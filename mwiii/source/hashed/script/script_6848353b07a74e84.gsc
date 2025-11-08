#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_hydro_ob_interactions_turret_trap_cs;

// Namespace mp_jup_hydro_ob_interactions_turret_trap_cs / namespace_f8f9b4e3bd129246
// Params 2
// Checksum 0x0, Offset: 0x278
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_hydro_ob_interactions_turret_trap_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_hydro_ob_interactions_turret_trap_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_hydro_ob_interactions_turret_trap_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_hydro_ob_interactions_turret_trap_cs / namespace_f8f9b4e3bd129246
// Params 3
// Checksum 0x0, Offset: 0x2ed
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_hydro_ob_interactions_turret_trap_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_hydro_ob_interactions_turret_trap_cs" );
}

// Namespace mp_jup_hydro_ob_interactions_turret_trap_cs / namespace_f8f9b4e3bd129246
// Params 3
// Checksum 0x0, Offset: 0x35c
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_hydro_ob_interactions_turret_trap_cs / namespace_f8f9b4e3bd129246
// Params 0
// Checksum 0x0, Offset: 0x3a4
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_hydro_ob_interactions_turret_trap_cs / namespace_f8f9b4e3bd129246
// Params 0
// Checksum 0x0, Offset: 0x3ae
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_hydro_ob_interactions_turret_trap_cs" );
}

// Namespace mp_jup_hydro_ob_interactions_turret_trap_cs / namespace_f8f9b4e3bd129246
// Params 0
// Checksum 0x0, Offset: 0x3c4
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_TURRET_TRAP";
    activityinfostruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_hydro_ob_interactions_turret_trap_cs / namespace_f8f9b4e3bd129246
// Params 4
// Checksum 0x0, Offset: 0x436
// Size: 0x83
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_hydro_ob_interactions_turret_trap_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_2907a08bcee3ac36":
            function_414c6420fc8b1297( fe, us, cf );
            break;
        case #"hash_fbbe783a6626ed60":
            function_d6110fa7d99dc8d7( fe, us, cf );
            break;
        case #"hash_30bd02de21f43d7":
            function_ef6f6303e36f2138( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_hydro_ob_interactions_turret_trap_cs / namespace_f8f9b4e3bd129246
// Params 3
// Checksum 0x0, Offset: 0x4c1
// Size: 0x162
function function_414c6420fc8b1297( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "turret_trap_spawn", "s_turret_trap_hydro_bridge", "turret_trap_spawn", undefined, undefined, ( -4742.28, 12426.9, 240 ), ( 0, 135, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "s_turret_trap_hydro_bridge", undefined, "activity_turret_trap_hydro_bridge", undefined, undefined, ( -4742.28, 12426.9, 240 ), ( 0, 135, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "turret_trap_panel", "s_turret_trap_hydro_bridge", "turret_trap_panel", undefined, undefined, ( -4742.28, 12426.9, 240 ), ( 0, 135, 0 ) );
}

// Namespace mp_jup_hydro_ob_interactions_turret_trap_cs / namespace_f8f9b4e3bd129246
// Params 3
// Checksum 0x0, Offset: 0x62b
// Size: 0x162
function function_d6110fa7d99dc8d7( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "turret_trap_spawn", "s_turret_trap_hydro_rooftop", "turret_trap_spawn", undefined, undefined, ( -12325.7, 5846.72, 444 ), ( 0, 225, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "s_turret_trap_hydro_rooftop", undefined, "activity_turret_trap_hydro_rooftop", undefined, undefined, ( -12325.7, 5846.72, 444 ), ( 0, 225, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "turret_trap_panel", "s_turret_trap_hydro_rooftop", "turret_trap_panel", undefined, undefined, ( -12325.7, 5846.72, 444 ), ( 0, 225, 0 ) );
}

// Namespace mp_jup_hydro_ob_interactions_turret_trap_cs / namespace_f8f9b4e3bd129246
// Params 3
// Checksum 0x0, Offset: 0x795
// Size: 0x162
function function_ef6f6303e36f2138( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "turret_trap_spawn", "s_turret_trap_hydro_plaza", "turret_trap_spawn", undefined, undefined, ( -4131.6, 4341.29, 543.01 ), ( 0, 190, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "s_turret_trap_hydro_plaza", undefined, "activity_turret_trap_hydro_plaza", undefined, undefined, ( -4131.6, 4341.29, 543.01 ), ( 0, 190, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_hydro_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "turret_trap_panel", "s_turret_trap_hydro_plaza", "turret_trap_panel", undefined, undefined, ( -4131.6, 4341.29, 543.01 ), ( 0, 190, 0 ) );
}

// Namespace mp_jup_hydro_ob_interactions_turret_trap_cs / namespace_f8f9b4e3bd129246
// Params 0
// Checksum 0x0, Offset: 0x8ff
// Size: 0x1e0
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_hydro_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -4742.28, 12426.9, 240 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TURRET_TRAP_HYDRO_BRIDGE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_hydro_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -12325.7, 5846.72, 444 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TURRET_TRAP_HYDRO_ROOFTOP" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_hydro_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 0 );
    instancestruct.scriptstructoriginoffset = ( -4131.6, 4341.29, 543.01 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TURRET_TRAP_HYDRO_PLAZA" ] = instancestruct;
    return activityinstances;
}

