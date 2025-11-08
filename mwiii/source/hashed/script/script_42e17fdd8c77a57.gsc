#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;

#namespace warrior_dontshoot;

// Namespace warrior_dontshoot / namespace_9763669b9aad9111
// Params 0
// Checksum 0x0, Offset: 0x127
// Size: 0x17
function function_3c1a6c0c2ccb4869()
{
    thread onplayerspawned();
    thread function_492b4dec632917ec( "warrior_dontshoot" );
}

// Namespace warrior_dontshoot / namespace_9763669b9aad9111
// Params 0
// Checksum 0x0, Offset: 0x146
// Size: 0x61
function onplayerspawned()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        player takeallweapons();
        pistolweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845( "jup_jp14_pi_rsierra12_mp" );
        player giveweapon( pistolweapon );
        player setspawnweapon( pistolweapon );
        player thread function_724cc0f31814881c();
    }
}

// Namespace warrior_dontshoot / namespace_9763669b9aad9111
// Params 0
// Checksum 0x0, Offset: 0x1af
// Size: 0x1f
function function_724cc0f31814881c()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    self waittill( "weapon_fired" );
    self kill();
}

