#using scripts\common\utility;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_lights;
#using scripts\common\vehicle_paths;
#using scripts\engine\utility;

#namespace vehicle;

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x35b
// Size: 0x53
function init_vehicles()
{
    if ( getdvarint( @"hash_742caa13b3c2e685", 0 ) )
    {
        return;
    }
    
    if ( isdefined( level.disablevehiclescripts ) && level.disablevehiclescripts )
    {
        return;
    }
    
    if ( !add_init_script( "vehicles", &init_vehicles ) )
    {
        return;
    }
    
    thread init_vehicles_thread();
    cleanup_vt();
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x3b6
// Size: 0x20
function cleanup_vt()
{
    level.vtclassname = undefined;
    level.vtmodel = undefined;
    level.vttype = undefined;
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x3de
// Size: 0xf5
function init_vehicles_thread()
{
    create_lock( "aircraft_wash_math" );
    vehicle_setuplevelvariables();
    level.vehicle.helicopter_crash_locations = array_combine( level.vehicle.helicopter_crash_locations, getstructarray_delete( "helicopter_crash_location", "targetname" ) );
    vehicle_setupspawners();
    allvehiclesprespawn = vehicle_precachescripts();
    setup_vehicles( allvehiclesprespawn );
    level.vehicle.has_vehicles = getentarray( "script_vehicle", "code_classname" ).size > 0;
    script_func( "add_hint_string", "invulerable_frags", &"SCRIPT/INVULERABLE_FRAGS" );
    script_func( "add_hint_string", "invulerable_bullets", &"SCRIPT/INVULERABLE_BULLETS" );
    script_func( "add_hint_string", "enter_vehicle", &"SCRIPT/ENTER_VEHICLE" );
    script_func( "add_hint_string", "exit_vehicle", &"SCRIPT/EXIT_VEHICLE", &function_3e3d0013d3b2b92a );
}

// Namespace vehicle / scripts\common\vehicle
// Params 3
// Checksum 0x0, Offset: 0x4db
// Size: 0x24
function vehicle_paths( node, var_269fb0ec10b51524, var_cfa3aafb71b08d36 )
{
    return _vehicle_paths( node, var_269fb0ec10b51524, var_cfa3aafb71b08d36 );
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x508
// Size: 0x12
function vehicle_spawn( vspawner )
{
    return vehicle_spawn_internal( vspawner );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x523
// Size: 0xd
function godon()
{
    self.godmode = 1;
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x538
// Size: 0xc
function godoff()
{
    self.godmode = 0;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x54c
// Size: 0x26
function function_7461e330c56d791e( parts )
{
    if ( !isarray( parts ) )
    {
        parts = [ parts ];
    }
    
    self.var_9868a2f0e52a82bd = parts;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x57a
// Size: 0x43
function function_20fc7af6688ea282( parts )
{
    if ( !isdefined( self.var_845b5beb82aa6bda ) )
    {
        return;
    }
    
    if ( !isarray( parts ) )
    {
        parts = [ parts ];
    }
    
    self.var_9868a2f0e52a82bd = array_remove( parts, self.var_845b5beb82aa6bda );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x5c5
// Size: 0xd
function function_9ce59aa48970a667()
{
    self.demigodmode = 1;
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x5da
// Size: 0xc
function function_7d7628da4296efab()
{
    self.demigodmode = 0;
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x5ee
// Size: 0x8
function mainturretoff()
{
    return _mainturretoff();
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x5ff
// Size: 0x8
function mainturreton()
{
    return _mainturreton();
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x610
// Size: 0x8
function mgoff()
{
    return _mgoff();
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x621
// Size: 0x8
function mgon()
{
    return _mgon();
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x632
// Size: 0xc, Type: bool
function isvehicle()
{
    return isdefined( self.vehicletype );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x647
// Size: 0x8
function vehicle_is_crashing()
{
    return vehicle_iscrashing();
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x658
// Size: 0xa
function vehicle_kill_rumble_forever()
{
    self notify( "kill_rumble_forever" );
}

// Namespace vehicle / scripts\common\vehicle
// Params 2
// Checksum 0x0, Offset: 0x66a
// Size: 0xe8
function spawn_vehicles_from_targetname( targetname, var_a7333fc35fb3cc3a )
{
    vehicles = [];
    spawners = getentarray( targetname, "targetname" );
    
    foreach ( spawner in spawners )
    {
        if ( !isdefined( spawner.code_classname ) || spawner.code_classname != "script_vehicle" )
        {
            continue;
        }
        
        if ( isspawner( spawner ) )
        {
            vehicle = vehicle_spawn_internal( spawner, var_a7333fc35fb3cc3a );
            
            if ( istrue( var_a7333fc35fb3cc3a ) )
            {
                vehicle waittill( "vehicle_init_complete" );
            }
            
            vehicles = array_add( vehicles, vehicle );
        }
    }
    
    assertex( vehicles.size, "No vehicle spawners had targetname " + targetname );
    return vehicles;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x75b
// Size: 0x44
function spawn_vehicle_from_targetname( name )
{
    vehiclearray = spawn_vehicles_from_targetname( name );
    assertex( vehiclearray.size == 1, "Tried to spawn a vehicle from targetname " + name + " but it returned " + vehiclearray.size + " vehicles, instead of 1" );
    return vehiclearray[ 0 ];
}

// Namespace vehicle / scripts\common\vehicle
// Params 2
// Checksum 0x0, Offset: 0x7a8
// Size: 0x58
function spawn_vehicle_from_targetname_and_drive( name, var_a7333fc35fb3cc3a )
{
    vehiclearray = spawn_vehicles_from_targetname( name, var_a7333fc35fb3cc3a );
    assertex( vehiclearray.size == 1, "Tried to spawn a vehicle from targetname " + name + " but it returned " + vehiclearray.size + " vehicles, instead of 1" );
    thread gopath( vehiclearray[ 0 ] );
    return vehiclearray[ 0 ];
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x809
// Size: 0x68
function spawn_vehicles_from_targetname_and_drive( name )
{
    vehiclearray = spawn_vehicles_from_targetname( name );
    
    foreach ( vehicle in vehiclearray )
    {
        thread gopath( vehicle );
    }
    
    return vehiclearray;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x87a
// Size: 0x14
function aircraft_wash( model )
{
    thread aircraft_wash_thread( model );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x896
// Size: 0xb
function vehicle_wheels_forward()
{
    vehicle_setwheeldirection( 1 );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x8a9
// Size: 0xa
function vehicle_wheels_backward()
{
    vehicle_setwheeldirection( 0 );
}

// Namespace vehicle / scripts\common\vehicle
// Params 3
// Checksum 0x0, Offset: 0x8bb
// Size: 0x170
function vehicle_load_ai( ai, goddriver, group )
{
    if ( !isarray( ai ) )
    {
        ai = [ ai ];
    }
    
    scripts\common\vehicle_aianim::load_ai( ai, goddriver, group );
    
    if ( getdvarint( @"hash_9403d7d31fc1d981" ) )
    {
        if ( !self.usedpositions[ 0 ] && !istrue( self.player_drivable ) )
        {
            assert( self.riders.size );
            riders = self.riders;
            vehicle_unload();
            scripts\engine\utility::ent_flag_wait( "unloaded" );
            riders = array_removedead( riders );
            riders = array_remove_array( riders, self.riders );
            
            if ( riders.size > 0 )
            {
                vehicle_load_ai( riders );
            }
            
            return;
        }
        
        vehicleanim = level.vehicle.templates.aianims[ get_vehicle_classname() ];
        
        if ( isdefined( vehicleanim[ 0 ].death ) )
        {
            foreach ( rider in self.riders )
            {
                if ( istrue( rider.drivingvehicle ) )
                {
                    thread scripts\common\vehicle_aianim::driverdead( rider );
                }
            }
        }
    }
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0xa33
// Size: 0x43
function spawn_vehicle_and_gopath()
{
    vehicle = utility::spawn_vehicle();
    
    if ( isdefined( self.script_speed ) )
    {
        if ( !ishelicopter() )
        {
            vehicle vehicle_setspeed( self.script_speed );
        }
    }
    
    thread gopath( vehicle );
    return vehicle;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0xa7f
// Size: 0x45
function attach_vehicle( node )
{
    self vehicle_teleport( node.origin, node.angles );
    
    if ( !ishelicopter() )
    {
        waitframe();
        self attachpath( node );
    }
    
    thread vehicle_paths( node, 1 );
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0xacc
// Size: 0x4b
function attach_vehicle_and_gopath( node )
{
    self vehicle_teleport( node.origin, node.angles );
    waitframe();
    
    if ( !ishelicopter() )
    {
        self attachpath( node );
    }
    
    thread vehicle_paths( node );
    gopath( self );
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0xb1f
// Size: 0x151
function vehicle_get_riders_by_group( groupname )
{
    group = [];
    assert( isdefined( self.vehicletype ) );
    classname = get_vehicle_classname();
    
    if ( !isdefined( level.vehicle.templates.unloadgroups[ classname ] ) )
    {
        return group;
    }
    
    vehicles_groups = level.vehicle.templates.unloadgroups[ classname ];
    
    if ( !isdefined( groupname ) )
    {
        return group;
    }
    
    foreach ( guy in self.riders )
    {
        assert( isdefined( guy.vehicle_position ) );
        
        foreach ( groupid in vehicles_groups[ groupname ] )
        {
            if ( guy.vehicle_position == groupid )
            {
                group[ group.size ] = guy;
            }
        }
    }
    
    return group;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0xc79
// Size: 0x12
function vehicle_unload( who )
{
    return _vehicle_unload( who );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0xc94
// Size: 0xa
function vehicle_turret_scan_off()
{
    self notify( "stop_scanning_turret" );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0xca6
// Size: 0xe3
function vehicle_get_path_array()
{
    self endon( "death" );
    apathnodes = [];
    estartnode = self.attachedpath;
    
    if ( !isdefined( self.attachedpath ) )
    {
        return apathnodes;
    }
    
    nextnode = estartnode;
    nextnode.counted = 0;
    
    while ( isdefined( nextnode ) )
    {
        if ( isdefined( nextnode.counted ) && nextnode.counted == 1 )
        {
            break;
        }
        
        apathnodes = array_add( apathnodes, nextnode );
        nextnode.counted = 1;
        
        if ( !isdefined( nextnode.target ) )
        {
            break;
        }
        
        if ( !ishelicopter() )
        {
            nextnode = getvehiclenode( nextnode.target, "targetname" );
            continue;
        }
        
        nextnode = getent_or_struct( nextnode.target, "targetname" );
    }
    
    return apathnodes;
}

// Namespace vehicle / scripts\common\vehicle
// Params 2
// Checksum 0x0, Offset: 0xd92
// Size: 0x28
function vehicle_lights_on( group, classname )
{
    if ( !isdefined( group ) )
    {
        group = "all";
    }
    
    lights_on( group, classname );
}

// Namespace vehicle / scripts\common\vehicle
// Params 2
// Checksum 0x0, Offset: 0xdc2
// Size: 0x28
function vehicle_lights_off( group, classname )
{
    if ( !isdefined( group ) )
    {
        group = "all";
    }
    
    lights_off( group, classname );
}

// Namespace vehicle / scripts\common\vehicle
// Params 2
// Checksum 0x0, Offset: 0xdf2
// Size: 0x2e
function vehicle_switch_paths( next_node, target_node )
{
    self setswitchnode( next_node, target_node );
    self.attachedpath = target_node;
    thread vehicle_paths();
}

// Namespace vehicle / scripts\common\vehicle
// Params 3
// Checksum 0x0, Offset: 0xe28
// Size: 0x24
function vehicle_stop_named( stop_name, acceleration, deceleration )
{
    return _vehicle_stop_named( stop_name, acceleration, deceleration );
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0xe55
// Size: 0x12
function vehicle_resume_named( stop_name )
{
    return _vehicle_resume_named( stop_name );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0xe70
// Size: 0x4e, Type: bool
function ishelicopter()
{
    if ( isdefined( self.isheli ) )
    {
        return true;
    }
    
    if ( !isdefined( self.vehicletype ) )
    {
        return false;
    }
    
    return isdefined( level.vehicle.templates.helicopter_list[ getxhashasset( self.vehicletype ) ] );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0xec7
// Size: 0x3e, Type: bool
function isboat()
{
    if ( !isdefined( self.vehicletype ) )
    {
        return false;
    }
    
    return isdefined( level.vehicle.templates.boat_list[ getxhashasset( self.vehicletype ) ] );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0xf0e
// Size: 0x2f, Type: bool
function isairplane()
{
    return isdefined( level.vehicle.templates.airplane_list[ getxhashasset( self.vehicletype ) ] );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0xf46
// Size: 0x3e, Type: bool
function istank()
{
    if ( !isdefined( self.vehicletype ) )
    {
        return false;
    }
    
    return isdefined( level.vehicle.templates.tank_list[ getxhashasset( self.vehicletype ) ] );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0xf8d
// Size: 0x1f
function enable_global_vehicle_spawn_functions()
{
    vehicle_setuplevelvariables();
    level.vehicle.spawn_functions_enable = 1;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0xfb4
// Size: 0x59, Type: bool
function isplayerinvehicle( veh )
{
    if ( isdefined( veh ) && isdefined( veh.driver ) && isplayer( veh.driver ) )
    {
        return true;
    }
    
    if ( !isdefined( veh ) && isdefined( level.player.veh ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x1016
// Size: 0x13, Type: bool
function function_3e3d0013d3b2b92a( veh )
{
    return !isplayerinvehicle( veh );
}

// Namespace vehicle / scripts\common\vehicle
// Params 4
// Checksum 0x0, Offset: 0x1032
// Size: 0x1c9
function vehicle_watch_for_driving( dist, entercallback, exitcallback, interact_delay )
{
    self endon( "death" );
    self endon( "stop_driveable" );
    level.player endon( "death" );
    self.player_drivable = 1;
    
    while ( true )
    {
        waitframe();
        
        if ( self.code_classname == "script_vehicle" )
        {
            if ( !isdefined( level.player.veh ) )
            {
                if ( distance2dsquared( level.player.origin, self.origin ) < squared( dist ) )
                {
                    script_func( "display_hint", "enter_vehicle", 0.05 );
                    
                    if ( level.player usebuttonpressed() )
                    {
                        level.player notify( "drive_vehicle" );
                        self vehicle_turnengineon();
                        level.player [[ entercallback ]]( self );
                        self.driver = level.player;
                        level.player.veh = self;
                        function_89cec1224ae724d5();
                        
                        while ( level.player usebuttonpressed() )
                        {
                            waitframe();
                        }
                        
                        if ( isdefined( interact_delay ) )
                        {
                            wait interact_delay;
                        }
                    }
                }
                
                continue;
            }
            
            if ( isdefined( level.player.veh ) && level.player.veh == self )
            {
                if ( level.player usebuttonpressed() )
                {
                    level.player [[ exitcallback ]]( self );
                    self.driver = undefined;
                    level.player.veh = undefined;
                    
                    while ( level.player usebuttonpressed() )
                    {
                        waitframe();
                    }
                    
                    if ( isdefined( interact_delay ) )
                    {
                        wait interact_delay;
                    }
                }
            }
        }
    }
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x1203
// Size: 0x1a
function function_32f7de64be76262()
{
    if ( isdefined( self.damagestate ) )
    {
        return self.damagestate;
    }
    
    return undefined;
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x1226
// Size: 0x26, Type: bool
function function_a59f81db0ddb38c2()
{
    if ( isdefined( self.damagestate ) && self.damagestate == "damageHeavy" )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x1255
// Size: 0xa0
function vehicle_kill( inflictor )
{
    if ( istrue( self.godmode ) || istrue( self.demigodmode ) )
    {
        /#
            print( "<dev string:x1c>" );
        #/
        
        return;
    }
    
    damage = self.healthstarting * 2;
    self dodamage( damage, self.origin, inflictor, undefined, "MOD_EXECUTION" );
    
    if ( isdefined( level.player.veh ) && self == level.player.veh )
    {
        setomnvar( "ui_veh_health_percent", 0 );
    }
}

// Namespace vehicle / scripts\common\vehicle
// Params 3
// Checksum 0x0, Offset: 0x12fd
// Size: 0x6a
function vehicle_damage( amount, inflictor, mod )
{
    if ( istrue( self.godmode ) || istrue( self.demigodmode ) )
    {
        /#
            print( "<dev string:x4e>" );
        #/
        
        return;
    }
    
    mod = default_to( mod, undefined );
    self dodamage( amount, self.origin, inflictor, undefined, mod );
    function_89cec1224ae724d5();
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x136f
// Size: 0x91
function function_af11cc0c8dc23332( inflictor )
{
    if ( istrue( self.godmode ) || istrue( self.demigodmode ) )
    {
        /#
            print( "<dev string:x81>" );
        #/
        
        return;
    }
    
    burndownhealth = self.healthstarting * 0.3 - 1 + self.healthbuffer;
    burndowndamage = self.health - burndownhealth;
    
    if ( burndowndamage > 1 )
    {
        self dodamage( burndowndamage, self.origin, inflictor, undefined, "MOD_EXECUTION" );
    }
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x1408
// Size: 0xc, Type: bool
function isvehiclehusk()
{
    return istrue( self.isvehiclehusk );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x141d
// Size: 0x30, Type: bool
function isvehiclealive()
{
    if ( isvehicle() || isdefined( self.code_classname ) && self.code_classname == "script_vehicle" )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x1456
// Size: 0x25
function function_f6f26f5b1c244d5( scale )
{
    assertex( isdefined( scale ), "Need to define a scale!" );
    self.var_1de5acbb26e97918 = scale;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x1483
// Size: 0x25
function function_2c8c048d81431d8b( scale )
{
    assertex( isdefined( scale ), "Need to define a scale!" );
    self.var_bd79128b30a2dfb2 = scale;
}

// Namespace vehicle / scripts\common\vehicle
// Params 2
// Checksum 0x0, Offset: 0x14b0
// Size: 0x69
function vehicle_sethealth( amount, resetstarting )
{
    if ( !isdefined( self.healthbuffer ) )
    {
        self.healthbuffer = 0;
    }
    
    amount = int( amount + self.healthbuffer );
    self.health = amount;
    self.healthactual = amount;
    
    if ( istrue( resetstarting ) )
    {
        self.healthstarting = amount - self.healthbuffer;
    }
}

// Namespace vehicle / scripts\common\vehicle
// Params 2
// Checksum 0x0, Offset: 0x1521
// Size: 0x79
function vehicle_addhealth( amount, resetstarting )
{
    amount = int( amount );
    
    if ( !isdefined( self.healthbuffer ) )
    {
        self.healthbuffer = 0;
    }
    
    self.health += amount;
    self.healthactual = self.health;
    
    if ( istrue( resetstarting ) )
    {
        self.healthstarting = self.health - self.healthbuffer;
    }
}

// Namespace vehicle / scripts\common\vehicle
// Params 2
// Checksum 0x0, Offset: 0x15a2
// Size: 0x90
function function_c8a94acef0beb362( amount, resetstarting )
{
    amount = int( amount );
    
    if ( !isdefined( self.healthbuffer ) )
    {
        self.healthbuffer = 0;
    }
    
    if ( amount >= self.health )
    {
        vehicle_kill( level );
        return;
    }
    
    self.health -= amount;
    self.healthactual = self.health;
    
    if ( istrue( resetstarting ) )
    {
        self.healthstarting = self.health - self.healthbuffer;
    }
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x163a
// Size: 0x15
function function_79a6e6e740893346()
{
    return self.healthactual - self.healthbuffer;
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x1658
// Size: 0x1f
function function_6cbb869150e32086()
{
    return ( self.healthactual - self.healthbuffer ) / self.healthstarting;
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x1680
// Size: 0xc, Type: bool
function function_9e9dfc6f77569f4d()
{
    return istrue( self.demigodmode );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x1695
// Size: 0xc, Type: bool
function function_d7fe44ffb08b499a()
{
    return istrue( self.godmode );
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x16aa
// Size: 0x15
function function_7b7412ddbeed1f41( bool )
{
    self.var_653c58271b7da4c9 = bool;
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x16c7
// Size: 0xc, Type: bool
function function_34a2eb36fbca6e89()
{
    return istrue( self.var_653c58271b7da4c9 );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x16dc
// Size: 0x32
function function_27f6984d596866bf()
{
    classname = get_vehicle_classname();
    return level.vehicle.templates.hudindex[ classname ];
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x1717
// Size: 0x2d
function function_65976a53a9cbd110()
{
    if ( isdefined( function_27f6984d596866bf() ) )
    {
        setomnvar( "ui_veh_vehicle", function_27f6984d596866bf() );
        return;
    }
    
    setomnvar( "ui_veh_vehicle", 2 );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x174c
// Size: 0x18
function function_37f33bfe6b63cb0a()
{
    level.player setclientomnvar( "ui_veh_vehicle", -1 );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x176c
// Size: 0x13d
function function_89cec1224ae724d5()
{
    if ( !isdefined( level.player ) )
    {
        return;
    }
    
    if ( !isdefined( level.player.veh ) )
    {
        return;
    }
    
    if ( self != level.player.veh )
    {
        if ( !isdefined( level.player.leanout_vehicle ) )
        {
            return;
        }
        
        if ( !is_equal( self, level.player.leanout_vehicle ) )
        {
            return;
        }
    }
    
    healthpercentage = function_6cbb869150e32086();
    
    if ( healthpercentage < 0 )
    {
        setomnvar( "ui_veh_health_percent", int( 0 ) );
    }
    else
    {
        setomnvar( "ui_veh_health_percent", int( healthpercentage * 100 ) );
    }
    
    if ( isdefined( self.var_488f0fc49178c96 ) )
    {
        level.player setclientomnvar( "ui_veh_flat_tire_mask", self.var_488f0fc49178c96 );
    }
    else
    {
        level.player setclientomnvar( "ui_veh_flat_tire_mask", 0 );
    }
    
    if ( isdefined( self.ui_warning ) )
    {
        level.player setclientomnvarbit( "ui_veh_warning", 1, self.ui_warning );
        return;
    }
    
    level.player setclientomnvarbit( "ui_veh_warning", 1, 0 );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x18b1
// Size: 0x1a
function function_2f026409116444()
{
    level.player setclientomnvarbit( "ui_veh_warning", 1, 1 );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x18d3
// Size: 0x1e
function function_9fb6b2244163f2a1()
{
    if ( !isdefined( self.blowntires ) )
    {
        return [];
    }
    
    return self.blowntires;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x18f9
// Size: 0x3d, Type: bool
function function_9b915d163f6d1d5a( part )
{
    if ( isdefined( self.damageableparts ) && isdefined( self.damageableparts[ part ] ) && self.damageableparts[ part ] > 0 )
    {
        return true;
    }
    
    return false;
}

#using_animtree( "vehicles" );

// Namespace vehicle / scripts\common\vehicle
// Params 2
// Checksum 0x0, Offset: 0x193f
// Size: 0x10e
function function_97cbee6be1660a84( animation, husk )
{
    vehicle = self;
    self.skiplaunch = 1;
    
    if ( !isdefined( husk ) )
    {
        husk = 1;
    }
    
    if ( istrue( husk ) && !ismp() && !iscp() )
    {
        vehicle = scripts\common\vehicle_code::function_18657584b6bd786a( 0 );
        vehicle useanimtree( #animtree );
    }
    
    if ( !vehicle hascomponent( "animator" ) )
    {
        vehicle addcomponent( "animator" );
        vehicle setconfigvalue( "animator", "keyframed", 0 );
    }
    
    vehicle animscripted( "crash_anim_finished", vehicle.origin, vehicle.angles, animation, undefined, undefined, 0.2, 1 );
    vehicle vehphys_crash();
    
    if ( vehicle hascomponent( "p2p" ) )
    {
        vehicle setconfigvalue( "p2p", "pause", 1 );
    }
    
    if ( vehicle hascomponent( "path" ) )
    {
        vehicle setconfigvalue( "path", "pause", 1 );
    }
    
    vehicle waittillmatch( "crash_anim_finished", "end" );
}

// Namespace vehicle / scripts\common\vehicle
// Params 2
// Checksum 0x0, Offset: 0x1a55
// Size: 0xa6
function function_a0f7306fc3c08ecf( vehicle, var_d5a3f788ef786063 )
{
    inoobtrigger = 0;
    
    if ( isdefined( vehicle.oob ) )
    {
        inoobtrigger = 1;
    }
    
    if ( !istrue( inoobtrigger ) && istrue( var_d5a3f788ef786063 ) )
    {
        oobtriggers = level.outofboundstriggers;
        
        foreach ( trigger in oobtriggers )
        {
            if ( vehicle istouching( trigger ) )
            {
                inoobtrigger = 1;
                break;
            }
        }
    }
    
    return inoobtrigger;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x1b04
// Size: 0x6c
function function_9039b650ffb212c8( str )
{
    if ( !isdefined( str ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_d43e78e513933216 ) )
    {
        level.var_d43e78e513933216 = [];
    }
    
    if ( !isdefined( level.var_d43e78e513933216[ function_3db00f01cdba4538( "tag_origin" ) ] ) )
    {
        level.var_d43e78e513933216[ function_3db00f01cdba4538( "tag_origin" ) ] = "tag_origin";
    }
    
    level.var_d43e78e513933216[ function_3db00f01cdba4538( str ) ] = str;
}

// Namespace vehicle / scripts\common\vehicle
// Params 1
// Checksum 0x0, Offset: 0x1b78
// Size: 0x34
function function_8ed0ffa3f8be7c75( xhash )
{
    if ( !isdefined( level.var_d43e78e513933216 ) )
    {
        return "";
    }
    
    return default_to( level.var_d43e78e513933216[ xhash ], "" );
}

// Namespace vehicle / scripts\common\vehicle
// Params 0
// Checksum 0x0, Offset: 0x1bb5
// Size: 0x3e
function codecallback_vehiclespawned()
{
    if ( isdefined( level.vehicle ) && isdefined( level.vehicle.onvehiclespawned ) )
    {
        self [[ level.vehicle.onvehiclespawned ]]();
    }
}

