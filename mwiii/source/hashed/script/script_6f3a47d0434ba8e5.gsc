#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_g_ob_activities_doghouse_cs;

// Namespace mp_jup_st_g_ob_activities_doghouse_cs / namespace_fdfc3bbf6a182785
// Params 2
// Checksum 0x0, Offset: 0x163
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_g_ob_activities_doghouse_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_g_ob_activities_doghouse_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_g_ob_activities_doghouse_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_g_ob_activities_doghouse_cs / namespace_fdfc3bbf6a182785
// Params 3
// Checksum 0x0, Offset: 0x1d8
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_g_ob_activities_doghouse_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_g_ob_activities_doghouse_cs" );
}

// Namespace mp_jup_st_g_ob_activities_doghouse_cs / namespace_fdfc3bbf6a182785
// Params 3
// Checksum 0x0, Offset: 0x247
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_g_ob_activities_doghouse_cs / namespace_fdfc3bbf6a182785
// Params 0
// Checksum 0x0, Offset: 0x28f
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_g_ob_activities_doghouse_cs / namespace_fdfc3bbf6a182785
// Params 0
// Checksum 0x0, Offset: 0x299
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_g_ob_activities_doghouse_cs" );
}

// Namespace mp_jup_st_g_ob_activities_doghouse_cs / namespace_fdfc3bbf6a182785
// Params 0
// Checksum 0x0, Offset: 0x2af
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

// Namespace mp_jup_st_g_ob_activities_doghouse_cs / namespace_fdfc3bbf6a182785
// Params 4
// Checksum 0x0, Offset: 0x321
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_g_ob_activities_doghouse_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_b8ef85434ba18646":
            function_e36be14a04dfa009( fe, us, cf );
            break;
        case #"hash_f5537fcd1fad3a79":
            function_73f2581e4f3f6cd0( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_g_ob_activities_doghouse_cs / namespace_fdfc3bbf6a182785
// Params 3
// Checksum 0x0, Offset: 0x393
// Size: 0xa7
function function_e36be14a04dfa009( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_doghouse_cs";
    s.name = "doghouse_scriptable_struct";
    fe [[ f ]]( s, us, cf, ( 57, 0, 0 ), ( 0, 0, 0 ), "doghouse_scriptable_struct", "DOGHOUSE_G_PARK", undefined, undefined, undefined, ( -2595.5, -17033, 1713.5 ), ( 0, 228.92, 0 ) );
}

// Namespace mp_jup_st_g_ob_activities_doghouse_cs / namespace_fdfc3bbf6a182785
// Params 3
// Checksum 0x0, Offset: 0x442
// Size: 0xa7
function function_73f2581e4f3f6cd0( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_doghouse_cs";
    s.name = "doghouse_scriptable_struct";
    fe [[ f ]]( s, us, cf, ( 57, 0, 0 ), ( 0, 0, 0 ), "doghouse_scriptable_struct", "DOGHOUSE_G_APT", undefined, undefined, undefined, ( -34004, -29206, 1194 ), ( 0, 65.02, 0 ) );
}

// Namespace mp_jup_st_g_ob_activities_doghouse_cs / namespace_fdfc3bbf6a182785
// Params 0
// Checksum 0x0, Offset: 0x4f1
// Size: 0x148
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
    instancestruct.cf = "mp_jup_st_g_ob_activities_doghouse_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -2595.5, -17033, 1713.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "DOGHOUSE_G_PARK" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
    instancestruct.cf = "mp_jup_st_g_ob_activities_doghouse_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -34004, -29206, 1194 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "DOGHOUSE_G_APT" ] = instancestruct;
    return activityinstances;
}

