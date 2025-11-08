#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_f_ob_activities_servershutdown_cs;

// Namespace mp_jup_st_f_ob_activities_servershutdown_cs / namespace_7a1eecd8c2a5b9c
// Params 2
// Checksum 0x0, Offset: 0x10c
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_f_ob_activities_servershutdown_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_f_ob_activities_servershutdown_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_f_ob_activities_servershutdown_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_f_ob_activities_servershutdown_cs / namespace_7a1eecd8c2a5b9c
// Params 3
// Checksum 0x0, Offset: 0x181
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_f_ob_activities_servershutdown_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_f_ob_activities_servershutdown_cs" );
}

// Namespace mp_jup_st_f_ob_activities_servershutdown_cs / namespace_7a1eecd8c2a5b9c
// Params 3
// Checksum 0x0, Offset: 0x1f0
// Size: 0x308
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_activities_servershutdown_cs";
    s.height = 4096;
    fe [[ f ]]( s, us, cf, ( 25024, -640, 2112 ), ( 0, 0, 0 ), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048 );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_activities_servershutdown_cs";
    s.height = 4096;
    fe [[ f ]]( s, us, cf, ( 22272, -13120, 2752 ), ( 0, 0, 0 ), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048 );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_activities_servershutdown_cs";
    s.height = 4096;
    fe [[ f ]]( s, us, cf, ( 33280, -8448, 2752 ), ( 0, 0, 0 ), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048 );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_activities_servershutdown_cs";
    s.height = 4096;
    fe [[ f ]]( s, us, cf, ( 24832, 10176, 1408 ), ( 0, 0, 0 ), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048 );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_activities_servershutdown_cs";
    s.height = 4096;
    fe [[ f ]]( s, us, cf, ( 39552, -11584, 2688 ), ( 0, 0, 0 ), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048 );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_activities_servershutdown_cs";
    s.height = 4096;
    fe [[ f ]]( s, us, cf, ( 41408, -1088, 2880 ), ( 0, 0, 0 ), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048 );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_activities_servershutdown_cs";
    s.height = 4096;
    fe [[ f ]]( s, us, cf, ( 38976, 3968, 2624 ), ( 0, 0, 0 ), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048 );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_activities_servershutdown_cs";
    s.height = 4096;
    fe [[ f ]]( s, us, cf, ( 35648, 10816, 1728 ), ( 0, 0, 0 ), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_f_ob_activities_servershutdown_cs / namespace_7a1eecd8c2a5b9c
// Params 0
// Checksum 0x0, Offset: 0x500
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_f_ob_activities_servershutdown_cs / namespace_7a1eecd8c2a5b9c
// Params 0
// Checksum 0x0, Offset: 0x50a
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_f_ob_activities_servershutdown_cs" );
}

