#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\cruise_predator;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\events;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;

#namespace cruise_predator_mp;

// Namespace cruise_predator_mp / scripts\mp\killstreaks\cruise_predator_mp
// Params 0
// Checksum 0x0, Offset: 0x1a6
// Size: 0x55
function init()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "cruise_predator", &scripts\cp_mp\killstreaks\cruise_predator::tryusecruisepredatorfromstruct );
    scripts\engine\utility::registersharedfunc( "cruise_predator", "registerVO", &cruisepredator_registervo );
    scripts\engine\utility::registersharedfunc( "cruise_predator", "eventRecord", &cruisepredator_eventrecord );
    scripts\engine\utility::registersharedfunc( "cruise_predator", "assignTargetMarkers", &cruisepredator_assigntargetmarkers );
}

// Namespace cruise_predator_mp / scripts\mp\killstreaks\cruise_predator_mp
// Params 0
// Checksum 0x0, Offset: 0x203
// Size: 0x5f
function cruisepredator_registervo()
{
    game[ "dialog" ][ "cruise_predator" + "_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "cruise_predator" + "_hit_target" ] = "killstreak_remote_operator" + "_hit_target";
    game[ "dialog" ][ "cruise_predator" + "_miss_target" ] = "killstreak_remote_operator" + "_miss_target";
}

// Namespace cruise_predator_mp / scripts\mp\killstreaks\cruise_predator_mp
// Params 1
// Checksum 0x0, Offset: 0x26a
// Size: 0x18
function cruisepredator_eventrecord( explodepos )
{
    if ( isdefined( explodepos ) )
    {
        scripts\mp\events::predatormissileimpact( explodepos );
    }
}

// Namespace cruise_predator_mp / scripts\mp\killstreaks\cruise_predator_mp
// Params 1
// Checksum 0x0, Offset: 0x28a
// Size: 0x15a
function cruisepredator_assigntargetmarkers( user )
{
    var_2cd52bbc2a67b7cf = [];
    var_ff93381949523976 = [];
    var_22ccb4186bd27179 = level.players;
    groupsstruct = spawnstruct();
    
    foreach ( player in var_22ccb4186bd27179 )
    {
        if ( level.teambased && player.team == user.team || player == user )
        {
            var_ff93381949523976[ var_ff93381949523976.size ] = player;
            continue;
        }
        
        if ( player scripts\mp\utility\perk::_hasperk( "specialty_noscopeoutline" ) )
        {
            continue;
        }
        
        var_2cd52bbc2a67b7cf[ var_2cd52bbc2a67b7cf.size ] = player;
    }
    
    if ( isdefined( level.killstreak_additional_targets ) )
    {
        foreach ( target in level.killstreak_additional_targets )
        {
            var_2cd52bbc2a67b7cf = array_add( var_2cd52bbc2a67b7cf, target );
        }
    }
    
    groupsstruct.enemytargetmarkergroup = var_2cd52bbc2a67b7cf;
    groupsstruct.friendlytargetmarkergroup = var_ff93381949523976;
    return groupsstruct;
}

