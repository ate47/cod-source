#using scripts\common\values;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;

#namespace warrior_bullettime;

// Namespace warrior_bullettime / namespace_364d3183e2eb6684
// Params 0
// Checksum 0x0, Offset: 0x143
// Size: 0x17
function function_b4220bf7ade5fc76()
{
    thread onplayerspawned();
    thread function_492b4dec632917ec( "warrior_bullettime" );
}

// Namespace warrior_bullettime / namespace_364d3183e2eb6684
// Params 0
// Checksum 0x0, Offset: 0x162
// Size: 0x62
function onplayerspawned()
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        player takeallweapons();
        var_260024495ccb1af0 = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845( "jup_cp24_pi_glima21_mp_bullettime" );
        player giveweapon( var_260024495ccb1af0 );
        player setspawnweapon( var_260024495ccb1af0 );
        player thread waittill_reload( var_260024495ccb1af0 );
    }
}

// Namespace warrior_bullettime / namespace_364d3183e2eb6684
// Params 1
// Checksum 0x0, Offset: 0x1cc
// Size: 0x45
function waittill_reload( var_260024495ccb1af0 )
{
    level endon( "game_ended" );
    level endon( "round_end_finished" );
    ammostock = self getweaponammostock( var_260024495ccb1af0 );
    
    while ( true )
    {
        self waittill( "reload" );
        self setweaponammostock( var_260024495ccb1af0, ammostock );
    }
}

