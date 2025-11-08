#using scripts\common\callbacks;

#namespace scriptable_group;

// Namespace scriptable_group / scripts\common\scriptable_group
// Params 3
// Checksum 0x0, Offset: 0x98
// Size: 0xee
function function_200bd098377a8674( group_id, var_449da622a6fe97bd, var_9137b8627fdf4cc8 )
{
    if ( !isdefined( level.scriptable_groups ) )
    {
        level.scriptable_groups = [];
    }
    
    assertex( !isdefined( level.scriptable_groups[ group_id ] ), "<dev string:x1c>" + group_id + "<dev string:x3a>" );
    group = spawnstruct();
    group.scriptables = [];
    group.start_id = 0;
    group.current_id = 0;
    group.group_id = group_id;
    group.max_count = var_449da622a6fe97bd;
    group.var_35b0b2e8bee60af4 = var_9137b8627fdf4cc8;
    assertex( group.var_35b0b2e8bee60af4 < group.max_count, "<dev string:x1c>" + group_id + "<dev string:x5c>" );
    level.scriptable_groups[ group_id ] = group;
}

// Namespace scriptable_group / scripts\common\scriptable_group
// Params 1
// Checksum 0x0, Offset: 0x18e
// Size: 0x4c
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
// Checksum 0x0, Offset: 0x1e3
// Size: 0xb5
function function_476b3beecd82dcca( group_id, instance )
{
    if ( !isdefined( level.scriptable_groups ) || !isdefined( level.scriptable_groups[ group_id ] ) )
    {
        assertmsg( "<dev string:xb0>" + group_id + "<dev string:xd8>" );
        return;
    }
    
    group = level.scriptable_groups[ group_id ];
    function_3e036cf2bd9bf933( group );
    instance.var_4a0145502132790a = group.current_id;
    group.scriptables[ instance.var_4a0145502132790a ] = instance;
    group.current_id++;
    instance callback::callback( #"hash_f24c94436ace19e3", group );
}

// Namespace scriptable_group / scripts\common\scriptable_group
// Params 2
// Checksum 0x0, Offset: 0x2a0
// Size: 0x84
function function_879ccb6a53e634f5( group_id, instance )
{
    if ( !isdefined( level.scriptable_groups[ group_id ] ) )
    {
        assertmsg( "<dev string:xb0>" + group_id + "<dev string:xd8>" );
        return;
    }
    
    group = level.scriptable_groups[ group_id ];
    instance callback::callback( #"hash_8e9040f5886c6379", group );
    group.scriptables[ instance.var_4a0145502132790a ] = undefined;
    instance.var_4a0145502132790a = undefined;
}

// Namespace scriptable_group / scripts\common\scriptable_group
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x32c
// Size: 0xde
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
            instance callback::callback( #"hash_c6a6fbc56f71a3b1", group );
            
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

