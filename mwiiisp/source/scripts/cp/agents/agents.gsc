#using scripts\mp\agents\agent_common;

#namespace agents;

// Namespace agents / scripts\cp\agents\agents
// Params 0
// Checksum 0x0, Offset: 0x70
// Size: 0x48
function main()
{
    if ( isdefined( level.createfx_enabled ) && level.createfx_enabled )
    {
        return;
    }
    
    level.badplace_cylinder_func = &badplace_cylinder;
    level.badplace_delete_func = &badplace_delete;
    level thread scripts\mp\agents\agent_common::init();
    level.spitter_last_cloud_time = 0;
}

