#namespace mp_jup_scrapyard_alt_v2_fx;

// Namespace mp_jup_scrapyard_alt_v2_fx / scripts\mp\maps\mp_jup_scrapyard_alt_v2\mp_jup_scrapyard_alt_v2_fx
// Params 0
// Checksum 0x0, Offset: 0xe5
// Size: 0x36
function main()
{
    level._effect[ "vfx_scrap_trash_flies_alt" ] = loadfx( "vfx/jup/level/mp_jup_scrap_alt/vfx_scrap_trash_flies_alt.vfx" );
    
    /#
        if ( getdvar( @"clientsideeffects" ) != "<dev string:x1c>" )
        {
        }
    #/
}

