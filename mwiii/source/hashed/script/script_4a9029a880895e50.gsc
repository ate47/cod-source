#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_d_ob_contracts_vehicle_drive_cs;

// Namespace mp_jup_st_d_ob_contracts_vehicle_drive_cs / namespace_f26383f97b745280
// Params 2
// Checksum 0x0, Offset: 0x244
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_d_ob_contracts_vehicle_drive_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_d_ob_contracts_vehicle_drive_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_d_ob_contracts_vehicle_drive_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_d_ob_contracts_vehicle_drive_cs / namespace_f26383f97b745280
// Params 3
// Checksum 0x0, Offset: 0x2b9
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_d_ob_contracts_vehicle_drive_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_d_ob_contracts_vehicle_drive_cs" );
}

// Namespace mp_jup_st_d_ob_contracts_vehicle_drive_cs / namespace_f26383f97b745280
// Params 3
// Checksum 0x0, Offset: 0x328
// Size: 0x718
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -19152, 14472, 1928.02 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -32300.8, 13890.8, 954.53 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -31959.2, -9817.3, 4985.76 ), ( 0, 35, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -27339.2, -13115.8, 1521.4 ), ( 0.02, 0, 0.56 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -22660.1, -12930, 5824.73 ), ( 0, 80, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -21927.1, -909.8, 5167.14 ), ( 0, 125, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -17017.3, 907.7, 6492.55 ), ( 0, 170, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -19005.9, 7509.7, 5503.6 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -26631.2, 4643.3, 5707.82 ), ( 0, 275, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -30249.4, -157.9, 4532.85 ), ( 0, 320, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -16836.1, -6593, 5731.74 ), ( 0, 350, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -25243.1, -6424, 5824.73 ), ( 0, 80, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -25580.2, 9564.3, 5707.82 ), ( 0, 275, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -29188.2, -11604.5, 1527.95 ), ( 0.02, 0, 0.56 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -17195.2, -8432.5, 1504.98 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -31203.3, 8344.3, 959 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -18831.1, 3960.3, 1269.97 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_d_ob_contracts_vehicle_drive_cs / namespace_f26383f97b745280
// Params 0
// Checksum 0x0, Offset: 0xa48
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_d_ob_contracts_vehicle_drive_cs / namespace_f26383f97b745280
// Params 0
// Checksum 0x0, Offset: 0xa52
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_d_ob_contracts_vehicle_drive_cs" );
}

// Namespace mp_jup_st_d_ob_contracts_vehicle_drive_cs / namespace_f26383f97b745280
// Params 0
// Checksum 0x0, Offset: 0xa68
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

// Namespace mp_jup_st_d_ob_contracts_vehicle_drive_cs / namespace_f26383f97b745280
// Params 4
// Checksum 0x0, Offset: 0xada
// Size: 0x51
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_cd209a6ae07998a7":
            function_46326f1429ee9844( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_d_ob_contracts_vehicle_drive_cs / namespace_f26383f97b745280
// Params 3
// Checksum 0x0, Offset: 0xb33
// Size: 0x1d0
function function_46326f1429ee9844( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -21615, -1576, 1060.5 ), ( 270, 135, 0 ), "activity_nexus_instance_joiner", undefined, "VEHICLE_DRIVE_D_GARAGE_GASSTATION_SOUTH", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -25554, -918, 1072 ), ( 0, 252, 0 ), "dmz_vehicledrive_start", "VEHICLE_DRIVE_D_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 15000 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -25739.5, -1148.5, 1009.99 ), ( 0, 315, 0 ), "vehicledrive_horde", "VEHICLE_DRIVE_D_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -25708, -788, 1014 ), ( 0, 270, 0 ), "vehicledrive_guard", "VEHICLE_DRIVE_D_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_d_ob_contracts_vehicle_drive_cs / namespace_f26383f97b745280
// Params 0
// Checksum 0x0, Offset: 0xd0b
// Size: 0xea
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
    instancestruct.cf = "mp_jup_st_d_ob_contracts_vehicle_drive_cs";
    instancestruct.scriptstructorigin = ( -25554, -918, 1030 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -25618, -800, 1013 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 350 ];
    activityinstances[ "VEHICLE_DRIVE_D_GARAGE_GASSTATION_SOUTH" ] = instancestruct;
    return activityinstances;
}

