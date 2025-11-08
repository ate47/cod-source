#using scripts\common\heartbeat;
#using scripts\engine\utility;

#namespace namespace_f388b4b671470a7d;

// Namespace namespace_f388b4b671470a7d / namespace_46454e0fdfc84088
// Params 0
// Checksum 0x0, Offset: 0xc7
// Size: 0x3d
function main()
{
    initcommonheartbeat( &playsoundfunc );
    
    while ( !issharedfuncdefined( "aggregator", "registerOnPlayerSpawnCallback" ) )
    {
        waitframe();
    }
    
    [[ getsharedfunc( "aggregator", "registerOnPlayerSpawnCallback" ) ]]( &function_767efe0110bfa73a );
}

// Namespace namespace_f388b4b671470a7d / namespace_46454e0fdfc84088
// Params 0
// Checksum 0x0, Offset: 0x10c
// Size: 0xa
function function_767efe0110bfa73a()
{
    thread function_a9c6f7587066ce13();
}

// Namespace namespace_f388b4b671470a7d / namespace_46454e0fdfc84088
// Params 1
// Checksum 0x0, Offset: 0x11e
// Size: 0x14
function playsoundfunc( firstpersonalias )
{
    self playsoundtoplayer( firstpersonalias, self );
}

