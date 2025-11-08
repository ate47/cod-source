#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs;

// Namespace mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs / namespace_3d5b99ceb1f529f8
// Params 2
// Checksum 0x0, Offset: 0x1cf
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs / namespace_3d5b99ceb1f529f8
// Params 3
// Checksum 0x0, Offset: 0x244
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs" );
}

// Namespace mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs / namespace_3d5b99ceb1f529f8
// Params 3
// Checksum 0x0, Offset: 0x2b3
// Size: 0x40
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs / namespace_3d5b99ceb1f529f8
// Params 0
// Checksum 0x0, Offset: 0x2fb
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs / namespace_3d5b99ceb1f529f8
// Params 0
// Checksum 0x0, Offset: 0x305
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

// Namespace mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs / namespace_3d5b99ceb1f529f8
// Params 4
// Checksum 0x0, Offset: 0x366
// Size: 0x51
function function_82613e20fba2deb9( instancename, fe, us, cf )
{
    if ( !isdefined( cf ) )
    {
        cf = "mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs";
    }
    
    switch ( instancename )
    {
        case #"hash_3657d39239c45827":
            function_8887d7e962667822( fe, us, cf );
            break;
    }
}

// Namespace mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs / namespace_3d5b99ceb1f529f8
// Params 3
// Checksum 0x0, Offset: 0x3bf
// Size: 0x195
function function_8887d7e962667822( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    fe [[ f ]]( s, us, cf, ( 5363, -8641, 2001 ), ( 0, 198, 0 ), "s_escort_zombies_oldtown", undefined, "escort_oldtown", undefined, undefined, ( 0, 0, 0 ) );
    s = s();
    s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
    fe [[ f ]]( s, us, cf, ( 5363, -8641, 1963 ), ( 0, 198, 0 ), "atv_spawn", undefined, "escort_oldtown", undefined, undefined, ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 5378, -8636, 1975 ), ( 0, 288, 0 ), "escort_package", undefined, "escort_oldtown", undefined, undefined, ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( 5411, -8625, 1963 ), ( 0, 17, 0 ), "interact_escort", undefined, "escort_oldtown", undefined, undefined, ( 0, 0, 0 ) );
    s = s();
    fe [[ f ]]( s, us, cf, ( -1674, -8508, 2833.72 ), ( 0, 225, 0 ), "s_escort_zombies_oldtown_reward", undefined, undefined, undefined, undefined, ( 0, 0, 0 ) );
}

// Namespace mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs / namespace_3d5b99ceb1f529f8
// Params 0
// Checksum 0x0, Offset: 0x55c
// Size: 0xa7
function function_6da2952367672ac0()
{
    activityinstances = [];
    instancestruct = spawnstruct();
    instancestruct.cf = "mp_jup_st_e_ob_objectives_oldtown_zombies_escort_cs";
    instancestruct.locationorigin = [ ( 5293, -8660, 1955.29 ) ];
    instancestruct.locationoriginoffset = [ ( 0, 0, 0 ) ];
    instancestruct.var_45283ef87b6e04b6 = [ ( 0, 0, 0 ) ];
    instancestruct.locationradius = [ 1500 ];
    activityinstances[ "ESCORT_ZOMBIES_OLDTOWN" ] = instancestruct;
    return activityinstances;
}

