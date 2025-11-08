#using scripts\common\ae_utility;
#using scripts\common\progression_utility;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_hud_util;
#using scripts\cp\cp_matchdata;
#using scripts\cp\cp_weaponrank;
#using scripts\cp\points;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\utility\script;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp\weapon;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\flags;

#namespace rank;

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x74f
// Size: 0x185
function init()
{
    level.scoreinfo = [];
    
    if ( ismp() )
    {
        xpscale = scripts\cp_mp\utility\game_utility::function_e3ef0908b595e8e1();
        
        if ( xpscale > 4 || xpscale < 0 )
        {
            exitlevel( 0 );
        }
        
        addglobalrankxpmultiplier( xpscale, "online_mp_xpscale" );
    }
    
    level.ranktable = [];
    level.weaponranktable = [];
    
    if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) == 1 )
    {
        level.maxrank = 0;
        level.maxelderrank = 0;
    }
    else
    {
        ranktablebundle = getranktablebundle();
        level.maxrank = ranktablebundle.var_3f2a88f2202def78;
        level.maxelderrank = ranktablebundle.maxelderrank;
    }
    
    for ( rankid = 0; rankid <= level.maxrank ; rankid++ )
    {
        rank = getrankbundle( ranktablebundle.ranklist[ rankid ].rank );
        level.ranktable[ rankid ][ 0 ] = rank.minxp;
        level.ranktable[ rankid ][ 1 ] = rank.xptonext;
        level.ranktable[ rankid ][ 2 ] = rank.maxxp;
    }
    
    if ( !function_ccf98e6391dd38b9() )
    {
        scripts\cp\cp_weaponrank::init();
    }
    
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
    level.prestigeextras = [];
    level thread onplayerconnect();
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x8dc
// Size: 0x80
function earnperiodicxp()
{
    self notify( "earnPeriodicXP" );
    self endon( "earnPeriodicXP" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    event = #"persistent_xp";
    
    while ( !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        waitframe();
    }
    
    if ( !scripts\cp\utility::is_wave_gametype() && !scripts\cp\utility::is_specops_gametype() )
    {
        if ( !ent_flag_exist( "player_spawned_with_loadout" ) )
        {
            ent_flag_init( "player_spawned_with_loadout" );
        }
        
        ent_flag_wait( "player_spawned_with_loadout" );
        return;
    }
    
    wait 15;
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x964
// Size: 0x17, Type: bool
function function_377a94f711d96927( type )
{
    return isdefined( level.scoreinfo[ type ] );
}

// Namespace rank / scripts\cp\rank
// Params 2
// Checksum 0x0, Offset: 0x984
// Size: 0x3d
function registerscoreinfomultiplier( type, multiplier )
{
    if ( !isxhash( type ) )
    {
        assertex( 1, type );
        type = getxhash( type );
    }
    
    level.scoreinfo_multiplier[ type ] = multiplier;
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x9c9
// Size: 0x3e
function function_6d17f84162f0d8f0( type )
{
    if ( !isxhash( type ) )
    {
        assertex( 1, type );
        type = getxhash( type );
    }
    
    return default_to( level.scoreinfo_multiplier[ type ], 1 );
}

// Namespace rank / scripts\cp\rank
// Params 3
// Checksum 0x0, Offset: 0xa10
// Size: 0x119
function registerscoreinfo( type, category, value )
{
    if ( !isxhash( type ) )
    {
        assertex( 1, type );
        type = getxhash( type );
    }
    
    if ( !isxhash( category ) )
    {
        assertex( 1, category );
        category = getxhash( category );
    }
    
    if ( category == #"value" )
    {
        level.scoreinfo_value[ type ] = value;
        
        if ( type == #"kill" )
        {
            setomnvar( "ui_game_type_kill_value", int( value ) );
        }
        
        return;
    }
    
    if ( category == #"xp" )
    {
        level.scoreinfo_xp[ type ] = value;
        return;
    }
    
    if ( category == #"isaward" )
    {
        level.var_f749dda4bf7912b[ type ] = value;
        return;
    }
    
    if ( category == #"hash_afa3cfee9cf8b4c6" )
    {
        level.var_6e43c80aedbeec75[ type ] = value;
        return;
    }
    
    if ( category == #"hash_582866801a05178b" )
    {
        level.var_ac143fe8d620124e[ type ] = value;
        return;
    }
    
    level.scoreinfo[ type ][ category ] = value;
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0xb31
// Size: 0x48
function getscoreinfovalue( type )
{
    if ( level.gametype == "incursion" )
    {
        return 50;
    }
    
    if ( !isxhash( type ) )
    {
        assertex( 1, type );
        type = getxhash( type );
    }
    
    return level.scoreinfo_value[ type ];
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0xb82
// Size: 0x48
function getscoreinfoxp( type )
{
    if ( level.gametype == "incursion" )
    {
        return 50;
    }
    
    if ( !isxhash( type ) )
    {
        assertex( 1, type );
        type = getxhash( type );
    }
    
    return level.scoreinfo_xp[ type ];
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0xbd3
// Size: 0x34, Type: bool
function function_34294184e90b96c( type )
{
    if ( !isxhash( type ) )
    {
        assertex( 1, type );
        type = getxhash( type );
    }
    
    return istrue( level.var_f749dda4bf7912b[ type ] );
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0xc10
// Size: 0x34, Type: bool
function function_e3dfd7e570749681( type )
{
    if ( !isxhash( type ) )
    {
        assertex( 1, type );
        type = getxhash( type );
    }
    
    return istrue( level.var_ac143fe8d620124e[ type ] );
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0xc4d
// Size: 0x38
function function_1e00d01d19fde519( type )
{
    if ( !isxhash( type ) )
    {
        assertex( 1, type );
        type = getxhash( type );
    }
    
    return getscoreinfocategory( type, #"hash_9ef9bbcd1edc198b" );
}

// Namespace rank / scripts\cp\rank
// Params 2
// Checksum 0x0, Offset: 0xc8e
// Size: 0xeb
function getscoreinfocategory( type, category )
{
    if ( !isxhash( type ) )
    {
        assertex( 1, type );
        type = getxhash( type );
    }
    
    if ( !isxhash( category ) )
    {
        assertex( 1, category );
        category = getxhash( category );
    }
    
    if ( istrue( level.removekilleventsplash ) && !isdefined( level.scoreinfo[ type ] ) )
    {
        return undefined;
    }
    
    if ( category == #"value" )
    {
        return getscoreinfovalue( type );
    }
    else if ( category == #"xp" )
    {
        return getscoreinfoxp( type );
    }
    else if ( category == #"isaward" )
    {
        return function_34294184e90b96c( type );
    }
    else if ( category == #"hash_582866801a05178b" )
    {
        return function_e3dfd7e570749681( type );
    }
    
    if ( !isdefined( level.scoreinfo[ type ] ) )
    {
        return undefined;
    }
    
    return level.scoreinfo[ type ][ category ];
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0xd82
// Size: 0x4a5
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( "connected", player );
        
        if ( !isai( player ) )
        {
            if ( level.playerxpenabled )
            {
                player.pers[ "rankxp" ] = player getplayerdata( "cploadouts", "squadMembers", "player_xp" );
                prestige = player getplayerdata( "cploadouts", "squadMembers", "season_rank" );
                
                if ( !isdefined( player.pers[ "xpEarnedThisMatch" ] ) )
                {
                    player.pers[ "xpEarnedThisMatch" ] = 0;
                }
            }
            else
            {
                prestige = 0;
                player.pers[ "rankxp" ] = 0;
            }
        }
        else
        {
            prestige = 0;
            player.pers[ "rankxp" ] = 0;
        }
        
        player.pers[ "prestige" ] = prestige;
        
        if ( player.pers[ "rankxp" ] < 0 )
        {
            player.pers[ "rankxp" ] = 0;
        }
        
        rankid = player getrankforxp( player getrankxp() );
        player.pers[ "rank" ] = rankid;
        player setrank( rankid, prestige );
        player.pers[ "participation" ] = 0;
        player.scoreupdatetotal = 0;
        player.scorepointsqueue = 0;
        player.scoreeventqueue = [];
        player.postgamepromotion = 0;
        player setclientdvar( @"ui_promotion", 0 );
        
        if ( !isdefined( player.pers[ "summary" ] ) )
        {
            player.pers[ "summary" ] = [];
            player.pers[ "summary" ][ "xp" ] = 0;
            player.pers[ "summary" ][ "score" ] = 0;
            player.pers[ "summary" ][ "challenge" ] = 0;
            player.pers[ "summary" ][ "match" ] = 0;
            player.pers[ "summary" ][ "misc" ] = 0;
            player.pers[ "summary" ][ "medal" ] = 0;
            player.pers[ "summary" ][ "bonusXP" ] = 0;
            player.pers[ "summary" ][ "weaponXP" ] = 0;
            player.pers[ "summary" ][ "operatorXP" ] = 0;
            player.pers[ "summary" ][ "clanXP" ] = 0;
            player.pers[ "summary" ][ "battlepassXP" ] = 0;
        }
        
        if ( !isdefined( player.pers[ "aarData" ] ) )
        {
            player.pers[ "aarData" ][ "combat_xp" ] = 0;
            player.pers[ "aarData" ][ "support_xp" ] = 0;
            player.pers[ "aarData" ][ "strategy_xp" ] = 0;
            player.pers[ "aarData" ][ "logistics_xp" ] = 0;
            player.pers[ "aarData" ][ "recon_xp" ] = 0;
            player.pers[ "aarData" ][ "use_featured_operator_skin_xp" ] = 0;
        }
        
        player setclientdvar( @"hash_cbb22e2fb1a57873", 0 );
        
        if ( level.playerxpenabled )
        {
            partyxpscale = getdvarint( @"online_mp_party_xpscale" );
            isinparty = player getprivatepartysize() > 1;
            
            if ( isinparty )
            {
                player addrankxpmultiplier( partyxpscale, "online_mp_party_xpscale" );
            }
            
            if ( player getplayerdata( "mp", "prestigeDoubleWeaponXp" ) )
            {
                player.prestigedoubleweaponxp = 1;
            }
            else
            {
                player.prestigedoubleweaponxp = 0;
            }
            
            value = getdvarint( @"hash_80e8af1bddc54017", 40000 );
            player.maxxpcap = value;
            player.totalxpearned = 0;
        }
        
        player.scoreeventcount = 0;
        player.scoreeventlistindex = 0;
        player.totalmuncurrencyearned = 0;
        player.maxmuncurrencycap = 3000;
        
        if ( getdvarint( @"hash_be472c16efcee2bf", 0 ) && !scripts\cp\utility::is_specops_gametype() && !scripts\cp\utility::is_wave_gametype() )
        {
            player thread earnperiodicxp();
        }
    }
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x122f
// Size: 0x94
function onplayerspawned()
{
    if ( isai( self ) )
    {
    }
    else if ( !level.playerxpenabled )
    {
        self.pers[ "rankxp" ] = 0;
    }
    else if ( !scripts\cp\utility::is_specops_gametype() && !scripts\cp\utility::function_a3577e8e6c88a56b() && !scripts\cp\utility::function_f620e996a1d7d81a() && !scripts\cp\utility::function_240f7f4e57340e8f() )
    {
        assertex( isdefined( self.class ), "Player should have class here." );
        assertex( isdefined( self.class_num ), "Player should have class_num here." );
    }
    
    playerupdaterank();
    playerinitpersstats();
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x12cb
// Size: 0xb7
function playerupdaterank()
{
    if ( self.pers[ "rankxp" ] < 0 )
    {
        self.pers[ "rankxp" ] = 0;
    }
    
    rankid = getrankforxp( getrankxp() );
    self.pers[ "rank" ] = rankid;
    
    if ( isai( self ) || !isdefined( self.pers[ "prestige" ] ) )
    {
        if ( level.playerxpenabled && isdefined( self.bufferedstats ) )
        {
            prestige = getprestigelevel();
        }
        else
        {
            prestige = 0;
        }
        
        self setrank( rankid, prestige );
        self.pers[ "prestige" ] = prestige;
    }
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x138a
// Size: 0x26
function playerinitpersstats()
{
    scripts\cp\cp_matchdata::initpersstat( "lastBulletKillTime" );
    scripts\cp\cp_matchdata::initpersstat( "bulletStreak" );
    scripts\cp\cp_matchdata::initpersstat( "assists" );
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x13b8
// Size: 0x85
function tryresetrankxp()
{
    assertex( isdefined( self.class ), "Player should have class here." );
    
    if ( issubstr( self.class, "custom" ) )
    {
        if ( !level.playerxpenabled )
        {
            self.pers[ "rankxp" ] = 0;
            return;
        }
        
        if ( isai( self ) )
        {
            self.pers[ "rankxp" ] = 0;
            return;
        }
        
        assertex( isdefined( self.class_num ), "Player should have class_num here." );
    }
}

// Namespace rank / scripts\cp\rank
// Params 8
// Checksum 0x0, Offset: 0x1445
// Size: 0x22a
function giverankxp( type, value, objweapon, suppresspopup, forceimmediate, var_339e50a026e4674f, var_b01aca3236595958, eventinfo )
{
    if ( scripts\cp\utility::function_240f7f4e57340e8f() )
    {
        return;
    }
    
    self endon( "disconnect" );
    
    if ( istrue( self.pers[ "ignoreWeaponKillXP" ] ) )
    {
        objweapon = undefined;
    }
    
    if ( isdefined( self.owner ) && !isbot( self ) && self != self.owner )
    {
        self.owner giverankxp( type, value, objweapon, suppresspopup, forceimmediate, var_339e50a026e4674f, var_b01aca3236595958, eventinfo );
        return;
    }
    
    if ( isai( self ) || !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( value ) )
    {
        assertmsg( getxhashsourcename( type ) + " attempted to give an undefined value for rankXP." );
        value = 0;
    }
    
    rateofgamerevenue = getplayerrateofgamerevenue( self );
    value = int( value * rateofgamerevenue );
    
    if ( !isdefined( suppresspopup ) )
    {
        suppresspopup = 0;
    }
    
    if ( !isdefined( forceimmediate ) )
    {
        forceimmediate = 0;
    }
    
    if ( !level.playerxpenabled )
    {
        if ( suppresspopup == 0 && level.var_27dcaf9644646944 == #"display_xp" )
        {
            var_b3a25cc5438cd047 = value;
            scripts\cp\points::displayscoreeventpoints( function_c465f9a27979c865( var_b3a25cc5438cd047, var_b01aca3236595958 ), type );
        }
        
        return;
    }
    
    if ( !isdefined( value ) || value == 0 )
    {
        return;
    }
    
    var_a29c313ec2ad5e22 = getscoreinfocategory( type, #"allowbonus" );
    bonusmultiplier = 1;
    modifiedvalue = value;
    bonusxp = 0;
    
    if ( istrue( var_a29c313ec2ad5e22 ) )
    {
        bonusmultiplier = getrankxpmultipliertotal();
        modifiedvalue = int( value * bonusmultiplier );
        bonusxp = int( max( modifiedvalue - value, 0 ) );
    }
    
    if ( !suppresspopup && level.var_27dcaf9644646944 == #"display_xp" )
    {
        displayscoreeventpoints( function_c465f9a27979c865( modifiedvalue, var_b01aca3236595958 ), type );
    }
    
    if ( !function_ccf98e6391dd38b9() )
    {
        thread waitandapplyxp( type, value, modifiedvalue, bonusxp, objweapon, forceimmediate, var_339e50a026e4674f, var_b01aca3236595958, eventinfo );
    }
}

// Namespace rank / scripts\cp\rank
// Params 9
// Checksum 0x0, Offset: 0x1677
// Size: 0x27f
function waitandapplyxp( type, originalvalue, modifiedvalue, bonusxp, objweapon, forceimmediate, var_339e50a026e4674f, var_b01aca3236595958, eventinfo )
{
    self endon( "disconnect" );
    
    if ( istrue( self.pers[ "ignoreWeaponKillXP" ] ) )
    {
        objweapon = undefined;
    }
    
    if ( !isdefined( forceimmediate ) )
    {
        forceimmediate = 0;
    }
    
    if ( !forceimmediate )
    {
        waitframe();
        scripts\cp\utility\script::waittillslowprocessallowed();
    }
    
    oldxp = getrankxp();
    
    if ( updaterank( oldxp ) )
    {
    }
    
    /#
        function_f440a654d455343e( type, modifiedvalue );
    #/
    
    syncxpstat();
    weapon_xp = 0;
    
    if ( !istrue( var_339e50a026e4674f ) )
    {
        if ( !isdefined( objweapon ) )
        {
            if ( isdefined( self.lastcacweaponobj ) )
            {
                objweapon = self.lastcacweaponobj;
            }
            else if ( isdefined( self.lastdroppableweaponobj ) )
            {
                objweapon = self.lastdroppableweaponobj;
            }
        }
        
        if ( isdefined( objweapon ) )
        {
            objweapon = function_1e3102980c3a4cc1( objweapon );
            
            if ( scripts\cp\cp_weaponrank::weaponshouldgetxp( objweapon.basename ) )
            {
                if ( istrue( level.var_d45cbfd4ecd2662c ) )
                {
                    weapon_xp = [[ level.var_d45cbfd4ecd2662c ]]( type );
                }
                else
                {
                    weapon_xp = originalvalue;
                    weapon_xp *= scripts\cp\cp_weaponrank::getweaponrankxpmultipliertotal();
                    weapon_xp = int( weapon_xp );
                }
            }
        }
    }
    
    battlepassxp = originalvalue;
    modifiedvalue = function_c465f9a27979c865( modifiedvalue, var_b01aca3236595958 );
    bonusxp = function_78802b8c6de6eeba( bonusxp, var_b01aca3236595958 );
    originalvalue = function_736110bfd2a3a5ea( originalvalue, var_b01aca3236595958 );
    weapon_xp = function_199d881c43179c3f( weapon_xp, var_b01aca3236595958 );
    incrankxp( modifiedvalue, objweapon, weapon_xp, type, battlepassxp );
    
    if ( level.playerxpenabled && !isai( self ) )
    {
        if ( isdefined( objweapon ) && ( scripts\cp\weapon::iscacprimaryweapon( objweapon ) || scripts\cp\weapon::iscacsecondaryweapon( objweapon ) ) )
        {
            var_7e2c53b0bcf117d9 = spawnstruct();
            var_7e2c53b0bcf117d9.weaponname = scripts\cp_mp\weapon::getweaponrootname( objweapon );
            var_7e2c53b0bcf117d9.fullweaponname = getcompleteweaponname( objweapon );
            var_7e2c53b0bcf117d9.statname = "xp_earned";
            var_7e2c53b0bcf117d9.incvalue = weapon_xp;
            var_7e2c53b0bcf117d9.variantid = -1;
            scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_update_weapon_stats", var_7e2c53b0bcf117d9 );
        }
    }
    
    recordxpgains( type, originalvalue, bonusxp );
    function_b933d0652ec01b54( type, originalvalue, bonusxp, eventinfo );
    current_prestige = getprestigelevel();
    current_rank = getrank();
}

// Namespace rank / scripts\cp\rank
// Params 2
// Checksum 0x0, Offset: 0x18fe
// Size: 0x35
function function_c465f9a27979c865( value, var_b01aca3236595958 )
{
    if ( isdefined( var_b01aca3236595958 ) && isdefined( var_b01aca3236595958.finalxp ) )
    {
        return var_b01aca3236595958.finalxp;
    }
    
    return value;
}

// Namespace rank / scripts\cp\rank
// Params 2
// Checksum 0x0, Offset: 0x193c
// Size: 0x35
function function_78802b8c6de6eeba( value, var_b01aca3236595958 )
{
    if ( isdefined( var_b01aca3236595958 ) && isdefined( var_b01aca3236595958.bonusxp ) )
    {
        return var_b01aca3236595958.bonusxp;
    }
    
    return value;
}

// Namespace rank / scripts\cp\rank
// Params 2
// Checksum 0x0, Offset: 0x197a
// Size: 0x35
function function_736110bfd2a3a5ea( value, var_b01aca3236595958 )
{
    if ( isdefined( var_b01aca3236595958 ) && isdefined( var_b01aca3236595958.basexp ) )
    {
        return var_b01aca3236595958.basexp;
    }
    
    return value;
}

// Namespace rank / scripts\cp\rank
// Params 2
// Checksum 0x0, Offset: 0x19b8
// Size: 0x35
function function_199d881c43179c3f( value, var_b01aca3236595958 )
{
    if ( isdefined( var_b01aca3236595958 ) && isdefined( var_b01aca3236595958.weaponxp ) )
    {
        return var_b01aca3236595958.weaponxp;
    }
    
    return value;
}

// Namespace rank / scripts\cp\rank
// Params 4
// Checksum 0x0, Offset: 0x19f6
// Size: 0x78
function function_b933d0652ec01b54( type, var_7c6b134e84356e37, bonusxp, eventinfo )
{
    if ( !isxhash( type ) )
    {
        type = getxhash( type );
    }
    
    xpcategory = undefined;
    
    if ( isdefined( xpcategory ) )
    {
        totalxp = var_7c6b134e84356e37 + bonusxp;
        self.pers[ "aarData" ][ xpcategory ] = self.pers[ "aarData" ][ xpcategory ] + totalxp;
    }
}

// Namespace rank / scripts\cp\rank
// Params 3
// Checksum 0x0, Offset: 0x1a76
// Size: 0x4d3
function recordxpgains( type, var_7c6b134e84356e37, bonusxp )
{
    var_61339cc7c44bde8b = var_7c6b134e84356e37 + bonusxp;
    group = getscoreinfocategory( type, #"group" );
    
    if ( !isdefined( self.pers[ "summary" ] ) )
    {
        self.pers[ "summary" ] = [];
        self.pers[ "summary" ][ "xp" ] = 0;
        self.pers[ "summary" ][ "score" ] = 0;
        self.pers[ "summary" ][ "challenge" ] = 0;
        self.pers[ "summary" ][ "match" ] = 0;
        self.pers[ "summary" ][ "misc" ] = 0;
        self.pers[ "summary" ][ "medal" ] = 0;
        self.pers[ "summary" ][ "bonusXP" ] = 0;
        self.pers[ "summary" ][ "weaponXP" ] = 0;
        self.pers[ "summary" ][ "operatorXP" ] = 0;
        self.pers[ "summary" ][ "clanXP" ] = 0;
        self.pers[ "summary" ][ "battlepassXP" ] = 0;
    }
    
    if ( !isdefined( group ) || group == "" )
    {
        /#
            println( "<dev string:x1c>" + var_61339cc7c44bde8b );
            println( "<dev string:x2e>" + bonusxp );
        #/
        
        self.pers[ "summary" ][ "misc" ] = self.pers[ "summary" ][ "misc" ] + var_7c6b134e84356e37;
        self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
        self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_61339cc7c44bde8b;
        return;
    }
    
    switch ( group )
    {
        case #"hash_a7e252caaf292eee":
            self.pers[ "summary" ][ "match" ] = self.pers[ "summary" ][ "match" ] + var_7c6b134e84356e37;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_61339cc7c44bde8b;
            break;
        case #"hash_5b8ea26626b7f31e":
            /#
                println( "<dev string:x41>" + var_61339cc7c44bde8b );
                println( "<dev string:x2e>" + bonusxp );
            #/
            
            self.pers[ "summary" ][ "challenge" ] = self.pers[ "summary" ][ "challenge" ] + var_7c6b134e84356e37;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_61339cc7c44bde8b;
            break;
        case #"hash_5ecdb5d7fae048c":
            /#
                println( "<dev string:x58>" + var_61339cc7c44bde8b );
                println( "<dev string:x2e>" + bonusxp );
            #/
            
            self.pers[ "summary" ][ "medal" ] = self.pers[ "summary" ][ "medal" ] + var_7c6b134e84356e37;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_61339cc7c44bde8b;
            break;
        default:
            /#
                println( "<dev string:x6b>" + var_61339cc7c44bde8b );
                println( "<dev string:x2e>" + bonusxp );
            #/
            
            self.pers[ "summary" ][ "score" ] = self.pers[ "summary" ][ "score" ] + var_7c6b134e84356e37;
            self.pers[ "summary" ][ "bonusXP" ] = self.pers[ "summary" ][ "bonusXP" ] + bonusxp;
            self.pers[ "summary" ][ "xp" ] = self.pers[ "summary" ][ "xp" ] + var_61339cc7c44bde8b;
            break;
    }
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x1f51
// Size: 0xf6, Type: bool
function updaterank( oldxp )
{
    newrank = getrank();
    newprestige = getprestigelevel();
    var_e6633fe0fb633e52 = self.pers[ "rank" ] + self.pers[ "prestige" ];
    var_7a8cd849f0dbf2c7 = newrank + newprestige;
    self.pers[ "rank" ] = newrank;
    self.pers[ "prestige" ] = newprestige;
    
    if ( var_7a8cd849f0dbf2c7 == var_e6633fe0fb633e52 || var_7a8cd849f0dbf2c7 >= level.maxrank + level.maxelderrank )
    {
        return false;
    }
    
    println( "<dev string:x7d>" + self.name + "<dev string:x87>" + var_e6633fe0fb633e52 + "<dev string:x93>" + var_7a8cd849f0dbf2c7 + "<dev string:x98>" + oldxp + "<dev string:x93>" + getrankxp() + "<dev string:xb0>" );
    self setrank( newrank, newprestige );
    return true;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2050
// Size: 0xe1
function updaterankannouncehud()
{
    self endon( "disconnect" );
    self notify( "update_rank" );
    self endon( "update_rank" );
    team = self.pers[ "team" ];
    
    if ( !isdefined( team ) )
    {
        return;
    }
    
    if ( !scripts\mp\flags::levelflag( "game_over" ) )
    {
        level waittill_notify_or_timeout( "game_over", 0.25 );
    }
    
    newrank = self.pers[ "rank" ] + self.pers[ "prestige" ];
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        playerteam = player.pers[ "team" ];
        
        if ( isdefined( playerteam ) && playerteam == team )
        {
        }
    }
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x2139
// Size: 0x1f
function queuescorepointspopup( amount )
{
    self.scorepointsqueue += amount;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2160
// Size: 0x1c
function flushscorepointspopupqueue()
{
    scorepointspopup( self.scorepointsqueue );
    self.scorepointsqueue = 0;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2184
// Size: 0x3b
function flushscorepointspopupqueueonspawn()
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    self notify( "flushScorePointsPopupQueueOnSpawn()" );
    self endon( "flushScorePointsPopupQueueOnSpawn()" );
    self waittill( "spawned_player" );
    wait 0.1;
    flushscorepointspopupqueue();
}

// Namespace rank / scripts\cp\rank
// Params 2
// Checksum 0x0, Offset: 0x21c7
// Size: 0xc8
function scorepointspopup( amount, var_644b10fb91c1254c )
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    
    if ( amount == 0 )
    {
        return;
    }
    
    if ( !isreallyalive( self ) && !self iscodcaster() && !isusingremote() )
    {
        if ( !istrue( var_644b10fb91c1254c ) || isinkillcam() )
        {
            queuescorepointspopup( amount );
            thread flushscorepointspopupqueueonspawn();
            return;
        }
    }
    
    self notify( "scorePointsPopup" );
    self endon( "scorePointsPopup" );
    self.scoreupdatetotal += amount;
    self setclientomnvar( "ui_points_popup", self.scoreupdatetotal );
    self setclientomnvar( "ui_points_popup_notify", gettime() );
    wait 1;
    self.scoreupdatetotal = 0;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2297
// Size: 0x15
function notifyplayerscore()
{
    waitframe();
    level notify( "update_player_score", self, self.scoreupdatetotal );
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x22b4
// Size: 0x21
function queuescoreeventpopup( event )
{
    self.scoreeventqueue[ self.scoreeventqueue.size ] = event;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x22dd
// Size: 0x5d
function flushscoreeventpopupqueue()
{
    foreach ( event in self.scoreeventqueue )
    {
        scoreeventpopup( event );
    }
    
    self.scoreeventqueue = [];
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2342
// Size: 0x3b
function flushscoreeventpopupqueueonspawn()
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    self endon( "joined_spectators" );
    self notify( "flushScoreEventPopupQueueOnSpawn()" );
    self endon( "flushScoreEventPopupQueueOnSpawn()" );
    self waittill( "spawned_player" );
    wait 0.1;
    flushscoreeventpopupqueue();
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x2385
// Size: 0x45
function getscoreeventpriority( event )
{
    if ( getdvarint( @"hash_a3a1cab75dca6cc6", 0 ) == 1 )
    {
        return 0;
    }
    
    value = getscoreinfocategory( event, #"priority" );
    
    if ( !istrue( value ) )
    {
        return 0;
    }
    
    return value;
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x23d3
// Size: 0x46, Type: bool
function scoreeventalwaysshowassplash( event )
{
    if ( getdvarint( @"hash_a3a1cab75dca6cc6", 0 ) == 1 )
    {
        return false;
    }
    
    value = getscoreinfocategory( event, #"alwaysshowsplash" );
    
    if ( !istrue( value ) )
    {
        return false;
    }
    
    return true;
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x2422
// Size: 0x3a, Type: bool
function scoreeventhastext( event )
{
    if ( getdvarint( @"hash_a3a1cab75dca6cc6", 0 ) == 1 )
    {
        return false;
    }
    
    if ( !istrue( getscoreinfocategory( event, #"hastext" ) ) )
    {
        return false;
    }
    
    return true;
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x2465
// Size: 0x1c2
function scoreeventpopup( event )
{
    if ( getdvarint( @"hash_a3a1cab75dca6cc6", 0 ) == 1 )
    {
        return;
    }
    
    if ( isdefined( self.owner ) && self.owner != self )
    {
        self.owner scoreeventpopup( event );
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    isscriptbundlesplash = 0;
    text = undefined;
    splashid = scripts\cp\rank::function_1e00d01d19fde519( event );
    
    if ( isdefined( splashid ) )
    {
        isscriptbundlesplash = 1;
    }
    
    if ( !isdefined( splashid ) || splashid < 0 )
    {
        splashid = getscoreinfocategory( event, #"hash_edd89bb2cc2d506" );
    }
    
    if ( !isdefined( splashid ) || splashid < 0 )
    {
        return;
    }
    
    if ( !istrue( getscoreinfocategory( event, #"hastext" ) ) )
    {
        return;
    }
    
    if ( !isreallyalive( self ) && !self iscodcaster() && !isusingremote() )
    {
        queuescoreeventpopup( event );
        thread flushscoreeventpopupqueueonspawn();
        return;
    }
    
    if ( !isdefined( self.scoreeventlistsize ) )
    {
        self.scoreeventlistsize = 1;
        thread clearscoreeventlistafterwait();
    }
    else
    {
        self.scoreeventlistsize++;
        
        if ( self.scoreeventlistsize > 5 )
        {
            self.scoreeventlistsize = 5;
            println( "<dev string:xb2>" );
            return;
        }
    }
    
    self setclientomnvar( "ui_score_event_list_" + self.scoreeventlistindex, splashid );
    self setclientomnvar( "ui_score_event_use_splashbundle_" + self.scoreeventlistindex, isscriptbundlesplash );
    self setclientomnvar( "ui_score_event_control", self.scoreeventcount % 10 );
    self.scoreeventlistindex++;
    self.scoreeventlistindex %= 5;
    self.scoreeventcount++;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x262f
// Size: 0x33
function clearscoreeventlistafterwait()
{
    self endon( "disconnect" );
    self notify( "clearScoreEventListAfterWait()" );
    self endon( "clearScoreEventListAfterWait()" );
    waittill_notify_or_timeout( "death", 0.5 );
    self.scoreeventlistsize = undefined;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x266a
// Size: 0x57
function getrank()
{
    rankxp = self.pers[ "rankxp" ];
    rankid = self.pers[ "rank" ];
    
    if ( rankxp < getrankinfominxp( rankid ) + getrankinfoxpamt( rankid ) )
    {
        return rankid;
    }
    
    return getrankforxp( rankxp );
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x26c9
// Size: 0x63
function getrankforxp( xpval )
{
    rankid = level.maxrank;
    
    if ( xpval >= getrankinfominxp( rankid ) )
    {
        return rankid;
    }
    else
    {
        rankid--;
    }
    
    while ( rankid > 0 )
    {
        if ( xpval >= getrankinfominxp( rankid ) && xpval < getrankinfominxp( rankid ) + getrankinfoxpamt( rankid ) )
        {
            return rankid;
        }
        
        rankid--;
    }
    
    return rankid;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2735
// Size: 0x23
function getmatchbonusspm()
{
    ranklevel = getrank() + 1;
    return ( 3 + ranklevel * 0.5 ) * 10;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2761
// Size: 0x48
function getprestigelevel()
{
    if ( isai( self ) && isdefined( self.pers[ "prestige_fake" ] ) )
    {
        return self.pers[ "prestige_fake" ];
    }
    
    return self getplayerdata( "cploadouts", "squadMembers", "season_rank" );
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x27b1
// Size: 0x11
function getrankxp()
{
    return self.pers[ "rankxp" ];
}

// Namespace rank / scripts\cp\rank
// Params 6
// Checksum 0x0, Offset: 0x27cb
// Size: 0x4fc
function incrankxp( amount, objweapon, weapon_xp, type, var_158745de00c72d3e, var_b01aca3236595958 )
{
    if ( !level.playerxpenabled )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    eventname = #"mp_addxp";
    eventid = function_6e2deb013c9ca85e( eventname );
    
    if ( !isdefined( eventid ) )
    {
        return;
    }
    
    if ( !isdefined( level.maxbetarank ) )
    {
        level.maxbetarank = getdvarint( @"hash_75ff427bfdaf65e9", 0 );
    }
    
    if ( level.maxbetarank > 0 && getrank() + 1 >= level.maxbetarank )
    {
        amount = 0;
    }
    
    if ( !isdefined( var_158745de00c72d3e ) )
    {
        var_158745de00c72d3e = amount;
    }
    
    xp = getrankxp();
    newxp = int( min( xp + amount, getrankinfomaxxp( level.maxrank ) - 1 ) );
    
    if ( self.pers[ "rank" ] == level.maxrank && newxp >= getrankinfomaxxp( level.maxrank ) )
    {
        newxp = getrankinfomaxxp( level.maxrank );
    }
    
    self.pers[ "xpEarnedThisMatch" ] = self.pers[ "xpEarnedThisMatch" ] + amount;
    self.pers[ "rankxp" ] = newxp;
    weapon = "";
    weaponlootid = 0;
    
    if ( isdefined( objweapon ) )
    {
        weapon = scripts\cp_mp\weapon::getweaponrootname( objweapon.basename );
        
        if ( isdefined( level.weaponmapdata[ weapon ] ) && isdefined( level.weaponmapdata[ weapon ].weaponlootid ) )
        {
            weaponlootid = level.weaponmapdata[ weapon ].weaponlootid;
        }
    }
    
    weaponlootid = function_64ca1aa18fdeabc( weaponlootid, var_b01aca3236595958 );
    
    if ( weapon_xp > 0 && weaponlootid == 0 )
    {
        assertmsg( "Trying to add weaponXP to an invalid weapon" );
    }
    
    operatorid = 0;
    operatorscalar = function_6352822c84cb9722();
    operatorxp = amount * operatorscalar;
    operatorxp = int( operatorxp );
    clanxp = int( amount );
    xpeventparams = [];
    
    if ( amount > 0 )
    {
        function_ec8877db4e73e4e8( xpeventparams, eventname, #"value", amount );
    }
    
    if ( weapon_xp > 0 )
    {
        if ( level.onlinegame && self function_2129e0e4d014e1b3() )
        {
            weaponxpmult = getdvarfloat( @"hash_ae1bef48f6b2083c", 1.25 );
            weapon_xp = int( weapon_xp * weaponxpmult );
        }
        
        function_ec8877db4e73e4e8( xpeventparams, eventname, #"weapon_xp", weapon_xp );
        function_ec8877db4e73e4e8( xpeventparams, eventname, #"weapon_loot_id", weaponlootid );
    }
    
    if ( var_158745de00c72d3e > 0 )
    {
        xpeventparams[ xpeventparams.size ] = function_e2ff8f4b4e94f723( #"battlepass", #"xp" );
        xpeventparams[ xpeventparams.size ] = var_158745de00c72d3e;
    }
    
    if ( operatorxp > 0 )
    {
        operatorid = scripts\cp_mp\challenges::function_aff35122a61a900b( self.team );
        
        if ( isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.operatorref ) )
        {
            operatorid = int( tablelookup( "loot/operator_ids.csv", 1, self.operatorcustomization.operatorref, 0 ) );
        }
        
        assertex( operatorid != 0, "Trying to add operatorXP to an invalid operator" );
        function_ec8877db4e73e4e8( xpeventparams, eventname, #"operator_xp", operatorxp );
        function_ec8877db4e73e4e8( xpeventparams, eventname, #"hash_8fba2fc976d0515e", operatorid );
    }
    
    if ( clanxp > 0 )
    {
        function_ec8877db4e73e4e8( xpeventparams, eventname, #"clan_xp", clanxp );
    }
    
    function_ec8877db4e73e4e8( xpeventparams, eventname, #"version", 1 );
    self reportchallengeuserserializedevent( eventid, xpeventparams );
    self.pers[ "summary" ][ "weaponXP" ] = self.pers[ "summary" ][ "weaponXP" ] + weapon_xp;
    self.pers[ "summary" ][ "operatorXP" ] = self.pers[ "summary" ][ "operatorXP" ] + operatorxp;
    self.pers[ "summary" ][ "clanXP" ] = self.pers[ "summary" ][ "clanXP" ] + clanxp;
    self.pers[ "summary" ][ "battlepassXP" ] = self.pers[ "summary" ][ "battlepassXP" ] + var_158745de00c72d3e;
    
    if ( isdefined( var_158745de00c72d3e ) )
    {
        self.pers[ "summary" ][ "battlepassXP" ] = self.pers[ "summary" ][ "battlepassXP" ] + var_158745de00c72d3e;
    }
    
    scripts\cp\cp_analytics::logevent_xpearned( self, amount, weapon, weapon_xp, type );
}

// Namespace rank / scripts\cp\rank
// Params 2
// Checksum 0x0, Offset: 0x2ccf
// Size: 0x35
function function_64ca1aa18fdeabc( value, var_b01aca3236595958 )
{
    if ( isdefined( var_b01aca3236595958 ) && isdefined( var_b01aca3236595958.weaponlootid ) )
    {
        return var_b01aca3236595958.weaponlootid;
    }
    
    return value;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2d0d
// Size: 0x27
function function_6352822c84cb9722()
{
    playermodifier = function_4beaed7d0e5c5b78();
    globalmodifier = function_e7b697c34bea0fc1();
    return playermodifier * globalmodifier;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2d3d
// Size: 0x7c
function function_4beaed7d0e5c5b78()
{
    if ( !isdefined( self.var_2914ba3b302ca331 ) )
    {
        return 1;
    }
    
    modifiertotal = 1;
    
    foreach ( modifier in self.var_2914ba3b302ca331 )
    {
        if ( !isdefined( modifier ) )
        {
            continue;
        }
        
        modifiertotal *= modifier;
    }
    
    return modifiertotal;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2dc2
// Size: 0x9
function function_e7b697c34bea0fc1()
{
    return level function_4beaed7d0e5c5b78();
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2dd4
// Size: 0x5b
function syncxpstat()
{
    xp = getrankxp();
    oldxp = self getplayerdata( "common", "mpProgression", "playerLevel", "xp" );
    
    if ( oldxp > xp )
    {
        return;
    }
    
    self setplayerdata( "common", "mpProgression", "playerLevel", "xp", xp );
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2e37
// Size: 0x61
function getgametypexpmultiplier()
{
    if ( getdvarint( @"hash_78653010d584aa6e", 0 ) == 0 )
    {
        if ( !isdefined( level.gametypexpmodifier ) )
        {
            level.gametypexpmodifier = float( tablelookup( "mp/gametypesTable.csv", 0, scripts\cp\utility::getgametype(), 17 ) );
        }
        
        return level.gametypexpmodifier;
    }
    
    return level.gametypebundle.xpscalar;
}

// Namespace rank / scripts\cp\rank
// Params 2
// Checksum 0x0, Offset: 0x2ea1
// Size: 0x1d
function addglobalrankxpmultiplier( multiplier, ref )
{
    level addrankxpmultiplier( multiplier, ref );
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2ec6
// Size: 0x2a
function getglobalrankxpmultiplier()
{
    xpmodifier = level getrankxpmultiplier();
    
    if ( xpmodifier > 4 || xpmodifier < 0 )
    {
        exitlevel( 0 );
    }
    
    return xpmodifier;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2ef9
// Size: 0x7, Type: bool
function getplatformrankxpmultiplier()
{
    return true;
}

// Namespace rank / scripts\cp\rank
// Params 2
// Checksum 0x0, Offset: 0x2f09
// Size: 0x66
function addrankxpmultiplier( multiplier, ref )
{
    if ( !isdefined( self.rankxpmultipliers ) )
    {
        self.rankxpmultipliers = [];
    }
    
    if ( isdefined( self.rankxpmultipliers[ ref ] ) )
    {
        self.rankxpmultipliers[ ref ] = max( self.rankxpmultipliers[ ref ], multiplier );
        return;
    }
    
    self.rankxpmultipliers[ ref ] = multiplier;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x2f77
// Size: 0x7c
function getrankxpmultiplier()
{
    if ( !isdefined( self.rankxpmultipliers ) )
    {
        return 1;
    }
    
    modifiertotal = 1;
    
    foreach ( modifier in self.rankxpmultipliers )
    {
        if ( !isdefined( modifier ) )
        {
            continue;
        }
        
        modifiertotal *= modifier;
    }
    
    return modifiertotal;
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x2ffc
// Size: 0x14
function removeglobalrankxpmultiplier( ref )
{
    level removerankxpmultiplier( ref );
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x3018
// Size: 0x60
function removerankxpmultiplier( ref )
{
    if ( !isdefined( self.rankxpmultipliers ) )
    {
        assertmsg( "removeRankXPMultiplier() called for \"" + ref + "\", but no xp modifiers have been added." );
        return;
    }
    
    if ( !isdefined( self.rankxpmultipliers[ ref ] ) )
    {
        assertmsg( "removeRankXPMultiplier() called for \"" + ref + "\", but that xp modifier has not been added." );
        return;
    }
    
    self.rankxpmultipliers[ ref ] = undefined;
}

// Namespace rank / scripts\cp\rank
// Params 3
// Checksum 0x0, Offset: 0x3080
// Size: 0xa5
function addteamrankxpmultiplier( multiplier, team, ref )
{
    if ( !level.teambased )
    {
        team = "all";
    }
    
    if ( !isdefined( self.teamrankxpmultipliers ) )
    {
        level.teamrankxpmultipliers = [];
    }
    
    if ( !isdefined( level.teamrankxpmultipliers[ team ] ) )
    {
        level.teamrankxpmultipliers[ team ] = [];
    }
    
    if ( isdefined( level.teamrankxpmultipliers[ team ][ ref ] ) )
    {
        level.teamrankxpmultipliers[ team ][ ref ] = max( self.teamrankxpmultipliers[ team ][ ref ], multiplier );
        return;
    }
    
    level.teamrankxpmultipliers[ team ][ ref ] = multiplier;
}

// Namespace rank / scripts\cp\rank
// Params 2
// Checksum 0x0, Offset: 0x312d
// Size: 0xa5
function removeteamrankxpmultiplier( team, ref )
{
    if ( !level.teambased )
    {
        team = "all";
    }
    
    if ( !isdefined( level.teamrankxpmultipliers ) )
    {
        assertmsg( "removeTeamRankXPMultiplier() called for \"" + ref + "\", but no team xp modifiers have been added." );
        return;
    }
    
    if ( !isdefined( level.teamrankxpmultipliers[ team ] ) )
    {
        assertmsg( "removeTeamRankXPMultiplier() called for \"" + ref + "\", but no team xp modifiers for that team have been added." );
        return;
    }
    
    if ( !isdefined( level.teamrankxpmultipliers[ team ][ ref ] ) )
    {
        assertmsg( "removeTeamRankXPMultiplier() called for \"" + ref + "\", but that team does not have any modifiers of that type." );
        return;
    }
    
    level.teamrankxpmultipliers[ team ][ ref ] = undefined;
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x31da
// Size: 0xab
function getteamrankxpmultiplier( team )
{
    if ( !level.teambased )
    {
        team = "all";
    }
    
    if ( !isdefined( level.teamrankxpmultipliers ) || !isdefined( level.teamrankxpmultipliers[ team ] ) )
    {
        return 1;
    }
    
    modifiertotal = 1;
    
    foreach ( modifier in level.teamrankxpmultipliers[ team ] )
    {
        if ( !isdefined( modifier ) )
        {
            continue;
        }
        
        modifiertotal *= modifier;
    }
    
    return modifiertotal;
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x328e
// Size: 0x56
function getrankxpmultipliertotal()
{
    playermodifier = getrankxpmultiplier();
    globalmodifier = getglobalrankxpmultiplier();
    teammodifier = getteamrankxpmultiplier( self.team );
    platformmodifier = getplatformrankxpmultiplier();
    return playermodifier * globalmodifier * teammodifier * platformmodifier;
}

/#

    // Namespace rank / scripts\cp\rank
    // Params 2
    // Checksum 0x0, Offset: 0x32ed
    // Size: 0x100, Type: dev
    function function_f440a654d455343e( type, amount )
    {
        if ( getdvarint( @"hash_a59ff2bb10f08cc9", 0 ) == 1 )
        {
            if ( !isdefined( self.xpamountdebug ) )
            {
                self.xpamountdebug = [];
            }
            
            if ( !isdefined( self.xpamountdebug[ type ] ) )
            {
                self.xpamountdebug[ type ] = 0;
            }
            
            self.xpamountdebug[ type ] += amount;
            println( "<dev string:x11e>" + self.name + "<dev string:x11e>" );
            
            foreach ( value in self.xpamountdebug )
            {
                println( "<dev string:x12e>" + getxhashsourcename( key ) + "<dev string:x132>" + value );
            }
            
            println( "<dev string:x134>" );
        }
    }

#/

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x33f5
// Size: 0x2d
function rankedmatchupdates( winner )
{
    setxenonranks( winner );
    
    if ( hostidledout() )
    {
    }
    
    if ( !function_ccf98e6391dd38b9() )
    {
        updatematchbonusscores( winner );
    }
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x342a
// Size: 0x44
function gethostplayer()
{
    players = getentarray( "player", "classname" );
    
    for ( index = 0; index < players.size ; index++ )
    {
        if ( players[ index ] ishost() )
        {
            return players[ index ];
        }
    }
}

// Namespace rank / scripts\cp\rank
// Params 0
// Checksum 0x0, Offset: 0x3476
// Size: 0x3b, Type: bool
function hostidledout()
{
    hostplayer = gethostplayer();
    
    if ( isdefined( hostplayer ) && !hostplayer.hasspawned && !isdefined( hostplayer.selectedclass ) )
    {
        return true;
    }
    
    return false;
}

// Namespace rank / scripts\cp\rank
// Params 1
// Checksum 0x0, Offset: 0x34ba
// Size: 0x14d
function setxenonranks( winner )
{
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( !isdefined( player.score ) || !isdefined( player.pers[ "team" ] ) )
        {
        }
    }
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( !isdefined( player.kills ) || !isdefined( player.deaths ) )
        {
            println( "<dev string:x155>" );
            continue;
        }
        
        if ( 120 > player.timeplayed[ "total" ] )
        {
            continue;
        }
        
        kd = ( player.kills - player.deaths ) / player.timeplayed[ "total" ] / 60;
        println( "<dev string:x17c>" + player.kills + "<dev string:x184>" + player.deaths + "<dev string:x188>" + kd );
        setplayerteamrank( player, player.clientid, kd );
    }
}

