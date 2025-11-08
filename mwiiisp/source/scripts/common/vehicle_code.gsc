#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_lights;
#using scripts\common\vehicle_paths;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\vehicle\vehicle_common;

#namespace vehicle_code;

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x1364
// Size: 0xbf6
function vehicle_initlevelvariables()
{
    setdvarifuninitialized( @"hash_9403d7d31fc1d981", 1 );
    setdvarifuninitialized( @"hash_fb816855f6554343", 0 );
    setdvarifuninitialized( @"hash_80e8717f617516cf", 0 );
    setdvarifuninitialized( @"hash_9cdcaf7a53494c37", 0 );
    setdvarifuninitialized( @"hash_cfd8073837710cef", 0 );
    setdvarifuninitialized( @"hash_a56728daa842e5e", 0 );
    setdvarifuninitialized( @"hash_f0f3e5a83f3f2843", 1 );
    setdvarifuninitialized( @"hash_7598045ee90e851d", 1 );
    setdvarifuninitialized( @"hash_4bd69b09131419ca", 1 );
    setdvarifuninitialized( @"hash_3a76c9f686d280fc", 0 );
    
    if ( utility::issp() )
    {
        setsaveddvar( @"movingplatformcinematicmotion", 1 );
        setsaveddvar( @"hash_b2b4f1e1cf04437f", 1 );
    }
    
    if ( !isdefined( level.vehicle ) )
    {
        level.vehicle = spawnstruct();
    }
    
    level.vehicle.templates = spawnstruct();
    level.vehicle.helicopter_crash_locations = getentarray( "helicopter_crash_location", "targetname" );
    level.vehicle.helicopter_crash_locations = array_combine( level.vehicle.helicopter_crash_locations, getstructarray_delete( "helicopter_crash_location", "targetname" ) );
    level.vehicle.templates.team = [];
    level.vehicle.templates.deathmodel = [];
    level.vehicle.templates.death_thread = [];
    level.vehicle.templates.driveidle = [];
    level.vehicle.templates.driveidle_r = [];
    level.vehicle.templates.rumble = [];
    level.vehicle.templates.mainturret = [];
    level.vehicle.templates.mgturret = [];
    level.vehicle.templates.death_earthquake = [];
    level.vehicle.templates.surface_effects = [];
    level.vehicle.templates.unloadgroups = [];
    level.vehicle.templates.aianims = [];
    level.vehicle.templates.landanims = [];
    level.vehicle.templates.exhaust_fx = [];
    level.vehicle.templates.engine_fx = [];
    level.vehicle.templates.shoot_shock = [];
    level.vehicle.templates.hide_part_list = [];
    level.vehicle.templates.destructible_model = [];
    level.vehicle.templates.grenade_shield = [];
    level.vehicle.templates.var_7412ca7553957e74 = [];
    level.vehicle.templates.bullet_shield = [];
    level.vehicle.templates.collision_shield = [];
    level.vehicle.templates.death_jolt = [];
    level.vehicle.templates.death_badplace = [];
    level.vehicle.templates.idle_anim = [];
    level.vehicle.templates.helicopter_list = [];
    level.vehicle.templates.boat_list = [];
    level.vehicle.templates.airplane_list = [];
    level.vehicle.templates.tank_list = [];
    level.vehicle.templates.single_tread_list = [];
    level.vehicle.templates.deathanimations = [];
    level.vehicle.templates.vehicle_death_fx = [];
    level.vehicle.templates.vehicle_rocket_death_fx = [];
    level.vehicle.templates.death_radiusdamage = [];
    level.vehicle.templates.model = [];
    level.vehicle.templates.husk = [];
    level.vehicle.templates.var_893da51cf12b2c8b = [];
    level.vehicle.templates.iw9physics = [];
    level.vehicle.templates.hudindex = [];
    level.vehicle.templates.dependentparts = [];
    level.vehicle.damageableparts = [];
    
    if ( utility::issp() )
    {
        level.vehicle.damageableparts[ "tag_mirror_left" ] = 3;
        level.vehicle.damageableparts[ "tag_mirror_right" ] = 3;
        level.vehicle.damageableparts[ "tag_light_front_left" ] = 3;
        level.vehicle.damageableparts[ "tag_light_front_right" ] = 3;
        level.vehicle.damageableparts[ "tag_light_front_left_2" ] = 3;
        level.vehicle.damageableparts[ "tag_light_front_right_2" ] = 3;
        level.vehicle.damageableparts[ "tag_light_back_left" ] = 3;
        level.vehicle.damageableparts[ "tag_light_back_right" ] = 3;
        level.vehicle.damageableparts[ "tag_light_back_left_2" ] = 3;
        level.vehicle.damageableparts[ "tag_light_back_right_2" ] = 3;
        level.vehicle.damageableparts[ "tag_light_top_left" ] = 3;
        level.vehicle.damageableparts[ "tag_light_top_right" ] = 3;
        level.vehicle.damageableparts[ "tag_light_front_middle" ] = 3;
        level.vehicle.damageableparts[ "tag_light_front_top" ] = 3;
        level.vehicle.damageableparts[ "tag_light_back_top" ] = 3;
        level.vehicle.damageableparts[ "tag_antenna" ] = 3;
        level.vehicle.damageableparts[ "tag_hubcap_front_left" ] = 3;
        level.vehicle.damageableparts[ "tag_hubcap_front_right" ] = 3;
        level.vehicle.damageableparts[ "tag_hubcap_back_left" ] = 3;
        level.vehicle.damageableparts[ "tag_hubcap_back_right" ] = 3;
        level.vehicle.damageableparts[ "tag_windshield_front" ] = 5;
        level.vehicle.damageableparts[ "tag_windshield_front_pristine" ] = 5;
        level.vehicle.damageableparts[ "tag_windshield_front_web" ] = 5;
        level.vehicle.damageableparts[ "tag_windshield_back" ] = 5;
        level.vehicle.damageableparts[ "tag_window_front_left" ] = 5;
        level.vehicle.damageableparts[ "tag_window_front_right" ] = 5;
        level.vehicle.damageableparts[ "tag_window_back_left" ] = 5;
        level.vehicle.damageableparts[ "tag_window_back_right" ] = 5;
        level.vehicle.damageableparts[ "tag_window_back_left_corner" ] = 5;
        level.vehicle.damageableparts[ "tag_window_back_right_corner" ] = 5;
        level.vehicle.damageableparts[ "tag_window_sunroof" ] = 5;
        level.vehicle.damageableparts[ "tag_door_front_left" ] = 5;
        level.vehicle.damageableparts[ "tag_door_front_right" ] = 5;
        level.vehicle.damageableparts[ "tag_door_back_left" ] = 5;
        level.vehicle.damageableparts[ "tag_door_back_right" ] = 5;
        level.vehicle.damageableparts[ "tag_hood" ] = 5;
        level.vehicle.damageableparts[ "tag_trunk" ] = 5;
        level.vehicle.damageableparts[ "tag_bumper_front" ] = 5;
        level.vehicle.damageableparts[ "tag_bumper_back" ] = 5;
        level.vehicle.damageableparts[ "tag_bumper_front_damaged" ] = 5;
        level.vehicle.damageableparts[ "tag_bumper_back_damaged" ] = 5;
        level.vehicle.damageableparts[ "tag_wheel_center_front_left" ] = 3;
        level.vehicle.damageableparts[ "tag_wheel_center_front_right" ] = 3;
        level.vehicle.damageableparts[ "tag_wheel_center_middle_left" ] = 3;
        level.vehicle.damageableparts[ "tag_wheel_center_middle_right" ] = 3;
        level.vehicle.damageableparts[ "tag_wheel_center_back_left" ] = 3;
        level.vehicle.damageableparts[ "tag_wheel_center_back_right" ] = 3;
        level.vehicle.damageableparts[ "tag_wheel_spare" ] = 3;
        
        foreach ( _ in level.vehicle.damageableparts )
        {
            scripts\common\vehicle::function_9039b650ffb212c8( name );
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1f62
// Size: 0x3b
function private addhealth( amount )
{
    if ( amount < 0 )
    {
        /#
            print( "<dev string:x1c>" + amount );
        #/
        
        return;
    }
    
    self.health += int( amount );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1fa5
// Size: 0xc2, Type: bool
function private isexplosivedamage( mod, objweapon )
{
    if ( isdefined( objweapon ) && isdefined( objweapon.basename ) )
    {
        switch ( objweapon.basename )
        {
            case #"hash_734c65fd451709ec":
            case #"hash_b347bbcd9d4a348d":
                if ( getdvarint( @"hash_cfd8073837710cef" ) )
                {
                    iprintln( "skipping explosive damage for weapon: " + objweapon.basename );
                }
                
                return false;
        }
    }
    
    if ( mod == "MOD_GRENADE_SPLASH" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_GRENADE" || mod == "MOD_PROJECTILE" || mod == "MOD_EXPLOSIVE" )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2070
// Size: 0x31, Type: bool
function private function_2cffaf4e15c4ab48( weaponname )
{
    if ( !isdefined( self.var_11bd2d454480b300 ) )
    {
        return false;
    }
    
    if ( array_contains( self.var_11bd2d454480b300, weaponname ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x20aa
// Size: 0xf9
function _getvehiclespawnerarray( value, key )
{
    /#
        if ( isdefined( value ) || isdefined( key ) )
        {
            assertex( isdefined( value ) && isdefined( key ), "<dev string:x46>" );
        }
    #/
    
    newarray = [];
    
    if ( isdefined( value ) && isdefined( key ) )
    {
        check_classname = 1;
        vehicles = getentarray( value, key );
    }
    else
    {
        check_classname = 0;
        vehicles = getentarray( "script_vehicle", "code_classname" );
    }
    
    foreach ( vehicle in vehicles )
    {
        if ( check_classname && vehicle.code_classname != "script_vehicle" )
        {
            continue;
        }
        
        if ( isspawner( vehicle ) )
        {
            newarray[ newarray.size ] = vehicle;
        }
    }
    
    return newarray;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x21ac
// Size: 0x59
function _kill_fx_play_direction( attackdir, lerp )
{
    if ( isdefined( attackdir ) && isdefined( lerp ) )
    {
        velocity = self getentityvelocity();
        velocity = vectornormalize( velocity );
        attackdir = vectornormalize( attackdir );
        dir = vectorlerp( velocity, attackdir, lerp );
        return dir;
    }
    
    return undefined;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x220d
// Size: 0x2a
function _mainturretoff()
{
    self.script_turretmain = 0;
    
    if ( !isdefined( self.mainturret ) )
    {
        return;
    }
    
    _turretoffshared( self.mainturret );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x223f
// Size: 0x2b
function _mainturreton()
{
    self.script_turretmain = 1;
    
    if ( !isdefined( self.mainturret ) )
    {
        return;
    }
    
    _turretonshared( self.mainturret );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x2272
// Size: 0xb2
function _mgoff()
{
    self.script_turretmg = 0;
    
    if ( ishelicopter() && hashelicopterturret() )
    {
        if ( isdefined( level.chopperturretfunc ) )
        {
            assertex( isdefined( level.chopperturretofffunc ), "hasHelicopterTurret with no level.ChopperTurretOnFunc, need scriptssphelicopter_globals::init_helicopters();" );
            self thread [[ level.chopperturretofffunc ]]();
            return;
        }
    }
    
    if ( !isdefined( self.mgturret ) )
    {
        return;
    }
    
    foreach ( turret in self.mgturret )
    {
        _turretoffshared( turret );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x232c
// Size: 0xad
function _mgon()
{
    self.script_turretmg = 1;
    
    if ( ishelicopter() && hashelicopterturret() )
    {
        assertex( isdefined( level.chopperturretonfunc ), "hasHelicopterTurret with no level.ChopperTurretOnFunc, need scriptssphelicopter_globals::init_helicopters();" );
        self thread [[ level.chopperturretonfunc ]]();
        return;
    }
    
    if ( !isdefined( self.mgturret ) )
    {
        return;
    }
    
    foreach ( turret in self.mgturret )
    {
        turret show();
        _turretonshared( turret );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x23e1
// Size: 0x33
function _turretoffshared( turret )
{
    if ( isdefined( turret.script_fireondrones ) )
    {
        turret.script_fireondrones = 0;
    }
    
    turret setmode( "manual" );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x241c
// Size: 0x74
function _turretonshared( turret )
{
    if ( isdefined( turret.script_fireondrones ) )
    {
        turret.script_fireondrones = 1;
    }
    
    if ( isdefined( turret.defaultonmode ) )
    {
        if ( turret.defaultonmode != "sentry" )
        {
            turret setmode( turret.defaultonmode );
        }
    }
    else
    {
        turret setmode( "auto_nonai" );
    }
    
    set_turret_team( turret );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x2498
// Size: 0x48
function _setvehgoalpos_wrap( origin, bstop )
{
    if ( self.health <= 0 )
    {
        return;
    }
    
    if ( isdefined( self.originheightoffset ) )
    {
        origin += ( 0, 0, self.originheightoffset );
    }
    
    self setvehgoalpos( origin, bstop );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x24e8
// Size: 0xb2
function _vehicle_landvehicle( neargoal, node )
{
    self endon( "death" );
    self notify( "newpath" );
    
    if ( !isdefined( neargoal ) )
    {
        neargoal = 2;
    }
    
    self setneargoalnotifydist( neargoal );
    self sethoverparams( 0, 0, 0 );
    self cleargoalyaw();
    self settargetyaw( flat_angle( self.angles )[ 1 ] );
    
    if ( isdefined( self.unload_land_offset ) )
    {
        _setvehgoalpos_wrap( utility::groundpos( self.origin ) + ( 0, 0, self.unload_land_offset ), 1 );
    }
    else
    {
        _setvehgoalpos_wrap( utility::groundpos( self.origin ), 1 );
    }
    
    self waittill( "goal" );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x25a2
// Size: 0x4bf
function _vehicle_unload( who )
{
    self endon( "death" );
    
    if ( isdefined( who ) )
    {
        self.unload_group = who;
    }
    
    if ( isdefined( self.var_e477b04ae71253d8 ) )
    {
        result = self [[ self.var_e477b04ae71253d8 ]]();
        
        if ( isdefined( result ) )
        {
            return result;
        }
    }
    
    if ( isdefined( level.func[ "vehicle_unload" ] ) )
    {
        result = self [[ level.func[ "vehicle_unload" ] ]]();
        
        if ( isdefined( result ) )
        {
            return result;
        }
    }
    
    if ( ent_flag_exist( "no_riders_until_unload" ) )
    {
        ent_flag_set( "no_riders_until_unload" );
        ai = spawn_unload_group( self.unload_group );
        
        foreach ( a in ai )
        {
            spawn_failed( a );
        }
        
        waittillframeend();
    }
    
    self notify( "unloading" );
    ai = [];
    unloadgroups = level.vehicle.templates.unloadgroups[ get_vehicle_classname() ];
    
    if ( isdefined( unloadgroups ) )
    {
        unloadgroup = get_unload_group();
        
        if ( istrue( self.vehiclesetuprope ) )
        {
            for ( i = 0; i < level.vehicle.templates.aianims[ get_vehicle_classname() ].size ; i++ )
            {
                animpos = level.vehicle.templates.aianims[ get_vehicle_classname() ][ i ];
                
                if ( istrue( animpos.setuprope ) )
                {
                    usingrope = 0;
                    
                    foreach ( rider in self.riders )
                    {
                        if ( isdefined( rider.vehicle_position ) && isdefined( unloadgroup[ rider.vehicle_position ] ) && rider.vehicle_position != i )
                        {
                            rideranimpos = anim_pos( self, rider.vehicle_position );
                            
                            if ( rideranimpos.fastroperig == animpos.fastroperig )
                            {
                                usingrope = 1;
                                break;
                            }
                        }
                    }
                    
                    if ( usingrope )
                    {
                        foreach ( rider in self.riders )
                        {
                            if ( isalive( rider ) && isdefined( rider.vehicle_position ) && rider.vehicle_position == i )
                            {
                                scripts\common\vehicle_aianim::guy_setup_rope( rider, animpos );
                                break;
                            }
                        }
                    }
                }
            }
        }
        
        var_3f5e5ee34d09efdd = 0;
        
        foreach ( rider in self.riders )
        {
            if ( isalive( rider ) && isdefined( rider.vehicle_position ) && isdefined( unloadgroup[ rider.vehicle_position ] ) )
            {
                if ( isdefined( level.vehicle.aianimcheck[ "unload" ] ) && ![[ level.vehicle.aianimcheck[ "unload" ] ]]( rider, rider.vehicle_position ) )
                {
                    continue;
                }
                
                animpos = anim_pos( self, rider.vehicle_position );
                
                if ( isdefined( animpos ) && istrue( animpos.do_not_unload ) )
                {
                    continue;
                }
                
                if ( isdefined( level.vehicle.aianimthread[ "unload" ] ) )
                {
                    if ( !istrue( animpos.setuprope ) )
                    {
                        rider notify( "newanim" );
                        thread [[ level.vehicle.aianimthread[ "unload" ] ]]( rider, rider.vehicle_position );
                        var_3f5e5ee34d09efdd = 1;
                        rider notify( "unload" );
                        rider.vehicle = undefined;
                        
                        if ( isdefined( animpos.mgturret ) )
                        {
                            rider scripts\common\ai::stop_use_turret();
                        }
                        
                        ai = array_add( ai, rider );
                    }
                }
            }
        }
        
        if ( !var_3f5e5ee34d09efdd )
        {
            scripts\engine\utility::ent_flag_set( "unloaded" );
        }
    }
    
    return ai;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x2a6a
// Size: 0x4e4
function vehicle_spawn_internal( vspawner, var_a7333fc35fb3cc3a )
{
    if ( isdefined( vspawner.script_delay_spawn ) )
    {
        vspawner endon( "death" );
        wait vspawner.script_delay_spawn;
    }
    
    assertex( !isdefined( vspawner.vehicle_spawned_thisframe ), "spawning two vehicles on one spawner on the same frame is not allowed" );
    nonentspawner = 0;
    
    if ( !issp() )
    {
        vehicle = vehicle_spawn_mp_internal( vspawner );
    }
    else
    {
        targetname = default_to( vspawner.targetname, "" );
        model = vspawner function_d0e99a4f0c29166e();
        
        if ( isdefined( vspawner.var_ae43938336bbd264 ) )
        {
            array = strtok( vspawner.var_ae43938336bbd264, "," );
            color = array[ randomintrange( 0, array.size ) ];
            
            if ( color != "base" )
            {
                model = color + "::" + model;
            }
        }
        
        vehicletype = vspawner.vehicletype;
        
        if ( getdvarint( @"hash_a56728daa842e5e" ) && isdefined( level.vehicle.templates.iw9physics[ vspawner.classname ] ) )
        {
            vehicletype = level.vehicle.templates.iw9physics[ vspawner.classname ];
        }
        
        vehicle = spawnvehicle( model, targetname, vehicletype, vspawner.origin, vspawner.angles );
        assert( isdefined( vehicle ) );
        vehicle.classname_mp = vspawner.classname;
        
        if ( isdefined( vspawner.spawnflags ) && vspawner.spawnflags & 16 )
        {
            vehicle.isstationary = 1;
        }
        
        if ( isdefined( vspawner.spawnflags ) && vspawner.spawnflags & 4 )
        {
            husk = vehicle function_18657584b6bd786a( 1 );
            return husk;
        }
        
        if ( isdefined( vspawner.spawnflags ) )
        {
            if ( vspawner.spawnflags & 1 )
            {
                vehicle thread script_func( "vehicle_usable" );
            }
            
            if ( vspawner.spawnflags & 8 || istrue( vehicle.isstationary ) )
            {
                vehicle vehphys_parkingbrake( 1 );
            }
        }
        
        if ( isdefined( vspawner.target ) )
        {
            vehicle.target = vspawner.target;
        }
        
        if ( isdefined( vspawner.script_noteworthy ) )
        {
            vehicle.script_noteworthy = vspawner.script_noteworthy;
        }
        
        if ( isdefined( vspawner.script_parameters ) )
        {
            vehicle.script_parameters = vspawner.script_parameters;
        }
        
        if ( isdefined( vspawner.script_linkto ) )
        {
            vehicle.script_linkto = vspawner.script_linkto;
        }
        
        if ( isdefined( vspawner.script_godmode ) )
        {
            vehicle.script_godmode = vspawner.script_godmode;
        }
        
        if ( isdefined( vspawner.script_index ) )
        {
            vehicle.script_index = vspawner.script_index;
        }
        
        if ( isdefined( vspawner.script_friendname ) )
        {
            vehicle.script_friendname = vspawner.script_friendname;
        }
        
        if ( isdefined( vspawner.script_dontunloadonend ) )
        {
            vehicle.script_dontunloadonend = vspawner.script_dontunloadonend;
        }
        
        if ( isdefined( vspawner.script_deathflag ) )
        {
            vehicle.script_deathflag = vspawner.script_deathflag;
        }
        
        if ( isdefined( vspawner.script_team ) )
        {
            vehicle.script_team = vspawner.script_team;
        }
        
        if ( isdefined( vspawner.script_delete ) )
        {
            vehicle.script_delete = vspawner.script_delete;
        }
        
        if ( isdefined( vspawner.script_vehicle_selfremove ) )
        {
            vehicle.script_vehicle_selfremove = vspawner.script_vehicle_selfremove;
        }
        
        if ( isdefined( vspawner.script_vehicle_lights_on ) )
        {
            vehicle.script_vehicle_lights_on = vspawner.script_vehicle_lights_on;
        }
    }
    
    assert( isdefined( vehicle ) );
    
    if ( !isdefined( vspawner.spawned_count ) )
    {
        vspawner.spawned_count = 0;
    }
    
    vspawner.spawned_count++;
    vspawner.last_spawned_vehicle = vehicle;
    vehicle.vehicle_spawner = vspawner;
    thread vehicle_init( vehicle, var_a7333fc35fb3cc3a );
    vspawner notify( "spawned", vehicle );
    return vehicle;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x2f57
// Size: 0xf1
function vehicle_spawn_mp_internal( vspawner )
{
    targetname = "temp_vehicle_targetname";
    
    if ( isdefined( vspawner.targetname ) )
    {
        targetname = vspawner.targetname;
    }
    
    if ( !isdefined( vspawner.classname_mp ) )
    {
        classname_mp = vspawner.classname;
    }
    else
    {
        classname_mp = vspawner.classname_mp;
    }
    
    vehicle = spawnvehicle( level.vehicle.templates.model[ classname_mp ], targetname, vspawner.vehicletype, vspawner.origin, vspawner.angles );
    vehicle.classname_mp = classname_mp;
    
    if ( isdefined( vspawner.target ) )
    {
        vehicle.target = vspawner.target;
    }
    
    return vehicle;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x3051
// Size: 0x35
function vehicle_setuplevelvariables()
{
    if ( !add_init_script( "vehicle_vars", &vehicle_setuplevelvariables ) )
    {
        return;
    }
    
    init_struct_class();
    vehicle_initlevelvariables();
    
    /#
        init_vehicle_spawner_devgui();
    #/
    
    scripts\common\vehicle_aianim::setup_aianimthreads();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x308e
// Size: 0x239
function vehicle_precachescripts()
{
    allvehiclesprespawn = [];
    level.needsprecaching = [];
    
    if ( !isdefined( level.vehicleinitthread ) )
    {
        level.vehicleinitthread = [];
    }
    
    vehicles = getentarray( "script_vehicle", "code_classname" );
    
    foreach ( vehicle in vehicles )
    {
        if ( vehicle.vehicletype == "empty" || vehicle.vehicletype == "empty_heli" )
        {
            continue;
        }
        
        allvehiclesprespawn[ allvehiclesprespawn.size ] = vehicle;
        vehicle_precachesetup( vehicle.classname, vehicle );
    }
    
    if ( level.needsprecaching.size > 0 )
    {
        /#
            println( "<dev string:x68>" );
            println( "<dev string:xbe>" );
            println( "<dev string:x68>" );
            tab = "<dev string:x114>";
            
            foreach ( reasons in level.needsprecaching )
            {
                println( index );
                
                foreach ( reason in reasons )
                {
                    println( tab + reason.pos );
                    
                    foreach ( r in reason.reasons )
                    {
                        println( tab + tab + r );
                    }
                }
            }
            
            println( "<dev string:x68>" );
        #/
        
        assertex( 0, "missing vehicle scripts, see above console prints" );
        level waittill( "never" );
    }
    
    return allvehiclesprespawn;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x32d0
// Size: 0x16b
function vehicle_precachesetup( classname, vehicle )
{
    vehicletype = getxhashasset( vehicle.vehicletype );
    
    if ( isdefined( level.vehicleinitthread[ vehicletype ] ) && isdefined( level.vehicleinitthread[ vehicletype ][ vehicle.classname ] ) )
    {
        return;
    }
    
    if ( vehicle.classname == "script_vehicle" )
    {
        return;
    }
    
    reasons = [];
    
    if ( isdefined( level.needsprecaching[ classname ] ) )
    {
        reasons = level.needsprecaching[ classname ];
    }
    
    struct = spawnstruct();
    struct.pos = vehicle.origin;
    struct.reasons = [];
    
    if ( !isdefined( level.vehicleinitthread[ vehicletype ] ) )
    {
        struct.reasons[ struct.reasons.size ] = "vehicletype \"" + vehicle.vehicletype + "\" is not setup properly. Maybe you just need to re-package? Or you have a Radiant copy/paste issue where you have the wrong vehicletype set?";
    }
    else if ( !isdefined( level.vehicleinitthread[ vehicletype ][ vehicle.classname ] ) )
    {
        struct.reasons[ struct.reasons.size ] = "classname \"" + vehicle.classname + "\"  is not setup properly. Maybe you just need to re-package? Or the vehicle's Quaked is not setup properly";
    }
    
    reasons[ reasons.size ] = struct;
    level.needsprecaching[ classname ] = reasons;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x3443
// Size: 0x2b8
function vehicle_setupspawners()
{
    spawners = _getvehiclespawnerarray();
    
    foreach ( spawner in spawners )
    {
        spawner thread vehicle_spawnerlogic();
        model = spawner function_d0e99a4f0c29166e();
        
        if ( isdefined( spawner.var_ae43938336bbd264 ) && isdefined( model ) )
        {
            array = strtok( spawner.var_ae43938336bbd264, "," );
            
            for ( i = 0; i < array.size ; i++ )
            {
                if ( array[ i ] == "base" )
                {
                    precachemodel( model );
                    continue;
                }
                
                precachemodel( array[ i ] + "::" + model );
            }
            
            if ( isdefined( level.vehicle.templates.husk[ model ] ) )
            {
                for ( i = 0; i < array.size ; i++ )
                {
                    if ( array[ i ] == "base" )
                    {
                        precachemodel( level.vehicle.templates.husk[ model ] );
                        continue;
                    }
                    
                    if ( istrue( level.vehicle.templates.var_893da51cf12b2c8b[ model ] ) )
                    {
                        precachemodel( array[ i ] + "::" + level.vehicle.templates.husk[ model ] );
                    }
                }
            }
            
            if ( isdefined( level.vehicle.templates.mgturret[ spawner.classname ] ) )
            {
                for ( i = 0; i < array.size ; i++ )
                {
                    if ( array[ i ] != "base" )
                    {
                        precachemodel( array[ i ] + "::" + level.vehicle.templates.mgturret[ spawner.classname ][ 0 ].model );
                    }
                }
            }
            
            if ( isdefined( level.vehicle.templates.mainturret[ spawner.classname ] ) )
            {
                for ( i = 0; i < array.size ; i++ )
                {
                    if ( array[ i ] != "base" )
                    {
                        precachemodel( array[ i ] + "::" + level.vehicle.templates.mainturret[ spawner.classname ].model );
                    }
                }
            }
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x3703
// Size: 0xb3
function vehicle_spawnerlogic()
{
    self endon( "entitydeleted" );
    
    if ( isdefined( self.script_deathflag ) )
    {
        thread script_func( "vehicle_spawner_deathflag" );
    }
    
    self.count = 1;
    self.spawn_functions = [];
    
    while ( true )
    {
        self waittill( "spawned", vehicle );
        self.count--;
        
        if ( !isdefined( vehicle ) )
        {
            println( "<dev string:x119>" + self.origin + "<dev string:x13a>" );
            continue;
        }
        
        vehicle.spawn_funcs = self.spawn_functions;
        vehicle.spawner = self;
        vehicle thread script_func( "run_spawn_functions" );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x37be
// Size: 0x7e
function vehicle_triggerkillspawner( trigger )
{
    trigger waittill( "trigger" );
    
    foreach ( vehiclespawner in vehicle_getspawnerarray() )
    {
        if ( is_equal( vehiclespawner.script_kill_vehicle_spawner, trigger.script_kill_vehicle_spawner ) )
        {
            vehiclespawner delete();
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x3844
// Size: 0x163
function vehicle_spawnaiarray( spawners, var_a7333fc35fb3cc3a )
{
    totalspawnedai = [];
    forcespawn = ent_flag_exist( "no_riders_until_unload" ) && ent_flag( "no_riders_until_unload" );
    
    foreach ( spawner in spawners )
    {
        spawner.count = 1;
        dronespawn = 0;
        
        if ( isdefined( spawner.script_drone ) )
        {
            dronespawn = 1;
            spawned = script_func( "dronespawn_bodyonly", spawner );
            spawned script_func( "drone_give_soul" );
        }
        else if ( isdefined( spawner.script_fakeactor ) || isdefined( spawner.script_bodyonly ) )
        {
            dronespawn = 1;
            spawned = script_func( "bodyonlyspawn", spawner );
            spawned script_func( "fakeactor_give_soul" );
        }
        else
        {
            spawned = spawner script_func( "spawn_ai", forcespawn );
        }
        
        if ( !dronespawn && !isalive( spawned ) )
        {
            continue;
        }
        
        totalspawnedai = array_add( totalspawnedai, spawned );
        
        if ( istrue( var_a7333fc35fb3cc3a ) )
        {
            waitframe();
        }
    }
    
    riders = vehicle_removenonridersfromaiarray( totalspawnedai );
    return riders;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x39b0
// Size: 0x6c
function vehicle_removenonridersfromaiarray( aiarray )
{
    living_ai = [];
    
    foreach ( ai in aiarray )
    {
        if ( !ai_should_be_added( ai ) )
        {
            continue;
        }
        
        living_ai[ living_ai.size ] = ai;
    }
    
    return living_ai;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x3a25
// Size: 0x40, Type: bool
function ai_should_be_added( ai )
{
    if ( isalive( ai ) )
    {
        return true;
    }
    
    if ( !isdefined( ai ) )
    {
        return false;
    }
    
    if ( !isdefined( ai.classname ) )
    {
        return false;
    }
    
    return ai.classname == "script_model";
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x3a6e
// Size: 0x6f
function spawn_riders( var_a7333fc35fb3cc3a )
{
    if ( ent_flag_exist( "no_riders_until_unload" ) && !ent_flag( "no_riders_until_unload" ) )
    {
        self notify( "spawnedRiders" );
        return [];
    }
    
    spawners = get_vehicle_riders_spawners();
    
    if ( !spawners.size )
    {
        self notify( "spawnedRiders" );
        return [];
    }
    
    riders = spawn_group( spawners, var_a7333fc35fb3cc3a );
    self notify( "spawnedRiders", riders );
    return riders;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x3ae6
// Size: 0x83
function spawn_group( spawners, var_a7333fc35fb3cc3a )
{
    ai = vehicle_spawnaiarray( spawners, var_a7333fc35fb3cc3a );
    ai = sort_by_startingpos( ai );
    
    foreach ( guy in ai )
    {
        thread scripts\common\vehicle_aianim::guy_enter( guy );
    }
    
    thread set_loaded_when_full( ai );
    return ai;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x3b72
// Size: 0x22
function set_loaded_when_full( ai )
{
    array_wait( ai, "loaded", 1 );
    scripts\common\vehicle_aianim::vehicle_loaded_if_full( self );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x3b9c
// Size: 0x23f
function spawn_unload_group( who )
{
    if ( !isdefined( who ) )
    {
        return spawn_riders();
    }
    
    assertex( ent_flag_exist( "no_riders_until_unload" ) && ent_flag( "no_riders_until_unload" ), "spawn_unload_group only used when no_riders_until_unload specified" );
    spawners = get_vehicle_riders_spawners();
    
    if ( !spawners.size )
    {
        return [];
    }
    
    group_spawners = [];
    classname = get_vehicle_classname();
    
    if ( isdefined( level.vehicle.templates.unloadgroups[ classname ] ) && isdefined( level.vehicle.templates.unloadgroups[ classname ][ who ] ) )
    {
        group = level.vehicle.templates.unloadgroups[ classname ][ who ];
        
        for ( i = 0; i < group.size ; i++ )
        {
            if ( isdefined( spawners[ i ] ) )
            {
                spawners[ i ].script_startingposition = group[ i ];
            }
        }
        
        spawners = sort_by_startingpos( spawners );
        
        foreach ( ride_pos in group )
        {
            foreach ( spawner in spawners )
            {
                if ( spawner.script_startingposition == ride_pos )
                {
                    group_spawners[ group_spawners.size ] = spawner;
                }
            }
        }
        
        ai = vehicle_spawnaiarray( group_spawners );
        
        foreach ( guy in ai )
        {
            thread scripts\common\vehicle_aianim::guy_enter( guy );
        }
        
        self notify( "spawnedRiders", ai );
        return ai;
    }
    
    return spawn_riders();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x3de3
// Size: 0x8a
function sort_by_startingpos( guysarray )
{
    firstarray = [];
    secondarray = [];
    
    foreach ( guy in guysarray )
    {
        if ( isdefined( guy.script_startingposition ) )
        {
            firstarray[ firstarray.size ] = guy;
            continue;
        }
        
        secondarray[ secondarray.size ] = guy;
    }
    
    return array_combine( firstarray, secondarray );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x3e76
// Size: 0x5b2
function vehicle_init( vehicle, var_a7333fc35fb3cc3a )
{
    if ( getdvar( @"hash_742caa13b3c2e685" ) == "1" )
    {
        return;
    }
    
    assert( vehicle.classname != "script_model" );
    classname = vehicle get_vehicle_classname();
    
    if ( isdefined( level.vehicle.templates.hide_part_list[ classname ] ) )
    {
        foreach ( part in level.vehicle.templates.hide_part_list[ classname ] )
        {
            vehicle hidepart( part );
        }
    }
    
    vehicletype = getxhashasset( vehicle.vehicletype );
    
    if ( vehicletype == "empty" || vehicletype == "empty_heli" )
    {
        vehicle thread getonpath();
        return;
    }
    
    vehicle set_ai_number();
    vehicle vehicle_setstartinghealth();
    
    /#
        vehicle thread vehicle_damagedebuginfo();
    #/
    
    /#
        vehicle thread function_a1df9e8f97742aaf( "<dev string:x14c>" + vehicle.healthstarting, 0, ( 0, 1, 0 ) );
    #/
    
    vehicle vehicle_setteam();
    
    if ( !isdefined( level.vehicleinitthread[ vehicletype ][ classname ] ) )
    {
        println( "<dev string:x169>" + classname );
        println( "<dev string:x180>" + getxhashsourcename( vehicletype ) );
        println( "<dev string:x199>" + vehicle.model );
    }
    
    vehicle thread [[ level.vehicleinitthread[ vehicletype ][ classname ] ]]();
    vehicle thread vehicle_playexhausteffect();
    vehicle thread vehicle_playengineeffect();
    
    if ( !isdefined( vehicle.script_avoidplayer ) )
    {
        vehicle.script_avoidplayer = 0;
    }
    
    if ( isdefined( level.vehicle.draw_thermal ) )
    {
        if ( level.vehicle.draw_thermal )
        {
            vehicle thermaldrawenable();
        }
    }
    
    vehicle ent_flag_init( "unloaded" );
    vehicle ent_flag_init( "loaded" );
    vehicle ent_flag_init( "landed" );
    vehicle.riders = [];
    vehicle.unloadque = [];
    vehicle.unload_group = "default";
    vehicle.fastroperig = [];
    
    if ( isdefined( level.vehicle.templates.attachedmodels ) && isdefined( level.vehicle.templates.attachedmodels[ classname ] ) )
    {
        rigs = level.vehicle.templates.attachedmodels[ classname ];
        strings = getarraykeys( rigs );
        
        foreach ( string in strings )
        {
            vehicle.fastroperig[ string ] = undefined;
            vehicle.fastroperiganimating[ string ] = 0;
        }
    }
    
    if ( isdefined( vehicle.script_vehicle_lights_on ) )
    {
        vehicle thread lights_on( vehicle.script_vehicle_lights_on );
    }
    
    if ( isdefined( vehicle.script_godmode ) )
    {
        vehicle.godmode = 1;
    }
    
    vehicle thread vehicle_damagelogic();
    vehicle thread scripts\common\vehicle_aianim::handle_attached_guys();
    
    if ( isdefined( vehicle.script_friendname ) )
    {
        vehicle setvehiclelookattext( vehicle.script_friendname, &"" );
    }
    
    vehicle thread vehicle_handleunloadevent();
    
    if ( isdefined( vehicle.script_dontunloadonend ) )
    {
        vehicle.dontunloadonend = 1;
    }
    
    vehicle thread vehicle_rumble();
    vehicle thread script_func( "vehicle_treads" );
    vehicle thread idle_animations();
    vehicle thread animate_drive_idle();
    
    if ( isdefined( vehicle.script_deathflag ) )
    {
        vehicle thread script_func( "vehicle_deathflag" );
    }
    
    vehicle thread mainturretinit();
    vehicle thread mginit();
    
    if ( isdefined( level.vehicle.spawn_callback_thread ) )
    {
        level thread [[ level.vehicle.spawn_callback_thread ]]( vehicle );
    }
    
    if ( isdefined( vehicle.script_team ) )
    {
        vehicle setvehicleteam( vehicle.script_team );
    }
    
    vehicle function_8e397e15e0fbd01a();
    vehicle thread getonpath();
    
    if ( isdefined( level.ignorewash ) )
    {
        ignore_wash = level.ignorewash;
    }
    else
    {
        ignore_wash = 0;
    }
    
    if ( utility::issp() && vehicle vehicle_hasdustkickup() && !ignore_wash )
    {
        vehicle thread aircraft_wash_thread();
    }
    
    if ( vehicle vehicle_isphysveh() )
    {
        vehicle.veh_pathtype = "constrained";
        
        if ( isdefined( vehicle.script_pathtype ) )
        {
            vehicle.veh_pathtype = vehicle.script_pathtype;
        }
    }
    
    vehicle thread function_fd3542824f9c1bd2();
    vehicle thread function_c2b5282b537a56bc();
    vehicle spawn_riders( var_a7333fc35fb3cc3a );
    vehicle thread vehicle_deathlogic();
    
    if ( istrue( var_a7333fc35fb3cc3a ) )
    {
        vehicle notify( "vehicle_init_complete" );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x4430
// Size: 0x368
function vehicle_init_mp( vehicle )
{
    assert( vehicle.classname != "script_model" );
    classname = vehicle get_vehicle_classname();
    
    if ( vehicle.spawndata.vehicletype == "empty" || vehicle.spawndata.vehicletype == "empty_heli" )
    {
        vehicle thread getonpath();
        return;
    }
    
    vehicle set_ai_number();
    type = vehicle.spawndata.vehicletype;
    
    if ( !isdefined( vehicle.script_avoidplayer ) )
    {
        vehicle.script_avoidplayer = 0;
    }
    
    if ( isdefined( level.vehicle.draw_thermal ) )
    {
        if ( level.vehicle.draw_thermal )
        {
            vehicle thermaldrawenable();
        }
    }
    
    vehicle ent_flag_init( "unloaded" );
    vehicle ent_flag_init( "loaded" );
    vehicle ent_flag_init( "landed" );
    vehicle.riders = [];
    vehicle.unloadque = [];
    vehicle.unload_group = "default";
    vehicle.fastroperig = [];
    
    if ( isdefined( vehicle.attachedmodels ) && isdefined( vehicle.attachedmodels[ classname ] ) )
    {
        rigs = vehicle.attachedmodels[ classname ];
        strings = getarraykeys( rigs );
        
        foreach ( string in strings )
        {
            vehicle.fastroperig[ string ] = undefined;
            vehicle.fastroperiganimating[ string ] = 0;
        }
    }
    
    if ( isdefined( vehicle.script_godmode ) )
    {
        vehicle.godmode = 1;
    }
    
    vehicle thread scripts\common\vehicle_aianim::handle_attached_guys();
    
    if ( isdefined( vehicle.script_friendname ) )
    {
        vehicle setvehiclelookattext( vehicle.script_friendname, &"" );
    }
    
    vehicle thread vehicle_handleunloadevent();
    
    if ( isdefined( vehicle.script_dontunloadonend ) )
    {
        vehicle.dontunloadonend = 1;
    }
    
    vehicle thread script_func( "vehicle_treads" );
    
    if ( isdefined( vehicle.script_deathflag ) )
    {
        vehicle thread script_func( "vehicle_deathflag" );
    }
    
    if ( isdefined( vehicle.script_team ) )
    {
        vehicle setvehicleteam( vehicle.script_team );
    }
    
    vehicle function_8e397e15e0fbd01a();
    vehicle thread getonpath();
    
    if ( isdefined( level.ignorewash ) )
    {
        ignore_wash = level.ignorewash;
    }
    else
    {
        ignore_wash = 0;
    }
    
    if ( utility::issp() && vehicle vehicle_hasdustkickup() && !ignore_wash )
    {
        vehicle thread aircraft_wash_thread();
    }
    
    if ( vehicle vehicle_isphysveh() )
    {
        vehicle.veh_pathtype = "constrained";
        
        if ( isdefined( vehicle.script_pathtype ) )
        {
            vehicle.veh_pathtype = vehicle.script_pathtype;
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x47a0
// Size: 0x39
function function_8e397e15e0fbd01a()
{
    if ( isdefined( level.var_620e3a366fb95fcf ) && level.var_620e3a366fb95fcf )
    {
        return;
    }
    
    if ( ishelicopter() )
    {
        thread vehicle_ai_avoidance_heli();
        return;
    }
    
    thread vehicle_ai_avoidance_logic();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x47e1
// Size: 0x85
function get_vehicle_classname()
{
    vehiclebundle = self.veh_scriptbundlesettings;
    
    if ( isdefined( vehiclebundle ) && isdefined( vehiclebundle.ref ) && isdefined( level.vehicle.templates.model[ vehiclebundle.ref ] ) )
    {
        return vehiclebundle.ref;
    }
    
    if ( isdefined( self.classname_mp ) )
    {
        return self.classname_mp;
    }
    
    return self.classname;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x486f
// Size: 0x43
function function_d0e99a4f0c29166e()
{
    if ( isdefined( self.modelhack ) )
    {
        return self.modelhack;
    }
    
    model = self.vehiclemodel;
    
    if ( model == "" )
    {
        model = self.model;
    }
    
    return model;
}

#using_animtree( "vehicles" );

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x48bb
// Size: 0x1f2
function vehicle_deathcleanup()
{
    self notify( "stop_looping_death_fx" );
    self notify( "death_finished" );
    
    if ( isdefined( self.navobstacleid ) )
    {
        destroynavobstacle( self.navobstacleid );
    }
    
    destroynavrepulsor( "veh_" + self getentitynumber() );
    
    if ( isdefined( self.rumbletrigger ) )
    {
        self.rumbletrigger delete();
    }
    
    if ( isdefined( self.mgturret ) )
    {
        array_delete( self.mgturret );
    }
    
    if ( isdefined( self.mainturret ) )
    {
        self.mainturret delete();
    }
    
    if ( istrue( level.vehicle.templates.has_main_turret[ self.model ] ) )
    {
        self clearturrettarget();
    }
    
    classname = get_vehicle_classname();
    
    if ( isdefined( level.vehicle.templates.rumble[ classname ] ) )
    {
        self stoprumble( level.vehicle.templates.rumble[ classname ].rumble );
    }
    
    if ( !issp() )
    {
        return;
    }
    
    self useanimtree( #animtree );
    
    if ( isdefined( level.vehicle.templates.driveidle[ self.model ] ) )
    {
        self clearanim( level.vehicle.templates.driveidle[ self.model ], 0 );
    }
    
    if ( isdefined( level.vehicle.templates.driveidle_r[ self.model ] ) )
    {
        self clearanim( level.vehicle.templates.driveidle_r[ self.model ], 0 );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x4ab5
// Size: 0x281
function vehicle_deathlogic()
{
    self endon( "entitydeleted" );
    self endon( "nodeath_thread" );
    thread helicopter_unloading_watcher();
    self waittill( "death", attacker, meansofdeath, weaponobject, damagelocation );
    
    if ( isdefined( self.fn_death ) )
    {
        [[ self.fn_death ]]();
    }
    
    shouldcontinue = vehicle_deathcustomlogic( attacker, meansofdeath, weaponobject );
    
    if ( isdefined( shouldcontinue ) && !shouldcontinue )
    {
        return;
    }
    
    vehicle_playdeatheffects( attacker, meansofdeath, damagelocation );
    
    if ( isdefined( self.riders ) )
    {
        foreach ( rider in self.riders )
        {
            if ( !isdefined( rider ) )
            {
                continue;
            }
            
            rider notify( "EndVehicleMotionWarp" );
            rider motionwarpcancel();
        }
    }
    
    if ( isdefined( self.runningtovehicle ) )
    {
        foreach ( guy in self.runningtovehicle )
        {
            if ( !isdefined( guy ) )
            {
                continue;
            }
            
            guy notify( "EndVehicleMotionWarp" );
            guy motionwarpcancel();
        }
    }
    
    thread vehicle_killriders();
    
    if ( function_b795d4c865a7bc7e() )
    {
        function_5d04267dd0768069();
    }
    else
    {
        vehicle_setdeathmodel();
        
        if ( ishelicopter() )
        {
            vehicle_docrash( attacker, meansofdeath );
        }
    }
    
    if ( vehicle_iscorpse() )
    {
        self notify( "vehicle_deathComplete", self.origin, self.angles );
        return;
    }
    
    vehicle_deathcleanup();
    function_37f33bfe6b63cb0a();
    self notify( "vehicle_deathComplete", self.origin, self.angles );
    
    if ( isdefined( self.driver ) && isplayer( self.driver ) )
    {
        self.driver callsharedfunc( "vehicle", "vehicle_driverShowViewModel" );
    }
    
    if ( function_b795d4c865a7bc7e() || self isscriptable() )
    {
        if ( isdefined( self.var_48fb8bde665d628d ) )
        {
            array_delete( self.var_48fb8bde665d628d );
        }
    }
    else if ( istrue( self.vehicle_skipdeathmodel ) )
    {
        if ( utility::iscp() )
        {
            wait 0.1;
        }
    }
    
    self delete();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 3
// Checksum 0x0, Offset: 0x4d3e
// Size: 0xf5
function vehicle_deathcustomlogic( attacker, meansofdeath, weaponobject )
{
    result = undefined;
    
    if ( isdefined( self.custom_death_script ) )
    {
        self thread [[ self.custom_death_script ]]();
    }
    
    if ( isdefined( self.deathfunction ) )
    {
        result = self [[ self.deathfunction ]]( attacker, meansofdeath, weaponobject );
    }
    
    if ( isdefined( level.vehicle.templates.death_thread[ self.vehicletype ] ) )
    {
        thread [[ level.vehicle.templates.death_thread[ self.vehicletype ] ]]();
    }
    
    registerkill = isdefined( attacker ) && isdefined( meansofdeath ) && isdefined( weaponobject );
    
    if ( registerkill )
    {
        weaponname = getcompleteweaponname( weaponobject );
        attacker script_func( "register_kill", self, meansofdeath, weaponname );
    }
    
    return result;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x4e3c
// Size: 0xc, Type: bool
function vehicle_iscrashing()
{
    return istrue( self.vehiclecrashing );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x4e51
// Size: 0x224
function vehicle_killriders()
{
    if ( istrue( self.pilot_killed ) && !istrue( self.unloading ) )
    {
        self waittill( "flavor_done" );
    }
    
    foreach ( rider in self.riders )
    {
        if ( !isalive( rider ) )
        {
            continue;
        }
        
        if ( !isdefined( rider.ridingvehicle ) )
        {
            continue;
        }
        
        if ( isdefined( rider.magic_bullet_shield ) )
        {
            rider stop_magic_bullet_shield();
        }
        
        if ( isdefined( rider._blackboard ) && isdefined( rider._blackboard.chosenvehicleanimpos ) && istrue( rider._blackboard.chosenvehicleanimpos_deathimpulse ) )
        {
            var_adf3664b12362142 = 100;
            velocity = self vehicle_getvelocity();
            rider.do_immediate_ragdoll = 1;
            rider.ragdollhitloc = "torso_lower";
            rider.ragdollimpactvector = ( rider.origin - self.origin ) * var_adf3664b12362142 + velocity;
        }
        
        if ( utility::iscp() && isdefined( self.damage_data ) )
        {
            if ( isdefined( self.damage_data.attacker ) && isplayer( self.damage_data.attacker ) )
            {
                rider dodamage( rider.maxhealth, self.damage_data.attacker.origin, self.damage_data.attacker, self.damage_data.attacker, self.damage_data.meansofdeath, self.damage_data.objweapon );
            }
            else
            {
                rider kill();
            }
            
            continue;
        }
        
        rider kill();
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x507d
// Size: 0x60
function vehicle_rider_death_detection( vehicle )
{
    if ( isdefined( self.vehicle_position ) && self.vehicle_position != 0 )
    {
        return;
    }
    
    self.health = 1;
    vehicle endon( "death" );
    self.baseaccuracy = 0.15;
    self waittill( "death" );
    vehicle notify( "driver_died" );
    vehicle vehicle_killriders();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x50e5
// Size: 0x79
function vehicle_becomes_crashable()
{
    self endon( "death" );
    self endon( "enable_spline_path" );
    waittillframeend();
    self.riders = array_removedead( self.riders );
    
    if ( self.riders.size )
    {
        array_thread( self.riders, &vehicle_rider_death_detection, self );
        waittill_either( "veh_collision", "driver_died" );
        vehicle_killriders();
        wait 0.25;
    }
    
    self notify( "script_crash_vehicle" );
    self vehphys_crash();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x5166
// Size: 0x15c
function vehicle_landanims( isunloadnode, hasnextnode )
{
    self endon( "death" );
    classname = get_vehicle_classname();
    
    if ( !isdefined( level.vehicle.templates.landanims[ classname ] ) )
    {
        return;
    }
    
    landanims = level.vehicle.templates.landanims[ classname ];
    
    foreach ( lanim in landanims )
    {
        self setanim( lanim.land, 1, 0.2, 1 );
    }
    
    if ( !hasnextnode )
    {
        return;
    }
    
    if ( isdefined( isunloadnode ) )
    {
        self waittill( "unloaded" );
    }
    else
    {
        self waittill( "continuepath" );
    }
    
    foreach ( lanim in landanims )
    {
        self clearanim( lanim.land, 0 );
        self setanim( lanim.takeoff, 1, 0.2, 1 );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x52ca
// Size: 0x1b
function vehicle_landvehicle( neargoal, node )
{
    return _vehicle_landvehicle( neargoal, node );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x52ee
// Size: 0x58
function spawn_vehicle_and_attach_to_spline_path( default_speed )
{
    vehicle = utility::spawn_vehicle();
    
    if ( isdefined( default_speed ) )
    {
        vehicle vehicle_setspeed( default_speed );
    }
    
    vehicle thread vehicle_becomes_crashable();
    vehicle endon( "death" );
    vehicle.dontunloadonend = 1;
    vehicle gopath( vehicle );
    vehicle leave_path_for_spline_path();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x534e
// Size: 0x50
function leave_path_for_spline_path()
{
    self endon( "script_crash_vehicle" );
    waittill_either( "enable_spline_path", "reached_end_node" );
    node = get_my_spline_node( self.origin );
    
    if ( isdefined( level.drive_spline_path_fun ) )
    {
        node thread [[ level.drive_spline_path_fun ]]( self );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x53a6
// Size: 0x103
function get_my_spline_node( org )
{
    org = ( org[ 0 ], org[ 1 ], 0 );
    all_nodes = get_array_of_closest( org, level.snowmobile_path );
    close_nodes = [];
    
    for ( i = 0; i < 3 ; i++ )
    {
        close_nodes[ i ] = all_nodes[ i ];
    }
    
    foreach ( path in level.snowmobile_path )
    {
        foreach ( node in close_nodes )
        {
            if ( node == path )
            {
                return node;
            }
        }
    }
    
    assertex( 0, "Found no node to be on!" );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x54b1
// Size: 0xd1
function waittill_stable( node )
{
    offset = 12;
    stabletime = 400;
    timer = gettime() + stabletime;
    prevangles = self.angles;
    
    while ( isdefined( self ) )
    {
        if ( abs( angleclamp180( self.angles[ 0 ] ) ) > offset || abs( angleclamp180( self.angles[ 2 ] ) ) > offset || abs( self.angles[ 1 ] - prevangles[ 1 ] ) > 0.5 )
        {
            timer = gettime() + stabletime;
        }
        
        if ( gettime() > timer )
        {
            break;
        }
        
        prevangles = self.angles;
        wait 0.05;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x558a
// Size: 0xa
function vehicle_kill_badplace_forever()
{
    self notify( "kill_badplace_forever" );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x559c
// Size: 0xc, Type: bool
function vehicle_isdestructible()
{
    return isdefined( self.destructible_type );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 3
// Checksum 0x0, Offset: 0x55b1
// Size: 0x9f
function vehicle_playdeatheffects( attacker, meansofdeath, damagelocation )
{
    if ( vehicle_isdestructible() )
    {
        return;
    }
    
    level notify( "vehicle_explosion", self.origin );
    self notify( "explode", self.origin );
    thread vehicle_deathearthquake();
    thread vehicle_deathradiusdamage();
    
    if ( self isscriptable() && !ishelicopter() )
    {
        utility::function_3677f2be30fdd581( "visibility", "hide" );
        delaycall( 0.05, &delete );
        return;
    }
    
    thread vehicle_deathkilllights();
    thread vehicle_deathvfx( attacker, meansofdeath );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x5658
// Size: 0x13f
function vehicle_deathvfx( attacker, meansofdeath )
{
    vehicleclassname = get_vehicle_classname();
    
    if ( vehicle_shoulddorocketdeath( attacker, meansofdeath, vehicleclassname ) )
    {
        self.vehicle_skipdeathmodel = 1;
        self.preferred_crash_style = 3;
        deathfxstructs = level.vehicle.templates.vehicle_rocket_death_fx[ vehicleclassname ];
    }
    else if ( istrue( self.pilot_killed ) )
    {
        self.vehicle_skipdeathmodel = 1;
        self.preferred_crash_style = 4;
        deathfxstructs = level.vehicle.templates.vehicle_rocket_death_fx[ vehicleclassname ];
    }
    else
    {
        deathfxstructs = level.vehicle.templates.vehicle_death_fx[ vehicleclassname ];
    }
    
    if ( isdefined( deathfxstructs ) )
    {
        foreach ( fxstruct in deathfxstructs )
        {
            thread kill_fx_thread( self.model, fxstruct, self.vehicletype, attacker );
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x579f
// Size: 0x66
function vehicle_deathearthquake()
{
    deathearthquake = level.vehicle.templates.death_earthquake[ get_vehicle_classname() ];
    
    if ( isdefined( deathearthquake ) )
    {
        earthquake( deathearthquake.scale, deathearthquake.duration, self.origin, deathearthquake.radius );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x580d
// Size: 0x131
function vehicle_deathradiusdamage()
{
    if ( ishelicopter() )
    {
        return;
    }
    
    classname = get_vehicle_classname();
    
    if ( !isdefined( level.vehicle.templates.death_radiusdamage ) || !isdefined( level.vehicle.templates.death_radiusdamage[ classname ] ) )
    {
        return;
    }
    
    maxdamage = level.vehicle.templates.death_radiusdamage[ classname ].maxdamage;
    mindamage = level.vehicle.templates.death_radiusdamage[ classname ].mindamage;
    self radiusdamage( self.origin + level.vehicle.templates.death_radiusdamage[ classname ].offset, level.vehicle.templates.death_radiusdamage[ classname ].range, maxdamage, mindamage );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x5946
// Size: 0x1d
function vehicle_deathkilllights()
{
    lights_off_internal( "all", self.model, get_vehicle_classname() );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 3
// Checksum 0x0, Offset: 0x596b
// Size: 0x6e, Type: bool
function vehicle_shoulddorocketdeath( attacker, meansofdeath, vehicleclassname )
{
    if ( !vehicle_hasrocketdeath( vehicleclassname ) )
    {
        return false;
    }
    
    if ( istrue( self.vehicle_forcerocketdeath ) )
    {
        return true;
    }
    
    if ( is_equal( meansofdeath, "MOD_PROJECTILE" ) )
    {
        return true;
    }
    
    if ( is_equal( meansofdeath, "MOD_PROJECTILE_SPLASH" ) )
    {
        return true;
    }
    
    if ( is_equal( meansofdeath, "MOD_GRENADE" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x59e2
// Size: 0x2b, Type: bool
function vehicle_hasrocketdeath( classname )
{
    return isdefined( level.vehicle.templates.vehicle_rocket_death_fx[ classname ] );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 4
// Checksum 0x0, Offset: 0x5a16
// Size: 0x397
function kill_fx_thread( model, struct, type, attacker )
{
    if ( isdefined( self.pilot_killed ) )
    {
        self waittill( "flavor_done" );
    }
    
    if ( isdefined( self.nodeath ) )
    {
        return;
    }
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    assert( isdefined( struct ) );
    
    if ( isdefined( struct.waitdelay ) )
    {
        if ( struct.waitdelay >= 0 )
        {
            wait struct.waitdelay;
        }
        else
        {
            self waittill( "death_finished" );
        }
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( struct.notifystring ) )
    {
        self notify( struct.notifystring );
    }
    
    attackerdirection = vectornormalize( self.origin - attacker.origin );
    
    if ( isdefined( struct.selfdeletedelay ) )
    {
        delaycall( struct.selfdeletedelay, &delete );
    }
    
    if ( isdefined( struct.effect ) )
    {
        if ( struct.beffectlooping )
        {
            if ( isdefined( struct.tag ) )
            {
                if ( isdefined( struct.stayontag ) && struct.stayontag == 1 )
                {
                    thread loop_fx_on_vehicle_tag( struct.effect, struct.delay, struct.tag );
                }
                else
                {
                    thread playloopedfxontag( struct.effect, struct.delay, struct.tag );
                }
            }
            else
            {
                forward = self.origin + ( 0, 0, 100 ) - self.origin;
                playfx( struct.effect, self.origin, forward );
            }
        }
        else if ( isdefined( struct.tag ) )
        {
            forward = _kill_fx_play_direction( attackerdirection, struct.attacker_velocity_lerp );
            
            if ( isdefined( forward ) )
            {
                deathent = deathfx_ent();
                playfx( struct.effect, deathent gettagorigin( struct.tag ), forward );
                
                if ( isdefined( struct.remove_deathfx_entity_delay ) )
                {
                    deathent delaycall( struct.remove_deathfx_entity_delay, &delete );
                }
            }
            else
            {
                deathent = deathfx_ent();
                playfxontag( struct.effect, deathent, struct.tag );
                thread stop_fx_on_vehicle_watcher( struct.effect, deathent, struct.tag );
                
                if ( isdefined( struct.remove_deathfx_entity_delay ) )
                {
                    deathfx_ent() delaycall( struct.remove_deathfx_entity_delay, &delete );
                }
            }
        }
        else
        {
            forward = _kill_fx_play_direction( attackerdirection, struct.attacker_velocity_lerp );
            
            if ( isdefined( forward ) )
            {
                playfx( struct.effect, self.origin, forward );
            }
            else
            {
                forward = self.origin + ( 0, 0, 100 ) - self.origin;
                playfx( struct.effect, self.origin, forward );
            }
        }
    }
    
    if ( isdefined( struct.sound ) )
    {
        if ( struct.bsoundlooping )
        {
            thread death_firesound( struct.sound );
            return;
        }
        
        play_sound_in_space( struct.sound );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 3
// Checksum 0x0, Offset: 0x5db5
// Size: 0x2c
function stop_fx_on_vehicle_watcher( effect_id, deathent, effect_tag )
{
    deathent waittill( "stop_all_death_fx" );
    stopfxontag( effect_id, deathent, effect_tag );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 3
// Checksum 0x0, Offset: 0x5de9
// Size: 0x5b
function loop_fx_on_vehicle_tag( effect, looptime, tag )
{
    assert( isdefined( effect ) );
    assert( isdefined( tag ) );
    assert( isdefined( looptime ) );
    self endon( "stop_looping_death_fx" );
    
    while ( isdefined( self ) )
    {
        playfxontag( effect, deathfx_ent(), tag );
        wait looptime;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x5e4c
// Size: 0x4c
function death_firesound( sound )
{
    thread script_func( "playloopsound_on_tag", sound, undefined, 0, 1 );
    waittill_any_2( "fire_extinguish", "stop_crash_loop_sound" );
    
    if ( !isdefined( self ) )
    {
        /#
            iprintln( "<dev string:x1ac>" );
        #/
        
        return;
    }
    
    self notify( "stop sound" + sound );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x5ea0
// Size: 0xd9
function deathfx_ent()
{
    if ( isdefined( self.death_fx_on_self ) && self.death_fx_on_self )
    {
        return self;
    }
    
    if ( !isdefined( self.deathfx_ent ) )
    {
        ent = spawn( "script_model", ( 0, 0, 0 ) );
        ent setmodel( self.model );
        ent.origin = self.origin;
        ent.angles = self.angles;
        ent notsolid();
        ent hide();
        ent linkto( self );
        ent.death_fx = 1;
        self.deathfx_ent = ent;
    }
    else
    {
        self.deathfx_ent setmodel( self.model );
    }
    
    return self.deathfx_ent;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 3
// Checksum 0x0, Offset: 0x5f82
// Size: 0x71
function playloopedfxontag( effect, durration, tag )
{
    effectorigin = spawn( "script_origin", self.origin );
    self endon( "fire_extinguish" );
    thread playloopedfxontag_originupdate( tag, effectorigin );
    
    while ( true )
    {
        playfx( effect, effectorigin.origin, effectorigin.upvec );
        wait durration;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x5ffb
// Size: 0xfc
function playloopedfxontag_originupdate( tag, effectorigin )
{
    effectorigin.angles = self gettagangles( tag );
    effectorigin.origin = self gettagorigin( tag );
    effectorigin.forwardvec = anglestoforward( effectorigin.angles );
    effectorigin.upvec = anglestoup( effectorigin.angles );
    
    while ( isdefined( self ) && self.code_classname == "script_vehicle" && self vehicle_getspeed() > 0 )
    {
        effectorigin.angles = self gettagangles( tag );
        effectorigin.origin = self gettagorigin( tag );
        effectorigin.forwardvec = anglestoforward( effectorigin.angles );
        effectorigin.upvec = anglestoup( effectorigin.angles );
        wait 0.05;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x60ff
// Size: 0x16f
function update_steering( vehicle )
{
    if ( vehicle.update_time == gettime() )
    {
        return vehicle.steering;
    }
    
    vehicle.update_time = gettime();
    
    if ( vehicle.steering_enable )
    {
        steering_goal = clamp( 0 - vehicle.angles[ 2 ], 0 - vehicle.steering_maxroll, vehicle.steering_maxroll ) / vehicle.steering_maxroll;
        
        if ( isdefined( vehicle.leanasitturns ) && vehicle.leanasitturns )
        {
            vehicle_steering = vehicle vehicle_getsteering();
            vehicle_steering *= -1;
            steering_goal += vehicle_steering;
            
            if ( steering_goal != 0 )
            {
                goal_factor = 1 / abs( steering_goal );
                
                if ( goal_factor < 1 )
                {
                    steering_goal *= goal_factor;
                }
            }
        }
        
        delta = steering_goal - vehicle.steering;
        
        if ( delta != 0 )
        {
            factor = vehicle.steering_maxdelta / abs( delta );
            
            if ( factor < 1 )
            {
                delta *= factor;
            }
            
            vehicle.steering += delta;
        }
    }
    else
    {
        vehicle.steering = 0;
    }
    
    return vehicle.steering;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x6277
// Size: 0xc
function function_98c0327a3d5ce1c( target )
{
    return target;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x628c
// Size: 0xae
function get_from_spawnstruct( target )
{
    array = getstructarray( target, "targetname" );
    
    if ( array.size == 1 )
    {
        return array[ 0 ];
    }
    
    foreach ( element in array )
    {
        if ( isdefined( element.poi ) && isdefined( self.poi ) && element.poi == self.poi )
        {
            return element;
        }
    }
    
    return array[ 0 ];
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x6342
// Size: 0x39
function get_from_entity( target )
{
    ent = getentarray( target, "targetname" );
    
    if ( isdefined( ent ) && ent.size > 0 )
    {
        return ent[ randomint( ent.size ) ];
    }
    
    return undefined;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x6384
// Size: 0x16
function get_from_vehicle_node( target )
{
    return getvehiclenode( target, "targetname" );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x63a3
// Size: 0x44
function set_lookat_from_dest( dest )
{
    viewtarget = getent( dest.script_linkto, "script_linkname" );
    
    if ( !isdefined( viewtarget ) )
    {
        return;
    }
    
    self setlookatent( viewtarget );
    self.set_lookat_point = 1;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x63ef
// Size: 0x128
function damage_hint_bullet_only()
{
    level.armordamagehints = 0;
    self.displayingdamagehints = 0;
    thread damage_hints_cleanup();
    
    while ( isdefined( self ) )
    {
        self waittill( "damage", amount, attacker, direction_vec, point, type );
        
        if ( !isplayer( attacker ) )
        {
            continue;
        }
        
        if ( isdefined( self.has_semtex_on_it ) )
        {
            continue;
        }
        
        type = tolower( type );
        
        switch ( type )
        {
            case #"hash_85662cca994b567":
            case #"hash_cafa41dcb907577c":
            case #"hash_f43c177a8f2e82d9":
                if ( !level.armordamagehints )
                {
                    if ( isdefined( level.thrown_semtex_grenades ) && level.thrown_semtex_grenades > 0 )
                    {
                        break;
                    }
                    
                    level.armordamagehints = 1;
                    self.displayingdamagehints = 1;
                    attacker script_func( "display_hint", "invulerable_bullets" );
                    wait 4;
                    level.armordamagehints = 0;
                    
                    if ( isdefined( self ) )
                    {
                        self.displayingdamagehints = 0;
                    }
                    
                    break;
                }
                
                break;
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x651f
// Size: 0x16e
function damage_hints()
{
    level.armordamagehints = 0;
    self.displayingdamagehints = 0;
    thread damage_hints_cleanup();
    
    while ( isdefined( self ) )
    {
        self waittill( "damage", amount, attacker, direction_vec, point, type );
        
        if ( !isplayer( attacker ) )
        {
            continue;
        }
        
        if ( isdefined( self.has_semtex_on_it ) )
        {
            continue;
        }
        
        type = tolower( type );
        
        switch ( type )
        {
            case #"hash_85662cca994b567":
            case #"hash_1991ba0f6a8cd0a2":
            case #"hash_3734ba2dac7b82b0":
            case #"hash_cafa41dcb907577c":
            case #"hash_f43c177a8f2e82d9":
                if ( !level.armordamagehints )
                {
                    if ( isdefined( level.thrown_semtex_grenades ) && level.thrown_semtex_grenades > 0 )
                    {
                        break;
                    }
                    
                    level.armordamagehints = 1;
                    self.displayingdamagehints = 1;
                    
                    if ( type == "mod_grenade" || type == "mod_grenade_splash" )
                    {
                        attacker script_func( "display_hint", "invulerable_frags", 5 );
                    }
                    else
                    {
                        attacker script_func( "display_hint", "invulerable_bullets", 5 );
                    }
                    
                    wait 4;
                    level.armordamagehints = 0;
                    
                    if ( isdefined( self ) )
                    {
                        self.displayingdamagehints = 0;
                    }
                    
                    break;
                }
                
                break;
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6695
// Size: 0x20
function damage_hints_cleanup()
{
    self waittill( "death" );
    
    if ( self.displayingdamagehints )
    {
        level.armordamagehints = 0;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x66bd
// Size: 0x2ce
function aircraft_wash_thread( model )
{
    self endon( "death" );
    self endon( "death_finished" );
    self notify( "stop_kicking_up_dust" );
    self endon( "stop_kicking_up_dust" );
    max_height = 2000;
    
    if ( isdefined( level.treadfx_maxheight ) )
    {
        max_height = level.treadfx_maxheight;
    }
    
    min_fraction = 80 / max_height;
    rate = 0.5;
    
    if ( isairplane() )
    {
        rate = 0.15;
    }
    
    trace_ent = self;
    
    if ( isdefined( model ) )
    {
        trace_ent = model;
    }
    
    trace_count = 3;
    var_b5973f58036e29a5 = scripts\engine\trace::create_default_contents( 1 );
    
    for ( ;; )
    {
        wait rate;
        
        if ( true )
        {
            if ( isdefined( self.disable_wash ) && self.disable_wash )
            {
                continue;
            }
            
            if ( isdefined( self.treadfx_maxheight ) )
            {
                max_height = self.treadfx_maxheight;
            }
            
            down_vector = anglestoup( trace_ent.angles ) * -1;
            trace = undefined;
            trace_count++;
            
            if ( trace_count > 3 )
            {
                trace_count = 3;
                trace = scripts\engine\trace::ray_trace( trace_ent.origin, trace_ent.origin + down_vector * max_height, trace_ent, var_b5973f58036e29a5, 1 );
            }
            
            if ( trace[ "fraction" ] == 1 || trace[ "fraction" ] < min_fraction )
            {
                continue;
            }
            
            dist = distance( trace_ent.origin, trace[ "position" ] );
            treadfx = get_wash_fx( self, trace, down_vector, dist );
            
            if ( !isdefined( treadfx ) )
            {
                continue;
            }
            
            rate = ( dist - 350 ) / ( max_height - 350 ) * 0.1 + 0.05;
            rate = max( rate, 0.05 );
            
            if ( !isdefined( trace ) )
            {
                continue;
            }
            
            if ( !isdefined( trace[ "position" ] ) )
            {
                continue;
            }
            
            fx_origin = trace[ "position" ];
            fx_normal = trace[ "normal" ];
            dist = vectordot( fx_origin - trace_ent.origin, fx_normal );
            pos = trace_ent.origin + ( 0, 0, dist );
            forward = fx_origin - pos;
            
            if ( isdefined( self.treadfx_orient_to_player ) )
            {
                forward = fx_origin - level.player.origin;
            }
            
            if ( vectordot( trace[ "normal" ], ( 0, 0, 1 ) ) == -1 )
            {
                continue;
            }
            
            if ( length( forward ) < 1 )
            {
                forward = trace_ent.angles + ( 0, 180, 0 );
            }
            
            playfx( treadfx, fx_origin, fx_normal, forward );
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 4
// Checksum 0x0, Offset: 0x6993
// Size: 0x9a
function get_wash_fx( vehicle, trace, down_vector, dist )
{
    surface = trace[ "surfacetype" ];
    bank = undefined;
    dot = vectordot( ( 0, 0, -1 ), down_vector );
    
    if ( dot >= 0.97 )
    {
        bank = undefined;
    }
    else if ( dot >= 0.92 )
    {
        bank = "_bank";
    }
    else
    {
        bank = "_bank_lg";
    }
    
    return get_wash_effect( vehicle get_vehicle_classname(), surface, bank );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 3
// Checksum 0x0, Offset: 0x6a36
// Size: 0x9a
function get_wash_effect( classname, surface, bank )
{
    if ( isdefined( bank ) )
    {
        bank_surface = surface + bank;
        
        if ( !isdefined( level.vehicle.templates.surface_effects[ classname ][ bank_surface ] ) && surface != "default" )
        {
            return get_wash_effect( classname, "default", bank );
        }
        else
        {
            return level.vehicle.templates.surface_effects[ classname ][ bank_surface ];
        }
    }
    
    return get_vehicle_effect( classname, surface );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x6ad9
// Size: 0x77
function get_vehicle_effect( classname, surface )
{
    if ( !isdefined( level.vehicle.templates.surface_effects[ classname ][ surface ] ) && surface != "default" )
    {
        return get_vehicle_effect( classname, "default" );
    }
    else
    {
        return level.vehicle.templates.surface_effects[ classname ][ surface ];
    }
    
    return undefined;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6b59
// Size: 0x12, Type: bool
function no_treads()
{
    return ishelicopter() || isairplane();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6b74
// Size: 0x1a, Type: bool
function vehicle_hasdustkickup()
{
    if ( !ishelicopter() && !isairplane() )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6b97
// Size: 0x51, Type: bool
function hashelicopterturret()
{
    if ( !isdefined( self.vehicletype ) )
    {
        return false;
    }
    
    if ( self.vehicletype == "cobra" )
    {
        return true;
    }
    
    if ( self.vehicletype == "cobra_player" )
    {
        return true;
    }
    
    if ( self.vehicletype == "viper" )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6bf1
// Size: 0x18
function vehicle_ai_avoidance_cleanup()
{
    self waittill( "death" );
    vehicle_remove_navobstacle();
    vehicle_remove_navrepulsor();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6c11
// Size: 0xdc
function vehicle_ai_avoidance_logic()
{
    self endon( "death" );
    thread vehicle_ai_avoidance_cleanup();
    isphysicsvehicle = self vehicle_isphysveh();
    var_f9728679c5e60af8 = 56.25;
    
    while ( true )
    {
        vehicle_navobstacle();
        
        for ( currentorigin = self.origin; vehicle_is_stopped() && ( !isphysicsvehicle || self vehicle_isonground() ) ; currentorigin = self.origin )
        {
            wait 0.5;
            
            if ( lengthsquared( self.origin - currentorigin ) > var_f9728679c5e60af8 )
            {
                vehicle_remove_navobstacle();
                vehicle_navobstacle();
            }
        }
        
        vehicle_remove_navobstacle();
        vehicle_navrepulsor();
        
        while ( !vehicle_is_stopped() || isphysicsvehicle && !self vehicle_isonground() )
        {
            wait 0.1;
        }
        
        vehicle_remove_navrepulsor();
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6cf5
// Size: 0x79, Type: bool
function vehicle_is_stopped()
{
    if ( !issp() && self issuspendedvehicle() )
    {
        return true;
    }
    
    if ( self vehicle_isphysveh() )
    {
        if ( isdefined( self.var_fa004eae3663dc6c ) )
        {
            return ( length( self vehicle_getvelocity() ) / 17.6 < self.var_fa004eae3663dc6c );
        }
        else
        {
            return ( length( self vehicle_getvelocity() ) / 17.6 < 0.25 );
        }
    }
    
    return length( self vehicle_getvelocity() ) / 17.6 == 0;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6d77
// Size: 0x80
function vehicle_ai_avoidance_heli()
{
    self endon( "death" );
    
    while ( true )
    {
        vehicle_navobstacle();
        
        while ( self vehicle_getspeed() == 0 && ( !isdefined( self.script_disconnectpaths ) || istrue( self.script_disconnectpaths ) ) )
        {
            wait 0.1;
        }
        
        vehicle_remove_navobstacle();
        
        while ( self vehicle_getspeed() != 0 || isdefined( self.script_disconnectpaths ) && !istrue( self.script_disconnectpaths ) )
        {
            wait 0.1;
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6dff
// Size: 0x40
function vehicle_navrepulsor()
{
    if ( isdefined( self.script_badplace ) && !istrue( self.script_badplace ) )
    {
        return;
    }
    
    createnavrepulsor( self.unique_id + "vehicle_badplace", -1, self, "allies", "axis" );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6e47
// Size: 0x17
function vehicle_remove_navrepulsor()
{
    destroynavrepulsor( self.unique_id + "vehicle_badplace" );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6e66
// Size: 0x2d
function vehicle_navobstacle()
{
    if ( isdefined( self.script_disconnectpaths ) && !istrue( self.script_disconnectpaths ) )
    {
        return;
    }
    
    self.navobstacleid = createnavbadplacebyent( self );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6e9b
// Size: 0x28
function vehicle_remove_navobstacle()
{
    if ( isdefined( self.navobstacleid ) )
    {
        destroynavobstacle( self.navobstacleid );
        self.navobstacleid = undefined;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6ecb
// Size: 0x13
function vehicle_disable_navrepulsors()
{
    self.script_badplace = 0;
    vehicle_remove_navrepulsor();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6ee6
// Size: 0x1c
function vehicle_enable_navrepulsors()
{
    self.script_badplace = undefined;
    
    if ( !vehicle_is_stopped() )
    {
        vehicle_navrepulsor();
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6f0a
// Size: 0x13
function vehicle_disable_navobstacles()
{
    self.script_disconnectpaths = 0;
    vehicle_remove_navobstacle();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6f25
// Size: 0x1c
function vehicle_enable_navobstacles()
{
    self.script_disconnectpaths = undefined;
    
    if ( vehicle_is_stopped() )
    {
        vehicle_navobstacle();
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6f49
// Size: 0x9
function vehicle_badplace()
{
    vehicle_navrepulsor();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6f5a
// Size: 0x9
function vehicle_remove_badplace()
{
    vehicle_remove_navrepulsor();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x6f6b
// Size: 0xf3
function disconnect_paths_whenstopped()
{
    self endon( "death" );
    self.pathsdisconnected = 0;
    var_d92d81d0d2fdf1c2 = 0;
    
    if ( isdefined( self.script_disconnectpaths ) && !self.script_disconnectpaths )
    {
        var_d92d81d0d2fdf1c2 = 1;
    }
    
    if ( var_d92d81d0d2fdf1c2 )
    {
        self.dontdisconnectpaths = 1;
        return;
    }
    
    wait randomfloat( 1 );
    
    while ( isdefined( self ) )
    {
        if ( self vehicle_getspeed() < 1 )
        {
            if ( !isdefined( self.dontdisconnectpaths ) )
            {
                self disconnectpaths();
                self.pathsdisconnected = 1;
            }
            else
            {
                assertex( self.dontdisconnectpaths == 1, ".dontDisconnectPaths should either be 1 or undefined." );
            }
            
            self notify( "speed_zero_path_disconnect" );
            
            while ( self vehicle_getspeed() < 1 )
            {
                if ( isdefined( self.dontdisconnectpaths ) && self.dontdisconnectpaths )
                {
                    break;
                }
                
                wait 0.05;
            }
        }
        
        self connectpaths();
        self.pathsdisconnected = 0;
        wait 1;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x7066
// Size: 0xe3
function mainturretinit()
{
    classname = get_vehicle_classname();
    
    if ( !isdefined( level.vehicle.templates.mainturret[ classname ] ) )
    {
        return;
    }
    
    turret_template = level.vehicle.templates.mainturret[ classname ];
    
    if ( !isdefined( turret_template ) )
    {
        return;
    }
    
    allowed_turrets = "";
    
    if ( isdefined( self.script_turrets ) )
    {
        allowed_turrets = self.script_turrets;
    }
    
    self.mainturret = turretinitshared( turret_template );
    
    if ( !isdefined( self.script_turretmain ) )
    {
        self.script_turretmain = 1;
    }
    
    if ( self.script_turretmain == 0 )
    {
        thread _mainturretoff();
        return;
    }
    
    self.script_turretmain = 1;
    thread _mainturreton();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x7151
// Size: 0x16b
function mginit()
{
    classname = get_vehicle_classname();
    
    if ( isdefined( self.script_nomg ) && self.script_nomg > 0 )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle.templates.mgturret[ classname ] ) )
    {
        return;
    }
    
    turret_templates = level.vehicle.templates.mgturret[ classname ];
    
    if ( !isdefined( turret_templates ) )
    {
        return;
    }
    
    allowed_turrets = "";
    
    if ( isdefined( self.script_turrets ) )
    {
        allowed_turrets = self.script_turrets;
    }
    
    foreach ( turret_template in turret_templates )
    {
        if ( isdefined( turret_template.referencename ) && !issubstr( allowed_turrets, turret_template.referencename ) )
        {
            continue;
        }
        
        self.mgturret[ index ] = turretinitshared( turret_template );
    }
    
    if ( !isdefined( self.script_turretmg ) )
    {
        self.script_turretmg = 1;
    }
    
    if ( self.script_turretmg == 0 )
    {
        thread _mgoff();
        return;
    }
    
    self.script_turretmg = 1;
    thread _mgon();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x72c4
// Size: 0x29c
function turretinitshared( turret_template )
{
    mgangle = 0;
    
    if ( isdefined( self.script_mg_angle ) )
    {
        mgangle = self.script_mg_angle;
    }
    
    turret = spawnturret( "misc_turret", ( 0, 0, 0 ), turret_template.info );
    linkoffset = ter_op( isdefined( turret_template.offset_tag ), turret_template.offset_tag, ( 0, 0, 0 ) );
    parent = self;
    
    if ( isdefined( turret_template.mainturretchild ) )
    {
        if ( !isdefined( self.mainturret ) )
        {
            assertmsg( "mg turret for veh <" + get_vehicle_classname() + "> is set to be child of mainturret, but no mainturret exists.  Use build_mainturret" );
        }
        
        parent = self.mainturret;
    }
    
    turret linkto( parent, turret_template.tag, linkoffset, ( 0, -1 * mgangle, 0 ) );
    bodymodel = function_d0e99a4f0c29166e();
    array = strtok( bodymodel, "::" );
    
    if ( array.size > 1 )
    {
        color = array[ 0 ] + "::";
    }
    else
    {
        color = "";
    }
    
    turret setmodel( color + turret_template.model );
    turret.angles = self.angles;
    turret.isvehicleattached = 1;
    turret.ownervehicle = self;
    turret.weaponinfo = turret_template.info;
    assert( isdefined( self.script_team ) );
    turret.script_team = self.script_team;
    turret makeusable();
    set_turret_team( turret );
    level thread vehicle_turret_difficulty( turret, utility::getdifficulty() );
    
    if ( isdefined( self.script_fireondrones ) )
    {
        turret.script_fireondrones = self.script_fireondrones;
    }
    
    if ( isdefined( turret_template.deletedelay ) )
    {
        turret.deletedelay = turret_template.deletedelay;
    }
    
    if ( isdefined( turret_template.defaultdroppitch ) )
    {
        turret setdefaultdroppitch( turret_template.defaultdroppitch );
    }
    
    if ( isdefined( turret_template.referencename ) )
    {
        turret.referencename = turret_template.referencename;
    }
    
    if ( isdefined( turret_template.defaultonmode ) )
    {
        turret turret_set_default_on_mode( turret_template.defaultonmode );
    }
    
    return turret;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x7569
// Size: 0xa4
function vehicle_turret_difficulty( turret, difficulty )
{
    turret.convergencetime = level.mgturretsettings[ difficulty ][ "convergenceTime" ];
    turret.suppressiontime = level.mgturretsettings[ difficulty ][ "suppressionTime" ];
    turret.accuracy = level.mgturretsettings[ difficulty ][ "accuracy" ];
    turret.aispread = level.mgturretsettings[ difficulty ][ "aiSpread" ];
    turret.playerspread = level.mgturretsettings[ difficulty ][ "playerSpread" ];
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x7615
// Size: 0x15
function turret_set_default_on_mode( defaultonmode )
{
    self.defaultonmode = defaultonmode;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x7632
// Size: 0xc7
function set_turret_team( turret )
{
    switch ( self.script_team )
    {
        case #"hash_5f54b9bf7583687f":
        case #"hash_ecada18a31eceade":
            turret setturretteam( "allies" );
            break;
        case #"hash_3e323a3a6f36e18b":
        case #"hash_7c2d091e6337bf54":
            turret setturretteam( "axis" );
            break;
        case #"hash_24b14065e10b1f8d":
            turret setturretteam( "team3" );
            break;
        case #"hash_a571cacc018623b8":
            turret setturretteam( "neutral" );
            break;
        default:
            assertmsg( "Unknown script_team: " + self.script_team );
            break;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x7701
// Size: 0x3b3
function animate_drive_idle()
{
    if ( !issp() )
    {
        return;
    }
    
    self endon( "suspend_drive_anims" );
    
    if ( !isdefined( self.vehiclewheeldirection ) )
    {
        self.vehiclewheeldirection = 1;
    }
    
    model = function_d0e99a4f0c29166e();
    curanimrate = -1;
    newanimtime = undefined;
    
    if ( !isdefined( level.vehicle.templates.driveidle[ model ] ) )
    {
        return;
    }
    
    self useanimtree( #animtree );
    
    if ( !isdefined( level.vehicle.templates.driveidle_r[ model ] ) )
    {
        level.vehicle.templates.driveidle_r[ model ] = level.vehicle.templates.driveidle[ model ];
    }
    
    self endon( "death" );
    normalspeed = level.vehicle.templates.driveidle_normal_speed[ model ];
    animrate = 1;
    
    if ( isdefined( level.vehicle.templates.driveidle_animrate ) && isdefined( level.vehicle.templates.driveidle_animrate[ model ] ) )
    {
        animrate = level.vehicle.templates.driveidle_animrate[ model ];
    }
    
    lastdir = self.vehiclewheeldirection;
    animation = level.vehicle.templates.driveidle[ model ];
    
    while ( true )
    {
        if ( !normalspeed )
        {
            if ( isdefined( self.suspend_driveanims ) )
            {
                wait 0.05;
                continue;
            }
            
            self setanim( level.vehicle.templates.driveidle[ model ], 1, 0.2, animrate );
            return;
        }
        
        speed = self vehicle_getspeed();
        
        if ( lastdir != self.vehiclewheeldirection )
        {
            dif = 0;
            
            if ( self.vehiclewheeldirection )
            {
                animation = level.vehicle.templates.driveidle[ model ];
                dif = 1 - get_normal_anim_time( level.vehicle.templates.driveidle_r[ model ] );
                self clearanim( level.vehicle.templates.driveidle_r[ model ], 0 );
            }
            else
            {
                animation = level.vehicle.templates.driveidle_r[ model ];
                dif = 1 - get_normal_anim_time( level.vehicle.templates.driveidle[ model ] );
                self clearanim( level.vehicle.templates.driveidle[ model ], 0 );
            }
            
            newanimtime = 0.01;
            
            if ( newanimtime >= 1 || newanimtime == 0 )
            {
                newanimtime = 0.01;
            }
            
            lastdir = self.vehiclewheeldirection;
        }
        
        newanimrate = speed / normalspeed;
        
        if ( newanimrate != curanimrate )
        {
            self setanim( animation, 1, 0.05, newanimrate );
            curanimrate = newanimrate;
        }
        
        if ( isdefined( newanimtime ) )
        {
            self setanimtime( animation, newanimtime );
            newanimtime = undefined;
        }
        
        wait 0.05;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x7abc
// Size: 0x2ee
function setup_vehicles( vehicles )
{
    nonspawned = [];
    
    foreach ( vehicle in vehicles )
    {
        if ( isspawner( vehicle ) )
        {
            continue;
        }
        
        nonspawned[ nonspawned.size ] = vehicle;
    }
    
    foreach ( live_vehicle in nonspawned )
    {
        model = live_vehicle function_d0e99a4f0c29166e();
        
        if ( isdefined( live_vehicle.var_ae43938336bbd264 ) && isdefined( model ) )
        {
            array = strtok( live_vehicle.var_ae43938336bbd264, "," );
            color = array[ randomintrange( 0, array.size ) ];
            
            if ( color == "base" )
            {
                precachemodel( model );
            }
            else
            {
                precachemodel( color + "::" + model );
            }
            
            if ( isdefined( level.vehicle.templates.husk[ model ] ) )
            {
                if ( color == "base" )
                {
                    precachemodel( level.vehicle.templates.husk[ model ] );
                }
                else if ( istrue( level.vehicle.templates.var_893da51cf12b2c8b[ model ] ) )
                {
                    precachemodel( color + "::" + level.vehicle.templates.husk[ model ] );
                }
            }
            
            if ( color == "base" )
            {
                live_vehicle setmodel( model );
            }
            else
            {
                live_vehicle setmodel( color + "::" + model );
            }
        }
        
        if ( isdefined( live_vehicle.spawnflags ) && live_vehicle.spawnflags & 16 )
        {
            live_vehicle.isstationary = 1;
        }
        
        if ( isdefined( live_vehicle.spawnflags ) && live_vehicle.spawnflags & 4 )
        {
            husk = live_vehicle thread function_18657584b6bd786a( 1 );
            continue;
        }
        
        if ( isdefined( live_vehicle.spawnflags ) )
        {
            if ( live_vehicle.spawnflags & 1 )
            {
                live_vehicle thread script_func( "vehicle_usable" );
            }
            else
            {
                live_vehicle vehicle_turnengineoff();
            }
            
            if ( live_vehicle vehicle_isphysveh() && !live_vehicle ishelicopter() && ( live_vehicle.spawnflags & 8 || istrue( live_vehicle.isstationary ) ) )
            {
                live_vehicle vehphys_parkingbrake( 1 );
            }
        }
        
        thread vehicle_init( live_vehicle );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x7db2
// Size: 0x217
function vehicle_setstartinghealth()
{
    classname = get_vehicle_classname();
    assertex( isdefined( level.vehicle.templates.life[ classname ] ), "need to specify vehicle_setStartingHealth() in vehicle script for vehicletype: " + classname );
    
    if ( isdefined( self.script_startinghealth ) )
    {
        self.health = self.script_startinghealth;
    }
    else
    {
        if ( level.vehicle.templates.life[ classname ] == -1 )
        {
            return;
        }
        
        if ( isdefined( level.vehicle.templates.life_range_low[ classname ] ) && isdefined( level.vehicle.templates.life_range_high[ classname ] ) && level.vehicle.templates.life_range_high[ classname ] > level.vehicle.templates.life_range_low[ classname ] )
        {
            self.health = randomint( level.vehicle.templates.life_range_high[ classname ] - level.vehicle.templates.life_range_low[ classname ] ) + level.vehicle.templates.life_range_low[ classname ];
        }
        else
        {
            self.health = level.vehicle.templates.life[ classname ];
        }
    }
    
    self.explosivehits = 0;
    self.maxhealth = self.health;
    self.healthactual = self.health;
    self.healthstarting = self.health;
    self.damagestate = "damagePristine";
    self.var_653c58271b7da4c9 = 1;
    self.ui_warning = 0;
    function_98c558b067cdd616();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x7fd1
// Size: 0x44
function get_normal_anim_time( animation )
{
    animtime = self getanimtime( animation );
    animlength = getanimlength( animation );
    
    if ( animtime == 0 )
    {
        return 0;
    }
    
    return self getanimtime( animation ) / getanimlength( animation );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x801e
// Size: 0x68
function suspend_drive_anims()
{
    self notify( "suspend_drive_anims" );
    self clearanim( level.vehicle.templates.driveidle[ self.model ], 0 );
    self clearanim( level.vehicle.templates.driveidle_r[ self.model ], 0 );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x808e
// Size: 0xa6
function idle_animations()
{
    if ( !isdefined( level.vehicle.templates.idle_anim[ self.model ] ) )
    {
        return;
    }
    
    self useanimtree( #animtree );
    
    foreach ( animation in level.vehicle.templates.idle_anim[ self.model ] )
    {
        self setanim( animation );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x813c
// Size: 0x314
function vehicle_rumble()
{
    self endon( "kill_rumble_forever" );
    classname = get_vehicle_classname();
    rumblestruct = level.vehicle.templates.rumble[ classname ];
    
    if ( !isdefined( rumblestruct ) )
    {
        return;
    }
    
    height = rumblestruct.radius * 2;
    zoffset = -1 * rumblestruct.radius;
    areatrigger = spawn( "trigger_radius", self.origin + ( 0, 0, zoffset ), 0, rumblestruct.radius, height );
    areatrigger enablelinkto();
    areatrigger linkto( self );
    self.rumbletrigger = areatrigger;
    self endon( "death" );
    
    if ( !isdefined( self.rumbleon ) )
    {
        self.rumbleon = 1;
    }
    
    if ( isdefined( rumblestruct.scale ) )
    {
        self.rumble_scale = rumblestruct.scale;
    }
    else
    {
        self.rumble_scale = 0.15;
    }
    
    if ( isdefined( rumblestruct.duration ) )
    {
        self.rumble_duration = rumblestruct.duration;
    }
    else
    {
        self.rumble_duration = 4.5;
    }
    
    if ( isdefined( rumblestruct.radius ) )
    {
        self.rumble_radius = rumblestruct.radius;
    }
    else
    {
        self.rumble_radius = 600;
    }
    
    if ( isdefined( rumblestruct.basetime ) )
    {
        self.rumble_basetime = rumblestruct.basetime;
    }
    else
    {
        self.rumble_basetime = 1;
    }
    
    if ( isdefined( rumblestruct.randomaditionaltime ) )
    {
        self.rumble_randomaditionaltime = rumblestruct.randomaditionaltime;
    }
    else
    {
        self.rumble_randomaditionaltime = 1;
    }
    
    areatrigger.radius = self.rumble_radius;
    
    while ( true )
    {
        areatrigger waittill( "trigger" );
        
        if ( vehicle_is_stopped() && !isdefined( self.forcerumble ) || !self.rumbleon )
        {
            wait 0.1;
            continue;
        }
        
        self playrumblelooponentity( rumblestruct.rumble );
        
        if ( isdefined( self.vehicletype ) )
        {
            soundname = self.vehicletype + "_rumble_sfx";
            
            if ( soundexists( soundname ) )
            {
                level.player playsound( soundname );
            }
        }
        
        while ( level.player istouching( areatrigger ) && self.rumbleon && ( !vehicle_is_stopped() || isdefined( self.forcerumble ) ) )
        {
            earthquake( self.rumble_scale, self.rumble_duration, self.origin, self.rumble_radius );
            wait self.rumble_basetime + randomfloat( self.rumble_randomaditionaltime );
        }
        
        self stoprumble( rumblestruct.rumble );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x8458
// Size: 0x6d
function vehicle_setteam()
{
    classname = get_vehicle_classname();
    
    if ( !isdefined( self.script_team ) && isdefined( level.vehicle.templates.team[ classname ] ) )
    {
        self.script_team = level.vehicle.templates.team[ classname ];
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x84cd
// Size: 0x37
function vehicle_handleunloadevent()
{
    self endon( "death" );
    type = self.vehicletype;
    
    if ( !ent_flag_exist( "unloaded" ) )
    {
        ent_flag_init( "unloaded" );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x850c
// Size: 0x90
function get_vehiclenode_any_dynamic( target )
{
    path_start = getvehiclenode( target, "targetname" );
    
    if ( !isdefined( path_start ) )
    {
        path_start = getent( target, "targetname" );
    }
    else if ( ishelicopter() )
    {
        /#
            println( "<dev string:x1fa>" + path_start.targetname );
            println( "<dev string:x217>" + self.vehicletype );
        #/
        
        assertmsg( "helicopter on vehicle path( see console for info )" );
    }
    
    if ( !isdefined( path_start ) )
    {
        path_start = getstruct( target, "targetname" );
    }
    
    return path_start;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x85a5
// Size: 0x9b8
function vehicle_damagelogic()
{
    self endon( "death" );
    self.damage_functions = [];
    classname = get_vehicle_classname();
    
    if ( isdefined( level.vehicle.templates.bullet_shield[ classname ] ) && !isdefined( self.script_bulletshield ) )
    {
        self.script_bulletshield = level.vehicle.templates.bullet_shield[ classname ];
    }
    
    if ( isdefined( level.vehicle.templates.grenade_shield[ classname ] ) && !isdefined( self.script_grenadeshield ) )
    {
        self.script_grenadeshield = level.vehicle.templates.grenade_shield[ classname ];
    }
    
    if ( isdefined( level.vehicle.templates.collision_shield[ classname ] ) && !isdefined( self.var_721298f6d1910c00 ) )
    {
        self.var_721298f6d1910c00 = level.vehicle.templates.collision_shield[ classname ];
    }
    
    self.healthbuffer = 100000;
    self.health += self.healthbuffer;
    self.healthactual = self.health;
    
    while ( self.health > 0 )
    {
        self.damageinfo = undefined;
        self waittill( "damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time );
        partname = scripts\common\vehicle::function_8ed0ffa3f8be7c75( partname );
        attachtagname = scripts\common\vehicle::function_8ed0ffa3f8be7c75( attachtagname );
        
        if ( !flag( "scriptables_ready" ) )
        {
            flag_wait( "scriptables_ready" );
        }
        
        flag_wait( "scriptables_ready" );
        damagedpartname = ter_op( attachtagname != "", attachtagname, partname );
        amount = function_8f700dc8e0d2fa89( amount, meansofdeath, time );
        
        if ( !isdefined( meansofdeath ) || !isexplosivedamage( meansofdeath, objweapon ) )
        {
            amount = function_8dfb977adeef3436( amount );
        }
        
        self.damageinfo[ "amount" ] = amount;
        self.damageinfo[ "attacker" ] = attacker;
        self.damageinfo[ "direction_vec" ] = direction_vec;
        self.damageinfo[ "damageLocation" ] = damagelocation;
        self.damageinfo[ "MOD" ] = meansofdeath;
        self.damageinfo[ "weapon" ] = objweapon;
        
        if ( istrue( self.custom_damage_handler ) )
        {
            return;
        }
        
        foreach ( func in self.damage_functions )
        {
            thread [[ func ]]( amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon );
        }
        
        if ( isdefined( attacker ) )
        {
            attacker script_func( "register_shot_hit" );
            
            if ( func_ref_exist( "vehicle_damage_modifier" ) )
            {
                data = undefined;
                
                if ( isdefined( level.fn_damage_pack ) )
                {
                    data = [[ level.fn_damage_pack ]]( attacker, self, amount, objweapon, meansofdeath, undefined, damagelocation, direction_vec, modelname, partname, attachtagname, dflags );
                }
                
                if ( isdefined( data ) )
                {
                    self.damage_data = data;
                }
                else
                {
                    self.damage_data = undefined;
                }
                
                new_amount = script_func( "vehicle_damage_modifier", data );
                
                if ( isdefined( new_amount ) )
                {
                    amount = new_amount;
                }
            }
        }
        
        if ( function_d7fe44ffb08b499a() )
        {
            /#
                thread function_a1df9e8f97742aaf( "<dev string:x225>", 1, ( 0, 1, 0 ) );
            #/
            
            self.health = self.healthactual;
        }
        else if ( function_e9ed4f44f9d1d682( attacker ) )
        {
            /#
                thread function_a1df9e8f97742aaf( "<dev string:x22a>" + self.script_team + "<dev string:x23f>" + time, 1, ( 0, 1, 0 ) );
            #/
            
            self.health = self.healthactual;
        }
        else if ( function_c948f3a1e60efd61( attacker, meansofdeath, objweapon ) )
        {
            /#
                thread function_a1df9e8f97742aaf( "<dev string:x243>" + "<dev string:x23f>" + time, 1, ( 0, 1, 0 ) );
            #/
            
            self.health = self.healthactual;
        }
        else if ( function_ba6c52398d8ba7fb( meansofdeath, objweapon ) )
        {
            /#
                thread function_a1df9e8f97742aaf( "<dev string:x255>" + "<dev string:x23f>" + time, 1, ( 0, 1, 0 ) );
            #/
            
            self.health = self.healthactual;
        }
        else
        {
            if ( function_f237c27c3ba6b34d( meansofdeath ) )
            {
                /#
                    thread function_a1df9e8f97742aaf( "<dev string:x269>" + "<dev string:x23f>" + time, 1, ( 0, 1, 0 ) );
                #/
                
                self.health = self.healthactual;
            }
            
            if ( isdefined( self.var_c543f8e941150b0b ) )
            {
                part_hit = self [[ self.var_c543f8e941150b0b ]]( damagedpartname, meansofdeath, damagelocation );
                
                if ( isdefined( part_hit ) )
                {
                    if ( isdefined( self.var_2352359ef3eefcd3 ) )
                    {
                        self thread [[ self.var_2352359ef3eefcd3 ]]( attacker, amount, part_hit, direction_vec, damagelocation );
                    }
                    
                    if ( isstartstr( part_hit, "tag_armor" ) )
                    {
                        amount = 0;
                        self.health = self.healthactual;
                    }
                }
            }
            
            if ( utility::issp() && isdefined( meansofdeath ) )
            {
                if ( isdefined( objweapon ) && function_2cffaf4e15c4ab48( getcompleteweaponname( objweapon ) ) || !function_b9ea9d0702abf6fd( self.health, amount, direction_vec, damagelocation, meansofdeath, objweapon, attacker, inflictor ) )
                {
                    if ( meansofdeath == "MOD_MELEE" )
                    {
                        function_a1ed6ce90e57bd32( amount, damagelocation, meansofdeath, objweapon, attacker );
                    }
                    else
                    {
                        thread function_b958f96bb17ec92d( damagedpartname, amount, meansofdeath, objweapon, attacker );
                    }
                }
            }
            
            if ( function_9e9dfc6f77569f4d() )
            {
                /#
                    thread function_a1df9e8f97742aaf( "<dev string:x27c>", 1, ( 0, 1, 0 ) );
                #/
                
                self.health = self.healthactual;
            }
            else
            {
                self.healthactual = self.health;
                function_89cec1224ae724d5();
            }
            
            /#
                thread function_a1df9e8f97742aaf( "<dev string:x284>" + self.damagestate + "<dev string:x292>" + self.healthactual, 1, ( 1, 0, 0 ) );
            #/
            
            /#
                thread function_a1df9e8f97742aaf( meansofdeath + "<dev string:x29c>" + amount + "<dev string:x2a0>" + self.explosivehits + "<dev string:x2b1>" + damagedpartname + "<dev string:x2b5>" + self.healthactual + "<dev string:x23f>" + time );
            #/
        }
        
        if ( function_d7fe44ffb08b499a() || function_9e9dfc6f77569f4d() )
        {
            continue;
        }
        
        if ( amount >= self.healthstarting * 2 )
        {
            self notify( "death", attacker, meansofdeath, objweapon, damagelocation );
        }
        
        if ( self.damagestate == "damageHeavy" )
        {
            if ( self.health <= self.healthbuffer || function_4d5539ed20893df1() )
            {
                self notify( "death", attacker, meansofdeath, objweapon, damagelocation );
            }
            
            continue;
        }
        
        if ( isdefined( level.vehicle.templates.explosivehits[ classname ] ) && function_4d5539ed20893df1() )
        {
            self notify( "death", attacker, meansofdeath, objweapon, damagelocation );
        }
        
        if ( ishelicopter() && function_4d5539ed20893df1() )
        {
            self notify( "death", attacker, meansofdeath, objweapon, damagelocation );
        }
        
        healthpercentage = ( self.health - self.healthbuffer ) / self.healthstarting;
        
        if ( function_4d5539ed20893df1() )
        {
            self.damagestate = "damageHeavy";
        }
        else if ( healthpercentage <= 0.3 )
        {
            self.damagestate = "damageHeavy";
        }
        else if ( healthpercentage <= 0.65 )
        {
            self.damagestate = "damageMedium";
        }
        else if ( healthpercentage <= 0.9 )
        {
            self.damagestate = "damageLight";
        }
        else
        {
            self.damagestate = "damagePristine";
        }
        
        /#
            thread function_a1df9e8f97742aaf( "<dev string:x284>" + self.damagestate + "<dev string:x292>" + self.healthactual, 1, ( 1, 0, 0 ) );
        #/
        
        if ( self isscriptable() && self getscriptablehaspart( self.damagestate ) && self getscriptablepartstate( self.damagestate, 1 ) != self.damagestate )
        {
            utility::function_3677f2be30fdd581( self.damagestate, "highSpeed" );
        }
        
        if ( self.damagestate == "damageHeavy" )
        {
            vehicle_sethealth( self.healthstarting * 0.3 );
            function_89cec1224ae724d5();
            self.burndownstart = gettime();
            self notify( "vehicle_inBurndown" );
            childthread burndown_timer();
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x8f65
// Size: 0x14d
function private function_8f700dc8e0d2fa89( amount, meansofdeath, time )
{
    /#
        thread function_a1df9e8f97742aaf( "<dev string:x2b9>" + time + "<dev string:x2cc>" + self.healthstarting + "<dev string:x2df>", 0, ( 1, 0, 0.5 ) );
    #/
    
    isbullet = undefined;
    
    if ( isdefined( meansofdeath ) && isendstr( meansofdeath, "_BULLET" ) )
    {
        isbullet = 1;
    }
    else
    {
        return amount;
    }
    
    scaledamount = undefined;
    
    if ( istrue( level.var_1de5acbb26e97918 ) )
    {
        scaledamount = amount * level.var_1de5acbb26e97918;
        
        /#
            thread function_a1df9e8f97742aaf( "<dev string:x2b9>" + time + "<dev string:x2cc>" + self.healthstarting + "<dev string:x2f0>" + level.var_1de5acbb26e97918, 0, ( 1, 0, 0.5 ) );
        #/
    }
    
    if ( istrue( self.var_1de5acbb26e97918 ) )
    {
        scaledamount = amount * self.var_1de5acbb26e97918;
        
        /#
            thread function_a1df9e8f97742aaf( "<dev string:x2b9>" + time + "<dev string:x2cc>" + self.healthstarting + "<dev string:x307>" + self.var_1de5acbb26e97918, 0, ( 1, 0, 0.5 ) );
        #/
    }
    
    if ( isdefined( scaledamount ) )
    {
        addhealth( amount - scaledamount );
        amount = scaledamount;
    }
    
    return amount;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x90bb
// Size: 0x34
function private function_8dfb977adeef3436( amount )
{
    if ( self.damagestate == "damageHeavy" )
    {
        addhealth( amount * 0.75 );
        return ( amount * 0.25 );
    }
    
    return amount;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x90f8
// Size: 0x4c
function private function_a183f52b983f5769( amount )
{
    scaledamount = amount;
    
    if ( istrue( level.var_bd79128b30a2dfb2 ) )
    {
        scaledamount = amount * level.var_bd79128b30a2dfb2;
    }
    
    if ( istrue( self.var_bd79128b30a2dfb2 ) )
    {
        scaledamount = amount * self.var_bd79128b30a2dfb2;
    }
    
    return scaledamount;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x914d
// Size: 0xf5
function private function_4a5955251a67bfda( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        return 1;
    }
    
    scaleweaponname = getweaponbasename( objweapon );
    scaledamount = 1;
    
    if ( isdefined( level.var_b8e957f2bf26c5e5 ) )
    {
        foreach ( entry in level.var_b8e957f2bf26c5e5 )
        {
            if ( entry[ 0 ] == scaleweaponname )
            {
                scaledamount = entry[ 1 ];
            }
        }
    }
    
    if ( isdefined( self.var_b8e957f2bf26c5e5 ) )
    {
        foreach ( entry in self.var_b8e957f2bf26c5e5 )
        {
            if ( entry[ 0 ] == scaleweaponname )
            {
                scaledamount = entry[ 1 ];
            }
        }
    }
    
    return scaledamount;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x924b
// Size: 0xaf
function burndown_timer()
{
    self.ui_warning = 1;
    function_89cec1224ae724d5();
    healthinc = int( ( self.health - self.healthbuffer ) / 30 / 0.25 ) + 1;
    
    while ( gettime() - self.burndownstart < 30000 )
    {
        countdown = 30000 - gettime() - self.burndownstart;
        
        /#
            thread function_a1df9e8f97742aaf( "<dev string:x31d>" + countdown, 2, ( 1, 0, 1 ) );
        #/
        
        vehicle_damage( healthinc, undefined, "MOD_EXECUTION" );
        wait 1;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x9302
// Size: 0x63
function function_37a7cbb36025d760()
{
    while ( gettime() - self.burndownstart < 30000 )
    {
        countdown = 30000 - gettime() - self.burndownstart;
        
        /#
            thread function_a1df9e8f97742aaf( "<dev string:x31d>" + countdown, 2, ( 1, 0, 1 ) );
        #/
        
        waitframe();
    }
    
    self notify( "death" );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 5
// Checksum 0x0, Offset: 0x936d
// Size: 0x10a
function function_a1ed6ce90e57bd32( amount, damagelocation, meansofdeath, objweapon, attacker )
{
    var_6071f029b63b07f6 = function_7bba68b7e28ec873( 64, damagelocation, 1 );
    
    foreach ( part in var_6071f029b63b07f6 )
    {
        switch ( level.vehicle.damageableparts[ part ] )
        {
            case 5:
                break;
            default:
                var_6071f029b63b07f6 = array_remove( var_6071f029b63b07f6, part );
                break;
        }
    }
    
    closestparttodamage = function_350e192b13bea45c( var_6071f029b63b07f6 );
    
    if ( isdefined( closestparttodamage ) && distancesquared( damagelocation, self gettagorigin( closestparttodamage ) ) <= squared( 64 ) )
    {
        thread function_b958f96bb17ec92d( closestparttodamage, amount, meansofdeath, objweapon, undefined, 1, damagelocation );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 4
// Checksum 0x0, Offset: 0x947f
// Size: 0x1de, Type: bool
function function_f8f1d017591e2c60( health, amount, meansofdeath, objweapon )
{
    classname = get_vehicle_classname();
    assertex( isdefined( level.vehicle.templates.explosivehits[ classname ] ), "Something fishy with classname: " + classname );
    
    if ( amount >= 110 && ( meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_PROJECTILE_SPLASH" ) )
    {
        hitsscale = function_4a5955251a67bfda( objweapon );
        
        if ( level.vehicle.templates.explosivehits[ classname ] > 0 )
        {
            healthreduction = self.healthstarting / level.vehicle.templates.explosivehits[ classname ] / 0.5 * hitsscale;
            vehicle_addhealth( amount );
            function_c8a94acef0beb362( healthreduction );
        }
        
        self.explosivehits += 0.5 * hitsscale;
        return true;
    }
    else if ( amount >= 190 && ( meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_EXECUTION" ) )
    {
        hitsscale = function_4a5955251a67bfda( objweapon );
        
        if ( level.vehicle.templates.explosivehits[ classname ] > 0 )
        {
            healthreduction = self.healthstarting / level.vehicle.templates.explosivehits[ classname ] / 1 * hitsscale;
            vehicle_addhealth( amount );
            function_c8a94acef0beb362( healthreduction );
        }
        
        self.explosivehits += 1 * hitsscale;
        return true;
    }
    
    return false;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x9666
// Size: 0xeb, Type: bool
function function_4d5539ed20893df1()
{
    classname = get_vehicle_classname();
    assertex( isdefined( level.vehicle.templates.explosivehits[ classname ] ), "Something fishy with classname: " + classname );
    
    if ( level.vehicle.templates.explosivehits[ classname ] == 0 )
    {
        if ( self.explosivehits > level.vehicle.templates.explosivehits[ classname ] )
        {
            return true;
        }
    }
    
    if ( level.vehicle.templates.explosivehits[ classname ] > 0 && self.explosivehits >= level.vehicle.templates.explosivehits[ classname ] )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 8
// Checksum 0x0, Offset: 0x975a
// Size: 0x103, Type: bool
function function_b9ea9d0702abf6fd( health, amount, direction_vec, damagelocation, meansofdeath, objweapon, attacker, inflictor )
{
    if ( function_f8f1d017591e2c60( health, amount, meansofdeath, objweapon ) )
    {
        thread function_97de184a1b867545();
        partstodamage = function_7bba68b7e28ec873( undefined, damagelocation, 1 );
        
        for ( i = 0; i < partstodamage.size ; i++ )
        {
            if ( i == 4 )
            {
                break;
            }
            
            if ( isdefined( inflictor ) )
            {
                thread function_b958f96bb17ec92d( partstodamage[ i ], amount * 2, meansofdeath, objweapon, attacker, 1, inflictor.origin );
                continue;
            }
            
            thread function_b958f96bb17ec92d( partstodamage[ i ], amount * 2, meansofdeath, objweapon, attacker, 1 );
        }
        
        if ( !istrue( self.skiplaunch ) && isdefined( meansofdeath ) && isexplosivedamage( meansofdeath, objweapon ) )
        {
            thread function_80b9a13a5f971524( amount, direction_vec, damagelocation, meansofdeath );
        }
        
        return true;
    }
    
    return false;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x9866
// Size: 0xa0
function function_98c558b067cdd616()
{
    if ( isdefined( self.damageableparts ) )
    {
        return;
    }
    
    self.damageableparts = [];
    
    for ( i = 0; i < getnumparts( self.model ) ; i++ )
    {
        partname = getpartname( self.model, i );
        partname = scripts\common\vehicle::function_8ed0ffa3f8be7c75( partname );
        
        if ( array_contains_key( level.vehicle.damageableparts, partname ) )
        {
            self.damageableparts[ partname ] = level.vehicle.damageableparts[ partname ];
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0x990e
// Size: 0x95
function function_97de184a1b867545()
{
    if ( !self isscriptable() )
    {
        return;
    }
    
    function_98c558b067cdd616();
    keys = getarraykeys( self.damageableparts );
    
    foreach ( key in keys )
    {
        if ( isstartstr( key, "tag_wind" ) )
        {
            self.damageableparts[ key ] = 0;
            utility::function_3677f2be30fdd581( key, "death" );
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 8
// Checksum 0x0, Offset: 0x99ab
// Size: 0x514
function function_b958f96bb17ec92d( damagedpartname, amount, meansofdeath, objweapon, attacker, skipregen, origin, skiptire )
{
    if ( !isdefined( skipregen ) )
    {
        skipregen = 0;
    }
    
    if ( !isdefined( skiptire ) )
    {
        skiptire = 0;
    }
    
    if ( !isdefined( damagedpartname ) || !array_contains_key( level.vehicle.damageableparts, damagedpartname ) )
    {
        return;
    }
    
    if ( isdefined( damagedpartname ) && isdefined( self.var_9868a2f0e52a82bd ) && array_contains( self.var_9868a2f0e52a82bd, damagedpartname ) )
    {
        if ( getdvarint( @"hash_cfd8073837710cef" ) )
        {
            /#
                print3d( self.origin, "<dev string:x328>" + damagedpartname, ( 1, 1, 1 ), 1, 0.2, 1000, 1 );
            #/
        }
        
        return;
    }
    
    function_98c558b067cdd616();
    
    if ( !skipregen )
    {
        addhealth( amount * 0.5 );
    }
    
    hits = 0;
    
    if ( isdefined( objweapon ) && isdefined( objweapon.classname ) )
    {
        if ( !isdefined( meansofdeath ) || meansofdeath != "MOD_IMPACT" )
        {
            switch ( objweapon.classname )
            {
                case #"hash_719417cb1de832b6":
                    hits = 0.5;
                    break;
                case #"hash_8cdaf2e4ecfe5b51":
                    hits = 1;
                    break;
                case #"hash_6191aaef9f922f96":
                    hits = 4;
                    break;
                case #"hash_61e969dacaaf9881":
                case #"hash_e224d0b635d0dadd":
                    hits = 8;
                    break;
            }
        }
    }
    else if ( isdefined( meansofdeath ) )
    {
        switch ( meansofdeath )
        {
            case #"hash_b1078ff213fddba6":
                hits = 1;
                break;
            case #"hash_a5123f4d02745600":
                hits = 3;
                break;
            case #"hash_61e42661ac27b9f2":
                hits = self.damageableparts[ damagedpartname ];
                break;
        }
    }
    
    if ( iswheelbone( damagedpartname ) && !isplayer( attacker ) || iswheelbone( damagedpartname ) && isai( attacker ) )
    {
        hits *= 0.5;
    }
    
    if ( issubstr( damagedpartname, "tag_wind" ) && isdefined( meansofdeath ) && meansofdeath == "MOD_IMPACT" && isdefined( objweapon ) && is_equal( objweapon.classname, "grenade" ) )
    {
        hits = 2;
    }
    
    if ( iswheelbone( damagedpartname ) && skiptire )
    {
        hits = 0;
    }
    
    self.damageableparts[ damagedpartname ] -= hits;
    
    /#
        thread function_fe805ffb3ad24253( damagedpartname, hits, origin );
    #/
    
    if ( self.damageableparts[ damagedpartname ] <= 0 )
    {
        if ( iswheelbone( damagedpartname ) && !skiptire )
        {
            if ( isvehiclehusk() || getdvarint( @"hash_f0f3e5a83f3f2843" ) && function_34a2eb36fbca6e89() )
            {
                numwheels = function_f18b042694d92f4();
                
                switch ( damagedpartname )
                {
                    case #"hash_176975cfc4da6ccf":
                        function_b1aab60676c543fe( 0, "fl" );
                        break;
                    case #"hash_7882ec199836b440":
                        function_b1aab60676c543fe( 1, "fr" );
                        break;
                    case #"hash_8990a9b7b683c2bd":
                        function_b1aab60676c543fe( 2, "ml" );
                        break;
                    case #"hash_a4c07c681d7d1836":
                        function_b1aab60676c543fe( 3, "mr" );
                        break;
                    case #"hash_e88679f8ff04aa03":
                        if ( numwheels > 4 )
                        {
                            function_b1aab60676c543fe( 4, "bl" );
                        }
                        else
                        {
                            function_b1aab60676c543fe( 2, "bl" );
                        }
                        
                        break;
                    case #"hash_95f9a89e42cf970c":
                        if ( numwheels > 4 )
                        {
                            function_b1aab60676c543fe( 5, "br" );
                        }
                        else
                        {
                            function_b1aab60676c543fe( 3, "br" );
                        }
                        
                        break;
                }
            }
        }
        
        utility::function_3677f2be30fdd581( damagedpartname, "death" );
        classname = get_vehicle_classname();
        
        if ( isdefined( level.vehicle.templates.dependentparts[ classname ] ) && isdefined( level.vehicle.templates.dependentparts[ classname ][ damagedpartname ] ) )
        {
            foreach ( part in level.vehicle.templates.dependentparts[ classname ][ damagedpartname ] )
            {
                if ( self.damageableparts[ part ] > 0 )
                {
                    utility::function_3677f2be30fdd581( part, "death" );
                }
            }
        }
        
        return;
    }
    
    if ( issubstr( damagedpartname, "tag_wind" ) && self.damageableparts[ damagedpartname ] <= 3 )
    {
        utility::function_3677f2be30fdd581( damagedpartname, "webbed" );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x9ec7
// Size: 0x6d
function iswheelbone( damagedpartname )
{
    switch ( damagedpartname )
    {
        case #"hash_176975cfc4da6ccf":
        case #"hash_7882ec199836b440":
        case #"hash_8990a9b7b683c2bd":
        case #"hash_95f9a89e42cf970c":
        case #"hash_a4c07c681d7d1836":
        case #"hash_e88679f8ff04aa03":
            return 1;
        default:
            return 0;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0x9f3c
// Size: 0x52, Type: bool
function vehicle_isalive( vehicle )
{
    if ( !isdefined( vehicle ) )
    {
        return false;
    }
    
    if ( isdefined( vehicle.healthbuffer ) && vehicle.health < vehicle.healthbuffer )
    {
        return false;
    }
    
    if ( vehicle.health <= 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0x9f97
// Size: 0xb2
function grenadeshielded( type, objweapon )
{
    if ( !isdefined( self.script_grenadeshield ) )
    {
        return 0;
    }
    
    type = tolower( type );
    
    if ( !isdefined( type ) || !issubstr( type, "grenade" ) )
    {
        return 0;
    }
    
    if ( isdefined( level.vehicle.templates.var_7412ca7553957e74[ get_vehicle_classname() ] ) )
    {
        if ( array_contains( level.vehicle.templates.var_7412ca7553957e74[ get_vehicle_classname() ], getweaponbasename( objweapon ) ) )
        {
            return 0;
        }
    }
    
    if ( self.script_grenadeshield )
    {
        return 1;
    }
    
    return 0;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xa051
// Size: 0x5c
function bulletshielded( type )
{
    if ( !isdefined( self.script_bulletshield ) )
    {
        return 0;
    }
    
    type = tolower( type );
    
    if ( !isdefined( type ) || !issubstr( type, "bullet" ) || issubstr( type, "explosive" ) )
    {
        return 0;
    }
    
    if ( self.script_bulletshield )
    {
        return 1;
    }
    
    return 0;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xa0b5
// Size: 0x4d
function explosive_bulletshielded( type )
{
    if ( !isdefined( self.script_explosive_bullet_shield ) )
    {
        return 0;
    }
    
    type = tolower( type );
    
    if ( !isdefined( type ) || !issubstr( type, "explosive" ) )
    {
        return 0;
    }
    
    if ( self.script_explosive_bullet_shield )
    {
        return 1;
    }
    
    return 0;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 3
// Checksum 0x0, Offset: 0xa10a
// Size: 0x45, Type: bool
function vehicle_should_regenerate( attacker, type, objweapon )
{
    return function_f237c27c3ba6b34d( type ) || function_e9ed4f44f9d1d682( attacker ) || function_c948f3a1e60efd61( attacker, type, objweapon ) || function_ba6c52398d8ba7fb( type );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xa158
// Size: 0x12, Type: bool
function function_f237c27c3ba6b34d( type )
{
    return type == "MOD_MELEE";
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xa173
// Size: 0x42, Type: bool
function function_e9ed4f44f9d1d682( attacker )
{
    return !isdefined( attacker ) && self.script_team != "neutral" || attacker_isonmyteam( attacker ) || attacker_troop_isonmyteam( attacker ) || is_invulnerable_from_ai( attacker );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 3
// Checksum 0x0, Offset: 0xa1be
// Size: 0x37, Type: bool
function function_c948f3a1e60efd61( attacker, type, objweapon )
{
    return isdefined( level.var_d1d6757f3c58e700 ) && [[ level.var_d1d6757f3c58e700 ]]( attacker, type, objweapon );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0xa1fe
// Size: 0x31, Type: bool
function function_ba6c52398d8ba7fb( type, objweapon )
{
    return bulletshielded( type ) || explosive_bulletshielded( type ) || grenadeshielded( type, objweapon );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xa238
// Size: 0x41
function is_invulnerable_from_ai( attacker )
{
    if ( !isdefined( self.script_ai_invulnerable ) )
    {
        return 0;
    }
    
    if ( isdefined( attacker ) && isai( attacker ) && self.script_ai_invulnerable == 1 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xa281
// Size: 0x83
function attacker_troop_isonmyteam( attacker )
{
    if ( getdvarint( @"hash_fb816855f6554343" ) )
    {
        return 0;
    }
    
    if ( isdefined( self.script_team ) && self.script_team == "allies" && isdefined( attacker ) && isplayer( attacker ) )
    {
        return 1;
    }
    
    if ( isai( attacker ) && is_equal( attacker.team, self.script_team ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xa30c
// Size: 0x5e, Type: bool
function attacker_isonmyteam( attacker )
{
    if ( getdvarint( @"hash_fb816855f6554343" ) )
    {
        return false;
    }
    
    if ( isdefined( attacker ) && isdefined( attacker.script_team ) && isdefined( self.script_team ) && attacker.script_team == self.script_team )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xa373
// Size: 0x20
function vehicle_setwheeldirection( direction )
{
    self.vehiclewheeldirection = ter_op( direction <= 0, 0, 1 );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xa39b
// Size: 0x78
function vehicle_playexhausteffect()
{
    self endon( "entitydeleted" );
    self endon( "death" );
    
    if ( !isdefined( level.vehicle.templates.exhaust_fx[ self.model ] ) )
    {
        return;
    }
    
    while ( true )
    {
        playfxontag( level.vehicle.templates.exhaust_fx[ self.model ], self, "tag_engine_exhaust" );
        waitframe();
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xa41b
// Size: 0x189
function vehicle_playengineeffect()
{
    enginefx = level.vehicle.templates.engine_fx[ get_vehicle_classname() ];
    
    if ( !isdefined( enginefx ) )
    {
        return;
    }
    
    effectdelay = 0.25;
    prev_effect = undefined;
    var_35c675f4f473ab8c = undefined;
    
    while ( true )
    {
        if ( !vehicle_isalive( self ) )
        {
            return;
        }
        
        var_d1d99b2513672267 = enginefx.effect;
        var_35c675f4f473ab8c = enginefx.effect_tag;
        effort_ratio = self vehicle_getspeed() / self vehicle_gettopspeedforward();
        
        if ( isdefined( self.enginefx_effort_scale ) )
        {
            effort_ratio *= self.enginefx_effort_scale;
        }
        
        if ( isdefined( enginefx.max_effort_effect ) && effort_ratio >= enginefx.max_effort_ratio )
        {
            var_d1d99b2513672267 = enginefx.max_effort_effect;
        }
        else if ( isdefined( enginefx.med_effort_effect ) && effort_ratio >= enginefx.med_effort_ratio )
        {
            var_d1d99b2513672267 = enginefx.med_effort_effect;
        }
        else if ( isdefined( enginefx.min_effort_effect ) && effort_ratio >= enginefx.min_effort_ratio )
        {
            var_d1d99b2513672267 = enginefx.min_effort_effect;
        }
        
        if ( !isdefined( prev_effect ) || prev_effect != var_d1d99b2513672267 )
        {
            if ( isdefined( prev_effect ) )
            {
                stopfxontag( prev_effect, self, var_35c675f4f473ab8c );
                waitframe();
                
                if ( !vehicle_isalive( self ) )
                {
                    return;
                }
            }
            
            playfxontag( var_d1d99b2513672267, self, var_35c675f4f473ab8c );
            prev_effect = var_d1d99b2513672267;
        }
        
        wait effectdelay;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xa5ac
// Size: 0x56
function vehicle_pathdetach()
{
    self.attachedpath = undefined;
    self notify( "newpath" );
    
    if ( ishelicopter() )
    {
        self setgoalyaw( flat_angle( self.angles )[ 1 ] );
        self setvehgoalpos( self.origin + ( 0, 0, 4 ), 1 );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xa60a
// Size: 0x1b
function deathrollon()
{
    if ( self.health > 0 )
    {
        self.rollingdeath = 1;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xa62d
// Size: 0x14
function deathrolloff()
{
    self.rollingdeath = undefined;
    self notify( "deathrolloff" );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xa649
// Size: 0x15d
function get_vehicle_riders_spawners()
{
    spawners = [];
    
    if ( isdefined( self.target ) )
    {
        targets = noself_func_return( "getspawnerarray", self.target );
        
        if ( !isdefined( targets ) )
        {
            targets = getstructarray( self.target, "targetname" );
        }
        
        if ( !isdefined( targets ) )
        {
            targets = [];
        }
        
        foreach ( target in targets )
        {
            if ( isstruct( target ) )
            {
                if ( !isdefined( target.script_demeanor ) )
                {
                    continue;
                }
            }
            else
            {
                if ( !issubstr( target.code_classname, "actor" ) && !issubstr( target.code_classname, "vehicle" ) )
                {
                    continue;
                }
                
                if ( issubstr( target.code_classname, "actor" ) )
                {
                    if ( !isspawner( target ) )
                    {
                        continue;
                    }
                    else if ( issubstr( target.code_classname, "vehicle" ) )
                    {
                        if ( !( target.spawnflags & 2 ) )
                        {
                            continue;
                        }
                    }
                }
            }
            
            if ( isdefined( target.dont_auto_ride ) )
            {
                continue;
            }
            
            spawners[ spawners.size ] = target;
        }
    }
    
    return spawners;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0xa7af
// Size: 0x1b
function setvehgoalpos_wrap( origin, bstop )
{
    return _setvehgoalpos_wrap( origin, bstop );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xa7d3
// Size: 0x49
function vehicle_liftoffvehicle( height )
{
    if ( !isdefined( height ) )
    {
        height = 512;
    }
    
    destination = self.origin + ( 0, 0, height );
    self setneargoalnotifydist( 10 );
    setvehgoalpos_wrap( destination, 1 );
    self waittill( "goal" );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xa824
// Size: 0x28, Type: bool
function vehicle_shouldplaydeathanimation( vehicle )
{
    if ( !vehicle_hasdeathanimations( vehicle ) )
    {
        return false;
    }
    
    if ( istrue( self.vehicle_skipdeathanimation ) )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xa855
// Size: 0x31, Type: bool
function vehicle_hasdeathanimations( vehicle )
{
    return isdefined( level.vehicle.templates.deathanimations[ vehicle get_vehicle_classname() ] );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0xa88f
// Size: 0x1b0
function vehicle_getdeathanimation( vehicle, damagelocation )
{
    deathanimations = level.vehicle.templates.deathanimations[ vehicle get_vehicle_classname() ];
    
    if ( isdefined( damagelocation ) )
    {
        centerofmass = vehicle getpointinbounds( 0.5, 0.5, 0.5 );
        var_4f61353d9ff59711 = damagelocation - centerofmass;
        directions = [];
        directions[ "forward" ] = anglestoforward( vehicle.angles );
        directions[ "right" ] = anglestoright( vehicle.angles );
        directions[ "backward" ] = directions[ "forward" ] * -1;
        directions[ "left" ] = directions[ "right" ] * -1;
        var_d65dafae56aa5229 = undefined;
        largestprojection = -999999;
        directionkeys = [ "forward", "right", "backward", "left" ];
        
        foreach ( currentkey in directionkeys )
        {
            direction = directions[ currentkey ];
            currentprojection = math::scalar_projection( direction, var_4f61353d9ff59711 );
            
            if ( !isdefined( var_d65dafae56aa5229 ) || currentprojection > largestprojection )
            {
                var_d65dafae56aa5229 = currentkey;
                largestprojection = currentprojection;
            }
        }
        
        return deathanimations[ var_d65dafae56aa5229 ];
    }
    
    return random( deathanimations );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xaa47
// Size: 0x91
function vehicle_playdeathanimation( deathanimation )
{
    self vehicle_turnengineoff();
    self_func( "vehicle_orientto", self.origin, self.angles, 0, 0 );
    self useanimtree( #animtree );
    self animscripted( "vehicle_playDeathAnimation", self.origin, self.angles, deathanimation );
    self setneargoalnotifydist( 30 );
    
    if ( ishelicopter() )
    {
        self setvehgoalpos( self.origin, 1 );
        self setgoalyaw( self.angles[ 1 ] );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xaae0
// Size: 0x15
function vehicle_setcrashing( boolean )
{
    self.vehiclecrashing = boolean;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0xaafd
// Size: 0xc6
function vehicle_docrash( attacker, cause )
{
    if ( istrue( self.vehicle_skipdeathcrash ) )
    {
        return;
    }
    
    vehicle_setcrashing( 1 );
    var_b990362c13178e7d = getdvarint( @"hash_31333fbc83a5058f" ) != 0 && ishelicopter() && self vehicle_isphysveh();
    
    if ( self vehicle_isphysveh() && !var_b990362c13178e7d )
    {
        self vehphys_crash();
        
        if ( !istrue( self.dontdisconnectpaths ) )
        {
            self disconnectpaths();
        }
        
        while ( !vehicle_iscorpse() && isdefined( self ) && !vehicle_is_stopped() )
        {
            waitframe();
        }
    }
    else if ( ishelicopter() )
    {
        thread vehicle_helicoptercrash( attacker, cause );
        self waittill( "vehicle_crashDone" );
    }
    
    vehicle_setcrashing( 0 );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0xabcb
// Size: 0x43
function vehicle_helicoptercrash( attacker, cause )
{
    if ( isdefined( attacker ) && isplayer( attacker ) )
    {
        self.original_attacker = attacker;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    detach_getoutrigs();
    thread helicopter_crash_move( attacker, cause );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0xac16
// Size: 0x328
function helicopter_crash_move( attacker, cause )
{
    self endon( "in_air_explosion" );
    
    if ( isdefined( self.perferred_crash_location ) )
    {
        crashloc = self.perferred_crash_location;
    }
    else if ( isdefined( level.vehicle.var_4bd4e750e5a8e895 ) )
    {
        crashloc = [[ level.vehicle.var_4bd4e750e5a8e895 ]]( self );
    }
    else
    {
        assertex( level.vehicle.helicopter_crash_locations.size > 0, "A helicopter tried to crash but you didn't have any script_origins with targetname helicopter_crash_location in the level" );
        unusedlocations = get_unused_crash_locations();
        assertex( unusedlocations.size > 0, "You dont have enough script_origins with targetname helicopter_crash_location in the level" );
        crashloc = getclosest( self.origin, unusedlocations );
    }
    
    assert( isdefined( crashloc ) );
    crashloc.claimed = 1;
    self notify( "newpath" );
    self notify( "deathspin" );
    indirect_zoff = 0;
    direct = 0;
    
    if ( isdefined( crashloc.script_parameters ) && crashloc.script_parameters == "direct" )
    {
        direct = 1;
    }
    
    if ( isdefined( self.heli_crash_indirect_zoff ) )
    {
        direct = 0;
        indirect_zoff = self.heli_crash_indirect_zoff;
    }
    
    if ( direct )
    {
        assert( isdefined( crashloc.radius ) );
        crash_speed = 40;
        self vehicle_setspeed( crash_speed, 15, 10 );
        self setneargoalnotifydist( crashloc.radius );
        self setvehgoalpos( crashloc.origin, 0 );
        thread helicopter_crash_flavor( crashloc.origin, crash_speed );
        waittill_any_2( "goal", "near_goal" );
        helicopter_crash_path( crashloc );
    }
    else
    {
        indirect_target = ( crashloc.origin[ 0 ], crashloc.origin[ 1 ], self.origin[ 2 ] + indirect_zoff );
        
        if ( isdefined( self.heli_crash_lead ) )
        {
            indirect_target = self.origin + self.heli_crash_lead * self vehicle_getvelocity();
            indirect_target = ( indirect_target[ 0 ], indirect_target[ 1 ], indirect_target[ 2 ] + indirect_zoff );
        }
        
        crash_speed = 20;
        
        if ( isdefined( self.crash_speed ) )
        {
            crash_speed = self.crash_speed;
        }
        
        self vehicle_setspeed( crash_speed, 10, 10 );
        self setneargoalnotifydist( 350 );
        self setvehgoalpos( indirect_target, 1 );
        thread helicopter_crash_flavor( indirect_target, 40 );
        
        for ( msg = "blank"; msg != "death" ; msg = "death" )
        {
            msg = waittill_any_3( "goal", "near_goal", "death" );
            
            if ( !isdefined( msg ) && !isdefined( self ) )
            {
                crashloc.claimed = undefined;
                self notify( "vehicle_crashDone" );
                return;
            }
        }
        
        self setvehgoalpos( crashloc.origin, 0 );
        self waittill( "goal" );
        helicopter_crash_path( crashloc );
    }
    
    crashloc.claimed = undefined;
    self notify( "stop_crash_loop_sound" );
    self notify( "vehicle_crashDone" );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xaf46
// Size: 0xa3
function helicopter_crash_path( crashloc )
{
    self endon( "death" );
    self endon( "entitydeleted" );
    
    while ( isdefined( crashloc.target ) )
    {
        crashloc = getstruct( crashloc.target, "targetname" );
        assert( isdefined( crashloc ) );
        radius = 56;
        
        if ( isdefined( crashloc.radius ) )
        {
            radius = crashloc.radius;
        }
        
        self setneargoalnotifydist( radius );
        self setvehgoalpos( crashloc.origin, 0 );
        waittill_any_2( "goal", "near_goal" );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0xaff1
// Size: 0x194
function helicopter_crash_flavor( target_origin, crash_speed )
{
    self endon( "vehicle_crashDone" );
    self clearlookatent();
    
    if ( soundexists( "hind_helicopter_dying_loop" ) )
    {
        self playloopsound( "hind_helicopter_dying_loop" );
    }
    
    style = 0;
    
    if ( isdefined( self.preferred_crash_style ) )
    {
        style = self.preferred_crash_style;
        
        if ( self.preferred_crash_style < 0 )
        {
            style_chance = [ 1, 2, 2 ];
            total = 5;
            rnd = randomint( total );
            chance = 0;
            
            foreach ( val in style_chance )
            {
                chance += val;
                
                if ( rnd < chance )
                {
                    style = i;
                    break;
                }
            }
        }
    }
    
    switch ( style )
    {
        case 1:
            thread helicopter_crash_zigzag();
            break;
        case 2:
            thread helicopter_crash_directed( target_origin, crash_speed );
            break;
        case 3:
            thread helicopter_in_air_explosion();
            break;
        case 4:
            thread helicopter_pilot_death_explosion();
            break;
        case 0:
        default:
            thread helicopter_crash_rotate();
            break;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xb18d
// Size: 0xa1
function helicopter_in_air_explosion()
{
    vehicleclassname = get_vehicle_classname();
    
    if ( isdefined( level.vehicle.templates.vehicle_rocket_death_fx[ vehicleclassname ] ) )
    {
        deathfxstructs = level.vehicle.templates.vehicle_rocket_death_fx[ vehicleclassname ];
        struct = deathfxstructs[ 2 ];
        
        if ( isdefined( struct ) && isdefined( struct.waitdelay ) )
        {
            wait struct.waitdelay;
        }
        
        waitframe();
    }
    
    self notify( "vehicle_crashDone" );
    self notify( "in_air_explosion" );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xb236
// Size: 0x28
function helicopter_pilot_death_explosion()
{
    thread helicopter_crash_rotate();
    waittill_notify_or_timeout( "goal", 5 );
    self notify( "flavor_done" );
    thread helicopter_in_air_explosion();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xb266
// Size: 0x38
function helicopter_unloading_watcher()
{
    if ( !ishelicopter() )
    {
        return;
    }
    
    self endon( "vehicle_crashDone" );
    self waittill( "unloading" );
    self.unloading = 1;
    self waittill( "unloaded" );
    self.unloading = 0;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0xb2a6
// Size: 0x9c
function helicopter_crash_directed( target_origin, crash_speed )
{
    self endon( "vehicle_crashDone" );
    self clearlookatent();
    self setmaxpitchroll( randomintrange( 20, 90 ), randomintrange( 5, 90 ) );
    self setyawspeed( 400, 100, 100 );
    angleoff = 90 * randomintrange( -2, 3 );
    
    for ( ;; )
    {
        totarget = target_origin - self.origin;
        yaw = vectortoyaw( totarget );
        yaw += angleoff;
        self settargetyaw( yaw );
        wait 0.1;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xb34a
// Size: 0xa0
function helicopter_crash_zigzag()
{
    self endon( "vehicle_crashDone" );
    self clearlookatent();
    self setyawspeed( 400, 100, 100 );
    dir = randomint( 2 );
    
    for ( ;; )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        irand = randomintrange( 20, 120 );
        
        if ( dir )
        {
            self settargetyaw( self.angles[ 1 ] + irand );
        }
        else
        {
            self settargetyaw( self.angles[ 1 ] - irand );
        }
        
        dir = 1 - dir;
        rtime = randomfloatrange( 0.5, 1 );
        wait rtime;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xb3f2
// Size: 0x61
function helicopter_crash_rotate()
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

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xb45b
// Size: 0xa7
function get_unused_crash_locations()
{
    unusedlocations = [];
    level.vehicle.helicopter_crash_locations = array_removeundefined( level.vehicle.helicopter_crash_locations );
    
    foreach ( location in level.vehicle.helicopter_crash_locations )
    {
        if ( isdefined( location.claimed ) )
        {
            continue;
        }
        
        unusedlocations[ unusedlocations.size ] = location;
    }
    
    return unusedlocations;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xb50b
// Size: 0x14, Type: bool
function vehicle_iscorpse()
{
    return isdefined( self ) && get_vehicle_classname() == "script_vehicle_corpse";
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xb528
// Size: 0x74
function detach_getoutrigs()
{
    if ( !isdefined( self.fastroperig ) )
    {
        return;
    }
    
    if ( !self.fastroperig.size )
    {
        return;
    }
    
    keys = getarraykeys( self.fastroperig );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        if ( isdefined( self.fastroperig[ keys[ i ] ] ) )
        {
            self.fastroperig[ keys[ i ] ] unlink();
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xb5a4
// Size: 0xe1
function vehicle_setdeathmodel()
{
    if ( !isdefined( level.vehicle.templates.deathmodel[ self.model ] ) )
    {
        return;
    }
    
    if ( istrue( self.vehicle_skipdeathmodel ) )
    {
        return;
    }
    
    if ( self isscriptable() )
    {
        if ( ishelicopter() )
        {
            return;
        }
        
        deathmodel = spawn( "script_model", self.origin );
        deathmodel.angles = self.angles;
        deathmodel setmodel( level.vehicle.templates.deathmodel[ self.model ] );
        return;
    }
    
    self setmodel( level.vehicle.templates.deathmodel[ self.model ] );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xb68d
// Size: 0x124
function function_1e9728e5e662aca3( husk )
{
    if ( isdefined( self.riders ) )
    {
        foreach ( rider in self.riders )
        {
            if ( !isdefined( rider ) )
            {
                continue;
            }
            
            if ( !isalive( rider ) )
            {
                continue;
            }
            
            if ( isdefined( rider._blackboard ) )
            {
                vehicle = rider._blackboard.currentvehicle;
                position = rider._blackboard.var_9176cae5619d7fba;
            }
            else
            {
                vehicle = rider.ridingvehicle;
                position = rider.vehicle_position;
            }
            
            aianims = anim_pos( vehicle, position );
            
            if ( isdefined( aianims ) && isdefined( aianims.sittag ) )
            {
                rider unlink();
            }
            
            rider linkto( husk, aianims.sittag );
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xb7b9
// Size: 0x4ab
function function_5d04267dd0768069( quiet )
{
    if ( !isdefined( level.vehicle.husks ) )
    {
        level.vehicle.husks = [];
    }
    else
    {
        level.vehicle.husks = array_removeundefined( level.vehicle.husks );
    }
    
    velocity = self vehicle_getvelocity();
    
    if ( istrue( self.headondeath ) )
    {
        velocity = self vehicle_getvelocity();
        velocity *= 5;
    }
    
    model = function_d0e99a4f0c29166e();
    colorvariation = "";
    
    if ( issubstr( model, "::" ) )
    {
        colorvariation = strtok( model, "::" )[ 0 ] + "::";
        model = strtok( model, "::" )[ 1 ];
        
        if ( !istrue( level.vehicle.templates.var_893da51cf12b2c8b[ model ] ) )
        {
            colorvariation = "";
        }
    }
    
    self notsolid();
    classname = get_vehicle_classname();
    husk = spawnvehicle( colorvariation + level.vehicle.templates.husk[ model ], "vehicle_husk", level.vehicle.templates.husktype[ model ], self.origin, self.angles, undefined, velocity );
    husk.isvehiclehusk = 1;
    husk.classname_mp = classname;
    husk vehicle_sethealth( level.vehicle.templates.life[ classname ] + 100000 );
    husk.healthstarting = level.vehicle.templates.life[ classname ];
    husk.parentmodel = model;
    husk.explosivehits = 0;
    husk.isstationary = self.isstationary;
    husk.parentlaunchtime = self.var_84bca5671c65c2aa;
    husk.var_1b84f0b023dd1ca7 = self.var_1b84f0b023dd1ca7;
    
    if ( !husk hascomponent( "animator" ) )
    {
        husk addcomponent( "animator" );
    }
    
    self notify( "vehicle_huskCreation", husk );
    
    if ( isdefined( self.var_27c9e774969793bc ) )
    {
        husk thread [[ self.var_27c9e774969793bc ]]();
    }
    
    level.vehicle.husks = array_add( level.vehicle.husks, husk );
    
    if ( isdefined( self.spawnflags ) && ( self.spawnflags & 8 || istrue( husk.isstationary ) ) )
    {
        husk vehphys_parkingbrake( 1 );
    }
    
    husk function_9ce59aa48970a667();
    husk vehicle_turnengineoff();
    husk delaycall( 0.05, &vehphys_crash );
    husk function_98c558b067cdd616();
    
    if ( getdvarint( @"hash_cfd8073837710cef" ) )
    {
        /#
            print3d( husk.origin + ( 0, 0, 3 ), "<dev string:x333>" + velocity, ( 0, 1, 1 ), 1, 0.2, 1000, 1 );
        #/
        
        draw_arrow_time( husk.origin, husk.origin + velocity, ( 0, 1, 1 ), 1000 );
    }
    
    if ( istrue( self.var_1de5acbb26e97918 ) )
    {
        husk.var_1de5acbb26e97918 = self.var_1de5acbb26e97918;
    }
    
    if ( !istrue( quiet ) )
    {
        husk thread function_b43ab7b2056ecb9a();
    }
    
    if ( !istrue( quiet ) && !istrue( self.skiplaunch ) )
    {
        husk thread vehicle_husklaunch( self, undefined, undefined );
    }
    
    /#
        husk thread vehicle_damagedebuginfo();
    #/
    
    husk thread disconnect_paths_whenstopped();
    husk thread function_fd3542824f9c1bd2();
    husk thread function_2d9c04d7fe4e6719( self );
    husk thread function_4286de11e406088f();
    
    if ( isdefined( self.damageableparts ) )
    {
        foreach ( health in self.damageableparts )
        {
            if ( health <= 0 )
            {
                husk.damageableparts[ i ] = 0;
            }
        }
    }
    
    function_1e9728e5e662aca3( husk );
    return husk;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xbc6d
// Size: 0x31
function function_18657584b6bd786a( quiet )
{
    flag_wait( "scriptables_ready" );
    husk = function_5d04267dd0768069( quiet );
    self delete();
    return husk;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xbca7
// Size: 0x55
function function_b43ab7b2056ecb9a( state )
{
    if ( !self isscriptable() )
    {
        return;
    }
    
    if ( !isdefined( state ) )
    {
        state = "on";
    }
    
    utility::function_3677f2be30fdd581( "damage_transition", state );
    utility::function_3677f2be30fdd581( "floor_fire", state );
    
    if ( !istrue( self.var_1b84f0b023dd1ca7 ) )
    {
        utility::function_3677f2be30fdd581( "smoke_heavy", state );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 4
// Checksum 0x0, Offset: 0xbd04
// Size: 0x3c4
function vehicle_husklaunch( parent, vehicleref, spawndata, forcemultiplier )
{
    if ( !self vehicle_isphysveh() )
    {
        return;
    }
    
    if ( istrue( self.isstationary ) )
    {
        if ( getdvarint( @"hash_cfd8073837710cef" ) )
        {
            /#
                print3d( self.origin, "<dev string:x343>", ( 1, 1, 1 ), 1, 0.2, 1000, 1 );
            #/
        }
        
        return;
    }
    
    if ( isdefined( parent ) && istrue( parent.p2phusk ) )
    {
        return;
    }
    
    if ( isdefined( parent ) && istrue( parent.headondeath ) )
    {
        return;
    }
    
    if ( isdefined( parent ) && isdefined( parent.damageinfo ) )
    {
        damagestrength = parent.damageinfo[ "amount" ];
        damagedir = parent.damageinfo[ "direction_vec" ];
        damagelocation = parent.damageinfo[ "damageLocation" ];
        damagemod = parent.damageinfo[ "MOD" ];
    }
    else
    {
        damagestrength = 600;
        damagedir = undefined;
        damagelocation = self.origin;
        damagemod = "";
    }
    
    if ( isdefined( parent ) && isdefined( parent.var_84bca5671c65c2aa ) && gettime() - parent.var_84bca5671c65c2aa < 1000 )
    {
        if ( getdvarint( @"hash_cfd8073837710cef" ) )
        {
            /#
                print3d( damagelocation + ( 0, 0, -3 ), "<dev string:x364>", ( 1, 1, 1 ), 1, 0.2, 1000, 1 );
            #/
        }
        
        damagestrength *= 0.1;
    }
    
    if ( isdefined( damagedir ) )
    {
        damagedir = ( damagedir[ 0 ], damagedir[ 1 ], 0.25 );
    }
    else
    {
        damagedir = ( randomfloatrange( -0.25, 0.25 ), randomfloatrange( -0.25, 0.25 ), 0.25 );
    }
    
    launchstrength = function_90f94b8850010576( damagestrength, damagemod, damagelocation, 0.3 );
    
    if ( isdefined( forcemultiplier ) )
    {
        launchstrength *= forcemultiplier;
    }
    
    if ( isdefined( vehicleref ) && isdefined( level.sharedfuncs ) && isdefined( level.sharedfuncs[ vehicleref ] ) )
    {
        var_fd0de3143acb9a42 = level.sharedfuncs[ vehicleref ][ "vehicle_huskLaunch" ];
        
        if ( isdefined( var_fd0de3143acb9a42 ) )
        {
            self [[ var_fd0de3143acb9a42 ]]( spawndata.initialvelocity );
            
            if ( isdefined( self.damagedir ) )
            {
                damagedir = self.damagedir;
            }
            
            if ( isdefined( self.launchstrength ) )
            {
                launchstrength = self.launchstrength;
            }
        }
    }
    
    self vehphys_impulse( damagedir, launchstrength, 1 );
    
    if ( getdvarint( @"hash_cfd8073837710cef" ) )
    {
        /#
            print3d( damagelocation + ( 0, 0, 6 ), "<dev string:x397>" + gettime(), ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
        #/
        
        /#
            print3d( damagelocation + ( 0, 0, 3 ), "<dev string:x39e>" + launchstrength, ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
        #/
        
        /#
            print3d( damagelocation + ( 0, 0, 0 ), "<dev string:x3b5>" + self function_3dda404001a83ee( "<dev string:x3bc>" ) + "<dev string:x3c1>" + damagestrength, ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
        #/
        
        draw_arrow_time( damagelocation, damagelocation + anglestoforward( vectortoangles( damagedir ) ) * launchstrength, ( 1, 0, 1 ), 1000 );
    }
    
    self.var_84bca5671c65c2aa = gettime();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 4
// Checksum 0x0, Offset: 0xc0d0
// Size: 0x31d
function function_80b9a13a5f971524( amount, damagedir, damagelocation, meansofdeath )
{
    if ( !self vehicle_isphysveh() )
    {
        return;
    }
    
    if ( istrue( self.isstationary ) )
    {
        if ( getdvarint( @"hash_cfd8073837710cef" ) )
        {
            /#
                print3d( damagelocation + ( 0, 0, -3 ), "<dev string:x3cf>", ( 1, 1, 1 ), 1, 0.2, 1000, 1 );
            #/
        }
        
        return;
    }
    
    if ( self.healthactual <= self.healthbuffer + 1 )
    {
        if ( getdvarint( @"hash_cfd8073837710cef" ) )
        {
            /#
                print3d( damagelocation + ( 0, 0, -3 ), "<dev string:x3eb>", ( 1, 1, 1 ), 1, 0.2, 1000, 1 );
            #/
        }
        
        return;
    }
    
    if ( isdefined( self.parentlaunchtime ) && gettime() - self.parentlaunchtime < 1000 )
    {
        if ( getdvarint( @"hash_cfd8073837710cef" ) )
        {
            /#
                print3d( damagelocation + ( 0, 0, -3 ), "<dev string:x408>", ( 1, 1, 1 ), 1, 0.2, 1000, 1 );
            #/
        }
        
        amount *= 0.1;
    }
    
    if ( !isdefined( self.var_84bca5671c65c2aa ) )
    {
        self.var_84bca5671c65c2aa = gettime();
    }
    else if ( gettime() - self.var_84bca5671c65c2aa < 1000 )
    {
        if ( getdvarint( @"hash_cfd8073837710cef" ) )
        {
            /#
                print3d( damagelocation + ( 0, 0, -3 ), "<dev string:x43d>", ( 1, 1, 1 ), 1, 0.2, 1000, 1 );
            #/
        }
        
        amount *= 0.1;
    }
    
    launchstrength = function_90f94b8850010576( amount, meansofdeath, damagelocation );
    damagedir = ( damagedir[ 0 ], damagedir[ 1 ], 0.25 );
    self vehphys_impulse( damagedir, launchstrength, 1 );
    
    if ( getdvarint( @"hash_cfd8073837710cef" ) )
    {
        /#
            print3d( damagelocation + ( 0, 0, 6 ), "<dev string:x397>" + gettime() + "<dev string:x46b>" + self.var_84bca5671c65c2aa, ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
        #/
        
        /#
            print3d( damagelocation + ( 0, 0, 3 ), "<dev string:x486>" + launchstrength, ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
        #/
        
        /#
            print3d( damagelocation + ( 0, 0, 0 ), "<dev string:x3b5>" + self function_3dda404001a83ee( "<dev string:x3bc>" ) + "<dev string:x3c1>" + amount, ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
        #/
        
        draw_arrow_time( damagelocation, damagelocation + anglestoforward( vectortoangles( damagedir ) ) * launchstrength, ( 1, 0, 1 ), 1000 );
    }
    
    self.var_84bca5671c65c2aa = gettime();
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 4
// Checksum 0x0, Offset: 0xc3f5
// Size: 0x12f
function function_90f94b8850010576( amount, meansofdeath, damagelocation, launchscalar )
{
    if ( !isdefined( launchscalar ) )
    {
        launchscalar = 1;
    }
    
    amount = ter_op( amount > 600, 600, amount );
    
    if ( isdefined( meansofdeath ) )
    {
        meansofdeath = tolower( meansofdeath );
        
        if ( meansofdeath == "mod_projectile_splash" )
        {
            amount *= 0.75;
        }
    }
    
    if ( self hascomponent( "p2p" ) )
    {
        amount *= 0.1;
    }
    
    mass = self function_3dda404001a83ee( "mass" );
    maxlaunchstrength = mass * 0.1 * launchscalar;
    normalizedamount = math::normalize_value( 600, 0, amount );
    launchstrength = maxlaunchstrength * normalizedamount;
    
    if ( istank() )
    {
        launchstrength *= 0.25;
    }
    
    if ( getdvarint( @"hash_cfd8073837710cef" ) )
    {
        /#
            print3d( damagelocation + ( 0, 0, 9 ), "<dev string:x49c>" + amount + "<dev string:x4b3>" + normalizedamount, ( 0, 1, 0 ), 1, 0.2, 1000, 1 );
        #/
    }
    
    return launchstrength;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xc52d
// Size: 0x41d
function function_2d9c04d7fe4e6719( parent )
{
    if ( self isscriptable() )
    {
        var_e72978aa7c06ee3c = [ "tag_hood", "tag_antenna", "tag_mirror_left", "tag_mirror_right", "tag_bumper_front", "tag_bumper_back", "tag_windshield_front", "tag_windshield_front_pristine", "tag_windshield_front_web", "tag_windshield_back", "tag_window_front_left", "tag_window_front_right", "tag_window_back_left", "tag_window_back_right", "tag_window_back_left_corner", "tag_window_back_right_corner", "tag_window_sunroof", "tag_hubcap_front_left", "tag_hubcap_front_right", "tag_hubcap_back_left", "tag_hubcap_back_right", "tag_wheel_spare" ];
        
        foreach ( part in var_e72978aa7c06ee3c )
        {
            if ( isdefined( parent.damageableparts ) && isdefined( parent.damageableparts[ part ] ) )
            {
                if ( parent.damageableparts[ part ] <= 0 )
                {
                    state = "hide";
                }
                else
                {
                    self.damageableparts[ part ] = 0;
                    state = "death";
                }
                
                utility::function_3677f2be30fdd581( part, state );
            }
        }
        
        var_de1af8851d79e89 = [ "tag_door_front_left", "tag_door_front_right", "tag_door_back_left", "tag_door_back_right", "tag_bumper_front_damaged", "tag_bumper_back_damaged", "tag_light_front_left", "tag_light_front_right", "tag_light_front_left_2", "tag_light_front_right_2", "tag_light_back_left", "tag_light_back_right", "tag_light_back_left_2", "tag_light_back_right_2", "tag_light_top_left", "tag_light_top_right", "tag_light_front_middle", "tag_light_front_top", "tag_light_back_top", "tag_wheel_center_front_left", "tag_wheel_center_front_right", "tag_wheel_center_middle_left", "tag_wheel_center_middle_right", "tag_wheel_center_back_left", "tag_wheel_center_back_right" ];
        
        foreach ( part in var_de1af8851d79e89 )
        {
            state = undefined;
            
            if ( isdefined( parent.damageableparts ) && isdefined( parent.damageableparts[ part ] ) && parent.damageableparts[ part ] <= 0 )
            {
                classname = get_vehicle_classname();
                
                if ( iswheelbone( part ) && getdvarint( @"hash_4bd69b09131419ca" ) == 1 )
                {
                    function_b958f96bb17ec92d( part, 0, "MOD_EXECUTION", undefined, level.player, 1, self gettagorigin( part ), 0 );
                }
                else
                {
                    self.damageableparts[ part ] = 0;
                    state = "hide";
                }
            }
            else if ( isdefined( self.damageableparts ) && isdefined( self.damageableparts[ part ] ) && randomint( 2 ) == 0 )
            {
                classname = get_vehicle_classname();
                
                if ( iswheelbone( part ) && getdvarint( @"hash_4bd69b09131419ca" ) == 1 )
                {
                    function_b958f96bb17ec92d( part, 0, "MOD_EXECUTION", undefined, level.player, 1, self gettagorigin( part ), 0 );
                }
                else
                {
                    self.damageableparts[ part ] = 0;
                    state = "death";
                }
            }
            
            if ( isdefined( state ) )
            {
                utility::function_3677f2be30fdd581( part, state );
            }
        }
        
        return;
    }
    
    /#
        thread function_a1df9e8f97742aaf( "<dev string:x4c7>", 1, ( 1, 0, 0 ) );
    #/
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xc952
// Size: 0x19
function function_f18b042694d92f4()
{
    if ( self tagexists( "tag_wheel_center_middle_left" ) )
    {
        return 6;
    }
    
    return 4;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0xc973
// Size: 0xe2
function function_b1aab60676c543fe( wheelnum, position )
{
    if ( !isdefined( self.var_488f0fc49178c96 ) )
    {
        self.var_488f0fc49178c96 = 0;
    }
    
    self.var_488f0fc49178c96 |= 1 << wheelnum;
    
    if ( isdefined( self.driver ) && isplayer( self.driver ) )
    {
        level.player setclientomnvar( "ui_veh_flat_tire_mask", self.var_488f0fc49178c96 );
    }
    
    classname = get_vehicle_classname();
    
    if ( !isdefined( self.blowntires ) )
    {
        self.blowntires = [];
    }
    
    if ( !array_contains( self.blowntires, position ) )
    {
        self blowuptire( wheelnum );
        self.blowntires = array_add( self.blowntires, position );
        self notify( "vehicle_tire_blown", position );
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xca5d
// Size: 0x53b
function function_fd3542824f9c1bd2()
{
    self endon( "death" );
    self endon( "stop collision watcher" );
    self vehphys_enablecollisioncallback( 1 );
    
    while ( true )
    {
        self.collisioninfo = undefined;
        classname = get_vehicle_classname();
        self waittill( "collision", body0, body1, flag0, flag1, position, normal, impulse, ent, collzone );
        
        if ( istrue( self.var_721298f6d1910c00 ) )
        {
            return;
        }
        
        self.collisioninfo[ "impulse" ] = impulse;
        
        /#
            if ( getdvarint( @"hash_cfd8073837710cef" ) )
            {
                draw_angles( vectortoangles( normal ), position, ( 0, 1, 0 ), 1000, 10 );
                line( position, position + anglestoforward( vectortoangles( normal ) ) * -32, ( 1, 0, 0 ), 1, 0, 1000 );
                line( position, self.origin, ( 0, 1, 1 ), 1, 0, 1000 );
                print3d( self.origin + ( 0, 0, 3 ), classname, ( 0, 1, 1 ), 1, 0.2, 1000, 1 );
                print3d( self.origin, "<dev string:x4e3>" + impulse, ( 0, 1, 1 ), 1, 0.2, 1000, 0 );
                print3d( self.origin + ( 0, 0, -3 ), "<dev string:x4ed>" + collzone, ( 0, 1, 1 ), 1, 0.2, 1000, 0 );
                
                if ( isdefined( ent ) )
                {
                    print3d( self.origin + ( 0, 0, -6 ), "<dev string:x4f8>" + vectordot( anglestoforward( self.angles ), anglestoforward( ent.angles ) ), ( 0, 1, 1 ), 1, 0.2, 1000, 0 );
                }
            }
        #/
        
        if ( isdefined( ent ) && ent.code_classname == "script_vehicle" && isdefined( ent.collisioninfo ) && isdefined( ent.collisioninfo[ "impulse" ] ) && ent.collisioninfo[ "impulse" ] > impulse )
        {
            impulse = ent.collisioninfo[ "impulse" ];
            self.collisioninfo[ "impulse" ] = ent.collisioninfo[ "impulse" ];
        }
        
        if ( !function_d7fe44ffb08b499a() && impulse >= 0.15 )
        {
            damage = impulse * 400;
            damagescaled = function_a183f52b983f5769( damage );
            closestparttodamage = function_7bba68b7e28ec873( 64, position, 0, 1 );
            
            if ( isdefined( closestparttodamage ) )
            {
                if ( getdvarint( @"hash_cfd8073837710cef" ) )
                {
                    classname = get_vehicle_classname();
                    classname = getsubstr( classname, 19, classname.size );
                    
                    /#
                        print3d( self gettagorigin( closestparttodamage ), classname + "<dev string:x4fe>" + closestparttodamage + "<dev string:x503>" + damagescaled, ( 1, 0, 0 ), 1, 0.2, 1000, 0 );
                    #/
                    
                    /#
                        line( position, self gettagorigin( closestparttodamage ), ( 1, 0, 0 ), 1, 0, 1000 );
                    #/
                }
                
                if ( impulse > 0.8 )
                {
                    function_97de184a1b867545();
                    partstodamage = function_7bba68b7e28ec873( 1000, position, 1, 1 );
                    
                    for ( i = 0; i < partstodamage.size ; i++ )
                    {
                        if ( i == 5 )
                        {
                            break;
                        }
                        
                        thread function_b958f96bb17ec92d( partstodamage[ i ], 0, "MOD_EXECUTION", undefined, level.player, 1, position, 1 );
                    }
                }
                else
                {
                    thread function_b958f96bb17ec92d( closestparttodamage, 0, "MOD_IMPACT", undefined, level.player, 1, position, 1 );
                }
            }
            
            if ( !function_9e9dfc6f77569f4d() && !isvehiclehusk() && !ent isvehiclehusk() )
            {
                var_aa8369f87b6b7363 = function_ab048fa9b5ad972( ent, position, impulse, collzone );
                
                if ( var_aa8369f87b6b7363 == 1 )
                {
                    vehicle_headondeath( ent );
                }
                else if ( var_aa8369f87b6b7363 != 2 )
                {
                    vehicle_damage( damagescaled, undefined, "MOD_IMPACT" );
                }
            }
        }
        
        if ( isvehiclehusk() && isdefined( ent ) )
        {
            if ( !isdefined( self.vehiclecollisions ) )
            {
                self.vehiclecollisions = 0;
            }
            
            if ( ent.code_classname == "script_vehicle" )
            {
                self.vehiclecollisions += 1;
            }
            
            if ( self.vehiclecollisions >= 5 )
            {
                ents = self getlinkedchildren();
                ents = array_add( ents, self );
                array_delete( ents );
            }
        }
        
        wait 1;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 4
// Checksum 0x0, Offset: 0xcfa0
// Size: 0x259
function function_ab048fa9b5ad972( ent, position, impulse, collzone )
{
    if ( ishelicopter() || ent ishelicopter() )
    {
        return 0;
    }
    
    if ( isboat() || ent isboat() )
    {
        return 0;
    }
    
    if ( getdvarint( @"hash_7598045ee90e851d" ) == 1 && impulse > 0.4 && isdefined( ent.classname_mp ) && isdefined( self.classname_mp ) && isdefined( ent ) && ent.code_classname == "script_vehicle" && ent function_5ae2b449b60714ca( position ) && function_5ae2b449b60714ca( position ) && vectordot( anglestoforward( self.angles ), anglestoforward( ent.angles ) ) < -0.9 && collzone == 0 )
    {
        if ( !isdefined( level.vehicle.templates.explosivehits[ self.classname_mp ] ) || !isdefined( level.vehicle.templates.explosivehits[ ent.classname_mp ] ) )
        {
            return 1;
        }
        
        if ( level.vehicle.templates.explosivehits[ self.classname_mp ] < level.vehicle.templates.explosivehits[ ent.classname_mp ] )
        {
            return 1;
        }
        
        if ( level.vehicle.templates.explosivehits[ self.classname_mp ] == level.vehicle.templates.explosivehits[ ent.classname_mp ] )
        {
            if ( !isdefined( self.driver ) || !isplayer( self.driver ) )
            {
                return 1;
            }
        }
        
        if ( function_79a6e6e740893346() < self.healthstarting * 0.5 )
        {
            return 1;
        }
        
        vehicle_damage( self.healthstarting * 0.5, undefined, "MOD_IMPACT" );
        return 2;
    }
    
    return 0;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xd202
// Size: 0x83, Type: bool
function function_5ae2b449b60714ca( point )
{
    dot = 0;
    tag = "tag_wheel_center_front_left";
    
    if ( !self tagexists( "tag_wheel_center_front_left" ) )
    {
        /#
            print( "<dev string:x508>" );
        #/
        
        tag = "tag_origin";
    }
    
    to_point = point - self gettagorigin( tag );
    forward = anglestoforward( self.angles );
    dot = vectordot( to_point, forward );
    return dot > 0;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xd28e
// Size: 0x85
function vehicle_headondeath( ent )
{
    if ( getdvarint( @"hash_cfd8073837710cef" ) )
    {
        classname = get_vehicle_classname();
        
        /#
            print3d( self.origin + ( 0, 0, 60 ), classname + "<dev string:x545>", ( 1, 0, 0 ), 1, 1, 1000, 1 );
        #/
    }
    
    self.headondeath = 1;
    self notify( "vehicle_headOnDeath" );
    vehicle_kill( ent );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 4
// Checksum 0x0, Offset: 0xd31b
// Size: 0x15f
function function_7bba68b7e28ec873( alloweddist, damagelocation, returnarray, notires )
{
    function_98c558b067cdd616();
    
    if ( self.damageableparts.size == 0 )
    {
        if ( istrue( returnarray ) )
        {
            return [];
        }
        else
        {
            return;
        }
    }
    
    parts = function_c7dde17f06deb794( self.damageableparts, damagelocation );
    
    foreach ( i, part in parts )
    {
        if ( self.damageableparts[ part ] <= 0 )
        {
            parts = array_remove_index( parts, i, 1 );
        }
    }
    
    if ( istrue( notires ) )
    {
        foreach ( part in parts )
        {
            if ( iswheelbone( part ) )
            {
                parts = array_remove_index( parts, i, 1 );
            }
        }
    }
    
    firstpart = function_350e192b13bea45c( parts );
    firstpart = function_5aaaaa0dc9a36d29( firstpart );
    
    if ( istrue( returnarray ) )
    {
        return parts;
    }
    
    if ( isdefined( firstpart ) && distancesquared( damagelocation, self gettagorigin( firstpart ) ) <= squared( alloweddist ) )
    {
        return firstpart;
    }
    
    if ( istrue( returnarray ) )
    {
        return [];
    }
    
    return;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 1
// Checksum 0x0, Offset: 0xd482
// Size: 0x51
function function_5aaaaa0dc9a36d29( part )
{
    if ( !isdefined( part ) )
    {
        return undefined;
    }
    
    if ( part == "tag_bumper_front_damaged" || part == "tag_bumper_back_damaged" )
    {
        undamagedbumper = getsubstr( part, 0, part.size - 8 );
        
        if ( utility::function_35c178c80fa19cbd( undamagedbumper, "death" ) )
        {
            return part;
        }
        
        return undamagedbumper;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0xd4db
// Size: 0x4d
function function_c7dde17f06deb794( array, damagelocation )
{
    assertex( isdefined( array ), "Array not defined." );
    self.partdamagelocation = damagelocation;
    keys = getarraykeys( array );
    keys = array_sort_with_func( keys, &part_distance );
    return keys;
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 2
// Checksum 0x0, Offset: 0xd531
// Size: 0x3e, Type: bool
function part_distance( parta, partb )
{
    return distancesquared( self gettagorigin( parta ), self.partdamagelocation ) < distancesquared( self gettagorigin( partb ), self.partdamagelocation );
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xd578
// Size: 0x2ba
function function_4286de11e406088f()
{
    self notify( "stop_damageLogic" );
    self endon( "death" );
    self endon( "stop_damageLogic" );
    
    /#
        thread function_a1df9e8f97742aaf( "<dev string:x554>", 2, ( 0, 1, 1 ) );
    #/
    
    while ( self.health > 0 )
    {
        self.damageinfo = undefined;
        self waittill( "damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time );
        partname = scripts\common\vehicle::function_8ed0ffa3f8be7c75( partname );
        attachtagname = scripts\common\vehicle::function_8ed0ffa3f8be7c75( attachtagname );
        damagedpartname = ter_op( attachtagname != "", attachtagname, partname );
        amount = function_8f700dc8e0d2fa89( amount, meansofdeath, time );
        self.damageinfo[ "amount" ] = amount;
        self.damageinfo[ "attacker" ] = attacker;
        self.damageinfo[ "direction_vec" ] = direction_vec;
        self.damageinfo[ "damageLocation" ] = damagelocation;
        self.damageinfo[ "MOD" ] = meansofdeath;
        self.damageinfo[ "weapon" ] = objweapon;
        
        if ( function_d7fe44ffb08b499a() )
        {
            /#
                thread function_a1df9e8f97742aaf( "<dev string:x225>", 1, ( 0, 1, 0 ) );
            #/
            
            self.health = self.healthactual;
            continue;
        }
        
        if ( !function_b9ea9d0702abf6fd( self.health, amount, direction_vec, damagelocation, meansofdeath, objweapon, attacker, inflictor ) )
        {
            /#
                thread function_a1df9e8f97742aaf( meansofdeath + "<dev string:x29c>" + amount + "<dev string:x2b1>" + damagedpartname + "<dev string:x2b5>" + self.health + "<dev string:x23f>" + time );
            #/
            
            if ( meansofdeath == "MOD_MELEE" )
            {
                function_a1ed6ce90e57bd32( amount, damagelocation, meansofdeath, objweapon, attacker );
            }
            else
            {
                thread function_b958f96bb17ec92d( damagedpartname, amount, meansofdeath, objweapon, attacker );
            }
        }
        
        if ( function_9e9dfc6f77569f4d() )
        {
            /#
                thread function_a1df9e8f97742aaf( "<dev string:x27c>", 1, ( 0, 1, 0 ) );
            #/
            
            self.health = self.healthactual;
            continue;
        }
        
        self.healthactual = self.health;
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xd83a
// Size: 0x19d
function vehicle_damagedebuginfo()
{
    self endon( "death" );
    
    if ( !isdefined( self.damagedebuginfo ) )
    {
        self.damagedebuginfo = spawnstruct();
        self.damagedebuginfo.text[ 0 ] = "";
        self.damagedebuginfo.color[ 0 ] = ( 1, 1, 1 );
        self.damagedebuginfo.text[ 1 ] = "";
        self.damagedebuginfo.color[ 1 ] = ( 1, 1, 1 );
        self.damagedebuginfo.text[ 2 ] = "";
        self.damagedebuginfo.color[ 2 ] = ( 1, 1, 1 );
    }
    
    for ( ;; )
    {
        if ( !getdvarint( @"hash_cfd8073837710cef" ) )
        {
        }
        else
        {
            zoffset = 70;
            
            for ( i = 0; i < self.damagedebuginfo.text.size ; i++ )
            {
                if ( isdefined( self.damagedebuginfo.text[ i ] ) )
                {
                    zoffset -= 3;
                    
                    /#
                        print3d( self.origin + ( 0, 0, zoffset ), self.damagedebuginfo.text[ i ], self.damagedebuginfo.color[ i ], 1, 0.2, 1, 1 );
                    #/
                }
            }
        }
        
        waitframe();
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 4
// Checksum 0x0, Offset: 0xd9df
// Size: 0x144
function function_a1df9e8f97742aaf( text, linenum, color, bone )
{
    if ( !isdefined( self.damagedebuginfo ) )
    {
        self.damagedebuginfo = spawnstruct();
    }
    
    if ( !isdefined( self.var_4eb5f18e4aff3101 ) )
    {
        self.var_4eb5f18e4aff3101 = 0;
    }
    
    if ( !isdefined( color ) )
    {
        color = ( 1, 1, 1 );
    }
    
    queuesize = 12;
    
    if ( !isdefined( linenum ) )
    {
        linenum = 3;
        
        if ( self.var_4eb5f18e4aff3101 < queuesize )
        {
            self.var_4eb5f18e4aff3101 += 1;
        }
        
        for ( i = queuesize; i > linenum ; i-- )
        {
            self.damagedebuginfo.text[ i ] = self.damagedebuginfo.text[ i - 1 ];
            self.damagedebuginfo.color[ i ] = self.damagedebuginfo.color[ i - 1 ];
        }
    }
    
    self.damagedebuginfo.text[ linenum ] = text;
    self.damagedebuginfo.color[ linenum ] = color;
}

/#

    // Namespace vehicle_code / scripts\common\vehicle_code
    // Params 3
    // Checksum 0x0, Offset: 0xdb2b
    // Size: 0x10a, Type: dev
    function function_fe805ffb3ad24253( damagedpartname, amount, origin )
    {
        self notify( "<dev string:x55a>" + damagedpartname );
        self endon( "<dev string:x566>" );
        self endon( "<dev string:x55a>" + damagedpartname );
        originoffset = undefined;
        
        if ( isdefined( origin ) )
        {
            originoffset = origin - self.origin;
        }
        
        time = gettime();
        
        for ( ;; )
        {
            if ( !getdvarint( @"hash_cfd8073837710cef" ) )
            {
            }
            else
            {
                if ( gettime() - time > 10000 )
                {
                    break;
                }
                
                if ( isdefined( originoffset ) )
                {
                    line( self.origin + originoffset, self gettagorigin( damagedpartname, 1 ), ( 1, 1, 1 ), 1, 0, 1 );
                }
                
                print3d( self gettagorigin( damagedpartname, 1 ), damagedpartname + "<dev string:x29c>" + amount + "<dev string:x2b5>" + self.damageableparts[ damagedpartname ] + "<dev string:x23f>" + time, ( 1, 1, 1 ), 1, 0.2, 1, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xdc3d
// Size: 0x98
function function_ceca0fbe6b37349a()
{
    self endon( "death" );
    flag_wait( "scriptables_ready" );
    
    while ( true )
    {
        level.player waittill( "ads_pressed" );
        
        if ( isdefined( self.driver ) && isplayer( self.driver ) )
        {
            ontime = gettime();
            vehicle_lights_on( "brakelights" );
            level.player waittill( "ads_released" );
            
            if ( gettime() - ontime < 300 )
            {
                wait 0.3;
            }
            
            vehicle_lights_on( "daylights" );
        }
    }
}

// Namespace vehicle_code / scripts\common\vehicle_code
// Params 0
// Checksum 0x0, Offset: 0xdcdd
// Size: 0xba
function function_c2b5282b537a56bc()
{
    if ( !self isscriptable() )
    {
        return;
    }
    
    self endon( "death" );
    flag_wait( "scriptables_ready" );
    
    if ( !self getscriptablehaspart( "flag" ) )
    {
        return;
    }
    
    while ( true )
    {
        velocityspeed = length( self vehicle_getvelocity() ) / 17.6;
        
        if ( velocityspeed > 35 )
        {
            utility::function_3677f2be30fdd581( "flag", "fast" );
        }
        else if ( velocityspeed > 7 )
        {
            utility::function_3677f2be30fdd581( "flag", "medium" );
        }
        else if ( velocityspeed > 2 )
        {
            utility::function_3677f2be30fdd581( "flag", "slow" );
        }
        else
        {
            utility::function_3677f2be30fdd581( "flag", "stopped" );
        }
        
        wait 0.1;
    }
}

/#

    // Namespace vehicle_code / scripts\common\vehicle_code
    // Params 0
    // Checksum 0x0, Offset: 0xdd9f
    // Size: 0x218, Type: dev
    function init_vehicle_spawner_devgui()
    {
        setdvarifuninitialized( @"hash_e73c951b937ce2c2", "<dev string:x56c>" );
        function_a9a864379a098ad6( "<dev string:x56d>", "<dev string:x594>", &function_48d05ac8c8af934f, 0, 2 );
        var_11f099113be884b5 = function_e3b6f7bd4cb6ce92();
        ground_vehicles = [];
        water_vehicles = [];
        air_vehicles = [];
        
        if ( isdefined( var_11f099113be884b5 ) )
        {
            foreach ( var_31e4e9a915c4851 in var_11f099113be884b5 )
            {
                if ( isdefined( var_31e4e9a915c4851.type ) && isdefined( var_31e4e9a915c4851.model ) )
                {
                    if ( var_31e4e9a915c4851.type == "<dev string:x5aa>" )
                    {
                        ground_vehicles[ ground_vehicles.size ] = var_31e4e9a915c4851;
                        continue;
                    }
                    
                    if ( var_31e4e9a915c4851.type == "<dev string:x5b1>" )
                    {
                        water_vehicles[ water_vehicles.size ] = var_31e4e9a915c4851;
                        continue;
                    }
                    
                    if ( var_31e4e9a915c4851.type == "<dev string:x5b7>" )
                    {
                        air_vehicles[ air_vehicles.size ] = var_31e4e9a915c4851;
                    }
                }
            }
        }
        
        function_6e7290c8ee4f558b( "<dev string:x5bb>" );
        
        for ( index = 0; index < ground_vehicles.size ; index++ )
        {
            vehicletype = getxhashsourcename( ground_vehicles[ index ].vehicletype );
            function_b23a59dfb4ca49a1( vehicletype, "<dev string:x5eb>" + vehicletype, &function_24af60cc7030872d );
        }
        
        function_fe953f000498048f();
        function_6e7290c8ee4f558b( "<dev string:x60c>" );
        
        for ( index = 0; index < water_vehicles.size ; index++ )
        {
            vehicletype = getxhashsourcename( water_vehicles[ index ].vehicletype );
            function_b23a59dfb4ca49a1( vehicletype, "<dev string:x5eb>" + vehicletype, &function_24af60cc7030872d );
        }
        
        function_fe953f000498048f();
        function_6e7290c8ee4f558b( "<dev string:x63b>" );
        
        for ( index = 0; index < air_vehicles.size ; index++ )
        {
            vehicletype = getxhashsourcename( air_vehicles[ index ].vehicletype );
            function_b23a59dfb4ca49a1( vehicletype, "<dev string:x5eb>" + vehicletype, &function_24af60cc7030872d );
        }
        
        function_fe953f000498048f();
    }

    // Namespace vehicle_code / scripts\common\vehicle_code
    // Params 0
    // Checksum 0x0, Offset: 0xdfbf
    // Size: 0xe1, Type: dev
    function function_48d05ac8c8af934f()
    {
        vehicletype = getdvar( @"hash_e73c951b937ce2c2", "<dev string:x56c>" );
        
        if ( vehicletype != "<dev string:x56c>" )
        {
            player = level.players[ 0 ];
            
            if ( !isdefined( player ) )
            {
                return;
            }
            
            forward = anglestoforward( player.angles );
            spawnposition = player.origin + ( 0, 0, 100 ) + forward * 300;
            spawnangles = player.angles * ( 0, 1, 0 );
            vehicle = spawnvehicle( undefined, "<dev string:x668>", vehicletype, spawnposition, spawnangles );
            
            if ( !isdefined( vehicle.interactdata ) )
            {
                vehicle makeusable();
            }
        }
    }

    // Namespace vehicle_code / scripts\common\vehicle_code
    // Params 1
    // Checksum 0x0, Offset: 0xe0a8
    // Size: 0x39, Type: dev
    function function_24af60cc7030872d( param )
    {
        vehicletype = param[ 0 ];
        setdvar( @"hash_e73c951b937ce2c2", vehicletype );
        iprintln( "<dev string:x67c>" + vehicletype );
    }

#/
