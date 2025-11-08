#using scripts\common\utility;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;

#namespace namespace_3723c659cb1de901;

// Namespace namespace_3723c659cb1de901 / namespace_2e6a07982189398
// Params 0
// Checksum 0x0, Offset: 0xf5
// Size: 0x3f
function function_47a79fc51aeb5823()
{
    registersharedfunc( "veh9_techo", "initLate", &function_e41728e3efa537f );
    registersharedfunc( "veh9_techo", "create", &function_24d24ce92b8f9fed );
    create_func_ref( "techo_rover", &function_60fc936dd3de9b81 );
}

// Namespace namespace_3723c659cb1de901 / namespace_2e6a07982189398
// Params 0
// Checksum 0x0, Offset: 0x13c
// Size: 0x2e
function function_e41728e3efa537f()
{
    if ( true )
    {
        return;
    }
    
    spawnstructs = getstructarray( "techo_spawn", "targetname" );
    thread function_466912ce204e4051( spawnstructs, 3 );
}

// Namespace namespace_3723c659cb1de901 / namespace_2e6a07982189398
// Params 2
// Checksum 0x0, Offset: 0x172
// Size: 0xeb
function function_466912ce204e4051( structarray, delay )
{
    wait delay;
    canspawnvehicles = getdvarint( @"hash_e6afce2cf5cf7515", 0 ) == 0;
    
    if ( canspawnvehicles )
    {
        foreach ( struct in structarray )
        {
            spawndata = spawnstruct();
            spawndata.origin = struct.origin;
            spawndata.angles = struct.angles;
            vehicle = vehicle_spawn( "veh9_techo", spawndata );
            
            if ( isdefined( vehicle ) )
            {
                level.var_7d34d3dad0a68d2f = array_add( level.var_7d34d3dad0a68d2f, vehicle );
            }
        }
    }
}

// Namespace namespace_3723c659cb1de901 / namespace_2e6a07982189398
// Params 1
// Checksum 0x0, Offset: 0x265
// Size: 0x35
function function_24d24ce92b8f9fed( vehicle )
{
    vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth( vehicle );
    vehicle.health = vehicle.maxhealth;
}

// Namespace namespace_3723c659cb1de901 / namespace_2e6a07982189398
// Params 1
// Checksum 0x0, Offset: 0x2a2
// Size: 0xa0
function function_60fc936dd3de9b81( player )
{
    spawndata = spawnstruct();
    spawndata.origin = player.origin + ( 0, 0, 100 );
    spawndata.angles = player.angles * ( 0, 1, 0 );
    spawndata.owner = player;
    vehicle = vehicle_spawn( "veh9_techo", spawndata );
    
    if ( isdefined( vehicle ) )
    {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter( vehicle, "driver", player, undefined, 1 );
    }
}

