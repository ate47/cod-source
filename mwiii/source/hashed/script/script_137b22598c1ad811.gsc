#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_f_gas_stations;

// Namespace mp_jup_st_f_gas_stations / namespace_e999d8dfe317a9c1
// Params 2
// Checksum 0x0, Offset: 0x104
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_f_gas_stations" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_f_gas_stations" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_f_gas_stations" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_f_gas_stations / namespace_e999d8dfe317a9c1
// Params 3
// Checksum 0x0, Offset: 0x179
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_f_gas_stations" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_f_gas_stations" );
}

// Namespace mp_jup_st_f_gas_stations / namespace_e999d8dfe317a9c1
// Params 3
// Checksum 0x0, Offset: 0x1e8
// Size: 0xd6
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.height = 1000;
    fe [[ f ]]( s, us, cf, ( 28536, 3016, 1600 ), ( 0, 0, 0 ), "gas_station_marine", undefined, undefined, undefined, undefined, undefined, undefined, 650 );
    s = s();
    s.height = 1000;
    fe [[ f ]]( s, us, cf, ( 33684, 8908, 2192 ), ( 0, 0, 0 ), "gas_station", undefined, undefined, undefined, undefined, undefined, undefined, 400 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_f_gas_stations / namespace_e999d8dfe317a9c1
// Params 0
// Checksum 0x0, Offset: 0x2c6
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

