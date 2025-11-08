#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_launchfacility_zone3_create_script;

// Namespace mp_jup_launchfacility_zone3_create_script / scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_zone3_create_script
// Params 2
// Checksum 0x0, Offset: 0x101
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_launchfacility_zone3_create_script" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_launchfacility_zone3_create_script" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_launchfacility_zone3_create_script" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_launchfacility_zone3_create_script / scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_zone3_create_script
// Params 3
// Checksum 0x0, Offset: 0x176
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_launchfacility_zone3_create_script" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_launchfacility_zone3_create_script" );
}

// Namespace mp_jup_launchfacility_zone3_create_script / scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_zone3_create_script
// Params 3
// Checksum 0x0, Offset: 0x1e5
// Size: 0x8a
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_launchfacility_zone3_create_script";
    fe [[ f ]]( s, us, cf, ( 39190, 34027, 1169 ), ( 0, 0, 0 ), undefined, undefined, "zone3_speaker" );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_launchfacility_zone3_create_script / scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_zone3_create_script
// Params 0
// Checksum 0x0, Offset: 0x277
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_launchfacility_zone3_create_script / scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_zone3_create_script
// Params 0
// Checksum 0x0, Offset: 0x281
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_launchfacility_zone3_create_script" );
}

