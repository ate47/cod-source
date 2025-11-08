#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace namespace_50465ab3ea19449b;

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x28e
// Size: 0x12
function main()
{
    thread function_a579b2c6238d6f25();
    thread function_ed6400aa301bcc1e();
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x2a8
// Size: 0x88
function function_19aeb30ca3bf7a64()
{
    level endon( "intro_skipped" );
    level.var_f86dca03b4e10a79 = 1;
    level.player_rig dontcastshadows();
    setdvar( @"hash_5d66c2ef5a9612e0", 0 );
    setdvar( @"hash_eca4b727b01fd254", 5 );
    setdvar( @"hash_dacffbfd52c2fdc5", 8 );
    setdvar( @"hash_f9190cd77b0b2463", 4 );
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 3, 180 );
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x338
// Size: 0x62
function function_19aeb60ca3bf80fd()
{
    function_cfb1d78acf5a9243();
    setdvar( @"hash_8adcf05d62fe94fd", 0.6 );
    level.player setphysicaldepthoffield( 7, 10 );
    wait 0.5;
    level.player setphysicaldepthoffield( 7, 20 );
    wait 2.5;
    level.player setphysicaldepthoffield( 7, 80 );
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x3a2
// Size: 0x103
function function_19aeb50ca3bf7eca()
{
    level endon( "intro_skipped" );
    function_cfb1d68acf5a9010();
    thread function_61a998996cc98831();
    showcinematicletterboxing( 0, 0 );
    level.var_f86dca03b4e10a79 = 1;
    level.player_rig dontcastshadows();
    wait 0.5;
    setdvar( @"hash_5d66c2ef5a9612e0", 0 );
    setdvar( @"hash_eca4b727b01fd254", 5 );
    setdvar( @"hash_dacffbfd52c2fdc5", 8 );
    setdvar( @"hash_f9190cd77b0b2463", 4 );
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 6, 100 );
    setdvar( @"hash_8adcf05d62fe94fd", 0.2 );
    wait 5;
    level.player setphysicaldepthoffield( 4, 13 );
    wait 3;
    level.player disablephysicaldepthoffieldscripting();
    wait 0.5;
    hidecinematicletterboxing( 2, 0 );
    flag_wait( "flag_dungeon_intro_complete" );
    function_4334270d07a014f2();
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x4ad
// Size: 0xf9
function function_4334270d07a014f2()
{
    if ( flag( "intro_skipped" ) )
    {
        setdvar( @"hash_8adcf05d62fe94fd", 0.2 );
        level.player disablephysicaldepthoffieldscripting();
        hidecinematicletterboxing( 0.1, 0 );
    }
    
    thread lerp_spot_intensity( "infil_light_002", 1, 0 );
    thread lerp_spot_intensity( "infil_light_003", 1, 0 );
    thread lerp_spot_intensity( "infil_light_004", 0.1, 0 );
    thread lerp_spot_intensity( "infil_light_005", 1, 0 );
    thread lerp_spot_intensity( "infil_light_006", 1, 0 );
    setdvar( @"hash_5d66c2ef5a9612e0", 1 );
    setdvar( @"hash_dacffbfd52c2fdc5", 8 );
    setdvar( @"hash_eca4b727b01fd254", 8 );
    setdvar( @"hash_f9190cd77b0b2463", 0 );
    level.player_rig castshadows();
    wait 1;
    level.var_f86dca03b4e10a79 = undefined;
    thread function_9160006a3f10b2cd();
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x5ae
// Size: 0xe
function function_cfb1d88acf5a9476()
{
    visionsetnaked( "cp_jup_apt_drone", 0 );
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x5c4
// Size: 0xe
function function_cfb1d78acf5a9243()
{
    visionsetnaked( "cp_jup_apt_infil_roof", 0 );
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x5da
// Size: 0xe
function function_cfb1d68acf5a9010()
{
    visionsetnaked( "cp_jup_apt_infil", 0 );
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x5f0
// Size: 0xf
function function_9a9f041d4b97cf90()
{
    visionsetnaked( "", 5 );
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x607
// Size: 0xda
function function_a579b2c6238d6f25()
{
    flag_wait( "flag_lighting_exfil" );
    level.var_f86dca03b4e10a79 = 1;
    thread function_ac51b3e1ba4a5adf();
    thread function_61a998996cc98831();
    setdvar( @"hash_6e3f8cef6be16b33", 1 );
    setdvar( @"hash_1ea8544d78048529", 0 );
    setdvar( @"hash_5d66c2ef5a9612e0", 0 );
    setdvar( @"hash_79627282666c0f9a", 0 );
    setdvar( @"hash_cb82c01fec2d534b", 32 );
    setdvar( @"hash_6157be5fe5b7cd6e", 32 );
    setdvar( @"hash_dd8e902514d20451", 2 );
    setdvar( @"hash_ea4c44a08cd23d5d", 1.5 );
    level waittill( "lgt_release" );
    setdvar( @"hash_ea4c44a08cd23d5d", 3 );
    level waittill( "lgt_exfil_cut" );
    thread function_9160006a3f10b2cd();
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x6e9
// Size: 0x137
function function_ac51b3e1ba4a5adf()
{
    level waittill( "lgt_look_down" );
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 5, 30, 20, 50 );
    level waittill( "lgt_look_hook" );
    level.player setphysicaldepthoffield( 5, 10, 20, 50 );
    level waittill( "lgt_look_up" );
    level.player setphysicaldepthoffield( 2.5, 60, 20, 50 );
    level waittill( "lgt_look_up_up" );
    level.player setphysicaldepthoffield( 2.5, 500, 20, 50 );
    level waittill( "lgt_look_down_down" );
    level.player setphysicaldepthoffield( 5, 30, 20, 50 );
    level waittill( "lgt_hook_in" );
    level.player setphysicaldepthoffield( 5, 10, 20, 50 );
    level waittill( "lgt_watch" );
    level.player setphysicaldepthoffield( 1, 55, 20, 50 );
    level waittill( "lgt_release" );
    level.player thread utility::dof_disable_autofocus();
    wait 0.05;
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 2, 500, 20, 50 );
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x828
// Size: 0x16d
function function_ed6400aa301bcc1e()
{
    flag_wait( "lgt_capture_nolan_start" );
    thread function_d5c8419b0a014df8();
    thread function_61a998996cc98831();
    visionsetnaked( "cp_jup_apt_capture" );
    setdvar( @"hash_5d66c2ef5a9612e0", 0 );
    setdvar( @"hash_eca4b727b01fd254", 5 );
    setdvar( @"hash_dacffbfd52c2fdc5", 8 );
    setdvar( @"hash_f9190cd77b0b2463", 4 );
    wait 2;
    thread lerp_spot_intensity( "lgt_capture_nolan_key_01", 1, 2 );
    thread lerp_spot_intensity( "lgt_capture_nolan_rim_01", 1, 0.3 );
    thread lerp_spot_intensity( "lgt_capture_nolan_rim_02", 1, 0.3 );
    thread lerp_spot_intensity( "lgt_capture_nolan_fill_01", 1, 0.2 );
    flag_wait( "lgt_capture_nolan_end" );
    visionsetnaked( "" );
    level.player disablephysicaldepthoffieldscripting();
    setdvar( @"hash_5d66c2ef5a9612e0", 1 );
    setdvar( @"hash_dacffbfd52c2fdc5", 8 );
    setdvar( @"hash_eca4b727b01fd254", 8 );
    setdvar( @"hash_f9190cd77b0b2463", 0 );
    thread lerp_spot_intensity( "lgt_capture_nolan_key_01", 1, 0 );
    thread lerp_spot_intensity( "lgt_capture_nolan_rim_01", 1, 0 );
    thread lerp_spot_intensity( "lgt_capture_nolan_rim_02", 1, 0 );
    thread lerp_spot_intensity( "lgt_capture_nolan_fill_01", 1, 0 );
    thread function_9160006a3f10b2cd();
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x99d
// Size: 0x53
function function_d5c8419b0a014df8()
{
    wait 3;
    level.player thread utility::dof_disable_autofocus();
    level.player enablephysicaldepthoffieldscripting();
    level.player setphysicaldepthoffield( 5, 11 );
    flag_wait( "lgt_capture_nolan_end" );
    level.player disablephysicaldepthoffieldscripting();
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0x9f8
// Size: 0x2
function function_2e71e16db1ac390a()
{
    
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0xa02
// Size: 0x2
function function_23729f7cf505880a()
{
    
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0xa0c
// Size: 0x2
function function_23729e7cf50585d7()
{
    
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0xa16
// Size: 0x2
function function_f409ff83748d977c()
{
    
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0xa20
// Size: 0x2
function function_f40a0283748d9e15()
{
    
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0xa2a
// Size: 0x2
function function_21f1f6c11a565371()
{
    
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0xa34
// Size: 0x2
function function_5664929930aafdf3()
{
    
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0xa3e
// Size: 0x2
function cp_hostage()
{
    
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0xa48
// Size: 0x2
function function_c456e31e8791085c()
{
    
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0xa52
// Size: 0x2
function function_d30a3a4e9341a243()
{
    
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0xa5c
// Size: 0x2
function function_eee5bf44e4a36c41()
{
    
}

// Namespace namespace_50465ab3ea19449b / namespace_a637649c8cd4ff68
// Params 0
// Checksum 0x0, Offset: 0xa66
// Size: 0x2c
function function_42491645cecc764()
{
    probe = getent( "cargo_probe", "targetname" );
    probe linkto( level.cargo_container );
}

