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

#namespace namespace_6e2885422769ed48;

// Namespace namespace_6e2885422769ed48 / namespace_124a01010aeb4093
// Params 0
// Checksum 0x0, Offset: 0x1fa
// Size: 0x13
function main()
{
    function_c0b3ddc9a6bdcc46( "veh9_jltv_cargo", &function_70158a7bb3fb0665 );
}

// Namespace namespace_6e2885422769ed48 / namespace_124a01010aeb4093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x215
// Size: 0x66
function private function_70158a7bb3fb0665()
{
    if ( !function_9697379150687859( "veh9_jltv_cargo" ) )
    {
        return;
    }
    
    callbacks = [];
    callbacks[ "spawn" ] = &function_247eed998b5b5c0b;
    callbacks[ "enterEnd" ] = &function_24dfb5aeadd19f3c;
    callbacks[ "exitEnd" ] = &function_c9a25e0722ada0f8;
    callbacks[ "reenter" ] = &function_c9e01ef8817d753c;
    function_8497e7e46b5e397( "veh9_jltv_cargo", callbacks );
    function_917ec65924280ade();
}

// Namespace namespace_6e2885422769ed48 / namespace_124a01010aeb4093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x283
// Size: 0x70
function private function_917ec65924280ade()
{
    leveldataforvehicle = vehomn_getleveldataforvehicle( "veh9_jltv_cargo", 1 );
    leveldataforvehicle.rotationids[ 0 ] = 0;
    leveldataforvehicle.rotationids[ 1 ] = 1;
    leveldataforvehicle.rotationrefsbyseatandweapon[ "driver" ][ function_ae5d72405e841a0a() ] = 0;
    leveldataforvehicle.rotationrefsbyseatandweapon[ "gunner" ][ function_ae5d72405e841a0a() ] = 1;
}

// Namespace namespace_6e2885422769ed48 / namespace_124a01010aeb4093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2fb
// Size: 0x3b
function private function_ae5d72405e841a0a()
{
    mapname = getdvar( @"g_mapname" );
    
    if ( iscp() && mapname == "cp_lone" )
    {
        return "iw9_mg_jltv_cp";
    }
    
    return "iw9_mg_jltv_mp";
}

// Namespace namespace_6e2885422769ed48 / namespace_124a01010aeb4093
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x33f
// Size: 0x53
function private function_247eed998b5b5c0b( spawndata, faildata )
{
    vehicle = function_bba34cf920370ff4( "veh9_jltv_cargo", spawndata, faildata );
    turret = function_7ee2d23e7c9bfa52( vehicle, spawndata );
    vehicle_registerturret( vehicle, turret, makeweapon( function_ae5d72405e841a0a() ) );
    return vehicle;
}

// Namespace namespace_6e2885422769ed48 / namespace_124a01010aeb4093
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x39b
// Size: 0x87
function private function_24dfb5aeadd19f3c( vehicle, seatid, oldseatid, player, data )
{
    if ( istrue( data.success ) )
    {
        thread function_d7d50e8f657a7c25( vehicle, seatid, oldseatid, player, data );
        return;
    }
    
    if ( !istrue( data.playerdisconnect ) && !istrue( data.playerdeath ) )
    {
        if ( seatid == "gunner" )
        {
            thread vehicle_occupancy_taketurret( player, vehicle, function_ae5d72405e841a0a(), data, 1 );
        }
    }
}

// Namespace namespace_6e2885422769ed48 / namespace_124a01010aeb4093
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x42a
// Size: 0x81
function private function_d7d50e8f657a7c25( vehicle, seatid, oldseatid, player, data )
{
    if ( seatid == "gunner" )
    {
        level thread vehicle_occupancy_disablefirefortime( player, ter_op( istrue( vehicle.playedfirstraise ), 850, 2200 ) );
        player thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret( player, vehicle, function_ae5d72405e841a0a() );
        vehicle.playedfirstraise = 1;
    }
    
    vehomn_updateomnvarsonseatenter( vehicle, oldseatid, seatid, player );
}

// Namespace namespace_6e2885422769ed48 / namespace_124a01010aeb4093
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x4b3
// Size: 0x46
function private function_c9a25e0722ada0f8( vehicle, seatid, newseatid, player, data )
{
    if ( istrue( data.success ) )
    {
        function_41e2ee710223cf99( vehicle, seatid, newseatid, player, data );
    }
}

// Namespace namespace_6e2885422769ed48 / namespace_124a01010aeb4093
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x501
// Size: 0x12d
function private function_41e2ee710223cf99( vehicle, seatid, newseatid, player, data )
{
    if ( seatid == "gunner" )
    {
        turret = vehicle_getturretbyweapon( vehicle, function_ae5d72405e841a0a() );
        
        if ( !istrue( data.playerdisconnect ) )
        {
            player enableturretdismount();
            player controlturretoff( turret );
            thread vehicle_occupancy_cleardisablefirefortime( player, data.playerdeath );
            
            if ( !istrue( data.playerdeath ) )
            {
                thread vehicle_occupancy_taketurret( player, vehicle, function_ae5d72405e841a0a(), data, 1 );
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

// Namespace namespace_6e2885422769ed48 / namespace_124a01010aeb4093
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x636
// Size: 0x4e
function private function_c9e01ef8817d753c( vehicle, reenterseatid, var_3f68c37bafd38606, player, data )
{
    if ( isdefined( var_3f68c37bafd38606 ) && var_3f68c37bafd38606 == "gunner" )
    {
        thread vehicle_occupancy_taketurret( player, vehicle, function_ae5d72405e841a0a(), data, 1 );
    }
}

// Namespace namespace_6e2885422769ed48 / namespace_124a01010aeb4093
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x68c
// Size: 0xbf
function private function_7ee2d23e7c9bfa52( vehicle, spawndata )
{
    turret = spawnturret( "misc_turret", vehicle gettagorigin( "tag_turret" ), function_ae5d72405e841a0a(), 0 );
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

