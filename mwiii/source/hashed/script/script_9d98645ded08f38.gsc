#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs;

// Namespace mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs / namespace_1a9235f87b9d6ba4
// Params 2
// Checksum 0x0, Offset: 0x1aa
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs / namespace_1a9235f87b9d6ba4
// Params 3
// Checksum 0x0, Offset: 0x21f
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs" );
}

// Namespace mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs / namespace_1a9235f87b9d6ba4
// Params 3
// Checksum 0x0, Offset: 0x28e
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs / namespace_1a9235f87b9d6ba4
// Params 0
// Checksum 0x0, Offset: 0x2d6
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs / namespace_1a9235f87b9d6ba4
// Params 0
// Checksum 0x0, Offset: 0x2e0
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs" );
}

// Namespace mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs / namespace_1a9235f87b9d6ba4
// Params 0
// Checksum 0x0, Offset: 0x2f6
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

// Namespace mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs / namespace_1a9235f87b9d6ba4
// Params 4
// Checksum 0x0, Offset: 0x368
// Size: 0x9c
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_df5701cd1612ce66":
            function_586d0cd32d7da701( fe, us, cf );
            break;
        case #"hash_222b1579dc1a12e5":
            function_41209ca58bab1b6e( fe, us, cf );
            break;
        case #"hash_407821dcace6477c":
            function_88824945e92dd84d( fe, us, cf );
            break;
        case #"hash_d823082c48faa0c2":
            function_6c074ffcf979041d( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs / namespace_1a9235f87b9d6ba4
// Params 3
// Checksum 0x0, Offset: 0x40c
// Size: 0x2c
function function_586d0cd32d7da701( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs / namespace_1a9235f87b9d6ba4
// Params 3
// Checksum 0x0, Offset: 0x440
// Size: 0x2c
function function_41209ca58bab1b6e( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs / namespace_1a9235f87b9d6ba4
// Params 3
// Checksum 0x0, Offset: 0x474
// Size: 0x2c
function function_88824945e92dd84d( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs / namespace_1a9235f87b9d6ba4
// Params 3
// Checksum 0x0, Offset: 0x4a8
// Size: 0x2c
function function_6c074ffcf979041d( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs / namespace_1a9235f87b9d6ba4
// Params 0
// Checksum 0x0, Offset: 0x4dc
// Size: 0x360
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 9285.25, 10571.3, 1857.5 );
    instancestruct.locationorigin = [ ( 0, 0, 0 ) ];
    instancestruct.locationoriginoffset = [ ( 9285.25, 10571.3, 1857.5 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_OLDTOWN_HILL" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 15344.5, 8205.5, 1817.44 );
    instancestruct.locationorigin = [ ( 0, 0, 0 ) ];
    instancestruct.locationoriginoffset = [ ( 15344.5, 8205.5, 1817.44 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_OLDTOWN_MARKET" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 4834.5, 9648.5, 1471 );
    instancestruct.locationorigin = [ ( 0, 0, 0 ) ];
    instancestruct.locationoriginoffset = [ ( 4834.5, 9648.5, 1471 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_OLDTOWN_COURTYARD" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_e_ob_activity_oldtown_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -172.5, -6470.5, 1655 );
    instancestruct.locationorigin = [ ( 0, 0, 0 ) ];
    instancestruct.locationoriginoffset = [ ( -172.5, -6470.5, 1655 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_OLDTOWN_SQUARE" ] = instancestruct;
    return activityinstances;
}

