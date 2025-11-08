#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;

#namespace namespace_bac291bbcfb102fc;

// Namespace namespace_bac291bbcfb102fc / namespace_42d2620e5c90a424
// Params 0
// Checksum 0x0, Offset: 0x2b2
// Size: 0xa3
function function_5688f09df31647c()
{
    level notify( "testbotvehicles_monitor_singleton" );
    level endon( "testbotvehicles_monitor_singleton" );
    setdvarifuninitialized( @"hash_22242920a0122649", 0 );
    setdvarifuninitialized( @"hash_c2abbfaf6092dd2e", 0 );
    
    while ( true )
    {
        wait 1;
        var_af7e6cf77c6eb49c = getdvarint( @"hash_22242920a0122649", 0 );
        
        if ( var_af7e6cf77c6eb49c > 0 )
        {
            function_b552a0e1fd9d5fab( var_af7e6cf77c6eb49c, 100 );
            setdvar( @"hash_22242920a0122649", 0 );
        }
        
        var_2243d74333538fbb = getdvarint( @"hash_c2abbfaf6092dd2e", 0 );
        
        if ( var_2243d74333538fbb > 0 )
        {
            function_b552a0e1fd9d5fab( var_2243d74333538fbb, 5 );
        }
    }
}

// Namespace namespace_bac291bbcfb102fc / namespace_42d2620e5c90a424
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x35d
// Size: 0xd8
function private function_4580d561379dbeed()
{
    validvehicles = [];
    
    if ( isdefined( level.vehicle ) )
    {
        foreach ( vehicles in level.vehicle.instances )
        {
            foreach ( vehicle in vehicles )
            {
                if ( isdefined( vehicle ) && istrue( vehicle_interact_vehiclecanbeused( vehicle ) ) && !isdefined( vehicle_occupancy_getdriver( vehicle ) ) )
                {
                    validvehicles[ validvehicles.size ] = vehicle;
                }
            }
        }
    }
    
    return validvehicles;
}

// Namespace namespace_bac291bbcfb102fc / namespace_42d2620e5c90a424
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x43e
// Size: 0xc5
function private function_b552a0e1fd9d5fab( var_9b3d64d7164bb5bc, var_afb49cc35a7dbe58 )
{
    if ( !isdefined( level.players ) )
    {
        return;
    }
    
    var_b5ed09d48080e3df = [];
    
    foreach ( player in level.players )
    {
        if ( !isbot( player ) && isalive( player ) )
        {
            var_b5ed09d48080e3df[ var_b5ed09d48080e3df.size ] = player;
        }
    }
    
    if ( var_b5ed09d48080e3df.size == 0 )
    {
        return;
    }
    
    selectedplayer = var_b5ed09d48080e3df[ randomint( var_b5ed09d48080e3df.size ) ];
    function_bc551c20e35ce094( selectedplayer.origin, 800, var_9b3d64d7164bb5bc, var_afb49cc35a7dbe58 );
}

// Namespace namespace_bac291bbcfb102fc / namespace_42d2620e5c90a424
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x50b
// Size: 0xb5
function private function_bc551c20e35ce094( position, radius, var_9b3d64d7164bb5bc, var_afb49cc35a7dbe58 )
{
    var_aec07bbc0287654b = function_4580d561379dbeed();
    
    if ( !isdefined( var_aec07bbc0287654b ) || var_aec07bbc0287654b.size == 0 )
    {
        return;
    }
    
    var_aec07bbc0287654b = array_randomize( var_aec07bbc0287654b );
    
    if ( !isdefined( var_9b3d64d7164bb5bc ) || var_9b3d64d7164bb5bc > var_aec07bbc0287654b.size )
    {
        var_9b3d64d7164bb5bc = var_aec07bbc0287654b.size;
    }
    
    navpoints = getrandomnavpoints( position, radius, var_9b3d64d7164bb5bc );
    
    if ( !isdefined( navpoints ) || navpoints.size <= 0 )
    {
        navpoints = [ position ];
    }
    
    for ( vehicleindex = 0; vehicleindex < var_9b3d64d7164bb5bc ; vehicleindex++ )
    {
        var_aec07bbc0287654b[ vehicleindex ] thread testbotvehicles_movetoposition( navpoints[ randomint( navpoints.size ) ], var_afb49cc35a7dbe58 );
    }
}

// Namespace namespace_bac291bbcfb102fc / namespace_42d2620e5c90a424
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x5c8
// Size: 0x146
function private testbotvehicles_movetoposition( position, var_afb49cc35a7dbe58, debugdraw )
{
    self notify( "testbotvehicles_movetoposition" );
    self endon( "testbotvehicles_movetoposition" );
    self endon( "death_or_disconnect" );
    self endon( "near_goal" );
    function_7f0c1e61a13ca16e( self );
    
    for ( var_4a492273c7f70ccc = 0; var_4a492273c7f70ccc < var_afb49cc35a7dbe58 ; var_4a492273c7f70ccc++ )
    {
        var_34bb55fbc59c2e1d = isnavmeshloaded( "vehicle_large" );
        var_a8c9b5fffa6387d = isnavmeshloaded( "zombie_large" );
        navmeshlayer = ter_op( var_34bb55fbc59c2e1d, "vehicle_large", ter_op( var_a8c9b5fffa6387d, "zombie_large", undefined ) );
        splinepoints = self findsplinepath( self.origin, position, 150, 250, 100, anglestoforward( self.angles ), ( 0, 0, 0 ), 300, 0.8, 0, 1, undefined, 0, 1 );
        
        if ( isdefined( splinepoints ) && istrue( debugdraw ) )
        {
            /#
                thread scripts\common\vehicle_paths::function_68d5232181fec390( splinepoints, ter_op( isdefined( navmeshlayer ), ( 1, 1, 1 ), ( 1, 0, 0 ) ) );
                thread scripts\common\vehicle_paths::function_2a708e9755fc798b( navmeshlayer, 500 );
            #/
        }
        
        waittill_any_2( "navspline_interrupted", "path_blocked" );
    }
}

// Namespace namespace_bac291bbcfb102fc / namespace_42d2620e5c90a424
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x716
// Size: 0x1c3
function private function_7f0c1e61a13ca16e( vehicle )
{
    if ( !vehicle hascomponent( "p2p" ) )
    {
        vehicle addcomponent( "p2p" );
    }
    
    if ( !vehicle hascomponent( "path" ) )
    {
        vehicle addcomponent( "path" );
    }
    
    if ( !vehicle hascomponent( "animator" ) )
    {
        vehicle addcomponent( "animator" );
    }
    
    vehicle setconfigvalue( "p2p", "checkStuck", 0 );
    vehicle setconfigvalue( "p2p", "brakeAtGoal", 1 );
    vehicle setconfigvalue( "p2p", "automaticNormal", 1 );
    vehicle setconfigvalue( "p2p", "brakeOnGoalGasbrake", 1 );
    vehicle setconfigvalue( "p2p", "goalPoint", vehicle.origin );
    vehicle setconfigvalue( "p2p", "goalThreshold", 200 );
    vehicle setconfigvalue( "p2p", "throttleSpeedClose", 1 );
    vehicle setconfigvalue( "p2p", "throttleSpeedThreshold", 1 );
    vehicle setconfigvalue( "p2p", "automaticFastTopspeedFraction", 1 );
    vehicle setconfigvalue( "p2p", "throttleSpeedFarBelow", 1 );
    vehicle setconfigvalue( "p2p", "throttleSpeedFarAbove", 4 );
    vehicle setconfigvalue( "p2p", "throttleSpeedClose", 2 );
    vehicle setconfigvalue( "p2p", "gasToStopMovement", 0.9 );
    vehicle setconfigvalue( "p2p", "steeringMultiplier", 2 );
    vehicle setconfigvalue( "path", "radiusToStep", 300 );
    vehicle.stopping = 0;
    vehicle scripts\common\vehicle_code::vehicle_disable_navobstacles();
    speedips = mph_to_ips( vehicle vehicle_gettopspeedforward( 1 ) );
    vehicle setconfigvalue( "p2p", "manualSpeed", speedips );
}

