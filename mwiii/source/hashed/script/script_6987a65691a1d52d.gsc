#using script_4222a2c4ca8b1fae;
#using script_4b28cf746311da43;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;

#namespace namespace_90db378d21a2e5e2;

// Namespace namespace_90db378d21a2e5e2 / namespace_73934a4688ba8f4d
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0xf2
// Size: 0x14
function autoexec init()
{
    level callback::add( "ob_season_main", &main );
}

// Namespace namespace_90db378d21a2e5e2 / namespace_73934a4688ba8f4d
// Params 1
// Checksum 0x0, Offset: 0x10e
// Size: 0x70
function main( params )
{
    mapname = getmapname();
    
    if ( getdvarint( @"hash_9a36e5985ae07814", 0 ) )
    {
        switch ( mapname )
        {
            case #"hash_2a218509d1620d9d":
            case #"hash_9ae3f9a4f2372775":
                namespace_ef93494119003805::main();
                namespace_c6fb841ce5c974f2::function_852f483c0266f8aa();
                break;
        }
    }
    
    level callback::remove( "ob_season_main", &main );
}

