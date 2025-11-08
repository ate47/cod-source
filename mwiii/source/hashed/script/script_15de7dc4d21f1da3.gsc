#namespace namespace_ee5e52a75fbcf489;

// Namespace namespace_ee5e52a75fbcf489 / namespace_a2c409363d7f24e7
// Params 0
// Checksum 0x0, Offset: 0xd2
// Size: 0x2c
function init()
{
    if ( !isdefined( level.var_170a29e0c0e257b7 ) )
    {
        level.var_170a29e0c0e257b7 = [];
        level.var_6d69e5fde1ae8e9e = [];
    }
    
    level thread function_5b1d60872d5f7d1f();
}

// Namespace namespace_ee5e52a75fbcf489 / namespace_a2c409363d7f24e7
// Params 0
// Checksum 0x0, Offset: 0x106
// Size: 0x2b
function function_5b1d60872d5f7d1f()
{
    for ( ;; )
    {
        level waittill( "connected", player );
        player thread function_6b1fcec8b1789d65();
        player thread function_df97371d5dcee28c();
    }
}

// Namespace namespace_ee5e52a75fbcf489 / namespace_a2c409363d7f24e7
// Params 1
// Checksum 0x0, Offset: 0x139
// Size: 0x38
function function_ba46cf958ae0cbda( callback )
{
    if ( !isdefined( level.var_170a29e0c0e257b7 ) )
    {
        level.var_170a29e0c0e257b7 = [];
    }
    
    level.var_170a29e0c0e257b7[ level.var_170a29e0c0e257b7.size ] = callback;
}

// Namespace namespace_ee5e52a75fbcf489 / namespace_a2c409363d7f24e7
// Params 1
// Checksum 0x0, Offset: 0x179
// Size: 0x78
function function_7f4116eba8c42fa0( weapondropcallback )
{
    temparray = [];
    
    foreach ( callback in level.var_170a29e0c0e257b7 )
    {
        if ( weapondropcallback != callback )
        {
            temparray[ temparray.size ] = callback;
        }
    }
    
    level.var_170a29e0c0e257b7 = temparray;
}

// Namespace namespace_ee5e52a75fbcf489 / namespace_a2c409363d7f24e7
// Params 1
// Checksum 0x0, Offset: 0x1f9
// Size: 0x38
function function_39027364b9c16127( callback )
{
    if ( !isdefined( level.var_6d69e5fde1ae8e9e ) )
    {
        level.var_6d69e5fde1ae8e9e = [];
    }
    
    level.var_6d69e5fde1ae8e9e[ level.var_6d69e5fde1ae8e9e.size ] = callback;
}

// Namespace namespace_ee5e52a75fbcf489 / namespace_a2c409363d7f24e7
// Params 1
// Checksum 0x0, Offset: 0x239
// Size: 0x78
function function_e7aae5b770c4747b( var_2d2deddadd177b34 )
{
    temparray = [];
    
    foreach ( callback in level.var_6d69e5fde1ae8e9e )
    {
        if ( var_2d2deddadd177b34 != callback )
        {
            temparray[ temparray.size ] = callback;
        }
    }
    
    level.var_6d69e5fde1ae8e9e = temparray;
}

// Namespace namespace_ee5e52a75fbcf489 / namespace_a2c409363d7f24e7
// Params 0
// Checksum 0x0, Offset: 0x2b9
// Size: 0x7b
function function_6b1fcec8b1789d65()
{
    self endon( "disconnect" );
    
    for ( ;; )
    {
        self waittill( "weapon_dropped", droppedentity, weaponobject );
        
        foreach ( callback in level.var_170a29e0c0e257b7 )
        {
            self [[ callback ]]( droppedentity, weaponobject );
        }
    }
}

// Namespace namespace_ee5e52a75fbcf489 / namespace_a2c409363d7f24e7
// Params 0
// Checksum 0x0, Offset: 0x33c
// Size: 0x86
function function_df97371d5dcee28c()
{
    self endon( "disconnect" );
    
    for ( ;; )
    {
        self waittill( "dropped_weapon_scriptable", droppedweapon, secondparam, soundposition );
        
        foreach ( callback in level.var_6d69e5fde1ae8e9e )
        {
            self [[ callback ]]( droppedweapon, secondparam, soundposition );
        }
    }
}

