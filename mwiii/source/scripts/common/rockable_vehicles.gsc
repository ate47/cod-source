#using scripts\common\utility;
#using scripts\engine\utility;

#namespace rockable_vehicles;

// Namespace rockable_vehicles / scripts\common\rockable_vehicles
// Params 0
// Checksum 0x0, Offset: 0x2e6
// Size: 0x24
function init()
{
    setdvarifuninitialized( @"hash_89dce574801028ad", 0 );
    level delaythread( 0.05, &rockable_cars_init );
}

// Namespace rockable_vehicles / scripts\common\rockable_vehicles
// Params 0
// Checksum 0x0, Offset: 0x312
// Size: 0x2e8
function rockable_cars_init()
{
    level.rockablecars = spawnstruct();
    level.rockablecars.cars = [];
    scriptables = getscriptablearray( "scriptable", "code_classname" );
    
    if ( !isdefined( scriptables ) || scriptables.size <= 0 )
    {
        return;
    }
    
    count = 0;
    
    foreach ( car in scriptables )
    {
        if ( count > 19 )
        {
            count = 0;
            waitframe();
        }
        
        count += 1;
        
        if ( utility::issp() )
        {
            if ( !isdefined( car.model ) || !car valid_rockable_vehicle() )
            {
                continue;
            }
        }
        
        if ( !car getscriptablehaspart( "Anim_Explosion" ) && !car getscriptablehaspart( "Anim_PlayerStandRock" ) )
        {
            continue;
        }
        
        level.rockablecars.cars[ level.rockablecars.cars.size ] = car;
        car.forward = anglestoforward( car.angles );
        car.right = anglestoright( car.angles );
        
        if ( !utility::issp() )
        {
            car.up = anglestoup( car.angles );
            car.frontpoint = car getpointinbounds( 1, 0, 0 );
            car.backpoint = car getpointinbounds( -1, 0, 0 );
            car.leftpoint = car getpointinbounds( 0, 1, 0 );
            car.rightpoint = car getpointinbounds( 0, -1, 0 );
            car.toppoint = car getpointinbounds( 0, 0, -0.15 );
            car.halflength = vectordot( car.forward, car.frontpoint - car.backpoint ) / 2;
            car.halfwidth = vectordot( car.right, car.rightpoint - car.leftpoint ) / 2;
            car.players = [];
            car.touchtimes = [];
            car.rocktimes = [];
            car.var_743ebab8013b6cde = 1;
        }
        
        car thread rockable_car_debug();
        
        if ( getdvarint( @"hash_2448528570ef56f7", 1 ) == 1 )
        {
            car thread rockable_car_watch_damage();
            car thread rockable_car_watch_death();
            continue;
        }
        
        car setscriptablepartstate( "body", "no_process" );
    }
    
    flag_set( "rockable_cars_init" );
    level thread alarm_cars_init();
}

// Namespace rockable_vehicles / scripts\common\rockable_vehicles
// Params 0
// Checksum 0x0, Offset: 0x602
// Size: 0x59
function valid_rockable_vehicle()
{
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "not_rockable" )
    {
        return 0;
    }
    
    if ( issubstr( self.model, "veh8_" ) || issubstr( self.model, "veh9_" ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace rockable_vehicles / scripts\common\rockable_vehicles
// Params 0
// Checksum 0x0, Offset: 0x663
// Size: 0x138
function rockable_car_watch_damage()
{
    self endon( "death" );
    self endon( "rocked" );
    self setcandamage( 1 );
    self.rockable_last_point = 0;
    self.rockable_last_meansofdeath = "";
    
    while ( true )
    {
        self.health = 99999;
        self waittill( "damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        self.rockable_last_point = point;
        self.rockable_last_meansofdeath = meansofdeath;
        print3d_debug( self.origin + ( 0, 0, 0 ), "Damage by: " + meansofdeath + " " + damage, ( 1, 1, 1 ), 1, 0.25, 100 );
    }
}

// Namespace rockable_vehicles / scripts\common\rockable_vehicles
// Params 0
// Checksum 0x0, Offset: 0x7a3
// Size: 0x2a4
function rockable_car_watch_death()
{
    self endon( "death" );
    self waittillmatch( "scriptableNotification", "anim_explosion" );
    self notify( "rocked" );
    
    if ( isexplosivedamagemod( self.rockable_last_meansofdeath ) )
    {
        btwn = self.rockable_last_point - self.origin;
        forwardstr = ter_op( vectordot( self.forward, btwn ) > 0, "front", "back" );
        rightstr = ter_op( vectordot( self.right, btwn ) > 0, "right", "left" );
        self setscriptablepartstate( "Anim_Explosion", forwardstr + "_" + rightstr, 0 );
        print3d_debug( self.origin + ( 0, 0, -5 ), "Death by: " + self.rockable_last_meansofdeath, ( 1, 0, 0 ), 1, 0.25, 1000 );
        print3d_debug( self.origin + ( 0, 0, 12 ), "Animation: " + forwardstr + "_" + rightstr, ( 1, 1, 1 ), 1, 0.25, 1000 );
    }
    else
    {
        death_anims = [ "front_left", "front_right", "back_left", "back_right" ];
        death_anim = death_anims[ randomint( death_anims.size - 1 ) ];
        self setscriptablepartstate( "Anim_Explosion", death_anim, 0 );
        print3d_debug( self.origin + ( 0, 0, -5 ), "Death by: " + self.rockable_last_meansofdeath, ( 1, 0, 0 ), 1, 0.25, 1000 );
        print3d_debug( self.origin + ( 0, 0, 5 ), "scripted explosion", ( 1, 0, 0 ), 1, 0.5, 500 );
        print3d_debug( self.origin + ( 0, 0, 10 ), "Animation: " + death_anim, ( 1, 1, 1 ), 1, 0.25, 1000 );
    }
    
    if ( getdvarint( @"hash_e9421533f01288a", 0 ) == 1 )
    {
        wait randomfloatrange( 15, 30 );
        self setscriptablepartstate( "body", "onfire" );
        thread rockable_car_watch_death();
        return;
    }
    
    self waittillmatch( "scriptableNotification", "anim_explosion_complete" );
    thread rockable_car_watch_dead();
}

// Namespace rockable_vehicles / scripts\common\rockable_vehicles
// Params 0
// Checksum 0x0, Offset: 0xa4f
// Size: 0x160
function rockable_car_watch_dead()
{
    self endon( "death" );
    
    while ( true )
    {
        self.health = 99999;
        self waittill( "damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isexplosivedamagemod( meansofdeath ) && damage > 10 )
        {
            self setscriptablepartstate( "Anim_Explosion", "rock", 1 );
        }
        
        print3d_debug( self.origin + ( 0, 0, 7 ), "Death animation: " + "rock", ( 1, 1, 1 ), 1, 0.25, 1000 );
        print3d_debug( self.origin + ( 0, 0, 0 ), "Death damage by: " + meansofdeath + " " + damage, ( 1, 1, 1 ), 1, 0.25, 150 );
    }
}

// Namespace rockable_vehicles / scripts\common\rockable_vehicles
// Params 0
// Checksum 0x0, Offset: 0xbb7
// Size: 0x58
function rockable_car_debug()
{
    self endon( "death" );
    
    if ( getdvarint( @"hash_89dce574801028ad" ) )
    {
        for ( ;; )
        {
            print3d_debug( self.origin + ( 0, 0, 60 ), "rockable", ( 1, 1, 1 ), 1, 0.5, 2 );
            waitframe();
            waitframe();
        }
    }
}

// Namespace rockable_vehicles / scripts\common\rockable_vehicles
// Params 0
// Checksum 0x0, Offset: 0xc17
// Size: 0x118
function alarm_cars_init()
{
    level.alarmcars = spawnstruct();
    level.alarmcars.cars = level.rockablecars.cars;
    count = 0;
    
    foreach ( car in level.alarmcars.cars )
    {
        if ( count > 19 )
        {
            count = 0;
            waitframe();
        }
        
        count += 1;
        
        if ( !isdefined( car.script_noteworthy ) || car.script_noteworthy != "veh9_generic_alarm_on" || !isdefined( car getscriptablehaspart( "Car_Alarm" ) ) )
        {
            level.alarmcars.cars = array_remove( level.alarmcars.cars, car );
            continue;
        }
        
        car thread alarm_car_watch_damage();
    }
}

// Namespace rockable_vehicles / scripts\common\rockable_vehicles
// Params 0
// Checksum 0x0, Offset: 0xd37
// Size: 0x166
function alarm_car_watch_damage()
{
    self endon( "death" );
    self endon( "rocked" );
    self endon( "stop_alarm" );
    self setcandamage( 1 );
    self.alarmdamage = 0;
    thread alarm_car_debug();
    
    while ( true )
    {
        self.health = 99999;
        self waittill( "damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        print3d_debug( self.origin + ( 0, 0, -7 ), "Alarm damage by: " + meansofdeath + " " + damage, ( 1, 1, 1 ), 1, 0.25, 150 );
        self.alarmdamage += damage;
        waitframe();
        
        if ( self.alarmdamage > 200 )
        {
            self setscriptablepartstate( "Car_Alarm", "on", 0 );
            level notify( "veh9_generic_alarm_on", self );
            break;
        }
    }
}

// Namespace rockable_vehicles / scripts\common\rockable_vehicles
// Params 0
// Checksum 0x0, Offset: 0xea5
// Size: 0x62
function alarm_car_debug()
{
    self endon( "death" );
    
    if ( getdvarint( @"hash_89dce574801028ad" ) )
    {
        for ( ;; )
        {
            print3d_debug( self.origin + ( 0, 0, 70 ), "alarm.  dmg: " + self.alarmdamage, ( 1, 1, 1 ), 1, 0.5, 2 );
            waitframe();
            waitframe();
        }
    }
}

// Namespace rockable_vehicles / scripts\common\rockable_vehicles
// Params 6
// Checksum 0x0, Offset: 0xf0f
// Size: 0x53
function print3d_debug( origin, text, color, alpha, scale, duration )
{
    if ( getdvarint( @"hash_89dce574801028ad" ) )
    {
        /#
            print3d( origin, text, color, alpha, scale, duration );
        #/
    }
}

