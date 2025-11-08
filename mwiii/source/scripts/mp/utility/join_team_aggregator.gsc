#namespace join_team_aggregator;

// Namespace join_team_aggregator / scripts\mp\utility\join_team_aggregator
// Params 1
// Checksum 0x0, Offset: 0xcb
// Size: 0x73
function onplayerjointeam( player )
{
    thread onplayerjointeamnospectator( player );
    
    if ( isdefined( level.onjointeamcallbacks ) )
    {
        foreach ( callback in level.onjointeamcallbacks )
        {
            self [[ callback ]]( player );
        }
    }
}

// Namespace join_team_aggregator / scripts\mp\utility\join_team_aggregator
// Params 1
// Checksum 0x0, Offset: 0x146
// Size: 0x38
function registeronplayerjointeamcallback( callback )
{
    if ( !isdefined( level.onjointeamcallbacks ) )
    {
        level.onjointeamcallbacks = [];
    }
    
    level.onjointeamcallbacks[ level.onjointeamcallbacks.size ] = callback;
}

// Namespace join_team_aggregator / scripts\mp\utility\join_team_aggregator
// Params 1
// Checksum 0x0, Offset: 0x186
// Size: 0xac
function onplayerjointeamnospectator( player )
{
    player notify( "onPlayerJoinTeamNoSpectator" );
    
    if ( player.sessionstate == "spectator" )
    {
        player endon( "death_or_disconnect" );
        player endon( "onPlayerJoinTeamNoSpectator" );
        
        while ( player.sessionstate == "spectator" )
        {
            waitframe();
        }
    }
    
    if ( isdefined( level.onjointeamnospectatorcallbacks ) )
    {
        foreach ( callback in level.onjointeamnospectatorcallbacks )
        {
            self [[ callback ]]( player );
        }
    }
}

// Namespace join_team_aggregator / scripts\mp\utility\join_team_aggregator
// Params 1
// Checksum 0x0, Offset: 0x23a
// Size: 0x38
function registeronplayerjointeamnospectatorcallback( callback )
{
    if ( !isdefined( level.onjointeamnospectatorcallbacks ) )
    {
        level.onjointeamnospectatorcallbacks = [];
    }
    
    level.onjointeamnospectatorcallbacks[ level.onjointeamnospectatorcallbacks.size ] = callback;
}

