#using scripts\common\utility;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;

#namespace namespace_6857f6e06c66d92c;

// Namespace namespace_6857f6e06c66d92c / namespace_8600c6128c661c9f
// Params 0
// Checksum 0x0, Offset: 0xfd
// Size: 0x3f
function function_7fbb4bdc170016b2()
{
    registersharedfunc( "veh9_suv_1996", "initLate", &function_4dd4f9b32d34b37e );
    registersharedfunc( "veh9_suv_1996", "create", &function_f264518ea185294 );
    create_func_ref( "veh9_suv_1996", &function_701902185150632a );
}

// Namespace namespace_6857f6e06c66d92c / namespace_8600c6128c661c9f
// Params 0
// Checksum 0x0, Offset: 0x144
// Size: 0x38
function function_4dd4f9b32d34b37e()
{
    if ( true )
    {
        return;
    }
    
    level.var_907d3564338c8280 = [];
    spawnstructs = getstructarray( "suv_1996_spawn", "targetname" );
    thread function_5c3e799013e72b1a( spawnstructs, 3 );
}

// Namespace namespace_6857f6e06c66d92c / namespace_8600c6128c661c9f
// Params 2
// Checksum 0x0, Offset: 0x184
// Size: 0xeb
function function_5c3e799013e72b1a( structarray, delay )
{
    wait delay;
    var_a3a86e2fdc8840d9 = getdvarint( @"hash_e6afce2cf5cf7515", 0 ) == 0;
    
    if ( var_a3a86e2fdc8840d9 )
    {
        foreach ( struct in structarray )
        {
            spawndata = spawnstruct();
            spawndata.origin = struct.origin;
            spawndata.angles = struct.angles;
            vehicle = vehicle_spawn( "veh9_suv_1996", spawndata );
            
            if ( isdefined( vehicle ) )
            {
                level.var_907d3564338c8280 = array_add( level.var_907d3564338c8280, vehicle );
            }
        }
    }
}

// Namespace namespace_6857f6e06c66d92c / namespace_8600c6128c661c9f
// Params 1
// Checksum 0x0, Offset: 0x277
// Size: 0x57
function function_f264518ea185294( vehicle )
{
    vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth( vehicle );
    vehicle.health = vehicle.maxhealth;
    vehicle.vehicle_specific_onentervehicle = &function_773ed31ffc2459df;
    vehicle.vehicle_specific_onexitvehicle = &function_b89e8c86f98d3697;
}

// Namespace namespace_6857f6e06c66d92c / namespace_8600c6128c661c9f
// Params 1
// Checksum 0x0, Offset: 0x2d6
// Size: 0xa0
function function_701902185150632a( player )
{
    spawndata = spawnstruct();
    spawndata.origin = player.origin + ( 0, 0, 100 );
    spawndata.angles = player.angles * ( 0, 1, 0 );
    spawndata.owner = player;
    vehicle = vehicle_spawn( "veh9_suv_1996", spawndata );
    
    if ( isdefined( vehicle ) )
    {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter( vehicle, "driver", player, undefined, 1 );
    }
}

// Namespace namespace_6857f6e06c66d92c / namespace_8600c6128c661c9f
// Params 4
// Checksum 0x0, Offset: 0x37e
// Size: 0x4f
function function_773ed31ffc2459df( vehicle, newseatid, player, data )
{
    player.isdrivingvehicle = 1;
    
    if ( istrue( level.var_d39df167f3a996b0 ) )
    {
        vehicle setscriptablepartstate( "lights", "on" );
    }
}

// Namespace namespace_6857f6e06c66d92c / namespace_8600c6128c661c9f
// Params 4
// Checksum 0x0, Offset: 0x3d5
// Size: 0x5b
function function_b89e8c86f98d3697( vehicle, newseatid, player, data )
{
    if ( !istrue( data.playerdisconnect ) )
    {
        player.isdrivingvehicle = undefined;
    }
    
    if ( istrue( level.var_d39df167f3a996b0 ) )
    {
        vehicle setscriptablepartstate( "lights", "off" );
    }
}

