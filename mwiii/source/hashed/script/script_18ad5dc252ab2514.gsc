#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_d_ob_interactions_aethertear_cs;

// Namespace mp_jup_st_d_ob_interactions_aethertear_cs / namespace_cc725920b0d0aeb8
// Params 2
// Checksum 0x0, Offset: 0x16a
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_d_ob_interactions_aethertear_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_d_ob_interactions_aethertear_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_d_ob_interactions_aethertear_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_d_ob_interactions_aethertear_cs / namespace_cc725920b0d0aeb8
// Params 3
// Checksum 0x0, Offset: 0x1df
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_d_ob_interactions_aethertear_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_d_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_d_ob_interactions_aethertear_cs / namespace_cc725920b0d0aeb8
// Params 3
// Checksum 0x0, Offset: 0x24e
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_d_ob_interactions_aethertear_cs / namespace_cc725920b0d0aeb8
// Params 0
// Checksum 0x0, Offset: 0x296
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_d_ob_interactions_aethertear_cs / namespace_cc725920b0d0aeb8
// Params 0
// Checksum 0x0, Offset: 0x2a0
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_d_ob_interactions_aethertear_cs" );
}

// Namespace mp_jup_st_d_ob_interactions_aethertear_cs / namespace_cc725920b0d0aeb8
// Params 0
// Checksum 0x0, Offset: 0x2b6
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

// Namespace mp_jup_st_d_ob_interactions_aethertear_cs / namespace_cc725920b0d0aeb8
// Params 4
// Checksum 0x0, Offset: 0x328
// Size: 0x83
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_d_ob_interactions_aethertear_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_b99def8fbbdc4ac1":
            function_54e41026e7074030( fe, us, cf );
            break;
        case #"hash_69cea87fc4a3f244":
            function_fcc21535e0b05557( fe, us, cf );
            break;
        case #"hash_1812d879c679bfd3":
            function_3eb9194adbbf32c4( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_d_ob_interactions_aethertear_cs / namespace_cc725920b0d0aeb8
// Params 3
// Checksum 0x0, Offset: 0x3b3
// Size: 0x2c
function function_54e41026e7074030( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_d_ob_interactions_aethertear_cs / namespace_cc725920b0d0aeb8
// Params 3
// Checksum 0x0, Offset: 0x3e7
// Size: 0x2c
function function_fcc21535e0b05557( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_d_ob_interactions_aethertear_cs / namespace_cc725920b0d0aeb8
// Params 3
// Checksum 0x0, Offset: 0x41b
// Size: 0x2c
function function_3eb9194adbbf32c4( fe, us, cf )
{
    f = &strike_additem;
}

// Namespace mp_jup_st_d_ob_interactions_aethertear_cs / namespace_cc725920b0d0aeb8
// Params 0
// Checksum 0x0, Offset: 0x44f
// Size: 0x1e0
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_d_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -31644.5, 16827.5, 966.25 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_D_SHORE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_d_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -31734, -3900, 936 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_D_PIER" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_aethertear";
    instancestruct.cf = "mp_jup_st_d_ob_interactions_aethertear_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -30507, -16417.5, 1321 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "AETHERTEAR_D_WEST" ] = instancestruct;
    return activityinstances;
}

