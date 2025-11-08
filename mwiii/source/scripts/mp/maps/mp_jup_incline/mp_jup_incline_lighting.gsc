#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace mp_jup_incline_lighting;

// Namespace mp_jup_incline_lighting / scripts\mp\maps\mp_jup_incline\mp_jup_incline_lighting
// Params 0
// Checksum 0x0, Offset: 0xca
// Size: 0xa
function main()
{
    thread function_d2b21d3eeb9a5054();
}

// Namespace mp_jup_incline_lighting / scripts\mp\maps\mp_jup_incline\mp_jup_incline_lighting
// Params 0
// Checksum 0x0, Offset: 0xdc
// Size: 0x34
function function_d2b21d3eeb9a5054()
{
    light = getent( "lgt_rescue_light", "targetname" );
    light rotatevelocity( ( 0, 1000, 0 ), 50000 );
}

