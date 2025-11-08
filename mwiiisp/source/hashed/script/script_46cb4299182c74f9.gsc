#using scripts\common\utility;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;

#namespace namespace_e9252936fc821c6c;

// Namespace namespace_e9252936fc821c6c / namespace_8e763655879586e1
// Params 0
// Checksum 0x0, Offset: 0x1b2
// Size: 0x55
function function_a66a9d83b9e60db0()
{
    registersharedfunc( "veh9_techo_rebel_armor", "initLate", &function_65c11e7437c3fb6c );
    registersharedfunc( "veh9_techo_rebel_armor", "create", &function_7e4187d5451ac0ce );
    create_func_ref( "techo_rebel", &function_b1c91c65e339db66 );
    registersharedfunc( "veh9_techo_rebel_armor", "armorDamageMitigation", &function_507809c631729c41 );
}

// Namespace namespace_e9252936fc821c6c / namespace_8e763655879586e1
// Params 4
// Checksum 0x0, Offset: 0x20f
// Size: 0x74
function function_507809c631729c41( partname, meansofdeath, damagelocation, objweapon )
{
    if ( isdefined( objweapon.basename ) && objweapon.basename == "chopper_gunner_turret_cp" )
    {
        return 0;
    }
    
    if ( issharedfuncdefined( "veh9_techo_rebel_armor", "armorShouldMitigateDamage" ) )
    {
        return self [[ getsharedfunc( "veh9_techo_rebel_armor", "armorShouldMitigateDamage" ) ]]( partname, meansofdeath, damagelocation, objweapon );
    }
}

// Namespace namespace_e9252936fc821c6c / namespace_8e763655879586e1
// Params 0
// Checksum 0x0, Offset: 0x28b
// Size: 0x2e
function function_65c11e7437c3fb6c()
{
    if ( true )
    {
        return;
    }
    
    spawnstructs = getstructarray( "techo_rebel_spawn", "targetname" );
    thread function_22c6c4e475bb08d4( spawnstructs, 3 );
}

// Namespace namespace_e9252936fc821c6c / namespace_8e763655879586e1
// Params 2
// Checksum 0x0, Offset: 0x2c1
// Size: 0xeb
function function_22c6c4e475bb08d4( structarray, delay )
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
            vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "veh9_techo_rebel_armor", spawndata );
            
            if ( isdefined( vehicle ) )
            {
                level.tacrovers = array_add( level.tacrovers, vehicle );
            }
        }
    }
}

// Namespace namespace_e9252936fc821c6c / namespace_8e763655879586e1
// Params 1
// Checksum 0x0, Offset: 0x3b4
// Size: 0x57
function function_7e4187d5451ac0ce( vehicle )
{
    vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth( vehicle );
    vehicle.health = vehicle.maxhealth;
    vehicle.vehicle_specific_onentervehicle = &function_8603fb4f33894a3d;
    vehicle.vehicle_specific_onexitvehicle = &function_42cff90ec61377e1;
}

// Namespace namespace_e9252936fc821c6c / namespace_8e763655879586e1
// Params 1
// Checksum 0x0, Offset: 0x413
// Size: 0xa0
function function_b1c91c65e339db66( player )
{
    spawndata = spawnstruct();
    spawndata.origin = player.origin + ( 0, 0, 100 );
    spawndata.angles = player.angles * ( 0, 1, 0 );
    spawndata.owner = player;
    vehicle = vehicle_spawn( "veh9_techo_rebel_armor", spawndata );
    
    if ( isdefined( vehicle ) )
    {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter( vehicle, "driver", player, undefined, 1 );
    }
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace namespace_e9252936fc821c6c / namespace_8e763655879586e1
// Params 4
// Checksum 0x0, Offset: 0x4bb
// Size: 0xa7
function function_8603fb4f33894a3d( vehicle, newseatid, player, data )
{
    vehicle notify( "player_entered_enemy_vehicle" );
    
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

// Namespace namespace_e9252936fc821c6c / namespace_8e763655879586e1
// Params 4
// Checksum 0x0, Offset: 0x56a
// Size: 0x48
function function_42cff90ec61377e1( vehicle, newseatid, player, data )
{
    if ( !istrue( data.playerdisconnect ) )
    {
        player.isdrivingvehicle = undefined;
    }
    
    vehicle.var_1ab6b61153087915 = undefined;
}

