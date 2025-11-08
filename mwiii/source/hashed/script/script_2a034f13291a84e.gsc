#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_d_ob_activities_summon_cs;

// Namespace mp_jup_st_d_ob_activities_summon_cs / namespace_1469258a73fe4c92
// Params 2
// Checksum 0x0, Offset: 0x135
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_d_ob_activities_summon_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_d_ob_activities_summon_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_d_ob_activities_summon_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_d_ob_activities_summon_cs / namespace_1469258a73fe4c92
// Params 3
// Checksum 0x0, Offset: 0x1aa
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_d_ob_activities_summon_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_d_ob_activities_summon_cs" );
}

// Namespace mp_jup_st_d_ob_activities_summon_cs / namespace_1469258a73fe4c92
// Params 3
// Checksum 0x0, Offset: 0x219
// Size: 0xa3
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_activities_summon_cs";
    s.name = "yellow_console_4";
    fe [[ f ]]( s, us, cf, ( -26627, 4650, 1034 ), ( 0, 146.8, 0 ), "yellow_console_4", "summon_console_yellow_controller", "summon_consoles" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_d_ob_activities_summon_cs / namespace_1469258a73fe4c92
// Params 0
// Checksum 0x0, Offset: 0x2c4
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_d_ob_activities_summon_cs / namespace_1469258a73fe4c92
// Params 0
// Checksum 0x0, Offset: 0x2ce
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_d_ob_activities_summon_cs" );
}

