#using scripts\engine\utility;

#namespace namespace_9e7e287a72e995a1;

// Namespace namespace_9e7e287a72e995a1 / namespace_2db0a94a6f3680c9
// Params 1
// Checksum 0x0, Offset: 0x90
// Size: 0x45
function function_88de778c36c85601( taskid )
{
    self.ents_in_mouth = function_fdc9d5557c53078e( self.ents_in_mouth );
    
    if ( self.ents_in_mouth.size > 0 )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace namespace_9e7e287a72e995a1 / namespace_2db0a94a6f3680c9
// Params 1
// Checksum 0x0, Offset: 0xde
// Size: 0x6e
function function_d76a0008f2159ab4( taskid )
{
    var_3fd3b525001c8401 = isdefined( self.var_aa9ea14cf354838f ) ? self.var_aa9ea14cf354838f : 1;
    health_perc = self.health / self.maxhealth;
    
    if ( var_3fd3b525001c8401 - health_perc >= 0.2 )
    {
        return anim.success;
    }
    
    return anim.failure;
}

