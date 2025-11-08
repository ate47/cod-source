#using script_1c47017ba325709a;
#using script_2b736eb3fdd9b328;
#using script_4bac13d511590220;
#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\flags;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;
#using scripts\mp\utility\player;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\teams;

#namespace namespace_38f7228a0bb0b8a8;

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 1
// Checksum 0x0, Offset: 0x318
// Size: 0x115
function function_80d68c9701e1aea5( data )
{
    scripts\mp\flags::function_1240434f4201ac9d( "vehicle_patrol_paths_selected" );
    level.convoyattack = spawnstruct();
    level.convoyattack.speed = getdvarfloat( @"hash_ffe88a9964ee8cda", 20 );
    level.convoyattack.usetruck = getdvarint( @"hash_ceaf6d7a5f1db16e", 1 );
    level.var_4b11054eaa9aa4ec = [];
    
    foreach ( p in level.var_9e7adb59a0cb3e3d )
    {
        p.origin = p.path[ 0 ].origin;
        level.var_4b11054eaa9aa4ec[ level.var_4b11054eaa9aa4ec.size ] = p;
    }
    
    function_b713f2d39b34540f( data, &function_f04c99751cdc9e0c, level.var_4b11054eaa9aa4ec );
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 2
// Checksum 0x0, Offset: 0x435
// Size: 0xec
function function_f04c99751cdc9e0c( activity, node )
{
    task = task_create( activity );
    task.funcs[ "onInit" ] = &function_db3d241c0c7aad79;
    task.funcs[ "onTeamAssigned" ] = &function_2c9f290c95b69f86;
    task.funcs[ "onPlayerJoined" ] = &function_51d145a2e76e5a7b;
    task.funcs[ "onPlayerRemoved" ] = &function_a7933ef4399591a;
    task.funcs[ "onTeamStart" ] = &function_75070f6092d4f6e;
    task.funcs[ "onCancel" ] = &function_d7edc7ea0b792a79;
    task.node = node;
    task.ref = "dmz_convoy_attack";
    task.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex( task.ref );
    return task;
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 0
// Checksum 0x0, Offset: 0x52a
// Size: 0x253
function function_db3d241c0c7aad79()
{
    if ( !isdefined( self.node ) )
    {
        return;
    }
    
    function_c847bfd52c064289( self.node.origin + ( 0, 0, 60 ) );
    
    if ( !scripts\cp_mp\vehicles\vehicle::function_fa537f1ab52a76d1( "veh9_jltv_mg" ) )
    {
        task_ended();
        return;
    }
    
    self.activity.origin = self.node.origin;
    self.caches = [];
    self.node.initai = 1;
    self.node.spawntype = "GAME_MODE";
    self.node.team = "team_hundred_ninety_five";
    self.node.showheadicon = 1;
    
    if ( istrue( level.convoyattack.usetruck ) )
    {
        self.vehicle = function_d54ed88824a6416e();
    }
    else
    {
        self.vehicle = function_5751a98afbcc56bd();
    }
    
    scripts\mp\objidpoolmanager::update_objective_onentity( self.icon, self.vehicle );
    thread function_6fb25f6b9a58b347();
    self.vehicle namespace_9246f10206f50768::function_1da2c31423c2676a( level.convoyattack.speed );
    self.node.direction = 1;
    self.node.index = 0;
    self.vehicle setconfigvalue( "p2p", "brakeAtGoal", 0 );
    self.vehicle setconfigvalue( "p2p", "goalThreshold", level.convoyattack.speed * 4 );
    self.vehicle setconfigvalue( "p2p", "steeringMultiplier", 2.5 );
    self.vehicle setconfigvalue( "p2p", "stuckTime", 4 );
    self.vehicle.pathdata = self.node;
    self.vehicle thread namespace_9246f10206f50768::function_c3889abf5cd6abbf( self.node, level.convoyattack.speed );
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 1
// Checksum 0x0, Offset: 0x785
// Size: 0xb
function function_51d145a2e76e5a7b( player )
{
    
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 1
// Checksum 0x0, Offset: 0x798
// Size: 0xb
function function_a7933ef4399591a( player )
{
    
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 1
// Checksum 0x0, Offset: 0x7ab
// Size: 0xb
function function_d7edc7ea0b792a79( team )
{
    
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 1
// Checksum 0x0, Offset: 0x7be
// Size: 0x18
function function_2c9f290c95b69f86( team )
{
    function_1759acfd39bb5edf( "dmz_convoy_attack_assigned", team );
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 1
// Checksum 0x0, Offset: 0x7de
// Size: 0xb
function function_75070f6092d4f6e( team )
{
    
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 0
// Checksum 0x0, Offset: 0x7f1
// Size: 0x9
function function_8250fd658e3aae32()
{
    function_629ed367d1393020();
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 0
// Checksum 0x0, Offset: 0x802
// Size: 0x48
function function_4377e070100de7ec()
{
    function_8250fd658e3aae32();
    
    if ( isdefined( self.teams[ 0 ] ) )
    {
        function_cd4f277cf0d6a560( self.teams[ 0 ] );
        function_1759acfd39bb5edf( "dmz_convoy_attack_success", self.teams[ 0 ] );
    }
    
    task_ended();
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 0
// Checksum 0x0, Offset: 0x852
// Size: 0x28
function function_6fb25f6b9a58b347()
{
    self endon( "task_ended" );
    self.vehicle waittill( "death" );
    function_30dea07ecda5db65();
    thread function_4377e070100de7ec();
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 0
// Checksum 0x0, Offset: 0x882
// Size: 0x164
function function_5751a98afbcc56bd()
{
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "veh9_jltv_mg", self.node );
    vehicle.var_7ee6203c5532a9e6 = 1;
    vehicle.task = self;
    vehicle.var_eb504fc7e1cfeb4c = 1;
    poiname = scripts\mp\poi::poi_findPOIOriginIsIn( self.node.origin, 0, 1 );
    agenttypes = namespace_43bf74a2ee9234c0::getVehicleRiderTypes( "veh9_jltv_mg" );
    spawners = namespace_43bf74a2ee9234c0::function_f260b1cef943f1ab( "veh9_jltv_mg", 4, agenttypes, self.node.origin, poiname, "absolute" );
    riders = namespace_43bf74a2ee9234c0::function_4ad6c25d6754f697( spawners, 4, undefined, "absolute", "convoy_attack", "convoy_attack", "team_hundred_ninety_five", undefined, "veh9_jltv_mg" );
    
    if ( riders.size > 0 )
    {
        foreach ( rider in riders )
        {
            rider.var_c7845d939c783cef = 1;
        }
    }
    
    if ( isdefined( riders[ 1 ] ) )
    {
        riders[ 1 ] setstealthstate( "combat" );
    }
    
    vehicle scripts\cp_mp\vehicles\vehicle::function_f92faaaf5c5077c6( riders, 1, 1 );
    return vehicle;
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 2
// Checksum 0x0, Offset: 0x9ef
// Size: 0x9a
function function_859ffd6bdcf262a7( offset, angles )
{
    worldpos = coordtransform( offset, self.origin, self.angles );
    worldangles = combineangles( self.angles, angles );
    cache = spawnscriptable( "br_loot_cache_convoy_attack", worldpos, angles );
    cache scriptablesetparententity( self, offset, angles );
    self.task.caches[ self.task.caches.size ] = cache;
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 0
// Checksum 0x0, Offset: 0xa91
// Size: 0x1a0
function function_d54ed88824a6416e()
{
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "veh9_mil_cargo_truck", self.node );
    vehicle.var_7ee6203c5532a9e6 = 1;
    vehicle.task = self;
    vehicle.var_eb504fc7e1cfeb4c = 1;
    poiname = scripts\mp\poi::poi_findPOIOriginIsIn( self.node.origin, 0, 1 );
    agenttypes = namespace_43bf74a2ee9234c0::getVehicleRiderTypes( "veh9_mil_cargo_truck" );
    spawners = namespace_43bf74a2ee9234c0::function_f260b1cef943f1ab( "veh9_mil_cargo_truck", 7, agenttypes, self.node.origin, poiname, "absolute" );
    riders = namespace_43bf74a2ee9234c0::function_4ad6c25d6754f697( spawners, 7, undefined, "absolute", "convoy_attack", "convoy_attack", "team_hundred_ninety_five", undefined, "veh9_mil_cargo_truck_convoy_attack" );
    
    if ( riders.size > 0 )
    {
        vehicle thread function_d9592f915ec62177( riders[ 0 ] );
        
        foreach ( rider in riders )
        {
            rider.var_c7845d939c783cef = 1;
        }
    }
    
    vehicle scripts\cp_mp\vehicles\vehicle::function_f92faaaf5c5077c6( riders, 1, 1 );
    vehicle function_859ffd6bdcf262a7( ( 33, 23, 10 ), ( 0, 90, 0 ) );
    vehicle function_859ffd6bdcf262a7( ( 33, -23, 10 ), ( 0, 90, 0 ) );
    return vehicle;
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 0
// Checksum 0x0, Offset: 0xc3a
// Size: 0x78
function function_30dea07ecda5db65()
{
    if ( istrue( self.openedcaches ) )
    {
        return;
    }
    
    self.openedcaches = 1;
    
    foreach ( cache in self.caches )
    {
        cache setscriptablepartstate( "body", "closed_usable" );
    }
}

// Namespace namespace_38f7228a0bb0b8a8 / namespace_a3ac717bde4bea03
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xcba
// Size: 0x43
function private function_d9592f915ec62177( driver )
{
    self endon( "death" );
    self endon( "unloaded" );
    driver waittill( "death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.task function_30dea07ecda5db65();
    namespace_d2c35aa0ab3fe2d2::function_ab0ee2215eb51dd5( "combat" );
}

