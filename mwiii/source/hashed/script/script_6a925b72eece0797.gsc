#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_f_ob_contracts_sabotage_cs;

// Namespace mp_jup_st_f_ob_contracts_sabotage_cs / namespace_7f1f62d616986645
// Params 2
// Checksum 0x0, Offset: 0x1b5
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_f_ob_contracts_sabotage_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_f_ob_contracts_sabotage_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_f_ob_contracts_sabotage_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_f_ob_contracts_sabotage_cs / namespace_7f1f62d616986645
// Params 3
// Checksum 0x0, Offset: 0x22a
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_f_ob_contracts_sabotage_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_f_ob_contracts_sabotage_cs" );
}

// Namespace mp_jup_st_f_ob_contracts_sabotage_cs / namespace_7f1f62d616986645
// Params 3
// Checksum 0x0, Offset: 0x299
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_f_ob_contracts_sabotage_cs / namespace_7f1f62d616986645
// Params 0
// Checksum 0x0, Offset: 0x2e1
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_f_ob_contracts_sabotage_cs / namespace_7f1f62d616986645
// Params 0
// Checksum 0x0, Offset: 0x2eb
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_f_ob_contracts_sabotage_cs" );
}

// Namespace mp_jup_st_f_ob_contracts_sabotage_cs / namespace_7f1f62d616986645
// Params 0
// Checksum 0x0, Offset: 0x301
// Size: 0x58
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_SABOTAGE";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_f_ob_contracts_sabotage_cs / namespace_7f1f62d616986645
// Params 4
// Checksum 0x0, Offset: 0x362
// Size: 0x83
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_f_ob_contracts_sabotage_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_8d70c8d760b6b3db":
            function_940943f879d1904a( fe, us, cf );
            break;
        case #"hash_6919a3480a5d2ae8":
            function_a7cc86d583a3a9ed( fe, us, cf );
            break;
        case #"hash_7c81c1302cc530d0":
            function_1dcb8dfab5207759( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_f_ob_contracts_sabotage_cs / namespace_7f1f62d616986645
// Params 3
// Checksum 0x0, Offset: 0x3ed
// Size: 0x96
function function_940943f879d1904a( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_contracts_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 44231.5, -10550, 2888.94 ), ( 356.77, 94.1, 1.79 ), "activity_nexus_instance_joiner", undefined, "SABOTAGE_F_FARM_EAST", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_f_ob_contracts_sabotage_cs / namespace_7f1f62d616986645
// Params 3
// Checksum 0x0, Offset: 0x48b
// Size: 0x96
function function_a7cc86d583a3a9ed( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_contracts_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 34181.5, 6804, 2344.25 ), ( 0, 295.36, 0 ), "activity_nexus_instance_joiner", undefined, "SABOTAGE_F_ABANDONED_VILLAGE", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_f_ob_contracts_sabotage_cs / namespace_7f1f62d616986645
// Params 3
// Checksum 0x0, Offset: 0x529
// Size: 0x96
function function_1dcb8dfab5207759( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_contracts_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 31076, -5750.5, 2989.1 ), ( 356.35, 24.41, -1.52 ), "activity_nexus_instance_joiner", undefined, "SABOTAGE_F_MARKETPLACE", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_f_ob_contracts_sabotage_cs / namespace_7f1f62d616986645
// Params 0
// Checksum 0x0, Offset: 0x5c7
// Size: 0x52b
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_sabotage";
    instancestruct.cf = "mp_jup_st_f_ob_contracts_sabotage_cs";
    instancestruct.scriptstructorigin = ( 44705, -1964.5, 3068.26 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.var_5b156d1fa702b37f = [];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationorigin = [ ( 44709, -1964.5, 3067.8 ) ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationradius = [ 3000 ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationorigin = [ ( 44717, -1962.5, 3066.84 ) ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationradius = [ 5000 ];
    instancestruct.locationorigin = [ ( 44709, -1980, 3068.19 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 3000 ];
    activityinstances[ "SABOTAGE_F_FARM_EAST" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_sabotage";
    instancestruct.cf = "mp_jup_st_f_ob_contracts_sabotage_cs";
    instancestruct.scriptstructorigin = ( 40520, 12202, 3074 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.var_5b156d1fa702b37f = [];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationorigin = [ ( 40512, 12204, 3074 ) ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationradius = [ 3000 ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationorigin = [ ( 40530, 12204, 3074 ) ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationradius = [ 5000 ];
    instancestruct.locationorigin = [ ( 40534, 12196, 3074 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 3000 ];
    activityinstances[ "SABOTAGE_F_ABANDONED_VILLAGE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_sabotage";
    instancestruct.cf = "mp_jup_st_f_ob_contracts_sabotage_cs";
    instancestruct.scriptstructorigin = ( 33627.5, -12058, 2936.5 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.var_5b156d1fa702b37f = [];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationorigin = [ ( 33627.5, -12058, 2936.5 ) ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationradius = [ 3500 ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationorigin = [ ( 33627.5, -12058, 2936.5 ) ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationradius = [ 5000 ];
    instancestruct.locationorigin = [ ( 33627.5, -12058, 2936.5 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 3000 ];
    activityinstances[ "SABOTAGE_F_MARKETPLACE" ] = instancestruct;
    return activityinstances;
}

