#using script_2f382e6c1908fbd4;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\flags;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\perks\perks;
#using scripts\mp\rank;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;

#namespace hud_message;

// Namespace hud_message / scripts\mp\hud_message
// Params 0
// Checksum 0x0, Offset: 0xf94
// Size: 0xd2c
function init()
{
    game[ "round_end" ][ "draw" ] = 1;
    game[ "round_end" ][ "round_draw" ] = 2;
    game[ "round_end" ][ "round_win" ] = 3;
    game[ "round_end" ][ "round_loss" ] = 4;
    game[ "round_end" ][ "victory" ] = 5;
    game[ "round_end" ][ "defeat" ] = 6;
    game[ "round_end" ][ "halftime" ] = 7;
    game[ "round_end" ][ "overtime" ] = 8;
    game[ "round_end" ][ "roundend" ] = 9;
    game[ "round_end" ][ "intermission" ] = 10;
    game[ "round_end" ][ "side_switch" ] = 11;
    game[ "round_end" ][ "match_bonus" ] = 12;
    game[ "round_end" ][ "tie" ] = 13;
    game[ "round_end" ][ "spectator" ] = 14;
    game[ "round_end" ][ "final_round" ] = 15;
    game[ "round_end" ][ "match_point" ] = 16;
    game[ "round_end" ][ "practice_round" ] = 17;
    game[ "round_end" ][ "win_by_two" ] = 18;
    game[ "round_end" ][ "secondary_victory" ] = 19;
    game[ "end_reason" ][ "score_limit_reached" ] = 1;
    game[ "end_reason" ][ "time_limit_reached" ] = 2;
    game[ "end_reason" ][ "players_forfeited" ] = 3;
    game[ "end_reason" ][ "target_destroyed" ] = 4;
    game[ "end_reason" ][ "bomb_defused" ] = 5;
    game[ "end_reason" ][ "rusf_eliminated" ] = 6;
    game[ "end_reason" ][ "usmc_eliminated" ] = 7;
    game[ "end_reason" ][ "sas_eliminated" ] = 8;
    game[ "end_reason" ][ "zvir_eliminated" ] = 9;
    game[ "end_reason" ][ "icorps_eliminated" ] = 10;
    game[ "end_reason" ][ "grp9_eliminated" ] = 11;
    game[ "end_reason" ][ "spetsnaz_forfeited" ] = 12;
    game[ "end_reason" ][ "marines_forfeited" ] = 13;
    game[ "end_reason" ][ "sas_forfeited" ] = 14;
    game[ "end_reason" ][ "zvir_forfeited" ] = 15;
    game[ "end_reason" ][ "icorps_forfeited" ] = 16;
    game[ "end_reason" ][ "grp9_forfeited" ] = 17;
    game[ "end_reason" ][ "enemies_eliminated" ] = 18;
    game[ "end_reason" ][ "tie" ] = 19;
    game[ "end_reason" ][ "objective_completed" ] = 20;
    game[ "end_reason" ][ "objective_failed" ] = 21;
    game[ "end_reason" ][ "switching_sides" ] = 22;
    game[ "end_reason" ][ "round_limit_reached" ] = 23;
    game[ "end_reason" ][ "ended_game" ] = 24;
    game[ "end_reason" ][ "host_ended_game" ] = 25;
    game[ "end_reason" ][ "loss_stat_prevented" ] = 26;
    game[ "end_reason" ][ "time_to_beat_ctf_win" ] = 27;
    game[ "end_reason" ][ "time_to_beat_ctf_loss" ] = 28;
    game[ "end_reason" ][ "time_to_beat_uplink_win" ] = 29;
    game[ "end_reason" ][ "time_to_beat_uplink_loss" ] = 30;
    game[ "end_reason" ][ "nuke_end" ] = 31;
    game[ "end_reason" ][ "enemies_forfeited" ] = 32;
    game[ "end_reason" ][ "arena_time_health_win" ] = 33;
    game[ "end_reason" ][ "arena_time_health_loss" ] = 34;
    game[ "end_reason" ][ "arena_time_lives_win" ] = 35;
    game[ "end_reason" ][ "arena_time_lives_loss" ] = 36;
    game[ "end_reason" ][ "arena_otflag_completed" ] = 37;
    game[ "end_reason" ][ "arena_otflag_failed" ] = 38;
    game[ "end_reason" ][ "outpost_defended" ] = 39;
    game[ "end_reason" ][ "practice_round_over" ] = 40;
    game[ "end_reason" ][ "br_eliminated" ] = 41;
    game[ "end_reason" ][ "cyber_tie" ] = 42;
    game[ "end_reason" ][ "mercy_win" ] = 43;
    game[ "end_reason" ][ "mercy_loss" ] = 44;
    game[ "end_reason" ][ "blank" ] = 45;
    game[ "end_reason" ][ "mlg_time_to_beat_ctf" ] = 46;
    game[ "end_reason" ][ "mlg_time_to_beat_uplink" ] = 47;
    game[ "end_reason" ][ "mlg_time_lives" ] = 48;
    game[ "end_reason" ][ "mlg_time_health" ] = 49;
    game[ "end_reason" ][ "mlg_eliminated" ] = 50;
    game[ "end_reason" ][ "mlg_forfeited" ] = 51;
    game[ "end_reason" ][ "siege_allflags_win" ] = 52;
    game[ "end_reason" ][ "siege_allflags_loss" ] = 53;
    game[ "end_reason" ][ "siege_flag_win" ] = 54;
    game[ "end_reason" ][ "siege_flag_loss" ] = 55;
    game[ "end_reason" ][ "arena_tournament_tie_win" ] = 56;
    game[ "end_reason" ][ "arena_tournament_tie_loss" ] = 57;
    game[ "end_reason" ][ "plunder_loss" ] = 58;
    game[ "end_reason" ][ "plunder_win" ] = 59;
    game[ "end_reason" ][ "enemy_forfeit" ] = 60;
    game[ "end_reason" ][ "survivors_eliminated" ] = 61;
    game[ "end_reason" ][ "siege_force_end" ] = 62;
    game[ "end_reason" ][ "dom_force_end" ] = 63;
    game[ "end_reason" ][ "ko_flag_win" ] = 64;
    game[ "end_reason" ][ "ko_flag_loss" ] = 65;
    game[ "end_reason" ][ "ko_flag_hold_win" ] = 66;
    game[ "end_reason" ][ "ko_flag_hold_loss" ] = 67;
    game[ "end_reason" ][ "ko_alive_count_win" ] = 68;
    game[ "end_reason" ][ "ko_alive_count_loss" ] = 69;
    game[ "end_reason" ][ "ko_draw_award_point" ] = 70;
    game[ "end_reason" ][ "win_by_two_tie" ] = 71;
    game[ "end_reason" ][ "all_hostage_extracted" ] = 72;
    game[ "end_reason" ][ "mlg_otflag_captured" ] = 73;
    game[ "end_reason" ][ "mlg_tournament_tie" ] = 74;
    game[ "end_reason" ][ "team_defending_most_segments" ] = 75;
    game[ "end_reason" ][ "team_defending_most_kills" ] = 76;
    game[ "end_reason" ][ "team_defending" ] = 77;
    game[ "end_reason" ][ "control_allzones_win" ] = 78;
    game[ "end_reason" ][ "control_allzones_loss" ] = 79;
    game[ "end_reason" ][ "mlg_allzones_captured" ] = 80;
    game[ "end_reason" ][ "friendlies_eliminated" ] = 81;
    game[ "end_reason" ][ "lg_tiebreaker_zonesheld_win" ] = 82;
    game[ "end_reason" ][ "lg_tiebreaker_zonesheld_loss" ] = 83;
    game[ "end_reason" ][ "covert_exfil" ] = 84;
    game[ "end_reason" ][ "rangers_eliminated" ] = 85;
    game[ "end_reason" ][ "tf141_eliminated" ] = 86;
    game[ "end_reason" ][ "navy_eliminated" ] = 87;
    game[ "end_reason" ][ "opfor_eliminated" ] = 88;
    game[ "end_reason" ][ "sptnz_eliminated" ] = 89;
    game[ "end_reason" ][ "mili_eliminated" ] = 90;
    game[ "end_reason" ][ "rangers_forfeited" ] = 91;
    game[ "end_reason" ][ "tf141_forfeited" ] = 92;
    game[ "end_reason" ][ "navy_forfeited" ] = 93;
    game[ "end_reason" ][ "opfor_forfeited" ] = 94;
    game[ "end_reason" ][ "sptnz_forfeited" ] = 95;
    game[ "end_reason" ][ "mili_forfeited" ] = 96;
    game[ "end_reason" ][ "all_eliminated" ] = 97;
    game[ "round_end_exmsg" ][ "intermission" ] = 1;
    game[ "round_end_exmsg" ][ "switching_sides" ] = 2;
    game[ "round_end_exmsg" ][ "match_point" ] = 3;
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "time_to_beat_ctf_win" ] ] = game[ "end_reason" ][ "mlg_time_to_beat_ctf" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "time_to_beat_ctf_loss" ] ] = game[ "end_reason" ][ "mlg_time_to_beat_ctf" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "arena_time_health_win" ] ] = game[ "end_reason" ][ "mlg_time_health" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "arena_time_health_loss" ] ] = game[ "end_reason" ][ "mlg_time_health" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "time_to_beat_uplink_win" ] ] = game[ "end_reason" ][ "mlg_time_to_beat_uplink" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "time_to_beat_uplink_loss" ] ] = game[ "end_reason" ][ "mlg_time_to_beat_uplink" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "arena_time_lives_win" ] ] = game[ "end_reason" ][ "mlg_time_lives" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "arena_time_lives_loss" ] ] = game[ "end_reason" ][ "mlg_time_lives" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "rusf_eliminated" ] ] = game[ "end_reason" ][ "mlg_eliminated" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "usmc_eliminated" ] ] = game[ "end_reason" ][ "mlg_eliminated" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "sas_eliminated" ] ] = game[ "end_reason" ][ "mlg_eliminated" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "zvir_eliminated" ] ] = game[ "end_reason" ][ "mlg_eliminated" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "icorps_eliminated" ] ] = game[ "end_reason" ][ "mlg_eliminated" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "grp9_eliminated" ] ] = game[ "end_reason" ][ "mlg_eliminated" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "rangers_eliminated" ] ] = game[ "end_reason" ][ "mlg_eliminated" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "tf141_eliminated" ] ] = game[ "end_reason" ][ "mlg_eliminated" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "navy_eliminated" ] ] = game[ "end_reason" ][ "mlg_eliminated" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "opfor_eliminated" ] ] = game[ "end_reason" ][ "mlg_eliminated" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "sptnz_eliminated" ] ] = game[ "end_reason" ][ "mlg_eliminated" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "mili_eliminated" ] ] = game[ "end_reason" ][ "mlg_eliminated" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "spetsnaz_forfeited" ] ] = game[ "end_reason" ][ "mlg_forfeited" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "marines_forfeited" ] ] = game[ "end_reason" ][ "mlg_forfeited" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "sas_forfeited" ] ] = game[ "end_reason" ][ "mlg_forfeited" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "zvir_forfeited" ] ] = game[ "end_reason" ][ "mlg_forfeited" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "icorps_forfeited" ] ] = game[ "end_reason" ][ "mlg_forfeited" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "grp9_forfeited" ] ] = game[ "end_reason" ][ "mlg_forfeited" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "rangers_forfeited" ] ] = game[ "end_reason" ][ "mlg_forfeited" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "tf141_forfeited" ] ] = game[ "end_reason" ][ "mlg_forfeited" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "navy_forfeited" ] ] = game[ "end_reason" ][ "mlg_forfeited" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "opfor_forfeited" ] ] = game[ "end_reason" ][ "mlg_forfeited" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "sptnz_forfeited" ] ] = game[ "end_reason" ][ "mlg_forfeited" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "mili_forfeited" ] ] = game[ "end_reason" ][ "mlg_forfeited" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "enemies_eliminated" ] ] = game[ "end_reason" ][ "mlg_eliminated" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "enemies_forfeited" ] ] = game[ "end_reason" ][ "mlg_forfeited" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "arena_otflag_completed" ] ] = game[ "end_reason" ][ "mlg_otflag_captured" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "arena_otflag_failed" ] ] = game[ "end_reason" ][ "mlg_otflag_captured" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "arena_tournament_tie_win" ] ] = game[ "end_reason" ][ "mlg_tournament_tie" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "arena_tournament_tie_loss" ] ] = game[ "end_reason" ][ "mlg_tournament_tie" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "control_allzones_win" ] ] = game[ "end_reason" ][ "mlg_allzones_captured" ];
    game[ "end_reason_mlg_mapping" ][ game[ "end_reason" ][ "control_allzones_loss" ] ] = game[ "end_reason" ][ "mlg_allzones_captured" ];
    level.splashtablecache = [];
    level.var_4cd98c0c1064cfc0 = [];
    level.var_97cd5ee2098d8181 = -2;
    level thread onplayerconnect();
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &splashshowncallback );
    level.showerrormessagefunc = &showerrormessage;
}

// Namespace hud_message / scripts\mp\hud_message
// Params 0
// Checksum 0x0, Offset: 0x1cc8
// Size: 0x2b
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( "connected", player );
        player thread lowermessagethink();
        player thread eventsplashesthink();
    }
}

// Namespace hud_message / scripts\mp\hud_message
// Params 4
// Checksum 0x0, Offset: 0x1cfb
// Size: 0x70
function showkillstreaksplash( splashref, streakval, fromcarepackage, splashlistoverride )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    altdisplayindex = undefined;
    
    if ( istrue( fromcarepackage ) )
    {
        altdisplayindex = 1;
    }
    
    splashref = getspecialistsplashfromkillstreak( splashref );
    showsplash( splashref, streakval, undefined, altdisplayindex, undefined, splashlistoverride );
    
    if ( !scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924() )
    {
        scripts\cp_mp\utility\killstreak_utility::playkillstreakteamleaderdialog( splashref, getxhash( splashref ) );
    }
}

// Namespace hud_message / scripts\mp\hud_message
// Params 1
// Checksum 0x0, Offset: 0x1d73
// Size: 0x32
function getspecialistsplashfromkillstreak( splashref )
{
    var_fec8b7a457ed3a4f = splashref;
    specialistperk = scripts\mp\perks\perks::getspecialistperkforstreak( splashref );
    
    if ( isdefined( specialistperk ) )
    {
        var_fec8b7a457ed3a4f = specialistperk;
    }
    
    return var_fec8b7a457ed3a4f;
}

// Namespace hud_message / scripts\mp\hud_message
// Params 6
// Checksum 0x0, Offset: 0x1dae
// Size: 0xb1
function showsplashwithkillcheckhack( ref, optionalnumber, playerforplayercard, altdisplayindex, splashlistoverride, forceshow )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    waitframe();
    
    if ( isdefined( self.lastkilltime ) )
    {
        maxdelaytime = getdvarfloat( @"hash_1eb32d180bc7cff8", 0.5 ) * 1000;
        delaytime = int( max( maxdelaytime - gettime() - self.lastkilltime, 0 ) );
        wait delaytime / 1000;
    }
    
    showsplash( ref, optionalnumber, playerforplayercard, altdisplayindex, 1, splashlistoverride, forceshow );
}

// Namespace hud_message / scripts\mp\hud_message
// Params 2
// Checksum 0x0, Offset: 0x1e67
// Size: 0x20
function function_51614e8fce37b07f( ref, splashlistoverride )
{
    showsplash( ref, undefined, undefined, undefined, undefined, splashlistoverride );
}

// Namespace hud_message / scripts\mp\hud_message
// Params 7
// Checksum 0x0, Offset: 0x1e8f
// Size: 0x134
function showsplash( ref, optionalnumber, playerforplayercard, altdisplayindex, var_ef4849b4cb3ac7e2, splashlistoverride, forceshow )
{
    if ( function_4e3eb46838440959() && !istrue( forceshow ) )
    {
        return;
    }
    
    assert( isplayer( self ) );
    
    if ( !istrue( var_ef4849b4cb3ac7e2 ) )
    {
        thread showsplashwithkillcheckhack( ref, optionalnumber, playerforplayercard, altdisplayindex, splashlistoverride, forceshow );
        return;
    }
    
    playernumforplayercard = undefined;
    
    if ( isdefined( playerforplayercard ) )
    {
        playernumforplayercard = playerforplayercard getentitynumber();
    }
    
    if ( isdefined( self.recentsplashcount ) && self.recentsplashcount >= 6 )
    {
        queuesplash( ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, splashlistoverride );
        return;
    }
    
    var_44d582ed00c6eb0b = 0;
    
    if ( isdefined( level.gametypebundle ) )
    {
        var_44d582ed00c6eb0b = default_to( level.gametypebundle.var_651047db5ba78359, var_44d582ed00c6eb0b );
    }
    
    if ( !isreallyalive( self ) && isplayer( self ) && !self iscodcaster() && !var_44d582ed00c6eb0b )
    {
        queuesplash( ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, splashlistoverride );
        return;
    }
    
    showsplashinternal( ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, splashlistoverride );
}

// Namespace hud_message / scripts\mp\hud_message
// Params 6
// Checksum 0x0, Offset: 0x1fcb
// Size: 0x2d8
function showsplashinternal( ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, splashlistoverride )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( playernumforplayercard ) )
    {
        if ( !isdefined( playerforplayercard ) )
        {
            return;
        }
    }
    
    if ( getdvarint( @"hash_ef4f06e55f320347", 0 ) == 1 )
    {
        isscriptbundlesplash = 1;
        splashid = function_73baf095c3b9cce6( ref, splashlistoverride );
        
        if ( !isdefined( splashid ) || splashid < 0 )
        {
            isscriptbundlesplash = 0;
            splashid = getsplashid( ref );
        }
    }
    else
    {
        isscriptbundlesplash = 0;
        splashid = getsplashid( ref );
        
        if ( !isdefined( splashid ) || splashid < 0 )
        {
            splashid = function_73baf095c3b9cce6( ref, splashlistoverride );
            isscriptbundlesplash = 1;
        }
    }
    
    if ( !isdefined( splashid ) || splashid < 0 )
    {
        assertmsg( "<dev string:x1c>" + getxhashsourcename( ref ) + "<dev string:x45>" + getsplashtablename() + "<dev string:x64>" );
        return;
    }
    
    assertex( splashid < ( 2047 ^ 4095 ), "<dev string:x7e>" );
    
    if ( !isdefined( self.var_e04f5d9b477cb89f ) )
    {
        self.var_e04f5d9b477cb89f = 0;
    }
    
    if ( !isdefined( self.var_e983b466b2ec69d5 ) )
    {
        self.var_e983b466b2ec69d5 = 1;
    }
    
    omnvarvalue = splashid;
    
    if ( self.var_e983b466b2ec69d5 )
    {
        omnvarvalue |= 2047 ^ 4095;
    }
    
    if ( isdefined( optionalnumber ) )
    {
        if ( level.var_97cd5ee2098d8181 < optionalnumber )
        {
            level.var_97cd5ee2098d8181 = optionalnumber;
            
            /#
                println( "<dev string:xd5>" );
                println( "<dev string:xf7>" + level.var_97cd5ee2098d8181 );
            #/
        }
        
        self setclientomnvar( "ui_player_splash_param_" + self.var_e04f5d9b477cb89f, optionalnumber );
    }
    else
    {
        self setclientomnvar( "ui_player_splash_param_" + self.var_e04f5d9b477cb89f, -1 );
    }
    
    if ( isdefined( playernumforplayercard ) )
    {
        self setclientomnvar( "ui_player_splash_cardClientId_" + self.var_e04f5d9b477cb89f, playernumforplayercard );
    }
    else
    {
        self setclientomnvar( "ui_player_splash_cardClientId_" + self.var_e04f5d9b477cb89f, -1 );
    }
    
    if ( isdefined( altdisplayindex ) )
    {
        self setclientomnvar( "ui_player_splash_use_alt_" + self.var_e04f5d9b477cb89f, altdisplayindex );
    }
    else
    {
        self setclientomnvar( "ui_player_splash_use_alt_" + self.var_e04f5d9b477cb89f, 0 );
    }
    
    self setclientomnvar( "ui_player_splash_scriptBundle_" + self.var_e04f5d9b477cb89f, isscriptbundlesplash );
    self setclientomnvar( "ui_player_splash_id_" + self.var_e04f5d9b477cb89f, omnvarvalue );
    
    if ( !isdefined( self.recentsplashcount ) )
    {
        self.recentsplashcount = 1;
    }
    else
    {
        self.recentsplashcount++;
    }
    
    thread cleanuplocalplayersplashlist();
    self.var_e04f5d9b477cb89f++;
    
    if ( self.var_e04f5d9b477cb89f >= 6 )
    {
        self.var_e04f5d9b477cb89f = 0;
        self.var_e983b466b2ec69d5 = !self.var_e983b466b2ec69d5;
    }
}

// Namespace hud_message / scripts\mp\hud_message
// Params 6
// Checksum 0x0, Offset: 0x22ab
// Size: 0xea
function queuesplash( ref, optionalnumber, playerforplayercard, playernumforplayercard, altdisplayindex, splashlistoverride )
{
    struct = spawnstruct();
    struct.ref = ref;
    struct.optionalnumber = optionalnumber;
    struct.playerforplayercard = playerforplayercard;
    struct.playernumforplayercard = playernumforplayercard;
    struct.altdisplayindex = altdisplayindex;
    struct.splashlistoverride = splashlistoverride;
    
    if ( !isdefined( self.splashqueuehead ) )
    {
        self.splashqueuehead = struct;
        self.splashqueuetail = struct;
        thread handlesplashqueue();
        return;
    }
    
    oldtail = self.splashqueuetail;
    oldtail.nextsplash = struct;
    self.splashqueuetail = struct;
}

// Namespace hud_message / scripts\mp\hud_message
// Params 0
// Checksum 0x0, Offset: 0x239d
// Size: 0x149
function handlesplashqueue()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "clearSplashQueue" );
    
    while ( isdefined( self.splashqueuehead ) )
    {
        if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() && ( getsubgametype() == "dmz" || getsubgametype() == "exgm" || getsubgametype() == "plunder" || getsubgametype() == "risk" || getsubgametype() == "rumble_mgl" ) )
        {
            waittill_any_2( "splash_list_cleared", "can_show_splashes" );
        }
        else
        {
            waittill_any_2( "splash_list_cleared", "spawned_player" );
        }
        
        for ( queueindex = 0; queueindex < 6 ; queueindex++ )
        {
            struct = self.splashqueuehead;
            showsplashinternal( struct.ref, struct.optionalnumber, struct.playerforplayercard, struct.playernumforplayercard, struct.altdisplayindex, struct.splashlistoverride );
            self.splashqueuehead = struct.nextsplash;
            
            if ( !isdefined( self.splashqueuehead ) )
            {
                break;
            }
        }
    }
    
    self.splashqueuetail = undefined;
}

// Namespace hud_message / scripts\mp\hud_message
// Params 0
// Checksum 0x0, Offset: 0x24ee
// Size: 0x5e
function clearsplashqueue()
{
    self notify( "clearSplashQueue" );
    nextsplash = self.splashqueuehead;
    
    while ( isdefined( nextsplash ) )
    {
        currentsplash = nextsplash;
        nextsplash = currentsplash.nextsplash;
        currentsplash.nextsplash = undefined;
    }
    
    self.splashqueuehead = undefined;
    self.splashqueuetail = undefined;
}

// Namespace hud_message / scripts\mp\hud_message
// Params 1
// Checksum 0x0, Offset: 0x2554
// Size: 0x44
function getsplashid( splashref )
{
    id = level.splashtablecache[ splashref ];
    
    if ( !isdefined( id ) )
    {
        id = tablelookuprownum( getsplashtablename(), 0, splashref );
        level.splashtablecache[ splashref ] = id;
    }
    
    return id;
}

// Namespace hud_message / scripts\mp\hud_message
// Params 2
// Checksum 0x0, Offset: 0x25a1
// Size: 0x1e7
function function_73baf095c3b9cce6( splashref, splashlistoverride )
{
    id = level.var_4cd98c0c1064cfc0[ splashref ];
    
    if ( isdefined( id ) )
    {
        return id;
    }
    
    var_c1c3e6a4f162ab45 = undefined;
    
    if ( isdefined( splashlistoverride ) )
    {
        var_c1c3e6a4f162ab45 = splashlistoverride;
    }
    
    if ( !isdefined( var_c1c3e6a4f162ab45 ) && isdefined( level.gametypebundle ) )
    {
        var_c1c3e6a4f162ab45 = level.gametypebundle.splashlist;
    }
    
    if ( !isdefined( var_c1c3e6a4f162ab45 ) )
    {
        var_c1c3e6a4f162ab45 = level.gamemodebundle.splashlist;
    }
    
    if ( !isdefined( var_c1c3e6a4f162ab45 ) )
    {
        return undefined;
    }
    
    if ( isxhashasset( var_c1c3e6a4f162ab45 ) )
    {
        splashlist = getscriptbundle( var_c1c3e6a4f162ab45 );
    }
    else
    {
        splashlist = getscriptbundle( hashcat( %"hash_7ac5a0b15c7d50e5", var_c1c3e6a4f162ab45 ) );
    }
    
    if ( !isdefined( splashlist ) || !isdefined( splashlist.splash_list ) )
    {
        return undefined;
    }
    
    foreach ( var_68cc4b3bf54adcfe in splashlist.splash_list )
    {
        if ( var_68cc4b3bf54adcfe.ref != splashref )
        {
            continue;
        }
        
        assertex( isdefined( var_68cc4b3bf54adcfe.splashbundle ), "<dev string:x108>" + getxhashhexname( splashref ) );
        id = undefined;
        
        if ( isdefined( var_68cc4b3bf54adcfe.splashbundle ) )
        {
            id = function_2336488258354fbc( #"scriptbundle_splash", hashcat( %"hash_39857ea6520cf871", var_68cc4b3bf54adcfe.splashbundle ) );
        }
        else
        {
            scripts\mp\utility\script::function_7bd154ad046984e2( "Undefined splashListEntry.splashBundle for splashName: " + getxhashhexname( splashref ) );
        }
        
        if ( !isdefined( id ) )
        {
            break;
        }
        
        level.var_4cd98c0c1064cfc0[ splashref ] = id;
        return id;
    }
    
    id = scripts\mp\rank::function_1e00d01d19fde519( splashref );
    
    if ( isdefined( id ) )
    {
        level.var_4cd98c0c1064cfc0[ splashref ] = id;
        return id;
    }
    
    return undefined;
}

// Namespace hud_message / scripts\mp\hud_message
// Params 2
// Checksum 0x0, Offset: 0x2791
// Size: 0x8e
function function_cd236201b71f07e2( splashref, var_de02835724550257 )
{
    self endon( "disconnect" );
    
    if ( self getclientomnvar( "ui_match_in_progress" ) == 1 )
    {
        return;
    }
    
    if ( isdefined( level.var_5135022cc0f6a101 ) && level.var_5135022cc0f6a101 )
    {
        return;
    }
    
    if ( !isdefined( level.matchcountdowntime ) )
    {
        return;
    }
    
    if ( level.matchcountdowntime < var_de02835724550257 )
    {
        return;
    }
    
    while ( level.matchcountdowntime > var_de02835724550257 )
    {
        wait 1;
    }
    
    showsplash( splashref );
    level.var_5135022cc0f6a101 = 1;
}

// Namespace hud_message / scripts\mp\hud_message
// Params 0
// Checksum 0x0, Offset: 0x2827
// Size: 0x1d4
function lowermessagethink()
{
    self endon( "disconnect" );
    self.lowermessages = [];
    lowermessagefont = "default";
    
    if ( isdefined( level.lowermessagefont ) )
    {
        lowermessagefont = level.lowermessagefont;
    }
    
    messagey = level.lowertexty;
    var_4c254f3e1813b5ac = level.lowertextfontsize;
    var_ed9168da0f317746 = 1.25;
    
    if ( level.splitscreen || self issplitscreenplayer() && !isai( self ) )
    {
        messagey -= 40;
        var_4c254f3e1813b5ac = level.lowertextfontsize * 1.3;
        var_ed9168da0f317746 *= 1.5;
    }
    
    self.lowermessage = createfontstring( lowermessagefont, var_4c254f3e1813b5ac );
    self.lowermessage settext( "" );
    self.lowermessage.archived = 0;
    self.lowermessage.sort = 10;
    self.lowermessage.showinkillcam = 0;
    self.lowermessage setpoint( "CENTER", level.lowertextyalign, 0, messagey );
    self.lowertimer = createfontstring( "default", var_ed9168da0f317746 );
    self.lowertimer setparent( self.lowermessage );
    self.lowertimer setpoint( "TOP", "BOTTOM", 0, 0 );
    self.lowertimer settext( "" );
    self.lowertimer.archived = 0;
    self.lowertimer.sort = 10;
    self.lowertimer.showinkillcam = 0;
}

// Namespace hud_message / scripts\mp\hud_message
// Params 0
// Checksum 0x0, Offset: 0x2a03
// Size: 0x3, Type: bool
function isdoingsplash()
{
    return false;
}

// Namespace hud_message / scripts\mp\hud_message
// Params 5
// Checksum 0x0, Offset: 0x2a0f
// Size: 0x847
function teamoutcomenotify( winner, isround, endreasontext, endreasontextloss, roundendextramessage )
{
    self endon( "disconnect" );
    tempwinner = winner;
    gametype = getgametype();
    
    if ( isdefined( roundendextramessage ) )
    {
        self setclientomnvar( "ui_round_end_extra_message", roundendextramessage );
    }
    
    team = self.pers[ "team" ];
    
    if ( self iscodcaster() )
    {
        team = self getcodcasterteam();
    }
    
    if ( isdefined( team ) && team == "spectator" )
    {
        gametype = getbasegametype();
        var_b19d8f6eee9278c4 = getdvarint( @"hash_2167cbfc86b6839", 0 ) == 1;
        
        if ( gametype == "sd" || gametype == "arena" && var_b19d8f6eee9278c4 || gametype == "warrior" )
        {
            spectatingplayer = self getspectatingplayer();
            var_f5ed5bd62f53b5f2 = self getclientomnvar( "ui_team_before_spectating" );
            
            if ( isdefined( var_f5ed5bd62f53b5f2 ) )
            {
                team = level.teamnamelist[ var_f5ed5bd62f53b5f2 - 1 ];
            }
            else if ( isdefined( spectatingplayer ) )
            {
                team = spectatingplayer.team;
            }
        }
    }
    
    if ( !isdefined( team ) || !array_contains( level.teamnamelist, team ) )
    {
        team = "allies";
    }
    
    if ( winner == "halftime" )
    {
        self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "halftime" ] );
        tempwinner = "allies";
    }
    else if ( winner == "intermission" )
    {
        self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "intermission" ] );
        tempwinner = "allies";
    }
    else if ( winner == "switching_sides" )
    {
        self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "side_switch" ] );
        tempwinner = "allies";
    }
    else if ( winner == "roundend" )
    {
        self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "roundend" ] );
        tempwinner = "allies";
    }
    else if ( winner == "overtime" )
    {
        if ( iswinbytworulegametype() && !allteamstied() )
        {
            self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "match_point" ] );
        }
        else
        {
            self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "overtime" ] );
        }
        
        tempwinner = "allies";
    }
    else if ( winner == "match_point" )
    {
        if ( gametype == "wm" || gametype == "escort" )
        {
            self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "side_switch" ] );
            tempwinner = "allies";
        }
        else
        {
            self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "match_point" ] );
            tempwinner = "allies";
        }
    }
    else if ( winner == "final_round" )
    {
        self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "final_round" ] );
        tempwinner = "allies";
    }
    else if ( winner == "win_by_two" )
    {
        self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "win_by_two" ] );
        tempwinner = "allies";
    }
    else if ( winner == "tie" )
    {
        if ( gametype == "warrior" && level.var_6298f362ec23d83.ref == "hunt" )
        {
            namespace_a3d0d452337405e0::teamoutcomenotify( winner, isround, endreasontext, endreasontextloss, roundendextramessage );
        }
        else if ( gametype == "warrior" )
        {
            scripts\mp\gametypes\warrior::teamoutcomenotify( winner, isround, endreasontext, endreasontextloss, roundendextramessage );
        }
        else if ( isround && !waslastround() )
        {
            self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "round_draw" ] );
        }
        else
        {
            self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "draw" ] );
        }
        
        tempwinner = "allies";
    }
    else if ( self iscodcaster() )
    {
        self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "spectator" ] );
    }
    else if ( isdefined( self.pers[ "team" ] ) && winner == team )
    {
        if ( gametype == "wm" )
        {
            if ( team == winner )
            {
                self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "victory" ] );
            }
        }
        else if ( isround && !waslastround() )
        {
            self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "round_win" ] );
        }
        else
        {
            self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "victory" ] );
        }
    }
    else if ( isround && !waslastround() && gametype != "wm" )
    {
        self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "round_loss" ] );
    }
    else
    {
        self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "defeat" ] );
    }
    
    if ( !self iscodcaster() )
    {
        winner = tempwinner;
    }
    
    if ( getgametype() == "arena" || scripts\cp_mp\utility\game_utility::isbrstylegametype() || getgametype() == "arm" || getgametype() == "conflict" || getgametype() == "siege" || getbasegametype() == "control" )
    {
        if ( isdefined( endreasontextloss ) )
        {
            if ( isdefined( self.pers[ "team" ] ) && winner == team )
            {
                endreasontext = endreasontext;
            }
            else
            {
                endreasontext = endreasontextloss;
            }
        }
    }
    else if ( inovertime() && waslastround() && istimetobeatrulegametype() )
    {
        if ( getgametype() == "ctf" )
        {
            if ( isdefined( self.pers[ "team" ] ) && winner == team )
            {
                endreasontext = game[ "end_reason" ][ "time_to_beat_ctf_win" ];
            }
            else if ( isdefined( self.pers[ "team" ] ) && winner == getotherteam( self.pers[ "team" ] )[ 0 ] )
            {
                endreasontext = game[ "end_reason" ][ "time_to_beat_ctf_loss" ];
            }
        }
        else if ( getgametype() == "ball" )
        {
            if ( isdefined( self.pers[ "team" ] ) && winner == team )
            {
                endreasontext = game[ "end_reason" ][ "time_to_beat_uplink_win" ];
            }
            else if ( isdefined( self.pers[ "team" ] ) && winner == getotherteam( self.pers[ "team" ] )[ 0 ] )
            {
                endreasontext = game[ "end_reason" ][ "time_to_beat_uplink_loss" ];
            }
        }
    }
    else if ( isdefined( endreasontextloss ) )
    {
        if ( isdefined( self.pers[ "team" ] ) && winner == team )
        {
            endreasontext = endreasontext;
        }
        else
        {
            endreasontext = endreasontextloss;
        }
    }
    
    if ( !isdefined( endreasontext ) )
    {
        endreasontext = 1;
    }
    
    if ( self iscodcaster() )
    {
        if ( isdefined( game[ "end_reason_mlg_mapping" ][ endreasontext ] ) )
        {
            endreasontext = game[ "end_reason_mlg_mapping" ][ endreasontext ];
        }
    }
    
    if ( endreasontext == game[ "end_reason" ][ "switching_sides" ] )
    {
        self setclientomnvar( "ui_round_end_reason", 0 );
    }
    else
    {
        self setclientomnvar( "ui_round_end_reason", endreasontext );
    }
    
    if ( self iscodcaster() )
    {
        if ( winner == "axis" )
        {
            self setclientomnvar( "ui_round_end_winner", 1 );
        }
        else if ( winner == "allies" )
        {
            self setclientomnvar( "ui_round_end_winner", 2 );
        }
        else
        {
            self setclientomnvar( "ui_round_end_winner", 0 );
        }
    }
    
    if ( !isroundbased() || !isobjectivebased() || ismoddedroundgame() )
    {
        friendlyscore = scripts\mp\gamescore::_getteamscore( team );
        
        if ( friendlyscore > 16000 )
        {
            friendlyscore = 16000;
        }
        
        enemyscore = scripts\mp\gamescore::_getteamscore( getotherteam( team )[ 0 ] );
        
        if ( enemyscore > 16000 )
        {
            enemyscore = 16000;
        }
        
        self setclientomnvar( "ui_round_end_friendly_score", friendlyscore );
        self setclientomnvar( "ui_round_end_enemy_score", enemyscore );
    }
    else
    {
        self setclientomnvar( "ui_round_end_friendly_score", game[ "roundsWon" ][ team ] );
        self setclientomnvar( "ui_round_end_enemy_score", game[ "roundsWon" ][ getotherteam( team )[ 0 ] ] );
    }
    
    if ( isdefined( self.matchbonus ) )
    {
        self setclientomnvar( "ui_round_end_match_bonus", self.matchbonus );
    }
}

// Namespace hud_message / scripts\mp\hud_message
// Params 3
// Checksum 0x0, Offset: 0x325e
// Size: 0x213
function outcomenotify( winner, endreasontext, endreasontextloss )
{
    self endon( "disconnect" );
    players = level.placement[ "all" ];
    firstplace = players[ 0 ];
    secondplace = players[ 1 ];
    thirdplace = players[ 2 ];
    var_2571942a4dcd338e = level.players.size > 3 && level.gametype != "oic";
    
    if ( isstring( winner ) && winner == "tie" )
    {
        if ( isdefined( firstplace ) && scripts\mp\gamescore::_getplayerscore( firstplace ) == scripts\mp\gamescore::_getplayerscore( self ) )
        {
            self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "tie" ] );
            self setclientomnvar( "ui_round_end_reason", endreasontext );
        }
        else if ( isdefined( firstplace ) && self == firstplace || isdefined( secondplace ) && self == secondplace || isdefined( thirdplace ) && self == thirdplace )
        {
            self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "tie" ] );
            self setclientomnvar( "ui_round_end_reason", endreasontext );
        }
        else
        {
            self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "defeat" ] );
            self setclientomnvar( "ui_round_end_reason", ter_op( isdefined( endreasontextloss ), endreasontextloss, endreasontext ) );
        }
    }
    else if ( isdefined( firstplace ) && self == firstplace || istrue( var_2571942a4dcd338e ) && ( isdefined( secondplace ) && self == secondplace || isdefined( thirdplace ) && self == thirdplace ) )
    {
        self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "victory" ] );
        self setclientomnvar( "ui_round_end_reason", endreasontext );
    }
    else
    {
        self setclientomnvar( "ui_round_end_title", game[ "round_end" ][ "defeat" ] );
        self setclientomnvar( "ui_round_end_reason", ter_op( isdefined( endreasontextloss ), endreasontextloss, endreasontext ) );
    }
    
    if ( isdefined( self.matchbonus ) )
    {
        self setclientomnvar( "ui_round_end_match_bonus", self.matchbonus );
    }
}

// Namespace hud_message / scripts\mp\hud_message
// Params 0
// Checksum 0x0, Offset: 0x3479
// Size: 0x6b
function getsplashtablename()
{
    if ( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.splashtable ) && level.gamemodebundle.splashtable != "" )
    {
        return level.gamemodebundle.splashtable;
    }
    
    return getdvar( @"hash_b7b83cc9df67c558", "mp/splashTable.csv" );
}

// Namespace hud_message / scripts\mp\hud_message
// Params 0
// Checksum 0x0, Offset: 0x34ed
// Size: 0x4
function getsplashtablemaxaltdisplays()
{
    return 5;
}

// Namespace hud_message / scripts\mp\hud_message
// Params 0
// Checksum 0x0, Offset: 0x34fa
// Size: 0x64
function cleanuplocalplayersplashlist()
{
    self endon( "disconnect" );
    self notify( "cleanupLocalPlayerSplashList()" );
    self endon( "cleanupLocalPlayerSplashList()" );
    waittill_notify_or_timeout( "death", 0.5 );
    
    while ( isdefined( self ) && !isreallyalive( self ) && !self iscodcaster() )
    {
        wait 0.15;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.recentsplashcount = undefined;
    self notify( "splash_list_cleared" );
}

// Namespace hud_message / scripts\mp\hud_message
// Params 2
// Checksum 0x0, Offset: 0x3566
// Size: 0x1e
function splashshowncallback( channel, splashindex )
{
    if ( channel != "splash_shown" )
    {
        return;
    }
}

// Namespace hud_message / scripts\mp\hud_message
// Params 1
// Checksum 0x0, Offset: 0x358c
// Size: 0x1d
function onkillstreaksplashshown( splashref )
{
    scripts\cp_mp\utility\killstreak_utility::playkillstreakteamleaderdialog( splashref, splashref );
    thread checkforspecialistbonusvo( splashref );
}

// Namespace hud_message / scripts\mp\hud_message
// Params 1
// Checksum 0x0, Offset: 0x35b1
// Size: 0x40
function checkforspecialistbonusvo( splashref )
{
    specialistperk = scripts\mp\perks\perks::getspecialistperkforstreak();
    
    if ( splashref == "specialist_perk_bonus" )
    {
        wait 2;
        level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, #"bc_flavor_player_positive" );
    }
}

// Namespace hud_message / scripts\mp\hud_message
// Params 2
// Checksum 0x0, Offset: 0x35f9
// Size: 0xde
function showerrormessage( var_1797174f9e968e96, optionalparam )
{
    assertex( isstring( var_1797174f9e968e96 ), "<dev string:x129>" + var_1797174f9e968e96 );
    rownum = tablelookuprownum( "mp/errorMessages.csv", 0, var_1797174f9e968e96 );
    assertex( isdefined( rownum ) && rownum >= 0, "<dev string:x166>" + var_1797174f9e968e96 + "<dev string:x17a>" );
    
    if ( isdefined( optionalparam ) )
    {
        self setclientomnvar( "ui_mp_error_message_param", optionalparam );
    }
    else
    {
        self setclientomnvar( "ui_mp_error_message_param", -1 );
    }
    
    if ( isdefined( rownum ) )
    {
        self setclientomnvar( "ui_mp_error_message_id", rownum );
    }
    
    if ( !isdefined( self.errormessagebitflipper ) )
    {
        self.errormessagebitflipper = 0;
    }
    
    self.errormessagebitflipper = !self.errormessagebitflipper;
    self setclientomnvar( "ui_mp_error_trigger", ter_op( self.errormessagebitflipper, 2, 1 ) );
}

// Namespace hud_message / scripts\mp\hud_message
// Params 2
// Checksum 0x0, Offset: 0x36df
// Size: 0x69
function showerrormessagetoallplayers( var_1797174f9e968e96, optionalparam )
{
    foreach ( player in level.players )
    {
        player showerrormessage( var_1797174f9e968e96, optionalparam );
    }
}

// Namespace hud_message / scripts\mp\hud_message
// Params 1
// Checksum 0x0, Offset: 0x3750
// Size: 0x33, Type: bool
function testmiscmessage( messageref )
{
    rownum = tablelookuprownum( "mp/miscMessages.csv", 0, messageref );
    
    if ( isdefined( rownum ) && rownum >= 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace hud_message / scripts\mp\hud_message
// Params 1
// Checksum 0x0, Offset: 0x378c
// Size: 0x8c
function showmiscmessage( messageref )
{
    rownum = tablelookuprownum( "mp/miscMessages.csv", 0, messageref );
    assertex( isdefined( rownum ) && rownum >= 0, "<dev string:x166>" + messageref + "<dev string:x194>" );
    sound = tablelookupbyrow( "mp/miscMessages.csv", rownum, 3 );
    
    if ( isdefined( sound ) && sound != "" )
    {
        self playlocalsound( sound );
    }
    
    self setclientomnvar( "ui_misc_message_id", rownum );
    self setclientomnvar( "ui_misc_message_trigger", 1 );
}

// Namespace hud_message / scripts\mp\hud_message
// Params 0
// Checksum 0x0, Offset: 0x3820
// Size: 0x18b
function eventsplashesthink()
{
    self endon( "disconnect" );
    
    if ( !matchmakinggame() )
    {
        return;
    }
    
    var_ab5e2871fc88494c = 0;
    
    if ( !isdefined( self.pers[ "hasSpawned" ] ) )
    {
        var_ab5e2871fc88494c = 1;
    }
    
    self waittill( "loadout_class_selected" );
    var_19323a94e0c59dfb = 0;
    
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        level scripts\mp\flags::gameflagwait( "prematch_done" );
        var_19323a94e0c59dfb = 1;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_9bfbc8300ed86a03 = self getprivatepartysize() > 1;
    
    if ( var_ab5e2871fc88494c )
    {
        if ( var_19323a94e0c59dfb )
        {
            wait 2;
        }
        
        if ( scripts\cp_mp\utility\game_utility::function_e3ef0908b595e8e1() == 2 || var_9bfbc8300ed86a03 && getdvarint( @"online_mp_party_xpscale" ) == 2 || self isps4player() && getdvarfloat( @"hash_10f733902fb6e20" ) == 2 )
        {
            showsplash( "event_double_xp", undefined, self );
        }
        
        if ( scripts\cp_mp\utility\game_utility::function_7d04fc91bee2ccd1() == 2 || var_9bfbc8300ed86a03 && getdvarint( @"online_mp_party_weapon_xpscale" ) == 2 )
        {
            showsplash( "event_double_weapon_xp", undefined, self );
        }
        
        if ( scripts\cp_mp\utility\game_utility::function_6d29dcaf4fd78604() == 2 )
        {
            showsplash( "event_double_battle_xp", undefined, self );
        }
        
        if ( getdvarint( @"hash_5b7fd81267302dcc" ) > 0 )
        {
            showsplash( "event_double_keys", undefined, self );
        }
        
        if ( getdvarint( @"hash_4c37ee9fba93ff82" ) == 2 || var_9bfbc8300ed86a03 && getdvarint( @"hash_5023ebb6627f862d" ) == 2 )
        {
            showsplash( "event_double_xp_teams", undefined, self );
        }
    }
}

// Namespace hud_message / scripts\mp\hud_message
// Params 7
// Checksum 0x0, Offset: 0x39b3
// Size: 0x139
function notifyteam( friendlystring, enemystring, friendlyteam, skipplayers, var_6acc43fa4db03a7f, var_6ad135fa4db6448c, playerforplayercard )
{
    foreach ( player in level.players )
    {
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !isgameplayteam( player.team ) )
        {
            continue;
        }
        
        if ( player.team == friendlyteam )
        {
            if ( !canshowsplash( friendlystring ) )
            {
                continue;
            }
            
            if ( isdefined( skipplayers ) )
            {
                if ( !array_contains( skipplayers, player ) )
                {
                    player thread scripts\mp\hud_message::showsplash( friendlystring, var_6acc43fa4db03a7f, playerforplayercard );
                }
            }
            else
            {
                player thread scripts\mp\hud_message::showsplash( friendlystring, var_6acc43fa4db03a7f, playerforplayercard );
            }
            
            continue;
        }
        
        if ( !canshowsplash( enemystring ) )
        {
            continue;
        }
        
        if ( isdefined( skipplayers ) )
        {
            if ( !array_contains( skipplayers, player ) )
            {
                player thread scripts\mp\hud_message::showsplash( enemystring, var_6ad135fa4db6448c, playerforplayercard );
            }
            
            continue;
        }
        
        player thread scripts\mp\hud_message::showsplash( enemystring, var_6ad135fa4db6448c, playerforplayercard );
    }
}

// Namespace hud_message / scripts\mp\hud_message
// Params 1
// Checksum 0x0, Offset: 0x3af4
// Size: 0x2b
function function_2b88d4a7a0b44e30( ref )
{
    omnvarvalue = int( tablelookup( "mp/matchStatusHintTextTable.csv", 2, ref, 0 ) );
    return omnvarvalue;
}

// Namespace hud_message / scripts\mp\hud_message
// Params 1
// Checksum 0x0, Offset: 0x3b28
// Size: 0x1e
function function_f004ef4606b9efdc( ref )
{
    self setclientomnvar( "ui_match_status_hint_text", function_2b88d4a7a0b44e30( ref ) );
}

// Namespace hud_message / scripts\mp\hud_message
// Params 5
// Checksum 0x0, Offset: 0x3b4e
// Size: 0xd1
function updatematchstatushintforallplayers( friendlyteam, friendlyhint, enemyhint, specplayer, var_dc3596691b18226a )
{
    level notify( "updateHint" );
    level endon( "updateHint" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( friendlyteam ) && player.team == friendlyteam )
        {
            if ( isdefined( specplayer ) && player == specplayer )
            {
                player function_f004ef4606b9efdc( var_dc3596691b18226a );
            }
            else
            {
                player function_f004ef4606b9efdc( friendlyhint );
            }
            
            continue;
        }
        
        if ( isdefined( enemyhint ) )
        {
            player function_f004ef4606b9efdc( enemyhint );
        }
    }
}

// Namespace hud_message / scripts\mp\hud_message
// Params 0
// Checksum 0x0, Offset: 0x3c27
// Size: 0x21, Type: bool
function function_4e3eb46838440959()
{
    return istrue( level.var_cc9e990b6e83975b ) || !istrue( getdvarint( @"hash_aacc4977e4ea1009", 1 ) );
}

