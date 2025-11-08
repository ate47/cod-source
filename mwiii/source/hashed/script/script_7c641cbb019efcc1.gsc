#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_d_ob_contracts_outlast_cs;

// Namespace mp_jup_st_d_ob_contracts_outlast_cs / namespace_f03f6d33241fa445
// Params 2
// Checksum 0x0, Offset: 0x2d0
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_d_ob_contracts_outlast_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_d_ob_contracts_outlast_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_d_ob_contracts_outlast_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_d_ob_contracts_outlast_cs / namespace_f03f6d33241fa445
// Params 3
// Checksum 0x0, Offset: 0x345
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_d_ob_contracts_outlast_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_d_ob_contracts_outlast_cs" );
}

// Namespace mp_jup_st_d_ob_contracts_outlast_cs / namespace_f03f6d33241fa445
// Params 3
// Checksum 0x0, Offset: 0x3b4
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_d_ob_contracts_outlast_cs / namespace_f03f6d33241fa445
// Params 0
// Checksum 0x0, Offset: 0x3fc
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_d_ob_contracts_outlast_cs / namespace_f03f6d33241fa445
// Params 0
// Checksum 0x0, Offset: 0x406
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_d_ob_contracts_outlast_cs" );
}

// Namespace mp_jup_st_d_ob_contracts_outlast_cs / namespace_f03f6d33241fa445
// Params 0
// Checksum 0x0, Offset: 0x41c
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_OUTLAST";
    activityinfostruct.scriptbundle = "jup_ob_activitydefinition_outlast";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_d_ob_contracts_outlast_cs / namespace_f03f6d33241fa445
// Params 4
// Checksum 0x0, Offset: 0x48e
// Size: 0x6a
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_d_ob_contracts_outlast_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_c311645c98b04902":
            function_cf60010c19e18101( fe, us, cf );
            break;
        case #"hash_4c3a794c61bd7818":
            function_5241efb1693a2c03( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_d_ob_contracts_outlast_cs / namespace_f03f6d33241fa445
// Params 3
// Checksum 0x0, Offset: 0x500
// Size: 0x87f
function function_cf60010c19e18101( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.var_750c4cbbadf7cc32 = ( 179, 338.5, 169.5 );
    s.var_74e936bbadd15418 = ( 131.5, 196.5, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -34881.6, 11296.8, 988.5 ), ( 0, 127.04, 0 ), "outlast_noent_entrance_trigger", "s_outlast_d_rails", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.var_750c4cbbadf7cc32 = ( 113, 87, 85.5 );
    s.var_74e936bbadd15418 = ( 109.5, 196.5, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -36820.1, 10117.8, 988.5 ), ( 0, 127.04, 0 ), "outlast_noent_entrance_trigger", "s_outlast_d_rails", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.var_750c4cbbadf7cc32 = ( 263, 162.5, 94.5 );
    s.var_74e936bbadd15418 = ( 175.5, 232, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -36587.6, 10263.8, 988.5 ), ( 0, 127.04, 0 ), "outlast_noent_entrance_trigger", "s_outlast_d_rails", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -36201, 10794, 966 ), ( 0, 344, 0 ), "ava_tablet", "s_outlast_d_rails", "ava_tablet", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -36025.1, 10597.7, 963.5 ), ( 0, 76.62, 0 ), "s_outlast_d_rails_reward", "s_outlast_d_rails", "s_outlast_d_rails_reward", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -35940.4, 10660.4, 963.5 ), ( 0, 307.46, 0 ), "pnd", "s_outlast_d_rails", "pnd", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -35946, 9742.5, 956.5 ), ( 0, 265, 0 ), "zombie_spawn_wave_1", "s_outlast_d_rails", "zombie_spawn_wave_1", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -35941.7, 10658, 1022 ), ( 0, 217.46, 0 ), "s_outlast_d_rails", "s_outlast_d_rails", "objective_outlast_d_rails", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -33512.5, 11013.2, 952 ), ( 0, 135, 0 ), "zombie_spawn_wave_3", "s_outlast_d_rails", "zombie_spawn_wave_3", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -34352, 12292.2, 958 ), ( 0, 135, 0 ), "zombie_spawn_wave_3", "s_outlast_d_rails", "zombie_spawn_wave_3", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -36225, 8877, 953 ), ( 0, 265, 0 ), "zombie_spawn_wave_2", "s_outlast_d_rails", "zombie_spawn_wave_2", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -38088.5, 9536.75, 944.5 ), ( 0, 265, 0 ), "zombie_spawn_wave_2", "s_outlast_d_rails", "zombie_spawn_wave_2", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -35233, 5026.5, 962.25 ), ( 0, 204.24, 0 ), "activity_nexus_instance_joiner", "s_outlast_d_rails", "OUTLAST_D_RAILS", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.var_750c4cbbadf7cc32 = ( 289.5, 1349, 222.5 );
    s.var_74e936bbadd15418 = ( 290.5, 329, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -35509.1, 11047.8, 988.5 ), ( 0, 127.04, 0 ), "outlast_noent_entrance_trigger", "s_outlast_d_rails", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -35862.5, 10901, 946 ), ( 0, 135, 0 ), "outlast_space", "s_outlast_d_rails", "outlast_space", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1600 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -35190.2, 9489.5, 958 ), ( 0, 265, 0 ), "zombie_spawn_wave_1", "s_outlast_d_rails", "zombie_spawn_wave_1", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_d_ob_contracts_outlast_cs / namespace_f03f6d33241fa445
// Params 3
// Checksum 0x0, Offset: 0xd87
// Size: 0x6d0
function function_5241efb1693a2c03( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.var_750c4cbbadf7cc32 = ( 244.5, 1274, 147.5 );
    s.var_74e936bbadd15418 = ( 139.5, 242, 160 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -32979.1, 3937.8, 1212.5 ), ( 0, 99.94, 0 ), "outlast_noent_entrance_trigger", "s_outlast_d_warehouse", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -34009, 3836, 970 ), ( 0, 183, 0 ), "ava_tablet", "s_outlast_d_warehouse", "ava_tablet", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -33213.1, 3941.7, 967.5 ), ( 0, 229.12, 0 ), "s_outlast_d_warehouse_reward", "s_outlast_d_warehouse", "s_outlast_d_warehouse_reward", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -33317.2, 3925.2, 967.5 ), ( 0, 99.96, 0 ), "pnd", "s_outlast_d_warehouse", "pnd", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -34562, 2847.5, 955.5 ), ( 0, 265, 0 ), "zombie_spawn_wave_1", "s_outlast_d_warehouse", "zombie_spawn_wave_1", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -33314.9, 3926.73, 1026 ), ( 0, 9.96, 0 ), "s_outlast_d_warehouse", "s_outlast_d_warehouse", "objective_outlast_d_warehouse", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -32035.2, 3219.25, 962 ), ( 0, 135, 0 ), "zombie_spawn_wave_3", "s_outlast_d_warehouse", "zombie_spawn_wave_3", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -32219, 4825.25, 954 ), ( 0, 135, 0 ), "zombie_spawn_wave_3", "s_outlast_d_warehouse", "zombie_spawn_wave_3", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -33506, 2272, 956 ), ( 0, 265, 0 ), "zombie_spawn_wave_2", "s_outlast_d_warehouse", "zombie_spawn_wave_2", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -33999.2, 5292, 934.5 ), ( 0, 265, 0 ), "zombie_spawn_wave_2", "s_outlast_d_warehouse", "zombie_spawn_wave_2", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    s.name = "script_struct_nexus_activity_joiner";
    fe [[ f ]]( s, us, cf, ( -30941.8, -826.5, 965.5 ), ( 0, 138.03, 0 ), "activity_nexus_instance_joiner", "s_outlast_d_warehouse", "OUTLAST_D_WAREHOUSE", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.var_750c4cbbadf7cc32 = ( 538.5, 1349, 147.5 );
    s.var_74e936bbadd15418 = ( 441.5, 337, 32 );
    s.height = 128;
    s.length = "128";
    s.width = "128";
    fe [[ f ]]( s, us, cf, ( -32979.1, 3937.8, 999.5 ), ( 0, 99.94, 0 ), "outlast_noent_entrance_trigger", "s_outlast_d_warehouse", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -33464.2, 3820.75, 1028 ), ( 0, 135, 0 ), "outlast_space", "s_outlast_d_warehouse", "outlast_space", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 1300 );
    s = s();
    s.cs_flag = "mp_jup_st_d_ob_contracts_outlast_cs";
    fe [[ f ]]( s, us, cf, ( -34949.5, 4915.25, 954 ), ( 0, 265, 0 ), "zombie_spawn_wave_1", "s_outlast_d_warehouse", "zombie_spawn_wave_1", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_d_ob_contracts_outlast_cs / namespace_f03f6d33241fa445
// Params 0
// Checksum 0x0, Offset: 0x145f
// Size: 0x1bc
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
    instancestruct.cf = "mp_jup_st_d_ob_contracts_outlast_cs";
    instancestruct.scriptstructorigin = ( -35938.3, 10661, 1013 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -35872, 10917, 976.5 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1600 ];
    activityinstances[ "OUTLAST_D_RAILS" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
    instancestruct.cf = "mp_jup_st_d_ob_contracts_outlast_cs";
    instancestruct.scriptstructorigin = ( -33319.3, 3925.63, 1017 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -33481.5, 3816.5, 1014.5 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1300 ];
    activityinstances[ "OUTLAST_D_WAREHOUSE" ] = instancestruct;
    return activityinstances;
}

