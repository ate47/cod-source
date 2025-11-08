#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_tower_ob_s5_rift_mission_allies_cs;

// Namespace mp_jup_tower_ob_s5_rift_mission_allies_cs / namespace_8eecc4aca22be002
// Params 2
// Checksum 0x0, Offset: 0x197
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_tower_ob_s5_rift_mission_allies_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_tower_ob_s5_rift_mission_allies_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_tower_ob_s5_rift_mission_allies_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_tower_ob_s5_rift_mission_allies_cs / namespace_8eecc4aca22be002
// Params 3
// Checksum 0x0, Offset: 0x20c
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_tower_ob_s5_rift_mission_allies_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_tower_ob_s5_rift_mission_allies_cs" );
}

// Namespace mp_jup_tower_ob_s5_rift_mission_allies_cs / namespace_8eecc4aca22be002
// Params 3
// Checksum 0x0, Offset: 0x27b
// Size: 0x245
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_tower_ob_s5_rift_mission_allies_cs";
    fe [[ f ]]( s, us, cf, ( 5819.75, 16320, 1276 ), ( 0, 217, 0 ), "ally_spawn_ravenov" );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_s5_rift_mission_allies_cs";
    fe [[ f ]]( s, us, cf, ( 5867.5, 16319.5, 1276 ), ( 0, 229, 0 ), "intro_ava_anim_struct" );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_s5_rift_mission_allies_cs";
    fe [[ f ]]( s, us, cf, ( 5915.75, 16261.5, 1291 ), ( 0, 0, 0 ), "rav_ref_location" );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_s5_rift_mission_allies_cs";
    fe [[ f ]]( s, us, cf, ( 5856.75, 16385.5, 1275.78 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_s5_rift_mission_allies_cs";
    fe [[ f ]]( s, us, cf, ( 5880, 17763.2, 1119 ), ( 0, 218.43, 0 ), "cspf_0_auto17374696635866299299" );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_s5_rift_mission_allies_cs";
    fe [[ f ]]( s, us, cf, ( 5873.5, 16317.5, 1276 ), ( 0, 221, 0 ), "intro_rav_anim_struct" );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_s5_rift_mission_allies_cs";
    fe [[ f ]]( s, us, cf, ( 5976.5, 16398, 1352.5 ), ( 0, 0, 0 ), "intro_clamp_struct" );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_s5_rift_mission_allies_cs";
    fe [[ f ]]( s, us, cf, ( 5872.75, 16272.5, 1276 ), ( 0, 225.13, 0 ), undefined, undefined, "ally_spawn_ava" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_tower_ob_s5_rift_mission_allies_cs / namespace_8eecc4aca22be002
// Params 0
// Checksum 0x0, Offset: 0x4c8
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_tower_ob_s5_rift_mission_allies_cs / namespace_8eecc4aca22be002
// Params 0
// Checksum 0x0, Offset: 0x4d2
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_tower_ob_s5_rift_mission_allies_cs" );
}

