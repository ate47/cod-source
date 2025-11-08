#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_h_ob_interactions_aethertear_cs;

// Namespace mp_jup_st_h_ob_interactions_aethertear_cs / namespace_fd6afd6f37bf7a20
// Params 2
// Checksum 0x0, Offset: 0x16c
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_h_ob_interactions_aethertear_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_h_ob_interactions_aethertear_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_h_ob_interactions_aethertear_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_h_ob_interactions_aethertear_cs / namespace_fd6afd6f37bf7a20
// Params 3
// Checksum 0x0, Offset: 0x1e1
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_h_ob_interactions_aethertear_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_h_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_h_ob_interactions_aethertear_cs / namespace_fd6afd6f37bf7a20
// Params 3
// Checksum 0x0, Offset: 0x250
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_h_ob_interactions_aethertear_cs / namespace_fd6afd6f37bf7a20
// Params 0
// Checksum 0x0, Offset: 0x298
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_h_ob_interactions_aethertear_cs / namespace_fd6afd6f37bf7a20
// Params 0
// Checksum 0x0, Offset: 0x2a2
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_h_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_h_ob_interactions_aethertear_cs / namespace_fd6afd6f37bf7a20
// Params 0
// Checksum 0x0, Offset: 0x2b8
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_AETHERTEAR";
    activityinfostruct.scriptbundle = "jup_activitydefinition_aethertear";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_h_ob_interactions_aethertear_cs / namespace_fd6afd6f37bf7a20
// Params 4
// Checksum 0x0, Offset: 0x32a
// Size: 0x83
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_h_ob_interactions_aethertear_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_ed9cb42d89dd2000":
            function_a453eb3316d8c683( fe, us, cf );
            break;
        case #"hash_9380a8dbe1d7b36a":
            function_37a93beeefe5f4d3( fe, us, cf );
            break;
        case #"hash_373ded237c2596ed":
            function_a83d5af432ee9e46( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_h_ob_interactions_aethertear_cs / namespace_fd6afd6f37bf7a20
// Params 3
// Checksum 0x0, Offset: 0x3b5
// Size: 0x2c
function function_a453eb3316d8c683( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_h_ob_interactions_aethertear_cs / namespace_fd6afd6f37bf7a20
// Params 3
// Checksum 0x0, Offset: 0x3e9
// Size: 0x2c
function function_37a93beeefe5f4d3( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_h_ob_interactions_aethertear_cs / namespace_fd6afd6f37bf7a20
// Params 3
// Checksum 0x0, Offset: 0x41d
// Size: 0x2c
function function_a83d5af432ee9e46( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_h_ob_interactions_aethertear_cs / namespace_fd6afd6f37bf7a20
// Params 0
// Checksum 0x0, Offset: 0x451
// Size: 0x1e0
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_h_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 5081, -13291, 1205 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_H_PIER" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_h_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 12182, -20159, 1485.21 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_H_SEWER" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_h_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -103, -29754, 1779 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_H_BRIDGE" ] = instancestruct;
    return activityinstances;
}

