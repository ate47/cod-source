#namespace scriptable_group;

// Namespace scriptable_group / scripts\common\scriptable_group
// Params 3
// Checksum 0x0, Offset: 0x147
// Size: 0xe0
function function_200bd098377a8674( group_id, var_449da622a6fe97bd, var_9137b8627fdf4cc8 )
{
    if ( !isdefined( level.scriptable_groups ) )
    {
        level.scriptable_groups = [];
    }
    
    assertex( !isdefined( level.scriptable_groups[ group_id ] ), "scriptable group with id [" + group_id + "] has already been initialized" );
    group = spawnstruct();
    group.scriptables = [];
    group.start_id = 0;
    group.current_id = 0;
    group.max_count = var_449da622a6fe97bd;
    group.var_35b0b2e8bee60af4 = var_9137b8627fdf4cc8;
    assertex( group.var_35b0b2e8bee60af4 < group.max_count, "scriptable group with id [" + group_id + "] has a larger group_cleanup_batch_size than group_size_max which is not allowed" );
    level.scriptable_groups[ group_id ] = group;
}

// Namespace scriptable_group / scripts\common\scriptable_group
// Params 1
// Checksum 0x0, Offset: 0x22f
// Size: 0x4b
function function_f8ecd6e02634e682( group_id )
{
    if ( isdefined( level.scriptable_groups ) && isdefined( level.scriptable_groups[ group_id ] ) )
    {
        group = level.scriptable_groups[ group_id ];
        return group.scriptables;
    }
    
    return undefined;
}

// Namespace scriptable_group / scripts\common\scriptable_group
// Params 2
// Checksum 0x0, Offset: 0x283
// Size: 0xa2
function function_476b3beecd82dcca( group_id, instance )
{
    if ( !isdefined( level.scriptable_groups ) || !isdefined( level.scriptable_groups[ group_id ] ) )
    {
        assertmsg( "no scriptable group exists with id [" + group_id + "]. Did you call init_scriptable_group()?" );
        return;
    }
    
    group = level.scriptable_groups[ group_id ];
    function_3e036cf2bd9bf933( group );
    instance.var_4a0145502132790a = group.current_id;
    group.scriptables[ instance.var_4a0145502132790a ] = instance;
    group.current_id++;
}

// Namespace scriptable_group / scripts\common\scriptable_group
// Params 2
// Checksum 0x0, Offset: 0x32d
// Size: 0x71
function function_879ccb6a53e634f5( group_id, instance )
{
    if ( !isdefined( level.scriptable_groups[ group_id ] ) )
    {
        assertmsg( "no scriptable group exists with id [" + group_id + "]. Did you call init_scriptable_group()?" );
        return;
    }
    
    group = level.scriptable_groups[ group_id ];
    group.scriptables[ instance.var_4a0145502132790a ] = undefined;
    instance.var_4a0145502132790a = undefined;
}

// Namespace scriptable_group / scripts\common\scriptable_group
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3a6
// Size: 0xcd
function private function_3e036cf2bd9bf933( group )
{
    if ( group.scriptables.size < group.max_count )
    {
        return;
    }
    
    var_d89dfb4bd556862a = 0;
    
    for ( id = group.start_id; id < group.current_id ; id++ )
    {
        if ( var_d89dfb4bd556862a == group.var_35b0b2e8bee60af4 )
        {
            break;
        }
        
        instance = group.scriptables[ id ];
        
        if ( isdefined( instance ) )
        {
            if ( isent( instance ) )
            {
                instance delete();
            }
            else
            {
                instance notify( "death" );
                instance freescriptable();
            }
            
            var_d89dfb4bd556862a++;
        }
        
        group.scriptables[ id ] = undefined;
        group.start_id++;
    }
}

