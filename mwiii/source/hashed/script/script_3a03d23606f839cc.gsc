#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_i_ob_contracts_vehicle_drive_cs;

// Namespace mp_jup_st_i_ob_contracts_vehicle_drive_cs / namespace_d2483194d44b06d4
// Params 2
// Checksum 0x0, Offset: 0x244
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_i_ob_contracts_vehicle_drive_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_i_ob_contracts_vehicle_drive_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_i_ob_contracts_vehicle_drive_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_i_ob_contracts_vehicle_drive_cs / namespace_d2483194d44b06d4
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
    
    s cs_setup_arrays( us, "mp_jup_st_i_ob_contracts_vehicle_drive_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_i_ob_contracts_vehicle_drive_cs" );
}

// Namespace mp_jup_st_i_ob_contracts_vehicle_drive_cs / namespace_d2483194d44b06d4
// Params 3
// Checksum 0x0, Offset: 0x328
// Size: 0x640
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 24192, -19456, 5248 ), ( 0, 305, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 21088, -28736, 6080 ), ( 0, 350, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 33120, -29472, 5408 ), ( 0, 35, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 34912, -34400, 6752 ), ( 0, 80, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 41536, -32416, 5760 ), ( 0, 140, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 38656, -24768, 5952 ), ( 0, 185, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 33856, -21152, 4800 ), ( 0, 230, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 27424, -34560, 5984 ), ( 0, 260, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 27584, -26176, 6080 ), ( 0, 350, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
    s.script_unload = "default";
    s.spawngroup = "heli_test_guys";
    fe [[ f ]]( s, us, cf, ( 43584, -25824, 5952 ), ( 0, 185, 0 ), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 26349.2, -30352.5, 3493.25 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 28104, -38218, 2984.6 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 39264, -25220, 3144 ), ( 0, 0, 0 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 21713, -21260, 2882.36 ), ( 0, 0.04, -0.37 ), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_i_ob_contracts_vehicle_drive_cs / namespace_d2483194d44b06d4
// Params 0
// Checksum 0x0, Offset: 0x970
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_i_ob_contracts_vehicle_drive_cs / namespace_d2483194d44b06d4
// Params 0
// Checksum 0x0, Offset: 0x97a
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_i_ob_contracts_vehicle_drive_cs" );
}

// Namespace mp_jup_st_i_ob_contracts_vehicle_drive_cs / namespace_d2483194d44b06d4
// Params 0
// Checksum 0x0, Offset: 0x990
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

// Namespace mp_jup_st_i_ob_contracts_vehicle_drive_cs / namespace_d2483194d44b06d4
// Params 4
// Checksum 0x0, Offset: 0xa02
// Size: 0x51
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_bb121a1b91ab7f8a":
            function_2cab58978a2240f5( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_i_ob_contracts_vehicle_drive_cs / namespace_d2483194d44b06d4
// Params 3
// Checksum 0x0, Offset: 0xa5b
// Size: 0x1d0
function function_2cab58978a2240f5( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 22216, -18524, 2944 ), ( 0, 315, 0 ), "dmz_vehicledrive_start", "VEHICLE_DRIVE_I_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 15000 );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 22480, -18676.5, 2883.53 ), ( 0, 270, 0 ), "vehicledrive_horde", "VEHICLE_DRIVE_I_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 22136, -18220, 2888 ), ( 0, 315, 0 ), "vehicledrive_guard", "VEHICLE_DRIVE_I_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    fe [[ f ]]( s, us, cf, ( 21153, -21429, 3080.25 ), ( 270, 0, 135 ), "activity_nexus_instance_joiner", undefined, "VEHICLE_DRIVE_I_GARAGE_GASSTATION_NORTH", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_i_ob_contracts_vehicle_drive_cs / namespace_d2483194d44b06d4
// Params 0
// Checksum 0x0, Offset: 0xc33
// Size: 0xea
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
    instancestruct.cf = "mp_jup_st_i_ob_contracts_vehicle_drive_cs";
    instancestruct.scriptstructorigin = ( 22208, -18512, 2904 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 22208, -18401, 2886 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 350 ];
    activityinstances[ "VEHICLE_DRIVE_I_GARAGE_GASSTATION_NORTH" ] = instancestruct;
    return activityinstances;
}

