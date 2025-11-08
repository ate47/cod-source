#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_e_ob_objective_sabotage_cs;

// Namespace mp_jup_st_e_ob_objective_sabotage_cs / namespace_d881f3cd8b40cc99
// Params 2
// Checksum 0x0, Offset: 0x1c1
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_e_ob_objective_sabotage_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_e_ob_objective_sabotage_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_e_ob_objective_sabotage_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_e_ob_objective_sabotage_cs / namespace_d881f3cd8b40cc99
// Params 3
// Checksum 0x0, Offset: 0x236
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_e_ob_objective_sabotage_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_e_ob_objective_sabotage_cs" );
}

// Namespace mp_jup_st_e_ob_objective_sabotage_cs / namespace_d881f3cd8b40cc99
// Params 3
// Checksum 0x0, Offset: 0x2a5
// Size: 0x8d6
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 16426, 4988, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 15792, 4342, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 17024, 5750, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 15250, 3476, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 14636, 2504, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 14142, 1652, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 13706, 800, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 13220, -8, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 12634, -1028, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 12178, -2014, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 12024, -2928, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 500 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 11722, -3730, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 11592, -4338, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 11464, -4884, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 11374, -5396, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 11280, -5960, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 11178, -6546, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 11098, -7074, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 11054, -7646, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 11006, -8200, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 10968, -8936, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 10980, -9536, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 10964, -9960, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 10944, -10446, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 10924, -10846, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 10912, -11346, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 10896, -11888, 2364 ), ( 0, 0, 0 ), "s_ob_overpass_supress", undefined, undefined, undefined, undefined, undefined, undefined, 300 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 29140, -5474, 3168 ), ( 0, 0, 0 ), "s_ob_infil_supress", undefined, undefined, undefined, undefined, undefined, undefined, 5000 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 26802, -12730, 3168 ), ( 0, 0, 0 ), "s_ob_infil_supress", undefined, undefined, undefined, undefined, undefined, undefined, 5000 );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 30766, 2594, 3168 ), ( 0, 0, 0 ), "s_ob_infil_supress", undefined, undefined, undefined, undefined, undefined, undefined, 5000 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_e_ob_objective_sabotage_cs / namespace_d881f3cd8b40cc99
// Params 0
// Checksum 0x0, Offset: 0xb83
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_e_ob_objective_sabotage_cs / namespace_d881f3cd8b40cc99
// Params 0
// Checksum 0x0, Offset: 0xb8d
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_e_ob_objective_sabotage_cs" );
}

// Namespace mp_jup_st_e_ob_objective_sabotage_cs / namespace_d881f3cd8b40cc99
// Params 0
// Checksum 0x0, Offset: 0xba3
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_SABOTAGE";
    activityinfostruct.scriptbundle = "jup_activitydef_sabotage";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_e_ob_objective_sabotage_cs / namespace_d881f3cd8b40cc99
// Params 4
// Checksum 0x0, Offset: 0xc15
// Size: 0x51
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_e_ob_objective_sabotage_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_bdfe09a07565151":
            function_11a4db86056e6a96( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_e_ob_objective_sabotage_cs / namespace_d881f3cd8b40cc99
// Params 3
// Checksum 0x0, Offset: 0xc6e
// Size: 0x96
function function_11a4db86056e6a96( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_objective_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 15338, -13078, 1919.5 ), ( 0, 246, 0 ), "activity_nexus_instance_joiner", undefined, "SABOTAGE_LOWTOWN_PARK", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_e_ob_objective_sabotage_cs / namespace_d881f3cd8b40cc99
// Params 0
// Checksum 0x0, Offset: 0xd0c
// Size: 0x232
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_sabotage";
    instancestruct.cf = "mp_jup_st_e_ob_objective_sabotage_cs";
    instancestruct.scriptstructorigin = ( 14852, -8220, 1972 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.var_5b156d1fa702b37f = [];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationorigin = [ ( 14848, -8128, 1692 ) ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationradius = [ 4000 ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationorigin = [ ( 14848, -8128, 1692 ) ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationradius = [ 2000 ];
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ].locationorigin = [ ( 14856, -8128, 1692.23 ) ];
    instancestruct.var_5b156d1fa702b37f[ "ai_exclusion_radius" ].locationradius = [ 2000 ];
    instancestruct.locationorigin = [ ( 14852, -8128, 1692 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 2000 ];
    activityinstances[ "SABOTAGE_LOWTOWN_PARK" ] = instancestruct;
    return activityinstances;
}

