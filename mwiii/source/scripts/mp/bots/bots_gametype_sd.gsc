#using script_27fdece778e999d8;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\entity;

#namespace bots_gametype_sd;

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x55a
// Size: 0x10
function main()
{
    setup_callbacks();
    bot_sd_start();
}

/#

    // Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
    // Params 0
    // Checksum 0x0, Offset: 0x572
    // Size: 0x5, Type: dev
    function function_e45e46b7c35deadb()
    {
        
    }

#/

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x57f
// Size: 0x91
function setup_callbacks()
{
    level.bot_funcs[ "crate_can_use" ] = &crate_can_use;
    level.bot_funcs[ "gametype_think" ] = &bot_sd_think;
    level.bot_funcs[ "should_start_cautious_approach" ] = &should_start_cautious_approach_sd;
    level.bot_funcs[ "know_enemies_on_start" ] = undefined;
    level.bot_funcs[ "notify_enemy_bots_bomb_used" ] = &notify_enemy_team_bomb_used;
    
    if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() )
    {
        level.bot_funcs[ "player_spawned_gamemode" ] = &namespace_da125b44c190d236::function_5f51c5c13fd2911b;
        level.modifyplayerdamage = &namespace_da125b44c190d236::modifyplayerdamage;
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x618
// Size: 0x14
function bot_sd_start()
{
    /#
        thread function_6cffc65203b4d521();
    #/
    
    setup_bot_sd();
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 1
// Checksum 0x0, Offset: 0x634
// Size: 0x87, Type: bool
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
    
    if ( !isteamparticipant( self ) )
    {
        return true;
    }
    
    if ( !isdefined( self.role ) )
    {
        return false;
    }
    
    switch ( self.role )
    {
        case #"hash_26452ec2b730b2b1":
        case #"hash_700eb8b52182808d":
        case #"hash_9af4ed111fd5e8cf":
            return false;
    }
    
    return true;
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x6c4
// Size: 0x19f
function setup_bot_sd()
{
    level.bots_disable_team_switching = 1;
    level.initial_pickup_wait_time = 3000;
    bot_setup_objective_bottargets();
    bot_waittill_bots_enabled();
    level.bot_sd_override_zone_targets = [];
    level.bot_sd_override_zone_targets[ "axis" ] = [];
    level.bot_sd_override_zone_targets[ "allies" ] = [];
    level.bot_default_sd_role_behavior[ "atk_bomber" ] = &atk_bomber_update;
    level.bot_default_sd_role_behavior[ "clear_target_zone" ] = &clear_target_zone_update;
    level.bot_default_sd_role_behavior[ "defend_planted_bomb" ] = &defend_planted_bomb_update;
    level.bot_default_sd_role_behavior[ "defuser" ] = &bomb_defuser_update;
    level.bot_default_sd_role_behavior[ "investigate_someone_using_bomb" ] = &investigate_someone_using_bomb_update;
    level.bot_default_sd_role_behavior[ "camp_bomb" ] = &camp_bomb_update;
    level.bot_default_sd_role_behavior[ "defender" ] = &defender_update;
    level.bot_default_sd_role_behavior[ "backstabber" ] = &backstabber_update;
    level.bot_default_sd_role_behavior[ "random_killer" ] = &random_killer_update;
    succeeded = bot_verify_and_cache_bombzones( [ "_a", "_b" ] );
    
    if ( succeeded )
    {
        foreach ( bombzone in level.objectives )
        {
            bombzone thread monitor_bombzone_control();
        }
        
        thread bot_sd_ai_director_update();
        level.bot_gametype_precaching_done = 1;
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x86b
// Size: 0x53d
function bot_sd_think()
{
    self notify( "bot_sd_think" );
    self endon( "bot_sd_think" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self.has_started_thinking = undefined;
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "separation", 0 );
    self botsetflag( "grenade_objectives", 1 );
    self botsetflag( "use_obj_path_style", 1 );
    attacker_team = game[ "attackers" ];
    var_e96df5260fda3edd = 1;
    
    if ( isdefined( level.sdbomb ) && isdefined( level.sdbomb.carrier ) && level.sdbomb.carrier == self && isdefined( self.role ) && self.role == "atk_bomber" )
    {
        var_e96df5260fda3edd = 0;
    }
    
    if ( var_e96df5260fda3edd )
    {
        self.role = undefined;
        
        if ( isdefined( level.atk_bomber ) && level.atk_bomber == self )
        {
            level.atk_bomber = undefined;
        }
    }
    
    self.suspend_sd_role = undefined;
    self.has_started_thinking = 0;
    self.atk_bomber_no_path_to_bomb_count = 0;
    self.scripted_path_style = undefined;
    self.defender_set_script_pathstyle = undefined;
    self.defuser_bad_path_counter = 0;
    
    if ( !isdefined( level.initial_bomb_location ) && !level.multibomb )
    {
        level.initial_bomb_location = level.sdbomb.curorigin;
        level.initial_bomb_location_nearest_node = getclosestnodeinsight( level.sdbomb.curorigin );
    }
    
    if ( self.team == attacker_team && !isdefined( level.can_pickup_bomb_time ) )
    {
        var_9d5768a33c477288 = 0;
        
        if ( !level.multibomb )
        {
            players = get_living_players_on_team( attacker_team );
            
            foreach ( player in players )
            {
                if ( !isai( player ) )
                {
                    var_9d5768a33c477288 = 1;
                }
            }
        }
        
        if ( var_9d5768a33c477288 )
        {
            time = 6000;
            level.can_pickup_bomb_time = gettime() + time;
            badplace_cylinder( "bomb", time / 1000, level.sdbomb.curorigin, 75, 300, attacker_team );
        }
    }
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_c2de8ca6dc8512c1" ) )
            {
                wait 0.05;
                continue;
            }
        #/
        
        wait randomintrange( 1, 3 ) * 0.05;
        
        if ( self.health <= 0 )
        {
            continue;
        }
        
        self.has_started_thinking = 1;
        
        if ( !isdefined( self.role ) )
        {
            initialize_sd_role();
        }
        
        if ( isdefined( self.suspend_sd_role ) )
        {
            continue;
        }
        
        if ( self.team == attacker_team )
        {
            if ( !level.multibomb && isdefined( level.can_pickup_bomb_time ) && gettime() < level.can_pickup_bomb_time && !isdefined( level.sdbomb.carrier ) )
            {
                if ( !bot_is_defending_point( level.sdbomb.curorigin ) )
                {
                    var_f67c409a17d1e614 = getclosestnodeinsight( level.sdbomb.curorigin );
                    
                    if ( isdefined( var_f67c409a17d1e614 ) )
                    {
                        optional_params[ "nearest_node_to_center" ] = var_f67c409a17d1e614;
                        bot_protect_point( level.sdbomb.curorigin, 900, optional_params );
                    }
                    else
                    {
                        level.can_pickup_bomb_time = gettime();
                    }
                }
            }
            else
            {
                self [[ level.bot_default_sd_role_behavior[ self.role ] ]]();
            }
            
            continue;
        }
        
        if ( level.bombplanted )
        {
            if ( isdefined( level.sdbombmodel ) && distancesquared( self.origin, level.sdbombmodel.origin ) > squared( level.protect_radius * 2 ) )
            {
                if ( !isdefined( self.defender_set_script_pathstyle ) )
                {
                    self.defender_set_script_pathstyle = 1;
                    self botsetpathingstyle( "scripted" );
                }
            }
            else if ( isdefined( self.defender_set_script_pathstyle ) && !isdefined( self.scripted_path_style ) )
            {
                self.defender_set_script_pathstyle = undefined;
                self botsetpathingstyle( undefined );
            }
        }
        
        if ( level.bombplanted && isdefined( level.sdbombmodel ) && isdefined( level.bomb_defuser ) && self.role != "defuser" )
        {
            if ( !bot_is_defending_point( level.sdbombmodel.origin ) )
            {
                self botclearscriptgoal();
                bot_protect_point( level.sdbombmodel.origin, level.protect_radius );
            }
            
            continue;
        }
        
        self [[ level.bot_default_sd_role_behavior[ self.role ] ]]();
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 1
// Checksum 0x0, Offset: 0xdb0
// Size: 0x55
function bomber_disable_movement_for_time( time )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self botsetflag( "disable_movement", 1 );
    self botsetstance( "stand" );
    wait time;
    self botsetflag( "disable_movement", 0 );
    self botsetstance( "none" );
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0xe0d
// Size: 0x779
function atk_bomber_update()
{
    self endon( "new_role" );
    assert( level.atk_bomber == self );
    
    if ( bot_is_defending() )
    {
        bot_defend_stop();
    }
    
    if ( isdefined( level.sdbomb ) && isdefined( level.sdbomb.carrier ) && isalive( level.sdbomb.carrier ) && level.sdbomb.carrier != self )
    {
        wait 0.7;
        
        /#
            if ( isalive( level.sdbomb.carrier ) && level.sdbomb.carrier != self )
            {
                println( "<dev string:x1c>" + self.role );
                println( "<dev string:x35>" + level.sdbomb.carrier.name );
                println( "<dev string:x51>" + ter_op( isdefined( level.sdbomb.carrier.role ), level.sdbomb.carrier.role, "<dev string:x72>" ) );
                assertmsg( "<dev string:x7f>" + self.name + "<dev string:x87>" );
            }
        #/
    }
    
    if ( !self.isbombcarrier && !level.multibomb )
    {
        if ( level.bombplanted )
        {
            assertmsg( "<dev string:x7f>" + self.name + "<dev string:xe6>" );
            level.atk_bomber = undefined;
            bot_enable_tactical_goals();
            bot_set_role( "defend_planted_bomb" );
            return;
        }
        
        if ( isdefined( level.sdbomb ) )
        {
            if ( !isdefined( self.last_bomb_location ) )
            {
                self.last_bomb_location = level.sdbomb.curorigin;
            }
            
            if ( distancesquared( self.last_bomb_location, level.sdbomb.curorigin ) > 4 )
            {
                self botclearscriptgoal();
                self.last_bomb_location = level.sdbomb.curorigin;
            }
        }
        
        /#
            if ( self bothasscriptgoal() )
            {
                goal = self botgetscriptgoal();
                
                if ( distancesquared( goal, self.origin ) < 100 )
                {
                    if ( !isdefined( self.var_51804ec9dde994d ) || distancesquared( self.var_51804ec9dde994d, goal ) >= 100 )
                    {
                        assertmsg( "<dev string:x13d>" + goal + "<dev string:x1ab>" + level.sdbomb.curorigin );
                    }
                    
                    self.var_51804ec9dde994d = goal;
                }
            }
        #/
        
        if ( self.atk_bomber_no_path_to_bomb_count >= 2 )
        {
            nodes = getnodesinradiussorted( level.sdbomb.curorigin, 512, 0 );
            best_node = undefined;
            
            foreach ( node in nodes )
            {
                if ( !node nodeisdisconnected() )
                {
                    best_node = node;
                    break;
                }
            }
            
            if ( isdefined( best_node ) )
            {
                self botsetscriptgoal( best_node.origin, 20, "critical" );
                bot_waittill_goal_or_fail();
                
                if ( isdefined( level.sdbomb ) && !isdefined( level.sdbomb.carrier ) )
                {
                    level.sdbomb scripts\mp\gameobjects::setpickedup( self );
                }
                
                return;
            }
            
            assertmsg( "<dev string:x1bf>" + level.sdbomb.curorigin );
            return;
        }
        
        if ( !self bothasscriptgoal() )
        {
            bot_radius = 15;
            bomb_radius = 32;
            var_7f18dda105927d60 = bot_queued_process( "BotGetClosestNavigablePoint", &func_bot_get_closest_navigable_point, level.sdbomb.curorigin, bot_radius + bomb_radius, self );
            
            if ( isdefined( var_7f18dda105927d60 ) )
            {
                set_goal = self botsetscriptgoal( level.sdbomb.curorigin, 0, "critical" );
                
                if ( set_goal )
                {
                    childthread bomber_monitor_no_path();
                }
            }
            else
            {
                nodes = getnodesinradiussorted( level.sdbomb.curorigin, 512, 0 );
                
                if ( nodes.size > 0 )
                {
                    self botsetscriptgoal( nodes[ 0 ].origin, 0, "critical" );
                    bot_waittill_goal_or_fail();
                }
                
                if ( isdefined( level.sdbomb ) && !isdefined( level.sdbomb.carrier ) )
                {
                    var_7f18dda105927d60 = bot_queued_process( "BotGetClosestNavigablePoint", &func_bot_get_closest_navigable_point, level.sdbomb.curorigin, bot_radius + bomb_radius, self );
                    
                    if ( !isdefined( var_7f18dda105927d60 ) )
                    {
                        level.sdbomb scripts\mp\gameobjects::setpickedup( self );
                    }
                }
            }
        }
        
        return;
    }
    
    assert( isdefined( self.carryobject ) || level.multibomb );
    
    if ( isdefined( self.dont_plant_until_time ) && gettime() < self.dont_plant_until_time )
    {
        return;
    }
    
    if ( !isdefined( level.bomb_zone_assaulting ) )
    {
        level.bomb_zone_assaulting = random( level.objectives );
    }
    
    bombzonegoal = level.bomb_zone_assaulting;
    self.bombzonegoal = bombzonegoal;
    
    if ( !isdefined( level.initial_bomb_pickup_time ) || gettime() - level.initial_bomb_pickup_time < level.initial_pickup_wait_time )
    {
        level.initial_bomb_pickup_time = gettime() + level.initial_pickup_wait_time;
        thread bomber_disable_movement_for_time( level.initial_pickup_wait_time / 1000 );
        wait level.initial_pickup_wait_time / 1000;
    }
    
    self botclearscriptgoal();
    
    if ( level.attack_behavior == "rush" )
    {
        self botsetpathingstyle( "scripted" );
        var_735fd56db96f509c = get_bombzone_node_to_plant_on( bombzonegoal, 1 );
        self botsetscriptgoal( var_735fd56db96f509c.origin, 0, "critical" );
    }
    
    pathresult = bot_waittill_goal_or_fail();
    
    if ( pathresult == "goal" )
    {
        time_left = get_round_end_time() - gettime();
        var_87e36bcbd7af1d56 = time_left - level.planttime * 2 * 1000;
        var_d77e04d8d7105bb0 = gettime() + var_87e36bcbd7af1d56;
        
        if ( var_87e36bcbd7af1d56 > 0 )
        {
            bot_waittill_out_of_combat_or_time( var_87e36bcbd7af1d56 );
        }
        
        var_5b45d81d67839650 = gettime() >= var_d77e04d8d7105bb0;
        succeeded = bombzone_press_use( level.planttime + 2, "bomb_planted", var_5b45d81d67839650 );
        self botclearscriptgoal();
        
        if ( succeeded )
        {
            assert( level.bombplanted );
            bot_enable_tactical_goals();
            bot_set_role( "defend_planted_bomb" );
            return;
        }
        
        assert( !level.bombplanted );
        
        if ( var_87e36bcbd7af1d56 > 5000 )
        {
            self.dont_plant_until_time = gettime() + 5000;
        }
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x158e
// Size: 0x28
function get_round_end_time()
{
    if ( level.bombplanted )
    {
        return level.defuseendtime;
    }
    
    return gettime() + scripts\mp\gamelogic::gettimeremaining();
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x15be
// Size: 0x48
function bomber_monitor_no_path()
{
    self notify( "bomber_monitor_no_path" );
    self endon( "death_or_disconnect" );
    self endon( "goal" );
    self endon( "bomber_monitor_no_path" );
    level.sdbomb endon( "pickup_object" );
    
    while ( true )
    {
        self waittill( "no_path" );
        self.atk_bomber_no_path_to_bomb_count++;
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x160e
// Size: 0x17b
function clear_target_zone_update()
{
    self endon( "new_role" );
    
    if ( isdefined( level.atk_bomber ) )
    {
        if ( level.attack_behavior == "rush" )
        {
            if ( !isdefined( self.set_initial_rush_goal ) )
            {
                if ( !level.multibomb )
                {
                    optional_params[ "nearest_node_to_center" ] = level.initial_bomb_location_nearest_node;
                    bot_protect_point( level.initial_bomb_location, 900, optional_params );
                    wait randomfloatrange( 0, 4 );
                    bot_defend_stop();
                }
                
                self.set_initial_rush_goal = 1;
            }
            
            if ( self botgetdifficultysetting( "strategyLevel" ) > 0 )
            {
                set_force_sprint();
            }
            
            if ( isai( level.atk_bomber ) && isdefined( level.atk_bomber.bombzonegoal ) )
            {
                bombzonetarget = level.atk_bomber.bombzonegoal;
            }
            else if ( isdefined( level.bomb_zone_assaulting ) )
            {
                bombzonetarget = level.bomb_zone_assaulting;
            }
            else
            {
                bombzonetarget = find_closest_bombzone_to_player( level.atk_bomber );
            }
            
            if ( !bot_is_defending_point( bombzonetarget.curorigin ) )
            {
                optional_params[ "min_goal_time" ] = 2;
                optional_params[ "max_goal_time" ] = 4;
                optional_params[ "override_origin_node" ] = random( bombzonetarget.bottargets );
                bot_protect_point( bombzonetarget.curorigin, level.protect_radius, optional_params );
            }
        }
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x1791
// Size: 0x93
function defend_planted_bomb_update()
{
    self endon( "new_role" );
    
    if ( level.bombplanted && isdefined( level.sdbombmodel ) )
    {
        if ( level.attack_behavior == "rush" )
        {
            disable_force_sprint();
        }
        
        if ( !bot_is_defending_point( level.sdbombmodel.origin ) )
        {
            optional_params[ "score_flags" ] = "strongly_avoid_center";
            bot_protect_point( level.sdbombmodel.origin, level.protect_radius, optional_params );
        }
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x182c
// Size: 0x2c2
function bomb_defuser_update()
{
    self endon( "new_role" );
    
    if ( level.bombdefused || !isdefined( level.sdbombmodel ) )
    {
        return;
    }
    
    zone = find_ticking_bomb();
    
    if ( !isdefined( zone ) )
    {
        return;
    }
    
    var_e6cfe3243aa08909 = get_array_of_closest( level.sdbombmodel.origin, zone.bottargets );
    var_2fea4b3d4aab8868 = ( level.sdbombmodel.origin[ 0 ], level.sdbombmodel.origin[ 1 ], var_e6cfe3243aa08909[ 0 ].origin[ 2 ] );
    
    if ( self.defuser_bad_path_counter <= 1 )
    {
        var_b66a59eac85e4643 = cautious_approach_till_close( var_2fea4b3d4aab8868, undefined );
    }
    else
    {
        self botclearscriptgoal();
        var_b66a59eac85e4643 = self botsetscriptgoal( var_2fea4b3d4aab8868, 20, "critical" );
    }
    
    if ( !var_b66a59eac85e4643 )
    {
        return;
    }
    
    pathresult = bot_waittill_goal_or_fail();
    
    if ( pathresult == "bad_path" )
    {
        self.defuser_bad_path_counter++;
        
        if ( self.defuser_bad_path_counter >= 4 )
        {
            while ( true )
            {
                nodes = getnodesinradiussorted( var_2fea4b3d4aab8868, 50, 0 );
                potential_index = self.defuser_bad_path_counter - 4;
                
                if ( nodes.size <= potential_index )
                {
                    closest_point = botgetclosestnavigablepoint( var_2fea4b3d4aab8868, 50, self );
                    
                    if ( isdefined( closest_point ) )
                    {
                        self botsetscriptgoal( closest_point, 20, "critical" );
                    }
                    else
                    {
                        break;
                    }
                }
                else
                {
                    self botsetscriptgoal( nodes[ potential_index ].origin, 20, "critical" );
                }
                
                pathresult = bot_waittill_goal_or_fail();
                
                if ( pathresult == "bad_path" )
                {
                    self.defuser_bad_path_counter++;
                    continue;
                }
                
                break;
            }
        }
    }
    
    if ( pathresult == "goal" )
    {
        time_left = get_round_end_time() - gettime();
        var_bae7d7b60ce8ffc3 = time_left - level.defusetime * 2 * 1000;
        var_bb36f4158262888d = gettime() + var_bae7d7b60ce8ffc3;
        
        if ( var_bae7d7b60ce8ffc3 > 0 )
        {
            bot_waittill_out_of_combat_or_time( var_bae7d7b60ce8ffc3 );
        }
        
        var_8759dc70176704ad = gettime() >= var_bb36f4158262888d;
        var_e8376b7b324e07bb = level.sdbombmodel.origin[ 2 ] - self.origin[ 2 ];
        succeeded = bombzone_press_use( level.defusetime + 2, "bomb_defused", var_8759dc70176704ad, var_e8376b7b324e07bb > 40 );
        
        if ( !succeeded && self.defuser_bad_path_counter >= 4 )
        {
            self.defuser_bad_path_counter++;
        }
        
        self botclearscriptgoal();
        bot_enable_tactical_goals();
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x1af6
// Size: 0x76
function investigate_someone_using_bomb_update()
{
    self endon( "new_role" );
    
    if ( bot_is_defending() )
    {
        bot_defend_stop();
    }
    
    closest_bomb_zone = find_closest_bombzone_to_player( self );
    self botsetscriptgoalnode( random( closest_bomb_zone.bottargets ), "critical" );
    result = bot_waittill_goal_or_fail();
    
    if ( result == "goal" )
    {
        wait 2;
        bot_set_role( self.prev_role );
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x1b74
// Size: 0xba
function camp_bomb_update()
{
    self endon( "new_role" );
    
    if ( isdefined( level.sdbomb.carrier ) )
    {
        if ( self.prev_role == "defender" )
        {
            self.defend_zone = find_closest_bombzone_to_player( self );
        }
        
        bot_set_role( self.prev_role );
        return;
    }
    
    if ( !bot_is_defending_point( level.sdbomb.curorigin ) )
    {
        optional_params[ "nearest_node_to_center" ] = level.sdbomb.nearest_node_for_camping;
        bot_protect_point( level.sdbomb.curorigin, level.protect_radius, optional_params );
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x1c36
// Size: 0x81
function defender_update()
{
    self endon( "new_role" );
    
    if ( !bot_is_defending_point( self.defend_zone.curorigin ) )
    {
        optional_params[ "score_flags" ] = "strict_los";
        optional_params[ "override_origin_node" ] = random( self.defend_zone.bottargets );
        bot_protect_point( self.defend_zone.curorigin, level.protect_radius, optional_params );
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x1cbf
// Size: 0x378
function backstabber_update()
{
    self endon( "new_role" );
    
    if ( bot_is_defending() )
    {
        bot_defend_stop();
    }
    
    if ( !isdefined( self.backstabber_stage ) )
    {
        self.backstabber_stage = "1_move_to_midpoint";
    }
    
    if ( self.backstabber_stage == "1_move_to_midpoint" && isdefined( level.objectives[ "_a" ] ) && isdefined( level.objectives[ "_b" ] ) )
    {
        var_7c32b030e8d60f75 = level.objectives[ "_a" ].curorigin;
        var_33f217cfbc5d84 = level.objectives[ "_b" ].curorigin;
        midpoint = ( ( var_7c32b030e8d60f75[ 0 ] + var_33f217cfbc5d84[ 0 ] ) * 0.5, ( var_7c32b030e8d60f75[ 1 ] + var_33f217cfbc5d84[ 1 ] ) * 0.5, ( var_7c32b030e8d60f75[ 2 ] + var_33f217cfbc5d84[ 2 ] ) * 0.5 );
        nodes = getnodesinradiussorted( midpoint, 512, 0 );
        
        if ( nodes.size == 0 )
        {
            bot_set_role( "random_killer" );
            return;
        }
        
        node_picked = undefined;
        total_weights = int( nodes.size * ( nodes.size + 1 ) * 0.5 );
        var_b7994b0fd923157a = randomint( total_weights );
        
        for ( i = 0; i < nodes.size ; i++ )
        {
            node_weight = nodes.size - i;
            
            if ( var_b7994b0fd923157a < node_weight )
            {
                node_picked = nodes[ i ];
                break;
            }
            
            var_b7994b0fd923157a -= node_weight;
        }
        
        self botsetpathingstyle( "scripted" );
        set_goal = self botsetscriptgoalnode( node_picked, "guard" );
        
        if ( set_goal )
        {
            pathresult = bot_waittill_goal_or_fail();
            
            if ( pathresult == "goal" )
            {
                wait randomfloatrange( 1, 4 );
                self.backstabber_stage = "2_move_to_enemy_spawn";
            }
        }
    }
    
    if ( self.backstabber_stage == "2_move_to_enemy_spawn" )
    {
        attacker_spawns = scripts\mp\spawnlogic::getspawnpointarray( "mp_sd_spawn_attacker" );
        spawn_target = random( attacker_spawns );
        self botsetpathingstyle( "scripted" );
        set_goal = self botsetscriptgoal( spawn_target.origin, 250, "guard" );
        
        if ( set_goal )
        {
            pathresult = bot_waittill_goal_or_fail();
            
            if ( pathresult == "goal" )
            {
                self.backstabber_stage = "3_move_to_bombzone";
            }
        }
    }
    
    if ( self.backstabber_stage == "3_move_to_bombzone" )
    {
        if ( !isdefined( self.bombzone_picked ) )
        {
            self.bombzone_picked = random( level.objectives );
        }
        
        self botsetpathingstyle( undefined );
        set_goal = self botsetscriptgoal( random( self.bombzone_picked.bottargets ).origin, 160, "objective" );
        
        if ( set_goal )
        {
            pathresult = bot_waittill_goal_or_fail();
            
            if ( pathresult == "goal" )
            {
                self botclearscriptgoal();
                self.backstabber_stage = "2_move_to_enemy_spawn";
                
                foreach ( objective in level.objectives )
                {
                    if ( objective != self.bombzone_picked )
                    {
                        self.bombzone_picked = objective;
                        break;
                    }
                }
            }
        }
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x203f
// Size: 0x26
function random_killer_update()
{
    self endon( "new_role" );
    
    if ( bot_is_defending() )
    {
        bot_defend_stop();
    }
    
    self [[ self.personality_update_function ]]();
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x206d
// Size: 0x28
function set_force_sprint()
{
    if ( !isdefined( self.always_sprint ) )
    {
        self botsetflag( "force_sprint", 1 );
        self.always_sprint = 1;
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x209d
// Size: 0x26
function disable_force_sprint()
{
    if ( isdefined( self.always_sprint ) )
    {
        self botsetflag( "force_sprint", 0 );
        self.always_sprint = undefined;
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x20cb
// Size: 0x26
function set_scripted_pathing_style()
{
    if ( !isdefined( self.scripted_path_style ) )
    {
        self botsetpathingstyle( "scripted" );
        self.scripted_path_style = 1;
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 2
// Checksum 0x0, Offset: 0x20f9
// Size: 0xb4
function cautious_approach_till_close( target, label )
{
    capture_radius = level.capture_radius;
    optional_params[ "entrance_points_index" ] = label;
    bot_capture_point( target, capture_radius, optional_params );
    wait 0.05;
    
    while ( distancesquared( self.origin, target ) > capture_radius * capture_radius && bot_is_defending() )
    {
        if ( get_round_end_time() - gettime() < 20000 )
        {
            set_scripted_pathing_style();
            set_force_sprint();
            break;
        }
        
        wait 0.05;
    }
    
    if ( bot_is_defending() )
    {
        bot_defend_stop();
    }
    
    return self botsetscriptgoal( target, 20, "critical" );
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 1
// Checksum 0x0, Offset: 0x21b6
// Size: 0x7c
function notify_enemy_team_bomb_used( type )
{
    players = get_ai_hearing_bomb_plant_sound( type );
    
    foreach ( player in players )
    {
        if ( isdefined( player.role ) )
        {
            player bot_set_role( "investigate_someone_using_bomb" );
        }
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 1
// Checksum 0x0, Offset: 0x223a
// Size: 0x10a
function should_start_cautious_approach_sd( firstcheck )
{
    var_8fa07dc6dc122490 = 2000;
    var_334d85f434992401 = var_8fa07dc6dc122490 * var_8fa07dc6dc122490;
    
    if ( firstcheck )
    {
        if ( get_round_end_time() - gettime() < 15000 )
        {
            return 0;
        }
        
        var_8331082fc25e5e1d = 0;
        enemy_team = get_enemy_team( self.team );
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.team ) )
            {
                continue;
            }
            
            if ( isalive( player ) && player.team == enemy_team )
            {
                var_8331082fc25e5e1d = 1;
            }
        }
        
        return var_8331082fc25e5e1d;
    }
    
    return distancesquared( self.origin, self.bot_defending_center ) <= var_334d85f434992401 && self botpursuingscriptgoal();
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 1
// Checksum 0x0, Offset: 0x234c
// Size: 0x109
function get_players_defending_zone( zone )
{
    var_b73e8bd7cc328b51 = [];
    var_41f00d5086d9f26c = get_living_players_on_team( game[ "defenders" ] );
    
    foreach ( player in var_41f00d5086d9f26c )
    {
        if ( isai( player ) && isdefined( player.role ) && player.role == "defender" )
        {
            if ( isdefined( player.defend_zone ) && player.defend_zone == zone )
            {
                var_b73e8bd7cc328b51 = array_add( var_b73e8bd7cc328b51, player );
            }
            
            continue;
        }
        
        if ( distancesquared( player.origin, zone.curorigin ) < level.protect_radius * level.protect_radius )
        {
            var_b73e8bd7cc328b51 = array_add( var_b73e8bd7cc328b51, player );
        }
    }
    
    return var_b73e8bd7cc328b51;
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x245e
// Size: 0x8a
function find_ticking_bomb()
{
    if ( isdefined( level.tickingobject ) )
    {
        foreach ( zone in level.objectives )
        {
            if ( distancesquared( level.tickingobject.origin, zone.curorigin ) < 90000 )
            {
                return zone;
            }
        }
    }
    
    return undefined;
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 1
// Checksum 0x0, Offset: 0x24f1
// Size: 0x3f
function get_specific_zone( zone_letter )
{
    assert( zone_letter == "<dev string:x1f8>" || zone_letter == "<dev string:x1fd>" );
    zone_letter = "_" + tolower( zone_letter );
    return level.objectives[ zone_letter ];
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x2539
// Size: 0x63
function bomber_wait_for_death()
{
    self endon( "stopped_being_bomb_carrier" );
    self endon( "new_role" );
    self waittill( "death_or_disconnect" );
    level.atk_bomber = undefined;
    level.last_atk_bomber_death_time = gettime();
    
    if ( isdefined( self ) )
    {
        self.role = undefined;
    }
    
    ai_attackers = get_living_players_on_team( game[ "attackers" ], 1 );
    force_all_players_to_role( ai_attackers, undefined );
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x25a4
// Size: 0x4c
function bomber_wait_for_bomb_reset()
{
    self endon( "death_or_disconnect" );
    self endon( "stopped_being_bomb_carrier" );
    level.sdbomb endon( "pickup_object" );
    level.sdbomb waittill( "reset" );
    
    if ( isaiteamparticipant( self ) )
    {
        self botclearscriptgoal();
    }
    
    bot_set_role( "atk_bomber" );
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x25f8
// Size: 0x7e
function set_new_bomber()
{
    assert( isteamparticipant( self ) );
    level.atk_bomber = self;
    bot_set_role( "atk_bomber" );
    thread bomber_wait_for_death();
    
    if ( !level.multibomb )
    {
        thread bomber_wait_for_bomb_reset();
    }
    
    if ( isai( self ) )
    {
        bot_disable_tactical_goals();
        
        if ( level.attack_behavior == "rush" && self botgetdifficultysetting( "strategyLevel" ) > 0 )
        {
            set_force_sprint();
        }
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x267e
// Size: 0x44f
function initialize_sd_role()
{
    if ( self.team == game[ "attackers" ] )
    {
        if ( level.bombplanted )
        {
            bot_set_role( "defend_planted_bomb" );
        }
        else if ( !isdefined( level.atk_bomber ) )
        {
            set_new_bomber();
        }
        else if ( level.attack_behavior == "rush" )
        {
            bot_set_role( "clear_target_zone" );
        }
        
        return;
    }
    
    backstabbers = get_players_by_role( "backstabber" );
    defenders = get_players_by_role( "defender" );
    personality_type = level.bot_personality_type[ self.personality ];
    strategy_level = self botgetdifficultysetting( "strategyLevel" );
    
    if ( personality_type == "active" )
    {
        if ( !isdefined( self.role ) && level.allow_backstabbers && strategy_level > 0 )
        {
            if ( backstabbers.size == 0 )
            {
                bot_set_role( "backstabber" );
            }
            else
            {
                var_62ba97c0dbe82a6c = 1;
                
                foreach ( stabber in backstabbers )
                {
                    var_f08102f5f5ef20d = level.bot_personality_type[ stabber.personality ];
                    
                    if ( var_f08102f5f5ef20d == "active" )
                    {
                        var_62ba97c0dbe82a6c = 0;
                        break;
                    }
                }
                
                if ( var_62ba97c0dbe82a6c )
                {
                    bot_set_role( "backstabber" );
                    backstabbers[ 0 ] bot_set_role( undefined );
                }
            }
        }
        
        if ( !isdefined( self.role ) )
        {
            if ( defenders.size < 4 )
            {
                bot_set_role( "defender" );
            }
        }
        
        if ( !isdefined( self.role ) )
        {
            random_choice = randomint( 4 );
            
            if ( random_choice == 3 && level.allow_random_killers && strategy_level > 0 )
            {
                bot_set_role( "random_killer" );
            }
            else if ( random_choice == 2 && level.allow_backstabbers && strategy_level > 0 )
            {
                bot_set_role( "backstabber" );
            }
            else
            {
                bot_set_role( "defender" );
            }
        }
    }
    else if ( personality_type == "stationary" )
    {
        if ( !isdefined( self.role ) )
        {
            if ( defenders.size < 4 )
            {
                bot_set_role( "defender" );
            }
            else
            {
                foreach ( defender in defenders )
                {
                    var_5c7e92e7b121ba6c = level.bot_personality_type[ defender.personality ];
                    
                    if ( var_5c7e92e7b121ba6c == "active" )
                    {
                        bot_set_role( "defender" );
                        defender bot_set_role( undefined );
                        break;
                    }
                }
            }
        }
        
        if ( !isdefined( self.role ) && level.allow_backstabbers && strategy_level > 0 )
        {
            if ( backstabbers.size == 0 )
            {
                bot_set_role( "backstabber" );
            }
        }
        
        if ( !isdefined( self.role ) )
        {
            bot_set_role( "defender" );
        }
    }
    
    if ( self.role == "defender" )
    {
        if ( getgametype() != "defuse" )
        {
            assert( level.objectives.size == 2 );
        }
        
        possible_zones = level.objectives;
        
        if ( has_override_zone_targets( self.team ) )
        {
            possible_zones = get_override_zone_targets( self.team );
        }
        
        if ( possible_zones.size == 1 )
        {
            self.defend_zone = possible_zones[ "_a" ];
            return;
        }
        
        var_669f62e425815aa5 = get_players_defending_zone( possible_zones[ "_a" ] );
        var_669f61e425815872 = get_players_defending_zone( possible_zones[ "_b" ] );
        
        if ( var_669f62e425815aa5.size < var_669f61e425815872.size )
        {
            self.defend_zone = possible_zones[ "_a" ];
            return;
        }
        
        if ( var_669f61e425815872.size < var_669f62e425815aa5.size )
        {
            self.defend_zone = possible_zones[ "_b" ];
            return;
        }
        
        self.defend_zone = random( possible_zones );
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 1
// Checksum 0x0, Offset: 0x2ad5
// Size: 0x47
function bot_set_role( new_role )
{
    if ( isai( self ) )
    {
        bot_defend_stop();
        self botsetpathingstyle( undefined );
    }
    
    self.prev_role = self.role;
    self.role = new_role;
    self notify( "new_role" );
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 2
// Checksum 0x0, Offset: 0x2b24
// Size: 0x2b
function bot_set_role_delayed( new_role, wait_time )
{
    self endon( "death_or_disconnect" );
    self endon( "new_role" );
    wait wait_time;
    bot_set_role( new_role );
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 3
// Checksum 0x0, Offset: 0x2b57
// Size: 0x86
function force_all_players_to_role( players, role, var_7bdd50bfdd1b9031 )
{
    foreach ( player in players )
    {
        if ( isdefined( var_7bdd50bfdd1b9031 ) )
        {
            player thread bot_set_role_delayed( role, randomfloatrange( 0, var_7bdd50bfdd1b9031 ) );
            continue;
        }
        
        player thread bot_set_role( role );
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 1
// Checksum 0x0, Offset: 0x2be5
// Size: 0x16
function get_override_zone_targets( team )
{
    return level.bot_sd_override_zone_targets[ team ];
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 1
// Checksum 0x0, Offset: 0x2c04
// Size: 0x22, Type: bool
function has_override_zone_targets( team )
{
    override_targets = get_override_zone_targets( team );
    return override_targets.size > 0;
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 1
// Checksum 0x0, Offset: 0x2c2f
// Size: 0x9e
function get_players_by_role( role )
{
    players = [];
    
    foreach ( player in level.participants )
    {
        if ( isalive( player ) && isteamparticipant( player ) && isdefined( player.role ) && player.role == role )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x2cd6
// Size: 0x909
function bot_sd_ai_director_update()
{
    level notify( "bot_sd_ai_director_update" );
    level endon( "bot_sd_ai_director_update" );
    level endon( "game_ended" );
    level.allow_backstabbers = randomint( 3 ) <= 1;
    level.allow_random_killers = randomint( 3 ) <= 1;
    level.attack_behavior = "rush";
    level.protect_radius = 725;
    level.capture_radius = 140;
    
    while ( true )
    {
        if ( isdefined( level.sdbomb ) && isdefined( level.sdbomb.carrier ) && !isai( level.sdbomb.carrier ) )
        {
            level.bomb_zone_assaulting = find_closest_bombzone_to_player( level.sdbomb.carrier );
        }
        
        var_d3e8b7250c920e3b = 0;
        
        if ( !level.bombplanted )
        {
            living_attackers = get_living_players_on_team( game[ "attackers" ] );
            
            foreach ( player in living_attackers )
            {
                if ( player.isbombcarrier )
                {
                    level.can_pickup_bomb_time = gettime();
                    
                    if ( !isdefined( level.atk_bomber ) || player != level.atk_bomber )
                    {
                        if ( isdefined( level.atk_bomber ) && isalive( level.atk_bomber ) )
                        {
                            level.atk_bomber bot_set_role( undefined );
                            level.atk_bomber notify( "stopped_being_bomb_carrier" );
                        }
                        
                        var_d3e8b7250c920e3b = 1;
                        player set_new_bomber();
                    }
                }
            }
            
            if ( !level.multibomb && !isdefined( level.sdbomb.carrier ) )
            {
                var_9d84a6dd1297510d = getclosestnodeinsight( level.sdbomb.curorigin );
                
                if ( isdefined( var_9d84a6dd1297510d ) )
                {
                    level.sdbomb.nearest_node_for_camping = var_9d84a6dd1297510d;
                    var_41a4b4ceba91ed4e = 0;
                    var_f0833aab2b73079e = get_living_players_on_team( game[ "defenders" ], 1 );
                    
                    foreach ( ai in var_f0833aab2b73079e )
                    {
                        var_b6f1deb8e946e67c = ai getnearestnode();
                        strategy_level = ai botgetdifficultysetting( "strategyLevel" );
                        
                        if ( strategy_level > 0 && ai.role != "camp_bomb" && isdefined( var_b6f1deb8e946e67c ) && nodesvisible( var_9d84a6dd1297510d, var_b6f1deb8e946e67c, 1 ) )
                        {
                            bot_fov = ai botgetfovdot();
                            
                            if ( within_fov( ai.origin, ai getplayerangles(), level.sdbomb.curorigin, bot_fov ) )
                            {
                                if ( strategy_level >= 2 || distancesquared( ai.origin, level.sdbomb.curorigin ) < squared( 700 ) )
                                {
                                    var_41a4b4ceba91ed4e = 1;
                                    break;
                                }
                            }
                        }
                    }
                    
                    if ( var_41a4b4ceba91ed4e )
                    {
                        foreach ( ai in var_f0833aab2b73079e )
                        {
                            if ( ai.role != "camp_bomb" && ai botgetdifficultysetting( "strategyLevel" ) > 0 )
                            {
                                ai bot_set_role( "camp_bomb" );
                            }
                        }
                    }
                }
            }
            
            possible_zones = level.objectives;
            
            if ( has_override_zone_targets( game[ "defenders" ] ) )
            {
                possible_zones = get_override_zone_targets( game[ "defenders" ] );
            }
            
            foreach ( i in possible_zones )
            {
                foreach ( j in possible_zones )
                {
                    var_eaea273876fe3e3e = get_players_defending_zone( i );
                    var_eaea263876fe3c0b = get_players_defending_zone( j );
                    
                    if ( var_eaea273876fe3e3e.size > var_eaea263876fe3c0b.size + 1 )
                    {
                        var_24050f51453437c9 = [];
                        
                        foreach ( player in var_eaea273876fe3e3e )
                        {
                            if ( isai( player ) )
                            {
                                var_24050f51453437c9 = array_add( var_24050f51453437c9, player );
                            }
                        }
                        
                        if ( var_24050f51453437c9.size > 0 )
                        {
                            defender = random( var_24050f51453437c9 );
                            defender bot_defend_stop();
                            defender.defend_zone = j;
                        }
                    }
                }
            }
        }
        else
        {
            if ( isdefined( level.atk_bomber ) )
            {
                level.atk_bomber = undefined;
            }
            
            if ( !isdefined( level.bomb_defuser ) || !isalive( level.bomb_defuser ) )
            {
                var_98dd7d6e449918f2 = [];
                defenders = get_players_by_role( "defender" );
                backstabbers = get_players_by_role( "backstabber" );
                random_killers = get_players_by_role( "random_killer" );
                
                if ( defenders.size > 0 )
                {
                    var_98dd7d6e449918f2 = defenders;
                }
                else if ( backstabbers.size > 0 )
                {
                    var_98dd7d6e449918f2 = backstabbers;
                }
                else if ( random_killers.size > 0 )
                {
                    var_98dd7d6e449918f2 = random_killers;
                }
                
                if ( var_98dd7d6e449918f2.size > 0 && isdefined( level.sdbombmodel ) )
                {
                    [ level.bomb_defuser ] = get_array_of_closest( level.sdbombmodel.origin, var_98dd7d6e449918f2 );
                    level.bomb_defuser bot_set_role( "defuser" );
                    level.bomb_defuser bot_disable_tactical_goals();
                    level.bomb_defuser thread defuser_wait_for_death();
                }
            }
            
            if ( !isdefined( level.sd_bomb_just_planted ) )
            {
                level.sd_bomb_just_planted = 1;
                attackers = get_living_players_on_team( game[ "attackers" ] );
                
                foreach ( player in attackers )
                {
                    if ( isdefined( player.role ) )
                    {
                        if ( player.role == "atk_bomber" )
                        {
                            player thread bot_set_role( undefined );
                            continue;
                        }
                        
                        if ( player.role != "defend_planted_bomb" )
                        {
                            player thread bot_set_role_delayed( "defend_planted_bomb", randomfloatrange( 0, 3 ) );
                        }
                    }
                }
            }
        }
        
        /#
            if ( !level.multibomb && !level.bombplanted && ( !isdefined( level.last_atk_bomber_death_time ) || gettime() - level.last_atk_bomber_death_time > 300 ) )
            {
                attackers = get_living_players_on_team( game[ "<dev string:x202>" ] );
                
                if ( attackers.size > 0 )
                {
                    carriers = [];
                    var_e46dc92aa60d0f0f = [];
                    var_9cfb1c3171b59a0e = 0;
                    
                    foreach ( player in attackers )
                    {
                        if ( isdefined( player.has_started_thinking ) && player.has_started_thinking )
                        {
                            var_9cfb1c3171b59a0e = 1;
                        }
                        
                        if ( isteamparticipant( player ) )
                        {
                            if ( player.isbombcarrier )
                            {
                                carriers[ carriers.size ] = player;
                            }
                            
                            if ( isdefined( player.role ) && player.role == "<dev string:x20f>" )
                            {
                                var_e46dc92aa60d0f0f[ var_e46dc92aa60d0f0f.size ] = player;
                            }
                        }
                    }
                    
                    if ( var_9cfb1c3171b59a0e )
                    {
                        if ( var_e46dc92aa60d0f0f.size != 1 )
                        {
                            assertmsg( "<dev string:x21d>" + var_e46dc92aa60d0f0f.size + "<dev string:x25b>" + attackers.size );
                        }
                        else
                        {
                            assert( var_e46dc92aa60d0f0f[ 0 ] == level.atk_bomber );
                        }
                    }
                    
                    assert( carriers.size <= 1 );
                    
                    if ( carriers.size == 1 )
                    {
                        assert( isdefined( var_e46dc92aa60d0f0f[ 0 ] ) );
                        assert( carriers[ 0 ] == level.sdbomb.carrier );
                        assert( carriers[ 0 ] == var_e46dc92aa60d0f0f[ 0 ] );
                    }
                }
            }
        #/
        
        wait 0.5;
    }
}

// Namespace bots_gametype_sd / scripts\mp\bots\bots_gametype_sd
// Params 0
// Checksum 0x0, Offset: 0x35e7
// Size: 0x14
function defuser_wait_for_death()
{
    self waittill( "death_or_disconnect" );
    level.bomb_defuser = undefined;
}

