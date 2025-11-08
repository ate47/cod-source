#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_c_ob_interacts_safe_cs;

// Namespace mp_jup_st_c_ob_interacts_safe_cs / namespace_1c628592735d653a
// Params 2
// Checksum 0x0, Offset: 0x11e
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_c_ob_interacts_safe_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_c_ob_interacts_safe_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_c_ob_interacts_safe_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_c_ob_interacts_safe_cs / namespace_1c628592735d653a
// Params 3
// Checksum 0x0, Offset: 0x193
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_c_ob_interacts_safe_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_c_ob_interacts_safe_cs" );
}

// Namespace mp_jup_st_c_ob_interacts_safe_cs / namespace_1c628592735d653a
// Params 3
// Checksum 0x0, Offset: 0x202
// Size: 0x83
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_c_ob_interacts_safe_cs";
    fe [[ f ]]( s, us, cf, ( 19279.1, 58721, 200 ), ( 0, 180, 0 ) );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_c_ob_interacts_safe_cs / namespace_1c628592735d653a
// Params 0
// Checksum 0x0, Offset: 0x28d
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_c_ob_interacts_safe_cs / namespace_1c628592735d653a
// Params 0
// Checksum 0x0, Offset: 0x297
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_c_ob_interacts_safe_cs" );
}

// Namespace mp_jup_st_c_ob_interacts_safe_cs / namespace_1c628592735d653a
// Params 0
// Checksum 0x0, Offset: 0x2ad
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_SAFECRACK";
    activityinfostruct.scriptbundle = "jup_activitydefinition_safecrack";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_c_ob_interacts_safe_cs / namespace_1c628592735d653a
// Params 4
// Checksum 0x0, Offset: 0x31f
// Size: 0x2f
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_c_ob_interacts_safe_cs";
    }
}

// Namespace mp_jup_st_c_ob_interacts_safe_cs / namespace_1c628592735d653a
// Params 0
// Checksum 0x0, Offset: 0x356
// Size: 0x10
function function_6da2952367672ac0()
{
    activityinstances = [];
    return activityinstances;
}

