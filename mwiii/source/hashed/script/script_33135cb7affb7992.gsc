#using script_17dc47fb18ded931;
#using script_5f71ed065b9cea1e;
#using script_6b684505b9959a08;
#using scripts\engine\utility;

#namespace namespace_55960efed51f8481;

// Namespace namespace_55960efed51f8481 / namespace_cc8f7511992de84
// Params 1
// Checksum 0x0, Offset: 0xa8
// Size: 0x4f
function function_18a04da230bdecbb( var_7ff959e229d749c3 )
{
    struct = function_dcbffa8a1a0be491( function_35f874585c5fcfe6( var_7ff959e229d749c3 ), function_1864c93384760910( var_7ff959e229d749c3 ), function_a4db25b7af304698( var_7ff959e229d749c3 ), function_f63abb63847ab316( var_7ff959e229d749c3 ), function_2dff7e1a10633ee1( var_7ff959e229d749c3 ), function_5b87e83d21054cb( var_7ff959e229d749c3 ), function_f29715a4f86830ed( var_7ff959e229d749c3 ) );
    return struct;
}

// Namespace namespace_55960efed51f8481 / namespace_cc8f7511992de84
// Params 7
// Checksum 0x0, Offset: 0x100
// Size: 0xb8
function function_dcbffa8a1a0be491( rewardcacheassetname, var_c92e69a2dca65df1, perplayerloot, rewardgrouptype, rewardspawnlocationtype, spawnactivationname, spawnactivitymoment )
{
    struct = spawnstruct();
    struct.var_fec7733a738249d6 = 1;
    struct.rewardcacheassetname = rewardcacheassetname;
    struct.var_c92e69a2dca65df1 = var_c92e69a2dca65df1;
    struct.perplayerloot = perplayerloot;
    struct.rewardgrouptype = rewardgrouptype;
    struct.rewardspawnlocationtype = rewardspawnlocationtype;
    struct.spawnactivationname = spawnactivationname;
    struct.spawnactivitymoment = spawnactivitymoment;
    return struct;
}

// Namespace namespace_55960efed51f8481 / namespace_cc8f7511992de84
// Params 1
// Checksum 0x0, Offset: 0x1c1
// Size: 0x1d
function function_155ac29988933331( var_40bdc956443135c6 )
{
    if ( isdefined( var_40bdc956443135c6 ) )
    {
        return var_40bdc956443135c6.rewardcacheassetname;
    }
    
    return undefined;
}

// Namespace namespace_55960efed51f8481 / namespace_cc8f7511992de84
// Params 1
// Checksum 0x0, Offset: 0x1e7
// Size: 0x1d
function function_57339c17a16d5b( var_40bdc956443135c6 )
{
    if ( isdefined( var_40bdc956443135c6 ) )
    {
        return var_40bdc956443135c6.var_c92e69a2dca65df1;
    }
    
    return undefined;
}

// Namespace namespace_55960efed51f8481 / namespace_cc8f7511992de84
// Params 1
// Checksum 0x0, Offset: 0x20d
// Size: 0x1d
function getperplayerloot( var_40bdc956443135c6 )
{
    if ( isdefined( var_40bdc956443135c6 ) )
    {
        return var_40bdc956443135c6.perplayerloot;
    }
    
    return undefined;
}

// Namespace namespace_55960efed51f8481 / namespace_cc8f7511992de84
// Params 1
// Checksum 0x0, Offset: 0x233
// Size: 0x1d
function getrewardgrouptype( var_40bdc956443135c6 )
{
    if ( isdefined( var_40bdc956443135c6 ) )
    {
        return var_40bdc956443135c6.rewardgrouptype;
    }
    
    return undefined;
}

// Namespace namespace_55960efed51f8481 / namespace_cc8f7511992de84
// Params 1
// Checksum 0x0, Offset: 0x259
// Size: 0x1d
function function_fe7983e3293f0584( var_40bdc956443135c6 )
{
    if ( isdefined( var_40bdc956443135c6 ) )
    {
        return var_40bdc956443135c6.rewardspawnlocationtype;
    }
    
    return undefined;
}

// Namespace namespace_55960efed51f8481 / namespace_cc8f7511992de84
// Params 1
// Checksum 0x0, Offset: 0x27f
// Size: 0x1d
function function_bc4d3f90dc517d3d( var_40bdc956443135c6 )
{
    if ( isdefined( var_40bdc956443135c6 ) )
    {
        return var_40bdc956443135c6.spawnactivationname;
    }
    
    return undefined;
}

// Namespace namespace_55960efed51f8481 / namespace_cc8f7511992de84
// Params 1
// Checksum 0x0, Offset: 0x2a5
// Size: 0x1d
function function_9f3743cde2de21b( var_40bdc956443135c6 )
{
    if ( isdefined( var_40bdc956443135c6 ) )
    {
        return var_40bdc956443135c6.spawnactivitymoment;
    }
    
    return undefined;
}

// Namespace namespace_55960efed51f8481 / namespace_cc8f7511992de84
// Params 1
// Checksum 0x0, Offset: 0x2cb
// Size: 0x2c
function function_e7c2ecccbf00007e( var_40bdc956443135c6 )
{
    rewardcachebundlename = function_155ac29988933331( var_40bdc956443135c6 );
    
    if ( !isdefined( rewardcachebundlename ) )
    {
        return undefined;
    }
    
    return reward_cache_settings::function_ec54b8019f59c0ef( rewardcachebundlename );
}

// Namespace namespace_55960efed51f8481 / namespace_cc8f7511992de84
// Params 1
// Checksum 0x0, Offset: 0x300
// Size: 0x2c
function function_9e1216d6f33a3c78( var_40bdc956443135c6 )
{
    var_2adb829fe068100d = function_57339c17a16d5b( var_40bdc956443135c6 );
    
    if ( !isdefined( var_2adb829fe068100d ) )
    {
        return undefined;
    }
    
    return namespace_81b7e1672a7e54da::function_4d6ae01e1e47320c( var_2adb829fe068100d );
}

