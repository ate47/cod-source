#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_e_ob_essence_cs;

// Namespace mp_jup_st_e_ob_essence_cs / namespace_b9b61ddb4ba5d417
// Params 2
// Checksum 0x0, Offset: 0x108
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_e_ob_essence_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_e_ob_essence_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_e_ob_essence_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_e_ob_essence_cs / namespace_b9b61ddb4ba5d417
// Params 3
// Checksum 0x0, Offset: 0x17d
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_e_ob_essence_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_e_ob_essence_cs" );
}

// Namespace mp_jup_st_e_ob_essence_cs / namespace_b9b61ddb4ba5d417
// Params 3
// Checksum 0x0, Offset: 0x1ec
// Size: 0xa74
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 6949, -1479, 2691 ), ( 0, 128, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 9287, -1852, 2691 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 8243, 1327, 2517 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 1634, 6621, 2133 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -4157, 4134, 2310 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -6892, -5791, 2287 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 14824, 336, 2061 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 12340, 5482, 2543 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -5325, 10491, 1817 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -12128, 4734, 1646 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -9360, 1474, 1622 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -13294, 11706, 1585 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -1642, -2879, 2457 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -6562, -12492, 2363 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -13460, -14905, 2471 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 7454, -7554, 2679 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 15236, -5075, 1782 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 13101, -990, 1993 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 2053, 1477, 2324 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 4925, 13927, 959 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -4567, -861, 2231 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -12774, -8190, 1993 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 14559, -11201, 2151 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 3523, -4349, 2688 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -1300, 1448, 2330 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 6238, 9998, 1676 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -14776, 454, 1555 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 2517, -15740, 2377 ), ( 0, 0, 0 ) );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_e_ob_essence_cs / namespace_b9b61ddb4ba5d417
// Params 0
// Checksum 0x0, Offset: 0xc68
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_e_ob_essence_cs / namespace_b9b61ddb4ba5d417
// Params 0
// Checksum 0x0, Offset: 0xc72
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_e_ob_essence_cs" );
}

