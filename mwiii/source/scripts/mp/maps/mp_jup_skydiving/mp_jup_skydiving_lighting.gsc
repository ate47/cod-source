#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace mp_jup_skydiving_lighting;

// Namespace mp_jup_skydiving_lighting / scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_lighting
// Params 0
// Checksum 0x0, Offset: 0xa8
// Size: 0x2e
function main()
{
    thread lighting_setup_dvars();
    thread function_9b9701887eb61641();
    level.var_1550eea978f3c08 = getmapsuncolorandintensity();
    level.var_6df7b39edec9ac5b = getmapsundirection();
}

// Namespace mp_jup_skydiving_lighting / scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_lighting
// Params 0
// Checksum 0x0, Offset: 0xde
// Size: 0x2
function lighting_setup_dvars()
{
    
}

// Namespace mp_jup_skydiving_lighting / scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_lighting
// Params 0
// Checksum 0x0, Offset: 0xe8
// Size: 0xe
function function_9b9701887eb61641()
{
    resetsundirection();
    resetsunlight();
}

// Namespace mp_jup_skydiving_lighting / scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_lighting
// Params 3
// Checksum 0x0, Offset: 0xfe
// Size: 0x68
function function_83165e6c3fba43ff( var_1486d9950068fc3b, var_1eee77dc97d49765, intensity )
{
    if ( !isdefined( intensity ) )
    {
        intensity = undefined;
    }
    
    var_e660de2f1c2dc655 = anglestoforward( var_1486d9950068fc3b );
    setsundirection( var_e660de2f1c2dc655 );
    
    if ( isdefined( intensity ) )
    {
        setsuncolorandintensity( var_1eee77dc97d49765[ 0 ], var_1eee77dc97d49765[ 1 ], var_1eee77dc97d49765[ 2 ], intensity );
        return;
    }
    
    setsuncolorandintensity( var_1eee77dc97d49765[ 0 ], var_1eee77dc97d49765[ 1 ], var_1eee77dc97d49765[ 2 ] );
}

