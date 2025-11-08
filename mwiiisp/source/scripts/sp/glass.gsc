#using scripts\common\utility;
#using scripts\engine\utility;

#namespace glass;

// Namespace glass / scripts\sp\glass
// Params 0
// Checksum 0x0, Offset: 0xa1
// Size: 0x1d
function init_glass()
{
    array_thread( getentarray( "window_poster", "targetname" ), &window_destroy );
}

// Namespace glass / scripts\sp\glass
// Params 0
// Checksum 0x0, Offset: 0xc6
// Size: 0x6e
function window_destroy()
{
    assert( isdefined( self.target ) );
    glassid = getglass( self.target );
    
    if ( !isdefined( glassid ) )
    {
        println( "<dev string:x1c>" + self.target + "<dev string:x4b>" + self.origin );
        return;
    }
    
    level waittillmatch( "glass_destroyed", glassid );
    self delete();
}

