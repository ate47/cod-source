#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_d_gas_stations;

// Namespace mp_jup_st_d_gas_stations / namespace_9661b1840de4663d
// Params 2
// Checksum 0x0, Offset: 0x10d
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_d_gas_stations" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_d_gas_stations" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_d_gas_stations" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_d_gas_stations / namespace_9661b1840de4663d
// Params 3
// Checksum 0x0, Offset: 0x182
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_d_gas_stations" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_d_gas_stations" );
}

// Namespace mp_jup_st_d_gas_stations / namespace_9661b1840de4663d
// Params 3
// Checksum 0x0, Offset: 0x1f1
// Size: 0x204
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_gas_stations";
    s.height = 1000;
    fe [[ f ]]( s, us, cf, ( -25124, -1608, 1012 ), ( 0, 0, 0 ), "gas_station", undefined, "large", undefined, undefined, undefined, undefined, 600 );
    s = s();
    s.cs_flag = "mp_jup_st_d_gas_stations";
    s.height = 1000;
    fe [[ f ]]( s, us, cf, ( -35524, 5224, 864 ), ( 0, 0, 0 ), "gas_station_marine", undefined, undefined, undefined, undefined, undefined, undefined, 650 );
    s = s();
    s.cs_flag = "mp_jup_st_d_gas_stations";
    s.height = 1000;
    fe [[ f ]]( s, us, cf, ( -31053.5, -929, 864 ), ( 0, 0, 0 ), "gas_station_marine", undefined, undefined, undefined, undefined, undefined, undefined, 650 );
    s = s();
    s.cs_flag = "mp_jup_st_d_gas_stations";
    s.height = 1000;
    fe [[ f ]]( s, us, cf, ( -33889.5, 15155.5, 858.5 ), ( 0, 0, 0 ), "gas_station_marine", undefined, undefined, undefined, undefined, undefined, undefined, 650 );
    s = s();
    s.cs_flag = "mp_jup_st_d_gas_stations";
    s.height = 1000;
    fe [[ f ]]( s, us, cf, ( -18055, -3462.5, 864 ), ( 0, 0, 0 ), "gas_station_marine", undefined, undefined, undefined, undefined, undefined, undefined, 650 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_d_gas_stations / namespace_9661b1840de4663d
// Params 0
// Checksum 0x0, Offset: 0x3fd
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_d_gas_stations / namespace_9661b1840de4663d
// Params 0
// Checksum 0x0, Offset: 0x407
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_d_gas_stations" );
}

