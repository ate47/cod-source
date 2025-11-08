#using script_3583ff375ab3a91e;
#using script_5bc60484d17fa95c;
#using script_5cda031797dce489;
#using scripts\common\utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\class;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;

#namespace br_ai_gulag;

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0xc01
// Size: 0x349
function function_4a0935954bbfdeb1()
{
    level.var_37e52c7fb7267efc = spawnstruct();
    level.var_37e52c7fb7267efc.var_2e88fff6c419ee6a = 1;
    level.var_37e52c7fb7267efc.var_7d4922396daa0192 = getdvarint( @"hash_674e53f15c9ff53d", 1 );
    level.var_37e52c7fb7267efc.var_37afb6f23303b55a = getdvarint( @"hash_7e7947ccb6191852", 1 );
    level.var_37e52c7fb7267efc.var_5cd8016b769d02aa = getdvarint( @"hash_bc73689cd8209e75", 1 );
    level.var_37e52c7fb7267efc.var_4b133d9c5b92891d = getdvarint( @"hash_a3f1cff5c396d63d", 12 );
    level.var_37e52c7fb7267efc.overtimeenabled = getdvarint( @"hash_5b3585afd70eaf8e", 0 );
    level.var_37e52c7fb7267efc.var_2713a9cf5318d984 = getdvarint( @"hash_a206a25a0ce81dda", 1 );
    level.var_37e52c7fb7267efc.var_5b74e1e54f3f3b74 = getdvarint( @"hash_f14d2f2480b4b618", 0 );
    level.var_37e52c7fb7267efc.var_54c7916bcea2b113 = getdvarint( @"hash_8993dd89b4d00b97", 0 );
    level.var_37e52c7fb7267efc.var_3564a4453eafcacb = getdvarint( @"hash_d824b632ccb82353", 0 );
    level.var_37e52c7fb7267efc.var_f98aec28092ae4f2 = getdvarfloat( @"hash_546a3f7597c568a", 9 );
    level.var_37e52c7fb7267efc.var_f04a0fb05108f52e = getdvarint( @"hash_eaccaf202728ce0c", 0 );
    level.var_37e52c7fb7267efc.var_ddcc046e7b061885 = getdvarint( @"hash_8d62b3080c53b03f", 0 );
    level.var_37e52c7fb7267efc.var_609a4f76dce95688 = getdvarint( @"hash_bfbfcd12d33dce15", 1 );
    level.var_37e52c7fb7267efc.var_be0bbfd2065c69b3 = getdvarint( @"hash_19476c64d4742882", 0 );
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853( "gulagGetMatchDuration", &function_92cfa932b04a6719 );
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853( "gulagIsMatchPending", &function_d1b3eed24bb52b44 );
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853( "gulagGetClosedCircleIndex", &function_ebafdb7112db8628 );
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853( "gulagGetCountdownLength", &function_441f914ba636643b );
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853( "gulagIsOneTeamLeft", &function_94aa98226f7a425c );
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853( "gulagGetVictoryWait", &function_eb1596a5daea0ef5 );
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853( "gulagGetPostVictoryWait", &function_d556bd222194d447 );
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853( "gulagHandleLossInfiniteEarly", &function_bd71f506af2cac70 );
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853( "gulagGiveAIKillRewards", &function_f561af47db779c79 );
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853( "gulagWinSequence", &function_2b0fd45ef612b4a5 );
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853( "gulagLoseSequence", &function_9dbb71aaae4e335e );
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853( "gulag_startWaitingStartTime", &function_fd55f9d5ef55b95e );
    namespace_eb17b46cdcb98eea::function_c9fa720726fab853( "gulag_initPlayerArena", &function_9d53e328c2d1aec4 );
    namespace_eb17b46cdcb98eea::function_8debf0c616bf9480( "gulagOvertime" );
    level function_93add0b65db9f722( &function_a7a1d8d937762614 );
    level thread function_9d02912cfe66605a();
    
    if ( !isdefined( level.supportsai ) )
    {
        thread scripts\mp\ai_mp_controller::init();
    }
    
    if ( namespace_ad49798629176e96::function_7ad9fcb1ac4f3db8() )
    {
        level thread function_669d65fcd2ac3d84();
    }
    
    level thread function_25a296c2ed85e35f();
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0xf52
// Size: 0x6e7
function function_9d02912cfe66605a()
{
    level waittill( "prematch_done" );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "second_chance_cargo", &function_f63baad2f7765f34 );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "second_chance_cable", &function_875f67700e4d2769 );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "second_chance_camera", &function_6c9ae1f39f71f7e1 );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "second_chance_bag", &function_e40faa26da957604 );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "second_chance_vent", &function_b0f86be8e080101 );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "second_chance_door", &function_3bc6f653f16663aa );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "second_chance_door_win", &function_b7e4cbd2a1618bdc );
    
    if ( istrue( level.var_37e52c7fb7267efc.overtimeenabled ) )
    {
        scripts\engine\scriptable::scriptable_addusedcallbackbypart( "second_chance_drive", &function_ed3b3a2040c051a6 );
    }
    
    foreach ( arena in level.gulag.arenas )
    {
        arenatargets = getentarray( arena.target, "targetname" );
        
        foreach ( arenatarget in arenatargets )
        {
            if ( !isdefined( arenatarget.script_noteworthy ) )
            {
                continue;
            }
            
            if ( arenatarget.script_noteworthy == "gulag_ai_goal_door" )
            {
                arena.goal_doors = arenatarget;
                
                if ( !istrue( level.var_37e52c7fb7267efc.overtimeenabled ) )
                {
                    arena.goal_doors delete();
                    continue;
                }
            }
            
            if ( arenatarget.script_noteworthy == "gulag_ai_goal_volume" )
            {
                if ( !istrue( level.var_37e52c7fb7267efc.var_609a4f76dce95688 ) )
                {
                    arena.goal_volume = arenatarget;
                }
            }
            
            if ( arenatarget.script_noteworthy == "gulag_ai_camera_door" )
            {
                arena.cameradoor = arenatarget;
                arena.cameradoor delete();
            }
        }
        
        arena.ai_structs = [];
        arena.legendary_loot_structs = [];
        arena.loot_structs = [];
        arena.var_267f3a45751996c2 = [];
        arena.var_60792b044c2d2cb = [];
        arena.var_4d916bb4bda1f18 = [];
        
        if ( istrue( level.var_43307855f189eb31.var_732a414f682801cc ) )
        {
            arena.lootpickedup = [];
        }
        
        arenastructs = getstructarray( arena.target, "targetname" );
        
        foreach ( arenastruct in arenastructs )
        {
            if ( arenastruct.script_noteworthy == "guard_stationary_smg" || isstartstr( arenastruct.script_noteworthy, "gulag_ai_enemy" ) )
            {
                arena.ai_structs[ arena.ai_structs.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "mhc_legendary_loot_structs " || arenastruct.script_noteworthy == "gulag_ai_legendary_loot_structs" )
            {
                arena.legendary_loot_structs[ arena.legendary_loot_structs.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "mhc_loot_structs" || arenastruct.script_noteworthy == "gulag_ai_loot_structs" )
            {
                arena.loot_structs[ arena.loot_structs.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_cabin_door" )
            {
                arena.var_60792b044c2d2cb[ arena.var_60792b044c2d2cb.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_camera" )
            {
                arena.var_267f3a45751996c2[ arena.var_267f3a45751996c2.size ] = arenastruct;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_cable" )
            {
                arena.cable = spawnscriptable( "second_chance_cable", arenastruct.origin + ( 0, 0, level.var_37e52c7fb7267efc.var_3564a4453eafcacb ), ( 0, 180, 0 ) );
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_cameras" )
            {
                arena.camera = spawnscriptable( "second_chance_camera", arenastruct.origin );
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_cargo" )
            {
                if ( level.var_37e52c7fb7267efc.var_ddcc046e7b061885 < 0 )
                {
                    arena.cargo = spawnscriptable( "second_chance_cargo", arenastruct.origin + ( 0, 0, level.var_37e52c7fb7267efc.var_3564a4453eafcacb ) );
                }
                else
                {
                    arena.cargo = arenastruct thread function_6341d4f1620c75fd();
                }
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_usb" && istrue( level.var_37e52c7fb7267efc.overtimeenabled ) )
            {
                arena.var_1dfb62f15b7d51cf = spawnscriptable( "second_chance_drive", arenastruct.origin );
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_ot_flag" )
            {
                arena.var_1df1acee38dcca72 = arenastruct.origin;
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_vent" )
            {
                arena.vent = spawnscriptable( "second_chance_vent", arenastruct.origin + ( 0, 0, -10 ) );
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_vent_bag" )
            {
                arena.bag = spawnscriptable( "second_chance_bag", arenastruct.origin + ( 0, 0, level.var_37e52c7fb7267efc.var_3564a4453eafcacb ) );
            }
            
            if ( arenastruct.script_noteworthy == "gulag_ai_escape_doors" )
            {
                if ( istrue( level.var_37e52c7fb7267efc.var_609a4f76dce95688 ) )
                {
                    var_68a6e69ddb34008a = spawnscriptable( "second_chance_door_win", arenastruct.origin, arenastruct.angles );
                    arena.var_4d916bb4bda1f18[ arena.var_4d916bb4bda1f18.size ] = var_68a6e69ddb34008a;
                }
            }
        }
        
        function_cb74a3e70ddfe7ac( arena );
        
        if ( istrue( level.var_37e52c7fb7267efc.var_37afb6f23303b55a ) )
        {
            arena.objid = function_3e4c7d5b30f40ed9( arena );
        }
        
        level thread function_591aa4c281221460( arena );
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x1641
// Size: 0x15
function function_92cfa932b04a6719()
{
    return getdvarfloat( @"hash_8be34599dfa102b8", 50 );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 2
// Checksum 0x0, Offset: 0x165f
// Size: 0x84
function function_d1b3eed24bb52b44( nextmatch, arena )
{
    if ( nextmatch.size < 2 )
    {
        if ( function_d58396c1483bfbdb() )
        {
            foreach ( p in nextmatch )
            {
                if ( !isdefined( p.var_d95581fdfc29ec7a ) )
                {
                    return 1;
                }
                
                return 0;
            }
            
            return;
        }
        
        return 0;
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x16eb
// Size: 0x35
function function_ebafdb7112db8628( offset )
{
    return level.br_level.br_circledelaytimes.size - 1 - getdvarint( @"scr_br_fc_circle_disable", 4 ) - offset;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x1729
// Size: 0x12
function function_441f914ba636643b()
{
    return getdvarint( @"hash_fb05c5f6825931d", 3 );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x1744
// Size: 0xd
function function_94aa98226f7a425c()
{
    if ( function_6a7fe34afaa1a01d() )
    {
        return 0;
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x1759
// Size: 0x7
function function_eb1596a5daea0ef5()
{
    return 4.5;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x1769
// Size: 0x7
function function_d556bd222194d447()
{
    return 2;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x1779
// Size: 0x61
function function_f6681bde87af34c8( arena )
{
    if ( istrue( level.var_37e52c7fb7267efc.var_5b74e1e54f3f3b74 ) )
    {
        if ( level.var_37e52c7fb7267efc.var_54c7916bcea2b113 == 1 )
        {
            arena function_7e3b92cd362571d0();
        }
        
        arena thread function_7cfce31d9c561b2d( arena.arenaplayers );
    }
    
    level thread function_591aa4c281221460( arena );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x17e2
// Size: 0x412
function function_8116af5afa37b9bf( arena )
{
    level endon( "game_ended" );
    
    if ( !istrue( level.var_37e52c7fb7267efc.var_609a4f76dce95688 ) )
    {
        level thread function_7525a0ed21932d7( arena );
    }
    
    if ( isdefined( arena.goal_doors ) )
    {
        level thread function_39c797f7e7c6ca87( arena.goal_doors );
    }
    
    aithreatbiasgroup = "gulagai" + arena.gulagindex;
    var_1ce1b071385a88f0 = "gulagplayers" + arena.gulagindex;
    
    if ( !threatbiasgroupexists( var_1ce1b071385a88f0 ) )
    {
        createthreatbiasgroup( var_1ce1b071385a88f0 );
    }
    
    if ( !threatbiasgroupexists( aithreatbiasgroup ) )
    {
        createthreatbiasgroup( aithreatbiasgroup );
        setthreatbiasagainstall( aithreatbiasgroup, -100000 );
        setthreatbias( aithreatbiasgroup, var_1ce1b071385a88f0, 2000 );
    }
    
    foreach ( ai in arena.var_707537a8904aa962 )
    {
        if ( isagent( ai ) )
        {
            ai setthreatbiasgroup( aithreatbiasgroup );
        }
    }
    
    arena.var_4eb3ce9801991000 = undefined;
    
    foreach ( player in arena.arenaplayers )
    {
        player.var_b807b84e723c5cea = undefined;
        player.var_d95581fdfc29ec7a = undefined;
        player.gulagbag = undefined;
        player.gulagkills = undefined;
        player.var_3a7c9a3e9aa20358 = undefined;
        player.var_d25277121d9d0a6c = undefined;
        player.var_322535086c0890fa = undefined;
        player.var_938604a8b5dd849 = undefined;
        player.var_e1ed3a7677ef1776 = undefined;
        
        if ( isdefined( player.var_97ac1ea78faea6e3 ) )
        {
            player.var_97ac1ea78faea6e3 = undefined;
            arena.spawnbag = 1;
        }
        
        if ( !istrue( level.var_37e52c7fb7267efc.var_5b74e1e54f3f3b74 ) )
        {
            player thread scripts\mp\hud_message::showsplash( "br_ai_gulag_start" );
        }
        
        if ( istrue( level.var_37e52c7fb7267efc.var_37afb6f23303b55a ) && isdefined( arena.objid ) )
        {
            objective_addclienttomask( arena.objid, player );
            objective_showtoplayersinmask( arena.objid );
        }
        
        player namespace_ad49798629176e96::function_63776b389e7c92c1();
        player namespace_ad49798629176e96::function_1167994a7ce49346();
        player function_10aa5ac1861ffb67( 0 );
        player setthreatbiasgroup( var_1ce1b071385a88f0 );
        player thread gulag_trackplayerbullets();
    }
    
    if ( isdefined( arena.baggulag ) )
    {
        arena.baggulag freescriptable();
        arena.baggulag = undefined;
    }
    
    if ( isdefined( arena.lootpickedup ) && arena.lootpickedup.size > 0 )
    {
        foreach ( loot in arena.lootpickedup )
        {
            if ( !isdefined( loot ) )
            {
                continue;
            }
            
            loot setscriptablepartstate( loot.type, "visible" );
        }
        
        arena.lootpickedup = [];
    }
    
    if ( istrue( arena.spawnbag ) )
    {
        function_f431c7f719a5a19( arena );
        arena.spawnbag = undefined;
    }
    
    arena.var_f69974791bb59e4b = undefined;
    
    if ( istrue( level.var_37e52c7fb7267efc.overtimeenabled ) )
    {
        function_51a5c2cbddb8569a( arena );
    }
    
    if ( isdefined( arena.var_707537a8904aa962 ) )
    {
        arena.var_28a470799d66ecd7 = arena.var_707537a8904aa962.size;
    }
    
    if ( isdefined( arena.arenaplayers ) )
    {
        arena.var_b6b01621833467d1 = arena.arenaplayers.size;
    }
    
    arena notify( "ai_gulag_matchStarted" );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x1bfc
// Size: 0x83
function gulag_trackplayerbullets()
{
    player = self;
    level endon( "game_ended" );
    player endon( "disconnect" );
    player notify( "gulag_trackPlayerBullets" );
    player endon( "gulag_trackPlayerBullets" );
    player endon( "can_show_splashes" );
    
    while ( true )
    {
        player waittill( "weapon_fired", objweapon );
        
        if ( !isdefined( player.var_322535086c0890fa ) )
        {
            player.var_322535086c0890fa = 0;
        }
        
        player.var_322535086c0890fa += 1;
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x1c87
// Size: 0x80
function function_669d65fcd2ac3d84()
{
    level endon( "game_ended" );
    level waittill( "prematch_done" );
    wait 10;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() )
        {
            continue;
        }
        
        player kill();
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x1d0f
// Size: 0x48
function function_51a5c2cbddb8569a( arena )
{
    if ( isdefined( arena.var_937fd276db7d6dcf ) )
    {
        arena.var_937fd276db7d6dcf delete();
    }
    
    function_cdb25f748b945cfa( arena.var_1dfb62f15b7d51cf.origin, arena );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x1d5f
// Size: 0x104
function function_6341d4f1620c75fd()
{
    arenastruct = self;
    level endon( "game_ended" );
    time = 0;
    
    if ( isdefined( level.br_level ) && isdefined( level.br_level.br_circlecenters ) )
    {
        var_4ebf4fdb24b6df5c = function_764cf6b0bca0fe0a();
        
        for ( circleindex = 0; circleindex < var_4ebf4fdb24b6df5c ; circleindex++ )
        {
            timedelay = level.br_level.br_circledelaytimes[ circleindex ];
            timeclose = level.br_level.br_circleclosetimes[ circleindex ];
            time = time + timedelay + timeclose;
        }
    }
    
    waittime = int( time );
    wait waittime;
    
    if ( !isdefined( arenastruct ) )
    {
        return;
    }
    
    var_f97856743fbd4b44 = spawnscriptable( "second_chance_cargo", arenastruct.origin + ( 0, 0, level.var_37e52c7fb7267efc.var_3564a4453eafcacb ) );
    return var_f97856743fbd4b44;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x1e6c
// Size: 0xa2
function function_764cf6b0bca0fe0a()
{
    if ( !isdefined( level.br_level ) || !isdefined( level.br_level.br_circledelaytimes ) || !isdefined( level.var_37e52c7fb7267efc.var_ddcc046e7b061885 ) )
    {
        return 0;
    }
    
    if ( isdefined( level.var_37e52c7fb7267efc.var_ddcc046e7b061885 ) && level.var_37e52c7fb7267efc.var_ddcc046e7b061885 > 0 )
    {
        return level.var_37e52c7fb7267efc.var_ddcc046e7b061885;
    }
    
    var_4ebf4fdb24b6df5c = max( 0, getgulagclosedcircleindex() - 1 );
    return var_4ebf4fdb24b6df5c;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 6
// Checksum 0x0, Offset: 0x1f17
// Size: 0x101
function function_f63baad2f7765f34( instance, part, state, player, bautouse, usestring )
{
    if ( !player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( !isdefined( instance.cargoprogress ) )
    {
        instance.cargoprogress = 0;
    }
    
    if ( instance.cargoprogress > 16 || istrue( player.var_b807b84e723c5cea ) )
    {
        return;
    }
    
    player.var_b807b84e723c5cea = 1;
    player playsoundonmovingent( "mine_betty_click" );
    instance.origin += ( 0, -35, 0 );
    instance.cargoprogress++;
    player.var_44722265234d31b0 = 1;
    
    if ( instance.cargoprogress > 16 )
    {
        player function_10167f4c451aadff( instance );
        instance thread function_1aa190da562f8db3();
    }
    
    player thread function_a71c019ff0f90d9d();
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x2020
// Size: 0x45
function function_a71c019ff0f90d9d()
{
    player = self;
    level endon( "game_ended" );
    player endon( "disconnect" );
    wait 1.5;
    
    if ( isdefined( player ) && isdefined( player.var_b807b84e723c5cea ) )
    {
        player.var_b807b84e723c5cea = 0;
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x206d
// Size: 0xb6
function function_10167f4c451aadff( instance )
{
    player = self;
    arena = function_de20b194b1a37513( player );
    
    if ( !isdefined( arena ) || !isdefined( arena.jailedplayers ) || arena.jailedplayers.size == 0 )
    {
        return;
    }
    
    foreach ( p in arena.jailedplayers )
    {
        p thread scripts\mp\hud_message::showsplash( "br_ai_gulag_cargo_success" );
    }
    
    instance thread function_a4b9cc7ede16275c( arena );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x212b
// Size: 0x4b
function function_1aa190da562f8db3()
{
    instance = self;
    level endon( "game_ended" );
    wait 10;
    instance.origin += ( 0, 560, 0 );
    instance.cargoprogress = 0;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 6
// Checksum 0x0, Offset: 0x217e
// Size: 0x57
function function_6c9ae1f39f71f7e1( instance, part, state, player, bautouse, usestring )
{
    if ( !player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( istrue( player.var_4bb14f07087a5da ) )
    {
        return;
    }
    
    player thread function_f5a4fd44b6a9e2ac();
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x21dd
// Size: 0x323
function function_f5a4fd44b6a9e2ac()
{
    player = self;
    level endon( "game_ended" );
    player endon( "disconnect" );
    arena = function_de20b194b1a37513( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    player.var_4bb14f07087a5da = 1;
    player.var_dbe1d28321e708dd = 1;
    player playsoundonmovingent( "mine_betty_click" );
    camera = spawn( "script_model", arena.var_267f3a45751996c2[ 0 ].origin );
    camera setmodel( "tag_origin" );
    camera.angles = arena.var_267f3a45751996c2[ 0 ].angles;
    cameratwo = spawn( "script_model", arena.var_267f3a45751996c2[ 1 ].origin );
    cameratwo setmodel( "tag_origin" );
    cameratwo.angles = arena.var_267f3a45751996c2[ 1 ].angles;
    camerathree = spawn( "script_model", arena.var_267f3a45751996c2[ 2 ].origin );
    camerathree setmodel( "tag_origin" );
    camerathree.angles = arena.var_267f3a45751996c2[ 2 ].angles;
    
    if ( istrue( level.var_37e52c7fb7267efc.var_2713a9cf5318d984 ) )
    {
        foreach ( enemyai in aibudgetmp_getagentsanddormantsincategory( "gulag" ) )
        {
            enemyai hudoutlineenableforclient( player, "outlinefill_nodepth_red" );
        }
    }
    
    wait 1;
    
    if ( istrue( player function_5322b4a5ec08d2c9( camera, cameratwo, camerathree ) ) )
    {
        return;
    }
    
    player setclientomnvar( "ui_rcd_controls", 2 );
    player cameralinkto( camera, "tag_origin", 1, 1 );
    wait 3;
    
    if ( istrue( player function_5322b4a5ec08d2c9( camera, cameratwo, camerathree ) ) )
    {
        return;
    }
    
    player cameraunlink();
    player cameralinkto( cameratwo, "tag_origin", 1, 1 );
    wait 3;
    
    if ( istrue( player function_5322b4a5ec08d2c9( camera, cameratwo, camerathree ) ) )
    {
        return;
    }
    
    player cameraunlink();
    player cameralinkto( camerathree, "tag_origin", 1, 1 );
    wait 3;
    
    if ( istrue( player function_5322b4a5ec08d2c9( camera, cameratwo, camerathree ) ) )
    {
        return;
    }
    
    if ( istrue( level.var_37e52c7fb7267efc.var_2713a9cf5318d984 ) )
    {
        foreach ( enemyai in aibudgetmp_getagentsanddormantsincategory( "gulag" ) )
        {
            enemyai hudoutlinedisableforclient( player );
        }
    }
    
    player setclientomnvar( "ui_rcd_controls", 0 );
    player cameraunlink();
    camera delete();
    cameratwo delete();
    player.var_4bb14f07087a5da = undefined;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 3
// Checksum 0x0, Offset: 0x2508
// Size: 0x66, Type: bool
function function_5322b4a5ec08d2c9( camera, cameratwo, camerathree )
{
    player = self;
    
    if ( !isdefined( player ) || !istrue( player.var_4bb14f07087a5da ) )
    {
        if ( isdefined( camera ) )
        {
            camera delete();
        }
        
        if ( isdefined( cameratwo ) )
        {
            cameratwo delete();
        }
        
        if ( isdefined( camerathree ) )
        {
            camerathree delete();
        }
        
        return true;
    }
    
    return false;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 6
// Checksum 0x0, Offset: 0x2577
// Size: 0x6c
function function_875f67700e4d2769( instance, part, state, player, bautouse, usestring )
{
    if ( !player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( istrue( player.var_e9343fd6e229b035 ) )
    {
        return;
    }
    
    player.var_525c703cfddaf913 = 1;
    player thread function_f229c4ce80428ffe( "briefcase_bomb_mp", 3 );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 6
// Checksum 0x0, Offset: 0x25eb
// Size: 0x9c
function function_b0f86be8e080101( instance, part, state, player, bautouse, usestring )
{
    if ( !player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( !isdefined( player.gulagbag ) )
    {
        player scripts\mp\hud_message::showerrormessage( "MP/BR_AI_GULAG_VENT_UNABLE" );
        return;
    }
    
    player.gulagbag = undefined;
    player.var_97ac1ea78faea6e3 = 1;
    player.var_e60b359eb0c2f51d = 1;
    player playsoundonmovingent( "mine_betty_click" );
    player thread scripts\mp\hud_message::showsplash( "br_ai_gulag_vent_success" );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 6
// Checksum 0x0, Offset: 0x268f
// Size: 0xac
function function_3bc6f653f16663aa( instance, part, state, player, bautouse, usestring )
{
    arena = namespace_ad49798629176e96::function_2f4344abdc200e43( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( !isdefined( arena.var_f69974791bb59e4b ) )
    {
        arena.var_f69974791bb59e4b = [];
    }
    
    if ( array_contains( arena.var_f69974791bb59e4b, player ) )
    {
        return;
    }
    
    arena.var_f69974791bb59e4b[ arena.var_f69974791bb59e4b.size ] = player;
    arena function_2ac2880e868dfec6();
    player playsoundonmovingent( "mine_betty_click" );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 6
// Checksum 0x0, Offset: 0x2743
// Size: 0x172
function function_e40faa26da957604( instance, part, state, player, bautouse, usestring )
{
    if ( !player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( isdefined( player.gulagbag ) && !istrue( instance.ingulag ) )
    {
        return;
    }
    
    player playsoundonmovingent( "mine_betty_click" );
    
    if ( istrue( instance.ingulag ) )
    {
        player.pers[ "gamemodeLoadout" ] = function_f4fab9c1a6e08991();
        player.class = "gamemode";
        player.prevweaponobj = undefined;
        struct = player scripts\mp\class::loadout_getclassstruct();
        struct = player scripts\mp\class::loadout_updateclass( struct, "gamemode" );
        player scripts\mp\class::preloadandqueueclassstruct( struct, 1, 1 );
        player scripts\mp\class::giveloadout( player.team, "gamemode", 0, 0 );
        player givestartammo( struct.loadoutprimaryobject );
        player scripts\mp\gametypes\br_weapons::br_give_weapon_clip( struct.loadoutprimaryobject, 2 );
        
        if ( isdefined( struct.loadoutsecondaryobject ) )
        {
            player givestartammo( struct.loadoutsecondaryobject );
            player scripts\mp\gametypes\br_weapons::br_give_weapon_clip( struct.loadoutsecondaryobject, 2 );
        }
        
        return;
    }
    
    player.gulagbag = 1;
    player.var_2ac81a7104e85b68 = 1;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 6
// Checksum 0x0, Offset: 0x28bd
// Size: 0xe9
function function_b7e4cbd2a1618bdc( instance, part, state, player, bautouse, usestring )
{
    arena = namespace_ad49798629176e96::function_2f4344abdc200e43( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( array_contains( arena.arenaplayers, player ) )
    {
        player thread namespace_ad49798629176e96::function_a65df5d97ee38203( arena );
        player namespace_ad49798629176e96::function_dcead2b56fdbf3e( "win" );
        player namespace_ad49798629176e96::function_3f18739ae34d9958();
        player function_10aa5ac1861ffb67( -1 );
        
        if ( istrue( level.var_37e52c7fb7267efc.var_37afb6f23303b55a ) && isdefined( arena.objid ) )
        {
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom( arena.objid, player );
        }
        
        player thread gulagvictory( arena, player, 1, 0, "gulag_ai" );
        
        if ( namespace_ad49798629176e96::function_7ad9fcb1ac4f3db8() )
        {
            player thread function_45c3dc4231157a10();
        }
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x29ae
// Size: 0x81
function function_f431c7f719a5a19( arena )
{
    if ( !isdefined( arena.loot_structs ) || arena.loot_structs.size == 0 )
    {
        return;
    }
    
    arena.baggulag = spawnscriptable( "second_chance_bag", arena.loot_structs[ 0 ].origin + ( 0, 0, 10 ) );
    arena.baggulag.ingulag = 1;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 2
// Checksum 0x0, Offset: 0x2a37
// Size: 0x41
function function_f229c4ce80428ffe( weaponref, waitduration )
{
    player = self;
    player.var_e9343fd6e229b035 = 1;
    player function_45cbf298abfaf76a( weaponref, waitduration );
    player function_bfb05639e6a851c0( weaponref );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 2
// Checksum 0x0, Offset: 0x2a80
// Size: 0x78
function function_45cbf298abfaf76a( weaponref, waitduration )
{
    player = self;
    player endon( "beginNewFight" );
    player endon( "can_show_splashes" );
    item = makeweapon( weaponref );
    player scripts\cp_mp\utility\inventory_utility::_giveweapon( item, undefined, undefined, 0 );
    player setweaponammostock( item, 0 );
    player setweaponammoclip( item, 0 );
    player thread scripts\mp\gameobjects::switchtouseweapon( item, 1 );
    wait waitduration;
    player thread scripts\mp\hud_message::showsplash( "br_ai_gulag_cable_tempered" );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x2b00
// Size: 0x2c
function function_bfb05639e6a851c0( weaponref )
{
    player = self;
    player scripts\cp_mp\utility\inventory_utility::getridofweapon( weaponref );
    player.var_e9343fd6e229b035 = undefined;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 6
// Checksum 0x0, Offset: 0x2b34
// Size: 0x1f5
function function_ed3b3a2040c051a6( instance, part, state, player, bautouse, usestring )
{
    arena = namespace_ad49798629176e96::function_2f4344abdc200e43( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( istrue( arena.overtime ) )
    {
        return;
    }
    
    foreach ( player in arena.arenaplayers )
    {
        player thread scripts\mp\hud_message::showsplash( "br_ai_gulag_reached_end" );
    }
    
    if ( !istrue( level.var_37e52c7fb7267efc.var_609a4f76dce95688 ) )
    {
        function_cdb25f748b945cfa( arena.goal_volume.origin, arena );
    }
    
    arena.goal_doors.moved = 1;
    arena.goal_doors.origin -= ( 0, 0, 200 );
    
    if ( istrue( level.var_37e52c7fb7267efc.overtimeenabled ) )
    {
        arena.overtime = 1;
        arena.dom.arenaflag arenaflag_setenabled( 1 );
        arena.dom.arenaflag arenaflag_setvisible( arena, 1 );
        arena.dom.arenaflag.flagmodel playsoundonmovingent( "flag_spawned" );
        progress = clamp( arena.time / getovertimelength(), 0, 1 );
        setovertimeomnvarprogress( arena, progress );
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x2d31
// Size: 0xe1
function function_7525a0ed21932d7( arena )
{
    level endon( "game_ended" );
    
    while ( arena.arenaplayers.size > 0 )
    {
        arena.goal_volume waittill( "trigger", player );
        
        if ( array_contains( arena.arenaplayers, player ) )
        {
            player thread namespace_ad49798629176e96::function_a65df5d97ee38203( arena );
            player namespace_ad49798629176e96::function_dcead2b56fdbf3e( "win" );
            player namespace_ad49798629176e96::function_3f18739ae34d9958();
            player function_10aa5ac1861ffb67( -1 );
            
            if ( istrue( level.var_37e52c7fb7267efc.var_37afb6f23303b55a ) && isdefined( arena.objid ) )
            {
                scripts\mp\objidpoolmanager::objective_playermask_hidefrom( arena.objid, player );
            }
            
            player thread gulagvictory( arena, player, 1, 0, "gulag_ai" );
            
            if ( namespace_ad49798629176e96::function_7ad9fcb1ac4f3db8() )
            {
                player thread function_45c3dc4231157a10();
            }
        }
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x2e1a
// Size: 0x27
function function_45c3dc4231157a10()
{
    player = self;
    player endon( "disconnect" );
    level endon( "game_ended" );
    wait 9;
    player kill();
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x2e49
// Size: 0x69
function function_39c797f7e7c6ca87( door )
{
    level endon( "game_ended" );
    
    if ( !isdefined( door.originalloc ) )
    {
        door.originalloc = door.origin;
    }
    
    if ( isdefined( door.moved ) )
    {
        door.origin = door.originalloc;
        door.moved = undefined;
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 2
// Checksum 0x0, Offset: 0x2eba
// Size: 0x34
function function_7f1a7d1e230f666c( item, location )
{
    scriptable = spawnscriptable( item, location, ( 0, 0, 0 ) );
    return scriptable;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x2ef7
// Size: 0xfb
function function_3e4c7d5b30f40ed9( arena )
{
    if ( istrue( level.var_37e52c7fb7267efc.var_609a4f76dce95688 ) )
    {
        if ( isdefined( arena.var_4d916bb4bda1f18[ 0 ] ) )
        {
            location = arena.var_4d916bb4bda1f18[ 0 ].origin;
        }
        else if ( isdefined( arena.goal_volume ) )
        {
            location = arena.goal_volume.origin;
        }
        else
        {
            location = ( 0, 0, 0 );
        }
    }
    else
    {
        location = arena.goal_volume.origin;
    }
    
    objid = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
    
    if ( objid != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( objid, "current", location, "ui_mp_br_mapmenu_icon_x1_05_objective" );
        scripts\mp\objidpoolmanager::update_objective_setbackground( objid, 1 );
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall( objid );
    }
    else
    {
        println( "<dev string:x1c>" );
    }
    
    return objid;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 2
// Checksum 0x0, Offset: 0x2ffb
// Size: 0x35
function function_cdb25f748b945cfa( location, arena )
{
    if ( !isdefined( arena.objid ) )
    {
        return;
    }
    
    objective_position( arena.objid, location );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x3038
// Size: 0x54
function function_b42c7b95b41f363c()
{
    player = self;
    wait level.var_37e52c7fb7267efc.var_4b133d9c5b92891d;
    
    if ( isdefined( player ) && player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() )
    {
        arenajail = function_de20b194b1a37513( player );
        
        if ( isdefined( arenajail ) )
        {
            player.var_d95581fdfc29ec7a = undefined;
        }
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x3094
// Size: 0x133
function function_82434e34c1223971()
{
    loadout = [];
    loadout[ "loadoutArchetype" ] = "archetype_assault";
    loadout[ "loadoutPrimary" ] = "iw9_pi_decho";
    loadout[ "loadoutPrimaryAttachment" ] = "none";
    loadout[ "loadoutPrimaryAttachment2" ] = "none";
    loadout[ "loadoutPrimaryCamo" ] = "none";
    loadout[ "loadoutPrimaryReticle" ] = "none";
    loadout[ "loadoutSecondary" ] = "none";
    loadout[ "loadoutSecondaryAttachment" ] = "none";
    loadout[ "loadoutSecondaryAttachment2" ] = "none";
    loadout[ "loadoutSecondaryCamo" ] = "none";
    loadout[ "loadoutSecondaryReticle" ] = "none";
    loadout[ "loadoutMeleeSlot" ] = "none";
    loadout[ "loadoutEquipmentPrimary" ] = "equip_frag";
    loadout[ "loadoutEquipmentSecondary" ] = "equip_snapshot_grenade";
    loadout[ "loadoutStreakType" ] = "assault";
    loadout[ "loadoutKillstreak1" ] = "none";
    loadout[ "loadoutKillstreak2" ] = "none";
    loadout[ "loadoutKillstreak3" ] = "none";
    loadout[ "loadoutSuper" ] = "super_br_extract";
    loadout[ "loadoutPerks" ] = [ "specialty_null" ];
    loadout[ "loadoutGesture" ] = "playerData";
    loadout[ "loadoutExecution" ] = "none";
    return loadout;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x31d0
// Size: 0x133
function function_f4fab9c1a6e08991()
{
    loadout = [];
    loadout[ "loadoutArchetype" ] = "archetype_assault";
    loadout[ "loadoutPrimary" ] = "iw9_sm_aviktor_mp";
    loadout[ "loadoutPrimaryAttachment" ] = "none";
    loadout[ "loadoutPrimaryAttachment2" ] = "none";
    loadout[ "loadoutPrimaryCamo" ] = "none";
    loadout[ "loadoutPrimaryReticle" ] = "none";
    loadout[ "loadoutSecondary" ] = "iw9_sh_mbravo";
    loadout[ "loadoutSecondaryAttachment" ] = "none";
    loadout[ "loadoutSecondaryAttachment2" ] = "none";
    loadout[ "loadoutSecondaryCamo" ] = "none";
    loadout[ "loadoutSecondaryReticle" ] = "none";
    loadout[ "loadoutMeleeSlot" ] = "none";
    loadout[ "loadoutEquipmentPrimary" ] = "equip_frag";
    loadout[ "loadoutEquipmentSecondary" ] = "equip_concussion";
    loadout[ "loadoutStreakType" ] = "assault";
    loadout[ "loadoutKillstreak1" ] = "none";
    loadout[ "loadoutKillstreak2" ] = "none";
    loadout[ "loadoutKillstreak3" ] = "none";
    loadout[ "loadoutSuper" ] = "super_br_extract";
    loadout[ "loadoutPerks" ] = [ "specialty_munitions_2" ];
    loadout[ "loadoutGesture" ] = "playerData";
    loadout[ "loadoutExecution" ] = "none";
    return loadout;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x330c
// Size: 0x39
function function_9dbb71aaae4e335e( arena )
{
    namespace_ad49798629176e96::function_dcead2b56fdbf3e( "lost" );
    
    if ( isdefined( arena.objid ) )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( arena.objid, self );
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 2
// Checksum 0x0, Offset: 0x334d
// Size: 0x36
function function_2b0fd45ef612b4a5( arena, var_b6acf0c07c4311e6 )
{
    winner = self;
    winner.var_22f8f8d138d3c02f = 2;
    winner function_f071db381e990d80();
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x338b
// Size: 0x3a
function function_fd55f9d5ef55b95e()
{
    player = self;
    player.waitingstarttime = gettime();
    player.var_d95581fdfc29ec7a = gettime();
    player thread function_b42c7b95b41f363c();
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x33cd
// Size: 0x52
function function_9d53e328c2d1aec4()
{
    player = self;
    player.waitingduration = gettime() - player.waitingstarttime;
    player.waitingstarttime = undefined;
    weaponobj = player getcurrentprimaryweapon();
    player scripts\mp\gametypes\br_weapons::br_give_weapon_clip( weaponobj, 2 );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x3427
// Size: 0xb0
function function_f561af47db779c79( arena )
{
    player = self;
    player endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( !isdefined( arena.var_4eb3ce9801991000 ) )
    {
        return;
    }
    
    points = arena.var_4eb3ce9801991000;
    wait 5;
    
    while ( !player isonground() )
    {
        wait 0.5;
    }
    
    if ( points >= 2 )
    {
        player scripts\mp\gametypes\br_plunder::playerplunderpickup( 5 );
    }
    
    if ( points >= 6 )
    {
        scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( player, "brloot_armor_plate", 1, 2 );
    }
    
    if ( points >= 8 )
    {
        player scripts\mp\gametypes\br_plunder::playerplunderpickup( 10 );
    }
    
    if ( points >= 10 )
    {
        scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem( player, "brloot_super_munitionsbox", 1 );
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x34df
// Size: 0xfa
function function_a4b9cc7ede16275c( arena )
{
    cargo = self;
    
    if ( !isdefined( arena.jailedplayers ) || arena.jailedplayers.size < 1 )
    {
        return;
    }
    
    foreach ( p in arena.jailedplayers )
    {
        if ( isdefined( p.var_b807b84e723c5cea ) )
        {
            p thread gulagvictory( p.arena, p, 1, 1, "jailbreakEvent" );
            
            if ( namespace_ad49798629176e96::function_7ad9fcb1ac4f3db8() )
            {
                p thread function_45c3dc4231157a10();
            }
        }
    }
    
    playsoundatpos( cargo.origin, "evt_br_gulag_round_start_buzzer" );
    arena.jailedplayers = array_removeundefined( arena.jailedplayers );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 2
// Checksum 0x0, Offset: 0x35e1
// Size: 0x19b
function function_a7a1d8d937762614( agent, killer )
{
    if ( !isplayer( killer ) )
    {
        return;
    }
    
    arena = namespace_ad49798629176e96::function_2f4344abdc200e43( killer );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( !isdefined( arena.var_4eb3ce9801991000 ) )
    {
        arena.var_4eb3ce9801991000 = 0;
    }
    
    if ( !isdefined( killer.gulagkills ) )
    {
        killer.gulagkills = 0;
    }
    
    arena.var_4eb3ce9801991000 += 1;
    killer.gulagkills += 1;
    
    if ( arena.var_4eb3ce9801991000 == 2 || arena.var_4eb3ce9801991000 == 6 || arena.var_4eb3ce9801991000 == 8 || arena.var_4eb3ce9801991000 == 10 )
    {
        foreach ( p in arena.arenaplayers )
        {
            p playsoundtoplayer( "mp_killconfirm_tags_pickup", p );
        }
    }
    
    foreach ( p in arena.arenaplayers )
    {
        p function_10aa5ac1861ffb67( arena.var_4eb3ce9801991000 );
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x3784
// Size: 0x25
function function_10aa5ac1861ffb67( value )
{
    player = self;
    player setclientomnvar( "ui_br_ai_gulag_score", value );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x37b1
// Size: 0x19b
function function_f071db381e990d80()
{
    player = self;
    arena = namespace_ad49798629176e96::function_2f4344abdc200e43( player );
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    firstplayerstatus = 0;
    var_4abdc6dfe813cd0e = 0;
    
    if ( isdefined( arena.arenaplayers ) && isdefined( arena.arenaplayers[ 0 ] ) && isdefined( arena.arenaplayers[ 0 ].var_22f8f8d138d3c02f ) )
    {
        firstplayerstatus = arena.arenaplayers[ 0 ].var_22f8f8d138d3c02f;
    }
    
    if ( isdefined( arena.arenaplayers ) && isdefined( arena.arenaplayers[ 1 ] ) && isdefined( arena.arenaplayers[ 1 ].var_22f8f8d138d3c02f ) )
    {
        var_4abdc6dfe813cd0e = arena.arenaplayers[ 1 ].var_22f8f8d138d3c02f;
    }
    
    /#
        assertex( firstplayerstatus < 16, "<dev string:x49>" );
        assertex( var_4abdc6dfe813cd0e < 16, "<dev string:x8e>" );
    #/
    
    var_3f65a52935223a7a = ( var_4abdc6dfe813cd0e << 4 ) + firstplayerstatus;
    var_87b2be9fef844de = array_combine( arena.jailedplayers, arena.arenaplayers );
    
    foreach ( p in var_87b2be9fef844de )
    {
        p setclientomnvar( "ui_br_ai_gulag_player_state", var_3f65a52935223a7a );
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x3954
// Size: 0xcb
function function_de20b194b1a37513( player )
{
    for ( i = 0; i < level.gulag.arenas.size ; i++ )
    {
        var_f40e6deec30ee209 = level.gulag.arenas[ i ];
        
        foreach ( jailedplayers in var_f40e6deec30ee209.jailedplayers )
        {
            if ( jailedplayers == player )
            {
                arena = level.gulag.arenas[ i ];
                return arena;
            }
        }
    }
    
    return undefined;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x3a28
// Size: 0x2b, Type: bool
function function_7effa8a355ddc886()
{
    if ( isdefined( level.var_37e52c7fb7267efc ) && istrue( level.var_37e52c7fb7267efc.var_2e88fff6c419ee6a ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x3a5c
// Size: 0x58, Type: bool
function function_79fdf5cd036ff575()
{
    if ( isdefined( level.var_37e52c7fb7267efc ) && istrue( level.var_37e52c7fb7267efc.var_2e88fff6c419ee6a ) && istrue( level.var_37e52c7fb7267efc.var_f04a0fb05108f52e ) || getdvarint( @"hash_8ffa9721c8dd3dcc", 0 ) != 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x3abd
// Size: 0x43, Type: bool
function function_d58396c1483bfbdb()
{
    if ( isdefined( level.var_37e52c7fb7267efc ) && istrue( level.var_37e52c7fb7267efc.var_2e88fff6c419ee6a ) && istrue( level.var_37e52c7fb7267efc.var_7d4922396daa0192 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x3b09
// Size: 0x145
function function_bd71f506af2cac70( arena )
{
    player = self;
    level endon( "game_ended" );
    player endon( "disconnect" );
    
    if ( isdefined( arena.objid ) )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( arena.objid, player );
    }
    
    if ( player.health == 0 )
    {
        wait 7;
        
        if ( !isdefined( player ) )
        {
            return;
        }
        
        player.gulag = 0;
        teammate = player;
        teammates = level.teamdata[ player.team ][ "players" ];
        
        foreach ( p in teammates )
        {
            if ( p == player )
            {
                continue;
            }
            
            teammate = p;
        }
        
        if ( isdefined( teammate ) )
        {
            teammate = teammates[ 0 ];
            teammate scripts\mp\gametypes\br_pickups::addrespawntoken( 1 );
            player playergulagautowin( "aiGulag", teammate );
            wait 7;
            
            if ( !isdefined( player ) )
            {
                return;
            }
            
            player kill();
        }
        
        return;
    }
    
    player thread gulagvictory( arena, player, 1, 0, "shutdown" );
    wait 7;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player kill();
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 2
// Checksum 0x0, Offset: 0x3c56
// Size: 0x61, Type: bool
function function_7b08c98431abda40( attacker, victim )
{
    if ( !function_7effa8a355ddc886() || !isdefined( victim ) || !isdefined( attacker ) )
    {
        return false;
    }
    
    if ( isplayer( victim ) && isplayer( attacker ) )
    {
        if ( istrue( victim.gulag ) && istrue( attacker.gulag ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x3cc0
// Size: 0x2b, Type: bool
function function_6a7fe34afaa1a01d()
{
    if ( isdefined( level.var_37e52c7fb7267efc ) && istrue( level.var_37e52c7fb7267efc.var_5cd8016b769d02aa ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x3cf4
// Size: 0xd1
function function_7cfce31d9c561b2d( arenaplayers )
{
    arena = self;
    
    if ( level.var_37e52c7fb7267efc.var_54c7916bcea2b113 == 0 )
    {
        arena function_ae6dce59ccb4b681();
        arena thread function_5427c6229b93668e( arena.fightspawns );
        return;
    }
    
    if ( level.var_37e52c7fb7267efc.var_54c7916bcea2b113 == 1 )
    {
        foreach ( p in arenaplayers )
        {
            p thread scripts\mp\hud_message::showsplash( "br_ai_gulag_afk_door" );
        }
        
        arena function_ae6dce59ccb4b681();
        arena function_16d6792e689d7559();
        arena function_3a22dd56aa026e21( arenaplayers );
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x3dcd
// Size: 0x23
function function_ae6dce59ccb4b681()
{
    arena = self;
    wait level.var_37e52c7fb7267efc.var_f98aec28092ae4f2;
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 5
// Checksum 0x0, Offset: 0x3df8
// Size: 0x18f
function function_5427c6229b93668e( locations, gasduration, var_ba599e887e5cdae4, gasdamage, var_74ab6e197feae88b )
{
    arena = self;
    arena endon( "matchEnded" );
    arena endon( "fight_over" );
    level endon( "game_ended" );
    
    if ( !isdefined( locations ) )
    {
        return;
    }
    
    if ( !isdefined( gasduration ) )
    {
        gasduration = 11;
    }
    
    if ( !isdefined( var_ba599e887e5cdae4 ) )
    {
        var_ba599e887e5cdae4 = 0;
    }
    
    if ( !isdefined( gasdamage ) )
    {
        gasdamage = 15;
    }
    
    if ( !isdefined( var_74ab6e197feae88b ) )
    {
        var_74ab6e197feae88b = 1.5;
    }
    
    foreach ( player in arena.arenaplayers )
    {
        player thread function_f3c05e86869e397c( gasdamage, var_74ab6e197feae88b );
    }
    
    foreach ( loc in locations )
    {
        position = loc.origin;
        playfx( getfx( "glsmoke" ), position, anglestoup( ( 0, 90, 0 ) ) );
        arena thread scripts\mp\equipment\gas_grenade::gas_createtrigger( position, arena.var_707537a8904aa962[ 0 ], arena.var_707537a8904aa962[ 0 ].team, gasduration, 0.7 );
        wait var_ba599e887e5cdae4;
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 2
// Checksum 0x0, Offset: 0x3f8f
// Size: 0x5c
function function_f3c05e86869e397c( gasdamage, var_74ab6e197feae88b )
{
    player = self;
    player endon( "gulagRespawn" );
    player endon( "gulagLost" );
    player endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    while ( player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() )
    {
        player waittill( "gas_begin_coughing" );
        player thread function_870d349c1ed60c21( gasdamage, var_74ab6e197feae88b );
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 2
// Checksum 0x0, Offset: 0x3ff3
// Size: 0x74
function function_870d349c1ed60c21( gasdamage, var_74ab6e197feae88b )
{
    player = self;
    player endon( "gas_modify_blur" );
    player endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        if ( player.health - gasdamage <= 0 )
        {
            player kill();
        }
        else
        {
            player.health -= gasdamage;
        }
        
        wait var_74ab6e197feae88b;
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x406f
// Size: 0x33
function function_2ac2880e868dfec6()
{
    arena = self;
    
    if ( arena.var_f69974791bb59e4b.size >= arena.arenaplayers.size )
    {
        arena notify( "gulag_both_doors_interacted" );
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x40aa
// Size: 0xa1
function function_7e3b92cd362571d0()
{
    arena = self;
    arena.var_6c9e6734548f435 = [];
    
    foreach ( structloc in arena.var_60792b044c2d2cb )
    {
        door = spawnscriptable( "second_chance_door", structloc.origin );
        arena.var_6c9e6734548f435[ arena.var_6c9e6734548f435.size ] = door;
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x4153
// Size: 0xeb
function function_16d6792e689d7559()
{
    arena = self;
    
    if ( !isdefined( arena.var_6c9e6734548f435 ) || arena.var_6c9e6734548f435.size < 1 )
    {
        return;
    }
    
    foreach ( door in arena.var_6c9e6734548f435 )
    {
        door freescriptable();
    }
    
    arena.var_6c9e6734548f435 = undefined;
    
    foreach ( p in arena.arenaplayers )
    {
        p thread scripts\mp\hud_message::showsplash( "br_ai_gulag_start" );
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x4246
// Size: 0xdf
function function_3a22dd56aa026e21( arenaplayers )
{
    arena = self;
    
    if ( !isdefined( arena.var_f69974791bb59e4b ) || arena.var_f69974791bb59e4b.size < 1 )
    {
        foreach ( p in arenaplayers )
        {
            p function_2f3cee02d1664ac3();
        }
        
        return;
    }
    
    foreach ( p in arenaplayers )
    {
        if ( !array_contains( arena.var_f69974791bb59e4b, p ) )
        {
            p function_2f3cee02d1664ac3();
        }
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 0
// Checksum 0x0, Offset: 0x432d
// Size: 0x2a
function function_2f3cee02d1664ac3()
{
    player = self;
    arena = namespace_ad49798629176e96::function_2f4344abdc200e43( player );
    player thread gulagplayerlost( arena );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x435f
// Size: 0x51
function function_591aa4c281221460( arena )
{
    if ( !isdefined( arena.var_707537a8904aa962 ) )
    {
        arena.aiset = 1;
        
        if ( isdefined( arena.ai_structs ) )
        {
            thread function_7872ad2759563bc9( arena );
        }
        
        arena waittill( "matchEnded" );
        thread function_ec081b1e504799de( arena );
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x43b8
// Size: 0x24
function function_cb74a3e70ddfe7ac( arena )
{
    category = "gulag";
    function_ba4022744dce59f6( category );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x43e4
// Size: 0x79
function function_7872ad2759563bc9( arena )
{
    if ( namespace_ad49798629176e96::function_d8f18f1d691c0ef8( arena ) )
    {
        thread function_89235e4fe5354b16( arena );
        return;
    }
    
    foreach ( aispawn in arena.ai_structs )
    {
        thread function_390d1a2dc50058c0( arena, aispawn );
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 2
// Checksum 0x0, Offset: 0x4465
// Size: 0x110
function function_390d1a2dc50058c0( arena, aispawn )
{
    aitype = "enemy_mp_smg_tier1_aq";
    spawnlocation = aispawn.origin;
    
    if ( !getdvarint( @"hash_b3d7a9483362813e", 0 ) )
    {
        spawnlocation = getclosestpointonnavmesh( aispawn.origin );
    }
    
    agent = ai_mp_requestspawnagent( aitype, spawnlocation, aispawn.angles, "absolute", "gulag", undefined, undefined, undefined, undefined, undefined, 1 );
    
    if ( isagent( agent ) )
    {
        agent thread function_c31f3a6ef58a2928( arena );
        
        if ( getdvarint( @"hash_b3d7a9483362813e", 0 ) )
        {
            agent forceteleport( spawnlocation, aispawn.angles );
            agent setgoalpos( agent.origin, 32 );
            agent clearpath();
            agent.fixednode = 1;
            agent thread function_b11c1964f528574b( agent, 1, agent.origin );
            return;
        }
        
        agent thread function_b11c1964f528574b( agent );
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x457d
// Size: 0xe7
function function_90e71e5ac7c0ee5d( arena )
{
    if ( !istrue( arena.aiset ) )
    {
        function_591aa4c281221460( arena );
    }
    
    var_c99a915a0dd0df12 = 0;
    
    foreach ( player in arena.arenaplayers )
    {
        if ( player namespace_ad49798629176e96::function_3facab0d974296c1() )
        {
            var_c99a915a0dd0df12 = 1;
            break;
        }
    }
    
    if ( var_c99a915a0dd0df12 )
    {
        foreach ( agent in arena.var_707537a8904aa962 )
        {
            if ( isagent( agent ) )
            {
            }
        }
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x466c
// Size: 0x45
function function_c31f3a6ef58a2928( arena )
{
    if ( !isdefined( arena.var_707537a8904aa962 ) )
    {
        arena.var_707537a8904aa962 = [];
    }
    
    arena.var_707537a8904aa962 = array_add( arena.var_707537a8904aa962, self );
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x46b9
// Size: 0x8e
function function_5a881c43e5febf38( arena )
{
    if ( isdefined( arena.var_707537a8904aa962 ) )
    {
        arena.var_707537a8904aa962 = array_remove( arena.var_707537a8904aa962, self );
        
        if ( isagent( self ) )
        {
            if ( isalive( self ) )
            {
                function_28b90eb2b591003f();
            }
            else
            {
                body = self getcorpseentity();
                
                if ( isdefined( body ) )
                {
                    body delete();
                }
            }
        }
        
        if ( arena.var_707537a8904aa962.size <= 0 )
        {
            arena.var_707537a8904aa962 = undefined;
        }
    }
}

// Namespace br_ai_gulag / scripts\mp\gametypes\br_ai_gulag
// Params 1
// Checksum 0x0, Offset: 0x474f
// Size: 0x123
function function_ec081b1e504799de( arena )
{
    if ( isdefined( arena.var_707537a8904aa962 ) )
    {
        foreach ( agent in arena.var_707537a8904aa962 )
        {
            if ( isagent( agent ) )
            {
                agent function_5a881c43e5febf38( arena );
                agent setthreatbiasgroup();
            }
        }
        
        arena.var_707537a8904aa962 = undefined;
        arena.aiset = undefined;
    }
    
    waitframe();
    var_2e903a90a966d9c2 = 2950;
    nearbyloot = getlootscriptablearrayinradius( undefined, undefined, arena.center, var_2e903a90a966d9c2 );
    
    foreach ( lootitem in nearbyloot )
    {
        if ( lootitem getscriptableisreserved() && lootitem getscriptableisloot() )
        {
            lootitem scripts\mp\gametypes\br_pickups::deletescriptableinstance();
        }
    }
}

