#namespace namespace_af91bb24f58a4a7d;

// Namespace namespace_af91bb24f58a4a7d / namespace_b3073f6a21b8a0a6
// Params 0
// Checksum 0x0, Offset: 0xfb
// Size: 0x1a
function function_6481fdd7c2eb7d5c()
{
    function_aadc3bf2875b3408( 0.2 );
    function_4c70ed79848813ab( "mgl_ftue_tutorial_loop_01" );
}

// Namespace namespace_af91bb24f58a4a7d / namespace_b3073f6a21b8a0a6
// Params 2
// Checksum 0x0, Offset: 0x11d
// Size: 0x45
function function_ae00f22f048a1f57( soundalias, loop )
{
    assert( isdefined( soundalias ) );
    
    if ( isdefined( loop ) )
    {
        if ( loop )
        {
            self playloopsound( soundalias );
        }
        else
        {
            self playlocalsound( soundalias );
        }
        
        return;
    }
    
    self playlocalsound( soundalias );
}

// Namespace namespace_af91bb24f58a4a7d / namespace_b3073f6a21b8a0a6
// Params 1
// Checksum 0x0, Offset: 0x16a
// Size: 0x1d
function function_4c70ed79848813ab( musicstate )
{
    assert( isdefined( musicstate ) );
    setmusicstate( musicstate );
}

// Namespace namespace_af91bb24f58a4a7d / namespace_b3073f6a21b8a0a6
// Params 1
// Checksum 0x0, Offset: 0x18f
// Size: 0x6e
function function_aadc3bf2875b3408( volume )
{
    if ( getdvarint( @"hash_4b32f268c08cd4e8", 0 ) == 1 )
    {
        return;
    }
    
    clamp( volume, 0, 1 );
    function_adfd4002c83fe6b2( "wpn_plr", volume );
    function_adfd4002c83fe6b2( "wpn_plr_atmo", volume );
    function_adfd4002c83fe6b2( "wpn_plr_mech", volume );
    function_adfd4002c83fe6b2( "wpn_reflections", volume );
    function_adfd4002c83fe6b2( "wpn_reflections_dist", volume );
}

