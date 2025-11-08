#using scripts\common\utility;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;

#namespace namespace_32bc29716721be3a;

// Namespace namespace_32bc29716721be3a / namespace_b0ffbd8b9a4c0b87
// Params 0
// Checksum 0x0, Offset: 0x11b
// Size: 0x3f
function function_59eb5f2de04c842a()
{
    create_func_ref( "little_bird", &spawn_and_enter_little_bird );
    registersharedfunc( "veh9_palfa", "create", &function_e142f49f5fd8fc5c );
    registersharedfunc( "veh9_palfa", "initLate", &function_eb07b052f2b17526 );
}

// Namespace namespace_32bc29716721be3a / namespace_b0ffbd8b9a4c0b87
// Params 1
// Checksum 0x0, Offset: 0x162
// Size: 0x35
function function_e142f49f5fd8fc5c( vehicle )
{
    vehicle.maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getmaxhealth( vehicle );
    vehicle.health = vehicle.maxhealth;
}

// Namespace namespace_32bc29716721be3a / namespace_b0ffbd8b9a4c0b87
// Params 0
// Checksum 0x0, Offset: 0x19f
// Size: 0x38
function function_eb07b052f2b17526()
{
    if ( true )
    {
        return;
    }
    
    level.littlebirds = [];
    spawnstructs = getstructarray( "littlebird_spawn", "targetname" );
    thread function_c5b7425291a048f2( spawnstructs, 3 );
}

// Namespace namespace_32bc29716721be3a / namespace_b0ffbd8b9a4c0b87
// Params 2
// Checksum 0x0, Offset: 0x1df
// Size: 0xf3
function function_c5b7425291a048f2( structarray, delay )
{
    wait delay;
    var_afee914574e657b8 = getdvarint( @"hash_e6afce2cf5cf7515", 0 ) == 0;
    
    if ( var_afee914574e657b8 )
    {
        foreach ( struct in structarray )
        {
            spawndata = spawnstruct();
            spawndata.origin = struct.origin;
            spawndata.angles = struct.angles;
            vehicle = vehicle_spawn( "veh9_palfa", spawndata );
            
            if ( isdefined( vehicle ) )
            {
                level.littlebirds = array_add( level.littlebirds, vehicle );
            }
        }
    }
    
    level notify( "little_birds_done_spawning" );
}

// Namespace namespace_32bc29716721be3a / namespace_b0ffbd8b9a4c0b87
// Params 1
// Checksum 0x0, Offset: 0x2da
// Size: 0xa0
function spawn_and_enter_little_bird( player )
{
    spawndata = spawnstruct();
    spawndata.origin = player.origin + ( 0, 0, 100 );
    spawndata.angles = player.angles * ( 0, 1, 0 );
    spawndata.owner = player;
    vehicle = vehicle_spawn( "veh9_palfa", spawndata );
    
    if ( isdefined( vehicle ) )
    {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter( vehicle, "driver", player, undefined, 1 );
    }
}

// Namespace namespace_32bc29716721be3a / namespace_b0ffbd8b9a4c0b87
// Params 1
// Checksum 0x0, Offset: 0x382
// Size: 0x2f
function addtolittlebirdlist( entnumber )
{
    if ( !isdefined( level.littlebirds ) )
    {
        level.littlebirds = [];
    }
    
    level.littlebirds[ entnumber ] = self;
}

// Namespace namespace_32bc29716721be3a / namespace_b0ffbd8b9a4c0b87
// Params 1
// Checksum 0x0, Offset: 0x3b9
// Size: 0x1e
function removefromlittlebirdlistondeath( entnumber )
{
    self waittill( "death" );
    level.littlebirds[ entnumber ] = undefined;
}

