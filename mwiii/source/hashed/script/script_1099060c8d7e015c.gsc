#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_tower_ob_interactions_turret_trap_cs;

// Namespace mp_jup_tower_ob_interactions_turret_trap_cs / namespace_bdb6a4bf87613c0e
// Params 2
// Checksum 0x0, Offset: 0x276
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_tower_ob_interactions_turret_trap_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_tower_ob_interactions_turret_trap_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_tower_ob_interactions_turret_trap_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_tower_ob_interactions_turret_trap_cs / namespace_bdb6a4bf87613c0e
// Params 3
// Checksum 0x0, Offset: 0x2eb
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_tower_ob_interactions_turret_trap_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_tower_ob_interactions_turret_trap_cs" );
}

// Namespace mp_jup_tower_ob_interactions_turret_trap_cs / namespace_bdb6a4bf87613c0e
// Params 3
// Checksum 0x0, Offset: 0x35a
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_tower_ob_interactions_turret_trap_cs / namespace_bdb6a4bf87613c0e
// Params 0
// Checksum 0x0, Offset: 0x3a2
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_tower_ob_interactions_turret_trap_cs / namespace_bdb6a4bf87613c0e
// Params 0
// Checksum 0x0, Offset: 0x3ac
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_tower_ob_interactions_turret_trap_cs" );
}

// Namespace mp_jup_tower_ob_interactions_turret_trap_cs / namespace_bdb6a4bf87613c0e
// Params 0
// Checksum 0x0, Offset: 0x3c2
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

// Namespace mp_jup_tower_ob_interactions_turret_trap_cs / namespace_bdb6a4bf87613c0e
// Params 4
// Checksum 0x0, Offset: 0x434
// Size: 0x83
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_tower_ob_interactions_turret_trap_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_d5e8d21e16a5747e":
            function_9d6e327852aefb55( fe, us, cf );
            break;
        case #"hash_108916ed8961b7e3":
            function_acf253bd969a3c20( fe, us, cf );
            break;
        case #"hash_5fab9345c035a9d8":
            function_ffb2442d8f234045( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_tower_ob_interactions_turret_trap_cs / namespace_bdb6a4bf87613c0e
// Params 3
// Checksum 0x0, Offset: 0x4bf
// Size: 0x162
function function_9d6e327852aefb55( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_tower_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "turret_trap_spawn", "s_turret_trap_tower_parking", "turret_trap_spawn", undefined, undefined, ( 3618.65, 21844.5, 478.5 ), ( 0, 90, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 88 ), ( 0, 90, 0 ), "s_turret_trap_tower_parking", undefined, "activity_turret_trap_tower_parking", undefined, undefined, ( 3618.65, 21844.5, 478.5 ), ( 0, 90, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 18.7, 17.3, 48 ), ( 0, 90, 0 ), "turret_trap_panel", "s_turret_trap_tower_parking", "turret_trap_panel", undefined, undefined, ( 3618.65, 21844.5, 478.5 ), ( 0, 90, 0 ) );
}

// Namespace mp_jup_tower_ob_interactions_turret_trap_cs / namespace_bdb6a4bf87613c0e
// Params 3
// Checksum 0x0, Offset: 0x629
// Size: 0x162
function function_acf253bd969a3c20( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_tower_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "turret_trap_spawn", "s_turret_trap_tower_rooftop", "turret_trap_spawn", undefined, undefined, ( 15205.1, 22234.8, 1519 ), ( 0, 180, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 88 ), ( 0, 90, 0 ), "s_turret_trap_tower_rooftop", undefined, "activity_turret_trap_tower_rooftop", undefined, undefined, ( 15205.1, 22234.8, 1519 ), ( 0, 180, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 18.7, 17.3, 48 ), ( 0, 90, 0 ), "turret_trap_panel", "s_turret_trap_tower_rooftop", "turret_trap_panel", undefined, undefined, ( 15205.1, 22234.8, 1519 ), ( 0, 180, 0 ) );
}

// Namespace mp_jup_tower_ob_interactions_turret_trap_cs / namespace_bdb6a4bf87613c0e
// Params 3
// Checksum 0x0, Offset: 0x793
// Size: 0x162
function function_ffb2442d8f234045( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_tower_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), "turret_trap_spawn", "s_turret_trap_tower_road", "turret_trap_spawn", undefined, undefined, ( 8337.2, 25377.5, 312 ), ( 0, 90, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 88 ), ( 0, 90, 0 ), "s_turret_trap_tower_road", undefined, "activity_turret_trap_tower_road", undefined, undefined, ( 8337.2, 25377.5, 312 ), ( 0, 90, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 18.7, 17.3, 48 ), ( 0, 90, 0 ), "turret_trap_panel", "s_turret_trap_tower_road", "turret_trap_panel", undefined, undefined, ( 8337.2, 25377.5, 312 ), ( 0, 90, 0 ) );
}

// Namespace mp_jup_tower_ob_interactions_turret_trap_cs / namespace_bdb6a4bf87613c0e
// Params 0
// Checksum 0x0, Offset: 0x8fd
// Size: 0x1e0
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_tower_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 104 );
    instancestruct.scriptstructoriginoffset = ( 3618.65, 21844.5, 478.5 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TURRET_TRAP_TOWER_PARKING" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_tower_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 104 );
    instancestruct.scriptstructoriginoffset = ( 15205.1, 22234.8, 1519 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TURRET_TRAP_TOWER_ROOFTOP" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_tower_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 0, 0, 104 );
    instancestruct.scriptstructoriginoffset = ( 8337.2, 25377.5, 312 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TURRET_TRAP_TOWER_ROAD" ] = instancestruct;
    return activityinstances;
}

