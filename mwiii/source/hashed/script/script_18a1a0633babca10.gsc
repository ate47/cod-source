#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs;

// Namespace mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs / namespace_90cb51074653cfd4
// Params 2
// Checksum 0x0, Offset: 0x197
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs / namespace_90cb51074653cfd4
// Params 3
// Checksum 0x0, Offset: 0x20c
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs" );
}

// Namespace mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs / namespace_90cb51074653cfd4
// Params 3
// Checksum 0x0, Offset: 0x27b
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs / namespace_90cb51074653cfd4
// Params 0
// Checksum 0x0, Offset: 0x2c3
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs / namespace_90cb51074653cfd4
// Params 0
// Checksum 0x0, Offset: 0x2cd
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs" );
}

// Namespace mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs / namespace_90cb51074653cfd4
// Params 0
// Checksum 0x0, Offset: 0x2e3
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

// Namespace mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs / namespace_90cb51074653cfd4
// Params 4
// Checksum 0x0, Offset: 0x355
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_9c6eeac21ac1adc4":
            function_7f4bfd3326decb0f( fe, us, cf );
            break;
        case #"hash_f2ed2be75dbcba58":
            function_fbc0047003b08fd( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs / namespace_90cb51074653cfd4
// Params 3
// Checksum 0x0, Offset: 0x3c7
// Size: 0x10d
function function_7f4bfd3326decb0f( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hunt_region", undefined, "H", undefined, undefined, ( 13324, -34780, 2782 ), ( 0, 105, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "TEAM_HUNT_H_HOUSE", "TEAM_HUNT_H_HOUSE", undefined, undefined, ( 13324, -34780, 2782 ), ( 0, 105, 0 ) );
}

// Namespace mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs / namespace_90cb51074653cfd4
// Params 3
// Checksum 0x0, Offset: 0x4dc
// Size: 0x10d
function function_fbc0047003b08fd( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hunt_region", undefined, "H", undefined, undefined, ( 9144, -23280, 1790 ), ( 0, 40, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "TEAM_HUNT_H_PARK", "TEAM_HUNT_H_PARK", undefined, undefined, ( 9144, -23280, 1790 ), ( 0, 40, 0 ) );
}

// Namespace mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs / namespace_90cb51074653cfd4
// Params 0
// Checksum 0x0, Offset: 0x5f1
// Size: 0x148
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_team_hunt";
    instancestruct.cf = "mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 13324, -34780, 2782 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TEAM_HUNT_H_HOUSE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_team_hunt";
    instancestruct.cf = "mp_jup_st_h_ob_contracts_pvpve_team_hunt_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 9144, -23280, 1790 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TEAM_HUNT_H_PARK" ] = instancestruct;
    return activityinstances;
}

