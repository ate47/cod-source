#using scripts\sp\equipment\offhands;

#namespace hb_sensor;

// Namespace hb_sensor / scripts\sp\equipment\hb_sensor
// Params 1
// Checksum 0x0, Offset: 0x70
// Size: 0x18
function precache( offhand )
{
    registeroffhandfirefunc( offhand, &function_8f256a2c4afab75f );
}

// Namespace hb_sensor / scripts\sp\equipment\hb_sensor
// Params 2
// Checksum 0x0, Offset: 0x90
// Size: 0x20
function function_8f256a2c4afab75f( grenade, weapon )
{
    waitframe();
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
}

