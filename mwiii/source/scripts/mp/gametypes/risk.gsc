#using script_53da3333b83b3527;
#using script_5bab271917698dc4;
#using script_640cf1641c03e2a0;
#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\killstreaks\nuke;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_heli_reinforce;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ammorestock;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_helicopters;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\dom;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\gametypes\risk;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\menus;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\rally_point;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spawnselection;
#using scripts\mp\spectating;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\game_utility_mp;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\stealth\enemy;
#using scripts\stealth\player;

#namespace risk;

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x1d48
// Size: 0xf04
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    level thread function_2c3c204d81feb239();
    allowed[ 0 ] = getgametype();
    scripts\mp\gameobjects::main( allowed );
    scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback( &onjoinedteam );
    
    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = &initializematchrules;
        [[ level.initializematchrules ]]();
        level thread reinitializematchrulesonmigration();
    }
    else
    {
        registertimelimitdvar( getgametype(), 300 );
        registerscorelimitdvar( getgametype(), 2400 );
        registerroundlimitdvar( getgametype(), 1 );
        registerwinlimitdvar( getgametype(), 1 );
        registernumlivesdvar( getgametype(), 0 );
        registerhalftimedvar( getgametype(), 0 );
    }
    
    setdvar( @"hash_405e7e20d91344cc", 0 );
    setdvar( @"scr_allow_technicals", 1 );
    setdvar( @"scr_runlean_max_technicals", 30 );
    setdvar( @"hash_cbc195ec2129279", 0 );
    updategametypedvars();
    level.scoreperplayer = undefined;
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.onrespawndelay = &getrespawndelay;
    level.onnormaldeath = &onnormaldeath;
    level.ontimelimit = &ontimelimit;
    level.onobjectivecomplete = &scripts\mp\gametypes\dom::onflagcapture;
    level.updatefobspawnselection = &updatefobspawnselection;
    
    /#
        level.var_e3a2a0c2e544728e = &function_e3a2a0c2e544728e;
    #/
    
    level.lastcaptime = gettime();
    level.promode = 1;
    level.var_a88344345b7590c8 = &setupspawnlocations;
    level.var_e637d49948a038d3 = &getmissedinfilcamerapositions;
    level.var_3c89983e2030dfff = &calculatecameraoffset;
    level.var_1063c425ddab3330 = &createdefaultcameras;
    level.var_d280c5fdb0036183 = &function_dc3a172bf923d9b3;
    level.var_72c2648ce78bea79 = 1;
    level.var_8f6541607d5dda6b = 1;
    
    if ( getdvarint( @"hash_9ab6d986e0fd6416", 1 ) == 1 )
    {
        level.var_840e89b17ac632ee = &function_b7262fc0da03a04f;
    }
    
    game[ "dialog" ][ "gametype" ] = "gametype_groundwar";
    
    if ( getdvarint( @"hash_4a2b3d01a81655a6" ) )
    {
        game[ "dialog" ][ "gametype" ] = "dh_" + game[ "dialog" ][ "gametype" ];
    }
    else if ( getdvarint( hashcat( @"scr_", getgametype(), "_promode" ) ) )
    {
        game[ "dialog" ][ "gametype" ] = game[ "dialog" ][ "gametype" ] + "_pro";
    }
    
    game[ "dialog" ][ "offense_obj" ] = "boost_groundwar";
    game[ "dialog" ][ "defense_obj" ] = "boost_groundwar";
    game[ "dialog" ][ "obj_destroyed" ] = "obj_destroyed";
    game[ "dialog" ][ "obj_captured" ] = "obj_captured";
    game[ "dialog" ][ "securing_a" ] = "securing_a";
    game[ "dialog" ][ "securing_b" ] = "securing_b";
    game[ "dialog" ][ "securing_c" ] = "securing_c";
    game[ "dialog" ][ "securing_d" ] = "securing_d";
    game[ "dialog" ][ "securing_e" ] = "securing_e";
    game[ "dialog" ][ "secured_a" ] = "secured_a";
    game[ "dialog" ][ "secured_b" ] = "secured_b";
    game[ "dialog" ][ "secured_c" ] = "secured_c";
    game[ "dialog" ][ "secured_d" ] = "secured_d";
    game[ "dialog" ][ "secured_e" ] = "secured_e";
    game[ "dialog" ][ "losing_a" ] = "losing_a";
    game[ "dialog" ][ "losing_b" ] = "losing_b";
    game[ "dialog" ][ "losing_c" ] = "losing_c";
    game[ "dialog" ][ "losing_d" ] = "losing_d";
    game[ "dialog" ][ "losing_e" ] = "losing_e";
    game[ "dialog" ][ "lost_a" ] = "lost_a";
    game[ "dialog" ][ "lost_b" ] = "lost_b";
    game[ "dialog" ][ "lost_c" ] = "lost_c";
    game[ "dialog" ][ "lost_d" ] = "lost_d";
    game[ "dialog" ][ "lost_e" ] = "lost_e";
    game[ "dialog" ][ "lost_all" ] = "gamestate_domlosing";
    game[ "dialog" ][ "secure_all" ] = "gamestate_domwinning";
    game[ "dialog" ][ "securing_f" ] = "flag_securing";
    game[ "dialog" ][ "securing_g" ] = "flag_securing";
    game[ "dialog" ][ "securing_h" ] = "flag_securing";
    game[ "dialog" ][ "securing_i" ] = "flag_securing";
    game[ "dialog" ][ "securing_j" ] = "flag_securing";
    game[ "dialog" ][ "securing_k" ] = "flag_securing";
    game[ "dialog" ][ "securing_l" ] = "flag_securing";
    game[ "dialog" ][ "securing_m" ] = "flag_securing";
    game[ "dialog" ][ "securing_n" ] = "flag_securing";
    game[ "dialog" ][ "securing_o" ] = "flag_securing";
    game[ "dialog" ][ "secured_f" ] = "flag_secured";
    game[ "dialog" ][ "secured_g" ] = "flag_secured";
    game[ "dialog" ][ "secured_h" ] = "flag_secured";
    game[ "dialog" ][ "secured_i" ] = "flag_secured";
    game[ "dialog" ][ "secured_j" ] = "flag_secured";
    game[ "dialog" ][ "secured_k" ] = "flag_secured";
    game[ "dialog" ][ "secured_l" ] = "flag_secured";
    game[ "dialog" ][ "secured_m" ] = "flag_secured";
    game[ "dialog" ][ "secured_n" ] = "flag_secured";
    game[ "dialog" ][ "secured_o" ] = "flag_secured";
    game[ "dialog" ][ "losing_f" ] = "flag_losing";
    game[ "dialog" ][ "losing_g" ] = "flag_losing";
    game[ "dialog" ][ "losing_h" ] = "flag_losing";
    game[ "dialog" ][ "losing_i" ] = "flag_losing";
    game[ "dialog" ][ "losing_j" ] = "flag_losing";
    game[ "dialog" ][ "losing_k" ] = "flag_losing";
    game[ "dialog" ][ "losing_l" ] = "flag_losing";
    game[ "dialog" ][ "losing_m" ] = "flag_losing";
    game[ "dialog" ][ "losing_n" ] = "flag_losing";
    game[ "dialog" ][ "losing_o" ] = "flag_losing";
    game[ "dialog" ][ "lost_f" ] = "flag_lost";
    game[ "dialog" ][ "lost_g" ] = "flag_lost";
    game[ "dialog" ][ "lost_h" ] = "flag_lost";
    game[ "dialog" ][ "lost_i" ] = "flag_lost";
    game[ "dialog" ][ "lost_j" ] = "flag_lost";
    game[ "dialog" ][ "lost_k" ] = "flag_lost";
    game[ "dialog" ][ "lost_l" ] = "flag_lost";
    game[ "dialog" ][ "lost_m" ] = "flag_lost";
    game[ "dialog" ][ "lost_n" ] = "flag_lost";
    game[ "dialog" ][ "lost_o" ] = "flag_lost";
    level._effect[ "vfx_smk_signal" ] = loadfx( "vfx/_requests/mp_gameplay/vfx_smk_signal" );
    level._effect[ "vfx_smk_signal_gr" ] = loadfx( "vfx/_requests/mp_gameplay/vfx_smk_signal_gr" );
    level._effect[ "vfx_snatch_ac130_clouds" ] = loadfx( "vfx/iw8_mp/gamemode/vfx_snatch_ac130_clouds.vfx" );
    level._effect[ "vfx_br_infil_cloud_scroll" ] = loadfx( "vfx/iw8_br/gameplay/infil/vfx_br_infil_cloud_scroll.vfx" );
    level._effect[ "vfx_br_infil_jump_smoke_01" ] = loadfx( "vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_smoke_01.vfx" );
    level._effect[ "vfx_br_infil_jump_wisp_01" ] = loadfx( "vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_01.vfx" );
    level._effect[ "vfx_br_infil_jump_wisp_02" ] = loadfx( "vfx/iw8_br/gameplay/infil/vfx_br_infil_jump_wisp_02.vfx" );
    level._effect[ "vfx_br_infil_omni_light" ] = loadfx( "vfx/iw8_br/gameplay/infil/vfx_br_infil_omni_light.vfx" );
    level._effect[ "vfx_br_infil_spot_light" ] = loadfx( "vfx/iw8_br/gameplay/infil/vfx_br_infil_spot_light.vfx" );
    level.nukeselectactive = getdvarint( @"hash_720c7a325f31f44b", 0 );
    level.killstoearnnukeselect = getdvarint( @"hash_b081c1dd5ea0af33", 7 );
    level.var_1ffd19a2a9a5aa20 = getdvarint( @"hash_27d2c9ae0137a563", 0 ) == 1;
    level.useobjectives = getdvarint( @"hash_921e6ee792d53981", 1 ) == 1;
    level.userallypointvehicles = getdvarint( @"hash_9381d93d96c2f50b", 0 );
    level.hideenemyfobs = getdvarint( @"hash_7aefd938edd32dcc", 0 );
    level.completelyremovelittlebird = getdvarint( @"hash_e39e476d418a5b03", 0 );
    level.usec130spawn = getdvarint( @"hash_9d9bb5a2f8144fb0", 0 );
    level.usec130spawnfirstonly = getdvarint( @"hash_930ce0bf448dadaa", 0 );
    level.c130movementmethod = getdvarint( @"hash_2a34ac7d0124085e", 0 );
    level.c130flightdist = getdvarfloat( @"hash_2d511cfd4eb77221", 4000 );
    level.c130distapart = getdvarfloat( @"hash_ef46594cd3335bd3", 5000 );
    level.c130alignedtolocale = getdvarfloat( @"hash_f4da32c36b5dcd26", 1 );
    level.parachutedeploydelay = getdvarfloat( @"hash_10a03cab3ebe8cfa", 3 );
    level.dropbrloot = getdvarint( @"hash_1d196605f8a290e3", 1 );
    level.br_plunder_enabled = getdvarint( @"scr_game_cash", 1 );
    level.var_1e17e3480b1d264d = getdvarint( @"hash_d18fa801b9479b9c", 1 );
    level.var_1f42dab41eff5cb2 = getdvarint( @"hash_a62824c80691fde2", 1 );
    
    if ( level.var_1e17e3480b1d264d )
    {
        level.var_9c1e3c18b99409e9 = &function_9c1e3c18b99409e9;
    }
    
    level.spawnselectionshowenemy = getdvarint( @"hash_3f0db83ea7503667", 0 );
    level.spawnselectionshowfriendly = getdvarint( @"hash_4134532f274e5dfa", 0 );
    level.forcetopickafob = getdvarint( @"scr_arm_forcespawning", 0 );
    level.maxhqtanks = getdvarint( @"scr_arm_maxhqtanks", 2 );
    level.tankrespawntime = getdvarint( @"hash_b624863894a18f21", 120 );
    level.apcrespawntime = getdvarint( @"hash_ba2474692378b203", 120 );
    level.longdialoguecooldown = getdvarint( @"hash_e01953fcf34a5d51", 1 );
    level.mercymatchending_nuke = getdvarint( @"hash_d45cea76b09d2cc5", 1 );
    level.mercymatchending_time = getdvarint( @"hash_799330195191b929", 60 );
    level.var_ae48bc1a4b9caa1c = getdvarint( @"hash_667de5dffc8b4cc", 1 );
    level.numnonrallyvehicles = getdvarint( @"scr_arm_numnonrallyvehicles", 25 );
    level.disablepersonalnuke = getdvarint( @"hash_f271257bddc28c95", 0 );
    level.personalnukecostoverride = getdvarint( @"hash_d9455f252fccdb97", 30 );
    level.showteamtanks = getdvarint( @"hash_236401104966b535", 1 );
    level.spawnselectionafktime = getdvarint( @"hash_da4e1d4c2111a1bc", 120 );
    level.manualadjustlittlebirdlocs = getdvarint( @"hash_1d04716268113cb5", 1 );
    level.objectivescaler = getdvarint( @"hash_64bba1553089dad4", 1.25 );
    level.var_f59a46460cc3cab5 = getdvarvector( @"hash_2c4216225b4f446c", ( 23000, -14000, 0 ) );
    level.var_4b80e3b89ad4842b = anglestoforward( getdvarvector( @"hash_fed70e0e680b8240", ( 0, 90, 0 ) ) );
    level.var_f0ee57fb9ebfb867 = getdvarfloat( @"hash_781225e0d23d5ddd", -22000 );
    level.var_8d385a761d1d2e9f = getdvarfloat( @"hash_808507211e1b1e33", 25000 );
    level.var_efb4ec5a8f5352bf = getdvarint( @"hash_e76aefcafd544237", 0 ) == 1;
    level.var_67a7732487fb9242 = getdvarint( @"hash_1dcd7c87da382733", 1 ) == 1;
    level.var_90f4dc933b674184 = getdvarfloat( @"hash_2ea02c74510fdcf9", 60 );
    level.var_1a505675f3ef1197 = getdvarfloat( @"hash_45adef1640013bb2", 60 );
    level.var_8e9daba162280a8e = getdvarint( @"hash_34cd8a4b783e9d79", 1 ) == 1;
    level.var_eaa760f325371803 = getdvarint( @"hash_f9b3581542e787c4", 1 ) == 1;
    level.var_7f5be0207e7457b1 = getdvarint( @"hash_c56057fd4bbaf32c", 1 ) == 1;
    level.var_4de8052758f986f3 = &function_4de8052758f986f3;
    level.var_3ce1055115edcbbb = &function_3ce1055115edcbbb;
    level.skydiveredeploy = &skydiveredeploy;
    
    if ( level.useobjectives || level.userallypointvehicles || level.usesquadspawnselection )
    {
        setdvar( @"scr_game_usespawnselection", 1 );
        setdvar( @"scr_game_disablespawncamera", 0 );
        setdvar( @"hash_1a2c3b67392b6657", 1 );
    }
    else
    {
        setdvar( @"scr_game_usespawnselection", 0 );
        setdvar( @"scr_game_disablespawncamera", 1 );
        setdvar( @"hash_1a2c3b67392b6657", 1 );
    }
    
    setomnvar( "ui_risk_obj_held_allies", 0 );
    setomnvar( "ui_risk_obj_held_axis", 0 );
    setomnvar( "ui_risk_obj_held_team_three", 0 );
    setomnvar( "ui_risk_obj_held_team_four", 0 );
    
    if ( level.c130movementmethod == 1 )
    {
        level.c130pathkilltracker = [];
        level.c130pathkilltracker[ "axis" ] = 0;
        level.c130pathkilltracker[ "allies" ] = 0;
    }
    
    level.modecontrolledvehiclespawningonly = 1;
    level.disableteamstartspawns = 1;
    level.spawnprotectionexception = &spawnprotectionexception;
    flag_init( "stealth_enabled" );
    flag_init( "level_stealth_initialized" );
    flag_init( "stealth_spotted" );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x2c54
// Size: 0x16
function initializematchrules()
{
    setcommonrulesfrommatchrulesdata();
    registerhalftimedvar( "risk", 0 );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x2c72
// Size: 0x22a
function onstartgametype()
{
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    setclientnamemode( "auto_change" );
    level.objectives = [];
    level.uncapturableobjectives = [];
    level.requiredplayercountoveride = 1;
    
    foreach ( entry in level.teamnamelist )
    {
        level.requiredplayercount[ entry ] = 6;
        
        if ( istrue( level.showteamtanks ) )
        {
            level.trackedtanks[ entry ] = [];
        }
    }
    
    level.var_111c5f085a86c2f0 = &function_111c5f085a86c2f0;
    level.var_aba39caf969cd3f7 = &function_aba39caf969cd3f7;
    initspawns();
    seticonnames();
    level.usedomflag = 0;
    level thread setupwaypointicons();
    debug_setupmatchdata();
    level.gw_objstruct = spawnstruct();
    
    if ( istrue( level.var_1ffd19a2a9a5aa20 ) )
    {
        setuphqs();
    }
    
    if ( istrue( level.useobjectives ) )
    {
        setupobjectives();
    }
    
    level thread runobjectives();
    
    if ( level.usec130spawn )
    {
        level thread managec130spawns();
    }
    
    /#
        level thread function_9c513c5e546a4f52();
    #/
    
    if ( istrue( level.userallypointvehicles ) )
    {
        scripts\mp\rally_point::init();
        level thread init_rallyvehicles();
    }
    
    thread init_groundwarvehicles();
    function_aa0d1f90dcc5d366();
    function_fb11675119ade7d4();
    function_5456c21de8f2bbbc();
    
    if ( getdvarint( @"scr_br_armory_kiosk", 0 ) == 1 )
    {
        function_1629419647b0f862();
    }
    
    if ( getdvarint( @"hash_261d66a288205dae", 1 ) == 1 )
    {
        level thread function_5a1699b27399a21e();
    }
    
    scripts\mp\utility\dialog::initstatusdialog();
    
    if ( istrue( level.mercymatchending_nuke ) )
    {
        level.defconteams = [];
        level thread nuke_mercyending_init();
    }
    
    emergency_cleanupents();
    scripts\cp_mp\parachute::initparachutedvars();
    scripts\engine\utility::registersharedfunc( "vehicle_compass", "shouldBeVisibleToPlayer", &function_f69e35a602975879 );
    level thread namespace_885300a47c2b51e6::function_ca39a413ace3c168();
    level thread scripts\mp\ai_heli_reinforce::function_d0ffcd08e0870cf2();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x2ea4
// Size: 0x11d
function updategametypedvars()
{
    scripts\mp\gametypes\common::updatecommongametypedvars();
    level.pausescoring = dvarintvalue( "pauseTime", 1, 0, 1 );
    level.spawndelay = dvarfloatvalue( "spawnDelay", 5, 0, 30 );
    level.flagcapturetime = dvarfloatvalue( "flagCaptureTime", 30, 0, 30 );
    level.flagsrequiredtoscore = dvarintvalue( "flagsRequiredToScore", 1, 1, 3 );
    level.pointsperflag = dvarintvalue( "pointsPerFlag", 1, 1, 300 );
    level.flagneutralization = dvarintvalue( "flagNeutralization", 0, 0, 1 );
    level.precappoints = dvarintvalue( "preCapPoints", 0, 0, 1 );
    level.capturedecay = dvarintvalue( "captureDecay", 1, 0, 1 );
    level.capturetype = dvarintvalue( "captureType", 1, 0, 3 );
    level.numflagsscoreonkill = dvarintvalue( "numFlagsScoreOnKill", 0, 0, 3 );
    level.objectivescaler = dvarfloatvalue( "objScalar", 4, 1, 10 );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x2fc9
// Size: 0x316
function emergency_cleanupents()
{
    scripts\cp_mp\utility\game_utility::removematchingents_bykey( "delete_on_load", "targetname" );
    scripts\cp_mp\utility\game_utility::removematchingents_bykey( "vehicle_volume", "script_noteworthy" );
    scripts\cp_mp\utility\game_utility::removematchingents_bykey( "vehicle_volume_simplified", "script_noteworthy" );
    scripts\cp_mp\utility\game_utility::removematchingents_bykey( "super", "script_noteworthy" );
    scripts\cp_mp\utility\game_utility::removematchingents_bykey( "militarybase", "script_noteworthy" );
    scripts\cp_mp\utility\game_utility::removematchingents_bykey( "location_volume", "targetname" );
    scripts\cp_mp\utility\game_utility::removematchingents_bykey( "locale_area_trigger", "targetname" );
    scripts\cp_mp\utility\game_utility::removematchingents_bykey( "bank_entry_detector", "targetname" );
    scripts\cp_mp\utility\game_utility::removematchingents_bykey( "shadow_blocker", "targetname" );
    scripts\cp_mp\utility\game_utility::removematchingents_bymodel( "door_prison_cell_metal_mp", 1 );
    scripts\cp_mp\utility\game_utility::removematchingents_bymodel( "veh8_mil_air_acharlie130", 1 );
    scripts\cp_mp\utility\game_utility::removematchingents_bymodel( "door_wooden_panel_mp_01", 1 );
    scripts\cp_mp\utility\game_utility::removematchingents_bymodel( "me_electrical_box_street_01", 1 );
    scripts\cp_mp\utility\game_utility::removematchingents_bycodeclassname( "light" );
    scripts\cp_mp\utility\game_utility::removematchingents_bycodeclassname( "trigger_use_touch" );
    
    if ( isdefined( level.localeid ) && level.localeid == "locale_6" )
    {
        scripts\cp_mp\utility\game_utility::removematchingents_bykey( "locale_8", "script_noteworthy" );
    }
    
    var_a48ba5ee7fe7c64c = [];
    var_a48ba5ee7fe7c64c[ 0 ] = ( -22592, 27367, 1000 );
    var_a48ba5ee7fe7c64c[ 1 ] = ( -22592, 27303, -448 );
    var_a48ba5ee7fe7c64c[ 2 ] = ( 7837, -9674, 1154 );
    var_a48ba5ee7fe7c64c[ 3 ] = ( 7637, -9674, 1154 );
    var_a48ba5ee7fe7c64c[ 4 ] = ( 7901, -9674, -270 );
    var_a48ba5ee7fe7c64c[ 5 ] = ( 7701, -9674, -270 );
    var_a48ba5ee7fe7c64c[ 6 ] = ( 10366, -11606, 66 );
    var_a48ba5ee7fe7c64c[ 7 ] = ( 10366, -11813, 66 );
    var_a48ba5ee7fe7c64c[ 6 ] = ( 10366, -11670, -270 );
    var_a48ba5ee7fe7c64c[ 7 ] = ( 10366, -11877, -270 );
    var_a48ba5ee7fe7c64c[ 8 ] = ( 7498, -11716, 66 );
    var_a48ba5ee7fe7c64c[ 9 ] = ( 7498, -11652, -270 );
    var_a48ba5ee7fe7c64c[ 10 ] = ( -1200, -18954, -242 );
    var_a48ba5ee7fe7c64c[ 11 ] = ( -1215, -19016, 774 );
    ents = getentarray();
    
    foreach ( ent in ents )
    {
        if ( isdefined( ent.model ) && ent.model == "tag_origin" )
        {
            var_e24c6c7277a83762 = 0;
            
            foreach ( badtagorigin in var_a48ba5ee7fe7c64c )
            {
                if ( var_e24c6c7277a83762 )
                {
                    break;
                }
                
                if ( distancesquared( ent.origin, badtagorigin ) < 144 )
                {
                    var_e24c6c7277a83762 = 1;
                }
            }
            
            if ( var_e24c6c7277a83762 )
            {
                ent delete();
            }
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x32e7
// Size: 0x19b
function debug_setupmatchdata()
{
    level.var_fc3733232f9c6b6 = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.var_fc3733232f9c6b6[ entry ] = [];
    }
    
    level.startingfobnames_neutral = [ "risk_a", "risk_b", "risk_c", "risk_d", "risk_e", "risk_f", "risk_g", "risk_h", "risk_i", "risk_j", "risk_k", "risk_l", "risk_m", "risk_n", "risk_o", "risk_p", "risk_q", "risk_r" ];
    
    if ( getdvar( @"hash_2b703a46d024bd77", "" ) != "" )
    {
        level.startingfobnames_neutral = [];
        var_1d7eae3df85707df = strtok( getdvar( @"hash_2b703a46d024bd77", "" ), "," );
        
        for ( i = 0; i < var_1d7eae3df85707df.size ; i++ )
        {
            var_1d7eae3df85707df[ i ] = "risk_" + var_1d7eae3df85707df[ i ];
            level.startingfobnames_neutral[ level.startingfobnames_neutral.size ] = var_1d7eae3df85707df[ i ];
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x348a
// Size: 0x64
function seticonnames()
{
    level.iconcapture = "waypoint_capture";
    level.iconneutral = "waypoint_captureneutral";
    level.icondefend = "waypoint_defend";
    level.iconcontested = "waypoint_contested";
    level.icondefending = "waypoint_defending";
    level.icontaking = "waypoint_taking";
    level.iconlosing = "waypoint_losing";
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x34f6
// Size: 0x427
function setupwaypointicons()
{
    var_a443300a7cc92ef0 = 0;
    var_ced44bb139651fa8 = [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" ];
    
    foreach ( letter in var_ced44bb139651fa8 )
    {
        scripts\mp\gamelogic::setwaypointiconinfo( "icon_waypoint_dom_" + letter, var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_" + letter, 0 );
        scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_taking_" + letter, var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_" + letter, 1 );
        scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_capture_" + letter, var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_" + letter, 0 );
        scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_defend_" + letter, var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_" + letter, 0 );
        scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_defending_" + letter, var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_" + letter, 0 );
        scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_blocking_" + letter, var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_" + letter, 1 );
        scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_blocked_" + letter, var_a443300a7cc92ef0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_" + letter, 1 );
        scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_losing_" + letter, var_a443300a7cc92ef0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_" + letter, 1 );
        scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_captureneutral_" + letter, var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_" + letter, 0 );
        scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_contested_" + letter, var_a443300a7cc92ef0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_" + letter, 1 );
        scripts\mp\gamelogic::setwaypointiconinfo( "waypoint_dom_target_" + letter, var_a443300a7cc92ef0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_" + letter, 0 );
    }
    
    while ( !isdefined( level.streakglobals ) || !isdefined( level.streakglobals.streakbundles ) )
    {
        waitframe();
    }
    
    foreach ( var_dfbd7318ef3cc9bd, bundle in level.streakglobals.streakbundles )
    {
        level.waypointcolors[ var_dfbd7318ef3cc9bd + "_incoming" ] = "neutral";
        level.waypointbgtype[ var_dfbd7318ef3cc9bd + "_incoming" ] = 1;
        level.waypointstring[ var_dfbd7318ef3cc9bd + "_incoming" ] = "";
        level.waypointshader[ var_dfbd7318ef3cc9bd + "_incoming" ] = ter_op( isdefined( bundle.hudicon ), bundle.hudicon, "" );
        level.waypointpulses[ var_dfbd7318ef3cc9bd + "_incoming" ] = 0;
        level.waypointcolors[ var_dfbd7318ef3cc9bd ] = "neutral";
        level.waypointbgtype[ var_dfbd7318ef3cc9bd ] = 1;
        level.waypointstring[ var_dfbd7318ef3cc9bd ] = "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS";
        level.waypointshader[ var_dfbd7318ef3cc9bd ] = ter_op( isdefined( bundle.hudicon ), bundle.hudicon, "" );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x3925
// Size: 0xad
function setuphqs()
{
    level.var_6121d66ffc5b8ec9 = [];
    
    foreach ( team in level.teamnamelist )
    {
        level.var_6121d66ffc5b8ec9[ team ] = "risk_hq_" + team;
        level.gw_objstruct.hqloc[ team ] = spawnstruct();
        level.gw_objstruct.hqloc[ team ].trigger = function_766a95324ab2aad3( team );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x39da
// Size: 0xe6
function function_766a95324ab2aad3( team )
{
    switch ( team )
    {
        case #"hash_7c2d091e6337bf54":
            return spawn( "trigger_radius", ( 14225, -4600, -500 ), 0, 300, 128 );
        case #"hash_5f54b9bf7583687f":
            return spawn( "trigger_radius", ( 27950, -5700, -465 ), 0, 300, 128 );
        case #"hash_11f9d28d306ceab7":
            return spawn( "trigger_radius", ( 30400, -21200, -395 ), 0, 300, 128 );
        case #"hash_de35e9ca17933bf1":
            return spawn( "trigger_radius", ( 16300, -21525, -210 ), 0, 300, 128 );
        default:
            return spawn( "trigger_radius", ( 0, 0, 0 ), 0, 300, 128 );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x3ac8
// Size: 0x50b
function setupobjectives()
{
    level.gw_objstruct.var_c20c12b2e617d1cb = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.gw_objstruct.var_c20c12b2e617d1cb[ entry ] = [];
    }
    
    level.gw_objstruct.startingfobs_neutral = [];
    var_f6ddbb71b889a0be = [ "_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i", "_j", "_k", "_l", "_m", "_n", "_o", "_p", "_q", "_r", "_s", "_t", "_u", "_v", "_w", "_x", "_y", "_z" ];
    var_a9b909bac20ba503 = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        foreach ( var_d83e5fa8f6ce891f in level.var_fc3733232f9c6b6[ entry ] )
        {
            fob = spawnstruct();
            fob.name = var_d83e5fa8f6ce891f;
            fob.trigger = scripts\cp_mp\utility\game_utility::getlocaleent( var_d83e5fa8f6ce891f );
            fob.trigger.objkey = var_f6ddbb71b889a0be[ var_a9b909bac20ba503 ];
            var_a9b909bac20ba503++;
            level.gw_objstruct.var_c20c12b2e617d1cb[ entry ][ level.gw_objstruct.var_c20c12b2e617d1cb[ entry ].size ] = fob;
        }
    }
    
    foreach ( var_d83e5fa8f6ce891f in level.startingfobnames_neutral )
    {
        fob = spawnstruct();
        fob.name = var_d83e5fa8f6ce891f;
        fob.trigger = scripts\cp_mp\utility\game_utility::getlocaleent( var_d83e5fa8f6ce891f );
        fob.trigger.objkey = var_f6ddbb71b889a0be[ var_a9b909bac20ba503 ];
        var_a9b909bac20ba503++;
        level.gw_objstruct.startingfobs_neutral[ level.gw_objstruct.startingfobs_neutral.size ] = fob;
    }
    
    if ( scripts\cp_mp\utility\game_utility::getmapname() == "mp_downtown_gw" && getdvarint( @"hash_9b80aac5287c580f", 0 ) == 1 )
    {
        foreach ( obj in var_f6ddbb71b889a0be )
        {
            if ( getdvarvector( hashcat( @"hash_ac622f742b7efccf", obj ), ( 0, 0, 0 ) ) != ( 0, 0, 0 ) )
            {
                foreach ( fob in level.gw_objstruct.startingfobs_neutral )
                {
                    if ( fob.trigger.objkey == obj )
                    {
                        fob.trigger.origin = getdvarvector( hashcat( @"hash_ac622f742b7efccf", obj ), ( 0, 0, 0 ) );
                    }
                }
            }
        }
    }
    
    var_79bf7801c1dd360c = getdvarint( @"hash_47ad5e5a550536f2", -1 );
    
    if ( var_79bf7801c1dd360c > -1 )
    {
        while ( var_79bf7801c1dd360c < level.gw_objstruct.startingfobs_neutral.size )
        {
            level.gw_objstruct.startingfobs_neutral = array_remove_index( level.gw_objstruct.startingfobs_neutral, randomint( level.gw_objstruct.startingfobs_neutral.size ) );
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x3fdb
// Size: 0x20d
function function_5a1699b27399a21e()
{
    level endon( "game_ended" );
    teamscore = undefined;
    otherteamscore = undefined;
    level waittill( "prematch_done" );
    level thread scripts\mp\spawnselection::updatefobindanger();
    
    while ( !level.gameended )
    {
        wait getdvarint( @"hash_67a52bbc5f1e1aa0", 20 );
        scripts\mp\hostmigration::waittillhostmigrationdone();
        domflags = getowneddomflags();
        
        if ( !isdefined( level.cashtick ) )
        {
            level.cashtick = [];
        }
        
        foreach ( entry in level.teamnamelist )
        {
            level.cashtick[ entry ] = 0;
        }
        
        if ( domflags.size )
        {
            for ( i = 1; i < domflags.size ; i++ )
            {
                domflag = domflags[ i ];
                flagscore = gettime() - domflag.capturetime;
                
                for ( j = i - 1; j >= 0 && flagscore > gettime() - domflags[ j ].capturetime ; j-- )
                {
                    domflags[ j + 1 ] = domflags[ j ];
                }
                
                domflags[ j + 1 ] = domflag;
            }
            
            foreach ( domflag in domflags )
            {
                team = domflag scripts\mp\gameobjects::getownerteam();
                assert( isgameplayteam( team ) );
                var_fee716687dd29378 = scripts\mp\gametypes\obj_dom::getteamflagcount( team );
                
                if ( var_fee716687dd29378 >= level.flagsrequiredtoscore )
                {
                    level.cashtick[ team ] += level.var_1f42dab41eff5cb2;
                }
            }
        }
        
        updatecash();
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x41f0
// Size: 0xc3
function updatecash()
{
    foreach ( entry in level.teamnamelist )
    {
        if ( level.cashtick[ entry ] > 0 )
        {
            foreach ( player in getteamdata( entry, "players" ) )
            {
                player [[ level.var_9c1e3c18b99409e9 ]]( level.cashtick[ entry ] );
            }
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x42bb
// Size: 0x207
function updatedomscores()
{
    level endon( "game_ended" );
    teamscore = undefined;
    otherteamscore = undefined;
    level waittill( "prematch_done" );
    level thread scripts\mp\spawnselection::updatefobindanger();
    
    while ( !level.gameended )
    {
        wait 10;
        scripts\mp\hostmigration::waittillhostmigrationdone();
        domflags = getowneddomflags();
        
        if ( !isdefined( level.scoretick ) )
        {
            level.scoretick = [];
        }
        
        foreach ( entry in level.teamnamelist )
        {
            level.scoretick[ entry ] = 0;
        }
        
        if ( domflags.size )
        {
            for ( i = 1; i < domflags.size ; i++ )
            {
                domflag = domflags[ i ];
                flagscore = gettime() - domflag.capturetime;
                
                for ( j = i - 1; j >= 0 && flagscore > gettime() - domflags[ j ].capturetime ; j-- )
                {
                    domflags[ j + 1 ] = domflags[ j ];
                }
                
                domflags[ j + 1 ] = domflag;
            }
            
            foreach ( domflag in domflags )
            {
                team = domflag scripts\mp\gameobjects::getownerteam();
                assert( isgameplayteam( team ) );
                teamscore = getteamscore( team );
                var_fee716687dd29378 = scripts\mp\gametypes\obj_dom::getteamflagcount( team );
                
                if ( var_fee716687dd29378 >= level.flagsrequiredtoscore )
                {
                    level.scoretick[ team ] += level.pointsperflag;
                }
            }
        }
        
        updatescores();
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x44ca
// Size: 0x80
function getowneddomflags()
{
    domflags = [];
    
    foreach ( domflag in level.objectives )
    {
        if ( domflag scripts\mp\gameobjects::getownerteam() != "neutral" && isdefined( domflag.capturetime ) )
        {
            domflags[ domflags.size ] = domflag;
        }
    }
    
    return domflags;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x4553
// Size: 0x15a
function updatescores()
{
    teamshitscorelimit = [];
    
    foreach ( entry in level.teamnamelist )
    {
        targetscore = game[ "teamScores" ][ entry ] + level.scoretick[ entry ];
        
        if ( targetscore >= level.roundscorelimit )
        {
            teamshitscorelimit[ teamshitscorelimit.size ] = entry;
        }
    }
    
    if ( teamshitscorelimit.size == 1 )
    {
        level.scoretick[ teamshitscorelimit[ 0 ] ] = level.roundscorelimit - game[ "teamScores" ][ teamshitscorelimit[ 0 ] ];
    }
    
    var_e80dc2f88d61c61c = scripts\mp\gamescore::calculatewinningteam();
    
    foreach ( entry in level.teamnamelist )
    {
        if ( level.scoretick[ entry ] > 0 )
        {
            scripts\mp\gamescore::giveteamscoreforobjective( entry, level.scoretick[ entry ], 1, undefined, 1 );
        }
    }
    
    var_3397acf8985dbd01 = scripts\mp\gamescore::calculatewinningteam();
    
    if ( var_e80dc2f88d61c61c != var_3397acf8985dbd01 )
    {
        scripts\mp\gamescore::playscorestatusdialog( var_3397acf8985dbd01, 1, var_e80dc2f88d61c61c );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x46b5
// Size: 0x11b
function function_d178db205c1fb9d1( team )
{
    var_fee716687dd29378 = 0;
    
    if ( team != "neutral" )
    {
        var_fee716687dd29378 = scripts\mp\gametypes\obj_dom::getteamflagcount( team );
        setomnvar( "ui_risk_obj_held_" + team, var_fee716687dd29378 );
    }
    
    if ( var_fee716687dd29378 >= level.winthreshold && !array_contains( level.defconteams, team ) )
    {
        level.defconteams[ level.defconteams.size ] = team;
    }
    
    if ( isdefined( self.oldteam ) && self.oldteam != "neutral" )
    {
        var_20cb1803648cbc73 = scripts\mp\gametypes\obj_dom::getteamflagcount( self.oldteam );
        setomnvar( "ui_risk_obj_held_" + self.oldteam, var_20cb1803648cbc73 );
        
        if ( level.defconteams.size > 0 && var_20cb1803648cbc73 < level.winthreshold && array_contains( level.defconteams, self.oldteam ) )
        {
            level.defconteams = array_remove( level.defconteams, self.oldteam );
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x47d8
// Size: 0x6b
function function_3667b4285d355dd9( team )
{
    foreach ( flag in level.objectives )
    {
        if ( flag scripts\mp\gameobjects::getownerteam() == team )
        {
            flag function_4ce0a109ec9345ab();
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x484b
// Size: 0x67
function function_e23f5e44b6c9e25c( team )
{
    foreach ( flag in level.objectives )
    {
        flag scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
        flag scripts\cp_mp\utility\game_utility::function_f630402329582086();
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x48ba
// Size: 0x17d
function function_4ce0a109ec9345ab()
{
    circlesize = getdvarint( @"hash_1e488ceb6504874f", 2500 );
    ownerteam = scripts\mp\gameobjects::getownerteam();
    scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
    scripts\cp_mp\utility\game_utility::function_f630402329582086();
    scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522( "Risk_Circle_defcon", self.trigger.origin, circlesize );
    
    foreach ( team, teamdata in level.teamdata )
    {
        if ( teamdata[ "players" ].size > 0 && team != ownerteam )
        {
            foreach ( player in teamdata[ "players" ] )
            {
                scripts\cp_mp\utility\game_utility::function_cfd53c8f6878014f( player );
            }
        }
    }
    
    scripts\cp_mp\utility\game_utility::function_db48978d7206bd41( "Risk_Circle_allies", self.trigger.origin, circlesize );
    
    foreach ( player in getteamdata( ownerteam, "players" ) )
    {
        scripts\cp_mp\utility\game_utility::function_fab8ec5feb7d4c9c( player );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x4a3f
// Size: 0x6e
function function_d70bdcd0d50615d3( ownerteam )
{
    switch ( ownerteam )
    {
        case #"hash_5f54b9bf7583687f":
            return "allies";
        case #"hash_7c2d091e6337bf54":
            return "axis";
        case #"hash_11f9d28d306ceab7":
            return "team_three";
        case #"hash_de35e9ca17933bf1":
            return "team_four";
        default:
            return "axis_red";
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x4ab5
// Size: 0x6e5
function runobjectives( numobjs )
{
    level.spawnareas = [];
    
    foreach ( entry in level.teamnamelist )
    {
        if ( level.var_1ffd19a2a9a5aa20 )
        {
            level.spawnareas[ entry ] = [ level.var_6121d66ffc5b8ec9[ entry ] ];
            continue;
        }
        
        level.spawnareas[ entry ] = [];
    }
    
    level.allfobs = [];
    
    if ( istrue( level.useobjectives ) )
    {
        foreach ( entry in level.teamnamelist )
        {
            foreach ( fob in level.var_fc3733232f9c6b6[ entry ] )
            {
                objective = runobjflag( fob.trigger, entry );
                objective.name = fob.name;
                level.allfobs[ level.allfobs.size ] = objective;
                level.spawnareas[ entry ][ level.spawnareas[ entry ].size ] = fob.name;
                
                if ( isdefined( level.spawnselectionlocations[ fob.name ][ entry ].anchorentity ) )
                {
                    level.spawnselectionlocations[ fob.name ][ entry ].anchorentity.origin = fob.trigger.origin + ( 0, 0, 100 );
                }
            }
        }
        
        foreach ( fob in level.gw_objstruct.startingfobs_neutral )
        {
            objective = runobjflag( fob.trigger, "neutral" );
            objective.name = fob.name;
            
            if ( isdefined( objective.objidnum ) )
            {
                scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9( objective.objidnum, 1 );
            }
            
            level.allfobs[ level.allfobs.size ] = objective;
        }
        
        foreach ( fob in level.allfobs )
        {
            fob.trigger.gameobject.oncontested = &objective_oncontested;
            fob.trigger.gameobject.onuncontested = &objective_onuncontested;
            fob.trigger.gameobject.onuse = &objective_onuse;
            fob.trigger.gameobject.onbeginuse = &objective_onusebegin;
            fob.trigger.gameobject.onenduse = &objective_onuseend;
            fob.trigger.gameobject.onpinnedstate = &objective_onpinnedstate;
            fob.trigger.gameobject.onunpinnedstate = &objective_onunpinnedstate;
            
            if ( istrue( level.var_dd7af80c3eb2c1e0 ) )
            {
                fob.var_5261f4479b04f834 = &scripts\mp\gametypes\obj_dom::function_5261f4479b04f834;
            }
            
            level.objectives[ fob.trigger.gameobject.objectivekey ] = fob.trigger.gameobject;
        }
    }
    
    level.objectivessetup = 1;
    
    if ( level.usesquadspawnselection )
    {
        if ( level.var_1ffd19a2a9a5aa20 )
        {
            sethqmarkerobjective();
        }
        
        foreach ( entry in level.teamnamelist )
        {
            if ( isdefined( level.spawnareas[ entry ] ) )
            {
                scripts\mp\spawnselection::setspawnlocations( level.spawnareas[ entry ], entry );
            }
        }
        
        while ( !isdefined( level.spawnselectionlocations ) )
        {
            waitframe();
        }
        
        waitframe();
        
        if ( level.var_1ffd19a2a9a5aa20 )
        {
            foreach ( team in level.teamnamelist )
            {
                if ( isdefined( level.spawnselectionlocations[ level.var_6121d66ffc5b8ec9[ team ] ][ team ].anchorentity ) )
                {
                    level.spawnselectionlocations[ level.var_6121d66ffc5b8ec9[ team ] ][ team ].anchorentity.origin = level.gw_objstruct.hqloc[ team ].trigger.origin;
                }
            }
        }
        
        foreach ( fob in level.allfobs )
        {
            foreach ( entry in level.teamnamelist )
            {
                level.spawnselectionlocations[ fob.name ][ entry ].objectivekey = fob.trigger.gameobject.objectivekey;
            }
        }
    }
    
    level thread objective_manageobjectivesintrovisibility();
    level thread allowobjectiveuseaftermatchstart();
    setomnvar( "ui_num_dom_flags", level.objectives.size );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x51a2
// Size: 0x7b
function allowobjectiveuseaftermatchstart()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    foreach ( fob in level.allfobs )
    {
        fob.trigger.gameobject scripts\mp\gameobjects::allowuse( "enemy" );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x5225
// Size: 0x2e8
function objective_manageobjectivesintrovisibility()
{
    wait 1;
    
    if ( level.var_1ffd19a2a9a5aa20 )
    {
        foreach ( team in level.teamnamelist )
        {
            scripts\mp\objidpoolmanager::objective_playermask_hidefromall( level.gw_objstruct.hqloc[ team ].marker.objidnum );
        }
    }
    
    foreach ( fob in level.allfobs )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall( fob.trigger.gameobject.objidnum );
    }
    
    if ( isdefined( level.rallypointvehicles ) )
    {
        foreach ( rallypoint in level.rallypointvehicles )
        {
            scripts\mp\objidpoolmanager::objective_playermask_hidefromall( rallypoint.marker.objidnum );
        }
    }
    
    while ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    if ( level.var_1ffd19a2a9a5aa20 )
    {
        foreach ( team in level.teamnamelist )
        {
            scripts\mp\objidpoolmanager::objective_teammask_addtomask( level.gw_objstruct.hqloc[ team ].marker.objidnum, team );
        }
    }
    
    foreach ( fob in level.allfobs )
    {
        scripts\mp\objidpoolmanager::objective_playermask_showtoall( fob.trigger.gameobject.objidnum );
    }
    
    if ( isdefined( level.rallypointvehicles ) )
    {
        foreach ( rallypoint in level.rallypointvehicles )
        {
            if ( isdefined( rallypoint ) )
            {
                scripts\mp\objidpoolmanager::objective_teammask_addtomask( rallypoint.marker.objidnum, rallypoint.team );
            }
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x5515
// Size: 0x17f
function sethqmarkerobjective()
{
    visibility = "any";
    
    foreach ( team in level.teamnamelist )
    {
        origin = level.gw_objstruct.hqloc[ team ].trigger.origin;
        marker = scripts\mp\gameobjects::createobjidobject( origin, "neutral", ( 0, 0, 0 ), undefined, visibility, 0 );
        scripts\mp\objidpoolmanager::update_objective_ownerteam( marker.objidnum, team );
        scripts\mp\objidpoolmanager::objective_teammask_addtomask( marker.objidnum, team );
        scripts\mp\objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
        marker.lockupdatingicons = 0;
        scripts\mp\objidpoolmanager::objective_pin_global( marker.objidnum, 0 );
        scripts\mp\objidpoolmanager::update_objective_icon( marker.objidnum, "icon_waypoint_hq_friendly" );
        scripts\mp\objidpoolmanager::update_objective_setbackground( marker.objidnum, 6 );
        marker.lockupdatingicons = 1;
        level.gw_objstruct.hqloc[ team ].marker = marker;
        level.uncapturableobjectives[ level.uncapturableobjectives.size ] = marker;
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x569c
// Size: 0x169
function function_111c5f085a86c2f0()
{
    if ( !isdefined( level.gw_objstruct.hqloc ) )
    {
        return;
    }
    
    if ( level.var_a50b22fa98674a50 )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( level.gw_objstruct.hqloc[ self.team ].marker.objidnum, self );
    }
    else
    {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( level.gw_objstruct.hqloc[ self.team ].marker.objidnum, self );
    }
    
    enemyteams = getenemyteams( self.team );
    
    foreach ( enemyteam in enemyteams )
    {
        if ( level.var_f15becfbc1b01a1b )
        {
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom( level.gw_objstruct.hqloc[ enemyteam ].marker.objidnum, self );
            continue;
        }
        
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( level.gw_objstruct.hqloc[ enemyteam ].marker.objidnum, self );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x580d
// Size: 0x169
function function_aba39caf969cd3f7()
{
    if ( !isdefined( level.gw_objstruct.hqloc ) )
    {
        return;
    }
    
    if ( level.var_757ec02df4d678f5 )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( level.gw_objstruct.hqloc[ self.team ].marker.objidnum, self );
    }
    else
    {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( level.gw_objstruct.hqloc[ self.team ].marker.objidnum, self );
    }
    
    enemyteams = getenemyteams( self.team );
    
    foreach ( enemyteam in enemyteams )
    {
        if ( level.var_6f40c2b6970373c0 )
        {
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom( level.gw_objstruct.hqloc[ enemyteam ].marker.objidnum, self );
            continue;
        }
        
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( level.gw_objstruct.hqloc[ enemyteam ].marker.objidnum, self );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x597e
// Size: 0x237
function updatefobspawnselection()
{
    level.spawnareas = [];
    
    foreach ( entry in level.teamnamelist )
    {
        if ( level.var_1ffd19a2a9a5aa20 )
        {
            level.spawnareas[ entry ] = [ level.var_6121d66ffc5b8ec9[ entry ] ];
            continue;
        }
        
        level.spawnareas[ entry ] = [];
    }
    
    foreach ( fob in level.allfobs )
    {
        gameobject = fob.trigger.gameobject;
        
        if ( gameobject.ownerteam != "neutral" )
        {
            level.spawnareas[ gameobject.ownerteam ][ level.spawnareas[ gameobject.ownerteam ].size ] = fob.name;
            
            if ( isdefined( level.spawnselectionlocations[ fob.name ][ gameobject.ownerteam ].anchorentity ) )
            {
                level.spawnselectionlocations[ fob.name ][ gameobject.ownerteam ].anchorentity.origin = fob.trigger.origin + ( 0, 0, 100 );
            }
        }
    }
    
    foreach ( entry in level.teamnamelist )
    {
        if ( isdefined( level.spawnareas[ entry ] ) )
        {
            scripts\mp\spawnselection::setspawnlocations( level.spawnareas[ entry ], entry );
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x5bbd
// Size: 0x28
function objective_oncontested()
{
    scripts\mp\gametypes\obj_dom::dompoint_oncontested();
    
    if ( !istrue( self.updatedoncontestedspawnselection ) )
    {
        updatefobspawnselection();
        self.updatedoncontestedspawnselection = 1;
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x5bed
// Size: 0x31
function objective_onuncontested( lastclaimteam )
{
    scripts\mp\gametypes\obj_dom::dompoint_onuncontested( lastclaimteam );
    
    if ( istrue( self.updatedoncontestedspawnselection ) )
    {
        updatefobspawnselection();
        self.updatedoncontestedspawnselection = 0;
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x5c26
// Size: 0x1a
function objective_onusebegin( player )
{
    scripts\mp\gametypes\obj_dom::dompoint_onusebegin( player );
    updatefobspawnselection();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 3
// Checksum 0x0, Offset: 0x5c48
// Size: 0x2c
function objective_onuseend( team, player, success )
{
    scripts\mp\gametypes\obj_dom::dompoint_onuseend( team, player, success );
    updatefobspawnselection();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x5c7c
// Size: 0x3b0
function objective_onuse( claim_player, team )
{
    if ( !isdefined( team ) )
    {
        var_bd0124b2572298d0 = claim_player.team;
    }
    else
    {
        var_bd0124b2572298d0 = team;
    }
    
    scripts\mp\gametypes\obj_dom::dompoint_onuse( claim_player, team );
    team = scripts\mp\gameobjects::getownerteam();
    function_d178db205c1fb9d1( team );
    
    if ( getdvarint( @"hash_37f19f5a0cfa7cc3", 1 ) == 1 && istrue( level.var_f9747e9b80b3c33a ) )
    {
        if ( istrue( level.var_ae48bc1a4b9caa1c ) )
        {
            foreach ( defteam in level.defconteams )
            {
                if ( team == defteam )
                {
                    function_4ce0a109ec9345ab();
                    continue;
                }
                
                scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
                scripts\cp_mp\utility\game_utility::function_f630402329582086();
            }
        }
        else if ( isdefined( level.var_5932bbef2fa89f92 ) && var_bd0124b2572298d0 == level.var_5932bbef2fa89f92 )
        {
            function_4ce0a109ec9345ab();
        }
        else
        {
            scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
            scripts\cp_mp\utility\game_utility::function_f630402329582086();
        }
    }
    else if ( getdvarint( @"hash_3c11f8853fb930a3", 0 ) == 1 )
    {
        function_4ce0a109ec9345ab();
    }
    
    updatefobspawnselection();
    function_666a2979def5d705( self.objectivekey );
    
    if ( self.ownerteam == "neutral" )
    {
        return;
    }
    
    function_e8a6e840ef663c81( self.objectivekey, self.ownerteam );
    
    if ( istrue( level.var_67a7732487fb9242 ) )
    {
        if ( !isdefined( self.capnum ) )
        {
            self.capnum = 1;
        }
        else
        {
            self.capnum++;
        }
        
        capturetime = level.var_90f4dc933b674184 * self.capnum;
        
        if ( capturetime > level.var_1a505675f3ef1197 )
        {
            capturetime = level.var_1a505675f3ef1197;
        }
        
        scripts\mp\gameobjects::setusetime( capturetime );
        objective_setstate( level.objectives[ self.objectivekey ].objidnum, 1 );
    }
    
    if ( istrue( level.var_eaa760f325371803 ) )
    {
        groupname = function_78759441c259f58a();
        numagents = getdvarint( @"hash_3ac57a7fbbfe5cf8", 4 );
        
        if ( numagents > 0 )
        {
            for ( i = 0; i < numagents ; i++ )
            {
                aitype = function_d5bc07eabf352abb();
                agent = ai_mp_requestspawnagent( aitype, self.trigger.origin, ( 0, 0, 0 ), "medium", "everybody", "captureAgents", groupname, team );
                
                if ( isdefined( agent ) )
                {
                    agent scripts\stealth\enemy::bt_set_stealth_state( "combat", undefined );
                    agent function_304da84d9a815c01( self.trigger.origin, 1024 );
                    agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff( "body_spetsnaz_cqc", "head_spetsnaz_cqc" );
                }
            }
        }
        
        var_40e875a042b82875 = getdvarint( @"hash_2c76d4f86fd341de", 1 );
        
        if ( var_40e875a042b82875 > 0 )
        {
            for ( i = 0; i < var_40e875a042b82875 ; i++ )
            {
                agent = ai_mp_requestspawnagent( "enemy_mp_jugg_base", self.trigger.origin, ( 0, 0, 0 ), "absolute", "everybody", "jugg", groupname, team );
                
                if ( isdefined( agent ) )
                {
                    scripts\cp_mp\agents\agent_utils::function_1828f1e20e52b418( agent );
                    agent scripts\stealth\enemy::bt_set_stealth_state( "combat", undefined );
                    agent function_304da84d9a815c01( self.trigger.origin, 1024 );
                }
            }
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 4
// Checksum 0x0, Offset: 0x6034
// Size: 0x23
function objective_onuseupdate( team, progress, change, capplayer )
{
    
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x605f
// Size: 0x1a
function objective_onpinnedstate( player )
{
    updatefobspawnselection();
    scripts\mp\gametypes\obj_dom::dompoint_onpinnedstate( player );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x6081
// Size: 0x1a
function objective_onunpinnedstate( player )
{
    updatefobspawnselection();
    scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate( player );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x60a3
// Size: 0x2
function dommainloop()
{
    
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x60ad
// Size: 0xc9
function runobjflag( objective, startingteam )
{
    level endon( "game_ended" );
    objective.script_label = objective.objkey;
    domflag = scripts\mp\gametypes\obj_dom::setupobjective( objective, undefined, undefined, undefined, 0 );
    domflag.origin = objective.origin;
    domflag scripts\mp\gameobjects::allowuse( "none" );
    domflag.didstatusnotify = 0;
    domflag scripts\mp\gameobjects::setownerteam( startingteam );
    visibility = "any";
    
    if ( startingteam != "neutral" )
    {
        if ( level.hideenemyfobs )
        {
            visibility = "friendly";
        }
        
        domflag.capturetime = gettime();
    }
    
    domflag scripts\mp\gameobjects::setvisibleteam( visibility );
    return domflag;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x617f
// Size: 0x24
function nuke_mercyending_init()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    if ( istrue( level.useobjectives ) )
    {
        level thread nuke_mercyending_think();
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x61ab
// Size: 0xa7
function nuke_mercyending_think()
{
    level endon( "game_ended" );
    level endon( "mercy_ending_timer_started" );
    level.winthreshold = getdvarint( @"hash_d885d71c2a455eb5", 5 );
    
    while ( true )
    {
        foreach ( team in level.teamnamelist )
        {
            held = calculateobjectivesheld( team );
            
            if ( held >= level.winthreshold )
            {
                level thread nuke_startmercycountdown( team );
            }
        }
        
        waitframe();
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x625a
// Size: 0x39b
function nuke_startmercycountdown( team )
{
    level notify( "mercy_ending_timer_started" );
    level endon( "mercy_ending_triggered" );
    setomnvar( "ui_nuke_timer_type", 1 );
    setomnvar( "ui_nuke_timer_time", level.mercymatchending_time );
    setomnvar( "ui_nuke_countdown_active", 1 );
    setomnvar( "ui_arm_dominatingTeam", scripts\engine\utility::array_find( level.allteamnamelist, team ) );
    var_d984aaafbb3f49e0 = 0;
    starttime = gettime();
    endtime = level.mercymatchending_time * 1000 + starttime;
    setomnvar( "ui_nuke_end_milliseconds", level.mercymatchending_time * 1000 + starttime );
    
    if ( getdvarint( @"hash_37f19f5a0cfa7cc3", 1 ) == 1 )
    {
        level thread function_3667b4285d355dd9( team );
    }
    
    level.var_f9747e9b80b3c33a = 1;
    level.var_5932bbef2fa89f92 = team;
    
    while ( calculateobjectivesheld( team ) >= level.winthreshold )
    {
        waitframe();
        
        if ( istrue( level.var_ae48bc1a4b9caa1c ) && level.defconteams.size > 1 )
        {
            break;
        }
        
        if ( gettime() > endtime )
        {
            if ( getdvarint( @"scr_risk_combine_team_on_defcon", 0 ) == 1 )
            {
                level.var_d37d95ac1717903c = &function_d37d95ac1717903c;
                var_e6a7bb0501f0ebd4 = level thread function_1347e3ab3c68b20e( team );
                level.var_9584dcc5d16d3469 = team;
                level.var_9584cec5d16d159f = var_e6a7bb0501f0ebd4;
                setnojipscore( 1, 1 );
                setnojiptime( 1, 1 );
                level.nojip = 1;
                
                if ( getdvar( @"hash_37f18cb13c592b0c", "neutral" ) == "combine" )
                {
                    function_f525754162a91372( team, var_e6a7bb0501f0ebd4 );
                }
                else if ( getdvar( @"hash_37f18cb13c592b0c", "neutral" ) == "neutral" )
                {
                    function_f525754162a91372( "neutral", var_e6a7bb0501f0ebd4 );
                }
                
                function_f6857ca2e18431e9( team, var_e6a7bb0501f0ebd4 );
                break;
            }
            
            nuke_triggermercywin( team );
            level notify( "mercy_ending_triggered" );
        }
    }
    
    if ( istrue( level.var_ae48bc1a4b9caa1c ) )
    {
        if ( level.defconteams.size > 1 )
        {
            foreach ( entry in level.defconteams )
            {
                level thread function_3667b4285d355dd9( entry );
            }
            
            setomnvar( "ui_nuke_countdown_active", 0 );
            setomnvar( "ui_arm_dominatingTeam", -1 );
            wait 1;
            setomnvar( "ui_nuke_countdown_active", 1 );
            setomnvar( "ui_arm_dominatingTeam", -2 );
            
            while ( level.defconteams.size > 1 )
            {
                waitframe();
            }
        }
        else
        {
            setomnvar( "ui_arm_dominatingTeam", scripts\engine\utility::array_find( level.allteamnamelist, team ) );
        }
    }
    
    if ( getdvarint( @"hash_37f19f5a0cfa7cc3", 1 ) == 1 )
    {
        level thread function_e23f5e44b6c9e25c( team );
    }
    
    level.var_f9747e9b80b3c33a = 0;
    level.var_5932bbef2fa89f92 = undefined;
    setomnvar( "ui_nuke_countdown_active", 0 );
    setomnvar( "ui_arm_dominatingTeam", -1 );
    wait 1;
    
    if ( istrue( level.var_ae48bc1a4b9caa1c ) && !isdefined( level.var_9584cec5d16d159f ) )
    {
        level thread nuke_mercyending_think();
        return;
    }
    
    if ( getdvarint( @"scr_risk_combine_team_on_defcon", 0 ) == 1 )
    {
        if ( getdvarint( @"hash_48c89c3e6b934d79", 1 ) )
        {
            level thread function_2a8adcc9b74f4838();
        }
        
        return;
    }
    
    level thread nuke_mercyending_think();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x65fd
// Size: 0x1be
function nuke_triggermercywin( team )
{
    level endon( "game_ended" );
    level.mercywintriggered = 1;
    level.blocknukekills = 1;
    
    foreach ( objective in level.objectives )
    {
        objective scripts\mp\gameobjects::allowuse( "none" );
    }
    
    setomnvar( "ui_nuke_countdown_active", 0 );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && !isbot( player ) && istrue( player.inspawnselection ) )
        {
            if ( isdefined( player.operatorsfx ) )
            {
                player clearsoundsubmix( "iw8_mp_spawn_camera" );
                player.operatorsfx stoploopsound( player.operatorsfxalias );
                player.operatorsfx delete();
                player.operatorsfx = undefined;
                player.operatorsfxalias = undefined;
            }
        }
    }
    
    if ( isdefined( level.teamdata[ team ][ "alivePlayers" ][ 0 ] ) )
    {
        var_39e8f33513c716cd = level.teamdata[ team ][ "alivePlayers" ][ 0 ];
        var_39e8f33513c716cd scripts\cp_mp\killstreaks\nuke::tryusenuke();
        return;
    }
    
    level thread scripts\mp\gamelogic::endgame( team, game[ "end_reason" ][ "mercy_win" ], game[ "end_reason" ][ "mercy_loss" ], 0, 1 );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x67c3
// Size: 0x88
function nukeselectgimmewatcher( killer )
{
    if ( !istrue( killer.hasnukeselectks ) )
    {
        remainder = killer.killcountthislife % level.killstoearnnukeselect;
        
        if ( remainder >= 0 && killer.killcountthislife >= level.killstoearnnukeselect )
        {
            killer.hasnukeselectks = 1;
            killer thread scripts\mp\killstreaks\killstreaks::givekillstreak( "nuke_select_location", 0, 0 );
            killer scripts\mp\hud_message::showkillstreaksplash( "nuke_select_location", undefined, 1 );
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x6853
// Size: 0x318
function initspawns( var_4c3936c2c179fab3 )
{
    level.gamemodestartspawnpointnames = [];
    
    if ( istrue( var_4c3936c2c179fab3 ) )
    {
        var_48501209a3e177a7 = "mp_risk_spawn";
        var_ae7d0107ad485428 = "mp_risk_spawn";
        var_e77fe17f16335f61 = scripts\mp\spawnlogic::getspawnpointarray( "mp_gw_spawn_allies_start_mod" );
        
        if ( var_e77fe17f16335f61.size > 0 )
        {
            var_48501209a3e177a7 = "mp_gw_spawn_allies_start_mod";
        }
        
        var_202c2c36d99ada78 = scripts\mp\spawnlogic::getspawnpointarray( "mp_gw_spawn_axis_start_mod" );
        
        if ( var_202c2c36d99ada78.size > 0 )
        {
            var_ae7d0107ad485428 = "mp_gw_spawn_axis_start_mod";
        }
    }
    else
    {
        var_48501209a3e177a7 = "mp_risk_spawn";
        var_ae7d0107ad485428 = "mp_risk_spawn";
    }
    
    foreach ( entry in level.teamnamelist )
    {
        if ( entry == "axis" )
        {
            level.gamemodestartspawnpointnames[ entry ] = var_ae7d0107ad485428;
            continue;
        }
        
        if ( entry == "allies" )
        {
            level.gamemodestartspawnpointnames[ entry ] = var_48501209a3e177a7;
            continue;
        }
        
        level.gamemodestartspawnpointnames[ entry ] = var_ae7d0107ad485428;
    }
    
    level.gamemodespawnpointnames = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.gamemodespawnpointnames[ entry ] = "mp_risk_spawn";
    }
    
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2147483647, -2147483647, -2147483647 );
    
    if ( function_bff229a11ecd1e34() )
    {
        scripts\mp\spawnlogic::setactivespawnlogic( #"default" );
    }
    else if ( scripts\cp_mp\utility\game_utility::getmapname() == "mp_aniyah" )
    {
        scripts\mp\spawnlogic::setactivespawnlogic( "GroundWarTTLOS", "Crit_Default" );
    }
    else if ( scripts\cp_mp\utility\game_utility::islargemap() )
    {
        scripts\mp\spawnlogic::setactivespawnlogic( "GroundWar", "Crit_Default" );
    }
    else
    {
        scripts\mp\spawnlogic::setactivespawnlogic( "Default", "Crit_Default" );
    }
    
    scripts\mp\spawnlogic::addstartspawnpoints( var_48501209a3e177a7 );
    scripts\mp\spawnlogic::addstartspawnpoints( var_ae7d0107ad485428 );
    
    foreach ( entry in level.teamnamelist )
    {
        scripts\mp\spawnlogic::addspawnpoints( entry, level.gamemodestartspawnpointnames[ entry ] );
        spawns = scripts\mp\spawnlogic::getspawnpointarray( level.gamemodestartspawnpointnames[ entry ] );
        scripts\mp\spawnlogic::registerspawnset( "start_" + entry, spawns );
        scripts\mp\spawnlogic::addspawnpoints( entry, "mp_risk_spawn" );
    }
    
    spawns = scripts\mp\spawnlogic::getspawnpointarray( "mp_risk_spawn" );
    scripts\mp\spawnlogic::registerspawnset( "normal", spawns );
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    level.spawnpoints = spawns;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x6b73
// Size: 0xae
function getspawnpoint()
{
    spawnpoint = undefined;
    
    if ( istrue( level.usesquadspawn ) && istrue( self.squadspawnconfirmed ) )
    {
        spectatingteammate = self getspectatingplayer();
        
        if ( isdefined( spectatingteammate ) && isdefined( self.sessionsquadid ) && self.team == spectatingteammate.team && self.sessionsquadid == spectatingteammate.sessionsquadid )
        {
            spawnpoint = scripts\mp\spawnscoring::findteammatebuddyspawn( spectatingteammate );
        }
    }
    else
    {
        scripts\mp\spawnlogic::activatespawnset( "normal", 1 );
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint( self, self.team, undefined, undefined );
    }
    
    return spawnpoint;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x6c2a
// Size: 0x92
function onspawnplayer( revivespawn )
{
    self setclientomnvar( "ui_risk_obj_client_team", scripts\engine\utility::array_find( level.allteamnamelist, self.team ) );
    thread updatematchstatushintonspawn();
    scripts\cp_mp\squads::updatesquadomnvars( self.team, self.sessionsquadid );
    
    if ( !isdefined( self.plundercount ) )
    {
        self.plundercount = 0;
    }
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) || !function_dc3a172bf923d9b3() )
    {
        thread function_b88ec41808ee3630();
    }
    
    self.var_5354295b99468cef = undefined;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x6cc4
// Size: 0x31
function updatematchstatushintonspawn()
{
    level endon( "game_ended" );
    
    if ( isdefined( level.nukeprogress ) )
    {
        scripts\mp\hud_message::function_f004ef4606b9efdc( "nuke_capture" );
        return;
    }
    
    scripts\mp\hud_message::function_f004ef4606b9efdc( "dom_cap_defend" );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 10
// Checksum 0x0, Offset: 0x6cfd
// Size: 0x164
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    scripts\cp_mp\squads::updatesquadomnvars( self.team, self.sessionsquadid );
    scripts\mp\gametypes\obj_dom::awardgenericmedals( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
    
    if ( level.dropbrloot )
    {
        dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
        dropstruct.dropidx = 14;
        scripts\mp\gametypes\br_plunder::playerdropplunderondeath( dropstruct, attacker );
    }
    
    if ( level.nukeselectactive && isplayer( attacker ) && smeansofdeath != "MOD_SUICIDE" )
    {
        if ( !isdefined( attacker.killcountthislife ) )
        {
            attacker.killcountthislife = 0;
        }
        
        if ( !istrue( attacker.hasnukeselectks ) )
        {
            attacker.killcountthislife++;
        }
        
        nukeselectgimmewatcher( attacker );
    }
    
    if ( !isdefined( level.c130pathkilltracker ) || level.c130movementmethod != 1 )
    {
        return;
    }
    
    level.c130pathkilltracker[ self.team ] += 1;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x6e69
// Size: 0x8c
function onplayerconnect( player )
{
    if ( isdefined( level.rallypointvehicles ) )
    {
        thread scripts\mp\rally_point::rallypoint_showtoplayer( player );
    }
    
    if ( isdefined( player ) && istrue( level.supportsai ) )
    {
        player.gameskill = namespace_310bdaa3cf041c47::get_gameskill();
        player namespace_310bdaa3cf041c47::set_difficulty_from_locked_settings();
        player.owner = undefined;
        flag_wait( "level_stealth_initialized" );
        
        while ( !isdefined( player.team ) )
        {
            waitframe();
        }
        
        player scripts\stealth\player::main();
    }
    
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x6efd
// Size: 0x13
function onjoinedteam( player )
{
    player function_6ed651811c936a22();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x6f18
// Size: 0xb
function onplayerdisconnect( player )
{
    
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x6f2b
// Size: 0x9e
function updategamemodespawncamera()
{
    activezonename = "lane02_4";
    
    if ( isdefined( level.activezone ) )
    {
        activezonename = level.activezone.zonetrigger.script_label;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        scripts\mp\spawncamera::setgamemodecamera( entry, level.spawncameras[ activezonename ][ entry ] );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x6fd1
// Size: 0x119
function debugdrawtocameras()
{
    while ( true )
    {
        wait 0.25;
        
        if ( !isdefined( level.players[ 0 ] ) )
        {
            continue;
        }
        
        foreach ( teamarray in level.spawncameras )
        {
            foreach ( team, camera in teamarray )
            {
                thread drawangles( camera.origin, camera.angles, 0.25, 50 );
                thread drawsphere( camera.origin, 50, 0.25, ter_op( team == "allies", ( 0, 0, 1 ), ( 1, 0, 0 ) ) );
            }
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x70f2
// Size: 0x1b
function onplayerspawned( player )
{
    while ( true )
    {
        player waittill( "spawned" );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x7115
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

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x7197
// Size: 0xd
function getrespawndelay()
{
    self.spawncameraskipthermal = 0;
    return undefined;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 6
// Checksum 0x0, Offset: 0x71ad
// Size: 0x85
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    scripts\mp\gametypes\common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    
    if ( getdvarint( @"hash_ddd6a50efca1e2c2", 0 ) == 1 )
    {
        if ( !isdefined( level.var_d37d95ac1717903c ) )
        {
            level.var_d37d95ac1717903c = &function_d37d95ac1717903c;
        }
        
        victim thread function_190616cdbc044966( attacker, attacker.team );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 3
// Checksum 0x0, Offset: 0x723a
// Size: 0x8a
function function_190616cdbc044966( attacker, var_917d7051fe3efec8, suicideplayer )
{
    if ( istrue( suicideplayer ) )
    {
        scripts\mp\utility\damage::_suicide();
    }
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    if ( isagent( attacker ) )
    {
        return;
    }
    
    if ( isdefined( attacker.owner ) )
    {
        attacker = attacker.owner;
    }
    
    if ( attacker == self && !istrue( suicideplayer ) )
    {
        return;
    }
    
    self.var_5354295b99468cef = 1;
    wait 0.15;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.teamchangedthisframe = 1;
    scripts\mp\menus::setteam( var_917d7051fe3efec8 );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x72cc
// Size: 0x15c
function ontimelimit()
{
    leadteam = "tie";
    leadteamcount = 0;
    domflags = getowneddomflags();
    
    if ( domflags.size )
    {
        foreach ( team in level.teamnamelist )
        {
            assert( isgameplayteam( team ) );
            var_fee716687dd29378 = scripts\mp\gametypes\obj_dom::getteamflagcount( team );
            
            if ( var_fee716687dd29378 > 0 )
            {
                if ( leadteamcount < var_fee716687dd29378 )
                {
                    leadteam = team;
                    leadteamcount = var_fee716687dd29378;
                    continue;
                }
                
                if ( leadteamcount == var_fee716687dd29378 )
                {
                    leadteam = "tie";
                }
            }
        }
        
        if ( leadteam == "tie" )
        {
            foreach ( team in level.teamnamelist )
            {
                scripts\mp\gamescore::giveteamscoreforobjective( team, 1 );
            }
        }
        else
        {
            scripts\mp\gamescore::giveteamscoreforobjective( leadteam, leadteamcount );
        }
        
        thread scripts\mp\gamelogic::endgame( leadteam, game[ "end_reason" ][ "time_limit_reached" ] );
        return;
    }
    
    thread scripts\mp\gamelogic::endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x7430
// Size: 0x13d
function initspecatatorcameras()
{
    level.spectatorcameras = [];
    level.currentspectatorcamref = "cop_2";
    var_84286554864313cb = getstructarray( "tac_ops_map_config", "targetname" );
    
    foreach ( var_48380029fbb1007a in var_84286554864313cb )
    {
        var_ca2c833762e5466c = var_48380029fbb1007a.script_noteworthy;
        childstructs = getstructarray( var_48380029fbb1007a.target, "targetname" );
        
        foreach ( childstruct in childstructs )
        {
            switch ( childstruct.script_label )
            {
                case #"hash_11e1630c6c429f23":
                    setteammapposition( var_ca2c833762e5466c, "allies", childstruct );
                    break;
                case #"hash_e66f1db565904926":
                    setteammapposition( var_ca2c833762e5466c, "axis", childstruct );
                    break;
            }
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 3
// Checksum 0x0, Offset: 0x7575
// Size: 0x46
function setteammapposition( var_ca2c833762e5466c, team, posinfo )
{
    if ( !isdefined( level.spectatorcameras[ var_ca2c833762e5466c ] ) )
    {
        level.spectatorcameras[ var_ca2c833762e5466c ] = [];
    }
    
    level.spectatorcameras[ var_ca2c833762e5466c ][ team ] = posinfo;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x75c3
// Size: 0x15
function applythermal()
{
    self visionsetthermalforplayer( "proto_apache_flir_mp" );
    self thermalvisionon();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x75e0
// Size: 0x9
function removethermal()
{
    self thermalvisionoff();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x75f1
// Size: 0x12f
function startspectatorview()
{
    if ( isteamreviveenabled() )
    {
        return;
    }
    
    waitframe();
    updatesessionstate( "spectator" );
    scripts\mp\spectating::setdisabled();
    
    if ( isdefined( self.lastdeathangles ) )
    {
        self setplayerangles( self.lastdeathangles );
    }
    
    wait 0.1;
    setdof_default();
    var_26ee0f3f89450d97 = 0;
    bestflag = undefined;
    camorigin = ( 0, 0, 0 );
    zoffset = 1000;
    var_dead2082432cecc = self.origin + ( 0, 0, zoffset );
    var_6788dc28320974a = self.angles;
    self.deathspectatepos = var_dead2082432cecc;
    self.deathspectateangles = var_6788dc28320974a;
    cameraent = spawn( "script_model", self getvieworigin() );
    cameraent setmodel( "tag_origin" );
    cameraent.angles = var_6788dc28320974a;
    self.spectatorcament = cameraent;
    self.isusingtacopsmapcamera = 1;
    self cameralinkto( cameraent, "tag_origin", 1 );
    thread dohalfwayflash();
    cameraent movecameratomappos( self, var_dead2082432cecc, var_6788dc28320974a );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x7728
// Size: 0x17
function dohalfwayflash()
{
    wait 0.4;
    thread playslamzoomflash();
    applythermal();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x7747
// Size: 0x1f
function endspectatorview()
{
    if ( !isdefined( self.spectatorcament ) )
    {
        return;
    }
    
    removethermal();
    thread runslamzoomonspawn();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 3
// Checksum 0x0, Offset: 0x776e
// Size: 0x102
function movecameratomappos( player, var_9813182985677b23, finalangles )
{
    player endon( "spawned_player" );
    movetime = 1;
    rotatetime = 1;
    self moveto( var_9813182985677b23, 2, 1, 1 );
    player playlocalsound( "mp_cmd_camera_zoom_out" );
    player setclienttriggeraudiozonepartialwithfade( "spawn_cam", 0.5, "mix" );
    self rotateto( finalangles, 2, 1, 1 );
    wait 1.1;
    var_ae753108f3dff053 = anglestoforward( finalangles ) * 300;
    var_ae753108f3dff053 *= ( 1, 1, 0 );
    
    if ( isdefined( player ) && isdefined( player.spectatorcament ) )
    {
        self moveto( var_9813182985677b23 + var_ae753108f3dff053, 15, 1, 1 );
        player earthquakeforplayer( 0.03, 15, var_9813182985677b23 + var_ae753108f3dff053, 1000 );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x7878
// Size: 0xed
function runslamzoomonspawn()
{
    self waittill( "spawned_player" );
    targetpos = self geteye();
    targetangles = self.angles;
    updatesessionstate( "spectator" );
    self cameralinkto( self.spectatorcament, "tag_origin", 1 );
    self visionsetnakedforplayer( "tac_ops_slamzoom", 0.2 );
    self.spectatorcament moveto( targetpos, 0.5 );
    self playlocalsound( "mp_cmd_camera_zoom_in" );
    self clearclienttriggeraudiozone( 0.5 );
    self.spectatorcament rotateto( targetangles, 0.5, 0.5 );
    wait 0.5;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self visionsetnakedforplayer( "", 0 );
    thread playslamzoomflash();
    updatesessionstate( "playing" );
    self cameraunlink();
    self.spectatorcament delete();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x796d
// Size: 0xd8
function playslamzoomflash()
{
    overlay = newclienthudelem( self );
    overlay.x = 0;
    overlay.y = 0;
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.sort = 1;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = 1;
    overlay.foreground = 1;
    overlay setshader( "white", 640, 480 );
    overlay fadeovertime( 0.4 );
    overlay.alpha = 0;
    wait 0.4;
    overlay destroy();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x7a4d
// Size: 0x104
function arm_playstatusdialog( soundname, team )
{
    soundalias = "dx_mpa_ustl_" + soundname;
    soundalias = tolower( soundalias );
    players = undefined;
    
    if ( team == "bothTeams" )
    {
        axisplayers = getteamdata( "axis", "players" );
        alliesplayers = getteamdata( "allies", "players" );
        players = array_combine( axisplayers, alliesplayers );
    }
    else if ( team == "axis" || team == "allies" )
    {
        players = getteamdata( team, "players" );
    }
    
    foreach ( player in players )
    {
        if ( !isbot( player ) )
        {
            player arm_leaderdialogonplayer_internal( soundalias, soundname );
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x7b59
// Size: 0x2f
function arm_playstatusdialogonplayer( soundname )
{
    soundalias = "dx_mpa_ustl_announcer_" + soundname;
    soundalias = tolower( soundalias );
    arm_leaderdialogonplayer_internal( soundalias, soundname );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x7b90
// Size: 0x99
function arm_leaderdialogonplayer_internal( soundalias, dialog )
{
    if ( isdefined( self.playerlastdialogstatus ) )
    {
        time = 5000;
        
        if ( gettime() < self.playerlastdialogstatus[ "time" ] + time && self.playerlastdialogstatus[ "dialog" ] == dialog )
        {
            return;
        }
        
        self.playerlastdialogstatus[ "time" ] = gettime();
        self.playerlastdialogstatus[ "dialog" ] = dialog;
    }
    
    if ( soundexists( soundalias ) )
    {
        self queuedialogforplayer( soundalias, dialog, 2 );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x7c31
// Size: 0x51b
function managec130spawns()
{
    level endon( "game_ended" );
    var_33bbc02aca0008b = 6000;
    c130height = 12000;
    var_f382830cb3a96bf9 = 20000;
    var_b34d9378696e10bb = 1;
    var_2b4ee773f94cedcf = ( 0, 0, 6000 );
    level.timebetweenc130passes = 0;
    level.flighttime = 20;
    level.spawnc130 = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.spawnc130[ entry ] = undefined;
    }
    
    c130_pickrandomflightpath();
    level.spawnc130[ "axis" ] = createc130( "axis", level.c130pathstruct_a.startpt + var_2b4ee773f94cedcf );
    level.spawnc130[ "allies" ] = createc130( "allies", level.c130pathstruct_b.startpt + var_2b4ee773f94cedcf );
    
    while ( !isdefined( level.spawnselectionlocations ) )
    {
        waitframe();
    }
    
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        if ( !isdefined( level.timeuntilnextc130 ) )
        {
            level.timeuntilnextc130 = [];
        }
        
        if ( !isdefined( level.timeuntilnextc130[ "axis" ] ) )
        {
            level.timeuntilnextc130[ "axis" ] = 0;
        }
        
        if ( !isdefined( level.timeuntilnextc130[ "allies" ] ) )
        {
            level.timeuntilnextc130[ "allies" ] = 0;
        }
        
        timeuntilnextc130 = gettime() + ( level.flighttime + level.timebetweenc130passes ) * 1000;
        level.timeuntilnextc130[ "axis" ] = timeuntilnextc130;
        level.timeuntilnextc130[ "allies" ] = timeuntilnextc130;
        
        if ( false )
        {
            thread drawline( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1000, ( 1, 0, 0 ) );
            thread drawline( level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1000, ( 0, 0, 1 ) );
        }
        
        if ( var_b34d9378696e10bb )
        {
            level.spawnc130[ "axis" ] thread handlec130motion( level.c130pathstruct_a.startpt + var_2b4ee773f94cedcf, level.c130pathstruct_a.endpt + var_2b4ee773f94cedcf, level.flighttime, "axis" );
            level.spawnc130[ "allies" ] thread handlec130motion( level.c130pathstruct_b.startpt + var_2b4ee773f94cedcf, level.c130pathstruct_b.endpt + var_2b4ee773f94cedcf, level.flighttime, "allies" );
        }
        else
        {
            level.spawnc130[ "axis" ] thread handlec130motion( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, level.flighttime, "axis" );
            level.spawnc130[ "allies" ] thread handlec130motion( level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, level.flighttime, "allies" );
        }
        
        level.c130firstpassstarted = 1;
        level waittill_all_in_array( [ "C130_path_complete_axis", "C130_path_complete_allies" ] );
        c130_fightpathmove();
        temppt = level.c130pathstruct_a.startpt;
        level.c130pathstruct_a.startpt = level.c130pathstruct_a.endpt;
        level.c130pathstruct_a.endpt = temppt;
        temppt = level.c130pathstruct_b.startpt;
        level.c130pathstruct_b.startpt = level.c130pathstruct_b.endpt;
        level.c130pathstruct_b.endpt = temppt;
        var_b34d9378696e10bb = 0;
        
        if ( istrue( level.usec130spawnfirstonly ) )
        {
            level.usec130spawn = 0;
            break;
        }
    }
    
    scripts\mp\spawnselection::removedynamicspawnarea( "axis", "dynamic_c130" );
    scripts\mp\spawnselection::removedynamicspawnarea( "allies", "dynamic_c130" );
    scripts\mp\spawnselection::removespawnlocation( "dynamic_c130", "axis" );
    scripts\mp\spawnselection::removespawnlocation( "dynamic_c130", "allies" );
    level.spawnc130[ "axis" ] delete();
    level.spawnc130[ "allies" ] delete();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x8154
// Size: 0x112
function createc130( team, startpt )
{
    gunship = spawn( "script_model", startpt );
    gunship setmodel( "veh8_mil_air_acharlie130" );
    gunship setcandamage( 0 );
    gunship.maxhealth = 100000;
    gunship.health = gunship.maxhealth;
    gunship.playeroffsets = [ ( 32, 30, 0 ), ( -32, 30, 0 ), ( 0, 30, 0 ), ( 16, 30, 0 ), ( -16, 30, 0 ) ];
    gunship.currentplayeroffset = 0;
    gunship.respawnqueue = [];
    gunship.players = [];
    gunship.team = team;
    gunship playloopsound( "iw8_ks_ac130_lp" );
    gunship thread scripts\mp\gametypes\br_c130::gunship_spawnvfx();
    return gunship;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 4
// Checksum 0x0, Offset: 0x826f
// Size: 0x1e4
function handlec130motion( startpt, endpt, time, team )
{
    toend = vectornormalize( endpt - startpt );
    dist = distance( endpt, startpt );
    var_92a519173221837e = startpt + toend * dist * 0.425;
    var_e7c3539b6fc3114f = startpt + toend * dist * 0.55;
    introtime = time * 0.3;
    dropofftime = time * 0.6;
    outrotime = time * 0.1;
    self.canjoin = 1;
    self.canparachute = 0;
    dir = vectornormalize( endpt - startpt );
    self.angles = vectortoangles( dir );
    self.origin = startpt;
    gatherc130playerstospawn();
    self moveto( endpt, introtime + dropofftime + outrotime, introtime * 0.25 );
    wait introtime;
    self.canparachute = 1;
    
    foreach ( p in self.players )
    {
        p notify( "canParachute" );
    }
    
    wait dropofftime;
    self.canjoin = 0;
    self.canparachute = 0;
    
    foreach ( p in self.players )
    {
        p notify( "halo_kick_c130" );
    }
    
    wait outrotime;
    level notify( "C130_path_complete_" + team );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x845b
// Size: 0x108
function gatherc130playerstospawn()
{
    self.players = array_combine( self.players, self.respawnqueue );
    self.respawnqueue = [];
    radius = 1400;
    spawnoffset = ( 30, 0, 0 );
    initialoffset = anglestoforward( spawnoffset ) * radius * -1;
    spawnpos = self gettagorigin( "tag_origin" ) + initialoffset;
    spawnang = self.angles;
    
    foreach ( p in self.players )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        p.forcespawncameraorg = spawnpos;
        p.forcespawncameraang = spawnang;
        p notify( "c130_ready" );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x856b
// Size: 0x14
function removefromspawnselectionaftertime( time )
{
    wait time;
    removefromspawnselection();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x8587
// Size: 0x2c
function removefromspawnselection()
{
    scripts\mp\spawnselection::removedynamicspawnarea( self.team, "dynamic_c130" );
    scripts\mp\spawnselection::removespawnlocation( "dynamic_c130", self.team );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x85bb
// Size: 0x103
function spawnplayertoc130()
{
    self endon( "disconnect" );
    
    if ( !isdefined( level.spawnc130[ self.team ] ) )
    {
        return;
    }
    
    self waittill( "spawn_camera_idle" );
    c130 = level.spawnc130[ self.team ];
    c130.respawnqueue[ c130.respawnqueue.size ] = self;
    
    if ( istrue( c130.canjoin ) )
    {
        c130 gatherc130playerstospawn();
    }
    
    if ( istrue( self.inspawncamera ) )
    {
        self waittill( "spawn_camera_complete" );
    }
    else
    {
        self waittill( "spawned_player" );
    }
    
    val::set( "spawnPlayerToC130", "killstreaks", 0 );
    self disableusability();
    self disableoffhandweapons();
    self allowmelee( 0 );
    self allowads( 0 );
    self allowfire( 0 );
    self setcandamage( 0 );
    thread jumplistener( c130, 0 );
    self.br_infil_type = "c130";
    
    if ( !isbot( self ) )
    {
        thread scripts\mp\gametypes\br_c130::orbitcam( c130 );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x86c6
// Size: 0x6a
function jumplistener( c130, var_1b89121ef11344d5 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self notify( "jumpListener()" );
    self endon( "jumpListener()" );
    
    if ( isdefined( self.parachute ) )
    {
        self.parachute delete();
    }
    
    self.c130 = c130;
    thread listenjump( c130, var_1b89121ef11344d5 );
    thread listenkick( c130, var_1b89121ef11344d5 );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x8738
// Size: 0x93
function listenkick( c130, forcechute )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "br_jump" );
    self notify( "listenKick()" );
    self endon( "listenKick()" );
    self waittill( "halo_kick_c130" );
    self cameradefault();
    self unlink();
    wait 0.1;
    
    if ( self.sessionstate == "spectator" )
    {
        return;
    }
    
    var_f9805aad354a150e = c130 scripts\mp\gametypes\br_helicopters::calctrailpoint();
    thread parachute( c130, forcechute );
    self notify( "br_jump" );
    self notify( "stop_cam_shake" );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x87d3
// Size: 0xfb
function listenjump( c130, var_1b89121ef11344d5 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "br_jump" );
    self notify( "listenJump()" );
    self endon( "listenJump()" );
    self notifyonplayercommand( "halo_jump_c130", "+gostand" );
    
    while ( true )
    {
        result = waittill_either( "halo_jump_c130", "canParachute" );
        
        if ( isdefined( result ) && result == "canParachute" )
        {
            self iprintlnbold( "Press Jump to Parachute!" );
        }
        else if ( !istrue( c130.canparachute ) )
        {
            self iprintlnbold( "Not over the AO" );
        }
        else
        {
            break;
        }
        
        if ( self.sessionstate == "spectator" )
        {
            return;
        }
    }
    
    println( "<dev string:x1c>" );
    self cameradefault();
    self unlink();
    wait 0.1;
    thread parachute( c130, var_1b89121ef11344d5 );
    self notify( "br_jump" );
    self notify( "stop_cam_shake" );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x88d6
// Size: 0x1bc
function parachute( c130, var_1b89121ef11344d5 )
{
    self endon( "jumpListener()" );
    self notify( "parachute()" );
    self endon( "parachute()" );
    
    if ( self.team == "axis" )
    {
        var_69dbcc65237ec970 = level.c130pathstruct_b.midpt;
    }
    else
    {
        var_69dbcc65237ec970 = level.c130pathstruct_a.midpt;
    }
    
    tofrontline = vectornormalize( var_69dbcc65237ec970 - c130.origin );
    c130.players = array_remove( c130.players, self );
    
    if ( isdefined( c130.playeroffsets ) && isdefined( c130.currentplayeroffset ) )
    {
        offset = c130.playeroffsets[ c130.currentplayeroffset ];
        self setorigin( c130.origin + offset, 1, 1 );
        c130.currentplayeroffset++;
        
        if ( c130.currentplayeroffset == c130.playeroffsets.size )
        {
            c130.currentplayeroffset = 0;
        }
    }
    else
    {
        worldoffset = anglestoforward( c130.angles ) * c130.br_vieworigin;
        self setorigin( c130.origin + worldoffset, 1, 1 );
    }
    
    waitframe();
    scripts\cp_mp\utility\player_utility::function_6fb380927695ee76();
    scripts\cp_mp\utility\player_utility::function_985b0973f29da4f8( "risk::parachute()" );
    self.plotarmor = 0;
    self.c130 = undefined;
    self setplayerangles( vectortoangles( tofrontline ) );
    thread scripts\cp_mp\parachute::startfreefall( 5, 0 );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x8a9a
// Size: 0x165
function debug_randomflightpathstest()
{
    wait 10;
    
    while ( true )
    {
        c130_pickrandomflightpath();
        level.c130pathstruct_a.startpt -= ( 0, 0, 10000 );
        level.c130pathstruct_a.endpt -= ( 0, 0, 10000 );
        level.c130pathstruct_b.startpt -= ( 0, 0, 10000 );
        level.c130pathstruct_b.endpt -= ( 0, 0, 10000 );
        thread drawline( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 1, ( 1, 0, 1 ) );
        thread drawline( level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 1, ( 1, 0, 1 ) );
        wait 1;
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x8c07
// Size: 0x490
function c130_pickrandomflightpath()
{
    if ( istrue( level.c130alignedtolocale ) && istrue( level.useobjectives ) )
    {
        mapcenter = level.mapcenter;
        var_f3c9e115b49a626a = vectortoangles( mapcenter - level.gw_objstruct.hqloc[ 0 ].trigger.origin );
        angle = var_f3c9e115b49a626a[ 1 ];
        
        if ( false )
        {
            thread drawsphere( mapcenter, 1000, 100000, ( 0, 1, 0 ) );
        }
    }
    else
    {
        mapcenter = ( level.mapsafecorners[ 0 ] + level.mapsafecorners[ 1 ] ) * 0.5;
        angle = randomfloatrange( 0, 359 );
    }
    
    c130params = makec130pathparamsstruct( mapcenter, angle - 90 );
    level.c130pathstruct_a = scripts\mp\gametypes\br_c130::makepathstruct( c130params );
    c130params.randomangle += 180;
    level.c130pathstruct_b = scripts\mp\gametypes\br_c130::makepathstruct( c130params );
    var_3abadab203328ad1 = 0.2;
    randomxoffset = 0;
    randomyoffset = 0;
    
    if ( istrue( level.c130spacing_usebigmapsettings ) )
    {
        var_3abadab203328ad1 = 0.1;
        randomxoffset = randomfloatrange( -5000, 5000 );
        randomyoffset = randomfloatrange( -5000, 5000 );
    }
    
    right = anglestoright( level.c130pathstruct_a.angle );
    level.c130pathstruct_a.startpt = right * level.c130distapart + level.c130pathstruct_a.startpt;
    level.c130pathstruct_a.endpt = right * level.c130distapart + level.c130pathstruct_a.endpt;
    right = anglestoright( level.c130pathstruct_b.angle );
    level.c130pathstruct_b.startpt = right * level.c130distapart + level.c130pathstruct_b.startpt;
    level.c130pathstruct_b.endpt = right * level.c130distapart + level.c130pathstruct_b.endpt;
    offset = ( randomxoffset, randomyoffset, 0 );
    level.c130pathstruct_a.startpt += offset;
    level.c130pathstruct_a.endpt += offset;
    level.c130pathstruct_a.midpt = vectorlerp( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5 );
    level.c130pathstruct_b.startpt += offset;
    level.c130pathstruct_b.endpt += offset;
    level.c130pathstruct_b.midpt = vectorlerp( level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5 );
    level.battlecenter = vectorlerp( level.c130pathstruct_a.midpt, level.c130pathstruct_b.midpt, 0.5 );
    level.c130minpathmovementinterval = vectorlerp( level.c130pathstruct_a.startpt, level.c130pathstruct_b.endpt, var_3abadab203328ad1 );
    level.c130minpathmovementinterval -= level.c130pathstruct_a.startpt;
    level.c130minpathmovementinterval = vectornormalize( level.c130minpathmovementinterval ) * level.c130distapart / 10;
    level.c130minpathmovementinterval = ( level.c130minpathmovementinterval[ 0 ], level.c130minpathmovementinterval[ 1 ], 0 );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x909f
// Size: 0x93
function makec130pathparamsstruct( centerpt, angle )
{
    twopi = 6.28318;
    randomangle = angle;
    endangleoffset = 180;
    r = level.c130flightdist;
    paramstruct = spawnstruct();
    paramstruct.r = r;
    paramstruct.randomangle = randomangle;
    paramstruct.endangleoffset = endangleoffset;
    paramstruct.centerpt = centerpt;
    return paramstruct;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x913b
// Size: 0x669
function c130_fightpathmove()
{
    if ( false )
    {
        level.c130movementmethod = 2;
    }
    
    if ( level.c130movementmethod == 0 )
    {
        return;
    }
    
    if ( level.c130movementmethod == 1 )
    {
        if ( false )
        {
            level.c130pathkilltracker[ "axis" ] = 1;
            level.c130pathkilltracker[ "allies" ] = 0;
        }
        
        if ( level.c130pathkilltracker[ "axis" ] > level.c130pathkilltracker[ "allies" ] )
        {
            if ( arenextpathsinsafebounds( level.c130minpathmovementinterval ) )
            {
                level.c130pathstruct_a.startpt += level.c130minpathmovementinterval;
                level.c130pathstruct_a.endpt += level.c130minpathmovementinterval;
                level.c130pathstruct_b.startpt += level.c130minpathmovementinterval;
                level.c130pathstruct_b.endpt += level.c130minpathmovementinterval;
            }
        }
        else if ( arenextpathsinsafebounds( level.c130minpathmovementinterval * -1 ) )
        {
            level.c130pathstruct_a.startpt -= level.c130minpathmovementinterval;
            level.c130pathstruct_a.endpt -= level.c130minpathmovementinterval;
            level.c130pathstruct_b.startpt -= level.c130minpathmovementinterval;
            level.c130pathstruct_b.endpt -= level.c130minpathmovementinterval;
        }
        
        level.c130pathstruct_a.midpt = vectorlerp( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5 );
        level.c130pathstruct_b.midpt = vectorlerp( level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5 );
        level.c130pathkilltracker[ "axis" ] = 0;
        level.c130pathkilltracker[ "allies" ] = 0;
        return;
    }
    
    if ( level.c130movementmethod == 2 )
    {
        var_d320310339164aac = ( 0, 0, 0 );
        var_ee6d8b534c2ddd2d = ( 0, 0, 0 );
        var_6d48eb54c3a800fc = 0;
        var_9297d08353baf063 = 0;
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                if ( player.team == "axis" )
                {
                    var_d320310339164aac += player.origin;
                    var_6d48eb54c3a800fc++;
                    continue;
                }
                
                if ( player.team == "allies" )
                {
                    var_ee6d8b534c2ddd2d += player.origin;
                    var_9297d08353baf063++;
                }
            }
        }
        
        if ( var_6d48eb54c3a800fc == 0 || var_9297d08353baf063 == 0 )
        {
            return;
        }
        
        axiscenter = var_d320310339164aac / var_6d48eb54c3a800fc;
        alliescenter = var_ee6d8b534c2ddd2d / var_9297d08353baf063;
        var_be2c550023fb372 = vectorlerp( axiscenter, alliescenter, 0.5 );
        level.c130minpathmovementinterval = vectorlerp( level.battlecenter, var_be2c550023fb372, 0.5 );
        level.c130minpathmovementinterval -= level.battlecenter;
        var_37dfb4f272c7016d = distance2d( level.battlecenter, var_be2c550023fb372 );
        level.c130minpathmovementinterval = vectornormalize( level.c130minpathmovementinterval ) * var_37dfb4f272c7016d / 4;
        level.c130minpathmovementinterval = ( level.c130minpathmovementinterval[ 0 ], level.c130minpathmovementinterval[ 1 ], 0 );
        
        if ( arenextpathsinsafebounds( level.c130minpathmovementinterval ) )
        {
            level.c130pathstruct_a.startpt += level.c130minpathmovementinterval;
            level.c130pathstruct_a.endpt += level.c130minpathmovementinterval;
            level.c130pathstruct_a.midpt = vectorlerp( level.c130pathstruct_a.startpt, level.c130pathstruct_a.endpt, 0.5 );
            level.c130pathstruct_b.startpt += level.c130minpathmovementinterval;
            level.c130pathstruct_b.endpt += level.c130minpathmovementinterval;
            level.c130pathstruct_b.midpt = vectorlerp( level.c130pathstruct_b.startpt, level.c130pathstruct_b.endpt, 0.5 );
            
            if ( false )
            {
                thread drawsphere( level.battlecenter, 1000, 700, ( 1, 0, 0 ) );
                thread drawsphere( var_be2c550023fb372, 1000, 700, ( 0, 1, 0 ) );
            }
            
            level.battlecenter += level.c130minpathmovementinterval;
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x97ac
// Size: 0x83, Type: bool
function arenextpathsinsafebounds( offset )
{
    return ispointinsafebounds( level.c130pathstruct_a.startpt + offset ) && ispointinsafebounds( level.c130pathstruct_a.endpt + offset ) && ispointinsafebounds( level.c130pathstruct_b.startpt + offset ) && ispointinsafebounds( level.c130pathstruct_b.endpt + offset );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x9838
// Size: 0x61, Type: bool
function ispointinsafebounds( pt )
{
    return pt[ 0 ] < level.mapsafecorners[ 0 ][ 0 ] && pt[ 0 ] > level.mapsafecorners[ 1 ][ 0 ] && pt[ 1 ] < level.mapsafecorners[ 0 ][ 1 ] && pt[ 1 ] > level.mapsafecorners[ 1 ][ 1 ];
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x98a2
// Size: 0x15, Type: bool
function function_f69e35a602975879( vehicle, player )
{
    return true;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x98c0
// Size: 0x95
function registervehicletype( refname, spawnvehiclecallback )
{
    assert( isdefined( refname ) );
    vehicleinfo = spawnstruct();
    vehicleinfo.refname = refname;
    vehicleinfo.spawncallback = spawnvehiclecallback;
    vehicleinfo.vehiclespawns = function_b08e7e3a0b14f76f( refname );
    assert( isdefined( vehicleinfo.vehiclespawns ) );
    
    if ( !isdefined( level.vehicleinfo ) )
    {
        level.vehicleinfo = [];
    }
    
    level.vehicleinfo[ refname ] = vehicleinfo;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0x995d
// Size: 0x322
function init_groundwarvehicles()
{
    registervehicletype( "little_bird", &vehiclespawn_littlebird );
    registervehicletype( "atv", &vehiclespawn_atv );
    registervehicletype( "tac_rover", &vehiclespawn_tacrover );
    registervehicletype( "light_tank", &vehiclespawn_tank );
    registervehicletype( "veh9_rhib", &function_91397b675b427da6 );
    registervehicletype( "veh9_jltv", &function_52e04331732241d7 );
    level.vehiclespawnlocs = [];
    level.tankspawnlocs_axis = [];
    level.tankspawnlocs_allies = [];
    
    foreach ( vehicleinfo in level.vehicleinfo )
    {
        foreach ( spawnpoint in vehicleinfo.vehiclespawns )
        {
            index = level.vehiclespawnlocs.size;
            level.vehiclespawnlocs[ index ] = spawnpoint;
            level.vehiclespawnlocs[ index ].refname = vehicleinfo.refname;
        }
    }
    
    if ( false )
    {
        foreach ( loc in level.vehiclespawnlocs )
        {
            thread drawline( loc.origin, loc.origin + ( 0, 0, 1500 ), 1000, ( 1, 0, 0 ) );
        }
    }
    
    level.vehiclespawnlocs = array_randomize( level.vehiclespawnlocs );
    numtospawn = level.numnonrallyvehicles;
    
    if ( !isdefined( level.numnonrallyvehicles ) )
    {
        numtospawn = 25;
    }
    
    if ( false )
    {
        for ( i = 0; i < numtospawn ; i++ )
        {
            loc = level.vehiclespawnlocs[ i ];
            thread drawline( loc.origin + ( 0, 0, 1500 ), loc.origin + ( 0, 0, 2500 ), 1000, ( 0, 1, 0 ) );
        }
    }
    
    for ( i = 0; i < numtospawn ; i++ )
    {
        loc = level.vehiclespawnlocs[ i ];
        
        if ( isdefined( loc ) )
        {
            vehicleinfo = level.vehicleinfo[ loc.refname ];
            [[ vehicleinfo.spawncallback ]]( loc );
        }
    }
    
    scripts\mp\flags::gameflagwait( "prematch_countdown" );
    level.numhqtanks_axis = 0;
    level.numhqtanks_allies = 0;
    thread vehiclespawn_hqtanks( level.tankspawnlocs_axis );
    thread vehiclespawn_hqtanks( level.tankspawnlocs_allies );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0x9c87
// Size: 0x8d
function vehiclespawn_hqtanks( var_9d4b9fcd75d1a736 )
{
    foreach ( loc in var_9d4b9fcd75d1a736 )
    {
        vehicleinfo = level.vehicleinfo[ loc.refname ];
        [[ vehicleinfo.spawncallback ]]( loc );
        wait randomfloatrange( 2, 3 );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x9d1c
// Size: 0x59
function vehiclespawn_littlebird( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "little_bird", spawndata, faildata );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x9d7e
// Size: 0x59
function vehiclespawn_atv( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "atv", spawndata, faildata );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x9de0
// Size: 0x59
function vehiclespawn_tacrover( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "tac_rover", spawndata, faildata );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x9e42
// Size: 0x176
function vehiclespawn_tank( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    spawndata.spawnmethod = "airdrop_at_position_unsafe";
    assert( isdefined( level.numhqtanks_axis ), "<dev string:x40>" );
    assert( isdefined( level.numhqtanks_allies ), "<dev string:x69>" );
    assert( isdefined( level.maxhqtanks ), "<dev string:x94>" );
    
    if ( isdefined( loc.script_team ) && loc.script_team == "axis" )
    {
        if ( level.numhqtanks_axis >= level.maxhqtanks )
        {
            return;
        }
        
        spawndata.usealtmodel = 1;
        spawndata.team = "axis";
        level.numhqtanks_axis++;
    }
    else
    {
        if ( level.numhqtanks_allies >= level.maxhqtanks )
        {
            return;
        }
        
        spawndata.team = "allies";
        level.numhqtanks_allies++;
    }
    
    iav = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "light_tank", spawndata, faildata );
    
    if ( istrue( level.showteamtanks ) )
    {
        vehicle_createspawnselectiontankmarker( iav, iav.team );
    }
    
    return iav;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0x9fc1
// Size: 0x59
function function_91397b675b427da6( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "veh9_rhib", spawndata, faildata );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xa023
// Size: 0x59
function function_52e04331732241d7( loc, faildata )
{
    if ( !isdefined( loc.angles ) )
    {
        loc.angles = ( 0, randomfloat( 360 ), 0 );
    }
    
    spawndata = vehiclespawn_getspawndata( loc );
    return scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "veh9_jltv", spawndata, faildata );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xa085
// Size: 0x1ab
function vehicle_createspawnselectiontankmarker( vehicle, team )
{
    wait 1;
    marker = scripts\mp\gameobjects::createobjidobject( vehicle.origin, team, ( 0, 0, 0 ), undefined, 0, 0 );
    scripts\mp\objidpoolmanager::update_objective_ownerteam( marker.objidnum, team );
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( marker.objidnum );
    scripts\mp\objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    marker.lockupdatingicons = 0;
    scripts\mp\objidpoolmanager::objective_pin_global( marker.objidnum, 0 );
    scripts\mp\objidpoolmanager::update_objective_icon( marker.objidnum, "hud_icon_minimap_vehicle_tank_coscar" );
    scripts\mp\objidpoolmanager::update_objective_setbackground( marker.objidnum, 1 );
    scripts\mp\objidpoolmanager::update_objective_onentity( marker.objidnum, vehicle );
    marker.lockupdatingicons = 1;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && isdefined( player.team ) && player.team == team && istrue( player.inspawnselection ) )
        {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( marker.objidnum, player );
        }
    }
    
    vehicle.spawnselectionmarker = marker;
    thread vehicle_watchmarkedtankdeath( vehicle );
    level.trackedtanks[ team ][ level.trackedtanks[ team ].size ] = vehicle;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0xa238
// Size: 0x6f
function vehicle_watchmarkedtankdeath( vehicle )
{
    objidnum = vehicle.spawnselectionmarker.objidnum;
    team = vehicle.team;
    vehicle waittill( "death" );
    scripts\mp\objidpoolmanager::returnobjectiveid( objidnum );
    level.trackedtanks[ team ] = array_remove( level.trackedtanks[ team ], vehicle );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xa2af
// Size: 0x162
function vehicle_showteamtanks()
{
    self endon( "disconnect" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    foreach ( tank in level.trackedtanks[ self.team ] )
    {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( tank.spawnselectionmarker.objidnum, self );
    }
    
    while ( self.inspawnselection )
    {
        waitframe();
    }
    
    foreach ( tank in level.trackedtanks[ "axis" ] )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( tank.spawnselectionmarker.objidnum, self );
    }
    
    foreach ( tank in level.trackedtanks[ "allies" ] )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( tank.spawnselectionmarker.objidnum, self );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0xa419
// Size: 0x6a
function vehiclespawn_getspawndata( loc )
{
    spawndata = spawnstruct();
    spawndata.origin = loc.origin;
    spawndata.angles = loc.angles;
    spawndata.spawntype = "GAME_MODE";
    spawndata.showheadicon = 1;
    return spawndata;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0xa48c
// Size: 0xae
function droptank_playincomingdialog( spawndata )
{
    team = spawndata.team;
    streakname = "bradley";
    
    if ( level.teambased )
    {
        if ( isdefined( level.killstreakactivatedtime[ streakname ] ) )
        {
            if ( isdefined( level.killstreakactivatedtime[ streakname ][ team ] ) )
            {
                if ( gettime() < level.killstreakactivatedtime[ streakname ][ team ] )
                {
                    return;
                }
            }
        }
        
        level.killstreakactivatedtime[ streakname ][ team ] = gettime() + scripts\cp_mp\utility\killstreak_utility::getkillstreakdialogcooldown() * 1000;
    }
    
    leaderdialog( team + "_friendly_" + streakname + "_inbound", team, "killstreak_used" );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xa542
// Size: 0x369
function init_rallyvehicles()
{
    while ( !isdefined( level.spawnselectionlocations ) )
    {
        waitframe();
    }
    
    waitframe();
    level.rallypointvehicles = [];
    var_13b8accbd9c63733 = getstructarray( "rallyPointAPC", "targetname" );
    
    foreach ( loc in var_13b8accbd9c63733 )
    {
        if ( isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) && isdefined( loc.script_noteworthy ) && loc.script_noteworthy != level.localeid )
        {
            continue;
        }
        
        team = ter_op( loc.script_team == "axis", "axis", "allies" );
        spawndata = getrallyvehiclespawndata( loc, team );
        
        if ( team == "allies" )
        {
            spawndata.usealtmodel = 1;
        }
        
        faildata = spawnstruct();
        vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "apc_russian", spawndata, faildata );
        
        if ( isdefined( vehicle ) )
        {
            level.rallypointvehicles[ level.rallypointvehicles.size ] = vehicle;
        }
    }
    
    foreach ( entry in level.teamnamelist )
    {
        while ( !isdefined( level.availablespawnlocations[ entry ][ 0 ] ) )
        {
            waitframe();
        }
    }
    
    var_ca3c2fdf46ba3669 = 0;
    var_31343980cbc746e5 = 0;
    var_245e307f2c92ca2 = 0;
    var_660828356d2f44da = 0;
    var_fb299e7e5d830989 = 0;
    var_29354b69bd8def17 = "gw_vehicle_technical_";
    var_e6fe9018451c854c = "gw_vehicle_apc_";
    
    foreach ( vehicle in level.rallypointvehicles )
    {
        spawndata = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata( vehicle );
        
        if ( !isdefined( spawndata.rallypointhealth ) )
        {
            spawndata.rallypointhealth = vehicle.health;
        }
        else
        {
            vehicle.health = spawndata.rallypointhealth;
        }
        
        index = 0;
        ref = undefined;
        
        if ( vehicle.team == "axis" )
        {
            if ( vehicle.vehiclename == "apc_russian" )
            {
                var_245e307f2c92ca2++;
                
                if ( var_245e307f2c92ca2 <= 2 )
                {
                    spawndata.ref = var_e6fe9018451c854c + var_245e307f2c92ca2;
                }
                else
                {
                    assert( 0, "<dev string:xb8>" );
                }
            }
        }
        else if ( vehicle.vehiclename == "apc_russian" )
        {
            var_fb299e7e5d830989++;
            
            if ( var_fb299e7e5d830989 <= 2 )
            {
                spawndata.ref = var_e6fe9018451c854c + var_fb299e7e5d830989;
            }
            else
            {
                assert( 0, "<dev string:x119>" );
            }
        }
        
        if ( istrue( level.userallypointvehicles ) && level.userallypointvehicles != 2 )
        {
            watchvehicleforrallypointactivation( vehicle );
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0xa8b3
// Size: 0x13
function watchvehicleforrallypointactivation( vehicle )
{
    scripts\mp\rally_point::rallypointvehicle_activate( vehicle );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xa8ce
// Size: 0x7f
function getrallyvehiclespawndata( loc, team )
{
    spawndata = spawnstruct();
    spawndata.origin = loc.origin;
    spawndata.angles = loc.angles;
    spawndata.spawntype = "GAME_MODE";
    spawndata.cannotbesuspended = 1;
    spawndata.team = team;
    return spawndata;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xa956
// Size: 0xc7
function arm_initoutofbounds()
{
    level.outofboundstriggers = [];
    potentialoobtriggers = getentarray( "OutOfBounds", "targetname" );
    
    foreach ( trigger in potentialoobtriggers )
    {
        if ( isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) && isdefined( trigger.script_noteworthy ) && trigger.script_noteworthy == level.localeid && scripts\mp\utility\game_utility_mp::modeusesgroundwarteamoobtriggers( trigger ) )
        {
            level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
            continue;
        }
        
        trigger delete();
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xaa25
// Size: 0x186
function function_2c3c204d81feb239()
{
    level.var_6af5ceb6eec10fea = getdvarint( @"scr_risk_agent_debug_output", 0 );
    
    if ( getdvarint( @"hash_eb48bcb91d80ecee", 0 ) == 1 )
    {
        return;
    }
    else
    {
        /#
            if ( istrue( level.var_6af5ceb6eec10fea ) )
            {
                println( "<dev string:x17c>" );
                println( "<dev string:x1a5>" );
                println( "<dev string:x17c>" );
            }
        #/
    }
    
    scripts\mp\ai_mp_controller::init();
    
    /#
        if ( istrue( level.var_6af5ceb6eec10fea ) )
        {
            println( "<dev string:x17c>" );
            println( "<dev string:x1c4>" );
            println( "<dev string:x17c>" );
        }
    #/
    
    while ( !isdefined( level.spawnselectionlocations ) )
    {
        waitframe();
    }
    
    while ( !isdefined( level.stealth ) )
    {
        waitframe();
    }
    
    while ( !isdefined( level.agentarray ) )
    {
        waitframe();
    }
    
    wait 1;
    var_cfde0d78a0770ce5 = [];
    
    foreach ( objective in level.gw_objstruct.startingfobs_neutral )
    {
        tempstruct = spawnstruct();
        tempstruct.origin = objective.trigger.origin;
        var_cfde0d78a0770ce5[ var_cfde0d78a0770ce5.size ] = tempstruct;
    }
    
    scripts\mp\ai_heli_reinforce::function_16c5ca10b4c664a7( var_cfde0d78a0770ce5, 1 );
    scripts\mp\ai_heli_reinforce::function_bf8ab11dd9e76f93( &function_87b809f69028ff14 );
    function_e417e6ca41953906();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xabb3
// Size: 0x170
function function_e417e6ca41953906()
{
    var_ccff9574f6a53859 = getdvarint( @"hash_f4b8192392c987fc", 25 );
    var_b60a2ad1b8eb2369 = getdvarint( @"hash_8eec5964fbfe4a41", 5 );
    
    /#
        if ( istrue( level.var_6af5ceb6eec10fea ) )
        {
            println( "<dev string:x17c>" );
            println( "<dev string:x1ea>" );
            println( "<dev string:x20b>" + var_ccff9574f6a53859 );
            println( "<dev string:x225>" + var_b60a2ad1b8eb2369 );
            println( "<dev string:x23a>" + level.agentarray.size );
            println( "<dev string:x24e>" + isdefined( level.stealth ) );
            println( "<dev string:x17c>" );
        }
    #/
    
    possiblelocations = [];
    
    foreach ( key, data in level.spawnselectionlocations )
    {
        if ( issubstr( key, "_hq_" ) )
        {
            continue;
        }
        
        possiblelocations[ key ] = data;
    }
    
    var_6c95bb29db70af0c = possiblelocations.size * var_ccff9574f6a53859 / 100;
    objkeys = array_randomize( getarraykeys( possiblelocations ) );
    
    for ( i = 0; i < var_6c95bb29db70af0c ; i++ )
    {
        function_4c69bcdd9f13c968( var_b60a2ad1b8eb2369, objkeys[ i ], "team_six", 1 );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 4
// Checksum 0x0, Offset: 0xad2b
// Size: 0x2c1
function function_4c69bcdd9f13c968( numagents, objectivename, team, var_fd9831032cddaa89 )
{
    var_fd5ea9cb37c309d3 = [];
    
    if ( istrue( var_fd9831032cddaa89 ) )
    {
        foreach ( team in level.spawnselectionlocations[ objectivename ] )
        {
            var_fd5ea9cb37c309d3 = array_combine( var_fd5ea9cb37c309d3, team.spawnpoints );
        }
    }
    
    agents = [];
    
    for ( i = 0; i < numagents ; i++ )
    {
        loc = random( var_fd5ea9cb37c309d3 );
        agent = undefined;
        
        if ( isdefined( loc ) && isdefined( loc.origin ) && isdefined( loc.angles ) && isdefined( objectivename ) )
        {
            aitype = function_d5bc07eabf352abb();
            agent = ai_mp_requestspawnagent( aitype, loc.origin, loc.angles, "medium", "everybody", undefined, objectivename );
            
            /#
                if ( !isdefined( agent ) && istrue( level.var_6af5ceb6eec10fea ) )
                {
                    println( "<dev string:x17c>" );
                    println( "<dev string:x262>" );
                    println( "<dev string:x284>" + aitype );
                    println( "<dev string:x290>" + loc.origin );
                    println( "<dev string:x29b>" + loc.angles );
                    println( "<dev string:x17c>" );
                }
            #/
        }
        
        agents[ agents.size ] = agent;
    }
    
    objectiveorigin = undefined;
    
    foreach ( objective in level.gw_objstruct.startingfobs_neutral )
    {
        if ( objective.name == objectivename )
        {
            objectiveorigin = objective.trigger.origin;
            break;
        }
    }
    
    foreach ( agent in agents )
    {
        if ( isalive( agent ) && isdefined( agent ) )
        {
            if ( isdefined( objectiveorigin ) )
            {
                agent function_304da84d9a815c01( getclosestpointonnavmesh( objectiveorigin ), 1024 );
            }
            
            agent scripts\stealth\enemy::bt_set_stealth_state( "combat", undefined );
            agent.var_9a04c6cfe15e92a7 = objectiveorigin;
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 3
// Checksum 0x0, Offset: 0xaff4
// Size: 0x71
function function_e0ae27a2065777ac( objectivekey, numagents, team )
{
    if ( !isdefined( team ) )
    {
        return undefined;
    }
    
    objectiveorigin = level.objectives[ objectivekey ].trigger.origin;
    agents = scripts\mp\ai_heli_reinforce::function_3779deb97b61a65( numagents, objectiveorigin, "medium", "everybody", "heli", objectivekey, team );
    return agents;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 3
// Checksum 0x0, Offset: 0xb06e
// Size: 0x75
function function_eb051cd1ea2a236e( objectivekey, numagents, team )
{
    if ( !isdefined( team ) )
    {
        return undefined;
    }
    
    objectiveorigin = level.objectives[ objectivekey ].trigger.origin;
    agents = namespace_885300a47c2b51e6::function_55ab9c6da96226e7( numagents, objectiveorigin, objectiveorigin[ 2 ] + 5000, undefined, "medium", "everybody", undefined, team );
    return agents;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 3
// Checksum 0x0, Offset: 0xb0ec
// Size: 0x80
function function_87b809f69028ff14( desired_origin, var_93390a6953905fef, team )
{
    org_struct = spawnstruct();
    org_struct.origin = desired_origin;
    unload_locs = sortbydistance( level.helireinforcestruct.unload_locs, org_struct.origin );
    pathnode = scripts\mp\ai_heli_reinforce::function_321665dcdcbf401e( unload_locs, desired_origin );
    
    if ( isdefined( pathnode ) )
    {
        return pathnode;
    }
    
    return undefined;
}

/#

    // Namespace risk / scripts\mp\gametypes\risk
    // Params 1
    // Checksum 0x0, Offset: 0xb175
    // Size: 0x19, Type: dev
    function debugprint( text )
    {
        if ( false )
        {
            println( text );
        }
    }

#/

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0xb196
// Size: 0x9a
function isobjectivecontested( gameobject )
{
    if ( gameobject.ownerteam != "neutral" )
    {
        enemyteams = getenemyteams( gameobject.ownerteam );
        
        foreach ( enemyteam in enemyteams )
        {
            if ( gameobject.numtouching[ enemyteam ] > 0 )
            {
                return 1;
            }
        }
        
        return 0;
    }
    
    return 0;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0xb238
// Size: 0x76
function calculateobjectivesheld( team )
{
    var_ae82e8f18ca8e0fe = 0;
    
    foreach ( objective in level.objectives )
    {
        if ( objective.ownerteam == team )
        {
            var_ae82e8f18ca8e0fe++;
        }
    }
    
    return var_ae82e8f18ca8e0fe;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 12
// Checksum 0x0, Offset: 0xb2b7
// Size: 0x1b7
function createhintobject( org, type, icon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov, useent )
{
    hintobj = undefined;
    
    if ( isdefined( useent ) )
    {
        hintobj = useent;
    }
    else
    {
        hintobj = spawn( "script_model", org );
    }
    
    hintobj makeusable();
    
    if ( isdefined( useent ) && isdefined( org ) )
    {
        assertex( isstring( org ), "<dev string:x2a7>" );
        hintobj sethinttag( org );
    }
    
    if ( isdefined( type ) )
    {
        hintobj setcursorhint( type );
    }
    else
    {
        hintobj setcursorhint( "HINT_NOICON" );
    }
    
    if ( isdefined( icon ) )
    {
        hintobj sethinticon( icon );
    }
    
    if ( isdefined( hintstring ) )
    {
        hintobj sethintstring( hintstring );
    }
    
    if ( isdefined( priority ) )
    {
        hintobj setusepriority( priority );
    }
    else
    {
        hintobj setusepriority( 0 );
    }
    
    if ( isdefined( duration ) )
    {
        hintobj setuseholdduration( duration );
    }
    else
    {
        hintobj setuseholdduration( "duration_short" );
    }
    
    if ( isdefined( onobstruction ) )
    {
        hintobj sethintonobstruction( onobstruction );
    }
    else
    {
        hintobj sethintonobstruction( "hide" );
    }
    
    if ( isdefined( hintdist ) )
    {
        hintobj sethintdisplayrange( hintdist );
    }
    else
    {
        hintobj sethintdisplayrange( 200 );
    }
    
    if ( isdefined( hintfov ) )
    {
        hintobj sethintdisplayfov( hintfov );
    }
    else
    {
        hintobj sethintdisplayfov( 160 );
    }
    
    if ( isdefined( usedist ) )
    {
        hintobj setuserange( usedist );
    }
    else
    {
        hintobj setuserange( 50 );
    }
    
    if ( isdefined( usefov ) )
    {
        hintobj setusefov( usefov );
    }
    else
    {
        hintobj setusefov( 120 );
    }
    
    if ( !isdefined( useent ) )
    {
        return hintobj;
    }
}

/#

    // Namespace risk / scripts\mp\gametypes\risk
    // Params 0
    // Checksum 0x0, Offset: 0xb476
    // Size: 0x409, Type: dev
    function function_9c513c5e546a4f52()
    {
        setdevdvar( @"hash_24d9f7f9324e9c61", 0 );
        
        while ( true )
        {
            if ( getdvar( @"hash_24d9f7f9324e9c61" ) != "<dev string:x307>" )
            {
                if ( isdefined( level.lane_1_obj_struct ) )
                {
                    foreach ( cluster in level.lane_1_obj_struct.clustertriggers )
                    {
                        foreach ( objective in cluster.domobjectives )
                        {
                            thread drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                        }
                    }
                }
                
                if ( isdefined( level.lane_2_obj_struct ) )
                {
                    foreach ( cluster in level.lane_2_obj_struct.clustertriggers )
                    {
                        foreach ( objective in cluster.domobjectives )
                        {
                            thread drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                        }
                    }
                }
                
                if ( isdefined( level.lane_3_obj_struct ) )
                {
                    foreach ( cluster in level.lane_3_obj_struct.clustertriggers )
                    {
                        foreach ( objective in cluster.domobjectives )
                        {
                            thread drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                        }
                    }
                }
                
                if ( isdefined( level.tdmzones[ "<dev string:x30c>" ] ) )
                {
                    foreach ( objective in level.tdmzones[ "<dev string:x30c>" ] )
                    {
                        thread drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                    }
                }
                
                if ( isdefined( level.tdmzones[ "<dev string:x312>" ] ) )
                {
                    foreach ( objective in level.tdmzones[ "<dev string:x312>" ] )
                    {
                        thread drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                    }
                }
                
                if ( isdefined( level.tdmzones[ "<dev string:x318>" ] ) )
                {
                    foreach ( objective in level.tdmzones[ "<dev string:x318>" ] )
                    {
                        thread drawsphere( objective.origin, 20, 1, ( 1, 1, 1 ) );
                    }
                }
            }
            
            wait 1;
        }
    }

    // Namespace risk / scripts\mp\gametypes\risk
    // Params 1
    // Checksum 0x0, Offset: 0xb887
    // Size: 0x4ca, Type: dev
    function function_e3a2a0c2e544728e( var_a4ab3e1ca5d220c4 )
    {
        if ( var_a4ab3e1ca5d220c4 <= 5 )
        {
            key = "<dev string:x31e>" + var_a4ab3e1ca5d220c4;
            spawns_axis = level.spawnselectionlocations[ key ][ "<dev string:x32a>" ].spawnpoints;
            spawns_allies = level.spawnselectionlocations[ key ][ "<dev string:x332>" ].spawnpoints;
            
            foreach ( spawnpos in spawns_axis )
            {
                thread drawsphere( spawnpos.origin, 30, 60, ( 1, 0, 0 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
                thread drawline( spawnpos.origin, spawnpos.origin + ( 0, 0, 1000 ), 60, ( 1, 0, 0 ) );
            }
            
            foreach ( spawnpos in spawns_allies )
            {
                thread drawsphere( spawnpos.origin, 30, 60, ( 0, 0, 1 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
                thread drawline( spawnpos.origin, spawnpos.origin + ( 0, 0, 1000 ), 60, ( 0, 0, 1 ) );
            }
            
            safekey = "<dev string:x31e>" + var_a4ab3e1ca5d220c4 + "<dev string:x33c>";
            var_eb7299174b67818d = undefined;
            var_fd81d96696f0490a = undefined;
            
            if ( isdefined( level.spawnselectionlocations[ safekey ] ) && isdefined( level.spawnselectionlocations[ safekey ][ "<dev string:x32a>" ] ) )
            {
                var_eb7299174b67818d = level.spawnselectionlocations[ safekey ][ "<dev string:x32a>" ].spawnpoints;
            }
            
            if ( isdefined( level.spawnselectionlocations[ safekey ] ) && isdefined( level.spawnselectionlocations[ safekey ][ "<dev string:x332>" ] ) )
            {
                var_fd81d96696f0490a = level.spawnselectionlocations[ safekey ][ "<dev string:x332>" ].spawnpoints;
            }
            
            if ( !isdefined( var_eb7299174b67818d ) )
            {
                var_eb7299174b67818d = spawns_axis;
            }
            
            if ( !isdefined( var_fd81d96696f0490a ) )
            {
                var_fd81d96696f0490a = spawns_allies;
            }
            
            foreach ( spawnpos in var_eb7299174b67818d )
            {
                thread drawsphere( spawnpos.origin, 15, 60, ( 0.5, 0, 0 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
                thread drawline( spawnpos.origin, spawnpos.origin + ( 0, 0, 500 ), 60, ( 0.5, 0, 0 ) );
            }
            
            foreach ( spawnpos in var_fd81d96696f0490a )
            {
                thread drawsphere( spawnpos.origin, 15, 60, ( 0, 0, 0.5 ) );
                vect = anglestoforward( spawnpos.angles ) * 30 + spawnpos.origin;
                thread drawline( spawnpos.origin, vect, 60, ( 0, 1, 0 ) );
                thread drawline( spawnpos.origin, spawnpos.origin + ( 0, 0, 500 ), 60, ( 0, 0, 0.5 ) );
            }
        }
    }

#/

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0xbd59
// Size: 0x981
function getmissedinfilcamerapositions( team )
{
    assert( isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ), "<dev string:x345>" );
    var_b379bc48dc371726 = spawnstruct();
    var_b379bc48dc371726.startorigin = undefined;
    var_b379bc48dc371726.endpos = undefined;
    
    if ( level.mapname == "mp_locale_test" )
    {
        switch ( level.localeid )
        {
            case #"hash_369d88655b32bac0":
            case #"hash_369d96655b32d0ca":
                if ( team == "axis" )
                {
                    var_b379bc48dc371726.startorigin = ( 2094, -1804, 2763 );
                    var_b379bc48dc371726.startangles = ( 54, 40, 0 );
                    var_b379bc48dc371726.endorigin = ( 2094, -1804, 2763 );
                    var_b379bc48dc371726.endangles = ( 54, 40, 0 );
                }
                else
                {
                    var_b379bc48dc371726.startorigin = ( 2315, 1956, 2763 );
                    var_b379bc48dc371726.startangles = ( 54, 296, 0 );
                    var_b379bc48dc371726.endorigin = ( 2094, -1804, 2763 );
                    var_b379bc48dc371726.endangles = ( 54, 40, 0 );
                }
                
                break;
            default:
                var_b379bc48dc371726.startorigin = ( 0, 0, 0 );
                var_b379bc48dc371726.startangles = ( 0, 0, 0 );
                var_b379bc48dc371726.endorigin = ( 0, 0, 0 );
                var_b379bc48dc371726.endangles = ( 0, 0, 0 );
                break;
        }
    }
    else
    {
        switch ( level.localeid )
        {
            case #"hash_369d93655b32cc11":
                if ( team == "axis" )
                {
                    var_b379bc48dc371726.startorigin = ( 38864, -14018, -396 );
                    var_b379bc48dc371726.startangles = ( 3, 250, 0 );
                    var_b379bc48dc371726.endorigin = ( 38473, -14077, 401 );
                    var_b379bc48dc371726.endangles = ( 15, 252, 0 );
                }
                else
                {
                    var_b379bc48dc371726.startorigin = ( 30526, -38262, -483 );
                    var_b379bc48dc371726.startangles = ( 0, 72, 0 );
                    var_b379bc48dc371726.endorigin = ( 30024, -38403, 560 );
                    var_b379bc48dc371726.endangles = ( 19, 67, 0 );
                }
                
                break;
            case #"hash_369d96655b32d0ca":
                if ( team == "axis" )
                {
                    var_b379bc48dc371726.startorigin = ( 16977, -23256, 169 );
                    var_b379bc48dc371726.startangles = ( 9, 69, 0 );
                    var_b379bc48dc371726.endorigin = ( 16899, -23467, 683 );
                    var_b379bc48dc371726.endangles = ( 15, 68, 0 );
                }
                else
                {
                    var_b379bc48dc371726.startorigin = ( 18607, 1423, -355 );
                    var_b379bc48dc371726.startangles = ( 8, 289, 0 );
                    var_b379bc48dc371726.endorigin = ( 18100, 1083, 503 );
                    var_b379bc48dc371726.endangles = ( 22, 302, 0 );
                }
                
                break;
            case #"hash_369d88655b32bac0":
                if ( team == "axis" )
                {
                    var_b379bc48dc371726.startorigin = ( 18672, -26836, -129 );
                    var_b379bc48dc371726.startangles = ( 359, 76, 0 );
                    var_b379bc48dc371726.endorigin = ( 18518, -26909, 314 );
                    var_b379bc48dc371726.endangles = ( 14, 69, 0 );
                }
                else
                {
                    var_b379bc48dc371726.startorigin = ( 18607, 1423, -355 );
                    var_b379bc48dc371726.startangles = ( 8, 289, 0 );
                    var_b379bc48dc371726.endorigin = ( 18100, 1083, 503 );
                    var_b379bc48dc371726.endangles = ( 22, 302, 0 );
                }
                
                break;
            case #"hash_2cd4bf8e90f233e7":
            case #"hash_369d95655b32cf37":
                if ( team == "axis" )
                {
                    var_b379bc48dc371726.startorigin = ( 24893, 28349, 1408 );
                    var_b379bc48dc371726.startangles = ( 15, 54, 0 );
                    var_b379bc48dc371726.endorigin = ( 25613, 29274, 1255 );
                    var_b379bc48dc371726.endangles = ( 19, 53, 0 );
                }
                else
                {
                    var_b379bc48dc371726.startorigin = ( 39490, 48919, 2302 );
                    var_b379bc48dc371726.startangles = ( 17, 235, 0 );
                    var_b379bc48dc371726.endorigin = ( 39254, 48584, 1542 );
                    var_b379bc48dc371726.endangles = ( 18, 245, 0 );
                }
                
                break;
            case #"hash_369d89655b32bc53":
                if ( team == "axis" )
                {
                    var_b379bc48dc371726.startorigin = ( 48331, -24822, 514 );
                    var_b379bc48dc371726.startangles = ( 12, 77, 0 );
                    var_b379bc48dc371726.endorigin = ( 48424, -24421, -240 );
                    var_b379bc48dc371726.endangles = ( 2, 77, 0 );
                }
                else
                {
                    var_b379bc48dc371726.startorigin = ( 46188, 2520, 49 );
                    var_b379bc48dc371726.startangles = ( 7, 295, 0 );
                    var_b379bc48dc371726.endorigin = ( 46571, 2664, 526 );
                    var_b379bc48dc371726.endangles = ( 16, 276, 0 );
                }
                
                break;
            case #"hash_2cd4bd8e90f230c1":
                if ( team == "axis" )
                {
                    var_b379bc48dc371726.startorigin = ( -11083, 22197, 381 );
                    var_b379bc48dc371726.startangles = ( 10, 181, 0 );
                    var_b379bc48dc371726.endorigin = ( -12112, 23761, 381 );
                    var_b379bc48dc371726.endangles = ( 11, 201, 0 );
                }
                else
                {
                    var_b379bc48dc371726.startorigin = ( -31134, 11924, -116 );
                    var_b379bc48dc371726.startangles = ( 0, 36, 0 );
                    var_b379bc48dc371726.endorigin = ( -31134, 11924, 434 );
                    var_b379bc48dc371726.endangles = ( 11, 36, 0 );
                }
                
                break;
            case #"hash_2cd4be8e90f23254":
                if ( team == "axis" )
                {
                    var_b379bc48dc371726.startorigin = ( 9215, 984, 325 );
                    var_b379bc48dc371726.startangles = ( 357, 186, 0 );
                    var_b379bc48dc371726.endorigin = ( 9107, 628, 1144 );
                    var_b379bc48dc371726.endangles = ( 19, 182, 0 );
                }
                else
                {
                    var_b379bc48dc371726.startorigin = ( -5351, 641, 408 );
                    var_b379bc48dc371726.startangles = ( 2, 352, 0 );
                    var_b379bc48dc371726.endorigin = ( -5282, 996, 1103 );
                    var_b379bc48dc371726.endangles = ( 11, 347, 0 );
                }
                
                break;
            case #"hash_2cd4b58e90f22429":
                if ( team == "axis" )
                {
                    var_b379bc48dc371726.startorigin = ( -22847, -28632, 34 );
                    var_b379bc48dc371726.startangles = ( 12, 42, 0 );
                    var_b379bc48dc371726.endorigin = ( -22694, -28429, 356 );
                    var_b379bc48dc371726.endangles = ( 12, 40, 0 );
                }
                else
                {
                    var_b379bc48dc371726.startorigin = ( -8084, -20649, 72 );
                    var_b379bc48dc371726.startangles = ( 10, 185, 0 );
                    var_b379bc48dc371726.endorigin = ( -9092, -20635, 224 );
                    var_b379bc48dc371726.endangles = ( 12, 184, 0 );
                }
                
                break;
            default:
                var_b379bc48dc371726.startorigin = ( 0, 0, 0 );
                var_b379bc48dc371726.startangles = ( 0, 0, 0 );
                var_b379bc48dc371726.endorigin = ( 0, 0, 0 );
                var_b379bc48dc371726.endangles = ( 0, 0, 0 );
                break;
        }
    }
    
    return var_b379bc48dc371726;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xc6e3
// Size: 0x20
function calculatecameraoffset( team, objectiveorigin )
{
    return ( 0, 0, 0 );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xc70c
// Size: 0x2a, Type: bool
function spawnprotectionexception()
{
    if ( isdefined( self.selectedspawnarea ) && issubstr( self.selectedspawnarea, "HQ" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xc73f
// Size: 0x26e
function function_b88ec41808ee3630()
{
    self endon( "death_or_disconnect" );
    self waittill( "spawned_player" );
    spawnheight = getdvarfloat( @"hash_5b1f2fa863c241cf", 20000 );
    spawnorigin = getdvarvector( @"hash_9a34b1db929c0c76", ( 23000, -14000, 0 ) );
    tracecontents = scripts\engine\trace::create_default_contents( 1 );
    
    if ( level.var_1ffd19a2a9a5aa20 )
    {
        var_a77f05e36991ec5 = getdvarfloat( @"hash_3c6081edc25b177b", 0.8 );
        spawncenter = spawnorigin;
        hqorigin = level.gw_objstruct.hqloc[ self.team ].trigger.origin;
        tohq = hqorigin - spawncenter;
        dist = length( tohq );
        dir = vectornormalize( tohq );
        spawnorigin = spawncenter + dir * dist * var_a77f05e36991ec5;
    }
    
    groundorigin = drop_to_ground( spawnorigin, 10000, -20000, undefined, tracecontents );
    spawnorigin = ( spawnorigin[ 0 ], spawnorigin[ 1 ], groundorigin[ 2 ] );
    spawnorigin += ( 0, 0, spawnheight );
    spawnpoint = spawnstruct();
    spawnpoint.origin = spawnorigin;
    spawnpoint.angles = vectortoangles( level.mapcenter - spawnpoint.origin );
    streamorigin = namespace_8bfdb6eb5a3df67a::playerprestreamrespawnorigin( spawnpoint );
    var_ad4dd16f29e24b77 = 0;
    var_dfab0807d83a77fe = 0.5;
    thread scripts\mp\playerlogic::managerespawnfade( var_ad4dd16f29e24b77, var_dfab0807d83a77fe );
    
    if ( var_ad4dd16f29e24b77 > 0 )
    {
        self waittill( "fadeDown_complete" );
    }
    
    self setorigin( spawnpoint.origin );
    self setplayerangles( spawnpoint.angles );
    scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();
    self setorigin( spawnpoint.origin );
    self setplayerangles( spawnpoint.angles );
    
    if ( level.parachutecancutautodeploy )
    {
        self skydive_cutautodeployon();
    }
    else
    {
        self skydive_cutautodeployoff();
    }
    
    if ( level.parachutecancutparachute )
    {
        self skydive_cutparachuteon();
    }
    else
    {
        self skydive_cutparachuteoff();
    }
    
    thread scripts\cp_mp\parachute::startfreefall( level.parachutedeploydelay, 0, undefined, undefined, 1 );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xc9b5
// Size: 0x1a1
function createdefaultcameras()
{
    level.spawncameras[ "default" ] = [];
    camerapos = level.var_f59a46460cc3cab5 + level.var_4b80e3b89ad4842b * level.var_f0ee57fb9ebfb867 + ( 0, 0, level.var_8d385a761d1d2e9f );
    var_6841474d6fed394f = vectornormalize( level.var_f59a46460cc3cab5 - camerapos );
    cameraang = vectortoanglessafe( var_6841474d6fed394f, ( 0, 0, 1 ) );
    camerastruct = spawnstruct();
    camerastruct.origin = camerapos;
    camerastruct.angles = cameraang;
    
    foreach ( entry in level.teamnamelist )
    {
        level.spawncameras[ "default" ][ entry ] = camerastruct;
    }
    
    if ( false )
    {
        thread drawline( camerapos, level.var_f59a46460cc3cab5, 600, ( 1, 0, 1 ) );
    }
    
    teamforward = level.var_4b80e3b89ad4842b;
    level.spawnselectionteamforward = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.spawnselectionteamforward[ entry ] = teamforward;
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xcb5e
// Size: 0x290
function setupspawnlocations()
{
    while ( !isdefined( level.gamemodespawnpointnames ) || !istrue( level.objectivessetup ) )
    {
        waitframe();
    }
    
    level.spawnselectionlocations = [];
    
    foreach ( entry in level.teamnamelist )
    {
        spawns = scripts\mp\spawnlogic::getspawnpointarray( level.gamemodespawnpointnames[ entry ] );
        scripts\mp\spawnlogic::registerspawnpoints( entry, spawns );
        
        foreach ( s in spawns )
        {
            if ( level.var_1ffd19a2a9a5aa20 )
            {
                setupspawnlocation( level.var_6121d66ffc5b8ec9[ entry ], entry, level.gw_objstruct.hqloc[ entry ].trigger.origin, s );
            }
            
            foreach ( obj in level.objectives )
            {
                setupspawnlocation( obj.name, entry, obj.trigger.origin, s );
            }
            
            if ( false )
            {
                thread drawline( s.origin, s.origin + ( 0, 0, 200 ), 600, ( 1, 0, 0 ) );
            }
        }
        
        foreach ( key, teamarray in level.spawnselectionlocations )
        {
            if ( isdefined( teamarray[ entry ] ) )
            {
                scripts\mp\spawnlogic::registerspawnset( key + "_" + entry, teamarray[ entry ].spawnpoints );
            }
        }
    }
    
    level.usespawnselection = scripts\mp\spawnselection::function_167619fe3d0cff00() && level.spawnselectionlocations.size > 0;
    
    if ( level.usespawnselection )
    {
        level.getspawnpoint = &getspawnpoint;
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 4
// Checksum 0x0, Offset: 0xcdf6
// Size: 0x1dd
function setupspawnlocation( ref, team, testorigin, spawnobj )
{
    usedot = getdvarint( @"hash_ca02d03a0895582a", 0 );
    dotthreshold = getdvarfloat( @"hash_3ef27b1b4af37146", 0 );
    distancethreshold = getdvarfloat( @"hash_80f34f05ebff950b", 4000 );
    var_e7f83d51a3c75d98 = testorigin - spawnobj.origin;
    
    if ( !usedot || usedot && vectordot( anglestoforward( spawnobj.angles ), var_e7f83d51a3c75d98 ) > dotthreshold )
    {
        if ( length( var_e7f83d51a3c75d98 ) < distancethreshold )
        {
            if ( false )
            {
                thread drawline( testorigin, spawnobj.origin, 600, ( 0, 1, 0 ) );
            }
            
            if ( isdefined( level.spawnselectionlocations[ ref ] ) && isdefined( level.spawnselectionlocations[ ref ][ team ] ) )
            {
                loc = level.spawnselectionlocations[ ref ][ team ];
                
                if ( !array_contains( loc.spawnpoints, spawnobj ) )
                {
                    loc.spawnpoints[ loc.spawnpoints.size ] = spawnobj;
                }
                
                return;
            }
            
            struct = spawnstruct();
            struct.origin = testorigin;
            struct.angles = ( 0, 0, 0 );
            struct.spawnpoints = [];
            struct.spawnpoints[ 0 ] = spawnobj;
            
            if ( !issubstr( ref, "safe" ) )
            {
                scripts\mp\spawnselection::initspawnarea( team, struct, ref );
                return;
            }
            
            level.spawnselectionlocations[ ref ][ team ] = struct;
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xcfdb
// Size: 0x1b4, Type: bool
function function_dc3a172bf923d9b3()
{
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    hasobjective = 0;
    
    foreach ( location in level.spawnareas[ self.team ] )
    {
        if ( !isdefined( level.spawnselectionlocations[ location ] ) || !isdefined( level.spawnselectionlocations[ location ][ self.team ] ) )
        {
            continue;
        }
        
        if ( issubstr( location, "_hq_" ) )
        {
            continue;
        }
        
        objectivekey = level.spawnselectionlocations[ location ][ self.team ].objectivekey;
        
        if ( !scripts\mp\spawnselection::isobjectiveindanger( objectivekey, self.team ) )
        {
            hasobjective = 1;
            break;
        }
    }
    
    squadspawnlocations = scripts\mp\spawnselection::getsquadspawnlocations( self.team, self.sessionsquadid );
    var_6b1775723ef7c56 = 0;
    
    if ( istrue( level.var_efb4ec5a8f5352bf ) )
    {
        foreach ( squadspawn in squadspawnlocations )
        {
            if ( self != squadspawn.dynamicent && scripts\mp\spawnselection::issquadspawnable( squadspawn.dynamicent ) )
            {
                var_6b1775723ef7c56 = 1;
                break;
            }
        }
    }
    
    return level.var_1ffd19a2a9a5aa20 || hasobjective || var_6b1775723ef7c56;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xd198
// Size: 0x166
function function_b7262fc0da03a04f()
{
    if ( !isdefined( self.selectedspawnarea ) || !isdefined( level.spawnselectionlocations[ self.selectedspawnarea ] ) || !isdefined( level.spawnselectionlocations[ self.selectedspawnarea ][ self.team ] ) )
    {
        return;
    }
    
    if ( issubstr( self.selectedspawnarea, "_hq_" ) )
    {
        facingorigin = ( level.mapcorners[ 0 ].origin + level.mapcorners[ 1 ].origin ) * 0.5;
    }
    else
    {
        facingorigin = level.spawnselectionlocations[ self.selectedspawnarea ][ self.team ].origin;
    }
    
    toselection = facingorigin - self.spawndata.spawnorigin;
    spawnangles = vectortoangles( vectornormalize( toselection ) );
    self.spawndata.spawnangles = ( 0, spawnangles[ 1 ], 0 );
    
    if ( false )
    {
        thread drawline( facingorigin, self.spawndata.spawnorigin, 60, ( 1, 0, 0 ) );
    }
    
    self setplayerangles( self.spawndata.spawnangles );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xd306
// Size: 0x25
function function_aa0d1f90dcc5d366()
{
    level.br_armory_kiosk = spawnstruct();
    level.br_armory_kiosk.scriptables = [];
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xd333
// Size: 0x278
function function_fb11675119ade7d4()
{
    if ( getdvarint( @"scr_game_allow_loot" ) == 1 )
    {
        return;
    }
    
    level.brloottablename = getdvar( @"loot_table_name", "mp/loot/br/default/loot_item_defs.csv" );
    
    if ( !isdefined( level.br_pickups ) )
    {
        level.br_pickups = spawnstruct();
    }
    
    level.br_pickups.createcallbacks = [];
    level.br_pickups.droppedgasmasks = [];
    level.br_pickups.br_equipname = [];
    level.br_pickups.stackable = [];
    level.br_pickups.maxcounts = [];
    level.br_pickups.counts = [];
    level.br_pickups.br_itemtype = [];
    level.br_pickups.br_itemrow = [];
    level.br_pickups.br_itemrarity = [];
    level.br_pickups.br_value = [];
    level.br_pickups.br_equipnametoscriptable = [];
    level.br_pickups.br_weapontoscriptable = [];
    level.br_pickups.var_7b2bff2d04ee1017 = [];
    level.br_pickups.var_b13dc7e63676bbe7 = [];
    level.br_pickups.br_pickupsfx = [];
    level.br_pickups.var_14bd11727c4b6629 = [];
    level.br_pickups.var_838863c4848d4c26 = [];
    level.br_pickups.br_hasautopickup = [];
    level.br_pickups.uniquelootcallbacks = [];
    level.br_pickups.br_allguns = [];
    level.br_pickups.br_lootguns = [];
    level.br_pickups.br_crateguns = [];
    level.br_pickups.br_crateitems = [];
    level.br_pickups.br_gulagpickups = [];
    level.br_lootiteminfo = [];
    level.br_weaponsprimary = [];
    level.br_weaponssecondary = [];
    level.br_throwables = [];
    level.br_usables = [];
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xd5b3
// Size: 0x1e5
function function_5456c21de8f2bbbc()
{
    if ( getdvarint( @"scr_game_allow_loot" ) == 1 )
    {
        return;
    }
    
    level._effect[ "vfx_extract_smoke" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_adv_supply_drop_marker" );
    level._effect[ "vfx_br_cashLeaderBag" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_money_vip_burst.vfx" );
    var_dc62762d4387d2b8 = getmatchrulesdata( "brData", "plunderLobby" );
    level.br_plunder_lobby = var_dc62762d4387d2b8 && istrue( level.allowprematchdamage );
    level.br_plunder = spawnstruct();
    level.br_plunder.plunderlimit = 16384 - 1;
    level.br_plunder.plunder_items_picked_up = 0;
    level.br_plunder.plunder_value_picked_up = 0;
    level.br_plunder.plunder_items_dropped = 0;
    level.br_plunder.plunder_value_dropped = 0;
    level.br_plunder.kiosk_spent_total = 0;
    level.br_plunder.kiosk_num_purchases = 0;
    level.br_plunder.extraction_balloon_total_plunder = 0;
    level.br_plunder.extraction_balloon_num_completed = 0;
    level.br_plunder.extraction_helicoptor_total_plunder = 0;
    level.br_plunder.extraction_helicoptor_num_completed = 0;
    level.br_plunder.plunder_awarded_by_missions_total = 0;
    level.br_plunder.itemsinworld = [];
    level.br_plunder.itemsinworld[ "brloot_plunder_cash_common_1" ] = getscriptablelootspawnedcountbyname( "brloot_plunder_cash_common_1" );
    scripts\mp\gametypes\br_plunder::setupquantities();
    level.br_depots = [];
    scripts\mp\gametypes\br_plunder::initplayerplunderevents();
    scripts\mp\gametypes\br_plunder::initteamdatafields();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xd7a0
// Size: 0x9b
function function_d23c7c1add9fb181()
{
    closestobj = undefined;
    closestdist = undefined;
    
    foreach ( objective in level.objectives )
    {
        dist = distancesquared( self.origin, objective.curorigin );
        
        if ( !isdefined( closestobj ) || dist < closestdist )
        {
            closestobj = objective;
            closestdist = dist;
        }
    }
    
    return closestobj;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xd844
// Size: 0x2aa
function function_1629419647b0f862()
{
    scripts\mp\gametypes\br_armory_kiosk::init();
    level.var_6beff7b631ab7e18 = &function_6beff7b631ab7e18;
    upgraderefs = [];
    upgraderefs[ upgraderefs.size ] = "longer_capture_time";
    upgraderefs[ upgraderefs.size ] = "ammo_depot";
    upgraderefs[ upgraderefs.size ] = "uav_ping";
    upgraderefs[ upgraderefs.size ] = "ai_squad";
    upgraderefs[ upgraderefs.size ] = "ai_jugg";
    upgraderefs[ upgraderefs.size ] = "deploy_minefield";
    level.var_57734b23ed1998d6 = 1;
    level.var_73e72117ada9cce6 = getdvarfloat( @"hash_e8c1e6c77e11300d", level.flagcapturetime * 2 );
    level.buystations = [];
    level.var_1b37b352ec399488 = [];
    level.var_b8d2b366ac757da6 = [];
    tracecontents = scripts\engine\trace::create_default_contents( 1 );
    
    foreach ( key, objective in level.objectives )
    {
        groundorigin = drop_to_ground( objective.curorigin + anglestoforward( objective.trigger.angles ) * 50, 50, -200, undefined, tracecontents );
        buystation = spawnscriptable( "br_plunder_box", groundorigin, objective.trigger.angles );
        buystation.objectivekey = key;
        level.buystations[ key ] = buystation;
        buystation setscriptablepartstate( "br_plunder_box", "visible" );
        buystation.var_5cfa621ebf61d8aa = 0;
        var_9316a571d5756b1b = spawnstruct();
        var_9316a571d5756b1b.origin = drop_to_ground( objective.curorigin + anglestoforward( objective.trigger.angles ) * -50, 50, -200, undefined, tracecontents );
        var_9316a571d5756b1b.angles = objective.trigger.angles;
        ammorestock = scripts\mp\ammorestock::spawnlocation( var_9316a571d5756b1b );
        ammorestock hide();
        level.var_b8d2b366ac757da6[ key ] = ammorestock;
        
        foreach ( ref in upgraderefs )
        {
            level.var_1b37b352ec399488[ key ][ ref ] = 0;
        }
    }
    
    level thread function_c800466f69dfc582();
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xdaf6
// Size: 0x5a
function function_6beff7b631ab7e18( instance, player )
{
    if ( istrue( instance.var_5cfa621ebf61d8aa ) || istrue( level.var_8e9daba162280a8e ) )
    {
        player setclientomnvar( "ui_buystation_override", scripts\cp_mp\utility\loot::function_54b046aa3ba2678a( "personalOnly" ) );
    }
    
    player function_e29957adfbe3c040( instance.objectivekey );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0xdb58
// Size: 0xac
function function_e29957adfbe3c040( objectivekey )
{
    omnvarvalue = 0;
    
    if ( istrue( level.var_1b37b352ec399488[ objectivekey ][ "longer_capture_time" ] ) )
    {
        omnvarvalue += 1;
    }
    
    if ( istrue( level.var_1b37b352ec399488[ objectivekey ][ "ammo_depot" ] ) )
    {
        omnvarvalue += 2;
    }
    
    if ( istrue( level.var_1b37b352ec399488[ objectivekey ][ "uav_ping" ] ) )
    {
        omnvarvalue += 4;
    }
    
    if ( istrue( level.var_1b37b352ec399488[ objectivekey ][ "ai_squad" ] ) )
    {
        omnvarvalue += 8;
    }
    
    if ( istrue( level.var_1b37b352ec399488[ objectivekey ][ "ai_jugg" ] ) )
    {
        omnvarvalue += 16;
    }
    
    self setclientomnvar( "ui_upgrade_status", omnvarvalue );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xdc0c
// Size: 0xbc
function function_c800466f69dfc582()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    if ( istrue( level.var_7f5be0207e7457b1 ) )
    {
        return;
    }
    
    foreach ( key, buystation in level.buystations )
    {
        foreach ( team in level.teamnamelist )
        {
            buystation function_8d03978a31faba3a( key, team );
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xdcd0
// Size: 0x132
function function_6ed651811c936a22()
{
    if ( !istrue( level.var_57734b23ed1998d6 ) )
    {
        return;
    }
    
    if ( istrue( level.var_7f5be0207e7457b1 ) )
    {
        return;
    }
    
    foreach ( key, buystation in level.buystations )
    {
        ownerteam = level.objectives[ key ] scripts\mp\gameobjects::getownerteam();
        
        if ( self.team == ownerteam )
        {
            buystation enablescriptableplayeruse( self );
            continue;
        }
        
        buystation disablescriptableplayeruse( self );
    }
    
    foreach ( key, ammorestock in level.var_b8d2b366ac757da6 )
    {
        ownerteam = level.objectives[ key ] scripts\mp\gameobjects::getownerteam();
        
        if ( self.team == ownerteam && istrue( level.var_1b37b352ec399488[ key ][ "ammo_depot" ] ) )
        {
            ammorestock enablescriptableplayeruse( self );
            continue;
        }
        
        ammorestock disablescriptableplayeruse( self );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xde0a
// Size: 0xc4
function function_e8a6e840ef663c81( key, team )
{
    if ( !istrue( level.var_57734b23ed1998d6 ) )
    {
        return;
    }
    
    if ( istrue( level.var_7f5be0207e7457b1 ) )
    {
        return;
    }
    
    if ( !isdefined( team ) || !isgameplayteam( team ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player.team == team )
        {
            level.buystations[ key ] enablescriptableplayeruse( player );
            continue;
        }
        
        level.buystations[ key ] disablescriptableplayeruse( player );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xded6
// Size: 0x9f
function function_8d03978a31faba3a( key, team )
{
    if ( !istrue( level.var_57734b23ed1998d6 ) )
    {
        return;
    }
    
    if ( !isdefined( team ) || !isgameplayteam( team ) )
    {
        return;
    }
    
    players = getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        level.buystations[ key ] disablescriptableplayeruse( player );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xdf7d
// Size: 0x68
function function_4de8052758f986f3( player, ref )
{
    if ( !istrue( level.var_57734b23ed1998d6 ) )
    {
        return 0;
    }
    
    objective = player function_d23c7c1add9fb181();
    
    if ( objective.ownerteam != player.team )
    {
        return 0;
    }
    
    return level.var_1b37b352ec399488[ objective.objectivekey ][ ref ];
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xdfee
// Size: 0x66, Type: bool
function function_3ce1055115edcbbb( player, ref )
{
    if ( !istrue( level.var_57734b23ed1998d6 ) )
    {
        return false;
    }
    
    objective = player function_d23c7c1add9fb181();
    
    if ( objective.ownerteam != player.team )
    {
        return false;
    }
    
    applyupgrade( objective.objectivekey, ref );
    return true;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xe05d
// Size: 0x185
function applyupgrade( objectivekey, ref )
{
    if ( !istrue( level.var_57734b23ed1998d6 ) )
    {
        return;
    }
    
    level.var_1b37b352ec399488[ objectivekey ][ ref ] = 1;
    ownerteam = level.objectives[ objectivekey ] scripts\mp\gameobjects::getownerteam();
    
    switch ( ref )
    {
        case #"hash_e4154ddbab061c63":
            level.objectives[ objectivekey ] scripts\mp\gameobjects::setusetime( level.var_73e72117ada9cce6 );
            objective_setstate( level.objectives[ objectivekey ].objidnum, 1 );
            break;
        case #"hash_bb639a6ed9e9b88a":
            function_d05de3a316eda41f( objectivekey, ownerteam );
            break;
        case #"hash_6235851dae0eeca8":
            level.objectives[ objectivekey ] thread function_c929fb023d29de5e( ownerteam );
            break;
        case #"hash_fd8da3bdddb8e1c2":
            scripts\mp\gametypes\risk::function_e0ae27a2065777ac( objectivekey, 5, ownerteam );
            break;
        case #"hash_dda8890cb35ca0bf":
            groupname = function_78759441c259f58a();
            agent = ai_mp_requestspawnagent( "enemy_mp_jugg_base", level.objectives[ objectivekey ].trigger.origin, ( 0, 0, 0 ), "absolute", "everybody", "jugg", groupname, ownerteam );
            scripts\cp_mp\agents\agent_utils::function_1828f1e20e52b418( agent );
            agent thread function_b11c1964f528574b( agent );
            break;
        case #"hash_6c0c806bbf705a0c":
            break;
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xe1ea
// Size: 0x12c
function removeupgrade( objectivekey, ref )
{
    if ( !istrue( level.var_57734b23ed1998d6 ) )
    {
        return;
    }
    
    level.var_1b37b352ec399488[ objectivekey ][ ref ] = 0;
    
    switch ( ref )
    {
        case #"hash_e4154ddbab061c63":
            level.objectives[ objectivekey ] scripts\mp\gameobjects::setusetime( level.flagcapturetime );
            objective_setstate( level.objectives[ objectivekey ].objidnum, 0 );
            break;
        case #"hash_bb639a6ed9e9b88a":
            foreach ( team in level.teamnamelist )
            {
                function_a1c82cb0172d09a6( objectivekey, team );
            }
            
            break;
        case #"hash_6235851dae0eeca8":
            level.objectives[ objectivekey ] thread disableuavping();
            break;
        case #"hash_6c0c806bbf705a0c":
        case #"hash_dda8890cb35ca0bf":
        case #"hash_fd8da3bdddb8e1c2":
            break;
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0xe31e
// Size: 0x70
function function_666a2979def5d705( objectivekey )
{
    if ( !istrue( level.var_57734b23ed1998d6 ) )
    {
        return;
    }
    
    foreach ( ref, value in level.var_1b37b352ec399488[ objectivekey ] )
    {
        removeupgrade( objectivekey, ref );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xe396
// Size: 0xb0
function function_d05de3a316eda41f( key, team )
{
    if ( !istrue( level.var_57734b23ed1998d6 ) )
    {
        return;
    }
    
    if ( !isdefined( team ) || !isgameplayteam( team ) )
    {
        return;
    }
    
    level.var_b8d2b366ac757da6[ key ] show();
    players = getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        level.var_b8d2b366ac757da6[ key ] enablescriptableplayeruse( player );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xe44e
// Size: 0xb0
function function_a1c82cb0172d09a6( key, team )
{
    if ( !istrue( level.var_57734b23ed1998d6 ) )
    {
        return;
    }
    
    if ( !isdefined( team ) || !isgameplayteam( team ) )
    {
        return;
    }
    
    level.var_b8d2b366ac757da6[ key ] hide();
    players = getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        level.var_b8d2b366ac757da6[ key ] disablescriptableplayeruse( player );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0xe506
// Size: 0x91
function function_c929fb023d29de5e( team )
{
    if ( !istrue( level.var_57734b23ed1998d6 ) )
    {
        return;
    }
    
    if ( !isdefined( team ) || !isgameplayteam( team ) )
    {
        return;
    }
    
    radius = getdvarint( @"hash_bbf08a38c88577", 3000 );
    duration = getdvarfloat( @"hash_e34e9ea29b7cc0a9", 3 );
    self endon( "disableUAVPing" );
    
    while ( true )
    {
        triggerportableradarpingteam( self.curorigin, team, radius, int( duration * 1000 ) );
        wait duration;
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xe59f
// Size: 0x18
function disableuavping()
{
    if ( !istrue( level.var_57734b23ed1998d6 ) )
    {
        return;
    }
    
    self notify( "disableUAVPing" );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xe5bf
// Size: 0x146
function skydiveredeploy()
{
    level thread namespace_1eb3c4e0e28fac71::utilflare_shootflare( self.origin, "revive" );
    spawnheight = getdvarfloat( @"hash_50f18343f33b6153", 8000 );
    spawnorigin = self.origin;
    spawnorigin += ( 0, 0, spawnheight );
    var_ad4dd16f29e24b77 = 0;
    var_dfab0807d83a77fe = 0.5;
    thread scripts\mp\playerlogic::managerespawnfade( var_ad4dd16f29e24b77, var_dfab0807d83a77fe );
    
    if ( var_ad4dd16f29e24b77 > 0 )
    {
        self waittill( "fadeDown_complete" );
    }
    
    facingorigin = ( level.mapcorners[ 0 ].origin + level.mapcorners[ 1 ].origin ) * 0.5;
    toselection = facingorigin - spawnorigin;
    spawnangles = vectortoangles( vectornormalize( toselection ) );
    self setorigin( spawnorigin );
    self setplayerangles( spawnangles );
    
    if ( level.parachutecancutautodeploy )
    {
        self skydive_cutautodeployon();
    }
    else
    {
        self skydive_cutautodeployoff();
    }
    
    if ( level.parachutecancutparachute )
    {
        self skydive_cutparachuteon();
    }
    else
    {
        self skydive_cutparachuteoff();
    }
    
    thread scripts\cp_mp\parachute::startfreefall( level.parachutedeploydelay, 0, undefined, undefined, 1 );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0xe70d
// Size: 0x79
function function_1347e3ab3c68b20e( var_5932bbef2fa89f92 )
{
    var_e6a7bb0501f0ebd4 = function_1416c66b41edf9ee( var_5932bbef2fa89f92 );
    
    foreach ( player in getteamdata( var_e6a7bb0501f0ebd4, "players" ) )
    {
        player thread function_190616cdbc044966( player, var_5932bbef2fa89f92, 1 );
    }
    
    return var_e6a7bb0501f0ebd4;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 1
// Checksum 0x0, Offset: 0xe78f
// Size: 0xe3
function function_1416c66b41edf9ee( var_5932bbef2fa89f92 )
{
    var_156ee87bdeae6828 = 0;
    var_4bdde661af8e9ed5 = [];
    var_b7e76e8a63129a64 = undefined;
    
    foreach ( team in level.teamnamelist )
    {
        if ( team == var_5932bbef2fa89f92 )
        {
            continue;
        }
        
        var_bc2470c042a8b5f3 = scripts\mp\gametypes\obj_dom::getteamflagcount( team );
        
        if ( var_4bdde661af8e9ed5.size == 0 )
        {
            var_156ee87bdeae6828 = var_bc2470c042a8b5f3;
            var_4bdde661af8e9ed5[ var_4bdde661af8e9ed5.size ] = team;
            continue;
        }
        
        if ( var_bc2470c042a8b5f3 < var_156ee87bdeae6828 )
        {
            var_156ee87bdeae6828 = var_bc2470c042a8b5f3;
            var_4bdde661af8e9ed5 = [];
            var_4bdde661af8e9ed5[ var_4bdde661af8e9ed5.size ] = team;
            continue;
        }
        
        if ( var_bc2470c042a8b5f3 == var_156ee87bdeae6828 )
        {
            var_4bdde661af8e9ed5[ var_4bdde661af8e9ed5.size ] = team;
        }
    }
    
    if ( var_4bdde661af8e9ed5.size > 1 )
    {
        var_b7e76e8a63129a64 = random( var_4bdde661af8e9ed5 );
    }
    else
    {
        var_b7e76e8a63129a64 = var_4bdde661af8e9ed5[ 0 ];
    }
    
    return var_b7e76e8a63129a64;
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xe87b
// Size: 0x91
function function_f525754162a91372( flagsetownerteam, var_e6a7bb0501f0ebd4 )
{
    foreach ( objective in level.objectives )
    {
        if ( objective.ownerteam == var_e6a7bb0501f0ebd4 )
        {
            if ( flagsetownerteam == "neutral" )
            {
                objective.var_b2555c1e8ca32569 = 1;
            }
            
            objective objective_onuse( undefined, flagsetownerteam );
        }
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xe914
// Size: 0x130
function function_2a8adcc9b74f4838()
{
    triggerending = 0;
    endingteam = undefined;
    
    while ( true )
    {
        foreach ( team in level.teamnamelist )
        {
            held = calculateobjectivesheld( team );
            
            if ( held >= level.objectives.size )
            {
                endingteam = team;
                triggerending = 1;
                break;
            }
        }
        
        if ( triggerending )
        {
            break;
        }
        
        waitframe();
    }
    
    setomnvar( "ui_nuke_timer_type", 2 );
    setomnvar( "ui_nuke_timer_time", 10 );
    setomnvar( "ui_nuke_countdown_active", 1 );
    setomnvar( "ui_arm_dominatingTeam", scripts\engine\utility::array_find( level.allteamnamelist, endingteam ) );
    starttime = gettime();
    endtime = 10000 + starttime;
    setomnvar( "ui_nuke_end_milliseconds", 10000 + starttime );
    
    while ( true )
    {
        waitframe();
        
        if ( gettime() > endtime )
        {
            break;
        }
    }
    
    level nuke_triggermercywin( endingteam );
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 0
// Checksum 0x0, Offset: 0xea4c
// Size: 0x12d
function function_d37d95ac1717903c()
{
    if ( isdefined( level.var_9584cec5d16d159f ) )
    {
        var_1d647d624f816cd9 = [];
        teamtofill = undefined;
        
        foreach ( entry in level.teamnamelist )
        {
            if ( entry != level.var_9584cec5d16d159f && entry != level.var_9584dcc5d16d3469 )
            {
                var_1d647d624f816cd9[ var_1d647d624f816cd9.size ] = entry;
            }
        }
        
        numplayers = 0;
        lowestnumplayers = undefined;
        
        foreach ( entry in var_1d647d624f816cd9 )
        {
            numplayers = getteamdata( entry, "teamCount" );
            
            if ( !isdefined( lowestnumplayers ) )
            {
                lowestnumplayers = numplayers;
                teamtofill = entry;
                continue;
            }
            
            if ( numplayers < lowestnumplayers )
            {
                teamtofill = entry;
                continue;
            }
            
            if ( numplayers == lowestnumplayers )
            {
                teamtofill = random( var_1d647d624f816cd9 );
            }
        }
        
        scripts\mp\menus::setteam( var_1d647d624f816cd9 );
    }
}

// Namespace risk / scripts\mp\gametypes\risk
// Params 2
// Checksum 0x0, Offset: 0xeb81
// Size: 0x98
function function_f6857ca2e18431e9( var_3168c8300ef54732, var_e6a7bb0501f0ebd4 )
{
    foreach ( team in level.teamnamelist )
    {
        if ( team == var_3168c8300ef54732 )
        {
            showsplashtoteam( team, "risk_team_absorb_us" );
            continue;
        }
        
        if ( team == var_e6a7bb0501f0ebd4 )
        {
            showsplashtoteam( team, "risk_team_absorb_them" );
            continue;
        }
        
        showsplashtoteam( team, "risk_team_absorb_other" );
    }
}

