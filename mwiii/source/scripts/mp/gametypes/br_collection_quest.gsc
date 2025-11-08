#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace br_collection_quest;

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0x2a6
// Size: 0xda
function init()
{
    enabled = registerquestcategory( "collection", 0 );
    
    if ( !enabled )
    {
        return;
    }
    
    level.scr_br_collection_findpath = getdvarint( @"scr_br_collection_findpath", 0 ) != 0;
    registerremovequestinstance( "collection", &col_removequestinstance );
    registerquestlocale( "collect_locale" );
    registerquestthink( "collect_locale", &col_localethink_itemspawn, 3 );
    registerquestthink( "collect_locale", &col_localethink_objectivevisibility, 0.2 );
    registerremovequestinstance( "collect_locale", &col_removelocaleinstance );
    registercreatequestlocale( "collect_locale", &col_createquestlocale );
    registercheckiflocaleisavailable( "collect_locale", &col_checkiflocaleisavailable );
    registerquestcircletick( "collect_locale", &col_circletick );
    getquestdata( "collect_locale" ).nextid = 0;
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0x388
// Size: 0xb3
function col_removequestinstance()
{
    locale = getquestinstancedata( "collect_locale", self.team );
    locale hideuielements( self );
    uiobjectivehidefromteam( self.team );
    
    foreach ( player in getteamdata( self.team, "players" ) )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( locale.objectiveiconid, player );
    }
    
    releaseteamonquest( self.team );
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 1
// Checksum 0x0, Offset: 0x443
// Size: 0x23d
function takequestitem( pickupent )
{
    uiobjectiveshowtoteam( "collection", self.team );
    instance = createquestinstance( "collection", self.team, pickupent.index, pickupent );
    instance.team = self.team;
    instance.startlocation = checkpoint( self.origin );
    instance registerteamonquest( self.team, self );
    search_params = spawnstruct();
    search_params.searchfunc = "questPointsArray";
    search_params.searchcircleorigin = instance.startlocation;
    search_params.searchradiusmax = 10000;
    search_params.searchradiusmin = 0;
    search_params.searchradiusidealmax = 6000;
    search_params.searchradiusidealmin = 4000;
    search_params.mintime = 30;
    search_params.initialplayer = self;
    search_params.questtypes = 7;
    locale = instance requestquestlocale( "collect_locale", search_params );
    instance.totalcollecteditems = 0;
    
    foreach ( player in getteamdata( self.team, "players" ) )
    {
        player.collecteditems = 0;
    }
    
    locale updatelocaleplayerlist();
    locale updateusablestateall();
    locale showuielements( instance );
    addquestinstance( "collection", instance );
    startteamcontractchallenge( "collection", self, self.team );
    params = spawnstruct();
    params.excludedplayers = [];
    params.excludedplayers[ 0 ] = self;
    displayteamsplash( self.team, "br_scavenger_quest_start_team", params );
    displayplayersplash( self, "br_scavenger_quest_start_tablet_finder" );
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0x688
// Size: 0xd5
function updatelocaleplayerlist()
{
    var_b87d7e190bafbd80 = [];
    
    foreach ( instance in self.subscribedinstances )
    {
        team = instance.team;
        
        foreach ( player in getteamdata( team, "players" ) )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            var_b87d7e190bafbd80[ var_b87d7e190bafbd80.size ] = player;
        }
    }
    
    self.playerlist = var_b87d7e190bafbd80;
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0x765
// Size: 0x56
function updateusablestateall()
{
    foreach ( item in self.itemlist )
    {
        updateusablestate( item );
    }
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 1
// Checksum 0x0, Offset: 0x7c3
// Size: 0x85
function updateusablestate( item )
{
    foreach ( player in level.players )
    {
        if ( array_contains( self.playerlist, player ) )
        {
            item enableplayeruse( player );
            item showtoplayer( player );
            continue;
        }
        
        item disableplayeruse( player );
    }
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 1
// Checksum 0x0, Offset: 0x850
// Size: 0x75
function showuielements( instance )
{
    foreach ( player in getteamdata( instance.team, "players" ) )
    {
        function_cfd53c8f6878014f( player );
        updatecollectionuiforplayer( instance, player );
    }
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 1
// Checksum 0x0, Offset: 0x8cd
// Size: 0x6d
function updatecollectionui( instance )
{
    foreach ( player in getteamdata( instance.team, "players" ) )
    {
        updatecollectionuiforplayer( instance, player );
    }
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 2
// Checksum 0x0, Offset: 0x942
// Size: 0x35
function updatecollectionuiforplayer( instance, player )
{
    assert( isplayer( player ) );
    player uiobjectivesetparameter( instance.totalcollecteditems );
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0x97f
// Size: 0x91
function determineobjectiveiconvisibility()
{
    foreach ( player in self.playerlist )
    {
        if ( distance2d( player.origin, self.curorigin ) > 0 )
        {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( self.objectiveiconid, player );
            continue;
        }
        
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( self.objectiveiconid, player );
    }
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 1
// Checksum 0x0, Offset: 0xa18
// Size: 0x74
function hideuielements( instance )
{
    foreach ( player in getteamdata( instance.team, "players" ) )
    {
        function_d7d113d56ef0ef5b( player );
        player uiobjectivehide();
    }
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0xa94
// Size: 0xe8
function findpoint()
{
    point = self.curorigin + math::random_vector_2d() * randomintrange( 0, 2900 );
    point = checkpoint( point );
    point += ( 0, 0, 10 );
    
    foreach ( item in self.itemlist )
    {
        if ( distance( item.origin, point ) < 100 )
        {
            return undefined;
        }
    }
    
    if ( level.scr_br_collection_findpath )
    {
        path = self.playerlist[ 0 ] findpath( self.curorigin, point, 0, 0 );
        
        if ( isdefined( path ) )
        {
            return point;
        }
        else
        {
            return undefined;
        }
        
        return;
    }
    
    return point;
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0xb84
// Size: 0x83
function forcespawnitem()
{
    if ( isdefined( self.previouspoints ) && self.previouspoints.size > 0 )
    {
        point = self.previouspoints[ 0 ];
        self.previouspoints = array_remove( self.previouspoints, self.previouspoints[ 0 ] );
        return;
    }
    
    for ( index = 0; index < 30 ; index++ )
    {
        point = findpoint();
        
        if ( !isdefined( point ) )
        {
            return point;
        }
    }
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 1
// Checksum 0x0, Offset: 0xc0f
// Size: 0xb1
function spawnitem( point )
{
    self.numitems++;
    stashlocation = spawn( "script_model", point );
    stashlocation setmodel( "box_wooden_grenade_01" );
    stashlocation makeusable();
    stashlocation setcursorhint( "HINT_NOICON" );
    stashlocation setuseholdduration( "duration_short" );
    stashlocation sethintdisplayfov( 150 );
    stashlocation setusefov( 150 );
    stashlocation setuserange( 150 );
    stashlocation sethintstring( &"MP/SCAV_PICKUP_PROMPT" );
    stashlocation setasgametypeobjective();
    stashlocation.locale = self;
    stashlocation thread stashthink();
    self.itemlist[ self.itemlist.size ] = stashlocation;
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0xcc8
// Size: 0x35
function stashthink()
{
    self endon( "death" );
    self endon( "remove_locale" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        thread usestash( player );
    }
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 1
// Checksum 0x0, Offset: 0xd05
// Size: 0x130
function usestash( player )
{
    locale = self.locale;
    instance = getquestinstancedata( "collection", player.team );
    
    if ( isdefined( instance ) )
    {
        self hide();
        self makeunusable();
        self.origin += ( 0, 0, -500 );
        self delete();
        player.collecteditems++;
        instance.totalcollecteditems++;
        locale updatecollectionui( instance );
        locale.numitems -= 1;
        
        if ( !isdefined( locale.previouspoints ) )
        {
            locale.previouspoints = [];
        }
        
        locale.previouspoints = array_add( locale.previouspoints, self.origin );
        locale.itemlist = array_remove( locale.itemlist, self );
        
        if ( instance.totalcollecteditems >= 10 )
        {
            instance thread completecollectionquest( self );
        }
    }
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 1
// Checksum 0x0, Offset: 0xe3d
// Size: 0xfb
function completecollectionquest( stash )
{
    rewardtier = getquestrewardtier( self.team );
    reward = getquestplunderreward( "collection", rewardtier );
    params = spawnstruct();
    missionid = getquestindex( "collection" );
    params.packedbits = packsplashparambits( missionid, rewardtier );
    displayteamsplash( self.id, "br_scavenger_quest_complete", params );
    giveteamplunderflat( self.team, reward );
    self.rewardorigin = stash.origin;
    self.rewardangles = stash.angles;
    self.result = "success";
    removequestinstance();
    
    if ( isdefined( level.var_52781be0b4e8a959 ) )
    {
        level [[ level.var_52781be0b4e8a959 ]]( self.team );
    }
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0xf40
// Size: 0x2c
function failcollectionquest()
{
    displayteamsplash( self.id, "br_scavenger_quest_circle_failure" );
    self.result = "fail";
    removequestinstance();
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0xf74
// Size: 0x1a
function col_checkiflocaleisavailable()
{
    if ( self.subscribedinstances.size < 4 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 1
// Checksum 0x0, Offset: 0xf96
// Size: 0xb5
function col_createquestlocale( placement )
{
    getquestdata( "collect_locale" ).nextid++;
    locale = createlocaleinstance( "collect_locale", "collection", "ColLoc:" + getquestdata( "collect_locale" ).nextid );
    locale.curorigin = placement.origin;
    locale col_createcircleobjectiveicon();
    locale.itemlist = [];
    locale function_6b6b6273f8180522( "Collection_Br", locale.curorigin, 2000 );
    locale function_4eaf685bc40a3b9();
    addquestinstance( "collect_locale", locale );
    return locale;
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0x1054
// Size: 0xa7
function col_createcircleobjectiveicon()
{
    self.objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( self.objectiveiconid != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( self.objectiveiconid, "current", ( 0, 0, 0 ), "ui_mp_br_mapmenu_icon_scavengerhunt_tablet" );
        scripts\mp\objidpoolmanager::update_objective_position( self.objectiveiconid, self.curorigin );
        scripts\mp\objidpoolmanager::update_objective_setbackground( self.objectiveiconid, 2 );
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall( self.objectiveiconid );
        scripts\mp\objidpoolmanager::objective_set_play_intro( self.objectiveiconid, 1 );
        return;
    }
    
    println( "<dev string:x1c>" );
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0x1103
// Size: 0x8e
function col_localethink_itemspawn()
{
    if ( !isdefined( self.numitems ) )
    {
        self.numitems = 0;
        self.nextitem = 0;
    }
    
    if ( self.nextitem % 3 == 0 || self.numitems < 5 )
    {
        if ( self.numitems < 15 )
        {
            if ( isdefined( self.nextpoint ) )
            {
                spawnitem( self.nextpoint );
                self.nextpoint = undefined;
            }
            else
            {
                forcespawnitem();
            }
        }
    }
    
    self.nextitem++;
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0x1199
// Size: 0x25
function col_localethink_objectivevisibility()
{
    determineobjectiveiconvisibility();
    
    if ( !isdefined( self.nextpoint ) )
    {
        self.nextpoint = findpoint();
    }
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 0
// Checksum 0x0, Offset: 0x11c6
// Size: 0xbb
function col_removelocaleinstance()
{
    function_af5604ce591768e1();
    self.playerlist = undefined;
    self.subscribedinstances = undefined;
    
    foreach ( item in self.itemlist )
    {
        item notify( "remove_locale" );
        item hide();
        item makeunusable();
        item.origin += ( 0, 0, -500 );
        item delete();
    }
    
    scripts\mp\objidpoolmanager::returnobjectiveid( self.objectiveiconid );
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 2
// Checksum 0x0, Offset: 0x1289
// Size: 0xd2
function col_circletick( dangercircleorigin, dangercircleradius )
{
    if ( !isdefined( self.lastcircletick ) )
    {
        self.lastcircletick = -1;
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
        foreach ( instanceid in self.subscribedinstances )
        {
            getquestinstancedata( "collection", instanceid ) failcollectionquest();
        }
    }
}

// Namespace br_collection_quest / scripts\mp\gametypes\br_collection_quest
// Params 1
// Checksum 0x0, Offset: 0x1363
// Size: 0x1c
function checkpoint( point )
{
    if ( isnavmeshloaded() )
    {
        point = getclosestpointonnavmesh( point );
    }
    
    return point;
}

