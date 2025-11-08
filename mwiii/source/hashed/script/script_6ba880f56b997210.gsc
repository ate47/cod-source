#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_d_ob_wallbuys_cs;

// Namespace mp_jup_st_d_ob_wallbuys_cs / namespace_60784ca744394e0a
// Params 2
// Checksum 0x0, Offset: 0x111
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_d_ob_wallbuys_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_d_ob_wallbuys_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_d_ob_wallbuys_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_d_ob_wallbuys_cs / namespace_60784ca744394e0a
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
    
    s cs_setup_arrays( us, "mp_jup_st_d_ob_wallbuys_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_d_ob_wallbuys_cs" );
}

// Namespace mp_jup_st_d_ob_wallbuys_cs / namespace_60784ca744394e0a
// Params 3
// Checksum 0x0, Offset: 0x1f5
// Size: 0x348
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( -26490, 8639, 1148 ), ( 0, 6, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( -33857, 11719, 960 ), ( 0, 9.97, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( -32459, 3226, 960 ), ( 0, 190, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( -25627, 1204, 1005 ), ( 0, 113.85, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( -18809, 5004, 1278 ), ( 0, 90, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_wallbuys_cs";
    s.content_key = "wallbuy_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 55 ), ( 0, 0, 0 ), undefined, undefined, "random_ob", undefined, undefined, ( -27674, 15107, 1171 ), ( 0, 349.96, 0 ) );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_d_ob_wallbuys_cs / namespace_60784ca744394e0a
// Params 0
// Checksum 0x0, Offset: 0x545
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_d_ob_wallbuys_cs / namespace_60784ca744394e0a
// Params 0
// Checksum 0x0, Offset: 0x54f
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_d_ob_wallbuys_cs" );
}

