#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_collision;
#using scripts\cp_mp\vehicles\vehicle_compass;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_dlog;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;

#namespace namespace_495d1b5a786a2174;

// Namespace namespace_495d1b5a786a2174 / namespace_65ad5249b19d5d41
// Params 0
// Checksum 0x0, Offset: 0x1f6
// Size: 0x13
function main()
{
    function_c0b3ddc9a6bdcc46( "veh9_jltv_mg", &function_ae4e7f00c8115b31 );
}

// Namespace namespace_495d1b5a786a2174 / namespace_65ad5249b19d5d41
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x211
// Size: 0x66
function private function_ae4e7f00c8115b31()
{
    if ( !function_9697379150687859( "veh9_jltv_mg" ) )
    {
        return;
    }
    
    callbacks = [];
    callbacks[ "spawn" ] = &function_8801494dff845e4f;
    callbacks[ "enterEnd" ] = &function_bb30116f3fd6e9e0;
    callbacks[ "exitEnd" ] = &function_fdc839bb6fc50c34;
    callbacks[ "reenter" ] = &function_6ed911ad6f6df408;
    function_8497e7e46b5e397( "veh9_jltv_mg", callbacks );
    function_9752aacd99a363ca();
}

// Namespace namespace_495d1b5a786a2174 / namespace_65ad5249b19d5d41
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x27f
// Size: 0x70
function private function_9752aacd99a363ca()
{
    leveldataforvehicle = vehomn_getleveldataforvehicle( "veh9_jltv_mg", 1 );
    leveldataforvehicle.rotationids[ 0 ] = 0;
    leveldataforvehicle.rotationids[ 1 ] = 1;
    leveldataforvehicle.rotationrefsbyseatandweapon[ "driver" ][ function_f921e95b80e8afae() ] = 0;
    leveldataforvehicle.rotationrefsbyseatandweapon[ "gunner" ][ function_f921e95b80e8afae() ] = 1;
}

// Namespace namespace_495d1b5a786a2174 / namespace_65ad5249b19d5d41
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2f7
// Size: 0x3b
function private function_f921e95b80e8afae()
{
    mapname = getdvar( @"g_mapname" );
    
    if ( iscp() && mapname == "cp_lone" )
    {
        return "iw9_mg_jltv_cp";
    }
    
    return "iw9_mg_jltv_mp";
}

// Namespace namespace_495d1b5a786a2174 / namespace_65ad5249b19d5d41
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x33b
// Size: 0x58
function private function_8801494dff845e4f( spawndata, faildata )
{
    vehicle = function_bba34cf920370ff4( "veh9_jltv_mg", spawndata, faildata );
    
    if ( isdefined( vehicle ) )
    {
        turret = function_b6f99331f7cc8aae( vehicle, spawndata );
        vehicle_registerturret( vehicle, turret, makeweapon( function_f921e95b80e8afae() ) );
    }
    
    return vehicle;
}

// Namespace namespace_495d1b5a786a2174 / namespace_65ad5249b19d5d41
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x39c
// Size: 0x87
function private function_bb30116f3fd6e9e0( vehicle, seatid, oldseatid, player, data )
{
    if ( istrue( data.success ) )
    {
        thread function_3ad4a8a755341361( vehicle, seatid, oldseatid, player, data );
        return;
    }
    
    if ( !istrue( data.playerdisconnect ) && !istrue( data.playerdeath ) )
    {
        if ( seatid == "gunner" )
        {
            thread vehicle_occupancy_taketurret( player, vehicle, function_f921e95b80e8afae(), data, 1 );
        }
    }
}

// Namespace namespace_495d1b5a786a2174 / namespace_65ad5249b19d5d41
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x42b
// Size: 0x81
function private function_3ad4a8a755341361( vehicle, seatid, oldseatid, player, data )
{
    if ( seatid == "gunner" )
    {
        level thread vehicle_occupancy_disablefirefortime( player, ter_op( istrue( vehicle.playedfirstraise ), 850, 2200 ) );
        player thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret( player, vehicle, function_f921e95b80e8afae() );
        vehicle.playedfirstraise = 1;
    }
    
    vehomn_updateomnvarsonseatenter( vehicle, oldseatid, seatid, player );
}

// Namespace namespace_495d1b5a786a2174 / namespace_65ad5249b19d5d41
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x4b4
// Size: 0x46
function private function_fdc839bb6fc50c34( vehicle, seatid, newseatid, player, data )
{
    if ( istrue( data.success ) )
    {
        function_a3417b548967a91d( vehicle, seatid, newseatid, player, data );
    }
}

// Namespace namespace_495d1b5a786a2174 / namespace_65ad5249b19d5d41
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x502
// Size: 0x12d
function private function_a3417b548967a91d( vehicle, seatid, newseatid, player, data )
{
    if ( seatid == "gunner" )
    {
        turret = vehicle_getturretbyweapon( vehicle, function_f921e95b80e8afae() );
        
        if ( !istrue( data.playerdisconnect ) )
        {
            player enableturretdismount();
            player controlturretoff( turret );
            thread vehicle_occupancy_cleardisablefirefortime( player, data.playerdeath );
            
            if ( !istrue( data.playerdeath ) )
            {
                thread vehicle_occupancy_taketurret( player, vehicle, function_f921e95b80e8afae(), data, 1 );
            }
        }
        
        turret.owner = undefined;
        turret setotherent( undefined );
        turret setentityowner( undefined );
        turret setsentryowner( undefined );
    }
    
    if ( !istrue( data.playerdisconnect ) )
    {
        success = vehicle_occupancy_moveplayertoexit( vehicle, seatid, newseatid, player, data );
        
        if ( !success )
        {
            if ( issharedfuncdefined( "vehicle_occupancy", "handleSuicideFromVehicles" ) )
            {
                [[ getsharedfunc( "vehicle_occupancy", "handleSuicideFromVehicles" ) ]]( player );
            }
            else
            {
                player suicide();
            }
        }
    }
    
    vehomn_updateomnvarsonseatexit( vehicle, seatid, newseatid, player );
}

// Namespace namespace_495d1b5a786a2174 / namespace_65ad5249b19d5d41
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x637
// Size: 0x4e
function private function_6ed911ad6f6df408( vehicle, reenterseatid, var_3f68c37bafd38606, player, data )
{
    if ( isdefined( var_3f68c37bafd38606 ) && var_3f68c37bafd38606 == "gunner" )
    {
        thread vehicle_occupancy_taketurret( player, vehicle, function_f921e95b80e8afae(), data, 1 );
    }
}

// Namespace namespace_495d1b5a786a2174 / namespace_65ad5249b19d5d41
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x68d
// Size: 0xbf
function private function_b6f99331f7cc8aae( vehicle, spawndata )
{
    turret = spawnturret( "misc_turret", vehicle gettagorigin( "tag_turret" ), function_f921e95b80e8afae(), 0 );
    turret linkto( vehicle, "tag_turret", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    turret setmodel( "veh9_mil_lnd_jltv_turret_gun" );
    turret setmode( "sentry_offline" );
    turret setsentryowner( undefined );
    turret makeunusable();
    turret setdefaultdroppitch( 0 );
    turret setturretmodechangewait( 1 );
    turret.angles = vehicle.angles;
    turret.vehicle = vehicle;
    return turret;
}

