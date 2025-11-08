#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_e_ob_interactions_aethertear_cs;

// Namespace mp_jup_st_e_ob_interactions_aethertear_cs / namespace_6436c3b25b53b4e4
// Params 2
// Checksum 0x0, Offset: 0x17f
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_e_ob_interactions_aethertear_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_e_ob_interactions_aethertear_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_e_ob_interactions_aethertear_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_e_ob_interactions_aethertear_cs / namespace_6436c3b25b53b4e4
// Params 3
// Checksum 0x0, Offset: 0x1f4
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_e_ob_interactions_aethertear_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_e_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_e_ob_interactions_aethertear_cs / namespace_6436c3b25b53b4e4
// Params 3
// Checksum 0x0, Offset: 0x263
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_e_ob_interactions_aethertear_cs / namespace_6436c3b25b53b4e4
// Params 0
// Checksum 0x0, Offset: 0x2ab
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_e_ob_interactions_aethertear_cs / namespace_6436c3b25b53b4e4
// Params 0
// Checksum 0x0, Offset: 0x2b5
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_e_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_e_ob_interactions_aethertear_cs / namespace_6436c3b25b53b4e4
// Params 0
// Checksum 0x0, Offset: 0x2cb
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

// Namespace mp_jup_st_e_ob_interactions_aethertear_cs / namespace_6436c3b25b53b4e4
// Params 4
// Checksum 0x0, Offset: 0x33d
// Size: 0x9c
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_e_ob_interactions_aethertear_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_a216f5b2dc201856":
            function_8e2ec8f4404ad3f1( fe, us, cf );
            break;
        case #"hash_f1c0f745656858ac":
            function_964e345c82765305( fe, us, cf );
            break;
        case #"hash_b3057a4281963b12":
            function_d37a0e82145cccef( fe, us, cf );
            break;
        case #"hash_c2fc6931cd5a5192":
            function_1401bd69ca4af2cd( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_e_ob_interactions_aethertear_cs / namespace_6436c3b25b53b4e4
// Params 3
// Checksum 0x0, Offset: 0x3e1
// Size: 0x2c
function function_8e2ec8f4404ad3f1( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_e_ob_interactions_aethertear_cs / namespace_6436c3b25b53b4e4
// Params 3
// Checksum 0x0, Offset: 0x415
// Size: 0x2c
function function_964e345c82765305( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_e_ob_interactions_aethertear_cs / namespace_6436c3b25b53b4e4
// Params 3
// Checksum 0x0, Offset: 0x449
// Size: 0x2c
function function_d37a0e82145cccef( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_e_ob_interactions_aethertear_cs / namespace_6436c3b25b53b4e4
// Params 3
// Checksum 0x0, Offset: 0x47d
// Size: 0x2c
function function_1401bd69ca4af2cd( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_e_ob_interactions_aethertear_cs / namespace_6436c3b25b53b4e4
// Params 0
// Checksum 0x0, Offset: 0x4b1
// Size: 0x278
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_e_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -10304.5, 12033.5, 1280 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_E_WEST" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_e_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 16508, 5249.5, 1863.4 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_E_NORTH" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_e_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -959.5, -7925.5, 1646 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_E_SOUTH" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_e_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 12084.8, 9312.5, 2651.75 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_E_HILL" ] = instancestruct;
    return activityinstances;
}

