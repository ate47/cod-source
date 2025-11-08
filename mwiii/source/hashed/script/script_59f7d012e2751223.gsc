#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_b_ob_intel_cs_season2;

// Namespace mp_jup_st_b_ob_intel_cs_season2 / namespace_6b1e835cd72f1145
// Params 2
// Checksum 0x0, Offset: 0x171
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_b_ob_intel_cs_season2" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_b_ob_intel_cs_season2" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_b_ob_intel_cs_season2" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_b_ob_intel_cs_season2 / namespace_6b1e835cd72f1145
// Params 3
// Checksum 0x0, Offset: 0x1e6
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_b_ob_intel_cs_season2" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_b_ob_intel_cs_season2" );
}

// Namespace mp_jup_st_b_ob_intel_cs_season2 / namespace_6b1e835cd72f1145
// Params 3
// Checksum 0x0, Offset: 0x255
// Size: 0x129
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_intel_cs_season2";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    s.season = "2";
    fe [[ f ]]( s, us, cf, ( -8232, 37364, 1376 ), ( 0, 89.37, 0 ), "deadbolt_audio_intel", undefined, "intel_s2_deadbolt_audio_comfort" );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_intel_cs_season2";
    s.groupid = "deadbolt";
    s.name = "deadbolt_radio_intel";
    fe [[ f ]]( s, us, cf, ( 13812, 18157, 916 ), ( 0, 115.7, 0 ), "deadbolt_radio_intel", undefined, "intel_s2_deadbolt_radio_containment" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_b_ob_intel_cs_season2 / namespace_6b1e835cd72f1145
// Params 0
// Checksum 0x0, Offset: 0x386
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_b_ob_intel_cs_season2 / namespace_6b1e835cd72f1145
// Params 0
// Checksum 0x0, Offset: 0x390
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_b_ob_intel_cs_season2" );
}

