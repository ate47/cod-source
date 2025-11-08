#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;

#namespace namespace_6c6964e55ab1bec8;

// Namespace namespace_6c6964e55ab1bec8 / namespace_8297ef197f3d67e1
// Params 0
// Checksum 0x0, Offset: 0xb2
// Size: 0x32
function get_linked_struct()
{
    array = get_linked_structs();
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace namespace_6c6964e55ab1bec8 / namespace_8297ef197f3d67e1
// Params 0
// Checksum 0x0, Offset: 0xed
// Size: 0x32
function get_linked_vehicle_node()
{
    array = get_linked_vehicle_nodes();
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace namespace_6c6964e55ab1bec8 / namespace_8297ef197f3d67e1
// Params 2
// Checksum 0x0, Offset: 0x128
// Size: 0x59
function function_98123b667b8f7daa( value, key )
{
    array = [];
    filtered_nodes = getvehiclenodearray( value, key );
    
    if ( isdefined( self.script_linkto ) )
    {
        linked_nodes = get_linked_vehicle_nodes();
        array = array_intersection( linked_nodes, filtered_nodes );
    }
    
    return array;
}

// Namespace namespace_6c6964e55ab1bec8 / namespace_8297ef197f3d67e1
// Params 2
// Checksum 0x0, Offset: 0x18a
// Size: 0x45
function function_90f7f7052df0614b( value, key )
{
    array = function_98123b667b8f7daa( value, key );
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace namespace_6c6964e55ab1bec8 / namespace_8297ef197f3d67e1
// Params 2
// Checksum 0x0, Offset: 0x1d8
// Size: 0xa5
function function_954eb52ab4cdeb46( value, key )
{
    array = [];
    filtered_structs = getstructarray( value, key );
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            linked_structs = getstructarray( linknames[ i ], "script_linkname" );
            structs = array_intersection( linked_structs, filtered_structs );
            
            if ( structs.size > 0 )
            {
                array = array_combine( array, structs );
            }
        }
    }
    
    return array;
}

// Namespace namespace_6c6964e55ab1bec8 / namespace_8297ef197f3d67e1
// Params 2
// Checksum 0x0, Offset: 0x286
// Size: 0x37
function function_98edf48d14333f3f( value, key )
{
    array = function_954eb52ab4cdeb46( value, key );
    
    if ( array.size > 0 )
    {
        return array[ 0 ];
    }
    
    return undefined;
}

// Namespace namespace_6c6964e55ab1bec8 / namespace_8297ef197f3d67e1
// Params 2
// Checksum 0x0, Offset: 0x2c5
// Size: 0xa3
function function_2ccdcbc0a0056226( value, key )
{
    array = [];
    filtered_ents = getentarray( value, key );
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            linked_ents = getentarray( linknames[ i ], "script_linkname" );
            ents = array_intersection( linked_ents, filtered_ents );
            
            if ( ents.size > 0 )
            {
                array = array_combine( array, ents );
            }
        }
    }
    
    return array;
}

// Namespace namespace_6c6964e55ab1bec8 / namespace_8297ef197f3d67e1
// Params 2
// Checksum 0x0, Offset: 0x371
// Size: 0x45
function function_45c24888c616581f( value, key )
{
    array = function_2ccdcbc0a0056226( value, key );
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace namespace_6c6964e55ab1bec8 / namespace_8297ef197f3d67e1
// Params 2
// Checksum 0x0, Offset: 0x3bf
// Size: 0x45
function function_53b040ee753f26b1( value, key )
{
    array = function_50b5e4fcc500bb90( value, key );
    assert( array.size == 1 );
    assert( isdefined( array[ 0 ] ) );
    return array[ 0 ];
}

// Namespace namespace_6c6964e55ab1bec8 / namespace_8297ef197f3d67e1
// Params 2
// Checksum 0x0, Offset: 0x40d
// Size: 0xea
function function_50b5e4fcc500bb90( value, key )
{
    array = [];
    var_8d08e5afdc964181 = [];
    var_a2e2c8edb4508f35 = getscriptablearray( value, key );
    var_7815a6f6f10f4cd4 = getentitylessscriptablearray( value, key );
    var_8d08e5afdc964181 = array_combine_unique( var_a2e2c8edb4508f35, var_7815a6f6f10f4cd4 );
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            linked_scriptables = [];
            var_a2e2c8edb4508f35 = getscriptablearray( linknames[ i ], "script_linkname" );
            var_7815a6f6f10f4cd4 = getentitylessscriptablearray( linknames[ i ], "script_linkname" );
            linked_scriptables = array_combine_unique( var_a2e2c8edb4508f35, var_7815a6f6f10f4cd4 );
            scriptables = array_intersection( linked_scriptables, var_8d08e5afdc964181 );
            
            if ( scriptables.size > 0 )
            {
                array = array_combine( array, scriptables );
            }
        }
    }
    
    return array;
}

// Namespace namespace_6c6964e55ab1bec8 / namespace_8297ef197f3d67e1
// Params 2
// Checksum 0x0, Offset: 0x500
// Size: 0xa5
function function_a230870ff680af93( value, key )
{
    array = [];
    filtered_volumes = getnoentvolumearray( value, key );
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            for ( j = 0; j < filtered_volumes.size ; j++ )
            {
                if ( is_equal( linknames[ i ], filtered_volumes[ j ].script_linkname ) )
                {
                    array = array_add( array, filtered_volumes[ j ] );
                }
            }
        }
    }
    
    return array;
}

