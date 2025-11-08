#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_h_ob_essence_cs;

// Namespace mp_jup_st_h_ob_essence_cs / namespace_a079c579312b4f23
// Params 2
// Checksum 0x0, Offset: 0x109
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_h_ob_essence_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_h_ob_essence_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_h_ob_essence_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_h_ob_essence_cs / namespace_a079c579312b4f23
// Params 3
// Checksum 0x0, Offset: 0x17e
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_h_ob_essence_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_h_ob_essence_cs" );
}

// Namespace mp_jup_st_h_ob_essence_cs / namespace_a079c579312b4f23
// Params 3
// Checksum 0x0, Offset: 0x1ed
// Size: 0x447
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 6816, -33872, 4453 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -2170, -32141, 2952 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 4799, -22493, 2262 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 1728, -18948, 2082 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 12012, -19687, 1708 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 18198, -34402, 3430 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 598, -37381, 2552 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -3988, -25953, 3138 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -5406, -15602, 2397 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -6037, -19462, 2110 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 7476, -26805, 2259 ), ( 0, 0, 0 ) );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_h_ob_essence_cs / namespace_a079c579312b4f23
// Params 0
// Checksum 0x0, Offset: 0x63c
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_h_ob_essence_cs / namespace_a079c579312b4f23
// Params 0
// Checksum 0x0, Offset: 0x646
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_h_ob_essence_cs" );
}

