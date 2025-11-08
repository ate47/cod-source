#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_tower_ob_contracts_zombie_control_cs;

// Namespace mp_jup_tower_ob_contracts_zombie_control_cs / namespace_44249a7b317e6c20
// Params 2
// Checksum 0x0, Offset: 0x2cb
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_tower_ob_contracts_zombie_control_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_tower_ob_contracts_zombie_control_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_tower_ob_contracts_zombie_control_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_tower_ob_contracts_zombie_control_cs / namespace_44249a7b317e6c20
// Params 3
// Checksum 0x0, Offset: 0x340
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_tower_ob_contracts_zombie_control_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_tower_ob_contracts_zombie_control_cs" );
}

// Namespace mp_jup_tower_ob_contracts_zombie_control_cs / namespace_44249a7b317e6c20
// Params 3
// Checksum 0x0, Offset: 0x3af
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_tower_ob_contracts_zombie_control_cs / namespace_44249a7b317e6c20
// Params 0
// Checksum 0x0, Offset: 0x3f7
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_tower_ob_contracts_zombie_control_cs / namespace_44249a7b317e6c20
// Params 0
// Checksum 0x0, Offset: 0x401
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_tower_ob_contracts_zombie_control_cs" );
}

// Namespace mp_jup_tower_ob_contracts_zombie_control_cs / namespace_44249a7b317e6c20
// Params 0
// Checksum 0x0, Offset: 0x417
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_ZOMBIE_CONTROL";
    activityinfostruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_tower_ob_contracts_zombie_control_cs / namespace_44249a7b317e6c20
// Params 4
// Checksum 0x0, Offset: 0x489
// Size: 0x51
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_tower_ob_contracts_zombie_control_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_c50e4156838da89b":
            function_d33c9cf9cc738472( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_tower_ob_contracts_zombie_control_cs / namespace_44249a7b317e6c20
// Params 3
// Checksum 0x0, Offset: 0x4e2
// Size: 0x4aa
function function_d33c9cf9cc738472( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_tower_ob_contracts_zombie_control_cs";
    fe [[ f ]]( s, us, cf, ( 20133, 21817, 3096.74 ), ( 0, 135, 0 ), "control_point_5", "s_zombie_control_tower", "control_spawn_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_contracts_zombie_control_cs";
    fe [[ f ]]( s, us, cf, ( 15774.2, 22422.4, 1519 ), ( 0, 225, 0 ), "control_point_6", "s_zombie_control_tower", "control_spawn_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_contracts_zombie_control_cs";
    fe [[ f ]]( s, us, cf, ( 14535.1, 25452.8, 2407 ), ( 0, 225, 0 ), "control_point_2", "s_zombie_control_tower", "control_spawn_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_contracts_zombie_control_cs";
    fe [[ f ]]( s, us, cf, ( 8140.79, 22717.6, 1954.58 ), ( 0, 225, 0 ), "control_point_1", "s_zombie_control_tower", "control_spawn_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_contracts_zombie_control_cs";
    s.name = "script_struct";
    fe [[ f ]]( s, us, cf, ( 7046.72, 25227, 2684.5 ), ( 0, 180.22, 0 ), "s_zombie_control_tower", "s_zombie_control_tower", "objective_zombie_control_tower", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_contracts_zombie_control_cs";
    fe [[ f ]]( s, us, cf, ( 7204.39, 25248.8, 2684.5 ), ( 0, 350.82, 0 ), "s_zombie_control_tower_reward", "s_zombie_control_tower", "objective_reward_struct", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_contracts_zombie_control_cs";
    fe [[ f ]]( s, us, cf, ( 14712.8, 23239.9, 1518.95 ), ( 0, 110.11, 0 ), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_tower", "zombie_control_start_interact_inhibitor_model", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_contracts_zombie_control_cs";
    fe [[ f ]]( s, us, cf, ( 7779.97, 25404.4, 2176.61 ), ( 0, 117.31, 0 ), "activity_nexus_instance_joiner", "s_zombie_control_tower", "ZOMBIE_CONTROL_TOWER", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_contracts_zombie_control_cs";
    fe [[ f ]]( s, us, cf, ( 15132, 23439.1, 415 ), ( 0, 0, 0 ), "zombie_control_quest_circle", "s_zombie_control_tower", "zombie_control_quest_circle", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 10000 );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_contracts_zombie_control_cs";
    fe [[ f ]]( s, us, cf, ( 20299.8, 25810.1, 2700 ), ( 0, 225, 0 ), "control_point_4", "s_zombie_control_tower", "control_spawn_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_tower_ob_contracts_zombie_control_cs";
    fe [[ f ]]( s, us, cf, ( 15065.1, 17007.9, 1707 ), ( 0, 225, 0 ), "control_point_3", "s_zombie_control_tower", "control_spawn_point", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_tower_ob_contracts_zombie_control_cs / namespace_44249a7b317e6c20
// Params 0
// Checksum 0x0, Offset: 0x994
// Size: 0xe9
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
    instancestruct.cf = "mp_jup_tower_ob_contracts_zombie_control_cs";
    instancestruct.scriptstructorigin = ( 7014.38, 25271, 2684.5 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 7021.1, 25205.2, 2684.5 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "ZOMBIE_CONTROL_TOWER" ] = instancestruct;
    return activityinstances;
}

