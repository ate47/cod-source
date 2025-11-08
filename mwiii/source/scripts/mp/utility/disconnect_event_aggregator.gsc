#namespace disconnect_event_aggregator;

// Namespace disconnect_event_aggregator / scripts\mp\utility\disconnect_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0x88
// Size: 0x75
function rundisconnectcallbacks( player )
{
    if ( !isdefined( level.ondisconnecteventcallbacks ) )
    {
        level.ondisconnecteventcallbacks = [];
    }
    
    foreach ( callback in level.ondisconnecteventcallbacks )
    {
        level thread [[ callback ]]( player );
    }
}

// Namespace disconnect_event_aggregator / scripts\mp\utility\disconnect_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0x105
// Size: 0x75
function function_fab0966a8fb0e314( player )
{
    if ( !isdefined( level.var_2f907afe1ed3f832 ) )
    {
        level.var_2f907afe1ed3f832 = [];
    }
    
    foreach ( callback in level.var_2f907afe1ed3f832 )
    {
        level thread [[ callback ]]( player );
    }
}

// Namespace disconnect_event_aggregator / scripts\mp\utility\disconnect_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0x182
// Size: 0x74
function function_7104b549684a0447( player )
{
    if ( !isdefined( level.var_37e3bc2c588941bb ) )
    {
        level.var_37e3bc2c588941bb = [];
    }
    
    foreach ( callback in level.var_37e3bc2c588941bb )
    {
        level [[ callback ]]( player );
    }
}

// Namespace disconnect_event_aggregator / scripts\mp\utility\disconnect_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0x1fe
// Size: 0x38
function registerondisconnecteventcallback( callback )
{
    if ( !isdefined( level.ondisconnecteventcallbacks ) )
    {
        level.ondisconnecteventcallbacks = [];
    }
    
    level.ondisconnecteventcallbacks[ level.ondisconnecteventcallbacks.size ] = callback;
}

// Namespace disconnect_event_aggregator / scripts\mp\utility\disconnect_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0x23e
// Size: 0x38
function function_18819785bafad430( callback )
{
    if ( !isdefined( level.var_2f907afe1ed3f832 ) )
    {
        level.var_2f907afe1ed3f832 = [];
    }
    
    level.var_2f907afe1ed3f832[ level.var_2f907afe1ed3f832.size ] = callback;
}

// Namespace disconnect_event_aggregator / scripts\mp\utility\disconnect_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0x27e
// Size: 0x38
function function_5b91df923c38392b( callback )
{
    if ( !isdefined( level.var_37e3bc2c588941bb ) )
    {
        level.var_37e3bc2c588941bb = [];
    }
    
    level.var_37e3bc2c588941bb[ level.var_37e3bc2c588941bb.size ] = callback;
}

