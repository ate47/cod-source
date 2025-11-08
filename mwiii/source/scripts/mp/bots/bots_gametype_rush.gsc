#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\entity;

#namespace bots_gametype_rush;

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x219
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_hardpoint();
}

/#

    // Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
    // Params 0
    // Checksum 0x0, Offset: 0x231
    // Size: 0x5, Type: dev
    function function_e45e46b7c35deadb()
    {
        
    }

#/

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x23e
// Size: 0x35
function setup_hardpoint()
{
    bot_waittill_bots_enabled( 1 );
    thread bot_hardpoint_ai_director_update();
    level.protect_radius = 128;
    level.patrol_radius = 800;
    level.bot_gametype_precaching_done = 1;
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x27b
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_hardpoint_think;
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x29a
// Size: 0x216
function initialize_role()
{
    attackers = get_allied_attackers_for_team( self.team );
    defenders = get_allied_defenders_for_team( self.team );
    attacker_limit = bot_attacker_limit_for_team( self.team );
    defender_limit = bot_defender_limit_for_team( self.team );
    personality_type = level.bot_personality_type[ self.personality ];
    
    if ( personality_type == "active" )
    {
        if ( attackers.size >= attacker_limit )
        {
            var_8668b3fa2350c9b3 = 0;
            
            foreach ( attacker in attackers )
            {
                if ( isai( attacker ) && level.bot_personality_type[ attacker.personality ] == "stationary" )
                {
                    attacker.role = undefined;
                    var_8668b3fa2350c9b3 = 1;
                    break;
                }
            }
            
            if ( var_8668b3fa2350c9b3 )
            {
                bot_set_role( "attacker" );
            }
            else
            {
                bot_set_role( "defender" );
            }
        }
        else
        {
            bot_set_role( "attacker" );
        }
        
        return;
    }
    
    if ( personality_type == "stationary" )
    {
        if ( defenders.size >= defender_limit )
        {
            var_8668b3fa2350c9b3 = 0;
            
            foreach ( defender in defenders )
            {
                if ( isai( defender ) && level.bot_personality_type[ defender.personality ] == "active" )
                {
                    defender.role = undefined;
                    var_8668b3fa2350c9b3 = 1;
                    break;
                }
            }
            
            if ( var_8668b3fa2350c9b3 )
            {
                bot_set_role( "defender" );
            }
            else
            {
                bot_set_role( "attacker" );
            }
            
            return;
        }
        
        bot_set_role( "defender" );
    }
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x4b8
// Size: 0x278
function bot_hardpoint_think()
{
    self notify( "bot_grnd_think" );
    self endon( "bot_grnd_think" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self botclearscriptgoal();
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "separation", 0 );
    current_patrol_zone = undefined;
    
    for ( current_defend_zone = undefined; true ; current_defend_zone = level.currentobjective.trigger )
    {
        wait 0.05;
        
        if ( !isdefined( level.currentobjective ) )
        {
            continue;
        }
        
        if ( bot_has_tactical_goal() )
        {
            continue;
        }
        
        if ( !isdefined( self.role ) )
        {
            initialize_role();
        }
        
        if ( !istrue( self.bot_defending ) )
        {
            current_patrol_zone = undefined;
            current_defend_zone = undefined;
        }
        
        if ( self.role == "attacker" )
        {
            var_7d8b092bacf8a8d8 = 0;
            current_defend_zone = undefined;
            
            if ( !isdefined( current_patrol_zone ) )
            {
                var_7d8b092bacf8a8d8 = 1;
            }
            else if ( isdefined( level.currentobjective.trigger ) )
            {
                if ( current_patrol_zone != level.currentobjective.trigger )
                {
                    var_7d8b092bacf8a8d8 = 1;
                }
            }
            
            if ( var_7d8b092bacf8a8d8 )
            {
                zoneorigin = getclosestpointonnavmesh( level.currentobjective.trigger.origin, self );
                optional_params[ "min_goal_time" ] = 1;
                optional_params[ "max_goal_time" ] = 4;
                bot_patrol_area( zoneorigin, level.patrol_radius, optional_params );
                current_patrol_zone = level.currentobjective.trigger;
            }
            
            continue;
        }
        
        if ( self.role == "defender" )
        {
            current_patrol_zone = undefined;
            var_d6180d62096f9cdc = 0;
            
            if ( !isdefined( current_defend_zone ) )
            {
                var_d6180d62096f9cdc = 1;
            }
            else if ( isdefined( level.currentobjective.trigger ) )
            {
                if ( current_defend_zone != level.currentobjective.trigger )
                {
                    var_d6180d62096f9cdc = 1;
                }
            }
            
            if ( var_d6180d62096f9cdc )
            {
                nodes = getnodesintrigger( level.currentobjective.trigger );
                
                if ( nodes.size > 0 )
                {
                    optional_params[ "min_goal_time" ] = 3;
                    optional_params[ "max_goal_time" ] = 6;
                    bot_capture_zone( level.currentobjective.trigger.origin, nodes, level.currentobjective.trigger, optional_params );
                }
            }
        }
    }
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 1
// Checksum 0x0, Offset: 0x738
// Size: 0x39
function bot_attacker_limit_for_team( team )
{
    team_limit = get_num_players_on_team( team );
    return int( int( team_limit ) / 2 ) + 1 + int( team_limit ) % 2;
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 1
// Checksum 0x0, Offset: 0x77a
// Size: 0x35
function bot_defender_limit_for_team( team )
{
    team_limit = get_num_players_on_team( team );
    return max( int( int( team_limit ) / 2 ) - 1, 0 );
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 1
// Checksum 0x0, Offset: 0x7b8
// Size: 0x91
function get_num_players_on_team( team )
{
    var_35b2ace44b93c013 = 0;
    
    foreach ( player in level.participants )
    {
        if ( isteamparticipant( player ) && isdefined( player.team ) && player.team == team )
        {
            var_35b2ace44b93c013++;
        }
    }
    
    return var_35b2ace44b93c013;
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 1
// Checksum 0x0, Offset: 0x852
// Size: 0xd6
function get_allied_attackers_for_team( team )
{
    attackers = get_players_by_role( "attacker", team );
    
    if ( isdefined( level.currentobjective.trigger ) )
    {
        foreach ( player in level.players )
        {
            if ( !isai( player ) && isdefined( player.team ) && player.team == team )
            {
                if ( !player istouching( level.currentobjective.trigger ) )
                {
                    attackers = array_add( attackers, player );
                }
            }
        }
    }
    
    return attackers;
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 1
// Checksum 0x0, Offset: 0x931
// Size: 0xd6
function get_allied_defenders_for_team( team )
{
    defenders = get_players_by_role( "defender", team );
    
    if ( isdefined( level.currentobjective.trigger ) )
    {
        foreach ( player in level.players )
        {
            if ( !isai( player ) && isdefined( player.team ) && player.team == team )
            {
                if ( player istouching( level.currentobjective.trigger ) )
                {
                    defenders = array_add( defenders, player );
                }
            }
        }
    }
    
    return defenders;
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 2
// Checksum 0x0, Offset: 0xa10
// Size: 0xc9
function get_players_by_role( role, team )
{
    players = [];
    
    foreach ( player in level.participants )
    {
        if ( !isdefined( player.team ) )
        {
            continue;
        }
        
        if ( isalive( player ) && isteamparticipant( player ) && player.team == team && isdefined( player.role ) && player.role == role )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 1
// Checksum 0x0, Offset: 0xae2
// Size: 0x23
function bot_set_role( new_role )
{
    self.role = new_role;
    self botclearscriptgoal();
    bot_defend_stop();
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 2
// Checksum 0x0, Offset: 0xb0d
// Size: 0x119, Type: bool
function is_b_better_defender( a, b )
{
    atouching = a istouching( level.currentobjective.trigger );
    btouching = b istouching( level.currentobjective.trigger );
    
    if ( atouching != btouching )
    {
        if ( atouching )
        {
            return false;
        }
        
        return true;
    }
    
    if ( atouching )
    {
        if ( a.role != b.role )
        {
            if ( b.role == "defender" )
            {
                return true;
            }
            
            return false;
        }
    }
    
    adistsqrd = distance2dsquared( a.origin, level.currentobjective.trigger.origin );
    bdistsqrd = distance2dsquared( b.origin, level.currentobjective.trigger.origin );
    
    if ( adistsqrd < bdistsqrd )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0xc2f
// Size: 0x4ec
function bot_hardpoint_ai_director_update()
{
    level notify( "bot_hardpoint_ai_director_update" );
    level endon( "bot_hardpoint_ai_director_update" );
    level endon( "game_ended" );
    teams[ 0 ] = "allies";
    teams[ 1 ] = "axis";
    var_315ada03f3555768[ "allies" ] = 0;
    var_315ada03f3555768[ "axis" ] = 0;
    
    while ( true )
    {
        var_e0ce35063064fb94 = "neutral";
        
        if ( !isdefined( level.currentobjective ) )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( level.currentobjective.trigger ) )
        {
            var_e0ce35063064fb94 = level.currentobjective scripts\mp\gameobjects::getownerteam();
        }
        
        foreach ( team in teams )
        {
            ai_attackers = [];
            ai_defenders = [];
            
            if ( team != var_e0ce35063064fb94 )
            {
                var_315ada03f3555768[ team ] = 0;
                
                foreach ( player in level.participants )
                {
                    if ( isteamparticipant( player ) && isdefined( player.team ) && player.team == team )
                    {
                        if ( isbot( player ) && ( !isdefined( player.role ) || player.role != "defender" ) )
                        {
                            player bot_set_role( "defender" );
                        }
                    }
                }
                
                continue;
            }
            
            attacker_limit = bot_attacker_limit_for_team( team );
            defender_limit = bot_defender_limit_for_team( team );
            
            if ( !var_315ada03f3555768[ team ] )
            {
                var_315ada03f3555768[ team ] = 1;
                var_2857a3996fb3fa53 = [];
                
                foreach ( player in level.participants )
                {
                    if ( isteamparticipant( player ) && isdefined( player.team ) && player.team == team )
                    {
                        if ( isbot( player ) )
                        {
                            var_2857a3996fb3fa53[ var_2857a3996fb3fa53.size ] = player;
                        }
                    }
                }
                
                var_8b00f8b964fc840a = array_sort_with_func( var_2857a3996fb3fa53, &is_b_better_defender );
                
                if ( var_2857a3996fb3fa53.size < defender_limit )
                {
                    defender_limit = var_2857a3996fb3fa53.size;
                }
                
                defender_limit = int( defender_limit );
                
                for ( i = 0; i < defender_limit ; i++ )
                {
                    var_2857a3996fb3fa53[ i ] bot_set_role( "defender" );
                }
                
                for ( i = defender_limit; i < var_2857a3996fb3fa53.size ; i++ )
                {
                    var_2857a3996fb3fa53[ i ] bot_set_role( "attacker" );
                }
                
                wait 1;
                continue;
            }
            
            attackers = get_allied_attackers_for_team( team );
            defenders = get_allied_defenders_for_team( team );
            
            if ( attackers.size > attacker_limit )
            {
                removed_attacker = 0;
                
                foreach ( attacker in attackers )
                {
                    if ( isai( attacker ) )
                    {
                        if ( level.bot_personality_type[ attacker.personality ] == "stationary" )
                        {
                            attacker bot_set_role( "defender" );
                            removed_attacker = 1;
                            break;
                        }
                        
                        ai_attackers = array_add( ai_attackers, attacker );
                    }
                }
                
                if ( !removed_attacker && ai_attackers.size > 0 )
                {
                    random( ai_attackers ) bot_set_role( "defender" );
                }
            }
            
            if ( defenders.size > defender_limit )
            {
                removed_defender = 0;
                
                foreach ( defender in defenders )
                {
                    if ( isai( defender ) )
                    {
                        if ( level.bot_personality_type[ defender.personality ] == "active" )
                        {
                            defender bot_set_role( "attacker" );
                            removed_defender = 1;
                            break;
                        }
                        
                        ai_defenders = array_add( ai_defenders, defender );
                    }
                }
                
                if ( !removed_defender && ai_defenders.size > 0 )
                {
                    random( ai_defenders ) bot_set_role( "attacker" );
                }
            }
            
            if ( defenders.size == 0 )
            {
                replacements = get_players_by_role( "attacker", team );
                
                if ( replacements.size > 0 )
                {
                    random( replacements ) bot_set_role( "defender" );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 1
// Checksum 0x0, Offset: 0x1123
// Size: 0x43, Type: bool
function crate_can_use( crate )
{
    if ( isagent( self ) && !isdefined( crate.boxtype ) )
    {
        return false;
    }
    
    if ( !scripts\mp\bots\bots::function_9bd84cede4fe8f24( crate ) )
    {
        return false;
    }
    
    return !bot_is_defending() || bot_is_protecting();
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x116f
// Size: 0xa4
function setup_bot_koth()
{
    bot_waittill_bots_enabled();
    
    while ( !isdefined( level.objectives ) )
    {
        wait 0.05;
    }
    
    bot_setup_objective_bottargets();
    
    foreach ( objective in level.objectives )
    {
        objective thread monitor_zone_control();
    }
    
    bot_cache_entrances_to_gametype_array( level.objectives, "radio", level.bot_ignore_precalc_paths );
    level.bot_gametype_precaching_done = 1;
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x121b
// Size: 0x1bc
function bot_headquarters_think()
{
    self notify( "bot_hq_think" );
    self endon( "bot_hq_think" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "grenade_objectives", 1 );
    init_bot_game_headquarters();
    
    for ( ;; )
    {
        wait_time = randomintrange( 1, 11 ) * 0.05;
        wait wait_time;
        
        if ( self.health <= 0 )
        {
            continue;
        }
        
        if ( !isdefined( level.radioobject ) )
        {
            if ( bot_is_defending() )
            {
                bot_defend_stop();
            }
            
            var_5db2b7f3a1e635c4 = 1;
            
            if ( self botgetscriptgoaltype() != "none" )
            {
                distsq = distancesquared( self botgetscriptgoal(), self.origin );
                radius = self botgetscriptgoalradius();
                
                if ( distsq > radius * radius )
                {
                    var_5db2b7f3a1e635c4 = 0;
                }
            }
            
            if ( var_5db2b7f3a1e635c4 )
            {
                randompos = self botfindrandomgoal();
                
                if ( isdefined( randompos ) )
                {
                    self botsetscriptgoal( randompos, 128, "hunt" );
                }
            }
            
            continue;
        }
        
        hqowningteam = level.radioobject scripts\mp\gameobjects::getownerteam();
        
        if ( self.team != hqowningteam )
        {
            if ( !is_capturing_current_headquarters() )
            {
                num_capturing = get_num_ai_capturing_headquarters();
                var_f3d4ce970fbcd5b7 = find_current_radio().bot_nodes.size;
                
                if ( num_capturing < var_f3d4ce970fbcd5b7 )
                {
                    capture_current_headquarters();
                }
                else if ( !is_protecting_current_headquarters() )
                {
                    protect_current_headquarters();
                }
            }
            
            continue;
        }
        
        if ( !is_protecting_current_headquarters() )
        {
            wait randomfloat( 2 );
            
            if ( isdefined( level.radioobject ) )
            {
                protect_current_headquarters();
            }
        }
    }
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x13df
// Size: 0x72
function find_current_radio()
{
    foreach ( radio in level.radios )
    {
        if ( radio.trig == level.radioobject.trigger )
        {
            return radio;
        }
    }
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x1459
// Size: 0x8
function is_capturing_current_headquarters()
{
    return bot_is_capturing();
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x146a
// Size: 0x9b
function get_num_ai_capturing_headquarters()
{
    total = 0;
    
    foreach ( player in level.participants )
    {
        if ( isai( player ) && player.health > 0 && player.team == self.team && player is_capturing_current_headquarters() )
        {
            total++;
        }
    }
    
    return total;
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x150e
// Size: 0x54
function capture_current_headquarters()
{
    current_radio = find_current_radio();
    optional_params[ "entrance_points_index" ] = "radio" + current_radio.objectivekey;
    bot_capture_zone( current_radio.origin, current_radio.bot_nodes, undefined, optional_params );
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x156a
// Size: 0x8
function is_protecting_current_headquarters()
{
    return bot_is_protecting();
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x157b
// Size: 0x57
function protect_current_headquarters()
{
    worldbounds = self botgetworldsize();
    average_side = ( worldbounds[ 0 ] + worldbounds[ 1 ] ) / 2;
    protect_radius = min( 1000, average_side / 4 );
    bot_protect_point( find_current_radio().origin, protect_radius );
}

// Namespace bots_gametype_rush / scripts\mp\bots\bots_gametype_rush
// Params 0
// Checksum 0x0, Offset: 0x15da
// Size: 0x90
function init_bot_game_headquarters()
{
    if ( isdefined( level.bots_gametype_initialized ) && level.bots_gametype_initialized )
    {
        return;
    }
    
    level.bots_gametype_initialized = 1;
    
    foreach ( radio in level.radios )
    {
        radio.bot_nodes = getnodesintrigger( radio.trig );
    }
}

