#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\asm\asm_sp;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\drone_base;
#using scripts\sp\fakeactor;
#using scripts\sp\mgturret;
#using scripts\sp\player_stats;
#using scripts\sp\spawner;
#using scripts\sp\vehicle_treads;

#namespace vehicle;

// Namespace vehicle / scripts\sp\vehicle
// Params 0
// Checksum 0x0, Offset: 0x3f1
// Size: 0x200
function init_vehicles()
{
    if ( !add_init_script( "vehicles_sp", &init_vehicles ) )
    {
        return;
    }
    
    create_func_ref( "makefakeai", &makefakeai );
    create_func_ref( "setturretignoregoals", &setturretignoregoals );
    create_func_ref( "vehicle_orientto", &vehicle_orientto );
    create_func_ref( "getspawnerarray", &getspawnerarray );
    create_func_ref( "setAiSpread", &setaispread );
    create_func_ref( "forcecolor_riders", &vehicle_script_forcecolor_riders );
    create_func_ref( "vehicle_treads", &scripts\sp\vehicle_treads::vehicle_treads );
    create_func_ref( "drone_give_soul", &scripts\sp\drone_base::drone_give_soul );
    create_func_ref( "fakeactor_give_soul", &scripts\sp\fakeactor::fakeactor_give_soul );
    create_func_ref( "anim_placeweaponon", &scripts\anim\shared::placeweaponon );
    create_func_ref( "vehicle_deathflag", &scripts\sp\spawner::vehicle_deathflag );
    create_func_ref( "vehicle_spawner_deathflag", &scripts\sp\spawner::vehicle_spawner_deathflag );
    create_func_ref( "run_spawn_functions", &scripts\sp\spawner::run_spawn_functions );
    create_func_ref( "anim_updateanimpose", &scripts\anim\utility::updateanimpose );
    create_func_ref( "anim_donotetracks", &scripts\anim\notetracks::donotetracks );
    create_func_ref( "anim_dropallaiweapons", &scripts\anim\shared::dropallaiweapons );
    create_func_ref( "register_kill", &scripts\sp\player_stats::register_kill );
    create_func_ref( "register_shot_hit", &scripts\sp\player_stats::register_shot_hit );
    create_func_ref( "register_shot_hit", &scripts\sp\player_stats::register_shot_hit );
    create_func_ref( "burst_fire_unmanned", &scripts\sp\mgturret::burst_fire_unmanned );
    create_func_ref( "turret_watchPlayerUse", &scripts\sp\mgturret::turret_watchplayeruse );
    create_func_ref( "use_turret", &utility::use_turret );
    create_func_ref( "asm_animcustom", &scripts\asm\asm_sp::asm_animcustom );
    create_func_ref( "spawner_makerealai", &scripts\sp\spawner::spawner_makerealai );
    create_func_ref( "use_a_turret", &scripts\sp\spawner::use_a_turret );
    create_func_ref( "go_to_node", &scripts\sp\spawner::go_to_node );
    create_func_ref( "fastrope_anim", &fastrope_anim );
    create_func_ref( "vehicle_door_anim", &door_anim );
    create_func_ref( "vehicle_usable", &function_7d87dd9eb57867a1 );
    scripts\common\vehicle::init_vehicles();
}

// Namespace vehicle / scripts\sp\vehicle
// Params 1
// Checksum 0x0, Offset: 0x5f9
// Size: 0xd, Type: bool
function reservevehicle( count )
{
    return true;
}

// Namespace vehicle / scripts\sp\vehicle
// Params 2
// Checksum 0x0, Offset: 0x60f
// Size: 0xfa
function spawnvehicle_sp( spawndata, faildata )
{
    vehicle = undefined;
    
    if ( isdefined( spawndata.initialvelocity ) )
    {
        vehicle = spawnvehicle( spawndata.modelname, spawndata.targetname, spawndata.vehicletype, spawndata.origin, spawndata.angles, spawndata.owner, spawndata.initialvelocity, spawndata.dospawnedcallback );
    }
    else
    {
        vehicle = spawnvehicle( spawndata.modelname, spawndata.targetname, spawndata.vehicletype, spawndata.origin, spawndata.angles, spawndata.owner, undefined, spawndata.dospawnedcallback );
    }
    
    if ( !isdefined( vehicle ) )
    {
        return undefined;
    }
    
    vehicle.spawndata = spawndata;
    return vehicle;
}

// Namespace vehicle / scripts\sp\vehicle
// Params 1
// Checksum 0x0, Offset: 0x712
// Size: 0x12
function deletevehicle_sp( vehicle )
{
    vehicle delete();
}

// Namespace vehicle / scripts\sp\vehicle
// Params 1
// Checksum 0x0, Offset: 0x72c
// Size: 0xa0
function vehicle_script_forcecolor_riders( script_forcecolor )
{
    foreach ( rider in self.riders )
    {
        if ( isai( rider ) )
        {
            rider set_force_color( script_forcecolor );
            continue;
        }
        
        if ( isdefined( rider.spawner ) )
        {
            rider.spawner.script_forcecolor = script_forcecolor;
            continue;
        }
        
        assertmsg( "rider who's not an ai without a spawner.." );
    }
}

// Namespace vehicle / scripts\sp\vehicle
// Params 3
// Checksum 0x0, Offset: 0x7d4
// Size: 0x3d
function fastrope_anim( model, animation, flag )
{
    model animscripted( flag, model.origin, model.angles, animation, undefined, undefined, 0 );
}

// Namespace vehicle / scripts\sp\vehicle
// Params 2
// Checksum 0x0, Offset: 0x819
// Size: 0x20
function door_anim( vehicle, animation )
{
    vehicle setflaggedanimrestart( "vehicle_anim_flag", animation );
}

// Namespace vehicle / scripts\sp\vehicle
// Params 3
// Checksum 0x0, Offset: 0x841
// Size: 0x91
function function_7d87dd9eb57867a1( distance, enter, interact_delay )
{
    if ( !self vehicle_isphysveh() )
    {
        return;
    }
    
    if ( !isdefined( distance ) )
    {
        distance = 150;
    }
    
    interact_delay = default_to( interact_delay, 0.5 );
    
    if ( !isdefined( self.candamage ) )
    {
        function_36dbb623c325c79( 1 );
    }
    
    thread scripts\common\vehicle::vehicle_watch_for_driving( distance, &function_fbef61d68f733524, &function_e5f869d16eb9abea, interact_delay );
    
    if ( istrue( enter ) )
    {
        level.player.veh = self;
        level.player function_fbef61d68f733524( self );
    }
}

// Namespace vehicle / scripts\sp\vehicle
// Params 0
// Checksum 0x0, Offset: 0x8da
// Size: 0x14
function function_abf25557f46191c5()
{
    self notify( "stop_driveable" );
    self.player_drivable = undefined;
}

// Namespace vehicle / scripts\sp\vehicle
// Params 1
// Checksum 0x0, Offset: 0x8f6
// Size: 0x190
function function_fbef61d68f733524( veh )
{
    if ( isdefined( veh.driver ) )
    {
        return;
    }
    
    animtag = "tag_seat_0";
    veh function_f3ae3ea0abca3cfb( animtag );
    veh.ownerid = self getentitynumber();
    veh.originalowner = self;
    veh.team_og = veh.team;
    veh.driver = level.player;
    
    if ( isdefined( self.team ) )
    {
        veh.team = self.team;
    }
    
    self setplayerangles( veh.angles );
    veh setotherent( self );
    self animscriptentervehicle();
    veh vehicle_turnengineon();
    self usevehicle( veh, 0, 1 );
    self hideviewmodel();
    self hidelegsandshadow();
    
    if ( veh hascomponent( "p2p" ) )
    {
        veh setconfigvalue( "p2p", "pause", 1 );
    }
    
    if ( veh hascomponent( "path" ) )
    {
        veh setconfigvalue( "path", "pause", 1 );
    }
    
    if ( isdefined( veh.turret ) )
    {
        veh.turret setotherent( self );
        self remotecontrolturret( veh.turret );
    }
    
    veh vehphys_parkingbrake( 0 );
    
    if ( isdefined( veh.classname_mp ) )
    {
        veh scripts\common\vehicle::function_65976a53a9cbd110();
        veh scripts\common\vehicle::function_89cec1224ae724d5();
        veh scripts\common\vehicle::function_7b7412ddbeed1f41( 0 );
    }
    
    self notify( "entered_driving_vehicle", veh );
}

// Namespace vehicle / scripts\sp\vehicle
// Params 1
// Checksum 0x0, Offset: 0xa8e
// Size: 0x38
function function_36dbb623c325c79( bool )
{
    if ( bool )
    {
        self.candamage = 1;
        self setcandamage( 1 );
        return;
    }
    
    self.candamage = 0;
    self setcandamage( 0 );
}

// Namespace vehicle / scripts\sp\vehicle
// Params 1
// Checksum 0x0, Offset: 0xace
// Size: 0x15d
function function_e5f869d16eb9abea( veh )
{
    if ( !isdefined( veh.driver ) )
    {
        return;
    }
    
    veh.ownerid = 0;
    veh.originalowner = undefined;
    veh.driver = undefined;
    
    if ( isdefined( veh.team_og ) )
    {
        veh.team = veh.team_og;
    }
    
    if ( isdefined( veh.exitfunc ) )
    {
        exitpos = [[ veh.exitfunc ]]();
    }
    else
    {
        exitpos = self.origin + anglestoright( self.angles ) * -100 + anglestoforward( self.angles ) * -80;
    }
    
    self leavevehicle( 0, 1 );
    self setorigin( scripts\engine\utility::drop_to_ground( exitpos, 0, 0 ) );
    self animscriptexitvehicle();
    veh setotherent( undefined );
    veh setentityowner( undefined );
    function_9b59f5c375018695();
    self showlegsandshadow();
    
    if ( isdefined( veh.turret ) )
    {
        self remotecontrolturretoff( veh.turret );
        veh.turret setmode( "sentry_offline" );
    }
    
    if ( isdefined( veh.classname_mp ) )
    {
        veh scripts\common\vehicle::function_37f33bfe6b63cb0a();
        veh scripts\common\vehicle::function_7b7412ddbeed1f41( 1 );
    }
    
    self notify( "exited_driving_vehicle", veh );
}

// Namespace vehicle / scripts\sp\vehicle
// Params 0
// Checksum 0x0, Offset: 0xc33
// Size: 0x9
function function_9b59f5c375018695()
{
    self showviewmodel();
}

// Namespace vehicle / scripts\sp\vehicle
// Params 1
// Checksum 0x0, Offset: 0xc44
// Size: 0x77, Type: bool
function function_f3ae3ea0abca3cfb( bone )
{
    parts = getnumparts( self.model );
    
    if ( parts > 0 )
    {
        for ( i = 0; i < parts ; i++ )
        {
            if ( getpartname( self.model, i ) == bone )
            {
                return true;
            }
        }
    }
    
    iprintln( "WARNING! " + self.model + " does not have bone, " + bone );
    return false;
}

// Namespace vehicle / scripts\sp\vehicle
// Params 1
// Checksum 0x0, Offset: 0xcc4
// Size: 0x74
function function_6355c25e9ecabe14( weaponname )
{
    assertex( isdefined( weaponname ), "Need to supply the weapon name!" );
    
    if ( !isdefined( self.var_11bd2d454480b300 ) )
    {
        self.var_11bd2d454480b300 = [];
    }
    
    if ( !isarray( weaponname ) )
    {
        weaponname = [ weaponname ];
    }
    
    self.var_11bd2d454480b300 = array_combine( self.var_11bd2d454480b300, weaponname );
    self.var_11bd2d454480b300 = array_remove_duplicates( self.var_11bd2d454480b300 );
}

// Namespace vehicle / scripts\sp\vehicle
// Params 2
// Checksum 0x0, Offset: 0xd40
// Size: 0xf2
function function_1fcabf2cb45d2c22( weaponname, scale )
{
    assertex( isdefined( weaponname ), "Need to supply the weapon name!" );
    assertex( isdefined( scale ), "Need to supply the scale!" );
    assertex( !isstring( scale ), "Scale needs to be an INT, not a string!" );
    
    if ( !isdefined( self.var_b8e957f2bf26c5e5 ) )
    {
        self.var_b8e957f2bf26c5e5 = [];
    }
    
    if ( isarray( weaponname ) )
    {
        foreach ( name in weaponname )
        {
            self.var_b8e957f2bf26c5e5 = array_add( self.var_b8e957f2bf26c5e5, [ name, scale ] );
        }
        
        return;
    }
    
    self.var_b8e957f2bf26c5e5 = array_add( self.var_b8e957f2bf26c5e5, [ weaponname, scale ] );
}

// Namespace vehicle / scripts\sp\vehicle
// Params 2
// Checksum 0x0, Offset: 0xe3a
// Size: 0x22
function function_d3314c8d717e9ae6( usedistance, enter )
{
    thread script_func( "vehicle_usable", usedistance, enter );
}

