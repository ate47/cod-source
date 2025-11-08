#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace namespace_818db91055f1f65e;

// Namespace namespace_818db91055f1f65e / namespace_1e316f64ce872d7a
// Params 0
// Checksum 0x0, Offset: 0x22c
// Size: 0x25
function main()
{
    thread function_c0331162f149609c( 10 );
    function_ead09275bb875c19();
    thread bink_display_lights();
    function_569aec3f2378f201();
}

// Namespace namespace_818db91055f1f65e / namespace_1e316f64ce872d7a
// Params 3
// Checksum 0x0, Offset: 0x259
// Size: 0xfe
function function_b7281bfb9645666( h, s, v )
{
    if ( s == 0 )
    {
        return ( v, v, v );
    }
    
    h = mod( h, 360 );
    hue_sector = floor( h / 60 );
    var_8367d2ae5b6edba2 = h / 60 - hue_sector;
    p = v * ( 1 - s );
    q = v * ( 1 - s * var_8367d2ae5b6edba2 );
    t = v * ( 1 - s * ( 1 - var_8367d2ae5b6edba2 ) );
    
    if ( hue_sector == 0 )
    {
        return ( v, t, p );
    }
    else if ( hue_sector == 1 )
    {
        return ( q, v, p );
    }
    else if ( hue_sector == 2 )
    {
        return ( p, v, t );
    }
    else if ( hue_sector == 3 )
    {
        return ( p, q, v );
    }
    else if ( hue_sector == 4 )
    {
        return ( t, p, v );
    }
    else if ( hue_sector == 5 )
    {
        return ( v, p, q );
    }
    
    return ( v, p, q );
}

// Namespace namespace_818db91055f1f65e / namespace_1e316f64ce872d7a
// Params 1
// Checksum 0x0, Offset: 0x360
// Size: 0xbf
function function_c0331162f149609c( duration )
{
    level endon( "game_ended" );
    
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        return;
    }
    
    lights = getentarray( "ferris_wheel_rgb_light", "targetname" );
    
    if ( !isdefined( lights ) || lights.size == 0 )
    {
        return;
    }
    
    while ( true )
    {
        foreach ( light in lights )
        {
            light thread lerp_rgb_wheel( duration, float( light.script_noteworthy ), 0.75 );
        }
        
        wait duration;
    }
}

// Namespace namespace_818db91055f1f65e / namespace_1e316f64ce872d7a
// Params 0
// Checksum 0x0, Offset: 0x427
// Size: 0x8a
function function_ead09275bb875c19()
{
    level.bink_display_lights = getentarray( "gp_bink_light", "targetname" );
    
    foreach ( light in level.bink_display_lights )
    {
        light.og_color = light getlightcolor();
        light.og_intensity = light getlightintensity();
    }
}

// Namespace namespace_818db91055f1f65e / namespace_1e316f64ce872d7a
// Params 0
// Checksum 0x0, Offset: 0x4b9
// Size: 0xd7
function bink_display_lights()
{
    self notify( "bink_display_lights" );
    self endon( "bink_display_lights" );
    level endon( "game_ended" );
    
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        return;
    }
    
    if ( !isdefined( level.bink_display_lights ) || level.bink_display_lights.size == 0 )
    {
        return;
    }
    
    while ( true )
    {
        foreach ( light in level.bink_display_lights )
        {
            light childthread function_9070eca46954f112( ( 0.917, 0.976, 0.643 ), ( 0.776, 1, 0.588 ), 30, 5, 1, 1.5 );
        }
        
        wait 30;
    }
}

// Namespace namespace_818db91055f1f65e / namespace_1e316f64ce872d7a
// Params 0
// Checksum 0x0, Offset: 0x598
// Size: 0x27f
function bink_display_lights_single_shot()
{
    self notify( "bink_display_lights_single_shot" );
    self endon( "bink_display_lights_single_shot" );
    level endon( "game_ended" );
    
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        return;
    }
    
    if ( !isdefined( level.bink_display_lights ) || level.bink_display_lights.size == 0 )
    {
        return;
    }
    
    foreach ( light in level.bink_display_lights )
    {
        light setlightcolor( ( 0.819, 0.862, 1 ) );
    }
    
    wait 0.5;
    
    foreach ( light in level.bink_display_lights )
    {
        light childthread lerp_light_color_from_to( ( 0.819, 0.862, 1 ), ( 0.776, 1, 0.588 ), 0.15 );
    }
    
    wait 0.15;
    
    foreach ( light in level.bink_display_lights )
    {
        light childthread function_9070eca46954f112( ( 0.823, 0.98, 0.56 ), ( 0.776, 1, 0.588 ), 14.15, 2, 1, 0.9 );
    }
    
    wait 14.15;
    
    foreach ( light in level.bink_display_lights )
    {
        light childthread lerp_light_color_to( ( 0.301, 0.454, 0.972 ), 0.5 );
    }
    
    wait 0.5;
    
    foreach ( light in level.bink_display_lights )
    {
        light childthread function_9070eca46954f112( ( 0.576, 0.062, 0.956 ), ( 0.301, 0.454, 0.972 ), 50, 10, 1, 0.8 );
    }
    
    wait 20;
}

// Namespace namespace_818db91055f1f65e / namespace_1e316f64ce872d7a
// Params 6
// Checksum 0x0, Offset: 0x81f
// Size: 0xf8
function function_9070eca46954f112( col1, col2, duration, speed, changeintensity, var_b153a77942d79d3b )
{
    self notify( "color_pulse" );
    self endon( "color_pulse" );
    
    if ( !isdefined( changeintensity ) )
    {
        changeintensity = 0;
    }
    
    steps = floor( duration * 20 );
    
    for ( i = 0; i < steps ; i++ )
    {
        t1 = pulse_function( i * speed );
        blend_col = vectorlerp( col1, col2, t1 );
        self setlightcolor( blend_col );
        
        if ( changeintensity )
        {
            t2 = pulse_function( ( i + 50 ) * speed );
            blend_intensity = math::lerp( self.og_intensity * var_b153a77942d79d3b, self.og_intensity, t2 );
            self setlightintensity( blend_intensity );
        }
        
        wait 0.05;
    }
}

// Namespace namespace_818db91055f1f65e / namespace_1e316f64ce872d7a
// Params 2
// Checksum 0x0, Offset: 0x91f
// Size: 0x9b
function lerp_light_color_to( col, duration )
{
    self notify( "lerp_light_color_to" );
    self endon( "lerp_light_color_to" );
    curr_col = self getlightcolor();
    steps = floor( duration * 20 );
    
    for ( i = 0; i < steps ; i++ )
    {
        t = float( ( i + 1 ) / steps );
        t = t * t * t;
        blend_col = vectorlerp( curr_col, col, t );
        self setlightcolor( blend_col );
        wait 0.05;
    }
}

// Namespace namespace_818db91055f1f65e / namespace_1e316f64ce872d7a
// Params 3
// Checksum 0x0, Offset: 0x9c2
// Size: 0x95
function lerp_light_color_from_to( from_col, to_col, duration )
{
    self notify( "lerp_light_color_from_to" );
    self endon( "lerp_light_color_ftom_to" );
    self setlightcolor( from_col );
    steps = floor( duration * 20 );
    
    for ( i = 0; i < steps ; i++ )
    {
        t = float( ( i + 1 ) / steps );
        blend_col = vectorlerp( from_col, to_col, t );
        self setlightcolor( blend_col );
        wait 0.05;
    }
}

// Namespace namespace_818db91055f1f65e / namespace_1e316f64ce872d7a
// Params 1
// Checksum 0x0, Offset: 0xa5f
// Size: 0x4c
function pulse_function( x )
{
    y = sin( 2 * x ) + sin( 3.14159 * x );
    return clamp( ( y + 2 ) / 4, 0, 1 );
}

// Namespace namespace_818db91055f1f65e / namespace_1e316f64ce872d7a
// Params 3
// Checksum 0x0, Offset: 0xab4
// Size: 0xd0
function lerp_rgb_wheel( duration, var_7c6637a253602501, SATURATION )
{
    self notify( "lerp_rgb_wheel" );
    self endon( "lerp_rgb_wheel" );
    
    if ( !isdefined( var_7c6637a253602501 ) )
    {
        var_7c6637a253602501 = 0;
    }
    
    if ( !isdefined( SATURATION ) )
    {
        SATURATION = 1;
    }
    
    self setlightcolor( function_b7281bfb9645666( var_7c6637a253602501, SATURATION, 1 ) );
    steps = floor( duration * 20 );
    
    for ( i = 0; i < steps ; i++ )
    {
        t = float( i / steps );
        self setlightcolor( function_b7281bfb9645666( 360 * t + var_7c6637a253602501, SATURATION, 1 ) );
        wait 0.05;
    }
    
    self setlightcolor( function_b7281bfb9645666( 360 + var_7c6637a253602501, SATURATION, 1 ) );
}

// Namespace namespace_818db91055f1f65e / namespace_1e316f64ce872d7a
// Params 0
// Checksum 0x0, Offset: 0xb8c
// Size: 0x14f
function function_569aec3f2378f201()
{
    fire_light_01 = getent( "crashed_car_fire_light_01", "targetname" );
    fire_light_02 = getent( "crashed_car_fire_light_02", "targetname" );
    fire_light_03 = getent( "crashed_car_fire_light_03", "targetname" );
    fire_light_04 = getent( "crashed_car_fire_light_04", "targetname" );
    var_29f9d33e2ff44dff = [ fire_light_01, fire_light_02, fire_light_03, fire_light_04 ];
    
    foreach ( light in var_29f9d33e2ff44dff )
    {
        if ( !isdefined( light ) )
        {
            return;
        }
    }
    
    fire_light_01 thread grandprix_fire_flicker( 0.4, 1, 55, 0.3, 0.8 );
    fire_light_02 thread grandprix_fire_flicker( 0.4, 1, 35, 0.3, 0.8 );
    fire_light_03 thread grandprix_fire_flicker( 0.4, 1, 35, 0.3, 0.8 );
    fire_light_04 thread grandprix_fire_flicker( 0.4, 1, 25, 0.3, 0.8 );
}

// Namespace namespace_818db91055f1f65e / namespace_1e316f64ce872d7a
// Params 5
// Checksum 0x0, Offset: 0xce3
// Size: 0xe2
function grandprix_fire_flicker( lower, higher, full, min_time, max_time )
{
    self notify( "grandprix_fire_flicker" );
    self endon( "grandprix_fire_flicker" );
    level endon( "game_ended" );
    
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        self setlightintensity( 0 );
        return;
    }
    
    for ( old_intensity = full;  ; old_intensity = intensity )
    {
        intensity = randomfloatrange( full * lower, full * higher );
        timer = randomfloatrange( min_time, max_time );
        timer *= 20;
        
        for ( i = 0; i < timer ; i++ )
        {
            new_intensity = intensity * i / timer + old_intensity * ( timer - i ) / timer;
            self setlightintensity( new_intensity );
            wait 0.05;
        }
    }
}

