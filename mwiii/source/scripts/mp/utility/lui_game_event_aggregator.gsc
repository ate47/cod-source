#using scripts\engine\utility;

#namespace lui_game_event_aggregator;

// Namespace lui_game_event_aggregator / scripts\mp\utility\lui_game_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0xf5
// Size: 0xb
function init()
{
    level thread onplayerconnect();
}

// Namespace lui_game_event_aggregator / scripts\mp\utility\lui_game_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0x108
// Size: 0x34
function onplayerconnect()
{
    level.onluieventcallbacks = [];
    level notify( "lui_game_event_aggregator_initialized" );
    
    for ( ;; )
    {
        level waittill( "connected", player );
        player thread onplayerconnected();
    }
}

// Namespace lui_game_event_aggregator / scripts\mp\utility\lui_game_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0x144
// Size: 0x21
function registeronluieventcallback( callback )
{
    level.onluieventcallbacks[ level.onluieventcallbacks.size ] = callback;
}

// Namespace lui_game_event_aggregator / scripts\mp\utility\lui_game_event_aggregator
// Params 1
// Checksum 0x0, Offset: 0x16d
// Size: 0x24
function function_89376739fb493757( callback )
{
    level.onluieventcallbacks = scripts\engine\utility::array_remove( level.onluieventcallbacks, callback );
}

// Namespace lui_game_event_aggregator / scripts\mp\utility\lui_game_event_aggregator
// Params 0
// Checksum 0x0, Offset: 0x199
// Size: 0x82
function onplayerconnected()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        self waittill( "luinotifyserver", channel, val );
        
        foreach ( callback in level.onluieventcallbacks )
        {
            self [[ callback ]]( channel, val );
        }
    }
}

