#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs;

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 2
// Checksum 0x0, Offset: 0x4cb
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 3
// Checksum 0x0, Offset: 0x540
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs" );
}

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 3
// Checksum 0x0, Offset: 0x5af
// Size: 0xd4
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -1626, -13649, 1924 ), ( 0, 0, 0 ), "unstable_rift_portal", undefined, "unstable_rift_portal_g_radio" );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -13044, -6833, 1609 ), ( 0, 0, 0 ), "unstable_rift_portal", undefined, "unstable_rift_portal_g_dam" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 0
// Checksum 0x0, Offset: 0x68b
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 0
// Checksum 0x0, Offset: 0x695
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs" );
}

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 0
// Checksum 0x0, Offset: 0x6ab
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

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 4
// Checksum 0x0, Offset: 0x71d
// Size: 0xe7
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_9f2fbbd5d261007b":
            function_56cc6c43683722de( fe, us, cf );
            break;
        case #"hash_671240db27f26f6d":
            function_f7bcb33553b96986( fe, us, cf );
            break;
        case #"hash_3e95e184c3c0f799":
            function_ec01d555e882e5ae( fe, us, cf );
            break;
        case #"hash_889c447e23b89a3c":
            function_790e4b98abd7a14d( fe, us, cf );
            break;
        case #"hash_d506d61639a90075":
            function_4d6cbdc979e05636( fe, us, cf );
            break;
        case #"hash_e29eb2bdbdbc8f7a":
            function_c962862d2e40e1ff( fe, us, cf );
            break;
        case #"hash_8970abe7c7ae92e6":
            function_c92522ed8b6925f7( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 3
// Checksum 0x0, Offset: 0x80c
// Size: 0x18b
function function_56cc6c43683722de( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -14248, -27113.3, 1707.5 ), ( 0, 343.4, 0 ), "obelisk_spawn", "s_unstable_rift_obelisk_g_rotary", "obelisk_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -14248.7, -27111.9, 1788 ), ( 0, 253.4, 0 ), "s_unstable_rift_obelisk_g_rotary", undefined, "activity_unstable_rift_obelisk_g_rotary", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( -14249.7, -27114.7, 1705 ), ( 0, 208.4, 0 ), "obelisk_kill_radius", "s_unstable_rift_obelisk_g_rotary", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 3
// Checksum 0x0, Offset: 0x99f
// Size: 0x18b
function function_f7bcb33553b96986( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -16427, -36478.3, 2454.5 ), ( 0, 306.6, 0 ), "obelisk_spawn", "s_unstable_rift_obelisk_g_radio", "obelisk_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -16426.8, -36476.8, 2535 ), ( 0, 216.6, 0 ), "s_unstable_rift_obelisk_g_radio", undefined, "activity_unstable_rift_obelisk_g_radio", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( -16429.2, -36478.4, 2452 ), ( 0, 171.6, 0 ), "obelisk_kill_radius", "s_unstable_rift_obelisk_g_radio", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 3
// Checksum 0x0, Offset: 0xb32
// Size: 0x18b
function function_ec01d555e882e5ae( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -12713, -36323.3, 1908.5 ), ( 0, 198.6, 0 ), "obelisk_spawn", "s_unstable_rift_obelisk_g_court", "obelisk_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -12711.7, -36323.9, 1989 ), ( 0, 108.6, 0 ), "s_unstable_rift_obelisk_g_court", undefined, "activity_unstable_rift_obelisk_g_court", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( -12712.5, -36321.1, 1906 ), ( 0, 63.6, 0 ), "obelisk_kill_radius", "s_unstable_rift_obelisk_g_court", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 3
// Checksum 0x0, Offset: 0xcc5
// Size: 0x18b
function function_790e4b98abd7a14d( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -6596.06, -29815.3, 1711.5 ), ( 0, 261.7, 0 ), "obelisk_spawn", "s_unstable_rift_obelisk_g_barber", "obelisk_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -6594.94, -29814.5, 1792 ), ( 0, 171.7, 0 ), "s_unstable_rift_obelisk_g_barber", undefined, "activity_unstable_rift_obelisk_g_barber", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( -6597.8, -29813.9, 1709 ), ( 0, 126.7, 0 ), "obelisk_kill_radius", "s_unstable_rift_obelisk_g_barber", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 3
// Checksum 0x0, Offset: 0xe58
// Size: 0x18b
function function_4d6cbdc979e05636( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -15912.2, -18199.4, 1708.33 ), ( 0, 268.89, 0 ), "obelisk_spawn", "s_unstable_rift_obelisk_g_lot", "obelisk_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -15911.2, -18198.4, 1793 ), ( 0, 178.89, 0 ), "s_unstable_rift_obelisk_g_lot", undefined, "activity_unstable_rift_obelisk_g_lot", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( -15914.1, -18198.2, 1710 ), ( 0, 133.9, 0 ), "obelisk_kill_radius", "s_unstable_rift_obelisk_g_lot", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 3
// Checksum 0x0, Offset: 0xfeb
// Size: 0x18b
function function_c962862d2e40e1ff( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -9724.42, -15145.2, 1712.5 ), ( 0, 312, 0 ), "obelisk_spawn", "s_unstable_rift_obelisk_g_fire", "obelisk_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -9724.36, -15143.8, 1793 ), ( 0, 221.99, 0 ), "s_unstable_rift_obelisk_g_fire", undefined, "activity_unstable_rift_obelisk_g_fire", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( -9726.61, -15145.6, 1710 ), ( 0, 177, 0 ), "obelisk_kill_radius", "s_unstable_rift_obelisk_g_fire", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 3
// Checksum 0x0, Offset: 0x117e
// Size: 0x18b
function function_c92522ed8b6925f7( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -16825.4, -8332.18, 1504.5 ), ( 0, 270, 0 ), "obelisk_spawn", "s_unstable_rift_obelisk_g_market", "obelisk_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    fe [[ f ]]( s, us, cf, ( -16824.4, -8331.18, 1585 ), ( 0, 179.99, 0 ), "s_unstable_rift_obelisk_g_market", undefined, "activity_unstable_rift_obelisk_g_market", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    s.is_cs_trigger = 1;
    s.var_857f45e57f5d5a7a = 1;
    s.height = 128;
    fe [[ f ]]( s, us, cf, ( -16827.3, -8331.01, 1502 ), ( 0, 135, 0 ), "obelisk_kill_radius", "s_unstable_rift_obelisk_g_market", undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ), 512 );
}

// Namespace mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs / namespace_c4351e63e5ee1a1b
// Params 0
// Checksum 0x0, Offset: 0x1311
// Size: 0x5d6
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    instancestruct.cf = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    instancestruct.scriptstructorigin = ( -14246.6, -27111.4, 1837 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -14247.4, -27116.4, 1801 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 500 ];
    activityinstances[ "UNSTABLE_RIFT_OBELISK_G_ROTARY" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    instancestruct.cf = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    instancestruct.scriptstructorigin = ( -16424.8, -36477.6, 2584 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -16428.4, -36481.1, 2548 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 500 ];
    activityinstances[ "UNSTABLE_RIFT_OBELISK_G_RADIO" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    instancestruct.cf = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    instancestruct.scriptstructorigin = ( -12713.1, -36325.6, 2038 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -12715.3, -36321.1, 2002 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 500 ];
    activityinstances[ "UNSTABLE_RIFT_OBELISK_G_COURT" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    instancestruct.cf = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    instancestruct.scriptstructorigin = ( -6594.06, -29816.5, 1841 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -6599.06, -29816.4, 1805 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 500 ];
    activityinstances[ "UNSTABLE_RIFT_OBELISK_G_BARBER" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    instancestruct.cf = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    instancestruct.scriptstructorigin = ( -15910, -18200.3, 1842 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -15915, -18200.9, 1806 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 500 ];
    activityinstances[ "UNSTABLE_RIFT_OBELISK_G_LOT" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    instancestruct.cf = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    instancestruct.scriptstructorigin = ( -9722.24, -15144.4, 1842 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -9725.47, -15148.3, 1806 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 500 ];
    activityinstances[ "UNSTABLE_RIFT_OBELISK_G_FIRE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_unstable_rift_obelisk";
    instancestruct.cf = "mp_jup_st_g_ob_activities_unstable_rift_obelisk_cs";
    instancestruct.scriptstructorigin = ( -16823.2, -8333.05, 1634 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( -16828.2, -8333.79, 1598 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 500 ];
    activityinstances[ "UNSTABLE_RIFT_OBELISK_G_MARKET" ] = instancestruct;
    return activityinstances;
}

