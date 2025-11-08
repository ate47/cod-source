#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_i_ob_activities_harvesterorb_cs;

// Namespace mp_jup_st_i_ob_activities_harvesterorb_cs / namespace_dc0360d472e0c7d2
// Params 2
// Checksum 0x0, Offset: 0x18d
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_i_ob_activities_harvesterorb_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_i_ob_activities_harvesterorb_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_i_ob_activities_harvesterorb_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_i_ob_activities_harvesterorb_cs / namespace_dc0360d472e0c7d2
// Params 3
// Checksum 0x0, Offset: 0x202
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_i_ob_activities_harvesterorb_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_i_ob_activities_harvesterorb_cs" );
}

// Namespace mp_jup_st_i_ob_activities_harvesterorb_cs / namespace_dc0360d472e0c7d2
// Params 3
// Checksum 0x0, Offset: 0x271
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_i_ob_activities_harvesterorb_cs / namespace_dc0360d472e0c7d2
// Params 0
// Checksum 0x0, Offset: 0x2b9
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_i_ob_activities_harvesterorb_cs / namespace_dc0360d472e0c7d2
// Params 0
// Checksum 0x0, Offset: 0x2c3
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_i_ob_activities_harvesterorb_cs" );
}

// Namespace mp_jup_st_i_ob_activities_harvesterorb_cs / namespace_dc0360d472e0c7d2
// Params 0
// Checksum 0x0, Offset: 0x2d9
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_HARVESTERORB";
    activityinfostruct.scriptbundle = "jup_activitydef_harvesterorb";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_i_ob_activities_harvesterorb_cs / namespace_dc0360d472e0c7d2
// Params 4
// Checksum 0x0, Offset: 0x34b
// Size: 0x9c
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_i_ob_activities_harvesterorb_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_a82e8f767105f4fe":
            function_829f730562e61e01( fe, us, cf );
            break;
        case #"hash_6860270b3dbb29bf":
            function_ecc760a94a8b448e( fe, us, cf );
            break;
        case #"hash_ea6cd2e8bcad3ef":
            function_e0e9e7d212babf00( fe, us, cf );
            break;
        case #"hash_aec59684a5420228":
            function_52eae543c17f3be9( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_i_ob_activities_harvesterorb_cs / namespace_dc0360d472e0c7d2
// Params 3
// Checksum 0x0, Offset: 0x3ef
// Size: 0x2c
function function_829f730562e61e01( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_i_ob_activities_harvesterorb_cs / namespace_dc0360d472e0c7d2
// Params 3
// Checksum 0x0, Offset: 0x423
// Size: 0x2c
function function_ecc760a94a8b448e( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_i_ob_activities_harvesterorb_cs / namespace_dc0360d472e0c7d2
// Params 3
// Checksum 0x0, Offset: 0x457
// Size: 0x2c
function function_e0e9e7d212babf00( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_i_ob_activities_harvesterorb_cs / namespace_dc0360d472e0c7d2
// Params 3
// Checksum 0x0, Offset: 0x48b
// Size: 0x2c
function function_52eae543c17f3be9( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_i_ob_activities_harvesterorb_cs / namespace_dc0360d472e0c7d2
// Params 0
// Checksum 0x0, Offset: 0x4bf
// Size: 0x278
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_i_ob_activities_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 39488, -22959.5, 3128 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "HARVESTERORB_I_ISLAND" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_i_ob_activities_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 35375.8, -34721.8, 3019.25 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "HARVESTERORB_I_RAINMAKER" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_i_ob_activities_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 20178.5, -35989, 3032 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "HARVESTERORB_I_FOUNTAIN" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_i_ob_activities_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 19860, -21764.5, 2896 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "HARVESTERORB_I_GAS" ] = instancestruct;
    return activityinstances;
}

