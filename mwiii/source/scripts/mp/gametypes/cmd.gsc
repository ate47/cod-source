#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\destructible;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\lightarmor;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace cmd;

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x2164
// Size: 0x767
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    allowed[ 0 ] = "cop";
    scripts\mp\gameobjects::main( allowed );
    
    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = &initializematchrules;
        [[ level.initializematchrules ]]();
        level thread reinitializematchrulesonmigration();
    }
    else
    {
        registertimelimitdvar( getgametype(), 1200 );
        
        if ( true )
        {
            registerscorelimitdvar( getgametype(), 5 );
        }
        else
        {
            registerscorelimitdvar( getgametype(), 0 );
        }
        
        registerroundlimitdvar( getgametype(), 2 );
        registerroundswitchdvar( getgametype(), 0, 0, 1 );
        registerwinlimitdvar( getgametype(), 0 );
        registernumlivesdvar( getgametype(), 0 );
        registerhalftimedvar( getgametype(), 0 );
        setovertimelimitdvar( 300 );
    }
    
    updategametypedvars();
    level.objectivebased = 1;
    level.teambased = 1;
    level.disablebuddyspawn = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.ontimelimit = &ontimelimit;
    level.getspawnpoint = &getspawnpoint;
    level.onplayerkilled = &onplayerkilled;
    level.lastcaptime = gettime();
    level.resetuiomnvargamemode = &scripts\mp\gametypes\obj_bombzone::resetuiomnvargamemode;
    level.cmdattackingteam = "neutral";
    level.cmddefendingteam = "neutral";
    level.timerstoppedforgamemode = 0;
    level.extratime = 0;
    game[ "dialog" ][ "gametype" ] = "intro_start";
    game[ "dialog" ][ "bomb_achieve" ] = "bomb_achieve";
    game[ "dialog" ][ "bomb_taken" ] = "bomb_taken";
    game[ "dialog" ][ "bomb_lost" ] = "bomb_enemyowns";
    game[ "dialog" ][ "bomb_defusing" ] = "bomb_enemydefusing";
    game[ "dialog" ][ "bomb_defused" ] = "bomb_defused";
    game[ "dialog" ][ "bomb_planted" ] = "bomb_planted";
    game[ "dialog" ][ "enemy_bomb_a" ] = "bomb_enemy_a";
    game[ "dialog" ][ "enemy_bomb_b" ] = "bomb_enemy_b";
    game[ "dialog" ][ "enemy_bomb_defused" ] = "bomb_enemydefused";
    game[ "dialog" ][ "enemy_bomb_planted" ] = "bomb_enemyplanted";
    game[ "dialog" ][ "offense_obj" ] = "cop_obj_clock";
    game[ "dialog" ][ "defense_obj" ] = "cop_obj_clock";
    game[ "dialog" ][ "cop_obj_0_mp_faridah" ] = "obj_embassy";
    game[ "dialog" ][ "cop_obj_0_attack_mp_faridah" ] = "embassy_attack";
    game[ "dialog" ][ "cop_obj_0_mp_euphrates" ] = "obj_compound";
    game[ "dialog" ][ "cop_obj_0_attack_mp_euphrates" ] = "compound_attack";
    game[ "dialog" ][ "cop_obj_1_mp_faridah" ] = "obj_school";
    game[ "dialog" ][ "cop_obj_1_attack_mp_faridah" ] = "school_attack";
    game[ "dialog" ][ "cop_obj_1_defend_mp_faridah" ] = "school_defend";
    game[ "dialog" ][ "cop_obj_1_enemy_cap_mp_faridah" ] = "school_enemycapture";
    game[ "dialog" ][ "cop_obj_1_enemy_hold_mp_faridah" ] = "school_enemycaptured";
    game[ "dialog" ][ "cop_obj_1_mp_euphrates" ] = "obj_buses";
    game[ "dialog" ][ "cop_obj_1_attack_mp_euphrates" ] = "buses_attack";
    game[ "dialog" ][ "cop_obj_1_defend_mp_euphrates" ] = "buses_defend";
    game[ "dialog" ][ "cop_obj_1_enemy_cap_mp_euphrates" ] = "buses_enemycapture";
    game[ "dialog" ][ "cop_obj_1_enemy_hold_mp_euphrates" ] = "buses_enemycaptured";
    game[ "dialog" ][ "cop_obj_2_mp_faridah" ] = "obj_clock";
    game[ "dialog" ][ "cop_obj_2_attack_mp_faridah" ] = "clock_attack";
    game[ "dialog" ][ "cop_obj_2_defend_mp_faridah" ] = "clock_defend";
    game[ "dialog" ][ "cop_obj_2_mp_euphrates" ] = "obj_underpass";
    game[ "dialog" ][ "cop_obj_2_attack_mp_euphrates" ] = "underpass_attack";
    game[ "dialog" ][ "cop_obj_2_defend_mp_euphrates" ] = "underpass_defend";
    game[ "dialog" ][ "cop_obj_2_enemy_cap_mp_euphrates" ] = "underpass_enemycapture";
    game[ "dialog" ][ "cop_obj_2_enemy_hold_mp_euphrates" ] = "underpass_enemycaptured";
    game[ "dialog" ][ "cop_obj_3_mp_faridah" ] = "obj_warehouse";
    game[ "dialog" ][ "cop_obj_3_attack_mp_faridah" ] = "warehouse_attack";
    game[ "dialog" ][ "cop_obj_3_defend_mp_faridah" ] = "warehouse_defend";
    game[ "dialog" ][ "cop_obj_3_enemy_cap_mp_faridah" ] = "warehouse_enemycapture";
    game[ "dialog" ][ "cop_obj_3_enemy_hold_mp_faridah" ] = "warehouse_enemycaptured";
    game[ "dialog" ][ "cop_obj_3_mp_euphrates" ] = "obj_construction";
    game[ "dialog" ][ "cop_obj_3_attack_mp_euphrates" ] = "construction_attack";
    game[ "dialog" ][ "cop_obj_3_defend_mp_euphrates" ] = "construction_defend";
    game[ "dialog" ][ "cop_obj_3_enemy_cap_mp_euphrates" ] = "construction_enemycapture";
    game[ "dialog" ][ "cop_obj_3_enemy_hold_mp_euphrates" ] = "construction_enemycaptured";
    game[ "dialog" ][ "cop_obj_4_mp_faridah" ] = "obj_compound";
    game[ "dialog" ][ "cop_obj_4_defend_mp_faridah" ] = "compound_defend";
    game[ "dialog" ][ "cop_obj_4_mp_euphrates" ] = "obj_fob";
    game[ "dialog" ][ "cop_obj_4_attack_mp_euphrates" ] = "fob_attack";
    game[ "dialog" ][ "cop_obj_4_defend_mp_euphrates" ] = "fob_defend";
    game[ "dialog" ][ "cop_target_active" ] = "gamestate_targetactive";
    game[ "dialog" ][ "cop_obj_contested" ] = "obj_contested";
    game[ "dialog" ][ "cop_enemy_sec" ] = "enemy_capturingneutral";
    game[ "dialog" ][ "cop_hold" ] = "confirm_copsecurewait";
    game[ "dialog" ][ "cop_outpostcaptured" ] = "confirm_copsecureyes";
    game[ "dialog" ][ "cop_bombplanted_atenemy" ] = "bombplanted_atenemycop";
    game[ "dialog" ][ "cop_bombplanted_atfriendly" ] = "bombplanted_atfriendlycop";
    game[ "dialog" ][ "cop_bombdefused" ] = "compound_bombdefused";
    game[ "dialog" ][ "sitrep_0_mp_faridah" ] = "sitrep_embspawn";
    game[ "dialog" ][ "sitrep_1_mp_faridah" ] = "sitrep_schoolspawn";
    game[ "dialog" ][ "sitrep_2_mp_faridah" ] = "sitrep_clockspawn";
    game[ "dialog" ][ "sitrep_3_mp_faridah" ] = "sitrep_whspawn";
    game[ "dialog" ][ "sitrep_4_mp_faridah" ] = "sitrep_comspawn";
    game[ "dialog" ][ "sitrep_0_mp_euphrates" ] = "sitrep_comspawn";
    game[ "dialog" ][ "sitrep_1_mp_euphrates" ] = "sitrep_busesspawn";
    game[ "dialog" ][ "sitrep_2_mp_euphrates" ] = "sitrep_undspawn";
    game[ "dialog" ][ "sitrep_3_mp_euphrates" ] = "sitrep_constspawn";
    game[ "dialog" ][ "sitrep_4_mp_euphrates" ] = "sitrep_fobspawn";
    game[ "dialog" ][ "cop_order_attack" ] = "order_attack";
    game[ "dialog" ][ "cop_order_fallback" ] = "order_fallback";
    game[ "dialog" ][ "cop_killstreak_bradley" ] = "killstreak_bradley";
    game[ "dialog" ][ "cop_enemy_bradley" ] = "enemy_bradley";
    game[ "dialog" ][ "cop_hostage_located" ] = "hostage_located";
    game[ "dialog" ][ "cop_hostage_extraction" ] = "hostage_extraction";
    game[ "dialog" ][ "cop_breach_plant" ] = "breach_plant";
    thread ongameended();
    level._effect[ "vfx_smk_signal" ] = loadfx( "vfx/_requests/mp_gameplay/vfx_smk_signal" );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x28d3
// Size: 0x1ca
function initializematchrules()
{
    setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_735778ffcb77229d", getmatchrulesdata( "cmdData", "cmdRules" ) );
    setdynamicdvar( @"hash_fd24789f16e89ad4", getmatchrulesdata( "cmdData", "activationDelayCenter" ) );
    setdynamicdvar( @"hash_95b89e8d583fc3f4", getmatchrulesdata( "cmdData", "activationDelayHalf" ) );
    setdynamicdvar( @"hash_c6918fbaba545a8", getmatchrulesdata( "cmdData", "activationDelayBase" ) );
    setdynamicdvar( @"hash_c5cd0ccd8e5dcb79", getmatchrulesdata( "cmdData", "captureDurationCenter" ) );
    setdynamicdvar( @"hash_15912d8e8706d469", getmatchrulesdata( "cmdData", "captureDurationHalf" ) );
    setdynamicdvar( @"hash_70014a04d6bc8145", getmatchrulesdata( "cmdData", "captureDurationBase" ) );
    setdynamicdvar( @"hash_f25163981c3cc7a2", getmatchrulesdata( "cmdData", "holdDurationCenter" ) );
    setdynamicdvar( @"hash_1a413608e91a1bf2", getmatchrulesdata( "cmdData", "holdDurationHalf" ) );
    setdynamicdvar( @"hash_bf89fd9299156f12", getmatchrulesdata( "cmdData", "holdDurationBase" ) );
    setdynamicdvar( @"hash_acbd6c796aa85052", getmatchrulesdata( "cmdData", "juggSpawnBehavior" ) );
    setdynamicdvar( @"hash_5460d7525025cd97", getmatchrulesdata( "domData", "flagCaptureTime" ) );
    setdynamicdvar( @"hash_2b8bea8d06e005c1", getmatchrulesdata( "domData", "flagNeutralization" ) );
    setdynamicdvar( @"hash_9fd736b486efcb95", getmatchrulesdata( "ctfData", "captureCondition" ) );
    setdynamicdvar( @"hash_cde4a2a016eecbae", 0 );
    registerhalftimedvar( "dom", 0 );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x2aa5
// Size: 0x313
function updategametypedvars()
{
    scripts\mp\gametypes\common::updatecommongametypedvars();
    level.cmdrules = dvarintvalue( "cmdRules", 1, 1, 3 );
    level.tieractivationdelay = [];
    level.tieractivationdelay[ 0 ] = dvarfloatvalue( "activationDelayCenter", 15, 0, 60 );
    level.tieractivationdelay[ 1 ] = dvarfloatvalue( "activationDelayHalf", 15, 0, 60 );
    level.tieractivationdelay[ 2 ] = dvarfloatvalue( "activationDelayBase", 15, 0, 60 );
    level.tiercapturetime = [];
    level.tiercapturetime[ 0 ] = dvarfloatvalue( "captureDurationCenter", 10, 0, 60 );
    level.tiercapturetime[ 1 ] = dvarfloatvalue( "captureDurationHalf", 10, 0, 60 );
    level.tiercapturetime[ 2 ] = dvarfloatvalue( "captureDurationBase", 10, 0, 60 );
    level.tierholdtime = [];
    level.tierholdtime[ 0 ] = dvarfloatvalue( "holdDurationCenter", 30, 0, 60 );
    level.tierholdtime[ 1 ] = dvarfloatvalue( "holdDurationHalf", 30, 0, 60 );
    level.tierholdtime[ 2 ] = dvarfloatvalue( "holdDurationBase", 45, 0, 60 );
    level.juggspawnbehavior = dvarintvalue( "juggSpawnBehavior", 1, 0, 3 );
    level.flagcapturetime = dvarfloatvalue( "flagCaptureTime", 10, 0, 30 );
    level.flagneutralization = dvarintvalue( "flagNeutralization", 0, 0, 1 );
    level.hvtspawnpos = dvarintvalue( "captureCondition", 1, 0, 2 );
    level.overtime = dvarfloatvalue( "overtimeLimit", 300, 0, 300 );
    setovertimelimitdvar( level.overtime );
    level.persistentbombtimer = 0;
    level.persistentdomtimer = 1;
    
    if ( istrue( level.persistentbombtimer ) )
    {
        level.bombtimer = 60;
    }
    else
    {
        level.bombtimer = 30;
    }
    
    if ( level.cmdrules == 1 )
    {
        level.planttime = 2;
        level.defusetime = 2;
    }
    else
    {
        level.planttime = level.tiercapturetime[ 2 ];
        level.defusetime = level.tiercapturetime[ 2 ];
        level.bombtimer = 3;
    }
    
    level.controltoprogress = 1;
    setdvar( @"hash_60f76e342fa97cce", 200 );
    level.forcedobjectiveindex = getdvarint( @"hash_1bee917b434ddca6", -1 );
    
    if ( level.forcedobjectiveindex != -1 )
    {
        setdynamicdvar( hashcat( @"scr_", getgametype(), "_roundLimit" ), 2 );
        registerroundlimitdvar( getgametype(), 2 );
        setdynamicdvar( hashcat( @"scr_", getgametype(), "_roundswitch" ), 1 );
        registerroundswitchdvar( getgametype(), 1, 0, 1 );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x2dc0
// Size: 0xa3
function ontimelimit()
{
    if ( level.cmdrules == 2 )
    {
        if ( level.cmddefendingteam != "neutral" )
        {
            cmd_endgame( level.cmddefendingteam, game[ "end_reason" ][ "outpost_defended" ] );
        }
        else
        {
            level thread scripts\mp\gamelogic::endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
        }
        
        return;
    }
    
    if ( inovertime() )
    {
        level thread scripts\mp\gamelogic::endgame( "tie", game[ "end_reason" ][ "time_limit_reached" ] );
        return;
    }
    
    level thread scripts\mp\gamelogic::endgame( "overtime", game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x2e6b
// Size: 0x80
function seticonnames()
{
    level.iconcapture = "icon_waypoint_capture";
    level.iconcontested = "icon_waypoint_contested";
    level.icondefend = "icon_waypoint_defend";
    level.icondefusing = "icon_waypoint_defusing";
    level.iconlosing = "icon_waypoint_losing";
    level.iconneutral = "icon_waypoint_neutral";
    level.iconplanting = "icon_waypoint_planting";
    level.icontaking = "icon_waypoint_taking";
    level.icontarget = "icon_waypoint_target";
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x2ef3
// Size: 0x14d
function onstartgametype()
{
    setomnvar( "ui_victory_condition_completed", 0 );
    seticonnames();
    
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
        setobjectivetext( entry, &"OBJECTIVES/DOM" );
        
        if ( level.splitscreen )
        {
            setobjectivescoretext( entry, &"OBJECTIVES/DOM" );
        }
        else
        {
            setobjectivescoretext( entry, &"OBJECTIVES/DOM_SCORE" );
        }
        
        setobjectivehinttext( entry, &"OBJECTIVES/DOM_HINT" );
    }
    
    setclientnamemode( "auto_change" );
    initspecatatorcameras();
    thread loopspectatorlocations();
    setupobjectives();
    initspawns();
    setupdestructibledoors();
    
    if ( level.mapname == "mp_faridah" )
    {
        init_mp_faridah();
    }
    
    thread startgame();
    scripts\mp\gametypes\bradley_spawner::inittankspawns();
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x3048
// Size: 0x19
function init_mp_faridah()
{
    initschoolmgturret();
    thread initksbonuscrates();
    thread initpropaganda();
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x3069
// Size: 0x72
function initpropaganda()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    spawnorigin = ( 435, 0, 625 );
    spawnangles = ( 0, 0, 0 );
    level.propagandaent = spawn_tag_origin( spawnorigin, spawnangles );
    level.propagandaent show();
    level.propagandaent playloopsound( "tmp_emt_mp_faridah_propaganda_lp" );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x30e3
// Size: 0x176
function initschoolmgturret()
{
    spawnorigin = ( 260, -1415, 150 );
    spawnangles = ( 0, 90, 0 );
    org = spawn_tag_origin( spawnorigin, spawnangles );
    turret = spawnturret( "misc_turret", org.origin, "tur_gun_faridah_mp", 0 );
    turret.angles = org.angles;
    turret linkto( org, "tag_origin", ( 0, 0, 16 ), ( 0, 0, 0 ) );
    turret setmodel( "weapon_mg_bravo50_balcony" );
    turret makeunusable();
    turret setnodeploy( 1 );
    turret setdefaultdroppitch( 0 );
    objweapon = makeweapon( "tur_gun_faridah_mp" );
    turret.objweapon = objweapon;
    useobjorigin = turret gettagorigin( "tag_turret_pitch" );
    useobj = scripts\mp\gameobjects::createhintobject( useobjorigin, "HINT_BUTTON", "hud_icon_turret", &"KILLSTREAKS_HINTS/SENTRY_USE_GL" );
    useobj linkto( turret, "tag_turret_pitch", ( 0, 0, 5 ), ( 0, 0, 0 ) );
    useobj thread turretthink( turret );
    turret.killcament = spawn( "script_model", ( 255, -1425, 210 ) );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x3261
// Size: 0xe1
function turretthink( turret )
{
    while ( true )
    {
        self waittill( "trigger", player );
        self makeunusable();
        player.prevweapon = player getcurrentweapon();
        player.useweapon = "tur_gun_faridah_mp";
        player _giveweapon( player.useweapon, undefined, undefined, 1 );
        
        while ( player domonitoredweaponswitch( player.useweapon, 1 ) == 0 )
        {
            waitframe();
        }
        
        player controlturreton( turret );
        thread endturretusewatch( player, turret );
        thread endturretonplayer( player );
        self waittill( "end_turret_use" );
        
        if ( isdefined( player ) )
        {
            player controlturretoff( turret );
            player switchtoweaponimmediate( player.prevweapon );
            player _takeweapon( player.useweapon );
        }
        
        self makeusable();
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 2
// Checksum 0x0, Offset: 0x334a
// Size: 0x44
function endturretusewatch( player, turret )
{
    player endon( "death_or_disconnect" );
    
    while ( player usebuttonpressed() )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( player usebuttonpressed() )
        {
            self notify( "end_turret_use" );
            break;
        }
        
        waitframe();
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x3396
// Size: 0x1b
function endturretonplayer( player )
{
    player waittill( "death_or_disconnect" );
    self notify( "end_turret_use" );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x33b9
// Size: 0x54
function initksbonuscrates()
{
    wait 2;
    pos = ( 1125, -1675, 100 );
    givekscratetoteam( "allies", pos, "cruise_predator" );
    pos = ( -1150, -575, 100 );
    givekscratetoteam( "allies", pos, "chopper_gunner" );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x3415
// Size: 0x141
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
                    setteammapposition( var_ca2c833762e5466c, game[ "attackers" ], childstruct );
                    break;
                case #"hash_e66f1db565904926":
                    setteammapposition( var_ca2c833762e5466c, game[ "defenders" ], childstruct );
                    break;
            }
        }
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 3
// Checksum 0x0, Offset: 0x355e
// Size: 0x46
function setteammapposition( var_ca2c833762e5466c, team, posinfo )
{
    if ( !isdefined( level.spectatorcameras[ var_ca2c833762e5466c ] ) )
    {
        level.spectatorcameras[ var_ca2c833762e5466c ] = [];
    }
    
    level.spectatorcameras[ var_ca2c833762e5466c ][ team ] = posinfo;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x35ac
// Size: 0xd8
function loopspectatorlocations()
{
    index = 0;
    
    while ( true )
    {
        if ( getdvarint( @"hash_4ac8d16ce8dd74fd", 0 ) == 1 )
        {
            if ( isalive( level.players[ 0 ] ) )
            {
                level.players[ 0 ] suicide();
            }
            
            overrideindex = getdvarint( @"hash_885dea990259dafe", -1 );
            
            if ( overrideindex != -1 )
            {
                index = overrideindex;
            }
            
            updatespectatorcamera( "cop_" + index );
            duration = getdvarfloat( @"hash_7d3ea16c514f408d", 1 );
            wait duration;
            index++;
            
            if ( index > 4 )
            {
                index = 0;
            }
            
            if ( getdvarint( @"hash_4ac8d16ce8dd74fd", 0 ) == 0 )
            {
                level.players[ 0 ] notify( "force_spawn" );
            }
            
            continue;
        }
        
        waitframe();
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x368c
// Size: 0xad
function setupdestructibledoors()
{
    if ( !isdefined( level.destructibles ) || !isdefined( level.destructibles[ "destructible_door" ] ) )
    {
        return;
    }
    
    foreach ( door in level.destructibles[ "destructible_door" ] )
    {
        owner = getdoorowner( door.ents[ 0 ].origin );
        door scripts\mp\destructible::assigninteractteam( getenemyteams( owner ) );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x3741
// Size: 0xb9
function getdoorowner( position )
{
    closest = undefined;
    bestdist = undefined;
    
    foreach ( objective in level.objectives )
    {
        if ( !isdefined( objective.defaultownerteam ) )
        {
            continue;
        }
        
        dist = distance2dsquared( position, objective.curorigin );
        
        if ( !isdefined( closest ) || dist < bestdist )
        {
            closest = objective;
            bestdist = dist;
        }
    }
    
    return closest.defaultownerteam;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x3803
// Size: 0x347
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
        scripts\mp\spawnlogic::setactivespawnlogic( "Default", "Crit_Default" );
    }
    
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_cmd_spawn_allies_start" );
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_cmd_spawn_axis_start" );
    scripts\mp\spawnlogic::addspawnpoints( game[ "attackers" ], "mp_cmd_spawn_allies", 1 );
    scripts\mp\spawnlogic::addspawnpoints( game[ "defenders" ], "mp_cmd_spawn_axis", 1 );
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    
    foreach ( objective in level.objectives )
    {
        objective.spawnpoints = [];
        objective.spawnpoints[ game[ "attackers" ] ] = [];
        objective.spawnpoints[ game[ "defenders" ] ] = [];
    }
    
    foreach ( spawnpoint in level.spawnpoints )
    {
        if ( isdefined( spawnpoint.script_noteworthy ) )
        {
            index = spawnpoint.script_noteworthy;
            
            if ( spawnpoint.classname == "mp_cmd_spawn_allies" )
            {
                level.objectives[ index ].spawnpoints[ game[ "attackers" ] ][ level.objectives[ index ].spawnpoints[ game[ "attackers" ] ].size ] = spawnpoint;
                continue;
            }
            
            if ( spawnpoint.classname == "mp_cmd_spawn_axis" )
            {
                level.objectives[ index ].spawnpoints[ game[ "defenders" ] ][ level.objectives[ index ].spawnpoints[ game[ "defenders" ] ].size ] = spawnpoint;
            }
        }
    }
    
    foreach ( objindex, objective in level.objectives )
    {
        objective.spawnsets = [];
        objective.spawnsets[ game[ "attackers" ] ] = "objSpawn_allies_" + objindex;
        scripts\mp\spawnlogic::registerspawnset( objective.spawnsets[ game[ "attackers" ] ], objective.spawnpoints[ game[ "attackers" ] ] );
        objective.spawnsets[ game[ "defenders" ] ] = "objSpawn_axis_" + objindex;
        scripts\mp\spawnlogic::registerspawnset( objective.spawnsets[ game[ "defenders" ] ], objective.spawnpoints[ game[ "defenders" ] ] );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x3b52
// Size: 0x96
function getspawnpoint()
{
    spawnteam = self.pers[ "team" ];
    
    if ( scripts\mp\spawnlogic::shoulduseteamstartspawn() )
    {
        if ( game[ "switchedsides" ] )
        {
            spawnteam = getotherteam( spawnteam )[ 0 ];
        }
        
        spawnpoints = scripts\mp\spawnlogic::getspawnpointarray( "mp_cmd_spawn_" + spawnteam + "_start" );
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn( spawnpoints );
        self.startspawnpoint = spawnpoint;
    }
    else
    {
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint( self, spawnteam, level.currentobjective.spawnsets[ spawnteam ] );
    }
    
    return spawnpoint;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x3bf1
// Size: 0x51
function setupobjectives()
{
    level.currentobjective = undefined;
    level.objectives = [];
    setupbombzones();
    setupflags();
    setupareabrushes();
    setupteamoobtriggers();
    validateobjectives();
    thread ui_updatecmdprogress();
    thread disableobjectiveongameended();
    thread setupcaptureflares();
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x3c4a
// Size: 0x239
function setupbombzones()
{
    triggers = getentarray( "cop_bombzone", "targetname" );
    
    if ( triggers.size == 0 )
    {
        return;
    }
    
    level._effect[ "bomb_explosion" ] = loadfx( "vfx/iw9/dmz/bombsite/vfx_dmz_bombsite_expl.vfx" );
    level._effect[ "vehicle_explosion" ] = loadfx( "vfx/core/expl/small_vehicle_explosion_new.vfx" );
    level._effect[ "building_explosion" ] = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
    level._effect[ "faridah_bomb_explosion" ] = loadfx( "vfx/iw8_mp/killstreak/vfx_cruise_predator_explosion_large_2.vfx" );
    level.ddbombmodel = [];
    level.multibomb = 1;
    level.bombsplanted = 0;
    level.bombexploded = 0;
    level.bombplanted = 0;
    level.aplanted = 0;
    level.bplanted = 0;
    
    foreach ( trigger in triggers )
    {
        assert( isdefined( trigger.script_noteworthy ) );
        objectiveindex = trigger.script_noteworthy;
        
        if ( objectiveindex == "5" )
        {
            objectiveindex = "_b";
        }
        else
        {
            objectiveindex = "_a";
        }
        
        trigger.objectivekey = objectiveindex;
        trigger mapobjectiveicon();
        bombzone = scripts\mp\gametypes\obj_bombzone::setupobjective( trigger );
        bombzone bombzone_ondisableobjective();
        bombzone scripts\mp\gameobjects::releaseid();
        level.objectives[ bombzone.objectivekey ] = bombzone;
        bombzone.onbeginuse = &bombzone_onbeginuse;
        bombzone.onenduse = &bombzone_onenduse;
        bombzone.onuse = &bombzone_onuseplantobject;
        bombzone.ondisableobjective = &bombzone_ondisableobjective;
        bombzone.onenableobjective = &bombzone_onenableobjective;
        bombzone.onactivateobjective = &bombzone_onactivateobjective;
        
        if ( objectiveindex == "_a" )
        {
            bombzone scripts\mp\gameobjects::setownerteam( game[ "attackers" ] );
            continue;
        }
        
        bombzone scripts\mp\gameobjects::setownerteam( game[ "defenders" ] );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x3e8b
// Size: 0x263
function setupflags()
{
    primaryflags = getentarray( "cop_flag", "targetname" );
    flagoverrides = getentarray( "cop_flag_override", "targetname" );
    
    if ( primaryflags.size == 0 )
    {
        return;
    }
    
    triggers = [];
    
    for ( index = 0; index < primaryflags.size ; index++ )
    {
        triggers[ triggers.size ] = primaryflags[ index ];
    }
    
    triggeroverrides = [];
    
    if ( flagoverrides.size > 0 )
    {
        foreach ( trigger in flagoverrides )
        {
            assert( isdefined( trigger.script_noteworthy ) );
            objectiveindex = trigger.script_noteworthy;
            triggeroverrides[ objectiveindex ] = trigger;
        }
    }
    
    foreach ( trigger in triggers )
    {
        assert( isdefined( trigger.script_noteworthy ) );
        objectiveindex = trigger.script_noteworthy;
        
        if ( isdefined( triggeroverrides[ objectiveindex ] ) )
        {
            trigger = triggeroverrides[ objectiveindex ];
        }
        
        trigger.objectivekey = objectiveindex;
        trigger mapobjectiveicon( objectiveindex );
        domflag = scripts\mp\gametypes\obj_dom::setupobjective( trigger );
        domflag.flagmodel delete();
        domflag.flagmodel = undefined;
        domflag.outlineent = undefined;
        domflag dompoint_ondisableobjective();
        level.objectives[ domflag.objectivekey ] = domflag;
        domflag.onbeginuse = &dompoint_onbeginuse;
        domflag.onuse = &dompoint_onuse;
        domflag.onenduse = &dompoint_onenduse;
        domflag.oncontested = &dompoint_oncontested;
        domflag.onuncontested = &dompoint_onuncontested;
        domflag.ondisableobjective = &dompoint_ondisableobjective;
        domflag.onenableobjective = &dompoint_onenableobjective;
        domflag.onactivateobjective = &dompoint_onactivateobjective;
        domflag thread scripts\mp\gametypes\obj_dom::updateflagstate( "off", 0 );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x40f6
// Size: 0x10
function disabledomflagscriptable()
{
    thread scripts\mp\gametypes\obj_dom::updateflagstate( "off", 0 );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x410e
// Size: 0x5d5
function setupareabrushes()
{
    neutralbrushes = getentarray( "cop_zone_visual", "targetname" );
    var_c4e3db398aa8c45a = getentarray( "cop_zone_visual_contest", "targetname" );
    friendlybrushes = getentarray( "cop_zone_visual_friend", "targetname" );
    enemybrushes = getentarray( "cop_zone_visual_enemy", "targetname" );
    var_6591cecb9458082d = getentarray( "cop_zone_visual_friend_pulse", "targetname" );
    var_651b51771bbbe69c = getentarray( "cop_zone_visual_enemy_pulse", "targetname" );
    
    foreach ( objective in level.objectives )
    {
        if ( isdefined( objective.scriptable ) )
        {
            objective.scriptable delete();
            objective.scriptable = undefined;
        }
    }
    
    if ( isdefined( neutralbrushes ) )
    {
        foreach ( brush in neutralbrushes )
        {
            assert( isdefined( brush.script_noteworthy ) );
            objidx = brush.script_noteworthy;
            
            if ( !isdefined( level.objectives[ objidx ].neutralbrush ) )
            {
                level.objectives[ objidx ].neutralbrush = [];
            }
            
            level.objectives[ objidx ].neutralbrush[ level.objectives[ objidx ].neutralbrush.size ] = brush;
            brush hide();
        }
        
        foreach ( brush in var_c4e3db398aa8c45a )
        {
            assert( isdefined( brush.script_noteworthy ) );
            objidx = brush.script_noteworthy;
            
            if ( !isdefined( level.objectives[ objidx ].contestedbrush ) )
            {
                level.objectives[ objidx ].contestedbrush = [];
            }
            
            level.objectives[ objidx ].contestedbrush[ level.objectives[ objidx ].contestedbrush.size ] = brush;
            brush hide();
        }
        
        foreach ( brush in friendlybrushes )
        {
            assert( isdefined( brush.script_noteworthy ) );
            objidx = brush.script_noteworthy;
            
            if ( !isdefined( level.objectives[ objidx ].friendlybrush ) )
            {
                level.objectives[ objidx ].friendlybrush = [];
            }
            
            level.objectives[ objidx ].friendlybrush[ level.objectives[ objidx ].friendlybrush.size ] = brush;
            brush hide();
        }
        
        foreach ( brush in enemybrushes )
        {
            assert( isdefined( brush.script_noteworthy ) );
            objidx = brush.script_noteworthy;
            
            if ( !isdefined( level.objectives[ objidx ].enemybrush ) )
            {
                level.objectives[ objidx ].enemybrush = [];
            }
            
            level.objectives[ objidx ].enemybrush[ level.objectives[ objidx ].enemybrush.size ] = brush;
            brush hide();
        }
        
        foreach ( brush in var_6591cecb9458082d )
        {
            assert( isdefined( brush.script_noteworthy ) );
            objidx = brush.script_noteworthy;
            
            if ( !isdefined( level.objectives[ objidx ].friendlypulsebrush ) )
            {
                level.objectives[ objidx ].friendlypulsebrush = [];
            }
            
            level.objectives[ objidx ].friendlypulsebrush[ level.objectives[ objidx ].friendlypulsebrush.size ] = brush;
            brush hide();
        }
        
        foreach ( brush in var_651b51771bbbe69c )
        {
            assert( isdefined( brush.script_noteworthy ) );
            objidx = brush.script_noteworthy;
            
            if ( !isdefined( level.objectives[ objidx ].enemypulsebrush ) )
            {
                level.objectives[ objidx ].enemypulsebrush = [];
            }
            
            level.objectives[ objidx ].enemypulsebrush[ level.objectives[ objidx ].enemypulsebrush.size ] = brush;
            brush hide();
        }
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x46eb
// Size: 0x1e5
function setupteamoobtriggers()
{
    oobtriggers = getentarray( "cop_outofbounds", "targetname" );
    
    if ( !isdefined( oobtriggers ) )
    {
        return;
    }
    
    foreach ( trigger in oobtriggers )
    {
        assert( isdefined( trigger.script_noteworthy ) );
        objidx = trigger.script_noteworthy;
        
        if ( !isdefined( level.objectives[ objidx ].oobtriggers ) )
        {
            level.objectives[ objidx ].oobtriggers = [];
        }
        
        assert( isdefined( trigger.script_label ) );
        
        if ( isdefined( trigger.target ) )
        {
            othervisuals = getscriptablearray( trigger.target, "targetname" );
            visuals = [];
            
            foreach ( visual in othervisuals )
            {
                index = visuals.size;
                visuals[ index ] = visual;
                
                if ( isdefined( visual.script_noteworthy ) )
                {
                    visuals[ index ].drawcount = int( visual.script_noteworthy );
                    continue;
                }
                
                visuals[ index ].drawcount = 1;
            }
            
            trigger.visuals = visuals;
            trigger thread updateoobvisuals( "off" );
        }
        
        level.objectives[ objidx ].oobtriggers[ trigger.script_label ] = trigger;
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x48d8
// Size: 0x2b4
function validateobjectives()
{
    if ( level.objectives.size == 0 )
    {
        assertmsg( "<dev string:x1c>" );
    }
    else if ( ( level.objectives.size - 2 ) % 2 == 0 )
    {
        assertmsg( "<dev string:x4e>" );
    }
    
    level.midpointobjectiveindex = int( floor( ( level.objectives.size - 2 ) / 2 ) );
    level.currentobjectiveindex = level.midpointobjectiveindex;
    level.previousobjectiveindex = level.currentobjectiveindex;
    
    foreach ( objective in level.objectives )
    {
        if ( level.cmdrules == 1 )
        {
            if ( objective.objectivekey == "_a" || objective.objectivekey == "_b" )
            {
                continue;
            }
        }
        
        index = int( objective.objectivekey );
        tierindex = int( clamp( floor( abs( index - 2 ) ), 0, 2 ) );
        objective.tierindex = tierindex;
        objective.activationdelay = level.tieractivationdelay[ tierindex ];
        objective.captureduration = level.tiercapturetime[ tierindex ];
        objective.holdtime = level.tierholdtime[ tierindex ];
        objective scripts\mp\gameobjects::disableobject();
        objective.firsttime = 1;
        
        if ( level.cmdrules == 1 )
        {
            switch ( tierindex )
            {
                case 0:
                case 1:
                    objective scripts\mp\gameobjects::setcapturebehavior( "persistent" );
                    objective.ignorestomp = 1;
                    break;
                case 2:
                    if ( index < level.midpointobjectiveindex )
                    {
                        objective.defaultownerteam = game[ "defenders" ];
                    }
                    else
                    {
                        objective.defaultownerteam = game[ "attackers" ];
                    }
                    
                    break;
            }
            
            continue;
        }
        
        objective.firsttime = 1;
        objective scripts\mp\gameobjects::setcapturebehavior( "normal" );
        
        if ( index == level.midpointobjectiveindex )
        {
            continue;
        }
        
        if ( index < level.midpointobjectiveindex )
        {
            objective.defaultownerteam = game[ "defenders" ];
            continue;
        }
        
        objective.defaultownerteam = game[ "attackers" ];
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x4b94
// Size: 0x68
function startgame()
{
    level endon( "game_ended" );
    setomnvar( "ui_objective_timer_stopped", 1 );
    setomnvar( "ui_hardpoint_timer", 0 );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    updateteamscores();
    setomnvar( "ui_objective_timer_stopped", 0 );
    
    if ( level.cmdrules == 2 )
    {
        level scripts\mp\gamelogic::pausetimer();
    }
    
    updatecurrentobjective( level.currentobjectiveindex );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x4c04
// Size: 0x3a2
function updatecurrentobjective( newindex )
{
    if ( level.forcedobjectiveindex != -1 )
    {
        newindex = level.forcedobjectiveindex;
    }
    
    if ( !isdefined( level.objectives[ string( newindex ) ] ) )
    {
        return;
    }
    
    if ( isdefined( level.currentobjective ) && isdefined( level.currentobjective.ondisableobjective ) )
    {
        level.currentobjective [[ level.currentobjective.ondisableobjective ]]();
    }
    
    level.previousobjectiveindex = level.currentobjectiveindex;
    level.currentobjectiveindex = newindex;
    updatespectatorcamera( "cop_" + level.currentobjectiveindex );
    level.currentobjective = level.objectives[ string( newindex ) ];
    setomnvar( "ui_cmd_current_obj", newindex );
    updateoobtriggers();
    
    if ( isdefined( level.currentobjective.onenableobjective ) )
    {
        level.currentobjective [[ level.currentobjective.onenableobjective ]]();
    }
    
    thread ui_updatecmdholdprogress();
    updateteamscores();
    
    if ( level.currentobjective.activationdelay > 0 )
    {
        if ( level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex )
        {
            level scripts\mp\gamelogic::pausetimer();
        }
        
        level.activationdelaystarttime = gettime();
        activationdelay = level.currentobjective.activationdelay;
        ui_updatezonetimer( activationdelay );
        ui_updatezonetimerpausedness( 0 );
        ui_updatecmdownerteam( "zone_activation_delay" );
        ui_updatecmdcapturestatus( "zone_activation_delay", 0 );
        wait 3;
        showsplashtoteam( "all", "cop_target" );
        statusdialog( getvoforobjective( "allies", "next" ), "allies", 1 );
        statusdialog( getvoforobjective( "axis", "next" ), "axis", 1 );
        level.currentobjective.firsttime = 0;
        currenttime = gettime();
        
        foreach ( player in level.players )
        {
            player.lastsitreptime = currenttime;
        }
        
        wait activationdelay - 3;
        level.activationdelaystarttime = undefined;
    }
    
    if ( level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex )
    {
        level scripts\mp\gamelogic::resumetimer();
    }
    
    if ( isdefined( level.currentobjective.onactivateobjective ) )
    {
        level.currentobjective [[ level.currentobjective.onactivateobjective ]]();
    }
    
    showsplashtoteam( "all", "cop_activate" );
    spawndelay = 0;
    
    switch ( level.currentobjective.tierindex )
    {
        case 0:
            spawndelay = 0;
            break;
        case 1:
            spawndelay = 5;
            break;
        case 2:
            spawndelay = 10;
            break;
    }
    
    scripts\mp\gamelogic::updatewavespawndelay( spawndelay );
    statusdialog( "cop_target_active", "allies", 0 );
    statusdialog( "cop_target_active", "axis", 0 );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x4fae
// Size: 0x37
function getfirsttimevoforobjective( team )
{
    dialog = "cop_obj_" + level.currentobjectiveindex + "_" + level.mapname;
    return dialog;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 2
// Checksum 0x0, Offset: 0x4fee
// Size: 0x266
function getvoforobjective( team, type )
{
    dialog = "";
    usegeneric = 0;
    var_f575332e106d8432 = team == "allies" && level.previousobjectiveindex > level.currentobjectiveindex || team == "axis" && level.previousobjectiveindex < level.currentobjectiveindex;
    
    if ( type == "next" && level.currentobjective.firsttime )
    {
        dialog = getfirsttimevoforobjective( team );
    }
    else
    {
        switch ( level.currentobjectiveindex )
        {
            case 0:
            case 4:
                usegeneric = 0;
                
                switch ( type )
                {
                    case #"hash_92670f494cc10c48":
                        dialog = "cop_obj_" + level.currentobjectiveindex + ter_op( var_f575332e106d8432, "_attack_", "_defend_" ) + level.mapname;
                        break;
                    case #"hash_6e2ea4fb7e9ad15e":
                        if ( level.currentobjectiveindex == 0 )
                        {
                            dialog = "cop_bombplanted" + ter_op( team == "allies", "_atenemy", "_atfriendly" );
                        }
                        else
                        {
                            dialog = "cop_bombplanted" + ter_op( team == "axis", "_atenemy", "_atfriendly" );
                        }
                        
                        break;
                    case #"hash_ee614ad990a332c4":
                        usegeneric = 1;
                        break;
                }
                
                break;
            case 1:
            case 2:
            case 3:
                switch ( type )
                {
                    case #"hash_92670f494cc10c48":
                        dialog = "cop_obj_" + level.currentobjectiveindex + ter_op( var_f575332e106d8432, "_attack_", "_defend_" ) + level.mapname;
                        break;
                    case #"hash_1bf6fe61528ba20e":
                    case #"hash_ad03d568ce6bff91":
                    case #"hash_dd93195493d0c818":
                        usegeneric = 1;
                        break;
                }
                
                break;
        }
        
        if ( dialog == "" )
        {
            if ( usegeneric )
            {
                dialog = "cop_" + type;
            }
            else
            {
                dialog = "cop_obj_" + level.currentobjectiveindex + "_" + type + "_" + level.mapname;
            }
        }
    }
    
    return dialog;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 10
// Checksum 0x0, Offset: 0x525d
// Size: 0xeb
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    if ( !isplayer( attacker ) || attacker.team == self.team )
    {
        return;
    }
    
    if ( isdefined( objweapon ) && iskillstreakweapon( objweapon.basename ) )
    {
        return;
    }
    
    switch ( level.currentobjective.id )
    {
        case #"hash_87dc3fd822e5915":
            scripts\mp\gametypes\obj_dom::awardgenericmedals( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
            break;
        case #"hash_def5f510c5aa68f4":
            scripts\mp\gametypes\obj_bombzone::bombzone_awardgenericbombzonemedals( attacker, self );
            break;
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x5350
// Size: 0x78
function onplayerconnect( player )
{
    foreach ( objective in level.objectives )
    {
        if ( isdefined( objective.neutralbrush ) )
        {
            objective hidebrushes( player );
        }
    }
    
    player thread updatefloorbrushwaitforjoined();
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x53d0
// Size: 0x69
function decayholdtime( team )
{
    self endon( "domPoint_HoldTimer" );
    
    while ( true )
    {
        if ( isdefined( team ) )
        {
            self.teamholdtimers[ team ] -= level.framedurationseconds;
            
            if ( self.teamholdtimers[ team ] <= 0 )
            {
                self.teamholdtimers[ team ] = 0;
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 2
// Checksum 0x0, Offset: 0x5441
// Size: 0x511
function dompoint_holdtimer( team, credit_player )
{
    level endon( "gameEnded" );
    self notify( "domPoint_HoldTimer" );
    self endon( "domPoint_HoldTimer" );
    level.inobjectiveot = 0;
    ui_updatecmdownerteam( team );
    
    if ( istrue( level.persistentdomtimer ) )
    {
        holdtime = self.teamholdtimers[ team ];
        self.holdteam = team;
    }
    else
    {
        holdtime = level.currentobjective.holdtime;
    }
    
    otherteam = getotherteam( team )[ 0 ];
    
    if ( holdtime > 0 )
    {
        thread decayholdtime( team );
        statusdialog( getvoforobjective( otherteam, "enemy_hold" ), otherteam, 1 );
        var_5c8df3b9e5303ff8 = 0;
        
        if ( level.currentobjectiveindex != 2 && holdtime > 5 )
        {
            closestplayer = getclosestplayeronteam( level.currentobjective.trigger.origin, team );
            
            if ( isdefined( closestplayer ) )
            {
                var_5c8df3b9e5303ff8 += closestplayer getselfobjcaptureddialog( "captured" );
            }
        }
        
        if ( var_5c8df3b9e5303ff8 > 0 )
        {
            wait var_5c8df3b9e5303ff8;
        }
        
        confirmlength = 0;
        closestplayer = getclosestplayeronteam( level.currentobjective.trigger.origin, team );
        
        if ( isdefined( closestplayer ) && holdtime > 5 + var_5c8df3b9e5303ff8 )
        {
            confirmlength = 0;
        }
        
        var_5c8df3b9e5303ff8 += confirmlength;
        wait confirmlength;
        
        if ( holdtime > 5 + var_5c8df3b9e5303ff8 )
        {
            statusdialog( getvoforobjective( team, "hold" ), team, 1 );
        }
        
        if ( holdtime - var_5c8df3b9e5303ff8 > 0 )
        {
            wait holdtime - var_5c8df3b9e5303ff8;
        }
        else
        {
            wait holdtime;
        }
        
        otherteam = getotherteam( team )[ 0 ];
        
        if ( istrue( level.controltoprogress ) && level.currentobjective.touchlist[ otherteam ].size > 0 )
        {
            level.inobjectiveot = 1;
            ui_updatecmdcapturestatus( "overtime", level.currentobjective.stalemate );
            
            while ( true )
            {
                if ( level.currentobjective.touchlist[ otherteam ].size == 0 )
                {
                    break;
                }
                
                waitframe();
            }
            
            level.inobjectiveot = 0;
        }
    }
    
    givescore = 0;
    newindex = level.currentobjectiveindex;
    
    if ( team == game[ "attackers" ] )
    {
        newindex--;
        
        if ( level.currentobjectiveindex <= level.midpointobjectiveindex )
        {
            givescore = 1;
            
            if ( level.currentobjective.tierindex == 1 )
            {
                spawnjuggcate( team, "attacker" );
                spawnjuggcate( getotherteam( team )[ 0 ], "defender" );
            }
            else if ( level.currentobjective.tierindex == 0 )
            {
                if ( isdefined( level.propagandaent ) )
                {
                    level.propagandaent stoploopsound();
                }
            }
        }
    }
    else
    {
        newindex++;
        
        if ( level.currentobjectiveindex >= level.midpointobjectiveindex )
        {
            givescore = 1;
            
            if ( level.currentobjective.tierindex == 1 )
            {
                spawnjuggcate( team, "attacker" );
                spawnjuggcate( getotherteam( team )[ 0 ], "defender" );
            }
            else if ( level.currentobjective.tierindex == 0 )
            {
                if ( isdefined( level.propagandaent ) )
                {
                    level.propagandaent playloopsound( "tmp_emt_mp_faridah_propaganda_lp" );
                }
            }
        }
    }
    
    if ( 0 && givescore )
    {
        giveteamscoreforobjective( team, 1, 0 );
    }
    
    if ( self.tierindex == 0 )
    {
        if ( isdefined( credit_player ) )
        {
            credit_player thread givekillstreak( "uav", 1 );
        }
        else
        {
            closestplayer = getclosestplayeronteam( level.currentobjective.trigger.origin, team );
            closestplayer thread givekillstreak( "uav", 1 );
        }
    }
    
    updateteamscores();
    
    if ( holdtime > 0 )
    {
        statusdialog( getvoforobjective( team, "hold_confirmed" ), team, 1 );
    }
    
    showsplashtoteam( team, "cop_captured_friendly" );
    showsplashtoteam( otherteam, "cop_captured_enemy" );
    
    if ( level.forcedobjectiveindex != -1 )
    {
        giveteamscoreforobjective( team, 1, 0 );
        cmd_endgame( team, game[ "end_reason" ][ "target_destroyed" ] );
        return;
    }
    
    if ( inovertime() )
    {
        giveteamscoreforobjective( team, 1, 0 );
        return;
    }
    
    if ( level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex )
    {
        level.extratime += 90;
        timeleft = scripts\mp\gamelogic::gettimeremaining();
        setgameendtime( gettime() + int( timeleft ) );
        level scripts\mp\gamelogic::resumetimer();
    }
    
    updatecurrentobjective( newindex );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x595a
// Size: 0x59
function dompoint_cancelholdtimer()
{
    if ( !istrue( level.persistentdomtimer ) )
    {
        return;
    }
    
    ownerteam = scripts\mp\gameobjects::getownerteam();
    
    if ( isdefined( self.holdteam ) && self.holdteam == ownerteam )
    {
        ui_updatezonetimerpausedness( 1 );
        self notify( "domPoint_HoldTimer" );
        self.holdteam = undefined;
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 3
// Checksum 0x0, Offset: 0x59bb
// Size: 0x1b
function givekscratetoteam( team, pos, streakname )
{
    
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 3
// Checksum 0x0, Offset: 0x59de
// Size: 0x1b
function createkscrate( team, pos, streakname )
{
    
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 2
// Checksum 0x0, Offset: 0x5a01
// Size: 0x300
function cratethink( team, streakname )
{
    self endon( "restarting_physics" );
    self endon( "death" );
    pos = drop_to_ground( self.origin + ( 7, 9, 0 ), 50, -200, ( 0, 0, 1 ) );
    canister = spawn( "script_model", pos + ( 0, 0, 0 ) );
    canister setmodel( "offhand_wm_grenade_smoke" );
    canister.angles = self.angles + ( -80, 120, 90 );
    vfxent = spawn( "script_model", canister.origin );
    vfxent setmodel( "tag_origin" );
    vfxent.angles = self.angles + ( 0, 30, 0 );
    vfxent playloopsound( "mp_flare_burn_lp" );
    waitframe();
    playfxontag( level._effect[ "vfx_smk_signal" ], vfxent, "tag_origin" );
    hintstring = &"KILLSTREAKS_HINTS/CRATE_PICKUP";
    hinticon = undefined;
    
    switch ( streakname )
    {
        case #"hash_4ad475e6e15635bd":
            hintstring = &"KILLSTREAKS_HINTS/JUGGERNAUT_PICKUP_GL";
            hinticon = "icon_ks_jugg";
            break;
        case #"hash_28d0236400e33fd0":
            hintstring = &"KILLSTREAKS_HINTS/CRUISE_PREDATOR_PICKUP_GL";
            hinticon = "hud_icon_killstreak_cruise_missile";
            break;
        case #"hash_349713b5ad494dda":
            hintstring = &"KILLSTREAKS_HINTS/CHOPPER_GUNNER_PICKUP_GL";
            hinticon = "hud_icon_killstreak_apache";
            break;
    }
    
    self.useobj = scripts\mp\gameobjects::createhintobject( self.origin + anglestoup( self.angles ) * 24, "HINT_BUTTON", hinticon, hintstring, -1, undefined, "show", 250, 360, 100, 360 );
    self.useobj linkto( self );
    
    if ( streakname == "juggernaut" )
    {
        thread gainedjuggupdater( team );
        thread removedjuggupdater( team );
    }
    
    for ( ;; )
    {
        self waittill( "captured", player );
        
        if ( isplayer( player ) )
        {
            player setclientomnvar( "ui_securing", 0 );
            player.ui_securing = undefined;
        }
        
        switch ( streakname )
        {
            case #"hash_4ad475e6e15635bd":
                if ( !player thread givejuggernaut() )
                {
                    continue;
                }
                
                break;
            case #"hash_28d0236400e33fd0":
                player thread givekillstreak( "cruise_predator", 1 );
                wait 3;
                break;
            case #"hash_349713b5ad494dda":
                player thread givekillstreak( "chopper_gunner", 1 );
                wait 3;
                break;
        }
        
        player playlocalsound( "ammo_crate_use" );
        stopfxontag( level._effect[ "vfx_smk_signal" ], vfxent, "tag_origin" );
        vfxent stoploopsound();
        vfxent delete();
        vfxent = undefined;
        canister delete();
        canister = undefined;
        scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x5d09
// Size: 0xb0
function gainedjuggupdater( team )
{
    self endon( "death" );
    
    foreach ( player in level.players )
    {
        if ( player.team == team && istrue( player.isjuggernaut ) )
        {
            self disableplayeruse( player );
        }
    }
    
    while ( true )
    {
        level waittill( "gained_juggernaut", player );
        
        if ( player.team == team )
        {
            self disableplayeruse( player );
        }
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x5dc1
// Size: 0x46
function removedjuggupdater( team )
{
    self endon( "death" );
    
    while ( true )
    {
        level waittill( "removed_juggernaut", player );
        
        if ( player.team == team )
        {
            self enableplayeruse( player );
        }
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 2
// Checksum 0x0, Offset: 0x5e0f
// Size: 0x46
function givekillstreak( streakname, useimmediate )
{
    streakitem = scripts\mp\killstreaks\killstreaks::createstreakitemstruct( streakname );
    scripts\mp\killstreaks\killstreaks::awardkillstreakfromstruct( streakitem, "other" );
    
    if ( istrue( useimmediate ) )
    {
        wait 0.1;
        self notify( "ks_action_4" );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x5e5d
// Size: 0xa7
function bombzone_warningklaxon()
{
    level endon( "game_ended" );
    thread scripts\mp\music_and_dialog::stopsuspensemusic();
    var_ea070ab75fe8c094 = game[ "music" ][ "cop_finalpush" ].size;
    var_88e74978a3823f5f = randomint( var_ea070ab75fe8c094 );
    
    foreach ( player in level.players )
    {
        player setplayermusicstate( game[ "music" ][ "cop_finalpush" ][ var_88e74978a3823f5f ] );
    }
    
    wait 2;
    wait 16;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x5f0c
// Size: 0x1de
function bombzone_holdtimer( endtime )
{
    if ( !isdefined( level.currentobjective ) )
    {
        return;
    }
    
    level endon( "gameEnded" );
    level endon( "bomb_planted" );
    self notify( "bombZone_HoldTimer" );
    self endon( "bombZone_HoldTimer" );
    ownerteam = level.currentobjective.defaultownerteam;
    otherteam = getotherteam( level.currentobjective.defaultownerteam )[ 0 ];
    scripts\mp\objidpoolmanager::objective_show_team_progress( level.currentobjective.objidnum, otherteam );
    level.timelimitoverride = 0;
    
    if ( endtime > 0 )
    {
        ui_updatezonetimer( endtime );
        wait endtime;
        
        if ( istrue( level.controltoprogress ) )
        {
            otherteam = getotherteam( level.currentobjective.defaultownerteam )[ 0 ];
            updatedui = 0;
            
            while ( true )
            {
                if ( !updatedui )
                {
                    updatedui = 1;
                    ui_updatecmdcapturestatus( "overtime", level.currentobjective.stalemate );
                }
                
                if ( level.currentobjective.touchlist[ otherteam ].size == 0 )
                {
                    break;
                }
                
                waitframe();
            }
        }
    }
    
    foreach ( player in level.players )
    {
        player setplayermusicstate( "mus_mp_cop_bombplant_end" );
    }
    
    thread scripts\mp\music_and_dialog::suspensemusic();
    newindex = level.currentobjectiveindex;
    team = level.currentobjective scripts\mp\gameobjects::getownerteam();
    
    if ( team == game[ "attackers" ] )
    {
        newindex--;
    }
    else
    {
        newindex++;
    }
    
    updatecurrentobjective( newindex );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 3
// Checksum 0x0, Offset: 0x60f2
// Size: 0x7f
function bombhandler( player, desttype, playerteam )
{
    if ( level.gameended )
    {
        return;
    }
    
    if ( desttype == "explode" )
    {
        self.bombexploded = 1;
        level.currentobjective [[ level.currentobjective.ondisableobjective ]]();
        giveteamscoreforobjective( playerteam, 1, 0 );
        cmd_endgame( playerteam, game[ "end_reason" ][ "target_destroyed" ] );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x6179
// Size: 0x49
function resetbombzone()
{
    scripts\mp\gameobjects::setusetime( level.planttime );
    scripts\mp\gameobjects::setvisibleteam( "none" );
    self.id = "bomb_zone";
    self.useweapon = makeweapon( "briefcase_bomb_mp" );
    self.bombexploded = undefined;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 2
// Checksum 0x0, Offset: 0x61ca
// Size: 0x1b6
function cmd_endgame( winningteam, endreasontext )
{
    level.docmdoutro = 1;
    camerastruct = undefined;
    
    if ( level.mapname == "mp_faridah" )
    {
        camerastruct = spawnstruct();
        
        if ( winningteam == "allies" )
        {
            camerastruct.origin = ( -207, -4711, 211 );
            camerastruct.angles = ( 7, 64, 0 );
        }
        else if ( winningteam == "axis" )
        {
            camerastruct.origin = ( 1945, 4423, 670 );
            camerastruct.angles = ( 15, 244, 0 );
        }
        else
        {
            assertmsg( "<dev string:x90>" );
        }
    }
    
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            player setclientomnvar( "ui_objective_pinned_text_param", 0 );
        }
        
        player thread playendofmatchtransition( camerastruct );
    }
    
    winnerscore = game[ "teamScores" ][ winningteam ];
    loserscore = game[ "teamScores" ][ getotherteam( winningteam )[ 0 ] ];
    
    if ( loserscore > winnerscore )
    {
        var_36f3228e1d630f1b = loserscore - winnerscore + 1;
        giveteamscoreforobjective( winningteam, var_36f3228e1d630f1b, 0 );
    }
    
    thread scripts\mp\gamelogic::endgame( winningteam, endreasontext );
    wait 0.65;
    level notify( "allow_bomb_explosion" );
    wait 5;
    level notify( "cmd_continue_game_end" );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x6388
// Size: 0x17c
function dompoint_onbeginuse( player )
{
    dompoint_cancelholdtimer();
    scripts\mp\gametypes\obj_dom::dompoint_onusebegin( player );
    self.didstatusnotify = 1;
    thread updateflares( player.team );
    ui_updatecmdcapturestatus( player.team, self.stalemate );
    
    if ( player.team == game[ "attackers" ] )
    {
        if ( level.currentobjectiveindex == 0 || level.currentobjectiveindex == 4 )
        {
            bombzoneowner = scripts\mp\gameobjects::getownerteam();
            
            if ( player.team != bombzoneowner )
            {
                player getselfobjcaptureddialog( "planting" );
            }
            else
            {
                player getselfobjcaptureddialog( "defusing" );
            }
        }
    }
    
    otherteam = getotherteam( player.team )[ 0 ];
    
    if ( otherteam == scripts\mp\gameobjects::getownerteam() )
    {
        statusdialog( getvoforobjective( player.team, "enemy_cap" ), otherteam, 0 );
    }
    else
    {
        statusdialog( getvoforobjective( player.team, "enemy_sec" ), otherteam, 0 );
    }
    
    foreach ( player in level.players )
    {
        updatefloorbrush( player );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x650c
// Size: 0x282
function dompoint_onuse( credit_player )
{
    if ( istrue( level.persistentdomtimer ) )
    {
        ui_updatezonetimerpausedness( 0 );
        self.lastcaptime = gettime();
        self.firstcapture = 0;
    }
    
    scripts\mp\gametypes\obj_dom::dompoint_onuse( credit_player );
    team = scripts\mp\gameobjects::getownerteam();
    thread updateflares( team );
    
    foreach ( player in level.players )
    {
        updatefloorbrush( player );
    }
    
    level.usestartspawns = 0;
    assert( team != "<dev string:xd0>" );
    otherteam = getotherteam( team )[ 0 ];
    thread printandsoundoneveryone( team, otherteam, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", credit_player );
    
    if ( level.cmdrules == 2 )
    {
        if ( level.currentobjectiveindex == level.midpointobjectiveindex )
        {
            level.cmdattackingteam = team;
            level.cmddefendingteam = otherteam;
            level scripts\mp\gamelogic::pausetimer();
        }
        else
        {
            level.extratime += 90;
            timeleft = scripts\mp\gamelogic::gettimeremaining();
            setgameendtime( gettime() + int( timeleft ) );
        }
    }
    
    if ( level.currentobjectiveindex == 0 )
    {
        bombzoneowner = level.objectives[ "_b" ] scripts\mp\gameobjects::getownerteam();
        
        if ( team != bombzoneowner )
        {
            level.objectives[ "_b" ] bombzone_onuseplantobject( credit_player );
        }
        else
        {
            level.objectives[ "_b" ] bombzone_onusedefuseobject( credit_player );
        }
    }
    else if ( level.currentobjectiveindex == 4 )
    {
        bombzoneowner = level.objectives[ "_a" ] scripts\mp\gameobjects::getownerteam();
        
        if ( team != bombzoneowner )
        {
            level.objectives[ "_a" ] bombzone_onuseplantobject( credit_player );
        }
        else
        {
            level.objectives[ "_a" ] bombzone_onusedefuseobject( credit_player );
        }
    }
    else
    {
        thread dompoint_holdtimer( team, credit_player );
        showsplashtoteam( team, "cop_hold_friendly" );
        showsplashtoteam( otherteam, "cop_hold_enemy" );
    }
    
    if ( self == level.currentobjective )
    {
        ui_updatecmdcapturestatus( "neutral", 0 );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 3
// Checksum 0x0, Offset: 0x6796
// Size: 0x1c5
function dompoint_onenduse( team, player, success )
{
    if ( self != level.currentobjective )
    {
        return;
    }
    
    scripts\mp\gametypes\obj_dom::dompoint_onuseend( team, player, success );
    ownerteam = scripts\mp\gameobjects::getownerteam();
    state = ter_op( ownerteam == "neutral", "idle", ownerteam );
    thread updateflares( state );
    
    if ( level.cmdrules == 2 )
    {
        if ( level.currentobjectiveindex == level.midpointobjectiveindex )
        {
            ownerteam = scripts\mp\gameobjects::getownerteam();
            ui_updatecmdcapturestatus( "neutral", 0 );
            
            if ( istrue( level.persistentdomtimer ) && self.objectivekey != "0" && self.objectivekey != "4" )
            {
                if ( ownerteam != "neutral" )
                {
                    ui_updatezonetimerpausedness( 0 );
                    self.lastcaptime = gettime();
                    thread dompoint_holdtimer( ownerteam );
                }
            }
        }
    }
    else if ( !success )
    {
        ownerteam = scripts\mp\gameobjects::getownerteam();
        ui_updatecmdcapturestatus( "neutral", 0 );
        
        if ( istrue( level.persistentdomtimer ) && self.objectivekey != "0" && self.objectivekey != "4" )
        {
            if ( ownerteam != "neutral" )
            {
                ui_updatezonetimerpausedness( 0 );
                self.lastcaptime = gettime();
                thread dompoint_holdtimer( ownerteam );
            }
        }
    }
    
    foreach ( player in level.players )
    {
        updatefloorbrush( player );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x6963
// Size: 0x10a
function dompoint_oncontested()
{
    if ( self != level.currentobjective )
    {
        return;
    }
    
    dompoint_cancelholdtimer();
    scripts\mp\gametypes\obj_dom::dompoint_oncontested();
    thread updateflares( "contested" );
    ownerteam = scripts\mp\gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" )
    {
        if ( level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex )
        {
            level scripts\mp\gamelogic::resumetimer();
        }
    }
    
    ui_updatecmdcapturestatus( ownerteam, 1 );
    notifyteam = ownerteam;
    
    if ( ownerteam == "neutral" )
    {
        notifyteam = self.claimteam;
    }
    
    if ( notifyteam != "none" )
    {
        statusdialog( "cop_obj_contested", notifyteam, 0 );
    }
    
    foreach ( player in level.players )
    {
        updatefloorbrush( player );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x6a75
// Size: 0x1d6
function dompoint_onuncontested( lastclaimteam )
{
    if ( self != level.currentobjective )
    {
        return;
    }
    
    scripts\mp\gametypes\obj_dom::dompoint_onuncontested( lastclaimteam );
    self.didstatusnotify = 1;
    ownerteam = scripts\mp\gameobjects::getownerteam();
    
    if ( ownerteam == "neutral" )
    {
        if ( level.cmdrules == 2 && level.currentobjectiveindex == level.midpointobjectiveindex )
        {
            level scripts\mp\gamelogic::resumetimer();
        }
    }
    
    state = ter_op( ownerteam == "neutral", "idle", ownerteam );
    thread updateflares( state );
    
    if ( level.cmdrules == 2 )
    {
        if ( level.currentobjectiveindex == level.midpointobjectiveindex )
        {
            if ( ownerteam != "neutral" && self.touchlist[ getotherteam( ownerteam )[ 0 ] ].size == 0 )
            {
                ui_updatezonetimerpausedness( 0 );
                self.lastcaptime = gettime();
                thread dompoint_holdtimer( ownerteam );
            }
        }
    }
    else if ( istrue( level.persistentdomtimer ) && level.currentobjectiveindex != 0 && level.currentobjectiveindex != 4 )
    {
        if ( ownerteam != "neutral" && self.touchlist[ getotherteam( ownerteam )[ 0 ] ].size == 0 )
        {
            ui_updatezonetimerpausedness( 0 );
            self.lastcaptime = gettime();
            thread dompoint_holdtimer( ownerteam );
        }
    }
    
    ui_updatecmdcapturestatus( "neutral", 0 );
    
    foreach ( player in level.players )
    {
        updatefloorbrush( player );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x6c53
// Size: 0x97
function dompoint_ondisableobjective()
{
    scripts\mp\gameobjects::allowuse( "none" );
    scripts\mp\gameobjects::disableobject();
    scripts\mp\gameobjects::resetcaptureprogress();
    scripts\mp\gameobjects::releaseid();
    delaythread( 0.1, &disabledomflagscriptable );
    thread updateflares( "off" );
    
    foreach ( player in level.players )
    {
        updatefloorbrush( player, 1 );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x6cf2
// Size: 0x1d3
function dompoint_onenableobjective()
{
    scripts\mp\gameobjects::requestid( 1, 1 );
    scripts\mp\objidpoolmanager::objective_set_play_intro( self.objidnum, 1 );
    scripts\mp\objidpoolmanager::objective_set_play_outro( self.objidnum, 1 );
    scripts\mp\gameobjects::enableobject();
    scripts\mp\gameobjects::setvisibleteam( "any" );
    scripts\mp\gameobjects::allowuse( "none" );
    scripts\mp\gameobjects::setobjectivestatusicons( level.icontarget );
    
    if ( istrue( level.persistentdomtimer ) )
    {
        if ( !isdefined( self.teamholdtimers ) )
        {
            self.teamholdtimers = [];
        }
        
        self.teamholdtimers[ "allies" ] = self.holdtime;
        self.teamholdtimers[ "axis" ] = self.holdtime;
        self.firstcapture = 1;
        self.holdteam = undefined;
    }
    
    if ( isdefined( self.defaultownerteam ) )
    {
        scripts\mp\gameobjects::setownerteam( self.defaultownerteam );
        thread scripts\mp\gametypes\obj_dom::updateflagstate( self.defaultownerteam, 0 );
        thread updateflares( self.defaultownerteam );
    }
    else
    {
        scripts\mp\gameobjects::setownerteam( "neutral" );
        thread scripts\mp\gametypes\obj_dom::updateflagstate( "idle", 0 );
        thread updateflares( "idle" );
    }
    
    if ( level.currentobjectiveindex == 0 || level.currentobjectiveindex == 4 )
    {
        thread bombzone_warningklaxon();
    }
    
    if ( getdvarint( @"hash_3bfe19e3234d5dff", 0 ) != 0 )
    {
        scripts\mp\gametypes\bradley_spawner::tryspawnneutralbradleycmd( level.currentobjectiveindex );
    }
    
    foreach ( player in level.players )
    {
        updatefloorbrush( player );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x6ecd
// Size: 0xf1
function dompoint_onactivateobjective()
{
    playsoundonplayers( "mp_combat_outpost_activateobj" );
    ownerteam = scripts\mp\gameobjects::getownerteam();
    ui_updatecmdownerteam( ownerteam );
    ui_updatecmdcapturestatus( "neutral", 0 );
    scripts\mp\gameobjects::allowuse( "enemy" );
    thread awardcapturepoints();
    level.flagcapturetime = self.captureduration;
    
    if ( self.tierindex == 2 )
    {
        if ( level.cmdrules == 1 )
        {
            level.flagcapturetime = 5;
        }
        
        scripts\mp\gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
    }
    else
    {
        scripts\mp\gameobjects::setobjectivestatusicons( level.iconneutral );
    }
    
    if ( level.cmdrules == 1 )
    {
        if ( level.currentobjectiveindex == 0 || level.currentobjectiveindex == 4 )
        {
            thread bombzone_holdtimer( self.holdtime );
        }
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x6fc6
// Size: 0x13
function bombzone_onbeginuse( player )
{
    scripts\mp\gametypes\obj_bombzone::bombzone_onbeginuse( player );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 3
// Checksum 0x0, Offset: 0x6fe1
// Size: 0x25
function bombzone_onenduse( team, player, result )
{
    scripts\mp\gametypes\obj_bombzone::bombzone_onenduse( team, player, result );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x700e
// Size: 0x20f
function bombzone_onuseplantobject( credit_player )
{
    ownerteam = scripts\mp\gameobjects::getownerteam();
    otherteam = getotherteam( ownerteam )[ 0 ];
    scripts\mp\objidpoolmanager::objective_show_team_progress( level.currentobjective.objidnum, ownerteam );
    showsplashtoteam( "all", "cop_planted" );
    level.flagcapturetime = 15;
    
    if ( istrue( level.persistentbombtimer ) )
    {
        if ( !isdefined( level.basefusetimers ) )
        {
            level.basefusetimers = [];
            level.basefusetimers[ "allies" ] = level.bombtimer;
            level.basefusetimers[ "axis" ] = level.bombtimer;
        }
        
        level.bombtimer = level.basefusetimers[ ownerteam ];
        level.lastbombplanttime = gettime();
    }
    
    scripts\mp\gametypes\obj_bombzone::bombzone_onuseplantobject( credit_player );
    var_6c7470a87c232ec5 = game[ "music" ][ "cop_bombplant" ].size;
    bombplant_track = randomint( var_6c7470a87c232ec5 );
    
    foreach ( player in level.players )
    {
        player setplayermusicstate( game[ "music" ][ "cop_bombplant" ][ bombplant_track ] );
    }
    
    if ( false )
    {
        giveteamscoreforobjective( credit_player.team, 1, 0 );
    }
    
    statusdialog( getvoforobjective( ownerteam, "bomb_planted" ), ownerteam, 1 );
    statusdialog( getvoforobjective( otherteam, "bomb_planted" ), otherteam, 1 );
    
    if ( isdefined( level.zoneendtime ) )
    {
        level.zoneendtime = int( level.zoneendtime - gettime() );
    }
    
    if ( level.cmdrules == 1 )
    {
        ui_updatebombtimer();
    }
    
    ui_updatecmdownerteam( credit_player.team );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x7225
// Size: 0x183
function bombzone_onusedefuseobject( player )
{
    if ( !level.bombplanted )
    {
        return;
    }
    
    showsplashtoteam( "all", "cop_defused" );
    ownerteam = scripts\mp\gameobjects::getownerteam();
    otherteam = getotherteam( ownerteam )[ 0 ];
    level.flagcapturetime = 5;
    
    if ( istrue( level.persistentbombtimer ) )
    {
        level.basefusetimers[ ownerteam ] -= ( gettime() - level.lastbombplanttime ) / 1000;
    }
    
    level.bombsplanted -= 1;
    
    if ( self.objectivekey == "_a" )
    {
        level.aplanted = 0;
    }
    else
    {
        level.bplanted = 0;
    }
    
    scripts\mp\gametypes\obj_bombzone::bombzone_onusedefuseobject( player );
    
    if ( getotherteam( player.team )[ 0 ] == "allies" )
    {
    }
    
    scripts\mp\gameobjects::setvisibleteam( "none" );
    statusdialog( getvoforobjective( ownerteam, "bomb_defused" ), ownerteam, 1 );
    statusdialog( getvoforobjective( otherteam, "bomb_defused" ), otherteam, 1 );
    player notify( "bomb_defused" + self.objectivekey );
    self notify( "defused" );
    resetbombzone();
    
    if ( isdefined( level.zoneendtime ) )
    {
        thread bombzone_holdtimer( level.zoneendtime / 1000 );
    }
    
    ui_updatecmdownerteam( player.team );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x73b0
// Size: 0x15
function bombzone_ondisableobjective()
{
    scripts\mp\gameobjects::disableobject();
    scripts\mp\gameobjects::allowuse( "none" );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x73cd
// Size: 0x31
function bombzone_onenableobjective()
{
    scripts\mp\gameobjects::enableobject();
    scripts\mp\gameobjects::setvisibleteam( "any" );
    scripts\mp\gameobjects::allowuse( "none" );
    scripts\mp\gameobjects::setobjectivestatusicons( level.icontarget );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x7406
// Size: 0x81
function bombzone_onactivateobjective()
{
    playsoundonplayers( "mp_combat_outpost_activateobj" );
    ui_updatecmdownerteam( "neutral" );
    ui_updatecmdcapturestatus( "neutral", 0 );
    level.planttime = self.captureduration;
    level.defusetime = self.captureduration;
    scripts\mp\gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
    scripts\mp\gameobjects::allowuse( "enemy" );
    thread bombzone_holdtimer( self.holdtime );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x748f
// Size: 0x38
function ui_updatezonetimer( seconds )
{
    level.zoneendtime = int( gettime() + 1000 * seconds );
    setomnvar( "ui_hardpoint_timer", level.zoneendtime );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x74cf
// Size: 0x32
function ui_updatebombtimer()
{
    bombendtime = int( gettime() + 1000 * level.bombtimer );
    setomnvar( "ui_hardpoint_timer", bombendtime );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x7509
// Size: 0x17
function ui_updatezonetimerpausedness( ispaused )
{
    setomnvar( "ui_objective_timer_stopped", ispaused );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x7528
// Size: 0x75
function getownerteamplayer( ownerteam )
{
    ownerplayer = undefined;
    
    foreach ( player in level.players )
    {
        if ( player.team == ownerteam )
        {
            return player;
        }
    }
    
    return ownerplayer;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 2
// Checksum 0x0, Offset: 0x75a6
// Size: 0xc7
function ui_updatecmdcapturestatus( status, contested )
{
    omnvarval = -1;
    
    if ( istrue( level.inobjectiveot ) )
    {
        if ( contested )
        {
            omnvarval = -4;
        }
        else
        {
            omnvarval = -5;
        }
    }
    else if ( contested )
    {
        omnvarval = -2;
    }
    else
    {
        switch ( status )
        {
            case #"hash_5f54b9bf7583687f":
                omnvarval = 2;
                break;
            case #"hash_7c2d091e6337bf54":
                omnvarval = 1;
                break;
            case #"hash_3bf8ec5fe1d42da8":
                omnvarval = -3;
                break;
            case #"hash_4a79ea9678ed059e":
                omnvarval = -4;
                break;
            case #"hash_c312107e6bce703c":
            default:
                break;
        }
    }
    
    setomnvar( "ui_cmd_capture_team", omnvarval );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x7675
// Size: 0x82
function ui_updatecmdownerteam( ownerteam )
{
    omnvarval = -1;
    
    switch ( ownerteam )
    {
        case #"hash_5f54b9bf7583687f":
            omnvarval = 2;
            break;
        case #"hash_7c2d091e6337bf54":
            omnvarval = 1;
            break;
        case #"hash_3bf8ec5fe1d42da8":
            omnvarval = -3;
            break;
        case #"hash_c312107e6bce703c":
        default:
            break;
    }
    
    setomnvar( "ui_cmd_owner_team", omnvarval );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x76ff
// Size: 0x41
function ui_updatecmdprogress()
{
    while ( true )
    {
        if ( isdefined( level.currentobjective ) )
        {
            setomnvar( "ui_cmd_capture_progress", level.currentobjective scripts\mp\gameobjects::getcaptureprogress() );
        }
        else
        {
            setomnvar( "ui_cmd_capture_progress", 0 );
        }
        
        waitframe();
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x7748
// Size: 0x107
function ui_updatecmdholdprogress()
{
    self notify( "ui_updateCMDHoldProgress" );
    self endon( "ui_updateCMDHoldProgress" );
    
    while ( true )
    {
        if ( isdefined( level.currentobjective ) && isdefined( level.currentobjective.teamholdtimers ) && isdefined( level.currentobjective.holdtime ) && level.currentobjective.holdtime > 0 )
        {
            setomnvar( "ui_cmd_owner_progress_allies", 1 - level.currentobjective.teamholdtimers[ "allies" ] / level.currentobjective.holdtime );
            setomnvar( "ui_cmd_owner_progress_axis", 1 - level.currentobjective.teamholdtimers[ "axis" ] / level.currentobjective.holdtime );
        }
        else
        {
            setomnvar( "ui_cmd_owner_progress_allies", 0 );
            setomnvar( "ui_cmd_owner_progress_axis", 0 );
        }
        
        waitframe();
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x7857
// Size: 0x2ea
function getcurrentvalue()
{
    if ( !isdefined( level.currentobjective ) )
    {
        return 0.5;
    }
    
    var_3ba14998c431ff5a = getcenterfrac( level.currentobjectiveindex );
    var_d53f69b9843525d5 = 0;
    ownerteam = level.currentobjective scripts\mp\gameobjects::getownerteam();
    captureprogress = 0;
    progresspercent = 0.03;
    transitionpercent = 0;
    
    if ( isdefined( level.activationdelaystarttime ) && level.previousobjectiveindex != level.currentobjectiveindex )
    {
        if ( isdefined( level.currentobjective.defaultownerteam ) )
        {
            var_d53f69b9843525d5 = progresspercent;
            
            if ( ownerteam == "allies" )
            {
                var_d53f69b9843525d5 *= -1;
            }
            
            progresspercent *= 2;
        }
        
        captureprogress = 1;
        currenttime = gettime();
        transitionfrac = ( currenttime - level.activationdelaystarttime ) / level.currentobjective.activationdelay * 1000;
        transitionpercent = ( abs( getcenterfrac( level.previousobjectiveindex ) - var_3ba14998c431ff5a ) - progresspercent ) * transitionfrac;
        
        if ( level.currentobjectiveindex < level.previousobjectiveindex )
        {
            transitionpercent *= -1;
            progresspercent *= -1;
        }
        
        var_3ba14998c431ff5a = getcenterfrac( level.previousobjectiveindex );
    }
    else
    {
        ownerteam = level.currentobjective scripts\mp\gameobjects::getownerteam();
        
        if ( ownerteam != "neutral" )
        {
            var_d53f69b9843525d5 = progresspercent;
            
            if ( ownerteam == "allies" )
            {
                var_d53f69b9843525d5 *= -1;
            }
            
            if ( isdefined( level.currentobjective.claimteam ) && level.currentobjective.claimteam != "none" )
            {
                if ( level.currentobjective.claimteam != ownerteam )
                {
                    progresspercent *= 2;
                    captureprogress = level.currentobjective scripts\mp\gameobjects::getcaptureprogress();
                    
                    if ( level.currentobjective.claimteam == "allies" )
                    {
                        captureprogress *= -1;
                    }
                }
            }
        }
        else
        {
            captureprogress = level.currentobjective scripts\mp\gameobjects::getcaptureprogress();
            
            if ( isdefined( level.currentobjective.claimteam ) && level.currentobjective.claimteam != "none" )
            {
                if ( level.currentobjective.claimteam == "allies" )
                {
                    captureprogress *= -1;
                }
            }
            else if ( isdefined( level.currentobjective.lastclaimteam ) )
            {
                if ( level.currentobjective.lastclaimteam == "allies" )
                {
                    captureprogress *= -1;
                }
            }
        }
    }
    
    return var_3ba14998c431ff5a + var_d53f69b9843525d5 + captureprogress * progresspercent + transitionpercent;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x7b4a
// Size: 0x94
function getcenterfrac( index )
{
    var_3ba14998c431ff5a = 0;
    
    switch ( index )
    {
        case 0:
            var_3ba14998c431ff5a = 0;
            break;
        case 1:
            var_3ba14998c431ff5a = 0.25;
            break;
        case 2:
            var_3ba14998c431ff5a = 0.5;
            break;
        case 3:
            var_3ba14998c431ff5a = 0.75;
            break;
        case 4:
            var_3ba14998c431ff5a = 1;
            break;
    }
    
    return var_3ba14998c431ff5a;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x7be7
// Size: 0x23
function updateteamscores()
{
    if ( true )
    {
        _setteamscore( "allies", 0, 0 );
        _setteamscore( "axis", 0, 0 );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 2
// Checksum 0x0, Offset: 0x7c12
// Size: 0x1f4
function spawnjuggcate( team, role )
{
    spawnbehavior = level.juggspawnbehavior;
    
    if ( role == "attacker" && spawnbehavior != 1 && spawnbehavior != 3 )
    {
        return;
    }
    
    if ( role == "defender" && spawnbehavior != 2 && spawnbehavior != 3 )
    {
        return;
    }
    
    if ( !isdefined( level.juggcrates ) )
    {
        level.juggcrates = [];
        level.juggcrates[ "allies" ] = [];
        level.juggcrates[ "axis" ] = [];
    }
    
    if ( isdefined( level.juggcrates[ team ][ role ] ) )
    {
        return;
    }
    
    pos = undefined;
    
    switch ( level.mapname )
    {
        case #"hash_ecbb96ade87e6efa":
            if ( role == "attacker" )
            {
                if ( team == "allies" )
                {
                    pos = ( 250, -2040, 215 );
                }
                else
                {
                    pos = ( 786, 2413, 260 );
                }
            }
            else if ( role == "defender" )
            {
                if ( team == "allies" )
                {
                    pos = ( 25, -4630, 10 );
                }
                else
                {
                    pos = ( 1480, 4375, -40 );
                }
            }
            
            break;
        case #"hash_3d15d48cf23a3f75":
            if ( role == "attacker" )
            {
                if ( team == "allies" )
                {
                    pos = ( 2775, 2375, 360 );
                }
                else
                {
                    pos = ( -60, -260, 450 );
                }
            }
            else if ( role == "defender" )
            {
                if ( team == "allies" )
                {
                    pos = ( -2680, -855, 250 );
                }
                else
                {
                    pos = ( 2365, 4360, 360 );
                }
            }
            
            break;
    }
    
    if ( isdefined( pos ) )
    {
        level.juggcrates[ team ][ role ] = givekscratetoteam( team, pos, "juggernaut" );
        level.juggcrates[ team ][ role ] thread removeondeath( team, role );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 2
// Checksum 0x0, Offset: 0x7e0e
// Size: 0x2f
function removeondeath( team, role )
{
    level endon( "game_ended" );
    self waittill( "death" );
    level.juggcrates[ team ][ role ] = undefined;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x7e45
// Size: 0x233, Type: bool
function givejuggernaut()
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    if ( istrue( self.isjuggernaut ) )
    {
        return false;
    }
    
    if ( isdefined( self.lightarmorhp ) )
    {
        scripts\mp\perks\perkfunctions::unsetlightarmor();
    }
    
    scripts\mp\lightarmor::setlightarmorvalue( self, 500, 1, 0 );
    scripts\mp\weapons::setplantedequipmentuse( 0 );
    val::set( "juggernaut", "offhand_weapons", 0 );
    val::set( "juggernaut", "weapon_pickup", 0 );
    
    if ( _hasperk( "specialty_explosivebullets" ) )
    {
        removeperk( "specialty_explosivebullets" );
    }
    
    _takeweapon( self.primaryweapon );
    _takeweapon( self.secondaryweapon );
    primaryweapon = "iw8_lm_kilo121_mp";
    _giveweapon( primaryweapon );
    self givemaxammo( primaryweapon );
    _switchtoweapon( primaryweapon );
    self.juggoverlay = newclienthudelem( self );
    self.juggoverlay.x = 0;
    self.juggoverlay.y = 0;
    self.juggoverlay.alignx = "left";
    self.juggoverlay.aligny = "top";
    self.juggoverlay.horzalign = "fullscreen";
    self.juggoverlay.vertalign = "fullscreen";
    self.juggoverlay setshader( "gasmask_overlay_delta", 640, 480 );
    self.juggoverlay.sort = -10;
    self.juggoverlay.archived = 1;
    self.juggoverlay.alpha = 1;
    self.health = self.maxhealth;
    self.isjuggernaut = 1;
    self.movespeedscaler = 0.75;
    giveperk( "specialty_scavenger" );
    giveperk( "specialty_quickdraw" );
    giveperk( "specialty_sharp_focus" );
    thread juggernautsounds();
    thread juggremover();
    level notify( "gained_juggernaut", self );
    return true;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x8081
// Size: 0x25
function juggernautsounds()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "jugg_removed" );
    
    while ( true )
    {
        wait 3;
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x80ae
// Size: 0xe2
function juggremover()
{
    self endon( "disconnect" );
    thread removejuggongameended();
    thread removejuggonteamchangeordeath();
    self waittill( "should_remove_jugg" );
    
    if ( isdefined( self.lightarmorhp ) )
    {
        scripts\mp\perks\perkfunctions::unsetlightarmor();
    }
    
    scripts\mp\weapons::setplantedequipmentuse( 1 );
    val::reset_all( "juggernaut" );
    self.juggoverlay destroy();
    _takeweapon( "iw8_lm_kilo121_mp" );
    _giveweapon( self.primaryweapon );
    _giveweapon( self.secondaryweapon );
    _switchtoweapon( self.primaryweapon );
    self.movespeedscaler = 1;
    removeperk( "specialty_scavenger" );
    removeperk( "specialty_quickdraw" );
    removeperk( "specialty_sharp_focus" );
    self.isjuggernaut = 0;
    level notify( "removed_juggernaut", self );
    self notify( "jugg_removed" );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x8198
// Size: 0x20
function removejuggongameended()
{
    self endon( "disconnect" );
    self endon( "jugg_removed" );
    level waittill( "game_ended" );
    self notify( "should_remove_jugg" );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x81c0
// Size: 0x3a
function removejuggonteamchangeordeath()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "jugg_removed" );
    waittill_any_4( "death", "joined_team", "joined_spectators", "lost_juggernaut" );
    self notify( "should_remove_jugg" );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 2
// Checksum 0x0, Offset: 0x8202
// Size: 0xfe
function updatefloorbrush( player, disabled )
{
    if ( !isdefined( self.neutralbrush ) )
    {
        return;
    }
    
    ownerteam = self.ownerteam;
    claimteam = self.claimteam;
    var_8e879faf3052e0d2 = player.team;
    iscodcaster = player iscodcaster();
    
    if ( iscodcaster )
    {
        var_8e879faf3052e0d2 = player getcodcasterteam();
    }
    
    if ( istrue( disabled ) )
    {
        hidebrushes( player );
    }
    else if ( istrue( self.stalemate ) )
    {
        showcontestedbrush( player );
    }
    else if ( ownerteam == "neutral" )
    {
        if ( claimteam != "none" )
        {
            if ( var_8e879faf3052e0d2 == claimteam )
            {
                showfriendlybrush( player );
            }
            else
            {
                showenemybrush( player );
            }
        }
        else
        {
            showneutralbrush( player );
        }
    }
    else if ( var_8e879faf3052e0d2 == ownerteam )
    {
        showfriendlybrush( player );
    }
    else
    {
        showenemybrush( player );
    }
    
    updatecapturebrush( player );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x8308
// Size: 0xa8
function updatecapturebrush( player )
{
    if ( true )
    {
        return;
    }
    
    if ( !isdefined( self.neutralbrush ) )
    {
        return;
    }
    
    captureteam = scripts\mp\gameobjects::getclaimteam();
    var_8e879faf3052e0d2 = player.team;
    iscodcaster = player iscodcaster();
    
    if ( iscodcaster )
    {
        var_8e879faf3052e0d2 = player getcodcasterteam();
    }
    
    if ( istrue( self.stalemate ) )
    {
        hidecapturebrush( player );
        return;
    }
    
    if ( captureteam == "none" )
    {
        hidecapturebrush( player );
        return;
    }
    
    if ( var_8e879faf3052e0d2 == captureteam )
    {
        showfriendlycapturebrush( player );
        return;
    }
    
    showenemycapturebrush( player );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x83b8
// Size: 0x145
function showneutralbrush( player )
{
    foreach ( brush in self.friendlybrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.enemybrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.contestedbrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.neutralbrush )
    {
        brush showtoplayer( player );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x8505
// Size: 0x145
function showfriendlybrush( player )
{
    foreach ( brush in self.friendlybrush )
    {
        brush showtoplayer( player );
    }
    
    foreach ( brush in self.enemybrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.contestedbrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.neutralbrush )
    {
        brush hidefromplayer( player );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x8652
// Size: 0x145
function showenemybrush( player )
{
    foreach ( brush in self.friendlybrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.enemybrush )
    {
        brush showtoplayer( player );
    }
    
    foreach ( brush in self.contestedbrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.neutralbrush )
    {
        brush hidefromplayer( player );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x879f
// Size: 0x145
function showcontestedbrush( player )
{
    foreach ( brush in self.friendlybrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.enemybrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.contestedbrush )
    {
        brush showtoplayer( player );
    }
    
    foreach ( brush in self.neutralbrush )
    {
        brush hidefromplayer( player );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x88ec
// Size: 0x145
function hidebrushes( player )
{
    foreach ( brush in self.friendlybrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.enemybrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.contestedbrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.neutralbrush )
    {
        brush hidefromplayer( player );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x8a39
// Size: 0xa9
function showfriendlycapturebrush( player )
{
    foreach ( brush in self.friendlypulsebrush )
    {
        brush showtoplayer( player );
    }
    
    foreach ( brush in self.enemypulsebrush )
    {
        brush hidefromplayer( player );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x8aea
// Size: 0xa9
function showenemycapturebrush( player )
{
    foreach ( brush in self.friendlypulsebrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.enemypulsebrush )
    {
        brush showtoplayer( player );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x8b9b
// Size: 0xa9
function hidecapturebrush( player )
{
    foreach ( brush in self.friendlypulsebrush )
    {
        brush hidefromplayer( player );
    }
    
    foreach ( brush in self.enemypulsebrush )
    {
        brush hidefromplayer( player );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x8c4c
// Size: 0x2
function updatefloorbrushwaitforjoined()
{
    
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x8c56
// Size: 0x15
function applythermal()
{
    self visionsetthermalforplayer( "proto_apache_flir_mp" );
    self thermalvisionon();
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x8c73
// Size: 0x9
function removethermal()
{
    self thermalvisionoff();
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x8c84
// Size: 0x111
function startspectatorview()
{
    waitframe();
    updatesessionstate( "spectator" );
    scripts\mp\spectating::setdisabled();
    
    if ( isdefined( self.lastdeathangles ) )
    {
        self setplayerangles( self.lastdeathangles );
    }
    
    wait 0.1;
    setdof_default();
    var_25ac223966c5537 = level.spectatorcameras[ level.currentspectatorcamref ][ self.team ];
    var_dead2082432cecc = var_25ac223966c5537.origin;
    var_6788dc28320974a = var_25ac223966c5537.angles;
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

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x8d9d
// Size: 0x17
function dohalfwayflash()
{
    wait 0.4;
    thread playslamzoomflash();
    applythermal();
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x8dbc
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

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x8de3
// Size: 0x104
function updatespectatorcamera( var_ca2c833762e5466c )
{
    level.currentspectatorcamref = var_ca2c833762e5466c;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.spectatorcament ) )
        {
            team = player.team;
            forcedteam = getdvarint( @"hash_8bfd75900211e88b", -1 );
            
            if ( forcedteam != -1 )
            {
                team = ter_op( forcedteam == 0, "allies", "axis" );
            }
            
            cament = level.spectatorcameras[ level.currentspectatorcamref ][ team ];
            player.spectatorcament movecameratomappos( player, cament.origin, cament.angles );
        }
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 3
// Checksum 0x0, Offset: 0x8eef
// Size: 0x10b
function movecameratomappos( player, var_9813182985677b23, finalangles )
{
    player endon( "spawned_player" );
    movetime = 1;
    rotatetime = 1;
    self moveto( var_9813182985677b23, 1, 0.5, 0.5 );
    player playlocalsound( "mp_cmd_camera_zoom_out" );
    player setclienttriggeraudiozonepartialwithfade( "spawn_cam", 0.5, "mix" );
    self rotateto( finalangles, 1, 0.5, 0.5 );
    player thread startoperatorsound();
    wait 1.1;
    var_ae753108f3dff053 = anglestoforward( finalangles ) * 300;
    var_ae753108f3dff053 *= ( 1, 1, 0 );
    
    if ( isdefined( player ) && isdefined( player.spectatorcament ) )
    {
        self moveto( var_9813182985677b23 + var_ae753108f3dff053, 15, 1, 1 );
        player earthquakeforplayer( 0.03, 15, var_9813182985677b23 + var_ae753108f3dff053, 1000 );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x9002
// Size: 0x162
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
    self visionsetnakedforplayer( "", 0 );
    thread playslamzoomflash();
    updatesessionstate( "playing" );
    self cameraunlink();
    self.spectatorcament delete();
    wait 1;
    currenttime = gettime();
    
    if ( !isdefined( self.lastsitreptime ) || currenttime < self.lastsitreptime + 30000 || currenttime < level.lastteamstatustime[ self.team ] + 5000 )
    {
        return;
    }
    
    scripts\mp\utility\dialog::sitrepdialogonplayer( getsitreplocname() );
    thread playselfbattlechatter( self, "plrresponse_affirm", "cop_affirm_2d", 2.5, 1 );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x916c
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

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x924c
// Size: 0x17
function startoperatorsound()
{
    self endon( "game_ended" );
    self waittill( "spawned_player" );
    wait 0.5;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x926b
// Size: 0x63
function ongameended()
{
    level waittill( "game_ended" );
    
    foreach ( objective in level.objectives )
    {
        objective scripts\mp\gameobjects::setvisibleteam( "none" );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x92d6
// Size: 0xe9
function playendofmatchtransition( camerastruct )
{
    self setclientomnvar( "ui_total_fade", 0 );
    waitframe();
    totalframes = 10;
    framesleft = totalframes;
    
    for ( framesleft = 1; framesleft <= totalframes ; framesleft++ )
    {
        waitframe();
        self setclientomnvar( "ui_total_fade", framesleft / totalframes );
    }
    
    if ( isreallyalive( self ) && !isusingremote() && isdefined( camerastruct ) )
    {
        var_58f345c26a2e8be3 = distance2dsquared( self.origin, camerastruct.origin );
        
        if ( var_58f345c26a2e8be3 > 40000 )
        {
            body = self cloneplayer( 0 );
            body startragdoll( 1 );
        }
    }
    
    thread scripts\mp\playerlogic::spawnintermission( camerastruct, "spectator" );
    waitframe();
    totalframes = 4;
    framesleft = totalframes;
    
    for ( framesleft = totalframes - 1; framesleft >= 0 ; framesleft-- )
    {
        waitframe();
        self setclientomnvar( "ui_total_fade", framesleft / totalframes );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x93c7
// Size: 0x2e
function getsitreplocname()
{
    dialog = "sitrep_" + level.currentobjectiveindex + "_" + level.mapname;
    return dialog;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x93fe
// Size: 0x3f
function getcapturedialog( action )
{
    dialog = "cop_obj_" + level.currentobjectiveindex + "_" + action + "_" + level.mapname;
    return dialog;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x9446
// Size: 0x2c7
function getselfobjcaptureddialog( action )
{
    soundname = "";
    dialog = "";
    var_a7af333d56ee650a = 0;
    
    switch ( level.currentobjectiveindex )
    {
        case 0:
            if ( action == "planting" )
            {
                soundname = "arming_bomb";
                dialog = "cop_arming_bomb_2d";
                var_a7af333d56ee650a = 1;
            }
            else if ( action == "defusing" )
            {
                soundname = "bomb_defusing";
                dialog = "cop_bomb_defusing_2d";
                var_a7af333d56ee650a = 1;
            }
            
            break;
        case 1:
            if ( action == "capturing" )
            {
                dialog = "";
            }
            else if ( action == "captured" )
            {
                if ( self.team == "axis" )
                {
                    soundname = "objsecured_generic";
                    dialog = "cop_generic_captured_2d";
                }
                else if ( level.mapname == "mp_faridah" )
                {
                    soundname = "objsecured_school";
                    dialog = "cop_school_captured_2d";
                }
                else
                {
                    soundname = "objsecured_generic";
                    dialog = "cop_generic_captured_2d";
                }
            }
            
            break;
        case 2:
            if ( action == "capturing" )
            {
                dialog = "";
            }
            else if ( action == "captured" )
            {
                soundname = "objsecured_generic";
                dialog = "cop_generic_captured_2d";
            }
            
            break;
        case 3:
            if ( action == "capturing" )
            {
                dialog = "";
            }
            else if ( action == "captured" )
            {
                if ( level.mapname == "mp_faridah" )
                {
                    soundname = "objsecured_warehouse";
                    dialog = "cop_warehouse_captured_2d";
                }
                else
                {
                    soundname = "objsecured_generic";
                    dialog = "cop_generic_captured_2d";
                }
            }
            
            break;
        case 4:
            if ( action == "planting" )
            {
                soundname = "arming_bomb";
                dialog = "cop_arming_bomb_2d";
                var_a7af333d56ee650a = 1;
            }
            else if ( action == "defusing" )
            {
                soundname = "bomb_defusing";
                dialog = "cop_bomb_defusing_2d";
                var_a7af333d56ee650a = 1;
            }
            
            break;
    }
    
    soundlength = 0;
    
    if ( var_a7af333d56ee650a && !scripts\mp\battlechatter_mp::saidtoorecently( dialog ) )
    {
        scripts\mp\battlechatter_mp::updatechatter( dialog );
        thread playselfbattlechatter( self, soundname, dialog, 1.5 );
    }
    else if ( !var_a7af333d56ee650a )
    {
        thread playselfbattlechatter( self, soundname, dialog, 1.5 );
    }
    
    faction = ter_op( self.team == "allies", "usp1", "abp1" );
    
    if ( level.mapname == "mp_faridah" )
    {
        faction = ter_op( self.team == "allies", "usp1", "afp1" );
    }
    
    soundalias = "dx_mpp_" + faction + "_" + soundname;
    return lookupsoundlength( soundalias ) / 1000;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 5
// Checksum 0x0, Offset: 0x9716
// Size: 0xec
function playselfbattlechatter( player, soundname, dialog, waittime, hassuffix )
{
    if ( isai( self ) )
    {
        return;
    }
    
    level endon( "game_ended" );
    self endon( "death" );
    
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    faction = ter_op( self.team == "allies", "usp1", "abp1" );
    
    if ( level.mapname == "mp_faridah" )
    {
        faction = ter_op( player.team == "allies", "usp1", "afp1" );
    }
    
    soundalias = "dx_mpp_" + faction + "_" + soundname;
    
    if ( isdefined( hassuffix ) )
    {
        newalias = soundalias;
        
        if ( soundexists( newalias ) )
        {
            soundalias = newalias;
        }
    }
    
    player queuedialogforplayer( soundalias, dialog, 2 );
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 2
// Checksum 0x0, Offset: 0x980a
// Size: 0xc1
function getclosestplayeronteam( org, team )
{
    closestplayer = undefined;
    closestdist = undefined;
    
    foreach ( player in level.players )
    {
        if ( player.team == team && isreallyalive( player ) )
        {
            dist = distance2dsquared( player.origin, org );
            
            if ( !isdefined( closestdist ) || dist < closestdist )
            {
                closestplayer = player;
                closestdist = dist;
            }
        }
    }
    
    return closestplayer;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x98d4
// Size: 0x4e
function disableobjectiveongameended()
{
    level waittill( "game_ended" );
    
    if ( isdefined( level.currentobjective ) && isdefined( level.currentobjective.ondisableobjective ) )
    {
        level.currentobjective [[ level.currentobjective.ondisableobjective ]]();
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x992a
// Size: 0x53b
function setupcaptureflares()
{
    if ( getdvarint( @"hash_b7ee28d2bfbcd1ed", 0 ) != 1 )
    {
        return;
    }
    
    wait 2;
    embassy = [];
    embassy[ embassy.size ] = spawnflare( ( 350, -3580, -35 ), ( 0, -151, 0 ) );
    embassy[ embassy.size ] = spawnflare( ( 345, -3650, -35 ), ( 0, 140, 0 ) );
    embassy[ embassy.size ] = spawnflare( ( 235, -3655, -35 ), ( 0, 50, 0 ) );
    embassy[ embassy.size ] = spawnflare( ( 230, -3575, -35 ), ( 0, -40, 0 ) );
    level.objectives[ "0" ].scriptables = embassy;
    school = [];
    school[ school.size ] = spawnflare( ( -457, -2006, 204 ), ( 0, 331, 0 ), 0 );
    school[ school.size ] = spawnflare( ( -31, -1915, 192 ), ( 45, 48, 0 ), 0 );
    school[ school.size ] = spawnflare( ( -319, -1706, 209 ), ( 0, 130, 0 ), 0 );
    school[ school.size ] = spawnflare( ( -545, -1805, 207 ), ( 0, 130, 0 ), 0 );
    school[ school.size ] = spawnflare( ( -302, -2137, 152 ), ( 0, 234, 0 ) );
    level.objectives[ "1" ].scriptables = school;
    clocktower = [];
    clocktower[ clocktower.size ] = spawnflare( ( 420, -23, 17 ), ( 5, 208, 0 ) );
    clocktower[ clocktower.size ] = spawnflare( ( 458, 59, 109 ), ( 0, 342, 0 ), 0 );
    clocktower[ clocktower.size ] = spawnflare( ( 380, -267, 17 ), ( 0, 186, 0 ) );
    clocktower[ clocktower.size ] = spawnflare( ( 210, 126, 18 ), ( 5, 125, 0 ) );
    clocktower[ clocktower.size ] = spawnflare( ( 675, 118, 18 ), ( 0, 41, 0 ) );
    clocktower[ clocktower.size ] = spawnflare( ( 638, -180, 18 ), ( 5, 356, 0 ) );
    clocktower[ clocktower.size ] = spawnflare( ( 417, 105, 69 ), ( 75, 285, 0 ), 0 );
    clocktower[ clocktower.size ] = spawnflare( ( 426, -177, 17 ), ( 5, 73, 0 ), 0 );
    clocktower[ clocktower.size ] = spawnflare( ( 509, -116, 69 ), ( 55, 82, 0 ), 0 );
    clocktower[ clocktower.size ] = spawnflare( ( 331, 60, 63 ), ( 0, 309, 0 ), 0 );
    clocktower[ clocktower.size ] = spawnflare( ( 578, 65, 62 ), ( 40, 197, 0 ), 0 );
    level.objectives[ "2" ].scriptables = clocktower;
    warehouse = [];
    warehouse[ warehouse.size ] = spawnflare( ( 812, 2074, 222 ), ( 35, 326, 0 ), 0 );
    warehouse[ warehouse.size ] = spawnflare( ( 431, 1882, 241 ), ( 5, 86, 0 ), 0 );
    warehouse[ warehouse.size ] = spawnflare( ( 762, 2333, 226 ), ( 15, 345, 0 ), 0 );
    warehouse[ warehouse.size ] = spawnflare( ( 609, 1861, 223 ), ( 65, 339, 0 ), 0 );
    warehouse[ warehouse.size ] = spawnflare( ( 580, 2150, 212 ), ( 0, 272, 0 ), 0 );
    level.objectives[ "3" ].scriptables = warehouse;
    compound = [];
    compound[ compound.size ] = spawnflare( ( 1300, 3335, 12 ), ( 0, 40, 0 ) );
    compound[ compound.size ] = spawnflare( ( 1305, 3430, -2 ), ( 0, -47, 0 ) );
    compound[ compound.size ] = spawnflare( ( 1430, 3435, -3 ), ( 0, -135, 0 ) );
    compound[ compound.size ] = spawnflare( ( 1430, 3350, 3 ), ( 0, 140, 0 ) );
    level.objectives[ "4" ].scriptables = compound;
    
    if ( getdvarint( @"hash_424c014a94392d1", 0 ) == 1 )
    {
        thread debugcaptureflares();
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 3
// Checksum 0x0, Offset: 0x9e6d
// Size: 0x9a
function spawnflare( org, angles, drop )
{
    spawnpos = org;
    
    if ( !isdefined( drop ) )
    {
        drop = 1;
    }
    
    if ( drop )
    {
        spawnpos = drop_to_ground( org, 50, -200, ( 0, 0, 1 ) );
    }
    
    scriptable = spawn( "script_model", spawnpos + ( 0, 0, 2 ) );
    scriptable.angles = angles + ( 0, 180, 0 );
    scriptable setmodel( "cop_marker_scriptable" );
    return scriptable;
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0x9f10
// Size: 0x9a
function updateflares( state )
{
    if ( getdvarint( @"hash_b7ee28d2bfbcd1ed", 0 ) != 1 )
    {
        return;
    }
    
    self notify( "updateFlares" );
    self endon( "updateFlares" );
    
    while ( !isdefined( self.scriptables ) )
    {
        waitframe();
    }
    
    foreach ( scriptable in self.scriptables )
    {
        scriptable setscriptablepartstate( "marker", state );
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0x9fb2
// Size: 0x14e
function debugcaptureflares()
{
    currstate = 0;
    
    while ( true )
    {
        state = 0;
        
        switch ( currstate )
        {
            case 0:
                state = "allies";
                break;
            case 1:
                state = "axis";
                break;
            case 2:
                state = "contested";
                break;
            case 3:
                state = "idle";
                break;
        }
        
        foreach ( objective in level.objectives )
        {
            if ( !isdefined( objective.scriptables ) )
            {
                continue;
            }
            
            foreach ( scriptable in objective.scriptables )
            {
                scriptable setscriptablepartstate( "marker", state );
            }
        }
        
        currstate++;
        
        if ( currstate > 3 )
        {
            currstate = 0;
        }
        
        wait 3;
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0xa108
// Size: 0x1b8
function mapobjectiveicon( index )
{
    switch ( level.mapname )
    {
        case #"hash_ecbb96ade87e6efa":
            switch ( self.objectivekey )
            {
                case #"hash_311010bc01bd3a0f":
                    self.iconname = "_bombsite";
                    break;
                case #"hash_31100fbc01bd387c":
                    self.iconname = "_school";
                    break;
                case #"hash_311012bc01bd3d35":
                    self.iconname = "_clocktower";
                    break;
                case #"hash_311011bc01bd3ba2":
                    self.iconname = "_warehouse";
                    break;
                case #"hash_31100cbc01bd33c3":
                    self.iconname = "_bombsite";
                    break;
                default:
                    self.iconname = "";
                    break;
            }
            
            break;
        default:
            switch ( self.objectivekey )
            {
                case #"hash_311010bc01bd3a0f":
                    self.iconname = "_generic";
                    break;
                case #"hash_31100fbc01bd387c":
                    self.iconname = "_generic";
                    break;
                case #"hash_311012bc01bd3d35":
                    self.iconname = "_generic";
                    break;
                case #"hash_311011bc01bd3ba2":
                    self.iconname = "_generic";
                    break;
                case #"hash_31100cbc01bd33c3":
                    self.iconname = "_generic";
                    break;
                default:
                    self.iconname = "";
                    break;
            }
            
            break;
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0xa2c8
// Size: 0xf4
function updateoobtriggers()
{
    if ( !isdefined( level.currentobjective.oobtriggers ) )
    {
        return;
    }
    
    level notify( "updateOOBTriggers" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( level.currentobjective.oobtriggers[ "allies" ] ) )
        {
            level.currentobjective.oobtriggers[ "allies" ] thread updateoobvisuals( "axis" );
        }
        
        if ( isdefined( level.currentobjective.oobtriggers[ "axis" ] ) )
        {
            level.currentobjective.oobtriggers[ "axis" ] thread updateoobvisuals( "allies" );
        }
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 1
// Checksum 0x0, Offset: 0xa3c4
// Size: 0x11e
function updateoobvisuals( state )
{
    self notify( "updateOOBVisuals" );
    self endon( "updateOOBVisuals" );
    
    while ( !isdefined( self.visuals ) )
    {
        waitframe();
    }
    
    foreach ( visual in self.visuals )
    {
        for ( i = 0; i < visual.drawcount ; i++ )
        {
            visual setscriptablepartstate( "chevron_" + i, state );
        }
    }
    
    level waittill( "updateOOBTriggers" );
    
    foreach ( visual in self.visuals )
    {
        for ( i = 0; i < visual.drawcount ; i++ )
        {
            visual setscriptablepartstate( "chevron_" + i, "off" );
        }
    }
}

// Namespace cmd / scripts\mp\gametypes\cmd
// Params 0
// Checksum 0x0, Offset: 0xa4ea
// Size: 0x116
function awardcapturepoints()
{
    level endon( "game_ended" );
    level notify( "awardCapturePointsRunning" );
    level endon( "awardCapturePointsRunning" );
    seconds = 1;
    score = 1;
    
    while ( !level.gameended )
    {
        for ( waittime = 0; waittime < seconds ; waittime = 0 )
        {
            waitframe();
            scripts\mp\hostmigration::waittillhostmigrationdone();
            waittime += level.framedurationseconds;
            
            if ( self.stalemate )
            {
            }
        }
        
        team = self.claimteam;
        
        if ( team == "none" )
        {
            continue;
        }
        
        if ( !self.stalemate )
        {
            foreach ( object in self.touchlist[ team ] )
            {
                object.player thread doscoreevent( #"hash_b70d7c404342b807" );
            }
        }
    }
}

