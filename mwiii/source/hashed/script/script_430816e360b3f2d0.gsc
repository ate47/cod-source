#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_c_ob_contracts_vehicle_drive_cs;

// Namespace mp_jup_st_c_ob_contracts_vehicle_drive_cs / namespace_78f598d5a0fb01e0
// Params 2
// Checksum 0x0, Offset: 0x25a
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_c_ob_contracts_vehicle_drive_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_c_ob_contracts_vehicle_drive_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_c_ob_contracts_vehicle_drive_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_c_ob_contracts_vehicle_drive_cs / namespace_78f598d5a0fb01e0
// Params 3
// Checksum 0x0, Offset: 0x2cf
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_c_ob_contracts_vehicle_drive_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_c_ob_contracts_vehicle_drive_cs" );
}

// Namespace mp_jup_st_c_ob_contracts_vehicle_drive_cs / namespace_78f598d5a0fb01e0
// Params 3
// Checksum 0x0, Offset: 0x33e
// Size: 0x604
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 20746.8, 25020.7, 4985.76 ), ( 0, 35, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 30433.9, 20242, 5824.73 ), ( 0, 80, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 30278.9, 30208.2, 5167.14 ), ( 0, 125, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 36687.7, 32969.7, 6492.55 ), ( 0, 170, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 33256.1, 38072.7, 5503.6 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 28960.8, 36094.3, 5707.82 ), ( 0, 275, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 22678.6, 33347.1, 4532.85 ), ( 0, 320, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 36868.9, 25469, 5731.74 ), ( 0, 350, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 36540.3, 17361.6, 3303.59 ), ( 352, 12.31, 5.18 ), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 21696, 25535, 1375.1 ), ( 0, 359.93, 0 ), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 31696, 38089, 1034 ), ( 0, 1.38, 0 ), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 28461.9, 25638, 5824.73 ), ( 0, 80, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 26070.8, 39628.3, 5707.82 ), ( 0, 275, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_c_ob_contracts_vehicle_drive_cs / namespace_78f598d5a0fb01e0
// Params 0
// Checksum 0x0, Offset: 0x94a
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_c_ob_contracts_vehicle_drive_cs / namespace_78f598d5a0fb01e0
// Params 0
// Checksum 0x0, Offset: 0x954
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_c_ob_contracts_vehicle_drive_cs" );
}

// Namespace mp_jup_st_c_ob_contracts_vehicle_drive_cs / namespace_78f598d5a0fb01e0
// Params 0
// Checksum 0x0, Offset: 0x96a
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_VEHICLE_DRIVE";
    activityinfostruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_c_ob_contracts_vehicle_drive_cs / namespace_78f598d5a0fb01e0
// Params 4
// Checksum 0x0, Offset: 0x9dc
// Size: 0x51
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_c96efca84c9aaa1e":
            function_329e0348c0550009( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_c_ob_contracts_vehicle_drive_cs / namespace_78f598d5a0fb01e0
// Params 3
// Checksum 0x0, Offset: 0xa35
// Size: 0x1d0
function function_329e0348c0550009( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 31805.2, 34760.8, 1192 ), ( 0, 135, 0 ), "vehicledrive_horde", "VEHICLE_DRIVE_C_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 32208, 34444, 1196 ), ( 0, 90, 0 ), "vehicledrive_guard", "VEHICLE_DRIVE_C_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 31968, 34558, 1252 ), ( 0, 151, 0 ), "dmz_vehicledrive_start", "VEHICLE_DRIVE_C_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 15000 );
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 30671.2, 38570.8, 1036.5 ), ( 270, 270, 0 ), "activity_nexus_instance_joiner", undefined, "VEHICLE_DRIVE_C_GARAGE_GASSTATION_SOUTH", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_c_ob_contracts_vehicle_drive_cs / namespace_78f598d5a0fb01e0
// Params 0
// Checksum 0x0, Offset: 0xc0d
// Size: 0xea
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
    instancestruct.cf = "mp_jup_st_c_ob_contracts_vehicle_drive_cs";
    instancestruct.scriptstructorigin = ( 31964, 34556, 1212 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 32101.8, 34539, 1193 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 350 ];
    activityinstances[ "VEHICLE_DRIVE_C_GARAGE_GASSTATION_SOUTH" ] = instancestruct;
    return activityinstances;
}

