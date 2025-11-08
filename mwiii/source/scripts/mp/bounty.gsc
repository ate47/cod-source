#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\points;

#namespace bounty;

// Namespace bounty / scripts\mp\bounty
// Params 0
// Checksum 0x0, Offset: 0x148
// Size: 0x4b
function init()
{
    level.bounty_index = [];
    level._effect[ "vfx_mo_money_cash_exp" ] = loadfx( "vfx/iw7/_requests/mp/vfx_mo_money_cash_exp.vfx" );
    
    if ( true )
    {
        thread onplayerconnect();
        scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
        scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback( &onplayerjoinedteam );
    }
}

// Namespace bounty / scripts\mp\bounty
// Params 0
// Checksum 0x0, Offset: 0x19b
// Size: 0x26
function onplayerconnect()
{
    while ( true )
    {
        level waittill( "connected", player );
        player bountyinit();
    }
}

// Namespace bounty / scripts\mp\bounty
// Params 0
// Checksum 0x0, Offset: 0x1c9
// Size: 0x24
function bountyinit()
{
    if ( !isdefined( self.bountypoints ) )
    {
        playerregisterbountyindex();
        playerresetbountypoints();
        playerresetbountystreak();
    }
}

// Namespace bounty / scripts\mp\bounty
// Params 1
// Checksum 0x0, Offset: 0x1f5
// Size: 0x2f
function onplayerdisconnect( player )
{
    if ( isdefined( player.bounty_index ) )
    {
        level.bounty_index[ player.bounty_index ] = undefined;
    }
}

// Namespace bounty / scripts\mp\bounty
// Params 1
// Checksum 0x0, Offset: 0x22c
// Size: 0x2f
function onplayerjoinedspectators( player )
{
    if ( true )
    {
        if ( isdefined( player.bounty_index ) )
        {
            player playerresetbountypoints();
            player playerresetbountystreak();
        }
    }
}

// Namespace bounty / scripts\mp\bounty
// Params 1
// Checksum 0x0, Offset: 0x263
// Size: 0x2f
function onplayerjoinedteam( player )
{
    if ( true )
    {
        if ( isdefined( player.bounty_index ) )
        {
            player playerresetbountypoints();
            player playerresetbountystreak();
        }
    }
}

// Namespace bounty / scripts\mp\bounty
// Params 0
// Checksum 0x0, Offset: 0x29a
// Size: 0x3b
function playerregisterbountyindex()
{
    for ( index = 0; isdefined( level.bounty_index[ index ] ) ; index++ )
    {
    }
    
    level.bounty_index[ index ] = self;
    self.bounty_index = index;
}

// Namespace bounty / scripts\mp\bounty
// Params 0
// Checksum 0x0, Offset: 0x2dd
// Size: 0x23
function playergetbountypoints()
{
    assertex( isdefined( self.bountypoints ), "<dev string:x1c>" );
    return self.bountypoints;
}

// Namespace bounty / scripts\mp\bounty
// Params 1
// Checksum 0x0, Offset: 0x309
// Size: 0x4f
function playersetbountypoints( bountypoints )
{
    assertex( isdefined( self.bounty_index ), "<dev string:x1c>" );
    self.bountypoints = bountypoints;
    level.bounty_index[ self.bounty_index ] setbountycount( self.bountypoints );
}

// Namespace bounty / scripts\mp\bounty
// Params 1
// Checksum 0x0, Offset: 0x360
// Size: 0x24
function playerresetbountypoints( wait_time )
{
    if ( false )
    {
        return;
    }
    
    if ( isdefined( wait_time ) )
    {
        wait wait_time;
    }
    
    if ( isdefined( self ) )
    {
        playersetbountypoints( 0 );
    }
}

// Namespace bounty / scripts\mp\bounty
// Params 1
// Checksum 0x0, Offset: 0x38c
// Size: 0x26
function playerresetbountystreak( wait_time )
{
    if ( false )
    {
        return;
    }
    
    if ( isdefined( wait_time ) )
    {
        wait wait_time;
    }
    
    if ( isdefined( self ) )
    {
        self.bountystreak = 0;
    }
}

// Namespace bounty / scripts\mp\bounty
// Params 1
// Checksum 0x0, Offset: 0x3ba
// Size: 0x34
function bountyincreasestreak( amount )
{
    if ( false )
    {
        return;
    }
    
    if ( !isdefined( amount ) )
    {
        amount = 1;
    }
    
    self.bountystreak += amount;
    bountyconvert();
}

// Namespace bounty / scripts\mp\bounty
// Params 0
// Checksum 0x0, Offset: 0x3f6
// Size: 0x4f
function bountyconvert()
{
    if ( false )
    {
        return;
    }
    
    old_bounty = playergetbountypoints();
    new_bounty = int( floor( self.bountystreak / 3 ) );
    
    if ( new_bounty > old_bounty && new_bounty <= 5 )
    {
        playersetbountypoints( new_bounty );
    }
}

// Namespace bounty / scripts\mp\bounty
// Params 2
// Checksum 0x0, Offset: 0x44d
// Size: 0x8b
function bountycollect( victim_bounty, victim_pos )
{
    if ( false )
    {
        return;
    }
    
    if ( _hasperk( "specialty_bounty" ) )
    {
        if ( victim_bounty > 0 )
        {
            for ( i = 0; i < victim_bounty ; i++ )
            {
                thread doscoreevent( #"bounty" );
                bountyincreasestreak();
                playfx( getfx( "vfx_mo_money_cash_exp" ), victim_pos + ( 0, 0, 45 ) );
            }
            
            thread teamplayercardsplash( "callout_bounty_collected", self );
        }
    }
}

