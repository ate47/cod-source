#using scripts\common\utility;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;

#namespace namespace_cbbca44aa26ee855;

// Namespace namespace_cbbca44aa26ee855 / namespace_d8a94de1eaf55642
// Params 0
// Checksum 0x0, Offset: 0xec
// Size: 0x49
function function_944a2eb36063f641()
{
    level.var_3b897e0bf2fd1085 = [];
    registersharedfunc( "veh9_rhib", "initLate", &function_579a147ed98230e5 );
    registersharedfunc( "veh9_rhib", "create", &function_8278682e1f6a45bf );
    create_func_ref( "rhib", &function_60df0d6dd51d625 );
}

// Namespace namespace_cbbca44aa26ee855 / namespace_d8a94de1eaf55642
// Params 0
// Checksum 0x0, Offset: 0x13d
// Size: 0x32
function function_579a147ed98230e5()
{
    spawnstructs = getstructarray( "rhib_spawn", "targetname" );
    
    if ( !function_6d4917219f632ba7() )
    {
        return;
    }
    
    thread function_a5f198848c9214ab( spawnstructs, 3 );
}

// Namespace namespace_cbbca44aa26ee855 / namespace_d8a94de1eaf55642
// Params 2
// Checksum 0x0, Offset: 0x177
// Size: 0xeb
function function_a5f198848c9214ab( structarray, delay )
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
            vehicle = vehicle_spawn( "veh9_rhib", spawndata );
            
            if ( isdefined( vehicle ) )
            {
                level.var_3b897e0bf2fd1085 = array_add( level.var_3b897e0bf2fd1085, vehicle );
            }
        }
    }
}

// Namespace namespace_cbbca44aa26ee855 / namespace_d8a94de1eaf55642
// Params 1
// Checksum 0x0, Offset: 0x26a
// Size: 0x35
function function_8278682e1f6a45bf( vehicle )
{
    vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth( vehicle );
    vehicle.health = vehicle.maxhealth;
}

// Namespace namespace_cbbca44aa26ee855 / namespace_d8a94de1eaf55642
// Params 1
// Checksum 0x0, Offset: 0x2a7
// Size: 0xa0
function function_60df0d6dd51d625( player )
{
    spawndata = spawnstruct();
    spawndata.origin = player.origin + ( 0, 0, 100 );
    spawndata.angles = player.angles * ( 0, 1, 0 );
    spawndata.owner = player;
    vehicle = vehicle_spawn( "veh9_rhib", spawndata );
    
    if ( isdefined( vehicle ) )
    {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter( vehicle, "driver", player, undefined, 1 );
    }
}

// Namespace namespace_cbbca44aa26ee855 / namespace_d8a94de1eaf55642
// Params 0
// Checksum 0x0, Offset: 0x34f
// Size: 0xc, Type: bool
function function_6d4917219f632ba7()
{
    return istrue( level.var_a81f53987e0482bf );
}

