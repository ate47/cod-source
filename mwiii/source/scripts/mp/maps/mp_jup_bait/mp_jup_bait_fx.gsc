#namespace mp_jup_bait_fx;

// Namespace mp_jup_bait_fx / scripts\mp\maps\mp_jup_bait\mp_jup_bait_fx
// Params 0
// Checksum 0x0, Offset: 0x171
// Size: 0x84
function main()
{
    level._effect[ "small_duck_explode" ] = loadfx( "vfx/jup/level/mp_jup_bait/vfx_bait_duck_pop.vfx" );
    level._effect[ "small_duck_spawn" ] = loadfx( "vfx/jup/level/mp_jup_bait/vfx_bait_duck_hi.vfx" );
    level._effect[ "big_duck_spawn" ] = loadfx( "vfx/jup/level/mp_jup_bait/vfx_bait_duck_pop.vfx" );
    level._effect[ "small_duck_timeout" ] = loadfx( "vfx/jup/level/mp_jup_bait/vfx_bait_duck_bye.vfx" );
    
    /#
        if ( getdvar( @"clientsideeffects" ) != "<dev string:x1c>" )
        {
        }
    #/
}

