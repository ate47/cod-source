#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_common;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\analyticslog;
#using scripts\mp\bots\bots_util;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_extract_chopper;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\gametypes\sd;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\usability;

#namespace vip;

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0xb47
// Size: 0x1bf
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    allowed[ 0 ] = getgametype();
    allowed[ 1 ] = "sd";
    allowed[ 2 ] = "bombzone";
    allowed[ 3 ] = "dom";
    scripts\mp\gameobjects::main( allowed );
    
    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = &initializematchrules;
        [[ level.initializematchrules ]]();
        level thread reinitializematchrulesonmigration();
    }
    else
    {
        registerroundswitchdvar( getgametype(), 1, 0, 3 );
        registertimelimitdvar( getgametype(), 300 );
        registerscorelimitdvar( getgametype(), 1 );
        registerroundlimitdvar( getgametype(), 0 );
        registerwinlimitdvar( getgametype(), 2 );
        registernumlivesdvar( getgametype(), 1 );
        registerhalftimedvar( getgametype(), 0 );
    }
    
    level.teambased = 1;
    level.objectivebased = 1;
    updategametypedvars();
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.onnormaldeath = &onnormaldeath;
    level.onplayerkilled = &onplayerkilled;
    level.ondeadevent = &ondeadevent;
    game[ "dialog" ][ "gametype" ] = "gametype_defender";
    game[ "dialog" ][ "offense_obj" ] = "hint_killall";
    game[ "dialog" ][ "defense_obj" ] = "hint_killall";
    level._effect[ "vfx_smk_signal" ] = loadfx( "vfx/_requests/mp_gameplay/vfx_smk_signal" );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0xd0e
// Size: 0x37
function initializematchrules()
{
    setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_dd7fdf98a94c3f97", 0 );
    registerhalftimedvar( getgametype(), 0 );
    setdynamicdvar( @"hash_274247f977c3cf99", 0 );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0xd4d
// Size: 0x9
function updategametypedvars()
{
    scripts\mp\gametypes\common::updatecommongametypedvars();
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0xd5e
// Size: 0x12b
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    setobjectivetext( "allies", &"OBJECTIVES/VIP" );
    setobjectivetext( "axis", &"OBJECTIVES/VIP" );
    
    if ( level.splitscreen )
    {
        setobjectivescoretext( "allies", &"OBJECTIVES/VIP" );
        setobjectivescoretext( "axis", &"OBJECTIVES/VIP" );
    }
    else
    {
        setobjectivescoretext( "allies", &"OBJECTIVES/VIP_SCORE" );
        setobjectivescoretext( "axis", &"OBJECTIVES/VIP_SCORE" );
    }
    
    setobjectivehinttext( "allies", &"OBJECTIVES/VIP_HINT" );
    setobjectivehinttext( "axis", &"OBJECTIVES/VIP_HINT" );
    initspawns();
    level.hostagestates = [];
    level.hostagecarrystates = [];
    seticonnames();
    thread waittoprocess();
    level thread votimeendingsoon();
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0xe91
// Size: 0x4b
function waittoprocess()
{
    level endon( "game_end" );
    level endon( "waitSkipped" );
    level thread extractionzone();
    level thread spawnvip();
    level thread createthreatbiasgroups();
    gameflagwait( "prematch_done" );
    gameflagwait( "graceperiod_done" );
    self notify( "graceComplete" );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0xee4
// Size: 0x79
function initspawns()
{
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2147483647, -2147483647, -2147483647 );
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_sd_spawn_attacker" );
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_sd_spawn_defender" );
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0xf65
// Size: 0x62
function getspawnpoint()
{
    spawnpointname = "mp_sd_spawn_defender";
    
    if ( self.pers[ "team" ] == game[ "attackers" ] )
    {
        spawnpointname = "mp_sd_spawn_attacker";
    }
    
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray( spawnpointname );
    assert( spawnpoints.size );
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn( spawnpoints );
    return spawnpoint;
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0xfd0
// Size: 0x80
function seticonnames()
{
    level.iconrecover = "waypoint_recover_vip";
    level.iconescort = "waypoint_escort_vip";
    level.iconextract = "waypoint_extract_vip";
    level.icontakingextract = "waypoint_taking_extract";
    level.iconlosingextract = "waypoint_losing_extract";
    level.iconcontestingextract = "waypoint_contesting_extract";
    level.icondefendextract = "waypoint_defend_extract";
    level.iconcaptureextract = "waypoint_capture_extract";
    level.iconstoppingextract = "waypoint_stopping_extract";
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 1
// Checksum 0x0, Offset: 0x1058
// Size: 0x72
function onspawnplayer( revivespawn )
{
    self.isvip = 0;
    self.usingobj = undefined;
    level notify( "spawned_player" );
    scripts\mp\hud_message::function_f004ef4606b9efdc( "hide_match_hint" );
    self setthreatbiasgroup( self.team );
    thread updatematchstatushintonspawn();
    
    if ( isdefined( level.vip ) )
    {
        level.vip.trigger enableplayeruse( self );
    }
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 6
// Checksum 0x0, Offset: 0x10d2
// Size: 0xaf
function onnormaldeath( victim, attacker, lifeid, smeansofdeath, objweapon, iskillstreakweapon )
{
    score = scripts\mp\rank::getscoreinfovalue( #"kill" );
    assert( isdefined( score ) );
    team = victim.team;
    
    if ( isdefined( victim.isvip ) && victim.isvip )
    {
        level thread vip_endgame( game[ "attackers" ], &"MP_ELIMINATED_VIP" );
        attacker.finalkill = 1;
    }
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 10
// Checksum 0x0, Offset: 0x1189
// Size: 0x5b
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    thread checkallowspectating();
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0x11ec
// Size: 0x93
function ontimelimit()
{
    if ( game[ "status" ] == "overtime" )
    {
        winner = "forfeit";
    }
    else if ( game[ "teamScores" ][ "allies" ] == game[ "teamScores" ][ "axis" ] )
    {
        winner = "overtime";
    }
    else if ( game[ "teamScores" ][ "axis" ] > game[ "teamScores" ][ "allies" ] )
    {
        winner = "axis";
    }
    else
    {
        winner = "allies";
    }
    
    thread scripts\mp\gamelogic::endgame( winner, game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0x1287
// Size: 0x89
function checkallowspectating()
{
    waitframe();
    update = 0;
    
    if ( !getteamdata( game[ "attackers" ], "aliveCount" ) )
    {
        level.spectateoverride[ game[ "attackers" ] ].allowenemyspectate = 1;
        update = 1;
    }
    
    if ( !getteamdata( game[ "defenders" ], "aliveCount" ) )
    {
        level.spectateoverride[ game[ "defenders" ] ].allowenemyspectate = 1;
        update = 1;
    }
    
    if ( update )
    {
        scripts\mp\spectating::updatespectatesettings();
    }
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 1
// Checksum 0x0, Offset: 0x1318
// Size: 0x7e
function ondeadevent( team )
{
    if ( team == game[ "attackers" ] )
    {
        level thread vip_endgame( game[ "defenders" ], game[ "end_reason" ][ tolower( game[ game[ "attackers" ] ] ) + "_eliminated" ] );
        return;
    }
    
    if ( team == game[ "defenders" ] )
    {
        level thread vip_endgame( game[ "attackers" ], game[ "end_reason" ][ tolower( game[ game[ "defenders" ] ] ) + "_eliminated" ] );
    }
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 2
// Checksum 0x0, Offset: 0x139e
// Size: 0x1d
function vip_endgame( winningteam, endreasontext )
{
    thread scripts\mp\gamelogic::endgame( winningteam, endreasontext );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0x13c3
// Size: 0x53a
function extractionzone()
{
    triggers = getentarray( "bombzone", "targetname" );
    triggers = scripts\mp\gametypes\sd::removebombzonec( triggers );
    level.objectives = [];
    var_c8a41ae10dd3b1d2 = game[ "attackers" ];
    
    foreach ( trigger in triggers )
    {
        visuals[ 0 ] = spawn( "script_model", trigger.origin );
        visuals[ 0 ].angles = ( 0, 270, 0 );
        visuals[ 0 ].team = var_c8a41ae10dd3b1d2;
        visuals[ 0 ].visibleteam = "any";
        visuals[ 0 ].ownerteam = var_c8a41ae10dd3b1d2;
        visuals[ 0 ].type = "";
        exfilgoaltrigger = spawn( "trigger_radius", trigger.origin, 0, 120, 80 );
        exfilgoaltrigger.team = var_c8a41ae10dd3b1d2;
        droppoint = exfilgoaltrigger.origin;
        contentoverride = scripts\engine\trace::create_contents( 0, 1, 1, 0, 0, 1, 1 );
        ignoreents = [];
        trace = scripts\engine\trace::ray_trace( visuals[ 0 ].origin + ( 0, 0, 20 ), visuals[ 0 ].origin - ( 0, 0, 4000 ), ignoreents, contentoverride, 0 );
        
        if ( isplayer( trace[ "entity" ] ) )
        {
            trace[ "entity" ] = undefined;
        }
        
        if ( isdefined( trace ) )
        {
            tempangle = randomfloat( 360 );
            droporigin = trace[ "position" ];
            
            if ( isdefined( self.visualgroundoffset ) )
            {
                droporigin += self.visualgroundoffset;
            }
            
            forward = ( cos( tempangle ), sin( tempangle ), 0 );
            forward = vectornormalize( forward - trace[ "normal" ] * vectordot( forward, trace[ "normal" ] ) );
            dropangles = vectortoangles( forward );
            visuals[ 0 ].origin = droporigin;
            visuals[ 0 ] setmodel( "cop_marker_scriptable" );
            visuals[ 0 ] setscriptablepartstate( "marker", "red" );
            visuals[ 0 ] playloopsound( "mp_flare_burn_lp" );
        }
        
        level.flagcapturetime = 0.05;
        
        if ( isdefined( exfilgoaltrigger.objectivekey ) )
        {
            objectivekey = exfilgoaltrigger.objectivekey;
        }
        else
        {
            objectivekey = exfilgoaltrigger.script_label;
        }
        
        if ( isdefined( exfilgoaltrigger.iconname ) )
        {
            iconname = exfilgoaltrigger.iconname;
        }
        else
        {
            iconname = exfilgoaltrigger.script_label;
        }
        
        exfilgoaltrigger = scripts\mp\gameobjects::createuseobject( var_c8a41ae10dd3b1d2, exfilgoaltrigger, visuals, ( 0, 0, 100 ) );
        exfilgoaltrigger.team = var_c8a41ae10dd3b1d2;
        exfilgoaltrigger.ownerteam = game[ "defenders" ];
        exfilgoaltrigger.ownerteamcaps = 1;
        exfilgoaltrigger.origin = exfilgoaltrigger.curorigin;
        exfilgoaltrigger scripts\mp\gameobjects::allowuse( "enemy" );
        exfilgoaltrigger scripts\mp\gameobjects::cancontestclaim( 1 );
        exfilgoaltrigger scripts\mp\gameobjects::setusetime( level.flagcapturetime );
        exfilgoaltrigger.onuse = &extractzone_onuse;
        exfilgoaltrigger.onbeginuse = &extractzone_onusebegin;
        exfilgoaltrigger.onenduse = &extractzone_onuseend;
        exfilgoaltrigger.oncontested = &extractzone_oncontested;
        exfilgoaltrigger.onuncontested = &extractzone_onuncontested;
        exfilgoaltrigger scripts\mp\gameobjects::pinobjiconontriggertouch();
        exfilgoaltrigger.id = "domFlag";
        exfilgoaltrigger.extractionactive = 0;
        exfilgoaltrigger scripts\mp\gameobjects::setcapturebehavior( "normal" );
        exfilgoaltrigger.objectivekey = objectivekey;
        exfilgoaltrigger.iconname = iconname;
        exfilgoaltrigger scripts\mp\gameobjects::setvisibleteam( "any" );
        exfilgoaltrigger.stompprogressreward = &extractzone_stompprogressreward;
        exfilgoaltrigger.nousebar = 1;
        exfilgoaltrigger.id = "domFlag";
        exfilgoaltrigger.claimgracetime = level.flagcapturetime * 1000;
        exfilgoaltrigger scripts\mp\gameobjects::setobjectivestatusicons( level.icondefendextract, level.iconcaptureextract );
        waitframe();
    }
    
    entities = getentarray();
    
    foreach ( entity in entities )
    {
        var_49c0bb15cb302f86 = entity.script_gameobjectname;
        
        if ( isdefined( var_49c0bb15cb302f86 ) )
        {
            if ( var_49c0bb15cb302f86 == "bombzone" )
            {
                entity delete();
            }
        }
    }
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 1
// Checksum 0x0, Offset: 0x1905
// Size: 0xf9
function extractzone_onusebegin( player )
{
    player.iscapturing = 1;
    level.canprocessot = 0;
    ownerteam = scripts\mp\gameobjects::getownerteam();
    self.neutralizing = istrue( level.flagneutralization ) && ownerteam != "neutral";
    
    if ( !istrue( self.neutralized ) )
    {
        self.didstatusnotify = 0;
    }
    
    if ( istrue( level.capturedecay ) )
    {
        thread scripts\mp\gameobjects::useobjectdecay( player.team );
    }
    
    self.prevownerteam = getotherteam( player.team )[ 0 ];
    scripts\mp\gametypes\obj_dom::updateflagcapturestate( player.team );
    
    if ( ownerteam == game[ "attackers" ] )
    {
        scripts\mp\gameobjects::setobjectivestatusicons( level.iconstoppingextract, level.iconlosingextract );
        return;
    }
    
    scripts\mp\gameobjects::setobjectivestatusicons( level.iconlosingextract, level.icontakingextract );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 3
// Checksum 0x0, Offset: 0x1a06
// Size: 0xd7
function extractzone_onuseend( team, player, success )
{
    level.canprocessot = 1;
    
    if ( success )
    {
        scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    }
    
    if ( isplayer( player ) )
    {
        player.iscapturing = 0;
        player setclientomnvar( "ui_objective_pinned_text_param", 0 );
    }
    
    if ( !success )
    {
        self.neutralized = 0;
        ownerteam = scripts\mp\gameobjects::getownerteam();
        
        if ( ownerteam == game[ "attackers" ] )
        {
            if ( self.extractionactive )
            {
                scripts\mp\gameobjects::setobjectivestatusicons( "icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil" );
            }
            else
            {
                scripts\mp\gameobjects::setobjectivestatusicons( "icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil" );
            }
            
            return;
        }
        
        scripts\mp\gameobjects::setobjectivestatusicons( level.icondefendextract, level.iconcaptureextract );
    }
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 1
// Checksum 0x0, Offset: 0x1ae5
// Size: 0x110
function extractzone_onuse( credit_player )
{
    level.canprocessot = 1;
    team = credit_player.team;
    oldteam = scripts\mp\gameobjects::getownerteam();
    self.capturetime = gettime();
    self.neutralized = 0;
    extractzone_setcaptured( team, credit_player );
    
    if ( !self.neutralized )
    {
        if ( isdefined( level.onobjectivecomplete ) )
        {
            [[ level.onobjectivecomplete ]]( "dompoint", self.objectivekey, credit_player, team, oldteam, self );
        }
    }
    
    if ( team == game[ "attackers" ] )
    {
        playfxontag( level._effect[ "vfx_smk_signal" ], self.visuals[ 0 ], "tag_origin" );
        playannouncerbattlechatter( team, "extract_littlebird_start_a_friendly", 20 );
        credit_player vipextract( self );
        return;
    }
    
    stopfxontag( level._effect[ "vfx_smk_signal" ], self.visuals[ 0 ], "tag_origin" );
    self.extractionactive = 0;
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0x1bfd
// Size: 0x23
function extractzone_oncontested()
{
    scripts\mp\gameobjects::setobjectivestatusicons( level.iconcontestingextract );
    scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 1
// Checksum 0x0, Offset: 0x1c28
// Size: 0x7e
function extractzone_onuncontested( lastclaimteam )
{
    ownerteam = scripts\mp\gameobjects::getownerteam();
    
    if ( self.ownerteam == game[ "attackers" ] )
    {
        if ( self.extractionactive )
        {
            scripts\mp\gameobjects::setobjectivestatusicons( "icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil" );
        }
        else
        {
            scripts\mp\gameobjects::setobjectivestatusicons( "icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil" );
        }
        
        return;
    }
    
    scripts\mp\gameobjects::setobjectivestatusicons( level.icondefendextract, level.iconcaptureextract );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 2
// Checksum 0x0, Offset: 0x1cae
// Size: 0x191
function extractzone_setcaptured( team, credit_player )
{
    scripts\mp\gameobjects::setownerteam( team );
    
    if ( self.ownerteam == game[ "attackers" ] )
    {
        scripts\mp\gameobjects::setusetime( 5 );
        scripts\mp\gameobjects::setobjectivestatusicons( "icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil" );
    }
    else
    {
        scripts\mp\gameobjects::setusetime( 0.05 );
        scripts\mp\gameobjects::setobjectivestatusicons( level.icondefendextract, level.iconcaptureextract );
        
        foreach ( heli in self.choppers )
        {
            heli notify( "bugOut" );
            heli notify( "esc_littlebird_arrive" );
            heli array_remove( self.choppers, heli );
            self.choppers = [];
            heli thread scripts\mp\gametypes\br_extract_chopper::littlebirdleave();
        }
        
        playannouncerbattlechatter( game[ "attackers" ], "extract_littlebird_leaving_a_friendly", 10 );
    }
    
    self notify( "capture", credit_player );
    self notify( "assault", credit_player );
    self.neutralized = 0;
    
    if ( self.touchlist[ team ].size == 0 )
    {
        self.touchlist = self.oldtouchlist;
    }
    
    thread giveflagcapturexp( self.touchlist[ team ], credit_player );
    scripts\mp\analyticslog::logevent_gameobject( self.analyticslogtype, self.analyticslogid, self.visuals[ 0 ].origin, -1, "captured_" + team );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 1
// Checksum 0x0, Offset: 0x1e47
// Size: 0x1d
function extractzone_stompprogressreward( player )
{
    player thread scripts\mp\utility\points::doscoreevent( #"mode_x_defend" );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0x1e6c
// Size: 0x43
function getcapturetype()
{
    capturetype = "normal";
    
    if ( level.capturetype == 2 )
    {
        capturetype = "neutralize";
    }
    else if ( level.capturetype == 3 )
    {
        capturetype = "persistent";
    }
    
    return capturetype;
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 2
// Checksum 0x0, Offset: 0x1eb8
// Size: 0x187
function giveflagcapturexp( touchlist, credit_player )
{
    level endon( "game_ended" );
    first_player = credit_player;
    
    if ( isdefined( first_player.owner ) )
    {
        first_player = first_player.owner;
    }
    
    level.lastcaptime = gettime();
    
    if ( isplayer( first_player ) )
    {
        level thread teamplayercardsplash( "callout_securedposition", first_player );
        var_7e2c53b0bcf117d9 = spawnstruct();
        var_7e2c53b0bcf117d9.player = first_player;
        var_7e2c53b0bcf117d9.eventname = "capture";
        var_7e2c53b0bcf117d9.position = first_player.origin;
        scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_on_game_event", var_7e2c53b0bcf117d9 );
    }
    
    players_touching = getarraykeys( touchlist );
    
    for ( index = 0; index < players_touching.size ; index++ )
    {
        player = touchlist[ players_touching[ index ] ].player;
        
        if ( isdefined( player.owner ) )
        {
            player = player.owner;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player incpersstat( "captures", 1 );
        player scripts\mp\persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
        player setextrascore0( player.pers[ "captures" ] );
        player thread scripts\mp\utility\points::doscoreevent( #"mode_dom_secure" );
        wait 0.05;
    }
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 1
// Checksum 0x0, Offset: 0x2047
// Size: 0x116
function vipextract( var_53472fd04ef31634 )
{
    if ( !isdefined( var_53472fd04ef31634.choppers ) )
    {
        var_53472fd04ef31634.choppers = [];
    }
    
    playerfwd = anglestoforward( self getplayerangles( 1 ) );
    groundpos = getgroundposition( self geteye() + ( 0, 0, 60 ) + playerfwd * 80, 60 ) + ( 0, 0, 8 );
    heli = scripts\mp\gametypes\br_extract_chopper::spawnextractchopper( var_53472fd04ef31634, var_53472fd04ef31634.origin );
    var_53472fd04ef31634.choppers[ var_53472fd04ef31634.choppers.size ] = heli;
    self iprintlnbold( "Extraction copter en route!" );
    heli.extractzone = var_53472fd04ef31634;
    heli.extractteam = self.team;
    var_53472fd04ef31634.curorigin = var_53472fd04ef31634.origin;
    var_53472fd04ef31634.offset3d = ( 0, 0, 30 );
    var_53472fd04ef31634 thread extracttriggerwatcher( heli );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 1
// Checksum 0x0, Offset: 0x2165
// Size: 0x13f
function extracttriggerwatcher( heli )
{
    level endon( "game_ended" );
    heli endon( "bugOut" );
    heli waittill( "esc_littlebird_arrive" );
    self.extractionactive = 1;
    playannouncerbattlechatter( heli.extractteam, "extract_littlebird_close_a_friendly", 10 );
    
    if ( self.stalemate )
    {
        scripts\mp\gameobjects::setobjectivestatusicons( level.iconcontestingextract );
    }
    else
    {
        scripts\mp\gameobjects::setobjectivestatusicons( "icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil" );
    }
    
    while ( true )
    {
        self.trigger waittill( "trigger", player );
        
        if ( !istrue( self.stalemate ) )
        {
            if ( istrue( player.isagentvip ) && self.numtouching[ game[ "defenders" ] ] == 0 )
            {
                level thread vip_endgame( player.team, game[ "end_reason" ][ "objective_completed" ] );
                break;
            }
            
            if ( player.team == self.team && isdefined( player.carryobject ) )
            {
                level thread vip_endgame( player.team, game[ "end_reason" ][ "objective_completed" ] );
                break;
            }
        }
    }
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0x22ac
// Size: 0x6d
function createthreatbiasgroups()
{
    waitframe();
    createthreatbiasgroup( "vip" );
    
    foreach ( team in level.teamnamelist )
    {
        createthreatbiasgroup( team );
        setignoremegroup( team, "vip" );
    }
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0x2321
// Size: 0x364
function spawnvip()
{
    level endon( "game_ended" );
    wait 2;
    bombtrigger = getent( "sd_bomb_pickup_trig", "targetname" );
    agent = undefined;
    spawnloc = undefined;
    level.allowhvtspawn = 1;
    
    while ( !isdefined( agent ) )
    {
        agent = scripts\mp\agents\agent_common::connectnewagent( "player", game[ "attackers" ] );
        
        if ( isdefined( agent ) )
        {
            spawnloc = bombtrigger.origin;
            bombtrigger delete();
            agent thread [[ agent scripts\mp\agents\agent_utility::agentfunc( "spawn" ) ]]( spawnloc, ( 0, 0, 0 ) );
            nearestnode = agent getnearestnode();
            agent setorigin( nearestnode.origin );
            agent.team = game[ "attackers" ];
            agent scripts\mp\bots\bots_util::bot_set_difficulty( "recruit" );
            agent.outlineid = scripts\mp\utility\outline::outlineenableforteam( agent, agent.team, "outline_nodepth_green", "lowest" );
            agent.nocorpse = 1;
            agent.isdowned = 0;
            agent.isagentvip = 1;
            trigger = spawn( "script_model", agent.origin + ( 0, 0, 30 ) );
            trigger.team = game[ "attackers" ];
            trigger.destination = agent.origin;
            trigger linkto( agent );
            trigger scripts\mp\utility\usability::maketeamusable( trigger.team );
            trigger sethintstring( &"MP/HOLD_TO_ESCORT_VIP" );
            trigger setusepriority( -1 - 1 - 1 - 1 );
            agent.trigger = trigger;
            agent.ownerteam = trigger.team;
            agent.interactteam = "friendly";
            agent.requireslos = 1;
            agent.exclusiveuse = 0;
            agent.curprogress = 0;
            agent.usetime = 0;
            agent.userate = 1;
            agent.id = "care_package";
            agent.skiptouching = 1;
            agent.onuse = &agent_onuse;
            agent thread scripts\mp\gameobjects::useobjectusethink();
            agent.trackedobject = agent scripts\mp\gameobjects::createtrackedobject( agent, ( 0, 0, 70 ) );
            agent.trackedobject.objidpingfriendly = 0;
            agent.trackedobject.objidpingenemy = 0;
            agent.trackedobject.objpingdelay = 0.05;
            agent.trackedobject.visibleteam = "friendly";
            agent.invulnerable = 1;
            agent.trackedobject scripts\mp\gameobjects::setobjectivestatusicons( level.iconescort );
            continue;
        }
        
        waitframe();
    }
    
    agent setthreatbiasgroup( "vip" );
    agent thread hvtclearmove( spawnloc );
    agent thread hvtdeathwatcher();
    agent takeallweapons();
    waitframe();
    agent _giveweapon( "iw9_me_fists_mp", undefined, undefined, 1 );
    level.vip = agent;
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 1
// Checksum 0x0, Offset: 0x268d
// Size: 0x50
function hvtclearmove( spawnloc )
{
    self botsetscriptgoal( spawnloc, 20, "critical" );
    result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();
    
    while ( !isdefined( self.tetherplayer ) )
    {
        self botsetflag( "disable_movement", 1 );
        wait 0.1;
    }
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 1
// Checksum 0x0, Offset: 0x26e5
// Size: 0x81
function agent_onuse( player )
{
    printboldonteam( "HVT is following " + player.name, player.team );
    self.following = 1;
    self.usetime = 1000;
    thread followplayer( player );
    player thread watchownerdeath( self );
    self.trigger scripts\mp\utility\usability::maketeamusable( self.team );
    self.trigger disableplayeruse( player );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 1
// Checksum 0x0, Offset: 0x276e
// Size: 0x210
function followplayer( player )
{
    self endon( "game_ended" );
    self.tetherplayer = player;
    level.tetherplayer = player;
    self botsetflag( "disable_movement", 0 );
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers( player.team, "vip_extract", "vip_stop_extract", level.tetherplayer, "vip_escort" );
    
    while ( isdefined( self.tetherplayer ) )
    {
        var_fddeec50a509ece5 = self.tetherplayer getstance();
        self botsetstance( var_fddeec50a509ece5 );
        
        if ( self.tetherplayer issprinting() )
        {
            self botsetflag( "cautious", 0 );
            self botsetflag( "force_sprint", 1 );
        }
        else
        {
            self botsetflag( "force_sprint", 0 );
            self botsetflag( "cautious", 1 );
        }
        
        if ( distance2dsquared( self.tetherplayer.origin, self.origin ) < 10000 )
        {
            level.vipdist = distance2dsquared( self.tetherplayer.origin, self.origin );
        }
        else if ( distance2dsquared( self.tetherplayer.origin, self.origin ) > 10000 )
        {
            level.vipdist = distance2dsquared( self.tetherplayer.origin, self.origin );
            goalnode = botgetclosestnavigablepoint( self.tetherplayer.origin, 40, self );
            
            /#
                sphere( goalnode, 32, ( 0, 1, 0 ), 1, 50 );
            #/
            
            if ( isdefined( goalnode ) )
            {
                self botsetpathingstyle( "sneak" );
                self botsetscriptgoal( goalnode, 32, "tactical" );
                pathresult = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail( 3 );
                
                if ( pathresult == "goal" )
                {
                }
            }
        }
        
        wait 0.15;
    }
    
    level.tetherplayer = undefined;
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 1
// Checksum 0x0, Offset: 0x2986
// Size: 0x6e
function watchownerdeath( vip )
{
    self endon( "game_ended" );
    vip endon( "tether_swap" );
    self waittill( "death" );
    vip.following = 0;
    vip.usetime = 0;
    vip.tetherplayer = undefined;
    level.tetherplayer = undefined;
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers( vip.team, "vip_secure", "vip_stop_extract" );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0x29fc
// Size: 0xae
function hvtdeathwatcher()
{
    self endon( "game_ended" );
    self endon( "hvt_timeout" );
    self waittill( "death" );
    self.trackedobject scripts\mp\gameobjects::releaseid();
    self.trigger scripts\mp\utility\usability::setallunusable();
    level.hostages[ 0 ] = spawnhostage( self.origin, self.team, 1 );
    level.hostages[ 0 ].outlineid = scripts\mp\utility\outline::outlineenableforteam( level.hostages[ 0 ].body, level.hostages[ 0 ].team, "outline_nodepth_cyan", "killstreak_personal" );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0x2ab2
// Size: 0x19a
function updatematchstatushintonspawn()
{
    level endon( "game_ended" );
    level gameflagwait( "prematch_done" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( level.vip ) )
    {
        if ( isdefined( level.tetherplayer ) )
        {
            if ( isdefined( level.tetherplayer.team ) && level.tetherplayer.team == self.team )
            {
                if ( level.tetherplayer == self )
                {
                    scripts\mp\hud_message::function_f004ef4606b9efdc( "vip_escort" );
                }
                else
                {
                    scripts\mp\hud_message::function_f004ef4606b9efdc( "vip_extract" );
                }
            }
            else
            {
                scripts\mp\hud_message::function_f004ef4606b9efdc( "vip_stop_extract" );
            }
        }
        else if ( isdefined( self.team ) && level.vip.team == self.team )
        {
            scripts\mp\hud_message::function_f004ef4606b9efdc( "vip_secure" );
        }
        else
        {
            scripts\mp\hud_message::function_f004ef4606b9efdc( "vip_stop_extract" );
        }
        
        return;
    }
    
    if ( isdefined( level.hostagecarrier ) )
    {
        if ( level.hostagecarrier.team == self.team )
        {
            if ( level.hostagecarrier == self )
            {
                scripts\mp\hud_message::function_f004ef4606b9efdc( "vip_carry" );
            }
            else
            {
                scripts\mp\hud_message::function_f004ef4606b9efdc( "vip_extract" );
            }
        }
        else
        {
            scripts\mp\hud_message::function_f004ef4606b9efdc( "vip_stop_extract" );
        }
        
        return;
    }
    
    if ( level.hostages[ 0 ].team == self.team )
    {
        scripts\mp\hud_message::function_f004ef4606b9efdc( "vip_secure" );
        return;
    }
    
    scripts\mp\hud_message::function_f004ef4606b9efdc( "vip_stop_extract" );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 3
// Checksum 0x0, Offset: 0x2c54
// Size: 0xc5
function playannouncerbattlechatter( team, soundname, suffix )
{
    level endon( "game_ended" );
    faction = "ustl";
    soundalias = "dx_mpa_" + faction + "_" + soundname + "_" + suffix;
    
    if ( soundexists( soundalias ) )
    {
        foreach ( player in level.players )
        {
            if ( player.team == team )
            {
                player queuedialogforplayer( soundalias, soundname, 2 );
            }
        }
    }
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 0
// Checksum 0x0, Offset: 0x2d21
// Size: 0x26
function votimeendingsoon()
{
    level endon( "game_ended" );
    level waittill( "match_ending_very_soon" );
    playannouncerbattlechatter( game[ "attackers" ], "extract_littlebird_leaving_soon_a_friendly", 10 );
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 3
// Checksum 0x0, Offset: 0x2d4f
// Size: 0x53b
function spawnhostage( spawnpt, var_2883e54a0393d54d, showicon )
{
    if ( !isdefined( showicon ) )
    {
        showicon = 1;
    }
    
    if ( getgametype() == "vip" )
    {
        var_2883e54a0393d54d = game[ "attackers" ];
        var_a5979337c62d2a9 = "body_opforce_london_terrorist_1_2";
        var_9163c4f755283f46 = "head_male_bc_03";
    }
    else
    {
        var_2883e54a0393d54d = "neutral";
        var_a5979337c62d2a9 = "body_mp_western_fireteam_west_ar_1_1_lod1";
        var_9163c4f755283f46 = "head_mp_western_fireteam_west_ar_1_1";
    }
    
    hostage = spawn( "script_model", spawnpt );
    var_15115ecdab98af77 = spawn( "script_model", spawnpt );
    var_541b553bd71295f4 = spawn( "script_model", spawnpt );
    var_15115ecdab98af77 setmodel( var_a5979337c62d2a9 );
    var_541b553bd71295f4 setmodel( var_9163c4f755283f46 );
    var_541b553bd71295f4 linkto( var_15115ecdab98af77, "j_neck", ( -9, 1, 0 ), ( 0, 0, 0 ) );
    var_15115ecdab98af77 linkto( hostage, "", ( 0, 0, -48 ), ( 0, 0, 0 ) );
    trigger = spawn( "script_model", spawnpt );
    trigger.team = var_2883e54a0393d54d;
    trigger.destination = spawnpt;
    hostage.trigger = trigger;
    trigger linkto( hostage );
    hostage.trigger makeusable();
    hostage.body = var_15115ecdab98af77;
    hostage.head = var_541b553bd71295f4;
    hostage = drophostage( undefined, hostage, spawnpt, 1 );
    hostage.teamscored[ "allies" ] = 0;
    hostage.teamscored[ "axis" ] = 0;
    hostage.wasindent = 0;
    hostage.requireslos = 1;
    hostage.setdropped = &drophostage;
    hostage.team = var_2883e54a0393d54d;
    hostage.usehostagedrop = 1;
    hostage.ownerteam = var_2883e54a0393d54d;
    hostage.interactteam = ter_op( var_2883e54a0393d54d == "neutral", "any", "friendly" );
    hostage.exclusiveuse = 0;
    hostage.curprogress = 0;
    hostage.usetime = ter_op( scripts\mp\utility\game::getgametype() == "cmd", 500, 0 );
    hostage.userate = 1;
    hostage.id = "care_package";
    hostage.skiptouching = 1;
    hostage thread scripts\mp\gameobjects::useobjectusethink();
    enemyicon = "icon_minimap_tac_ops_hostage_unknown";
    attachobj = spawn( "script_model", spawnpt );
    attachobj linkto( hostage );
    hostage.attachobj = attachobj;
    
    if ( var_2883e54a0393d54d == "neutral" )
    {
        var_e7345e605d1947fc = "any";
        visibleteam = "any";
    }
    else
    {
        var_e7345e605d1947fc = "friendly";
        visibleteam = "friendly";
    }
    
    if ( scripts\mp\utility\game::getgametype() != "cmd" && showicon )
    {
        hostage.trackedobject = hostage scripts\mp\gameobjects::createtrackedobject( attachobj, ( 0, 0, 0 ) );
        hostage.trackedobject.objidpingfriendly = 0;
        hostage.trackedobject.objidpingenemy = 1;
        hostage.trackedobject.objpingdelay = 2;
        hostage.trackedobject scripts\mp\gameobjects::allowcarry( var_e7345e605d1947fc );
        hostage.trackedobject scripts\mp\gameobjects::setownerteam( hostage.ownerteam );
        hostage.trackedobject scripts\mp\gameobjects::setobjectivestatusicons( level.iconrecover, level.iconrecover );
        hostage.trackedobject.cancontestclaim = 1;
        hostage.trackedobject.stalemate = 0;
        hostage.trackedobject.wasstalemate = 1;
        hostage.trackedobject scripts\mp\gameobjects::setvisibleteam( visibleteam );
    }
    
    if ( isdefined( hostage.trackedobject ) )
    {
        hostage.trackedobject scripts\mp\gameobjects::allowcarry( var_2883e54a0393d54d );
        hostage.trackedobject scripts\mp\gameobjects::setownerteam( var_2883e54a0393d54d );
        hostage.trackedobject scripts\mp\gameobjects::setobjectivestatusicons( level.iconrecover, level.iconrecover );
        
        if ( getgametype() == "btm" || getgametype() == "arm" || getgametype() == "conflict" )
        {
            hostage.trackedobject.cancontestclaim = 1;
            hostage.trackedobject.stalemate = 0;
            hostage.trackedobject.wasstalemate = 1;
        }
        
        hostage.trackedobject scripts\mp\gameobjects::setvisibleteam( visibleteam );
    }
    
    return hostage;
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 5
// Checksum 0x0, Offset: 0x3293
// Size: 0x553
function drophostage( player, hostage, position, spawndrop, waittime )
{
    self notify( "gameobject_deleted" );
    
    if ( !isdefined( player ) )
    {
        player = self.carrier;
    }
    
    if ( !isdefined( position ) )
    {
        position = self.curorigin;
    }
    
    if ( !isdefined( hostage ) )
    {
        hostage = self;
    }
    
    hostage notify( "dropped" );
    
    if ( isdefined( hostage.trackedobject ) )
    {
        hostage.trackedobject.carrier = hostage.attachobj;
        hostage.trackedobject scripts\mp\gameobjects::setobjectivestatusicons( level.iconrecover, level.iconrecover );
        
        if ( getgametype() != "cmd" && getgametype() != "btm" || getgametype() == "arm" || getgametype() == "conflict" )
        {
        }
    }
    
    if ( isdefined( level.hostagegoalent ) )
    {
        level.hostagegoalent scripts\mp\gameobjects::setvisibleteam( "none" );
        level.hostagegoalent scripts\mp\gameobjects::releaseid();
    }
    
    if ( getgametype() == "btm" && isdefined( level.vipextractzones ) )
    {
        level.vipextractzones[ player.team ].goalent scripts\mp\gameobjects::setvisibleteam( "none" );
    }
    
    hostage.carried = 0;
    droppt = position;
    hostage unlink();
    droppt = getclosestpointonnavmesh( position );
    hostage.origin = getphysicspointaboutnavmesh( droppt ) + ( 0, 0, 2 );
    hostage.angles = ( 0, hostage.angles[ 1 ], 0 );
    
    if ( !isdefined( spawndrop ) && isdefined( hostage.useobj ) )
    {
        hostage.useobj.origin = hostage.origin;
    }
    
    if ( isdefined( player ) )
    {
        player.carryobject = undefined;
        team = player.team;
        
        foreach ( hstg in level.hostages )
        {
            if ( hstg != hostage )
            {
                hstg enableplayeruse( player );
            }
        }
    }
    
    if ( isdefined( hostage.wmhostage ) )
    {
        hostage.wmhostage unlink();
        hostage.wmhostage.head delete();
        hostage.wmhostage delete();
        hostage.wmhostage = undefined;
    }
    
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    if ( isdefined( player ) && isdefined( player.hostagecarried ) )
    {
        player.hostagecarried.body show();
        player.hostagecarried.head show();
        player.hostagecarried = undefined;
    }
    else
    {
        hostage.body show();
        hostage.head show();
    }
    
    hostage.trigger makeusable();
    
    if ( isdefined( waittime ) )
    {
    }
    
    level.hostagecarrier = undefined;
    
    if ( getgametype() == "vip" )
    {
        foreach ( player in level.players )
        {
            if ( player.team != hostage.trigger.team )
            {
                hostage.trigger disableplayeruse( player );
                hostage.trigger hidefromplayer( player );
            }
        }
        
        hostage.trigger sethintstring( &"MP/HOLD_TO_PICKUP_VIP" );
        level thread scripts\mp\hud_message::updatematchstatushintforallplayers( hostage.team, "vip_secure", "vip_stop_extract" );
    }
    else if ( getgametype() == "btm" )
    {
        hostage.trigger sethintstring( &"MP/HOLD_TO_PICKUP_VIP" );
        level thread scripts\mp\hud_message::updatematchstatushintforallplayers( hostage.team, "vip_secure", "vip_stop_extract" );
    }
    else
    {
        hostage.trigger sethintstring( &"MP/HOLD_TO_PICKUP_HOSTAGE" );
    }
    
    hostage setusepriority( -1 - 1 - 1 - 1 );
    
    if ( isdefined( hostage.curobjid ) )
    {
        objective_setownerteam( hostage.curobjid, "neutral" );
    }
    
    if ( isdefined( hostage.body ) )
    {
        hostage.body linkto( hostage, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        hostage.body scriptmodelplayanimdeltamotion( "hm_grnd_civ_react02_idle07" );
    }
    
    return hostage;
}

// Namespace vip / scripts\mp\gametypes\vip
// Params 1
// Checksum 0x0, Offset: 0x37ef
// Size: 0x89
function getphysicspointaboutnavmesh( pt )
{
    contents = scripts\engine\trace::create_contents( undefined, 1, 1, undefined, undefined, undefined, undefined );
    var_bc1fb594d8a6e68a = physics_raycast( pt + ( 0, 0, 48 ), pt - ( 0, 0, 48 ), contents, undefined, 0, "physicsquery_closest" );
    hit = isdefined( var_bc1fb594d8a6e68a ) && var_bc1fb594d8a6e68a.size > 0;
    
    if ( hit )
    {
        hitpos = var_bc1fb594d8a6e68a[ 0 ][ "position" ];
        return hitpos;
    }
    
    return pt;
}

