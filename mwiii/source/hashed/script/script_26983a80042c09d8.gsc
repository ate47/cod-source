#using script_bd0d3e8f9ff5c11;

#namespace namespace_16e4ada217cd5608;

// Namespace namespace_16e4ada217cd5608 / namespace_80283ad72c21b0c0
// Params 1
// Checksum 0x0, Offset: 0x90
// Size: 0xf6
function function_b209f843e410abb5( taskid )
{
    target = self.enemy;
    
    if ( !isalive( target ) )
    {
        return anim.failure;
    }
    
    if ( abs( target.origin[ 2 ] - self.origin[ 2 ] ) > 100 )
    {
        return anim.failure;
    }
    
    if ( !istrue( self.zombieaisettings.var_e58a65b7a8f5973c.var_a379ec913c7fcfa1 ) )
    {
        return anim.failure;
    }
    
    closest_tacpoint = findclosesttacpoint( target.origin );
    
    if ( isdefined( closest_tacpoint ) )
    {
        var_5472fac695b32f65 = calculatetacpointexposureforleastexposedsector( closest_tacpoint );
        
        if ( var_5472fac695b32f65 < 1000 )
        {
            return anim.failure;
        }
    }
    
    if ( function_e82696e7b59178f3( target.origin ) )
    {
        return anim.failure;
    }
    
    return anim.success;
}

