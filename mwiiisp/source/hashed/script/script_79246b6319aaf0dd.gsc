#using scripts\common\anim;
#using scripts\engine\utility;

#namespace namespace_aa51f46c4e9f6395;

// Namespace namespace_aa51f46c4e9f6395 / namespace_4e0727bc7cbcc307
// Params 0
// Checksum 0x0, Offset: 0x426
// Size: 0x1e
function main()
{
    anim_precache();
    player();
    humans();
    vehicle();
}

// Namespace namespace_aa51f46c4e9f6395 / namespace_4e0727bc7cbcc307
// Params 0
// Checksum 0x0, Offset: 0x44c
// Size: 0xd
function anim_precache()
{
    precachemodel( "veh9_mil_air_heli_palfa" );
}

#using_animtree( "player" );

// Namespace namespace_aa51f46c4e9f6395 / namespace_4e0727bc7cbcc307
// Params 0
// Checksum 0x0, Offset: 0x461
// Size: 0x4c
function player()
{
    var_7907568326d674ab = "player_rig";
    level.scr_animtree[ var_7907568326d674ab ] = #animtree;
    level.scr_model[ var_7907568326d674ab ] = "vm_c_jup_sp_hero_ghost_urban";
    level.scr_anim[ var_7907568326d674ab ][ "infil" ] = %jup_dam_infil_vm;
}

#using_animtree( "generic_human" );

// Namespace namespace_aa51f46c4e9f6395 / namespace_4e0727bc7cbcc307
// Params 0
// Checksum 0x0, Offset: 0x4b5
// Size: 0x253
function humans()
{
    thirdpersonplayer = "3rd_person_player";
    level.scr_animtree[ thirdpersonplayer ] = #animtree;
    level.scr_model[ thirdpersonplayer ] = "body_c_jup_sp_hero_ghost_urban";
    level.scr_anim[ thirdpersonplayer ][ "infil" ] = %jup_dam_infil_player;
    addnotetrack_notify( thirdpersonplayer, "lgt_sss_lerp", "lgt_sss_lerp", "infil" );
    executioner_0 = "executioner_0";
    level.scr_animtree[ executioner_0 ] = #animtree;
    level.scr_anim[ executioner_0 ][ "EXECUTION_ANIMATION" ] = %wnd_0120_awk_roundup_execute_enemy4_jup;
    executioner_1 = "executioner_1";
    level.scr_animtree[ executioner_1 ] = #animtree;
    level.scr_anim[ executioner_1 ][ "EXECUTION_ANIMATION" ] = %wnd_0120_awk_roundup_execute_enemy6_jup;
    executioner_2 = "executioner_2";
    level.scr_animtree[ executioner_2 ] = #animtree;
    level.scr_anim[ executioner_2 ][ "EXECUTION_ANIMATION" ] = %wnd_0120_awk_roundup_execute_enemy7_jup;
    execution_victim_0 = "execution_victim_0";
    level.scr_animtree[ execution_victim_0 ] = #animtree;
    level.scr_anim[ execution_victim_0 ][ "EXECUTION_ANIMATION" ] = %wnd_0120_awk_roundup_execute_victim1_jup;
    execution_victim_1 = "execution_victim_1";
    level.scr_animtree[ execution_victim_1 ] = #animtree;
    level.scr_anim[ execution_victim_1 ][ "EXECUTION_ANIMATION" ] = %wnd_0120_awk_roundup_execute_victim2_jup;
    execution_victim_2 = "execution_victim_2";
    level.scr_animtree[ execution_victim_2 ] = #animtree;
    level.scr_anim[ execution_victim_2 ][ "EXECUTION_ANIMATION" ] = %wnd_0120_awk_roundup_execute_victim5_jup;
    executioner_0 = "executioner_0";
    level.scr_animtree[ executioner_0 ] = #animtree;
    level.scr_anim[ executioner_0 ][ "EXECUTION_POST_IDLE_ANIMATION" ][ 0 ] = %wnd_0120_awk_roundup_execute_idle_enemy4_jup;
    executioner_1 = "executioner_1";
    level.scr_animtree[ executioner_1 ] = #animtree;
    level.scr_anim[ executioner_1 ][ "EXECUTION_POST_IDLE_ANIMATION" ][ 0 ] = %wnd_0120_awk_roundup_execute_idle_enemy6_jup;
    executioner_2 = "executioner_2";
    level.scr_animtree[ executioner_2 ] = #animtree;
    level.scr_anim[ executioner_2 ][ "EXECUTION_POST_IDLE_ANIMATION" ][ 0 ] = %wnd_0120_awk_roundup_execute_idle_enemy7_jup;
}

#using_animtree( "vehicles" );

// Namespace namespace_aa51f46c4e9f6395 / namespace_4e0727bc7cbcc307
// Params 0
// Checksum 0x0, Offset: 0x710
// Size: 0x88
function vehicle()
{
    level.scr_animtree[ "heli" ] = #animtree;
    level.scr_model[ "heli" ] = "veh9_mil_air_heli_palfa_doors_open_mtx_vehphys_mp";
    level.scr_anim[ "heli" ][ "exfil_enter" ] = %jup_dam_exfil_helicopter_enter_01;
    level.scr_anim[ "heli" ][ "exfil_loop" ][ 0 ] = %jup_dam_exfil_helicopter_loop_01;
    level.scr_anim[ "heli" ][ "exfil_exit" ] = %jup_dam_exfil_helicopter_exit_01;
}

// Namespace namespace_aa51f46c4e9f6395 / namespace_4e0727bc7cbcc307
// Params 0
// Checksum 0x0, Offset: 0x7a0
// Size: 0x2
function function_9d6a1fa3094d9e8()
{
    
}

