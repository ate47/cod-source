#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\cp\cp_hud_util;
#using scripts\cp\cp_weaponrank;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\cp\utility\entity;
#using scripts\cp\utility\player;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;

#namespace cp_matchdata;

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 0
// Checksum 0x0, Offset: 0x2bf
// Size: 0x191
function init()
{
    if ( getdvarint( @"online_matchdata_enabled" ) != 0 && !isdefined( game[ "gamestarted" ] ) )
    {
        setmatchdata( "commonMatchData", "map", level.script );
        
        if ( scripts\cp_mp\utility\game_utility::function_21322da268e71c19() )
        {
            tmp = scripts\cp\utility::getgametype() + " hc";
            setmatchdata( "commonMatchData", "gametype", tmp );
        }
        else
        {
            setmatchdata( "commonMatchData", "gametype", scripts\cp\utility::getgametype() );
        }
        
        setmatchdata( "commonMatchData", "build_version", getbuildversion() );
        setmatchdata( "commonMatchData", "build_number", getbuildnumber() );
        setmatchdata( "commonMatchData", "is_private_match", scripts\cp\utility::privatematch() );
    }
    
    if ( getdvarint( @"online_matchdata_enabled" ) != 0 )
    {
        level.maxlogclients = 30;
    }
    else if ( level.gametype != "dungeons" )
    {
        level.maxlogclients = 0;
    }
    
    level.maxlives = 475;
    level.maxnamelength = 26;
    level.maxgameevents = 250;
    level.maxkillstreaks = 64;
    level.maxkillstreaksavailable = 64;
    level.maxnumchallengesperplayer = 10;
    level.maxnumawardsperplayer = 10;
    level.maxsupersavailable = 50;
    level.maxsupersactivated = 50;
    level.maxsupersexpired = 50;
    level.matchdata_logaward = &logaward;
    level.matchdataattachmentstatsenabled = 0;
    level thread endofgamesummarylogger();
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 0
// Checksum 0x0, Offset: 0x458
// Size: 0x31
function onmatchstart()
{
    setmatchdata( "commonMatchData", "utc_start_time_s", getsystemtime() );
    setmatchdata( "commonMatchData", "player_count_start", level.players.size );
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 0
// Checksum 0x0, Offset: 0x491
// Size: 0x78
function onroundend()
{
    level.endtimeutcseconds = getsystemtime();
    setmatchdata( "commonMatchData", "utc_end_time_s", level.endtimeutcseconds );
    setmatchdata( "commonMatchData", "player_count_end", level.players.size );
    
    if ( !function_ccf98e6391dd38b9() )
    {
        setmatchdata( "globalPlayerXpModifier", int( scripts\cp\rank::getglobalrankxpmultiplier() ) );
        setmatchdata( "globalWeaponXpModifier", int( scripts\cp\cp_weaponrank::getglobalweaponrankxpmultiplier() ) );
    }
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 1
// Checksum 0x0, Offset: 0x511
// Size: 0x1d
function logplayerdata( disconnectreason )
{
    if ( !scripts\common\telemetry_utils::is_valid_client( self ) )
    {
        return;
    }
    
    self sendclientnetworktelemetry();
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 0
// Checksum 0x0, Offset: 0x536
// Size: 0x34f
function endofgamesummarylogger()
{
    level waittill( "game_ended" );
    
    if ( level.gametype == "dungeons" )
    {
        current_map = tolower( getdvar( @"g_mapname" ) );
        level.players[ 0 ] setplayerdata( "common", "round", "gameMode", scripts\cp\utility::getgametype() );
        level.players[ 0 ] setplayerdata( "common", "round", "map", current_map );
        return;
    }
    
    foreach ( player in level.players )
    {
        wait 0.05;
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player scripts\cp_mp\utility\game_utility::stopkeyearning();
        
        if ( isdefined( player.challengescompleted ) )
        {
            player setplayerdata( "common", "round", "challengeNumCompleted", player.challengescompleted.size );
        }
        else
        {
            player setplayerdata( "common", "round", "challengeNumCompleted", 0 );
        }
        
        for ( i = 0; i < 20 ; i++ )
        {
            if ( isdefined( player.challengescompleted ) && isdefined( player.challengescompleted[ i ] ) && player.challengescompleted[ i ] != "ch_prestige" && !issubstr( player.challengescompleted[ i ], "_daily" ) && !issubstr( player.challengescompleted[ i ], "_weekly" ) )
            {
                player setplayerdata( "common", "round", "challengesCompleted", i, player.challengescompleted[ i ] );
                continue;
            }
            
            player setplayerdata( "common", "round", "challengesCompleted", i, "ch_none" );
        }
        
        current_map = tolower( getdvar( @"g_mapname" ) );
        player setplayerdata( "common", "round", "gameMode", scripts\cp\utility::getgametype() );
        player setplayerdata( "common", "round", "map", current_map );
        
        if ( istrue( level.matchmakingmatch ) )
        {
            start_pos = 0;
            add = 0;
            
            for ( i = 0; i < 5 ; i++ )
            {
                map = player getplayerdata( "mp", "mapsPlayed", i );
                
                if ( map == "" )
                {
                    start_pos = i;
                    add = 1;
                    break;
                }
                
                if ( map == current_map )
                {
                    start_pos = i;
                    add = 0;
                    break;
                }
            }
            
            if ( add == 1 )
            {
                player setplayerdata( "mp", "mapsPlayed", start_pos, current_map );
                continue;
            }
            
            index = start_pos;
            
            for ( i = start_pos; i < 4 ; i++ )
            {
                index = i + 1;
                map = player getplayerdata( "mp", "mapsPlayed", i + 1 );
                player setplayerdata( "mp", "mapsPlayed", i, map );
                
                if ( map == "" )
                {
                    index = i;
                    break;
                }
            }
            
            player setplayerdata( "mp", "mapsPlayed", index, current_map );
        }
    }
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 4
// Checksum 0x0, Offset: 0x88d
// Size: 0x3e
function logattachmentstat( attachname, statname, incvalue, weapon )
{
    if ( !level.matchdataattachmentstatsenabled )
    {
        return;
    }
    
    println( "<dev string:x1c>" );
}

/#

    // Namespace cp_matchdata / scripts\cp\cp_matchdata
    // Params 2
    // Checksum 0x0, Offset: 0x8d3
    // Size: 0x21, Type: dev
    function logkillstreakevent( event, position )
    {
        println( "<dev string:x44>" );
    }

    // Namespace cp_matchdata / scripts\cp\cp_matchdata
    // Params 2
    // Checksum 0x0, Offset: 0x8fc
    // Size: 0x21, Type: dev
    function logattackerkillevent( lifeid, eventref )
    {
        println( "<dev string:x91>" );
    }

    // Namespace cp_matchdata / scripts\cp\cp_matchdata
    // Params 2
    // Checksum 0x0, Offset: 0x925
    // Size: 0x21, Type: dev
    function logvictimkillevent( lifeid, eventref )
    {
        println( "<dev string:xfc>" );
    }

    // Namespace cp_matchdata / scripts\cp\cp_matchdata
    // Params 2
    // Checksum 0x0, Offset: 0x94e
    // Size: 0x21, Type: dev
    function logmultikill( lifeid, multikillcount )
    {
        println( "<dev string:x165>" );
    }

    // Namespace cp_matchdata / scripts\cp\cp_matchdata
    // Params 2
    // Checksum 0x0, Offset: 0x977
    // Size: 0x21, Type: dev
    function logchallenge( challengename, tier )
    {
        println( "<dev string:x188>" );
    }

#/

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 1
// Checksum 0x0, Offset: 0x9a0
// Size: 0x30
function function_ff48d255c865806( client )
{
    if ( scripts\common\telemetry_utils::is_valid_client( client ) )
    {
        return ( client.clientid < level.maxlogclients );
    }
    
    return 0;
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 1
// Checksum 0x0, Offset: 0x9d8
// Size: 0x27
function initpersstat( dataname )
{
    if ( !isdefined( self.pers[ dataname ] ) )
    {
        self.pers[ dataname ] = 0;
    }
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 1
// Checksum 0x0, Offset: 0xa07
// Size: 0x16
function getpersstat( dataname )
{
    return self.pers[ dataname ];
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 2
// Checksum 0x0, Offset: 0xa26
// Size: 0x5b
function incpersstat( dataname, increment )
{
    if ( istrue( game[ "practiceRound" ] ) )
    {
        return;
    }
    
    if ( isdefined( self ) && isdefined( self.pers ) && isdefined( self.pers[ dataname ] ) )
    {
        self.pers[ dataname ] += increment;
    }
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 1
// Checksum 0x0, Offset: 0xa89
// Size: 0x32
function setextrascore0( newvalue )
{
    if ( istrue( game[ "practiceRound" ] ) )
    {
        return;
    }
    
    self.extrascore0 = newvalue;
    self.pers[ "extrascore0" ] = newvalue;
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 1
// Checksum 0x0, Offset: 0xac3
// Size: 0x32
function setextrascore1( newvalue )
{
    if ( istrue( game[ "practiceRound" ] ) )
    {
        return;
    }
    
    self.extrascore1 = newvalue;
    self.pers[ "extrascore1" ] = newvalue;
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 1
// Checksum 0x0, Offset: 0xafd
// Size: 0x32
function setextrascore2( newvalue )
{
    if ( istrue( game[ "practiceRound" ] ) )
    {
        return;
    }
    
    self.extrascore2 = newvalue;
    self.pers[ "extrascore2" ] = newvalue;
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 1
// Checksum 0x0, Offset: 0xb37
// Size: 0x32
function setextrascore3( newvalue )
{
    if ( istrue( game[ "practiceRound" ] ) )
    {
        return;
    }
    
    self.extrascore3 = newvalue;
    self.pers[ "extrascore3" ] = newvalue;
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 0
// Checksum 0x0, Offset: 0xb71
// Size: 0x7
function getplayerdataloadoutgroup()
{
    return "cploadouts";
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 0
// Checksum 0x0, Offset: 0xb81
// Size: 0x11
function setplayerdatagroups()
{
    level.loadoutsgroup = getplayerdataloadoutgroup();
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 0
// Checksum 0x0, Offset: 0xb9a
// Size: 0x29, Type: bool
function canrecordcombatrecordstats()
{
    return level.rankedmatch && !istrue( level.ignorescoring ) && scripts\cp\utility::getgametype() != "infect";
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 1
// Checksum 0x0, Offset: 0xbcc
// Size: 0x3e
function getstreakrecordtype( streakname )
{
    if ( isenumvaluevalid( "mp", "LethalScorestreakStatItems", streakname ) )
    {
        return "lethalScorestreakStats";
    }
    
    if ( isenumvaluevalid( "mp", "SupportScorestreakStatItems", streakname ) )
    {
        return "supportScorestreakStats";
    }
    
    return undefined;
}

// Namespace cp_matchdata / scripts\cp\cp_matchdata
// Params 1
// Checksum 0x0, Offset: 0xc13
// Size: 0xb
function logaward( awardname )
{
    
}

