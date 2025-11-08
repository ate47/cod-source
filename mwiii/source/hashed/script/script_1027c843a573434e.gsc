#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_i_ob_intel_cs_season2;

// Namespace mp_jup_st_i_ob_intel_cs_season2 / namespace_d0bde5fe2cbebf04
// Params 2
// Checksum 0x0, Offset: 0x137
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_i_ob_intel_cs_season2" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_i_ob_intel_cs_season2" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_i_ob_intel_cs_season2" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_i_ob_intel_cs_season2 / namespace_d0bde5fe2cbebf04
// Params 3
// Checksum 0x0, Offset: 0x1ac
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_i_ob_intel_cs_season2" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_i_ob_intel_cs_season2" );
}

// Namespace mp_jup_st_i_ob_intel_cs_season2 / namespace_d0bde5fe2cbebf04
// Params 3
// Checksum 0x0, Offset: 0x21b
// Size: 0xc1
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_intel_cs_season2";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    s.season = "2";
    fe [[ f ]]( s, us, cf, ( 23119, -21631, 2934 ), ( 0, 16.9, 0 ), "deadbolt_audio_intel", undefined, "intel_s2_deadbolt_audio_matejustrank" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_i_ob_intel_cs_season2 / namespace_d0bde5fe2cbebf04
// Params 0
// Checksum 0x0, Offset: 0x2e4
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_i_ob_intel_cs_season2 / namespace_d0bde5fe2cbebf04
// Params 0
// Checksum 0x0, Offset: 0x2ee
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_i_ob_intel_cs_season2" );
}

