#using script_1098b2fcad86e2ff;
#using script_155dfa0cc34a5062;
#using script_19163c4e4e504a5e;
#using script_1db908936531314b;
#using script_1e172edbfbe283b6;
#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\dialogue_wheel;
#using scripts\sp\hud_util;
#using scripts\sp\load;
#using scripts\sp\maps\sp_jup_hijack\gen\sp_jup_hijack_art;
#using scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio;
#using scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_fx;
#using scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_rig;
#using scripts\sp\spawner;
#using scripts\sp\utility;

#namespace sp_jup_hijack;

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x1a2d
// Size: 0x6a
function main()
{
    scripts\sp\maps\sp_jup_hijack\gen\sp_jup_hijack_art::main();
    scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_fx::main();
    namespace_a60113f3bd67f601::main();
    scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting::main();
    scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::main();
    level_starts();
    scripts\sp\load::main();
    flag_init( "introscreen_start_wait" );
    function_53ccaaf3e988ccea();
    init_level();
    init_player();
    thread objective_flow();
    level.var_c3934394c0f5cb03 = "sp_hijack_deaths_door";
}

/#

    // Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
    // Params 0
    // Checksum 0x0, Offset: 0x1a9f
    // Size: 0x5, Type: dev
    function function_6acb99ad7e1243d3()
    {
        
    }

#/

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x1aac
// Size: 0xb6
function level_starts()
{
    set_default_start( "intro" );
    add_start( "intro", &intro_start, &intro_main, undefined, &intro_catchup );
    add_start( "hijackers", &hijackers_start, &hijackers_main, undefined, &function_961959bb9765b8ba );
    add_start( "makarov_reveal", &function_837e987facbb27e5, &function_2dbfa8785ecc2bbe, undefined, &function_f99a77eb1feb0c37 );
    add_start( "futile_defuse", &function_17dbdad7c58fcb60, &function_b2ed98f0b1f7a6f9, undefined, &function_27762bc5ed1b4cb6 );
    add_start( "back_to_economy_recording", &function_882edf487ef95e2, &function_31f0c968d73391f3, undefined, &function_2aee6e5f91223f68 );
    add_start( "standoff_recording", &function_e00bd1c22a521607, &function_d031fcfd2af95ef0, undefined, &function_64bf71eda7e2689 );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x1b6a
// Size: 0x385
function init_level()
{
    setsaveddvar( @"cg_fov", 55 );
    setsaveddvar( @"bg_cinematicfullscreen", "0" );
    setsaveddvar( @"hash_ac456948d164faa1", 1 );
    setsaveddvar( @"hash_b8f67e3b279e0584", 1 );
    setsaveddvar( @"hash_475511eeb86d47f2", 1 );
    scripts\engine\sp\utility::add_hint_string( "hijack_disarm_hint", &"SP_JUP_HIJACK/DISARM_HINT" );
    scripts\engine\sp\utility::add_hint_string( "intro_stand_hint", &"SP_JUP_HIJACK/INTRO_STAND_UP" );
    scripts\engine\sp\utility::add_hint_string( "gesture_hint", &"SP_JUP_HIJACK/GESTURE_HINT" );
    precachemodel( "body_civ_london_male_1_1" );
    precachemodel( "uk_townhouse_baby" );
    precachemodel( "body_al_qatala_urban_civ_3_2" );
    precachemodel( "body_civ_russian_dead_clerical_male_1" );
    precachemodel( "body_civ_party_male_3_1" );
    precachemodel( "body_al_qatala_urban_civ_1_1" );
    precachemodel( "body_civ_party_female_1_2" );
    precachemodel( "civ_amsterdam_male_3_3" );
    precachemodel( "body_civ_amsterdam_female_7_1" );
    precachemodel( "body_civ_amsterdam_female_2_1" );
    precachemodel( "dmz_backpack_small" );
    precachemodel( "jup_accessory_plane_luggage_backpack_rig" );
    precachemodel( "jup_accessory_plane_luggage_backpack_01" );
    precachemodel( "head_sc_m_androsov_bg" );
    precachemodel( "head_sc_m_sharipov_bg" );
    precachemodel( "head_sc_m_george_bg_civ" );
    precachemodel( "head_sc_f_wetherbee_bg" );
    precachemodel( "head_sc_f_rezaee_civ_bg" );
    precachemodel( "head_sc_f_alicea_bg_civ" );
    precachemodel( "head_sc_m_ahmadzai" );
    precachemodel( "head_sc_m_alameer" );
    precachemodel( "head_russian_army_sharipov" );
    precachemodel( "electronics_smartphone_01" );
    precachemodel( "misc_vm_smartphone_civilian_v0" );
    precachemodel( "body_hero_price_undercover" );
    precachemodel( "head_hero_price_nohat_lod" );
    precachemodel( "head_sc_male_16_opt" );
    precachemodel( "head_bg_var_head_sc_male_08_head_male_bc_06" );
    precachemodel( "head_sc_m_ferragamo" );
    precachemodel( "head_sc_m_miller_iw9" );
    precachemodel( "head_sc_m_polister" );
    precachemodel( "body_c_jup_sp_hero_fitri" );
    precachemodel( "body_c_jup_sp_enemy_pmc_hooded_01" );
    precachemodel( "body_c_jup_sp_enemy_pmc_hooded_02" );
    precachemodel( "body_c_jup_sp_enemy_pmc_hooded_03" );
    precachemodel( "head_sc_m_johnson_var_1" );
    precachemodel( "head_sc_m_fahselt_civ_no_hair" );
    precachemodel( "head_sc_m_bansal_beard" );
    precachemodel( "body_c_jup_civ_plane_attendant_01" );
    precachemodel( "body_c_jup_sp_civ_plane_attendant_02" );
    precachemodel( "body_c_jup_sp_civ_plane_attendant_02_pregnant" );
    precachemodel( "body_c_jup_sp_enemy_pmc_undercover" );
    precachemodel( "head_sc_m_bruce_var_2" );
    precachemodel( "head_sc_m_rozmiarek" );
    precachemodel( "head_sc_f_chivikina" );
    level.fakeactor_spawn_func = &fakeactor_spawn;
    level.var_4b008acd8d4972c5 = [ "jup_hij_smartphone_06_idle_civ02", "jup_hij_smartphone_06_idle_civ03" ];
    thread function_e2ee6f531da3872c();
    thread function_8ea1fb185586cc5a();
    thread function_53bfad63cce70ff3();
    thread function_182dac5521908fa2();
    thread function_ebd10619133e859c();
    thread function_1f51580c2472a5c8();
    thread function_d143cea35faf4b();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_907c6992fc83d232();
    thread function_d90ecafe1cffe760();
    thread enter_economy_curtains();
    flag_set( "flag_hide_o2_masks" );
    level.var_47d42a0c7d19c938 = &namespace_bde1a0e87b86090::function_25b67057c0f2b89b;
    
    foreach ( civ in level.var_ffd93feee6d8259b )
    {
    }
    
    battlechatter_off();
    thread function_1734e4f3a27d192f();
    thread function_2b76b679c7d68922();
    level.var_35dc8163678b4227 = 0;
    level.friendlyfiredisabled = 1;
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x1ef7
// Size: 0x147
function init_player()
{
    function_7d89f98164b6df3d( "vm_c_jup_sp_hero_fitri", undefined, "default_character_shadow" );
    scripts\sp\player_rig::init_player_rig( "vm_c_jup_sp_hero_fitri", undefined, "vb_c_jup_sp_hero_fitri" );
    level.player val::set( "weapons", "weapon_first_raise_anims", 0 );
    level.player allowsupersprint( 0 );
    level.player allowsprint( 0 );
    level.player allowjump( 0 );
    level.player scripts\sp\player::player_movement_state( "creep" );
    level.player scripts\engine\sp\utility::blend_movespeedscale( 0.5, 0.25 );
    level.player function_3f41cb77e2785636( 0 );
    setsaveddvar( @"hash_d8837d8a14efe9a3", 0 );
    level.player.animating = 0;
    level.player.handsup = 0;
    level.player setentitysoundcontext( "gender", "female", 0 );
    level.player thread actionslotoverride( 4, "none", undefined, &function_4e77ad3c291b5056 );
    thread function_6bae8921a69255a3();
    thread scripts\sp\player::disable_player_weapon_info();
    level.tray = make_weapon( "jup_me_tray_hijack" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x2046
// Size: 0x76
function objective_flow()
{
    flag_wait( "flag_start_objectives" );
    objective_add( "Survive", "current", undefined, &"SP_JUP_HIJACK/OBJ_1_HIJACK" );
    flag_wait( "futile_show_lifeline" );
    objective_add( "Disarm the bomb", "current", undefined, &"SP_JUP_HIJACK/OBJ_2_HIJACK" );
    flag_wait( "hij_0700_explosion" );
    objective_set_state( "Survive", "failed" );
    objective_set_state( "Disarm the bomb", "failed" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x20c4
// Size: 0x13b
function function_6bae8921a69255a3()
{
    level endon( "futile_defuse_start_plane_list" );
    groundrefent = spawn( "script_model", ( 0, 0, 0 ) );
    level.player playersetgroundreferenceent( groundrefent );
    
    while ( true )
    {
        rotation_value = randomfloatrange( 0.5, 4 );
        
        if ( rotation_value < 1 )
        {
            rotation_time = randomfloatrange( 2, 10 );
        }
        else if ( rotation_value > 1 )
        {
            rotation_time = randomfloatrange( 6, 15 );
        }
        
        groundrefent rotateto( ( 0, 0, rotation_value ), rotation_time, rotation_time / 5, rotation_time / 5 );
        wait rotation_time;
        groundrefent rotateto( ( 0, 0, 0 ), rotation_time / 2, rotation_time / 5, rotation_time / 5 );
        wait rotation_time / 2;
        rotation_value = randomfloatrange( -4, -0.5 );
        
        if ( rotation_value > -1 )
        {
            rotation_time = randomfloatrange( 2, 10 );
        }
        else if ( rotation_value < -1 )
        {
            rotation_time = randomfloatrange( 6, 15 );
        }
        
        groundrefent rotateto( ( 0, 0, rotation_value ), rotation_time, rotation_time / 5, rotation_time / 5 );
        wait rotation_time;
        groundrefent rotateto( ( 0, 0, 0 ), rotation_time / 2, rotation_time / 5, rotation_time / 5 );
        wait rotation_time / 2;
    }
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x2207
// Size: 0x28
function function_182dac5521908fa2()
{
    rear_plane_door = getent( "rear_plane_door", "targetname" );
    rear_plane_door setmodel( "jup_gate_plane_exit_doors_rig" );
}

/#

    // Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
    // Params 0
    // Checksum 0x0, Offset: 0x2237
    // Size: 0x5, Type: dev
    function function_d6333b592af8d69c()
    {
        
    }

#/

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x2244
// Size: 0x1c
function intro_start()
{
    set_start_location( "intro", [ level.player ] );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x2268
// Size: 0xb8
function intro_main()
{
    flag_set( "introscreen_start_wait" );
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::intro_jet_whine();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_15492311e775ef09();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_1fe5ec9e8442ee3();
    thread scripts\sp\hud_util::fade_out( 0, "black" );
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_8bc536c11fe3eb9();
    model = getent( "rear_plane_door", "targetname" );
    model setmodel( "jup_gate_plane_exit_doors_rig" );
    wait 5;
    thread function_54b1b98949d747f();
    thread function_c16ff4a3aa4d12e7();
    thread function_494dfc68a364045e();
    thread function_db7cf901994d45d0();
    wait 1;
    thread scripts\sp\hud_util::fade_in( 0, "black" );
    flag_wait( "flag_intro_complete" );
    cart_blocker = function_fa35b59a26e5cc66( "debug_cart_blocker" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x2328
// Size: 0x216
function function_494dfc68a364045e()
{
    var_cfe2e30acba4c67e = level_spawner( "man" );
    level.front_civ = var_cfe2e30acba4c67e spawn_ai( 1 );
    level.front_civ.animname = "front_civ";
    level.front_civ.targetname = "front_civ";
    waitframe();
    level.filming_civ = var_cfe2e30acba4c67e spawn_ai( 1 );
    level.filming_civ.animname = "filming_civ";
    level.filming_civ.targetname = "filming_civ";
    level.marshal_1 = spawn_aitype( "actor_jup_enemy_hijack_air_marshal_2", ( 0, 0, 0 ), ( 0, 0, 0 ), 1 );
    level.marshal_1.animname = "air_marshal_1";
    level.marshal_1.targetname = "air_marshal_1";
    level.marshal_2 = spawn_aitype( "actor_jup_enemy_hijack_air_marshal", ( 0, 0, 0 ), ( 0, 0, 0 ), 1 );
    level.marshal_2.animname = "air_marshal_2";
    level.marshal_2.targetname = "air_marshal_2";
    function_1c677895c2060ff6( "marhsal1", "gameplay", level.marshal_1, 0, -1, 2 );
    function_1c677895c2060ff6( "marhsal2", "gameplay", level.marshal_2, 0, -1, 2 );
    animnode = getstruct( "jup_hij_0200_standoff", "targetname" );
    animnode anim_first_frame_solo( level.marshal_1, "jup_hij_0200_standoff_airmarshal_01_start" );
    animnode anim_first_frame_solo( level.marshal_2, "jup_hij_0200_standoff_airmarshal_02_start" );
    animnode anim_first_frame_solo( level.front_civ, "jup_hij_0200_standoff_civ_01_start" );
    animnode anim_first_frame_solo( level.filming_civ, "jup_hij_0200_standoff_civ_02_start" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x2546
// Size: 0x2f
function function_c16ff4a3aa4d12e7()
{
    flag_wait( "intro_turbulence_1" );
    thread function_42ad86cbdd2d532c( 0 );
    flag_wait( "intro_turbulence_2" );
    flag_set( "flag_move_stewardess_further" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x257d
// Size: 0x3bd
function function_54b1b98949d747f()
{
    animnode = getstruct( "scene_hij_010_intro", "targetname" );
    actors = [ level.neighbor, level.stewardess ];
    thread intro_music();
    thread zoom_disable();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_aee51ba44e4e892();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_22d2fc50ad928fd2();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_d8c586f52f52805e();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_475b473cd5fe0c73();
    intro_phone = animnode scene::get_entity( "intro_phone" );
    thread function_7070c8a674d0b8c9( intro_phone );
    level.player delaycall( 18, &lerpviewangleclamp, 1, 1, 1, 10, 10, 10, 10 );
    delaythread( 1, &function_ed04e541e65d1dce, animnode );
    animnode scene::play( actors, "shot_010" );
    animnode thread scene::play( actors, "shot_020_idle" );
    thread autosave_now_silent();
    wait 0.5;
    thread function_365c95a5050985c9( 1 );
    wait 0.25;
    flag_set( "flag_start_objectives" );
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_6159c7170473b3b5();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_bbebf4009dc0eaa0();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_c9ded0a9c560bbff();
    timeout_time = 5;
    messages = [ "hij_player_stand_button_pressed", "hij_melee_button_pressed" ];
    level.player scripts\engine\sp\utility::display_hint_forced( "hijack_disarm_hint", timeout_time, 0, level.player, messages );
    thread function_2618248c26c2bfde();
    thread function_ac1e83a11ee00674();
    flag_wait_any_timeout( timeout_time, "flag_player_stand_button_pressed", "flag_player_disarmed_neighbor" );
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_623b2fe30a053c15();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_ca3c04ca4ff302b5();
    level notify( "intro_choice_made" );
    var_bdc512b8d83a9275 = getstruct( "jup_hij_0200_standoff", "targetname" );
    var_bdc512b8d83a9275 thread scene::play( level.stewardess, "shot_idle" );
    
    if ( flag( "flag_player_disarmed_neighbor" ) )
    {
        level.player.gun_taken = 1;
        thread function_c2553f2d985620d5();
        var_e86b25000c0fb10e = getstruct( "jup_hij_0200_standoff", "targetname" );
        var_e86b25000c0fb10e thread scene::play( undefined, "jup_hij_0200_standoff_start" );
        ents = var_e86b25000c0fb10e scene::function_77751080050d2cb1( "Types_Actor", "jup_hij_0200_standoff_start", "jup_hij_0200_standoff" );
        function_38497ef67aae58c8( ents );
        npc1 = getent( "takedown_npc_1", "target" );
        npc2 = getent( "takedown_npc_2", "target" );
        npc3 = getent( "takedown_npc_3", "target" );
        npc4 = getent( "takedown_npc_4", "target" );
        npc5 = getent( "takedown_npc_5", "target" );
        thread function_587b8e0d4e4090f4( npc1, animnode, "jup_hij_0150_disarm_from_enemy_01_civ01" );
        thread function_587b8e0d4e4090f4( npc2, animnode, "jup_hij_0150_disarm_from_enemy_01_civ02" );
        thread function_587b8e0d4e4090f4( npc3, animnode, "jup_hij_0150_disarm_from_enemy_01_civ03" );
        thread function_587b8e0d4e4090f4( npc4, animnode, "jup_hij_0150_disarm_from_enemy_01_civ04" );
        thread function_587b8e0d4e4090f4( npc5, animnode, "jup_hij_0150_disarm_from_enemy_01_civ05" );
        animnode scene::play( actors, "shot_030_disarm" );
    }
    else
    {
        neighbor = animnode scene::get_entity( "neighbor" );
        level.player.gun_taken = 0;
        animnode scene::play( actors, "shot_050_stand" );
        neighbor delete();
    }
    
    thread zoom_enable();
    debug_stuffy = function_fa35b59a26e5cc66( "debug_stuffy" );
    flag_set( "flag_intro_complete" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x2942
// Size: 0x51
function function_ac1e83a11ee00674()
{
    level endon( "intro_choice_made" );
    level.player endon( "Disarm_end" );
    
    while ( true )
    {
        if ( level.player meleebuttonpressed() )
        {
            level.player notify( "hij_melee_button_pressed" );
            flag_set( "flag_player_disarmed_neighbor" );
            break;
        }
        
        waitframe();
    }
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x299b
// Size: 0x7a
function function_2618248c26c2bfde()
{
    level endon( "intro_choice_made" );
    wait 1;
    movement = level.player getnormalizedmovement();
    
    while ( !level.player stancebuttonpressed() && movement == ( 0, 0, 0 ) )
    {
        movement = level.player getnormalizedmovement();
        waitframe();
    }
    
    level.player notify( "hij_player_stand_button_pressed" );
    flag_set( "flag_player_stand_button_pressed" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x2a1d
// Size: 0x21
function intro_music()
{
    setmusicstate( "mx_hijack_seated" );
    level.player setsoundsubmix( "sp_jup_hijack_duck_seated_walla_amb" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x2a46
// Size: 0xd
function function_c2553f2d985620d5()
{
    stopmusicstate( "mx_hijack_seated" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x2a5b
// Size: 0x26
function intro_catchup()
{
    flag_set( "flag_intro_complete" );
    flag_set( "flag_spawn_civ_checkpoint" );
    flag_set( "flag_move_stewardess_further" );
}

/#

    // Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
    // Params 0
    // Checksum 0x0, Offset: 0x2a89
    // Size: 0x5, Type: dev
    function function_ff31a86185a4a6c5()
    {
        
    }

#/

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x2a96
// Size: 0x1c
function hijackers_start()
{
    set_start_location( "hijackers", [ level.player ] );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x2aba
// Size: 0x2f
function function_17228b97b9f4769f()
{
    if ( flag( "flag_flashbang_done" ) )
    {
        return;
    }
    
    function_1c677895c2060ff6( string( self getentitynumber() ), "gameplay", self, 0, -1, 2 );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x2af1
// Size: 0xbc1
function hijackers_main()
{
    add_global_spawn_function( "axis", &function_17228b97b9f4769f );
    
    foreach ( civ in level.var_8fdfe8e04db3db1f )
    {
        if ( isai( civ ) )
        {
            civ enable_lookat();
        }
    }
    
    flag_wait( "flag_intro_complete" );
    flag_clear( "flag_spawn_hijackers" );
    flag_set( "flag_hijackers_started" );
    thread function_c2553f2d985620d5();
    flag_set( "flag_trigger_turbulence_1" );
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_6f948ae583865e3e();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_36bac2eed4b69c80();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_6bbac8f70172dad2();
    thread function_a3c560b7e0a3f584();
    level.cleanup_crew = [];
    
    if ( isdefined( level.steward ) && isalive( level.steward ) )
    {
        level.steward delete();
    }
    
    if ( isdefined( level.neighbor ) && isalive( level.neighbor ) )
    {
        level.neighbor delete();
    }
    
    if ( !isdefined( level.player.gun_taken ) )
    {
        level.player.gun_taken = 1;
    }
    
    function_1c677895c2060ff6( "player", "gameplay", level.player, 0, -1, 2 );
    struct = getstruct( "hijackers_v2", "targetname" );
    
    if ( isdefined( struct ) )
    {
        if ( level.player.gun_taken )
        {
            level.weap = make_weapon( "jup_cp24_pi_glima21_sp_3d" );
            level.player give_weapon( level.weap );
            level.player switchtoweaponimmediate( level.weap );
            level.player setweaponammostock( level.weap, 0 );
            level.player setweaponammoclip( level.weap, 15 );
            level.player allowreload( 0 );
            level.player allowfire( 1 );
            level.player allowcrouch( 1 );
            level.player allowsprint( 1 );
            level.player setstance( "stand", 1, 1, 0 );
            level.player delaythread( 1, &function_4e77ad3c291b5056 );
        }
        else
        {
            level.player allowcrouch( 1 );
            level.player allowsprint( 1 );
            level.weap = make_weapon( "iw9_gunless_montage" );
            level.player give_weapon( level.weap );
            level.player switchtoweaponimmediate( level.weap );
            thread function_c8583438e5aded0c();
            waitframe();
            thread function_32cb2a1de20d7e6();
            level.player thread melee_listener();
            level thread function_a733404fceca139f();
        }
        
        flag_set( "flag_spawn_hijackers" );
    }
    
    flag_set( "flag_mexican_standoff_begin" );
    animnode = getstruct( "jup_hij_0200_standoff", "targetname" );
    animnode thread function_ab40eac79468cd2f();
    animnode thread function_a886303a91d34356();
    animnode thread function_1a15931d1a7e9509();
    
    if ( !level.player.gun_taken )
    {
        animnode thread scene::play( undefined, "jup_hij_0200_standoff_start_player" );
        level.var_a613011527cdaa23 = animnode scene::get_object( "Prop 1" );
        animnode thread function_57ac36ea7abb5af4( undefined, undefined, "jup_hij_0200_standoff_start" );
        ents = animnode scene::function_77751080050d2cb1( "Types_Actor", "jup_hij_0200_standoff_start", "jup_hij_0200_standoff" );
        function_38497ef67aae58c8( ents );
        animnode waittill( "scene_complete" );
    }
    else
    {
        while ( animnode scene::get_state() == "Playing" )
        {
            waitframe();
        }
    }
    
    if ( !flag( "standoff_canceled" ) )
    {
        if ( !level.player.gun_taken )
        {
            animnode thread scene::play( undefined, "jup_hij_0200_standoff_loop_player" );
        }
        
        animnode thread scene::play( undefined, "jup_hij_0200_standoff_loop" );
        level waittill_notify_or_timeout( "standoff_canceled", 5 );
    }
    
    flag_set( "flag_trigger_turbulence_2" );
    
    if ( !flag( "standoff_canceled" ) )
    {
        flag_set( "flag_standoff_uncancelable" );
        flag_set( "hijacker_entered" );
        thread flag_clear_delayed( "flag_standoff_uncancelable", 2 );
        
        if ( !level.player.gun_taken )
        {
            animnode thread scene::play( undefined, "jup_hij_0200_standoff_end_player" );
        }
        
        animnode thread stewardess_death();
        animnode scene::play( undefined, "jup_hij_0200_standoff_end" );
        
        if ( !level.player.gun_taken )
        {
            animnode thread scene::play( undefined, "shot_endidle" );
        }
    }
    else
    {
        var_bbad503ff5ae6b6 = getent( "_scene_global_hijacker_2", "targetname" );
        
        if ( isdefined( var_bbad503ff5ae6b6 ) )
        {
            function_6984185a661c2887( string( var_bbad503ff5ae6b6 getentitynumber() ) );
            var_bbad503ff5ae6b6 delete();
        }
        
        var_bbad403ff5ae483 = getent( "_scene_global_hijacker_3", "targetname" );
        
        if ( isdefined( var_bbad403ff5ae483 ) )
        {
            function_6984185a661c2887( string( var_bbad403ff5ae483 getentitynumber() ) );
            var_bbad403ff5ae483 delete();
        }
        
        var_bbad303ff5ae250 = getent( "_scene_global_hijacker_4", "targetname" );
        
        if ( isdefined( var_bbad303ff5ae250 ) )
        {
            function_6984185a661c2887( string( var_bbad303ff5ae250 getentitynumber() ) );
            var_bbad303ff5ae250 delete();
        }
    }
    
    flag_set( "flag_mexican_standoff_end" );
    level.player notify( "hij_player_remove_takedown" );
    var_eff5da43baf69164 = [];
    var_fd1609ea9c241b6f = [];
    am1 = level.marshal_1;
    
    if ( isdefined( am1 ) )
    {
        var_fd1609ea9c241b6f = array_add( var_fd1609ea9c241b6f, am1 );
        level.cleanup_crew = array_add( level.cleanup_crew, am1 );
        am1.var_a2039801f1f31873 = 1;
        am1.team = "team3";
    }
    
    am2 = level.marshal_2;
    
    if ( isdefined( am2 ) )
    {
        var_fd1609ea9c241b6f = array_add( var_fd1609ea9c241b6f, am2 );
        level.cleanup_crew = array_add( level.cleanup_crew, am2 );
        am2.var_a2039801f1f31873 = 1;
        am2.team = "team3";
    }
    
    level.var_79f585084e76199a = make_weapon( "jup_cp24_pi_glima21_sp_3d" );
    var_bbad503ff5ae6b6 = getent( "_scene_global_hijacker_2", "targetname" );
    
    if ( isdefined( var_bbad503ff5ae6b6 ) )
    {
        var_eff5da43baf69164 = array_add( var_eff5da43baf69164, var_bbad503ff5ae6b6 );
        level.cleanup_crew = array_add( level.cleanup_crew, var_bbad503ff5ae6b6 );
        var_bbad503ff5ae6b6.var_a2039801f1f31873 = 1;
        var_bbad503ff5ae6b6 scripts\anim\shared::forceuseweapon( level.var_79f585084e76199a, "primary" );
    }
    
    var_bbad403ff5ae483 = getent( "_scene_global_hijacker_3", "targetname" );
    
    if ( isdefined( var_bbad403ff5ae483 ) )
    {
        var_eff5da43baf69164 = array_add( var_eff5da43baf69164, var_bbad403ff5ae483 );
        level.cleanup_crew = array_add( level.cleanup_crew, var_bbad403ff5ae483 );
        var_bbad403ff5ae483.var_a2039801f1f31873 = 1;
        var_bbad403ff5ae483 scripts\anim\shared::forceuseweapon( level.var_79f585084e76199a, "primary" );
    }
    
    var_bbad303ff5ae250 = getent( "_scene_global_hijacker_4", "targetname" );
    
    if ( isdefined( var_bbad303ff5ae250 ) )
    {
        var_eff5da43baf69164 = array_add( var_eff5da43baf69164, var_bbad303ff5ae250 );
        level.cleanup_crew = array_add( level.cleanup_crew, var_bbad303ff5ae250 );
        var_bbad303ff5ae250.var_a2039801f1f31873 = 1;
        var_bbad303ff5ae250 scripts\anim\shared::forceuseweapon( level.var_79f585084e76199a, "primary" );
    }
    
    neighbor = getent( "_scene_global_neighbor", "targetname" );
    
    if ( isdefined( neighbor ) )
    {
        neighbor.ignoreme = 1;
    }
    
    level.player.ignoreme = 1;
    
    if ( isalive( am1 ) )
    {
        am1 thread function_e47ba6fce6829dbd( var_eff5da43baf69164 );
    }
    
    if ( isalive( am2 ) )
    {
        am2 thread function_e47ba6fce6829dbd( var_eff5da43baf69164 );
    }
    
    if ( isalive( var_bbad503ff5ae6b6 ) )
    {
        var_bbad503ff5ae6b6 thread function_ad2aff0233216ab9( var_fd1609ea9c241b6f );
    }
    
    if ( isalive( var_bbad403ff5ae483 ) )
    {
        var_bbad403ff5ae483 thread function_ad2aff0233216ab9( var_fd1609ea9c241b6f );
    }
    
    if ( isalive( var_bbad303ff5ae250 ) )
    {
        var_bbad303ff5ae250 thread function_ad2aff0233216ab9( var_fd1609ea9c241b6f );
    }
    
    var_f76c66840f6c5ed8 = getnode( "seat_cover_right", "targetname" );
    var_8d2ccf1434086627 = getnode( "seat_cover_left", "targetname" );
    
    if ( isdefined( var_bbad503ff5ae6b6 ) )
    {
        var_bbad503ff5ae6b6.var_3056d8c9bd11f1f2 = 1;
    }
    
    if ( isdefined( var_bbad403ff5ae483 ) )
    {
        var_bbad403ff5ae483 thread function_4dd6bcfa285fa86e( var_f76c66840f6c5ed8 );
    }
    
    if ( isdefined( var_bbad303ff5ae250 ) )
    {
        var_bbad303ff5ae250 thread function_4dd6bcfa285fa86e( var_f76c66840f6c5ed8 );
    }
    
    flag_set( "flag_hijackers_end" );
    thread function_f0fdc3f46c920579();
    level waittill_any_timeout_1( 15, "standoff_over" );
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_faca90fa96fa2939();
    flag_set( "flag_standoff_end" );
    wait 0.5;
    
    if ( istrue( level.var_21fd20948641a30b ) && flag( "hijacker_entered" ) )
    {
        wait 2;
    }
    
    var_e86b25000c0fb10e = getstruct( "scene_hij_0550_flashbang_toss", "targetname" );
    level.player thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting::function_510e7fb47810f595( animnode );
    var_e86b25000c0fb10e thread scene::play( undefined, "shot_010" );
    ents = var_e86b25000c0fb10e scene::function_77751080050d2cb1( "Types_Actor", "shot_010", "scene_hij_0550_flashbang_toss" );
    function_38497ef67aae58c8( ents );
    waitframe();
    wait 4.6;
    animnode thread scene::stop();
    hijackers_flashbang();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_30485484eeb84f8();
    flag_set( "flag_flashbang_done" );
    level.cleanup_crew = array_add( level.cleanup_crew, level.stewardess );
    thread function_112eb3afa848aa64( "flashbang_cam", 2 );
    
    foreach ( guy in level.cleanup_crew )
    {
        if ( isdefined( self.has_bs ) && self.has_bs )
        {
            guy stop_magic_bullet_shield();
        }
        
        if ( !is_dead_or_dying( guy ) )
        {
            guy delete();
        }
    }
    
    wait 0.5;
    var_5d129d554df48180 = spawnstruct();
    var_5d129d554df48180.origin = level.player.origin;
    var_5d129d554df48180 thread scene::play( level.player, "flashbang_melee", "scene_hij_0550_flashbang_toss" );
    level.player earthquakeforplayer( 0.05, 1, level.player.origin, 200 );
    wait 0.1;
    level.player shellshock( "flashbang", 3.5, 1, 0 );
    wait 1;
    thread scripts\sp\hud_util::fade_in( 1.5, "white" );
    flag_wait( "pistol_whip_deathsdoor" );
    level.player thread enabledeathsdoor();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_5e320cd0ce9c9a2b();
    flag_wait( "pistol_whip_ground_hit" );
    thread scripts\sp\hud_util::fade_out( 0.1, "black" );
    wait 0.5;
    level.player thread disabledeathsdoor();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_2a90160a7dd87714();
    clearallcorpses();
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x36ba
// Size: 0x2
function function_961959bb9765b8ba()
{
    
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x36c4
// Size: 0xc3
function function_ab40eac79468cd2f()
{
    level endon( "flag_flashbang_done" );
    level.player waittill( "weapon_fired" );
    level.player.var_179ccec341f75747 = 1;
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_47a0692123a119e6();
    stewardess = scene::get_entity( "civ_to_shoot" );
    var_ce364378f58a6443 = scene::get_entity( "hijacker_3" );
    
    if ( !flag( "last_hijacker_entered" ) )
    {
        if ( isdefined( var_ce364378f58a6443 ) )
        {
            function_6984185a661c2887( string( var_ce364378f58a6443 getentitynumber() ) );
            var_ce364378f58a6443 delete();
        }
    }
    
    if ( isdefined( stewardess ) )
    {
        stewardess thread function_46a7af93f6a23ac3();
    }
    
    while ( flag( "flag_standoff_uncancelable" ) )
    {
        waitframe();
    }
    
    scene::stop();
    flag_set( "standoff_canceled" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x378f
// Size: 0x8e
function function_a886303a91d34356()
{
    level endon( "flag_mexican_standoff_end" );
    flag_wait( "neighbor_takedown" );
    var_ce364378f58a6443 = scene::get_entity( "hijacker_3" );
    
    if ( !flag( "last_hijacker_entered" ) )
    {
        if ( isdefined( var_ce364378f58a6443 ) )
        {
            function_6984185a661c2887( string( var_ce364378f58a6443 getentitynumber() ) );
            var_ce364378f58a6443 delete();
        }
    }
    
    level.stewardess thread function_46a7af93f6a23ac3();
    
    while ( flag( "flag_standoff_uncancelable" ) )
    {
        waitframe();
    }
    
    scene::stop();
    flag_set( "standoff_canceled" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x3825
// Size: 0x21
function function_1a15931d1a7e9509()
{
    function_24968bb85878234d();
    flag_wait_any( "standoff_canceled", "flag_mexican_standoff_end" );
    function_c7ffc674efb6b116();
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x384e
// Size: 0x6f
function function_24968bb85878234d()
{
    filming = scene::get_entity( "filming_civ" );
    front = scene::get_entity( "front_civ" );
    
    if ( isdefined( front ) && !is_dead_or_dying( front ) && !flag( "front_civ_late" ) )
    {
        front thread function_382c9c7dbf0a67e9();
    }
    
    if ( isdefined( filming ) && !is_dead_or_dying( filming ) )
    {
        filming thread function_382c9c7dbf0a67e9();
    }
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x38c5
// Size: 0x79
function function_c7ffc674efb6b116()
{
    filming = scene::get_entity( "filming_civ" );
    front = scene::get_entity( "front_civ" );
    
    if ( isdefined( front ) && !is_dead_or_dying( front ) && !flag( "front_civ_late" ) )
    {
        thread anim_loop_solo( front, "jup_hij_0200_standoff_civ_01_loop" );
    }
    
    if ( isdefined( filming ) && !is_dead_or_dying( filming ) )
    {
        thread anim_loop_solo( filming, "jup_hij_0200_standoff_civ_02_endidle" );
    }
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x3946
// Size: 0x80
function hijackers_flashbang()
{
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::flashbang_explosion();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_88f9036667bbfa9f();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_b87c2c00f5f8cb71();
    thread function_1c070af29897bf1b();
    level.player cleardamageindicators();
    level.player freezecontrols( 1 );
    
    if ( level.player function_c74f5c58d0fd6369() )
    {
        scripts\sp\hud_util::fade_out( 0.1, "black" );
    }
    else
    {
        scripts\sp\hud_util::fade_out( 0.1, "white" );
    }
    
    level notify( "flashbang_done" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x39ce
// Size: 0x1c2
function function_f0fdc3f46c920579()
{
    var_b425b51f51b7b0c = [];
    var_b616051f53dd7ec = [];
    am1 = level.marshal_1;
    
    if ( isdefined( am1 ) )
    {
        var_b425b51f51b7b0c = array_add( var_b425b51f51b7b0c, am1 );
    }
    
    am2 = level.marshal_2;
    
    if ( isdefined( am2 ) )
    {
        var_b425b51f51b7b0c = array_add( var_b425b51f51b7b0c, am2 );
    }
    
    var_bbad503ff5ae6b6 = getent( "_scene_global_hijacker_2", "targetname" );
    
    if ( isdefined( var_bbad503ff5ae6b6 ) )
    {
        var_b616051f53dd7ec = array_add( var_b616051f53dd7ec, var_bbad503ff5ae6b6 );
    }
    
    var_bbad403ff5ae483 = getent( "_scene_global_hijacker_3", "targetname" );
    
    if ( isdefined( var_bbad403ff5ae483 ) )
    {
        var_b616051f53dd7ec = array_add( var_b616051f53dd7ec, var_bbad403ff5ae483 );
    }
    
    var_bbad303ff5ae250 = getent( "_scene_global_hijacker_4", "targetname" );
    
    if ( isdefined( var_bbad303ff5ae250 ) )
    {
        var_b616051f53dd7ec = array_add( var_b616051f53dd7ec, var_bbad303ff5ae250 );
    }
    
    while ( true )
    {
        wait 0.5;
        amdead = var_b425b51f51b7b0c.size > 0;
        var_85d865b682375bd5 = var_b616051f53dd7ec.size > 0;
        
        foreach ( ai in var_b425b51f51b7b0c )
        {
            if ( !is_dead_or_dying( ai ) )
            {
                amdead = 0;
            }
        }
        
        foreach ( ai in var_b616051f53dd7ec )
        {
            if ( !is_dead_or_dying( ai ) )
            {
                var_85d865b682375bd5 = 0;
            }
        }
        
        if ( amdead || var_85d865b682375bd5 )
        {
            break;
        }
    }
    
    level notify( "standoff_over" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x3b98
// Size: 0x10
function function_1c070af29897bf1b()
{
    wait 2;
    setmusicstate( "mx_hijack_makarovreveal" );
}

/#

    // Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
    // Params 0
    // Checksum 0x0, Offset: 0x3bb0
    // Size: 0x5, Type: dev
    function function_727c58530f3119e2()
    {
        
    }

#/

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x3bbd
// Size: 0x2a
function function_837e987facbb27e5()
{
    set_start_location( "hijackers", [ level.player ] );
    thread scripts\sp\hud_util::fade_out( 0, "black" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x3bef
// Size: 0x1c7
function function_2dbfa8785ecc2bbe()
{
    if ( !flag( "passenger_transition_to_alert" ) )
    {
        flag_set( "flag_hijackers_started" );
        flag_set( "passenger_transition_to_alert" );
    }
    
    flag_set( "flag_hijackers_started" );
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_6f0e50943cc99139();
    level.player scripts\engine\sp\utility::blend_movespeedscale( 0.3, 0.25 );
    level.player disableweaponpickup();
    level.player function_6078d3c20d55c620( 1 );
    var_41896001e4362fb3 = getstruct( "scene_hij_0550_first_class", "targetname" );
    waitframe();
    var_41896001e4362fb3 thread scene::play( undefined, "staging_shot", "scene_hij_0550_first_class" );
    var_41896001e4362fb3 thread function_57ac36ea7abb5af4( undefined, undefined, "first_class_drag" );
    level.player thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting::function_d20e92819af22401( var_41896001e4362fb3 );
    wait 1;
    level.player setblurforplayer( 10.3, 0 );
    waitframe();
    thread scripts\sp\hud_util::fade_in( 2, "black" );
    level.player setblurforplayer( 0, 2 );
    thread autosave_now_silent();
    delaythread( 3.85, &function_e6aa5905388847cf, 2.5, 3 );
    delaythread( 3, &function_76238eb4d960e867 );
    var_41896001e4362fb3 waittill( "scene_complete" );
    var_edbeb1df0ba8bd5c = getstruct( "scene_hij_0600_makarov_parachute", "targetname" );
    waitframe();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_657f121fc52518ca();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_c8de152f50814b71();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_56490d046a0db2a6();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_2868ab53f630a1a6();
    var_edbeb1df0ba8bd5c thread function_57ac36ea7abb5af4( undefined, undefined, "shot_010" );
    level.player thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting::function_c40e793c5a31c2f7( var_edbeb1df0ba8bd5c );
    countdown_phone = var_edbeb1df0ba8bd5c scene::get_entity( "makarov_countdown_phone" );
    thread function_d7c6627f65ecb8ac( countdown_phone );
    var_edbeb1df0ba8bd5c waittill( "scene_complete" );
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_2adfa93148e9c10e();
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 3
// Checksum 0x0, Offset: 0x3dbe
// Size: 0x66
function function_e6aa5905388847cf( scale, duration, slow_scale )
{
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_186c811d20202ad();
    
    if ( !isdefined( scale ) )
    {
        scale = 2.5;
    }
    
    if ( !isdefined( duration ) )
    {
        duration = 3;
    }
    
    if ( !isdefined( slow_scale ) )
    {
        slow_scale = 0.35;
    }
    
    level.earthquake_active = 1;
    thread turbulence( scale, duration, slow_scale );
    wait duration;
    level.earthquake_active = 0;
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x3e2c
// Size: 0x55
function function_76238eb4d960e867()
{
    level.player setblurforplayer( 5, 1 );
    wait 1;
    level.player setblurforplayer( 0, 1 );
    wait 2;
    level.player setblurforplayer( 5, 1 );
    wait 1;
    level.player setblurforplayer( 0, 1 );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x3e89
// Size: 0x38
function function_f99a77eb1feb0c37()
{
    flag_set( "passenger_transition_to_alert" );
    flag_set( "flag_hide_o2_masks" );
    
    if ( level.start_point != "standoff_recording" )
    {
        flag_set( "lgt_mak_para_door_open" );
    }
}

/#

    // Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
    // Params 0
    // Checksum 0x0, Offset: 0x3ec9
    // Size: 0x5, Type: dev
    function function_ca866f43f97b88ff()
    {
        
    }

#/

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x3ed6
// Size: 0x75
function function_17dbdad7c58fcb60()
{
    set_start_location( "futile_defuse", [ level.player ] );
    
    if ( !flag( "passenger_transition_to_alert" ) )
    {
        flag_set( "flag_hijackers_started" );
        flag_set( "passenger_transition_to_alert" );
    }
    
    flag_set( "flag_hijackers_started" );
    wait 1;
    level.player thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting::player_bomb_blinking();
    level.player thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting::function_8d0cbb338cb1d6b5( 50 );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x3f53
// Size: 0x290
function function_b2ed98f0b1f7a6f9()
{
    thread autosave_now_silent();
    clearallcorpses();
    thread function_cba15d748d5113d2();
    thread function_eadeeb4cffc84813();
    thread function_6e6f9e6665d05f18();
    thread function_8e58cd53e43d9ed5();
    level.player disableweaponpickup();
    flag_wait( "makarov_exit_player_in_economy" );
    wait 1;
    wait 1;
    flag_set( "futile_show_lifeline" );
    flag_wait( "player_gun_up" );
    level.weap = make_weapon( "jup_cp24_pi_glima21_sp_3d" );
    level.player give_weapon( level.weap );
    level.player switchtoweaponimmediate( level.weap );
    level.player setweaponammoclip( level.weap, 0 );
    level.player setweaponammostock( level.weap, 0 );
    flag_wait( "makarov_exit_player_drag_end" );
    thread function_9529b1fd17e35803();
    level.player allowstand( 1 );
    level.player allowprone( 0 );
    level.player allowcrouch( 0 );
    level.player setstance( "stand", 0, 0, 0 );
    flag_set( "flag_block_business_class" );
    level.player allowfire( 1 );
    level.player disable_player_weapon_info();
    flag_set( "flag_player_has_weapon_return_to_econ" );
    level.player function_4e77ad3c291b5056();
    wait 1;
    thread function_e6aa5905388847cf( 2.5, 3, 0.6 );
    delaythread( 4, &function_e6aa5905388847cf, 3, 4, 0.6 );
    delaythread( 4, &function_3e93f92821c5df97 );
    flag_wait_either( "flag_weapon_fire_attempted", "flag_take_player_down" );
    thread function_ce38683af02da257();
    flag_set( "futile_defuse_black_out" );
    flag_wait( "hij_0700_explosion" );
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_694cefd45aed146b();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::bomb_explosion();
    playfxontag( level._effect[ "vfx_hij_cam_explode" ], level.player, "j_chest" );
    level.player allowfire( 0 );
    stopcinematicingame();
    wait 0.15;
    thread scripts\sp\hud_util::fade_out( 0.01, "white" );
    wait 2.5;
    thread scripts\sp\hud_util::fade_in( 1, "white" );
    thread scripts\sp\hud_util::fade_out( 0, "black" );
    wait 2;
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_deaf4e524dcd7776();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_b194d4eb3b43f417();
    nextmission();
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x41eb
// Size: 0x4bc
function function_cba15d748d5113d2()
{
    animnode = getstruct( "scene_hij_0700_enter_economy", "targetname" );
    var_ef9ede83b49f9102 = getstruct( "scene_hij_0700_enter_economy_blockers", "targetname" );
    level.player thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_lighting::function_ea9880e4a1f28d26( animnode );
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_b3f33897c12d0e04();
    thread function_39d3ce79ea83d1b2();
    civ_array = array_spawn_noteworthy( "blocker_array_0700", 1 );
    waitframe();
    
    if ( isdefined( var_ef9ede83b49f9102 ) )
    {
        var_ef9ede83b49f9102 thread scene::play( civ_array, "alert_to_block_01_init" );
    }
    
    waitframe();
    animnode thread scene::play( level.player, "economy_drag" );
    countdown_phone = animnode scene::get_entity( "countdown_phone" );
    flag_set( "flag_enter_economy_curtains" );
    flag_wait( "hij_0700_start_blockers" );
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_6bdd001c0eefe74b();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_ef66685f1a7d7f60();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_42e0ce8a59962f9c();
    animnode thread scene::play( undefined, "civ_reaction" );
    namespace_bde1a0e87b86090::function_733e573493a9ef16();
    level.var_47d42a0c7d19c938 = &namespace_bde1a0e87b86090::function_c6f77bd43877c9c6;
    
    if ( isdefined( civ_array ) )
    {
        foreach ( guy in civ_array )
        {
            if ( !isdefined( guy ) )
            {
                continue;
            }
            
            if ( guy.animname == "civ_blocker_01" )
            {
                var_eea0a1a9cbadb42d = "alert_to_block_01";
                block_loop = "block_loop_01";
                var_cb47add00ce86d4f = "block_to_alert_01";
            }
            else if ( guy.animname == "civ_blocker_02" )
            {
                var_eea0a1a9cbadb42d = "alert_to_block_02";
                block_loop = "block_loop_02";
                var_cb47add00ce86d4f = "block_to_alert_02";
            }
            else if ( guy.animname == "civ_blocker_03" )
            {
                var_eea0a1a9cbadb42d = "alert_to_block_03";
                block_loop = "block_loop_03";
                var_cb47add00ce86d4f = "block_to_alert_03";
            }
            else if ( guy.animname == "civ_blocker_04" )
            {
                var_eea0a1a9cbadb42d = "alert_to_block_04";
                block_loop = "block_loop_04";
                var_cb47add00ce86d4f = "block_to_alert_04";
            }
            else if ( guy.animname == "civ_blocker_05" )
            {
                var_eea0a1a9cbadb42d = "alert_to_block_05";
                block_loop = "block_loop_05";
                var_cb47add00ce86d4f = "block_to_alert_05";
            }
            
            shots = [ var_eea0a1a9cbadb42d, block_loop ];
            guy.animnode = spawnstruct();
            guy.animnode.script_scenescriptbundle = var_ef9ede83b49f9102.script_scenescriptbundle;
            guy.animnode.origin = var_ef9ede83b49f9102.origin;
            guy.animnode.angles = var_ef9ede83b49f9102.angles;
            guy.animnode thread scene::play( guy, shots );
            guy thread function_976065acc30cc33( guy.animnode, var_cb47add00ce86d4f );
            waitframe();
        }
    }
    
    flag_wait( "makarov_exit_player_drag_end" );
    animnode thread scene::play( undefined, "curtain_reset" );
    countdown_phone scripts\sp\player\cursor_hint::create_cursor_hint( undefined, ( 0, 0, 0 ), undefined, undefined, undefined, undefined, 1, 0, undefined, undefined, "duration_medium" );
    level.player thread function_5b97a4b7ffb4df0e();
    delaythread( 14, &flag_set, "flag_weapon_fire_attempted" );
    front_plane_org = getstruct( "front_plane_org", "targetname" );
    waitframe();
    
    while ( true )
    {
        if ( flag( "flag_take_player_down" ) )
        {
            function_ffa33723f2c718ab( "takedown_front" );
            break;
        }
        else if ( within_fov( level.player geteye(), level.player getplayerangles(), front_plane_org.origin, cos( 30 ) ) )
        {
            function_ffa33723f2c718ab( "takedown_r" );
            break;
        }
        else if ( flag( "flag_weapon_fire_attempted" ) && !within_fov( level.player geteye(), level.player getplayerangles(), front_plane_org.origin, cos( 70 ) ) )
        {
            wait 1;
            function_ffa33723f2c718ab( "takedown_r" );
            break;
        }
        else if ( flag( "flag_weapon_fire_attempted" ) && within_fov( level.player geteye(), level.player getplayerangles(), front_plane_org.origin, cos( 70 ) ) )
        {
            wait 1;
            function_ffa33723f2c718ab( "takedown_back" );
            break;
        }
        
        waitframe();
    }
    
    countdown_phone scripts\sp\player\cursor_hint::remove_cursor_hint();
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x46af
// Size: 0x37
function function_f316a2688edb4ef0()
{
    level.player earthquakeforplayer( 0.3, 0.25, level.player.origin, 850 );
    wait 0.4;
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x46ee
// Size: 0x3b
function function_fd8a43b28c5968ff()
{
    var_354ce7c8aea8db16 = getstructarray( "return_to_economy_takedown_animnodes", "targetname" );
    var_354ce7c8aea8db16 = sortbydistance( var_354ce7c8aea8db16, level.player.origin );
    return var_354ce7c8aea8db16[ 0 ];
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4732
// Size: 0x5e
function function_5b97a4b7ffb4df0e()
{
    level.player notifyonplayercommand( "fake_weapon_fire_attempted", "+attack" );
    level.player waittill( "fake_weapon_fire_attempted" );
    
    if ( level.player isgestureplaying( "jup_ges_hands_up" ) )
    {
        level.player thread function_4e77ad3c291b5056();
    }
    
    flag_set( "flag_weapon_fire_attempted" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 2
// Checksum 0x0, Offset: 0x4798
// Size: 0x183
function function_976065acc30cc33( animnode, var_cb47add00ce86d4f )
{
    self endon( "death" );
    ads_check = 0;
    var_43d480227da1cf91 = 0;
    flag_wait( "makarov_exit_player_drag_end" );
    flag_clear( "flag_take_player_down" );
    
    while ( !ads_check )
    {
        var_589c0eb9803a3415 = distance( self.origin, level.player.origin );
        waitframe();
        
        if ( level.player isads() && var_589c0eb9803a3415 < 115 )
        {
            ads_check = 1;
            thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::passengers_vo_react_to_gun_add();
            continue;
        }
        
        if ( var_589c0eb9803a3415 < 34 )
        {
            ads_check = 1;
            var_43d480227da1cf91 = 1;
            continue;
        }
        
        if ( flag( "flag_take_player_down" ) )
        {
            ads_check = 1;
            continue;
        }
        
        if ( flag( "flag_weapon_fire_attempted" ) )
        {
            ads_check = 1;
            thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::passengers_vo_react_to_gun_add();
        }
    }
    
    animnode scene::stop();
    animnode thread function_57ac36ea7abb5af4( undefined, self, var_cb47add00ce86d4f );
    level waittill( "civ_blocker_seated" );
    
    if ( var_43d480227da1cf91 )
    {
        flag_set( "flag_take_player_down" );
    }
    
    self visiblenotsolid();
    animnode waittill( "scene_complete" );
    animnode scene::stop();
    self.animname = "blocker";
    var_5d129d554df48180 = spawnstruct();
    var_5d129d554df48180.origin = self.origin;
    var_5d129d554df48180.angles = self.angles;
    waitframe();
    var_5d129d554df48180 thread anim_loop_solo( self, "jup_hij_panic_01_civ_01" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4923
// Size: 0x42
function function_39d3ce79ea83d1b2()
{
    flag_wait( "makarov_exit_player_in_economy" );
    
    while ( !flag( "flag_player_has_weapon_return_to_econ" ) )
    {
        waitframe();
    }
    
    setsaveddvar( @"player_view_pitch_up", 40 );
    setsaveddvar( @"player_view_pitch_down", 40 );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x496d
// Size: 0xd
function function_ce38683af02da257()
{
    setmusicstate( "mx_hijack_makarovreveal_end" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4982
// Size: 0x1b7
function function_8e58cd53e43d9ed5()
{
    level endon( "flag_futile_defuse_detonator_used" );
    level endon( "futile_defuse_black_out" );
    level endon( "futile_flip_lifeline" );
    civ2 = getstruct( "node_vo_civ2", "script_noteworthy" );
    civ3 = getstruct( "node_vo_civ3", "script_noteworthy" );
    civ4 = getstruct( "node_vo_civ4", "script_noteworthy" );
    civ5 = getstruct( "node_vo_civ5", "script_noteworthy" );
    flag_wait( "dialogue_civilian_panic" );
    playsoundatpos( civ2.origin, "dx_sp_hjck_para_rpc2_abomb" );
    wait 0.5;
    level.player say( "dx_sp_hjck_para_sama_helpmegivemethecellp", 1, 0, 1, 0, "global" );
    playsoundatpos( civ3.origin, "dx_sp_hjck_para_rpc3_shesgoingtokillusall" );
    wait 1.5;
    playsoundatpos( civ4.origin, "dx_sp_hjck_para_rpc4_wehavetodosomething" );
    wait 1;
    level.player thread say( "dx_sp_hjck_para_sama_wehavetodefusethebom", 1, 0, 1, 0, "global" );
    wait 1;
    playsoundatpos( civ5.origin, "dx_sp_hjck_para_rpc5_stopher" );
    wait 1;
    level.player thread say( "dx_sp_hjck_para_sama_pleaseweregoingtodie", 1, 0, 1, 0, "global" );
    wait 2;
    playsoundatpos( civ3.origin, "dx_sp_hjck_para_rpc3_shestryingtosetthebo" );
    wait 1.5;
    level.player thread say( "dx_sp_hjck_para_sama_youhavetohelpme", 1, 0, 1, 0, "global" );
    wait 1;
    playsoundatpos( civ2.origin, "dx_sp_hjck_para_rpc2_keepherawayfromtheph" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4b41
// Size: 0x92
function function_9529b1fd17e35803()
{
    civ4 = getstruct( "node_vo_civ4", "script_noteworthy" );
    flag_wait( "dialogue_civilians_takedown" );
    playsoundatpos( civ4.origin, "dx_sp_hjck_para_rpc4_grabherarms" );
    wait 0.5;
    level.player thread say( "dx_sp_hjck_defu_sama_noletmegoineedtogett", 1, 0, 1, 0, "global" );
    flag_wait( "dialogue_samara_respond_phone_civilian" );
    level.player say( "dx_sp_hjck_para_sama_hurrygiveittomegivem", 1, 0, 1, 0, "global" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4bdb
// Size: 0x5f
function function_eadeeb4cffc84813()
{
    level.player freezecontrols( 1 );
    flag_wait( "futile_show_lifeline" );
    level.player scripts\engine\sp\utility::blend_movespeedscale( 0.65, 0.5 );
    flag_wait( "flag_take_player_down" );
    level.player scripts\engine\sp\utility::blend_movespeedscale( 0.01, 0.1 );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4c42
// Size: 0x26
function function_6e6f9e6665d05f18()
{
    flag_clear( "flag_take_player_down" );
    flag_wait( "flag_pick_up_phone" );
    flag_set( "futile_flip_lifeline" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4c70
// Size: 0x33
function function_3e93f92821c5df97()
{
    pos = getstruct( "futile_defuse", "targetname" );
    
    if ( !function_8435dd9d3a6a867b( pos ) )
    {
        flag_set( "flag_take_player_down" );
    }
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 1
// Checksum 0x0, Offset: 0x4cab
// Size: 0xa8
function function_ffa33723f2c718ab( initial_shot )
{
    var_f0393cccfbd4e57f = function_fd8a43b28c5968ff();
    civil = getent( var_f0393cccfbd4e57f.script_linkto, "script_linkname" );
    waitframe();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_4437b50ae5c40f41();
    thread scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_audio::function_9358eb324ef5b753();
    thread function_f316a2688edb4ef0();
    var_f0393cccfbd4e57f scene::play( [ level.player, civil ], initial_shot, "scene_hij_0700_enter_economy" );
    
    if ( isdefined( civil ) )
    {
        civil.targetname = "takedown_civ_r";
    }
    
    var_f0393cccfbd4e57f thread scene::play( level.player, "takedown_struggle", "scene_hij_0700_enter_economy" );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4d5b
// Size: 0x2
function function_27762bc5ed1b4cb6()
{
    
}

/#

    // Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
    // Params 0
    // Checksum 0x0, Offset: 0x4d65
    // Size: 0x5, Type: dev
    function function_9874a515d7f7ca2c()
    {
        
    }

#/

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4d72
// Size: 0x1c
function function_882edf487ef95e2()
{
    set_start_location( "futile_defuse", [ level.player ] );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4d96
// Size: 0x44
function function_9de970ad2eb597a2()
{
    var_36109f139cb57b7c = getent( "first_class_curtain_entrance", "targetname" );
    var_36109f139cb57b7c hide();
    var_d7feeae39b9325e5 = getent( "first_class_curtain_entrance_open", "targetname" );
    var_d7feeae39b9325e5 show();
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4de2
// Size: 0xa5
function function_31f0c968d73391f3()
{
    if ( level.start_point != "back_to_economy_recording" )
    {
        return;
    }
    
    level.var_35dc8163678b4227 = 1;
    level.var_e2ca4e74bc1e1cb0 = 1;
    
    if ( !flag( "passenger_transition_to_alert" ) )
    {
        flag_set( "flag_hijackers_started" );
        flag_set( "passenger_transition_to_alert" );
    }
    
    flag_set( "flag_hijackers_started" );
    animnode = getstruct( "jup_hij_0250_gun_footage_third_player", "targetname" );
    assertex( isdefined( animnode ), "Anim node not defined." );
    function_9de970ad2eb597a2();
    
    while ( true )
    {
        animnode scene::play( undefined, "shot_010" );
    }
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4e8f
// Size: 0x2
function function_2aee6e5f91223f68()
{
    
}

/#

    // Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
    // Params 0
    // Checksum 0x0, Offset: 0x4e99
    // Size: 0x5, Type: dev
    function function_356f16cd5f6e45f7()
    {
        
    }

#/

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4ea6
// Size: 0x1c
function function_e00bd1c22a521607()
{
    set_start_location( "futile_defuse", [ level.player ] );
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4eca
// Size: 0x110
function function_d031fcfd2af95ef0()
{
    if ( level.start_point != "standoff_recording" )
    {
        return;
    }
    
    hidemayhem( "vfx_mayh_oxy_mask_02" );
    level.var_afdfbe3344861cfa = [ "shot_010", "shot_020" ];
    level.var_35dc8163678b4227 = 1;
    level.var_e2ca4e74bc1e1cb0 = 1;
    
    if ( !flag( "passenger_transition_to_alert" ) )
    {
        flag_set( "flag_hijackers_started" );
        flag_set( "passenger_transition_to_alert" );
    }
    
    animnode = getstruct( "jup_hij_0200_standoff_third_person", "targetname" );
    assertex( isdefined( animnode ), "Anim node not defined." );
    level.player enableinvulnerability();
    
    while ( true )
    {
        foreach ( shot in level.var_afdfbe3344861cfa )
        {
            animnode scene::play( undefined, shot );
            waitframe();
            waitframe();
            waitframe();
        }
    }
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x4fe2
// Size: 0x34
function function_d143cea35faf4b()
{
    player_col = getent( "flash_player_col", "targetname" );
    flag_wait( "pistol_whip_ground_hit" );
    
    if ( isdefined( player_col ) )
    {
        player_col delete();
    }
}

// Namespace sp_jup_hijack / scripts\sp\maps\sp_jup_hijack\sp_jup_hijack
// Params 0
// Checksum 0x0, Offset: 0x501e
// Size: 0x2
function function_64bf71eda7e2689()
{
    
}

