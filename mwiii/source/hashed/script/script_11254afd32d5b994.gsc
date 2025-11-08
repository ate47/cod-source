#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_c_ob_interactions_aethertear_cs;

// Namespace mp_jup_st_c_ob_interactions_aethertear_cs / namespace_ccff918adfb660d8
// Params 2
// Checksum 0x0, Offset: 0x165
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_c_ob_interactions_aethertear_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_c_ob_interactions_aethertear_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_c_ob_interactions_aethertear_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_c_ob_interactions_aethertear_cs / namespace_ccff918adfb660d8
// Params 3
// Checksum 0x0, Offset: 0x1da
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_c_ob_interactions_aethertear_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_c_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_c_ob_interactions_aethertear_cs / namespace_ccff918adfb660d8
// Params 3
// Checksum 0x0, Offset: 0x249
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_c_ob_interactions_aethertear_cs / namespace_ccff918adfb660d8
// Params 0
// Checksum 0x0, Offset: 0x291
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_c_ob_interactions_aethertear_cs / namespace_ccff918adfb660d8
// Params 0
// Checksum 0x0, Offset: 0x29b
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_c_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_c_ob_interactions_aethertear_cs / namespace_ccff918adfb660d8
// Params 0
// Checksum 0x0, Offset: 0x2b1
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

// Namespace mp_jup_st_c_ob_interactions_aethertear_cs / namespace_ccff918adfb660d8
// Params 4
// Checksum 0x0, Offset: 0x323
// Size: 0x83
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_c_ob_interactions_aethertear_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_ba670e4e4be3f86b":
            function_1229a900a9ca5cc( fe, us, cf );
            break;
        case #"hash_cd7f3da919853cd6":
            function_b53a1f592110fa2b( fe, us, cf );
            break;
        case #"hash_ba67204e4be414c1":
            function_122ac900a9ccd62( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_c_ob_interactions_aethertear_cs / namespace_ccff918adfb660d8
// Params 3
// Checksum 0x0, Offset: 0x3ae
// Size: 0x2c
function function_1229a900a9ca5cc( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_c_ob_interactions_aethertear_cs / namespace_ccff918adfb660d8
// Params 3
// Checksum 0x0, Offset: 0x3e2
// Size: 0x2c
function function_b53a1f592110fa2b( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_c_ob_interactions_aethertear_cs / namespace_ccff918adfb660d8
// Params 3
// Checksum 0x0, Offset: 0x416
// Size: 0x2c
function function_122ac900a9ccd62( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_c_ob_interactions_aethertear_cs / namespace_ccff918adfb660d8
// Params 0
// Checksum 0x0, Offset: 0x44a
// Size: 0x1e0
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_c_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 36106, 16385, 3466.25 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_C_SE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_c_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 35552.5, 34447.5, 1745 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_C_NORTH" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_c_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 17137.5, 19532, 1001.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_C_SW" ] = instancestruct;
    return activityinstances;
}

