#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\hud_util;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;

#namespace namespace_36cfc486ea2fec3b;

// Namespace namespace_36cfc486ea2fec3b / namespace_d564b97030b0868
// Params 0
// Checksum 0x0, Offset: 0x345
// Size: 0x72
function init()
{
    if ( !scripts\cp_mp\utility\game_utility::IsMagellanMode() )
    {
        return;
    }
    
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_server_exit_level", &function_69ddf7a3e512a18a );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_on_player_disconnect", &on_player_disconnect );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_on_player_spawned", &on_player_spawned );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_update_weapon_stats", &update_weapon_stats );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_prematch_over", &function_37f53cf222f43271 );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_on_bot_set_difficulty", &on_bot_set_difficulty );
}

// Namespace namespace_36cfc486ea2fec3b / namespace_d564b97030b0868
// Params 0
// Checksum 0x0, Offset: 0x3bf
// Size: 0x72
function function_69ddf7a3e512a18a()
{
    foreach ( player in level.players )
    {
        data = spawnstruct();
        data.player = player;
        function_ce976ee0200475a2( data );
    }
}

// Namespace namespace_36cfc486ea2fec3b / namespace_d564b97030b0868
// Params 1
// Checksum 0x0, Offset: 0x439
// Size: 0x1d3
function function_ce976ee0200475a2( data )
{
    player = data.player;
    
    if ( !isdefined( player.pers[ "telemetry" ].var_c804fa67733b8ef5 ) )
    {
        if ( !scripts\common\telemetry_utils::is_valid_client( player ) )
        {
            return;
        }
        
        if ( istrue( player.var_6a91d0e80cc504e ) && !istrue( level.gameended ) )
        {
            return;
        }
        
        place = -1;
        survival_time = 0;
        
        if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
        {
            if ( isdefined( player.pers[ "br_place" ] ) )
            {
                place = player.pers[ "br_place" ];
            }
            
            if ( !isdefined( player.pers[ "br_survival_time" ] ) && isdefined( level.starttime ) )
            {
                gameendtime = level.gameendtime;
                
                if ( !isdefined( gameendtime ) )
                {
                    gameendtime = gettime();
                }
                
                player.pers[ "br_survival_time" ] = gameendtime - level.starttime;
                survival_time = player.pers[ "br_survival_time" ];
            }
        }
        
        bot_difficulty = "";
        bot_mind_personality = "";
        
        if ( isbot( player ) )
        {
            bot_difficulty = player botgetdifficulty();
            
            if ( isdefined( player.mind_personality ) )
            {
                bot_mind_personality = player.mind_personality;
            }
        }
        
        player dlog_recordplayerevent( "dlog_event_mobile_player_match_end", [ "place", place, "survival_time", survival_time, "bot_difficulty", bot_difficulty, "bot_mind_personality", bot_mind_personality ] );
        player.pers[ "telemetry" ].var_c804fa67733b8ef5 = 1;
    }
}

// Namespace namespace_36cfc486ea2fec3b / namespace_d564b97030b0868
// Params 1
// Checksum 0x0, Offset: 0x614
// Size: 0x29
function on_player_disconnect( data )
{
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        function_6b12cc412aa6ea91( data );
    }
    
    function_ce976ee0200475a2( data );
}

// Namespace namespace_36cfc486ea2fec3b / namespace_d564b97030b0868
// Params 1
// Checksum 0x0, Offset: 0x645
// Size: 0x90
function on_player_spawned( player )
{
    if ( !scripts\common\telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        prematch = player.pers[ "telemetry" ].prematch;
        
        if ( !isdefined( prematch ) )
        {
            prematch = spawnstruct();
            player.pers[ "telemetry" ].prematch = prematch;
            prematch.spawns = 0;
            return;
        }
        
        prematch.spawns++;
    }
}

// Namespace namespace_36cfc486ea2fec3b / namespace_d564b97030b0868
// Params 0
// Checksum 0x0, Offset: 0x6dd
// Size: 0x94
function function_37f53cf222f43271()
{
    if ( istrue( getdvarint( @"hash_b46c28f676772bd2", 0 ) ) || istrue( level.skipprematch ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        data = spawnstruct();
        data.player = player;
        function_6b12cc412aa6ea91( data );
    }
}

// Namespace namespace_36cfc486ea2fec3b / namespace_d564b97030b0868
// Params 1
// Checksum 0x0, Offset: 0x779
// Size: 0x51
function on_bot_set_difficulty( data )
{
    bot = data.bot;
    
    if ( !isbot( bot ) )
    {
        return;
    }
    
    bot dlog_recordplayerevent( "dlog_event_mobile_bot_set_difficulty", [ "difficulty", data.difficulty ] );
}

// Namespace namespace_36cfc486ea2fec3b / namespace_d564b97030b0868
// Params 1
// Checksum 0x0, Offset: 0x7d2
// Size: 0x15c
function function_522ebd007aa28658( data )
{
    prematch = self.pers[ "telemetry" ].prematch;
    
    if ( !isdefined( prematch ) )
    {
        return;
    }
    
    if ( data.statname == "shots" )
    {
        if ( !isdefined( prematch.shots ) )
        {
            prematch.shots = data.incvalue;
        }
        else
        {
            prematch.shots += data.incvalue;
        }
        
        return;
    }
    
    if ( data.statname == "hits" )
    {
        if ( !isdefined( prematch.hits ) )
        {
            prematch.hits = data.incvalue;
        }
        else
        {
            prematch.hits += data.incvalue;
        }
        
        return;
    }
    
    if ( data.statname == "kills" )
    {
        if ( !isdefined( prematch.kills ) )
        {
            prematch.kills = data.incvalue;
            return;
        }
        
        prematch.kills += data.incvalue;
    }
}

// Namespace namespace_36cfc486ea2fec3b / namespace_d564b97030b0868
// Params 1
// Checksum 0x0, Offset: 0x936
// Size: 0x30
function update_weapon_stats( data )
{
    currenttime = scripts\common\telemetry_utils::function_1b15450e092933cf( gettime() );
    
    if ( currenttime <= 0 )
    {
        function_522ebd007aa28658( data );
    }
}

// Namespace namespace_36cfc486ea2fec3b / namespace_d564b97030b0868
// Params 1
// Checksum 0x0, Offset: 0x96e
// Size: 0x2f2
function function_6b12cc412aa6ea91( data )
{
    player = data.player;
    
    if ( !isdefined( player.pers[ "telemetry" ].var_c0e398db99db74ed ) )
    {
        if ( !scripts\common\telemetry_utils::is_valid_client( player ) )
        {
            return;
        }
        
        if ( istrue( player.var_6a91d0e80cc504e ) )
        {
            return;
        }
        
        prematch = player.pers[ "telemetry" ].prematch;
        
        if ( !isdefined( prematch ) )
        {
            return;
        }
        
        utc_connect_time = 0;
        
        if ( isdefined( player.pers[ "telemetry" ].utc_connect_time_s ) )
        {
            utc_connect_time = player.pers[ "telemetry" ].utc_connect_time_s;
        }
        
        spawns = default_to( prematch.spawns, 0 );
        hits = player.trackingweaponhits;
        
        if ( isdefined( prematch.hits ) )
        {
            hits += prematch.hits;
        }
        
        shots = default_to( player.trackingweaponshots, 0 );
        
        if ( isdefined( prematch.shots ) )
        {
            shots += prematch.shots;
        }
        
        kills = default_to( player.trackingweaponkills, 0 );
        
        if ( isdefined( prematch.kills ) )
        {
            kills += prematch.kills;
        }
        
        distancetotal = default_to( player.pers[ "distanceTotal" ], 0 );
        var_b92c01f350d85fe3 = 0;
        
        if ( isdefined( player.pers[ "movementUpdateCount" ] ) && player.pers[ "movementUpdateCount" ] >= 30 )
        {
            var_b92c01f350d85fe3 = player.pers[ "distanceTotal" ] / player.pers[ "movementUpdateCount" ];
        }
        
        currentweapon = player getcurrentweapon();
        weaponname = currentweapon.basename;
        player dlog_recordplayerevent( "dlog_event_mobile_prematch_end", [ "spawns", spawns, "kills", kills, "distance_moved", distancetotal, "speed", var_b92c01f350d85fe3, "shots", shots, "hits", hits, "last_weapon_at_hand", weaponname, "connect_time", utc_connect_time, "disconnect_time", getsystemtime() ] );
        player.pers[ "telemetry" ].var_c0e398db99db74ed = 1;
    }
}

