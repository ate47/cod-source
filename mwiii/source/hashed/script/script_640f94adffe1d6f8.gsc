#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_e_ob_exfil_cargo_cs;

// Namespace mp_jup_st_e_ob_exfil_cargo_cs / namespace_e28e7a93b7035a14
// Params 2
// Checksum 0x0, Offset: 0xe4
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_e_ob_exfil_cargo_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_e_ob_exfil_cargo_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_e_ob_exfil_cargo_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_e_ob_exfil_cargo_cs / namespace_e28e7a93b7035a14
// Params 3
// Checksum 0x0, Offset: 0x159
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_e_ob_exfil_cargo_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_e_ob_exfil_cargo_cs" );
}

// Namespace mp_jup_st_e_ob_exfil_cargo_cs / namespace_e28e7a93b7035a14
// Params 3
// Checksum 0x0, Offset: 0x1c8
// Size: 0x83
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_exfil_cargo_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_e_ob_exfil_cargo_cs / namespace_e28e7a93b7035a14
// Params 0
// Checksum 0x0, Offset: 0x253
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_e_ob_exfil_cargo_cs / namespace_e28e7a93b7035a14
// Params 0
// Checksum 0x0, Offset: 0x25d
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_e_ob_exfil_cargo_cs" );
}

