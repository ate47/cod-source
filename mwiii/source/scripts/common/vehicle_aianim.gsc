#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\vehicle\vehicle_common;

#namespace vehicle_aianim;

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x665
// Size: 0x5f4
function guy_enter( guy, var_5b0cab0a9420da60 )
{
    guy endon( "death_or_disconnect" );
    assertex( !isspawner( self ), "<dev string:x1c>" );
    assertex( !isdefined( guy.ridingvehicle ), "<dev string:x42>" );
    
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.vehicletype ) )
    {
        return;
    }
    
    classname = get_vehicle_classname();
    vehicleanim = level.vehicle.templates.aianims[ classname ];
    self.attachedguys[ self.attachedguys.size ] = guy;
    pos = set_pos( guy, vehicleanim );
    
    if ( !isdefined( pos ) )
    {
        return;
    }
    
    if ( pos == 0 )
    {
        guy.drivingvehicle = 1;
    }
    
    animpos = anim_pos( self, pos );
    self.usedpositions[ pos ] = 1;
    guy.vehicle_position = pos;
    guy.vehicle_idling = 0;
    
    if ( isdefined( animpos.delay ) )
    {
        guy.delay = animpos.delay;
        
        if ( isdefined( animpos.delayinc ) )
        {
            self.delayer = guy.delay;
        }
    }
    
    if ( isdefined( animpos.delayinc ) )
    {
        self.delayer += animpos.delayinc;
        guy.delay = self.delayer;
    }
    
    guy.ridingvehicle = self;
    guy.orghealth = guy.health;
    guy.vehicle_idle = animpos.idle;
    guy.vehicle_standattack = animpos.standattack;
    
    if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
    {
        guy.deathanim = animpos.death;
        guy.deathanimscript = animpos.deathscript;
    }
    
    guy.standing = 0;
    guy.allowdeath = 1;
    
    if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
    {
        if ( isdefined( guy.deathanim ) && !isdefined( guy.magic_bullet_shield ) && vehicle_allows_rider_death() )
        {
            if ( guy.vehicle_position != 0 || vehicle_allows_driver_death() )
            {
                guy.allowdeath = !isdefined( guy.script_allowdeath ) || guy.script_allowdeath;
            }
        }
    }
    else if ( !isdefined( guy.magic_bullet_shield ) && vehicle_allows_rider_death() )
    {
        guy.allowdeath = !isdefined( guy.script_allowdeath ) || guy.script_allowdeath;
    }
    
    if ( !isdefined( guy.classname ) )
    {
        return;
    }
    
    if ( guy.classname == "script_model" )
    {
        if ( isdefined( animpos.death ) && guy.allowdeath && ( !isdefined( guy.script_allowdeath ) || guy.script_allowdeath ) )
        {
            thread guy_death( guy, animpos );
        }
    }
    
    self.riders[ self.riders.size ] = guy;
    
    if ( guy.classname != "script_model" && spawn_failed( guy ) )
    {
        return;
    }
    
    org = self gettagorigin( animpos.sittag );
    angles = self gettagangles( animpos.sittag );
    
    if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
    {
        link_to_sittag( guy, animpos.sittag, animpos.sittag_origin_offset, animpos.sittag_angles_offset, animpos.linktoblend );
    }
    else if ( guy.classname != "script_model" && !guy hasvehicle() )
    {
        chosenpos = vehicle_getinstart( pos );
        guy entervehicle( self, 1, chosenpos, animpos );
    }
    
    if ( isai( guy ) )
    {
        if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
        {
            guy forceteleport( org, angles );
        }
        
        if ( isdefined( animpos.bhasgunwhileriding ) && !animpos.bhasgunwhileriding )
        {
            guy gun_remove();
        }
        
        if ( guy_should_man_turret( animpos ) )
        {
            thread guy_man_turret( guy, pos, var_5b0cab0a9420da60 );
        }
    }
    else
    {
        if ( isdefined( animpos.bhasgunwhileriding ) && !animpos.bhasgunwhileriding )
        {
            detach_models_with_substr( guy, "weapon_" );
        }
        
        guy.origin = org;
        guy.angles = angles;
    }
    
    if ( pos == 0 )
    {
        self.driver = guy;
        
        if ( getdvarint( @"hash_9403d7d31fc1d981" ) || isdefined( vehicleanim[ 0 ].death ) )
        {
            thread driverdead( guy );
        }
    }
    
    self notify( "guy_entered", guy, pos );
    guy notify( "loaded" );
    scripts\engine\utility::ent_flag_clear( "unloaded" );
    thread guy_handle( guy, pos );
    
    if ( isdefined( animpos.rider_func ) )
    {
        guy [[ animpos.rider_func ]]();
        return;
    }
    
    if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
    {
        if ( isdefined( animpos.getin_idle_func ) )
        {
            thread [[ animpos.getin_idle_func ]]( guy, pos );
            return;
        }
        
        thread guy_idle( guy, pos );
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0xc61
// Size: 0x1a
function vehicle_allows_driver_death()
{
    if ( !isdefined( self.script_allow_driver_death ) )
    {
        return 0;
    }
    
    return self.script_allow_driver_death;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0xc84
// Size: 0x1b
function vehicle_allows_rider_death()
{
    if ( !isdefined( self.script_allow_rider_deaths ) )
    {
        return 1;
    }
    
    return self.script_allow_rider_deaths;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0xca8
// Size: 0x36, Type: bool
function guy_should_man_turret( animpos )
{
    if ( !isdefined( animpos.mgturret ) )
    {
        return false;
    }
    
    if ( !isdefined( self.script_nomg ) )
    {
        return true;
    }
    
    return !self.script_nomg;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0xce7
// Size: 0x177
function handle_attached_guys()
{
    classname = get_vehicle_classname();
    self.attachedguys = [];
    
    if ( !( isdefined( level.vehicle.templates.aianims ) && isdefined( level.vehicle.templates.aianims[ classname ] ) ) )
    {
        return;
    }
    
    maxpos = level.vehicle.templates.aianims[ classname ].size;
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "ai_wait_go" )
    {
        thread ai_wait_go();
    }
    
    self.runningtovehicle = [];
    self.usedpositions = [];
    self.getinorgs = [];
    self.delayer = 0;
    vehicleanim = level.vehicle.templates.aianims[ classname ];
    
    for ( i = 0; i < maxpos ; i++ )
    {
        self.usedpositions[ i ] = 0;
        
        if ( isdefined( self.script_nomg ) && self.script_nomg && isdefined( vehicleanim[ i ].bisgunner ) && vehicleanim[ i ].bisgunner )
        {
            self.usedpositions[ 1 ] = 1;
        }
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0xe66
// Size: 0x15
function load_ai_goddriver( array )
{
    load_ai( array, 1 );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0xe83
// Size: 0xf5
function guy_death( guy, animpos )
{
    waittillframeend();
    assert( !isai( guy ) );
    guy setcandamage( 1 );
    guy endon( "death" );
    guy.allowdeath = 0;
    guy.health = 10150;
    
    if ( isdefined( guy.script_startinghealth ) )
    {
        guy.health += guy.script_startinghealth;
    }
    
    guy endon( "jumping_out" );
    
    if ( isdefined( guy.magic_bullet_shield ) && guy.magic_bullet_shield )
    {
        while ( isdefined( guy.magic_bullet_shield ) && guy.magic_bullet_shield )
        {
            wait 0.05;
        }
    }
    
    while ( guy.health > 10000 )
    {
        guy waittill( "damage" );
    }
    
    thread guy_deathimate_me( guy, animpos );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0xf80
// Size: 0x10f
function guy_deathimate_me( guy, animpos )
{
    animtimer = gettime() + getanimlength( animpos.death ) * 1000;
    angles = guy.angles;
    origin = guy.origin;
    guy = convert_guy_to_drone( guy );
    detach_models_with_substr( guy, "weapon_" );
    guy linkto( self );
    guy notsolid();
    guy setanim( animpos.death );
    
    if ( isai( guy ) )
    {
        guy script_func( "anim_dropallaiweapons" );
    }
    else
    {
        detach_models_with_substr( guy, "weapon_" );
    }
    
    if ( isdefined( animpos.death_delayed_ragdoll ) )
    {
        guy unlink();
        
        if ( isdefined( guy.fnpreragdoll ) )
        {
            guy [[ guy.fnpreragdoll ]]();
        }
        
        guy startragdoll();
        wait animpos.death_delayed_ragdoll;
        guy delete();
        return;
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 3
// Checksum 0x0, Offset: 0x1097
// Size: 0x87
function load_ai( array, bgoddriver, group )
{
    self endon( "death" );
    assert( self.code_classname == "<dev string:x71>" );
    
    if ( array.size )
    {
        if ( !isdefined( bgoddriver ) )
        {
            bgoddriver = 0;
        }
        
        scripts\engine\utility::ent_flag_clear( "unloaded" );
        scripts\engine\utility::ent_flag_clear( "loaded" );
        array_levelthread( array, &get_in_vehicle, bgoddriver, group );
        array_wait( array, "loaded" );
    }
    
    scripts\engine\utility::ent_flag_set( "loaded" );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x1126
// Size: 0x41, Type: bool
function is_rider( guy )
{
    for ( i = 0; i < self.riders.size ; i++ )
    {
        if ( self.riders[ i ] == guy )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 3
// Checksum 0x0, Offset: 0x1170
// Size: 0x4f
function get_in_vehicle( guy, bgoddriver, group )
{
    if ( is_rider( guy ) )
    {
        return;
    }
    
    if ( !handle_detached_guys_check() )
    {
        return;
    }
    
    assertex( isalive( guy ), "<dev string:x83>" );
    guy_runtovehicle( guy, self, bgoddriver, group );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x11c7
// Size: 0x6f
function handle_detached_guys_check()
{
    if ( vehicle_hasavailablespots() )
    {
        return 1;
    }
    
    if ( !issp() )
    {
        classname = self.classname_mp;
    }
    else
    {
        classname = self.class;
    }
    
    assertmsg( "<dev string:xe0>" + level.vehicle.templates.aianims[ classname ].size + "<dev string:x110>" );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x123e
// Size: 0x3d
function vehicle_hasavailablespots()
{
    if ( level.vehicle.templates.aianims[ get_vehicle_classname() ].size - self.runningtovehicle.size )
    {
        return 1;
    }
    
    return 0;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x1283
// Size: 0xe4
function guy_runtovehicle_loaded( guy, vehicle )
{
    vehicle endon( "death" );
    vehicle endon( "stop_loading" );
    
    if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
    {
        msg = guy waittill_any_return_3( "long_death", "death", "enteredvehicle" );
        
        if ( msg != "enteredvehicle" && isdefined( guy.forced_startingposition ) )
        {
            vehicle.usedpositions[ guy.forced_startingposition ] = 0;
        }
    }
    else if ( !guy waitforentervehicle() && isdefined( guy.forced_startingposition ) )
    {
        vehicle.usedpositions[ guy.forced_startingposition ] = 0;
    }
    
    vehicle.runningtovehicle = array_remove( vehicle.runningtovehicle, guy );
    vehicle_loaded_if_full( vehicle );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x136f
// Size: 0xaf
function vehicle_loaded_if_full( vehicle )
{
    if ( isdefined( vehicle.vehicletype ) && isdefined( vehicle.vehicle_loaded_notify_size ) )
    {
        if ( vehicle.riders.size == vehicle.vehicle_loaded_notify_size )
        {
            vehicle scripts\engine\utility::ent_flag_set( "loaded" );
        }
        
        return;
    }
    
    if ( !vehicle.runningtovehicle.size && vehicle.riders.size )
    {
        if ( vehicle.usedpositions[ 0 ] )
        {
            vehicle scripts\engine\utility::ent_flag_set( "loaded" );
            return;
        }
        
        if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
        {
            vehicle thread vehicle_reload();
        }
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x1426
// Size: 0x4f
function vehicle_reload()
{
    assert( self.riders.size );
    riders = self.riders;
    vehicle_unload();
    scripts\engine\utility::ent_flag_wait( "unloaded" );
    riders = array_removedead( riders );
    thread vehicle_load_ai( riders );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x147d
// Size: 0x24
function remove_magic_bullet_shield_from_guy_on_unload_or_death( guy )
{
    waittill_any_2( "unload", "death" );
    guy stop_magic_bullet_shield();
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 3
// Checksum 0x0, Offset: 0x14a9
// Size: 0xed
function choose_vehicle_position( guy, vehiclepositions, bgoddriver )
{
    guy endon( "stop_loading" );
    self endon( "stop_loading" );
    
    if ( !isdefined( bgoddriver ) )
    {
        bgoddriver = 0;
    }
    
    chosenorg = undefined;
    origin = 0;
    
    if ( isdefined( guy.script_startingposition ) )
    {
        chosenorg = vehicle_getinstart( guy.script_startingposition );
    }
    else if ( !self.usedpositions[ 0 ] )
    {
        chosenorg = vehicle_getinstart( 0 );
        
        if ( bgoddriver )
        {
            assertex( !isdefined( guy.magic_bullet_shield ), "<dev string:x116>" );
            guy thread magic_bullet_shield();
            thread remove_magic_bullet_shield_from_guy_on_unload_or_death( guy );
        }
    }
    else if ( vehiclepositions.availablepositions.size )
    {
        chosenorg = getclosest( guy.origin, vehiclepositions.availablepositions );
    }
    else
    {
        chosenorg = undefined;
    }
    
    return chosenorg;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 4
// Checksum 0x0, Offset: 0x159f
// Size: 0x689
function guy_runtovehicle( guy, vehicle, bgoddriver, group )
{
    guy endon( "stop_loading" );
    vehicle endon( "stop_loading" );
    var_5b0cab0a9420da60 = 1;
    
    if ( !isdefined( bgoddriver ) )
    {
        bgoddriver = 0;
    }
    
    vehicleanim = level.vehicle.templates.aianims[ vehicle get_vehicle_classname() ];
    
    if ( isdefined( vehicle.runtovehicleoverride ) )
    {
        vehicle thread [[ vehicle.runtovehicleoverride ]]( guy );
        return;
    }
    
    vehicle endon( "death" );
    guy endon( "death" );
    vehicle.runningtovehicle[ vehicle.runningtovehicle.size ] = guy;
    thread guy_runtovehicle_loaded( guy, vehicle );
    availablepositions = [];
    chosenorg = undefined;
    origin = 0;
    var_f15089151c320c06 = getdvarint( @"hash_9403d7d31fc1d981" );
    
    for ( i = 0; i < vehicleanim.size ; i++ )
    {
        if ( isdefined( vehicleanim[ i ].getin ) )
        {
            var_f15089151c320c06 = 1;
        }
    }
    
    if ( !var_f15089151c320c06 )
    {
        guy notify( "enteredvehicle" );
        
        if ( getdvarint( @"hash_9403d7d31fc1d981" ) )
        {
            chosenorg = choose_vehicle_position( guy, get_availablepositions( group ), bgoddriver );
            guy.forced_startingposition = chosenorg.vehicle_position;
            vehicle.usedpositions[ chosenorg.vehicle_position ] = 1;
            guy entervehicle( self, 1, chosenorg, anim_pos( self, guy.forced_startingposition ) );
        }
        
        vehicle guy_enter( guy, var_5b0cab0a9420da60 );
        return;
    }
    
    if ( !isdefined( guy.get_in_moving_vehicle ) )
    {
        while ( vehicle vehicle_getspeed() > 1 )
        {
            wait 0.05;
        }
    }
    
    positions = vehicle get_availablepositions( group );
    
    if ( !positions.availablepositions.size && positions.nonanimatedpositions.size )
    {
        guy notify( "enteredvehicle" );
        vehicle guy_enter( guy, var_5b0cab0a9420da60 );
        return;
    }
    
    chosenorg = choose_vehicle_position( guy, positions, bgoddriver );
    
    if ( !isdefined( chosenorg ) )
    {
        return;
    }
    
    origin = chosenorg.origin;
    angles = chosenorg.angles;
    guy.forced_startingposition = chosenorg.vehicle_position;
    vehicle.usedpositions[ chosenorg.vehicle_position ] = 1;
    
    if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
    {
        guy.script_moveoverride = 1;
        guy notify( "stop_going_to_node" );
        guy set_forcegoal();
        guy disable_arrivals();
        guy.goalradius = 64;
        guy setgoalpos( origin );
        guy waittill( "goal" );
        guy enable_arrivals();
        guy unset_forcegoal();
        guy notify( "boarding_vehicle" );
    }
    else
    {
        guy requestentervehicle( self, 0, chosenorg, anim_pos( self, chosenorg.vehicle_position ) );
        guy waitforarrivedatvehicle();
    }
    
    animpos = anim_pos( vehicle, chosenorg.vehicle_position );
    
    if ( isdefined( animpos.delay ) )
    {
        guy.delay = animpos.delay;
        
        if ( isdefined( animpos.delayinc ) )
        {
            self.delayer = guy.delay;
        }
    }
    
    if ( isdefined( animpos.delayinc ) )
    {
        self.delayer += animpos.delayinc;
        guy.delay = self.delayer;
    }
    
    if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
    {
        vehicle link_to_sittag( guy, animpos.sittag, animpos.sittag_origin_offset, animpos.sittag_angles_offset, animpos.linktoblend );
    }
    
    guy.allowdeath = 0;
    animpos = vehicleanim[ chosenorg.vehicle_position ];
    
    if ( isdefined( chosenorg ) )
    {
        if ( isdefined( animpos.vehicle_getinanim ) )
        {
            var_b92de7d48a424c1c = isdefined( guy.no_vehicle_getoutanim );
            
            if ( !var_b92de7d48a424c1c && !isagent( guy ) )
            {
                if ( isdefined( animpos.vehicle_getoutanim ) )
                {
                    vehicle clearanim( animpos.vehicle_getoutanim, 0 );
                }
                
                if ( isdefined( animpos.vehicle_getoutanim_combat ) )
                {
                    vehicle clearanim( animpos.vehicle_getoutanim_combat, 0 );
                }
                
                if ( isdefined( animpos.vehicle_getoutanim_combat_run ) )
                {
                    vehicle clearanim( animpos.vehicle_getoutanim_combat_run, 0 );
                }
            }
            
            vehicle = vehicle getanimatemodel();
            vehicle thread setanimrestart_once( animpos.vehicle_getinanim, animpos.vehicle_getinanim_clear );
            vehicle thread scripts\common\notetrack::start_notetrack_wait( vehicle, "vehicle_anim_flag", undefined, undefined, animpos.vehicle_getinanim );
        }
        
        if ( isdefined( animpos.vehicle_getinsoundtag ) )
        {
            origin = vehicle gettagorigin( animpos.vehicle_getinsoundtag );
        }
        else
        {
            origin = vehicle.origin;
        }
        
        if ( isdefined( animpos.vehicle_getinsound ) )
        {
            playsoundatpos( origin, animpos.vehicle_getinsound );
        }
        
        getintags = undefined;
        getinthreads = undefined;
        
        if ( isdefined( animpos.getin_enteredvehicletrack ) )
        {
            getintags = [];
            getintags[ 0 ] = animpos.getin_enteredvehicletrack;
            getinthreads = [];
            getinthreads[ 0 ] = &entered_vehicle_notify;
            vehicle link_to_sittag( guy, animpos.sittag, animpos.sittag_origin_offset, animpos.sittag_angles_offset, animpos.linktoblend );
        }
        
        if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
        {
            vehicle animontag( guy, animpos.sittag, animpos.getin, getintags, getinthreads, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset );
        }
    }
    
    if ( getdvarint( @"hash_9403d7d31fc1d981" ) )
    {
        guy waitforentervehicle();
    }
    
    guy notify( "enteredvehicle" );
    vehicle guy_enter( guy, var_5b0cab0a9420da60 );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x1c30
// Size: 0xa
function entered_vehicle_notify()
{
    self notify( "enteredvehicle" );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x1c42
// Size: 0xb6
function driverdead( guy )
{
    if ( scripts\common\vehicle::ishelicopter() )
    {
        return;
    }
    
    self.driver = guy;
    self endon( "death" );
    guy endon( "jumping_out" );
    guy waittill( "death" );
    
    if ( getdvarint( @"hash_bd29c0db2cf41967", 0 ) == 1 )
    {
        return;
    }
    
    if ( isdefined( self.vehicle_keeps_going_after_driver_dies ) )
    {
        return;
    }
    
    self notify( "driver dead" );
    self.deaddriver = 1;
    
    if ( isdefined( self.hasstarted ) && self.hasstarted )
    {
        self setwaitspeed( 0 );
        self vehicle_setspeed( 0, 20, 20 );
        self waittill( "reached_wait_speed" );
    }
    
    if ( !istrue( self.donotunloadondriverdeath ) )
    {
        vehicle_unload();
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x1d00
// Size: 0x110
function guy_becomes_real_ai( guy, pos )
{
    if ( isai( guy ) )
    {
        return guy;
    }
    
    if ( istrue( guy.drone_delete_on_unload ) )
    {
        guy delete();
        return;
    }
    
    guy = script_func( "spawner_makerealai", guy );
    
    if ( utility::issp() )
    {
        classname = self.classname;
    }
    else
    {
        classname = self.classname_mp;
    }
    
    maxpos = level.vehicle.templates.aianims[ classname ].size;
    animpos = anim_pos( self, pos );
    link_to_sittag( guy, animpos.sittag, animpos.sittag_origin_offset, animpos.sittag_angles_offset, animpos.linktoblend );
    guy.vehicle_idle = animpos.idle;
    
    if ( !istrue( guy.disable_vehicle_idle ) )
    {
        thread guy_idle( guy, pos );
    }
    
    return guy;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 5
// Checksum 0x0, Offset: 0x1e19
// Size: 0x87
function link_to_sittag( guy, tag, origin_offset, angles_offset, linktoblend )
{
    if ( !isdefined( origin_offset ) )
    {
        origin_offset = ( 0, 0, 0 );
    }
    
    if ( !isdefined( angles_offset ) )
    {
        angles_offset = ( 0, 0, 0 );
    }
    
    if ( !isdefined( linktoblend ) )
    {
        linktoblend = 0;
    }
    
    if ( linktoblend && !isdefined( guy.script_drone ) )
    {
        guy linktoblendtotag( self, tag, 0 );
        return;
    }
    
    guy linkto( self, tag, origin_offset, angles_offset );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x1ea8
// Size: 0x63
function anim_pos( vehicle, pos )
{
    assertex( isdefined( pos ), "<dev string:x193>" + vehicle get_vehicle_classname() + "<dev string:x1a7>" );
    
    if ( !isdefined( pos ) )
    {
        return spawnstruct();
    }
    
    return level.vehicle.templates.aianims[ vehicle get_vehicle_classname() ][ pos ];
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x1f14
// Size: 0x47
function guy_deathhandle( guy, pos )
{
    guy waittill( "death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.riders = array_remove( self.riders, guy );
    self.usedpositions[ pos ] = 0;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x1f63
// Size: 0x98
function setup_aianimthreads()
{
    if ( !isdefined( level.vehicle.aianimthread ) )
    {
        level.vehicle.aianimthread = [];
    }
    
    if ( !isdefined( level.vehicle.aianimcheck ) )
    {
        level.vehicle.aianimcheck = [];
    }
    
    level.vehicle.aianimthread[ "idle" ] = &guy_idle;
    level.vehicle.aianimthread[ "unload" ] = &guy_unload;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x2003
// Size: 0x2b
function guy_handle( guy, pos )
{
    guy.vehicle_idling = 1;
    thread guy_deathhandle( guy, pos );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x2036
// Size: 0x86
function driver_idle_speed( driver, pos )
{
    driver endon( "newanim" );
    self endon( "death" );
    driver endon( "death" );
    animpos = anim_pos( self, pos );
    
    while ( true )
    {
        if ( self vehicle_getspeed() == 0 )
        {
            driver.vehicle_idle = animpos.idle_animstop;
        }
        else
        {
            driver.vehicle_idle = animpos.idle_anim;
        }
        
        wait 0.25;
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 3
// Checksum 0x0, Offset: 0x20c4
// Size: 0xc1
function guy_idle( guy, pos, ignoredeath )
{
    guy endon( "newanim" );
    
    if ( !isdefined( ignoredeath ) )
    {
        self endon( "death" );
    }
    
    guy endon( "death" );
    guy.vehicle_idling = 1;
    guy notify( "gotime" );
    
    if ( !isdefined( guy.vehicle_idle ) )
    {
        return;
    }
    
    animpos = anim_pos( self, pos );
    
    if ( isdefined( animpos.mgturret ) )
    {
        return;
    }
    
    if ( isdefined( animpos.idle_animstop ) && isdefined( animpos.idle_anim ) )
    {
        thread driver_idle_speed( guy, pos );
    }
    
    while ( true )
    {
        guy notify( "idle" );
        play_new_idle( guy, animpos );
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x218d
// Size: 0x171
function play_new_idle( guy, animpos )
{
    if ( isdefined( guy.vehicle_idle_override ) )
    {
        animontag( guy, animpos.sittag, guy.vehicle_idle_override, undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset );
        return;
    }
    
    if ( isdefined( animpos.idleoccurrence ) )
    {
        theanim = randomoccurrance( guy, animpos.idleoccurrence );
        animontag( guy, animpos.sittag, guy.vehicle_idle[ theanim ], undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset );
        return;
    }
    
    if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_idle ) )
    {
        animontag( guy, animpos.sittag, animpos.player_idle, undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset );
        return;
    }
    
    if ( isdefined( animpos.vehicle_idle ) )
    {
        thread setanimrestart_once( animpos.vehicle_idle );
    }
    
    animontag( guy, animpos.sittag, guy.vehicle_idle, undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x2306
// Size: 0x79
function randomoccurrance( guy, occurrences )
{
    range = [];
    var_c32808289f6a7cc0 = 0;
    
    for ( i = 0; i < occurrences.size ; i++ )
    {
        var_c32808289f6a7cc0 += occurrences[ i ];
        range[ i ] = var_c32808289f6a7cc0;
    }
    
    pick = randomint( var_c32808289f6a7cc0 );
    
    for ( i = 0; i < occurrences.size ; i++ )
    {
        if ( pick < range[ i ] )
        {
            return i;
        }
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x2387
// Size: 0x7d
function function_b4600df9b9f46f3d( guy )
{
    self endon( "death" );
    wait 50;
    
    if ( isdefined( guy ) && array_contains( self.unloadque, guy ) )
    {
        self.unloadque = array_remove( self.unloadque, guy );
        
        if ( !self.unloadque.size )
        {
            scripts\engine\utility::ent_flag_set( "unloaded" );
            self.unload_group = "default";
            self function_75feda26550d4f0e();
        }
        
        guy notify( "jumpedout" );
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x240c
// Size: 0x84
function guy_unload_que( guy )
{
    self endon( "death" );
    self.unloadque = array_add( self.unloadque, guy );
    guy waittill_any_2( "death", "jumpedout" );
    self.unloadque = array_remove( self.unloadque, guy );
    
    if ( !self.unloadque.size )
    {
        scripts\engine\utility::ent_flag_set( "unloaded" );
        self.unload_group = "default";
        self function_75feda26550d4f0e();
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x2498
// Size: 0xbb, Type: bool
function riders_unloadable( unload_group )
{
    if ( !isdefined( self.riders ) )
    {
        return false;
    }
    
    if ( !self.riders.size )
    {
        return false;
    }
    
    for ( i = 0; i < self.riders.size ; i++ )
    {
        if ( !isalive( self.riders[ i ] ) && !isdefined( self.riders[ i ].isvehicle ) )
        {
            continue;
        }
        
        if ( !isdefined( self.riders[ i ].vehicle_position ) )
        {
            continue;
        }
        
        if ( check_unloadgroup( self.riders[ i ].vehicle_position, unload_group ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x255c
// Size: 0xe2
function get_unload_group()
{
    group = [];
    unloadgroups = [];
    unload_group = "default";
    
    if ( isdefined( self.unload_group ) )
    {
        unload_group = self.unload_group;
    }
    
    unloadgroups = level.vehicle.templates.unloadgroups[ get_vehicle_classname() ][ unload_group ];
    
    if ( !isdefined( unloadgroups ) )
    {
        unloadgroups = level.vehicle.templates.unloadgroups[ get_vehicle_classname() ][ "default" ];
    }
    
    foreach ( pos in unloadgroups )
    {
        group[ pos ] = pos;
    }
    
    return group;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x2647
// Size: 0x110, Type: bool
function check_unloadgroup( pos, unload_group )
{
    if ( !isdefined( unload_group ) )
    {
        unload_group = self.unload_group;
    }
    
    classname = get_vehicle_classname();
    
    if ( !isdefined( level.vehicle.templates.unloadgroups[ classname ] ) )
    {
        return true;
    }
    
    if ( !isdefined( level.vehicle.templates.unloadgroups[ classname ][ unload_group ] ) )
    {
        println( "<dev string:x1c3>" + self.currentnode.origin + "<dev string:x1ef>" + unload_group + "<dev string:x202>" );
        println( "<dev string:x209>" );
        return true;
    }
    
    group = level.vehicle.templates.unloadgroups[ classname ][ unload_group ];
    
    for ( i = 0; i < group.size ; i++ )
    {
        if ( pos == group[ i ] )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 3
// Checksum 0x0, Offset: 0x2760
// Size: 0x34
function getoutrig_model_idle( model, tag, animation )
{
    self endon( "unloading" );
    
    while ( true )
    {
        animontag( model, tag, animation );
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 5
// Checksum 0x0, Offset: 0x279c
// Size: 0x133
function getoutrig_model( animpos, model, tag, animation, var_ec8a68bde7ac6a73 )
{
    classname = get_vehicle_classname();
    
    if ( var_ec8a68bde7ac6a73 )
    {
        thread getoutrig_model_idle( model, tag, level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].idleanim );
        self waittill( "unloading" );
    }
    
    self.unloadque = array_add( self.unloadque, model );
    thread getoutrig_abort( model, tag, animation );
    
    if ( !scripts\common\vehicle_code::vehicle_iscrashing() )
    {
        animontag( model, tag, animation );
    }
    
    model unlink();
    
    if ( !isdefined( self ) )
    {
        model delete();
        return;
    }
    
    assert( isdefined( self.unloadque ) );
    self.unloadque = array_remove( self.unloadque, model );
    
    if ( !self.unloadque.size )
    {
        self notify( "unloaded" );
    }
    
    self.fastroperig[ animpos.fastroperig ] = undefined;
    wait 10;
    model delete();
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 5
// Checksum 0x0, Offset: 0x28d7
// Size: 0x3cc
function getoutrig_model_new( animpos, model, tag, animation, var_ec8a68bde7ac6a73 )
{
    self endon( "death" );
    classname = get_vehicle_classname();
    thread delete_on_death( model );
    origin = self gettagorigin( tag );
    angles = self gettagangles( tag );
    xanim = level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].idleanim;
    startorg = getstartorigin( origin, angles, xanim );
    startangles = getstartangles( origin, angles, xanim );
    startangles = self.angles;
    tagorigin = model gettagorigin( "j_rope_1", 1 );
    
    if ( !isdefined( tagorigin ) )
    {
        tagorigin = self.origin;
    }
    
    tagoffset = tagorigin - self.origin;
    
    if ( var_ec8a68bde7ac6a73 )
    {
        model.origin = startorg;
        model.angles = startangles;
        thread script_func( "fastrope_anim", model, xanim, "getoutrigidle" );
        scripts\engine\utility::ent_flag_wait( "unloaded" );
    }
    
    origin = self gettagorigin( tag );
    angles = self gettagangles( tag );
    
    if ( istrue( self.animintro ) )
    {
        if ( scripts\common\vehicle_aianim::riders_unloadable( self.currentnode.script_unload ) )
        {
            ropeorigin = origin;
            thread getoutrig_abort( model, undefined, animation, ropeorigin );
            
            if ( !scripts\common\vehicle_code::vehicle_iscrashing() )
            {
                model unlink();
                model.origin = origin;
                model.angles = angles;
                thread script_func( "fastrope_anim", model, animation, "getoutrigfall" );
            }
        }
    }
    else
    {
        moveangles = self.angles - startangles;
        moveangles = ( angleclamp( moveangles[ 0 ] ), angleclamp( moveangles[ 1 ] ), angleclamp( moveangles[ 2 ] ) );
        traceorigin = rotatevector( tagoffset, moveangles ) + self.origin;
        results = ray_trace( traceorigin, traceorigin - ( 0, 0, 1000 ), self, create_world_contents() );
        ropeheight = traceorigin[ 2 ] - 400;
        
        if ( isdefined( results[ "position" ] ) )
        {
            ropeheight = results[ "position" ][ 2 ];
        }
        
        ropeorigin = ( origin[ 0 ], origin[ 1 ], ropeheight );
        
        if ( istrue( self.var_e662d8c3659cb3e3 ) )
        {
            ropeorigin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] );
        }
        
        if ( istrue( level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].dropusestraceorigin ) )
        {
            ropeorigin = ( traceorigin[ 0 ], traceorigin[ 1 ], ropeheight );
        }
        
        /#
            if ( getdvarint( @"hash_c318492e4a168bb3", 0 ) == 1 )
            {
                line( traceorigin, traceorigin - ( 0, 0, 1000 ), ( 0, 0, 1 ), 1, 0, 400 );
                sphere( ropeorigin, 4, ( 0, 1, 0 ), 0, 400 );
            }
        #/
        
        thread getoutrig_abort( model, undefined, animation, ropeorigin );
        
        if ( !scripts\common\vehicle_code::vehicle_iscrashing() )
        {
            model unlink();
            model.origin = ropeorigin;
            thread script_func( "fastrope_anim", model, animation, "getoutrigfall" );
        }
    }
    
    self.fastroperig[ animpos.fastroperig ] = undefined;
    wait 10;
    model delete();
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x2cab
// Size: 0x48
function getoutrig_disable_abort_notify_after_riders_out()
{
    wait 0.05;
    
    while ( isalive( self ) && self.unloadque.size > 2 )
    {
        wait 0.05;
    }
    
    if ( !isalive( self ) || scripts\common\vehicle_code::vehicle_iscrashing() )
    {
        return;
    }
    
    self notify( "getoutrig_disable_abort" );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x2cfb
// Size: 0x97
function getoutrig_abort_while_deploying()
{
    self endon( "end_getoutrig_abort_while_deploying" );
    
    while ( !scripts\common\vehicle_code::vehicle_iscrashing() )
    {
        wait 0.05;
    }
    
    updatedriders = [];
    
    foreach ( rider in self.riders )
    {
        if ( isalive( rider ) )
        {
            array_add_safe( updatedriders, rider );
        }
    }
    
    array_delete( updatedriders );
    self notify( "crashed_while_deploying" );
    updatedriders = undefined;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 4
// Checksum 0x0, Offset: 0x2d9a
// Size: 0x2f0
function getoutrig_abort( model, tag, animation, ropeorigin )
{
    totalanimtime = getanimlength( animation );
    var_ec4312f917fcfbf3 = totalanimtime - 1;
    
    if ( self.vehicletype == "mi17" )
    {
        var_ec4312f917fcfbf3 = totalanimtime - 0.5;
    }
    
    var_22a98bc45239b860 = 0.8;
    assert( totalanimtime > var_22a98bc45239b860 );
    assert( var_ec4312f917fcfbf3 - var_22a98bc45239b860 > 0 );
    self endon( "getoutrig_disable_abort" );
    thread getoutrig_disable_abort_notify_after_riders_out();
    thread getoutrig_abort_while_deploying();
    waittill_notify_or_timeout( "crashed_while_deploying", var_22a98bc45239b860 );
    self notify( "end_getoutrig_abort_while_deploying" );
    
    while ( !isdefined( self.vehiclecrashing ) )
    {
        waitframe();
    }
    
    if ( isdefined( model ) )
    {
        if ( !isdefined( tag ) && isdefined( ropeorigin ) )
        {
            model unlink();
            model.origin = ropeorigin;
            
            if ( !issp() )
            {
                if ( iscp() )
                {
                }
                else
                {
                    animindex = model scripts\asm\asm::asm_lookupanimfromalias( "animscripted", animation );
                    xanim = model scripts\asm\asm::asm_getxanim( "animscripted", animindex );
                    startorg = getstartorigin( self.origin, self.angles, xanim );
                    startangles = getstartangles( self.origin, self.angles, xanim );
                    model dontinterpolate();
                    model forceteleport( startorg, startangles );
                    model animmode( "nogravity" );
                    model aisetanim( "animscripted", animindex );
                }
            }
            else
            {
                model animscripted( "getoutrigfall", model.origin, model.angles, animation, undefined, undefined, 0 );
            }
        }
        else
        {
            thread animontag( model, tag, animation );
        }
        
        waittillframeend();
        
        if ( !iscp() )
        {
            model setanimtime( animation, var_ec4312f917fcfbf3 / totalanimtime );
        }
    }
    
    attacker = self;
    
    if ( isdefined( self.original_attacker ) )
    {
        attacker = self.original_attacker;
    }
    
    for ( i = 0; i < self.riders.size ; i++ )
    {
        if ( !isdefined( self.riders[ i ] ) )
        {
            continue;
        }
        
        if ( !isdefined( self.riders[ i ].ragdoll_getout_death ) )
        {
            continue;
        }
        
        if ( self.riders[ i ].ragdoll_getout_death != 1 )
        {
            continue;
        }
        
        if ( !isdefined( self.riders[ i ].ridingvehicle ) )
        {
            continue;
        }
        
        self.riders[ i ].forcefallthroughonropes = 1;
        
        if ( isalive( self.riders[ i ] ) )
        {
            thread animontag_ragdoll_death_fall( self.riders[ i ], self, attacker );
        }
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x3092
// Size: 0x6b
function setanimrestart_once( vehicle_anim, bclearanim )
{
    self endon( "death" );
    self endon( "dont_clear_anim" );
    
    if ( !isdefined( bclearanim ) )
    {
        bclearanim = 1;
    }
    
    cycletime = getanimlength( vehicle_anim );
    self endon( "death" );
    thread script_func( "vehicle_door_anim", self, vehicle_anim );
    wait cycletime;
    
    if ( utility::issp() && bclearanim )
    {
        self clearanim( vehicle_anim, 0 );
    }
}

#using_animtree( "script_model" );

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 3
// Checksum 0x0, Offset: 0x3105
// Size: 0x30d
function getout_rigspawn( animatemodel, animpos, var_ec8a68bde7ac6a73 )
{
    if ( !isdefined( var_ec8a68bde7ac6a73 ) )
    {
        var_ec8a68bde7ac6a73 = 1;
    }
    
    classname = get_vehicle_classname();
    
    if ( isdefined( self.attach_model_override ) && isdefined( self.attach_model_override[ animpos.fastroperig ] ) )
    {
        overrridegetoutrig = 1;
    }
    else
    {
        overrridegetoutrig = 0;
    }
    
    if ( !isdefined( animpos.fastroperig ) || isdefined( self.fastroperig[ animpos.fastroperig ] ) || overrridegetoutrig )
    {
        return;
    }
    
    origin = animatemodel gettagorigin( level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].tag );
    angles = animatemodel gettagangles( level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].tag );
    self.fastroperiganimating[ animpos.fastroperig ] = 1;
    getoutrig_model = spawn( "script_model", origin );
    getoutrig_model.angles = angles;
    getoutrig_model.origin = origin;
    getoutrig_model useanimtree( #animtree );
    getoutrig_model setmodel( level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].model );
    self.fastroperig[ animpos.fastroperig ] = getoutrig_model;
    getoutrig_model linkto( animatemodel, level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].tag );
    
    if ( getdvarint( @"hash_9403d7d31fc1d981" ) )
    {
        thread getoutrig_model_new( animpos, getoutrig_model, level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].tag, level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].dropanim, var_ec8a68bde7ac6a73 );
    }
    else
    {
        thread getoutrig_model( animpos, getoutrig_model, level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].tag, level.vehicle.templates.attachedmodels[ classname ][ animpos.fastroperig ].dropanim, var_ec8a68bde7ac6a73 );
    }
    
    return getoutrig_model;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x341b
// Size: 0x5d
function check_sound_tag_dupe( soundtag )
{
    if ( !isdefined( self.sound_tag_dupe ) )
    {
        self.sound_tag_dupe = [];
    }
    
    duped = 0;
    
    if ( !isdefined( self.sound_tag_dupe[ soundtag ] ) )
    {
        self.sound_tag_dupe[ soundtag ] = 1;
    }
    else
    {
        duped = 1;
    }
    
    thread check_sound_tag_dupe_reset( soundtag );
    return duped;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x3481
// Size: 0x71
function check_sound_tag_dupe_reset( soundtag )
{
    wait 0.05;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.sound_tag_dupe[ soundtag ] = 0;
    keys = getarraykeys( self.sound_tag_dupe );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        if ( self.sound_tag_dupe[ keys[ i ] ] )
        {
            return;
        }
    }
    
    self.sound_tag_dupe = undefined;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 3
// Checksum 0x0, Offset: 0x34fa
// Size: 0x110
function vehicle_play_exit_anim( animpos, vehicle_getoutanim, vehicle_getoutanim_clear )
{
    vehicleanim = level.vehicle.templates.aianims[ get_vehicle_classname() ];
    animatemodel = getanimatemodel();
    
    if ( !isdefined( vehicle_getoutanim ) )
    {
        vehicle_getoutanim = animpos.vehicle_getoutanim;
    }
    
    if ( !isdefined( vehicle_getoutanim_clear ) )
    {
        vehicle_getoutanim_clear = animpos.vehicle_getoutanim_clear;
    }
    
    if ( isdefined( vehicle_getoutanim ) )
    {
        animatemodel thread setanimrestart_once( vehicle_getoutanim, vehicle_getoutanim_clear );
        var_b3b5db2bc223ffd6 = 0;
        
        if ( isdefined( animpos.vehicle_getoutsoundtag ) )
        {
            var_b3b5db2bc223ffd6 = check_sound_tag_dupe( animpos.vehicle_getoutsoundtag );
            origin = animatemodel gettagorigin( animpos.vehicle_getoutsoundtag );
        }
        else
        {
            origin = animatemodel.origin;
        }
        
        if ( isdefined( animpos.vehicle_getoutsound ) && !var_b3b5db2bc223ffd6 )
        {
            playsoundatpos( origin, animpos.vehicle_getoutsound );
        }
        
        var_b3b5db2bc223ffd6 = undefined;
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x3612
// Size: 0xcf
function vehicle_end_loop_sounds( guy, pos )
{
    animpos = anim_pos( self, pos );
    
    if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout_sound_loop ) )
    {
        level.player thread script_func( "playloopsound_on_entity", animpos.player_getout_sound_loop );
    }
    
    if ( isdefined( animpos.getoutloopsnd ) )
    {
        guy thread script_func( "playloopsound_on_entity", animpos.getoutloopsnd );
    }
    
    if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout_sound_end ) )
    {
        level.player thread script_func( "playsound_on_entity", animpos.player_getout_sound_end );
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x36e9
// Size: 0xaa
function prepdoorsforunload()
{
    if ( self function_8fa29bf693c94b27() )
    {
        return;
    }
    
    for ( i = 0; i < level.vehicle.templates.aianims[ get_vehicle_classname() ].size ; i++ )
    {
        animpos = level.vehicle.templates.aianims[ get_vehicle_classname() ][ i ];
        
        if ( isdefined( animpos.vehicle_getoutanim ) )
        {
            anim_name = getanimname( animpos.vehicle_getoutanim );
            self function_d043dd116c449128( anim_name );
        }
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x379b
// Size: 0x192
function wait_for_open_door( guy, animpos )
{
    guy endon( "jumpedout" );
    guy endon( "death" );
    self endon( "death" );
    prepdoorsforunload();
    
    while ( !istrue( guy.requestopendoor ) )
    {
        waitframe();
    }
    
    if ( isdefined( animpos.vehicle_getoutanim ) )
    {
        anim_name = getanimname( animpos.vehicle_getoutanim );
        
        if ( !self function_6d897c252a37c080( anim_name ) )
        {
            vehicle_getoutanim = animpos.vehicle_getoutanim;
            vehicle_getoutanim_clear = animpos.vehicle_getoutanim_clear;
            
            if ( isdefined( guy.requestopendoorparams ) )
            {
                if ( guy.requestopendoorparams == "combat_run" && isdefined( animpos.vehicle_getoutanim_combat_run ) )
                {
                    vehicle_getoutanim = animpos.vehicle_getoutanim_combat_run;
                    vehicle_getoutanim_clear = animpos.vehicle_getoutanim_combat_run_clear;
                }
                else if ( guy.requestopendoorparams == "combat" && isdefined( animpos.vehicle_getoutanim_combat ) )
                {
                    vehicle_getoutanim = animpos.vehicle_getoutanim_combat;
                    vehicle_getoutanim_clear = animpos.vehicle_getoutanim_combat_clear;
                }
            }
            
            vehicle_play_exit_anim( animpos, vehicle_getoutanim, vehicle_getoutanim_clear );
            self function_dcec5ea95982c90c( anim_name, 1 );
        }
        
        if ( isdefined( animpos.fastroperig ) && !isdefined( self.fastroperig[ animpos.fastroperig ] ) )
        {
            animatemodel = getanimatemodel();
            getoutrig_model = getout_rigspawn( animatemodel, animpos, 1 );
        }
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x3935
// Size: 0x45
function guy_setup_rope( guy, animpos )
{
    if ( isdefined( animpos.fastroperig ) )
    {
        thread wait_for_open_door( guy, animpos );
        guy setuprope();
        return;
    }
    
    assertmsg( "<dev string:x220>" );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x3982
// Size: 0xb65
function guy_unload( guy, pos )
{
    isvehicle = 0;
    
    if ( isdefined( guy.isvehicle ) )
    {
        isvehicle = 1;
    }
    
    animpos = anim_pos( self, pos );
    type = self.vehicletype;
    
    if ( !check_unloadgroup( pos ) )
    {
        if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
        {
            thread guy_idle( guy, pos );
        }
        
        return;
    }
    
    if ( !getdvarint( @"hash_9403d7d31fc1d981" ) && !isdefined( animpos.getout ) )
    {
        thread guy_idle( guy, pos );
        return;
    }
    
    thread guy_unload_que( guy );
    
    if ( !issp() )
    {
        thread function_b4600df9b9f46f3d( guy );
    }
    
    self endon( "death" );
    
    if ( isai( guy ) && isalive( guy ) )
    {
        guy endon( "death" );
    }
    
    bnoanimunload = 0;
    
    if ( isdefined( guy.getoffvehiclefunc ) )
    {
        var_f5b7a13c571f124c = guy [[ guy.getoffvehiclefunc ]]();
        
        if ( isdefined( var_f5b7a13c571f124c ) && var_f5b7a13c571f124c )
        {
            bnoanimunload = 1;
        }
    }
    
    if ( isdefined( guy.onrotatingvehicleturret ) )
    {
        guy.onrotatingvehicleturret = undefined;
        
        if ( isdefined( guy.getoffvehiclefunc ) )
        {
            guy [[ guy.getoffvehiclefunc ]]();
        }
    }
    
    if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
    {
        vehicle_play_exit_anim( animpos );
        delay = 0;
        
        if ( isdefined( animpos.getout_timed_anim ) )
        {
            delay += getanimlength( animpos.getout_timed_anim );
        }
        
        if ( isdefined( animpos.delay ) )
        {
            delay += animpos.delay;
        }
        
        if ( isdefined( guy.delay ) )
        {
            delay += guy.delay;
        }
        
        if ( delay > 0 )
        {
            if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
            {
                thread guy_idle( guy, pos );
            }
            
            wait delay;
        }
    }
    
    if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
    {
        guy.deathanim = undefined;
        guy.deathanimscript = undefined;
    }
    
    guy notify( "newanim" );
    
    if ( isdefined( animpos.bhasgunwhileriding ) && !animpos.bhasgunwhileriding )
    {
        if ( !isdefined( guy.disable_gun_recall ) )
        {
            guy gun_recall();
        }
    }
    
    if ( isai( guy ) )
    {
        guy pushplayer( 1 );
    }
    
    if ( isdefined( animpos.bnoanimunload ) )
    {
        bnoanimunload = 1;
    }
    else if ( !getdvarint( @"hash_9403d7d31fc1d981" ) && !isdefined( animpos.getout ) || !isdefined( self.script_unloadmgguy ) && isdefined( animpos.bisgunner ) && animpos.bisgunner || isdefined( self.script_keepdriver ) && pos == 0 )
    {
        thread guy_idle( guy, pos );
        return;
    }
    
    if ( guy should_give_orghealth() )
    {
        guy.health = guy.orghealth;
    }
    
    guy.orghealth = undefined;
    
    if ( isai( guy ) && isalive( guy ) )
    {
        guy endon( "death" );
    }
    
    guy.allowdeath = 0;
    tag = animpos.sittag;
    
    if ( isdefined( guy.get_out_override ) )
    {
        animation = guy.get_out_override;
    }
    else if ( scripts\engine\utility::ent_flag( "landed" ) && isdefined( animpos.getout_landed ) )
    {
        animation = animpos.getout_landed;
    }
    else if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout ) )
    {
        animation = animpos.player_getout;
    }
    else
    {
        animation = animpos.getout;
    }
    
    if ( !bnoanimunload )
    {
        if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
        {
            thread guy_unlink_on_death( guy );
        }
        
        if ( !getdvarint( @"hash_9403d7d31fc1d981" ) && isdefined( animpos.fastroperig ) )
        {
            if ( !isdefined( self.fastroperig[ animpos.fastroperig ] ) )
            {
                if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
                {
                    thread guy_idle( guy, pos );
                }
                
                animatemodel = getanimatemodel();
                getoutrig_model = getout_rigspawn( animatemodel, animpos, 1 );
            }
        }
        
        if ( isdefined( animpos.getoutsnd ) )
        {
            guy thread script_func( "playsound_on_tag", animpos.getoutsnd, "J_Wrist_RI", 1 );
        }
        
        if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout_sound ) )
        {
            guy thread script_func( "playsound_on_tag", animpos.player_getout_sound );
        }
        
        if ( isdefined( animpos.getoutloopsnd ) )
        {
            guy thread script_func( "playloopsound_on_tag", animpos.getoutloopsnd );
        }
        
        if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout_sound_loop ) )
        {
            level.player thread script_func( "playloopsound_on_tag", animpos.player_getout_sound_loop );
        }
        
        guy notify( "newanim" );
        guy notify( "jumping_out" );
        var_c87c13106eca1f = 0;
        
        if ( !isai( guy ) && !isvehicle )
        {
            var_c87c13106eca1f = 1;
        }
        
        if ( !isdefined( guy.script_stay_drone ) && !isvehicle )
        {
            guy = guy_becomes_real_ai( guy, pos );
        }
        
        if ( !isalive( guy ) && !isvehicle )
        {
            return;
        }
        
        if ( !isvehicle )
        {
            guy.ragdoll_getout_death = 1;
        }
        
        if ( isdefined( animpos.ragdoll_getout_death ) )
        {
            guy.ragdoll_getout_death = 1;
            
            if ( isdefined( animpos.ragdoll_fall_anim ) )
            {
                guy.ragdoll_fall_anim = animpos.ragdoll_fall_anim;
            }
        }
        
        if ( var_c87c13106eca1f )
        {
            self.riders = array_add( self.riders, guy );
            thread guy_deathhandle( guy, pos );
            thread guy_unload_que( guy );
            guy.ridingvehicle = self;
        }
        
        if ( isai( guy ) )
        {
            guy endon( "death" );
        }
        
        guy notify( "newanim" );
        guy notify( "jumping_out" );
        
        if ( isdefined( animpos.littlebirde_getout_unlinks ) && animpos.littlebirde_getout_unlinks )
        {
            thread stable_unlink( guy );
        }
        
        if ( isalive( guy ) && isai( guy ) && guy_resets_goalpos( guy ) )
        {
            guy.goalradius = 600;
            guy setgoalpos( guy.origin );
        }
        
        if ( isdefined( animpos.getout_secondary ) )
        {
            animontag( guy, tag, animation );
            var_dac541eb37e05fba = tag;
            
            if ( isdefined( animpos.getout_secondary_tag ) )
            {
                var_dac541eb37e05fba = animpos.getout_secondary_tag;
            }
            
            animontag( guy, var_dac541eb37e05fba, animpos.getout_secondary, undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset );
        }
        else
        {
            hoverunload = 0;
            
            if ( isdefined( animpos.getout_hover_loop ) && isdefined( animpos.getout_hover_land ) )
            {
                thread guy_unload_land( guy, tag, animpos.getout, animpos.getout_hover_loop, animpos.getout_hover_land );
                hoverunload = 1;
            }
            else if ( !isvehicle )
            {
                guy.anim_end_early = 1;
            }
            
            if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
            {
                animontag( guy, tag, animation, undefined, undefined, undefined, animpos.sittag_origin_offset, animpos.sittag_angles_offset );
            }
            else
            {
                thread wait_for_open_door( guy, animpos );
                guy exitvehicle();
            }
            
            if ( hoverunload )
            {
                guy waittill( "hoverunload_done" );
            }
        }
        
        if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout_sound_loop ) )
        {
            level.player thread stop_loop_sound_on_entity( animpos.player_getout_sound_loop );
        }
        
        if ( isdefined( animpos.getoutloopsnd ) )
        {
            guy thread stop_loop_sound_on_entity( animpos.getoutloopsnd );
        }
        
        if ( isdefined( guy.playerpiggyback ) && isdefined( animpos.player_getout_sound_end ) )
        {
            level.player thread script_func( "playsound_on_entity", animpos.player_getout_sound_end );
        }
    }
    else if ( !isai( guy ) )
    {
        if ( istrue( guy.drone_delete_on_unload ) )
        {
            guy delete();
            return;
        }
        
        guy = script_func( "spawner_makerealai", guy );
    }
    
    self.riders = array_remove( self.riders, guy );
    self.usedpositions[ pos ] = 0;
    guy.ridingvehicle = undefined;
    guy.drivingvehicle = undefined;
    
    if ( !isalive( self ) && !isdefined( animpos.unload_ondeath ) )
    {
        guy delete();
        return;
    }
    
    if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
    {
        guy unlink();
    }
    
    if ( !isdefined( guy.magic_bullet_shield ) )
    {
        guy.allowdeath = 1;
    }
    
    if ( isalive( guy ) || isvehicle )
    {
        guy.forced_startingposition = undefined;
        
        if ( isai( guy ) )
        {
            if ( isdefined( animpos.getoutstance ) )
            {
                guy.desired_anim_pose = animpos.getoutstance;
                guy allowedstances( "crouch" );
                guy thread script_func( "anim_updateanimpose" );
                guy allowedstances( "stand", "crouch", "prone" );
            }
            
            guy pushplayer( 0 );
            guy notify( "pushplayerchanged" );
        }
        else if ( isvehicle )
        {
            guy.vspawner.origin = guy.origin;
            guy.vspawner.angles = guy.angles;
            
            if ( isdefined( guy.vspawner.target ) )
            {
                guy.vspawner spawn_vehicle_and_gopath();
            }
            else
            {
                realvehicle = guy.vspawner utility::spawn_vehicle();
            }
            
            guy delete();
        }
        
        if ( !getdvarint( @"hash_9403d7d31fc1d981" ) )
        {
            guy notify( "jumpedout" );
        }
    }
    
    if ( isdefined( guy.script_noteworthy ) && guy.script_noteworthy == "delete_after_unload" )
    {
        guy delete();
        return;
    }
    
    if ( isdefined( animpos.getout_delete ) && animpos.getout_delete )
    {
        guy delete();
        return;
    }
    
    guy guy_cleanup_vehiclevars();
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 5
// Checksum 0x0, Offset: 0x44ef
// Size: 0x2e2
function guy_unload_land( guy, exittag, jumpanim, loopanim, landanim )
{
    jumporigin = self gettagorigin( exittag );
    jumpangles = self gettagangles( exittag );
    startorigin = getstartorigin( jumporigin, jumpangles, jumpanim );
    startangles = getstartangles( jumporigin, jumpangles, jumpanim );
    move_delta = getmovedelta( jumpanim, 0, 1 );
    ent = spawn_tag_origin();
    ent.origin = startorigin;
    ent.angles = startangles;
    endorigin = ent localtoworldcoords( move_delta );
    ent thread delete_on_notify( "movedone" );
    fallstartorigin = endorigin;
    groundtrace = utility::groundpos( fallstartorigin );
    landstartorigin = getstartorigin( jumporigin, jumpangles, landanim );
    move_delta = getmovedelta( landanim, 0, 1 );
    landendorigin = landstartorigin + move_delta;
    landheight = landstartorigin[ 2 ] - landendorigin[ 2 ];
    fallendorigin = groundtrace + ( 0, 0, landheight );
    guy.allowdeath = 0;
    guy setcandamage( 0 );
    guy endon( "death" );
    wait getanimlength( jumpanim ) - 0.1;
    guy unlink();
    guy notify( "animontag_thread" );
    guy stopanimscripted();
    ent.origin = guy.origin;
    ent.angles = guy.angles;
    ent dontinterpolate();
    guy dontinterpolate();
    guy linkto( ent, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    guy.allowdeath = 1;
    guy setcandamage( 1 );
    guy.unload_loopanim = loopanim;
    
    if ( isai( guy ) )
    {
        guy script_func( "asm_animcustom", &guy_fall_loop, &guy_fall_loop_end );
    }
    else
    {
        guy thread guy_fall_loop();
    }
    
    falldist = length( ( 0, 0, fallendorigin[ 2 ] ) - ( 0, 0, fallstartorigin[ 2 ] ) );
    fallspeed = 350;
    falltime = falldist / fallspeed;
    ent moveto( fallendorigin, falltime );
    ent waittill( "movedone" );
    guy unlink();
    guy animscripted( "dropship_land", guy.origin, guy.angles, landanim );
    wait getanimlength( landanim );
    guy notify( "hoverunload_done" );
    guy notify( "anim_on_tag_done" );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x47d9
// Size: 0x7e
function guy_fall_loop()
{
    if ( isai( self ) )
    {
        if ( actor_is3d() )
        {
            self orientmode( "face angle 3d", self.angles );
        }
        else
        {
            self orientmode( "face angle", self.angles[ 1 ] );
        }
        
        self animmode( "zonly_physics", 1 );
        self clearanim( scripts\asm\asm::asm_getbodyknob(), 0.2 );
    }
    
    self setanim( self.unload_loopanim, 1 );
    self waittill( "dropship_land" );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x485f
// Size: 0x2
function guy_fall_loop_end()
{
    
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x4869
// Size: 0xe0, Type: bool
function guy_resets_goalpos( guy )
{
    if ( isdefined( guy.script_delayed_playerseek ) )
    {
        return false;
    }
    
    if ( istrue( guy script_func( "ai_has_color" ) ) )
    {
        return false;
    }
    
    if ( isdefined( guy.qsetgoalpos ) )
    {
        return false;
    }
    
    if ( !isdefined( guy.target ) )
    {
        return true;
    }
    
    nodes = getnodearray( guy.target, "targetname" );
    structs = getstructarray( guy.target, "targetname" );
    
    if ( nodes.size > 0 || structs.size > 0 )
    {
        return false;
    }
    
    ent = getent( guy.target, "targetname" );
    
    if ( isdefined( ent ) && ent.classname == "info_volume" )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 8
// Checksum 0x0, Offset: 0x4952
// Size: 0x317
function animontag( guy, tag, animation, notetracks, sthreads, flag, origin_offset, angles_offset )
{
    guy notify( "animontag_thread" );
    guy endon( "animontag_thread" );
    
    if ( !isdefined( origin_offset ) )
    {
        origin_offset = ( 0, 0, 0 );
    }
    
    if ( !isdefined( angles_offset ) )
    {
        angles_offset = ( 0, 0, 0 );
    }
    
    if ( !isdefined( flag ) )
    {
        flag = "animontagdone";
    }
    
    if ( isdefined( self.modeldummy ) )
    {
        animatemodel = self.modeldummy;
    }
    else
    {
        animatemodel = self;
    }
    
    if ( !isdefined( tag ) || !hastag( animatemodel.model, tag ) )
    {
        org = guy.origin;
        angles = guy.angles;
    }
    else
    {
        org = animatemodel gettagorigin( tag );
        angles = animatemodel gettagangles( tag ) + angles_offset;
        axes = anglestoaxis( angles );
        axesnames = [ "forward", "right", "up" ];
        
        for ( i = 0; i < axes.size ; i++ )
        {
            org += axes[ axesnames[ i ] ] * origin_offset[ i ];
        }
    }
    
    if ( isdefined( guy.ragdoll_getout_death ) )
    {
        level thread animontag_ragdoll_death( guy, self );
    }
    
    if ( !issp() )
    {
        guy dontinterpolate();
        
        if ( isai( guy ) )
        {
            animindex = guy scripts\asm\asm::asm_lookupanimfromalias( "animscripted", animation );
            xanim = guy scripts\asm\asm::asm_getxanim( "animscripted", animindex );
            startorg = getstartorigin( self.origin, self.angles, xanim );
            startangles = getstartangles( self.origin, self.angles, xanim );
            guy forceteleport( startorg, startangles );
            guy animmode( "nogravity" );
            guy aisetanim( "animscripted", animindex );
        }
    }
    else
    {
        guy animscripted( flag, org, angles, animation );
    }
    
    if ( isai( guy ) )
    {
        thread donotetracks( guy, animatemodel, flag );
    }
    
    if ( isdefined( guy.anim_end_early ) )
    {
        guy.anim_end_early = undefined;
        animwait = getanimlength( animation ) - 0.25;
        
        if ( animwait > 0 )
        {
            wait animwait;
        }
        
        guy stopanimscripted();
        guy.interval = 0;
        guy thread recover_interval();
    }
    else
    {
        if ( isdefined( notetracks ) )
        {
            for ( i = 0; i < notetracks.size ; i++ )
            {
                guy waittillmatch( flag, notetracks[ i ] );
                guy thread [[ sthreads[ i ] ]]();
            }
        }
        
        guy waittillmatch( flag, "end" );
    }
    
    guy notify( "anim_on_tag_done" );
    guy.ragdoll_getout_death = undefined;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x4c71
// Size: 0x25
function recover_interval()
{
    self endon( "death" );
    wait 2;
    
    if ( self.interval == 0 )
    {
        self.interval = 80;
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x4c9e
// Size: 0xfa
function animontag_ragdoll_death( guy, vehicle )
{
    if ( isdefined( guy.magic_bullet_shield ) && guy.magic_bullet_shield )
    {
        return;
    }
    
    if ( !isai( guy ) )
    {
        guy setcandamage( 1 );
    }
    
    guy endon( "anim_on_tag_done" );
    damage = undefined;
    attacker = undefined;
    var_d7c1a2eebd0b7c47 = vehicle.health <= 0;
    
    while ( true )
    {
        if ( !var_d7c1a2eebd0b7c47 && !( isdefined( vehicle ) && vehicle.health > 0 ) )
        {
            break;
        }
        
        guy waittill( "damage", damage, attacker );
        
        if ( isdefined( guy.forcefallthroughonropes ) )
        {
            break;
        }
        
        if ( !isdefined( damage ) )
        {
            continue;
        }
        
        if ( damage < 1 )
        {
            continue;
        }
        
        if ( !isdefined( attacker ) )
        {
            continue;
        }
        
        if ( isplayer( attacker ) )
        {
            break;
        }
    }
    
    if ( !isalive( guy ) )
    {
        return;
    }
    
    thread animontag_ragdoll_death_fall( guy, vehicle, attacker );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 3
// Checksum 0x0, Offset: 0x4da0
// Size: 0x298
function animontag_ragdoll_death_fall( guy, vehicle, attacker )
{
    guy.deathanim = undefined;
    guy.deathfunction = undefined;
    guy.anim_disablepain = 1;
    
    if ( isdefined( guy.ragdoll_fall_anim ) )
    {
        movedelta = getmovedelta( guy.ragdoll_fall_anim, 0, 1 );
        groundpos = physicstrace( guy.origin + ( 0, 0, 16 ), guy.origin - ( 0, 0, 10000 ) );
        distancefromground = distance( guy.origin + ( 0, 0, 16 ), groundpos );
        
        if ( abs( movedelta[ 2 ] + 16 ) <= abs( distancefromground ) )
        {
            guy thread script_func( "playsound_on_entity", "generic_death_falling" );
            guy animscripted( "fastrope_fall", guy.origin, guy.angles, guy.ragdoll_fall_anim );
            guy waittillmatch( "fastrope_fall", "start_ragdoll" );
        }
    }
    
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    guy.deathanim = undefined;
    guy.deathfunction = undefined;
    guy.anim_disablepain = 1;
    guy notify( "rope_death", attacker );
    guy kill( attacker.origin, attacker );
    
    if ( isdefined( guy.script_stay_drone ) )
    {
        guy notsolid();
        weapon_model = getweaponmodel( guy.weapon );
        weapon = guy.weapon;
        
        if ( isdefined( weapon_model ) )
        {
            guy detach( weapon_model, "tag_weapon_right" );
            org = guy gettagorigin( "tag_weapon_right" );
            ang = guy gettagangles( "tag_weapon_right" );
            level.gun = spawn( "weapon_" + getcompleteweaponname( weapon ), ( 0, 0, 0 ) );
            level.gun.angles = ang;
            level.gun.origin = org;
        }
    }
    else
    {
        guy script_func( "anim_dropallaiweapons" );
    }
    
    if ( isdefined( guy.fnpreragdoll ) )
    {
        guy [[ guy.fnpreragdoll ]]();
    }
    
    guy startragdoll();
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 3
// Checksum 0x0, Offset: 0x5040
// Size: 0x45
function donotetracks( guy, vehicle, flag )
{
    guy endon( "idle" );
    guy endon( "newanim" );
    vehicle endon( "death" );
    guy endon( "death" );
    guy script_func( "anim_donotetracks", flag );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 4
// Checksum 0x0, Offset: 0x508d
// Size: 0x41
function animatemoveintoplace( guy, org, angles, movetospotanim )
{
    guy animscripted( "movetospot", org, angles, movetospotanim );
    guy waittillmatch( "movetospot", "end" );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x50d6
// Size: 0x1b0
function guy_vehicle_death( guy, attacker )
{
    assert( !getdvarint( @"hash_9403d7d31fc1d981" ) );
    
    if ( !isalive( guy ) )
    {
        return;
    }
    
    if ( isdefined( self.no_rider_death ) )
    {
        return;
    }
    
    animpos = anim_pos( self, guy.vehicle_position );
    
    if ( isdefined( animpos.explosion_death ) )
    {
        return guy_blowup( guy );
    }
    
    classname = get_vehicle_classname();
    
    if ( isdefined( level.vehicle.templates.rider_death_func ) && isdefined( level.vehicle.templates.rider_death_func[ classname ] ) )
    {
        self [[ level.vehicle.templates.rider_death_func[ classname ] ]]();
        return;
    }
    
    if ( isdefined( animpos.unload_ondeath ) && isdefined( self ) )
    {
        if ( isdefined( self.dontunloadondeath ) && self.dontunloadondeath )
        {
            return;
        }
        
        thread guy_idle( guy, guy.vehicle_position, 1 );
        wait animpos.unload_ondeath;
        
        if ( isdefined( guy ) && isdefined( self ) )
        {
            self.groupedanim_pos = guy.vehicle_position;
            animate_guys( "unload" );
        }
        
        return;
    }
    
    if ( isdefined( guy ) )
    {
        if ( isdefined( guy.ragdoll_getout_death ) )
        {
            return;
        }
        
        assertex( !isdefined( guy.magic_bullet_shield ), "<dev string:x270>" + guy getentitynumber() );
        guy delete();
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x528e
// Size: 0x19
function ai_wait_go()
{
    self endon( "death" );
    self waittill( "loaded" );
    scripts\common\vehicle_paths::gopath( self );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x52af
// Size: 0x13e
function set_pos( guy, vehicleanim )
{
    pos = guy.script_startingposition;
    
    /#
        if ( isdefined( pos ) )
        {
            assertex( pos < vehicleanim.size && pos >= 0, "<dev string:x2af>" + vehicleanim.size - 1 );
        }
    #/
    
    if ( isdefined( guy.forced_startingposition ) )
    {
        pos = guy.forced_startingposition;
    }
    
    if ( isdefined( pos ) )
    {
        return pos;
    }
    
    assertex( !isdefined( pos ), "<dev string:x2f4>" );
    
    for ( j = 0; j < self.usedpositions.size ; j++ )
    {
        if ( self.usedpositions[ j ] )
        {
            continue;
        }
        
        if ( isdefined( guy.isvehicle ) && !isdefined( vehicleanim[ j ].isvehicle ) )
        {
            continue;
        }
        
        if ( !isdefined( guy.isvehicle ) && isdefined( vehicleanim[ j ].isvehicle ) )
        {
            continue;
        }
        
        return j;
    }
    
    if ( isdefined( guy.isvehicle ) && guy.isvehicle )
    {
        assertmsg( "<dev string:x311>" );
        return;
    }
    
    assertmsg( "<dev string:x352>" );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 3
// Checksum 0x0, Offset: 0x53f5
// Size: 0x102
function guy_man_turret( guy, pos, var_5b0cab0a9420da60 )
{
    animpos = anim_pos( self, pos );
    turret = self.mgturret[ animpos.mgturret ];
    
    if ( !isalive( guy ) )
    {
        return;
    }
    
    turret endon( "death" );
    guy endon( "death" );
    
    if ( isdefined( var_5b0cab0a9420da60 ) && var_5b0cab0a9420da60 && isdefined( animpos.passenger_2_turret_func ) )
    {
        [[ animpos.passenger_2_turret_func ]]( self, guy, pos, turret );
    }
    
    set_turret_team( turret );
    turret setdefaultdroppitch( 0 );
    wait 0.1;
    guy endon( "guy_man_turret_stop" );
    level thread vehicle_turret_difficulty( turret, utility::getdifficulty() );
    turret self_func( "setturretignoregoals", 1 );
    pose = "stand";
    
    if ( isdefined( animpos.turretpos ) )
    {
        pose = animpos.turretpos;
    }
    
    guy scripts\asm\asm_bb::bb_requestturret( turret );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x54ff
// Size: 0x26
function guy_unlink_on_death( guy )
{
    guy endon( "jumpedout" );
    guy waittill( "death" );
    
    if ( isdefined( guy ) )
    {
        guy unlink();
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x552d
// Size: 0x2d0
function guy_blowup( guy )
{
    if ( !isdefined( guy.vehicle_position ) )
    {
        return;
    }
    
    pos = guy.vehicle_position;
    anim_pos = anim_pos( self, pos );
    
    if ( !isdefined( anim_pos.explosion_death ) )
    {
        return;
    }
    
    guy.deathanim = anim_pos.explosion_death;
    angles = self.angles;
    origin = guy.origin;
    
    if ( isdefined( anim_pos.explosion_death_offset ) )
    {
        origin += anglestoforward( angles ) * anim_pos.explosion_death_offset[ 0 ];
        origin += anglestoright( angles ) * anim_pos.explosion_death_offset[ 1 ];
        origin += anglestoup( angles ) * anim_pos.explosion_death_offset[ 2 ];
    }
    
    guy = convert_guy_to_drone( guy );
    detach_models_with_substr( guy, "weapon_" );
    guy notsolid();
    guy.origin = origin;
    guy.angles = angles;
    guy animscripted( "deathanim", origin, angles, anim_pos.explosion_death );
    fraction = 0.3;
    
    if ( isdefined( anim_pos.explosion_death_ragdollfraction ) )
    {
        fraction = anim_pos.explosion_death_ragdollfraction;
    }
    
    animlength = getanimlength( anim_pos.explosion_death );
    timer = gettime() + animlength * 1000;
    wait animlength * fraction;
    force = ( 0, 0, 1 );
    org = guy.origin;
    
    if ( getdvar( @"ragdoll_enable" ) == "0" )
    {
        guy delete();
        return;
    }
    
    if ( isai( guy ) )
    {
        guy script_func( "anim_dropallaiweapons" );
    }
    else
    {
        detach_models_with_substr( guy, "weapon_" );
    }
    
    while ( !guy isragdoll() && gettime() < timer )
    {
        org = guy.origin;
        wait 0.05;
        force = guy.origin - org;
        
        if ( isdefined( guy.fnpreragdoll ) )
        {
            guy [[ guy.fnpreragdoll ]]();
        }
        
        guy startragdoll();
    }
    
    wait 0.05;
    force *= 20000;
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( isdefined( guy ) )
        {
            org = guy.origin;
        }
        
        wait 0.05;
    }
    
    if ( !guy isragdoll() )
    {
        guy delete();
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x5805
// Size: 0xe9
function convert_guy_to_drone( guy, var_5d30c43be498cbaf )
{
    if ( !isdefined( var_5d30c43be498cbaf ) )
    {
        var_5d30c43be498cbaf = 0;
    }
    
    model = spawn( "script_model", guy.origin );
    model.angles = guy.angles;
    model setmodel( guy.model );
    size = guy getattachsize();
    
    for ( i = 0; i < size ; i++ )
    {
        model attach( guy getattachmodelname( i ), guy getattachtagname( i ) );
    }
    
    model useanimtree( #animtree );
    
    if ( isdefined( guy.team ) )
    {
        model.team = guy.team;
    }
    
    if ( !var_5d30c43be498cbaf )
    {
        guy delete();
    }
    
    model self_func( "makefakeai" );
    return model;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x58f7
// Size: 0x23
function vehicle_animate( animation, animtree )
{
    self useanimtree( animtree );
    self setanim( animation );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x5922
// Size: 0x8e
function vehicle_getinstart( pos )
{
    animpos = anim_pos( self, pos );
    assert( isdefined( animpos ) );
    assert( isdefined( animpos.sittag ) );
    assert( getdvarint( @"hash_9403d7d31fc1d981" ) || isdefined( animpos.getin ) );
    return vehicle_getanimstart( animpos.getin, animpos.sittag, pos, animpos.canshootinvehicle );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 4
// Checksum 0x0, Offset: 0x59b9
// Size: 0xfa
function vehicle_getanimstart( animation, tag, pos, canshootinvehicle )
{
    struct = spawnstruct();
    origin = undefined;
    angles = undefined;
    assert( getdvarint( @"hash_9403d7d31fc1d981" ) || isdefined( animation ) );
    org = self gettagorigin( tag );
    ang = self gettagangles( tag );
    
    if ( !getdvarint( @"hash_9403d7d31fc1d981" ) || isdefined( animation ) )
    {
        origin = getstartorigin( org, ang, animation );
        angles = getstartangles( org, ang, animation );
    }
    else
    {
        origin = org;
        angles = ang;
    }
    
    struct.origin = origin;
    struct.angles = angles;
    struct.vehicle_position = pos;
    struct.canshootinvehicle = canshootinvehicle;
    return struct;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 3
// Checksum 0x0, Offset: 0x5abc
// Size: 0xda, Type: bool
function is_position_in_group( vehicle, pos, group )
{
    if ( !isdefined( group ) )
    {
        return true;
    }
    
    classname = vehicle get_vehicle_classname();
    assert( isdefined( level.vehicle.templates.unloadgroups[ classname ][ group ] ) );
    vehicles_group = level.vehicle.templates.unloadgroups[ classname ][ group ];
    
    foreach ( member in vehicles_group )
    {
        if ( member == pos )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x5b9f
// Size: 0xf1
function get_availablepositions( group )
{
    vehicleanim = level.vehicle.templates.aianims[ get_vehicle_classname() ];
    availablepositions = [];
    nonanimatedpositions = [];
    
    for ( i = 0; i < self.usedpositions.size ; i++ )
    {
        if ( self.usedpositions[ i ] )
        {
            continue;
        }
        
        if ( ( getdvarint( @"hash_9403d7d31fc1d981" ) || isdefined( vehicleanim[ i ].getin ) ) && is_position_in_group( self, i, group ) )
        {
            availablepositions[ availablepositions.size ] = vehicle_getinstart( i );
            continue;
        }
        
        nonanimatedpositions[ nonanimatedpositions.size ] = i;
    }
    
    struct = spawnstruct();
    struct.availablepositions = availablepositions;
    struct.nonanimatedpositions = nonanimatedpositions;
    return struct;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x5c99
// Size: 0x1e
function getanimatemodel()
{
    if ( isdefined( self.modeldummy ) )
    {
        return self.modeldummy;
    }
    
    return self;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 2
// Checksum 0x0, Offset: 0x5cbf
// Size: 0xb6
function detach_models_with_substr( guy, substr )
{
    size = guy getattachsize();
    var_895aea96c7debffd = [];
    var_e51d4c9a2f109b4b = [];
    index = 0;
    
    for ( i = 0; i < size ; i++ )
    {
        modelname = guy getattachmodelname( i );
        tagname = guy getattachtagname( i );
        
        if ( issubstr( modelname, substr ) )
        {
            var_895aea96c7debffd[ index ] = modelname;
            var_e51d4c9a2f109b4b[ index ] = tagname;
        }
    }
    
    for ( i = 0; i < var_895aea96c7debffd.size ; i++ )
    {
        guy detach( var_895aea96c7debffd[ i ], var_e51d4c9a2f109b4b[ i ] );
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x5d7d
// Size: 0x27, Type: bool
function should_give_orghealth()
{
    if ( !isai( self ) )
    {
        return false;
    }
    
    if ( !isdefined( self.orghealth ) )
    {
        return false;
    }
    
    return !isdefined( self.magic_bullet_shield );
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x5dad
// Size: 0x23
function stable_unlink( guy )
{
    self waittill( "stable_for_unlink" );
    
    if ( isalive( guy ) )
    {
        guy unlink();
    }
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 1
// Checksum 0x0, Offset: 0x5dd8
// Size: 0x11a
function animate_guys( other )
{
    return_guys = [];
    
    foreach ( guy in self.riders )
    {
        if ( isai( guy ) && !isalive( guy ) )
        {
            continue;
        }
        
        if ( isdefined( level.vehicle.aianimcheck[ other ] ) && ![[ level.vehicle.aianimcheck[ other ] ]]( guy, guy.vehicle_position ) )
        {
            continue;
        }
        
        if ( isdefined( level.vehicle.aianimthread[ other ] ) )
        {
            guy notify( "newanim" );
            thread [[ level.vehicle.aianimthread[ other ] ]]( guy, guy.vehicle_position );
            return_guys[ return_guys.size ] = guy;
            continue;
        }
        
        println( "<dev string:x399>", other );
    }
    
    return return_guys;
}

// Namespace vehicle_aianim / scripts\common\vehicle_aianim
// Params 0
// Checksum 0x0, Offset: 0x5efb
// Size: 0x2a
function guy_cleanup_vehiclevars()
{
    self.vehicle_idling = undefined;
    self.standing = undefined;
    self.vehicle_position = undefined;
    self.delay = undefined;
}

