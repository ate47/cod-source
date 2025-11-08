#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_d_ob_contracts_pvpve_assassination_cs;

// Namespace mp_jup_st_d_ob_contracts_pvpve_assassination_cs / namespace_4ca22f138e73d273
// Params 2
// Checksum 0x0, Offset: 0x1b2
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_d_ob_contracts_pvpve_assassination_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_d_ob_contracts_pvpve_assassination_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_d_ob_contracts_pvpve_assassination_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_d_ob_contracts_pvpve_assassination_cs / namespace_4ca22f138e73d273
// Params 3
// Checksum 0x0, Offset: 0x227
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_d_ob_contracts_pvpve_assassination_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_d_ob_contracts_pvpve_assassination_cs" );
}

// Namespace mp_jup_st_d_ob_contracts_pvpve_assassination_cs / namespace_4ca22f138e73d273
// Params 3
// Checksum 0x0, Offset: 0x296
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_d_ob_contracts_pvpve_assassination_cs / namespace_4ca22f138e73d273
// Params 0
// Checksum 0x0, Offset: 0x2de
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_d_ob_contracts_pvpve_assassination_cs / namespace_4ca22f138e73d273
// Params 0
// Checksum 0x0, Offset: 0x2e8
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_d_ob_contracts_pvpve_assassination_cs" );
}

// Namespace mp_jup_st_d_ob_contracts_pvpve_assassination_cs / namespace_4ca22f138e73d273
// Params 0
// Checksum 0x0, Offset: 0x2fe
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

// Namespace mp_jup_st_d_ob_contracts_pvpve_assassination_cs / namespace_4ca22f138e73d273
// Params 4
// Checksum 0x0, Offset: 0x370
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_d_ob_contracts_pvpve_assassination_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_e4e9782da1d03518":
            function_97567fe867b9433b( fe, us, cf );
            break;
        case #"hash_5173e6ea099e2372":
            function_705fad19b3c2db15( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_d_ob_contracts_pvpve_assassination_cs / namespace_4ca22f138e73d273
// Params 3
// Checksum 0x0, Offset: 0x3e2
// Size: 0x10d
function function_97567fe867b9433b( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_pvpve_assassination_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "assassination_region", undefined, "D1", undefined, undefined, ( -20972.5, -14855, 4432.5 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_pvpve_assassination_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "ASSASSINATION_D_ROOFTOP", "ASSASSINATION_D_ROOFTOP", undefined, undefined, ( -20972.5, -14855, 4432.5 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_d_ob_contracts_pvpve_assassination_cs / namespace_4ca22f138e73d273
// Params 3
// Checksum 0x0, Offset: 0x4f7
// Size: 0x109
function function_705fad19b3c2db15( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_pvpve_assassination_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "assassination_region", undefined, "D1", undefined, undefined, ( -39522, 7160, 952 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_pvpve_assassination_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", undefined, "ASSASSINATION_D_YACHT", undefined, undefined, ( -39522, 7160, 952 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_d_ob_contracts_pvpve_assassination_cs / namespace_4ca22f138e73d273
// Params 0
// Checksum 0x0, Offset: 0x608
// Size: 0x148
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_assassination";
    instancestruct.cf = "mp_jup_st_d_ob_contracts_pvpve_assassination_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -20972.5, -14855, 4432.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "ASSASSINATION_D_ROOFTOP" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_assassination";
    instancestruct.cf = "mp_jup_st_d_ob_contracts_pvpve_assassination_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -39522, 7160, 952 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "ASSASSINATION_D_YACHT" ] = instancestruct;
    return activityinstances;
}

