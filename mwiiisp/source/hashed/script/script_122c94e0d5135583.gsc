#using scripts\common\progression_utility;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_weaponrank;
#using scripts\cp\persistence;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\telemetry_utils;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;

#namespace namespace_3a53de8007388aea;

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 0
// Checksum 0x0, Offset: 0xdbd
// Size: 0x112
function init()
{
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_match_start", &function_393baf20db478c0d );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_match_end", &function_f5f91665fe4dba94 );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_server_exit_level", &function_69ddf7a3e512a18a );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_on_player_first_connect", &on_player_connect );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_on_player_spawned", &on_player_spawned );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_on_player_disconnect", &on_player_disconnect );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_player_death", &on_player_death );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_update_weapon_stats", &update_weapon_stats );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_player_score_event", &function_ac6b649326f4b17e );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_on_game_event", &on_game_event );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_on_player_award", &on_player_award );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_player_loadout_changed", &function_94bd96d6049d4686 );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_update_armor_ammo_stats", &update_armor_ammo_stats );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_open_tacmap", &function_43f5fb86aeac9344 );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_open_lootcrate", &function_97089deac1d05f63 );
    scripts\common\telemetry_utils::function_aacbbe63c26687ae( "callback_used_spotter", &function_ce380d5e29a6a5d4 );
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 0
// Checksum 0x0, Offset: 0xed7
// Size: 0x130
function function_393baf20db478c0d()
{
    if ( !isdefined( level.utc_start_time_s ) )
    {
        level.utc_start_time_s = 0;
    }
    
    level.utc_start_time_s = getsystemtime();
    playlist_id = 0;
    playlist_name = "private_match";
    
    if ( matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    frame_duration = getframeduration();
    onmatchbegin();
    
    if ( level.gametype == "dungeons" )
    {
        flag_wait( "player_spawned_pre_loadout" );
        playlist_name = level.player scripts\cp\cp_analytics::get_gameskill_as_string();
    }
    
    dlog_recordevent( "dlog_event_cp_server_match_start", [ "map", level.script, "game_type", getgametype(), "time_stamp", level.utc_start_time_s, "player_count", level.players.size, "playlist_id", int( playlist_id ), "playlist_name", playlist_name, "frame_duration", frame_duration ] );
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x100f
// Size: 0x217
function function_f5f91665fe4dba94( data )
{
    utc_start_time_s = 0;
    total_player_connections = 0;
    life_count = 0;
    game_event_count = 0;
    
    if ( isdefined( level.utc_start_time_s ) )
    {
        utc_start_time_s = level.utc_start_time_s;
    }
    
    if ( isdefined( game[ "telemetry" ].game_event_count ) )
    {
        game_event_count = game[ "telemetry" ].game_event_count;
    }
    
    if ( isdefined( game[ "telemetry" ].total_player_connections ) )
    {
        total_player_connections = game[ "telemetry" ].total_player_connections;
    }
    
    if ( isdefined( game[ "telemetry" ].life_count ) )
    {
        life_count = game[ "telemetry" ].life_count;
    }
    
    result_text = data.result;
    
    if ( result_text != "" )
    {
        if ( is_wave_gametype() )
        {
            result_text = "KIA";
        }
    }
    
    playlist_id = 0;
    playlist_name = "private_match";
    
    if ( matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    if ( level.gametype == "dungeons" )
    {
        playlist_name = level.player scripts\cp\cp_analytics::get_gameskill_as_string();
    }
    
    dlog_recordevent( "dlog_event_cp_server_match_end", [ "map", level.script, "game_type", getgametype(), "time_stamp", getsystemtime(), "result", result_text, "utc_start_time_s", utc_start_time_s, "player_count", level.players.size, "total_player_connections", total_player_connections, "life_count", life_count, "game_event_count", game_event_count, "playlist_id", int( playlist_id ), "playlist_name", playlist_name ] );
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x122e
// Size: 0x126
function on_player_connect( player )
{
    if ( !isdefined( player.pers[ "telemetry" ] ) || !isdefined( player.pers[ "telemetry" ].connected ) )
    {
        if ( !isdefined( player.pers[ "telemetry" ] ) )
        {
            player.pers[ "telemetry" ] = spawnstruct();
        }
        
        if ( isdefined( game[ "telemetry" ] ) && isdefined( game[ "telemetry" ].total_player_connections ) )
        {
            player.pers[ "telemetry" ].connect_index = game[ "telemetry" ].total_player_connections;
            game[ "telemetry" ].total_player_connections++;
        }
        else
        {
            println( "<dev string:x1c>" );
            return;
        }
    }
    
    player.pers[ "telemetry" ].utc_connect_time_s = getsystemtime();
    player.pers[ "telemetry" ].connected = 1;
    player function_97f88f577c57665f();
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 0
// Checksum 0x0, Offset: 0x135c
// Size: 0x23a
function function_97f88f577c57665f()
{
    if ( rankingenabled() )
    {
        start_xp = self getplayerdata( "cp", "progression", "playerLevel", "xp" );
        start_time_played_total = self getplayerdata( "cp", "coopCareerStats", "totalGameplayTime" );
        start_prestige = self getplayerdata( "cp", "progression", "playerLevel", "prestige" );
    }
    else
    {
        start_xp = 0;
        start_time_played_total = 0;
        start_prestige = 0;
    }
    
    self.pers[ "utc_connect_time_s" ] = getsystemtime();
    connect_index = self.pers[ "telemetry" ].connect_index;
    playlist_id = 0;
    playlist_name = "private_match";
    
    if ( matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    if ( level.gametype == "dungeons" )
    {
        playlist_name = scripts\cp\cp_analytics::get_gameskill_as_string();
    }
    
    self dlog_recordplayerevent( "dlog_event_cp_player_match_start", [ "utc_connect_time_s", self.pers[ "utc_connect_time_s" ], "team", self.sessionteam, "join_type", self getjointype(), "skill", self getskill(), "start_xp", start_xp, "start_time_played_total", start_time_played_total, "start_prestige", start_prestige, "connect_index", connect_index, "player_count", level.players.size, "party_id", self getpartyid(), "playlist_id", int( playlist_id ), "playlist_name", playlist_name ] );
    self.pers[ "telemetry" ].var_72c4294a35f33731 = undefined;
    self.pers[ "telemetry" ].var_c902b1aca6729094 = undefined;
    self.pers[ "telemetry" ].var_475783a3bcaa05f3 = undefined;
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x159e
// Size: 0x1d8
function on_player_spawned( player )
{
    if ( !scripts\common\telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.pers[ "telemetry" ] ) )
    {
        player.pers[ "telemetry" ] = spawnstruct();
    }
    
    if ( !isdefined( player.pers[ "telemetry" ].life ) )
    {
        player.pers[ "telemetry" ].life = spawnstruct();
    }
    
    if ( isdefined( game[ "telemetry" ] ) && isdefined( game[ "telemetry" ].life_count ) )
    {
        player.pers[ "telemetry" ].life.life_index = game[ "telemetry" ].life_count;
        game[ "telemetry" ].life_count++;
    }
    
    if ( isdefined( player.pers[ "summary" ][ "xp" ] ) )
    {
        player.pers[ "telemetry" ].life.var_2148fb703835ec1f = player.pers[ "summary" ][ "xp" ];
    }
    else
    {
        player.pers[ "telemetry" ].life.var_2148fb703835ec1f = 0;
    }
    
    if ( isdefined( player.score ) )
    {
        player.pers[ "telemetry" ].life.var_7e5250b5700df037 = player.score;
        return;
    }
    
    player.pers[ "telemetry" ].life.var_7e5250b5700df037 = 0;
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x177e
// Size: 0xaf
function function_94bd96d6049d4686( data )
{
    if ( !scripts\common\telemetry_utils::is_valid_client( data.player ) )
    {
        return;
    }
    
    data.player dlog_recordplayerevent( "dlog_event_cp_player_loadout", [ "primary_weapon_name", data.primaryweapon, "secondary_weapon_name", data.secondaryweapon, "lethal_name", data.lethalgrenade, "tactical_name", data.tactical, "field_upgrade_name", data.fieldupgrade ] );
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 0
// Checksum 0x0, Offset: 0x1835
// Size: 0x70
function function_69ddf7a3e512a18a()
{
    foreach ( player in level.players )
    {
        data = spawnstruct();
        data.player = player;
        function_6447f24addc0137e( data );
    }
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x18ad
// Size: 0x18d
function on_player_disconnect( data )
{
    function_6447f24addc0137e( data );
    var_a4772a08b422271f = -1;
    
    if ( scripts\common\telemetry_utils::function_4b974d822d418a06( data ) && isdefined( data.player.pers[ "telemetry" ].life.var_d8bae1f0e4d5e27e ) )
    {
        var_a4772a08b422271f = data.player.pers[ "telemetry" ].life.var_d8bae1f0e4d5e27e;
    }
    
    lifeindex = -1;
    
    if ( scripts\common\telemetry_utils::function_4b974d822d418a06( data ) && isdefined( data.player.pers[ "telemetry" ].life.life_index ) )
    {
        lifeindex = data.player.pers[ "telemetry" ].life.life_index;
    }
    
    if ( var_a4772a08b422271f != lifeindex )
    {
        lifedata = spawnstruct();
        lifedata.victim = data.player;
        lifedata.attacker = undefined;
        lifedata.weaponfullstring = "none";
        lifedata.meansofdeath = "";
        
        if ( isdefined( data.disconnectreason ) )
        {
            lifedata.meansofdeath = "MOD_DISCONNECTED";
        }
        
        on_player_death( lifedata );
    }
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x1a42
// Size: 0x7f6
function function_6447f24addc0137e( data )
{
    player = data.player;
    var_8f87c853b986d24a = "";
    
    if ( isdefined( data.disconnectreason ) && isstring( data.disconnectreason ) )
    {
        var_8f87c853b986d24a = data.disconnectreason;
    }
    
    if ( level.teambased )
    {
        var_8cc713ff16b24041 = int( player scripts\cp\rank::getteamrankxpmultiplier( player.team ) );
    }
    else
    {
        var_8cc713ff16b24041 = 0;
    }
    
    total_xp = 0;
    score_xp = 0;
    challenge_xp = 0;
    match_xp = 0;
    medal_xp = 0;
    bonus_xp = 0;
    misc_xp = 0;
    var_9e919a78b9496138 = player onlinestatsenabled();
    
    if ( player onlinestatsenabled() && !is_specops_gametype() )
    {
        if ( isdefined( player.pers[ "summary" ][ "xp" ] ) )
        {
            total_xp = player.pers[ "summary" ][ "xp" ];
        }
        
        if ( isdefined( player.pers[ "summary" ][ "score" ] ) )
        {
            score_xp = player.pers[ "summary" ][ "score" ];
        }
        
        if ( isdefined( player.pers[ "summary" ][ "challenge" ] ) )
        {
            challenge_xp = player.pers[ "summary" ][ "challenge" ];
        }
        
        if ( isdefined( player.pers[ "summary" ][ "match" ] ) )
        {
            match_xp = player.pers[ "summary" ][ "match" ];
        }
        
        if ( isdefined( player.pers[ "summary" ][ "medal" ] ) )
        {
            medal_xp = player.pers[ "summary" ][ "medal" ];
        }
        
        if ( isdefined( player.pers[ "summary" ][ "bonusXP" ] ) )
        {
            bonus_xp = player.pers[ "summary" ][ "bonusXP" ];
        }
        
        if ( isdefined( player.pers[ "summary" ][ "misc" ] ) )
        {
            misc_xp = player.pers[ "summary" ][ "misc" ];
        }
    }
    
    var_219ef42301aeaac8 = player getplayerdata( "cp", "progression", "playerLevel", "xp" );
    player scripts\cp\persistence::set_player_xp( total_xp + var_219ef42301aeaac8 );
    rankxp = player getrankxp();
    rank = player getrankforxp( rankxp );
    
    if ( player rankingenabled() && player hasplayerdata() )
    {
        end_xp = player getplayerdata( "cp", "progression", "playerLevel", "xp" );
        end_time_played_total = player getplayerdata( "cp", "coopCareerStats", "totalGameplayTime" );
        end_prestige = player getplayerdata( "common", "mpProgression", "playerLevel", "prestige" );
    }
    else
    {
        end_xp = 0;
        end_time_played_total = 0;
        end_prestige = 0;
    }
    
    average_speed_during_match = 0;
    percent_time_moving = 0;
    
    if ( isdefined( player.segments ) )
    {
        if ( isdefined( player.segments[ "movementUpdateCount" ] ) )
        {
            if ( player.segments[ "movementUpdateCount" ] >= 30 )
            {
                percent_time_moving = player.segments[ "movingTotal" ] / player.segments[ "movementUpdateCount" ] / 5 * 100;
                average_speed_during_match = player.segments[ "distanceTotal" ] / player.segments[ "movementUpdateCount" ];
            }
        }
    }
    
    var_7e01e835b5e9cb04 = 0;
    
    if ( isdefined( player.pers[ "utc_connect_time_s" ] ) )
    {
        var_7e01e835b5e9cb04 = player.pers[ "utc_connect_time_s" ];
    }
    
    if ( isdefined( player.pers[ "essence" ] ) )
    {
        essence = player.pers[ "essence" ];
    }
    else
    {
        essence = 0;
    }
    
    if ( isdefined( player.var_751641130e86b95f ) )
    {
        salvage = player.var_751641130e86b95f;
    }
    else
    {
        salvage = 0;
    }
    
    means_of_end = var_8f87c853b986d24a;
    
    if ( level.matchmakingmatch )
    {
        var_196eccb3049e0c6a = "public";
    }
    else if ( level.onlinegame )
    {
        var_196eccb3049e0c6a = "private";
    }
    else
    {
        var_196eccb3049e0c6a = "solo";
    }
    
    objective_type_on_death = scripts\common\telemetry_utils::get_objective_type();
    connect_index = player.pers[ "telemetry" ].connect_index;
    connected_time_s = getsystemtime() - var_7e01e835b5e9cb04;
    playlist_id = 0;
    playlist_name = "private_match";
    
    if ( matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    if ( level.gametype == "dungeons" )
    {
        playlist_name = player scripts\cp\cp_analytics::get_gameskill_as_string();
    }
    
    result_text = default_to( data.result, "" );
    player dlog_recordplayerevent( "dlog_event_cp_player_match_end", [ "utc_connect_time_s", var_7e01e835b5e9cb04, "utc_disconnect_time_s", getsystemtime(), "player_xp_modifier", int( player scripts\cp\rank::getrankxpmultiplier() ), "team_xp_modifier", var_8cc713ff16b24041, "weapon_xp_modifier", int( player scripts\cp\cp_weaponrank::getweaponrankxpmultiplier() ), "total_xp", total_xp, "score_xp", score_xp, "challenge_xp", challenge_xp, "match_xp", match_xp, "medal_xp", medal_xp, "bonus_xp", bonus_xp, "misc_xp", misc_xp, "rank", rank, "end_xp", end_xp, "end_time_played_total", end_time_played_total, "end_prestige", end_prestige, "disconnect_reason", var_8f87c853b986d24a, "average_speed_during_match", average_speed_during_match, "percent_time_moving", percent_time_moving, "result", result_text, "connected_time_s", connected_time_s, "essence", essence, "salvage", salvage, "means_of_end", means_of_end, "match_type", var_196eccb3049e0c6a, "objective_type_on_death", objective_type_on_death, "map", level.script, "active_objective", scripts\common\telemetry_utils::get_objective_type(), "player_count", level.players.size, "round", scripts\cp\utility::function_f0d6acf93c15bd59(), "connect_index", connect_index, "party_id", player getpartyid(), "playlist_id", int( playlist_id ), "playlist_name", playlist_name ] );
    function_8076b5556f48a6cd( player );
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x2240
// Size: 0xc21
function on_player_death( data )
{
    attacker = data.attacker;
    victim = data.victim;
    weapon_string = data.weaponfullstring;
    
    if ( !scripts\common\telemetry_utils::is_valid_client( victim ) )
    {
        return;
    }
    
    means_of_death = "";
    
    if ( isdefined( data.meansofdeath ) )
    {
        means_of_death = data.meansofdeath;
    }
    
    if ( weapon_string == "agent_cp" )
    {
        attacker_weapon_attachments = [];
    }
    else
    {
        var_ba6f272fe15ef31b = getweaponattachments( weapon_string );
        attacker_weapon_attachments = scripts\cp\weapon::attachmentsfilterforstats( var_ba6f272fe15ef31b, weapon_string );
    }
    
    spawntime = 0;
    
    if ( isdefined( victim.spawntime ) )
    {
        spawntime = victim.spawntime;
    }
    
    spawn_time_from_match_start_ms = scripts\common\telemetry_utils::function_1b15450e092933cf( spawntime );
    death_time_from_match_start_ms = scripts\common\telemetry_utils::function_1b15450e092933cf( gettime() );
    life_index = -1;
    
    if ( isdefined( victim.pers[ "telemetry" ].life.life_index ) )
    {
        life_index = victim.pers[ "telemetry" ].life.life_index;
    }
    
    attacker_life_index = -1;
    attacker_loadout_index = -1;
    attacker_death_modifiers = [];
    
    if ( scripts\common\telemetry_utils::is_valid_client( attacker ) || function_f639982ff796a722( attacker ) )
    {
        attacker_weapon = getweaponbasename( weapon_string );
        
        if ( scripts\common\telemetry_utils::is_valid_client( attacker ) )
        {
            var_41fb323b39c88db5 = attacker;
        }
        else
        {
            var_41fb323b39c88db5 = undefined;
        }
        
        attacker_weapon_picked_up = attacker scripts\cp\weapon::ispickedupweapon( weapon_string );
        attacker_weapon_alt_mode = attacker isalternatemode( weapon_string );
        attacker_ads_value = 0;
        
        if ( scripts\cp\weapon::iscacprimaryweapon( weapon_string ) || scripts\cp\weapon::iscacsecondaryweapon( weapon_string ) )
        {
            attacker_ads_value = attacker playerads();
        }
        
        attacker_was_in_victim_fov = within_fov( victim.origin, victim.angles, attacker.origin, 0.4226 );
        victim_was_in_attacker_fov = within_fov( attacker.origin, attacker.angles, victim.origin, 0.4226 );
        attacker_mount_type = attacker scripts\common\telemetry_utils::function_50989a55805a440b();
        attacker_pos = attacker.origin;
        attacker_angles = attacker.angles;
        
        if ( isdefined( attacker.pers[ "telemetry" ] ) && isdefined( attacker.pers[ "telemetry" ].life.life_index ) )
        {
            attacker_life_index = attacker.pers[ "telemetry" ].life.life_index;
        }
        
        if ( isdefined( attacker.loadoutindex ) )
        {
            attacker_loadout_index = attacker.loadoutindex;
        }
        
        attacker_death_modifiers = attacker scripts\cp_mp\telemetry_utils::function_1c355f42faf7f4bb();
    }
    else
    {
        var_41fb323b39c88db5 = undefined;
        attacker_weapon = "";
        attacker_weapon_picked_up = 0;
        attacker_weapon_alt_mode = 0;
        attacker_ads_value = 0;
        attacker_was_in_victim_fov = 0;
        victim_was_in_attacker_fov = 0;
        attacker_mount_type = "MOUNT_NONE";
        attacker_pos = ( 0, 0, 0 );
        attacker_angles = ( 0, 0, 0 );
    }
    
    victim_death_modifiers = victim scripts\cp_mp\telemetry_utils::function_1c355f42faf7f4bb();
    victim_weapon_attachments = [];
    victim_weapon = "";
    
    if ( isdefined( victim.lastweaponused ) )
    {
        victimcurrentweapon = victim.lastweaponused;
        var_fb475ef768b518c0 = getweaponattachments( victimcurrentweapon );
        victim_weapon_attachments = scripts\cp\weapon::attachmentsfilterforstats( var_fb475ef768b518c0, victimcurrentweapon );
        victim_weapon = getweaponbasename( victimcurrentweapon );
        victim_weapon_picked_up = victim scripts\cp\weapon::ispickedupweapon( victimcurrentweapon );
        victim_weapon_alt_mode = victim isalternatemode( victimcurrentweapon, 0, 1 );
        victim_ads_value = victim playerads();
    }
    else
    {
        victim_weapon_picked_up = 0;
        victim_weapon_alt_mode = 0;
        victim_ads_value = 0;
    }
    
    victim_mount_type = victim scripts\common\telemetry_utils::function_50989a55805a440b();
    victim_loadout_index = -1;
    
    if ( isdefined( victim.loadoutindex ) )
    {
        victim_loadout_index = victim.loadoutindex;
    }
    
    xp_earned = 0;
    
    if ( isdefined( victim.pers[ "summary" ][ "xp" ] ) )
    {
        currentxp = victim.pers[ "summary" ][ "xp" ];
        xp_earned = currentxp - victim.pers[ "telemetry" ].life.var_2148fb703835ec1f;
    }
    
    score_earned = victim.score - victim.pers[ "telemetry" ].life.var_7e5250b5700df037;
    is_hipfire = 0;
    
    if ( isdefined( attacker ) && isdefined( attacker.modifiers ) )
    {
        is_hipfire = istrue( attacker.modifiers[ "hipfire" ] );
    }
    
    spawn_pos = ( 0, 0, 0 );
    
    if ( isdefined( victim.spawnpos ) )
    {
        spawn_pos = victim.spawnpos;
    }
    
    was_tactical_insertion = 0;
    
    if ( isdefined( victim.wasti ) )
    {
        was_tactical_insertion = victim.wasti;
    }
    
    spawn_evaluation_id = 0;
    
    if ( isdefined( victim.spawndata ) && isdefined( victim.spawndata.spawnpoint ) && isdefined( victim.spawndata.spawnpoint.evaluationid ) )
    {
        spawn_evaluation_id = victim.spawndata.spawnpoint.evaluationid;
    }
    
    attacker_shooting_mode = "1st";
    
    if ( isdefined( attacker ) && isdefined( attacker.pers ) && isdefined( attacker.pers[ "shootingMode" ] ) )
    {
        attacker_shooting_mode = attacker.pers[ "shootingMode" ];
    }
    
    victim_shooting_mode = "1st";
    
    if ( isdefined( victim.pers[ "shootingMode" ] ) )
    {
        victim_shooting_mode = victim.pers[ "shootingMode" ];
    }
    
    first_damage_delivered_time_ms = 0;
    
    if ( isdefined( victim.var_198b774c93c48891 ) )
    {
        first_damage_delivered_time_ms = scripts\common\telemetry_utils::function_1b15450e092933cf( victim.var_198b774c93c48891 );
    }
    
    first_damage_received_time_ms = 0;
    
    if ( isdefined( victim.var_9691e7d8cde294f2 ) )
    {
        first_damage_received_time_ms = scripts\common\telemetry_utils::function_1b15450e092933cf( victim.var_9691e7d8cde294f2 );
    }
    
    victim dlog_recordplayerevent( "dlog_event_cp_life", [ "attacker", var_41fb323b39c88db5, "spawn_time_from_match_start_ms", spawn_time_from_match_start_ms, "life_index", life_index, "spawn_evaluation_id", spawn_evaluation_id, "spawn_pos_x", spawn_pos[ 0 ], "spawn_pos_y", spawn_pos[ 1 ], "spawn_pos_z", spawn_pos[ 2 ], "team", victim.team, "is_host", victim ishost(), "was_tactical_insertion", was_tactical_insertion, "death_time_from_match_start_ms", death_time_from_match_start_ms, "victim_weapon", victim_weapon, "victim_weapon_attachments", victim_weapon_attachments, "attacker_weapon", attacker_weapon, "attacker_weapon_attachments", attacker_weapon_attachments, "victim_death_modifiers", victim_death_modifiers, "attacker_death_modifiers", attacker_death_modifiers, "death_pos_x", victim.origin[ 0 ], "death_pos_y", victim.origin[ 1 ], "death_pos_z", victim.origin[ 2 ], "death_angle_x", victim.angles[ 0 ], "death_angle_y", victim.angles[ 1 ], "death_angle_z", victim.angles[ 2 ], "attacker_pos_x", attacker_pos[ 0 ], "attacker_pos_y", attacker_pos[ 1 ], "attacker_pos_z", attacker_pos[ 2 ], "attacker_angle_x", attacker_angles[ 0 ], "attacker_angle_y", attacker_angles[ 1 ], "attacker_angle_z", attacker_angles[ 2 ], "means_of_death", means_of_death, "attacker_weapon_alt_mode", attacker_weapon_alt_mode, "attacker_weapon_picked_up", attacker_weapon_picked_up, "victim_weapon_alt_mode", victim_weapon_alt_mode, "victim_weapon_picked_up", victim_weapon_picked_up, "attacker_ads_value", attacker_ads_value, "victim_ads_value", victim_ads_value, "attacker_was_in_victim_fov", attacker_was_in_victim_fov, "victim_was_in_attacker_fov", victim_was_in_attacker_fov, "attacker_mount_type", attacker_mount_type, "victim_mount_type", victim_mount_type, "xp_earned", xp_earned, "score_earned", score_earned, "victim_loadout_index", victim_loadout_index, "attacker_life_index", attacker_life_index, "attacker_loadout_index", attacker_loadout_index, "victim_was_reloading", victim isreloading(), "victim_was_executing", victim isinexecutionattack(), "is_hipfire", is_hipfire, "attacker_shooting_mode", attacker_shooting_mode, "victim_shooting_mode", victim_shooting_mode, "first_damage_delivered_time_ms", first_damage_delivered_time_ms, "first_damage_received_time_ms", first_damage_received_time_ms, "map", level.mapname ] );
    victim.pers[ "telemetry" ].life.var_d8bae1f0e4d5e27e = life_index;
    
    if ( scripts\common\telemetry_utils::is_valid_client( attacker ) )
    {
        logtournamentdeath( victim getxuid(), attacker getxuid(), weapon_string, means_of_death == "MOD_HEAD_SHOT" );
        
        if ( isdefined( level.matchrecording_logevent ) )
        {
            time = gettime();
            [[ level.matchrecording_logevent ]]( victim.clientid, victim.team, "DEATH", victim.origin[ 0 ], victim.origin[ 1 ], time );
            
            if ( issubstr( tolower( means_of_death ), "bullet" ) && isdefined( weapon_string ) && !scripts\cp_mp\weapon::iskillstreakweapon( weapon_string ) )
            {
                [[ level.matchrecording_logevent ]]( attacker.clientid, attacker.team, "BULLET", attacker.origin[ 0 ], attacker.origin[ 1 ], time, undefined, victim.origin[ 0 ], victim.origin[ 1 ] );
            }
        }
    }
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x2e69
// Size: 0x305
function function_8076b5556f48a6cd( player )
{
    if ( !scripts\common\telemetry_utils::is_valid_client( player ) || scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        return;
    }
    
    if ( isbot( player ) || istestclient( player ) || isai( player ) )
    {
        return;
    }
    
    player_xp = player getplayerdata( "cploadouts", "squadMembers", "player_xp" );
    
    foreach ( datastruct in player.pers[ "weaponStats" ] )
    {
        startingweaponxp = 0;
        earnedxp = 0;
        deaths = 0;
        headshots = 0;
        hits = 0;
        kills = 0;
        shots = 0;
        damage = 0;
        
        if ( isenumvaluevalid( "common", "LoadoutWeapon", datastruct.weapon ) )
        {
            startingweaponxp = player getplayerdata( "cploadouts", "squadMembers", "weapon_xp", datastruct.weapon );
        }
        
        weapon_ammo = player getammocount( datastruct.weapon );
        
        foreach ( statname, value in datastruct.stats )
        {
            if ( statname == "xp_earned" )
            {
                earnedxp += value;
            }
            
            if ( statname == "deaths" )
            {
                deaths += value;
            }
            
            if ( statname == "headshots" )
            {
                headshots += value;
            }
            
            if ( statname == "hits" )
            {
                hits += value;
            }
            
            if ( statname == "kills" )
            {
                kills += value;
            }
            
            if ( statname == "shots" )
            {
                shots += value;
            }
            
            if ( statname == "damage" )
            {
                damage += value;
            }
        }
        
        player dlog_recordplayerevent( "dlog_event_cp_player_weapon_stats", [ "weapon", datastruct.weapon, "variant_id", datastruct.variantid, "loadout_index", datastruct.loadoutindex, "starting_weapon_xp", startingweaponxp, "xp_earned", earnedxp, "deaths", deaths, "headshots", headshots, "hits", hits, "kills", kills, "shots", shots, "damage", damage, "weapon_ammo", weapon_ammo ] );
    }
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x3176
// Size: 0x15d
function update_armor_ammo_stats( data )
{
    if ( scripts\cp_mp\weapon::iskillstreakweapon( data.weaponname ) || scripts\cp\weapon::isvehicleweapon( data.weaponname ) )
    {
        return;
    }
    
    if ( !scripts\common\telemetry_utils::is_valid_client( data.player ) )
    {
        return;
    }
    
    player = data.player;
    playerhealth = player.health;
    var_e64f5bff1f0b1632 = player getammocount( data.weaponobj );
    playerweapons = player getweaponslistprimaries();
    var_d16b9abf8492347c = 0;
    
    for ( i = 0; i < playerweapons.size ; i++ )
    {
        var_d16b9abf8492347c += player getammocount( playerweapons[ i ] );
    }
    
    var_c4492e40722ece57 = player scripts\cp_mp\armor::function_85e373bb15921966();
    cur_armor = player scripts\cp_mp\armor::function_ac266fc218266d08();
    player dlog_recordplayerevent( "dlog_event_cp_player_armor_ammo_stats", [ "weapon_name", data.weaponname, "player_ammo", var_e64f5bff1f0b1632, "player_armor", cur_armor, "player_health", playerhealth, "total_ammo", var_d16b9abf8492347c ] );
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x32db
// Size: 0x2e4
function update_weapon_stats( data )
{
    if ( scripts\cp_mp\weapon::iskillstreakweapon( data.weaponname ) || scripts\cp\weapon::isvehicleweapon( data.weaponname ) )
    {
        return;
    }
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        return;
    }
    
    key = data.weaponname;
    
    if ( isdefined( self.loadoutindex ) )
    {
        assertex( self.loadoutindex != -1, "Attempting to use invalid loadout index as key for weapon stats" );
        key = key + "+loadoutIndex" + self.loadoutindex;
    }
    else
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "weaponStats" ][ key ] ) )
    {
        self.pers[ "weaponStats" ][ key ] = spawnstruct();
        self.pers[ "weaponStats" ][ key ].stats = [];
        self.pers[ "weaponStats" ][ key ].weapon = data.weaponname;
        self.pers[ "weaponStats" ][ key ].loadoutindex = self.loadoutindex;
        
        if ( isdefined( data.variantid ) )
        {
            self.pers[ "weaponStats" ][ key ].variantid = data.variantid;
        }
        else
        {
            self.pers[ "weaponStats" ][ key ].variantid = -1;
        }
    }
    
    if ( !isdefined( self.pers[ "weaponStats" ][ key ].stats[ data.statname ] ) )
    {
        self.pers[ "weaponStats" ][ key ].stats[ data.statname ] = data.incvalue;
    }
    else
    {
        self.pers[ "weaponStats" ][ key ].stats[ data.statname ] = self.pers[ "weaponStats" ][ key ].stats[ data.statname ] + data.incvalue;
    }
    
    if ( data.statname == "shots" )
    {
        self.pers[ "telemetry" ].shots = self.pers[ "telemetry" ].shots + data.incvalue;
        return;
    }
    
    if ( data.statname == "hits" )
    {
        self.pers[ "telemetry" ].hits = self.pers[ "telemetry" ].hits + data.incvalue;
    }
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x35c7
// Size: 0xf2
function function_ac6b649326f4b17e( data )
{
    assertex( scripts\cp_mp\utility\game_utility::isgameparticipant( data.player ), "data.player is not a player: " + data.player.code_classname );
    player = data.player;
    
    if ( scripts\cp_mp\utility\game_utility::isgameparticipant( player ) == 0 )
    {
        return;
    }
    
    if ( !scripts\common\telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( isbot( player ) || istestclient( player ) || isai( player ) )
    {
        return;
    }
    
    timefrommatchstart = scripts\common\telemetry_utils::function_1b15450e092933cf( gettime() );
    scoreevent = data.scoreevent;
    
    if ( isxhash( scoreevent ) )
    {
        scoreevent = getxhashhexname( scoreevent );
    }
    
    self dlog_recordplayerevent( "dlog_event_cp_player_score_event", [ "time_from_match_start_ms", timefrommatchstart, "score_event", scoreevent ] );
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x36c1
// Size: 0x1ce
function on_game_event( data )
{
    eventplayer = undefined;
    lifeindex = -1;
    
    if ( isdefined( data.player ) && scripts\common\telemetry_utils::is_valid_client( data.player ) && scripts\cp_mp\utility\game_utility::isgameparticipant( data.player ) )
    {
        eventplayer = data.player;
        
        if ( isdefined( data.player.pers[ "telemetry" ].life.life_index ) )
        {
            lifeindex = data.player.pers[ "telemetry" ].life.life_index;
        }
    }
    
    timefrommatchstart = scripts\common\telemetry_utils::function_1b15450e092933cf( gettime() );
    position = [ 0, 0, 0 ];
    
    if ( isdefined( data.position ) )
    {
        position = data.position;
    }
    
    dlog_recordevent( "dlog_event_cp_game_event", [ "event_player", eventplayer, "event_name", data.eventname, "time_from_match_start_ms", timefrommatchstart, "player_life_index", lifeindex, "pos_x", position[ 0 ], "pos_y", position[ 1 ], "pos_z", position[ 2 ] ] );
    
    if ( isdefined( game[ "telemetry" ] ) && isdefined( game[ "telemetry" ].game_event_count ) )
    {
        game[ "telemetry" ].game_event_count++;
    }
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x3897
// Size: 0x9f
function on_player_award( data )
{
    player = data.player;
    awardname = data.awardname;
    
    if ( !scripts\common\telemetry_utils::is_valid_client( player ) )
    {
        return;
    }
    
    if ( isbot( player ) || istestclient( player ) || isai( player ) )
    {
        return;
    }
    
    time_ms = scripts\common\telemetry_utils::function_1b15450e092933cf( gettime() );
    player dlog_recordplayerevent( "dlog_event_cp_player_award", [ "time_ms_from_match_start", time_ms, "award", awardname ] );
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x393e
// Size: 0x2f, Type: bool
function function_f639982ff796a722( client )
{
    if ( istrue( game[ "isLaunchChunk" ] ) )
    {
        return false;
    }
    
    if ( !isdefined( client ) )
    {
        return false;
    }
    else if ( !isagent( client ) )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x3976
// Size: 0x14
function function_43f5fb86aeac9344( player )
{
    player thread scripts\cp\cp_analytics::update_focus_counter();
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x3992
// Size: 0x2d
function function_97089deac1d05f63( data )
{
    data.player scripts\cp\cp_analytics::function_1cb406a7e2755abd( "opened_lootcrate", data.item_name );
}

// Namespace namespace_3a53de8007388aea / namespace_a7430cfb7d293cf
// Params 1
// Checksum 0x0, Offset: 0x39c7
// Size: 0x43
function function_ce380d5e29a6a5d4( data )
{
    data.player scripts\cp\cp_analytics::function_1cb406a7e2755abd( "callback_used_spotter", data.enemiesmarked, data.var_a96aac2935b87d1, data.var_6709a01d1de361cf );
}

