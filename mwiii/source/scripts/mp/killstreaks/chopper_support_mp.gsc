#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\weapon;
#using scripts\mp\vehicles\damage;

#namespace chopper_support_mp;

// Namespace chopper_support_mp / scripts\mp\killstreaks\chopper_support_mp
// Params 0
// Checksum 0x0, Offset: 0x132
// Size: 0x29
function init()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "chopper_support", &scripts\cp_mp\killstreaks\chopper_support::tryusechoppersupportfromstruct );
    scripts\engine\utility::registersharedfunc( "chopper_support", "set_vehicle_hit_damage_data", &chopper_support_set_vehicle_hit_damage_data );
}

// Namespace chopper_support_mp / scripts\mp\killstreaks\chopper_support_mp
// Params 2
// Checksum 0x0, Offset: 0x163
// Size: 0x1c
function chopper_support_set_vehicle_hit_damage_data( ref, hitstokill )
{
    scripts\mp\vehicles\damage::set_vehicle_hit_damage_data( ref, hitstokill );
}

