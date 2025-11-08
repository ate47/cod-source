#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_incline\gen\mp_jup_incline_art;
#using scripts\mp\maps\mp_jup_incline\mp_jup_incline_fx;
#using scripts\mp\maps\mp_jup_incline\mp_jup_incline_lighting;

#namespace mp_jup_incline;

// Namespace mp_jup_incline / scripts\mp\maps\mp_jup_incline\mp_jup_incline
// Params 0
// Checksum 0x0, Offset: 0x16c
// Size: 0x8e
function main()
{
    scripts\mp\maps\mp_jup_incline\gen\mp_jup_incline_art::main();
    scripts\mp\maps\mp_jup_incline\mp_jup_incline_fx::main();
    scripts\mp\maps\mp_jup_incline\mp_jup_incline_lighting::main();
    scripts\mp\load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    scripts\mp\compass::setupminimap( "compass_map_mp_jup_incline" );
    setdvar( @"hash_7686fcb92ccc5edb", 8 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    scripts\cp_mp\utility\game_utility::registersmallmap();
}

