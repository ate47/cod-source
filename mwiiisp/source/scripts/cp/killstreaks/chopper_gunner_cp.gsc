#using scripts\common\utility;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\helicopter\cp_helicopter;
#using scripts\cp\utility;
#using scripts\cp\vehicles\damage_cp;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace chopper_gunner_cp;

// Namespace chopper_gunner_cp / scripts\cp\killstreaks\chopper_gunner_cp
// Params 0
// Checksum 0x0, Offset: 0x1bb
// Size: 0x4d
function init()
{
    scripts\engine\utility::registersharedfunc( "chopper_gunner", "set_vehicle_hit_damage_data", &chopper_gunner_set_vehicle_hit_damage_data );
    scripts\engine\utility::registersharedfunc( "chopper_gunner", "findTargetStruct", &chopper_gunner_findtargetstruct );
    
    if ( !scripts\cp\utility::is_specops_gametype() )
    {
        scripts\engine\utility::registersharedfunc( "chopper_gunner", "assignTargetMarkers", &chopper_gunner_assigntargetmarkers );
    }
}

// Namespace chopper_gunner_cp / scripts\cp\killstreaks\chopper_gunner_cp
// Params 2
// Checksum 0x0, Offset: 0x210
// Size: 0x1c
function chopper_gunner_set_vehicle_hit_damage_data( ref, hitstokill )
{
    scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data( ref, hitstokill );
}

// Namespace chopper_gunner_cp / scripts\cp\killstreaks\chopper_gunner_cp
// Params 2
// Checksum 0x0, Offset: 0x234
// Size: 0x1b
function chopper_gunner_findtargetstruct( structlinkname, var_6e1e1e75fc237eb1 )
{
    return scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetstruct( structlinkname, var_6e1e1e75fc237eb1 );
}

// Namespace chopper_gunner_cp / scripts\cp\killstreaks\chopper_gunner_cp
// Params 0
// Checksum 0x0, Offset: 0x258
// Size: 0x28c
function chopper_gunner_assigntargetmarkers()
{
    var_2cd52bbc2a67b7cf = [];
    var_ff93381949523976 = [];
    var_4496855dec276732 = [];
    all_ai = scripts\cp\cp_agent_utils::getactiveenemyagents( "allies" );
    all_players = level.players;
    var_eba1c5743194000d = [];
    
    if ( isdefined( level.killstreak_additional_targets ) )
    {
        foreach ( target in level.killstreak_additional_targets )
        {
            var_eba1c5743194000d = array_add( var_eba1c5743194000d, target );
        }
    }
    
    var_4496855dec276732 = array_combine( var_eba1c5743194000d, all_ai, all_players );
    
    foreach ( enemy in var_4496855dec276732 )
    {
        if ( !isdefined( enemy.team ) )
        {
            continue;
        }
        
        if ( level.teambased && enemy.team == self.team )
        {
            continue;
        }
        
        if ( enemy == self.owner )
        {
            continue;
        }
        
        if ( enemy scripts\cp\utility::_hasperk( "specialty_noscopeoutline" ) )
        {
            continue;
        }
        
        var_2cd52bbc2a67b7cf[ var_2cd52bbc2a67b7cf.size ] = enemy;
        
        if ( isdefined( enemy.aitype ) && isdefined( enemy.stealth_enabled ) && enemy.stealth_enabled == 1 )
        {
            enemy setstealthstate( "combat" );
        }
    }
    
    foreach ( player in all_players )
    {
        if ( level.teambased && player.team != self.team )
        {
            continue;
        }
        
        var_ff93381949523976[ var_ff93381949523976.size ] = player;
    }
    
    self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on( "thermalvisionenemydefault", self.owner, var_2cd52bbc2a67b7cf, self.owner, 0, 1, 1 );
    self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on( "thermalvisionfriendlydefault", self.owner, var_ff93381949523976, self.owner, 1, 1 );
    level thread chopper_gunner_assignedtargetmarkers_onnewai( self.enemytargetmarkergroup, 0 );
}

// Namespace chopper_gunner_cp / scripts\cp\killstreaks\chopper_gunner_cp
// Params 2
// Checksum 0x0, Offset: 0x4ec
// Size: 0x48
function chopper_gunner_assignedtargetmarkers_onnewai( targetmarkergroupid, var_262f4b55aa151de1 )
{
    level endon( "game_ended " );
    level endon( "removed_targetMarkerGroup_" + targetmarkergroupid );
    
    while ( true )
    {
        level waittill( "spawned_group_soldier", soldier );
        scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity( soldier, targetmarkergroupid, var_262f4b55aa151de1 );
    }
}

// Namespace chopper_gunner_cp / scripts\cp\killstreaks\chopper_gunner_cp
// Params 0
// Checksum 0x0, Offset: 0x53c
// Size: 0xb
function function_6a41bef845f5c144()
{
    scripts\cp\helicopter\cp_helicopter::function_c1150d781d01adc8( self, undefined );
}

