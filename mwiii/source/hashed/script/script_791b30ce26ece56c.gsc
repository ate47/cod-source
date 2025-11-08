#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs;

// Namespace mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs / namespace_d687ce4fe57c14a8
// Params 2
// Checksum 0x0, Offset: 0x1ac
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs / namespace_d687ce4fe57c14a8
// Params 3
// Checksum 0x0, Offset: 0x221
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs" );
}

// Namespace mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs / namespace_d687ce4fe57c14a8
// Params 3
// Checksum 0x0, Offset: 0x290
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs / namespace_d687ce4fe57c14a8
// Params 0
// Checksum 0x0, Offset: 0x2d8
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs / namespace_d687ce4fe57c14a8
// Params 0
// Checksum 0x0, Offset: 0x2e2
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs" );
}

// Namespace mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs / namespace_d687ce4fe57c14a8
// Params 0
// Checksum 0x0, Offset: 0x2f8
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_TEAM_HUNT";
    activityinfostruct.scriptbundle = "jup_activitydefinition_team_hunt";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs / namespace_d687ce4fe57c14a8
// Params 4
// Checksum 0x0, Offset: 0x36a
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_ef1b3dc9c0a745ec":
            function_a630355e55a25bd9( fe, us, cf );
            break;
        case #"hash_fa018baedba94dc1":
            function_f2fb698b911f4ee( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs / namespace_d687ce4fe57c14a8
// Params 3
// Checksum 0x0, Offset: 0x3dc
// Size: 0x10d
function function_a630355e55a25bd9( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hunt_region", undefined, "I", undefined, undefined, ( 37366.1, -31689.9, 3166 ), ( 0, 40, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "TEAM_HUNT_I_ISLAND_WOODHOUSE", "TEAM_HUNT_I_ISLAND_WOODHOUSE", undefined, undefined, ( 37366.1, -31689.9, 3166 ), ( 0, 40, 0 ) );
}

// Namespace mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs / namespace_d687ce4fe57c14a8
// Params 3
// Checksum 0x0, Offset: 0x4f1
// Size: 0x10d
function function_f2fb698b911f4ee( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hunt_region", undefined, "I", undefined, undefined, ( 24916.6, -30700.4, 3590.54 ), ( 0, 70, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "TEAM_HUNT_I_TRAINING_CAMP", "TEAM_HUNT_I_TRAINING_CAMP", undefined, undefined, ( 24916.6, -30700.4, 3590.54 ), ( 0, 70, 0 ) );
}

// Namespace mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs / namespace_d687ce4fe57c14a8
// Params 0
// Checksum 0x0, Offset: 0x606
// Size: 0x148
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_team_hunt";
    instancestruct.cf = "mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 37366.1, -31689.9, 3166 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TEAM_HUNT_I_ISLAND_WOODHOUSE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_team_hunt";
    instancestruct.cf = "mp_jup_st_i_ob_contracts_pvpve_team_hunt_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 24916.6, -30700.4, 3590.54 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TEAM_HUNT_I_TRAINING_CAMP" ] = instancestruct;
    return activityinstances;
}

