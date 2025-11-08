#using scripts\engine\utility;

#namespace basic_wind;

// Namespace basic_wind / scripts\common\basic_wind
// Params 2
// Checksum 0x0, Offset: 0x7f0
// Size: 0xf0
function load_wind( direction, intensity )
{
    var_3c853a3642aa7b74 = [ "n", "ne", "e", "se", "s", "sw", "w", "nw" ];
    intensityarray = [ "weak", "medium", "strong" ];
    rootpath = "vfx/iw8/wind/basic_directions/vfx_basic_wind_";
    fxid = var_3c853a3642aa7b74[ get_wind_index( direction ) ] + "_" + intensityarray[ intensity ][ 0 ];
    fullpath = rootpath + direction + "_" + intensityarray[ intensity ] + ".vfx";
    level.g_effect[ fxid ] = loadfx( fullpath );
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 0
// Checksum 0x0, Offset: 0x8e8
// Size: 0x1c
function load_debug_particles()
{
    level.g_effect[ "wind_debug" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_debug.vfx" );
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 0
// Checksum 0x0, Offset: 0x90c
// Size: 0x28c
function load_all_wind()
{
    level.g_effect[ "wind_debug" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_debug.vfx" );
    level.g_effect[ "n_w" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_north_weak.vfx" );
    level.g_effect[ "n_m" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_north_medium.vfx" );
    level.g_effect[ "n_s" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_north_strong.vfx" );
    level.g_effect[ "ne_w" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_northeast_weak.vfx" );
    level.g_effect[ "ne_m" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_northeast_medium.vfx" );
    level.g_effect[ "ne_s" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_northeast_strong.vfx" );
    level.g_effect[ "e_w" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_east_weak.vfx" );
    level.g_effect[ "e_m" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_east_medium.vfx" );
    level.g_effect[ "e_s" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_east_strong.vfx" );
    level.g_effect[ "se_w" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_southeast_weak.vfx" );
    level.g_effect[ "se_m" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_southeast_medium.vfx" );
    level.g_effect[ "se_s" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_southeast_strong.vfx" );
    level.g_effect[ "s_w" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_south_weak.vfx" );
    level.g_effect[ "s_m" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_south_medium.vfx" );
    level.g_effect[ "s_s" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_south_strong.vfx" );
    level.g_effect[ "sw_w" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_southwest_weak.vfx" );
    level.g_effect[ "sw_m" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_southwest_medium.vfx" );
    level.g_effect[ "sw_s" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_southwest_strong.vfx" );
    level.g_effect[ "w_w" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_west_weak.vfx" );
    level.g_effect[ "w_m" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_west_medium.vfx" );
    level.g_effect[ "w_s" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_west_strong.vfx" );
    level.g_effect[ "nw_w" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_northwest_weak.vfx" );
    level.g_effect[ "nw_m" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_northwest_medium.vfx" );
    level.g_effect[ "nw_s" ] = loadfx( "vfx/iw8/wind/basic_directions/vfx_basic_wind_northwest_strong.vfx" );
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 3
// Checksum 0x0, Offset: 0xba0
// Size: 0xe5
function init_wind( direction, strength, permanent )
{
    dirvalue = get_wind_index( direction );
    windstring = wind_index( dirvalue, strength );
    fxid = level.g_effect[ windstring ];
    
    if ( permanent == 1 )
    {
        fxobj = spawnfx( fxid, ( 0, 0, 0 ) );
        triggerfx( fxobj );
        return undefined;
    }
    
    fxtag = spawn_tag_origin();
    playfxontag( fxid, fxtag, "tag_origin" );
    windobj = spawnstruct();
    windobj.id = fxid;
    windobj.fxtag = fxtag;
    windobj.tagorigin = "tag_origin";
    return windobj;
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 4
// Checksum 0x0, Offset: 0xc8d
// Size: 0xf0
function init_wind_at_point( direction, strength, location, permanent )
{
    dirvalue = get_wind_index( direction );
    windstring = wind_index( dirvalue, strength );
    fxid = level.g_effect[ windstring ];
    
    if ( permanent == 1 )
    {
        fxobj = spawnfx( fxid, location );
        triggerfx( fxobj );
        return undefined;
    }
    
    fxtag = spawn_tag_origin();
    fxtag.point = location;
    playfxontag( fxid, fxtag, "tag_origin" );
    windobj = spawnstruct();
    windobj.id = fxid;
    windobj.fxtag = fxtag;
    windobj.tagorigin = "tag_origin";
    return windobj;
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 5
// Checksum 0x0, Offset: 0xd85
// Size: 0xa3
function function_7c798f6cb0754110( min_value, max_value, pause_time, ramp_time, start_paused )
{
    if ( !flag_exist( "pause_ambient_wind_change" ) )
    {
        flag_init( "pause_ambient_wind_change" );
    }
    
    if ( istrue( start_paused ) )
    {
        flag_set( "pause_ambient_wind_change" );
    }
    
    min_value = default_to( min_value, 0.5 );
    max_value = default_to( max_value, 7 );
    pause = default_to( pause_time, 10 );
    ramp_time = default_to( ramp_time, 25 );
    thread function_3bf9ed80166e5b45( @"hash_402173c7dbee15d9", min_value, max_value, pause, ramp_time );
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 5
// Checksum 0x0, Offset: 0xe30
// Size: 0x8a
function function_3bf9ed80166e5b45( dvar, min_value, max_value, pause_time, ramp_time )
{
    level notify( "stop_ambient_wind_change" );
    level endon( "stop_ambient_wind_change" );
    
    while ( true )
    {
        flag_waitopen( "pause_ambient_wind_change" );
        new_value = max_value;
        should_wait = 1;
        
        if ( getdvarfloat( dvar ) > min_value )
        {
            new_value = min_value;
            should_wait = 0;
        }
        
        function_a334760f5ed07966( dvar, new_value, ramp_time );
        
        if ( should_wait )
        {
            wait pause_time;
        }
    }
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 3
// Checksum 0x0, Offset: 0xec2
// Size: 0xb6
function function_a334760f5ed07966( name, value, time )
{
    curr = getdvarfloat( name );
    level notify( getxhashhexname( name ) + "_lerp_savedDvar" );
    level endon( getxhashhexname( name ) + "_lerp_savedDvar" );
    range = value - curr;
    interval = 0.05;
    count = int( time / interval );
    
    if ( count > 0 )
    {
        delta = range / count;
        
        while ( count )
        {
            curr += delta;
            setsaveddvar( name, curr );
            wait interval;
            count--;
        }
    }
    
    setsaveddvar( name, value );
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 1
// Checksum 0x0, Offset: 0xf80
// Size: 0x48
function stop_wind( windobj )
{
    if ( isdefined( windobj ) )
    {
        stopfxontag( windobj.id, windobj.fxtag, windobj.tagorigin );
        return;
    }
    
    println( "<dev string:x1c>" );
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 1
// Checksum 0x0, Offset: 0xfd0
// Size: 0x1b
function set_wind_amplitude( amplitude )
{
    setsaveddvar( @"hash_402173c7dbee15d9", amplitude );
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 1
// Checksum 0x0, Offset: 0xff3
// Size: 0x1b
function set_wind_frequency( frequency )
{
    setsaveddvar( @"hash_71fe8b216d50a24c", frequency );
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 1
// Checksum 0x0, Offset: 0x1016
// Size: 0x1b
function set_wind_area_scale( areascale )
{
    setsaveddvar( @"hash_656131a98e0d2c9d", areascale );
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 1
// Checksum 0x0, Offset: 0x1039
// Size: 0x45
function spawn_debug_particles( location )
{
    fxid = level.g_effect[ "wind_debug" ];
    fxent = spawn_tag_origin( location );
    playfxontag( fxid, fxent, "tag_origin" );
    return fxent;
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 1
// Checksum 0x0, Offset: 0x1087
// Size: 0xaa
function get_wind_index( windstring )
{
    switch ( windstring )
    {
        case #"hash_b9ff0a9f617355e4":
            return 0;
        case #"hash_493bfd7122639b31":
            return 1;
        case #"hash_22ce3b03c1e51a9c":
            return 2;
        case #"hash_8856b747c93e7793":
            return 3;
        case #"hash_fbd39e4f5634905a":
            return 4;
        case #"hash_abed5ad834825ff1":
            return 5;
        case #"hash_a1e9b77432f55b0e":
            return 6;
        case #"hash_b66b59dcd06dfad3":
            return 7;
        default:
            /#
                iprintlnbold( "<dev string:x4d>" + windstring );
            #/
            
            return -1;
    }
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 1
// Checksum 0x0, Offset: 0x1139
// Size: 0x62
function get_wind_string( windindex )
{
    windarray = [ "north", "northeast", "east", "southeast", "south", "southwest", "west", "northwest" ];
    return windarray[ windindex ];
}

// Namespace basic_wind / scripts\common\basic_wind
// Params 2
// Checksum 0x0, Offset: 0x11a4
// Size: 0x12b
function wind_index( direction, strength )
{
    windlist = [];
    windlist[ 0 ] = [ "n_w", "n_m", "n_s" ];
    windlist[ 1 ] = [ "ne_w", "ne_m", "ne_s" ];
    windlist[ 2 ] = [ "e_w", "e_m", "e_s" ];
    windlist[ 3 ] = [ "se_w", "se_m", "se_s" ];
    windlist[ 4 ] = [ "s_w", "s_m", "s_s" ];
    windlist[ 5 ] = [ "sw_w", "sw_m", "sw_s" ];
    windlist[ 6 ] = [ "w_w", "w_m", "w_s" ];
    windlist[ 7 ] = [ "nw_w", "nw_m", "nw_s" ];
    return windlist[ direction ][ strength ];
}

