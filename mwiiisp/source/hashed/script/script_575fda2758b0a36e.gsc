#using script_575fda2758b0a36e;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace level_progression;

// Namespace level_progression / namespace_d6cca25f4b0ab62
// Params 0
// Checksum 0x0, Offset: 0x1c5
// Size: 0x2d
function createmission()
{
    mission = spawnstruct();
    mission.levels = [];
    mission.prereqs = [];
    return mission;
}

// Namespace level_progression / namespace_d6cca25f4b0ab62
// Params 11
// Checksum 0x0, Offset: 0x1fb
// Size: 0x23f
function addlevel( levelname, keepweapons, achievement, completion, postloadbink, settletime, clientsettletime, restartlevel, preload_transients, streamsync, loadbink )
{
    if ( scripts\engine\utility::default_to( loadbink, "" ) == "" )
    {
        loadbink = undefined;
    }
    
    count = level.missionsettings.levels.size;
    level.missionsettings.levels[ count ] = spawnstruct();
    level.missionsettings.levels[ count ].name = levelname;
    level.missionsettings.levels[ count ].keepweapons = keepweapons;
    level.missionsettings.levels[ count ].achievement = achievement;
    level.missionsettings.levels[ count ].completion = completion;
    level.missionsettings.levels[ count ].postloadbink = postloadbink;
    level.missionsettings.levels[ count ].settletime = settletime;
    level.missionsettings.levels[ count ].clientsettletime = clientsettletime;
    level.missionsettings.levels[ count ].restartlevel = restartlevel;
    level.missionsettings.levels[ count ].preload_transients = preload_transients;
    level.missionsettings.levels[ count ].streamsync = streamsync;
    level.missionsettings.levels[ count ].fade_time = 0;
    level.missionsettings.levels[ count ].bink = loadbink;
}

// Namespace level_progression / namespace_d6cca25f4b0ab62
// Params 1
// Checksum 0x0, Offset: 0x442
// Size: 0x229
function startsavedprogression( levelname )
{
    while ( !isdefined( level.player ) )
    {
        waitframe();
    }
    
    if ( scripts\common\utility::iscp() && getsubstr( levelname, 0, 3 ) == "cp_" )
    {
        levelname = callsharedfunc( "game", "convertsbmissionnametoddl", levelname );
    }
    
    if ( isprogressionlevel( levelname ) )
    {
        if ( scripts\common\utility::iscp() && getsubstr( levelname, 0, 3 ) == "cp_" )
        {
            scripts\engine\utility::callsharedfunc( "checkpoint", "timestamp" );
            
            if ( !getdvarint( @"hash_f004b2ccc04fdc8d", 0 ) )
            {
                scripts\engine\utility::callsharedfunc( "checkpoint", "reset" );
            }
            
            checkpoint_map = level.player scripts\engine\utility::callsharedfunc( "checkpoint", "get_checkpoint_map" );
            
            if ( isdefined( checkpoint_map ) && isstring( checkpoint_map ) && checkpoint_map != levelname )
            {
                scripts\engine\utility::callsharedfunc( "checkpoint", "reset" );
            }
        }
        
        if ( isprogressionmismatch( levelname ) )
        {
            function_dba9f60ce6c9c5a();
            return;
        }
        
        if ( getdvarint( @"hash_b8b8e25bb75b206d" ) == 0 )
        {
            if ( scripts\common\utility::iscp() )
            {
                level.player callsharedfunc( "game", "setProgressionData", "spData", "currentMission", levelname );
            }
            else
            {
                level.player callsharedfunc( "game", "setPlayerProgression", "currentMission", levelname );
            }
            
            if ( scripts\common\utility::iscp() )
            {
                state = level.player callsharedfunc( "game", "getProgressionData", "spData", "missionStateData", levelname );
            }
            else
            {
                state = level.player callsharedfunc( "game", "getPlayerProgression", "missionStateData", levelname );
            }
            
            if ( state == "locked" )
            {
                if ( scripts\common\utility::iscp() )
                {
                    level.player callsharedfunc( "game", "setProgressionData", "spData", "missionStateData", levelname, "incomplete" );
                    return;
                }
                
                level.player callsharedfunc( "game", "setPlayerProgression", "missionStateData", levelname, "incomplete" );
            }
        }
    }
}

// Namespace level_progression / namespace_d6cca25f4b0ab62
// Params 1
// Checksum 0x0, Offset: 0x673
// Size: 0x18
function function_dba9f60ce6c9c5a( levelname )
{
    setomnvar( "progression_invalid", 1 );
}

// Namespace level_progression / namespace_d6cca25f4b0ab62
// Params 1
// Checksum 0x0, Offset: 0x693
// Size: 0x1f, Type: bool
function isprogressionlevel( levelname )
{
    levelindex = getlevelindex( levelname );
    return isdefined( levelindex );
}

// Namespace level_progression / namespace_d6cca25f4b0ab62
// Params 1
// Checksum 0x0, Offset: 0x6bb
// Size: 0x4c, Type: bool
function isprogressionmismatch( levelname )
{
    levelindex = getlevelindex( levelname );
    
    if ( previouslevelcompleted( levelindex ) || isdevbuild() || getdvarint( @"fpstool_run" ) )
    {
        return false;
    }
    else
    {
        return true;
    }
    
    return false;
}

// Namespace level_progression / namespace_d6cca25f4b0ab62
// Params 1
// Checksum 0x0, Offset: 0x710
// Size: 0xaf
function previouslevelcompleted( levelindex )
{
    if ( levelindex == 0 )
    {
        return 1;
    }
    
    levelindex--;
    var_dafc1e855ded43aa = level.missionsettings.levels[ levelindex ].name;
    
    if ( scripts\common\utility::iscp() )
    {
        var_15cfc62c61f4117f = level.player callsharedfunc( "game", "getProgressionData", "spData", "missionStateData", var_dafc1e855ded43aa );
    }
    else
    {
        var_15cfc62c61f4117f = level.player callsharedfunc( "game", "getPlayerProgression", "missionStateData", var_dafc1e855ded43aa );
    }
    
    if ( var_15cfc62c61f4117f != "complete" )
    {
        return 0;
    }
    
    return 1;
}

// Namespace level_progression / namespace_d6cca25f4b0ab62
// Params 0
// Checksum 0x0, Offset: 0x7c7
// Size: 0x37
function isdevbuild()
{
    devbuild = 0;
    setdvarifuninitialized( @"hash_b3fcf6e357e30812", 0 );
    
    /#
        if ( !getdvarint( @"hash_b3fcf6e357e30812" ) )
        {
            devbuild = 1;
        }
    #/
    
    return devbuild;
}

// Namespace level_progression / namespace_d6cca25f4b0ab62
// Params 1
// Checksum 0x0, Offset: 0x807
// Size: 0xc8
function getlevelindex( levelname )
{
    if ( scripts\common\utility::iscp() && getsubstr( levelname, 0, 3 ) == "cp_" )
    {
        levelname = callsharedfunc( "game", "convertsbmissionnametoddl", levelname );
    }
    
    if ( !isdefined( level.missionsettings ) || !isdefined( level.missionsettings.levels ) )
    {
        return undefined;
    }
    
    foreach ( so_level in level.missionsettings.levels )
    {
        if ( so_level.name == levelname )
        {
            return levelindex;
        }
    }
    
    return undefined;
}

// Namespace level_progression / namespace_d6cca25f4b0ab62
// Params 1
// Checksum 0x0, Offset: 0x8d8
// Size: 0x52
function getlevelbink( levelindex )
{
    bink = undefined;
    
    if ( levelindex < level.missionsettings.levels.size )
    {
        bink = level.missionsettings.levels[ levelindex ].bink;
    }
    
    return bink;
}

// Namespace level_progression / namespace_d6cca25f4b0ab62
// Params 1
// Checksum 0x0, Offset: 0x933
// Size: 0x213
function levelprogressioncomplete( levelindex )
{
    var_6e0eeacbd0c484e7 = level.missionsettings.levels[ levelindex ].name;
    
    if ( scripts\common\utility::iscp() )
    {
        level.player callsharedfunc( "game", "setProgressionData", "spData", "missionStateData", var_6e0eeacbd0c484e7, "complete" );
        level.player callsharedfunc( "game", "setProgressionData", "spData", "currentGameskill", level.player.gameskill + 1 );
    }
    else
    {
        level.player callsharedfunc( "game", "setPlayerProgression", "missionStateData", var_6e0eeacbd0c484e7, "complete" );
        level.player callsharedfunc( "game", "setPlayerProgression", "currentGameskill", level.player.gameskill + 1 );
    }
    
    level.player setprogressiondata( "JupMissionDifficulties", "JupMissionDifficulty", levelindex, level.lowestgameskill + 1 );
    var_80f827abc3d76099 = [];
    
    for ( i = 0; i < level.missionsettings.levels.size ; i++ )
    {
        var_80f827abc3d76099[ i ] = level.player getprogressiondata( "JupMissionDifficulties", "JupMissionDifficulty", i );
    }
    
    var_45c1c6bb65ecb9b = 1;
    
    if ( var_80f827abc3d76099.size > 0 )
    {
        for ( i = 0; i < var_80f827abc3d76099.size ; i++ )
        {
            if ( var_80f827abc3d76099[ i ] != 4 )
            {
                var_45c1c6bb65ecb9b = 0;
                break;
            }
        }
    }
    
    if ( istrue( var_45c1c6bb65ecb9b ) )
    {
        level.player function_6a369480dbaf1090( "jup_sp_141ready" );
    }
    
    levelindex++;
    
    if ( level.missionsettings.levels.size > levelindex )
    {
        var_b02ce1c02cd503c9 = level.missionsettings.levels[ levelindex ].name;
        namespace_d6cca25f4b0ab62::startsavedprogression( var_b02ce1c02cd503c9 );
    }
}

