#using scripts\asm\asm;
#using scripts\engine\utility;

#namespace namespace_3cd8443b4650c886;

// Namespace namespace_3cd8443b4650c886 / namespace_2a48aafa587c77be
// Params 1
// Checksum 0x0, Offset: 0xa3
// Size: 0x24
function function_6c5371915054a3f9( state_name )
{
    assert( isstring( state_name ) );
    self.bite_state = state_name;
}

// Namespace namespace_3cd8443b4650c886 / namespace_2a48aafa587c77be
// Params 0
// Checksum 0x0, Offset: 0xcf
// Size: 0x36
function function_3ce3c307b88d4237()
{
    if ( istrue( self.var_4507177651176666 ) )
    {
        return;
    }
    
    self.var_4507177651176666 = 1;
    function_ac90fa5cc0a80298( default_to( self.bite_state, "bite_in" ) );
}

