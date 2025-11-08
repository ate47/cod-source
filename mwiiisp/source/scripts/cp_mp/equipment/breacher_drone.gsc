#using script_608c50392df8c7d1;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace breacher_drone;

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x218
// Size: 0x9
function autoexec main()
{
    function_dd3ae1df4fce2e85();
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 0
// Checksum 0x0, Offset: 0x229
// Size: 0x45
function function_dd3ae1df4fce2e85()
{
    if ( issharedfuncdefined( "breacher_drone", "init" ) )
    {
        [[ getsharedfunc( "breacher_drone", "init" ) ]]();
    }
    
    registersharedfunc( "breacher_drone", "breacher_drone_used", &breacher_drone_used );
    function_633c7f773e57ca31();
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 0
// Checksum 0x0, Offset: 0x276
// Size: 0xe9
function function_633c7f773e57ca31()
{
    setdvarifuninitialized( @"hash_948191727e1e0a48", 1 );
    setdvarifuninitialized( @"hash_15f4bdd9a935599e", 8 );
    setdvarifuninitialized( @"hash_590aa3dcb5b178b3", 0.2 );
    setdvarifuninitialized( @"hash_880bc9cb96e0d47a", 20 );
    setdvarifuninitialized( @"hash_e84ef551e525beef", 25 );
    setdvarifuninitialized( @"hash_4eb410aa813c8a92", 40 );
    setdvarifuninitialized( @"hash_d0988687e6689cf8", 0.5 );
    setdvarifuninitialized( @"hash_178470c11f7062cd", 2.5 );
    setdvarifuninitialized( @"hash_984112ed98131c1f", 0 );
    setdvarifuninitialized( @"hash_b3179bfb043e6579", 15 );
    setdvarifuninitialized( @"hash_30eb2c84bb64de0f", -20 );
    setdvarifuninitialized( @"hash_c829ecd8ebe56106", 20 );
    setdvarifuninitialized( @"hash_d4ac918df9a03e8", 0 );
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 1
// Checksum 0x0, Offset: 0x367
// Size: 0x1b6
function breacher_drone_used( breacher_drone )
{
    self endon( "death" );
    self endon( "timeout" );
    level endon( "game_ended" );
    isunderwater = scripts\cp_mp\utility\player_utility::isswimmingunderwater();
    
    if ( isunderwater == 1 )
    {
        breacher_drone setscriptablepartstate( "exit", "on", 0 );
        return;
    }
    
    gunangle = self getgunangles();
    launchdirection = anglestoforward( gunangle );
    breacher_drone setotherent( self );
    breacher_drone setscriptablepartstate( "breacher_setup", "on", 0 );
    breacher_drone function_63d1a11f8b22244( undefined, &function_7bee8dd6e886169c, undefined );
    breacher_drone scripts\cp_mp\equipment\haywire::function_172d848d58051fdf( &function_42393d355d1090ff );
    drone_velocity = breacher_drone.bundle.var_beb9fe48183bc52b;
    launch_offset = getdvarfloat( @"hash_b3179bfb043e6579" );
    breacher_drone.origin += launchdirection * launch_offset;
    breacher_drone thread function_a608fdd8e2a06891();
    breacher_drone thread function_f6f652e978862b5a();
    breacher_drone thread function_d6d18aaab42129ad( launchdirection, drone_velocity, gunangle );
    breacher_drone thread function_cab343d49c8e389a();
    maxlifetime = getdvarfloat( @"hash_15f4bdd9a935599e" );
    breacher_drone thread function_47b5394a301d8c5( maxlifetime, @"hash_d4ac918df9a03e8" );
    maxhealth = getdvarfloat( @"hash_948191727e1e0a48" );
    damagefeedback = "hitequip";
    
    if ( issharedfuncdefined( "damage", "monitorDamage" ) )
    {
        breacher_drone thread [[ getsharedfunc( "damage", "monitorDamage" ) ]]( maxhealth, damagefeedback, &function_66a7440055d386c3, &function_7bdb3610d602438d, 0 );
    }
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 0
// Checksum 0x0, Offset: 0x525
// Size: 0xb9
function function_cab343d49c8e389a()
{
    trigger_height = getdvarint( @"hash_e84ef551e525beef" );
    trigger_radius = getdvarint( @"hash_4eb410aa813c8a92" );
    self.playertrigger = spawn( "trigger_radius", self.origin, 0, trigger_radius, trigger_height );
    self.playertrigger.angles = self.angles;
    self.playertrigger.origin = self.origin - ( 0, 0, trigger_height );
    self.playertrigger enablelinkto();
    self.playertrigger linkto( self );
    thread function_f3b97e69ad4c367d();
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 0
// Checksum 0x0, Offset: 0x5e6
// Size: 0x178
function function_f3b97e69ad4c367d()
{
    self endon( "death" );
    self endon( "disconnected" );
    wait getdvarfloat( @"hash_590aa3dcb5b178b3" );
    
    while ( true )
    {
        self.playertrigger waittill( "trigger", var_f4fc390187305987 );
        assert( isdefined( var_f4fc390187305987 ) );
        
        if ( istrue( self.isarmed ) )
        {
            if ( isarray( var_f4fc390187305987 ) )
            {
                foreach ( ent in var_f4fc390187305987 )
                {
                    if ( isagent( ent ) || isplayer( ent ) || isai( ent ) )
                    {
                        if ( !isalive( ent ) )
                        {
                            continue;
                        }
                        
                        if ( isdefined( ent.team ) )
                        {
                            if ( ent.team == self.owner.team )
                            {
                                continue;
                            }
                        }
                        
                        callback::callback( "on_functional_death" );
                    }
                }
            }
            else if ( ( isagent( var_f4fc390187305987 ) || isplayer( var_f4fc390187305987 ) || isai( var_f4fc390187305987 ) ) && isalive( var_f4fc390187305987 ) )
            {
                if ( isdefined( var_f4fc390187305987.team ) )
                {
                    if ( var_f4fc390187305987.team == self.owner.team )
                    {
                        continue;
                    }
                }
                
                callback::callback( "on_functional_death" );
            }
        }
        
        waitframe();
    }
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 0
// Checksum 0x0, Offset: 0x766
// Size: 0x117
function function_a608fdd8e2a06891()
{
    self endon( "death" );
    self endon( "disconnected" );
    endangles = self.angles;
    xtilt = getdvarint( @"hash_30eb2c84bb64de0f" );
    startangle = ( xtilt, self.angles[ 1 ], self.angles[ 2 ] );
    self.angles = anglelerpquat( self.angles, startangle, 1 );
    lerpfraction = 0;
    elapsedtime = 0;
    starttime = gettime();
    lerpduration = getdvarfloat( @"hash_178470c11f7062cd" ) * 1000;
    
    while ( true )
    {
        timepassed = gettime() - starttime;
        lerpfraction = timepassed / lerpduration;
        
        if ( lerpfraction < 1 )
        {
            self.angles = math::lerp( startangle, endangles, lerpfraction );
        }
        else
        {
            wait 0.2;
            function_3fb4e2d77e555bc6();
        }
        
        waitframe();
    }
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 0
// Checksum 0x0, Offset: 0x885
// Size: 0x107
function function_3fb4e2d77e555bc6()
{
    self endon( "death" );
    self endon( "disconnected" );
    startangle = self.angles;
    var_ec6f6aae65f97e57 = getdvarint( @"hash_c829ecd8ebe56106" );
    endangles = ( var_ec6f6aae65f97e57, self.angles[ 1 ], self.angles[ 2 ] );
    self.angles = anglelerpquat( self.angles, endangles, 1 );
    lerpfraction = 0;
    elapsedtime = 0;
    starttime = gettime();
    lerpduration = getdvarfloat( @"hash_178470c11f7062cd" ) * 1000;
    
    while ( true )
    {
        timepassed = gettime() - starttime;
        lerpfraction = timepassed / lerpduration;
        
        if ( lerpfraction < 1 )
        {
            self.angles = math::lerp( startangle, endangles, lerpfraction );
        }
        
        waitframe();
    }
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 3
// Checksum 0x0, Offset: 0x994
// Size: 0x208
function function_d6d18aaab42129ad( direction, velocity, gunangle )
{
    self endon( "death" );
    self endon( "timeout" );
    level endon( "game_ended" );
    self.owner endon( "disconnect" );
    raycaststart = self.origin;
    raycastdistance = getdvarint( @"hash_880bc9cb96e0d47a" );
    raycastend = raycaststart + direction * raycastdistance;
    droneangle = gunangle;
    vectordistance = 1500;
    startpos = self.origin;
    previouspos = self.origin;
    targetpos = raycaststart + direction * vectordistance;
    starttime = gettime();
    var_134d0390a5b98256 = getdvarint( @"hash_3e0b76e7c8bbae22" );
    lerpduration = getdvarfloat( @"hash_178470c11f7062cd" ) * 1000;
    collisioncontents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_glass", "physicscontents_vehicle" ] );
    
    while ( true )
    {
        timepassed = gettime() - starttime;
        lerpfraction = timepassed / lerpduration;
        hitents = physics_raycast( previouspos, raycastend, collisioncontents, self, 0, "physicsquery_all" );
        
        if ( hitents.size >= 1 )
        {
            params = spawnstruct();
            params.hitents = hitents;
            callback::callback( "on_functional_death", params );
            break;
        }
        
        newpos = math::lerp( startpos, targetpos, lerpfraction );
        previouspos = self.origin;
        self.origin = newpos;
        raycastend = self.origin + direction * raycastdistance;
        waitframe();
    }
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 0
// Checksum 0x0, Offset: 0xba4
// Size: 0x63
function function_f6f652e978862b5a()
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    
    while ( true )
    {
        if ( isdefined( self ) )
        {
            if ( distance2d( self.origin, self.owner.origin ) > 200 )
            {
                if ( isdefined( self ) )
                {
                    self.isarmed = 1;
                }
            }
        }
        else
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 1
// Checksum 0x0, Offset: 0xc0f
// Size: 0xa8
function function_7bee8dd6e886169c( params )
{
    forward = anglestoup( self.angles );
    right = -1 * anglestoright( self.angles );
    up = anglestoforward( self.angles );
    
    if ( istrue( self.owner.ksempd ) || self.owner scripts\cp_mp\emp_debuff::is_empd() )
    {
        self setscriptablepartstate( "explode", "on_noDamage", 0 );
        return;
    }
    
    function_859275f92a03628c( self.owner );
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 1
// Checksum 0x0, Offset: 0xcbf
// Size: 0x1d
function function_859275f92a03628c( attacker )
{
    self setscriptablepartstate( "explode", "on", 0 );
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 1
// Checksum 0x0, Offset: 0xce4
// Size: 0x2a
function function_42393d355d1090ff( data )
{
    self setscriptablepartstate( "explode", "on_noDamage", 0 );
    wait 0.05;
    self delete();
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 0
// Checksum 0x0, Offset: 0xd16
// Size: 0x87
function function_c367714fa20f379()
{
    self endon( "death" );
    self endon( "disconnected" );
    droneangle = self.owner getgunangles();
    direction = anglestoforward( droneangle );
    
    while ( true )
    {
        hitents = function_8729672225464641( direction );
        
        if ( hitents.size >= 1 )
        {
            params = spawnstruct();
            params.hitents = hitents;
            callback::callback( "on_functional_death", params );
        }
        
        waitframe();
    }
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 1
// Checksum 0x0, Offset: 0xda5
// Size: 0x15f
function function_8729672225464641( dirvector )
{
    var_68e6f05a4ee24dee = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_characterproxy" ] );
    vectordistance = getdvarint( @"hash_880bc9cb96e0d47a" );
    raycaststart = self.origin;
    raycastend = raycaststart + dirvector * vectordistance;
    var_97db5d48f2509e02 = physics_raycast( raycaststart, raycastend, var_68e6f05a4ee24dee, undefined, 0, "physicsquery_all" );
    
    /#
        debugactive = getdvarint( @"hash_d4ac918df9a03e8" );
        
        if ( debugactive > 0 )
        {
            duration = 500;
            line( raycaststart, raycastend, ( 0, 0, 100 ), 1, 0, duration );
            drawcolor = ( 0, 255, 0 );
            
            foreach ( result in var_97db5d48f2509e02 )
            {
                sphere( result[ "<dev string:x1c>" ], 5, drawcolor, 0, duration );
            }
        }
    #/
    
    return var_97db5d48f2509e02;
}

// Namespace breacher_drone / scripts\cp_mp\equipment\breacher_drone
// Params 0
// Checksum 0x0, Offset: 0xf0d
// Size: 0x211
function function_ca0071a0a7dc0d4f()
{
    self endon( "death" );
    self endon( "timeout" );
    level endon( "game_ended" );
    self.owner endon( "disconnect" );
    drone_velocity = getdvarfloat( @"hash_3e0b76e7c8bbae22" );
    lerpdelay = getdvarfloat( @"hash_d0988687e6689cf8" ) * 1000;
    lerpduration = getdvarfloat( @"hash_178470c11f7062cd" ) * 1000;
    var_d5aa91d70ba9a397 = getdvarint( @"hash_984112ed98131c1f" );
    launch_offset = getdvarfloat( @"hash_b3179bfb043e6579" );
    drone_lifetime = getdvarint( @"hash_15f4bdd9a935599e" );
    gunangle = self.owner getgunangles();
    launchdirection = anglestoforward( gunangle );
    stepvector = launchdirection * drone_velocity;
    lerpfraction = 0;
    elapsedtime = 0;
    starttime = gettime();
    target_height = self.origin[ 2 ];
    lerpstartheight = undefined;
    self.origin += launchdirection * launch_offset;
    
    while ( true )
    {
        if ( var_d5aa91d70ba9a397 == 1 )
        {
            timepassed = gettime() - starttime;
            lerpfraction = timepassed / lerpduration;
            
            if ( timepassed > lerpdelay )
            {
                if ( !isdefined( lerpstartheight ) )
                {
                    lerpstartheight = self.origin[ 2 ];
                    newdirection = ( launchdirection[ 0 ], launchdirection[ 1 ], 0 );
                    newdirection = vectornormalize( newdirection );
                    stepvector = drone_velocity * newdirection;
                }
                
                if ( lerpfraction < 1 )
                {
                    lerp_height = math::lerp( lerpstartheight, target_height, lerpfraction );
                    self.origin = ( self.origin[ 0 ], self.origin[ 1 ], lerp_height );
                }
            }
        }
        
        waitframe();
    }
}

