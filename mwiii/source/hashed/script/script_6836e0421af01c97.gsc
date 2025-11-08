#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_i_ob_contracts_escort_cs;

// Namespace mp_jup_st_i_ob_contracts_escort_cs / namespace_43dceaa919761d41
// Params 2
// Checksum 0x0, Offset: 0x413
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_i_ob_contracts_escort_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_i_ob_contracts_escort_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_i_ob_contracts_escort_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_i_ob_contracts_escort_cs / namespace_43dceaa919761d41
// Params 3
// Checksum 0x0, Offset: 0x488
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_i_ob_contracts_escort_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_i_ob_contracts_escort_cs" );
}

// Namespace mp_jup_st_i_ob_contracts_escort_cs / namespace_43dceaa919761d41
// Params 3
// Checksum 0x0, Offset: 0x4f7
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_i_ob_contracts_escort_cs / namespace_43dceaa919761d41
// Params 0
// Checksum 0x0, Offset: 0x53f
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_i_ob_contracts_escort_cs / namespace_43dceaa919761d41
// Params 0
// Checksum 0x0, Offset: 0x549
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_i_ob_contracts_escort_cs" );
}

// Namespace mp_jup_st_i_ob_contracts_escort_cs / namespace_43dceaa919761d41
// Params 0
// Checksum 0x0, Offset: 0x55f
// Size: 0x58
function function_fd69cf02ba4d90a2()
{
    activityinfostruct = spawnstruct();
    activityinfostruct.name = "REV_OB_ESCORT_ZOMBIES";
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
    activityinfostruct.metadatafunction = &function_6da2952367672ac0;
    return activityinfostruct;
}

// Namespace mp_jup_st_i_ob_contracts_escort_cs / namespace_43dceaa919761d41
// Params 4
// Checksum 0x0, Offset: 0x5c0
// Size: 0x51
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_i_ob_contracts_escort_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_f7a2a8e3ebcba546":
            function_fd26cf5ce119bced( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_i_ob_contracts_escort_cs / namespace_43dceaa919761d41
// Params 3
// Checksum 0x0, Offset: 0x619
// Size: 0xb44
function function_fd26cf5ce119bced( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 27855, -24618, 3101.86 ), ( 0, 0, 0 ), "ESCORT_ZOMBIES_I_MANSION_ENTRANCE", undefined, "escort_i_mansion_entrance", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 27444, -30324, 3505 ), ( 0, 35, 0 ), "ESCORT_ZOMBIES_I_MANSION_ENTRANCE_REWARD", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 26586, -25508, 3101.27 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_ambush_01", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 30761, -23685, 3153 ), ( 0, 342.44, 0 ), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_I_MANSION_ENTRANCE", "ESCORT_ZOMBIES_I_MANSION_ENTRANCE", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 26091, -24625, 3100.85 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_ambush_01", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 25295, -25708, 3101.27 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_ambush_02", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 25252, -24830, 3099.93 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_ambush_02", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 23948, -25276, 3111 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_ambush_03", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 21672, -26564, 3177.01 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_ambush_04", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 23988, -26176, 3106.33 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_ambush_04", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 23568, -28320, 3473.89 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_ambush_05", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 23572, -28324, 3473.89 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_ambush_05", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 24272, -29564, 3589 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_ambush_06", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 26092, -29504, 3513 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_ambush_07", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 26068, -30996, 3513 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_ambush_08", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 27756, -30844, 3601 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_ambush_09", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 23180, -25632, 3109.46 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_neutralize_ambush_01", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 24224, -25928, 3121 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_neutralize_ambush_01", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 23542, -24775, 3089.21 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_neutralize_ambush_01", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 23446, -23852, 3005.79 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_neutralize_ambush_01", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 23212, -30176, 3513 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_neutralize_ambush_02", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 24420, -30544, 3497 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_neutralize_ambush_02", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 24972, -28948, 3505 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_neutralize_ambush_02", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 27964, -30556, 3601 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_neutralize_ambush_03", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 27780, -31176, 3601 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_neutralize_ambush_03", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 26016, -31012, 3505 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_neutralize_ambush_03", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 27368, -28832, 3497 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_neutralize_ambush_03", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 25374, -29840, 3503.17 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_horde_02", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 23675, -25208, 3106 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_horde_01", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_i_ob_contracts_escort_cs";
    fe [[ f ]]( s, us, cf, ( 28064, -31004, 3606 ), ( 0, 0, 0 ), "escort_i_mansion_entrance_horde_03", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_i_ob_contracts_escort_cs / namespace_43dceaa919761d41
// Params 0
// Checksum 0x0, Offset: 0x1165
// Size: 0x198
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_activitydef_escort";
    instancestruct.cf = "mp_jup_st_i_ob_contracts_escort_cs";
    instancestruct.scriptstructorigin = ( 28919, -24770, 3104.79 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 23732, -25168, 3111 ), ( 28211, -24750, 3102.44 ), ( 24196, -29504, 3497 ), ( 26944, -30580, 3497 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1000, 1250, 1000, 1000 ];
    activityinstances[ "ESCORT_ZOMBIES_I_MANSION_ENTRANCE" ] = instancestruct;
    return activityinstances;
}

