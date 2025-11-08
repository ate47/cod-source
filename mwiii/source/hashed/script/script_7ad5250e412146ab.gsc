#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_h_ob_contracts_sabotage_cs;

// Namespace mp_jup_st_h_ob_contracts_sabotage_cs / namespace_e625182b151dea91
// Params 2
// Checksum 0x0, Offset: 0x1ad
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_h_ob_contracts_sabotage_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_h_ob_contracts_sabotage_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_h_ob_contracts_sabotage_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_h_ob_contracts_sabotage_cs / namespace_e625182b151dea91
// Params 3
// Checksum 0x0, Offset: 0x222
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_h_ob_contracts_sabotage_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_h_ob_contracts_sabotage_cs" );
}

// Namespace mp_jup_st_h_ob_contracts_sabotage_cs / namespace_e625182b151dea91
// Params 3
// Checksum 0x0, Offset: 0x291
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_h_ob_contracts_sabotage_cs / namespace_e625182b151dea91
// Params 0
// Checksum 0x0, Offset: 0x2d9
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_h_ob_contracts_sabotage_cs / namespace_e625182b151dea91
// Params 0
// Checksum 0x0, Offset: 0x2e3
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_h_ob_contracts_sabotage_cs" );
}

// Namespace mp_jup_st_h_ob_contracts_sabotage_cs / namespace_e625182b151dea91
// Params 0
// Checksum 0x0, Offset: 0x2f9
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_SABOTAGE";
    activityinfostruct.scriptbundle = "jup_activitydef_sabotage";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_h_ob_contracts_sabotage_cs / namespace_e625182b151dea91
// Params 4
// Checksum 0x0, Offset: 0x36b
// Size: 0x83
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_h_ob_contracts_sabotage_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_53d2595a5f8e7677":
            function_eabdb13361e20852( fe, us, cf );
            break;
        case #"hash_70329fde07d566d3":
            function_23e5fc48465229a4( fe, us, cf );
            break;
        case #"hash_43abae9860084656":
            function_95397b1f6dc7f819( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_h_ob_contracts_sabotage_cs / namespace_e625182b151dea91
// Params 3
// Checksum 0x0, Offset: 0x3f6
// Size: 0x96
function function_eabdb13361e20852( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 6908.5, -35421, 2840.95 ), ( 0.02, 94.08, 0.01 ), "activity_nexus_instance_joiner", undefined, "SABOTAGE_H_RESIDENTIAL", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_h_ob_contracts_sabotage_cs / namespace_e625182b151dea91
// Params 3
// Checksum 0x0, Offset: 0x494
// Size: 0x96
function function_23e5fc48465229a4( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 9164.5, -25679, 1806.72 ), ( 1.74, 117.24, 0.48 ), "activity_nexus_instance_joiner", undefined, "SABOTAGE_H_MARKET", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_h_ob_contracts_sabotage_cs / namespace_e625182b151dea91
// Params 3
// Checksum 0x0, Offset: 0x532
// Size: 0x96
function function_95397b1f6dc7f819( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_h_ob_contracts_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( -1933.5, -38149, 2529.5 ), ( 0, 293.18, 0 ), "activity_nexus_instance_joiner", undefined, "SABOTAGE_H_CONSTRUCTION", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_h_ob_contracts_sabotage_cs / namespace_e625182b151dea91
// Params 0
// Checksum 0x0, Offset: 0x5d0
// Size: 0x52b
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_sabotage";
    instancestruct.cf = "mp_jup_st_h_ob_contracts_sabotage_cs";
    instancestruct.scriptstructorigin = ( 13696, -34830, 2735 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.var_5b156d1fa702b37f = [];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationorigin = [ ( 13703.5, -34830, 2735 ) ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationradius = [ 2400 ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationorigin = [ ( 13704.5, -34823.5, 2735 ) ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationradius = [ 5000 ];
    instancestruct.locationorigin = [ ( 100.47, -35563.8, 2737.75 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 2400 ];
    activityinstances[ "SABOTAGE_H_RESIDENTIAL" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_sabotage";
    instancestruct.cf = "mp_jup_st_h_ob_contracts_sabotage_cs";
    instancestruct.scriptstructorigin = ( 15143.5, -22893, 1704 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.var_5b156d1fa702b37f = [];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationorigin = [ ( 15145, -22891, 1704 ) ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationradius = [ 2100 ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationorigin = [ ( 15144, -22891, 1704 ) ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationradius = [ 4000 ];
    instancestruct.locationorigin = [ ( 15143.5, -22890, 1704 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 2100 ];
    activityinstances[ "SABOTAGE_H_MARKET" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_sabotage";
    instancestruct.cf = "mp_jup_st_h_ob_contracts_sabotage_cs";
    instancestruct.scriptstructorigin = ( -1451.5, -32392, 1789 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.var_5b156d1fa702b37f = [];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationorigin = [ ( -1449, -32391.5, 1788.98 ) ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationradius = [ 2000 ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationorigin = [ ( -1456.5, -32391.5, 1789 ) ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationradius = [ 4000 ];
    instancestruct.locationorigin = [ ( -1451.5, -32392, 1789 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 2000 ];
    activityinstances[ "SABOTAGE_H_CONSTRUCTION" ] = instancestruct;
    return activityinstances;
}

