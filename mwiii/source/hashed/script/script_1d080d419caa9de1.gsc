#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_c_ob_mysteryboxes_cs;

// Namespace mp_jup_st_c_ob_mysteryboxes_cs / namespace_8b45a101f607d5bb
// Params 2
// Checksum 0x0, Offset: 0x108
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_c_ob_mysteryboxes_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_c_ob_mysteryboxes_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_c_ob_mysteryboxes_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_c_ob_mysteryboxes_cs / namespace_8b45a101f607d5bb
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
    
    s cs_setup_arrays( us, "mp_jup_st_c_ob_mysteryboxes_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_c_ob_mysteryboxes_cs" );
}

// Namespace mp_jup_st_c_ob_mysteryboxes_cs / namespace_8b45a101f607d5bb
// Params 3
// Checksum 0x0, Offset: 0x1ec
// Size: 0x192
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_mysteryboxes_cs";
    s.content_key = "magicbox_spawn";
    s.name = "magicbox_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 24673, 27358, 1372 ), ( 0, 270.05, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_mysteryboxes_cs";
    s.content_key = "magicbox_spawn";
    s.name = "magicbox_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 33002, 39310, 943 ), ( 0, 149.31, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_mysteryboxes_cs";
    s.content_key = "magicbox_spawn";
    s.name = "magicbox_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 40415, 31603, 1776 ), ( 0, 48.68, 0 ) );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_c_ob_mysteryboxes_cs / namespace_8b45a101f607d5bb
// Params 0
// Checksum 0x0, Offset: 0x386
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_c_ob_mysteryboxes_cs / namespace_8b45a101f607d5bb
// Params 0
// Checksum 0x0, Offset: 0x390
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_c_ob_mysteryboxes_cs" );
}

