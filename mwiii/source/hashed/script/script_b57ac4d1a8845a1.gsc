#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs;

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 2
// Checksum 0x0, Offset: 0x426
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 3
// Checksum 0x0, Offset: 0x49b
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs" );
}

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 3
// Checksum 0x0, Offset: 0x50a
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 0
// Checksum 0x0, Offset: 0x552
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 0
// Checksum 0x0, Offset: 0x55c
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs" );
}

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 0
// Checksum 0x0, Offset: 0x572
// Size: 0x69
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_UNSTABLE_RIFT_OBELISK";
    activityinfostruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 4
// Checksum 0x0, Offset: 0x5e4
// Size: 0xce
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_9543f5f0db699c6a":
            function_e238ce32e8c33dfb( fe, us, cf );
            break;
        case #"hash_bea0a3d2ceb432b7":
            function_b7e58900423b725e( fe, us, cf );
            break;
        case #"hash_8f74766ce828cfca":
            function_77bd806245bea5ef( fe, us, cf );
            break;
        case #"hash_5623f82aaa152603":
            function_8a608c81c082eaac( fe, us, cf );
            break;
        case #"hash_d14d1233ab102187":
            function_d1feba32e9244488( fe, us, cf );
            break;
        case #"hash_213f800bf8882292":
            function_1c5b22a590c0816b( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 3
// Checksum 0x0, Offset: 0x6ba
// Size: 0x18b
function function_e238ce32e8c33dfb( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -9236.2, 30527.5, 1197.5 ), ( 0, 135, 0 ), "obelisk_spawn", "s_unstable_rift_obelisk_b_construction", "obelisk_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -9236.2, 30526, 1278 ), ( 0, 45, 0 ), "s_unstable_rift_obelisk_b_construction", undefined, "activity_unstable_rift_obelisk_b_construction", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( -9234, 30528, 1195 ), ( 0, 0, 0 ), "obelisk_kill_radius", "s_unstable_rift_obelisk_b_construction", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 3
// Checksum 0x0, Offset: 0x84d
// Size: 0x18b
function function_b7e58900423b725e( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( 3604.82, 35996.6, 1299.5 ), ( 0, 90.5, 0 ), "obelisk_spawn", "s_unstable_rift_obelisk_b_tank", "obelisk_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( 3603.77, 35995.5, 1380 ), ( 0, 0.5, 0 ), "s_unstable_rift_obelisk_b_tank", undefined, "activity_unstable_rift_obelisk_b_tank", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( 3606.74, 35995.4, 1297 ), ( 0, 315.5, 0 ), "obelisk_kill_radius", "s_unstable_rift_obelisk_b_tank", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 3
// Checksum 0x0, Offset: 0x9e0
// Size: 0x18b
function function_77bd806245bea5ef( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( 10304.2, 27290.3, 1027.5 ), ( 0, 152.4, 0 ), "obelisk_spawn", "s_unstable_rift_obelisk_b_bridge", "obelisk_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( 10304.7, 27288.9, 1108 ), ( 0, 62.4, 0 ), "s_unstable_rift_obelisk_b_bridge", undefined, "activity_unstable_rift_obelisk_b_bridge", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( 10306.1, 27291.4, 1025 ), ( 0, 17.4, 0 ), "obelisk_kill_radius", "s_unstable_rift_obelisk_b_bridge", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 3
// Checksum 0x0, Offset: 0xb73
// Size: 0x18b
function function_8a608c81c082eaac( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( 9389.05, 18480, 1028.5 ), ( 0, 121.6, 0 ), "obelisk_spawn", "s_unstable_rift_obelisk_b_drain", "obelisk_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( 9388.75, 18478.6, 1109 ), ( 0, 31.6, 0 ), "s_unstable_rift_obelisk_b_drain", undefined, "activity_unstable_rift_obelisk_b_drain", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( 9391.24, 18480, 1026 ), ( 0, 346.6, 0 ), "obelisk_kill_radius", "s_unstable_rift_obelisk_b_drain", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 3
// Checksum 0x0, Offset: 0xd06
// Size: 0x18b
function function_d1feba32e9244488( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( 5392.98, 24375, 899.5 ), ( 0, 13.7, 0 ), "obelisk_spawn", "s_unstable_rift_obelisk_b_nuclear", "obelisk_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( 5391.74, 24375.7, 980 ), ( 0, 283.7, 0 ), "s_unstable_rift_obelisk_b_nuclear", undefined, "activity_unstable_rift_obelisk_b_nuclear", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( 5392.31, 24372.9, 897 ), ( 0, 238.7, 0 ), "obelisk_kill_radius", "s_unstable_rift_obelisk_b_nuclear", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 3
// Checksum 0x0, Offset: 0xe99
// Size: 0x18b
function function_1c5b22a590c0816b( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -7685.17, 18623.6, 1380.5 ), ( 0, 87.9, 0 ), "obelisk_spawn", "s_unstable_rift_obelisk_b_repair", "obelisk_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -7686.27, 18622.6, 1461 ), ( 0, 357.9, 0 ), "s_unstable_rift_obelisk_b_repair", undefined, "activity_unstable_rift_obelisk_b_repair", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( -7683.32, 18622.3, 1378 ), ( 0, 312.9, 0 ), "obelisk_kill_radius", "s_unstable_rift_obelisk_b_repair", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs / namespace_15ac7d7a0789715f
// Params 0
// Checksum 0x0, Offset: 0x102c
// Size: 0x504
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    instancestruct.cf = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    instancestruct.scriptstructorigin = ( -9238.2, 30526.5, 1327 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -9235.2, 30530.5, 1291 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 500 ];
    activityinstances[ "UNSTABLE_RIFT_OBELISK_B_CONSTRUCTION" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    instancestruct.cf = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    instancestruct.scriptstructorigin = ( 3602.7, 35997.3, 1429 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 3607.63, 35998, 1393 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 500 ];
    activityinstances[ "UNSTABLE_RIFT_OBELISK_B_TANK" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    instancestruct.cf = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    instancestruct.scriptstructorigin = ( 10302.6, 27288.8, 1157 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 10304.3, 27293.4, 1121 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 500 ];
    activityinstances[ "UNSTABLE_RIFT_OBELISK_B_BRIDGE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    instancestruct.cf = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    instancestruct.scriptstructorigin = ( 9386.89, 18479.6, 1158 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 9390.71, 18482.6, 1122 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 500 ];
    activityinstances[ "UNSTABLE_RIFT_OBELISK_B_DRAIN" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    instancestruct.cf = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    instancestruct.scriptstructorigin = ( 5393.27, 24377.1, 1029 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 5394.94, 24372.6, 993 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 500 ];
    activityinstances[ "UNSTABLE_RIFT_OBELISK_B_NUCLEAR" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    instancestruct.cf = "mp_jup_st_b_ob_activities_unstable_rift_obelisk_cs";
    instancestruct.scriptstructorigin = ( -7687.26, 18624.4, 1510 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -7682.3, 18624.9, 1474 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 500 ];
    activityinstances[ "UNSTABLE_RIFT_OBELISK_B_REPAIR" ] = instancestruct;
    return activityinstances;
}

