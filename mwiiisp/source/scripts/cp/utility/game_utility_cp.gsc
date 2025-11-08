#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;

#namespace game_utility_cp;

// Namespace game_utility_cp / scripts\cp\utility\game_utility_cp
// Params 0
// Checksum 0x0, Offset: 0xa3
// Size: 0x18
function game_utility_cp_init()
{
    registersharedfunc( "game_utility", "getTimeSinceGameStart", &game_utility_cp_gettimesincegamestart );
}

// Namespace game_utility_cp / scripts\cp\utility\game_utility_cp
// Params 0
// Checksum 0x0, Offset: 0xc3
// Size: 0x11
function game_utility_cp_gettimesincegamestart()
{
    return gettime() - level.starttime;
}

