#using scripts\engine\utility;

#namespace uav_manager;

// Namespace uav_manager / namespace_4ad0bd66eaa05ae7
// Params 0
// Checksum 0x0, Offset: 0xbc
// Size: 0x1e
function function_360128ec8c9d243()
{
    level.var_34eacc4ba5c409a7 = [];
    level thread function_8371656cac31e3e5();
    level thread function_ee39a757e5ab8fbe();
}

// Namespace uav_manager / namespace_4ad0bd66eaa05ae7
// Params 0
// Checksum 0x0, Offset: 0xe2
// Size: 0x54
function function_8371656cac31e3e5()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "uav_started", uavowner, uavtype );
        
        if ( !isdefined( uavowner ) || isbot( uavowner ) )
        {
            continue;
        }
        
        level.var_34eacc4ba5c409a7[ uavowner getentitynumber() ] = uavowner;
    }
}

// Namespace uav_manager / namespace_4ad0bd66eaa05ae7
// Params 0
// Checksum 0x0, Offset: 0x13e
// Size: 0x5e
function function_ee39a757e5ab8fbe()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "uav_finished", uavowner );
        
        if ( isbot( uavowner ) )
        {
            continue;
        }
        
        if ( isdefined( uavowner ) )
        {
            level.var_34eacc4ba5c409a7[ uavowner getentitynumber() ] = undefined;
        }
        
        level.var_34eacc4ba5c409a7 = array_removeundefined( level.var_34eacc4ba5c409a7 );
    }
}

// Namespace uav_manager / namespace_4ad0bd66eaa05ae7
// Params 0
// Checksum 0x0, Offset: 0x1a4
// Size: 0xe, Type: bool
function function_296623d26e11725()
{
    return level.var_34eacc4ba5c409a7.size > 0;
}

