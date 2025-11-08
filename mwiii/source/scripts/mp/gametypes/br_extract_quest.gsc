#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_extract_quest;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace br_extract_quest;

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 0
// Checksum 0x0, Offset: 0x5b4
// Size: 0x2b9
function init()
{
    enabled = registerquestcategory( "blueprintextract", 1 );
    
    if ( !enabled )
    {
        return;
    }
    
    registertabletinit( "blueprintextract", &extracttablet_init );
    registerremovequestinstance( "blueprintextract", &extractquest_removequestinstance );
    registerquestlocale( "blueprintextract_locale" );
    registercreatequestlocale( "blueprintextract_locale", &extractlocale_createquestlocale );
    registercheckiflocaleisavailable( "blueprintextract_locale", &extractlocale_checkiflocaleisavailable );
    registerremovequestinstance( "blueprintextract_locale", &extractlocale_removelocaleinstance );
    registerquestcircletick( "blueprintextract_locale", &extractlocale_circletick );
    registeronentergulag( "blueprintextract_locale", &extractlocale_onentergulag );
    registeronrespawn( "blueprintextract_locale", &extractlocale_onrespawn );
    getquestdata( "blueprintextract_locale" ).nextid = 0;
    questtimerinit( "blueprintextract", 1 );
    registerontimerexpired( "blueprintextract", &extract_ontimerexpired );
    
    if ( !istrue( level.br_plunder_enabled ) )
    {
        scripts\mp\gametypes\br_plunder::initheliextractanims();
        scripts\mp\gametypes\br_plunder::inithelipropanims();
        level._effect[ "vfx_extract_smoke" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_adv_supply_drop_marker" );
        scripts\mp\gametypes\br_plunder::plunder_initrepositories();
        scripts\mp\gametypes\br_plunder::inithelirepository();
    }
    
    if ( !scripts\mp\gametypes\br_plunder::isplunderextractionenabled() )
    {
        scripts\engine\scriptable::scriptable_addusedcallback( &scripts\mp\gametypes\br_plunder::plundersiteused );
    }
    
    brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();
    inplunder = brgametype == "plunder" || brgametype == "risk";
    level.extractmissionhelipadscriptable = ter_op( inplunder, "brloot_quest_extract_site_plunder", "brloot_quest_extract_site_br" );
    level.extractmissionhelipadmodel = ter_op( inplunder, "brloot_quest_extract_site_model_plunder", "brloot_quest_extract_site_model_br" );
    level.plunderrepositories.data[ "extractHelipadPlunder" ].prevcallback = level.plunderrepositories.data[ "extractHelipadPlunder" ].usecallback;
    level.plunderrepositories.data[ "extractHelipadPlunder" ].usecallback = &extracthelipadusecallback;
    level.plunderrepositories.data[ "extractHelipadBR" ].prevcallback = level.plunderrepositories.data[ "extractHelipadBR" ].usecallback;
    level.plunderrepositories.data[ "extractHelipadBR" ].usecallback = &extracthelipadusecallback;
    assert( isdefined( game[ "<dev string:x1c>" ] ) );
    game[ "dialog" ][ "mission_extract_accept" ] = "bm_exfil_arrived";
    game[ "dialog" ][ "mission_extract_success" ] = "contract_misc_success";
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 3
// Checksum 0x0, Offset: 0x875
// Size: 0x9f
function extracthelipadusecallback( entity, player, amount )
{
    player.lastplunderbankindex = entity.index;
    player notify( "heliDeposit" );
    brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();
    
    if ( amount > 0 && istrue( level.br_plunder_enabled ) && ( brgametype == "plunder" || brgametype == "risk" ) )
    {
        [[ level.plunderrepositories.data[ "extractHelipadPlunder" ].prevcallback ]]( entity, player, amount );
    }
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 0
// Checksum 0x0, Offset: 0x91c
// Size: 0x63
function extractquest_removequestinstance()
{
    /#
        function_d2caa40694d469ab();
    #/
    
    releaseteamonquest( self.team );
    uiobjectivehidefromteam( self.team );
    extractupdatehud( 0, undefined );
    
    if ( isdefined( self.carryingplayer ) )
    {
        self.carryingplayer unsetweaponcarry();
    }
    
    self.subscribedlocale thread extractupdateiconsframeend();
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 0
// Checksum 0x0, Offset: 0x987
// Size: 0x79
function extractlocale_removelocaleinstance()
{
    /#
        function_8b0829a8ce24f0aa();
    #/
    
    foreach ( instance in self.subscribedinstances )
    {
        instance thread removequestinstance();
    }
    
    deletequestobjicon();
    self.helipadscriptable thread removeextracthelipad();
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 0
// Checksum 0x0, Offset: 0xa08
// Size: 0x48, Type: bool
function extracttablet_init()
{
    /#
        function_edc6b2561f8041e0();
    #/
    
    search_params = getsearchparams( self );
    placement = findquestplacement( "blueprintextract", search_params );
    
    if ( !isdefined( placement ) )
    {
        return false;
    }
    
    self.reservedplacement = placement;
    return true;
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0xa59
// Size: 0x272
function extractlocale_createquestlocale( placement )
{
    /#
        function_d2caa40694d469ab();
    #/
    
    getquestdata( "blueprintextract_locale" ).nextid++;
    locale = createlocaleinstance( "blueprintextract_locale", "blueprintextract", "ExtractPoint:" + getquestdata( "blueprintextract_locale" ).nextid );
    
    if ( !isdefined( placement ) )
    {
        locale.curorigin = ( 0, 0, 0 );
        locale.enabled = 0;
        return locale;
    }
    
    locale.playerlist = getteamdata( self.team, "players" );
    locale.helipad = spawn( "script_model", placement.origin );
    locale.helipad setmodel( level.extractmissionhelipadmodel );
    assertex( isdefined( locale.playerlist ) || locale.playerlist.size > 0, "<dev string:x26>" );
    var_7f599accb72658d1 = locale.playerlist[ 0 ];
    locale.helipad setotherent( var_7f599accb72658d1 );
    locale.helipad setscriptablepartstate( level.extractmissionhelipadscriptable, "activeCurrent" );
    locale.helipad.forceextractscriptable = 1;
    locale.helipadscriptable = locale.helipad getlinkedscriptableinstance();
    locale.helipadscriptable.activestate = "active";
    locale.helipadscriptable.activecurrstate = "activeCurrent";
    locale.helipadscriptable.disabledstate = "hidden";
    locale.helipadscriptable.disabledcurrstate = "hidden";
    locale.helipadscriptable.questcomplete = 0;
    locale.locationpad = placement;
    locale createquestobjicon( "ui_mp_br_mapmenu_icon_extraction_objective", "current", placement.origin );
    locale.lastcircletick = -1;
    locale.curorigin = placement.origin;
    addquestinstance( "blueprintextract_locale", locale );
    return locale;
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0xcd4
// Size: 0x52, Type: bool
function extractlocale_islocaleavailable( position )
{
    faketablet = spawnstruct();
    faketablet.origin = position;
    search_params = scripts\mp\gametypes\br_extract_quest::getsearchparams( faketablet );
    placement = scripts\mp\gametypes\br_quest_util::findquestplacement( "blueprintextract", search_params );
    return isdefined( placement );
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 0
// Checksum 0x0, Offset: 0xd2f
// Size: 0x62
function removeextracthelipad()
{
    brgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();
    
    if ( brgametype != "plunder" && brgametype != "risk" )
    {
        self setscriptablepartstate( level.extractmissionhelipadscriptable, "hidden" );
    }
    
    if ( isdefined( self.heli ) )
    {
        self waittill( "heli_left" );
    }
    
    self.entity delete();
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0xd99
// Size: 0x15
function extractlocale_checkiflocaleisavailable( search_params )
{
    /#
        function_8b0829a8ce24f0aa();
    #/
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 2
// Checksum 0x0, Offset: 0xdb6
// Size: 0x109
function extractlocale_circletick( dangercircleorigin, dangercircleradius )
{
    /#
        function_8b0829a8ce24f0aa();
    #/
    
    if ( !isdefined( self.helipad ) )
    {
        return;
    }
    
    currenttime = gettime();
    
    if ( self.lastcircletick == currenttime )
    {
        return;
    }
    
    self.lastcircletick = currenttime;
    dist = distance2d( self.curorigin, dangercircleorigin );
    
    if ( dist > dangercircleradius )
    {
        foreach ( instance in self.subscribedinstances )
        {
            displayteamsplash( instance.team, "br_blueprint_extract_quest_circle_failure" );
            level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "mission_obj_circle_fail", instance.team, 1 );
            instance.result = "circle";
        }
        
        removequestinstance();
    }
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0xec7
// Size: 0x1d
function extractlocale_onentergulag( player )
{
    /#
        function_8b0829a8ce24f0aa();
    #/
    
    extracthideiconfromplayer( player );
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0xeec
// Size: 0x41
function extractlocale_onrespawn( player )
{
    /#
        function_8b0829a8ce24f0aa();
    #/
    
    if ( player.team == self.subscribedinstances[ 0 ].team )
    {
        extractshowicontoplayer( player );
    }
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 0
// Checksum 0x0, Offset: 0xf35
// Size: 0xe7
function extractupdateicons()
{
    /#
        function_8b0829a8ce24f0aa();
    #/
    
    objective_showtoplayersinmask( self.objectiveiconid );
    objective_removeallfrommask( self.objectiveiconid );
    
    foreach ( instance in self.subscribedinstances )
    {
        foreach ( player in getteamdata( instance.team, "players" ) )
        {
            if ( !player scripts\mp\gametypes\br_public::isplayeringulag() )
            {
                objective_addclienttomask( self.objectiveiconid, player );
            }
        }
    }
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0x1024
// Size: 0x25
function extracthideiconfromplayer( player )
{
    /#
        function_8b0829a8ce24f0aa();
    #/
    
    objective_removeclientfrommask( self.objectiveiconid, player );
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0x1051
// Size: 0x25
function extractshowicontoplayer( player )
{
    /#
        function_8b0829a8ce24f0aa();
    #/
    
    objective_addclienttomask( self.objectiveiconid, player );
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 0
// Checksum 0x0, Offset: 0x107e
// Size: 0x1b
function extractupdateiconsframeend()
{
    /#
        function_8b0829a8ce24f0aa();
    #/
    
    self endon( "removed" );
    waittillframeend();
    extractupdateicons();
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 2
// Checksum 0x0, Offset: 0x10a1
// Size: 0xe0
function extractupdatehud( var_c8029619477a0d4b, carryingplayer )
{
    carryingplayernum = 0;
    lootid = -1;
    
    if ( var_c8029619477a0d4b )
    {
        carryingplayernum = carryingplayer getentitynumber();
        lootid = self.extractunlockablelootid;
    }
    
    foreach ( player in getteamdata( self.team, "players" ) )
    {
        player uiobjectivesetparameter( carryingplayernum );
        player uiobjectivesetlootid( lootid );
        iscarryingplayer = isdefined( carryingplayer ) && player == carryingplayer;
        showhudicon = var_c8029619477a0d4b && iscarryingplayer;
        player setclientomnvar( "ui_br_has_extract_bag", showhudicon );
    }
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0x1189
// Size: 0x398
function takequestitem( pickupent )
{
    /#
        function_fe3b51cfbf0f97c5();
    #/
    
    quests = scripts\mp\gametypes\br_quest_util::getallactivequestsforteam( self.team );
    
    if ( isdefined( quests ) && quests.size > 0 )
    {
        foreach ( quest in quests )
        {
            quest.instance scripts\mp\gametypes\br_quest_util::removequestinstance();
        }
    }
    
    instance = createquestinstance( "blueprintextract", self.team, pickupent.index, pickupent );
    instance registerteamonquest( self.team, self );
    instance.team = self.team;
    instance.tablet = pickupent;
    instance.extractunlockablelootid = pickupent.extractunlockablelootid;
    questtime = getdvarint( @"hash_244206ce2e68a9d8", 240 );
    instance questtimerset( questtime, 4 );
    search_params = getsearchparams( pickupent );
    locale = instance requestquestlocale( "blueprintextract_locale", search_params, 1 );
    
    if ( !locale.enabled )
    {
        instance.result = "no_locale";
        instance releaseteamonquest( self.team );
        return;
    }
    
    locale extractupdateicons();
    uiobjectiveshowtoteam( "blueprintextract", self.team );
    addquestinstance( "blueprintextract", instance );
    startteamcontractchallenge( "blueprintextract", self, self.team );
    
    if ( !level.br_plunder_enabled )
    {
        foreach ( player in getteamdata( self.team, "players" ) )
        {
            player.plundercount = 0;
        }
    }
    
    params = spawnstruct();
    params.excludedplayers = [];
    params.excludedplayers[ 0 ] = self;
    params.plundervar = getquestplunderreward( "blueprintextract", getquestrewardtier( self.team ) );
    displayteamsplash( self.team, "br_blueprint_extract_quest_start_team", params );
    displayplayersplash( self, "br_blueprint_extract_quest_start_tablet_finder", params );
    displaysquadmessagetoteam( instance.team, self, 6, getquestindex( "blueprintextract" ) );
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "mission_extract_accept", instance.team, 1 );
    setweaponcarry( locale, pickupent.extractunlockablelootid );
    instance.carryingplayer = self;
    
    foreach ( player in level.players )
    {
        if ( player != self )
        {
            locale.helipadscriptable disablescriptablepartplayeruse( level.extractmissionhelipadscriptable, player );
        }
    }
    
    instance extractupdatehud( 1, self );
    instance thread watchweapondeathordisconnect( self );
    instance thread watchfordeposit( self );
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 2
// Checksum 0x0, Offset: 0x1529
// Size: 0x54
function setweaponcarry( locale, unlockablelootid )
{
    self.extractquest_alwaysallowdeposit = 1;
    self.extractquest_helipadid = locale.helipadscriptable.index;
    self.extractquest_missionitem = "brloot_blueprintextract_tablet";
    self.extractquest_unlockablelootid = unlockablelootid;
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 0
// Checksum 0x0, Offset: 0x1585
// Size: 0x2a
function unsetweaponcarry()
{
    self.extractquest_alwaysallowdeposit = undefined;
    self.extractquest_helipadid = undefined;
    self.extractquest_missionitem = undefined;
    self.extractquest_unlockablelootid = undefined;
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0x15b7
// Size: 0x7a
function extract_removemissionweapon( quest )
{
    if ( self hasweapon( quest.weapon ) )
    {
        fists = makeweapon( "iw9_me_fists_mp" );
        switchto = scripts\cp_mp\utility\inventory_utility::iscurrentweapon( quest.weapon );
        scripts\cp_mp\utility\inventory_utility::_takeweapon( quest.weapon );
        scripts\cp_mp\utility\inventory_utility::_giveweapon( fists, undefined, undefined, 1 );
        
        if ( switchto )
        {
            scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate( fists );
        }
    }
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0x1639
// Size: 0x25, Type: bool
function extract_ismissionweapon( weapon )
{
    if ( !isdefined( self.extractquest_missionweapon ) )
    {
        return false;
    }
    
    return self.extractquest_missionweapon == weapon;
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0x1667
// Size: 0xfc
function watchweapondrop( player )
{
    self endon( "removed" );
    
    while ( true )
    {
        player waittill( "weapon_change" );
        
        if ( isdefined( player ) && !player hasweapon( self.weapon ) )
        {
            dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
            dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( dropstruct, player.origin, player.angles, player );
            tablet = scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_blueprintextract_tablet", dropinfo );
            tablet.reservedplacement = self.subscribedlocale.locationpad;
            level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "br_blueprint_extract_quest_failure", player.team, 1, 1 );
            displayteamsplash( player.team, "br_blueprint_extract_quest_failure" );
            player unsetweaponcarry();
            self.result = "fail";
            thread removequestinstance();
            return;
        }
    }
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0x176b
// Size: 0x7d
function watchweapondeathordisconnect( player )
{
    self endon( "removed" );
    team = player.team;
    
    while ( true )
    {
        player waittill( "death_or_disconnect" );
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "br_blueprint_extract_quest_failure", team, 1, 1 );
        displayteamsplash( team, "br_blueprint_extract_quest_failure" );
        
        if ( isdefined( player ) )
        {
            player unsetweaponcarry();
        }
        
        self.result = "fail";
        thread removequestinstance();
        return;
    }
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0x17f0
// Size: 0x1e6
function watchfordeposit( player )
{
    self endon( "removed" );
    
    while ( true )
    {
        player waittill( "heliDeposit" );
        
        if ( player.lastplunderbankindex == self.subscribedlocale.helipadscriptable.index )
        {
            unlockref = "blueprint_unlock_" + self.extractunlockablelootid;
            optionalnumber = getquestunlockableindexfromlootid( self.extractunlockablelootid );
            
            foreach ( teammate in getteamdata( self.team, "players" ) )
            {
                teammate scripts\cp_mp\challenges::onunlockitem( unlockref );
                
                if ( optionalnumber > 0 )
                {
                    teammate thread scripts\mp\hud_message::showsplash( "br_unlockable_weapon_splash", optionalnumber );
                }
            }
            
            self.subscribedlocale.helipadscriptable.questcomplete = 1;
            displaysquadmessagetoteam( self.team, player, 8, getquestindex( "blueprintextract" ) );
            displaydelayedmissioncompletesplash( player );
            missionid = getquestindex( "blueprintextract" );
            displaysquadmessagetoteam( self.team, player, 8, missionid );
            level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "mission_extract_success", self.team, 1, 1 );
            self.rewardorigin = self.subscribedlocale.helipad.origin;
            self.rewardangles = self.subscribedlocale.helipad.angles;
            self.result = "success";
            thread removequestinstance();
            return;
        }
    }
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0x19de
// Size: 0xbf
function displaydelayedmissioncompletesplash( player )
{
    level endon( "game_ended" );
    team = self.team;
    params = spawnstruct();
    rewardtier = getquestrewardtier( player.team );
    missionid = getquestindex( "blueprintextract" );
    rewardindex = getquestrewardgroupindex( getquestrewardbuildgroupref( "blueprintextract" ) );
    unlockableindex = getquestunlockableindexfromlootid( self.extractunlockablelootid );
    params.packedbits = packsplashparambits( missionid, rewardtier, rewardindex, unlockableindex );
    waitframe();
    displayteamsplash( team, "br_blueprint_extract_quest_complete", params );
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 1
// Checksum 0x0, Offset: 0x1aa5
// Size: 0xd2
function getsearchparams( tablet )
{
    search_params = spawnstruct();
    search_params.searchfunc = "getInactiveHelipads";
    search_params.searchcircleorigin = ( tablet.origin[ 0 ], tablet.origin[ 1 ], 0 );
    search_params.searchradiusmax = 30000;
    search_params.searchradiusmin = 0;
    search_params.searchradiusidealmax = getdvarint( @"hash_3f4a769b64c24a7d", 20000 );
    search_params.searchradiusidealmin = getdvarint( @"hash_51284059de901d6f", 15000 );
    search_params.searchforcecirclecenter = 1;
    search_params.reservedplacement = tablet.reservedplacement;
    return search_params;
}

// Namespace br_extract_quest / scripts\mp\gametypes\br_extract_quest
// Params 0
// Checksum 0x0, Offset: 0x1b80
// Size: 0x30
function extract_ontimerexpired()
{
    displayteamsplash( self.team, "br_blueprint_extract_quest_timer_expired" );
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "mission_gen_fail", self.team, 1 );
}

