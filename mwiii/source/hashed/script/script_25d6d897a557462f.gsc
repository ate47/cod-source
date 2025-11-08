#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_i_ob_essence_cs;

// Namespace mp_jup_st_i_ob_essence_cs / namespace_9c12c3ac22d75c87
// Params 2
// Checksum 0x0, Offset: 0x124
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_i_ob_essence_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_i_ob_essence_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_i_ob_essence_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_i_ob_essence_cs / namespace_9c12c3ac22d75c87
// Params 3
// Checksum 0x0, Offset: 0x199
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_i_ob_essence_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_i_ob_essence_cs" );
}

// Namespace mp_jup_st_i_ob_essence_cs / namespace_9c12c3ac22d75c87
// Params 3
// Checksum 0x0, Offset: 0x208
// Size: 0x3b8
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.name = "essence_container_large";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 41841, -26080, 3674 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.name = "essence_container_large";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 30316, -22085, 3418 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.name = "essence_container_large";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 29267, -30924, 4118 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.name = "essence_container_large";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 28714, -35611, 3332 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.name = "essence_container_large";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 34762, -29076, 3107 ), ( 0.02, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.name = "essence_container_large";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 38067, -18864, 3293 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.name = "essence_container_large";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 19223, -30624, 3880 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.name = "essence_container_large";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 22232, -21742, 2998 ), ( 0, 0, 0 ) );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_i_ob_essence_cs / namespace_9c12c3ac22d75c87
// Params 0
// Checksum 0x0, Offset: 0x5c8
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_i_ob_essence_cs / namespace_9c12c3ac22d75c87
// Params 0
// Checksum 0x0, Offset: 0x5d2
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_i_ob_essence_cs" );
}

