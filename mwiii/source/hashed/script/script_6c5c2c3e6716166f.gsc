#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_f_ob_essence_cs;

// Namespace mp_jup_st_f_ob_essence_cs / namespace_21b8a06f41fd5c47
// Params 2
// Checksum 0x0, Offset: 0x109
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_f_ob_essence_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_f_ob_essence_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_f_ob_essence_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_f_ob_essence_cs / namespace_21b8a06f41fd5c47
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
    
    s cs_setup_arrays( us, "mp_jup_st_f_ob_essence_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_f_ob_essence_cs" );
}

// Namespace mp_jup_st_f_ob_essence_cs / namespace_21b8a06f41fd5c47
// Params 3
// Checksum 0x0, Offset: 0x1ed
// Size: 0x447
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 41274, 14242, 3609 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 32225, 12115, 2382 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 30760, 6096, 3042 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 42222, -4727, 3436 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 35906, -14227, 3189 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 28437, -1881, 2513 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 30231, -8286, 3409 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 36301, 3556, 3000 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 36914, -1583, 2893 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 41170, 9635, 3379 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_essence_cs";
    s.content_key = "essence_large_spawn";
    s.variantname = "content_struct";
    fe [[ f ]]( s, us, cf, ( 41469, 107, 3220 ), ( 0, 0, 0 ) );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_f_ob_essence_cs / namespace_21b8a06f41fd5c47
// Params 0
// Checksum 0x0, Offset: 0x63c
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_f_ob_essence_cs / namespace_21b8a06f41fd5c47
// Params 0
// Checksum 0x0, Offset: 0x646
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_f_ob_essence_cs" );
}

