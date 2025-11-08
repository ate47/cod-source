#using script_18c2fb8b3f85c7cd;
#using script_2707474774db34b;
#using script_392e29d6a9a83091;
#using script_41387eecc35b88bf;
#using script_60b33963be93ae9d;
#using script_6617e2f2bb62b52b;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_util;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;

#namespace fr;

// Namespace fr / scripts\mp\gametypes\fr
// Params 0
// Checksum 0x0, Offset: 0x359
// Size: 0x1e9
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    allowed[ 0 ] = getgametype();
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
        registertimelimitdvar( getgametype(), 600 );
        registerscorelimitdvar( getgametype(), 75 );
        registerroundlimitdvar( getgametype(), 1 );
        registerwinlimitdvar( getgametype(), 1 );
        registernumlivesdvar( getgametype(), 0 );
        registerhalftimedvar( getgametype(), 0 );
    }
    
    updategametypedvars();
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    game[ "dialog" ][ "gametype" ] = "gametype_tdm";
    game[ "dialog" ][ "boost" ] = "boost_tdm";
    game[ "dialog" ][ "offense_obj" ] = "boost_tdm";
    game[ "dialog" ][ "defense_obj" ] = "boost_tdm";
    
    if ( matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
    
    /#
        level.reinitspawns = &reinitspawns;
    #/
    
    function_b2ab8303e71ffcf4();
    function_6154a7fa500ffdc6();
    function_d6a9e7094f78672e();
    namespace_236d5e32d01e927d::function_70b0f5c75f974eff();
    
    if ( getdvarint( @"hash_3a0783f0e1830d67", 0 ) )
    {
        namespace_3a7aeee21b004e1b::function_6f8c89f8f7dd3cc1();
        function_6a2fd0869da15e06( "test_0" );
    }
}

// Namespace fr / scripts\mp\gametypes\fr
// Params 0
// Checksum 0x0, Offset: 0x54a
// Size: 0x9
function function_d6a9e7094f78672e()
{
    function_89929df8c53338f7();
}

// Namespace fr / scripts\mp\gametypes\fr
// Params 0
// Checksum 0x0, Offset: 0x55b
// Size: 0x37
function initializematchrules()
{
    setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_6e7da31aae47b8e0", 0 );
    registerhalftimedvar( getgametype(), 0 );
    setdynamicdvar( @"hash_bb6e8f8d9be104f4", 0 );
}

// Namespace fr / scripts\mp\gametypes\fr
// Params 0
// Checksum 0x0, Offset: 0x59a
// Size: 0x136
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
        setobjectivetext( entry, &"OBJECTIVES/WAR" );
        
        if ( level.splitscreen )
        {
            setobjectivescoretext( entry, &"OBJECTIVES/WAR" );
        }
        else
        {
            setobjectivescoretext( entry, &"OBJECTIVES/WAR_SCORE" );
        }
        
        setobjectivehinttext( entry, &"OBJECTIVES/WAR_HINT" );
    }
    
    if ( isdefined( level.initspawnsoverridefunc ) )
    {
        [[ level.initspawnsoverridefunc ]]();
    }
    else
    {
        initspawns();
    }
    
    scripts\mp\gametypes\bradley_spawner::inittankspawns();
    
    if ( getdvarint( @"hash_3a0783f0e1830d67", 0 ) )
    {
        function_d1a0788290216f08( "test_0" );
    }
}

// Namespace fr / scripts\mp\gametypes\fr
// Params 0
// Checksum 0x0, Offset: 0x6d8
// Size: 0x9
function updategametypedvars()
{
    scripts\mp\gametypes\common::updatecommongametypedvars();
}

// Namespace fr / scripts\mp\gametypes\fr
// Params 0
// Checksum 0x0, Offset: 0x6e9
// Size: 0x1c0
function initspawns()
{
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2147483647, -2147483647, -2147483647 );
    
    if ( function_bff229a11ecd1e34() )
    {
        scripts\mp\spawnlogic::setactivespawnlogic( #"default" );
    }
    else if ( isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) )
    {
        scripts\mp\spawnlogic::setactivespawnlogic( "BigTDM", "Crit_Frontline" );
    }
    else
    {
        scripts\mp\spawnlogic::setactivespawnlogic( "Default", "Crit_Frontline" );
    }
    
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
    scripts\mp\spawnlogic::addspawnpoints( game[ "attackers" ], "mp_tdm_spawn_allies_start" );
    scripts\mp\spawnlogic::addspawnpoints( game[ "defenders" ], "mp_tdm_spawn_axis_start" );
    attackers = scripts\mp\spawnlogic::getspawnpointarray( "mp_tdm_spawn_allies_start" );
    defenders = scripts\mp\spawnlogic::getspawnpointarray( "mp_tdm_spawn_axis_start" );
    scripts\mp\spawnlogic::registerspawnset( "start_attackers", attackers );
    scripts\mp\spawnlogic::registerspawnset( "start_defenders", defenders );
    scripts\mp\spawnlogic::addspawnpoints( "allies", "mp_tdm_spawn" );
    scripts\mp\spawnlogic::addspawnpoints( "axis", "mp_tdm_spawn" );
    scripts\mp\spawnlogic::addspawnpoints( "allies", "mp_tdm_spawn_secondary", 1, 1 );
    scripts\mp\spawnlogic::addspawnpoints( "axis", "mp_tdm_spawn_secondary", 1, 1 );
    spawns = scripts\mp\spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
    spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray( "mp_tdm_spawn_secondary" );
    scripts\mp\spawnlogic::registerspawnset( "normal", spawns );
    scripts\mp\spawnlogic::registerspawnset( "fallback", spawnssecondary );
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
}

/#

    // Namespace fr / scripts\mp\gametypes\fr
    // Params 0
    // Checksum 0x0, Offset: 0x8b1
    // Size: 0x63, Type: dev
    function reinitspawns()
    {
        scripts\mp\spawnlogic::function_8390bf8c3b74466a( "<dev string:x1c>" );
        scripts\mp\spawnlogic::function_8390bf8c3b74466a( "<dev string:x26>" );
        spawns = scripts\mp\spawnlogic::getspawnpointarray( "<dev string:x32>" );
        spawnssecondary = scripts\mp\spawnlogic::getspawnpointarray( "<dev string:x42>" );
        scripts\mp\spawnlogic::registerspawnset( "<dev string:x1c>", spawns );
        scripts\mp\spawnlogic::registerspawnset( "<dev string:x26>", spawnssecondary );
    }

#/

// Namespace fr / scripts\mp\gametypes\fr
// Params 0
// Checksum 0x0, Offset: 0x91c
// Size: 0xaa
function getspawnpoint()
{
    spawnteam = self.pers[ "team" ];
    spawnpoint = undefined;
    
    if ( scripts\mp\spawnlogic::shoulduseteamstartspawn() )
    {
        if ( spawnteam == game[ "attackers" ] )
        {
            scripts\mp\spawnlogic::activatespawnset( "start_attackers", 1 );
            spawnpoint = scripts\mp\spawnlogic::getspawnpoint( self, spawnteam, undefined, "start_attackers" );
        }
        else
        {
            scripts\mp\spawnlogic::activatespawnset( "start_defenders", 1 );
            spawnpoint = scripts\mp\spawnlogic::getspawnpoint( self, spawnteam, undefined, "start_defenders" );
        }
    }
    else
    {
        scripts\mp\spawnlogic::activatespawnset( "normal", 1 );
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint( self, spawnteam, undefined, "fallback" );
        
        /#
            spawncompare( spawnpoint, spawnteam );
        #/
    }
    
    return spawnpoint;
}

// Namespace fr / scripts\mp\gametypes\fr
// Params 1
// Checksum 0x0, Offset: 0x9cf
// Size: 0x27
function onspawnplayer( revivespawn )
{
    if ( istrue( level.var_3cd921e8f55a730b ) )
    {
        function_cc6a3b6b4c6e5ed8();
    }
    
    function_1f99e5a11b5e285b( self );
}

/#

    // Namespace fr / scripts\mp\gametypes\fr
    // Params 2
    // Checksum 0x0, Offset: 0x9fe
    // Size: 0x17a, Type: dev
    function spawncompare( spawnpoint, spawnteam )
    {
        if ( getdvarint( @"hash_b5ceec3e3cb419be" ) != 0 )
        {
            spawnpoints = scripts\mp\spawnlogic::getteamspawnpoints( spawnteam );
            fallbackspawnpoints = [];
            scriptspawnpoint = scripts\mp\spawnscoring::getspawnpoint_legacy( spawnpoints, fallbackspawnpoints );
            
            if ( !isdefined( level.var_3d292942d52b104a ) )
            {
                level.var_3d292942d52b104a = 0;
                level.var_2dc7108159dc1da3 = 0;
                level.var_a065445ba781ddf6 = 0;
            }
            
            level.var_3d292942d52b104a++;
            println( "<dev string:x5c>" + scriptspawnpoint.index + "<dev string:x77>" + scriptspawnpoint.totalscore );
            
            if ( scriptspawnpoint.index == spawnpoint.index )
            {
                level.var_2dc7108159dc1da3++;
                iprintlnbold( "<dev string:x8d>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:xac>" + "<dev string:xba>" + level.var_2dc7108159dc1da3 + "<dev string:xbf>" + level.var_3d292942d52b104a );
            }
            else
            {
                level.var_a065445ba781ddf6++;
                iprintlnbold( "<dev string:xc4>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:xac>" + "<dev string:xba>" + level.var_2dc7108159dc1da3 + "<dev string:xbf>" + level.var_3d292942d52b104a );
            }
            
            return scriptspawnpoint;
        }
    }

#/

// Namespace fr / scripts\mp\gametypes\fr
// Params 6
// Checksum 0x0, Offset: 0xb80
// Size: 0x40
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    scripts\mp\gametypes\common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace fr / scripts\mp\gametypes\fr
// Params 0
// Checksum 0x0, Offset: 0xbc8
// Size: 0x53
function ontimelimit()
{
    winner = scripts\mp\gamescore::gethighestscoringteam();
    
    if ( game[ "status" ] == "overtime" )
    {
        winner = "forfeit";
    }
    else if ( "tie" )
    {
        winner = "overtime";
    }
    
    thread scripts\mp\gamelogic::endgame( winner, game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace fr / scripts\mp\gametypes\fr
// Params 10
// Checksum 0x0, Offset: 0xc23
// Size: 0x53
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    
}

// Namespace fr / scripts\mp\gametypes\fr
// Params 0
// Checksum 0x0, Offset: 0xc7e
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

