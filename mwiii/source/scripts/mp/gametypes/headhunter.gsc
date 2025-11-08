#using scripts\common\values;
#using scripts\mp\tweakables;

#namespace headhunter;

// Namespace headhunter / scripts\mp\gametypes\headhunter
// Params 0
// Checksum 0x0, Offset: 0x136
// Size: 0x12
function init()
{
    thread function_117e2995648ba30c();
    thread onplayerspawned();
}

// Namespace headhunter / scripts\mp\gametypes\headhunter
// Params 0
// Checksum 0x0, Offset: 0x150
// Size: 0x24
function function_117e2995648ba30c()
{
    level endon( "game_ended" );
    level waittill( "tweakablesInitialized" );
    scripts\mp\tweakables::settweakablevalue( "game", "onlyheadshots", 1 );
}

// Namespace headhunter / scripts\mp\gametypes\headhunter
// Params 0
// Checksum 0x0, Offset: 0x17c
// Size: 0x5c
function onplayerspawned()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        player val::set( "headhunter", "execution_attack", 0 );
        player val::set( "headhunter", "execution_victim", 0 );
        player setsoundsubmix( "jup_mode_headhunter", 0.5 );
    }
}

