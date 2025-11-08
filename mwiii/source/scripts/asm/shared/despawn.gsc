#using scripts\asm\asm;
#using scripts\engine\throttle;
#using scripts\engine\utility;

#namespace despawn;

// Namespace despawn / scripts\asm\shared\despawn
// Params 2
// Checksum 0x0, Offset: 0xca
// Size: 0x1b
function terminatedespawn( asmname, statename )
{
    thread queue_despawn();
}

// Namespace despawn / scripts\asm\shared\despawn
// Params 0
// Checksum 0x0, Offset: 0xed
// Size: 0x6d
function queue_despawn()
{
    self endon( "death" );
    level endon( "game_ended" );
    
    if ( !isdefined( level.despawnthrottle ) )
    {
        level.despawnthrottle = throttle_initialize( "despawnThrottle", getdvarint( @"hash_31df6612d8150a09", 3 ), level.framedurationseconds );
    }
    
    function_f632348cbb773537( level.despawnthrottle, self );
    self.nocorpse = 1;
    self kill();
}

