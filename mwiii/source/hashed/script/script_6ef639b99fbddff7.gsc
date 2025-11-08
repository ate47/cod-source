#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_e_ob_contracts_pvpve_assassination_cs;

// Namespace mp_jup_st_e_ob_contracts_pvpve_assassination_cs / namespace_5ea9848627a81537
// Params 2
// Checksum 0x0, Offset: 0x196
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_e_ob_contracts_pvpve_assassination_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_e_ob_contracts_pvpve_assassination_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_e_ob_contracts_pvpve_assassination_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_e_ob_contracts_pvpve_assassination_cs / namespace_5ea9848627a81537
// Params 3
// Checksum 0x0, Offset: 0x20b
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_e_ob_contracts_pvpve_assassination_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_e_ob_contracts_pvpve_assassination_cs" );
}

// Namespace mp_jup_st_e_ob_contracts_pvpve_assassination_cs / namespace_5ea9848627a81537
// Params 3
// Checksum 0x0, Offset: 0x27a
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_e_ob_contracts_pvpve_assassination_cs / namespace_5ea9848627a81537
// Params 0
// Checksum 0x0, Offset: 0x2c2
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_e_ob_contracts_pvpve_assassination_cs / namespace_5ea9848627a81537
// Params 0
// Checksum 0x0, Offset: 0x2cc
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_e_ob_contracts_pvpve_assassination_cs" );
}

// Namespace mp_jup_st_e_ob_contracts_pvpve_assassination_cs / namespace_5ea9848627a81537
// Params 0
// Checksum 0x0, Offset: 0x2e2
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

// Namespace mp_jup_st_e_ob_contracts_pvpve_assassination_cs / namespace_5ea9848627a81537
// Params 4
// Checksum 0x0, Offset: 0x354
// Size: 0x51
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_e_ob_contracts_pvpve_assassination_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_224d80f7a2c253b1":
            function_38a9b758dd250c34( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_e_ob_contracts_pvpve_assassination_cs / namespace_5ea9848627a81537
// Params 3
// Checksum 0x0, Offset: 0x3ad
// Size: 0x10d
function function_38a9b758dd250c34( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_contracts_pvpve_assassination_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "activity_nexus_instance_joiner", "ASSASSINATION_E_PORT", "ASSASSINATION_E_PORT", undefined, undefined, ( -10399, 1477.5, 1244 ), ( 0, 303.2, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_e_ob_contracts_pvpve_assassination_cs";
    s.name = "region";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "assassination_region", undefined, "E", undefined, undefined, ( -10399, 1477.5, 1244 ), ( 0, 303.2, 0 ) );
}

// Namespace mp_jup_st_e_ob_contracts_pvpve_assassination_cs / namespace_5ea9848627a81537
// Params 0
// Checksum 0x0, Offset: 0x4c2
// Size: 0xb0
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydefinition_assassination";
    instancestruct.cf = "mp_jup_st_e_ob_contracts_pvpve_assassination_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -10399, 1477.5, 1244 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "ASSASSINATION_E_PORT" ] = instancestruct;
    return activityinstances;
}

