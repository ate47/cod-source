#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\utility\game;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;

#namespace codcasterclientmatchdata;

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 1
// Checksum 0x0, Offset: 0x2e2
// Size: 0x3e
function function_5281975e60eac3a( var_127743befe53da2e )
{
    if ( !isdefined( self.var_a8f9789edd592f29 ) )
    {
        self.var_a8f9789edd592f29 = [];
    }
    
    if ( !isdefined( self.var_a8f9789edd592f29[ var_127743befe53da2e ] ) )
    {
        self.var_a8f9789edd592f29[ var_127743befe53da2e ] = 0;
    }
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 2
// Checksum 0x0, Offset: 0x328
// Size: 0x66
function function_cc33f4ece5dca487( var_127743befe53da2e, index )
{
    if ( !isdefined( self.var_a8f9789edd592f29 ) )
    {
        self.var_a8f9789edd592f29 = [];
    }
    
    if ( !isdefined( self.var_a8f9789edd592f29[ var_127743befe53da2e ] ) )
    {
        self.var_a8f9789edd592f29[ var_127743befe53da2e ] = [];
    }
    
    if ( !isdefined( self.var_a8f9789edd592f29[ var_127743befe53da2e ][ index ] ) )
    {
        self.var_a8f9789edd592f29[ var_127743befe53da2e ][ index ] = 0;
    }
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 1
// Checksum 0x0, Offset: 0x396
// Size: 0x3e
function function_b899bce95b7d6a94( var_cf76a3550b35080c )
{
    if ( !isdefined( self.var_e41d482461d4594f ) )
    {
        self.var_e41d482461d4594f = [];
    }
    
    if ( !isdefined( self.var_e41d482461d4594f[ var_cf76a3550b35080c ] ) )
    {
        self.var_e41d482461d4594f[ var_cf76a3550b35080c ] = 0;
    }
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 2
// Checksum 0x0, Offset: 0x3dc
// Size: 0x47
function function_d16498b27251da56( var_127743befe53da2e, increment )
{
    function_5281975e60eac3a( var_127743befe53da2e );
    self.var_a8f9789edd592f29[ var_127743befe53da2e ] += increment;
    function_7ee466e81b1afc12( var_127743befe53da2e, self.var_a8f9789edd592f29[ var_127743befe53da2e ] );
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 2
// Checksum 0x0, Offset: 0x42b
// Size: 0x30
function function_48544e365f4f5648( var_cf76a3550b35080c, increment )
{
    function_b899bce95b7d6a94( var_cf76a3550b35080c );
    function_f8b808cd6473e6cc( var_cf76a3550b35080c, self.var_e41d482461d4594f[ var_cf76a3550b35080c ] + increment );
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 2
// Checksum 0x0, Offset: 0x463
// Size: 0x3b
function function_7ee466e81b1afc12( var_127743befe53da2e, value )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    function_5281975e60eac3a( var_127743befe53da2e );
    self.var_a8f9789edd592f29[ var_127743befe53da2e ] = value;
    self setcodcasterstat( var_127743befe53da2e, value );
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 3
// Checksum 0x0, Offset: 0x4a6
// Size: 0x47
function function_6807ed320b73be7f( var_127743befe53da2e, index, value )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    function_cc33f4ece5dca487( var_127743befe53da2e, index );
    self.var_a8f9789edd592f29[ var_127743befe53da2e ][ index ] = value;
    self setcodcasterstat( var_127743befe53da2e, value, index );
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 2
// Checksum 0x0, Offset: 0x4f5
// Size: 0x4b
function function_f8b808cd6473e6cc( var_cf76a3550b35080c, value )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    function_b899bce95b7d6a94( var_cf76a3550b35080c );
    
    if ( self.var_e41d482461d4594f[ var_cf76a3550b35080c ] != value )
    {
        self.var_e41d482461d4594f[ var_cf76a3550b35080c ] = value;
        self setcodcastergametypestat( var_cf76a3550b35080c, value );
    }
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 1
// Checksum 0x0, Offset: 0x548
// Size: 0x1e
function function_815fee43d577e1b6( var_127743befe53da2e )
{
    function_5281975e60eac3a( var_127743befe53da2e );
    return self.var_a8f9789edd592f29[ var_127743befe53da2e ];
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 1
// Checksum 0x0, Offset: 0x56f
// Size: 0x1e
function function_a08fea26a49145a8( var_cf76a3550b35080c )
{
    function_b899bce95b7d6a94( var_cf76a3550b35080c );
    return self.var_e41d482461d4594f[ var_cf76a3550b35080c ];
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 1
// Checksum 0x0, Offset: 0x596
// Size: 0x3e
function function_aef8a28143d1f9ad( var_9138ab59ff517f7b )
{
    if ( !isdefined( self.var_1a34ed8eb5c6e9c ) )
    {
        self.var_1a34ed8eb5c6e9c = [];
    }
    
    if ( !isdefined( self.var_1a34ed8eb5c6e9c[ var_9138ab59ff517f7b ] ) )
    {
        self.var_1a34ed8eb5c6e9c[ var_9138ab59ff517f7b ] = 0;
    }
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 2
// Checksum 0x0, Offset: 0x5dc
// Size: 0x47
function function_1882f80b14421089( var_9138ab59ff517f7b, increment )
{
    function_aef8a28143d1f9ad( var_9138ab59ff517f7b );
    self.var_1a34ed8eb5c6e9c[ var_9138ab59ff517f7b ] += increment;
    function_5a82c337b996baa5( var_9138ab59ff517f7b, self.var_1a34ed8eb5c6e9c[ var_9138ab59ff517f7b ] );
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 2
// Checksum 0x0, Offset: 0x62b
// Size: 0x3a
function function_5a82c337b996baa5( var_9138ab59ff517f7b, value )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    function_aef8a28143d1f9ad( var_9138ab59ff517f7b );
    self.var_1a34ed8eb5c6e9c[ var_9138ab59ff517f7b ] = value;
    function_ad829fab97971b4b( var_9138ab59ff517f7b );
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 1
// Checksum 0x0, Offset: 0x66d
// Size: 0x1e
function function_e42724fbfacff469( var_9138ab59ff517f7b )
{
    function_aef8a28143d1f9ad( var_9138ab59ff517f7b );
    return self.var_1a34ed8eb5c6e9c[ var_9138ab59ff517f7b ];
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 1
// Checksum 0x0, Offset: 0x694
// Size: 0x123
function function_ad829fab97971b4b( var_9138ab59ff517f7b )
{
    if ( var_9138ab59ff517f7b == 0 || var_9138ab59ff517f7b == 1 )
    {
        function_7ee466e81b1afc12( 0, function_1b32a33893becbcf() );
        return;
    }
    
    if ( var_9138ab59ff517f7b == 6 )
    {
        consecutivekills = self.var_1a34ed8eb5c6e9c[ 6 ];
        function_7ee466e81b1afc12( 6, consecutivekills );
        var_51538fe8520e4052 = function_815fee43d577e1b6( 7 );
        
        if ( consecutivekills > var_51538fe8520e4052 )
        {
            function_7ee466e81b1afc12( 7, consecutivekills );
        }
        
        return;
    }
    
    if ( var_9138ab59ff517f7b == 3 )
    {
        var_128ce76c9c22e1bc = self.var_1a34ed8eb5c6e9c[ 3 ];
        function_f8b808cd6473e6cc( 13, function_d1f982e1e54336ec( var_128ce76c9c22e1bc ) );
        function_f8b808cd6473e6cc( 14, function_d6a8339d07d64d73( var_128ce76c9c22e1bc ) );
        function_f8b808cd6473e6cc( 1, dividestats( function_a08fea26a49145a8( 0 ), var_128ce76c9c22e1bc ) );
        return;
    }
    
    if ( var_9138ab59ff517f7b == 4 )
    {
        var_b39bb65d413613b6 = self.var_1a34ed8eb5c6e9c[ 4 ];
        function_f8b808cd6473e6cc( 5, function_d1f982e1e54336ec( var_b39bb65d413613b6 ) );
        function_f8b808cd6473e6cc( 6, function_d6a8339d07d64d73( var_b39bb65d413613b6 ) );
        return;
    }
    
    if ( var_9138ab59ff517f7b == 5 )
    {
        if ( function_726f071c1f349dd4() )
        {
            function_48544e365f4f5648( 12, 1 );
        }
        
        return;
    }
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 0
// Checksum 0x0, Offset: 0x7bf
// Size: 0x29, Type: bool
function function_726f071c1f349dd4()
{
    function_b899bce95b7d6a94( 12 );
    return floor( self.var_1a34ed8eb5c6e9c[ 5 ] ) > self.var_e41d482461d4594f[ 12 ];
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 0
// Checksum 0x0, Offset: 0x7f1
// Size: 0x73
function function_1b32a33893becbcf()
{
    if ( !isdefined( self.var_1a34ed8eb5c6e9c ) || !isdefined( self.var_1a34ed8eb5c6e9c[ 0 ] ) || !isdefined( self.var_1a34ed8eb5c6e9c[ 1 ] ) )
    {
        return 0;
    }
    
    shots = self.var_1a34ed8eb5c6e9c[ 0 ];
    
    if ( shots <= 0 )
    {
        return 0;
    }
    
    hits = self.var_1a34ed8eb5c6e9c[ 1 ];
    return hits / shots;
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 1
// Checksum 0x0, Offset: 0x86d
// Size: 0x21
function function_d1f982e1e54336ec( var_3436f757aee9ef90 )
{
    return dividestats( self.pers[ "kills" ], var_3436f757aee9ef90 );
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 1
// Checksum 0x0, Offset: 0x897
// Size: 0x1a
function function_d6a8339d07d64d73( var_3436f757aee9ef90 )
{
    return dividestats( function_815fee43d577e1b6( 1 ), var_3436f757aee9ef90 );
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 2
// Checksum 0x0, Offset: 0x8ba
// Size: 0x2f
function dividestats( stat, denominator )
{
    if ( !isdefined( stat ) || !isdefined( denominator ) || denominator <= 0 )
    {
        return 0;
    }
    
    return stat / denominator;
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 1
// Checksum 0x0, Offset: 0x8f2
// Size: 0x2e4
function function_2e28105e6500a144( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    logstring( player.name + ": " );
    debugstring = "\t\tcodcasterClientStats: ";
    
    if ( isdefined( player.var_a8f9789edd592f29 ) )
    {
        foreach ( index, value in player.var_a8f9789edd592f29 )
        {
            if ( !isarray( value ) )
            {
                debugstring += value + "~ [" + index + "]" + " / ";
                continue;
            }
            
            foreach ( i, indexedvalue in value )
            {
                debugstring += indexedvalue + ",";
            }
            
            debugstring += "~ [" + index + "]" + " / ";
        }
    }
    
    logstring( debugstring );
    debugstring = "\t\tlocalCodcasterClientStat: ";
    
    if ( isdefined( player.var_1a34ed8eb5c6e9c ) )
    {
        foreach ( index, value in player.var_1a34ed8eb5c6e9c )
        {
            if ( !isarray( value ) )
            {
                debugstring += value + "~ [" + index + "]" + " / ";
                continue;
            }
            
            foreach ( i, indexedvalue in value )
            {
                debugstring += indexedvalue + ",";
            }
            
            debugstring += "~ [" + index + "]" + " / ";
        }
    }
    
    logstring( debugstring );
    debugstring = "\t\tcodcasterGametypeClientStats: ";
    
    if ( isdefined( player.var_e41d482461d4594f ) )
    {
        foreach ( index, value in player.var_e41d482461d4594f )
        {
            if ( !isarray( value ) )
            {
                debugstring += value + "~ [" + index + "]" + " / ";
                continue;
            }
            
            foreach ( indexedvalue in value )
            {
                debugstring += indexedvalue + ",";
            }
            
            debugstring += "~ [" + index + "]" + " / ";
        }
    }
    
    logstring( debugstring );
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 0
// Checksum 0x0, Offset: 0xbde
// Size: 0xe3
function function_edba1ee7c2375a5()
{
    game[ "codcasterClientStatsSaveBetweenRounds" ] = [];
    game[ "localCodcasterClientStatsSaveBetweenRounds" ] = [];
    game[ "codcasterGametypeClientStatsSaveBetweenRounds" ] = [];
    
    foreach ( player in level.players )
    {
        if ( getdvarint( @"hash_b0b065fcee59b58d", 0 ) == 1 )
        {
            function_2e28105e6500a144( player );
        }
        
        game[ "codcasterClientStatsSaveBetweenRounds" ][ player.guid ] = player.var_a8f9789edd592f29;
        game[ "localCodcasterClientStatsSaveBetweenRounds" ][ player.guid ] = player.var_1a34ed8eb5c6e9c;
        game[ "codcasterGametypeClientStatsSaveBetweenRounds" ][ player.guid ] = player.var_e41d482461d4594f;
    }
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 0
// Checksum 0x0, Offset: 0xcc9
// Size: 0x20a
function function_9b229b18b0750bad()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( game[ "codcasterClientStatsSaveBetweenRounds" ] ) || !isdefined( game[ "localCodcasterClientStatsSaveBetweenRounds" ] ) )
    {
        return;
    }
    
    if ( isdefined( game[ "codcasterClientStatsSaveBetweenRounds" ][ self.guid ] ) )
    {
        self.var_a8f9789edd592f29 = game[ "codcasterClientStatsSaveBetweenRounds" ][ self.guid ];
    }
    else
    {
        self.var_a8f9789edd592f29 = [];
    }
    
    if ( isdefined( game[ "localCodcasterClientStatsSaveBetweenRounds" ][ self.guid ] ) )
    {
        self.var_1a34ed8eb5c6e9c = game[ "localCodcasterClientStatsSaveBetweenRounds" ][ self.guid ];
    }
    else
    {
        self.var_1a34ed8eb5c6e9c = [];
    }
    
    if ( isdefined( game[ "codcasterGametypeClientStatsSaveBetweenRounds" ][ self.guid ] ) )
    {
        self.var_e41d482461d4594f = game[ "codcasterGametypeClientStatsSaveBetweenRounds" ][ self.guid ];
    }
    else
    {
        self.var_e41d482461d4594f = [];
    }
    
    if ( getdvarint( @"hash_b0b065fcee59b58d", 0 ) == 1 )
    {
        logstring( "=========================== retrieveCodcasterClientStats ==============================" );
        function_2e28105e6500a144( self );
    }
    
    foreach ( statid, statvalue in self.var_a8f9789edd592f29 )
    {
        if ( !isarray( self.var_a8f9789edd592f29[ statid ] ) )
        {
            function_7ee466e81b1afc12( statid, statvalue );
            continue;
        }
        
        foreach ( index, value in self.var_a8f9789edd592f29[ statid ] )
        {
            function_6807ed320b73be7f( statid, index, value );
        }
    }
    
    foreach ( statid, statvalue in self.var_e41d482461d4594f )
    {
        self setcodcastergametypestat( statid, statvalue );
    }
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 3
// Checksum 0x0, Offset: 0xedb
// Size: 0x396
function function_ee3acf6a8baa2ff8( killtime, attacker, victim )
{
    if ( !isdefined( level.var_b33b6a18519b1bbe ) )
    {
        level.var_b33b6a18519b1bbe = [];
    }
    
    if ( isdefined( victim ) && isdefined( attacker ) )
    {
        if ( attacker.team != victim.team )
        {
            var_c7169d94937c6c29 = 0;
            liveremaining = scripts\mp\utility\teams::getteamdata( victim.team, "livesCount" );
            
            switch ( level.gametype )
            {
                case #"hash_a1313b745c17c07e":
                    var_c7169d94937c6c29 = scripts\mp\utility\teams::getteamdata( victim.team, "livesCount" ) == 0 && scripts\mp\utility\teams::getfriendlyplayers( victim.team, 1 ).size == 0;
                    break;
                case #"hash_aac44b0b52bacb8e":
                case #"hash_fa50b0f6bd82e972":
                    var_c7169d94937c6c29 = scripts\mp\utility\teams::getteamdata( victim.team, "aliveCount" ) == 0;
                    break;
                default:
                    var_c7169d94937c6c29 = 0;
                    break;
            }
            
            if ( var_c7169d94937c6c29 )
            {
                if ( isdefined( attacker.pers[ "inapplicableTradedKills" ] ) && isdefined( victim.pers[ "inapplicableTradedDeaths" ] ) )
                {
                    attacker scripts\mp\utility\stats::incpersstat( "inapplicableTradedKills", 1 );
                    victim scripts\mp\utility\stats::incpersstat( "inapplicableTradedDeaths", 1 );
                }
            }
            else
            {
                if ( isdefined( victim.pers[ "untradedDeaths" ] ) )
                {
                    victim scripts\mp\utility\stats::incpersstat( "untradedDeaths", 1 );
                }
                
                attacker function_d16498b27251da56( 5, 1 );
            }
            
            newentry = [];
            newentry[ "killtime" ] = killtime;
            newentry[ "attacker" ] = attacker;
            newentry[ "victim" ] = victim;
            
            while ( self.var_b33b6a18519b1bbe.size > 0 && killtime - self.var_b33b6a18519b1bbe[ 0 ][ "killtime" ] > 5000 )
            {
                self.var_b33b6a18519b1bbe = array_remove_index( self.var_b33b6a18519b1bbe, 0, 0 );
            }
            
            for ( entryindex = self.var_b33b6a18519b1bbe.size - 1; entryindex >= 0 ; entryindex-- )
            {
                entry = self.var_b33b6a18519b1bbe[ entryindex ];
                
                if ( isdefined( entry ) && isdefined( entry[ "attacker" ] ) && isdefined( entry[ "victim" ] ) )
                {
                    if ( entry[ "attacker" ] == victim )
                    {
                        if ( victim.lastkilledplayer == entry[ "victim" ] )
                        {
                            if ( isdefined( entry[ "attacker" ].pers[ "tradedKills" ] ) && isdefined( entry[ "victim" ].pers[ "untradedDeaths" ] ) && isdefined( entry[ "victim" ].pers[ "tradedDeaths" ] ) )
                            {
                                entry[ "attacker" ] function_d16498b27251da56( 5, -1 );
                                entry[ "victim" ] function_d16498b27251da56( 9, 1 );
                                entry[ "attacker" ] scripts\mp\utility\stats::incpersstat( "tradedKills", 1 );
                                entry[ "victim" ] scripts\mp\utility\stats::incpersstat( "untradedDeaths", -1 );
                                entry[ "victim" ] scripts\mp\utility\stats::incpersstat( "tradedDeaths", 1 );
                            }
                        }
                        
                        self.var_b33b6a18519b1bbe = array_remove_index( self.var_b33b6a18519b1bbe, entryindex, 0 );
                    }
                }
            }
            
            self.var_b33b6a18519b1bbe[ self.var_b33b6a18519b1bbe.size ] = newentry;
            return;
        }
        
        if ( isdefined( victim.pers[ "untradedDeaths" ] ) )
        {
            victim scripts\mp\utility\stats::incpersstat( "untradedDeaths", 1 );
        }
    }
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 2
// Checksum 0x0, Offset: 0x1279
// Size: 0x22
function function_6f792f70ffe4cd4d( attacker, victim )
{
    level function_ee3acf6a8baa2ff8( gettime(), attacker, victim );
}

// Namespace codcasterclientmatchdata / scripts\mp\codcasterclientmatchdata
// Params 0
// Checksum 0x0, Offset: 0x12a3
// Size: 0x96
function function_94c8f3722d550646()
{
    if ( isdefined( level.var_bb581bb447e5a6a6 ) )
    {
        return;
    }
    
    isroundbasedgamemode = isroundbased();
    
    foreach ( player in level.players )
    {
        if ( isroundbasedgamemode )
        {
            player scripts\mp\codcasterclientmatchdata::function_1882f80b14421089( 4, 1 );
            continue;
        }
        
        player scripts\mp\codcasterclientmatchdata::function_1882f80b14421089( 3, 1 );
    }
    
    level.var_bb581bb447e5a6a6 = 1;
}

