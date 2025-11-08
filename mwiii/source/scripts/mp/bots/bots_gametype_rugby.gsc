#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\rugby;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\teams;

#namespace bots_gametype_rugby;

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 0
// Checksum 0x0, Offset: 0x26b
// Size: 0x10
function main()
{
    setup_callbacks();
    function_7f19d11dbf8f7c20();
}

/#

    // Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
    // Params 0
    // Checksum 0x0, Offset: 0x283
    // Size: 0x5, Type: dev
    function function_e45e46b7c35deadb()
    {
        
    }

#/

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 0
// Checksum 0x0, Offset: 0x290
// Size: 0x50
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_rugby_think;
    level.bot_funcs[ "crate_can_use" ] = &crate_can_use;
    level.bot_funcs[ "know_enemies_on_start" ] = undefined;
    level.bot_funcs[ "jugg_picked_up_cancel" ] = &function_e1792f85cfa1c508;
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 0
// Checksum 0x0, Offset: 0x2e8
// Size: 0x50
function function_7f19d11dbf8f7c20()
{
    function_789e1bb0f071af10();
    bot_waittill_bots_enabled();
    succeeded = function_770d1881c6adb8d0( [ "_allies", "_axis" ] );
    
    if ( succeeded )
    {
        level.protect_radius = 1200;
        level.bot_gametype_precaching_done = 1;
    }
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 0
// Checksum 0x0, Offset: 0x340
// Size: 0x35e
function bot_rugby_think()
{
    self notify( "bot_rugby_think" );
    self endon( "bot_rugby_think" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    /#
        setdevdvarifuninitialized( @"hash_54b3dbf61a166e11", 0 );
        level thread function_a3f84b78c1204ba5();
    #/
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    function_9ec0e59b27b57a40();
    self botsetflag( "separation", 0 );
    self botsetflag( "grenade_objectives", 1 );
    self botsetflag( "use_obj_path_style", 1 );
    self.next_time_hunt_carrier = gettime();
    
    if ( !isdefined( level.next_game_update_time ) )
    {
        level.next_game_update_time = gettime() + 100;
    }
    
    for ( ;; )
    {
        wait 0.05;
        
        if ( gettime() >= level.next_game_update_time )
        {
            level.next_game_update_time = gettime() + 100;
        }
        
        if ( self.health <= 0 )
        {
            continue;
        }
        
        if ( !isdefined( level.rugbyjugg ) )
        {
            if ( bot_has_tactical_goal( "seek_rugby_jugg", undefined ) == 0 )
            {
                action_thread = &function_8830ce4efdc64403;
                extra_params = spawnstruct();
                extra_params.object = level.rugby.activejuggcrates[ 0 ];
                extra_params.script_goal_radius = 16;
                extra_params.should_abort = level.bot_funcs[ "jugg_picked_up_cancel" ];
                extra_params.action_thread = action_thread;
                var_4b1ced49f4dc2afb = getclosestpointonnavmesh( level.rugby.activejuggcrates[ 0 ].origin, self );
                bot_new_tactical_goal( "seek_rugby_jugg", var_4b1ced49f4dc2afb, 99, extra_params );
            }
            
            continue;
        }
        
        if ( self == level.rugbyjugg )
        {
            if ( istrue( game[ "switchedsides" ] ) )
            {
                endzone = level.rugby.endzones[ self.team ][ 0 ];
            }
            else
            {
                endzone = level.rugby.endzones[ get_enemy_team( self.team ) ][ 0 ];
            }
            
            var_735fd56db96f509c = function_451fe89fc8f4f1b1( endzone.trigger );
            self botsetscriptgoal( var_735fd56db96f509c.origin, 0, "critical", var_735fd56db96f509c.angles[ 1 ] );
            pathresult = bot_waittill_goal_or_fail();
            continue;
        }
        
        if ( level.rugbyjugg.team == self.team )
        {
            if ( !bot_is_defending() )
            {
                bot_guard_player( level.rugbyjugg, 400 );
            }
            
            continue;
        }
        
        if ( gettime() > self.next_time_hunt_carrier || sighttracepassed( self.origin + ( 0, 0, 77 ), level.rugbyjugg.origin + ( 0, 0, 77 ), 0, self ) )
        {
            self botsetscriptgoal( level.rugbyjugg.origin, 16, "hunt" );
            self.next_time_hunt_carrier = gettime() + randomintrange( 4500, 5500 );
        }
    }
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 1
// Checksum 0x0, Offset: 0x6a6
// Size: 0x4f
function function_451fe89fc8f4f1b1( trigger )
{
    if ( trigger.bottargets.size >= 2 )
    {
        var_82d7851272ca820d = array_randomize( trigger.bottargets );
        return var_82d7851272ca820d[ 0 ];
    }
    
    return trigger.bottargets[ 0 ];
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 1
// Checksum 0x0, Offset: 0x6fd
// Size: 0x1c, Type: bool
function function_e1792f85cfa1c508( goal )
{
    if ( isdefined( level.rugbyjugg ) )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 1
// Checksum 0x0, Offset: 0x722
// Size: 0x43
function function_8830ce4efdc64403( goal )
{
    succeeded = function_7ba961e259d98d3d( scripts\mp\gametypes\rugby::function_cca61180d8fdf0ea() + 2, "jugg_captured", randomint( 100 ) > 50 );
    self botclearscriptgoal();
    
    if ( succeeded )
    {
    }
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 4
// Checksum 0x0, Offset: 0x76d
// Size: 0xe7
function function_7ba961e259d98d3d( time, var_206bf0ac411b2257, var_5b45d81d67839650, dont_prone )
{
    var_8e7073e75873765a = 0;
    
    if ( self botgetdifficultysetting( "strategyLevel" ) == 1 )
    {
        var_8e7073e75873765a = 40;
    }
    else if ( self botgetdifficultysetting( "strategyLevel" ) >= 2 )
    {
        var_8e7073e75873765a = 80;
    }
    
    if ( randomint( 100 ) < var_8e7073e75873765a && !( isdefined( dont_prone ) && dont_prone ) )
    {
        self botsetstance( "prone" );
        wait 0.2;
    }
    
    if ( self botgetdifficultysetting( "strategyLevel" ) > 0 && !var_5b45d81d67839650 )
    {
    }
    
    self botpressbutton( "use", time );
    result = bot_usebutton_wait( time, var_206bf0ac411b2257, "use_interrupted" );
    self botsetstance( "none" );
    self botclearbutton( "use" );
    succeeded = result == var_206bf0ac411b2257;
    return succeeded;
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 1
// Checksum 0x0, Offset: 0x85d
// Size: 0x5d
function waittill_usebutton_released_or_time_or_bomb_planted( time )
{
    time_started = gettime();
    var_f36002d69d048db6 = time_started + time * 1000;
    wait 0.05;
    
    while ( self usebuttonpressed() && gettime() < var_f36002d69d048db6 && level.bombplanted )
    {
        wait 0.05;
    }
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 0
// Checksum 0x0, Offset: 0x8c2
// Size: 0x8
function is_defending_bombzone()
{
    return bot_is_protecting();
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 0
// Checksum 0x0, Offset: 0x8d3
// Size: 0x28
function function_9ec0e59b27b57a40()
{
    if ( isdefined( level.bots_gametype_initialized ) && level.bots_gametype_initialized )
    {
        return;
    }
    
    level.bots_gametype_initialized = 1;
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 0
// Checksum 0x0, Offset: 0x903
// Size: 0x6b
function function_789e1bb0f071af10()
{
    wait 1;
    function_9b8b9e0f9b6897e3( level.rugby.endzones[ "allies" ][ 0 ].trigger );
    function_9b8b9e0f9b6897e3( level.rugby.endzones[ "axis" ][ 0 ].trigger );
    level.bot_set_objective_bottargets = 1;
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 1
// Checksum 0x0, Offset: 0x976
// Size: 0x2d
function function_9b8b9e0f9b6897e3( element )
{
    if ( !isdefined( element.bottargets ) )
    {
        element.bottargets = bot_get_valid_nodes_in_trigger( element );
    }
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 0
// Checksum 0x0, Offset: 0x9ab
// Size: 0x333
function function_ca798b60536c6b13()
{
    if ( !level.bombplanted )
    {
        if ( isdefined( level.team_planted_bomb ) )
        {
            level.team_planted_bomb = undefined;
            level.bomb_carrier = undefined;
        }
        
        prev_carrier = level.bomb_carrier;
        level.bomb_carrier = undefined;
        
        foreach ( player in level.participants )
        {
            if ( isalive( player ) && player.isbombcarrier )
            {
                level.bomb_carrier = player;
            }
        }
        
        var_af5fb37a7fbc388 = 0;
        
        if ( !isdefined( prev_carrier ) && isdefined( level.bomb_carrier ) )
        {
            assert( isteamparticipant( level.bomb_carrier ) );
            var_af5fb37a7fbc388 = 1;
            
            if ( isai( level.bomb_carrier ) )
            {
                level.bomb_carrier thread bomber_think();
            }
        }
        else if ( isdefined( prev_carrier ) && !isdefined( level.bomb_carrier ) )
        {
            var_af5fb37a7fbc388 = 1;
        }
        
        if ( var_af5fb37a7fbc388 )
        {
            foreach ( player in level.participants )
            {
                if ( isaiteamparticipant( player ) )
                {
                    player bot_defend_stop();
                }
            }
        }
        
        return;
    }
    
    if ( isdefined( level.bombowner ) && !isdefined( level.team_planted_bomb ) )
    {
        level.team_planted_bomb = level.bombowner.team;
        level.last_time_calc_defuser = gettime();
    }
    
    if ( !isdefined( level.bomb_defuser ) || !isalive( level.bomb_defuser ) || gettime() > level.last_time_calc_defuser + 1000 )
    {
        defusers = [];
        
        foreach ( player in level.participants )
        {
            if ( isalive( player ) && isaiteamparticipant( player ) && player.team != level.team_planted_bomb )
            {
                defusers[ defusers.size ] = player;
            }
        }
        
        if ( defusers.size > 0 )
        {
            bombzone = level.objectives[ get_enemy_team( level.team_planted_bomb ) ];
            var_8518445c76f3e0b8 = get_array_of_closest( bombzone.curorigin, defusers );
            
            if ( !isdefined( level.bomb_defuser ) || level.bomb_defuser != var_8518445c76f3e0b8[ 0 ] )
            {
                prev_defuser = level.bomb_defuser;
                level.bomb_defuser = var_8518445c76f3e0b8[ 0 ];
                level.bomb_defuser bot_defend_stop();
                
                if ( isdefined( prev_defuser ) )
                {
                    prev_defuser notify( "no_longer_bomb_defuser" );
                }
            }
        }
    }
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 0
// Checksum 0x0, Offset: 0xce6
// Size: 0x1a8
function bomber_think()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    while ( !level.bombplanted && self.isbombcarrier )
    {
        followers = [];
        
        foreach ( player in level.participants )
        {
            if ( isalive( player ) && isaiteamparticipant( player ) && player.team == self.team && player bot_is_defending() )
            {
                followers[ followers.size ] = player;
            }
        }
        
        num_behind = 0;
        
        foreach ( follower in followers )
        {
            var_c267021f983a459b = distancesquared( self.origin, follower.origin );
            var_3a0de1e171a0895f = follower.bot_defending_radius * follower.bot_defending_radius;
            var_e7f967c527a728a7 = follower.bot_defending_radius * 2 * follower.bot_defending_radius * 2;
            
            if ( var_c267021f983a459b > var_3a0de1e171a0895f && var_c267021f983a459b < var_e7f967c527a728a7 )
            {
                num_behind++;
            }
        }
        
        self setmovespeedscale( 1 - 0.15 * num_behind );
        wait 1;
    }
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 1
// Checksum 0x0, Offset: 0xe96
// Size: 0x62, Type: bool
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
    
    if ( self.isbombcarrier )
    {
        return false;
    }
    
    if ( !bot_is_defending() && !bot_is_protecting() && !bot_is_bodyguarding() )
    {
        return true;
    }
    
    return false;
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 1
// Checksum 0x0, Offset: 0xf01
// Size: 0x140, Type: bool
function function_770d1881c6adb8d0( var_d36a7e987347e24d )
{
    var_99e49ced1b12ab57 = 0;
    
    foreach ( endzone in level.rugby.endzones )
    {
        /#
            wait_time = 1;
            
            if ( gettime() < 5000 )
            {
                wait_time = max( 1, 5 - gettime() / 1000 );
            }
            
            if ( !isdefined( endzone[ 0 ].trigger ) )
            {
                wait wait_time;
                return false;
            }
            
            if ( endzone[ 0 ].trigger.bottargets.size < 3 )
            {
                wait wait_time;
                assertmsg( "<dev string:x1c>" + "<dev string:x29>" + endzone[ 0 ].trigger.origin + "<dev string:x3b>" );
                
                if ( endzone[ 0 ].trigger.bottargets.size < 1 )
                {
                    var_99e49ced1b12ab57 = 1;
                }
            }
        #/
    }
    
    if ( !var_99e49ced1b12ab57 )
    {
        function_19b1cd86e58e30ce();
    }
    
    return !var_99e49ced1b12ab57;
}

// Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
// Params 0
// Checksum 0x0, Offset: 0x104a
// Size: 0xee
function function_19b1cd86e58e30ce()
{
    assert( isdefined( level.rugby.endzones ) );
    entrance_origin_points = [];
    var_31ac0f14318b785f = [];
    index = 0;
    
    foreach ( endzone in level.rugby.endzones )
    {
        entrance_origin_points[ index ] = random( endzone[ 0 ].trigger.bottargets ).origin;
        var_31ac0f14318b785f[ index ] = "zone" + endzone[ 0 ].trigger.objectivekey;
        index++;
    }
    
    bot_cache_entrances( entrance_origin_points, var_31ac0f14318b785f );
}

/#

    // Namespace bots_gametype_rugby / scripts\mp\bots\bots_gametype_rugby
    // Params 0
    // Checksum 0x0, Offset: 0x1140
    // Size: 0x4c, Type: dev
    function function_a3f84b78c1204ba5()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_f66db1fdabed015d", 0 ) == 1 )
            {
                setdevdvar( @"hash_54b3dbf61a166e11", 0 );
                self botpressbutton( "<dev string:x6f>", 11 );
                wait 0.05;
            }
            
            wait 0.05;
        }
    }

#/
