#using script_27fdece778e999d8;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\mgl_mp;
#using scripts\mp\utility\entity;

#namespace bots_gametype_koth;

// Namespace bots_gametype_koth / scripts\mp\bots\bots_gametype_koth
// Params 0
// Checksum 0x0, Offset: 0x1c7
// Size: 0x3f
function main()
{
    level.var_e6628286205f2ea7 = 1;
    
    if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() && !getdvarint( @"hash_131a7029db1ed456", 0 ) )
    {
        scripts\mp\gametypes\mgl_mp::function_892db361940e142d();
        return;
    }
    
    setup_callbacks();
    setup_bot_koth();
}

/#

    // Namespace bots_gametype_koth / scripts\mp\bots\bots_gametype_koth
    // Params 0
    // Checksum 0x0, Offset: 0x20e
    // Size: 0x5, Type: dev
    function function_e45e46b7c35deadb()
    {
        
    }

#/

// Namespace bots_gametype_koth / scripts\mp\bots\bots_gametype_koth
// Params 0
// Checksum 0x0, Offset: 0x21b
// Size: 0x6b
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_koth_think;
    level.bot_funcs[ "should_start_cautious_approach" ] = &should_start_cautious_approach_koth;
    
    if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() && getdvarint( @"hash_131a7029db1ed456", 0 ) )
    {
        level.bot_funcs[ "player_spawned_gamemode" ] = &namespace_da125b44c190d236::function_5f51c5c13fd2911b;
        level.modifyplayerdamage = &namespace_da125b44c190d236::modifyplayerdamage;
    }
}

// Namespace bots_gametype_koth / scripts\mp\bots\bots_gametype_koth
// Params 0
// Checksum 0x0, Offset: 0x28e
// Size: 0x185
function setup_bot_koth()
{
    bot_waittill_bots_enabled();
    var_794c62d4a40cacbd = 0;
    
    foreach ( objective in level.objectives )
    {
        objective thread monitor_zone_control();
        var_c24b62a774e2496b = 0;
        
        if ( istrue( objective.trigger.trigger_off ) )
        {
            objective.trigger trigger_on();
            var_c24b62a774e2496b = 1;
        }
        
        objective.nodes = bot_get_valid_nodes_in_trigger( objective.trigger );
        
        if ( var_c24b62a774e2496b )
        {
            objective.trigger trigger_off();
        }
        
        /#
            if ( objective.nodes.size < 5 )
            {
                wait 5;
                
                if ( objective.nodes.size < 3 )
                {
                    var_794c62d4a40cacbd = 1;
                }
            }
        #/
    }
    
    level.bot_set_zone_nodes = 1;
    
    if ( !var_794c62d4a40cacbd )
    {
        level.bot_hp_allow_predictive_capping = 1;
        initial_zone = level.zone;
        
        if ( !isdefined( initial_zone ) )
        {
            initial_zone = random( level.objectives );
        }
        
        bot_cache_entrances_to_zones( [ initial_zone ] );
        level.bot_gametype_zones_precached[ initial_zone.trigger getentitynumber() ] = 1;
        level.bot_gametype_precaching_done = 1;
        thread bot_cache_entrances_to_other_zones( initial_zone );
    }
}

// Namespace bots_gametype_koth / scripts\mp\bots\bots_gametype_koth
// Params 1
// Checksum 0x0, Offset: 0x41b
// Size: 0xa3
function bot_cache_entrances_to_other_zones( zone_done )
{
    for ( zones_left = array_remove( level.objectives, zone_done ); zones_left.size > 0 ; zones_left = array_remove( zones_left, zone_precaching ) )
    {
        zone_precaching = undefined;
        current_zone = level.zone;
        
        if ( isdefined( current_zone ) && array_contains( zones_left, current_zone ) )
        {
            zone_precaching = current_zone;
        }
        else
        {
            zone_precaching = random( zones_left );
        }
        
        bot_cache_entrances_to_zones( [ zone_precaching ] );
        level.bot_gametype_zones_precached[ zone_precaching.trigger getentitynumber() ] = 1;
    }
}

// Namespace bots_gametype_koth / scripts\mp\bots\bots_gametype_koth
// Params 0
// Checksum 0x0, Offset: 0x4c6
// Size: 0x33a
function bot_koth_think()
{
    self notify( "bot_koth_think" );
    self endon( "bot_koth_think" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "separation", 0 );
    self botsetflag( "grenade_objectives", 1 );
    var_f89468cd9a401388 = undefined;
    last_recorded_zone = level.zone;
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_c2de8ca6dc8512c1" ) )
            {
                wait 0.05;
                continue;
            }
        #/
        
        wait 0.05;
        
        if ( self.health <= 0 )
        {
            continue;
        }
        
        if ( !isdefined( level.zone ) || !isdefined( level.bot_gametype_zones_precached[ level.zone.trigger getentitynumber() ] ) )
        {
            if ( bot_is_defending() )
            {
                bot_defend_stop();
            }
            
            self.current_zone = undefined;
            self [[ self.personality_update_function ]]();
            continue;
        }
        
        if ( last_recorded_zone != level.zone )
        {
            var_f89468cd9a401388 = undefined;
            last_recorded_zone = level.zone;
        }
        
        if ( !istrue( level.zone.trigger.trigger_off ) && isdefined( level.zoneendtime ) && !isdefined( var_f89468cd9a401388 ) && !level.zonerandomlocationorder && level.bot_hp_allow_predictive_capping )
        {
            var_7a8ae257730d6c26 = level.zoneendtime - gettime();
            
            if ( var_7a8ae257730d6c26 > 0 && var_7a8ae257730d6c26 < 10000 )
            {
                var_5f20a57c87fb6002 = level.zone scripts\mp\gameobjects::getownerteam() == self.team;
                
                if ( !var_5f20a57c87fb6002 )
                {
                    var_ce5bd620eeddf1aa = level.zone.zone_bounds.radius * 6;
                    
                    if ( var_7a8ae257730d6c26 < 5000 )
                    {
                        var_ce5bd620eeddf1aa = level.zone.zone_bounds.radius * 3;
                    }
                    
                    var_87f2f08f7437a411 = distance( level.zone.zone_bounds.center, self.origin );
                    
                    if ( var_87f2f08f7437a411 > var_ce5bd620eeddf1aa )
                    {
                        var_f89468cd9a401388 = bot_should_cap_next_zone();
                    }
                }
                else
                {
                    team_limit = bot_get_max_players_on_team( self.team );
                    var_9bbd8a880a88652e = ceil( team_limit / 2 );
                    
                    if ( var_7a8ae257730d6c26 < 5000 )
                    {
                        var_9bbd8a880a88652e = ceil( team_limit / 3 );
                    }
                    
                    var_66df858e06a4f668 = bot_get_num_teammates_capturing_zone( level.zone );
                    
                    if ( var_66df858e06a4f668 + 1 > var_9bbd8a880a88652e )
                    {
                        var_f89468cd9a401388 = bot_should_cap_next_zone();
                    }
                }
            }
        }
        
        var_e6065833510c1c0c = level.zone;
        
        if ( istrue( var_f89468cd9a401388 ) )
        {
            var_9906019056aeee60 = ( level.prevzoneindex + 1 ) % level.objectives.size;
            
            if ( var_9906019056aeee60 == 0 )
            {
                var_9906019056aeee60 = 1;
            }
            
            var_e6065833510c1c0c = level.objectives[ string( var_9906019056aeee60 ) ];
        }
        
        if ( !bot_is_capturing_zone( var_e6065833510c1c0c ) )
        {
            bot_capture_koth_zone( var_e6065833510c1c0c );
        }
    }
}

// Namespace bots_gametype_koth / scripts\mp\bots\bots_gametype_koth
// Params 0
// Checksum 0x0, Offset: 0x808
// Size: 0x72
function bot_should_cap_next_zone()
{
    if ( level.zonerandomlocationorder )
    {
        return 0;
    }
    
    strategy_level = self botgetdifficultysetting( "strategyLevel" );
    var_b79d6ac8174afeb = 0;
    
    if ( strategy_level == 1 )
    {
        var_b79d6ac8174afeb = 0.1;
    }
    else if ( strategy_level == 2 )
    {
        var_b79d6ac8174afeb = 0.5;
    }
    else if ( strategy_level == 3 )
    {
        var_b79d6ac8174afeb = 0.8;
    }
    
    return randomfloat( 1 ) < var_b79d6ac8174afeb;
}

// Namespace bots_gametype_koth / scripts\mp\bots\bots_gametype_koth
// Params 1
// Checksum 0x0, Offset: 0x882
// Size: 0x13
function bot_get_num_teammates_capturing_zone( zone )
{
    return bot_get_teammates_capturing_zone( zone ).size;
}

// Namespace bots_gametype_koth / scripts\mp\bots\bots_gametype_koth
// Params 1
// Checksum 0x0, Offset: 0x89e
// Size: 0xb7
function bot_get_teammates_capturing_zone( zone )
{
    teammates_capturing_zone = [];
    
    foreach ( other_player in level.participants )
    {
        if ( other_player != self && isteamparticipant( other_player ) && isalliedsentient( self, other_player ) )
        {
            if ( other_player istouching( level.zone.trigger ) )
            {
                if ( !isai( other_player ) || other_player bot_is_capturing_zone( zone ) )
                {
                    teammates_capturing_zone[ teammates_capturing_zone.size ] = other_player;
                }
            }
        }
    }
    
    return teammates_capturing_zone;
}

// Namespace bots_gametype_koth / scripts\mp\bots\bots_gametype_koth
// Params 1
// Checksum 0x0, Offset: 0x95e
// Size: 0x21, Type: bool
function bot_is_capturing_zone( zone )
{
    if ( !bot_is_capturing() )
    {
        return false;
    }
    
    return self.current_zone == zone;
}

// Namespace bots_gametype_koth / scripts\mp\bots\bots_gametype_koth
// Params 1
// Checksum 0x0, Offset: 0x988
// Size: 0x78
function bot_capture_koth_zone( zone )
{
    self.current_zone = zone;
    optional_params[ "entrance_points_index" ] = zone.entrance_indices;
    optional_params[ "override_origin_node" ] = zone.center_node;
    bot_capture_zone( zone.trigger.origin, zone.nodes, zone.trigger, optional_params );
}

// Namespace bots_gametype_koth / scripts\mp\bots\bots_gametype_koth
// Params 1
// Checksum 0x0, Offset: 0xa08
// Size: 0x4c
function should_start_cautious_approach_koth( firstcheck )
{
    if ( firstcheck )
    {
        team = level.zone scripts\mp\gameobjects::getownerteam();
        
        if ( team == "neutral" || team == self.team )
        {
            return 0;
        }
    }
    
    return should_start_cautious_approach_default( firstcheck );
}

