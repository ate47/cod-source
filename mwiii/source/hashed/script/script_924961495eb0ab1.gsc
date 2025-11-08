#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\juggernaut;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;

#namespace warrior_miniguns;

// Namespace warrior_miniguns / namespace_97af351e5c3d498d
// Params 0
// Checksum 0x0, Offset: 0x11a
// Size: 0x4a
function function_d8ab130aa8874e6b()
{
    thread onplayerspawned();
    level.var_6298f362ec23d83.var_3a312a64852e713b = getdvarfloat( @"hash_4a9a810d95be6352" );
    setdvar( @"hash_e953bd34c5277146", 80 );
    thread function_492b4dec632917ec( "warrior_miniguns" );
}

// Namespace warrior_miniguns / namespace_97af351e5c3d498d
// Params 0
// Checksum 0x0, Offset: 0x16c
// Size: 0x50
function function_eb881ddfad8bc7eb()
{
    if ( level.var_6298f362ec23d83.var_3a312a64852e713b == 0 )
    {
        setdvar( @"hash_e953bd34c5277146", -1 );
        return;
    }
    
    setdvar( @"hash_e953bd34c5277146", level.var_6298f362ec23d83.var_3a312a64852e713b );
}

// Namespace warrior_miniguns / namespace_97af351e5c3d498d
// Params 0
// Checksum 0x0, Offset: 0x1c4
// Size: 0x59
function onplayerspawned()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        player scripts\mp\juggernaut::jugg_makejuggernaut( level.juggksglobals.config );
        player setspawnweapon( scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845( "iw9_minigunksjugg_mp" ) );
    }
}

