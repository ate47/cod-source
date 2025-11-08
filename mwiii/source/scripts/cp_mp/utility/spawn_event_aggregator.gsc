#namespace spawn_event_aggregator;

// Namespace spawn_event_aggregator / scripts\cp_mp\utility\spawn_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0xb5
// Size: 0x22
function init()
{
    if ( !isdefined( level.onplayerspawncallbacks ) )
    {
        level.onplayerspawncallbacks = [];
    }
    
    level thread onplayerconnect();
}

// Namespace spawn_event_aggregator / scripts\cp_mp\utility\spawn_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0xdf
// Size: 0x22
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( "connected", player );
        player thread onplayerspawned();
    }
}

// Namespace spawn_event_aggregator / scripts\cp_mp\utility\spawn_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0x109
// Size: 0x38
function registeronplayerspawncallback( callback )
{
    if ( !isdefined( level.onplayerspawncallbacks ) )
    {
        level.onplayerspawncallbacks = [];
    }
    
    level.onplayerspawncallbacks[ level.onplayerspawncallbacks.size ] = callback;
}

// Namespace spawn_event_aggregator / scripts\cp_mp\utility\spawn_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0x149
// Size: 0x78
function function_de35280460ae9411( remove_callback )
{
    temp_array = [];
    
    foreach ( callback in level.onplayerspawncallbacks )
    {
        if ( remove_callback != callback )
        {
            temp_array[ temp_array.size ] = callback;
        }
    }
    
    level.onplayerspawncallbacks = temp_array;
}

// Namespace spawn_event_aggregator / scripts\cp_mp\utility\spawn_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0x1c9
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

