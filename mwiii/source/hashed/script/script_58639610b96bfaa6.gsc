#using script_64acb6ce534155b7;
#using scripts\common\ai;
#using scripts\common\create_script_utility;
#using scripts\common\utility;
#using scripts\cp_mp\equipment\geiger_counter;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_util;
#using scripts\mp\movers;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace namespace_1595ce89357b7e39;

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x1856
// Size: 0x46
function init()
{
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "dmz_radioactive_object_1", &function_5bc57c3a339eba95 );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "dmz_radioactive_object_2", &function_5bc57c3a339eba95 );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "dmz_radioactive_object_3", &function_5bc57c3a339eba95 );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "dmz_secret_stash", &function_5bc57c3a339eba95 );
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 4
// Checksum 0x0, Offset: 0x18a4
// Size: 0xe6
function function_8a49992a2e6901e6( activity, numcircles, fortress, spawntrap )
{
    if ( !isdefined( numcircles ) )
    {
        numcircles = 1;
    }
    
    if ( !isdefined( spawntrap ) )
    {
        spawntrap = 0;
    }
    
    task = task_create( activity );
    task.funcs[ "onInit" ] = &function_a41a8966906f798d;
    task.funcs[ "onTeamAssigned" ] = &function_a6ff88151cf5542b;
    task.ref = ter_op( isdefined( fortress ), "dmz_fortress_search_bads", "dmz_search_bads" );
    task.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex( task.ref );
    task.numcircles = numcircles;
    task.fortress = fortress;
    task.spawntrap = spawntrap;
    activity.var_75ded47b03386e57 = 1;
    return task;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x1993
// Size: 0x3c
function function_a41a8966906f798d( teamname )
{
    level.var_d648ed8eca1dfb3c = spawnstruct();
    level.var_d648ed8eca1dfb3c.task = self;
    function_27f9050017807d8a();
    function_5982d93ea6bd26cd();
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x19d7
// Size: 0x15
function function_5d8bee83697787cc()
{
    return level.var_d648ed8eca1dfb3c.task;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x19f5
// Size: 0x1d
function function_4b0b660ecab607e6()
{
    return getteamdata( function_5d8bee83697787cc().team, "players" );
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x1a1b
// Size: 0x171
function function_a6ff88151cf5542b( teamname )
{
    locations = undefined;
    locations = getstructarray( "intel_loc", "targetname" );
    self.itotalobjects = locations.size;
    self.var_1ae1be9ca33b1a87 = 0;
    self.circletracker = [];
    
    foreach ( location in locations )
    {
        var_187e63a5cf6d992a = function_111ec726eaa1ce68( location );
        function_67e00b8d4251c284( var_187e63a5cf6d992a.origin, var_187e63a5cf6d992a.angles, teamname, self, self.spawntrap, var_187e63a5cf6d992a.script_noteworthy );
    }
    
    var_f934392aa6995070 = function_56f0fe0080c4f01e();
    function_e2db801fc08bbfca( var_f934392aa6995070, teamname );
    scripts\mp\utility\dialog::leaderdialog( "dmz_mission_search_assigned", teamname );
    
    foreach ( circle in self.questcircles )
    {
        circle thread function_c847bfd52c064289( circle.mapcircle.origin + ( 0, 0, 500 ) );
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x1b94
// Size: 0x98
function function_e2db801fc08bbfca( var_f934392aa6995070, teamname )
{
    foreach ( index, var_532ec2cd26095da3 in var_f934392aa6995070 )
    {
        function_325390edb051cd5d( "Explore_Dmz", [ var_532ec2cd26095da3.origin ], 1500, teamname );
        self.circletracker[ var_532ec2cd26095da3.script_noteworthy ] = self.questcircles[ index ];
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x1c34
// Size: 0x96
function function_56f0fe0080c4f01e( var_7f0f9ad360500e73 )
{
    structs = [];
    
    foreach ( location in getstructarray( "objective_location", "targetname" ) )
    {
        if ( istrue( var_7f0f9ad360500e73 ) )
        {
            location.origin += function_6174330574a2a273() * 200;
        }
        
        structs[ structs.size ] = location;
    }
    
    return structs;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x1cd3
// Size: 0x8f
function function_c15ef1bb5dd116a0( teamname )
{
    if ( isdefined( self.fortress ) )
    {
        function_629ed367d1393020();
    }
    else
    {
        foreach ( circle in self.questcircles )
        {
            circle function_629ed367d1393020();
        }
        
        function_1759acfd39bb5edf( "dmz_search_complete", teamname );
    }
    
    scripts\common\create_script_utility::cleanup_cs_file_objects( "mp_dmz_hydro_bads_create_script" );
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 6
// Checksum 0x0, Offset: 0x1d6a
// Size: 0x81
function function_5bc57c3a339eba95( instance, part, state, player, bautouse, usestring )
{
    if ( ( part == "dmz_radioactive_object_1" || part == "dmz_radioactive_object_2" || part == "dmz_radioactive_object_3" ) && state == "usable" )
    {
        function_cf54f4de9e8d2608( instance, player );
        function_bb50fb4b09b7f165( instance, part, state, player, bautouse, usestring );
        instance setscriptablepartstate( part, "unusable" );
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x1df3
// Size: 0xeb
function function_cf54f4de9e8d2608( instance, player )
{
    if ( !isdefined( instance.task ) )
    {
        return;
    }
    
    task = instance.task;
    
    if ( isdefined( task.teams ) && array_contains( task.teams, player.team ) )
    {
        scripts\cp_mp\equipment\geiger_counter::function_a67007b5af86ff0b( instance );
        task function_ec727a26a8b9db8f();
        task function_db7e4ab290b642c1( instance, player.team );
        
        if ( task function_3710f7eb08295551() )
        {
            if ( isdefined( task.mission.next ) )
            {
                task.mission.next.instance = instance;
            }
            
            function_c15ef1bb5dd116a0( player.team );
            task task_ended();
        }
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x1ee6
// Size: 0x77
function function_db7e4ab290b642c1( instance, teamname )
{
    foreach ( var_cf1f227589f2acda, circle in self.circletracker )
    {
        if ( var_cf1f227589f2acda == instance.locationref )
        {
            circle function_629ed367d1393020();
        }
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x1f65
// Size: 0x2d
function function_ec727a26a8b9db8f()
{
    self.var_1ae1be9ca33b1a87++;
    assertex( self.itotalobjects >= self.var_1ae1be9ca33b1a87, "<dev string:x1c>" );
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x1f9a
// Size: 0x15, Type: bool
function function_3710f7eb08295551()
{
    return self.itotalobjects == self.var_1ae1be9ca33b1a87;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 6
// Checksum 0x0, Offset: 0x1fb8
// Size: 0x3a
function function_bb50fb4b09b7f165( instance, part, state, player, bautouse, usestring )
{
    function_60291dfce2923372();
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x1ffa
// Size: 0x5c
function function_b9beb2bb0e6b4941( location_string )
{
    switch ( location_string )
    {
        case #"hash_31103fbc01bd840c":
            return "dmz_radioactive_object_1";
        case #"hash_311042bc01bd88c5":
            return "dmz_radioactive_object_2";
        case #"hash_311041bc01bd8732":
            return "dmz_radioactive_object_3";
        default:
            return "dmz_radioactive_object_3";
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 6
// Checksum 0x0, Offset: 0x205e
// Size: 0x2de
function function_67e00b8d4251c284( inorigin, var_5b9c864b21207ff6, teamname, task, spawntrap, location_string )
{
    cache = undefined;
    inorigin += anglestoright( var_5b9c864b21207ff6 ) * -10;
    var_5b9c864b21207ff6 = ( var_5b9c864b21207ff6[ 0 ], var_5b9c864b21207ff6[ 1 ] + 180, var_5b9c864b21207ff6[ 2 ] );
    scriptable_name = function_b9beb2bb0e6b4941( location_string );
    cache = spawnscriptable( scriptable_name, inorigin, var_5b9c864b21207ff6 );
    scripts\cp_mp\equipment\geiger_counter::function_f0d61e14dfde9ccd( cache );
    playerlist = getteamdata( teamname, "players" );
    assertex( isdefined( playerlist ) || playerlist.size > 0, "<dev string:x6e>" );
    var_7f599accb72658d1 = playerlist[ 0 ];
    cache.teamname = teamname;
    cache.task = task;
    cache.locationref = location_string;
    cache.var_534e0cf170a981b7 = &function_cf54f4de9e8d2608;
    cache.contents = [];
    cache.contents[ 0 ][ "quantity" ] = randomintrange( 50, 84 );
    cache.contents[ 0 ][ "lootID" ] = 8395;
    cache.contents[ 1 ][ "quantity" ] = randomintrange( 50, 85 );
    cache.contents[ 1 ][ "lootID" ] = 8395;
    cache.contents[ 2 ][ "quantity" ] = randomintrange( 50, 84 );
    cache.contents[ 2 ][ "lootID" ] = 8395;
    cache.contents[ 3 ][ "quantity" ] = 1;
    cache.contents[ 3 ][ "lootID" ] = 549;
    cache.contents[ 4 ][ "quantity" ] = 1;
    cache.contents[ 4 ][ "lootID" ] = 9230;
    cache.contents[ 5 ][ "quantity" ] = 1;
    cache.contents[ 5 ][ "lootID" ] = 9224;
    cache.contents = array_randomize( cache.contents );
    
    foreach ( player in level.players )
    {
        if ( player != var_7f599accb72658d1 && ( var_7f599accb72658d1.team == "none" || player.team != var_7f599accb72658d1.team ) )
        {
            cache disablescriptableplayeruse( player );
        }
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x2344
// Size: 0xda
function function_111ec726eaa1ce68( parentstruct )
{
    struct = undefined;
    
    if ( isdefined( parentstruct.target ) )
    {
        var_bae65ff0227a539 = getstructarray( parentstruct.target, "targetname" );
        force_selection = getdvarint( @"hash_eb2f6d009f65cb77", 1 );
        
        switch ( force_selection )
        {
            case 1:
                struct = random( var_bae65ff0227a539 );
                break;
            case 2:
                struct = function_ae7f38910a49197e( "a", var_bae65ff0227a539 );
                break;
            case 3:
                struct = function_ae7f38910a49197e( "b", var_bae65ff0227a539 );
                break;
            case 4:
                struct = function_ae7f38910a49197e( "c", var_bae65ff0227a539 );
                break;
        }
    }
    
    return struct;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x2427
// Size: 0x6a
function function_ae7f38910a49197e( script_noteworthy, array )
{
    foreach ( interactionstruct in array )
    {
        if ( interactionstruct.script_noteworthy == script_noteworthy )
        {
            return interactionstruct;
        }
    }
    
    return undefined;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x249a
// Size: 0x7e
function function_27f9050017807d8a()
{
    level.escalation = spawnstruct();
    level.escalation.currentlevel = 1;
    level.escalation.functions = [];
    level.escalation.var_106a0c25c537a585 = "";
    function_d6da0dd209b341c9( &function_880a372a0fa8755d, 1 );
    function_d6da0dd209b341c9( &function_880a372a0fa8755d, 2 );
    function_d6da0dd209b341c9( &function_880a372a0fa8755d, 3 );
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x2520
// Size: 0x23
function function_9691dfef872dd7e4()
{
    return getdvarint( @"hash_2967fdd4515a6756", level.escalation.currentlevel );
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x254c
// Size: 0x2a
function function_880a372a0fa8755d()
{
    /#
        if ( getdvarint( @"hash_56a0e54026dd70df", 1 ) )
        {
            iprintln( "<dev string:xb2>" + function_9691dfef872dd7e4() );
        }
    #/
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x257e
// Size: 0x30
function function_d6da0dd209b341c9( function, ilevel )
{
    level.escalation.functions[ "escalation_" + ilevel ] = function;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x25b6
// Size: 0x93
function function_60291dfce2923372()
{
    level.escalation.currentlevel++;
    
    if ( level.escalation.currentlevel > 3 )
    {
        level.escalation.currentlevel = 3;
    }
    
    currentlevel = function_9691dfef872dd7e4();
    assert( currentlevel == 1 || currentlevel == 2 || currentlevel == 3 );
    thread [[ level.escalation.functions[ "escalation_" + currentlevel ] ]]();
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x2651
// Size: 0xe1
function function_7a888a38fce76e9( var_eb7b7d47d5339c45, objname )
{
    spawn_group = "";
    
    if ( isdefined( var_eb7b7d47d5339c45 ) && isstring( var_eb7b7d47d5339c45 ) )
    {
        spawn_group = var_eb7b7d47d5339c45 + "_" + function_9691dfef872dd7e4();
    }
    else
    {
        if ( getdvarint( @"hash_e410c11bcb9d47e6", 0 ) == function_9691dfef872dd7e4() )
        {
            return "";
        }
        
        if ( objname == "stealth_a" )
        {
            spawn_group = "spawner_obj_a_exterior_reinforcement_" + function_9691dfef872dd7e4();
        }
        else if ( objname == "stealth_b" )
        {
            spawn_group = "spawner_obj_b_exterior_reinforcement_" + function_9691dfef872dd7e4();
        }
        else if ( objname == "stealth_c" )
        {
            spawn_group = "spawner_obj_c_exterior_reinforcement_" + function_9691dfef872dd7e4();
        }
        else
        {
            spawn_group = "exfil_exterior_reinforcement_" + function_9691dfef872dd7e4();
        }
        
        assertex( spawn_group != "<dev string:xdb>", "<dev string:xdf>" + function_9691dfef872dd7e4() );
    }
    
    return spawn_group;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x273b
// Size: 0x1c1
function function_3645d8aee174afb3( spawngroup, objname )
{
    agents = [];
    var_aa2b4adf749ccbee = [];
    var_eb096a9d4e8a54d2 = function_7a888a38fce76e9( spawngroup, objname );
    
    if ( !isdefined( var_eb096a9d4e8a54d2 ) || var_eb096a9d4e8a54d2 == "" )
    {
        return;
    }
    
    spawnpointstructs = function_43ae814062c7741b( var_eb096a9d4e8a54d2 );
    
    foreach ( aispawnstruct in spawnpointstructs )
    {
        tempstruct = function_471352520e6468( aispawnstruct );
        var_aa2b4adf749ccbee[ var_aa2b4adf749ccbee.size ] = tempstruct;
    }
    
    foreach ( aispawnstruct in var_aa2b4adf749ccbee )
    {
        agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent( aispawnstruct.script_noteworthy, aispawnstruct.origin, aispawnstruct.angles, "high", "mission", "badSituation" );
        agent.group = aispawnstruct;
        agent.group.group_name = aispawnstruct.targetname;
        agent.spawnpoint = aispawnstruct;
        agent thread function_9648829771fb344( aispawnstruct );
        
        /#
            if ( getdvarint( @"hash_9bcca58e56e4c178", 1 ) )
            {
                scripts\mp\utility\outline::outlineenableforall( agent, "<dev string:x12e>", "<dev string:x148>" );
            }
        #/
        
        agent.spawnpoint = aispawnstruct;
        agents[ agents.size ] = agent;
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x2904
// Size: 0x24
function function_43ae814062c7741b( spawngroup )
{
    spawnerstructs = getstructarray( spawngroup, "targetname" );
    return spawnerstructs;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x2931
// Size: 0x126
function function_471352520e6468( struct )
{
    var_1eab94309f7b587e = undefined;
    aitype = struct.script_noteworthy;
    
    switch ( aitype )
    {
        case #"hash_23209741b93850b5":
            struct.script_noteworthy = "enemy_mp_dmz_base_shotgun";
            break;
        case #"hash_6191aaef9f922f96":
            struct.script_noteworthy = "enemy_mp_dmz_base_sniper";
            break;
        case #"hash_2f2d546c2247838f":
            struct.script_noteworthy = "enemy_mp_dmz_base_lmg";
            break;
        case #"hash_900cb96c552c5e8e":
            struct.script_noteworthy = "enemy_mp_dmz_base_smg";
            break;
        case #"hash_fa18d2f6bd57925a":
        case #"hash_ff739c8b59c1e5ea":
            struct.script_noteworthy = "enemy_mp_dmz_base_ar";
            break;
        case #"hash_4ad475e6e15635bd":
            struct.script_noteworthy = "enemy_mp_dmz_base_ar";
            break;
        default:
            struct.script_noteworthy = "enemy_mp_dmz_base_ar";
            break;
    }
    
    var_1eab94309f7b587e = struct;
    return var_1eab94309f7b587e;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x2a60
// Size: 0x13
function function_9648829771fb344( spawnerstruct )
{
    function_5add58433814dbc( spawnerstruct );
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x2a7b
// Size: 0x128
function function_5982d93ea6bd26cd()
{
    level.var_8332a0d90935d5e8 = [];
    level.var_8332a0d90935d5e8[ "stealth_a" ] = 0;
    level.var_8332a0d90935d5e8[ "stealth_b" ] = 0;
    level.var_8332a0d90935d5e8[ "stealth_c" ] = 0;
    level.var_8332a0d90935d5e8[ "exfil_area" ] = 0;
    level.var_a359cb3e2bfa1964 = [];
    level.var_9eeab63c54988c55 = [];
    level.var_359c318944444b78 = [];
    level.var_a359cb3e2bfa1964[ "stealth_a" ] = 0;
    level.var_9eeab63c54988c55[ "stealth_a" ] = 0;
    level.var_359c318944444b78[ "stealth_a" ] = 0;
    level.var_a359cb3e2bfa1964[ "stealth_b" ] = 0;
    level.var_9eeab63c54988c55[ "stealth_b" ] = 0;
    level.var_359c318944444b78[ "stealth_b" ] = 0;
    level.var_a359cb3e2bfa1964[ "stealth_c" ] = 0;
    level.var_9eeab63c54988c55[ "stealth_c" ] = 0;
    level.var_359c318944444b78[ "stealth_c" ] = 0;
    level.var_359c318944444b78[ "exfil_area" ] = 0;
    function_e26037e34403828d();
    level thread function_73a70e82f50954fa();
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x2bab
// Size: 0x55c
function function_e26037e34403828d()
{
    level.ambientgroups = [];
    function_94a20f1e012ae23b( "bs_exfil_stealth_1", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "bs_exfil_stealth_2", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "bs_exfil_stealth_3", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "exfil_exterior_reinforcement_1", &function_f2d1dfd7a8ce1ec3 );
    function_94a20f1e012ae23b( "exfil_exterior_reinforcement_2", &function_f2d1dfd7a8ce1ec3 );
    function_94a20f1e012ae23b( "exfil_exterior_reinforcement_3", &function_f2d1dfd7a8ce1ec3 );
    function_94a20f1e012ae23b( "exfil_exterior_reinforcement_vehicle_1", &function_2b1d55f8d82cef07 );
    function_94a20f1e012ae23b( "exfil_exterior_reinforcement_vehicle_2", &function_2b1d55f8d82cef07 );
    function_94a20f1e012ae23b( "exfil_exterior_reinforcement_vehicle_3", &function_2b1d55f8d82cef07 );
    function_94a20f1e012ae23b( "exfil_exterior_reinforcement_vehicle_4", &function_2b1d55f8d82cef07 );
    function_94a20f1e012ae23b( "exfil_exterior_reinforcement_vehicle_5", &function_2b1d55f8d82cef07 );
    function_94a20f1e012ae23b( "spawner_obj_b_interior_smg_1", &function_1b3e1d52186f7026 );
    function_94a20f1e012ae23b( "spawner_obj_b_interior_smg_2", &function_1b3e1d52186f7026 );
    function_94a20f1e012ae23b( "spawner_obj_b_interior_smg_3", &function_1b3e1d52186f7026 );
    function_94a20f1e012ae23b( "spawner_obj_b_interior_2_smg_1", &function_1b3e1d52186f7026 );
    function_94a20f1e012ae23b( "spawner_obj_b_interior_2_smg_2", &function_1b3e1d52186f7026 );
    function_94a20f1e012ae23b( "spawner_obj_b_interior_2_smg_3", &function_1b3e1d52186f7026 );
    function_94a20f1e012ae23b( "spawner_obj_b_exterior_1", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_b_exterior_2", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_b_exterior_3", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_b_exterior_roof_1", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_b_exterior_roof_2", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_b_exterior_roof_3", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_b_exterior_patrol_1", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_b_exterior_patrol_2", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_b_exterior_patrol_3", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_b_exterior_reinforcement_1", &function_f2d1dfd7a8ce1ec3 );
    function_94a20f1e012ae23b( "spawner_obj_b_exterior_reinforcement_2", &function_f2d1dfd7a8ce1ec3 );
    function_94a20f1e012ae23b( "spawner_obj_b_exterior_reinforcement_3", &function_f2d1dfd7a8ce1ec3 );
    function_94a20f1e012ae23b( "spawner_obj_b_ambush_1", &function_2d5b628e330541cb );
    function_94a20f1e012ae23b( "spawner_obj_b_ambush_2", &function_2d5b628e330541cb );
    function_94a20f1e012ae23b( "spawner_obj_b_ambush_3", &function_2d5b628e330541cb );
    function_94a20f1e012ae23b( "spawner_obj_b_ambush_smg_1", &function_2d5b628e330541cb );
    function_94a20f1e012ae23b( "spawner_obj_b_ambush_smg_2", &function_2d5b628e330541cb );
    function_94a20f1e012ae23b( "spawner_obj_b_ambush_smg_3", &function_2d5b628e330541cb );
    function_94a20f1e012ae23b( "techo_patroller_b", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "techo_patroller_a", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_a_interior_upstairs_1", &function_8855b1ba1fe3e2c );
    function_94a20f1e012ae23b( "spawner_obj_a_interior_upstairs_2", &function_8855b1ba1fe3e2c );
    function_94a20f1e012ae23b( "spawner_obj_a_interior_upstairs_3", &function_8855b1ba1fe3e2c );
    function_94a20f1e012ae23b( "spawner_obj_a_interior_upstairs_smg_1", &function_8855b1ba1fe3e2c );
    function_94a20f1e012ae23b( "spawner_obj_a_interior_upstairs_smg_2", &function_8855b1ba1fe3e2c );
    function_94a20f1e012ae23b( "spawner_obj_a_interior_upstairs_smg_3", &function_8855b1ba1fe3e2c );
    function_94a20f1e012ae23b( "spawner_obj_a_interior_smg_1", &function_1b3e1c52186f6df3 );
    function_94a20f1e012ae23b( "spawner_obj_a_interior_smg_2", &function_1b3e1c52186f6df3 );
    function_94a20f1e012ae23b( "spawner_obj_a_interior_smg_3", &function_1b3e1c52186f6df3 );
    function_94a20f1e012ae23b( "spawner_obj_a_exterior_1", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_a_exterior_2", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_a_exterior_3", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_a_exterior_patrol_1", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_a_exterior_patrol_2", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_a_exterior_patrol_3", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_a_exterior_patrol_roof_1", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_a_exterior_patrol_roof_2", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_a_exterior_patrol_roof_3", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_a_exterior_reinforcement_1", &function_f2d1dfd7a8ce1ec3 );
    function_94a20f1e012ae23b( "spawner_obj_a_exterior_reinforcement_2", &function_f2d1dfd7a8ce1ec3 );
    function_94a20f1e012ae23b( "spawner_obj_a_exterior_reinforcement_3", &function_f2d1dfd7a8ce1ec3 );
    function_94a20f1e012ae23b( "spawner_obj_a_upstairs_ambush_1", &function_8855b1ba1fe3e2c );
    function_94a20f1e012ae23b( "spawner_obj_a_upstairs_ambush_2", &function_8855b1ba1fe3e2c );
    function_94a20f1e012ae23b( "spawner_obj_a_upstairs_ambush_3", &function_8855b1ba1fe3e2c );
    function_94a20f1e012ae23b( "techo_patroller_c", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_c_exterior_1", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_c_exterior_2", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_c_exterior_3", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_c_exterior_patrol_1", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_c_exterior_patrol_2", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_c_exterior_patrol_3", &function_50418629d296c51d );
    function_94a20f1e012ae23b( "spawner_obj_c_interior_upstairs_1", &function_8855d1ba1fe4292 );
    function_94a20f1e012ae23b( "spawner_obj_c_interior_upstairs_2", &function_8855d1ba1fe4292 );
    function_94a20f1e012ae23b( "spawner_obj_c_interior_upstairs_3", &function_8855d1ba1fe4292 );
    function_94a20f1e012ae23b( "spawner_obj_c_interior_1", &function_8855d1ba1fe4292 );
    function_94a20f1e012ae23b( "spawner_obj_c_interior_2", &function_8855d1ba1fe4292 );
    function_94a20f1e012ae23b( "spawner_obj_c_interior_3", &function_8855d1ba1fe4292 );
    function_94a20f1e012ae23b( "spawner_obj_c_upstairs_ambush_1", &function_8855d1ba1fe4292 );
    function_94a20f1e012ae23b( "spawner_obj_c_upstairs_ambush_2", &function_8855d1ba1fe4292 );
    function_94a20f1e012ae23b( "spawner_obj_c_upstairs_ambush_3", &function_8855d1ba1fe4292 );
    function_94a20f1e012ae23b( "spawner_obj_c_exterior_reinforcement_1", &function_f2d1dfd7a8ce1ec3 );
    function_94a20f1e012ae23b( "spawner_obj_c_exterior_reinforcement_2", &function_f2d1dfd7a8ce1ec3 );
    function_94a20f1e012ae23b( "spawner_obj_c_exterior_reinforcement_3", &function_f2d1dfd7a8ce1ec3 );
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x310f
// Size: 0x51
function function_c5793c2004afcbcc( group_name, func )
{
    if ( getdvarint( @"hash_dcf5fcede3345fb8", 0 ) != 0 )
    {
        self.ignoreall = 1;
    }
    
    self.sightmaxdistance = 1000;
    self laseron();
    self.maxfacenewenemydist = 4000;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x3168
// Size: 0x36
function function_ffd832f03f6ebb80()
{
    players = function_4b0b660ecab607e6();
    
    for ( i = 0; i < players.size ; i++ )
    {
        self getenemyinfo( players[ i ] );
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x31a6
// Size: 0x97
function function_2b1d55f8d82cef07( group_name, func )
{
    if ( scripts\mp\agents\agent_utility::isspecifiedunittype( "dog" ) )
    {
        thread function_45a008ca8959297f();
    }
    
    function_c5793c2004afcbcc( group_name, func );
    thread function_53004420672f13fa();
    self.stealth.funcs[ "event_investigate" ] = &function_62615fdc150baa1a;
    self.stealth.funcs[ "event_cover_blown" ] = &function_62615fdc150baa1a;
    self.stealth.funcs[ "event_combat" ] = &function_62615fdc150baa1a;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x3245
// Size: 0x18a
function function_1b3e1d52186f7026( group_name, func )
{
    function_c5793c2004afcbcc( group_name, func );
    thread function_877ab7a7d5ed8172();
    self.stealth.funcs[ "event_investigate" ] = &function_bc28e12f0c1c8364;
    self.stealth.funcs[ "event_cover_blown" ] = &function_bc28e12f0c1c8364;
    self.stealth.funcs[ "event_combat" ] = &function_bc28e12f0c1c8364;
    
    if ( getstealthdetectstate() == "spotted" )
    {
        if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
        {
            return;
        }
        
        self [[ self.fnsetstealthstate ]]( "combat" );
        function_ffd832f03f6ebb80();
        self.goalradius = 300;
        self.dont_enter_combat = 1;
        self.script_combatmode = "ambush";
        self.combatmode = self.script_combatmode;
        scripts\common\ai::find_and_teleport_to_cover();
    }
    else
    {
        if ( function_dcf52ed792cd5571() )
        {
            if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
            {
                return;
            }
            
            self [[ self.fnsetstealthstate ]]( "hunt" );
        }
        
        self.goalradius = 300;
        self.dont_enter_combat = 1;
        self.script_combatmode = "ambush";
        self.combatmode = self.script_combatmode;
        scripts\common\ai::find_and_teleport_to_cover();
    }
    
    thread function_b558b6dbca1a6491();
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x33d7
// Size: 0x1cc
function function_877ab7a7d5ed8172()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "weapon_fired" );
        objname = getdvar( hashcat( @"hash_287b3b75f2c14fe9", level.script ), "stealth_container" );
        var_e61af03c9e384f0f = 0;
        var_e7758d1cef59fbf6 = 0;
        var_e4189f6142f280f1 = 0;
        var_5ead7cd5bd2a23c3 = getent( "stealth_a", "script_noteworthy" );
        var_46cf58102043e30 = getent( "stealth_b", "script_noteworthy" );
        var_867b6418dd3354e1 = getent( "stealth_c", "script_noteworthy" );
        
        if ( self istouching( var_5ead7cd5bd2a23c3 ) )
        {
            var_e61af03c9e384f0f = 1;
        }
        
        if ( self istouching( var_46cf58102043e30 ) )
        {
            var_e7758d1cef59fbf6 = 1;
        }
        
        if ( self istouching( var_867b6418dd3354e1 ) )
        {
            var_94a36a51659a7a2e = 1;
        }
        
        if ( !var_e61af03c9e384f0f && !var_e7758d1cef59fbf6 && !var_e4189f6142f280f1 )
        {
            closesttrigger = scripts\engine\utility::getclosest( self.origin, getentarray( "objective_trigger", "targetname" ) );
            
            if ( !isdefined( closesttrigger ) )
            {
                /#
                    iprintln( "<dev string:x14f>" );
                #/
                
                continue;
            }
            
            objname = closesttrigger.script_noteworthy;
        }
        else
        {
            if ( var_e61af03c9e384f0f )
            {
                objname = "stealth_a";
            }
            
            if ( var_e7758d1cef59fbf6 )
            {
                objname = "stealth_b";
            }
            
            if ( var_e4189f6142f280f1 )
            {
                objname = "stealth_c";
            }
        }
        
        if ( objname == "stealth_a" )
        {
            thread function_3d5706b7f6e25709( "downstairs", 0.1, "stealth_a" );
        }
        
        if ( objname == "stealth_b" )
        {
            thread function_3d5706b7f6e25709( "downstairs", 0.1, "stealth_b" );
        }
        
        if ( objname == "stealth_c" )
        {
            thread function_3d5706b7f6e25709( "downstairs", 0.1, "stealth_c" );
        }
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x35ab
// Size: 0x169, Type: bool
function function_dcf52ed792cd5571()
{
    var_cd5e9d1ecb0bcbd3 = "";
    players = function_4b0b660ecab607e6();
    
    foreach ( player in players )
    {
        var_cd5e9d1ecb0bcbd3 = function_3a45f1c5e142d0f3( player );
        
        switch ( var_cd5e9d1ecb0bcbd3 )
        {
            case #"hash_e7d0f11b30878b08":
                if ( level.var_a359cb3e2bfa1964[ var_cd5e9d1ecb0bcbd3 ] < 1 && level.var_9eeab63c54988c55[ var_cd5e9d1ecb0bcbd3 ] < 1 && level.var_359c318944444b78[ var_cd5e9d1ecb0bcbd3 ] < 1 )
                {
                    return false;
                }
                
                break;
            case #"hash_e7d0f41b30878fc1":
                if ( level.var_a359cb3e2bfa1964[ var_cd5e9d1ecb0bcbd3 ] < 1 && level.var_9eeab63c54988c55[ var_cd5e9d1ecb0bcbd3 ] < 1 && level.var_359c318944444b78[ var_cd5e9d1ecb0bcbd3 ] < 1 )
                {
                    return false;
                }
                
                break;
            case #"hash_e7d0f31b30878e2e":
                if ( level.var_a359cb3e2bfa1964[ var_cd5e9d1ecb0bcbd3 ] < 1 && level.var_9eeab63c54988c55[ var_cd5e9d1ecb0bcbd3 ] < 1 && level.var_359c318944444b78[ var_cd5e9d1ecb0bcbd3 ] < 1 )
                {
                    return false;
                }
                
                break;
            case #"hash_e0c6548ea2c82409":
                break;
            default:
                break;
        }
    }
    
    return true;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x371d
// Size: 0x1e6
function function_3a45f1c5e142d0f3( player )
{
    var_e61af03c9e384f0f = 0;
    var_e7758d1cef59fbf6 = 0;
    var_e4189f6142f280f1 = 0;
    var_2795910ea142bebd = 0;
    var_5ead7cd5bd2a23c3 = getent( "interior_ai_spawn_trigger_objA", "targetname" );
    var_46cf58102043e30 = getent( "interior_ai_spawn_trigger_objB", "targetname" );
    var_867b6418dd3354e1 = getent( "interior_ai_spawn_trigger_objC", "targetname" );
    exfiltrigger = getent( "exfil_area", "script_noteworthy" );
    
    if ( isdefined( player.recondronesuper ) )
    {
        if ( player.recondronesuper istouching( var_5ead7cd5bd2a23c3 ) )
        {
            var_e61af03c9e384f0f = 1;
        }
        
        if ( player.recondronesuper istouching( var_46cf58102043e30 ) )
        {
            var_e7758d1cef59fbf6 = 1;
        }
        
        if ( player.recondronesuper istouching( var_867b6418dd3354e1 ) )
        {
            var_e4189f6142f280f1 = 1;
        }
        
        if ( player.recondronesuper istouching( exfiltrigger ) )
        {
            var_2795910ea142bebd = 1;
        }
    }
    
    if ( isdefined( player.vehicle ) )
    {
        if ( player.vehicle istouching( var_5ead7cd5bd2a23c3 ) )
        {
            var_e61af03c9e384f0f = 1;
        }
        
        if ( player.vehicle istouching( var_46cf58102043e30 ) )
        {
            var_e7758d1cef59fbf6 = 1;
        }
        
        if ( player.vehicle istouching( var_867b6418dd3354e1 ) )
        {
            var_e4189f6142f280f1 = 1;
        }
        
        if ( player.vehicle istouching( exfiltrigger ) )
        {
            var_2795910ea142bebd = 1;
        }
    }
    
    if ( player istouching( var_5ead7cd5bd2a23c3 ) )
    {
        var_e61af03c9e384f0f = 1;
    }
    
    if ( player istouching( var_46cf58102043e30 ) )
    {
        var_e7758d1cef59fbf6 = 1;
    }
    
    if ( player istouching( var_867b6418dd3354e1 ) )
    {
        var_e4189f6142f280f1 = 1;
    }
    
    if ( player istouching( exfiltrigger ) )
    {
        var_2795910ea142bebd = 1;
    }
    
    if ( var_e61af03c9e384f0f )
    {
        return "stealth_a";
    }
    
    if ( var_e7758d1cef59fbf6 )
    {
        return "stealth_b";
    }
    
    if ( var_e4189f6142f280f1 )
    {
        return "stealth_c";
    }
    
    if ( var_2795910ea142bebd )
    {
        return "exfil_area";
    }
    
    return "";
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x390c
// Size: 0x102
function function_b558b6dbca1a6491()
{
    self endon( "death" );
    ignore_events = [ "footstep", "footstep_walk", "silenced_shot", "seek_backup", "window_open" ];
    
    while ( true )
    {
        self waittill( "ai_events", events );
        
        if ( !ent_flag( "stealth_enabled" ) )
        {
            continue;
        }
        
        if ( self.ignoreall || self isragdoll() )
        {
            continue;
        }
        
        foreach ( event in events )
        {
            if ( array_contains( ignore_events, event.type ) )
            {
                continue;
            }
            
            self.script_combatmode = "cover";
            self.combatmode = self.script_combatmode;
            return;
        }
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x3a16
// Size: 0x126
function function_8855d1ba1fe4292( group_name, func )
{
    function_c5793c2004afcbcc( group_name, func );
    thread function_948291bd95f7c96a( "stealth_c" );
    self.stealth.funcs[ "event_investigate" ] = &function_7ebc4ae7009f4c41;
    self.stealth.funcs[ "event_cover_blown" ] = &function_7ebc4ae7009f4c41;
    self.stealth.funcs[ "event_combat" ] = &function_7ebc4ae7009f4c41;
    self.goalradius = 64;
    self setgoalpos( self.origin );
    
    if ( getstealthdetectstate() == "spotted" )
    {
        if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
        {
            return;
        }
        
        self [[ self.fnsetstealthstate ]]( "combat" );
        function_ffd832f03f6ebb80();
        return;
    }
    
    if ( function_dcf52ed792cd5571() )
    {
        if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
        {
            return;
        }
        
        self [[ self.fnsetstealthstate ]]( "hunt" );
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x3b44
// Size: 0x109
function function_f2d1dfd7a8ce1ec3( group_name, func )
{
    function_c5793c2004afcbcc( group_name, func );
    
    if ( scripts\mp\agents\agent_utility::isspecifiedunittype( "juggernaut" ) )
    {
        self.ballowexecutions = 1;
        return;
    }
    
    function_52b755330ef9af41( group_name );
    
    if ( issubstr( self.group.group_name, "vehicle" ) )
    {
        thread function_53004420672f13fa();
        thread scripts\mp\movers::player_unresolved_collision_watch();
        self.stealth.funcs[ "event_investigate" ] = &function_62615fdc150baa1a;
        self.stealth.funcs[ "event_cover_blown" ] = &function_62615fdc150baa1a;
        self.stealth.funcs[ "event_combat" ] = &function_62615fdc150baa1a;
        self.maxfacenewenemydist = 4000;
    }
    
    if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
    {
        return;
    }
    
    self [[ self.fnsetstealthstate ]]( "hunt" );
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x3c55
// Size: 0x23f
function function_53004420672f13fa()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "weapon_fired" );
        objname = getdvar( hashcat( @"hash_287b3b75f2c14fe9", level.script ), "stealth_container" );
        var_e61af03c9e384f0f = 0;
        var_e7758d1cef59fbf6 = 0;
        var_e4189f6142f280f1 = 0;
        var_2795910ea142bebd = 0;
        var_5ead7cd5bd2a23c3 = getent( "stealth_a", "script_noteworthy" );
        var_46cf58102043e30 = getent( "stealth_b", "script_noteworthy" );
        var_867b6418dd3354e1 = getent( "stealth_c", "script_noteworthy" );
        exfiltrigger = getent( "exfil_area", "script_noteworthy" );
        
        if ( self istouching( var_5ead7cd5bd2a23c3 ) )
        {
            var_e61af03c9e384f0f = 1;
        }
        
        if ( self istouching( var_46cf58102043e30 ) )
        {
            var_e7758d1cef59fbf6 = 1;
        }
        
        if ( self istouching( var_867b6418dd3354e1 ) )
        {
            var_94a36a51659a7a2e = 1;
        }
        
        if ( self istouching( exfiltrigger ) )
        {
            var_2795910ea142bebd = 1;
        }
        
        if ( !var_e61af03c9e384f0f && !var_e7758d1cef59fbf6 && !var_e4189f6142f280f1 && !var_2795910ea142bebd )
        {
            closesttrigger = scripts\engine\utility::getclosest( self.origin, getentarray( "objective_trigger", "targetname" ) );
            
            if ( !isdefined( closesttrigger ) )
            {
                /#
                    iprintln( "<dev string:x14f>" );
                #/
                
                continue;
            }
            
            objname = closesttrigger.script_noteworthy;
        }
        else
        {
            if ( var_e61af03c9e384f0f )
            {
                objname = "stealth_a";
            }
            
            if ( var_e7758d1cef59fbf6 )
            {
                objname = "stealth_b";
            }
            
            if ( var_e4189f6142f280f1 )
            {
                objname = "stealth_c";
            }
            
            if ( var_2795910ea142bebd )
            {
                objname = "exfil_area";
            }
        }
        
        if ( objname == "stealth_a" )
        {
            thread function_3d5706b7f6e25709( "exterior", 0.05, "stealth_a" );
        }
        
        if ( objname == "stealth_b" )
        {
            thread function_3d5706b7f6e25709( "exterior", 0.05, "stealth_b" );
        }
        
        if ( objname == "stealth_c" )
        {
            thread function_3d5706b7f6e25709( "exterior", 0.05, "stealth_c" );
        }
        
        if ( objname == "exfil_area" )
        {
            thread function_3d5706b7f6e25709( "exterior", 0.05, "exfil_area" );
        }
        
        level.var_26678298a0072160 = 1;
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 3
// Checksum 0x0, Offset: 0x3e9c
// Size: 0x77
function function_3d5706b7f6e25709( region, delay, obj )
{
    wait delay;
    
    switch ( region )
    {
        case #"hash_1fd7e6acc4fe2e83":
            level.var_359c318944444b78[ obj ]++;
            break;
        case #"hash_a364d2439c68c25f":
            level.var_a359cb3e2bfa1964[ obj ]++;
            break;
        case #"hash_1fb89d518fb3736e":
            level.var_9eeab63c54988c55[ obj ]++;
            break;
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x3f1b
// Size: 0x106
function function_1b3e1c52186f6df3( group_name, func )
{
    function_c5793c2004afcbcc( group_name, func );
    thread function_877ab7a7d5ed8172();
    self.stealth.funcs[ "event_investigate" ] = &function_c9b04b362b0b8b88;
    self.stealth.funcs[ "event_cover_blown" ] = &function_c9b04b362b0b8b88;
    self.stealth.funcs[ "event_combat" ] = &function_c9b04b362b0b8b88;
    
    if ( getstealthdetectstate() == "spotted" )
    {
        if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
        {
            return;
        }
        
        self [[ self.fnsetstealthstate ]]( "combat" );
        function_ffd832f03f6ebb80();
        return;
    }
    
    if ( function_dcf52ed792cd5571() )
    {
        if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
        {
            return;
        }
        
        self [[ self.fnsetstealthstate ]]( "hunt" );
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x4029
// Size: 0x126
function function_8855b1ba1fe3e2c( group_name, func )
{
    function_c5793c2004afcbcc( group_name, func );
    thread function_948291bd95f7c96a( "stealth_a" );
    self.stealth.funcs[ "event_investigate" ] = &function_7ebc4ae7009f4c41;
    self.stealth.funcs[ "event_cover_blown" ] = &function_7ebc4ae7009f4c41;
    self.stealth.funcs[ "event_combat" ] = &function_7ebc4ae7009f4c41;
    self.goalradius = 16;
    self setgoalpos( self.origin );
    
    if ( getstealthdetectstate() == "spotted" )
    {
        if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
        {
            return;
        }
        
        self [[ self.fnsetstealthstate ]]( "combat" );
        function_ffd832f03f6ebb80();
        return;
    }
    
    if ( function_dcf52ed792cd5571() )
    {
        if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
        {
            return;
        }
        
        self [[ self.fnsetstealthstate ]]( "hunt" );
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x4157
// Size: 0x106
function function_2d5b628e330541cb( group_name, func )
{
    function_c5793c2004afcbcc( group_name, func );
    thread function_877ab7a7d5ed8172();
    self.stealth.funcs[ "event_investigate" ] = &function_bc28e12f0c1c8364;
    self.stealth.funcs[ "event_cover_blown" ] = &function_bc28e12f0c1c8364;
    self.stealth.funcs[ "event_combat" ] = &function_bc28e12f0c1c8364;
    
    if ( getstealthdetectstate() == "spotted" )
    {
        if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
        {
            return;
        }
        
        self [[ self.fnsetstealthstate ]]( "combat" );
        function_ffd832f03f6ebb80();
        return;
    }
    
    if ( function_dcf52ed792cd5571() )
    {
        if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
        {
            return;
        }
        
        self [[ self.fnsetstealthstate ]]( "hunt" );
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x4265
// Size: 0xa3
function function_50418629d296c51d( group_name, func )
{
    if ( scripts\mp\agents\agent_utility::isspecifiedunittype( "dog" ) )
    {
        thread function_45a008ca8959297f();
    }
    
    function_c5793c2004afcbcc( group_name, func );
    thread function_53004420672f13fa();
    self.stealth.funcs[ "event_investigate" ] = &function_62615fdc150baa1a;
    self.stealth.funcs[ "event_cover_blown" ] = &function_62615fdc150baa1a;
    self.stealth.funcs[ "event_combat" ] = &function_62615fdc150baa1a;
    self.maxfacenewenemydist = 4000;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x4310
// Size: 0x82
function function_45a008ca8959297f()
{
    self endon( "death" );
    
    while ( true )
    {
        message = waittill_any_return_3( "stealth_investigate", "stealth_combat", "stealth_idle" );
        
        switch ( message )
        {
            case #"hash_13251ba402e7508":
                break;
            case #"hash_a4157a2f0345f08d":
                self.soundent scripts\engine\utility::playsoundonentity( "anml_dog_growl", "dog_growl" );
                break;
            case #"hash_2c98371b75c681cf":
                break;
        }
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x439a
// Size: 0x201
function function_948291bd95f7c96a( obj_override )
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "weapon_fired" );
        objname = getdvar( hashcat( @"hash_287b3b75f2c14fe9", level.script ), "stealth_container" );
        var_e61af03c9e384f0f = 0;
        var_e7758d1cef59fbf6 = 0;
        var_e4189f6142f280f1 = 0;
        var_5ead7cd5bd2a23c3 = getent( "stealth_a", "script_noteworthy" );
        var_46cf58102043e30 = getent( "stealth_b", "script_noteworthy" );
        var_867b6418dd3354e1 = getent( "stealth_c", "script_noteworthy" );
        
        if ( self istouching( var_5ead7cd5bd2a23c3 ) )
        {
            var_e61af03c9e384f0f = 1;
        }
        
        if ( self istouching( var_46cf58102043e30 ) )
        {
            var_e7758d1cef59fbf6 = 1;
        }
        
        if ( self istouching( var_867b6418dd3354e1 ) )
        {
            var_94a36a51659a7a2e = 1;
        }
        
        if ( !var_e61af03c9e384f0f && !var_e7758d1cef59fbf6 && !var_e4189f6142f280f1 )
        {
            closesttrigger = scripts\engine\utility::getclosest( self.origin, getentarray( "objective_trigger", "targetname" ) );
            
            if ( !isdefined( closesttrigger ) )
            {
                /#
                    iprintln( "<dev string:x14f>" );
                #/
                
                continue;
            }
            
            objname = closesttrigger.script_noteworthy;
        }
        else
        {
            if ( var_e61af03c9e384f0f )
            {
                objname = "stealth_a";
            }
            
            if ( var_e7758d1cef59fbf6 )
            {
                objname = "stealth_b";
            }
            
            if ( var_e4189f6142f280f1 )
            {
                objname = "stealth_c";
            }
        }
        
        if ( isdefined( obj_override ) )
        {
            level thread function_3d5706b7f6e25709( "upstairs", 0.05, obj_override );
            continue;
        }
        
        if ( objname == "stealth_a" )
        {
            level thread function_3d5706b7f6e25709( "upstairs", 0.05, "stealth_a" );
        }
        
        if ( objname == "stealth_b" )
        {
            level thread function_3d5706b7f6e25709( "upstairs", 0.05, "stealth_b" );
        }
        
        if ( objname == "stealth_c" )
        {
            level thread function_3d5706b7f6e25709( "upstairs", 0.05, "stealth_c" );
        }
        
        level.var_d02cc581558b702b = 1;
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x45a3
// Size: 0x34f
function function_52b755330ef9af41( group )
{
    if ( scripts\mp\agents\agent_utility::isspecifiedunittype( "juggernaut" ) || scripts\mp\agents\agent_utility::isspecifiedunittype( "dog" ) )
    {
        if ( scripts\mp\agents\agent_utility::isspecifiedunittype( "dog" ) )
        {
            thread function_45a008ca8959297f();
        }
        
        return;
    }
    
    body = "body_mp_milsim_balkan_sf_1_1";
    head = "head_mp_milsim_balkan_sf_1_1";
    weapon = scripts\cp_mp\weapon::buildweapon( "iw8_sm_uzulu_mp", [ "thermal_west01", "none", "none", "none", "silencer_uzulu", "laserrange_smg" ], "none", "none" );
    grenade_type = "frag_grenade_mp";
    group_type = self.spawner.script_noteworthy;
    
    switch ( group_type )
    {
        case #"hash_23209741b93850b5":
            body = "body_mp_eastern_nikto_2_1";
            head = "head_mp_eastern_nikto_3_1";
            weapon = scripts\cp_mp\weapon::buildweapon( "iw8_sh_dpapa12_mp", [ "none", "none", "none", "muzzlemelee_dpapa12", "caldb_dpapa12", "none" ], "none", "none" );
            grenade_type = "molotov_mp";
            break;
        case #"hash_6191aaef9f922f96":
            body = "body_mp_eastern_azur_8_1";
            head = "head_mp_eastern_azur_8_1";
            weapon = scripts\cp_mp\weapon::buildweapon( "iw8_sn_alpha50_mp", [ "vzscope_alpha50", "laserbalancedsnpr", "pistolgrip02_alpha50", "xmags_alpha50", "barlong_alpha50" ], "none", "none" );
            grenade_type = "frag_grenade_mp";
            break;
        case #"hash_2f2d546c2247838f":
            body = "body_mp_eastern_velikan_1_1";
            head = "head_mp_eastern_velikan_1_1";
            weapon = scripts\cp_mp\weapon::buildweapon( "iw8_lm_mgolf36_mp", [ "thermal_west01", "none", "none", "none", "none", "none" ], "none", "none" );
            grenade_type = "semtex_mp";
            break;
        case #"hash_900cb96c552c5e8e":
            body = "body_mp_eastern_rodion_7_1";
            head = "head_mp_eastern_rodion_7_1";
            weapon = scripts\cp_mp\weapon::buildweapon( "iw8_sm_uzulu_mp", [ "thermal_west01", "none", "none", "none", "silencer_uzulu", "laserrange_smg" ], "none", "none" );
            grenade_type = "smoke_grenade_mp";
            break;
        case #"hash_fa18d2f6bd57925a":
        case #"hash_ff739c8b59c1e5ea":
            body = "body_mp_western_milsim_jw_grom_1_1";
            head = "head_mp_western_milsim_jw_grom_1_1";
            weapon = scripts\cp_mp\weapon::buildweapon( "iw8_ar_mike4_mp", [ "thermal_west01", "none", "none", "none", "silencer_west01", "laserbalanced_mike4" ], "none", "none" );
            grenade_type = "flash_mp";
            break;
        default:
            break;
    }
    
    body = "body_mp_eastern_velikan_1_1";
    head = "head_mp_eastern_velikan_1_1";
    function_8d7211588560dd1( body, head, weapon, grenade_type );
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 4
// Checksum 0x0, Offset: 0x48fa
// Size: 0x17b
function function_8d7211588560dd1( body, head, weapon, grenade_type )
{
    self setmodel( body );
    
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel );
    }
    
    self attach( head, "", 1 );
    self.headmodel = head;
    self.allowpain = 0;
    self.equip_armor = 1;
    self.armorhealth = 840;
    self.goalradius = 2048;
    
    /#
        if ( getdvarint( @"hash_8de63a2e6037a1f9", 420 ) != 420 )
        {
            self.armorhealth = getdvarint( @"hash_8de63a2e6037a1f9" );
        }
    #/
    
    if ( isdefined( self.weapon ) )
    {
        self takeweapon( self.weapon );
    }
    
    self.weapon = weapon;
    utility::initweapon( self.weapon );
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    self.grenadeweapon = makeweapon( grenade_type );
    self.grenadeammo = 2;
    self.script_forcegrenade = 1;
    self.accuracy = 0.4;
    thread function_31ce456a217691d0();
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x4a7d
// Size: 0x46
function function_31ce456a217691d0()
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        objweapon = self getcurrentweapon();
        
        if ( isdefined( objweapon ) )
        {
            function_6c8eca00ebac031c( objweapon );
        }
        
        self waittill( "weapon_change" );
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x4acb
// Size: 0x12
function function_6c8eca00ebac031c( objweapon )
{
    scripts\mp\weapons::updatelauncherusage();
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 3
// Checksum 0x0, Offset: 0x4ae5
// Size: 0x1ac
function function_94a20f1e012ae23b( group_name, func, teamname )
{
    if ( !isdefined( level.ambientgroups[ group_name ] ) )
    {
        level.ambientgroups[ group_name ] = spawnstruct();
    }
    
    if ( isdefined( level.ambientgroups[ group_name ] ) )
    {
        if ( isarray( level.ambientgroups[ group_name ] ) )
        {
            for ( i = 0; i < level.ambientgroups[ group_name ].size ; i++ )
            {
                if ( !isdefined( level.ambientgroups[ group_name ][ i ].var_51ab71b549b8e798 ) )
                {
                    level.ambientgroups[ group_name ][ i ].var_51ab71b549b8e798 = [];
                }
                
                if ( !isdefined( level.ambientgroups[ group_name ][ i ].team ) )
                {
                    level.ambientgroups[ group_name ][ i ].team = teamname;
                }
                
                level.ambientgroups[ group_name ][ i ].var_51ab71b549b8e798[ level.ambientgroups[ group_name ][ i ].var_51ab71b549b8e798.size ] = func;
            }
            
            return;
        }
        
        if ( !isdefined( level.ambientgroups[ group_name ].var_51ab71b549b8e798 ) )
        {
            level.ambientgroups[ group_name ].var_51ab71b549b8e798 = [];
        }
        
        if ( !isdefined( level.ambientgroups[ group_name ].team ) )
        {
            level.ambientgroups[ group_name ].team = teamname;
        }
        
        level.ambientgroups[ group_name ].var_51ab71b549b8e798[ level.ambientgroups[ group_name ].var_51ab71b549b8e798.size ] = func;
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x4c99
// Size: 0x1e, Type: bool
function function_dc3e57164f1a2eb9( group_name )
{
    if ( isdefined( level.ambientgroups[ group_name ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x4cc0
// Size: 0xd8
function function_5add58433814dbc( spawnerstruct )
{
    if ( function_dc3e57164f1a2eb9( spawnerstruct.targetname ) )
    {
        for ( i = 0; i < level.ambientgroups[ spawnerstruct.targetname ].var_51ab71b549b8e798.size ; i++ )
        {
            thread function_420e3f1db78aac7( level.ambientgroups[ spawnerstruct.targetname ], level.ambientgroups[ spawnerstruct.targetname ].var_51ab71b549b8e798[ i ], undefined, self );
        }
    }
    
    if ( isdefined( spawnerstruct.var_51ab71b549b8e798 ) )
    {
        for ( i = 0; i < spawnerstruct.var_51ab71b549b8e798.size ; i++ )
        {
            thread function_420e3f1db78aac7( spawnerstruct, spawnerstruct.var_51ab71b549b8e798[ i ], undefined, self );
        }
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 4
// Checksum 0x0, Offset: 0x4da0
// Size: 0x121
function function_420e3f1db78aac7( group, var, is_param, keep_self )
{
    level endon( "game_ended" );
    group endon( "death" );
    self endon( "var_param_race_timeout" );
    
    if ( !isdefined( var ) )
    {
        return "empty";
    }
    
    return_var = var;
    
    if ( isstring( var ) )
    {
        return var;
    }
    else if ( function_33b2f6bd50628c64( var ) )
    {
        return var;
    }
    else if ( isarray( var ) )
    {
        if ( isarray( var[ 0 ] ) )
        {
            for ( i = 0; i < var.size ; i++ )
            {
                return_var = function_420e3f1db78aac7( group, var[ i ], is_param );
            }
        }
        else if ( isfunction( var[ 0 ] ) )
        {
            func = var[ 0 ];
            var_params = [];
            param_struct = function_91fa2f936230f998( group, var );
            return_var = group function_31b0f98a06da6b4f( func, param_struct, keep_self );
        }
        else
        {
            return_var = var;
        }
    }
    else if ( isfunction( var ) )
    {
        if ( istrue( is_param ) )
        {
            return var;
        }
        else
        {
            return_var = [[ var ]]( group );
        }
    }
    
    return return_var;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x4eca
// Size: 0x29
function function_33b2f6bd50628c64( param1 )
{
    if ( isdefined( param1 ) && isnumber( param1 ) && param1 > 0 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 2
// Checksum 0x0, Offset: 0x4efb
// Size: 0xad
function function_91fa2f936230f998( group, var )
{
    var_params = [];
    
    if ( var.size < 2 )
    {
        return var_params;
    }
    else
    {
        param_struct = spawnstruct();
        param_struct.var_params = [];
        var_bae8297148c7f7e8 = min( var.size, 9 );
        
        for ( i = 1; i < var_bae8297148c7f7e8 ; i++ )
        {
            var_param = var[ i ];
            param_struct thread function_df50d8fcd21e9646( "var_param_race_timeout" );
            param_struct.var_params[ i - 1 ] = param_struct function_420e3f1db78aac7( group, var_param, 1 );
        }
    }
    
    return param_struct;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x4fb1
// Size: 0x17
function function_df50d8fcd21e9646( var_7239f8830ef22b43 )
{
    self endon( "death" );
    waittillframeend();
    self notify( var_7239f8830ef22b43 );
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 3
// Checksum 0x0, Offset: 0x4fd0
// Size: 0x3ed
function function_31b0f98a06da6b4f( func, params, keep_self )
{
    if ( isdefined( keep_self ) )
    {
        var_84dae085357e37ad = keep_self;
    }
    else
    {
        var_84dae085357e37ad = self;
    }
    
    if ( !isdefined( params.var_params ) )
    {
        return var_84dae085357e37ad [[ func ]]( self );
    }
    
    if ( params.var_params.size == 1 )
    {
        return var_84dae085357e37ad [[ func ]]( self, function_86fdcc8c2d170e42( params.var_params[ 0 ] ) );
    }
    
    if ( params.var_params.size == 2 )
    {
        return var_84dae085357e37ad [[ func ]]( self, function_86fdcc8c2d170e42( params.var_params[ 0 ] ), function_86fdcc8c2d170e42( params.var_params[ 1 ] ) );
    }
    
    if ( params.var_params.size == 3 )
    {
        return var_84dae085357e37ad [[ func ]]( self, function_86fdcc8c2d170e42( params.var_params[ 0 ] ), function_86fdcc8c2d170e42( params.var_params[ 1 ] ), function_86fdcc8c2d170e42( params.var_params[ 2 ] ) );
    }
    
    if ( params.var_params.size == 4 )
    {
        return var_84dae085357e37ad [[ func ]]( self, function_86fdcc8c2d170e42( params.var_params[ 0 ] ), function_86fdcc8c2d170e42( params.var_params[ 1 ] ), function_86fdcc8c2d170e42( params.var_params[ 2 ] ), function_86fdcc8c2d170e42( params.var_params[ 3 ] ) );
    }
    
    if ( params.var_params.size == 5 )
    {
        return var_84dae085357e37ad [[ func ]]( self, function_86fdcc8c2d170e42( params.var_params[ 0 ] ), function_86fdcc8c2d170e42( params.var_params[ 1 ] ), function_86fdcc8c2d170e42( params.var_params[ 2 ] ), function_86fdcc8c2d170e42( params.var_params[ 3 ] ), function_86fdcc8c2d170e42( params.var_params[ 4 ] ) );
    }
    
    if ( params.var_params.size == 6 )
    {
        return var_84dae085357e37ad [[ func ]]( self, function_86fdcc8c2d170e42( params.var_params[ 0 ] ), function_86fdcc8c2d170e42( params.var_params[ 1 ] ), function_86fdcc8c2d170e42( params.var_params[ 2 ] ), function_86fdcc8c2d170e42( params.var_params[ 3 ] ), function_86fdcc8c2d170e42( params.var_params[ 4 ] ), function_86fdcc8c2d170e42( params.var_params[ 5 ] ) );
    }
    
    if ( params.var_params.size == 7 )
    {
        return var_84dae085357e37ad [[ func ]]( self, function_86fdcc8c2d170e42( params.var_params[ 0 ] ), function_86fdcc8c2d170e42( params.var_params[ 1 ] ), function_86fdcc8c2d170e42( params.var_params[ 2 ] ), function_86fdcc8c2d170e42( params.var_params[ 3 ] ), function_86fdcc8c2d170e42( params.var_params[ 4 ] ), function_86fdcc8c2d170e42( params.var_params[ 5 ] ), function_86fdcc8c2d170e42( params.var_params[ 6 ] ) );
    }
    
    if ( params.var_params.size == 8 )
    {
        return var_84dae085357e37ad [[ func ]]( self, function_86fdcc8c2d170e42( params.var_params[ 0 ] ), function_86fdcc8c2d170e42( params.var_params[ 1 ] ), function_86fdcc8c2d170e42( params.var_params[ 2 ] ), function_86fdcc8c2d170e42( params.var_params[ 3 ] ), function_86fdcc8c2d170e42( params.var_params[ 4 ] ), function_86fdcc8c2d170e42( params.var_params[ 5 ] ), function_86fdcc8c2d170e42( params.var_params[ 6 ] ), function_86fdcc8c2d170e42( params.var_params[ 7 ] ) );
    }
    
    return undefined;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x53c5
// Size: 0x30
function function_86fdcc8c2d170e42( var )
{
    if ( isdefined( var ) )
    {
        if ( isstring( var ) && var == "empty" )
        {
            return undefined;
        }
        else
        {
            return var;
        }
        
        return;
    }
    
    return undefined;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x53fd
// Size: 0x68
function function_73a70e82f50954fa()
{
    var_8fb1722d1b30262 = getentarray( "objective_trigger", "targetname" );
    
    foreach ( trigger in var_8fb1722d1b30262 )
    {
        trigger thread _dmztask_watchfortriggerentered();
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x546d
// Size: 0xd8
function _dmztask_watchfortriggerentered()
{
    self notify( "_dmzTask_watchForTriggerEntered" );
    self endon( "_dmzTask_watchForTriggerEntered" );
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "trigger", entity );
        
        if ( !isplayer( entity ) )
        {
            if ( isdefined( entity.owner ) )
            {
                if ( !isplayer( entity.owner ) )
                {
                    continue;
                }
            }
            else
            {
                continue;
            }
        }
        
        objective = self.script_noteworthy;
        
        switch ( objective )
        {
            case #"hash_e7d0f11b30878b08":
                thread function_1537c5052a90679c();
                break;
            case #"hash_e7d0f41b30878fc1":
                thread function_23191a0b3361e1b1();
                break;
            case #"hash_e7d0f31b30878e2e":
                thread function_fd6c72301c76f7a2();
                break;
            case #"hash_e0c6548ea2c82409":
                break;
        }
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x554d
// Size: 0x60
function function_1537c5052a90679c()
{
    if ( istrue( level.var_c60247daec61ed67 ) )
    {
        return;
    }
    
    level.var_c60247daec61ed67 = 1;
    function_3645d8aee174afb3( "spawner_obj_a_exterior", "stealth_container" );
    function_3645d8aee174afb3( "spawner_obj_a_exterior_patrol", "stealth_container" );
    function_3645d8aee174afb3( "spawner_obj_a_exterior_patrol_roof", "stealth_container" );
    level thread function_e4d159155f43a954();
    level thread function_4548d071950d3c0f();
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x55b5
// Size: 0x11e
function function_e4d159155f43a954()
{
    level endon( "obj_a_interior_spawned" );
    var_780678e81fe0812b = getent( "interior_ai_spawn_trigger_objA", "targetname" );
    
    while ( true )
    {
        var_780678e81fe0812b waittill( "trigger", entity );
        
        if ( !isplayer( entity ) )
        {
            if ( isdefined( entity.owner ) )
            {
                if ( !isplayer( entity.owner ) )
                {
                    continue;
                }
            }
            else
            {
                continue;
            }
        }
        
        objname = "stealth_a";
        
        if ( istrue( level.var_8332a0d90935d5e8[ objname ] ) )
        {
            return;
        }
        
        if ( getdvarint( @"hash_aa53922f2189291a", 0 ) != 0 )
        {
            function_3645d8aee174afb3( "spawner_obj_a_interior_shotgun", "stealth_container" );
            function_3645d8aee174afb3( "spawner_obj_a_interior_upstairs_shotgun", "stealth_container" );
        }
        else
        {
            function_3645d8aee174afb3( "spawner_obj_a_interior_smg", "stealth_container" );
            function_3645d8aee174afb3( "spawner_obj_a_interior_upstairs_smg", "stealth_container" );
        }
        
        function_3645d8aee174afb3( "spawner_obj_a_upstairs_ambush", "stealth_container" );
        level.var_8332a0d90935d5e8[ objname ] = 1;
        level notify( "kill_upstairs_thread" );
        level notify( "obj_a_interior_spawned" );
        break;
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x56db
// Size: 0x68
function function_4548d071950d3c0f()
{
    var_d6bd3e7e1abc7488 = getentarray( "interior_ai_spawn_trigger_upstairs_objA", "targetname" );
    
    foreach ( trigger in var_d6bd3e7e1abc7488 )
    {
        trigger thread function_c657c349af2fe650();
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x574b
// Size: 0x105
function function_c657c349af2fe650()
{
    level endon( "kill_upstairs_thread" );
    
    while ( true )
    {
        self waittill( "trigger", entity );
        
        if ( !isplayer( entity ) )
        {
            if ( isdefined( entity.owner ) )
            {
                if ( !isplayer( entity.owner ) )
                {
                    continue;
                }
            }
            else
            {
                continue;
            }
        }
        
        objname = "stealth_a";
        
        if ( istrue( level.var_8332a0d90935d5e8[ objname ] ) )
        {
            return;
        }
        
        if ( getdvarint( @"hash_aa53922f2189291a", 0 ) != 0 )
        {
            function_3645d8aee174afb3( "spawner_obj_a_interior_shotgun", "stealth_container" );
            function_3645d8aee174afb3( "spawner_obj_a_interior_upstairs_shotgun", "stealth_container" );
        }
        else
        {
            function_3645d8aee174afb3( "spawner_obj_a_interior_smg", "stealth_container" );
            function_3645d8aee174afb3( "spawner_obj_a_interior_upstairs_smg", "stealth_container" );
        }
        
        function_3645d8aee174afb3( "spawner_obj_a_upstairs_ambush", "stealth_container" );
        level.var_8332a0d90935d5e8[ objname ] = 1;
        level notify( "obj_a_interior_spawned" );
        level notify( "kill_upstairs_thread" );
        break;
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x5858
// Size: 0x57
function function_23191a0b3361e1b1()
{
    if ( istrue( level.var_b681a67c472f3e22 ) )
    {
        return;
    }
    
    level.var_b681a67c472f3e22 = 1;
    function_3645d8aee174afb3( "spawner_obj_b_exterior", "stealth_container" );
    function_3645d8aee174afb3( "spawner_obj_b_exterior_patrol", "stealth_container" );
    function_3645d8aee174afb3( "spawner_obj_b_exterior_roof", "stealth_container" );
    level thread function_c657c649af2fece9();
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x58b7
// Size: 0x11e
function function_c657c649af2fece9()
{
    level notify( "kill_objb_spawner_thread" );
    level endon( "kill_objb_spawner_thread" );
    var_780678e81fe0812b = getent( "interior_ai_spawn_trigger_objB", "targetname" );
    
    while ( true )
    {
        var_780678e81fe0812b waittill( "trigger", entity );
        
        if ( !isplayer( entity ) )
        {
            if ( isdefined( entity.owner ) )
            {
                if ( !isplayer( entity.owner ) )
                {
                    continue;
                }
            }
            else
            {
                continue;
            }
        }
        
        objname = "stealth_b";
        
        if ( istrue( level.var_8332a0d90935d5e8[ objname ] ) )
        {
            return;
        }
        
        if ( getdvarint( @"hash_aa53922f2189291a", 0 ) != 0 )
        {
            function_3645d8aee174afb3( "spawner_obj_b_interior_shotgun", "stealth_container" );
            function_3645d8aee174afb3( "spawner_obj_b_ambush_shotgun", "stealth_container" );
        }
        else
        {
            function_3645d8aee174afb3( "spawner_obj_b_interior_smg", "stealth_container" );
            function_3645d8aee174afb3( "spawner_obj_b_interior_2_smg", "stealth_container" );
            function_3645d8aee174afb3( "spawner_obj_b_ambush_smg", "stealth_container" );
        }
        
        level.var_8332a0d90935d5e8[ objname ] = 1;
        level notify( "kill_objb_spawner_thread" );
        break;
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x59dd
// Size: 0x5a
function function_fd6c72301c76f7a2()
{
    if ( istrue( level.var_c58764b80fed93a9 ) )
    {
        return;
    }
    
    level.var_c58764b80fed93a9 = 1;
    
    if ( getdvarint( @"hash_99bb5c2c4f003e2b", 0 ) == 0 )
    {
        function_3645d8aee174afb3( "spawner_obj_c_exterior", "stealth_container" );
        function_3645d8aee174afb3( "spawner_obj_c_exterior_patrol", "stealth_container" );
    }
    
    level thread function_e4d15b155f43adba();
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x5a3f
// Size: 0x68
function function_e4d15b155f43adba()
{
    var_d6bd3e7e1abc7488 = getentarray( "interior_ai_spawn_trigger_objC", "targetname" );
    
    foreach ( trigger in var_d6bd3e7e1abc7488 )
    {
        trigger thread function_c657c549af2feab6();
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 0
// Checksum 0x0, Offset: 0x5aaf
// Size: 0xc4
function function_c657c549af2feab6()
{
    level endon( "kill_objC_spawner_thread" );
    
    while ( true )
    {
        self waittill( "trigger", entity );
        
        if ( !isplayer( entity ) )
        {
            if ( isdefined( entity.owner ) )
            {
                if ( !isplayer( entity.owner ) )
                {
                    continue;
                }
            }
            else
            {
                continue;
            }
        }
        
        objname = "stealth_c";
        
        if ( istrue( level.var_8332a0d90935d5e8[ objname ] ) )
        {
            return;
        }
        
        function_3645d8aee174afb3( "spawner_obj_c_interior", "stealth_container" );
        function_3645d8aee174afb3( "spawner_obj_c_interior_upstairs", "stealth_container" );
        function_3645d8aee174afb3( "spawner_obj_c_upstairs_ambush", "stealth_container" );
        level.var_8332a0d90935d5e8[ objname ] = 1;
        level notify( "kill_objC_spawner_thread" );
        break;
    }
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x5b7b
// Size: 0x2e, Type: bool
function function_32d6fa230ba2316f( ent )
{
    return abs( ent.origin[ 2 ] - self.origin[ 2 ] ) > 120;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x5bb2
// Size: 0x47, Type: bool
function function_62615fdc150baa1a( event )
{
    if ( event.type == "combat" )
    {
        self laseron();
        self.goalradius = 1024;
        self setgoalpos( event.origin );
        return false;
    }
    
    return false;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x5c02
// Size: 0xb7, Type: bool
function function_bc28e12f0c1c8364( event )
{
    ignore_events = [ "silenced_shot", "silenced_shot_impact", "death" ];
    
    if ( array_contains( ignore_events, event.typeorig ) )
    {
        if ( isdefined( event.origin ) )
        {
            if ( !self hastacvis( event.origin, 1 ) )
            {
                return true;
            }
        }
        
        if ( function_32d6fa230ba2316f( event ) )
        {
            return true;
        }
    }
    
    self laseron();
    
    if ( getdvarint( @"hash_a025b8f10a93a908", 0 ) == 0 )
    {
        self.goalradius = 64;
        self setgoalpos( self.origin );
    }
    
    return false;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x5cc2
// Size: 0xb7, Type: bool
function function_7ebc4ae7009f4c41( event )
{
    ignore_events = [ "silenced_shot", "silenced_shot_impact", "death" ];
    
    if ( array_contains( ignore_events, event.typeorig ) )
    {
        if ( isdefined( event.origin ) )
        {
            if ( !self hastacvis( event.origin, 1 ) )
            {
                return true;
            }
        }
        
        if ( function_32d6fa230ba2316f( event ) )
        {
            return true;
        }
    }
    
    self laseron();
    
    if ( getdvarint( @"hash_a025b8f10a93a908", 0 ) == 0 )
    {
        self.goalradius = 64;
        self setgoalpos( self.origin );
    }
    
    return false;
}

// Namespace namespace_1595ce89357b7e39 / namespace_ba49697a3e0ffe00
// Params 1
// Checksum 0x0, Offset: 0x5d82
// Size: 0xcb, Type: bool
function function_c9b04b362b0b8b88( event )
{
    ignore_events = [ "silenced_shot", "silenced_shot_impact", "death" ];
    
    if ( array_contains( ignore_events, event.typeorig ) )
    {
        if ( isdefined( event.origin ) )
        {
            if ( !self hastacvis( event.origin, 1 ) )
            {
                return true;
            }
        }
        
        if ( function_32d6fa230ba2316f( event ) )
        {
            return true;
        }
    }
    
    if ( event.typeorig == "ally_killed" )
    {
    }
    
    self laseron();
    
    if ( getdvarint( @"hash_a025b8f10a93a908", 0 ) != 0 )
    {
        self.goalradius = 64;
        self setgoalpos( self.origin );
    }
    
    return false;
}

