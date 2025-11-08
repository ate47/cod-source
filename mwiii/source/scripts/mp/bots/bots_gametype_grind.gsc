#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_conf;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;

#namespace bots_gametype_grind;

// Namespace bots_gametype_grind / scripts\mp\bots\bots_gametype_grind
// Params 0
// Checksum 0x0, Offset: 0x1c1
// Size: 0x10
function main()
{
    setup_callbacks();
    scripts\mp\bots\bots_gametype_conf::setup_bot_conf();
}

/#

    // Namespace bots_gametype_grind / scripts\mp\bots\bots_gametype_grind
    // Params 0
    // Checksum 0x0, Offset: 0x1d9
    // Size: 0x5, Type: dev
    function function_e45e46b7c35deadb()
    {
        
    }

#/

// Namespace bots_gametype_grind / scripts\mp\bots\bots_gametype_grind
// Params 0
// Checksum 0x0, Offset: 0x1e6
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_grind_think;
}

// Namespace bots_gametype_grind / scripts\mp\bots\bots_gametype_grind
// Params 0
// Checksum 0x0, Offset: 0x205
// Size: 0x6a
function bot_grind_think()
{
    self notify( "bot_grind_think" );
    self endon( "bot_grind_think" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self.grind_waiting_to_bank = 0;
    self.goal_zone = undefined;
    self.conf_camping_zone = 0;
    self.additional_tactical_logic_func = &bot_grind_extra_think;
    
    if ( self botgetdifficultysetting( "strategyLevel" ) > 0 )
    {
        childthread enemy_watcher();
    }
    
    scripts\mp\bots\bots_gametype_conf::bot_conf_think();
}

// Namespace bots_gametype_grind / scripts\mp\bots\bots_gametype_grind
// Params 1
// Checksum 0x0, Offset: 0x277
// Size: 0x12
function function_3ec615a6536f891f( team )
{
    return scripts\mp\gameobjects::caninteractwith( team );
}

// Namespace bots_gametype_grind / scripts\mp\bots\bots_gametype_grind
// Params 0
// Checksum 0x0, Offset: 0x292
// Size: 0xc1, Type: bool
function function_eb22fb5239067420()
{
    if ( self.grind_waiting_to_bank && isdefined( self.goal_zone ) && !self.goal_zone function_3ec615a6536f891f( self.team ) )
    {
        self.grind_waiting_to_bank = 0;
        self.goal_zone = undefined;
        self notify( "stop_going_to_zone" );
        self botclearscriptgoal();
        return false;
    }
    
    if ( self.conf_camping_zone && isdefined( self.var_12e47b0891f8e76e ) && !self.var_12e47b0891f8e76e function_3ec615a6536f891f( self.team ) )
    {
        self.conf_camping_zone = 0;
        self.var_12e47b0891f8e76e = undefined;
        self notify( "stop_camping_zone" );
        self botclearscriptgoal();
        clear_camper_data();
        return false;
    }
    
    return true;
}

// Namespace bots_gametype_grind / scripts\mp\bots\bots_gametype_grind
// Params 0
// Checksum 0x0, Offset: 0x35c
// Size: 0x423, Type: bool
function bot_grind_extra_think()
{
    if ( !function_eb22fb5239067420() )
    {
        return true;
    }
    
    if ( !isdefined( self.tag_getting ) )
    {
        if ( self.tagscarried > 0 )
        {
            bestdistsq = squared( 500 + self.tagscarried * 250 );
            
            if ( game[ "teamScores" ][ self.team ] + self.tagscarried >= level.roundscorelimit )
            {
                bestdistsq = squared( 5000 );
            }
            else if ( !isdefined( self.enemy ) && !bot_in_combat() )
            {
                bestdistsq = squared( 1500 + self.tagscarried * 250 );
            }
            
            bestzone = undefined;
            
            foreach ( objective in level.objectives )
            {
                if ( !objective function_3ec615a6536f891f( self.team ) )
                {
                    continue;
                }
                
                distsq = distancesquared( self.origin, objective.trigger.origin );
                
                if ( distsq < bestdistsq )
                {
                    bestdistsq = distsq;
                    bestzone = objective;
                }
            }
            
            if ( isdefined( bestzone ) )
            {
                var_52d6c7e049076154 = 1;
                
                if ( self.grind_waiting_to_bank )
                {
                    if ( isdefined( self.goal_zone ) && self.goal_zone == bestzone )
                    {
                        var_52d6c7e049076154 = 0;
                    }
                }
                
                if ( var_52d6c7e049076154 )
                {
                    self.grind_waiting_to_bank = 1;
                    self.goal_zone = bestzone;
                    self botclearscriptgoal();
                    self notify( "stop_going_to_zone" );
                    self notify( "stop_camping_zone" );
                    self.conf_camping_zone = 0;
                    clear_camper_data();
                    bot_abort_tactical_goal( "kill_tag" );
                    childthread bot_goto_zone( bestzone, "tactical" );
                }
            }
            
            if ( self.grind_waiting_to_bank )
            {
                if ( game[ "teamScores" ][ self.team ] + self.tagscarried >= level.roundscorelimit )
                {
                    self botsetflag( "force_sprint", 1 );
                }
                
                if ( self.tagscarried >= 4 )
                {
                    self botsetflag( "force_sprint", 1 );
                }
            }
        }
        else if ( self.grind_waiting_to_bank )
        {
            self.grind_waiting_to_bank = 0;
            self.goal_zone = undefined;
            self notify( "stop_going_to_zone" );
            self botclearscriptgoal();
        }
        
        if ( self.personality == "camper" && !self.conf_camping_tag && !self.grind_waiting_to_bank )
        {
            bestdistsq = undefined;
            bestzone = undefined;
            
            foreach ( objective in level.objectives )
            {
                if ( !objective function_3ec615a6536f891f( self.team ) )
                {
                    continue;
                }
                
                distsq = distancesquared( self.origin, objective.trigger.origin );
                
                if ( !isdefined( bestdistsq ) || distsq < bestdistsq )
                {
                    bestdistsq = distsq;
                    bestzone = objective;
                }
            }
            
            if ( isdefined( bestzone ) )
            {
                if ( should_select_new_ambush_point() )
                {
                    if ( find_ambush_node( bestzone.trigger.origin ) )
                    {
                        self.conf_camping_zone = 1;
                        self.var_12e47b0891f8e76e = bestzone;
                        self notify( "stop_going_to_zone" );
                        self.grind_waiting_to_bank = 0;
                        self botclearscriptgoal();
                        childthread bot_camp_zone( bestzone, "camp" );
                    }
                    else
                    {
                        self notify( "stop_camping_zone" );
                        self.conf_camping_zone = 0;
                        clear_camper_data();
                    }
                }
            }
            else
            {
                self.conf_camping_zone = 1;
            }
        }
    }
    else
    {
        self notify( "stop_going_to_zone" );
        self.grind_waiting_to_bank = 0;
        self.goal_zone = undefined;
        self notify( "stop_camping_zone" );
        self.conf_camping_zone = 0;
    }
    
    return self.grind_waiting_to_bank || self.conf_camping_zone;
}

// Namespace bots_gametype_grind / scripts\mp\bots\bots_gametype_grind
// Params 2
// Checksum 0x0, Offset: 0x788
// Size: 0x99
function bot_goto_zone( zone, goal_type )
{
    self endon( "stop_going_to_zone" );
    
    if ( !isdefined( zone.calculated_nearest_node ) )
    {
        zone.nearest_node = getclosestnodeinsight( zone.trigger.origin );
        zone.calculated_nearest_node = 1;
    }
    
    var_c781af3fac2aa3e5 = zone.nearest_node;
    self botsetscriptgoal( var_c781af3fac2aa3e5.origin, 32, goal_type );
    result = bot_waittill_goal_or_fail();
}

// Namespace bots_gametype_grind / scripts\mp\bots\bots_gametype_grind
// Params 2
// Checksum 0x0, Offset: 0x829
// Size: 0xd8
function bot_camp_zone( zone, goal_type )
{
    self endon( "stop_camping_zone" );
    self botsetscriptgoalnode( self.node_ambushing_from, goal_type, self.ambush_yaw );
    result = bot_waittill_goal_or_fail();
    
    if ( result == "goal" )
    {
        if ( !isdefined( zone.calculated_nearest_node ) )
        {
            zone.nearest_node = getclosestnodeinsight( zone.trigger.origin );
            zone.calculated_nearest_node = 1;
        }
        
        var_c781af3fac2aa3e5 = zone.nearest_node;
        
        if ( isdefined( var_c781af3fac2aa3e5 ) )
        {
            var_6e99c9c93e0d0552 = findentrances( self.origin );
            var_6e99c9c93e0d0552 = array_add( var_6e99c9c93e0d0552, var_c781af3fac2aa3e5 );
            childthread bot_watch_nodes( var_6e99c9c93e0d0552 );
        }
    }
}

// Namespace bots_gametype_grind / scripts\mp\bots\bots_gametype_grind
// Params 0
// Checksum 0x0, Offset: 0x909
// Size: 0x10d
function enemy_watcher()
{
    self.default_meleechargedist = self botgetdifficultysetting( "meleeChargeDist" );
    
    while ( true )
    {
        if ( self botgetdifficultysetting( "strategyLevel" ) < 2 )
        {
            wait 0.5;
        }
        else
        {
            wait 0.2;
        }
        
        if ( isdefined( self.enemy ) && isplayer( self.enemy ) && isdefined( self.enemy.tagscarried ) && self.enemy.tagscarried >= 3 && self botcanseeentity( self.enemy ) && distance( self.origin, self.enemy.origin ) <= 500 )
        {
            self botsetdifficultysetting( "meleeChargeDist", 500 );
            self botsetflag( "prefer_melee", 1 );
            continue;
        }
        
        self botsetdifficultysetting( "meleeChargeDist", self.default_meleechargedist );
        self botsetflag( "prefer_melee", 0 );
    }
}

