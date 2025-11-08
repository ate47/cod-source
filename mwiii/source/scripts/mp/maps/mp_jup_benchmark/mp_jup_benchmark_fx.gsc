#namespace mp_jup_benchmark_fx;

// Namespace mp_jup_benchmark_fx / scripts\mp\maps\mp_jup_benchmark\mp_jup_benchmark_fx
// Params 0
// Checksum 0x0, Offset: 0x170
// Size: 0x6a
function main()
{
    level._effect[ "vfx_muzzle_flash" ] = loadfx( "vfx/iw9/core/weapons/muzzleflash/ar/vfx_muz_ar_mike4.vfx" );
    level._effect[ "swim_exit_water" ] = loadfx( "vfx/iw9/core/swimming/vfx_swim_exit_water_screen.vfx" );
    level._effect[ "swim_enter_water" ] = loadfx( "vfx/iw9/core/swimming/vfx_swim_submerge_bubbles_2.vfx" );
    
    /#
        if ( getdvar( @"clientsideeffects" ) != "<dev string:x1c>" )
        {
        }
    #/
}

