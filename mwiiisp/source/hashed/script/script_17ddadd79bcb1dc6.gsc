#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace namespace_71c0aa26543a9151;

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x91d
// Size: 0x41
function main()
{
    scripts\common\lighting::light_init();
    thread function_f29d0cd9dae6bab4();
    thread function_f8fd68a59055821e();
    thread function_12a1c44985e8ba93();
    thread function_12a1c54985e8bcc6();
    thread function_12a1c64985e8bef9();
    thread function_95238bbeaa618750();
    thread function_a6fea76a4085e5c1();
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x966
// Size: 0x41
function function_a6fea76a4085e5c1()
{
    wait 1;
    setdvar( @"hash_7c6e3f49a053cc4c", 0.2 );
    setdvar( @"hash_b345e52965c135b5", 0.2 );
    setdvar( @"hash_bc13d3a46e2c2877", 0.4 );
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 2
// Checksum 0x0, Offset: 0x9af
// Size: 0x72
function letterbox_enable( bool, time )
{
    time = default_to( time, 2 );
    
    if ( bool )
    {
        level.player ent_flag_set( "letterbox_enabled" );
        level.player lerpfovscalefactor( 0, time );
        return;
    }
    
    level.player ent_flag_clear( "letterbox_enabled" );
    level.player lerpfovscalefactor( 1, time );
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0xa29
// Size: 0x80
function function_1be9145b47c4b31d()
{
    thread function_61a998996cc98831();
    setdvar( @"hash_6e3f8cef6be16b33", 1 );
    setdvar( @"hash_1ea8544d78048529", 1 );
    setdvar( @"hash_5d66c2ef5a9612e0", 0 );
    setdvar( @"hash_dacffbfd52c2fdc5", 8 );
    setdvar( @"hash_eca4b727b01fd254", 12 );
    setdvar( @"hash_e08232af8b8b695c", 6 );
    setdvar( @"hash_63eb1893f96ac98d", 8 );
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0xab1
// Size: 0x5f
function function_26280fbed5700639()
{
    thread function_9160006a3f10b2cd();
    setdvar( @"hash_5d66c2ef5a9612e0", 1 );
    setdvar( @"hash_dacffbfd52c2fdc5", 8 );
    setdvar( @"hash_cb82c01fec2d534b", 8 );
    setdvar( @"hash_e08232af8b8b695c", 2 );
    setdvar( @"hash_63eb1893f96ac98d", 6 );
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0xb18
// Size: 0x5e
function function_f29d0cd9dae6bab4()
{
    function_dbec921ed499ee34( "firelight_motion_medium", ( 0.7, 0.2246, 0 ), ( 0.7, 0.25, 0 ), 30, 0.05, 0.2, 20 );
    function_bf134e4c6c36436( "flickerdim", 0.25, 10, 0.05, 0.15, 3, 7, 0.1, 3 );
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 1
// Checksum 0x0, Offset: 0xb7e
// Size: 0x242
function function_97fa450d44ef3a35( anim_org )
{
    level endon( "scene_skipped" );
    flag_wait( "intro_cin_start" );
    childthread function_1be9145b47c4b31d();
    level.var_f86dca03b4e10a79 = 1;
    wait 0.05;
    Farah_body = anim_org scene::get_entity( "Farah_body" );
    Farah_head = anim_org scene::get_entity( "Farah_head" );
    childthread function_a91a68d942ea5bcf( Farah_head );
    showcinematicletterboxing( 0, 0 );
    visionsetnaked( "cp_jup_port_intro", 0 );
    childthread function_b01bc37bb97ec069( "lgt_blink_intro", 1000, 50, 50, "fx_intro_blink", undefined, 0.5, 3, 0.2, 0.5, "lgt_blink_intro_off", undefined, 0 );
    childthread lerp_spot_intensity( "intro_shot1_fill", 0, 4 );
    wait 2;
    flag_wait( "lgt_cine_intro_farah_up" );
    exploder( "intro_exp" );
    flag_wait( "look_at_gun" );
    childthread lerp_spot_intensity( "intro_shot1_fill", 3, 1 );
    flag_wait( "gun_grab" );
    childthread lerp_spot_intensity( "intro_shot1_moon", 1, 40 );
    exploder( "intro_single_shot" );
    exploder( "intro_strafe" );
    flag_wait( "camera_look" );
    wait 1;
    visionsetnaked( "cp_jup_port_intro_turn", 1 );
    wait 1;
    level notify( "lgt_blink_intro_off" );
    wait 0.05;
    childthread lerp_spot_intensity( "intro_fire_light_flicker_bounce_off", 0, 0 );
    flag_wait( "intro_cin_bars_end" );
    hidecinematicletterboxing( 2, 0 );
    flag_wait( "intro_cin_end" );
    childthread lerp_spot_intensity( "intro_shot1_moon", 3, 0 );
    childthread lerp_spot_intensity( "intro_shot1_fill", 3, 0 );
    childthread lerp_spot_intensity( "lgt_blink_intro", 3, 0 );
    stop_exploder( "fx_intro_blink" );
    visionsetnaked( "", 30 );
    childthread function_1d321dd7f8b825ce( "flicker4", "intro_fire_light_flicker_omni", 0 );
    childthread function_1d321dd7f8b825ce( "flicker4", "intro_fire_light_flicker_bounce", 0 );
    childthread function_26280fbed5700639();
    childthread lerp_spot_intensity( "ladder_light_1", 30, 8 );
    childthread lerp_spot_intensity( "ladder_light_2", 30, 0.16 );
    wait 2;
    level.var_f86dca03b4e10a79 = undefined;
    wait 1;
    thread function_3719cd7c0273cbe8();
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0xdc8
// Size: 0x169
function function_3719cd7c0273cbe8()
{
    intro_shot1_moon = getent( "intro_shot1_moon", "targetname" );
    intro_shot1_fill = getent( "intro_shot1_fill", "targetname" );
    lgt_blink_intro = getentarray( "lgt_blink_intro", "targetname" );
    intro_fire_light_flicker = getent( "intro_fire_light_flicker", "targetname" );
    var_1e55ac70042499b1 = [ intro_shot1_moon, intro_shot1_fill, intro_fire_light_flicker ];
    
    if ( isdefined( lgt_blink_intro ) )
    {
        foreach ( ent in lgt_blink_intro )
        {
            if ( isdefined( ent ) )
            {
                array = array_add( var_1e55ac70042499b1, ent );
            }
        }
    }
    
    if ( isdefined( var_1e55ac70042499b1 ) )
    {
        foreach ( light in var_1e55ac70042499b1 )
        {
            if ( isdefined( ent ) )
            {
                light delete();
            }
        }
    }
    
    wait 0.1;
    level notify( "lgt_blink_intro_off" );
    kill_exploder( "fx_intro_blink" );
    childthread lerp_spot_intensity( "lgt_blink_intro", 0, 0 );
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 1
// Checksum 0x0, Offset: 0xf39
// Size: 0x129
function function_a91a68d942ea5bcf( Farah_head )
{
    level.player thread utility::dof_disable_autofocus();
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 4, 15, 5, 5 );
    flag_wait( "lgt_cine_intro_dof_change" );
    level.player setphysicaldepthoffield( 4, 20, 1, 1 );
    flag_wait( "lgt_cine_intro_farah_up" );
    level.player setphysicaldepthoffield( 4, 12, 15, 50 );
    flag_wait( "look_at_gun" );
    level.player setphysicaldepthoffield( 5, 50, 15, 50 );
    flag_wait( "gun_grab" );
    level.player setphysicaldepthoffield( 5, 30, 15, 50 );
    flag_wait( "camera_look" );
    level.player setphysicaldepthoffield( 5, 28, 15, 15 );
    wait 1.8;
    level.player setphysicaldepthoffield( 5, 200, 5, 5 );
    flag_wait( "intro_cin_end" );
    level.player disablephysicaldepthoffieldscripting();
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 1
// Checksum 0x0, Offset: 0x106a
// Size: 0x173
function function_8ce600bd17823a90( anim_org )
{
    thread function_1be9145b47c4b31d();
    thread function_d583c7bd4cc404e3();
    level.player utility::hidehudenable();
    level.var_f86dca03b4e10a79 = 1;
    showcinematicletterboxing( 1.5, 0 );
    visionsetnaked( "cp_jup_port_exfil", 1.5 );
    setdvar( @"hash_8adcf05d62fe94fd", 0.7 );
    setdvar( @"hash_b345e52965c135b5", 0.2 );
    setdvar( @"hash_7c6e3f49a053cc4c", 0.2 );
    setdvar( @"hash_ea4c44a08cd23d5d", 2 );
    thread lerp_spot_intensity( "lgt_exfil_tracker_key", 1, 23.9 );
    thread lerp_spot_intensity( "lgt_exfil_tracker_rim", 1, 160 );
    thread lerp_spot_intensity( "lgt_exfil_tracker_fill", 1, 1.6 );
    thread lerp_spot_intensity( "lgt_exfil_tracker_key_2", 1, 23.9 );
    thread lerp_spot_intensity( "lgt_exfil_tracker_rim_2", 1, 160 );
    thread lerp_spot_intensity( "lgt_exfil_tracker_fill_2", 1, 1.6 );
    level waittill( "tracker_cin_end" );
    thread lerp_spot_intensity( "lgt_exfil_tracker_key", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_tracker_rim", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_tracker_fill", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_tracker_key_2", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_tracker_rim_2", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_tracker_fill_2", 0, 0 );
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x11e5
// Size: 0xa6
function function_d583c7bd4cc404e3()
{
    tracker = getent( "obj_container_tracker_final", "targetname" );
    var_568e39a6e9adeca0 = spawn_tag_origin();
    var_568e39a6e9adeca0 show();
    var_568e39a6e9adeca0 linkto( tracker );
    level.player thread utility::dof_enable_autofocus( 5, var_568e39a6e9adeca0, 20, 20, undefined, "tag_origin" );
    wait 2.7;
    level.player thread utility::dof_enable_autofocus( 1, var_568e39a6e9adeca0, 10, 10, undefined, "tag_origin" );
    level waittill( "konni_exfil_start" );
    level.player disablephysicaldepthoffieldscripting();
    level.player thread utility::dof_disable_autofocus();
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 1
// Checksum 0x0, Offset: 0x1293
// Size: 0xcc
function function_85e10721066aa7e3( anim_org )
{
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 4, 150, 1, 1 );
    wait 4.5;
    level.player setphysicaldepthoffield( 1, 150, 1, 1 );
    wait 2;
    level.player setphysicaldepthoffield( 1, 250, 1, 1 );
    wait 3;
    level.player setphysicaldepthoffield( 4, 200, 1, 1 );
    wait 3;
    level.player setphysicaldepthoffield( 4, 200, 1, 1 );
    wait 3;
    level.player setphysicaldepthoffield( 1, 900, 1, 1 );
    wait 5.5;
    level.player disablephysicaldepthoffieldscripting();
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 1
// Checksum 0x0, Offset: 0x1367
// Size: 0x613
function function_4047ec2c508ff8eb( anim_org )
{
    waitframe();
    Farah_body = anim_org scene::get_entity( "farah_body" );
    alex_body = anim_org scene::get_entity( "alex_body" );
    thread function_e340fb595dcd40d9( Farah_body, alex_body );
    flag_wait( "lgt_exfil_cin_start" );
    thread function_1be9145b47c4b31d();
    level.player utility::hidehudenable();
    setdvar( @"hash_e08232af8b8b695c", 16 );
    setdvar( @"hash_63eb1893f96ac98d", 18 );
    level.var_f86dca03b4e10a79 = 1;
    visionsetnaked( "cp_jup_port_exfil", 0.1 );
    setdvar( @"hash_8adcf05d62fe94fd", 0.7 );
    setdvar( @"hash_b345e52965c135b5", 0.2 );
    setdvar( @"hash_7c6e3f49a053cc4c", 0.2 );
    setdvar( @"hash_ea4c44a08cd23d5d", 2 );
    setsaveddvar( @"sm_spotdistcull", 8000 );
    thread lerp_spot_intensity( "street_lamp", 0, 0 );
    thread lerp_spot_intensity( "ladder_light_1", 0, 0 );
    thread lerp_spot_intensity( "ladder_light_2", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_streetlamp_main", 0, 400 );
    thread lerp_spot_intensity( "lgt_exfil_crane_key", 0, 630 );
    thread lerp_spot_intensity( "lgt_exfil_s1_farah_fill", 0, 0.8 );
    thread lerp_spot_intensity( "lgt_exfil_s1_farah_rim_2", 0, 160 );
    flag_wait( "lgt_exfil_farah_mcu" );
    thread lerp_spot_intensity( "lgt_exfil_s1_farah_rim_1", 0.5, 0.64 );
    thread lerp_spot_intensity( "lgt_exfil_s1_farah_fill", 0.5, 2 );
    thread lerp_spot_intensity( "crane_bg_lights", 0, 400 );
    flag_wait( "lgt_exfil_farah_mcu_2" );
    thread lerp_spot_intensity( "lgt_exfil_street_lamp_main", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s1_farah_rim_1", 2, 3.98 );
    thread lerp_spot_intensity( "lgt_exfil_s1_farah_fill", 2, 3.98 );
    flag_wait( "lgt_exfil_disable_street_lights" );
    flag_wait( "lgt_exfil_ally" );
    thread lerp_spot_intensity( "lgt_exfil_s1_farah_fill", 5, 7.96 );
    thread lerp_spot_intensity( "lgt_exfil_s1_ally_rim", 8, 40 );
    thread lerp_spot_intensity( "lgt_exfil_s1_ally_key", 1, 40 );
    flag_wait( "lgt_exfil_duo_mw" );
    thread lerp_spot_intensity( "lgt_exfil_s1_farah_rim_1", 1, 7.96 );
    thread lerp_spot_intensity( "lgt_exfil_crane_key", 3, 160 );
    flag_wait( "lgt_exfil_farah_focus_m" );
    thread lerp_spot_intensity( "lgt_exfil_s1_farah_fill", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s1_ally_key", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s1_farah_rim_1", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s1_farah_rim_2", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s2_farah_rim", 0, 240 );
    thread lerp_spot_intensity( "lgt_exfil_s2_farah_fill", 0, 0.4 );
    thread lerp_spot_intensity( "lgt_exfil_s2_farah_kick", 0, 6 );
    thread lerp_spot_intensity( "lgt_exfil_streetlamp_main", 0, 400 );
    thread lerp_spot_intensity( "lgt_exfil_s1_ally_rim", 0, 15 );
    thread lerp_spot_intensity( "lgt_exfil_crane_key", 0, 630 );
    flag_wait( "lgt_exfil_farah_walk_mw" );
    thread lerp_spot_intensity( "lgt_exfil_s2_farah_rim", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s2_farah_fill", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s2_farah_kick", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_streetlamp_main", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s1_ally_rim", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s3_key", 0, 800 );
    thread lerp_spot_intensity( "lgt_exfil_s3_duo_rim", 0, 80 );
    thread lerp_spot_intensity( "lgt_exfil_s3_duo_fill", 0, 40 );
    flag_wait( "lgt_exfil_farah_turn_mcu" );
    thread lerp_spot_intensity( "lgt_exfil_s3_duo_fill", 2, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s3_duo_rim", 1, 20 );
    thread lerp_spot_intensity( "lgt_exfil_s3_ally_fill", 1, 15 );
    thread lerp_spot_intensity( "lgt_exfil_s3_ally_rim", 1, 4 );
    flag_wait( "lgt_exfil_farah_focus_2_m" );
    thread lerp_spot_intensity( "lgt_exfil_s3_ally_fill", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s3_duo_rim", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s3_ally_rim", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s4_farah_key", 0, 80 );
    thread lerp_spot_intensity( "lgt_exfil_s4_farah_rim", 0, 3.98 );
    thread lerp_spot_intensity( "lgt_exfil_s4_farah_fill", 0, 3.98 );
    thread lerp_spot_intensity( "lgt_exfil_s3_key", 0, 47 );
    flag_wait( "lgt_exfil_farah_walk_m" );
    thread lerp_spot_intensity( "lgt_exfil_s4_farah_key", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s4_farah_rim", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s4_farah_fill", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s3_key", 0, 800 );
    thread lerp_spot_intensity( "lgt_exfil_s3_ally_rim", 0, 4 );
    thread lerp_spot_intensity( "lgt_exfil_s3_ally_fill", 0, 15 );
    thread lerp_spot_intensity( "lgt_exfil_s5_crane_spec", 0, 8 );
    flag_wait( "lgt_exfil_ally_w" );
    thread lerp_spot_intensity( "lgt_exfil_s3_ally_fill", 4, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s3_ally_rim", 4, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s3_duo_rim", 3, 30 );
    flag_wait( "lgt_exfil_cine_end" );
    thread lerp_spot_intensity( "lgt_exfil_s3_key", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s5_crane_spec", 0, 0 );
    thread lerp_spot_intensity( "lgt_exfil_s3_duo_rim", 0, 0 );
    thread function_26280fbed5700639();
    hidecinematicletterboxing( 0, 0 );
    setdvar( @"hash_b345e52965c135b5", 1 );
    setdvar( @"hash_7c6e3f49a053cc4c", 1 );
    setsaveddvar( @"sm_spotdistcull", 1500 );
    thread lerp_spot_intensity( "street_lamp", 0, 119 );
    thread lerp_spot_intensity( "ladder_light_1", 30, 8 );
    thread lerp_spot_intensity( "ladder_light_2", 30, 0.16 );
    thread lerp_spot_intensity( "crane_bg_lights", 0, 636 );
    level.var_f86dca03b4e10a79 = undefined;
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 2
// Checksum 0x0, Offset: 0x1982
// Size: 0x235
function function_e340fb595dcd40d9( Farah_body, alex_body )
{
    wait 0.05;
    flag_wait( "lgt_exfil_farah_mcu" );
    level.player thread utility::dof_enable_autofocus( 2, Farah_body, 1, 1, undefined, "tag_eye" );
    flag_wait( "lgt_exfil_farah_mcu_2" );
    level.player thread utility::dof_enable_autofocus( 1.5, Farah_body, 1, 1, undefined, "tag_eye" );
    flag_wait( "lgt_exfil_ally" );
    level.player thread utility::dof_enable_autofocus( 2.5, Farah_body, 1, 1, undefined, "tag_eye" );
    wait 1.5;
    level.player thread utility::dof_enable_autofocus( 1, alex_body, 2, 2, undefined, "tag_eye" );
    flag_wait( "lgt_exfil_duo_mw" );
    level.player thread utility::dof_enable_autofocus( 1.5, Farah_body, 1, 1, undefined, "tag_eye" );
    flag_wait( "lgt_exfil_farah_focus_m" );
    level.player thread utility::dof_enable_autofocus( 1, Farah_body, 1, 5, undefined, "tag_eye" );
    flag_wait( "lgt_exfil_farah_walk_mw" );
    level.player thread utility::dof_enable_autofocus( 2, alex_body, 49, 49, undefined, "tag_eye" );
    flag_wait( "lgt_exfil_farah_turn_mcu" );
    level.player thread utility::dof_enable_autofocus( 1, alex_body, 1, 5, undefined, "tag_eye" );
    flag_wait( "lgt_exfil_farah_focus_2_m" );
    level.player thread utility::dof_enable_autofocus( 0.5, Farah_body, 49, 49, undefined, "tag_eye" );
    flag_wait( "lgt_exfil_farah_walk_m" );
    level.player thread utility::dof_enable_autofocus( 1.5, alex_body, 49, 49, undefined, "tag_eye" );
    flag_wait( "lgt_exfil_ally_w" );
    level.player thread utility::dof_enable_autofocus( 2, alex_body, 49, 49, undefined, "tag_eye" );
    wait 3;
    level.player thread utility::dof_enable_autofocus( 5, alex_body, 1, 1, undefined, "tag_eye" );
    flag_wait( "lgt_exfil_cine_end" );
    level.player thread utility::dof_enable_autofocus( 8, undefined, 5, 2 );
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x1bbf
// Size: 0x49e
function function_f8fd68a59055821e()
{
    crane_omnis = getentarray( "crane_omnis", "targetname" );
    crane_spots = getentarray( "crane_spots", "targetname" );
    crane = getent( "crane_base_1", "targetname" );
    var_855c4238a654af21 = getentarray( "crane_base_1_lgts", "targetname" );
    
    foreach ( var_f28df97ed5ffb246 in crane_omnis )
    {
        var_f28df97ed5ffb246 linkto( crane );
    }
    
    foreach ( var_adfeb51c13a96a07 in crane_spots )
    {
        var_adfeb51c13a96a07 linkto( crane );
    }
    
    foreach ( var_5ef006c6cebb7d28 in var_855c4238a654af21 )
    {
        var_5ef006c6cebb7d28 linkto( crane );
    }
    
    crane2_spots = getentarray( "crane2_spots", "targetname" );
    var_53d1de2199c7c358 = getent( "crane_base_2", "targetname" );
    var_af19125dbd1497f3 = getentarray( "crane_base_2_lgts", "targetname" );
    
    foreach ( var_ce795cf90751bd9d in crane2_spots )
    {
        var_ce795cf90751bd9d linkto( var_53d1de2199c7c358 );
    }
    
    foreach ( var_bae37a3bbbacd332 in var_af19125dbd1497f3 )
    {
        var_bae37a3bbbacd332 linkto( var_53d1de2199c7c358 );
    }
    
    crane3_omnis = getentarray( "crane3_omnis", "targetname" );
    crane3_spots = getentarray( "crane3_spots", "targetname" );
    var_53d1df2199c7c58b = getent( "crane_base_3", "targetname" );
    var_d08192301d2b7af2 = getentarray( "crane_base_3_lgts", "targetname" );
    
    foreach ( var_4565484c84015cfd in crane3_omnis )
    {
        var_4565484c84015cfd linkto( var_53d1df2199c7c58b );
    }
    
    foreach ( var_d6b2fbebd5eb21d4 in crane3_spots )
    {
        var_d6b2fbebd5eb21d4 linkto( var_53d1df2199c7c58b );
    }
    
    foreach ( var_23023a567ad29b35 in var_d08192301d2b7af2 )
    {
        var_23023a567ad29b35 linkto( var_53d1df2199c7c58b );
    }
    
    level._effect[ "lensflare_crane_set" ] = loadfx( "vfx/jup/level/cp_jup_port/vfx_jup_port_lensflare_crane_set.vfx" );
    var_49592704f3ed538a = spawn_tag_origin();
    var_49592704f3ed538a show();
    var_49592704f3ed538a linkto( crane, "tag_origin", ( -468, 0, -490 ), ( 0, 0, 0 ) );
    playfxontag( getfx( "lensflare_crane_set" ), var_49592704f3ed538a, "tag_origin" );
    var_3c6487e472ef1da8 = spawn_tag_origin();
    var_3c6487e472ef1da8 show();
    var_3c6487e472ef1da8 linkto( var_53d1de2199c7c358, "tag_origin", ( -468, 0, -490 ), ( 0, 0, 0 ) );
    playfxontag( getfx( "lensflare_crane_set" ), var_3c6487e472ef1da8, "tag_origin" );
    var_3c6488e472ef1fdb = spawn_tag_origin();
    var_3c6488e472ef1fdb show();
    var_3c6488e472ef1fdb linkto( var_53d1df2199c7c58b, "tag_origin", ( -468, 0, -490 ), ( 0, 0, 0 ) );
    playfxontag( getfx( "lensflare_crane_set" ), var_3c6488e472ef1fdb, "tag_origin" );
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x2065
// Size: 0x66
function function_12a1c44985e8ba93()
{
    var_eed66cd61a8d4130 = getentarray( "crane_force_light_1", "targetname" );
    
    foreach ( var_351e125a1ef0e2f8 in var_eed66cd61a8d4130 )
    {
        var_351e125a1ef0e2f8 thread function_8ff6a8c36abc7ae();
    }
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x20d3
// Size: 0x70
function function_8ff6a8c36abc7ae()
{
    while ( true )
    {
        self waittill( "trigger" );
        crane_big_light_1 = getent( "crane_big_light_1", "script_noteworthy" );
        crane_big_light_1 function_94e6538604ee3986( "forceshadowon" );
        
        while ( level.player istouching( self ) )
        {
            wait 0.1;
        }
        
        crane_big_light_1 = getent( "crane_big_light_1", "script_noteworthy" );
        crane_big_light_1 function_94e6538604ee3986( "normal" );
    }
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x214b
// Size: 0x66
function function_12a1c54985e8bcc6()
{
    var_eed66cd61a8d4130 = getentarray( "crane_force_light_2", "targetname" );
    
    foreach ( var_351e125a1ef0e2f8 in var_eed66cd61a8d4130 )
    {
        var_351e125a1ef0e2f8 thread function_1c272abf620093e1();
    }
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x21b9
// Size: 0x70
function function_1c272abf620093e1()
{
    while ( true )
    {
        self waittill( "trigger" );
        crane_big_light_2 = getent( "crane_big_light_2", "script_noteworthy" );
        crane_big_light_2 function_94e6538604ee3986( "forceshadowon" );
        
        while ( level.player istouching( self ) )
        {
            wait 0.1;
        }
        
        crane_big_light_2 = getent( "crane_big_light_2", "script_noteworthy" );
        crane_big_light_2 function_94e6538604ee3986( "normal" );
    }
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x2231
// Size: 0x66
function function_12a1c64985e8bef9()
{
    var_eed66cd61a8d4130 = getentarray( "crane_force_light_3", "targetname" );
    
    foreach ( var_351e125a1ef0e2f8 in var_eed66cd61a8d4130 )
    {
        var_351e125a1ef0e2f8 thread function_592bb2dce8115044();
    }
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x229f
// Size: 0x70
function function_592bb2dce8115044()
{
    while ( true )
    {
        self waittill( "trigger" );
        crane_big_light_3 = getent( "crane_big_light_3", "script_noteworthy" );
        crane_big_light_3 function_94e6538604ee3986( "forceshadowon" );
        
        while ( level.player istouching( self ) )
        {
            wait 0.1;
        }
        
        crane_big_light_3 = getent( "crane_big_light_3", "script_noteworthy" );
        crane_big_light_3 function_94e6538604ee3986( "normal" );
    }
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x2317
// Size: 0x65
function function_95238bbeaa618750()
{
    var_762efe52c56d977 = getentarray( "lgt_exfil_streetlamp", "targetname" );
    
    foreach ( light in var_762efe52c56d977 )
    {
        light setlightintensity( 0 );
    }
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x2384
// Size: 0x17
function function_9b174ff6779fcf67()
{
    wait 0.05;
    thread lerp_spot_intensity( "explosion_close_lights", 0, 0 );
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x23a3
// Size: 0x17
function function_9b1750f6779fd19a()
{
    wait 0.05;
    thread lerp_spot_intensity( "fire_explosion_lights_maintenance", 0, 0 );
}

// Namespace namespace_71c0aa26543a9151 / namespace_3d5dc532bca51ac0
// Params 0
// Checksum 0x0, Offset: 0x23c2
// Size: 0x13d
function function_464c7dc390d8030d()
{
    truck1 = getent( "escape_truck_1", "targetname" );
    truck2 = getent( "escape_truck_2", "targetname" );
    truck3 = getent( "escape_truck_3", "targetname" );
    trucks = [ truck1, truck2, truck3 ];
    
    foreach ( truck in trucks )
    {
        truck.var_2156203b75d98c15 = spawn_tag_origin();
        truck.var_2156123b75d96d4b = spawn_tag_origin();
        truck.var_2156203b75d98c15 show();
        truck.var_2156123b75d96d4b show();
        playfxontag( level._effect[ "vfx_lensflare_headlight_warm_nolight" ], truck.var_2156203b75d98c15, "tag_light_lf" );
        playfxontag( level._effect[ "vfx_lensflare_headlight_warm_nolight" ], truck.var_2156123b75d96d4b, "tag_light_rf" );
    }
}

