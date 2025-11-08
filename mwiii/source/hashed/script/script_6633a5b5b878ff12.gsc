#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_fort_ob_contracts_sabotage_cs;

// Namespace mp_jup_fort_ob_contracts_sabotage_cs / namespace_6410a814a444bcf4
// Params 2
// Checksum 0x0, Offset: 0x196
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_fort_ob_contracts_sabotage_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_fort_ob_contracts_sabotage_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_fort_ob_contracts_sabotage_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_fort_ob_contracts_sabotage_cs / namespace_6410a814a444bcf4
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
    
    s cs_setup_arrays( us, "mp_jup_fort_ob_contracts_sabotage_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_fort_ob_contracts_sabotage_cs" );
}

// Namespace mp_jup_fort_ob_contracts_sabotage_cs / namespace_6410a814a444bcf4
// Params 3
// Checksum 0x0, Offset: 0x27a
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_fort_ob_contracts_sabotage_cs / namespace_6410a814a444bcf4
// Params 0
// Checksum 0x0, Offset: 0x2c2
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_fort_ob_contracts_sabotage_cs / namespace_6410a814a444bcf4
// Params 0
// Checksum 0x0, Offset: 0x2cc
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_fort_ob_contracts_sabotage_cs" );
}

// Namespace mp_jup_fort_ob_contracts_sabotage_cs / namespace_6410a814a444bcf4
// Params 0
// Checksum 0x0, Offset: 0x2e2
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

// Namespace mp_jup_fort_ob_contracts_sabotage_cs / namespace_6410a814a444bcf4
// Params 4
// Checksum 0x0, Offset: 0x354
// Size: 0x51
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_fort_ob_contracts_sabotage_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_30b5278e229b08d3":
            function_3cf6bb9611fc258( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_fort_ob_contracts_sabotage_cs / namespace_6410a814a444bcf4
// Params 3
// Checksum 0x0, Offset: 0x3ad
// Size: 0x9a
function function_3cf6bb9611fc258( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_fort_ob_contracts_sabotage_cs";
    fe [[ f ]]( s, us, cf, ( 23484, -51611, 931 ), ( 0, 14.64, 0 ), "activity_nexus_instance_joiner", "cspf_2_auto11925423706169286131", "SABOTAGE_FORT", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_fort_ob_contracts_sabotage_cs / namespace_6410a814a444bcf4
// Params 0
// Checksum 0x0, Offset: 0x44f
// Size: 0x1c8
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_sabotage";
    instancestruct.cf = "mp_jup_fort_ob_contracts_sabotage_cs";
    instancestruct.scriptstructorigin = ( 18709, -53895, 1462.21 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.var_5b156d1fa702b37f = [];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationorigin = [ ( 18692, -53891.5, 1462 ) ];
    instancestruct.var_5b156d1fa702b37f[ "join_radius" ].locationradius = [ 5000 ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ] = spawnstruct();
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationorigin = [ ( 18693.5, -53894.5, 1467 ) ];
    instancestruct.var_5b156d1fa702b37f[ "participation_radius" ].locationradius = [ 8000 ];
    instancestruct.locationorigin = [ ( 18701, -53894, 1465 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1 ];
    activityinstances[ "SABOTAGE_FORT" ] = instancestruct;
    return activityinstances;
}

