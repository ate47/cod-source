#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_h_ob_contracts_vehicle_drive_cs;

// Namespace mp_jup_st_h_ob_contracts_vehicle_drive_cs / namespace_585c5b0ba5009e78
// Params 2
// Checksum 0x0, Offset: 0x26f
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_h_ob_contracts_vehicle_drive_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_h_ob_contracts_vehicle_drive_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_h_ob_contracts_vehicle_drive_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_h_ob_contracts_vehicle_drive_cs / namespace_585c5b0ba5009e78
// Params 3
// Checksum 0x0, Offset: 0x2e4
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_h_ob_contracts_vehicle_drive_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_h_ob_contracts_vehicle_drive_cs" );
}

// Namespace mp_jup_st_h_ob_contracts_vehicle_drive_cs / namespace_585c5b0ba5009e78
// Params 3
// Checksum 0x0, Offset: 0x353
// Size: 0x718
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 14640, -38312, 2983.11 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 646, -25744, 1702.93 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 16192, -23616, 1704.98 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 4608, -43520, 2935.77 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 4777, -15134, 1672.89 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -3104, -37120, 4992 ), ( 0, 35, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 6176, -40224, 5824 ), ( 0, 80, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 6912, -28192, 5152 ), ( 0, 125, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 11840, -26400, 6496 ), ( 0, 170, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 9856, -19776, 5504 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 2208, -22656, 5696 ), ( 0, 275, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -1408, -27456, 4544 ), ( 0, 320, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 12000, -33888, 5728 ), ( 0, 350, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 3616, -33728, 5824 ), ( 0, 80, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 3264, -17728, 5696 ), ( 0, 275, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -247, -35641, 1960 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -1186, -42401, 2812.93 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_h_ob_contracts_vehicle_drive_cs / namespace_585c5b0ba5009e78
// Params 0
// Checksum 0x0, Offset: 0xa73
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_h_ob_contracts_vehicle_drive_cs / namespace_585c5b0ba5009e78
// Params 0
// Checksum 0x0, Offset: 0xa7d
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_h_ob_contracts_vehicle_drive_cs" );
}

// Namespace mp_jup_st_h_ob_contracts_vehicle_drive_cs / namespace_585c5b0ba5009e78
// Params 0
// Checksum 0x0, Offset: 0xa93
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

// Namespace mp_jup_st_h_ob_contracts_vehicle_drive_cs / namespace_585c5b0ba5009e78
// Params 4
// Checksum 0x0, Offset: 0xb05
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_e56111473cab914b":
            function_107518ab04d18ce0( fe, us, cf );
            break;
        case #"hash_64c319ec75b43691":
            function_a873c00f39292cde( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_h_ob_contracts_vehicle_drive_cs / namespace_585c5b0ba5009e78
// Params 3
// Checksum 0x0, Offset: 0xb77
// Size: 0x1d0
function function_107518ab04d18ce0( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -6936, -42158, 2488 ), ( 0, 116, -0 ), "dmz_vehicledrive_start", "VEHICLE_DRIVE_H_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 15000 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -7158, -41923.5, 2428.96 ), ( 0, 90, 0 ), "vehicledrive_horde", "VEHICLE_DRIVE_H_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -6912, -42444, 2432 ), ( 0, 135, 0 ), "vehicledrive_guard", "VEHICLE_DRIVE_H_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -2615.25, -40348.8, 2755.25 ), ( 270, 0, 135 ), "activity_nexus_instance_joiner", undefined, "VEHICLE_DRIVE_H_GARAGE_GASSTATION_SOUTH", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_h_ob_contracts_vehicle_drive_cs / namespace_585c5b0ba5009e78
// Params 3
// Checksum 0x0, Offset: 0xd4f
// Size: 0x1d0
function function_a873c00f39292cde( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 14024, -23042, 1724 ), ( 270, 45, 0 ), "activity_nexus_instance_joiner", undefined, "VEHICLE_DRIVE_H_GARAGE_GASSTATION_NORTH", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 9732, -20812, 1768 ), ( 0, 77.3, 0 ), "dmz_vehicledrive_start", "VEHICLE_DRIVE_H_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 15000 );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 9740.25, -20438.8, 1712 ), ( 0, 45, 0 ), "vehicledrive_horde", "VEHICLE_DRIVE_H_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 9588, -20868, 1716 ), ( 0, 45, 0 ), "vehicledrive_guard", "VEHICLE_DRIVE_H_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_h_ob_contracts_vehicle_drive_cs / namespace_585c5b0ba5009e78
// Params 0
// Checksum 0x0, Offset: 0xf27
// Size: 0x1bc
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
    instancestruct.cf = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    instancestruct.scriptstructorigin = ( -6936, -42156, 2448 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -6929, -42285, 2430.5 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 350 ];
    activityinstances[ "VEHICLE_DRIVE_H_GARAGE_GASSTATION_SOUTH" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
    instancestruct.cf = "mp_jup_st_h_ob_contracts_vehicle_drive_cs";
    instancestruct.scriptstructorigin = ( 9732, -20812, 1732 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 9655, -20903, 1710.95 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 350 ];
    activityinstances[ "VEHICLE_DRIVE_H_GARAGE_GASSTATION_NORTH" ] = instancestruct;
    return activityinstances;
}

