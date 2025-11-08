#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_ob_objectives_harvesterorb_test_cs;

// Namespace mp_jup_ob_objectives_harvesterorb_test_cs / namespace_bdbb99445177035c
// Params 2
// Checksum 0x0, Offset: 0x154
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_ob_objectives_harvesterorb_test_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_ob_objectives_harvesterorb_test_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_ob_objectives_harvesterorb_test_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_ob_objectives_harvesterorb_test_cs / namespace_bdbb99445177035c
// Params 3
// Checksum 0x0, Offset: 0x1c9
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_ob_objectives_harvesterorb_test_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_ob_objectives_harvesterorb_test_cs" );
}

// Namespace mp_jup_ob_objectives_harvesterorb_test_cs / namespace_bdbb99445177035c
// Params 3
// Checksum 0x0, Offset: 0x238
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_ob_objectives_harvesterorb_test_cs / namespace_bdbb99445177035c
// Params 0
// Checksum 0x0, Offset: 0x280
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_ob_objectives_harvesterorb_test_cs / namespace_bdbb99445177035c
// Params 0
// Checksum 0x0, Offset: 0x28a
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

// Namespace mp_jup_ob_objectives_harvesterorb_test_cs / namespace_bdbb99445177035c
// Params 4
// Checksum 0x0, Offset: 0x2fc
// Size: 0x51
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_ob_objectives_harvesterorb_test_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_747f69dfa3941503":
            function_b4f485feb27d3904( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_ob_objectives_harvesterorb_test_cs / namespace_bdbb99445177035c
// Params 3
// Checksum 0x0, Offset: 0x355
// Size: 0x81
function function_b4f485feb27d3904( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "s_harvester_orb_test", undefined, undefined, undefined, undefined, ( 41890, -1015, 407 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_ob_objectives_harvesterorb_test_cs / namespace_bdbb99445177035c
// Params 0
// Checksum 0x0, Offset: 0x3de
// Size: 0xea
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_ob_objectives_harvesterorb_test_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 41890, -1015, 407 );
    instancestruct.locationorigin = [ ( 0, 0, 0 ) ];
    instancestruct.locationoriginoffset = [ ( 41890, -1015, 407 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_TEST" ] = instancestruct;
    return activityinstances;
}

