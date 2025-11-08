#using scripts\common\utility;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;

#namespace namespace_fd34989ac9be2da1;

// Namespace namespace_fd34989ac9be2da1 / namespace_f5874001d201a304
// Params 0
// Checksum 0x0, Offset: 0x132
// Size: 0x3f
function function_d06448e049fab02f()
{
    registersharedfunc( "veh9_jltv_mg", "initLate", &function_8f390fc5caccbdc3 );
    registersharedfunc( "veh9_jltv_mg", "create", &function_4620cd961f2d1ba1 );
    create_func_ref( "veh9_jltv_mg", &function_440add0394f4a4a1 );
}

// Namespace namespace_fd34989ac9be2da1 / namespace_f5874001d201a304
// Params 0
// Checksum 0x0, Offset: 0x179
// Size: 0x38
function function_8f390fc5caccbdc3()
{
    if ( true )
    {
        return;
    }
    
    level.var_8101fc8c5dcf3ce3 = [];
    spawnstructs = getstructarray( "jltv_mg_spawn", "targetname" );
    thread function_6347af8d38c1385d( spawnstructs, 3 );
}

// Namespace namespace_fd34989ac9be2da1 / namespace_f5874001d201a304
// Params 2
// Checksum 0x0, Offset: 0x1b9
// Size: 0xeb
function function_6347af8d38c1385d( structarray, delay )
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
            vehicle = vehicle_spawn( "veh9_jltv_mg", spawndata );
            
            if ( isdefined( vehicle ) )
            {
                level.var_8101fc8c5dcf3ce3 = array_add( level.var_66a1156521ee6dea, vehicle );
            }
        }
    }
}

// Namespace namespace_fd34989ac9be2da1 / namespace_f5874001d201a304
// Params 1
// Checksum 0x0, Offset: 0x2ac
// Size: 0x57
function function_4620cd961f2d1ba1( vehicle )
{
    vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth( vehicle );
    vehicle.health = vehicle.maxhealth;
    vehicle.vehicle_specific_onentervehicle = &function_c8ea1b99067c2fbc;
    vehicle.vehicle_specific_onexitvehicle = &function_46c7342379aa9bb6;
}

// Namespace namespace_fd34989ac9be2da1 / namespace_f5874001d201a304
// Params 1
// Checksum 0x0, Offset: 0x30b
// Size: 0xa0
function function_440add0394f4a4a1( player )
{
    spawndata = spawnstruct();
    spawndata.origin = player.origin + ( 0, 0, 100 );
    spawndata.angles = player.angles * ( 0, 1, 0 );
    spawndata.owner = player;
    vehicle = vehicle_spawn( "veh9_jltv_mg", spawndata );
    
    if ( isdefined( vehicle ) )
    {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter( vehicle, "driver", player, undefined, 1 );
    }
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace namespace_fd34989ac9be2da1 / namespace_f5874001d201a304
// Params 4
// Checksum 0x0, Offset: 0x3b3
// Size: 0x9f
function function_c8ea1b99067c2fbc( vehicle, newseatid, player, data )
{
    if ( istrue( vehicle.door_open ) )
    {
        vehicle vehicleplayanim( %reb_com_veh8_techo_fl_door_close );
        vehicle.door_open = undefined;
    }
    
    player.isdrivingvehicle = 1;
    
    if ( istrue( level.var_d39df167f3a996b0 ) )
    {
        vehicle setscriptablepartstate( "lights", "on" );
    }
    
    if ( isdefined( vehicle.var_f24cc3beef01650c ) )
    {
        vehicle.var_1ab6b61153087915 = vehicle.var_f24cc3beef01650c;
    }
}

// Namespace namespace_fd34989ac9be2da1 / namespace_f5874001d201a304
// Params 4
// Checksum 0x0, Offset: 0x45a
// Size: 0x48
function function_46c7342379aa9bb6( vehicle, newseatid, player, data )
{
    if ( !istrue( data.playerdisconnect ) )
    {
        player.isdrivingvehicle = undefined;
    }
    
    vehicle.var_1ab6b61153087915 = undefined;
}

