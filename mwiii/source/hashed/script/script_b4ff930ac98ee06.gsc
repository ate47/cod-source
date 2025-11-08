#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_d_ob_activities_harvesterorb_cs;

// Namespace mp_jup_st_d_ob_activities_harvesterorb_cs / namespace_412c8d9c4ebfd6e6
// Params 2
// Checksum 0x0, Offset: 0x15b
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_d_ob_activities_harvesterorb_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_d_ob_activities_harvesterorb_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_d_ob_activities_harvesterorb_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_d_ob_activities_harvesterorb_cs / namespace_412c8d9c4ebfd6e6
// Params 3
// Checksum 0x0, Offset: 0x1d0
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_d_ob_activities_harvesterorb_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_d_ob_activities_harvesterorb_cs" );
}

// Namespace mp_jup_st_d_ob_activities_harvesterorb_cs / namespace_412c8d9c4ebfd6e6
// Params 3
// Checksum 0x0, Offset: 0x23f
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_d_ob_activities_harvesterorb_cs / namespace_412c8d9c4ebfd6e6
// Params 0
// Checksum 0x0, Offset: 0x287
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_d_ob_activities_harvesterorb_cs / namespace_412c8d9c4ebfd6e6
// Params 0
// Checksum 0x0, Offset: 0x291
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_d_ob_activities_harvesterorb_cs" );
}

// Namespace mp_jup_st_d_ob_activities_harvesterorb_cs / namespace_412c8d9c4ebfd6e6
// Params 0
// Checksum 0x0, Offset: 0x2a7
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

// Namespace mp_jup_st_d_ob_activities_harvesterorb_cs / namespace_412c8d9c4ebfd6e6
// Params 4
// Checksum 0x0, Offset: 0x319
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_d_ob_activities_harvesterorb_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_53a2d389c8d2dbee":
            function_f748726faf534317( fe, us, cf );
            break;
        case #"hash_224e504fd02f6786":
            function_cfd0b186b0c81be3( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_d_ob_activities_harvesterorb_cs / namespace_412c8d9c4ebfd6e6
// Params 3
// Checksum 0x0, Offset: 0x38b
// Size: 0x2c
function function_f748726faf534317( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_d_ob_activities_harvesterorb_cs / namespace_412c8d9c4ebfd6e6
// Params 3
// Checksum 0x0, Offset: 0x3bf
// Size: 0x2c
function function_cfd0b186b0c81be3( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_d_ob_activities_harvesterorb_cs / namespace_412c8d9c4ebfd6e6
// Params 0
// Checksum 0x0, Offset: 0x3f3
// Size: 0x182
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_d_ob_activities_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -17763, 2182, 1582 );
    instancestruct.locationorigin = [ ( 0, 0, 0 ) ];
    instancestruct.locationoriginoffset = [ ( -17763, 2182, 1582 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_D_OUTSKIRTS" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_d_ob_activities_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -21048.5, -9826.5, 1505 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "HARVESTERORB_D_FIELD" ] = instancestruct;
    return activityinstances;
}

