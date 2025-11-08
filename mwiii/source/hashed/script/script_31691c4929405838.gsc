#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_f_ob_interactions_aethertear_cs;

// Namespace mp_jup_st_f_ob_interactions_aethertear_cs / namespace_f15045095e8f44b4
// Params 2
// Checksum 0x0, Offset: 0x168
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_f_ob_interactions_aethertear_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_f_ob_interactions_aethertear_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_f_ob_interactions_aethertear_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_f_ob_interactions_aethertear_cs / namespace_f15045095e8f44b4
// Params 3
// Checksum 0x0, Offset: 0x1dd
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_f_ob_interactions_aethertear_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_f_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_f_ob_interactions_aethertear_cs / namespace_f15045095e8f44b4
// Params 3
// Checksum 0x0, Offset: 0x24c
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_f_ob_interactions_aethertear_cs / namespace_f15045095e8f44b4
// Params 0
// Checksum 0x0, Offset: 0x294
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_f_ob_interactions_aethertear_cs / namespace_f15045095e8f44b4
// Params 0
// Checksum 0x0, Offset: 0x29e
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_f_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_f_ob_interactions_aethertear_cs / namespace_f15045095e8f44b4
// Params 0
// Checksum 0x0, Offset: 0x2b4
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

// Namespace mp_jup_st_f_ob_interactions_aethertear_cs / namespace_f15045095e8f44b4
// Params 4
// Checksum 0x0, Offset: 0x326
// Size: 0x83
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_f_ob_interactions_aethertear_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_135720d71a8f8398":
            function_61c36c63c6822875( fe, us, cf );
            break;
        case #"hash_1fd0986fc23fd22b":
            function_b4b035aac68b4f0c( fe, us, cf );
            break;
        case #"hash_7b8ece796660fbf7":
            function_e6dcb90c3df3cb4a( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_f_ob_interactions_aethertear_cs / namespace_f15045095e8f44b4
// Params 3
// Checksum 0x0, Offset: 0x3b1
// Size: 0x2c
function function_61c36c63c6822875( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_f_ob_interactions_aethertear_cs / namespace_f15045095e8f44b4
// Params 3
// Checksum 0x0, Offset: 0x3e5
// Size: 0x2c
function function_b4b035aac68b4f0c( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_f_ob_interactions_aethertear_cs / namespace_f15045095e8f44b4
// Params 3
// Checksum 0x0, Offset: 0x419
// Size: 0x2c
function function_e6dcb90c3df3cb4a( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_f_ob_interactions_aethertear_cs / namespace_f15045095e8f44b4
// Params 0
// Checksum 0x0, Offset: 0x44d
// Size: 0x1e0
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_f_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 28635, 5857.5, 2201.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_F_MID" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_f_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 44947, -6374, 2843 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_F_EAST" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_f_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 27146, -3207, 2366.33 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_F_SOUTH" ] = instancestruct;
    return activityinstances;
}

