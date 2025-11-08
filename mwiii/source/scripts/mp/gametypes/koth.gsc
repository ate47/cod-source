#using script_548072087c9fd504;
#using scripts\common\powerups;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\callouts;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\escort_horde;
#using scripts\mp\gametypes\grnd;
#using scripts\mp\gametypes\mgl_mp;
#using scripts\mp\gametypes\obj_zonecapture;
#using scripts\mp\gametypes\trickrtreat;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace koth;

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0xe18
// Size: 0x3d0
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    
    if ( isjuggermoshgamemode() )
    {
        level.var_29ed825c4a9a052c = scripts\mp\utility\game::function_9a59855eebf296b6();
    }
    
    if ( scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e() )
    {
        allowed = scripts\mp\gametypes\mgl_mp::function_7b7c572755736c13();
    }
    else
    {
        allowed[ 0 ] = getgametype();
        allowed[ 1 ] = "hardpoint";
        allowed[ 2 ] = "tdm";
    }
    
    if ( scripts\cp_mp\utility\game_utility::function_21322da268e71c19() || level.leagueplaymatch )
    {
        allowed[ 0 ] = scripts\mp\utility\game::getbasegametype();
    }
    
    scripts\mp\gameobjects::main( allowed );
    
    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = &initializematchrules;
        [[ level.initializematchrules ]]();
        level thread reinitializematchrulesonmigration();
    }
    else
    {
        registertimelimitdvar( getgametype(), 300 );
        registerscorelimitdvar( getgametype(), 300 );
        registerroundlimitdvar( getgametype(), 1 );
        registerwinlimitdvar( getgametype(), 1 );
        registernumlivesdvar( getgametype(), 0 );
        registerhalftimedvar( getgametype(), 0 );
    }
    
    updategametypedvars();
    level.hpstarttime = 0;
    level.scoreperplayer = undefined;
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.var_952bd6e10104d8a = &function_952bd6e10104d8a;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.onrespawndelay = &getrespawndelay;
    level.lastcaptime = gettime();
    level.usezonecapture = 1;
    level.getkothzonedeadzonedist = &getkothzonedeadzonedist;
    level.onplayerjoinedteam = &scripts\mp\gametypes\obj_zonecapture::onplayerjoinedteam;
    level.disablebuddyspawn = 1;
    
    if ( isanymlgmatch() )
    {
        level.ontimelimit = &function_1134d3068749d68e;
    }
    
    level.lastcaptureteam = undefined;
    level.previousclosespawnent = undefined;
    setomnvar( "ui_hq_num_alive", 0 );
    setomnvar( "ui_hq_ownerteam", -1 );
    
    if ( scripts\cp_mp\utility\game_utility::function_21322da268e71c19() )
    {
        game[ "dialog" ][ "gametype" ] = "dx_mp_hphc_mode_t141_name";
    }
    else
    {
        game[ "dialog" ][ "gametype" ] = "dx_mp_hard_game_uktl_name";
    }
    
    game[ "dialog" ][ "boost" ] = "dx_mp_hard_game_uktl_bost";
    game[ "dialog" ][ "offense_obj" ] = "dx_mp_hard_game_uktl_bost";
    game[ "dialog" ][ "defense_obj" ] = "dx_mp_hard_game_uktl_bost";
    game[ "dialog" ][ "obj_destroyed" ] = "obj_destroyed";
    game[ "dialog" ][ "obj_captured" ] = "obj_captured";
    game[ "dialog" ][ "hp_first" ] = "dx_mp_hard_game_uktl_hpo1";
    game[ "dialog" ][ "hp_new_location" ] = "dx_mp_hard_game_uktl_hpnl";
    game[ "dialog" ][ "hp_captured_enemy" ] = "dx_mp_hard_game_uktl_hpec";
    game[ "dialog" ][ "hp_captured_friendly" ] = "dx_mp_hard_game_uktl_hpfc";
    game[ "dialog" ][ "hp_contested" ] = "dx_mp_hard_game_uktl_hpct";
    game[ "dialog" ][ "hp_move_soon" ] = "dx_mp_hard_game_uktl_hpmv";
    game[ "dialog" ][ "hp_capturing_enemy" ] = "dx_mp_hard_game_uktl_ecip";
    game[ "dialog" ][ "hp_capturing_friendly" ] = "dx_mp_hard_game_uktl_fcip";
    level.nosuspensemusic = 1;
    thread writeplayerrotationscoretomatchdataongameend();
    
    if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
    {
        scripts\mp\gametypes\mgl_mp::function_29020e26e20049d9();
    }
    
    if ( getgametype() == "koth_horde_haunting" )
    {
        scripts\mp\gametypes\trickrtreat::init();
        scripts\common\powerups::function_8edb8c0ed499f61e( 0 );
        setdvarifuninitialized( @"hash_56c4a304cb548a29", 0 );
    }
    
    /#
        if ( getdvarint( @"hash_3288df25c3558e8d", 0 ) )
        {
            level thread function_97b50111eebb7239();
        }
    #/
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x11f0
// Size: 0x168
function initializematchrules()
{
    setcommonrulesfrommatchrulesdata();
    setdynamicdvar( function_3514ae5d09f47ed2( "zoneLifetime" ), getmatchrulesdata( "kothData", "zoneLifetime" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "zoneCaptureTime" ), getmatchrulesdata( "kothData", "zoneCaptureTime" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "firstZoneActivationDelay" ), getmatchrulesdata( "kothData", "firstZoneActivationDelay" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "zoneActivationDelay" ), getmatchrulesdata( "kothData", "zoneActivationDelay" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "nextZoneRevealTime" ), getmatchrulesdata( "kothData", "nextZoneRevealTime" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "zoneMajorityCapture" ), getmatchrulesdata( "kothData", "zoneMajorityCapture" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "randomLocationOrder" ), getmatchrulesdata( "kothData", "randomLocationOrder" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "additiveScoring" ), getmatchrulesdata( "kothData", "additiveScoring" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "pauseTime" ), getmatchrulesdata( "kothData", "pauseTime" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "spawnDelay" ), getmatchrulesdata( "kothData", "spawnDelay" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "halftime" ), 0 );
    registerhalftimedvar( "koth", 0 );
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x1360
// Size: 0x159
function onstartgametype()
{
    if ( ismutationgamemode() )
    {
        scripts\mp\gametypes\escort_horde::function_f9c27bb7f1c4fedc();
    }
    
    foreach ( entry in level.teamnamelist )
    {
        setobjectivetext( entry, &"OBJECTIVES/KOTH" );
        
        if ( level.splitscreen )
        {
            setobjectivescoretext( entry, &"OBJECTIVES/KOTH" );
        }
        else
        {
            setobjectivescoretext( entry, &"OBJECTIVES/KOTH_SCORE" );
        }
        
        setobjectivehinttext( entry, &"OBJECTIVES/KOTH_HINT" );
    }
    
    if ( level.scoremod[ "kill" ] > 0 )
    {
        game[ "dialog" ][ "offense_obj" ] = "boost_groundwar";
        game[ "dialog" ][ "defense_obj" ] = "boost_groundwar";
    }
    
    setclientnamemode( "auto_change" );
    level thread setupzones();
    initspawns();
    setkothwaypoints();
    seticonnames();
    
    if ( !level.zonerandomlocationorder )
    {
        remaphardpointorder();
    }
    
    level thread function_fab770bfe4b14e75();
    level thread hardpointmainloop();
    
    /#
        level thread function_1f98c5616d8b3d67();
        level thread function_bed0f399bee034f8();
        level thread function_ef4f5aa9c42838b2();
        level thread function_be67fb2ebcca86d1();
        level thread function_b4c2563f73b02c80();
    #/
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x14c1
// Size: 0x27
function private function_952bd6e10104d8a()
{
    if ( level.scoremod[ "kill" ] > 0 )
    {
        setdvar( @"hash_cf1c084c7a6622f9", 2 );
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x14f0
// Size: 0x180
function updategametypedvars()
{
    updatecommongametypedvars();
    level.zoneduration = dvarfloatvalue( "zoneLifetime", 60, 0, 300 );
    level.zonecapturetime = dvarfloatvalue( "zoneCaptureTime", 0, 0, 30 );
    level.firstzoneactivationdelay = dvarfloatvalue( "firstZoneActivationDelay", 30, 0, 60 );
    level.zoneactivationdelay = dvarfloatvalue( "zoneActivationDelay", 0, 0, 60 );
    level.nextzonerevealtime = dvarfloatvalue( "nextZoneRevealTime", 12, 0, 300 );
    level.zonemajoritycapture = dvarintvalue( "zoneMajorityCapture", 0, 0, 1 );
    level.zonerandomlocationorder = dvarintvalue( "randomLocationOrder", 0, 0, 1 );
    level.zoneadditivescoring = dvarintvalue( "additiveScoring", 0, 0, 1 );
    level.pausemodetimer = dvarintvalue( "pauseTime", 1, 0, 1 );
    level.spawndelay = dvarfloatvalue( "spawnDelay", 0, 0, 10 );
    
    if ( matchmakinggame() && !isanymlgmatch() && getdvarint( @"hash_56937a1bd450393d", 15 ) != 0 )
    {
        level.zoneactivationdelay = adjustzoneactivationdelayforlargemaps();
    }
    
    assertex( level.zoneduration >= level.nextzonerevealtime, "<dev string:x1c>" );
    
    if ( level.zoneduration < level.nextzonerevealtime )
    {
        level.nextzonerevealtime = level.zoneduration;
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x1678
// Size: 0x88
function adjustzoneactivationdelayforlargemaps()
{
    mapname = scripts\cp_mp\utility\game_utility::getmapname();
    
    switch ( mapname )
    {
        case #"hash_62c07791a2eda185":
        case #"hash_f09747c9feb47eb1":
        case #"hash_fcab5810ee4c6dc2":
            return getdvarint( @"hash_56937a1bd450393d", 15 );
        case #"hash_a8b272dba33a4aed":
            return ( getdvarint( @"hash_56937a1bd450393d", 15 ) + 15 );
        default:
            return level.zoneactivationdelay;
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x1708
// Size: 0x80
function seticonnames()
{
    level.icontarget = "koth_target";
    level.iconneutral = "koth_neutral";
    level.iconcapture = "koth_destroy";
    level.icondefend = "koth_defend";
    level.iconcontested = "koth_contested";
    level.icontaking = "koth_taking";
    level.iconlosing = "koth_losing";
    level.icondefending = "koth_defending";
    level.iconnext = "koth_next";
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x1790
// Size: 0x520
function hardpointmainloop()
{
    level endon( "game_ended" );
    setomnvar( "ui_objective_timer_stopped", 1 );
    setomnvar( "ui_hardpoint_timer", 0 );
    level.zone = getfirstzone();
    firstzone = 1;
    level.var_bf918fc5f938cd0c = 1;
    level.kothhillrotation = 0;
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        level waittill_any_2( "prematch_done", "start_mode_setup" );
    }
    
    level.favorclosespawnent = level.zone;
    logannouncement( undefined, undefined, "New Hardpoint", level.zone.trigger.origin );
    var_7e2c53b0bcf117d9 = spawnstruct();
    var_7e2c53b0bcf117d9.player = level.zone;
    var_7e2c53b0bcf117d9.eventname = "hill_moved";
    var_7e2c53b0bcf117d9.position = level.zone.trigger.origin;
    scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_on_game_event", var_7e2c53b0bcf117d9 );
    playsoundatpos( level.zone.trigger.origin, "jup_shared_zone_spawned" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    if ( level.pausemodetimer )
    {
        level scripts\mp\gamelogic::pausetimer();
    }
    
    setomnvar( "ui_objective_timer_stopped", 0 );
    level.zone scripts\mp\gametypes\obj_zonecapture::activatezone();
    level.zone scripts\mp\gameobjects::setvisibleteam( "any" );
    level.zone scripts\mp\gameobjects::setobjectivestatusicons( level.icontarget );
    level.zone.active = 1;
    var_570ba02607c0425c = 0;
    
    if ( level.firstzoneactivationdelay )
    {
        var_570ba02607c0425c = 1;
        level.zoneendtime = int( gettime() + level.firstzoneactivationdelay * 1000 );
        
        if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
        {
            level.var_a18063a06c258143 = int( gettime() + ( level.firstzoneactivationdelay + level.zoneduration ) * 1000 );
        }
        
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        setomnvar( "ui_hq_status", 12 );
        level.zoneislocked = 1;
        level thread scripts\mp\hud_message::updatematchstatushintforallplayers( undefined, "koth_control", "koth_control" );
        playsoundatpos( level.zone.curorigin, "jup_shared_zone_activate" );
        level thread waitthenplaynewobj();
        level.zone thread scripts\mp\gameobjects::function_d36dcacac1708708( level.firstzoneactivationdelay );
        wait level.firstzoneactivationdelay;
        level.zoneislocked = 0;
        level thread scripts\mp\hud_message::updatematchstatushintforallplayers( undefined, "koth_capture", "koth_capture" );
        playsoundatpos( level.zone.curorigin, "jup_shared_zone_activated" );
        namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c( 5, "free" );
    }
    
    level.zone notify( "stop_watching_first_trigger" );
    
    while ( true )
    {
        if ( !isdefined( level.mapcalloutsready ) )
        {
            level thread setupzonecallouts( firstzone );
        }
        
        level.objectivesetorder = 1;
        
        if ( level.pausemodetimer )
        {
            level scripts\mp\gamelogic::resumetimer();
        }
        
        waittillframeend();
        level.zone scripts\mp\gameobjects::enableobject();
        level.zone.capturecount = 0;
        
        if ( level.codcasterenabled )
        {
            level.zone thread scripts\mp\gametypes\obj_zonecapture::trackgametypevips();
        }
        
        spawnlogic::clearlastteamspawns();
        function_79cef04e7bd8c4c7( var_570ba02607c0425c, firstzone );
        firstzone = 0;
        var_570ba02607c0425c = 0;
        level.var_bf918fc5f938cd0c = 0;
        setomnvar( "ui_hq_status", 10 );
        spawnlogic::clearlastteamspawns();
        hpcaptureloop();
        ownerteam = level.zone scripts\mp\gameobjects::getownerteam();
        
        if ( level.pausemodetimer )
        {
            level scripts\mp\gamelogic::resumetimer();
        }
        
        level.lastcaptureteam = undefined;
        level.zone killhardpointvfx();
        level.zone.active = 0;
        
        if ( istrue( level.usehpzonebrushes ) )
        {
            foreach ( player in level.players )
            {
                level.zone scripts\mp\gametypes\obj_zonecapture::hideplayerspecificbrushes( player );
            }
        }
        
        level.zone scripts\mp\gameobjects::disableobject();
        level.zone scripts\mp\gameobjects::allowuse( "none" );
        level.zone scripts\mp\gameobjects::setownerteam( "neutral" );
        updateservericons( "zone_shift", 0 );
        level notify( "zone_reset" );
        setomnvar( "ui_hq_status", -1 );
        spawn_next_zone();
        
        if ( getgametype() == "grnd" && level.kothhillrotation == 1 )
        {
        }
        
        wait 1;
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x1cb8
// Size: 0x77
function waitthenplaynewobj()
{
    if ( istrue( level.infilvotiming ) )
    {
        wait 9.5;
    }
    else
    {
        wait 7;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        scripts\mp\utility\dialog::statusdialog( "hp_first", entry );
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x1d37
// Size: 0x134
function killhardpointvfx()
{
    foreach ( player in level.players )
    {
        foreach ( hpvfx in player._hardpointeffect )
        {
            player._hardpointeffect = array_remove( player._hardpointeffect, hpvfx );
            
            if ( isdefined( hpvfx ) )
            {
                hpvfx delete();
            }
        }
    }
    
    if ( isdefined( self.neutralhardpointfx ) && self.neutralhardpointfx.size > 0 )
    {
        foreach ( hpvfx in self.neutralhardpointfx )
        {
            hpvfx delete();
        }
    }
    
    self.neutralhardpointfx = [];
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x1e73
// Size: 0x2
function remaphardpointorder()
{
    
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x1e7d
// Size: 0xa3
function getfirstzone()
{
    if ( isdefined( level.remappedhpzoneorder ) )
    {
        zone = level.objectives[ level.remappedhpzoneorder[ 0 ] ];
        level.prevzoneindex = 0;
        level.futurezone = level.objectives[ level.remappedhpzoneorder[ 1 ] ];
    }
    else
    {
        zone = level.objectives[ "1" ];
        level.prevzoneindex = 1;
        level.futurezone = level.objectives[ "2" ];
    }
    
    zone.trigger scripts\engine\utility::trigger_on();
    return zone;
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x1f29
// Size: 0x503
function getnextzone()
{
    level notify( "stop_watching_trigger" );
    
    if ( level.zonerandomlocationorder )
    {
        var_bcadda10e825a297 = [];
        
        foreach ( entry in level.teamnamelist )
        {
            var_bcadda10e825a297[ entry ] = ( 0, 0, 0 );
        }
        
        livingplayers = getpotentiallivingplayers();
        
        foreach ( player in livingplayers )
        {
            if ( player.team == "spectator" )
            {
                continue;
            }
            
            var_bcadda10e825a297[ player.team ] += player.origin;
        }
        
        avgpos = [];
        
        foreach ( entry in level.teamnamelist )
        {
            players = getteamdata( entry, "players" );
            teamsize = max( players.size, 1 );
            avgpos[ entry ] = var_bcadda10e825a297[ entry ] / teamsize;
        }
        
        if ( !isdefined( level.prevzonelist ) || isdefined( level.prevzonelist ) && level.prevzonelist.size == level.objectives.size - 1 )
        {
            level.prevzonelist = [];
        }
        
        level.prevzonelist[ level.prevzonelist.size ] = level.prevzoneindex;
        playerweight = 0.7;
        zoneweight = 0.3;
        bestzoneindex = undefined;
        bestcost = undefined;
        
        foreach ( objective in level.objectives )
        {
            skip = 0;
            
            foreach ( zoneindex in level.prevzonelist )
            {
                if ( objective.objectivekey == string( zoneindex ) )
                {
                    skip = 1;
                    break;
                }
            }
            
            if ( skip )
            {
                continue;
            }
            
            zone = objective;
            playercost = 0;
            
            foreach ( entry in level.teamnamelist )
            {
                playercost += distance2dsquared( zone.curorigin, avgpos[ entry ] );
            }
            
            zonecost = distance2dsquared( zone.curorigin, level.zone.curorigin );
            totalcost = playercost * playerweight + zonecost * zoneweight;
            
            if ( !isdefined( bestcost ) || totalcost > bestcost )
            {
                bestcost = totalcost;
                bestzoneindex = objective.objectivekey;
            }
        }
        
        zone = level.objectives[ bestzoneindex ];
        level.prevzoneindex = bestzoneindex;
    }
    else if ( isdefined( level.remappedhpzoneorder ) )
    {
        level.prevzoneindex++;
        
        if ( level.prevzoneindex > level.remappedhpzoneorder.size - 1 )
        {
            level.prevzoneindex = 0;
        }
        
        zone = level.objectives[ level.remappedhpzoneorder[ level.prevzoneindex ] ];
        futurezone = level.prevzoneindex + 1;
        
        if ( futurezone > level.remappedhpzoneorder.size - 1 )
        {
            futurezone = 0;
        }
        
        level.futurezone = level.objectives[ level.remappedhpzoneorder[ futurezone ] ];
    }
    else
    {
        level.prevzoneindex++;
        
        if ( level.prevzoneindex > level.objectives.size )
        {
            level.prevzoneindex = 1;
        }
        
        zone = level.objectives[ string( level.prevzoneindex ) ];
        futurezone = level.prevzoneindex + 1;
        
        if ( futurezone > level.objectives.size )
        {
            futurezone = 1;
        }
        
        level.futurezone = level.objectives[ string( futurezone ) ];
    }
    
    return zone;
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x2435
// Size: 0x186
function spawn_next_zone()
{
    writecurrentrotationteamscore();
    level.zone scripts\mp\gametypes\obj_zonecapture::deactivatezone();
    level.zone = getnextzone();
    level.kothhillrotation++;
    level.zone scripts\mp\gametypes\obj_zonecapture::activatezone();
    level.favorclosespawnent = level.zone;
    level.zone.active = 1;
    level.zone.lastactivatetime = gettime();
    
    if ( level.zoneactivationdelay > 0 )
    {
        level.zone scripts\mp\gameobjects::setobjectivestatusicons( level.icontarget );
    }
    else
    {
        level.zone scripts\mp\gameobjects::setobjectivestatusicons( level.iconneutral );
    }
    
    logannouncement( undefined, undefined, "New Hardpoint", level.zone.trigger.origin );
    var_7e2c53b0bcf117d9 = spawnstruct();
    var_7e2c53b0bcf117d9.player = level.zone;
    var_7e2c53b0bcf117d9.eventname = "hill_moved";
    var_7e2c53b0bcf117d9.position = level.zone.trigger.origin;
    scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_on_game_event", var_7e2c53b0bcf117d9 );
    playsoundatpos( level.zone.trigger.origin, "jup_shared_zone_spawned" );
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 2
// Checksum 0x0, Offset: 0x25c3
// Size: 0x362
function function_79cef04e7bd8c4c7( var_570ba02607c0425c, firstzone )
{
    if ( firstzone )
    {
        foreach ( entry in level.teamnamelist )
        {
            scripts\mp\utility\dialog::statusdialog( "obj_generic_capture", entry );
        }
    }
    else
    {
        foreach ( entry in level.teamnamelist )
        {
            scripts\mp\utility\dialog::statusdialog( "hp_new_location", entry );
        }
    }
    
    /#
        if ( !isdefined( level.zone ) )
        {
            assertmsg( "<dev string:x6c>" );
            level waittill( "<dev string:xd6>" );
        }
    #/
    
    if ( isdefined( level.zone.curorigin ) )
    {
        playsoundatpos( level.zone.curorigin, "jup_shared_zone_activated" );
    }
    
    thread scripts\mp\music_and_dialog::headquarters_newhq_music();
    level.zone thread scripts\mp\gametypes\obj_zonecapture::hardpoint_setneutral();
    level.zone scripts\mp\gameobjects::allowuse( "none" );
    
    if ( istrue( var_570ba02607c0425c ) )
    {
    }
    else if ( level.zoneactivationdelay )
    {
        level.zone scripts\mp\gameobjects::setobjectivestatusicons( level.icontarget );
        updateservericons( "zone_activation_delay", 0 );
        level.zoneendtime = int( gettime() + 1000 * level.zoneactivationdelay );
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        setomnvar( "ui_hq_status", 12 );
        
        if ( level.pausemodetimer )
        {
            level scripts\mp\gamelogic::pausetimer();
        }
        
        level.zoneislocked = 1;
        level thread scripts\mp\hud_message::updatematchstatushintforallplayers( undefined, "koth_control", "koth_control" );
        level.zone thread scripts\mp\gameobjects::function_d36dcacac1708708( level.zoneactivationdelay );
        wait level.zoneactivationdelay;
        level.zoneislocked = 0;
        level thread scripts\mp\hud_message::updatematchstatushintforallplayers( undefined, "koth_capture", "koth_capture" );
        playsoundatpos( level.zone.trigger.origin, "jup_shared_zone_activated" );
        namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c( 5, "free" );
    }
    
    objid = scripts\mp\objidpoolmanager::function_92a696fa5918eca5( 1 );
    level.futurezone scripts\mp\gameobjects::setvisibleteam( "none", objid );
    level.zone scripts\mp\gameobjects::setobjectivestatusicons( level.iconneutral );
    updateservericons( "neutral", 0 );
    
    if ( level.zoneduration )
    {
        updateservericons( "neutral", 0 );
        thread movezoneaftertime( level.zoneduration );
        level.zoneendtime = int( gettime() + 1000 * level.zoneduration );
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        
        if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
        {
            level.var_a18063a06c258143 = int( gettime() + ( level.zoneactivationdelay + level.zoneduration ) * 1000 );
        }
        
        return;
    }
    
    level.zonedestroyedbytimer = 0;
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x292d
// Size: 0x178
function hpcaptureloop()
{
    level endon( "game_ended" );
    level endon( "zone_moved" );
    level.hpstarttime = gettime();
    
    while ( true )
    {
        level.zone scripts\mp\gameobjects::allowuse( "enemy" );
        level.zone scripts\mp\gameobjects::setvisibleteam( "any" );
        level.zone scripts\mp\gameobjects::setusetext( &"MP/SECURING_POSITION" );
        level.zone thread scripts\mp\gametypes\obj_zonecapture::hardpoint_setneutral();
        level.zone scripts\mp\gameobjects::cancontestclaim( 1 );
        
        if ( isdefined( level.matchrules_droptime ) && level.matchrules_droptime )
        {
            level thread scripts\mp\gametypes\grnd::randomdrops();
        }
        
        msg = level waittill_any_return_2( "zone_captured", "zone_destroyed" );
        
        if ( msg == "zone_destroyed" )
        {
            continue;
        }
        
        ownerteam = level.zone scripts\mp\gameobjects::getownerteam();
        scripts\mp\utility\sound::playsoundonplayers( "mp_hardpoint_captured_positive", ownerteam );
        scripts\mp\utility\sound::playsoundonplayers( "mp_hardpoint_captured_negative", getotherteam( ownerteam )[ 0 ] );
        level waittill( "zone_destroyed", destroy_team );
        
        if ( isdefined( destroy_team ) )
        {
            level.zone scripts\mp\gameobjects::setownerteam( destroy_team );
            continue;
        }
        
        level.zone scripts\mp\gameobjects::setownerteam( "none" );
        playsoundatpos( level.zone.trigger.origin, "jup_shared_zone_neutral_ping" );
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x2aad
// Size: 0x395
function initspawns()
{
    if ( !spawnlogic::function_bff229a11ecd1e34() )
    {
        spawnlogic::setactivespawnlogic( "Default", "Crit_Default", 1 );
    }
    
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2147483647, -2147483647, -2147483647 );
    spawnkey = "koth";
    
    if ( spawnlogic::function_b17bf43316b9fb08( spawnkey ) )
    {
        spawnlogic::function_afe4709b818e7c9e( spawnkey );
    }
    else
    {
        spawnlogic::addstartspawnpoints( "mp_koth_spawn_allies_start" );
        spawnlogic::addstartspawnpoints( "mp_koth_spawn_axis_start" );
        spawnlogic::addspawnpoints( game[ "attackers" ], "mp_koth_spawn_allies_start" );
        spawnlogic::addspawnpoints( game[ "defenders" ], "mp_koth_spawn_axis_start" );
        attackers = spawnlogic::getspawnpointarray( "mp_koth_spawn_allies_start" );
        defenders = spawnlogic::getspawnpointarray( "mp_koth_spawn_axis_start" );
        spawnlogic::registerspawnset( "start_attackers", attackers );
        spawnlogic::registerspawnset( "start_defenders", defenders );
        spawnlogic::addspawnpoints( "allies", "mp_koth_spawn", 1 );
        spawnlogic::addspawnpoints( "axis", "mp_koth_spawn", 1 );
        spawnlogic::addspawnpoints( "allies", "mp_koth_spawn_secondary", 1, 1 );
        spawnlogic::addspawnpoints( "axis", "mp_koth_spawn_secondary", 1, 1 );
        spawnlogic::registerspawnset( "primary", spawnlogic::getspawnpointarray( "mp_koth_spawn" ) );
        spawnlogic::registerspawnset( "fallback", spawnlogic::getspawnpointarray( "mp_koth_spawn_secondary" ) );
        
        if ( !isdefined( level.spawnpoints ) )
        {
            spawnlogic::addspawnpoints( "allies", "mp_tdm_spawn" );
            spawnlogic::addspawnpoints( "axis", "mp_tdm_spawn" );
            spawnlogic::addspawnpoints( "allies", "mp_tdm_spawn_secondary", 1, 1 );
            spawnlogic::addspawnpoints( "axis", "mp_tdm_spawn_secondary", 1, 1 );
            tdmspawns = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
            var_3d83bc62b320d11a = spawnlogic::getspawnpointarray( "mp_tdm_spawn_secondary" );
            spawnlogic::registerspawnset( "primary", tdmspawns );
            spawnlogic::registerspawnset( "fallback", var_3d83bc62b320d11a );
        }
        
        spawnlogic::function_48ed29b53fd72775();
    }
    
    level.mapcenter = spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    
    foreach ( zone in level.objectives )
    {
        zone.furthestspawndistsq = 0;
        zone.spawnpoints = [];
        zone.spawnpoints[ 0 ] = [];
        zone.spawnpoints[ 2 ] = [];
    }
    
    obj_zonecapture::function_4265173fd3869f34( 0, "primary", spawnkey );
    obj_zonecapture::function_4265173fd3869f34( 2, "fallback", spawnkey );
    
    foreach ( objid, zone in level.objectives )
    {
        zone.spawnset = "koth_" + objid;
        spawnlogic::registerspawnset( zone.spawnset, zone.spawnpoints[ 0 ] );
        zone.fallbackspawnset = "koth_fallback_" + objid;
        spawnlogic::registerspawnset( zone.fallbackspawnset, zone.spawnpoints[ 2 ] );
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 2
// Checksum 0x0, Offset: 0x2e4a
// Size: 0xdd, Type: bool
function comparezoneindexes( zone_a, zone_b )
{
    script_index_a = int( zone_a.objectivekey );
    script_index_b = int( zone_b.objectivekey );
    
    if ( !isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "<dev string:xe1>" + zone_a.origin + "<dev string:x111>" + zone_b.origin );
        return false;
    }
    
    if ( !isdefined( script_index_a ) && isdefined( script_index_b ) )
    {
        println( "<dev string:xe1>" + zone_a.origin );
        return true;
    }
    
    if ( isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "<dev string:xe1>" + zone_b.origin );
        return false;
    }
    
    if ( script_index_a > script_index_b )
    {
        return true;
    }
    
    return false;
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 1
// Checksum 0x0, Offset: 0x2f30
// Size: 0x97
function getzonearray( targetname )
{
    zones = getentarray( targetname, "targetname" );
    
    foreach ( z in zones )
    {
        z.objectivekey = z.script_label;
    }
    
    if ( !isdefined( zones ) || zones.size == 0 )
    {
        return undefined;
    }
    
    return utility::array_sort_with_func( zones, &comparezoneindexes );
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x2fd0
// Size: 0x169, Type: bool
function setupzones()
{
    primaryzones = getzonearray( "hardpoint_zone" );
    assertex( isdefined( primaryzones ) && primaryzones.size >= 3, "<dev string:x116>" );
    triggers = [];
    
    for ( index = 0; index < primaryzones.size ; index++ )
    {
        triggers[ triggers.size ] = primaryzones[ index ];
    }
    
    level.objectives = [];
    
    foreach ( trigger in triggers )
    {
        zone = scripts\mp\gametypes\obj_zonecapture::setupobjective( trigger, undefined, undefined, 1 );
        
        if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
        {
            zone.var_b8cc16dcaf5a0746 = scripts\mp\gametypes\mgl_mp::function_d91924619ae46b1f();
        }
        
        level.objectives[ zone.objectivekey ] = zone;
    }
    
    objid = scripts\mp\objidpoolmanager::requestreservedid( 1 );
    scripts\mp\objidpoolmanager::objective_set_play_intro( objid, 0 );
    scripts\mp\objidpoolmanager::objective_set_play_outro( objid, 0 );
    
    if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( objid, "done", ( 0, 0, 0 ), undefined, "icon_medium" );
    }
    else
    {
        scripts\mp\objidpoolmanager::objective_add_objective( objid, "done", ( 0, 0, 0 ) );
    }
    
    scripts\mp\objidpoolmanager::objective_playermask_showtoall( objid );
    return true;
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 1
// Checksum 0x0, Offset: 0x3142
// Size: 0x106
function setupzonecallouts( firstzone )
{
    areaid = undefined;
    zonetrigger = level.zone.visuals[ 0 ];
    
    if ( isdefined( zonetrigger.script_noteworthy ) )
    {
        areaid = level.calloutglobals.areaidmap[ zonetrigger.script_noteworthy ];
    }
    
    if ( !isdefined( areaid ) )
    {
        areaid = scripts\mp\callouts::function_45d5ee5f369ad604( zonetrigger );
    }
    
    if ( isdefined( areaid ) )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "ui_hp_callout_id", areaid );
        }
    }
    
    if ( !istrue( firstzone ) )
    {
        namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c( 4, "free" );
    }
    
    assertex( isdefined( areaid ), "<dev string:x147>" + zonetrigger.script_label + "<dev string:x155>" );
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x3250
// Size: 0x58
function forcespawnplayers()
{
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( !isdefined( player ) || isalive( player ) )
        {
            continue;
        }
        
        player notify( "force_spawn" );
        waitframe();
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x32b0
// Size: 0x13d
function getspawnpoint()
{
    var_2fa17baefe0fa286 = getkothzonedeadzonedist();
    spawnparams = scripts\mp\spawnfactor::function_75c03ed937b75b22( level.zone.trigger getentitynumber(), level.zone.furthestspawndistsq, var_2fa17baefe0fa286 * var_2fa17baefe0fa286, 12250000 );
    usingstartspawns = spawnlogic::shoulduseteamstartspawn();
    
    if ( !isdefined( level.switchedtohardpointspawnlogic ) && !spawnlogic::function_bff229a11ecd1e34() && !usingstartspawns )
    {
        level.switchedtohardpointspawnlogic = 1;
        spawnlogic::setactivespawnlogic( "Hardpoint", "Crit_Default" );
    }
    
    if ( spawnlogic::function_bff229a11ecd1e34() )
    {
        factor_set = #"default";
        
        if ( usingstartspawns )
        {
            factor_set = #"start";
        }
        
        if ( !spawnlogic::isactivespawnlogic( factor_set ) )
        {
            spawnlogic::setactivespawnlogic( factor_set );
        }
    }
    
    if ( usingstartspawns )
    {
        return spawnlogic::function_8be1c339876506b9( self, "start", self.pers[ "team" ], spawnparams );
    }
    
    return spawnlogic::getspawnpoint( self, self.pers[ "team" ], level.zone.spawnset, level.zone.fallbackspawnset, 2, spawnparams );
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x33f6
// Size: 0x5
function getkothzonedeadzonedist()
{
    return 1000;
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 1
// Checksum 0x0, Offset: 0x3404
// Size: 0x3a
function onspawnplayer( revivespawn )
{
    scripts\mp\utility\lower_message::setlowermessageomnvar( "clear_lower_msg" );
    self.forcespawnnearteammates = undefined;
    thread updatematchstatushintonspawn();
    
    if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
    {
        thread scripts\mp\gametypes\mgl_mp::function_f9ae07213a0af3de();
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 1
// Checksum 0x0, Offset: 0x3446
// Size: 0xc9
function movezoneaftertime( time )
{
    level endon( "game_ended" );
    level endon( "zone_reset" );
    level endon( "dev_force_zone" );
    level.zonemovetime = time;
    level.zonedestroyedbytimer = 0;
    scripts\mp\gametypes\obj_zonecapture::zonetimerwait();
    objid = 1;
    level scripts\mp\objidpoolmanager::returnreservedobjectiveid( objid, 0 );
    
    if ( objective_isunlimited() )
    {
        objid = scripts\mp\objidpoolmanager::requestreservedid( objid );
    }
    
    level scripts\mp\objidpoolmanager::update_objective_state( objid, "done" );
    level scripts\mp\objidpoolmanager::update_objective_position( objid, level.futurezone.visuals[ 0 ].origin + level.futurezone.offset3d );
    level.zonedestroyedbytimer = 1;
    level notify( "zone_moved" );
    level notify( "zone_destroyed" );
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 10
// Checksum 0x0, Offset: 0x3517
// Size: 0x30c
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    if ( !isplayer( attacker ) || attacker.team == self.team )
    {
        return;
    }
    
    if ( attacker == self )
    {
        return;
    }
    
    if ( !isdefined( level.zone ) )
    {
        return;
    }
    
    ownerteam = level.zone.ownerteam;
    
    if ( !isdefined( ownerteam ) )
    {
        return;
    }
    
    if ( isdefined( objweapon ) && iskillstreakweapon( objweapon.basename ) )
    {
        return;
    }
    
    victim = self;
    var_9ff9376383f4bc58 = 0;
    attackerteam = attacker.team;
    var_229449cfd54fdc5b = attacker istouching( level.zone.trigger );
    var_9d0123af024e86ac = victim istouching( level.zone.trigger );
    
    if ( attackerteam != ownerteam )
    {
        if ( level.zonecapturetime > 0 && var_229449cfd54fdc5b )
        {
            attacker thread function_e3e3e81453fd788b( #"capture_kill" );
            attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648( 11, 1 );
        }
        else if ( var_9d0123af024e86ac )
        {
            attacker thread scripts\mp\rank::scoreeventpopup( #"assault" );
            attacker thread scripts\mp\utility\points::doscoreevent( #"mode_x_assault" );
            attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648( 11, 1 );
            thread utility::trycall( level.matchdata_logvictimkillevent, killid, "defending" );
        }
        
        return;
    }
    
    if ( var_229449cfd54fdc5b )
    {
        value = level.zone.objectivekey;
        var_f6ddbb71b889a0be = [ "_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i" ];
        
        if ( !array_contains( var_f6ddbb71b889a0be, value ) )
        {
            value = var_f6ddbb71b889a0be[ int( value ) ];
        }
        
        attacker thread scripts\mp\rank::scoreeventpopup( #"defend", value );
        attacker thread scripts\mp\utility\points::doscoreevent( #"mode_x_defend", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, { #extraparam:level.zone.objectivekey } );
        attacker incpersstat( "defends", 1 );
        attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648( 11, 1 );
        attacker scripts\mp\persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
        attacker setextrascore1( attacker.pers[ "defends" ] );
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 6
// Checksum 0x0, Offset: 0x382b
// Size: 0x507
function give_capture_credit( touchlist, capturetime, capture_team, lastcaptureteam, credit_player, gameobject )
{
    level endon( "game_ended" );
    level.lastcaptime = gettime();
    logannouncement( credit_player, undefined, "Hardpoint Captured", credit_player.origin );
    first_player = credit_player;
    var_2307a154949bbf43 = credit_player;
    
    if ( !isdefined( first_player.lastcaptime ) )
    {
        timesincelastcap = 10000;
    }
    else
    {
        timesincelastcap = gettime() - first_player.lastcaptime;
    }
    
    first_player.lastcaptime = gettime();
    first_player = scripts\mp\gameobjects::function_15a05ddc354746a2( first_player );
    
    if ( isplayer( first_player ) )
    {
        var_7e2c53b0bcf117d9 = spawnstruct();
        var_7e2c53b0bcf117d9.player = first_player;
        var_7e2c53b0bcf117d9.eventname = "capture";
        var_7e2c53b0bcf117d9.position = first_player.origin;
        scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_on_game_event", var_7e2c53b0bcf117d9 );
        
        if ( isexcessivescoreboosting( first_player ) && !isanymlgmatch() )
        {
        }
        else if ( timesincelastcap < 2100 && gettime() - first_player.lastkilltime > 2100 )
        {
            if ( var_2307a154949bbf43 != first_player )
            {
                first_player thread scripts\mp\utility\points::doscoreevent( #"hash_527aee59bf6f0079" );
            }
            else
            {
                first_player thread scripts\mp\rank::scoreeventpopup( #"hp_secure" );
                first_player thread scripts\mp\utility\points::doscoreevent( #"mode_hp_secure_tiny" );
            }
        }
        else if ( !isscoreboosting( first_player ) )
        {
            if ( var_2307a154949bbf43 != first_player )
            {
                first_player thread scripts\mp\utility\points::doscoreevent( #"hash_36af03684ac64eb8" );
            }
            else
            {
                first_player thread scripts\mp\rank::scoreeventpopup( #"hp_secure" );
                first_player thread scripts\mp\utility\points::doscoreevent( #"mode_hp_secure" );
            }
        }
        else if ( var_2307a154949bbf43 != first_player )
        {
            first_player thread scripts\mp\utility\points::doscoreevent( #"hash_527aee59bf6f0079" );
        }
        else
        {
            first_player thread scripts\mp\rank::scoreeventpopup( #"hp_secure" );
            first_player thread scripts\mp\utility\points::doscoreevent( #"mode_hp_secure_reduced" );
        }
        
        if ( isdefined( level.zone.lastactivatetime ) && gettime() - level.zone.lastactivatetime <= 2100 )
        {
            if ( var_2307a154949bbf43 != first_player )
            {
                first_player thread scripts\mp\utility\points::doscoreevent( #"hp_quick_cap_capture_bot" );
            }
            else
            {
                first_player thread scripts\mp\rank::scoreeventpopup( #"hp_quick_cap" );
                first_player thread scripts\mp\utility\points::doscoreevent( #"mode_hp_quick_cap" );
            }
        }
        
        if ( first_player.lastkilltime + 500 > gettime() )
        {
        }
        else
        {
            first_player scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap( first_player );
        }
    }
    
    players = getarraykeys( touchlist );
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = touchlist[ players[ i ] ].player;
        var_64656a8b87eaae16 = touchlist[ players[ i ] ].player;
        player = scripts\mp\gameobjects::function_15a05ddc354746a2( player );
        player updatecapsperminute( lastcaptureteam );
        
        if ( !isscoreboosting( player ) )
        {
            player incpersstat( "captures", 1 );
            player scripts\mp\persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
        }
        else
        {
            /#
                player iprintlnbold( "<dev string:x1ca>" );
            #/
        }
        
        if ( first_player != player )
        {
            if ( var_64656a8b87eaae16 != player )
            {
                player thread scripts\mp\utility\points::doscoreevent( #"hash_70c24ce7e0579e7a" );
            }
            else
            {
                player thread scripts\mp\rank::scoreeventpopup( #"capture_assist" );
                player thread scripts\mp\utility\points::doscoreevent( #"mode_dom_secure_assist" );
            }
            
            scripts\cp_mp\challenges::function_90d26b6dc5331196( player );
            player scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap( player );
        }
        
        wait 0.05;
    }
    
    if ( isdefined( gameobject.assisttouchlist ) )
    {
        if ( gameobject.assisttouchlist[ capture_team ].size > 0 )
        {
            var_9eb80458ef362367 = getarraykeys( gameobject.assisttouchlist[ capture_team ] );
            
            foreach ( id in players )
            {
                foreach ( assistid in var_9eb80458ef362367 )
                {
                    if ( assistid == id )
                    {
                        gameobject.assisttouchlist[ capture_team ][ assistid ] = undefined;
                    }
                }
            }
        }
        
        if ( gameobject.assisttouchlist[ capture_team ].size > 0 )
        {
            gameobject thread function_9c5c0e02b3615275( capture_team );
        }
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 1
// Checksum 0x0, Offset: 0x3d3a
// Size: 0x153
function function_9c5c0e02b3615275( team )
{
    level endon( "game_ended" );
    var_9eb80458ef362367 = getarraykeys( self.assisttouchlist[ team ] );
    
    if ( var_9eb80458ef362367.size > 0 )
    {
        for ( index = 0; index < var_9eb80458ef362367.size ; index++ )
        {
            var_6c7881393d098340 = self.assisttouchlist[ team ][ var_9eb80458ef362367[ index ] ];
            var_8a11b26acefd3594 = var_6c7881393d098340.var_d96989d14549fd76;
            
            if ( var_8a11b26acefd3594 )
            {
                if ( isdefined( var_6c7881393d098340.owner ) )
                {
                    player = var_6c7881393d098340.owner;
                }
                else
                {
                    player = undefined;
                }
            }
            else
            {
                player = var_6c7881393d098340.player;
            }
            
            if ( isdefined( player ) )
            {
                player incpersstat( "captures", 1 );
                player scripts\mp\persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
                
                if ( var_8a11b26acefd3594 )
                {
                    player thread scripts\mp\utility\points::doscoreevent( #"hash_70c24ce7e0579e7a" );
                }
                else
                {
                    player thread scripts\mp\rank::scoreeventpopup( #"capture_assist" );
                    player thread scripts\mp\utility\points::doscoreevent( #"mode_dom_secure_assist" );
                }
                
                scripts\cp_mp\challenges::function_90d26b6dc5331196( player );
                player scripts\mp\gametypes\obj_zonecapture::setcrankedtimerzonecap( player );
            }
            
            self.assisttouchlist[ team ][ var_9eb80458ef362367[ index ] ] = undefined;
            wait 0.05;
        }
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x3e95
// Size: 0x406
function awardcapturepoints()
{
    level endon( "game_ended" );
    level endon( "zone_reset" );
    level endon( "zone_moved" );
    level notify( "awardCapturePointsRunning" );
    level endon( "awardCapturePointsRunning" );
    seconds = 1;
    
    while ( !level.gameended )
    {
        for ( waittime = 0; waittime < seconds && !level.gameended ; waittime = 0 )
        {
            wait level.framedurationseconds;
            scripts\mp\hostmigration::waittillhostmigrationdone();
            waittime += level.framedurationseconds;
            
            if ( level.zone.stalemate )
            {
            }
        }
        
        team = level.zone scripts\mp\gameobjects::getownerteam();
        
        if ( team == "neutral" )
        {
            continue;
        }
        
        if ( level.gameended )
        {
            break;
        }
        
        if ( !level.zone.stalemate && !level.gameended )
        {
            score = 1;
            scoremultiplier = 1;
            
            if ( level.zoneadditivescoring )
            {
                score = level.zone.touchlist[ team ].size;
            }
            
            foreach ( object in level.zone.touchlist[ team ] )
            {
                currplayer = object.player;
                var_64656a8b87eaae16 = object.player;
                currplayer = scripts\mp\gameobjects::function_15a05ddc354746a2( currplayer );
                currplayer incpersstat( "objTime", 1 );
                currplayer function_48544e365f4f5648( 0, 1 );
                var_7c01e84ef860ccbd = "obj" + level.zone.trigger.script_label + "Time";
                
                if ( isdefined( currplayer.pers[ var_7c01e84ef860ccbd ] ) )
                {
                    currplayer incpersstat( var_7c01e84ef860ccbd, 1 );
                }
                
                if ( isdefined( currplayer.timebyrotation[ level.kothhillrotation ] ) )
                {
                    currplayer.timebyrotation[ level.kothhillrotation ]++;
                }
                else
                {
                    currplayer.timebyrotation[ level.kothhillrotation ] = 1;
                }
                
                currplayer scripts\mp\persistence::statsetchild( "round", "objTime", currplayer.pers[ "objTime" ] );
                currplayer setextrascore0( currplayer.pers[ "objTime" ] );
                
                if ( isdefined( currplayer.var_bd0feb635eed5b60 ) && currplayer.var_bd0feb635eed5b60 > 3 )
                {
                    currplayer.var_bd0feb635eed5b60 = 0;
                    
                    if ( getbasegametype() == "koth" )
                    {
                        if ( var_64656a8b87eaae16 != currplayer )
                        {
                            currplayer thread doscoreevent( #"hash_fa8cc32ce86849b6" );
                        }
                        else
                        {
                            currplayer thread doscoreevent( #"hash_61e7451e5d97d089" );
                        }
                        
                        scripts\cp_mp\challenges::function_183b2d4a1ccd46b3( currplayer );
                    }
                    else if ( getgametype() == "grnd" )
                    {
                        currplayer thread doscoreevent( #"hash_7e236756fb6f7c1a", undefined, 15 );
                    }
                }
                else
                {
                    if ( !isdefined( currplayer.var_bd0feb635eed5b60 ) )
                    {
                        currplayer.var_bd0feb635eed5b60 = 0;
                    }
                    else
                    {
                        currplayer.var_bd0feb635eed5b60++;
                    }
                    
                    if ( var_64656a8b87eaae16 != currplayer )
                    {
                        currplayer scripts\mp\gamescore::giveplayerscore( #"hash_fa8cc32ce86849b6", 3 );
                    }
                    else
                    {
                        currplayer scripts\mp\gamescore::giveplayerscore( #"hash_61e7451e5d97d089", 10 );
                    }
                }
                
                if ( getdvarint( @"hash_4753586a2ac8718f", 0 ) == 1 )
                {
                    if ( scoremultiplier < currplayer getclientomnvar( "ui_voxel_head_size" ) )
                    {
                        scoremultiplier = currplayer getclientomnvar( "ui_voxel_head_size" );
                        score *= scoremultiplier;
                    }
                }
            }
            
            scripts\mp\gamescore::giveteamscoreforobjective( team, score, 0 );
        }
        
        if ( istrue( level.var_9028202fb295d21 ) )
        {
            scripts\mp\gamelogic::default_ontimelimit();
        }
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 1
// Checksum 0x0, Offset: 0x42a3
// Size: 0xcb
function updatecapsperminute( lastownerteam )
{
    if ( !isdefined( self.capsperminute ) )
    {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    
    if ( !isdefined( lastownerteam ) || lastownerteam == "neutral" )
    {
        return;
    }
    
    self.numcaps++;
    minutespassed = gettimepassed() / 60000;
    
    if ( isplayer( self ) && isdefined( self.timeplayed[ "total" ] ) )
    {
        minutespassed = self.timeplayed[ "total" ] / 60;
    }
    
    self.capsperminute = self.numcaps / minutespassed;
    
    if ( self.capsperminute > self.numcaps )
    {
        self.capsperminute = self.numcaps;
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 1
// Checksum 0x0, Offset: 0x4376
// Size: 0x29, Type: bool
function isscoreboosting( player )
{
    return isdefined( player.capsperminute ) && player.capsperminute > 3;
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 1
// Checksum 0x0, Offset: 0x43a8
// Size: 0x29, Type: bool
function isexcessivescoreboosting( player )
{
    return isdefined( player.capsperminute ) && player.capsperminute > 5;
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 1
// Checksum 0x0, Offset: 0x43da
// Size: 0x139
function onplayerconnect( player )
{
    player._hardpointeffect = [];
    player.numcaps = 0;
    player.capsperminute = 0;
    player.timebyrotation = [];
    player setextrascore0( 0 );
    
    if ( isdefined( player.pers[ "objTime" ] ) )
    {
        player setextrascore0( player.pers[ "objTime" ] );
    }
    
    player setextrascore1( 0 );
    
    if ( isdefined( player.pers[ "defends" ] ) )
    {
        player setextrascore1( player.pers[ "defends" ] );
    }
    
    if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
    {
        player thread scripts\mp\gametypes\mgl_mp::function_8bb13aa2a5d32576( player, "mp_gametype_koth_mgl_match_introduction" );
    }
    
    thread onplayerspawned( player );
    
    foreach ( zone in level.objectives )
    {
        if ( istrue( level.usehpzonebrushes ) )
        {
            zone scripts\mp\gametypes\obj_zonecapture::hideplayerspecificbrushes( player );
        }
    }
    
    player thread refreshfreecamhardpointfx();
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 1
// Checksum 0x0, Offset: 0x451b
// Size: 0xa9
function onplayerspawned( player )
{
    while ( true )
    {
        player waittill( "spawned" );
        
        foreach ( zone in level.objectives )
        {
            if ( istrue( zone.active ) )
            {
                if ( zone.ownerteam == "neutral" )
                {
                    zone scripts\mp\gametypes\obj_zonecapture::playhardpointneutralfx();
                    continue;
                }
                
                zone scripts\mp\gametypes\obj_zonecapture::showcapturedhardpointeffecttoplayer( zone.ownerteam, player );
            }
        }
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 2
// Checksum 0x0, Offset: 0x45cc
// Size: 0x9b
function updateservericons( state, contested )
{
    omnvarval = -1;
    
    if ( contested )
    {
        omnvarval = -2;
    }
    else if ( isgameplayteam( state ) )
    {
        player = thread getownerteamplayer( state );
        
        if ( isdefined( player ) )
        {
            omnvarval = player getentitynumber();
        }
    }
    else
    {
        switch ( state )
        {
            case #"hash_3bf8ec5fe1d42da8":
                omnvarval = -3;
                break;
            case #"hash_c312107e6bce703c":
            default:
                break;
        }
    }
    
    setomnvar( "ui_hardpoint", omnvarval );
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 1
// Checksum 0x0, Offset: 0x466f
// Size: 0x79
function getownerteamplayer( ownerteam )
{
    ownerplayer = undefined;
    
    foreach ( player in level.players )
    {
        if ( player.team == ownerteam )
        {
            ownerplayer = player;
            break;
        }
    }
    
    return ownerplayer;
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x46f1
// Size: 0xb2
function refreshfreecamhardpointfx()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, view );
        
        if ( channel == "mlg_view_change" )
        {
            foreach ( zone in level.objectives )
            {
                if ( zone.ownerteam != "neutral" )
                {
                    zone scripts\mp\gametypes\obj_zonecapture::showcapturedhardpointeffecttoplayer( zone.ownerteam, self );
                }
            }
        }
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x47ab
// Size: 0x76
function getrespawndelay()
{
    if ( !istrue( level.delayplayer ) )
    {
        return undefined;
    }
    
    if ( isdefined( level.spawndelay ) && level.spawndelay > 0 )
    {
        if ( isdefined( level.zone.ownerteam ) && self.pers[ "team" ] == level.zone.ownerteam )
        {
            return level.spawndelay;
        }
    }
    
    return undefined;
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x482a
// Size: 0x11
function writeplayerrotationscoretomatchdataongameend()
{
    level waittill( "game_ended" );
    writecurrentrotationteamscore();
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x4843
// Size: 0x4d
function writecurrentrotationteamscore()
{
    if ( level.kothhillrotation < 24 )
    {
        setmatchdata( "alliesRoundScore", level.kothhillrotation, getteamscore( "allies" ) );
        setmatchdata( "axisRoundScore", level.kothhillrotation, getteamscore( "axis" ) );
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x4898
// Size: 0x11a
function setkothwaypoints()
{
    scripts\mp\gamelogic::setwaypointiconinfo( "koth_destroy", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_koth", 0, 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "koth_defend", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_koth", 0, 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "koth_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_koth", 0, 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "koth_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_koth", 0, 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "koth_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_koth", 0, 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "koth_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_koth", 0, 1 );
    scripts\mp\gamelogic::setwaypointiconinfo( "koth_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 2 );
    scripts\mp\gamelogic::setwaypointiconinfo( "koth_next", 0, "neutral", "MP_INGAME_ONLY/OBJ_NEXT_CAPS", "icon_waypoint_locked", 0, 2 );
    scripts\mp\gamelogic::setwaypointiconinfo( "koth_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_DESTROYING_CAPS", "icon_waypoint_koth", 1, 1 );
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x49ba
// Size: 0x31
function updatematchstatushintonspawn()
{
    level endon( "game_ended" );
    
    if ( istrue( level.zoneislocked ) )
    {
        scripts\mp\hud_message::function_f004ef4606b9efdc( "koth_control" );
        return;
    }
    
    scripts\mp\hud_message::function_f004ef4606b9efdc( "koth_capture" );
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x49f3
// Size: 0x20
function function_fab770bfe4b14e75()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "zone_moved" );
        function_94ae9bf19d8942d9();
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x4a1b
// Size: 0x5a
function function_94ae9bf19d8942d9()
{
    foreach ( player in level.players )
    {
        player scripts\mp\codcasterclientmatchdata::function_1882f80b14421089( 3, 1 );
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x4a7d
// Size: 0x122
function function_69c581621849df52()
{
    level endon( "game_ended" );
    level endon( "stop_contested_stats_thread" );
    level endon( "zone_moved" );
    level endon( "zone_destroyed" );
    timeincrement = level.framedurationseconds;
    zone = self;
    
    while ( true )
    {
        waitframe();
        
        foreach ( team in level.teamnamelist )
        {
            foreach ( object in zone.touchlist[ team ] )
            {
                player = object.player;
                
                if ( isdefined( player.owner ) )
                {
                    player = player.owner;
                }
                
                if ( isdefined( player ) )
                {
                    player function_1882f80b14421089( 5, timeincrement );
                }
            }
        }
    }
}

// Namespace koth / scripts\mp\gametypes\koth
// Params 0
// Checksum 0x0, Offset: 0x4ba7
// Size: 0x4b
function function_1134d3068749d68e()
{
    if ( istrue( level.var_9028202fb295d21 ) )
    {
        return;
    }
    
    winner = scripts\mp\gamescore::gethighestscoringteam();
    
    if ( winner != "tie" )
    {
        scripts\mp\gamelogic::default_ontimelimit();
        return;
    }
    
    scripts\mp\hud_message::showerrormessagetoallplayers( "MP_INGAME_ONLY/KOTH_OVERTIME_WARNING" );
    level.var_9028202fb295d21 = 1;
}

/#

    // Namespace koth / scripts\mp\gametypes\koth
    // Params 3
    // Checksum 0x0, Offset: 0x4bfa
    // Size: 0xa4, Type: dev
    function drawpoint( org, size, color )
    {
        for ( i = 0; i < 10 ; i++ )
        {
            a1 = i / 10 * 360;
            a2 = ( i + 1 ) / 10 * 360;
            pt1 = org + ( cos( a1 ), sin( a1 ), 0 ) * size;
            pt2 = org + ( cos( a2 ), sin( a2 ), 0 ) * size;
            line( pt1, pt2, color );
        }
    }

    // Namespace koth / scripts\mp\gametypes\koth
    // Params 0
    // Checksum 0x0, Offset: 0x4ca6
    // Size: 0x2f8, Type: dev
    function kothdebug()
    {
        while ( true )
        {
            if ( getdvar( @"hash_657c47f657a0023c" ) != "<dev string:x212>" )
            {
                wait 2;
                continue;
            }
            
            while ( true )
            {
                if ( getdvar( @"hash_657c47f657a0023c" ) != "<dev string:x212>" )
                {
                    break;
                }
                
                if ( !isdefined( level.players ) || level.players.size <= 0 )
                {
                    wait 0.05;
                    continue;
                }
                
                bestdistsq = 999999999;
                bestradio = level.radios[ 0 ];
                
                foreach ( radio in level.radios )
                {
                    distsq = distancesquared( radio.origin, level.players[ 0 ].origin );
                    
                    if ( distsq < bestdistsq )
                    {
                        bestdistsq = distsq;
                        bestradio = radio;
                    }
                }
                
                foreach ( radio in level.radios )
                {
                    if ( radio != bestradio )
                    {
                        drawpoint( radio.origin, 50, ( 0.5, 0.5, 0.5 ) );
                    }
                }
                
                radio = bestradio;
                drawpoint( radio.origin, 100, ( 1, 1, 1 ) );
                
                foreach ( spawnpoint in radio.outerspawns )
                {
                    line( radio.origin, spawnpoint.origin, ( 1, 0.5, 0.5 ) );
                    drawpoint( spawnpoint.origin, 20, ( 1, 0.5, 0.5 ) );
                }
                
                foreach ( spawnpoint in radio.nearspawns )
                {
                    line( radio.origin + ( 0, 0, 10 ), spawnpoint.origin + ( 0, 0, 10 ), ( 0.5, 1, 0.5 ) );
                    drawpoint( spawnpoint.origin, 30, ( 0.5, 1, 0.5 ) );
                }
                
                wait 0.05;
            }
        }
    }

    // Namespace koth / scripts\mp\gametypes\koth
    // Params 0
    // Checksum 0x0, Offset: 0x4fa6
    // Size: 0x75, Type: dev
    function function_1f98c5616d8b3d67()
    {
        self endon( "<dev string:x217>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_4806172df45de691" ) != 0 )
            {
                level notify( "<dev string:x225>" );
                level.zoneduration = 10000;
                break;
            }
            
            wait 1;
        }
        
        thread movezoneaftertime( level.zoneduration );
        level.var_2db03438253fa6e2 = 1;
        setdevdvar( @"hash_4806172df45de691", 0 );
        thread function_1f98c5616d8b3d67();
    }

    // Namespace koth / scripts\mp\gametypes\koth
    // Params 0
    // Checksum 0x0, Offset: 0x5023
    // Size: 0xb1, Type: dev
    function function_bed0f399bee034f8()
    {
        self endon( "<dev string:x217>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_796deaab0da995a1" ) != 0 )
            {
                level notify( "<dev string:x225>" );
                level.zoneduration = 1;
                break;
            }
            
            wait 1;
        }
        
        thread movezoneaftertime( level.zoneduration );
        setdevdvar( @"hash_796deaab0da995a1", 0 );
        
        if ( isdefined( level.var_2db03438253fa6e2 ) && level.var_2db03438253fa6e2 )
        {
            level.zoneduration = 10000;
        }
        else
        {
            level.zoneduration = getdvarint( @"hash_cb81f537c99c9657" );
        }
        
        thread function_bed0f399bee034f8();
        self notify( "<dev string:x237>" );
    }

    // Namespace koth / scripts\mp\gametypes\koth
    // Params 0
    // Checksum 0x0, Offset: 0x50dc
    // Size: 0x7f, Type: dev
    function function_ef4f5aa9c42838b2()
    {
        self endon( "<dev string:x217>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_4c260c16d548430f" ) != 0 )
            {
                level notify( "<dev string:x225>" );
                level.zoneduration = getdvarint( @"hash_cb81f537c99c9657" );
                break;
            }
            
            wait 1;
        }
        
        thread movezoneaftertime( level.zoneduration );
        level.var_2db03438253fa6e2 = 0;
        setdevdvar( @"hash_4c260c16d548430f", 0 );
        thread function_ef4f5aa9c42838b2();
    }

    // Namespace koth / scripts\mp\gametypes\koth
    // Params 0
    // Checksum 0x0, Offset: 0x5163
    // Size: 0x25b, Type: dev
    function function_be67fb2ebcca86d1()
    {
        self endon( "<dev string:x217>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_c000ec9a5a2f4b6c" ) != 0 )
            {
                setdevdvar( @"hash_4806172df45de691", 1 );
                level.zoneduration = 10000;
                level.var_2db03438253fa6e2 = 1;
                thread movezoneaftertime( level.zoneduration );
                level notify( "<dev string:x24f>" );
                
                foreach ( zone in level.objectives )
                {
                    if ( isdefined( zone.neutralhardpointfx ) && zone.neutralhardpointfx.size > 0 )
                    {
                        foreach ( hpvfx in zone.neutralhardpointfx )
                        {
                            zone.neutralhardpointfx = array_remove( zone.neutralhardpointfx, hpvfx );
                            
                            if ( isdefined( hpvfx ) )
                            {
                                hpvfx delete();
                            }
                        }
                    }
                    
                    zone.neutralhardpointfx = [];
                    
                    for ( i = 1; i < zone.visuals.size ; i++ )
                    {
                        fxfwd = anglestoforward( zone.visuals[ i ].angles );
                        zone.neutralhardpointfx[ zone.neutralhardpointfx.size ] = spawnfx( level.hardpointfxid[ "<dev string:x264>" ], zone.visuals[ i ].baseorigin, fxfwd );
                        zone.neutralhardpointfx[ zone.neutralhardpointfx.size - 1 ] setfxkilldefondelete();
                        triggerfx( zone.neutralhardpointfx[ zone.neutralhardpointfx.size - 1 ] );
                    }
                    
                    zone scripts\mp\gameobjects::setobjectivestatusicons( level.iconneutral );
                    zone scripts\mp\gameobjects::setvisibleteam( "<dev string:x26f>" );
                }
            }
            
            setdevdvar( @"hash_c000ec9a5a2f4b6c", 0 );
            wait 1;
        }
    }

    // Namespace koth / scripts\mp\gametypes\koth
    // Params 0
    // Checksum 0x0, Offset: 0x53c6
    // Size: 0xa4, Type: dev
    function function_b4c2563f73b02c80()
    {
        self endon( "<dev string:x217>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_46a6b424af6acbc2" ) != 0 )
            {
                scripts\mp\gamescore::giveteamscoreforobjective( "<dev string:x276>", getdvarint( @"hash_46a6b424af6acbc2" ), 0 );
                break;
            }
            else if ( getdvarint( @"hash_86e14326e43c0115" ) != 0 )
            {
                scripts\mp\gamescore::giveteamscoreforobjective( "<dev string:x280>", getdvarint( @"hash_86e14326e43c0115" ), 0 );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"hash_46a6b424af6acbc2", 0 );
        setdevdvar( @"hash_86e14326e43c0115", 0 );
        thread function_b4c2563f73b02c80();
    }

    // Namespace koth / scripts\mp\gametypes\koth
    // Params 0
    // Checksum 0x0, Offset: 0x5472
    // Size: 0x1f5, Type: dev
    function function_97b50111eebb7239()
    {
        while ( true )
        {
            if ( !isdefined( level.players ) )
            {
                waitframe();
                continue;
            }
            
            if ( isdefined( level.players ) && level.players.size == 0 )
            {
                waitframe();
                continue;
            }
            
            if ( !isdefined( level.var_385d55b55c63b8e2 ) )
            {
                foreach ( player in level.players )
                {
                    if ( !player isplayerheadless() )
                    {
                        level.var_385d55b55c63b8e2 = player;
                        break;
                    }
                }
            }
            
            if ( !isdefined( level.var_8812f1aff8df05d4 ) && isdefined( level.var_385d55b55c63b8e2 ) )
            {
                foreach ( player in level.players )
                {
                    if ( player isplayerheadless() && isalive( player ) && istrue( player.hasspawned ) && !is_equal( player.pers[ "<dev string:x288>" ], level.var_385d55b55c63b8e2.pers[ "<dev string:x288>" ] ) )
                    {
                        wait 1;
                        level.var_8812f1aff8df05d4 = player;
                        break;
                    }
                }
            }
            
            if ( isdefined( level.var_8812f1aff8df05d4 ) && isalive( level.var_8812f1aff8df05d4 ) )
            {
                level.var_8812f1aff8df05d4 setorigin( ( 2556.19, 5259.61, 192 ) );
            }
            
            wait 0.25;
            
            if ( isdefined( level.var_8812f1aff8df05d4 ) && isalive( level.var_8812f1aff8df05d4 ) )
            {
                level.var_8812f1aff8df05d4 setorigin( ( 2581.96, 5046.65, 192 ) );
            }
            
            wait 0.25;
        }
    }

#/
