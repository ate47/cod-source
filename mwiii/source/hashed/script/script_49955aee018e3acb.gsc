#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs;

// Namespace mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs / namespace_60db312ba22882e7
// Params 2
// Checksum 0x0, Offset: 0x16c
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs / namespace_60db312ba22882e7
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
    
    s cs_setup_arrays( us, "mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs" );
}

// Namespace mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs / namespace_60db312ba22882e7
// Params 3
// Checksum 0x0, Offset: 0x250
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs / namespace_60db312ba22882e7
// Params 0
// Checksum 0x0, Offset: 0x298
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs / namespace_60db312ba22882e7
// Params 0
// Checksum 0x0, Offset: 0x2a2
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs" );
}

// Namespace mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs / namespace_60db312ba22882e7
// Params 0
// Checksum 0x0, Offset: 0x2b8
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

// Namespace mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs / namespace_60db312ba22882e7
// Params 4
// Checksum 0x0, Offset: 0x32a
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_151cf5405161f53b":
            function_96d9dec23c889e84( fe, us, cf );
            break;
        case #"hash_b2c30cbc103db9d8":
            function_52d640400ae605fd( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs / namespace_60db312ba22882e7
// Params 3
// Checksum 0x0, Offset: 0x39c
// Size: 0x2c
function function_96d9dec23c889e84( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs / namespace_60db312ba22882e7
// Params 3
// Checksum 0x0, Offset: 0x3d0
// Size: 0x2c
function function_52d640400ae605fd( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs / namespace_60db312ba22882e7
// Params 0
// Checksum 0x0, Offset: 0x404
// Size: 0x1bc
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 20864, -4648, 2040 );
    instancestruct.locationorigin = [ ( 0, 0, 0 ) ];
    instancestruct.locationoriginoffset = [ ( 20864, -4648, 2040 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_LOWTOWN_SOCCER" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_harvesterorb";
    instancestruct.cf = "mp_jup_st_e_ob_activity_lowtown_harvesterorb_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 15575, -10677, 1830 );
    instancestruct.locationorigin = [ ( 0, 0, 0 ) ];
    instancestruct.locationoriginoffset = [ ( 15575, -10677, 1830 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1000 ];
    activityinstances[ "HARVESTERORB_LOWTOWN_STATION" ] = instancestruct;
    return activityinstances;
}

