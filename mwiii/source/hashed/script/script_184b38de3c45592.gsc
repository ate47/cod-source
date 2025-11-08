#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_b_ob_activities_summon_cs;

// Namespace mp_jup_st_b_ob_activities_summon_cs / namespace_212266c75b256f0e
// Params 2
// Checksum 0x0, Offset: 0x134
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_b_ob_activities_summon_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_b_ob_activities_summon_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_b_ob_activities_summon_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_b_ob_activities_summon_cs / namespace_212266c75b256f0e
// Params 3
// Checksum 0x0, Offset: 0x1a9
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_b_ob_activities_summon_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_b_ob_activities_summon_cs" );
}

// Namespace mp_jup_st_b_ob_activities_summon_cs / namespace_212266c75b256f0e
// Params 3
// Checksum 0x0, Offset: 0x218
// Size: 0xa3
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_summon_cs";
    s.name = "yellow_console_1";
    fe [[ f ]]( s, us, cf, ( 5711.12, 22344.4, 1024 ), ( 0, 164.29, 0 ), "yellow_console_1", "summon_console_yellow_controller", "summon_consoles" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_b_ob_activities_summon_cs / namespace_212266c75b256f0e
// Params 0
// Checksum 0x0, Offset: 0x2c3
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_b_ob_activities_summon_cs / namespace_212266c75b256f0e
// Params 0
// Checksum 0x0, Offset: 0x2cd
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_b_ob_activities_summon_cs" );
}

