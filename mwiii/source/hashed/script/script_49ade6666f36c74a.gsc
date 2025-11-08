#using scripts\engine\utility;

#namespace namespace_e59f070a7a8a4fcd;

// Namespace namespace_e59f070a7a8a4fcd / namespace_25db8a825b1053d8
// Params 1
// Checksum 0x0, Offset: 0xa4
// Size: 0x14
function pick_random( params )
{
    return params[ randomint( params.size ) ];
}

// Namespace namespace_e59f070a7a8a4fcd / namespace_25db8a825b1053d8
// Params 1
// Checksum 0x0, Offset: 0xc1
// Size: 0x5b
function layout_join( params )
{
    result = [];
    
    for ( i = 0; i < params.size ; i++ )
    {
        param = params[ i ];
        
        if ( isarray( param ) )
        {
            result = result array_combine( result, param );
            continue;
        }
        
        result[ result.size ] = param;
    }
    
    return result;
}

// Namespace namespace_e59f070a7a8a4fcd / namespace_25db8a825b1053d8
// Params 1
// Checksum 0x0, Offset: 0x125
// Size: 0x6a
function function_c7dcf35d43da192b( names )
{
    entities = [];
    
    foreach ( i, name in names )
    {
        entities[ i ] = getent( name, "script_noteworthy" );
    }
    
    return entities;
}

