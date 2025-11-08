#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_das_haus_alien\gen\mp_jup_das_haus_alien_art;
#using scripts\mp\maps\mp_jup_das_haus_alien\mp_jup_das_haus_alien_fx;
#using scripts\mp\maps\mp_jup_das_haus_alien\mp_jup_das_haus_alien_lighting;

#namespace mp_jup_das_haus_alien;

// Namespace mp_jup_das_haus_alien / scripts\mp\maps\mp_jup_das_haus_alien\mp_jup_das_haus_alien
// Params 0
// Checksum 0x0, Offset: 0x181
// Size: 0x9f
function main()
{
    scripts\mp\maps\mp_jup_das_haus_alien\gen\mp_jup_das_haus_alien_art::main();
    scripts\mp\maps\mp_jup_das_haus_alien\mp_jup_das_haus_alien_fx::main();
    scripts\mp\maps\mp_jup_das_haus_alien\mp_jup_das_haus_alien_lighting::main();
    scripts\mp\load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.kill_border_triggers = getentarray( "kill_border_trigger", "targetname" );
    scripts\mp\compass::setupminimap( "compass_map_mp_jup_das_haus_alien" );
    setdvar( @"hash_7686fcb92ccc5edb", 8 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

