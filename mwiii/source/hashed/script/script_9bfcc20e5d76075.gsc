#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_f_ob_intel_cs;

// Namespace mp_jup_st_f_ob_intel_cs / namespace_36260b098cf2fcf9
// Params 2
// Checksum 0x0, Offset: 0x29b
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_f_ob_intel_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_f_ob_intel_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_f_ob_intel_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_f_ob_intel_cs / namespace_36260b098cf2fcf9
// Params 3
// Checksum 0x0, Offset: 0x310
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_f_ob_intel_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_f_ob_intel_cs" );
}

// Namespace mp_jup_st_f_ob_intel_cs / namespace_36260b098cf2fcf9
// Params 3
// Checksum 0x0, Offset: 0x37f
// Size: 0x2f6
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_rural_shop_md_01";
    fe [[ f ]]( s, us, cf, ( 34644.8, 917.58, 2554.04 ), ( 0, 0.29, 0 ), "terminus_audio_intel_warlord" );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_rural_packing_building_01";
    fe [[ f ]]( s, us, cf, ( 42411.7, -4171.42, 3176 ), ( 0, 270.29, 0 ), "terminus_audio_intel_warlord" );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_rural_house_md_06_abandoned";
    fe [[ f ]]( s, us, cf, ( 41247, 14662.3, 3413.52 ), ( 0, 321.37, 0 ), "terminus_audio_intel_warlord" );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_rural_house_md_06";
    fe [[ f ]]( s, us, cf, ( 28186.5, 10412.5, 2112 ), ( 0, 141.37, 0 ), "terminus_audio_intel_warlord" );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_rural_house_md_2s_03";
    fe [[ f ]]( s, us, cf, ( 27113.2, -2021, 2532.5 ), ( 0, 351.18, 0 ), "terminus_audio_intel_warlord" );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_house_lg_01";
    fe [[ f ]]( s, us, cf, ( 31878.4, 1864.64, 2381.3 ), ( 0, 90.29, 0 ), "terminus_audio_intel_warlord" );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_intel_cs";
    s.groupid = "stronghold";
    s.name = "terminus_audio_intel_stronghold_f_police_station_01";
    fe [[ f ]]( s, us, cf, ( 24491.5, -14978.4, 2994.57 ), ( 0, 38.95, 0 ), "terminus_audio_intel_warlord" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_f_ob_intel_cs / namespace_36260b098cf2fcf9
// Params 0
// Checksum 0x0, Offset: 0x67d
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_f_ob_intel_cs / namespace_36260b098cf2fcf9
// Params 0
// Checksum 0x0, Offset: 0x687
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_f_ob_intel_cs" );
}

