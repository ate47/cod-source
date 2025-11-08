#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;

#namespace telemetry;

// Namespace telemetry/telemetry_utils
// Params 2
// Checksum 0x4549a9cc, Offset: 0x90
// Size: 0x2c
function add_callback( callback_id, callback_func )
{
    callback::add_callback( callback_id, callback_func );
}

// Namespace telemetry/telemetry_utils
// Params 2
// Checksum 0xa32be86a, Offset: 0xc8
// Size: 0x7a
function function_98df8818( callback, func )
{
    if ( !isdefined( level.telemetry_callbacks ) )
    {
        level.telemetry_callbacks = [];
    }
    
    if ( !isdefined( level.telemetry_callbacks[ callback ] ) )
    {
        level.telemetry_callbacks[ callback ] = [];
    }
    
    level.telemetry_callbacks[ callback ][ level.telemetry_callbacks[ callback ].size ] = func;
}

// Namespace telemetry/telemetry_utils
// Params 2
// Checksum 0x7221740b, Offset: 0x150
// Size: 0xc8
function function_18135b72( callback, data )
{
    if ( !isdefined( level.telemetry_callbacks ) )
    {
        return;
    }
    
    if ( !isdefined( level.telemetry_callbacks[ callback ] ) )
    {
        return;
    }
    
    if ( isdefined( data ) )
    {
        for ( i = 0; i < level.telemetry_callbacks[ callback ].size ; i++ )
        {
            thread [[ level.telemetry_callbacks[ callback ][ i ] ]]( data );
        }
        
        return;
    }
    
    for ( i = 0; i < level.telemetry_callbacks[ callback ].size ; i++ )
    {
        thread [[ level.telemetry_callbacks[ callback ][ i ] ]]();
    }
}

// Namespace telemetry/telemetry_utils
// Params 0
// Checksum 0xe602d453, Offset: 0x220
// Size: 0x2c
function function_f397069a()
{
    while ( level.var_d3427749 === gettime() )
    {
        waitframe( 1 );
    }
    
    level.var_d3427749 = gettime();
}

