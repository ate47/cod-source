#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_e_ob_activity_lowtown_doghouse_cs;

// Namespace mp_jup_st_e_ob_activity_lowtown_doghouse_cs / namespace_cc69d5b187b6b5d4
// Params 2
// Checksum 0x0, Offset: 0x128
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_e_ob_activity_lowtown_doghouse_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_e_ob_activity_lowtown_doghouse_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_e_ob_activity_lowtown_doghouse_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_e_ob_activity_lowtown_doghouse_cs / namespace_cc69d5b187b6b5d4
// Params 3
// Checksum 0x0, Offset: 0x19d
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_e_ob_activity_lowtown_doghouse_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_e_ob_activity_lowtown_doghouse_cs" );
}

// Namespace mp_jup_st_e_ob_activity_lowtown_doghouse_cs / namespace_cc69d5b187b6b5d4
// Params 3
// Checksum 0x0, Offset: 0x20c
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_e_ob_activity_lowtown_doghouse_cs / namespace_cc69d5b187b6b5d4
// Params 0
// Checksum 0x0, Offset: 0x254
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_e_ob_activity_lowtown_doghouse_cs / namespace_cc69d5b187b6b5d4
// Params 0
// Checksum 0x0, Offset: 0x25e
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_DOGHOUSE";
    activityinfostruct.scriptbundle = "jup_activitydefinition_doghouse";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_e_ob_activity_lowtown_doghouse_cs / namespace_cc69d5b187b6b5d4
// Params 4
// Checksum 0x0, Offset: 0x2d0
// Size: 0x2f
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_e_ob_activity_lowtown_doghouse_cs";
    }
}

// Namespace mp_jup_st_e_ob_activity_lowtown_doghouse_cs / namespace_cc69d5b187b6b5d4
// Params 0
// Checksum 0x0, Offset: 0x307
// Size: 0x10
function function_6da2952367672ac0()
{
    activityinstances = [];
    return activityinstances;
}

