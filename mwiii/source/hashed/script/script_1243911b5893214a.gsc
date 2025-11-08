#using scripts\asm\asm;
#using scripts\engine\utility;

#namespace namespace_cd4551f405e67268;

// Namespace namespace_cd4551f405e67268 / namespace_b8a06502e3725a60
// Params 1
// Checksum 0x0, Offset: 0xb2
// Size: 0x24
function function_da956b9ed2ec5b85( state_name )
{
    assert( isstring( state_name ) );
    self.melee_state = state_name;
}

// Namespace namespace_cd4551f405e67268 / namespace_b8a06502e3725a60
// Params 0
// Checksum 0x0, Offset: 0xde
// Size: 0x5c
function function_e725cd043cf58ebb()
{
    if ( istrue( self.var_a7a6441b0e218a8a ) )
    {
        return;
    }
    
    self.var_a7a6441b0e218a8a = 1;
    
    if ( istrue( self.zombieaisettings.var_96a98119d705d6c2 ) )
    {
        function_ac90fa5cc0a80298( "explode_in" );
        return;
    }
    
    function_ac90fa5cc0a80298( default_to( self.melee_state, "melee_in" ) );
}

