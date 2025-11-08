#using script_4cdabcd91a92977;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\teams;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;

#namespace leagueplay;

// Namespace leagueplay / scripts\mp\leagueplay
// Params 0
// Checksum 0x0, Offset: 0x330
// Size: 0x19e
function init()
{
    if ( !level.leagueplaymatch )
    {
        return;
    }
    
    namespace_bf9ffd2b22c7d819::function_8ce5b106fbba9e9f( &ondisconnect );
    namespace_bf9ffd2b22c7d819::function_8fe6d6539ed31a88( &function_adcdfd1b1a3efa51 );
    level.var_dbf03354f99ebab2 = &function_ecb13c8e7b38facd;
    level.var_c8001f5313a05589 = getdvarint( @"hash_b5256fb3f4ed76af", 0 );
    level.var_7272c293f31c587c = getdvarint( @"hash_a94c6ed8a414196", 0 );
    level.var_8c675b8e9e21ec44 = getdvarint( @"hash_95bde55f2b298c10", 15 );
    level.leagueid = leagueplaygetcurrentleagueid();
    level.var_75b72a33aeab21d4 = leagueplaygetcurrenteventtype();
    level.var_cbbf84a8e78caeee = getmatchmakinggametype();
    level.var_bbcb5f6b1b0a78ae = 0;
    
    if ( !isdefined( level.var_75b72a33aeab21d4 ) )
    {
        level.var_75b72a33aeab21d4 = 0;
    }
    
    level.var_6cd6ea2a7a7ddffb = "none";
    requiredplayers = 4;
    
    if ( isusingmatchrulesdata() )
    {
        requiredplayers = getmatchrulesdata( "commonOption", "squadSize" );
    }
    
    level.requiredplayercountoveride = 1;
    level.requiredplayercount[ "allies" ] = requiredplayers;
    level.requiredplayercount[ "axis" ] = requiredplayers;
    level.var_dc3c7c5627a11e5e = getdvarint( @"hash_f0ad3b38c4166ee", 150 );
    level.var_7d731c7dcbefbf3d = 1;
    level thread onconnect();
    level thread ongameplaying();
    var_5f4a4aacb73b91d7 = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsPlacement", 1 ) );
    level.var_f67ee22da6041b9b = leagueplaygetcurrentleagueseason();
    leagueplayinitializematch( var_5f4a4aacb73b91d7 );
    function_5ea9c8005581107f();
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 0
// Checksum 0x0, Offset: 0x4d6
// Size: 0xa8
function onconnect()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "connected", player );
        
        if ( istrue( level.leagueplaymatchcancelled ) )
        {
            return;
        }
        
        if ( !isplayer( player ) || isbot( player ) )
        {
            return;
        }
        
        xuid = player getxuid();
        
        if ( !function_4707c41ed8bae2d2( player ) || !leagueplayhasplayermatchdata( xuid ) )
        {
            player function_6c42f05b6c82b35e();
        }
        
        var_da4da6075aa47d27 = ter_op( istrue( player.pers[ "LPAllowLeave" ] ), 2, 3 );
        player setclientomnvar( "ui_leagueplay_allow_quit", var_da4da6075aa47d27 );
    }
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 1
// Checksum 0x0, Offset: 0x586
// Size: 0x29a
function function_adcdfd1b1a3efa51( player )
{
    if ( istrue( level.leagueplaymatchcancelled ) )
    {
        return;
    }
    
    if ( !isplayer( player ) || isbot( player ) )
    {
        return;
    }
    
    player.pers[ "leaguePlayDisconnected" ] = 0;
    xuid = player getxuid();
    
    if ( function_4707c41ed8bae2d2( player ) && leagueplayhasplayermatchdata( xuid ) )
    {
        leagueplayclearplayerladderpenalties( xuid );
        function_c080f7ef04fc3970( xuid, "" );
        var_bca6691d9622c899 = function_78fcc96be9d69371();
        gamemode = scripts\cp_mp\challenges::getchallengegamemode( self );
        aeeventname = #"connection_update";
        aeeventid = function_6e2deb013c9ca85e( aeeventname );
        
        if ( var_bca6691d9622c899 > -1 )
        {
            params = [ function_d6f771aedba70ce7( aeeventname, #"hash_d708505d31d66ef6" ), 0, function_d6f771aedba70ce7( aeeventname, #"hash_c9361150947eb728" ), getonlinematchid(), function_d6f771aedba70ce7( aeeventname, #"hash_e03f5709c8cd8a03" ), getlobbyid(), function_d6f771aedba70ce7( aeeventname, #"hash_23d400c5be24f34b" ), var_bca6691d9622c899, function_d6f771aedba70ce7( aeeventname, #"hash_5fba2f25f07000f5" ), level.var_cbbf84a8e78caeee, function_d6f771aedba70ce7( aeeventname, #"gamemode" ), gamemode, function_d6f771aedba70ce7( aeeventname, #"hash_e8d0ec1cb1f306c4" ), namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25() ];
            
            if ( issharedfuncdefined( "challenges", "reportChallengeUserSerializedEventWrapper" ) )
            {
                player callsharedfunc( "challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params );
            }
            
            return;
        }
        
        params = [ function_d6f771aedba70ce7( aeeventname, #"hash_d708505d31d66ef6" ), 0, function_d6f771aedba70ce7( aeeventname, #"hash_c9361150947eb728" ), getonlinematchid(), function_d6f771aedba70ce7( aeeventname, #"hash_e03f5709c8cd8a03" ), getlobbyid(), function_d6f771aedba70ce7( aeeventname, #"hash_5fba2f25f07000f5" ), level.var_cbbf84a8e78caeee, function_d6f771aedba70ce7( aeeventname, #"gamemode" ), gamemode, function_d6f771aedba70ce7( aeeventname, #"hash_e8d0ec1cb1f306c4" ), namespace_bf9ffd2b22c7d819::function_e3bd94413509bc25() ];
        
        if ( issharedfuncdefined( "challenges", "reportChallengeUserSerializedEventWrapper" ) )
        {
            player callsharedfunc( "challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params );
        }
    }
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 2
// Checksum 0x0, Offset: 0x828
// Size: 0x590
function ondisconnect( player, aeeventname )
{
    if ( istrue( level.leagueplaymatchcompleted ) || istrue( level.leagueplaymatchcancelled ) )
    {
        return;
    }
    
    if ( !isplayer( player ) || isbot( player ) )
    {
        return;
    }
    
    if ( !isdefined( player ) || !isdefined( player.team ) )
    {
        return;
    }
    
    if ( !isdefined( player.pers[ "leaguePlayInit" ] ) || player.pers[ "leaguePlayInit" ] == 0 )
    {
        return;
    }
    
    if ( !istrue( level.var_149c4cbc0fa7557d ) && function_630ec6e211cd26d1() )
    {
        level.var_149c4cbc0fa7557d = 1;
    }
    
    squadmembers = [];
    
    if ( istrue( level.matchmakingmatch ) )
    {
        squadmembers = player getfireteammembers();
    }
    
    foreach ( ent in level.players )
    {
        if ( is_equal( ent.team, player.team ) && isplayer( ent ) )
        {
            if ( array_contains( squadmembers, ent ) )
            {
                ent setclientomnvar( "ui_leagueplay_allow_quit", 0 );
            }
            else
            {
                ent setclientomnvar( "ui_leagueplay_allow_quit", 2 );
            }
            
            ent.pers[ "LPAllowLeave" ] = 1;
        }
    }
    
    var_dda705f2e8ff8269 = 0;
    ladderpenalty = 0;
    ladderpointsloss = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsLoss", 1 ) );
    disconnectreason = 0;
    playercounts = scripts\mp\teams::countplayers();
    xuid = player getxuid();
    
    if ( isdefined( playercounts ) && isdefined( playercounts[ player.team ] ) && playercounts[ player.team ] == 3 )
    {
        ladderpenalty = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPenaltyFirstLeave", 1 ) );
        disconnectreason = 1;
    }
    else
    {
        ladderpenalty = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPenaltyAdditionalLeave", 1 ) );
        disconnectreason = 2;
    }
    
    if ( isdefined( player.hitffkicklimit ) && istrue( player.hitffkicklimit ) )
    {
        disconnectreason = 3;
    }
    else if ( isdefined( player.var_72c19b43b99e7097 ) && istrue( player.var_72c19b43b99e7097 ) )
    {
        disconnectreason = 4;
    }
    else if ( scripts\mp\gamelogic::inprematch() )
    {
        disconnectreason = 9;
    }
    
    function_c080f7ef04fc3970( xuid, disconnectreason );
    leagueplayapplyladderdelta( xuid, ladderpenalty, 1 );
    
    if ( isdefined( player.team ) )
    {
        function_b3b3e822f262ebda( xuid, 0, player.team );
    }
    
    function_626b6e017a257e10( xuid );
    player.pers[ "leaguePlayDisconnected" ] = 1;
    var_bca6691d9622c899 = function_78fcc96be9d69371();
    gamemode = scripts\cp_mp\challenges::getchallengegamemode( self );
    
    if ( var_bca6691d9622c899 > -1 )
    {
        return [ function_d6f771aedba70ce7( aeeventname, #"hash_d708505d31d66ef6" ), 1, function_d6f771aedba70ce7( aeeventname, #"hash_c9361150947eb728" ), getonlinematchid(), function_d6f771aedba70ce7( aeeventname, #"hash_e03f5709c8cd8a03" ), getlobbyid(), function_d6f771aedba70ce7( aeeventname, #"disconnect_reason" ), disconnectreason, function_d6f771aedba70ce7( aeeventname, #"hash_cd5d35cc3d1850e5" ), -1 * ( ladderpointsloss + ladderpenalty ), function_d6f771aedba70ce7( aeeventname, #"hash_e643e8a9919c09d8" ), var_dda705f2e8ff8269, function_d6f771aedba70ce7( aeeventname, #"hash_23d400c5be24f34b" ), var_bca6691d9622c899, function_d6f771aedba70ce7( aeeventname, #"hash_ab984d923d5f2c96" ), function_fb67b62bbd718b34(), function_d6f771aedba70ce7( aeeventname, #"hash_5fba2f25f07000f5" ), level.var_cbbf84a8e78caeee, function_d6f771aedba70ce7( aeeventname, #"gamemode" ), gamemode, function_d6f771aedba70ce7( aeeventname, #"hash_e8d0ec1cb1f306c4" ), function_e3bd94413509bc25() ];
    }
    
    return [ function_d6f771aedba70ce7( aeeventname, #"hash_d708505d31d66ef6" ), 1, function_d6f771aedba70ce7( aeeventname, #"hash_c9361150947eb728" ), getonlinematchid(), function_d6f771aedba70ce7( aeeventname, #"hash_e03f5709c8cd8a03" ), getlobbyid(), function_d6f771aedba70ce7( aeeventname, #"disconnect_reason" ), disconnectreason, function_d6f771aedba70ce7( aeeventname, #"hash_cd5d35cc3d1850e5" ), -1 * ( ladderpointsloss + ladderpenalty ), function_d6f771aedba70ce7( aeeventname, #"hash_e643e8a9919c09d8" ), var_dda705f2e8ff8269, function_d6f771aedba70ce7( aeeventname, #"hash_ab984d923d5f2c96" ), function_fb67b62bbd718b34(), function_d6f771aedba70ce7( aeeventname, #"hash_5fba2f25f07000f5" ), level.var_cbbf84a8e78caeee, function_d6f771aedba70ce7( aeeventname, #"gamemode" ), gamemode, function_d6f771aedba70ce7( aeeventname, #"hash_e8d0ec1cb1f306c4" ), function_e3bd94413509bc25() ];
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 0
// Checksum 0x0, Offset: 0xdc0
// Size: 0xb8
function ongameplaying()
{
    level endon( "game_ended" );
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        scripts\mp\flags::gameflagwait( "prematch_done" );
    }
    
    leagueplaybeginmatch();
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.team ) )
        {
            function_11e88c88f89143fe( player getxuid(), player.team );
        }
    }
    
    if ( !isroundbased() || isfirstround() )
    {
        level thread match_cancelling();
    }
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 0
// Checksum 0x0, Offset: 0xe80
// Size: 0x82
function match_cancelling()
{
    if ( !isdefined( level.var_7272c293f31c587c ) || level.var_7272c293f31c587c <= 0 )
    {
        return;
    }
    
    level endon( "game_ended" );
    
    while ( function_630ec6e211cd26d1() )
    {
        if ( istrue( level.var_149c4cbc0fa7557d ) )
        {
            level.var_60f7d8bd0181980f = 1;
            setomnvarforallclients( "ui_leagueplay_allow_quit", 1 );
            thread scripts\mp\gamelogic::function_46eb417b582d5179( level.var_8c675b8e9e21ec44 * 1000 );
            wait level.var_8c675b8e9e21ec44;
            cancel_match();
            return;
        }
        
        wait 1;
    }
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 0
// Checksum 0x0, Offset: 0xf0a
// Size: 0x21, Type: bool
function function_ecb13c8e7b38facd()
{
    if ( istrue( level.var_60f7d8bd0181980f ) && !istrue( level.leagueplaymatchcancelled ) )
    {
        return true;
    }
    
    return false;
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 0
// Checksum 0x0, Offset: 0xf34
// Size: 0x50, Type: bool
function function_630ec6e211cd26d1()
{
    secondspassed = int( floor( scripts\mp\utility\game::getgamelength() / 1000 ) );
    return ( !isroundbased() || isfirstround() ) && isdefined( level.var_7272c293f31c587c ) && secondspassed < level.var_7272c293f31c587c;
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 0
// Checksum 0x0, Offset: 0xf8d
// Size: 0x21
function function_5ea9c8005581107f()
{
    setnojipscore( 1, 1 );
    setnojiptime( 1, 1 );
    level.nojip = 1;
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 1
// Checksum 0x0, Offset: 0xfb6
// Size: 0x36, Type: bool
function function_4707c41ed8bae2d2( player )
{
    if ( isdefined( player.pers[ "leaguePlayInit" ] ) )
    {
        return ( player.pers[ "leaguePlayInit" ] == 1 );
    }
    
    return false;
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 0
// Checksum 0x0, Offset: 0xff5
// Size: 0x1c4
function function_6c42f05b6c82b35e()
{
    player = self;
    
    if ( !isplayer( player ) || isbot( player ) )
    {
        return;
    }
    
    if ( isdefined( player.pers[ "leaguePlayInit" ] ) && player.pers[ "leaguePlayInit" ] == 1 )
    {
        return;
    }
    
    xuid = player getxuid();
    var_7fb9bcaaa8ebb115 = 0;
    var_59d49ab6b66aaf7c = 0;
    player.pers[ "leaguePlayOnLadder" ] = 0;
    player.pers[ "leaguePlayDisconnected" ] = 0;
    
    if ( function_78fcc96be9d69371() > -1 )
    {
        var_59d49ab6b66aaf7c = player getplayerdata( level.progressiongroup, "leaguePlayData", level.var_bbcb5f6b1b0a78ae, "season", level.var_f67ee22da6041b9b, "pmatches" ) == getdvarint( @"hash_fd4d1a68a9daff4d", 5 ) - 1;
        var_8b918a9e28b6db8e = player getplayerdata( level.progressiongroup, "leaguePlayData", level.var_bbcb5f6b1b0a78ae, "season", level.var_f67ee22da6041b9b, "pmatches" ) >= getdvarint( @"hash_fd4d1a68a9daff4d", 5 );
        player.pers[ "leaguePlayOnLadder" ] = player getplayerdata( level.progressiongroup, "leaguePlayData", level.var_bbcb5f6b1b0a78ae, "league_id" ) == level.leagueid;
        
        if ( var_8b918a9e28b6db8e && !player.pers[ "leaguePlayOnLadder" ] )
        {
            var_7fb9bcaaa8ebb115 = 1;
        }
    }
    
    leagueplayonplayerconnect( xuid, var_7fb9bcaaa8ebb115, player.pers[ "leaguePlayOnLadder" ], var_59d49ab6b66aaf7c );
    player.pers[ "leaguePlayInit" ] = 1;
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 1
// Checksum 0x0, Offset: 0x11c1
// Size: 0x15
function forfeit_match( forfeitteamname )
{
    level.var_6cd6ea2a7a7ddffb = forfeitteamname;
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 0
// Checksum 0x0, Offset: 0x11de
// Size: 0xf3
function cancel_match()
{
    level.leagueplaymatchcancelled = 1;
    level.var_7ebde40af908fcf8 = 0;
    
    if ( getdvarint( @"online_mp_clientmatchdata_enabled" ) != 0 )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player.clientmatchdataid ) )
            {
                scripts\mp\gamelogic::assignclientmatchdataid( player );
            }
            
            setclientmatchdata( "players", player.clientmatchdataid, "leaguePlayMatchCancelled", level.leagueplaymatchcancelled );
        }
    }
    
    scripts\mp\gamescore::updateplacement();
    scripts\mp\gamelogic::processlobbydata();
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        match_end( undefined );
        wait 1;
        level notify( "exitLevel_called" );
        exitlevel( 0 );
        return;
    }
    
    level thread scripts\mp\gamelogic::forceend();
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 0
// Checksum 0x0, Offset: 0x12d9
// Size: 0x2a
function function_78fcc96be9d69371()
{
    if ( isdefined( level.var_f67ee22da6041b9b ) && level.var_f67ee22da6041b9b >= 0 )
    {
        return level.var_f67ee22da6041b9b;
    }
    
    return -1;
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 1
// Checksum 0x0, Offset: 0x130c
// Size: 0x79
function function_883f3d0fdef74fbf( winner )
{
    player = self;
    
    if ( !isdefined( winner ) )
    {
        return 2;
    }
    
    if ( level.teambased )
    {
        if ( isgameplayteam( winner ) )
        {
            if ( isdefined( player.team ) )
            {
                if ( player.team == winner )
                {
                    return 3;
                }
                else
                {
                    return 1;
                }
            }
        }
        else if ( isstring( winner ) && winner == "tie" )
        {
            return 2;
        }
    }
    
    return undefined;
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 1
// Checksum 0x0, Offset: 0x138e
// Size: 0x7e
function function_5231a8b9bc35b470( ladderpointsbonuspoolstep )
{
    player = self;
    bonuspool = player getplayerdata( level.progressiongroup, "leaguePlayData", level.var_bbcb5f6b1b0a78ae, "bonuspool" );
    var_282f09c3ac1a1052 = bonuspool - ladderpointsbonuspoolstep;
    
    if ( var_282f09c3ac1a1052 >= 0 )
    {
        player getplayerdata( level.progressiongroup, "leaguePlayData", level.var_bbcb5f6b1b0a78ae, "bonuspool", var_282f09c3ac1a1052 );
        return ladderpointsbonuspoolstep;
    }
    
    return 0;
}

// Namespace leagueplay / scripts\mp\leagueplay
// Params 1
// Checksum 0x0, Offset: 0x1415
// Size: 0x7b6
function match_end( winner )
{
    level.gameended = 1;
    level.leagueplaymatchcompleted = 1;
    matchcancelled = istrue( level.leagueplaymatchcancelled );
    ladderpointswin = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsWin", 1 ) );
    ladderpointsloss = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsLoss", 1 ) );
    ladderpointsbonuspoolstep = int( tablelookup( "mp/leagueplay_config.csv", 0, "ladderPointsBonusPoolStep", 1 ) );
    var_bca6691d9622c899 = function_78fcc96be9d69371();
    gamemode = scripts\cp_mp\challenges::getchallengegamemode( self );
    lobbyid = getlobbyid();
    matchid = getonlinematchid();
    var_abbf42875a7797ad = getdvarint( @"hash_74b99125b3898193", 86400 );
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) || isbot( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.pers[ "leaguePlayInit" ] ) || player.pers[ "leaguePlayInit" ] == 0 )
        {
            continue;
        }
        
        if ( !isdefined( player.pers[ "leaguePlayDisconnected" ] ) || player.pers[ "leaguePlayDisconnected" ] == 1 )
        {
            continue;
        }
        
        xuid = player getxuid();
        matchresult = player function_883f3d0fdef74fbf( winner );
        skillrating = function_904672268eb8e3fe( xuid );
        var_49bb51e761c847ff = 0;
        var_31ec327c47f15b5c = leagueplayisplayeraddedtoladder( xuid );
        onladder = isdefined( player.pers[ "leaguePlayOnLadder" ] ) && player.pers[ "leaguePlayOnLadder" ];
        function_c080f7ef04fc3970( xuid, 0 );
        
        if ( level.var_75b72a33aeab21d4 != 1 || onladder || var_31ec327c47f15b5c )
        {
            var_49bb51e761c847ff = function_d85a1e614464b733( skillrating );
        }
        
        if ( matchcancelled )
        {
            matchresult = 0;
        }
        else if ( isdefined( matchresult ) && ( onladder || var_31ec327c47f15b5c ) )
        {
            if ( matchresult == 3 )
            {
                var_453735e83c192121 = 0;
                
                if ( onladder )
                {
                    var_453735e83c192121 = player function_5231a8b9bc35b470( ladderpointsbonuspoolstep );
                }
                
                leagueplayapplyladderdelta( xuid, ladderpointswin + var_453735e83c192121 );
            }
            else if ( matchresult == 1 )
            {
                leagueplayapplyladderdelta( xuid, ladderpointsloss );
            }
        }
        
        if ( isdefined( level.leagueid ) && isdefined( matchresult ) && var_bca6691d9622c899 > -1 )
        {
            aeeventname = #"hash_46314392af70142b";
            aeeventid = function_6e2deb013c9ca85e( aeeventname );
            
            if ( skillrating > 0 )
            {
                params = [ function_d6f771aedba70ce7( aeeventname, #"hash_5c84471bbbd6a98e" ), level.leagueid, function_d6f771aedba70ce7( aeeventname, #"hash_d555f3589ac28cc" ), matchresult, function_d6f771aedba70ce7( aeeventname, #"leagueplay_skill_rating" ), skillrating, function_d6f771aedba70ce7( aeeventname, #"hash_182a7ae142f3b128" ), var_49bb51e761c847ff, function_d6f771aedba70ce7( aeeventname, #"hash_490204184a5f13e" ), var_31ec327c47f15b5c, function_d6f771aedba70ce7( aeeventname, #"hash_9262d5cef5a7650f" ), onladder, function_d6f771aedba70ce7( aeeventname, #"hash_23d400c5be24f34b" ), var_bca6691d9622c899, function_d6f771aedba70ce7( aeeventname, #"hash_c9361150947eb728" ), matchid, function_d6f771aedba70ce7( aeeventname, #"hash_e03f5709c8cd8a03" ), lobbyid, function_d6f771aedba70ce7( aeeventname, #"hash_f1733e44a51e82be" ), level.var_75b72a33aeab21d4, function_d6f771aedba70ce7( aeeventname, #"hash_cb5895c719e93d31" ), var_abbf42875a7797ad, function_d6f771aedba70ce7( aeeventname, #"hash_d885ae7541734272" ), 1, function_d6f771aedba70ce7( aeeventname, #"hash_5fba2f25f07000f5" ), level.var_cbbf84a8e78caeee, function_d6f771aedba70ce7( aeeventname, #"gamemode" ), gamemode, function_d6f771aedba70ce7( aeeventname, #"hash_e8d0ec1cb1f306c4" ), function_e3bd94413509bc25() ];
                
                if ( issharedfuncdefined( "challenges", "reportChallengeUserSerializedEventWrapper" ) )
                {
                    player callsharedfunc( "challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params );
                }
            }
            else
            {
                params = [ function_d6f771aedba70ce7( aeeventname, #"hash_5c84471bbbd6a98e" ), level.leagueid, function_d6f771aedba70ce7( aeeventname, #"hash_d555f3589ac28cc" ), matchresult, function_d6f771aedba70ce7( aeeventname, #"hash_182a7ae142f3b128" ), var_49bb51e761c847ff, function_d6f771aedba70ce7( aeeventname, #"hash_490204184a5f13e" ), var_31ec327c47f15b5c, function_d6f771aedba70ce7( aeeventname, #"hash_9262d5cef5a7650f" ), onladder, function_d6f771aedba70ce7( aeeventname, #"hash_23d400c5be24f34b" ), var_bca6691d9622c899, function_d6f771aedba70ce7( aeeventname, #"hash_c9361150947eb728" ), matchid, function_d6f771aedba70ce7( aeeventname, #"hash_e03f5709c8cd8a03" ), lobbyid, function_d6f771aedba70ce7( aeeventname, #"hash_f1733e44a51e82be" ), level.var_75b72a33aeab21d4, function_d6f771aedba70ce7( aeeventname, #"hash_cb5895c719e93d31" ), var_abbf42875a7797ad, function_d6f771aedba70ce7( aeeventname, #"hash_d885ae7541734272" ), 1, function_d6f771aedba70ce7( aeeventname, #"hash_5fba2f25f07000f5" ), level.var_cbbf84a8e78caeee, function_d6f771aedba70ce7( aeeventname, #"gamemode" ), gamemode, function_d6f771aedba70ce7( aeeventname, #"hash_e8d0ec1cb1f306c4" ), function_e3bd94413509bc25() ];
                
                if ( issharedfuncdefined( "challenges", "reportChallengeUserSerializedEventWrapper" ) )
                {
                    player callsharedfunc( "challenges", "reportChallengeUserSerializedEventWrapper", aeeventid, params );
                }
            }
        }
        
        if ( isdefined( player.team ) )
        {
            playerscore = 0;
            
            if ( !matchcancelled && isdefined( player.pers[ "score" ] ) )
            {
                playerscore = player.pers[ "score" ];
            }
            
            function_b3b3e822f262ebda( xuid, playerscore, player.team );
        }
    }
    
    for ( i = 0; i < level.teamnamelist.size ; i++ )
    {
        teamscore = 0;
        
        if ( !matchcancelled )
        {
            teamscore = scripts\mp\gamescore::_getteamscore( level.teamnamelist[ i ] );
        }
        
        function_846c101d2c3fe49a( level.teamnamelist[ i ], teamscore );
    }
    
    winningteam = winner;
    
    if ( !isdefined( winner ) || matchcancelled || isstring( winner ) && winner == "tie" )
    {
        winningteam = "none";
    }
    
    leagueplayendmatch( matchcancelled, level.var_6cd6ea2a7a7ddffb, winningteam );
}

