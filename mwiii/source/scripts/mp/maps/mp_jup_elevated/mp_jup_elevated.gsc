#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_elevated\gen\mp_jup_elevated_art;
#using scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_audio;
#using scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_fx;
#using scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_lighting;

#namespace mp_jup_elevated;

// Namespace mp_jup_elevated / scripts\mp\maps\mp_jup_elevated\mp_jup_elevated
// Params 0
// Checksum 0x0, Offset: 0x184
// Size: 0xa6
function main()
{
    scripts\mp\maps\mp_jup_elevated\gen\mp_jup_elevated_art::main();
    scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_fx::main();
    scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_lighting::main();
    scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_audio::main();
    scripts\mp\load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.kill_border_triggers = getentarray( "kill_border_trigger", "targetname" );
    scripts\mp\compass::setupminimap( "compass_map_mp_jup_elevated" );
    setdvar( @"hash_7686fcb92ccc5edb", 8 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

