#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_g_ob_intel_cs_season1;

// Namespace mp_jup_st_g_ob_intel_cs_season1 / namespace_a215515661f7dd6
// Params 2
// Checksum 0x0, Offset: 0x140
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_g_ob_intel_cs_season1" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_g_ob_intel_cs_season1" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_g_ob_intel_cs_season1" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_g_ob_intel_cs_season1 / namespace_a215515661f7dd6
// Params 3
// Checksum 0x0, Offset: 0x1b5
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_g_ob_intel_cs_season1" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_g_ob_intel_cs_season1" );
}

// Namespace mp_jup_st_g_ob_intel_cs_season1 / namespace_a215515661f7dd6
// Params 3
// Checksum 0x0, Offset: 0x224
// Size: 0xc1
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_intel_cs_season1";
    s.groupid = "deadbolt";
    s.name = "deadbolt_audio_intel";
    s.season = "1";
    fe [[ f ]]( s, us, cf, ( -22925, -8075.5, 1944 ), ( 2.7, 89.3, 0 ), "deadbolt_audio_intel", undefined, "intel_s1_deadbolt_audio_scientificdifferences" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_g_ob_intel_cs_season1 / namespace_a215515661f7dd6
// Params 0
// Checksum 0x0, Offset: 0x2ed
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_g_ob_intel_cs_season1 / namespace_a215515661f7dd6
// Params 0
// Checksum 0x0, Offset: 0x2f7
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_g_ob_intel_cs_season1" );
}

