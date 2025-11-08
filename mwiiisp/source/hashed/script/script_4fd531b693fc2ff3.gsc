#using script_1031976741eb6674;
#using script_5d5405089d04628b;
#using script_f8531dcf975a7a7;
#using scripts\common\ai;
#using scripts\common\scene;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio;
#using scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_fx;
#using scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_lighting;
#using scripts\sp\player;
#using scripts\sp\starts;
#using scripts\sp\utility;

#namespace namespace_424a337b14b91d5f;

/#

    // Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
    // Params 0
    // Checksum 0x0, Offset: 0x74b
    // Size: 0x5, Type: dev
    function function_e7ed57084cfaf0c0()
    {
        
    }

#/

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x758
// Size: 0x4ef
function function_e0ea9506f0e9d2b9()
{
    level.player val::set( "weapons", "weapon_first_raise_anims", 0 );
    level.player function_8b7829a01e6b58aa( 1 );
    level.player setmovespeedscale( 0.6 );
    context_melee_enable( 0 );
    function_a771c1243643c108();
    setsaveddvar( @"hash_fa84e9dc55b9d406", 0 );
    setdvar( @"hash_42deeb1fb385c72", 0 );
    level.player setclientomnvar( "swim_breath_meter_hide", 1 );
    level.scuba_mask = utility::spawn_model( "parts_jup_headgear_m48_mod1_divemask_vm" );
    level.scuba_mask linktoplayerview( level.player, "tag_origin", ( 0, 0, 0 ) );
    level.player lerpfovscalefactor( 0, 0 );
    exploder( "vfx_detonator_charge_initial" );
    level thread function_b029452f88f894b4();
    level thread function_d1a6fec38d0ba01a();
    level thread function_1d4f626cce0229e8();
    level thread function_1f3d1d94f9d2a5a0( 1 );
    level.price = getent( "price", "targetname" );
    level.price setmodel( "body_c_jup_sp_hero_price_tundra_diver" );
    level.ally01 = spawn_targetname( "ally01", 1 );
    level.ally01.name = "Gaz";
    level.ally01 set_callsign( "Bravo 6-1" );
    level.ally01 setmodel( "body_c_jup_sp_hero_gaz_tundra_diver" );
    level.ally01 gun_remove();
    level.ally01 function_36d8c0ddc6500bb7( 1 );
    level.ally02 = spawn_targetname( "ally02", 1 );
    level.ally02.animname = "ally02";
    level.ally02.name = "Soap";
    level.ally02 set_callsign( "Bravo 7-1" );
    level.ally02 setmodel( "body_c_jup_sp_hero_soap_tundra_diver" );
    level.ally02 gun_remove();
    level.ally02 function_36d8c0ddc6500bb7( 1 );
    level thread function_25e8fba7f624dc1();
    level.laswell = spawn_tag_origin( ( 0, 0, 0 ) );
    level.laswell.team = level.player.team;
    level.laswell.name = "Laswell";
    level.suvs = getentarray( "suv_convoy", "targetname" );
    level.suvs[ 0 ] setmodel( "jup_veh9_overland_2016_crashed" );
    level.suvs[ 1 ] setmodel( "jup_veh9_overland_2016_tundra_underwater_02" );
    level.suvs[ 2 ] setmodel( "jup_veh9_overland_2016_tundra_underwater_02" );
    level.suvs[ 3 ] setmodel( "jup_veh9_overland_2016_tundra_underwater_03" );
    level.suvs[ 3 ].animname = "veh04";
    flag_set( "flg_allies_veh_refs_created" );
    getent( "veh1_window_00", "targetname" ) hide();
    getent( "veh1_window_01", "targetname" ) hide();
    getent( "veh1_window_02", "targetname" ) hide();
    level.var_aac9c8a9482e81b1 = getent( "veh1_window_03", "targetname" );
    level.var_aac9c8a9482e81b1 hide();
    level.suvs[ 0 ] hidepart( "TAG_WINDSHIELD_FRONT" );
    level.suvs[ 0 ] hidepart( "TAG_WINDSHIELD_FRONT_PRISTINE" );
    level.suvs[ 0 ] hidepart( "TAG_WINDSHIELD_FRONT_WEB" );
    getent( "veh1_window_00", "targetname" ) linkto( level.suvs[ 0 ], "tag_origin_animate", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    getent( "veh1_window_02", "targetname" ) linkto( level.suvs[ 0 ], "tag_origin_animate", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    level.var_aac9c8a9482e81b1 linkto( level.suvs[ 0 ], "tag_origin_animate", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    getent( "veh4_window_00", "targetname" ) hide();
    getent( "veh4_window_01", "targetname" ) hide();
    level.var_f903ac629abc4bc3 = [];
    battlechatter_off( "axis" );
    namespace_a35eea5f35ca76c1::function_5aec039aeda2631c();
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xc4f
// Size: 0x52
function private function_12d3704463b4be73()
{
    function_9125ca62e7e137dc();
    function_9ed0b674bd69eec8();
    level thread function_59c82d5a588507fd();
    level thread function_560a94ab6cf8eba6();
    level thread floating_ice_mayhem();
    level thread function_61c75b78e987d72d();
    level thread function_b70fbe0cfde26e57();
    flag_set( "end_scene_0110" );
    level thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio::function_5b29597b2f23102e();
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xca9
// Size: 0x2e
function private function_6e08196907a73a66()
{
    level thread function_befd36dbc348f28();
    level thread function_afdc639ee731bc9e();
    level thread function_fcf930eedc91f95();
    setsaveddvar( @"hash_fa84e9dc55b9d406", 1 );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0xcdf
// Size: 0x26
function function_9ed0b674bd69eec8()
{
    exploder( "vfx_debris_silt" );
    exploder( "vfx_debris_silt_main" );
    exploder( "vfx_player_screen_bubbles" );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0xd0d
// Size: 0x39
function function_9125ca62e7e137dc()
{
    knifeweapon = make_weapon( "jup_knife_diver_sp" );
    level.player give_weapon( knifeweapon );
    level.player switchtoweapon( knifeweapon );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0xd4e
// Size: 0x44
function function_b70fbe0cfde26e57()
{
    ice_surface_whole = getent( "ice_surface_whole", "targetname" );
    ice_surface_broken = getent( "ice_surface_broken", "targetname" );
    ice_surface_broken show();
    ice_surface_whole hide();
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0xd9a
// Size: 0x22
function function_2b41de2f0232c20a()
{
    waitframe();
    level.price = self;
    self setmodel( "body_c_jup_sp_hero_price_tundra_diver" );
    function_36d8c0ddc6500bb7( 1 );
}

/#

    // Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
    // Params 0
    // Checksum 0x0, Offset: 0xdc4
    // Size: 0x5, Type: dev
    function function_7b66d21f952e3d1()
    {
        
    }

#/

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0xdd1
// Size: 0x45
function function_7e3a2aa7302c9df0()
{
    set_start_location( "s_start_lake_detonate", [ level.player ] );
    precachemodel( "body_c_jup_sp_hero_price_tundra_diver" );
    thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio::function_8fc9d6fd2773cfb3();
    function_e0ea9506f0e9d2b9();
    level.scuba_mask hide();
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0xe1e
// Size: 0x3d
function function_521c270fd86a5290()
{
    function_490af68912c6c09d( "detonate" );
    function_e0ea9506f0e9d2b9();
    scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_lighting::function_b5c58f7313680759();
    level.scuba_mask show();
    level thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_lighting::function_351a30b5a2b23f92();
    level thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio::function_5b29597b2f23102e();
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0xe63
// Size: 0x52
function function_37cd27042f339151()
{
    function_490af68912c6c09d( "main" );
    function_e0ea9506f0e9d2b9();
    thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_lighting::function_cee2f8effa73eb79();
    level.scuba_mask show();
    level function_12d3704463b4be73();
    level.player thread utility::dof_enable_autofocus( 28, undefined, 6, 2 );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0xebd
// Size: 0x92
function function_11e6f441784d86d()
{
    function_490af68912c6c09d( "rescue" );
    function_e0ea9506f0e9d2b9();
    thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_lighting::function_cee2f8effa73eb79();
    level.scuba_mask show();
    time = 15;
    level thread function_eab7234ced8d0d21( time );
    level thread function_12d3704463b4be73();
    level thread function_6e08196907a73a66();
    level thread function_319c2f097ede51e0( "scene_jup_tun_0125_scuba_veh02_swim_to_veh04", level.ally01, "loop_exit" );
    exploder( "vfx_player_mask_condensation" );
    level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9( undefined, undefined, "flag_lake_stop_nags", "lake_player_progress" );
}

/#

    // Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
    // Params 0
    // Checksum 0x0, Offset: 0xf57
    // Size: 0x5, Type: dev
    function function_e85f218c774a46()
    {
        
    }

#/

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0xf64
// Size: 0x1e
function lake_intro()
{
    autosave_by_name();
    level thread function_14e3c58e1e9f14e0();
    flag_wait( "lake_intro_complete" );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0xf8a
// Size: 0x30
function lake_detonate()
{
    thread autosave_by_name();
    level thread function_46154feb76c8ab80();
    level thread namespace_f247b8d258f67b0b::function_97e97294517bbc58();
    thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio::function_9aa1e57c196d4847();
    flag_wait( "lake_detonate_complete" );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0xfc2
// Size: 0x43
function lake_main()
{
    autosave_by_name();
    level thread function_37b0acceeed68ff5();
    level thread namespace_f247b8d258f67b0b::function_3ccba704d29f93e4();
    level thread namespace_f247b8d258f67b0b::function_1a381685fafc883d();
    thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio::function_9aa1e57c196d4847();
    level thread function_eab7234ced8d0d21( 75 );
    flag_wait( "lake_main_complete" );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x100d
// Size: 0x49
function lake_rescue()
{
    autosave_by_name();
    level thread function_e8ab76e750e5bc81();
    thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio::function_9aa1e57c196d4847();
    flag_wait( "lake_rescue_complete" );
    level thread function_1f3d1d94f9d2a5a0( 0 );
    level.player lerpfovscalefactor( 1, 0 );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 1
// Checksum 0x0, Offset: 0x105e
// Size: 0xbe
function function_490af68912c6c09d( str_startpoint )
{
    v_pos = getstruct( "s_start_lake_detonate", "targetname" );
    
    switch ( str_startpoint )
    {
        case #"hash_2b03afb9f1da2591":
            v_pos = getstruct( "s_start_lake_detonate", "targetname" );
            break;
        case #"hash_faea0534e49cf368":
            v_pos = getstruct( "s_start_lake_detonate", "targetname" );
            break;
        case #"hash_ec086b911c1011ec":
            v_pos = getstruct( "s_start_lake_rescue", "targetname" );
            break;
        case #"hash_bf2698954a8a0491":
        default:
            break;
    }
    
    level.player teleport_player( v_pos );
}

/#

    // Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
    // Params 0
    // Checksum 0x0, Offset: 0x1124
    // Size: 0x5, Type: dev
    function function_91c4bc96d11b651b()
    {
        
    }

#/

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x1131
// Size: 0x2
function function_aa66ffde4d265926()
{
    
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x113b
// Size: 0x23
function function_dffe8a3baa2618c6()
{
    flag_set( "lake_intro_complete" );
    kill_exploder( "vfx_detonator_charge_initial" );
    level thread namespace_f247b8d258f67b0b::function_7ecaf0dfe8277c39();
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x1166
// Size: 0x27
function function_bfea90384462b323()
{
    flag_set( "lake_detonate_complete" );
    thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_lighting::function_cee2f8effa73eb79();
    setsaveddvar( @"hash_25fd1d18d38c336a", 24 );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x1195
// Size: 0x28
function function_746fe8fd9724cc8f()
{
    flag_set( "lake_struggle_complete" );
    thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_lighting::function_cee2f8effa73eb79();
    level thread function_1f3d1d94f9d2a5a0( 0 );
    level notify( "uw_audio_cleanup" );
}

/#

    // Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
    // Params 0
    // Checksum 0x0, Offset: 0x11c5
    // Size: 0x5, Type: dev
    function function_da774c6e934bccf3()
    {
        
    }

#/

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x11d2
// Size: 0x186
function function_14e3c58e1e9f14e0()
{
    function_7dcc5e04ab79399b( [ "sp_jup_tundra_lake_tr" ] );
    level.player setcinematicmotionoverride( "disabled" );
    level.player scripts\common\utility::letterbox_enable( 1, 0 );
    level.player scripts\sp\player::focusdisable();
    level.player val::set( "tundra_cinematic", "freezecontrols", 1 );
    level.player val::set( "tundra_cinematic", "show_weapon_hud", 0 );
    function_d632c8ec5db9c014( 1, 1 );
    setsaveddvar( @"sm_sunenable", 0 );
    delaythread( 4, &function_5704dc016a96a16c );
    function_17175f6af83bafea( [ "sp_jup_tundra_lake_tr" ] );
    setsaveddvar( @"sm_sunenable", 1 );
    level thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_lighting::function_15c17e3a7339336e();
    function_6ea5b8f6f2554f9f();
    flag_set( "lake_intro_complete" );
    level.player val::set( "tundra_cinematic", "freezecontrols", 0 );
    level.player val::set( "tundra_cinematic", "show_weapon_hud", 1 );
    level.player scripts\sp\player::focusenable();
    level thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio::function_5510625cf2daa2bb();
    level.player delaythread( 1.5, &scripts\common\utility::letterbox_enable, 0, 2 );
    level.player lerpfovscalefactor( 0, 0 );
    level.player clearcinematicmotionoverride();
    level thread scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_audio::function_9aa1e57c196d4847();
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x1360
// Size: 0x67
function function_46154feb76c8ab80()
{
    autosave_by_name( "tundra_lake_detonator_save" );
    flag_wait( "flg_allies_veh_refs_created" );
    level.ally01 function_36d8c0ddc6500bb7( 0 );
    level.ally02 function_36d8c0ddc6500bb7( 0 );
    function_b6da8bf3044d28d5();
    level.ally01 function_36d8c0ddc6500bb7( 1 );
    level.ally02 function_36d8c0ddc6500bb7( 1 );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x13cf
// Size: 0xbf
function function_37b0acceeed68ff5()
{
    hq_drilling_ice = getent( "hq_drilling_ice", "targetname" );
    hq_drilling_ice hide();
    setsaveddvar( @"hash_fa84e9dc55b9d406", 1 );
    setsaveddvar( @"hash_25fd1d18d38c336a", 24 );
    flag_wait( "flg_allies_veh_refs_created" );
    level thread function_414810ea2923ae67();
    level thread function_55072791234e5e42();
    level thread function_34533c1e8d674a0f();
    level thread function_13318308eb3fff19();
    level thread function_8bedb290ea62164d();
    level thread function_e118b366b72babfa();
    level thread namespace_8339f6377b6ba60e::function_b3e858ac93d180e9( undefined, undefined, "flag_lake_stop_nags", "lake_player_progress" );
    
    if ( is_after_start( "lake_detonate" ) )
    {
        level thread function_befd36dbc348f28();
    }
    
    flag_set( "lake_main_complete" );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x1496
// Size: 0x144
function function_e8ab76e750e5bc81()
{
    hq_drilling_ice = getent( "hq_drilling_ice", "targetname" );
    hq_drilling_ice hide();
    function_5a35d55449e984db();
    flag_wait( "tundra_countdown_end" );
    level namespace_8339f6377b6ba60e::function_aec5169b5cad5be3( "flag_lake_stop_nags" );
    flag_set( "lake_rescue_complete" );
    v_pos = undefined;
    var_d4fce79d6a338e31 = getstructarray( "s_start_forest_walk", "targetname" );
    
    foreach ( struct in var_d4fce79d6a338e31 )
    {
        if ( is_equal( struct.script_noteworthy, "player" ) )
        {
            v_pos = struct;
            break;
        }
    }
    
    level.player teleport_player( v_pos );
    level.player setmovespeedscale( 1 );
    setdvar( @"hash_42deeb1fb385c72", 1 );
    level.player setclientomnvar( "swim_breath_meter_hide", 0 );
    context_melee_enable( 1 );
    level thread function_cc3cee48bf16e8ed();
    level thread function_b6e2f5f1a276d090();
    level notify( "uw_audio_cleanup" );
}

/#

    // Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
    // Params 0
    // Checksum 0x0, Offset: 0x15e2
    // Size: 0x5, Type: dev
    function function_efa9d70a56ff6f41()
    {
        
    }

#/

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 1
// Checksum 0x0, Offset: 0x15ef
// Size: 0xfc
function function_1f3d1d94f9d2a5a0( var_4e4ea67a37055b04 )
{
    setsaveddvar( @"hash_c6d1dde462e39873", var_4e4ea67a37055b04 );
    setsaveddvar( @"hash_207a6e806d91000c", var_4e4ea67a37055b04 );
    setsaveddvar( @"hash_7e340ee42da1bc88", var_4e4ea67a37055b04 );
    setsaveddvar( @"hash_bddf964126d9ca85", var_4e4ea67a37055b04 );
    setsaveddvar( @"hash_8b6c0afa3a1f3c0d", var_4e4ea67a37055b04 );
    setsaveddvar( @"hash_f61df5804ef0a80f", var_4e4ea67a37055b04 );
    self notify( "notify_tundra_underwater_override_triggered" );
    self endon( "notify_tundra_underwater_override_triggered" );
    
    while ( !function_26ae1f5bfac952d2() )
    {
        waitframe();
    }
    
    var_4e4ea67a37055b04 = default_to( var_4e4ea67a37055b04, 1 );
    
    if ( var_4e4ea67a37055b04 )
    {
        level.player enableplayerbreathsystem( 0 );
        function_f9f2360629b81807( 1 );
        function_bf47d6807d7b8a72( 1 );
        level.player notify( "swim_breathing_disabled_begin" );
        return;
    }
    
    level.player enableplayerbreathsystem( 1 );
    function_f9f2360629b81807( 0 );
    function_bf47d6807d7b8a72( 0 );
    level.player notify( "swim_breathing_disabled_end" );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x16f3
// Size: 0x44, Type: bool
function function_26ae1f5bfac952d2()
{
    return isdefined( level.player ) && level.player isscriptable() && isdefined( level.swim ) && isdefined( level.player.swim );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 1
// Checksum 0x0, Offset: 0x1740
// Size: 0x35
function function_bf47d6807d7b8a72( var_4e4ea67a37055b04 )
{
    var_4e4ea67a37055b04 = default_to( var_4e4ea67a37055b04, 1 );
    
    if ( var_4e4ea67a37055b04 )
    {
        level.var_5dd2f422579238e3 = &function_e421a99dbf159d9d;
        return;
    }
    
    level.var_5dd2f422579238e3 = undefined;
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 1
// Checksum 0x0, Offset: 0x177d
// Size: 0x35
function function_f9f2360629b81807( var_4e4ea67a37055b04 )
{
    var_4e4ea67a37055b04 = default_to( var_4e4ea67a37055b04, 1 );
    
    if ( var_4e4ea67a37055b04 )
    {
        level.var_e08155a589fd83f5 = &function_a808c774f0a9b298;
        return;
    }
    
    level.var_e08155a589fd83f5 = undefined;
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x17ba
// Size: 0x22
function function_e421a99dbf159d9d()
{
    level.player scripts\common\swim_common::function_a4cc23314a609ed7();
    level.player scripts\common\swim_common::function_aae8f85a278e89();
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x17e4
// Size: 0x4, Type: bool
function function_a808c774f0a9b298()
{
    return true;
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 1
// Checksum 0x0, Offset: 0x17f1
// Size: 0xb5
function function_36d8c0ddc6500bb7( play_fx )
{
    if ( istrue( play_fx ) )
    {
        playfxontag( level._effect[ "vfx_water_diver_bubble_trail_2_main" ], self, "j_spinelower" );
        playfxontag( level._effect[ "vfx_water_diver_bubble_trail_3_main" ], self, "j_ankle_le" );
        playfxontag( level._effect[ "vfx_water_diver_bubble_trail_3_main" ], self, "j_ankle_ri" );
        return;
    }
    
    stopfxontag( level._effect[ "vfx_water_diver_bubble_trail_2_main" ], self, "j_spinelower" );
    stopfxontag( level._effect[ "vfx_water_diver_bubble_trail_3_main" ], self, "j_ankle_le" );
    stopfxontag( level._effect[ "vfx_water_diver_bubble_trail_3_main" ], self, "j_ankle_ri" );
}

/#

    // Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
    // Params 0
    // Checksum 0x0, Offset: 0x18ae
    // Size: 0x5, Type: dev
    function function_daec78409bd8bd84()
    {
        
    }

#/

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x18bb
// Size: 0x1c
function function_414810ea2923ae67()
{
    wait 5;
    level.player setstance( "prone" );
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x18df
// Size: 0xb9
function function_8bedb290ea62164d()
{
    struct1 = getstruct( "suv_convoy_dest_1", "targetname" );
    struct2 = getstruct( "suv_convoy_dest_2", "targetname" );
    struct3 = getstruct( "suv_convoy_dest_3", "targetname" );
    a_structs = [ struct1, struct2, struct3 ];
    
    foreach ( struct in a_structs )
    {
        struct thread function_c13bcc5432f004bb();
    }
}

// Namespace namespace_424a337b14b91d5f / namespace_4eea8ced69a1ec9f
// Params 0
// Checksum 0x0, Offset: 0x19a0
// Size: 0xe2
function function_c13bcc5432f004bb()
{
    level endon( "flg_prisoner_location_revealed" );
    var_5f119ae69179a499 = 0;
    var_974b6e6533f27bd = 2;
    
    while ( !flag( "lake_rescue_complete" ) )
    {
        b_proximity = 0;
        var_422cb2c401cd88c1 = 0;
        dist = distance2d( self.origin, level.player.origin );
        
        if ( dist < 128 )
        {
            b_proximity = 1;
        }
        
        var_422cb2c401cd88c1 = within_fov( level.player geteye(), level.player getplayerangles(), self.origin, 0.766044 );
        
        if ( b_proximity && var_422cb2c401cd88c1 )
        {
            var_5f119ae69179a499++;
            
            if ( var_5f119ae69179a499 >= var_974b6e6533f27bd )
            {
                level.player notify( "msg_underwater_vehicle_checked" );
                break;
            }
        }
        else
        {
            var_5f119ae69179a499 = 0;
        }
        
        wait 1;
    }
}

