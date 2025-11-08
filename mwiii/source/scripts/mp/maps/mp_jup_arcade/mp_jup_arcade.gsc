#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_arcade\gen\mp_jup_arcade_art;
#using scripts\mp\maps\mp_jup_arcade\mp_jup_arcade_fx;
#using scripts\mp\maps\mp_jup_arcade\mp_jup_arcade_lighting;

#namespace mp_jup_arcade;

// Namespace mp_jup_arcade / scripts\mp\maps\mp_jup_arcade\mp_jup_arcade
// Params 0
// Checksum 0x0, Offset: 0x1ca
// Size: 0xa7
function main()
{
    scripts\mp\maps\mp_jup_arcade\gen\mp_jup_arcade_art::main();
    scripts\mp\maps\mp_jup_arcade\mp_jup_arcade_fx::main();
    scripts\mp\maps\mp_jup_arcade\mp_jup_arcade_lighting::main();
    scripts\mp\load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.kill_border_triggers = getentarray( "kill_border_trigger", "targetname" );
    scripts\mp\compass::setupminimap( "compass_map_mp_jup_arcade" );
    setdvar( @"hash_7686fcb92ccc5edb", 8 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    thread gondola_spawn();
}

// Namespace mp_jup_arcade / scripts\mp\maps\mp_jup_arcade\mp_jup_arcade
// Params 0
// Checksum 0x0, Offset: 0x279
// Size: 0x95
function gondola_spawn()
{
    var_8c439f7c112081e = getstructarray( "gondola_start", "script_noteworthy" );
    
    foreach ( var_61fb690ac4ff15c8 in var_8c439f7c112081e )
    {
        var_46e9c3ad7bbcde82 = spawn_model( "jup_machinery_gondola_lift_car_vista_01", var_61fb690ac4ff15c8.origin, var_61fb690ac4ff15c8.angles );
        var_61fb690ac4ff15c8 thread gondola_movement( var_46e9c3ad7bbcde82 );
    }
}

// Namespace mp_jup_arcade / scripts\mp\maps\mp_jup_arcade\mp_jup_arcade
// Params 1
// Checksum 0x0, Offset: 0x316
// Size: 0xae
function gondola_movement( var_46e9c3ad7bbcde82 )
{
    targetpoint = getstruct( self.target, "targetname" );
    currentpoint = self;
    
    while ( isdefined( targetpoint ) )
    {
        var_7a7468a3f3fd54b = distance( currentpoint.origin, targetpoint.origin );
        var_4187040fa98742ee = var_7a7468a3f3fd54b / 160;
        thread function_9637cf9e39bf1ab7( var_46e9c3ad7bbcde82, targetpoint.origin, targetpoint.angles, var_4187040fa98742ee );
        wait var_4187040fa98742ee;
        currentpoint = targetpoint;
        targetpoint = getstruct( currentpoint.target, "targetname" );
    }
}

// Namespace mp_jup_arcade / scripts\mp\maps\mp_jup_arcade\mp_jup_arcade
// Params 4
// Checksum 0x0, Offset: 0x3cc
// Size: 0x39
function function_9637cf9e39bf1ab7( var_46e9c3ad7bbcde82, targetorigin, targetangle, var_4187040fa98742ee )
{
    var_46e9c3ad7bbcde82 moveto( targetorigin, var_4187040fa98742ee );
    var_46e9c3ad7bbcde82 rotateto( targetangle, 0.1 );
}

