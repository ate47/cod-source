#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_e043e6db317d6d71;

// Namespace namespace_e043e6db317d6d71 / namespace_6bb2e038a2adbe49
// Params 0
// Checksum 0x0, Offset: 0x15a
// Size: 0x9
function main()
{
    function_959babe1a25e784e();
}

#using_animtree( "script_model" );

// Namespace namespace_e043e6db317d6d71 / namespace_6bb2e038a2adbe49
// Params 0
// Checksum 0x0, Offset: 0x16b
// Size: 0x9a
function function_959babe1a25e784e()
{
    level.scr_animtree[ "zone1_heavy_lab_device" ] = #animtree;
    level.scr_anim[ "zone1_heavy_lab_device" ][ "exploded" ] = %jup_fxanim_war_military_heavy_lab_device_damaged;
    level.scr_animname[ "zone1_heavy_lab_device" ][ "exploded" ] = "jup_fxanim_war_military_heavy_lab_device_damaged";
    level.scr_animtree[ "zone1_heavy_lab_device_line" ] = #animtree;
    level.scr_anim[ "zone1_heavy_lab_device_line" ][ "exploded" ] = %jup_fxanim_war_military_heavy_lab_device_line_damaged;
    level.scr_animname[ "zone1_heavy_lab_device_line" ][ "exploded" ] = "jup_fxanim_war_military_heavy_lab_device_line_damaged";
}

