#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\hud_util;
#using scripts\mp\laststand;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace namespace_ef7dd1046a7b0ee;

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 0
// Checksum 0x0, Offset: 0x410
// Size: 0x15b
function init()
{
    enabled = registerquestcategory( "vip", 1 );
    
    if ( !enabled )
    {
        return;
    }
    
    registerremovequestinstance( "vip", &vip_removequestinstance );
    registeronplayerkilled( "vip", &vip_playerdied );
    registeronplayerdisconnect( "vip", &vip_playerdisconnect );
    registeronentergulag( "vip", &vip_onentergulag );
    registeronrespawn( "vip", &vip_onrespawn );
    registerquestthink( "vip", &vip_questthink_iconposition, 2 );
    
    /#
        function_8f449f8c11c8ea84( "<dev string:x1c>", "<dev string:x23>", [ 5, 30, 60, 120, 180, 240, 300 ], 180 );
    #/
    
    game[ "dialog" ][ "hvt_accept" ] = "contract_hvt_accept";
    game[ "dialog" ][ "mission_hvt_accept_first_person" ] = "mission_mission_hvt_accept_first_person";
    game[ "dialog" ][ "mission_hvt_success_third_person" ] = "mission_mission_hvt_success_third_person";
    game[ "dialog" ][ "mission_hvt_success_first_person" ] = "mission_mission_hvt_success_first_person";
    game[ "dialog" ][ "mission_hvt_failure" ] = "mission_mission_hvt_failure";
    game[ "dialog" ][ "mission_hvt_eliminated" ] = "mission_mission_hvt_eliminated";
    questtimerinit( "vip", 1 );
    registerontimerexpired( "vip", &vip_ontimerexpired );
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 1
// Checksum 0x0, Offset: 0x573
// Size: 0x23a
function takequestitem( pickupent )
{
    /#
        function_fe3b51cfbf0f97c5();
    #/
    
    instance = createquestinstance( "vip", self.team, pickupent.index, pickupent );
    instance registerteamonquest( self.team, self );
    giveteampoints( self.team, #"hash_67eb4b642067882a" );
    instance.team = self.team;
    instance.vip = self;
    instance.vip scripts\mp\gametypes\br_public::setplayermostwantedextrainfo( 1 );
    instance createquestobjicon( "ui_mp_br_mapmenu_icon_assassin_objective_enemy", "active", self.origin + ( 0, 0, 100 ) );
    instance viphud_setupvisibility();
    instance questtimerset( getdvarint( @"hash_7f10f216178d1d16", 180 ), 4 );
    addquestinstance( "vip", instance );
    startteamcontractchallenge( "vip", self, self.team );
    params = spawnstruct();
    params.excludedplayers = [];
    params.excludedplayers[ 0 ] = instance.vip;
    params.excludedteams = [];
    params.excludedteams[ 0 ] = instance.team;
    params.plundervar = getquestplunderreward( "vip", getquestrewardtier( self.team ) );
    displayteamsplash( instance.team, "br_vip_quest_start_vip_team", params );
    displayplayersplash( instance.vip, "br_vip_quest_start_tablet_finder", params );
    displaysplashtoplayersinradius( "br_vip_quest_vip_spawn_alert", self.origin, 5000, level.questinfo.defaultfilter, params );
    level thread scripts\mp\gametypes\br_public::brleaderdialogteamexcludeplayer( "hvt_accept", instance.team, instance.vip, 1, undefined, 0.5 );
    level thread scripts\mp\gametypes\br_public::brleaderdialogplayer( "mission_hvt_accept_first_person", instance.vip, 1, undefined, 0.5 );
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 0
// Checksum 0x0, Offset: 0x7b5
// Size: 0x130
function viphud_setupvisibility()
{
    objective_addalltomask( self.objectiveiconid );
    allplayers = sortvalidplayersinarray( level.players );
    
    foreach ( player in allplayers[ "valid" ] )
    {
        showquestobjicontoplayer( player );
    }
    
    foreach ( player in allplayers[ "invalid" ] )
    {
        hidequestobjiconfromplayer( player );
    }
    
    foreach ( player in getteamdata( self.team, "players" ) )
    {
        if ( !player scripts\mp\gametypes\br_public::isplayeringulag() )
        {
            viphud_showtoplayer( player );
        }
        
        hidequestobjiconfromplayer( player );
    }
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 2
// Checksum 0x0, Offset: 0x8ed
// Size: 0x3c
function vip_playerdied( attacker, victim )
{
    /#
        function_d2caa40694d469ab();
    #/
    
    if ( victim scripts\mp\gametypes\br_public::isplayeringulag() || attacker scripts\mp\gametypes\br_public::isplayeringulag() )
    {
        return;
    }
    
    vip_playerremoved( victim, attacker );
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 1
// Checksum 0x0, Offset: 0x931
// Size: 0x1d
function vip_playerdisconnect( player )
{
    /#
        function_d2caa40694d469ab();
    #/
    
    vip_playerremoved( player );
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 1
// Checksum 0x0, Offset: 0x956
// Size: 0x1d
function vip_onentergulag( player )
{
    /#
        function_d2caa40694d469ab();
    #/
    
    viphud_hidefromplayer( player );
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 1
// Checksum 0x0, Offset: 0x97b
// Size: 0x3d
function vip_onrespawn( player )
{
    /#
        function_d2caa40694d469ab();
    #/
    
    if ( player.team == self.team )
    {
        viphud_showtoplayer( player );
    }
    
    showquestobjicontoplayer( player );
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 2
// Checksum 0x0, Offset: 0x9c0
// Size: 0x61
function vip_playerremoved( removedplayer, attacker )
{
    /#
        function_d2caa40694d469ab();
    #/
    
    if ( removedplayer.team == self.team )
    {
        if ( removedplayer == self.vip )
        {
            vip_failquest( attacker );
        }
        else
        {
            viphud_hidefromplayer( removedplayer );
        }
        
        return;
    }
    
    hidequestobjiconfromplayer( removedplayer );
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 0
// Checksum 0x0, Offset: 0xa29
// Size: 0x13
function vip_ontimerexpired()
{
    /#
        function_d2caa40694d469ab();
    #/
    
    vip_completequest();
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 0
// Checksum 0x0, Offset: 0xa44
// Size: 0x35
function vip_removequestinstance()
{
    /#
        function_d2caa40694d469ab();
    #/
    
    level notify( "calloutmarkerping_warzoneKillQuestIconGlobal_" + self.objectiveiconid );
    releaseteamonquest( self.team );
    viphud_deletehud();
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 1
// Checksum 0x0, Offset: 0xa81
// Size: 0x40
function viphud_showtoplayer( player )
{
    /#
        function_d2caa40694d469ab();
    #/
    
    player uiobjectiveshow( "vip" );
    player uiobjectivesetparameter( self.vip getentitynumber() );
    showquestobjicontoplayer( player );
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 1
// Checksum 0x0, Offset: 0xac9
// Size: 0x25
function viphud_hidefromplayer( player )
{
    /#
        function_d2caa40694d469ab();
    #/
    
    player uiobjectivehide();
    hidequestobjiconfromplayer( player );
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 0
// Checksum 0x0, Offset: 0xaf6
// Size: 0x72
function viphud_deletehud()
{
    /#
        function_d2caa40694d469ab();
    #/
    
    foreach ( player in getteamdata( self.team, "players" ) )
    {
        viphud_hidefromplayer( player );
    }
    
    deletequestobjicon();
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 3
// Checksum 0x0, Offset: 0xb70
// Size: 0x74
function vip_respawnplayer( player, sponsor, var_df2fbb13c226be75 )
{
    if ( istrue( player.inlaststand ) )
    {
        player scripts\mp\laststand::finishreviveplayer( "use_hold_revive_success", player );
    }
    
    if ( !isalive( player ) && !player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() )
    {
        player thread scripts\mp\gametypes\br_gulag::playergulagautowin( "vipRespawn", sponsor );
        return;
    }
    
    if ( player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() )
    {
        player thread scripts\mp\gametypes\br_gulag::playerpulloutofgulagwin( sponsor, var_df2fbb13c226be75 );
    }
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 0
// Checksum 0x0, Offset: 0xbec
// Size: 0x1ad
function vip_completequest()
{
    /#
        function_d2caa40694d469ab();
    #/
    
    params = spawnstruct();
    rewardtier = getquestrewardtier( self.team );
    missionid = getquestindex( "vip" );
    rewardindex = getquestrewardgroupindex( getquestrewardbuildgroupref( "vip" ) );
    params.packedbits = packsplashparambits( missionid, rewardtier, rewardindex );
    displayteamsplash( self.team, "br_vip_quest_complete", params );
    level thread scripts\mp\gametypes\br_public::brleaderdialogteamexcludeplayer( "mission_hvt_success_third_person", self.team, self.vip, 1, undefined, 0.5 );
    level thread scripts\mp\gametypes\br_public::brleaderdialogplayer( "mission_hvt_success_first_person", self.vip, 1, undefined, 0.5 );
    self.vip scripts\mp\gametypes\br_public::setplayermostwantedextrainfo( 0 );
    
    foreach ( player in getteamdata( self.team, "players" ) )
    {
        vip_respawnplayer( player, self.vip, "vip" );
    }
    
    self.rewardmodifier = undefined;
    self.rewardorigin = self.vip.origin;
    self.rewardangles = self.vip.angles;
    self.result = "success";
    thread removequestinstance();
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 1
// Checksum 0x0, Offset: 0xda1
// Size: 0x1bc
function vip_failquest( attacker )
{
    /#
        function_d2caa40694d469ab();
    #/
    
    if ( isdefined( attacker ) && isplayer( attacker ) && attacker.team != self.team )
    {
        params = spawnstruct();
        rewardtier = getquestrewardtier( attacker.team );
        missionid = getquestindex( "vip" );
        self.rewardmodifier = "_killer";
        rewardindex = getquestrewardgroupindex( getquestrewardbuildgroupref( "vip", self.rewardmodifier, self.modifier ) );
        params.packedbits = packsplashparambits( missionid, rewardtier, rewardindex );
        displayteamsplash( attacker.team, "br_vip_quest_you_killed_the_vip", params );
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "mission_hvt_eliminated", attacker.team, 1, 1 );
        givequestrewardsinstance( attacker.team, self.vip.origin, self.vip.angles, self.rewardscriptable );
        self.vip scripts\mp\gametypes\br_public::setplayermostwantedextrainfo( 0 );
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "mission_hvt_failure", self.team, 1, 1 );
        self.rewardmodifier = undefined;
        self.result = "fail";
    }
    
    displayteamsplash( self.team, "br_vip_quest_failure" );
    self.rewardmodifier = undefined;
    self.result = "fail";
    removequestinstance();
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 0
// Checksum 0x0, Offset: 0xf65
// Size: 0x34
function vip_questthink_iconposition()
{
    /#
        function_d2caa40694d469ab();
    #/
    
    movequestobjicon( self.vip.origin + ( 0, 0, 100 ) );
}

// Namespace namespace_ef7dd1046a7b0ee / namespace_5a4a9f3e4a0baf2f
// Params 0
// Checksum 0x0, Offset: 0xfa1
// Size: 0x80, Type: bool
function function_5f352fb76c54705c()
{
    quests = getquestdata( "vip" );
    
    if ( !isdefined( quests ) )
    {
        return false;
    }
    
    foreach ( instance in quests.instances )
    {
        if ( instance.vip == self )
        {
            return true;
        }
    }
    
    return false;
}

