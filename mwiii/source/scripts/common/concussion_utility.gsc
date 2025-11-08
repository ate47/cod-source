#using scripts\common\utility;
#using scripts\engine\utility;

#namespace concussion_utility;

// Namespace concussion_utility / scripts\common\concussion_utility
// Params 1
// Checksum 0x0, Offset: 0x98
// Size: 0x1c
function calculateinterruptdelay( duration )
{
    return max( 0, duration - 2.6 ) * 1000;
}

