#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\teams;

#namespace friendicons;

// Namespace friendicons / scripts\mp\friendicons
// Params 0
// Checksum 0x0, Offset: 0x153
// Size: 0x5f
function init()
{
    level.drawfriend = 0;
    game[ "headicon_allies" ] = getteamheadicon( "allies" );
    game[ "headicon_axis" ] = getteamheadicon( "axis" );
    precacheshader( "waypoint_revive" );
    level thread onplayerconnect();
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
    
    for ( ;; )
    {
        updatefriendiconsettings();
        wait 5;
    }
}

// Namespace friendicons / scripts\mp\friendicons
// Params 0
// Checksum 0x0, Offset: 0x1ba
// Size: 0x2c
function onplayerconnect()
{
    if ( scripts\mp\utility\game::runleanthreadmode() )
    {
        return;
    }
    
    for ( ;; )
    {
        level waittill( "connected", player );
        player thread onplayerkilled();
    }
}

// Namespace friendicons / scripts\mp\friendicons
// Params 0
// Checksum 0x0, Offset: 0x1ee
// Size: 0x14
function onplayerspawned()
{
    if ( scripts\mp\utility\game::runleanthreadmode() )
    {
        return;
    }
    
    thread showfriendicon();
}

// Namespace friendicons / scripts\mp\friendicons
// Params 0
// Checksum 0x0, Offset: 0x20a
// Size: 0x22
function onplayerkilled()
{
    self endon( "disconnect" );
    
    for ( ;; )
    {
        self waittill( "killed_player" );
        self.headicon = "";
    }
}

// Namespace friendicons / scripts\mp\friendicons
// Params 0
// Checksum 0x0, Offset: 0x234
// Size: 0x65
function showfriendicon()
{
    if ( level.drawfriend )
    {
        if ( self.pers[ "team" ] == "allies" )
        {
            self.headicon = game[ "headicon_allies" ];
            self.headiconteam = "allies";
            return;
        }
        
        self.headicon = game[ "headicon_axis" ];
        self.headiconteam = "axis";
    }
}

// Namespace friendicons / scripts\mp\friendicons
// Params 0
// Checksum 0x0, Offset: 0x2a1
// Size: 0x41
function updatefriendiconsettings()
{
    drawfriend = scripts\mp\utility\dvars::getintproperty( "scr_drawfriend", level.drawfriend );
    
    if ( level.drawfriend != drawfriend )
    {
        level.drawfriend = drawfriend;
        updatefriendicons();
    }
}

// Namespace friendicons / scripts\mp\friendicons
// Params 0
// Checksum 0x0, Offset: 0x2ea
// Size: 0x16b
function updatefriendicons()
{
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] != "spectator" && player.sessionstate == "playing" )
        {
            if ( level.drawfriend )
            {
                if ( player.pers[ "team" ] == "allies" )
                {
                    player.headicon = game[ "headicon_allies" ];
                    player.headiconteam = "allies";
                }
                else
                {
                    player.headicon = game[ "headicon_axis" ];
                    player.headiconteam = "axis";
                }
                
                continue;
            }
            
            players = level.players;
            
            for ( i = 0; i < players.size ; i++ )
            {
                player = players[ i ];
                
                if ( isdefined( player.pers[ "team" ] ) && player.pers[ "team" ] != "spectator" && player.sessionstate == "playing" )
                {
                    player.headicon = "";
                }
            }
        }
    }
}

