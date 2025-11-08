#using script_1076881dd9127338;
#using script_37d9a569491ff1e0;
#using script_40e63dd222434655;
#using script_59ff79d681bb860c;
#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_br;

#namespace sniper_combat;

// Namespace sniper_combat / namespace_82adac1fd015a505
// Params 0
// Checksum 0x0, Offset: 0xfd
// Size: 0xd
function function_eda57308516bfc5f()
{
    return function_bffb5b682a4ef6a2( &evaluatescore );
}

// Namespace sniper_combat / namespace_82adac1fd015a505
// Params 1
// Checksum 0x0, Offset: 0x113
// Size: 0x9a
function evaluatescore( bot )
{
    targetstruct = function_1613f016af44e830( bot );
    
    if ( !isdefined( targetstruct ) || !isdefined( targetstruct.target ) )
    {
        return 0;
    }
    
    target = targetstruct.target;
    targetname = getentityname( target );
    self.var_df9d35d9b4bee654 = createactionbase( "sniper_combat", target, "main", targetname + "/" + target getentitynumber(), &actionprocess, self, &function_f4caae7e8af9d32c );
    return targetstruct.score;
}

// Namespace sniper_combat / namespace_82adac1fd015a505
// Params 1
// Checksum 0x0, Offset: 0x1b6
// Size: 0x2b0
function function_1613f016af44e830( bot )
{
    /#
        if ( getdvar( @"bot_notarget" ) == "<dev string:x1c>" )
        {
            return undefined;
        }
    #/
    
    var_49fffc1ce970e26d = isdefined( bot.primaryweaponobj ) && bot namespace_bc2665cbe6cf4e1f::isammoenough( bot.primaryweaponobj, self.constants.var_d0708c53f9aedbbe );
    
    if ( !var_49fffc1ce970e26d )
    {
        return undefined;
    }
    
    var_b01971ef554bac8 = bot namespace_1bebff3a2e9afaca::getevent();
    var_80d16926274a0f94 = getclosest( bot.origin, var_b01971ef554bac8 );
    
    if ( !isdefined( var_80d16926274a0f94 ) )
    {
        return undefined;
    }
    
    var_3b3d162ce953d1dc = var_80d16926274a0f94 get_target_array();
    var_5debf83062cf0194 = getclosest( bot.origin, var_3b3d162ce953d1dc, self.constants.var_b9de038abd473868 );
    
    if ( !isdefined( var_5debf83062cf0194 ) )
    {
        return undefined;
    }
    
    nearbyevent = bot namespace_5524884c16a95af2::getevent();
    nearbyevent namespace_5524884c16a95af2::keepenemies( bot );
    maxdistance = self.constants.var_96af88c97db9ed21[ self.constants.var_96af88c97db9ed21.size - 1 ];
    nearbyevent namespace_5524884c16a95af2::indistance( maxdistance );
    finalscore = 0;
    target = undefined;
    
    foreach ( player in nearbyevent.result )
    {
        /#
            if ( !isbot( player ) && getdvar( @"bot_notarget" ) == "<dev string:x23>" )
            {
                continue;
            }
        #/
        
        distancetoplayer = distance( bot.origin, player.origin );
        basescore = function_9d1ab012058221bb( distancetoplayer, self.constants.var_96af88c97db9ed21, self.constants.var_49e2976ca0c853ef );
        var_6ca288ca3f0ca3a0 = bot function_3569a4bec8b9af17( player );
        
        if ( var_6ca288ca3f0ca3a0 )
        {
            basescore += self.constants.attackermodifier;
        }
        
        if ( basescore > finalscore && ( var_6ca288ca3f0ca3a0 || bot botcanseeentity( player ) ) )
        {
            finalscore = basescore;
            target = player;
        }
    }
    
    result = spawnstruct();
    result.score = finalscore;
    result.target = target;
    return result;
}

// Namespace sniper_combat / namespace_82adac1fd015a505
// Params 1
// Checksum 0x0, Offset: 0x46f
// Size: 0x95
function actionprocess( bot )
{
    assert( isplayer( self.argument ) );
    target = self.argument;
    target endon( "death_or_disconnect" );
    bot allowmovement( 0 );
    bot botsetstance( bot getstance() );
    bot setenemy( target );
    
    while ( isvalidplayer( target ) )
    {
        if ( self.decision.constants.extragrenadethrow )
        {
            bot function_cf1a9e98122e3931( target );
        }
        
        wait 1;
    }
}

// Namespace sniper_combat / namespace_82adac1fd015a505
// Params 1
// Checksum 0x0, Offset: 0x50c
// Size: 0x29
function function_f4caae7e8af9d32c( action )
{
    if ( function_d57dd414963503d1() )
    {
        self botsetstance( "none" );
        self allowmovement( 1 );
    }
}

