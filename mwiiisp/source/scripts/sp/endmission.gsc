#using script_575fda2758b0a36e;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\analytics;
#using scripts\sp\utility;

#namespace endmission;

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x280
// Size: 0x16d
function main()
{
    missionsettings = createmission();
    level.missionsettings = missionsettings;
    level.lowestgameskill = getdvarint( @"g_gameskill" );
    nil = undefined;
    mapinfolist = function_91d6763e1921a524();
    
    foreach ( mapinfo in mapinfolist )
    {
        preloadtransients = undefined;
        
        if ( isdefined( mapinfo.preloadtransients ) )
        {
            preloadtransients = strtok( mapinfo.preloadtransients, ", " );
        }
        
        settletime = default_to( mapinfo.settletime, 10 );
        clientsettletime = default_to( mapinfo.clientsettletime, 100 );
        loadbink = mapinfo.loadingmoviename;
        addlevel( mapinfo.mapname, 0, nil, 1, nil, settletime, clientsettletime, nil, preloadtransients, 0, loadbink );
    }
    
    if ( isdefined( level.endmission_main_func ) )
    {
        [[ level.endmission_main_func ]]();
        level.endmission_main_func = undefined;
    }
    
    /#
        thread function_b47ee5b0dae14294();
    #/
    
    thread debug_test_next_mission();
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x3f5
// Size: 0x61
function debug_test_next_mission()
{
    version = getbuildversion();
    
    if ( version == "SHIP" )
    {
        return;
    }
    
    setdvarifuninitialized( @"test_next_mission", 0 );
    wait 10;
    
    while ( getdvarint( @"test_next_mission" ) < 1 )
    {
        wait 3;
    }
    
    setdvar( @"test_next_mission", 0 );
    nextmission_internal();
}

// Namespace endmission / scripts\sp\endmission
// Params 2
// Checksum 0x0, Offset: 0x45e
// Size: 0x150
function nextmission_preload_internal( type, var_740cf07d74dba935 )
{
    if ( !isdefined( type ) )
    {
        type = "full";
    }
    
    if ( !isdefined( var_740cf07d74dba935 ) )
    {
        var_740cf07d74dba935 = 1;
    }
    
    levelindex = level.missionsettings getlevelindex( level.script );
    nextlevelindex = levelindex + 1;
    preload_transients = level.missionsettings.levels[ nextlevelindex ].preload_transients;
    
    if ( var_740cf07d74dba935 )
    {
        level thread nextmission_primeloadbink();
    }
    
    if ( getdvarint( @"fastload", 1 ) )
    {
        levelname = level.missionsettings getlevelname( nextlevelindex );
        
        switch ( type )
        {
            case #"hash_af9a1714fe58109c":
                if ( isdefined( preload_transients ) )
                {
                    array = array_combine( [ levelname ], preload_transients );
                    preloadzones( array );
                }
                else
                {
                    preloadzones( levelname );
                }
                
                break;
            case #"hash_4d3e1f9017db6ba5":
                preloadzones( levelname );
                break;
            case #"hash_ce8bfbd622fff22a":
                if ( isdefined( preload_transients ) )
                {
                    preloadzones( preload_transients );
                }
                
                break;
        }
        
        while ( !ispreloadzonescomplete() )
        {
            waitframe();
        }
    }
    
    flag_set( "nextmission_preload_complete" );
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x5b6
// Size: 0xf9
function nextmission_primeloadbink_internal()
{
    if ( !isdefined( getlevelindex( level.script ) ) || !isdefined( getlevelindex( level.script ) + 1 ) )
    {
        return;
    }
    
    if ( !flag_exist( "nextmission_transition_bink_primed" ) )
    {
        flag_init( "nextmission_transition_bink_primed" );
    }
    
    nextlevelindex = getlevelindex( level.script ) + 1;
    mission_bink = getlevelbink( nextlevelindex );
    setsaveddvar( @"bg_cinematicfullscreen", "0" );
    setsaveddvar( @"hash_b9ff37d084074df3", "1" );
    stopcinematicingame();
    waitframe();
    
    if ( !isdefined( mission_bink ) )
    {
        /#
            iprintlnbold( "<dev string:x1c>" );
        #/
        
        mission_bink = "default";
    }
    
    cinematicingame( mission_bink, 1, 1, 1, 0, 0, 1 );
    
    while ( !iscinematicplaying() )
    {
        waitframe();
    }
    
    println( "<dev string:x84>" + mission_bink );
    flag_set( "nextmission_transition_bink_primed" );
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x6b7
// Size: 0x6f
function getrestartlevel( levelname )
{
    if ( !isdefined( level.missionsettings ) )
    {
        return undefined;
    }
    
    index = getlevelindex( levelname );
    
    if ( isdefined( level.missionsettings.levels[ index ].restartlevel ) )
    {
        return level.missionsettings.levels[ index ].restartlevel;
    }
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x72e
// Size: 0x52
function level_settle_time_get( levelname )
{
    assert( isdefined( levelname ) );
    index = getlevelindex( levelname );
    
    if ( !isdefined( index ) )
    {
        return 0;
    }
    
    return level.missionsettings.levels[ index ].settletime;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x788
// Size: 0x52
function client_settle_time_get( levelname )
{
    assert( isdefined( levelname ) );
    index = getlevelindex( levelname );
    
    if ( !isdefined( index ) )
    {
        return 0;
    }
    
    return level.missionsettings.levels[ index ].clientsettletime;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x7e2
// Size: 0x94
function level_settle_time_wait( levelname )
{
    if ( !isdefined( levelname ) )
    {
        levelname = level.script;
    }
    
    settletime = level_settle_time_get( levelname );
    clientsettletime = client_settle_time_get( levelname );
    
    if ( !isdefined( settletime ) )
    {
        settletime = 0;
    }
    
    if ( !isdefined( clientsettletime ) )
    {
        clientsettletime = 0;
    }
    else
    {
        clientsettletime *= 0.02;
    }
    
    totalsettletime = settletime + clientsettletime;
    
    if ( isdefined( totalsettletime ) )
    {
        wait totalsettletime * 0.05;
    }
    
    if ( isdefined( clientsettletime ) && clientsettletime <= 0 )
    {
        waitframe();
        return;
    }
    
    if ( !isdefined( settletime ) || settletime <= 0 )
    {
        waitframe();
    }
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x87e
// Size: 0x52
function function_65085d2b5d1f245c()
{
    difficultystring = "";
    difficultyarray = level.player function_ff103db8e0d75209();
    
    for ( index = 0; index < difficultyarray.size ; index++ )
    {
        difficultystring += string( difficultyarray[ index ] );
    }
    
    return difficultystring;
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x8d9
// Size: 0x68f
function nextmission_internal()
{
    /#
        if ( getdvarint( @"nextmission_disable" ) )
        {
            iprintlnbold( "<dev string:x95>" );
            return;
        }
    #/
    
    if ( utility::is_demo() )
    {
        if ( isdefined( level.nextmission_exit_time ) )
        {
            changelevel( "", 0, level.nextmission_exit_time );
            return;
        }
        
        changelevel( "", 0 );
        return;
    }
    
    scripts\sp\analytics::analytics_upload_during_nextmission();
    level notify( "nextmission" );
    level.nextmission = 1;
    level.player enableinvulnerability();
    levelindex = undefined;
    setdvar( @"ui_showpopup", "0" );
    setdvar( @"hash_b5229012ccf8e014", "" );
    setdvar( @"hash_3e810e7dcf052f5d", level.script );
    game[ "previous_map" ] = undefined;
    levelindex = getlevelindex( level.script );
    
    if ( !isdefined( levelindex ) )
    {
        missionsuccess( level.script );
        return;
    }
    
    if ( !is_lastlevel() )
    {
        scripts\engine\sp\utility::level_end_save();
    }
    else
    {
        var_5963a57373cba5b4 = "none";
        level.player setplayerprogression( "currentMission", var_5963a57373cba5b4 );
    }
    
    setlevelcompleted( levelindex );
    collateraldamageassessment( level.script );
    println( "<dev string:xb5>" );
    completion_percentage = updatesppercent();
    
    /#
        if ( getdvarint( @"hash_bc76f1b9a1f7ba07" ) != 0 )
        {
            highestmission_ifnotcheating_set( getdvarint( @"hash_b50de240594f8df4" ) );
            level.missionsettings setlevelcompleted( max( 0, getdvarint( @"hash_b50de240594f8df4" ) - 1 ) );
            setdvar( @"hash_bc76f1b9a1f7ba07", "<dev string:xe3>" );
        }
        
        if ( completion_percentage < level.player getplayerprogression( "<dev string:xe4>" ) )
        {
            println( "<dev string:xf6>" + completion_percentage + "<dev string:x118>" + level.player getplayerprogression( "<dev string:xe4>" ) + "<dev string:x121>" );
        }
        
        println( "<dev string:x126>" + getdvarint( @"hash_bc76f1b9a1f7ba07" ) + "<dev string:x143>" + getdvarint( @"hash_1adbe88f794c0245" ) + "<dev string:x14e>" );
        println( "<dev string:x151>" + function_65085d2b5d1f245c() + "<dev string:x16d>" );
        println( "<dev string:x16f>" + completion_percentage / 100 + "<dev string:x18e>" );
        println( "<dev string:x191>" + levelindex + "<dev string:x16d>" );
        println( "<dev string:x1a8>" + level.script + "<dev string:x16d>" );
        println( "<dev string:x1bf>" + level.missionsettings.levels.size + "<dev string:x16d>" );
    #/
    
    updategamerprofile();
    
    if ( level.missionsettings hasachievement( levelindex ) )
    {
        scripts\sp\utility::giveachievement_wrapper( level.missionsettings getachievement( levelindex ) );
    }
    
    if ( level.missionsettings haslevelveteranaward( levelindex ) && getlevelcompleted( levelindex ) == 4 && level.missionsettings check_other_haslevelveteranachievement( levelindex ) )
    {
        scripts\sp\utility::giveachievement_wrapper( level.missionsettings getlevelveteranaward( levelindex ) );
    }
    
    if ( level.missionsettings hasmissionhardenedaward() && level.missionsettings getlowestskill() > 2 )
    {
        giveachievement_wrapper( level.missionsettings gethardenedaward() );
    }
    
    scripts\sp\analytics::start_point_update( "mission_end", 1 );
    
    if ( isplatformps5() )
    {
        if ( isdefined( level.ps5activity ) && level.script != "gunship_compound" )
        {
            stopactivity( level.ps5activity, "completed" );
        }
    }
    
    if ( is_lastlevel() )
    {
        changelevel( "", 0 );
        return;
    }
    
    nextlevelindex = levelindex + 1;
    assert( nextlevelindex < level.missionsettings.levels.size );
    mission_bink = getlevelbink( nextlevelindex );
    var_b02ce1c02cd503c9 = level.missionsettings getlevelname( nextlevelindex );
    var_7291ff60dd218210 = getmapinfobundle( var_b02ce1c02cd503c9 );
    
    /#
        println( "<dev string:x1d6>" + var_b02ce1c02cd503c9 + "<dev string:x16d>" );
        println( "<dev string:x1ed>" + var_7291ff60dd218210.var_60699f6be12aea0d + "<dev string:x16d>" );
    #/
    
    if ( isdefined( mission_bink ) && !istrue( level.endmission_bink_skip ) )
    {
        println( "<dev string:x20a>" + mission_bink + "<dev string:x16d>" );
        setdvar( @"hash_4967b5f5316f16af", mission_bink );
        
        if ( !flag_exist( "nextmission_transition_bink_primed" ) )
        {
            flag_init( "nextmission_transition_bink_primed" );
        }
        
        setomnvar( "ui_hide_hud", 1 );
        
        if ( !level.player islinked() )
        {
            tag = level.player spawn_tag_origin();
            level.player playerlinktoabsolute( tag );
        }
        
        level.player freezecontrols( 1 );
        
        if ( flag( "nextmission_transition_bink_primed" ) )
        {
            /#
                print( "<dev string:x223>" );
            #/
            
            setsaveddvar( @"bg_cinematicfullscreen", "1" );
            setsaveddvar( @"hash_b9ff37d084074df3", "1" );
            pausecinematicingame( 0 );
        }
        else
        {
            /#
                print( "<dev string:x246>" );
            #/
            
            setsaveddvar( @"bg_cinematicfullscreen", "1" );
            setsaveddvar( @"hash_b9ff37d084074df3", "1" );
            flags = 128 | 2048 | 8192;
            
            if ( var_7291ff60dd218210.var_60699f6be12aea0d )
            {
                flags |= 33554432;
            }
            
            cinematicingame( mission_bink, flags );
        }
    }
    
    scripts\sp\analytics::analytics_lui_mission_end_dlog();
    
    if ( level.missionsettings getlevelstreamsync( nextlevelindex ) )
    {
        setstreamsynconnextlevel();
    }
    
    if ( var_7291ff60dd218210.var_60699f6be12aea0d )
    {
        wait 1;
        function_bb63844d1b8da6ae( var_b02ce1c02cd503c9 );
        return;
    }
    
    if ( isdefined( level.missionsettings getfadetime( levelindex ) ) )
    {
        changelevel( var_b02ce1c02cd503c9, level.missionsettings getkeepweapons( levelindex ), level.missionsettings getfadetime( levelindex ) );
        return;
    }
    
    changelevel( var_b02ce1c02cd503c9, level.missionsettings getkeepweapons( levelindex ) );
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0xf70
// Size: 0x6d
function collateraldamageassessment( levelname )
{
    grade = getcollateraldamagegrade();
    level.player setplayerprogression( "civiliansKilledGrade", levelname, grade );
    best = level.player getplayerprogression( "civiliansKilledGradeBest", levelname );
    
    if ( grade > best )
    {
        level.player setplayerprogression( "civiliansKilledGradeBest", levelname, grade );
    }
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0xfe5
// Size: 0x3f
function getcollateraldamagegrade()
{
    var_d40d6d92361e9a2 = 4;
    grade = int( min( level.friendlyfire[ "civilians_killed" ], var_d40d6d92361e9a2 ) );
    grade = var_d40d6d92361e9a2 - grade;
    return int( grade );
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x102d
// Size: 0x66
function updatesppercent()
{
    completion_percentage = int( gettotalpercentcompletesp() * 100 );
    
    if ( getdvarint( @"hash_b8b8e25bb75b206d" ) == 0 )
    {
        assertex( completion_percentage >= 0 && completion_percentage <= 10000, "SP's Completion percentage [ " + completion_percentage + "% ] is outside of 0 to 100 range!" );
        level.player setplayerprogression( "percentCompleteSP", completion_percentage );
    }
    
    return completion_percentage;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x109c
// Size: 0x41
function addprereq( missionindex )
{
    var_82b6d1fbefcc5fae = level.missionsettings.prereqs.size;
    level.missionsettings.prereqs[ var_82b6d1fbefcc5fae ] = missionindex;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x10e5
// Size: 0x75
function getpostloadbink( levelname )
{
    assert( isdefined( levelname ) );
    index = getlevelindex( levelname );
    
    if ( isdefined( index ) )
    {
        if ( isdefined( level.missionsettings.levels[ index ].postloadbink ) )
        {
            return level.missionsettings.levels[ index ].postloadbink;
        }
    }
    
    return "none";
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x1163
// Size: 0x20
function getlevelname( levelindex )
{
    return self.levels[ levelindex ].name;
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x118c
// Size: 0x5a
function function_823f915153b5fcd8()
{
    if ( level.missionsettings.levels.size == 0 )
    {
        return level.script;
    }
    
    return level.missionsettings.levels[ level.missionsettings.levels.size - 1 ].name;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x11ef
// Size: 0x20
function getkeepweapons( levelindex )
{
    return self.levels[ levelindex ].keepweapons;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x1218
// Size: 0x20
function getachievement( levelindex )
{
    return self.levels[ levelindex ].achievement;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x1241
// Size: 0x20
function getlevelveteranaward( levelindex )
{
    return self.levels[ levelindex ].veteran_achievement;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x126a
// Size: 0x20
function getlevelstreamsync( levelindex )
{
    return self.levels[ levelindex ].streamsync;
}

// Namespace endmission / scripts\sp\endmission
// Params 2
// Checksum 0x0, Offset: 0x1293
// Size: 0x34
function setfadetime( index, time )
{
    level.missionsettings.levels[ index ].fade_time = time;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x12cf
// Size: 0x3b
function getfadetime( index )
{
    if ( !isdefined( self.levels[ index ].fade_time ) )
    {
        return undefined;
    }
    
    return self.levels[ index ].fade_time;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x1313
// Size: 0x2c
function haslevelveteranaward( levelindex )
{
    if ( isdefined( self.levels[ levelindex ].veteran_achievement ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x1347
// Size: 0x2c
function hasachievement( levelindex )
{
    if ( isdefined( self.levels[ levelindex ].achievement ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x137b
// Size: 0x81, Type: bool
function check_other_haslevelveteranachievement( levelindex )
{
    for ( i = 0; i < self.levels.size ; i++ )
    {
        if ( i == levelindex )
        {
            continue;
        }
        
        if ( !haslevelveteranaward( i ) )
        {
            continue;
        }
        
        if ( self.levels[ i ].veteran_achievement == self.levels[ levelindex ].veteran_achievement )
        {
            if ( getlevelcompleted( i ) < 4 )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x1405
// Size: 0xb
function gethardenedaward()
{
    return self.hardenedaward;
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x1419
// Size: 0x17
function hasmissionhardenedaward()
{
    if ( isdefined( self.hardenedaward ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x1438
// Size: 0x1af
function gettotalpercentcompletesp()
{
    stat_progression = max( getstat_progression( 1 ), getstat_progression( 2 ) );
    var_870ca0c572d3b097 = 0.5;
    println( "<dev string:x26d>" + stat_progression + "<dev string:x282>" + "<dev string:x284>" + var_870ca0c572d3b097 * 100 + "<dev string:x286>" );
    var_44a90f29ee2b00ff = getstat_progression( 3 );
    var_be0978ec6507b6f3 = 0.25;
    println( "<dev string:x289>" + var_44a90f29ee2b00ff + "<dev string:x282>" + "<dev string:x284>" + var_be0978ec6507b6f3 * 100 + "<dev string:x286>" );
    stat_veteran = getstat_progression( 4 );
    var_286fdc6f7b7f3ef7 = 0.1;
    println( "<dev string:x29f>" + stat_veteran + "<dev string:x282>" + "<dev string:x284>" + var_286fdc6f7b7f3ef7 * 100 + "<dev string:x286>" );
    stat_intel = getstat_intel();
    var_64951e461b04a4c0 = 0.15;
    println( "<dev string:x2b4>" + stat_intel + "<dev string:x282>" + "<dev string:x284>" + var_64951e461b04a4c0 * 100 + "<dev string:x286>" );
    assertex( var_870ca0c572d3b097 + var_be0978ec6507b6f3 + var_286fdc6f7b7f3ef7 + var_64951e461b04a4c0 <= 1, "Total sum of SP progress breakdown contributes to more than 100%!" );
    total_progress = 0;
    total_progress += var_870ca0c572d3b097 * stat_progression;
    total_progress += var_be0978ec6507b6f3 * var_44a90f29ee2b00ff;
    total_progress += var_286fdc6f7b7f3ef7 * stat_veteran;
    total_progress += var_64951e461b04a4c0 * stat_intel;
    assertex( total_progress <= 100, "Total Percentage calculation is out of bound, larger then 100%" );
    println( "<dev string:x2c7>" + total_progress + "<dev string:x282>" );
    return total_progress;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x15f0
// Size: 0xe4
function getstat_progression( difficulty )
{
    assert( isdefined( level.missionsettings ) );
    assert( isdefined( level.script ) );
    difficulty_array = level.player function_ff103db8e0d75209();
    levels = 0;
    var_c51133d2565044c9 = [];
    skipped = 0;
    missioncount = min( difficulty_array.size, level.missionsettings.levels.size - 1 );
    
    for ( i = 0; i < missioncount ; i++ )
    {
        if ( difficulty_array[ i ] >= difficulty )
        {
            levels++;
        }
    }
    
    completion = levels / ( level.missionsettings.levels.size - 1 ) * 100;
    return completion;
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x16dd
// Size: 0x1b
function getstat_intel()
{
    return level.player getplayerprogression( "cheatPoints" ) / 45 * 100;
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x1701
// Size: 0x1a
function getlevelcompleted( levelindex )
{
    return level.player function_b3bf603811212474( levelindex );
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x1724
// Size: 0x61
function setlevelcompleted( levelindex )
{
    levelprogressioncomplete( levelindex );
    var_a22f6f453396a4f0 = level.player function_b3bf603811212474( levelindex );
    
    if ( level.lowestgameskill + 1 > var_a22f6f453396a4f0 )
    {
        level.player function_4b0cd7f9ce03cf8( levelindex, level.lowestgameskill + 1 );
    }
    
    function_d46d93b0a99a612d();
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x178d
// Size: 0x23
function highestmission_ifnotcheating_set( mission )
{
    if ( getdvar( @"hash_b8b8e25bb75b206d" ) == "1" )
    {
        return;
    }
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x17b8
// Size: 0x9e
function function_d46d93b0a99a612d()
{
    if ( getdvar( @"hash_b8b8e25bb75b206d" ) == "1" )
    {
        return;
    }
    
    var_64820f36de0a7e54 = level.player function_ff103db8e0d75209();
    
    if ( var_64820f36de0a7e54.size >= level.missionsettings.levels.size )
    {
        var_f6fef0a5f712672b = 1;
        
        for ( i = 0; i < level.missionsettings.levels.size ; i++ )
        {
            if ( var_64820f36de0a7e54[ i ] != 4 && var_64820f36de0a7e54[ i ] != 5 )
            {
                var_f6fef0a5f712672b = undefined;
                break;
            }
        }
    }
}

// Namespace endmission / scripts\sp\endmission
// Params 1
// Checksum 0x0, Offset: 0x185e
// Size: 0x1a
function getlevelskill( levelindex )
{
    return level.player function_b3bf603811212474( levelindex );
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x1881
// Size: 0x6a
function getlowestskill()
{
    missionarray = level.player function_ff103db8e0d75209();
    lowestskill = 4;
    completedmissioncount = min( missionarray.size, self.levels.size );
    
    for ( index = 0; index < completedmissioncount ; index++ )
    {
        if ( missionarray[ index ] < lowestskill )
        {
            lowestskill = missionarray[ index ];
        }
    }
    
    return lowestskill;
}

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x18f4
// Size: 0x30
function getnextlevelindex()
{
    for ( index = 0; index < self.levels.size ; index++ )
    {
        if ( !getlevelskill( index ) )
        {
            return index;
        }
    }
    
    return 0;
}

/#

    // Namespace endmission / scripts\sp\endmission
    // Params 0
    // Checksum 0x0, Offset: 0x192d
    // Size: 0x4f, Type: dev
    function function_b47ee5b0dae14294()
    {
        for ( ;; )
        {
            if ( getdvarint( @"hash_1adbe88f794c0245" ) )
            {
                clearall();
                level.player setplayerprogression( "<dev string:xe4>", 0 );
                setdvar( @"hash_1adbe88f794c0245", "<dev string:xe3>" );
            }
            
            wait 0.05;
        }
    }

#/

// Namespace endmission / scripts\sp\endmission
// Params 0
// Checksum 0x0, Offset: 0x1984
// Size: 0x54
function clearall()
{
    missionarray = [];
    arraycount = level.player function_2d447b52456ea3b8();
    
    for ( index = 0; index < arraycount ; index++ )
    {
        missionarray[ index ] = 0;
    }
    
    level.player function_a320e75d6ec43bb5( missionarray );
}

