#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_c_ob_ambient_biomes_cs;

// Namespace mp_jup_st_c_ob_ambient_biomes_cs / namespace_644f62ff38e6df05
// Params 2
// Checksum 0x0, Offset: 0x103
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_c_ob_ambient_biomes_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_c_ob_ambient_biomes_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_c_ob_ambient_biomes_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_c_ob_ambient_biomes_cs / namespace_644f62ff38e6df05
// Params 3
// Checksum 0x0, Offset: 0x178
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_c_ob_ambient_biomes_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_c_ob_ambient_biomes_cs" );
}

// Namespace mp_jup_st_c_ob_ambient_biomes_cs / namespace_644f62ff38e6df05
// Params 3
// Checksum 0x0, Offset: 0x1e7
// Size: 0x263
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.name = "dense";
    fe [[ f ]]( s, us, cf, ( 30765.3, 41142.2, 1323.5 ), ( 0, 0, 0 ), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3500 );
    s = s();
    s.name = "dense";
    fe [[ f ]]( s, us, cf, ( 30426.3, 34435.4, 1743.05 ), ( 0, 0, 0 ), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 5500 );
    s = s();
    s.name = "dense";
    fe [[ f ]]( s, us, cf, ( 38735.4, 30626.7, 1760.67 ), ( 0, 0, 0 ), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3500 );
    s = s();
    s.name = "dense";
    fe [[ f ]]( s, us, cf, ( 42834.7, 33182.9, 2576.67 ), ( 0, 0, 0 ), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500 );
    s = s();
    s.name = "dense";
    fe [[ f ]]( s, us, cf, ( 24327.6, 32635.2, 1906.66 ), ( 0, 0, 0 ), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500 );
    s = s();
    s.name = "dense";
    fe [[ f ]]( s, us, cf, ( 26503.1, 25088.7, 1504.05 ), ( 0, 0, 0 ), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 5500 );
    s = s();
    s.name = "dense";
    fe [[ f ]]( s, us, cf, ( 31529.6, 25855.2, 1503.72 ), ( 0, 0, 0 ), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 4000 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_c_ob_ambient_biomes_cs / namespace_644f62ff38e6df05
// Params 0
// Checksum 0x0, Offset: 0x452
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

