#using scripts\common\anim;
#using scripts\common\createfx;
#using scripts\common\exploder;
#using scripts\common\utility;
#using scripts\engine\flags;
#using scripts\engine\trace;

#namespace utility;

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x7b1
// Size: 0xb6
function noself_func( func, parm1, parm2, parm3, parm4 )
{
    if ( !isdefined( level.func ) )
    {
        return;
    }
    
    if ( !isdefined( level.func[ func ] ) )
    {
        return;
    }
    
    if ( isdefined( parm4 ) )
    {
        builtin [[ level.func[ func ] ]]( parm1, parm2, parm3, parm4 );
        return;
    }
    
    if ( isdefined( parm3 ) )
    {
        builtin [[ level.func[ func ] ]]( parm1, parm2, parm3 );
        return;
    }
    
    if ( isdefined( parm2 ) )
    {
        builtin [[ level.func[ func ] ]]( parm1, parm2 );
        return;
    }
    
    if ( isdefined( parm1 ) )
    {
        builtin [[ level.func[ func ] ]]( parm1 );
        return;
    }
    
    builtin [[ level.func[ func ] ]]();
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x86f
// Size: 0xb3
function noself_func_return( func, parm1, parm2, parm3, parm4 )
{
    if ( !isdefined( level.func ) )
    {
        return undefined;
    }
    
    if ( !isdefined( level.func[ func ] ) )
    {
        return undefined;
    }
    
    if ( isdefined( parm4 ) )
    {
        return builtin [[ level.func[ func ] ]]( parm1, parm2, parm3, parm4 );
    }
    
    if ( isdefined( parm3 ) )
    {
        return builtin [[ level.func[ func ] ]]( parm1, parm2, parm3 );
    }
    
    if ( isdefined( parm2 ) )
    {
        return builtin [[ level.func[ func ] ]]( parm1, parm2 );
    }
    
    if ( isdefined( parm1 ) )
    {
        return builtin [[ level.func[ func ] ]]( parm1 );
    }
    
    return builtin [[ level.func[ func ] ]]();
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0x92b
// Size: 0xca
function self_func( func, parm1, parm2, parm3, parm4, var_77895a5b8a625552 )
{
    if ( !isdefined( level.func[ func ] ) )
    {
        return;
    }
    
    if ( isdefined( var_77895a5b8a625552 ) )
    {
        return self builtin [[ level.func[ func ] ]]( parm1, parm2, parm3, parm4, var_77895a5b8a625552 );
    }
    
    if ( isdefined( parm4 ) )
    {
        return self builtin [[ level.func[ func ] ]]( parm1, parm2, parm3, parm4 );
    }
    
    if ( isdefined( parm3 ) )
    {
        return self builtin [[ level.func[ func ] ]]( parm1, parm2, parm3 );
    }
    
    if ( isdefined( parm2 ) )
    {
        return self builtin [[ level.func[ func ] ]]( parm1, parm2 );
    }
    
    if ( isdefined( parm1 ) )
    {
        return self builtin [[ level.func[ func ] ]]( parm1 );
    }
    
    return self builtin [[ level.func[ func ] ]]();
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x9fe
// Size: 0xb0
function script_func( func, parm1, parm2, parm3, parm4 )
{
    if ( !isdefined( level.func[ func ] ) )
    {
        return;
    }
    
    if ( isdefined( parm4 ) )
    {
        return self [[ level.func[ func ] ]]( parm1, parm2, parm3, parm4 );
    }
    
    if ( isdefined( parm3 ) )
    {
        return self [[ level.func[ func ] ]]( parm1, parm2, parm3 );
    }
    
    if ( isdefined( parm2 ) )
    {
        return self [[ level.func[ func ] ]]( parm1, parm2 );
    }
    
    if ( isdefined( parm1 ) )
    {
        return self [[ level.func[ func ] ]]( parm1 );
    }
    
    return self [[ level.func[ func ] ]]();
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xab6
// Size: 0x36
function randomvector( num )
{
    return ( randomfloat( num ) - num * 0.5, randomfloat( num ) - num * 0.5, randomfloat( num ) - num * 0.5 );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xaf5
// Size: 0x98
function randomvectorrange( num_min, num_max )
{
    assert( isdefined( num_min ) );
    assert( isdefined( num_max ) );
    x = randomfloatrange( num_min, num_max );
    
    if ( randomint( 2 ) == 0 )
    {
        x *= -1;
    }
    
    y = randomfloatrange( num_min, num_max );
    
    if ( randomint( 2 ) == 0 )
    {
        y *= -1;
    }
    
    z = randomfloatrange( num_min, num_max );
    
    if ( randomint( 2 ) == 0 )
    {
        z *= -1;
    }
    
    return ( x, y, z );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xb96
// Size: 0x16
function sign( x )
{
    if ( x >= 0 )
    {
        return 1;
    }
    
    return -1;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xbb5
// Size: 0x29
function vectorsign( vec )
{
    return ( sign( vec[ 0 ] ), sign( vec[ 1 ] ), sign( vec[ 2 ] ) );
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xbe7
// Size: 0x69
function randomonunitsphere()
{
    theta = randomfloat( 180 );
    phi = randomfloat( 360 );
    x = cos( phi ) * cos( theta );
    y = cos( phi ) * sin( theta );
    z = sin( phi );
    return ( x, y, z );
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xc59
// Size: 0x4f
function function_6174330574a2a273()
{
    angle = randomfloat( 360 );
    dist = randomfloat( 1 );
    x = cos( angle ) * dist;
    y = sin( angle ) * dist;
    return ( x, y, 0 );
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xcb1
// Size: 0x44
function function_d553466cf817a4da()
{
    while ( true )
    {
        x = randomfloatrange( -1, 1 );
        y = randomfloatrange( -1, 1 );
        
        if ( x * x + y * y < 1 )
        {
            return ( x, y, 0 );
        }
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xcfd
// Size: 0x3a
function mod( dividend, divisor )
{
    q = int( dividend / divisor );
    
    if ( dividend * divisor < 0 )
    {
        q -= 1;
    }
    
    return dividend - q * divisor;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xd40
// Size: 0x4a
function get_enemy_team( team )
{
    assertex( team != "<dev string:x1c>", "<dev string:x27>" );
    teams = [];
    teams[ "axis" ] = "allies";
    teams[ "allies" ] = "axis";
    return teams[ team ];
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xd93
// Size: 0x35
function clear_exception( type )
{
    assert( isdefined( self.exception[ type ] ) );
    self.exception[ type ] = anim.defaultexception;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xdd0
// Size: 0xc, Type: bool
function cointoss()
{
    return randomint( 100 ) >= 50;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xde5
// Size: 0x24, Type: bool
function percent_chance( probability )
{
    assertex( isdefined( probability ), "<dev string:x46>" );
    return randomfloat( 100 ) < probability;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xe12
// Size: 0x60
function choose_from_weighted_array( values, weights )
{
    assert( values.size == weights.size );
    randomval = randomint( weights[ weights.size - 1 ] + 1 );
    
    for ( i = 0; i < weights.size ; i++ )
    {
        if ( randomval <= weights[ i ] )
        {
            return values[ i ];
        }
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xe7a
// Size: 0x38
function waittill_string( msg, ent )
{
    if ( msg != "death" )
    {
        self endon( "death" );
    }
    
    ent endon( "die" );
    self waittill( msg );
    ent notify( "returned", msg );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xeba
// Size: 0x43
function waittillmatch_string( anim_name, msg, ent )
{
    if ( msg != "death" )
    {
        self endon( "death" );
    }
    
    ent endon( "die" );
    self waittillmatch( anim_name, msg );
    ent notify( "returned", msg );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xf05
// Size: 0x27
function waittill_string_no_endon_death( msg, ent )
{
    ent endon( "die" );
    self waittill( msg );
    ent notify( "returned", msg );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xf34
// Size: 0x33
function function_67e5ee8add8aafae( string, ent )
{
    ent endon( "die" );
    self waittill( string, msg );
    ent notify( "returned", msg );
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0xf6f
// Size: 0x118
function waittill_multiple( string1, string2, string3, string4, string5 )
{
    assertex( issp(), "<dev string:x6d>" );
    self endon( "death" );
    ent = spawnstruct();
    ent.threads = 0;
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
        ent.threads++;
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
        ent.threads++;
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string( string3, ent );
        ent.threads++;
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string( string4, ent );
        ent.threads++;
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string( string5, ent );
        ent.threads++;
    }
    
    while ( ent.threads )
    {
        ent waittill( "returned" );
        ent.threads--;
    }
    
    ent notify( "die" );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x108f
// Size: 0x9b
function waittill_2( string1, string2 )
{
    self endon( "death" );
    ent = spawnstruct();
    ent.threads = 0;
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
        ent.threads++;
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
        ent.threads++;
    }
    
    while ( ent.threads )
    {
        ent waittill( "returned" );
        ent.threads--;
    }
    
    ent notify( "die" );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x1132
// Size: 0x2d
function waittillmatch_notify( anim_name, match_msg, notify_str )
{
    self endon( "death" );
    self waittillmatch( anim_name, match_msg );
    self notify( notify_str );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x1167
// Size: 0x5e
function waittill_any_return_1( string1 )
{
    if ( !isdefined( string1 ) || string1 != "death" )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x11ce
// Size: 0x87
function waittill_any_return_2( string1, string2 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x125e
// Size: 0xb0
function waittill_any_return_3( string1, string2, string3 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string( string3, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x1317
// Size: 0xd9
function waittill_any_return_4( string1, string2, string3, string4 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string( string4, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x13f9
// Size: 0x106
function waittill_any_return_5( string1, string2, string3, string4, string5 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) && ( !isdefined( string5 ) || string5 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string( string5, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0x1508
// Size: 0x133
function waittill_any_return_6( string1, string2, string3, string4, string5, string6 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) && ( !isdefined( string5 ) || string5 != "death" ) && ( !isdefined( string6 ) || string6 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string( string5, ent );
    }
    
    if ( isdefined( string6 ) )
    {
        childthread waittill_string( string6, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0x1644
// Size: 0x160
function waittill_any_return_7( string1, string2, string3, string4, string5, string6, string7 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) && ( !isdefined( string5 ) || string5 != "death" ) && ( !isdefined( string6 ) || string6 != "death" ) && ( !isdefined( string7 ) || string7 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string( string5, ent );
    }
    
    if ( isdefined( string6 ) )
    {
        childthread waittill_string( string6, ent );
    }
    
    if ( isdefined( string7 ) )
    {
        childthread waittill_string( string7, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 8
// Checksum 0x0, Offset: 0x17ad
// Size: 0x1a1
function waittill_any_return( string1, string2, string3, string4, string5, string6, string7, string8 )
{
    assertex( issp(), "<dev string:xd6>" );
    
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) && ( !isdefined( string5 ) || string5 != "death" ) && ( !isdefined( string6 ) || string6 != "death" ) && ( !isdefined( string7 ) || string7 != "death" ) && ( !isdefined( string8 ) || string8 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string( string5, ent );
    }
    
    if ( isdefined( string6 ) )
    {
        childthread waittill_string( string6, ent );
    }
    
    if ( isdefined( string7 ) )
    {
        childthread waittill_string( string7, ent );
    }
    
    if ( isdefined( string8 ) )
    {
        childthread waittill_string( string8, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0x1957
// Size: 0x147
function waittillmatch_any_return( animstring, string1, string2, string3, string4, string5, string6 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) && ( !isdefined( string5 ) || string5 != "death" ) && ( !isdefined( string6 ) || string6 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittillmatch_string( animstring, string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittillmatch_string( animstring, string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittillmatch_string( animstring, string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittillmatch_string( animstring, string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittillmatch_string( animstring, string5, ent );
    }
    
    if ( isdefined( string6 ) )
    {
        childthread waittillmatch_string( animstring, string6, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x1aa7
// Size: 0x46
function waittill_any_return_no_endon_death_1( string1 )
{
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x1af6
// Size: 0x5d
function waittill_any_return_no_endon_death_2( string1, string2 )
{
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string_no_endon_death( string2, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x1b5c
// Size: 0x74
function waittill_any_return_no_endon_death_3( string1, string2, string3 )
{
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string_no_endon_death( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string_no_endon_death( string3, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x1bd9
// Size: 0x8b
function waittill_any_return_no_endon_death_4( string1, string2, string3, string4 )
{
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string_no_endon_death( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string_no_endon_death( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string_no_endon_death( string4, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x1c6d
// Size: 0xa4
function waittill_any_return_no_endon_death_5( string1, string2, string3, string4, string5 )
{
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string_no_endon_death( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string_no_endon_death( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string_no_endon_death( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string_no_endon_death( string5, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0x1d1a
// Size: 0xbd
function waittill_any_return_no_endon_death_6( string1, string2, string3, string4, string5, string6 )
{
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string_no_endon_death( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string_no_endon_death( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string_no_endon_death( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string_no_endon_death( string5, ent );
    }
    
    if ( isdefined( string6 ) )
    {
        childthread waittill_string_no_endon_death( string6, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0x1de0
// Size: 0xd6
function function_efe4706df8361219( string1, string2, string3, string4, string5, string6, string7 )
{
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string_no_endon_death( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string_no_endon_death( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string_no_endon_death( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string_no_endon_death( string5, ent );
    }
    
    if ( isdefined( string6 ) )
    {
        childthread waittill_string_no_endon_death( string6, ent );
    }
    
    if ( isdefined( string7 ) )
    {
        childthread waittill_string_no_endon_death( string7, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0x1ebf
// Size: 0xd1
function waittill_any_return_no_endon_death( string1, string2, string3, string4, string5, string6 )
{
    assertex( issp(), "<dev string:xd6>" );
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string_no_endon_death( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string_no_endon_death( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string_no_endon_death( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string_no_endon_death( string5, ent );
    }
    
    if ( isdefined( string6 ) )
    {
        childthread waittill_string_no_endon_death( string6, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x1f99
// Size: 0x49
function waittill_any_in_array( string_array )
{
    assertex( string_array.size > 0, "<dev string:x141>" );
    
    for ( i = 0; i < string_array.size - 1 ; i++ )
    {
        self endon( string_array[ i ] );
    }
    
    self waittill( string_array[ string_array.size - 1 ] );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x1fea
// Size: 0xa8
function waittill_any_in_array_return( string_array )
{
    ent = spawnstruct();
    hasdeath = 0;
    
    foreach ( string in string_array )
    {
        childthread waittill_string( string, ent );
        
        if ( string == "death" )
        {
            hasdeath = 1;
        }
    }
    
    if ( !hasdeath )
    {
        self endon( "death" );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x209b
// Size: 0x83
function waittill_any_in_array_return_no_endon_death( string_array )
{
    ent = spawnstruct();
    
    foreach ( string in string_array )
    {
        childthread waittill_string_no_endon_death( string, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x2127
// Size: 0xbb
function waittill_any_in_array_or_timeout( string_array, timeout )
{
    ent = spawnstruct();
    hasdeath = 0;
    
    foreach ( string in string_array )
    {
        childthread waittill_string( string, ent );
        
        if ( string == "death" )
        {
            hasdeath = 1;
        }
    }
    
    if ( !hasdeath )
    {
        self endon( "death" );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x21eb
// Size: 0x96
function waittill_any_in_array_or_timeout_no_endon_death( string_array, timeout )
{
    ent = spawnstruct();
    
    foreach ( string in string_array )
    {
        childthread waittill_string_no_endon_death( string, ent );
    }
    
    ent thread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x228a
// Size: 0x4a
function waittill_all_in_array( string_array )
{
    assert( isdefined( string_array ) );
    assert( isarray( string_array ) );
    
    while ( string_array.size )
    {
        msg = waittill_any_in_array_return( string_array );
        string_array = array_remove( string_array, msg );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x22dc
// Size: 0x70
function waittill_any_timeout_1( timeout, string1 )
{
    if ( !isdefined( string1 ) || string1 != "death" )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x2355
// Size: 0x99
function waittill_any_timeout_2( timeout, string1, string2 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x23f7
// Size: 0xc2
function waittill_any_timeout_3( timeout, string1, string2, string3 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string( string3, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x24c2
// Size: 0xec
function waittill_any_timeout_4( timeout, string1, string2, string3, string4 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string( string4, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0x25b7
// Size: 0x119
function waittill_any_timeout_5( timeout, string1, string2, string3, string4, string5 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) && ( !isdefined( string5 ) || string5 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string( string5, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0x26d9
// Size: 0x146
function waittill_any_timeout_6( timeout, string1, string2, string3, string4, string5, string6 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) && ( !isdefined( string5 ) || string5 != "death" ) && ( !isdefined( string6 ) || string6 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string( string5, ent );
    }
    
    if ( isdefined( string6 ) )
    {
        childthread waittill_string( string6, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0x2828
// Size: 0x15a
function waittill_any_timeout( timeout, string1, string2, string3, string4, string5, string6 )
{
    assertex( issp(), "<dev string:x16c>" );
    
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) && ( !isdefined( string5 ) || string5 != "death" ) && ( !isdefined( string6 ) || string6 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string( string5, ent );
    }
    
    if ( isdefined( string6 ) )
    {
        childthread waittill_string( string6, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x298b
// Size: 0x21
function timeout_struct( delay )
{
    self endon( "die" );
    wait delay;
    self notify( "returned", "timeout" );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x29b4
// Size: 0x58
function waittill_any_timeout_no_endon_death_1( timeout, string1 )
{
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x2a15
// Size: 0x6f
function waittill_any_timeout_no_endon_death_2( timeout, string1, string2 )
{
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string_no_endon_death( string2, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x2a8d
// Size: 0x86
function waittill_any_timeout_no_endon_death_3( timeout, string1, string2, string3 )
{
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string_no_endon_death( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string_no_endon_death( string3, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x2b1c
// Size: 0x9e
function waittill_any_timeout_no_endon_death_4( timeout, string1, string2, string3, string4 )
{
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string_no_endon_death( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string_no_endon_death( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string_no_endon_death( string4, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0x2bc3
// Size: 0xb7
function waittill_any_timeout_no_endon_death_5( timeout, string1, string2, string3, string4, string5 )
{
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string_no_endon_death( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string_no_endon_death( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string_no_endon_death( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string_no_endon_death( string5, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0x2c83
// Size: 0xcb
function waittill_any_timeout_no_endon_death( timeout, string1, string2, string3, string4, string5 )
{
    assertex( issp(), "<dev string:x1d8>" );
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread waittill_string_no_endon_death( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread waittill_string_no_endon_death( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread waittill_string_no_endon_death( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread waittill_string_no_endon_death( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread waittill_string_no_endon_death( string5, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x2d57
// Size: 0x2a
function waittill_any_2( string1, string2 )
{
    assert( isdefined( string1 ) );
    
    if ( isdefined( string2 ) )
    {
        self endon( string2 );
    }
    
    self waittill( string1 );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x2d89
// Size: 0x3a
function waittill_any_3( string1, string2, string3 )
{
    assert( isdefined( string1 ) );
    
    if ( isdefined( string2 ) )
    {
        self endon( string2 );
    }
    
    if ( isdefined( string3 ) )
    {
        self endon( string3 );
    }
    
    self waittill( string1 );
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x2dcb
// Size: 0x4a
function waittill_any_4( string1, string2, string3, string4 )
{
    assert( isdefined( string1 ) );
    
    if ( isdefined( string2 ) )
    {
        self endon( string2 );
    }
    
    if ( isdefined( string3 ) )
    {
        self endon( string3 );
    }
    
    if ( isdefined( string4 ) )
    {
        self endon( string4 );
    }
    
    self waittill( string1 );
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x2e1d
// Size: 0x5a
function waittill_any_5( string1, string2, string3, string4, string5 )
{
    assert( isdefined( string1 ) );
    
    if ( isdefined( string2 ) )
    {
        self endon( string2 );
    }
    
    if ( isdefined( string3 ) )
    {
        self endon( string3 );
    }
    
    if ( isdefined( string4 ) )
    {
        self endon( string4 );
    }
    
    if ( isdefined( string5 ) )
    {
        self endon( string5 );
    }
    
    self waittill( string1 );
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0x2e7f
// Size: 0x6a
function waittill_any_6( string1, string2, string3, string4, string5, string6 )
{
    assert( isdefined( string1 ) );
    
    if ( isdefined( string2 ) )
    {
        self endon( string2 );
    }
    
    if ( isdefined( string3 ) )
    {
        self endon( string3 );
    }
    
    if ( isdefined( string4 ) )
    {
        self endon( string4 );
    }
    
    if ( isdefined( string5 ) )
    {
        self endon( string5 );
    }
    
    if ( isdefined( string6 ) )
    {
        self endon( string6 );
    }
    
    self waittill( string1 );
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0x2ef1
// Size: 0x7c
function waittill_any_7( string1, string2, string3, string4, string5, string6, string7 )
{
    assert( isdefined( string1 ) );
    
    if ( isdefined( string2 ) )
    {
        self endon( string2 );
    }
    
    if ( isdefined( string3 ) )
    {
        self endon( string3 );
    }
    
    if ( isdefined( string4 ) )
    {
        self endon( string4 );
    }
    
    if ( isdefined( string5 ) )
    {
        self endon( string5 );
    }
    
    if ( isdefined( string6 ) )
    {
        self endon( string6 );
    }
    
    if ( isdefined( string7 ) )
    {
        self endon( string7 );
    }
    
    self waittill( string1 );
}

// Namespace utility / scripts\engine\utility
// Params 8
// Checksum 0x0, Offset: 0x2f75
// Size: 0x8e
function waittill_any_8( string1, string2, string3, string4, string5, string6, string7, string8 )
{
    assert( isdefined( string1 ) );
    
    if ( isdefined( string2 ) )
    {
        self endon( string2 );
    }
    
    if ( isdefined( string3 ) )
    {
        self endon( string3 );
    }
    
    if ( isdefined( string4 ) )
    {
        self endon( string4 );
    }
    
    if ( isdefined( string5 ) )
    {
        self endon( string5 );
    }
    
    if ( isdefined( string6 ) )
    {
        self endon( string6 );
    }
    
    if ( isdefined( string7 ) )
    {
        self endon( string7 );
    }
    
    if ( isdefined( string8 ) )
    {
        self endon( string8 );
    }
    
    self waittill( string1 );
}

// Namespace utility / scripts\engine\utility
// Params 8
// Checksum 0x0, Offset: 0x300b
// Size: 0xa2
function waittill_any( string1, string2, string3, string4, string5, string6, string7, string8 )
{
    assertex( issp(), "<dev string:xd6>" );
    assert( isdefined( string1 ) );
    
    if ( isdefined( string2 ) )
    {
        self endon( string2 );
    }
    
    if ( isdefined( string3 ) )
    {
        self endon( string3 );
    }
    
    if ( isdefined( string4 ) )
    {
        self endon( string4 );
    }
    
    if ( isdefined( string5 ) )
    {
        self endon( string5 );
    }
    
    if ( isdefined( string6 ) )
    {
        self endon( string6 );
    }
    
    if ( isdefined( string7 ) )
    {
        self endon( string7 );
    }
    
    if ( isdefined( string8 ) )
    {
        self endon( string8 );
    }
    
    self waittill( string1 );
}

// Namespace utility / scripts\engine\utility
// Params 14
// Checksum 0x0, Offset: 0x30b5
// Size: 0xf1
function waittill_any_ents( ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7 )
{
    assert( isdefined( ent1 ) );
    assert( isdefined( string1 ) );
    
    if ( isdefined( ent2 ) && isdefined( string2 ) )
    {
        ent2 endon( string2 );
    }
    
    if ( isdefined( ent3 ) && isdefined( string3 ) )
    {
        ent3 endon( string3 );
    }
    
    if ( isdefined( ent4 ) && isdefined( string4 ) )
    {
        ent4 endon( string4 );
    }
    
    if ( isdefined( ent5 ) && isdefined( string5 ) )
    {
        ent5 endon( string5 );
    }
    
    if ( isdefined( ent6 ) && isdefined( string6 ) )
    {
        ent6 endon( string6 );
    }
    
    if ( isdefined( ent7 ) && isdefined( string7 ) )
    {
        ent7 endon( string7 );
    }
    
    ent1 waittill( string1 );
}

// Namespace utility / scripts\engine\utility
// Params 15
// Checksum 0x0, Offset: 0x31ae
// Size: 0x107
function function_cf308f348d516c65( delay, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7 )
{
    assert( isdefined( delay ) );
    assert( isdefined( ent1 ) );
    assert( isdefined( string1 ) );
    ent1 endon( string1 );
    
    if ( isdefined( ent2 ) && isdefined( string2 ) )
    {
        ent2 endon( string2 );
    }
    
    if ( isdefined( ent3 ) && isdefined( string3 ) )
    {
        ent3 endon( string3 );
    }
    
    if ( isdefined( ent4 ) && isdefined( string4 ) )
    {
        ent4 endon( string4 );
    }
    
    if ( isdefined( ent5 ) && isdefined( string5 ) )
    {
        ent5 endon( string5 );
    }
    
    if ( isdefined( ent6 ) && isdefined( string6 ) )
    {
        ent6 endon( string6 );
    }
    
    if ( isdefined( ent7 ) && isdefined( string7 ) )
    {
        ent7 endon( string7 );
    }
    
    wait delay;
}

// Namespace utility / scripts\engine\utility
// Params 14
// Checksum 0x0, Offset: 0x32bd
// Size: 0x15f
function waittill_any_ents_return( ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7 )
{
    assert( isdefined( ent1 ) );
    assert( isdefined( string1 ) );
    self endon( "death" );
    ent = spawnstruct();
    ent1 childthread waittill_string( string1, ent );
    
    if ( isdefined( ent2 ) && isdefined( string2 ) )
    {
        ent2 childthread waittill_string( string2, ent );
    }
    
    if ( isdefined( ent3 ) && isdefined( string3 ) )
    {
        ent3 childthread waittill_string( string3, ent );
    }
    
    if ( isdefined( ent4 ) && isdefined( string4 ) )
    {
        ent4 childthread waittill_string( string4, ent );
    }
    
    if ( isdefined( ent5 ) && isdefined( string5 ) )
    {
        ent5 childthread waittill_string( string5, ent );
    }
    
    if ( isdefined( ent6 ) && isdefined( string6 ) )
    {
        ent6 childthread waittill_string( string6, ent );
    }
    
    if ( isdefined( ent7 ) && isdefined( string7 ) )
    {
        ent7 childthread waittill_string( string7, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 14
// Checksum 0x0, Offset: 0x3425
// Size: 0x15f
function function_7b9e0e7ca4b3b940( ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7 )
{
    assert( isdefined( ent1 ) );
    assert( isdefined( string1 ) );
    self endon( "death" );
    ent = spawnstruct();
    ent1 childthread waittill_string_no_endon_death( string1, ent );
    
    if ( isdefined( ent2 ) && isdefined( string2 ) )
    {
        ent2 childthread waittill_string_no_endon_death( string2, ent );
    }
    
    if ( isdefined( ent3 ) && isdefined( string3 ) )
    {
        ent3 childthread waittill_string_no_endon_death( string3, ent );
    }
    
    if ( isdefined( ent4 ) && isdefined( string4 ) )
    {
        ent4 childthread waittill_string_no_endon_death( string4, ent );
    }
    
    if ( isdefined( ent5 ) && isdefined( string5 ) )
    {
        ent5 childthread waittill_string_no_endon_death( string5, ent );
    }
    
    if ( isdefined( ent6 ) && isdefined( string6 ) )
    {
        ent6 childthread waittill_string_no_endon_death( string6, ent );
    }
    
    if ( isdefined( ent7 ) && isdefined( string7 ) )
    {
        ent7 childthread waittill_string_no_endon_death( string7, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x358d
// Size: 0xab
function function_e6583be4abd3e438( ents, string )
{
    assert( isdefined( ents ) );
    assert( isdefined( string ) );
    self endon( "death" );
    dummyent = spawnstruct();
    
    foreach ( ent in ents )
    {
        ent childthread function_67e5ee8add8aafae( string, dummyent );
    }
    
    dummyent waittill( "returned", msg );
    dummyent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 8
// Checksum 0x0, Offset: 0x3641
// Size: 0x106
function waittill_any_ents_array( ents, string1, string2, string3, string4, string5, string6, string7 )
{
    assert( isdefined( ents ) );
    assert( isarray( ents ) );
    assert( isdefined( ents[ 0 ] ) );
    assert( isdefined( string1 ) );
    
    foreach ( ent in ents )
    {
        if ( ent != ents[ 0 ] )
        {
            ent endon( string1 );
        }
        
        if ( isdefined( string2 ) )
        {
            ent endon( string2 );
        }
        
        if ( isdefined( string3 ) )
        {
            ent endon( string3 );
        }
        
        if ( isdefined( string4 ) )
        {
            ent endon( string4 );
        }
        
        if ( isdefined( string5 ) )
        {
            ent endon( string5 );
        }
        
        if ( isdefined( string6 ) )
        {
            ent endon( string6 );
        }
        
        if ( isdefined( string7 ) )
        {
            ent endon( string7 );
        }
    }
    
    ents[ 0 ] waittill( string1 );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x374f
// Size: 0x2c
function wait_time_in_ms( waittimems )
{
    endtimems = gettime() + waittimems;
    
    while ( gettime() < endtimems )
    {
        waitframe();
    }
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x3783
// Size: 0x56, Type: bool
function script_delay()
{
    if ( isdefined( self.script_delay ) )
    {
        wait self.script_delay;
        return true;
    }
    else if ( isdefined( self.script_delay_min ) && isdefined( self.script_delay_max ) )
    {
        wait randomfloatrange( self.script_delay_min, self.script_delay_max );
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x37e2
// Size: 0xd5
function script_wait()
{
    starttime = gettime();
    
    if ( isdefined( self.script_wait ) )
    {
        wait self.script_wait;
        
        if ( isdefined( self.script_wait_add ) )
        {
            self.script_wait += self.script_wait_add;
        }
    }
    else if ( isdefined( self.script_wait_min ) && isdefined( self.script_wait_max ) )
    {
        wait randomfloatrange( self.script_wait_min, self.script_wait_max );
        
        if ( isdefined( self.script_wait_add ) )
        {
            self.script_wait_min += self.script_wait_add;
            self.script_wait_max += self.script_wait_add;
        }
    }
    
    return gettime() - starttime;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x38c0
// Size: 0x34
function ispointinwater( point )
{
    excludearray = [];
    return physics_querypoint( point, 0, physics_createcontents( [ "physicscontents_water" ] ), excludearray, "physicsquery_any" );
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x38fd
// Size: 0x20, Type: bool
function isflashed()
{
    if ( !isdefined( self.flashendtime ) )
    {
        return false;
    }
    
    return gettime() < self.flashendtime;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x3926
// Size: 0x20, Type: bool
function isstunned()
{
    if ( !isdefined( self.stunendtime ) )
    {
        return false;
    }
    
    return gettime() < self.stunendtime;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x394f
// Size: 0x26, Type: bool
function flag_exist( message )
{
    if ( !isdefined( level.flag ) )
    {
        return false;
    }
    
    return isdefined( level.flag[ message ] );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x397e
// Size: 0x31, Type: bool
function flag( message )
{
    assertex( isdefined( message ), "<dev string:x253>" );
    return flag_exist( message ) && level.flag[ message ];
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x39b8
// Size: 0x8c
function flag_init( message )
{
    if ( !isdefined( level.flag ) )
    {
        scripts\engine\flags::init_flags();
    }
    
    /#
        if ( isdefined( level.first_frame ) && level.first_frame == -1 )
        {
            assertex( !isdefined( level.flag[ message ] ), "<dev string:x288>" + message );
        }
    #/
    
    level.flag[ message ] = 0;
    init_trigger_flags();
    
    if ( !isdefined( level.trigger_flags[ message ] ) )
    {
        level.trigger_flags[ message ] = [];
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x3a4c
// Size: 0xb
function empty_init_func( empty )
{
    
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x3a5f
// Size: 0x4c
function flag_set( message, setter )
{
    if ( !flag_exist( message ) )
    {
        flag_init( message );
    }
    
    level.flag[ message ] = 1;
    set_trigger_flag_permissions( message );
    
    if ( isdefined( setter ) )
    {
        level notify( message, setter );
        return;
    }
    
    level notify( message );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x3ab3
// Size: 0x35
function flag_wait( msg )
{
    other = undefined;
    
    while ( !flag( msg ) )
    {
        other = undefined;
        level waittill( msg, other );
    }
    
    if ( isdefined( other ) )
    {
        return other;
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x3af0
// Size: 0x2f
function flag_clear( message )
{
    if ( !flag( message ) )
    {
        return;
    }
    
    level.flag[ message ] = 0;
    set_trigger_flag_permissions( message );
    level notify( message );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x3b27
// Size: 0x1c
function flag_waitopen( msg )
{
    while ( flag( msg ) )
    {
        level waittill( msg );
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x3b4b
// Size: 0x80
function function_ef5098111fa4ae2c( flags )
{
    flags = array_removeundefined( flags );
    
    foreach ( f in flags )
    {
        if ( !flag( f ) )
        {
            return;
        }
    }
    
    while ( true )
    {
        f = level waittill_any_in_array_return( flags );
        
        if ( !flag( f ) )
        {
            return;
        }
    }
}

// Namespace utility / scripts\engine\utility
// Params 8
// Checksum 0x0, Offset: 0x3bd3
// Size: 0x83
function function_254e355bdfc30d6c( flag1, flag2, flag3, flag4, flag5, flag6, flag7, flag8 )
{
    array = [ flag1, flag2, flag3, flag4, flag5, flag6, flag7, flag8 ];
    function_ef5098111fa4ae2c( array );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x3c5e
// Size: 0x3c
function flag_waitopen_either( flag1, flag2 )
{
    while ( true )
    {
        if ( !flag( flag1 ) || !flag( flag2 ) )
        {
            return;
        }
        
        level waittill_any_2( flag1, flag2 );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x3ca2
// Size: 0x1b
function waittill_either( msg1, msg2 )
{
    self endon( msg1 );
    self waittill( msg2 );
    return msg2;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x3cc6
// Size: 0x48
function trigger_on( name, type )
{
    if ( isdefined( name ) && isdefined( type ) )
    {
        ents = getentarray( name, type );
        array_thread( ents, &trigger_on_proc );
        return;
    }
    
    trigger_on_proc();
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x3d16
// Size: 0x13
function trigger_on_proc()
{
    self triggerenable();
    self.trigger_off = undefined;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x3d31
// Size: 0x48
function trigger_off( name, type )
{
    if ( isdefined( name ) && isdefined( type ) )
    {
        ents = getentarray( name, type );
        array_thread( ents, &trigger_off_proc );
        return;
    }
    
    trigger_off_proc();
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x3d81
// Size: 0x32
function trigger_off_proc()
{
    if ( issubstr( self.classname, "trigger" ) )
    {
        self triggerdisable();
    }
    
    self.trigger_off = 1;
    self notify( "trigger_off" );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x3dbb
// Size: 0x4d
function set_trigger_flag_permissions( msg )
{
    if ( !isdefined( level.trigger_flags ) )
    {
        return;
    }
    
    level.trigger_flags[ msg ] = array_removeundefined( level.trigger_flags[ msg ] );
    array_thread( level.trigger_flags[ msg ], &update_trigger_based_on_flags );
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x3e10
// Size: 0x116
function update_trigger_based_on_flags()
{
    true_on = 1;
    
    if ( isdefined( self.script_flag_true ) )
    {
        true_on = 0;
        tokens = create_flags_and_return_tokens( self.script_flag_true );
        
        foreach ( token in tokens )
        {
            if ( flag( token ) )
            {
                true_on = 1;
                break;
            }
        }
    }
    
    false_on = 1;
    
    if ( isdefined( self.script_flag_false ) )
    {
        tokens = create_flags_and_return_tokens( self.script_flag_false );
        
        foreach ( token in tokens )
        {
            if ( flag( token ) )
            {
                false_on = 0;
                break;
            }
        }
    }
    
    [[ level.trigger_func[ true_on && false_on ] ]]();
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x3f2e
// Size: 0x56
function create_flags_and_return_tokens( flags )
{
    tokens = strtok( flags, " " );
    
    for ( i = 0; i < tokens.size ; i++ )
    {
        if ( !isdefined( level.flag[ tokens[ i ] ] ) )
        {
            flag_init( tokens[ i ] );
        }
    }
    
    return tokens;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x3f8d
// Size: 0x43
function init_trigger_flags()
{
    if ( !add_init_script( "trigger_flags", &init_trigger_flags ) )
    {
        return;
    }
    
    level.trigger_flags = [];
    level.trigger_func[ 1 ] = &trigger_on;
    level.trigger_func[ 0 ] = &trigger_off;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x3fd8
// Size: 0x2d5
function addstruct( struct )
{
    assertex( isdefined( level.struct_class_names ), "<dev string:x2b3>" );
    
    if ( isdefined( struct.targetname ) )
    {
        if ( !isdefined( level.struct_class_names[ "targetname" ][ struct.targetname ] ) )
        {
            level.struct_class_names[ "targetname" ][ struct.targetname ] = [];
        }
        
        size = level.struct_class_names[ "targetname" ][ struct.targetname ].size;
        level.struct_class_names[ "targetname" ][ struct.targetname ][ size ] = struct;
    }
    
    if ( isdefined( struct.target ) )
    {
        if ( !isdefined( level.struct_class_names[ "target" ][ struct.target ] ) )
        {
            level.struct_class_names[ "target" ][ struct.target ] = [];
        }
        
        size = level.struct_class_names[ "target" ][ struct.target ].size;
        level.struct_class_names[ "target" ][ struct.target ][ size ] = struct;
    }
    
    if ( isdefined( struct.script_noteworthy ) )
    {
        if ( !isdefined( level.struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ] ) )
        {
            level.struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ] = [];
        }
        
        size = level.struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ].size;
        level.struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ][ size ] = struct;
    }
    
    if ( isdefined( struct.script_linkname ) )
    {
        if ( !isdefined( level.struct_class_names[ "script_linkname" ][ struct.script_linkname ] ) )
        {
            level.struct_class_names[ "script_linkname" ][ struct.script_linkname ] = [];
        }
        
        size = level.struct_class_names[ "script_linkname" ][ struct.script_linkname ].size;
        level.struct_class_names[ "script_linkname" ][ struct.script_linkname ][ size ] = struct;
    }
    
    if ( isdefined( struct.variantname ) )
    {
        if ( !isdefined( level.struct_class_names[ "variantname" ][ struct.variantname ] ) )
        {
            level.struct_class_names[ "variantname" ][ struct.variantname ] = [];
        }
        
        size = level.struct_class_names[ "variantname" ][ struct.variantname ].size;
        level.struct_class_names[ "variantname" ][ struct.variantname ][ size ] = struct;
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x42b5
// Size: 0x119
function getstruct( name, type )
{
    assertex( isdefined( name ) && isdefined( type ), "<dev string:x2e6>" );
    assertex( isdefined( level.struct_class_names ), "<dev string:x307>" );
    array = level.struct_class_names[ type ][ name ];
    
    if ( !isdefined( array ) )
    {
        return undefined;
    }
    
    if ( array.size > 1 )
    {
        if ( isdefined( array[ 0 ] ) && isdefined( array[ 0 ].origin ) )
        {
            originstr1 = "" + array[ 0 ].origin;
        }
        else
        {
            originstr1 = "<UNKNOWN>";
        }
        
        if ( isdefined( array[ 1 ] ) && isdefined( array[ 1 ].origin ) )
        {
            originstr2 = "" + array[ 1 ].origin;
        }
        else
        {
            originstr2 = "<UNKNOWN>";
        }
        
        assertmsg( "<dev string:x33a>" + type + "<dev string:x36f>" + name + "<dev string:x37d>" + originstr1 + "<dev string:x3b3>" + originstr2 );
        return undefined;
    }
    
    return array[ 0 ];
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x43d7
// Size: 0x69
function getstructarray( name, type )
{
    if ( !isdefined( level.struct_class_names ) )
    {
        assertex( isdefined( level.struct_class_names ), "<dev string:x307>" );
        return [];
    }
    
    if ( !isdefined( type ) || !isdefined( name ) )
    {
        return [];
    }
    
    array = level.struct_class_names[ type ][ name ];
    
    if ( !isdefined( array ) )
    {
        return [];
    }
    
    return array;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x4449
// Size: 0x22b
function function_e89fc5f3b8084c2b( struct )
{
    if ( !isdefined( struct.var_88446e27ec9c8ed7 ) )
    {
        return;
    }
    
    if ( !isdefined( level._fx ) )
    {
        level._fx = spawnstruct();
    }
    
    if ( !isdefined( level._fx.ambientwar ) )
    {
        level._fx.ambientwar = spawnstruct();
    }
    
    if ( !isdefined( level._fx.ambientwar.nodes ) )
    {
        level._fx.ambientwar.nodes = [];
    }
    
    if ( !isdefined( level._fx.ambientwar.nodes[ struct.var_88446e27ec9c8ed7 ] ) )
    {
        level._fx.ambientwar.nodes[ struct.var_88446e27ec9c8ed7 ] = [];
    }
    
    node = spawnstruct();
    node.origin = struct.origin;
    node.angles = struct.angles;
    
    if ( isdefined( struct.var_9e2bbe262ca3c265 ) )
    {
        node.var_9e2bbe262ca3c265 = struct.var_9e2bbe262ca3c265;
    }
    
    if ( isdefined( struct.var_975a876c9c8ced9d ) )
    {
        node.var_975a876c9c8ced9d = struct.var_975a876c9c8ced9d;
    }
    
    if ( isdefined( struct.var_48f95e175a12d9c4 ) )
    {
        node.var_48f95e175a12d9c4 = struct.var_48f95e175a12d9c4;
    }
    
    if ( isdefined( struct.var_22ff57eef960b294 ) )
    {
        node.var_22ff57eef960b294 = struct.var_22ff57eef960b294;
    }
    
    level._fx.ambientwar.nodes[ struct.var_88446e27ec9c8ed7 ][ level._fx.ambientwar.nodes[ struct.var_88446e27ec9c8ed7 ].size ] = node;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x467c
// Size: 0xa7
function add_smartobject_point( struct )
{
    if ( !isdefined( anim.smartobjectpoints ) )
    {
        anim.smartobjectpoints = [];
    }
    
    anim.smartobjectpoints[ anim.smartobjectpoints.size ] = struct;
    volumeidx = function_6bf2b684ed87ad5e( struct.origin );
    
    if ( !isdefined( volumeidx ) )
    {
        return;
    }
    
    if ( !isdefined( anim.var_463c0093dff0f81c ) )
    {
        anim.var_463c0093dff0f81c = [];
    }
    
    if ( !isdefined( anim.var_463c0093dff0f81c[ volumeidx ] ) )
    {
        anim.var_463c0093dff0f81c[ volumeidx ] = [];
    }
    
    anim.var_463c0093dff0f81c[ volumeidx ][ anim.var_463c0093dff0f81c[ volumeidx ].size ] = struct;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x472b
// Size: 0x111
function store_linked_smartobjects()
{
    if ( !isdefined( anim.smartobjectpoints ) )
    {
        return;
    }
    
    foreach ( obj in anim.smartobjectpoints )
    {
        if ( isdefined( obj.script_linkto ) )
        {
            structs = obj get_linked_structs();
            
            foreach ( linkedstruct in structs )
            {
                if ( linkedstruct == obj )
                {
                    continue;
                }
                
                if ( !isdefined( linkedstruct.script_smartobject ) )
                {
                    continue;
                }
                
                if ( !isdefined( obj.linkedsmartobjects ) )
                {
                    obj.linkedsmartobjects = [];
                }
                
                obj.linkedsmartobjects[ obj.linkedsmartobjects.size ] = linkedstruct;
            }
        }
    }
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x4844
// Size: 0x27e
function init_struct_class()
{
    if ( !add_init_script( "struct_classes", &init_struct_class ) )
    {
        return;
    }
    
    level.struct_class_names = [];
    level.struct_class_names[ "target" ] = [];
    level.struct_class_names[ "targetname" ] = [];
    level.struct_class_names[ "script_noteworthy" ] = [];
    level.struct_class_names[ "script_linkname" ] = [];
    level.struct_class_names[ "variantname" ] = [];
    level.struct_exploders = [];
    level.struct_fakeactors = [];
    level.var_f99b1d319e65854c = [];
    level.var_a0b4eb1703be349a = [];
    filterfunc = level.struct_filter;
    hasfilterfunc = isdefined( filterfunc );
    
    foreach ( index, struct in level.struct )
    {
        if ( istrue( struct.var_d63b146db6138e15 ) )
        {
            continue;
        }
        
        if ( isdefined( struct.script_smartobject ) )
        {
            add_smartobject_point( struct );
        }
        
        if ( hasfilterfunc && ![[ filterfunc ]]( struct ) )
        {
            continue;
        }
        
        if ( isdefined( struct.targetname ) && struct.targetname == "delete_on_load" )
        {
            continue;
        }
        
        if ( isdefined( struct.script_prefab_exploder ) || isdefined( struct.script_exploder ) )
        {
            level.struct_exploders[ level.struct_exploders.size ] = struct;
        }
        
        if ( isdefined( struct.script_fakeactor_node ) )
        {
            level.struct_fakeactors[ level.struct_fakeactors.size ] = struct;
        }
        
        if ( isdefined( struct.script_scenescriptbundle ) )
        {
            level.var_f99b1d319e65854c[ level.var_f99b1d319e65854c.size ] = struct.script_scenescriptbundle;
            level.var_a0b4eb1703be349a[ level.var_a0b4eb1703be349a.size ] = struct;
        }
        
        if ( isdefined( struct.script_noteworthy ) && struct.script_noteworthy == "vfx_ambientwar_node" )
        {
            function_e89fc5f3b8084c2b( struct );
            continue;
        }
        
        addstruct( struct );
        level.struct[ index ] = undefined;
    }
    
    level.struct = undefined;
    
    if ( isdefined( level.var_b32e30f2a469bc5c ) )
    {
        level thread [[ level.var_b32e30f2a469bc5c ]]();
        level.var_b32e30f2a469bc5c = undefined;
    }
    
    store_linked_smartobjects();
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x4aca
// Size: 0x38
function deletestructarray( value, key, delay )
{
    structs = getstructarray( value, key );
    deletestructarray_ref( structs, delay );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x4b0a
// Size: 0x35c
function deletestruct_ref( struct )
{
    if ( !isdefined( struct ) )
    {
        return;
    }
    
    value = struct.script_linkname;
    
    if ( isdefined( value ) && isdefined( level.struct_class_names[ "script_linkname" ] ) && isdefined( level.struct_class_names[ "script_linkname" ][ value ] ) )
    {
        foreach ( i, _struct in level.struct_class_names[ "script_linkname" ][ value ] )
        {
            if ( isdefined( _struct ) && struct == _struct )
            {
                level.struct_class_names[ "script_linkname" ][ value ][ i ] = undefined;
            }
        }
        
        if ( level.struct_class_names[ "script_linkname" ][ value ].size == 0 )
        {
            level.struct_class_names[ "script_linkname" ][ value ] = undefined;
        }
    }
    
    value = struct.script_noteworthy;
    
    if ( isdefined( value ) && isdefined( level.struct_class_names[ "script_noteworthy" ] ) && isdefined( level.struct_class_names[ "script_noteworthy" ][ value ] ) )
    {
        foreach ( i, _struct in level.struct_class_names[ "script_noteworthy" ][ value ] )
        {
            if ( isdefined( _struct ) && struct == _struct )
            {
                level.struct_class_names[ "script_noteworthy" ][ value ][ i ] = undefined;
            }
        }
        
        if ( level.struct_class_names[ "script_noteworthy" ][ value ].size == 0 )
        {
            level.struct_class_names[ "script_noteworthy" ][ value ] = undefined;
        }
    }
    
    value = struct.target;
    
    if ( isdefined( value ) && isdefined( level.struct_class_names[ "target" ] ) && isdefined( level.struct_class_names[ "target" ][ value ] ) )
    {
        foreach ( i, _struct in level.struct_class_names[ "target" ][ value ] )
        {
            if ( isdefined( _struct ) && struct == _struct )
            {
                level.struct_class_names[ "target" ][ value ][ i ] = undefined;
            }
        }
        
        if ( level.struct_class_names[ "target" ][ value ].size == 0 )
        {
            level.struct_class_names[ "target" ][ value ] = undefined;
        }
    }
    
    value = struct.targetname;
    
    if ( isdefined( value ) && isdefined( level.struct_class_names[ "targetname" ] ) && isdefined( level.struct_class_names[ "targetname" ][ value ] ) )
    {
        foreach ( i, _struct in level.struct_class_names[ "targetname" ][ value ] )
        {
            if ( isdefined( _struct ) && struct == _struct )
            {
                level.struct_class_names[ "targetname" ][ value ][ i ] = undefined;
            }
        }
        
        if ( level.struct_class_names[ "targetname" ][ value ].size == 0 )
        {
            level.struct_class_names[ "targetname" ][ value ] = undefined;
        }
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x4e6e
// Size: 0xe3
function deletestructarray_ref( structs, delay )
{
    if ( !isdefined( structs ) || !isarray( structs ) || structs.size == 0 )
    {
        return;
    }
    
    delay = ter_op( isdefined( delay ), delay, 0 );
    delay = ter_op( delay > 0, delay, 0 );
    
    if ( delay > 0 )
    {
        foreach ( struct in structs )
        {
            deletestruct_ref( struct );
            wait delay;
        }
        
        return;
    }
    
    foreach ( struct in structs )
    {
        deletestruct_ref( struct );
    }
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x4f59
// Size: 0x39
function getstructarray_delete( value, key, delay )
{
    structs = getstructarray( value, key );
    deletestructarray_ref( structs, delay );
    return structs;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x4f9b
// Size: 0x55
function function_a5079b5837467402( name, key, ignore_spawners )
{
    ents = getentarray( name, key, default_to( ignore_spawners, 0 ) );
    
    if ( isdefined( level.struct_class_names ) )
    {
        ents = array_combine( ents, getstructarray( name, key ) );
    }
    
    return ents;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x4ff9
// Size: 0x45
function getent_or_struct( name, key, ignore_spawners )
{
    ent = getent( name, key, default_to( ignore_spawners, 0 ) );
    
    if ( isdefined( ent ) )
    {
        return ent;
    }
    
    return getstruct( name, key );
}

/#

    // Namespace utility / scripts\engine\utility
    // Params 1
    // Checksum 0x0, Offset: 0x5047
    // Size: 0x3a, Type: dev
    function fileprint_start( file )
    {
        filename = file;
        level.fileprint = 1;
        level.fileprintlinecount = 0;
        level.fileprint_filename = filename;
    }

    // Namespace utility / scripts\engine\utility
    // Params 0
    // Checksum 0x0, Offset: 0x5089
    // Size: 0x18, Type: dev
    function fileprint_map_start()
    {
        level.fileprint_mapentcount = 0;
        fileprint_map_header( 1 );
    }

#/

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x50a9
// Size: 0x5e
function fileprint_map_header( binclude_blank_worldspawn )
{
    if ( !isdefined( binclude_blank_worldspawn ) )
    {
        binclude_blank_worldspawn = 0;
    }
    
    /#
        fileprint_launcher( "<dev string:x3bc>" );
        fileprint_launcher( "<dev string:x3c7>" );
        fileprint_launcher( "<dev string:x3e5>" );
        
        if ( !binclude_blank_worldspawn )
        {
            return;
        }
        
        fileprint_map_entity_start();
        fileprint_map_keypairprint( "<dev string:x3f8>", "<dev string:x405>" );
        fileprint_map_entity_end();
    #/
}

/#

    // Namespace utility / scripts\engine\utility
    // Params 2
    // Checksum 0x0, Offset: 0x510f
    // Size: 0x32, Type: dev
    function fileprint_map_keypairprint( key1, key2 )
    {
        fileprint_launcher( "<dev string:x413>" + key1 + "<dev string:x418>" + key2 + "<dev string:x413>" );
    }

    // Namespace utility / scripts\engine\utility
    // Params 0
    // Checksum 0x0, Offset: 0x5149
    // Size: 0x68, Type: dev
    function fileprint_map_entity_start()
    {
        assert( isdefined( level.fileprint_mapentcount ), "<dev string:x41f>" );
        assert( !isdefined( level.fileprint_entitystart ) );
        level.fileprint_entitystart = 1;
        fileprint_launcher( "<dev string:x457>" + level.fileprint_mapentcount );
        fileprint_launcher( "<dev string:x462>" );
        level.fileprint_mapentcount++;
    }

    // Namespace utility / scripts\engine\utility
    // Params 0
    // Checksum 0x0, Offset: 0x51b9
    // Size: 0x1b, Type: dev
    function fileprint_map_entity_end()
    {
        fileprint_launcher( "<dev string:x467>" );
        level.fileprint_entitystart = undefined;
    }

    // Namespace utility / scripts\engine\utility
    // Params 1
    // Checksum 0x0, Offset: 0x51dc
    // Size: 0x41, Type: dev
    function fileprint_radiant_vec( vector )
    {
        string = "<dev string:x46c>" + vector[ 0 ] + "<dev string:x470>" + vector[ 1 ] + "<dev string:x470>" + vector[ 2 ] + "<dev string:x46c>";
        return string;
    }

#/

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x5225
// Size: 0x2f
function call_on_notify_no_endon_death( notifystring, method, param1, param2 )
{
    childthread call_on_notify_proc( notifystring, method, param1, param2 );
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x525c
// Size: 0x3f
function call_on_notify( notifystring, method, param1, param2, param3 )
{
    self endon( "death" );
    childthread call_on_notify_proc( notifystring, method, param1, param2, param3 );
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x52a3
// Size: 0x65
function call_on_notify_proc( notifystring, method, param1, param2, param3 )
{
    self waittill( notifystring );
    
    if ( isdefined( param3 ) )
    {
        self builtin [[ method ]]( param1, param2, param3 );
        return;
    }
    
    if ( isdefined( param2 ) )
    {
        self builtin [[ method ]]( param1, param2 );
        return;
    }
    
    if ( isdefined( param1 ) )
    {
        self builtin [[ method ]]( param1 );
        return;
    }
    
    self builtin [[ method ]]();
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x5310
// Size: 0x38
function thread_on_notify_no_endon_death( notifystring, function, param1, param2, ent )
{
    childthread thread_on_notify_proc( notifystring, function, param1, param2, ent );
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0x5350
// Size: 0x112
function thread_on_notify( notifystring, function, param1, param2, ent, endonentities, endonmessages )
{
    self endon( "death" );
    
    if ( isdefined( endonentities ) && isdefined( endonmessages ) )
    {
        if ( !isarray( endonentities ) )
        {
            endonentities = [ endonentities ];
        }
        
        if ( !isarray( endonmessages ) )
        {
            endonmessages = [ endonmessages ];
        }
        
        foreach ( entity in endonentities )
        {
            foreach ( message in endonmessages )
            {
                entity endon( message );
            }
        }
    }
    
    childthread thread_on_notify_proc( notifystring, function, param1, param2, ent );
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x546a
// Size: 0x5c
function thread_on_notify_proc( notifystring, function, param1, param2, ent )
{
    self waittill( notifystring );
    
    if ( !isdefined( ent ) )
    {
        ent = self;
    }
    
    if ( isdefined( param2 ) )
    {
        ent thread [[ function ]]( param1, param2 );
        return;
    }
    
    if ( isdefined( param1 ) )
    {
        ent thread [[ function ]]( param1 );
        return;
    }
    
    ent thread [[ function ]]();
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0x54ce
// Size: 0x108
function function_fb7b452e8dd1dddc( notifystring, function, params, ent, endonentities, endonmessages )
{
    self endon( "death" );
    
    if ( isdefined( endonentities ) && isdefined( endonmessages ) )
    {
        if ( !isarray( endonentities ) )
        {
            endonentities = [ endonentities ];
        }
        
        if ( !isarray( endonmessages ) )
        {
            endonmessages = [ endonmessages ];
        }
        
        foreach ( entity in endonentities )
        {
            foreach ( message in endonmessages )
            {
                entity endon( message );
            }
        }
    }
    
    childthread function_399a710b148277ad( notifystring, function, params, ent );
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x55de
// Size: 0x17b
function function_399a710b148277ad( notifystring, function, params, ent )
{
    self waittill( notifystring );
    
    if ( !isdefined( ent ) )
    {
        ent = self;
    }
    
    if ( !isdefined( params ) )
    {
        ent thread [[ function ]]();
    }
    
    switch ( params.size )
    {
        case 0:
            ent thread [[ function ]]();
            break;
        case 1:
            ent thread [[ function ]]( params[ 0 ] );
            break;
        case 2:
            ent thread [[ function ]]( params[ 0 ], params[ 1 ] );
            break;
        case 3:
            ent thread [[ function ]]( params[ 0 ], params[ 1 ], params[ 2 ] );
            break;
        case 4:
            ent thread [[ function ]]( params[ 0 ], params[ 1 ], params[ 2 ], params[ 3 ] );
            break;
        case 5:
            ent thread [[ function ]]( params[ 0 ], params[ 1 ], params[ 2 ], params[ 3 ], params[ 4 ] );
            break;
        case 6:
            ent thread [[ function ]]( params[ 0 ], params[ 1 ], params[ 2 ], params[ 3 ], params[ 4 ], params[ 5 ] );
            break;
        case 7:
            ent thread [[ function ]]( params[ 0 ], params[ 1 ], params[ 2 ], params[ 3 ], params[ 4 ], params[ 5 ], params[ 6 ] );
            break;
        default:
            assertmsg( "<dev string:x475>" + params.size + "<dev string:x4b4>" );
            break;
    }
}

// Namespace utility / scripts\engine\utility
// Params 14
// Checksum 0x0, Offset: 0x5761
// Size: 0x92
function delaycall( timer, func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12 )
{
    thread delaycall_proc( func, undefined, timer, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12 );
}

// Namespace utility / scripts\engine\utility
// Params 15
// Checksum 0x0, Offset: 0x57fb
// Size: 0x9b
function delaycallendon( timer, endonevent, func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12 )
{
    thread delaycall_proc( func, endonevent, timer, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12 );
}

// Namespace utility / scripts\engine\utility
// Params 15
// Checksum 0x0, Offset: 0x589e
// Size: 0x25a
function delaycall_proc( func, endonevent, timer, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12 )
{
    if ( issp() || iscp() )
    {
        self endon( "death" );
        self endon( "stop_delay_call" );
    }
    
    if ( isdefined( endonevent ) )
    {
        if ( !isarray( endonevent ) )
        {
            endonevent = [ endonevent ];
        }
        
        foreach ( endonname in endonevent )
        {
            self endon( endonname );
        }
    }
    
    wait timer;
    
    if ( isdefined( param12 ) )
    {
        self builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12 );
        return;
    }
    
    if ( isdefined( param11 ) )
    {
        self builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 );
        return;
    }
    
    if ( isdefined( param10 ) )
    {
        self builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 );
        return;
    }
    
    if ( isdefined( param9 ) )
    {
        self builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9 );
        return;
    }
    
    if ( isdefined( param8 ) )
    {
        self builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8 );
        return;
    }
    
    if ( isdefined( param7 ) )
    {
        self builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7 );
        return;
    }
    
    if ( isdefined( param6 ) )
    {
        self builtin [[ func ]]( param1, param2, param3, param4, param5, param6 );
        return;
    }
    
    if ( isdefined( param5 ) )
    {
        self builtin [[ func ]]( param1, param2, param3, param4, param5 );
        return;
    }
    
    if ( isdefined( param4 ) )
    {
        self builtin [[ func ]]( param1, param2, param3, param4 );
        return;
    }
    
    if ( isdefined( param3 ) )
    {
        self builtin [[ func ]]( param1, param2, param3 );
        return;
    }
    
    if ( isdefined( param2 ) )
    {
        self builtin [[ func ]]( param1, param2 );
        return;
    }
    
    if ( isdefined( param1 ) )
    {
        self builtin [[ func ]]( param1 );
        return;
    }
    
    self builtin [[ func ]]();
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x5b00
// Size: 0x1a
function string_starts_with( string, start )
{
    return isstartstr( string, start );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x5b23
// Size: 0x82
function string_join( str_array, separator )
{
    assertex( isdefined( str_array ), "<dev string:x4e6>" );
    assertex( isdefined( str_array.size > 0 ), "<dev string:x500>" );
    separator = default_to( separator, "" );
    str = "";
    
    for ( i = 0; i < str_array.size - 1 ; i++ )
    {
        str += str_array[ i ] + separator;
    }
    
    return str + str_array[ str_array.size - 1 ];
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x5bae
// Size: 0x9e
function string_split( str, separator )
{
    assertex( isdefined( str ), "<dev string:x51f>" );
    assertex( isdefined( separator ), "<dev string:x536>" );
    
    if ( str.size == 0 )
    {
        return [];
    }
    
    array = [];
    start_index = 0;
    
    for ( i = 0; i < str.size ; i++ )
    {
        if ( str[ i ] == separator )
        {
            array = array_add( array, getsubstr( str, start_index, i ) );
            start_index = i + 1;
        }
    }
    
    array = array_add( array, getsubstr( str, start_index, str.size ) );
    return array;
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x5c55
// Size: 0x90
function plot_points( plotpoints, r, g, b, timer )
{
    lastpoint = plotpoints[ 0 ];
    
    if ( !isdefined( r ) )
    {
        r = 1;
    }
    
    if ( !isdefined( g ) )
    {
        g = 1;
    }
    
    if ( !isdefined( b ) )
    {
        b = 1;
    }
    
    if ( !isdefined( timer ) )
    {
        timer = 0.05;
    }
    
    for ( i = 1; i < plotpoints.size ; i++ )
    {
        thread draw_line_for_time( lastpoint, plotpoints[ i ], r, g, b, timer );
        lastpoint = plotpoints[ i ];
    }
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0x5ced
// Size: 0x75
function draw_line_for_time( org1, org2, r, g, b, timer, endonevent )
{
    if ( isdefined( endonevent ) )
    {
        level endon( endonevent );
    }
    
    timer = gettime() + timer * 1000;
    
    while ( gettime() < timer )
    {
        /#
            line( org1, org2, ( r, g, b ), 1 );
        #/
        
        wait 0.05;
    }
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0x5d6a
// Size: 0x13c
function draw_circle( center, radius, color, alpha, depthtest, duration )
{
    circle_sides = 16;
    anglefrac = 360 / circle_sides;
    circlepoints = [];
    
    for ( i = 0; i < circle_sides ; i++ )
    {
        angle = anglefrac * i;
        xadd = cos( angle ) * radius;
        yadd = sin( angle ) * radius;
        x = center[ 0 ] + xadd;
        y = center[ 1 ] + yadd;
        z = center[ 2 ];
        circlepoints[ circlepoints.size ] = ( x, y, z );
    }
    
    for ( i = 0; i < circlepoints.size ; i++ )
    {
        start = circlepoints[ i ];
        
        if ( i + 1 >= circlepoints.size )
        {
            end = circlepoints[ 0 ];
        }
        else
        {
            end = circlepoints[ i + 1 ];
        }
        
        /#
            line( start, end, color, alpha, depthtest, duration );
        #/
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x5eae
// Size: 0x1a
function array_add( array, object )
{
    array[ array.size ] = object;
    return array;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x5ed1
// Size: 0x2e
function array_add_safe( array, object )
{
    if ( !isdefined( object ) )
    {
        return array;
    }
    
    if ( !isdefined( array ) )
    {
        array[ 0 ] = object;
    }
    else
    {
        array[ array.size ] = object;
    }
    
    return array;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x5f08
// Size: 0x2e
function function_6d6af8144a5131f1( array, object )
{
    array = default_to( array, [] );
    
    if ( !arraycontains( array, object ) )
    {
        array[ array.size ] = object;
    }
    
    return array;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x5f3f
// Size: 0x5b
function array_delete( array )
{
    foreach ( ent in array )
    {
        if ( isdefined( ent ) )
        {
            ent delete();
        }
    }
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x5fa2
// Size: 0x76
function array_insert( array, object, index )
{
    if ( index == array.size )
    {
        temp = array;
        temp[ temp.size ] = object;
        return temp;
    }
    
    temp = [];
    offset = 0;
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( i == index )
        {
            temp[ i ] = object;
            offset = 1;
        }
        
        temp[ i + offset ] = array[ i ];
    }
    
    return temp;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x6021
// Size: 0x85
function function_ef4b3df86351aa00( array1, array2, index )
{
    assertex( index >= 0, "<dev string:x553>" );
    
    for ( i = array1.size + array2.size - 1; true ; i-- )
    {
        if ( i < index + array2.size )
        {
            for ( j = array2.size - 1; j >= 0 ; j-- )
            {
                array1[ i ] = array2[ j ];
                i--;
            }
            
            return array1;
        }
        
        array1[ i ] = array1[ i - array2.size ];
    }
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x60ae
// Size: 0x1af
function array_combine( array1, array2, array3, array4, array5 )
{
    array = [];
    
    if ( isdefined( array1 ) )
    {
        foreach ( item in array1 )
        {
            array[ array.size ] = item;
        }
    }
    
    if ( isdefined( array2 ) )
    {
        foreach ( item in array2 )
        {
            array[ array.size ] = item;
        }
    }
    
    if ( isdefined( array3 ) )
    {
        foreach ( item in array3 )
        {
            array[ array.size ] = item;
        }
    }
    
    if ( isdefined( array4 ) )
    {
        foreach ( item in array4 )
        {
            array[ array.size ] = item;
        }
    }
    
    if ( isdefined( array5 ) )
    {
        foreach ( item in array5 )
        {
            array[ array.size ] = item;
        }
    }
    
    return array;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x6266
// Size: 0xa6
function array_combine_multiple( arr2d )
{
    arr1d = [];
    
    foreach ( arr in arr2d )
    {
        foreach ( item in arr )
        {
            arr1d[ arr1d.size ] = item;
        }
    }
    
    return arr1d;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x6315
// Size: 0xb8
function array_combine_unique( array1, array2 )
{
    array3 = [];
    
    foreach ( item in array1 )
    {
        array3[ array3.size ] = item;
    }
    
    foreach ( item in array2 )
    {
        if ( arraycontains( array3, item ) )
        {
            continue;
        }
        
        array3[ array3.size ] = item;
    }
    
    return array3;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x63d6
// Size: 0x64
function array_combine_unique_keys( array1, array2 )
{
    foreach ( key, item in array2 )
    {
        if ( !isdefined( array1[ key ] ) )
        {
            array1[ key ] = item;
        }
    }
    
    return array1;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x6443
// Size: 0xbc
function array_combine_non_integer_indices( array1, array2 )
{
    array3 = [];
    
    foreach ( index, item in array1 )
    {
        assert( !isdefined( array3[ index ] ) );
        array3[ index ] = item;
    }
    
    foreach ( index, item in array2 )
    {
        assert( !isdefined( array3[ index ] ) );
        array3[ index ] = item;
    }
    
    return array3;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x6508
// Size: 0x73
function array_intersection( array1, array2 )
{
    array3 = [];
    
    foreach ( item in array1 )
    {
        if ( arraycontains( array2, item ) )
        {
            array3[ array3.size ] = item;
        }
    }
    
    return array3;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x6584
// Size: 0x73
function array_difference( array1, array2 )
{
    array3 = [];
    
    foreach ( item in array1 )
    {
        if ( !arraycontains( array2, item ) )
        {
            array3[ array3.size ] = item;
        }
    }
    
    return array3;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x6600
// Size: 0x61
function array_convert_keys_to_ints( array )
{
    intarray = [];
    
    foreach ( item in array )
    {
        intarray[ intarray.size ] = item;
    }
    
    return intarray;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x666a
// Size: 0x2a
function array_random( array )
{
    if ( array.size > 0 )
    {
        random_index = randomint( array.size );
        return array[ random_index ];
    }
    
    return undefined;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x669d
// Size: 0x54
function array_randomize( array )
{
    for ( i = 0; i < array.size - 1 ; i++ )
    {
        j = randomintrange( i, array.size );
        temp = array[ i ];
        array[ i ] = array[ j ];
        array[ j ] = temp;
    }
    
    return array;
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x66fa
// Size: 0xd3
function function_1bb9ae4b5f3e2ab( array, seed, a, c, m )
{
    if ( !isdefined( array ) || !isdefined( seed ) )
    {
        assertmsg( "<dev string:x57e>" );
        return [];
    }
    
    x = seed;
    a = default_to( a, 29 );
    c = default_to( c, 19 );
    m = default_to( m, int( max( array.size, 41 ) ) );
    
    for ( i = 0; i < array.size ; i++ )
    {
        x = ( x * a + c ) % m;
        randval = x % array.size;
        tmp = array[ i ];
        array[ i ] = array[ randval ];
        array[ randval ] = tmp;
    }
    
    return array;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x67d6
// Size: 0xd3
function array_randomize_objects( array )
{
    randomarray = [];
    
    for ( temparray = array; temparray.size > 0 ; temparray = newarray )
    {
        randomindex = randomintrange( 0, temparray.size );
        newarray = [];
        arraycount = 0;
        
        foreach ( key, object in temparray )
        {
            if ( arraycount == randomindex )
            {
                randomarray[ ter_op( isstring( key ), key, randomarray.size ) ] = object;
            }
            else
            {
                newarray[ ter_op( isstring( key ), key, newarray.size ) ] = object;
            }
            
            arraycount++;
        }
    }
    
    return randomarray;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x68b2
// Size: 0x3c
function array_reverse( array )
{
    array2 = [];
    
    for ( i = array.size - 1; i >= 0 ; i-- )
    {
        array2[ array2.size ] = array[ i ];
    }
    
    return array2;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x68f7
// Size: 0x93
function array_slice( array, startindex, endindex )
{
    assert( isdefined( array ) && isarray( array ) );
    assert( isdefined( startindex ) );
    
    if ( array.size <= 0 )
    {
        return [];
    }
    
    if ( !isdefined( endindex ) || endindex > array.size )
    {
        endindex = array.size;
    }
    
    if ( startindex == 0 && endindex == array.size )
    {
        return array;
    }
    
    slicedarray = [];
    
    for ( index = startindex; index < endindex ; index++ )
    {
        slicedarray[ slicedarray.size ] = array[ index ];
    }
    
    return slicedarray;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x6993
// Size: 0x1a
function array_contains( array, compare )
{
    return arraycontains( array, compare );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x69b6
// Size: 0x3b, Type: bool
function array_contains_key( array, key )
{
    assertex( isarray( array ), "<dev string:x5c3>" );
    assertex( isdefined( key ), "<dev string:x5f1>" );
    return isdefined( array[ key ] );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x69fa
// Size: 0x60
function array_find( array, item )
{
    foreach ( idx, test in array )
    {
        if ( test == item )
        {
            return idx;
        }
    }
    
    return undefined;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x6a63
// Size: 0x1a
function array_remove( ents, remover )
{
    return arrayremove( ents, remover );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x6a86
// Size: 0x51
function array_exclude( array, arrayexclude )
{
    newarray = array;
    
    for ( i = 0; i < arrayexclude.size ; i++ )
    {
        if ( arraycontains( array, arrayexclude[ i ] ) )
        {
            newarray = array_remove( newarray, arrayexclude[ i ] );
        }
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x6ae0
// Size: 0x62
function array_remove_array( ents, remover_array )
{
    foreach ( remover in remover_array )
    {
        ents = array_remove( ents, remover );
    }
    
    return ents;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x6b4b
// Size: 0x92
function array_remove_index( array, index, var_ca8b90cd9c832fd9 )
{
    newarray = [];
    
    foreach ( arrayindex, value in array )
    {
        if ( arrayindex == index )
        {
            continue;
        }
        
        if ( istrue( var_ca8b90cd9c832fd9 ) )
        {
            newarray_index = arrayindex;
        }
        else
        {
            newarray_index = newarray.size;
        }
        
        newarray[ newarray_index ] = value;
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x6be6
// Size: 0x87
function array_removeundefined( array, keepkeys )
{
    newarray = [];
    keepkeys = default_to( keepkeys, 0 );
    
    foreach ( i, member in array )
    {
        if ( !isdefined( member ) )
        {
            continue;
        }
        
        if ( keepkeys )
        {
            newarray[ i ] = member;
            continue;
        }
        
        newarray[ newarray.size ] = member;
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x6c76
// Size: 0x92
function function_fdc9d5557c53078e( array, keepkeys )
{
    newarray = [];
    keepkeys = default_to( keepkeys, 0 );
    
    foreach ( i, member in array )
    {
        if ( !isdefined( member ) || !isalive( member ) )
        {
            continue;
        }
        
        if ( keepkeys )
        {
            newarray[ i ] = member;
            continue;
        }
        
        newarray[ newarray.size ] = member;
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x6d11
// Size: 0x8b
function array_removedead( array, keepkeys )
{
    newarray = [];
    keepkeys = default_to( keepkeys, 0 );
    
    foreach ( i, member in array )
    {
        if ( !isalive( member ) )
        {
            continue;
        }
        
        if ( keepkeys )
        {
            newarray[ i ] = member;
            continue;
        }
        
        newarray[ newarray.size ] = member;
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x6da5
// Size: 0x71
function array_remove_key( array, var_b3e77f92460be011 )
{
    newarray = [];
    
    foreach ( key, item in array )
    {
        if ( var_b3e77f92460be011 == key )
        {
            continue;
        }
        
        newarray[ key ] = item;
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x6e1f
// Size: 0x76
function array_remove_duplicates( array )
{
    array_unique = [];
    
    foreach ( item in array )
    {
        if ( !isdefined( item ) )
        {
            continue;
        }
        
        if ( arraycontains( array_unique, item ) )
        {
            continue;
        }
        
        array_unique[ array_unique.size ] = item;
    }
    
    return array_unique;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x6e9e
// Size: 0x52
function array_get_first_item( array )
{
    foreach ( item in array )
    {
        return item;
    }
    
    return undefined;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x6ef9
// Size: 0x5e
function function_350e192b13bea45c( array )
{
    last_item = undefined;
    
    foreach ( item in array )
    {
        last_item = item;
    }
    
    return last_item;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x6f60
// Size: 0x94
function function_57091b2d67654a14( array, remover )
{
    result = [];
    removed = 0;
    
    foreach ( item in array_reverse( array ) )
    {
        if ( !removed && item == remover )
        {
            removed = 1;
            continue;
        }
        
        result[ result.size ] = item;
    }
    
    return array_reverse( result );
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x6ffd
// Size: 0x162
function array_levelthread( array, process, var1, var2, var3 )
{
    if ( isdefined( var3 ) )
    {
        foreach ( ent in array )
        {
            thread [[ process ]]( ent, var1, var2, var3 );
        }
        
        return;
    }
    
    if ( isdefined( var2 ) )
    {
        foreach ( ent in array )
        {
            thread [[ process ]]( ent, var1, var2 );
        }
        
        return;
    }
    
    if ( isdefined( var1 ) )
    {
        foreach ( ent in array )
        {
            thread [[ process ]]( ent, var1 );
        }
        
        return;
    }
    
    foreach ( ent in array )
    {
        thread [[ process ]]( ent );
    }
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x7167
// Size: 0x162
function array_levelcall( array, process, var1, var2, var3 )
{
    if ( isdefined( var3 ) )
    {
        foreach ( ent in array )
        {
            builtin [[ process ]]( ent, var1, var2, var3 );
        }
        
        return;
    }
    
    if ( isdefined( var2 ) )
    {
        foreach ( ent in array )
        {
            builtin [[ process ]]( ent, var1, var2 );
        }
        
        return;
    }
    
    if ( isdefined( var1 ) )
    {
        foreach ( ent in array )
        {
            builtin [[ process ]]( ent, var1 );
        }
        
        return;
    }
    
    foreach ( ent in array )
    {
        builtin [[ process ]]( ent );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x72d1
// Size: 0x93
function array_sort_with_func( array, compare_func )
{
    assertex( isdefined( array ), "<dev string:x61e>" );
    assertex( isdefined( compare_func ), "<dev string:x634>" );
    
    for ( j = 1; j < array.size ; j++ )
    {
        key = array[ j ];
        
        for ( i = j - 1; i >= 0 && ![[ compare_func ]]( array[ i ], key ) ; i-- )
        {
            array[ i + 1 ] = array[ i ];
        }
        
        array[ i + 1 ] = key;
    }
    
    return array;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x736d
// Size: 0xb1
function array_sort_by_script_index( array )
{
    sortedarray = [];
    
    for ( index = 0; index < array.size ; index++ )
    {
        foreach ( item in array )
        {
            if ( is_equal( item.script_index, index ) )
            {
                sortedarray = array_add( sortedarray, item );
            }
        }
    }
    
    remainingitems = array_remove_array( array, sortedarray );
    sortedarray = array_combine( sortedarray, remainingitems );
    return sortedarray;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x7427
// Size: 0x15
function array_average( array )
{
    return array_sum( array ) / array.size;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x7445
// Size: 0x60
function array_sum( array )
{
    sum = 0;
    
    foreach ( item in array )
    {
        sum += item;
    }
    
    return sum;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x74ae
// Size: 0xf3
function function_427c36d659d2f67( array, var_d1f4456463c5272d, shouldthread )
{
    if ( !isdefined( shouldthread ) )
    {
        shouldthread = 0;
    }
    
    assertex( isdefined( array ) && isarray( array ), "<dev string:x655>" );
    assertex( isdefined( var_d1f4456463c5272d ) && isfunction( var_d1f4456463c5272d ), "<dev string:x682>" );
    
    if ( istrue( shouldthread ) )
    {
        foreach ( arrayobject in array )
        {
            self thread [[ var_d1f4456463c5272d ]]( arrayobject );
        }
        
        return;
    }
    
    foreach ( arrayobject in array )
    {
        self [[ var_d1f4456463c5272d ]]( arrayobject );
    }
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0x75a9
// Size: 0x20b
function function_ec65095e6f342856( array, var_d1f4456463c5272d, var_818871783e92735e, var_6fd8f67384dda4d0, iterationtimeinseconds, shouldthread )
{
    if ( !isdefined( var_818871783e92735e ) )
    {
        var_818871783e92735e = undefined;
    }
    
    if ( !isdefined( var_6fd8f67384dda4d0 ) )
    {
        var_6fd8f67384dda4d0 = undefined;
    }
    
    if ( !isdefined( iterationtimeinseconds ) )
    {
        iterationtimeinseconds = 5;
    }
    
    if ( !isdefined( shouldthread ) )
    {
        shouldthread = 0;
    }
    
    assertex( isdefined( array ) && isarray( array ), "<dev string:x655>" );
    assertex( isdefined( var_d1f4456463c5272d ) && isfunction( var_d1f4456463c5272d ), "<dev string:x682>" );
    var_7a73fce97b998437 = 0;
    
    if ( isdefined( var_818871783e92735e ) && isfunction( var_818871783e92735e ) )
    {
        var_7a73fce97b998437 = 1;
    }
    
    var_344b31701913dda0 = array.size;
    var_609bfd613f331f2b = max( iterationtimeinseconds / level.framedurationseconds, 1 );
    var_9e5988ae3851a115 = max( var_344b31701913dda0 / var_609bfd613f331f2b, 1 );
    var_9e5988ae3851a115 = ceil( var_9e5988ae3851a115 );
    var_dce766d46ccbf3d4 = 0;
    
    if ( istrue( shouldthread ) )
    {
        foreach ( arrayobject in array )
        {
            var_e295a391c3f9155d = !var_7a73fce97b998437 || var_7a73fce97b998437 && self [[ var_818871783e92735e ]]( arrayobject );
            
            if ( var_e295a391c3f9155d )
            {
                self thread [[ var_d1f4456463c5272d ]]( arrayobject );
            }
            
            var_dce766d46ccbf3d4++;
            
            if ( var_dce766d46ccbf3d4 >= var_9e5988ae3851a115 )
            {
                waitframe();
                var_dce766d46ccbf3d4 = 0;
            }
        }
    }
    else
    {
        foreach ( arrayobject in array )
        {
            var_e295a391c3f9155d = !var_7a73fce97b998437 || var_7a73fce97b998437 && self [[ var_818871783e92735e ]]( arrayobject );
            
            if ( var_e295a391c3f9155d )
            {
                self [[ var_d1f4456463c5272d ]]( arrayobject );
            }
            
            var_dce766d46ccbf3d4++;
            
            if ( var_dce766d46ccbf3d4 >= var_9e5988ae3851a115 )
            {
                waitframe();
                var_dce766d46ccbf3d4 = 0;
            }
        }
    }
    
    if ( isdefined( var_6fd8f67384dda4d0 ) && isfunction( var_6fd8f67384dda4d0 ) )
    {
        self [[ var_6fd8f67384dda4d0 ]]();
    }
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x77bc
// Size: 0xa9
function function_e81fabd6ea651c21( array, var_d1f4456463c5272d, shouldthread )
{
    if ( !isdefined( shouldthread ) )
    {
        shouldthread = 0;
    }
    
    assertex( isdefined( array ) && isarray( array ), "<dev string:x655>" );
    assertex( isdefined( var_d1f4456463c5272d ) && isfunction( var_d1f4456463c5272d ), "<dev string:x682>" );
    
    if ( istrue( shouldthread ) )
    {
        for ( index = 0; index < array.size ; index++ )
        {
            arrayobject = array[ index ];
            self thread [[ var_d1f4456463c5272d ]]( arrayobject );
        }
        
        return;
    }
    
    for ( index = 0; index < array.size ; index++ )
    {
        arrayobject = array[ index ];
        self [[ var_d1f4456463c5272d ]]( arrayobject );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x786d
// Size: 0x37
function array_divide( array, divisor )
{
    for ( i = 0; i < array.size ; i++ )
    {
        array[ i ] /= divisor;
    }
    
    return array;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x78ad
// Size: 0x65, Type: bool
function function_fcd0e0af8e1d238d( a_ents, e_volume )
{
    foreach ( e_ent in a_ents )
    {
        if ( !e_ent istouching( e_volume ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x791b
// Size: 0x17, Type: bool
function function_ef2b4cd10b36a1ae( object )
{
    return isdefined( object ) && isplayer( object );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x793b
// Size: 0x1c, Type: bool
function function_5a522719a7ec12b8( object )
{
    return function_ef2b4cd10b36a1ae( object ) && isalive( object );
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x7960
// Size: 0x102
function create_deck( item_array, autoshuffle, var_85dd38782ccc953e, prevent_redraw )
{
    if ( !isdefined( item_array ) )
    {
        item_array = [];
    }
    else if ( !isarray( item_array ) )
    {
        item_array = [ item_array ];
    }
    
    deck = spawnstruct();
    deck.items = [];
    deck.index = 0;
    deck.autoshuffle = !isdefined( autoshuffle ) || autoshuffle;
    deck.prevent_redraw = !isdefined( prevent_redraw ) || prevent_redraw;
    
    foreach ( item in item_array )
    {
        deck.items[ deck.items.size ] = item;
    }
    
    if ( istrue( var_85dd38782ccc953e ) )
    {
        deck deck_shuffle();
    }
    
    return deck;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x7a6b
// Size: 0xc1
function deck_draw()
{
    assertex( isstruct( self ) && isdefined( self.items ) && isdefined( self.index ), "<dev string:x6b3>" );
    deck = self;
    
    if ( deck.items.size == 0 )
    {
        return undefined;
    }
    
    if ( deck.index >= deck.items.size )
    {
        if ( deck.autoshuffle )
        {
            deck deck_shuffle();
        }
        else
        {
            deck.index = 0;
        }
    }
    
    drawn_item = deck.items[ deck.index ];
    deck.index++;
    return drawn_item;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x7b35
// Size: 0x192
function deck_shuffle()
{
    assertex( isstruct( self ) && isdefined( self.items ) && isdefined( self.index ), "<dev string:x6f4>" );
    deck = self;
    
    if ( deck.index == 0 || !deck.prevent_redraw || deck.items.size <= 1 )
    {
        deck.items = array_randomize( deck.items );
        deck.index = 0;
        return;
    }
    
    j = randomintrange( 0, deck.items.size - 1 );
    
    if ( j == deck.index - 1 )
    {
        j++;
    }
    
    temp = deck.items[ 0 ];
    deck.items[ 0 ] = deck.items[ j ];
    deck.items[ j ] = temp;
    
    for ( i = 1; i < deck.items.size - 1 ; i++ )
    {
        j = randomintrange( i, deck.items.size );
        temp = deck.items[ i ];
        deck.items[ i ] = deck.items[ j ];
        deck.items[ j ] = temp;
    }
    
    deck.index = 0;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x7ccf
// Size: 0x70
function random( array )
{
    newarray = [];
    
    foreach ( value in array )
    {
        newarray[ newarray.size ] = value;
    }
    
    if ( !newarray.size )
    {
        return undefined;
    }
    
    return newarray[ randomint( newarray.size ) ];
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x7d48
// Size: 0x24
function random_key( array )
{
    keys = getarraykeys( array );
    return random( keys );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x7d75
// Size: 0xf9
function random_weighted( array, weights )
{
    assertex( array.size == weights.size, "<dev string:x733>" );
    totalweight = 0;
    
    foreach ( value in weights )
    {
        totalweight += value;
    }
    
    if ( totalweight == 0 )
    {
        return undefined;
    }
    
    weight = randomint( totalweight );
    chosenvalue = undefined;
    
    foreach ( i, value in array )
    {
        if ( weight < weights[ i ] )
        {
            chosenvalue = value;
            break;
        }
        
        weight -= weights[ i ];
    }
    
    return chosenvalue;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x7e77
// Size: 0xf3
function function_a656c6dfb7dcb33a( struct_array )
{
    totalweight = 0;
    
    foreach ( struct in struct_array )
    {
        totalweight += struct.weight;
    }
    
    if ( totalweight == 0 )
    {
        return undefined;
    }
    
    choosenweight = randomint( totalweight );
    cumulativeweight = 0;
    selectedstruct = undefined;
    
    foreach ( struct in struct_array )
    {
        cumulativeweight += struct.weight;
        
        if ( cumulativeweight > choosenweight )
        {
            selectedstruct = struct;
            break;
        }
    }
    
    return selectedstruct;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x7f73
// Size: 0x8e
function random_weight_sorted( array )
{
    newarray = [];
    
    foreach ( value in array )
    {
        newarray[ newarray.size ] = value;
    }
    
    if ( !newarray.size )
    {
        return undefined;
    }
    
    var_ddcccbf258180536 = randomint( newarray.size * newarray.size );
    return newarray[ newarray.size - 1 - int( sqrt( var_ddcccbf258180536 ) ) ];
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x800a
// Size: 0xa3
function alphabetize( array )
{
    if ( array.size <= 1 )
    {
        return array;
    }
    
    count = 0;
    
    for ( asize = array.size - 1; asize >= 1 ; asize-- )
    {
        largest = array[ asize ];
        largestindex = asize;
        
        for ( i = 0; i < asize ; i++ )
        {
            string1 = array[ i ];
            
            if ( stricmp( string1, largest ) > 0 )
            {
                largest = string1;
                largestindex = i;
            }
        }
        
        if ( largestindex != asize )
        {
            array[ largestindex ] = array[ asize ];
            array[ asize ] = largest;
        }
    }
    
    return array;
}

// Namespace utility / scripts\engine\utility
// Params 12
// Checksum 0x0, Offset: 0x80b6
// Size: 0x7d
function array_thread_amortized( entities, process, var_b2f6e3841e5273bf, var1, var2, var3, var4, var5, var6, var7, var8, var9 )
{
    thread function_d049f2bd4e2b0918( entities, process, var_b2f6e3841e5273bf, var1, var2, var3, var4, var5, var6, var7, var8, var9 );
}

// Namespace utility / scripts\engine\utility
// Params 12
// Checksum 0x0, Offset: 0x813b
// Size: 0x4f8
function function_d049f2bd4e2b0918( entities, process, var_b2f6e3841e5273bf, var1, var2, var3, var4, var5, var6, var7, var8, var9 )
{
    if ( !isdefined( var1 ) )
    {
        foreach ( ent in entities )
        {
            if ( isai( ent ) && !isalive( ent ) || !isdefined( ent ) )
            {
                continue;
            }
            
            ent thread [[ process ]]();
            wait var_b2f6e3841e5273bf;
        }
        
        return;
    }
    
    if ( !isdefined( var2 ) )
    {
        foreach ( ent in entities )
        {
            if ( isai( ent ) && !isalive( ent ) || !isdefined( ent ) )
            {
                continue;
            }
            
            ent thread [[ process ]]( var1 );
            wait var_b2f6e3841e5273bf;
        }
        
        return;
    }
    
    if ( !isdefined( var3 ) )
    {
        foreach ( ent in entities )
        {
            if ( isai( ent ) && !isalive( ent ) || !isdefined( ent ) )
            {
                continue;
            }
            
            ent thread [[ process ]]( var1, var2 );
            wait var_b2f6e3841e5273bf;
        }
        
        return;
    }
    
    if ( !isdefined( var4 ) )
    {
        foreach ( ent in entities )
        {
            if ( isai( ent ) && !isalive( ent ) || !isdefined( ent ) )
            {
                continue;
            }
            
            ent thread [[ process ]]( var1, var2, var3 );
            wait var_b2f6e3841e5273bf;
        }
        
        return;
    }
    
    if ( !isdefined( var5 ) )
    {
        foreach ( ent in entities )
        {
            if ( isai( ent ) && !isalive( ent ) || !isdefined( ent ) )
            {
                continue;
            }
            
            ent thread [[ process ]]( var1, var2, var3, var4 );
            wait var_b2f6e3841e5273bf;
        }
        
        return;
    }
    
    if ( !isdefined( var6 ) )
    {
        foreach ( ent in entities )
        {
            if ( isai( ent ) && !isalive( ent ) || !isdefined( ent ) )
            {
                continue;
            }
            
            ent thread [[ process ]]( var1, var2, var3, var4, var5 );
            wait var_b2f6e3841e5273bf;
        }
        
        return;
    }
    
    if ( !isdefined( var7 ) )
    {
        foreach ( ent in entities )
        {
            if ( isai( ent ) && !isalive( ent ) || !isdefined( ent ) )
            {
                continue;
            }
            
            ent thread [[ process ]]( var1, var2, var3, var4, var5, var6 );
            wait var_b2f6e3841e5273bf;
        }
        
        return;
    }
    
    if ( !isdefined( var8 ) )
    {
        foreach ( ent in entities )
        {
            if ( isai( ent ) && !isalive( ent ) || !isdefined( ent ) )
            {
                continue;
            }
            
            ent thread [[ process ]]( var1, var2, var3, var4, var5, var6, var7 );
            wait var_b2f6e3841e5273bf;
        }
        
        return;
    }
    
    if ( !isdefined( var9 ) )
    {
        foreach ( ent in entities )
        {
            if ( isai( ent ) && !isalive( ent ) || !isdefined( ent ) )
            {
                continue;
            }
            
            ent thread [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8 );
            wait var_b2f6e3841e5273bf;
        }
        
        return;
    }
    
    foreach ( ent in entities )
    {
        if ( isai( ent ) && !isalive( ent ) || !isdefined( ent ) )
        {
            continue;
        }
        
        ent thread [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8, var9 );
        wait var_b2f6e3841e5273bf;
    }
}

// Namespace utility / scripts\engine\utility
// Params 11
// Checksum 0x0, Offset: 0x863c
// Size: 0x39c
function array_thread( entities, process, var1, var2, var3, var4, var5, var6, var7, var8, var9 )
{
    if ( isdefined( var9 ) )
    {
        foreach ( ent in entities )
        {
            ent thread [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8, var9 );
        }
        
        return;
    }
    
    if ( isdefined( var8 ) )
    {
        foreach ( ent in entities )
        {
            ent thread [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8 );
        }
        
        return;
    }
    
    if ( isdefined( var7 ) )
    {
        foreach ( ent in entities )
        {
            ent thread [[ process ]]( var1, var2, var3, var4, var5, var6, var7 );
        }
        
        return;
    }
    
    if ( isdefined( var6 ) )
    {
        foreach ( ent in entities )
        {
            ent thread [[ process ]]( var1, var2, var3, var4, var5, var6 );
        }
        
        return;
    }
    
    if ( isdefined( var5 ) )
    {
        foreach ( ent in entities )
        {
            ent thread [[ process ]]( var1, var2, var3, var4, var5 );
        }
        
        return;
    }
    
    if ( isdefined( var4 ) )
    {
        foreach ( ent in entities )
        {
            ent thread [[ process ]]( var1, var2, var3, var4 );
        }
        
        return;
    }
    
    if ( isdefined( var3 ) )
    {
        foreach ( ent in entities )
        {
            ent thread [[ process ]]( var1, var2, var3 );
        }
        
        return;
    }
    
    if ( isdefined( var2 ) )
    {
        foreach ( ent in entities )
        {
            ent thread [[ process ]]( var1, var2 );
        }
        
        return;
    }
    
    if ( isdefined( var1 ) )
    {
        foreach ( ent in entities )
        {
            ent thread [[ process ]]( var1 );
        }
        
        return;
    }
    
    foreach ( ent in entities )
    {
        ent thread [[ process ]]();
    }
}

// Namespace utility / scripts\engine\utility
// Params 11
// Checksum 0x0, Offset: 0x89e0
// Size: 0x39c
function function_9b971e1bc95bc1df( entities, process, var1, var2, var3, var4, var5, var6, var7, var8, var9 )
{
    if ( isdefined( var9 ) )
    {
        foreach ( ent in entities )
        {
            ent childthread [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8, var9 );
        }
        
        return;
    }
    
    if ( isdefined( var8 ) )
    {
        foreach ( ent in entities )
        {
            ent childthread [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8 );
        }
        
        return;
    }
    
    if ( isdefined( var7 ) )
    {
        foreach ( ent in entities )
        {
            ent childthread [[ process ]]( var1, var2, var3, var4, var5, var6, var7 );
        }
        
        return;
    }
    
    if ( isdefined( var6 ) )
    {
        foreach ( ent in entities )
        {
            ent childthread [[ process ]]( var1, var2, var3, var4, var5, var6 );
        }
        
        return;
    }
    
    if ( isdefined( var5 ) )
    {
        foreach ( ent in entities )
        {
            ent childthread [[ process ]]( var1, var2, var3, var4, var5 );
        }
        
        return;
    }
    
    if ( isdefined( var4 ) )
    {
        foreach ( ent in entities )
        {
            ent childthread [[ process ]]( var1, var2, var3, var4 );
        }
        
        return;
    }
    
    if ( isdefined( var3 ) )
    {
        foreach ( ent in entities )
        {
            ent childthread [[ process ]]( var1, var2, var3 );
        }
        
        return;
    }
    
    if ( isdefined( var2 ) )
    {
        foreach ( ent in entities )
        {
            ent childthread [[ process ]]( var1, var2 );
        }
        
        return;
    }
    
    if ( isdefined( var1 ) )
    {
        foreach ( ent in entities )
        {
            ent childthread [[ process ]]( var1 );
        }
        
        return;
    }
    
    foreach ( ent in entities )
    {
        ent childthread [[ process ]]();
    }
}

// Namespace utility / scripts\engine\utility
// Params 10
// Checksum 0x0, Offset: 0x8d84
// Size: 0x338
function array_call( entities, process, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    if ( isdefined( var8 ) )
    {
        foreach ( ent in entities )
        {
            ent builtin [[ process ]]( var1, var2, var3, var4, var5, var6, var7, var8 );
        }
        
        return;
    }
    
    if ( isdefined( var7 ) )
    {
        foreach ( ent in entities )
        {
            ent builtin [[ process ]]( var1, var2, var3, var4, var5, var6, var7 );
        }
        
        return;
    }
    
    if ( isdefined( var6 ) )
    {
        foreach ( ent in entities )
        {
            ent builtin [[ process ]]( var1, var2, var3, var4, var5, var6 );
        }
        
        return;
    }
    
    if ( isdefined( var5 ) )
    {
        foreach ( ent in entities )
        {
            ent builtin [[ process ]]( var1, var2, var3, var4, var5 );
        }
        
        return;
    }
    
    if ( isdefined( var4 ) )
    {
        foreach ( ent in entities )
        {
            ent builtin [[ process ]]( var1, var2, var3, var4 );
        }
        
        return;
    }
    
    if ( isdefined( var3 ) )
    {
        foreach ( ent in entities )
        {
            ent builtin [[ process ]]( var1, var2, var3 );
        }
        
        return;
    }
    
    if ( isdefined( var2 ) )
    {
        foreach ( ent in entities )
        {
            ent builtin [[ process ]]( var1, var2 );
        }
        
        return;
    }
    
    if ( isdefined( var1 ) )
    {
        foreach ( ent in entities )
        {
            ent builtin [[ process ]]( var1 );
        }
        
        return;
    }
    
    foreach ( ent in entities )
    {
        ent builtin [[ process ]]();
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x90c4
// Size: 0xb2
function function_1f9d89277519b570( job_funcs, arg_array )
{
    assert( isarray( job_funcs ) );
    arg_array = default_to( arg_array, [] );
    jobpool = spawnstruct();
    jobpool.alldonenotify = "all_workers_done";
    jobpool.pendingcount = job_funcs.size;
    
    for ( i = 0; i < job_funcs.size ; i++ )
    {
        assert( isfunction( job_funcs[ i ] ) );
        jobpool childthread function_917573e92ca19878( self, job_funcs[ i ], arg_array );
    }
    
    if ( jobpool.pendingcount == 0 )
    {
        return;
    }
    
    jobpool waittill( jobpool.alldonenotify );
}

// Namespace utility / scripts\engine\utility
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x917e
// Size: 0x54
function private function_917573e92ca19878( ent, func, arg_array )
{
    single_func_argarray( ent, func, arg_array );
    self.pendingcount -= 1;
    
    if ( self.pendingcount == 0 )
    {
        self notify( self.alldonenotify );
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x91da
// Size: 0x1f
function flat_angle( angle )
{
    rangle = ( 0, angle[ 1 ], 0 );
    return rangle;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x9202
// Size: 0x21
function flat_origin( org )
{
    rorg = ( org[ 0 ], org[ 1 ], 0 );
    return rorg;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x922c
// Size: 0x44
function flatten_vector( var_cc24231b0f3f7333, up_vector )
{
    if ( !isdefined( up_vector ) )
    {
        up_vector = ( 0, 0, 1 );
    }
    
    flat_vec = vectornormalize( var_cc24231b0f3f7333 - vectordot( up_vector, var_cc24231b0f3f7333 ) * up_vector );
    return flat_vec;
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x9279
// Size: 0x17f
function draw_arrow_time( start, end, color, duration, endonevent )
{
    if ( isdefined( endonevent ) )
    {
        level endon( endonevent );
    }
    
    level endon( "newpath" );
    pts = [];
    angles = vectortoangles( start - end );
    right = anglestoright( angles );
    forward = anglestoforward( angles );
    up = anglestoup( angles );
    dist = distance( start, end );
    arrow = [];
    range = 0.1;
    arrow[ 0 ] = start;
    arrow[ 1 ] = start + right * dist * range + forward * dist * -0.1;
    arrow[ 2 ] = end;
    arrow[ 3 ] = start + right * dist * -1 * range + forward * dist * -0.1;
    arrow[ 4 ] = start;
    arrow[ 5 ] = start + up * dist * range + forward * dist * -0.1;
    arrow[ 6 ] = end;
    arrow[ 7 ] = start + up * dist * -1 * range + forward * dist * -0.1;
    arrow[ 8 ] = start;
    r = color[ 0 ];
    g = color[ 1 ];
    b = color[ 2 ];
    plot_points( arrow, r, g, b, duration );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x9400
// Size: 0x118
function draw_arrow( start, end, color )
{
    level endon( "newpath" );
    pts = [];
    angles = vectortoangles( start - end );
    right = anglestoright( angles );
    forward = anglestoforward( angles );
    dist = distance( start, end );
    arrow = [];
    range = 0.05;
    arrow[ 0 ] = start;
    arrow[ 1 ] = start + right * dist * range + forward * dist * -0.2;
    arrow[ 2 ] = end;
    arrow[ 3 ] = start + right * dist * -1 * range + forward * dist * -0.2;
    
    for ( p = 0; p < 4 ; p++ )
    {
        nextpoint = p + 1;
        
        if ( nextpoint >= 4 )
        {
            nextpoint = 0;
        }
        
        /#
            line( arrow[ p ], arrow[ nextpoint ], color, 1 );
        #/
    }
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0x9520
// Size: 0x1c7
function draw_capsule( pos, radius, height, angles, color, depthtest, duration )
{
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    if ( !isdefined( depthtest ) )
    {
        depthtest = 0;
    }
    
    if ( !isdefined( duration ) )
    {
        duration = 1;
    }
    
    forward = anglestoforward( angles );
    right = anglestoright( angles );
    up = anglestoup( angles );
    
    /#
        cap_base = pos + up * radius;
        sphere( cap_base, radius, color, depthtest, duration );
        cap_top = pos + up * height;
        cap_top -= up * radius;
        sphere( cap_top, radius, color, depthtest, duration );
        var_e3e4708f2b15cdc = cap_base + forward * radius;
        var_c082cafefe1be9e0 = cap_top + forward * radius;
        line( var_e3e4708f2b15cdc, var_c082cafefe1be9e0, color, 1, depthtest, duration );
        var_35e9e473f5743470 = cap_base - forward * radius;
        var_f06f5503d572a834 = cap_top - forward * radius;
        line( var_35e9e473f5743470, var_f06f5503d572a834, color, 1, depthtest, duration );
        var_154fc976c8007720 = cap_base + right * radius;
        var_c826cf340204f3e4 = cap_top + right * radius;
        line( var_154fc976c8007720, var_c826cf340204f3e4, color, 1, depthtest, duration );
        var_29521623860703fa = cap_base - right * radius;
        var_2bc57f4bb1103296 = cap_top - right * radius;
        line( var_29521623860703fa, var_2bc57f4bb1103296, color, 1, depthtest, duration );
    #/
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x96ef
// Size: 0x57
function draw_character_capsule( color, depthtest, duration )
{
    capsule_data = self physics_getcharactercollisioncapsule();
    draw_capsule( self getorigin(), capsule_data[ "radius" ], capsule_data[ "half_height" ] * 2, self.angles, color, depthtest, duration );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x974e
// Size: 0x54
function draw_player_capsule( color, depthtest, duration )
{
    capsule_data = self physics_getcharactercollisioncapsule();
    draw_capsule( self getorigin(), capsule_data[ "radius" ], capsule_data[ "half_height" ] * 2, self getplayerangles(), color, depthtest, duration );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x97aa
// Size: 0x58
function draw_ent_bone_forever( bone_name, origin_color )
{
    self endon( "stop_drawing_axis" );
    self endon( "death" );
    
    while ( true )
    {
        bone_origin = self gettagorigin( bone_name );
        bone_angles = self gettagangles( bone_name );
        draw_angles( bone_angles, bone_origin, origin_color );
        waitframe();
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x980a
// Size: 0x34
function draw_ent_axis_forever( origin_color, scale )
{
    self endon( "stop_drawing_axis" );
    self endon( "death" );
    
    while ( true )
    {
        draw_ent_axis( origin_color, undefined, scale );
        waitframe();
    }
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x9846
// Size: 0x3d
function draw_tag_axis_forever( tag, origin_color, scale )
{
    self endon( "stop_drawing_axis" );
    self endon( "death" );
    
    while ( true )
    {
        draw_tag_axis( tag, origin_color, undefined, scale );
        waitframe();
    }
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x988b
// Size: 0x64
function draw_ent_axis( origin_color, duration, scale )
{
    waittillframeend();
    
    if ( isdefined( self.angles ) )
    {
        angles = self.angles;
    }
    else
    {
        angles = ( 0, 0, 0 );
    }
    
    draw_angles( angles, self.origin, origin_color, duration, scale );
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x98f7
// Size: 0x54
function draw_tag_axis( tag, origin_color, duration, scale )
{
    waittillframeend();
    angles = self gettagangles( tag );
    origin = self gettagorigin( tag );
    draw_angles( angles, origin, origin_color, duration, scale );
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x9953
// Size: 0x12d
function draw_angles( angles, origin, origin_color, duration, scale )
{
    waittillframeend();
    forward = anglestoforward( angles );
    right = anglestoright( angles );
    up = anglestoup( angles );
    assert( vectordot( forward, right ) == 0 );
    assert( vectordot( forward, up ) == 0 );
    assert( vectordot( up, right ) == 0 );
    
    if ( !isdefined( origin_color ) )
    {
        origin_color = ( 1, 0, 1 );
    }
    
    if ( !isdefined( duration ) )
    {
        duration = 1;
    }
    
    if ( !isdefined( scale ) )
    {
        scale = 10;
    }
    
    /#
        sphere( origin, 1, origin_color, 0, duration );
        line( origin, origin + forward * scale, ( 1, 0, 0 ), 1, 0, duration );
        line( origin, origin + right * scale, ( 0, 1, 0 ), 1, 0, duration );
        line( origin, origin + up * scale, ( 0, 0, 1 ), 1, 0, duration );
    #/
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x9a88
// Size: 0x1fc
function draw_entity_bounds( ent, time_sec, color, dynamic, var_d88c48911f4bf6a0 )
{
    assert( isdefined( ent ) );
    assert( time_sec > 0 );
    
    if ( !isdefined( color ) )
    {
        color = ( 0, 1, 0 );
    }
    
    if ( !isdefined( dynamic ) )
    {
        dynamic = 0;
    }
    
    if ( !isdefined( var_d88c48911f4bf6a0 ) )
    {
        var_d88c48911f4bf6a0 = level.framedurationseconds;
    }
    
    if ( dynamic )
    {
        num_frames = int( var_d88c48911f4bf6a0 / level.framedurationseconds );
    }
    else
    {
        num_frames = int( time_sec / level.framedurationseconds );
    }
    
    var_1d29919376ad4830 = [];
    var_1d29949376ad4ec9 = [];
    current = gettime();
    end = current + time_sec * 1000;
    
    while ( current < end && isdefined( ent ) )
    {
        var_1d29919376ad4830[ 0 ] = ent getpointinbounds( 1, 1, 1 );
        var_1d29919376ad4830[ 1 ] = ent getpointinbounds( 1, 1, -1 );
        var_1d29919376ad4830[ 2 ] = ent getpointinbounds( -1, 1, -1 );
        var_1d29919376ad4830[ 3 ] = ent getpointinbounds( -1, 1, 1 );
        var_1d29949376ad4ec9[ 0 ] = ent getpointinbounds( 1, -1, 1 );
        var_1d29949376ad4ec9[ 1 ] = ent getpointinbounds( 1, -1, -1 );
        var_1d29949376ad4ec9[ 2 ] = ent getpointinbounds( -1, -1, -1 );
        var_1d29949376ad4ec9[ 3 ] = ent getpointinbounds( -1, -1, 1 );
        
        /#
            for ( i = 0; i < 4 ; i++ )
            {
                j = i + 1;
                
                if ( j == 4 )
                {
                    j = 0;
                }
                
                line( var_1d29919376ad4830[ i ], var_1d29919376ad4830[ j ], color, 1, 0, num_frames );
                line( var_1d29949376ad4ec9[ i ], var_1d29949376ad4ec9[ j ], color, 1, 0, num_frames );
                line( var_1d29919376ad4830[ i ], var_1d29949376ad4ec9[ i ], color, 1, 0, num_frames );
            }
        #/
        
        if ( !dynamic )
        {
            return;
        }
        
        wait var_d88c48911f4bf6a0;
        current = gettime();
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x9c8c
// Size: 0x38
function getfx( fx )
{
    assertex( isdefined( level._effect[ fx ] ), "<dev string:x762>" + fx + "<dev string:x769>" );
    return level._effect[ fx ];
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x9ccd
// Size: 0x17, Type: bool
function fxexists( fx )
{
    return isdefined( level._effect[ fx ] );
}

/#

    // Namespace utility / scripts\engine\utility
    // Params 0
    // Checksum 0x0, Offset: 0x9ced
    // Size: 0xf1, Type: dev
    function playerunlimitedammothread()
    {
        if ( !isdefined( self ) || self == level || isdefined( self.code_classname ) && self.code_classname != "<dev string:x78e>" )
        {
            player = level.player;
        }
        else
        {
            player = self;
        }
        
        assert( isdefined( player ) );
        
        while ( true )
        {
            wait 0.5;
            
            if ( getdvar( @"unlimitedammooff" ) == "<dev string:x798>" )
            {
                continue;
            }
            
            currentweapon = player getcurrentweapon();
            
            if ( !isnullweapon( currentweapon ) )
            {
                currentammo = player getfractionmaxammo( currentweapon );
                
                if ( currentammo < 0.2 )
                {
                    player givemaxammo( currentweapon );
                }
            }
            
            currentoffhand = player getcurrentoffhand();
            
            if ( !isnullweapon( currentoffhand ) )
            {
                currentammo = player getfractionmaxammo( currentoffhand );
                
                if ( currentammo < 0.4 )
                {
                    player givemaxammo( currentoffhand );
                }
            }
        }
    }

#/

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x9de6
// Size: 0xa5
function spawn_tag_origin( org, ang )
{
    if ( !isdefined( ang ) && isdefined( self.angles ) )
    {
        ang = self.angles;
    }
    
    if ( !isdefined( org ) && isdefined( self.origin ) )
    {
        org = self.origin;
    }
    else if ( !isdefined( org ) )
    {
        org = ( 0, 0, 0 );
    }
    
    TAG_ORIGIN = spawn( "script_model", org );
    TAG_ORIGIN setmodel( "tag_origin" );
    TAG_ORIGIN hide();
    
    if ( isdefined( ang ) )
    {
        TAG_ORIGIN.angles = ang;
    }
    
    return TAG_ORIGIN;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x9e94
// Size: 0x18
function waittill_notify_or_timeout( msg, timer )
{
    self endon( msg );
    wait timer;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x9eb4
// Size: 0x4b
function waittill_notify_or_timeout_return( notifymessage, timer )
{
    notifystruct = spawnstruct();
    thread waittill_notify_proc( notifystruct, notifymessage );
    thread waittill_timeout_proc( notifystruct, timer );
    notifystruct waittill( "waittill_proc", result );
    return result;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x9f08
// Size: 0x27
function waittill_notify_proc( notifystruct, notifymessage )
{
    notifystruct endon( "waittill_proc" );
    self waittill( notifymessage );
    notifystruct notify( "waittill_proc", notifymessage );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x9f37
// Size: 0x29
function waittill_timeout_proc( notifystruct, timeout )
{
    notifystruct endon( "waittill_proc" );
    wait timeout;
    notifystruct notify( "waittill_proc", "timeout" );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x9f68
// Size: 0x5f
function waittill_notify_and_time( msg, time )
{
    starttime = gettime();
    self waittill( msg );
    endtime = starttime + time * 1000;
    timeleft = endtime - starttime;
    
    if ( timeleft > 0 )
    {
        waittime = timeleft / 1000;
        wait waittime;
    }
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x9fcf
// Size: 0xba
function array_wait( array, message, timeout )
{
    notifystruct = spawnstruct();
    
    if ( istrue( timeout ) )
    {
        thread array_wait_timeout_proc( notifystruct, timeout );
        notifystruct endon( "array_wait_timeout" );
    }
    
    foreach ( element in array )
    {
        thread array_wait_proc( notifystruct, element, message );
    }
    
    for ( i = 0; i < array.size ; i++ )
    {
        notifystruct waittill( "array_wait_proc" );
    }
    
    notifystruct notify( "array_wait_success" );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xa091
// Size: 0x38
function array_wait_proc( notifystruct, element, message )
{
    notifystruct endon( "array_wait_success" );
    element waittill_any_2( message, "death" );
    notifystruct notify( "array_wait_proc" );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xa0d1
// Size: 0x24
function array_wait_timeout_proc( notifystruct, timeout )
{
    notifystruct endon( "array_wait_success" );
    wait timeout;
    notifystruct notify( "array_wait_timeout" );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xa0fd
// Size: 0x85
function array_any_wait( array, message )
{
    notifystruct = spawnstruct();
    
    foreach ( element in array )
    {
        thread array_any_wait_proc( notifystruct, element, message );
    }
    
    notifystruct waittill( "array_wait_proc", result );
    return result;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xa18b
// Size: 0x98
function array_any_wait_timeout( array, message, timeout )
{
    notifystruct = spawnstruct();
    thread array_any_wait_timeout_proc( notifystruct, timeout );
    
    foreach ( element in array )
    {
        thread array_any_wait_proc( notifystruct, element, message );
    }
    
    notifystruct waittill( "array_wait_proc", result );
    return result;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xa22c
// Size: 0x3d
function array_any_wait_proc( notifystruct, element, message )
{
    result = element waittill_any_return_no_endon_death( message, "death" );
    notifystruct notify( "array_wait_proc", result );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xa271
// Size: 0x29
function array_any_wait_timeout_proc( notifystruct, timeout )
{
    notifystruct endon( "array_wait_proc" );
    wait timeout;
    notifystruct notify( "array_wait_proc", "timeout" );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xa2a2
// Size: 0x7c
function array_any_wait_return( array, message )
{
    notifystruct = spawnstruct();
    
    foreach ( element in array )
    {
        thread array_any_wait_return_proc( notifystruct, element, message );
    }
    
    notifystruct waittill( "array_wait_proc", element );
    return element;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xa327
// Size: 0x3d
function array_any_wait_return_proc( notifystruct, element, message )
{
    result = element waittill_any_return_2( message, "death" );
    notifystruct notify( "array_wait_proc", element );
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xa36c
// Size: 0x3c
function fileprint_launcher_start_file()
{
    assertex( !isdefined( level.fileprint_launcher ), "<dev string:x79d>" );
    level.fileprintlauncher_linecount = 0;
    level.fileprint_launcher = 1;
    fileprint_launcher( "GAMEPRINTSTARTFILE:" );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xa3b0
// Size: 0x57
function fileprint_launcher( string )
{
    assert( isdefined( level.fileprintlauncher_linecount ) );
    level.fileprintlauncher_linecount++;
    
    if ( level.fileprintlauncher_linecount > 200 )
    {
        wait 0.05;
        level.fileprintlauncher_linecount = 0;
    }
    
    println( "<dev string:x7e3>" + string );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xa40f
// Size: 0x18f, Type: bool
function fileprint_launcher_end_file( var_82996f577af7f7f3, var_91a1926479dd5e50 )
{
    if ( !isdefined( var_91a1926479dd5e50 ) )
    {
        var_91a1926479dd5e50 = 0;
    }
    
    /#
        setdevdvarifuninitialized( @"launcher_print_fail", "<dev string:x7f7>" );
        setdevdvarifuninitialized( @"hash_afbeda0efab5bd5e", "<dev string:x7f7>" );
    #/
    
    if ( var_91a1926479dd5e50 )
    {
        fileprint_launcher( "GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + var_82996f577af7f7f3 );
    }
    else
    {
        fileprint_launcher( "GAMEPRINTENDFILE:" + var_82996f577af7f7f3 );
    }
    
    timeout = gettime() + 4000;
    
    while ( getdvarint( @"hash_afbeda0efab5bd5e" ) == 0 && getdvar( @"launcher_print_fail" ) == "0" && gettime() < timeout )
    {
        wait 0.05;
    }
    
    if ( !( gettime() < timeout ) )
    {
        iprintlnbold( "LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? " );
        
        /#
            setdevdvar( @"launcher_print_fail", "<dev string:x7f7>" );
        #/
        
        level.fileprint_launcher = undefined;
        return false;
    }
    
    failvar = getdvar( @"launcher_print_fail" );
    
    if ( failvar != "0" )
    {
        iprintlnbold( "LAUNCHER_PRINT_FAIL:( " + failvar + " ): launcherconflict? restart launcher and try again? " );
        
        /#
            setdevdvar( @"launcher_print_fail", "<dev string:x7f7>" );
        #/
        
        level.fileprint_launcher = undefined;
        return false;
    }
    
    /#
        setdevdvar( @"launcher_print_fail", "<dev string:x7f7>" );
        setdevdvar( @"hash_afbeda0efab5bd5e", "<dev string:x7f7>" );
    #/
    
    iprintlnbold( "Launcher write to file successful!" );
    level.fileprint_launcher = undefined;
    return true;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xa5a7
// Size: 0x23
function launcher_write_clipboard( str )
{
    level.fileprintlauncher_linecount = 0;
    fileprint_launcher( "LAUNCHER_CLIP:" + str );
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xa5d2
// Size: 0x9
function activate_individual_exploder()
{
    scripts\common\exploder::activate_individual_exploder_proc();
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xa5e3
// Size: 0xcd
function get_target_ent( target )
{
    if ( !isdefined( target ) )
    {
        target = self.target;
    }
    
    assertex( isdefined( target ), "<dev string:x7fc>" );
    ent = getent( target, "targetname" );
    
    if ( isdefined( ent ) )
    {
        return ent;
    }
    
    if ( issp() )
    {
        ent = builtin [[ level.getnodefunction ]]( target, "targetname" );
        
        if ( isdefined( ent ) )
        {
            return ent;
        }
        
        ent = builtin [[ level.func[ "getspawner" ] ]]( target, "targetname" );
        
        if ( isdefined( ent ) )
        {
            return ent;
        }
    }
    
    ent = getstruct( target, "targetname" );
    
    if ( isdefined( ent ) )
    {
        return ent;
    }
    
    ent = getvehiclenode( target, "targetname" );
    
    if ( isdefined( ent ) )
    {
        return ent;
    }
    
    assertmsg( "<dev string:x813>" + target + "<dev string:x828>" );
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xa6b8
// Size: 0x15
function get_links()
{
    return strtok( self.script_linkto, " " );
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xa6d6
// Size: 0x5a
function get_linked_ents()
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        if ( linknames.size == 1 )
        {
            return getentarray( linknames[ 0 ], "script_linkname" );
        }
        else if ( linknames.size > 1 )
        {
            return function_9f9ba8a4756db8c7( linknames, "script_linkname" );
        }
    }
    
    return array;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xa739
// Size: 0x32
function get_linked_ent()
{
    array = get_linked_ents();
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xa774
// Size: 0x4f
function get_linked_nodes()
{
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        if ( linknames.size == 1 )
        {
            return getnodearray( linknames[ 0 ], "script_linkname" );
        }
        else if ( linknames.size > 1 )
        {
            return getnodesfromvalues( linknames, "script_linkname" );
        }
    }
    
    return [];
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xa7cc
// Size: 0x78
function do_earthquake( name, origin )
{
    eq = level.earthquake[ name ];
    earthquake( eq[ "magnitude" ], eq[ "duration" ], origin, eq[ "radius" ] );
    
    if ( isdefined( level.var_bc7733fa2bdf5ad0 ) )
    {
        level thread [[ level.var_bc7733fa2bdf5ad0 ]]( name, origin, eq[ "magnitude" ], eq[ "duration" ], eq[ "radius" ] );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xa84c
// Size: 0x5c
function play_loopsound_in_space( alias, origin )
{
    org = spawn( "script_origin", ( 0, 0, 0 ) );
    
    if ( !isdefined( origin ) )
    {
        origin = self.origin;
    }
    
    org.origin = origin;
    org playloopsound( alias );
    return org;
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0xa8b1
// Size: 0xcb
function play_sound_in_space_with_angles( alias, origin, angles, parent )
{
    org = spawn( "script_origin", ( 0, 0, 1 ) );
    
    if ( !isdefined( origin ) )
    {
        origin = self.origin;
    }
    
    org.origin = origin;
    org.angles = angles;
    
    if ( isdefined( parent ) )
    {
        org linkto( parent );
    }
    
    /#
        if ( isdefined( self.v ) )
        {
            org.createfx_ent = 1;
        }
    #/
    
    if ( issp() )
    {
        org playsound( alias, "sounddone" );
        org waittill( "sounddone" );
    }
    else
    {
        org playsound( alias );
    }
    
    org delete();
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xa984
// Size: 0x32
function play_sound_in_space( alias, origin, parent )
{
    play_sound_in_space_with_angles( alias, origin, ( 0, 0, 0 ), parent );
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0xa9be
// Size: 0x133
function play_loop_sound_on_tag( alias, tag, bstopsoundondeath, var_627c155c7ac80247, release_sound )
{
    org = spawn( "script_origin", ( 0, 0, 0 ) );
    org endon( "death" );
    
    if ( !isdefined( bstopsoundondeath ) )
    {
        bstopsoundondeath = 1;
    }
    
    if ( bstopsoundondeath )
    {
        thread delete_on_death( org );
    }
    
    if ( !isdefined( var_627c155c7ac80247 ) )
    {
        var_627c155c7ac80247 = 0;
    }
    
    if ( var_627c155c7ac80247 )
    {
        thread delete_on_removed( org );
    }
    
    if ( isdefined( tag ) )
    {
        org linkto( self, tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    else
    {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto( self );
    }
    
    org playloopsound( alias );
    self waittill( "stop sound" + alias );
    
    if ( isdefined( release_sound ) )
    {
        org playsound( release_sound, "sounddone" );
        org delaycall( 0.15, &stoploopsound, alias );
        org waittill( "sounddone" );
        org delete();
        return;
    }
    
    org stoploopsound( alias );
    org delete();
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xaaf9
// Size: 0x2c
function delete_on_removed( ent )
{
    ent endon( "death" );
    
    while ( isdefined( self ) )
    {
        wait 0.05;
    }
    
    if ( isdefined( ent ) )
    {
        ent delete();
    }
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0xab2d
// Size: 0x44
function loop_fx_sound( alias, origin, culled, ender, createfx_ent )
{
    loop_fx_sound_with_angles( alias, origin, ( 0, 0, 0 ), culled, ender, createfx_ent );
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0xab79
// Size: 0x132
function loop_fx_sound_with_angles( alias, origin, angles, culled, ender, createfx_ent, shape )
{
    if ( istrue( culled ) )
    {
        if ( !isdefined( level.first_frame ) || level.first_frame == 1 )
        {
            spawnloopingsound( alias, origin, angles );
        }
        
        return;
    }
    
    if ( level.createfx_enabled && isdefined( createfx_ent.loopsound_ent ) )
    {
        org = createfx_ent.loopsound_ent;
    }
    else
    {
        org = spawn( "script_origin", ( 0, 0, 0 ) );
    }
    
    /#
        if ( isdefined( self.v ) )
        {
            org.createfx_ent = 1;
        }
    #/
    
    if ( isdefined( ender ) )
    {
        thread loop_sound_delete( ender, org );
        self endon( ender );
    }
    
    org.origin = origin;
    org.angles = angles;
    org playloopsound( alias );
    
    if ( level.createfx_enabled )
    {
        createfx_ent.loopsound_ent = org;
        return;
    }
    
    org willneverchange();
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0xacb3
// Size: 0x4d
function loop_fx_sound_interval( alias, origin, ender, timeout, delay_min, delay_max )
{
    loop_fx_sound_interval_with_angles( alias, origin, ( 0, 0, 0 ), ender, timeout, delay_min, delay_max );
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0xad08
// Size: 0x10b
function loop_fx_sound_interval_with_angles( alias, origin, angles, ender, timeout, delay_min, delay_max )
{
    self.origin = origin;
    self.angles = angles;
    
    if ( isdefined( ender ) )
    {
        self endon( ender );
    }
    
    if ( delay_min >= delay_max )
    {
        while ( true )
        {
            /#
                print3d( origin, "<dev string:x843>", ( 1, 0, 0 ), 1, 1 );
            #/
            
            wait 0.05;
        }
    }
    
    if ( !soundexists( alias ) )
    {
        while ( true )
        {
            /#
                print3d( origin, "<dev string:x85d>" + alias, ( 1, 0, 0 ), 1, 1 );
            #/
            
            wait 0.05;
        }
    }
    
    while ( true )
    {
        wait randomfloatrange( delay_min, delay_max );
        lock( "createfx_looper" );
        thread play_sound_in_space_with_angles( alias, self.origin, self.angles, undefined );
        unlock( "createfx_looper" );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xae1b
// Size: 0x25
function loop_sound_delete( ender, ent )
{
    ent endon( "death" );
    self waittill( ender );
    ent delete();
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xae48
// Size: 0x3c
function createloopeffect( fxid )
{
    ent = scripts\common\createfx::createeffect( "loopfx", fxid );
    ent.v[ "delay" ] = scripts\common\createfx::getloopeffectdelaydefault();
    return ent;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xae8d
// Size: 0x3c
function createoneshoteffect( fxid )
{
    ent = scripts\common\createfx::createeffect( "oneshotfx", fxid );
    ent.v[ "delay" ] = scripts\common\createfx::getoneshoteffectdelaydefault();
    return ent;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xaed2
// Size: 0x5c
function createexploder( fxid, islevelexploder )
{
    ent = scripts\common\createfx::createeffect( "exploder", fxid, islevelexploder );
    ent.v[ "delay" ] = scripts\common\createfx::getexploderdelaydefault();
    ent.v[ "exploder_type" ] = "normal";
    return ent;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xaf37
// Size: 0xd5
function play_loop_sound_on_entity( alias, offset )
{
    org = spawn( "script_origin", ( 0, 0, 0 ) );
    org endon( "death" );
    thread delete_on_death( org );
    
    if ( isdefined( offset ) )
    {
        org.origin = self.origin + offset;
        org.angles = self.angles;
        org linkto( self );
    }
    else
    {
        org.origin = self.origin;
        org.angles = self.angles;
        org linkto( self );
    }
    
    org playloopsound( alias );
    self waittill( "stop sound" + alias );
    org stoploopsound( alias );
    org delete();
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xb014
// Size: 0x15
function stop_loop_sound_on_entity( alias )
{
    self notify( "stop sound" + alias );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xb031
// Size: 0x26
function delete_on_death( ent )
{
    ent endon( "death" );
    self waittill( "death" );
    
    if ( isdefined( ent ) )
    {
        ent delete();
    }
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xb05f
// Size: 0x11
function delete_on_sounddone()
{
    self waittill( "sounddone" );
    self delete();
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xb078
// Size: 0x16
function delete_on_notify( msg )
{
    self waittill( msg );
    self delete();
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xb096
// Size: 0x23
function function_5ee1730c2e122134( ent, msg )
{
    self waittill( msg );
    
    if ( isdefined( ent ) )
    {
        ent delete();
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xb0c1
// Size: 0x19
function function_b4b04de87729a6f3( delay )
{
    wait delay;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

/#

    // Namespace utility / scripts\engine\utility
    // Params 1
    // Checksum 0x0, Offset: 0xb0e2
    // Size: 0x41, Type: dev
    function error( msg )
    {
        println( "<dev string:x86b>", msg );
        
        if ( getdvar( @"scr_debug" ) != "<dev string:x798>" )
        {
            assertmsg( "<dev string:x87c>" + msg );
        }
    }

#/

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xb12b
// Size: 0x34
function exploder( num, players, starttime )
{
    [[ level._fx.exploderfunction ]]( num, players, starttime );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xb167
// Size: 0x13
function delete_exploder( num )
{
    scripts\common\exploder::delete_exploder_proc( num );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xb182
// Size: 0x13
function hide_exploder_models( num )
{
    scripts\common\exploder::hide_exploder_models_proc( num );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xb19d
// Size: 0x13
function show_exploder_models( num )
{
    scripts\common\exploder::show_exploder_models_proc( num );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xb1b8
// Size: 0x1d
function stop_exploder( num, players )
{
    scripts\common\exploder::stop_exploder_proc( num, players, 0 );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xb1dd
// Size: 0x1e
function kill_exploder( num, players )
{
    scripts\common\exploder::stop_exploder_proc( num, players, 1 );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xb203
// Size: 0x12
function get_exploder_array( msg )
{
    return scripts\common\exploder::get_exploder_array_proc( msg );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xb21e
// Size: 0x22
function ter_op( var_9cb951de1a571d32, true_value, false_value )
{
    if ( var_9cb951de1a571d32 )
    {
        return true_value;
    }
    
    return false_value;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xb249
// Size: 0x1b
function default_to( value, default_value )
{
    if ( !isdefined( value ) )
    {
        return default_value;
    }
    
    return value;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xb26d
// Size: 0x32
function function_ce51e08dcc037220( value, default_value, err_msg )
{
    if ( !isdefined( value ) )
    {
        if ( isdefined( err_msg ) )
        {
            assertmsg( err_msg );
        }
        
        return default_value;
    }
    
    return value;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xb2a8
// Size: 0x76
function create_lock( msg, count )
{
    if ( !isdefined( count ) )
    {
        count = 1;
    }
    
    assert( isdefined( msg ) );
    
    if ( !isdefined( level.lock ) )
    {
        level.lock = [];
    }
    
    lock_struct = spawnstruct();
    lock_struct.max_count = count;
    lock_struct.count = 0;
    level.lock[ msg ] = lock_struct;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xb326
// Size: 0x7b
function lock( msg )
{
    assert( isdefined( level.lock ) );
    assert( isdefined( level.lock[ msg ] ) );
    lock = level.lock[ msg ];
    
    while ( lock.count >= lock.max_count )
    {
        lock waittill( "unlocked" );
    }
    
    lock.count++;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xb3a9
// Size: 0x14
function unlock( msg )
{
    thread unlock_thread( msg );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xb3c5
// Size: 0x7a
function unlock_thread( msg )
{
    wait 0.05;
    assert( isdefined( level.lock ) );
    assert( isdefined( level.lock[ msg ] ) );
    lock = level.lock[ msg ];
    lock.count--;
    assert( lock.count >= 0 );
    lock notify( "unlocked" );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xb447
// Size: 0x1a
function unlock_wait( msg )
{
    thread unlock_thread( msg );
    wait 0.05;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xb469
// Size: 0x2f
function is_player_gamepad_enabled()
{
    var_ce09c6f6a7628f6d = self usinggamepad();
    
    if ( isdefined( var_ce09c6f6a7628f6d ) )
    {
        return var_ce09c6f6a7628f6d;
    }
    
    if ( self ispcplayer() )
    {
        return 0;
    }
    
    return 1;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xb4a0
// Size: 0x3c
function player_prestream_camera( position, duration, altposition )
{
    if ( !isdefined( duration ) )
    {
        duration = 5;
    }
    
    if ( !isdefined( altposition ) )
    {
        altposition = undefined;
    }
    
    thread function_d4192e0c7c79be61( position, duration, altposition );
}

// Namespace utility / scripts\engine\utility
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xb4e4
// Size: 0x9f
function private function_d4192e0c7c79be61( position, duration, altposition )
{
    if ( !isdefined( duration ) )
    {
        duration = 5;
    }
    
    if ( !isdefined( altposition ) )
    {
        altposition = undefined;
    }
    
    assert( isplayer( self ) );
    player = self;
    player notify( "player_prestream_camera" );
    player endon( "player_prestream_camera" );
    player endon( "death_or_disconnect" );
    player clearadditionalstreampos();
    
    if ( isdefined( altposition ) )
    {
        player setadditionalstreamposuntilcleared( altposition );
    }
    
    player predictstreamposuntilcleared( position );
    
    if ( duration > 0 )
    {
        wait duration;
    }
    else if ( duration < 0 )
    {
        return;
    }
    
    player clearadditionalstreampos();
    player clearpredictedstreampos();
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xb58b
// Size: 0xab
function player_prestream_entities( entities, distances, duration )
{
    if ( !isdefined( duration ) )
    {
        duration = 5;
    }
    
    if ( !isarray( entities ) )
    {
        entities = [ entities ];
    }
    
    if ( !isdefined( distances ) )
    {
        distances = [];
        
        foreach ( entity in entities )
        {
            distances[ distances.size ] = 50;
        }
    }
    else if ( !isarray( distances ) )
    {
        distances = [ distances ];
    }
    
    thread function_28548c8e56c0b115( entities, distances, duration );
}

// Namespace utility / scripts\engine\utility
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xb63e
// Size: 0xc9
function private function_28548c8e56c0b115( entities, distances, duration )
{
    assert( isplayer( self ) );
    player = self;
    player notify( "player_prestream_entities" );
    player endon( "player_prestream_entities" );
    player endon( "disconnect" );
    player function_bab9acc2cf205a62();
    
    foreach ( idx, entity in entities )
    {
        if ( isdefined( entity ) )
        {
            entity function_af96f7c8819ae854( player, distances[ idx ] );
        }
    }
    
    if ( duration > 0 )
    {
        wait duration;
    }
    else if ( duration < 0 )
    {
        return;
    }
    
    if ( isplayer( player ) )
    {
        player function_bab9acc2cf205a62();
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xb70f
// Size: 0x1b
function distance_2d_squared( a, b )
{
    return length2dsquared( a - b );
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0xb733
// Size: 0x56
function get_array_of_farthest( org, array, excluders, max, maxdist, mindist )
{
    aarray = get_array_of_closest( org, array, excluders, max, maxdist, mindist );
    aarray = array_reverse( aarray );
    return aarray;
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0xb792
// Size: 0x1d7
function get_array_of_closest( org, array, excluders, max, maxdist, mindist )
{
    if ( !isdefined( max ) )
    {
        max = array.size;
    }
    
    if ( !isdefined( excluders ) )
    {
        excluders = [];
    }
    
    maxdist2rd = undefined;
    
    if ( isdefined( maxdist ) )
    {
        maxdist2rd = maxdist * maxdist;
    }
    
    mindist2rd = 0;
    
    if ( isdefined( mindist ) )
    {
        mindist2rd = mindist * mindist;
    }
    
    if ( excluders.size == 0 && max >= array.size && mindist2rd == 0 && !isdefined( maxdist2rd ) )
    {
        return sortbydistance( array, org );
    }
    
    newarray = [];
    
    foreach ( ent in array )
    {
        excluded = 0;
        
        foreach ( excluder in excluders )
        {
            if ( ent == excluder )
            {
                excluded = 1;
                break;
            }
        }
        
        if ( excluded )
        {
            continue;
        }
        
        dist2rd = distancesquared( org, ent.origin );
        
        if ( isdefined( maxdist2rd ) && dist2rd > maxdist2rd )
        {
            continue;
        }
        
        if ( dist2rd < mindist2rd )
        {
            continue;
        }
        
        newarray[ newarray.size ] = ent;
    }
    
    newarray = sortbydistance( newarray, org );
    
    if ( max >= newarray.size )
    {
        return newarray;
    }
    
    finalarray = [];
    
    for ( i = 0; i < max ; i++ )
    {
        finalarray[ i ] = newarray[ i ];
    }
    
    return finalarray;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xb972
// Size: 0x96
function function_f7a98d43838654af( org, array, maxdist )
{
    maxdistsquared = maxdist * maxdist;
    finalarray = [];
    
    foreach ( ent in array )
    {
        if ( distance2dsquared( org, ent.origin ) < maxdistsquared )
        {
            finalarray[ finalarray.size ] = ent;
        }
    }
    
    return finalarray;
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0xba11
// Size: 0x9a
function drop_to_ground( pos, updist, downdist, upvector, contents )
{
    assertex( isdefined( pos ), "<dev string:x8af>" );
    
    if ( !isdefined( updist ) )
    {
        updist = 1500;
    }
    
    if ( !isdefined( downdist ) )
    {
        downdist = -12000;
    }
    
    if ( !isdefined( contents ) )
    {
        contents = scripts\engine\trace::create_solid_ai_contents( 1 );
    }
    
    if ( isdefined( upvector ) )
    {
        return scripts\engine\trace::ray_trace( pos + updist * upvector, pos + downdist * upvector, undefined, contents )[ "position" ];
    }
    
    return scripts\engine\trace::ray_trace( pos + ( 0, 0, updist ), pos + ( 0, 0, downdist ), undefined, contents )[ "position" ];
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0xbab3
// Size: 0x91
function player_drop_to_ground( pos, radius, updist, downdist, upvector )
{
    if ( !isdefined( updist ) )
    {
        updist = 1500;
    }
    
    if ( !isdefined( downdist ) )
    {
        downdist = -12000;
    }
    
    contents = scripts\engine\trace::create_solid_ai_contents( 1 );
    
    if ( isdefined( upvector ) )
    {
        return scripts\engine\trace::sphere_trace( pos + updist * upvector, pos + downdist * upvector, radius, undefined, contents )[ "position" ];
    }
    
    return scripts\engine\trace::sphere_trace( pos + ( 0, 0, updist ), pos + ( 0, 0, downdist ), radius, undefined, contents )[ "position" ];
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0xbb4c
// Size: 0xab
function function_114e5c055b13dacf( pos, up_dist, down_dist, z_tolerance )
{
    z_tolerance = default_to( z_tolerance, 32 );
    ground_pos = drop_to_ground( pos, up_dist, down_dist );
    navmesh_pos = getclosestpointonnavmesh( ground_pos, undefined, 0, 0, 0 );
    
    if ( isdefined( navmesh_pos ) )
    {
        max_z = max( ground_pos[ 2 ], navmesh_pos[ 2 ] );
        min_z = min( ground_pos[ 2 ], navmesh_pos[ 2 ] );
        
        if ( max_z - min_z <= z_tolerance )
        {
            final_pos = ( navmesh_pos[ 0 ], navmesh_pos[ 1 ], max_z );
            return final_pos;
        }
    }
    
    return undefined;
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0xbc00
// Size: 0x5c, Type: bool
function within_fov( start_origin, start_angles, end_origin, fov )
{
    normal = vectornormalize( end_origin - start_origin );
    forward = anglestoforward( start_angles );
    dot = vectordot( forward, normal );
    return dot >= fov;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xbc65
// Size: 0x4f
function ai_3d_sighting_model( associatedent )
{
    assert( isai( self ) );
    
    if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs[ "ai_3d_sighting_model" ] ) )
    {
        return self [[ level.bot_funcs[ "ai_3d_sighting_model" ] ]]( associatedent );
    }
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xbcbc
// Size: 0x5d
function getclosest( org, array, maxdist )
{
    if ( array.size == 0 )
    {
        return undefined;
    }
    
    ent = sortbydistance( array, org )[ 0 ];
    
    if ( isdefined( maxdist ) && distancesquared( org, ent.origin ) > squared( maxdist ) )
    {
        return undefined;
    }
    
    return ent;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xbd22
// Size: 0xc3
function function_4d046f33253e46e0( org, array, maxdist )
{
    closestent = undefined;
    closestdistance = ter_op( isdefined( maxdist ), maxdist, undefined );
    
    foreach ( ent in array )
    {
        if ( !isdefined( ent.origin ) )
        {
            continue;
        }
        
        distancesq = distancesquared( ent.origin, org );
        
        if ( !isdefined( closestdistance ) || distancesq < closestdistance )
        {
            closestent = ent;
            closestdistance = distancesq;
        }
    }
    
    return closestent;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xbdee
// Size: 0x87
function missile_settargetandflightmode( target, mode, offset )
{
    assert( isdefined( target ) );
    assert( isdefined( mode ) );
    offset = ter_op( isdefined( offset ), offset, ( 0, 0, 0 ) );
    self missile_settargetent( target, offset );
    
    switch ( mode )
    {
        case #"hash_da8b50286ccc05fc":
            self missile_setflightmodedirect();
            break;
        case #"hash_6d308d6c437ce11c":
            self missile_setflightmodetop();
            break;
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xbe7d
// Size: 0x52
function add_fx( fx_id, fx_path )
{
    if ( !isdefined( level._effect ) )
    {
        level._effect = [];
    }
    
    assert( isdefined( fx_path ) );
    assert( isdefined( fx_id ) );
    level._effect[ fx_id ] = loadfx( fx_path );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xbed7
// Size: 0x37
function create_func_ref( name, func )
{
    if ( !isdefined( level.func ) )
    {
        level.func = [];
    }
    
    level.func[ name ] = func;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xbf16
// Size: 0x3e
function create_empty_func_ref( name )
{
    if ( !isdefined( level.func ) )
    {
        level.func = [];
    }
    
    if ( !isdefined( level.func[ name ] ) )
    {
        create_func_ref( name, &empty_init_func );
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xbf5c
// Size: 0x25, Type: bool
function func_ref_exist( name )
{
    return isdefined( level.func ) && isdefined( level.func[ name ] );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xbf8a
// Size: 0x4a, Type: bool
function add_init_script( name, init_function )
{
    if ( !isdefined( level.init_script ) )
    {
        level.init_script = [];
    }
    
    if ( isdefined( level.init_script[ name ] ) )
    {
        return false;
    }
    
    level.init_script[ name ] = init_function;
    return true;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xbfdd
// Size: 0x48
function add_frame_event( event )
{
    if ( !isdefined( self.frame_events ) )
    {
        self.frame_events = [ event ];
        thread process_frame_events();
        return;
    }
    
    self.frame_events[ self.frame_events.size ] = event;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xc02d
// Size: 0x65
function process_frame_events()
{
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        foreach ( event in self.frame_events )
        {
            self thread [[ event ]]();
        }
        
        waitframe();
    }
}

// Namespace utility / scripts\engine\utility
// Params 9
// Checksum 0x0, Offset: 0xc09a
// Size: 0x60
function delaythread( timer, func, param1, param2, param3, param4, param5, param6, param7 )
{
    thread delaythread_proc( func, undefined, timer, param1, param2, param3, param4, param5, param6, param7 );
}

// Namespace utility / scripts\engine\utility
// Params 10
// Checksum 0x0, Offset: 0xc102
// Size: 0x69
function delaythreadendon( timer, endonevent, func, param1, param2, param3, param4, param5, param6, param7 )
{
    thread delaythread_proc( func, endonevent, timer, param1, param2, param3, param4, param5, param6, param7 );
}

// Namespace utility / scripts\engine\utility
// Params 10
// Checksum 0x0, Offset: 0xc173
// Size: 0x18f
function delaythread_proc( func, endonevent, timer, param1, param2, param3, param4, param5, param6, param7 )
{
    if ( isdefined( self ) && !isarray( self ) )
    {
        self endon( "stop_delay_thread" );
        
        if ( isent( self ) && isplayer( self ) )
        {
            self endon( "death_or_disconnect" );
        }
        else
        {
            self endon( "death" );
        }
        
        if ( isdefined( endonevent ) )
        {
            if ( !isarray( endonevent ) )
            {
                endonevent = [ endonevent ];
            }
            
            foreach ( endonname in endonevent )
            {
                self endon( endonname );
            }
        }
    }
    
    wait timer;
    
    if ( isdefined( param7 ) )
    {
        thread [[ func ]]( param1, param2, param3, param4, param5, param6, param7 );
        return;
    }
    
    if ( isdefined( param6 ) )
    {
        thread [[ func ]]( param1, param2, param3, param4, param5, param6 );
        return;
    }
    
    if ( isdefined( param5 ) )
    {
        thread [[ func ]]( param1, param2, param3, param4, param5 );
        return;
    }
    
    if ( isdefined( param4 ) )
    {
        thread [[ func ]]( param1, param2, param3, param4 );
        return;
    }
    
    if ( isdefined( param3 ) )
    {
        thread [[ func ]]( param1, param2, param3 );
        return;
    }
    
    if ( isdefined( param2 ) )
    {
        thread [[ func ]]( param1, param2 );
        return;
    }
    
    if ( isdefined( param1 ) )
    {
        thread [[ func ]]( param1 );
        return;
    }
    
    thread [[ func ]]();
}

// Namespace utility / scripts\engine\utility
// Params 12
// Checksum 0x0, Offset: 0xc30a
// Size: 0x1a8
function damagelocationisany( a, b, c, d, e, f, g, h, i, j, k, ovr )
{
    if ( isdefined( self.damagelocation ) )
    {
        if ( !isdefined( a ) )
        {
            return 0;
        }
        
        if ( self.damagelocation == a )
        {
            return 1;
        }
        
        if ( !isdefined( b ) )
        {
            return 0;
        }
        
        if ( self.damagelocation == b )
        {
            return 1;
        }
        
        if ( !isdefined( c ) )
        {
            return 0;
        }
        
        if ( self.damagelocation == c )
        {
            return 1;
        }
        
        if ( !isdefined( d ) )
        {
            return 0;
        }
        
        if ( self.damagelocation == d )
        {
            return 1;
        }
        
        if ( !isdefined( e ) )
        {
            return 0;
        }
        
        if ( self.damagelocation == e )
        {
            return 1;
        }
        
        if ( !isdefined( f ) )
        {
            return 0;
        }
        
        if ( self.damagelocation == f )
        {
            return 1;
        }
        
        if ( !isdefined( g ) )
        {
            return 0;
        }
        
        if ( self.damagelocation == g )
        {
            return 1;
        }
        
        if ( !isdefined( h ) )
        {
            return 0;
        }
        
        if ( self.damagelocation == h )
        {
            return 1;
        }
        
        if ( !isdefined( i ) )
        {
            return 0;
        }
        
        if ( self.damagelocation == i )
        {
            return 1;
        }
        
        if ( !isdefined( j ) )
        {
            return 0;
        }
        
        if ( self.damagelocation == j )
        {
            return 1;
        }
        
        if ( !isdefined( k ) )
        {
            return 0;
        }
        
        if ( self.damagelocation == k )
        {
            return 1;
        }
        
        assert( !isdefined( ovr ) );
    }
    
    return damagesubpartlocationisany( a, b, c, d, e, f, g, h, i, j, k, ovr );
}

// Namespace utility / scripts\engine\utility
// Params 12
// Checksum 0x0, Offset: 0xc4bb
// Size: 0x193, Type: bool
function damagesubpartlocationisany( a, b, c, d, e, f, g, h, i, j, k, ovr )
{
    if ( !isdefined( self.damagedsubpart ) )
    {
        return false;
    }
    
    if ( !isdefined( a ) )
    {
        return false;
    }
    
    if ( self.damagedsubpart == a )
    {
        return true;
    }
    
    if ( !isdefined( b ) )
    {
        return false;
    }
    
    if ( self.damagedsubpart == b )
    {
        return true;
    }
    
    if ( !isdefined( c ) )
    {
        return false;
    }
    
    if ( self.damagedsubpart == c )
    {
        return true;
    }
    
    if ( !isdefined( d ) )
    {
        return false;
    }
    
    if ( self.damagedsubpart == d )
    {
        return true;
    }
    
    if ( !isdefined( e ) )
    {
        return false;
    }
    
    if ( self.damagedsubpart == e )
    {
        return true;
    }
    
    if ( !isdefined( f ) )
    {
        return false;
    }
    
    if ( self.damagedsubpart == f )
    {
        return true;
    }
    
    if ( !isdefined( g ) )
    {
        return false;
    }
    
    if ( self.damagedsubpart == g )
    {
        return true;
    }
    
    if ( !isdefined( h ) )
    {
        return false;
    }
    
    if ( self.damagedsubpart == h )
    {
        return true;
    }
    
    if ( !isdefined( i ) )
    {
        return false;
    }
    
    if ( self.damagedsubpart == i )
    {
        return true;
    }
    
    if ( !isdefined( j ) )
    {
        return false;
    }
    
    if ( self.damagedsubpart == j )
    {
        return true;
    }
    
    if ( !isdefined( k ) )
    {
        return false;
    }
    
    if ( self.damagedsubpart == k )
    {
        return true;
    }
    
    assert( !isdefined( ovr ) );
    return false;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xc657
// Size: 0x61
function isbulletdamage( meansofdeath )
{
    if ( !isdefined( meansofdeath ) )
    {
        assertmsg( "<dev string:x8e9>" );
        return 0;
    }
    
    switch ( meansofdeath )
    {
        case #"hash_590bdb04e515167b":
        case #"hash_5f1054c48d66fd1c":
        case #"hash_966768b3f0c94767":
            return 1;
        default:
            return 0;
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xc6c0
// Size: 0x2a, Type: bool
function isfiredamage( meansofdeath )
{
    if ( !isdefined( meansofdeath ) )
    {
        assertmsg( "<dev string:x911>" );
        return false;
    }
    
    return meansofdeath == "MOD_FIRE";
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xc6f3
// Size: 0x2a, Type: bool
function isimpactdamage( meansofdeath )
{
    if ( !isdefined( meansofdeath ) )
    {
        assertmsg( "<dev string:x911>" );
        return false;
    }
    
    return meansofdeath == "MOD_IMPACT";
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xc726
// Size: 0x2a, Type: bool
function ismeleedamage( meansofdeath )
{
    if ( !isdefined( meansofdeath ) )
    {
        assertmsg( "<dev string:x937>" );
        return false;
    }
    
    return meansofdeath == "MOD_MELEE";
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xc759
// Size: 0x32, Type: bool
function isvehiclecrushdamage( inflictor, meansofdeath )
{
    if ( !isdefined( inflictor ) || !isdefined( inflictor.vehiclename ) )
    {
        return false;
    }
    
    return meansofdeath == "MOD_CRUSH";
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xc794
// Size: 0x74, Type: bool
function isvalidpeekoutdir( dir )
{
    node = self;
    peekouts = node getvalidcoverpeekouts();
    
    foreach ( peekout in peekouts )
    {
        if ( peekout == dir )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xc811
// Size: 0x1f6
function getbestcovermultinodetype( node )
{
    assert( isai( self ) );
    nodetypelist = node getvalidcovermultinodetypes();
    
    if ( nodetypelist.size <= 0 )
    {
        return undefined;
    }
    
    yaw_diff = 0;
    
    if ( isdefined( self.enemy ) )
    {
        enemy_pos = self.enemy.origin;
        
        if ( issentient( self.enemy ) && self lastknowntime( self.enemy ) > 0 )
        {
            enemy_pos = self lastknownpos( self.enemy );
        }
        
        var_72c1ba1a734c19e6 = vectortoangles( enemy_pos - node.origin );
        yaw_diff = angleclamp180( var_72c1ba1a734c19e6[ 1 ] - node.angles[ 1 ] );
    }
    
    foreach ( nodetypeit in nodetypelist )
    {
        switch ( nodetypeit )
        {
            case #"hash_78b110033ccb68b0":
            case #"hash_c3b74422dec48736":
                if ( abs( yaw_diff ) < 30 )
                {
                    return nodetypeit;
                }
                
                break;
            case #"hash_55ed607005f12d49":
            case #"hash_e1d8e1adebed5a61":
                if ( yaw_diff > 30 )
                {
                    return "Cover Left";
                }
                
                break;
            case #"hash_667bc7e605903a6c":
            case #"hash_cd3ffe799551db82":
                if ( yaw_diff < -30 )
                {
                    return "Cover Right";
                }
                
                break;
            default:
                assertmsg( "<dev string:x95e>" );
                break;
        }
    }
    
    nodetype = nodetypelist[ 0 ];
    
    switch ( nodetype )
    {
        case #"hash_55ed607005f12d49":
            return "Cover Left";
        case #"hash_667bc7e605903a6c":
            return "Cover Right";
    }
    
    return nodetype;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xca10
// Size: 0x37, Type: bool
function isnodecoverleft( node )
{
    assert( isdefined( node ) && isdefined( node.type ) );
    return node.type == "Cover Left";
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xca50
// Size: 0x37, Type: bool
function isnodecoverright( node )
{
    assert( isdefined( node ) && isdefined( node.type ) );
    return node.type == "Cover Right";
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xca90
// Size: 0x61, Type: bool
function isnodecovercrouchtype( node, type )
{
    assert( isdefined( node ) );
    
    if ( node.type == "Cover Crouch" && isdefined( self._blackboard.croucharrivaltype ) )
    {
        return ( self._blackboard.croucharrivaltype == type );
    }
    
    return false;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xcafa
// Size: 0x1d, Type: bool
function isnode3d( node )
{
    return isnodecover3d( node ) || isnodeexposed3d( node );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xcb20
// Size: 0x4c, Type: bool
function isnodecover3d( node )
{
    assert( isdefined( node ) && isdefined( node.type ) );
    return node.type == "Cover Stand 3D" || node.type == "Cover 3D";
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xcb75
// Size: 0x4c, Type: bool
function isnodeexposed3d( node )
{
    assert( isdefined( node ) && isdefined( node.type ) );
    return node.type == "Exposed 3D" || node.type == "Path 3D";
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xcbca
// Size: 0x61, Type: bool
function isnodecovercrouch( node )
{
    assert( isdefined( node ) && isdefined( node.type ) );
    return node.type == "Cover Crouch" || node.type == "Cover Crouch Window" || node.type == "Conceal Crouch";
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xcc34
// Size: 0x5f
function getaimyawtopoint( point )
{
    yaw = getyawtospot( point );
    dist = distance( self.origin, point );
    
    if ( dist > 3 )
    {
        anglefudge = asin( -3 / dist );
        yaw -= anglefudge;
    }
    
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xcc9c
// Size: 0x8c
function getyawtospot( spot )
{
    if ( actor_is3d() )
    {
        forward = anglestoforward( self.angles );
        rotatedpos = rotatepointaroundvector( forward, spot - self.origin, self.angles[ 2 ] * -1 );
        spot = rotatedpos + self.origin;
    }
    
    yaw = getyaw( spot ) - self.angles[ 1 ];
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xcd31
// Size: 0x1b
function getyaw( org )
{
    return vectortoyaw( org - self.origin );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xcd55
// Size: 0x5f
function getaimyawtopoint3d( point )
{
    yaw = getyawtospot3d( point );
    dist = distance( self.origin, point );
    
    if ( dist > 3 )
    {
        anglefudge = asin( -3 / dist );
        yaw -= anglefudge;
    }
    
    yaw = angleclamp180( yaw );
    return yaw;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xcdbd
// Size: 0x5c
function getyawtospot3d( spot )
{
    var_2f2845d474ecddd0 = spot - self.origin;
    var_11f7d776431edc42 = rotatevectorinverted( var_2f2845d474ecddd0, self.angles );
    yaw = vectortoyaw( var_11f7d776431edc42 );
    yaw_clamped = angleclamp180( yaw );
    return yaw_clamped;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xce22
// Size: 0x5f
function getaimpitchtopoint3d( point )
{
    pitch = getpitchtospot3d( point );
    dist = distance( self.origin, point );
    
    if ( dist > 3 )
    {
        anglefudge = asin( -3 / dist );
        pitch -= anglefudge;
    }
    
    pitch = angleclamp180( pitch );
    return pitch;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xce8a
// Size: 0x5c
function getpitchtospot3d( spot )
{
    var_2f2845d474ecddd0 = spot - self.origin;
    var_11f7d776431edc42 = rotatevectorinverted( var_2f2845d474ecddd0, self.angles );
    pitch = vectortopitch( var_11f7d776431edc42 );
    pitch_clamped = angleclamp180( pitch );
    return pitch_clamped;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xceef
// Size: 0x48
function getplayerpitch( player )
{
    assert( isplayer( player ) );
    playerangles = player getplayerangles();
    assert( isnumber( playerangles[ 0 ] ) );
    return ( playerangles[ 0 ] + 360 ) % 360;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xcf40
// Size: 0x4a
function getplayeryaw( player )
{
    assert( isplayer( player ) );
    playerangles = player getplayerangles();
    assert( isnumber( playerangles[ 1 ] ) );
    return ( playerangles[ 1 ] + 360 ) % 360;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xcf93
// Size: 0xc, Type: bool
function actor_isspace()
{
    return istrue( self.space );
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xcfa8
// Size: 0x8, Type: bool
function actor_is3d()
{
    return actor_isspace();
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xcfb9
// Size: 0x92
function getpredictedaimyawtoshootentorpos( time, shootent, shootpos )
{
    if ( !isdefined( shootent ) )
    {
        if ( !isdefined( shootpos ) )
        {
            return 0;
        }
        
        return getaimyawtopoint( shootpos );
    }
    
    v = ( 0, 0, 0 );
    
    if ( isplayer( shootent ) )
    {
        v = shootent getvelocity();
    }
    else if ( isai( shootent ) )
    {
        v = shootent.velocity;
    }
    
    predictedpos = shootent.origin + v * time;
    return getaimyawtopoint( predictedpos );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xd054
// Size: 0x92
function getpredictedaimyawtoshootentorpos3d( time, shootent, shootpos )
{
    if ( !isdefined( shootent ) )
    {
        if ( !isdefined( shootpos ) )
        {
            return 0;
        }
        
        return getaimyawtopoint3d( shootpos );
    }
    
    v = ( 0, 0, 0 );
    
    if ( isplayer( shootent ) )
    {
        v = shootent getvelocity();
    }
    else if ( isai( shootent ) )
    {
        v = shootent.velocity;
    }
    
    predictedpos = shootent.origin + v * time;
    return getaimyawtopoint3d( predictedpos );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xd0ef
// Size: 0x92
function getpredictedaimpitchtoshootentorpos3d( time, shootent, shootpos )
{
    if ( !isdefined( shootent ) )
    {
        if ( !isdefined( shootpos ) )
        {
            return 0;
        }
        
        return getaimpitchtopoint3d( shootpos );
    }
    
    v = ( 0, 0, 0 );
    
    if ( isplayer( shootent ) )
    {
        v = shootent getvelocity();
    }
    else if ( isai( shootent ) )
    {
        v = shootent.velocity;
    }
    
    predictedpos = shootent.origin + v * time;
    return getaimpitchtopoint3d( predictedpos );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xd18a
// Size: 0x22, Type: bool
function is_equal( arga, argb )
{
    return isdefined( arga ) && isdefined( argb ) && arga == argb;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xd1b5
// Size: 0x82, Type: bool
function function_5b7e9a4c946f3a13( arg, argarray )
{
    assertex( isarray( argarray ), "<dev string:x997>" );
    
    if ( !isdefined( arg ) )
    {
        return false;
    }
    
    foreach ( value in argarray )
    {
        if ( isdefined( value ) && arg == value )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xd240
// Size: 0x3, Type: bool
function player_is_in_jackal()
{
    return false;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xd24c
// Size: 0x2c
function set_createfx_enabled()
{
    if ( !isdefined( level.createfx_enabled ) )
    {
        level.createfx_enabled = getdvar( @"createfx" ) != "";
    }
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xd280
// Size: 0x26
function flag_set_delayed( message, delay, setter )
{
    wait delay;
    flag_set( message, setter );
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0xd2ae
// Size: 0x162
function noself_array_call( entities, process, var2, var3, var4 )
{
    if ( isdefined( var4 ) )
    {
        foreach ( ent in entities )
        {
            builtin [[ process ]]( ent, var2, var3, var4 );
        }
        
        return;
    }
    
    if ( isdefined( var3 ) )
    {
        foreach ( ent in entities )
        {
            builtin [[ process ]]( ent, var2, var3 );
        }
        
        return;
    }
    
    if ( isdefined( var2 ) )
    {
        foreach ( ent in entities )
        {
            builtin [[ process ]]( ent, var2 );
        }
        
        return;
    }
    
    foreach ( ent in entities )
    {
        builtin [[ process ]]( ent );
    }
}

/#

    // Namespace utility / scripts\engine\utility
    // Params 1
    // Checksum 0x0, Offset: 0xd418
    // Size: 0x29, Type: dev
    function flag_assert( msg )
    {
        assertex( !flag( msg ), "<dev string:x9b4>" + msg + "<dev string:x9bd>" );
    }

#/

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xd449
// Size: 0x36
function flag_wait_either( flag1, flag2 )
{
    for ( ;; )
    {
        if ( flag( flag1 ) )
        {
            return;
        }
        
        if ( flag( flag2 ) )
        {
            return;
        }
        
        level waittill_either( flag1, flag2 );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xd487
// Size: 0x41
function flag_wait_either_return( flag1, flag2 )
{
    if ( flag( flag1 ) )
    {
        return flag1;
    }
    
    if ( flag( flag2 ) )
    {
        return flag2;
    }
    
    msg = level waittill_any_return_2( flag1, flag2 );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xd4d4
// Size: 0x5e
function function_665d474ff040b446( flags )
{
    assertex( isarray( flags ), "<dev string:x9cf>" );
    flags = array_removeundefined( flags );
    
    for ( ;; )
    {
        for ( i = 0; i < flags.size ; i++ )
        {
            if ( flag( flags[ i ] ) )
            {
                return flags[ i ];
            }
        }
        
        level waittill_any_in_array( flags );
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xd53a
// Size: 0x12
function function_51ffc85dd7ebde09( flags )
{
    return function_665d474ff040b446( flags );
}

// Namespace utility / scripts\engine\utility
// Params 6
// Checksum 0x0, Offset: 0xd555
// Size: 0x130
function flag_wait_any( flag1, flag2, flag3, flag4, flag5, flag6 )
{
    array = [];
    
    if ( isdefined( flag6 ) )
    {
        array[ array.size ] = flag1;
        array[ array.size ] = flag2;
        array[ array.size ] = flag3;
        array[ array.size ] = flag4;
        array[ array.size ] = flag5;
        array[ array.size ] = flag6;
    }
    else if ( isdefined( flag5 ) )
    {
        array[ array.size ] = flag1;
        array[ array.size ] = flag2;
        array[ array.size ] = flag3;
        array[ array.size ] = flag4;
        array[ array.size ] = flag5;
    }
    else if ( isdefined( flag4 ) )
    {
        array[ array.size ] = flag1;
        array[ array.size ] = flag2;
        array[ array.size ] = flag3;
        array[ array.size ] = flag4;
    }
    else if ( isdefined( flag3 ) )
    {
        array[ array.size ] = flag1;
        array[ array.size ] = flag2;
        array[ array.size ] = flag3;
    }
    else if ( isdefined( flag2 ) )
    {
        flag_wait_either( flag1, flag2 );
        return;
    }
    else
    {
        assertmsg( "<dev string:xa0e>" );
        return;
    }
    
    for ( ;; )
    {
        for ( i = 0; i < array.size ; i++ )
        {
            if ( flag( array[ i ] ) )
            {
                return;
            }
        }
        
        level waittill_any( flag1, flag2, flag3, flag4, flag5, flag6 );
    }
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0xd68d
// Size: 0x1f3
function flag_wait_any_timeout( timer, flag1, flag2, flag3, flag4, flag5, flag6 )
{
    assertex( isdefined( timer ) && timer > 0, "<dev string:xa45>" );
    timerms = timer * 1000;
    start_time = gettime();
    array = [];
    
    if ( isdefined( flag6 ) )
    {
        array[ array.size ] = flag1;
        array[ array.size ] = flag2;
        array[ array.size ] = flag3;
        array[ array.size ] = flag4;
        array[ array.size ] = flag5;
        array[ array.size ] = flag6;
    }
    else if ( isdefined( flag5 ) )
    {
        array[ array.size ] = flag1;
        array[ array.size ] = flag2;
        array[ array.size ] = flag3;
        array[ array.size ] = flag4;
        array[ array.size ] = flag5;
    }
    else if ( isdefined( flag4 ) )
    {
        array[ array.size ] = flag1;
        array[ array.size ] = flag2;
        array[ array.size ] = flag3;
        array[ array.size ] = flag4;
    }
    else if ( isdefined( flag3 ) )
    {
        array[ array.size ] = flag1;
        array[ array.size ] = flag2;
        array[ array.size ] = flag3;
    }
    else if ( isdefined( flag2 ) )
    {
        array[ array.size ] = flag1;
        array[ array.size ] = flag2;
    }
    else
    {
        assertmsg( "<dev string:xa93>" );
        return;
    }
    
    for ( ;; )
    {
        foreach ( flag_msg in array )
        {
            if ( flag( flag_msg ) )
            {
                return;
            }
        }
        
        curr_time = gettime();
        
        if ( curr_time >= start_time + timerms )
        {
            break;
        }
        
        timeremaining = timerms - curr_time - start_time;
        timeremainingsecs = timeremaining / 1000;
        internal_wait_for_any_flag_or_time_elapses( array, timeremainingsecs );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xd888
// Size: 0x5c
function internal_wait_for_any_flag_or_time_elapses( flag_arr, timer )
{
    foreach ( flag_msg in flag_arr )
    {
        level endon( flag_msg );
    }
    
    wait timer;
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0xd8ec
// Size: 0x105
function flag_wait_any_return( flag1, flag2, flag3, flag4, flag5 )
{
    array = [];
    
    if ( isdefined( flag5 ) )
    {
        array[ array.size ] = flag1;
        array[ array.size ] = flag2;
        array[ array.size ] = flag3;
        array[ array.size ] = flag4;
        array[ array.size ] = flag5;
    }
    else if ( isdefined( flag4 ) )
    {
        array[ array.size ] = flag1;
        array[ array.size ] = flag2;
        array[ array.size ] = flag3;
        array[ array.size ] = flag4;
    }
    else if ( isdefined( flag3 ) )
    {
        array[ array.size ] = flag1;
        array[ array.size ] = flag2;
        array[ array.size ] = flag3;
    }
    else if ( isdefined( flag2 ) )
    {
        msg = flag_wait_either_return( flag1, flag2 );
        return msg;
    }
    else
    {
        assertmsg( "<dev string:xad2>" );
        return;
    }
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( flag( array[ i ] ) )
        {
            return array[ i ];
        }
    }
    
    msg = level waittill_any_return_5( flag1, flag2, flag3, flag4, flag5 );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0xd9fd
// Size: 0x57
function flag_wait_all( flag1, flag2, flag3, flag4 )
{
    if ( isdefined( flag1 ) )
    {
        flag_wait( flag1 );
    }
    
    if ( isdefined( flag2 ) )
    {
        flag_wait( flag2 );
    }
    
    if ( isdefined( flag3 ) )
    {
        flag_wait( flag3 );
    }
    
    if ( isdefined( flag4 ) )
    {
        flag_wait( flag4 );
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xda5c
// Size: 0xc3
function function_7a252abaaa15fcd7( flags )
{
    flags = array_removeundefined( flags );
    
    for ( ;; )
    {
        foreach ( flagname in flags )
        {
            flag_wait( flagname );
        }
        
        flagsetcount = 0;
        
        foreach ( flagname in flags )
        {
            if ( flag( flagname ) )
            {
                flagsetcount++;
            }
        }
        
        if ( flagsetcount == flags.size )
        {
            break;
        }
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xdb27
// Size: 0xc3
function flag_waitopen_all_array( flags )
{
    flags = array_removeundefined( flags );
    
    for ( ;; )
    {
        foreach ( flagname in flags )
        {
            flag_waitopen( flagname );
        }
        
        var_df8bbda6a16dd1cb = 0;
        
        foreach ( flagname in flags )
        {
            if ( !flag( flagname ) )
            {
                var_df8bbda6a16dd1cb++;
            }
        }
        
        if ( var_df8bbda6a16dd1cb == flags.size )
        {
            break;
        }
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xdbf2
// Size: 0x7d
function flag_wait_or_timeout( flagname, timer )
{
    timerms = timer * 1000;
    start_time = gettime();
    
    for ( ;; )
    {
        if ( flag( flagname ) )
        {
            break;
        }
        
        if ( gettime() >= start_time + timerms )
        {
            break;
        }
        
        timeremaining = timerms - gettime() - start_time;
        timeremainingsecs = timeremaining / 1000;
        wait_for_flag_or_time_elapses( flagname, timeremainingsecs );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xdc77
// Size: 0x50
function flag_waitopen_or_timeout( flagname, timer )
{
    start_time = gettime();
    
    for ( ;; )
    {
        if ( !flag( flagname ) )
        {
            break;
        }
        
        if ( gettime() >= start_time + timer * 1000 )
        {
            break;
        }
        
        wait_for_flag_or_time_elapses( flagname, timer );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xdccf
// Size: 0x18
function wait_for_flag_or_time_elapses( flagname, timer )
{
    level endon( flagname );
    wait timer;
}

// Namespace utility / scripts\engine\utility
// Params 10
// Checksum 0x0, Offset: 0xdcef
// Size: 0x69
function noself_delaycall( timer, func, param1, param2, param3, param4, param5, param6, param7, param8 )
{
    thread noself_delaycall_proc( func, timer, param1, param2, param3, param4, param5, param6, param7, param8 );
}

// Namespace utility / scripts\engine\utility
// Params 10
// Checksum 0x0, Offset: 0xdd60
// Size: 0x101
function noself_delaycall_proc( func, timer, param1, param2, param3, param4, param5, param6, param7, param8 )
{
    wait timer;
    
    if ( isdefined( param8 ) )
    {
        builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8 );
        return;
    }
    
    if ( isdefined( param7 ) )
    {
        builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7 );
        return;
    }
    
    if ( isdefined( param6 ) )
    {
        builtin [[ func ]]( param1, param2, param3, param4, param5, param6 );
        return;
    }
    
    if ( isdefined( param5 ) )
    {
        builtin [[ func ]]( param1, param2, param3, param4, param5 );
        return;
    }
    
    if ( isdefined( param4 ) )
    {
        builtin [[ func ]]( param1, param2, param3, param4 );
        return;
    }
    
    if ( isdefined( param3 ) )
    {
        builtin [[ func ]]( param1, param2, param3 );
        return;
    }
    
    if ( isdefined( param2 ) )
    {
        builtin [[ func ]]( param1, param2 );
        return;
    }
    
    if ( isdefined( param1 ) )
    {
        builtin [[ func ]]( param1 );
        return;
    }
    
    builtin [[ func ]]();
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xde69
// Size: 0xc1
function get_target_array( target )
{
    if ( !isdefined( target ) )
    {
        target = self.target;
    }
    
    assertex( isdefined( target ), "<dev string:x7fc>" );
    ents = getentarray( target, "targetname" );
    
    if ( ents.size > 0 )
    {
        return ents;
    }
    
    if ( issp() )
    {
        ents = builtin [[ level.getnodearrayfunction ]]( target, "targetname" );
        
        if ( ents.size > 0 )
        {
            return ents;
        }
    }
    
    if ( isdefined( level.struct_class_names ) )
    {
        ents = getstructarray( target, "targetname" );
        
        if ( ents.size > 0 )
        {
            return ents;
        }
    }
    
    ents = getvehiclenodearray( target, "targetname" );
    
    if ( ents.size > 0 )
    {
        return ents;
    }
    
    assertmsg( "<dev string:x813>" + target + "<dev string:xb10>" );
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xdf32
// Size: 0x9
function pauseeffect()
{
    scripts\common\createfx::stop_fx_looper();
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xdf43
// Size: 0x92
function spawn_script_origin( org, ang )
{
    if ( !isdefined( ang ) && isdefined( self.angles ) )
    {
        ang = self.angles;
    }
    
    if ( !isdefined( org ) && isdefined( self.origin ) )
    {
        org = self.origin;
    }
    else if ( !isdefined( org ) )
    {
        org = ( 0, 0, 0 );
    }
    
    script_origin = spawn( "script_origin", org );
    
    if ( isdefined( ang ) )
    {
        script_origin.angles = ang;
    }
    
    return script_origin;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xdfde
// Size: 0xb1
function get_noteworthy_array( noteworthy )
{
    assertex( isdefined( noteworthy ), "<dev string:xb2c>" );
    ents = getentarray( noteworthy, "script_noteworthy" );
    
    if ( ents.size > 0 )
    {
        return ents;
    }
    
    if ( issp() )
    {
        ents = builtin [[ level.getnodearrayfunction ]]( noteworthy, "script_noteworthy" );
        
        if ( ents.size > 0 )
        {
            return ents;
        }
    }
    
    if ( isdefined( level.struct_class_names ) )
    {
        ents = getstructarray( noteworthy, "script_noteworthy" );
        
        if ( ents.size > 0 )
        {
            return ents;
        }
    }
    
    ents = getvehiclenodearray( noteworthy, "script_noteworthy" );
    
    if ( ents.size > 0 )
    {
        return ents;
    }
    
    assertex( "<dev string:xb4e>" + noteworthy + "<dev string:xb73>" );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xe097
// Size: 0x48
function get_cumulative_weights( weights )
{
    cumulative_weights = [];
    sum = 0;
    
    for ( i = 0; i < weights.size ; i++ )
    {
        sum += weights[ i ];
        cumulative_weights[ i ] = sum;
    }
    
    return cumulative_weights;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xe0e8
// Size: 0x2
function void()
{
    
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xe0f2
// Size: 0x5c
function getanim( anime )
{
    assertex( isdefined( self.animname ), "<dev string:xb8d>" );
    assertex( isdefined( level.scr_anim[ self.animname ][ anime ] ), "<dev string:xbb9>" );
    return level.scr_anim[ self.animname ][ anime ];
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xe157
// Size: 0x39, Type: bool
function hasanim( anime )
{
    assertex( isdefined( self.animname ), "<dev string:xbe1>" );
    return isdefined( level.scr_anim[ self.animname ][ anime ] );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xe199
// Size: 0x4c
function getanim_from_animname( anime, animname )
{
    assertex( isdefined( animname ), "<dev string:xc0d>" );
    assertex( isdefined( level.scr_anim[ animname ][ anime ] ), "<dev string:xc28>" );
    return level.scr_anim[ animname ][ anime ];
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xe1ee
// Size: 0x3c
function getanim_generic( anime )
{
    assertex( isdefined( level.scr_anim[ "<dev string:xc5e>" ][ anime ] ), "<dev string:xc69>" );
    return level.scr_anim[ "generic" ][ anime ];
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xe233
// Size: 0x1d, Type: bool
function hasanim_generic( anime )
{
    return isdefined( level.scr_anim[ "generic" ][ anime ] );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xe259
// Size: 0xd9
function getanim_starts( anime, ent )
{
    startpositions = [];
    
    if ( scripts\common\anim::function_f1e7ee8ddeece062( anime ) )
    {
        foreach ( animation in level.scr_anim[ ent.animname ][ anime ] )
        {
            newanime = scripts\common\anim::function_56bd620e57a834af( anime, ent.animname, animation );
            scripts\common\anim::anim_first_frame_solo( ent, newanime );
            startpositions[ startpositions.size ] = ent.origin;
        }
    }
    else
    {
        scripts\common\anim::anim_first_frame_solo( ent, anime );
        startpositions[ startpositions.size ] = ent.origin;
    }
    
    return startpositions;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xe33b
// Size: 0x4d
function waittill_match_or_timeout( msg, match, timer )
{
    ent = spawnstruct();
    ent endon( "complete" );
    ent delaythread( timer, &send_notify, "complete" );
    self waittillmatch( msg, match );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xe390
// Size: 0x25
function function_ee012c2dd711a8ce( msg, match, endonmsg )
{
    self endon( endonmsg );
    self waittillmatch( msg, match );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xe3bd
// Size: 0x4d
function waittill_match_or_timeout_return( msg, match, timer )
{
    ent = spawnstruct();
    ent endon( "complete" );
    ent delaythread( timer, &send_notify, "complete" );
    self waittill( msg, match );
    return match;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xe413
// Size: 0x24
function send_notify( msg, optional_param )
{
    if ( isdefined( optional_param ) )
    {
        self notify( msg, optional_param );
        return;
    }
    
    self notify( msg );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xe43f
// Size: 0x3b
function get_notetrack_time( animation, notetrack )
{
    notetracktimes = getnotetracktimes( animation, notetrack );
    animlength = getanimlength( animation );
    return notetracktimes[ 0 ] * animlength;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xe483
// Size: 0x12
function mph_to_ips( mph )
{
    return mph * 17.6;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xe49e
// Size: 0x2c
function mph_travel_time( speed, dist )
{
    speed = mph_to_ips( speed );
    time = dist / speed;
    return time;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xe4d3
// Size: 0x12
function ips_to_mph( ips )
{
    return ips * 0.056818;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xe4ee
// Size: 0x12
function function_dd1c9564bbdda261( knots )
{
    return knots * 20.2537;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xe509
// Size: 0x12
function function_de54c0137bbb0d7f( ips )
{
    return ips * 0.049374;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xe524
// Size: 0xe5
function wrap_text( text, line_limit )
{
    tokenized = strtok( text, " " );
    checked_words = "";
    lines = [];
    i = 0;
    total_characters = 0;
    
    foreach ( word in tokenized )
    {
        if ( total_characters > line_limit )
        {
            lines[ lines.size ] = checked_words;
            checked_words = "";
            total_characters = 0;
        }
        
        total_characters += word.size;
        checked_words += word;
        
        if ( i != tokenized.size - 1 )
        {
            checked_words += " ";
        }
        else
        {
            lines[ lines.size ] = checked_words;
        }
        
        i++;
    }
    
    return lines;
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0xe612
// Size: 0x21e
function closestdistancebetweenlines( p1, p2, p3, p4 )
{
    p13 = p1 - p3;
    p43 = p4 - p3;
    
    if ( abs( p43[ 0 ] ) < 1e-06 && abs( p43[ 1 ] ) < 1e-06 && abs( p43[ 2 ] ) < 1e-06 )
    {
        return undefined;
    }
    
    p21 = p2 - p1;
    
    if ( abs( p21[ 0 ] ) < 1e-06 && abs( p21[ 1 ] ) < 1e-06 && abs( p21[ 2 ] ) < 1e-06 )
    {
        return undefined;
    }
    
    d1343 = p13[ 0 ] * p43[ 0 ] + p13[ 1 ] * p43[ 1 ] + p13[ 2 ] * p43[ 2 ];
    d4321 = p43[ 0 ] * p21[ 0 ] + p43[ 1 ] * p21[ 1 ] + p43[ 2 ] * p21[ 2 ];
    d1321 = p13[ 0 ] * p21[ 0 ] + p13[ 1 ] * p21[ 1 ] + p13[ 2 ] * p21[ 2 ];
    d4343 = p43[ 0 ] * p43[ 0 ] + p43[ 1 ] * p43[ 1 ] + p43[ 2 ] * p43[ 2 ];
    d2121 = p21[ 0 ] * p21[ 0 ] + p21[ 1 ] * p21[ 1 ] + p21[ 2 ] * p21[ 2 ];
    denom = d2121 * d4343 - d4321 * d4321;
    
    if ( abs( denom ) < 1e-06 )
    {
        return undefined;
    }
    
    numer = d1343 * d4321 - d1321 * d4343;
    mua = numer / denom;
    mub = ( d1343 + d4321 * mua ) / d4343;
    pa = p1 + mua * p21;
    pb = p3 + mub * p43;
    var_770e3bedd2b80d9b = [ pa, pb, distance( pa, pb ) ];
    return var_770e3bedd2b80d9b;
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0xe839
// Size: 0x262
function closestdistancebetweensegments( p1, p2, p3, p4 )
{
    pdir = p2 - p1;
    qdir = p4 - p3;
    segdelta = p1 - p3;
    pdp = vectordot( pdir, pdir );
    pdq = vectordot( pdir, qdir );
    qdq = vectordot( qdir, qdir );
    pdw = vectordot( pdir, segdelta );
    qdw = vectordot( qdir, segdelta );
    commondenominator = pdp * qdq - pdq * pdq;
    denominatorp = commondenominator;
    denominatorq = commondenominator;
    scalarp = 0;
    numeratorp = 0;
    scalarq = 0;
    numeratorq = 0;
    
    if ( commondenominator < 1e-08 )
    {
        numeratorp = 0;
        denominatorp = 1;
        numeratorq = qdw;
        denominatorq = qdq;
    }
    else
    {
        numeratorp = pdq * qdw - qdq * pdw;
        numeratorq = pdp * qdw - pdq * pdw;
        
        if ( numeratorp < 0 )
        {
            numeratorp = 0;
            numeratorq = qdw;
            denominatorq = qdq;
        }
        else if ( numeratorp > denominatorp )
        {
            numeratorp = denominatorp;
            numeratorq = qdw + pdq;
            denominatorq = qdq;
        }
    }
    
    if ( numeratorq < 0 )
    {
        numeratorq = 0;
        
        if ( pdw * -1 < 0 )
        {
            numeratorp = 0;
        }
        else if ( pdw * -1 > pdp )
        {
            numeratorp = denominatorp;
        }
        else
        {
            numeratorp = pdw * -1;
            denominatorp = pdp;
        }
    }
    else if ( numeratorq > denominatorq )
    {
        numeratorq = denominatorq;
        
        if ( pdq - pdw < 0 )
        {
            numeratorp = 0;
        }
        else if ( pdq - pdw > pdp )
        {
            numeratorp = denominatorp;
        }
        else
        {
            numeratorp = pdq - pdw;
            denominatorp = pdp;
        }
    }
    
    if ( abs( numeratorp ) > 1e-08 )
    {
        scalarp = numeratorp / denominatorp;
    }
    
    if ( abs( numeratorq ) > 1e-08 )
    {
        scalarq = numeratorq / denominatorq;
    }
    
    pa = p1 + scalarp * pdir;
    pb = p3 + scalarq * qdir;
    var_770e3bedd2b80d9b = [ pa, pb, distance( pa, pb ) ];
    return var_770e3bedd2b80d9b;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xeaa4
// Size: 0x12, Type: bool
function is_dead_sentient()
{
    return issentient( self ) && !isalive( self );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xeabf
// Size: 0xd5
function hastag( model, tag )
{
    if ( !isdefined( model ) || model == "" )
    {
        return 0;
    }
    
    if ( !isdefined( level.has_tag ) )
    {
        level.has_tag = [];
    }
    
    key = model + "_" + tag;
    
    if ( isdefined( level.has_tag[ key ] ) )
    {
        return level.has_tag[ key ];
    }
    
    partcount = getnumparts( model );
    
    if ( partcount > 0 )
    {
        for ( i = 0; i < partcount ; i++ )
        {
            partname = getpartname( model, i );
            
            if ( partname == tolower( tag ) )
            {
                level.has_tag[ key ] = 1;
                return 1;
            }
        }
        
        level.has_tag[ key ] = 0;
    }
    
    return 0;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xeb9d
// Size: 0x4a
function flashbanggettimeleftsec()
{
    assert( isdefined( self ) );
    assert( isdefined( self.flashendtime ) );
    durationms = self.flashendtime - gettime();
    
    if ( durationms < 0 )
    {
        return 0;
    }
    
    return durationms * 0.001;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xebf0
// Size: 0xa, Type: bool
function flashbangisactive()
{
    return flashbanggettimeleftsec() > 0;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xec03
// Size: 0x12
function string( num )
{
    return "" + num;
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0xec1e
// Size: 0x4f
function playsoundontag( alias, tag, ends_on_death, var_b426f32755673ba6, radio_dialog )
{
    assert( isdefined( level.fnplaysoundontag ) );
    [[ level.fnplaysoundontag ]]( alias, tag, ends_on_death, var_b426f32755673ba6, radio_dialog );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xec75
// Size: 0x34
function playsoundonentity( alias, var_b426f32755673ba6 )
{
    assert( isdefined( level.fnplaysoundonentity ) );
    [[ level.fnplaysoundonentity ]]( alias, var_b426f32755673ba6 );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xecb1
// Size: 0x28
function set_movement_speed( desiredspeed )
{
    self._blackboard.requestedspeed = desiredspeed;
    self aisetdesiredspeed( desiredspeed );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xece1
// Size: 0x15
function set_cautious_navigation( enabled )
{
    self.cautiousnavigation = enabled;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xecfe
// Size: 0x1b, Type: bool
function doinglongdeath()
{
    assert( isai( self ) );
    return istrue( self.doinglongdeath );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xed22
// Size: 0x44, Type: bool
function is_dead_or_dying( guy )
{
    if ( !isdefined( guy ) )
    {
        return true;
    }
    
    if ( isai( guy ) )
    {
        return ( !isalive( guy ) || guy doinglongdeath() );
    }
    else if ( issentient( guy ) )
    {
        return !isalive( guy );
    }
    
    return false;
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0xed6f
// Size: 0xca
function motionwarpwithnotetracks( anime, targetpos, targetangles, notetrackstart, notetrackend, duration, updateanimrate )
{
    if ( isdefined( notetrackstart ) )
    {
        animstartfrac = getnotetracktimes( anime, notetrackstart )[ 0 ];
        
        if ( !isdefined( animstartfrac ) )
        {
            assertmsg( "<dev string:xc99>" + notetrackstart + "<dev string:xcaf>" );
            animstartfrac = 0;
        }
    }
    else
    {
        animstartfrac = 0;
    }
    
    if ( isdefined( notetrackend ) )
    {
        animendfrac = getnotetracktimes( anime, notetrackend )[ 0 ];
        
        if ( !isdefined( animendfrac ) )
        {
            assertmsg( "<dev string:xcd4>" + notetrackend + "<dev string:xcaf>" );
            animendfrac = 1;
        }
    }
    else
    {
        animendfrac = 1;
    }
    
    motionwarpwithtimes( anime, targetpos, targetangles, animstartfrac, animendfrac, duration, updateanimrate );
}

// Namespace utility / scripts\engine\utility
// Params 7
// Checksum 0x0, Offset: 0xee41
// Size: 0x15b
function motionwarpwithtimes( anime, targetpos, targetangles, animstartfrac, animendfrac, duration, updateanimrate )
{
    if ( !isdefined( updateanimrate ) )
    {
        updateanimrate = 1;
    }
    
    animyawdelta = getangledelta( anime, animstartfrac, animendfrac );
    animtranslationdelta = getmovedelta( anime, animstartfrac, animendfrac );
    animtranslationdelta = rotatevector( animtranslationdelta, ( 0, targetangles[ 1 ] - animyawdelta, 0 ) );
    animstartpos = targetpos - animtranslationdelta;
    animstartyaw = targetangles[ 1 ] - animyawdelta;
    animstartangles = ( targetangles[ 0 ], animstartyaw, targetangles[ 2 ] );
    animrate = 1;
    var_94fbe2a18e7f59b3 = length( targetpos - self.origin );
    
    if ( updateanimrate && var_94fbe2a18e7f59b3 > 0 )
    {
        animrate = length( animtranslationdelta ) / var_94fbe2a18e7f59b3;
        animrate = clamp( animrate, 0.5, 2 );
        self aisetanimrate( anime, animrate );
    }
    
    if ( !isdefined( duration ) )
    {
        animlength = getanimlength( anime ) / animrate;
        duration = int( ( animendfrac - animstartfrac ) * animlength * 1000 );
    }
    
    if ( duration < 50 )
    {
        duration = 50;
    }
    
    self motionwarpwithanim( animstartpos, animstartangles, targetpos, targetangles, duration );
    return animrate;
}

// Namespace utility / scripts\engine\utility
// Params 9
// Checksum 0x0, Offset: 0xefa5
// Size: 0x2ad
function function_df956d52bae0b61d( anime, parentent, tag, localtargetpos, var_b6c5de4898b7f63b, animstartfrac, animendfrac, duration, updateanimrate )
{
    assert( isdefined( anime ) );
    assert( isdefined( animstartfrac ) && animstartfrac >= 0 );
    assert( isdefined( animendfrac ) && animendfrac <= 1 );
    assert( isdefined( parentent ) );
    assert( isdefined( localtargetpos ) );
    assert( isdefined( var_b6c5de4898b7f63b ) );
    
    if ( !isdefined( updateanimrate ) )
    {
        updateanimrate = 1;
    }
    
    if ( isdefined( tag ) )
    {
        linkpos = parentent gettagorigin( tag );
        linkang = parentent gettagangles( tag );
    }
    else
    {
        linkpos = parentent.origin;
        linkang = parentent.angles;
        tag = "";
    }
    
    worldtargetpos = linkpos + rotatevector( localtargetpos, linkang );
    var_8248003e7165c71e = combineangles( var_b6c5de4898b7f63b, linkang );
    var_5201fba058886642 = getangledelta3d( anime, animstartfrac, animendfrac );
    animposdelta = getmovedelta( anime, animstartfrac, animendfrac );
    var_f7bd065066febebf = invertangles( var_5201fba058886642 );
    var_f03bd42b04ee3dca = combineangles( var_8248003e7165c71e, var_f7bd065066febebf );
    var_ca6be8926624acbf = rotatevector( -1 * animposdelta, var_f7bd065066febebf );
    var_ca86acbc27e4a31c = rotatevector( var_ca6be8926624acbf, var_8248003e7165c71e );
    worldanimstartpos = worldtargetpos + var_ca86acbc27e4a31c;
    var_7b1c8fcebb9c392d = self.origin - linkpos;
    invlinkang = invertangles( linkang );
    localtargetpos = rotatevector( var_7b1c8fcebb9c392d, invlinkang );
    var_b6c5de4898b7f63b = combineangles( self.angles, invlinkang );
    animrate = 1;
    var_94fbe2a18e7f59b3 = length( worldtargetpos - self.origin );
    
    if ( updateanimrate && var_94fbe2a18e7f59b3 > 0 )
    {
        animrate = length( animposdelta ) / var_94fbe2a18e7f59b3;
        animrate = clamp( animrate, 0.5, 2 );
        self aisetanimrate( anime, animrate );
    }
    
    if ( !isdefined( duration ) )
    {
        animlength = getanimlength( anime ) / animrate;
        duration = int( ( animendfrac - animstartfrac ) * animlength * 1000 );
    }
    
    if ( duration < 50 )
    {
        duration = 50;
    }
    
    self linktomoveoffset( parentent, tag, localtargetpos, var_b6c5de4898b7f63b );
    self motionwarpwithanim( worldanimstartpos, var_f03bd42b04ee3dca, worldtargetpos, var_8248003e7165c71e, duration );
}

// Namespace utility / scripts\engine\utility
// Params 15
// Checksum 0x0, Offset: 0xf25a
// Size: 0x17e
function waittill_any_ents_or_timeout_return( timeout, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7 )
{
    assert( isdefined( timeout ) );
    assert( isdefined( ent1 ) );
    assert( isdefined( string1 ) );
    self endon( "death" );
    ent = spawnstruct();
    ent1 childthread waittill_string( string1, ent );
    
    if ( isdefined( ent2 ) && isdefined( string2 ) )
    {
        ent2 childthread waittill_string( string2, ent );
    }
    
    if ( isdefined( ent3 ) && isdefined( string3 ) )
    {
        ent3 childthread waittill_string( string3, ent );
    }
    
    if ( isdefined( ent4 ) && isdefined( string4 ) )
    {
        ent4 childthread waittill_string( string4, ent );
    }
    
    if ( isdefined( ent5 ) && isdefined( string5 ) )
    {
        ent5 childthread waittill_string( string5, ent );
    }
    
    if ( isdefined( ent6 ) && isdefined( string6 ) )
    {
        ent6 childthread waittill_string( string6, ent );
    }
    
    if ( isdefined( ent7 ) && isdefined( string7 ) )
    {
        ent7 childthread waittill_string( string7, ent );
    }
    
    ent childthread timeout_struct( timeout );
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xf3e1
// Size: 0x27, Type: bool
function time_has_passed( timestamp, seconds )
{
    if ( !isdefined( timestamp ) )
    {
        return false;
    }
    
    return gettime() - timestamp >= seconds * 1000;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xf411
// Size: 0x23
function reacttolightifpossible( lightorigin )
{
    self.lightreaction_lightorigin = lightorigin;
    self.lightreaction_requesttime = gettime();
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xf43c
// Size: 0x74
function setcovercrouchtype( covertype )
{
    switch ( covertype )
    {
        case #"hash_96815ce4f2a3dbc5":
            self.covercrouchtype = "Cover Right Crouch";
            break;
        case #"hash_c9b3133a17a3b2d0":
            self.covercrouchtype = "Cover Left Crouch";
            break;
        case #"hash_3fed0cbd303639eb":
        default:
            self.covercrouchtype = "Cover Crouch";
            break;
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xf4b8
// Size: 0x16
function setcornerstepoutsdisabled( disabled )
{
    self.cornerstepoutsdisabled = istrue( disabled );
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xf4d6
// Size: 0xc, Type: bool
function getcornerstepoutsdisabled()
{
    return istrue( self.cornerstepoutsdisabled );
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0xf4eb
// Size: 0x89
function can_trace_to_ai( start, ai, ignoreentarray, contentoverride )
{
    if ( isent( self ) || isai( self ) )
    {
        ignoregroup = [ self, ai ];
    }
    else
    {
        ignoregroup = [ ai ];
    }
    
    if ( isdefined( ignoreentarray ) )
    {
        ignoregroup = array_combine( ignoregroup, ignoreentarray );
    }
    
    content = ter_op( isdefined( contentoverride ), contentoverride, scripts\engine\trace::create_default_contents() );
    return cantracetoai( ai, start, ignoreentarray, content );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xf57d
// Size: 0x9a
function array_removedead_or_dying( array, var_5c3b6418c0ad64ae )
{
    if ( !isdefined( var_5c3b6418c0ad64ae ) )
    {
        var_5c3b6418c0ad64ae = 1;
    }
    
    newarray = [];
    
    foreach ( member in array )
    {
        if ( !isalive( member ) )
        {
            continue;
        }
        
        if ( isai( member ) && var_5c3b6418c0ad64ae && member doinglongdeath() )
        {
            continue;
        }
        
        newarray[ newarray.size ] = member;
    }
    
    return newarray;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xf620
// Size: 0x36
function disable_pain()
{
    assertex( isai( self ), "<dev string:xce8>" );
    self.a.disablepain = 1;
    self.allowpain = 0;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xf65e
// Size: 0x36
function enable_pain()
{
    assertex( isai( self ), "<dev string:xd0d>" );
    self.a.disablepain = 0;
    self.allowpain = 1;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xf69c
// Size: 0x1f
function get_ai_number()
{
    if ( !isdefined( self.unique_id ) )
    {
        set_ai_number();
    }
    
    return self.unique_id;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xf6c4
// Size: 0x3b
function set_ai_number()
{
    if ( !isdefined( level.ai_number ) )
    {
        level.ai_number = 0;
    }
    
    self.unique_id = "ai" + level.ai_number;
    level.ai_number++;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xf707
// Size: 0x1c
function function_82581894f5a1c71c()
{
    self.var_8aa9efe6383c1d5a = "ai" + getpersistentainumber();
    incrementpersistentainumber();
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xf72b
// Size: 0x47
function ent_flag_wait( msg )
{
    assertex( !issentient( self ) && isdefined( self ) || isalive( self ), "<dev string:xd31>" );
    
    while ( isdefined( self ) && !ent_flag( msg ) )
    {
        self waittill( msg );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xf77a
// Size: 0xae
function array_ent_flag_wait( entities, flag )
{
    notifystruct = spawnstruct();
    
    foreach ( entity in entities )
    {
        if ( entity ent_flag( flag ) )
        {
            entities = array_remove( entities, entity );
        }
    }
    
    array_thread( entities, &array_ent_flag_wait_proc, notifystruct, flag );
    
    for ( i = 0; i < entities.size ; i++ )
    {
        notifystruct waittill( "notify" );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xf830
// Size: 0x23
function array_ent_flag_wait_proc( notifystruct, flag )
{
    ent_flag_wait( flag );
    notifystruct notify( "notify" );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xf85b
// Size: 0x32
function ent_flag_wait_vehicle_node( msg )
{
    assertex( isdefined( self ), "<dev string:xd73>" );
    
    while ( isdefined( self ) && !ent_flag( msg ) )
    {
        self waittill( msg );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xf895
// Size: 0x5f
function ent_flag_wait_either( flag1, flag2 )
{
    assertex( !issentient( self ) && isdefined( self ) || isalive( self ), "<dev string:xd31>" );
    
    while ( isdefined( self ) )
    {
        if ( ent_flag( flag1 ) )
        {
            return;
        }
        
        if ( ent_flag( flag2 ) )
        {
            return;
        }
        
        waittill_either( flag1, flag2 );
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xf8fc
// Size: 0xc3
function function_243c46ee6332c45d( flags )
{
    flags = array_removeundefined( flags );
    
    for ( ;; )
    {
        foreach ( flagname in flags )
        {
            ent_flag_wait( flagname );
        }
        
        flagsetcount = 0;
        
        foreach ( flagname in flags )
        {
            if ( ent_flag( flagname ) )
            {
                flagsetcount++;
            }
        }
        
        if ( flagsetcount == flags.size )
        {
            break;
        }
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xf9c7
// Size: 0xc3
function function_cba0984334ba3279( flags )
{
    flags = array_removeundefined( flags );
    
    for ( ;; )
    {
        foreach ( flagname in flags )
        {
            ent_flag_waitopen( flagname );
        }
        
        var_e9edcc859df58c2e = 0;
        
        foreach ( flagname in flags )
        {
            if ( !ent_flag( flagname ) )
            {
                var_e9edcc859df58c2e++;
            }
        }
        
        if ( var_e9edcc859df58c2e == flags.size )
        {
            break;
        }
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xfa92
// Size: 0x98
function function_e205428b44d1a83c( flags )
{
    flags = array_removeundefined( flags );
    assertex( !issentient( self ) && isdefined( self ) || isalive( self ), "<dev string:xd31>" );
    
    while ( isdefined( self ) )
    {
        foreach ( flagname in flags )
        {
            if ( !ent_flag( flagname ) )
            {
                return;
            }
        }
        
        waittill_any_in_array_return( flags );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xfb32
// Size: 0x7a
function ent_flag_wait_or_timeout( flagname, timer )
{
    assertex( !issentient( self ) && isdefined( self ) || isalive( self ), "<dev string:xd31>" );
    start_time = gettime();
    
    while ( isdefined( self ) )
    {
        if ( ent_flag( flagname ) )
        {
            break;
        }
        
        if ( gettime() >= start_time + timer * 1000 )
        {
            break;
        }
        
        ent_wait_for_flag_or_time_elapses( flagname, timer );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xfbb4
// Size: 0x18
function ent_wait_for_flag_or_time_elapses( flagname, timer )
{
    self endon( flagname );
    wait timer;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xfbd4
// Size: 0x47
function ent_flag_waitopen( msg )
{
    assertex( !issentient( self ) && isdefined( self ) || isalive( self ), "<dev string:xd31>" );
    
    while ( isdefined( self ) && ent_flag( msg ) )
    {
        self waittill( msg );
    }
}

/#

    // Namespace utility / scripts\engine\utility
    // Params 1
    // Checksum 0x0, Offset: 0xfc23
    // Size: 0x29, Type: dev
    function ent_flag_assert( msg )
    {
        assertex( !ent_flag( msg ), "<dev string:x9b4>" + msg + "<dev string:xdad>" );
    }

#/

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xfc54
// Size: 0x5f
function ent_flag_waitopen_either( flag1, flag2 )
{
    assertex( !issentient( self ) && isdefined( self ) || isalive( self ), "<dev string:xd31>" );
    
    while ( isdefined( self ) )
    {
        if ( !ent_flag( flag1 ) )
        {
            return;
        }
        
        if ( !ent_flag( flag2 ) )
        {
            return;
        }
        
        waittill_either( flag1, flag2 );
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xfcbb
// Size: 0x87
function ent_flag_init( message )
{
    if ( !isdefined( self.ent_flag ) )
    {
        self.ent_flag = [];
        self.ent_flags_lock = [];
    }
    
    /#
        if ( isdefined( level.first_frame ) && level.first_frame == -1 )
        {
            assertex( !ent_flag_exist( message ), "<dev string:x288>" + message + "<dev string:xdc8>" );
        }
    #/
    
    self.ent_flag[ message ] = 0;
    
    /#
        self.ent_flags_lock[ message ] = 0;
    #/
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xfd4a
// Size: 0x2c, Type: bool
function ent_flag_exist( message )
{
    if ( isdefined( self.ent_flag ) && isdefined( self.ent_flag[ message ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xfd7f
// Size: 0x24
function ent_flag_set_delayed( message, delay )
{
    self endon( "death" );
    wait delay;
    ent_flag_set( message );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xfdab
// Size: 0x80
function ent_flag_set( message )
{
    assertex( isdefined( self ), "<dev string:xdd7>" );
    assertex( isdefined( message ), "<dev string:x253>" );
    
    if ( !ent_flag_exist( message ) )
    {
        ent_flag_init( message );
    }
    
    /#
        assert( self.ent_flag[ message ] == self.ent_flags_lock[ message ] );
        self.ent_flags_lock[ message ] = 1;
    #/
    
    self.ent_flag[ message ] = 1;
    self notify( message );
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xfe33
// Size: 0xa1
function ent_flag_clear( message, remove )
{
    /#
        assertex( isdefined( self ), "<dev string:xe0e>" );
        
        if ( ent_flag_exist( message ) )
        {
            assert( self.ent_flag[ message ] == self.ent_flags_lock[ message ] );
        }
        
        self.ent_flags_lock[ message ] = 0;
    #/
    
    if ( ent_flag( message ) )
    {
        self.ent_flag[ message ] = 0;
        self notify( message );
    }
    
    if ( ent_flag_exist( message ) && istrue( remove ) )
    {
        self.ent_flag[ message ] = undefined;
        
        /#
            self.ent_flags_lock[ message ] = undefined;
        #/
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0xfedc
// Size: 0x22
function ent_flag_clear_delayed( message, delay )
{
    wait delay;
    
    if ( isdefined( self ) )
    {
        ent_flag_clear( message );
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0xff06
// Size: 0x31, Type: bool
function ent_flag( message )
{
    assertex( isdefined( message ), "<dev string:x253>" );
    return ent_flag_exist( message ) && self.ent_flag[ message ];
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0xff40
// Size: 0x6e
function get_linked_structs()
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            structs = getstructarray( linknames[ i ], "script_linkname" );
            
            if ( structs.size > 0 )
            {
                array = array_combine( array, structs );
            }
        }
    }
    
    return array;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0xffb7
// Size: 0x71, Type: bool
function ispointinsidecircle( point, circlecenter, circleradius )
{
    assert( isvector( point ) );
    assert( isvector( circlecenter ) );
    assert( isnumber( circleradius ) );
    
    if ( squared( point[ 0 ] - circlecenter[ 0 ] ) + squared( point[ 1 ] - circlecenter[ 1 ] ) <= squared( circleradius ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x10031
// Size: 0x53
function requestgamerprofile( var_d40db77fec61d6a4 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self sendrequestgamerprofilecmd( var_d40db77fec61d6a4 );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, value );
        
        if ( channel == "gamerprofile_request" )
        {
            return value;
        }
    }
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x1008c
// Size: 0x44, Type: bool
function ismountconfigenabled()
{
    var_6c9fe414d3f3d966 = 1;
    mountconfig = 0;
    
    if ( is_player_gamepad_enabled() )
    {
        mountconfig = requestgamerprofile( "mountButtonConfig" );
    }
    else
    {
        mountconfig = requestgamerprofile( "mountButtonConfigKBM" );
    }
    
    return mountconfig != var_6c9fe414d3f3d966;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x100d9
// Size: 0x44, Type: bool
function function_4319aef954ddbee5()
{
    var_f9ac1524e38018a2 = 1;
    toggletacticaladsconfig = 0;
    
    if ( is_player_gamepad_enabled() )
    {
        toggletacticaladsconfig = requestgamerprofile( "toggleTacticalADSConfig" );
    }
    else
    {
        toggletacticaladsconfig = requestgamerprofile( "toggleTacticalADSConfigKBM" );
    }
    
    return toggletacticaladsconfig != var_f9ac1524e38018a2;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x10126
// Size: 0x53, Type: bool
function function_9ec2f480552af944( player )
{
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:xe47>" );
        return false;
    }
    
    if ( player usinggamepad() )
    {
        var_43c445e16f561dce = player getcurrentusereloadconfig();
        return ( var_43c445e16f561dce == 0 || var_43c445e16f561dce == 3 );
    }
    
    return player getuseholdkbmprofile() == 1;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x10182
// Size: 0x20
function getintorzero( value )
{
    if ( isnumber( value ) )
    {
        return int( value );
    }
    
    return 0;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x101aa
// Size: 0x5f
function stringtovec3( input )
{
    output = ( 0, 0, 0 );
    values = strtok( input, " " );
    
    if ( values.size == 3 )
    {
        output = ( float( values[ 0 ] ), float( values[ 1 ] ), float( values[ 2 ] ) );
    }
    
    return output;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x10212
// Size: 0x52
function queue_create( capacity )
{
    queue = spawnstruct();
    queue.capacity = capacity;
    queue.array = [];
    queue.front = 0;
    queue.rear = -1;
    return queue;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x1026d
// Size: 0xae
function function_6cf786a6cf335cb9( queue, object )
{
    if ( queue.array.size == queue.capacity )
    {
        assertex( 0, "<dev string:xe82>" );
        return queue;
    }
    
    if ( queue.array.size != queue.capacity && queue.rear + 1 >= queue.capacity )
    {
        queue.rear = 0;
    }
    else
    {
        queue.rear++;
    }
    
    queue.array[ queue.rear ] = object;
    return queue;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x10324
// Size: 0xbc
function function_93def91a50927481( queue )
{
    if ( queue.array.size == 0 )
    {
        assertex( 0, "<dev string:xeb6>" );
        return queue;
    }
    
    queue.array[ queue.front ] = undefined;
    
    if ( queue.array.size > 0 && queue.front + 1 >= queue.capacity )
    {
        queue.front = 0;
    }
    else
    {
        queue.front++;
    }
    
    if ( queue.array.size == 0 )
    {
        queue.front = 0;
        queue.rear = -1;
    }
    
    return queue;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x103e9
// Size: 0x44
function queue_peek( queue )
{
    if ( queue.array.size == 0 )
    {
        assertex( 0, "<dev string:xeeb>" );
        return undefined;
    }
    
    return queue.array[ queue.front ];
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x10436
// Size: 0x17
function queue_size( queue )
{
    return queue.array.size;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x10456
// Size: 0x3f
function queue_clear( queue )
{
    queue.array = [];
    queue.front = 0;
    queue.rear = -1;
    return queue.array.size;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x1049e
// Size: 0x19, Type: bool
function queue_isempty( queue )
{
    return queue.array.size == 0;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x104c0
// Size: 0xa0, Type: bool
function function_a6025442a4e1c649( queue, object )
{
    if ( !isdefined( queue ) || !isdefined( object ) )
    {
        return false;
    }
    
    tempcount = 0;
    i = queue.front;
    
    while ( tempcount < queue.array.size )
    {
        if ( !isdefined( queue.array[ i ] ) )
        {
        }
        else
        {
            if ( queue.array[ i ] == object )
            {
                return true;
            }
            
            if ( i + 1 >= queue.capacity )
            {
                i = 0;
            }
            else
            {
                i++;
            }
        }
        
        tempcount++;
    }
    
    return false;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x10569
// Size: 0x12
function function_c89ed1840c8d0f0f( milliseconds )
{
    return milliseconds * 0.001;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x10584
// Size: 0x12
function function_a5b14435e3229bed( seconds )
{
    return seconds * 1000;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x1059f
// Size: 0x27
function single_thread_argarray( entity, func, a_vars )
{
    single_thread( entity, func, undefined, undefined, a_vars );
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x105ce
// Size: 0x2f
function function_8a68123e2bbb5ba4( entity, func, arg1, a_vars )
{
    single_thread( entity, func, arg1, undefined, a_vars );
}

// Namespace utility / scripts\engine\utility
// Params 5
// Checksum 0x0, Offset: 0x10605
// Size: 0x37
function function_8a68133e2bbb5dd7( entity, func, arg1, arg2, a_vars )
{
    single_thread( entity, func, arg1, arg2, a_vars );
}

// Namespace utility / scripts\engine\utility
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x10644
// Size: 0x4b3
function private single_thread( entity, func, arg1, arg2, a_vars )
{
    a_vars = function_d13634fdb31beeaf( a_vars );
    assert( isfunction( func ) );
    
    if ( !isfunction( func ) )
    {
        return;
    }
    
    if ( isdefined( arg2 ) )
    {
        switch ( a_vars.size )
        {
            case 8:
                entity thread [[ func ]]( arg1, arg2, a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ], a_vars[ 6 ], a_vars[ 7 ] );
                break;
            case 7:
                entity thread [[ func ]]( arg1, arg2, a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ], a_vars[ 6 ] );
                break;
            case 6:
                entity thread [[ func ]]( arg1, arg2, a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ] );
                break;
            case 5:
                entity thread [[ func ]]( arg1, arg2, a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ] );
                break;
            case 4:
                entity thread [[ func ]]( arg1, arg2, a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ] );
                break;
            case 3:
                entity thread [[ func ]]( arg1, arg2, a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ] );
                break;
            case 2:
                entity thread [[ func ]]( arg1, arg2, a_vars[ 0 ], a_vars[ 1 ] );
                break;
            case 1:
                entity thread [[ func ]]( arg1, arg2, a_vars[ 0 ] );
                break;
            case 0:
                entity thread [[ func ]]( arg1, arg2 );
                break;
            default:
                assertmsg( "<dev string:xf1c>" );
                break;
        }
        
        return;
    }
    
    if ( isdefined( arg1 ) )
    {
        switch ( a_vars.size )
        {
            case 8:
                entity thread [[ func ]]( arg1, a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ], a_vars[ 6 ], a_vars[ 7 ] );
                break;
            case 7:
                entity thread [[ func ]]( arg1, a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ], a_vars[ 6 ] );
                break;
            case 6:
                entity thread [[ func ]]( arg1, a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ] );
                break;
            case 5:
                entity thread [[ func ]]( arg1, a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ] );
                break;
            case 4:
                entity thread [[ func ]]( arg1, a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ] );
                break;
            case 3:
                entity thread [[ func ]]( arg1, a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ] );
                break;
            case 2:
                entity thread [[ func ]]( arg1, a_vars[ 0 ], a_vars[ 1 ] );
                break;
            case 1:
                entity thread [[ func ]]( arg1, a_vars[ 0 ] );
                break;
            case 0:
                entity thread [[ func ]]( arg1 );
                break;
            default:
                assertmsg( "<dev string:xf1c>" );
                break;
        }
        
        return;
    }
    
    switch ( a_vars.size )
    {
        case 8:
            entity thread [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ], a_vars[ 6 ], a_vars[ 7 ] );
            break;
        case 7:
            entity thread [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ], a_vars[ 6 ] );
            break;
        case 6:
            entity thread [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ] );
            break;
        case 5:
            entity thread [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ] );
            break;
        case 4:
            entity thread [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ] );
            break;
        case 3:
            entity thread [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ] );
            break;
        case 2:
            entity thread [[ func ]]( a_vars[ 0 ], a_vars[ 1 ] );
            break;
        case 1:
            entity thread [[ func ]]( a_vars[ 0 ] );
            break;
        case 0:
            entity thread [[ func ]]();
            break;
        default:
            assertmsg( "<dev string:xf1c>" );
            break;
    }
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x10aff
// Size: 0x24
function single_func_argarray( entity, func, a_vars )
{
    return function_a057e1f7cf74f00( entity, func, a_vars );
}

// Namespace utility / scripts\engine\utility
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x10b2c
// Size: 0x278
function private function_a057e1f7cf74f00( entity, func, a_vars )
{
    a_vars = function_d13634fdb31beeaf( a_vars );
    
    switch ( a_vars.size )
    {
        case 8:
            if ( isdefined( entity ) )
            {
                return entity [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ], a_vars[ 6 ], a_vars[ 7 ] );
            }
            else
            {
                return [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ], a_vars[ 6 ], a_vars[ 7 ] );
            }
            
            break;
        case 7:
            if ( isdefined( entity ) )
            {
                return entity [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ], a_vars[ 6 ] );
            }
            else
            {
                return [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ], a_vars[ 6 ] );
            }
            
            break;
        case 6:
            if ( isdefined( entity ) )
            {
                return entity [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ] );
            }
            else
            {
                return [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ], a_vars[ 5 ] );
            }
            
            break;
        case 5:
            if ( isdefined( entity ) )
            {
                return entity [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ] );
            }
            else
            {
                return [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ], a_vars[ 4 ] );
            }
            
            break;
        case 4:
            if ( isdefined( entity ) )
            {
                return entity [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ] );
            }
            else
            {
                return [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ], a_vars[ 3 ] );
            }
            
            break;
        case 3:
            if ( isdefined( entity ) )
            {
                return entity [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ] );
            }
            else
            {
                return [[ func ]]( a_vars[ 0 ], a_vars[ 1 ], a_vars[ 2 ] );
            }
            
            break;
        case 2:
            if ( isdefined( entity ) )
            {
                return entity [[ func ]]( a_vars[ 0 ], a_vars[ 1 ] );
            }
            else
            {
                return [[ func ]]( a_vars[ 0 ], a_vars[ 1 ] );
            }
            
            break;
        case 1:
            if ( isdefined( entity ) )
            {
                return entity [[ func ]]( a_vars[ 0 ] );
            }
            else
            {
                return [[ func ]]( a_vars[ 0 ] );
            }
            
            break;
        case 0:
            if ( isdefined( entity ) )
            {
                return entity [[ func ]]();
            }
            else
            {
                return [[ func ]]();
            }
            
            break;
        default:
            assertmsg( "<dev string:xf1c>" );
            break;
    }
}

// Namespace utility / scripts\engine\utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x10dac
// Size: 0x6f
function private function_d13634fdb31beeaf( a_vars )
{
    var_d9d0128c23712f95 = -1;
    
    for ( i = a_vars.size - 1; i >= 0 ; i-- )
    {
        if ( !isdefined( a_vars[ i ] ) )
        {
            var_d9d0128c23712f95 = i;
            continue;
        }
        
        break;
    }
    
    if ( var_d9d0128c23712f95 == -1 )
    {
        return a_vars;
    }
    
    var_4c1b085372d0c223 = [];
    
    for ( i = 0; i < var_d9d0128c23712f95 ; i++ )
    {
        var_4c1b085372d0c223[ i ] = a_vars[ i ];
    }
    
    return var_4c1b085372d0c223;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x10e24
// Size: 0x3f
function vtos( vector )
{
    return "(" + int( vector[ 0 ] ) + " " + int( vector[ 1 ] ) + " " + int( vector[ 2 ] ) + ")";
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x10e6c
// Size: 0x1b
function absolutevalue( inputvalue )
{
    if ( inputvalue >= 0 )
    {
        return inputvalue;
    }
    
    return -1 * inputvalue;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x10e8f
// Size: 0xf7
function create_partition( array, cell_size )
{
    assert( isdefined( array ), "<dev string:xf2e>" );
    assert( isarray( array ), "<dev string:xf5d>" );
    assert( isdefined( cell_size ), "<dev string:xfa0>" );
    assert( isfloat( cell_size ) || isint( cell_size ), "<dev string:xfd3>" );
    partition = spawnstruct();
    partition.array = [];
    partition.cell_size = cell_size;
    partition.coordinate_add = int( 150000 / 2 * cell_size );
    
    foreach ( object in array )
    {
        partition function_24bbefb4beda630d( object );
    }
    
    return partition;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x10f8f
// Size: 0x2e, Type: bool
function is_partition()
{
    return isdefined( self ) && isdefined( self.array ) && isdefined( self.cell_size ) && isdefined( self.coordinate_add );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x10fc6
// Size: 0xf2
function function_24bbefb4beda630d( object )
{
    assert( is_partition(), "<dev string:x101f>" );
    assert( isdefined( object ), "<dev string:x107e>" );
    assert( isdefined( object.origin ), "<dev string:x10ae>" );
    [ x, y ] = function_5b83b054e7f1c193( object.origin );
    var_56c8714742ff3c04 = self.array[ x ];
    
    if ( !isdefined( var_56c8714742ff3c04 ) )
    {
        self.array[ x ] = [];
        var_56c8714742ff3c04 = [];
    }
    
    var_dd613b6808c13588 = var_56c8714742ff3c04[ y ];
    
    if ( !isdefined( var_dd613b6808c13588 ) )
    {
        self.array[ x ][ y ] = [];
        var_f9ce76ad7118b7ec = 0;
    }
    else
    {
        var_f9ce76ad7118b7ec = var_dd613b6808c13588.size;
    }
    
    self.array[ x ][ y ][ var_f9ce76ad7118b7ec ] = object;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x110c0
// Size: 0xb5
function function_5b83b054e7f1c193( vector )
{
    assert( is_partition(), "<dev string:x10ee>" );
    assert( isdefined( vector ), "<dev string:x115b>" );
    assert( isvector( vector ), "<dev string:x1199>" );
    cell_size = self.cell_size;
    coordinate_add = self.coordinate_add;
    x = int( vector[ 0 ] / cell_size ) + coordinate_add;
    
    if ( x < 0 )
    {
        x = 0;
    }
    
    y = int( vector[ 1 ] / cell_size ) + coordinate_add;
    
    if ( y < 0 )
    {
        y = 0;
    }
    
    return [ x, y ];
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x1117e
// Size: 0xf8
function function_9cd3f5f067afea37( object )
{
    assert( is_partition(), "<dev string:x11ea>" );
    assert( isdefined( object ), "<dev string:x124e>" );
    assert( isdefined( object.origin ), "<dev string:x1283>" );
    [ x, y ] = function_5b83b054e7f1c193( object.origin );
    var_56c8714742ff3c04 = self.array[ x ];
    
    if ( isdefined( var_56c8714742ff3c04 ) && isdefined( var_56c8714742ff3c04[ y ] ) )
    {
        self.array[ x ][ y ] = array_remove( var_56c8714742ff3c04[ y ], object );
        
        if ( self.array[ x ][ y ].size == 0 )
        {
            self.array[ x ][ y ] = undefined;
            
            if ( self.array[ x ].size == 0 )
            {
                self.array[ x ] = undefined;
            }
        }
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x1127e
// Size: 0xa1
function function_99b7cb4906b8cb4f( vector )
{
    assert( is_partition(), "<dev string:x12c8>" );
    assert( isdefined( vector ), "<dev string:x132f>" );
    assert( isvector( vector ), "<dev string:x1368>" );
    [ x, y ] = function_5b83b054e7f1c193( vector );
    var_56c8714742ff3c04 = self.array[ x ];
    
    if ( isdefined( var_56c8714742ff3c04 ) )
    {
        var_dd613b6808c13588 = var_56c8714742ff3c04[ y ];
        
        if ( isdefined( var_dd613b6808c13588 ) )
        {
            return var_dd613b6808c13588;
        }
    }
    
    return [];
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x11328
// Size: 0x11b
function function_df633f460888a47( vector )
{
    assert( is_partition(), "<dev string:x13b3>" );
    assert( isdefined( vector ), "<dev string:x1424>" );
    assert( isvector( vector ), "<dev string:x1466>" );
    [ x, y ] = function_5b83b054e7f1c193( vector );
    adjacent_arrays = [];
    
    for ( x_offset = -1; x_offset <= 1 ; x_offset++ )
    {
        x_test = x + x_offset;
        
        if ( x_test < 0 )
        {
            continue;
        }
        
        var_56c8714742ff3c04 = self.array[ x_test ];
        
        if ( !isdefined( var_56c8714742ff3c04 ) )
        {
            continue;
        }
        
        for ( y_offset = -1; y_offset <= 1 ; y_offset++ )
        {
            y_test = y + y_offset;
            
            if ( y_test < 0 )
            {
                continue;
            }
            
            var_dd613b6808c13588 = var_56c8714742ff3c04[ y_test ];
            
            if ( !isdefined( var_dd613b6808c13588 ) )
            {
                continue;
            }
            
            adjacent_arrays[ adjacent_arrays.size ] = var_dd613b6808c13588;
        }
    }
    
    return adjacent_arrays;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x1144c
// Size: 0x1b2
function function_60dbe20f8385f1b0( vector )
{
    assert( is_partition(), "<dev string:x14bb>" );
    assert( isdefined( vector ), "<dev string:x1533>" );
    assert( isvector( vector ), "<dev string:x157c>" );
    [ x, y ] = function_5b83b054e7f1c193( vector );
    closest_object = undefined;
    var_84d7de0b98e2e704 = undefined;
    
    for ( x_offset = -1; x_offset <= 1 ; x_offset++ )
    {
        x_test = x + x_offset;
        
        if ( x_test < 0 )
        {
            continue;
        }
        
        var_56c8714742ff3c04 = self.array[ x_test ];
        
        if ( !isdefined( var_56c8714742ff3c04 ) )
        {
            continue;
        }
        
        for ( y_offset = -1; y_offset <= 1 ; y_offset++ )
        {
            y_test = y + y_offset;
            
            if ( y_test < 0 )
            {
                continue;
            }
            
            var_dd613b6808c13588 = var_56c8714742ff3c04[ y_test ];
            
            if ( !isdefined( var_dd613b6808c13588 ) )
            {
                continue;
            }
            
            foreach ( object in var_dd613b6808c13588 )
            {
                if ( !isdefined( object ) || !isdefined( object.origin ) )
                {
                    continue;
                }
                
                distance_squared = distancesquared( object.origin, vector );
                
                if ( !isdefined( var_84d7de0b98e2e704 ) || distance_squared < var_84d7de0b98e2e704 )
                {
                    var_84d7de0b98e2e704 = distance_squared;
                    closest_object = object;
                }
            }
        }
    }
    
    return closest_object;
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x11607
// Size: 0x7d
function registersharedfunc( category, funcname, function, nooverride )
{
    if ( !isdefined( level.sharedfuncs ) )
    {
        level.sharedfuncs = [];
    }
    
    if ( !isdefined( level.sharedfuncs[ category ] ) )
    {
        level.sharedfuncs[ category ] = [];
    }
    
    if ( isdefined( level.sharedfuncs[ category ][ funcname ] ) && istrue( nooverride ) )
    {
        return;
    }
    
    level.sharedfuncs[ category ][ funcname ] = function;
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x1168c
// Size: 0x87
function function_3bd171ed299fd530( category, funcname, function, forceremove )
{
    if ( isdefined( level.sharedfuncs ) && isdefined( level.sharedfuncs[ category ] ) )
    {
        if ( isdefined( level.sharedfuncs[ category ][ funcname ] ) )
        {
            if ( istrue( forceremove ) || level.sharedfuncs[ category ][ funcname ] == function )
            {
                level.sharedfuncs[ category ] = array_remove_key( level.sharedfuncs[ category ], funcname );
            }
        }
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x1171b
// Size: 0x3e
function function_7ae9075c73180af7( category )
{
    if ( !isdefined( level.sharedfuncs ) )
    {
        level.sharedfuncs = [];
    }
    
    if ( !isdefined( level.sharedfuncs[ category ] ) )
    {
        level.sharedfuncs[ category ] = [];
    }
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x11761
// Size: 0x75, Type: bool
function issharedfuncdefined( category, funcname, shouldassert )
{
    if ( !isdefined( level.sharedfuncs ) )
    {
        return false;
    }
    
    if ( !isdefined( level.sharedfuncs[ category ] ) )
    {
        return false;
    }
    
    func = getsharedfunc( category, funcname );
    
    if ( !isdefined( func ) )
    {
        if ( istrue( shouldassert ) )
        {
            assertmsg( category + "<dev string:x15d8>" + funcname + "<dev string:x15de>" );
        }
        
        return false;
    }
    
    return true;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x117df
// Size: 0x31
function function_6a11999c562cf4ab( category, funcname )
{
    if ( !isdefined( level.sharedfuncs[ category ] ) )
    {
        return undefined;
    }
    
    return level.sharedfuncs[ category ][ funcname ];
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x11819
// Size: 0x20
function getsharedfunc( category, funcname )
{
    return level.sharedfuncs[ category ][ funcname ];
}

// Namespace utility / scripts\engine\utility
// Params 13
// Checksum 0x0, Offset: 0x11842
// Size: 0x86
function callsharedfunc( category, funcname, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 )
{
    return function_f6734d8246596c7f( category, funcname, 0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 );
}

// Namespace utility / scripts\engine\utility
// Params 13
// Checksum 0x0, Offset: 0x118d1
// Size: 0x87
function function_6d1f056f62ed082a( category, funcname, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 )
{
    return function_f6734d8246596c7f( category, funcname, 1, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 );
}

// Namespace utility / scripts\engine\utility
// Params 14, eflags: 0x4
// Checksum 0x0, Offset: 0x11961
// Size: 0xb7
function private function_f6734d8246596c7f( category, funcname, required, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 )
{
    if ( issharedfuncdefined( category, funcname, required ) )
    {
        func = level.sharedfuncs[ category ][ funcname ];
        return function_a97bcc1cab7d91ee( func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 );
    }
    
    return 0;
}

// Namespace utility / scripts\engine\utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x11a21
// Size: 0x42
function private function_38d3c10d2527cb3a( func )
{
    if ( isfunction( func ) )
    {
        return self [[ func ]]();
    }
    
    if ( isbuiltinfunction( func ) )
    {
        return builtin [[ func ]]();
    }
    
    assert( isbuiltinmethod( func ) );
    return self builtin [[ func ]]();
}

// Namespace utility / scripts\engine\utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x11a6b
// Size: 0x4d
function private function_38d3c20d2527cd6d( func, param1 )
{
    if ( isfunction( func ) )
    {
        return self [[ func ]]( param1 );
    }
    
    if ( isbuiltinfunction( func ) )
    {
        return builtin [[ func ]]( param1 );
    }
    
    assert( isbuiltinmethod( func ) );
    return self builtin [[ func ]]( param1 );
}

// Namespace utility / scripts\engine\utility
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x11ac0
// Size: 0x58
function private function_38d3bf0d2527c6d4( func, param1, param2 )
{
    if ( isfunction( func ) )
    {
        return self [[ func ]]( param1, param2 );
    }
    
    if ( isbuiltinfunction( func ) )
    {
        return builtin [[ func ]]( param1, param2 );
    }
    
    assert( isbuiltinmethod( func ) );
    return self builtin [[ func ]]( param1, param2 );
}

// Namespace utility / scripts\engine\utility
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x11b20
// Size: 0x63
function private function_38d3c00d2527c907( func, param1, param2, param3 )
{
    if ( isfunction( func ) )
    {
        return self [[ func ]]( param1, param2, param3 );
    }
    
    if ( isbuiltinfunction( func ) )
    {
        return builtin [[ func ]]( param1, param2, param3 );
    }
    
    assert( isbuiltinmethod( func ) );
    return self builtin [[ func ]]( param1, param2, param3 );
}

// Namespace utility / scripts\engine\utility
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x11b8b
// Size: 0x6e
function private function_38d3bd0d2527c26e( func, param1, param2, param3, param4 )
{
    if ( isfunction( func ) )
    {
        return self [[ func ]]( param1, param2, param3, param4 );
    }
    
    if ( isbuiltinfunction( func ) )
    {
        return builtin [[ func ]]( param1, param2, param3, param4 );
    }
    
    assert( isbuiltinmethod( func ) );
    return self builtin [[ func ]]( param1, param2, param3, param4 );
}

// Namespace utility / scripts\engine\utility
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x11c01
// Size: 0x79
function private function_38d3be0d2527c4a1( func, param1, param2, param3, param4, param5 )
{
    if ( isfunction( func ) )
    {
        return self [[ func ]]( param1, param2, param3, param4, param5 );
    }
    
    if ( isbuiltinfunction( func ) )
    {
        return builtin [[ func ]]( param1, param2, param3, param4, param5 );
    }
    
    assert( isbuiltinmethod( func ) );
    return self builtin [[ func ]]( param1, param2, param3, param4, param5 );
}

// Namespace utility / scripts\engine\utility
// Params 7, eflags: 0x4
// Checksum 0x0, Offset: 0x11c82
// Size: 0x8a
function private function_38d3bb0d2527be08( func, param1, param2, param3, param4, param5, param6 )
{
    if ( isfunction( func ) )
    {
        return self [[ func ]]( param1, param2, param3, param4, param5, param6 );
    }
    
    if ( isbuiltinfunction( func ) )
    {
        return builtin [[ func ]]( param1, param2, param3, param4, param5, param6 );
    }
    
    assert( isbuiltinmethod( func ) );
    return self builtin [[ func ]]( param1, param2, param3, param4, param5, param6 );
}

// Namespace utility / scripts\engine\utility
// Params 8, eflags: 0x4
// Checksum 0x0, Offset: 0x11d14
// Size: 0x98
function private function_38d3bc0d2527c03b( func, param1, param2, param3, param4, param5, param6, param7 )
{
    if ( isfunction( func ) )
    {
        return self [[ func ]]( param1, param2, param3, param4, param5, param6, param7 );
    }
    
    if ( isbuiltinfunction( func ) )
    {
        return builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7 );
    }
    
    assert( isbuiltinmethod( func ) );
    return self builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7 );
}

// Namespace utility / scripts\engine\utility
// Params 9, eflags: 0x4
// Checksum 0x0, Offset: 0x11db4
// Size: 0xa6
function private function_38d3b90d2527b9a2( func, param1, param2, param3, param4, param5, param6, param7, param8 )
{
    if ( isfunction( func ) )
    {
        return self [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8 );
    }
    
    if ( isbuiltinfunction( func ) )
    {
        return builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8 );
    }
    
    assert( isbuiltinmethod( func ) );
    return self builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8 );
}

// Namespace utility / scripts\engine\utility
// Params 10, eflags: 0x4
// Checksum 0x0, Offset: 0x11e62
// Size: 0xb4
function private function_38d3ba0d2527bbd5( func, param1, param2, param3, param4, param5, param6, param7, param8, param9 )
{
    if ( isfunction( func ) )
    {
        return self [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9 );
    }
    
    if ( isbuiltinfunction( func ) )
    {
        return builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9 );
    }
    
    assert( isbuiltinmethod( func ) );
    return self builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9 );
}

// Namespace utility / scripts\engine\utility
// Params 11, eflags: 0x4
// Checksum 0x0, Offset: 0x11f1e
// Size: 0xc2
function private function_21811fe8b688a387( func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 )
{
    if ( isfunction( func ) )
    {
        return self [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 );
    }
    
    if ( isbuiltinfunction( func ) )
    {
        return builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 );
    }
    
    assert( isbuiltinmethod( func ) );
    return self builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 );
}

// Namespace utility / scripts\engine\utility
// Params 12, eflags: 0x4
// Checksum 0x0, Offset: 0x11fe8
// Size: 0xd0
function private function_21811ee8b688a154( func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 )
{
    if ( isfunction( func ) )
    {
        return self [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 );
    }
    
    if ( isbuiltinfunction( func ) )
    {
        return builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 );
    }
    
    assert( isbuiltinmethod( func ) );
    return self builtin [[ func ]]( param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 );
}

// Namespace utility / scripts\engine\utility
// Params 12, eflags: 0x4
// Checksum 0x0, Offset: 0x120c0
// Size: 0x19c
function private function_a97bcc1cab7d91ee( func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 )
{
    if ( isdefined( param11 ) )
    {
        return function_21811ee8b688a154( func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11 );
    }
    else if ( isdefined( param10 ) )
    {
        return function_21811fe8b688a387( func, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10 );
    }
    else if ( isdefined( param9 ) )
    {
        return function_38d3ba0d2527bbd5( func, param1, param2, param3, param4, param5, param6, param7, param8, param9 );
    }
    else if ( isdefined( param8 ) )
    {
        return function_38d3b90d2527b9a2( func, param1, param2, param3, param4, param5, param6, param7, param8 );
    }
    else if ( isdefined( param7 ) )
    {
        return function_38d3bc0d2527c03b( func, param1, param2, param3, param4, param5, param6, param7 );
    }
    else if ( isdefined( param6 ) )
    {
        return function_38d3bb0d2527be08( func, param1, param2, param3, param4, param5, param6 );
    }
    else if ( isdefined( param5 ) )
    {
        return function_38d3be0d2527c4a1( func, param1, param2, param3, param4, param5 );
    }
    else if ( isdefined( param4 ) )
    {
        return function_38d3bd0d2527c26e( func, param1, param2, param3, param4 );
    }
    else if ( isdefined( param3 ) )
    {
        return function_38d3c00d2527c907( func, param1, param2, param3 );
    }
    else if ( isdefined( param2 ) )
    {
        return function_38d3bf0d2527c6d4( func, param1, param2 );
    }
    else if ( isdefined( param1 ) )
    {
        return function_38d3c20d2527cd6d( func, param1 );
    }
    else
    {
        return function_38d3c10d2527cb3a( func );
    }
    
    return 0;
}

// Namespace utility / scripts\engine\utility
// Params 14
// Checksum 0x0, Offset: 0x12265
// Size: 0x90
function function_a655374a990831d8( ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7 )
{
    return function_ac1863f0deb8a63e( undefined, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7 );
}

// Namespace utility / scripts\engine\utility
// Params 15
// Checksum 0x0, Offset: 0x122fe
// Size: 0x24b
function function_ac1863f0deb8a63e( timeout, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7 )
{
    assert( !isdefined( timeout ) || timeout > 0 );
    assert( isdefined( ent1 ) );
    assert( isdefined( string1 ) );
    self endon( "death" );
    context = spawnstruct();
    context.var_a83666b52ab41e0d = 0;
    context.var_9166fb2e27ecb4b1 = isdefined( ent1 ) && isdefined( string1 ) && string1 == "death" || isdefined( ent2 ) && isdefined( string2 ) && string2 == "death" || isdefined( ent3 ) && isdefined( string3 ) && string3 == "death" || isdefined( ent4 ) && isdefined( string4 ) && string4 == "death" || isdefined( ent5 ) && isdefined( string5 ) && string5 == "death" || isdefined( ent6 ) && isdefined( string6 ) && string6 == "death" || isdefined( ent7 ) && isdefined( string7 ) && string7 == "death";
    function_24b0694682c6934a( ent1, string1, context );
    
    if ( isdefined( ent2 ) && isdefined( string2 ) )
    {
        function_24b0694682c6934a( ent2, string2, context );
    }
    
    if ( isdefined( ent3 ) && isdefined( string3 ) )
    {
        function_24b0694682c6934a( ent3, string3, context );
    }
    
    if ( isdefined( ent4 ) && isdefined( string4 ) )
    {
        function_24b0694682c6934a( ent4, string4, context );
    }
    
    if ( isdefined( ent5 ) && isdefined( string5 ) )
    {
        function_24b0694682c6934a( ent5, string5, context );
    }
    
    if ( isdefined( ent6 ) && isdefined( string6 ) )
    {
        function_24b0694682c6934a( ent6, string6, context );
    }
    
    if ( isdefined( ent7 ) && isdefined( string7 ) )
    {
        function_24b0694682c6934a( ent7, string7, context );
    }
    
    if ( isdefined( timeout ) )
    {
        context childthread timeout_struct( timeout );
    }
    
    context waittill( "returned", msg );
    context notify( "die" );
    return msg;
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x12552
// Size: 0x4a
function function_24b0694682c6934a( entity, message, context )
{
    entity childthread waittill_string( message, context );
    
    if ( !context.var_9166fb2e27ecb4b1 )
    {
        context.var_a83666b52ab41e0d++;
        childthread function_54258b3847b3bbca( entity, context );
    }
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x125a4
// Size: 0x47
function function_54258b3847b3bbca( entity, context )
{
    context endon( "die" );
    entity waittill( "death" );
    context.var_a83666b52ab41e0d--;
    
    if ( context.var_a83666b52ab41e0d == 0 )
    {
        context notify( "returned", undefined );
    }
}

// Namespace utility / scripts\engine\utility
// Params 8
// Checksum 0x0, Offset: 0x125f3
// Size: 0x18d
function function_28551e899093b138( string1, string2, string3, string4, string5, string6, string7, string8 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) && ( !isdefined( string5 ) || string5 != "death" ) && ( !isdefined( string6 ) || string6 != "death" ) && ( !isdefined( string7 ) || string7 != "death" ) && ( !isdefined( string8 ) || string8 != "death" ) )
    {
        self endon( "death" );
    }
    
    struct = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread function_acb8d1f52b2223cb( string1, struct );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread function_acb8d1f52b2223cb( string2, struct );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread function_acb8d1f52b2223cb( string3, struct );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread function_acb8d1f52b2223cb( string4, struct );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread function_acb8d1f52b2223cb( string5, struct );
    }
    
    if ( isdefined( string6 ) )
    {
        childthread function_acb8d1f52b2223cb( string6, struct );
    }
    
    if ( isdefined( string7 ) )
    {
        childthread function_acb8d1f52b2223cb( string7, struct );
    }
    
    if ( isdefined( string8 ) )
    {
        childthread function_acb8d1f52b2223cb( string8, struct );
    }
    
    struct waittill( "returned", results_array );
    struct notify( "struct_delete" );
    return results_array;
}

// Namespace utility / scripts\engine\utility
// Params 9
// Checksum 0x0, Offset: 0x12789
// Size: 0x1cf
function function_b90de82e759099dc( timeout, string1, string2, string3, string4, string5, string6, string7, string8 )
{
    /#
        if ( !isdefined( timeout ) || !isnumber( timeout ) )
        {
            assertmsg( "<dev string:x1601>" );
        }
    #/
    
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) && ( !isdefined( string5 ) || string5 != "death" ) && ( !isdefined( string6 ) || string6 != "death" ) && ( !isdefined( string7 ) || string7 != "death" ) && ( !isdefined( string8 ) || string8 != "death" ) )
    {
        self endon( "death" );
    }
    
    struct = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        childthread function_acb8d1f52b2223cb( string1, struct );
    }
    
    if ( isdefined( string2 ) )
    {
        childthread function_acb8d1f52b2223cb( string2, struct );
    }
    
    if ( isdefined( string3 ) )
    {
        childthread function_acb8d1f52b2223cb( string3, struct );
    }
    
    if ( isdefined( string4 ) )
    {
        childthread function_acb8d1f52b2223cb( string4, struct );
    }
    
    if ( isdefined( string5 ) )
    {
        childthread function_acb8d1f52b2223cb( string5, struct );
    }
    
    if ( isdefined( string6 ) )
    {
        childthread function_acb8d1f52b2223cb( string6, struct );
    }
    
    if ( isdefined( string7 ) )
    {
        childthread function_acb8d1f52b2223cb( string7, struct );
    }
    
    if ( isdefined( string8 ) )
    {
        childthread function_acb8d1f52b2223cb( string8, struct );
    }
    
    if ( timeout > 0 )
    {
        childthread function_cb4bda23f2687c64( struct, "returned", timeout );
    }
    
    struct waittill( "returned", results_array );
    struct notify( "struct_delete" );
    return results_array;
}

// Namespace utility / scripts\engine\utility
// Params 16
// Checksum 0x0, Offset: 0x12961
// Size: 0x2a0
function function_3c010dc06eabfe5f( ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7, ent8, string8 )
{
    /#
        params[ 0 ] = ent1;
        params[ 1 ] = string1;
        params[ 2 ] = ent2;
        params[ 3 ] = string2;
        params[ 4 ] = ent3;
        params[ 5 ] = string3;
        params[ 6 ] = ent4;
        params[ 7 ] = string4;
        params[ 8 ] = ent5;
        params[ 9 ] = string5;
        params[ 10 ] = ent6;
        params[ 11 ] = string6;
        params[ 12 ] = ent7;
        params[ 13 ] = string7;
        params[ 14 ] = ent8;
        params[ 15 ] = string8;
        
        for ( i = 0; i < params.size ; i++ )
        {
            if ( i % 2 == 0 && isdefined( params[ i ] ) && !isent( params[ i ] ) && !isstruct( params[ i ] ) )
            {
                assertmsg( "<dev string:x1655>" + i + 1 + "<dev string:x168d>" + i / 2 + 1 + "<dev string:x1696>" );
            }
            
            if ( i % 2 == 1 && isdefined( params[ i ] ) && !isstring( params[ i ] ) )
            {
                assertmsg( "<dev string:x1655>" + i + 1 + "<dev string:x16db>" + ( i + 1 ) / 2 + "<dev string:x16e7>" );
            }
        }
    #/
    
    struct = spawnstruct();
    
    if ( isdefined( ent1 ) && isdefined( string1 ) )
    {
        ent1 childthread function_acb8d1f52b2223cb( string1, struct );
    }
    
    if ( isdefined( ent2 ) && isdefined( string2 ) )
    {
        ent2 childthread function_acb8d1f52b2223cb( string2, struct );
    }
    
    if ( isdefined( ent3 ) && isdefined( string3 ) )
    {
        ent3 childthread function_acb8d1f52b2223cb( string3, struct );
    }
    
    if ( isdefined( ent4 ) && isdefined( string4 ) )
    {
        ent4 childthread function_acb8d1f52b2223cb( string4, struct );
    }
    
    if ( isdefined( ent5 ) && isdefined( string5 ) )
    {
        ent5 childthread function_acb8d1f52b2223cb( string5, struct );
    }
    
    if ( isdefined( ent6 ) && isdefined( string6 ) )
    {
        ent6 childthread function_acb8d1f52b2223cb( string6, struct );
    }
    
    if ( isdefined( ent7 ) && isdefined( string7 ) )
    {
        ent7 childthread function_acb8d1f52b2223cb( string7, struct );
    }
    
    if ( isdefined( ent8 ) && isdefined( string8 ) )
    {
        ent8 childthread function_acb8d1f52b2223cb( string8, struct );
    }
    
    struct waittill( "returned", results_array );
    struct notify( "struct_delete" );
    return results_array;
}

// Namespace utility / scripts\engine\utility
// Params 17
// Checksum 0x0, Offset: 0x12c0a
// Size: 0x377
function function_ebad8f70ed282931( timeout, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7, ent8, string8 )
{
    /#
        params[ 1 ] = ent1;
        params[ 2 ] = string1;
        params[ 3 ] = ent2;
        params[ 4 ] = string2;
        params[ 5 ] = ent3;
        params[ 6 ] = string3;
        params[ 7 ] = ent4;
        params[ 8 ] = string4;
        params[ 9 ] = ent5;
        params[ 10 ] = string5;
        params[ 11 ] = ent6;
        params[ 12 ] = string6;
        params[ 13 ] = ent7;
        params[ 14 ] = string7;
        params[ 15 ] = ent8;
        params[ 16 ] = string8;
        
        if ( !isdefined( timeout ) || !isnumber( timeout ) )
        {
            assertmsg( "<dev string:x1601>" );
        }
        
        for ( i = 1; i < params.size ; i++ )
        {
            if ( i % 2 == 1 && isdefined( params[ i ] ) && !isent( params[ i ] ) )
            {
                assertmsg( "<dev string:x1655>" + i + 1 + "<dev string:x168d>" + ( i + 1 ) / 2 + "<dev string:x1730>" );
            }
            
            if ( i % 2 == 0 && isdefined( params[ i ] ) && !isstring( params[ i ] ) )
            {
                assertmsg( "<dev string:x1655>" + i + 1 + "<dev string:x16db>" + i / 2 + "<dev string:x1777>" );
            }
        }
    #/
    
    struct = spawnstruct();
    
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) && ( !isdefined( string5 ) || string5 != "death" ) && ( !isdefined( string6 ) || string6 != "death" ) && ( !isdefined( string7 ) || string7 != "death" ) && ( !isdefined( string8 ) || string8 != "death" ) )
    {
        self endon( "death" );
    }
    
    if ( isdefined( ent1 ) && isdefined( string1 ) )
    {
        ent1 childthread function_acb8d1f52b2223cb( string1, struct );
    }
    
    if ( isdefined( ent2 ) && isdefined( string2 ) )
    {
        ent2 childthread function_acb8d1f52b2223cb( string2, struct );
    }
    
    if ( isdefined( ent3 ) && isdefined( string3 ) )
    {
        ent3 childthread function_acb8d1f52b2223cb( string3, struct );
    }
    
    if ( isdefined( ent4 ) && isdefined( string4 ) )
    {
        ent4 childthread function_acb8d1f52b2223cb( string4, struct );
    }
    
    if ( isdefined( ent5 ) && isdefined( string5 ) )
    {
        ent5 childthread function_acb8d1f52b2223cb( string5, struct );
    }
    
    if ( isdefined( ent6 ) && isdefined( string6 ) )
    {
        ent6 childthread function_acb8d1f52b2223cb( string6, struct );
    }
    
    if ( isdefined( ent7 ) && isdefined( string7 ) )
    {
        ent7 childthread function_acb8d1f52b2223cb( string7, struct );
    }
    
    if ( isdefined( ent8 ) && isdefined( string8 ) )
    {
        ent8 childthread function_acb8d1f52b2223cb( string8, struct );
    }
    
    if ( timeout > 0 )
    {
        level childthread function_cb4bda23f2687c64( struct, "returned", timeout );
    }
    
    struct waittill( "returned", results_array );
    struct notify( "struct_delete" );
    return results_array;
}

// Namespace utility / scripts\engine\utility
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x12f8a
// Size: 0x4b
function private function_cb4bda23f2687c64( ent, msg, timeout )
{
    self endon( msg );
    wait timeout;
    results = [];
    results[ "ent" ] = undefined;
    results[ "message" ] = "timeout";
    ent notify( "returned", results );
}

// Namespace utility / scripts\engine\utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x12fdd
// Size: 0x137
function private function_acb8d1f52b2223cb( msg, struct )
{
    if ( msg != "death" )
    {
        self endon( "death" );
    }
    
    struct endon( "struct_delete" );
    self waittill( msg, parm1, parm2, parm3, parm4, var_77895a5b8a625552, var_7789595b8a62531f, var_7789585b8a6250ec, var_77895f5b8a626051, var_77895e5b8a625e1e, parm10 );
    result = [];
    
    if ( isdefined( parm1 ) )
    {
        result[ 0 ] = parm1;
    }
    
    if ( isdefined( parm2 ) )
    {
        result[ 1 ] = parm2;
    }
    
    if ( isdefined( parm3 ) )
    {
        result[ 2 ] = parm3;
    }
    
    if ( isdefined( parm4 ) )
    {
        result[ 3 ] = parm4;
    }
    
    if ( isdefined( var_77895a5b8a625552 ) )
    {
        result[ 4 ] = var_77895a5b8a625552;
    }
    
    if ( isdefined( var_7789595b8a62531f ) )
    {
        result[ 5 ] = var_7789595b8a62531f;
    }
    
    if ( isdefined( var_7789585b8a6250ec ) )
    {
        result[ 6 ] = var_7789585b8a6250ec;
    }
    
    if ( isdefined( var_77895f5b8a626051 ) )
    {
        result[ 7 ] = var_77895f5b8a626051;
    }
    
    if ( isdefined( var_77895e5b8a625e1e ) )
    {
        result[ 8 ] = var_77895e5b8a625e1e;
    }
    
    if ( isdefined( parm10 ) )
    {
        result[ 9 ] = parm10;
    }
    
    result[ "ent" ] = self;
    result[ "message" ] = msg;
    struct notify( "returned", result );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x1311c
// Size: 0x7c
function string_to_bool( the_string )
{
    retval = undefined;
    
    switch ( the_string )
    {
        case #"hash_31100fbc01bd387c":
        case #"hash_8328fb6e4f43ba45":
            retval = 1;
            break;
        case #"hash_311010bc01bd3a0f":
        case #"hash_a9152f56f0c74738":
            retval = 0;
            break;
        default:
            assertmsg( "<dev string:x17bd>" );
            break;
    }
    
    return retval;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x131a1
// Size: 0x18
function get_int_or_0( value )
{
    if ( !isdefined( value ) )
    {
        return 0;
    }
    
    return int( value );
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x131c2
// Size: 0x101
function function_5e9baece4185ee1e( bundlename )
{
    if ( !isxhashasset( bundlename ) )
    {
        bundlename = getxhashasset( tolower( bundlename ) );
    }
    
    if ( !isdefined( level.globalbundles ) )
    {
        level.globalbundles = [];
    }
    
    if ( !isdefined( level.globalbundles[ bundlename ] ) )
    {
        level.globalbundles[ bundlename ] = [];
        level.globalbundles[ bundlename ][ 0 ] = getscriptbundle( bundlename );
        
        if ( isdefined( level.globalbundles[ bundlename ][ 0 ] ) )
        {
            assert( !isdefined( level.globalbundles[ bundlename ][ 0 ].var_ba90822709a29aa2 ) );
            level.globalbundles[ bundlename ][ 0 ].var_ba90822709a29aa2 = bundlename;
            level.globalbundles[ bundlename ][ 1 ] = 0;
        }
        else
        {
            level.globalbundles[ bundlename ] = undefined;
            return undefined;
        }
    }
    
    level.globalbundles[ bundlename ][ 1 ] += 1;
    return level.globalbundles[ bundlename ][ 0 ];
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x132cc
// Size: 0x99
function function_680ff86fdba6e483( bundlestruct )
{
    if ( !isdefined( bundlestruct ) )
    {
        return;
    }
    
    if ( !isdefined( level.globalbundles ) )
    {
        return;
    }
    
    assert( isdefined( bundlestruct.var_ba90822709a29aa2 ) );
    bundlename = bundlestruct.var_ba90822709a29aa2;
    
    if ( !isdefined( level.globalbundles[ bundlename ] ) )
    {
        return;
    }
    
    level.globalbundles[ bundlename ][ 1 ] -= 1;
    
    if ( level.globalbundles[ bundlename ][ 1 ] <= 0 )
    {
        level.globalbundles[ bundlename ] = undefined;
    }
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x1336d
// Size: 0x84
function function_eadd787ef68ba356( object )
{
    queue = self;
    queueitem = spawnstruct();
    queueitem.object = object;
    
    if ( isdefined( queue.tail ) )
    {
        queue.tail.next = queueitem;
        queue.tail = queueitem;
        return;
    }
    
    queue.head = queueitem;
    queue.tail = queueitem;
}

// Namespace utility / scripts\engine\utility
// Params 0
// Checksum 0x0, Offset: 0x133f9
// Size: 0x83
function function_beed97b4da27070e()
{
    queue = self;
    
    while ( isdefined( queue.head ) )
    {
        object = queue.head.object;
        queue.head = queue.head.next;
        
        if ( !isdefined( queue.head ) )
        {
            queue.tail = undefined;
        }
        
        if ( isdefined( object ) )
        {
            return object;
        }
    }
    
    return undefined;
}

// Namespace utility / scripts\engine\utility
// Params 1
// Checksum 0x0, Offset: 0x13485
// Size: 0x16b
function function_4676b0931a17998a( array )
{
    assert( isdefined( self.origin ) && isdefined( self.angles ) );
    closest_dot = -1;
    closest_object = undefined;
    
    if ( isplayer( self ) )
    {
        forward = anglestoforward( self getplayerangles() );
        
        foreach ( object in array )
        {
            dir = vectornormalize( object.origin - self geteye() );
            dot = vectordot( forward, dir );
            
            if ( dot >= closest_dot )
            {
                closest_dot = dot;
                closest_object = object;
            }
        }
    }
    else
    {
        forward = anglestoforward( self.angles );
        
        foreach ( object in array )
        {
            dir = vectornormalize( object.origin - self.origin );
            dot = vectordot( forward, dir );
            
            if ( dot >= closest_dot )
            {
                closest_dot = dot;
                closest_object = object;
            }
        }
    }
    
    return closest_object;
}

// Namespace utility / scripts\engine\utility
// Params 2
// Checksum 0x0, Offset: 0x135f9
// Size: 0x23
function function_fe32d769b4bbd6a1( object, string )
{
    object waittill( string );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x13624
// Size: 0x4c
function function_2bf8ec790b5a10f8( dvar, func, args )
{
    if ( getdvarint( dvar ) )
    {
        if ( isdefined( args ) )
        {
            if ( !isarray( args ) )
            {
                args = [ args ];
            }
            
            return single_func_argarray( self, func, args );
        }
        
        return self [[ func ]]();
    }
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x13678
// Size: 0x57
function function_faefc2306b38a0b2( dvar, func, args )
{
    if ( !isdvardefined( dvar ) || !getdvarint( dvar ) )
    {
        if ( isdefined( args ) )
        {
            if ( !isarray( args ) )
            {
                args = [ args ];
            }
            
            return single_func_argarray( self, func, args );
        }
        
        return self [[ func ]]();
    }
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x136d7
// Size: 0x8f
function function_c306c2fab085ed0e( dvar, value, func, args )
{
    if ( isdefined( value ) )
    {
        if ( getdvarint( dvar ) == value )
        {
            if ( isdefined( args ) )
            {
                if ( !isarray( args ) )
                {
                    args = [ args ];
                }
                
                return single_func_argarray( self, func, args );
            }
            else
            {
                return self [[ func ]]();
            }
        }
        
        return;
    }
    
    if ( !isdvardefined( dvar ) )
    {
        if ( isdefined( args ) )
        {
            if ( !isarray( args ) )
            {
                args = [ args ];
            }
            
            return single_func_argarray( self, func, args );
        }
        
        return self [[ func ]]();
    }
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x1376e
// Size: 0x60
function function_c71faf21f94673a3( dvar, value, func, args )
{
    if ( isdvardefined( dvar ) && getdvarint( dvar ) < value )
    {
        if ( isdefined( args ) )
        {
            if ( !isarray( args ) )
            {
                args = [ args ];
            }
            
            return single_func_argarray( self, func, args );
        }
        
        return self [[ func ]]();
    }
}

// Namespace utility / scripts\engine\utility
// Params 4
// Checksum 0x0, Offset: 0x137d6
// Size: 0x60
function function_2bf5388598cc6836( dvar, value, func, args )
{
    if ( isdvardefined( dvar ) && getdvarint( dvar ) > value )
    {
        if ( isdefined( args ) )
        {
            if ( !isarray( args ) )
            {
                args = [ args ];
            }
            
            return single_func_argarray( self, func, args );
        }
        
        return self [[ func ]]();
    }
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x1383e
// Size: 0x2a
function function_ee26a62ef3d1372d( dvar_name, default_value, var_5e073b266eeb0520 )
{
    return function_2155c1bc405429a3( getdvarint( dvar_name, default_value ), default_value, var_5e073b266eeb0520 );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x13871
// Size: 0x2a
function function_370c5539313daf66( dvar_name, default_value, var_5e073b266eeb0520 )
{
    return function_2155c1bc405429a3( getdvarfloat( dvar_name, default_value ), default_value, var_5e073b266eeb0520 );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x138a4
// Size: 0x2a
function function_680811466c2e6053( dvar_name, default_value, var_5e073b266eeb0520 )
{
    return function_2155c1bc405429a3( getdvarvector( dvar_name, default_value ), default_value, var_5e073b266eeb0520 );
}

// Namespace utility / scripts\engine\utility
// Params 3
// Checksum 0x0, Offset: 0x138d7
// Size: 0x2a
function function_ba70ea4e80f22895( dvar_name, default_value, var_5e073b266eeb0520 )
{
    return function_2155c1bc405429a3( getdvar( dvar_name, default_value ), default_value, var_5e073b266eeb0520 );
}

// Namespace utility / scripts\engine\utility
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1390a
// Size: 0x52
function private function_2155c1bc405429a3( dvar_value, default_value, var_5e073b266eeb0520 )
{
    assert( isdefined( default_value ) );
    return_value = default_value;
    
    if ( isdefined( dvar_value ) && dvar_value != default_value )
    {
        return_value = dvar_value;
    }
    else
    {
        return_value = ter_op( isdefined( var_5e073b266eeb0520 ), var_5e073b266eeb0520, default_value );
    }
    
    return return_value;
}

