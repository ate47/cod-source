#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_fort_ob_interactions_turret_trap_cs;

// Namespace mp_jup_fort_ob_interactions_turret_trap_cs / namespace_9607052b3c2afb1a
// Params 2
// Checksum 0x0, Offset: 0x378
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_fort_ob_interactions_turret_trap_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_fort_ob_interactions_turret_trap_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_fort_ob_interactions_turret_trap_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_fort_ob_interactions_turret_trap_cs / namespace_9607052b3c2afb1a
// Params 3
// Checksum 0x0, Offset: 0x3ed
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_fort_ob_interactions_turret_trap_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_fort_ob_interactions_turret_trap_cs" );
}

// Namespace mp_jup_fort_ob_interactions_turret_trap_cs / namespace_9607052b3c2afb1a
// Params 3
// Checksum 0x0, Offset: 0x45c
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_fort_ob_interactions_turret_trap_cs / namespace_9607052b3c2afb1a
// Params 0
// Checksum 0x0, Offset: 0x4a4
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_fort_ob_interactions_turret_trap_cs / namespace_9607052b3c2afb1a
// Params 0
// Checksum 0x0, Offset: 0x4ae
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

// Namespace mp_jup_fort_ob_interactions_turret_trap_cs / namespace_9607052b3c2afb1a
// Params 4
// Checksum 0x0, Offset: 0x520
// Size: 0xce
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_e24388b315d99499":
            function_f88c6f5fbe851ac4( fe, us, cf );
            break;
        case #"hash_aba6b945b4fb1884":
            function_1a9b3470d746ffc1( fe, us, cf );
            break;
        case #"hash_ad1a92b4a88d6a2d":
            function_6b789baf710347a( fe, us, cf );
            break;
        case #"hash_1831b65e9e90e157":
            function_331506fcf9b66040( fe, us, cf );
            break;
        case #"hash_533b64c918519f84":
            function_f1fcff6d2129dd0b( fe, us, cf );
            break;
        case #"hash_7b426c04ed249c43":
            function_8635dce6619d01be( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_fort_ob_interactions_turret_trap_cs / namespace_9607052b3c2afb1a
// Params 3
// Checksum 0x0, Offset: 0x5f6
// Size: 0x12f
function function_f88c6f5fbe851ac4( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    fe [[ f ]]( s, us, cf, ( 17320, -52196, 961 ), ( 0, 225, 0 ), "turret_trap_spawn", "s_turret_trap_fort_front", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 17320, -52196, 1049 ), ( 0, 135, 0 ), "s_turret_trap_fort_front", undefined, "activity_turret_trap_fort_front", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 17297, -52207, 1009 ), ( 0, 135, 0 ), "turret_trap_panel", "s_turret_trap_fort_front", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_fort_ob_interactions_turret_trap_cs / namespace_9607052b3c2afb1a
// Params 3
// Checksum 0x0, Offset: 0x72d
// Size: 0x12f
function function_1a9b3470d746ffc1( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    fe [[ f ]]( s, us, cf, ( 19728, -49192, 510 ), ( 0, 270, 0 ), "turret_trap_spawn", "s_turret_trap_fort_gas_station", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 19728, -49192, 598 ), ( 0, 180, 0 ), "s_turret_trap_fort_gas_station", undefined, "activity_turret_trap_fort_gas_station", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 19720, -49216, 558 ), ( 0, 180, 0 ), "turret_trap_panel", "s_turret_trap_fort_gas_station", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_fort_ob_interactions_turret_trap_cs / namespace_9607052b3c2afb1a
// Params 3
// Checksum 0x0, Offset: 0x864
// Size: 0x12f
function function_6b789baf710347a( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    fe [[ f ]]( s, us, cf, ( 12488, -53438, 712 ), ( 0, 0, 0 ), "turret_trap_spawn", "s_turret_trap_fort_west", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 12488, -53438, 800 ), ( 0, 270, 0 ), "s_turret_trap_fort_west", undefined, "activity_turret_trap_fort_west", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 12512, -53446.5, 760 ), ( 0, 270, 0 ), "turret_trap_panel", "s_turret_trap_fort_west", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_fort_ob_interactions_turret_trap_cs / namespace_9607052b3c2afb1a
// Params 3
// Checksum 0x0, Offset: 0x99b
// Size: 0x12f
function function_331506fcf9b66040( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    fe [[ f ]]( s, us, cf, ( 21821, -54337, 839 ), ( 0, 90, 0 ), "turret_trap_spawn", "s_turret_trap_fort_east", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 21821, -54337, 927 ), ( 0, 0, 0 ), "s_turret_trap_fort_east", undefined, "activity_turret_trap_fort_east", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 21830, -54313, 887 ), ( 0, 0, 0 ), "turret_trap_panel", "s_turret_trap_fort_east", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_fort_ob_interactions_turret_trap_cs / namespace_9607052b3c2afb1a
// Params 3
// Checksum 0x0, Offset: 0xad2
// Size: 0x12f
function function_f1fcff6d2129dd0b( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    fe [[ f ]]( s, us, cf, ( 16860, -54105, 1472 ), ( 0, 0, 0 ), "turret_trap_spawn", "s_turret_trap_fort_roof", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 16860, -54105, 1560 ), ( 0, 270, 0 ), "s_turret_trap_fort_roof", undefined, "activity_turret_trap_fort_roof", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 16884, -54114, 1520 ), ( 0, 270, 0 ), "turret_trap_panel", "s_turret_trap_fort_roof", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_fort_ob_interactions_turret_trap_cs / namespace_9607052b3c2afb1a
// Params 3
// Checksum 0x0, Offset: 0xc09
// Size: 0x12f
function function_8635dce6619d01be( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    fe [[ f ]]( s, us, cf, ( 18581, -57526, 524 ), ( 0, 45, 0 ), "turret_trap_spawn", "s_turret_trap_fort_south", "turret_trap_spawn", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 18581, -57526, 612 ), ( 0, 315, 0 ), "s_turret_trap_fort_south", undefined, "activity_turret_trap_fort_south", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 18604, -57515, 572 ), ( 0, 315, 0 ), "turret_trap_panel", "s_turret_trap_fort_south", "turret_trap_panel", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
}

// Namespace mp_jup_fort_ob_interactions_turret_trap_cs / namespace_9607052b3c2afb1a
// Params 0
// Checksum 0x0, Offset: 0xd40
// Size: 0x3a8
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 17320, -52196, 1065 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TURRET_TRAP_FORT_FRONT" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 19728, -49192, 614 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TURRET_TRAP_FORT_GAS_STATION" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 12488, -53438, 816 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TURRET_TRAP_FORT_WEST" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 21821, -54337, 943 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TURRET_TRAP_FORT_EAST" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 16860, -54105, 1576 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TURRET_TRAP_FORT_ROOF" ] = instancestruct;
    instancestruct = spawnstruct();
    instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
    instancestruct.cf = "mp_jup_fort_ob_interactions_turret_trap_cs";
    instancestruct.scriptstructorigin = ( 18581, -57526, 628 );
    instancestruct.scriptstructoriginoffset = ( 0, 0, 0 );
    instancestruct.locationorigin = [];
    instancestruct.locationoriginoffset = [];
    instancestruct.var_45283ef87b6e04b6 = [];
    instancestruct.locationradius = [];
    activityinstances[ "TURRET_TRAP_FORT_SOUTH" ] = instancestruct;
    return activityinstances;
}

