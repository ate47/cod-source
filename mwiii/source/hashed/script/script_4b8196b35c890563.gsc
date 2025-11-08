#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_ob_objectives_doghouse_test_cs;

// Namespace mp_jup_ob_objectives_doghouse_test_cs / namespace_3798ea022950a245
// Params 2
// Checksum 0x0, Offset: 0x182
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_ob_objectives_doghouse_test_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_ob_objectives_doghouse_test_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_ob_objectives_doghouse_test_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_ob_objectives_doghouse_test_cs / namespace_3798ea022950a245
// Params 3
// Checksum 0x0, Offset: 0x1f7
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_ob_objectives_doghouse_test_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_ob_objectives_doghouse_test_cs" );
}

// Namespace mp_jup_ob_objectives_doghouse_test_cs / namespace_3798ea022950a245
// Params 3
// Checksum 0x0, Offset: 0x266
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_ob_objectives_doghouse_test_cs / namespace_3798ea022950a245
// Params 0
// Checksum 0x0, Offset: 0x2ae
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_ob_objectives_doghouse_test_cs / namespace_3798ea022950a245
// Params 0
// Checksum 0x0, Offset: 0x2b8
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

// Namespace mp_jup_ob_objectives_doghouse_test_cs / namespace_3798ea022950a245
// Params 4
// Checksum 0x0, Offset: 0x32a
// Size: 0x51
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_ob_objectives_doghouse_test_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_efc8d0a6f639c084":
            function_3b430d8dde25528b( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_ob_objectives_doghouse_test_cs / namespace_3798ea022950a245
// Params 3
// Checksum 0x0, Offset: 0x383
// Size: 0x149
function function_3b430d8dde25528b( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.name = "vfx";
    fe [[ f ]]( s, us, cf, ( 28, 0.5, 83.5 ), ( 0, 356.12, 0 ), "doghouse_vfx_struct", "DOGHOUSE_TEST", undefined, undefined, undefined, ( 42312.5, 3478.5, 536 ), ( 0, 225.35, 0 ) );
    s = s();
    s.name = "doghouse_scriptable_struct";
    fe [[ f ]]( s, us, cf, ( 57, 0, 0 ), ( 0, 0, 0 ), "doghouse_scriptable_struct", "DOGHOUSE_TEST", undefined, undefined, undefined, ( 42312.5, 3478.5, 536 ), ( 0, 225.35, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( -94.5, -90, 0 ), ( 0, 0, 0 ), "s_doghouse_test", "DOGHOUSE_TEST", undefined, undefined, undefined, ( 42312.5, 3478.5, 536 ), ( 0, 225.35, 0 ) );
}

// Namespace mp_jup_ob_objectives_doghouse_test_cs / namespace_3798ea022950a245
// Params 0
// Checksum 0x0, Offset: 0x4d4
// Size: 0xb0
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_doghouse";
    instancestruct.cf = "mp_jup_ob_objectives_doghouse_test_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 42312.5, 3478.5, 536 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "DOGHOUSE_TEST" ] = instancestruct;
    return activityinstances;
}

