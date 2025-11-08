#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_b_ob_activities_armored_convoy_cs;

// Namespace mp_jup_st_b_ob_activities_armored_convoy_cs / namespace_12edc63bc711f740
// Params 2
// Checksum 0x0, Offset: 0x166
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_b_ob_activities_armored_convoy_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_b_ob_activities_armored_convoy_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_b_ob_activities_armored_convoy_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_b_ob_activities_armored_convoy_cs / namespace_12edc63bc711f740
// Params 3
// Checksum 0x0, Offset: 0x1db
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_b_ob_activities_armored_convoy_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_b_ob_activities_armored_convoy_cs" );
}

// Namespace mp_jup_st_b_ob_activities_armored_convoy_cs / namespace_12edc63bc711f740
// Params 3
// Checksum 0x0, Offset: 0x24a
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_b_ob_activities_armored_convoy_cs / namespace_12edc63bc711f740
// Params 0
// Checksum 0x0, Offset: 0x292
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_b_ob_activities_armored_convoy_cs / namespace_12edc63bc711f740
// Params 0
// Checksum 0x0, Offset: 0x29c
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_ARMORED_CONVOY";
    activityinfostruct.scriptbundle = "jup_activitydefinition_armoredconvoy";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_b_ob_activities_armored_convoy_cs / namespace_12edc63bc711f740
// Params 4
// Checksum 0x0, Offset: 0x30e
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_b_ob_activities_armored_convoy_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_ee8b364ba9389f11":
            function_3efb722a7ca1b9a0( fe, us, cf );
            break;
        case #"hash_43715d18b3ffc64f":
            function_37bf948c9b93d0e8( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_b_ob_activities_armored_convoy_cs / namespace_12edc63bc711f740
// Params 3
// Checksum 0x0, Offset: 0x380
// Size: 0x2c
function function_3efb722a7ca1b9a0( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_b_ob_activities_armored_convoy_cs / namespace_12edc63bc711f740
// Params 3
// Checksum 0x0, Offset: 0x3b4
// Size: 0x2c
function function_37bf948c9b93d0e8( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_b_ob_activities_armored_convoy_cs / namespace_12edc63bc711f740
// Params 0
// Checksum 0x0, Offset: 0x3e8
// Size: 0x148
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_armoredconvoy";
    instancestruct.cf = "mp_jup_st_b_ob_activities_armored_convoy_cs";
    instancestruct.scriptstructorigin = ( 6462, 31699, 1200 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "ARMORED_CONVOY_B_NORTH" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_armoredconvoy";
    instancestruct.cf = "mp_jup_st_b_ob_activities_armored_convoy_cs";
    instancestruct.scriptstructorigin = ( 2696, 16156, 1038.95 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "ARMORED_CONVOY_B_EAST" ] = instancestruct;
    return activityinstances;
}

