#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\flags;

#namespace dmz_ai;

// Namespace dmz_ai / scripts\mp\gametypes\dmz_ai
// Params 0
// Checksum 0x0, Offset: 0x1c8
// Size: 0x9a
function init()
{
    if ( getdvarfloat( @"hash_3545ca86ff96cb37", 0.34 ) != 0 )
    {
        scripts\engine\utility::registersharedfunc( "ai", "dropLootOnAgentDeath", &scripts\mp\ai_mp_controller::function_82ed67ae79913551 );
    }
    
    scripts\mp\ai_mp_controller::function_5aee5d819f7dfd1c();
    
    while ( !scripts\mp\flags::gameflagexists( "prematch_done" ) )
    {
        waitframe();
    }
    
    scripts\mp\flags::gameflagwait( "prematch_done" );
    setsaveddvar( @"hash_df03d7ac5b31599", 1 );
    function_e00cc8c1c5cc38fb( 1 );
    stealthenablelocalizedhunt( 1 );
    stealthsettocombatbyproxpingradius( 256 );
    stealthsettocombatfromhuntpingradius( 700 );
    level thread function_3c5c2e3402f0431e();
    level thread function_bbbd3531ab976b5e();
}

// Namespace dmz_ai / scripts\mp\gametypes\dmz_ai
// Params 0
// Checksum 0x0, Offset: 0x26a
// Size: 0x37
function function_3c5c2e3402f0431e()
{
    waittime = getdvarint( @"hash_ba0cc4a1f73de4c", 10 );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    scripts\mp\ai_mp_controller::function_35bae74232ff8b77( 0 );
    scripts\mp\ai_mp_controller::function_2b36368b8b1b2b30( 1 );
}

// Namespace dmz_ai / scripts\mp\gametypes\dmz_ai
// Params 0
// Checksum 0x0, Offset: 0x2a9
// Size: 0x2d
function function_bbbd3531ab976b5e()
{
    waittime = getdvarint( @"hash_e1b4b41af9d69b3b", 15 );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    scripts\mp\ai_mp_controller::function_3c44b8551d08ac1d();
}

// Namespace dmz_ai / scripts\mp\gametypes\dmz_ai
// Params 0
// Checksum 0x0, Offset: 0x2de
// Size: 0x9a
function function_428703950599c9e9()
{
    scripts\mp\ai_mp_controller::function_b1d1e7e3b23e0dfe( [ "mission", "perfTesting", "fortressGuards", "fortressPatrols", "reinforcements", "elites", "extraGuards", "extraPatrols", "firstKillFodder", "spawnPackage", "civilian", "vehiclePatrol", "bosses", "bossMinions", "convoy_attack", "huntSquad" ] );
}

