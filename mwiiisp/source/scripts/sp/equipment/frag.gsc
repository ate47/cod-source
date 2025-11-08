#using scripts\sp\equipment\offhands;

#namespace frag;

// Namespace frag / scripts\sp\equipment\frag
// Params 1
// Checksum 0x0, Offset: 0xaf
// Size: 0x18
function precache( offhand )
{
    registeroffhandfirefunc( offhand, &fragfiremain );
}

// Namespace frag / scripts\sp\equipment\frag
// Params 2
// Checksum 0x0, Offset: 0xcf
// Size: 0x68
function fragfiremain( grenade, weapon )
{
    grenade endon( "frag_deleted" );
    addbattlechatternotify( self, undefined, "grenade_throw", "frag_grenade" );
    grenade thread notifyondelete();
    grenade waittill( "explode", origin );
    playrumbleonposition( "grenade_rumble", origin );
    earthquake( 0.38, 0.65, origin, 900 );
}

// Namespace frag / scripts\sp\equipment\frag
// Params 0
// Checksum 0x0, Offset: 0x13f
// Size: 0x1f
function notifyondelete()
{
    self endon( "explode" );
    
    while ( isdefined( self ) )
    {
        wait 0.05;
    }
    
    self notify( "frag_deleted" );
}

