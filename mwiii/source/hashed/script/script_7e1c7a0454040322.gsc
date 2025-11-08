#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_tower_ob_interactions_aether_tear_cs;

// Namespace mp_jup_tower_ob_interactions_aether_tear_cs / namespace_3f8df0d57a4f3a78
// Params 2
// Checksum 0x0, Offset: 0x128
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_tower_ob_interactions_aether_tear_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_tower_ob_interactions_aether_tear_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_tower_ob_interactions_aether_tear_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_tower_ob_interactions_aether_tear_cs / namespace_3f8df0d57a4f3a78
// Params 3
// Checksum 0x0, Offset: 0x19d
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_tower_ob_interactions_aether_tear_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_tower_ob_interactions_aether_tear_cs" );
}

// Namespace mp_jup_tower_ob_interactions_aether_tear_cs / namespace_3f8df0d57a4f3a78
// Params 3
// Checksum 0x0, Offset: 0x20c
// Size: 0x108
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_tower_ob_interactions_aether_tear_cs";
    fe [[ f ]]( s, us, cf, ( 14823, 16979, 272 ), ( 0, 0, 0 ), undefined, "cspf_1_auto259537210961259514", "aether_tear_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_interactions_aether_tear_cs";
    fe [[ f ]]( s, us, cf, ( 16792, 15064, 4946 ), ( 0, 138.6, 0 ), "cspf_1_auto259537210961259514", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_tower_ob_interactions_aether_tear_cs / namespace_3f8df0d57a4f3a78
// Params 0
// Checksum 0x0, Offset: 0x31c
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_tower_ob_interactions_aether_tear_cs / namespace_3f8df0d57a4f3a78
// Params 0
// Checksum 0x0, Offset: 0x326
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_tower_ob_interactions_aether_tear_cs" );
}

