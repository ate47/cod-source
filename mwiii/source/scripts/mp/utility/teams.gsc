#using scripts\common\utility;
#using scripts\cp_mp\factions;
#using scripts\engine\utility;
#using scripts\mp\playerlogic;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;

#namespace teams;

// Namespace teams / scripts\mp\utility\teams
// Params 2
// Checksum 0x0, Offset: 0x567
// Size: 0x68
function getteamdata( team, property )
{
    assertex( isdefined( level.teamdata[ team ] ), "<dev string:x1c>" + team + "<dev string:x39>" );
    assertex( function_ef7cf07ba921200e( team, property ), "<dev string:x1c>" + team + "<dev string:x3e>" + property + "<dev string:x39>" );
    return level.teamdata[ team ][ property ];
}

// Namespace teams / scripts\mp\utility\teams
// Params 3
// Checksum 0x0, Offset: 0x5d8
// Size: 0x82
function setteamdata( team, property, value )
{
    assertex( isdefined( level.teamdata[ team ] ), "<dev string:x1c>" + team + "<dev string:x39>" );
    assertex( function_ef7cf07ba921200e( team, property ), "<dev string:x1c>" + team + "<dev string:x3e>" + property + "<dev string:x39>" );
    assertex( isdefined( value ), "<dev string:x44>" );
    level.teamdata[ team ][ property ] = value;
}

// Namespace teams / scripts\mp\utility\teams
// Params 3
// Checksum 0x0, Offset: 0x662
// Size: 0x90
function modifyteamdata( team, property, value )
{
    assertex( isdefined( level.teamdata[ team ] ), "<dev string:x1c>" + team + "<dev string:x39>" );
    assertex( function_ef7cf07ba921200e( team, property ), "<dev string:x1c>" + team + "<dev string:x3e>" + property + "<dev string:x39>" );
    assertex( isdefined( value ), "<dev string:x44>" );
    level.teamdata[ team ][ property ] += value;
}

// Namespace teams / scripts\mp\utility\teams
// Params 2
// Checksum 0x0, Offset: 0x6fa
// Size: 0x43, Type: bool
function function_ef7cf07ba921200e( team, property )
{
    assertex( isdefined( level.teamdata[ team ] ), "<dev string:x1c>" + team + "<dev string:x39>" );
    return isdefined( level.teamdata[ team ][ property ] );
}

// Namespace teams / scripts\mp\utility\teams
// Params 3
// Checksum 0x0, Offset: 0x746
// Size: 0xc9
function addplayertoteam( player, team, var_cf5d3f8f0d10e600 )
{
    assertex( !array_contains( level.teamdata[ team ][ "<dev string:x69>" ], player ), "<dev string:x74>" );
    level.teamdata[ team ][ "teamCount" ]++;
    level.teamdata[ team ][ "players" ] = array_add( level.teamdata[ team ][ "players" ], player );
    
    /#
        if ( level.teamdata[ team ][ "<dev string:x69>" ].size != level.teamdata[ team ][ "<dev string:xb1>" ] )
        {
            assertmsg( "<dev string:xbe>" );
        }
    #/
    
    if ( var_cf5d3f8f0d10e600 )
    {
        addtoteamlives( player, team, undefined, "addPlayerToTeam" );
    }
}

// Namespace teams / scripts\mp\utility\teams
// Params 2
// Checksum 0x0, Offset: 0x817
// Size: 0xad
function removeplayerfromteam( player, team )
{
    assertex( array_contains( level.teamdata[ team ][ "<dev string:x69>" ], player ), "<dev string:xf1>" );
    level.teamdata[ team ][ "teamCount" ]--;
    level.teamdata[ team ][ "players" ] = array_remove( level.teamdata[ team ][ "players" ], player );
    
    /#
        if ( level.teamdata[ team ][ "<dev string:x69>" ].size != level.teamdata[ team ][ "<dev string:xb1>" ] )
        {
            assertmsg( "<dev string:xbe>" );
        }
    #/
}

// Namespace teams / scripts\mp\utility\teams
// Params 4
// Checksum 0x0, Offset: 0x8cc
// Size: 0x181
function addtoteamlives( player, team, var_28335de6505d7e0c, context )
{
    level.teamdata[ team ][ "aliveCount" ]++;
    level.teamdata[ team ][ "alivePlayers" ] = array_add( level.teamdata[ team ][ "alivePlayers" ], player );
    
    if ( level.multiteambased )
    {
        level.teamdata[ team ][ "deathEvent" ] = 0;
    }
    
    validatealivecount( "add", team, player, context );
    
    if ( isdefined( level.modeaddtoteamlives ) )
    {
        [[ level.modeaddtoteamlives ]]( player, team, context );
    }
    
    if ( lpcfeaturegated() )
    {
        return;
    }
    
    if ( istrue( var_28335de6505d7e0c ) && isgameplayteam( team ) )
    {
        foreach ( player in level.teamdata[ team ][ "players" ] )
        {
            player playlocalsound( "mp_bodycount_tick_positive" );
        }
        
        enemies = getenemyplayers( team );
        
        foreach ( player in enemies )
        {
            player playlocalsound( "mp_bodycount_tick_negative" );
        }
    }
}

// Namespace teams / scripts\mp\utility\teams
// Params 4
// Checksum 0x0, Offset: 0xa55
// Size: 0x19f
function removefromteamlives( player, team, var_28335de6505d7e0c, context )
{
    level.teamdata[ team ][ "aliveCount" ]--;
    level.teamdata[ team ][ "alivePlayers" ] = array_remove( level.teamdata[ team ][ "alivePlayers" ], player );
    validatealivecount( "remove", team, player, context );
    
    if ( isdefined( level.moderemovefromteamlives ) )
    {
        [[ level.moderemovefromteamlives ]]( player, team, context );
    }
    
    if ( istrue( var_28335de6505d7e0c ) && isgameplayteam( team ) )
    {
        var_8e64916b837afa27 = "mp_bodycount_tick_negative";
        var_8940a36ac40ebf77 = "mp_bodycount_tick_positive";
        
        if ( level.teamdata[ team ][ "aliveCount" ] == 1 )
        {
            var_8e64916b837afa27 = "mp_bodycount_tick_negative_final";
            var_8940a36ac40ebf77 = "mp_bodycount_tick_positive_final";
        }
        
        foreach ( player in level.teamdata[ team ][ "players" ] )
        {
            player playlocalsound( var_8e64916b837afa27 );
        }
        
        if ( !lpcfeaturegated() )
        {
            enemies = getenemyplayers( team );
            
            foreach ( player in enemies )
            {
                player playlocalsound( var_8940a36ac40ebf77 );
            }
        }
    }
}

// Namespace teams / scripts\mp\utility\teams
// Params 4
// Checksum 0x0, Offset: 0xbfc
// Size: 0x2ff
function validatealivecount( eventtype, team, player, context )
{
    runfixup = getdvarint( @"hash_2bfdcc415ed38338", 1 );
    context = default_to( context, "?" );
    var_a6b269d3a73b87f9 = 0;
    var_1124b7ac7d344fed = 0;
    
    if ( isdefined( eventtype ) )
    {
        if ( eventtype == "disconnect" || eventtype == "extract" )
        {
            var_a6b269d3a73b87f9 = array_contains( level.teamdata[ team ][ "alivePlayers" ], player );
            
            if ( var_a6b269d3a73b87f9 && runfixup )
            {
                player scripts\mp\playerlogic::removefromalivecount( 1, "validateAliveCount" );
            }
        }
        else if ( eventtype == "add" )
        {
            var_fd5e7a241044b880 = array_remove_duplicates( level.teamdata[ team ][ "alivePlayers" ] );
            
            if ( var_fd5e7a241044b880.size < level.teamdata[ team ][ "alivePlayers" ].size )
            {
                var_1124b7ac7d344fed = 1;
                eventtype += " duplicate";
            }
        }
    }
    
    aliveplayers = level.teamdata[ team ][ "alivePlayers" ].size;
    alivecount = level.teamdata[ team ][ "aliveCount" ];
    
    if ( aliveplayers != alivecount || var_a6b269d3a73b87f9 || var_1124b7ac7d344fed )
    {
        message = "";
        
        if ( var_1124b7ac7d344fed )
        {
            message = "WARNING: Duplicate players in alive player array! context=" + context;
            scripts\mp\utility\script::demoforcesre( message );
        }
        else if ( var_a6b269d3a73b87f9 )
        {
            message = "WARNING: player in alive array after disconnect! context=" + context;
            scripts\mp\utility\script::demoforcesre( message );
        }
        else
        {
            message = "WARNING: alivePlayers and aliveCount are out of sync! context=" + context;
            message += "; alive_players: " + aliveplayers;
            message += "; alive_count: " + alivecount;
            message += "; event: " + eventtype;
            message += "; team: " + team;
            message += "; player_xuid: " + player getxuid();
            message += "; player_name: " + player.name;
            var_7b9b62dbc37d7f48 = getdvarint( @"hash_2b1c389284b21136", 0 );
            
            if ( var_7b9b62dbc37d7f48 )
            {
                scripts\mp\utility\script::function_7bd154ad046984e2( message );
            }
        }
        
        assertmsg( message );
        dlog_recordevent( "dlog_event_alive_count_mismatch", [ "alive_players", aliveplayers, "alive_count", alivecount, "event", eventtype, "team", team, "player_xuid", player getxuid(), "player_name", player.name ] );
        
        if ( runfixup )
        {
            level.teamdata[ team ][ "alivePlayers" ] = array_remove_duplicates( level.teamdata[ team ][ "alivePlayers" ] );
            level.teamdata[ team ][ "aliveCount" ] = level.teamdata[ team ][ "alivePlayers" ].size;
            [[ level.updategameevents ]]();
        }
    }
}

// Namespace teams / scripts\mp\utility\teams
// Params 2
// Checksum 0x0, Offset: 0xf03
// Size: 0x41
function getteamcount( team, aliveonly )
{
    if ( istrue( aliveonly ) )
    {
        return level.teamdata[ team ][ "alivePlayers" ].size;
    }
    
    return level.teamdata[ team ][ "players" ].size;
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0xf4c
// Size: 0x42
function getenemyteams( testteam )
{
    assertex( isgameplayteam( testteam ), "<dev string:x12f>" + testteam );
    teams = level.teamnamelist;
    teams = array_remove( teams, testteam );
    return teams;
}

// Namespace teams / scripts\mp\utility\teams
// Params 2
// Checksum 0x0, Offset: 0xf97
// Size: 0xf3
function getfriendlyplayers( testteam, aliveonly )
{
    friends = [];
    
    if ( istrue( aliveonly ) )
    {
        foreach ( player in level.teamdata[ testteam ][ "alivePlayers" ] )
        {
            if ( isdefined( player ) && isalive( player ) && !isdefined( player.fauxdead ) )
            {
                friends[ friends.size ] = player;
            }
        }
    }
    else
    {
        foreach ( player in level.teamdata[ testteam ][ "players" ] )
        {
            friends[ friends.size ] = player;
        }
    }
    
    return friends;
}

// Namespace teams / scripts\mp\utility\teams
// Params 2
// Checksum 0x0, Offset: 0x1093
// Size: 0x1f2
function getenemyplayers( testteam, aliveonly )
{
    enemies = [];
    
    if ( istrue( level.teambased ) )
    {
        enemyteams = getenemyteams( testteam );
        
        foreach ( team in enemyteams )
        {
            if ( istrue( aliveonly ) )
            {
                foreach ( player in level.teamdata[ team ][ "alivePlayers" ] )
                {
                    if ( isdefined( player ) && isalive( player ) && !isdefined( player.fauxdead ) )
                    {
                        enemies[ enemies.size ] = player;
                    }
                }
                
                continue;
            }
            
            foreach ( player in level.teamdata[ team ][ "players" ] )
            {
                enemies[ enemies.size ] = player;
            }
        }
    }
    else if ( istrue( aliveonly ) )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && isdefined( self ) && isalive( player ) && player != self && !isdefined( player.fauxdead ) )
            {
                enemies[ enemies.size ] = player;
            }
        }
    }
    else
    {
        enemies = array_remove( level.players, self );
    }
    
    return enemies;
}

// Namespace teams / scripts\mp\utility\teams
// Params 3
// Checksum 0x0, Offset: 0x128e
// Size: 0xc9
function getsquadmates( testteam, testsquadindex, aliveonly )
{
    if ( function_d0e67bb0e7f430f8( testteam, testsquadindex ) )
    {
        if ( istrue( aliveonly ) )
        {
            squadmates = [];
            
            foreach ( player in level.squaddata[ testteam ][ testsquadindex ].players )
            {
                if ( scripts\mp\utility\player::isreallyalive( player ) )
                {
                    squadmates[ squadmates.size ] = player;
                }
            }
            
            return squadmates;
        }
        else
        {
            return level.squaddata[ testteam ][ testsquadindex ].players;
        }
    }
    
    return getfriendlyplayers( testteam, aliveonly );
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0x1360
// Size: 0x27
function function_5b7802e04b6d946( player )
{
    return function_d0e67bb0e7f430f8( player.team, player.sessionsquadid );
}

// Namespace teams / scripts\mp\utility\teams
// Params 2
// Checksum 0x0, Offset: 0x1390
// Size: 0x4b, Type: bool
function function_d0e67bb0e7f430f8( team, squadindex )
{
    return isdefined( team ) && isdefined( squadindex ) && isdefined( level.squaddata ) && isdefined( level.squaddata[ team ] ) && isdefined( level.squaddata[ team ][ squadindex ] );
}

// Namespace teams / scripts\mp\utility\teams
// Params 2
// Checksum 0x0, Offset: 0x13e4
// Size: 0x82
function getenemycount( testteam, aliveonly )
{
    count = 0;
    enemyteams = getenemyteams( testteam );
    
    foreach ( team in enemyteams )
    {
        count += getteamcount( team, istrue( aliveonly ) );
    }
    
    return count;
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0x146f
// Size: 0xa7, Type: bool
function function_44a6f98cc3c0f5f4( team )
{
    var_7d247415a9640d07 = getsubgametype() == "dmz" || getsubgametype() == "exgm" || getsubgametype() == "limbo";
    var_65c32dd267d39ddb = team == "team_hundred_ninety_five" || team == "team_hundred_ninety_three" || team == "team_hundred_ninety_four" || team == "team_hundred_ninety_five" || team == "team_hundred_ninety_six" || team == "team_hundred_ninety_seven" || team == "team_hundred_ninety_eight" || team == "team_hundred_ninety_nine";
    return var_7d247415a9640d07 && var_65c32dd267d39ddb;
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0x151f
// Size: 0x20, Type: bool
function isgameplayteam( team )
{
    return isdefined( team ) && arraycontains( level.teamnamelist, team );
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0x1548
// Size: 0xe
function getfaction( team )
{
    return game[ team ];
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0x155f
// Size: 0x19b
function function_dd622cd64f483958( teamref )
{
    bundle = function_716b04a356073ae5( level.teamdata[ teamref ][ "teamFaction" ] );
    game[ teamref ] = bundle.ref;
    
    if ( !isdefined( level.teamdata[ teamref ][ "teamName" ] ) )
    {
        level.teamdata[ teamref ][ "teamName" ] = bundle.name;
    }
    
    if ( !isdefined( level.teamdata[ teamref ][ "shortName" ] ) )
    {
        level.teamdata[ teamref ][ "shortName" ] = bundle.shortname;
    }
    
    if ( !isdefined( level.teamdata[ teamref ][ "teamIcon" ] ) )
    {
        level.teamdata[ teamref ][ "teamIcon" ] = bundle.var_493bf0f1c7cf4ad1;
    }
    
    if ( !isdefined( level.teamdata[ teamref ][ "headIcon" ] ) )
    {
        level.teamdata[ teamref ][ "headIcon" ] = bundle.headicon;
    }
    
    if ( !isdefined( level.teamdata[ teamref ][ "soundInfix" ] ) )
    {
        level.teamdata[ teamref ][ "soundInfix" ] = bundle.var_d5fbbcddd0fdfe3b;
    }
    
    if ( !isdefined( level.teamdata[ teamref ][ "customizationInfix" ] ) )
    {
        level.teamdata[ teamref ][ "customizationInfix" ] = bundle.customizationinfix;
    }
    
    if ( !isdefined( level.teamdata[ teamref ][ "superFaction" ] ) )
    {
        level.teamdata[ teamref ][ "superFaction" ] = bundle.var_47eff39aeeb815fb;
    }
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0x1702
// Size: 0x67
function getteamname( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "teamName" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "teamName" ] = function_716b04a356073ae5( faction ).name;
    }
    
    return level.teamdata[ teamref ][ "teamName" ];
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0x1772
// Size: 0x67
function getteamshortname( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "shortName" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "shortName" ] = function_716b04a356073ae5( faction ).shortname;
    }
    
    return level.teamdata[ teamref ][ "shortName" ];
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0x17e2
// Size: 0x67
function getteamicon( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "teamIcon" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "teamIcon" ] = function_716b04a356073ae5( faction ).var_493bf0f1c7cf4ad1;
    }
    
    return level.teamdata[ teamref ][ "teamIcon" ];
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0x1852
// Size: 0x67
function getteamheadicon( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "headIcon" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "headIcon" ] = function_716b04a356073ae5( faction ).headicon;
    }
    
    return level.teamdata[ teamref ][ "headIcon" ];
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0x18c2
// Size: 0x67
function getteamvoiceinfix( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "soundInfix" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "soundInfix" ] = function_716b04a356073ae5( faction ).var_d5fbbcddd0fdfe3b;
    }
    
    return level.teamdata[ teamref ][ "soundInfix" ];
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0x1932
// Size: 0x67
function getcustomizationprefix( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "customizationInfix" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "customizationInfix" ] = function_716b04a356073ae5( faction ).customizationinfix;
    }
    
    return level.teamdata[ teamref ][ "customizationInfix" ];
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0x19a2
// Size: 0x67
function function_f5f92738a88b4577( teamref )
{
    if ( !isdefined( level.teamdata[ teamref ][ "superFaction" ] ) )
    {
        faction = getfaction( teamref );
        level.teamdata[ teamref ][ "superFaction" ] = function_716b04a356073ae5( faction ).var_47eff39aeeb815fb;
    }
    
    return level.teamdata[ teamref ][ "superFaction" ];
}

// Namespace teams / scripts\mp\utility\teams
// Params 1
// Checksum 0x0, Offset: 0x1a12
// Size: 0x1a7
function getteamfactionsfrommap( teamref )
{
    mapbundle = getmapscriptbundle();
    mapfaction = undefined;
    var_b051af13cb960b7a = %"hash_6a3e9234e0d7e26d";
    
    if ( !isdefined( level.teamdata[ teamref ][ "teamFaction" ] ) )
    {
        if ( isdefined( mapbundle ) )
        {
            switch ( teamref )
            {
                case #"hash_7c2d091e6337bf54":
                    mapfaction = mapbundle.team1faction;
                    break;
                case #"hash_5f54b9bf7583687f":
                    mapfaction = mapbundle.team2faction;
                    break;
                case #"hash_11f9d28d306ceab7":
                    mapfaction = mapbundle.team3faction;
                    break;
                case #"hash_de35e9ca17933bf1":
                    mapfaction = mapbundle.team4faction;
                    break;
                case #"hash_ec4dd0ca1ec42f41":
                    mapfaction = mapbundle.team5faction;
                    break;
                case #"hash_cb45d282427f65a7":
                    mapfaction = mapbundle.team6faction;
                    break;
                default:
                    mapfaction = mapbundle.team2faction;
                    break;
            }
            
            if ( !isdefined( mapfaction ) || mapfaction == "" )
            {
                println( "<dev string:x14e>" + teamref + "<dev string:x15e>" + level.mapname );
                mapfaction = var_b051af13cb960b7a;
            }
            
            level.teamdata[ teamref ][ "teamFaction" ] = mapfaction;
        }
        else
        {
            println( "<dev string:x186>" + level.mapname );
            level.teamdata[ teamref ][ "teamFaction" ] = var_b051af13cb960b7a;
        }
    }
    
    return level.teamdata[ teamref ][ "teamFaction" ];
}

// Namespace teams / scripts\mp\utility\teams
// Params 0
// Checksum 0x0, Offset: 0x1bc2
// Size: 0x2f
function getcustomgametypeteammax()
{
    gametype = getgametype();
    return getdvarint( hashcat( @"scr_", gametype, "_teamcount" ), -1 );
}

// Namespace teams / scripts\mp\utility\teams
// Params 0
// Checksum 0x0, Offset: 0x1bfa
// Size: 0x2e
function function_f6728366ba30005c()
{
    registersharedfunc( "team_utility", "getFriendlyPlayers", &getfriendlyplayers );
    registersharedfunc( "team_utility", "getEnemyPlayers", &getenemyplayers );
}

// Namespace teams / scripts\mp\utility\teams
// Params 0
// Checksum 0x0, Offset: 0x1c30
// Size: 0x73
function calculatenumteamswithplayers()
{
    numteamswithplayers = 0;
    
    foreach ( team in level.teamdata )
    {
        if ( team[ "players" ].size > 0 )
        {
            numteamswithplayers++;
        }
    }
    
    level.numteamswithplayers = numteamswithplayers;
}

