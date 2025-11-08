#using script_13204033905a2a90;
#using script_16d28018f576f969;

#namespace namespace_94f121a7aa39e844;

// Namespace namespace_94f121a7aa39e844 / namespace_8c245fa63761384d
// Params 0
// Checksum 0x0, Offset: 0x10a
// Size: 0x24
function function_a78debac92a88923()
{
    /#
        return getdvarint( @"hash_484421b3752a1b9d", 0 );
    #/
    
    return getdvarint( @"hash_484421b3752a1b9d", 0 );
}

// Namespace namespace_94f121a7aa39e844 / namespace_8c245fa63761384d
// Params 1
// Checksum 0x0, Offset: 0x137
// Size: 0x6f
function function_805f1f0b22ca5026( var_bf7cebbb38bdf01 )
{
    var_5a904f463705ae66 = undefined;
    var_f118da0af461c7e1 = undefined;
    
    switch ( var_bf7cebbb38bdf01 )
    {
        case 1:
            var_5a904f463705ae66 = &namespace_197ebf97e16268de::function_b24a36667938b8d4;
            var_f118da0af461c7e1 = &namespace_197ebf97e16268de::function_b831ccf10a32a4b1;
            break;
        case 2:
            var_5a904f463705ae66 = &namespace_197ebe97e16266ab::function_b24a36667938b8d4;
            var_f118da0af461c7e1 = &namespace_197ebe97e16266ab::function_b831ccf10a32a4b1;
            break;
    }
    
    function_921fed896a534721( var_5a904f463705ae66, var_f118da0af461c7e1 );
}

// Namespace namespace_94f121a7aa39e844 / namespace_8c245fa63761384d
// Params 2
// Checksum 0x0, Offset: 0x1ae
// Size: 0x44
function function_921fed896a534721( var_5a904f463705ae66, var_f118da0af461c7e1 )
{
    if ( !isdefined( var_5a904f463705ae66 ) || !isdefined( var_f118da0af461c7e1 ) )
    {
        logprint( "Orientation override launch function is not defined!" );
        return;
    }
    
    if ( [[ var_f118da0af461c7e1 ]]() != 1 )
    {
        logprint( "Orientation match variant file is not at head of base!" );
        return;
    }
    
    [[ var_5a904f463705ae66 ]]();
}

