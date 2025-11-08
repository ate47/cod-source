#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_trainingfacility\gen\mp_jup_trainingfacility_art;
#using scripts\mp\maps\mp_jup_trainingfacility\mp_jup_trainingfacility_fx;
#using scripts\mp\maps\mp_jup_trainingfacility\mp_jup_trainingfacility_lighting;

#namespace mp_jup_trainingfacility;

// Namespace mp_jup_trainingfacility / scripts\mp\maps\mp_jup_trainingfacility\mp_jup_trainingfacility
// Params 0
// Checksum 0x0, Offset: 0x174
// Size: 0x8e
function main()
{
    scripts\mp\maps\mp_jup_trainingfacility\gen\mp_jup_trainingfacility_art::main();
    scripts\mp\maps\mp_jup_trainingfacility\mp_jup_trainingfacility_fx::main();
    scripts\mp\maps\mp_jup_trainingfacility\mp_jup_trainingfacility_lighting::main();
    scripts\mp\load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    scripts\mp\compass::setupminimap( "compass_map_mp_jup_trainingfacility" );
    scripts\cp_mp\utility\game_utility::registerarenamap();
    setdvar( @"hash_7686fcb92ccc5edb", 8 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

