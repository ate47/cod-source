#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace trace;

// Namespace trace / scripts\engine\trace
// Params 7
// Checksum 0x0, Offset: 0x505
// Size: 0xa8
function ray_trace( start, end, ignore, contentoverride, getsurfacetype, ignoreclutter, allowscriptables )
{
    trace = physics_raycast( start, end, isdefined( contentoverride ) ? contentoverride : create_default_contents(), ignore, 0, "physicsquery_closest", istrue( ignoreclutter ), allowscriptables );
    
    if ( trace.size )
    {
        trace = trace[ 0 ];
    }
    else
    {
        trace = internal_pack_default_trace( end );
    }
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        trace = convert_surface_flag( trace );
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x1c>", start, end );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 6
// Checksum 0x0, Offset: 0x5b6
// Size: 0xc0
function ray_trace_ents( start, end, ents, contentoverride, getsurfacetype, ignoreclutter )
{
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    shouldignoreclutter = ter_op( isdefined( ignoreclutter ), ignoreclutter, 0 );
    trace = physics_raycastents( start, end, content, ents, 0, "physicsquery_closest", shouldignoreclutter );
    
    if ( trace.size )
    {
        trace = trace[ 0 ];
    }
    else
    {
        trace = internal_pack_default_trace( end );
    }
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        trace = convert_surface_flag( trace );
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x1c>", start, end );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 4
// Checksum 0x0, Offset: 0x67f
// Size: 0x85
function player_viewangles( collisioncontents, getsurfacetype, ignoreclutter, allowscriptables )
{
    if ( !isdefined( collisioncontents ) )
    {
        collisioncontents = create_all_contents();
    }
    
    if ( !isdefined( getsurfacetype ) )
    {
        getsurfacetype = 1;
    }
    
    if ( !isdefined( ignoreclutter ) )
    {
        ignoreclutter = 1;
    }
    
    if ( !isdefined( allowscriptables ) )
    {
        allowscriptables = 1;
    }
    
    assert( isplayer( self ) );
    return ray_trace( self geteye(), self geteye() + anglestoforward( self getplayerangles() ) * 10000, self, collisioncontents, getsurfacetype, ignoreclutter, allowscriptables );
}

// Namespace trace / scripts\engine\trace
// Params 9
// Checksum 0x0, Offset: 0x70d
// Size: 0x113
function _bullet_trace( start, end, hitcharacters, ignore, itemclip, var_45ab9428a87b2b9f, testvehicleclip, noshotclip, testglass )
{
    content = [ "physicscontents_clipshot", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item" ];
    
    if ( hitcharacters )
    {
        content[ content.size ] = "physicscontents_characterproxy";
    }
    
    if ( isdefined( itemclip ) && itemclip )
    {
        content[ content.size ] = "physicscontents_itemclip";
    }
    
    if ( isdefined( testvehicleclip ) && testvehicleclip )
    {
        content[ content.size ] = "physicscontents_vehicleclip";
    }
    
    if ( !isdefined( noshotclip ) || !noshotclip )
    {
        content[ content.size ] = "physicscontents_clipshot";
    }
    
    if ( !isdefined( testglass ) || testglass )
    {
        content[ content.size ] = "physicscontents_glass";
    }
    
    if ( isdefined( var_45ab9428a87b2b9f ) && var_45ab9428a87b2b9f )
    {
        return ray_trace_detail( start, end, ignore, physics_createcontents( content ), 1 );
    }
    
    return ray_trace( start, end, ignore, physics_createcontents( content ), 1 );
}

// Namespace trace / scripts\engine\trace
// Params 4
// Checksum 0x0, Offset: 0x828
// Size: 0x34
function _bullet_trace_passed( start, end, hitcharacters, ignore )
{
    return ray_trace_passed( start, end, ignore, create_default_contents( !hitcharacters ) );
}

// Namespace trace / scripts\engine\trace
// Params 7
// Checksum 0x0, Offset: 0x865
// Size: 0xea
function ray_trace_detail( start, end, ignore, contentoverride, getsurfacetype, ignoreclutter, allowscriptables )
{
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    shouldignoreclutter = ter_op( isdefined( ignoreclutter ), ignoreclutter, 0 );
    
    if ( isdefined( allowscriptables ) )
    {
        trace = physics_raycast( start, end, content, ignore, 1, "physicsquery_closest", shouldignoreclutter, allowscriptables );
    }
    else
    {
        trace = physics_raycast( start, end, content, ignore, 1, "physicsquery_closest", shouldignoreclutter );
    }
    
    if ( trace.size )
    {
        trace = trace[ 0 ];
    }
    else
    {
        trace = internal_pack_default_trace( end );
    }
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        trace = convert_surface_flag( trace );
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x1c>", start, end );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 5
// Checksum 0x0, Offset: 0x958
// Size: 0xd0
function ray_trace_get_all_results( start, end, ignore, contentoverride, getsurfacetype )
{
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    trace = physics_raycast( start, end, content, ignore, 0, "physicsquery_all" );
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        foreach ( t in trace )
        {
            trace[ i ] = convert_surface_flag( t );
        }
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x1c>", start, end );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 4
// Checksum 0x0, Offset: 0xa31
// Size: 0x4d, Type: bool
function ray_trace_passed( start, end, ignore, contentoverride )
{
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    return !physics_raycast( start, end, content, ignore, 0, "physicsquery_any" );
}

// Namespace trace / scripts\engine\trace
// Params 4
// Checksum 0x0, Offset: 0xa87
// Size: 0x4e, Type: bool
function ray_trace_detail_passed( start, end, ignore, contentoverride )
{
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    return !physics_raycast( start, end, content, ignore, 1, "physicsquery_any" );
}

// Namespace trace / scripts\engine\trace
// Params 2
// Checksum 0x0, Offset: 0xade
// Size: 0x73, Type: bool
function can_see_origin( origin, test_characters )
{
    assertex( isdefined( origin ), "can_see_origin() requires a valid origin to be passed in." );
    assertex( isplayer( self ) || isai( self ), "can_see_origin() can only be called on a player or AI." );
    
    if ( !isdefined( test_characters ) )
    {
        test_characters = 1;
    }
    
    if ( !math::point_in_fov( origin ) )
    {
        return false;
    }
    
    return ray_trace_passed( self geteye(), origin, self, scripts\engine\trace::create_contents( test_characters, 1, 0, 1, 0, 1 ) );
}

// Namespace trace / scripts\engine\trace
// Params 7
// Checksum 0x0, Offset: 0xb5a
// Size: 0xb6
function sphere_trace( start, end, radius, ignore, contentoverride, getsurfacetype, allowscriptables )
{
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    trace = physics_spherecast( start, end, radius, content, ignore, "physicsquery_closest", undefined, allowscriptables );
    
    if ( trace.size )
    {
        trace = trace[ 0 ];
    }
    else
    {
        trace = internal_pack_default_trace( end );
    }
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        trace = convert_surface_flag( trace );
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x20>", start, end, radius );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 7
// Checksum 0x0, Offset: 0xc19
// Size: 0xbd
function sphere_trace_get_all_results( start, end, radius, ignore, contentoverride, getsurfacetype, allowscriptables )
{
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    trace = physics_spherecast( start, end, radius, content, ignore, "physicsquery_all", undefined, allowscriptables );
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        for ( i = 0; i < trace.size ; i++ )
        {
            trace[ i ] = convert_surface_flag( trace[ i ] );
        }
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x20>", start, end, radius );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 5
// Checksum 0x0, Offset: 0xcdf
// Size: 0x55, Type: bool
function sphere_trace_passed( start, end, radius, ignore, contentoverride )
{
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    return !physics_spherecast( start, end, radius, content, ignore, "physicsquery_any" );
}

// Namespace trace / scripts\engine\trace
// Params 6
// Checksum 0x0, Offset: 0xd3d
// Size: 0xad
function sphere_get_closest_point( position, radius, search_distance, ignore, contentoverride, getsurfacetype )
{
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    trace = physics_getclosestpointtosphere( position, radius, search_distance, content, ignore, "physicsquery_closest" );
    
    if ( trace.size )
    {
        trace = trace[ 0 ];
    }
    else
    {
        trace = internal_pack_default_trace( position );
    }
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        trace = convert_surface_flag( trace );
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x20>", position, undefined, radius, undefined, undefined, search_distance );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 8
// Checksum 0x0, Offset: 0xdf3
// Size: 0x103
function capsule_trace( start, end, radius, height, angles, ignore, contentoverride, getsurfacetype )
{
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    capsule_data = convert_capsule_data( start, end, radius, height, angles );
    trace = physics_capsulecast( capsule_data[ "trace_start" ], capsule_data[ "trace_end" ], radius, capsule_data[ "half_height" ], angles, content, ignore, "physicsquery_closest" );
    
    if ( trace.size )
    {
        trace = trace[ 0 ];
    }
    else
    {
        trace = internal_pack_default_trace( end );
    }
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        trace = convert_surface_flag( trace );
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x27>", start, end, radius, height, angles );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 8
// Checksum 0x0, Offset: 0xeff
// Size: 0x132
function capsule_trace_get_all_results( start, end, radius, height, angles, ignore, contentoverride, getsurfacetype )
{
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    capsule_data = convert_capsule_data( start, end, radius, height, angles );
    trace = physics_capsulecast( capsule_data[ "trace_start" ], capsule_data[ "trace_end" ], radius, capsule_data[ "half_height" ], angles, content, ignore, "physicsquery_all" );
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        foreach ( t in trace )
        {
            t = convert_surface_flag( t );
        }
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x27>", start, end, radius, height, angles );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 7
// Checksum 0x0, Offset: 0x103a
// Size: 0xa7, Type: bool
function capsule_trace_passed( start, end, radius, height, angles, ignore, contentoverride )
{
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    capsule_data = convert_capsule_data( start, end, radius, height, angles );
    return !physics_capsulecast( capsule_data[ "trace_start" ], capsule_data[ "trace_end" ], radius, capsule_data[ "half_height" ], angles, content, ignore, "physicsquery_any" );
}

// Namespace trace / scripts\engine\trace
// Params 8
// Checksum 0x0, Offset: 0x10ea
// Size: 0xfe
function capsule_get_closest_point( position, radius, height, angles, search_distance, ignore, contentoverride, getsurfacetype )
{
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    capsule_data = convert_capsule_data( position, undefined, radius, height, angles );
    trace = physics_getclosestpointtocapsule( capsule_data[ "trace_start" ], radius, capsule_data[ "half_height" ], angles, search_distance, content, ignore, "physicsquery_closest" );
    
    if ( trace.size )
    {
        trace = trace[ 0 ];
    }
    else
    {
        trace = internal_pack_default_trace( position );
    }
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        trace = convert_surface_flag( trace );
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x27>", position, undefined, radius, height, angles, search_distance );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 7
// Checksum 0x0, Offset: 0x11f1
// Size: 0xe8
function player_trace( start, end, angles, ignore, contentoverride, getsurfacetype, ground_clearance )
{
    if ( !isplayer( self ) )
    {
        assertmsg( "player_trace can only be called on a player!" );
        return;
    }
    
    if ( !isdefined( angles ) )
    {
        angles = self getplayerangles();
    }
    
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    
    if ( !isdefined( ground_clearance ) )
    {
        ground_clearance = 0;
    }
    
    trace = physics_charactercast( start, end, self, ground_clearance, angles, content, ignore, "physicsquery_closest" );
    
    if ( trace.size )
    {
        trace = trace[ 0 ];
    }
    else
    {
        trace = internal_pack_default_trace( end );
    }
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        trace = convert_surface_flag( trace );
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x2f>", start, end, undefined, undefined, angles, undefined, self );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 7
// Checksum 0x0, Offset: 0x12e2
// Size: 0x117
function player_trace_get_all_results( start, end, angles, ignore, contentoverride, getsurfacetype, ground_clearance )
{
    if ( !isplayer( self ) )
    {
        assertmsg( "player_trace_get_all_results can only be called on a player!" );
        return;
    }
    
    if ( !isdefined( angles ) )
    {
        angles = self getplayerangles();
    }
    
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    
    if ( !isdefined( ground_clearance ) )
    {
        ground_clearance = 0;
    }
    
    trace = physics_charactercast( start, end, self, ground_clearance, angles, content, ignore, "physicsquery_all" );
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        foreach ( t in trace )
        {
            t = convert_surface_flag( t );
        }
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x2f>", start, end, undefined, undefined, angles, undefined, self );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 6
// Checksum 0x0, Offset: 0x1402
// Size: 0x8d
function player_trace_passed( start, end, angles, ignore, contentoverride, ground_clearance )
{
    if ( !isplayer( self ) )
    {
        assertmsg( "player_trace_passed can only be called on a player!" );
        return;
    }
    
    if ( !isdefined( angles ) )
    {
        angles = self getplayerangles();
    }
    
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    
    if ( !isdefined( ground_clearance ) )
    {
        ground_clearance = 0;
    }
    
    return !physics_charactercast( start, end, self, ground_clearance, angles, content, ignore, "physicsquery_any" );
}

// Namespace trace / scripts\engine\trace
// Params 4
// Checksum 0x0, Offset: 0x1498
// Size: 0x3f
function player_get_closest_point_static( search_distance, ignore, contentoverride, getsurfacetype )
{
    return player_get_closest_point( self.origin, self.angles, search_distance, ignore, contentoverride, getsurfacetype );
}

// Namespace trace / scripts\engine\trace
// Params 6
// Checksum 0x0, Offset: 0x14e0
// Size: 0xf7
function player_get_closest_point( position, angles, search_distance, ignore, contentoverride, getsurfacetype )
{
    if ( !isplayer( self ) )
    {
        assertmsg( "player_get_closest_point can only be called on a player!" );
        return;
    }
    
    if ( !isdefined( angles ) )
    {
        angles = self getplayerangles();
    }
    
    if ( !isdefined( search_distance ) )
    {
        search_distance = 0;
    }
    
    if ( isarray( ignore ) )
    {
        ignore = array_add( ignore, self );
    }
    else
    {
        ignore = self;
    }
    
    content = ter_op( isdefined( contentoverride ), contentoverride, create_default_contents() );
    trace = physics_getclosestpointtocharacter( position, self, 0, angles, search_distance, content, ignore, "physicsquery_closest" );
    
    if ( trace.size )
    {
        trace = trace[ 0 ];
    }
    else
    {
        trace = internal_pack_default_trace( position );
    }
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        trace = convert_surface_flag( trace );
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x2f>", position, undefined, undefined, undefined, angles, search_distance, self );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 7
// Checksum 0x0, Offset: 0x15e0
// Size: 0xeb
function ai_trace( start, end, angles, ignore, contentoverride, getsurfacetype, ground_clearance )
{
    if ( !isai( self ) )
    {
        assertmsg( "ai_trace can only be called on an AI!" );
        return;
    }
    
    if ( !isdefined( angles ) )
    {
        angles = self.angles;
    }
    
    content = ter_op( isdefined( contentoverride ), contentoverride, create_solid_ai_contents() );
    
    if ( !isdefined( ground_clearance ) )
    {
        ground_clearance = 0;
    }
    
    trace = physics_charactercast( start, end, self, ground_clearance, angles, content, ignore, "physicsquery_closest" );
    
    if ( trace.size )
    {
        trace = trace[ 0 ];
    }
    else
    {
        trace = internal_pack_default_trace( end );
    }
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        trace = convert_surface_flag( trace );
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x2f>", start, end, undefined, undefined, angles, undefined, self );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 7
// Checksum 0x0, Offset: 0x16d4
// Size: 0x11a
function ai_trace_get_all_results( start, end, angles, ignore, contentoverride, getsurfacetype, ground_clearance )
{
    if ( !isai( self ) )
    {
        assertmsg( "ai_trace_get_all_results can only be called on an AI!" );
        return;
    }
    
    if ( !isdefined( angles ) )
    {
        angles = self.angles;
    }
    
    content = ter_op( isdefined( contentoverride ), contentoverride, create_solid_ai_contents() );
    
    if ( !isdefined( ground_clearance ) )
    {
        ground_clearance = 0;
    }
    
    trace = physics_charactercast( start, end, self, ground_clearance, angles, content, ignore, "physicsquery_all" );
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        foreach ( t in trace )
        {
            t = convert_surface_flag( t );
        }
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x2f>", start, end, undefined, undefined, angles, undefined, self );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 6
// Checksum 0x0, Offset: 0x17f7
// Size: 0x90
function ai_trace_passed( start, end, angles, ignore, contentoverride, ground_clearance )
{
    if ( !isai( self ) )
    {
        assertmsg( "ai_trace can only be called on an AI!" );
        return;
    }
    
    if ( !isdefined( angles ) )
    {
        angles = self.angles;
    }
    
    content = ter_op( isdefined( contentoverride ), contentoverride, create_solid_ai_contents() );
    
    if ( !isdefined( ground_clearance ) )
    {
        ground_clearance = 0;
    }
    
    return !physics_charactercast( start, end, self, ground_clearance, angles, content, ignore, "physicsquery_any" );
}

// Namespace trace / scripts\engine\trace
// Params 6
// Checksum 0x0, Offset: 0x1890
// Size: 0xe1
function ai_get_closest_point( position, angles, search_distance, ignore, contentoverride, getsurfacetype )
{
    if ( !isai( self ) )
    {
        assertmsg( "ai_trace can only be called on an AI!" );
        return;
    }
    
    if ( !isdefined( angles ) )
    {
        angles = self.angles;
    }
    
    if ( !isdefined( search_distance ) )
    {
        search_distance = 0;
    }
    
    content = ter_op( isdefined( contentoverride ), contentoverride, create_solid_ai_contents() );
    trace = physics_getclosestpointtocharacter( position, self, 0, angles, search_distance, content, ignore, "physicsquery_closest" );
    
    if ( trace.size )
    {
        trace = trace[ 0 ];
    }
    else
    {
        trace = internal_pack_default_trace( position );
    }
    
    if ( isdefined( getsurfacetype ) && getsurfacetype )
    {
        trace = convert_surface_flag( trace );
    }
    
    /#
        trace = internal_create_debug_data( trace, "<dev string:x2f>", position, undefined, undefined, undefined, angles, search_distance, self );
    #/
    
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 1
// Checksum 0x0, Offset: 0x197a
// Size: 0x51
function create_solid_ai_contents( ignore_characters )
{
    content = [ "physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle" ];
    
    if ( !isdefined( ignore_characters ) || !ignore_characters )
    {
        content = array_add( content, "physicscontents_characterproxy" );
    }
    
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x19d4
// Size: 0x38
function function_2d88cb1f022d0989()
{
    content = [ "physicscontents_solid", "physicscontents_playerclip", "physicscontents_characterproxy", "physicscontents_glass" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 2
// Checksum 0x0, Offset: 0x1a15
// Size: 0x55
function create_opaque_ai_contents( ignore_character, ignore_foliage )
{
    contents = [ "physicscontents_ainosight", "physicscontents_vehicle" ];
    
    if ( !istrue( ignore_character ) )
    {
        contents[ contents.size ] = "physicscontents_characterproxy";
    }
    
    if ( !istrue( ignore_foliage ) )
    {
        contents[ contents.size ] = "physicscontents_foliage";
    }
    
    return physics_createcontents( contents );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1a73
// Size: 0x26
function function_416688b9ffe933c4()
{
    contents = [ "physicscontents_foliage", "physicscontents_foliage_audio" ];
    return physics_createcontents( contents );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1aa2
// Size: 0x1d
function create_ainosight_contents()
{
    content = [ "physicscontents_ainosight" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1ac8
// Size: 0x26
function create_world_contents()
{
    content = [ "physicscontents_itemclip", "physicscontents_water" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1af7
// Size: 0x11
function function_b88b8bd51ea7fe24()
{
    return physics_createcontents( [ "physicscontents_water" ] );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1b11
// Size: 0x1d
function create_glass_contents()
{
    content = [ "physicscontents_glass" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1b37
// Size: 0x1d
function create_ainoshoot_contents()
{
    content = [ "physicscontents_ainoshoot" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1b5d
// Size: 0x1d
function create_item_contents()
{
    content = [ "physicscontents_item" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1b83
// Size: 0x1d
function create_itemclip_contents()
{
    content = [ "physicscontents_itemclip" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1ba9
// Size: 0x1d
function create_vehicle_contents()
{
    content = [ "physicscontents_vehicle" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1bcf
// Size: 0x1d
function function_f3dae12daeb1e8bb()
{
    content = [ "physicscontents_vehicleclip" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1bf5
// Size: 0x26
function create_shotclip_contents()
{
    content = [ "physicscontents_clipshot", "physicscontents_missileclip" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1c24
// Size: 0x1d
function create_playerclip_contents()
{
    content = [ "physicscontents_playerclip" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1c4a
// Size: 0x1d
function create_character_contents()
{
    content = [ "physicscontents_characterproxy" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1c70
// Size: 0x1d
function function_95da3996aeae6098()
{
    content = [ "physicscontents_cameraclip" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 1
// Checksum 0x0, Offset: 0x1c96
// Size: 0x24
function create_default_contents( ignore_characters )
{
    if ( !isdefined( ignore_characters ) )
    {
        ignore_characters = 0;
    }
    
    return create_contents( !ignore_characters, 1, 1, 1, 0, 1 );
}

// Namespace trace / scripts\engine\trace
// Params 12
// Checksum 0x0, Offset: 0x1cc3
// Size: 0x192
function create_contents( character, world, glass, shotclip, item, vehicle, playerclip, ainosight, itemclip, vehicleclip, waterclip, cameraclip )
{
    content = 0;
    contentcache = isdefined( level.var_dd16da2ec35010ad ) ? level.var_dd16da2ec35010ad : function_f00c9e807784481e();
    
    if ( istrue( character ) )
    {
        content += contentcache.character;
    }
    
    if ( istrue( world ) )
    {
        content += contentcache.world;
    }
    
    if ( istrue( glass ) )
    {
        content += contentcache.glass;
    }
    
    if ( istrue( shotclip ) )
    {
        content += contentcache.shotclip;
    }
    
    if ( istrue( item ) )
    {
        content += contentcache.item;
    }
    
    if ( istrue( vehicle ) )
    {
        content += contentcache.vehicle;
    }
    
    if ( istrue( playerclip ) )
    {
        content += contentcache.playerclip;
    }
    
    if ( istrue( ainosight ) )
    {
        content += contentcache.ainosight;
    }
    
    if ( istrue( itemclip ) )
    {
        content += contentcache.itemclip;
    }
    
    if ( istrue( vehicleclip ) )
    {
        content += contentcache.vehicleclip;
    }
    
    if ( istrue( waterclip ) )
    {
        content += contentcache.waterclip;
    }
    
    if ( istrue( cameraclip ) )
    {
        content += contentcache.cameraclip;
    }
    
    return content;
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1e5e
// Size: 0xc9
function function_f00c9e807784481e()
{
    level.var_dd16da2ec35010ad = { #cameraclip:function_95da3996aeae6098(), #waterclip:function_b88b8bd51ea7fe24(), #vehicleclip:function_f3dae12daeb1e8bb(), #itemclip:create_itemclip_contents(), #ainosight:create_ainosight_contents(), #playerclip:create_playerclip_contents(), #vehicle:create_vehicle_contents(), #item:create_item_contents(), #shotclip:create_shotclip_contents(), #glass:create_glass_contents(), #world:create_world_contents(), #character:create_character_contents() };
    return level.var_dd16da2ec35010ad;
}

// Namespace trace / scripts\engine\trace
// Params 0
// Checksum 0x0, Offset: 0x1f30
// Size: 0xb6
function create_all_contents()
{
    content = [ "physicscontents_foliage", "physicscontents_foliage_audio", "physicscontents_edge", "physicscontents_glass", "physicscontents_water", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_ainosight", "physicscontents_clipshot", "physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_aiclip", "physicscontents_trigger", "physicscontents_vehicle", "physicscontents_useclip" ];
    return physics_createcontents( content );
}

// Namespace trace / scripts\engine\trace
// Params 1
// Checksum 0x0, Offset: 0x1fef
// Size: 0x41
function convert_surface_flag( trace )
{
    var_ea126d64fbd440ef = physics_getsurfacetypefromflags( trace[ "surfaceflags" ] );
    trace[ "surfaceindex" ] = var_ea126d64fbd440ef[ "index" ];
    trace[ "surfacetype" ] = var_ea126d64fbd440ef[ "name" ];
    return trace;
}

// Namespace trace / scripts\engine\trace
// Params 5
// Checksum 0x0, Offset: 0x2039
// Size: 0xbe
function convert_capsule_data( var_cc43f8a28dc3bc22, var_b26c88a9b9f4ef65, radius, height, angles )
{
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    half_height = height * 0.5;
    forward = anglestoforward( angles );
    up = anglestoup( angles );
    capsule_data = [];
    capsule_data[ "trace_start" ] = var_cc43f8a28dc3bc22 + up * half_height;
    
    if ( isdefined( var_b26c88a9b9f4ef65 ) )
    {
        capsule_data[ "trace_end" ] = var_b26c88a9b9f4ef65 + up * half_height;
    }
    
    capsule_data[ "radius" ] = radius;
    capsule_data[ "angles" ] = angles;
    capsule_data[ "half_height" ] = half_height;
    return capsule_data;
}

/#

    // Namespace trace / scripts\engine\trace
    // Params 4
    // Checksum 0x0, Offset: 0x2100
    // Size: 0xcf, Type: dev
    function draw_trace( trace, color, display_details, duration )
    {
        if ( !isdefined( trace ) )
        {
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( isdefined( trace[ "<dev string:x39>" ] ) )
        {
            draw_trace_type( trace[ "<dev string:x39>" ], color, duration );
        }
        
        if ( isdefined( trace[ 0 ] ) )
        {
            foreach ( t in trace )
            {
                thread draw_trace_hit( t, trace[ "<dev string:x39>" ], color, display_details, duration );
            }
            
            return;
        }
        
        thread draw_trace_hit( trace, trace[ "<dev string:x39>" ], color, display_details, duration );
    }

    // Namespace trace / scripts\engine\trace
    // Params 5
    // Checksum 0x0, Offset: 0x21d7
    // Size: 0x3d1, Type: dev
    function draw_trace_hit( trace, var_42ef1b9ce9e7de9c, color, display_details, duration )
    {
        if ( !isdefined( duration ) )
        {
            duration = 1;
        }
        
        if ( isdefined( trace[ "<dev string:x43>" ] ) )
        {
            half_color = color * 0.25;
            is_white = gettime() / 50 / 2 == int( gettime() / 50 / 2 );
            
            if ( is_white )
            {
                color = ( 1, 1, 1 );
            }
            
            sphere( trace[ "<dev string:x43>" ], 5, color, 1, duration );
            line( trace[ "<dev string:x43>" ], trace[ "<dev string:x43>" ] + trace[ "<dev string:x4c>" ] * 15, color, 1, 1, duration );
            
            if ( isdefined( display_details ) && display_details )
            {
                cam_angles = level.player getplayerangles();
                cam_up = anglestoup( cam_angles );
                text_scale = 0.25;
                new_line = 11 * text_scale;
                normal_len = 15;
                
                if ( isdefined( trace[ "<dev string:x53>" ] ) )
                {
                    normal_len = trace[ "<dev string:x53>" ];
                }
                
                text_pos = trace[ "<dev string:x43>" ] + trace[ "<dev string:x4c>" ] * normal_len;
                print3d( text_pos, "<dev string:x5c>" + trace[ "<dev string:x43>" ], ( 1, 1, 1 ), 1, text_scale, duration );
                
                if ( isdefined( trace[ "<dev string:x68>" ] ) )
                {
                    print3d( text_pos - cam_up * new_line * 1, "<dev string:x77>" + trace[ "<dev string:x68>" ], ( 1, 1, 1 ), 1, text_scale, duration );
                }
                else
                {
                    print3d( text_pos - cam_up * new_line * 1, "<dev string:x83>", ( 1, 1, 1 ), 1, text_scale, duration );
                }
                
                print3d( text_pos - cam_up * new_line * 2, "<dev string:x95>" + trace[ "<dev string:x4c>" ], ( 1, 1, 1 ), 1, text_scale, duration );
                
                if ( isdefined( trace[ "<dev string:x9e>" ] ) )
                {
                    print3d( text_pos - cam_up * new_line * 3, "<dev string:xa7>" + trace[ "<dev string:x9e>" ], ( 1, 1, 1 ), 1, text_scale, duration );
                }
                else if ( isdefined( trace[ "<dev string:x53>" ] ) )
                {
                    print3d( text_pos - cam_up * new_line * 3, "<dev string:xb2>" + trace[ "<dev string:x53>" ], ( 1, 1, 1 ), 1, text_scale, duration );
                }
                else
                {
                    print3d( text_pos - cam_up * new_line * 3, "<dev string:xbd>", ( 1, 1, 1 ), 1, text_scale, duration );
                }
                
                if ( isdefined( trace[ "<dev string:xc4>" ] ) )
                {
                    print3d( text_pos - cam_up * new_line * 4, "<dev string:xd0>" + trace[ "<dev string:xc4>" ], ( 1, 1, 1 ), 1, text_scale, duration );
                }
                else
                {
                    print3d( text_pos - cam_up * new_line * 4, "<dev string:xdf>", ( 1, 1, 1 ), 1, text_scale, duration );
                }
                
                if ( isdefined( trace[ "<dev string:xfe>" ] ) )
                {
                    print3d( text_pos - cam_up * new_line * 5, "<dev string:x105>", ( 1, 1, 1 ), 1, text_scale, duration );
                    print3d( text_pos - cam_up * new_line * 6, "<dev string:x117>" + trace[ "<dev string:xfe>" ] getentitynumber(), ( 1, 1, 1 ), 1, text_scale, duration );
                    print3d( text_pos - cam_up * new_line * 7, "<dev string:x127>" + trace[ "<dev string:xfe>" ].classname, ( 1, 1, 1 ), 1, text_scale, duration );
                    return;
                }
                
                print3d( text_pos - cam_up * new_line * 5, "<dev string:x136>", ( 1, 1, 1 ), 1, text_scale, duration );
            }
        }
    }

    // Namespace trace / scripts\engine\trace
    // Params 3
    // Checksum 0x0, Offset: 0x25b0
    // Size: 0x3b5, Type: dev
    function draw_trace_type( debugdata, color, duration )
    {
        if ( !isdefined( duration ) )
        {
            duration = 1;
        }
        
        half_color = color * 0.75;
        no_color = color * 0.1;
        start = debugdata[ "<dev string:x149>" ];
        
        if ( debugdata[ "<dev string:x14f>" ] == "<dev string:x1c>" )
        {
            end = debugdata[ "<dev string:x154>" ];
            dist = distance( debugdata[ "<dev string:x149>" ], debugdata[ "<dev string:x154>" ] );
            sphere( start, 0.15, no_color, 1, duration );
            sphere( end, 0.15, half_color, 1, duration );
            line( start, end, no_color, 1, 0, duration );
            line( start, end, half_color, 1, 1, duration );
            return;
        }
        
        if ( debugdata[ "<dev string:x14f>" ] == "<dev string:x20>" )
        {
            radius = debugdata[ "<dev string:x158>" ];
            
            if ( isdefined( debugdata[ "<dev string:x154>" ] ) )
            {
                end = debugdata[ "<dev string:x154>" ];
                dist = distance( debugdata[ "<dev string:x149>" ], debugdata[ "<dev string:x154>" ] );
                count = max( ceil( dist / 128 ), 1 );
                
                for ( i = 0; i <= count ; i++ )
                {
                    sphere( vectorlerp( start, end, i / count ), radius, no_color, 0, duration );
                    sphere( vectorlerp( start, end, i / count ), radius, half_color, 1, duration );
                }
                
                line( start, end, no_color, 1, 0, duration );
                line( start, end, half_color, 1, 1, duration );
            }
            else
            {
                sphere( start, radius, no_color, 0, duration );
                sphere( start, radius, half_color, 1, duration );
            }
            
            return;
        }
        
        if ( debugdata[ "<dev string:x14f>" ] == "<dev string:x27>" || debugdata[ "<dev string:x14f>" ] == "<dev string:x2f>" )
        {
            if ( debugdata[ "<dev string:x14f>" ] == "<dev string:x2f>" & isdefined( debugdata[ "<dev string:x2f>" ] ) )
            {
                angles = debugdata[ "<dev string:x15f>" ];
                capsule_data = debugdata[ "<dev string:x2f>" ] physics_getcharactercollisioncapsule();
                radius = capsule_data[ "<dev string:x158>" ];
                height = capsule_data[ "<dev string:x166>" ] * 2;
            }
            else
            {
                radius = debugdata[ "<dev string:x158>" ];
                angles = debugdata[ "<dev string:x15f>" ];
                height = debugdata[ "<dev string:x172>" ];
            }
            
            if ( isdefined( debugdata[ "<dev string:x154>" ] ) )
            {
                end = debugdata[ "<dev string:x154>" ];
                dist = distance( debugdata[ "<dev string:x149>" ], debugdata[ "<dev string:x154>" ] );
                count = max( ceil( dist / 128 ), 1 );
                
                for ( i = 0; i <= count ; i++ )
                {
                    draw_capsule( vectorlerp( start, end, i / count ), radius, height, angles, no_color, 0, duration );
                    draw_capsule( vectorlerp( start, end, i / count ), radius, height, angles, half_color, 1, duration );
                }
                
                up = anglestoup( angles );
                start_top = start + up * height;
                end_top = end + up * height;
                line( start, end, no_color, 1, 0, duration );
                line( start, end, half_color, 1, 1, duration );
                line( start_top, end_top, no_color, 1, 0, duration );
                line( start_top, end_top, half_color, 1, 1, duration );
                return;
            }
            
            draw_capsule( start, radius, height, angles, no_color, 0 );
        }
    }

#/

// Namespace trace / scripts\engine\trace
// Params 1
// Checksum 0x0, Offset: 0x296d
// Size: 0x7d
function internal_pack_default_trace( pos )
{
    trace = [];
    trace[ "fraction" ] = 1;
    trace[ "surfaceflags" ] = 0;
    trace[ "distance" ] = 0;
    trace[ "position" ] = pos;
    trace[ "shape_position" ] = pos;
    trace[ "normal" ] = ( 0, 0, 0 );
    trace[ "contact_normal" ] = ( 0, 0, 0 );
    trace[ "hittype" ] = "hittype_none";
    return trace;
}

/#

    // Namespace trace / scripts\engine\trace
    // Params 9
    // Checksum 0x0, Offset: 0x29f3
    // Size: 0xcb, Type: dev
    function internal_create_debug_data( trace, type, start, end, radius, height, angles, search_distance, character )
    {
        trace[ "<dev string:x39>" ][ "<dev string:x14f>" ] = type;
        trace[ "<dev string:x39>" ][ "<dev string:x149>" ] = start;
        trace[ "<dev string:x39>" ][ "<dev string:x154>" ] = end;
        trace[ "<dev string:x39>" ][ "<dev string:x158>" ] = radius;
        trace[ "<dev string:x39>" ][ "<dev string:x172>" ] = height;
        trace[ "<dev string:x39>" ][ "<dev string:x15f>" ] = angles;
        trace[ "<dev string:x39>" ][ "<dev string:x179>" ] = search_distance;
        trace[ "<dev string:x39>" ][ "<dev string:x2f>" ] = character;
        return trace;
    }

#/
