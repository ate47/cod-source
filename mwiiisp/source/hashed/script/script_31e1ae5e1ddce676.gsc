#using scripts\common\utility;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;

#namespace namespace_c1f1eb97c978bfbb;

// Namespace namespace_c1f1eb97c978bfbb / namespace_50d0b417576cdea4
// Params 0
// Checksum 0x0, Offset: 0x17c
// Size: 0x3f
function function_f8cd879642397a71()
{
    registersharedfunc( "veh9_sedan_hatchback_1985", "initLate", &function_155de152ad763cf5 );
    registersharedfunc( "veh9_sedan_hatchback_1985", "create", &function_54d66e9828e8498f );
    create_func_ref( "veh9_sedan_hatchback_1985", &function_701902185150632a );
}

// Namespace namespace_c1f1eb97c978bfbb / namespace_50d0b417576cdea4
// Params 0
// Checksum 0x0, Offset: 0x1c3
// Size: 0x38
function function_155de152ad763cf5()
{
    if ( true )
    {
        return;
    }
    
    level.var_907d3564338c8280 = [];
    spawnstructs = getstructarray( "sedan_hatchback_1985_spawn", "targetname" );
    thread function_f0918a0308e39dfb( spawnstructs, 3 );
}

// Namespace namespace_c1f1eb97c978bfbb / namespace_50d0b417576cdea4
// Params 2
// Checksum 0x0, Offset: 0x203
// Size: 0xeb
function function_f0918a0308e39dfb( structarray, delay )
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
            vehicle = vehicle_spawn( "veh9_sedan_hatchback_1985", spawndata );
            
            if ( isdefined( vehicle ) )
            {
                level.var_907d3564338c8280 = array_add( level.var_907d3564338c8280, vehicle );
            }
        }
    }
}

// Namespace namespace_c1f1eb97c978bfbb / namespace_50d0b417576cdea4
// Params 1
// Checksum 0x0, Offset: 0x2f6
// Size: 0x57
function function_54d66e9828e8498f( vehicle )
{
    vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth( vehicle );
    vehicle.health = vehicle.maxhealth;
    vehicle.vehicle_specific_onentervehicle = &function_7df76584d6078b46;
    vehicle.vehicle_specific_onexitvehicle = &function_40ce047405104c04;
}

// Namespace namespace_c1f1eb97c978bfbb / namespace_50d0b417576cdea4
// Params 1
// Checksum 0x0, Offset: 0x355
// Size: 0xa0
function function_701902185150632a( player )
{
    spawndata = spawnstruct();
    spawndata.origin = player.origin + ( 0, 0, 100 );
    spawndata.angles = player.angles * ( 0, 1, 0 );
    spawndata.owner = player;
    vehicle = vehicle_spawn( "veh9_sedan_hatchback_1985", spawndata );
    
    if ( isdefined( vehicle ) )
    {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter( vehicle, "driver", player, undefined, 1 );
    }
}

// Namespace namespace_c1f1eb97c978bfbb / namespace_50d0b417576cdea4
// Params 4
// Checksum 0x0, Offset: 0x3fd
// Size: 0x82
function function_7df76584d6078b46( vehicle, newseatid, player, data )
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

// Namespace namespace_c1f1eb97c978bfbb / namespace_50d0b417576cdea4
// Params 4
// Checksum 0x0, Offset: 0x487
// Size: 0x8e
function function_40ce047405104c04( vehicle, newseatid, player, data )
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

