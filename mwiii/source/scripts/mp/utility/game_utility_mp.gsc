#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\matchdata;
#using scripts\mp\utility\game;

#namespace game_utility_mp;

// Namespace game_utility_mp / scripts\mp\utility\game_utility_mp
// Params 0
// Checksum 0x0, Offset: 0x117
// Size: 0x18
function game_utility_mp_init()
{
    registersharedfunc( "game_utility", "getTimeSinceGameStart", &game_utility_mp_gettimesincegamestart );
}

// Namespace game_utility_mp / scripts\mp\utility\game_utility_mp
// Params 0
// Checksum 0x0, Offset: 0x137
// Size: 0xd
function game_utility_mp_gettimesincegamestart()
{
    return scripts\mp\matchdata::gettimefrommatchstart( gettime() );
}

// Namespace game_utility_mp / scripts\mp\utility\game_utility_mp
// Params 0
// Checksum 0x0, Offset: 0x14d
// Size: 0x76, Type: bool
function function_9a2fd0d19774edde()
{
    switch ( scripts\mp\utility\game::getgametype() )
    {
        case #"hash_1e4846dca3ccf38":
        case #"hash_ca6516c10db2c95":
        case #"hash_5e78ea9021845d4a":
        case #"hash_7f9c384a34cc392f":
        case #"hash_9a6f07d0214a87db":
        case #"hash_c065cef60f38490a":
        case #"hash_c7f4420f385eeb3d":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace game_utility_mp / scripts\mp\utility\game_utility_mp
// Params 1
// Checksum 0x0, Offset: 0x1cc
// Size: 0x8f, Type: bool
function modeusesgroundwarteamoobtriggers( trigger )
{
    if ( isdefined( trigger.script_team ) )
    {
        switch ( scripts\mp\utility\game::getgametype() )
        {
            case #"hash_1e4846dca3ccf38":
            case #"hash_ca6516c10db2c95":
            case #"hash_5e78ea9021845d4a":
            case #"hash_7f9c384a34cc392f":
            case #"hash_9a6f07d0214a87db":
            case #"hash_c065cef60f38490a":
            case #"hash_c7f4420f385eeb3d":
                return true;
            default:
                return false;
        }
    }
    
    return true;
}

