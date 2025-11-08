#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_wave_spawning;
#using scripts\cp\damage;
#using scripts\cp\damagefeedback;
#using scripts\cp\helicopter\cp_helicopter;
#using scripts\cp\persistence;
#using scripts\cp\points;
#using scripts\cp\spawner_scoring;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\vehicles;
#using scripts\cp\vehicles\vehicle_cp;
#using scripts\cp\vo;
#using scripts\cp\weapon;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_anim;
#using scripts\cp_mp\vehicles\vehicle_dlog;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace vehicles;

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xd56
// Size: 0x19c
function vehicles_init()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) == 1 )
    {
        return;
    }
    
    if ( getdvar( @"hash_742caa13b3c2e685" ) == "1" )
    {
        return;
    }
    
    level endon( "game_ended" );
    level thread scripts\cp_mp\vehicles\vehicle::vehicle_init();
    
    if ( isdefined( level.vehicles_init ) )
    {
        [[ level.vehicles_init ]]();
    }
    
    if ( !isdefined( level.unloading_func ) )
    {
        level.unloading_func = [];
    }
    
    if ( !isdefined( level.unloaded_func ) )
    {
        level.unloaded_func = [];
    }
    
    if ( !isdefined( level.vehicle_builds ) )
    {
        level.vehicle_builds = [];
    }
    
    setdvar( @"hash_b77d72f69452a294", 1 );
    level thread init_vehicle_spawning();
    scripts\cp_mp\vehicles\vehicle_anim::init_vehicles();
    create_func_ref( "vehicle_damage_modifier", &cp_vehicle_damage_monitor );
    create_func_ref( "anim_placeweaponon", &scripts\anim\shared::placeweaponon );
    level._effect[ "helidown_rpghit" ] = loadfx( "vfx/iw8_cp/chopper/vfx_chopper_air_explosion.vfx" );
    level._effect[ "helidown_tailfire" ] = loadfx( "vfx/iw8_cp/chopper/vfx_cp_fire_fire_trail.vfx" );
    level._effect[ "helidown_groundexp" ] = loadfx( "vfx/iw8_cp/chopper/vfx_cp_chopper_ground_exp.vfx" );
    
    /#
        flag_wait( "<dev string:x1c>" );
        cmd = "<dev string:x35>";
        addentrytodevgui( cmd );
        cmd = "<dev string:x89>";
        addentrytodevgui( cmd );
        cmd = "<dev string:xf4>";
        addentrytodevgui( cmd );
        create_func_ref( "<dev string:x15b>", &setup_player_vehicles );
        level thread debug_activation( @"hash_67d581853aa8906d", &cp_vehicle_debug );
    #/
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xefa
// Size: 0xb0
function unset_bullet_shields()
{
    if ( isdefined( level.vehicle ) )
    {
        if ( isdefined( level.vehicle.templates ) )
        {
            if ( isdefined( level.vehicle.templates.bullet_shield ) )
            {
                keys = getarraykeys( level.vehicle.templates.bullet_shield );
                
                for ( i = 0; i < keys.size ; i++ )
                {
                    level.vehicle.templates.bullet_shield[ keys[ i ] ] = 0;
                }
            }
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xfb2
// Size: 0x256
function create_passengers_unload_groups()
{
    if ( isdefined( level.vehicle ) )
    {
        if ( isdefined( level.vehicle.templates ) )
        {
            if ( isdefined( level.vehicle.templates.unloadgroups ) )
            {
                keys = getarraykeys( level.vehicle.templates.unloadgroups );
                
                for ( i = 0; i < keys.size ; i++ )
                {
                    key = keys[ i ];
                    passenger_size = level.vehicle.templates.aianims[ keys[ i ] ].size;
                    
                    if ( !isdefined( level.vehicle.templates.unloadgroups[ key ] ) )
                    {
                        level.vehicle.templates.unloadgroups[ key ] = [];
                    }
                    
                    if ( isdefined( level.vehicle.templates.unloadgroups[ key ][ "passengers" ] ) )
                    {
                        continue;
                    }
                    
                    if ( passenger_size > 1 )
                    {
                        for ( j = 1; j < passenger_size ; j++ )
                        {
                            if ( isdefined( level.vehicle.templates.aianims[ key ][ j ] ) )
                            {
                                seat = level.vehicle.templates.aianims[ key ][ j ];
                                
                                if ( isdefined( seat.getout ) )
                                {
                                    if ( !isdefined( level.vehicle.templates.unloadgroups[ key ][ "passengers" ] ) )
                                    {
                                        level.vehicle.templates.unloadgroups[ key ][ "passengers" ] = [];
                                    }
                                    
                                    level.vehicle.templates.unloadgroups[ key ][ "passengers" ][ level.vehicle.templates.unloadgroups[ key ][ "passengers" ].size ] = j;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x1210
// Size: 0xb4
function set_vehicle_templates_script_team()
{
    if ( isdefined( level.vehicle ) )
    {
        if ( isdefined( level.vehicle.templates ) )
        {
            if ( isdefined( level.vehicle.templates.team ) )
            {
                keys = getarraykeys( level.vehicle.templates.team );
                
                for ( i = 0; i < keys.size ; i++ )
                {
                    level.vehicle.templates.team[ keys[ i ] ] = "axis";
                }
            }
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x12cc
// Size: 0x2fb
function vehiclefollowstructpathsplines( path_start, pathing_array, var_6f3f0d19b9577e15 )
{
    self endon( "death" );
    self endon( "stop_follow_path" );
    self endon( "reset_path" );
    level endon( "game_ended" );
    
    if ( pathing_array.size == 0 )
    {
        assertmsg( "Pathing_array.size == 0" );
        return;
    }
    
    if ( !isdefined( path_start ) )
    {
        assertmsg( "path_start is undefined" );
        return;
    }
    
    while ( pathing_array.size < 4 )
    {
        var_f17000b1738727b3 = create_extra_structpath( 1, pathing_array[ pathing_array.size - 1 ].origin, pathing_array[ pathing_array.size - 2 ].origin );
        pathing_array[ pathing_array.size ] = var_f17000b1738727b3;
    }
    
    var_865de0e45fd72eda = [];
    durations = [];
    amount = pathing_array.size;
    currentpoint = undefined;
    last_point = self.origin;
    vel = 15;
    
    for ( i = 0; i < amount ; i++ )
    {
        if ( isdefined( pathing_array[ i + 1 ] ) )
        {
            currentpoint = pathing_array[ i + 1 ].origin;
        }
        
        if ( i == 0 )
        {
            var_865de0e45fd72eda[ var_865de0e45fd72eda.size ] = self.origin;
        }
        else
        {
            var_865de0e45fd72eda[ var_865de0e45fd72eda.size ] = pathing_array[ i ].origin;
        }
        
        path_speed = 300;
        
        if ( ( !isdefined( self.convoy ) || istrue( self.convoy.settings.use_path_speeds ) ) && isdefined( pathing_array[ i ].speed ) )
        {
            path_speed = 300 * pathing_array[ i ].speed / 15;
            
            /#
            #/
        }
        
        var_d530f6290fec0a8c = get_duration_between_points( last_point, currentpoint, ter_op( isdefined( self.cp_speed ), self.cp_speed, path_speed ) );
        durations[ durations.size ] = var_d530f6290fec0a8c;
        last_point = currentpoint;
    }
    
    if ( vehicle_on_last_pathing_array( self ) )
    {
        self startpathnodes( var_865de0e45fd72eda, durations );
    }
    else
    {
        self startpathnodes( var_865de0e45fd72eda, durations, 0, 0.5, 0.5, 0, 0, 0 );
    }
    
    thread vehicle_process_node_when_at_goal( var_6f3f0d19b9577e15 );
    self notify( "startpathnodes" );
    
    for ( i = 0; i < durations.size ; i++ )
    {
        while ( function_cb612f9367051ea2( i > 0 && durations[ i ] > 1 ) )
        {
            wait 0.25;
        }
        
        wait durations[ i ];
    }
    
    if ( vehicle_on_last_pathing_array( self ) )
    {
        self.on_last_pathing_array = undefined;
        
        if ( isdefined( self.convoy ) && !istrue( self.convoy.settings.roaming ) || !isdefined( self.convoy ) )
        {
            thread finish_spline_path();
        }
    }
    
    if ( istrue( self.looping_path ) )
    {
        vehiclefollowstructpathsplines( self.pathing_array[ 0 ], self.pathing_array, 1 );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x15cf
// Size: 0x127
function vehicle_process_node_when_at_goal( var_6f3f0d19b9577e15 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self notify( "vehicle_process_node_when_at_goal" );
    self endon( "vehicle_process_node_when_at_goal" );
    dist_sq = 62500;
    node_index = 1;
    nextpoint = self.pathing_array[ node_index ];
    lastpoint = self.pathing_array[ node_index ];
    level.vehicle_tracker = self;
    
    if ( istrue( var_6f3f0d19b9577e15 ) )
    {
        thread process_nextpoint_after_struct_wait( nextpoint, dist_sq );
    }
    
    while ( true )
    {
        self waittill( "trigger", completed_ratio, param1, param2, param3 );
        
        if ( isint( completed_ratio ) )
        {
            if ( node_index < completed_ratio + 1 )
            {
                if ( isdefined( self.path_gobbler ) )
                {
                    deletestruct_ref( nextpoint );
                }
                
                node_index = completed_ratio + 1;
                nextpoint = get_next_node_on_spline( node_index );
                
                if ( isdefined( nextpoint ) )
                {
                    lastpoint = nextpoint;
                    self notify( "new_next_point" );
                    
                    if ( istrue( var_6f3f0d19b9577e15 ) )
                    {
                        thread process_nextpoint_after_struct_wait( nextpoint, dist_sq );
                    }
                    
                    continue;
                }
                
                break;
            }
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x16fe
// Size: 0x58
function process_nextpoint_after_struct_wait( nextpoint, dist_sq )
{
    self notify( "process_nextPoint_after_struct_wait" );
    self endon( "process_nextPoint_after_struct_wait" );
    self endon( "death" );
    
    while ( distancesquared( self.origin, nextpoint.origin ) > dist_sq )
    {
        wait 0.1;
    }
    
    process_vehicle_struct_node( nextpoint );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x175e
// Size: 0xdc
function process_vehicle_struct_node( nextpoint )
{
    self endon( "newpath" );
    self endon( "death" );
    get_func = get_path_getfunc( nextpoint );
    lastpoint = undefined;
    self.currentnode = nextpoint;
    trigger_process_node( nextpoint );
    
    if ( vehicle_should_unload( &node_wait, nextpoint ) )
    {
        self vehicle_setspeedimmediate( 0, 1, 1 );
        struct_path_unload_node( nextpoint );
        wait 0.25;
        
        if ( isdefined( level.vehicle.var_9442d439c225c3fe ) )
        {
            if ( [[ level.vehicle.var_9442d439c225c3fe ]]( self ) )
            {
                return;
            }
        }
        
        if ( !isdefined( self.riders ) || self.riders.size < 1 )
        {
            self notify( "vehicle_process_node_when_at_goal" );
            self notify( "stop_follow_path" );
            return;
        }
        
        self resumespeed( 20 );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x1842
// Size: 0x284
function struct_path_unload_node( node )
{
    self endon( "death" );
    
    if ( isdefined( self.ent_flag ) && isdefined( self.ent_flag[ "prep_unload" ] ) && ent_flag( "prep_unload" ) )
    {
        return;
    }
    
    if ( !isdefined( node.script_flag_wait ) && !isdefined( node.script_delay ) )
    {
    }
    
    assert( isdefined( self ) );
    pathnode = getnode( node.targetname, "target" );
    
    if ( isdefined( pathnode ) && self.riders.size )
    {
        foreach ( rider in self.riders )
        {
            if ( isai( rider ) )
            {
                rider thread script_func( "go_to_node", pathnode );
            }
        }
    }
    else if ( self.riders.size )
    {
        foreach ( rider in self.riders )
        {
            if ( !isdefined( rider.spawnpoint ) )
            {
                continue;
            }
            
            if ( isdefined( rider.spawnpoint.target ) || isdefined( rider.spawnpoint.script_linkto ) )
            {
                rider thread scripts\cp\spawning::go_to_node( rider.spawnpoint scripts\cp\spawning::get_next_node_array() );
            }
        }
    }
    
    if ( scripts\common\vehicle::ishelicopter() )
    {
        self sethoverparams( 0, 0, 0 );
        waittill_stable( node );
    }
    
    if ( isdefined( node.script_noteworthy ) )
    {
        if ( node.script_noteworthy == "wait_for_flag" )
        {
            flag_wait( node.script_flag );
        }
    }
    
    if ( isdefined( node.script_unload ) )
    {
        if ( node.script_unload == "1" )
        {
            node.script_unload = "default";
        }
    }
    
    _vehicle_unload( node.script_unload );
    
    if ( scripts\common\vehicle_aianim::riders_unloadable( node.script_unload ) )
    {
        self waittill( "unloaded" );
    }
    
    if ( isdefined( node.script_flag_wait ) || isdefined( node.script_delay ) )
    {
        return;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x1ace
// Size: 0x47
function get_next_node_on_spline( node_index )
{
    if ( !isdefined( node_index ) )
    {
        return undefined;
    }
    
    if ( !isdefined( self.pathing_array ) )
    {
        return undefined;
    }
    
    if ( isdefined( self.pathing_array[ node_index ] ) )
    {
        return self.pathing_array[ node_index ];
    }
    
    return undefined;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x1b1d
// Size: 0x23, Type: bool
function function_cb612f9367051ea2( started_path )
{
    return self issuspendedvehicle() || started_path && self vehicle_getspeed() < 1;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x1b49
// Size: 0x44, Type: bool
function vehicle_on_last_pathing_array( vehicle )
{
    if ( istrue( vehicle.looping_path ) )
    {
        return false;
    }
    
    if ( isdefined( vehicle.pathing_arrays ) )
    {
        if ( istrue( vehicle.on_last_pathing_array ) )
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    return true;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x1b96
// Size: 0x89
function create_extra_structpath( after_toggle, first_position, second_position )
{
    if ( !isdefined( second_position ) )
    {
        second_position = ( first_position - self.origin ) / 2;
    }
    
    last_oldpos = first_position;
    var_e0a5fd5c9513b506 = second_position;
    avg = ( var_e0a5fd5c9513b506 + last_oldpos ) / 2;
    var_a20aa2636ccbfa4 = avg - var_e0a5fd5c9513b506;
    var_f17000b1738727b3 = spawnstruct();
    var_f17000b1738727b3.origin = last_oldpos + var_a20aa2636ccbfa4;
    return var_f17000b1738727b3;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x1c28
// Size: 0x110
function vehiclefollowstructpath( path_start, var_6f3f0d19b9577e15 )
{
    self endon( "death" );
    self endon( "stop_follow_path" );
    self endon( "reset_path" );
    level endon( "game_ended" );
    self.on_last_pathing_array = undefined;
    var_e32861b33e4343fd = undefined;
    
    if ( isdefined( self.pathing_arrays ) && self.pathing_arrays.size > 0 )
    {
        for ( i = 0; i < self.pathing_arrays.size ; i++ )
        {
            if ( !isdefined( self.pathing_arrays ) || self.pathing_arrays.size == 0 )
            {
                return;
            }
            
            if ( i == self.pathing_arrays.size - 1 )
            {
                self.on_last_pathing_array = 1;
            }
            
            vehiclefollowstructpathsplines( path_start, self.pathing_arrays[ i ], var_6f3f0d19b9577e15 );
        }
        
        return;
    }
    
    if ( isdefined( self.pathing_array ) && self.pathing_array.size > 0 )
    {
        self.on_last_pathing_array = 1;
        vehiclefollowstructpathsplines( path_start, self.pathing_array, var_6f3f0d19b9577e15 );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x1d40
// Size: 0x12b
function finish_spline_path()
{
    self endon( "death" );
    
    if ( isdefined( self.convoy ) )
    {
        if ( !isdefined( self.convoy.settings ) || istrue( self.convoy.settings.unload_at_target ) )
        {
            if ( isdefined( level.vehicle_all_stop_func ) )
            {
                self [[ level.vehicle_all_stop_func ]]( 0 );
            }
            
            self notify( "unload_guys" );
        }
        
        if ( isdefined( self.convoy.settings ) && isdefined( self.convoy.settings.target ) )
        {
            self notify( "unload_guys" );
        }
    }
    
    self stoppath( 1 );
    self notify( "stop_follow_path" );
    final_node = self.pathing_array[ self.pathing_array.size - 1 ];
    
    if ( isdefined( final_node ) )
    {
        struct_path_unload_node( final_node );
        wait 0.25;
        
        if ( isdefined( level.vehicle.var_9442d439c225c3fe ) )
        {
            if ( [[ level.vehicle.var_9442d439c225c3fe ]]( self ) )
            {
                return;
            }
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x1e73
// Size: 0x340
function cp_vehicle_damage_monitor( damage_data )
{
    idamage = undefined;
    
    if ( isdefined( damage_data ) )
    {
        if ( isdefined( damage_data.damage ) )
        {
            idamage = damage_data.damage;
        }
        
        if ( isdefined( damage_data.attacker ) && isplayer( damage_data.attacker ) && isdefined( idamage ) )
        {
            if ( isdefined( damage_data.attacker.team ) && isdefined( self.team ) && damage_data.attacker.team != self.team )
            {
                if ( isdefined( damage_data.objweapon ) && isdefined( damage_data.objweapon.basename ) )
                {
                    if ( damage_data.objweapon.basename == "emp_drone_player_mp" )
                    {
                        idamage = 10000;
                    }
                }
            }
            
            if ( isdefined( damage_data.objweapon ) && isdefined( damage_data.objweapon.basename ) )
            {
                switch ( damage_data.objweapon.basename )
                {
                    case #"hash_85ea99fcbe4116a4":
                    case #"hash_91a48ebfd2d03a40":
                        if ( isdefined( self.healthbuffer ) )
                        {
                            self.health = self.healthbuffer - 100;
                        }
                        else
                        {
                            self.health = 0;
                        }
                        
                        break;
                }
                
                if ( isdefined( damage_data.meansofdeath ) )
                {
                    idamage = scripts\cp\damage::handleapdamage( damage_data.objweapon, damage_data.meansofdeath, idamage, damage_data.attacker );
                }
            }
            
            if ( isdefined( self.var_f6a794b2d3dc63e7 ) )
            {
                idamage = self [[ self.var_f6a794b2d3dc63e7 ]]( damage_data );
            }
            
            if ( isdefined( self.damage_multiplier ) )
            {
                idamage *= self.damage_multiplier;
            }
            
            if ( istrue( damage_data.attacker.damage_from_above ) )
            {
                attacker_z = damage_data.attacker.origin[ 2 ];
                victim_z = self.origin[ 2 ];
                
                if ( attacker_z >= victim_z )
                {
                    difference = int( abs( attacker_z - victim_z ) );
                    idamage_multiplier = int( difference / 64 );
                    
                    if ( idamage_multiplier > 0 )
                    {
                        idamage *= 1 + 0.4 * idamage_multiplier;
                    }
                }
            }
            
            if ( damage_data.meansofdeath == "MOD_GRENADE_SPLASH" || damage_data.meansofdeath == "MOD_PROJECTILE_SPLASH" || damage_data.meansofdeath == "MOD_PROJECTILE" || damage_data.meansofdeath == "MOD_GRENADE" )
            {
                idamage = function_869e06b0541def6d( idamage );
            }
            
            damage_data.attacker scripts\cp\damagefeedback::updatehitmarker( "standard", 1, idamage, 0, 0 );
            new_health = self.health - idamage;
            self.health = int( max( new_health, self.healthbuffer - 1 ) );
        }
    }
    
    return idamage;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x21bc
// Size: 0x14
function function_869e06b0541def6d( amount )
{
    return int( amount * 5 );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x21d9
// Size: 0xe5
function init_vehicle_spawning()
{
    level.ai_spawn_vehicle_func = [];
    level.next_index = 0;
    level.all_ai_vehicle_infils = [];
    level.available_ai_vehicle_air_infils = [];
    level.available_ai_vehicle_ground_infils = [];
    level.path_points = [];
    level.invalid_path_points = [];
    level.heli_triggers = [];
    level.vehicle_ai_script_models = [];
    vehicle_registrations();
    level thread init_vehicles_after_flags();
    add_ai_air_infil( "attack_heli" );
    register_vehicle_spawn( "attack_heli", undefined, undefined, undefined, "heli_spawner", undefined, "heli_infil_path", undefined, &spawn_enemy_chopper, "apache" );
    register_vehicle_spawn( "random_ground_vehicle_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, &choose_random_ground_vehicle_spawn );
    register_vehicle_spawn( "random_air_vehicle_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, &choose_random_air_vehicle_spawn );
    register_vehicle_spawn( "escalation_heli_spawn", undefined, undefined, undefined, undefined, undefined, undefined, undefined, &choose_escalation_air_vehicle_spawn );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x22c6
// Size: 0xfb
function init_vehicles_after_flags()
{
    level endon( "game_ended" );
    flag_wait( "level_ready_for_script" );
    unset_bullet_shields();
    create_passengers_unload_groups();
    set_vehicle_templates_script_team();
    level.ground_vehicle_structs = getstructarray( "ground_veh_infil_path", "targetname" );
    
    if ( isdefined( level.vehicle.helicopter_crash_locations ) )
    {
        level.vehicle.helicopter_crash_locations = array_combine( level.vehicle.helicopter_crash_locations, getstructarray_delete( "helicopter_crash_location", "targetname" ) );
        level.vehicle.helicopter_crash_locations = array_combine( level.vehicle.helicopter_crash_locations, getstructarray( "heli_exit", "targetname" ) );
        return;
    }
    
    level.vehicle.helicopter_crash_locations = getstructarray( "heli_exit", "targetname" );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x23c9
// Size: 0x2
function vehicle_ai_spawn_funcs()
{
    
}

// Namespace vehicles / scripts\cp\vehicles
// Params 4
// Checksum 0x0, Offset: 0x23d3
// Size: 0x82
function register_spawner_script_function( func_name, func, specs, var_64d1449ec4e9520 )
{
    if ( istrue( var_64d1449ec4e9520 ) )
    {
        level waittill( func_name );
    }
    
    if ( isdefined( level.spawner_script_funcs[ func_name ] ) )
    {
        struct = level.spawner_script_funcs[ func_name ];
    }
    else
    {
        struct = spawnstruct();
    }
    
    struct.script_function = func;
    struct.specs = specs;
    level.spawner_script_funcs[ func_name ] = struct;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x245d
// Size: 0x12a
function create_ai_plr_vehicle( veh_spawn_point, vehicle_type )
{
    copy_vehicle_build_to_spawnpoint( vehicle_type, veh_spawn_point );
    vehicle = scripts\common\vehicle::vehicle_spawn( veh_spawn_point );
    vehicle.cannotbesuspended = 1;
    
    if ( isdefined( veh_spawn_point.vehiclename ) )
    {
        vehicle.vehiclename = veh_spawn_point.vehiclename;
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam( vehicle, "axis" );
        vehicle makeunusable();
        vehicle setcandamage( 1 );
        vehicle.maxhealth = 999999;
        vehicle.health = vehicle.maxhealth;
        vehicle scripts\cp_mp\emp_debuff::set_start_emp_callback( &scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback );
        vehicle scripts\cp_mp\emp_debuff::set_clear_emp_callback( &scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback );
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance( vehicle );
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance( vehicle );
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability( vehicle );
        scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance( vehicle, undefined, undefined );
        scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent( vehicle, undefined );
        var_e9ad534890b3b83e = &scripts\cp_mp\utility\weapon_utility::setlockedoncallback;
        [[ var_e9ad534890b3b83e ]]( vehicle, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedoncallback );
        var_cfde26882efc85e = &scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback;
        [[ var_cfde26882efc85e ]]( vehicle, &scripts\cp_mp\vehicles\vehicle::vehicle_lockedonremovedcallback );
        vehicle thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped();
    }
    
    return vehicle;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 5
// Checksum 0x0, Offset: 0x2590
// Size: 0x6f
function register_vehicle_build( vehicle_type, model, type, classname, var_35c134fe54c9a072 )
{
    struct = spawnstruct();
    struct.model = model;
    struct.vehicletype = type;
    struct.classname_mp = classname;
    level.vehicle_builds[ vehicle_type ] = struct;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x2607
// Size: 0x53
function register_vehicle_as_ambient( vehicle_type, var_64d1449ec4e9520 )
{
    if ( istrue( var_64d1449ec4e9520 ) )
    {
        level waittill( vehicle_type );
    }
    
    struct = level.vehicle_builds[ vehicle_type ];
    
    if ( isdefined( struct ) )
    {
        struct.is_ambient = 1;
        struct.allow_deleteme_path = 1;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x2662
// Size: 0x21, Type: bool
function vehicle_is_ambient( vehicle_type )
{
    return istrue( level.vehicle_builds[ vehicle_type ].is_ambient );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 4
// Checksum 0x0, Offset: 0x268c
// Size: 0x7a
function create_ambient_vehicle( vehicle_type, model, type, classname )
{
    level thread register_vehicle_max_ai( vehicle_type, model, type, classname, undefined, 1, 1 );
    level thread register_vehicle_as_ambient( vehicle_type, 1 );
    level thread register_vehicle_spawn_drivers( vehicle_type, 1, random( [ "aq_pilot_fullbody_1", "aq_pilot_fullbody_2" ] ) );
    level thread register_vehicle_spawn_override( vehicle_type, undefined, undefined, undefined, undefined, undefined, undefined, 1, undefined, undefined );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 7
// Checksum 0x0, Offset: 0x270e
// Size: 0x18b
function register_vehicle_max_ai( vehicle_type, model, type, classname, var_35c134fe54c9a072, override, var_64d1449ec4e9520 )
{
    if ( istrue( var_64d1449ec4e9520 ) )
    {
        level waittill( vehicle_type );
    }
    
    if ( isdefined( level.vehicle ) )
    {
        if ( isdefined( level.vehicle.templates ) )
        {
            if ( isdefined( level.vehicle.templates.aianims ) )
            {
                if ( isdefined( level.vehicle.templates.aianims[ classname ] ) )
                {
                    if ( isdefined( level.ai_spawn_vehicle_func[ vehicle_type ] ) && isdefined( level.ai_spawn_vehicle_func[ vehicle_type ].max_ai ) )
                    {
                        if ( isdefined( override ) )
                        {
                            level.vehicle_builds[ vehicle_type ].max_ai = override;
                        }
                        else
                        {
                            level.vehicle_builds[ vehicle_type ].max_ai = level.ai_spawn_vehicle_func[ vehicle_type ].max_ai;
                        }
                        
                        return;
                    }
                    
                    if ( isdefined( override ) )
                    {
                        level.vehicle_builds[ vehicle_type ].max_ai = override;
                        return;
                    }
                    
                    var_339e16780e986b27 = level.vehicle.templates.aianims[ classname ];
                    level.vehicle_builds[ vehicle_type ].max_ai = var_339e16780e986b27.size;
                }
            }
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x28a1
// Size: 0x10a
function get_max_ai_from_infil_name( module_struct, vehicle_type )
{
    if ( isdefined( level.vehicle_builds ) && isdefined( level.vehicle_builds[ vehicle_type ] ) && isdefined( level.vehicle_builds[ vehicle_type ].max_ai ) )
    {
        invalid_seats = scripts\cp\vehicles::get_invalid_seats_from_module_struct( module_struct, vehicle_type );
        
        if ( isdefined( invalid_seats ) )
        {
            count = 0;
            
            for ( i = 0; i < self.usedpositions.size ; i++ )
            {
                found_seat = 1;
                
                for ( j = 0; j < invalid_seats.size ; j++ )
                {
                    if ( invalid_seats[ j ] == i )
                    {
                        found_seat = 0;
                        break;
                    }
                }
                
                if ( found_seat )
                {
                    count++;
                }
            }
            
            return int( min( count, level.vehicle_builds[ vehicle_type ].max_ai ) );
        }
        else
        {
            return level.vehicle_builds[ vehicle_type ].max_ai;
        }
        
        return;
    }
    
    return undefined;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x29b3
// Size: 0x11
function get_random_available_air_ai_infil()
{
    return random( level.available_ai_vehicle_air_infils );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x29cd
// Size: 0x11
function get_random_available_ground_ai_infil()
{
    return random( level.available_ai_vehicle_ground_infils );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x29e7
// Size: 0x43
function attempt_ai_ground_infil_cooldown( infil_name )
{
    if ( level.ai_spawn_vehicle_func[ infil_name ].max_num <= level.ai_spawn_vehicle_func[ infil_name ].count )
    {
        level thread remove_ai_ground_infil_for_time( infil_name );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x2a32
// Size: 0x43
function attempt_ai_air_infil_cooldown( infil_name )
{
    if ( level.ai_spawn_vehicle_func[ infil_name ].max_num <= level.ai_spawn_vehicle_func[ infil_name ].count )
    {
        level thread remove_ai_air_infil_for_time( infil_name );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x2a7d
// Size: 0x5f
function remove_ai_ground_infil_for_time( infil_name )
{
    level.available_ai_vehicle_ground_infils = array_remove( level.available_ai_vehicle_ground_infils, infil_name );
    
    if ( isdefined( level.ai_spawn_vehicle_func[ infil_name ].cooldown ) )
    {
        delaythread( level.ai_spawn_vehicle_func[ infil_name ].cooldown, &add_ai_ground_infil, infil_name );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x2ae4
// Size: 0x5f
function remove_ai_air_infil_for_time( infil_name )
{
    level.available_ai_vehicle_air_infils = array_remove( level.available_ai_vehicle_air_infils, infil_name );
    
    if ( isdefined( level.ai_spawn_vehicle_func[ infil_name ].cooldown ) )
    {
        delaythread( level.ai_spawn_vehicle_func[ infil_name ].cooldown, &add_ai_air_infil, infil_name );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x2b4b
// Size: 0x18
function add_ai_air_infil( infil_name )
{
    level.available_ai_vehicle_air_infils[ infil_name ] = infil_name;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x2b6b
// Size: 0x18
function add_ai_ground_infil( infil_name )
{
    level.available_ai_vehicle_ground_infils[ infil_name ] = infil_name;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 10
// Checksum 0x0, Offset: 0x2b8b
// Size: 0x19e
function register_vehicle_spawn_override( spawn_type, max_num, cooldown, max_wait_for_infil, spawn_points, exit_points, path_start_points, max_ai, vehicle_spawn_func, vehicle_build )
{
    level waittill( spawn_type );
    
    if ( isdefined( level.ai_spawn_vehicle_func[ spawn_type ] ) )
    {
        flag_wait( "level_ready_for_script" );
        struct = level.ai_spawn_vehicle_func[ spawn_type ];
        
        if ( isdefined( spawn_type ) )
        {
            struct.spawn_type = spawn_type;
        }
        
        if ( isdefined( max_num ) )
        {
            struct.max_num = max_num;
        }
        
        if ( isdefined( cooldown ) )
        {
            struct.cooldown = cooldown;
        }
        
        if ( isdefined( max_wait_for_infil ) )
        {
            struct.max_wait_for_infil = max_wait_for_infil;
        }
        
        if ( isdefined( spawn_points ) )
        {
            struct.spawn_points = spawn_points;
        }
        
        if ( isdefined( exit_points ) )
        {
            struct.exit_points = exit_points;
        }
        
        if ( isdefined( path_start_points ) )
        {
            struct.path_start_points = path_start_points;
        }
        
        if ( isdefined( vehicle_spawn_func ) )
        {
            struct.vehicle_spawn_func = vehicle_spawn_func;
        }
        
        if ( isdefined( vehicle_build ) )
        {
            struct.vehicle_build = vehicle_build;
        }
        
        level.ai_spawn_vehicle_func[ spawn_type ] = struct;
        
        if ( isdefined( path_start_points ) )
        {
            level thread get_path_points( spawn_type, path_start_points );
        }
    }
    
    if ( isdefined( max_ai ) )
    {
        if ( isdefined( level.vehicle_builds[ spawn_type ] ) && isdefined( level.vehicle_builds[ spawn_type ].max_ai ) )
        {
            level.vehicle_builds[ spawn_type ].max_ai = max_ai;
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 10
// Checksum 0x0, Offset: 0x2d31
// Size: 0x13b
function register_vehicle_spawn( spawn_type, max_num, cooldown, max_wait_for_infil, spawn_points, exit_points, path_start_points, max_ai, vehicle_spawn_func, vehicle_build )
{
    level.all_ai_vehicle_infils[ level.all_ai_vehicle_infils.size ] = spawn_type;
    struct = spawnstruct();
    struct.spawn_type = spawn_type;
    struct.max_num = max_num;
    struct.cooldown = cooldown;
    struct.max_wait_for_infil = max_wait_for_infil;
    struct.spawn_points = spawn_points;
    struct.exit_points = exit_points;
    struct.path_start_points = path_start_points;
    struct.vehicle_spawn_func = vehicle_spawn_func;
    struct.count = 0;
    struct.max_ai = max_ai;
    struct.vehicle_build = vehicle_build;
    struct.cpvehiclename = spawn_type;
    level.ai_spawn_vehicle_func[ spawn_type ] = struct;
    
    if ( isdefined( path_start_points ) )
    {
        level thread get_path_points( spawn_type, path_start_points );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x2e74
// Size: 0x32
function get_path_points( spawn_type, path_start_points )
{
    level endon( "game_ended" );
    level.path_points[ spawn_type ] = getstructarray( path_start_points, "targetname" );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 4
// Checksum 0x0, Offset: 0x2eae
// Size: 0x78
function register_vehicle_spawn_drivers( spawn_type, num_script_models, driver_models, var_64d1449ec4e9520 )
{
    if ( istrue( var_64d1449ec4e9520 ) )
    {
        level waittill( spawn_type );
    }
    
    if ( isdefined( level.ai_spawn_vehicle_func[ spawn_type ] ) )
    {
        struct = level.ai_spawn_vehicle_func[ spawn_type ];
        struct.num_script_models = num_script_models;
        struct.driver_models = driver_models;
        level.ai_spawn_vehicle_func[ spawn_type ] = struct;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x2f2e
// Size: 0x108
function choose_random_ground_vehicle_spawn( group, spawn_point, param3 )
{
    if ( isdefined( spawn_point.ai_infil_type ) )
    {
        random_infil = spawn_point.ai_infil_type;
    }
    else
    {
        random_infil = get_random_available_ground_ai_infil();
    }
    
    if ( isdefined( random_infil ) )
    {
        spawn_point.og_script_function = spawn_point.script_function;
        spawn_point.script_function = random_infil;
        
        if ( !isdefined( spawn_point.vehicle ) && isdefined( level.ai_spawn_vehicle_func[ random_infil ].vehicle_spawn_func ) )
        {
            if ( [[ level.ai_spawn_vehicle_func[ random_infil ].vehicle_spawn_func ]]( group, spawn_point, random_infil ) )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        else if ( isdefined( spawn_point.vehicle ) )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        self thread [[ level.spawner_script_funcs[ random_infil ].script_function ]]( group, spawn_point, random_infil );
        thread attempt_ai_ground_infil_cooldown( random_infil );
        return;
    }
    
    return 0;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x303e
// Size: 0x50
function decrement_wave_veh_count( random_infil )
{
    if ( isdefined( self.valid_vehicles ) && isdefined( self.valid_vehicles[ random_infil ] ) )
    {
        self.valid_vehicles[ random_infil ]--;
        
        if ( self.valid_vehicles[ random_infil ] < 1 )
        {
            self.valid_vehicles[ random_infil ] = undefined;
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x3096
// Size: 0x1c9
function choose_escalation_air_vehicle_spawn( group, spawn_point, param3 )
{
    random_infil = undefined;
    current_wave_ref = group scripts\cp\cp_wave_spawning::get_current_wave_ref();
    
    if ( isdefined( current_wave_ref ) )
    {
        allowed_vehicles = group scripts\cp\spawning::get_allowed_vehicle_types_from_wave();
        
        if ( istrue( group.use_only_veh_spawners ) && ( !isdefined( allowed_vehicles ) || allowed_vehicles.size < 1 ) )
        {
            return 0;
        }
        
        allowed_vehicles = spawn_point scripts\cp\spawning::get_allowed_vehicle_types_from_spawnpoint( allowed_vehicles );
        
        if ( isdefined( allowed_vehicles ) && allowed_vehicles.size > 0 )
        {
            random_infil = random( allowed_vehicles );
            
            if ( scripts\cp\spawning::has_vehicle_type_exceeded_module_cap( group, random_infil ) )
            {
                return 0;
            }
        }
    }
    else if ( isdefined( group.valid_vehicles ) && array_sum( group.valid_vehicles ) > 0 )
    {
        allowed_vehicles = group scripts\cp\spawning::get_allowed_vehicle_types_from_wave();
        allowed_vehicles = spawn_point scripts\cp\spawning::get_allowed_vehicle_types_from_spawnpoint( allowed_vehicles );
        
        if ( isdefined( allowed_vehicles ) && allowed_vehicles.size > 0 )
        {
            random_infil = random( allowed_vehicles );
            
            if ( scripts\cp\spawning::has_vehicle_type_exceeded_module_cap( group, random_infil ) )
            {
                return 0;
            }
        }
    }
    else
    {
        random_infil = get_random_available_air_ai_infil();
    }
    
    if ( isdefined( random_infil ) )
    {
        if ( scripts\cp\spawning::has_vehicle_type_exceeded_module_cap( group, random_infil ) )
        {
            return 0;
        }
        
        spawn_point.og_script_function = spawn_point.script_function;
        spawn_point.script_function = random_infil;
        
        if ( !isdefined( spawn_point.vehicle ) && isdefined( level.ai_spawn_vehicle_func[ random_infil ].vehicle_spawn_func ) )
        {
            if ( [[ level.ai_spawn_vehicle_func[ random_infil ].vehicle_spawn_func ]]( group, spawn_point, random_infil ) )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        else if ( isdefined( spawn_point.vehicle ) )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        self thread [[ level.spawner_script_funcs[ random_infil ].script_function ]]( group, spawn_point, random_infil );
        return;
    }
    
    return 0;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x3267
// Size: 0x108
function choose_random_air_vehicle_spawn( group, spawn_point, param3 )
{
    if ( isdefined( spawn_point.ai_infil_type ) )
    {
        random_infil = spawn_point.ai_infil_type;
    }
    else
    {
        random_infil = get_random_available_air_ai_infil();
    }
    
    if ( isdefined( random_infil ) )
    {
        spawn_point.og_script_function = spawn_point.script_function;
        spawn_point.script_function = random_infil;
        
        if ( !isdefined( spawn_point.vehicle ) && isdefined( level.ai_spawn_vehicle_func[ random_infil ].vehicle_spawn_func ) )
        {
            if ( [[ level.ai_spawn_vehicle_func[ random_infil ].vehicle_spawn_func ]]( group, spawn_point, random_infil ) )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        else if ( isdefined( spawn_point.vehicle ) )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        self thread [[ level.spawner_script_funcs[ random_infil ].script_function ]]( group, spawn_point, random_infil );
        thread attempt_ai_air_infil_cooldown( random_infil );
        return;
    }
    
    return 0;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x3377
// Size: 0x8d
function ai_ground_veh_spawn( module_struct, spawn_point, infil_name )
{
    if ( isdefined( spawn_point.vehicle ) )
    {
        self.vehicle = spawn_point.vehicle;
        self.vehicle thread thread_on_notify( "unloaded", &clear_kill_off_flags, self, undefined, self, self, "death" );
        thread delay_enter_vehicle( module_struct, spawn_point, spawn_point.vehicle, infil_name );
        spawn_point.vehicle thread allow_infil_after_full_or_timeout( module_struct, infil_name );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x340c
// Size: 0x7b
function function_64f6b6424352bc68( group, spawn_point, infil_name )
{
    if ( !isdefined( spawn_point.vehicle ) && isdefined( level.ai_spawn_vehicle_func[ infil_name ].vehicle_spawn_func ) )
    {
        if ( [[ level.ai_spawn_vehicle_func[ infil_name ].vehicle_spawn_func ]]( group, spawn_point, infil_name ) )
        {
            thread ai_enter_vehicle( group, spawn_point, infil_name );
        }
        
        return;
    }
    
    thread ai_enter_vehicle( group, spawn_point, infil_name );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x348f
// Size: 0x89
function ai_enter_vehicle( module_struct, spawn_point, infil_name )
{
    if ( isdefined( spawn_point.vehicle ) )
    {
        thread clear_kill_off_flags_after_unload( spawn_point.vehicle );
        thread delay_enter_vehicle( module_struct, spawn_point, spawn_point.vehicle, infil_name );
        spawn_point.vehicle thread allow_infil_after_full_or_timeout( module_struct, infil_name );
        
        if ( isdefined( spawn_point.script_demeanor ) )
        {
            scripts\cp\spawning::set_demeanor_from_unittype( spawn_point.script_demeanor );
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x3520
// Size: 0x23
function clear_kill_off_flags_after_unload( vehicle )
{
    self endon( "death" );
    clear_kill_off_flags_after_unload_wait( vehicle );
    thread clear_kill_off_flags( self );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x354b
// Size: 0x28
function clear_kill_off_flags_after_unload_wait( vehicle )
{
    self endon( "unload" );
    self endon( "death" );
    vehicle endon( "death" );
    self waittill( "forever" );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 4
// Checksum 0x0, Offset: 0x357b
// Size: 0xe8
function delay_enter_vehicle( module_struct, spawn_point, vehicle, infil_name )
{
    if ( isdefined( self.spawnpoint.pos_override_struct ) && self.spawnpoint.pos_override_struct != vehicle )
    {
        vehicle thread add_to_vehicle_queue( self );
        return;
    }
    
    thread_on_notify( "loaded", &disable_canshootinvehicle );
    self hide();
    
    if ( isdefined( spawn_point.script_demeanor ) )
    {
        scripts\cp\spawning::set_demeanor_from_unittype( spawn_point.script_demeanor );
    }
    
    forced_seat = vehicle get_valid_seats( module_struct, infil_name );
    
    if ( !isdefined( self.forced_startingposition ) && isdefined( forced_seat ) && int( forced_seat ) >= 0 )
    {
        self.forced_startingposition = forced_seat;
    }
    
    self dontinterpolate();
    vehicle thread scripts\common\vehicle_aianim::guy_enter( self );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x366b
// Size: 0x21
function disable_canshootinvehicle()
{
    self show();
    
    if ( istrue( level.vehicle_ai_can_shoot_after_reload ) )
    {
        return;
    }
    
    self.canshootinvehicle = 0;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x3694
// Size: 0x3c
function add_to_vehicle_queue( ai )
{
    self notify( "add_to_vehicle_queue" );
    self.load_queue[ self.load_queue.size ] = ai;
    ai thread_on_notify_no_endon_death( "death", &remove_from_vehicle_queue, self );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x36d8
// Size: 0x65
function remove_from_vehicle_queue( vehicle )
{
    if ( isdefined( vehicle ) && isdefined( vehicle.load_queue ) && vehicle.load_queue.size > 0 )
    {
        if ( array_contains( vehicle.load_queue, self ) )
        {
            vehicle.load_queue = array_remove( vehicle.load_queue, self );
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x3745
// Size: 0x143
function veh_ground_veh_spawn( group, spawn_point, infil_name )
{
    data_struct = level.ai_spawn_vehicle_func[ infil_name ];
    var_1317c822798f0c26 = data_struct get_vehicle_spawn_points( spawn_point );
    
    if ( var_1317c822798f0c26.size > 0 )
    {
        foreach ( veh_spawn_point in var_1317c822798f0c26 )
        {
            if ( istrue( veh_spawn_point.in_use ) )
            {
                continue;
            }
            
            vehicle = create_ai_plr_vehicle( veh_spawn_point, infil_name );
            
            if ( isdefined( vehicle ) )
            {
                vehicle init_cp_vehicle( spawn_point, group, veh_spawn_point, infil_name );
                vehicle thread veh_ping_vehicle_location_to_players();
                vehicle thread waittill_full_or_timeout( infil_name, group );
                vehicle post_spawn_vehicle_init( group, spawn_point, infil_name, veh_spawn_point );
                vehicle thread init_ground_vehicle( group, infil_name );
                
                if ( vehicle_is_ambient( infil_name ) || getdvarint( @"hash_9ba0d5f78c98373e", 0 ) )
                {
                    vehicle thread spawn_script_model_driver_and_passengers( vehicle, infil_name );
                }
                
                clear_vehicle_build_to_spawnpoint( veh_spawn_point );
                return 1;
            }
            
            clear_vehicle_build_to_spawnpoint( veh_spawn_point );
            return 0;
        }
        
        return 0;
    }
    
    return 0;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x3890
// Size: 0x2f
function veh_ping_vehicle_location_to_players()
{
    self endon( "death" );
    self endon( "unloading" );
    
    while ( true )
    {
        pinglocationenemyteams( self.origin, "axis" );
        wait 2;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 4
// Checksum 0x0, Offset: 0x38c7
// Size: 0xb5
function post_spawn_vehicle_init( group, spawn_point, infil_name, veh_spawn_point )
{
    level.ai_spawn_vehicle_func[ infil_name ].count++;
    self.load_queue = [];
    self.group = group;
    self.vehicle_skipdeathmodel = 1;
    self.veh_spawn_point = veh_spawn_point;
    spawn_point.ai_infil_type = infil_name;
    veh_spawn_point.in_use = 1;
    spawn_point.specs = level.spawner_script_funcs[ infil_name ].specs;
    spawn_point.vehicle = self;
    self.spawn_point = spawn_point;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x3984
// Size: 0x1c1
function spawn_script_model_driver_and_passengers( vehicle, infil_name )
{
    vehicle_struct = level.ai_spawn_vehicle_func[ infil_name ];
    
    if ( isdefined( vehicle_struct ) && isdefined( vehicle_struct.num_script_models ) )
    {
        fake_guys = [];
        
        for ( i = 0; i < vehicle_struct.num_script_models ; i++ )
        {
            struct = level.vehicle.templates.aianims[ vehicle.classname_mp ][ i ];
            tag = struct.sittag;
            fake_guy = vehicle scripts\cp\vehicles\vehicle_cp::spawn_script_model_at_pos( i, tag, struct.idle_anim, struct.idle, vehicle_struct.driver_models );
            fake_guys[ fake_guys.size ] = fake_guy;
            level.vehicle_ai_script_models[ level.vehicle_ai_script_models.size ] = fake_guy;
            vehicle thread cleanup_fake_ai_on_death( fake_guys );
            
            if ( i <= 1 && is_wave_gametype() )
            {
                vehicle thread script_model_pilot_kill_watch( fake_guy );
            }
        }
    }
    
    if ( isdefined( level.vehicle_builds[ infil_name ] ) && isdefined( level.vehicle_builds[ infil_name ].max_ai ) )
    {
        max_guys = int( min( level.vehicle_builds[ infil_name ].max_ai, vehicle.usedpositions.size ) );
    }
    else
    {
        max_guys = vehicle.usedpositions.size;
    }
    
    if ( vehicle.attachedguys.size >= max_guys )
    {
        vehicle notify( "spawning_done" );
        return;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x3b4d
// Size: 0x1cc
function script_model_pilot_kill_watch( var_c2f1ca305ee16808 )
{
    self endon( "death" );
    var_c2f1ca305ee16808 endon( "death" );
    
    if ( !isdefined( self ) || !isdefined( var_c2f1ca305ee16808 ) )
    {
        return;
    }
    
    health_amount = 250;
    
    while ( true )
    {
        self waittill( "damage", amount, attacker, unused, point );
        
        if ( isdefined( attacker ) && isplayer( attacker ) && isdefined( amount ) && amount > 0 && isdefined( point ) )
        {
            if ( var_c2f1ca305ee16808 tagexists( "j_head" ) )
            {
                head_pos = var_c2f1ca305ee16808 gettagorigin( "j_head" );
            }
            else
            {
                head_pos = var_c2f1ca305ee16808.origin + ( 0, 0, 50 );
            }
            
            head_pos += ( 0, 0, -20 );
            start_point = attacker geteye();
            vec_shot = vectornormalize( point - start_point );
            vec_head = vectornormalize( head_pos - start_point );
            hit_dot = vectordot( vec_shot, vec_head );
            veh_dot = vectordot( vectornormalize( anglestoforward( self.angles ) ), vectornormalize( point - self.origin ) );
            seat_pos = var_c2f1ca305ee16808.origin + ( 0, 0, 18 );
            
            if ( hit_dot > 0.99975 && veh_dot > 0.73 && point[ 2 ] > seat_pos[ 2 ] )
            {
                health_amount -= amount;
                
                if ( health_amount <= 0 )
                {
                    self notify( "death", attacker );
                }
            }
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x3d21
// Size: 0x3b
function cleanup_fake_ai_on_death( fake_guys )
{
    self waittill( "death" );
    
    if ( isdefined( fake_guys ) )
    {
        for ( i = 0; i < fake_guys.size ; i++ )
        {
            fake_guys[ i ] remove_fake_guy_from_list();
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x3d64
// Size: 0x3a
function remove_fake_guy_from_list()
{
    if ( array_contains( level.vehicle_ai_script_models, self ) )
    {
        level.vehicle_ai_script_models = array_remove( level.vehicle_ai_script_models, self );
        
        if ( isdefined( self ) )
        {
            self delete();
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x3da6
// Size: 0xc3
function get_vehicle_spawn_points( spawn_point )
{
    if ( istrue( spawn_point.veh_model_spawner ) )
    {
        return [ spawn_point ];
    }
    
    potential_structs = getstructarray( self.spawn_points, "targetname" );
    return_array = [];
    
    if ( isdefined( spawn_point.script_linkname ) )
    {
        for ( i = 0; i < potential_structs.size ; i++ )
        {
            if ( is_linked_struct( potential_structs[ i ], spawn_point ) )
            {
                return_array[ return_array.size ] = potential_structs[ i ];
            }
        }
        
        if ( return_array.size < 1 )
        {
            return array_randomize( potential_structs );
        }
        else
        {
            returned_struct = random( return_array );
            return [ returned_struct ];
        }
        
        return;
    }
    
    return array_randomize( potential_structs );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x3e71
// Size: 0x23c
function veh_heli_spawn( group, spawn_point, infil_name )
{
    data_struct = level.ai_spawn_vehicle_func[ infil_name ];
    var_1317c822798f0c26 = data_struct get_vehicle_spawn_points( spawn_point );
    
    if ( var_1317c822798f0c26.size > 0 )
    {
        foreach ( veh_spawn_point in var_1317c822798f0c26 )
        {
            if ( istrue( veh_spawn_point.in_use ) )
            {
                continue;
            }
            
            if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
            {
                thread draw_capsule( veh_spawn_point.origin, 64, 64, ( 0, 0, 0 ), ( 0, 1, 0 ), 0, 1000 );
            }
            
            copy_vehicle_build_to_spawnpoint( infil_name, veh_spawn_point );
            angle_ref = vectortoangles( spawn_point.origin - veh_spawn_point.origin );
            veh_spawn_point.angles = ( 0, angle_ref[ 1 ], 0 );
            vehicle = scripts\common\vehicle::vehicle_spawn( veh_spawn_point );
            
            if ( isdefined( vehicle ) )
            {
                vehicle init_cp_vehicle( spawn_point, group, veh_spawn_point, infil_name );
                veh_spawn_point toggle_in_use( 1 );
                
                if ( veh_spawn_point scripts\common\vehicle::ishelicopter() )
                {
                    vehicle init_helicopter( group, infil_name );
                }
                
                if ( isdefined( group ) )
                {
                    group.vehicle = vehicle;
                }
                
                vehicle.veh_spawn_point = veh_spawn_point;
                vehicle.path_gobbler = 1;
                spawn_point.specs = level.spawner_script_funcs[ infil_name ].specs;
                spawn_point.ai_infil_type = infil_name;
                vehicle thread veh_ping_vehicle_location_to_players();
                vehicle thread heli_waittill_full_or_timeout( infil_name, group );
                
                if ( vehicle_is_ambient( infil_name ) || getdvarint( @"hash_9ba0d5f78c98373e", 0 ) || is_wave_gametype() )
                {
                    vehicle thread spawn_script_model_driver_and_passengers( vehicle, infil_name );
                }
                
                clear_vehicle_build_to_spawnpoint( veh_spawn_point );
                return 1;
            }
            
            clear_vehicle_build_to_spawnpoint( veh_spawn_point );
            return 0;
        }
        
        return 0;
    }
    
    return 0;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 4
// Checksum 0x0, Offset: 0x40b5
// Size: 0xd4
function init_cp_vehicle( spawn_point, group, veh_spawn_point, infil_name )
{
    self.load_queue = [];
    self.spawn_point = spawn_point;
    self.infil_name = infil_name;
    
    if ( isdefined( group ) )
    {
        self.group = group;
        group.vehicle = self;
        group.recently_spawned_vehicle = 1;
        group thread decrement_wave_veh_count( infil_name );
    }
    
    spawn_point.vehicle = self;
    spawn_point.veh_spawn_point = veh_spawn_point;
    self.veh_spawn_point = veh_spawn_point;
    self.dontdisconnectpaths = 1;
    self setcandamage( 1 );
    scripts\cp_mp\emp_debuff::set_start_emp_callback( &scripts\cp_mp\vehicles\vehicle::vehicle_empstartcallback );
    scripts\cp_mp\emp_debuff::set_clear_emp_callback( &scripts\cp_mp\vehicles\vehicle::vehicle_empclearcallback );
    thread destroy_vehicle_if_driver_dies();
    self vehicle_turnengineon();
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x4191
// Size: 0x65
function destroy_vehicle_if_driver_dies()
{
    self endon( "death" );
    guy = watch_for_driver_spawned();
    
    if ( isdefined( guy ) && isai( guy ) )
    {
        guy.health = 500;
        guy.maxhealth = 500;
        
        if ( scripts\common\vehicle::ishelicopter() )
        {
            thread destroy_vehicle_on_pilot_death( guy );
            return;
        }
        
        thread stop_vehicle_on_pilot_death( guy );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x41fe
// Size: 0x7f
function function_fe2167fe1376f914()
{
    level endon( "game_ended" );
    self endon( "death_finished" );
    self endon( "death" );
    
    if ( getdvarint( @"hash_a474fdc25ad6ab13", 0 ) )
    {
        self waittill( "landing_found" );
        
        if ( isdefined( self.aidriver ) )
        {
            self.aidriver.invulnerable = 1;
        }
        
        self notify( "vehicle_OnDriverDeath_early" );
    }
    
    if ( isdefined( self.aidriver ) )
    {
        self.aidriver.ignoreme = 1;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x4285
// Size: 0x64
function destroy_vehicle_on_pilot_death( guy )
{
    level endon( "game_ended" );
    self endon( "death_finished" );
    self endon( "death" );
    guy endon( "unload" );
    guy waittill( "death", attacker, test, test2, test3 );
    self notify( "death", attacker );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x42f1
// Size: 0xb7
function stop_vehicle_on_pilot_death( guy )
{
    level endon( "game_ended" );
    self endon( "death" );
    guy endon( "unload" );
    guy waittill( "death", attacker, test, test2, test3 );
    self notify( "watch_for_all_passengers_dead" );
    self stoppath( 1 );
    self notify( "stop_follow_path" );
    self vehicle_setspeedimmediate( 0, 1, 1 );
    scripts\common\vehicle::vehicle_unload();
    wait 0.25;
    
    if ( isdefined( level.vehicle.var_9442d439c225c3fe ) )
    {
        if ( [[ level.vehicle.var_9442d439c225c3fe ]]( self ) )
        {
            return;
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x43b0
// Size: 0x58
function watch_for_driver_spawned()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "unloading" );
    
    while ( true )
    {
        self waittill( "guy_entered", guy, pos );
        
        if ( isdefined( guy ) )
        {
            if ( is_equal( self.driver, guy ) )
            {
                return guy;
            }
        }
    }
    
    return undefined;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x4411
// Size: 0x27
function toggle_in_use( bool )
{
    if ( istrue( bool ) )
    {
        self.in_use = bool;
        return;
    }
    
    self.in_use = undefined;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x4440
// Size: 0x2c
function clear_vehicle_build_to_spawnpoint( veh_spawn_point )
{
    veh_spawn_point.classname_mp = undefined;
    veh_spawn_point.vehicletype = undefined;
    veh_spawn_point.vehiclename = undefined;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x4474
// Size: 0xb8
function copy_vehicle_build_to_spawnpoint( infil_name, veh_spawn_point )
{
    if ( isdefined( level.vehicle_builds ) && isdefined( level.vehicle_builds[ infil_name ] ) )
    {
        data_struct = level.vehicle_builds[ infil_name ];
        
        if ( isdefined( data_struct.classname_mp ) )
        {
            veh_spawn_point.classname_mp = data_struct.classname_mp;
        }
        
        if ( isdefined( data_struct.vehicletype ) )
        {
            veh_spawn_point.vehicletype = data_struct.vehicletype;
        }
        
        if ( isdefined( data_struct.vehiclename ) )
        {
            veh_spawn_point.vehiclename = data_struct.vehiclename;
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x4534
// Size: 0x25e
function waittill_full_or_timeout( infil_name, group )
{
    self notify( "waittill_full_or_timeout" );
    self endon( "waittill_full_or_timeout" );
    self endon( "death" );
    level endon( "game_ended" );
    thread decrement_vehicles_active( infil_name, group );
    thread watch_for_all_passengers_dead( infil_name, group );
    
    if ( self vehicle_isphysveh() )
    {
        if ( getdvarint( @"hash_b77d72f69452a294", 0 ) )
        {
            self vehicle_cleardrivingstate();
        }
        
        self.veh_brake = 1;
    }
    
    self waittill( "spawning_done" );
    self.spawn_point scripts\cp\spawning::disable_spawner();
    thread_on_notify_no_endon_death( "unloading", &check_for_unloading_func, infil_name, undefined, undefined );
    
    if ( !isdefined( self.group.successful_vehicle_spawns ) )
    {
        self.group.successful_vehicle_spawns = 1;
    }
    else
    {
        self.group.successful_vehicle_spawns++;
    }
    
    self.group.vehicle = undefined;
    self.spawn_point.pos_override_struct = undefined;
    
    if ( self.load_queue.size > 0 )
    {
        thread scripts\common\vehicle::vehicle_load_ai( self.load_queue );
        ent_flag_wait( "loaded" );
    }
    else
    {
        wait 1;
    }
    
    start_path = create_vehicle_path( infil_name );
    
    if ( self vehicle_isphysveh() )
    {
        self.veh_brake = 0;
    }
    
    self notify( "ai_vehicle_pathing_started" );
    
    if ( !self vehicle_isphysveh() )
    {
        if ( isdefined( self.target ) )
        {
            start_node = getvehiclenode( self.target, "targetname" );
            self attachpath( start_node );
            self startpath();
        }
        else
        {
            self notify( "stop_vehicle_watchers" );
        }
        
        return;
    }
    
    self notify( "newpath" );
    
    if ( isdefined( self.target ) )
    {
        start_node = getvehiclenode( self.target, "targetname" );
        
        if ( isdefined( start_node ) )
        {
            self attachpath( start_node );
            self startpath();
            return;
        }
    }
    
    if ( getdvarint( @"hash_b77d72f69452a294", 0 ) && self.pathing_array.size >= 1 )
    {
        self.spawn_point.vehicle = undefined;
        vehiclefollowstructpath( self.pathing_array[ 0 ], 1 );
        return;
    }
    
    self.spawn_point.vehicle = undefined;
    thread scripts\common\vehicle_paths::getonpath();
}

// Namespace vehicles / scripts\cp\vehicles
// Params 4
// Checksum 0x0, Offset: 0x479a
// Size: 0x63
function get_duration_between_points( startpos, endpos, speed, convert )
{
    dist = distance( startpos, endpos );
    
    if ( istrue( convert ) )
    {
        dist *= 0.0568182;
    }
    
    moverate = dist / speed;
    
    if ( moverate < 0.05 )
    {
        moverate = 0.05;
    }
    
    return moverate;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x4806
// Size: 0xf3
function heli_waittill_full_or_timeout( infil_name, group )
{
    self notify( "waittill_full_or_timeout" );
    self endon( "waittill_full_or_timeout" );
    self endon( "death" );
    level endon( "game_ended" );
    thread decrement_vehicles_active( infil_name, group );
    thread heli_watch_for_fly_away( infil_name );
    self waittill( "spawning_done" );
    self.spawn_point scripts\cp\spawning::disable_spawner();
    
    if ( isdefined( group ) )
    {
        self.group.vehicle = undefined;
    }
    
    thread_on_notify_no_endon_death( "unloading", &check_for_unloading_func, infil_name, undefined, undefined );
    thread_on_notify_no_endon_death( "unloaded", &delete_nav_obstacle, undefined, undefined, undefined );
    
    if ( isdefined( self.spawn_point.heli_path_func ) )
    {
        start_path = self [[ self.spawn_point.heli_path_func ]]( infil_name );
    }
    else
    {
        start_path = create_direct_heli_path( infil_name );
    }
    
    self.spawn_point.vehicle = undefined;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x4901
// Size: 0x2a
function check_for_unloading_func( infil_name )
{
    if ( isdefined( level.unloading_func[ infil_name ] ) )
    {
        self thread [[ level.unloading_func[ infil_name ] ]]();
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x4933
// Size: 0x96
function watch_for_all_passengers_dead( infil_name, group )
{
    self notify( "watch_for_all_passengers_dead" );
    self endon( "watch_for_all_passengers_dead" );
    self endon( "death" );
    self endon( "unloading" );
    self waittill( "guy_entered" );
    self waittill( "spawning_done" );
    
    while ( true )
    {
        var_67b4a6e5752b260f = get_vehicle_riders( 1 );
        
        if ( var_67b4a6e5752b260f <= 0 )
        {
            delete_nav_obstacle();
            self notify( "all_passengers_dead" );
            self notify( "newpath" );
            self vehicle_setspeedimmediate( 0, 30, 30 );
            thread convert_remaining_to_ai( group );
            break;
        }
        
        wait 0.2;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x49d1
// Size: 0x1b8
function convert_remaining_to_ai( group, var_c02e57df860f2d41 )
{
    temp_array = self.riders;
    
    if ( isdefined( var_c02e57df860f2d41 ) )
    {
        temp_array = var_c02e57df860f2d41;
    }
    
    for ( i = 0; i < temp_array.size ; i++ )
    {
        rider = temp_array[ i ];
        
        if ( !isent( rider ) || isagent( rider ) )
        {
            continue;
        }
        
        var_78543f1a37928429 = spawnstruct();
        var_78543f1a37928429.origin = rider.origin;
        var_78543f1a37928429.angles = rider.angles;
        var_78543f1a37928429.vehicle_position = rider.vehicle_position;
        var_78543f1a37928429.specs = rider.specs;
        
        if ( isdefined( self.convoy ) )
        {
            level deposit_from_compromised_convoy_delayed( self );
        }
        
        rider remove_fake_guy_from_list();
        new_seat = var_78543f1a37928429.vehicle_position;
        var_78543f1a37928429.vehicle_position = undefined;
        var_78543f1a37928429.specs = "vehicle_ai";
        soldier = scripts\cp\spawning::function_4441d2c30537ec6b( group, var_78543f1a37928429, 0, "vehicle_ai", undefined, 1 );
        
        if ( isdefined( soldier ) )
        {
            soldier.forced_startingposition = new_seat;
            
            if ( istrue( self.stealth_enabled ) )
            {
                soldier.ignoreall = 0;
                soldier.sightmaxdistance = 2200;
                soldier thread scripts\cp\coop_stealth::run_common_functions( soldier, 1, 1, 60, 160000 );
            }
            
            thread scripts\common\vehicle_aianim::guy_enter( soldier );
        }
        
        if ( isent( rider ) )
        {
            rider delete();
        }
    }
    
    scripts\common\vehicle::vehicle_unload();
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x4b91
// Size: 0x101
function deposit_from_compromised_convoy_delayed( vehicle )
{
    level endon( "game_ended" );
    
    if ( !isdefined( vehicle.convoy ) )
    {
        return;
    }
    
    vehicle.convoy endon( "event_convoy_delete" );
    vehicle.convoy endon( "death" );
    vehicle endon( "death" );
    convoy = vehicle.convoy;
    
    if ( istrue( convoy.delayed_depositing ) )
    {
        vehicle thread deposit_from_compromised_convoy_delayed_failsafe();
        
        while ( istrue( convoy.delayed_depositing ) )
        {
            wait 0.5;
        }
        
        return;
    }
    
    maxaicount = 28;
    
    if ( getaiarray( "axis" ).size > maxaicount )
    {
        convoy.delayed_depositing = 1;
        scripts\cp\spawning::pause_group_by_group_name( "wave_spawning" );
        
        while ( getaiarray( "axis" ).size > maxaicount )
        {
            wait 0.5;
        }
        
        convoy.delayed_depositing = undefined;
        convoy notify( "delayed_depositing_undefined" );
        scripts\cp\spawning::unpause_group_by_group_name( "wave_spawning" );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x4c9a
// Size: 0x40
function deposit_from_compromised_convoy_delayed_failsafe()
{
    level endon( "game_ended" );
    self.convoy endon( "delayed_depositing_undefined" );
    self waittill( "death" );
    
    if ( isdefined( self.convoy ) )
    {
        self.convoy.delayed_depositing = undefined;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x4ce2
// Size: 0x43
function heli_watch_for_fly_away( infil_name )
{
    self notify( "heli_watch_for_fly_away" );
    self endon( "heli_watch_for_fly_away" );
    self endon( "death" );
    self waittill( "guy_entered" );
    self waittill( "spawning_done" );
    thread waittill_all_valid_ai_are_gone( infil_name );
    thread waittill_unload_complete( infil_name );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x4d2d
// Size: 0x90
function waittill_unload_complete( infil_name )
{
    self notify( "waittill_unload_complete" );
    self endon( "waittill_unload_complete" );
    self endon( "death" );
    self endon( "all_valid_passengers_are_gone" );
    self waittill( "unloaded" );
    
    if ( isdefined( self.spawn_point ) && isdefined( self.spawn_point.leaveforplayer ) )
    {
        if ( isdefined( level.heli_convertforplayerfunc ) )
        {
            [[ level.heli_convertforplayerfunc ]]( self );
        }
        
        return;
    }
    
    self notify( "newpath" );
    delete_nav_obstacle();
    thread get_to_z_and_fly_off( infil_name );
    self notify( "all_valid_passengers_are_gone" );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x4dc5
// Size: 0xdd
function waittill_all_valid_ai_are_gone( infil_name )
{
    self notify( "waittill_all_valid_ai_are_gone" );
    self endon( "waittill_all_valid_ai_are_gone" );
    self endon( "death" );
    self endon( "unloaded" );
    
    while ( true )
    {
        num_riders = get_vehicle_riders();
        var_67b4a6e5752b260f = get_vehicle_riders( 1 );
        var_f268752392ac42d1 = get_vehicle_unloadable_riders( 1 );
        
        if ( var_67b4a6e5752b260f <= 0 || var_f268752392ac42d1 <= 0 )
        {
            if ( isdefined( self.spawn_point ) && isdefined( self.spawn_point.leaveforplayer ) )
            {
                if ( isdefined( level.heli_convertforplayerfunc ) )
                {
                    [[ level.heli_convertforplayerfunc ]]( self );
                }
                
                return;
            }
            
            thread get_to_z_and_fly_off( infil_name );
            self notify( "newpath" );
            delete_nav_obstacle();
            self notify( "all_valid_passengers_are_gone" );
            break;
        }
        
        wait 0.2;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x4eaa
// Size: 0x1fb
function get_to_z_and_fly_off( infil_name, var_61bec49fd0ba66b6 )
{
    self endon( "death" );
    thread mark_remaining_as_died_poorly();
    ground_pos = getgroundposition( self.origin, 1 );
    
    if ( distancesquared( self.origin, ground_pos ) <= 2250000 )
    {
        exit_path = spawnstruct();
        exit_path.origin = ground_pos + ( 0, 0, 1500 );
        exit_path.angles = self.angles;
        exit_path.script_goalyaw = 1;
        thread scripts\common\vehicle_paths::vehicle_paths_helicopter( exit_path );
        self setneargoalnotifydist( 512 );
        waittill_any_2( "near_goal", "goal" );
    }
    
    if ( !isdefined( var_61bec49fd0ba66b6 ) )
    {
        var_61bec49fd0ba66b6 = get_best_end_point( infil_name, self.spawn_point, self.angles );
    }
    
    if ( !isdefined( var_61bec49fd0ba66b6 ) )
    {
        var_61bec49fd0ba66b6 = random( getstructarray( level.ai_spawn_vehicle_func[ infil_name ].exit_points, "targetname" ) );
    }
    
    end_point = duplicate_struct( var_61bec49fd0ba66b6 );
    forward = anglestoforward( vectortoangles( end_point.origin - self.origin ) ) * 10000;
    end_point.origin += ( forward[ 0 ], forward[ 1 ], end_point.origin[ 2 ] );
    end_point.targetname = create_unique_kvp_string();
    self.end_point = end_point;
    path_start = end_point;
    
    if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
    {
        thread draw_capsule( end_point.origin, 32, 32, ( 0, 0, 0 ), ( 1, 0, 0 ), 0, 250 );
    }
    
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter( end_point );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x50ad
// Size: 0x69
function mark_remaining_as_died_poorly()
{
    level endon( "game_ended" );
    self endon( "death" );
    wait 2;
    
    if ( isdefined( self.riders ) && self.riders.size > 0 )
    {
        for ( i = 0; i < self.riders.size ; i++ )
        {
            self.riders[ i ].never_unloaded_from_vehicle = 1;
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x511e
// Size: 0x78
function get_vehicle_riders( check_isalive )
{
    count = 0;
    
    foreach ( guy in self.riders )
    {
        if ( istrue( check_isalive ) )
        {
            if ( isalive( guy ) )
            {
                count++;
            }
            
            continue;
        }
        
        count++;
    }
    
    return count;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x519f
// Size: 0x165
function get_vehicle_unloadable_riders( check_isalive, infil_name )
{
    count = 0;
    
    if ( isdefined( self.classname_mp ) )
    {
        if ( isdefined( level.vehicle ) && isdefined( level.vehicle.templates ) && isdefined( level.vehicle.templates.aianims ) && isdefined( level.vehicle.templates.aianims[ self.classname_mp ] ) )
        {
            for ( i = 0; i < self.riders.size ; i++ )
            {
                ai = self.riders[ i ];
                
                if ( !isalive( ai ) )
                {
                    continue;
                }
                
                if ( !isai( ai ) )
                {
                    continue;
                }
                
                if ( !isdefined( ai.vehicle_position ) )
                {
                    continue;
                }
                
                if ( scripts\common\vehicle_aianim::check_unloadgroup( ai.vehicle_position ) )
                {
                    seat = level.vehicle.templates.aianims[ self.classname_mp ][ ai.vehicle_position ];
                    
                    if ( isdefined( seat.getout ) )
                    {
                        count++;
                    }
                }
            }
        }
    }
    
    return count;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x530d
// Size: 0x3c4
function create_vehicle_path( infil_name )
{
    level notify( "create_vehicle_path" );
    counter = level.next_index;
    level.next_index++;
    
    if ( isdefined( self.spawn_point.veh_model_spawner ) )
    {
        self.allow_unload_on_path = 1;
        start_point = create_path_to_delete_node( infil_name, counter );
        unload_struct = undefined;
        return start_point;
    }
    else
    {
        start_point = duplicate_struct( self.veh_spawn_point );
        add_targetname_kvps( start_point, undefined, infil_name + counter + "_start" );
        self.currentnode = start_point;
        path_created = create_simple_path( self.currentnode, self.angles, counter, infil_name, "_end_node_pathing_", ( 1, 1, 0 ) );
        
        if ( path_created )
        {
            return start_point;
        }
    }
    
    unload_struct = duplicate_struct( self.spawn_point );
    var_4769a2cad76e31f = undefined;
    
    if ( isdefined( unload_struct ) && isdefined( self.veh_spawn_point ) && isdefined( self.veh_spawn_point.script_linkto ) )
    {
        linked_structs = self.veh_spawn_point get_veh_linked_structs();
        var_b1cf71f85043aea6 = -5;
        
        foreach ( struct in linked_structs )
        {
            var_2c4faf696b6cfdca = math::get_dot( self.origin, self.angles, struct.origin );
            var_d305c3c2de1b97a = math::get_dot( self.origin, vectortoangles( unload_struct.origin - self.origin ), struct.origin );
            dot_score = var_2c4faf696b6cfdca + var_d305c3c2de1b97a;
            
            if ( dot_score > var_b1cf71f85043aea6 )
            {
                var_b1cf71f85043aea6 = dot_score;
                var_4769a2cad76e31f = struct;
            }
        }
    }
    
    if ( !isdefined( var_4769a2cad76e31f ) )
    {
        var_54acc546493f0109 = getstructarray( level.ai_spawn_vehicle_func[ infil_name ].path_start_points, "targetname" );
        
        if ( !isdefined( var_54acc546493f0109 ) || var_54acc546493f0109.size < 1 )
        {
            var_54acc546493f0109 = getstructarray( level.ai_spawn_vehicle_func[ infil_name ].path_start_points, "script_linkName" );
        }
        
        if ( !isdefined( var_54acc546493f0109 ) || var_54acc546493f0109.size < 1 )
        {
            return;
        }
        
        var_4769a2cad76e31f = getclosest( self.origin, var_54acc546493f0109 );
    }
    
    if ( !isdefined( var_4769a2cad76e31f ) )
    {
        return;
    }
    
    start_path = duplicate_struct( var_4769a2cad76e31f );
    start_path.angles = vectortoangles( start_path.origin - self.origin );
    
    if ( false )
    {
        level thread draw_line_until_endons( self.spawn_point.origin, 1, 1, 1, "create_vehicle_path" );
        level thread draw_line_until_endons( start_path.origin, 0, 1, 0, "create_vehicle_path" );
        level thread draw_line_until_endons( unload_struct.origin, 1, 1, 0, "create_vehicle_path" );
    }
    
    add_targetname_kvps( start_path, undefined, infil_name + counter + "_start" );
    create_path_from_struct_to_struct( start_path, unload_struct, counter, infil_name, "_unload_pathing_", ( 1, 1, 1 ) );
    thread_on_notify( "unloaded", &create_path_to_delete_node, infil_name, counter, self );
    thread_on_notify_no_endon_death( "death", &reset_spawn_point_targetname, self.spawn_point, undefined, self );
    self.disabled_nodes = undefined;
    return start_path;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x56da
// Size: 0x1af
function create_path_to_delete_node( infil_name, counter )
{
    start_point = self.spawn_point;
    self.currentnode = start_point;
    path_created = create_simple_path( self.currentnode, self.angles, counter, infil_name, "_end_node_pathing_", ( 1, 1, 0 ) );
    
    if ( !path_created )
    {
        var_5bda6f0ecaf2f49 = get_best_end_point( infil_name, self.currentnode );
        end_point = duplicate_struct( var_5bda6f0ecaf2f49 );
        self.path_gobbler = 1;
        self.end_point = end_point;
        
        if ( false )
        {
            level thread draw_line_until_endons( end_point.origin, 1, 0, 0, "create_vehicle_path" );
        }
        
        create_path_from_struct_to_struct( self.currentnode, end_point, counter, infil_name, "_end_node_pathing_", ( 1, 1, 0 ) );
    }
    
    if ( math::is_point_in_front( self.currentnode.origin ) || self.spawn_point.origin == self.currentnode.origin )
    {
        self.target = self.pathing_array[ 1 ].targetname;
    }
    else if ( !path_created )
    {
        self.target = self.pathing_array[ 1 ].targetname;
    }
    else
    {
        self.pathing_array = array_remove_index( self.pathing_array, 0 );
    }
    
    self.disabled_nodes = undefined;
    return self.currentnode;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 6
// Checksum 0x0, Offset: 0x5892
// Size: 0x3f4
function create_simple_path( start_struct, comp_angles, counter, infil_name, kvp_string, color )
{
    level endon( "game_ended" );
    self endon( "death" );
    found_links = 1;
    current_struct = start_struct;
    valid_dot = -0.3;
    self.pathing_array = [ start_struct ];
    
    if ( false )
    {
        level.players[ 0 ] notifyonplayercommand( "use", "+usereload" );
        level.players[ 0 ] notifyonplayercommand( "use", "+activate" );
    }
    
    if ( isdefined( current_struct.script_linkto ) )
    {
        start_point = duplicate_struct( current_struct );
        add_targetname_kvps( start_point, undefined, infil_name + counter + "_start" );
        self.currentnode = start_point;
        current_struct = self.currentnode;
    }
    
    while ( true )
    {
        if ( false )
        {
            level.players[ 0 ] waittill( "use" );
        }
        
        if ( isdefined( current_struct.script_linkto ) )
        {
            linked_structs = current_struct get_veh_linked_structs();
            potential_structs = [];
            best_dot = -1;
            best_option = undefined;
            
            if ( linked_structs.size == 1 )
            {
                potential_structs[ potential_structs.size ] = linked_structs[ 0 ];
            }
            else
            {
                for ( i = 0; i < linked_structs.size ; i++ )
                {
                    linked_struct = linked_structs[ i ];
                    
                    if ( !isdefined( best_option ) )
                    {
                        best_option = linked_struct;
                    }
                    
                    var_2c4faf696b6cfdca = math::get_dot( current_struct.origin, comp_angles, linked_struct.origin );
                    
                    if ( var_2c4faf696b6cfdca >= valid_dot )
                    {
                        potential_structs[ potential_structs.size ] = linked_struct;
                    }
                }
            }
            
            if ( potential_structs.size < 1 && isdefined( best_option ) )
            {
                potential_structs[ potential_structs.size ] = best_option;
            }
            
            if ( potential_structs.size > 0 )
            {
                selected_struct = random( potential_structs );
                selected_struct = duplicate_struct( selected_struct );
                self.path_gobbler = 1;
                self.pathing_array[ self.pathing_array.size ] = selected_struct;
                add_targetname_kvps( selected_struct, current_struct, infil_name + "_" + counter + "_simple_path_" + self.pathing_array.size );
                
                if ( false )
                {
                    level thread draw_line_until_endons( current_struct.origin, 1, 1, 1, "create_vehicle_path", selected_struct.origin );
                }
                
                current_struct = selected_struct;
            }
            else
            {
                break;
            }
            
            continue;
        }
        
        if ( isdefined( current_struct.target ) )
        {
            linked_structs = current_struct get_target_array();
            potential_structs = [];
            best_dot = -1;
            best_option = undefined;
            
            for ( i = 0; i < linked_structs.size ; i++ )
            {
                linked_struct = linked_structs[ i ];
                var_2c4faf696b6cfdca = math::get_dot( current_struct.origin, comp_angles, linked_struct.origin );
                
                if ( var_2c4faf696b6cfdca >= valid_dot )
                {
                    potential_structs[ potential_structs.size ] = linked_struct;
                    continue;
                }
                
                if ( var_2c4faf696b6cfdca >= best_dot )
                {
                    best_option = linked_structs[ i ];
                }
            }
            
            if ( potential_structs.size < 1 && isdefined( best_option ) )
            {
                potential_structs[ potential_structs.size ] = best_option;
            }
            
            if ( potential_structs.size > 0 )
            {
                selected_struct = random( potential_structs );
                
                if ( array_contains( self.pathing_array, selected_struct ) )
                {
                    self.pathing_array[ self.pathing_array.size ] = selected_struct;
                    self.looping_path = 1;
                    break;
                }
                
                self.pathing_array[ self.pathing_array.size ] = selected_struct;
                
                if ( false )
                {
                    level thread draw_line_until_endons( current_struct.origin, 1, 1, 1, "create_vehicle_path", selected_struct.origin );
                }
                
                current_struct = selected_struct;
            }
            else
            {
                break;
            }
            
            continue;
        }
        
        break;
    }
    
    if ( self.pathing_array.size > 27 )
    {
        split_large_pathing_array();
    }
    
    if ( self.pathing_array.size < 1 )
    {
        return 0;
    }
    
    return 1;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x5c8e
// Size: 0xfa
function split_large_pathing_array()
{
    self.pathing_arrays = [];
    var_2c437d6b6ebd8178 = [];
    var_51b313a230b35bce = undefined;
    
    for ( i = 0; i < self.pathing_array.size ; i++ )
    {
        var_2c437d6b6ebd8178[ var_2c437d6b6ebd8178.size ] = self.pathing_array[ i ];
        var_51b313a230b35bce = self.pathing_array[ i ];
        
        if ( i > 0 && i % 27 == 0 )
        {
            self.pathing_arrays[ self.pathing_arrays.size ] = var_2c437d6b6ebd8178;
            var_2c437d6b6ebd8178 = [];
            var_2c437d6b6ebd8178[ 0 ] = var_51b313a230b35bce;
        }
    }
    
    if ( var_2c437d6b6ebd8178.size == 1 )
    {
        newstruct = spawnstruct();
        newstruct.origin = ( var_2c437d6b6ebd8178[ 0 ].origin + var_51b313a230b35bce.origin ) / 2;
        var_2c437d6b6ebd8178[ var_2c437d6b6ebd8178.size ] = var_2c437d6b6ebd8178[ 0 ];
        var_2c437d6b6ebd8178[ 0 ] = newstruct;
    }
    
    if ( var_2c437d6b6ebd8178.size > 0 )
    {
        self.pathing_arrays[ self.pathing_arrays.size ] = var_2c437d6b6ebd8178;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 6
// Checksum 0x0, Offset: 0x5d90
// Size: 0x2f4
function create_path_from_struct_to_struct( start_struct, goal_struct, counter, infil_name, kvp_string, color )
{
    level endon( "game_ended" );
    self endon( "death" );
    last_struct = start_struct;
    last_struct.angles = self.angles;
    closest_struct = undefined;
    searching = 1;
    index = 0;
    start_struct.pathing_index = 0;
    
    if ( isdefined( self.disabled_nodes ) )
    {
        self.disabled_nodes = undefined;
    }
    
    if ( isdefined( self.pathing_array ) )
    {
        foreach ( struct in self.pathing_array )
        {
            if ( isdefined( struct ) )
            {
                struct.previous_struct = undefined;
                struct.antepenultimate_struct = undefined;
            }
        }
    }
    
    self.pathing_array = [ start_struct ];
    
    if ( false )
    {
        announcement( "Waiting for player use" );
        level.players[ 0 ] notifyonplayercommand( "use", "+usereload" );
        level.players[ 0 ] notifyonplayercommand( "use", "+activate" );
    }
    
    while ( true )
    {
        if ( false )
        {
            level.players[ 0 ] waittill( "use" );
        }
        
        last_struct = find_closest_path_struct( last_struct, goal_struct, infil_name + counter + kvp_string + index, color, infil_name );
        
        if ( isdefined( last_struct ) )
        {
            if ( !isdefined( last_struct.pathing_index ) )
            {
                last_struct.pathing_index = self.pathing_array.size;
                self.pathing_array[ self.pathing_array.size ] = last_struct;
                
                if ( false )
                {
                    if ( isdefined( last_struct.previous_struct ) )
                    {
                        level thread draw_line_until_endons( last_struct.previous_struct.origin, color[ 0 ], color[ 1 ], color[ 2 ], [ "create_vehicle_path", "kill_debug_" + last_struct.pathing_index ], last_struct.origin );
                    }
                }
            }
            
            if ( last_struct.origin == goal_struct.origin )
            {
                break;
            }
        }
        else
        {
            break;
        }
        
        if ( index > 1000 )
        {
            self notify( "no_good_path_found" );
            break;
        }
        
        index++;
    }
    
    for ( i = 0; i < self.pathing_array.size - 1 ; i++ )
    {
        self.pathing_array[ i ].target = self.pathing_array[ i + 1 ].targetname;
    }
    
    if ( self.pathing_array.size > 27 )
    {
        split_large_pathing_array();
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 5
// Checksum 0x0, Offset: 0x608c
// Size: 0x4be
function find_closest_path_struct( last_struct, goal_struct, kvp_string, color, infil_name )
{
    self notify( "find_closest_path_struct" );
    
    if ( false )
    {
        level thread drawsphere( last_struct.origin, 24, 1, ( 1, 1, 1 ) );
    }
    
    closest_struct = undefined;
    nearby_array = sortbydistance( last_struct get_veh_linked_structs(), goal_struct.origin );
    
    if ( nearby_array.size < 1 )
    {
        var_b077fdca28691bb5 = getstructarray( level.ai_spawn_vehicle_func[ infil_name ].path_start_points, "targetname" );
        
        if ( !isdefined( var_b077fdca28691bb5 ) || var_b077fdca28691bb5.size < 1 )
        {
            var_b077fdca28691bb5 = getstructarray( level.ai_spawn_vehicle_func[ infil_name ].path_start_points, "script_linkName" );
        }
        
        if ( !isdefined( var_b077fdca28691bb5 ) || var_b077fdca28691bb5.size < 1 )
        {
            return;
        }
        
        new_structs = get_array_of_closest( last_struct.origin, var_b077fdca28691bb5, [ last_struct ], 3 );
        
        foreach ( new_struct in new_structs )
        {
            nearby_array[ nearby_array.size ] = new_struct;
            nearby_array = array_combine( nearby_array, sortbydistance( new_struct get_veh_linked_structs(), new_struct.origin ) );
        }
    }
    
    sorted_paths = [];
    best_dot = -5;
    best_distance = 20000;
    backup_dot = -5;
    backup_struct = undefined;
    var_e79809bd510fbd33 = 0;
    
    foreach ( new_struct in nearby_array )
    {
        add_struct = new_struct;
        
        foreach ( saved_struct in self.pathing_array )
        {
            if ( istrue( saved_struct.disabled ) || new_struct.origin == saved_struct.origin )
            {
                add_struct = undefined;
                break;
            }
        }
        
        if ( isdefined( add_struct ) )
        {
            sorted_paths[ sorted_paths.size ] = add_struct;
        }
    }
    
    last_struct.rewinding_path = undefined;
    
    if ( sorted_paths.size > 1 )
    {
        /#
            if ( istrue( 0 ) )
            {
                print3d( self.pathing_array[ self.pathing_array.size - 1 ].origin + ( 0, 0, 65 ), "<dev string:x171>", ( 0, 1, 0 ), 1, 1, 999, 1 );
            }
        #/
        
        self.pathing_array[ self.pathing_array.size - 1 ].was_branch = 1;
    }
    
    if ( is_linked_struct( last_struct, goal_struct ) )
    {
        closest_struct = goal_struct;
    }
    else if ( sorted_paths.size > 0 )
    {
        if ( istrue( 0 ) )
        {
            foreach ( p_path in sorted_paths )
            {
                /#
                    print3d( p_path.origin - ( 0, 0, 50 ), "<dev string:x179>", ( 0.7, 0.1, 0.3 ), 1, 3, 100, 1 );
                #/
            }
        }
        
        closest_struct = calc_best_closest_struct( last_struct, goal_struct, sorted_paths );
    }
    
    if ( !isdefined( closest_struct ) && isdefined( backup_struct ) )
    {
        closest_struct = backup_struct;
    }
    
    if ( isdefined( closest_struct ) )
    {
        closest_struct.angles = vectortoangles( closest_struct.origin - last_struct.origin );
        
        if ( closest_struct.origin != goal_struct.origin )
        {
            closest_struct = duplicate_struct( closest_struct );
        }
        
        closest_struct.previous_struct = last_struct;
        
        if ( isdefined( last_struct.previous_struct ) )
        {
            closest_struct.antepenultimate_struct = last_struct.previous_struct;
        }
        
        add_targetname_kvps( closest_struct, last_struct, kvp_string );
        return closest_struct;
    }
    
    if ( !isdefined( closest_struct ) )
    {
        closest_struct = step_back_to_last_good_branch( last_struct, goal_struct );
        
        if ( isdefined( closest_struct ) )
        {
            add_targetname_kvps( closest_struct, last_struct, kvp_string );
        }
    }
    
    return closest_struct;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x6553
// Size: 0x99, Type: bool
function is_linked_struct( linked_to, link_name )
{
    if ( isdefined( linked_to.script_linkto ) && isdefined( link_name.script_linkname ) )
    {
        linknames = linked_to get_links();
        
        foreach ( linkname in linknames )
        {
            if ( link_name.script_linkname == linkname )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 6
// Checksum 0x0, Offset: 0x65f5
// Size: 0x163
function print_debug_info( struct, var_d305c3c2de1b97a, var_2c4faf696b6cfdca, comp_dist, total_score, endon_string )
{
    self endon( endon_string );
    self endon( "death" );
    branch = istrue( self.pathing_array[ self.pathing_array.size - 1 ].was_branch );
    
    while ( true )
    {
        /#
            print3d( struct.origin + ( 0, 0, 24 ), "<dev string:x180>" + comp_dist, ( 1, 1, 0 ), 1, 1, 1 );
        #/
        
        /#
            print3d( struct.origin + ( 0, 0, 36 ), "<dev string:x18b>" + var_2c4faf696b6cfdca, ( 1, 1, 1 ), 1, 1, 1 );
        #/
        
        /#
            print3d( struct.origin + ( 0, 0, 48 ), "<dev string:x19c>" + var_d305c3c2de1b97a, ( 1, 1, 1 ), 1, 1, 1 );
        #/
        
        /#
            print3d( struct.origin + ( 0, 0, 60 ), "<dev string:x1a9>" + total_score, ( 0, 1, 0 ), 1, 2, 1 );
        #/
        
        waitframe();
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x6760
// Size: 0x70
function get_veh_linked_structs()
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = get_links();
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            structs = getstructarray( linknames[ i ], "script_linkname" );
            
            if ( structs.size > 0 )
            {
                array = array_combine( array, structs );
            }
        }
    }
    
    return array;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x67d9
// Size: 0x438
function calc_best_closest_struct( last_struct, goal_struct, enabled_paths )
{
    var_c409751f6400ecc2 = 1000000;
    var_a743d2bf021f5457 = 360;
    best_score = -50;
    closest_struct = undefined;
    bonus = 0.5;
    
    for ( i = 0; i < enabled_paths.size ; i++ )
    {
        if ( enabled_paths[ i ].origin == last_struct.origin )
        {
            last_struct = last_struct.previous_struct;
        }
    }
    
    var_d31a2ee982e4801c = -5;
    var_d2d5f9260f458419 = distance( goal_struct.origin, last_struct.origin );
    
    foreach ( potential_struct in enabled_paths )
    {
        var_95a0d262b22644 = 5;
        var_26bf31ac98d0a5d4 = 5;
        var_e79809bd510fbd33 = 0;
        dot = undefined;
        score = -5;
        
        if ( potential_struct == last_struct )
        {
            continue;
        }
        
        if ( potential_struct.origin == last_struct.origin )
        {
            continue;
        }
        
        if ( isdefined( last_struct.previous_struct ) && last_struct.previous_struct.origin == potential_struct.origin )
        {
            continue;
        }
        
        if ( isdefined( last_struct.antepenultimate_struct ) && last_struct.antepenultimate_struct.origin == potential_struct.origin )
        {
            continue;
        }
        
        if ( isdefined( potential_struct.script_noteworthy ) && potential_struct.script_noteworthy == "deleteme" && potential_struct.origin != goal_struct.origin )
        {
            continue;
        }
        
        if ( !istrue( self.allow_unload_on_path ) && isdefined( potential_struct.script_unload ) && potential_struct.origin != goal_struct.origin )
        {
            continue;
        }
        
        if ( istrue( potential_struct.disabled ) )
        {
            continue;
        }
        
        if ( check_all_previous_in_pathing( potential_struct, 30 ) )
        {
            continue;
        }
        
        if ( istrue( struct_is_personally_disabled( potential_struct ) ) )
        {
            continue;
        }
        
        comp_distance = distance( last_struct.origin, potential_struct.origin );
        
        if ( potential_struct.origin == goal_struct.origin && comp_distance > 1250 )
        {
            continue;
        }
        
        comp_distance = distance( goal_struct.origin, potential_struct.origin );
        var_fb156017c7455904 = vectortoangles( goal_struct.origin - last_struct.origin );
        
        if ( !isdefined( last_struct.angles ) )
        {
            last_struct.angles = ( 0, 0, 0 );
        }
        
        var_2c4faf696b6cfdca = math::get_dot( last_struct.origin, last_struct.angles, potential_struct.origin );
        var_2c4faf696b6cfdca = math::normalize_value( -0.5, 0.8, var_2c4faf696b6cfdca );
        var_d305c3c2de1b97a = math::get_dot( last_struct.origin, var_fb156017c7455904, potential_struct.origin );
        var_d305c3c2de1b97a = math::normalize_value( -0.8, 0.8, var_d305c3c2de1b97a );
        var_ae9ece2d695c9009 = math::normalize_value( 0, 2000, comp_distance );
        var_ae9ece2d695c9009 = 1 - var_ae9ece2d695c9009;
        score = var_2c4faf696b6cfdca + var_d305c3c2de1b97a + var_ae9ece2d695c9009;
        
        if ( var_2c4faf696b6cfdca < 0.25 )
        {
            score -= 10;
        }
        
        if ( false )
        {
            thread print_debug_info( potential_struct, var_d305c3c2de1b97a, var_2c4faf696b6cfdca, comp_distance, score, "find_closest_path_struct" );
        }
        
        if ( score > best_score )
        {
            closest_struct = potential_struct;
            best_score = score;
        }
    }
    
    if ( isdefined( closest_struct ) )
    {
    }
    
    return closest_struct;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x6c1a
// Size: 0x1ce
function get_best_end_point( infil_name, unload_struct, dot_angles )
{
    if ( isdefined( unload_struct.script_linkto ) )
    {
        linkto_structs = unload_struct get_veh_linked_structs();
        
        for ( i = 0; i < linkto_structs.size ; i++ )
        {
            if ( is_equal( level.ai_spawn_vehicle_func[ infil_name ].exit_points, linkto_structs[ i ].targetname ) )
            {
                return linkto_structs[ i ];
            }
        }
    }
    
    var_2b008b868cc6c2f7 = getstructarray( level.ai_spawn_vehicle_func[ infil_name ].exit_points, "targetname" );
    best_dot = -5;
    var_14bb0bb2b7d418d7 = undefined;
    sorted_structs = get_array_of_closest( unload_struct.origin, var_2b008b868cc6c2f7, [ unload_struct ] );
    
    if ( isdefined( unload_struct.angles ) )
    {
        dot_angles = unload_struct.angles;
    }
    
    foreach ( struct in sorted_structs )
    {
        dot = math::get_dot( unload_struct.origin, dot_angles, struct.origin );
        
        if ( dot > best_dot )
        {
            if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
            {
                thread draw_capsule( struct.origin, 32, 32, ( 0, 0, 0 ), ( 1, 0, 0 ), 0, 250 );
            }
            
            best_dot = dot;
            var_14bb0bb2b7d418d7 = struct;
        }
    }
    
    return var_14bb0bb2b7d418d7;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x6df1
// Size: 0x83, Type: bool
function check_all_previous_in_pathing( potential_struct, limit )
{
    if ( !isdefined( self.pathing_array ) )
    {
        return false;
    }
    
    if ( !isdefined( limit ) )
    {
        limit = self.pathing_array.size;
    }
    
    for ( i = 0; i < limit ; i++ )
    {
        if ( isdefined( self.pathing_array[ i ] ) && self.pathing_array[ i ].origin == potential_struct.origin )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x6e7d
// Size: 0x66, Type: bool
function struct_is_personally_disabled( potential_struct )
{
    if ( !isdefined( self.disabled_nodes ) )
    {
        return false;
    }
    
    for ( k = self.disabled_nodes.size - 1; k >= 0 ; k-- )
    {
        if ( self.disabled_nodes[ k ].origin == potential_struct.origin )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x6eec
// Size: 0x266
function step_back_to_last_good_branch( last_struct, goal_struct )
{
    closest_struct = undefined;
    var_bf3b8c90fdeeb414 = undefined;
    var_df17d2e0402832da = [];
    var_f5641ed3c3b1543 = 0;
    
    for ( i = self.pathing_array.size - 1; i >= 0 ; i-- )
    {
        if ( var_f5641ed3c3b1543 > 0 )
        {
            break;
        }
        
        if ( istrue( self.pathing_array[ i ].was_branch ) )
        {
            linkedto = self.pathing_array[ i ] get_veh_linked_structs();
            
            for ( j = 0; j < linkedto.size ; j++ )
            {
                if ( is_this_a_valid_node( linkedto[ j ] ) )
                {
                    var_df17d2e0402832da[ var_df17d2e0402832da.size ] = linkedto[ j ];
                }
            }
            
            if ( var_df17d2e0402832da.size > 0 )
            {
                if ( var_df17d2e0402832da.size == 1 )
                {
                    best_struct = var_df17d2e0402832da[ 0 ];
                }
                else
                {
                    best_struct = calc_best_closest_struct( last_struct, goal_struct, var_df17d2e0402832da );
                }
                
                var_f5641ed3c3b1543 = i;
                var_bf3b8c90fdeeb414 = best_struct;
                
                /#
                    if ( istrue( 0 ) )
                    {
                        print3d( self.pathing_array[ i ].origin + ( 0, 0, -90 ), "<dev string:x1b1>" + var_df17d2e0402832da.size, ( 0, 1, 1 ), 1, 5, 999, 1 );
                        print3d( best_struct.origin + ( 0, 0, -90 ), "<dev string:x1bc>", ( 0, 1, 1 ), 1, 5, 999, 1 );
                    }
                #/
                
                break;
            }
            else
            {
                disable_this_node_for_us( self.pathing_array[ i ] );
            }
            
            continue;
        }
        
        disable_this_node_for_us( self.pathing_array[ i ] );
    }
    
    if ( isdefined( last_struct.previous_struct ) )
    {
        if ( isdefined( var_bf3b8c90fdeeb414 ) )
        {
            closest_struct = var_bf3b8c90fdeeb414;
            
            if ( isdefined( self.pathing_array[ var_f5641ed3c3b1543 - 1 ] ) )
            {
                closest_struct.previous_struct = self.pathing_array[ var_f5641ed3c3b1543 - 1 ];
            }
            
            if ( isdefined( self.pathing_array[ var_f5641ed3c3b1543 - 2 ] ) )
            {
                closest_struct.antepenultimate_struct = self.pathing_array[ var_f5641ed3c3b1543 - 2 ];
            }
        }
        else
        {
            closest_struct = self.pathing_array[ 0 ];
        }
        
        if ( isdefined( closest_struct ) )
        {
            closest_struct.rewinding_path = 1;
        }
    }
    
    if ( !isdefined( closest_struct ) )
    {
        /#
            announcement( "<dev string:x1c2>" );
        #/
    }
    
    return closest_struct;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x715b
// Size: 0xa9, Type: bool
function is_this_a_valid_node( node )
{
    if ( istrue( node.disabled ) )
    {
        return false;
    }
    
    for ( k = self.pathing_array.size - 1; k >= 0 ; k-- )
    {
        if ( self.pathing_array[ k ].origin == node.origin )
        {
            return false;
        }
    }
    
    for ( k = self.disabled_nodes.size - 1; k >= 0 ; k-- )
    {
        if ( self.disabled_nodes[ k ].origin == node.origin )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x720d
// Size: 0xc1
function disable_this_node_for_us( node )
{
    if ( !isdefined( node ) )
    {
        return;
    }
    
    if ( !isdefined( self.disabled_nodes ) )
    {
        self.disabled_nodes = [];
    }
    
    if ( array_contains( self.disabled_nodes, node ) )
    {
        return;
    }
    
    self.disabled_nodes[ self.disabled_nodes.size ] = node;
    
    if ( istrue( 0 ) )
    {
        /#
            print3d( node.origin + ( 0, 0, 15 ), "<dev string:x1db>", ( 1, 0, 0 ), 1, 5, 999, 1 );
        #/
    }
    
    level notify( "kill_debug_" + node.pathing_index );
    self.pathing_array = array_remove( self.pathing_array, node );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x72d6
// Size: 0x2d
function create_direct_heli_path( infil_name )
{
    self endon( "death" );
    path_start = create_direct_path_from_landing_point( infil_name );
    thread scripts\common\vehicle_paths::vehicle_paths_helicopter( path_start );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x730b
// Size: 0xfd
function adjust_angles_for_heli_path( linkto_path, landing_point )
{
    for ( i = 0; i < linkto_path.size ; i++ )
    {
        j = i + 1;
        
        if ( isdefined( linkto_path[ j ] ) )
        {
            angles = vectortoangles( linkto_path[ j ].origin - linkto_path[ i ].origin );
            linkto_path[ i ].angles = ( 0, angles[ 1 ], 0 );
            continue;
        }
        
        angles = vectortoangles( landing_point.origin - linkto_path[ i ].origin );
        linkto_path[ i ].angles = ( 0, angles[ 1 ], 0 );
        
        if ( !isdefined( landing_point.angles ) || landing_point.angles == ( 0, 0, 0 ) )
        {
            landing_point.angles = ( 0, angles[ 1 ], 0 );
        }
        
        break;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x7410
// Size: 0x699
function create_direct_path_from_landing_point( infil_name )
{
    new_kvp = create_unique_kvp_string();
    target_kvp = new_kvp;
    landing_point = duplicate_struct( self.spawn_point );
    landing_point.targetname = new_kvp;
    addtostructarray( "targetname", landing_point.targetname, landing_point );
    linkto_path = [];
    
    if ( isdefined( landing_point.script_linkto ) )
    {
        linkto_path = landing_point build_path_from_script_linkto( infil_name );
    }
    
    if ( linkto_path.size > 0 )
    {
        adjust_angles_for_heli_path( linkto_path, landing_point );
        new_goal_pos = self.spawn_point.origin;
        
        for ( i = 0; i < self.riders.size ; i++ )
        {
            if ( isalive( self.riders[ i ] ) && isai( self.riders[ i ] ) )
            {
                self.riders[ i ] scripts\cp\spawning::set_goal_pos( new_goal_pos );
            }
        }
        
        if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
        {
            thread draw_line_for_time( self.veh_spawn_point.origin, linkto_path[ 0 ].origin, 1, 1, 1, 60 );
        }
        
        return linkto_path[ 0 ];
    }
    
    if ( isdefined( landing_point.script_linkname ) )
    {
        path_array = [];
        potential_paths = getstructarray( level.ai_spawn_vehicle_func[ infil_name ].path_start_points, "script_linkname" );
        
        if ( !isdefined( potential_paths ) || potential_paths.size < 1 )
        {
            potential_paths = getstructarray( level.ai_spawn_vehicle_func[ infil_name ].path_start_points, "targetname" );
        }
        
        if ( !isdefined( potential_paths ) || potential_paths.size < 1 )
        {
            return;
        }
        
        linkname = landing_point.script_linkname;
        
        for ( i = 0; i < potential_paths.size ; i++ )
        {
            if ( is_equal( potential_paths[ i ].script_linkto, linkname ) )
            {
                temp_array = [];
                new_struct = duplicate_struct( potential_paths[ i ] );
                new_struct.target = target_kvp;
                addtostructarray( "target", target_kvp, new_struct );
                new_struct.targetname = create_unique_kvp_string();
                addtostructarray( "targetname", new_struct.targetname, new_struct );
                temp_array = new_struct get_linkto_structs_return_to_array( temp_array, potential_paths );
                
                if ( temp_array.size > 0 )
                {
                    path_array[ path_array.size ] = temp_array;
                }
            }
        }
        
        if ( path_array.size > 0 )
        {
            return_array = [];
            
            for ( i = 0; i < path_array.size ; i++ )
            {
                thread cleanup_unused_paths( path_array[ i ], path_array[ i ][ path_array[ i ].size - 1 ] );
                return_array[ return_array.size ] = path_array[ i ][ path_array[ i ].size - 1 ];
                
                if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
                {
                    thread draw_capsule( path_array[ i ][ path_array[ i ].size - 1 ].origin, 32, 32, ( 0, 0, 0 ), ( 1, 0, 0 ), 0, 250 );
                }
            }
            
            mid_point = math::get_mid_point( landing_point.origin, self.origin );
            
            if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
            {
                thread draw_capsule( self.origin, 32, 32, ( 0, 0, 0 ), ( 0, 1, 0 ), 0, 250 );
                thread draw_capsule( self.spawn_point.origin, 32, 32, ( 0, 0, 0 ), ( 0, 1, 0 ), 0, 250 );
                thread draw_capsule( mid_point, 32, 32, ( 0, 0, 0 ), ( 1, 1, 0 ), 0, 250 );
            }
            
            var_4769a2cad76e31f = getclosest( mid_point, return_array );
            
            if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
            {
                thread draw_line_for_time( var_4769a2cad76e31f.origin, self.origin, 1, 0, 0, 10 );
            }
            
            if ( isdefined( var_4769a2cad76e31f.target ) )
            {
                target_array = var_4769a2cad76e31f get_target_array();
                
                for ( i = 0; i < target_array.size ; i++ )
                {
                    if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
                    {
                        thread draw_line_for_time( var_4769a2cad76e31f.origin, target_array[ i ].origin, 1, 0, 0, 12.5 );
                        thread draw_capsule( target_array[ i ].origin, 32, 32, ( 0, 0, 0 ), ( 0, 1, 1 ), 0, 250 );
                    }
                    
                    if ( i >= target_array.size - 1 )
                    {
                        if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
                        {
                            thread draw_line_for_time( landing_point.origin, target_array[ i ].origin, 1, 0, 0, 12.5 );
                        }
                    }
                }
            }
            
            if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
            {
                thread draw_capsule( var_4769a2cad76e31f.origin, 32, 32, ( 0, 0, 0 ), ( 0, 1, 1 ), 0, 250 );
            }
            
            var_4769a2cad76e31f notify( "path_chosen" );
            self notify( "path_chosen" );
            return var_4769a2cad76e31f;
        }
        else
        {
            path_array = [];
            var_4769a2cad76e31f = create_entrance_points( landing_point );
            
            if ( isdefined( var_4769a2cad76e31f ) )
            {
                var_4769a2cad76e31f.target = target_kvp;
                addtostructarray( "target", target_kvp, var_4769a2cad76e31f );
                var_4769a2cad76e31f.targetname = create_unique_kvp_string();
                addtostructarray( "targetname", var_4769a2cad76e31f.targetname, var_4769a2cad76e31f );
                
                if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
                {
                    thread draw_capsule( var_4769a2cad76e31f.origin, 32, 32, ( 0, 0, 0 ), ( 0, 1, 1 ), 0, 250 );
                    thread draw_capsule( landing_point.origin, 32, 32, ( 0, 0, 0 ), ( 0, 1, 0 ), 0, 250 );
                }
                
                return var_4769a2cad76e31f;
            }
            else
            {
                return landing_point;
            }
        }
        
        return;
    }
    
    return landing_point;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x7ab1
// Size: 0x36
function allow_deleteme_on_path( infil_name )
{
    if ( isdefined( level.vehicle_builds[ infil_name ] ) )
    {
        return istrue( level.vehicle_builds[ infil_name ].allow_deleteme_path );
    }
    
    return 0;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x7aef
// Size: 0x228
function build_path_from_script_linkto( infil_name )
{
    linkto_path = [];
    links = get_links();
    last_struct = undefined;
    
    for ( i = 0; i < links.size ; i++ )
    {
        linkto_string = links[ i ];
        linkto_structs = getstructarray( linkto_string, "script_linkname" );
        
        if ( isdefined( linkto_structs ) && linkto_structs.size > 0 )
        {
            linkto_structs = array_randomize( linkto_structs );
            
            for ( j = 0; j < linkto_structs.size ; j++ )
            {
                linkto_struct = linkto_structs[ j ];
                
                if ( is_equal( linkto_struct.targetname, "heli_spawner" ) )
                {
                    continue;
                }
                
                if ( !allow_deleteme_on_path( infil_name ) )
                {
                    if ( is_equal( linkto_struct.script_noteworthy, "deleteme" ) )
                    {
                        continue;
                    }
                }
                
                linkto_struct = duplicate_struct( linkto_struct );
                linkto_path[ linkto_path.size ] = linkto_struct;
                linkto_struct.targetname = create_unique_kvp_string();
                addtostructarray( "targetname", linkto_struct.targetname, linkto_struct );
                
                if ( isdefined( last_struct ) )
                {
                    if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
                    {
                        thread draw_line_for_time( last_struct.origin, linkto_struct.origin, 1, 1, 1, 60 );
                    }
                    
                    last_struct.target = linkto_struct.targetname;
                    addtostructarray( "target", last_struct.target, last_struct );
                }
                
                last_struct = linkto_struct;
                break;
            }
        }
    }
    
    if ( linkto_path.size > 0 )
    {
        linkto_path[ linkto_path.size - 1 ].target = self.targetname;
        addtostructarray( "target", linkto_path[ linkto_path.size - 1 ].target, linkto_path[ linkto_path.size - 1 ] );
        
        if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
        {
            thread draw_line_for_time( linkto_path[ linkto_path.size - 1 ].origin, self.origin, 1, 1, 1, 60 );
        }
    }
    
    return linkto_path;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x7d20
// Size: 0x3fc
function create_entrance_points( landing_point )
{
    var_e2c3188febed52f5 = [];
    start_pos = landing_point.origin;
    
    if ( scripts\engine\trace::capsule_trace_passed( start_pos + ( 1500, 0, 1500 ), start_pos, 256, 512, ( 0, 0, 0 ), level.characters ) )
    {
        struct = spawnstruct();
        struct.origin = start_pos + ( 1500, 0, 1500 );
        var_e2c3188febed52f5[ var_e2c3188febed52f5.size ] = struct;
    }
    
    if ( scripts\engine\trace::capsule_trace_passed( start_pos + ( -1500, 0, 1500 ), start_pos, 256, 512, ( 0, 0, 0 ), level.characters ) )
    {
        struct = spawnstruct();
        struct.origin = start_pos + ( -1500, 0, 1500 );
        var_e2c3188febed52f5[ var_e2c3188febed52f5.size ] = struct;
    }
    
    if ( scripts\engine\trace::capsule_trace_passed( start_pos + ( 0, -1500, 1500 ), start_pos, 256, 512, ( 0, 0, 0 ), level.characters ) )
    {
        struct = spawnstruct();
        struct.origin = start_pos + ( 0, -1500, 1500 );
        var_e2c3188febed52f5[ var_e2c3188febed52f5.size ] = struct;
    }
    
    if ( scripts\engine\trace::capsule_trace_passed( start_pos + ( 0, 1500, 1500 ), start_pos, 256, 512, ( 0, 0, 0 ), level.characters ) )
    {
        struct = spawnstruct();
        struct.origin = start_pos + ( 0, 1500, 1500 );
        var_e2c3188febed52f5[ var_e2c3188febed52f5.size ] = struct;
    }
    
    if ( scripts\engine\trace::capsule_trace_passed( start_pos + ( -1500, 1500, 1500 ), start_pos, 256, 512, ( 0, 0, 0 ), level.characters ) )
    {
        struct = spawnstruct();
        struct.origin = start_pos + ( -1500, 1500, 1500 );
        var_e2c3188febed52f5[ var_e2c3188febed52f5.size ] = struct;
    }
    
    if ( scripts\engine\trace::capsule_trace_passed( start_pos + ( -1500, -1500, 1500 ), start_pos, 256, 512, ( 0, 0, 0 ), level.characters ) )
    {
        struct = spawnstruct();
        struct.origin = start_pos + ( -1500, -1500, 1500 );
        var_e2c3188febed52f5[ var_e2c3188febed52f5.size ] = struct;
    }
    
    if ( scripts\engine\trace::capsule_trace_passed( start_pos + ( 1500, -1500, 1500 ), start_pos, 256, 512, ( 0, 0, 0 ), level.characters ) )
    {
        struct = spawnstruct();
        struct.origin = start_pos + ( 1500, -1500, 1500 );
        var_e2c3188febed52f5[ var_e2c3188febed52f5.size ] = struct;
    }
    
    if ( scripts\engine\trace::capsule_trace_passed( start_pos + ( 1500, 1500, 1500 ), start_pos, 256, 512, ( 0, 0, 0 ), level.characters ) )
    {
        struct = spawnstruct();
        struct.origin = start_pos + ( 1500, 1500, 1500 );
        var_e2c3188febed52f5[ var_e2c3188febed52f5.size ] = struct;
    }
    
    mid_point = math::get_mid_point( landing_point.origin, self.origin );
    
    if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
    {
        thread draw_capsule( mid_point, 32, 32, ( 0, 0, 0 ), ( 1, 1, 0 ), 0, 250 );
    }
    
    var_4769a2cad76e31f = getclosest( mid_point, var_e2c3188febed52f5 );
    
    for ( i = 0; i < var_e2c3188febed52f5.size ; i++ )
    {
        if ( var_e2c3188febed52f5[ i ] != var_4769a2cad76e31f )
        {
            if ( getdvarint( @"hash_610414ecdfe9549f", 0 ) )
            {
                thread draw_capsule( var_e2c3188febed52f5[ i ].origin, 32, 32, ( 0, 0, 0 ), ( 1, 0, 0 ), 0, 250 );
            }
        }
    }
    
    return var_4769a2cad76e31f;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x8125
// Size: 0x104
function get_linkto_structs_return_to_array( var_57d82443e81dbd5a, struct_array )
{
    var_57d82443e81dbd5a[ var_57d82443e81dbd5a.size ] = self;
    
    if ( isdefined( self.script_linkname ) )
    {
        linkname = self.script_linkname;
        
        for ( i = 0; i < struct_array.size ; i++ )
        {
            if ( struct_array[ i ].origin == self.origin )
            {
                continue;
            }
            
            if ( is_equal( struct_array[ i ].script_linkto, linkname ) )
            {
                next_struct = duplicate_struct( struct_array[ i ] );
                next_struct.target = self.targetname;
                addtostructarray( "target", next_struct.target, next_struct );
                next_struct.targetname = create_unique_kvp_string();
                addtostructarray( "targetname", next_struct.targetname, next_struct );
                var_57d82443e81dbd5a[ var_57d82443e81dbd5a.size ] = next_struct;
                var_57d82443e81dbd5a = next_struct get_linkto_structs_return_to_array( var_57d82443e81dbd5a, struct_array );
            }
        }
    }
    
    return var_57d82443e81dbd5a;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x8232
// Size: 0x45
function cleanup_unused_paths( path_array, var_4769a2cad76e31f )
{
    var_4769a2cad76e31f endon( "path_chosen" );
    self waittill( "path_chosen" );
    
    for ( i = 0; i < path_array.size ; i++ )
    {
        deletestruct_ref( path_array[ i ] );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x827f
// Size: 0xa7
function create_heli_path( infil_name )
{
    self.veh_path = [];
    counter = level.next_index;
    level.next_index++;
    var_5bda6f0ecaf2f49 = random( getstructarray( level.ai_spawn_vehicle_func[ infil_name ].exit_points, "targetname" ) );
    end_point = duplicate_struct( var_5bda6f0ecaf2f49 );
    self.end_point = end_point;
    thread begin_searching_for_landing_loc( undefined, infil_name, counter );
    thread_on_notify_no_endon_death( "death", &reset_spawn_point_targetname, self.spawn_point, undefined, self );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x832e
// Size: 0x635
function begin_searching_for_landing_loc( start_path, infil_name, counter )
{
    level endon( "game_ended" );
    self endon( "death" );
    self notify( "begin_searching_for_landing_loc" );
    self endon( "begin_searching_for_landing_loc" );
    self endon( "all_passengers_dead" );
    var_b1b8b417f4009bfd = undefined;
    landing_point = undefined;
    exit_path = undefined;
    last_point = undefined;
    
    while ( true )
    {
        valid_players = get_array_of_valid_players();
        
        if ( !valid_players.size )
        {
            wait 1;
            continue;
        }
        
        point = get_center_point_of_array( valid_players );
        
        if ( !isdefined( point ) )
        {
            point = self.origin;
        }
        
        if ( isdefined( self.spawn_point ) )
        {
            if ( isdefined( self.spawn_point ) )
            {
            }
            
            var_8a69b1ccdc99bf9a = [ self.spawn_point ];
        }
        else
        {
            var_8a69b1ccdc99bf9a = sortbydistance( level.valid_air_vehicle_spawn_points, point );
        }
        
        var_b1b8b417f4009bfd = undefined;
        search_radius = 2048;
        
        for ( i = 0; i < var_8a69b1ccdc99bf9a.size ; i++ )
        {
            landing_spot = var_8a69b1ccdc99bf9a[ i ];
            
            if ( isdefined( landing_spot.radius ) && landing_spot.radius > search_radius )
            {
                search_radius = int( landing_spot.radius );
            }
            
            if ( distance2dsquared( landing_spot.origin, point ) <= search_radius * search_radius )
            {
                var_b1b8b417f4009bfd = landing_spot;
                break;
            }
        }
        
        if ( isdefined( var_b1b8b417f4009bfd ) )
        {
            search_radius = 2048;
            
            if ( isdefined( var_b1b8b417f4009bfd.radius ) && var_b1b8b417f4009bfd.radius > search_radius )
            {
                search_radius = int( var_b1b8b417f4009bfd.radius );
            }
            
            if ( distance2dsquared( var_b1b8b417f4009bfd.origin, self.origin ) <= search_radius * search_radius )
            {
                level.valid_air_vehicle_spawn_points = array_remove( level.valid_air_vehicle_spawn_points, var_b1b8b417f4009bfd );
                landing_point = duplicate_struct( var_b1b8b417f4009bfd );
                
                if ( !isdefined( var_b1b8b417f4009bfd.script_noteworthy ) )
                {
                    landing_point.targetname = "arrived_at_node_" + counter;
                }
                else
                {
                    landing_point.targetname = var_b1b8b417f4009bfd.script_noteworthy;
                }
                
                thread scripts\common\vehicle_paths::vehicle_paths_helicopter( landing_point );
                self.landing_spot = landing_point;
                nav_box = ( 150, 150, 150 );
                
                if ( infil_name == "lbravo_ai_infil" )
                {
                    nav_box = ( 90, 90, 90 );
                }
                
                self.nav_obstacle = createnavobstaclebybounds( landing_point.origin, nav_box, ( 0, 0, 0 ), "axis" );
                thread delete_nav_obstacle_on_death();
                break;
            }
            else
            {
                var_5c3edfd13b3c67f0 = array_remove_array( level.path_points[ infil_name ], level.invalid_path_points );
                
                if ( isdefined( last_point ) )
                {
                    var_5c3edfd13b3c67f0 = array_remove( level.path_points[ infil_name ], last_point );
                }
                
                var_cd529f062f8821f0 = get_best_hover_point( point, var_5c3edfd13b3c67f0 );
                
                if ( isdefined( var_cd529f062f8821f0 ) )
                {
                    hover_point = duplicate_struct( var_cd529f062f8821f0 );
                    
                    if ( !isdefined( var_cd529f062f8821f0.script_noteworthy ) )
                    {
                        hover_point.script_noteworthy = "arrived_at_node_" + counter;
                    }
                    else
                    {
                        hover_point.script_noteworthy = var_cd529f062f8821f0.script_noteworthy;
                    }
                    
                    hover_point.radius = 512;
                    
                    if ( !isdefined( last_point ) || var_cd529f062f8821f0 != last_point )
                    {
                        thread scripts\common\vehicle_paths::vehicle_paths_helicopter( hover_point );
                    }
                    
                    last_point = var_cd529f062f8821f0;
                    level.invalid_path_points[ level.invalid_path_points.size ] = var_cd529f062f8821f0;
                    result = waittill_any_timeout_1( 2.5, hover_point.script_noteworthy );
                    
                    if ( result == "timeout" )
                    {
                        last_point = undefined;
                    }
                    
                    deletestruct_ref( hover_point );
                    level.invalid_path_points = array_remove( level.invalid_path_points, var_cd529f062f8821f0 );
                }
                else
                {
                    wait 1;
                }
            }
            
            continue;
        }
        
        var_5c3edfd13b3c67f0 = array_remove_array( level.path_points[ infil_name ], level.invalid_path_points );
        
        if ( isdefined( last_point ) )
        {
            var_5c3edfd13b3c67f0 = array_remove( level.path_points[ infil_name ], last_point );
        }
        
        var_cd529f062f8821f0 = get_best_hover_point( point, var_5c3edfd13b3c67f0 );
        
        if ( isdefined( var_cd529f062f8821f0 ) )
        {
            hover_point = duplicate_struct( var_cd529f062f8821f0 );
            
            if ( !isdefined( var_cd529f062f8821f0.script_noteworthy ) )
            {
                hover_point.script_noteworthy = "arrived_at_node_" + counter;
            }
            else
            {
                hover_point.script_noteworthy = var_cd529f062f8821f0.script_noteworthy;
            }
            
            hover_point.radius = 512;
            
            if ( !isdefined( last_point ) || var_cd529f062f8821f0 != last_point )
            {
                thread scripts\common\vehicle_paths::vehicle_paths_helicopter( hover_point );
            }
            
            last_point = var_cd529f062f8821f0;
            level.invalid_path_points[ level.invalid_path_points.size ] = var_cd529f062f8821f0;
            result = waittill_any_timeout_1( 2.5, hover_point.script_noteworthy );
            
            if ( result == "timeout" )
            {
                last_point = undefined;
            }
            
            deletestruct_ref( hover_point );
            level.invalid_path_points = array_remove( level.invalid_path_points, var_cd529f062f8821f0 );
            continue;
        }
        
        wait 1;
    }
    
    self waittill( "unloaded" );
    
    if ( !array_contains( level.valid_air_vehicle_spawn_points, var_b1b8b417f4009bfd ) )
    {
        level.valid_air_vehicle_spawn_points[ level.valid_air_vehicle_spawn_points.size ] = var_b1b8b417f4009bfd;
    }
    
    if ( isdefined( landing_point ) )
    {
        exit_path = get_exit_route( landing_point, infil_name + counter + "_start" );
    }
    
    var_5bda6f0ecaf2f49 = random( getstructarray( level.ai_spawn_vehicle_func[ infil_name ].exit_points, "targetname" ) );
    end_point = duplicate_struct( var_5bda6f0ecaf2f49 );
    
    if ( isdefined( landing_point ) && isdefined( exit_path ) && exit_path != landing_point )
    {
        add_targetname_kvps( exit_path, landing_point, infil_name + counter + "_exit_path" );
        add_targetname_kvps( end_point, exit_path, infil_name + counter + "_end" );
        thread scripts\common\vehicle_paths::vehicle_paths_helicopter( exit_path );
    }
    else
    {
        add_targetname_kvps( end_point, landing_point, infil_name + counter + "_end" );
        thread scripts\common\vehicle_paths::vehicle_paths_helicopter( end_point );
    }
    
    delete_nav_obstacle();
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x896b
// Size: 0x1a
function create_unique_kvp_string()
{
    targetname_index = get_next_free_num();
    return "unique_KVP_" + targetname_index;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x898e
// Size: 0x21
function get_next_free_num()
{
    counter = level.next_index;
    level.next_index++;
    return counter;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x89b8
// Size: 0xb0
function get_best_hover_point( point, var_5c3edfd13b3c67f0 )
{
    var_5c3edfd13b3c67f0 = sortbydistance( var_5c3edfd13b3c67f0, point );
    best_dot = -5;
    best_point = undefined;
    
    foreach ( path_point in var_5c3edfd13b3c67f0 )
    {
        dot = math::get_dot( self.origin, self.angles, path_point.origin );
        
        if ( dot > 0 )
        {
            return path_point;
        }
    }
    
    return best_point;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x8a71
// Size: 0x86
function get_exit_route( starting_struct, kvp_string )
{
    current_struct = starting_struct;
    
    if ( isdefined( current_struct.script_linkto ) )
    {
        for ( counter = 0; isdefined( current_struct.script_linkto ) ; counter++ )
        {
            exit_path = random( current_struct get_veh_linked_structs() );
            exit_path = duplicate_struct( exit_path );
            add_targetname_kvps( exit_path, starting_struct, kvp_string + "_exit_route_" + counter );
            current_struct = exit_path;
        }
    }
    
    return current_struct;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x8b00
// Size: 0xa1
function add_targetname_kvps( targetstruct, var_8862e77985bbe111, string_add )
{
    if ( isdefined( targetstruct ) )
    {
        targetstruct.targetname = string_add;
        addtostructarray( "targetname", string_add, targetstruct );
        
        if ( isdefined( self.veh_path ) )
        {
            self.veh_path[ self.veh_path.size ] = targetstruct;
        }
    }
    
    if ( isdefined( var_8862e77985bbe111 ) )
    {
        var_8862e77985bbe111.target = string_add;
        addtostructarray( "target", string_add, var_8862e77985bbe111 );
        
        if ( isdefined( self.veh_path ) )
        {
            self.veh_path[ self.veh_path.size ] = var_8862e77985bbe111;
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x8ba9
// Size: 0x26f
function duplicate_struct( original_struct )
{
    struct = spawnstruct();
    struct.path_gobbler = 1;
    struct.origin = original_struct.origin;
    
    if ( isdefined( original_struct.angles ) )
    {
        struct.angles = original_struct.angles;
    }
    else
    {
        struct.angles = ( 0, 0, 0 );
    }
    
    if ( isdefined( original_struct.script_unload ) )
    {
        struct.script_unload = original_struct.script_unload;
    }
    
    if ( isdefined( original_struct.lookahead ) )
    {
        struct.lookahead = original_struct.lookahead;
    }
    
    if ( isdefined( original_struct.speed ) )
    {
        struct.speed = original_struct.speed;
    }
    else
    {
        struct.speed = 2000;
    }
    
    if ( isdefined( original_struct.start_node ) )
    {
        struct.start_node = original_struct.start_node;
    }
    
    if ( isdefined( original_struct.script_noteworthy ) )
    {
        struct.script_noteworthy = original_struct.script_noteworthy;
    }
    
    if ( isdefined( original_struct.script_linkname ) )
    {
        struct.script_linkname = original_struct.script_linkname;
    }
    
    if ( isdefined( original_struct.script_linkto ) )
    {
        struct.script_linkto = original_struct.script_linkto;
    }
    
    if ( isdefined( original_struct.script_brake ) )
    {
        struct.script_brake = original_struct.script_brake;
    }
    
    if ( isdefined( original_struct.script_pathtype ) )
    {
        struct.script_pathtype = original_struct.script_pathtype;
    }
    
    if ( isdefined( original_struct.script_goalyaw ) )
    {
        struct.script_goalyaw = original_struct.script_goalyaw;
    }
    
    if ( isdefined( original_struct.script_anglevehicle ) )
    {
        struct.script_anglevehicle = original_struct.script_anglevehicle;
    }
    
    if ( isdefined( original_struct.radius ) )
    {
        struct.radius = original_struct.radius;
    }
    else
    {
        struct.radius = 512;
    }
    
    return struct;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x8e21
// Size: 0x3b
function delete_nav_obstacle()
{
    if ( isdefined( self.nav_obstacle ) )
    {
        destroynavobstacle( self.nav_obstacle );
    }
    
    if ( isdefined( self.spawn_point ) )
    {
        self.spawn_point scripts\cp\spawning::function_ec648f2c89ea1c91();
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 4
// Checksum 0x0, Offset: 0x8e64
// Size: 0xac
function activate_vehicle_spawner( veh_spawn_point, spawn_point, vehicle, group )
{
    if ( isdefined( group ) )
    {
        group.recently_spawned_vehicle = undefined;
    }
    
    enable_spawners = 1;
    
    if ( isdefined( vehicle ) )
    {
        if ( vehicle get_vehicle_riders() < 1 )
        {
            enable_spawners = 0;
        }
    }
    
    if ( isdefined( veh_spawn_point ) )
    {
        veh_spawn_point toggle_in_use( 0 );
    }
    
    if ( isdefined( spawn_point ) )
    {
        if ( enable_spawners )
        {
            spawn_point scripts\cp\spawning::enable_spawner();
        }
        else if ( isdefined( vehicle ) )
        {
            vehicle enable_spawner_after_vehicle_death( spawn_point );
        }
    }
    
    reset_spawn_point_targetname( spawn_point );
    
    if ( isdefined( vehicle ) )
    {
        if ( isdefined( vehicle.veh_spawn_point ) )
        {
            vehicle.veh_spawn_point = undefined;
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x8f18
// Size: 0x1b
function enable_spawner_after_vehicle_death( spawn_point )
{
    self waittill( "death" );
    spawn_point scripts\cp\spawning::enable_spawner();
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0x8f3b
// Size: 0x11
function delete_nav_obstacle_on_death()
{
    self waittill( "death" );
    delete_nav_obstacle();
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x8f54
// Size: 0x175
function decrement_vehicles_active( infil_name, group )
{
    self notify( "decrement_vehicles_active" );
    self endon( "decrement_vehicles_active" );
    level endon( "game_ended" );
    veh_spawn_point = self.veh_spawn_point;
    spawn_point = self.spawn_point;
    result = waittill_any_return_2( "death", "unloaded" );
    level delaythread( 5, &activate_vehicle_spawner, veh_spawn_point, spawn_point, self, group );
    level.all_spawned_vehicles = array_remove( level.all_spawned_vehicles, self );
    level.ai_spawn_vehicle_func[ infil_name ].count--;
    
    if ( isdefined( self.veh_spawn_point ) && isdefined( self.veh_spawn_point.script_vehiclegroup ) )
    {
        target_array = getstructarray( self.veh_spawn_point.script_vehiclegroup, "targetname" );
        
        foreach ( other_struct in target_array )
        {
            other_struct.disabled = undefined;
        }
    }
    
    if ( isdefined( self.veh_spawn_point ) )
    {
        self.veh_spawn_point.in_use = undefined;
    }
    
    self.veh_spawn_point = undefined;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x90d1
// Size: 0xa9
function reset_spawn_point_targetname( spawn_point )
{
    if ( !isdefined( spawn_point ) && isdefined( self.spawn_point ) )
    {
        spawn_point = self.spawn_point;
    }
    
    if ( isdefined( spawn_point ) )
    {
        spawn_point.ai_infil_type = undefined;
        
        if ( isdefined( spawn_point.og_script_function ) )
        {
            spawn_point.script_function = spawn_point.og_script_function;
        }
        
        spawn_point = undefined;
    }
    
    if ( isdefined( self ) && isdefined( self.veh_path ) )
    {
        deletestructarray_ref( self.veh_path );
    }
    
    if ( isdefined( self ) && isdefined( self.pathing_array ) )
    {
        deletestructarray_ref( self.pathing_array );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x9182
// Size: 0x131
function clear_kill_off_flags( guy )
{
    if ( istrue( guy.skip_clear_kill_off_flag ) )
    {
        return;
    }
    
    guy.killofftime = gettime() + 20000;
    guy.dontkilloff = undefined;
    guy.canshootinvehicle = 1;
    guy.ignoreall = 0;
    
    if ( isdefined( guy.vehicle ) && isdefined( guy.vehicle.landing_spot ) )
    {
        guy scripts\cp\spawning::node_fields_pre_goal( guy.vehicle.landing_spot );
    }
    
    if ( isdefined( guy.demeanoroverride ) && guy.demeanoroverride == "casual" )
    {
        guy scripts\cp\spawning::set_demeanor_from_unittype( "patrol" );
        guy scripts\cp\spawning::set_goal_pos( guy.origin );
        guy thread scripts\cp\spawning::start_patrol();
        return;
    }
    
    guy scripts\cp\spawning::set_goal_pos( guy.origin );
    closest_player = guy get_closest_living_player();
    
    if ( isdefined( closest_player ) )
    {
        guy scripts\cp\spawning::set_goal_pos( closest_player.origin );
    }
    
    guy scripts\cp\spawning::enter_combat();
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x92bb
// Size: 0x53
function get_invalid_seats_from_module_struct( module_struct, infil_name )
{
    if ( isdefined( module_struct ) && isdefined( infil_name ) )
    {
        if ( !isdefined( module_struct.vehicle_invalid_seats ) )
        {
            return;
        }
        
        if ( !isdefined( module_struct.vehicle_invalid_seats[ infil_name ] ) )
        {
            return;
        }
        
        return module_struct.vehicle_invalid_seats[ infil_name ];
    }
    
    return undefined;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x9316
// Size: 0xa7
function get_valid_seats( module_struct, infil_name )
{
    if ( isdefined( module_struct ) && isdefined( infil_name ) )
    {
        invalid_seats = get_invalid_seats_from_module_struct( module_struct, infil_name );
        
        if ( !isdefined( invalid_seats ) )
        {
            invalid_seats = [];
        }
        
        for ( i = 0; i < self.usedpositions.size ; i++ )
        {
            if ( self.usedpositions[ i ] )
            {
                continue;
            }
            
            found_seat = 1;
            
            for ( j = 0; j < invalid_seats.size ; j++ )
            {
                if ( invalid_seats[ j ] == i )
                {
                    found_seat = 0;
                    break;
                }
            }
            
            if ( found_seat )
            {
                return i;
            }
        }
    }
    
    return -1;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0x93c6
// Size: 0x76
function send_notify_after_player_tac_vis( var_ff5ccede2521cb13 )
{
    if ( isdefined( var_ff5ccede2521cb13 ) )
    {
        return;
    }
    
    while ( true )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( hastacvis( level.players[ i ] geteye(), self.origin + ( 0, 0, 56 ) ) )
            {
                break;
            }
        }
        
        wait 0.1;
    }
    
    self notify( var_ff5ccede2521cb13 );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x9444
// Size: 0x161
function allow_infil_after_full_or_timeout( module_struct, infil_name )
{
    self notify( "allow_infil_after_full_or_timeout" );
    self endon( "allow_infil_after_full_or_timeout" );
    self endon( "death" );
    self endon( "spawning_done" );
    level endon( "game_ended" );
    max_ai = get_max_ai_from_infil_name( module_struct, infil_name );
    
    if ( isdefined( level.ai_spawn_vehicle_func[ infil_name ].max_wait_for_infil ) )
    {
        waittill_any_timeout_1( level.ai_spawn_vehicle_func[ infil_name ].max_wait_for_infil, "stop_waiting_for_spawns" );
    }
    
    if ( isdefined( max_ai ) )
    {
        if ( self.attachedguys.size == max_ai || isdefined( self.load_queue ) && self.load_queue.size == max_ai )
        {
            self notify( "spawning_done" );
            return;
        }
        else
        {
            childthread send_notify_after_player_tac_vis( "spawning_done" );
            
            if ( isdefined( self.group ) )
            {
                self.group waittill_any_timeout_1( 3, "death" );
            }
            else
            {
                wait 3;
            }
            
            self notify( "spawning_done" );
        }
    }
    
    if ( isdefined( self.load_queue ) && self.load_queue.size > 0 )
    {
        self notify( "spawning_done" );
        return;
    }
    
    if ( self.attachedguys.size < 1 )
    {
        scripts\common\vehicle_code::vehicle_deathcleanup();
        scripts\common\vehicle_paths::delete_riders();
        self notify( "delete" );
        self delete();
        return;
    }
    
    self notify( "spawning_done" );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 7
// Checksum 0x0, Offset: 0x95ad
// Size: 0x54
function register_combined_vehicles( var_c7813bd63c9ba2e4, model, type, classname, mp_vehiclename, alias, build_alias )
{
    [[ var_c7813bd63c9ba2e4 ]]( model, type, classname );
    level thread register_combined_vehicles_threaded( var_c7813bd63c9ba2e4, model, type, classname, mp_vehiclename, alias, build_alias );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 8
// Checksum 0x0, Offset: 0x9609
// Size: 0x1c9
function register_combined_vehicles_threaded( var_c7813bd63c9ba2e4, model, type, classname, mp_vehiclename, alias, build_alias, spec_override )
{
    level endon( "game_ended" );
    flag_wait( "level_ready_for_script" );
    register_vehicle_build( build_alias, model, type, classname, build_alias );
    struct = spawnstruct();
    copy_vehicle_build_to_spawnpoint( alias, struct );
    
    if ( struct scripts\common\vehicle::ishelicopter() )
    {
        add_ai_air_infil( alias );
        register_vehicle_spawn( alias, 10, 10, undefined, "heli_spawner", "heli_exit", "heli_infil_path", undefined, &veh_heli_spawn, build_alias );
        register_spawner_script_function( alias, &function_64f6b6424352bc68 );
    }
    else
    {
        add_ai_ground_infil( alias );
        register_vehicle_spawn( alias, 10, 10, undefined, "ai_ground_veh_spawner", "ground_veh_exit", "ground_veh_infil_path", undefined, &veh_ground_veh_spawn, build_alias );
        register_spawner_script_function( alias, &ai_ground_veh_spawn );
    }
    
    register_vehicle_max_ai( build_alias, model, type, classname, mp_vehiclename );
    vehicle_build = level.vehicle.templates.aianims[ classname ];
    var_3c435505038f3d9c = 0;
    
    for ( i = 0; i < vehicle_build.size ; i++ )
    {
        if ( isdefined( vehicle_build[ i ].idle_anim ) )
        {
            var_3c435505038f3d9c++;
        }
    }
    
    if ( var_3c435505038f3d9c > 0 )
    {
        register_vehicle_spawn_drivers( alias, var_3c435505038f3d9c, random( [ "aq_pilot_fullbody_1", "aq_pilot_fullbody_2" ] ) );
    }
    
    if ( isdefined( mp_vehiclename ) && getdvarint( @"hash_ca67d9f39e1dd86f", 0 ) )
    {
        create_mp_version_of_vehicle( mp_vehiclename, classname, build_alias );
    }
    
    level notify( alias );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x97da
// Size: 0x7a
function create_mp_version_of_vehicle( mp_vehiclename, classname, build_alias )
{
    if ( !isdefined( mp_vehiclename ) )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle ) )
    {
        return;
    }
    
    struct = level.vehicle_builds[ build_alias ];
    struct.vehiclename = build_alias;
    create_vehicle_vehicledata( mp_vehiclename, classname, build_alias );
    create_vehicle_occupancy_data( mp_vehiclename, classname, build_alias );
    create_vehicle_interact( mp_vehiclename, classname, build_alias );
    create_vehicle_omnvars_data( mp_vehiclename, classname, build_alias );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x985c
// Size: 0x1e4
function create_vehicle_interact( mp_vehiclename, classname, build_alias )
{
    if ( !isdefined( level.vehicle.interact ) )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle.interact.vehicledata ) )
    {
        return;
    }
    
    if ( isdefined( level.vehicle.interact.vehicledata[ mp_vehiclename ] ) && !isdefined( level.vehicle.interact.vehicledata[ build_alias ] ) )
    {
        if ( isdefined( level.vehicle.templates.aianims[ classname ] ) )
        {
            leveldataforvehicle = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle( build_alias, 1 );
            
            for ( i = 0; i < level.vehicle.templates.aianims[ classname ].size ; i++ )
            {
                struct = level.vehicle.templates.aianims[ classname ][ i ];
                sittag = tolower( struct.sittag );
                leveldataforvehicle.seatenterarrays[ sittag ] = [];
                leveldataforvehicle.seatenterarrays[ sittag ][ leveldataforvehicle.seatenterarrays[ sittag ].size ] = sittag;
                leveldataforseat = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( build_alias, sittag, 1 );
                
                if ( i == 0 )
                {
                    var_7432b7fb4c69781f = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle( build_alias, 1 );
                    var_7432b7fb4c69781f.driverseatid = sittag;
                }
            }
            
            level.vehicle.interact.vehicledata[ build_alias ] = leveldataforvehicle;
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x9a48
// Size: 0xba
function create_vehicle_vehicledata( mp_vehiclename, classname, build_alias )
{
    if ( !isdefined( level.vehicle.vehicledata ) )
    {
        return;
    }
    
    if ( isdefined( level.vehicle.vehicledata[ mp_vehiclename ] ) && !isdefined( level.vehicle.vehicledata[ build_alias ] ) )
    {
        leveldataforvehicle = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle( build_alias );
        leveldataforvehicle.destroycallback = level.vehicle.vehicledata[ mp_vehiclename ].destroycallback;
        level.vehicle.vehicledata[ build_alias ] = leveldataforvehicle;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x9b0a
// Size: 0x183
function create_vehicle_omnvars_data( mp_vehiclename, classname, build_alias )
{
    if ( !isdefined( level.vehicle.omnvars.vehicledata ) )
    {
        return;
    }
    
    if ( isdefined( level.vehicle.omnvars.vehicledata[ mp_vehiclename ] ) && !isdefined( level.vehicle.omnvars.vehicledata[ build_alias ] ) )
    {
        leveldataforvehicle = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle( build_alias, 1 );
        var_ee8a4198ec7e827c = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle( mp_vehiclename );
        leveldataforvehicle.ammoids = var_ee8a4198ec7e827c.ammoids;
        leveldataforvehicle.id = var_ee8a4198ec7e827c.id;
        leveldataforvehicle.rotationids = var_ee8a4198ec7e827c.rotationids;
        leveldataforvehicle.seatids = var_ee8a4198ec7e827c.seatids;
        leveldataforvehicle.warningbits = var_ee8a4198ec7e827c.warningbits;
        leveldataforvehicle.warningclearcallbacks = var_ee8a4198ec7e827c.warningclearcallbacks;
        leveldataforvehicle.warningendcallbacks = var_ee8a4198ec7e827c.warningendcallbacks;
        leveldataforvehicle.warningstartcallbacks = var_ee8a4198ec7e827c.warningstartcallbacks;
        level.vehicle.omnvars.vehicledata[ build_alias ] = leveldataforvehicle;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0x9c95
// Size: 0xf3
function create_seatids_override( build_alias, seatids )
{
    if ( !isdefined( level.vehicle.omnvars.vehicledata ) )
    {
        return;
    }
    
    if ( isdefined( level.vehicle.omnvars.vehicledata[ build_alias ] ) )
    {
        leveldataforvehicle = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle( build_alias, 1 );
        var_7432b7fb4c69781f = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle( build_alias );
        leveldataforvehicle.seatids = [];
        keys = getarraykeys( var_7432b7fb4c69781f.seatdata );
        
        for ( i = 0; i < keys.size ; i++ )
        {
            leveldataforvehicle.seatids[ keys[ i ] ] = seatids[ i ];
        }
        
        level.vehicle.omnvars.vehicledata[ build_alias ] = leveldataforvehicle;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0x9d90
// Size: 0x36a
function create_vehicle_occupancy_data( mp_vehiclename, classname, build_alias )
{
    if ( !isdefined( level.vehicle.occupancy.vehicledata ) )
    {
        return;
    }
    
    if ( isdefined( level.vehicle.occupancy.vehicledata[ mp_vehiclename ] ) && !isdefined( level.vehicle.occupancy.vehicledata[ build_alias ] ) )
    {
        leveldataforvehicle = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle( build_alias, 1 );
        leveldataforvehicle.camera = level.vehicle.occupancy.vehicledata[ mp_vehiclename ].camera;
        leveldataforvehicle.damagefeedbackgroupheavy = level.vehicle.occupancy.vehicledata[ mp_vehiclename ].damagefeedbackgroupheavy;
        leveldataforvehicle.damagefeedbackgrouplight = level.vehicle.occupancy.vehicledata[ mp_vehiclename ].damagefeedbackgrouplight;
        leveldataforvehicle.damagemodifier = level.vehicle.occupancy.vehicledata[ mp_vehiclename ].damagemodifier;
        leveldataforvehicle.enterendcallback = level.vehicle.occupancy.vehicledata[ mp_vehiclename ].enterendcallback;
        leveldataforvehicle.enterstartcallback = level.vehicle.occupancy.vehicledata[ mp_vehiclename ].enterstartcallback;
        leveldataforvehicle.exitdirections = level.vehicle.occupancy.vehicledata[ mp_vehiclename ].exitdirections;
        leveldataforvehicle.exitendcallback = level.vehicle.occupancy.vehicledata[ mp_vehiclename ].exitendcallback;
        leveldataforvehicle.exitextents = level.vehicle.occupancy.vehicledata[ mp_vehiclename ].exitextents;
        leveldataforvehicle.exitoffsets = level.vehicle.occupancy.vehicledata[ mp_vehiclename ].exitoffsets;
        leveldataforvehicle.exitstartcallback = level.vehicle.occupancy.vehicledata[ mp_vehiclename ].exitstartcallback;
        leveldataforvehicle.restrictions = level.vehicle.occupancy.vehicledata[ mp_vehiclename ].restrictions;
        leveldataforvehicle.threatbiasgroup = level.vehicle.occupancy.vehicledata[ mp_vehiclename ].threatbiasgroup;
        level.vehicle.occupancy.vehicledata[ build_alias ] = leveldataforvehicle;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 8
// Checksum 0x0, Offset: 0xa102
// Size: 0xab
function register_seat_data_for_vehicle( build_alias, seatid, seatswitcharray, animtag, exitids, exitoffsets, exitdirections, spawnpriority )
{
    if ( !isdefined( level.vehicle ) )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle.occupancy.vehicledata ) )
    {
        return;
    }
    
    if ( !isdefined( !isdefined( level.vehicle.occupancy.vehicledata[ build_alias ] ) ) )
    {
        return;
    }
    
    register_seat_data( build_alias, seatid, seatswitcharray, animtag, exitids, exitoffsets, exitdirections, spawnpriority );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 8
// Checksum 0x0, Offset: 0xa1b5
// Size: 0xf1
function register_seat_data( build_alias, seatid, seatswitcharray, animtag, exitids, exitoffsets, exitdirections, spawnpriority )
{
    leveldataforvehicle = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle( build_alias, 1 );
    leveldataforseat = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( build_alias, seatid, 1 );
    leveldataforseat.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( seatid, seatswitcharray );
    leveldataforseat.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
    leveldataforseat.damagemodifier = 0.5;
    leveldataforseat.animtag = animtag;
    leveldataforseat.exitids = exitids;
    leveldataforvehicle.exitoffsets[ seatid ] = exitoffsets;
    leveldataforvehicle.exitdirections[ seatid ] = exitdirections;
    leveldataforseat.spawnpriority = 10;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0xa2ae
// Size: 0x1da
function register_techo_seat_data( build_alias )
{
    seatswitcharray = [ "tag_driver", "tag_passenger", "tag_bed1", "tag_bed2", "tag_bed_center" ];
    var_f079ddd1216d5051 = [ "tag_seat_0", "tag_seat_2", "tag_seat_4", "tag_seat_4", "tag_seat_4", "tag_seat_3", "tag_seat_5" ];
    var_f29d65b6397ba222 = seatswitcharray;
    exitids = [];
    exitoffsets = ( 5, 14, 55 );
    exitdirections = "left";
    spawnpriority = 10;
    
    if ( isdefined( level.vehicle.interact.vehicledata[ build_alias ] ) && isdefined( isdefined( level.vehicle.interact.vehicledata[ build_alias ].seatenterarrays ) ) )
    {
        keys = getarraykeys( level.vehicle.interact.vehicledata[ build_alias ].seatenterarrays );
        
        for ( i = 0; i < level.vehicle.interact.vehicledata[ build_alias ].seatenterarrays.size ; i++ )
        {
            seatid = keys[ i ];
            exitids = array_add( var_f29d65b6397ba222, seatid );
            register_seat_data_for_vehicle( build_alias, seatid, seatswitcharray, var_f079ddd1216d5051[ i ], exitids, exitoffsets, exitdirections, spawnpriority );
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0xa490
// Size: 0x12
function function_b7229e2dcb171037( positions )
{
    return function_7e79f1b51303070f( positions );
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0xa4ab
// Size: 0x3c
function function_7e79f1b51303070f( positions )
{
    for ( i = 0; i < positions.size ; i++ )
    {
        positions[ i ].vehicle_getoutanim = %vh_blima_rappel_heli_drop;
    }
    
    return positions;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0xa4f0
// Size: 0x53
function vehicle_registrations( lbravo, blima, mindia8 )
{
    level.var_b7229e2dcb171037 = [];
    level.var_b7229e2dcb171037[ "blima" ] = &function_b7229e2dcb171037;
    
    if ( isdefined( level.vehicle_registration_func ) )
    {
        [[ level.vehicle_registration_func ]]();
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0xa54b
// Size: 0xf1
function setup_player_vehicles( player, playername, ip1 )
{
    dash = "-";
    ampersand = "&";
    underscore = "_";
    keys = getarraykeys( level.var_a0b2c978ca57ffc5 );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        key = keys[ i ];
        name = key;
        
        if ( string_starts_with( key, "veh9" ) )
        {
            name = getsubstr( name, 5, key.size );
        }
        
        cmd = "devgui_cmd \"CP Players:2 / " + playername + " / Spawn Vehicle / " + name + "\" \"set scr_vehicle_debug Spawn" + underscore + dash + ip1 + dash + ampersand + key + "\" \n";
        addentrytodevgui( cmd );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0xa644
// Size: 0xe4
function cp_vehicle_debug( itemref )
{
    items = strtok( itemref, "_" );
    playertoks = strtok( itemref, "-" );
    params = strtok( itemref, "&" );
    player = undefined;
    
    if ( playertoks.size > 0 )
    {
        playerint = int( playertoks[ 0 ] );
        player = level.players[ playerint ];
    }
    
    switch ( items[ 0 ] )
    {
        case #"hash_819aac6f5ae2fb78":
        case #"hash_b5c4035792ad20d8":
            if ( isdefined( params ) && params.size > 1 )
            {
                script_func( params[ 1 ], player );
            }
            
            break;
        default:
            break;
    }
    
    /#
        if ( isdefined( player ) )
        {
            player thread scripts\cp_mp\vehicles\vehicle::function_276beb60c7f60d1e( params[ 1 ] );
        }
    #/
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0xa730
// Size: 0x283, Type: bool
function spawn_enemy_chopper( group, spawn_point, infil_name )
{
    data_struct = level.ai_spawn_vehicle_func[ infil_name ];
    var_1317c822798f0c26 = data_struct get_vehicle_spawn_points( spawn_point );
    
    if ( isdefined( level.attack_heli ) )
    {
        return false;
    }
    
    if ( var_1317c822798f0c26.size > 0 )
    {
        foreach ( veh_spawn_point in var_1317c822798f0c26 )
        {
            if ( istrue( veh_spawn_point.in_use ) )
            {
                continue;
            }
            
            copy_vehicle_build_to_spawnpoint( infil_name, veh_spawn_point );
            angle_ref = vectortoangles( spawn_point.origin - veh_spawn_point.origin );
            veh_spawn_point.angles = ( 0, angle_ref[ 1 ], 0 );
            helicopter = scripts\common\vehicle::vehicle_spawn( veh_spawn_point );
            
            if ( isdefined( helicopter ) )
            {
                veh_spawn_point.in_use = 1;
                level.attack_heli = helicopter;
                helicopter init_cp_vehicle( spawn_point, group, veh_spawn_point, infil_name );
                group.vehicle = undefined;
                spawn_point.vehicle = undefined;
                spawn_point.veh_spawn_point = undefined;
                group.recently_spawned_vehicle = undefined;
                helicopter init_helicopter( group, infil_name );
                helicopter.vehicle_forcerocketdeath = undefined;
                helicopter.death_fx_on_self = 1;
                helicopter.circle_radius = 2500;
                helicopter scripts\cp\helicopter\cp_helicopter::heli_mg_create( "veh8_mil_air_ahotel64_turret_wm", "chopper_gunner_turret_cp", "tag_turret" );
                helicopter thread scripts\cp\helicopter\cp_helicopter::setup_pilot( 1, undefined, undefined, undefined );
                helicopter setmaxpitchroll( 15, 15 );
                helicopter.health_remaining = 2250;
                level thread scripts\cp\helicopter\cp_helicopter::heli_think_default( helicopter );
                helicopter sethoverparams( 25, 15, 10 );
                helicopter.headicon = createheadicon( helicopter );
                setheadiconimage( helicopter.headicon, "hud_icon_head_equipment_enemy" );
                setheadiconmaxdistance( helicopter.headicon, 12000 );
                setheadiconnaturaldistance( helicopter.headicon, 1500 );
                setheadiconzoffset( helicopter.headicon, 10 );
                setheadiconsnaptoedges( helicopter.headicon, 1 );
                helicopter.bullets_can_damage = 1;
                helicopter.needs_to_evade = 0;
                level thread vo_boss_heli();
            }
        }
    }
    
    return false;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xa9bc
// Size: 0x46
function vo_boss_heli()
{
    snds = [ "dx_cps_kama_callout_helicopter_attacking_10", "dx_cps_kama_callout_helicopter_attacking_20", "dx_cps_lass_callout_helicopter_attacking_10", "dx_cps_lass_callout_helicopter_attacking_20" ];
    level scripts\cp\vo::try_to_play_vo_on_team( random( snds ), "allies" );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0xaa0a
// Size: 0x5d
function set_cp_vehicle_health_values( health )
{
    if ( isdefined( self.healthbuffer ) )
    {
        self.health = self.healthbuffer + health;
        self.maxhealth = self.health;
        return;
    }
    
    self.health = health;
    self.maxhealth = self.health;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0xaa6f
// Size: 0x191
function init_helicopter( group, infil_name )
{
    self.isheli = 1;
    self.borntime = gettime();
    
    switch ( infil_name )
    {
        case #"hash_3ac34cdad8041c36":
        case #"hash_4f1ed711fc7ee2e7":
        case #"hash_6293ed64b1ab6691":
        case #"hash_68cb10ac5667e070":
            set_cp_vehicle_health_values( 5000 );
            break;
        case #"hash_6fbd504f237f8a9e":
            set_cp_vehicle_health_values( 50000 );
            break;
        default:
            set_cp_vehicle_health_values( 1250 );
            break;
    }
    
    thread damage_players_on_top();
    self.team = "axis";
    
    if ( isdefined( self.script_team ) )
    {
        self.team = self.script_team;
    }
    
    self setvehicleteam( self.team );
    
    if ( isdefined( infil_name ) && infil_name == "lbravo_carrier" )
    {
        thread landing_damage_watcher();
    }
    
    if ( self.team == "axis" )
    {
        level thread scripts\cp\weapon::add_to_special_lockon_target_list( self );
        thread helicopter_death_lockon_clear();
    }
    
    self.dontdisconnectpaths = 1;
    self.vehicle_forcerocketdeath = 1;
    self.death_fx_on_self = 1;
    function_82a45e8aef44ce3f( &function_30a6caeaaa14c934 );
    
    if ( isdefined( infil_name ) )
    {
        level.ai_spawn_vehicle_func[ infil_name ].count++;
        
        if ( isdefined( group ) )
        {
            scripts\cp\spawning::add_to_module_vehicles_list( group, infil_name );
        }
    }
    
    level.all_spawned_vehicles[ level.all_spawned_vehicles.size ] = self;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0xac08
// Size: 0x3f, Type: bool
function function_30a6caeaaa14c934( attacker, meansofdeath, weaponobject )
{
    if ( istrue( self.nocrash ) )
    {
        thread scripts\cp\helicopter\cp_helicopter::mid_air_explode( attacker );
    }
    else
    {
        thread scripts\cp\helicopter\cp_helicopter::do_heli_crash( attacker );
    }
    
    return true;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xac50
// Size: 0x24
function helicopter_death_lockon_clear()
{
    level endon( "game_ended" );
    waittill_any_2( "death", "deleting_vehicle" );
    level thread scripts\cp\weapon::remove_from_special_lockon_target_list( self );
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xac7c
// Size: 0xc6
function damage_players_on_top()
{
    self endon( "death" );
    
    while ( true )
    {
        players_near = utility::playersnear( self.origin, 256 );
        
        for ( i = 0; i < players_near.size ; i++ )
        {
            if ( players_near[ i ].origin[ 2 ] > self.origin[ 2 ] )
            {
                if ( players_near[ i ].origin[ 2 ] - self.origin[ 2 ] <= 32 && players_near[ i ] isonground() )
                {
                    players_near[ i ] dodamage( players_near[ i ].health + 1000, self.origin, self, self, "MOD_CRUSH" );
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xad4a
// Size: 0x381
function landing_damage_watcher()
{
    self endon( "death" );
    self endon( "unloaded" );
    self notify( "landing_damage_watcher" );
    self endon( "landing_damage_watcher" );
    var_c03a5e83336294f5 = 256;
    var_5bef124e5f705d27 = 80;
    var_953d4a8f21434378 = 36;
    
    while ( isdefined( self ) )
    {
        if ( isdefined( self.borntime ) && gettime() - self.borntime < 5000 )
        {
            wait 0.05;
            continue;
        }
        
        var_60c02c698578edb = self.origin + ( 0, 0, -140 ) + anglestoforward( self.angles ) * 24;
        
        if ( self.team == "axis" )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player ) && isalive( player ) && is_point_in_cylinder( player.origin, var_60c02c698578edb, var_5bef124e5f705d27, var_953d4a8f21434378 ) )
                {
                    player dodamage( player.health + 1000, self.origin, self, self, "MOD_CRUSH" );
                }
            }
        }
        
        vehicles = vehicle_getarrayinradius( var_60c02c698578edb - ( 0, 0, 200 ), 400, 400 );
        
        if ( !isdefined( vehicles ) || vehicles.size == 0 )
        {
            wait 0.25;
            continue;
        }
        
        vehicles = sortbydistance( vehicles, self.origin );
        var_494e292fc76002c5 = undefined;
        
        for ( i = 0; i < vehicles.size ; i++ )
        {
            vehicle = vehicles[ i ];
            
            if ( !isdefined( vehicle ) || vehicle == self )
            {
                continue;
            }
            
            if ( vehicle vehicle_getspeed() > 1 )
            {
                continue;
            }
            
            if ( isent( vehicle ) && is_point_in_cylinder( vehicle.origin, var_60c02c698578edb, var_c03a5e83336294f5 * 1.5, var_953d4a8f21434378 ) )
            {
                var_494e292fc76002c5 = vehicle;
                break;
            }
        }
        
        if ( !isdefined( var_494e292fc76002c5 ) )
        {
            wait 0.05;
            continue;
        }
        
        ent = var_494e292fc76002c5;
        var_cb874df7c9e9edfc = 0;
        
        if ( isdefined( ent.vehiclename ) && ent.vehiclename == "little_bird" )
        {
            var_cb874df7c9e9edfc = 1;
        }
        
        if ( isdefined( ent.vehiclename ) && ent.vehiclename == "little_bird_mg" )
        {
            var_cb874df7c9e9edfc = 1;
        }
        
        if ( isdefined( ent.infil_name ) && ent.infil_name == "lbravo_carrier" )
        {
            var_cb874df7c9e9edfc = 1;
        }
        
        if ( isdefined( self.owner ) && isplayer( self.owner ) && isdefined( ent.owner ) && isplayer( ent.owner ) )
        {
            var_cb874df7c9e9edfc = 0;
        }
        
        if ( is_helicopter_player_occupied() && ent is_helicopter_player_occupied() )
        {
            var_cb874df7c9e9edfc = 0;
        }
        
        if ( var_cb874df7c9e9edfc )
        {
            dmg = ent.health + 1000;
            ent notify( "landing_collision_damage", dmg, self );
            ent.disableheavystatedamagefloor = 1;
            ent dodamage( dmg, self.origin, undefined, undefined, "MOD_CRUSH" );
        }
        
        wait 0.05;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 4
// Checksum 0x0, Offset: 0xb0d3
// Size: 0x57, Type: bool
function is_point_in_cylinder( point, cylinder_org, cylinder_radius, cylinder_height )
{
    if ( distance_2d_squared( point, cylinder_org ) > squared( cylinder_radius ) )
    {
        return false;
    }
    
    if ( point[ 2 ] < cylinder_org[ 2 ] )
    {
        return false;
    }
    
    if ( point[ 2 ] > cylinder_org[ 2 ] + cylinder_height )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xb133
// Size: 0x97, Type: bool
function is_helicopter_player_occupied()
{
    if ( isdefined( self.owner ) && isplayer( self.owner ) )
    {
        return true;
    }
    
    if ( isdefined( self.occupants ) )
    {
        foreach ( occupant in self.occupants )
        {
            if ( isdefined( occupant ) && isplayer( occupant ) && isalive( occupant ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0xb1d3
// Size: 0xfe
function init_ground_vehicle( group, infil_name )
{
    switch ( infil_name )
    {
        case #"hash_f80baf80c1494495":
            self.looping_path = 1;
            set_cp_vehicle_health_values( 2500 );
            break;
        case #"hash_36a654665ed22fb8":
        case #"hash_74a4c28ebce1f6c8":
        case #"hash_ed0943d77ef90562":
        case #"hash_f60027ccb20dde63":
            set_cp_vehicle_health_values( 2500 );
            break;
        default:
            set_cp_vehicle_health_values( 1250 );
            break;
    }
    
    self.vehicle_skipdeathcrash = 1;
    self.team = "axis";
    self setvehicleteam( self.team );
    
    if ( isdefined( infil_name ) )
    {
        level.ai_spawn_vehicle_func[ infil_name ].count++;
        
        if ( isdefined( group ) )
        {
            scripts\cp\spawning::add_to_module_vehicles_list( group, infil_name );
        }
    }
    
    level.all_spawned_vehicles[ level.all_spawned_vehicles.size ] = self;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xb2d9
// Size: 0x2a
function heli_think_default()
{
    thread heli_damagemonitor();
    thread heli_check_players();
    thread heli_move();
    thread engage_target_think();
    thread rumble_nearby_players();
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0xb30b
// Size: 0x635
function heli_damagemonitor( var_227a4202bbfa2f79, starting_health )
{
    self endon( "death" );
    snipes = 0;
    self.health = 1000000;
    
    if ( !isdefined( starting_health ) )
    {
        starting_health = 2500;
    }
    
    while ( true )
    {
        self waittill( "damage", amount, attacker, direction_vec, dmgpoint, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        self.health = 1000000;
        
        if ( isdefined( attacker ) && attacker == self )
        {
            continue;
        }
        
        if ( isdefined( inflictor ) && isdefined( inflictor.owner ) && inflictor.owner == self )
        {
            continue;
        }
        
        if ( isdefined( attacker ) && isdefined( self.minigun ) && attacker == self.minigun )
        {
            continue;
        }
        
        if ( scripts\cp\helicopter\cp_helicopter::is_snipe_kill( attacker, dmgpoint, objweapon ) )
        {
            snipes++;
            
            if ( snipes == 1 )
            {
                if ( isdefined( self.headicon ) )
                {
                    deleteheadicon( self.headicon );
                }
                
                self.headicon = undefined;
                eventinfo = spawnstruct();
                eventinfo.isdestroyedkillstreak = 1;
                attacker thread scripts\cp\points::doscoreevent( #"kill_ss_chopper_support", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
                attacker scripts\cp\persistence::give_player_currency( 500, "large" );
                playfx( level._effect[ "vfx_blima_explosion" ], self.origin );
                attacker scripts\cp\damagefeedback::updatedamagefeedback( "hitcritical", 1 );
                level.all_spawned_vehicles = array_remove( level.all_spawned_vehicles, self );
                self.minigun delete();
                
                if ( isdefined( self.pilot ) )
                {
                    self.pilot delete();
                }
                
                self notify( "deleting_vehicle" );
                self delete();
                return;
            }
            
            attacker.lasthitmarkertime = undefined;
            attacker scripts\cp\damagefeedback::updatedamagefeedback( "hitcritical", 1 );
            self.needs_to_evade = 1;
            self vehicle_setspeed( 100, 100, 100 );
            self setvehgoalpos( self.origin + ( randomintrange( -50, 50 ), randomintrange( -50, 50 ), 0 ), 0 );
            self notify( "needs_to_evade" );
            continue;
        }
        
        if ( !isexplosivedamagemod( meansofdeath ) )
        {
            attacker.lasthitmarkertime = undefined;
            attacker scripts\cp\damagefeedback::updatedamagefeedback( "hitarmorheavy" );
        }
        else
        {
            attacker.lasthitmarkertime = undefined;
            attacker scripts\cp\damagefeedback::updatedamagefeedback( "hitcritical" );
            
            if ( isdefined( objweapon ) && isdefined( objweapon.basename ) )
            {
                switch ( objweapon.basename )
                {
                    case #"hash_f59a8f678401aee2":
                        break;
                    case #"hash_c7ce3f77814f7950":
                        amount = 1400;
                        break;
                    default:
                        break;
                }
            }
            else if ( amount < 700 )
            {
                amount = 700;
            }
            
            if ( isdefined( var_227a4202bbfa2f79 ) && flag_exist( var_227a4202bbfa2f79 ) && !flag( var_227a4202bbfa2f79 ) )
            {
                flag_set( var_227a4202bbfa2f79 );
            }
            else
            {
                if ( !istrue( self.needs_to_evade ) )
                {
                    self.needs_to_evade = 1;
                }
                
                self notify( "needs_to_evade" );
                self vehicle_setspeed( 100, 100, 100 );
                self setvehgoalpos( self.origin + ( randomintrange( -850, 850 ), randomintrange( -850, 850 ), 0 ), 0 );
            }
        }
        
        self.health_remaining -= amount;
        
        if ( self.health_remaining <= starting_health * 0.25 && !isdefined( self.deathfx ) )
        {
            playfx( level._effect[ "aerial_explosion" ], self.origin );
            self setscriptablepartstate( "body_damage_heavy", "on" );
            self.deathfx = 1;
        }
        else if ( self.health_remaining <= starting_health * 0.5 && !isdefined( self.deathfx1 ) )
        {
            self setscriptablepartstate( "body_damage_medium", "on" );
            playfx( level._effect[ "aerial_explosion" ], self.origin );
            self.deathfx1 = 1;
        }
        else if ( self.health_remaining <= starting_health * 0.75 && !isdefined( self.deathfx2 ) )
        {
            self setscriptablepartstate( "body_damage_light", "on" );
            self.deathfx2 = 1;
        }
        
        if ( self.health_remaining <= 0 )
        {
            if ( isdefined( self.headicon ) )
            {
                deleteheadicon( self.headicon );
            }
            
            self.headicon = undefined;
            
            if ( isdefined( attacker ) && isplayer( attacker ) )
            {
                eventinfo = spawnstruct();
                eventinfo.isdestroyedkillstreak = 1;
                attacker thread scripts\cp\points::doscoreevent( #"kill_ss_chopper_support", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
                attacker scripts\cp\persistence::give_player_currency( 500, "large" );
            }
            
            playfx( level._effect[ "vfx_blima_explosion" ], self.origin );
            attacker scripts\cp\damagefeedback::updatedamagefeedback( "hitcritical", 1 );
            level.all_spawned_vehicles = array_remove( level.all_spawned_vehicles, self );
            self.minigun delete();
            
            if ( isdefined( self.pilot ) )
            {
                self.pilot delete();
            }
            
            self notify( "deleting_vehicle" );
            self delete();
            continue;
        }
        
        if ( isdefined( attacker ) && isplayer( attacker ) )
        {
            attacker scripts\cp\persistence::give_player_currency( 10, "large" );
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0xb948
// Size: 0x15
function create_rocket_death_fx( classname )
{
    level.vtclassname = classname;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0xb965
// Size: 0x157
function get_helicopter_path_positions( target_player )
{
    self.path_positions = [];
    slices = 12;
    dist = 2048;
    angle_frac = 360 / slices;
    pos = self.origin;
    self.flight_pos = undefined;
    self.flight_pos_dot = undefined;
    
    if ( isdefined( target_player ) )
    {
        if ( isvector( target_player ) )
        {
            targetpos = target_player;
        }
        else
        {
            targetpos = target_player.origin;
        }
    }
    else
    {
        targetpos = get_center_point_of_array( level.players );
    }
    
    for ( i = 0; i < slices ; i++ )
    {
        angle = angle_frac * i;
        xadd = cos( angle ) * dist;
        yadd = sin( angle ) * dist;
        x = pos[ 0 ] + xadd;
        y = pos[ 1 ] + yadd;
        z = pos[ 2 ];
        
        if ( validate_pos( ( x, y, z ), targetpos ) )
        {
            self.path_positions[ self.path_positions.size ] = ( x, y, z );
        }
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0xbac4
// Size: 0x216
function validate_pos( targetpos, valid_target )
{
    if ( isdefined( valid_target ) )
    {
        targetpos = ( targetpos[ 0 ], targetpos[ 1 ], valid_target[ 2 ] + 1500 );
    }
    
    if ( isdefined( level.heli_triggers ) && level.heli_triggers.size > 0 )
    {
        temp_array = level.heli_triggers;
        
        for ( t = 0; t < temp_array.size ; t++ )
        {
            if ( !isdefined( temp_array[ t ] ) )
            {
                level.heli_triggers = array_remove( level.heli_triggers, temp_array[ t ] );
                continue;
            }
            
            if ( isdefined( self.move_trigger ) && self.move_trigger == temp_array[ t ] )
            {
                continue;
            }
            
            if ( ispointinvolume( targetpos, temp_array[ t ] ) )
            {
                return 0;
            }
        }
    }
    
    if ( scripts\engine\trace::capsule_trace_passed( self.origin, targetpos, 256, 512, self.angles, self ) )
    {
        if ( isdefined( valid_target ) )
        {
            to_point = targetpos - self.origin;
            
            if ( isvector( valid_target ) )
            {
                var_4fe25eaeba81ec3 = vectortoangles( valid_target - self.origin );
            }
            else if ( isdefined( valid_target.velo_forward ) )
            {
                var_4fe25eaeba81ec3 = vectortoangles( valid_target.velo_forward - self.origin );
            }
            else
            {
                var_4fe25eaeba81ec3 = vectortoangles( valid_target.origin - self.origin );
            }
            
            forward = anglestoforward( var_4fe25eaeba81ec3 );
            dot = vectordot( to_point, forward );
            
            if ( isdefined( self.flight_pos ) )
            {
                if ( dot > self.flight_pos_dot )
                {
                    self.flight_pos_dot = dot;
                    self.flight_pos = targetpos;
                }
            }
            else
            {
                self.flight_pos_dot = dot;
                self.flight_pos = targetpos;
            }
            
            if ( dot > 0.3 )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        else if ( math::is_point_in_front( targetpos ) )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 0;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xbce2
// Size: 0xdd
function heli_move()
{
    level endon( "game_ended" );
    self endon( "death" );
    chopper_height = self.origin[ 2 ];
    self.chopper_height = chopper_height;
    targettimeout = 0;
    timeout = 5;
    self vehicle_setspeed( 75, 30 );
    
    while ( true )
    {
        if ( istrue( self.needs_to_evade ) )
        {
            heli_evade( ( self.origin[ 0 ], self.origin[ 1 ], self.chopper_height ) );
            continue;
        }
        
        if ( !isdefined( self.best_target ) )
        {
            heli_go_search();
            continue;
        }
        
        if ( should_move_to_target( self.minigun, self.best_target ) )
        {
            heli_move_to_target( self.best_target );
            continue;
        }
        
        wait 1;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 2
// Checksum 0x0, Offset: 0xbdc7
// Size: 0xb0, Type: bool
function should_move_to_target( dist_ent, target )
{
    var_47c3d9295106d6d0 = 6250000;
    
    if ( isdefined( self.should_move_to_target_dist ) )
    {
        var_47c3d9295106d6d0 = self.should_move_to_target_dist * self.should_move_to_target_dist;
    }
    
    if ( istrue( self.landed ) )
    {
        self.landed = undefined;
        return true;
    }
    
    if ( distance2dsquared( dist_ent.origin, target.origin ) > var_47c3d9295106d6d0 || isdefined( self.gotopos ) && distance2dsquared( dist_ent.origin, self.gotopos ) > var_47c3d9295106d6d0 )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0xbe80
// Size: 0x10c
function heli_move_to_target( target )
{
    self endon( "death" );
    self cleartargetyaw();
    self cleargoalyaw();
    self setlookatent( target );
    
    if ( isdefined( self.best_target ) )
    {
        get_helicopter_path_positions( self.best_target );
    }
    else
    {
        get_helicopter_path_positions();
    }
    
    origin = undefined;
    
    if ( isdefined( self.flight_pos ) )
    {
        origin = self.flight_pos;
    }
    else if ( isdefined( self.path_positions ) && self.path_positions.size > 0 )
    {
        origin = random( self.path_positions );
    }
    
    if ( isdefined( origin ) )
    {
        self setneargoalnotifydist( 750 );
        
        if ( distance2dsquared( self.origin, origin ) > 1440000 )
        {
            self vehicle_setspeed( 50, 30, 30 );
            self setvehgoalpos( origin, 1 );
        }
        else
        {
            self vehicle_setspeed( 15, 12, 12 );
            self setvehgoalpos( origin, 0 );
        }
        
        waittill_any_timeout_1( 15, "near_goal" );
    }
    
    wait 5;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 1
// Checksum 0x0, Offset: 0xbf94
// Size: 0x227
function heli_evade( target )
{
    self notify( "taking_evasive_actions" );
    self endon( "taking_evasive_actions" );
    self endon( "death" );
    rad = 5000;
    get_helicopter_path_positions();
    points = self.path_positions;
    
    if ( isdefined( points ) && points.size > 0 )
    {
        start_index = 0;
        start_point = points[ 0 ];
        self cleargoalyaw();
        self cleartargetyaw();
        self clearlookatent();
        
        foreach ( index, point in points )
        {
            if ( isvector( point ) )
            {
                end_pos = point;
            }
            else
            {
                end_pos = point.origin;
            }
            
            if ( within_fov( self.origin, self.angles, end_pos, cos( 25 ) ) )
            {
                start_point = point;
                start_index = index;
                break;
            }
        }
        
        if ( isvector( points[ start_index ] ) )
        {
            self setvehgoalpos( points[ start_index ], 0 );
        }
        else
        {
            self setvehgoalpos( points[ start_index ].origin, 0 );
        }
        
        notify_dist = 1500;
        notify_dist *= rad / 5000;
        heli_speed = 100;
        heli_speed *= rad / 5000;
        self setneargoalnotifydist( 1500 );
        self vehicle_setspeed( 100, 50, 50 );
        numpoints = 0;
        index = start_index + 1;
        random_num = randomint( 4 );
        
        while ( numpoints < points.size - 1 )
        {
            if ( index >= points.size )
            {
                index = 0;
            }
            
            if ( isvector( points[ index ] ) )
            {
                self setvehgoalpos( points[ index ], 0 );
            }
            else
            {
                self setvehgoalpos( points[ index ].origin, 0 );
            }
            
            self waittill( "near_goal" );
            numpoints++;
            index++;
            
            if ( numpoints == random_num )
            {
                break;
            }
        }
    }
    
    self.needs_to_evade = 0;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xc1c3
// Size: 0x2b
function rumble_nearby_players()
{
    self endon( "death" );
    
    while ( true )
    {
        playrumbleonposition( "cp_chopper_rumble", self.origin );
        wait 0.1;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xc1f6
// Size: 0x8c
function heli_check_players()
{
    self endon( "death" );
    self.best_target = undefined;
    reacquire_timer = 5;
    reacquire_counter = 0;
    
    while ( true )
    {
        valid_target = heli_get_target();
        
        if ( isdefined( valid_target ) )
        {
            reacquire_counter = 0;
            self notify( "target_found" );
            self.best_target = valid_target;
        }
        else
        {
            self notify( "target_lost" );
            reacquire_counter += 0.25;
            
            if ( reacquire_counter >= reacquire_timer )
            {
                reacquire_counter = 0;
                self.best_target = undefined;
            }
        }
        
        wait 0.25;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xc28a
// Size: 0xfc
function engage_target_think()
{
    level endon( "game_ended" );
    self notify( "engage_target_think" );
    self endon( "engage_target_think" );
    self endon( "death" );
    self.minigun setmode( "manual" );
    self.nextfiretime = gettime() + 2000;
    
    while ( true )
    {
        while ( isdefined( self.best_target ) )
        {
            self sethoverparams( 150, 35, 35 );
            
            if ( istrue( self.has_rockets ) )
            {
                wait 2;
                
                if ( istrue( self.rockets_ready ) )
                {
                    scripts\cp\helicopter\cp_helicopter::hover_and_shoot_rockets( self.best_target );
                }
            }
            else
            {
                self.minigun settargetentity( self.best_target, ( 0, 0, 40 ) );
                result = waittill_any_ents_or_timeout_return( 3, self.minigun, "turret_on_target" );
                scripts\cp\helicopter\cp_helicopter::shoot_at_target();
            }
            
            self notify( "target_engaged" );
            self sethoverparams( 0, 0, 0 );
        }
        
        wait 1;
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xc38e
// Size: 0x2a8
function heli_get_target()
{
    trace_pos = self.origin;
    closest = undefined;
    all_players = get_array_of_closest( trace_pos, level.players );
    
    for ( i = 0; i < all_players.size ; i++ )
    {
        player = all_players[ i ];
        
        if ( !player is_valid_player( undefined, 0 ) || istrue( player isinfreefall() ) || istrue( player isskydiving() ) || istrue( player isparachuting() ) )
        {
            continue;
        }
        
        trace_pos = ( player.origin[ 0 ], player.origin[ 1 ], self.chopper_height );
        
        if ( !istrue( self.has_rockets ) )
        {
            if ( scripts\engine\trace::ray_trace_passed( trace_pos, player.origin + ( 0, 0, 10 ), [ self, player ] ) )
            {
                closest = player;
                self.gotopos = trace_pos;
            }
        }
        
        if ( !isdefined( closest ) )
        {
            r = anglestoright( player.angles );
            l = anglestoleft( player.angles );
            f = anglestoforward( player.angles );
            b = f * -1;
            tracepoints = [ r, l, f, b ];
            
            foreach ( point in tracepoints )
            {
                if ( isdefined( player.vehicle ) )
                {
                    ignore_array = [ self, player, player.vehicle ];
                }
                else
                {
                    ignore_array = [ self, player ];
                }
                
                trace_pos = ( player.origin[ 0 ], player.origin[ 1 ], 0 ) + ( point[ 0 ], point[ 1 ], 0 ) * 1800 + ( 0, 0, self.chopper_height );
                
                if ( scripts\engine\trace::ray_trace_passed( trace_pos, player.origin + ( 0, 0, 10 ), ignore_array ) )
                {
                    closest = player;
                    self.gotopos = trace_pos;
                    self.nocircle = 1;
                    return closest;
                }
            }
        }
        
        if ( isdefined( closest ) )
        {
            break;
        }
    }
    
    return closest;
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xc63f
// Size: 0xe7
function heli_go_search()
{
    level endon( "game_ended" );
    self endon( "target_found" );
    self endon( "needs_to_evade" );
    self endon( "death" );
    self clearlookatent();
    self cleartargetyaw();
    self cleargoalyaw();
    
    if ( isdefined( self.minigun ) )
    {
        self.minigun cleartargetentity();
    }
    
    self vehicle_setspeed( 90, 15 );
    self setneargoalnotifydist( 1000 );
    
    while ( !isdefined( self.best_target ) )
    {
        get_helicopter_path_positions();
        
        if ( isdefined( self.flight_pos ) )
        {
            origin = self.flight_pos;
            self setvehgoalpos( origin, 0 );
        }
        else if ( isdefined( self.path_positions ) && self.path_positions.size > 0 )
        {
            origin = random( self.path_positions );
            self setvehgoalpos( origin, 0 );
        }
        
        self waittill( "near_goal" );
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xc72e
// Size: 0xe, Type: bool
function is_vehicle_spawnpoint()
{
    return scripts\cp\spawner_scoring::get_spawn_scoring_type() == "vehicle_spawner";
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xc745
// Size: 0x2
function function_3458e37bbac2ff9a()
{
    
}

// Namespace vehicles / scripts\cp\vehicles
// Params 0
// Checksum 0x0, Offset: 0xc74f
// Size: 0x74
function function_f83786291b8efe6e()
{
    self endon( "death_or_disconnect" );
    
    while ( true )
    {
        self waittill( "vehicle_enter" );
        wait 1;
        self sethudtutorialmessage( &"COOP_GAME_PLAY/LEANOUT_TUTORIAL", 1 );
        time = gettime() + 5000;
        
        while ( gettime() < time )
        {
            if ( self meleebuttonpressed() )
            {
                break;
            }
            
            if ( !isdefined( self.vehicle ) )
            {
                break;
            }
            
            wait 0.05;
        }
        
        self clearhudtutorialmessage();
    }
}

// Namespace vehicles / scripts\cp\vehicles
// Params 3
// Checksum 0x0, Offset: 0xc7cb
// Size: 0xfb
function register_invalid_seats_for_module_by_seat( var_46ff34890ecae00b, infil_name, invalid_seats )
{
    if ( isdefined( level.ambientgroups[ var_46ff34890ecae00b ] ) )
    {
        if ( isarray( level.ambientgroups[ var_46ff34890ecae00b ] ) )
        {
            for ( i = 0; i < level.ambientgroups[ var_46ff34890ecae00b ].size ; i++ )
            {
                if ( !isdefined( level.ambientgroups[ var_46ff34890ecae00b ][ i ].vehicle_invalid_seats ) )
                {
                    level.ambientgroups[ var_46ff34890ecae00b ][ i ].vehicle_invalid_seats = [];
                }
                
                level.ambientgroups[ var_46ff34890ecae00b ][ i ].vehicle_invalid_seats[ infil_name ] = invalid_seats;
            }
            
            return;
        }
        
        if ( !isdefined( level.ambientgroups[ var_46ff34890ecae00b ].vehicle_invalid_seats ) )
        {
            level.ambientgroups[ var_46ff34890ecae00b ].vehicle_invalid_seats = [];
        }
        
        level.ambientgroups[ var_46ff34890ecae00b ].vehicle_invalid_seats[ infil_name ] = invalid_seats;
    }
}

