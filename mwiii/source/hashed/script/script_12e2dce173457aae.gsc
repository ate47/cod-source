#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_g_ob_activities_harvesterorb_cs;

// Namespace mp_jup_st_g_ob_activities_harvesterorb_cs / namespace_6b2ee003edbf821e
// Params 2
// Checksum 0x0, Offset: 0x15f
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_g_ob_activities_harvesterorb_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_g_ob_activities_harvesterorb_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_g_ob_activities_harvesterorb_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_g_ob_activities_harvesterorb_cs / namespace_6b2ee003edbf821e
// Params 3
// Checksum 0x0, Offset: 0x1d4
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_g_ob_activities_harvesterorb_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_g_ob_activities_harvesterorb_cs" );
}

// Namespace mp_jup_st_g_ob_activities_harvesterorb_cs / namespace_6b2ee003edbf821e
// Params 3
// Checksum 0x0, Offset: 0x243
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_g_ob_activities_harvesterorb_cs / namespace_6b2ee003edbf821e
// Params 0
// Checksum 0x0, Offset: 0x28b
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_g_ob_activities_harvesterorb_cs / namespace_6b2ee003edbf821e
// Params 0
// Checksum 0x0, Offset: 0x295
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_g_ob_activities_harvesterorb_cs" );
}

// Namespace mp_jup_st_g_ob_activities_harvesterorb_cs / namespace_6b2ee003edbf821e
// Params 0
// Checksum 0x0, Offset: 0x2ab
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

// Namespace mp_jup_st_g_ob_activities_harvesterorb_cs / namespace_6b2ee003edbf821e
// Params 4
// Checksum 0x0, Offset: 0x31d
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_g_ob_activities_harvesterorb_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_c1bda016bd45b5ef":
            function_9065ede5f4e9eea4( fe, us, cf );
            break;
        case #"hash_460ef1d228381170":
            function_4a3bb46304df2113( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_g_ob_activities_harvesterorb_cs / namespace_6b2ee003edbf821e
// Params 3
// Checksum 0x0, Offset: 0x38f
// Size: 0x2c
function function_9065ede5f4e9eea4( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_g_ob_activities_harvesterorb_cs / namespace_6b2ee003edbf821e
// Params 3
// Checksum 0x0, Offset: 0x3c3
// Size: 0x2c
function function_4a3bb46304df2113( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_g_ob_activities_harvesterorb_cs / namespace_6b2ee003edbf821e
// Params 0
// Checksum 0x0, Offset: 0x3f7
// Size: 0x148
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_g_ob_activities_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -25210.5, -30753, 1956 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "HARVESTERORB_G_STORES" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_g_ob_activities_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -889.5, -21135.5, 1719.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "HARVESTERORB_G_INTERSECTION" ] = instancestruct;
    return activityinstances;
}

