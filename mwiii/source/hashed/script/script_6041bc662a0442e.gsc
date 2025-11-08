#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\airdrop_escort;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\killstreak;

#namespace namespace_6d86fa067dd1151d;

// Namespace namespace_6d86fa067dd1151d / namespace_cf330d307304e7fc
// Params 0
// Checksum 0x0, Offset: 0xdf
// Size: 0x29
function function_f383491974a17b9a()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "airdrop_escort", &scripts\cp_mp\killstreaks\airdrop_escort::function_45378f51950e7d1f );
    scripts\engine\utility::registersharedfunc( "airdrop_escort", "attachXRays", &function_1f3181d1053887e6 );
}

// Namespace namespace_6d86fa067dd1151d / namespace_cf330d307304e7fc
// Params 1
// Checksum 0x0, Offset: 0x110
// Size: 0x20
function function_1f3181d1053887e6( escortheli )
{
    escortheli setentityhudoutlinedata( 3, escortheli.team );
    return escortheli;
}

