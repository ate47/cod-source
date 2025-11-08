#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\hud_util;
#using scripts\sp\utility;
#using scripts\sp\vision;

#namespace silo_lighting;

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x474
// Size: 0x31
function main()
{
    post_load_precache( &function_bf161307a213ad69 );
    level thread function_d639a200435fca78();
    flag_init( "silo_infil_end" );
    function_e11e77f687b7b626();
    function_14df7d7bc1eb3bd1();
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x4ad
// Size: 0x2
function function_bf161307a213ad69()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x4b7
// Size: 0x2
function function_861747b965da3832()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x4c1
// Size: 0x2
function function_7d2766b8a241577e()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x4cb
// Size: 0x2
function function_7dc8d6592d0d97d()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x4d5
// Size: 0x2
function function_c86d5fcf8e295015()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x4df
// Size: 0x2
function function_2b50d736d5245e23()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x4e9
// Size: 0x2
function function_e86a59c418dd8517()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x4f3
// Size: 0x2
function function_9650e3f7359ae899()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x4fd
// Size: 0x2
function function_a4e758a8c87d908()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x507
// Size: 0x2
function function_44f9515e001340aa()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x511
// Size: 0x2
function function_14143b21b303fb2f()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x51b
// Size: 0x2
function function_42f8cbedde1b65f9()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x525
// Size: 0x16
function function_d639a200435fca78()
{
    flag_wait( "player_spawned_with_loadout" );
    thread function_4a2c75fba97aedbf();
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x543
// Size: 0xb2
function function_4a2c75fba97aedbf()
{
    wait 0.05;
    level.var_adf2baf353988a4e = 0;
    interior_triggers = getentarray( "INTERIOR_TRIGGERS", "targetname" );
    
    foreach ( interior_trigger in interior_triggers )
    {
        interior_trigger thread function_429e69dcbcc4bf1d();
    }
    
    while ( true )
    {
        level waittill( "interior_trigger_count_updated" );
        waittillframeend();
        
        if ( level.var_adf2baf353988a4e > 0 )
        {
            visionsetnaked( "sp_jup_silo_interior", 1 );
            continue;
        }
        
        visionsetnaked( "sp_jup_silo", 1 );
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x5fd
// Size: 0x51
function function_429e69dcbcc4bf1d()
{
    while ( true )
    {
        self waittill( "trigger" );
        level.var_adf2baf353988a4e++;
        level notify( "interior_trigger_count_updated" );
        
        while ( level.player istouching( self ) )
        {
            wait 0.1;
        }
        
        level.var_adf2baf353988a4e--;
        level notify( "interior_trigger_count_updated" );
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x656
// Size: 0x262
function function_4dfe4cb7805442c3()
{
    level endon( "intro_skipped" );
    intro_lights = getentarray( "intro_light", "targetname" );
    
    if ( intro_lights.size <= 0 )
    {
        return;
    }
    
    hwconfiguratoraddasset( %"hw_sp_jup_silo_intro_igc_rt" );
    level.intro_lights = intro_lights;
    level.unique_lights[ "intro_sh010_09" ] function_f5600319797ffa1e( level.unique_lights[ "intro_sh010_09" ].og_intensity );
    wait 2.5;
    level.unique_lights[ "intro_sh010_02" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "intro_sh010_02" ].og_intensity, 0.4 );
    wait 0.9;
    level.unique_lights[ "intro_sh010_04" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "intro_sh010_04" ].og_intensity, 1.3 );
    level.unique_lights[ "intro_sh010_06" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "intro_sh010_06" ].og_intensity, 1.3 );
    wait 6.5;
    level.unique_lights[ "intro_sh010_03" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "intro_sh010_03" ].og_intensity, 0.45 );
    level.unique_lights[ "intro_sh010_08" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "intro_sh010_08" ].og_intensity, 0.45 );
    wait 0.9;
    level.unique_lights[ "intro_sh010_08" ] thread function_70a9f70afd49dead( level.unique_lights[ "intro_sh010_08" ].og_intensity, level.unique_lights[ "intro_sh010_08" ].og_intensity * 0.5, 0.3 );
    level.unique_lights[ "intro_sh010_09" ] thread function_70a9f70afd49dead( level.unique_lights[ "intro_sh010_09" ].og_intensity, level.unique_lights[ "intro_sh010_09" ].og_intensity * 0.25, 0.3 );
    wait 2.85;
    function_4b65276da49e2658();
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x8c0
// Size: 0x116
function function_4b65276da49e2658()
{
    if ( !isdefined( level.intro_lights ) )
    {
        return;
    }
    
    foreach ( light in level.intro_lights )
    {
        light setlightintensity( 0 );
    }
    
    level.unique_lights[ "intro_sh010_02" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "intro_sh010_04" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "intro_sh010_06" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "intro_sh010_03" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "intro_sh010_08" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "intro_sh010_09" ] function_f5600319797ffa1e( 0 );
    hwconfiguratorremoveasset( %"hw_sp_jup_silo_intro_igc_rt" );
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 1
// Checksum 0x0, Offset: 0x9de
// Size: 0xb7
function function_33c0ee1eec5fbf26( anime )
{
    hasxcam = 0;
    var_c29be8a72c384d19 = 0;
    
    if ( isdefined( level.scr_xcam ) && isdefined( level.scr_xcam[ anime ] ) )
    {
        hasxcam = 1;
    }
    
    if ( isdefined( level.scr_anim ) && isdefined( level.scr_anim[ "player_rig" ] ) && isdefined( level.scr_anim[ "player_rig" ][ anime ] ) )
    {
        var_c29be8a72c384d19 = 1;
    }
    
    if ( hasxcam )
    {
        return getxcamlength( level.scr_xcam[ anime ] );
    }
    else if ( var_c29be8a72c384d19 )
    {
        return getanimlength( level.scr_anim[ "player_rig" ][ anime ] );
    }
    
    return 0;
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0xa9e
// Size: 0x17
function function_e11e77f687b7b626()
{
    function_1d630e974680d15e();
    function_e82a9a528bf0259f();
    function_d94830ce5d2d2b7d();
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 1
// Checksum 0x0, Offset: 0xabd
// Size: 0xc6
function function_14df7d7bc1eb3bd1( noteworthy )
{
    blockers = getentarray( "outro_sun_blocker", "targetname" );
    
    if ( isdefined( noteworthy ) )
    {
        foreach ( blocker in blockers )
        {
            if ( blocker.script_noteworthy == noteworthy )
            {
                blocker hide();
            }
        }
        
        return;
    }
    
    foreach ( blocker in blockers )
    {
        blocker hide();
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 1
// Checksum 0x0, Offset: 0xb8b
// Size: 0xc6
function function_1cac4a15c9899224( noteworthy )
{
    blockers = getentarray( "outro_sun_blocker", "targetname" );
    
    if ( isdefined( noteworthy ) )
    {
        foreach ( blocker in blockers )
        {
            if ( blocker.script_noteworthy == noteworthy )
            {
                blocker show();
            }
        }
        
        return;
    }
    
    foreach ( blocker in blockers )
    {
        blocker show();
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0xc59
// Size: 0x26
function function_e82a9a528bf0259f()
{
    light_controls = getentitylessscriptablearray( "lower_base_alarm", "targetname" );
    level.var_229349f3910f8dc9 = light_controls;
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0xc87
// Size: 0x79
function function_14a0501f982ee582()
{
    if ( isdefined( level.var_229349f3910f8dc9 ) && level.var_229349f3910f8dc9.size >= 0 )
    {
        foreach ( alarm in level.var_229349f3910f8dc9 )
        {
            alarm setscriptablepartstate( "base", "on" );
        }
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0xd08
// Size: 0x12d
function function_1d630e974680d15e()
{
    cine_lights = getentarray( "cinematic_light", "targetname" );
    level.unique_lights = [];
    level.var_e841a10ca12d3ced = [];
    
    foreach ( light in cine_lights )
    {
        light.og_intensity = light getlightintensity();
        light setlightintensity( 0 );
        
        if ( isdefined( light.script_parameters ) && light.script_parameters != "" )
        {
            level.unique_lights[ light.script_parameters ] = light;
        }
        
        light.scene_shots = light function_2db8baa8be717dce();
        level.var_e841a10ca12d3ced[ level.var_e841a10ca12d3ced.size ] = light;
    }
    
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        function_318f3b408eb88511( level.var_e841a10ca12d3ced, "sh000" );
        function_862591b7b92c10c7();
        return;
    }
    
    function_97479c7df424d62a();
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0xe3d
// Size: 0x64
function function_862591b7b92c10c7()
{
    models = getentarray( "capture_only", "targetname" );
    
    foreach ( m in models )
    {
        m show();
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0xea9
// Size: 0x64
function function_97479c7df424d62a()
{
    models = getentarray( "capture_only", "targetname" );
    
    foreach ( m in models )
    {
        m hide();
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0xf15
// Size: 0x24
function function_2db8baa8be717dce()
{
    if ( !isdefined( self.script_noteworthy ) )
    {
        return [];
    }
    
    return strtok( self.script_noteworthy, " " );
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 2
// Checksum 0x0, Offset: 0xf42
// Size: 0x9b
function function_318f3b408eb88511( light_list, scene_shot )
{
    foreach ( light in light_list )
    {
        if ( array_contains( light.scene_shots, scene_shot ) )
        {
            if ( abs( light getlightintensity() - light.og_intensity ) > 1e-05 )
            {
                light setlightintensity( light.og_intensity );
            }
        }
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 2
// Checksum 0x0, Offset: 0xfe5
// Size: 0x7c
function function_4f68acac1881a018( light_list, scene_shot )
{
    ret_list = [];
    
    foreach ( light in light_list )
    {
        if ( array_contains( light.scene_shots, scene_shot ) )
        {
            ret_list[ ret_list.size ] = light;
        }
    }
    
    return ret_list;
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 2
// Checksum 0x0, Offset: 0x106a
// Size: 0x89
function function_d2f026db9170974b( light_list, scene_shot )
{
    foreach ( light in light_list )
    {
        if ( array_contains( light.scene_shots, scene_shot ) )
        {
            if ( abs( light getlightintensity() ) > 1e-05 )
            {
                light setlightintensity( 0 );
            }
        }
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 1
// Checksum 0x0, Offset: 0x10fb
// Size: 0x22
function function_f5600319797ffa1e( intensity )
{
    if ( isdefined( self ) && is_light() )
    {
        self setlightintensity( intensity );
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 3
// Checksum 0x0, Offset: 0x1125
// Size: 0x8f
function function_70a9f70afd49dead( from, to, time )
{
    if ( !isdefined( self ) || !is_light() )
    {
        return;
    }
    
    steps = int( time * 20 );
    curr = from;
    inc = ( to - curr ) / steps;
    
    for ( i = 0; i < steps ; i++ )
    {
        self setlightintensity( curr + i * inc );
        wait 0.05;
    }
    
    self setlightintensity( to );
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 1
// Checksum 0x0, Offset: 0x11bc
// Size: 0xe2
function function_f3275439c2ea3a58( anime )
{
    if ( anime != "outro_0" )
    {
        anim_length = function_33c0ee1eec5fbf26( anime ) + function_f5284a50ee13f9ec( anime );
    }
    
    switch ( anime )
    {
        case #"hash_cc3e91f4ea46800c":
            function_9b93bc25341e538c();
            wait anim_length;
            function_3b44e348d3d8e655();
            break;
        case #"hash_cc3e94f4ea4684c5":
            function_2efa32ccd31c5223();
            wait anim_length;
            function_5b76132c6404f4b6();
            break;
        case #"hash_cc3e93f4ea468332":
            function_444d3b1b90025626();
            wait anim_length;
            function_3a040b40543cb3e3();
            break;
        case #"hash_cc3e8ef4ea467b53":
            function_2c2a84bc4e82e94d();
            wait anim_length;
            function_54fcf0081bccd7d4();
            break;
        case #"hash_cc3e8df4ea4679c0":
            function_b3594f5ba3367a50();
            wait anim_length;
            function_54c51f229afceab1();
            break;
        default:
            break;
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 1
// Checksum 0x0, Offset: 0x12a6
// Size: 0x80
function function_f5284a50ee13f9ec( anime )
{
    switch ( anime )
    {
        case #"hash_cc3e91f4ea46800c":
            return 0.6;
        case #"hash_cc3e94f4ea4684c5":
            return -0.05;
        case #"hash_cc3e93f4ea468332":
            return 0;
        case #"hash_cc3e8ef4ea467b53":
            return 0;
        case #"hash_cc3e8df4ea4679c0":
            return -0.05;
        default:
            return -0.05;
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x132e
// Size: 0x2
function function_47b562360a0f5e59()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1338
// Size: 0x2
function function_ea01ab3490096148()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1342
// Size: 0x16
function function_9b93bc25341e538c()
{
    thread function_723acf6a37e0cc49();
    function_1cac4a15c9899224( "side" );
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1360
// Size: 0xfa
function function_723acf6a37e0cc49()
{
    level.unique_lights[ "sh010_intensity_01" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh010_intensity_01" ].og_intensity, 2 );
    level.unique_lights[ "sh010_intensity_02" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh010_intensity_02" ].og_intensity, 2 );
    level.unique_lights[ "sh010_intensity_03" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh010_intensity_03" ].og_intensity, 2 );
    level.unique_lights[ "sh010_intensity_04" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh010_intensity_04" ].og_intensity, 2 );
    wait 1.5;
    hwconfiguratoraddasset( %"hw_sp_jup_silo_outro_igc_rt" );
    function_37f31ed516b18c4c();
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1462
// Size: 0x2c
function function_3b44e348d3d8e655()
{
    function_d2f026db9170974b( level.var_e841a10ca12d3ced, "sh010" );
    function_318f3b408eb88511( level.var_e841a10ca12d3ced, "sh020" );
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1496
// Size: 0x2
function function_2efa32ccd31c5223()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x14a0
// Size: 0x34
function function_5b76132c6404f4b6()
{
    function_d2f026db9170974b( level.var_e841a10ca12d3ced, "sh020" );
    function_318f3b408eb88511( level.var_e841a10ca12d3ced, "sh030" );
    thread function_48279e8861f39927();
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x14dc
// Size: 0x80
function function_48279e8861f39927()
{
    level.unique_lights[ "sh030_lightswitch_01" ] function_f5600319797ffa1e( 0 );
    wait 3.8;
    level.unique_lights[ "sh030_lightswitch_01" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh030_lightswitch_01" ].og_intensity, 0.5 );
    visionsetnaked( "sp_jup_silo_IGC_outro", 1 );
    wait 1.9;
    visionsetnaked( "sp_jup_silo_IGC_outro_sh040", 1.8 );
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1564
// Size: 0xa
function function_444d3b1b90025626()
{
    thread function_a44a001c7d22fa78();
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1576
// Size: 0x38
function function_3a040b40543cb3e3()
{
    function_d2f026db9170974b( level.var_e841a10ca12d3ced, "sh030" );
    function_318f3b408eb88511( level.var_e841a10ca12d3ced, "sh040" );
    function_1cac4a15c9899224( "front" );
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x15b6
// Size: 0x2
function function_2c2a84bc4e82e94d()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x15c0
// Size: 0x64
function function_54fcf0081bccd7d4()
{
    function_d2f026db9170974b( level.var_e841a10ca12d3ced, "sh040" );
    function_318f3b408eb88511( level.var_e841a10ca12d3ced, "sh050" );
    visionsetnaked( "sp_jup_silo_IGC_outro_sh050", 0 );
    setsuncolorandintensity( 1, 0.94, 0.827, 23 );
    function_14df7d7bc1eb3bd1( "front" );
    thread function_7c2e8c3dbe095561();
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x162c
// Size: 0x4cb
function function_7c2e8c3dbe095561()
{
    level.unique_lights[ "sh050_lightswitch_01" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "sh050_lightswitch_001" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "sh050_lightswitch_04" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "sh050_lightswitch_06" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "sh050_lightswitch_07" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "sh050_lightswitch_08" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "sh050_lightswitch_09" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "sh050_lightswitch_10" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "sh050_lightswitch_11" ] function_f5600319797ffa1e( 0 );
    level.unique_lights[ "sh050_lightswitch_12" ] function_f5600319797ffa1e( 0 );
    wait 3.15;
    level.unique_lights[ "sh050_lightswitch_01" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh050_lightswitch_01" ].og_intensity, 1.75 );
    level.unique_lights[ "sh050_lightswitch_001" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh050_lightswitch_001" ].og_intensity, 1.75 );
    wait 1.95;
    level.unique_lights[ "sh050_lightswitch_02" ] thread function_70a9f70afd49dead( level.unique_lights[ "sh050_lightswitch_02" ].og_intensity, 0, 1.15 );
    level.unique_lights[ "sh050_lightswitch_03" ] thread function_70a9f70afd49dead( level.unique_lights[ "sh050_lightswitch_03" ].og_intensity, 0, 1.15 );
    level.unique_lights[ "sh050_lightswitch_04" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh050_lightswitch_04" ].og_intensity, 3 );
    wait 4.2;
    level.unique_lights[ "sh050_lightswitch_01" ] thread function_70a9f70afd49dead( level.unique_lights[ "sh050_lightswitch_01" ].og_intensity, 0, 1 );
    level.unique_lights[ "sh050_lightswitch_04" ] thread function_70a9f70afd49dead( level.unique_lights[ "sh050_lightswitch_04" ].og_intensity, 0, 1 );
    level.unique_lights[ "sh050_lightswitch_05" ] thread function_70a9f70afd49dead( level.unique_lights[ "sh050_lightswitch_05" ].og_intensity, 0, 1 );
    level.unique_lights[ "sh050_lightswitch_06" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh050_lightswitch_06" ].og_intensity, 0.9 );
    level.unique_lights[ "sh050_lightswitch_07" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh050_lightswitch_07" ].og_intensity, 0.9 );
    wait 3.05;
    level.unique_lights[ "sh050_lightswitch_06" ] thread function_70a9f70afd49dead( level.unique_lights[ "sh050_lightswitch_06" ].og_intensity, 0.5, 2 );
    level.unique_lights[ "sh050_lightswitch_10" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh050_lightswitch_10" ].og_intensity, 0.5 );
    wait 2.95;
    level.unique_lights[ "sh050_lightswitch_09" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh050_lightswitch_09" ].og_intensity, 1 );
    level.unique_lights[ "sh050_lightswitch_11" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh050_lightswitch_11" ].og_intensity, 1 );
    level.unique_lights[ "sh050_lightswitch_07" ] thread function_70a9f70afd49dead( level.unique_lights[ "sh050_lightswitch_07" ].og_intensity, 0, 0.5 );
    wait 0.8;
    level.unique_lights[ "sh050_lightswitch_08" ] thread function_70a9f70afd49dead( 0, level.unique_lights[ "sh050_lightswitch_08" ].og_intensity, 0.8 );
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1aff
// Size: 0x2
function function_b3594f5ba3367a50()
{
    
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1b09
// Size: 0x26
function function_54c51f229afceab1()
{
    function_d2f026db9170974b( level.var_e841a10ca12d3ced, "sh050" );
    hwconfiguratorremoveasset( %"hw_sp_jup_silo_outro_igc_rt" );
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1b37
// Size: 0xc8
function function_a44a001c7d22fa78()
{
    dyn_lights = getentarray( "sh030_flicker_off", "targetname" );
    
    if ( dyn_lights.size <= 0 )
    {
        return;
    }
    
    foreach ( light in dyn_lights )
    {
        light.og_intensity = light getlightintensity();
    }
    
    wait 3.1;
    
    foreach ( light in dyn_lights )
    {
        light thread function_bfa1bbeb78f7e022( int( 28 ) );
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 1
// Checksum 0x0, Offset: 0x1c07
// Size: 0x9c
function function_bfa1bbeb78f7e022( var_c69574dc8dd9a30a )
{
    for ( i = 0; i < var_c69574dc8dd9a30a ; i++ )
    {
        var_3e078ff594bc5499 = clamp( perlinnoise2d( 0, 1, 1, 4, 5, 255, int( gettime() * 0.01 ) % 255, 0 ), 0, 1 ) * self.og_intensity;
        self setlightintensity( var_3e078ff594bc5499 );
        time = randomfloatrange( 0.15, 0.4 );
        waitframe();
    }
    
    self setlightintensity( 0 );
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1cab
// Size: 0x48
function count_down_thread()
{
    self notify( "count_down_thread" );
    self endon( "count_down_thread" );
    t = 0;
    
    while ( true )
    {
        /#
            printtoscreen2d( 500, 500, t );
        #/
        
        t += 0.05;
        wait 0.05;
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1cfb
// Size: 0x81
function function_d94830ce5d2d2b7d()
{
    level.var_60a0588082ee87d0 = getentarray( "exit_hatch_silo_light", "targetname" );
    
    foreach ( light in level.var_60a0588082ee87d0 )
    {
        light.og_intensity = light getlightintensity();
        light setlightintensity( 0 );
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1d84
// Size: 0x7a
function function_e5d8995bd86eabe6()
{
    if ( isdefined( level.var_60a0588082ee87d0 ) && level.var_60a0588082ee87d0.size > 0 )
    {
        foreach ( light in level.var_60a0588082ee87d0 )
        {
            light setlightintensity( light.og_intensity );
        }
    }
}

// Namespace silo_lighting / scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting
// Params 0
// Checksum 0x0, Offset: 0x1e06
// Size: 0x74
function function_37f31ed516b18c4c()
{
    if ( isdefined( level.var_60a0588082ee87d0 ) && level.var_60a0588082ee87d0.size > 0 )
    {
        foreach ( light in level.var_60a0588082ee87d0 )
        {
            light setlightintensity( 0 );
        }
    }
}

