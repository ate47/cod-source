#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_d_ob_puzzles;

// Namespace mp_jup_st_d_ob_puzzles / namespace_2518e41dd44c2ea7
// Params 2
// Checksum 0x0, Offset: 0x15e
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_d_ob_puzzles" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_d_ob_puzzles" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_d_ob_puzzles" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_d_ob_puzzles / namespace_2518e41dd44c2ea7
// Params 3
// Checksum 0x0, Offset: 0x1d3
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_d_ob_puzzles" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_d_ob_puzzles" );
}

// Namespace mp_jup_st_d_ob_puzzles / namespace_2518e41dd44c2ea7
// Params 3
// Checksum 0x0, Offset: 0x242
// Size: 0x488
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_puzzles";
    s.name = "spatial_air_obelisk";
    fe [[ f ]]( s, us, cf, ( -26749.1, 5581.82, 1033.11 ), ( 359.91, 295.89, 0.28 ), "spatial_air_obelisk" );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_puzzles";
    s.name = "spatial_air_runes";
    fe [[ f ]]( s, us, cf, ( -26625.2, 6964.75, 1190.83 ), ( 359.33, 284.24, 0.2 ), undefined, undefined, "spatial_air_runes" );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_puzzles";
    s.height = 500;
    s.name = "spatial_air_alignment";
    fe [[ f ]]( s, us, cf, ( -25792, 3149, 3005.75 ), ( 28, 112, -0 ), "spatial_air_alignment", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_puzzles";
    s.name = "alignment_center";
    fe [[ f ]]( s, us, cf, ( -25792, 3149, 3234 ), ( 28, 112, -0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_puzzles";
    s.name = "spatial_air_runes";
    fe [[ f ]]( s, us, cf, ( -26067.2, 6052.75, 1107.81 ), ( 0.29, 196.79, 0.04 ), undefined, undefined, "spatial_air_runes" );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_puzzles";
    s.name = "spatial_air_reward";
    fe [[ f ]]( s, us, cf, ( -26836, 5720.01, 1040.25 ), ( 0, 297.1, 0 ), "spatial_air_reward" );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_puzzles";
    s.name = "spatial_air_runes";
    fe [[ f ]]( s, us, cf, ( -25662.2, 5396.84, 1484.43 ), ( 21.69, 192.76, -0.19 ), undefined, undefined, "spatial_air_runes" );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_puzzles";
    s.name = "spatial_air_runes";
    fe [[ f ]]( s, us, cf, ( -27750.5, 4614, 1055.83 ), ( 0.22, 105.66, -0.23 ), undefined, undefined, "spatial_air_runes" );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_puzzles";
    s.name = "spatial_air_runes";
    fe [[ f ]]( s, us, cf, ( -25518.6, 5856.25, 1450.83 ), ( 0.24, 193.28, 0.2 ), undefined, undefined, "spatial_air_runes" );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_puzzles";
    s.name = "spatial_air_orb";
    fe [[ f ]]( s, us, cf, ( -26749.1, 5581.82, 1233.11 ), ( 359.91, 295.89, 0.28 ), "spatial_air_orb" );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_puzzles";
    s.name = "spatial_air_runes";
    fe [[ f ]]( s, us, cf, ( -26296.3, 5237.25, 1055.49 ), ( 0, 237.29, 0 ), undefined, undefined, "spatial_air_runes" );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_puzzles";
    s.name = "spatial_air_runes";
    fe [[ f ]]( s, us, cf, ( -27601.2, 5936.75, 1109.76 ), ( 0, 103.91, 0 ), undefined, undefined, "spatial_air_runes" );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_puzzles";
    s.name = "spatial_air_runes";
    fe [[ f ]]( s, us, cf, ( -27458.8, 6773.5, 1606.76 ), ( 0, 283.59, 0 ), undefined, undefined, "spatial_air_runes" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_d_ob_puzzles / namespace_2518e41dd44c2ea7
// Params 0
// Checksum 0x0, Offset: 0x6d2
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_d_ob_puzzles / namespace_2518e41dd44c2ea7
// Params 0
// Checksum 0x0, Offset: 0x6dc
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_d_ob_puzzles" );
}

