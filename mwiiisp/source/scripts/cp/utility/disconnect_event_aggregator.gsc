#namespace disconnect_event_aggregator;

// Namespace disconnect_event_aggregator / scripts\cp\utility\disconnect_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0x68
// Size: 0xc
function init()
{
    level.ondisconnecteventcallbacks = [];
}

// Namespace disconnect_event_aggregator / scripts\cp\utility\disconnect_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0x7c
// Size: 0x5a
function rundisconnectcallbacks( player )
{
    foreach ( callback in level.ondisconnecteventcallbacks )
    {
        level [[ callback ]]( player );
    }
}

// Namespace disconnect_event_aggregator / scripts\cp\utility\disconnect_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0xde
// Size: 0x21
function registerondisconnecteventcallback( callback )
{
    level.ondisconnecteventcallbacks[ level.ondisconnecteventcallbacks.size ] = callback;
}

