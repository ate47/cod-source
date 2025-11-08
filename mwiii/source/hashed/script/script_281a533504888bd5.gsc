#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_a_ob_interactions_turret_trap_cs;

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 2
// Checksum 0x0, Offset: 0x3c0
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_a_ob_interactions_turret_trap_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_a_ob_interactions_turret_trap_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_a_ob_interactions_turret_trap_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 3
// Checksum 0x0, Offset: 0x435
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_a_ob_interactions_turret_trap_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_a_ob_interactions_turret_trap_cs" );
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 3
// Checksum 0x0, Offset: 0x4a4
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 0
// Checksum 0x0, Offset: 0x4ec
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 0
// Checksum 0x0, Offset: 0x4f6
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_a_ob_interactions_turret_trap_cs" );
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 0
// Checksum 0x0, Offset: 0x50c
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_TURRET_TRAP";
    activityinfostruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 4
// Checksum 0x0, Offset: 0x57e
// Size: 0xe7
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_f33280bfb3a7c865":
            function_245b7f79787cfd20( fe, us, cf );
            break;
        case #"hash_9dc858e08a785f68":
            function_435a05bf1b09db9d( fe, us, cf );
            break;
        case #"hash_9e4f94aa490c2155":
            function_ccfeaf236674ed48( fe, us, cf );
            break;
        case #"hash_c16110d67572ee58":
            function_48bf5e542ea18b63( fe, us, cf );
            break;
        case #"hash_7cf797390762c55a":
            function_68f4110f5cdb931b( fe, us, cf );
            break;
        case #"hash_9450df6114af1815":
            function_5940679f1ba6cfde( fe, us, cf );
            break;
        case #"hash_66a69f15248c67fb":
            function_c2421398e67e8890( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 3
// Checksum 0x0, Offset: 0x66d
// Size: 0x162
function function_245b7f79787cfd20( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -21759.7, 38788.2, 2507.5 ), ( 0, 285.1, 0 ), "turret_trap_spawn", "s_turret_trap_a_playground", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -21758.9, 38789.7, 2592 ), ( 0, 195.1, 0 ), "s_turret_trap_a_playground", undefined, "activity_turret_trap_a_playground", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -21753.4, 38761.1, 2557.5 ), ( 0, 195.1, 0 ), "turret_trap_panel", "s_turret_trap_a_playground", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 3
// Checksum 0x0, Offset: 0x7d7
// Size: 0x166
function function_435a05bf1b09db9d( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -25583.5, 42084.8, 1881.5 ), ( 0, 334.4, 0 ), "turret_trap_spawn", "s_turret_trap_a_statue", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -25584, 42086.2, 1966 ), ( 0, 244.4, 0 ), "s_turret_trap_a_statue", "s_turret_trap_a_statue", "activity_turret_trap_a_statue", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -25558.8, 42071.8, 1931.5 ), ( 0, 244.4, 0 ), "turret_trap_panel", "s_turret_trap_a_statue", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 3
// Checksum 0x0, Offset: 0x945
// Size: 0x162
function function_ccfeaf236674ed48( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -30827.7, 31120.1, 1437.5 ), ( 0, 298.1, 0 ), "turret_trap_spawn", "s_turret_trap_a_construction", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -30827.2, 31121.7, 1522 ), ( 0, 208.1, 0 ), "s_turret_trap_a_construction", undefined, "activity_turret_trap_a_construction", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -30815.5, 31095, 1487.5 ), ( 0, 208.1, 0 ), "turret_trap_panel", "s_turret_trap_a_construction", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 3
// Checksum 0x0, Offset: 0xaaf
// Size: 0x162
function function_48bf5e542ea18b63( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -29594.7, 22709.1, 1358.25 ), ( 0, 240.94, 0 ), "turret_trap_spawn", "s_turret_trap_a_parking", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -29593.2, 22709.6, 1442.75 ), ( 0, 150.94, 0 ), "s_turret_trap_a_parking", undefined, "activity_turret_trap_a_parking", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -29609.2, 22685.3, 1408.25 ), ( 0, 150.94, 0 ), "turret_trap_panel", "s_turret_trap_a_parking", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 3
// Checksum 0x0, Offset: 0xc19
// Size: 0x162
function function_68f4110f5cdb931b( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -31127.7, 17105.2, 1068 ), ( 0, 319.27, 0 ), "turret_trap_spawn", "s_turret_trap_a_jeti", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -31127.9, 17106.7, 1152.5 ), ( 0, 229.27, 0 ), "s_turret_trap_a_jeti", undefined, "activity_turret_trap_a_jeti", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -31107.3, 17086.1, 1118 ), ( 0, 229.27, 0 ), "turret_trap_panel", "s_turret_trap_a_jeti", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 3
// Checksum 0x0, Offset: 0xd83
// Size: 0x162
function function_5940679f1ba6cfde( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -34528.6, 42666.4, 1790.5 ), ( 0, 45.3, 0 ), "turret_trap_spawn", "s_turret_trap_a_tower", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -34530.3, 42666.4, 1875 ), ( 0, 315.3, 0 ), "s_turret_trap_a_tower", undefined, "activity_turret_trap_a_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -34508.3, 42685.5, 1840.5 ), ( 0, 315.3, 0 ), "turret_trap_panel", "s_turret_trap_a_tower", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 3
// Checksum 0x0, Offset: 0xeed
// Size: 0x162
function function_c2421398e67e8890( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -21931.2, 19211, 2275.5 ), ( 0, 224.5, 0 ), "turret_trap_spawn", "s_turret_trap_a_billboard", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -21929.5, 19211, 2360 ), ( 0, 134.5, 0 ), "s_turret_trap_a_billboard", undefined, "activity_turret_trap_a_billboard", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( -21951.8, 19192.2, 2325.5 ), ( 0, 134.5, 0 ), "turret_trap_panel", "s_turret_trap_a_billboard", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_a_ob_interactions_turret_trap_cs / namespace_c5c19ce11cea9c1b
// Params 0
// Checksum 0x0, Offset: 0x1057
// Size: 0x5cf
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( -21757.5, 38788.1, 2610 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -21754.8, 38785.4, 2640 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_A_PLAYGROUND" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( -25582, 42086.4, 1984 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -25578.1, 42086.6, 2014 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_A_STATUE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( -30825.5, 31120.5, 1540 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -30822.3, 31118.4, 1570 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_A_CONSTRUCTION" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( -29593.2, 22707.6, 1460.75 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -29593.2, 22703.7, 1490.75 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_A_PARKING" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( -31125.9, 17106.3, 1170.5 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -31122.1, 17105.4, 1200.5 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_A_JETI" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( -34529.6, 42668.4, 1893 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -34528.6, 42672.1, 1923 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_A_TOWER" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_a_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( -21930.3, 19209, 2378 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -21931.3, 19205.3, 2408 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_A_BILLBOARD" ] = instancestruct;
    return activityinstances;
}

