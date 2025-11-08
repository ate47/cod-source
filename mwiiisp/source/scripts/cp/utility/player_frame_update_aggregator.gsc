#using scripts\cp\utility;

#namespace player_frame_update_aggregator;

// Namespace player_frame_update_aggregator / scripts\cp\utility\player_frame_update_aggregator
// Params 0
// Checksum 0x0, Offset: 0x89
// Size: 0x15
function init()
{
    level.playerframeupdatecallbacks = [];
    level thread runupdates();
}

// Namespace player_frame_update_aggregator / scripts\cp\utility\player_frame_update_aggregator
// Params 0
// Checksum 0x0, Offset: 0xa6
// Size: 0x79
function runupdates()
{
    level endon( "game_ended" );
    scripts\cp\utility::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            for ( j = 0; j < level.playerframeupdatecallbacks.size ; j++ )
            {
                level.players[ i ] [[ level.playerframeupdatecallbacks[ j ] ]]();
            }
        }
        
        waitframe();
    }
}

// Namespace player_frame_update_aggregator / scripts\cp\utility\player_frame_update_aggregator
// Params 1
// Checksum 0x0, Offset: 0x127
// Size: 0x21
function registerplayerframeupdatecallback( callback )
{
    level.playerframeupdatecallbacks[ level.playerframeupdatecallbacks.size ] = callback;
}

