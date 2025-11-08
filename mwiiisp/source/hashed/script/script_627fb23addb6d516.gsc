#using script_eb67ad8b220e6c7;
#using scripts\common\hud_util;
#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace namespace_5b91911344c0c843;

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 0
// Checksum 0x0, Offset: 0x11ba
// Size: 0x12
function main()
{
    thread namespace_fa30e36ae6a8ad2f::init();
    thread lighting_dvars();
}

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 0
// Checksum 0x0, Offset: 0x11d4
// Size: 0x1b7
function lighting_dvars()
{
    wait 0.05;
    flag_wait( "player_spawned_with_loadout" );
    wait 0.05;
    setdvar( @"hash_1dde331a8e0153d8", 16 );
    setdvar( @"hash_63eb1893f96ac98d", 8 );
    setdvar( @"hash_e08232af8b8b695c", 6 );
    setdvar( @"hash_a083dfcc7a54f85f", 0 );
    setdvar( @"hash_633e1a62bb5ceeb2", 1 );
    setdvar( @"hash_1fc47d6f68e1faf", 1 );
    setdvar( @"hash_5b1b5bd738a5436f", 0 );
    setdvar( @"sm_sunsamplesizenear", 1 );
    setdvar( @"hash_4c14e16355aa5cb0", 2 );
    setdvar( @"hash_4c14e46355aa6349", 3 );
    setdvar( @"hash_924d46a5bf2c1f5d", 1.2 );
    setdvar( @"hash_a32719b6bbd25f1e", 1.5 );
    setdvar( @"sm_spotdistcull", 4500 );
    setdvar( @"hash_5a83a561cb4970b2", 6500 );
    setdvar( @"r_fogheightmapfade", 0.001 );
    setdvar( @"hash_81b9a5d52e0be6ac", 70 );
    setdvar( @"hash_3b399a1604643dec", "1 1 1" );
    setdvar( @"hash_aead3f0db524f5d", 0 );
    setdvar( @"hash_16a28dae4d06cb5f", 300 );
    setdvar( @"hash_a04dd064784d0939", -0.1 );
    setdvar( @"hash_6462fa32d9ea200e", 1000 );
    setdvar( @"hash_68ef7ddd6c9f3375", "64826.1 77401.2" );
    setdvar( @"hash_691267dd6cc54acb", "-64565.9 -51990.8 0" );
}

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 0
// Checksum 0x0, Offset: 0x1393
// Size: 0xf2
function function_f8c846b71840b96d()
{
    thread lerp_spot_intensity( "wall_top_fill", 0, 0 );
    visionsetnaked( "cp_jup_ranch", 0 );
    setsuncolorandintensity( 0 );
    setsundirection( anglestoforward( ( -16, 41.27, 0 ) ) );
    setdvar( @"hash_93ca035fa3964d3d", 1 );
    level.player thread utility::dof_enable_autofocus( 8, undefined, 5, 2 );
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 2, 500, 15, 50 );
    setsaveddvar( @"hash_1048f749a8b7aa91", 1 );
    setsaveddvar( @"hash_5a83a561cb4970b2", 1 );
    setsaveddvar( @"hash_cb471f951a15940f", 0.5 );
    setsaveddvar( @"hash_36561ce503889667", 0.5 );
    setsaveddvar( @"hash_5a016e50936393e9", 0.5 );
    showcinematicletterboxing( 0, 0 );
}

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 1
// Checksum 0x0, Offset: 0x148d
// Size: 0x1d1
function function_fe37660adcbfb21d( anim_org )
{
    flag_wait( "player_spawned_with_loadout" );
    level.var_f86dca03b4e10a79 = 1;
    thread function_61a998996cc98831();
    thread function_a44b977b4b9b4f37( anim_org );
    showcinematicletterboxing( 0, 0 );
    visionsetnaked( "cp_jup_resort_infil", 0 );
    thread lerp_spot_intensity( "cine_intro_s1_key", 0, 2.79 );
    thread lerp_spot_intensity( "cine_intro_s1_rim", 0, 1.19 );
    thread lerp_spot_intensity( "cine_intro_s1_fill", 0, 0.4 );
    flag_wait( "lgt_intro_s2" );
    thread lerp_spot_intensity( "cine_intro_s1_key", 0, 0 );
    thread lerp_spot_intensity( "cine_intro_s1_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_intro_s1_fill", 0, 0 );
    thread lerp_spot_intensity( "cine_intro_s2_key", 0, 10 );
    thread lerp_spot_intensity( "cine_intro_s2_rim", 0, 1.6 );
    flag_wait( "lgt_intro_s3" );
    thread lerp_spot_intensity( "cine_intro_s2_key", 0, 0 );
    thread lerp_spot_intensity( "cine_intro_s2_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_intro_s2_fill", 0, 0 );
    thread lerp_spot_intensity( "cine_intro_s3_key", 0, 0.8 );
    thread lerp_spot_intensity( "cine_intro_s3_rim", 0, 0.08 );
    thread lerp_spot_intensity( "cine_intro_s3_fill", 0, 0.08 );
    level waittill( "lgt_intro_pre_end" );
    visionsetnaked( "", 3 );
    thread lerp_spot_intensity( "cine_intro_s3_key", 0.5, 0 );
    thread lerp_spot_intensity( "cine_intro_s3_rim", 0.5, 0 );
    thread lerp_spot_intensity( "cine_intro_s3_fill", 0.5, 0 );
    wait 1;
    hidecinematicletterboxing( 2, 0 );
    level waittill( "lgt_intro_end" );
    visionsetnaked( "", 0 );
    thread function_9160006a3f10b2cd();
    wait 2;
    level.var_f86dca03b4e10a79 = undefined;
}

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 1
// Checksum 0x0, Offset: 0x1666
// Size: 0x1c2
function function_a44b977b4b9b4f37( anim_org )
{
    flag_wait( "lgt_intro_s2" );
    soap_1_body = anim_org scene::get_entity( "soap_1_body" );
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 0.2, 10000, 15, 49 );
    flag_wait( "lgt_intro_s2_foc_soap" );
    level.player setphysicaldepthoffield( 0.2, 10000, 15, 49 );
    flag_wait( "lgt_intro_s2_foc_resort" );
    level.player setphysicaldepthoffield( 0.2, 10000, 15, 49 );
    flag_wait( "lgt_intro_s3" );
    level.player setphysicaldepthoffield( 22, 50, 15, 49 );
    wait 1.5;
    level.player setphysicaldepthoffield( 1.5, 13, 15, 49 );
    level waittill( "lgt_intro_s4" );
    level.player setphysicaldepthoffield( 1.5, 13, 15, 49 );
    level.player disablephysicaldepthoffieldscripting();
    level.player thread utility::dof_enable_autofocus( 2, undefined, 49, 49 );
    wait 2;
    level.player thread utility::dof_enable_autofocus( 0.13, soap_1_body, 5, 5, undefined, "tag_helmetlight" );
    wait 1;
    level.player thread utility::dof_enable_autofocus( 0.13, soap_1_body, 49, 49, undefined, "tag_helmetlight" );
    level waittill( "lgt_intro_pre_end" );
    level.player thread utility::dof_enable_autofocus( 2, undefined, 1, 1 );
    level waittill( "lgt_intro_end" );
    level.player thread utility::dof_disable_autofocus();
    level.player disablephysicaldepthoffieldscripting();
}

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 1
// Checksum 0x0, Offset: 0x1830
// Size: 0x55a
function function_70a130c71a4c929b( anim_org )
{
    flag_wait( "lgt_exfil_start" );
    level.var_f86dca03b4e10a79 = 1;
    thread function_ee89f51c6b88bf1a();
    setdvar( @"hash_1ea8544d78048529", 0 );
    showcinematicletterboxing( 2, 0 );
    visionsetnaked( "cp_jup_resort_exfil", 2 );
    waitframe();
    player = anim_org scene::get_entity( "Player 1" );
    ghost_character = anim_org scene::get_entity( "ghost_character" );
    soap_character = anim_org scene::get_entity( "soap_character" );
    milena_character = anim_org scene::get_entity( "milena_character" );
    laptop = anim_org scene::get_entity( "laptop" );
    thread function_e128e43a29fb2ca9( player, ghost_character, soap_character, milena_character, laptop );
    thread lerp_spot_intensity( "cine_exfil_door_first", 1, 0.4 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_left", 0, 0.7 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right", 0, 2 );
    thread lerp_spot_intensity( "cine_exfil_outside_left", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_left_glow", 0, 2.1 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_left_glow_cool", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_ghost_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_2", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_010", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_010", 0, 0.7 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_020", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun", 0, 15 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_2", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_cool", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_blinds", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_010", 0, 10 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_right_soap_050", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_250", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_ghost_150", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_190", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_hand_grab_key", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_hand_grab_fill", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top", 0, 8 );
    thread lerp_spot_intensity( "cine_exfil_top_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_100", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_ghost_150", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_ghost_160", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_290", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_350", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source", 0, 0.15 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2", 0, 0.15 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_011", 0, 1 );
    thread lerp_spot_intensity( "cine_exfil_top_source_glow_030", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_tv_rim", 0, 1 );
    thread lerp_spot_intensity( "cine_exfil_tv_rim_030", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_tv_glow", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_tv_glow_2", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_290", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_080_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_160", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_170_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_180", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_280", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_320_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_glow_1", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_door_first", 1, 0.4 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 1.5 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead_050", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_door_rim_040", 0, 0 );
    thread lerp_spot_intensity( "cine_level_downstairs_entry", 0, 0 );
    thread lerp_spot_intensity( "cine_level_downstairs_2", 0, 0 );
    thread lerp_spot_intensity( "cine_level_lamp_out_door", 1, 0 );
    thread lerp_spot_intensity( "cine_exfil_BG_ceiling_light_1", 0, 9 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_270", 0, 0 );
    flag_wait( "lgt_exfil_chair" );
    thread lerp_spot_intensity( "cine_exfil_door_first", 1, 0 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 1, 0 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead_050", 1, 0 );
}

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 1
// Checksum 0x0, Offset: 0x1d92
// Size: 0x1d7b
function function_a69aa7828589faa0( anim_org )
{
    thread function_4755946181d91a4d( anim_org );
    player = anim_org scene::get_entity( "Player 1" );
    ghost_character = anim_org scene::get_entity( "ghost_character" );
    soap_character = anim_org scene::get_entity( "soap_character" );
    milena_character = anim_org scene::get_entity( "milena_character" );
    laptop = anim_org scene::get_entity( "laptop" );
    level waittill( "lgt_exfil_shot_020" );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_010", 0, 1 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_020", 0, 1 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_011", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun", 0, 0 );
    level waittill( "lgt_exfil_shot_030" );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_011", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_glow_030", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_010", 0, 0.4 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_010", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_020", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_tv_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_tv_rim_030", 0, 0.5 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 1.5 );
    level waittill( "lgt_exfil_shot_040" );
    thread lerp_spot_intensity( "cine_exfil_top_040", 0, 2 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_010", 0, 2 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_040", 0, 1 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_070", 0, 8 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_door_rim_040", 0, 0.8 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_011", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_glow_030", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_290", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_tv_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_tv_rim_030", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_290", 0, 0 );
    flag_wait( "lgt_exfil_shot_040_ghost_cross" );
    thread lerp_spot_intensity( "cine_exfil_door_rim_040", 2, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_ghost_040", 0, 0.7 );
    flag_wait( "lgt_cine_exfil_laptop" );
    thread lerp_spot_intensity( "cine_exfil_laptop", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.025 );
    thread lerp_spot_intensity( "cine_exfil_laptop_glow_1", 0, 0.05 );
    level waittill( "lgt_exfil_shot_050" );
    thread lerp_spot_intensity( "cine_exfil_top_050", 0, 26 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.075 );
    thread lerp_spot_intensity( "cine_exfil_rim_right_soap_050", 0, 0.7 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_050", 0, 1.7 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_ghost_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_040", 0, 0 );
    level waittill( "lgt_exfil_shot_060" );
    thread lerp_spot_intensity( "cine_exfil_top_040", 0, 2 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_ghost_040", 0, 0.7 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0.2 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_010", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_070", 0, 8 );
    thread lerp_spot_intensity( "cine_exfil_tv_rim_040", 0, 0.5 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_laptop", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.2 );
    thread lerp_spot_intensity( "cine_exfil_top_050", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_290", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 1.5 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_050", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_right_soap_050", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_tv_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_tv_rim_030", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_290", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_door_rim_040", 0, 0 );
    level waittill( "lgt_exfil_shot_070" );
    thread lerp_spot_intensity( "cine_exfil_top_070", 0, 5.5 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_070", 0, 12 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.12 );
    thread lerp_spot_intensity( "cine_exfil_outside_left", 0, 1 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 1.25 );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_ghost_040", 0, 0 );
    level waittill( "lgt_exfil_shot_080" );
    thread lerp_spot_intensity( "cine_exfil_top_080", 0, 2 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.025 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_ghost_040", 0, 0.7 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_010", 0, 8 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0.2 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_070", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 1.5 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_blinds", 0, 50 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun", 0, 15 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_left", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead_050", 0, 0 );
    flag_wait( "lgt_exfil_flip_door" );
    thread lerp_spot_intensity( "cine_exfil_rim_left_ghost_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_290", 1, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_070", 1, 0 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 1, 1.5 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead_050", 1, 0 );
    thread lerp_spot_intensity( "cine_exfil_door_rim_040", 0, 0.8 );
    thread lerp_spot_intensity( "cine_exfil_outside_2", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 1, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_170_rim", 1, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_010", 1, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_290", 2, 0 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 1, 1.2 );
    level waittill( "lgt_exfil_shot_090" );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.025 );
    thread lerp_spot_intensity( "cine_exfil_laptop_170_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_blinds", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun", 0, 0 );
    level waittill( "lgt_exfil_shot_100" );
    thread lerp_spot_intensity( "cine_exfil_top_140", 0, 1.2 );
    thread lerp_spot_intensity( "cine_exfil_top_080", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_100", 0, 9 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_170_rim", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_door_rim_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 1.2 );
    level waittill( "lgt_exfil_shot_110" );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 1.25 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_110", 0, 35 );
    thread lerp_spot_intensity( "cine_exfil_rim_right_soap_050", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_100", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_080", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_140", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_170_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 0 );
    level waittill( "lgt_exfil_shot_120" );
    thread lerp_spot_intensity( "cine_exfil_top_140", 0, 1.2 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 1.5 );
    thread lerp_spot_intensity( "cine_exfil_laptop_170_rim", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 1.2 );
    thread lerp_spot_intensity( "cine_exfil_soap_eyes", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_110", 0, 0 );
    level waittill( "lgt_exfil_shot_130" );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 1.25 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_110", 0, 15 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_140", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_170_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_soap_eyes", 0, 0 );
    level waittill( "lgt_exfil_shot_140" );
    thread lerp_spot_intensity( "cine_exfil_top_140", 0, 1.2 );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_010", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.015 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 1.5 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 1.2 );
    thread lerp_spot_intensity( "cine_exfil_soap_eyes", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_110", 0, 0 );
    level waittill( "lgt_exfil_shot_150" );
    thread lerp_spot_intensity( "cine_exfil_top", 0, 9 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_150", 0, 1 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_ghost_150", 0, 1.2 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_ghost_150", 0, 8 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_150", 0, 6 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_040", 0, 1 );
    thread lerp_spot_intensity( "cine_exfil_top_source_glow_150", 0, 7 );
    thread lerp_spot_intensity( "cine_exfil_top_140", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_011", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_glow_030", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_soap_eyes", 0, 0 );
    level waittill( "lgt_exfil_shot_160" );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 1.3 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_ghost_160", 0, 3 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_250", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_rim_right_ghost_160", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_150", 0, 2 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.15 );
    thread lerp_spot_intensity( "cine_exfil_laptop_160", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_blinds", 0, 40 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun", 0, 15 );
    thread lerp_spot_intensity( "cine_exfil_top", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_011", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_glow_030", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_2_glow_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_source_glow_150", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_150", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_150", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_ghost_150", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop", 0, 0 );
    level waittill( "lgt_exfil_shot_170" );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_320", 0, 0.2 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_150", 0, 0.4 );
    thread lerp_spot_intensity( "cine_exfil_laptop_170_rim", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 1.2 );
    thread lerp_spot_intensity( "cine_exfil_laptop_160", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_250", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_blinds", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun", 0, 0 );
    flag_wait( "lgt_exfil_shot_170_laptop_2" );
    thread lerp_spot_intensity( "cine_exfil_laptop_170_rim", 1, 0.2 );
    level waittill( "lgt_exfil_shot_180" );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 2.5 );
    thread lerp_spot_intensity( "cine_exfil_laptop_180", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_rim_right_ghost_160", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_250", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_ghost_160", 0, 1 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.15 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_blinds", 0, 40 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun", 0, 15 );
    thread lerp_spot_intensity( "cine_exfil_laptop_glow_1", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_160", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_160", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_170_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_320", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 0 );
    level waittill( "lgt_exfil_shot_190" );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.2 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_190", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_150", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_170_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_250", 0, 0 );
    level waittill( "lgt_exfil_shot_200" );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 2.5 );
    thread lerp_spot_intensity( "cine_exfil_laptop_160", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_rim_right_ghost_160", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_250", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_soap_eyes", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_laptop_180", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_190", 0, 0 );
    level waittill( "lgt_exfil_shot_210" );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 2.5 );
    thread lerp_spot_intensity( "cine_exfil_hand_grab_key", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_hand_grab_fill", 0, 0.005 );
    thread lerp_spot_intensity( "cine_exfil_BG_ceiling_light_1", 0, 5 );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_250", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_soap_eyes", 0, 0 );
    level waittill( "lgt_exfil_shot_220" );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 1.2 );
    thread lerp_spot_intensity( "cine_exfil_laptop_160", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_220", 0, 16 );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_hand_grab_fill", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_hand_grab_key", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_010", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_170_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_blinds", 0, 0 );
    level waittill( "lgt_exfil_shot_230" );
    thread lerp_spot_intensity( "cine_exfil_top_140", 0, 1.2 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_laptop_180", 0, 0.075 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_320", 0, 0.2 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 1.2 );
    thread lerp_spot_intensity( "cine_exfil_soap_eyes", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_220", 0, 0 );
    level waittill( "lgt_exfil_shot_240" );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 1.2 );
    thread lerp_spot_intensity( "cine_exfil_laptop_180", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_220", 0, 10 );
    thread lerp_spot_intensity( "cine_exfil_top_240", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_140", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_320", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_soap_eyes", 0, 0 );
    level waittill( "lgt_exfil_shot_250" );
    thread lerp_spot_intensity( "cine_exfil_top_100", 0, 9 );
    thread lerp_spot_intensity( "cine_exfil_top_240", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_250", 0, 0.5 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.02 );
    thread lerp_spot_intensity( "cine_exfil_laptop_250", 0, 0.02 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun", 0, 33 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_blinds", 0, 40 );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_160", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_180", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_2", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_220", 0, 0 );
    level waittill( "lgt_exfil_shot_260" );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.13 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_laptop_250", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_250", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_260", 0, 16 );
    thread lerp_spot_intensity( "cine_exfil_top_240", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_100", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_blinds", 0, 0 );
    level waittill( "lgt_exfil_shot_270" );
    thread lerp_spot_intensity( "cine_exfil_top_140", 0, 1.5 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 0.5 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_250", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_soap_eyes", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_240", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_ghost_160", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_260", 0, 0 );
    flag_wait( "lgt_exfil_shot_270_lean" );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_320", 1, 0.09 );
    level waittill( "lgt_exfil_shot_280" );
    thread lerp_spot_intensity( "cine_exfil_top_281", 0, 2 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_250", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_110", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_laptop_250", 3, 0.08 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun", 0, 33 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_blinds", 0, 40 );
    thread lerp_spot_intensity( "cine_exfil_soap_eyes", 0, 0.05 );
    thread function_e946565fc572aae2();
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 2, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_320", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_140", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_270", 0, 0 );
    level waittill( "lgt_exfil_shot_290" );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0.6 );
    thread lerp_spot_intensity( "cine_exfil_laptop_250", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_250", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_290", 0, 18 );
    thread function_787da89f3b53b194();
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_right_290", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_100", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_130", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_280", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_281", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_blinds", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_soap_eyes", 0, 0 );
    level waittill( "lgt_exfil_shot_300" );
    thread lerp_spot_intensity( "cine_exfil_top_280", 0, 2 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 1.5 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_290", 0, 0.2 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_blinds", 0, 40 );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_right_290", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_290", 0, 0 );
    level waittill( "lgt_exfil_shot_310" );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0.6 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_250", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_290", 0, 18 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_right_290", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_100", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_280", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_290", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_150", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_blinds", 0, 0 );
    level waittill( "lgt_exfil_shot_320" );
    thread lerp_spot_intensity( "cine_exfil_top_280", 0, 2 );
    thread lerp_spot_intensity( "cine_exfil_laptop_glow_1", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 1.5 );
    thread lerp_spot_intensity( "cine_exfil_laptop_320_rim", 0, 0.01 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_320", 0, 0.2 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_290", 0, 0 );
    level waittill( "lgt_exfil_shot_330" );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 4 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0.6 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_250", 0, 0.3 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_290", 0, 18 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_milena_070", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_right_rim_soap_080", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_right_290", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_100", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_290", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_150", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_280", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_290", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_320_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_glow_1", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_320", 0, 0 );
    level waittill( "lgt_exfil_shot_340" );
    thread lerp_spot_intensity( "cine_exfil_top_280", 0, 2 );
    thread lerp_spot_intensity( "cine_exfil_door_overhead", 0, 1.5 );
    thread lerp_spot_intensity( "cine_exfil_laptop_320_rim", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_laptop_glow_1", 0, 0.05 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_320", 0, 0.1 );
    thread lerp_spot_intensity( "cine_exfil_top_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_100", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_290", 0, 0 );
    flag_wait( "lgt_exfil_shot_340_close_laptop" );
    thread lerp_spot_intensity( "cine_exfil_laptop", 0.25, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_080_rim", 0.25, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_110", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_250", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_320_rim", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_laptop_glow_1", 0, 0 );
    level waittill( "lgt_exfil_shot_350" );
    thread lerp_spot_intensity( "cine_exfil_top_350", 0, 12 );
    thread lerp_spot_intensity( "cine_exfil_top_rim_350", 0, 5 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_350", 0, 0.7 );
    thread lerp_spot_intensity( "cine_exfil_tv_rim_030", 0, 0.2 );
    thread lerp_spot_intensity( "cine_exfil_outside_balcony_right_glow_sun_010", 0, 20 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_040", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_280", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_top_100", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_fill_right_soap_320", 0, 0 );
    thread lerp_spot_intensity( "cine_exfil_rim_left_290", 0, 0 );
    level waittill( "lgt_exfil_cut" );
    hidecinematicletterboxing( 0, 0 );
    thread scripts\common\hud_util::fade_out( 0 );
    level.var_f86dca03b4e10a79 = undefined;
    level waittill( "lgt_exfil_end" );
}

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 1
// Checksum 0x0, Offset: 0x3b15
// Size: 0xaf9
function function_4755946181d91a4d( anim_org )
{
    player = anim_org scene::get_entity( "Player 1" );
    ghost_character = anim_org scene::get_entity( "ghost_character" );
    soap_character = anim_org scene::get_entity( "soap_character" );
    milena_character = anim_org scene::get_entity( "milena_character" );
    laptop = anim_org scene::get_entity( "laptop" );
    flag_wait( "lgt_exfil_shot_020" );
    level.player thread utility::dof_enable_autofocus( 1, soap_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_030" );
    level.player thread utility::dof_enable_autofocus( 1, milena_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_030_soap" );
    level.player thread utility::dof_enable_autofocus( 1, soap_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_040" );
    level.player thread utility::dof_enable_autofocus( 1, soap_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_040_ghost" );
    level.player thread utility::dof_enable_autofocus( 1, ghost_character, 5, 2, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_040_soap" );
    level.player thread utility::dof_enable_autofocus( 1, soap_character, 5, 2, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_050" );
    level.player thread utility::dof_enable_autofocus( 0.7, milena_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_060" );
    level.player thread utility::dof_enable_autofocus( 0.7, soap_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_070" );
    level.player thread utility::dof_enable_autofocus( 0.5, milena_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_080" );
    level.player thread utility::dof_enable_autofocus( 1, ghost_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_080_1_soap_sit" );
    level.player thread utility::dof_enable_autofocus( 0.7, soap_character, 5, 3, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_080_ghost_door" );
    level.player thread utility::dof_enable_autofocus( 1.2, ghost_character, 5, 2, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_080_soap_1" );
    level.player thread utility::dof_enable_autofocus( 1.2, soap_character, 5, 10, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_090" );
    level.player thread utility::dof_enable_autofocus( 1, soap_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_100" );
    wait 0.05;
    level.player thread utility::dof_enable_autofocus( 0.5, soap_character, 5, 10, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_110" );
    level.player thread utility::dof_disable_autofocus();
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 0.5, 81, 49, 49 );
    flag_wait( "lgt_exfil_shot_110_1" );
    level.player setphysicaldepthoffield( 0.5, 75, 5, 49 );
    flag_wait( "lgt_exfil_shot_110_2" );
    level.player setphysicaldepthoffield( 0.5, 77, 5, 49 );
    flag_wait( "lgt_exfil_shot_110_3" );
    level.player setphysicaldepthoffield( 0.5, 81, 5, 49 );
    flag_wait( "lgt_exfil_shot_120" );
    level.player setphysicaldepthoffield( 0.5, 75, 5, 49 );
    flag_wait( "lgt_exfil_shot_130" );
    level.player setphysicaldepthoffield( 0.16, 76.5, 49, 49 );
    flag_wait( "lgt_exfil_shot_140" );
    level.player setphysicaldepthoffield( 0.22, 33.1, 49, 49 );
    flag_wait( "lgt_exfil_shot_150" );
    level.player disablephysicaldepthoffieldscripting();
    level.player thread utility::dof_enable_autofocus( 0.4, ghost_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_160" );
    level.player thread utility::dof_enable_autofocus( 0.75, ghost_character, 49, 49, undefined, "tag_helmetlight" );
    level waittill( "lgt_exfil_shot_170" );
    level.player dof_disable_autofocus();
    wait 0.05;
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 0.5, 50, 49, 49 );
    flag_wait( "lgt_exfil_shot_180" );
    level.player disablephysicaldepthoffieldscripting();
    level.player thread utility::dof_enable_autofocus( 0.8, ghost_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_180_1" );
    level.player thread utility::dof_enable_autofocus( 0.8, soap_character, 30, 50, undefined, "tag_helmetlight" );
    level waittill( "lgt_exfil_shot_190" );
    wait 0.05;
    level.player thread utility::dof_enable_autofocus( 0.25, milena_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_200" );
    level.player dof_disable_autofocus();
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 0.7, 18, 49, 49 );
    flag_wait( "lgt_exfil_shot_210" );
    level.player setphysicaldepthoffield( 3, 18, 49, 49 );
    level waittill( "lgt_exfil_shot_220" );
    wait 0.05;
    level.player setphysicaldepthoffield( 0.13, 52, 49, 49 );
    flag_wait( "lgt_exfil_shot_230" );
    level.player setphysicaldepthoffield( 0.13, 79, 49, 49 );
    flag_wait( "lgt_exfil_shot_240" );
    level.player setphysicaldepthoffield( 0.2, 40, 49, 49 );
    flag_wait( "lgt_exfil_shot_240_1" );
    level.player setphysicaldepthoffield( 0.2, 43.5, 49, 49 );
    flag_wait( "lgt_exfil_shot_240_2" );
    level.player setphysicaldepthoffield( 0.2, 42, 49, 49 );
    flag_wait( "lgt_exfil_shot_250" );
    level.player disablephysicaldepthoffieldscripting();
    level.player thread utility::dof_enable_autofocus( 1, ghost_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_250_1" );
    level.player thread utility::dof_enable_autofocus( 1, soap_character, 15, 15, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_260" );
    level.player dof_disable_autofocus();
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 0.13, 51, 49, 49 );
    flag_wait( "lgt_exfil_shot_260_1" );
    level.player setphysicaldepthoffield( 0.13, 49, 15, 49 );
    flag_wait( "lgt_exfil_shot_260_2" );
    level.player setphysicaldepthoffield( 0.13, 46, 15, 49 );
    flag_wait( "lgt_exfil_shot_260_3" );
    level.player setphysicaldepthoffield( 0.13, 44.5, 15, 49 );
    flag_wait( "lgt_exfil_shot_260_4" );
    level.player setphysicaldepthoffield( 0.13, 47.5, 15, 49 );
    level waittill( "lgt_exfil_shot_270" );
    level.player disablephysicaldepthoffieldscripting();
    level.player thread utility::dof_enable_autofocus( 0.2, soap_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_280" );
    level.player thread utility::dof_enable_autofocus( 1, soap_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_280_ghost_lean" );
    level.player thread utility::dof_enable_autofocus( 0.7, ghost_character, 5, 1, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_290" );
    level.player dof_disable_autofocus();
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 0.4, 29, 49, 49 );
    flag_wait( "lgt_exfil_shot_290_2" );
    level.player setphysicaldepthoffield( 0.4, 25, 15, 49 );
    flag_wait( "lgt_exfil_shot_300" );
    level.player disablephysicaldepthoffieldscripting();
    level.player thread utility::dof_enable_autofocus( 0.7, soap_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_310" );
    level.player dof_disable_autofocus();
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 0.8, 23, 49, 49 );
    flag_wait( "lgt_exfil_shot_320" );
    level.player disablephysicaldepthoffieldscripting();
    level.player thread utility::dof_enable_autofocus( 0.7, soap_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_330" );
    level.player dof_disable_autofocus();
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 0.8, 24, 49, 49 );
    flag_wait( "lgt_exfil_shot_330_2_1" );
    level.player setphysicaldepthoffield( 0.8, 25, 49, 49 );
    flag_wait( "lgt_exfil_shot_330_2" );
    level.player setphysicaldepthoffield( 0.8, 26, 15, 49 );
    flag_wait( "lgt_exfil_shot_330_3" );
    level.player setphysicaldepthoffield( 0.8, 24.5, 15, 49 );
    setdvar( @"hash_93ca035fa3964d3d", 1 );
    flag_wait( "lgt_exfil_shot_340" );
    level.player disablephysicaldepthoffieldscripting();
    level.player thread utility::dof_enable_autofocus( 0.7, soap_character, 49, 49, undefined, "tag_helmetlight" );
    flag_wait( "lgt_exfil_shot_350" );
    level.player thread utility::dof_enable_autofocus( 1, milena_character, 49, 49, undefined, "tag_helmetlight" );
    level waittill( "lgt_exfil_end" );
    level.player thread utility::dof_disable_autofocus();
}

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 5
// Checksum 0x0, Offset: 0x4616
// Size: 0x64
function function_e128e43a29fb2ca9( player, ghost_character, soap_character, milena_character, laptop )
{
    level.player disablephysicaldepthoffieldscripting();
    flag_wait( "lgt_exfil_door_enter" );
    level.player thread utility::dof_enable_autofocus( 1, milena_character, 2, 2, undefined, "tag_helmetlight" );
}

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 0
// Checksum 0x0, Offset: 0x4682
// Size: 0x80
function function_1be9145b47c4b31d()
{
    thread function_61a998996cc98831();
    setdvar( @"hash_6e3f8cef6be16b33", 1 );
    setdvar( @"hash_1ea8544d78048529", 1 );
    setdvar( @"hash_5d66c2ef5a9612e0", 0 );
    setdvar( @"hash_dacffbfd52c2fdc5", 8 );
    setdvar( @"hash_eca4b727b01fd254", 8 );
    setdvar( @"hash_e08232af8b8b695c", 6 );
    setdvar( @"hash_63eb1893f96ac98d", 8 );
}

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 0
// Checksum 0x0, Offset: 0x470a
// Size: 0x13a
function function_ee89f51c6b88bf1a()
{
    thread function_61a998996cc98831();
    setdvar( @"hash_7e128eb152f9065a", 0.0001 );
    setdvar( @"hash_e3f56fe404e467cb", 5 );
    setdvar( @"hash_8adcf05d62fe94fd", 0.1 );
    setdvar( @"hash_7c6e3f49a053cc4c", 0.2 );
    setdvar( @"hash_b345e52965c135b5", 0.2 );
    setdvar( @"hash_bc13d3a46e2c2877", 0.4 );
    setsaveddvar( @"hash_1dde331a8e0153d8", 16 );
    setdvar( @"hash_6e3f8cef6be16b33", 1 );
    setdvar( @"hash_1ea8544d78048529", 1 );
    setdvar( @"hash_5d66c2ef5a9612e0", 0 );
    setdvar( @"hash_dacffbfd52c2fdc5", 8 );
    setdvar( @"hash_eca4b727b01fd254", 2 );
    setdvar( @"hash_e08232af8b8b695c", 6 );
    setdvar( @"hash_63eb1893f96ac98d", 12 );
    setdvar( @"hash_5b1b5bd738a5436f", 1 );
    setdvar( @"hash_1fc47d6f68e1faf", 1 );
    setdvar( @"sm_spotdistcull", 300 );
}

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 0
// Checksum 0x0, Offset: 0x484c
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

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 0
// Checksum 0x0, Offset: 0x48b3
// Size: 0x4e
function function_e946565fc572aae2()
{
    var_2c7c9d88b2d9082e = getent( "cine_exfil_outside_balcony_right_glow_sun_blinds", "targetname" );
    var_2c7c9d88b2d9082e function_94e6538604ee3986( "forceshadowon" );
    var_a3a7f6f98899f81 = getent( "cine_exfil_top_281", "targetname" );
    var_a3a7f6f98899f81 function_94e6538604ee3986( "forceshadowon" );
}

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 0
// Checksum 0x0, Offset: 0x4909
// Size: 0x4e
function function_787da89f3b53b194()
{
    var_2c7c9d88b2d9082e = getent( "cine_exfil_outside_balcony_right_glow_sun_blinds", "targetname" );
    var_2c7c9d88b2d9082e function_94e6538604ee3986( "normal" );
    var_a3a7f6f98899f81 = getent( "cine_exfil_top_281", "targetname" );
    var_a3a7f6f98899f81 function_94e6538604ee3986( "normal" );
}

// Namespace namespace_5b91911344c0c843 / namespace_9aee6cba55e1ac28
// Params 0
// Checksum 0x0, Offset: 0x495f
// Size: 0x70
function function_c0df239566181bdd()
{
    flag_set( "lgt_intro_end" );
    flag_set( "lgt_exfil_end" );
    level notify( "lgt_intro_end" );
    level notify( "lgt_exfil_end" );
    thread function_26280fbed5700639();
    level.player thread utility::dof_disable_autofocus();
    level.player disablephysicaldepthoffieldscripting();
    visionsetnaked( "", 0 );
    hidecinematicletterboxing( 0, 0 );
    level.var_f86dca03b4e10a79 = undefined;
}

