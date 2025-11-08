#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;

#namespace mp_jup_estate_lighting;

// Namespace mp_jup_estate_lighting / scripts\mp\maps\mp_jup_estate\mp_jup_estate_lighting
// Params 0
// Checksum 0x0, Offset: 0x12d
// Size: 0xa
function main()
{
    thread function_15ac91b5e59a6c86();
}

// Namespace mp_jup_estate_lighting / scripts\mp\maps\mp_jup_estate\mp_jup_estate_lighting
// Params 0
// Checksum 0x0, Offset: 0x13f
// Size: 0x7e
function function_15ac91b5e59a6c86()
{
    wait 1;
    gameflagwait( "infil_started" );
    mover = getent( "bravo", "targetname" );
    probe = getent( "helicopter_reflection_probe", "targetname" );
    probe linkto( mover, "tag_light_interior_01", ( 120, 3, -50 ), ( 0, 0, 0 ) );
    mover setscriptablepartstate( "infil_lights", "on_estate", 0 );
}

