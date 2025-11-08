#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_a_ob_contracts_pvpve_assassination_cs;

// Namespace mp_jup_st_a_ob_contracts_pvpve_assassination_cs / namespace_ee0c44b2b5ce4eb7
// Params 2
// Checksum 0x0, Offset: 0x1dc
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_a_ob_contracts_pvpve_assassination_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_a_ob_contracts_pvpve_assassination_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_a_ob_contracts_pvpve_assassination_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_a_ob_contracts_pvpve_assassination_cs / namespace_ee0c44b2b5ce4eb7
// Params 3
// Checksum 0x0, Offset: 0x251
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_a_ob_contracts_pvpve_assassination_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_a_ob_contracts_pvpve_assassination_cs" );
}

// Namespace mp_jup_st_a_ob_contracts_pvpve_assassination_cs / namespace_ee0c44b2b5ce4eb7
// Params 3
// Checksum 0x0, Offset: 0x2c0
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_a_ob_contracts_pvpve_assassination_cs / namespace_ee0c44b2b5ce4eb7
// Params 0
// Checksum 0x0, Offset: 0x308
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_a_ob_contracts_pvpve_assassination_cs / namespace_ee0c44b2b5ce4eb7
// Params 0
// Checksum 0x0, Offset: 0x312
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_a_ob_contracts_pvpve_assassination_cs" );
}

// Namespace mp_jup_st_a_ob_contracts_pvpve_assassination_cs / namespace_ee0c44b2b5ce4eb7
// Params 0
// Checksum 0x0, Offset: 0x328
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_ASSASSINATION";
    activityinfostruct.scriptbundle = "jup_activitydefinition_assassination";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_a_ob_contracts_pvpve_assassination_cs / namespace_ee0c44b2b5ce4eb7
// Params 4
// Checksum 0x0, Offset: 0x39a
// Size: 0x83
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_a_ob_contracts_pvpve_assassination_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_54a19c8213874153":
            function_7aa60b9371af4ee( fe, us, cf );
            break;
        case #"hash_bd949ac32796269b":
            function_7357b1123e40a846( fe, us, cf );
            break;
        case #"hash_2a5a91dbccc6d491":
            function_bcf8a2ee9f9a0170( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_a_ob_contracts_pvpve_assassination_cs / namespace_ee0c44b2b5ce4eb7
// Params 3
// Checksum 0x0, Offset: 0x425
// Size: 0x109
function function_7aa60b9371af4ee( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_pvpve_assassination_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "assassination_region", undefined, "A", undefined, undefined, ( -22018.5, 30350.5, 2216 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_pvpve_assassination_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", undefined, "ASSASSINATION_A_EAGLE_STATUE", undefined, undefined, ( -22018.5, 30350.5, 2216 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_a_ob_contracts_pvpve_assassination_cs / namespace_ee0c44b2b5ce4eb7
// Params 3
// Checksum 0x0, Offset: 0x536
// Size: 0x109
function function_7357b1123e40a846( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_pvpve_assassination_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "assassination_region", undefined, "A", undefined, undefined, ( -39826.5, 40459.5, 1613.5 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_pvpve_assassination_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", undefined, "ASSASSINATION_A_ISOLATED_CABIN", undefined, undefined, ( -39826.5, 40459.5, 1613.5 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_a_ob_contracts_pvpve_assassination_cs / namespace_ee0c44b2b5ce4eb7
// Params 3
// Checksum 0x0, Offset: 0x647
// Size: 0x10d
function function_bcf8a2ee9f9a0170( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_pvpve_assassination_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "assassination_region", undefined, "A", undefined, undefined, ( -17945.5, 17491.5, 2336.5 ), ( 0, 228.19, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_a_ob_contracts_pvpve_assassination_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "ASSASSINATION_A_MOUNTAIN", "ASSASSINATION_A_MOUNTAIN", undefined, undefined, ( -17945.5, 17491.5, 2336.5 ), ( 0, 228.19, 0 ) );
}

// Namespace mp_jup_st_a_ob_contracts_pvpve_assassination_cs / namespace_ee0c44b2b5ce4eb7
// Params 0
// Checksum 0x0, Offset: 0x75c
// Size: 0x1e0
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_assassination";
    instancestruct.cf = "mp_jup_st_a_ob_contracts_pvpve_assassination_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -22018.5, 30350.5, 2216 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "ASSASSINATION_A_EAGLE_STATUE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_assassination";
    instancestruct.cf = "mp_jup_st_a_ob_contracts_pvpve_assassination_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -39826.5, 40459.5, 1613.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "ASSASSINATION_A_ISOLATED_CABIN" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_assassination";
    instancestruct.cf = "mp_jup_st_a_ob_contracts_pvpve_assassination_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -17945.5, 17491.5, 2336.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "ASSASSINATION_A_MOUNTAIN" ] = instancestruct;
    return activityinstances;
}

