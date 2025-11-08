#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_hydro_ob_circle_cs;

// Namespace mp_jup_hydro_ob_circle_cs / namespace_c80b48d458bcbe24
// Params 2
// Checksum 0x0, Offset: 0x12e
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_hydro_ob_circle_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_hydro_ob_circle_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_hydro_ob_circle_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_hydro_ob_circle_cs / namespace_c80b48d458bcbe24
// Params 3
// Checksum 0x0, Offset: 0x1a3
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_hydro_ob_circle_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_hydro_ob_circle_cs" );
}

// Namespace mp_jup_hydro_ob_circle_cs / namespace_c80b48d458bcbe24
// Params 3
// Checksum 0x0, Offset: 0x212
// Size: 0x173
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_circle_cs";
    s.name = "exit_portal_ending";
    fe [[ f ]]( s, us, cf, ( -8208.21, 8823.55, 306.26 ), ( 0, 134.2, 0 ), "exit_portal_ending" );
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_circle_cs";
    fe [[ f ]]( s, us, cf, ( -14098.2, 2363.34, 1114.87 ), ( 0, 318.2, 0 ), "ob_infil_rift_gate" );
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_circle_cs";
    s.name = "exit_portal";
    fe [[ f ]]( s, us, cf, ( -6230.45, 9536.44, 187.96 ), ( 0, 76.48, 0 ), "exit_portal" );
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_circle_cs";
    fe [[ f ]]( s, us, cf, ( -7324.8, 7516.43, 1862.5 ), ( 0, 0, 0 ), "ob_circle_start", undefined, undefined, undefined, undefined, undefined, undefined, 10000 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_hydro_ob_circle_cs / namespace_c80b48d458bcbe24
// Params 0
// Checksum 0x0, Offset: 0x38d
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_hydro_ob_circle_cs / namespace_c80b48d458bcbe24
// Params 0
// Checksum 0x0, Offset: 0x397
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_hydro_ob_circle_cs" );
}

