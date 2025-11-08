#using script_1d34b11a5f86a870;
#using scripts\engine\utility;

#namespace vfx_ambientwar;

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 0
// Checksum 0x0, Offset: 0xa4
// Size: 0x13
function main()
{
    function_605874f5b079939e();
    
    /#
        init_dvars();
    #/
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xbf
// Size: 0xae
function private function_605874f5b079939e()
{
    if ( !isdefined( level._fx ) )
    {
        level._fx = spawnstruct();
    }
    
    if ( !isdefined( level._fx.ambientwar ) )
    {
        level._fx.ambientwar = spawnstruct();
    }
    
    level._fx.ambientwar.groups = [];
    level._fx.ambientwar.filter = "";
    level._fx.ambientwar.cinematic_mode = 0;
}

/#

    // Namespace vfx_ambientwar / namespace_eefe753007203056
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x175
    // Size: 0x32, Type: dev
    function private init_dvars()
    {
        setdvarifuninitialized( @"hash_185e6b153cd4cd85", 0 );
        setdvarifuninitialized( @"hash_2ae987e5f164028", "<dev string:x1c>" );
        level thread function_77c43f774eb592b();
    }

#/

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 6
// Checksum 0x0, Offset: 0x1af
// Size: 0x26e
function create( group_id, aliases_arr, min_delay, max_delay, min_dist, max_dist )
{
    if ( isdefined( level._fx.ambientwar.groups[ group_id ] ) )
    {
        println( "<dev string:x1d>" + "<dev string:x32>" + group_id );
        return;
    }
    
    if ( !isdefined( group_id ) || group_id == "" )
    {
        println( "<dev string:x1d>" + "<dev string:x50>" );
        return;
    }
    
    if ( !isdefined( aliases_arr ) || !isarray( aliases_arr ) || aliases_arr.size < 1 )
    {
        println( "<dev string:x1d>" + "<dev string:x7c>" );
        return;
    }
    
    if ( !isdefined( min_delay ) )
    {
        min_delay = 0.5;
    }
    
    if ( !isdefined( max_delay ) )
    {
        max_delay = 1.5;
    }
    
    if ( !isdefined( min_dist ) )
    {
        min_dist = 100;
    }
    
    if ( !isdefined( max_dist ) )
    {
        max_dist = 1000;
    }
    
    struct = spawnstruct();
    struct.group_id = group_id;
    struct.grid = function_bd44643ea1a15d08( level._fx.ambientwar.nodes[ group_id ], max_dist );
    level._fx.ambientwar.nodes[ group_id ] = undefined;
    
    if ( !isdefined( struct.grid ) )
    {
        println( "<dev string:x1d>" + "<dev string:xc9>" + group_id );
        return;
    }
    
    struct.aliases = aliases_arr;
    struct.delay = spawnstruct();
    struct.delay.min = min_delay;
    struct.delay.max = max_delay;
    struct.dist = spawnstruct();
    struct.dist.min = min_dist;
    struct.dist.max = max_dist;
    struct.is_active = 0;
    struct.var_7e4ccd3a6bb57da0 = 1;
    struct.rumbles_enabled = 1;
    level._fx.ambientwar.groups[ group_id ] = struct;
    
    /#
        level notify( "<dev string:xf1>" );
    #/
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 1
// Checksum 0x0, Offset: 0x425
// Size: 0x6c
function start( group_id )
{
    if ( exists( group_id ) )
    {
        level._fx.ambientwar.groups[ group_id ].is_active = 1;
        level thread update( group_id );
        println( "<dev string:x1d>" + "<dev string:x104>" + group_id );
        
        /#
            level notify( "<dev string:xf1>" );
        #/
    }
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 1
// Checksum 0x0, Offset: 0x499
// Size: 0x6b
function stop( group_id )
{
    if ( exists( group_id ) )
    {
        level notify( "aws_stop_" + group_id );
        level._fx.ambientwar.groups[ group_id ].is_active = 0;
        println( "<dev string:x1d>" + "<dev string:x115>" + group_id );
        
        /#
            level notify( "<dev string:xf1>" );
        #/
    }
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 1
// Checksum 0x0, Offset: 0x50c
// Size: 0x9e
function remove( group_id )
{
    if ( exists( group_id ) )
    {
        stop( group_id );
        level._fx.ambientwar.groups[ group_id ] = undefined;
        level._fx.ambientwar.groups = remove_undefined( level._fx.ambientwar.groups );
        println( "<dev string:x1d>" + "<dev string:x126>" + group_id );
        
        /#
            level notify( "<dev string:xf1>" );
        #/
    }
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 1
// Checksum 0x0, Offset: 0x5b2
// Size: 0x5f
function toggle( group_id )
{
    if ( exists( group_id ) )
    {
        if ( level._fx.ambientwar.groups[ group_id ].is_active )
        {
            stop( group_id );
        }
        else
        {
            start( group_id );
        }
        
        /#
            level notify( "<dev string:xf1>" );
        #/
    }
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 0
// Checksum 0x0, Offset: 0x619
// Size: 0x71
function shutdown()
{
    foreach ( group in level._fx.ambientwar.groups )
    {
        remove( group.group_id );
    }
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 5
// Checksum 0x0, Offset: 0x692
// Size: 0xa2
function add_alias( fx_alias, shake_alias, rumble_alias, func_hit, func_leadin )
{
    struct = spawnstruct();
    struct.fx_alias = fx_alias;
    struct.shake_alias = shake_alias;
    struct.rumble_alias = rumble_alias;
    struct.func = spawnstruct();
    struct.func.hit = func_hit;
    struct.func.leadin = func_leadin;
    return struct;
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 2
// Checksum 0x0, Offset: 0x73d
// Size: 0x6d
function set_aliases( group_id, new_aliases )
{
    if ( !exists( group_id ) )
    {
        return;
    }
    
    if ( !isdefined( new_aliases ) || new_aliases.size < 1 )
    {
        println( "<dev string:x1d>" + "<dev string:x137>" );
        return;
    }
    
    level._fx.ambientwar.groups[ group_id ].aliases = new_aliases;
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 4
// Checksum 0x0, Offset: 0x7b2
// Size: 0x10e
function set_delay( group_id, var_90e4c321e57aafe6, var_9893026561ada098, time )
{
    if ( !exists( group_id ) )
    {
        return;
    }
    
    if ( var_90e4c321e57aafe6 < 0.05 )
    {
        var_90e4c321e57aafe6 = 0.05;
    }
    
    if ( var_9893026561ada098 < var_90e4c321e57aafe6 )
    {
        println( "<dev string:x1d>" + "<dev string:x15a>" + group_id );
        return;
    }
    
    if ( !is_active( group_id ) || !isdefined( time ) || time == 0 )
    {
        level._fx.ambientwar.groups[ group_id ].delay.min = var_90e4c321e57aafe6;
        level._fx.ambientwar.groups[ group_id ].delay.max = var_9893026561ada098;
        return;
    }
    
    if ( var_90e4c321e57aafe6 < 0.05 )
    {
        var_90e4c321e57aafe6 = 0.05;
    }
    
    if ( var_9893026561ada098 < 0.05 )
    {
        var_9893026561ada098 = 0.05;
    }
    
    level thread lerp_delays( group_id, var_90e4c321e57aafe6, var_9893026561ada098, time );
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 3
// Checksum 0x0, Offset: 0x8c8
// Size: 0xad
function set_distance( group_id, var_30e6164cdbb20da7, var_b51b726d07e7bbc9 )
{
    if ( !exists( group_id ) )
    {
        return;
    }
    
    if ( var_b51b726d07e7bbc9 <= var_30e6164cdbb20da7 )
    {
        println( "<dev string:x1d>" + "<dev string:x18f>" + group_id );
        return;
    }
    
    level._fx.ambientwar.groups[ group_id ].dist.min = var_30e6164cdbb20da7;
    level._fx.ambientwar.groups[ group_id ].dist.max = var_b51b726d07e7bbc9;
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 4
// Checksum 0x0, Offset: 0x97d
// Size: 0x12d
function set_callback( group_id, fx_alias, func_hit, func_leadin )
{
    if ( !exists( group_id ) )
    {
        return;
    }
    
    foreach ( idx, alias in level._fx.ambientwar.groups[ group_id ].aliases )
    {
        if ( alias.fx_alias == fx_alias )
        {
            level._fx.ambientwar.groups[ group_id ].aliases[ idx ].func.hit = func_hit;
            level._fx.ambientwar.groups[ group_id ].aliases[ idx ].func.leadin = func_leadin;
        }
    }
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 1
// Checksum 0x0, Offset: 0xab2
// Size: 0x40
function is_active( group_id )
{
    if ( exists( group_id ) )
    {
        return level._fx.ambientwar.groups[ group_id ].is_active;
    }
    
    return 0;
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 1
// Checksum 0x0, Offset: 0xafb
// Size: 0x48, Type: bool
function exists( group_id )
{
    if ( isdefined( level._fx.ambientwar.groups[ group_id ] ) )
    {
        return true;
    }
    
    println( "<dev string:x1d>" + "<dev string:x1ca>" + group_id );
    return false;
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 1
// Checksum 0x0, Offset: 0xb4c
// Size: 0x15
function function_955f4192b9000b8( group_id )
{
    function_7e4ccd3a6bb57da0( group_id, 1 );
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 1
// Checksum 0x0, Offset: 0xb69
// Size: 0x14
function function_e52c396d5b27fa3f( group_id )
{
    function_7e4ccd3a6bb57da0( group_id, 0 );
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 1
// Checksum 0x0, Offset: 0xb85
// Size: 0x15
function enable_rumbles( group_id )
{
    rumbles_enabled( group_id, 1 );
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 1
// Checksum 0x0, Offset: 0xba2
// Size: 0x14
function disable_rumbles( group_id )
{
    rumbles_enabled( group_id, 0 );
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 1
// Checksum 0x0, Offset: 0xbbe
// Size: 0x2a
function cinematic_mode( enabled )
{
    level._fx.ambientwar.cinematic_mode = enabled;
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0xbf0
// Size: 0x6b, Type: bool
function private function_d531b42ea4033c5b( player, location, dist_min, dist_max )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    dist_sqr = distance2dsquared( player.origin, location.origin );
    
    if ( dist_sqr >= squared( dist_min ) && dist_sqr <= squared( dist_max ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xc64
// Size: 0x4a
function private function_e670633504274130( player, location, fov )
{
    if ( !isdefined( player ) )
    {
        return 0;
    }
    
    return within_fov( player.origin, player.angles, location.origin, fov );
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xcb7
// Size: 0x85, Type: bool
function private function_f09cfe1ad75009d9( player, location )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    enemies = [];
    
    if ( isdefined( location.var_22ff57eef960b294 ) && location.var_22ff57eef960b294 > 0 )
    {
        enemies = getaiarrayinradius( location.origin, location.var_22ff57eef960b294, "axis" );
        enemies = array_removedead_or_dying( enemies );
        enemies = array_removeundefined( enemies );
    }
    
    if ( enemies.size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xd45
// Size: 0x28
function private ease_linear( start, end, pct )
{
    return ( 1 - pct ) * start + pct * end;
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0xd76
// Size: 0x14b
function private lerp_delays( group_id, var_90e4c321e57aafe6, var_9893026561ada098, time )
{
    level notify( "aws_lerp_delay_" + group_id );
    level endon( "aws_lerp_delay_" + group_id );
    level endon( "aws_stop_" + group_id );
    start_time = gettime();
    lerp_time = abs( time ) * 1000;
    start_delay = level._fx.ambientwar.groups[ group_id ].delay;
    percent = 0;
    
    while ( percent < 1 )
    {
        elapsed_time = gettime() - start_time;
        percent = clamp( elapsed_time / lerp_time, 0, 1 );
        set_delay( group_id, ease_linear( start_delay.min, var_90e4c321e57aafe6, percent ), ease_linear( start_delay.max, var_9893026561ada098, percent ) );
        
        /#
            if ( getdvarint( @"hash_185e6b153cd4cd85", 0 ) )
            {
                println( "<dev string:x1d>" + "<dev string:x1e6>" + group_id + "<dev string:x1f6>" + percent * 100 + "<dev string:x1fa>" );
            }
        #/
        
        waitframe();
    }
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xec9
// Size: 0x955
function private update( group_id )
{
    level notify( "aws_update_" + group_id );
    level endon( "aws_update_" + group_id );
    level endon( "aws_stop_" + group_id );
    aliases = [];
    locations = [];
    delay = level._fx.ambientwar.groups[ group_id ].delay;
    dist = level._fx.ambientwar.groups[ group_id ].dist;
    grid = level._fx.ambientwar.groups[ group_id ].grid;
    parms = spawnstruct();
    
    while ( isdefined( grid ) )
    {
        aliases = level._fx.ambientwar.groups[ group_id ].aliases;
        
        if ( !isdefined( aliases ) || aliases.size == 0 )
        {
            remove( group_id );
            return;
        }
        
        foreach ( player in level.players )
        {
            locations = function_56570edd92b23938( grid, player.origin, dist.max );
            
            if ( isdefined( locations ) && locations.size > 0 )
            {
                parms.player = player;
                parms.group_id = group_id;
                parms.fx_alias = undefined;
                parms.shake_alias = undefined;
                parms.rumble_alias = undefined;
                func_hit = undefined;
                func_leadin = undefined;
                rand_idx = randomintrange( 0, locations.size );
                rand_loc = locations[ rand_idx ];
                rand_delay = randomfloatrange( delay.min, delay.max );
                on_screen = 0;
                in_range = function_d531b42ea4033c5b( player, rand_loc, dist.min, dist.max );
                ai_present = function_f09cfe1ad75009d9( player, rand_loc );
                cinematic_mode = level._fx.ambientwar.cinematic_mode;
                var_7e4ccd3a6bb57da0 = level._fx.ambientwar.groups[ group_id ].var_7e4ccd3a6bb57da0;
                rumbles_enabled = level._fx.ambientwar.groups[ group_id ].rumbles_enabled;
                msg = "";
                
                if ( in_range && !ai_present )
                {
                    if ( isdefined( rand_loc.var_9e2bbe262ca3c265 ) && rand_loc.var_9e2bbe262ca3c265 != "" )
                    {
                        parms.fx_alias = rand_loc.var_9e2bbe262ca3c265;
                        parms.shake_alias = rand_loc.var_975a876c9c8ced9d;
                        parms.rumble_alias = rand_loc.var_48f95e175a12d9c4;
                        
                        /#
                            msg = parms.fx_alias + "<dev string:x1fc>";
                        #/
                    }
                    else
                    {
                        var_e8782b22925ef04d = randomintrange( 0, aliases.size );
                        parms.fx_alias = aliases[ var_e8782b22925ef04d ].fx_alias;
                        parms.shake_alias = aliases[ var_e8782b22925ef04d ].shake_alias;
                        parms.rumble_alias = aliases[ var_e8782b22925ef04d ].rumble_alias;
                        func_hit = aliases[ var_e8782b22925ef04d ].func.hit;
                        func_leadin = aliases[ var_e8782b22925ef04d ].func.leadin;
                        
                        /#
                            msg = parms.fx_alias;
                        #/
                    }
                    
                    if ( !isdefined( rand_loc.angles ) )
                    {
                        rand_loc.angles = ( 0, 0, 0 );
                    }
                    
                    if ( isdefined( func_leadin ) )
                    {
                        rand_loc thread [[ func_leadin ]]( parms, rand_delay, "aws_stop_" + group_id );
                    }
                    
                    wait rand_delay;
                    on_screen = function_e670633504274130( player, rand_loc, 0.5 );
                    
                    if ( isdefined( parms.fx_alias ) )
                    {
                        if ( on_screen )
                        {
                            playfx( getfx( parms.fx_alias ), rand_loc.origin, anglestoforward( rand_loc.angles ), anglestoup( rand_loc.angles ) );
                        }
                        
                        if ( isdefined( parms.shake_alias ) && parms.shake_alias != "" && var_7e4ccd3a6bb57da0 && !cinematic_mode )
                        {
                            do_earthquake( parms.shake_alias, rand_loc.origin );
                        }
                        
                        if ( isdefined( parms.rumble_alias ) && parms.rumble_alias != "" && rumbles_enabled && !cinematic_mode )
                        {
                            playrumbleonposition( parms.rumble_alias, rand_loc.origin );
                        }
                        
                        if ( isdefined( func_hit ) )
                        {
                            rand_loc thread [[ func_hit ]]( parms );
                        }
                        
                        /#
                            if ( getdvarint( @"hash_185e6b153cd4cd85", 0 ) && ( level._fx.ambientwar.filter == "<dev string:x1c>" || level._fx.ambientwar.filter == group_id ) )
                            {
                                text_row = 50;
                                line( rand_loc.origin, rand_loc.origin + ( 0, 0, 50 ), ( 1, 0.65, 0 ), 1, 0, 10 );
                                print3d( rand_loc.origin + ( 0, 0, text_row ), msg, ( 1, 1, 1 ), 1, 0.2, 10, 0 );
                                
                                if ( isdefined( parms.shake_alias ) && isdefined( level.earthquake[ parms.shake_alias ] ) )
                                {
                                    eq = level.earthquake[ parms.shake_alias ];
                                    draw_circle( rand_loc.origin, eq[ "<dev string:x201>" ], 1, 1, 1, eq[ "<dev string:x208>" ] );
                                    enabled = ter_op( var_7e4ccd3a6bb57da0, "<dev string:x211>", "<dev string:x219>" );
                                    text_row -= 4;
                                    print3d( rand_loc.origin + ( 0, 0, text_row ), "<dev string:x222>" + parms.shake_alias + "<dev string:x227>" + enabled + "<dev string:x22a>", ( 1, 1, 1 ), 1, 0.15, 10, 0 );
                                }
                                
                                if ( isdefined( parms.rumble_alias ) )
                                {
                                    enabled = ter_op( rumbles_enabled, "<dev string:x211>", "<dev string:x219>" );
                                    text_row -= 4;
                                    print3d( rand_loc.origin + ( 0, 0, text_row ), "<dev string:x22d>" + parms.rumble_alias + "<dev string:x227>" + enabled + "<dev string:x22a>", ( 1, 1, 1 ), 1, 0.15, 10, 0 );
                                }
                                
                                if ( isdefined( func_hit ) )
                                {
                                    text_row -= 4;
                                    print3d( rand_loc.origin + ( 0, 0, text_row ), "<dev string:x232>", ( 1, 1, 1 ), 1, 0.15, 10, 0 );
                                }
                            }
                        #/
                    }
                }
                
                /#
                    if ( on_screen && ( !in_range || ai_present ) )
                    {
                        if ( getdvarint( @"hash_185e6b153cd4cd85", 0 ) && ( level._fx.ambientwar.filter == "<dev string:x1c>" || level._fx.ambientwar.filter == group_id ) )
                        {
                            msg = "<dev string:x23f>";
                            
                            if ( ai_present )
                            {
                                msg = "<dev string:x24c>";
                                draw_circle( rand_loc.origin, rand_loc.var_22ff57eef960b294, ( 1, 0, 0 ), 1, 0, 2 );
                            }
                            
                            line( rand_loc.origin, rand_loc.origin + ( 0, 0, 50 ), ( 1, 0, 0 ), 1, 0, 2 );
                            print3d( rand_loc.origin + ( 0, 0, 50 ), msg, ( 1, 0, 0 ), 1, 0.2, 2, 0 );
                        }
                    }
                #/
            }
        }
        
        waitframe();
    }
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1826
// Size: 0x48
function private function_7e4ccd3a6bb57da0( group_id, enabled )
{
    if ( exists( group_id ) )
    {
        level._fx.ambientwar.groups[ group_id ].var_7e4ccd3a6bb57da0 = enabled;
    }
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1876
// Size: 0x48
function private rumbles_enabled( group_id, enabled )
{
    if ( exists( group_id ) )
    {
        level._fx.ambientwar.groups[ group_id ].rumbles_enabled = enabled;
    }
}

// Namespace vfx_ambientwar / namespace_eefe753007203056
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x18c6
// Size: 0x66
function private remove_undefined( array )
{
    new_array = [];
    
    foreach ( val in array )
    {
        if ( !isdefined( val ) )
        {
            continue;
        }
        
        new_array[ key ] = val;
    }
    
    return new_array;
}

/#

    // Namespace vfx_ambientwar / namespace_eefe753007203056
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1935
    // Size: 0xaad, Type: dev
    function private function_77c43f774eb592b()
    {
        level notify( "<dev string:x257>" );
        level endon( "<dev string:x257>" );
        level endon( "<dev string:x279>" );
        inset = 10;
        
        while ( true )
        {
            if ( getdvarint( @"hash_185e6b153cd4cd85", 0 ) )
            {
                level._fx.ambientwar.filter = getdvar( @"hash_2ae987e5f164028", "<dev string:x1c>" );
                
                foreach ( group in level._fx.ambientwar.groups )
                {
                    if ( level._fx.ambientwar.filter == "<dev string:x1c>" || level._fx.ambientwar.filter == group.group_id )
                    {
                        x1 = group.grid.bounds.p1[ 0 ];
                        x2 = group.grid.bounds.p2[ 0 ];
                        y1 = group.grid.bounds.p1[ 1 ];
                        y2 = group.grid.bounds.p2[ 1 ];
                        x = x1;
                        y = y1;
                        z = 0;
                        
                        for ( r = 0; r < group.grid.rows ; r++ )
                        {
                            line( ( x1, y, z ), ( x2, y, z ), ( 0, 0, 0 ), 1, 0, 1 );
                            y += group.grid.cell_size;
                        }
                        
                        for ( c = 0; c < group.grid.cols ; c++ )
                        {
                            line( ( x, y1, z ), ( x, y2, z ), ( 0, 0, 0 ), 1, 0, 1 );
                            x += group.grid.cell_size;
                        }
                        
                        line( ( group.grid.bounds.p1[ 0 ], group.grid.bounds.p1[ 1 ], 0 ), ( group.grid.bounds.p2[ 0 ], group.grid.bounds.p1[ 1 ], 0 ), ( 1, 1, 1 ), 1, 0, 1 );
                        line( ( group.grid.bounds.p2[ 0 ], group.grid.bounds.p1[ 1 ], 0 ), ( group.grid.bounds.p2[ 0 ], group.grid.bounds.p2[ 1 ], 0 ), ( 1, 1, 1 ), 1, 0, 1 );
                        line( ( group.grid.bounds.p2[ 0 ], group.grid.bounds.p2[ 1 ], 0 ), ( group.grid.bounds.p1[ 0 ], group.grid.bounds.p2[ 1 ], 0 ), ( 1, 1, 1 ), 1, 0, 1 );
                        line( ( group.grid.bounds.p1[ 0 ], group.grid.bounds.p2[ 1 ], 0 ), ( group.grid.bounds.p1[ 0 ], group.grid.bounds.p1[ 1 ], 0 ), ( 1, 1, 1 ), 1, 0, 1 );
                        
                        foreach ( index in group.grid.selected )
                        {
                            line( ( group.grid.cells[ index ].area.p1[ 0 ] + inset, group.grid.cells[ index ].area.p1[ 1 ] + inset, 0 ), ( group.grid.cells[ index ].area.p2[ 0 ] - inset, group.grid.cells[ index ].area.p1[ 1 ] + inset, 0 ), ( 0, 1, 0 ), 1, 0, 1 );
                            line( ( group.grid.cells[ index ].area.p2[ 0 ] - inset, group.grid.cells[ index ].area.p1[ 1 ] + inset, 0 ), ( group.grid.cells[ index ].area.p2[ 0 ] - inset, group.grid.cells[ index ].area.p2[ 1 ] - inset, 0 ), ( 0, 1, 0 ), 1, 0, 1 );
                            line( ( group.grid.cells[ index ].area.p2[ 0 ] - inset, group.grid.cells[ index ].area.p2[ 1 ] - inset, 0 ), ( group.grid.cells[ index ].area.p1[ 0 ] + inset, group.grid.cells[ index ].area.p2[ 1 ] - inset, 0 ), ( 0, 1, 0 ), 1, 0, 1 );
                            line( ( group.grid.cells[ index ].area.p1[ 0 ] + inset, group.grid.cells[ index ].area.p2[ 1 ] - inset, 0 ), ( group.grid.cells[ index ].area.p1[ 0 ] + inset, group.grid.cells[ index ].area.p1[ 1 ] + inset, 0 ), ( 0, 1, 0 ), 1, 0, 1 );
                            
                            foreach ( ent in group.grid.cells[ index ].ents )
                            {
                                debugaxis( ent.origin, ent.angles );
                                print3d( ent.origin, "<dev string:x28d>" + group.group_id, ( 1, 1, 1 ), 1, 0.2, 1, 0 );
                            }
                        }
                        
                        foreach ( player in level.players )
                        {
                            draw_circle( player.origin, group.dist.min, ( 1, 0, 0 ), 1, 0, 1 );
                            draw_circle( player.origin, group.dist.max, ( 0, 1, 0 ), 1, 0, 1 );
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace vfx_ambientwar / namespace_eefe753007203056
    // Params 0
    // Checksum 0x0, Offset: 0x23ea
    // Size: 0xd, Type: dev
    function function_9f23016b393f33df()
    {
        level notify( "<dev string:x279>" );
    }

#/
