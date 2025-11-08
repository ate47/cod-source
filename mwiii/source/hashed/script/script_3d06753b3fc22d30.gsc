#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs;

// Namespace mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs / namespace_b90be98f4e4b8234
// Params 2
// Checksum 0x0, Offset: 0x1b9
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs / namespace_b90be98f4e4b8234
// Params 3
// Checksum 0x0, Offset: 0x22e
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs" );
}

// Namespace mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs / namespace_b90be98f4e4b8234
// Params 3
// Checksum 0x0, Offset: 0x29d
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs / namespace_b90be98f4e4b8234
// Params 0
// Checksum 0x0, Offset: 0x2e5
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs / namespace_b90be98f4e4b8234
// Params 0
// Checksum 0x0, Offset: 0x2ef
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs" );
}

// Namespace mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs / namespace_b90be98f4e4b8234
// Params 0
// Checksum 0x0, Offset: 0x305
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

// Namespace mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs / namespace_b90be98f4e4b8234
// Params 4
// Checksum 0x0, Offset: 0x377
// Size: 0x83
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_2e14ffbc7014a54e":
            function_c6d5b421e4a1678b( fe, us, cf );
            break;
        case #"hash_4a94c53356eab392":
            function_7283e0756341720b( fe, us, cf );
            break;
        case #"hash_4428d0aa65064cff":
            function_c5b97878dbf1982( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs / namespace_b90be98f4e4b8234
// Params 3
// Checksum 0x0, Offset: 0x402
// Size: 0x10d
function function_c6d5b421e4a1678b( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hunt_region", undefined, "G", undefined, undefined, ( -25872, -9868, 1536 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "TEAM_HUNT_G_FOOTBALL", "TEAM_HUNT_G_FOOTBALL", undefined, undefined, ( -25872, -9868, 1536 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs / namespace_b90be98f4e4b8234
// Params 3
// Checksum 0x0, Offset: 0x517
// Size: 0x10d
function function_7283e0756341720b( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hunt_region", undefined, "G", undefined, undefined, ( -14220, -32240, 1959.5 ), ( 0, 350, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "TEAM_HUNT_G_TOY_SHOP", "TEAM_HUNT_G_TOY_SHOP", undefined, undefined, ( -14220, -32240, 1959.5 ), ( 0, 350, 0 ) );
}

// Namespace mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs / namespace_b90be98f4e4b8234
// Params 3
// Checksum 0x0, Offset: 0x62c
// Size: 0x10d
function function_c5b97878dbf1982( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hunt_region", undefined, "G", undefined, undefined, ( -8710.49, -39990.8, 2328.5 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "TEAM_HUNT_G_UNIVERSITY", "TEAM_HUNT_G_UNIVERSITY", undefined, undefined, ( -8710.49, -39990.8, 2328.5 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs / namespace_b90be98f4e4b8234
// Params 0
// Checksum 0x0, Offset: 0x741
// Size: 0x1e0
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_team_hunt";
    instancestruct.cf = "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -25872, -9868, 1536 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TEAM_HUNT_G_FOOTBALL" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_team_hunt";
    instancestruct.cf = "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -14220, -32240, 1959.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TEAM_HUNT_G_TOY_SHOP" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_team_hunt";
    instancestruct.cf = "mp_jup_st_g_ob_contracts_pvpve_team_hunt_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -8710.49, -39990.8, 2328.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TEAM_HUNT_G_UNIVERSITY" ] = instancestruct;
    return activityinstances;
}

