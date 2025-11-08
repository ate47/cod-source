#using scripts\common\utility;
#using scripts\engine\utility;

#namespace render_utility;

// Namespace render_utility / scripts\cp_mp\utility\render_utility
// Params 4
// Checksum 0x0, Offset: 0x137
// Size: 0x85
function function_4f2c4138dacca16a( aberration, radius, strength, distortion )
{
    assert( isdefined( self ) );
    assert( isplayer( self ) );
    
    if ( isdefined( aberration ) )
    {
        self setclientomnvar( "chromatic_aberration_override", aberration );
    }
    
    if ( isdefined( radius ) )
    {
        self setclientomnvar( "chromatic_aberration_radius_override", radius );
    }
    
    if ( isdefined( strength ) )
    {
        self setclientomnvar( "chromatic_aberration_strength_override", strength );
    }
    
    if ( isdefined( distortion ) )
    {
        self setclientomnvar( "chromatic_aberration_distortion_override", distortion );
    }
}

// Namespace render_utility / scripts\cp_mp\utility\render_utility
// Params 0
// Checksum 0x0, Offset: 0x1c4
// Size: 0x60
function function_e2eae50826e12247()
{
    assert( isdefined( self ) );
    assert( isplayer( self ) );
    self setclientomnvar( "chromatic_aberration_override", 0 );
    self setclientomnvar( "chromatic_aberration_radius_override", 0 );
    self setclientomnvar( "chromatic_aberration_strength_override", 0 );
    self setclientomnvar( "chromatic_aberration_distortion_override", 0 );
}

