#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;

#namespace namespace_963441cb55eef69e;

// Namespace namespace_963441cb55eef69e / namespace_33fccacad4892a25
// Params 0
// Checksum 0x0, Offset: 0x107
// Size: 0x1d
function init()
{
    if ( !getdvarint( @"hash_8bfdc77e20414f2a", 0 ) )
    {
        return;
    }
    
    thread function_38317b48d412b1d5();
}

// Namespace namespace_963441cb55eef69e / namespace_33fccacad4892a25
// Params 0
// Checksum 0x0, Offset: 0x12c
// Size: 0x8c
function function_38317b48d412b1d5()
{
    flag_wait( "scriptables_ready" );
    caralarms = getentitylessscriptablearray( "scriptablecaralarm", "script_noteworthy" );
    
    if ( caralarms.size <= 0 )
    {
        return;
    }
    
    level waittill( "prematch_fade_done" );
    
    foreach ( alarm in caralarms )
    {
        alarm setscriptablepartstate( "base", "alive" );
    }
}

