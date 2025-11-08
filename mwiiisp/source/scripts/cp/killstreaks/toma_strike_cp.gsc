#using scripts\common\utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;

#namespace toma_strike_cp;

// Namespace toma_strike_cp / scripts\cp\killstreaks\toma_strike_cp
// Params 0
// Checksum 0x0, Offset: 0xb7
// Size: 0x18
function init()
{
    scripts\engine\utility::registersharedfunc( "toma_strike", "munitionUsed", &toma_strike_munitionused );
}

// Namespace toma_strike_cp / scripts\cp\killstreaks\toma_strike_cp
// Params 2
// Checksum 0x0, Offset: 0xd7
// Size: 0x20
function toma_strike_munitionused( streakinfo, ignorecancel )
{
    self notify( "munitions_used", "cluster_strike" );
}

