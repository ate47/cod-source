#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\cluster_spike;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace cluster_spike_mp;

// Namespace cluster_spike_mp / scripts\mp\killstreaks\cluster_spike_mp
// Params 0
// Checksum 0x0, Offset: 0x138
// Size: 0x29
function init()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "cluster_spike", &scripts\cp_mp\killstreaks\cluster_spike::function_4d4dfa5c57455df0 );
    scripts\engine\utility::registersharedfunc( "cluster_spike", "attachXRays", &function_d0f5e3c6e6080d5d );
}

// Namespace cluster_spike_mp / scripts\mp\killstreaks\cluster_spike_mp
// Params 1
// Checksum 0x0, Offset: 0x169
// Size: 0x20
function function_d0f5e3c6e6080d5d( clusterspike )
{
    clusterspike setentityhudoutlinedata( 3, clusterspike.team );
    return clusterspike;
}

