#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_h_gas_stations;

// Namespace mp_jup_st_h_gas_stations / namespace_db64ae640647c5cd
// Params 2
// Checksum 0x0, Offset: 0xf6
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_h_gas_stations" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_h_gas_stations" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_h_gas_stations" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_h_gas_stations / namespace_db64ae640647c5cd
// Params 3
// Checksum 0x0, Offset: 0x16b
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_h_gas_stations" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_h_gas_stations" );
}

// Namespace mp_jup_st_h_gas_stations / namespace_db64ae640647c5cd
// Params 3
// Checksum 0x0, Offset: 0x1da
// Size: 0x100
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_h_gas_stations";
    s.height = 1000;
    fe [[ f ]]( s, us, cf, ( -7737.5, -41914, 2423 ), ( 0, 0, 0 ), "gas_station", undefined, "large", undefined, undefined, undefined, undefined, 600 );
    s = s();
    s.cs_flag = "mp_jup_st_h_gas_stations";
    s.height = 1000;
    fe [[ f ]]( s, us, cf, ( 9136, -20192, 1696 ), ( 0, 0, 0 ), "gas_station", undefined, "large", undefined, undefined, undefined, undefined, 600 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_h_gas_stations / namespace_db64ae640647c5cd
// Params 0
// Checksum 0x0, Offset: 0x2e2
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_h_gas_stations / namespace_db64ae640647c5cd
// Params 0
// Checksum 0x0, Offset: 0x2ec
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_h_gas_stations" );
}

