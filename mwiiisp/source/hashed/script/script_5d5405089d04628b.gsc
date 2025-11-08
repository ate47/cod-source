#using script_1031976741eb6674;
#using script_4fd531b693fc2ff3;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\scene;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio;
#using scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_fx;
#using scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_lighting;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_death;
#using scripts\sp\player_rig;
#using scripts\sp\starts;
#using scripts\sp\utility;

#namespace namespace_a35eea5f35ca76c1;

/#

    // Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
    // Params 0
    // Checksum 0x0, Offset: 0xdbc
    // Size: 0x5, Type: dev
    function function_f5b68486b45309f9()
    {
        
    }

#/

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0xdc9
// Size: 0x1a0
function function_6ea5b8f6f2554f9f()
{
    function_eff09671c6af36fd();
    var_ca9b9b3e50107c9a = spawn_tag_origin();
    var_ca9b9b3e50107c9a linktoplayerview( level.player, "tag_origin", ( 0, 0, 0 ) );
    var_af88bf2dde1be969 = getstruct( "scene_jup_tun_0010_intro", "targetname" );
    var_af88bf2dde1be969 scene::add_spawn_function( &namespace_4eea8ced69a1ec9f::function_2b41de2f0232c20a, "price" );
    var_af88bf2dde1be969 scene::function_8207074e79f22926( self, "swap_mask", "plr_mask" );
    ice_surface_broken = getent( "ice_surface_broken", "targetname" );
    ice_surface_broken hide();
    level notify( "audio_underwater_intro_mute_clear" );
    thread function_d8bd34ff21ea2388();
    level thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio::function_3cb460d33aaa813e();
    var_af88bf2dde1be969 scene::play( [ level.ally01, level.ally02 ], "shot_010" );
    thread function_4530fb7445646b43();
    hq_drilling_ice = getent( "hq_drilling_ice", "targetname" );
    hq_drilling_ice hide();
    level thread function_f714a8596d55fdc6();
    var_673a459e17561ef0 = var_af88bf2dde1be969 scene::function_d9be975d8d1c9db3( "shot_020" );
    delaythread( var_673a459e17561ef0 - 5.25, &function_193a23b49e477ce8 );
    var_af88bf2dde1be969 scene::play( [ level.ally01, level.ally02 ], "shot_020" );
    flag_set( "dof_before_trigger_ready" );
    killfxontag( level._effect[ "vfx_water_diver_bubble_trail_1_main" ], level.price, "j_head" );
    level.price delete();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0xf71
// Size: 0xe
function function_193a23b49e477ce8()
{
    hidecinematicletterboxing( 1.5, 0 );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0xf87
// Size: 0x19
function function_4530fb7445646b43()
{
    level waittill( "swap_mask" );
    level.scuba_mask show();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0xfa8
// Size: 0x13
function function_d8bd34ff21ea2388()
{
    wait 0.5;
    setmusicstate( "mx_tundra_lakeintro" );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xfc3
// Size: 0x37
function private function_eff09671c6af36fd()
{
    level.var_75f4a600d9223c98 = 1;
    level.var_c6eed567148e0ee8 = getdvarint( @"hash_863a2044d629615", 24 );
    setsaveddvar( @"hash_25fd1d18d38c336a", 24 );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1002
// Size: 0x4e
function private function_bfd82aa59ed89de1()
{
    if ( istrue( level.var_75f4a600d9223c98 ) && isdefined( level.var_c6eed567148e0ee8 ) )
    {
        level.var_c6eed567148e0ee8 = getdvarint( @"hash_863a2044d629615", 24 );
        setsaveddvar( @"hash_863a2044d629615", level.var_c6eed567148e0ee8 );
    }
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 1
// Checksum 0x0, Offset: 0x1058
// Size: 0x201
function function_b7b1d8d64bd66324( var_ca9b9b3e50107c9a )
{
    level.scuba_mask unlinkfromplayerview( level.player );
    endpos = ( 81600.2, 548.823, 178.181 );
    endangles = ( 350.23, 279.95, 3.04 );
    fwd_angles = anglestoforward( endangles );
    startingpos = endpos - fwd_angles * 10;
    lerptime = 6.96;
    intervaltime = 0.5;
    interval = lerptime / intervaltime;
    level.scuba_mask.origin = startingpos;
    level.scuba_mask.angles = endangles;
    level.scuba_mask delaycall( 5, &show );
    
    while ( interval > 0 )
    {
        movevector = endpos - startingpos;
        lerpvector = movevector / interval;
        lerppos = startingpos + lerpvector;
        var_dd4bad131228ea4 = endangles;
        level.scuba_mask moveto( lerppos, intervaltime );
        level.scuba_mask rotateto( var_dd4bad131228ea4, intervaltime - 0.02 );
        wait intervaltime;
        startingpos = level.scuba_mask.origin;
        interval -= 1;
        endangles = var_ca9b9b3e50107c9a.angles;
        dist = distance_2d_squared( endpos, var_ca9b9b3e50107c9a.origin );
        
        if ( dist > 800 )
        {
            endpos = ( 81600.2, 548.823, 178.181 );
            continue;
        }
        
        endpos = var_ca9b9b3e50107c9a.origin;
    }
    
    var_ca9b9b3e50107c9a unlinkfromplayerview( level.player );
    level.scuba_mask linktoplayerview( level.player, "tag_origin", ( 0, 0, 0 ) );
}

/#

    // Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
    // Params 0
    // Checksum 0x0, Offset: 0x1261
    // Size: 0x5, Type: dev
    function function_4236133744253927()
    {
        
    }

#/

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x126e
// Size: 0x3fd
function function_b6da8bf3044d28d5()
{
    scripts\sp\player_rig::init_player_rig( "vm_c_jup_sp_hero_price_tundra_diver", undefined, undefined, 0 );
    hq_drilling_ice = getent( "hq_drilling_ice", "targetname" );
    hq_drilling_ice hide();
    scene_0110 = getstruct( "scene_jup_tun_0110_scuba_detonator", "targetname" );
    scene_0110 scene::function_8207074e79f22926( level.ally01, "end", "ally01", 1 );
    scene_0110 scene::function_8207074e79f22926( level.ally01, "ally01_fist", "ally01", 1 );
    scene_0110 scene::function_8207074e79f22926( level.ally02, "end", "ally02", 1 );
    scene_0110 thread scene::play( [ level.player, level.ally01, level.ally02 ], "enter" );
    level.var_6fdefac938b887d5 = scene_0110 scene::get_entity( "clacker" );
    level.var_6fdefac938b887d5 castshadows();
    level.player castshadows();
    scene_0110 scene::function_8207074e79f22926( level.player, "end", "player" );
    level.player waittill( "end" );
    flag_set( "dof_after_trigger_ready" );
    scene_0110 thread scene::play( [ level.player, level.ally01, level.ally02, level.var_6fdefac938b887d5 ], "loop" );
    level.player allowprone( 0 );
    exploder( "vfx_vehicle_drive_shadows" );
    level.ally01 waittill( "ally01_fist" );
    var_fc60b65586ce400 = getent( "water_explosion_center", "targetname" );
    detonate_hint = getstruct( "s_detonator_prompt", "targetname" );
    detonate_hint.origin = var_fc60b65586ce400.origin;
    detonate_hint scripts\sp\player\cursor_hint::create_cursor_hint( undefined, ( 170, 0, -270 ), &"SP_JUP_TUNDRA/LAKE_DETONATE_HINT", undefined, 10000, 10000, 1 );
    level thread function_319c2f097ede51e0( "scene_jup_tun_0100_scuba_crash", level.suvs, "drive" );
    level thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_lighting::function_76d126b1903cb419();
    player_response = detonate_hint waittill_any_timeout( 3.5, "trigger" );
    knifeweapon = make_weapon( "jup_knife_diver_sp" );
    level.player give_weapon( knifeweapon );
    level.player switchtoweapon( knifeweapon );
    flag_set( "dof_after_explosion" );
    
    if ( player_response == "timeout" )
    {
        level notify( "detonation_fail" );
        flag_set( "detonation_fail" );
        
        if ( isdefined( detonate_hint ) )
        {
            detonate_hint scripts\sp\player\cursor_hint::remove_cursor_hint();
        }
        
        wait 3;
        scene_0110 thread scene::function_bc521bee52fde214( 0.05 );
        scripts\sp\player_death::set_custom_death_quote( 513, 0 );
        scripts\sp\utility::missionfailedwrapper();
        level waittill( "forever" );
    }
    
    utility::flag_set( "flag_lake_detonate_triggered" );
    level thread function_a3f4f9c3f405b0c0();
    noself_delaycall( 0.2, &earthquake, 0.2, 4, level.player.origin, 850 );
    utility::flag_set( "flag_lake_detonate_success" );
    function_bfd82aa59ed89de1();
    level thread function_ee6fe6ad6f81480b();
    scene_0110 thread scene::play( [ level.player, level.ally01, level.ally02 ], "exit" );
    waitframe();
    level.ally01 waittill( "end" );
    level thread function_befd36dbc348f28();
    utility::flag_set( "lake_detonate_complete" );
    level.ally02 waittill( "end" );
    utility::flag_set( "ally01_exit_scene_0110" );
    level.var_6fdefac938b887d5 delete();
    scene_0110 scene::cleanup();
    level.player allowprone( 1 );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x1673
// Size: 0x2d
function function_ee6fe6ad6f81480b()
{
    level thread function_8003dec5036a7051();
    level thread function_560a94ab6cf8eba6();
    wait 2;
    function_d17322afcc5c21a2();
    wait 9;
    level thread function_59c82d5a588507fd();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x16a8
// Size: 0x16f
function function_d17322afcc5c21a2()
{
    level.suvs[ 0 ] setmodel( "jup_veh9_overland_2016_crashed" );
    level.suvs[ 0 ] hidepart( "TAG_WINDSHIELD_FRONT" );
    level.suvs[ 0 ] hidepart( "TAG_WINDSHIELD_FRONT_PRISTINE" );
    level.suvs[ 0 ] hidepart( "TAG_WINDSHIELD_FRONT_WEB" );
    var_bc60742de6e979ab = getstruct( "scene_jup_tun_0100_scuba_crash", "targetname" );
    var_bc60742de6e979ab scene::function_8207074e79f22926( level.suvs[ 0 ], "reached_final_pos", "veh01" );
    var_bc60742de6e979ab scene::function_8207074e79f22926( level.suvs[ 1 ], "veh02_reached_final_position", "veh02" );
    var_bc60742de6e979ab scene::function_8207074e79f22926( level.suvs[ 2 ], "veh03_reached_final_position", "veh03" );
    var_bc60742de6e979ab scene::function_8207074e79f22926( level.suvs[ 3 ], "veh04_reached_final_position", "veh04" );
    var_bc60742de6e979ab scene::add_spawn_function( &function_4b9be0750ff5f45c, "tire" );
    var_bc60742de6e979ab thread function_afdc639ee731bc9e();
    var_bc60742de6e979ab thread scene::play( level.suvs, "sink" );
    var_bc60742de6e979ab childthread function_a011efa52572363();
    level.var_5f8d34a255220522 = var_bc60742de6e979ab scene::get_entity( "driver" );
    level.var_534e69ffec2d477d = var_bc60742de6e979ab scene::get_entity( "ally02_takedown_enemy" );
    level.var_cfe3ebf991d178d6 = var_bc60742de6e979ab scene::get_entity( "takedown_enemy_mask" );
    level thread function_90740a4b975511e1();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x181f
// Size: 0x40
function function_4b9be0750ff5f45c()
{
    waitframe();
    tire_clip = getent( "uw_floating_tire_clip", "targetname" );
    
    if ( !isdefined( tire_clip ) )
    {
        return;
    }
    
    tire_clip.origin = self.origin;
    tire_clip linkto( self );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x1867
// Size: 0x197
function function_61c75b78e987d72d()
{
    veh01[ 0 ] = ( 81945.7, -51.124, 163.884 );
    veh01[ 1 ] = ( 0.331, 89.51, -2.876 );
    veh02[ 0 ] = ( 81478, -204.896, 155.706 );
    veh02[ 1 ] = ( 3.786, 102.726, -85.925 );
    veh03[ 0 ] = ( 81444.4, 195.534, 157.601 );
    veh03[ 1 ] = ( 358.22, 310.056, -34.986 );
    veh04[ 0 ] = ( 81776, -505.849, 181.599 );
    veh04[ 1 ] = ( 351.816, 314.866, 175.286 );
    array_call( level.suvs, &stopanimscripted );
    level.suvs[ 0 ].origin = veh01[ 0 ];
    level.suvs[ 0 ].angles = veh01[ 1 ];
    level.suvs[ 1 ].origin = veh02[ 0 ];
    level.suvs[ 1 ].angles = veh02[ 1 ];
    level.suvs[ 2 ].origin = veh03[ 0 ];
    level.suvs[ 2 ].angles = veh03[ 1 ];
    level.suvs[ 3 ].origin = veh04[ 0 ];
    level.suvs[ 3 ].angles = veh04[ 1 ];
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x1a06
// Size: 0x1ce
function function_afdc639ee731bc9e()
{
    level endon( "targetExtract" );
    var_77d6d84562a4c50 = getstruct( "scene_jup_tun_0120_rlp_death", "targetname" );
    veh02_driver = getstruct( "scene_jup_tun_0120_veh02_driver_death", "targetname" );
    veh03_shotgun = getstruct( "scene_jup_tun_0130_veh03_shotgun_death", "targetname" );
    veh03_driver = getstruct( "scene_jup_tun_0130_veh03_driver_death", "targetname" );
    var_67b78e62ed65a313 = getstruct( "scene_jup_tun_0130_veh03_rlp_death", "targetname" );
    
    if ( !is_after_start( "lake_detonate" ) )
    {
        level.suvs[ 1 ] waittill( "veh02_reached_final_position" );
        flag_set( "veh02_finished_sinking" );
    }
    
    var_77d6d84562a4c50 function_147d0733986c4ccd( level.suvs[ 1 ], "TAG_ORIGIN", "death_float" );
    var_77d6d84562a4c50 scene::add_spawn_function( &function_b19b8734383e8d3a, "veh02_passenger_rear_left" );
    veh02_driver function_147d0733986c4ccd( level.suvs[ 1 ], "TAG_SEAT_0", "death_float" );
    veh02_driver scene::add_spawn_function( &function_b19b8734383e8d3a, "veh02_driver" );
    
    if ( !is_after_start( "lake_detonate" ) )
    {
        level.suvs[ 2 ] waittill( "veh03_reached_final_position" );
    }
    
    veh03_shotgun function_147d0733986c4ccd( level.suvs[ 2 ], "TAG_ORIGIN_STATIC", "death_float" );
    veh03_shotgun scene::add_spawn_function( &function_b19b8734383e8d3a, "veh03_shotgun" );
    veh03_driver function_147d0733986c4ccd( level.suvs[ 2 ], "TAG_SEAT_0", "death_float" );
    veh03_driver scene::add_spawn_function( &function_b19b8734383e8d3a, "veh03_driver" );
    var_67b78e62ed65a313 function_147d0733986c4ccd( level.suvs[ 2 ], "TAG_ORIGIN", "death_float" );
    var_67b78e62ed65a313 scene::add_spawn_function( &function_b19b8734383e8d3a, "veh03_passenger_rear_left" );
}

/#

    // Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
    // Params 0
    // Checksum 0x0, Offset: 0x1bdc
    // Size: 0x5, Type: dev
    function function_d53465ae7602138b()
    {
        
    }

#/

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x1be9
// Size: 0x5e
function function_55072791234e5e42()
{
    level endon( "targetExtract" );
    animnode = getstruct( "scene_jup_tun_0100_scuba_crash", "targetname" );
    
    if ( is_after_start( "lake_detonate" ) )
    {
        level thread function_90740a4b975511e1( 1 );
    }
    else
    {
        flag_wait( "ally01_exit_scene_0110" );
    }
    
    level childthread function_c423fae71a746dff();
    level childthread function_3df285723c8fc440();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x1c4f
// Size: 0x10b
function function_c423fae71a746dff()
{
    animnode = getstruct( "scene_jup_tun_0111_scuba_car01_takedown", "targetname" );
    animnode scene::function_8207074e79f22926( level.ally02, "end", "ally02" );
    anim_ents = [ level.ally02, level.suvs[ 0 ] ];
    level.ally02 scripts\anim\shared::dropallaiweapons();
    
    if ( isdefined( level.var_534e69ffec2d477d ) )
    {
        anim_ents = array_add( anim_ents, level.var_534e69ffec2d477d );
        level.var_534e69ffec2d477d function_b19b8734383e8d3a();
    }
    else
    {
        animnode scene::add_spawn_function( &function_b19b8734383e8d3a, "ally02_takedown_enemy" );
    }
    
    animnode thread scene::play( anim_ents, "ally_takedown" );
    ally02_knife = animnode scene::get_entity( "ally02_knife" );
    level.ally02 waittill( "end" );
    flag_set( "flg_lake_soap_takedown_complete" );
    
    if ( isdefined( ally02_knife ) )
    {
        ally02_knife delete();
    }
    
    level thread function_fcf930eedc91f95();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x1d62
// Size: 0x28e
function function_3df285723c8fc440()
{
    animnode = getstruct( "scene_jup_tun_0112_scuba_car1_plyr_takedown", "targetname" );
    s_interact = getstruct( "s_veh01_enemy_interact", "targetname" );
    animnode scene::function_8207074e79f22926( level.player, "start_ally_takedown_veh02", "player" );
    level thread function_e6c8b7c32ff9e04b( 1 );
    animnode thread scene::play( level.var_5f8d34a255220522, "loop" );
    
    if ( !isdefined( level.var_5f8d34a255220522 ) )
    {
        level.var_5f8d34a255220522 = animnode scene::get_entity( "driver" );
    }
    
    level.var_5f8d34a255220522 function_711cf70929ee1bf5();
    flag_set( "takedown_unavailable" );
    level.player.var_c010264d86a473fc = s_interact;
    level.player.var_c010264d86a473fc.msg = "drown";
    level.player.var_c010264d86a473fc namespace_8339f6377b6ba60e::function_e1c354895b9a03a6( 45 );
    flag_set( "veh01_player_takedown_start" );
    flag_set( "takedown_unavailable" );
    shotname = "drown";
    animents = [ level.var_5f8d34a255220522 ];
    flag_set( "flg_takedown_windshield_end" );
    
    if ( level.player.var_c010264d86a473fc.msg == "trigger" )
    {
        shotname = "takedown";
        animents = array_add( animents, level.player );
        level thread function_2e27831383e65419();
        animnode thread scene::play( animents, shotname );
        animnode scene::function_8207074e79f22926( level.player, "end", "player" );
        player_knife = animnode scene::get_entity( "knife" );
        level.player waittill( "end" );
        level.player val::set( "underwater_takedown", "melee", 1 );
        
        if ( isdefined( player_knife ) )
        {
            player_knife delete();
        }
    }
    else
    {
        level.player val::set( "underwater_takedown", "melee", 1 );
        animnode thread scene::play( animents, shotname );
        animnode scene::function_8207074e79f22926( level.var_5f8d34a255220522, "enemy_open_arms", "driver" );
        level.var_5f8d34a255220522 waittill( "enemy_open_arms" );
    }
    
    while ( level.var_5f8d34a255220522 namespace_1e1d02cadf563998::function_bdc64300ee4c81e2( 3500 ) )
    {
        wait 0.1;
    }
    
    level thread function_e6c8b7c32ff9e04b( 0 );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 1
// Checksum 0x0, Offset: 0x1ff8
// Size: 0x9e
function function_90740a4b975511e1( var_c2a3aada8171e94d )
{
    shot_name = "sink_death_float";
    
    if ( is_equal( var_c2a3aada8171e94d, 1 ) )
    {
        shot_name = "death_float";
    }
    
    var_62ac9c5e86fb237f = getstruct( "scene_jup_tun_0100_scuba_crash_rrp", "targetname" );
    var_62ac9c5e86fb237f scene::add_spawn_function( &function_711cf70929ee1bf5, "veh01_rrp" );
    var_62ac9c5e86fb237f thread scene::play( undefined, shot_name );
    var_70d4e57048f983b = getstruct( "scene_jup_tun_0100_scuba_crash_front_passenger", "targetname" );
    var_70d4e57048f983b scene::add_spawn_function( &function_711cf70929ee1bf5, "veh01_fp" );
    var_70d4e57048f983b thread scene::play( undefined, shot_name );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x209e
// Size: 0xd1
function function_fcf930eedc91f95()
{
    animnode = getstruct( "scene_jup_tun_0117_scuba_generic_search", "targetname" );
    animnode scene::function_bc521bee52fde214( 1.2 );
    shotnames = [ "swim", "loop" ];
    
    if ( scripts\sp\starts::is_after_start( "lake_main" ) )
    {
        shotnames = "loop";
    }
    
    animnode thread scene::play( level.ally02, shotnames );
    animnode scene::function_8207074e79f22926( level.ally02, "end", "ally02" );
    level.var_5cc82553c93e3e94 = animnode scene::get_entity( "flashlight" );
    level.var_965c9291556bec55 = animnode scene::get_entity( "ally02_knife" );
    level.ally02 waittill( "end" );
    flag_set( "flg_ally02_reached_vip_veh" );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2177
// Size: 0xa4
function function_a011efa52572363()
{
    scene::function_8207074e79f22926( level.player, "windshield_kick_1", "driver" );
    scene::function_8207074e79f22926( level.player, "windshield_kick_2", "driver" );
    level.player waittill( "windshield_kick_1" );
    getent( "veh1_window_00", "targetname" ) hide();
    getent( "veh1_window_02", "targetname" ) show();
    level.player waittill( "windshield_kick_2" );
    getent( "veh1_window_02", "targetname" ) hide();
    level.var_aac9c8a9482e81b1 show();
}

/#

    // Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
    // Params 0
    // Checksum 0x0, Offset: 0x2223
    // Size: 0x5, Type: dev
    function function_4a84b05f49021a44()
    {
        
    }

#/

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2230
// Size: 0x17e
function function_befd36dbc348f28()
{
    level endon( "targetExtract" );
    level.suvs[ 1 ] stopanimscripted();
    level.ally01 stopanimscripted();
    level.suvs[ 1 ] hidepart( "TAG_WINDOW_FRONT_RIGHT" );
    level.suvs[ 1 ] hidepart( "TAG_WINDOW_BACK_RIGHT" );
    animnode = getstruct( "scene_jup_tun_0120_ally_takedown", "targetname" );
    animnode scene::add_spawn_function( &function_8fc2c4c2e9b4fb90, "enemy_shooter" );
    level thread function_65af7d9d41651a63();
    
    if ( is_after_start( "lake_main" ) )
    {
        animnode thread scene::play( undefined, "enemy_death_idle" );
        return;
    }
    
    var_dae76a34bbb9cf2c = 1;
    
    if ( !var_dae76a34bbb9cf2c )
    {
        animnode childthread scene::play( level.ally01, "enter_no_shoot" );
    }
    else
    {
        animnode childthread scene::play( level.ally01, "enemy_shoot", undefined, 0.1 );
    }
    
    animnode scene::function_8207074e79f22926( level.ally01, "end", "ally01" );
    allyknife = animnode scene::get_entity( "allyKnife" );
    enemy_shooter = animnode scene::get_entity( "enemy_shooter" );
    level.ally01 waittill( "end" );
    utility::flag_set( "flg_lake_gaz_takedown_complete" );
    
    if ( isdefined( allyknife ) )
    {
        allyknife delete();
    }
    
    enemy_shooter delaycall( 1.5, &visiblenotsolid );
    level thread function_7cad752744c22272();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x23b6
// Size: 0x6c
function function_65af7d9d41651a63()
{
    level endon( "targetExtract" );
    shotname = undefined;
    
    if ( is_after_start( "lake_main" ) )
    {
        shotname = "loop_exit";
    }
    
    animnode = getstruct( "scene_jup_tun_0115_scuba_car2_escape", "targetname" );
    animnode scene::add_spawn_function( &function_3083187af57a47d4, "enemy01" );
    animnode scene::play( level.suvs[ 1 ], shotname );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x242a
// Size: 0x2d
function function_8fc2c4c2e9b4fb90()
{
    waitframe();
    ak = make_weapon( "iw9_ar_akilo_sp" );
    scripts\anim\shared::forceuseweapon( ak, "primary" );
    function_3083187af57a47d4();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x245f
// Size: 0x6b
function function_7cad752744c22272()
{
    animnode = getstruct( "scene_jup_tun_0125_scuba_veh02_swim_to_veh04", "targetname" );
    animnode scene::function_8207074e79f22926( level.ally01, "end", "ally01" );
    animnode thread scene::play( level.ally01, "enter" );
    level.ally01 waittill( "end" );
    flag_set( "flg_ally01_reached_vip_veh" );
}

/#

    // Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
    // Params 0
    // Checksum 0x0, Offset: 0x24d2
    // Size: 0x5, Type: dev
    function function_4f627eeccb6062fd()
    {
        
    }

#/

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x24df
// Size: 0x28d
function function_34533c1e8d674a0f()
{
    level endon( "targetExtract" );
    animnode = getstruct( "scene_jup_tun_0130_scuba_plyr_takedown", "targetname" );
    s_interact = getstruct( "s_veh03_enemy_interact", "targetname" );
    animnode endon( "mask_tkd_timeout" );
    animnode scene::function_8207074e79f22926( level.player, "player_mask_off", "player" );
    animnode scene::function_8207074e79f22926( level.player, "player_mask_on", "player" );
    animnode scene::function_8207074e79f22926( level.player, "ally01_thumbs_up", "player" );
    animnode scene::function_263e37fc44b91d4f( 1 );
    
    if ( isdefined( level.var_cfe3ebf991d178d6 ) )
    {
        enemy = level.var_cfe3ebf991d178d6;
        enemy function_711cf70929ee1bf5();
    }
    else
    {
        animnode childthread scene::init( undefined, "enemy_idle" );
        enemy = animnode function_606bd046da88fabc();
    }
    
    level.suvs[ 2 ] hidepart( "tag_window_back_right" );
    animnode thread function_172a5b32fe9f53dc( enemy );
    level.player.var_2994e35ad4e49cab = s_interact;
    level.player.var_2994e35ad4e49cab.msg = undefined;
    level.player.var_2994e35ad4e49cab function_60ba5cf353ce52b6( 32 );
    
    if ( !is_equal( level.player.var_2994e35ad4e49cab.msg, "trigger" ) )
    {
        return;
    }
    
    flag_set( "takedown_unavailable" );
    animnode notify( "trigger" );
    animnode scene::function_263e37fc44b91d4f( 0 );
    level thread function_68563c5b6707be36();
    animnode thread scene::play( [ level.player, enemy ], "takedown" );
    var_c84f770b76dc58cf = animnode scene::get_entity( "Prop 3" );
    var_c84f770b76dc58cf hide();
    animnode scene::function_8207074e79f22926( level.player, "end", "player" );
    level.player waittill( "player_mask_off" );
    level.scuba_mask hide();
    var_c84f770b76dc58cf show();
    level.player waittill( "player_mask_on" );
    wait 2.39;
    var_c84f770b76dc58cf hide();
    level.scuba_mask show();
    level.player waittill( "end" );
    level.player val::set( "underwater_takedown", "melee", 1 );
    level.player unlink();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2774
// Size: 0x44
function function_606bd046da88fabc()
{
    enemy = scene::get_entity( "enemy01" );
    enemy gun_remove();
    enemy.script_nodrop = 1;
    enemy.dropweapon = 0;
    enemy function_711cf70929ee1bf5();
    return enemy;
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 1
// Checksum 0x0, Offset: 0x27c1
// Size: 0x8d
function function_172a5b32fe9f53dc( enemy )
{
    self endon( "trigger" );
    level endon( "targetExtract" );
    thread scene::play( enemy, "enemy_idle" );
    wait 31;
    self notify( "mask_tkd_timeout" );
    flag_set( "takedown_unavailable" );
    flag_set( "takedown_maskrip_complete" );
    level.player.var_2994e35ad4e49cab notify( "lake_takedown_cleanup" );
    level.player val::set( "underwater_takedown", "melee", 1 );
    scene::play( enemy, "enemy_death" );
}

/#

    // Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
    // Params 0
    // Checksum 0x0, Offset: 0x2856
    // Size: 0x5, Type: dev
    function function_6d54086dd18f2936()
    {
        
    }

#/

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2863
// Size: 0x395
function function_5a35d55449e984db()
{
    level endon( "tundra_countdown_fail" );
    var_190ed28b38f6e078 = 38;
    var_94aeb00dd29776d8 = 50;
    var_2bc92d4887564fc6 = 28;
    var_155f4569780b0f7e = getstruct( "scene_jup_tun_0140_scuba_vip_rescue", "targetname" );
    var_155f4569780b0f7e scene::function_8207074e79f22926( level.player, "break_vip_loop", "Player 1" );
    var_155f4569780b0f7e scene::function_8207074e79f22926( level.player, "veh04_window_crack", "Player 1" );
    var_155f4569780b0f7e scene::function_8207074e79f22926( level.player, "veh04_window_break", "Player 1" );
    var_155f4569780b0f7e scene::function_8207074e79f22926( level.player, "veh04_items_hidden", "Player 1" );
    var_155f4569780b0f7e scene::function_8207074e79f22926( level.player, "enemy_end_start", "Player 1" );
    var_155f4569780b0f7e scene::function_8207074e79f22926( level.player, "transition_from_lake", "Player 1" );
    var_f2b84fdfd18d5cf = getstruct( "start_scene_interact_break_window", "targetname" );
    var_155f4569780b0f7e thread function_2e6e061e7043c5fa();
    var_f2b84fdfd18d5cf scripts\sp\player\cursor_hint::create_cursor_hint( undefined, ( 0, 0, 0 ), &"SP_JUP_TUNDRA/LAKE_EXTRACT_HINT", 40, 415, var_190ed28b38f6e078, 1, undefined, undefined, undefined, undefined, undefined, undefined, var_2bc92d4887564fc6, var_94aeb00dd29776d8 );
    var_f2b84fdfd18d5cf thread function_9b131ea987d61a71();
    var_f2b84fdfd18d5cf waittill_any( "trigger", "window_smash" );
    level thread namespace_8339f6377b6ba60e::function_53670f3fa1413a29( "lake_player_progress" );
    flag_set( "targetExtract" );
    flag_set( "tundra_countdown_end" );
    utility::flag_set( "flag_player_at_final_vehicle" );
    setsaveddvar( @"hash_fa84e9dc55b9d406", 0 );
    
    if ( isdefined( level.var_5cc82553c93e3e94 ) )
    {
        level.var_5cc82553c93e3e94 delete();
    }
    
    if ( isdefined( level.var_965c9291556bec55 ) )
    {
        level.var_965c9291556bec55 delete();
    }
    
    thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_lighting::function_f2d397de671c4106();
    thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio::function_26c637b4a0e68843();
    level.ally01 stopanimscripted();
    level.ally02 stopanimscripted();
    level.suvs[ 3 ] stopanimscripted();
    var_155f4569780b0f7e thread scene::play( [ level.ally01, level.ally02, level.suvs[ 3 ] ], "jup_tun_0140_scuba_vip_rescue" );
    thread function_65149e010952c273();
    level.player waittill( "veh04_window_crack" );
    level.suvs[ 3 ] hidepart( "tag_window_back_right" );
    getent( "veh4_window_01", "targetname" ) show();
    level.player waittill( "veh04_window_break" );
    getent( "veh4_window_01", "targetname" ) hide();
    level.player waittill( "break_vip_loop" );
    var_155f4569780b0f7e thread scene::play( undefined, "vip_end" );
    level.player waittill( "enemy_end_start" );
    var_155f4569780b0f7e thread function_44f368729123cf19();
    level.player waittill( "transition_from_lake" );
    scripts\engine\sp\utility::autosave_by_name( "tundra_lake_rescue_save" );
    scripts\engine\sp\utility::transient_load_array( [ "sp_jup_tundra_lake_campfire_tr", "sp_jup_tundra_forest_walk_tr" ] );
    transition_overlay();
    level.scuba_mask unlinkfromplayerview( level.player );
    level.scuba_mask delete();
    flag_set( "lake_rescue_complete" );
    var_155f4569780b0f7e scene::stop();
    var_a09680276e0156aa = var_155f4569780b0f7e scene::get_entities();
    level.var_f903ac629abc4bc3 = array_combine( level.var_f903ac629abc4bc3, var_a09680276e0156aa );
    function_f903ac629abc4bc3();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2c00
// Size: 0x18
function function_9b131ea987d61a71()
{
    level endon( "tundra_countdown_end" );
    level waittill( "tundra_countdown_fail" );
    scripts\sp\player\cursor_hint::remove_cursor_hint();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2c20
// Size: 0xd
function function_65149e010952c273()
{
    stopmusicstate( "mx_tundra_lakedetonate" );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2c35
// Size: 0x35
function function_13318308eb3fff19()
{
    if ( !is_after_start( "lake_detonate" ) )
    {
        level.suvs[ 3 ] waittill( "veh04_reached_final_position" );
    }
    
    function_319c2f097ede51e0( "scene_jup_tun_0140_scuba_vip_rescue", undefined, "vip_start_loop" );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2c72
// Size: 0x31
function function_2e6e061e7043c5fa()
{
    scene::add_spawn_function( &function_1e63a6aea013a8cd, "enemy01" );
    scene::add_spawn_function( &function_1e63a6aea013a8cd, "enemy02" );
    scene::play( undefined, "enemy_start_loop" );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2cab
// Size: 0x25
function function_1e63a6aea013a8cd()
{
    waitframe();
    self visiblenotsolid();
    function_711cf70929ee1bf5();
    self hide();
    wait 7.5;
    self show();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2cd8
// Size: 0x33
function function_44f368729123cf19()
{
    scene::play( undefined, "enemy_end" );
    
    while ( !flag( "lake_rescue_complete" ) )
    {
        scene::play( undefined, "enemy_end", undefined, 0.9 );
    }
}

/#

    // Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
    // Params 0
    // Checksum 0x0, Offset: 0x2d13
    // Size: 0x5, Type: dev
    function function_13ec8f8aac892fe0()
    {
        
    }

#/

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 4
// Checksum 0x0, Offset: 0x2d20
// Size: 0x52
function function_319c2f097ede51e0( targetname, entities, shot, playrate )
{
    animnode = getstruct( targetname, "targetname" );
    
    if ( isdefined( playrate ) )
    {
        animnode scene::function_bc521bee52fde214( playrate );
    }
    
    animnode scene::play( entities, shot );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 2
// Checksum 0x0, Offset: 0x2d7a
// Size: 0x6a
function function_d632c8ec5db9c014( fadeintime, var_8fdcc47e02a1d9d3 )
{
    fadeintime = default_to( fadeintime, 2 );
    var_8fdcc47e02a1d9d3 = default_to( var_8fdcc47e02a1d9d3, 3 );
    blackoverlay = scripts\sp\hud_util::create_client_overlay( "black", 1 );
    wait var_8fdcc47e02a1d9d3;
    blackoverlay fadeovertime( fadeintime );
    blackoverlay.alpha = 0;
    blackoverlay delaycall( fadeintime, &destroy );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2dec
// Size: 0xcc
function function_f903ac629abc4bc3()
{
    a_cleanup = level.var_f903ac629abc4bc3;
    
    foreach ( ent in a_cleanup )
    {
        if ( is_equal( ent, level.player ) || is_equal( ent, level.ally01 ) || is_equal( ent, level.ally02 ) || is_equal( ent, level.suvs[ 3 ] ) )
        {
            a_cleanup = array_remove( a_cleanup, ent );
            continue;
        }
        
        if ( isdefined( ent ) )
        {
            ent delete();
        }
    }
    
    level.var_f903ac629abc4bc3 = undefined;
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 3
// Checksum 0x0, Offset: 0x2ec0
// Size: 0x5d
function function_147d0733986c4ccd( ent, tag_name, shot_name )
{
    new_origin = ent gettagorigin( tag_name );
    new_angles = ent gettagangles( tag_name );
    self.origin = new_origin;
    self.angles = new_angles;
    thread scene::play( undefined, shot_name );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2f25
// Size: 0x21
function function_711cf70929ee1bf5()
{
    waitframe();
    
    if ( isdefined( self ) )
    {
        level.var_f903ac629abc4bc3 = array_add( level.var_f903ac629abc4bc3, self );
    }
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2f4e
// Size: 0x11
function function_b19b8734383e8d3a()
{
    waitframe();
    self visiblenotsolid();
    function_711cf70929ee1bf5();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2f67
// Size: 0x11
function function_3083187af57a47d4()
{
    waitframe();
    self visiblesolid();
    function_711cf70929ee1bf5();
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x2f80
// Size: 0x99
function function_25e8fba7f624dc1()
{
    a_clips = getentarray( "uw_ally_clip_player", "targetname" );
    var_df78b42d9680fb9b = getentarray( "uw_ally_hand_clip_player", "targetname" );
    a_clips[ 0 ] linkto( level.ally01, "j_mainroot", ( -1, -6.5, 0 ), ( 90, 0, 0 ) );
    a_clips[ 1 ] linkto( level.ally02, "j_mainroot", ( -1, -6.5, 0 ), ( 90, 0, 0 ) );
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 0
// Checksum 0x0, Offset: 0x3021
// Size: 0x69
function function_5aec039aeda2631c()
{
    var_f52b4b816da536aa = getentarray( "uw_veh01_driver_clip_death", "targetname" );
    
    foreach ( clip in var_f52b4b816da536aa )
    {
        if ( isdefined( clip ) )
        {
            clip notsolid();
        }
    }
}

// Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
// Params 1
// Checksum 0x0, Offset: 0x3092
// Size: 0x84
function function_e6c8b7c32ff9e04b( b_loop )
{
    b_loop = default_to( b_loop, 1 );
    var_627c93f288e1729a = getent( "uw_veh01_driver_clip_loop", "targetname" );
    var_3be2a80a566f9bb6 = getent( "uw_veh01_driver_clip_float", "targetname" );
    
    if ( b_loop == 1 )
    {
        if ( isdefined( var_627c93f288e1729a ) )
        {
            var_627c93f288e1729a solid();
        }
        
        if ( isdefined( var_3be2a80a566f9bb6 ) )
        {
            var_3be2a80a566f9bb6 notsolid();
        }
        
        return;
    }
    
    if ( isdefined( var_627c93f288e1729a ) )
    {
        var_627c93f288e1729a notsolid();
    }
    
    if ( isdefined( var_3be2a80a566f9bb6 ) )
    {
        var_3be2a80a566f9bb6 solid();
    }
}

/#

    // Namespace namespace_a35eea5f35ca76c1 / namespace_394bf2aebe5c3101
    // Params 2
    // Checksum 0x0, Offset: 0x311e
    // Size: 0xf2, Type: dev
    function function_d3ee4f81e23ab8b4( waittime, color )
    {
        self endon( "<dev string:x1c>" );
        waittime = default_to( waittime, 1 );
        
        if ( isdefined( color ) )
        {
            if ( color == "<dev string:x22>" )
            {
                color = ( 255, 0, 0 );
            }
            else if ( color == "<dev string:x26>" )
            {
                color = ( 0, 255, 0 );
            }
            else if ( color == "<dev string:x2c>" )
            {
                color = ( 0, 0, 255 );
            }
        }
        else
        {
            color = ( 241, 255, 0 );
        }
        
        while ( true )
        {
            if ( !isdefined( self ) )
            {
                break;
            }
            
            wait waittime;
            fwd_angles = anglestoforward( self.angles );
            draw_circle( self.origin, 20, color, undefined, undefined, 100 );
            draw_arrow_time( self.origin, self.origin + fwd_angles * 100, color, waittime );
        }
    }

#/
