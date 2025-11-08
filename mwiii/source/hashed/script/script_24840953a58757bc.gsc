#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_a_ob_contracts_vehicle_drive_cs;

// Namespace mp_jup_st_a_ob_contracts_vehicle_drive_cs / namespace_c53cc58959bd5ec4
// Params 2
// Checksum 0x0, Offset: 0x26e
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_a_ob_contracts_vehicle_drive_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_a_ob_contracts_vehicle_drive_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_a_ob_contracts_vehicle_drive_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_a_ob_contracts_vehicle_drive_cs / namespace_c53cc58959bd5ec4
// Params 3
// Checksum 0x0, Offset: 0x2e3
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_a_ob_contracts_vehicle_drive_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_a_ob_contracts_vehicle_drive_cs" );
}

// Namespace mp_jup_st_a_ob_contracts_vehicle_drive_cs / namespace_c53cc58959bd5ec4
// Params 3
// Checksum 0x0, Offset: 0x352
// Size: 0x640
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -35096, 23776, 4992 ), ( 0, 35, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -25816, 20672, 5824 ), ( 0, 80, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -25080, 32704, 5152 ), ( 0, 125, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -20152, 34496, 6496 ), ( 0, 170, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -22136, 41120, 5504 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -29784, 38240, 5696 ), ( 0, 275, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -33400, 33440, 4544 ), ( 0, 320, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -19992, 27008, 5728 ), ( 0, 350, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -28376, 27168, 5824 ), ( 0, 80, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( -28728, 43168, 5696 ), ( 0, 275, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -40864, 36968, 960 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -32223, 19843, 907.23 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -16636, 20996, 2287.39 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -15402, 36002, 2476.18 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_a_ob_contracts_vehicle_drive_cs / namespace_c53cc58959bd5ec4
// Params 0
// Checksum 0x0, Offset: 0x99a
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_a_ob_contracts_vehicle_drive_cs / namespace_c53cc58959bd5ec4
// Params 0
// Checksum 0x0, Offset: 0x9a4
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_a_ob_contracts_vehicle_drive_cs" );
}

// Namespace mp_jup_st_a_ob_contracts_vehicle_drive_cs / namespace_c53cc58959bd5ec4
// Params 0
// Checksum 0x0, Offset: 0x9ba
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

// Namespace mp_jup_st_a_ob_contracts_vehicle_drive_cs / namespace_c53cc58959bd5ec4
// Params 4
// Checksum 0x0, Offset: 0xa2c
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_31f9b68b7b4494a4":
            function_2481f5507af33d27( fe, us, cf );
            break;
        case #"hash_96436180e4aa8062":
            function_45dbf9e1d023136d( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_a_ob_contracts_vehicle_drive_cs / namespace_c53cc58959bd5ec4
// Params 3
// Checksum 0x0, Offset: 0xa9e
// Size: 0x1d0
function function_2481f5507af33d27( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -22532, 24216, 1764 ), ( 0, 339, 0 ), "dmz_vehicledrive_start", "VEHICLE_DRIVE_A_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 15000 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -22216.5, 24196.5, 1703.53 ), ( 0, 315, 0 ), "vehicledrive_horde", "VEHICLE_DRIVE_A_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -22728, 24460, 1704 ), ( 0, 315, 0 ), "vehicledrive_guard", "VEHICLE_DRIVE_A_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -21122, 20982, 1794.75 ), ( 270, 45, 0 ), "activity_nexus_instance_joiner", undefined, "VEHICLE_DRIVE_A_GARAGE_GASSTATION_SOUTH", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_a_ob_contracts_vehicle_drive_cs / namespace_c53cc58959bd5ec4
// Params 3
// Checksum 0x0, Offset: 0xc76
// Size: 0x1d0
function function_45dbf9e1d023136d( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( -27652, 39428, 1626 ), ( 0, 245, 0 ), "dmz_vehicledrive_start", "VEHICLE_DRIVE_A_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 15000 );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -27855, 39202.2, 1566.05 ), ( 0, 225, 0 ), "vehicledrive_horde", "VEHICLE_DRIVE_A_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -27675, 39678, 1567.5 ), ( 0, 270, 0 ), "vehicledrive_guard", "VEHICLE_DRIVE_A_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( -24622, 37270, 1830.5 ), ( 270, 0, 0 ), "activity_nexus_instance_joiner", undefined, "VEHICLE_DRIVE_A_GARAGE_GASSTATION_NORTH", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_a_ob_contracts_vehicle_drive_cs / namespace_c53cc58959bd5ec4
// Params 0
// Checksum 0x0, Offset: 0xe4e
// Size: 0x1bc
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
    instancestruct.cf = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    instancestruct.scriptstructorigin = ( -22532, 24216, 1720 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -22591.5, 24354, 1705.5 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 350 ];
    activityinstances[ "VEHICLE_DRIVE_A_GARAGE_GASSTATION_SOUTH" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
    instancestruct.cf = "mp_jup_st_a_ob_contracts_vehicle_drive_cs";
    instancestruct.scriptstructorigin = ( -27652, 39428, 1584 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -27684.5, 39559.5, 1567.5 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 350 ];
    activityinstances[ "VEHICLE_DRIVE_A_GARAGE_GASSTATION_NORTH" ] = instancestruct;
    return activityinstances;
}

