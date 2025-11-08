#using scripts\engine\utility;

#namespace lighting_dvars;

// Namespace lighting_dvars / namespace_fa30e36ae6a8ad2f
// Params 0
// Checksum 0x0, Offset: 0xfd
// Size: 0x7af
function init()
{
    wait 0.05;
    flag_wait( "player_spawned_with_loadout" );
    
    if ( level.player isps4player() || level.player isxb3player() )
    {
        setdvar( @"hash_8adcf05d62fe94fd", 0 );
        setdvar( @"hash_1d03444cd52cc348", 0 );
        setdvar( @"hash_6d194d6c7f21172e", 1 );
        setdvar( @"hash_2d74914ecc30bb62", 16 );
        setdvar( @"hash_4778772d83d5a997", "8 0 1 0" );
        setdvar( @"hash_8dfe778be90d1cbc", 0 );
        setdvar( @"hash_e3f56fe404e467cb", 2 );
        setdvar( @"hash_5b73c78e77a0a6d5", 1 );
        setdvar( @"hash_6e3f8cef6be16b33", 0 );
        setdvar( @"hash_1ea8544d78048529", 0 );
        setdvar( @"hash_ea4c44a08cd23d5d", 0.2 );
        setdvar( @"hash_dacffbfd52c2fdc5", 8 );
        setdvar( @"hash_5d66c2ef5a9612e0", 1 );
        setdvar( @"hash_eca4b727b01fd254", 8 );
        setdvar( @"hash_63eb1893f96ac98d", 4 );
        setdvar( @"hash_e08232af8b8b695c", 2 );
        setdvar( @"hash_5a83a561cb4970b2", "2176" );
        setdvar( @"sm_sunsamplesizenear", 0.25 );
        setdvar( @"hash_4c14e16355aa5cb0", 2 );
        setdvar( @"hash_4c14e46355aa6349", 2 );
        setdvar( @"hash_63b517de4ccc57cd", 0 );
        setdvar( @"sm_spotdistcull", 0 );
        setdvar( @"r_spotlightentityshadows", 0 );
        setdvar( @"hash_1dde331a8e0153d8", 4 );
        setdvar( @"hash_a083dfcc7a54f85f", 1 );
        setdvar( @"hash_f1d740f1f4306d8f", 1 );
        setdvar( @"hash_898c20905541cb73", 1 );
        setdvar( @"hash_633e1a62bb5ceeb2", 1 );
        setdvar( @"hash_1fc47d6f68e1faf", 0 );
        setdvar( @"hash_5b1b5bd738a5436f", 0 );
        setdvar( @"hash_93b4b56b615317b9", 999999 );
        setdvar( @"hash_6af4238b48dd61c", 0 );
        setdvar( @"hash_9dae7d2931a373dd", 1 );
        setdvar( @"hash_68f03c897f2ed29e", 2 );
        setdvar( @"hash_924d46a5bf2c1f5d", 1.5 );
        setdvar( @"hash_a32719b6bbd25f1e", 1.5 );
        setdvar( @"hash_55f8fe20a6ed10b5", 1 );
        return;
    }
    
    if ( level.player ispcplayer() )
    {
        setdvar( @"hash_8adcf05d62fe94fd", 0 );
        setdvar( @"hash_1d03444cd52cc348", 0 );
        setdvar( @"hash_6d194d6c7f21172e", 1 );
        setdvar( @"hash_5b73c78e77a0a6d5", 1 );
        setdvar( @"hash_2d74914ecc30bb62", 16 );
        setdvar( @"hash_4778772d83d5a997", "8 0 1 0" );
        setdvar( @"hash_6e3f8cef6be16b33", 1 );
        setdvar( @"hash_1ea8544d78048529", 1 );
        setdvar( @"hash_ea4c44a08cd23d5d", 0.2 );
        setdvar( @"hash_dacffbfd52c2fdc5", 8 );
        setdvar( @"hash_5d66c2ef5a9612e0", 1 );
        setdvar( @"hash_eca4b727b01fd254", 8 );
        setdvar( @"hash_63eb1893f96ac98d", 4 );
        setdvar( @"hash_e08232af8b8b695c", 2 );
        setdvar( @"hash_5a83a561cb4970b2", "2176" );
        setdvar( @"sm_sunsamplesizenear", 0.25 );
        setdvar( @"hash_4c14e16355aa5cb0", 2 );
        setdvar( @"hash_4c14e46355aa6349", 2 );
        setdvar( @"hash_63b517de4ccc57cd", 0 );
        setdvar( @"sm_spotdistcull", 0 );
        setdvar( @"r_spotlightentityshadows", 0 );
        setdvar( @"hash_1dde331a8e0153d8", 4 );
        setdvar( @"hash_a083dfcc7a54f85f", 1 );
        setdvar( @"hash_f1d740f1f4306d8f", 1 );
        setdvar( @"hash_898c20905541cb73", 1 );
        setdvar( @"hash_633e1a62bb5ceeb2", 1 );
        setdvar( @"hash_1fc47d6f68e1faf", 0 );
        setdvar( @"hash_5b1b5bd738a5436f", 0 );
        setdvar( @"hash_93b4b56b615317b9", 999999 );
        setdvar( @"hash_6af4238b48dd61c", 0 );
        setdvar( @"hash_9dae7d2931a373dd", 1 );
        setdvar( @"hash_68f03c897f2ed29e", 2 );
        setdvar( @"hash_924d46a5bf2c1f5d", 1.5 );
        setdvar( @"hash_a32719b6bbd25f1e", 1.5 );
        setdvar( @"hash_55f8fe20a6ed10b5", 1 );
        return;
    }
    
    setdvar( @"hash_8adcf05d62fe94fd", 0 );
    setdvar( @"hash_1d03444cd52cc348", 0 );
    setdvar( @"hash_6d194d6c7f21172e", 1 );
    setdvar( @"hash_5b73c78e77a0a6d5", 1 );
    setdvar( @"hash_2d74914ecc30bb62", 16 );
    setdvar( @"hash_4778772d83d5a997", "8 0 1 0" );
    setdvar( @"hash_6e3f8cef6be16b33", 1 );
    setdvar( @"hash_1ea8544d78048529", 1 );
    setdvar( @"hash_ea4c44a08cd23d5d", 0.2 );
    setdvar( @"hash_dacffbfd52c2fdc5", 8 );
    setdvar( @"hash_5d66c2ef5a9612e0", 1 );
    setdvar( @"hash_eca4b727b01fd254", 8 );
    setdvar( @"hash_63eb1893f96ac98d", 4 );
    setdvar( @"hash_e08232af8b8b695c", 2 );
    setdvar( @"hash_5a83a561cb4970b2", "2176" );
    setdvar( @"sm_sunsamplesizenear", 0.25 );
    setdvar( @"hash_4c14e16355aa5cb0", 2 );
    setdvar( @"hash_4c14e46355aa6349", 2 );
    setdvar( @"hash_63b517de4ccc57cd", 0 );
    setdvar( @"sm_spotdistcull", 0 );
    setdvar( @"r_spotlightentityshadows", 0 );
    setdvar( @"hash_1dde331a8e0153d8", 4 );
    setdvar( @"hash_a083dfcc7a54f85f", 1 );
    setdvar( @"hash_f1d740f1f4306d8f", 1 );
    setdvar( @"hash_898c20905541cb73", 1 );
    setdvar( @"hash_633e1a62bb5ceeb2", 1 );
    setdvar( @"hash_1fc47d6f68e1faf", 0 );
    setdvar( @"hash_5b1b5bd738a5436f", 0 );
    setdvar( @"hash_93b4b56b615317b9", 999999 );
    setdvar( @"hash_6af4238b48dd61c", 0 );
    setdvar( @"hash_9dae7d2931a373dd", 1 );
    setdvar( @"hash_68f03c897f2ed29e", 2 );
    setdvar( @"hash_924d46a5bf2c1f5d", 1.5 );
    setdvar( @"hash_a32719b6bbd25f1e", 1.5 );
    setdvar( @"hash_55f8fe20a6ed10b5", 1 );
    setdvar( @"hash_8dfe778be90d1cbc", 1 );
    setdvar( @"hash_e3f56fe404e467cb", 2 );
}

// Namespace lighting_dvars / namespace_fa30e36ae6a8ad2f
// Params 0
// Checksum 0x0, Offset: 0x8b4
// Size: 0x18b
function function_2df0e672265f272f()
{
    while ( true )
    {
        if ( getomnvar( 0, "winner_circle_lgt_dvars" ) == 1 )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isplatformxb3() || isplatformps4() )
    {
        setdvar( @"hash_6e3f8cef6be16b33", 1 );
        setdvar( @"hash_1ea8544d78048529", 1 );
        setdvar( @"hash_dacffbfd52c2fdc5", "32" );
        setdvar( @"hash_63eb1893f96ac98d", 8 );
        setdvar( @"hash_e08232af8b8b695c", 6 );
        setdvar( @"hash_ea4c44a08cd23d5d", 2 );
        setdvar( @"hash_1dde331a8e0153d8", 16 );
        setdvar( @"hash_c75b193e083a0e5", 1 );
        setdvar( @"hash_503f548196f716a", 0.2 );
    }
    
    if ( isplatformxb4() || isplatformps5() || isplatformpc() )
    {
        setdvar( @"hash_6e3f8cef6be16b33", 1 );
        setdvar( @"hash_1ea8544d78048529", 1 );
        setdvar( @"hash_dacffbfd52c2fdc5", "32" );
        setdvar( @"hash_63eb1893f96ac98d", 8 );
        setdvar( @"hash_e08232af8b8b695c", 6 );
        setdvar( @"hash_ea4c44a08cd23d5d", 2 );
        setdvar( @"hash_1dde331a8e0153d8", 16 );
        setdvar( @"hash_c75b193e083a0e5", 1 );
        setdvar( @"hash_503f548196f716a", 0.3 );
    }
}

// Namespace lighting_dvars / namespace_fa30e36ae6a8ad2f
// Params 0
// Checksum 0x0, Offset: 0xa47
// Size: 0x30d
function infil()
{
    while ( true )
    {
        if ( getomnvar( 0, "infil_lgt_dvars" ) == 1 )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isplatformxb3() || isplatformps4() )
    {
        setdvar( @"hash_6e3f8cef6be16b33", 1 );
        setdvar( @"hash_1ea8544d78048529", 1 );
        setdvar( @"hash_dacffbfd52c2fdc5", "32" );
        setdvar( @"hash_63eb1893f96ac98d", 8 );
        setdvar( @"hash_e08232af8b8b695c", 6 );
        setdvar( @"hash_ea4c44a08cd23d5d", 1 );
        setdvar( @"hash_1dde331a8e0153d8", 16 );
        setdvar( @"hash_c75b193e083a0e5", 1 );
        setdvar( @"hash_503f548196f716a", 0.2 );
    }
    
    if ( isplatformxb4() || isplatformps5() || isplatformpc() )
    {
        setdvar( @"hash_6e3f8cef6be16b33", 1 );
        setdvar( @"hash_1ea8544d78048529", 1 );
        setdvar( @"hash_dacffbfd52c2fdc5", "32" );
        setdvar( @"hash_63eb1893f96ac98d", 8 );
        setdvar( @"hash_e08232af8b8b695c", 6 );
        setdvar( @"hash_ea4c44a08cd23d5d", 1 );
        setdvar( @"hash_1dde331a8e0153d8", 16 );
        setdvar( @"hash_c75b193e083a0e5", 1 );
        setdvar( @"hash_503f548196f716a", 0.3 );
    }
    
    while ( true )
    {
        if ( getomnvar( 0, "infil_lgt_dvars" ) == 0 )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isplatformxb3() || isplatformps4() )
    {
        setdvar( @"hash_6e3f8cef6be16b33", 0 );
        setdvar( @"hash_1ea8544d78048529", 0 );
        setdvar( @"hash_dacffbfd52c2fdc5", "8" );
        setdvar( @"hash_63eb1893f96ac98d", 4 );
        setdvar( @"hash_e08232af8b8b695c", 2 );
        setdvar( @"hash_ea4c44a08cd23d5d", 0.2 );
        setdvar( @"hash_1dde331a8e0153d8", 4 );
        setdvar( @"hash_c75b193e083a0e5", 0 );
        setdvar( @"hash_503f548196f716a", 0 );
    }
    
    if ( isplatformxb4() || isplatformps5() || isplatformpc() )
    {
        setdvar( @"hash_6e3f8cef6be16b33", 1 );
        setdvar( @"hash_1ea8544d78048529", 1 );
        setdvar( @"hash_dacffbfd52c2fdc5", "32" );
        setdvar( @"hash_63eb1893f96ac98d", 4 );
        setdvar( @"hash_e08232af8b8b695c", 2 );
        setdvar( @"hash_ea4c44a08cd23d5d", 0.2 );
        setdvar( @"hash_1dde331a8e0153d8", 4 );
        setdvar( @"hash_c75b193e083a0e5", 0 );
        setdvar( @"hash_503f548196f716a", 0 );
    }
}

// Namespace lighting_dvars / namespace_fa30e36ae6a8ad2f
// Params 0
// Checksum 0x0, Offset: 0xd5c
// Size: 0x47
function function_dad02d81e667c615()
{
    while ( true )
    {
        if ( getomnvar( 0, "lgt_ball_turret_killstreak_in_progress" ) == 1 )
        {
            setdvar( @"hash_becfcdfa654305b0", "0 0 10000" );
        }
        else
        {
            setdvar( @"hash_becfcdfa654305b0", "0 0 0" );
        }
        
        waitframe();
    }
}

