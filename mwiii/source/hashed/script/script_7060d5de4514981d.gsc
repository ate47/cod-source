#using scripts\engine\utility;

#namespace namespace_1e8b45a54c41285f;

// Namespace namespace_1e8b45a54c41285f / namespace_4baceae61a12e297
// Params 1
// Checksum 0x0, Offset: 0x8f
// Size: 0x90
function function_c358395fdd65426c( taskid )
{
    if ( !istrue( self.zombieaisettings.var_e58a65b7a8f5973c.var_8046d8e4a62a55c0 ) )
    {
        return anim.failure;
    }
    
    if ( self.var_1b51c793abb7dbe6 <= 1 )
    {
        return anim.success;
    }
    
    var_de7821bc51ab43a0 = [[ self.var_8f1d8328f7a9091b ]]();
    
    if ( var_de7821bc51ab43a0 >= 7 && self.var_1b51c793abb7dbe6 <= 3 )
    {
        return anim.success;
    }
    
    return anim.failure;
}

