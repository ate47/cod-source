#using scripts\common\utility;
#using scripts\cp\cp_audio;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace namespace_95af3005fd2ed66a;

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0x7bb
// Size: 0xfb
function main()
{
    while ( !isdefined( level.player ) )
    {
        waitframe();
    }
    
    level.player setsoundsubmix( "cp_jup_dam_default" );
    setglobalsoundcontext( "jup_map", "dam_mission" );
    flag_init( "flag_aud_stop_red_alert" );
    thread infil_start();
    location_list = [];
    location_list[ 0 ] = ( -24965, 46753, 2600 );
    location_list[ 1 ] = ( -19423, 49851, 2600 );
    var_4af21f8a50feeaf5 = [];
    var_4af21f8a50feeaf5[ 0 ] = ( -17004, 44290, 1100 );
    var_4af21f8a50feeaf5[ 1 ] = ( -27039, 38913, 1100 );
    var_4af21f8a50feeaf5[ 2 ] = ( -20686, 38518, 1100 );
    thread scripts\cp\cp_audio::function_ec9b3af8f8e2d59f( 2, "flag_aud_stop_red_alert", "jup_dam_alarm_red_alert", "cp_jup_dam_alarm_attenuate", location_list, "jup_dam_alarm_red_alert_wet", var_4af21f8a50feeaf5, "cp_jup_dam_red_alert" );
    thread scripts\cp\cp_audio::function_f1dd559fdd8216d1( 2, 5, 8, 2000, "dam", "flag_dungeon_outro_start" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0x8be
// Size: 0x5c
function infil_start()
{
    flag_wait( "flag_intro_start" );
    level.player setsoundsubmix( "cp_jup_dam_infil", 1 );
    level.player playsound( "dam_infil_waterfall_oneshot" );
    wait_for_flag_or_time_elapses( "intro_skipped", 13 );
    level.player clearsoundsubmix( "cp_jup_dam_infil", 7 );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 2
// Checksum 0x0, Offset: 0x922
// Size: 0x32
function function_7a77200a30e3cf3d( light, site )
{
    while ( !flag( site ) )
    {
        light playsound( "evt_cp_jup_dam_bomb_defuse_beacon_underwater" );
        wait 1.55;
    }
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 2
// Checksum 0x0, Offset: 0x95c
// Size: 0x32
function function_f70f9e22bd8bc6c5( light, site )
{
    while ( !flag( site ) )
    {
        light playsound( "evt_cp_jup_dam_bomb_defuse_beacon" );
        wait 1.55;
    }
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0x996
// Size: 0x1a
function function_f77f935c8021b2a8()
{
    playsoundatpos( ( -19896, 43293, -693 ), "evt_jup_dam_bomb_defuse_water" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0x9b8
// Size: 0x1a
function function_8b6ce0aefcf1e116()
{
    playsoundatpos( ( -23726, 42399, -370 ), "evt_jup_dam_bomb_defuse_catwalk" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0x9da
// Size: 0x1a
function function_aa298192682ee26e()
{
    playsoundatpos( ( -25262, 45543, 154 ), "evt_jup_dam_bomb_defuse_bunker" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0x9fc
// Size: 0x32
function function_5257909d38af100()
{
    var_b741c62cec5ceb3b = getent( "obj_bomb_truck", "script_noteworthy" );
    playsoundatpos( var_b741c62cec5ceb3b.origin, "evt_jup_dam_bomb_defuse_truck" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0xa36
// Size: 0x91
function function_ed5e75134533a928()
{
    level endon( "game_ended" );
    flag_wait( "flag_ally_attack_heli_spawned" );
    attackheli = level.attackheli;
    sound_ent = spawn( "script_origin", attackheli.origin );
    sound_ent linkto( attackheli, "tag_origin" );
    attackheli playsoundonmovingent( "veh_jup_dam_exfil_apache_arrive_01" );
    sound_ent playloopsound( "veh_jup_dam_exfil_apache_lp" );
    attackheli waittill( "death" );
    sound_ent stopsounds();
    sound_ent stoploopsound();
    sound_ent function_b4b04de87729a6f3( 0.1 );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0xacf
// Size: 0xc5
function function_22162fa427f12df8()
{
    setglobalsoundcontext( "jup_map_event", "exfil" );
    level.player clearsoundsubmix( "cp_jup_dam_reinforcements", 5 );
    waitframe();
    waitframe();
    level.player setsoundsubmix( "cp_jup_dam_exfil", 15 );
    level.player setsoundsubmix( "cp_jup_dam_exfil_loop_mix" );
    flag_set( "flag_aud_stop_red_alert" );
    
    if ( level.var_5843e823f7ef9a57 )
    {
        level.heli_model playsoundonmovingent( "veh_jup_dam_exfil_heli_fly_in_alt_main" );
        wait 20;
        level.heli_model playsoundonmovingent( "veh_jup_dam_exfil_heli_fly_in_wind" );
        return;
    }
    
    level.heli_model playsoundonmovingent( "veh_jup_dam_exfil_heli_fly_in_bridge_main" );
    wait 20;
    level.heli_model playsoundonmovingent( "veh_jup_dam_exfil_heli_fly_in_wind" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0xb9c
// Size: 0x65
function function_3868039f299dfe34()
{
    waitframe();
    waitframe();
    level.heli_model playsound( "veh_jup_dam_exfil_heli_fly_in_touchdown" );
    level.heli_model playloopsound( "veh_jup_dam_exfil_heli_hover_lp" );
    level.player clearsoundsubmix( "cp_jup_dam_exfil_loop_mix" );
    flag_wait( "flag_dungeon_outro_complete" );
    level.player setsoundsubmix( "cp_jup_exfil_end", 3.5 );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0xc09
// Size: 0x2b
function function_a043be3abda84ede()
{
    waitframe();
    level.player setsoundsubmix( "cp_jup_dam_exfil_loop_mix" );
    level.heli_model playsoundonmovingent( "veh_jup_dam_exfil_heli_fly_out_engine" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0xc3c
// Size: 0x4c
function function_429f431ae3f34273()
{
    var_39aa401a07247927 = getent( "obj_mcguffin_hack", "targetname" );
    var_9b979f85a0fae4cc = var_39aa401a07247927.origin + ( 0, 0, 10 );
    playsoundatpos( var_9b979f85a0fae4cc, "evt_cp_jup_dam_laptop_hack" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0xc90
// Size: 0x42
function function_b4f3705a288a88ad()
{
    wait 1.5;
    level.player setsoundsubmix( "cp_jup_dam_reinforcements", 3 );
    var_803b39902c4c6367 = ( -18305, 43671, -480 );
    playsoundatpos( var_803b39902c4c6367, "cp_jup_dam_scn_reinforcements_defend_01_cue" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0xcda
// Size: 0x2c
function function_4abd644739110f11()
{
    wait 2.5;
    var_b97f96a3af252ef0 = ( -21585, 44458, -253 );
    playsoundatpos( var_b97f96a3af252ef0, "cp_jup_dam_scn_reinforcements_defend_01" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0xd0e
// Size: 0x29
function function_4f58b385a20e2f6f()
{
    wait 8;
    var_b97f96a3af252ef0 = ( -21585, 44458, -253 );
    playsoundatpos( var_b97f96a3af252ef0, "cp_jup_dam_scn_reinforcements_defend_01_doors" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0xd3f
// Size: 0x29
function function_5b6d9a058e3b36a0()
{
    wait 2;
    var_b093e82e60f6d976 = ( -25651, 39368, -19 );
    playsoundatpos( var_b093e82e60f6d976, "cp_jup_dam_scn_reinforcements_defend_02_cue" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0xd70
// Size: 0x77
function function_4abd614739110878()
{
    wait 19;
    var_eaa4190325300bc6 = ( -25023, 41352, -120 );
    playsoundatpos( var_eaa4190325300bc6, "cp_jup_dam_scn_reinforcements_defend_02_a" );
    wait 5;
    var_78edf189c83eb5db = ( -26245, 42261, 56 );
    playsoundatpos( var_78edf189c83eb5db, "cp_jup_dam_scn_reinforcements_defend_02_b" );
    wait 1;
    var_fed7808219f13b88 = ( -25719, 43980, 134 );
    playsoundatpos( var_fed7808219f13b88, "cp_jup_dam_scn_reinforcements_defend_02_c" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 0
// Checksum 0x0, Offset: 0xdef
// Size: 0x50
function function_1c7ff14e606cde4e()
{
    wait 24;
    var_eaa4190325300bc6 = ( -25023, 41352, -120 );
    playsoundatpos( var_eaa4190325300bc6, "cp_jup_dam_scn_reinforcements_defend_02_a_doors" );
    wait 6;
    var_fed7808219f13b88 = ( -25719, 43980, 134 );
    playsoundatpos( var_fed7808219f13b88, "cp_jup_dam_scn_reinforcements_defend_02_c_doors" );
}

// Namespace namespace_95af3005fd2ed66a / namespace_cf0990776c0e3528
// Params 2
// Checksum 0x0, Offset: 0xe47
// Size: 0xb8
function function_bfe011965db768b6( heli, vehspawner )
{
    level.player setsoundsubmix( "jup_cp_dam_reinforcement_helicopter_scene_mix" );
    
    if ( vehspawner == "truck_reinf_heli" )
    {
        heli playsoundonmovingent( "veh_jup_dam_reinforcement_heli_fly_in_1_truck" );
    }
    else if ( vehspawner == "bridge_left_reinf_heli" )
    {
        heli playsoundonmovingent( "veh_jup_dam_reinforcement_heli_fly_in_2_bridge_left" );
    }
    else if ( vehspawner == "bridge_right_reinf_heli" )
    {
        heli playsoundonmovingent( "veh_jup_dam_reinforcement_heli_fly_in_3_bridge_right" );
    }
    else if ( vehspawner == "catwalk_reinf_heli" )
    {
        heli playsoundonmovingent( "veh_jup_dam_reinforcement_heli_fly_in_4_catwalk" );
    }
    else if ( vehspawner == "bunker_reinf_heli" )
    {
        heli playsoundonmovingent( "veh_jup_dam_reinforcement_heli_fly_in_5_bunker" );
    }
    
    wait 55;
    level.player clearsoundsubmix( "jup_cp_dam_reinforcement_helicopter_scene_mix" );
}

