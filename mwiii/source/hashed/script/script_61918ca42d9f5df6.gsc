#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_e_ob_aether_storm_cs;

// Namespace mp_jup_st_e_ob_aether_storm_cs / namespace_5c747362b650ddec
// Params 2
// Checksum 0x0, Offset: 0x100
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_e_ob_aether_storm_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_e_ob_aether_storm_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_e_ob_aether_storm_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_e_ob_aether_storm_cs / namespace_5c747362b650ddec
// Params 3
// Checksum 0x0, Offset: 0x175
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_e_ob_aether_storm_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_e_ob_aether_storm_cs" );
}

// Namespace mp_jup_st_e_ob_aether_storm_cs / namespace_5c747362b650ddec
// Params 3
// Checksum 0x0, Offset: 0x1e4
// Size: 0x77
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    fe [[ f ]]( s, us, cf, ( -1036, 1750, 2008 ), ( 0, 0, 0 ), "aether_storm_spawnpoint" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_e_ob_aether_storm_cs / namespace_5c747362b650ddec
// Params 0
// Checksum 0x0, Offset: 0x263
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

