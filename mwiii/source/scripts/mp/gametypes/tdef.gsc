#using script_548072087c9fd504;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;

#namespace tdef;

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0xc75
// Size: 0x3d9
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    level.defenderflag_starts = [];
    var_58553518a66cebe9 = getentarray( "cyber_emp_pickup_trig", "targetname" );
    
    foreach ( trig in var_58553518a66cebe9 )
    {
        level.defenderflag_starts[ level.defenderflag_starts.size ] = trig.origin;
    }
    
    level.defenderflag_bflagstart = ( 0, 0, 0 );
    primaryflags = getentarray( "flag_primary", "targetname" );
    
    foreach ( flag in primaryflags )
    {
        if ( flag.script_label == "_b" )
        {
            level.defenderflag_bflagstart = flag.origin;
            break;
        }
    }
    
    allowed[ 0 ] = getgametype();
    allowed[ 1 ] = "tdm";
    scripts\mp\gameobjects::main( allowed );
    
    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = &initializematchrules;
        [[ level.initializematchrules ]]();
        level thread reinitializematchrulesonmigration();
    }
    else
    {
        registerroundswitchdvar( getgametype(), 0, 0, 9 );
        registertimelimitdvar( getgametype(), 10 );
        registerscorelimitdvar( getgametype(), 7500 );
        registerroundlimitdvar( getgametype(), 1 );
        registerwinlimitdvar( getgametype(), 1 );
        registernumlivesdvar( getgametype(), 0 );
        registerhalftimedvar( getgametype(), 0 );
        setdynamicdvar( @"hash_8e6448164d6909cb", 1 );
        setdynamicdvar( @"hash_92904d1a8261b677", 60 );
        level.matchrules_enemyflagradar = 1;
        level.matchrules_damagemultiplier = 0;
        level.matchrules_vampirism = 0;
    }
    
    level.carrierarmor = 100;
    updategametypedvars();
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onplayerkilled = &onplayerkilled;
    level.onrespawndelay = &getrespawndelay;
    level.defenderflagreset = 1;
    level.defenderflagbases = [];
    level.scorefrozenuntil = 0;
    level.defenderflagpickupscorefrozen = 0;
    
    if ( scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924() )
    {
        game[ "dialog" ][ "gametype" ] = "iw9_tdef_mode_uktl_tdt1";
    }
    else
    {
        game[ "dialog" ][ "gametype" ] = "gametype_defender";
    }
    
    game[ "strings" ][ "overtime_hint" ] = &"MP/FIRST_BLOOD";
    game[ "bomb_dropped_sound" ] = "iw9_mp_ui_objective_lost";
    game[ "bomb_recovered_sound" ] = "iw9_mp_ui_objective_taken";
    game[ "dialog" ][ "offense_obj" ] = "boost_tdm";
    game[ "dialog" ][ "defense_obj" ] = "boost_tdm";
    game[ "dialog" ][ "flag_dropped" ] = "ourblitzflag_drop";
    game[ "dialog" ][ "flag_returned" ] = "ourflag_return";
    game[ "dialog" ][ "flag_getback" ] = "ourblitzflag_getback";
    game[ "dialog" ][ "enemy_flag_taken" ] = "ourblitzflag_taken";
    game[ "dialog" ][ "enemy_flag_dropped" ] = "enemyblitzflag_drop";
    game[ "dialog" ][ "enemy_flag_returned" ] = "ourblitzflag_return";
    setomnvar( "ui_single_flag_loc", -2 );
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x1056
// Size: 0x1bc
function initializematchrules()
{
    setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_1cc0d66c46db96d6", getmatchrulesdata( "tdefData", "ppkTeamNoFlag" ) );
    setdynamicdvar( @"hash_1aa7e0f1a1007031", getmatchrulesdata( "tdefData", "ppkTeamWithFlag" ) );
    setdynamicdvar( @"hash_c896b59425076b7c", getmatchrulesdata( "tdefData", "ppkFlagCarrier" ) );
    setdynamicdvar( @"hash_b5878f8ab2eaa223", getmatchrulesdata( "tdefData", "scoringTime" ) );
    setdynamicdvar( @"hash_db9cb11c88c0328d", getmatchrulesdata( "tdefData", "scorePerTick" ) );
    setdynamicdvar( @"hash_b61c1981eeaad777", getmatchrulesdata( "tdefData", "carrierBonusTime" ) );
    setdynamicdvar( @"hash_48eda09982a74dac", getmatchrulesdata( "tdefData", "carrierBonusScore" ) );
    setdynamicdvar( @"hash_c429e9dec8a0dc33", getmatchrulesdata( "tdefData", "spawnDelay" ) );
    setdynamicdvar( @"hash_53c09e0944fb50da", getmatchrulesdata( "tdefData", "flagActivationDelay" ) );
    setdynamicdvar( @"hash_8e6448164d6909cb", getmatchrulesdata( "carryData", "possessionResetCondition" ) );
    setdynamicdvar( @"hash_92904d1a8261b677", getmatchrulesdata( "carryData", "possessionResetTime" ) );
    setdynamicdvar( @"hash_f0cb1a84da33e8a8", getmatchrulesdata( "carryData", "showEnemyCarrier" ) );
    setdynamicdvar( @"hash_2fc502e4555eb8a7", getmatchrulesdata( "carryData", "idleResetTime" ) );
    setdynamicdvar( @"hash_445f6744f9a3f171", 0 );
    registerhalftimedvar( "tdef", 0 );
    setdynamicdvar( @"hash_d71f4ed1af2ec0af", 0 );
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x121a
// Size: 0xfc
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
    
    foreach ( entry in level.teamnamelist )
    {
        setobjectivetext( entry, &"OBJECTIVES/TDEF" );
        
        if ( level.splitscreen )
        {
            setobjectivescoretext( entry, &"OBJECTIVES/TDEF" );
        }
        else
        {
            setobjectivescoretext( entry, &"OBJECTIVES/TDEF_SCORE" );
        }
        
        setobjectivehinttext( entry, &"OBJECTIVES/TDEF_ATTACKER_HINT" );
    }
    
    initspawns();
    tdef();
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x131e
// Size: 0x14e
function updategametypedvars()
{
    scripts\mp\gametypes\common::updatecommongametypedvars();
    level.ppkteamnoflag = dvarintvalue( "ppkTeamNoFlag", 50, 0, 250 );
    level.ppkteamwithflag = dvarintvalue( "ppkTeamWithFlag", 100, 0, 250 );
    level.ppkflagcarrier = dvarintvalue( "ppkFlagCarrier", 250, 0, 250 );
    level.scoringtime = dvarfloatvalue( "scoringTime", 1, 1, 10 );
    level.scorepertick = dvarintvalue( "scorePerTick", 1, 1, 25 );
    level.carrierbonustime = dvarfloatvalue( "carrierBonusTime", 4, 0, 10 );
    level.carrierbonusscore = dvarintvalue( "carrierBonusScore", 25, 0, 250 );
    level.spawndelay = dvarfloatvalue( "spawnDelay", 60, 0, 60 );
    level.flagactivationdelay = dvarfloatvalue( "flagActivationDelay", 10, 0, 30 );
    level.possessionresetcondition = dvarintvalue( "possessionResetCondition", 0, 0, 2 );
    level.possessionresettime = dvarfloatvalue( "possessionResetTime", 0, 0, 150 );
    level.idleresettime = dvarfloatvalue( "idleResetTime", 15, 0, 60 );
    level.showenemycarrier = dvarintvalue( "showEnemyCarrier", 5, 0, 6 );
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x1474
// Size: 0x18a
function initspawns()
{
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2147483647, -2147483647, -2147483647 );
    
    if ( function_bff229a11ecd1e34() )
    {
        scripts\mp\spawnlogic::setactivespawnlogic( #"default" );
    }
    else
    {
        scripts\mp\spawnlogic::setactivespawnlogic( "TDef", "Crit_Frontline" );
    }
    
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
    scripts\mp\spawnlogic::addspawnpoints( "allies", "mp_tdm_spawn" );
    scripts\mp\spawnlogic::addspawnpoints( "allies", "mp_tdm_spawn_secondary", 1, 1 );
    scripts\mp\spawnlogic::addspawnpoints( "axis", "mp_tdm_spawn" );
    scripts\mp\spawnlogic::addspawnpoints( "axis", "mp_tdm_spawn_secondary", 1, 1 );
    spawns = scripts\mp\spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
    spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray( "mp_tdm_spawn_secondary" );
    scripts\mp\spawnlogic::registerspawnset( "normal", spawns );
    scripts\mp\spawnlogic::registerspawnset( "fallback", spawnssecondary );
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    
    foreach ( spawnpoint in level.spawnpoints )
    {
        calculatespawndisttodefenderflagstart( spawnpoint );
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x1606
// Size: 0x8d
function calculatespawndisttodefenderflagstart( spawnpoint )
{
    spawnpoint.scriptdata.distsqtodefenderflagstart = undefined;
    dist = getpathdist( spawnpoint.origin, level.defenderflag_starts[ 0 ], 1000 );
    
    if ( dist < 0 )
    {
        dist = distance_2d_squared( spawnpoint.origin, level.defenderflag_starts[ 0 ] );
    }
    else
    {
        dist *= dist;
    }
    
    spawnpoint.scriptdata.distsqtodefenderflagstart = dist;
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x169b
// Size: 0x110
function getspawnpoint()
{
    spawnteam = self.pers[ "team" ];
    
    if ( game[ "switchedsides" ] )
    {
        spawnteam = getotherteam( spawnteam )[ 0 ];
    }
    
    if ( scripts\mp\spawnlogic::shoulduseteamstartspawn() )
    {
        spawnpoints = scripts\mp\spawnlogic::getspawnpointarray( "mp_tdm_spawn_" + spawnteam + "_start" );
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn( spawnpoints );
    }
    else
    {
        var_ba0a9fd614a3f6ee = [];
        var_ba0a9fd614a3f6ee[ "defenderFlagPosition" ] = level.defenderflag.visuals[ 0 ].origin;
        
        if ( isdefined( level.defenderflag.carrier ) )
        {
            var_ba0a9fd614a3f6ee[ "activeCarrierPosition" ] = level.defenderflag.carrier.origin;
        }
        else
        {
            var_ba0a9fd614a3f6ee[ "activeCarrierPosition" ] = var_ba0a9fd614a3f6ee[ "defenderFlagPosition" ];
        }
        
        var_ba0a9fd614a3f6ee[ "avoidDefenderFlagDeadZoneDistSq" ] = 1000000;
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint( self, spawnteam, "normal", "fallback", undefined, var_ba0a9fd614a3f6ee );
    }
    
    return spawnpoint;
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x17b4
// Size: 0xfe
function tdef()
{
    level.flagmodel[ "allies" ] = "ctf_game_flag_west";
    level.flagbase[ "allies" ] = "ctf_game_flag_base";
    level.carryflag[ "allies" ] = "prop_ctf_game_flag_west";
    level.flagmodel[ "axis" ] = "ctf_game_flag_east";
    level.flagbase[ "axis" ] = "ctf_game_flag_base";
    level.carryflag[ "axis" ] = "prop_ctf_game_flag_east";
    setupwaypointicons();
    level.iconescort = "waypoint_escort_flag";
    level.iconkill = "waypoint_ctf_kill";
    level.iconcaptureflag = "waypoint_take_flag";
    level.icondefendflag = "waypoint_defend_flag";
    level.iconreturnflag = "waypoint_recover_flag";
    level.mlgiconemptyflag = "waypoint_mlg_empty_flag";
    level.mlgiconfullflag = "waypoint_mlg_full_flag";
    level.icontarget = "waypoint_target";
    createflagstart();
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x18ba
// Size: 0xec
function setupwaypointicons()
{
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_ctf_kill", 2, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_recover_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_RECOVER_CAPS", "icon_waypoint_flag", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_escort_flag", 2, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_take_flag", 0, "neutral", "MP_INGAME_ONLY/OBJ_TAKE_CAPS", "icon_waypoint_flag", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_defend_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_mlg_empty_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_empty", 0 );
    scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_mlg_full_flag", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "codcaster_icon_waypoint_ctf_full", 0 );
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x19ae
// Size: 0xad
function createflagstart()
{
    level.defenderflag_starts = array_randomize( level.defenderflag_starts );
    tracestart = level.defenderflag_starts[ 0 ] + ( 0, 0, 64 );
    traceend = level.defenderflag_starts[ 0 ] + ( 0, 0, -64 );
    trace = scripts\engine\trace::ray_trace( tracestart, traceend, undefined, scripts\engine\trace::create_default_contents( 1 ) );
    level.defenderflag_starts[ 0 ] = trace[ "position" ];
    level.defenderflag = createteamdefenderflag( "allies" );
    level thread flaglockedtimer();
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x1a63
// Size: 0x14e
function flaglockedtimer()
{
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        level.defenderflagbase.objectiveicon scripts\mp\gameobjects::setvisibleteam( "none" );
        level waittill_any_2( "prematch_done", "start_mode_setup" );
        level.defenderflagbase.objectiveicon scripts\mp\gameobjects::setvisibleteam( "any" );
    }
    
    if ( level.flagactivationdelay )
    {
        scripts\mp\flags::gameflagwait( "prematch_done" );
        level.defenderflagbase.objectiveicon thread scripts\mp\gameobjects::function_d36dcacac1708708( level.flagactivationdelay );
        wait level.flagactivationdelay;
        level.defenderflagbase.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons( level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag );
        level.defenderflag.trigger scripts\engine\utility::trigger_on();
        
        foreach ( team in level.teamnamelist )
        {
            scripts\mp\utility\dialog::leaderdialog( "obj_generic_capture", team );
        }
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x1bb9
// Size: 0x43d
function createteamdefenderflag( team )
{
    level.pickuptime = 0;
    level.returntime = 0;
    radius = 32;
    trigger = spawn( "trigger_radius", level.defenderflag_starts[ 0 ], 0, radius, 128 );
    visuals = [];
    visuals[ 0 ] = spawn( "script_model", level.defenderflag_starts[ 0 ] );
    visuals[ 0 ] setmodel( level.flagmodel[ team ] );
    visuals[ 0 ] setasgametypeobjective();
    visuals[ 0 ] setteaminhuddatafromteamname( team );
    carryteam = "neutral";
    teamflag = scripts\mp\gameobjects::createcarryobject( carryteam, trigger, visuals, ( 0, 0, 85 ) );
    teamflag scripts\mp\gameobjects::allowcarry( "any" );
    teamflag scripts\mp\gameobjects::setteamusetime( "friendly", level.pickuptime );
    teamflag scripts\mp\gameobjects::setteamusetime( "enemy", level.returntime );
    teamflag scripts\mp\gameobjects::setvisibleteam( "none" );
    teamflag scripts\mp\gameobjects::setobjectivestatusallicons( level.iconescort, level.iconkill, level.mlgiconfullflag );
    teamflag scripts\mp\objidpoolmanager::objective_set_play_intro( teamflag.objidnum, 0 );
    teamflag scripts\mp\objidpoolmanager::objective_set_play_outro( teamflag.objidnum, 0 );
    teamflag scripts\mp\gameobjects::registercarryobjectpickupcheck( &flagpickupchecks );
    teamflag.allowweapons = 1;
    teamflag.onpickup = &onpickup;
    teamflag.onpickupfailed = &onpickup;
    teamflag.ondrop = &ondrop;
    teamflag.onreset = &onreset;
    
    if ( isdefined( level.showenemycarrier ) )
    {
        switch ( level.showenemycarrier )
        {
            case 0:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 60;
                break;
            case 1:
                teamflag.objidpingfriendly = 0;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 0.05;
                break;
            case 2:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 1;
                break;
            case 3:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 1.5;
                break;
            case 4:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 2;
                break;
            case 5:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 3;
                break;
            case 6:
                teamflag.objidpingfriendly = 1;
                teamflag.objidpingenemy = 0;
                teamflag.objpingdelay = 4;
                break;
        }
        
        pingobjid = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
        teamflag.pingobjidnum = pingobjid;
        scripts\mp\objidpoolmanager::objective_add_objective( pingobjid, "done", teamflag.origin );
        scripts\mp\objidpoolmanager::objective_set_play_intro( pingobjid, 0 );
        scripts\mp\objidpoolmanager::objective_set_play_outro( pingobjid, 0 );
        teamflag scripts\mp\gameobjects::setvisibleteam( "none", pingobjid );
        objective_setownerteam( pingobjid, team );
        teamflag scripts\mp\gameobjects::setobjectivestatusallicons( level.iconescort, level.iconkill, level.mlgiconfullflag, pingobjid );
    }
    else
    {
        teamflag.objidpingfriendly = 1;
        teamflag.objidpingenemy = 0;
        teamflag.objpingdelay = 3;
    }
    
    level.defenderflagbase = createteamdefenderflagbase( team, teamflag );
    return teamflag;
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x1fff
// Size: 0x13, Type: bool
function flagpickupchecks( player )
{
    return !player scripts\cp_mp\utility\player_utility::isinvehicle();
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 2
// Checksum 0x0, Offset: 0x201b
// Size: 0x13d
function createteamdefenderflagbase( team, teamflag )
{
    flagbaseorigin = teamflag.visuals[ 0 ].origin;
    teamflagbase = spawn( "script_model", flagbaseorigin );
    teamflagbase setmodel( level.flagbase[ team ] );
    teamflagbase.ownerteam = "neutral";
    teamflagbase setasgametypeobjective();
    teamflagbase setteaminhuddatafromteamname( team );
    teamflagbase.objectiveicon = scripts\mp\gameobjects::createobjidobject( flagbaseorigin, "neutral", ( 0, 0, 85 ), undefined, "any", 0 );
    teamflagbase.objectiveicon scripts\mp\gameobjects::setvisibleteam( "any" );
    
    if ( level.flagactivationdelay )
    {
        teamflag.trigger scripts\engine\utility::trigger_off();
        teamflagbase.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons( level.icontarget, level.icontarget, level.mlgiconfullflag );
    }
    else
    {
        teamflagbase.objectiveicon scripts\mp\gameobjects::setobjectivestatusallicons( level.iconcaptureflag, level.iconcaptureflag, level.mlgiconfullflag );
    }
    
    return teamflagbase;
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x2161
// Size: 0x3f
function setteaminhuddatafromteamname( teamname )
{
    if ( teamname == "axis" )
    {
        self setteaminhuddata( 1 );
        return;
    }
    
    if ( teamname == "allies" )
    {
        self setteaminhuddata( 2 );
        return;
    }
    
    self setteaminhuddata( 0 );
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 3
// Checksum 0x0, Offset: 0x21a8
// Size: 0x356
function onpickup( player, playervo, defused )
{
    self notify( "picked_up" );
    player notify( "obj_picked_up" );
    level.defenderflagbase.objectiveicon scripts\mp\gameobjects::setvisibleteam( "none" );
    level.defenderflag.currentcarrier = player;
    player thread awardobjtimeforcarrier();
    
    if ( level.scorepertick > 0 )
    {
        level.defenderflag thread awardcapturepoints( player.team );
    }
    else
    {
        player thread flagattachradar();
    }
    
    ownerteam = scripts\mp\gameobjects::getownerteam();
    scripts\mp\gameobjects::setownerteam( player.team );
    team = player.pers[ "team" ];
    
    if ( team == "allies" )
    {
        otherteam = "axis";
    }
    else
    {
        otherteam = "allies";
    }
    
    player attachflag();
    player incpersstat( "pickups", 1 );
    
    if ( self.ownerteam == "allies" )
    {
        setomnvar( "ui_single_flag_loc", player getentitynumber() );
    }
    else
    {
        setomnvar( "ui_single_flag_loc", player getentitynumber() );
    }
    
    player setclientomnvar( "ui_flag_player_hud_icon", 1 );
    
    if ( isdefined( level.showenemycarrier ) )
    {
        if ( level.showenemycarrier == 0 )
        {
            scripts\mp\gameobjects::setvisibleteam( "none" );
        }
        else
        {
            scripts\mp\gameobjects::setvisibleteam( "friendly" );
            objective_state( self.pingobjidnum, "current" );
            scripts\mp\gameobjects::updatecompassicon( "enemy", self.pingobjidnum );
            objective_icon( self.pingobjidnum, "icon_waypoint_kill" );
            objective_setbackground( self.pingobjidnum, 2 );
            scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator( self.pingobjidnum, 1 );
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( self.pingobjidnum, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS" );
            scripts\mp\objidpoolmanager::update_objective_setenemylabel( self.pingobjidnum, "MP_INGAME_ONLY/OBJ_KILL_CAPS" );
            objective_setownerteam( self.pingobjidnum, team );
        }
    }
    
    scripts\mp\gameobjects::setobjectivestatusallicons( level.iconescort, level.iconkill, level.mlgiconfullflag );
    printandsoundoneveryone( team, otherteam, undefined, undefined, "mp_obj_taken", "mp_enemy_obj_taken", player );
    
    if ( !level.gameended )
    {
        scripts\mp\utility\dialog::leaderdialog( "enemy_flag_taken", team );
        scripts\mp\utility\dialog::leaderdialog( "flag_getback", otherteam );
    }
    
    thread teamplayercardsplash( "callout_flagpickup", player );
    player thread scripts\mp\hud_message::showsplash( "flagpickup" );
    
    if ( !isdefined( self.previouscarrier ) || self.previouscarrier != player )
    {
        player thread doscoreevent( #"flag_grab" );
    }
    
    var_7e2c53b0bcf117d9 = spawnstruct();
    var_7e2c53b0bcf117d9.player = player;
    var_7e2c53b0bcf117d9.eventname = "pickup";
    var_7e2c53b0bcf117d9.position = player.origin;
    scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_on_game_event", var_7e2c53b0bcf117d9 );
    self.previouscarrier = player;
    
    if ( level.codcasterenabled )
    {
        player setgametypevip( 1 );
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x2506
// Size: 0x9
function returnflag()
{
    scripts\mp\gameobjects::returnhome();
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x2517
// Size: 0x288
function ondrop( player )
{
    if ( isdefined( player.leaving_team ) )
    {
        self.droppedteam = player.leaving_team;
        player.leaving_team = undefined;
    }
    else if ( !isdefined( player ) )
    {
        self.droppedteam = self.ownerteam;
    }
    else
    {
        self.droppedteam = player.team;
    }
    
    level.defenderflag.currentcarrier = undefined;
    
    if ( isdefined( player ) )
    {
        player updatematchstatushintonnoflag();
    }
    
    scripts\mp\gameobjects::setownerteam( "neutral" );
    team = self.droppedteam;
    otherteam = getotherteam( self.droppedteam )[ 0 ];
    scripts\mp\gameobjects::allowcarry( "any" );
    scripts\mp\gameobjects::setvisibleteam( "any" );
    objective_state( self.pingobjidnum, "done" );
    
    if ( level.returntime >= 0 )
    {
        scripts\mp\gameobjects::setobjectivestatusallicons( level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag );
    }
    else
    {
        scripts\mp\gameobjects::setobjectivestatusallicons( level.iconreturnflag, level.iconreturnflag, level.mlgiconfullflag );
        scripts\mp\objidpoolmanager::objective_hide_for_mlg_spectator( self.objidnum, 1 );
    }
    
    if ( self.ownerteam == "allies" )
    {
        setomnvar( "ui_single_flag_loc", -1 );
    }
    else
    {
        setomnvar( "ui_single_flag_loc", -1 );
    }
    
    if ( isdefined( player ) )
    {
        player setclientomnvar( "ui_flag_player_hud_icon", 0 );
    }
    
    if ( isdefined( player ) )
    {
        if ( !isreallyalive( player ) )
        {
            player.carryobject.previouscarrier = undefined;
        }
        
        if ( isdefined( player.carryflag ) )
        {
            player detachflag();
        }
        
        printandsoundoneveryone( otherteam, "none", undefined, undefined, "iw9_mp_ui_objective_lost", "", player );
        
        if ( level.codcasterenabled )
        {
            player setgametypevip( 0 );
        }
    }
    else
    {
        scripts\mp\utility\sound::playsoundonplayers( "iw9_mp_ui_objective_lost", otherteam );
    }
    
    if ( !level.gameended )
    {
        scripts\mp\utility\dialog::leaderdialog( "enemy_flag_dropped", getotherteam( self.droppedteam )[ 0 ], "status" );
        scripts\mp\utility\dialog::leaderdialog( "flag_dropped", self.droppedteam, "status" );
    }
    
    if ( level.spawndelay > 5 )
    {
        thread forcespawnplayers();
    }
    
    if ( level.idleresettime > 0 )
    {
        thread returnaftertime();
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x27a7
// Size: 0xa9
function returnaftertime()
{
    self endon( "picked_up" );
    currentwaittime = 0;
    
    while ( currentwaittime < level.idleresettime )
    {
        waitframe();
        
        if ( self.claimteam == "none" )
        {
            currentwaittime += level.framedurationseconds;
        }
    }
    
    foreach ( team in level.teamnamelist )
    {
        scripts\mp\utility\sound::playsoundonplayers( "iw9_mp_ui_objective_lost", team );
    }
    
    scripts\mp\gameobjects::returnhome();
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x2858
// Size: 0x17b
function onreset()
{
    level.defenderflag.currentcarrier = undefined;
    
    if ( isdefined( level.defenderflag.portable_radar ) )
    {
        level.defenderflag.portable_radar clearportableradar();
        level.defenderflag.portable_radar delete();
    }
    
    if ( isdefined( self.droppedteam ) )
    {
        scripts\mp\gameobjects::setownerteam( self.droppedteam );
    }
    
    team = scripts\mp\gameobjects::getownerteam();
    otherteam = getotherteam( team )[ 0 ];
    scripts\mp\gameobjects::allowcarry( "any" );
    scripts\mp\gameobjects::setvisibleteam( "none" );
    scripts\mp\gameobjects::setobjectivestatusicons( level.iconescort, level.iconkill );
    level.defenderflagbase.objectiveicon scripts\mp\gameobjects::setvisibleteam( "any" );
    
    if ( !level.gameended )
    {
        scripts\mp\utility\dialog::leaderdialog( "enemy_flag_returned", getotherteam( self.droppedteam )[ 0 ], "status" );
        scripts\mp\utility\dialog::leaderdialog( "enemy_flag_returned", self.droppedteam, "status" );
    }
    
    self.droppedteam = undefined;
    
    if ( self.ownerteam == "allies" )
    {
        setomnvar( "ui_single_flag_loc", -2 );
    }
    else
    {
        setomnvar( "ui_single_flag_loc", -2 );
    }
    
    self.previouscarrier = undefined;
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x29db
// Size: 0x59
function attachflag()
{
    updatematchstatushintonhasflag();
    otherteam = getotherteam( self.pers[ "team" ] )[ 0 ];
    self attach( level.carryflag[ otherteam ], "tag_stowed_back3", 1 );
    self.carryflag = level.carryflag[ otherteam ];
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x2a3c
// Size: 0x21
function detachflag()
{
    self detach( self.carryflag, "tag_stowed_back3" );
    self.carryflag = undefined;
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x2a65
// Size: 0xe
function updatematchstatushintonnoflag()
{
    scripts\mp\hud_message::function_f004ef4606b9efdc( "single_flag_cap" );
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x2a7b
// Size: 0xe
function updatematchstatushintonhasflag()
{
    scripts\mp\hud_message::function_f004ef4606b9efdc( "single_flag_cap" );
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x2a91
// Size: 0x12e
function awardobjtimeforcarrier( team )
{
    level endon( "game_ended" );
    level.defenderflag endon( "dropped" );
    level.defenderflag endon( "reset" );
    level notify( "objTimePointsRunning" );
    level endon( "objTimePointsRunning" );
    
    while ( !level.gameended )
    {
        wait 1;
        scripts\mp\hostmigration::waittillhostmigrationdone();
        
        if ( !level.gameended )
        {
            level.defenderflag.carrier incpersstat( "objTime", 1 );
            level.defenderflag.carrier scripts\mp\persistence::statsetchild( "round", "objTime", level.defenderflag.carrier.pers[ "objTime" ] );
            level.defenderflag.carrier setextrascore0( level.defenderflag.carrier.pers[ "objTime" ] );
            level.defenderflag.carrier scripts\mp\gamescore::giveplayerscore( #"hash_98bfd8d29c56bc08", 10 );
        }
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x2bc7
// Size: 0x13f
function flagattachradar( radarteam )
{
    level endon( "game_ended" );
    level.defenderflag endon( "dropped" );
    level.defenderflag endon( "reset" );
    level notify( "portableRadarRunning" );
    level endon( "portableRadarRunning" );
    
    if ( isdefined( level.defenderflag.portable_radar ) )
    {
        level.defenderflag.portable_radar clearportableradar();
        level.defenderflag.portable_radar delete();
    }
    
    if ( !isdefined( radarteam ) )
    {
        radarteam = self.team;
    }
    
    radarowner = getflagradarowner( radarteam );
    portable_radar = spawn( "script_model", level.defenderflag.visuals[ 0 ].origin );
    portable_radar.team = getotherteam( radarteam )[ 0 ];
    portable_radar.owner = radarowner;
    portable_radar makeportableradar( radarowner );
    level.defenderflag.portable_radar = portable_radar;
    level.defenderflag thread flagradarmover();
    level.defenderflag thread flagwatchradarownerlost();
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x2d0e
// Size: 0xec
function getflagradarowner( team )
{
    level endon( "game_ended" );
    self endon( "dropped" );
    level endon( "portableRadarRunning" );
    var_347499d973e25860 = 0;
    
    while ( true )
    {
        if ( level.teamswithplayers.size == 1 && game[ "state" ] == "playing" )
        {
            var_347499d973e25860 = 1;
        }
        else
        {
            if ( var_347499d973e25860 )
            {
                wait 15;
            }
            
            otherteam = getotherteam( team )[ 0 ];
            var_347499d973e25860 = 0;
            
            foreach ( player in level.players )
            {
                if ( isalive( player ) && player.pers[ "team" ] == otherteam )
                {
                    return player;
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x2e02
// Size: 0x56
function flagradarmover()
{
    level endon( "game_ended" );
    self endon( "dropped" );
    self.portable_radar endon( "death" );
    level endon( "portableRadarRunning" );
    
    for ( ;; )
    {
        self.portable_radar moveto( self.currentcarrier.origin, 0.05 );
        wait 0.05;
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x2e60
// Size: 0x84
function flagwatchradarownerlost()
{
    level endon( "game_ended" );
    self endon( "dropped" );
    radarteam = self.portable_radar.team;
    radarteam = getotherteam( radarteam )[ 0 ];
    self.portable_radar.owner waittill_any_3( "disconnect", "joined_team", "joined_spectators" );
    self.portable_radar clearportableradar();
    self.portable_radar = undefined;
    flagattachradar( radarteam );
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x2eec
// Size: 0x6e
function getrespawndelay()
{
    ownerteam = level.defenderflag scripts\mp\gameobjects::getownerteam();
    
    if ( isdefined( ownerteam ) )
    {
        if ( self.pers[ "team" ] == ownerteam )
        {
            if ( !isdefined( level.spawndelay ) || level.spawndelay <= 0 )
            {
                return undefined;
            }
            
            if ( istrue( self.ignorerespawndelay ) )
            {
                return 0;
            }
            
            return level.spawndelay;
        }
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x2f62
// Size: 0x83
function forcespawnplayers()
{
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( !isdefined( player ) || istrue( player.fauxdead ) && player isusingremote() || isalive( player ) && !istrue( player.fauxdead ) )
        {
            continue;
        }
        
        player notify( "force_spawn" );
        waitframe();
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x2fed
// Size: 0x14
function onplayerconnect( player )
{
    thread onplayerspawned( player );
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x3009
// Size: 0xa1
function onplayerspawned( player )
{
    while ( true )
    {
        player waittill( "spawned" );
        player.ignorerespawndelay = undefined;
        player setclientomnvar( "ui_flag_player_hud_icon", 0 );
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
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 10
// Checksum 0x0, Offset: 0x30b2
// Size: 0x4d1
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    if ( !isplayer( attacker ) || attacker == self )
    {
        if ( isdefined( self.carryflag ) )
        {
            detachflag();
            self.ignorerespawndelay = 1;
        }
        
        return;
    }
    
    score = level.ppkteamnoflag;
    assert( isdefined( score ) );
    
    if ( isdefined( level.defenderflag ) && level.defenderflag scripts\mp\gameobjects::getownerteam() == attacker.pers[ "team" ] )
    {
        if ( isdefined( level.defenderflag.carrier ) && attacker != level.defenderflag.carrier )
        {
            level.defenderflag.carrier thread scripts\mp\rank::scoreeventpopup( #"carrier_bonus" );
            points = scripts\mp\rank::getscoreinfovalue( #"carrier_bonus" );
            scripts\mp\gamescore::giveplayerscore( #"carrier_bonus", points, self );
            level.defenderflag.carrier thread scripts\mp\rank::giverankxp( #"carrier_bonus", points );
            attacker thread scripts\mp\rank::scoreeventpopup( #"kill_bonus" );
            points = scripts\mp\rank::getscoreinfovalue( #"kill_bonus" );
            scripts\mp\gamescore::giveplayerscore( #"kill_bonus", points, self );
            attacker thread scripts\mp\rank::giverankxp( #"kill_bonus", points );
        }
        
        score = level.ppkteamwithflag;
    }
    else if ( isdefined( self.carryflag ) )
    {
        score = level.ppkflagcarrier;
    }
    
    attacker scripts\mp\gamescore::giveteamscoreforobjective( attacker.pers[ "team" ], score );
    var_aec2e5e01f424119 = 0;
    attackerpos = attacker.origin;
    attackerisinflictor = 0;
    
    if ( isdefined( einflictor ) )
    {
        attackerpos = einflictor.origin;
        attackerisinflictor = einflictor == attacker;
    }
    
    if ( isdefined( attacker ) && isplayer( attacker ) && attacker.pers[ "team" ] != self.pers[ "team" ] )
    {
        if ( isdefined( attacker.carryflag ) && attackerisinflictor )
        {
            attacker thread scripts\mp\rank::scoreeventpopup( #"carrier_kill" );
            attacker thread scripts\mp\utility\points::doscoreevent( #"mode_ctf_kill_with_flag" );
            var_aec2e5e01f424119 = 1;
        }
        
        if ( isdefined( self.carryflag ) )
        {
            attacker thread scripts\mp\utility\points::doscoreevent( #"mode_ctf_kill_carrier" );
            attacker incpersstat( "carrierKills", 1 );
            attacker thread scripts\mp\hud_message::showsplash( "killed_carrier" );
            attacker incpersstat( "defends", 1 );
            attacker scripts\mp\persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
            thread utility::trycall( level.matchdata_logvictimkillevent, killid, "carrying" );
            namespace_f5675568ccc8acc6::function_7d42d3f8dd68280c( 20, attacker.team, attacker getentitynumber() );
            var_aec2e5e01f424119 = 1;
        }
        
        if ( !var_aec2e5e01f424119 )
        {
            var_3cd1af2851f12ab5 = 0;
            awarddefense = 0;
            flagcheck = distsquaredcheck( attackerpos, self.origin, level.defenderflag.curorigin );
            
            if ( flagcheck )
            {
                if ( level.defenderflag.ownerteam == self.team )
                {
                    var_3cd1af2851f12ab5 = 1;
                }
                else
                {
                    awarddefense = 1;
                }
            }
            
            if ( var_3cd1af2851f12ab5 )
            {
                attacker thread scripts\mp\rank::scoreeventpopup( #"assault" );
                attacker thread scripts\mp\utility\points::doscoreevent( #"mode_x_assault" );
                thread utility::trycall( level.matchdata_logvictimkillevent, killid, "defending" );
                attacker incpersstat( "assaults", 1 );
            }
            else if ( awarddefense )
            {
                attacker thread scripts\mp\rank::scoreeventpopup( #"defend" );
                attacker thread scripts\mp\utility\points::doscoreevent( #"mode_x_defend" );
                attacker incpersstat( "defends", 1 );
                attacker scripts\mp\persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
                thread utility::trycall( level.matchdata_logvictimkillevent, killid, "assaulting" );
            }
        }
    }
    
    if ( isdefined( self.carryflag ) )
    {
        detachflag();
        self.ignorerespawndelay = 1;
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 3
// Checksum 0x0, Offset: 0x358b
// Size: 0x5c
function distsquaredcheck( attackerpos, victimpos, checkpos )
{
    attackerdistsq = distancesquared( checkpos, attackerpos );
    victimdistsq = distancesquared( checkpos, victimpos );
    
    if ( attackerdistsq < 90000 || victimdistsq < 90000 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x35ef
// Size: 0x40
function carriergivescore()
{
    level endon( "game_ended" );
    self endon( "death" );
    level.defenderflag endon( "dropped" );
    level.defenderflag endon( "reset" );
    
    while ( true )
    {
        wait level.carrierbonustime;
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x3637
// Size: 0x188
function awardcapturepoints( team )
{
    level endon( "game_ended" );
    level.defenderflag endon( "dropped" );
    level.defenderflag endon( "reset" );
    level notify( "awardCapturePointsRunning" );
    level endon( "awardCapturePointsRunning" );
    
    if ( level.carrierbonusscore > 0 )
    {
        level.defenderflag.carrier thread carriergivescore();
    }
    
    seconds = level.scoringtime;
    score = level.scorepertick;
    
    while ( !level.gameended )
    {
        wait seconds;
        scripts\mp\hostmigration::waittillhostmigrationdone();
        
        if ( !level.gameended )
        {
            scripts\mp\gamescore::giveteamscoreforobjective( team, score, 0 );
            level.defenderflag.carrier incpersstat( "objTime", 1 );
            level.defenderflag.carrier scripts\mp\persistence::statsetchild( "round", "objTime", level.defenderflag.carrier.pers[ "objTime" ] );
            level.defenderflag.carrier setextrascore0( level.defenderflag.carrier.pers[ "objTime" ] );
            level.defenderflag.carrier scripts\mp\gamescore::giveplayerscore( #"hash_98bfd8d29c56bc08", 10 );
        }
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x37c7
// Size: 0x48
function function_3b12569ebd75de5b()
{
    level.var_f076141742a52169 = level.possessionresettime;
    level.var_bc53c4bea6cd9a8f = 1;
    level.var_19d29cca063754a2 = 0;
    
    if ( isdefined( level.possessionresetcondition ) && level.possessionresetcondition != 0 )
    {
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x3817
// Size: 0x25
function createhudelems()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    updatetimers( "neutral", 1, 1 );
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 4
// Checksum 0x0, Offset: 0x3844
// Size: 0x12c
function updatetimers( ownerteam, stoptimer, resethome, resetpossession )
{
    if ( !istrue( level.possessionresetcondition ) )
    {
        return;
    }
    
    timeoverride = undefined;
    displaytime = 1000 * level.possessionresettime;
    
    if ( istrue( resethome ) )
    {
        if ( istrue( level.flagactivationdelay ) && !istrue( level.defenderflagreset ) )
        {
            displaytime = 1000 * level.flagactivationdelay;
        }
    }
    
    if ( istrue( resethome ) || istrue( resetpossession ) )
    {
        level.var_f076141742a52169 = level.possessionresettime;
        level.var_9d87ea6f4e249074 = int( gettime() + displaytime );
    }
    else
    {
        level.var_9d87ea6f4e249074 = int( gettime() + 1000 * level.var_f076141742a52169 );
    }
    
    setomnvar( "ui_hardpoint_timer", level.var_9d87ea6f4e249074 );
    
    if ( displaytime > 0 && ( istrue( resetpossession ) || !stoptimer && level.var_bc53c4bea6cd9a8f ) )
    {
        level.defenderflag thread defenderflagruntimer( ownerteam, timeoverride );
    }
    
    if ( stoptimer )
    {
        level pausedefenderflagtimer();
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 2
// Checksum 0x0, Offset: 0x3978
// Size: 0x4a
function defenderflagruntimer( ownerteam, timeoverride )
{
    level endon( "game_ended" );
    level endon( "reset" );
    level endon( "pause_defenderFlag_timer" );
    level notify( "defenderFlagRunTimer" );
    level endon( "defenderFlagRunTimer" );
    level.var_bc53c4bea6cd9a8f = 0;
    function_1a73c412bbdd19ac( ownerteam, timeoverride );
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 2
// Checksum 0x0, Offset: 0x39ca
// Size: 0x79
function function_1a73c412bbdd19ac( ownerteam, timeoverride )
{
    level endon( "game_ended" );
    level endon( "pause_defenderFlag_timer" );
    var_ff049ff4093f7a4e = ter_op( isdefined( timeoverride ), timeoverride, int( level.var_f076141742a52169 * 1000 + gettime() ) );
    level function_d06f48b387ff75bc( timeoverride );
    thread watchtimerpause();
    level thread handlehostmigration( var_ff049ff4093f7a4e );
    function_797aa8aed455dc96( level.var_f076141742a52169 );
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x3a4b
// Size: 0xc4
function function_797aa8aed455dc96( duration )
{
    level endon( "game_ended" );
    level endon( "pause_defenderFlag_timer" );
    
    if ( duration == 0 )
    {
        return;
    }
    
    assert( duration > 0 );
    starttime = gettime();
    endtime = gettime() + duration * 1000;
    
    while ( gettime() < endtime )
    {
        function_4f70f01f97007f69( ( endtime - gettime() ) / 1000 );
        
        while ( isdefined( level.hostmigrationtimer ) )
        {
            endtime += 1000;
            setgameendtime( int( endtime ) );
            wait 1;
        }
    }
    
    while ( isdefined( level.hostmigrationtimer ) )
    {
        endtime += 1000;
        setgameendtime( int( endtime ) );
        wait 1;
    }
    
    return gettime() - starttime;
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x3b18
// Size: 0x30
function function_4f70f01f97007f69( duration )
{
    level endon( "game_ended" );
    level endon( "pause_defenderFlag_timer" );
    
    if ( isdefined( level.hostmigrationtimer ) )
    {
        return;
    }
    
    level endon( "host_migration_begin" );
    wait duration;
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x3b50
// Size: 0x8b
function handlehostmigration( var_ff049ff4093f7a4e )
{
    level endon( "game_ended" );
    level endon( "disconnect" );
    level waittill( "host_migration_begin" );
    setomnvar( "ui_objective_timer_stopped", 1 );
    timepassed = scripts\mp\hostmigration::waittillhostmigrationdone();
    
    if ( !level.var_19d29cca063754a2 )
    {
        setomnvar( "ui_objective_timer_stopped", 0 );
    }
    
    if ( timepassed > 0 )
    {
        setomnvar( "ui_hardpoint_timer", level.var_9d87ea6f4e249074 + timepassed );
        return;
    }
    
    setomnvar( "ui_hardpoint_timer", level.var_9d87ea6f4e249074 );
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x3be3
// Size: 0x135
function watchtimerpause()
{
    level endon( "game_ended" );
    level notify( "watchResetSoon" );
    level endon( "watchResetSoon" );
    var_2526e18a7c1cb9ee = 0;
    var_7c2f34f22d3f69f7 = undefined;
    
    while ( level.var_f076141742a52169 > 0 && !level.var_bc53c4bea6cd9a8f )
    {
        currenttime = gettime();
        
        if ( !var_2526e18a7c1cb9ee && level.var_f076141742a52169 < 10 )
        {
            foreach ( entry in level.teamnamelist )
            {
            }
            
            var_2526e18a7c1cb9ee = 1;
        }
        
        if ( isdefined( level.defenderflag.carrier ) && level.var_f076141742a52169 < 5 )
        {
            if ( !isdefined( var_7c2f34f22d3f69f7 ) || currenttime > var_7c2f34f22d3f69f7 + 1000 )
            {
                var_7c2f34f22d3f69f7 = currenttime;
            }
        }
        
        dt = 0.05;
        wait dt;
        level.var_f076141742a52169 -= dt;
    }
    
    if ( level.var_bc53c4bea6cd9a8f )
    {
        level notify( "pause_defenderFlag_timer" );
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x3d20
// Size: 0x93
function function_ee738ab8ec64bde3( timeoverride )
{
    shouldbestopped = level.var_bc53c4bea6cd9a8f || isdefined( level.hostmigrationtimer );
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        shouldbestopped = 0;
    }
    
    if ( !level.var_19d29cca063754a2 && shouldbestopped )
    {
        level.var_19d29cca063754a2 = 1;
        setomnvar( "ui_objective_timer_stopped", 1 );
        return;
    }
    
    if ( level.var_19d29cca063754a2 && !shouldbestopped )
    {
        level.var_19d29cca063754a2 = 0;
        setomnvar( "ui_objective_timer_stopped", 0 );
    }
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 0
// Checksum 0x0, Offset: 0x3dbb
// Size: 0x14
function pausedefenderflagtimer()
{
    level.var_bc53c4bea6cd9a8f = 1;
    function_ee738ab8ec64bde3();
}

// Namespace tdef / scripts\mp\gametypes\tdef
// Params 1
// Checksum 0x0, Offset: 0x3dd7
// Size: 0x1d
function function_d06f48b387ff75bc( timeoverride )
{
    level.var_bc53c4bea6cd9a8f = 0;
    function_ee738ab8ec64bde3( timeoverride );
}

