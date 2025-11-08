#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_f_ob_contracts_pvpve_assassination_cs;

// Namespace mp_jup_st_f_ob_contracts_pvpve_assassination_cs / namespace_640e7d8769ad71c7
// Params 2
// Checksum 0x0, Offset: 0x1eb
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_f_ob_contracts_pvpve_assassination_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_f_ob_contracts_pvpve_assassination_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_f_ob_contracts_pvpve_assassination_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_f_ob_contracts_pvpve_assassination_cs / namespace_640e7d8769ad71c7
// Params 3
// Checksum 0x0, Offset: 0x260
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_f_ob_contracts_pvpve_assassination_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_f_ob_contracts_pvpve_assassination_cs" );
}

// Namespace mp_jup_st_f_ob_contracts_pvpve_assassination_cs / namespace_640e7d8769ad71c7
// Params 3
// Checksum 0x0, Offset: 0x2cf
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_f_ob_contracts_pvpve_assassination_cs / namespace_640e7d8769ad71c7
// Params 0
// Checksum 0x0, Offset: 0x317
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_f_ob_contracts_pvpve_assassination_cs / namespace_640e7d8769ad71c7
// Params 0
// Checksum 0x0, Offset: 0x321
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_f_ob_contracts_pvpve_assassination_cs" );
}

// Namespace mp_jup_st_f_ob_contracts_pvpve_assassination_cs / namespace_640e7d8769ad71c7
// Params 0
// Checksum 0x0, Offset: 0x337
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

// Namespace mp_jup_st_f_ob_contracts_pvpve_assassination_cs / namespace_640e7d8769ad71c7
// Params 4
// Checksum 0x0, Offset: 0x3a9
// Size: 0x9c
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_f_ob_contracts_pvpve_assassination_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_7e86dbda87ba2955":
            function_e86682672cba20e4( fe, us, cf );
            break;
        case #"hash_5cd317c5992768ae":
            function_8b05e6388fe5f9d7( fe, us, cf );
            break;
        case #"hash_9ff5d15c16d80b34":
            function_19032a2d3bba5d3f( fe, us, cf );
            break;
        case #"hash_7d05c11f4ac54726":
            function_92a94a19ec24f73f( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_f_ob_contracts_pvpve_assassination_cs / namespace_640e7d8769ad71c7
// Params 3
// Checksum 0x0, Offset: 0x44d
// Size: 0x10d
function function_e86682672cba20e4( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_contracts_pvpve_assassination_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "assassination_region", undefined, "F", undefined, undefined, ( 36089.5, -13808.5, 2977 ), ( 0, 94.46, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_contracts_pvpve_assassination_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "ASSASSINATION_F_MARKET", "ASSASSINATION_F_MARKET", undefined, undefined, ( 36089.5, -13808.5, 2977 ), ( 0, 94.46, 0 ) );
}

// Namespace mp_jup_st_f_ob_contracts_pvpve_assassination_cs / namespace_640e7d8769ad71c7
// Params 3
// Checksum 0x0, Offset: 0x562
// Size: 0x10d
function function_8b05e6388fe5f9d7( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_contracts_pvpve_assassination_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "assassination_region", undefined, "F", undefined, undefined, ( 19126, -3652.5, 2043.5 ), ( 0, 271.37, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_contracts_pvpve_assassination_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "ASSASSINATION_F_LOW_TOWN", "ASSASSINATION_F_LOW_TOWN", undefined, undefined, ( 19126, -3652.5, 2043.5 ), ( 0, 271.37, 0 ) );
}

// Namespace mp_jup_st_f_ob_contracts_pvpve_assassination_cs / namespace_640e7d8769ad71c7
// Params 3
// Checksum 0x0, Offset: 0x677
// Size: 0x10d
function function_19032a2d3bba5d3f( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_contracts_pvpve_assassination_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0.5, 0.5, 0 ), ( 0, 0, 0 ), "assassination_region", undefined, "F", undefined, undefined, ( 47572.5, -6144.5, 2940 ), ( 0, 189.76, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_contracts_pvpve_assassination_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "ASSASSINATION_F_TRACTOR", "ASSASSINATION_F_TRACTOR", undefined, undefined, ( 47572.5, -6144.5, 2940 ), ( 0, 189.76, 0 ) );
}

// Namespace mp_jup_st_f_ob_contracts_pvpve_assassination_cs / namespace_640e7d8769ad71c7
// Params 3
// Checksum 0x0, Offset: 0x78c
// Size: 0x10d
function function_92a94a19ec24f73f( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_contracts_pvpve_assassination_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "assassination_region", undefined, "F", undefined, undefined, ( 32688, -2707.5, 2306.5 ), ( 0, 324.03, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_contracts_pvpve_assassination_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "ASSASSINATION_F_VILLIAGE", "ASSASSINATION_F_VILLIAGE", undefined, undefined, ( 32688, -2707.5, 2306.5 ), ( 0, 324.03, 0 ) );
}

// Namespace mp_jup_st_f_ob_contracts_pvpve_assassination_cs / namespace_640e7d8769ad71c7
// Params 0
// Checksum 0x0, Offset: 0x8a1
// Size: 0x278
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_assassination";
    instancestruct.cf = "mp_jup_st_f_ob_contracts_pvpve_assassination_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 36089.5, -13808.5, 2977 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "ASSASSINATION_F_MARKET" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_assassination";
    instancestruct.cf = "mp_jup_st_f_ob_contracts_pvpve_assassination_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 19126, -3652.5, 2043.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "ASSASSINATION_F_LOW_TOWN" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_assassination";
    instancestruct.cf = "mp_jup_st_f_ob_contracts_pvpve_assassination_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 47572.5, -6144.5, 2940 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "ASSASSINATION_F_TRACTOR" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_assassination";
    instancestruct.cf = "mp_jup_st_f_ob_contracts_pvpve_assassination_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( 32688, -2707.5, 2306.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "ASSASSINATION_F_VILLIAGE" ] = instancestruct;
    return activityinstances;
}

