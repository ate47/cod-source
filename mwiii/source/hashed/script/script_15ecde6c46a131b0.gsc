#using scripts\common\create_script_utility;
#using scripts\engine\utility;

#namespace mp_jup_sira_ob_ambient_blockers_cs;

// Namespace mp_jup_sira_ob_ambient_blockers_cs / namespace_b5341cf5cfc91b36
// Params 2
// Checksum 0x0, Offset: 0xfd
// Size: 0x6d
function main( unused, us )
{
    if ( flag_exist( "mp_jup_sira_ob_ambient_blockers_cs" ) )
    {
        return;
    }
    
    if ( !isdefined( us ) )
    {
        us = function_b055d49370405173();
    }
    
    flag_init( "mp_jup_sira_ob_ambient_blockers_cs" );
    s = spawnstruct();
    level thread cs_return_and_wait_for_flag( us, s, "mp_jup_sira_ob_ambient_blockers_cs" );
    
    if ( !cs_is_starttime() )
    {
        endcreatescript( s );
    }
}

// Namespace mp_jup_sira_ob_ambient_blockers_cs / namespace_b5341cf5cfc91b36
// Params 3
// Checksum 0x0, Offset: 0x172
// Size: 0x67
function cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( "game_ended" );
    wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s cs_setup_arrays( us, "mp_jup_sira_ob_ambient_blockers_cs" );
    cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread wait_for_flags( s, "mp_jup_sira_ob_ambient_blockers_cs" );
}

// Namespace mp_jup_sira_ob_ambient_blockers_cs / namespace_b5341cf5cfc91b36
// Params 3
// Checksum 0x0, Offset: 0x1e1
// Size: 0x120
function createstructs( fe, us, cf )
{
    f = &strike_additem;
    s = s();
    s.cs_flag = "mp_jup_sira_ob_ambient_blockers_cs";
    fe [[ f ]]( s, us, cf, ( -29938.6, -30830.4, 256.59 ), ( 0, 0, 0 ), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = s();
    s.cs_flag = "mp_jup_sira_ob_ambient_blockers_cs";
    fe [[ f ]]( s, us, cf, ( -29085.2, -30822.1, 257.54 ), ( 0, 0, 0 ), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    s = s();
    s.cs_flag = "mp_jup_sira_ob_ambient_blockers_cs";
    fe [[ f ]]( s, us, cf, ( -29531.1, -30820.9, 257.44 ), ( 0, 0, 0 ), "s_ambient_blocker", undefined, undefined, undefined, undefined, undefined, undefined, 100 );
    fe ent_flag_set( "cs_objects_created" );
    function_7af6d59eef91a7dd();
}

// Namespace mp_jup_sira_ob_ambient_blockers_cs / namespace_b5341cf5cfc91b36
// Params 0
// Checksum 0x0, Offset: 0x309
// Size: 0x2
function function_7af6d59eef91a7dd()
{
    
}

// Namespace mp_jup_sira_ob_ambient_blockers_cs / namespace_b5341cf5cfc91b36
// Params 0
// Checksum 0x0, Offset: 0x313
// Size: 0xe
function cleanup()
{
    function_71a564b3bc009618( "mp_jup_sira_ob_ambient_blockers_cs" );
}

