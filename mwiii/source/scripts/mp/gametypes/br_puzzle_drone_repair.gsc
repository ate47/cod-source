#using script_2d9d24f7c63ac143;
#using scripts\common\devgui;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\structspawnconfig;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\objidpoolmanager;

#namespace drone_repair;

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x3d5
// Size: 0x109
function autoexec init()
{
    var_38603dae3d76e1d5 = getdvarint( @"hash_ec05c1bc29a209fc", 0 ) == 1;
    
    if ( !var_38603dae3d76e1d5 )
    {
        return;
    }
    
    level.var_6c42f1942be0314 = [ "brloot_drone_part_a_jup", "brloot_drone_part_b_jup", "brloot_drone_part_c_jup", "brloot_drone_part_d_jup", "brloot_drone_part_e_jup" ];
    
    /#
        iprintln( "<dev string:x1c>" );
        init_debug();
    #/
    
    level.var_9d7ea50921b67d31 = getdvarint( @"hash_2f0f26d4707f8853", 0 ) == 1;
    level.var_654f718e0c7ead7c = getdvarint( @"hash_501cfc58fbef89a2", 0 ) == 1;
    registersharedfunc( "br_puzzle_drone_repair", "setDronePartFound", &setdronepartfound );
    registersharedfunc( "br_puzzle_drone_repair", "onDronePartDropped", &ondronepartdropped );
    registersharedfunc( "br_puzzle_drone_repair", "devSetupBrokenDrone", &devsetupbrokendrone );
    thread function_28d7437a275a45c7();
    thread setupbrokendrone();
    thread init_dialog();
    thread watchplayerconnect();
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 0
// Checksum 0x0, Offset: 0x4e6
// Size: 0x4d
function function_28d7437a275a45c7()
{
    level endon( "game_ended" );
    
    while ( !isdefined( level.ssc ) )
    {
        waitframe();
    }
    
    scripts\cp_mp\structspawnconfig::function_4f7660cfd85cd517( "drone_parts", &function_e6c1c35181a2870f );
    scripts\cp_mp\structspawnconfig::function_412f527ef0863f0e( "drone_parts", &function_b4b48707a625a324 );
    scripts\cp_mp\structspawnconfig::function_eded5b87f8f7bdfd( "drone_parts", &function_ec3e14f05c136a35 );
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 0
// Checksum 0x0, Offset: 0x53b
// Size: 0x24
function init_dialog()
{
    while ( !isdefined( game[ "dialog" ] ) )
    {
        waitframe();
    }
    
    game[ "dialog" ][ "drone_part_repaired" ] = "eaeg_eean_eefo";
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 1
// Checksum 0x0, Offset: 0x567
// Size: 0xe9
function function_2beebfae871aed04( player )
{
    for ( i = 0; i < level.var_6c42f1942be0314.size ; i++ )
    {
        partfound = player getplayerdata( level.progressiongroup, "dronePartsFound", i );
        player setclientomnvar( level.var_6c42f1942be0314[ i ], partfound );
    }
    
    if ( function_cba9562cfa638fe8( player ) )
    {
        if ( getdvarint( @"hash_c8bcd09200a0d6f2", 1 ) )
        {
            if ( level.var_654f718e0c7ead7c && !player getplayerdata( level.progressiongroup, "droneLaunched" ) )
            {
                if ( isdefined( level.var_780fff00a6a68686 ) )
                {
                    level.var_780fff00a6a68686 enableplayeruse( player );
                    return;
                }
                
                thread function_a7a80e8ba88920c8( player );
                return;
            }
            
            function_3c73da53109dcc01( player );
            return;
        }
        
        player setclientomnvar( level.var_6c42f1942be0314[ 0 ], 2 );
    }
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 0
// Checksum 0x0, Offset: 0x658
// Size: 0x2d
function watchplayerconnect()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "connected", player );
        function_2beebfae871aed04( player );
    }
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x68d
// Size: 0x31
function private function_a7a80e8ba88920c8( player )
{
    level endon( "game_ended" );
    player endon( "disconnect" );
    level waittill( "PuzzleDroneSetup" );
    level.var_780fff00a6a68686 enableplayeruse( player );
}

/#

    // Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
    // Params 0
    // Checksum 0x0, Offset: 0x6c6
    // Size: 0x7e, Type: dev
    function init_debug()
    {
        function_6e7290c8ee4f558b( "<dev string:x3c>" );
        add_devgui_command( "<dev string:x5b>", "<dev string:x6b>" );
        add_devgui_command( "<dev string:xa7>", "<dev string:xb7>" );
        add_devgui_command( "<dev string:xf3>", "<dev string:x103>" );
        add_devgui_command( "<dev string:x13f>", "<dev string:x14f>" );
        add_devgui_command( "<dev string:x18b>", "<dev string:x19b>" );
        add_devgui_command( "<dev string:x1d7>", "<dev string:x1ec>" );
        function_fe953f000498048f();
    }

#/

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 1
// Checksum 0x0, Offset: 0x74c
// Size: 0x9d
function function_a20133b287aa61da( item )
{
    objid = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
    
    if ( objid != -1 )
    {
        item setscriptablepartstate( "debug_icon", "disabled" );
        scripts\mp\objidpoolmanager::objective_add_objective( objid, "current", item.origin, "jup_ui_map_icon_generic_marker" );
        scripts\mp\objidpoolmanager::update_objective_setbackground( objid, 1 );
        scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9( objid, 1 );
        scripts\mp\objidpoolmanager::update_objective_setzoffset( objid, 75 );
        scripts\mp\objidpoolmanager::function_98ba077848896a3( objid, 1 );
        item.scriptedobjid = objid;
        return;
    }
    
    item setscriptablepartstate( "debug_icon", "visible" );
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 1
// Checksum 0x0, Offset: 0x7f1
// Size: 0x24
function function_e6c1c35181a2870f( structname )
{
    allspawnlocations = getstructarray( structname, "targetname" );
    return allspawnlocations;
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 2
// Checksum 0x0, Offset: 0x81e
// Size: 0x41
function function_b4b48707a625a324( structname, posstruct )
{
    if ( !isdefined( level.var_13ed53cdcd563f93 ) )
    {
        level.var_13ed53cdcd563f93 = [];
    }
    
    level.var_13ed53cdcd563f93[ level.var_13ed53cdcd563f93.size ] = posstruct;
    return posstruct;
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 2
// Checksum 0x0, Offset: 0x868
// Size: 0xf8
function function_4e6039b32b329a2d( posstruct, partnameindex )
{
    if ( !isdefined( level.var_6c42f1942be0314 ) )
    {
        assertmsg( "<dev string:x216>" );
        return;
    }
    
    if ( !isdefined( partnameindex ) || partnameindex >= level.var_6c42f1942be0314.size || partnameindex < 0 )
    {
        assertmsg( "<dev string:x239>" );
        return;
    }
    
    posstruct.scriptableid = level.var_6c42f1942be0314[ partnameindex ];
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( dropstruct, posstruct.origin + ( 0, 0, 10 ), posstruct.angles );
    item = scripts\mp\gametypes\br_pickups::spawnpickup( posstruct.scriptableid, dropinfo );
    item.criticalitem = 1;
    
    if ( level.var_9d7ea50921b67d31 )
    {
        function_a20133b287aa61da( item );
    }
    
    return item;
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 1
// Checksum 0x0, Offset: 0x969
// Size: 0x6f
function function_ec3e14f05c136a35( structname )
{
    level endon( "game_ended" );
    level waittill( "prematch_done" );
    waitframe();
    
    if ( !isdefined( level.var_13ed53cdcd563f93 ) || level.var_13ed53cdcd563f93.size == 0 )
    {
        return;
    }
    
    for ( i = 0; i < level.var_13ed53cdcd563f93.size ; i++ )
    {
        function_4e6039b32b329a2d( level.var_13ed53cdcd563f93[ i ], i );
    }
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 2
// Checksum 0x0, Offset: 0x9e0
// Size: 0x122
function setdronepartfound( pickup, player )
{
    scriptablename = pickup.scriptablename;
    
    if ( !isdefined( player.droneparts ) )
    {
        player.droneparts = [];
    }
    
    player.droneparts = array_add( player.droneparts, scriptablename );
    
    if ( !function_db0ed0033a34d360( player ) )
    {
        function_17827e7b10d50ae4( player, level.var_5c5b88ce7ae1228e );
    }
    else
    {
        function_cdebd3f4fa5a45b3( player, level.var_5c5b88ce7ae1228e );
    }
    
    if ( level.var_9d7ea50921b67d31 )
    {
        if ( isdefined( pickup.instance.scriptedobjid ) )
        {
            objective_delete( pickup.instance.scriptedobjid );
            scripts\mp\objidpoolmanager::returnobjectiveid( pickup.instance.scriptedobjid );
            pickup.instance.scriptedobjid = undefined;
            return;
        }
        
        pickup.instance setscriptablepartstate( "debug_icon", "disabled" );
    }
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 2
// Checksum 0x0, Offset: 0xb0a
// Size: 0x52
function ondronepartdropped( scriptablename, player )
{
    player.droneparts = array_remove( player.droneparts, scriptablename );
    
    if ( player.droneparts.size == 0 )
    {
        level.var_5c5b88ce7ae1228e disableplayeruse( player );
    }
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 2
// Checksum 0x0, Offset: 0xb64
// Size: 0x44
function devsetupbrokendrone( origin, angles )
{
    var_5c5b88ce7ae1228e = spawnscriptable( "brloot_drone_part_all_jup", origin, angles );
    var_5c5b88ce7ae1228e setscriptablepartstate( "brloot_drone_part_all_jup", "visible" );
    function_f1d36faeb630ecea( var_5c5b88ce7ae1228e );
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 0
// Checksum 0x0, Offset: 0xbb0
// Size: 0xe2
function setupbrokendrone()
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    dronestruct = getstruct( "drone_broken", "targetname" );
    
    if ( !isdefined( dronestruct ) )
    {
        assertmsg( "<dev string:x260>" );
        return;
    }
    
    level waittill( "prematch_done" );
    waitframe();
    var_5c5b88ce7ae1228e = spawnscriptable( "brloot_drone_part_all_jup", dronestruct.origin );
    var_5c5b88ce7ae1228e setscriptablepartstate( "brloot_drone_part_all_jup", "visible" );
    function_f1d36faeb630ecea( var_5c5b88ce7ae1228e );
    
    if ( level.var_654f718e0c7ead7c )
    {
        level.var_780fff00a6a68686 = function_3d94d1b826172df3();
    }
    
    if ( level.var_9d7ea50921b67d31 )
    {
        function_a20133b287aa61da( var_5c5b88ce7ae1228e );
    }
    
    if ( isdefined( var_5c5b88ce7ae1228e.scriptedobjid ) )
    {
        scripts\mp\objidpoolmanager::function_846c2acd91309cd8( var_5c5b88ce7ae1228e.scriptedobjid, 255, 60, 60 );
    }
    
    level notify( "PuzzleDroneSetup" );
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 1
// Checksum 0x0, Offset: 0xc9a
// Size: 0x7b
function function_f1d36faeb630ecea( var_5c5b88ce7ae1228e )
{
    foreach ( player in level.players )
    {
        function_17827e7b10d50ae4( player, var_5c5b88ce7ae1228e );
    }
    
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "brloot_drone_part_all_jup", &function_10a0469fe6e9e108 );
    level.var_5c5b88ce7ae1228e = var_5c5b88ce7ae1228e;
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 6
// Checksum 0x0, Offset: 0xd1d
// Size: 0x1d4
function function_10a0469fe6e9e108( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( player.droneparts ) )
    {
        assertmsg( "<dev string:x281>" );
        return;
    }
    
    partindexes = [];
    
    foreach ( part in player.droneparts )
    {
        if ( !function_6ad995b1a14a7e86( player, part ) )
        {
            lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7( part );
            player namespace_aead94004cf4c147::function_6f39f9916649ac48( lootid, 1 );
            partindexes = array_add( partindexes, function_75636dddd4fde65( part ) );
        }
    }
    
    foreach ( index in partindexes )
    {
        player setclientomnvar( level.var_6c42f1942be0314[ index ], 1 );
        player setplayerdata( level.progressiongroup, "dronePartsFound", index, 1 );
        player.droneparts = function_57091b2d67654a14( player.droneparts, level.var_6c42f1942be0314[ index ] );
    }
    
    function_17827e7b10d50ae4( player, instance );
    
    if ( function_cba9562cfa638fe8( player ) )
    {
        if ( level.var_654f718e0c7ead7c )
        {
            level.var_780fff00a6a68686 enableplayeruse( player );
        }
        else
        {
            launchdrone( player );
        }
        
        return;
    }
    
    level thread scripts\mp\gametypes\br_public::brleaderdialogplayer( "drone_part_repaired", player, 1, undefined, 0, undefined, "dx_br_jpbm_" );
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xef9
// Size: 0xc0
function private launchdrone( player )
{
    streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "radar_drone_recon", player );
    streakinfo.mpstreaksysteminfo = scripts\mp\killstreaks\killstreaks::createstreakitemstruct( streakinfo.streakname );
    player scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreaktriggered( streakinfo );
    player scripts\mp\killstreaks\killstreaks::streakglobals_onkillstreakbeginuse( streakinfo );
    function_9a8d68db097f6be8( player, level.var_5c5b88ce7ae1228e.origin, level.var_5c5b88ce7ae1228e.angles, "radar_drone_recon", streakinfo );
    player setclientomnvar( level.var_6c42f1942be0314[ 0 ], 2 );
    player setplayerdata( level.progressiongroup, "droneLaunched", 1 );
    scripts\cp_mp\challenges::function_8359cadd253f9604( player, "BR_EASTEREGG_DRONEASSEMBLE", 1 );
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 5
// Checksum 0x0, Offset: 0xfc1
// Size: 0xe7
function function_9a8d68db097f6be8( player, startpos, startang, helperdronetype, streakinfo )
{
    repaireddrone = player scripts\cp_mp\killstreaks\helper_drone::createhelperdrone( startpos, startang, helperdronetype, streakinfo, 0, 1 );
    repaireddrone thread scripts\cp_mp\killstreaks\helper_drone::helperdrone_overwatchplayer();
    thread function_3c03c4c1859f38e1( player, repaireddrone );
    thread watchplayerdeath( player, repaireddrone );
    
    if ( level.var_9d7ea50921b67d31 )
    {
        if ( isdefined( level.var_5c5b88ce7ae1228e.scriptedobjid ) )
        {
            objective_delete( level.var_5c5b88ce7ae1228e.scriptedobjid );
            scripts\mp\objidpoolmanager::returnobjectiveid( level.var_5c5b88ce7ae1228e.scriptedobjid );
            level.var_5c5b88ce7ae1228e.scriptedobjid = undefined;
            return;
        }
        
        level.var_5c5b88ce7ae1228e setscriptablepartstate( "debug_icon", "disabled" );
    }
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 2
// Checksum 0x0, Offset: 0x10b0
// Size: 0xff
function function_3c03c4c1859f38e1( player, var_5c5b88ce7ae1228e )
{
    var_5c5b88ce7ae1228e endon( "death" );
    var_5c5b88ce7ae1228e endon( "explode" );
    var_5c5b88ce7ae1228e endon( "owner_gone" );
    player endon( "disconnect" );
    player endon( "death" );
    uavtype = "uav";
    duration = 48;
    streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo( uavtype, player );
    streakinfo.skipequippedstreakcheck = 1;
    uavradius = 5000;
    var_ec00e2b85c91da0c = 3;
    var_6c3716013ea4f716 = 6;
    team = player.pers[ "team" ];
    function_78033a976b978c7( player, team, streakinfo );
    timepassed = 0;
    
    while ( true )
    {
        if ( !isdefined( team ) )
        {
            break;
        }
        
        triggerportableradarpingteam( var_5c5b88ce7ae1228e.origin, team, uavradius, var_ec00e2b85c91da0c * 1000 );
        wait var_6c3716013ea4f716;
        timepassed += var_6c3716013ea4f716;
    }
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 2
// Checksum 0x0, Offset: 0x11b7
// Size: 0x49
function watchplayerdeath( player, var_5c5b88ce7ae1228e )
{
    var_5c5b88ce7ae1228e endon( "death" );
    var_5c5b88ce7ae1228e endon( "explode" );
    var_5c5b88ce7ae1228e endon( "owner_gone" );
    player waittill_2( "death", "disconnect" );
    var_5c5b88ce7ae1228e thread scripts\cp_mp\killstreaks\helper_drone::function_6edfda4764129e3( 0, 1, 0, 1 );
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 3
// Checksum 0x0, Offset: 0x1208
// Size: 0x5e
function function_78033a976b978c7( player, team, streakinfo )
{
    vostreakname = streakinfo.streakname;
    var_52a5be2e2f91d710 = undefined;
    player thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog( vostreakname, vostreakname + "_use", 1, var_52a5be2e2f91d710 );
    scripts\cp_mp\utility\killstreak_utility::killstreak_dangernotifyplayersinrange( player, team, 5000, vostreakname );
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x126e
// Size: 0x20
function private function_17827e7b10d50ae4( player, var_5c5b88ce7ae1228e )
{
    var_5c5b88ce7ae1228e disablescriptablepartplayeruse( "brloot_drone_part_all_jup", player );
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1296
// Size: 0x20
function private function_cdebd3f4fa5a45b3( player, var_5c5b88ce7ae1228e )
{
    var_5c5b88ce7ae1228e enablescriptablepartplayeruse( "brloot_drone_part_all_jup", player );
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x12be
// Size: 0x1b
function private function_75636dddd4fde65( scriptablename )
{
    return array_find( level.var_6c42f1942be0314, scriptablename );
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x12e2
// Size: 0x30, Type: bool
function private function_6ad995b1a14a7e86( player, scriptablename )
{
    omnvarvalue = player getclientomnvar( scriptablename );
    
    if ( omnvarvalue > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x131b
// Size: 0x68, Type: bool
function private function_db0ed0033a34d360( player )
{
    foreach ( part in player.droneparts )
    {
        if ( !function_6ad995b1a14a7e86( player, part ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x138c
// Size: 0x66, Type: bool
function private function_cba9562cfa638fe8( player )
{
    foreach ( partname in level.var_6c42f1942be0314 )
    {
        if ( !function_6ad995b1a14a7e86( player, partname ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x13fb
// Size: 0x6d
function private function_3c73da53109dcc01( player )
{
    for ( i = 0; i < level.var_6c42f1942be0314.size ; i++ )
    {
        player setclientomnvar( level.var_6c42f1942be0314[ i ], 0 );
        player setplayerdata( level.progressiongroup, "dronePartsFound", i, 0 );
    }
    
    player setplayerdata( level.progressiongroup, "droneLaunched", 0 );
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1470
// Size: 0x6d
function private function_3d94d1b826172df3()
{
    useobj = spawn( "script_origin", level.var_5c5b88ce7ae1228e.origin );
    useobj makeusable();
    useobj sethintstring( &"MP/BR_DRONE_PART_ALL_USE" );
    useobj setcursorhint( "HINT_NOICON" );
    useobj sethintrequiresholding( 1 );
    useobj setuseholdduration( 150 );
    useobj disableplayeruseforallplayers();
    thread waitfortrigger( useobj );
    return useobj;
}

// Namespace drone_repair / scripts\mp\gametypes\br_puzzle_drone_repair
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x14e6
// Size: 0x3f
function private waitfortrigger( ent )
{
    level endon( "game_ended" );
    
    while ( true )
    {
        ent waittill( "trigger", player );
        ent disableplayeruse( player );
        player launchdrone( player );
    }
}

