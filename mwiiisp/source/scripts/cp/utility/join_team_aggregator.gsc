#namespace join_team_aggregator;

// Namespace join_team_aggregator / scripts\cp\utility\join_team_aggregator
// Params 1
// Checksum 0x0, Offset: 0x68
// Size: 0x5a
function onplayerjointeam( player )
{
    foreach ( callback in level.onjointeamcallbacks )
    {
        self [[ callback ]]( player );
    }
}

// Namespace join_team_aggregator / scripts\cp\utility\join_team_aggregator
// Params 1
// Checksum 0x0, Offset: 0xca
// Size: 0x38
function registeronplayerjointeamcallback( callback )
{
    if ( !isdefined( level.onjointeamcallbacks ) )
    {
        level.onjointeamcallbacks = [];
    }
    
    level.onjointeamcallbacks[ level.onjointeamcallbacks.size ] = callback;
}

