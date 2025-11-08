#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\teams;

#namespace warrior_dronewars;

// Namespace warrior_dronewars / namespace_4ade0a16752c1aea
// Params 0
// Checksum 0x0, Offset: 0x17e
// Size: 0x28
function function_fc973eaad5032286()
{
    thread onplayerspawned();
    setdvar( @"hash_b9422777c9947030", 1 );
    thread function_492b4dec632917ec( "warrior_dronewars" );
}

// Namespace warrior_dronewars / namespace_4ade0a16752c1aea
// Params 0
// Checksum 0x0, Offset: 0x1ae
// Size: 0x66
function function_edbb4af03709e7ca()
{
    setdvar( @"hash_b9422777c9947030", 0 );
    
    foreach ( player in level.players )
    {
        player scripts\mp\killstreaks\killstreaks::clearkillstreaks();
    }
}

// Namespace warrior_dronewars / namespace_4ade0a16752c1aea
// Params 0
// Checksum 0x0, Offset: 0x21c
// Size: 0x6e
function onplayerspawned()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        player takeallweapons();
        empweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845( "jup_jp22_la_dromeo_mp" );
        player giveweapon( empweapon );
        player setspawnweapon( empweapon );
        player scripts\mp\killstreaks\killstreaks::awardkillstreak( "assault_drone" );
        player thread function_7f932a5ec2ace0fd();
    }
}

// Namespace warrior_dronewars / namespace_4ade0a16752c1aea
// Params 0
// Checksum 0x0, Offset: 0x292
// Size: 0x3d
function function_7f932a5ec2ace0fd()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    
    while ( true )
    {
        self waittill( "assault_drone_deployed" );
        waittill_any_2( "eng_drone_update", "drone_destroyed" );
        scripts\mp\killstreaks\killstreaks::awardkillstreak( "assault_drone" );
    }
}

