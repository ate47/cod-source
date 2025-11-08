#namespace string;

// Namespace string / scripts\common\string
// Params 1
// Checksum 0x0, Offset: 0x8b
// Size: 0x1d
function to_string( var )
{
    if ( isdefined( var ) )
    {
        return ( "" + var );
    }
    
    return "";
}

// Namespace string / scripts\common\string
// Params 1
// Checksum 0x0, Offset: 0xb1
// Size: 0x19, Type: bool
function function_46b9c00bb0535aa3( str )
{
    return !isdefined( str ) || str == "";
}

/#

    // Namespace string / scripts\common\string
    // Params 3
    // Checksum 0x0, Offset: 0xd3
    // Size: 0x51, Type: dev
    function rjust( str_input, n_length, str_fill )
    {
        if ( !isdefined( str_fill ) )
        {
            str_fill = "<dev string:x1c>";
        }
        
        str_input = to_string( str_input );
        n_fill_length = n_length - str_input.size;
        str_fill = fill( n_fill_length, str_fill );
        return str_fill + str_input;
    }

    // Namespace string / scripts\common\string
    // Params 3
    // Checksum 0x0, Offset: 0x12c
    // Size: 0x51, Type: dev
    function ljust( str_input, n_length, str_fill )
    {
        if ( !isdefined( str_fill ) )
        {
            str_fill = "<dev string:x1c>";
        }
        
        str_input = to_string( str_input );
        n_fill_length = n_length - str_input.size;
        str_fill = fill( n_fill_length, str_fill );
        return str_input + str_fill;
    }

    // Namespace string / scripts\common\string
    // Params 2
    // Checksum 0x0, Offset: 0x185
    // Size: 0x67, Type: dev
    function fill( n_length, str_fill )
    {
        if ( !isdefined( str_fill ) || str_fill == "<dev string:x21>" )
        {
            str_fill = "<dev string:x1c>";
        }
        
        str_return = "<dev string:x21>";
        
        while ( n_length > 0 )
        {
            str = getsubstr( str_fill, 0, n_length );
            n_length -= str.size;
            str_return += str;
        }
        
        return str_return;
    }

#/
