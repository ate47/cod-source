#using script_294d813e5d00b68c;
#using scripts\common\utility;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\killstreaks\assault_drone_cp;
#using scripts\cp\laststand;
#using scripts\cp\super;
#using scripts\cp\vehicles\damage_cp;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\killstreaks\recon_drone;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace helper_drone_cp;

// Namespace helper_drone_cp / scripts\cp\killstreaks\helper_drone_cp
// Params 0
// Checksum 0x0, Offset: 0x1c1
// Size: 0x12a
function helper_drone_init()
{
    namespace_e19027ce6d65052c::recondrone_init();
    scripts\cp\killstreaks\assault_drone_cp::function_c260cd16a5c5a2d9();
    scripts\engine\utility::registersharedfunc( "helper_drone", "watchMarkingEntStatus", &markent_watchmarkingentstatus_cp );
    scripts\engine\utility::registersharedfunc( "helper_drone", "get_mark_ui_duration", &get_mark_ui_duration );
    scripts\engine\utility::registersharedfunc( "helper_drone", "get_outer_reticle_targets", &get_outer_reticle_targets );
    scripts\engine\utility::registersharedfunc( "helper_drone", "customMarkDuration", &custommarkduration );
    scripts\engine\utility::registersharedfunc( "supers", "superUseFinished", &scripts\cp\super::superusefinished );
    scripts\engine\utility::registersharedfunc( "player", "isInLastStand", &scripts\cp\laststand::player_in_laststand );
    streaknames = getarraykeys( level.helperdronesettings );
    
    foreach ( streakname in streaknames )
    {
        hitstokill = level.helperdronesettings[ streakname ].hitstokill;
        
        if ( isdefined( hitstokill ) )
        {
            scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data( streakname, hitstokill );
            scripts\cp\vehicles\damage_cp::set_weapon_hit_damage_data_for_vehicle( "emp_grenade_mp", hitstokill, streakname );
        }
    }
}

// Namespace helper_drone_cp / scripts\cp\killstreaks\helper_drone_cp
// Params 0
// Checksum 0x0, Offset: 0x2f3
// Size: 0x4
function get_mark_ui_duration()
{
    return 90;
}

// Namespace helper_drone_cp / scripts\cp\killstreaks\helper_drone_cp
// Params 0
// Checksum 0x0, Offset: 0x300
// Size: 0x4
function custommarkduration()
{
    return 90;
}

// Namespace helper_drone_cp / scripts\cp\killstreaks\helper_drone_cp
// Params 0
// Checksum 0x0, Offset: 0x30d
// Size: 0xb
function get_mark_target_array()
{
    return level.spawned_enemies;
}

// Namespace helper_drone_cp / scripts\cp\killstreaks\helper_drone_cp
// Params 1
// Checksum 0x0, Offset: 0x321
// Size: 0xeb
function get_outer_reticle_targets( config )
{
    outer_dist = 3000;
    var_b11567dd924e0a86 = outer_dist * outer_dist;
    potential_targets = [];
    var_7c18d93982d63713 = cos( 70 );
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam( "axis" );
    
    foreach ( guy in guys )
    {
        if ( distancesquared( self.origin, guy.origin ) < var_b11567dd924e0a86 )
        {
            if ( within_fov( self.origin, self.angles, guy.origin, var_7c18d93982d63713 ) )
            {
                potential_targets[ potential_targets.size ] = guy;
            }
        }
    }
    
    return potential_targets;
}

// Namespace helper_drone_cp / scripts\cp\killstreaks\helper_drone_cp
// Params 1
// Checksum 0x0, Offset: 0x415
// Size: 0xdd
function markent_watchmarkingentstatus_cp( markdata )
{
    level endon( "game_ended" );
    markdata.target endon( "unmarked_" + markdata.targetnum );
    markdata.target thread function_995178e171593ec0( markdata, self );
    waittill_any_3( "explode", "death", "leaving" );
    wait 15;
    
    if ( isdefined( level.var_301eb5985c867e8 ) )
    {
        foreach ( player in level.players )
        {
            player notify( "tracker_removed" );
            markdata.target thread [[ level.var_301eb5985c867e8 ]]( player );
        }
        
        waitframe();
    }
    
    scripts\cp_mp\killstreaks\recon_drone::function_8bf0338c7a157c29( markdata );
}

// Namespace helper_drone_cp / scripts\cp\killstreaks\helper_drone_cp
// Params 2
// Checksum 0x0, Offset: 0x4fa
// Size: 0x24
function function_995178e171593ec0( markdata, drone )
{
    self waittill( "death" );
    drone scripts\cp_mp\killstreaks\recon_drone::function_8bf0338c7a157c29( markdata );
}

