#using scripts\engine\utility;

#namespace easing;

// Namespace easing / scripts\engine\easing
// Params 0
// Checksum 0x0, Offset: 0xd9
// Size: 0x108
function ease_init()
{
    level.ease_funcs = [];
    level.ease_funcs[ "linear" ] = &ease_linear;
    level.ease_funcs[ "power" ] = &ease_power;
    level.ease_funcs[ "quadratic" ] = &ease_quadratic;
    level.ease_funcs[ "cubic" ] = &ease_cubic;
    level.ease_funcs[ "quartic" ] = &ease_quartic;
    level.ease_funcs[ "quintic" ] = &ease_quintic;
    level.ease_funcs[ "exponential" ] = &ease_exponential;
    level.ease_funcs[ "logarithmic" ] = &ease_logarithmic;
    level.ease_funcs[ "sine" ] = &ease_sine;
    level.ease_funcs[ "back" ] = &ease_back;
    level.ease_funcs[ "elastic" ] = &ease_elastic;
    level.ease_funcs[ "bounce" ] = &ease_bounce;
}

// Namespace easing / scripts\engine\easing
// Params 5
// Checksum 0x0, Offset: 0x1e9
// Size: 0x38
function ease_linear( start, end, pct, ease_in, ease_out )
{
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing / scripts\engine\easing
// Params 6
// Checksum 0x0, Offset: 0x22a
// Size: 0x4b
function ease_power( start, end, pct, ease_in, ease_out, power )
{
    pct = easepower( pct, power, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing / scripts\engine\easing
// Params 5
// Checksum 0x0, Offset: 0x27e
// Size: 0x44
function ease_quadratic( start, end, pct, ease_in, ease_out )
{
    pct = easepower( pct, 2, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing / scripts\engine\easing
// Params 5
// Checksum 0x0, Offset: 0x2cb
// Size: 0x44
function ease_cubic( start, end, pct, ease_in, ease_out )
{
    pct = easepower( pct, 3, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing / scripts\engine\easing
// Params 5
// Checksum 0x0, Offset: 0x318
// Size: 0x44
function ease_quartic( start, end, pct, ease_in, ease_out )
{
    pct = easepower( pct, 4, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing / scripts\engine\easing
// Params 5
// Checksum 0x0, Offset: 0x365
// Size: 0x44
function ease_quintic( start, end, pct, ease_in, ease_out )
{
    pct = easepower( pct, 5, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing / scripts\engine\easing
// Params 6
// Checksum 0x0, Offset: 0x3b2
// Size: 0x4b
function ease_exponential( start, end, pct, ease_in, ease_out, scale )
{
    pct = easeexponential( pct, scale, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing / scripts\engine\easing
// Params 6
// Checksum 0x0, Offset: 0x406
// Size: 0x4b
function ease_logarithmic( start, end, pct, ease_in, ease_out, log_base )
{
    pct = easelogarithmic( pct, log_base, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing / scripts\engine\easing
// Params 5
// Checksum 0x0, Offset: 0x45a
// Size: 0x42
function ease_sine( start, end, pct, ease_in, ease_out )
{
    pct = easesine( pct, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing / scripts\engine\easing
// Params 7
// Checksum 0x0, Offset: 0x4a5
// Size: 0x55
function ease_back( start, end, pct, ease_in, ease_out, overshoot_scalar, power )
{
    pct = easeback( pct, overshoot_scalar, power, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing / scripts\engine\easing
// Params 8
// Checksum 0x0, Offset: 0x503
// Size: 0x5f
function ease_elastic( start, end, pct, ease_in, ease_out, amplitude, frequency, fade_scalar )
{
    pct = easeelastic( pct, amplitude, frequency, fade_scalar, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing / scripts\engine\easing
// Params 7
// Checksum 0x0, Offset: 0x56b
// Size: 0x55
function ease_bounce( start, end, pct, ease_in, ease_out, bounces, decay_scalar )
{
    pct = easebounce( pct, bounces, decay_scalar, ease_in, ease_out );
    return ( 1 - pct ) * start + pct * end;
}

// Namespace easing / scripts\engine\easing
// Params 9
// Checksum 0x0, Offset: 0x5c9
// Size: 0x61
function ease_dvar( dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3 )
{
    function_5a51a4e5eec18b00( &setdvar, dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3 );
}

// Namespace easing / scripts\engine\easing
// Params 9
// Checksum 0x0, Offset: 0x632
// Size: 0x61
function ease_saved_dvar( dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3 )
{
    function_5a51a4e5eec18b00( &setsaveddvar, dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3 );
}

// Namespace easing / scripts\engine\easing
// Params 10, eflags: 0x4
// Checksum 0x0, Offset: 0x69b
// Size: 0x194
function private function_5a51a4e5eec18b00( dvar_func, dvar, value, time, ease_type, ease_in, ease_out, ease_param1, ease_param2, ease_param3 )
{
    assert( isdefined( level.ease_funcs ) );
    assert( isdefined( level.ease_funcs[ ease_type ] ) );
    dvar_name = getxhashhexname( dvar );
    level notify( "ease_dvar_" + dvar_name );
    level endon( "ease_dvar_" + dvar_name );
    start_value = getdvarfloat( dvar );
    cur_value = start_value;
    cur_time = 0;
    
    while ( cur_time < time )
    {
        cur_time += level.framedurationseconds;
        pct = min( 1, cur_time / time );
        
        if ( isdefined( ease_param3 ) )
        {
            cur_value = [[ level.ease_funcs[ ease_type ] ]]( start_value, value, pct, ease_in, ease_out, ease_param1, ease_param2, ease_param3 );
        }
        else if ( isdefined( ease_param2 ) )
        {
            cur_value = [[ level.ease_funcs[ ease_type ] ]]( start_value, value, pct, ease_in, ease_out, ease_param1, ease_param2 );
        }
        else if ( isdefined( ease_param1 ) )
        {
            cur_value = [[ level.ease_funcs[ ease_type ] ]]( start_value, value, pct, ease_in, ease_out, ease_param1 );
        }
        else
        {
            cur_value = [[ level.ease_funcs[ ease_type ] ]]( start_value, value, pct, ease_in, ease_out );
        }
        
        builtin [[ dvar_func ]]( dvar, cur_value );
        waitframe();
    }
    
    builtin [[ dvar_func ]]( dvar, value );
}

