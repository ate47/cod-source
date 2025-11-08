#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_h_ob_activities_harvesterorb_cs;

// Namespace mp_jup_st_h_ob_activities_harvesterorb_cs / namespace_8af12f224e087be
// Params 2
// Checksum 0x0, Offset: 0x17b
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_h_ob_activities_harvesterorb_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_h_ob_activities_harvesterorb_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_h_ob_activities_harvesterorb_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_h_ob_activities_harvesterorb_cs / namespace_8af12f224e087be
// Params 3
// Checksum 0x0, Offset: 0x1f0
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_h_ob_activities_harvesterorb_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_h_ob_activities_harvesterorb_cs" );
}

// Namespace mp_jup_st_h_ob_activities_harvesterorb_cs / namespace_8af12f224e087be
// Params 3
// Checksum 0x0, Offset: 0x25f
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_h_ob_activities_harvesterorb_cs / namespace_8af12f224e087be
// Params 0
// Checksum 0x0, Offset: 0x2a7
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_h_ob_activities_harvesterorb_cs / namespace_8af12f224e087be
// Params 0
// Checksum 0x0, Offset: 0x2b1
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_h_ob_activities_harvesterorb_cs" );
}

// Namespace mp_jup_st_h_ob_activities_harvesterorb_cs / namespace_8af12f224e087be
// Params 0
// Checksum 0x0, Offset: 0x2c7
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_HARVESTERORB";
    activityinfostruct.scriptbundle = "jup_activitydefinition_bigbounty";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_h_ob_activities_harvesterorb_cs / namespace_8af12f224e087be
// Params 4
// Checksum 0x0, Offset: 0x339
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_h_ob_activities_harvesterorb_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_1f903193b28af892":
            function_6aabf6e43f001493( fe, us, cf );
            break;
        case #"hash_4fc43c9532bf48de":
            function_251ffada7c6e815b( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_h_ob_activities_harvesterorb_cs / namespace_8af12f224e087be
// Params 3
// Checksum 0x0, Offset: 0x3ab
// Size: 0x2c
function function_6aabf6e43f001493( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_h_ob_activities_harvesterorb_cs / namespace_8af12f224e087be
// Params 3
// Checksum 0x0, Offset: 0x3df
// Size: 0x2c
function function_251ffada7c6e815b( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_h_ob_activities_harvesterorb_cs / namespace_8af12f224e087be
// Params 0
// Checksum 0x0, Offset: 0x413
// Size: 0x148
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_h_ob_activities_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 15324, -31020.5, 2464.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "HARVESTERORB_H_SHACK" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_h_ob_activities_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -1991, -37088.5, 2136.49 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "HARVESTERORB_H_VILLA" ] = instancestruct;
    return activityinstances;
}

