#namespace mp_jup_subbase_fx;

// Namespace mp_jup_subbase_fx / scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_fx
// Params 0
// Checksum 0x0, Offset: 0x11e
// Size: 0x50
function main()
{
    level._effect[ "vfx_rhib_infil_splashes" ] = loadfx( "vfx/iw9/infil/vfx_rhib_infil_splashes.vfx" );
    level._effect[ "vfx_farm_sunflare" ] = loadfx( "vfx/jup/level/mp_jup_subbase/vfx_subbase_sunflare.vfx" );
    
    /#
        if ( getdvar( @"clientsideeffects" ) != "<dev string:x1c>" )
        {
        }
    #/
}

