#using script_1593390328d4b03f;
#using script_2054aeaae312dd57;
#using script_2986aa4b0ff2bddf;
#using script_40e63dd222434655;
#using script_47e50634bcd54a6d;
#using script_59ff79d681bb860c;
#using script_79a6268aa7298ac4;
#using script_7c53ec390fad942d;
#using script_dfbffa20f9a73d;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\load;
#using scripts\mp\utility\print;

#namespace mit;

// Namespace mit / namespace_ef54497d29a56093
// Params 0
// Checksum 0x0, Offset: 0x500
// Size: 0x11
function function_5a60778277d6ae4b()
{
    return getdvarint( @"hash_cd66a9bfc03ac479", 0 );
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x51a
// Size: 0x11
function private checkdoor()
{
    return getdvarint( @"hash_a26ae46918350c7", 0 );
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x534
// Size: 0x12
function private function_4de50e7b0da34ab()
{
    return getdvarint( @"hash_abc7f3036a7a549b", 1 );
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x54f
// Size: 0x11
function private checktraversal()
{
    return getdvarint( @"hash_b0eefb927ba15201", 0 );
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x569
// Size: 0x11
function private function_51a400f6949511de()
{
    return getdvarint( @"hash_eb781589d9dabf4f", 0 );
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x583
// Size: 0x11
function private function_2327b6e483b3fb90()
{
    return getdvarint( @"hash_a941d4176a868108", 0 );
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x59d
// Size: 0x115
function private mapinitialize()
{
    level.mit = spawnstruct();
    level.mit.var_513a313408516dc2 = getdvarint( @"hash_a7c59e9830aa5637", 0 );
    level.mit.var_204746694f255ae3 = 1;
    level.var_b017944f02bb5e97 = 1;
    
    if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        scripts\mp\gametypes\br_c130::setc130heightoverrides();
    }
    
    level.mit.spawnpointminradius = getdvarint( @"hash_27572078d01a0677", 50 );
    level.mit.spawnpointmaxradius = getdvarint( @"hash_f6297cf726b2f395", 100 );
    spawnpointenabled = getdvarint( @"hash_f7910830506b8974", 0 );
    
    if ( spawnpointenabled )
    {
        level.mit.spawnpoint = getdvarvector( @"hash_597f15c7e66412ef" );
        level.getspawnpoint = &getspawnpoint;
    }
    else
    {
        level.var_744dfabb8f946331 = &function_744dfabb8f946331;
    }
    
    level thread function_ba26c6f0f3861ea2();
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0
// Checksum 0x0, Offset: 0x6ba
// Size: 0x86
function getspawnpoint()
{
    spawnpoint = spawnstruct();
    spawnpoint.origin = function_cf24515b476de99e( level.mit.spawnpoint, level.mit.spawnpointminradius, level.mit.spawnpointmaxradius );
    spawnpoint.angles = ( 0, 0, 0 );
    spawnpoint.index = 1;
    return spawnpoint;
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0
// Checksum 0x0, Offset: 0x749
// Size: 0x112
function initialize()
{
    mapinitialize();
    
    /#
        namespace_9fa112241a70b32b::function_66c502dfb1c607b2();
        level thread function_8272e3327eca4ddc();
    #/
    
    level.bot_funcs[ "player_spawned_gamemode" ] = &botinitialize;
    level.bot_funcs[ "gametype_think" ] = &function_43ab8f184738915a;
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        scripts\mp\gametypes\br_gametypes::function_ec416fa15d5fa6af( "onPlayerKilled" );
        scripts\mp\gametypes\br_gametypes::registerbrgametypefunc( "onPlayerKilled", &br_onplayerkilled );
        scripts\mp\gametypes\br_gametypes::function_ec416fa15d5fa6af( "playerShouldRespawn" );
        scripts\mp\gametypes\br_gametypes::registerbrgametypefunc( "playerShouldRespawn", &function_cc11b02ab6d8e8a4 );
    }
    else
    {
        level.onplayerkilled = &onplayerkilled;
    }
    
    if ( checkdoor() )
    {
        namespace_47a22a8f9dbdb88d::init();
    }
    
    if ( checktraversal() )
    {
        namespace_e52f2dbcddf04577::init();
    }
    
    if ( function_2327b6e483b3fb90() )
    {
        namespace_577f6919a96a7b63::init();
    }
    
    namespace_40f17d09cd6b145::init();
    namespace_4dbcecb8aa6160e3::init();
    
    if ( function_4de50e7b0da34ab() )
    {
        namespace_4fc54f74105650c0::function_14f6e531ffd2958d();
    }
    
    level thread function_ccaf436f3f04c8cc();
    
    /#
        level.mit.var_5696004ca866d848 = [];
        level thread function_6d1c17a3f1f2d562();
    #/
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x863
// Size: 0x40
function private botinitialize()
{
    self.onlyscriptenemy = 1;
    bot_set_personality( "run_and_gun" );
    self botsetflag( "disable_random_goal", 1 );
    self.mit = spawnstruct();
    self.hasrespawntoken = 1;
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x8ab
// Size: 0x2e
function private function_744dfabb8f946331()
{
    return generatespawnpoints( level.mit.spawnpointminradius, level.mit.spawnpointmaxradius );
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x8e2
// Size: 0x71
function private function_ba26c6f0f3861ea2()
{
    level waittill( "player_spawned" );
    setdvar( @"hash_8c74085973b14303", 0 );
    setdvar( @"hash_89556297eaab6b6a", 0 );
    result = level waittill_any_timeout_1( 10, "spawned_bots" );
    
    if ( result == "timeout" )
    {
        botcount = getdvarint( @"hash_a9944abc2f276e96", 0 );
        level thread namespace_bc2665cbe6cf4e1f::function_f166b9f78beca5e6( botcount );
    }
}

// Namespace mit / namespace_ef54497d29a56093
// Params 2
// Checksum 0x0, Offset: 0x95b
// Size: 0xa7
function function_b564050a363f08ec( bot, waitseconds )
{
    pathevents = [ "goal", "off_navmesh", "bad_path_door_blocker_door_owner", "bad_path_door_blocker_invalid_client", "bad_path_stuck_in_traversal", "bad_path_fell_over_edge_when_jump", "bad_path_fell_over_edge", "bad_path_no_path_found", "bad_path_frozen", "bad_path_owner_collide", "bad_path_node_claimed_by_other", "bad_path_claimed_node_lost", "bad_path_pathnode_inactive", "bad_path_no_tac_point" ];
    return bot waittill_any_in_array_or_timeout( pathevents, waitseconds );
}

// Namespace mit / namespace_ef54497d29a56093
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xa0b
// Size: 0x5e
function private br_onplayerkilled( deathdata )
{
    if ( isdefined( self.mit.onplayerkilled ) )
    {
        [[ self.mit.onplayerkilled ]]( deathdata );
    }
    
    self.hasrespawntoken = 1;
    self.pers[ "lives" ]++;
    self.liveragdoll = 0;
}

// Namespace mit / namespace_ef54497d29a56093
// Params 10, eflags: 0x4
// Checksum 0x0, Offset: 0xa71
// Size: 0xae
function private onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    deathdata = spawnstruct();
    deathdata.meansofdeath = smeansofdeath;
    
    if ( isdefined( self.mit ) && isdefined( self.mit.onplayerkilled ) )
    {
        [[ self.mit.onplayerkilled ]]( deathdata );
    }
}

// Namespace mit / namespace_ef54497d29a56093
// Params 3
// Checksum 0x0, Offset: 0xb27
// Size: 0x4c
function botteleport( position, distancetolerance, var_f24bccd9181848c1 )
{
    self botsetflag( "disable_movement", 1 );
    errorstring = function_e6b91d3fc0e1a873( position, distancetolerance, var_f24bccd9181848c1 );
    self botsetflag( "disable_movement", 0 );
    return errorstring;
}

// Namespace mit / namespace_ef54497d29a56093
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xb7c
// Size: 0x144
function private function_e6b91d3fc0e1a873( position, distancetolerance, var_f24bccd9181848c1 )
{
    self botclearscriptgoal();
    self setvelocity( ( 0, 0, 0 ) );
    
    if ( !function_8deb12db7dc34202() )
    {
        return "unstoppable movement";
    }
    
    clippos = position;
    
    if ( isdefined( var_f24bccd9181848c1 ) )
    {
        var_ac488fbc8f8e10ed = -30 - var_f24bccd9181848c1;
        contents = physics_createcontents( [ "physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_water" ] );
        clippos = drop_to_ground( position, var_f24bccd9181848c1, var_ac488fbc8f8e10ed, undefined, contents );
        
        if ( floatequal( clippos[ 2 ] - position[ 2 ], var_ac488fbc8f8e10ed, 1 ) )
        {
            return "no clip";
        }
    }
    
    beforetp = self.origin;
    self setorigin( clippos );
    
    if ( !function_8deb12db7dc34202() )
    {
        return "still sliding";
    }
    
    dist = distance( position, self.origin );
    
    if ( dist > distancetolerance && !( self isswimming() || ispointinwater( self.origin ) ) )
    {
        return ( "inaccurate " + dist + "/" + distancetolerance + ", bot's position before tp:" + beforetp );
    }
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xcc8
// Size: 0x79, Type: bool
function private function_8deb12db7dc34202()
{
    waitframe();
    waitframe();
    var_d8870c535f6fa86 = 20;
    var_b4513df28daee805 = function_cc7e90653e9dab25( var_d8870c535f6fa86 );
    starttime = function_71b519a5e0525acc();
    endtime = starttime + var_b4513df28daee805;
    
    while ( self getvelocity() != ( 0, 0, 0 ) && !self isswimming() )
    {
        wait 0.1;
        
        if ( function_71b519a5e0525acc() >= endtime )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace mit / namespace_ef54497d29a56093
// Params 3
// Checksum 0x0, Offset: 0xd4a
// Size: 0xd8
function outputlog( category, reportstr, append )
{
    var_b18e856504fd9803 = 2048;
    
    if ( istrue( append ) )
    {
        header = "[MIT]+";
    }
    else
    {
        header = "[MIT]" + category + ";";
    }
    
    maxlength = var_b18e856504fd9803 - header.size;
    
    if ( reportstr.size <= maxlength )
    {
        logstring( header + reportstr );
        return;
    }
    
    for ( startindex = 0; startindex < reportstr.size ; startindex = endindex )
    {
        endindex = int( min( startindex + maxlength, reportstr.size ) );
        substring = getsubstring( reportstr, startindex, endindex );
        logstring( header + substring );
        
        if ( startindex == 0 )
        {
            header = "[MIT]+";
            maxlength = var_b18e856504fd9803 - header.size;
        }
    }
}

// Namespace mit / namespace_ef54497d29a56093
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xe2a
// Size: 0x64
function private getsubstring( str, start, end )
{
    var_412e737891ac8b31 = 1023;
    substring = "";
    
    while ( end - start > var_412e737891ac8b31 )
    {
        substring += getsubstr( str, start, start + var_412e737891ac8b31 );
        start += var_412e737891ac8b31;
    }
    
    substring += getsubstr( str, start, end );
    return substring;
}

// Namespace mit / namespace_ef54497d29a56093
// Params 3
// Checksum 0x0, Offset: 0xe97
// Size: 0x25, Type: bool
function floatequal( float1, float2, epsilon )
{
    return abs( float1 - float2 ) < epsilon;
}

// Namespace mit / namespace_ef54497d29a56093
// Params 4
// Checksum 0x0, Offset: 0xec5
// Size: 0x202, Type: bool
function function_3c55380b5e177254( p1, p2, q1, q2 )
{
    var_a50631b6539f72d5 = ter_op( p1[ 0 ] > p2[ 0 ], p1[ 0 ], p2[ 0 ] );
    var_a5291bb653c58a2b = ter_op( p1[ 0 ] > p2[ 0 ], p2[ 0 ], p1[ 0 ] );
    var_1b13c7a356a1e420 = ter_op( p1[ 1 ] > p2[ 1 ], p1[ 1 ], p2[ 1 ] );
    var_1af0bda3567b866a = ter_op( p1[ 1 ] > p2[ 1 ], p2[ 1 ], p1[ 1 ] );
    var_31ab34a515f2c3c6 = ter_op( q1[ 0 ] > q2[ 0 ], q1[ 0 ], q2[ 0 ] );
    var_318826a515cc5d44 = ter_op( q1[ 0 ] > q2[ 0 ], q2[ 0 ], q1[ 0 ] );
    var_fee7f6b9bb338ed3 = ter_op( q1[ 1 ] > q2[ 1 ], q1[ 1 ], q2[ 1 ] );
    var_ff0b0cb9bb5a06ed = ter_op( q1[ 1 ] > q2[ 1 ], q2[ 1 ], q1[ 1 ] );
    
    if ( var_a50631b6539f72d5 < var_318826a515cc5d44 || var_31ab34a515f2c3c6 < var_a5291bb653c58a2b || var_1b13c7a356a1e420 < var_ff0b0cb9bb5a06ed || var_fee7f6b9bb338ed3 < var_1af0bda3567b866a )
    {
        return false;
    }
    
    res1 = ( p1[ 0 ] - p2[ 0 ] ) * ( q1[ 1 ] - p2[ 1 ] ) - ( p1[ 1 ] - p2[ 1 ] ) * ( q1[ 0 ] - p2[ 0 ] );
    res2 = ( p1[ 0 ] - p2[ 0 ] ) * ( q2[ 1 ] - p2[ 1 ] ) - ( p1[ 1 ] - p2[ 1 ] ) * ( q2[ 0 ] - p2[ 0 ] );
    res3 = ( q1[ 0 ] - q2[ 0 ] ) * ( p1[ 1 ] - q2[ 1 ] ) - ( q1[ 1 ] - q2[ 1 ] ) * ( p1[ 0 ] - q2[ 0 ] );
    res4 = ( q1[ 0 ] - q2[ 0 ] ) * ( p2[ 1 ] - q2[ 1 ] ) - ( q1[ 1 ] - q2[ 1 ] ) * ( p2[ 0 ] - q2[ 0 ] );
    return res1 * res2 <= 0 && res3 * res4 <= 0;
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0
// Checksum 0x0, Offset: 0x10d0
// Size: 0xd
function function_71b519a5e0525acc()
{
    return gettime() * gettimescale();
}

// Namespace mit / namespace_ef54497d29a56093
// Params 1
// Checksum 0x0, Offset: 0x10e6
// Size: 0x55
function function_cc7e90653e9dab25( durationsec )
{
    var_1a5084f74d8a14df = durationsec * 1000;
    
    if ( gettimescale() == 4 )
    {
        var_76edfa97585d9b57 = 0.5;
        assert( gettimescale() * var_76edfa97585d9b57 >= 1 );
        var_1a5084f74d8a14df /= var_76edfa97585d9b57;
    }
    
    return var_1a5084f74d8a14df;
}

// Namespace mit / namespace_ef54497d29a56093
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1144
// Size: 0xc3
function private generatespawnpoints( secondaryminradius, secondarymaxradius )
{
    points = [];
    num = getdvarint( @"hash_a9944abc2f276e96", 1 ) + 1;
    
    for ( i = 0; i < num ; i++ )
    {
        randompoint = namespace_4dbcecb8aa6160e3::function_3ec57983d173d1e3();
        startpoint = spawnstruct();
        startpoint.origin = function_cf24515b476de99e( randompoint, secondaryminradius, secondarymaxradius );
        startpoint.angles = ( 0, randomfloat( 360 ), 0 );
        startpoint.team = undefined;
        startpoint.script_label = "InteriorSpawnPoint";
        points[ points.size ] = startpoint;
    }
    
    return points;
}

// Namespace mit / namespace_ef54497d29a56093
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1210
// Size: 0x44
function private function_cf24515b476de99e( point, secondaryminradius, secondarymaxradius )
{
    assert( secondaryminradius > 0 && secondarymaxradius > secondaryminradius );
    return scripts\mp\gametypes\br_circle::getrandompointincircle( point, secondarymaxradius, float( secondaryminradius ) / secondarymaxradius, 1, 1, 1 );
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x125d
// Size: 0x2f
function private function_43ab8f184738915a()
{
    self notify( "map_integrity_testing" );
    self endon( "map_integrity_testing" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        function_f62e0c533ead8b59();
        waitframe();
    }
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1294
// Size: 0x53
function private function_ccaf436f3f04c8cc()
{
    level endon( "game_ended" );
    startime = getsystemtime();
    
    while ( true )
    {
        time = ( getsystemtime() - startime ) * 1000;
        outputlog( "Timer", "The game has been running for:" + scripts\mp\utility\print::getformattedtimestamp( time ) );
        wait 60;
    }
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x12ef
// Size: 0x4, Type: bool
function private function_cc11b02ab6d8e8a4()
{
    return true;
}

// Namespace mit / namespace_ef54497d29a56093
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x12fc
// Size: 0x45
function private runtest( name, testprocess, endhandler )
{
    thread function_ff299aa9c1c02c3e( name, endhandler );
    thread function_b5eeb52ea9d620b2( name, testprocess );
    waittill_any_in_array( [ name, "death_or_disconnect" ] );
}

// Namespace mit / namespace_ef54497d29a56093
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1349
// Size: 0x27
function private function_b5eeb52ea9d620b2( name, testprocess )
{
    self endon( name );
    self endon( "death_or_disconnect" );
    self [[ testprocess ]]();
    waitframe();
    self notify( name );
}

// Namespace mit / namespace_ef54497d29a56093
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1378
// Size: 0x2e
function private function_ff299aa9c1c02c3e( name, endhandler )
{
    waittill_any_in_array( [ name, "death_or_disconnect" ] );
    self [[ endhandler ]]();
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x13ae
// Size: 0x1e1
function private function_f62e0c533ead8b59()
{
    if ( function_51a400f6949511de() && !istrue( level.mit.lootchecked ) )
    {
        level thread namespace_40f17d09cd6b145::function_5d1148bbed9fc1d7();
        level.mit.lootchecked = 1;
    }
    
    var_e1745dae8cdd8388 = 0;
    
    /#
        var_e1745dae8cdd8388 = namespace_9fa112241a70b32b::function_e1745dae8cdd8388();
    #/
    
    if ( var_e1745dae8cdd8388 )
    {
        /#
            runtest( "<dev string:x1c>", &namespace_9fa112241a70b32b::function_caedac3a0de734d, &namespace_4dbcecb8aa6160e3::endhandler );
        #/
        
        return;
    }
    
    if ( checkdoor() && namespace_47a22a8f9dbdb88d::function_3113f44ebafe71b1() )
    {
        runtest( "door", &namespace_47a22a8f9dbdb88d::testprocess, &namespace_47a22a8f9dbdb88d::endhandler );
        return;
    }
    
    if ( checktraversal() && namespace_e52f2dbcddf04577::function_3113f44ebafe71b1() )
    {
        runtest( "traversal", &namespace_e52f2dbcddf04577::testprocess, &namespace_e52f2dbcddf04577::endhandler );
        return;
    }
    
    if ( function_2327b6e483b3fb90() && namespace_577f6919a96a7b63::function_3113f44ebafe71b1() )
    {
        runtest( "connectivity", &namespace_577f6919a96a7b63::testprocess, &namespace_577f6919a96a7b63::endhandler );
        return;
    }
    
    if ( namespace_4dbcecb8aa6160e3::function_3113f44ebafe71b1() )
    {
        level.mit.var_204746694f255ae3 = 0;
        runtest( "roaming", &namespace_4dbcecb8aa6160e3::testprocess, &namespace_4dbcecb8aa6160e3::endhandler );
        return;
    }
    
    self.mit.var_6d6f86879ea55752 = 1;
    gameend = 1;
    
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            continue;
        }
        
        if ( !istrue( player.mit.var_6d6f86879ea55752 ) )
        {
            gameend = 0;
            break;
        }
    }
    
    if ( gameend )
    {
        level thread scripts\mp\gamelogic::forceend();
    }
    
    self notify( "map_integrity_testing" );
}

// Namespace mit / namespace_ef54497d29a56093
// Params 0
// Checksum 0x0, Offset: 0x1597
// Size: 0x24
function function_d4cc0fe3bc1557bf()
{
    assert( !isdefined( level.struct_filter ) );
    level.struct_filter = &filterstructs;
}

// Namespace mit / namespace_ef54497d29a56093
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x15c3
// Size: 0x39
function private filterstructs( struct )
{
    if ( isdefined( struct.targetname ) && struct.targetname == "gulag" )
    {
        return 1;
    }
    
    return scripts\mp\load::filterstructs( struct );
}

/#

    // Namespace mit / namespace_ef54497d29a56093
    // Params 5
    // Checksum 0x0, Offset: 0x1605
    // Size: 0xbe, Type: dev
    function function_f2bc01a7b0321f52( testphase, targetpos, camerapos, originaltask, var_31e45429b9998458 )
    {
        info = spawnstruct();
        info.camerapos = camerapos;
        info.cameraangle = vectortoangles( targetpos - camerapos );
        info.testphase = testphase;
        info.targetpos = targetpos;
        info.originaltask = originaltask;
        info.var_31e45429b9998458 = var_31e45429b9998458;
        level.mit.var_5696004ca866d848[ level.mit.var_5696004ca866d848.size ] = info;
    }

    // Namespace mit / namespace_ef54497d29a56093
    // Params 0
    // Checksum 0x0, Offset: 0x16cb
    // Size: 0x27b, Type: dev
    function function_6d1c17a3f1f2d562()
    {
        level endon( "<dev string:x27>" );
        level waittill( "<dev string:x35>", player );
        setdvar( @"ai_shownavmesh", 2 );
        setdvar( @"hash_3c48eaf332022cd9", 1 );
        defaultplayer = level.players[ 0 ];
        defaultplayer dontinterpolate();
        
        while ( true )
        {
            if ( !getdvarint( @"hash_824c718cad3c0f17", 1 ) || level.mit.var_5696004ca866d848.size == 0 )
            {
                wait 1;
                continue;
            }
            
            if ( !defaultplayer isnoclip() )
            {
                defaultplayer noclip();
            }
            
            var_1a1ddfa1a9811c7c = level.mit.var_5696004ca866d848[ 0 ];
            
            if ( level.mit.var_204746694f255ae3 && function_3e26a18e77c086b0( var_1a1ddfa1a9811c7c.targetpos ) )
            {
                wait 2;
                continue;
            }
            
            if ( var_1a1ddfa1a9811c7c.testphase == "<dev string:x47>" )
            {
                defaultplayer thread namespace_e52f2dbcddf04577::function_dec8f2a03738931b( var_1a1ddfa1a9811c7c.originaltask );
            }
            else if ( var_1a1ddfa1a9811c7c.testphase == "<dev string:x54>" )
            {
                defaultplayer thread namespace_4dbcecb8aa6160e3::function_63bde891e2fb515c( var_1a1ddfa1a9811c7c.targetpos );
            }
            
            level.mit.var_5696004ca866d848 = array_remove_index( level.mit.var_5696004ca866d848, 0 );
            defaultplayer setorigin( var_1a1ddfa1a9811c7c.camerapos );
            defaultplayer setplayerangles( var_1a1ddfa1a9811c7c.cameraangle );
            wait 0.2;
            posstring = int( var_1a1ddfa1a9811c7c.targetpos[ 0 ] ) + "<dev string:x5f>" + int( var_1a1ddfa1a9811c7c.targetpos[ 1 ] ) + "<dev string:x5f>" + int( var_1a1ddfa1a9811c7c.targetpos[ 2 ] );
            screenshotfilename = "<dev string:x64>" + var_1a1ddfa1a9811c7c.testphase + "<dev string:x5f>" + posstring + "<dev string:x72>" + var_1a1ddfa1a9811c7c.var_31e45429b9998458;
            adddebugcommand( "<dev string:x81>" + screenshotfilename + "<dev string:x94>" );
            wait 0.5;
            
            if ( var_1a1ddfa1a9811c7c.testphase == "<dev string:x54>" )
            {
                level notify( "<dev string:x9a>" + var_1a1ddfa1a9811c7c.var_31e45429b9998458 );
            }
            
            if ( defaultplayer isnoclip() )
            {
                defaultplayer noclip();
            }
        }
    }

    // Namespace mit / namespace_ef54497d29a56093
    // Params 1
    // Checksum 0x0, Offset: 0x194e
    // Size: 0x8e, Type: dev
    function function_3e26a18e77c086b0( pos )
    {
        foreach ( player in level.players )
        {
            if ( !( namespace_41f4dfb71dd08362::isvalidplayer( player ) && isbot( player ) ) )
            {
                continue;
            }
            
            if ( distance2dsquared( pos, player.origin ) < 10000 )
            {
                return 1;
            }
        }
        
        return 0;
    }

    // Namespace mit / namespace_ef54497d29a56093
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x19e4
    // Size: 0x43, Type: dev
    function private function_8272e3327eca4ddc()
    {
        level waittill( "<dev string:x35>" );
        
        if ( getdvarint( @"hash_1992a1ad0bd6723b", 0 ) != 0 )
        {
            adddebugcommand( "<dev string:xbe>" );
            wait 1;
            assert( gettimescale() == 4 );
        }
    }

#/
