#using scripts\common\utility;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;

#namespace namespace_426467f0723e255a;

// Namespace namespace_426467f0723e255a / namespace_cb8c441d992fbeff
// Params 0
// Checksum 0x0, Offset: 0x172
// Size: 0x3f
function function_974dace3684b9e9b()
{
    registersharedfunc( "veh9_mil_cargo_truck", "initLate", &function_8bfe97a985843fa7 );
    registersharedfunc( "veh9_mil_cargo_truck", "create", &function_a3aded844ddffed5 );
    create_func_ref( "veh9_mil_cargo_truck", &function_b6977e53c5d1b9a1 );
}

// Namespace namespace_426467f0723e255a / namespace_cb8c441d992fbeff
// Params 0
// Checksum 0x0, Offset: 0x1b9
// Size: 0x38
function function_8bfe97a985843fa7()
{
    if ( true )
    {
        return;
    }
    
    level.var_53a2c539dfbbf4b3 = [];
    spawnstructs = getstructarray( "mil_cargo_truck_spawn", "targetname" );
    thread function_2eed5685649875e9( spawnstructs, 3 );
}

// Namespace namespace_426467f0723e255a / namespace_cb8c441d992fbeff
// Params 2
// Checksum 0x0, Offset: 0x1f9
// Size: 0xeb
function function_2eed5685649875e9( structarray, delay )
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
            vehicle = vehicle_spawn( "veh9_mil_cargo_truck", spawndata );
            
            if ( isdefined( vehicle ) )
            {
                level.var_53a2c539dfbbf4b3 = array_add( level.var_53a2c539dfbbf4b3, vehicle );
            }
        }
    }
}

// Namespace namespace_426467f0723e255a / namespace_cb8c441d992fbeff
// Params 1
// Checksum 0x0, Offset: 0x2ec
// Size: 0x57
function function_a3aded844ddffed5( vehicle )
{
    vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth( vehicle );
    vehicle.health = vehicle.maxhealth;
    vehicle.vehicle_specific_onentervehicle = &function_944637d5d83c25b8;
    vehicle.vehicle_specific_onexitvehicle = &function_c75bb8069708440a;
}

// Namespace namespace_426467f0723e255a / namespace_cb8c441d992fbeff
// Params 1
// Checksum 0x0, Offset: 0x34b
// Size: 0xa0
function function_b6977e53c5d1b9a1( player )
{
    spawndata = spawnstruct();
    spawndata.origin = player.origin + ( 0, 0, 100 );
    spawndata.angles = player.angles * ( 0, 1, 0 );
    spawndata.owner = player;
    vehicle = vehicle_spawn( "veh9_mil_cargo_truck", spawndata );
    
    if ( isdefined( vehicle ) )
    {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter( vehicle, "driver", player, undefined, 1 );
    }
}

// Namespace namespace_426467f0723e255a / namespace_cb8c441d992fbeff
// Params 4
// Checksum 0x0, Offset: 0x3f3
// Size: 0x82
function function_944637d5d83c25b8( vehicle, newseatid, player, data )
{
    player.isdrivingvehicle = 1;
    
    if ( istrue( level.var_d39df167f3a996b0 ) )
    {
        vehicle setscriptablepartstate( "tag_light_front_left", "on" );
        vehicle setscriptablepartstate( "tag_light_front_right", "on" );
        vehicle setscriptablepartstate( "tag_light_back_left", "on" );
        vehicle setscriptablepartstate( "tag_light_back_right", "on" );
    }
}

// Namespace namespace_426467f0723e255a / namespace_cb8c441d992fbeff
// Params 4
// Checksum 0x0, Offset: 0x47d
// Size: 0x8e
function function_c75bb8069708440a( vehicle, newseatid, player, data )
{
    if ( !istrue( data.playerdisconnect ) )
    {
        player.isdrivingvehicle = undefined;
    }
    
    if ( istrue( level.var_d39df167f3a996b0 ) )
    {
        vehicle setscriptablepartstate( "tag_light_front_left", "off" );
        vehicle setscriptablepartstate( "tag_light_front_right", "off" );
        vehicle setscriptablepartstate( "tag_light_back_left", "off" );
        vehicle setscriptablepartstate( "tag_light_back_right", "off" );
    }
}

