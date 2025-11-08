#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_a_ob_activities_servershutdown_cs;

// Namespace mp_jup_st_a_ob_activities_servershutdown_cs / namespace_981841431137dfcc
// Params 2
// Checksum 0x0, Offset: 0x10d
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_a_ob_activities_servershutdown_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_a_ob_activities_servershutdown_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_a_ob_activities_servershutdown_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_a_ob_activities_servershutdown_cs / namespace_981841431137dfcc
// Params 3
// Checksum 0x0, Offset: 0x182
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_a_ob_activities_servershutdown_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_a_ob_activities_servershutdown_cs" );
}

// Namespace mp_jup_st_a_ob_activities_servershutdown_cs / namespace_981841431137dfcc
// Params 3
// Checksum 0x0, Offset: 0x1f1
// Size: 0x200
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_activities_servershutdown_cs";
    s.height = 4096;
    fe [[ f ]]( s, us, cf, ( -36784, 38624, 1088 ), ( 0, 0, 0 ), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_activities_servershutdown_cs";
    s.height = 4096;
    fe [[ f ]]( s, us, cf, ( -27008, 19904, 1088 ), ( 0, 0, 0 ), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_activities_servershutdown_cs";
    s.height = 4096;
    fe [[ f ]]( s, us, cf, ( -17856, 22336, 1920 ), ( 0, 0, 0 ), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_activities_servershutdown_cs";
    s.height = 4096;
    fe [[ f ]]( s, us, cf, ( -25216, 42944, 1536 ), ( 0, 0, 0 ), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_activities_servershutdown_cs";
    s.height = 4096;
    fe [[ f ]]( s, us, cf, ( -26112, 27072, 1344 ), ( 0, 0, 0 ), "aether_storm_spawnpoint", undefined, undefined, undefined, undefined, undefined, undefined, 2048 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_a_ob_activities_servershutdown_cs / namespace_981841431137dfcc
// Params 0
// Checksum 0x0, Offset: 0x3f9
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_a_ob_activities_servershutdown_cs / namespace_981841431137dfcc
// Params 0
// Checksum 0x0, Offset: 0x403
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_a_ob_activities_servershutdown_cs" );
}

