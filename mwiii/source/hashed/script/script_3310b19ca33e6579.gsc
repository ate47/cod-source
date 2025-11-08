#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_b_ob_activities_doghouse_cs;

// Namespace mp_jup_st_b_ob_activities_doghouse_cs / namespace_ad2316c62db96c41
// Params 2
// Checksum 0x0, Offset: 0x181
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_b_ob_activities_doghouse_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_b_ob_activities_doghouse_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_b_ob_activities_doghouse_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_b_ob_activities_doghouse_cs / namespace_ad2316c62db96c41
// Params 3
// Checksum 0x0, Offset: 0x1f6
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_b_ob_activities_doghouse_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_b_ob_activities_doghouse_cs" );
}

// Namespace mp_jup_st_b_ob_activities_doghouse_cs / namespace_ad2316c62db96c41
// Params 3
// Checksum 0x0, Offset: 0x265
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_b_ob_activities_doghouse_cs / namespace_ad2316c62db96c41
// Params 0
// Checksum 0x0, Offset: 0x2ad
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_b_ob_activities_doghouse_cs / namespace_ad2316c62db96c41
// Params 0
// Checksum 0x0, Offset: 0x2b7
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_b_ob_activities_doghouse_cs" );
}

// Namespace mp_jup_st_b_ob_activities_doghouse_cs / namespace_ad2316c62db96c41
// Params 0
// Checksum 0x0, Offset: 0x2cd
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_DOGHOUSE";
    activityinfostruct.scriptbundle = "jup_activitydefinition_doghouse";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_b_ob_activities_doghouse_cs / namespace_ad2316c62db96c41
// Params 4
// Checksum 0x0, Offset: 0x33f
// Size: 0x83
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_b_ob_activities_doghouse_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_987da87821c81bc1":
            function_f6aecbbc4ed2314e( fe, us, cf );
            break;
        case #"hash_83c47397ab853dff":
            function_5ec22cc6ba28c668( fe, us, cf );
            break;
        case #"hash_df4ca7b2c01063d2":
            function_a5b07a9a8179cf25( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_b_ob_activities_doghouse_cs / namespace_ad2316c62db96c41
// Params 3
// Checksum 0x0, Offset: 0x3ca
// Size: 0xa7
function function_f6aecbbc4ed2314e( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_doghouse_cs";
    s.name = "doghouse_scriptable_struct";
    fe [[ f ]]( s, us, cf, ( 57, 0, 0 ), ( 0, 0, 0 ), "doghouse_scriptable_struct", "DOGHOUSE_B_JUNKYARD", undefined, undefined, undefined, ( 9023.5, 37708, 1213.29 ), ( 0, 0.84, 0 ) );
}

// Namespace mp_jup_st_b_ob_activities_doghouse_cs / namespace_ad2316c62db96c41
// Params 3
// Checksum 0x0, Offset: 0x479
// Size: 0xa7
function function_5ec22cc6ba28c668( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_doghouse_cs";
    s.name = "doghouse_scriptable_struct";
    fe [[ f ]]( s, us, cf, ( 57, 0, 0 ), ( 0, 0, 0 ), "doghouse_scriptable_struct", "DOGHOUSE_B_OFFICE", undefined, undefined, undefined, ( -6306, 21448, 1000.5 ), ( 0, 72.83, 0 ) );
}

// Namespace mp_jup_st_b_ob_activities_doghouse_cs / namespace_ad2316c62db96c41
// Params 3
// Checksum 0x0, Offset: 0x528
// Size: 0xa7
function function_a5b07a9a8179cf25( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_doghouse_cs";
    s.name = "doghouse_scriptable_struct";
    fe [[ f ]]( s, us, cf, ( 57, 0, 0 ), ( 0, 0, 0 ), "doghouse_scriptable_struct", "DOGHOUSE_B_ISLAND", undefined, undefined, undefined, ( 14133.8, 17203.8, 901.3 ), ( 0, 130.37, 0 ) );
}

// Namespace mp_jup_st_b_ob_activities_doghouse_cs / namespace_ad2316c62db96c41
// Params 0
// Checksum 0x0, Offset: 0x5d7
// Size: 0x1e0
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
    instancestruct.cf = "mp_jup_st_b_ob_activities_doghouse_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 9023.5, 37708, 1213.29 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "DOGHOUSE_B_JUNKYARD" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
    instancestruct.cf = "mp_jup_st_b_ob_activities_doghouse_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -6306, 21448, 1000.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "DOGHOUSE_B_OFFICE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
    instancestruct.cf = "mp_jup_st_b_ob_activities_doghouse_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 14133.8, 17203.8, 901.3 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "DOGHOUSE_B_ISLAND" ] = instancestruct;
    return activityinstances;
}

