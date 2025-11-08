#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;

#namespace smoke;

// Namespace smoke / namespace_1676ee684fdab294
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x44d
// Size: 0x17
function private onplayerdeath( params )
{
    ent_flag_clear( "player_smoke_active" );
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 1
// Checksum 0x0, Offset: 0x46c
// Size: 0x193
function function_d63760cb7c36587( smoke_level )
{
    level notify( "smoke_test_monitor_singleton" );
    level endon( "smoke_test_monitor_singleton" );
    println( "<dev string:x1c>" );
    
    while ( !function_464c7c47f88f997f() )
    {
        wait 0.1;
    }
    
    println( "<dev string:x35>" );
    callback::add( "player_death", &onplayerdeath );
    callback::add( "player_disconnect", &onplayerdeath );
    
    while ( true )
    {
        setdvar( @"hash_f231356c584a015b", 0 );
        var_4516a055a41b717e = getdvarint( @"hash_b5b5a0b219992b30", 0 );
        
        if ( var_4516a055a41b717e > 0 )
        {
            if ( !istrue( level.smoke_started ) )
            {
                function_ee2a48ffc8fda458();
                log_msg( 4, [ "DVAR_SETTING:", var_4516a055a41b717e, "GameType:", getgametype() ] );
                
                switch ( var_4516a055a41b717e )
                {
                    case 1:
                        log_msg( 4, "case 1" );
                        thread smoke_level_1();
                        break;
                    case 2:
                        log_msg( 4, "case 2" );
                        player = getentarray( "player", "classname" )[ 0 ];
                        
                        if ( isdefined( player ) && isalive( player ) )
                        {
                            player thread smoke_level_2();
                        }
                        
                        break;
                    default:
                        log_msg( 4, "default" );
                        break;
                }
            }
        }
        
        setdvar( @"hash_b5b5a0b219992b30", 0 );
        wait 1;
    }
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x607
// Size: 0x41
function private function_ee2a48ffc8fda458()
{
    level.smoke_started = 1;
    level.var_88a8efeaa91fabba = 0;
    level.var_6492adee56d19067 = function_b6dccdc08d6a79cf( 1, 0 );
    level.var_d267f6e95a74866d = 0;
    level.testparams = spawnstruct();
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x650
// Size: 0x24, Type: bool
function private function_464c7c47f88f997f()
{
    return isdefined( level.maxplayercount ) && scripts\mp\utility\game::gamehasstarted() && isdefined( level.players );
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x67d
// Size: 0x24
function private smoke_getpersstat( stat )
{
    if ( isdefined( self.pers ) )
    {
        return self.pers[ stat ];
    }
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x6a9
// Size: 0x33
function private function_63406a3b87272a0f( stat, value )
{
    if ( isdefined( self.pers ) && isdefined( value ) )
    {
        self.pers[ stat ] = value;
    }
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x6e4
// Size: 0x50, Type: bool
function private function_aadecbc412d792b5()
{
    kills = smoke_getpersstat( "kills" );
    
    if ( kills >= 3 )
    {
        log_msg( 3, "Kills reached:" + kills );
        function_63406a3b87272a0f( "kills", 0 );
        return true;
    }
    
    log_msg( 3, "Kills not reached:" + kills );
    return false;
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x73d
// Size: 0x19b
function private function_3ef591377c2b6fd1( testname )
{
    if ( isdefined( level.testparams ) && isdefined( testname ) )
    {
        level.testparams.dt = getdatetime();
        level.testparams.st = gettime();
        level.testparams.event = "TEST_START";
        level.testparams.testname = "SMOKE_TEST: " + testname;
        level.testparams.result = "INIT";
        level.testparams.duration = 0;
        level.testparams.build_id = getdvar( @"hash_444503022bc062df", "0" );
        level.testparams.test_session_id = getdvar( @"hash_79ed55a7f6c778a4", "0" );
    }
    
    log_msg( 2, function_4cafad2d016399da() );
    dlog_recordevent( "dlog_event_automation_smoketest_start", [ "test_name", level.testparams.testname, "test_additional_info", level.testparams.event, "test_session_id", level.testparams.test_session_id, "build_id", level.testparams.build_id ] );
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x8e0
// Size: 0x160
function private function_a48370b9ea15e2f0( status )
{
    if ( isdefined( level.testparams ) )
    {
        level.testparams.et = gettime();
        level.testparams.result = status;
        level.testparams.event = "TEST_END";
        level.testparams.duration = int( function_c89ed1840c8d0f0f( level.testparams.et - level.testparams.st ) );
    }
    
    log_msg( 2, function_4cafad2d016399da() );
    dlog_recordevent( "dlog_event_automation_smoketest_end", [ "test_name", level.testparams.testname, "test_duration_seconds", level.testparams.duration, "test_result", level.testparams.result, "test_additional_info", level.testparams.event, "test_session_id", level.testparams.test_session_id ] );
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xa48
// Size: 0x121
function private function_4cafad2d016399da()
{
    if ( isdefined( level.testparams ) )
    {
        teststr = string_join( level.testparams.dt, "_" ) + "|" + level.testparams.event + "|" + level.testparams.testname + "|" + level.testparams.result + "|" + "Error:" + level.var_6492adee56d19067.messages[ 0 ] + "|" + "Warn:" + level.var_6492adee56d19067.messages[ 1 ] + "|" + level.testparams.build_id + "|" + level.testparams.test_session_id + "|" + level.testparams.duration + "s";
        return teststr;
    }
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 3
// Checksum 0x0, Offset: 0xb71
// Size: 0x9a, Type: bool
function function_243de27a2b9ecbbe( origin, angles, dist )
{
    if ( !function_464c7c47f88f997f() )
    {
        return false;
    }
    
    dist = ter_op( isdefined( dist ), dist, 80 );
    
    if ( isdefined( origin ) && isdefined( angles ) && isdefined( dist ) )
    {
        castend = origin + angles * dist;
        trace = ray_trace( origin, castend );
        
        if ( isdefined( trace ) && ter_op( trace[ "hittype" ] == "hittype_none", 1, 0 ) )
        {
            log_msg( 4, trace[ "hittype" ] );
            return true;
        }
    }
    
    return false;
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 2
// Checksum 0x0, Offset: 0xc14
// Size: 0x53
function function_e8bd86d0c0f85749( var_6c3200050ed240a2, wait_time )
{
    if ( isdefined( self ) && isdefined( var_6c3200050ed240a2 ) )
    {
        wait_time = default_to( wait_time, 1 );
        log_msg( 4, "plr: " + self.clientid + " " + var_6c3200050ed240a2 );
        self botpressbutton( var_6c3200050ed240a2 );
        wait wait_time;
    }
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 2
// Checksum 0x0, Offset: 0xc6f
// Size: 0x53
function function_852d53e299c34e9c( stance, wait_time )
{
    if ( isdefined( self ) && isdefined( stance ) )
    {
        wait_time = default_to( wait_time, 1 );
        log_msg( 4, "plr: " + self.clientid + " " + stance );
        self botsetstance( stance );
        wait wait_time;
    }
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xcca
// Size: 0x152
function private smoke_level_1()
{
    level notify( "smoke_singleton" );
    level endon( "smoke_singleton" );
    
    while ( !function_464c7c47f88f997f() )
    {
        wait 0.05;
    }
    
    function_3ef591377c2b6fd1( "SMOKE_LEVEL_1" );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && isplayer( player ) && !player ent_flag( "player_smoke_active" ) )
        {
            player thread function_c7aeb5253e41a015();
        }
    }
    
    var_733899cede023a70 = 1;
    
    while ( var_733899cede023a70 )
    {
        wait 2;
        var_733899cede023a70 = 0;
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && isplayer( player ) && player ent_flag( "player_smoke_active" ) )
            {
                var_733899cede023a70 = 1;
                break;
            }
        }
    }
    
    function_a48370b9ea15e2f0( "PASS" );
    level.smoke_started = 0;
    setdvar( @"hash_f231356c584a015b", 1 );
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xe24
// Size: 0x230
function private function_c7aeb5253e41a015()
{
    self notify( "player_smoke_loop_singleton" );
    self endon( "player_smoke_loop_singleton" );
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    player = self;
    player ent_flag_set( "player_smoke_active" );
    setdvar( @"player_sustainammo", 1 );
    dist = 200;
    
    if ( !function_243de27a2b9ecbbe( player.origin, anglestoforward( player.angles ), dist ) )
    {
        log_msg( 1, "plr: " + player.clientid + " Spawning bot with ray collision from players forward angles." );
    }
    
    spawndata = function_afc83012117903d9( player, dist );
    level thread [[ level.bot_funcs[ "bots_spawn" ] ]]( 1, player.team, undefined, undefined, undefined, undefined, spawndata );
    bot = undefined;
    wait 1;
    
    if ( !isdefined( bot ) )
    {
        players = getentarray( "player", "classname" );
        
        for ( index = 0; index < players.size ; index++ )
        {
            player = players[ index ];
            
            if ( isbot( player ) && isalive( player ) )
            {
                bot = player;
                break;
            }
        }
    }
    
    if ( isdefined( bot ) )
    {
        bot.ignoreall = 1;
        bot botsetflag( "disable_movement", 1 );
        bot botsetflag( "disable_random_goal", 1 );
        bot function_e8bd86d0c0f85749( "jump" );
        bot function_e8bd86d0c0f85749( "melee" );
        bot function_e8bd86d0c0f85749( "attack" );
        bot function_e8bd86d0c0f85749( "lethal" );
        bot function_e8bd86d0c0f85749( "tactical" );
        bot function_852d53e299c34e9c( "crouch" );
        bot function_852d53e299c34e9c( "prone" );
        bot function_e8bd86d0c0f85749( "attack" );
        bot function_852d53e299c34e9c( "crouch" );
        bot function_852d53e299c34e9c( "stand" );
        log_msg( 4, "plr: " + self.clientid + " ads" );
        bot botpressbutton( "ads", 0.5 );
        wait 1;
    }
    
    player ent_flag_clear( "player_smoke_active" );
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x105c
// Size: 0xfa
function private smoke_level_2()
{
    self endon( "disconnect" );
    self endon( "death" );
    level notify( "smoke_singleton" );
    level endon( "smoke_singleton" );
    player = self;
    function_3ef591377c2b6fd1( "SMOKE_LEVEL_2" );
    setdvar( @"player_sustainammo", 1 );
    player function_9fc451f8cce8fc98( 3 );
    playerkills = player smoke_getpersstat( "kills" );
    
    while ( !player function_aadecbc412d792b5() )
    {
        log_msg( 4, "StartForcedFire" );
        player startforcedfire();
        wait 0.5;
        player stopforcedfire();
        wait 0.5;
        log_msg( 4, "StopForcedFire" );
        playerkills = player smoke_getpersstat( "kills" );
        log_msg( 4, "Kill Count:" + playerkills );
    }
    
    level.var_88a8efeaa91fabba += 1;
    function_a48370b9ea15e2f0( "PASS" + " SMOKE_BOTS_KILLS:" + playerkills );
    function_7d933ec423d9d4f5();
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x115e
// Size: 0x26
function private function_7d933ec423d9d4f5()
{
    if ( function_1c00590758e63257() )
    {
        level.smoke_started = 0;
        setdvar( @"hash_f231356c584a015b", 1 );
    }
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x118c
// Size: 0x8
function private function_1c00590758e63257()
{
    return function_59399abfaa25ec21();
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x119d
// Size: 0xe, Type: bool
function private function_59399abfaa25ec21()
{
    return level.var_88a8efeaa91fabba == 1;
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x11b4
// Size: 0x124
function private function_9fc451f8cce8fc98( var_b7891bdcdcda7208, botteam, spawndata )
{
    self endon( "disconnect" );
    
    while ( !function_464c7c47f88f997f() )
    {
        wait 0.05;
    }
    
    if ( !isdefined( var_b7891bdcdcda7208 ) )
    {
        var_b7891bdcdcda7208 = 1;
    }
    
    if ( !isdefined( botteam ) )
    {
        switch ( self.team )
        {
            case #"hash_7c2d091e6337bf54":
                botteam = "allies";
                break;
            case #"hash_5f54b9bf7583687f":
                botteam = "axis";
                break;
            default:
                break;
        }
    }
    
    while ( isdefined( level.var_d267f6e95a74866d ) && level.var_d267f6e95a74866d < var_b7891bdcdcda7208 )
    {
        spawndata = function_afc83012117903d9( self, level.var_d267f6e95a74866d * 24 + 48 );
        log_msg( 4, "Spawning bot:" + level.var_d267f6e95a74866d );
        level thread [[ level.bot_funcs[ "bots_spawn" ] ]]( 1, botteam, undefined, undefined, undefined, undefined, spawndata );
        level.var_d267f6e95a74866d += 1;
        wait 0.25;
    }
    
    log_msg( 2, "Spawned bot(s):" + var_b7891bdcdcda7208 );
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x12e0
// Size: 0x40
function private function_deadcc8fc572657d( duration )
{
    self endon( "disconnect" );
    
    if ( !isdefined( duration ) )
    {
        duration = 3;
    }
    
    while ( !function_464c7c47f88f997f() )
    {
        wait 0.05;
    }
    
    for ( ;; )
    {
        self startforcedfire();
        wait duration;
        self stopforcedfire();
    }
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x1328
// Size: 0x69
function private function_3819840818a6b8b6( start_angle, end_angle, step_angle, duration )
{
    self endon( "disconnect" );
    
    while ( !function_464c7c47f88f997f() )
    {
        wait 0.05;
    }
    
    current_angle = start_angle;
    
    for ( ;; )
    {
        self setplayerangles( ( 0, current_angle, 0 ) );
        
        if ( current_angle > end_angle )
        {
            current_angle = start_angle;
            continue;
        }
        
        current_angle += step_angle;
        wait duration;
    }
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1399
// Size: 0x1ac
function private function_6e02da7fde448d84( toorigin )
{
    while ( !function_464c7c47f88f997f() )
    {
        wait 0.05;
    }
    
    if ( !isdefined( toorigin ) )
    {
        toorigin = self.origin;
    }
    
    j = 1;
    
    foreach ( p in level.players )
    {
        if ( isalive( p ) && isbot( p ) && p.team != "spectator" )
        {
            p.new_loc = function_afc83012117903d9( self, j * 24 + 48 );
            
            if ( !isdefined( p.new_loc ) )
            {
                continue;
            }
            
            forward = anglestoforward( self.angles );
            p.ignoreall = 1;
            p botsetflag( "disable_movement", 1 );
            p botsetflag( "disable_random_goal", 1 );
            p setorigin( p.new_loc.origin );
            p setplayerangles( ( 0, p.new_loc.angles[ 1 ], 0 ) );
            log_msg( 3, [ "Moved bot to:", p.new_loc.origin, " Angles:", p.new_loc.angles ] );
            j += 1;
        }
    }
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x154d
// Size: 0xc0
function private function_afc83012117903d9( player, spawndist )
{
    if ( !isdefined( player ) )
    {
        player = getentarray( "player", "classname" )[ 0 ];
    }
    
    if ( !isdefined( spawndist ) )
    {
        spawndist = 75;
    }
    
    angles = player getplayerangles();
    fwd = anglestoforward( angles );
    spawnorigin = player.origin + ( 0, 0, 30 ) + fwd * spawndist;
    spawnangles = ( 0, angles[ 1 ] + 180, 0 );
    spawndata = spawnstruct();
    spawndata.origin = spawnorigin;
    spawndata.angles = spawnangles;
    return spawndata;
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 2
// Checksum 0x0, Offset: 0x1616
// Size: 0xbc
function function_b6dccdc08d6a79cf( enabled, logdestination )
{
    logger = spawnstruct();
    logger.enabled = default_to( enabled, 1 );
    logger.logdestination = default_to( logdestination, 0 );
    logger.messages = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        logger.messages[ i ] = 0;
    }
    
    logger.prefixes = [ "[SMOKE_ERROR]", "[SMOKE_WARN]", "[SMOKE_INFO]", "[SMOKE_DEBUG]", "[SMOKE_TRACE]" ];
    return logger;
}

// Namespace smoke / namespace_1676ee684fdab294
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x16db
// Size: 0x123
function private log_msg( loglevel, thetext )
{
    if ( loglevel < 5 && isdefined( thetext ) )
    {
        /#
            if ( isarray( thetext ) )
            {
                thetext = string_join( thetext, "<dev string:x66>" );
            }
            
            switch ( level.var_6492adee56d19067.logdestination )
            {
                case 0:
                    println( level.var_6492adee56d19067.prefixes[ loglevel ] + "<dev string:x66>" + thetext );
                    break;
                case 1:
                    iprintln( level.var_6492adee56d19067.prefixes[ loglevel ] + "<dev string:x66>" + thetext );
                    break;
                default:
                    assertmsg( "<dev string:x68>" + default_to( level.var_6492adee56d19067.logdestination, "<dev string:x89>" ) );
                    break;
            }
        #/
        
        level.var_6492adee56d19067.messages[ loglevel ] += 1;
    }
}

