#using script_575fda2758b0a36e;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\sp\utility_code;
#using scripts\engine\utility;
#using scripts\sp\audio;
#using scripts\sp\utility;

#namespace audio;

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x66e
// Size: 0x136
function init_audio()
{
    level.player clearallsoundsubmixes( 0.05 );
    
    if ( isdefined( level.audio ) && isdefined( level.audio.initialized ) )
    {
        return;
    }
    
    init_audio_struct();
    level.audio.initialized = 1;
    setdvarifuninitialized( @"debug_audio", "0" );
    setdvarifuninitialized( @"debug_headroom", "-1" );
    setdvarifuninitialized( @"music_enable", "1" );
    setsaveddvar( @"hash_687f6fe472201df1", 1 );
    setsaveddvar( @"hash_4e5b353bf84974a9", 1 );
    setdvarifuninitialized( @"hash_f133094f3b5288b6", 1 );
    
    if ( getprojectname() == "JUP" )
    {
        setsaveddvar( @"hash_8136ae00f7d4f22f", 0 );
    }
    
    level.player function_54117659a8e5c5b4();
    init_timescale();
    thread level_fadein();
    
    /#
        level.player thread function_f9400d838bd381d8();
        level.player thread function_72df0f1d6f3d845d();
    #/
    
    post_load_precache( &function_f31c23bedada2c6b );
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x7ac
// Size: 0x5e
function rex_emitter_test()
{
    wait 2;
    uppressed = 0;
    
    while ( true )
    {
        if ( level.player buttonpressed( "DPAD_UP" ) )
        {
            radiusdamage( level.player.origin, 1500, 150, 10, undefined, "MOD_EXPLOSIVE" );
            wait 2;
        }
        
        wait 0.1;
    }
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x812
// Size: 0x1d
function init_audio_struct()
{
    if ( !isdefined( level.audio ) )
    {
        level.audio = spawnstruct();
    }
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x837
// Size: 0x2f
function is_deathsdoor_audio_enabled()
{
    if ( !isdefined( level.audio.deathsdoor_enabled ) )
    {
        return 1;
    }
    
    return level.audio.deathsdoor_enabled;
}

// Namespace audio / scripts\sp\audio
// Params 1
// Checksum 0x0, Offset: 0x86f
// Size: 0xc4
function restore_after_deathsdoor( fadetime )
{
    if ( is_deathsdoor_audio_enabled() || isdefined( level.audio.in_deathsdoor ) )
    {
        level.audio.in_deathsdoor = undefined;
        level.player clearpriorityclienttriggeraudiozone( "deathsdoor" );
        level.player scripts\sp\audio::function_a2b4e6088394bade();
        
        if ( isdefined( level.deathsdoor_sfx ) )
        {
            wait fadetime;
            
            if ( isdefined( level.deathsdoor_sfx ) )
            {
                level.deathsdoor_sfx playsound( "deaths_door_out", "sounddone" );
                level.deathsdoor_sfx waittill( "sounddone" );
            }
            
            if ( isdefined( level.deathsdoor_sfx ) )
            {
                level.deathsdoor_sfx delete();
            }
        }
    }
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x93b
// Size: 0xe6
function set_deathsdoor()
{
    level.audio.in_deathsdoor = 1;
    
    if ( is_deathsdoor_audio_enabled() )
    {
        if ( isdefined( level.deathsdooroverride ) )
        {
            level.player setpriorityclienttriggeraudiozonepartial( level.deathsdooroverride, "deathsdoor", "reverb" );
            level.player scripts\sp\audio::function_501be800abf11f33();
        }
        else
        {
            level.player setpriorityclienttriggeraudiozonepartial( "deathsdoor", "deathsdoor", "reverb" );
            level.player scripts\sp\audio::function_501be800abf11f33();
        }
        
        if ( !isdefined( level.deathsdoor_sfx ) )
        {
            level.deathsdoor_sfx = spawn( "script_origin", level.player.origin );
            wait 0.05;
        }
        
        thread playerbreathingpainsound();
        level.deathsdoor_sfx playsound( "deaths_door_in" );
    }
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0xa29
// Size: 0x5b
function playerbreathingpainsound()
{
    self endon( "death_or_disconnect" );
    self endon( "disableDeathsDoor" );
    self endon( "healed" );
    self endon( "last_stand_revived" );
    level endon( "game_ended" );
    
    if ( getprojectname() == "JUP" )
    {
        wait 0.5;
        
        while ( true )
        {
            level.player playlocalsound( "plr_breath_pain_ong_exh" );
            wait 1.7;
        }
    }
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0xa8c
// Size: 0x62
function stop_deaths_door_audio()
{
    if ( isdefined( level.deathsdoor_sfx ) )
    {
        level.deathsdoor_sfx scalevolume( 0, 2 );
        wait 2;
        
        if ( isdefined( level.deathsdoor_sfx ) )
        {
            level.deathsdoor_sfx stopsounds();
        }
        
        wait 0.05;
        
        if ( isdefined( level.deathsdoor_sfx ) )
        {
            level.deathsdoor_sfx delete();
        }
    }
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0xaf6
// Size: 0x50
function level_fadein()
{
    if ( !isdefined( level.audio.level_fade_time ) )
    {
        level.audio.level_fade_time = 1;
    }
    
    wait 0.05;
    levelsoundfade( 1, level.audio.level_fade_time );
}

// Namespace audio / scripts\sp\audio
// Params 1
// Checksum 0x0, Offset: 0xb4e
// Size: 0x27
function set_audio_level_fade_time( time )
{
    init_audio_struct();
    level.audio.level_fade_time = time;
}

// Namespace audio / scripts\sp\audio
// Params 7
// Checksum 0x0, Offset: 0xb7d
// Size: 0x18f
function audio_bink_transition_ambient( binktime, ambient_out, fadeout, ambient_in, fadein, musicstate, musicstatetime )
{
    if ( !isdefined( binktime ) )
    {
        assertmsg( "tried to fade audio for bink playback without specifying bink length" );
        return;
    }
    
    if ( !isdefined( fadeout ) )
    {
        fadeout = 2;
    }
    
    if ( !isdefined( fadein ) )
    {
        fadein = 2;
    }
    
    if ( !isdefined( musicstatetime ) )
    {
        musicstatetime = 2;
    }
    
    if ( isdefined( musicstate ) )
    {
        thread bink_transition_music( binktime, musicstate, musicstatetime );
    }
    
    almostfadein = fadein + 0.05;
    binkskipped = 1;
    
    if ( isdefined( ambient_out ) )
    {
        level.player setclienttriggeraudiozone( ambient_out );
    }
    
    while ( !iscinematicplaying() )
    {
        wait 0.05;
    }
    
    level.player setclienttriggeraudiozone( "fade_to_black_minus_music", fadeout );
    
    while ( 1 && iscinematicplaying() )
    {
        time = cinematicgettimeinmsec() / 1000;
        var_626cae83e1c9cb97 = binktime - time;
        
        if ( var_626cae83e1c9cb97 <= almostfadein )
        {
            binkskipped = 0;
            break;
        }
        
        wait 0.05;
    }
    
    if ( binkskipped == 0 )
    {
        if ( isdefined( ambient_in ) )
        {
            level.player setclienttriggeraudiozone( ambient_in, fadein );
            wait 2;
            level.player clearclienttriggeraudiozone( 2 );
        }
        else
        {
            level.player clearclienttriggeraudiozone( fadein );
        }
        
        level.player clearsoundsubmix( "jup_global_igc_skip" );
        return;
    }
    
    level.player clearclienttriggeraudiozone();
}

// Namespace audio / scripts\sp\audio
// Params 3
// Checksum 0x0, Offset: 0xd14
// Size: 0x9e
function bink_transition_music( binktime, musicstate, musicstatetime )
{
    binkskipped = 1;
    almostfadein = musicstatetime + 0.05;
    
    while ( !iscinematicplaying() )
    {
        wait 0.05;
    }
    
    while ( 1 && iscinematicplaying() )
    {
        time = cinematicgettimeinmsec() / 1000;
        var_626cae83e1c9cb97 = binktime - time;
        
        if ( var_626cae83e1c9cb97 <= almostfadein )
        {
            binkskipped = 0;
            break;
        }
        
        wait 0.05;
    }
    
    if ( binkskipped == 0 )
    {
        setmusicstate( musicstate );
    }
}

// Namespace audio / scripts\sp\audio
// Params 2
// Checksum 0x0, Offset: 0xdba
// Size: 0x57
function audio_bink_fadeout_ambient( ambient_out, fadeout )
{
    if ( !isdefined( fadeout ) )
    {
        fadeout = 2;
    }
    
    if ( isdefined( ambient_out ) )
    {
        level.player setclienttriggeraudiozone( ambient_out );
    }
    
    while ( !iscinematicplaying() )
    {
        wait 0.05;
    }
    
    level.player setclienttriggeraudiozone( "fade_to_black_minus_music", fadeout );
}

// Namespace audio / scripts\sp\audio
// Params 5
// Checksum 0x0, Offset: 0xe19
// Size: 0x134
function audio_bink_fadein_ambient( binktime, ambient_in, fadein, musicstate, musicstatetime )
{
    if ( !isdefined( binktime ) )
    {
        assertmsg( "tried to fade audio for bink playback without specifying bink length" );
        return;
    }
    
    if ( !isdefined( fadein ) )
    {
        fadein = 2;
    }
    
    almostfadein = fadein + 0.05;
    
    if ( !isdefined( musicstatetime ) )
    {
        musicstatetime = 2;
    }
    
    if ( isdefined( musicstate ) )
    {
        thread bink_transition_music( binktime, musicstate, musicstatetime );
    }
    
    binkskipped = 1;
    
    while ( !iscinematicplaying() )
    {
        wait 0.05;
    }
    
    while ( 1 && iscinematicplaying() )
    {
        time = cinematicgettimeinmsec() / 1000;
        var_626cae83e1c9cb97 = binktime - time;
        
        if ( var_626cae83e1c9cb97 <= almostfadein )
        {
            binkskipped = 0;
            break;
        }
        
        wait 0.05;
    }
    
    if ( binkskipped == 0 )
    {
        if ( isdefined( ambient_in ) )
        {
            level.player setclienttriggeraudiozone( ambient_in, fadein );
            wait 2;
            level.player clearclienttriggeraudiozone( 2 );
        }
        else
        {
            level.player clearclienttriggeraudiozone( fadein );
        }
        
        return;
    }
    
    level.player clearclienttriggeraudiozone();
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0xf55
// Size: 0x16e
function init_timescale()
{
    level.audio.timescale = spawnstruct();
    level.audio.timescale.current = "";
    set_timescale( "default" );
    soundsettimescalefactor( "music_lr", 0 );
    soundsettimescalefactor( "music_lsrs", 0 );
    soundsettimescalefactor( "musicnopause_lr", 0 );
    soundsettimescalefactor( "musicnopause_lsrs", 0 );
    soundsettimescalefactor( "mus_emitter_3d", 0 );
    soundsettimescalefactor( "menu_unres_2d", 0 );
    soundsettimescalefactor( "menu_1_2d_lim", 0 );
    soundsettimescalefactor( "menu_2_2d_lim", 0 );
    soundsettimescalefactor( "scn_fx_unres_2d", 0 );
    soundsettimescalefactor( "scn_lfe_unres_2d", 0 );
    soundsettimescalefactor( "scn_fx_res_3d", 0 );
    soundsettimescalefactor( "scn_fx_unres_3d", 0 );
    soundsettimescalefactor( "scn_lfe_unres_3d", 0 );
    soundsettimescalefactor( "scn_igc_unres_2d", 0 );
    soundsettimescalefactor( "scn_igc_lfe_unres_2d", 0 );
    soundsettimescalefactor( "scn_igc_unres_3d", 0 );
    soundsettimescalefactor( "scn_igc_lfe_unres_3d", 0 );
    soundsettimescalefactor( "scn_fx_special_unres_3d", 0 );
    soundsettimescalefactor( "scn_fx_special_unres_2d", 0 );
    soundsettimescalefactor( "scn_fx_special_unres_prop_3d", 0 );
    soundsettimescalefactor( "scn_fx_unres_3d_lim", 0 );
    soundsettimescalefactor( "scn_fx_unres_2d_lim", 0 );
    soundsettimescalefactor( "scn_fx_res_3d", 0 );
    soundsettimescalefactor( "scn_fx_res_2d", 0 );
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x10cb
// Size: 0x6e
function set_slowmo_dialogue_start()
{
    soundsettimescalefactor( "voice_air_3d", 0 );
    soundsettimescalefactor( "voice_special_2d", 0 );
    soundsettimescalefactor( "voice_narration_2d", 0 );
    soundsettimescalefactor( "voice_plr_2d", 0 );
    soundsettimescalefactor( "voice_radio_2d", 0 );
    soundsettimescalefactor( "voice_plr_efforts_2d", 0 );
    soundsettimescalefactor( "voice_plr_breath_2d", 0 );
    soundsettimescalefactor( "voice_animal_1_3d", 0 );
    soundsettimescalefactor( "voice_bchatter_1_3d", 0 );
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x1141
// Size: 0x92
function set_slowmo_dialogue_end()
{
    soundsettimescalefactor( "voice_air_3d", 1 );
    soundsettimescalefactor( "voice_special_2d", 1 );
    soundsettimescalefactor( "voice_narration_2d", 1 );
    soundsettimescalefactor( "voice_plr_2d", 1 );
    soundsettimescalefactor( "voice_radio_2d", 1 );
    soundsettimescalefactor( "voice_plr_efforts_2d", 1 );
    soundsettimescalefactor( "voice_plr_breath_2d", 1 );
    soundsettimescalefactor( "voice_animal_1_3d", 1 );
    soundsettimescalefactor( "voice_bchatter_1_3d", 1 );
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x11db
// Size: 0x1a2
function set_slowmo_sniper_breath_start()
{
    soundsettimescalefactor( "voice_air_3d", 0.05 );
    soundsettimescalefactor( "voice_special_2d", 0.05 );
    soundsettimescalefactor( "voice_narration_2d", 0.05 );
    soundsettimescalefactor( "voice_plr_2d", 0.05 );
    soundsettimescalefactor( "voice_radio_2d", 0.05 );
    soundsettimescalefactor( "voice_plr_efforts_2d", 0.05 );
    soundsettimescalefactor( "voice_plr_breath_2d", 0.05 );
    soundsettimescalefactor( "voice_animal_1_3d", 0.05 );
    soundsettimescalefactor( "voice_bchatter_1_3d", 0.05 );
    soundsettimescalefactor( "amb_bed_2d", 0.2 );
    soundsettimescalefactor( "shock_nofilter_2d", 0.05 );
    soundsettimescalefactor( "explo_main_3d", 0.05 );
    soundsettimescalefactor( "explo_close_3d", 0.05 );
    soundsettimescalefactor( "explo_body_3d", 0.05 );
    soundsettimescalefactor( "explo_body2_3d", 0.05 );
    soundsettimescalefactor( "explo_debris_3d", 0.05 );
    soundsettimescalefactor( "explo_atmo_3d", 0.05 );
    soundsettimescalefactor( "explo_atmo_alt_3d", 0.05 );
    soundsettimescalefactor( "explo_lfe_3d", 0.05 );
    soundsettimescalefactor( "explo_dist_3d", 0.05 );
    soundsettimescalefactor( "weap_plr_fire_1_2d", 0.05 );
    soundsettimescalefactor( "weap_plr_fire_2_2d", 0.05 );
    soundsettimescalefactor( "weap_plr_fire_3_2d", 0.05 );
    soundsettimescalefactor( "weap_plr_fire_4_2d", 0.05 );
    soundsettimescalefactor( "weap_plr_fire_overlap_2d", 0.05 );
    soundsettimescalefactor( "weap_plr_fire_lfe_2d", 0.05 );
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x1385
// Size: 0x119
function set_slowmo_sniper_breath_end()
{
    set_slowmo_dialogue_end();
    soundsettimescalefactor( "amb_bed_2d", 1 );
    soundsettimescalefactor( "shock_nofilter_2d", 1 );
    soundsettimescalefactor( "explo_main_3d", 1 );
    soundsettimescalefactor( "explo_close_3d", 1 );
    soundsettimescalefactor( "explo_body_3d", 1 );
    soundsettimescalefactor( "explo_body2_3d", 1 );
    soundsettimescalefactor( "explo_debris_3d", 1 );
    soundsettimescalefactor( "explo_atmo_3d", 1 );
    soundsettimescalefactor( "explo_atmo_alt_3d", 1 );
    soundsettimescalefactor( "explo_lfe_3d", 1 );
    soundsettimescalefactor( "explo_dist_3d", 1 );
    soundsettimescalefactor( "weap_plr_fire_1_2d", 1 );
    soundsettimescalefactor( "weap_plr_fire_2_2d", 1 );
    soundsettimescalefactor( "weap_plr_fire_3_2d", 1 );
    soundsettimescalefactor( "weap_plr_fire_4_2d", 1 );
    soundsettimescalefactor( "weap_plr_fire_overlap_2d", 1 );
    soundsettimescalefactor( "weap_plr_fire_lfe_2d", 1 );
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x14a6
// Size: 0xef
function function_f31c23bedada2c6b()
{
    if ( isdefined( level.audio.fnsubmix ) )
    {
        [[ level.audio.fnsubmix ]]();
        return;
    }
    
    index = namespace_d6cca25f4b0ab62::getlevelindex( level.script );
    
    if ( isdefined( index ) )
    {
        level.player setsoundsubmix( "sp_mix_npc_fs_down_global", 0.05 );
        
        if ( getprojectname() == "JUP" )
        {
            foreach ( player in level.players )
            {
                player setsoundsubmix( "jup_global_ingame", 0.05 );
                player setsoundsubmix( "jup_global_sp", 0.05 );
                player clearsoundsubmix( "jup_global_death", 10 );
            }
        }
    }
}

// Namespace audio / scripts\sp\audio
// Params 1
// Checksum 0x0, Offset: 0x159d
// Size: 0x27
function function_651db72b2f52cf76( func )
{
    init_audio_struct();
    level.audio.fnsubmix = func;
}

// Namespace audio / scripts\sp\audio
// Params 3
// Checksum 0x0, Offset: 0x15cc
// Size: 0xee
function audio_helmet_transition_helmet_on_visor_down_w_lma( var_3abcf05da9d2dfed, lma_speed, filter_setting )
{
    if ( !isdefined( var_3abcf05da9d2dfed ) )
    {
        var_3abcf05da9d2dfed = 2.5;
    }
    
    if ( !isdefined( lma_speed ) )
    {
        lma_speed = "normal";
    }
    
    if ( !isdefined( filter_setting ) )
    {
        filter_setting = "clear_all";
    }
    
    level.player playsound( "plr_helmet_on_visor_down_lr" );
    
    if ( var_3abcf05da9d2dfed != 0 )
    {
        wait var_3abcf05da9d2dfed;
        
        if ( lma_speed == "normal" )
        {
            level.player delaycall( 0.1, &playsound, "plr_helmet_short_boot_up_lr" );
        }
        else
        {
            level.player delaycall( 0.1, &playsound, "plr_helmet_boot_up_fast_lr" );
        }
        
        if ( filter_setting == "clear_all" )
        {
            level.player delaycall( 0.45, &clearclienttriggeraudiozone, 0.2 );
            return;
        }
        
        level.player delaycall( 0.45, &setclienttriggeraudiozone, filter_setting, 0.2 );
    }
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x16c2
// Size: 0x2
function audio_helmet_transition_helmet_on_visor_up_no_lma()
{
    
}

// Namespace audio / scripts\sp\audio
// Params 3
// Checksum 0x0, Offset: 0x16cc
// Size: 0xe4
function audio_helmet_transition_visor_down_w_lma( var_3abcf05da9d2dfed, lma_speed, filter_setting )
{
    if ( !isdefined( var_3abcf05da9d2dfed ) )
    {
        var_3abcf05da9d2dfed = 2.5;
    }
    
    if ( !isdefined( lma_speed ) )
    {
        lma_speed = "normal";
    }
    
    if ( !isdefined( filter_setting ) )
    {
        filter_setting = "clear_all";
    }
    
    level.player playsound( "plr_helmet_visor_pull_down_w_air_lr" );
    wait var_3abcf05da9d2dfed;
    
    if ( lma_speed == "normal" )
    {
        level.player delaycall( 0.1, &playsound, "plr_helmet_short_boot_up_lr" );
    }
    else
    {
        level.player delaycall( 0.1, &playsound, "plr_helmet_boot_up_fast_lr" );
    }
    
    if ( filter_setting == "clear_all" )
    {
        level.player delaycall( 0.45, &clearclienttriggeraudiozone, 0.2 );
        return;
    }
    
    level.player delaycall( 0.45, &setclienttriggeraudiozone, filter_setting, 0.2 );
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x17b8
// Size: 0x16
function audio_helmet_transition_visor_up()
{
    level.player playsound( "plr_helmet_visor_pull_up_w_air_lr" );
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x17d6
// Size: 0x3e
function audio_helmet_transition_helmet_off_release_scripted_filter()
{
    level.player playsound( "plr_helmet_off_lr" );
    level.player playsound( "plr_helmet_off_lyr_lr" );
    level.player clearclienttriggeraudiozone( 0.25 );
}

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x181c
// Size: 0x16
function audio_helmet_transition_helmet_off_no_filter_change()
{
    level.player playsound( "plr_helmet_off_lr" );
}

// Namespace audio / scripts\sp\audio
// Params 1
// Checksum 0x0, Offset: 0x183a
// Size: 0x73
function set_timescale( name )
{
    if ( level.audio.timescale.current == name )
    {
        return;
    }
    
    level.audio.timescale.current = name;
    
    /#
        msg = "<dev string:x1c>" + name;
        debug_println( msg, 2 );
    #/
    
    soundsettimescalefactorfromtable( name );
}

/#

    // Namespace audio / scripts\sp\audio
    // Params 2
    // Checksum 0x0, Offset: 0x18b5
    // Size: 0x39, Type: dev
    function debug_println( msg, dvar_num )
    {
        if ( !isdefined( dvar_num ) )
        {
            dvar_num = 1;
        }
        
        if ( debug_enabled() < 1 )
        {
            return;
        }
        
        println( "<dev string:x4b>" + msg );
    }

#/

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x18f6
// Size: 0x27
function debug_enabled()
{
    /#
        dvar = getdvarint( @"debug_audio" );
        
        if ( dvar > 0 )
        {
            return dvar;
        }
    #/
    
    return 0;
}

/#

    // Namespace audio / scripts\sp\audio
    // Params 0
    // Checksum 0x0, Offset: 0x1926
    // Size: 0x47, Type: dev
    function function_f9400d838bd381d8()
    {
        for ( ;; )
        {
            if ( getdvar( @"scr_setclothtype" ) != "<dev string:x52>" )
            {
                thread gui_setclothtype();
            }
            
            if ( getdvar( @"hash_46a5925d26c9f0fa" ) != "<dev string:x52>" )
            {
                thread function_c2b8b450a3cba9c0();
            }
            
            waitframe();
        }
    }

    // Namespace audio / scripts\sp\audio
    // Params 0
    // Checksum 0x0, Offset: 0x1975
    // Size: 0xd0, Type: dev
    function gui_setclothtype()
    {
        clothtype = getdvar( @"scr_setclothtype" );
        setdevdvar( @"scr_setclothtype", "<dev string:x52>" );
        player = level.player;
        
        if ( isdefined( clothtype ) && clothtype != "<dev string:x52>" )
        {
            if ( isdefined( player.clothtype ) && player.clothtype == clothtype )
            {
            }
            
            if ( !isdefined( player.clothtype ) )
            {
                player.clothtype = "<dev string:x52>";
            }
            
            if ( isdefined( player.clothtype ) && player.clothtype != clothtype )
            {
                player.clothtype = clothtype;
                player setclothtype( getxhash( clothtype ) );
            }
        }
    }

    // Namespace audio / scripts\sp\audio
    // Params 0
    // Checksum 0x0, Offset: 0x1a4d
    // Size: 0xd0, Type: dev
    function function_c2b8b450a3cba9c0()
    {
        geartype = getdvar( @"hash_46a5925d26c9f0fa" );
        setdevdvar( @"hash_46a5925d26c9f0fa", "<dev string:x52>" );
        player = level.player;
        
        if ( isdefined( geartype ) && geartype != "<dev string:x52>" )
        {
            if ( isdefined( player.geartype ) && player.geartype == geartype )
            {
            }
            
            if ( !isdefined( player.geartype ) )
            {
                player.geartype = "<dev string:x52>";
            }
            
            if ( isdefined( player.geartype ) && player.geartype != geartype )
            {
                player.geartype = geartype;
                player setgeartype( getxhash( geartype ) );
            }
        }
    }

    // Namespace audio / scripts\sp\audio
    // Params 0
    // Checksum 0x0, Offset: 0x1b25
    // Size: 0xcc, Type: dev
    function function_72df0f1d6f3d845d()
    {
        i = 0;
        
        for ( ;; )
        {
            if ( getdvarint( @"hash_f75720f29df3df7" ) != 0 && i == 0 )
            {
                level.player setsoundsubmix( "<dev string:x53>", 1, 1 );
                setglobalsoundcontext( "<dev string:x6e>", "<dev string:x79>" );
                level.player setclienttriggeraudiozone( "<dev string:x79>", 1 );
                i = 1;
            }
            else if ( getdvarint( @"hash_f75720f29df3df7" ) == 0 && i == 1 )
            {
                level.player clearsoundsubmix( "<dev string:x53>", 2.2 );
                setglobalsoundcontext( "<dev string:x6e>", "<dev string:x52>" );
                level.player clearclienttriggeraudiozone( 1 );
                i = 0;
            }
            
            waitframe();
        }
    }

#/

// Namespace audio / scripts\sp\audio
// Params 0
// Checksum 0x0, Offset: 0x1bf9
// Size: 0x2f
function function_54117659a8e5c5b4()
{
    self.var_dd452cc5c546120b = "deaths_door_sp";
    
    if ( isdefined( level.var_c3934394c0f5cb03 ) )
    {
        self.var_dd452cc5c546120b = level.var_c3934394c0f5cb03;
    }
}

// Namespace audio / scripts\sp\audio
// Params 2
// Checksum 0x0, Offset: 0x1c30
// Size: 0x82
function function_501be800abf11f33( fadetime, scale )
{
    str_submix = default_to( self.var_dd452cc5c546120b, "deaths_door_sp" );
    n_fadetime = default_to( fadetime, -1 );
    n_scale = default_to( scale, 1 );
    self setsoundsubmix( str_submix, n_fadetime, n_scale );
    level.player setentitysoundcontext( "deaths_door", "active", 0.1 );
}

// Namespace audio / scripts\sp\audio
// Params 1
// Checksum 0x0, Offset: 0x1cba
// Size: 0x74
function function_a2b4e6088394bade( fadetime )
{
    str_submix = default_to( self.var_dd452cc5c546120b, "deaths_door_sp" );
    n_fadetime = default_to( fadetime, undefined );
    
    if ( isdefined( n_fadetime ) )
    {
        self clearsoundsubmix( str_submix, n_fadetime );
    }
    else
    {
        self clearsoundsubmix( str_submix );
    }
    
    level.player setentitysoundcontext( "deaths_door", "", 0.1 );
}

