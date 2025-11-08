#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_a_ob_interactions_aethertear_cs;

// Namespace mp_jup_st_a_ob_interactions_aethertear_cs / namespace_f821add3864a3a64
// Params 2
// Checksum 0x0, Offset: 0x16b
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_a_ob_interactions_aethertear_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_a_ob_interactions_aethertear_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_a_ob_interactions_aethertear_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_a_ob_interactions_aethertear_cs / namespace_f821add3864a3a64
// Params 3
// Checksum 0x0, Offset: 0x1e0
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_a_ob_interactions_aethertear_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_a_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_a_ob_interactions_aethertear_cs / namespace_f821add3864a3a64
// Params 3
// Checksum 0x0, Offset: 0x24f
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_a_ob_interactions_aethertear_cs / namespace_f821add3864a3a64
// Params 0
// Checksum 0x0, Offset: 0x297
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_a_ob_interactions_aethertear_cs / namespace_f821add3864a3a64
// Params 0
// Checksum 0x0, Offset: 0x2a1
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_a_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_a_ob_interactions_aethertear_cs / namespace_f821add3864a3a64
// Params 0
// Checksum 0x0, Offset: 0x2b7
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

// Namespace mp_jup_st_a_ob_interactions_aethertear_cs / namespace_f821add3864a3a64
// Params 4
// Checksum 0x0, Offset: 0x329
// Size: 0x83
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_a_ob_interactions_aethertear_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_3058f82f5b945469":
            function_b1e29523ac19b2bc( fe, us, cf );
            break;
        case #"hash_acf37b9afbf557e":
            function_dd3a3b7436f55343( fe, us, cf );
            break;
        case #"hash_610d326560bd83d0":
            function_fda957d72835bd9f( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_a_ob_interactions_aethertear_cs / namespace_f821add3864a3a64
// Params 3
// Checksum 0x0, Offset: 0x3b4
// Size: 0x2c
function function_b1e29523ac19b2bc( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_a_ob_interactions_aethertear_cs / namespace_f821add3864a3a64
// Params 3
// Checksum 0x0, Offset: 0x3e8
// Size: 0x2c
function function_dd3a3b7436f55343( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_a_ob_interactions_aethertear_cs / namespace_f821add3864a3a64
// Params 3
// Checksum 0x0, Offset: 0x41c
// Size: 0x2c
function function_fda957d72835bd9f( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_a_ob_interactions_aethertear_cs / namespace_f821add3864a3a64
// Params 0
// Checksum 0x0, Offset: 0x450
// Size: 0x1e0
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_a_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -15377.5, 35537.5, 1250.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_A_TRASH" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_a_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -37346, 37598.5, 1388 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_A_SHORE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_a_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -16392.5, 17691, 2169.4 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_A_EAST" ] = instancestruct;
    return activityinstances;
}

