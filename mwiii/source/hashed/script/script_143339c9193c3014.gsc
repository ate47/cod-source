#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_c_ob_intel_cs_season1;

// Namespace mp_jup_st_c_ob_intel_cs_season1 / namespace_ca2191c2f05ae3e2
// Params 2
// Checksum 0x0, Offset: 0x138
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_c_ob_intel_cs_season1" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_c_ob_intel_cs_season1" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_c_ob_intel_cs_season1" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_c_ob_intel_cs_season1 / namespace_ca2191c2f05ae3e2
// Params 3
// Checksum 0x0, Offset: 0x1ad
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_c_ob_intel_cs_season1" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_c_ob_intel_cs_season1" );
}

// Namespace mp_jup_st_c_ob_intel_cs_season1 / namespace_ca2191c2f05ae3e2
// Params 3
// Checksum 0x0, Offset: 0x21c
// Size: 0xc1
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_intel_cs_season1";
    s.groupid = "terminus";
    s.name = "terminus_audio_intel";
    s.season = "1";
    fe [[ f ]]( s, us, cf, ( 42690, 32675, 1876 ), ( 0, 314.6, 0 ), "terminus_audio_intel", undefined, "intel_s1_terminus_audio_newobjectives" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_c_ob_intel_cs_season1 / namespace_ca2191c2f05ae3e2
// Params 0
// Checksum 0x0, Offset: 0x2e5
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_c_ob_intel_cs_season1 / namespace_ca2191c2f05ae3e2
// Params 0
// Checksum 0x0, Offset: 0x2ef
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_c_ob_intel_cs_season1" );
}

