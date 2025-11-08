#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_security_area\gen\mp_jup_security_area_art;
#using scripts\mp\maps\mp_jup_security_area\mp_jup_security_area_fx;
#using scripts\mp\maps\mp_jup_security_area\mp_jup_security_area_lighting;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;

#namespace mp_jup_security_area;

// Namespace mp_jup_security_area / scripts\mp\maps\mp_jup_security_area\mp_jup_security_area
// Params 0
// Checksum 0x0, Offset: 0x1b1
// Size: 0xa6
function main()
{
    scripts\mp\maps\mp_jup_security_area\gen\mp_jup_security_area_art::main();
    scripts\mp\maps\mp_jup_security_area\mp_jup_security_area_fx::main();
    scripts\mp\maps\mp_jup_security_area\mp_jup_security_area_lighting::main();
    scripts\mp\load::main();
    scripts\cp_mp\utility\game_utility::function_35f564beac680d88();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.kill_border_triggers = getentarray( "kill_border_trigger", "targetname" );
    scripts\mp\compass::setupminimap( "compass_map_mp_jup_security_area" );
    setdvar( @"hash_7686fcb92ccc5edb", 8 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

