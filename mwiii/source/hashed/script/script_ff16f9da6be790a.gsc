#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_hydro_ob_activities_doghouse_cs;

// Namespace mp_jup_hydro_ob_activities_doghouse_cs / namespace_598cc82c0086edc2
// Params 2
// Checksum 0x0, Offset: 0x153
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_hydro_ob_activities_doghouse_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_hydro_ob_activities_doghouse_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_hydro_ob_activities_doghouse_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_hydro_ob_activities_doghouse_cs / namespace_598cc82c0086edc2
// Params 3
// Checksum 0x0, Offset: 0x1c8
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_hydro_ob_activities_doghouse_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_hydro_ob_activities_doghouse_cs" );
}

// Namespace mp_jup_hydro_ob_activities_doghouse_cs / namespace_598cc82c0086edc2
// Params 3
// Checksum 0x0, Offset: 0x237
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_hydro_ob_activities_doghouse_cs / namespace_598cc82c0086edc2
// Params 0
// Checksum 0x0, Offset: 0x27f
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_hydro_ob_activities_doghouse_cs / namespace_598cc82c0086edc2
// Params 0
// Checksum 0x0, Offset: 0x289
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_hydro_ob_activities_doghouse_cs" );
}

// Namespace mp_jup_hydro_ob_activities_doghouse_cs / namespace_598cc82c0086edc2
// Params 0
// Checksum 0x0, Offset: 0x29f
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

// Namespace mp_jup_hydro_ob_activities_doghouse_cs / namespace_598cc82c0086edc2
// Params 4
// Checksum 0x0, Offset: 0x311
// Size: 0x51
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_hydro_ob_activities_doghouse_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_9601e367f2193bde":
            function_6ce4ce19a6ffba5b( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_hydro_ob_activities_doghouse_cs / namespace_598cc82c0086edc2
// Params 3
// Checksum 0x0, Offset: 0x36a
// Size: 0xa7
function function_6ce4ce19a6ffba5b( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_activities_doghouse_cs";
    s.name = "doghouse_scriptable_struct";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "doghouse_scriptable_struct", "DOGHOUSE_HYDRO", undefined, undefined, undefined, ( -15368.1, 6466.68, 625.44 ), ( 0, 330, 0 ) );
}

// Namespace mp_jup_hydro_ob_activities_doghouse_cs / namespace_598cc82c0086edc2
// Params 0
// Checksum 0x0, Offset: 0x419
// Size: 0xb0
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
    instancestruct.cf = "mp_jup_hydro_ob_activities_doghouse_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -15368.1, 6466.68, 625.44 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "DOGHOUSE_HYDRO" ] = instancestruct;
    return activityinstances;
}

