#namespace spawn_event_aggregator;

// Namespace spawn_event_aggregator / scripts\mp\utility\spawn_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0xe3
// Size: 0x22
function init()
{
    if ( !isdefined( level.onplayerspawncallbacks ) )
    {
        level.onplayerspawncallbacks = [];
    }
    
    level thread onplayerconnect();
}

// Namespace spawn_event_aggregator / scripts\mp\utility\spawn_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0x10d
// Size: 0x31
function onplayerconnect()
{
    self notify( "spawn_aggregator_onPlayerConnect_singleton" );
    self endon( "spawn_aggregator_onPlayerConnect_singleton" );
    
    for ( ;; )
    {
        level waittill( "connected", player );
        player thread onplayerspawned();
    }
}

// Namespace spawn_event_aggregator / scripts\mp\utility\spawn_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0x146
// Size: 0x35
function registeronplayerspawncallback( callback )
{
    if ( !isdefined( level.onplayerspawncallbacks ) )
    {
        init();
    }
    
    level.onplayerspawncallbacks[ level.onplayerspawncallbacks.size ] = callback;
}

// Namespace spawn_event_aggregator / scripts\mp\utility\spawn_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0x183
// Size: 0x65
function onplayerspawned()
{
    self endon( "disconnect" );
    
    for ( ;; )
    {
        self waittill( "spawned_player" );
        
        foreach ( callback in level.onplayerspawncallbacks )
        {
            self [[ callback ]]();
        }
    }
}

