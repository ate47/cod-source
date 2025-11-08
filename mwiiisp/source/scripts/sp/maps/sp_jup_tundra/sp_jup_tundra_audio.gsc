#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\vehicle_aianim;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;

#namespace sp_jup_tundra_audio;

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x964
// Size: 0xf
function main()
{
    level flag_init( "flg_audio_underwater_sfx_playing" );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x97b
// Size: 0x5c
function function_8fc9d6fd2773cfb3()
{
    level.player setsoundsubmix( "sp_jup_tundra_intro", 0 );
    level waittill( "audio_underwater_intro_mute_clear" );
    thread function_5b29597b2f23102e();
    thread function_669c5b581f579331();
    level.player playsound( "evt_jup_tun_intro_submerge_stringer_lr" );
    level.player clearsoundsubmix( "sp_jup_tundra_intro", 0.5 );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x9df
// Size: 0x16
function function_3cb460d33aaa813e()
{
    level.player setsoundsubmix( "sp_jup_tun_underwater_intro_mus" );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x9fd
// Size: 0x38
function function_5b29597b2f23102e()
{
    level.player setsoundsubmix( "sp_jup_tun_underwater_mix", 0 );
    level waittill( "uw_audio_cleanup" );
    level.player clearsoundsubmix( "sp_jup_tun_underwater_mix", 0.25 );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0xa3d
// Size: 0x50
function function_669c5b581f579331()
{
    wait 16;
    level.player playsound( "tun_underwater_scripted_ice_cracks_01_lr" );
    wait 10;
    level.player playsound( "tun_underwater_scripted_ice_cracks_02_lr" );
    wait 11.9;
    level.player playsound( "tun_underwater_scripted_ice_cracks_03_lr" );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0xa95
// Size: 0x5f
function function_5510625cf2daa2bb()
{
    thread intro_ice_cracks();
    wait 1.5;
    level.player playsound( "evt_tun_underwater_car_engines_approach" );
    level waittill( "audio_stop_underwater_vehicles" );
    level.player setsoundsubmix( "sp_jup_tundra_underwater_vehicle", 4 );
    wait 10;
    level.player clearsoundsubmix( "sp_jup_tundra_underwater_vehicle" );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0xafc
// Size: 0x1b
function intro_ice_cracks()
{
    play_sound_in_space( "tun_underwater_intro_ice_cracks", ( 81754, -625, 615 ) );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0xb1f
// Size: 0xa4
function function_a3f4f9c3f405b0c0()
{
    level.player setsoundsubmix( "sp_jup_tundra_underwater_explosion", 0.5 );
    thread play_sound_in_space( "exp_tun_underwater_explo_01", ( 81884, -1287, 615 ) );
    wait 0.6;
    thread play_sound_in_space( "exp_tun_underwater_explo_02", ( 81837, -970, 615 ) );
    wait 0.7;
    thread function_73d7681781ebb6e8();
    thread play_sound_in_space( "exp_tun_underwater_explo_03_body", ( 81754, -625, 615 ) );
    level notify( "audio_stop_underwater_vehicles" );
    wait 5;
    level.player clearsoundsubmix( "sp_jup_tundra_underwater_explosion", 2 );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0xbcb
// Size: 0x24
function function_73d7681781ebb6e8()
{
    wait 0.2;
    soundsettimescalefactorfromtable( "third_explosion" );
    wait 1;
    soundsettimescalefactorfromtable( "default" );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0xbf7
// Size: 0x42
function function_9aa1e57c196d4847()
{
    if ( level flag( "flg_audio_underwater_sfx_playing" ) )
    {
        return;
    }
    
    level flag_set( "flg_audio_underwater_sfx_playing" );
    thread function_957cf1aa5f6b9c5f();
    thread function_fbc315aaaaa7c6a0();
    thread function_c2f083751f8230d6();
    thread function_65c94ad1dece6d5e();
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0xc41
// Size: 0xbc
function function_957cf1aa5f6b9c5f()
{
    level endon( "uw_audio_cleanup" );
    wait randomfloatrange( 5, 10 );
    
    while ( true )
    {
        dist_x = randomfloatrange( -500, 500 );
        dist_y = randomfloatrange( -500, 500 );
        dist_z = randomfloatrange( 20, 500 );
        position = level.player.origin + ( dist_x, dist_y, dist_z );
        play_sound_in_space( "tun_underwater_amb_ice_cracks_lrg", position );
        wait randomfloatrange( 5, 10 );
        dist_x = undefined;
        dist_y = undefined;
        dist_z = undefined;
        position = undefined;
        waitframe();
    }
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0xd05
// Size: 0xbc
function function_fbc315aaaaa7c6a0()
{
    level endon( "uw_audio_cleanup" );
    wait randomfloatrange( 10, 15 );
    
    while ( true )
    {
        dist_x = randomfloatrange( -500, 500 );
        dist_y = randomfloatrange( -500, 500 );
        dist_z = randomfloatrange( 20, 500 );
        position = level.player.origin + ( dist_x, dist_y, dist_z );
        play_sound_in_space( "tun_underwater_amb_ice_cracks_sml", position );
        wait randomfloatrange( 5, 10 );
        dist_x = undefined;
        dist_y = undefined;
        dist_z = undefined;
        position = undefined;
        waitframe();
    }
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0xdc9
// Size: 0x166
function function_c2f083751f8230d6()
{
    level.player endon( "death" );
    level endon( "stop_underwater_breathing" );
    level endon( "uw_audio_cleanup" );
    var_877b978e63de2709 = getstruct( "scene_jup_tun_0112_scuba_car1_plyr_takedown", "targetname" );
    var_877b978e63de2709 scene::function_8207074e79f22926( level.player, "note_hold_breath", "player" );
    var_877b978e63de2709 scene::function_8207074e79f22926( level.player, "note_start_breath", "player" );
    var_8772a98e63d42ff1 = getstruct( "scene_jup_tun_0130_scuba_plyr_takedown", "targetname" );
    var_8772a98e63d42ff1 scene::function_8207074e79f22926( level.player, "note_hold_breath", "player" );
    var_8772a98e63d42ff1 scene::function_8207074e79f22926( level.player, "note_start_breath", "player" );
    var_8788a78e63ec5ebe = getstruct( "scene_jup_tun_0140_scuba_vip_rescue", "targetname" );
    var_8788a78e63ec5ebe scene::function_8207074e79f22926( level.player, "note_hold_breath", "Player 1" );
    thread underwater_breathing();
    thread function_b1daf17b4376c583();
    flag_wait( "flg_allies_veh_refs_created" );
    thread function_426b5f7495da6b49();
    
    while ( true )
    {
        level.player waittill( "note_hold_breath" );
        level notify( "stop_breathing" );
        level.player waittill( "note_start_breath" );
        thread underwater_breathing();
        thread function_b1daf17b4376c583();
        thread function_426b5f7495da6b49();
        wait 1;
    }
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0xf37
// Size: 0x7f
function underwater_breathing()
{
    level.player endon( "death" );
    level endon( "stop_breathing" );
    level endon( "uw_audio_cleanup" );
    
    while ( true )
    {
        level.player playsound( "plr_underwater_scuba_idle_inh", "inhale_done" );
        level.player waittill( "inhale_done" );
        level.player playsound( "plr_underwater_scuba_idle_exh", "exhale_done" );
        level.player waittill( "exhale_done" );
        wait 0.5;
    }
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0xfbe
// Size: 0x5b
function function_b1daf17b4376c583()
{
    level.player endon( "death" );
    level endon( "stop_breathing" );
    level endon( "uw_audio_cleanup" );
    wait randomfloatrange( 15, 20 );
    
    while ( true )
    {
        level.player playsound( "plr_underwater_scuba_oxygen" );
        wait randomfloatrange( 12, 26 );
    }
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x1021
// Size: 0x8f
function function_426b5f7495da6b49()
{
    level.player endon( "death" );
    level endon( "stop_breathing" );
    level endon( "uw_audio_cleanup" );
    allies = [ level.ally01, level.ally02 ];
    
    foreach ( ally in allies )
    {
        ally thread function_258b04c4146401d6();
    }
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x10b8
// Size: 0x53
function function_258b04c4146401d6()
{
    level.player endon( "death" );
    level endon( "stop_breathing" );
    level endon( "uw_audio_cleanup" );
    wait randomfloatrange( 16, 21 );
    
    while ( true )
    {
        self playsound( "npc_underwater_scuba_oxygen" );
        wait randomfloatrange( 12, 28 );
    }
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x1113
// Size: 0x135
function function_65c94ad1dece6d5e()
{
    var_8788a78e63ec5ebe = getstruct( "scene_jup_tun_0140_scuba_vip_rescue", "targetname" );
    var_8788a78e63ec5ebe thread scene::function_8207074e79f22926( level.player, "note_welder_bubbles_sfx_ally", "Player 1" );
    var_8788a78e63ec5ebe thread scene::function_8207074e79f22926( level.player, "note_metal_heat_sfx_ally", "Player 1" );
    var_8788a78e63ec5ebe thread scene::function_8207074e79f22926( level.player, "note_welder_bubbles_sfx_plr", "Player 1" );
    var_8788a78e63ec5ebe thread scene::function_8207074e79f22926( level.player, "note_metal_heat_sfx_plr", "Player 1" );
    level.player waittill( "note_welder_bubbles_sfx_ally" );
    thread play_sound_in_space( "emt_tun_underwater_welder_bubbles_ally_01", ( 81807, -482, 182 ) );
    level.player waittill( "note_metal_heat_sfx_ally" );
    thread play_sound_in_space( "emt_tun_underwater_welder_heat_stress_ally", ( 81807, -482, 182 ) );
    level.player waittill( "note_welder_bubbles_sfx_plr" );
    thread play_sound_in_space( "emt_tun_underwater_welder_bubbles_plr_01", ( 81779, -456, 154 ) );
    level.player waittill( "note_metal_heat_sfx_plr" );
    thread play_sound_in_space( "emt_tun_underwater_welder_heat_stress_plr", ( 81779, -456, 154 ) );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x1250
// Size: 0x7d
function function_26c637b4a0e68843()
{
    var_35ba032abdd6e2e8 = getstruct( "scene_jup_tun_0140_scuba_vip_rescue", "targetname" );
    var_35ba032abdd6e2e8 thread scene::function_8207074e79f22926( level.player, "note_sfx_fade_start", "Player 1" );
    level.player waittill( "note_sfx_fade_start" );
    level.player setsoundsubmix( "sp_jup_tundra_fade_to_black_all_except_music", 5 );
    level waittill( "audio_clear_vip_rescue_mute" );
    level.player clearsoundsubmix( "sp_jup_tundra_fade_to_black_all_except_music", 1 );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x12d5
// Size: 0xe6
function function_864a8e9188f7b036()
{
    var_7867f48e589b8b2f = getstruct( "scene_jup_tun_0200_igc_forest_reveal", "targetname" );
    var_7867f48e589b8b2f scene::function_8207074e79f22926( level.player, "note_amb_change_start", "price_igc" );
    var_7867f48e589b8b2f scene::function_8207074e79f22926( level.player, "note_amb_change_end", "price_igc" );
    price_igc = var_7867f48e589b8b2f scene::get_entity( "price_igc" );
    level.player playsound( "scn_jup_tun_0200_igc_forest_reveal_lr" );
    level.player waittill( "note_amb_change_start" );
    level.player setsoundsubmix( "tun_forest_reveal", 0, 1 );
    price_igc playloopsound( "amb_tun_clearing_igc_0200_lr" );
    level.player waittill( "note_amb_change_end" );
    price_igc stoploopsound( "amb_tun_clearing_igc_0200_lr" );
    level.player clearsoundsubmix( "tun_forest_reveal", 0.5 );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 1
// Checksum 0x0, Offset: 0x13c3
// Size: 0xf3
function function_df167234b8c47354( bird )
{
    level endon( "flg_audio_bird_done" );
    bird_audio = undefined;
    level.var_72d800ee048c7e49 = 0;
    play_delay = 0;
    
    while ( true )
    {
        if ( level.var_72d800ee048c7e49 )
        {
            play_delay = 0;
            wait randomfloatrange( 8, 15 );
        }
        else if ( !isdefined( bird_audio ) )
        {
            play_delay -= 0.05;
            
            if ( play_delay <= 0 )
            {
                dist_x = randomfloatrange( -2500, 2500 );
                dist_y = randomfloatrange( -2500, 2500 );
                dist_z = randomfloatrange( 0, 200 );
                position = bird + ( dist_x, dist_y, dist_z );
                bird_audio = play_sound_in_space( "amb_emt_ext_tun_forest_birds", position );
                dist_x = undefined;
                dist_y = undefined;
                dist_z = undefined;
                position = undefined;
                waitframe();
                play_delay = randomfloatrange( 4, 15 );
            }
        }
        
        waitframe();
    }
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x14be
// Size: 0x50
function function_af1d28b3257969a7()
{
    level endon( "flg_audio_bird_done" );
    
    while ( true )
    {
        level.player waittill_any( "weapon_fired", "grenade_fire" );
        level.var_72d800ee048c7e49 = 1;
        wait randomfloatrange( 10, 20 );
        level.var_72d800ee048c7e49 = 0;
    }
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x1516
// Size: 0xe1
function forest_birds()
{
    bird_array = [ ( 6458, -15241, 242 ), ( 5515, -13485, 229 ), ( 4507, -11710, 458 ), ( 3969, -10307, 606 ), ( 6086, -6670, 920 ), ( -321, -1546, 1068 ), ( -4632, -485, 1474 ) ];
    
    foreach ( bird in bird_array )
    {
        wait randomfloatrange( 1, 4 );
        thread function_df167234b8c47354( bird );
    }
    
    thread function_af1d28b3257969a7();
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x15ff
// Size: 0x38
function function_eaa7e0dde7061f58()
{
    level.player setsoundsubmix( "sp_jup_tun_vista_heli" );
    level waittill( "audio_clear_heli_attenuate" );
    wait 5;
    level.player clearsoundsubmix( "sp_jup_tun_vista_heli" );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x163f
// Size: 0x2d
function function_e93afe911221b883()
{
    wait 1;
    play_sound_in_space( "exp_tun_forest_vista_explo", ( -537, -210, 1189 ) );
    flag_set( "flg_audio_bird_done" );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x1674
// Size: 0x1c
function function_50c54ccefd9163de()
{
    level waittill( "audio_lumbermill_vehicle_started" );
    wait 0.4;
    self playsound( "veh_lumbermill_drive_in" );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x1698
// Size: 0x1c
function function_163cc1ee70056ff()
{
    level waittill( "audio_lumbermill_vehicle_started" );
    wait 0.1;
    self playsound( "veh_lumbermill_drive_in" );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x16bc
// Size: 0xe
function function_620ba573390478ce()
{
    self playsound( "veh_lumbermill_drive_in_back" );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x16d2
// Size: 0x8f
function function_7f440c78fa69709()
{
    a_pos = [ 0, 1, 2, 3 ];
    
    foreach ( pos in a_pos )
    {
        animpos = scripts\common\vehicle_aianim::anim_pos( self, pos );
        
        if ( isdefined( animpos ) )
        {
            animpos.vehicle_getoutsound = "veh_lumbermill_truck_door_open";
        }
    }
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x1769
// Size: 0x5d
function function_4e97b1a797add6f0()
{
    thread function_9b9d6ffab72245fa();
    level.player setsoundsubmix( "tun_cliff_snowdrift", 3 );
    level.player playsound( "evt_tun_snowdrift_cliff_lr" );
    level flag_wait( "flag_cliff_snowdrift_off" );
    level.player clearsoundsubmix( "tun_cliff_snowdrift", 10 );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x17ce
// Size: 0xe9
function function_9b9d6ffab72245fa()
{
    var_7b31cdde6dd7bf88 = spawn_script_origin( ( 740, 7080, -264 ) );
    var_7b31d0de6dd7c621 = spawn_script_origin( ( -22, 6094, 304 ) );
    var_7b31cdde6dd7bf88 scalevolume( 0, 0 );
    var_7b31cdde6dd7bf88 scalevolume( 1, 2.5 );
    var_7b31cdde6dd7bf88 playloopsound( "amb_tun_snowdrift_tree_wind_lp" );
    var_7b31d0de6dd7c621 scalevolume( 0, 0 );
    var_7b31d0de6dd7c621 scalevolume( 1, 4.5 );
    var_7b31d0de6dd7c621 playloopsound( "amb_tun_snowdrift_tree_wind_lp" );
    level flag_wait( "flag_cliff_snowdrift_off" );
    wait 2;
    var_7b31cdde6dd7bf88 scalevolume( 0, 2.5 );
    wait 2.5;
    var_7b31cdde6dd7bf88 stoploopsound( "amb_tun_snowdrift_tree_wind_lp" );
    var_7b31d0de6dd7c621 scalevolume( 0, 2.5 );
    wait 2.5;
    var_7b31d0de6dd7c621 stoploopsound( "amb_tun_snowdrift_tree_wind_lp" );
    wait 2.5;
    var_7b31cdde6dd7bf88 delete();
    var_7b31d0de6dd7c621 delete();
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x18bf
// Size: 0x16
function function_89261962aa444c35()
{
    level.player playsound( "evt_tun_snowdrift_shipyard_lr" );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x18dd
// Size: 0xb1
function function_733b42fe33959ee()
{
    self endon( "death" );
    engine_ent = utility::spawn_script_origin( self.origin );
    engine_ent linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self playloopsound( "veh_jup_tun_finale_jltv_engine_lp" );
    utility::waittill_any_ents( self, "vehicle_near_path_end", level, "flag_" + self.targetname + "_clear" );
    engine_ent playsound( "veh_jup_tun_veh9_mil_lnd_jltv_engine_shutoff" );
    self scalevolume( 0, 0.5 );
    wait 0.8;
    self stoploopsound( "veh_jup_tun_finale_jltv_engine_lp" );
    wait 5;
    engine_ent delete();
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x1996
// Size: 0x76
function function_a08690148d25a40e()
{
    var_3a465e75b646f5d4 = getstruct( "scene_jup_tun_1000_igc_outro", "targetname" );
    var_3a465e75b646f5d4 thread scene::function_8207074e79f22926( level, "audio_notify_sh060_heli", "heli" );
    level.nikolai_heli playloopsound( "evt_tun_1000_exfil_heli_idle" );
    level waittill( "audio_notify_sh060_heli" );
    level.nikolai_heli scalevolume( 0, 1 );
    wait 1;
    level.nikolai_heli stoploopsound( "evt_tun_1000_exfil_heli_idle" );
}

// Namespace sp_jup_tundra_audio / scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio
// Params 0
// Checksum 0x0, Offset: 0x1a14
// Size: 0x1b
function function_fe45177bf22323f9()
{
    level.player setsoundsubmix( "sp_jup_tun_level_fade_out", 0.5 );
}

