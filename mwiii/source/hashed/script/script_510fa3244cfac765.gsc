#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_d_ob_activities_merc_stronghold_cs;

// Namespace mp_jup_st_d_ob_activities_merc_stronghold_cs / namespace_40aba0a58a4fa597
// Params 2
// Checksum 0x0, Offset: 0x46b
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_d_ob_activities_merc_stronghold_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_d_ob_activities_merc_stronghold_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_d_ob_activities_merc_stronghold_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_d_ob_activities_merc_stronghold_cs / namespace_40aba0a58a4fa597
// Params 3
// Checksum 0x0, Offset: 0x4e0
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_d_ob_activities_merc_stronghold_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_d_ob_activities_merc_stronghold_cs" );
}

// Namespace mp_jup_st_d_ob_activities_merc_stronghold_cs / namespace_40aba0a58a4fa597
// Params 3
// Checksum 0x0, Offset: 0x54f
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_d_ob_activities_merc_stronghold_cs / namespace_40aba0a58a4fa597
// Params 0
// Checksum 0x0, Offset: 0x597
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_d_ob_activities_merc_stronghold_cs / namespace_40aba0a58a4fa597
// Params 0
// Checksum 0x0, Offset: 0x5a1
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_d_ob_activities_merc_stronghold_cs" );
}

// Namespace mp_jup_st_d_ob_activities_merc_stronghold_cs / namespace_40aba0a58a4fa597
// Params 0
// Checksum 0x0, Offset: 0x5b7
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_MERC_STRONGHOLD";
    activityinfostruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_d_ob_activities_merc_stronghold_cs / namespace_40aba0a58a4fa597
// Params 4
// Checksum 0x0, Offset: 0x629
// Size: 0x9c
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_4c7db34a5e11d4c2":
            function_9b6af0201b86ff0d( fe, us, cf );
            break;
        case #"hash_4c7dba4a5e11dfc7":
            function_9b6ae5201b86e6dc( fe, us, cf );
            break;
        case #"hash_d0faf278bddcea0f":
            function_d05e74433f558eec( fe, us, cf );
            break;
        case #"hash_7e3db5f2dc649f4c":
            function_5ce781a1a9943b15( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_d_ob_activities_merc_stronghold_cs / namespace_40aba0a58a4fa597
// Params 3
// Checksum 0x0, Offset: 0x6cd
// Size: 0x18d
function function_9b6af0201b86ff0d( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    s.name = "spawn_heli_reinforcements";
    s.script_parameters = "merc_stronghold_d_house_md_08_reinforcements";
    fe [[ f ]]( s, us, cf, ( -32128.2, 15443.9, 971.09 ), ( 0, 0, 0 ), undefined, "MERC_STRONGHOLD_HOUSE_MD_08", "s_safe_reinforce", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    fe [[ f ]]( s, us, cf, ( -32953.3, 14933.8, 950.75 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_D_HOUSE_MD_08_main", "MERC_STRONGHOLD_HOUSE_MD_08", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    s.script_parameters = "auto_floor_2";
    fe [[ f ]]( s, us, cf, ( -32670.9, 14818.6, 1086.75 ), ( 0, 190, 0 ), undefined, "MERC_STRONGHOLD_HOUSE_MD_08", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_d_ob_activities_merc_stronghold_cs / namespace_40aba0a58a4fa597
// Params 3
// Checksum 0x0, Offset: 0x862
// Size: 0x18d
function function_9b6ae5201b86e6dc( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    s.name = "spawn_heli_reinforcements";
    s.script_parameters = "merc_stronghold_d_house_md_03_reinforcements";
    fe [[ f ]]( s, us, cf, ( -21142.8, 7775.4, 2367.83 ), ( 0, 0, 0 ), undefined, "MERC_STRONGHOLD_HOUSE_MD_03", "s_safe_reinforce", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    fe [[ f ]]( s, us, cf, ( -21569.2, 8473.81, 2380.68 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_D_HOUSE_MD_03_main", "MERC_STRONGHOLD_HOUSE_MD_03", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    s.script_parameters = "auto_floor_2";
    fe [[ f ]]( s, us, cf, ( -21639.9, 8838.76, 2516.68 ), ( 0, 308, 0 ), undefined, "MERC_STRONGHOLD_HOUSE_MD_03", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_d_ob_activities_merc_stronghold_cs / namespace_40aba0a58a4fa597
// Params 3
// Checksum 0x0, Offset: 0x9f7
// Size: 0x18d
function function_d05e74433f558eec( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    s.name = "spawn_heli_reinforcements";
    s.script_parameters = "merc_stronghold_d_house_md_08_2_reinforcements";
    fe [[ f ]]( s, us, cf, ( -19648.7, 10271.2, 2017.08 ), ( 0, 0, 0 ), undefined, "MERC_STRONGHOLD_HOUSE_MD_08", "s_safe_reinforce", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    fe [[ f ]]( s, us, cf, ( -19268.4, 9219.47, 1977.75 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_D_HOUSE_MD_08_2_main", "MERC_STRONGHOLD_HOUSE_MD_08", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    s.script_parameters = "auto_floor_2";
    fe [[ f ]]( s, us, cf, ( -19091.4, 9175.71, 2113.68 ), ( 0, 166, 0 ), undefined, "MERC_STRONGHOLD_HOUSE_MD_08", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_d_ob_activities_merc_stronghold_cs / namespace_40aba0a58a4fa597
// Params 3
// Checksum 0x0, Offset: 0xb8c
// Size: 0x18d
function function_5ce781a1a9943b15( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    s.name = "spawn_heli_reinforcements";
    s.script_parameters = "merc_stronghold_d_marina_building_10_reinforcements";
    fe [[ f ]]( s, us, cf, ( -32371, 9298.24, 958 ), ( 0, 0, 0 ), undefined, "MERC_STRONGHOLD_MARINA_BUILDING_10", "s_safe_reinforce", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    fe [[ f ]]( s, us, cf, ( -32250.1, 8301.12, 976 ), ( 0, 0, 0 ), "MERC_STRONGHOLD_D_MARINA_BUILDING_10_main", "MERC_STRONGHOLD_MARINA_BUILDING_10", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    s.script_parameters = "auto_floor_3_saferoom";
    fe [[ f ]]( s, us, cf, ( -31492.8, 8330.19, 1328 ), ( 0, 190, 0 ), undefined, "MERC_STRONGHOLD_MARINA_BUILDING_10", "s_safe_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_d_ob_activities_merc_stronghold_cs / namespace_40aba0a58a4fa597
// Params 0
// Checksum 0x0, Offset: 0xd21
// Size: 0xbc8
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
    instancestruct.cf = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    instancestruct.scriptstructorigin = ( -32953.3, 14933.8, 1388.4 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.var_5b156d1fa702b37f = [];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationorigin = [ ( -32953.3, 14933.8, 950.75 ) ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationradius = [ 1600 ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_approach" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_approach" ].locationorigin = [ ( -32953.3, 14933.8, 950.75 ) ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_approach" ].locationradius = [ 2000 ];
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ].locationorigin = [ ( -32953.3, 14933.8, 950.75 ) ];
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ].locationradius = [ 500 ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationorigin = [ ( -32953.3, 14933.8, 950.75 ) ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationradius = [ 1100 ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_nokey" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_nokey" ].locationorigin = [ ( -32953.3, 14933.8, 950.75 ) ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_nokey" ].locationradius = [ 450 ];
    instancestruct.locationorigin = [ ( -32953.3, 14933.8, 950.75 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1600 ];
    activityinstances[ "MERC_STRONGHOLD_D_HOUSE_MD_08" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
    instancestruct.cf = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    instancestruct.scriptstructorigin = ( -21569.2, 8473.81, 2780.68 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.var_5b156d1fa702b37f = [];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationorigin = [ ( -21569.2, 8473.81, 2380.68 ) ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationradius = [ 1500 ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_approach" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_approach" ].locationorigin = [ ( -21569.2, 8473.81, 2380.68 ) ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_approach" ].locationradius = [ 2000 ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_nokey" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_nokey" ].locationorigin = [ ( -21569.2, 8473.81, 2380.68 ) ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_nokey" ].locationradius = [ 400 ];
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ].locationorigin = [ ( -21569.2, 8473.81, 2380.68 ) ];
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ].locationradius = [ 500 ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationorigin = [ ( -21569.2, 8473.81, 2380.68 ) ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationradius = [ 1000 ];
    instancestruct.locationorigin = [ ( -21569.2, 8473.81, 2380.68 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1500 ];
    activityinstances[ "MERC_STRONGHOLD_D_HOUSE_MD_03" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
    instancestruct.cf = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    instancestruct.scriptstructorigin = ( -19268.4, 9219.47, 2415.51 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.var_5b156d1fa702b37f = [];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationorigin = [ ( -19268.4, 9219.47, 1977.75 ) ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationradius = [ 1700 ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_approach" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_approach" ].locationorigin = [ ( -19268.4, 9219.47, 1977.75 ) ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_approach" ].locationradius = [ 2000 ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_nokey" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_nokey" ].locationorigin = [ ( -19268.4, 9219.47, 1977.75 ) ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_nokey" ].locationradius = [ 450 ];
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ].locationorigin = [ ( -19268.4, 9219.47, 1977.75 ) ];
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ].locationradius = [ 500 ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationorigin = [ ( -19268.4, 9219.47, 1977.75 ) ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationradius = [ 1200 ];
    instancestruct.locationorigin = [ ( -19268.4, 9219.47, 1977.75 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1700 ];
    activityinstances[ "MERC_STRONGHOLD_D_HOUSE_MD_08_2" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
    instancestruct.cf = "mp_jup_st_d_ob_activities_merc_stronghold_cs";
    instancestruct.scriptstructorigin = ( -32250.1, 8301.12, 1883 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.var_5b156d1fa702b37f = [];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationorigin = [ ( -32250.1, 8301.12, 976 ) ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationradius = [ 1700 ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_approach" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_approach" ].locationorigin = [ ( -32250.1, 8301.12, 976 ) ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_approach" ].locationradius = [ 2000 ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_nokey" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_nokey" ].locationorigin = [ ( -32250.1, 8301.12, 976 ) ];
    instancestruct.var_5b156d1fa702b37f[ "handler_comms_nokey" ].locationradius = [ 700 ];
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ].locationorigin = [ ( -32250.1, 8301.12, 976 ) ];
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ].locationradius = [ 1000 ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationorigin = [ ( -32250.1, 8301.12, 976 ) ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationradius = [ 1200 ];
    instancestruct.locationorigin = [ ( -32250.1, 8301.12, 976 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1700 ];
    activityinstances[ "MERC_STRONGHOLD_D_MARINA_BUILDING_10" ] = instancestruct;
    return activityinstances;
}

