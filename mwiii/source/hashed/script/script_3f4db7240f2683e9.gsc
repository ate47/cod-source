#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_a_ob_activities_doghouse_cs;

// Namespace mp_jup_st_a_ob_activities_doghouse_cs / namespace_bdf6f22a57667e71
// Params 2
// Checksum 0x0, Offset: 0x16f
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_a_ob_activities_doghouse_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_a_ob_activities_doghouse_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_a_ob_activities_doghouse_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_a_ob_activities_doghouse_cs / namespace_bdf6f22a57667e71
// Params 3
// Checksum 0x0, Offset: 0x1e4
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_a_ob_activities_doghouse_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_a_ob_activities_doghouse_cs" );
}

// Namespace mp_jup_st_a_ob_activities_doghouse_cs / namespace_bdf6f22a57667e71
// Params 3
// Checksum 0x0, Offset: 0x253
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_a_ob_activities_doghouse_cs / namespace_bdf6f22a57667e71
// Params 0
// Checksum 0x0, Offset: 0x29b
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_a_ob_activities_doghouse_cs / namespace_bdf6f22a57667e71
// Params 0
// Checksum 0x0, Offset: 0x2a5
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_a_ob_activities_doghouse_cs" );
}

// Namespace mp_jup_st_a_ob_activities_doghouse_cs / namespace_bdf6f22a57667e71
// Params 0
// Checksum 0x0, Offset: 0x2bb
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

// Namespace mp_jup_st_a_ob_activities_doghouse_cs / namespace_bdf6f22a57667e71
// Params 4
// Checksum 0x0, Offset: 0x32d
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_a_ob_activities_doghouse_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_bed6c660c4d87ecd":
            function_a47c01f80043fbf0( fe, us, cf );
            break;
        case #"hash_29a6b07afab7c029":
            function_b052722819b1ff3e( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_a_ob_activities_doghouse_cs / namespace_bdf6f22a57667e71
// Params 3
// Checksum 0x0, Offset: 0x39f
// Size: 0xa7
function function_a47c01f80043fbf0( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_activities_doghouse_cs";
    s.name = "doghouse_scriptable_struct";
    fe [[ f ]]( s, us, cf, ( 57, 0, 0 ), ( 0, 0, 0 ), "doghouse_scriptable_struct", "DOGHOUSE_A_POWER", undefined, undefined, undefined, ( -13397.5, 34027.5, 2664 ), ( 0, 180.34, 0 ) );
}

// Namespace mp_jup_st_a_ob_activities_doghouse_cs / namespace_bdf6f22a57667e71
// Params 3
// Checksum 0x0, Offset: 0x44e
// Size: 0xa7
function function_b052722819b1ff3e( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_activities_doghouse_cs";
    s.name = "doghouse_scriptable_struct";
    fe [[ f ]]( s, us, cf, ( 57, 0, 0 ), ( 0, 0, 0 ), "doghouse_scriptable_struct", "DOGHOUSE_A_CONSTRUCTION", undefined, undefined, undefined, ( -31410.5, 14049.5, 983.5 ), ( 0, 84.81, 0 ) );
}

// Namespace mp_jup_st_a_ob_activities_doghouse_cs / namespace_bdf6f22a57667e71
// Params 0
// Checksum 0x0, Offset: 0x4fd
// Size: 0x148
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
    instancestruct.cf = "mp_jup_st_a_ob_activities_doghouse_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -13397.5, 34027.5, 2664 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "DOGHOUSE_A_POWER" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
    instancestruct.cf = "mp_jup_st_a_ob_activities_doghouse_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -31410.5, 14049.5, 983.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "DOGHOUSE_A_CONSTRUCTION" ] = instancestruct;
    return activityinstances;
}

