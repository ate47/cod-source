#namespace mp_jup_elevated_fx;

// Namespace mp_jup_elevated_fx / scripts\mp\maps\mp_jup_elevated\mp_jup_elevated_fx
// Params 0
// Checksum 0x0, Offset: 0xdc
// Size: 0x36
function main()
{
    level._effect[ "vfx_elevated_train_01" ] = loadfx( "vfx/jup/level/mp_jup_elevated/vfx_elevated_train_01.vfx" );
    
    /#
        if ( getdvar( @"clientsideeffects" ) != "<dev string:x1c>" )
        {
        }
    #/
}

