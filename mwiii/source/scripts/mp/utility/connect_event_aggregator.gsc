#namespace connect_event_aggregator;

// Namespace connect_event_aggregator / scripts\mp\utility\connect_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0xa3
// Size: 0xb
function init()
{
    level thread onplayerconnect();
}

// Namespace connect_event_aggregator / scripts\mp\utility\connect_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0xb6
// Size: 0x39
function onplayerconnect()
{
    if ( !isdefined( level.onplayerconnectcallbacks ) )
    {
        level.onplayerconnectcallbacks = [];
    }
    
    for ( ;; )
    {
        level waittill( "connected", player );
        player thread onplayerconnected();
    }
}

// Namespace connect_event_aggregator / scripts\mp\utility\connect_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0xf7
// Size: 0x38
function registeronconnectcallback( callback )
{
    if ( !isdefined( level.onplayerconnectcallbacks ) )
    {
        level.onplayerconnectcallbacks = [];
    }
    
    level.onplayerconnectcallbacks[ level.onplayerconnectcallbacks.size ] = callback;
}

// Namespace connect_event_aggregator / scripts\mp\utility\connect_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0x137
// Size: 0x5a
function onplayerconnected()
{
    self endon( "disconnect" );
    
    foreach ( callback in level.onplayerconnectcallbacks )
    {
        self [[ callback ]]();
    }
}

