#using script_26ccbfe3954cacf4;
#using script_40e63dd222434655;
#using script_59ff79d681bb860c;
#using script_7c79573f6d201a19;
#using script_d74ae0b4aa21186;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_br;
#using scripts\mp\utility\game;

#namespace wander;

// Namespace wander / namespace_ea0055094e5fd26a
// Params 0
// Checksum 0x0, Offset: 0x178
// Size: 0x15
function function_eda57308516bfc5f()
{
    return function_bffb5b682a4ef6a2( &evaluatescore, &createaction, 2000 );
}

// Namespace wander / namespace_ea0055094e5fd26a
// Params 1
// Checksum 0x0, Offset: 0x196
// Size: 0xed
function evaluatescore( bot )
{
    finalscore = self.constants.basescore;
    
    if ( function_cbba7b5bbf487abb( "WanderSelectDestination" ) )
    {
        return finalscore;
    }
    
    master = bot function_2810b62e37a684f9();
    
    if ( isdefined( master ) && master != bot )
    {
        if ( self.constants.var_bf4b19a689dba773 > 0 )
        {
            self.var_df9d35d9b4bee654 = function_f51749cef5c1eec( master );
            var_90c7ba59a2555b5d = function_9d1ab012058221bb( distance( bot.origin, master.origin ), self.constants.var_b248e7805fbaf822, self.constants.var_375a77fd02b3fcc );
            var_90c7ba59a2555b5d *= self.constants.var_bf4b19a689dba773;
            finalscore += var_90c7ba59a2555b5d;
        }
    }
    
    return finalscore;
}

// Namespace wander / namespace_ea0055094e5fd26a
// Params 1
// Checksum 0x0, Offset: 0x28c
// Size: 0x12
function createaction( bot )
{
    return function_f51749cef5c1eec( undefined );
}

// Namespace wander / namespace_ea0055094e5fd26a
// Params 1
// Checksum 0x0, Offset: 0x2a7
// Size: 0x27
function function_f51749cef5c1eec( squadmaster )
{
    return createactionbase( "wander", squadmaster, "main", "", &actionprocess, self );
}

// Namespace wander / namespace_ea0055094e5fd26a
// Params 1
// Checksum 0x0, Offset: 0x2d7
// Size: 0x160
function actionprocess( bot )
{
    pointonnavmesh = bot function_188de758cb607fa3( self.decision, self.argument );
    
    if ( !isdefined( pointonnavmesh ) )
    {
        return "No destination";
    }
    
    bot setscriptgoal( pointonnavmesh, self.decision.constants.var_a135e495fbf4cf96 );
    result = bot waittill_any_in_array_or_timeout( [ "goal", "bad_path", "long_path" ], 15 );
    
    if ( result == "goal" )
    {
        if ( scripts\mp\utility\game::getsubgametype() != "rumble_mgl" )
        {
            /#
                function_f3cf203834e48c6d( "<dev string:x1c>" );
            #/
            
            restseconds = randomfloatrange( 1, 3 );
            wait restseconds;
        }
    }
    else if ( result == "bad_path" && isdefined( self.decision.lastloot ) )
    {
        var_8c9d8551140041f7 = bot.mind.var_f0a8822dcc782c9d.var_577f45571c039a54[ "Pickup" ];
        
        if ( isdefined( var_8c9d8551140041f7 ) )
        {
            var_8c9d8551140041f7 namespace_351e75b9d115392f::function_2d9fcd6970321ba( self.decision.lastloot );
        }
    }
    
    bot notify( "dormant_bot_suspending_chance" );
    
    if ( result != "goal" && result != "timeout" )
    {
        return result;
    }
}

// Namespace wander / namespace_ea0055094e5fd26a
// Params 2
// Checksum 0x0, Offset: 0x43f
// Size: 0x7e
function function_188de758cb607fa3( decision, squadmaster )
{
    wanderselectdestination = function_63cc4ce09c4659a1( "WanderSelectDestination" );
    
    if ( isdefined( wanderselectdestination ) )
    {
        return wanderselectdestination;
    }
    
    lastloot = decision.lastloot;
    decision.lastloot = undefined;
    
    if ( isdefined( squadmaster ) )
    {
        return function_75328d9af88f8b4e( squadmaster, decision );
    }
    
    if ( namespace_95d8d8ec67e3e074::function_d012729eac1e7053() )
    {
        return function_9e2f5dc882037389( decision, lastloot );
    }
    
    return function_d635a657fa4ebf17();
}

// Namespace wander / namespace_ea0055094e5fd26a
// Params 2
// Checksum 0x0, Offset: 0x4c5
// Size: 0x7c
function function_75328d9af88f8b4e( master, decision )
{
    center = undefined;
    
    if ( isbot( master ) && master bothasscriptgoal() )
    {
        center = master botgetscriptgoal();
    }
    else
    {
        center = master.origin;
    }
    
    return function_94df2aa132008fcc( center, decision.constants.var_cc9b7ef91fc151b, decision.constants.var_3145d7adafc61293 );
}

// Namespace wander / namespace_ea0055094e5fd26a
// Params 2
// Checksum 0x0, Offset: 0x54a
// Size: 0xac
function function_9e2f5dc882037389( decision, lastloot )
{
    var_8f60e685e9ada1d8 = 0.5;
    
    if ( randomfloat( 1 ) < var_8f60e685e9ada1d8 )
    {
        var_8c9d8551140041f7 = self.mind.var_f0a8822dcc782c9d.var_577f45571c039a54[ "Pickup" ];
        
        if ( isdefined( var_8c9d8551140041f7 ) )
        {
            decision.lastloot = var_8c9d8551140041f7 namespace_351e75b9d115392f::function_54f633f649764ea9( self, lastloot );
            
            if ( isdefined( decision.lastloot ) )
            {
                return decision.lastloot.entity.origin;
            }
        }
    }
    
    return function_d635a657fa4ebf17();
}

// Namespace wander / namespace_ea0055094e5fd26a
// Params 0
// Checksum 0x0, Offset: 0x5ff
// Size: 0x23
function function_d635a657fa4ebf17()
{
    var_58a4f0b1d349d24e = 2500;
    return function_94df2aa132008fcc( self.origin, var_58a4f0b1d349d24e, 5 );
}

// Namespace wander / namespace_ea0055094e5fd26a
// Params 0
// Checksum 0x0, Offset: 0x62b
// Size: 0x10c
function function_2810b62e37a684f9()
{
    if ( !scripts\cp_mp\utility\squad_utility::issquadmode() )
    {
        return undefined;
    }
    
    squad = level.squaddata[ self.team ][ self.sessionsquadid ];
    var_8b0bfb7310ce9582 = function_87102f4ad2cc5188( self, squad.squadleader );
    
    if ( var_8b0bfb7310ce9582 && !isai( squad.squadleader ) )
    {
        return squad.squadleader;
    }
    
    var_a5f822b72ce13f72 = undefined;
    
    for ( i = 0; i < squad.players.size ; i++ )
    {
        player = squad.players[ i ];
        
        if ( isdefined( squad.squadleader ) && squad.squadleader == player )
        {
            continue;
        }
        
        if ( function_87102f4ad2cc5188( self, player ) )
        {
            if ( !isai( player ) )
            {
                return player;
            }
            
            if ( !isdefined( var_a5f822b72ce13f72 ) )
            {
                var_a5f822b72ce13f72 = player;
            }
        }
    }
    
    if ( var_8b0bfb7310ce9582 )
    {
        return squad.squadleader;
    }
    
    return var_a5f822b72ce13f72;
}

// Namespace wander / namespace_ea0055094e5fd26a
// Params 2
// Checksum 0x0, Offset: 0x740
// Size: 0x5c
function function_87102f4ad2cc5188( follower, target )
{
    assert( !isdefined( target ) || follower.team == target.team && follower.sessionsquadid == target.sessionsquadid );
    return isvalidplayeronground( target );
}

// Namespace wander / namespace_ea0055094e5fd26a
// Params 3
// Checksum 0x0, Offset: 0x7a5
// Size: 0x8b
function function_94df2aa132008fcc( center, distance, seconds )
{
    if ( !isdefined( distance ) )
    {
        distance = 750;
    }
    
    timeout = gettime() + 1000 * seconds;
    
    while ( gettime() < timeout )
    {
        point = function_fcc75af6225b896b( center, distance, 0.6, 1 );
        reachable_point = function_207ba502560fa1d2( point );
        
        if ( function_bcb0778bb33e86de( reachable_point ) )
        {
            return reachable_point;
        }
        
        wait 0.05;
    }
    
    return function_c42a53b48c0a683e();
}

// Namespace wander / namespace_ea0055094e5fd26a
// Params 1
// Checksum 0x0, Offset: 0x839
// Size: 0x18
function function_e08ee6939ebfdb4d( func )
{
    registercallback( "WanderSelectDestination", func );
}

