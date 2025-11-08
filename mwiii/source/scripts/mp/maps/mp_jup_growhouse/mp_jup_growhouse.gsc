#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_growhouse\gen\mp_jup_growhouse_art;
#using scripts\mp\maps\mp_jup_growhouse\mp_jup_growhouse_fx;
#using scripts\mp\maps\mp_jup_growhouse\mp_jup_growhouse_lighting;

#namespace mp_jup_growhouse;

// Namespace mp_jup_growhouse / scripts\mp\maps\mp_jup_growhouse\mp_jup_growhouse
// Params 0
// Checksum 0x0, Offset: 0x17d
// Size: 0x9f
function main()
{
    scripts\mp\maps\mp_jup_growhouse\gen\mp_jup_growhouse_art::main();
    scripts\mp\maps\mp_jup_growhouse\mp_jup_growhouse_fx::main();
    scripts\mp\maps\mp_jup_growhouse\mp_jup_growhouse_lighting::main();
    scripts\mp\load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.kill_border_triggers = getentarray( "kill_border_trigger", "targetname" );
    scripts\mp\compass::setupminimap( "compass_map_mp_jup_growhouse" );
    setdvar( @"hash_7686fcb92ccc5edb", 8 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

