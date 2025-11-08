#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_f_ob_interactions_turret_trap_cs;

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 2
// Checksum 0x0, Offset: 0x39e
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_f_ob_interactions_turret_trap_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_f_ob_interactions_turret_trap_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_f_ob_interactions_turret_trap_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 3
// Checksum 0x0, Offset: 0x413
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_f_ob_interactions_turret_trap_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_f_ob_interactions_turret_trap_cs" );
}

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 3
// Checksum 0x0, Offset: 0x482
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 0
// Checksum 0x0, Offset: 0x4ca
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 0
// Checksum 0x0, Offset: 0x4d4
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_st_f_ob_interactions_turret_trap_cs" );
}

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 0
// Checksum 0x0, Offset: 0x4ea
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

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 4
// Checksum 0x0, Offset: 0x55c
// Size: 0xe7
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_486fe0a766be194f":
            function_92d441dd8b4c820a( fe, us, cf );
            break;
        case #"hash_881342ea73ddfa69":
            function_2f5ffeb7f8b69ec6( fe, us, cf );
            break;
        case #"hash_3ef11d2d30168b04":
            function_a3e8140b9d1227e3( fe, us, cf );
            break;
        case #"hash_98f2adfbfc4c66c7":
            function_15fead11ebb67920( fe, us, cf );
            break;
        case #"hash_4094ab1a15d620fe":
            function_a94ddcf71dd25ccf( fe, us, cf );
            break;
        case #"hash_c244752af50df861":
            function_afb43bee169e245c( fe, us, cf );
            break;
        case #"hash_85a0b8bc71fb3b8e":
            function_144344db8fe567ed( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 3
// Checksum 0x0, Offset: 0x64b
// Size: 0x162
function function_92d441dd8b4c820a( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 41046, 11705.8, 3364.5 ), ( 0, 268, 0 ), "turret_trap_spawn", "s_turret_trap_f_town", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 41047.1, 11706.9, 3449 ), ( 0, 178, 0 ), "s_turret_trap_f_town", undefined, "activity_turret_trap_f_town", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 41043.9, 11678, 3414.5 ), ( 0, 178, 0 ), "turret_trap_panel", "s_turret_trap_f_town", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 3
// Checksum 0x0, Offset: 0x7b5
// Size: 0x162
function function_2f5ffeb7f8b69ec6( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 25995, 6395.8, 1564.5 ), ( 0, 332.8, 0 ), "turret_trap_spawn", "s_turret_trap_f_shack", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 25994.5, 6397.27, 1649 ), ( 0, 242.8, 0 ), "s_turret_trap_f_shack", undefined, "activity_turret_trap_f_shack", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 26019.3, 6382.06, 1614.5 ), ( 0, 242.8, 0 ), "turret_trap_panel", "s_turret_trap_f_shack", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 3
// Checksum 0x0, Offset: 0x91f
// Size: 0x162
function function_a3e8140b9d1227e3( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 30658.4, -5246.76, 2736.5 ), ( 0, 246.7, 0 ), "turret_trap_spawn", "s_turret_trap_f_cliffside", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 30659.8, -5246.16, 2821 ), ( 0, 156.7, 0 ), "s_turret_trap_f_cliffside", undefined, "activity_turret_trap_f_cliffside", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 30646.3, -5271.94, 2786.5 ), ( 0, 156.7, 0 ), "turret_trap_panel", "s_turret_trap_f_cliffside", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 3
// Checksum 0x0, Offset: 0xa89
// Size: 0x162
function function_15fead11ebb67920( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 31180.2, -1416.68, 2239.5 ), ( 0, 119.6, 0 ), "turret_trap_spawn", "s_turret_trap_f_crossroad", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 31179.8, -1418.16, 2324 ), ( 0, 29.6, 0 ), "s_turret_trap_f_crossroad", undefined, "activity_turret_trap_f_crossroad", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 31167.4, -1391.84, 2289.5 ), ( 0, 29.6, 0 ), "turret_trap_panel", "s_turret_trap_f_crossroad", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 3
// Checksum 0x0, Offset: 0xbf3
// Size: 0x162
function function_a94ddcf71dd25ccf( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 33605.2, -12337.1, 3127.75 ), ( 0, 283.8, 0 ), "turret_trap_spawn", "s_turret_trap_f_cafe", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 33605.9, -12335.8, 3212.25 ), ( 0, 193.8, 0 ), "s_turret_trap_f_cafe", undefined, "activity_turret_trap_f_cafe", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 33610.8, -12364.5, 3177.75 ), ( 0, 193.8, 0 ), "turret_trap_panel", "s_turret_trap_f_cafe", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 3
// Checksum 0x0, Offset: 0xd5d
// Size: 0x162
function function_afb43bee169e245c( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 43700.1, -4199.84, 3294.5 ), ( 0, 265.1, 0 ), "turret_trap_spawn", "s_turret_trap_f_shipment", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 43701.3, -4198.83, 3379 ), ( 0, 175.1, 0 ), "s_turret_trap_f_shipment", undefined, "activity_turret_trap_f_shipment", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 43696.6, -4227.55, 3344.5 ), ( 0, 175.1, 0 ), "turret_trap_panel", "s_turret_trap_f_shipment", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 3
// Checksum 0x0, Offset: 0xec7
// Size: 0x162
function function_144344db8fe567ed( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 31266.7, 4892.85, 2376.5 ), ( 0, 301.5, 0 ), "turret_trap_spawn", "s_turret_trap_f_tin", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 31267.1, 4894.38, 2461 ), ( 0, 211.5, 0 ), "s_turret_trap_f_tin", undefined, "activity_turret_trap_f_tin", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    s.cs_flag = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    fe [[ f ]]( s, us, cf, ( 31280.3, 4868.47, 2426.5 ), ( 0, 211.5, 0 ), "turret_trap_panel", "s_turret_trap_f_tin", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_f_ob_interactions_turret_trap_cs / namespace_406c2f76088a332b
// Params 0
// Checksum 0x0, Offset: 0x1031
// Size: 0x5cf
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 41048.1, 11705, 3467 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 41049.9, 11701.5, 3497 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_F_TOWN" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 25996.6, 6397.36, 1667 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 26000.6, 6397.5, 1697 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_F_SHACK" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 30660, -5248.25, 2839 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 30660.4, -5252.23, 2869 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_F_CLIFFSIDE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 31178, -1417.06, 2342 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 31174.6, -1414.97, 2372 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_F_CROSSROAD" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 33607.4, -12337.3, 3230.25 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 33610.1, -12340.3, 3260.25 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_F_CAFE" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 43702.1, -4200.74, 3397 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 43703.8, -4204.4, 3427 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_F_SHIPMENT" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_st_f_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 31268.8, 4893.31, 2479 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [ ( 31272.4, 4891.38, 2509 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 100 ];
    activityinstances[ "TURRET_TRAP_F_TIN" ] = instancestruct;
    return activityinstances;
}

