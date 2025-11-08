#namespace connect_event_aggregator;

// Namespace connect_event_aggregator / scripts\cp\utility\connect_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0x7d
// Size: 0xb
function init()
{
    level thread onplayerconnect();
}

// Namespace connect_event_aggregator / scripts\cp\utility\connect_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0x90
// Size: 0x38
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

// Namespace connect_event_aggregator / scripts\cp\utility\connect_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0xd0
// Size: 0x38
function registeronconnectcallback( callback )
{
    if ( !isdefined( level.onplayerconnectcallbacks ) )
    {
        level.onplayerconnectcallbacks = [];
    }
    
    level.onplayerconnectcallbacks[ level.onplayerconnectcallbacks.size ] = callback;
}

// Namespace connect_event_aggregator / scripts\cp\utility\connect_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0x110
// Size: 0x57
function onplayerconnected()
{
    self endon( "disconnect" );
    
    foreach ( callback in level.onplayerconnectcallbacks )
    {
        self [[ callback ]]();
    }
}

