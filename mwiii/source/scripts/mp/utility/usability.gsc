#namespace usability;

// Namespace usability / scripts\mp\utility\usability
// Params 1
// Checksum 0x0, Offset: 0x138
// Size: 0x77
function setselfusable( caller )
{
    self makeusable();
    
    foreach ( player in level.players )
    {
        if ( player != caller )
        {
            self disableplayeruse( player );
            continue;
        }
        
        self enableplayeruse( player );
    }
}

// Namespace usability / scripts\mp\utility\usability
// Params 0
// Checksum 0x0, Offset: 0x1b7
// Size: 0x56
function setallunusable()
{
    foreach ( player in level.players )
    {
        self disableplayeruse( player );
    }
}

// Namespace usability / scripts\mp\utility\usability
// Params 1
// Checksum 0x0, Offset: 0x215
// Size: 0x1b
function maketeamusable( team )
{
    self makeusable();
    thread _updateteamusable( team );
}

// Namespace usability / scripts\mp\utility\usability
// Params 1
// Checksum 0x0, Offset: 0x238
// Size: 0x8c
function _updateteamusable( team )
{
    self endon( "death" );
    
    for ( ;; )
    {
        foreach ( player in level.players )
        {
            if ( player.team == team )
            {
                self enableplayeruse( player );
                continue;
            }
            
            self disableplayeruse( player );
        }
        
        level waittill( "joined_team" );
    }
}

// Namespace usability / scripts\mp\utility\usability
// Params 2
// Checksum 0x0, Offset: 0x2cc
// Size: 0x24
function makeenemyusable( owner, var_418a5c9b9391dfc7 )
{
    self makeusable();
    thread _updateenemyusable( owner, var_418a5c9b9391dfc7 );
}

// Namespace usability / scripts\mp\utility\usability
// Params 2
// Checksum 0x0, Offset: 0x2f8
// Size: 0x159
function _updateenemyusable( owner, var_418a5c9b9391dfc7 )
{
    self endon( "death" );
    team = owner.team;
    
    for ( ;; )
    {
        if ( level.teambased )
        {
            foreach ( player in level.players )
            {
                if ( istrue( var_418a5c9b9391dfc7 ) )
                {
                    if ( player.team != team || player == owner )
                    {
                        self enableplayeruse( player );
                    }
                    else
                    {
                        self disableplayeruse( player );
                    }
                    
                    continue;
                }
                
                if ( player.team != team )
                {
                    self enableplayeruse( player );
                    continue;
                }
                
                self disableplayeruse( player );
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( istrue( var_418a5c9b9391dfc7 ) )
                {
                    self enableplayeruse( player );
                    continue;
                }
                
                if ( player != owner )
                {
                    self enableplayeruse( player );
                    continue;
                }
                
                self disableplayeruse( player );
            }
        }
        
        level waittill( "joined_team" );
    }
}

// Namespace usability / scripts\mp\utility\usability
// Params 1
// Checksum 0x0, Offset: 0x459
// Size: 0x6c
function notusableforjoiningplayers( owner )
{
    self notify( "notusablejoiningplayers" );
    self endon( "death" );
    level endon( "game_ended" );
    owner endon( "death_or_disconnect" );
    self endon( "notusablejoiningplayers" );
    self endon( "makeExplosiveUnusable" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        
        if ( isdefined( self ) && isdefined( player ) && player != owner )
        {
            self disableplayeruse( player );
        }
    }
}

// Namespace usability / scripts\mp\utility\usability
// Params 2
// Checksum 0x0, Offset: 0x4cd
// Size: 0x56
function notusableafterownerchange( owner, equipment )
{
    self notify( "notusableafterownerchange" );
    self endon( "death" );
    level endon( "game_ended" );
    owner endon( "death_or_disconnect" );
    self endon( "notusableafterownerchange" );
    self endon( "makeExplosiveUnusable" );
    
    while ( true )
    {
        equipment waittill( "ownerChanged" );
        self disableplayeruse( owner );
    }
}

