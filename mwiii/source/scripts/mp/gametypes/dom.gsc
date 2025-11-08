#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\koth;
#using scripts\mp\gametypes\mgl_mp;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\music_and_dialog;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnselection;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\print;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;

#namespace dom;

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0xed4
// Size: 0x4d6
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    level.var_62fd57cfce2e0cb8 = &function_25a2273df166bdaf;
    level.var_ef1b0e14902b92ae = &function_8340998294dc2140;
    level.usestrongholdhills = dvarintvalue( "useStrongholdHills", 0, 0, 1 );
    
    if ( level.usestrongholdhills )
    {
        allowed[ 0 ] = "hardpoint";
    }
    else if ( scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e() )
    {
        allowed = scripts\mp\gametypes\mgl_mp::function_4248416fffb4c5b3();
    }
    else
    {
        allowed[ 0 ] = getgametype();
    }
    
    if ( scripts\cp_mp\utility\game_utility::function_21322da268e71c19() || issubstr( getgametype(), "snipers" ) || isjuggermoshgamemode() )
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
        registertimelimitdvar( getgametype(), 0 );
        registerscorelimitdvar( getgametype(), 200 );
        registerroundlimitdvar( getgametype(), 2 );
        registerroundswitchdvar( getgametype(), 1, 0, 1 );
        registerwinlimitdvar( getgametype(), 0 );
        registernumlivesdvar( getgametype(), 0 );
        registerhalftimedvar( getgametype(), 0 );
    }
    
    updategametypedvars();
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.var_952bd6e10104d8a = &function_952bd6e10104d8a;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onplayerkilled = &onplayerkilled;
    level.modeonspawnplayer = &onspawnplayer;
    level.lastcaptime = gettime();
    level.onobjectivecomplete = &onflagcapture;
    level.onmaprestart = &function_6d0c070c982eddb4;
    
    if ( isdefined( level.numflagsscoreonkill ) && level.numflagsscoreonkill > 0 )
    {
        level.teamscoresonkill = [];
        level.onnormaldeath = &onnormaldeath;
        setdynamicdvar( hashcat( @"hash_39365bfde3c7d1c4" ), 1 );
    }
    
    level.domflag_setneutral = &scripts\mp\gametypes\obj_dom::domflag_setneutral;
    level.dompoint_setcaptured = &scripts\mp\gametypes\obj_dom::dompoint_setcaptured;
    level.onflagcapture = &onflagcapture;
    level.playholdtwovo = 0;
    
    if ( scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924() )
    {
        game[ "dialog" ][ "gametype" ] = "dx_mp_domi_game_uktl_dnt1";
    }
    else
    {
        game[ "dialog" ][ "gametype" ] = "dx_mp_domi_game_uktl_name";
    }
    
    game[ "dialog" ][ "offense_obj" ] = "dx_mp_domi_game_uktl_bost";
    game[ "dialog" ][ "defense_obj" ] = "dx_mp_domi_game_uktl_bost";
    game[ "dialog" ][ "securing_a" ] = "dx_mp_domi_game_uktl_dsca";
    game[ "dialog" ][ "securing_b" ] = "dx_mp_domi_game_uktl_dscb";
    game[ "dialog" ][ "securing_c" ] = "dx_mp_domi_game_uktl_dscc";
    game[ "dialog" ][ "securing_d" ] = "dx_mp_domi_game_uktl_dscd";
    game[ "dialog" ][ "securing_e" ] = "dx_mp_domi_game_uktl_dsce";
    game[ "dialog" ][ "secured_a" ] = "dx_mp_domi_game_uktl_dcpa";
    game[ "dialog" ][ "secured_b" ] = "dx_mp_domi_game_uktl_dcpb";
    game[ "dialog" ][ "secured_c" ] = "dx_mp_domi_game_uktl_dcpc";
    game[ "dialog" ][ "secured_d" ] = "dx_mp_domi_game_uktl_dcpd";
    game[ "dialog" ][ "secured_e" ] = "dx_mp_domi_game_uktl_dcpe";
    game[ "dialog" ][ "losing_a" ] = "dx_mp_domi_game_uktl_dlsa";
    game[ "dialog" ][ "losing_b" ] = "dx_mp_domi_game_uktl_dlsb";
    game[ "dialog" ][ "losing_c" ] = "dx_mp_domi_game_uktl_dlsc";
    game[ "dialog" ][ "losing_d" ] = "dx_mp_domi_game_uktl_dlsd";
    game[ "dialog" ][ "losing_e" ] = "dx_mp_domi_game_uktl_dlse";
    game[ "dialog" ][ "lost_a" ] = "dx_mp_domi_game_uktl_dloa";
    game[ "dialog" ][ "lost_b" ] = "dx_mp_domi_game_uktl_dlob";
    game[ "dialog" ][ "lost_c" ] = "dx_mp_domi_game_uktl_dloc";
    game[ "dialog" ][ "lost_d" ] = "dx_mp_domi_game_uktl_dlod";
    game[ "dialog" ][ "lost_e" ] = "dx_mp_domi_game_uktl_dloe";
    game[ "dialog" ][ "enemy_captured_2" ] = "dx_mp_domi_game_uktl_dec2";
    game[ "dialog" ][ "friendly_captured_2" ] = "dx_mp_domi_game_uktl_dfc2";
    game[ "dialog" ][ "gamestate_domlosing" ] = "dx_mp_domi_game_uktl_doml";
    game[ "dialog" ][ "gamestate_domwinning" ] = "dx_mp_domi_game_uktl_domw";
    game[ "dialog" ][ "friendly_scoring" ] = "iw9_mpgm_anno_uktl_hofs";
    game[ "dialog" ][ "enemy_scoring" ] = "iw9_mpgm_anno_uktl_hoes";
    function_2776ced2d74c6681();
    
    if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
    {
        scripts\mp\gametypes\mgl_mp::function_8c9c24a50231b1f9();
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x13b2
// Size: 0x25b
function function_2776ced2d74c6681()
{
    if ( !getdvarint( @"jup", 0 ) )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\game_utility::function_21322da268e71c19() )
    {
        game[ "dialog" ][ "gametype" ] = "dx_mp_domh_mode_t141_name";
    }
    else
    {
        game[ "dialog" ][ "gametype" ] = "dx_mp_domi_game_uktl_name";
    }
    
    game[ "dialog" ][ "offense_obj" ] = "dx_mp_domi_game_uktl_bost";
    game[ "dialog" ][ "defense_obj" ] = "dx_mp_domi_game_uktl_bost";
    game[ "dialog" ][ "securing_a" ] = "dx_mp_domi_game_uktl_dsca";
    game[ "dialog" ][ "securing_b" ] = "dx_mp_domi_game_uktl_dscb";
    game[ "dialog" ][ "securing_c" ] = "dx_mp_domi_game_uktl_dscc";
    game[ "dialog" ][ "securing_d" ] = "dx_mp_domi_game_uktl_dscd";
    game[ "dialog" ][ "securing_e" ] = "dx_mp_domi_game_uktl_dsce";
    game[ "dialog" ][ "secured_a" ] = "dx_mp_domi_game_uktl_dcpa";
    game[ "dialog" ][ "secured_b" ] = "dx_mp_domi_game_uktl_dcpb";
    game[ "dialog" ][ "secured_c" ] = "dx_mp_domi_game_uktl_dcpc";
    game[ "dialog" ][ "secured_d" ] = "dx_mp_domi_game_uktl_dcpd";
    game[ "dialog" ][ "secured_e" ] = "dx_mp_domi_game_uktl_dcpe";
    game[ "dialog" ][ "losing_a" ] = "dx_mp_domi_game_uktl_dlsa";
    game[ "dialog" ][ "losing_b" ] = "dx_mp_domi_game_uktl_dlsb";
    game[ "dialog" ][ "losing_c" ] = "dx_mp_domi_game_uktl_dlsc";
    game[ "dialog" ][ "losing_d" ] = "dx_mp_domi_game_uktl_dlsd";
    game[ "dialog" ][ "losing_e" ] = "dx_mp_domi_game_uktl_dlse";
    game[ "dialog" ][ "lost_a" ] = "dx_mp_domi_game_uktl_dloa";
    game[ "dialog" ][ "lost_b" ] = "dx_mp_domi_game_uktl_dlob";
    game[ "dialog" ][ "lost_c" ] = "dx_mp_domi_game_uktl_dloc";
    game[ "dialog" ][ "lost_d" ] = "dx_mp_domi_game_uktl_dlod";
    game[ "dialog" ][ "lost_e" ] = "dx_mp_domi_game_uktl_dloe";
    game[ "dialog" ][ "enemy_captured_2" ] = "dx_mp_domi_game_uktl_dec2";
    game[ "dialog" ][ "friendly_captured_2" ] = "dx_mp_domi_game_uktl_dfc2";
    game[ "dialog" ][ "gamestate_domlosing" ] = "dx_mp_domi_game_uktl_doml";
    game[ "dialog" ][ "gamestate_domwinning" ] = "dx_mp_domi_game_uktl_domw";
    game[ "dialog" ][ "friendly_scoring" ] = "dx_mp_gmst_anno_t141_gswc_01";
    game[ "dialog" ][ "enemy_scoring" ] = "dx_mp_gmst_anno_t141_gslc";
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x1615
// Size: 0x286
function initializematchrules()
{
    setcommonrulesfrommatchrulesdata();
    setdynamicdvar( function_3514ae5d09f47ed2( "flagCaptureTime" ), getmatchrulesdata( "domData", "flagCaptureTime" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "flagDecayTime" ), getmatchrulesdata( "domData", "flagDecayTime" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "flagModelHidden" ), getmatchrulesdata( "domData", "flagModelHidden" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "flagNeutralization" ), getmatchrulesdata( "domData", "flagNeutralization" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "flagReinforcement" ), getmatchrulesdata( "domData", "flagReinforcement" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "flagsRequiredToScore" ), getmatchrulesdata( "domData", "flagsRequiredToScore" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "numFlagsScoreOnKill" ), getmatchrulesdata( "domData", "numFlagsScoreOnKill" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "objScalar" ), getmatchrulesdata( "domData", "objScalar" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "pointsPerFlag" ), getmatchrulesdata( "domData", "pointsPerFlag" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "pointsPerReinforcedFlag" ), getmatchrulesdata( "domData", "pointsPerReinforcedFlag" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "reinforcementStompScalar" ), getmatchrulesdata( "domData", "reinforcementStompScalar" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "shuffleHillRoundCount" ), getmatchrulesdata( "domData", "shuffleHillRoundCount" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "strongholdScoreAllCapIncrement" ), getmatchrulesdata( "domData", "strongholdScoreAllCapIncrement" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "strongholdScoreIncrement" ), getmatchrulesdata( "domData", "strongholdScoreIncrement" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "strongholdScoreInterval" ), getmatchrulesdata( "domData", "strongholdScoreInterval" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "useStrongholdScoring" ), getmatchrulesdata( "domData", "useStrongholdScoring" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "preCapPoints" ), getmatchrulesdata( "siegeData", "preCapPoints" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "captureType" ), getmatchrulesdata( "captureData", "captureType" ) );
    setdynamicdvar( function_3514ae5d09f47ed2( "captureDecay" ), getmatchrulesdata( "captureData", "captureDecay" ) );
    setdynamicdvar( @"hash_cde4a2a016eecbae", 0 );
    registerhalftimedvar( "dom", 0 );
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x18a3
// Size: 0x80
function seticonnames()
{
    level.iconneutral = "waypoint_captureneutral";
    level.iconcapture = "waypoint_capture";
    level.icondefend = "waypoint_defend";
    level.icondefending = "waypoint_defending";
    level.iconcontested = "waypoint_contested";
    level.icontaking = "waypoint_taking";
    level.iconlosing = "waypoint_losing";
    level.iconclearing = "waypoint_clearing";
    level.var_a58e0495b821276 = "waypoint_reinforcing";
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x192b
// Size: 0x1ab
function onstartgametype()
{
    seticonnames();
    
    foreach ( entry in level.teamnamelist )
    {
        if ( isdefined( level.teamscoresonkill ) )
        {
            level.teamscoresonkill[ entry ] = level.precappoints >= level.numflagsscoreonkill && level.precappoints >= level.flagsrequiredtoscore;
        }
        
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
    
    if ( level.scoremod[ "kill" ] > 0 )
    {
        game[ "dialog" ][ "offense_obj" ] = "boost_groundwar";
        game[ "dialog" ][ "defense_obj" ] = "boost_groundwar";
    }
    
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
    
    initspawns();
    thread domflags();
    thread updatedomscores();
    
    /#
        thread function_95b0959344794f91();
        thread removedompoint();
        thread placedompoint();
    #/
    
    scripts\mp\gametypes\bradley_spawner::inittankspawns();
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1ade
// Size: 0x27
function private function_952bd6e10104d8a()
{
    if ( level.scoremod[ "kill" ] > 0 )
    {
        setdvar( @"hash_cf1c084c7a6622f9", 1 );
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x1b0d
// Size: 0x1e5
function updategametypedvars()
{
    updatecommongametypedvars();
    level.flagcapturetime = dvarfloatvalue( "flagCaptureTime", 10, 0, 30 );
    level.flagdecaytime = dvarfloatvalue( "flagDecayTime", 0, 0, 30 );
    level.flagmodelhidden = dvarintvalue( "flagModelHidden", 0, 0, 1 );
    level.flagneutralization = dvarintvalue( "flagNeutralization", 0, 0, 1 );
    level.flagreinforcement = dvarintvalue( "flagReinforcement", 0, 0, 1 );
    level.flagsrequiredtoscore = dvarintvalue( "flagsRequiredToScore", 1, 1, 3 );
    level.numflagsscoreonkill = dvarintvalue( "numFlagsScoreOnKill", 0, 0, 3 );
    level.objectivescaler = dvarfloatvalue( "objScalar", 4, 1, 10 );
    level.pointsperflag = dvarintvalue( "pointsPerFlag", 1, 1, 300 );
    level.pointsperreinforcedflag = dvarintvalue( "pointsPerReinforcedFlag", 0, 0, 300 );
    level.reinforcementstompscalar = dvarfloatvalue( "reinforcementStompScalar", 1, 1, 10 );
    level.shufflehillroundcount = dvarintvalue( "shuffleHillRoundCount", 2, 0, 10 );
    level.strongholdscoreallcapincrement = dvarintvalue( "strongholdScoreAllCapIncrement", 2, 2, 10 );
    level.strongholdscoreincrement = dvarintvalue( "strongholdScoreIncrement", 1, 1, 5 );
    level.strongholdscoreinterval = dvarfloatvalue( "strongholdScoreInterval", 1, 1, 10 );
    level.usestrongholdscoring = dvarintvalue( "useStrongholdScoring", 0, 0, 1 );
    level.precappoints = dvarintvalue( "preCapPoints", 0, 0, 1 );
    level.capturetype = dvarintvalue( "captureType", 1, 0, 3 );
    level.capturedecay = dvarintvalue( "captureDecay", 1, 0, 1 );
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x1cfa
// Size: 0x264
function initspawns()
{
    if ( function_bff229a11ecd1e34() )
    {
        scripts\mp\spawnlogic::setactivespawnlogic( #"default" );
    }
    else if ( isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) )
    {
        spawnlogic::setactivespawnlogic( "BigTDM", "Crit_Default" );
    }
    else
    {
        spawnlogic::setactivespawnlogic( "Domination", "Crit_Default" );
    }
    
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2147483647, -2147483647, -2147483647 );
    spawnkey = "dom";
    
    if ( spawnlogic::function_b17bf43316b9fb08( spawnkey ) )
    {
        spawnlogic::function_afe4709b818e7c9e( spawnkey );
    }
    else
    {
        spawnlogic::addstartspawnpoints( "mp_dom_spawn_allies_start" );
        spawnlogic::addstartspawnpoints( "mp_dom_spawn_axis_start" );
        spawnlogic::addspawnpoints( game[ "attackers" ], "mp_dom_spawn_allies_start" );
        spawnlogic::addspawnpoints( game[ "defenders" ], "mp_dom_spawn_axis_start" );
        attackers = spawnlogic::getspawnpointarray( "mp_dom_spawn_allies_start" );
        defenders = spawnlogic::getspawnpointarray( "mp_dom_spawn_axis_start" );
        spawnlogic::registerspawnset( "start_attackers", attackers );
        spawnlogic::registerspawnset( "start_defenders", defenders );
        spawnlogic::addspawnpoints( "allies", "mp_dom_spawn" );
        spawnlogic::addspawnpoints( "axis", "mp_dom_spawn" );
        spawnlogic::addspawnpoints( "allies", "mp_dom_spawn_secondary", 1, 1 );
        spawnlogic::addspawnpoints( "axis", "mp_dom_spawn_secondary", 1, 1 );
        spawns = spawnlogic::getspawnpointarray( "mp_dom_spawn" );
        spawnssecondary = spawnlogic::getspawnpointarray( "mp_dom_spawn_secondary" );
        spawnlogic::registerspawnset( "primary", spawns );
        spawnlogic::registerspawnset( "fallback", spawnssecondary );
        spawnlogic::function_48ed29b53fd72775();
    }
    
    if ( scripts\mp\spawnselection::function_167619fe3d0cff00() )
    {
        level.gamemodestartspawnpointnames = [];
        level.gamemodestartspawnpointnames[ game[ "attackers" ] ] = "mp_dom_spawn_allies_start";
        level.gamemodestartspawnpointnames[ game[ "defenders" ] ] = "mp_dom_spawn_axis_start";
        level.gamemodespawnpointnames = [];
        level.gamemodespawnpointnames[ game[ "attackers" ] ] = "mp_dom_spawn";
        level.gamemodespawnpointnames[ game[ "defenders" ] ] = "mp_dom_spawn";
    }
    
    level.mapcenter = spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x1f66
// Size: 0x8c
function getspawnpoint()
{
    spawnteam = self.pers[ "team" ];
    teamdompoints = getteamdompoints( spawnteam );
    enemyteam = getotherteam( spawnteam )[ 0 ];
    var_db44ac0d1491f876 = getteamdompoints( enemyteam );
    flaggroups = getpreferreddompoints( teamdompoints, var_db44ac0d1491f876, spawnteam, enemyteam );
    var_ba0a9fd614a3f6ee = spawnfactor::function_5647d0dca50a2d4d( flaggroups[ "preferred" ], flaggroups[ "secondary" ] );
    return spawnlogic::getspawnpointforplayer( self, var_ba0a9fd614a3f6ee );
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x1ffb
// Size: 0x79
function getteamdompoints( team )
{
    teamdompoints = [];
    
    foreach ( dompoint in level.objectives )
    {
        if ( dompoint.ownerteam == team )
        {
            teamdompoints[ teamdompoints.size ] = dompoint;
        }
    }
    
    return teamdompoints;
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 4
// Checksum 0x0, Offset: 0x207d
// Size: 0x224
function getpreferreddompoints( teamdompoints, var_db44ac0d1491f876, team, enemyteam )
{
    var_eca8ba29df25a989 = [];
    
    if ( teamdompoints.size == level.objectives.size )
    {
        enemyspawnflag = level.bestspawnflag[ enemyteam ];
        
        foreach ( flag in teamdompoints )
        {
            if ( flag != enemyspawnflag )
            {
                var_eca8ba29df25a989[ var_eca8ba29df25a989.size ] = flag;
            }
        }
    }
    else if ( teamdompoints.size > 0 )
    {
        foreach ( flag in teamdompoints )
        {
            var_eca8ba29df25a989[ var_eca8ba29df25a989.size ] = flag;
        }
    }
    else if ( teamdompoints.size == 0 )
    {
        var_e4b0a18c08e01fc9 = level.bestspawnflag[ team ];
        
        if ( var_db44ac0d1491f876.size > 0 && var_db44ac0d1491f876.size < level.objectives.size )
        {
            var_e4b0a18c08e01fc9 = scripts\mp\gametypes\obj_dom::getunownedflagneareststart( team );
        }
        
        var_eca8ba29df25a989[ var_eca8ba29df25a989.size ] = var_e4b0a18c08e01fc9;
    }
    
    preferreddompoints = 0;
    secondarydompoints = 0;
    
    foreach ( flag in var_eca8ba29df25a989 )
    {
        if ( flag scripts\mp\gameobjects::getclaimteam() == "none" )
        {
            preferreddompoints |= flag.spawnflagid;
            continue;
        }
        
        secondarydompoints |= flag.spawnflagid;
    }
    
    if ( preferreddompoints & 1 && preferreddompoints & 2 )
    {
        preferreddompoints |= 32;
    }
    
    if ( preferreddompoints & 4 && preferreddompoints & 2 )
    {
        preferreddompoints |= 64;
    }
    
    if ( preferreddompoints & 1 && preferreddompoints & 4 )
    {
        preferreddompoints |= 128;
    }
    
    flaggroups = [];
    flaggroups[ "preferred" ] = preferreddompoints;
    flaggroups[ "secondary" ] = secondarydompoints;
    return flaggroups;
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x22aa
// Size: 0x88e
function domflags()
{
    primaryflags = [];
    secondaryflags = [];
    level.changenumdomflags = 0;
    
    if ( level.usestrongholdhills )
    {
        allflags = scripts\mp\gametypes\koth::getzonearray( "hardpoint_zone" );
        
        if ( !isdefined( game[ "strongholdFlagKeys" ] ) || level.shufflehillroundcount > 0 && game[ "roundsPlayed" ] % level.shufflehillroundcount == 0 )
        {
            tempflags = allflags;
            
            if ( isdefined( game[ "strongholdFlagKeys" ] ) )
            {
                removecount = randomintrange( 0, tempflags.size - game[ "strongholdFlagKeys" ].size );
                
                while ( removecount > 0 )
                {
                    randomflag = game[ "strongholdFlagKeys" ][ randomint( game[ "strongholdFlagKeys" ].size ) ];
                    game[ "strongholdFlagKeys" ] = array_remove( game[ "strongholdFlagKeys" ], randomflag );
                    
                    foreach ( hill in tempflags )
                    {
                        if ( hill.script_label == randomflag )
                        {
                            tempflags = array_remove( tempflags, hill );
                            removecount--;
                            break;
                        }
                    }
                }
            }
            
            var_2a267ac444be003e = [];
            allyhills = scripts\engine\utility::get_array_of_closest( scripts\mp\spawncamera::getstartspawnavg( "allies", "mp_dom_spawn_allies_start" ), tempflags, undefined, 2 );
            randomflag = allyhills[ randomint( allyhills.size ) ];
            tempflags = array_remove( tempflags, randomflag );
            var_2a267ac444be003e[ 0 ] = randomflag.script_label;
            axishills = scripts\engine\utility::get_array_of_closest( scripts\mp\spawncamera::getstartspawnavg( "axis", "mp_dom_spawn_axis_start" ), tempflags, undefined, 2 );
            randomflag = axishills[ randomint( axishills.size ) ];
            tempflags = array_remove( tempflags, randomflag );
            var_2a267ac444be003e[ 2 ] = randomflag.script_label;
            randomflag = tempflags[ randomint( tempflags.size ) ];
            tempflags = array_remove( tempflags, randomflag );
            var_2a267ac444be003e[ 1 ] = randomflag.script_label;
            game[ "strongholdFlagKeys" ] = var_2a267ac444be003e;
        }
        
        flagnames = [ "_a", "_b", "_c", "_d", "_e" ];
        flagindex = 0;
        selectedflags = [];
        
        for ( i = 0; i < game[ "strongholdFlagKeys" ].size ; i++ )
        {
            hillkey = game[ "strongholdFlagKeys" ][ i ];
            
            foreach ( zone in allflags )
            {
                if ( hillkey != zone.script_label )
                {
                    continue;
                }
                
                key = flagnames[ flagindex ];
                zone.script_label = key;
                zone.objectivekey = key;
                selectedflags[ selectedflags.size ] = zone;
                flagindex++;
                break;
            }
        }
        
        primaryflags = selectedflags;
        level.changenumdomflags = getdvarint( @"hash_f9faada5b0dcc0d3", 3 );
    }
    else
    {
        if ( isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) )
        {
            var_85e038319fbafcf9 = getentarray( "flag_primary", "targetname" );
            
            foreach ( flag in var_85e038319fbafcf9 )
            {
                if ( isdefined( flag.script_noteworthy ) && flag.script_noteworthy == level.localeid )
                {
                    primaryflags[ primaryflags.size ] = flag;
                    continue;
                }
                
                flag delete();
            }
        }
        else
        {
            level.changenumdomflags = getdvarint( @"hash_f9faada5b0dcc0d3", 0 );
            primaryflags = getentarray( "flag_primary", "targetname" );
        }
        
        secondaryflags = getentarray( "flag_secondary", "targetname" );
    }
    
    if ( primaryflags.size + secondaryflags.size < 2 )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    if ( level.changenumdomflags == 3 )
    {
        setomnvar( "ui_num_dom_flags", level.changenumdomflags );
    }
    else
    {
        setomnvar( "ui_num_dom_flags", primaryflags.size );
    }
    
    triggers = array_combine( primaryflags, secondaryflags );
    
    if ( level.changenumdomflags == 3 || level.mapname == "mp_rust" )
    {
        foreach ( trigger in triggers )
        {
            trigger remapdomtriggerscriptlabel();
        }
    }
    
    foreach ( trigger in triggers )
    {
        if ( !level.usestrongholdhills && level.changenumdomflags == 3 )
        {
            if ( trigger.script_label == "_d" || trigger.script_label == "_e" )
            {
                continue;
            }
        }
        
        modifytriggerlocation( trigger );
        domflag = scripts\mp\gametypes\obj_dom::setupobjective( trigger, undefined, 1, 1 );
        domflag thread function_57034c991fb8630b( trigger.target, trigger.script_label );
        level.objectives[ domflag.objectivekey ] = domflag;
    }
    
    spawn_axis_start = spawnlogic::getspawnpointarray( "mp_dom_spawn_axis_start" );
    spawn_allies_start = spawnlogic::getspawnpointarray( "mp_dom_spawn_allies_start" );
    level.startpos[ "allies" ] = spawn_allies_start[ 0 ].origin;
    level.startpos[ "axis" ] = spawn_axis_start[ 0 ].origin;
    level.bestspawnflag = [];
    level.bestspawnflag[ "allies" ] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart( "allies", undefined );
    level.bestspawnflag[ "axis" ] = scripts\mp\gametypes\obj_dom::getunownedflagneareststart( "axis", level.bestspawnflag[ "allies" ] );
    flagsetup();
    thread modifieddefendradiussetup();
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        level waittill_any_2( "prematch_done", "start_mode_setup" );
    }
    
    if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
    {
        iconsize = "icon_medium";
    }
    else
    {
        iconsize = undefined;
    }
    
    foreach ( flag in level.objectives )
    {
        reservedobjid = scripts\mp\gametypes\obj_dom::getreservedobjid( flag.objectivekey );
        flag scripts\mp\gameobjects::requestid( 1, 1, reservedobjid, undefined, undefined, iconsize );
        flag.onuse = &dompoint_onuse;
        flag.onbeginuse = &dom_onbeginuse;
        flag.onuseupdate = &scripts\mp\gametypes\obj_dom::dompoint_onuseupdate;
        flag.onenduse = &dom_onenduse;
        flag.oncontested = &dom_oncontested;
        flag.onuncontested = &dom_onuncontested;
        flag.onunoccupied = &dom_onunoccupied;
        flag.oncleared = &scripts\mp\gametypes\obj_dom::function_3dc46df97466e4d3;
        flag.ondecayed = &scripts\mp\gametypes\obj_dom::function_3dc46df97466e4d3;
        flag.onpinnedstate = &function_f2d95c239bf680ac;
        flag.onunpinnedstate = &function_10b7087fecf03775;
        flag.stompprogressreward = &scripts\mp\gametypes\obj_dom::dompoint_stompprogressreward;
        flag scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_target" );
        flag scripts\mp\gameobjects::setvisibleteam( "any" );
        flag scripts\mp\gametypes\obj_dom::domflag_setneutral();
    }
    
    if ( level.precappoints )
    {
        thread scripts\mp\gametypes\obj_dom::precap();
    }
    
    if ( level.codcasterenabled )
    {
        thread updatetriggerforcodcaster();
    }
    
    if ( isdefined( level.var_60744cb47838daf6 ) )
    {
        function_45da6d50b025370a();
    }
    
    /#
        thread domdebug();
    #/
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 2
// Checksum 0x0, Offset: 0x2b40
// Size: 0xb5
function function_57034c991fb8630b( target, label )
{
    wait 1;
    othervisuals = getentitylessscriptablearray( target, "targetname" );
    chevrons = [];
    
    foreach ( visual in othervisuals )
    {
        index = chevrons.size;
        chevrons[ index ] = visual;
        chevrons[ index ].numchevrons = 1;
    }
    
    self.chevrons = chevrons;
    function_726259d42f88361( "idle" );
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x2bfd
// Size: 0xb2
function function_726259d42f88361( state )
{
    self notify( "updateChevrons" );
    self endon( "updateChevrons" );
    
    while ( !isdefined( self.chevrons ) )
    {
        waitframe();
    }
    
    var_a27485475186b39d = "chevron_";
    
    foreach ( chevron in self.chevrons )
    {
        for ( i = 0; i < chevron.numchevrons ; i++ )
        {
            chevron setscriptablepartstate( var_a27485475186b39d + i, state );
        }
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x2cb7
// Size: 0xee
function function_223fb185e0afb231()
{
    if ( game[ "switchedsides" ] )
    {
        if ( self.ownerteam == game[ "attackers" ] )
        {
            thread function_726259d42f88361( "axis" );
        }
        else if ( self.ownerteam == game[ "defenders" ] )
        {
            thread function_726259d42f88361( "allies" );
        }
    }
    else if ( self.ownerteam == game[ "attackers" ] )
    {
        thread function_726259d42f88361( "allies" );
    }
    else if ( self.ownerteam == game[ "defenders" ] )
    {
        thread function_726259d42f88361( "axis" );
    }
    else if ( self.isunoccupied )
    {
        thread function_726259d42f88361( "idle" );
    }
    
    if ( self.stalemate )
    {
        thread function_726259d42f88361( "contested" );
        return;
    }
    
    if ( !self.isunoccupied )
    {
        thread function_726259d42f88361( self.mostnumtouchingteam );
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x2dad
// Size: 0x1a
function dom_onbeginuse( player )
{
    scripts\mp\gametypes\obj_dom::dompoint_onusebegin( player );
    function_223fb185e0afb231();
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 3
// Checksum 0x0, Offset: 0x2dcf
// Size: 0x46
function dom_onenduse( team, player, success )
{
    scripts\mp\gametypes\obj_dom::dompoint_onuseend( team, player, success );
    
    if ( success )
    {
        thread function_726259d42f88361( player.team );
        return;
    }
    
    function_223fb185e0afb231();
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x2e1d
// Size: 0x10
function dom_oncontested()
{
    scripts\mp\gametypes\obj_dom::dompoint_oncontested();
    function_223fb185e0afb231();
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x2e35
// Size: 0x24
function dom_onuncontested( lastclaimteam )
{
    scripts\mp\gametypes\obj_dom::dompoint_onuncontested( lastclaimteam );
    delaythread( 0.05, &function_223fb185e0afb231 );
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x2e61
// Size: 0x10
function dom_onunoccupied()
{
    scripts\mp\gametypes\obj_dom::dompoint_onunoccupied();
    function_223fb185e0afb231();
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x2e79
// Size: 0x1a
function function_f2d95c239bf680ac( player )
{
    scripts\mp\gametypes\obj_dom::dompoint_onpinnedstate( player );
    function_223fb185e0afb231();
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x2e9b
// Size: 0x1a
function function_10b7087fecf03775( player )
{
    scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate( player );
    function_223fb185e0afb231();
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x2ebd
// Size: 0xb6
function modifytriggerlocation( trigger )
{
    switch ( level.mapname )
    {
        case #"hash_d8bbcfc499e70e6f":
            switch ( trigger.script_label )
            {
                case #"hash_fac2c5f6bddd49bd":
                    trigger.origin = ( 983, 303, 110 );
                    break;
                case #"hash_fac2c2f6bddd4504":
                    trigger.origin = ( -1064, -525, 110 );
                    break;
                case #"hash_fac2c3f6bddd4697":
                    trigger.origin = ( -1605, -2298, 60 );
                    break;
            }
            
            break;
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x2f7b
// Size: 0xf4
function remapdomtriggerscriptlabel()
{
    if ( level.mapname == "mp_aniyah" || level.mapname == "mp_aniyah_pm" )
    {
        if ( self.script_label == "_e" && !isdefined( self.remappedscriptlabel ) )
        {
            self.script_label = "_c";
            self.remappedscriptlabel = 1;
        }
        else if ( self.script_label == "_c" && !isdefined( self.remappedscriptlabel ) )
        {
            self.script_label = "_e";
            self.remappedscriptlabel = 1;
        }
        
        return;
    }
    
    if ( level.mapname == "mp_rust" )
    {
        if ( self.script_label == "_a" )
        {
            self.script_label = "_b";
            return;
        }
        
        if ( self.script_label == "_b" )
        {
            self.script_label = "_a";
        }
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x3077
// Size: 0x348
function updatedomscores()
{
    level endon( "game_ended" );
    teamscore = undefined;
    otherteamscore = undefined;
    level waittill( "prematch_done" );
    
    if ( !isdefined( level.scoretick ) )
    {
        level.scoretick = [];
    }
    
    while ( !level.gameended )
    {
        waittime = 5;
        
        if ( level.usestrongholdscoring )
        {
            waittime = level.strongholdscoreinterval;
        }
        
        timeleft = scripts\mp\gamelogic::gettimeremaining();
        
        if ( timeleft < 5000 && timeleft > 0 )
        {
            waittime = timeleft / 1000;
        }
        
        wait waittime;
        scripts\mp\hostmigration::waittillhostmigrationdone();
        domflags = getowneddomflags();
        
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
            
            if ( level.usestrongholdscoring )
            {
                foreach ( team in level.teamnamelist )
                {
                    var_fee716687dd29378 = scripts\mp\gametypes\obj_dom::getteamflagcount( team, level.usestrongholdscoring );
                    
                    if ( var_fee716687dd29378 == level.objectives.size )
                    {
                        level.scoretick[ team ] = level.strongholdscoreallcapincrement;
                        continue;
                    }
                    
                    if ( var_fee716687dd29378 >= level.flagsrequiredtoscore )
                    {
                        level.scoretick[ team ] = level.strongholdscoreincrement;
                    }
                }
            }
            else
            {
                foreach ( domflag in domflags )
                {
                    team = domflag scripts\mp\gameobjects::getownerteam();
                    assert( isgameplayteam( team ) );
                    teamscore = getteamscore( team );
                    var_fee716687dd29378 = scripts\mp\gametypes\obj_dom::getteamflagcount( team );
                    
                    if ( var_fee716687dd29378 >= level.flagsrequiredtoscore )
                    {
                        level.scoretick[ team ] += level.pointsperflag;
                        
                        if ( istrue( domflag.reinforced ) && isdefined( level.pointsperreinforcedflag ) )
                        {
                            level.scoretick[ team ] += level.pointsperreinforcedflag;
                        }
                    }
                }
            }
        }
        
        updatescores();
        checkendgame( domflags.size );
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x33c7
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

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x3529
// Size: 0x11f
function checkendgame( var_bedc18e1c7da5fbf )
{
    timesincelastcap = gettime() - level.lastcaptime;
    
    if ( matchmakinggame() && var_bedc18e1c7da5fbf < 2 && timesincelastcap > 120000 )
    {
        level.forcedend = 1;
        thread scripts\mp\gamelogic::endgame( "none", game[ "end_reason" ][ "dom_force_end" ] );
        return;
    }
    
    if ( level.objectives.size == 3 && level.playholdtwovo && timesincelastcap > 30000 )
    {
        foreach ( entry in level.teamnamelist )
        {
            if ( scripts\mp\gametypes\obj_dom::getteamflagcount( entry ) == 2 )
            {
                otherteam = getotherteam( entry )[ 0 ];
                scripts\mp\utility\dialog::statusdialog( "enemy_captured_2", otherteam );
                scripts\mp\utility\dialog::statusdialog( "friendly_captured_2", entry );
                level.playholdtwovo = 0;
                break;
            }
        }
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 10
// Checksum 0x0, Offset: 0x3650
// Size: 0xa8
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    if ( !isplayer( attacker ) || attacker.team == self.team )
    {
        return;
    }
    
    if ( isdefined( objweapon ) && scripts\cp_mp\weapon::iskillstreakweapon( objweapon.basename ) )
    {
        return;
    }
    
    scripts\mp\gametypes\obj_dom::awardgenericmedals( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 6
// Checksum 0x0, Offset: 0x3700
// Size: 0x59
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    if ( istrue( level.teamscoresonkill[ attacker.team ] ) )
    {
        oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x3761
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

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x37ea
// Size: 0x8
function getflagteam()
{
    return scripts\mp\gameobjects::getownerteam();
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x37fb
// Size: 0xf4
function flagsetup()
{
    /#
        setdevdvarifuninitialized( @"scr_domdebug", "<dev string:x80>" );
    #/
    
    foreach ( domflag in level.objectives )
    {
        domflag.spawnflagid = getflagspawnidforobjectivekey( domflag.objectivekey );
    }
    
    spawnpoints = level.spawnpoints;
    
    foreach ( spawnpoint in spawnpoints )
    {
        spawnpoint.scriptdata.domflagassignments = getspawnpointflagassignment( spawnpoint );
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x38f7
// Size: 0x60
function getflagspawnidforobjectivekey( objectivekey )
{
    switch ( objectivekey )
    {
        case #"hash_fac2c5f6bddd49bd":
            return 1;
        case #"hash_fac2c2f6bddd4504":
            return 2;
        case #"hash_fac2c3f6bddd4697":
            return 4;
        case #"hash_fac2c0f6bddd41de":
            return 8;
        case #"hash_fac2c1f6bddd4371":
            return 16;
    }
    
    return undefined;
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x3960
// Size: 0xdb
function getspawnpointflagassignment( spawnpoint )
{
    if ( scripts\cp_mp\utility\game_utility::isarenamap() )
    {
        if ( spawnpoint.script_noteworthy == "1" || spawnpoint.script_noteworthy == "2" || spawnpoint.script_noteworthy == "3" )
        {
            spawnpoint.script_noteworthy = "";
        }
    }
    
    if ( isdefined( spawnpoint.script_noteworthy ) && spawnpoint.script_noteworthy != "" )
    {
        if ( !isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) )
        {
            flagassignment = parseflagassignmentstring( spawnpoint.script_noteworthy );
            
            if ( isdefined( flagassignment ) )
            {
                return flagassignment;
            }
        }
    }
    
    nearestdompoint = findnearestdompoint( spawnpoint.origin );
    return nearestdompoint.spawnflagid;
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x3a44
// Size: 0xdd
function parseflagassignmentstring( stringvalue )
{
    stringvalue = tolower( stringvalue );
    
    switch ( stringvalue )
    {
        case #"hash_31103fbc01bd840c":
            return 1;
        case #"hash_311042bc01bd88c5":
            return 2;
        case #"hash_311041bc01bd8732":
            return 4;
        case #"hash_31103cbc01bd7f53":
            return 8;
        case #"hash_31103bbc01bd7dc0":
            return 16;
        case #"hash_fa18c2f6bd57792a":
        case #"hash_fa21b1f6bd5e1a2c":
            return 32;
        case #"hash_fa1ecaf6bd5c02f0":
        case #"hash_fa21b3f6bd5e1d52":
            return 64;
        case #"hash_fa18c3f6bd577abd":
        case #"hash_fa1ecdf6bd5c07a9":
            return 128;
        default:
            assertmsg( "<dev string:x85>" + stringvalue + "<dev string:xba>" );
            break;
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x3b29
// Size: 0x1bf
function findnearestdompoint( pos )
{
    navmeshpoints = [];
    
    foreach ( dompoint in level.objectives )
    {
        dompoint.navmeshpos = getclosestpointonnavmesh( dompoint.trigger.origin );
        navmeshpoints[ navmeshpoints.size ] = dompoint.navmeshpos;
    }
    
    var_2a1e7872f714f838 = findclosestpointbyapproxpathdist( navmeshpoints, getclosestpointonnavmesh( pos ) );
    nearestdompoint = undefined;
    
    if ( !isdefined( var_2a1e7872f714f838 ) )
    {
        nearestdist = undefined;
        
        foreach ( dompoint in level.objectives )
        {
            dist = distancesquared( dompoint.trigger.origin, pos );
            
            if ( !isdefined( nearestdompoint ) || dist < nearestdist )
            {
                nearestdompoint = dompoint;
                nearestdist = dist;
            }
        }
    }
    else
    {
        foreach ( dompoint in level.objectives )
        {
            if ( distance2dsquared( dompoint.navmeshpos, var_2a1e7872f714f838 ) < 1 )
            {
                nearestdompoint = dompoint;
                break;
            }
        }
        
        assert( isdefined( nearestdompoint ) );
    }
    
    return nearestdompoint;
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x3cf1
// Size: 0x8c
function modifieddefendradiussetup()
{
    if ( level.mapname == "mp_frontier" )
    {
        foreach ( objective in level.objectives )
        {
            if ( objective.objectivekey == "_b" )
            {
                objective.trigger.modifieddefendcheck = 1;
            }
        }
    }
}

/#

    // Namespace dom / scripts\mp\gametypes\dom
    // Params 0
    // Checksum 0x0, Offset: 0x3d85
    // Size: 0x61f, Type: dev
    function domdebug()
    {
        spawnpoints = spawnlogic::getteamspawnpoints( "<dev string:xff>" );
        fallbacks = spawnlogic::getteamfallbackspawnpoints( "<dev string:xff>" );
        spawnpoints = array_combine( spawnpoints, fallbacks );
        ispathdataavailable = spawnlogic::ispathdataavailable();
        heightoffsetlines = ( 0, 0, 12 );
        heightoffsetnames = ( 0, 0, 64 );
        colors = [];
        colors[ 1 ] = ( 1, 0, 0 );
        colors[ 2 ] = ( 0, 1, 0 );
        colors[ 4 ] = ( 0, 0, 1 );
        colors[ 8 ] = ( 1, 1, 1 );
        colors[ 16 ] = ( 0, 0, 0 );
        colors[ 32 ] = ( 1, 1, 0 );
        colors[ 64 ] = ( 0, 1, 1 );
        colors[ 128 ] = ( 1, 0, 1 );
        
        while ( true )
        {
            if ( getdvar( @"scr_domdebug" ) != "<dev string:x107>" )
            {
                wait 1;
                continue;
            }
            
            setdevdvar( @"scr_showspawns", "<dev string:x107>" );
            
            while ( true )
            {
                if ( getdvar( @"scr_domdebug" ) != "<dev string:x107>" )
                {
                    setdevdvar( @"scr_showspawns", "<dev string:x80>" );
                    break;
                }
                
                if ( !isdefined( level.players[ 0 ] ) )
                {
                    waitframe();
                    continue;
                }
                
                endpoints = [];
                endpoints[ 1 ] = [ level.objectives[ "<dev string:x10c>" ] ];
                endpoints[ 2 ] = [ level.objectives[ "<dev string:x112>" ] ];
                endpoints[ 4 ] = [ level.objectives[ "<dev string:x118>" ] ];
                endpoints[ 8 ] = [ level.objectives[ "<dev string:x11e>" ] ];
                endpoints[ 16 ] = [ level.objectives[ "<dev string:x124>" ] ];
                endpoints[ 32 ] = [ level.objectives[ "<dev string:x10c>" ], level.objectives[ "<dev string:x112>" ] ];
                endpoints[ 64 ] = [ level.objectives[ "<dev string:x118>" ], level.objectives[ "<dev string:x112>" ] ];
                endpoints[ 128 ] = [ level.objectives[ "<dev string:x10c>" ], level.objectives[ "<dev string:x118>" ] ];
                
                foreach ( spawnpoint in spawnpoints )
                {
                    spawnpointdata = spawnpoint.scriptdata;
                    
                    if ( !isdefined( spawnpointdata.domflagassignments ) )
                    {
                        continue;
                    }
                    
                    if ( !isdefined( spawnpointdata.var_601117ef603f46a3 ) )
                    {
                        spawnpointdata.var_601117ef603f46a3 = [];
                    }
                    
                    if ( ispathdataavailable )
                    {
                        foreach ( endpoint in endpoints[ spawnpoint.scriptdata.domflagassignments ] )
                        {
                            if ( !isdefined( spawnpointdata.var_601117ef603f46a3[ endpoint.spawnflagid ] ) )
                            {
                                spawnpointdata.var_601117ef603f46a3[ endpoint.spawnflagid ] = level.players[ 0 ] findpath( spawnpoint.origin, endpoint.curorigin );
                            }
                            
                            if ( !isdefined( spawnpointdata.var_601117ef603f46a3[ endpoint.spawnflagid ] ) || spawnpointdata.var_601117ef603f46a3[ endpoint.spawnflagid ].size == 0 )
                            {
                                continue;
                            }
                            
                            color = colors[ spawnpoint.scriptdata.domflagassignments ];
                            line( spawnpoint.origin + heightoffsetlines, spawnpointdata.var_601117ef603f46a3[ endpoint.spawnflagid ][ 0 ] + heightoffsetlines, color );
                            
                            for ( i = 0; i < spawnpointdata.var_601117ef603f46a3[ endpoint.spawnflagid ].size - 1 ; i++ )
                            {
                                line( spawnpointdata.var_601117ef603f46a3[ endpoint.spawnflagid ][ i ] + heightoffsetlines, spawnpointdata.var_601117ef603f46a3[ endpoint.spawnflagid ][ i + 1 ] + heightoffsetlines, color );
                            }
                        }
                        
                        continue;
                    }
                    
                    foreach ( endpoint in endpoints[ spawnpoint.scriptdata.domflagassignments ] )
                    {
                        line( endpoint.curorigin + heightoffsetlines, spawnpoint.origin + heightoffsetlines, ( 0.2, 0.2, 0.6 ) );
                    }
                }
                
                foreach ( flaglocation in level.objectives )
                {
                    if ( flaglocation == level.bestspawnflag[ "<dev string:x12a>" ] )
                    {
                        print3d( flaglocation.trigger.origin + heightoffsetnames, "<dev string:x134>" );
                    }
                    
                    if ( flaglocation == level.bestspawnflag[ "<dev string:xff>" ] )
                    {
                        print3d( flaglocation.trigger.origin + heightoffsetnames, "<dev string:x14e>" );
                    }
                }
                
                waitframe();
            }
        }
    }

#/

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x43ac
// Size: 0x24
function onspawnplayer( revivespawn )
{
    thread updatematchstatushintonspawn();
    
    if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
    {
        thread scripts\mp\gametypes\mgl_mp::function_f9ae07213a0af3de();
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x43d8
// Size: 0x53
function updatecpm()
{
    if ( !isdefined( self.cpm ) )
    {
        self.numcaps = 0;
        self.cpm = 0;
    }
    
    self.numcaps++;
    
    if ( getminutespassed() < 1 )
    {
        return;
    }
    
    self.cpm = self.numcaps / getminutespassed();
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x4433
// Size: 0x1d
function getcapxpscale()
{
    if ( self.cpm < 4 )
    {
        return 1;
    }
    
    return 0.25;
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x4458
// Size: 0x2c
function onplayerconnect( player )
{
    if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
    {
        player thread scripts\mp\gametypes\mgl_mp::function_8bb13aa2a5d32576( player, "mp_gametype_domination_match_introduction" );
    }
    
    player thread onplayerspawned();
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x448c
// Size: 0x84
function onplayerspawned( player )
{
    self endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "spawned" );
        setextrascore0( 0 );
        
        if ( isdefined( self.pers[ "captures" ] ) )
        {
            setextrascore0( self.pers[ "captures" ] );
        }
        
        setextrascore1( 0 );
        
        if ( isdefined( self.pers[ "defends" ] ) )
        {
            setextrascore1( self.pers[ "defends" ] );
        }
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 6
// Checksum 0x0, Offset: 0x4518
// Size: 0x1b9
function onflagcapture( objectivetype, label, credit_player, team, oldteam, flagobj )
{
    level.usestartspawns = 0;
    assert( team != "<dev string:x166>" );
    otherteam = getotherteam( team )[ 0 ];
    
    if ( scripts\mp\gametypes\obj_dom::getteamflagcount( team ) == level.objectives.size )
    {
        scripts\mp\utility\sound::playsoundonplayers( "mp_dom_flag_captured_all", team );
        scripts\mp\utility\sound::playsoundonplayers( "mp_dom_flag_lost_all", otherteam );
    }
    else
    {
        scripts\mp\utility\sound::playsoundonplayers( "mp_dom_flag_captured", team );
        scripts\mp\utility\sound::playsoundonplayers( "mp_dom_flag_lost", otherteam );
    }
    
    credit_player scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648( 15, 1 );
    
    if ( scripts\mp\gametypes\obj_dom::getteamflagcount( team ) < level.objectives.size )
    {
        scripts\mp\utility\dialog::statusdialog( "secured" + self.objectivekey, team );
        
        if ( isdefined( oldteam ) && oldteam == "neutral" )
        {
            if ( isdefined( level.objectives ) && level.objectives.size == 5 && ( self.objectivekey == "_c" || self.objectivekey == "_d" ) || self.objectivekey == "_b" )
            {
                scripts\mp\utility\dialog::statusdialog( "lost" + self.objectivekey, otherteam );
            }
        }
        else
        {
            scripts\mp\utility\dialog::statusdialog( "lost" + self.objectivekey, otherteam );
        }
    }
    else
    {
        thread scripts\mp\music_and_dialog::dominating_music( team );
        scripts\mp\utility\dialog::statusdialog( "gamestate_domwinning", team );
        scripts\mp\utility\dialog::statusdialog( "gamestate_domlosing", otherteam );
    }
    
    if ( istrue( level.var_d0d511ba6517842a ) )
    {
        function_d0d511ba6517842a( team );
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x46d9
// Size: 0xae
function dompoint_onuse( credit_player )
{
    scripts\mp\gametypes\obj_dom::dompoint_onuse( credit_player, credit_player.team );
    
    if ( isdefined( level.teamscoresonkill ) )
    {
        foreach ( team in level.teamnamelist )
        {
            var_fee716687dd29378 = scripts\mp\gametypes\obj_dom::getteamflagcount( team );
            level.teamscoresonkill[ team ] = var_fee716687dd29378 >= level.numflagsscoreonkill && var_fee716687dd29378 >= level.flagsrequiredtoscore;
        }
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x478f
// Size: 0x9
function function_6d0c070c982eddb4()
{
    scripts\mp\codcasterclientmatchdata::function_edba1ee7c2375a5();
}

/#

    // Namespace dom / scripts\mp\gametypes\dom
    // Params 0
    // Checksum 0x0, Offset: 0x47a0
    // Size: 0xa6, Type: dev
    function function_95b0959344794f91()
    {
        self endon( "<dev string:x171>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_46a6b424af6acbc2" ) != 0 )
            {
                scripts\mp\gamescore::giveteamscoreforobjective( "<dev string:x12a>", getdvarint( @"hash_46a6b424af6acbc2" ), 1 );
                break;
            }
            else if ( getdvarint( @"hash_86e14326e43c0115" ) != 0 )
            {
                scripts\mp\gamescore::giveteamscoreforobjective( "<dev string:xff>", getdvarint( @"hash_86e14326e43c0115" ), 1 );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"hash_46a6b424af6acbc2", 0 );
        setdevdvar( @"hash_86e14326e43c0115", 0 );
        thread function_95b0959344794f91();
    }

    // Namespace dom / scripts\mp\gametypes\dom
    // Params 0
    // Checksum 0x0, Offset: 0x484e
    // Size: 0x190, Type: dev
    function removedompoint()
    {
        self endon( "<dev string:x171>" );
        
        while ( true )
        {
            if ( getdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x17f>" ) != "<dev string:x17f>" )
            {
                flaglabel = getdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x17f>" );
                
                foreach ( domflag in level.objectives )
                {
                    if ( isdefined( domflag.objectivekey ) && domflag.objectivekey == flaglabel )
                    {
                        domflag scripts\mp\gameobjects::allowuse( "<dev string:x183>" );
                        domflag.trigger = undefined;
                        domflag notify( "<dev string:x18b>" );
                        domflag.visibleteam = "<dev string:x183>";
                        domflag scripts\mp\gameobjects::setobjectivestatusicons( undefined );
                        tempflags = [];
                        
                        foreach ( objective in level.objectives )
                        {
                            if ( objective.objectivekey != flaglabel )
                            {
                                tempflags[ objective.objectivekey ] = objective;
                            }
                        }
                        
                        level.objectives = tempflags;
                        break;
                    }
                }
                
                setdynamicdvar( @"hash_6ce167f2cdc8ef7c", "<dev string:x17f>" );
            }
            
            wait 1;
        }
    }

    // Namespace dom / scripts\mp\gametypes\dom
    // Params 0
    // Checksum 0x0, Offset: 0x49e6
    // Size: 0x47f, Type: dev
    function placedompoint()
    {
        self endon( "<dev string:x171>" );
        
        while ( true )
        {
            if ( getdvar( @"hash_29d45d6822a1cf6d", "<dev string:x17f>" ) != "<dev string:x17f>" )
            {
                flaglabel = getdvar( @"hash_29d45d6822a1cf6d", "<dev string:x17f>" );
                zone = spawnstruct();
                zone.origin = level.players[ 0 ].origin;
                zone.angles = level.players[ 0 ].angles;
                trigger = spawn( "<dev string:x196>", zone.origin, 0, 120, 128 );
                zone.trigger = trigger;
                zone.trigger.script_label = flaglabel;
                zone.ownerteam = "<dev string:x166>";
                tracestart = zone.origin + ( 0, 0, 32 );
                traceend = zone.origin + ( 0, 0, -32 );
                trace = scripts\engine\trace::ray_trace( tracestart, traceend, undefined, scripts\engine\trace::create_default_contents( 1 ) );
                zone.origin = trace[ "<dev string:x1a8>" ];
                zone.upangles = vectortoangles( trace[ "<dev string:x1b4>" ] );
                zone.forward = anglestoforward( zone.upangles );
                zone.right = anglestoright( zone.upangles );
                zone.visuals[ 0 ] = spawn( "<dev string:x1be>", zone.origin );
                zone.visuals[ 0 ].angles = zone.angles;
                domflag = scripts\mp\gameobjects::createuseobject( "<dev string:x166>", zone.trigger, zone.visuals, ( 0, 0, 100 ) );
                domflag scripts\mp\gameobjects::allowuse( "<dev string:x1ce>" );
                domflag scripts\mp\gameobjects::setusetime( 10 );
                
                if ( isdefined( trigger.objectivekey ) )
                {
                    domflag.objectivekey = trigger.objectivekey;
                }
                else
                {
                    domflag.objectivekey = domflag scripts\mp\gameobjects::getlabel();
                }
                
                if ( isdefined( trigger.iconname ) )
                {
                    domflag.iconname = trigger.iconname;
                }
                else
                {
                    domflag.iconname = domflag scripts\mp\gameobjects::getlabel();
                }
                
                domflag scripts\mp\gameobjects::setobjectivestatusicons( level.icondefend, level.iconneutral );
                domflag scripts\mp\gameobjects::setvisibleteam( "<dev string:x1d7>" );
                domflag.onuse = &dompoint_onuse;
                domflag.onbeginuse = &scripts\mp\gametypes\obj_dom::dompoint_onusebegin;
                domflag.onuseupdate = &scripts\mp\gametypes\obj_dom::dompoint_onuseupdate;
                domflag.onenduse = &scripts\mp\gametypes\obj_dom::dompoint_onuseend;
                domflag.nousebar = 1;
                domflag.id = "<dev string:x1de>";
                domflag.firstcapture = 1;
                domflag.claimgracetime = 10000;
                domflag.decayrate = 50;
                tracestart = zone.visuals[ 0 ].origin + ( 0, 0, 32 );
                traceend = zone.visuals[ 0 ].origin + ( 0, 0, -32 );
                contentoverride = scripts\engine\trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
                ignoreents = [];
                trace = scripts\engine\trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
                domflag.baseeffectpos = trace[ "<dev string:x1a8>" ];
                upangles = vectortoangles( trace[ "<dev string:x1b4>" ] );
                domflag.baseeffectforward = anglestoforward( upangles );
                domflag scripts\mp\gametypes\obj_dom::initializematchrecording();
                domflag thread scripts\mp\gametypes\obj_dom::domflag_setneutral();
                level.objectives[ domflag.objectivekey ] = domflag;
                setdynamicdvar( @"hash_29d45d6822a1cf6d", "<dev string:x17f>" );
            }
            
            wait 1;
        }
    }

#/

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x4e6d
// Size: 0x15
function updatematchstatushintonspawn()
{
    level endon( "game_ended" );
    scripts\mp\hud_message::function_f004ef4606b9efdc( "dom_cap_defend" );
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x4e8a
// Size: 0x14b
function updatetriggerforcodcaster()
{
    level endon( "game_ended" );
    level waittill( "prematch_done" );
    
    while ( !level.gameended )
    {
        foreach ( player in level.players )
        {
            mlgpoint = 0;
            
            foreach ( dompoint in level.objectives )
            {
                if ( player istouching( dompoint.trigger ) && isalive( player ) )
                {
                    mlgpoint = scripts\mp\gametypes\obj_dom::getreservedobjid( dompoint.objectivekey ) + 1;
                    break;
                }
            }
            
            if ( !isdefined( player.mlgpoint ) || player.mlgpoint != mlgpoint )
            {
                player setmlgdominationpoint( mlgpoint );
                player.mlgpoint = mlgpoint;
                player setgametypevip( 1 );
            }
            
            if ( mlgpoint == 0 )
            {
                player setgametypevip( 0 );
            }
        }
        
        waitframe();
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x4fdd
// Size: 0x2b5
function function_d0d511ba6517842a( team )
{
    var_b5b1784d5a1327c7 = team + "_agents";
    totalspawned = function_9368fb9261e4cd0a( var_b5b1784d5a1327c7 );
    var_644d90de7685f75 = level.var_72e8a99508b7be1b - totalspawned;
    
    if ( var_644d90de7685f75 <= 0 )
    {
        return;
    }
    
    numagents = getdvarint( @"hash_3ac57a7fbbfe5cf8", 1 );
    
    if ( numagents > 0 )
    {
        for ( i = 0; i < numagents ; i++ )
        {
            type = function_6d1e55c48e2c12f();
            aitype = function_d5bc07eabf352abb();
            agent = ai_mp_requestspawnagent( aitype, self.trigger.origin + function_8271f5b7ac2c25da( i ), ( 0, 0, 0 ), "medium", var_b5b1784d5a1327c7, "domAgents", var_b5b1784d5a1327c7, team );
            
            if ( isdefined( agent ) )
            {
                agent thread function_35c195df2ba46725( agent, team );
                agent thread function_a5117518725da028( agent, self.trigger.origin );
                
                if ( team == "allies" )
                {
                    agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff( "body_mp_eastern_geist_1_1_lod1", "head_mp_eastern_bale_1_1" );
                    continue;
                }
                
                agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff( "body_spetsnaz_cqc", "head_spetsnaz_cqc" );
            }
        }
    }
    
    if ( getdvarint( @"hash_b50a927a2e0e0a5d", 1 ) == 1 )
    {
        if ( self.objectivekey == "_b" )
        {
            var_40e875a042b82875 = getdvarint( @"hash_2c76d4f86fd341de", 1 );
            
            if ( var_40e875a042b82875 > 0 )
            {
                for ( i = 0; i < var_40e875a042b82875 ; i++ )
                {
                    agent = ai_mp_requestspawnagent( "enemy_mp_jugg_base", self.trigger.origin, ( 0, 0, 0 ), "absolute", var_b5b1784d5a1327c7, "jugg", var_b5b1784d5a1327c7, team );
                    
                    if ( isdefined( agent ) )
                    {
                        agent thread function_35c195df2ba46725( agent, team );
                        scripts\cp_mp\agents\agent_utils::function_1828f1e20e52b418( agent );
                        agent thread function_a5117518725da028( agent, self.trigger.origin );
                    }
                }
            }
        }
        
        return;
    }
    
    var_40e875a042b82875 = getdvarint( @"hash_2c76d4f86fd341de", 0 );
    
    if ( var_40e875a042b82875 > 0 )
    {
        for ( i = 0; i < var_40e875a042b82875 ; i++ )
        {
            agent = ai_mp_requestspawnagent( "enemy_mp_jugg_base", self.trigger.origin, ( 0, 0, 0 ), "absolute", var_b5b1784d5a1327c7, "jugg", var_b5b1784d5a1327c7, team );
            
            if ( isdefined( agent ) )
            {
                agent thread function_35c195df2ba46725( agent, team );
                scripts\cp_mp\agents\agent_utils::function_1828f1e20e52b418( agent );
                agent thread function_a5117518725da028( agent, self.trigger.origin );
            }
        }
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x529a
// Size: 0x85
function function_8271f5b7ac2c25da( spawnindex )
{
    offset = ( 0, 0, 0 );
    
    if ( spawnindex == 0 )
    {
        offset = ( 32, 0, 0 );
    }
    else if ( spawnindex == 1 )
    {
        offset = ( 0, 32, 0 );
    }
    else if ( spawnindex == 2 )
    {
        offset = ( 32, 32, 0 );
    }
    else if ( spawnindex == 3 )
    {
        offset = ( -32, 0, 0 );
    }
    
    return offset;
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x5328
// Size: 0xab
function function_45963b4546563e1( pos )
{
    objective = undefined;
    best_dist = 9000000;
    
    foreach ( flag in level.objectives )
    {
        dist = scripts\engine\utility::distance_2d_squared( pos, flag.trigger.origin );
        
        if ( dist < best_dist || !isdefined( objective ) )
        {
            best_dist = dist;
            objective = flag;
        }
    }
    
    return objective;
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 1
// Checksum 0x0, Offset: 0x53dc
// Size: 0x80
function function_5e500ed9ad3f9b69( objective )
{
    if ( isdefined( objective ) )
    {
        if ( !isdefined( objective.var_5df9e749c7e29b85 ) )
        {
            objective.var_5df9e749c7e29b85 = [];
        }
        
        objective.var_5df9e749c7e29b85 = array_add( objective.var_5df9e749c7e29b85, self.handle );
        self.team = objective.ownerteam;
        function_850bb49d5142a56f( self.handle, objective.ownerteam );
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x5464
// Size: 0x47
function function_25a2273df166bdaf()
{
    if ( isdefined( level.objectives ) && self.type == 1 )
    {
        objective = function_45963b4546563e1( self.pos );
        
        if ( isdefined( objective ) )
        {
            function_5e500ed9ad3f9b69( objective );
        }
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x54b3
// Size: 0xbe
function function_45da6d50b025370a()
{
    foreach ( objective in level.objectives )
    {
        objective.var_5df9e749c7e29b85 = [];
    }
    
    foreach ( anchor in level.var_60744cb47838daf6 )
    {
        if ( anchor.type == 1 )
        {
            anchor function_25a2273df166bdaf();
        }
    }
}

// Namespace dom / scripts\mp\gametypes\dom
// Params 0
// Checksum 0x0, Offset: 0x5579
// Size: 0x6b
function function_8340998294dc2140()
{
    if ( isdefined( self.var_5df9e749c7e29b85 ) )
    {
        foreach ( var_4151eae053b0c0bd in self.var_5df9e749c7e29b85 )
        {
            function_850bb49d5142a56f( var_4151eae053b0c0bd, self.ownerteam );
        }
    }
}

