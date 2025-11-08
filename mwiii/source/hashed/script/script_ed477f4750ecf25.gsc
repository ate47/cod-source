#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_e_ob_intel_cs;

// Namespace mp_jup_st_e_ob_intel_cs / namespace_4a9cd794b84f1429
// Params 2
// Checksum 0x0, Offset: 0x26c
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_e_ob_intel_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_e_ob_intel_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_e_ob_intel_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_e_ob_intel_cs / namespace_4a9cd794b84f1429
// Params 3
// Checksum 0x0, Offset: 0x2e1
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_e_ob_intel_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_e_ob_intel_cs" );
}

// Namespace mp_jup_st_e_ob_intel_cs / namespace_4a9cd794b84f1429
// Params 3
// Checksum 0x0, Offset: 0x350
// Size: 0x2f6
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_warehouse_ind_02";
    fe [[ f ]]( s, us, cf, ( -8151.5, 7864.25, 1103 ), ( 0, 344.21, 0 ), "terminus_audio_intel_warlord" );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_office_lg_02";
    fe [[ f ]]( s, us, cf, ( -13849.3, 11792, 1449 ), ( 0, 209.65, 0 ), "terminus_audio_intel_warlord" );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_office_md_02";
    fe [[ f ]]( s, us, cf, ( -17546.6, 4379.88, 1447.81 ), ( 0, 182.63, 0 ), "terminus_audio_intel_warlord" );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_low_town_18";
    fe [[ f ]]( s, us, cf, ( 20277.9, -1939.11, 2188.82 ), ( 0, 257.63, 0 ), "terminus_audio_intel_warlord" );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_low_town_15_b";
    fe [[ f ]]( s, us, cf, ( 20612.8, 988, 2226.5 ), ( 0, 118.31, 0 ), "terminus_audio_intel_warlord" );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_low_town_10";
    fe [[ f ]]( s, us, cf, ( 21735.2, -4873.75, 2423.22 ), ( 0, 359.43, 0 ), "terminus_audio_intel_warlord" );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_e_low_town_19";
    fe [[ f ]]( s, us, cf, ( 18195.3, -2872.82, 1994.93 ), ( 0, 251.89, 0 ), "terminus_audio_intel_warlord" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_e_ob_intel_cs / namespace_4a9cd794b84f1429
// Params 0
// Checksum 0x0, Offset: 0x64e
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_e_ob_intel_cs / namespace_4a9cd794b84f1429
// Params 0
// Checksum 0x0, Offset: 0x658
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_e_ob_intel_cs" );
}

