#using scripts\mp\flags;

#namespace player_frame_update_aggregator;

// Namespace player_frame_update_aggregator / scripts\mp\utility\player_frame_update_aggregator
// Params 0
// Checksum 0x0, Offset: 0xaf
// Size: 0x15
function init()
{
    level.playerframeupdatecallbacks = [];
    level thread runupdates();
}

// Namespace player_frame_update_aggregator / scripts\mp\utility\player_frame_update_aggregator
// Params 0
// Checksum 0x0, Offset: 0xcc
// Size: 0xb9
function runupdates()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            foreach ( callback in level.playerframeupdatecallbacks )
            {
                player [[ callback ]]();
            }
        }
        
        waitframe();
    }
}

// Namespace player_frame_update_aggregator / scripts\mp\utility\player_frame_update_aggregator
// Params 1
// Checksum 0x0, Offset: 0x18d
// Size: 0x21
function registerplayerframeupdatecallback( callback )
{
    level.playerframeupdatecallbacks[ level.playerframeupdatecallbacks.size ] = callback;
}

