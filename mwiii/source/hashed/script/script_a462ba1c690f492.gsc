#using script_1362708683492300;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_2304453c69e996e2;
#using script_2d05e472a90adb1d;
#using script_2ff6eb4f5b8663fb;
#using script_41387eecc35b88bf;
#using script_42982ffd0134f28e;
#using script_4ef01fe6151dde4d;
#using script_4fdefae8b7bcdf73;
#using script_64351208cb856df9;
#using script_6617e2f2bb62b52b;
#using script_6f65366f542f6627;
#using script_7956d56c4922bd1;
#using script_79deab1955343d5d;
#using script_7cfaa6fd841fb4dd;
#using script_7edf952f8921aa6b;
#using script_9880b9dc28bc25e;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\gamelogic;
#using scripts\mp\mp_agent;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\scoreboard;
#using scripts\mp\vehicles\damage;

#namespace namespace_cf011d7d8f1de3ac;

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x10bf
// Size: 0xf8
function function_87759397315122a3()
{
    setdvar( @"hash_f1d095735ac37f33", 0 );
    setdvar( @"hash_f1f518497502aea8", 1 );
    level.var_54492f7bf0674200 = spawnstruct();
    level.var_54492f7bf0674200.n_armored = 0;
    level.var_54492f7bf0674200.n_mercs = 0;
    level.var_54492f7bf0674200.n_zombies = 0;
    level.var_54492f7bf0674200.difficulty = "difficulty_normal";
    level.var_54492f7bf0674200 flag_init( "merc_airborne" );
    level.var_54492f7bf0674200 flag_init( "ava_vehicle_go" );
    callback::add( "player_spawned", &on_player_spawned );
    level thread namespace_ac2dc66acdf98ed8::main();
    level._effect[ "c4_explosion" ] = loadfx( "vfx/iw9/veh/scriptables/apc/vfx_veh_apc_engine_explode.vfx" );
    level.var_54492f7bf0674200 thread setup_quest();
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x11bf
// Size: 0x6c
function function_3e10b338f3050e84( b_skipped )
{
    level endon( "game_ended" );
    level waittill( "prematch_done" );
    
    if ( istrue( b_skipped ) )
    {
        return;
    }
    
    level.var_54492f7bf0674200 thread function_de6ae73d98f28ba3();
    level.var_54492f7bf0674200 thread function_f90f151575eb87c0();
    level.var_54492f7bf0674200 thread function_28e004bcfd8a97e1();
    level.var_54492f7bf0674200 thread monitor_breach();
    level waittill( "story_quest_complete_step_1" );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x1233
// Size: 0x10
function function_e34d2618f099f04b( b_skipped )
{
    if ( istrue( b_skipped ) )
    {
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x124b
// Size: 0x41
function function_3e10b638f305151d( b_skipped )
{
    level endon( "game_ended" );
    level.var_54492f7bf0674200 setup_turrets();
    level.var_54492f7bf0674200 thread turret_defend_start();
    
    if ( istrue( b_skipped ) )
    {
        return;
    }
    
    level waittill( "story_quest_complete_step_2" );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x1294
// Size: 0x4d
function function_e34d2718f099f27e( b_skipped )
{
    if ( istrue( b_skipped ) )
    {
        skipto_teleport( "merc_defend_player_pos", 0 );
        level.var_54492f7bf0674200 thread ava_spawn();
        scripts\mp\objidpoolmanager::update_objective_state( level.var_54492f7bf0674200.var_4118ca23a8b62b78, "empty" );
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x12e9
// Size: 0x31
function function_3e10b538f30512ea( b_skipped )
{
    level endon( "game_ended" );
    
    if ( istrue( b_skipped ) )
    {
        return;
    }
    
    level.var_54492f7bf0674200 thread merc_defend();
    level waittill( "story_quest_complete_step_3" );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x1322
// Size: 0x3a
function function_e34d2818f099f4b1( b_skipped )
{
    if ( istrue( b_skipped ) )
    {
        skipto_teleport( "merc_defend_player_pos", 0 );
        level.var_54492f7bf0674200 flag_set( "ava_vehicle_go" );
        level notify( "story_quest_complete_step_3" );
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x1364
// Size: 0x30
function function_3e10b038f30507eb( b_skipped )
{
    level endon( "game_ended" );
    
    if ( istrue( b_skipped ) )
    {
        return;
    }
    
    level.var_54492f7bf0674200 rail_setup();
    level waittill( "story_quest_complete_step_4" );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x139c
// Size: 0x1e
function function_e34d2918f099f6e4( b_skipped )
{
    if ( istrue( b_skipped ) )
    {
        /#
            iprintlnbold( "<dev string:x1c>" );
        #/
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x13c2
// Size: 0x36
function function_3ff548bfc2391855()
{
    while ( true )
    {
        if ( getdvarint( @"hash_a6e925b5c1930590", 0 ) )
        {
            function_87759397315122a3();
            level flag_set( "init_quest" );
            break;
        }
        
        wait 1;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x1400
// Size: 0x5c
function setup_quest()
{
    self.var_607fd6c265fe2a0 = getentarray( "clip_zombie_breach", "targetname" );
    thread setup_barriers();
    setdvar( @"hash_f1d095735ac37f33", 0 );
    level waittill( "prematch_done" );
    skipto_teleport( "quest_start_player_pos", 1 );
    thread objective_start();
    namespace_64135de19550f047::function_e9158c9e8c391f25( "cover_merc_defend" );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x1464
// Size: 0x21
function objective_start()
{
    namespace_32e74fbed1406ca3::function_5b4245d8e50d6cc3( "Ava is somewhere in that building.  Let's go find her.", level.players, "always", 2000, 1 );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x148d
// Size: 0x2
function function_ba6167b43da41877()
{
    
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x1497
// Size: 0xed
function function_de6ae73d98f28ba3()
{
    level endon( "skipped" );
    wait 1;
    self.s_interact = getstruct( "breach_interact", "targetname" );
    self.s_charge = getstruct( "breach_charge", "targetname" );
    self.mdl_charge = utility::spawn_model( "offhand_wm_briefcase_bomb_c4_cp", self.s_charge.origin, self.s_charge.angles );
    waitframe();
    self.mdl_charge hide();
    thread function_1e86be4e3accaf94();
    self.e_charge = scripts\cp_mp\interaction::register_interact( self.s_interact.origin, 64, &breach_interact, &"JUP_OB_OBJECTIVES/Q0_PLANT_CHARGE" );
    self.e_charge waittill( "charge_planted" );
    self.e_charge delete();
    self notify( "charge_planted" );
    thread function_5d024034f0b757a3();
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x158c
// Size: 0x192
function function_5d024034f0b757a3()
{
    self.mdl_charge show();
    n_time = 5;
    
    while ( n_time )
    {
        iprintlnbold( "Bomb Countdown: " + n_time );
        n_time--;
        wait 1;
    }
    
    playfx( getfx( "c4_explosion" ), self.mdl_charge.origin );
    playsoundatpos( self.mdl_charge.origin, "evt_ob_q_object_explo" );
    self.mdl_charge thread function_3aff99f1ebe5698b();
    waitframe();
    thread function_db21ab0a6b9e93ee( self.mdl_charge, 100 );
    self notify( "breached" );
    self.mdl_charge delete();
    
    foreach ( mdl_entry in self.var_25c51a60bc088d9b )
    {
        mdl_entry delete();
    }
    
    foreach ( mdl_clip in self.var_607fd6c265fe2a0 )
    {
        if ( isdefined( mdl_clip ) && isdefined( mdl_clip.script_noteworthy ) && mdl_clip.script_noteworthy == "breach_entry" )
        {
            mdl_clip connectpaths();
            wait 0.1;
            mdl_clip delete();
        }
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x1726
// Size: 0x13
function breach_interact( player )
{
    self notify( "charge_planted" );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x1741
// Size: 0x2
function function_3aff99f1ebe5698b()
{
    
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x174b
// Size: 0x19a
function setup_barriers()
{
    self.var_e60f78a6da569e71 = [];
    self.var_25c51a60bc088d9b = [];
    self.var_2788b7f8dbde803d = [];
    self.var_686818ffab148c29 = [];
    self.a_s_barriers = getstructarray( "breach_barrier", "targetname" );
    
    foreach ( s_barrier in self.a_s_barriers )
    {
        self.var_e60f78a6da569e71[ self.var_e60f78a6da569e71.size ] = utility::spawn_model( "s4_barrier_wood_window_slats_48x72_01", s_barrier.origin, s_barrier.angles );
        
        if ( isdefined( s_barrier.script_noteworthy ) )
        {
            if ( s_barrier.script_noteworthy == "entry_barrier" )
            {
                self.var_25c51a60bc088d9b[ self.var_25c51a60bc088d9b.size ] = self.var_e60f78a6da569e71[ self.var_e60f78a6da569e71.size - 1 ];
                continue;
            }
            
            if ( s_barrier.script_noteworthy == "exit_barrier" )
            {
                self.var_2788b7f8dbde803d[ self.var_2788b7f8dbde803d.size ] = self.var_e60f78a6da569e71[ self.var_e60f78a6da569e71.size - 1 ];
                continue;
            }
            
            if ( s_barrier.script_noteworthy == "defend_exit" )
            {
                self.var_686818ffab148c29[ self.var_686818ffab148c29.size ] = self.var_e60f78a6da569e71[ self.var_e60f78a6da569e71.size - 1 ];
            }
        }
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x18ed
// Size: 0x115
function function_f90f151575eb87c0()
{
    level endon( "skipped" );
    var_c6e42f4c295786d2 = getstructarray( "breach_spawner_entry", "targetname" );
    wait_watcher( getstruct( "breach_interact", "targetname" ) );
    namespace_32e74fbed1406ca3::function_5b4245d8e50d6cc3( "Get inside that building.", level.players, "always", 2000, 1, 1 );
    n_zombies = function_20385cfdc216f458();
    
    for ( i = 0; i < var_c6e42f4c295786d2.size ; i++ )
    {
        a_s_spawners = function_b584f143ed0ec5d0( var_c6e42f4c295786d2[ i ].origin, n_zombies, var_c6e42f4c295786d2[ i ].radius );
        
        foreach ( s_spawner in a_s_spawners )
        {
            ai_zombie = spawn_zombie( s_spawner );
            waitframe();
            
            if ( isdefined( ai_zombie ) )
            {
                ai_zombie thread function_a250d816c3645ad2( self );
            }
        }
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x1a0a
// Size: 0x8c
function function_28e004bcfd8a97e1()
{
    var_c6e42f4c295786d2 = getstructarray( "breach_zombie_spawner", "targetname" );
    
    foreach ( s_zombie in var_c6e42f4c295786d2 )
    {
        s_zombie.s_target = getstruct( s_zombie.target, "targetname" );
        s_zombie thread function_a687eb1efe2bd5fd( self );
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x1a9e
// Size: 0x146
function function_a687eb1efe2bd5fd( quest_info )
{
    level endon( "skipped" );
    self endon( "spawned" );
    n_dist = squared( self.s_target.radius );
    n_zombies = function_20385cfdc216f458();
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( distance2dsquared( self.s_target.origin, player.origin ) <= n_dist )
            {
                a_s_spawners = function_b584f143ed0ec5d0( self.origin, n_zombies, self.radius );
                
                foreach ( s_spawner in a_s_spawners )
                {
                    quest_info spawn_zombie( s_spawner );
                }
                
                self notify( "spawned" );
            }
        }
        
        wait 0.5;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 3
// Checksum 0x0, Offset: 0x1bec
// Size: 0x107
function spawn_zombie( s_pt, b_attack, n_radius )
{
    if ( !isdefined( b_attack ) )
    {
        b_attack = 0;
    }
    
    str_aitype = function_af6084ba33d72168();
    aitype = getdvar( @"hash_5254c3fbd200d7ee", str_aitype );
    pos = level.var_4db5d2aa78c050a3;
    team = "team_two_hundred";
    ai_zombie = scripts\mp\mp_agent::spawnnewagentaitype( aitype, s_pt.origin, s_pt.angles, team );
    waitframe();
    
    if ( isalive( ai_zombie ) )
    {
        ai_zombie namespace_dd16d65e824b8e9::function_b5e57408c7878df7( &function_20a33aa40305aafc );
        ai_zombie.team = "team_two_hundred";
        
        if ( scripts\engine\utility::percent_chance( 20 ) )
        {
            str_speed = "super_sprint";
        }
        else
        {
            str_speed = "sprint";
        }
        
        ai_zombie namespace_dd16d65e824b8e9::function_f1e5805da192a1ef( str_speed, "default", 26 );
        
        if ( b_attack )
        {
            ai_zombie thread attack_player( n_radius );
        }
        
        return ai_zombie;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 3
// Checksum 0x0, Offset: 0x1cfb
// Size: 0x122
function spawn_merc( s_pt, b_attack, n_radius )
{
    if ( !isdefined( b_attack ) )
    {
        b_attack = 0;
    }
    
    var_4661c9a486253047 = [ "ar", "lmg", "smg" ];
    ai_merc = namespace_64135de19550f047::function_5881a353a471bd02( random( var_4661c9a486253047 ), s_pt.origin, s_pt.angles, "team_hundred_ninety", 2 );
    waitframe();
    
    if ( isalive( ai_merc ) )
    {
        if ( isdefined( ai_merc ) )
        {
            self.n_mercs++;
            
            if ( isdefined( s_pt.target ) )
            {
                ai_merc thread scripts\mp\ai_behavior::function_4c61a6fd42fa58( getstruct( s_pt.target, "targetname" ) );
            }
            else if ( isdefined( s_pt.script_noteworthy ) && s_pt.script_noteworthy == "sniper" )
            {
                ai_merc thread scripts\mp\ai_behavior::function_b11c1964f528574b( ai_merc, 1, s_pt.origin );
            }
            else
            {
                ai_merc thread scripts\mp\ai_behavior::function_9bbf1713a14fa580( ai_merc, 128, 64, s_pt.origin );
            }
            
            return ai_merc;
        }
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x1e25
// Size: 0x156
function function_9472a81e1e313004( s_pt )
{
    str_aitype = function_af6084ba33d72168();
    aitype = getdvar( @"hash_5254c3fbd200d7ee", str_aitype );
    pos = level.var_4db5d2aa78c050a3;
    team = "team_two_hundred";
    ai_zombie = scripts\mp\mp_agent::spawnnewagentaitype( aitype, s_pt.origin, s_pt.angles, team );
    
    if ( isdefined( ai_zombie ) && ai_zombie function_8fa69650e33c84ef( "spawn" ) )
    {
        ai_zombie thread animscriptedagent( "spawn", "spawn_end", undefined, undefined, "spawn_animating" );
    }
    
    waitframe();
    
    if ( isalive( ai_zombie ) )
    {
        self.n_zombies++;
        ai_zombie.team = "team_two_hundred";
        ai_zombie namespace_dd16d65e824b8e9::function_b5e57408c7878df7( &function_20a33aa40305aafc );
        
        if ( ai_zombie.agent_type == "actor_jup_spawner_zombie_base" )
        {
            ai_zombie thread function_46c328e4e24b334a( self );
        }
        else
        {
            self.n_armored++;
            ai_zombie thread function_beb2cfd9b21349d5( self );
        }
        
        if ( scripts\engine\utility::percent_chance( 20 ) )
        {
            str_speed = "super_sprint";
        }
        else
        {
            str_speed = "sprint";
        }
        
        ai_zombie namespace_dd16d65e824b8e9::function_f1e5805da192a1ef( str_speed, "default", 26 );
        ai_zombie thread attack_player( 1500 );
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x1f83
// Size: 0x2f
function function_46c328e4e24b334a( s_quest )
{
    self waittill( "death" );
    
    if ( s_quest.n_zombies > 0 )
    {
        s_quest.n_zombies--;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x1fba
// Size: 0x3b
function function_beb2cfd9b21349d5( s_quest )
{
    self waittill( "death" );
    
    if ( s_quest.n_zombies > 0 )
    {
        s_quest.n_zombies--;
        s_quest.n_armored--;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x1ffd
// Size: 0x39
function function_af6084ba33d72168()
{
    if ( scripts\engine\utility::percent_chance( 20 ) && self.n_armored < 6 )
    {
        str_aitype = "jup_spawner_zombie_base_armored_heavy";
    }
    else
    {
        str_aitype = "jup_spawner_zombie_base";
    }
    
    return str_aitype;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 3
// Checksum 0x0, Offset: 0x203f
// Size: 0xdb
function function_b584f143ed0ec5d0( origin, num_spots, n_radius )
{
    var_f10d2bae0aa4fce7 = [];
    
    for ( i = 0; i < num_spots ; i++ )
    {
        var_2a74fdb9fac967ff = randomintrange( n_radius * -1, n_radius + 1 );
        var_2a74fcb9fac965cc = randomintrange( n_radius * -1, n_radius + 1 );
        pos = origin + ( var_2a74fdb9fac967ff, var_2a74fcb9fac965cc, 0 );
        pos_on_navmesh = getclosestpointonnavmesh( pos );
        s_spot = spawnstruct();
        
        if ( isdefined( s_spot ) )
        {
            s_spot.origin = pos_on_navmesh;
            s_spot.angles = ( 0, 0, 0 );
        }
        
        if ( isdefined( pos_on_navmesh ) )
        {
            var_f10d2bae0aa4fce7[ var_f10d2bae0aa4fce7.size ] = s_spot;
        }
    }
    
    return var_f10d2bae0aa4fce7;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x2123
// Size: 0xc8
function function_9a77b5ad8fe80b87()
{
    var_607fd6c265fe2a0 = getentarray( "clip_zombie_breach", "targetname" );
    
    foreach ( mdl_clip in var_607fd6c265fe2a0 )
    {
        if ( isdefined( mdl_clip ) )
        {
            mdl_clip movez( -10000, 0.1 );
        }
    }
    
    level flag_wait( "player_spawned" );
    
    foreach ( mdl_clip in var_607fd6c265fe2a0 )
    {
        if ( isdefined( mdl_clip ) )
        {
            mdl_clip thread function_efc91437286e0ba1();
        }
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x21f3
// Size: 0x20
function function_efc91437286e0ba1()
{
    self movez( 10000, 0.1 );
    self waittill( "movedone" );
    self disconnectpaths();
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x221b
// Size: 0x73
function function_af6ceb543695252b()
{
    var_607fd6c265fe2a0 = getentarray( "clip_zombie_breach", "targetname" );
    
    foreach ( mdl_clip in var_607fd6c265fe2a0 )
    {
        if ( isdefined( mdl_clip ) )
        {
            mdl_clip connectpaths();
            waitframe();
            mdl_clip delete();
        }
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x2296
// Size: 0xd6
function function_1e86be4e3accaf94()
{
    self.var_4118ca23a8b62b78 = scripts\mp\objidpoolmanager::requestobjectiveid( 0 );
    waitframe();
    scripts\mp\objidpoolmanager::objective_set_play_intro( self.var_4118ca23a8b62b78, 0 );
    scripts\mp\objidpoolmanager::objective_set_play_outro( self.var_4118ca23a8b62b78, 0 );
    scripts\mp\objidpoolmanager::objective_add_objective( self.var_4118ca23a8b62b78, "current" );
    scripts\mp\objidpoolmanager::update_objective_position( self.var_4118ca23a8b62b78, self.s_charge.origin );
    scripts\mp\objidpoolmanager::update_objective_icon( self.var_4118ca23a8b62b78, "icon_waypoint_objective_general" );
    scripts\mp\objidpoolmanager::objective_playermask_showtoall( self.var_4118ca23a8b62b78 );
    scripts\mp\objidpoolmanager::update_objective_setbackground( self.var_4118ca23a8b62b78, 1 );
    scripts\mp\objidpoolmanager::update_objective_ownerteam( self.var_4118ca23a8b62b78, "neutral" );
    self waittill( "charge_planted" );
    scripts\mp\objidpoolmanager::update_objective_state( self.var_4118ca23a8b62b78, "empty" );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x2374
// Size: 0x74
function monitor_breach()
{
    level endon( "skipped" );
    wait_watcher( getstruct( "turret_defend_start", "targetname" ) );
    s_exp = getstruct( "defend_explosion", "targetname" );
    scripts\mp\objidpoolmanager::update_objective_state( self.var_4118ca23a8b62b78, "current" );
    scripts\mp\objidpoolmanager::update_objective_position( self.var_4118ca23a8b62b78, s_exp.origin );
    level notify( "story_quest_complete_step_1" );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x23f0
// Size: 0xfe
function setup_turrets()
{
    level waittill( "story_quest_complete_step_1" );
    namespace_8ef157d888576350::function_610dfcbf191b189b();
    self.var_ac351578b7196874 = [];
    self.var_be6bb0d3ba2db2fe = getstructarray( "turret_ava", "targetname" );
    
    foreach ( s_turret in self.var_be6bb0d3ba2db2fe )
    {
        s_turret.turrettype = "defend_turret";
        s_turret.team = level.players[ 0 ].team;
        s_turret.owner = level.players[ 0 ];
        s_turret.var_6d9f48354b1ae939 = 1;
        s_turret.turret = namespace_8ef157d888576350::sentryturret_create( s_turret );
        s_turret.turret thread turret_monitor( self );
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x24f6
// Size: 0xa
function turret_defend_start()
{
    thread function_e9e6bf7d03f3f4d8();
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x2508
// Size: 0xec
function function_e9e6bf7d03f3f4d8()
{
    a_s_spawns = getstructarray( "defend_zombie_spawner", "targetname" );
    
    switch ( level.players.size )
    {
        case 1:
            n_active = 15;
            break;
        case 2:
            n_active = 18;
            break;
        case 3:
            n_active = 20;
            break;
        case 4:
            n_active = 24;
            break;
        default:
            n_active = 8;
            break;
    }
    
    wait_watcher( getstruct( "defend_start", "targetname" ) );
    namespace_32e74fbed1406ca3::function_5b4245d8e50d6cc3( "Get to those turrets!", level.players, "always", 2000, 1, 1 );
    thread function_3f64e1ac142a5bf( n_active, a_s_spawns );
    wait 60;
    self notify( "defend_done" );
    level notify( "story_quest_complete_step_2" );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x25fc
// Size: 0x30
function turret_monitor( s_quest )
{
    self endon( "death" );
    s_quest waittill( "defend_done" );
    self notify( "stop_shooting" );
    wait 0.1;
    namespace_8ef157d888576350::sentryturret_setinactive( self );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x2634
// Size: 0x73
function function_3f64e1ac142a5bf( n_active, var_f10d2bae0aa4fce7 )
{
    self endon( "defend_done" );
    
    while ( true )
    {
        var_f10d2bae0aa4fce7 = array_randomize( var_f10d2bae0aa4fce7 );
        
        for ( i = 0; i < var_f10d2bae0aa4fce7.size ; i++ )
        {
            if ( self.n_zombies < n_active )
            {
                function_9472a81e1e313004( var_f10d2bae0aa4fce7[ i ] );
                wait randomfloatrange( 0.5, 1 );
            }
        }
        
        wait 0.5;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x26af
// Size: 0x152
function function_17b8713dc49bd702()
{
    self.e_turrets = [];
    
    foreach ( s_turret in self.var_be6bb0d3ba2db2fe )
    {
        self.e_turrets[ self.e_turrets.size ] = namespace_64135de19550f047::function_586d4d82f07e0d09( s_turret );
    }
    
    waitframe();
    
    foreach ( e_turret in self.e_turrets )
    {
        e_turret.team = level.players[ 0 ].team;
    }
    
    self waittill( "defend_done" );
    
    foreach ( e_turret in self.e_turrets )
    {
        if ( isdefined( e_turret ) && isdefined( e_turret.attractor ) )
        {
            remove_attractor( e_turret.attractor );
        }
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x2809
// Size: 0xb8
function function_4683868ff58c695d( attractor, zombie )
{
    if ( isdefined( zombie.var_941802a0997e0c42 ) )
    {
        return 0;
    }
    
    if ( isdefined( level.players ) )
    {
        player = getclosest( zombie.origin, level.players, 2000 );
        
        if ( isdefined( player ) && distance2dsquared( zombie.origin, player.origin ) < distance2dsquared( zombie.origin, attractor.source.origin ) )
        {
            return 0;
        }
    }
    
    if ( isalive( zombie ) && isdefined( attractor ) )
    {
        return 1;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x28c9
// Size: 0xf4
function merc_defend()
{
    level endon( "skipped" );
    thread function_caf7e8e50d7bee96();
    function_6a40feac381a035f();
    self.s_comm = getstruct( "ava_comm_unit", "targetname" );
    self.mdl_comm = utility::spawn_model( "military_hq_crate_01_proxy_cp_spawnable", self.s_comm.origin, self.s_comm.angles );
    wait_watcher( getstruct( "breach_exit_point", "targetname" ) );
    function_20f503076f97ec85();
    
    while ( self.n_mercs > 3 )
    {
        wait 1;
    }
    
    thread spawn_mercs( 1 );
    
    while ( self.n_mercs > 5 )
    {
        wait 1;
    }
    
    function_804aa1cbd49ba400( getstructarray( "merc_chopper", "targetname" ) );
    flag_wait( "merc_airborne" );
    flag_set( "ava_vehicle_go" );
    level notify( "story_quest_complete_step_3" );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x29c5
// Size: 0x198
function spawn_mercs( n_wave )
{
    n_total = function_ee63d6fa5d4d6e87( n_wave );
    n_active = function_cbec893df583aecc();
    n_spawned = 0;
    var_4661c9a486253047 = [ "ar", "lmg", "smg" ];
    
    while ( true )
    {
        if ( self.n_mercs < n_active )
        {
            s_spawner = function_254323e1a248db9a( getstructarray( "merc_spawn_pos", "targetname" ) );
            ai_merc = namespace_64135de19550f047::function_5881a353a471bd02( random( var_4661c9a486253047 ), s_spawner.origin, s_spawner.angles, "team_hundred_ninety", 2 );
            
            if ( isdefined( ai_merc ) )
            {
                self.n_mercs++;
                
                if ( isdefined( s_spawner.target ) )
                {
                    ai_merc thread scripts\mp\ai_behavior::function_4c61a6fd42fa58( getstruct( s_spawner.target, "targetname" ) );
                }
                else if ( isdefined( s_spawner.script_noteworthy ) && s_spawner.script_noteworthy == "sniper" )
                {
                    ai_merc thread scripts\mp\ai_behavior::function_b11c1964f528574b( ai_merc, 1, s_spawner.origin );
                }
                else
                {
                    ai_merc thread scripts\mp\ai_behavior::function_9bbf1713a14fa580( ai_merc, 128, 64, s_spawner.origin );
                }
                
                ai_merc thread function_a344f88e91b8c4ee();
                ai_merc thread function_d9f63cad62a5df8e( self );
                n_spawned++;
                
                if ( n_spawned >= n_total )
                {
                    break;
                }
            }
        }
        
        wait randomfloatrange( 0.5, 1.5 );
    }
    
    thread function_2cc571d4c77b4052();
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x2b65
// Size: 0x26
function function_a344f88e91b8c4ee()
{
    self endon( "death" );
    thread attack_player( 1500 );
    
    while ( true )
    {
        self findbestcovernode();
        wait 3;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x2b93
// Size: 0x2d
function function_d9f63cad62a5df8e( s_quest )
{
    self waittill( "death" );
    
    if ( s_quest.n_mercs )
    {
        s_quest.n_mercs--;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x2bc8
// Size: 0x2bc
function function_20f503076f97ec85()
{
    self.var_c271e0870dfe0089 = [];
    var_a756dbc9ec43e6c4 = "veh9_techo_rebel_armor";
    self.var_f3bc9650a3828799 = [];
    self.var_f3bc9550a3828566 = [];
    self.var_f3bc9650a3828799[ "merc_veh_0" ] = var_a756dbc9ec43e6c4;
    self.var_f3bc9550a3828566[ "merc_veh_1" ] = var_a756dbc9ec43e6c4;
    var_d2a21a88ac01c152 = getstruct( "merc_veh_0", "targetname" );
    var_d2a21b88ac01c385 = getstruct( "merc_veh_1", "targetname" );
    wait 0.1;
    var_d2a21a88ac01c152.spawndata = spawnstruct();
    var_d2a21a88ac01c152.spawndata.angles = var_d2a21a88ac01c152.angles;
    var_d2a21a88ac01c152.spawndata.origin = var_d2a21a88ac01c152.origin;
    var_d2a21a88ac01c152.spawndata.initai = 1;
    var_d2a21b88ac01c385.spawndata = spawnstruct();
    var_d2a21b88ac01c385.spawndata.angles = var_d2a21b88ac01c385.angles;
    var_d2a21b88ac01c385.spawndata.origin = var_d2a21b88ac01c385.origin;
    var_d2a21b88ac01c385.spawndata.initai = 1;
    
    foreach ( refname in self.var_f3bc9650a3828799 )
    {
        self.var_c271e0870dfe0089[ self.var_c271e0870dfe0089.size ] = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( refname, var_d2a21a88ac01c152.spawndata );
    }
    
    foreach ( refname in self.var_f3bc9550a3828566 )
    {
        self.var_c271e0870dfe0089[ self.var_c271e0870dfe0089.size ] = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( refname, var_d2a21b88ac01c385.spawndata );
    }
    
    wait 0.5;
    
    foreach ( var_4935eb9a94a96a5 in self.var_c271e0870dfe0089 )
    {
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable( var_4935eb9a94a96a5 );
        var_4935eb9a94a96a5.preventrespawn = 1;
        var_4935eb9a94a96a5 thread function_81736a1ad0f27c6( self );
    }
    
    wait 3;
    thread function_2cc571d4c77b4052();
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x2e8c
// Size: 0xbd
function function_b5d2e634d5a8cef4( var_54492f7bf0674200, n_riders )
{
    for ( i = 0; i < n_riders ; i++ )
    {
        var_f5c1001be3a71548 = [ "ar", "lmg", "smg" ];
        ai_rider = namespace_64135de19550f047::function_5881a353a471bd02( random( var_f5c1001be3a71548 ), self.origin + ( 0, 0, 128 ), self.angles, "team_hundred_ninety", 2 );
        waitframe();
        
        if ( isdefined( ai_rider ) )
        {
            var_54492f7bf0674200.n_mercs++;
            scripts\common\vehicle_aianim::guy_enter( ai_rider );
            ai_rider thread function_d9f63cad62a5df8e( var_54492f7bf0674200 );
            ai_rider thread function_265fc153525cc5e3();
        }
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x2f51
// Size: 0x26
function function_265fc153525cc5e3()
{
    self endon( "death" );
    self waittill( "jumpedout" );
    wait 1;
    function_a344f88e91b8c4ee();
    thread attack_player( 1500 );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x2f7f
// Size: 0x59
function function_81736a1ad0f27c6( var_54492f7bf0674200 )
{
    self endon( "death" );
    var_d993688670684035 = getvehiclenodearray( "merc_start", "targetname" );
    nd_start = getclosest( self.origin, var_d993688670684035 );
    function_b5d2e634d5a8cef4( var_54492f7bf0674200, 4 );
    scripts\common\vehicle::attach_vehicle_and_gopath( nd_start );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x2fe0
// Size: 0x1b7
function function_804aa1cbd49ba400( a_s_pos )
{
    foreach ( s_pos in a_s_pos )
    {
        s_pos.spawndata = spawnstruct();
        s_pos.spawndata.origin = s_pos.origin;
        s_pos.spawndata.angles = s_pos.angles;
        s_pos.spawndata.spawntype = "GAME_MODE";
        s_pos.v_chopper = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "veh_jup_blima", s_pos.spawndata );
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable( s_pos.v_chopper );
        s_pos.v_chopper scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setcandamage( 0 );
        s_pos.v_chopper.callingteam = "team_hundred_ninety";
        s_pos.v_chopper.unload_land_offset = 255;
        s_pos.v_chopper.script_disconnectpaths = 1;
        s_pos.v_chopper.vehiclesetuprope = 1;
        s_pos.v_chopper.ignorelist = [ s_pos.v_chopper ];
        s_pos.v_chopper thread function_514f522c0fd10ad7( self, getstruct( s_pos.target, "targetname" ) );
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x319f
// Size: 0x15b
function function_514f522c0fd10ad7( var_54492f7bf0674200, s_goal )
{
    self endon( "death" );
    self.var_f585b76d7f472cd9 = [];
    var_4661c9a486253047 = [ "ar", "lmg", "smg" ];
    
    for ( i = 0; i < 5 ; i++ )
    {
        ai_merc = namespace_64135de19550f047::function_5881a353a471bd02( random( var_4661c9a486253047 ), self.origin, self.angles, "team_hundred_ninety", 2 );
        
        if ( isdefined( ai_merc ) )
        {
            self.var_f585b76d7f472cd9[ i ] = ai_merc;
        }
        
        waitframe();
    }
    
    namespace_5d57e6b81b105f5d::function_35c699c709e24b69( self.var_f585b76d7f472cd9 );
    self vehicle_setspeed( 60, 10, 8 );
    
    while ( true )
    {
        if ( isdefined( s_goal.script_noteworthy ) && s_goal.script_noteworthy == "drop_off" )
        {
            heli_unload( s_goal.origin );
        }
        else
        {
            self setvehgoalpos( s_goal.origin, 1 );
            self waittill( "goal" );
        }
        
        if ( isdefined( s_goal.target ) )
        {
            s_goal = getstruct( s_goal.target, "targetname" );
            continue;
        }
        
        break;
    }
    
    var_54492f7bf0674200 flag_set( "merc_airborne" );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x3302
// Size: 0x85
function heli_unload( unload_location )
{
    self setvehgoalpos( unload_location, 1 );
    self waittill( "goal" );
    var_b3941e6a151cf4d2 = scripts\common\vehicle_code::_vehicle_unload();
    self waittill( "unloaded" );
    
    foreach ( guy in var_b3941e6a151cf4d2 )
    {
        guy.var_f327ed481efe4857 = undefined;
    }
    
    return var_b3941e6a151cf4d2;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 3
// Checksum 0x0, Offset: 0x3390
// Size: 0x37
function function_baacb480af33c3a( var_54492f7bf0674200, vh_heli, v_land )
{
    self endon( "death" );
    var_54492f7bf0674200.n_mercs++;
    thread function_d9f63cad62a5df8e( var_54492f7bf0674200 );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x33cf
// Size: 0x2
function rail_setup()
{
    
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x33d9
// Size: 0x29d
function function_caf7e8e50d7bee96()
{
    var_20e578a22db9e8e7 = "veh9_mil_cargo_truck";
    self.var_2adad5a67432a282 = undefined;
    self.var_88e38b1e209c9e97 = [];
    self.var_88e38b1e209c9e97[ "ava_cargo_truck_spawn" ] = var_20e578a22db9e8e7;
    var_45883bdaf8a56684 = getstruct( "ava_cargo_truck_spawn", "targetname" );
    t_vehicle = getent( "trigger_ava_vehicle", "targetname" );
    wait 1;
    spawndata = spawnstruct();
    spawndata.angles = var_45883bdaf8a56684.angles;
    spawndata.origin = var_45883bdaf8a56684.origin;
    spawndata.team = level.players[ 0 ].team;
    spawndata.var_699ac4a9c9e9f0ec = 1;
    spawndata.var_24993ee24f7c7c0 = 1;
    t_vehicle enablelinkto();
    
    foreach ( refname in self.var_88e38b1e209c9e97 )
    {
        while ( !isdefined( self.var_2adad5a67432a282 ) )
        {
            self.var_2adad5a67432a282 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( refname, spawndata );
        }
        
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable( self.var_2adad5a67432a282 );
        self.var_2adad5a67432a282.nohitmarkers = 1;
        self.var_2adad5a67432a282.preventrespawn = 1;
    }
    
    waitframe();
    t_vehicle linkto( self.var_2adad5a67432a282 );
    nd_start = getvehiclenode( "ava_rail_start", "targetname" );
    waitframe();
    self.var_2adad5a67432a282 thread scripts\common\vehicle::attach_vehicle( nd_start );
    flag_wait( "ava_vehicle_go" );
    thread function_b38b0cc78701b351();
    wait 20;
    self.var_2adad5a67432a282 thread scripts\common\vehicle::attach_vehicle_and_gopath( nd_start );
    self.var_2adad5a67432a282 function_6086b203cd6eda0d();
    self.var_2adad5a67432a282 thread function_5401ab18e4d575fb( self );
    self.var_2adad5a67432a282 thread function_90bd7ad48c0646e5( self );
    self.var_2adad5a67432a282 thread function_f01ae83dfe738dc1( self );
    self.var_2adad5a67432a282 thread function_65c38625d2694a55( t_vehicle );
    self.var_2adad5a67432a282 thread function_36ee3c256bf542de( self );
    self.var_2adad5a67432a282 thread function_14f4e7962be2643f( self );
    self.var_2adad5a67432a282 thread function_ed4651890d65a6f8( self );
    self.var_2adad5a67432a282 thread function_b38a73fc6aa9721f( self );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x367e
// Size: 0x106
function function_b38b0cc78701b351()
{
    var_82a6f259e309287e = getstructarray( "horde_attractor", "targetname" );
    
    foreach ( s_attractor in var_82a6f259e309287e )
    {
        s_attractor.attractor = namespace_5381a59d140f4df8::add_attractor( s_attractor, 1, 1000, 0, undefined, &function_b38f0b92e2bc5fdb );
    }
    
    self.var_2adad5a67432a282 waittill( "entry" );
    scripts\mp\objidpoolmanager::update_objective_onentity( self.var_4118ca23a8b62b78, self.var_2adad5a67432a282 );
    scripts\mp\objidpoolmanager::update_objective_setzoffset( self.var_4118ca23a8b62b78, 64 );
    
    foreach ( s_attractor in var_82a6f259e309287e )
    {
        namespace_5381a59d140f4df8::remove_attractor( s_attractor.attractor );
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x378c
// Size: 0x3e
function function_6086b203cd6eda0d()
{
    self endon( "death" );
    self waittill( "entry" );
    namespace_32e74fbed1406ca3::function_5b4245d8e50d6cc3( "Get on the Truck!", level.players, "never", 2000, 1, 1 );
    self vehicle_setspeed( 0, 5, 3 );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x37d2
// Size: 0x95
function function_f01ae83dfe738dc1( s_quest )
{
    var_c6e42f4c295786d2 = getstructarray( "ava_vehicle_zombie_spawner", "targetname" );
    
    foreach ( s_zombie in var_c6e42f4c295786d2 )
    {
        s_zombie.s_target = getstruct( s_zombie.target, "targetname" );
        s_zombie thread function_c364169c42d7d5b6( s_quest );
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x386f
// Size: 0x9d
function function_5401ab18e4d575fb( s_quest )
{
    var_fdbc62a2eb9677f = getstructarray( "ava_vehicle_merc_spawner", "targetname" );
    self waittill( "mercs" );
    
    foreach ( s_merc in var_fdbc62a2eb9677f )
    {
        s_quest spawn_merc( s_merc, 1 );
    }
    
    namespace_32e74fbed1406ca3::function_5b4245d8e50d6cc3( "Keep Ava safe!", level.players, "always", 2000, 1, 1 );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x3914
// Size: 0xf6
function function_c364169c42d7d5b6( quest_info )
{
    level endon( "skipped" );
    self endon( "spawned" );
    n_dist = squared( self.s_target.radius );
    
    while ( true )
    {
        if ( distance2dsquared( self.s_target.origin, quest_info.var_2adad5a67432a282.origin ) <= n_dist )
        {
            a_s_spawners = function_b584f143ed0ec5d0( self.origin, 8, self.radius );
            
            foreach ( s_spawner in a_s_spawners )
            {
                quest_info spawn_zombie( s_spawner, 1 );
            }
            
            self notify( "spawned" );
        }
        
        wait 0.5;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x3a12
// Size: 0x14e
function function_90bd7ad48c0646e5( s_quest )
{
    self endon( "death" );
    self endon( "flats" );
    var_12efaa62b82333c5 = [ "tag_wheel_center_front_left", "tag_wheel_center_front_right", "tag_wheel_center_middle_left", "tag_wheel_center_middle_right", "tag_wheel_center_back_left", "tag_wheel_center_back_right" ];
    var_12efaa62b82333c5 = array_randomize( var_12efaa62b82333c5 );
    damagedata = spawnstruct();
    damagedata.damage = 10;
    damagedata.meansofdeath = "MOD_RIFLE_BULLET";
    i = 0;
    
    while ( true )
    {
        self waittill( "flat" );
        damagedata.partname = var_12efaa62b82333c5[ i ];
        damagedata.point = self gettagorigin( damagedata.partname );
        scripts\cp_mp\vehicles\vehicle_damage::function_152437480e61a8a2( self, damagedata, 200 );
        i++;
        
        if ( i == 1 )
        {
            s_quest thread function_257f748de6279425();
            namespace_32e74fbed1406ca3::function_5b4245d8e50d6cc3( "We've got a flat!", level.players, "never", 2000, 1, 1 );
            continue;
        }
        
        if ( i > 2 )
        {
            thread function_e29c6f098b10c447( s_quest );
            thread function_ad7ba8e61ac998ca( s_quest );
            wait 1.5;
            self.is_flat = 1;
            self notify( "flats" );
        }
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x3b68
// Size: 0x3f
function function_e29c6f098b10c447( s_quest )
{
    self endon( "death" );
    self vehicle_setspeed( 0, 5, 3 );
    namespace_32e74fbed1406ca3::function_5b4245d8e50d6cc3( "Repair the Tires!", level.players, "never", 2000, 1, 1 );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x3baf
// Size: 0x2e
function function_257f748de6279425()
{
    a_s_spawners = getstructarray( "ambush_zombie_spawner", "targetname" );
    n_zombies = function_ab65e0d9a8828ab2();
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x3be5
// Size: 0x6e
function function_ad7ba8e61ac998ca( s_quest )
{
    self endon( "death" );
    
    while ( true )
    {
        if ( isdefined( self.flattiremask ) && !self.flattiremask )
        {
            break;
        }
        
        wait 1;
    }
    
    self.is_flat = undefined;
    
    if ( isdefined( s_quest.broadcast ) )
    {
        namespace_236d5e32d01e927d::function_dacc8aa0d16e4487( level.players, s_quest.broadcast );
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x3c5b
// Size: 0x50
function function_36ee3c256bf542de( s_quest )
{
    self endon( "death" );
    self waittill( "chopper" );
    s_quest thread function_328d961097692dd1();
    s_quest thread function_d58e9fe01994f55();
    wait 1;
    namespace_32e74fbed1406ca3::function_5b4245d8e50d6cc3( "Destroy that chopper!", level.players, "always", 2000, 1, 1 );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x3cb3
// Size: 0x5e
function function_14f4e7962be2643f( s_quest )
{
    self endon( "death" );
    self waittill( "divert" );
    s_quest.var_e5141adfc5fa60b2 notify( "stop_attack" );
    s_quest.var_e5141adfc5fa60b2.chase_mode = "flank";
    wait 3;
    s_quest.var_e5141adfc5fa60b2 thread function_5e3044d71dec3655( self );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x3d19
// Size: 0x6d
function function_ed4651890d65a6f8( s_quest )
{
    self endon( "death" );
    self waittill( "turn" );
    
    if ( isdefined( s_quest.var_e5141adfc5fa60b2 ) )
    {
        s_quest.var_e5141adfc5fa60b2 notify( "stop_attack" );
        s_quest.var_e5141adfc5fa60b2.chase_mode = "forward";
    }
    
    wait 3;
    s_quest.var_e5141adfc5fa60b2 thread function_5e3044d71dec3655( self );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x3d8e
// Size: 0xf1
function function_65c38625d2694a55( t_vehicle )
{
    self endon( "death" );
    self endon( "reached_end_node" );
    
    for ( n_touching = 0; true ; n_touching = 0 )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( t_vehicle ) )
            {
                n_touching++;
            }
        }
        
        if ( n_touching != level.players.size || isdefined( self.is_flat ) )
        {
            n_speed = 0;
        }
        else if ( isdefined( self.var_bd3f3353ccaa316c ) )
        {
            n_speed = self.currentnode.speed;
        }
        else
        {
            n_speed = 15;
        }
        
        wait 0.5;
        self vehicle_setspeed( n_speed, 5, 3 );
        wait 1;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x3e87
// Size: 0x73
function zombie_horde( a_s_spawners, n_zombies )
{
    n_spawns = 0;
    
    while ( true )
    {
        s_pt = array_random( a_s_spawners );
        ai_zombie = spawn_zombie( s_pt );
        waitframe();
        
        if ( isdefined( ai_zombie ) )
        {
            if ( scripts\engine\utility::percent_chance( 50 ) )
            {
                ai_zombie thread attack_player( 1000 );
            }
            
            n_spawns++;
            
            if ( n_spawns >= n_zombies )
            {
                break;
            }
        }
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x3f02
// Size: 0x59
function function_110ac03f5f4575e( a_s_spawners, n_zombies )
{
    for ( i = 0; i < n_zombies ; i++ )
    {
        s_pt = array_random( a_s_spawners );
        ai_zombie = spawn_zombie( s_pt, 1, 3000 );
        wait 0.1;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x3f63
// Size: 0x29e
function function_328d961097692dd1()
{
    vehicle_ref = "veh_jup_hind";
    s_pos = getstruct( "merc_hind", "targetname" );
    s_goal = getstruct( s_pos.target, "targetname" );
    spawndata = spawnstruct();
    spawndata.origin = s_pos.origin;
    spawndata.angles = s_pos.angles;
    spawndata.spawntype = "GAME_MODE";
    spawndata.model = "veh9_mil_air_heli_hind_vehphys_mp";
    var_3fdedb60564fc5b5 = 3000;
    
    if ( level.players.size > 3 )
    {
        var_3fdedb60564fc5b5 = 5000;
    }
    
    vehtargetnametoref = [];
    vehtargetnametoref[ "merc_hind" ] = vehicle_ref;
    self.var_e5141adfc5fa60b2 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( vehicle_ref, spawndata );
    self.var_e5141adfc5fa60b2.turrets = [];
    waitframe();
    self.var_e5141adfc5fa60b2.turret_minigun = spawnturret( "misc_turret", self.var_e5141adfc5fa60b2 gettagorigin( "tag_rocket_right1" ), "chopper_support_turret_mp" );
    self.var_e5141adfc5fa60b2.turret_minigun linkto( self.var_e5141adfc5fa60b2, "tag_turret" );
    self.var_e5141adfc5fa60b2.turret_minigun setmode( "manual" );
    self.var_e5141adfc5fa60b2.health = var_3fdedb60564fc5b5;
    self.var_e5141adfc5fa60b2.vehiclename = "Helicopter";
    self.var_e5141adfc5fa60b2.crashoffset = 1030;
    self.var_e5141adfc5fa60b2 thread namespace_49e272e116f37d0::function_e3ab01a91dc64df0();
    scripts\mp\vehicles\damage::set_death_callback( self.var_e5141adfc5fa60b2.vehiclename, &function_82d4517b0ad36467 );
    self.var_e5141adfc5fa60b2 vehicle_setspeed( 160, 40, 20 );
    self.var_e5141adfc5fa60b2 setlookatent( self.var_2adad5a67432a282 );
    self.var_e5141adfc5fa60b2 setvehgoalpos( s_goal.origin, 0 );
    self.var_e5141adfc5fa60b2 waittill( "goal" );
    self.var_e5141adfc5fa60b2.chase_mode = "rear";
    self.var_e5141adfc5fa60b2 thread function_f0b5dc7c40caf038( self.var_2adad5a67432a282 );
    self.var_e5141adfc5fa60b2 thread function_5e3044d71dec3655( self.var_2adad5a67432a282 );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x4209
// Size: 0x10b
function function_5e3044d71dec3655( var_2adad5a67432a282 )
{
    self endon( "death" );
    self endon( "stop_attack" );
    var_2adad5a67432a282 endon( "death" );
    
    while ( true )
    {
        v_target = vectornormalize( anglestoforward( var_2adad5a67432a282.angles ) ) * 1000 + var_2adad5a67432a282.origin;
        
        if ( isdefined( self ) && function_3b142e491735475( var_2adad5a67432a282 ) )
        {
            e_missile = magicbullet( makeweapon( "samsite_missile_weapon" ), self gettagorigin( "tag_rocket_right1" ) + ( 0, 0, -16 ), v_target + ( 200, 200, 200 ) );
            e_missile thread missile_explosion();
            wait 1;
            e_missile = magicbullet( makeweapon( "samsite_missile_weapon" ), self gettagorigin( "tag_rocket_left1" ) + ( 0, 0, -16 ), v_target + ( -200, -200, 200 ) );
            e_missile thread missile_explosion();
            wait randomfloatrange( 4, 5 );
        }
        
        wait 1;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x431c
// Size: 0x23
function missile_explosion()
{
    self waittill( "death" );
    
    if ( isdefined( self ) )
    {
        playsoundatpos( self.origin, "evt_ob_q_object_explo" );
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x4347
// Size: 0x108
function function_f0b5dc7c40caf038( var_2adad5a67432a282 )
{
    self endon( "death" );
    var_2adad5a67432a282 endon( "death" );
    
    while ( true )
    {
        if ( self.chase_mode == "rear" )
        {
            v_goal = vectornormalize( anglestoforward( var_2adad5a67432a282.angles ) ) * -1500 + var_2adad5a67432a282.origin;
            n_speed = 100;
        }
        else if ( self.chase_mode == "forward" )
        {
            v_goal = vectornormalize( anglestoforward( var_2adad5a67432a282.angles ) ) * 2500 + var_2adad5a67432a282.origin;
            n_speed = 200;
        }
        else
        {
            v_goal = vectornormalize( anglestoright( var_2adad5a67432a282.angles ) ) * 2500 + var_2adad5a67432a282.origin;
            n_speed = 150;
        }
        
        self vehicle_setspeed( n_speed, 20, 10 );
        
        if ( n_speed )
        {
            self setvehgoalpos( v_goal + ( 0, 0, 1200 ), 0 );
        }
        
        wait 1;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x4457
// Size: 0x16a
function function_d58e9fe01994f55()
{
    s_pos = getstruct( "ava_chopper", "targetname" );
    spawndata = spawnstruct();
    spawndata.origin = s_pos.origin;
    spawndata.angles = s_pos.angles;
    spawndata.spawntype = "GAME_MODE";
    spawndata.var_699ac4a9c9e9f0ec = 1;
    spawndata.var_24993ee24f7c7c0 = 1;
    self.ava_chopper = undefined;
    
    while ( true )
    {
        self.ava_chopper = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "veh9_palfa", spawndata );
        
        if ( isdefined( self.ava_chopper ) )
        {
            break;
        }
        
        wait 0.1;
    }
    
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable( self.ava_chopper );
    self.ava_chopper scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setcandamage( 0 );
    self.ava_chopper.playersinside = [];
    self.ava_chopper.var_c9164736baf0694a = [];
    self.ava_chopper.onstartriding = &function_b28cb16c37f8e7b;
    self.ava_chopper.onendriding = &function_5f4563731f3e286f;
    self.ava_chopper.unload_land_offset = 255;
    self.ava_chopper thread function_1b93f9a5bdc20396( s_pos );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x45c9
// Size: 0x14
function function_b28cb16c37f8e7b( player )
{
    thread function_f814294925882e0( player );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x45e5
// Size: 0x123
function function_f814294925882e0( player )
{
    player notify( "endon_enter_walkable_vehicle" );
    player endon( "endon_enter_walkable_vehicle" );
    player endon( "disconnect" );
    player waittill( "entered_vehicle_interior" );
    self.playersinside = function_6d6af8144a5131f1( self.var_c9164736baf0694a, player );
    scripts\mp\outofbounds::enableoobimmunity( player );
    player.var_68b9486f4adbcb62 = 1;
    
    foreach ( player in self.playersinside )
    {
        if ( !istrue( player.var_68b9486f4adbcb62 ) )
        {
            return;
        }
    }
    
    if ( !istrue( self.leaving ) && isdefined( self.playersinside ) && self.playersinside.size == level.players.size )
    {
        if ( isdefined( level.var_54492f7bf0674200.broadcast ) )
        {
            namespace_236d5e32d01e927d::function_dacc8aa0d16e4487( level.players, level.var_54492f7bf0674200.broadcast );
        }
        
        thread function_3c26533e550baeb9();
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x4710
// Size: 0x65
function function_5f4563731f3e286f( player )
{
    player notify( "endon_enter_walkable_vehicle" );
    self.playersinside[ player.guid ] = undefined;
    
    if ( isdefined( player ) && isint( player.oobimmunity ) )
    {
        scripts\mp\outofbounds::disableoobimmunity( player );
    }
    
    player notify( "endon_exfil_inside_vehicle_timer" );
    player.var_68b9486f4adbcb62 = undefined;
    thread function_59e7feccaa753a46( player );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x477d
// Size: 0x6e
function function_59e7feccaa753a46( player, var_45fd392609262a96 )
{
    self endon( "death" );
    
    if ( ( istrue( self.leaving ) || istrue( var_45fd392609262a96 ) ) && !istrue( player.var_68b9486f4adbcb62 ) )
    {
        scripts\cp_mp\utility\game_utility::function_852712268d005332( player, 1, 0.25 );
        player setorigin( self gettagorigin( "tag_seat_7" ) );
        level thread scripts\cp_mp\utility\game_utility::function_852712268d005332( player, 0, 0.25 );
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x47f3
// Size: 0xa1
function function_3c26533e550baeb9()
{
    self endon( "death" );
    s_start = getstruct( "exfil_start", "targetname" );
    s_end = getstruct( s_start.target, "targetname" );
    self vehicle_setspeed( 60, 10, 8 );
    self setvehgoalpos( s_start.origin, 0 );
    self waittill( "goal" );
    self vehicle_setspeed( 100, 10, 8 );
    self setvehgoalpos( s_end.origin, 0 );
    wait 5;
    level notify( "game_ended" );
    level thread function_bf01aba31e9023d1();
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x489c
// Size: 0x131
function function_1b93f9a5bdc20396( s_pos )
{
    self endon( "death" );
    self vehicle_setspeed( 60, 10, 8 );
    s_goal = getstruct( s_pos.target, "targetname" );
    
    while ( isdefined( s_goal ) )
    {
        if ( isdefined( s_goal.script_noteworthy ) && s_goal.script_noteworthy == "land" )
        {
            self vehicle_setspeed( 10, 10, 8 );
            self setvehgoalpos( s_goal.origin, 1 );
            scripts\mp\objidpoolmanager::update_objective_onentity( level.var_54492f7bf0674200.var_4118ca23a8b62b78, self );
            scripts\mp\objidpoolmanager::update_objective_setzoffset( level.var_54492f7bf0674200.var_4118ca23a8b62b78, 48 );
        }
        else
        {
            self setvehgoalpos( s_goal.origin, 0 );
        }
        
        if ( isdefined( s_goal.target ) )
        {
            s_goal = getstruct( s_goal.target, "targetname" );
        }
        else
        {
            s_goal = undefined;
        }
        
        self waittill( "goal" );
    }
    
    namespace_32e74fbed1406ca3::function_5b4245d8e50d6cc3( "Get to the chopper!", level.players, "always", 2000, 1, 1 );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x49d5
// Size: 0x22
function function_b38a73fc6aa9721f( s_quest )
{
    self endon( "death" );
    self waittill( "reached_end_node" );
    level notify( "story_quest_complete_step_4" );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x49ff
// Size: 0xb6
function function_bf01aba31e9023d1()
{
    foreach ( player in level.players )
    {
        setmusicstate( "gameover" );
        player setclientdvar( @"hash_cbb22e2fb1a57873", 1 );
        scripts\mp\gamelogic::processlobbydataforclient( player );
        namespace_cddd3ad399b210ff::processlobbydata();
        scripts\mp\scoreboard::processcommonplayerdataforplayer( player );
        wait 2.5;
        level thread scripts\cp_mp\utility\game_utility::function_852712268d005332( player, 1, 1 );
        thread scripts\mp\gamelogic::endgame( player.team, game[ "end_reason" ][ "objective_completed" ] );
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x4abd
// Size: 0xa0
function wait_watcher( s_spot )
{
    n_dist = squared( s_spot.radius );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( distance2dsquared( s_spot.origin, player.origin ) < n_dist )
            {
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x4b65
// Size: 0x9b
function attack_player( n_radius )
{
    self endon( "death" );
    
    while ( true )
    {
        if ( isdefined( level.players ) && level.players.size )
        {
            player = getclosest( self.origin, level.players );
            
            if ( isalive( player ) )
            {
                if ( !isdefined( n_radius ) )
                {
                    n_radius = distance2d( self.origin, player.origin ) + 100;
                }
                
                self function_65cdab0fc78aba8f( player.origin, n_radius );
            }
        }
        
        wait 5;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x4c08
// Size: 0x151
function function_6a40feac381a035f()
{
    var_607fd6c265fe2a0 = getentarray( "clip_zombie_breach", "targetname" );
    
    foreach ( mdl_clip in var_607fd6c265fe2a0 )
    {
        if ( isdefined( mdl_clip ) && isdefined( mdl_clip.script_noteworthy ) && mdl_clip.script_noteworthy == "breach_exit" )
        {
            playfx( getfx( "c4_explosion" ), mdl_clip.origin );
            playsoundatpos( mdl_clip.origin, "evt_ob_q_object_explo" );
            mdl_clip connectpaths();
            wait 0.1;
            mdl_clip delete();
        }
    }
    
    foreach ( mdl_exit in self.var_2788b7f8dbde803d )
    {
        mdl_exit delete();
    }
    
    s_exp = getstruct( "defend_explosion", "targetname" );
    thread function_db21ab0a6b9e93ee( s_exp, 100 );
    thread ava_spawn();
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x4d61
// Size: 0x7e
function function_cbec893df583aecc()
{
    switch ( level.players.size )
    {
        case 1:
            n_active = 5;
            break;
        case 2:
            n_active = 6;
            break;
        case 3:
            n_active = 8;
            break;
        case 4:
            n_active = 10;
            break;
        default:
            n_active = 13;
            break;
    }
    
    return n_active;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x4de8
// Size: 0x30
function function_ee63d6fa5d4d6e87( n_wave )
{
    n_active = function_cbec893df583aecc();
    n_total = n_active + n_wave * 2 + n_wave;
    return n_total;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x4e21
// Size: 0x33
function function_2cc571d4c77b4052()
{
    self endon( "wave_done" );
    thread function_8313312f00f4badd();
    
    while ( true )
    {
        if ( self.n_mercs < 5 )
        {
            self notify( "wave_done" );
        }
        
        wait 1;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x4e5c
// Size: 0x1f
function function_8313312f00f4badd()
{
    self endon( "wave_done" );
    wait 20;
    
    while ( true )
    {
        self notify( "wave_done" );
        wait 1;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x4e83
// Size: 0x80, Type: bool
function function_b38f0b92e2bc5fdb( attractor, zombie )
{
    if ( distance2dsquared( zombie.origin, attractor.source.origin ) < 1000000 && !isdefined( zombie.is_attacking ) )
    {
        zombie.is_attacking = 1;
        zombie thread attack_player( 1500 );
        return false;
    }
    
    if ( isdefined( zombie.is_attacking ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x4f0c
// Size: 0xd2, Type: bool
function function_3dd03206e8d95f5d( attractor, zombie )
{
    if ( isdefined( level.players ) )
    {
        player = getclosest( zombie.origin, level.players );
        
        if ( isdefined( player ) && distance2dsquared( zombie.origin, player.origin ) < 40000 && isdefined( attractor.var_2adad5a67432a282 ) && !player istouching( attractor.var_2adad5a67432a282 ) && !isdefined( zombie.is_attacking ) )
        {
            zombie.is_attacking = 1;
            zombie thread attack_player( 1500 );
            return false;
        }
    }
    
    if ( isdefined( zombie.is_attacking ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x4fe7
// Size: 0x2d
function zombie_death_watcher( s_quest )
{
    self waittill( "death" );
    
    if ( s_quest.n_zombies )
    {
        s_quest.n_zombies--;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x501c
// Size: 0x7e
function function_d5923ceea7a3af1d()
{
    switch ( level.players.size )
    {
        case 1:
            n_active = 5;
            break;
        case 2:
            n_active = 7;
            break;
        case 3:
            n_active = 10;
            break;
        case 4:
            n_active = 12;
            break;
        default:
            n_active = 12;
            break;
    }
    
    return n_active;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x50a3
// Size: 0x65
function function_dbfe8c600c66f236( s_quest )
{
    self endon( "death" );
    s_quest.var_2adad5a67432a282 waittill( "ambush" );
    
    while ( true )
    {
        if ( distance2dsquared( s_quest.var_2adad5a67432a282.origin, self.origin ) > 5760000 )
        {
            self kill();
        }
        
        wait 0.5;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x5110
// Size: 0x1d, Type: bool
function function_82d4517b0ad36467( data )
{
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage( data );
    self notify( "death" );
    return true;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x5136
// Size: 0x58
function function_20a33aa40305aafc( params )
{
    if ( isdefined( params.eattacker ) && params.eattacker.classname == "misc_turret" )
    {
        return int( params.idamage * 50 );
    }
    
    return params.idamage;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x5197
// Size: 0x18
function on_player_spawned( params )
{
    level flag_set( "player_spawned" );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x51b7
// Size: 0x91, Type: bool
function player_looking_at( start, dot )
{
    if ( !isdefined( dot ) )
    {
        dot = 0.8;
    }
    
    end = self geteye();
    angles = vectortoangles( start - end );
    forward = anglestoforward( angles );
    player_angles = self getplayerangles();
    player_forward = anglestoforward( player_angles );
    new_dot = vectordot( forward, player_forward );
    
    if ( new_dot < dot )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x5251
// Size: 0xa0
function function_254323e1a248db9a( a_s_spawners )
{
    while ( true )
    {
        b_can_see = 0;
        s_spawner = array_random( a_s_spawners );
        
        foreach ( player in level.players )
        {
            if ( player player_looking_at( s_spawner.origin ) )
            {
                b_can_see = 1;
            }
        }
        
        if ( !b_can_see )
        {
            return s_spawner;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x52f9
// Size: 0x117
function function_db21ab0a6b9e93ee( var_4444dee8b3dba8fa, n_radius )
{
    a_doors = [];
    var_99c4d97ba39f21cf = getentitylessscriptablearray( undefined, undefined, var_4444dee8b3dba8fa.origin, n_radius );
    
    foreach ( scriptable in var_99c4d97ba39f21cf )
    {
        if ( isdefined( scriptable.type ) && issubstr( scriptable.type, "door" ) )
        {
            a_doors = function_6d6af8144a5131f1( a_doors, scriptable );
        }
    }
    
    foreach ( door in a_doors )
    {
        if ( door scriptabledoorisclosed() )
        {
            door scriptabledooropen( "away", var_4444dee8b3dba8fa.origin );
        }
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x5418
// Size: 0x12c
function defend_exit()
{
    self waittill( "defend_done" );
    s_exp = getstruct( "defend_explosion", "targetname" );
    playfx( getfx( "c4_explosion" ), s_exp.origin );
    playsoundatpos( s_exp.origin, "evt_ob_q_object_explo" );
    
    foreach ( mdl_clip in self.var_607fd6c265fe2a0 )
    {
        if ( isdefined( mdl_clip ) && isdefined( mdl_clip.script_noteworthy ) && mdl_clip.script_noteworthy == "defend_exit_clip" )
        {
            mdl_clip connectpaths();
            waitframe();
            mdl_clip delete();
        }
    }
    
    foreach ( mdl_exit in self.var_686818ffab148c29 )
    {
        mdl_exit delete();
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x554c
// Size: 0xc1
function ava_spawn()
{
    var_b7c715b0a7324c06 = getstruct( "ava_spawn", "targetname" );
    self.mdl_ava = undefined;
    
    while ( !isdefined( self.mdl_ava ) )
    {
        self.mdl_ava = utility::spawn_model( "body_civ_london_female_3_3", var_b7c715b0a7324c06.origin, var_b7c715b0a7324c06.angles );
        waitframe();
    }
    
    scripts\mp\objidpoolmanager::update_objective_onentity( self.var_4118ca23a8b62b78, self.mdl_ava );
    scripts\mp\objidpoolmanager::update_objective_setzoffset( self.var_4118ca23a8b62b78, 72 );
    namespace_32e74fbed1406ca3::function_5b4245d8e50d6cc3( "Let's go!", level.players, "never", 2000, 1, 1 );
    self.mdl_ava thread function_1a42fd7a576ce0c3( self );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x5615
// Size: 0x14d
function function_1a42fd7a576ce0c3( quest )
{
    wait_watcher( getstruct( "breach_exit_point", "targetname" ) );
    s_goal = getstruct( "ava_comm_pos", "targetname" );
    self moveto( s_goal.origin, 3 );
    self waittill( "movedone" );
    self rotateto( s_goal.angles, 0.5 );
    namespace_32e74fbed1406ca3::function_5b4245d8e50d6cc3( "Commencing the download!  Keep them off me!", level.players, "never", 2000, 1, 1 );
    quest flag_wait( "ava_vehicle_go" );
    namespace_32e74fbed1406ca3::function_5b4245d8e50d6cc3( "Download complete!  Hang tight!", level.players, "never", 2000, 1, 1 );
    s_goal = getstruct( "ava_exit_pos", "targetname" );
    self moveto( s_goal.origin, 1 );
    self waittill( "movedone" );
    s_goal = getstruct( "ava_truck_pos", "targetname" );
    self moveto( s_goal.origin, 5 );
    self waittill( "movedone" );
    namespace_32e74fbed1406ca3::function_5b4245d8e50d6cc3( "Watch out!  Zombie horde!", level.players, "never", 2000, 1, 1 );
    self delete();
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x576a
// Size: 0x25
function function_a250d816c3645ad2( s_quest )
{
    self endon( "death" );
    s_quest waittill( "breached" );
    thread attack_player( 1500 );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x5797
// Size: 0x18e
function skipto_teleport( var_fe068b47c5b8d085, b_start )
{
    if ( !b_start )
    {
        level notify( "skipped" );
        a_s_pos = getstructarray( var_fe068b47c5b8d085, "targetname" );
        
        for ( i = 0; i < a_s_pos.size ; i++ )
        {
            if ( isdefined( level.players[ i ] ) )
            {
                level.players[ i ] thread teleport_player( a_s_pos[ i ], b_start, i );
            }
        }
        
        return;
    }
    
    s_chopper = getstruct( "infil_chopper", "targetname" );
    spawndata = spawnstruct();
    spawndata.origin = s_chopper.origin;
    spawndata.angles = s_chopper.angles;
    spawndata.spawntype = "GAME_MODE";
    spawndata.var_699ac4a9c9e9f0ec = 1;
    spawndata.var_24993ee24f7c7c0 = 1;
    level.var_cdac4dacd44c17c6 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "veh9_palfa", spawndata );
    waitframe();
    level.var_cdac4dacd44c17c6.is_infil = 1;
    level.var_cdac4dacd44c17c6.onstartriding = &function_3321561d55e07c30;
    level.var_cdac4dacd44c17c6.onendriding = &function_453f831fdfcc5dce;
    level.var_cdac4dacd44c17c6 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setcandamage( 0 );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable( level.var_cdac4dacd44c17c6 );
    level.var_cdac4dacd44c17c6 thread function_86b4ca8e83c456e6( s_chopper );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 3
// Checksum 0x0, Offset: 0x592d
// Size: 0xde
function teleport_player( s_pos, b_start, n_index )
{
    self endon( "death" );
    level thread scripts\cp_mp\utility\game_utility::function_852712268d005332( self, 1, 1 );
    
    if ( b_start )
    {
        n_pos = n_index + 4;
        level.var_cdac4dacd44c17c6.team = self.team;
        wait 1;
        self playerlinkto( level.var_cdac4dacd44c17c6, "offset_seat_ai_" + n_pos );
        wait 0.1;
        level.var_cdac4dacd44c17c6 flag_set( "occupied" );
        wait 3;
        self unlink();
        level thread function_ce34466b3cece887( self );
    }
    else
    {
        self setorigin( s_pos.origin );
        self setplayerangles( s_pos.angles );
    }
    
    level thread scripts\cp_mp\utility\game_utility::function_852712268d005332( self, 0, 2 );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x5a13
// Size: 0x175
function function_86b4ca8e83c456e6( s_pos )
{
    self endon( "death" );
    self vehicle_setspeedimmediate( 0, 10, 5 );
    flag_wait( "occupied" );
    wait 1;
    self vehicle_setspeed( 60, 20, 10 );
    
    for ( s_goal = getstruct( s_pos.target, "targetname" ); isdefined( s_goal ) ; s_goal = undefined )
    {
        if ( isdefined( s_goal.script_noteworthy ) && s_goal.script_noteworthy == "land" )
        {
            self setvehgoalpos( s_goal.origin, 1 );
            self waittill( "goal" );
            self vehicle_setspeed( 0, 10, 8 );
            thread function_4d7fd5688d7a03a9();
            
            foreach ( player in level.players )
            {
                scripts\mp\outofbounds::disableoobimmunity( player );
            }
            
            flag_wait( "flyaway" );
            self vehicle_setspeed( 100, 30, 20 );
        }
        else
        {
            self setvehgoalpos( s_goal.origin, 0 );
            self waittill( "goal" );
        }
        
        if ( isdefined( s_goal.target ) )
        {
            s_goal = getstruct( s_goal.target, "targetname" );
            continue;
        }
    }
    
    self delete();
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x5b90
// Size: 0x1e6
function test_rappel()
{
    s_pos = getstruct( "rappel_chopper", "targetname" );
    spawndata = spawnstruct();
    spawndata.origin = s_pos.origin;
    spawndata.angles = s_pos.angles;
    spawndata.initai = 1;
    v_chopper = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "veh_jup_blima", spawndata );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable( v_chopper );
    v_chopper scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setcandamage( 0 );
    v_chopper.callingteam = "team_hundred_ninety";
    v_chopper.unload_land_offset = 255;
    v_chopper.script_disconnectpaths = 1;
    v_chopper.vehiclesetuprope = 1;
    v_chopper.ignorelist = [ v_chopper ];
    v_chopper.var_f585b76d7f472cd9 = [];
    var_4661c9a486253047 = [ "ar", "lmg", "smg" ];
    
    for ( i = 0; i < 5 ; i++ )
    {
        ai_merc = namespace_64135de19550f047::function_5881a353a471bd02( random( var_4661c9a486253047 ), v_chopper.origin, v_chopper.angles, "team_hundred_ninety", 2 );
        
        if ( isdefined( ai_merc ) )
        {
            v_chopper.var_f585b76d7f472cd9[ v_chopper.var_f585b76d7f472cd9.size ] = ai_merc;
        }
        
        waitframe();
    }
    
    v_chopper namespace_5d57e6b81b105f5d::function_35c699c709e24b69( v_chopper.var_f585b76d7f472cd9 );
    s_goal = getstruct( s_pos.target, "targetname" );
    v_chopper vehicle_setspeed( 100, 10, 8 );
    v_chopper setvehgoalpos( s_goal.origin, 1 );
    wait 3;
    v_chopper namespace_5d57e6b81b105f5d::function_9e55d8680a23ec64( s_goal.origin );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x5d7e
// Size: 0x19
function function_3321561d55e07c30( player )
{
    player.var_fa91f7e0c2de5846 = 1;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x5d9f
// Size: 0x18
function function_453f831fdfcc5dce( player )
{
    player.var_fa91f7e0c2de5846 = 0;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x5dbf
// Size: 0x94
function function_4d7fd5688d7a03a9()
{
    self endon( "death" );
    
    while ( true )
    {
        b_inside = 0;
        
        foreach ( player in level.players )
        {
            if ( istrue( player.var_fa91f7e0c2de5846 ) )
            {
                b_inside = 1;
            }
        }
        
        if ( !b_inside )
        {
            flag_set( "flyaway" );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x5e5b
// Size: 0x7e
function function_ab65e0d9a8828ab2()
{
    switch ( level.players.size )
    {
        case 1:
            n_zombies = 20;
            break;
        case 2:
            n_zombies = 24;
            break;
        case 3:
            n_zombies = 28;
            break;
        case 4:
            n_zombies = 32;
            break;
        default:
            n_zombies = 40;
            break;
    }
    
    return n_zombies;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 0
// Checksum 0x0, Offset: 0x5ee2
// Size: 0x7e
function function_20385cfdc216f458()
{
    switch ( level.players.size )
    {
        case 1:
            n_zombies = 8;
            break;
        case 2:
            n_zombies = 9;
            break;
        case 3:
            n_zombies = 11;
            break;
        case 4:
            n_zombies = 12;
            break;
        default:
            n_zombies = 8;
            break;
    }
    
    return n_zombies;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x5f69
// Size: 0x74
function function_3b142e491735475( target )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_97f0985016aa48cb = 0.8;
    turretforward = anglestoforward( self.angles );
    targetdisplace = vectornormalize( target.origin - self gettagorigin( "tag_rocket_right1" ) );
    var_ff53e400dd536b82 = vectordot( turretforward, targetdisplace );
    return var_ff53e400dd536b82 >= var_97f0985016aa48cb;
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 1
// Checksum 0x0, Offset: 0x5fe6
// Size: 0x1f8
function function_ce34466b3cece887( player )
{
    ammo_mods = [ "brainrot", "deadwire", "napalmburst", "cryofreeze", "shatterblast" ];
    perks = [ "specialty_juggernog", "specialty_quickrevive", "specialty_deadshot", "specialty_speedcola", "specialty_elemental_pop", "specialty_death_perception", "specialty_staminup", "specialty_tombstone" ];
    supers = [ "super_aether_shroud", "super_healing_aura", "super_frost_blast", "super_energy_mine", "super_frenzied_guard", "super_tesla_storm" ];
    smg_weapon = "iw9_sm_papa90_mp";
    smg_weapons = [];
    smg_weapons[ "weapon" ] = "iw9_sm_papa90_mp";
    smg_weapons[ "ob_weapon" ] = [ "ob_jup_item_weapon_sm_papa90", "ob_jup_item_weapon_sm_papa90_green", "ob_jup_item_weapon_sm_papa90_blue", "ob_jup_item_weapon_sm_papa90_purple", "ob_jup_item_weapon_sm_papa90_orange" ];
    player scripts\cp_mp\armor::setarmorhealth( self.maxarmorhealth );
    waitframe();
    player scripts\cp_mp\armor::function_9c6e9a6643b6c9a6( 1 );
    waitframe();
    var_e1d199da4592fc05 = randomint( supers.size );
    player scripts\mp\perks\perkpackage::perkpackage_givedebug( supers[ var_e1d199da4592fc05 ] );
    waitframe();
    player scripts\cp_mp\currency::function_3036cef61495210f( "essence", 20000 );
    waitframe();
    fakeitem = spawnstruct();
    max_stock_ammo = weaponmaxammo( smg_weapon );
    item_bundle = getscriptbundle( "itemspawnentry:" + smg_weapons[ "ob_weapon" ][ 1 ] );
    item_scriptable = item_bundle.scriptable;
    fakeitem.count = scripts\cp_mp\loot\common_item::function_7209c8cd4b2e3afd( max_stock_ammo );
    player scripts\cp_mp\loot\common_item::function_7f6f62ba8dfd0da0( item_bundle, fakeitem );
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x61e6
// Size: 0x26
function onvehiclekill( player, vehicle )
{
    var_c9b69aecc5c631ed = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
}

// Namespace namespace_cf011d7d8f1de3ac / namespace_e39de371869cd948
// Params 2
// Checksum 0x0, Offset: 0x6214
// Size: 0x26
function function_c8bcbda102291b17( player, vehicle )
{
    var_c9b69aecc5c631ed = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
}

