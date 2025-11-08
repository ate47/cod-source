#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_d_ob_essence_cs;

// Namespace mp_jup_st_d_ob_essence_cs / namespace_ffbeef5a9056e1bb
// Params 2
// Checksum 0x0, Offset: 0x109
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_d_ob_essence_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_d_ob_essence_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_d_ob_essence_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_d_ob_essence_cs / namespace_ffbeef5a9056e1bb
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
    
    s cs_setup_arrays( us, "mp_jup_st_d_ob_essence_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_d_ob_essence_cs" );
}

// Namespace mp_jup_st_d_ob_essence_cs / namespace_ffbeef5a9056e1bb
// Params 3
// Checksum 0x0, Offset: 0x1ed
// Size: 0x3ea
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -28813, 11488, 1220 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -18831, 5154, 1665 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -37155, 11261, 1002 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -30901, -3936, 1086 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -32581, 7244, 1182 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -31800, 1667, 1201 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -25956, 6301, 1660 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -18144, -777, 1307 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -24714, 2215, 1660 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -22364, 10115, 3582 ), ( 0, 0, 0 ) );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_d_ob_essence_cs / namespace_ffbeef5a9056e1bb
// Params 0
// Checksum 0x0, Offset: 0x5df
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_d_ob_essence_cs / namespace_ffbeef5a9056e1bb
// Params 0
// Checksum 0x0, Offset: 0x5e9
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_d_ob_essence_cs" );
}

