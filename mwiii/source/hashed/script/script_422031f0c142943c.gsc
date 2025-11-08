#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_i_ob_wallbuys_cs;

// Namespace mp_jup_st_i_ob_wallbuys_cs / namespace_514bb433a608217e
// Params 2
// Checksum 0x0, Offset: 0x111
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_i_ob_wallbuys_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_i_ob_wallbuys_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_i_ob_wallbuys_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_i_ob_wallbuys_cs / namespace_514bb433a608217e
// Params 3
// Checksum 0x0, Offset: 0x186
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_i_ob_wallbuys_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_i_ob_wallbuys_cs" );
}

// Namespace mp_jup_st_i_ob_wallbuys_cs / namespace_514bb433a608217e
// Params 3
// Checksum 0x0, Offset: 0x1f5
// Size: 0x4c8
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 23690, -32041, 3508 ), ( 0, 159.3, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 40677, -23516, 3136 ), ( 0, 300.2, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 25254, -37187, 3120 ), ( 0, 112.4, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 37305, -21607, 3059 ), ( 0, 211.01, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 44473, -29122, 3128 ), ( 0, 194, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 24165, -25642.3, 3101.28 ), ( 0, 152.01, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 19575, -21674, 2856 ), ( 0, 95.9, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 33454, -34532, 3024.62 ), ( 0, 22.33, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 30252, -26561, 3132 ), ( 0, 58.1, 0 ) );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_i_ob_wallbuys_cs / namespace_514bb433a608217e
// Params 0
// Checksum 0x0, Offset: 0x6c5
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_i_ob_wallbuys_cs / namespace_514bb433a608217e
// Params 0
// Checksum 0x0, Offset: 0x6cf
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_i_ob_wallbuys_cs" );
}

