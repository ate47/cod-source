#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_b_ob_contracts_vehicle_drive_cs;

// Namespace mp_jup_st_b_ob_contracts_vehicle_drive_cs / namespace_e265d5109a300cd4
// Params 2
// Checksum 0x0, Offset: 0x2ac
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_b_ob_contracts_vehicle_drive_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_b_ob_contracts_vehicle_drive_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_b_ob_contracts_vehicle_drive_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_b_ob_contracts_vehicle_drive_cs / namespace_e265d5109a300cd4
// Params 3
// Checksum 0x0, Offset: 0x321
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_b_ob_contracts_vehicle_drive_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_b_ob_contracts_vehicle_drive_cs" );
}

// Namespace mp_jup_st_b_ob_contracts_vehicle_drive_cs / namespace_e265d5109a300cd4
// Params 3
// Checksum 0x0, Offset: 0x390
// Size: 0x900
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -2989.2, 26199.7, 7436.76 ), ( 0, 35, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -4511.1, 20761, 8275.73 ), ( 0, 80, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 2646.9, 22218.2, 7618.14 ), ( 0, 125, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 4948.1, 32679.7, 7954.6 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -5789.2, 37561.3, 8158.82 ), ( 0, 275, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -2297.4, 33314.1, 6983.85 ), ( 0, 320, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -10436.1, 33570, 7000.74 ), ( 0, 350, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 3059.8, 28075.7, 7436.76 ), ( 0, 35, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 9530.9, 19943, 8275.73 ), ( 0, 80, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 10094.9, 25545.2, 7618.14 ), ( 0, 125, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 12848.7, 31415.7, 8943.55 ), ( 0, 170, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 13311.1, 36683.7, 7954.6 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 7413.8, 37733.3, 8158.82 ), ( 0, 275, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 1227.6, 38866.1, 6983.85 ), ( 0, 320, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -9138.1, 27048, 7000.74 ), ( 0, 350, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.name = "dmz_vehicledrive_end";
    fe [[ f ]]( s, us, cf, ( -9805.64, 34138.5, 1210.3 ), ( 357.9, 306.96, -2.11 ), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_POWER_EAST", undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.name = "dmz_vehicledrive_end";
    fe [[ f ]]( s, us, cf, ( 1183, 38687.5, 1393.75 ), ( 359.06, 142.02, -1.25 ), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_POWER_EAST", undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.name = "dmz_vehicledrive_end";
    fe [[ f ]]( s, us, cf, ( 12125.3, 22326.4, 984.93 ), ( 0.24, 252.58, -0.03 ), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_INDUSTRIAL_WEST", undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.name = "dmz_vehicledrive_end";
    fe [[ f ]]( s, us, cf, ( 2253.15, 19176.5, 999.97 ), ( 359.94, 78.89, -0.11 ), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_INDUSTRIAL_WEST", undefined, undefined, undefined, undefined, 200 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_b_ob_contracts_vehicle_drive_cs / namespace_e265d5109a300cd4
// Params 0
// Checksum 0x0, Offset: 0xc98
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_b_ob_contracts_vehicle_drive_cs / namespace_e265d5109a300cd4
// Params 0
// Checksum 0x0, Offset: 0xca2
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_b_ob_contracts_vehicle_drive_cs" );
}

// Namespace mp_jup_st_b_ob_contracts_vehicle_drive_cs / namespace_e265d5109a300cd4
// Params 0
// Checksum 0x0, Offset: 0xcb8
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

// Namespace mp_jup_st_b_ob_contracts_vehicle_drive_cs / namespace_e265d5109a300cd4
// Params 4
// Checksum 0x0, Offset: 0xd2a
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_39e9abf2b293ea07":
            function_df2b73d8a91a281c( fe, us, cf );
            break;
        case #"hash_50ebc80f7f48fb25":
            function_dce550759dfaee22( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_b_ob_contracts_vehicle_drive_cs / namespace_e265d5109a300cd4
// Params 3
// Checksum 0x0, Offset: 0xd9c
// Size: 0x1d0
function function_df2b73d8a91a281c( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 2375.25, 31161.5, 988 ), ( 0, 270, 0 ), "vehicledrive_horde", "VEHICLE_DRIVE_B_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 2360, 31492, 1038 ), ( 0, 252.1, 0 ), "dmz_vehicledrive_start", "VEHICLE_DRIVE_B_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 15000 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 2490.25, 31608.8, 980 ), ( 0, 225, 0 ), "vehicledrive_guard", "VEHICLE_DRIVE_B_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 2645, 26780, 1082.75 ), ( 270, 315, 0 ), "activity_nexus_instance_joiner", undefined, "VEHICLE_DRIVE_B_GARAGE_GASSTATION_NORTH", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_b_ob_contracts_vehicle_drive_cs / namespace_e265d5109a300cd4
// Params 3
// Checksum 0x0, Offset: 0xf74
// Size: 0x1d0
function function_dce550759dfaee22( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -382.5, 18550.2, 1000 ), ( 0, 360, 0 ), "vehicledrive_horde", "VEHICLE_DRIVE_B_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -560, 18260, 1060 ), ( 0, 74.1, 0 ), "dmz_vehicledrive_start", "VEHICLE_DRIVE_B_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 15000 );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -487.75, 18087.5, 1002.5 ), ( 0, 90, 0 ), "vehicledrive_guard", "VEHICLE_DRIVE_B_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -3911.5, 24641, 1051.75 ), ( 270, 0, 179.44 ), "activity_nexus_instance_joiner", undefined, "VEHICLE_DRIVE_B_GARAGE_GASSTATION_SOUTH", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_b_ob_contracts_vehicle_drive_cs / namespace_e265d5109a300cd4
// Params 0
// Checksum 0x0, Offset: 0x114c
// Size: 0x1bc
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
    instancestruct.cf = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    instancestruct.scriptstructorigin = ( 2360, 31492, 996 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 2421, 31572.5, 980 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 350 ];
    activityinstances[ "VEHICLE_DRIVE_B_GARAGE_GASSTATION_NORTH" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
    instancestruct.cf = "mp_jup_st_b_ob_contracts_vehicle_drive_cs";
    instancestruct.scriptstructorigin = ( -560, 18264, 1020 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -492, 18143, 1002.5 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 350 ];
    activityinstances[ "VEHICLE_DRIVE_B_GARAGE_GASSTATION_SOUTH" ] = instancestruct;
    return activityinstances;
}

