#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;

#namespace vehicle_spawn_cp;

// Namespace vehicle_spawn_cp / scripts\cp\vehicles\vehicle_spawn_cp
// Params 0
// Checksum 0x0, Offset: 0x9e
// Size: 0x18
function vehicle_spawn_cp_init()
{
    registersharedfunc( "vehicle_spawn", "canSpawnVehicle", &vehicle_spawn_cp_canspawnvehicle );
}

// Namespace vehicle_spawn_cp / scripts\cp\vehicles\vehicle_spawn_cp
// Params 3
// Checksum 0x0, Offset: 0xbe
// Size: 0x5a, Type: bool
function vehicle_spawn_cp_canspawnvehicle( vehicleref, owner, team )
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) == 1 )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_742caa13b3c2e685", 0 ) == 1 )
    {
        return false;
    }
    
    if ( istrue( level.disable_global_vehicle_spawn ) )
    {
        return false;
    }
    
    return true;
}

