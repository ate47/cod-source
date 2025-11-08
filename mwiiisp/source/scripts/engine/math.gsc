#using scripts\engine\math;
#using scripts\engine\utility;

#namespace math;

// Namespace math / scripts\engine\math
// Params 2
// Checksum 0x0, Offset: 0x175
// Size: 0x36
function anglebetweenvectors( vector1, vector2 )
{
    return acos( clamp( vectordot( vector1, vector2 ) / length( vector1 ) * length( vector2 ), -1, 1 ) );
}

// Namespace math / scripts\engine\math
// Params 2
// Checksum 0x0, Offset: 0x1b4
// Size: 0x1f
function anglebetweenvectorsunit( v1, v2 )
{
    return acos( vectordot( v1, v2 ) );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x1dc
// Size: 0x83
function anglebetweenvectorssigned( vector1, vector2, reference_norm )
{
    vec1 = vectornormalize( vector1 );
    vec2 = vectornormalize( vector2 );
    angle = acos( clamp( vectordot( vec1, vec2 ), -1, 1 ) );
    cross = vectorcross( vec1, vec2 );
    
    if ( vectordot( cross, reference_norm ) < 0 )
    {
        angle *= -1;
    }
    
    return angle;
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x268
// Size: 0x22
function lerp( from, to, frac )
{
    return from + ( to - from ) * frac;
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x293
// Size: 0x22
function lerp_fraction( from, to, n )
{
    return ( n - from ) / ( to - from );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x2be
// Size: 0x47
function fake_slerp( from, to, fraction )
{
    return ( angle_lerp( from[ 0 ], to[ 0 ], fraction ), angle_lerp( from[ 1 ], to[ 1 ], fraction ), angle_lerp( from[ 2 ], to[ 2 ], fraction ) );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x30e
// Size: 0x2c
function angle_lerp( from, to, fraction )
{
    return angleclamp( from + angleclamp180( to - from ) * fraction );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x343
// Size: 0x52
function get_dot( start_origin, start_angles, end_origin )
{
    normal = vectornormalize( end_origin - start_origin );
    forward = anglestoforward( start_angles );
    dot = vectordot( forward, normal );
    return dot;
}

// Namespace math / scripts\engine\math
// Params 2
// Checksum 0x0, Offset: 0x39e
// Size: 0x2a
function vector_project_onto_plane( vector, normal )
{
    return vector - vectordot( normal, vector ) / squared( length( normal ) ) * normal;
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x3d1
// Size: 0x61
function vector_project_endpoint( origin, angles, len )
{
    assert( isdefined( origin ) );
    assert( isdefined( angles ) );
    assert( isdefined( len ) );
    dir = anglestoforward( angles );
    dir *= len;
    end = origin + dir;
    return end;
}

// Namespace math / scripts\engine\math
// Params 2
// Checksum 0x0, Offset: 0x43b
// Size: 0x25
function vector_reflect( vector, normal )
{
    return vectornormalize( 2 * vector_project_onto_plane( vector, normal ) - vector );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x469
// Size: 0x71
function vector_area_parallelogram( v, a, b )
{
    assert( isdefined( v ) );
    assert( isdefined( a ) );
    assert( isdefined( b ) );
    return a[ 0 ] * b[ 1 ] - a[ 1 ] * b[ 0 ] + b[ 0 ] * v[ 1 ] - v[ 0 ] * b[ 1 ] + v[ 0 ] * a[ 1 ] - a[ 0 ] * v[ 1 ];
}

// Namespace math / scripts\engine\math
// Params 2
// Checksum 0x0, Offset: 0x4e3
// Size: 0x1f
function scalar_projection( veca, vecb )
{
    return vectordot( vectornormalize( veca ), vecb );
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0x50b
// Size: 0x80
function get_point_on_parabola( start, end, height, t )
{
    parabolic_t = t * 2 - 1;
    direction = end - start;
    up = ( 0, 0, 1 );
    result = start + t * direction;
    result += ( parabolic_t * parabolic_t * -1 + 1 ) * height * up;
    return result;
}

// Namespace math / scripts\engine\math
// Params 2
// Checksum 0x0, Offset: 0x594
// Size: 0x3f
function get_mid_point( point_1, point_2 )
{
    return ( ( point_1[ 0 ] + point_2[ 0 ] ) * 0.5, ( point_1[ 1 ] + point_2[ 1 ] ) * 0.5, ( point_1[ 2 ] + point_2[ 2 ] ) * 0.5 );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x5dc
// Size: 0xd7
function round_float( value, precision, down )
{
    assertex( isdefined( value ), "value must be defined." );
    assertex( isdefined( precision ), "precision must be defined." );
    assertex( precision == int( precision ), "precision must be an integer." );
    precision = int( precision );
    
    if ( precision < 0 || precision > 4 )
    {
        assertmsg( "Precision value must be an integer that is >= 0 and <= 4. This was passed in: " + precision );
        return value;
    }
    
    decimal_offset = 1;
    
    for ( i = 1; i <= precision ; i++ )
    {
        decimal_offset *= 10;
    }
    
    var_f27d0b5c6511561e = value * decimal_offset;
    
    if ( !isdefined( down ) || down )
    {
        var_f27d0b5c6511561e = floor( var_f27d0b5c6511561e );
    }
    else
    {
        var_f27d0b5c6511561e = ceil( var_f27d0b5c6511561e );
    }
    
    value = var_f27d0b5c6511561e / decimal_offset;
    return value;
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x6bc
// Size: 0x43
function round_millisec_on_sec( value, precision, down )
{
    value_seconds = value / 1000;
    value_seconds = round_float( value_seconds, precision, down );
    value = value_seconds * 1000;
    return int( value );
}

// Namespace math / scripts\engine\math
// Params 5
// Checksum 0x0, Offset: 0x708
// Size: 0x38
function remap( value, min1, max1, min2, max2 )
{
    return min2 + ( value - min1 ) * ( max2 - min2 ) / ( max1 - min1 );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x749
// Size: 0x7c
function normalize_value( clamp_a, clamp_b, var_a8fe33ce005d9c1e )
{
    if ( clamp_a > clamp_b )
    {
        upper = clamp_a;
        clamp_a = clamp_b;
        clamp_b = upper;
    }
    
    if ( var_a8fe33ce005d9c1e > clamp_b )
    {
        return 1;
    }
    else if ( var_a8fe33ce005d9c1e < clamp_a )
    {
        return 0;
    }
    else if ( clamp_a == clamp_b )
    {
        assertmsg( "clamp_a <" + clamp_a + "> and <" + clamp_b + " MUST be different values." );
    }
    
    return ( var_a8fe33ce005d9c1e - clamp_a ) / ( clamp_b - clamp_a );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x7ce
// Size: 0x27
function normalized_to_growth_clamps( min, max, value )
{
    return ( max - min ) * squared( value ) + min;
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x7fe
// Size: 0x27
function normalized_to_decay_clamps( min, max, value )
{
    return normalized_to_growth_clamps( min, max, 1 - value );
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x82e
// Size: 0x1d
function normalized_parabola( x )
{
    return -1 * squared( 2 * x - 1 ) + 1;
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x854
// Size: 0x3e
function normalized_sin_wave( x )
{
    y = x * 2 * 3.14159 - 1.5708;
    y = ( sin( radians_to_degrees( y ) ) + 1 ) * 0.5;
    return y;
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x89b
// Size: 0x38
function normalized_cos_wave( x )
{
    y = x * 2 * 3.14159;
    y = ( cos( radians_to_degrees( y ) ) + 1 ) * 0.5;
    return y;
}

// Namespace math / scripts\engine\math
// Params 2
// Checksum 0x0, Offset: 0x8dc
// Size: 0x32
function normalized_offset( value, offsetamount )
{
    value += offsetamount;
    
    if ( value > 1 )
    {
        value -= 1;
    }
    
    if ( value < 0 )
    {
        value += 1;
    }
    
    return value;
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x917
// Size: 0x12
function radians_to_degrees( radians )
{
    return radians * 57.2958;
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x932
// Size: 0x12
function degrees_to_radians( degrees )
{
    return degrees * 0.0174533;
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x94d
// Size: 0x25
function factor_value( min_val, max_val, factor_val )
{
    return max_val * factor_val + min_val * ( 1 - factor_val );
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x97b
// Size: 0x55
function function_889bef0ad1600791( num )
{
    if ( num < 0.5 )
    {
        num *= 2;
        num = normalized_float_smooth_in( num );
        num *= 0.5;
    }
    else
    {
        num = ( num - 0.5 ) * 2;
        num = normalized_float_smooth_out( num );
        num = num * 0.5 + 0.5;
    }
    
    return num;
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x9d9
// Size: 0xe
function normalized_float_smooth_in( num )
{
    return num * num;
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x9f0
// Size: 0x1d
function normalized_float_smooth_out( num )
{
    num = 1 - num;
    num *= num;
    num = 1 - num;
    return num;
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0xa16
// Size: 0x89
function line_to_plane_intersection( var_d747962793d54b7d, var_d747932793d544e4, plane_point, plane_normal )
{
    d = vectordot( plane_normal, plane_point );
    ray = var_d747932793d544e4 - var_d747962793d54b7d;
    var_f93d442fee36ceed = vectordot( plane_normal, ray );
    
    if ( var_f93d442fee36ceed == 0 )
    {
        return undefined;
    }
    
    t = ( d - vectordot( plane_normal, var_d747962793d54b7d ) ) / var_f93d442fee36ceed;
    intersection_point = var_d747962793d54b7d + ray * t;
    return intersection_point;
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0xaa8
// Size: 0x61, Type: bool
function function_d3daf615a9f61ea6( point, aabb_min, aabb_max )
{
    return point[ 0 ] <= aabb_max[ 0 ] && point[ 0 ] >= aabb_min[ 0 ] && point[ 1 ] <= aabb_max[ 1 ] && point[ 1 ] >= aabb_min[ 1 ] && point[ 2 ] <= aabb_max[ 2 ] && point[ 2 ] >= aabb_min[ 2 ];
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0xb12
// Size: 0x34
function ray_to_plane_intersection_distance( rayorigin, raydirection, var_d74074ad5396e58a, planenormal )
{
    return vectordot( var_d74074ad5396e58a - rayorigin, planenormal ) / vectordot( raydirection, planenormal );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0xb4f
// Size: 0x92, Type: bool
function function_b2858ff2d7212ba7( point, start, end )
{
    point2d = ( point[ 0 ], point[ 1 ], 0 );
    start2d = ( start[ 0 ], start[ 1 ], 0 );
    end2d = ( end[ 0 ], end[ 1 ], 0 );
    topoint = vectornormalize( point2d - start2d );
    forward = vectornormalize( end2d - start2d );
    dot = vectordot( topoint, forward );
    return dot > 0;
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0xbea
// Size: 0x208
function function_d2c0d8330ab7ad7f( start, end, circlecenter, circleradius )
{
    x1 = start[ 0 ] - circlecenter[ 0 ];
    y1 = start[ 1 ] - circlecenter[ 1 ];
    x2 = end[ 0 ] - circlecenter[ 0 ];
    y2 = end[ 1 ] - circlecenter[ 1 ];
    r = float( circleradius );
    dx = x2 - x1;
    dy = y2 - y1;
    dr = dx * dx + dy * dy;
    d = x1 * y2 - x2 * y1;
    dis = r * r * dr - d * d;
    
    if ( dis < 0 )
    {
        return;
    }
    
    if ( dis == 0 )
    {
        pointx = d * dy / dr + circlecenter[ 0 ];
        pointy = -1 * d * dx / dr + circlecenter[ 1 ];
        return [ ( pointx, pointy, 0 ) ];
    }
    
    sqrtdis = sqrt( dis );
    xa = d * dy;
    xb = scripts\engine\utility::sign( dy ) * dx * sqrtdis;
    point1x = ( xa + xb ) / dr + circlecenter[ 0 ];
    point2x = ( xa - xb ) / dr + circlecenter[ 0 ];
    ya = -1 * d * dx;
    yb = abs( dy ) * sqrtdis;
    point1y = ( ya + yb ) / dr + circlecenter[ 1 ];
    point2y = ( ya - yb ) / dr + circlecenter[ 1 ];
    return [ ( point1x, point1y, 0 ), ( point2x, point2y, 0 ) ];
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0xdfa
// Size: 0xfe
function function_cc2ad02dcf5030d8( start, end, circleorigin, circleradius )
{
    result = function_d2c0d8330ab7ad7f( start, end, circleorigin, circleradius );
    
    if ( !isdefined( result ) )
    {
        return;
    }
    
    if ( result.size == 1 )
    {
        if ( function_b2858ff2d7212ba7( result[ 0 ], start, end ) )
        {
            return result;
        }
        
        return;
    }
    
    pt1valid = function_b2858ff2d7212ba7( result[ 0 ], start, end );
    pt2valid = function_b2858ff2d7212ba7( result[ 1 ], start, end );
    
    if ( !pt1valid && !pt2valid )
    {
        return;
    }
    
    if ( pt1valid && !pt2valid )
    {
        return result[ 0 ];
    }
    
    if ( pt2valid && !pt1valid )
    {
        return result[ 1 ];
    }
    
    distsq1 = distance2dsquared( start, result[ 0 ] );
    distsq2 = distance2dsquared( start, result[ 1 ] );
    
    if ( distsq1 < distsq2 )
    {
        return result[ 0 ];
    }
    
    return result[ 1 ];
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0xf00
// Size: 0x8b, Type: bool
function segmentvssphere( pointa, pointb, spherecenter, sphereradius )
{
    if ( pointa == pointb )
    {
        return false;
    }
    
    var_1b1c7be2a8e1295c = spherecenter - pointa;
    atob = pointb - pointa;
    atobscalar = clamp( vectordot( var_1b1c7be2a8e1295c, atob ) / vectordot( atob, atob ), 0, 1 );
    closestpoint = pointa + atob * atobscalar;
    return lengthsquared( spherecenter - closestpoint ) <= sphereradius * sphereradius;
}

// Namespace math / scripts\engine\math
// Params 8
// Checksum 0x0, Offset: 0xf94
// Size: 0xae, Type: bool
function pointvscone( point, coneorigin, coneforward, coneup, conelen, conelenoffset, coneang, conehalfheight )
{
    starttopoint = point - coneorigin;
    starttopointforward = vectordot( starttopoint, coneforward );
    starttopointup = vectordot( starttopoint, coneup );
    
    if ( starttopointforward > conelen )
    {
        return false;
    }
    
    if ( starttopointforward < conelenoffset )
    {
        return false;
    }
    
    if ( isdefined( conehalfheight ) )
    {
        if ( abs( starttopointup ) > conehalfheight )
        {
            return false;
        }
    }
    
    if ( anglebetweenvectors( coneforward, starttopoint ) > coneang )
    {
        return false;
    }
    
    return true;
}

// Namespace math / scripts\engine\math
// Params 5
// Checksum 0x0, Offset: 0x104b
// Size: 0x7e, Type: bool
function pointvscylinder( point, radiussqr, height, origin, up )
{
    btwn = point - origin;
    vmag = vectordot( btwn, up );
    
    if ( vmag < 0 || vmag > height )
    {
        return false;
    }
    
    btwn -= vmag * up;
    var_96fb14702ae758b4 = lengthsquared( btwn );
    
    if ( var_96fb14702ae758b4 > radiussqr )
    {
        return false;
    }
    
    return true;
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x10d2
// Size: 0x44
function point_side_of_line2d( v, a, b )
{
    area = vector_area_parallelogram( v, a, b );
    
    if ( area > 0 )
    {
        return "left";
    }
    
    return "right";
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x111f
// Size: 0x4c
function wrap( min, max, value )
{
    range_size = max - min + 1;
    
    if ( value < min )
    {
        value += range_size * int( ( min - value ) / range_size + 1 );
    }
    
    return min + ( value - min ) % range_size;
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x1174
// Size: 0x92
function point_in_fov( origin, fov, checkpitch )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( !isdefined( fov ) )
    {
        fov = 0.766;
    }
    
    if ( isplayer( self ) )
    {
        forward = anglestoforward( self getplayerangles( !istrue( checkpitch ) ) );
    }
    else
    {
        forward = anglestoforward( self.angles );
    }
    
    normalvec = vectornormalize( origin - self.origin );
    dot = vectordot( forward, normalvec );
    return dot > fov;
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0x120f
// Size: 0x66, Type: bool
function within_fov_2d( start_origin, start_angles, end_origin, fov )
{
    normal = vectornormalize( ( end_origin[ 0 ], end_origin[ 1 ], 0 ) - ( start_origin[ 0 ], start_origin[ 1 ], 0 ) );
    forward = anglestoforward( ( 0, start_angles[ 1 ], 0 ) );
    return vectordot( forward, normal ) >= fov;
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x127e
// Size: 0x8a, Type: bool
function is_point_in_front( point )
{
    dot = 0;
    
    if ( isent( self ) && isplayer( self ) )
    {
        to_point = point - self getorigin();
        forward = anglestoforward( self getplayerangles( 1 ) );
        dot = vectordot( to_point, forward );
    }
    else
    {
        to_point = point - self.origin;
        forward = anglestoforward( self.angles );
        dot = vectordot( to_point, forward );
    }
    
    return dot > 0;
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x1311
// Size: 0x80, Type: bool
function is_point_on_right( point )
{
    dot = 0;
    
    if ( isplayer( self ) )
    {
        to_point = point - self getorigin();
        right = anglestoright( self getplayerangles( 1 ) );
        dot = vectordot( to_point, right );
    }
    else
    {
        to_point = point - self.origin;
        right = anglestoright( self.angles );
        dot = vectordot( to_point, right );
    }
    
    return dot > 0;
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x139a
// Size: 0x56, Type: bool
function function_1c46b3e291eff242( dir, forward_vec, up_vec )
{
    if ( !isdefined( up_vec ) )
    {
        up_vec = ( 0, 0, 1 );
    }
    
    cross = vectorcross( forward_vec, up_vec );
    dot = vectordot( cross, dir );
    return dot > 0;
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0x13f9
// Size: 0xc7
function function_6c1e6433c5e5cf79( point, center, half_size, forward_angles )
{
    var_9b91a9e577670535 = point - center;
    result = center;
    axis_array = anglestoaxis( forward_angles );
    axis_vecs = [ axis_array[ "forward" ], axis_array[ "right" ], axis_array[ "up" ] ];
    
    for ( i = 0; i <= 2 ; i++ )
    {
        dist = vectordot( axis_vecs[ i ], var_9b91a9e577670535 );
        dist = clamp( dist, -1 * half_size[ i ], half_size[ i ] );
        result += dist * axis_vecs[ i ];
    }
    
    return result;
}

// Namespace math / scripts\engine\math
// Params 0
// Checksum 0x0, Offset: 0x14c9
// Size: 0x27
function random_vector_2d()
{
    var_57338c9e11b3e93 = randomfloat( 360 );
    return ( cos( var_57338c9e11b3e93 ), sin( var_57338c9e11b3e93 ), 0 );
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x14f9
// Size: 0x59
function set_matrix_from_up( new_up )
{
    current_foward = anglestoforward( self.angles );
    new_right = vectorcross( current_foward, new_up );
    new_forward = vectorcross( new_up, new_right );
    self.angles = axistoangles( new_forward, new_right, new_up );
}

// Namespace math / scripts\engine\math
// Params 2
// Checksum 0x0, Offset: 0x155a
// Size: 0x34
function set_matrix_from_up_and_angles( new_up, var_8583b7021ec2367 )
{
    if ( !isdefined( var_8583b7021ec2367 ) )
    {
        var_8583b7021ec2367 = self.angles;
    }
    
    self.angles = build_matrix_from_up_and_angles( new_up, var_8583b7021ec2367 );
}

// Namespace math / scripts\engine\math
// Params 2
// Checksum 0x0, Offset: 0x1596
// Size: 0x6b
function build_matrix_from_up_and_angles( new_up, var_8583b7021ec2367 )
{
    var_89752207bcf12f45 = acos( -1 * vectordot( anglestoforward( var_8583b7021ec2367 ), new_up ) );
    new_forward = anglestoup( var_8583b7021ec2367 + ( var_89752207bcf12f45, 0, 0 ) );
    new_right = vectorcross( new_forward, new_up );
    new_forward = vectorcross( new_up, new_right );
    return axistoangles( new_forward, new_right, new_up );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x160a
// Size: 0x26
function critically_damped_move_to( target_pos, spring_factor, start_speed )
{
    thread critically_damped_move_to_thread( target_pos, spring_factor, start_speed );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x1638
// Size: 0xa4
function critically_damped_move_to_thread( target_pos, spring_factor, start_speed )
{
    self endon( "death" );
    self endon( "stop_spring" );
    
    if ( !isdefined( start_speed ) )
    {
        start_speed = 1;
    }
    
    spring_index = spring_make_critically_damped( spring_factor, self.origin, anglestoforward( self.angles ) * start_speed );
    
    while ( distancesquared( self.origin, target_pos ) > squared( 0.1 ) )
    {
        self.origin = spring_update( spring_index, target_pos );
        wait 0.05;
    }
    
    self notify( "movedone" );
    spring_delete( spring_index );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x16e4
// Size: 0x26
function critically_damped_move_and_rotate_to( target_pos, spring_factor, start_speed )
{
    thread critically_damped_move_and_rotate_to_thread( target_pos, spring_factor, start_speed );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x1712
// Size: 0xb9
function critically_damped_move_and_rotate_to_thread( target_pos, spring_factor, start_speed )
{
    self endon( "death" );
    self endon( "stop_spring" );
    
    if ( !isdefined( start_speed ) )
    {
        start_speed = 1;
    }
    
    spring_index = spring_make_critically_damped( spring_factor, self.origin, anglestoforward( self.angles ) * start_speed );
    
    while ( distancesquared( self.origin, target_pos ) > squared( 0.1 ) )
    {
        self.origin = spring_update( spring_index, target_pos );
        self.angles = vectortoangles( spring_get_vel( spring_index ) );
        wait 0.05;
    }
    
    self notify( "movedone" );
    spring_delete( spring_index );
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0x17d3
// Size: 0x87
function function_c5b0d1646ebc8eb3( start_point, target_point, yaw_limit, start_yaw )
{
    yaw = start_yaw;
    target_yaw = vectortoyaw( target_point - start_point );
    diff = angleclamp180( target_yaw - yaw );
    new_yaw = undefined;
    
    if ( abs( diff ) < yaw_limit )
    {
        new_yaw = target_yaw;
    }
    else
    {
        new_yaw = yaw + scripts\engine\utility::sign( diff ) * yaw_limit;
    }
    
    return int( new_yaw );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x1863
// Size: 0x59
function function_804deea7a479c83b( start_angle, target_angle, limit )
{
    diff = angleclamp180( target_angle - start_angle );
    new_angle = undefined;
    
    if ( abs( diff ) < limit )
    {
        new_angle = target_angle;
    }
    else
    {
        new_angle = start_angle + scripts\engine\utility::sign( diff ) * limit;
    }
    
    return new_angle;
}

// Namespace math / scripts\engine\math
// Params 5
// Checksum 0x0, Offset: 0x18c5
// Size: 0xb1
function function_e70fb12ac4e8f91b( center, outer_radius, inner_radius, begin_yaw, end_yaw )
{
    ratio = 0;
    
    if ( isdefined( inner_radius ) )
    {
        ratio = clamp( inner_radius / outer_radius, 0, 1 );
    }
    
    if ( !isdefined( begin_yaw ) )
    {
        begin_yaw = 0;
    }
    
    if ( !isdefined( end_yaw ) )
    {
        end_yaw = 360;
    }
    
    radius = outer_radius * sqrt( randomfloatrange( ratio * ratio, 1 ) );
    theta = randomfloatrange( begin_yaw, end_yaw );
    offset = ( cos( theta ) * radius, sin( theta ) * radius, 0 );
    return center + offset;
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0x197f
// Size: 0x2f
function over_damped_move_to( target_pos, spring_factor, spring_drag, start_speed )
{
    thread over_damped_move_to_thread( target_pos, spring_factor, spring_drag, start_speed );
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0x19b6
// Size: 0xad
function over_damped_move_to_thread( target_pos, spring_factor, spring_drag, start_speed )
{
    self endon( "death" );
    self endon( "stop_spring" );
    
    if ( !isdefined( start_speed ) )
    {
        start_speed = 1;
    }
    
    spring_index = spring_make_over_damped( spring_factor, spring_drag, self.origin, anglestoforward( self.angles ) * start_speed );
    
    while ( distancesquared( self.origin, target_pos ) > squared( 0.1 ) )
    {
        self.origin = spring_update( spring_index, target_pos );
        wait 0.05;
    }
    
    self notify( "movedone" );
    spring_delete( spring_index );
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0x1a6b
// Size: 0x2f
function under_damped_move_to( target_pos, freq, damp, start_speed )
{
    thread under_damped_move_to_thread( target_pos, freq, damp, start_speed );
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0x1aa2
// Size: 0xc8
function under_damped_move_to_thread( target_pos, freq, damp, start_speed )
{
    self endon( "death" );
    self endon( "stop_spring" );
    
    if ( !isdefined( start_speed ) )
    {
        start_speed = 1;
    }
    
    spring_index = spring_make_under_damped( freq, damp, self.origin, anglestoforward( self.angles ) * start_speed );
    
    while ( distancesquared( self.origin, target_pos ) > squared( 0.1 ) || length( spring_get_vel( spring_index ) ) < squared( 0.1 ) )
    {
        self.origin = spring_update( spring_index, target_pos );
        wait 0.05;
    }
    
    self notify( "movedone" );
    spring_delete( spring_index );
}

// Namespace math / scripts\engine\math
// Params 3
// Checksum 0x0, Offset: 0x1b72
// Size: 0xd4
function spring_make_critically_damped( spring_factor, start_pos, start_vel )
{
    spring_index = spring_add( start_pos, start_vel );
    k = spring_factor * 0.05;
    e = exp( -1 * k );
    level.springs[ spring_index ].c0 = ( k + 1 ) * e;
    level.springs[ spring_index ].c1 = e;
    level.springs[ spring_index ].c2 = -1 * k * k * e;
    level.springs[ spring_index ].c3 = ( 1 - k ) * e;
    spring_set_pos( spring_index, start_pos );
    spring_set_vel( spring_index, start_vel );
    return spring_index;
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0x1c4f
// Size: 0x1b7
function spring_make_over_damped( spring_factor, spring_drag, start_pos, start_vel )
{
    assert( spring_drag > 0 );
    spring_index = spring_add( start_pos, start_vel );
    k = spring_factor * spring_factor;
    c = -1 * sqrt( spring_drag * spring_drag + 4 * k );
    r1 = 0.5 * ( c + spring_drag );
    r2 = 0.5 * ( c - spring_drag );
    dr = r2 - r1;
    rdr = 1 / dr;
    e1 = exp( r1 * 0.05 );
    e2 = exp( r2 * 0.05 );
    de = e2 - e1;
    level.springs[ spring_index ].c1 = de * rdr;
    level.springs[ spring_index ].c0 = e1 - r1 * level.springs[ spring_index ].c1;
    level.springs[ spring_index ].c3 = ( r2 * e2 - r1 * e1 ) * rdr;
    level.springs[ spring_index ].c2 = r1 * ( e1 - level.springs[ spring_index ].c3 );
    spring_set_pos( spring_index, start_pos );
    spring_set_vel( spring_index, start_vel );
    return spring_index;
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0x1e0f
// Size: 0x16b
function spring_make_under_damped( freq, damp, start_pos, start_vel )
{
    assert( freq > 0 );
    spring_index = spring_add( start_pos, start_vel );
    h = -0.5 * damp;
    w = freq;
    e = exp( h * 0.05 ) / w;
    angle = angleclamp( w * 0.05 );
    s = sin( angle );
    c = cos( angle );
    wc = w * c;
    hs = h * s;
    level.springs[ spring_index ].c0 = e * ( wc - hs );
    level.springs[ spring_index ].c1 = e * s;
    level.springs[ spring_index ].c2 = e * -1 * s * ( h * h + w * w );
    level.springs[ spring_index ].c3 = e * ( wc + hs );
    spring_set_pos( spring_index, start_pos );
    spring_set_vel( spring_index, start_vel );
    return spring_index;
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0x1f83
// Size: 0x14e
function spring_update( spring_index, target_pos, overwrite_pos, overwrite_vel )
{
    if ( isdefined( overwrite_pos ) )
    {
        spring_set_pos( spring_index, overwrite_pos );
    }
    
    if ( isdefined( overwrite_vel ) )
    {
        spring_set_vel( spring_index, overwrite_vel );
    }
    
    adjusted_pos = level.springs[ spring_index ].pos - target_pos;
    new_pos = level.springs[ spring_index ].c0 * adjusted_pos + level.springs[ spring_index ].c1 * level.springs[ spring_index ].vel;
    new_vel = level.springs[ spring_index ].c2 * adjusted_pos + level.springs[ spring_index ].c3 * level.springs[ spring_index ].vel;
    level.springs[ spring_index ].pos = new_pos + target_pos;
    level.springs[ spring_index ].vel = new_vel;
    return level.springs[ spring_index ].pos;
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x20da
// Size: 0x16
function spring_delete( spring_index )
{
    level.springs[ spring_index ] = undefined;
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x20f8
// Size: 0x20
function spring_get_pos( spring_index )
{
    return level.springs[ spring_index ].pos;
}

// Namespace math / scripts\engine\math
// Params 1
// Checksum 0x0, Offset: 0x2121
// Size: 0x20
function spring_get_vel( spring_index )
{
    return level.springs[ spring_index ].vel;
}

// Namespace math / scripts\engine\math
// Params 0
// Checksum 0x0, Offset: 0x214a
// Size: 0x23
function spring_init()
{
    if ( !isdefined( level.springs ) )
    {
        level.springs = [];
        level.spring_count = 0;
    }
}

// Namespace math / scripts\engine\math
// Params 2
// Checksum 0x0, Offset: 0x2175
// Size: 0xd4
function spring_add( start_pos, start_vel )
{
    spring_init();
    var_e22dc56261fcf460 = level.spring_count;
    level.spring_count++;
    level.springs[ var_e22dc56261fcf460 ] = spawnstruct();
    level.springs[ var_e22dc56261fcf460 ].pos = start_pos;
    level.springs[ var_e22dc56261fcf460 ].vel = start_vel;
    level.springs[ var_e22dc56261fcf460 ].c0 = 0;
    level.springs[ var_e22dc56261fcf460 ].c1 = 0;
    level.springs[ var_e22dc56261fcf460 ].c2 = 0;
    level.springs[ var_e22dc56261fcf460 ].c3 = 0;
    return var_e22dc56261fcf460;
}

// Namespace math / scripts\engine\math
// Params 2
// Checksum 0x0, Offset: 0x2252
// Size: 0x2a
function spring_set_pos( spring_index, pos )
{
    level.springs[ spring_index ].pos = pos;
}

// Namespace math / scripts\engine\math
// Params 2
// Checksum 0x0, Offset: 0x2284
// Size: 0x2a
function spring_set_vel( spring_index, vel )
{
    level.springs[ spring_index ].vel = vel;
}

// Namespace math / scripts\engine\math
// Params 4
// Checksum 0x0, Offset: 0x22b6
// Size: 0xd5
function random_normal_distribution( mean, std_deviation, lower_bound, upper_bound )
{
    x1 = 0;
    x2 = 0;
    w = 1;
    y1 = 0;
    
    while ( w >= 1 )
    {
        x1 = 2 * randomfloatrange( 0, 1 ) - 1;
        x2 = 2 * randomfloatrange( 0, 1 ) - 1;
        w = x1 * x1 + x2 * x2;
    }
    
    w = sqrt( -2 * log( w ) / w );
    y1 = x1 * w;
    number = mean + y1 * std_deviation;
    
    if ( isdefined( lower_bound ) && number < lower_bound )
    {
        number = lower_bound;
    }
    
    if ( isdefined( upper_bound ) && number > upper_bound )
    {
        number = upper_bound;
    }
    
    return number;
}

