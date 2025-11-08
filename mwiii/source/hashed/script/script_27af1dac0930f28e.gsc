#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_occupancy;

#namespace namespace_b5ab7539f1c4a823;

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 1
// Checksum 0x0, Offset: 0x154
// Size: 0x5d
function function_ce9d634e565ef6de( vehicles )
{
    if ( !isdefined( vehicles ) )
    {
        return;
    }
    
    foreach ( vehicle in vehicles )
    {
        function_791c40715c757bd9( vehicle );
    }
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 1
// Checksum 0x0, Offset: 0x1b9
// Size: 0x13d
function function_791c40715c757bd9( vehicle )
{
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    if ( isdefined( vehicle.spawnfunction ) && isdefined( vehicle.spawnposition ) && isdefined( vehicle.spawnrotation ) )
    {
        vehicle.vehicleentity = [[ vehicle.spawnfunction ]]( vehicle.spawnposition, vehicle.spawnrotation );
    }
    
    if ( isdefined( vehicle.vehicleentity ) )
    {
        if ( isdefined( vehicle.spawndestroyed ) )
        {
            vehicle.vehicleentity function_b9a4d29f4bc73806();
        }
        
        if ( isdefined( vehicle.initialdamage ) )
        {
            vehicle.vehicleentity dodamage( vehicle.vehicleentity.health * vehicle.initialdamage, vehicle.spawnposition );
        }
        
        if ( isdefined( vehicle.vfxdata ) )
        {
            vehicle.vfx = spawnscriptable( vehicle.vfxdata[ 0 ], vehicle.vfxdata[ 1 ], vehicle.vfxdata[ 2 ] );
        }
        
        vehicle thread function_71a45813be39078e();
    }
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2fe
// Size: 0x43
function private function_71a45813be39078e()
{
    while ( isdefined( self.vehicleentity ) )
    {
        wait 1;
    }
    
    if ( isdefined( self.vfx ) )
    {
        self.vfx.origin = ( 0, 0, 0 );
    }
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 2
// Checksum 0x0, Offset: 0x349
// Size: 0x90
function function_1bc8a302d36b9ab8( position, rotation )
{
    if ( !function_fa537f1ab52a76d1( "atv" ) )
    {
        println( "<dev string:x1c>" );
        return;
    }
    
    println( "<dev string:x32>" );
    spawndata = spawnstruct();
    faildata = spawnstruct();
    spawndata.origin = position;
    spawndata.angles = rotation;
    vehicle = vehicle_spawn( "atv", spawndata, faildata );
    return vehicle;
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 2
// Checksum 0x0, Offset: 0x3e2
// Size: 0x90
function function_7faf4fc46a309ce4( position, rotation )
{
    if ( !function_fa537f1ab52a76d1( "little_bird" ) )
    {
        println( "<dev string:x43>" );
        return;
    }
    
    println( "<dev string:x58>" );
    spawndata = spawnstruct();
    faildata = spawnstruct();
    spawndata.origin = position;
    spawndata.angles = rotation;
    vehicle = vehicle_spawn( "little_bird", spawndata, faildata );
    return vehicle;
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 2
// Checksum 0x0, Offset: 0x47b
// Size: 0x90
function function_441b0847b091c73f( position, rotation )
{
    if ( !function_fa537f1ab52a76d1( "tac_rover" ) )
    {
        println( "<dev string:x68>" );
        return;
    }
    
    println( "<dev string:x84>" );
    spawndata = spawnstruct();
    faildata = spawnstruct();
    spawndata.origin = position;
    spawndata.angles = rotation;
    vehicle = vehicle_spawn( "tac_rover", spawndata, faildata );
    return vehicle;
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 2
// Checksum 0x0, Offset: 0x514
// Size: 0x90
function function_c446faece0456afc( position, rotation )
{
    if ( !function_fa537f1ab52a76d1( "veh9_mil_cargo_truck" ) )
    {
        println( "<dev string:x9b>" );
        return;
    }
    
    println( "<dev string:xb9>" );
    spawndata = spawnstruct();
    faildata = spawnstruct();
    spawndata.origin = position;
    spawndata.angles = rotation;
    vehicle = vehicle_spawn( "veh9_mil_cargo_truck", spawndata, faildata );
    return vehicle;
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 2
// Checksum 0x0, Offset: 0x5ad
// Size: 0xa1
function function_9758acff14ae878e( position, rotation )
{
    if ( !function_fa537f1ab52a76d1( "veh9_suv_1996" ) )
    {
        println( "<dev string:xd2>" );
        return;
    }
    
    println( "<dev string:xed>" );
    spawndata = spawnstruct();
    faildata = spawnstruct();
    spawndata.origin = position;
    spawndata.angles = rotation;
    spawndata.vehicletype = "suv_1996_spawn";
    vehicle = vehicle_spawn( "veh9_suv_1996", spawndata, faildata );
    return vehicle;
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 5
// Checksum 0x0, Offset: 0x657
// Size: 0x82
function function_944743524ecaea3( position, speed, acceleration, yaw, hovering )
{
    if ( !isdefined( self ) || !isdefined( position ) || !isdefined( speed ) || !isdefined( acceleration ) )
    {
        return;
    }
    
    self vehicle_turnengineon();
    self vehicle_setspeed( speed, acceleration );
    
    if ( isdefined( hovering ) )
    {
        self sethoverparams( hovering[ 0 ], hovering[ 1 ], hovering[ 2 ] );
    }
    
    self setvehgoalpos( position, 1 );
    
    if ( isdefined( yaw ) )
    {
        self setgoalyaw( yaw );
    }
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 1
// Checksum 0x0, Offset: 0x6e1
// Size: 0x35
function function_b9a4d29f4bc73806( callback )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self dodamage( self.health, self.origin );
    
    if ( isdefined( callback ) )
    {
        self thread [[ callback ]]();
    }
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 1
// Checksum 0x0, Offset: 0x71e
// Size: 0x1a
function function_4d84a1c381ece6c0( callback )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    thread function_63a435765cc08( callback );
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x740
// Size: 0x3a
function private function_63a435765cc08( callback )
{
    initialhealth = self.health;
    
    while ( self.health >= initialhealth )
    {
        waitframe();
    }
    
    function_b9a4d29f4bc73806( callback );
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 2
// Checksum 0x0, Offset: 0x782
// Size: 0x23
function function_11cc5dbd12cb9f9e( position, speed )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    thread function_446ed0697b1b25a2( position, speed );
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x7ad
// Size: 0x72
function private function_446ed0697b1b25a2( position, speed )
{
    if ( !isdefined( speed ) )
    {
        speed = 40;
    }
    
    if ( self vehicle_isphysveh() )
    {
        self vehphys_crash();
    }
    
    self vehicle_setspeed( speed, 15, 10 );
    self setvehgoalpos( position, 0 );
    
    if ( soundexists( "hind_helicopter_dying_loop" ) )
    {
        self playloopsound( "hind_helicopter_dying_loop" );
    }
    
    thread function_35da48c2e41c32f7();
    self waittill( "death" );
    self notify( "vehicle_crashDone" );
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x827
// Size: 0x62
function private function_35da48c2e41c32f7()
{
    self endon( "vehicle_crashDone" );
    self clearlookatent();
    self setmaxpitchroll( 60, 90 );
    self setyawspeed( 700, 200, 200 );
    
    for ( ;; )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        irand = randomintrange( 140, 170 );
        self settargetyaw( self.angles[ 1 ] + irand );
        wait 0.5;
    }
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 1
// Checksum 0x0, Offset: 0x891
// Size: 0x1d
function function_ee15cb02c86edc6e( vehicle )
{
    assert( isdefined( vehicle ) );
    return vehicle_occupancy_getdriver( vehicle );
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 1
// Checksum 0x0, Offset: 0x8b7
// Size: 0x91
function function_cb90a442bf4d8100( modifier )
{
    if ( !isdefined( self ) || !isvehicle() )
    {
        return;
    }
    
    switch ( modifier )
    {
        case #"hash_bdb6392e8750d9b0":
            vehicle_damage_setpremoddamagecallback( self.vehiclename, &function_1e94e45fcb25f69a );
            break;
        case #"hash_db653a4972b3c13b":
            vehicle_damage_setpremoddamagecallback( self.vehiclename, &function_7f608c6951fd341d );
            break;
        default:
            vehicle_damage_setpremoddamagecallback( self.vehiclename, &function_7f608c6951fd341d );
            break;
    }
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 1
// Checksum 0x0, Offset: 0x950
// Size: 0x32, Type: bool
function function_1e94e45fcb25f69a( data )
{
    if ( data.inflictor == level.player )
    {
        data.damage = 0;
    }
    
    return true;
}

// Namespace namespace_b5ab7539f1c4a823 / namespace_9e27347da4069f42
// Params 1
// Checksum 0x0, Offset: 0x98b
// Size: 0xc, Type: bool
function function_7f608c6951fd341d( data )
{
    return false;
}

