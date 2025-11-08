#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_i_ob_interactions_aethertear_cs;

// Namespace mp_jup_st_i_ob_interactions_aethertear_cs / namespace_f9ac4a175808c9f4
// Params 2
// Checksum 0x0, Offset: 0x186
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_i_ob_interactions_aethertear_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_i_ob_interactions_aethertear_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_i_ob_interactions_aethertear_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_i_ob_interactions_aethertear_cs / namespace_f9ac4a175808c9f4
// Params 3
// Checksum 0x0, Offset: 0x1fb
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_i_ob_interactions_aethertear_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_i_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_i_ob_interactions_aethertear_cs / namespace_f9ac4a175808c9f4
// Params 3
// Checksum 0x0, Offset: 0x26a
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_i_ob_interactions_aethertear_cs / namespace_f9ac4a175808c9f4
// Params 0
// Checksum 0x0, Offset: 0x2b2
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_i_ob_interactions_aethertear_cs / namespace_f9ac4a175808c9f4
// Params 0
// Checksum 0x0, Offset: 0x2bc
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_i_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_i_ob_interactions_aethertear_cs / namespace_f9ac4a175808c9f4
// Params 0
// Checksum 0x0, Offset: 0x2d2
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

// Namespace mp_jup_st_i_ob_interactions_aethertear_cs / namespace_f9ac4a175808c9f4
// Params 4
// Checksum 0x0, Offset: 0x344
// Size: 0x9c
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_i_ob_interactions_aethertear_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_353ae6e8a2f4df54":
            function_949f343587d6f37( fe, us, cf );
            break;
        case #"hash_3be116a790313d45":
            function_3c5186f67d476148( fe, us, cf );
            break;
        case #"hash_f8223bc7e0758d3b":
            function_48d813ffbdb2482e( fe, us, cf );
            break;
        case #"hash_e5035db111fbacd0":
            function_26eb47c21ca5623b( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_i_ob_interactions_aethertear_cs / namespace_f9ac4a175808c9f4
// Params 3
// Checksum 0x0, Offset: 0x3e8
// Size: 0x2c
function function_949f343587d6f37( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_i_ob_interactions_aethertear_cs / namespace_f9ac4a175808c9f4
// Params 3
// Checksum 0x0, Offset: 0x41c
// Size: 0x2c
function function_3c5186f67d476148( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_i_ob_interactions_aethertear_cs / namespace_f9ac4a175808c9f4
// Params 3
// Checksum 0x0, Offset: 0x450
// Size: 0x2c
function function_48d813ffbdb2482e( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_i_ob_interactions_aethertear_cs / namespace_f9ac4a175808c9f4
// Params 3
// Checksum 0x0, Offset: 0x484
// Size: 0x2c
function function_26eb47c21ca5623b( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_i_ob_interactions_aethertear_cs / namespace_f9ac4a175808c9f4
// Params 0
// Checksum 0x0, Offset: 0x4b8
// Size: 0x278
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_i_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 33168, -20865.5, 2912 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_I_BRIDGE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_i_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 24848, -38131, 3114 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_I_SWING" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_i_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 44916, -28220, 3132 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_I_STABLES" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_i_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 35009.8, -37065.8, 3097 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_I_ISLAND" ] = instancestruct;
    return activityinstances;
}

