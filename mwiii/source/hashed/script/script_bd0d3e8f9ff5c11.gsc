#using script_200c1cd00f9ab885;
#using script_3badb8914eb5ac16;
#using script_7edf952f8921aa6b;
#using scripts\aitypes\zombie_deathworm\zombie_deathworm_metabones;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace zombie_deathworm;

// Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
// Params 1
// Checksum 0x0, Offset: 0x173
// Size: 0x69
function function_1fa609d0d2a30cf9( params )
{
    if ( utility::flag( "deathworm_arena_precache_init" ) )
    {
        return;
    }
    
    utility::flag_set( "deathworm_arena_precache_init" );
    function_567352b560bfa797();
    level.var_e8b533c647a37168 = getnoentvolumearray( "deathworm_exclude_unburrow", "script_noteworthy" );
    level.var_b3a50e9cc45c0150 = getnoentvolumearray( "deathworm_exclude_melee", "script_noteworthy" );
    
    /#
        level thread draw_arena();
    #/
}

// Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
// Params 0
// Checksum 0x0, Offset: 0x1e4
// Size: 0xa4
function init_arena()
{
    arena_struct = function_93d1ef5f66691f8b( self.origin );
    
    if ( !isdefined( arena_struct ) )
    {
        level.var_53335c6347493500++;
        arena_struct = { #arena_id:level.var_53335c6347493500, #radius:2000, #origin:self.origin };
        level.var_5700d8decfa9d4f = array_add( level.var_5700d8decfa9d4f, arena_struct );
        level.var_ca6e770e74de937b[ level.var_53335c6347493500 ] = [ arena_struct ];
    }
    
    function_858422d3879f557f( arena_struct );
    
    /#
        function_66d4d09bd388ee78();
    #/
}

// Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
// Params 0
// Checksum 0x0, Offset: 0x290
// Size: 0x35
function function_7b4daaf9179c9cee()
{
    assert( isdefined( self.var_a64485b1cb0aadc8.origin ) );
    return self.var_a64485b1cb0aadc8.origin;
}

// Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
// Params 0
// Checksum 0x0, Offset: 0x2ce
// Size: 0x35
function function_674396d03ad1a1fa()
{
    assert( isdefined( self.var_a64485b1cb0aadc8.radius ) );
    return self.var_a64485b1cb0aadc8.radius;
}

// Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
// Params 0
// Checksum 0x0, Offset: 0x30c
// Size: 0x35
function function_ece5be42c1ccbb71()
{
    assert( isdefined( self.var_a64485b1cb0aadc8.arena_id ) );
    return self.var_a64485b1cb0aadc8.arena_id;
}

// Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
// Params 1
// Checksum 0x0, Offset: 0x34a
// Size: 0x45
function function_858422d3879f557f( arena_struct )
{
    assert( isdefined( arena_struct.origin ) );
    assert( isdefined( arena_struct.radius ) );
    self.var_a64485b1cb0aadc8 = arena_struct;
}

// Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
// Params 1
// Checksum 0x0, Offset: 0x397
// Size: 0x65, Type: bool
function function_95d12d803b1f13bb( pos )
{
    foreach ( volume in level.var_e8b533c647a37168 )
    {
        if ( ispointinvolume( pos, volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
// Params 1
// Checksum 0x0, Offset: 0x405
// Size: 0x65, Type: bool
function function_e82696e7b59178f3( pos )
{
    foreach ( volume in level.var_b3a50e9cc45c0150 )
    {
        if ( ispointinvolume( pos, volume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
// Params 1
// Checksum 0x0, Offset: 0x473
// Size: 0x8a
function function_93d1ef5f66691f8b( pos )
{
    foreach ( arena_struct in level.var_5700d8decfa9d4f )
    {
        dist_sq = distancesquared( arena_struct.origin, pos );
        
        if ( dist_sq < squared( arena_struct.radius ) )
        {
            return arena_struct;
        }
    }
    
    return undefined;
}

// Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
// Params 0
// Checksum 0x0, Offset: 0x506
// Size: 0xd6
function function_dd196c8614532a7e()
{
    self endon( "death" );
    
    while ( ent_flag( "is_underground" ) )
    {
        arena_id = function_ece5be42c1ccbb71();
        
        if ( level.var_ca6e770e74de937b[ arena_id ].size <= 1 )
        {
            return;
        }
        
        var_7a25821a42f91ded = undefined;
        var_9d9f39b70c22774b = -1;
        
        foreach ( arena_struct in level.var_ca6e770e74de937b[ arena_id ] )
        {
            influence = getplayerinfluenceatposition( arena_struct.origin, 1 );
            
            if ( influence > var_9d9f39b70c22774b )
            {
                var_9d9f39b70c22774b = influence;
                var_7a25821a42f91ded = arena_struct;
            }
            
            waitframe();
        }
        
        function_858422d3879f557f( var_7a25821a42f91ded );
        waitframe();
    }
}

// Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
// Params 0
// Checksum 0x0, Offset: 0x5e4
// Size: 0x97
function function_567352b560bfa797()
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    level.var_ca6e770e74de937b = [];
    arena_structs = getstructarray( "deathworm_arena", "script_noteworthy" );
    level.var_53335c6347493500 = 0;
    
    foreach ( arena_struct in arena_structs )
    {
        function_23655a044ca75962( arena_struct );
    }
    
    level.var_5700d8decfa9d4f = arena_structs;
}

// Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
// Params 1
// Checksum 0x0, Offset: 0x683
// Size: 0xcc
function function_23655a044ca75962( arena_struct )
{
    if ( !isdefined( arena_struct ) )
    {
        level.var_53335c6347493500++;
        return level.var_53335c6347493500;
    }
    
    if ( isdefined( arena_struct.arena_id ) )
    {
        return arena_struct.arena_id;
    }
    
    target_struct = undefined;
    
    if ( isdefined( arena_struct.target ) )
    {
        target_struct = getstruct( arena_struct.target, "targetname" );
    }
    
    arena_id = function_23655a044ca75962( target_struct );
    arena_struct.arena_id = arena_id;
    
    if ( !isdefined( level.var_ca6e770e74de937b[ arena_id ] ) )
    {
        level.var_ca6e770e74de937b[ arena_id ] = [];
    }
    
    level.var_ca6e770e74de937b[ arena_id ] = array_add( level.var_ca6e770e74de937b[ arena_id ], arena_struct );
    return arena_id;
}

/#

    // Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
    // Params 0
    // Checksum 0x0, Offset: 0x758
    // Size: 0x2e, Type: dev
    function function_66d4d09bd388ee78()
    {
        function_6e7290c8ee4f558b( "<dev string:x1c>" );
        function_a9a864379a098ad6( "<dev string:x3b>", "<dev string:x4a>", &function_751e00a00e530c41 );
        function_fe953f000498048f();
    }

    // Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x78e
    // Size: 0x17, Type: dev
    function private debug_arena()
    {
        return getdvarint( @"hash_c48f64bb1ff42277", 0 ) > 0;
    }

    // Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x7ad
    // Size: 0x1a, Type: dev
    function private function_751e00a00e530c41()
    {
        function_2fb888667001fc39( "<dev string:x5e>", @"hash_c48f64bb1ff42277" );
    }

    // Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x7cf
    // Size: 0x5a, Type: dev
    function private arena_print( text, pos )
    {
        if ( debug_arena() )
        {
            pos = default_to( pos, self.origin + ( 0, 0, 70 ) );
            print3d( pos, "<dev string:x77>" + text, ( 1, 0, 0 ) );
        }
    }

    // Namespace zombie_deathworm / namespace_7762066fd5e7dbe9
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x831
    // Size: 0x2f3, Type: dev
    function private draw_arena()
    {
        level endon( "<dev string:x8c>" );
        
        while ( true )
        {
            if ( !debug_arena() )
            {
                waitframe();
                continue;
            }
            
            if ( !isdefined( level.players ) || !isdefined( level.players[ 0 ] ) )
            {
                waitframe();
                continue;
            }
            
            worm = function_6d1fbda4b8524ef2( level.players[ 0 ].origin, undefined, "<dev string:x9a>" );
            
            if ( isdefined( worm ) )
            {
                arena_color = ( 0, 0.5, 1 );
                draw_circle( worm function_7b4daaf9179c9cee(), worm function_674396d03ad1a1fa(), arena_color, 1, 1, 1 );
                sphere( worm function_7b4daaf9179c9cee(), 100, arena_color, 1, 1 );
                print3d( worm function_7b4daaf9179c9cee(), "<dev string:xae>", arena_color );
                var_48f627463d405084 = ( 1, 0.2, 0.2 );
                sphere( worm.var_7aeae37022a80dc2.origin, 30, var_48f627463d405084, 1, 1 );
                print3d( worm.var_7aeae37022a80dc2.origin + ( 0, 0, -10 ), "<dev string:xc6>", var_48f627463d405084, 0.8, 0.5 );
            }
            
            foreach ( arena_struct in level.var_5700d8decfa9d4f )
            {
                arena_color = ( 0.2, 0.5, 0.8 );
                
                if ( isdefined( arena_struct.radius ) )
                {
                    influence = getplayerinfluenceatposition( arena_struct.origin, 1 );
                    draw_circle( arena_struct.origin, arena_struct.radius, arena_color, 0.7, 1, 1 );
                    sphere( arena_struct.origin, 50, arena_color, 1, 1 );
                    print3d( arena_struct.origin, "<dev string:xe5>" + arena_struct.arena_id + "<dev string:xfe>" + influence, arena_color, 0.7 );
                }
            }
            
            foreach ( exclude_volume in level.var_e8b533c647a37168 )
            {
                orientedbox( exclude_volume.origin, ( 20, 20, 20 ), exclude_volume.angles, ( 1, 0, 0 ), 1, 1 );
                print3d( exclude_volume.origin, "<dev string:x112>", ( 1, 0, 0 ), 0.7, 0.5 );
            }
            
            waitframe();
        }
    }

#/
