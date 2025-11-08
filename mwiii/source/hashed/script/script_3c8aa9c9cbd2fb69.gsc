#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_g_ob_mysteryboxes_cs;

// Namespace mp_jup_st_g_ob_mysteryboxes_cs / namespace_e3133db2e25257f3
// Params 2
// Checksum 0x0, Offset: 0x109
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_g_ob_mysteryboxes_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_g_ob_mysteryboxes_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_g_ob_mysteryboxes_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_g_ob_mysteryboxes_cs / namespace_e3133db2e25257f3
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
    
    s cs_setup_arrays( us, "mp_jup_st_g_ob_mysteryboxes_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_g_ob_mysteryboxes_cs" );
}

// Namespace mp_jup_st_g_ob_mysteryboxes_cs / namespace_e3133db2e25257f3
// Params 3
// Checksum 0x0, Offset: 0x1ed
// Size: 0x2dc
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_mysteryboxes_cs";
    s.content_key = "magicbox_spawn";
    s.name = "magicbox_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -17335, -10338, 1527 ), ( 0, 270.07, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_mysteryboxes_cs";
    s.content_key = "magicbox_spawn";
    s.name = "magicbox_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -20972, -38103, 2917 ), ( 0, 158.8, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_mysteryboxes_cs";
    s.content_key = "magicbox_spawn";
    s.name = "magicbox_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -1583, -19318, 1736 ), ( 0, 322.56, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_mysteryboxes_cs";
    s.content_key = "magicbox_spawn";
    s.name = "magicbox_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -24949, -23630, 1713 ), ( 0, 257.27, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_mysteryboxes_cs";
    s.content_key = "magicbox_spawn";
    s.name = "magicbox_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -9652, -31693, 1757 ), ( 0, 251.2, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_mysteryboxes_cs";
    s.content_key = "magicbox_spawn";
    s.name = "magicbox_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( -11326, -24353, 1789 ), ( 0, 336, 0 ) );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_g_ob_mysteryboxes_cs / namespace_e3133db2e25257f3
// Params 0
// Checksum 0x0, Offset: 0x4d1
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_g_ob_mysteryboxes_cs / namespace_e3133db2e25257f3
// Params 0
// Checksum 0x0, Offset: 0x4db
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_g_ob_mysteryboxes_cs" );
}

