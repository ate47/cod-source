#using scripts\common\utility;
#using scripts\cp\cp_aiparachute;
#using scripts\cp\cp_gameskill;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\cp_wave_spawning;
#using scripts\cp\persistence;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace cp_wave_spawning;

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 0
// Checksum 0x0, Offset: 0x3f7
// Size: 0x6d
function init_wave_spawning()
{
    if ( !isdefined( level.wave_table ) )
    {
        if ( getdvar( @"ui_gametype" ) == "cp_wave_sv" )
        {
            level.wave_table = "cp/" + getdvar( @"ui_mapname" ) + "_wave_table.csv";
        }
        else
        {
            level.wave_table = "cp/cp_donetsk_wave_table.csv";
        }
    }
    
    level thread initialize_wave_spawn_modules();
    
    /#
        function_46ec151542255df6();
    #/
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 0
// Checksum 0x0, Offset: 0x46c
// Size: 0x345
function initialize_wave_spawn_modules()
{
    wave_min = [ &set_count_based_on_grouped_modules, "grouped_wave_spawning", 0, 0 ];
    var_61671992d4830187 = [ &set_count_based_on_grouped_modules, "grouped_wave_spawning", [ &get_ambient_max_count, 30 ], 30 ];
    wave_max = [ &set_count_based_on_grouped_modules, "grouped_wave_spawning", [ &get_ambient_max_count, 30 ], 30 ];
    registerambientgroup( "wave_spawning", wave_min, var_61671992d4830187, undefined, [ &wave_spawn_proc, undefined, undefined, 0.1, [ &get_wave_low_threshold, 0 ], &get_wave_high_threshold, 1 ], undefined, &return_wave_veh_spawners, &init_wave_spawning_module_proc );
    registerambientgroup( "wave_spawning", wave_min, wave_max, undefined, [ &wave_spawn, undefined, undefined, [ &get_spawn_time_from_wave, 1 ], [ &get_wave_low_threshold, 0 ], &get_wave_high_threshold, 1 ], undefined, &return_cover_spawners, &init_wave_spawning_module );
    register_module_pause_unpause_funcs( "wave_spawning", &pause_wave_hud, &unpause_wave_hud );
    register_module_init_func( "wave_spawning", [ &combine_module_counters, "wave_spawning" ] );
    register_module_as_passive( "wave_spawning" );
    
    if ( is_wave_gametype() )
    {
        register_module_ai_spawn_func( "wave_spawning", [ &module_set_goal_radius, 750 ] );
        register_module_ai_spawn_func( "wave_spawning", [ &module_set_goal_height, 64 ] );
        set_spawn_scoring_params_for_group( "wave_spawning", 750, 1024, 2500, 1 );
    }
    else
    {
        set_spawn_scoring_params_for_group( "wave_spawning", 1024, 1536, 2500, 1 );
    }
    
    register_module_ai_spawn_func( "wave_spawning", &increase_wave_ai_spawned_counter );
    register_module_ai_spawn_func( "wave_paratroopers", &increase_wave_ai_spawned_counter );
    register_module_ai_death_func( "wave_spawning", &increase_wave_ai_killed_counter );
    register_module_ai_death_func( "wave_paratroopers", &increase_wave_ai_killed_counter );
    register_module_ai_death_func( "wave_spawning", &update_current_count_death );
    level thread create_paratrooper_spawners();
    registerambientgroup( "wave_paratroopers", 0, 30, 8, 0.5, undefined, &return_paratroopers_spawners, &init_paratroopers_spawners );
    register_module_init_func( "wave_paratroopers", [ &combine_module_counters, "wave_spawning" ] );
    register_module_ai_spawn_func( "wave_paratroopers", &scripts\cp\cp_aiparachute::paratrooper_spawnfunc );
    set_spawn_scoring_params_for_group( "wave_paratroopers", 0, 2000, 200000, 1 );
    register_module_ai_death_func( "wave_paratroopers", &update_current_count_death );
    registerambientgroup( "wave_veh_test", 0, 24, undefined, 0.1, undefined, &return_wave_veh_spawners, &force_wave_vehicles_on );
    registerambientgroup( "attack_heli_test", 0, 1, undefined, 0.1, 0, "wave_veh_spawners", undefined, undefined, undefined );
    register_module_init_func( "attack_heli_test", [ &cap_vehicle_type_on_module, "attack_heli", 1 ] );
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0x7b9
// Size: 0x15
function increase_wave_ai_spawned_counter( module_struct )
{
    level.wave_ai_spawned++;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0x7d6
// Size: 0x9b
function increase_wave_ai_killed_counter( module_struct )
{
    if ( !isdefined( module_struct ) && isdefined( self.group ) )
    {
        module_struct = self.group;
    }
    
    if ( isdefined( module_struct ) && !istrue( module_struct.kamikaze ) && istrue( self.never_unloaded_from_vehicle ) )
    {
        subtract_from_spawn_count_from_group( module_struct );
        toggle_force_stop_wave_from_groupname( "wave_spawning", undefined, "wave_retry" );
        run_func_on_group_by_groupname( "wave_spawning", [ &send_notify_to_module_struct, "wave_delay_over" ] );
        level.wave_ai_spawned--;
        return;
    }
    
    level.wave_ai_killed++;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 2
// Checksum 0x0, Offset: 0x879
// Size: 0x17
function send_notify_to_module_struct( module_struct, var_ff5ccede2521cb13 )
{
    module_struct notify( var_ff5ccede2521cb13 );
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0x898
// Size: 0x22a
function init_wave_spawning_module( group )
{
    level endon( "game_ended" );
    
    if ( !flag_exist( "wave_spawning_initialized" ) )
    {
        flag_init( "wave_spawning_initialized" );
    }
    
    /#
        level.wave = group;
    #/
    
    starting_wave = define_var_if_undefined( group get_current_wave_ref(), 1 );
    
    if ( isdefined( level.spawn_module_structs_memory[ group.group_name ] ) )
    {
        for ( i = 0; i < level.spawn_module_structs_memory[ group.group_name ].size ; i++ )
        {
            level.spawn_module_structs_memory[ group.group_name ][ i ].wave_reference = starting_wave;
            level.spawn_module_structs_memory[ group.group_name ][ i ].cover_node_spawners_override_id = 0;
            level.spawn_module_structs_memory[ group.group_name ][ i ].cover_node_spawners_override = [];
            level.spawn_module_structs_memory[ group.group_name ][ i ].wave_spawner_overrides = [];
            level.spawn_module_structs_memory[ group.group_name ][ i ].requested_spawners = [];
            level.spawn_module_structs_memory[ group.group_name ][ i ].requested_veh_spawners = [];
            level.spawn_module_structs_memory[ group.group_name ][ i ].last_wave_num = level.spawn_module_structs_memory[ group.group_name ][ i ].wave_reference;
            level.spawn_module_structs_memory[ group.group_name ][ i ].last_wave_ref = level.spawn_module_structs_memory[ group.group_name ][ i ].wave_reference;
        }
    }
    
    group init_passive_wave_struct();
    flag_wait( "cover_spawners_initialized" );
    run_func_on_group_by_groupname( "wave_spawning", &setup_wave_vars );
    flag_set( "wave_spawning_initialized" );
    group start_wave();
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 0
// Checksum 0x0, Offset: 0xaca
// Size: 0x34
function start_wave()
{
    level endon( "game_ended" );
    level.wave_ai_spawned = 0;
    level.wave_ai_killed = 0;
    set_wave_settings();
    update_current_count( self );
    thread show_all_player_wave_started_splash();
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0xb06
// Size: 0x59
function init_wave_spawning_module_proc( group )
{
    level endon( "game_ended" );
    
    if ( !flag_exist( "wave_spawning_initialized" ) )
    {
        flag_init( "wave_spawning_initialized" );
    }
    
    /#
        level.veh_wave = group;
    #/
    
    group init_passive_wave_struct();
    flag_wait( "cover_spawners_initialized" );
    flag_wait( "wave_spawning_initialized" );
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 3
// Checksum 0x0, Offset: 0xb67
// Size: 0x46
function cap_vehicle_type_on_module( module_struct, vehicle_type, max_num )
{
    if ( !isdefined( module_struct.vehicle_caps ) )
    {
        module_struct.vehicle_caps = [];
    }
    
    module_struct.vehicle_caps[ vehicle_type ] = max_num;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 0
// Checksum 0x0, Offset: 0xbb5
// Size: 0x7d
function create_paratrooper_spawners()
{
    flag_wait( "cover_spawners_initialized" );
    
    for ( i = 0; i < 8 ; i++ )
    {
        struct = spawnstruct();
        addtostructarray( "targetname", "wave_paratroopers", struct );
        struct.origin = getclosestpointonnavmesh( ( 0, 0, 0 ) );
        struct.script_forcespawn = 1;
        struct spawner_init();
    }
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0xc3a
// Size: 0x42
function return_paratroopers_spawners( group )
{
    if ( istrue( group.respawning ) )
    {
        return return_cover_spawners( group );
    }
    
    spawn_structs = getstructarray( "wave_paratroopers", "targetname" );
    return spawn_structs;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0xc84
// Size: 0x135
function init_paratroopers_spawners( group )
{
    group copy_wave_settings_from_module( group, "wave_spawning" );
    spawner = group move_spawnpoints_to_valid_positions();
    var_1e4bce6c927436e0 = spawner.parachute_land_origin + ( 0, 0, 12000 );
    spawnpos = var_1e4bce6c927436e0 + anglestoforward( ( 0, randomint( 360 ), 0 ) ) * -20000;
    
    if ( getdvarint( @"hash_188f3d56a3849a78", 0 ) )
    {
        thread drawsphere( spawner.origin, 128, 60, ( 1, 1, 1 ) );
        thread drawsphere( var_1e4bce6c927436e0, 128, 60, ( 1, 1, 0 ) );
        thread drawsphere( spawnpos, 128, 60, ( 0, 1, 0 ) );
    }
    
    ac130 = spawner scripts\cp\cp_aiparachute::spawn_paratrooper_ac130( group.group_name, spawnpos, var_1e4bce6c927436e0 );
    group.ac130 = ac130;
    ac130 scripts\cp\cp_aiparachute::ac130_flight_path( var_1e4bce6c927436e0 );
    ac130 thread thread_on_notify_no_endon_death( "death", &end_paratroopers_group );
    group move_spawnpoints_to_ac130();
    spawner = group move_spawnpoints_to_valid_positions( 1 );
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 0
// Checksum 0x0, Offset: 0xdc1
// Size: 0x10
function end_paratroopers_group()
{
    stop_module_by_groupname( "wave_paratroopers", 1 );
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 0
// Checksum 0x0, Offset: 0xdd9
// Size: 0x58
function move_spawnpoints_to_ac130()
{
    spawn_structs = getstructarray( "wave_paratroopers", "targetname" );
    
    for ( i = 0; i < spawn_structs.size ; i++ )
    {
        spawn_structs[ i ].origin = self.ac130.origin;
    }
    
    waitframe();
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0xe39
// Size: 0xcb
function move_spawnpoints_to_valid_positions( debug )
{
    spawn_structs = getstructarray( "wave_paratroopers", "targetname" );
    positions = get_positions_around_vector( get_center_point_of_array( level.players ) );
    
    for ( i = 0; i < spawn_structs.size ; i++ )
    {
        spawn_structs[ i ].origin = positions[ i ];
        spawn_structs[ i ].parachute_land_origin = spawn_structs[ i ].origin;
        
        if ( istrue( debug ) )
        {
            if ( getdvarint( @"hash_188f3d56a3849a78", 0 ) )
            {
                thread drawsphere( spawn_structs[ i ].origin, 32, 60, ( 0, 1, 1 ) );
            }
        }
    }
    
    return spawn_structs[ 0 ];
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0xf0d
// Size: 0x148
function get_positions_around_vector( pos )
{
    return_array = [];
    slices = 12;
    dist = 2048;
    angle_frac = 360 / slices;
    starting_pos = pos;
    
    for ( i = 0; i < slices ; i++ )
    {
        angle = angle_frac * i;
        xadd = cos( angle ) * dist;
        yadd = sin( angle ) * dist;
        x = starting_pos[ 0 ] + xadd;
        y = starting_pos[ 1 ] + yadd;
        z = starting_pos[ 2 ];
        pos = getclosestpointonnavmesh( ( x, y, z ) );
        results = scripts\engine\trace::sphere_trace( starting_pos + ( 0, 0, 48 ), pos, 32, level.characters );
        
        if ( isdefined( results ) && isdefined( results[ "shape_position" ] ) )
        {
            pos = results[ "shape_position" ];
            pos = getgroundposition( pos, 1, 1000, 1000 );
            return_array[ return_array.size ] = pos;
        }
    }
    
    return array_randomize( return_array );
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0x105e
// Size: 0x50
function force_wave_vehicles_on( group )
{
    group.wave_use_vehicles = 1;
    group.valid_vehicles = [];
    group.valid_vehicles[ "lbravo_carrier" ] = 500;
    group.valid_vehicles[ "mindia8" ] = 500;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0x10b6
// Size: 0xf6
function return_wave_veh_spawners( group )
{
    if ( istrue( group.respawning ) )
    {
        return return_cover_spawners( group );
    }
    
    if ( isdefined( group.requested_veh_spawners ) && group.requested_veh_spawners.size > 0 )
    {
        temp_array = [];
        
        for ( i = 0; i < group.requested_veh_spawners.size ; i++ )
        {
            spawners = getstructarray( group.requested_veh_spawners[ i ], "targetname" );
            temp_array = array_combine( temp_array, spawners );
        }
        
        if ( temp_array.size > 0 )
        {
            return temp_array;
        }
        else if ( istrue( group.wave_use_vehicles ) )
        {
            return getstructarray( "wave_veh_spawners", "targetname" );
        }
        
        return;
    }
    
    if ( istrue( group.wave_use_vehicles ) )
    {
        return getstructarray( "wave_veh_spawners", "targetname" );
    }
    
    return [];
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 7
// Checksum 0x0, Offset: 0x11b4
// Size: 0x3a8
function wave_spawn( group, wavetime, spawn_window_time, spawntime, low_threshold, high_threshold, spawn_count )
{
    group notify( "wave_spawn" );
    group endon( "wave_spawn" );
    
    if ( isdefined( group.paratroopers_allowed ) && group.paratroopers_allowed > 0 )
    {
        group.paratroopers_allowed--;
        run_spawn_module( "wave_paratroopers" );
    }
    
    if ( isdefined( group.wave_airstrikes_allowed ) && group.wave_airstrikes_allowed > 0 )
    {
        group.wave_airstrikes_allowed--;
        streakinfo = spawnstruct();
        streakinfo.streakname = "precision_airstrike";
        
        if ( !isdefined( streakinfo.shots_fired ) )
        {
            streakinfo.shots_fired = 0;
        }
        
        players = get_array_of_valid_players();
        
        if ( players.size > 0 )
        {
            player = random( players );
            streakinfo.owner = player;
            animname = level.scr_anim[ streakinfo.streakname ][ "airstrike_flyby" ];
            thread scripts\cp_mp\killstreaks\airstrike::callstrike( player, player.origin, player.angles[ 1 ], undefined, streakinfo, animname );
        }
    }
    
    wavetime = define_var_if_undefined( wavetime, get_passive_wave_spawn_time() );
    spawn_window_time = define_var_if_undefined( spawn_window_time, get_passive_spawn_window_time() );
    spawntime = define_var_if_undefined( spawntime, 0.1 );
    ref_count = group get_spawncount_from_groupnames( [ "wave_spawning", "wave_paratroopers" ] );
    active_count = group get_activecount_from_group();
    low_threshold = get_passive_wave_low_threshold( group, low_threshold );
    high_threshold = get_passive_wave_high_threshold( group, high_threshold );
    scripts\cp\cp_gameskill::wave_difficulty_update( self.wave_difficulty );
    
    if ( isdefined( low_threshold ) && isdefined( high_threshold ) )
    {
        if ( istrue( group.stop_wave_spawning ) )
        {
            toggle_force_stop_wave_from_groupname( group.group_name, 1, "end_wave" );
            toggle_force_stop_wave_from_groupname( "wave_paratroopers", 1, "end_wave" );
            group waittill( "wave_delay_over" );
        }
        else if ( ref_count < group.spawn_wave_total )
        {
            if ( active_count >= high_threshold )
            {
                run_func_on_group_by_groupname( group.group_name, [ &change_module_status, "wait_4_count: " + low_threshold ] );
                run_func_on_group_by_groupname( "wave_paratroopers", [ &change_module_status, "wait_4_count: " + low_threshold ] );
                group group_wait_for_activecount_notify( low_threshold );
                return spawntime;
            }
            else
            {
                run_func_on_group_by_groupname( group.group_name, [ &change_module_status, "spawning" ] );
                run_func_on_group_by_groupname( "wave_paratroopers", [ &change_module_status, "spawning" ] );
                return spawntime;
            }
        }
        else
        {
            toggle_force_stop_wave_from_groupname( group.group_name, 1, "end_wave" );
            toggle_force_stop_wave_from_groupname( "wave_paratroopers", 1, "end_wave" );
            group waittill( "wave_delay_over" );
        }
        
        return;
    }
    
    if ( isdefined( group.spawn_wave_total ) && isdefined( ref_count ) && ref_count >= group.spawn_wave_total )
    {
        toggle_force_stop_wave_from_groupname( group.group_name, 1, "end_wave" );
        toggle_force_stop_wave_from_groupname( "wave_paratroopers", 1, "end_wave" );
        group waittill( "wave_delay_over" );
        return;
    }
    
    return spawntime;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 7
// Checksum 0x0, Offset: 0x1564
// Size: 0x280
function wave_spawn_proc( group, wavetime, spawn_window_time, spawntime, low_threshold, high_threshold, spawn_count )
{
    group notify( "wave_spawn" );
    group endon( "wave_spawn" );
    
    while ( getdvarint( @"hash_b27ec95e27463b0", 0 ) )
    {
        wait 1;
    }
    
    wavetime = define_var_if_undefined( wavetime, get_passive_wave_spawn_time() );
    spawn_window_time = define_var_if_undefined( spawn_window_time, get_passive_spawn_window_time() );
    spawntime = define_var_if_undefined( spawntime, 0.1 );
    ref_count = group get_spawncount_from_groupnames( [ "wave_spawning", "wave_paratroopers" ] );
    active_count = group get_activecount_from_group();
    low_threshold = get_passive_wave_low_threshold( group, low_threshold );
    high_threshold = get_passive_wave_high_threshold( group, high_threshold );
    scripts\cp\cp_gameskill::wave_difficulty_update( self.wave_difficulty );
    
    if ( isdefined( low_threshold ) && isdefined( high_threshold ) )
    {
        allowed_vehicles = group get_allowed_vehicle_types_from_wave();
        
        if ( istrue( group.use_only_veh_spawners ) && ( !isdefined( allowed_vehicles ) || allowed_vehicles.size < 1 ) )
        {
            run_func_on_group_by_groupname( group.group_name, &unset_vehicle_only_wave );
        }
        
        if ( istrue( group.stop_wave_spawning ) )
        {
            toggle_force_stop_wave_from_groupname( group.group_name, 1, "end_wave" );
            toggle_force_stop_wave_from_groupname( "wave_paratroopers", 1, "end_wave" );
            group waittill( "wave_delay_over" );
        }
        else if ( active_count >= high_threshold )
        {
            if ( ref_count < group.spawn_wave_total )
            {
                run_func_on_group_by_groupname( group.group_name, [ &change_module_status, "wait_4_count: " + low_threshold ] );
                run_func_on_group_by_groupname( "wave_paratroopers", [ &change_module_status, "wait_4_count: " + low_threshold ] );
                group group_wait_for_activecount_notify( low_threshold );
                return spawntime;
            }
            else
            {
                toggle_force_stop_wave_from_groupname( group.group_name, 1, "end_wave" );
                toggle_force_stop_wave_from_groupname( "wave_paratroopers", 1, "end_wave" );
                group waittill( "wave_delay_over" );
            }
        }
        else
        {
            run_func_on_group_by_groupname( group.group_name, [ &change_module_status, "spawning" ] );
            run_func_on_group_by_groupname( "wave_paratroopers", [ &change_module_status, "spawning" ] );
            return spawntime;
        }
        
        return;
    }
    
    return spawntime;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 2
// Checksum 0x0, Offset: 0x17ec
// Size: 0x29
function unset_vehicle_only_wave( group, new_status )
{
    group.wave_use_vehicles = undefined;
    group.use_only_veh_spawners = undefined;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0x181d
// Size: 0x101
function increase_wave_num( var_2248eae0b480df1b )
{
    current_wave_ref = get_current_wave_ref();
    
    if ( isdefined( current_wave_ref ) )
    {
        reset_spawn_count_from_groupname( self.group_name );
        
        if ( isstring( self.next_wave ) && self.next_wave != "" )
        {
            self.last_wave_ref = self.next_wave;
        }
        else if ( isint( current_wave_ref ) )
        {
            if ( current_wave_ref == self.last_wave_num )
            {
                self.last_wave_num++;
            }
            else
            {
                self.last_wave_num = current_wave_ref;
            }
            
            self.last_wave_ref = self.last_wave_num;
        }
        else
        {
            self.last_wave_ref = current_wave_ref;
        }
        
        self.wave_reference = self.last_wave_ref;
        set_wave_settings_for_all_with_groupname( self.group_name, self.wave_reference, self.last_wave_ref, self.last_wave_num );
        
        if ( istrue( var_2248eae0b480df1b ) )
        {
            return;
        }
        
        start_wave();
    }
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0x1926
// Size: 0x25
function pause_wave_hud( module_struct )
{
    module_struct change_module_status( undefined, "Module Paused" );
    setomnvar( "cp_wave_timer", 0 );
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0x1953
// Size: 0x19
function unpause_wave_hud( module_struct )
{
    module_struct change_module_status( undefined, "Module Unpaused" );
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 2
// Checksum 0x0, Offset: 0x1974
// Size: 0x29
function delay_then_run_wave_override( timer, wave_ref )
{
    if ( isdefined( timer ) && timer > 0 )
    {
        wait timer;
    }
    
    set_wave_ref_override( wave_ref );
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0x19a5
// Size: 0xd8
function update_current_count_death( group )
{
    if ( isdefined( group ) )
    {
        wave_group = group;
    }
    else if ( isdefined( self.group ) )
    {
        wave_group = self.group;
    }
    else
    {
        return 0;
    }
    
    active_count = wave_group get_activecount_from_group();
    level thread wave_failsafe_end( wave_group );
    
    if ( wave_group is_wave_hud_enabled() && !istrue( wave_group.kamikaze ) )
    {
        update_enemies_remaining( undefined, wave_group );
    }
    
    if ( !istrue( wave_group.kamikaze ) && istrue( wave_group.stop_wave_spawning ) && active_count < wave_group.next_threshold )
    {
        run_func_on_group_by_groupname( wave_group.group_name, [ &toggle_kamikaze_for_group, 1 ] );
        level thread wave_go_kamikaze( wave_group );
    }
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 2
// Checksum 0x0, Offset: 0x1a85
// Size: 0xec
function update_enemies_remaining( num, group )
{
    if ( isdefined( num ) )
    {
        setomnvar( "cp_enemies_remaining", num );
        level.wave_enemies_remaining = num;
        return;
    }
    
    module_structs = get_module_structs_by_groupname( "wave_spawning" );
    module_structs = array_combine( module_structs, get_module_structs_by_groupname( "wave_paratroopers" ) );
    group.total_killed += 1;
    count = 0;
    
    for ( i = 0; i < module_structs.size ; i++ )
    {
        if ( isdefined( module_structs[ i ].total_killed ) )
        {
            count += module_structs[ i ].total_killed;
        }
    }
    
    count = level.wave_ai_killed;
    num = group.spawn_wave_total - count;
    setomnvar( "cp_enemies_remaining", num );
    level.wave_enemies_remaining = num;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0x1b79
// Size: 0x5b
function update_current_count( group )
{
    if ( !isdefined( group ) )
    {
        if ( isdefined( self.group ) )
        {
            group = self.group;
        }
        else
        {
            return 0;
        }
    }
    
    if ( group is_wave_hud_enabled() && group.total_killed == 0 )
    {
        update_enemies_remaining( group.spawn_wave_total, group );
    }
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 0
// Checksum 0x0, Offset: 0x1bdc
// Size: 0x84
function init_passive_wave_struct()
{
    struct = spawnstruct();
    struct.high_threshold = undefined;
    struct.low_threshold = undefined;
    struct.spawn_window_time = 5;
    struct.wave_spawn_time = 15;
    struct.min_count = 0;
    struct.max_count = 48;
    struct.wave_time_between_spawns = 1;
    struct.disable_wave_hud = 0;
    self.passive_wave_settings = struct;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 0
// Checksum 0x0, Offset: 0x1c68
// Size: 0x5f5
function set_wave_settings()
{
    if ( isdefined( level.wave_table ) )
    {
        wave_table = level.wave_table;
    }
    else if ( getdvar( @"ui_gametype" ) == "cp_wave_sv" )
    {
        wave_table = "cp/" + getdvar( @"ui_mapname" ) + "_wave_table.csv";
    }
    else
    {
        wave_table = "cp/cp_donetsk_wave_table.csv";
    }
    
    if ( getdvarint( @"hash_1661cdbaedd6ca75", 1 ) && tableexists( wave_table ) )
    {
        table = wave_table;
        group_name = "wave_spawning";
        
        if ( isdefined( level.spawn_module_structs_memory[ group_name ] ) )
        {
            for ( i = 0; i < level.spawn_module_structs_memory[ group_name ].size ; i++ )
            {
                module_struct = level.spawn_module_structs_memory[ group_name ][ i ];
                search_term = module_struct get_current_wave_ref();
                module_struct.valid_vehicles = [];
                module_struct.valid_vehicles[ "lbravo_carrier" ] = int( tablelookup( table, 0, search_term, 15 ) );
                module_struct.valid_vehicles[ "mindia8" ] = int( tablelookup( table, 0, search_term, 16 ) );
                module_struct.valid_vehicles[ "attack_heli" ] = int( tablelookup( table, 0, search_term, 19 ) );
                
                if ( array_sum( module_struct.valid_vehicles ) > 0 )
                {
                    module_struct.wave_use_vehicles = 1;
                }
                
                module_struct.spawn_aitype_counts = [];
                module_struct.spawn_aitype_counts[ "ar" ] = int( tablelookup( table, 0, search_term, 1 ) );
                module_struct.spawn_aitype_counts[ "ar_heavy" ] = int( tablelookup( table, 0, search_term, 2 ) );
                module_struct.spawn_aitype_counts[ "ar_heavy_laser" ] = int( tablelookup( table, 0, search_term, 3 ) );
                module_struct.spawn_aitype_counts[ "smg" ] = int( tablelookup( table, 0, search_term, 4 ) );
                module_struct.spawn_aitype_counts[ "smg_heavy" ] = int( tablelookup( table, 0, search_term, 5 ) );
                module_struct.spawn_aitype_counts[ "shotgun" ] = int( tablelookup( table, 0, search_term, 6 ) );
                module_struct.spawn_aitype_counts[ "shotgun_heavy" ] = int( tablelookup( table, 0, search_term, 7 ) );
                module_struct.spawn_aitype_counts[ "rpg" ] = int( tablelookup( table, 0, search_term, 8 ) );
                module_struct.spawn_aitype_counts[ "lmg" ] = int( tablelookup( table, 0, search_term, 9 ) );
                module_struct.spawn_aitype_counts[ "lmg_heavy" ] = int( tablelookup( table, 0, search_term, 10 ) );
                module_struct.spawn_aitype_counts[ "sniper" ] = int( tablelookup( table, 0, search_term, 11 ) );
                module_struct.spawn_aitype_counts[ "goliath" ] = int( tablelookup( table, 0, search_term, 12 ) );
                module_struct.spawn_aitype_counts[ "suicidebomber" ] = int( tablelookup( table, 0, search_term, 13 ) );
                module_struct.spawn_aitype_counts[ "juggernaut" ] = int( tablelookup( table, 0, search_term, 14 ) );
                module_struct.spawn_aitype_counts = module_struct remove_invalid_aitypes();
                module_struct.wave_difficulty = int( tablelookup( table, 0, search_term, 22 ) );
                module_struct.high_threshold = int( tablelookup( table, 0, search_term, 23 ) );
                module_struct.min_count = int( tablelookup( table, 0, search_term, 24 ) );
                module_struct.next_threshold = int( tablelookup( table, 0, search_term, 25 ) );
                module_struct.timeout_after_min_count = int( tablelookup( table, 0, search_term, 26 ) );
                module_struct.next_wave = tablelookup( table, 0, search_term, 29 );
                module_struct.use_only_veh_spawners = int( tablelookup( table, 0, search_term, 32 ) );
                module_struct.paratroopers_allowed = int( tablelookup( table, 0, search_term, 20 ) );
                module_struct.wave_airstrikes_allowed = int( tablelookup( table, 0, search_term, 21 ) );
                var_2831269a752e5bf5 = float( tablelookup( table, 0, search_term, 30 ) );
                module_struct.wave_time_between_spawns = ter_op( var_2831269a752e5bf5 > 0, var_2831269a752e5bf5, 1 );
                
                if ( scripts\cp\utility::is_wave_gametype() )
                {
                    module_struct.disable_wave_hud = int( tablelookup( table, 0, search_term, 31 ) );
                }
                else
                {
                    module_struct.disable_wave_hud = 1;
                }
                
                /#
                    if ( getdvarint( @"hash_7aa9ca88617b9ed4", 0 ) )
                    {
                        module_struct.disable_wave_hud = 0;
                    }
                #/
                
                module_struct.spawn_wave_total = array_sum( module_struct.spawn_aitype_counts ) + module_struct.paratroopers_allowed * 8;
                module_struct.total_killed = 0;
                module_struct.requested_spawners = [];
                toks = strtok( tablelookup( table, 0, search_term, 27 ), "," );
                
                if ( isdefined( toks ) && toks.size > 0 )
                {
                    for ( j = 0; j < toks.size ; j++ )
                    {
                        module_struct add_spawners_to_passive_wave_spawning( toks[ j ] );
                    }
                }
                
                module_struct.requested_veh_spawners = [];
                toks = strtok( tablelookup( table, 0, search_term, 28 ), "," );
                
                if ( isdefined( toks ) && toks.size > 0 )
                {
                    for ( j = 0; j < toks.size ; j++ )
                    {
                        module_struct add_veh_spawners_to_passive_wave_spawning( toks[ j ] );
                    }
                }
            }
        }
    }
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 2
// Checksum 0x0, Offset: 0x2265
// Size: 0xb0
function copy_wave_settings_from_module( module_struct, group_name )
{
    if ( isdefined( level.spawn_module_structs_memory[ group_name ] ) )
    {
        group = level.spawn_module_structs_memory[ group_name ][ 0 ];
        module_struct.high_threshold = group.high_threshold;
        module_struct.next_threshold = group.next_threshold;
        module_struct.min_count = group.min_count;
        module_struct.disable_wave_hud = group.disable_wave_hud;
        return;
    }
    
    module_struct.spawn_wave_total = module_struct.totalspawns;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 0
// Checksum 0x0, Offset: 0x231d
// Size: 0x110
function show_all_player_wave_started_splash()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "show_all_player_wave_started_splash" );
    
    if ( is_wave_hud_enabled() || is_wave_gametype() )
    {
        level notify( "wave_starting" );
        
        if ( !isdefined( level.display_wave_num ) )
        {
            level.display_wave_num = 1;
        }
        else
        {
            level.display_wave_num += 1;
        }
        
        setomnvar( "cp_wave_number", level.display_wave_num );
        wait 0.1;
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            level.players[ i ] thread scripts\cp\cp_hud_message::showsplash( "cp_wave_started", level.display_wave_num, undefined );
            level.players[ i ] setplayerdata( "cp", "alienSession", "waveNum", level.display_wave_num );
            scripts\cp\persistence::update_player_career_highest_wave( level.players[ i ], level.display_wave_num, level.players.size );
        }
    }
    
    wait 2;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 0
// Checksum 0x0, Offset: 0x2435
// Size: 0xd, Type: bool
function is_wave_hud_enabled()
{
    return !istrue( self.disable_wave_hud );
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 0
// Checksum 0x0, Offset: 0x244b
// Size: 0xc
function clear_wave_ref_override()
{
    self.wave_reference_override = undefined;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0x245f
// Size: 0x3f
function get_wave_high_threshold( group )
{
    if ( isdefined( group.high_threshold ) )
    {
        return int( group.high_threshold );
    }
    
    return int( group.spawn_wave_total );
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 2
// Checksum 0x0, Offset: 0x24a6
// Size: 0x2f
function get_spawn_time_from_wave( group, default_spawntime )
{
    if ( isdefined( self.wave_time_between_spawns ) )
    {
        return self.wave_time_between_spawns;
    }
    
    return default_spawntime;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 2
// Checksum 0x0, Offset: 0x24dd
// Size: 0x38
function get_wave_low_threshold( group, return_value )
{
    if ( isdefined( group.min_count ) )
    {
        return int( group.min_count );
    }
    
    return return_value;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 0
// Checksum 0x0, Offset: 0x251d
// Size: 0xa3
function get_current_wave_ref()
{
    /#
        if ( getdvar( @"hash_348079ac80b6fbf5", "<dev string:x1c>" ) != "<dev string:x1c>" )
        {
            return getdvar( @"hash_348079ac80b6fbf5" );
        }
    #/
    
    if ( isdefined( level.first_wave_override ) )
    {
        return_value = level.first_wave_override;
        level.first_wave_override = undefined;
        return return_value;
    }
    
    if ( isdefined( self.wave_reference_override ) )
    {
        return_value = self.wave_reference_override;
        self.wave_reference_override = undefined;
        return return_value;
    }
    
    if ( isdefined( self.wave_reference ) )
    {
        return self.wave_reference;
    }
    
    return undefined;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0x25c8
// Size: 0x5f
function add_spawners_to_passive_wave_spawning( spawner_targetname )
{
    if ( !array_contains( self.requested_spawners, spawner_targetname ) )
    {
        spawners = getstructarray( spawner_targetname, "targetname" );
        
        if ( spawners.size > 0 )
        {
            self.requested_spawners[ self.requested_spawners.size ] = spawner_targetname;
            array_thread( spawners, &spawner_init );
        }
    }
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 1
// Checksum 0x0, Offset: 0x262f
// Size: 0x5f
function add_veh_spawners_to_passive_wave_spawning( spawner_targetname )
{
    if ( !array_contains( self.requested_veh_spawners, spawner_targetname ) )
    {
        spawners = getstructarray( spawner_targetname, "targetname" );
        
        if ( spawners.size > 0 )
        {
            self.requested_veh_spawners[ self.requested_veh_spawners.size ] = spawner_targetname;
            array_thread( spawners, &spawner_init );
        }
    }
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 7
// Checksum 0x0, Offset: 0x2696
// Size: 0x2e9
function module_wave_spawn( group, wavetime, spawn_window_time, spawntime, low_threshold, high_threshold, spawn_count )
{
    wavetime = define_var_if_undefined( wavetime, get_passive_wave_spawn_time() );
    spawn_window_time = define_var_if_undefined( spawn_window_time, get_passive_spawn_window_time() );
    spawntime = define_var_if_undefined( spawntime, 0.1 );
    ref_count = define_var_if_undefined( spawn_count, group get_activecount_from_group() );
    low_threshold = get_passive_wave_low_threshold( group, low_threshold );
    high_threshold = get_passive_wave_high_threshold( group, high_threshold );
    
    if ( istrue( group.spawn_window_open ) )
    {
        if ( !istrue( group.disable_wave_hud ) )
        {
            setomnvar( "cp_wave_timer", 0 );
        }
        
        return spawntime;
    }
    
    time = gettime();
    
    if ( isdefined( low_threshold ) && isdefined( high_threshold ) )
    {
        if ( isdefined( spawn_count ) )
        {
            if ( group.spawn_count > 0 && group.spawn_count % high_threshold == 0 )
            {
                group change_module_status( undefined, "low_threshold: " + low_threshold );
                group group_wait_for_activecount_notify( low_threshold );
                group change_module_status( undefined, "wave_delay" );
                group wave_cooldown_time( wavetime );
                wait wavetime;
                
                if ( !istrue( group.disable_wave_hud ) )
                {
                    setomnvar( "cp_wave_timer", 0 );
                }
                
                group scripts\cp\cp_wave_spawning::increase_wave_num();
                group change_module_status( undefined, "spawning_after_low_threshold" );
            }
            else
            {
                group change_module_status( undefined, "spawning_to_high_threshold" );
                return spawntime;
            }
        }
        else if ( ref_count >= high_threshold )
        {
            group change_module_status( undefined, "low_threshold: " + low_threshold );
            group group_wait_for_activecount_notify( low_threshold );
            group change_module_status( undefined, "wave_delay" );
            group wave_cooldown_time( wavetime );
            wait wavetime;
            
            if ( !istrue( group.disable_wave_hud ) )
            {
                setomnvar( "cp_wave_timer", 0 );
            }
            
            group scripts\cp\cp_wave_spawning::increase_wave_num();
            group change_module_status( undefined, "spawning_after_low_threshold" );
        }
        else
        {
            group change_module_status( undefined, "spawning_to_high_threshold" );
            return spawntime;
        }
        
        return;
    }
    
    if ( !isdefined( group.last_wave_time ) )
    {
        group change_module_status( undefined, "first_spawn_window" );
        group.spawn_window_open = 1;
        group delaythread( spawn_window_time, &disable_spawn_window );
        group delaythread( spawn_window_time, &wave_cooldown_time, wavetime );
        return spawntime;
    }
    
    time_left = group.last_wave_time + wavetime * 1000 - time;
    
    if ( time_left < 0 )
    {
        group change_module_status( undefined, "full_spawn_window" );
        group.spawn_window_open = 1;
        group delaythread( spawn_window_time, &disable_spawn_window );
        group delaythread( spawn_window_time, &wave_cooldown_time, wavetime );
        return spawntime;
    }
    
    group change_module_status( undefined, "wave_delay" );
    return wavetime;
}

// Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
// Params 2
// Checksum 0x0, Offset: 0x2987
// Size: 0x76
function get_ambient_max_count( group, default_value )
{
    if ( getdvarint( @"hash_a70fa5936c87d3ff", -1 ) != -1 )
    {
        return getdvarint( @"hash_a70fa5936c87d3ff" );
    }
    
    if ( isdefined( self.passive_wave_settings ) && isdefined( self.passive_wave_settings.max_count ) )
    {
        return self.passive_wave_settings.max_count;
    }
    
    return default_value;
}

/#

    // Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
    // Params 0
    // Checksum 0x0, Offset: 0x2a05
    // Size: 0xb2, Type: dev
    function function_46ec151542255df6()
    {
        level thread debug_activation( @"hash_5e35c90539fb0416", &function_fa78a89dd0b02138 );
        wave_table = level.wave_table;
        
        if ( tableexists( wave_table ) )
        {
            row = 0;
            
            while ( true )
            {
                index = tablelookupbyrow( wave_table, row, 0 );
                
                if ( index == "<dev string:x1c>" )
                {
                    break;
                }
                
                row++;
                new_index = "<dev string:x1d>" + index + "<dev string:x23>" + row;
                cmd = "<dev string:x25>" + new_index + "<dev string:x63>" + index + "<dev string:x87>";
                addentrytodevgui( cmd );
            }
        }
    }

    // Namespace cp_wave_spawning / scripts\cp\cp_wave_spawning
    // Params 1
    // Checksum 0x0, Offset: 0x2abf
    // Size: 0x121, Type: dev
    function function_fa78a89dd0b02138( itemref )
    {
        items = strtok( itemref, "<dev string:x8b>" );
        playertoks = strtok( itemref, "<dev string:x8d>" );
        params = strtok( itemref, "<dev string:x8f>" );
        player = undefined;
        
        if ( playertoks.size > 1 )
        {
            playerint = int( playertoks[ 0 ] );
            player = level.players[ playerint ];
        }
        
        switch ( items[ 0 ] )
        {
            case #"hash_38e44e4f68ca86ac":
            case #"hash_c7cb19e460d1476d":
                break;
            case #"hash_ed49946bfff8e78a":
                break;
            case #"hash_bda5687440fc2934":
                test_index = int( params[ 1 ] );
                
                if ( test_index > 0 )
                {
                    params[ 1 ] = test_index;
                }
                
                setomnvar( "<dev string:xa8>", 0 );
                setomnvar( "<dev string:xb6>", params[ 1 ] );
                level.display_wave_num = params[ 1 ] - 1;
                set_wave_ref_override( params[ 1 ] );
                break;
        }
    }

#/
