#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_a_ob_activities_mrp_challenges_cs;

// Namespace mp_jup_st_a_ob_activities_mrp_challenges_cs / namespace_7d12a25cf603c57b
// Params 2
// Checksum 0x0, Offset: 0x150
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_a_ob_activities_mrp_challenges_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_a_ob_activities_mrp_challenges_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_a_ob_activities_mrp_challenges_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_a_ob_activities_mrp_challenges_cs / namespace_7d12a25cf603c57b
// Params 3
// Checksum 0x0, Offset: 0x1c5
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_a_ob_activities_mrp_challenges_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_a_ob_activities_mrp_challenges_cs" );
}

// Namespace mp_jup_st_a_ob_activities_mrp_challenges_cs / namespace_7d12a25cf603c57b
// Params 3
// Checksum 0x0, Offset: 0x234
// Size: 0xe3
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_activities_mrp_challenges_cs";
    s.trigger_size = "122,1024,550";
    fe [[ f ]]( s, us, cf, ( -22034, 30514, 2854 ), ( 0, 332, 0 ), "cspf_0_auto10862537481892710558" );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_activities_mrp_challenges_cs";
    fe [[ f ]]( s, us, cf, ( -21817, 30395, 2683.81 ), ( 357.91, 141.87, 0 ), "mrp_challenge", "cspf_0_auto10862537481892710558", "mrp_freebird_challenge" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_a_ob_activities_mrp_challenges_cs / namespace_7d12a25cf603c57b
// Params 0
// Checksum 0x0, Offset: 0x31f
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_a_ob_activities_mrp_challenges_cs / namespace_7d12a25cf603c57b
// Params 0
// Checksum 0x0, Offset: 0x329
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_a_ob_activities_mrp_challenges_cs" );
}

