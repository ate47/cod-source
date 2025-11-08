#using script_3bdadfff7554ceba;
#using script_4c9bd9a3bf3f8cf7;
#using script_72af5a878a9d3397;
#using scripts\common\progression_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_war;
#using scripts\mp\bots\bots_killstreaks;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\class;
#using scripts\mp\dev;
#using scripts\mp\door;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\menus;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\playerlogic;
#using scripts\mp\supers;
#using scripts\mp\teams;
#using scripts\mp\tweakables;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace bots;

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0xcd1
// Size: 0xbb
function main()
{
    if ( isdefined( level.createfx_enabled ) && level.createfx_enabled )
    {
        return;
    }
    
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    namespace_2c19af30dc7a566c::init();
    setup_callbacks();
    setup_personalities();
    level.badplace_cylinder_func = &badplace_cylinder;
    level.badplace_delete_func = &badplace_delete;
    
    if ( isdefined( level.bot_killstreak_setup_func ) )
    {
        [[ level.bot_killstreak_setup_func ]]();
    }
    else
    {
        bot_killstreak_setup();
    }
    
    level thread init();
    level.var_33463503caca4795 = 1;
    level.var_3342bd64cdf4b028 = 1;
    
    /#
        thread function_dc85300e25bf3deb();
    #/
}

/#

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0xd94
    // Size: 0x9a, Type: dev
    function function_dc85300e25bf3deb()
    {
        level endon( "<dev string:x1c>" );
        
        while ( getdvarint( @"hash_d46f7bf3970382f9" ) == 0 )
        {
            wait 1;
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_c2de8ca6dc8512c1" ) )
            {
                wait 0.05;
                continue;
            }
            
            if ( getdvarint( @"hash_d46f7bf3970382f9" ) != 0 && isdefined( level.players ) && isdefined( level.players[ 0 ] ) )
            {
                function_d59ab5740c283ae3( level.players[ 0 ].origin );
            }
            
            wait 0.05;
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 6
    // Checksum 0x0, Offset: 0xe36
    // Size: 0x1ac, Type: dev
    function draw_box( pos, color, angles, size, alpha, depthtest )
    {
        if ( !isdefined( size ) )
        {
            size = 32;
        }
        
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( depthtest ) )
        {
            depthtest = 0;
        }
        
        forward = anglestoforward( angles );
        right = anglestoright( angles );
        up = anglestoup( angles );
        start = pos + forward * size * 0.5;
        start += right * size * 0.5;
        points = [];
        points[ points.size ] = start;
        points[ points.size ] = points[ points.size - 1 ] + forward * size * -1;
        points[ points.size ] = points[ points.size - 1 ] + right * size * -1;
        points[ points.size ] = points[ points.size - 1 ] + forward * size;
        offset = size * up;
        
        for ( i = 0; i < points.size ; i++ )
        {
            line( points[ i ], points[ i ] + offset, color, alpha, depthtest );
            
            if ( i == points.size - 1 )
            {
                line( points[ i ], points[ 0 ], color, alpha, depthtest );
                line( points[ i ] + offset, points[ 0 ] + offset, color, alpha, depthtest );
                continue;
            }
            
            line( points[ i ], points[ i + 1 ], color, alpha, depthtest );
            line( points[ i ] + offset, points[ i + 1 ] + offset, color, alpha, depthtest );
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 6
    // Checksum 0x0, Offset: 0xfea
    // Size: 0x56, Type: dev
    function drawtraversalbox( pos, color, angles, size, alpha, depthtest )
    {
        pos = ( pos[ 0 ], pos[ 1 ], pos[ 2 ] - size / 2 );
        draw_box( pos, color, angles, size, alpha, depthtest );
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 1
    // Checksum 0x0, Offset: 0x1048
    // Size: 0x201, Type: dev
    function function_bcc5e2c3e16c7934( var_65aa68f5910e096 )
    {
        var_d9d64c0994a5a7f6 = 0;
        navmeshpt = getclosestpointonnavmesh( self.origin );
        
        if ( abs( navmeshpt[ 2 ] - self.origin[ 2 ] ) > 32 || distance2d( navmeshpt, self.origin ) > 32 )
        {
            var_d9d64c0994a5a7f6 = 1;
        }
        
        endnode = undefined;
        
        if ( isdefined( self.target ) )
        {
            endnode = getnode( self.target, "<dev string:x2a>" );
        }
        
        if ( isdefined( endnode ) )
        {
            navmeshpt = getclosestpointonnavmesh( self.origin );
            
            if ( abs( navmeshpt[ 2 ] - self.origin[ 2 ] ) > 32 || distance2d( navmeshpt, self.origin ) > 32 )
            {
                var_d9d64c0994a5a7f6 = 1;
            }
        }
        
        if ( istrue( var_65aa68f5910e096 ) && !var_d9d64c0994a5a7f6 )
        {
            return;
        }
        
        color = ( 0, 1, 0 );
        
        if ( var_d9d64c0994a5a7f6 )
        {
            print3d( self.origin + ( 0, 0, 32 ), self.animscript + "<dev string:x38>", ( 1, 0, 0 ), 1 );
            color = ( 1, 0, 0 );
        }
        else
        {
            print3d( self.origin + ( 0, 0, 32 ), self.animscript, ( 1, 1, 1 ), 1 );
        }
        
        drawtraversalbox( self.origin, color, ( 0, 0, 0 ), 32, 1, 0 );
        
        if ( isdefined( endnode ) )
        {
            line( self.origin, endnode.origin, color, 1, 0 );
            drawtraversalbox( endnode.origin, ( 0.5, 0.5, 0.5 ), ( 0, 0, 0 ), 32, 1, 1 );
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 1
    // Checksum 0x0, Offset: 0x1251
    // Size: 0xde, Type: dev
    function function_d59ab5740c283ae3( origin )
    {
        var_fb2fb6eb30927421 = getdvarint( @"hash_d46f7bf3970382f9" );
        var_65aa68f5910e096 = 0;
        
        if ( var_fb2fb6eb30927421 == -1 )
        {
            var_65aa68f5910e096 = 1;
        }
        
        nodecount = getnodecount();
        
        for ( i = 0; i < nodecount ; i++ )
        {
            node = getnodebyindex( i );
            
            if ( !isdefined( node ) )
            {
                continue;
            }
            
            if ( var_fb2fb6eb30927421 != 1 && !var_65aa68f5910e096 )
            {
                dist = distance( node.origin, origin );
                
                if ( dist > var_fb2fb6eb30927421 )
                {
                    continue;
                }
            }
            
            if ( !isdefined( node.animscript ) || node.animscript == "<dev string:x41>" )
            {
                continue;
            }
            
            node function_bcc5e2c3e16c7934( var_65aa68f5910e096 );
        }
    }

#/

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x1337
// Size: 0x32a
function setup_callbacks()
{
    level.bot_funcs = [];
    level.bot_funcs[ "bots_spawn" ] = &spawn_bots;
    level.bot_funcs[ "bots_add_scavenger_bag" ] = &bot_add_scavenger_bag;
    level.bot_funcs[ "bots_add_to_level_targets" ] = &bot_add_to_bot_level_targets;
    level.bot_funcs[ "bots_remove_from_level_targets" ] = &bot_remove_from_bot_level_targets;
    level.bot_funcs[ "think" ] = &bot_think;
    level.bot_funcs[ "on_killed" ] = &on_bot_killed;
    level.bot_funcs[ "should_do_killcam" ] = &bot_should_do_killcam;
    level.bot_funcs[ "get_attacker_ent" ] = &bot_get_known_attacker;
    level.bot_funcs[ "should_pickup_weapons" ] = &bot_should_pickup_weapons;
    level.bot_funcs[ "on_damaged" ] = &bot_damage_callback;
    level.bot_funcs[ "gametype_think" ] = &default_gametype_think;
    level.bot_funcs[ "leader_dialog" ] = &bot_leader_dialog;
    level.bot_funcs[ "player_spawned" ] = &bot_player_spawned;
    level.bot_funcs[ "should_start_cautious_approach" ] = &should_start_cautious_approach_default;
    level.bot_funcs[ "know_enemies_on_start" ] = &bot_know_enemies_on_start;
    level.bot_funcs[ "bot_get_rank_xp" ] = &bot_get_rank_xp;
    level.bot_funcs[ "ai_3d_sighting_model" ] = &bot_3d_sighting_model;
    level.bot_funcs[ "dropped_weapon_think" ] = &bot_think_seek_dropped_weapons;
    level.bot_funcs[ "dropped_weapon_cancel" ] = &should_stop_seeking_weapon;
    level.bot_funcs[ "crate_can_use" ] = &crate_can_use_always;
    level.bot_funcs[ "crate_low_ammo_check" ] = &crate_low_ammo_check;
    level.bot_funcs[ "crate_should_claim" ] = &crate_should_claim;
    level.bot_funcs[ "crate_wait_use" ] = &crate_wait_use;
    level.bot_funcs[ "crate_in_range" ] = &crate_in_range;
    level.bot_funcs[ "post_teleport" ] = &bot_post_teleport;
    level.bot_funcs[ "bot_set_difficulty" ] = &scripts\mp\bots\bots_util::bot_set_difficulty;
    level.bot_funcs[ "bot_set_personality" ] = &scripts\mp\bots\bots_util::bot_set_personality;
    level.bot_funcs[ "bot_think_watch_enemy" ] = &bot_think_watch_enemy;
    level.bot_funcs[ "bot_think_tactical_goals" ] = &scripts\mp\bots\bots_strategy::bot_think_tactical_goals;
    level.bot_funcs[ "bot_bots_enabled_or_added" ] = &scripts\mp\bots\bots_util::bot_bots_enabled_or_added;
    level.bot_funcs[ "revive_think" ] = &bot_think_revive;
    level.bot_random_path_function = &bot_random_path_default;
    level.bot_find_defend_node_func[ "capture" ] = &find_defend_node_capture;
    level.bot_find_defend_node_func[ "capture_zone" ] = &find_defend_node_capture_zone;
    level.bot_find_defend_node_func[ "protect" ] = &find_defend_node_protect;
    level.bot_find_defend_node_func[ "protect_zone" ] = &find_defend_node_protect_zone;
    level.bot_find_defend_node_func[ "bodyguard" ] = &find_defend_node_bodyguard;
    level.bot_find_defend_node_func[ "patrol" ] = &find_defend_node_patrol;
    scripts\mp\bots\bots_gametype_war::setup_callbacks();
}

// Namespace bots / scripts\mp\bots\bots
// Params 2
// Checksum 0x0, Offset: 0x1669
// Size: 0x49
function codecallback_leaderdialog( dialog, location )
{
    if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs[ "leader_dialog" ] ) )
    {
        self [[ level.bot_funcs[ "leader_dialog" ] ]]( dialog, location );
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x16ba
// Size: 0x8c
function init()
{
    if ( getdvarint( @"hash_abe45e35ef030a56" ) == 0 )
    {
        thread monitor_smoke_grenades();
    }
    
    thread bot_triggers();
    initbotlevelvariables();
    
    /#
        level thread function_cfe352958059570a();
        level thread function_13012f2ebb78e1ab();
        level thread function_fbc3db3d21bb0677();
        level thread function_361fab20102e6557();
        level thread function_c71139dd1c600b64();
        level thread function_8c79a04b049a7ea2();
    #/
    
    if ( !shouldspawnbots() )
    {
        return;
    }
    
    refresh_existing_bots();
    setmatchdata( "hasBots", 1 );
    level thread bot_connect_monitor();
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x174e
// Size: 0xc9
function initbotlevelvariables()
{
    if ( !isdefined( level.crateownerusetime ) )
    {
        level.crateownerusetime = 500;
    }
    
    if ( !isdefined( level.cratenonownerusetime ) )
    {
        level.cratenonownerusetime = 3000;
    }
    
    level.bot_out_of_combat_time = 3000;
    level.bot_respawn_launcher_name = "iw6_panzerfaust3";
    level.bot_fallback_weapon = "iw9_me_knife";
    level.zonecount = getzonecount();
    level.bot_light_volumes = getentarray( "bot_light_area", "targetname" );
    level.bot_dark_volumes = getentarray( "bot_dark_area", "targetname" );
    initbotmapextents();
    level.bot_variables_initialized = 1;
    createthreatbiasgroup( "Bots" );
    setthreatbias( "Killstreak_Static", "Bots", -200 );
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x181f
// Size: 0x22a
function initbotmapextents()
{
    if ( isdefined( level.teleportgetactivenodesfunc ) )
    {
        all_nodes = [[ level.teleportgetactivenodesfunc ]]();
        level.bot_map_min_x = 0;
        level.bot_map_max_x = 0;
        level.bot_map_min_y = 0;
        level.bot_map_max_y = 0;
        level.bot_map_min_z = 0;
        level.bot_map_max_z = 0;
        
        if ( all_nodes.size > 1 )
        {
            level.bot_map_min_x = all_nodes[ 0 ].origin[ 0 ];
            level.bot_map_max_x = all_nodes[ 0 ].origin[ 0 ];
            level.bot_map_min_y = all_nodes[ 0 ].origin[ 1 ];
            level.bot_map_max_y = all_nodes[ 0 ].origin[ 1 ];
            level.bot_map_min_z = all_nodes[ 0 ].origin[ 2 ];
            level.bot_map_max_z = all_nodes[ 0 ].origin[ 2 ];
            
            for ( i = 1; i < all_nodes.size ; i++ )
            {
                node_origin = all_nodes[ i ].origin;
                
                if ( node_origin[ 0 ] < level.bot_map_min_x )
                {
                    level.bot_map_min_x = node_origin[ 0 ];
                }
                
                if ( node_origin[ 0 ] > level.bot_map_max_x )
                {
                    level.bot_map_max_x = node_origin[ 0 ];
                }
                
                if ( node_origin[ 1 ] < level.bot_map_min_y )
                {
                    level.bot_map_min_y = node_origin[ 1 ];
                }
                
                if ( node_origin[ 1 ] > level.bot_map_max_y )
                {
                    level.bot_map_max_y = node_origin[ 1 ];
                }
                
                if ( node_origin[ 2 ] < level.bot_map_min_z )
                {
                    level.bot_map_min_z = node_origin[ 2 ];
                }
                
                if ( node_origin[ 2 ] > level.bot_map_max_z )
                {
                    level.bot_map_max_z = node_origin[ 2 ];
                }
            }
        }
        
        level.bot_map_center = ( ( level.bot_map_min_x + level.bot_map_max_x ) / 2, ( level.bot_map_min_y + level.bot_map_max_y ) / 2, ( level.bot_map_min_z + level.bot_map_max_z ) / 2 );
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x1a51
// Size: 0x28
function bot_post_teleport()
{
    level.bot_variables_initialized = undefined;
    level.bot_initialized_remote_vehicles = undefined;
    initbotmapextents();
    level.bot_variables_initialized = 1;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x1a81
// Size: 0x4, Type: bool
function shouldspawnbots()
{
    return true;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x1a8e
// Size: 0xad
function refresh_existing_bots()
{
    wait 1;
    
    foreach ( player in level.players )
    {
        if ( isbot( player ) )
        {
            if ( isalive( player ) )
            {
                player.equipment_enabled = 1;
                player.bot_team = player.team;
                player.bot_spawned_this_round = 1;
                player thread [[ level.bot_funcs[ "think" ] ]]();
            }
        }
    }
}

/#

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x1b43
    // Size: 0xe2, Type: dev
    function function_cfe352958059570a()
    {
        level endon( "<dev string:x1c>" );
        setdevdvarifuninitialized( @"hash_f4c99c3f45339d3f", "<dev string:x41>" );
        
        while ( true )
        {
            value = getdvar( @"hash_f4c99c3f45339d3f" );
            
            if ( value == "<dev string:x45>" )
            {
                setdevdvar( @"hash_f4c99c3f45339d3f", "<dev string:x41>" );
                var_7cd7a1678123ea91 = getdvarint( @"hash_d1ce2062f6b1971e" );
                var_4155625a9c67e873 = getdvarint( @"hash_f6a053d208e8b550" );
                setdvar( @"hash_d1ce2062f6b1971e", 0 );
                setdvar( @"hash_f6a053d208e8b550", 0 );
                wait 3;
                setdvar( @"hash_d1ce2062f6b1971e", var_7cd7a1678123ea91 );
                setdvar( @"hash_f6a053d208e8b550", var_4155625a9c67e873 );
                wait 3;
            }
            
            wait 0.05;
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x1c2d
    // Size: 0x2a5, Type: dev
    function function_13012f2ebb78e1ab()
    {
        level endon( "<dev string:x1c>" );
        setdevdvarifuninitialized( @"hash_57843b1c39f06368", "<dev string:x41>" );
        setdevdvarifuninitialized( @"hash_f7fec3f23eed8a03", 17 );
        setdevdvarifuninitialized( @"hash_c45117ed6fbd7c31", 6 );
        setdevdvarifuninitialized( @"hash_120407f488061ef3", 180 );
        wait 8;
        
        while ( true )
        {
            if ( getdvarint( @"hash_57843b1c39f06368" ) )
            {
                bots = [];
                
                foreach ( player in level.players )
                {
                    if ( isdefined( player.connected ) && player.connected && isbot( player ) )
                    {
                        bots[ bots.size ] = player;
                    }
                }
                
                var_53f4c70f8f3cb47a = getdvarint( @"hash_f7fec3f23eed8a03" ) - bots.size;
                setdvar( @"scr_testclients", var_53f4c70f8f3cb47a );
                var_b318e813255366ef = getdvarfloat( @"hash_c45117ed6fbd7c31" );
                
                if ( var_b318e813255366ef < 6 )
                {
                    var_b318e813255366ef = 6;
                }
                
                var_a10cf459a45a646d = getdvarfloat( @"hash_120407f488061ef3" );
                
                if ( var_a10cf459a45a646d <= var_b318e813255366ef )
                {
                    var_a10cf459a45a646d = var_b318e813255366ef + 0.05;
                }
                
                time_to_wait = randomfloatrange( var_b318e813255366ef, var_a10cf459a45a646d );
                time_waited = 0;
                
                while ( time_waited < time_to_wait && getdvarint( @"hash_57843b1c39f06368" ) )
                {
                    wait 0.5;
                    time_waited += 0.5;
                }
                
                bots = [];
                
                foreach ( player in level.players )
                {
                    if ( isdefined( player.connected ) && player.connected && isbot( player ) )
                    {
                        bots[ bots.size ] = player;
                    }
                }
                
                bots = array_randomize( bots );
                
                if ( !getdvarint( @"hash_57843b1c39f06368" ) )
                {
                    var_64a2360a43f43d71 = bots.size - 1;
                }
                else
                {
                    var_64a2360a43f43d71 = randomint( bots.size );
                }
                
                for ( i = 0; i <= var_64a2360a43f43d71 ; i++ )
                {
                    bots[ i ] thread bot_drop();
                }
                
                wait 5;
                continue;
            }
            
            wait 0.5;
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x1eda
    // Size: 0x1b3, Type: dev
    function function_fbc3db3d21bb0677()
    {
        level endon( "<dev string:x1c>" );
        
        while ( !bot_bots_enabled_or_added() )
        {
            wait 1;
        }
        
        level.var_3d7b4a188d5de49e = [];
        
        for ( i = 0; i < 10 ; i++ )
        {
            level.var_3d7b4a188d5de49e[ level.var_3d7b4a188d5de49e.size ] = spawnstruct();
        }
        
        level.var_d65b83156825b08c = 0;
        setdevdvarifuninitialized( @"hash_886b3374b1579604", "<dev string:x41>" );
        
        for ( ;; )
        {
            if ( getdvarint( @"hash_c2de8ca6dc8512c1" ) )
            {
                wait 0.05;
                continue;
            }
            
            var_f52bbde72992fec0 = getdvar( @"hash_2113a3b9387cd9f0" );
            function_3b9730a04944204();
            
            if ( var_f52bbde72992fec0 == "<dev string:x4a>" )
            {
                function_16dc1bd6b6c0bc76();
            }
            else if ( var_f52bbde72992fec0 == "<dev string:x54>" )
            {
                function_7403595c45dccd77();
            }
            else if ( var_f52bbde72992fec0 == "<dev string:x63>" )
            {
                function_16dc1bd6b6c0bc76();
                function_7403595c45dccd77();
            }
            else if ( var_f52bbde72992fec0 == "<dev string:x7d>" || var_f52bbde72992fec0 == "<dev string:x91>" )
            {
                function_cabafea737e3a024( var_f52bbde72992fec0 == "<dev string:x7d>" );
            }
            else if ( var_f52bbde72992fec0 == "<dev string:xb3>" )
            {
                function_d862b7eae98dfc13();
            }
            
            if ( getdvar( @"hash_886b3374b1579604" ) != "<dev string:x41>" && level.gametype == "<dev string:xc7>" )
            {
                setdevdvar( @"hash_886b3374b1579604", "<dev string:x41>" );
                human = function_35d942f93b6a3cfe()[ 0 ];
                
                if ( isalive( human ) && human.team != "<dev string:xce>" )
                {
                    level.var_e6522d43cff255f2 = human.origin;
                }
            }
            
            waitframe();
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x2095
    // Size: 0x85, Type: dev
    function function_3b9730a04944204()
    {
        for ( i = 0; i < level.var_d65b83156825b08c ; i++ )
        {
            struct = level.var_3d7b4a188d5de49e[ i ];
            
            if ( isdefined( struct.defense_trigger ) && struct.defense_trigger.classname != "<dev string:xdb>" )
            {
                botdebugdrawtrigger( 0, struct.defense_trigger );
            }
        }
        
        level.var_d65b83156825b08c = 0;
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x2122
    // Size: 0x7c0, Type: dev
    function function_16dc1bd6b6c0bc76()
    {
        assert( level.var_d65b83156825b08c == 0 );
        
        foreach ( player in level.participants )
        {
            if ( !isdefined( player.team ) )
            {
                continue;
            }
            
            if ( player.health > 0 && isai( player ) && player bot_is_defending() )
            {
                var_c54a6a4164e65b87 = undefined;
                
                for ( i = 0; i < level.var_d65b83156825b08c ; i++ )
                {
                    struct = level.var_3d7b4a188d5de49e[ i ];
                    var_92f6621ac1937d99 = struct.defense_type == player.bot_defending_type;
                    var_c88166399eb8890f = isdefined( struct.defense_radius ) && isdefined( player.bot_defending_radius ) && struct.defense_radius == player.bot_defending_radius;
                    var_57b6c8a85ada07f7 = isdefined( struct.defense_trigger ) && isdefined( player.bot_defending_trigger ) && struct.defense_trigger == player.bot_defending_trigger;
                    
                    if ( var_92f6621ac1937d99 && ( var_c88166399eb8890f || var_57b6c8a85ada07f7 ) )
                    {
                        if ( bot_vectors_are_equal( struct.defense_center, player.bot_defending_center ) )
                        {
                            var_c54a6a4164e65b87 = struct;
                            break;
                        }
                    }
                }
                
                if ( isdefined( var_c54a6a4164e65b87 ) )
                {
                    if ( var_c54a6a4164e65b87.defense_team != player.team )
                    {
                        var_c54a6a4164e65b87.cylinder_color = ( 1, 0, 1 );
                    }
                    
                    var_c54a6a4164e65b87.bots = array_add( var_c54a6a4164e65b87.bots, player );
                    continue;
                }
                
                var_f5ba03ba3a641936 = level.var_3d7b4a188d5de49e[ level.var_d65b83156825b08c ];
                level.var_d65b83156825b08c++;
                
                if ( player.team == "<dev string:xed>" )
                {
                    var_f5ba03ba3a641936.cylinder_color = ( 0, 0, 1 );
                }
                else if ( player.team == "<dev string:xf7>" )
                {
                    var_f5ba03ba3a641936.cylinder_color = ( 1, 0, 0 );
                }
                
                var_f5ba03ba3a641936.defense_team = player.team;
                var_f5ba03ba3a641936.defense_type = player.bot_defending_type;
                var_f5ba03ba3a641936.defense_radius = player.bot_defending_radius;
                var_f5ba03ba3a641936.defense_trigger = player.bot_defending_trigger;
                var_f5ba03ba3a641936.defense_center = player.bot_defending_center;
                var_f5ba03ba3a641936.defense_nodes = player.bot_defending_nodes;
                var_f5ba03ba3a641936.bots = [];
                var_f5ba03ba3a641936.bots = array_add( var_f5ba03ba3a641936.bots, player );
            }
        }
        
        var_f41212488bbec5cd = [];
        
        for ( i = 0; i < level.var_d65b83156825b08c ; i++ )
        {
            struct = level.var_3d7b4a188d5de49e[ i ];
            
            if ( isdefined( struct.defense_nodes ) )
            {
                foreach ( node in struct.defense_nodes )
                {
                    bot_draw_cylinder( node.origin, 10, 10, 0.05, undefined, struct.cylinder_color, 1, 4 );
                }
            }
            
            if ( isdefined( struct.defense_trigger ) )
            {
                if ( struct.defense_trigger.classname != "<dev string:xdb>" )
                {
                    botdebugdrawtrigger( 1, struct.defense_trigger, struct.cylinder_color, 1 );
                }
                else
                {
                    bot_draw_cylinder( struct.defense_center, struct.defense_trigger.radius, struct.defense_trigger.height, 0.05, undefined, struct.cylinder_color, 1 );
                }
            }
            
            if ( isdefined( struct.defense_radius ) )
            {
                bot_draw_cylinder( struct.defense_center, struct.defense_radius, 75, 0.05, undefined, struct.cylinder_color, 1 );
            }
            
            foreach ( bot in struct.bots )
            {
                line_color = undefined;
                
                if ( bot.team == "<dev string:xed>" )
                {
                    line_color = ( 0, 0, 1 );
                }
                else if ( bot.team == "<dev string:xf7>" )
                {
                    line_color = ( 1, 0, 0 );
                }
                
                lineend = bot.origin + ( 0, 0, 25 );
                
                if ( isdefined( struct.defense_center ) )
                {
                    linestart = struct.defense_center + ( 0, 0, 25 );
                    line( linestart, lineend, line_color, 1, 1, 1 );
                }
                
                if ( isdefined( bot.bot_defending_override_origin_node ) )
                {
                    var_4a775464ae4eabc0 = ( max( line_color[ 0 ], 0.3 ), max( line_color[ 1 ], 0.3 ), max( line_color[ 2 ], 0.3 ) );
                    line( bot.bot_defending_override_origin_node.origin, lineend, var_4a775464ae4eabc0, 1, 1, 1 );
                    found_struct = undefined;
                    
                    foreach ( var_4e6cf23076d4ce18 in var_f41212488bbec5cd )
                    {
                        if ( var_4e6cf23076d4ce18.node == bot.bot_defending_override_origin_node )
                        {
                            found_struct = var_4e6cf23076d4ce18;
                        }
                    }
                    
                    if ( isdefined( found_struct ) )
                    {
                        if ( found_struct.team != bot.team )
                        {
                            found_struct.color = ( 1, 0.3, 1 );
                        }
                        
                        continue;
                    }
                    
                    var_1f57a365cc453f38 = spawnstruct();
                    var_1f57a365cc453f38.node = bot.bot_defending_override_origin_node;
                    var_1f57a365cc453f38.team = bot.team;
                    var_1f57a365cc453f38.color = var_4a775464ae4eabc0;
                    var_f41212488bbec5cd[ var_f41212488bbec5cd.size ] = var_1f57a365cc453f38;
                }
            }
        }
        
        foreach ( struct in var_f41212488bbec5cd )
        {
            bot_draw_cylinder( struct.node.origin, 7.5, 10, 0.05, undefined, struct.color, 1, 4 );
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x28ea
    // Size: 0x371, Type: dev
    function function_7403595c45dccd77()
    {
        foreach ( player in level.participants )
        {
            if ( player.health > 0 && isai( player ) && isdefined( player.watch_nodes ) )
            {
                node_offset = ( 0, 0, player getplayerviewheight() );
                
                foreach ( node in player.watch_nodes )
                {
                    watch_node_chance = node.watch_node_chance[ player.entity_number ];
                    entrance_color = ( 1 - watch_node_chance, 1, 1 - watch_node_chance );
                    
                    if ( watch_node_chance <= 0.05 )
                    {
                        alpha = 0.1;
                        bot_draw_cylinder( node.origin + ( 0, 0, 30 ), 10, 10, 0.05, undefined, entrance_color, 1, 8, alpha );
                    }
                    else
                    {
                        alpha = 1;
                        bot_draw_cylinder( node.origin + ( 0, 0, 30 ), 10, 10, 0.05, undefined, entrance_color, 1, 4, alpha );
                    }
                    
                    line( player.origin + node_offset, node.origin + ( 0, 0, 35 ), entrance_color, alpha, 1, 1 );
                    
                    if ( isdefined( node.var_b0429a1dfba19038 ) )
                    {
                        print3d( node.origin, int( node.var_b0429a1dfba19038[ player.team ] ), ( 0, 0, 1 ), alpha, 1.1 );
                        print3d( node.origin + ( 0, 0, 10 ), int( node.var_b0429a1dfba19038[ getotherteam( player.team ) ] ), ( 1, 0, 0 ), alpha, 1.1 );
                    }
                }
                
                if ( isdefined( player.var_bfc743b5b4029ae3 ) )
                {
                    offset = ( 0, 0, 60 );
                    playerstance = player getstance();
                    
                    if ( playerstance == "<dev string:xff>" )
                    {
                        offset = ( 0, 0, 40 );
                    }
                    else if ( playerstance == "<dev string:x109>" )
                    {
                        offset = ( 0, 0, 11 );
                    }
                    
                    print3d( player.origin + offset, int( player.var_bfc743b5b4029ae3[ player.team ] ), ( 0, 0, 1 ), 1, 1.1 );
                    print3d( player.origin + offset + ( 0, 0, 10 ), int( player.var_bfc743b5b4029ae3[ getotherteam( player.team ) ] ), ( 1, 0, 0 ), 1, 1.1 );
                }
            }
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 1
    // Checksum 0x0, Offset: 0x2c63
    // Size: 0x2bf, Type: dev
    function function_cabafea737e3a024( var_2f4e4b921733b189 )
    {
        if ( !isdefined( level.entrance_indices ) || !isdefined( level.entrance_points ) )
        {
            return;
        }
        
        node_offset = ( 0, 0, 11 );
        standing_offset = ( 0, 0, 55 );
        var_a2106b5d045f6d6d = ( 0, 0, 40 );
        prone_offset = ( 0, 0, 15 );
        var_c531a6aa175eb24b = ( 0, 1, 0 );
        var_af1aede5178be415 = ( 1, 0, 0 );
        color_visible = var_c531a6aa175eb24b;
        var_39f2bf7b185b408f = var_af1aede5178be415;
        node_height = 13;
        
        for ( i = 0; i < level.entrance_indices.size ; i++ )
        {
            if ( level.entrance_indices.size > 5 )
            {
                color_shift = i % 5 * 50 / 256;
                color_visible = ( var_c531a6aa175eb24b[ 0 ] + color_shift, var_c531a6aa175eb24b[ 1 ], var_c531a6aa175eb24b[ 2 ] + color_shift );
                var_39f2bf7b185b408f = ( var_af1aede5178be415[ 0 ], var_af1aede5178be415[ 1 ] + color_shift, var_af1aede5178be415[ 2 ] + color_shift );
            }
            
            entrance_collection = level.entrance_points[ level.entrance_indices[ i ] ];
            
            for ( j = 0; j < entrance_collection.size ; j++ )
            {
                bot_draw_cylinder( entrance_collection[ j ].origin + node_offset, 10, node_height, 0.05, undefined, color_visible, 1, 4 );
                line( level.entrance_origin_points[ i ] + standing_offset, entrance_collection[ j ].origin + node_offset + ( 0, 0, node_height / 2 ), color_visible, 1, 1, 1 );
                
                if ( var_2f4e4b921733b189 )
                {
                    var_aa19f0e10be1075c = var_39f2bf7b185b408f;
                    
                    if ( entrance_collection[ j ].crouch_visible_from[ level.entrance_indices[ i ] ] )
                    {
                        var_aa19f0e10be1075c = color_visible;
                    }
                    
                    line( level.entrance_origin_points[ i ] + var_a2106b5d045f6d6d, entrance_collection[ j ].origin + node_offset + ( 0, 0, node_height / 2 ), var_aa19f0e10be1075c, 1, 1, 1 );
                    var_aa19f0e10be1075c = var_39f2bf7b185b408f;
                    
                    if ( entrance_collection[ j ].prone_visible_from[ level.entrance_indices[ i ] ] )
                    {
                        var_aa19f0e10be1075c = color_visible;
                    }
                    
                    line( level.entrance_origin_points[ i ] + prone_offset, entrance_collection[ j ].origin + node_offset + ( 0, 0, node_height / 2 ), var_aa19f0e10be1075c, 1, 1, 1 );
                }
            }
            
            bot_draw_cylinder( level.entrance_origin_points[ i ], 10, 75, 0.05, undefined, ( 1, 1, 1 ), 1, 8 );
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x2f2a
    // Size: 0x36e, Type: dev
    function function_d862b7eae98dfc13()
    {
        if ( !isdefined( level.entrance_indices ) || !isdefined( level.precalculated_paths ) )
        {
            return;
        }
        
        node_colors = [ ( 1, 0, 0 ), ( 0, 1, 0 ), ( 0, 0, 1 ), ( 1, 0, 1 ), ( 1, 1, 0 ), ( 0, 1, 1 ), ( 1, 0.6, 0.6 ), ( 0.6, 1, 0.6 ), ( 0.6, 0.6, 1 ), ( 0.1, 0.1, 0.1 ) ];
        
        if ( !isdefined( level.var_c5e41ba5e2338276 ) )
        {
            level.var_6ef6870b0f3a0309 = level.entrance_indices.size - 2;
            level.var_931a3a0c7c522adf = level.entrance_indices.size - 1;
            level.var_c5e41ba5e2338276 = gettime() - 1;
            level.var_3f28269bf89bd1aa = 15000;
        }
        
        if ( gettime() > level.var_c5e41ba5e2338276 )
        {
            for ( var_6d53aae606df92e6 = 1; var_6d53aae606df92e6 ; var_6d53aae606df92e6 = !isdefined( level.precalculated_paths[ level.entrance_indices[ level.var_6ef6870b0f3a0309 ] ][ level.entrance_indices[ level.var_931a3a0c7c522adf ] ] ) )
            {
                if ( level.var_931a3a0c7c522adf == level.entrance_indices.size - 1 )
                {
                    if ( level.var_6ef6870b0f3a0309 == level.entrance_indices.size - 2 )
                    {
                        level.var_6ef6870b0f3a0309 = 0;
                        level.var_f2fd482e96c1d49c = -1;
                    }
                    else
                    {
                        level.var_6ef6870b0f3a0309++;
                    }
                    
                    level.var_931a3a0c7c522adf = level.var_6ef6870b0f3a0309 + 1;
                    continue;
                }
                
                level.var_931a3a0c7c522adf++;
            }
            
            level.var_f2fd482e96c1d49c = ( level.var_f2fd482e96c1d49c + 1 ) % node_colors.size;
            level.var_c5e41ba5e2338276 = gettime() + level.var_3f28269bf89bd1aa;
        }
        
        bot_draw_cylinder( level.entrance_origin_points[ level.var_6ef6870b0f3a0309 ], 10, 75, 0.05, undefined, ( 1, 1, 1 ), 1, 8 );
        bot_draw_cylinder( level.entrance_origin_points[ level.var_931a3a0c7c522adf ], 10, 75, 0.05, undefined, ( 1, 1, 1 ), 1, 8 );
        
        foreach ( node in level.precalculated_paths[ level.entrance_indices[ level.var_6ef6870b0f3a0309 ] ][ level.entrance_indices[ level.var_931a3a0c7c522adf ] ] )
        {
            assert( node node_is_on_path_from_labels( level.entrance_indices[ level.var_6ef6870b0f3a0309 ], level.entrance_indices[ level.var_931a3a0c7c522adf ] ) );
            bot_draw_cylinder( node.origin, 10, 13, 0.05, undefined, node_colors[ level.var_f2fd482e96c1d49c ], 1, 4 );
        }
    }

#/

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x32a0
// Size: 0x4d
function bot_player_spawned()
{
    if ( istrue( self.pers[ #"hash_c2cf97cc1cced6a1" ] ) )
    {
        function_8e439247eeca6302();
    }
    
    if ( isdefined( level.bot_funcs[ "player_spawned_gamemode" ] ) )
    {
        self [[ level.bot_funcs[ "player_spawned_gamemode" ] ]]();
    }
    
    bot_set_loadout_class();
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x32f5
// Size: 0xde
function bot_set_loadout_class()
{
    if ( !isdefined( self.bot_class ) )
    {
        if ( !bot_gametype_chooses_class() )
        {
            while ( !isdefined( level.botloadouts ) || !isdefined( level.botloadouts.initialized ) )
            {
                wait 0.05;
            }
            
            /#
                debugclass = getdvar( @"hash_f126b40c4dd6c2c9", "<dev string:x41>" );
                
                if ( isdefined( debugclass ) && debugclass != "<dev string:x41>" )
                {
                    self.bot_class = debugclass;
                    return;
                }
            #/
            
            if ( isdefined( self.override_class_function ) )
            {
                self.bot_class = [[ self.override_class_function ]]();
            }
            else
            {
                self.bot_class = bot_setup_callback_class();
            }
        }
        else
        {
            self.bot_class = self.class;
        }
    }
    
    self.class = self.bot_class;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x33db
// Size: 0x6c
function watch_players_connecting()
{
    while ( true )
    {
        level waittill( "connected", player );
        
        if ( !isai( player ) && level.players.size > 0 )
        {
            level.players_waiting_to_join = array_add( level.players_waiting_to_join, player );
            childthread bots_notify_on_spawn( player );
            childthread bots_notify_on_disconnect( player );
            childthread bots_remove_from_array_on_notify( player );
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x344f
// Size: 0x36
function bots_notify_on_spawn( player )
{
    player endon( "bots_human_disconnected" );
    
    while ( !array_contains( level.players, player ) )
    {
        wait 0.05;
    }
    
    player notify( "bots_human_spawned" );
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x348d
// Size: 0x22
function bots_notify_on_disconnect( player )
{
    player endon( "bots_human_spawned" );
    player waittill( "disconnect" );
    player notify( "bots_human_disconnected" );
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x34b7
// Size: 0x36
function bots_remove_from_array_on_notify( player )
{
    player waittill_any_2( "bots_human_spawned", "bots_human_disconnected" );
    level.players_waiting_to_join = array_remove( level.players_waiting_to_join, player );
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x34f5
// Size: 0x49
function monitor_pause_spawning()
{
    level.players_waiting_to_join = [];
    childthread watch_players_connecting();
    
    while ( true )
    {
        if ( level.players_waiting_to_join.size > 0 )
        {
            level.pausing_bot_connect_monitor = 1;
        }
        else
        {
            level.pausing_bot_connect_monitor = 0;
        }
        
        wait 0.5;
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x3546
// Size: 0x34, Type: bool
function bot_can_join_team( team )
{
    if ( matchmakinggame() )
    {
        return true;
    }
    
    if ( !level.teambased )
    {
        return true;
    }
    
    if ( scripts\mp\teams::getjointeampermissions( team ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x3583
// Size: 0x3c, Type: bool
function bot_allowed_to_switch_teams()
{
    if ( isdefined( level.bots_disable_team_switching ) && level.bots_disable_team_switching )
    {
        return false;
    }
    
    if ( isdefined( level.matchrules_switchteamdisabled ) && level.matchrules_switchteamdisabled )
    {
        return false;
    }
    
    return true;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x35c8
// Size: 0x2ab
function bot_connect_monitor()
{
    level endon( "game_ended" );
    self notify( "bot_connect_monitor" );
    self endon( "bot_connect_monitor" );
    level.pausing_bot_connect_monitor = 0;
    childthread monitor_pause_spawning();
    childthread bot_monitor_team_limits();
    var_41e7dc4fa58ee542 = 1.5;
    var_29e1cb7568f77e66 = isdefined( level.var_7b37b2193f163b9b );
    devmapaddbotpartymembers();
    
    for ( ;; )
    {
        /#
            if ( getdvarint( @"hash_955d9d2c8102c6bc", -1 ) != -1 )
            {
                error( "<dev string:x112>" );
            }
            
            if ( getdvar( @"hash_9e5da81386e98d36", "<dev string:x14c>" ) != "<dev string:x14c>" )
            {
                error( "<dev string:x157>" );
            }
        #/
        
        if ( level.pausing_bot_connect_monitor )
        {
            scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( var_41e7dc4fa58ee542 );
            continue;
        }
        
        dropbotsifnecessary();
        namespace_c50b30148766aa59::function_cde96c5b28cc69f6();
        new_bots = spawnbotsifnecessary( var_29e1cb7568f77e66 );
        
        for ( i = 0; i < new_bots.size ; i++ )
        {
            if ( new_bots[ i ].team == "free" )
            {
                new_bots[ i ].bot.bot_team = "autoassign";
            }
            else
            {
                new_bots[ i ].bot.bot_team = new_bots[ i ].team;
            }
            
            if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() || scripts\cp_mp\utility\game_utility::function_6910a4c65560c44b() )
            {
                var_5be31bbf808e8d4c = new_bots[ i ].squad;
                new_bots[ i ].bot.bot_squad = var_5be31bbf808e8d4c;
            }
            
            if ( new_bots[ i ].istestclient )
            {
                new_bots[ i ].bot scripts\mp\playerlogic::spawnspectator();
                new_bots[ i ].bot.btestclient = 1;
                new_bots[ i ].bot scripts\mp\menus::autoassign();
                class = "class" + randomint( 3 );
                new_bots[ i ].bot notify( "loadout_class_selected", class );
                new_bots[ i ].bot notify( "luinotifyserver", "class_select", class );
            }
            else
            {
                new_bots[ i ].bot.equipment_enabled = 1;
                new_bots[ i ].bot thread [[ level.bot_funcs[ "think" ] ]]();
            }
            
            new_bots[ i ].bot namespace_92443376a63aa4bd::function_3283fdac29887de();
            new_bots[ i ].bot function_81c6c4218188e7d8();
        }
        
        if ( new_bots.size > 0 )
        {
            level notify( "spawned_bots" );
        }
        
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( var_41e7dc4fa58ee542 );
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x387b
// Size: 0x93
function function_81c6c4218188e7d8()
{
    if ( isdefined( self.xuid ) && self.xuid != "" )
    {
        return;
    }
    
    if ( isdefined( self.var_5876cd9fc14af731 ) && isdefined( self.var_5876cd9fc14af731.xuid ) && self.var_5876cd9fc14af731.xuid != "" )
    {
        self.xuid = self.var_5876cd9fc14af731.xuid;
        return;
    }
    
    self.xuid = self getplayerunoid();
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x3916
// Size: 0x144
function bot_monitor_team_limits()
{
    level endon( "game_ended" );
    self notify( "bot_monitor_team_limits" );
    self endon( "bot_monitor_team_limits" );
    level.bot_max_players_on_team[ "allies" ] = 0;
    level.bot_max_players_on_team[ "axis" ] = 0;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 0.5 );
    var_41e7dc4fa58ee542 = 1.5;
    
    if ( !istrue( level.var_e6628286205f2ea7 ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( istrue( level.hasbots ) )
        {
            level.bot_max_players_on_team[ "allies" ] = 0;
            level.bot_max_players_on_team[ "axis" ] = 0;
            
            foreach ( player in level.players )
            {
                if ( isdefined( player.team ) && ( player.team == "allies" || player.team == "axis" ) )
                {
                    level.bot_max_players_on_team[ player.team ]++;
                }
            }
            
            update_max_players_from_team_agents();
        }
        
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( var_41e7dc4fa58ee542 );
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x3a62
// Size: 0xd2
function update_max_players_from_team_agents()
{
    if ( isdefined( level.agentarray ) && istrue( level.var_96df914b8abdd34f ) )
    {
        foreach ( agent in level.agentarray )
        {
            if ( agent.isactive && isteamparticipant( agent ) && isdefined( agent.team ) && ( agent.team == "allies" || agent.team == "axis" ) )
            {
                level.bot_max_players_on_team[ agent.team ]++;
            }
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x3b3c
// Size: 0x3d
function bot_get_player_team()
{
    if ( isdefined( self.team ) )
    {
        return self.team;
    }
    
    if ( isdefined( self.pers[ "team" ] ) )
    {
        return self.pers[ "team" ];
    }
    
    return undefined;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x3b82
// Size: 0x6f
function bot_get_host_team()
{
    foreach ( player in level.players )
    {
        if ( !isai( player ) && player ishost() )
        {
            return player bot_get_player_team();
        }
    }
    
    return "spectator";
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x3bfa
// Size: 0xab, Type: bool
function bot_get_human_picked_team()
{
    havehost = 0;
    var_3b278e62e61b9ec6 = 0;
    var_7cd77eec8870208d = 0;
    
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            if ( player ishost() )
            {
                havehost = 1;
            }
            
            if ( player_picked_team( player ) )
            {
                var_3b278e62e61b9ec6 = 1;
                
                if ( player ishost() )
                {
                    var_7cd77eec8870208d = 1;
                }
            }
        }
    }
    
    return var_7cd77eec8870208d || var_3b278e62e61b9ec6 && !havehost;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x3cae
// Size: 0x85, Type: bool
function player_picked_team( player )
{
    if ( isdefined( player.team ) && player.team != "spectator" )
    {
        return true;
    }
    
    if ( isdefined( player.spectating_actively ) && player.spectating_actively )
    {
        return true;
    }
    
    if ( player iscodcaster() && isdefined( player.team ) && player.team == "spectator" )
    {
        return true;
    }
    
    return false;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x3d3c
// Size: 0xb0, Type: bool
function bot_get_human_picked_class()
{
    havehost = 0;
    var_3b278e62e61b9ec6 = 0;
    var_7cd77eec8870208d = 0;
    
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            if ( player ishost() )
            {
                havehost = 1;
            }
            
            if ( isdefined( player.class ) )
            {
                var_3b278e62e61b9ec6 = 1;
                
                if ( player ishost() )
                {
                    var_7cd77eec8870208d = 1;
                }
            }
        }
    }
    
    return var_7cd77eec8870208d || var_3b278e62e61b9ec6 && !havehost;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x3df5
// Size: 0xd8
function bot_client_counts()
{
    clientcounts = [];
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( isdefined( player ) && isdefined( player.team ) )
        {
            clientcounts = cat_array_add( clientcounts, "all" );
            clientcounts = cat_array_add( clientcounts, player.team );
            
            if ( isbot( player ) )
            {
                clientcounts = cat_array_add( clientcounts, "bots" );
                clientcounts = cat_array_add( clientcounts, "bots_" + player.team );
                continue;
            }
            
            clientcounts = cat_array_add( clientcounts, "humans" );
            clientcounts = cat_array_add( clientcounts, "humans_" + player.team );
        }
    }
    
    return clientcounts;
}

// Namespace bots / scripts\mp\bots\bots
// Params 2
// Checksum 0x0, Offset: 0x3ed6
// Size: 0x32
function cat_array_add( arraycounts, category )
{
    if ( !isdefined( arraycounts ) )
    {
        arraycounts = [];
    }
    
    if ( !isdefined( arraycounts[ category ] ) )
    {
        arraycounts[ category ] = 0;
    }
    
    arraycounts[ category ] += 1;
    return arraycounts;
}

// Namespace bots / scripts\mp\bots\bots
// Params 2
// Checksum 0x0, Offset: 0x3f11
// Size: 0x26
function cat_array_get( arraycounts, category )
{
    if ( !isdefined( arraycounts ) )
    {
        return 0;
    }
    
    if ( !isdefined( arraycounts[ category ] ) )
    {
        return 0;
    }
    
    return arraycounts[ category ];
}

// Namespace bots / scripts\mp\bots\bots
// Params 4
// Checksum 0x0, Offset: 0x3f40
// Size: 0x118
function move_bots_from_team_to_team( count, teamfrom, teamto, difficulty )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player.team ) )
        {
            continue;
        }
        
        if ( isdefined( player.connected ) && player.connected && isbot( player ) && player.team == teamfrom )
        {
            player.bot_team = teamto;
            
            if ( isdefined( difficulty ) )
            {
                player bot_set_difficulty( difficulty );
            }
            
            player notify( "luinotifyserver", "team_select", bot_lui_convert_team_to_int( teamto ) );
            wait 0.05;
            player notify( "loadout_class_selected", player.bot_class );
            count--;
            
            if ( count <= 0 )
            {
                break;
            }
            
            wait 0.1;
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 2
// Checksum 0x0, Offset: 0x4060
// Size: 0xbe
function bots_update_difficulty( team, difficulty )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player.team ) )
        {
            continue;
        }
        
        if ( isdefined( player.connected ) && player.connected && isbot( player ) && player.team == team )
        {
            if ( difficulty != player botgetdifficulty() )
            {
                player bot_set_difficulty( difficulty );
            }
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x4126
// Size: 0x3d
function bot_drop()
{
    assert( isbot( self ) );
    assert( self.connected );
    kick( self.entity_number, "EXE/PLAYERKICKED_BOT_BALANCE" );
    wait 0.1;
}

// Namespace bots / scripts\mp\bots\bots
// Params 2
// Checksum 0x0, Offset: 0x416b
// Size: 0x134
function drop_bots( count, team )
{
    bots = [];
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.connected ) && player.connected && isbot( player ) && ( !isdefined( team ) || isdefined( player.team ) && player.team == team ) )
        {
            bots[ bots.size ] = player;
        }
    }
    
    for ( i = bots.size - 1; i >= 0 ; i-- )
    {
        if ( count <= 0 )
        {
            break;
        }
        
        if ( !bots[ i ] scripts\cp_mp\utility\player_utility::_isalive() )
        {
            bots[ i ] bot_drop();
            bots = array_remove( bots, bots[ i ] );
            count--;
        }
    }
    
    for ( i = bots.size - 1; i >= 0 ; i-- )
    {
        if ( count <= 0 )
        {
            break;
        }
        
        bots[ i ] bot_drop();
        count--;
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x42a7
// Size: 0x48
function bot_lui_convert_team_to_int( team_name )
{
    if ( team_name == "axis" )
    {
        return 0;
    }
    
    if ( team_name == "allies" )
    {
        return 1;
    }
    
    if ( team_name == "autoassign" || team_name == "random" )
    {
        return 2;
    }
    
    return 3;
}

// Namespace bots / scripts\mp\bots\bots
// Params 3
// Checksum 0x0, Offset: 0x42f7
// Size: 0x161
function spawn_bot_latent( team, botcallback, connecting )
{
    var_f1b03ffe289c1025 = gettime() + 60000;
    
    while ( !self canspawnbotortestclient() )
    {
        if ( gettime() >= var_f1b03ffe289c1025 )
        {
            kick( self.entity_number, "EXE/PLAYERKICKED_BOT_BALANCE" );
            connecting.abort = 1;
            println( "<dev string:x1a3>" );
            return;
        }
        
        wait 0.05;
        
        if ( !isdefined( self ) )
        {
            connecting.abort = 1;
            println( "<dev string:x1d6>" );
            return;
        }
    }
    
    if ( !isdefined( self ) )
    {
        connecting.abort = 1;
        println( "<dev string:x216>" );
        return;
    }
    
    self spawnbotortestclient();
    self.equipment_enabled = 1;
    self.bot_team = team;
    self.bot_squad = connecting.bot_squad;
    
    if ( isdefined( connecting.difficulty ) )
    {
        bot_set_difficulty( connecting.difficulty );
    }
    
    if ( isdefined( connecting.mind_personality ) )
    {
        self.mind_personality = connecting.mind_personality;
    }
    
    if ( isdefined( botcallback ) )
    {
        self [[ botcallback ]]();
    }
    
    self thread [[ level.bot_funcs[ "think" ] ]]();
    connecting.ready = 1;
}

// Namespace bots / scripts\mp\bots\bots
// Params 7
// Checksum 0x0, Offset: 0x4460
// Size: 0x304
function spawn_bots( num_bots, team, botcallback, var_a018df45312ba50f, var_dfc67eaaf62bc0, difficulty, fixedspawndata )
{
    level.var_9bb484946bcc49b2 = 1;
    var_f1b03ffe289c1025 = gettime() + 15000;
    var_821516dc10ec00f0 = [];
    
    for ( squad_index = var_821516dc10ec00f0.size; level.players.size < bot_get_client_limit() && var_821516dc10ec00f0.size < num_bots && gettime() < var_f1b03ffe289c1025 ; squad_index++ )
    {
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 0.05 );
        bot = undefined;
        
        if ( isbotmatchmakingenabled() )
        {
            if ( level.teambased )
            {
                bot = addmpbottoteam( team );
            }
            else
            {
                bot = addmpbottoteam( "none" );
            }
        }
        else
        {
            bot = addbot( "" );
        }
        
        if ( !isdefined( bot ) )
        {
            /#
                if ( gettime() >= var_f1b03ffe289c1025 )
                {
                    println( "<dev string:x256>" );
                }
                else
                {
                    println( "<dev string:x296>" );
                }
            #/
            
            if ( isdefined( var_a018df45312ba50f ) && var_a018df45312ba50f )
            {
                if ( isdefined( var_dfc67eaaf62bc0 ) )
                {
                    self notify( var_dfc67eaaf62bc0 );
                }
                
                return;
            }
            
            scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 1 );
            continue;
        }
        
        connecting = spawnstruct();
        connecting.bot = bot;
        connecting.ready = 0;
        connecting.abort = 0;
        connecting.index = squad_index;
        connecting.difficulty = difficulty;
        var_821516dc10ec00f0[ var_821516dc10ec00f0.size ] = connecting;
        
        if ( isdefined( fixedspawndata ) )
        {
            bot.pers[ #"hash_c2cf97cc1cced6a1" ] = 1;
            bot.pers[ #"fixedspawnorigin" ] = fixedspawndata.origin;
            bot.pers[ #"fixedspawnangles" ] = fixedspawndata.angles;
            
            if ( !isdefined( level.var_6d4b0d324eef7492 ) )
            {
                level.var_6d4b0d324eef7492 = [];
            }
            
            level.var_6d4b0d324eef7492[ level.var_6d4b0d324eef7492.size ] = bot;
        }
        
        connecting.bot thread spawn_bot_latent( team, botcallback, connecting );
    }
    
    /#
        if ( gettime() >= var_f1b03ffe289c1025 )
        {
            println( "<dev string:x2d4>" );
        }
    #/
    
    connectedcomplete = 0;
    var_f1b03ffe289c1025 = gettime() + 60000;
    
    while ( connectedcomplete < var_821516dc10ec00f0.size && gettime() < var_f1b03ffe289c1025 )
    {
        connectedcomplete = 0;
        
        foreach ( connecting in var_821516dc10ec00f0 )
        {
            if ( connecting.ready || connecting.abort )
            {
                connectedcomplete++;
            }
        }
        
        wait 0.05;
    }
    
    if ( isdefined( var_dfc67eaaf62bc0 ) )
    {
        self notify( var_dfc67eaaf62bc0 );
    }
    
    level.var_9bb484946bcc49b2 = undefined;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x476c
// Size: 0x58, Type: bool
function bot_gametype_chooses_team()
{
    if ( matchmakinggame() && self.sessionteam != "none" )
    {
        allow_choice = 0;
    }
    else if ( !matchmakinggame() && !denysystemicteamchoice() && doesmodesupportplayerteamchoice() )
    {
        allow_choice = 1;
    }
    else
    {
        allow_choice = 0;
    }
    
    return !allow_choice;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x47cd
// Size: 0xc, Type: bool
function bot_gametype_chooses_class()
{
    return istrue( level.bots_gametype_handles_class_choice );
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x47e2
// Size: 0x1c, Type: bool
function bot_is_ready_to_spawn()
{
    if ( !isdefined( self.classcallback ) )
    {
        if ( !bot_gametype_chooses_class() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace bots / scripts\mp\bots\bots
// Params 2
// Checksum 0x0, Offset: 0x4807
// Size: 0xa1
function forcebotpos( bot, botteam )
{
    var_a4b90ad02e7922ad = getdvarvector( @"forcedbotspawnvec3" );
    verticalbuffer = 12;
    botspacing = 40;
    
    switch ( botteam )
    {
        case #"hash_5f54b9bf7583687f":
            bot setorigin( var_a4b90ad02e7922ad + ( bot.var_5ce930ab383b8a15 * botspacing * -1, 0, verticalbuffer ) );
            break;
        case #"hash_7c2d091e6337bf54":
            bot setorigin( var_a4b90ad02e7922ad + ( bot.var_5ce930ab383b8a15 * botspacing, 0, verticalbuffer ) );
            break;
    }
}

/#

    // Namespace bots / scripts\mp\bots\bots
    // Params 1
    // Checksum 0x0, Offset: 0x48b0
    // Size: 0x141, Type: dev
    function function_84fead845cc1c1ff( var_c9176bb4dce2c995 )
    {
        hostplayer = function_35d942f93b6a3cfe()[ 0 ];
        setspawnweap = 0;
        botweapon = var_c9176bb4dce2c995 getcurrentweapon();
        playerweapon = hostplayer getcurrentweapon();
        
        if ( isdefined( playerweapon ) && botweapon != playerweapon )
        {
            if ( var_c9176bb4dce2c995 isreloading() )
            {
                wait 3;
                var_c9176bb4dce2c995 takeallweapons();
                var_c9176bb4dce2c995 scripts\mp\class::loadout_updateplayer( hostplayer.var_240e299e201c6a39, hostplayer.classstruct, hostplayer.class, setspawnweap, 0 );
            }
            else
            {
                var_c9176bb4dce2c995 takeallweapons();
                var_c9176bb4dce2c995 scripts\mp\class::loadout_updateplayer( hostplayer.var_240e299e201c6a39, hostplayer.classstruct, hostplayer.class, setspawnweap, 0 );
            }
        }
        
        if ( getdvarint( @"hash_17bb7ff71c139bfe" ) )
        {
            var_c0afad358ef6d08 = hostplayer.operatorcustomization.skinref;
            setdvar( @"hash_803cefdbe23f6bfe", var_c0afad358ef6d08 );
        }
        else
        {
            var_c0afad358ef6d08 = getdvar( @"hash_803cefdbe23f6bfe" );
        }
        
        if ( var_c9176bb4dce2c995.operatorcustomization.skinref != var_c0afad358ef6d08 )
        {
            var_c9176bb4dce2c995 scripts\mp\teams::createoperatorcustomization();
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 1
    // Checksum 0x0, Offset: 0x49f9
    // Size: 0x89d, Type: dev
    function function_214bc4c1c6c204d2( var_c9176bb4dce2c995 )
    {
        self endon( "<dev string:x2f3>" );
        self endon( "<dev string:x301>" );
        hostplayer = function_35d942f93b6a3cfe()[ 0 ];
        level.var_f55a78de40f16b44 = 1;
        function_9a9702fa32785f74( var_c9176bb4dce2c995 );
        stancetype = [ "<dev string:x30a>", "<dev string:x31d>", "<dev string:x32f>", "<dev string:x340>", "<dev string:x35b>", "<dev string:x36e>", "<dev string:x382>" ];
        
        switch ( stancetype[ ( var_c9176bb4dce2c995.var_5ce930ab383b8a15 - 1 ) % 7 ] )
        {
            case #"hash_f0b12bd1282d46ee":
                if ( var_c9176bb4dce2c995.bot_team == "<dev string:xed>" )
                {
                    var_c9176bb4dce2c995 setorigin( ( -978, -638, 132 ) );
                }
                else
                {
                    var_c9176bb4dce2c995 setorigin( ( -1140, -638, 132 ) );
                }
                
                break;
            case #"hash_f4e2152a6151d486":
                if ( var_c9176bb4dce2c995.bot_team == "<dev string:xed>" )
                {
                    var_c9176bb4dce2c995 setorigin( ( -569, -518, 132 ) );
                }
                else
                {
                    var_c9176bb4dce2c995 setorigin( ( -500, -518, 132 ) );
                }
                
                break;
            case #"hash_f07871b4fc312ea4":
                if ( var_c9176bb4dce2c995.bot_team == "<dev string:xed>" )
                {
                    var_c9176bb4dce2c995 setorigin( ( -425, -518, 132 ) );
                }
                else
                {
                    var_c9176bb4dce2c995 setorigin( ( -350, -518, 132 ) );
                }
                
                break;
            case #"hash_86607b8541f5dee5":
                if ( var_c9176bb4dce2c995.bot_team == "<dev string:xed>" )
                {
                    var_c9176bb4dce2c995 setorigin( ( -1575, 279, 130 ) );
                }
                else
                {
                    var_c9176bb4dce2c995 setorigin( ( -290, -518, 132 ) );
                }
                
                break;
            case #"hash_36b8a15fa0645e0f":
                if ( var_c9176bb4dce2c995.bot_team == "<dev string:xed>" )
                {
                    var_c9176bb4dce2c995 setorigin( ( -1675, 279, 130 ) );
                }
                
                break;
        }
        
        while ( true )
        {
            wait 3;
            setspawnweap = 0;
            botweapon = var_c9176bb4dce2c995 getcurrentweapon();
            playerweapon = hostplayer getcurrentweapon();
            function_84fead845cc1c1ff( var_c9176bb4dce2c995 );
            
            switch ( stancetype[ ( var_c9176bb4dce2c995.var_5ce930ab383b8a15 - 1 ) % 7 ] )
            {
                case #"hash_f0b12bd1282d46ee":
                    if ( var_c9176bb4dce2c995.bot_team == "<dev string:xed>" )
                    {
                        var_c9176bb4dce2c995 setplayerangles( ( 0, 90, 0 ) );
                        var_c9176bb4dce2c995 botsetstance( "<dev string:x39b>" );
                        var_c9176bb4dce2c995 givemaxammo( botweapon );
                        var_c9176bb4dce2c995 setweaponammostock( botweapon, 300, 1 );
                        var_c9176bb4dce2c995 botpressbutton( "<dev string:x3a4>" );
                        var_c9176bb4dce2c995 forcereloading();
                    }
                    else
                    {
                        var_c9176bb4dce2c995 setplayerangles( ( 0, 90, 0 ) );
                        var_c9176bb4dce2c995 givemaxammo( botweapon );
                        var_c9176bb4dce2c995 botpressbutton( "<dev string:x3a4>", 30 );
                        var_c9176bb4dce2c995 botsetstance( "<dev string:x39b>" );
                    }
                    
                    break;
                case #"hash_f4e2152a6151d486":
                    if ( var_c9176bb4dce2c995.bot_team == "<dev string:xed>" )
                    {
                        var_c9176bb4dce2c995 setplayerangles( ( 0, 90, 0 ) );
                        var_c9176bb4dce2c995 botsetstance( "<dev string:x109>" );
                        wait 3;
                        var_c9176bb4dce2c995 botsetstance( "<dev string:x39b>" );
                    }
                    else
                    {
                        var_c9176bb4dce2c995 setplayerangles( ( 0, 90, 0 ) );
                        var_c9176bb4dce2c995 botsetstance( "<dev string:xff>" );
                        wait 3;
                        var_c9176bb4dce2c995 botsetstance( "<dev string:x39b>" );
                    }
                    
                    break;
                case #"hash_f07871b4fc312ea4":
                    if ( var_c9176bb4dce2c995.bot_team == "<dev string:xed>" )
                    {
                        var_c9176bb4dce2c995 setplayerangles( ( 0, 90, 0 ) );
                        var_c9176bb4dce2c995 botpressbutton( "<dev string:x3ae>" );
                    }
                    else
                    {
                        var_c9176bb4dce2c995 setplayerangles( ( 0, 90, 0 ) );
                        var_c9176bb4dce2c995 botpressbutton( "<dev string:x3b7>" );
                    }
                    
                    break;
                case #"hash_86607b8541f5dee5":
                    if ( var_c9176bb4dce2c995.bot_team == "<dev string:xed>" )
                    {
                        wait 1;
                        objweapon = hostplayer.offhandweapon.basename;
                        var_c9176bb4dce2c995 giveandfireoffhand( objweapon );
                        wait 2;
                        superweaponname = level.superglobals.staticsuperdata[ hostplayer.loadoutfieldupgrade1 ].weapon;
                        
                        if ( !isdefined( superweaponname ) )
                        {
                            superweaponname = "<dev string:x3bf>";
                        }
                        
                        superweapon = makeweapon( superweaponname );
                        var_c9176bb4dce2c995 scripts\mp\perks\perkpackage::perkpackage_givedebug( "<dev string:x3d3>" );
                        
                        if ( isdefined( var_c9176bb4dce2c995.super ) )
                        {
                            if ( !isnullweapon( superweapon ) && superweapon.basename != "<dev string:x3bf>" )
                            {
                                var_c9176bb4dce2c995 giveandfireoffhandreliable( superweapon );
                            }
                            
                            var_c9176bb4dce2c995 thread scripts\mp\supers::trysuperusebegin( superweapon );
                        }
                    }
                    else
                    {
                        var_c9176bb4dce2c995 setplayerangles( ( 0, 90, 0 ) );
                        var_c9176bb4dce2c995 botpressbutton( "<dev string:x3e6>", 2.5 );
                    }
                    
                    break;
                case #"hash_c74bdb650448859e":
                    if ( var_c9176bb4dce2c995.bot_team == "<dev string:xed>" )
                    {
                        var_c9176bb4dce2c995 botsetstance( "<dev string:x39b>" );
                        waitframe();
                        var_c9176bb4dce2c995 botsetscriptgoal( ( 359, -421, 130 ), 5, "<dev string:x3f1>", undefined, undefined );
                        var_c9176bb4dce2c995 waittill_any_2( "<dev string:x3fd>", "<dev string:x405>" );
                        var_c9176bb4dce2c995 botlookatpoint( ( 361, -531, 130 ), 3 );
                        var_c9176bb4dce2c995 forcemantle();
                        wait 1;
                        var_c9176bb4dce2c995 botsetscriptgoal( ( 363, -483, 170 ), 10, "<dev string:x3f1>", undefined, undefined );
                    }
                    else
                    {
                        var_c9176bb4dce2c995 botsetflag( "<dev string:x411>", 1 );
                        var_c9176bb4dce2c995 botsetflag( "<dev string:x421>", 1 );
                        var_c9176bb4dce2c995 botsetscriptgoal( ( -867, 355, 130 ), 10, "<dev string:x3f1>", undefined, undefined );
                        var_c9176bb4dce2c995 waittill_any_2( "<dev string:x3fd>", "<dev string:x405>" );
                        var_c9176bb4dce2c995 botsetscriptgoal( ( -540, 355, 130 ), 10, "<dev string:x3f1>", undefined, undefined );
                        var_c9176bb4dce2c995 waittill_any_2( "<dev string:x3fd>", "<dev string:x405>" );
                    }
                    
                    break;
                case #"hash_284de335e850af7a":
                    if ( var_c9176bb4dce2c995.bot_team == "<dev string:xed>" )
                    {
                        var_c9176bb4dce2c995 botsetscriptgoal( ( 969, -198, 130 ), 10, "<dev string:x3f1>", undefined, undefined );
                        var_c9176bb4dce2c995 waittill_any_2( "<dev string:x3fd>", "<dev string:x405>" );
                        var_c9176bb4dce2c995 botlookatpoint( ( 1054, -200, 266 ), 3 );
                        var_c9176bb4dce2c995 botsetscriptgoal( ( 1027, -201, 266 ), 10, "<dev string:x3f1>", undefined, undefined );
                        var_c9176bb4dce2c995 waittill_any_2( "<dev string:x3fd>", "<dev string:x405>" );
                    }
                    else
                    {
                        var_c9176bb4dce2c995 setorigin( ( 1012, 358, 130 ) );
                        var_c9176bb4dce2c995 botsetstance( "<dev string:x39b>" );
                        var_c9176bb4dce2c995 botlookatpoint( ( 1008, 438, 130 ), 3 );
                        var_c9176bb4dce2c995 botpressbutton( "<dev string:x444>", 2 );
                        wait 3;
                        var_c9176bb4dce2c995 botlookatpoint( ( 1007, 350, 378 ), 3 );
                        var_c9176bb4dce2c995 botpressbutton( "<dev string:x444>", 2 );
                        wait 3;
                    }
                    
                    break;
                case #"hash_36b8a15fa0645e0f":
                    if ( var_c9176bb4dce2c995.bot_team == "<dev string:xed>" )
                    {
                        wait 1;
                        objweapon1 = hostplayer.offhandinventory[ 1 ].basename;
                        var_c9176bb4dce2c995 giveandfireoffhand( objweapon1 );
                    }
                    else
                    {
                        var_c9176bb4dce2c995 allowprone( 1 );
                        var_c9176bb4dce2c995 botsetstance( "<dev string:x39b>" );
                        var_c9176bb4dce2c995 botsetscriptgoal( ( -867, 199, 130 ), 10, "<dev string:x3f1>", undefined, undefined );
                        wait 1;
                        var_c9176bb4dce2c995 botsetstance( "<dev string:x109>" );
                        wait 0.5;
                        var_c9176bb4dce2c995 botsetstance( "<dev string:x39b>" );
                        var_c9176bb4dce2c995 waittill_any_2( "<dev string:x3fd>", "<dev string:x405>" );
                        var_c9176bb4dce2c995 botsetscriptgoal( ( -540, 199, 130 ), 10, "<dev string:x3f1>", undefined, undefined );
                        var_c9176bb4dce2c995 botsetflag( "<dev string:x411>", 1 );
                        wait 1;
                        var_c9176bb4dce2c995 botsetstance( "<dev string:x109>" );
                        wait 0.5;
                        var_c9176bb4dce2c995 botsetstance( "<dev string:x39b>" );
                        var_c9176bb4dce2c995 waittill_any_2( "<dev string:x3fd>", "<dev string:x405>" );
                    }
                    
                    break;
            }
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x529e
    // Size: 0x5, Type: dev
    function function_6a932d3bcaaa7623()
    {
        
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 1
    // Checksum 0x0, Offset: 0x52ab
    // Size: 0xa0, Type: dev
    function function_9a9702fa32785f74( bot )
    {
        bot setplayerangles( ( 0, 266, 0 ) );
        bot endon( "<dev string:x301>" );
        bot botsetflag( "<dev string:x44b>", 1 );
        bot botsetflag( "<dev string:x462>", 1 );
        bot botsetawareness( 0 );
        bot botsetflag( "<dev string:x472>", 1 );
        bot botsetflag( "<dev string:x488>", 1 );
        bot.personality_update_function = &function_6a932d3bcaaa7623;
        setdvar( @"hash_91a24c408f08888b", 1 );
        setdvar( @"bot_notarget", 1 );
    }

#/

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x5353
// Size: 0x4a1
function bot_think()
{
    self notify( "bot_think" );
    self endon( "bot_think" );
    self endon( "disconnect" );
    
    while ( !isdefined( self.pers[ "team" ] ) )
    {
        wait 0.05;
    }
    
    level.hasbots = 1;
    
    if ( bot_gametype_chooses_team() )
    {
        self.bot_team = self.pers[ "team" ];
    }
    
    team = self.bot_team;
    
    if ( !isdefined( team ) )
    {
        team = self.pers[ "team" ];
    }
    
    self.entity_number = self getentitynumber();
    firstspawn = 0;
    
    if ( !isdefined( self.bot_spawned_this_round ) )
    {
        firstspawn = 1;
        self.bot_spawned_this_round = 1;
        
        if ( !bot_gametype_chooses_team() )
        {
            var_4ec7f123b211e7be = self.pers[ "team" ] != "spectator" && !isdefined( self.bot_team );
            
            if ( !var_4ec7f123b211e7be )
            {
                var_e7fe0e101285e7e2 = isdefined( self.bot_team ) && self.bot_team != self.pers[ "team" ];
                
                if ( var_e7fe0e101285e7e2 )
                {
                    self notify( "luinotifyserver", "team_select", bot_lui_convert_team_to_int( team ) );
                }
                
                wait 0.5;
                
                if ( self.pers[ "team" ] == "spectator" )
                {
                    bot_drop();
                    return;
                }
            }
        }
    }
    
    while ( true )
    {
        bot_set_difficulty( self botgetdifficulty() );
        self.difficulty = self botgetdifficulty();
        var_631a8deab6ab2901 = self botgetdifficultysetting( "advancedPersonality" );
        
        if ( firstspawn && isdefined( var_631a8deab6ab2901 ) && var_631a8deab6ab2901 != 0 )
        {
            bot_balance_personality();
        }
        
        /#
            function_70008d3ab47d171d();
        #/
        
        bot_assign_personality_functions();
        self.enemyselector = %"hash_7508743687e8fab9";
        
        if ( firstspawn )
        {
            if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs[ "class_select_override" ] ) )
            {
                self [[ level.bot_funcs[ "class_select_override" ] ]]();
            }
            else
            {
                bot_set_loadout_class();
                
                if ( !bot_gametype_chooses_class() )
                {
                    if ( isdefined( self.connecttime ) && self.connecttime == gettime() )
                    {
                        waittillframeend();
                        waittillframeend();
                    }
                    
                    self notify( "loadout_class_selected", self.bot_class );
                }
            }
            
            if ( self.health == 0 )
            {
                self.bwaitingforteamselect = 1;
                self notify( "bot_ready_to_spawn" );
                self waittill( "spawned_player" );
                self.bwaitingforteamselect = undefined;
                self.bot_team = team;
            }
            
            if ( scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73() || scripts\cp_mp\utility\game_utility::function_6910a4c65560c44b() )
            {
                var_27eb9f95564a944d = "botsight_mgl_br";
            }
            else
            {
                var_27eb9f95564a944d = "botsight";
            }
            
            self function_95d5375059c2a022( var_27eb9f95564a944d, 1 );
            
            if ( !threatbiasgroupexists( "Bots" ) )
            {
                createthreatbiasgroup( "Bots" );
            }
            
            self setthreatbiasgroup( "Bots" );
            
            if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs[ "know_enemies_on_start" ] ) )
            {
                self thread [[ level.bot_funcs[ "know_enemies_on_start" ] ]]();
            }
            
            firstspawn = 0;
            self.var_5ce930ab383b8a15 = 1;
            
            if ( getdvarint( @"scr_botphalanx" ) > 0 )
            {
                if ( team == "axis" )
                {
                    self.var_5ce930ab383b8a15 = level.var_33463503caca4795;
                    level.var_33463503caca4795++;
                }
                else
                {
                    self.var_5ce930ab383b8a15 = level.var_3342bd64cdf4b028;
                    level.var_3342bd64cdf4b028++;
                }
            }
            
            if ( !istrue( gameflag( "prematch_done" ) ) && getdvarint( @"scr_forcedposbotspawn" ) > 0 )
            {
                level waittill( "prematch_over" );
                forcebotpos( self, team );
                
                /#
                    if ( getdvarint( @"hash_8d557dac00cc7997" ) > 0 )
                    {
                        function_214bc4c1c6c204d2( self );
                    }
                #/
            }
        }
        
        bot_modify_behavior_from_tweakables();
        bot_restart_think_threads();
        wait 0.1;
        
        if ( isalive( self ) )
        {
            self waittill( "death" );
        }
        
        if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs[ "post_death_func" ] ) )
        {
            self [[ level.bot_funcs[ "post_death_func" ] ]]();
        }
        
        respawn_watcher();
        self waittill( "spawned_player" );
        
        if ( getdvarint( @"scr_forcedposbotspawn" ) > 0 )
        {
            forcebotpos( self, team );
            
            /#
                if ( getdvarint( @"hash_8d557dac00cc7997" ) > 0 )
                {
                    function_214bc4c1c6c204d2( self );
                }
            #/
        }
        
        /#
            if ( getdvarint( @"hash_f5a9982eaa189f7b" ) > 0 )
            {
                scripts\mp\dev::function_6033c33f117d9dc4( self );
            }
        #/
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x57fc
// Size: 0x23
function bot_modify_behavior_from_tweakables()
{
    if ( scripts\mp\tweakables::gettweakablevalue( "game", "onlyheadshots" ) )
    {
        self botsetflag( "only_headshots", 1 );
    }
}

/#

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x5827
    // Size: 0x36, Type: dev
    function function_70008d3ab47d171d()
    {
        debug_personality = getdvar( @"hash_ef7ffe5706136ad9", "<dev string:x14c>" );
        
        if ( debug_personality != "<dev string:x14c>" )
        {
            bot_set_personality( debug_personality );
        }
    }

#/

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x5865
// Size: 0x87
function respawn_watcher()
{
    self endon( "started_spawnPlayer" );
    
    while ( !self.waitingtospawn )
    {
        wait 0.05;
    }
    
    if ( scripts\mp\playerlogic::needsbuttontorespawn() )
    {
        while ( self.waitingtospawn )
        {
            if ( self.sessionstate == "spectator" )
            {
                if ( getdvarint( @"numlives" ) == 0 || self.pers[ "lives" ] > 0 )
                {
                    self botpressbutton( "use", 0.5 );
                }
            }
            
            wait 1;
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x58f4
// Size: 0xd0
function bot_get_rank_xp()
{
    difficulty = self botgetdifficulty();
    persname = "bot_rank_" + difficulty;
    
    if ( isdefined( self.pers[ persname ] ) && self.pers[ persname ] > 0 )
    {
        return self.pers[ persname ];
    }
    
    desiredranks = bot_random_ranks_for_difficulty( difficulty );
    rank = desiredranks[ "rank" ];
    prestige = desiredranks[ "prestige" ];
    minxp = getrankinfominxp( rank );
    maxxp = minxp + getrankinfoxpamt( rank );
    rankxp = randomintrange( minxp, maxxp + 1 );
    self.pers[ persname ] = rankxp;
    return rankxp;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x59cd
// Size: 0x14
function bot_3d_sighting_model( associatedent )
{
    thread bot_3d_sighting_model_thread( associatedent );
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x59e9
// Size: 0x9c
function bot_3d_sighting_model_thread( associatedent )
{
    associatedent endon( "disconnect" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_c2de8ca6dc8512c1" ) )
            {
                wait 0.05;
                continue;
            }
        #/
        
        if ( isalive( self ) && !self botcanseeentity( associatedent ) && within_fov( self.origin, self getplayerangles(), associatedent.origin, self botgetfovdot() ) )
        {
            self botgetimperfectenemyinfo( associatedent, associatedent.origin );
        }
        
        wait 0.1;
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x5a8d
// Size: 0x279
function bot_random_ranks_for_difficulty( difficulty )
{
    result = [];
    result[ "rank" ] = 0;
    result[ "prestige" ] = 0;
    
    if ( difficulty == "default" )
    {
        return result;
    }
    
    if ( !isdefined( level.bot_rnd_rank ) )
    {
        level.bot_rnd_rank = [];
        level.bot_rnd_rank[ "recruit" ][ 0 ] = 0;
        level.bot_rnd_rank[ "recruit" ][ 1 ] = 1;
        level.bot_rnd_rank[ "regular" ][ 0 ] = 3;
        level.bot_rnd_rank[ "regular" ][ 1 ] = 18;
        level.bot_rnd_rank[ "hardened" ][ 0 ] = 22;
        level.bot_rnd_rank[ "hardened" ][ 1 ] = 38;
        level.bot_rnd_rank[ "veteran" ][ 0 ] = 40;
        level.bot_rnd_rank[ "veteran" ][ 1 ] = 54;
    }
    
    assertex( level.bot_rnd_rank[ "<dev string:x49a>" ][ 1 ] == level.maxstandardrank, "<dev string:x4a5>" );
    
    if ( !isdefined( level.bot_rnd_prestige ) )
    {
        level.bot_rnd_prestige = [];
        level.bot_rnd_prestige[ "recruit" ][ 0 ] = 0;
        level.bot_rnd_prestige[ "recruit" ][ 1 ] = 0;
        level.bot_rnd_prestige[ "regular" ][ 0 ] = 0;
        level.bot_rnd_prestige[ "regular" ][ 1 ] = 0;
        level.bot_rnd_prestige[ "hardened" ][ 0 ] = 0;
        level.bot_rnd_prestige[ "hardened" ][ 1 ] = 0;
        level.bot_rnd_prestige[ "veteran" ][ 0 ] = 0;
        level.bot_rnd_prestige[ "veteran" ][ 1 ] = 9;
    }
    
    assert( isdefined( level.bot_rnd_rank[ difficulty ][ 0 ] ) && isdefined( level.bot_rnd_rank[ difficulty ][ 1 ] ) );
    result[ "rank" ] = randomintrange( level.bot_rnd_rank[ difficulty ][ 0 ], level.bot_rnd_rank[ difficulty ][ 1 ] + 1 );
    assert( isdefined( level.bot_rnd_prestige[ difficulty ][ 0 ] ) && isdefined( level.bot_rnd_prestige[ difficulty ][ 1 ] ) );
    result[ "prestige" ] = randomintrange( level.bot_rnd_prestige[ difficulty ][ 0 ], level.bot_rnd_prestige[ difficulty ][ 1 ] + 1 );
    return result;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x5d0f
// Size: 0xd, Type: bool
function function_9bd84cede4fe8f24( crate )
{
    return true;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x5d25
// Size: 0x34, Type: bool
function crate_can_use_always( crate )
{
    if ( isagent( self ) && !isdefined( crate.boxtype ) )
    {
        return false;
    }
    
    if ( !function_9bd84cede4fe8f24( crate ) )
    {
        return false;
    }
    
    return true;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x5d62
// Size: 0x9d
function get_human_player()
{
    result = undefined;
    players = getentarray( "player", "classname" );
    
    if ( isdefined( players ) )
    {
        for ( index = 0; index < players.size ; index++ )
        {
            if ( isdefined( players[ index ] ) && isdefined( players[ index ].connected ) && players[ index ].connected && !isai( players[ index ] ) && ( !isdefined( result ) || result.team == "spectator" ) )
            {
                result = players[ index ];
            }
        }
    }
    
    return result;
}

/#

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x5e08
    // Size: 0x80, Type: dev
    function function_35d942f93b6a3cfe()
    {
        humans = [];
        
        foreach ( player in level.players )
        {
            if ( player.connected && !isai( player ) )
            {
                humans = array_add( humans, player );
            }
        }
        
        return humans;
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x5e90
    // Size: 0x80, Type: dev
    function function_9ea1b3409311f518()
    {
        humans = function_35d942f93b6a3cfe();
        human_spectators = [];
        
        foreach ( player in humans )
        {
            if ( player.team == "<dev string:xce>" )
            {
                human_spectators[ human_spectators.size ] = player;
            }
        }
        
        return human_spectators;
    }

#/

// Namespace bots / scripts\mp\bots\bots
// Params 8
// Checksum 0x0, Offset: 0x5f18
// Size: 0x159
function bot_damage_callback( eattacker, idamage, smeansofdeath, sweapon, einflictor, shitloc, vpoint, lightarmordamage )
{
    if ( !isdefined( lightarmordamage ) )
    {
        lightarmordamage = 0;
    }
    
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_SUICIDE" )
    {
        return;
    }
    
    if ( idamage <= 0 && lightarmordamage <= 0 )
    {
        return;
    }
    
    if ( !isdefined( einflictor ) )
    {
        if ( !isdefined( eattacker ) )
        {
            return;
        }
        
        einflictor = eattacker;
    }
    
    if ( isdefined( einflictor ) )
    {
        if ( isdefined( self.fnbotdamagecallback ) )
        {
            self [[ self.fnbotdamagecallback ]]( eattacker, idamage, smeansofdeath, sweapon, einflictor, shitloc, vpoint, lightarmordamage );
        }
        
        if ( level.teambased )
        {
            if ( isdefined( einflictor.team ) && einflictor.team == self.team )
            {
                return;
            }
            else if ( isdefined( eattacker ) && isdefined( eattacker.team ) && eattacker.team == self.team )
            {
                return;
            }
        }
        
        attacker_ent = bot_get_known_attacker( eattacker, einflictor );
        
        if ( isdefined( attacker_ent ) )
        {
            self botsetattacker( attacker_ent );
        }
    }
    
    if ( isagent( self ) )
    {
        self notify( "agentDamage" );
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 10
// Checksum 0x0, Offset: 0x6079
// Size: 0x15f
function on_bot_killed( einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    self botclearscriptenemy();
    self botclearscriptgoal();
    attacker_ent = bot_get_known_attacker( attacker, einflictor );
    
    if ( isdefined( attacker_ent ) && ( attacker_ent.classname == "script_vehicle" || attacker_ent.classname == "script_model" ) && isdefined( attacker_ent.helitype ) )
    {
        respawn_chance = self botgetdifficultysetting( "launcherRespawnChance" );
        
        if ( randomfloat( 1 ) < respawn_chance )
        {
            self.respawn_with_launcher = 1;
        }
    }
    
    /#
        if ( isdefined( level.testdummy ) && level.testdummy == self && isdefined( self.menu ) && isdefined( self.firstdamagetime ) )
        {
            ttk = gettime() - self.firstdamagetime;
            self.menu[ "<dev string:x4f9>" ] setvalue( function_c89ed1840c8d0f0f( ttk ) );
            self.firstdamagetime = undefined;
        }
    #/
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x61e0
// Size: 0x11b, Type: bool
function bot_should_do_killcam()
{
    if ( istrue( game[ "isLaunchChunk" ] ) )
    {
        return true;
    }
    
    /#
        human_spectators = function_9ea1b3409311f518();
        
        foreach ( human in human_spectators )
        {
            var_342ef8334ecfd02a = human getspectatingplayer();
            
            if ( isdefined( var_342ef8334ecfd02a ) && var_342ef8334ecfd02a == self )
            {
                return false;
            }
        }
        
        if ( getdvarint( @"hash_e125675f281d4f47", 0 ) == 1 )
        {
            return false;
        }
    #/
    
    var_6e08093b6ffe655f = 0;
    bot_difficulty = self botgetdifficulty();
    
    if ( bot_difficulty == "recruit" )
    {
        var_6e08093b6ffe655f = 0.1;
    }
    else if ( bot_difficulty == "regular" )
    {
        var_6e08093b6ffe655f = 0.4;
    }
    else if ( bot_difficulty == "hardened" )
    {
        var_6e08093b6ffe655f = 0.7;
    }
    else if ( bot_difficulty == "veteran" )
    {
        var_6e08093b6ffe655f = 1;
    }
    
    return randomfloat( 1 ) < 1 - var_6e08093b6ffe655f;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x6304
// Size: 0x4, Type: bool
function bot_should_pickup_weapons()
{
    return true;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x6311
// Size: 0xb1
function bot_restart_think_threads()
{
    self thread [[ level.bot_funcs[ "bot_think_watch_enemy" ] ]]();
    self thread [[ level.bot_funcs[ "bot_think_tactical_goals" ] ]]();
    self thread [[ level.bot_funcs[ "dropped_weapon_think" ] ]]();
    self thread [[ level.bot_funcs[ "revive_think" ] ]]();
    
    if ( !scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73() && !scripts\cp_mp\utility\game_utility::function_6493ec89ae923684() )
    {
        thread bot_think_crate();
        thread bot_think_crate_blocking_path();
    }
    
    thread bot_think_usable_objects();
    thread bot_think_killstreak();
    thread bot_think_watch_aerial_killstreak();
    thread bot_think_gametype();
    thread bot_think_dynamic_doors();
    thread bot_think_nvg();
    
    /#
        thread function_85449d9e699cd4cd();
    #/
}

/#

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x63ca
    // Size: 0xd2, Type: dev
    function function_85449d9e699cd4cd()
    {
        self notify( "<dev string:x500>" );
        self endon( "<dev string:x500>" );
        self endon( "<dev string:x513>" );
        level endon( "<dev string:x1c>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_c2de8ca6dc8512c1" ) )
            {
                wait 0.05;
                continue;
            }
            
            if ( isdefined( level.var_e6522d43cff255f2 ) )
            {
                bot_disable_tactical_goals();
                self.ignoreall = 1;
                self botsetstance( "<dev string:x39b>" );
                
                if ( !self bothasscriptgoal() )
                {
                    self botsetscriptgoal( level.var_e6522d43cff255f2, 0, "<dev string:x3f1>" );
                }
                else
                {
                    goal = self botgetscriptgoal();
                    
                    if ( !bot_vectors_are_equal( goal, level.var_e6522d43cff255f2 ) )
                    {
                        self botsetscriptgoal( level.var_e6522d43cff255f2, 0, "<dev string:x3f1>" );
                    }
                }
            }
            
            wait 0.05;
        }
    }

#/

// Namespace bots / scripts\mp\bots\bots
// Params 2
// Checksum 0x0, Offset: 0x64a4
// Size: 0x46, Type: bool
function sortdoorsbydistance( door1, door2 )
{
    return distancesquared( door1.origin, self.closestdoorpos ) < distancesquared( door2.origin, self.closestdoorpos );
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x64f3
// Size: 0xcf
function bot_think_dynamic_doors()
{
    self notify( "bot_think_dynamic_doors" );
    self endon( "bot_think_dynamic_doors" );
    self endon( "bot_suspended" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        doorpos = self getmodifierlocationonpath( "door", 64 );
        
        if ( isdefined( doorpos ) )
        {
            self.closestdoorpos = doorpos;
            doorlist = getentarrayinradius( "dynamic_door", "targetname", doorpos, 64 );
            
            if ( doorlist.size > 0 )
            {
                doorlist = array_sort_with_func( doorlist, &sortdoorsbydistance );
                door = doorlist[ 0 ];
                
                if ( isdefined( door.state ) && door scripts\mp\door::door_can_open_check() )
                {
                    door thread scripts\mp\door::cheapopen( self );
                }
            }
            
            self.closestdoorpos = undefined;
        }
        
        wait 0.05;
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x65ca
// Size: 0x193
function bot_think_nvg()
{
    self notify( "bot_think_nvg" );
    self endon( "bot_think_nvg" );
    self endon( "bot_suspended" );
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    isnightmap = scripts\cp_mp\utility\game_utility::isnightmap();
    
    while ( true )
    {
        indarkvolume = 0;
        var_9d8167bedff899c8 = 0;
        
        if ( isdefined( level.bot_light_volumes ) )
        {
            foreach ( vol in level.bot_light_volumes )
            {
                if ( self istouching( vol ) )
                {
                    var_9d8167bedff899c8 = 1;
                    break;
                }
            }
        }
        
        if ( isdefined( level.bot_dark_volumes ) )
        {
            foreach ( vol in level.bot_dark_volumes )
            {
                if ( self istouching( vol ) )
                {
                    indarkvolume = 1;
                    break;
                }
            }
        }
        
        if ( istrue( self.inmotionlight ) )
        {
            var_9d8167bedff899c8 = 1;
        }
        
        if ( indarkvolume || isnightmap && !var_9d8167bedff899c8 )
        {
            self botsetflag( "dark_area", 1 );
            self.indarkarea = 1;
        }
        else if ( !indarkvolume && istrue( self.indarkarea ) )
        {
            self botsetflag( "dark_area", 0 );
            self.indarkarea = 0;
        }
        
        wait 0.25;
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x6765
// Size: 0x9d
function bot_think_watch_enemy( bendondeath )
{
    level endon( "game_ended" );
    self notify( "bot_think_watch_enemy" );
    self endon( "bot_think_watch_enemy" );
    self endon( "bot_suspended" );
    self endon( "disconnect" );
    
    if ( istrue( bendondeath ) )
    {
        self endon( "death" );
    }
    
    self.last_enemy_sight_time = 0;
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_c2de8ca6dc8512c1" ) )
            {
                wait 0.05;
                continue;
            }
        #/
        
        if ( isdefined( self.enemy ) )
        {
            if ( self botcanseeentity( self.enemy ) )
            {
                self.last_enemy_sight_time = gettime();
            }
        }
        
        wait 0.05;
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x680a
// Size: 0x26b
function bot_think_seek_dropped_weapons()
{
    self notify( "bot_think_seek_dropped_weapons" );
    self endon( "bot_think_seek_dropped_weapons" );
    self endon( "bot_suspended" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    var_7ba262cc7ab5e283 = "throwingknife_mp";
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_c2de8ca6dc8512c1" ) )
            {
                wait 0.05;
                continue;
            }
        #/
        
        var_6fe7e4707cd33327 = 0;
        
        if ( bot_out_of_ammo() )
        {
            if ( self [[ level.bot_funcs[ "should_pickup_weapons" ] ]]() && !bot_is_remote_or_linked() )
            {
                dropped_weapons = getentarray( "dropped_weapon", "targetname" );
                var_6ac6ee221e4d7361 = get_array_of_closest( self.origin, dropped_weapons );
                
                if ( var_6ac6ee221e4d7361.size > 0 )
                {
                    dropped_weapon = var_6ac6ee221e4d7361[ 0 ];
                    bot_seek_dropped_weapon( dropped_weapon );
                }
            }
        }
        
        if ( !bot_in_combat() && !bot_is_remote_or_linked() && self botgetdifficultysetting( "strategyLevel" ) > 0 )
        {
            var_4b40839ad49e4f31 = self hasweapon( var_7ba262cc7ab5e283 );
            knife_thrown = var_4b40839ad49e4f31 && self getammocount( var_7ba262cc7ab5e283 ) == 0;
            
            if ( knife_thrown )
            {
                if ( isdefined( self.going_for_knife ) )
                {
                    wait 5;
                    continue;
                }
                
                dropped_knives = getentarray( "dropped_knife", "targetname" );
                var_d22a29017f63ae78 = get_array_of_closest( self.origin, dropped_knives );
                
                foreach ( knife in var_d22a29017f63ae78 )
                {
                    if ( !isdefined( knife ) )
                    {
                        continue;
                    }
                    
                    if ( !isdefined( knife.calculated_closest_point ) )
                    {
                        result = bot_queued_process( "BotGetClosestNavigablePoint", &func_bot_get_closest_navigable_point, knife.origin, 32, self );
                        
                        if ( isdefined( knife ) )
                        {
                            knife.closest_point_on_grid = result;
                            knife.calculated_closest_point = 1;
                        }
                        else
                        {
                            continue;
                        }
                    }
                    
                    if ( isdefined( knife.closest_point_on_grid ) )
                    {
                        self.going_for_knife = 1;
                        bot_seek_dropped_weapon( knife );
                    }
                }
            }
            else if ( var_4b40839ad49e4f31 )
            {
                self.going_for_knife = undefined;
            }
        }
        
        wait randomfloatrange( 0.25, 0.75 );
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x6a7d
// Size: 0x12d
function bot_seek_dropped_weapon( dropped_weapon )
{
    if ( bot_has_tactical_goal( "seek_dropped_weapon", dropped_weapon ) == 0 )
    {
        action_thread = undefined;
        
        if ( dropped_weapon.targetname == "dropped_weapon" )
        {
            var_661c34ec270a10 = 1;
            heldweapons = self getweaponslistprimaries();
            
            foreach ( held_weapon in heldweapons )
            {
                if ( dropped_weapon.model == getweaponmodel( held_weapon ) )
                {
                    var_661c34ec270a10 = 0;
                }
            }
            
            if ( var_661c34ec270a10 )
            {
                action_thread = &bot_pickup_weapon;
            }
        }
        
        extra_params = spawnstruct();
        extra_params.object = dropped_weapon;
        extra_params.script_goal_radius = 12;
        extra_params.should_abort = level.bot_funcs[ "dropped_weapon_cancel" ];
        extra_params.action_thread = action_thread;
        bot_new_tactical_goal( "seek_dropped_weapon", dropped_weapon.origin, 100, extra_params );
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x6bb2
// Size: 0x1c
function bot_pickup_weapon( goal )
{
    self botpressbutton( "use", 2 );
    wait 2;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x6bd6
// Size: 0x7f, Type: bool
function should_stop_seeking_weapon( goal )
{
    if ( !isdefined( goal.object ) )
    {
        return true;
    }
    
    if ( goal.object.targetname == "dropped_weapon" )
    {
        if ( !bot_out_of_ammo() )
        {
            return true;
        }
    }
    else if ( goal.object.targetname == "dropped_knife" )
    {
        if ( bot_in_combat() )
        {
            self.going_for_knife = undefined;
            return true;
        }
    }
    
    return false;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x6c5e
// Size: 0x52, Type: bool
function crate_in_range( crate )
{
    if ( !isdefined( crate.owner ) || crate.owner != self )
    {
        if ( distancesquared( self.origin, crate.origin ) > 4194304 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x6cb9
// Size: 0x1ee, Type: bool
function bot_crate_valid( crate )
{
    if ( !isdefined( crate ) )
    {
        return false;
    }
    
    cratecanuse = self [[ level.bot_funcs[ "crate_can_use" ] ]]( crate );
    
    if ( !cratecanuse )
    {
        if ( getgametype() == "grnd" )
        {
            cratecanuse = 1;
        }
    }
    
    assertex( isdefined( cratecanuse ), "<dev string:x52a>" );
    
    if ( !cratecanuse )
    {
        return false;
    }
    
    if ( !crate_landed_and_on_path_grid( crate ) )
    {
        return false;
    }
    
    if ( level.teambased && isdefined( crate.bomb ) && isdefined( crate.team ) && crate.team == self.team )
    {
        return false;
    }
    
    if ( !self [[ level.bot_funcs[ "crate_in_range" ] ]]( crate ) )
    {
        return false;
    }
    
    if ( isdefined( crate.boxtype ) )
    {
        if ( isdefined( level.boxsettings ) && isdefined( level.boxsettings[ crate.boxtype ] ) && ![[ level.boxsettings[ crate.boxtype ].canusecallback ]]() )
        {
            return false;
        }
        
        if ( isdefined( crate.disabled_use_for ) && isdefined( crate.disabled_use_for[ self getentitynumber() ] ) && crate.disabled_use_for[ self getentitynumber() ] )
        {
            return false;
        }
        
        /#
            if ( isdefined( level.bot_can_use_box_by_type ) && !isdefined( level.bot_can_use_box_by_type[ crate.boxtype ] ) )
            {
                assertmsg( "<dev string:x57b>" + crate.boxtype + "<dev string:x58b>" );
                return false;
            }
        #/
        
        if ( !isdefined( level.bot_can_use_box_by_type ) || !self [[ level.bot_can_use_box_by_type[ crate.boxtype ] ]]( crate ) )
        {
            return false;
        }
    }
    else if ( bot_has_streak_in_crate( crate ) )
    {
        return false;
    }
    
    return isdefined( crate );
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x6eb0
// Size: 0xc, Type: bool
function bot_has_streak_in_crate( crate )
{
    return false;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x6ec5
// Size: 0x3b, Type: bool
function crate_landed_and_on_path_grid( crate )
{
    assert( isdefined( crate ) );
    
    if ( !crate_has_landed( crate ) )
    {
        return false;
    }
    
    assert( isdefined( crate ) );
    
    if ( !crate_is_on_path_grid( crate ) )
    {
        return false;
    }
    
    return isdefined( crate );
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x6f09
// Size: 0x82, Type: bool
function crate_has_landed( crate )
{
    if ( isdefined( crate.boxtype ) )
    {
        return ( gettime() > crate.birthtime + 1000 );
    }
    else
    {
        if ( isdefined( crate.droppingtoground ) )
        {
            return !crate.droppingtoground;
        }
        
        if ( isdefined( crate.animname ) )
        {
            return false;
        }
        
        if ( isdefined( crate.avlinvel ) )
        {
            return ( crate.avlinvel < 0.01 );
        }
    }
    
    return false;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x6f94
// Size: 0x43, Type: bool
function crate_is_on_path_grid( crate )
{
    assert( crate_has_landed( crate ) );
    
    if ( !isdefined( crate.on_path_grid ) )
    {
        crate_calculate_on_path_grid( crate );
    }
    
    return isdefined( crate ) && crate.on_path_grid;
}

// Namespace bots / scripts\mp\bots\bots
// Params 2
// Checksum 0x0, Offset: 0x6fe0
// Size: 0xff
function node_within_use_radius_of_crate( node, crate )
{
    if ( isdefined( crate.boxtype ) && crate.boxtype == "scavenger_bag" )
    {
        return ( abs( node.origin[ 0 ] - crate.origin[ 0 ] ) < 36 && abs( node.origin[ 0 ] - crate.origin[ 0 ] ) < 36 && abs( node.origin[ 0 ] - crate.origin[ 0 ] ) < 18 );
    }
    
    var_ebd58f81541d9efb = getdvarfloat( @"hash_a62badf83a03d925" );
    var_e9b1f8e9e674c72c = distancesquared( crate.origin, node.origin + ( 0, 0, 40 ) );
    return var_e9b1f8e9e674c72c <= var_ebd58f81541d9efb * var_ebd58f81541d9efb;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x70e7
// Size: 0x23c
function crate_calculate_on_path_grid( crate )
{
    assert( !isdefined( crate.nearest_nodes ) );
    assert( !isdefined( crate.on_path_grid ) );
    crate thread crate_monitor_position();
    crate.on_path_grid = 0;
    var_bc2fb8699d6785aa = undefined;
    var_c6100808b5487220 = undefined;
    
    if ( isdefined( crate.forcedisconnectuntil ) )
    {
        var_bc2fb8699d6785aa = crate.forcedisconnectuntil;
        var_c6100808b5487220 = gettime() + 30000;
        crate.forcedisconnectuntil = var_c6100808b5487220;
        crate notify( "path_disconnect" );
    }
    
    wait 0.05;
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    nearest_nodes = crate_get_nearest_valid_nodes( crate );
    
    if ( !isdefined( crate ) )
    {
        return;
    }
    
    if ( isdefined( nearest_nodes ) && nearest_nodes.size > 0 )
    {
        crate.nearest_nodes = nearest_nodes;
        crate.on_path_grid = 1;
    }
    else
    {
        var_ebd58f81541d9efb = getdvarfloat( @"hash_a62badf83a03d925" );
        closest_node = getnodesinradiussorted( crate.origin, var_ebd58f81541d9efb * 2, 0 )[ 0 ];
        var_46de623fb65654b7 = crate getpointinbounds( 0, 0, -1 );
        nearest_point = undefined;
        
        if ( isdefined( crate.boxtype ) && crate.boxtype == "scavenger_bag" )
        {
            if ( bot_point_is_on_pathgrid( crate.origin, var_ebd58f81541d9efb ) )
            {
                nearest_point = crate.origin;
            }
        }
        else
        {
            nearest_point = botgetclosestnavigablepoint( crate.origin, var_ebd58f81541d9efb );
        }
        
        if ( isdefined( closest_node ) && !closest_node nodeisdisconnected() && isdefined( nearest_point ) && abs( closest_node.origin[ 2 ] - var_46de623fb65654b7[ 2 ] ) < 30 )
        {
            crate.nearest_points = [ nearest_point ];
            crate.nearest_nodes = [ closest_node ];
            crate.on_path_grid = 1;
        }
    }
    
    if ( isdefined( crate.forcedisconnectuntil ) )
    {
        if ( crate.forcedisconnectuntil == var_c6100808b5487220 )
        {
            crate.forcedisconnectuntil = var_bc2fb8699d6785aa;
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x732b
// Size: 0x249
function crate_get_nearest_valid_nodes( crate )
{
    nodes = getnodesinradiussorted( crate.origin, 256, 0 );
    
    for ( i = nodes.size; i > 0 ; i-- )
    {
        nodes[ i ] = nodes[ i - 1 ];
    }
    
    nodes[ 0 ] = getclosestnodeinsight( crate.origin );
    var_f0c46916118d97cd = undefined;
    
    if ( isdefined( crate.forcedisconnectuntil ) )
    {
        var_f0c46916118d97cd = getnodecount();
    }
    
    var_a4a22899c4c3c751 = [];
    var_6ae00cccc4c48924 = 1;
    
    if ( !isdefined( crate.boxtype ) )
    {
        var_6ae00cccc4c48924 = 2;
    }
    
    for ( i = 0; i < nodes.size ; i++ )
    {
        node = nodes[ i ];
        
        if ( !isdefined( node ) || !isdefined( crate ) )
        {
            continue;
        }
        
        if ( node nodeisdisconnected() )
        {
            continue;
        }
        
        if ( !node_within_use_radius_of_crate( node, crate ) )
        {
            if ( i == 0 )
            {
                continue;
            }
            else
            {
                break;
            }
        }
        
        wait 0.05;
        
        if ( !isdefined( crate ) )
        {
            break;
        }
        
        if ( sighttracepassed( crate.origin, node.origin + ( 0, 0, 55 ), 0, crate ) )
        {
            wait 0.05;
            
            if ( !isdefined( crate ) )
            {
                break;
            }
            
            if ( !isdefined( crate.forcedisconnectuntil ) )
            {
                var_a4a22899c4c3c751[ var_a4a22899c4c3c751.size ] = node;
                
                if ( var_a4a22899c4c3c751.size == var_6ae00cccc4c48924 )
                {
                    return var_a4a22899c4c3c751;
                }
                else
                {
                    continue;
                }
            }
            
            var_b4a4e2c4f49b95df = undefined;
            num_tested = 0;
            
            while ( !isdefined( var_b4a4e2c4f49b95df ) && num_tested < 100 )
            {
                num_tested++;
                var_498acc2540d38c2c = randomint( var_f0c46916118d97cd );
                var_1b82b6f689a2283d = getnodebyindex( var_498acc2540d38c2c );
                
                if ( isdefined( var_1b82b6f689a2283d ) && distancesquared( node.origin, var_1b82b6f689a2283d.origin ) > 250000 )
                {
                    var_b4a4e2c4f49b95df = var_1b82b6f689a2283d;
                }
            }
            
            if ( isdefined( var_b4a4e2c4f49b95df ) )
            {
                path = bot_queued_process( "GetNodesOnPathCrate", &func_get_nodes_on_path, node.origin, var_b4a4e2c4f49b95df.origin );
                
                if ( isdefined( path ) )
                {
                    var_a4a22899c4c3c751[ var_a4a22899c4c3c751.size ] = node;
                    
                    if ( var_a4a22899c4c3c751.size == var_6ae00cccc4c48924 )
                    {
                        return var_a4a22899c4c3c751;
                    }
                }
            }
        }
    }
    
    return undefined;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x757d
// Size: 0xbe
function crate_get_bot_target( crate )
{
    if ( isdefined( crate.nearest_points ) )
    {
        return crate.nearest_points[ 0 ];
    }
    
    if ( isdefined( crate.nearest_nodes ) && crate.nearest_nodes.size > 0 )
    {
        if ( crate.nearest_nodes.size > 1 )
        {
            nodes_sorted = array_reverse( self botnodescoremultiple( crate.nearest_nodes, "node_exposed" ) );
            return random_weight_sorted( nodes_sorted ).origin;
        }
        else
        {
            return crate.nearest_nodes[ 0 ].origin;
        }
    }
    
    assertmsg( "<dev string:x5aa>" );
}

// Namespace bots / scripts\mp\bots\bots
// Params 2
// Checksum 0x0, Offset: 0x7643
// Size: 0x62
function crate_get_bot_target_check_distance( crate, use_radius )
{
    var_dbe8b001ddd1337e = crate_get_bot_target( crate );
    var_dbe8b001ddd1337e = getclosestpointonnavmesh( var_dbe8b001ddd1337e, self );
    testradiussq = use_radius * 0.9;
    testradiussq *= testradiussq;
    
    if ( distancesquared( crate.origin, var_dbe8b001ddd1337e ) <= testradiussq )
    {
        return var_dbe8b001ddd1337e;
    }
    
    return undefined;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x76ad
// Size: 0x790
function bot_think_crate()
{
    self notify( "bot_think_crate" );
    self endon( "bot_think_crate" );
    self endon( "bot_suspended" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    var_ebd58f81541d9efb = getdvarfloat( @"hash_a62badf83a03d925" );
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_c2de8ca6dc8512c1" ) )
            {
                wait 0.05;
                continue;
            }
        #/
        
        wait_time = randomfloatrange( 2, 4 );
        waittill_notify_or_timeout( "new_crate_to_take", wait_time );
        
        if ( isdefined( self.boxes ) && self.boxes.size == 0 )
        {
            self.boxes = undefined;
        }
        
        all_crates = level.carepackages;
        
        if ( !bot_in_combat() && isdefined( self.boxes ) )
        {
            all_crates = array_combine( all_crates, self.boxes );
        }
        
        if ( isdefined( level.bot_scavenger_bags ) && _hasperk( "specialty_scavenger" ) )
        {
            all_crates = array_combine( all_crates, level.bot_scavenger_bags );
        }
        
        if ( isdefined( level.cratedata ) )
        {
            foreach ( crate in level.cratedata.crates )
            {
                if ( isdefined( crate ) )
                {
                    all_crates[ all_crates.size ] = crate;
                }
            }
        }
        
        all_crates = array_removeundefined( all_crates );
        
        if ( all_crates.size == 0 )
        {
            continue;
        }
        
        if ( bot_has_tactical_goal( "airdrop_crate" ) || self botgetscriptgoaltype() == "tactical" || bot_is_remote_or_linked() )
        {
            continue;
        }
        
        var_9e543bde5d2a2496 = [];
        
        foreach ( crate in all_crates )
        {
            if ( bot_crate_valid( crate ) )
            {
                var_9e543bde5d2a2496[ var_9e543bde5d2a2496.size ] = crate;
            }
        }
        
        var_9e543bde5d2a2496 = array_remove_duplicates( var_9e543bde5d2a2496 );
        
        if ( var_9e543bde5d2a2496.size == 0 )
        {
            continue;
        }
        
        var_9e543bde5d2a2496 = get_array_of_closest( self.origin, var_9e543bde5d2a2496 );
        var_b6f1deb8e946e67c = self getnearestnode();
        
        if ( !isdefined( var_b6f1deb8e946e67c ) )
        {
            continue;
        }
        
        ammolow = self [[ level.bot_funcs[ "crate_low_ammo_check" ] ]]();
        var_ec5d6613e0b30ab7 = ( ammolow || randomint( 100 ) < 50 ) && !scripts\cp_mp\emp_debuff::is_empd();
        crate_to_take = undefined;
        
        foreach ( crate in var_9e543bde5d2a2496 )
        {
            var_10256e13fb6f7945 = 0;
            
            if ( ( !isdefined( crate.owner ) || crate.owner != self ) && !isdefined( crate.boxtype ) )
            {
                var_2df5bad592ba26ac = [];
                
                foreach ( player in level.players )
                {
                    if ( !isdefined( player.team ) )
                    {
                        continue;
                    }
                    
                    if ( !isai( player ) && level.teambased && player.team == self.team )
                    {
                        if ( distancesquared( player.origin, crate.origin ) < 490000 )
                        {
                            var_2df5bad592ba26ac[ var_2df5bad592ba26ac.size ] = player;
                        }
                    }
                }
                
                if ( var_2df5bad592ba26ac.size > 0 )
                {
                    var_f8b50191af8c5b3c = var_2df5bad592ba26ac[ 0 ] getnearestnode();
                    
                    if ( isdefined( var_f8b50191af8c5b3c ) )
                    {
                        var_10256e13fb6f7945 = 0;
                        
                        if ( isdefined( crate.nearest_nodes ) )
                        {
                            foreach ( node in crate.nearest_nodes )
                            {
                                var_10256e13fb6f7945 = var_10256e13fb6f7945 || nodesvisible( var_f8b50191af8c5b3c, node, 1 );
                            }
                        }
                    }
                }
            }
            
            if ( !var_10256e13fb6f7945 )
            {
                var_1cdea334d6287f87 = isdefined( crate.bots ) && isdefined( crate.bots[ self.team ] ) && crate.bots[ self.team ] > 0;
                var_539c5e6b72fb319 = 0;
                
                foreach ( node in crate.nearest_nodes )
                {
                    var_539c5e6b72fb319 = var_539c5e6b72fb319 || nodesvisible( var_b6f1deb8e946e67c, node, 1 );
                }
                
                if ( var_539c5e6b72fb319 || var_ec5d6613e0b30ab7 && !var_1cdea334d6287f87 )
                {
                    crate_to_take = crate;
                    break;
                }
            }
        }
        
        if ( isdefined( crate_to_take ) )
        {
            if ( self [[ level.bot_funcs[ "crate_should_claim" ] ]]() )
            {
                if ( !isdefined( crate_to_take.boxtype ) )
                {
                    if ( !isdefined( crate_to_take.bots ) )
                    {
                        crate_to_take.bots = [];
                    }
                    
                    crate_to_take.bots[ self.team ] = 1;
                }
            }
            
            extra_params = spawnstruct();
            extra_params.object = crate_to_take;
            extra_params.start_thread = &watch_bot_died_during_crate;
            extra_params.should_abort = &crate_picked_up;
            crate_dest = undefined;
            
            if ( isdefined( crate_to_take.boxtype ) )
            {
                if ( isdefined( crate_to_take.boxtouchonly ) && crate_to_take.boxtouchonly )
                {
                    extra_params.script_goal_radius = 16;
                    extra_params.action_thread = undefined;
                    crate_dest = crate_to_take.origin;
                }
                else
                {
                    extra_params.script_goal_radius = 50;
                    extra_params.action_thread = &use_box;
                    var_e1fe7ee9b032b76f = crate_get_bot_target_check_distance( crate_to_take, var_ebd58f81541d9efb );
                    
                    if ( !isdefined( var_e1fe7ee9b032b76f ) )
                    {
                        continue;
                    }
                    
                    var_e1fe7ee9b032b76f -= crate_to_take.origin;
                    scale = length( var_e1fe7ee9b032b76f ) * randomfloat( 1 );
                    crate_dest = crate_to_take.origin + vectornormalize( var_e1fe7ee9b032b76f ) * scale + ( 0, 0, 12 );
                }
            }
            else
            {
                extra_params.action_thread = &use_crate;
                extra_params.end_thread = &stop_using_crate;
                crate_dest = crate_get_bot_target_check_distance( crate_to_take, var_ebd58f81541d9efb );
                
                if ( !isdefined( crate_dest ) )
                {
                    continue;
                }
                
                extra_params.script_goal_radius = var_ebd58f81541d9efb - distance( crate_to_take.origin, crate_dest + ( 0, 0, 40 ) );
                crate_dest += ( 0, 0, 24 );
            }
            
            if ( isdefined( extra_params.script_goal_radius ) )
            {
                assert( extra_params.script_goal_radius >= 0 );
            }
            
            crate_to_take notify( "path_disconnect" );
            wait 0.05;
            
            if ( !isdefined( crate_to_take ) )
            {
                continue;
            }
            
            bot_new_tactical_goal( "airdrop_crate", crate_dest, 30, extra_params );
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x7e45
// Size: 0xd, Type: bool
function bot_should_use_ballistic_vest_crate( crate )
{
    return true;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x7e5b
// Size: 0x4, Type: bool
function crate_should_claim()
{
    return true;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x7e68
// Size: 0x3, Type: bool
function crate_low_ammo_check()
{
    return false;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x7e74
// Size: 0x3d, Type: bool
function bot_should_use_ammo_crate( crate )
{
    if ( getcompleteweaponname( self getcurrentweapon() ) == level.boxsettings[ crate.boxtype ].minigunweapon )
    {
        return false;
    }
    
    return true;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x7eba
// Size: 0x21
function bot_pre_use_ammo_crate( crate )
{
    _switchtoweapon( self.secondaryweapon );
    wait 1;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x7ee3
// Size: 0x26
function bot_post_use_ammo_crate( crate )
{
    _switchtoweapon( nullweapon() );
    self.secondaryweapon = self getcurrentweapon();
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x7f11
// Size: 0x97, Type: bool
function bot_should_use_scavenger_bag( crate )
{
    if ( bot_get_low_on_ammo( 0.66 ) )
    {
        var_b6f1deb8e946e67c = self getnearestnode();
        
        if ( isdefined( crate.nearest_nodes ) && isdefined( crate.nearest_nodes[ 0 ] ) && isdefined( var_b6f1deb8e946e67c ) )
        {
            if ( nodesvisible( var_b6f1deb8e946e67c, crate.nearest_nodes[ 0 ], 1 ) )
            {
                if ( within_fov( self.origin, self getplayerangles(), crate.origin, self botgetfovdot() ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x7fb1
// Size: 0x6f, Type: bool
function bot_should_use_grenade_crate( crate )
{
    offhand_list = self getweaponslistoffhands();
    
    foreach ( weapon in offhand_list )
    {
        if ( self getweaponammostock( weapon ) == 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x8029
// Size: 0xd, Type: bool
function bot_should_use_juicebox_crate( crate )
{
    return true;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x803f
// Size: 0x79
function crate_monitor_position()
{
    self notify( "crate_monitor_position" );
    self endon( "crate_monitor_position" );
    self endon( "death" );
    level endon( "game_ended" );
    
    while ( true )
    {
        lastpos = self.origin;
        wait 0.5;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( !bot_vectors_are_equal( self.origin, lastpos ) )
        {
            self.on_path_grid = undefined;
            self.nearest_nodes = undefined;
            self.nearest_points = undefined;
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x80c0
// Size: 0x8
function crate_wait_use()
{
    wait 0.5;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x80d0
// Size: 0x1e, Type: bool
function crate_picked_up( goal )
{
    if ( !isdefined( goal.object ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x80f7
// Size: 0x1aa
function use_crate( goal )
{
    if ( isagent( self ) )
    {
        val::reset_all( "agent_use" );
        goal.object enableplayeruse( self );
        wait 0.05;
    }
    
    self [[ level.bot_funcs[ "crate_wait_use" ] ]]();
    
    if ( isdefined( goal.object.owner ) && goal.object.owner == self )
    {
        time = level.crateownerusetime / 1000 + 0.5;
    }
    else
    {
        time = level.cratenonownerusetime / 1000 + 1;
    }
    
    self botpressbutton( "use", time );
    
    while ( time > 0 && isdefined( goal.object ) )
    {
        wait 0.05;
        time -= 0.05;
    }
    
    if ( time > 0 )
    {
        wait randomfloatrange( 0.05, 0.5 );
    }
    
    if ( isagent( self ) )
    {
        val::set( "agent_use", "usability", 0 );
        
        if ( isdefined( goal.object ) )
        {
            goal.object disableplayeruse( self );
        }
    }
    
    if ( isdefined( goal.object ) )
    {
        if ( !isdefined( goal.object.bots_used ) )
        {
            goal.object.bots_used = [];
        }
        
        goal.object.bots_used[ goal.object.bots_used.size ] = self;
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x82a9
// Size: 0x16b
function use_box( goal )
{
    if ( isagent( self ) )
    {
        val::reset_all( "agent_use" );
        goal.object enableplayeruse( self );
        wait 0.05;
    }
    
    if ( isdefined( goal.object ) && isdefined( goal.object.boxtype ) )
    {
        boxtype = goal.object.boxtype;
        
        if ( isdefined( level.bot_pre_use_box_of_type[ boxtype ] ) )
        {
            self [[ level.bot_pre_use_box_of_type[ boxtype ] ]]( goal.object );
        }
        
        if ( isdefined( goal.object ) )
        {
            time = level.boxsettings[ goal.object.boxtype ].usetime / 1000 + 0.5;
            self botpressbutton( "use", time );
            wait time;
            
            if ( isdefined( level.bot_post_use_box_of_type[ boxtype ] ) )
            {
                self [[ level.bot_post_use_box_of_type[ boxtype ] ]]( goal.object );
            }
        }
    }
    
    if ( isagent( self ) )
    {
        val::set( "agent_use", "usability", 0 );
        
        if ( isdefined( goal.object ) )
        {
            goal.object disableplayeruse( self );
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x841c
// Size: 0x1e
function watch_bot_died_during_crate( goal )
{
    thread bot_watch_for_death( goal.object );
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x8442
// Size: 0x3b
function stop_using_crate( goal )
{
    if ( isdefined( goal.object ) )
    {
        goal.object.bots[ self.team ] = 0;
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x8485
// Size: 0x51
function bot_watch_for_death( object )
{
    object endon( "death_or_disconnect" );
    object endon( "revived" );
    level endon( "game_ended" );
    prev_team = self.team;
    self waittill( "death_or_disconnect" );
    
    if ( isdefined( object ) )
    {
        object.bots[ prev_team ] = 0;
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x84de
// Size: 0x16b
function bot_think_crate_blocking_path()
{
    self notify( "bot_think_crate_blocking_path" );
    self endon( "bot_think_crate_blocking_path" );
    self endon( "bot_suspended" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    radius = getdvarfloat( @"hash_a62badf83a03d925" );
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_c2de8ca6dc8512c1" ) )
            {
                wait 0.05;
                continue;
            }
        #/
        
        wait 3;
        
        if ( self usebuttonpressed() )
        {
            continue;
        }
        
        if ( isusingremote() )
        {
            continue;
        }
        
        crates = level.carepackages;
        
        for ( i = 0; i < crates.size ; i++ )
        {
            crate = crates[ i ];
            
            if ( !isdefined( crate ) )
            {
                continue;
            }
            
            use_ent = self getplayeruseentity();
            
            if ( !isdefined( use_ent ) || use_ent != crate )
            {
                continue;
            }
            
            if ( distancesquared( self.origin, crate.origin ) < radius * radius )
            {
                if ( !bot_has_streak_in_crate( crate ) )
                {
                    if ( isdefined( crate.owner ) && crate.owner == self )
                    {
                        self botpressbutton( "use", level.crateownerusetime / 1000 + 0.5 );
                        continue;
                    }
                    
                    self botpressbutton( "use", level.cratenonownerusetime / 1000 + 0.5 );
                }
            }
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x8651
// Size: 0xb5
function bot_think_usable_objects()
{
    self notify( "bot_think_usable_objects" );
    self endon( "bot_think_usable_objects" );
    self endon( "bot_suspended" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_c2de8ca6dc8512c1" ) )
            {
                wait 0.05;
                continue;
            }
        #/
        
        wait 2;
        
        if ( self usebuttonpressed() )
        {
            continue;
        }
        
        if ( isusingremote() )
        {
            continue;
        }
        
        use_ent = self getplayeruseentity();
        
        if ( isdefined( use_ent ) )
        {
            if ( isdefined( use_ent.equipmentref ) && use_ent.equipmentref == "equip_tac_insert" )
            {
                self botpressbutton( "use", 1 );
            }
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x870e
// Size: 0x444
function bot_think_revive()
{
    self notify( "bot_think_revive" );
    self endon( "bot_think_revive" );
    self endon( "bot_suspended" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( !level.teambased )
    {
        return;
    }
    
    if ( !islaststandenabled() && !isteamreviveenabled() )
    {
        return;
    }
    
    while ( true )
    {
        waittime = 2;
        var_199a5ebbb9ca9fa2 = getentarray( "revive_trigger", "targetname" );
        var_2b6486bbc80874ad = level.revivetriggers;
        revive_triggers = array_combine( var_199a5ebbb9ca9fa2, var_2b6486bbc80874ad );
        
        if ( revive_triggers.size > 0 )
        {
            waittime = 0.05;
        }
        
        level waittill_notify_or_timeout( "player_last_stand", waittime );
        
        if ( !bot_can_revive() )
        {
            self.isbotmedicrole = 0;
            continue;
        }
        
        var_199a5ebbb9ca9fa2 = getentarray( "revive_trigger", "targetname" );
        var_2b6486bbc80874ad = level.revivetriggers;
        revive_triggers = array_combine( var_199a5ebbb9ca9fa2, var_2b6486bbc80874ad );
        
        if ( revive_triggers.size == 0 )
        {
            continue;
        }
        
        var_10f56a3597f09ae = 1;
        totalteamplayers = scripts\mp\utility\teams::getteamdata( self.team, "teamCount" );
        
        if ( totalteamplayers < 4 )
        {
            var_10f56a3597f09ae = 0;
        }
        
        if ( revive_triggers.size > var_10f56a3597f09ae )
        {
            revive_triggers = sortbydistance( revive_triggers, self.origin );
            
            if ( isdefined( self.owner ) )
            {
                for ( i = 0; i < revive_triggers.size ; i++ )
                {
                    if ( revive_triggers[ i ].owner != self.owner )
                    {
                        continue;
                    }
                    
                    if ( i == 0 )
                    {
                        break;
                    }
                    
                    var_65a9dcf5e2e9fc21 = revive_triggers[ i ];
                    revive_triggers[ i ] = revive_triggers[ 0 ];
                    revive_triggers[ 0 ] = var_65a9dcf5e2e9fc21;
                    break;
                }
            }
        }
        
        foreach ( revive_trigger in revive_triggers )
        {
            player = revive_trigger.owner;
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player == self )
            {
                continue;
            }
            
            if ( islaststandenabled() && ( !isalive( player ) || isdefined( player.fauxdead ) || istrue( player.delayedspawnedplayernotify ) ) )
            {
                continue;
            }
            
            if ( player.team != self.team )
            {
                continue;
            }
            
            if ( islaststandenabled() && ( !isdefined( player.inlaststand ) || !player.inlaststand ) && !scripts\mp\utility\game::isteamreviveenabled() )
            {
                continue;
            }
            
            if ( isdefined( player.bots ) && isdefined( player.bots[ self.team ] ) && player.bots[ self.team ] > 0 )
            {
                continue;
            }
            
            if ( islaststandenabled() )
            {
                reviveorigin = player.origin;
            }
            else
            {
                reviveorigin = revive_trigger.origin;
            }
            
            if ( distancesquared( self.origin, reviveorigin ) < 4194304 )
            {
                extra_params = spawnstruct();
                extra_params.object = revive_trigger;
                extra_params.script_goal_radius = 64;
                
                if ( isdefined( self.last_revive_fail_time ) && gettime() - self.last_revive_fail_time < 1000 )
                {
                    extra_params.script_goal_radius = 32;
                }
                
                extra_params.start_thread = &watch_bot_died_during_revive;
                extra_params.end_thread = &stop_reviving;
                extra_params.should_abort = &player_revived_or_dead;
                extra_params.action_thread = &revive_player;
                revivepriority = 60;
                
                if ( scripts\mp\utility\teams::getteamdata( self.team, "aliveCount" ) == 1 )
                {
                    revivepriority = 100;
                }
                
                bot_new_tactical_goal( "revive", reviveorigin, revivepriority, extra_params );
                self.isbotmedicrole = 1;
                player.bots[ self.team ] = 1;
                break;
            }
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x8b5a
// Size: 0x31
function watch_bot_died_during_revive( goal )
{
    if ( islaststandenabled() )
    {
        thread bot_watch_for_death( goal.object.owner );
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x8b93
// Size: 0x4f
function stop_reviving( goal )
{
    if ( isdefined( goal.object.owner ) )
    {
        goal.object.owner.bots[ self.team ] = 0;
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x8bea
// Size: 0xe0, Type: bool
function player_revived_or_dead( goal )
{
    if ( islaststandenabled() )
    {
        if ( !isdefined( goal.object.owner ) || goal.object.owner.health <= 0 )
        {
            return true;
        }
        
        if ( !isdefined( goal.object.owner.inlaststand ) || !goal.object.owner.inlaststand )
        {
            return true;
        }
    }
    else if ( !isdefined( goal.object.owner ) || isreallyalive( goal.object.owner ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x8cd3
// Size: 0x21b
function revive_player( goal )
{
    if ( isdefined( goal.object.owner ) )
    {
        goal.object.owner.bots[ self.team ] = 1;
    }
    
    if ( islaststandenabled() )
    {
        goalorigincheck = goal.object.owner.origin;
    }
    else
    {
        goalorigincheck = goal.object.origin;
    }
    
    if ( distancesquared( self.origin, goalorigincheck ) > 4900 )
    {
        self.last_revive_fail_time = gettime();
        return;
    }
    
    if ( isagent( self ) )
    {
        val::reset_all( "agent_use" );
        goal.object enableplayeruse( self );
        wait 0.05;
    }
    
    prev_team = self.team;
    
    if ( islaststandenabled() )
    {
        use_time = level.laststandrevivetimer;
    }
    else if ( isdefined( goal.object.usetime ) )
    {
        use_time = goal.object.usetime / 1000;
    }
    else
    {
        use_time = 3;
    }
    
    self botlookatpoint( goal.object.origin, use_time + 1, "script_forced" );
    wait 0.5;
    self botpressbutton( "use", use_time + 0.5 );
    wait use_time + 1.5;
    
    if ( isdefined( goal.object.owner ) )
    {
        goal.object.owner.bots[ prev_team ] = 0;
    }
    
    if ( isagent( self ) )
    {
        val::set( "agent_use", "usability", 0 );
        
        if ( isdefined( goal.object ) )
        {
            goal.object disableplayeruse( self );
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x8ef6
// Size: 0xf1, Type: bool
function bot_can_revive()
{
    if ( isdefined( self.laststand ) && self.laststand == 1 )
    {
        return false;
    }
    
    if ( bot_has_tactical_goal( "revive" ) )
    {
        return false;
    }
    
    if ( bot_is_remote_or_linked() )
    {
        return false;
    }
    
    if ( bot_is_bodyguarding() )
    {
        return true;
    }
    
    if ( isdefined( level.bot_funcs[ "tactical_revive_override" ] ) )
    {
        result = self [[ level.bot_funcs[ "tactical_revive_override" ] ]]();
        
        if ( result )
        {
            self.isbotmedicrole = 0;
            return true;
        }
    }
    
    goaltype = self botgetscriptgoaltype();
    
    if ( goaltype == "none" || goaltype == "hunt" || goaltype == "guard" )
    {
        return true;
    }
    
    if ( goaltype == "objective" )
    {
        goal = self botgetscriptgoal();
        
        if ( distance( self.origin, goal ) > 500 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x8ff0
// Size: 0x3a
function revive_watch_for_finished( player )
{
    self endon( "death_or_disconnect" );
    self endon( "bad_path" );
    self endon( "goal" );
    player waittill_any_2( "death", "revived" );
    self notify( "bad_path" );
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x9032
// Size: 0x134
function bot_know_enemies_on_start()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( gettime() > 15000 )
    {
        return;
    }
    
    while ( !gamehasstarted() || !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        wait 0.05;
    }
    
    var_5ff5b48fd903f4f5 = undefined;
    var_ea273c648ae678dc = undefined;
    
    for ( enemyidx = 0; enemyidx < level.players.size ; enemyidx++ )
    {
        otherplayer = level.players[ enemyidx ];
        
        if ( isdefined( otherplayer ) && isdefined( self.team ) && isdefined( otherplayer.team ) && !isalliedsentient( self, otherplayer ) )
        {
            if ( !isdefined( otherplayer.bot_start_known_by_enemy ) )
            {
                var_5ff5b48fd903f4f5 = otherplayer;
            }
            
            if ( isai( otherplayer ) && !isdefined( otherplayer.bot_start_know_enemy ) )
            {
                var_ea273c648ae678dc = otherplayer;
            }
        }
    }
    
    if ( isdefined( var_5ff5b48fd903f4f5 ) )
    {
        self.bot_start_know_enemy = 1;
        var_5ff5b48fd903f4f5.bot_start_known_by_enemy = 1;
        self getenemyinfo( var_5ff5b48fd903f4f5 );
    }
    
    if ( isdefined( var_ea273c648ae678dc ) )
    {
        var_ea273c648ae678dc.bot_start_know_enemy = 1;
        self.bot_start_known_by_enemy = 1;
        var_ea273c648ae678dc getenemyinfo( self );
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x916e
// Size: 0x5d
function bot_think_gametype()
{
    self notify( "bot_think_gametype" );
    self endon( "bot_think_gametype" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    var_5076db025cbed16e = 0;
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        var_5076db025cbed16e = 1;
    }
    
    if ( !var_5076db025cbed16e )
    {
        scripts\mp\flags::gameflagwait( "prematch_done" );
    }
    
    self thread [[ level.bot_funcs[ "gametype_think" ] ]]();
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x91d3
// Size: 0x2
function default_gametype_think()
{
    
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x91dd
// Size: 0x85
function monitor_smoke_grenades()
{
    level.bot_smoke_sight_clip_large = getent( "smoke_grenade_sight_clip_256", "targetname" );
    
    if ( !isdefined( level.bot_smoke_sight_clip_large ) )
    {
        assertmsg( "<dev string:x5b9>" + "<dev string:x5e8>" + "<dev string:x608>" );
        return;
    }
    
    while ( true )
    {
        level waittill( "smoke", grenade, objweapon );
        
        if ( objweapon.basename == "smoke_grenade_mp" )
        {
            grenade thread handle_smoke();
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x926a
// Size: 0x2e
function handle_smoke()
{
    self endon( "late_death" );
    thread smoke_grenade_late_death();
    self waittill( "explode", explosion_location );
    thread create_smoke_occluder( explosion_location );
}

// Namespace bots / scripts\mp\bots\bots
// Params 2
// Checksum 0x0, Offset: 0x92a0
// Size: 0x6b
function create_smoke_occluder( origin, overrideduration )
{
    occluder = spawn( "script_model", origin );
    occluder show();
    wait 1;
    occluder clonebrushmodeltoscriptmodel( level.bot_smoke_sight_clip_large );
    occluder setmovertransparentvolume();
    duration = 8.75;
    
    if ( isdefined( overrideduration ) )
    {
        duration = overrideduration;
    }
    
    wait duration;
    occluder delete();
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x9313
// Size: 0x1a
function smoke_grenade_late_death()
{
    self endon( "explode" );
    self waittill( "death" );
    waittillframeend();
    self notify( "late_death" );
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x9335
// Size: 0x139
function bot_add_scavenger_bag( dropbag )
{
    added = 0;
    dropbag.boxtype = "scavenger_bag";
    dropbag.boxtouchonly = 1;
    
    if ( !isdefined( level.bot_scavenger_bags ) )
    {
        level.bot_scavenger_bags = [];
    }
    
    foreach ( index, existingbag in level.bot_scavenger_bags )
    {
        if ( !isdefined( existingbag ) )
        {
            added = 1;
            level.bot_scavenger_bags[ index ] = dropbag;
            break;
        }
    }
    
    if ( !added )
    {
        level.bot_scavenger_bags[ level.bot_scavenger_bags.size ] = dropbag;
    }
    
    foreach ( participant in level.participants )
    {
        if ( isai( participant ) && participant _hasperk( "specialty_scavenger" ) )
        {
            participant notify( "new_crate_to_take" );
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x9476
// Size: 0xa5
function bot_triggers()
{
    var_750831cedcd7f13e = getentarray( "bot_flag_set", "targetname" );
    
    foreach ( trigger in var_750831cedcd7f13e )
    {
        if ( !isdefined( trigger.script_noteworthy ) )
        {
            assertmsg( "<dev string:x64c>" + trigger.origin + "<dev string:x664>" );
            continue;
        }
        
        trigger thread bot_flag_trigger( trigger.script_noteworthy );
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x9523
// Size: 0x56
function bot_flag_trigger( flag_name )
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "trigger", bot );
        
        if ( scripts\cp_mp\utility\game_utility::isaigameparticipant( bot ) )
        {
            bot notify( "flag_trigger_set_" + flag_name );
            bot botsetflag( flag_name, 1 );
            bot thread bot_flag_trigger_clear( flag_name );
        }
    }
}

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x9581
// Size: 0x2d
function bot_flag_trigger_clear( flag_name )
{
    self endon( "flag_trigger_set_" + flag_name );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    waitframe();
    waittillframeend();
    self botsetflag( flag_name, 0 );
}

/#

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x95b6
    // Size: 0x1f6, Type: dev
    function function_361fab20102e6557()
    {
        level endon( "<dev string:x1c>" );
        
        while ( true )
        {
            var_c2985b5ae5fee336 = getdvarint( @"hash_d2c1e13b48beed87", 0 );
            
            if ( var_c2985b5ae5fee336 )
            {
                setdvar( @"hash_d2c1e13b48beed87", 0 );
                host = scripts\mp\dev::devfindhost();
                
                if ( !isdefined( host ) )
                {
                    continue;
                }
                
                spawnorigin = function_b771795f421ef637( host );
                
                if ( !isdefined( spawnorigin ) )
                {
                    continue;
                }
                
                spawnorigin = getclosestpointonnavmesh( spawnorigin );
                var_93bed5aae5070beb = host getplayerangles();
                spawnangles = ( 0, var_93bed5aae5070beb[ 1 ] + 180, 0 );
                
                if ( var_c2985b5ae5fee336 == 2 )
                {
                    setdvar( @"hash_5e767ceb6b77e053", -2 );
                }
                else
                {
                    setdvar( @"hash_5e767ceb6b77e053", -3 );
                }
                
                setdvar( @"hash_2d5236cbe9894aff", 1 );
                level waittill( "<dev string:x690>", player );
                player setorigin( spawnorigin );
                player setplayerangles( spawnangles );
                setdvar( @"hash_5e767ceb6b77e053", 0 );
            }
            
            var_e9b4a948c50db028 = getdvarint( @"hash_39a9059930f4ca30", 0 );
            
            if ( var_e9b4a948c50db028 )
            {
                setdvar( @"hash_39a9059930f4ca30", 0 );
                host = scripts\mp\dev::devfindhost();
                
                if ( !isdefined( host ) )
                {
                    continue;
                }
                
                if ( var_e9b4a948c50db028 == 2 )
                {
                    team = host.team;
                }
                else
                {
                    team = scripts\engine\utility::get_enemy_team( host.team );
                }
                
                spawnorigin = function_b771795f421ef637( host );
                
                if ( !isdefined( spawnorigin ) )
                {
                    continue;
                }
                
                var_93bed5aae5070beb = host getplayerangles();
                spawnangles = ( 0, var_93bed5aae5070beb[ 1 ] + 180, 0 );
                fixedspawndata = spawnstruct();
                fixedspawndata.origin = spawnorigin;
                fixedspawndata.angles = spawnangles;
                level thread [[ level.bot_funcs[ "<dev string:x6a2>" ] ]]( 1, team, undefined, undefined, undefined, undefined, fixedspawndata );
            }
            
            waitframe();
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x97b4
    // Size: 0x16d, Type: dev
    function function_c71139dd1c600b64()
    {
        level endon( "<dev string:x1c>" );
        
        while ( true )
        {
            var_80037671e3f2ed57 = getdvarint( @"hash_8cd9f80a99bccf2f", 0 );
            
            if ( var_80037671e3f2ed57 )
            {
                setdvar( @"hash_8cd9f80a99bccf2f", 0 );
                
                if ( !isdefined( level.var_6d4b0d324eef7492 ) )
                {
                    continue;
                }
                
                switch ( var_80037671e3f2ed57 )
                {
                    case 1:
                        var_9369cf0d229589 = "<dev string:x6b0>";
                        var_7d14e075a8fac17e = 999;
                        break;
                    case 2:
                        var_9369cf0d229589 = "<dev string:xed>";
                        var_7d14e075a8fac17e = 999;
                        break;
                    case 3:
                        var_9369cf0d229589 = "<dev string:xf7>";
                        var_7d14e075a8fac17e = 999;
                        break;
                    default:
                        var_9369cf0d229589 = "<dev string:x6b0>";
                        var_7d14e075a8fac17e = 1;
                        break;
                }
                
                foreach ( bot in level.var_6d4b0d324eef7492 )
                {
                    if ( var_7d14e075a8fac17e <= 0 )
                    {
                        break;
                    }
                    
                    if ( var_9369cf0d229589 == "<dev string:x6b0>" || var_9369cf0d229589 == bot.team )
                    {
                        kick( bot getentitynumber() );
                    }
                    
                    var_7d14e075a8fac17e--;
                }
                
                level.var_6d4b0d324eef7492 = array_removeundefined( level.var_6d4b0d324eef7492 );
            }
            
            waitframe();
        }
    }

#/

// Namespace bots / scripts\mp\bots\bots
// Params 1
// Checksum 0x0, Offset: 0x9929
// Size: 0xba
function function_b771795f421ef637( player )
{
    angles = player getplayerangles();
    fwd = anglestoforward( angles );
    eye = player geteye();
    end = eye + fwd * 10000;
    traces = scripts\engine\trace::ray_trace_get_all_results( eye, end );
    
    foreach ( trace in traces )
    {
        if ( !isdefined( trace[ "entity" ] ) )
        {
            return trace[ "position" ];
        }
    }
    
    return undefined;
}

// Namespace bots / scripts\mp\bots\bots
// Params 0
// Checksum 0x0, Offset: 0x99ec
// Size: 0xa6
function function_8e439247eeca6302()
{
    self botsetflag( "disable_movement", 1 );
    self botsetflag( "disable_rotation", 1 );
    self botsetflag( "disable_attack", 1 );
    self.ignoreall = 1;
    origin = getclosestpointonnavmesh( default_to( self.pers[ #"fixedspawnorigin" ], self.origin ) );
    angles = default_to( self.pers[ #"fixedspawnangles" ], self.angles );
    self setorigin( origin );
    self setplayerangles( angles );
}

// Namespace bots / scripts\mp\bots\bots
// Params 2
// Checksum 0x0, Offset: 0x9a9a
// Size: 0x3d
function function_22577987c6639704( neworigin, newangles )
{
    self.pers[ #"fixedspawnorigin" ] = neworigin;
    self.pers[ #"fixedspawnangles" ] = newangles;
}

/#

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x9adf
    // Size: 0x18a, Type: dev
    function function_8c79a04b049a7ea2()
    {
        level endon( "<dev string:x1c>" );
        
        while ( true )
        {
            var_a074ce85487e9da0 = getdvarint( @"hash_670fcefaa6d8a693", 0 );
            
            if ( var_a074ce85487e9da0 )
            {
                setdvar( @"hash_670fcefaa6d8a693", 0 );
                
                if ( var_a074ce85487e9da0 == 3 && isdefined( level.testdummy ) )
                {
                    kick( level.testdummy getentitynumber() );
                    level.testdummy = undefined;
                    continue;
                }
                
                host = scripts\mp\dev::devfindhost();
                
                if ( !isdefined( host ) )
                {
                    continue;
                }
                
                team = scripts\engine\utility::get_enemy_team( host.team );
                
                if ( var_a074ce85487e9da0 == 1 )
                {
                    spawnorigin = function_b771795f421ef637( host );
                    
                    if ( !isdefined( spawnorigin ) )
                    {
                        continue;
                    }
                    
                    var_93bed5aae5070beb = host getplayerangles();
                    spawnangles = ( 0, var_93bed5aae5070beb[ 1 ] + 180, 0 );
                }
                else
                {
                    results = level function_5723f098aabd9836( host );
                    
                    if ( !isdefined( results ) )
                    {
                        continue;
                    }
                    
                    spawnorigin = results[ "<dev string:x6b7>" ];
                    spawnangles = results[ "<dev string:x6c1>" ];
                }
                
                if ( isdefined( level.testdummy ) )
                {
                    level function_6ff6a20ce4521fa9( spawnorigin, spawnangles );
                    continue;
                }
                
                fixedspawndata = spawnstruct();
                fixedspawndata.origin = spawnorigin;
                fixedspawndata.angles = spawnangles;
                level thread [[ level.bot_funcs[ "<dev string:x6a2>" ] ]]( 1, team, &function_8af1863f5e7ade4a, undefined, undefined, undefined, fixedspawndata );
            }
            
            waitframe();
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x9c71
    // Size: 0x16, Type: dev
    function function_8af1863f5e7ade4a()
    {
        level.testdummy = self;
        function_5188aadb27d72a11();
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 2
    // Checksum 0x0, Offset: 0x9c8f
    // Size: 0x74, Type: dev
    function function_6ff6a20ce4521fa9( origin, angles )
    {
        level.testdummy.pers[ #"fixedspawnorigin" ] = origin;
        level.testdummy.pers[ #"fixedspawnangles" ] = angles;
        level.testdummy setorigin( origin );
        level.testdummy setplayerangles( angles );
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x9d0b
    // Size: 0x70, Type: dev
    function function_5188aadb27d72a11()
    {
        host = scripts\mp\dev::devfindhost();
        
        if ( !isdefined( self.hud ) )
        {
            function_e53f5c23f0a7a78f( host );
        }
        
        self.var_2fc19f3a438f03a5 = 0;
        self.var_b0ab2dca24bfe60a = 0;
        self.firstdamagetime = undefined;
        self.fnbotdamagecallback = &function_b09b8c00320b91e;
        thread function_6e65c3faa4356411();
        thread function_c87dcea241ae074d();
        thread function_51da8c98ef44eceb();
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 8
    // Checksum 0x0, Offset: 0x9d83
    // Size: 0x240, Type: dev
    function function_b09b8c00320b91e( eattacker, idamage, smeansofdeath, objweapon, einflictor, shitloc, vpoint, lightarmordamage )
    {
        if ( !isdefined( lightarmordamage ) )
        {
            lightarmordamage = 0;
        }
        
        host = scripts\mp\dev::devfindhost();
        
        if ( !isdefined( host ) || eattacker != host )
        {
            return;
        }
        
        self.var_2fc19f3a438f03a5++;
        self.var_b0ab2dca24bfe60a += idamage + lightarmordamage;
        
        if ( !isdefined( self.firstdamagetime ) )
        {
            self.firstdamagetime = gettime();
        }
        
        source_pos = eattacker == einflictor ? eattacker geteye() : self.origin;
        range = distance( source_pos, vpoint );
        weap_token = strtok( getcompleteweaponname( objweapon ), "<dev string:x6cb>" );
        weap_name = "<dev string:x41>";
        
        foreach ( tok in weap_token )
        {
            weap_name += tok + "<dev string:x6d0>";
        }
        
        if ( isdefined( self.armorhealth ) )
        {
            self.menu[ "<dev string:x6d5>" ] setvalue( self.armorhealth );
        }
        
        self.menu[ "<dev string:x6de>" ] setvalue( self.health );
        self.menu[ "<dev string:x6e8>" ] setvalue( idamage + lightarmordamage );
        self.menu[ "<dev string:x6f2>" ] setvalue( self.var_b0ab2dca24bfe60a );
        self.menu[ "<dev string:x701>" ] setvalue( self.var_2fc19f3a438f03a5 );
        self.menu[ "<dev string:x709>" ] setvalue( range );
        self.menu[ "<dev string:x712>" ] setdevtext( shitloc );
        self.menu[ "<dev string:x71c>" ] setdevtext( weap_name );
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0x9fcb
    // Size: 0x59, Type: dev
    function function_6e65c3faa4356411()
    {
        self endon( "<dev string:x2f3>" );
        
        for ( ;; )
        {
            waitframe();
            
            if ( isdefined( self.armorhealth ) )
            {
                self.menu[ "<dev string:x6d5>" ] setvalue( self.armorhealth );
            }
            
            self.menu[ "<dev string:x6de>" ] setvalue( self.health );
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0xa02c
    // Size: 0x6f, Type: dev
    function function_c87dcea241ae074d()
    {
        self waittill( "<dev string:x2f3>" );
        self.hud destroy();
        
        foreach ( menu in self.menu )
        {
            menu destroy();
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 0
    // Checksum 0x0, Offset: 0xa0a3
    // Size: 0x30, Type: dev
    function function_51da8c98ef44eceb()
    {
        self endon( "<dev string:x2f3>" );
        
        while ( true )
        {
            self waittill( "<dev string:x301>" );
            self.var_2fc19f3a438f03a5 = 0;
            self.var_b0ab2dca24bfe60a = 0;
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 1
    // Checksum 0x0, Offset: 0xa0db
    // Size: 0xd5, Type: dev
    function function_5723f098aabd9836( host )
    {
        host endon( "<dev string:x301>" );
        host endon( "<dev string:x2f3>" );
        placementmodel = spawn( "<dev string:x726>", ( 0, 0, 0 ) );
        placementmodel setmodel( "<dev string:x736>" );
        
        for ( ;; )
        {
            waitframe();
            spawnorigin = function_b771795f421ef637( host );
            
            if ( !isdefined( spawnorigin ) )
            {
                continue;
            }
            
            var_93bed5aae5070beb = host getplayerangles();
            spawnangles = ( 0, var_93bed5aae5070beb[ 1 ] + 180, 0 );
            placementmodel.origin = spawnorigin;
            placementmodel.angles = spawnangles;
            
            if ( host usebuttonpressed() )
            {
                results = [];
                results[ "<dev string:x6b7>" ] = spawnorigin;
                results[ "<dev string:x6c1>" ] = spawnangles;
                placementmodel delete();
                return results;
            }
        }
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 1
    // Checksum 0x0, Offset: 0xa1b8
    // Size: 0x2f3, Type: dev
    function function_e53f5c23f0a7a78f( host )
    {
        x = -40;
        y = 145;
        scale = 0.9;
        self.hud = host function_829a24c34a7fda26( "<dev string:x749>", x, y, scale, 0.6, 10 );
        menu = [];
        menux = x + 5;
        
        if ( isdefined( host.armorhealth ) )
        {
            menu[ menu.size ] = host function_829a24c34a7fda26( "<dev string:x757>", menux, y + 10 * ( menu.size + 1 ), scale );
        }
        
        menu[ menu.size ] = host function_829a24c34a7fda26( "<dev string:x762>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_829a24c34a7fda26( "<dev string:x76e>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_829a24c34a7fda26( "<dev string:x77a>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_829a24c34a7fda26( "<dev string:x78c>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_829a24c34a7fda26( "<dev string:x7a0>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_829a24c34a7fda26( "<dev string:x7b2>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_829a24c34a7fda26( "<dev string:x7bd>", menux, y + 10 * ( menu.size + 1 ), scale );
        menu[ menu.size ] = host function_829a24c34a7fda26( "<dev string:x7cf>", menux, y + 10 * ( menu.size + 1 ), scale );
        menux = x + 85;
        indexoffset = menu.size;
        
        if ( isdefined( host.armorhealth ) )
        {
            menu[ "<dev string:x6d5>" ] = host function_829a24c34a7fda26( "<dev string:x41>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        }
        
        menu[ "<dev string:x6de>" ] = host function_829a24c34a7fda26( "<dev string:x41>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x6e8>" ] = host function_829a24c34a7fda26( "<dev string:x41>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x6f2>" ] = host function_829a24c34a7fda26( "<dev string:x41>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x701>" ] = host function_829a24c34a7fda26( "<dev string:x41>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x4f9>" ] = host function_829a24c34a7fda26( "<dev string:x41>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x709>" ] = host function_829a24c34a7fda26( "<dev string:x41>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x712>" ] = host function_829a24c34a7fda26( "<dev string:x41>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        menu[ "<dev string:x71c>" ] = host function_829a24c34a7fda26( "<dev string:x41>", menux, y + 10 * ( menu.size + 1 - indexoffset ), scale );
        self.menu = menu;
    }

    // Namespace bots / scripts\mp\bots\bots
    // Params 6
    // Checksum 0x0, Offset: 0xa4b3
    // Size: 0x124, Type: dev
    function function_829a24c34a7fda26( text, x, y, scale, alpha, sort )
    {
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        if ( !isdefined( sort ) )
        {
            sort = 20;
        }
        
        hudelem = newclienthudelem( self );
        hudelem.elemtype = "<dev string:x7db>";
        hudelem.alpha = alpha;
        hudelem.font = "<dev string:x14c>";
        hudelem.fontscale = scale;
        hudelem.basefontscale = scale;
        hudelem.sort = sort;
        hudelem.x = x;
        hudelem.y = y;
        hudelem.archived = 0;
        hudelem.foreground = 1;
        hudelem.hidewhendead = 1;
        hudelem.hidewheninmenu = 1;
        
        if ( isdefined( text ) && text.size > 0 )
        {
            hudelem setdevtext( text );
        }
        
        return hudelem;
    }

#/
