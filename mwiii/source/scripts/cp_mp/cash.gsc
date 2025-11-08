#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;

#namespace cash;

// Namespace cash / scripts\cp_mp\cash
// Params 1
// Checksum 0x0, Offset: 0xe1
// Size: 0x175
function playersetplunderomnvar( value )
{
    assert( isdefined( value ) );
    
    if ( !isdefined( value ) )
    {
        return;
    }
    
    squadmemberindex = self.sessionuimemberindex;
    
    if ( !isdefined( squadmemberindex ) || !isdefined( self.team ) || istrue( self.isdisconnecting ) || isdefined( level.maxsquadsize ) && squadmemberindex >= level.maxsquadsize )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() )
    {
        self setclientomnvar( "ui_cash_squad_index_" + squadmemberindex, value );
        return;
    }
    
    squadmates = level.teamdata[ self.team ][ "players" ];
    
    if ( isdefined( level.squaddata ) && isdefined( level.squaddata[ self.team ] ) && isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
    {
        squadmates = level.squaddata[ self.team ][ self.sessionsquadid ].players;
    }
    
    foreach ( player in squadmates )
    {
        if ( isdefined( player ) )
        {
            player setclientomnvar( "ui_cash_squad_index_" + squadmemberindex, value );
        }
    }
}

// Namespace cash / scripts\cp_mp\cash
// Params 2
// Checksum 0x0, Offset: 0x25e
// Size: 0x1e7
function function_52bea99a5c38fbe5( value, var_10aaaaa566515888 )
{
    if ( !isdefined( var_10aaaaa566515888 ) )
    {
        var_10aaaaa566515888 = 0;
    }
    
    assert( isdefined( value ) );
    
    if ( !isdefined( value ) )
    {
        return;
    }
    
    if ( !var_10aaaaa566515888 && isdefined( self.var_d62416826f295c0b ) && self.var_d62416826f295c0b == value )
    {
        return;
    }
    
    squadmemberindex = self.sessionuimemberindex;
    
    if ( !isdefined( squadmemberindex ) || !isdefined( self.team ) || istrue( self.isdisconnecting ) )
    {
        return;
    }
    
    if ( isdefined( level.var_5f92f1f4d7faf5a0 ) && squadmemberindex >= level.var_5f92f1f4d7faf5a0 )
    {
        return;
    }
    
    if ( !isdefined( level.var_5f92f1f4d7faf5a0 ) && isdefined( level.maxsquadsize ) && squadmemberindex >= level.maxsquadsize )
    {
        return;
    }
    
    if ( squadmemberindex < 0 )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() )
    {
        self setclientomnvar( "ui_zm_essence_squad_index_" + squadmemberindex, value );
    }
    else
    {
        squadmates = level.teamdata[ self.team ][ "players" ];
        
        if ( isdefined( level.squaddata ) && isdefined( level.squaddata[ self.team ] ) && isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
        {
            squadmates = level.squaddata[ self.team ][ self.sessionsquadid ].players;
        }
        
        foreach ( player in squadmates )
        {
            player setclientomnvar( "ui_zm_essence_squad_index_" + squadmemberindex, value );
        }
    }
    
    self.var_d62416826f295c0b = value;
}

// Namespace cash / scripts\cp_mp\cash
// Params 0
// Checksum 0x0, Offset: 0x44d
// Size: 0x175
function function_6da8b65579348d0b()
{
    if ( !isdefined( self.plundercount ) )
    {
        self.plundercount = 0;
    }
    
    if ( isdefined( self.team ) && !scripts\cp_mp\utility\game_utility::function_9cdaadfddeda4d7a() )
    {
        squadmates = level.teamdata[ self.team ][ "players" ];
        
        if ( isdefined( level.squaddata ) && isdefined( level.squaddata[ self.team ] ) && isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
        {
            squadmates = level.squaddata[ self.team ][ self.sessionsquadid ].players;
        }
        
        foreach ( player in squadmates )
        {
            squadmemberindex = player.sessionuimemberindex;
            
            if ( self != player && isdefined( squadmemberindex ) )
            {
                value = player getclientomnvar( "ui_cash_squad_index_" + squadmemberindex );
                self setclientomnvar( "ui_cash_squad_index_" + squadmemberindex, value );
                var_6214ba0b9e2c422e = player getclientomnvar( "ui_zm_essence_squad_index_" + squadmemberindex );
                self setclientomnvar( "ui_zm_essence_squad_index_" + squadmemberindex, var_6214ba0b9e2c422e );
            }
        }
    }
}

