#using scripts\cp_mp\agents\agent_utils;
#using scripts\engine\utility;

#namespace namespace_5e75b5a54fb4603f;

// Namespace namespace_5e75b5a54fb4603f / namespace_8fb1124048da2603
// Params 0
// Checksum 0x0, Offset: 0xa7
// Size: 0x99
function function_a57e56c880e80cdd()
{
    aitypes = function_3290e192ac188e2d( "zombie_base" );
    base_aitype = undefined;
    
    foreach ( aitype in aitypes )
    {
        strlen = aitype.size;
        
        if ( !isdefined( base_aitype ) || base_aitype.size > strlen )
        {
            base_aitype = aitype;
        }
    }
    
    var_931e0bfccfc26fa5 = base_aitype;
    level.var_ec9d44662c92bb5c = var_931e0bfccfc26fa5;
}

