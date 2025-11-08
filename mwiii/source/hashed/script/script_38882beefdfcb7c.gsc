#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_f_ob_wallbuys_cs;

// Namespace mp_jup_st_f_ob_wallbuys_cs / namespace_3fa31e4e9d89bd3e
// Params 2
// Checksum 0x0, Offset: 0x110
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_f_ob_wallbuys_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_f_ob_wallbuys_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_f_ob_wallbuys_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_f_ob_wallbuys_cs / namespace_3fa31e4e9d89bd3e
// Params 3
// Checksum 0x0, Offset: 0x185
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_f_ob_wallbuys_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_f_ob_wallbuys_cs" );
}

// Namespace mp_jup_st_f_ob_wallbuys_cs / namespace_3fa31e4e9d89bd3e
// Params 3
// Checksum 0x0, Offset: 0x1f4
// Size: 0x5c8
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 36685, -10243, 2941 ), ( 0, 27, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 37254, -5041, 2968 ), ( 0, 344.9, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 29584, 7588, 2185 ), ( 0, 230.94, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 31124, -5506, 2940 ), ( 0, 134.9, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 33605, 3344, 2358 ), ( 0, 114, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 40212, 11438, 3072.71 ), ( 0, 360, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 27831, -376, 2232 ), ( 0, 92.1, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 45068, 1259, 2970.49 ), ( 0, 89, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 30445, -13446, 2935 ), ( 0, 285.2, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 38062, 369, 2968.06 ), ( 0, 270, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( 44262, -10038, 2844.29 ), ( 0, 159.9, 0 ) );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_f_ob_wallbuys_cs / namespace_3fa31e4e9d89bd3e
// Params 0
// Checksum 0x0, Offset: 0x7c4
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_f_ob_wallbuys_cs / namespace_3fa31e4e9d89bd3e
// Params 0
// Checksum 0x0, Offset: 0x7ce
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_f_ob_wallbuys_cs" );
}

