#using scripts\common\callbacks;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\outofbounds;

#namespace namespace_d30c3332ecd51815;

// Namespace namespace_d30c3332ecd51815 / namespace_2a9cffd769289a8
// Params 0
// Checksum 0x0, Offset: 0x23b
// Size: 0xb
function main()
{
    level thread function_738844ba18b42814();
}

// Namespace namespace_d30c3332ecd51815 / namespace_2a9cffd769289a8
// Params 0
// Checksum 0x0, Offset: 0x24e
// Size: 0x8d
function function_738844ba18b42814()
{
    flag_wait( "create_script_initialized" );
    var_16a2a41f25edbf03 = array_randomize( getstructarray( "limbo_mode_kill_ball_spawn_loc", "targetname" ) );
    limit = getdvarint( @"hash_1b6d772442c811a7", var_16a2a41f25edbf03.size );
    
    for ( i = 0; i < limit ; i++ )
    {
        level thread function_273a2924623954df( var_16a2a41f25edbf03[ i ].origin );
    }
    
    registersharedfunc( "limbo", "isDeathBall", &isdeathball );
}

// Namespace namespace_d30c3332ecd51815 / namespace_2a9cffd769289a8
// Params 2
// Checksum 0x0, Offset: 0x2e3
// Size: 0x1a9
function function_273a2924623954df( spawnlocation, var_3fae9930f2b96d69 )
{
    ball = spawn( "script_model", spawnlocation );
    ball setmodel( "art_stadium_ball_limbo" );
    ball physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 0 ), 100 );
    ball.var_3fae9930f2b96d69 = var_3fae9930f2b96d69;
    ball physics_registerforcollisioncallback();
    killcament = spawn( "script_model", ball.origin + ( 0, 0, 300 ) );
    killcament setscriptmoverkillcam( "explosive" );
    killcament linkto( ball );
    ball.killcament = killcament;
    ball.trigger = spawn( "trigger_radius", ball.origin, 0, 50, 50 );
    ball.trigger enablelinkto();
    ball.trigger linkto( ball );
    ball thread function_26a3f9262c0e61c1();
    ball thread function_36e242799d3de02e();
    level thread function_eae183e660ed1bd( ball );
    ball.health = 99999;
    ball.maxhealth = 99999;
    ball.currenthealth = 99999;
    ball.spawnloc = spawnlocation;
    ball setcandamage( 1 );
    ball thread function_b5cc3a104beea7f5();
    ball thread function_83b8161c371893ff();
    
    if ( !isdefined( level.var_c8936f922b7d32a1 ) )
    {
        level.var_c8936f922b7d32a1 = [];
    }
    
    level.var_c8936f922b7d32a1[ level.var_c8936f922b7d32a1.size ] = ball;
    return ball;
}

// Namespace namespace_d30c3332ecd51815 / namespace_2a9cffd769289a8
// Params 1
// Checksum 0x0, Offset: 0x495
// Size: 0x61, Type: bool
function isdeathball( ent )
{
    foreach ( ball in level.var_c8936f922b7d32a1 )
    {
        if ( ent == ball )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_d30c3332ecd51815 / namespace_2a9cffd769289a8
// Params 0
// Checksum 0x0, Offset: 0x4ff
// Size: 0x9f
function function_b5cc3a104beea7f5()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon );
        self.health = 99999;
        self.var_37c1904b89e6c18c = attacker;
    }
}

// Namespace namespace_d30c3332ecd51815 / namespace_2a9cffd769289a8
// Params 0
// Checksum 0x0, Offset: 0x5a6
// Size: 0x83
function function_36e242799d3de02e()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        self.trigger waittill( "trigger", ent );
        toball = self.origin - ent.origin;
        normal = vectornormalize( toball );
        pushball( ent, self, normal, 1, self.origin );
        self.var_37c1904b89e6c18c = ent;
        waitframe();
    }
}

// Namespace namespace_d30c3332ecd51815 / namespace_2a9cffd769289a8
// Params 5
// Checksum 0x0, Offset: 0x631
// Size: 0x444
function pushball( ent, ball, normal, var_efce983b772a6f22, contactposition )
{
    if ( isdefined( ent.lastpushtime ) && gettime() < ent.lastpushtime + 200 )
    {
        return;
    }
    
    ent.lastpushtime = gettime();
    entvelocity = ent getentityvelocity();
    
    if ( isdefined( self.vehicletype ) )
    {
        entvelocity = ent vehicle_getvelocity();
    }
    
    ballvelocity = ball.velocity;
    velocitydifference = entvelocity - ballvelocity;
    var_c0696ed701533095 = math::remap( clamp( length( velocitydifference ), 0, 1000 ), 0, 1000, 0, 1 );
    var_eb3b42597661a6ea = math::remap( var_c0696ed701533095, 0, 1, 20, 60 );
    var_ad3dc842bed328b9 = var_eb3b42597661a6ea;
    
    if ( ball.velocity[ 2 ] > 40 )
    {
        var_ad3dc842bed328b9 /= 3;
    }
    
    ball physics_applyimpulse( ball.origin, ( 0, 0, var_ad3dc842bed328b9 ) );
    normal = vectornormalize( ( normal[ 0 ], normal[ 1 ], normal[ 2 ] * 0.8 ) );
    var_5a4ed8bed236876a = math::remap( var_c0696ed701533095, 0, 1, 100, 600 );
    var_9e8d543ba58e308 = normal * var_5a4ed8bed236876a;
    ball physics_applyimpulse( ball.origin, var_9e8d543ba58e308 * var_efce983b772a6f22 );
    function_508a666f8c32e510( ball, var_5a4ed8bed236876a, 1, 0 );
    x = self.velocity[ 0 ];
    y = self.velocity[ 1 ];
    z = self.velocity[ 2 ];
    var_1f162d8e57c321e4 = sqrt( x * x + y * y + z * z );
    threshold = getdvarint( @"hash_b15005db0137b479", 70 );
    var_d5f173d66aad44ef = vectortoangles( vectornormalize( flat_origin( ball.velocity ) ) );
    var_21d2ef6ef22b358a = vectortoangles( flat_origin( ball.origin - ent.origin ) );
    var_8e1b9267a25d421d = anglesdelta( var_d5f173d66aad44ef, var_21d2ef6ef22b358a ) > 90;
    
    if ( isplayer( ent ) && var_1f162d8e57c321e4 > threshold && var_8e1b9267a25d421d && !( isdefined( ball.var_3fae9930f2b96d69 ) && isdefined( ent.team ) && ball.var_3fae9930f2b96d69 == ent.team ) )
    {
        ballweapon = makeweapon( "deathball_limbo" );
        attacker = isdefined( ball.var_37c1904b89e6c18c ) ? ball.var_37c1904b89e6c18c : ball;
        ent earthquakeforplayer( 0.15, 0.3, ball.origin, 5000 );
        ent dodamage( ent.maxhealth + 500, ent.origin, attacker, ball, "MOD_EXPLOSIVE", ballweapon, "torso_upper" );
        return;
    }
    
    if ( isdefined( self.vehicletype ) )
    {
        foreach ( player in ent.occupants )
        {
            player earthquakeforplayer( 0.15, 0.3, ball.origin, 5000 );
        }
        
        return;
    }
    
    if ( isagent( ent ) )
    {
        ballweapon = makeweapon( "deathball_limbo" );
        attacker = isdefined( ball.var_37c1904b89e6c18c ) ? ball.var_37c1904b89e6c18c : ball;
        ent dodamage( ent.maxhealth + 500, ent.origin, attacker, ball, "MOD_EXPLOSIVE", ballweapon, "torso_upper" );
    }
}

// Namespace namespace_d30c3332ecd51815 / namespace_2a9cffd769289a8
// Params 1
// Checksum 0x0, Offset: 0xa7d
// Size: 0xa1
function function_eae183e660ed1bd( ball )
{
    level endon( "game_ended" );
    ball endon( "death" );
    
    while ( true )
    {
        if ( isdefined( ball ) && isdefined( ball.origin ) )
        {
            if ( !isdefined( ball.oldorigin ) )
            {
                ball.oldorigin = ball.origin;
            }
            
            ball.velocity = ( ball.origin - ball.oldorigin ) / level.framedurationseconds;
            ball.oldorigin = ball.origin;
        }
        
        waitframe();
    }
}

// Namespace namespace_d30c3332ecd51815 / namespace_2a9cffd769289a8
// Params 4
// Checksum 0x0, Offset: 0xb26
// Size: 0x12b
function function_508a666f8c32e510( ball, ballspeed, hitsurface, pulse )
{
    soundprefix = "phy_ball_limbo";
    surfacetype = "_default";
    soundintensity = "_light";
    soundalias = "phy_ball_limbo";
    lightspeed = 5;
    mediumspeed = 200;
    heavyspeed = 500;
    
    if ( hitsurface > 2 || hitsurface < 0 )
    {
        return;
    }
    
    switch ( hitsurface )
    {
        case 0:
            surfacetype = "_atv";
            
            if ( pulse )
            {
                surfacetype = "_atv_pulse";
            }
            
            break;
        case 1:
            surfacetype = "_player";
            break;
        case 2:
            surfacetype = "_geo";
            break;
    }
    
    if ( ballspeed >= heavyspeed )
    {
        soundintensity = "_heavy";
    }
    else if ( ballspeed >= mediumspeed )
    {
        soundintensity = "_medium";
    }
    
    soundalias = soundprefix + surfacetype + soundintensity;
    
    if ( isdefined( soundalias ) && isdefined( ball ) )
    {
        ball playsound( soundalias );
    }
}

// Namespace namespace_d30c3332ecd51815 / namespace_2a9cffd769289a8
// Params 0
// Checksum 0x0, Offset: 0xc59
// Size: 0x167
function function_26a3f9262c0e61c1()
{
    level endon( "game_ended" );
    var_63ab34b4a76e8f86 = 0.1;
    var_7856e907f2d37675 = 1;
    var_64f13c589a594107 = 3;
    var_38f5340b182b64f0 = 0;
    var_653bf22a4d053b24 = 5;
    var_4be5096ca36000af = 200;
    var_c59ce7533110caff = 500;
    hitsurfacetype = 1;
    grasssurfacetype = 1;
    wallsurfacetype = 2;
    self physics_registerforcollisioncallback();
    
    while ( true )
    {
        self waittill( "collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum );
        surface = physics_getsurfacetypefromflags( flag1 );
        surfacetype = getsubstr( surface[ "name" ], 9 );
        
        if ( normalspeed > var_63ab34b4a76e8f86 )
        {
            if ( normalspeed > var_64f13c589a594107 )
            {
                var_38f5340b182b64f0 = var_c59ce7533110caff;
            }
            else if ( normalspeed > var_7856e907f2d37675 )
            {
                var_38f5340b182b64f0 = var_4be5096ca36000af;
            }
            else
            {
                var_38f5340b182b64f0 = var_653bf22a4d053b24;
            }
            
            hitsurfacetype = wallsurfacetype;
            
            if ( surfacetype != "default" )
            {
                hitsurfacetype = wallsurfacetype;
            }
            
            function_508a666f8c32e510( self, var_38f5340b182b64f0, hitsurfacetype, 0 );
            waitframe();
        }
    }
}

// Namespace namespace_d30c3332ecd51815 / namespace_2a9cffd769289a8
// Params 0
// Checksum 0x0, Offset: 0xdc8
// Size: 0x14a
function function_83b8161c371893ff()
{
    if ( !getdvarint( @"hash_76cb5c397872dde2", 1 ) )
    {
        return;
    }
    
    level endon( "game_ended" );
    self endon( "death" );
    var_f4e356cf55b9a82e = 0;
    waittime = 5;
    
    while ( true )
    {
        wait waittime;
        isoob = scripts\mp\outofbounds::ispointinoutofbounds( self.origin );
        
        if ( isoob )
        {
            result = thread function_f4e356cf55b9a82e( self.spawnloc );
            
            if ( result )
            {
                return;
            }
        }
        
        dist = distancesquared( self.origin, self.spawnloc );
        distthreshold = getdvarint( @"hash_9b4c30312253ac55", 2500 );
        
        if ( dist < distthreshold * distthreshold )
        {
            waittime = 15;
            continue;
        }
        else if ( dist < distthreshold * 2 * distthreshold * 2 )
        {
            waittime = 10;
        }
        else
        {
            waittime = 5;
        }
        
        checkradius = getdvarint( @"hash_a46e62748bd6dba4", 2000 );
        playerlist = getplayersinradius( self.origin, checkradius, checkradius );
        
        if ( playerlist.size == 0 )
        {
            result = thread function_f4e356cf55b9a82e( self.spawnloc );
            
            if ( result )
            {
                return;
            }
        }
    }
}

// Namespace namespace_d30c3332ecd51815 / namespace_2a9cffd769289a8
// Params 1
// Checksum 0x0, Offset: 0xf1a
// Size: 0x6f, Type: bool
function function_f4e356cf55b9a82e( spawnloc )
{
    checkradius = getdvarint( @"hash_24b341731de17be1", 2000 );
    playerlist = getplayersinradius( spawnloc, checkradius, checkradius );
    
    if ( playerlist.size == 0 )
    {
        level.var_c8936f922b7d32a1 = array_remove( level.var_c8936f922b7d32a1, self );
        self delete();
        level thread function_273a2924623954df( spawnloc );
        return true;
    }
    
    return false;
}

