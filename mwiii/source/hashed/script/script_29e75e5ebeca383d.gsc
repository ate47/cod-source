#using script_135f13d8aa1c1f19;
#using script_4948cdf739393d2d;
#using script_64acb6ce534155b7;
#using script_728ffcee8cbf30ee;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\entityheadicons;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_bunker_utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\br_scavenger_quest;
#using scripts\mp\gametypes\dmz_audio;
#using scripts\mp\gametypes\dmz_safes;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\locksandkeys;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace namespace_d8b853b40a83b85a;

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x9d7
// Size: 0x5c5
function getcontractdata( data )
{
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "safe", &function_f156678b1297cfb2 );
    function_f17124a7d7fbeaca();
    level.var_d8b853b40a83b85a = spawnstruct();
    var_ad60abb5340e959d = getdvarint( @"hash_5ea4fa2ae23946a7", 0 );
    level.var_d8b853b40a83b85a.time = var_ad60abb5340e959d != 0 ? var_ad60abb5340e959d : function_ea591c2a379e3424( "safecracker" );
    level.var_d8b853b40a83b85a.timebonus = getdvarint( @"hash_cfd8130a7ac5bdcf", 90 );
    level.var_d8b853b40a83b85a.numsafes = getdvarint( @"hash_62eed71e92d5aed0", 1 );
    level.var_d8b853b40a83b85a.var_591b8a798c3a67c3 = getdvarint( @"hash_952302af5ebc79d4", 3000 );
    level.var_d8b853b40a83b85a.var_59216a99e6c86d53 = level.var_d8b853b40a83b85a.var_591b8a798c3a67c3 * level.var_d8b853b40a83b85a.var_591b8a798c3a67c3;
    level.var_d8b853b40a83b85a.var_49d9de2a9cd31cdd = getdvarint( @"hash_fb53e617c8ba412a", 11800 );
    level.var_d8b853b40a83b85a.var_fc6c2c380a8177a1 = level.var_d8b853b40a83b85a.var_49d9de2a9cd31cdd * level.var_d8b853b40a83b85a.var_49d9de2a9cd31cdd;
    level.var_d8b853b40a83b85a.var_82c419a87816954 = getdvarfloat( @"hash_5d0dbfbbd490c400", 4 );
    level.var_d8b853b40a83b85a.var_a127465b8187ac6 = getdvarint( @"hash_b8bc0db35821cdca", 5000 );
    level.var_d8b853b40a83b85a.var_b2193923c0e12a84 = getdvarint( @"hash_9928ca92a88608a4", 9900 );
    level.var_d8b853b40a83b85a.var_3aad62e7a6c7f662 = getdvarint( @"hash_a868de1aa94e39c", 1 );
    level.var_d8b853b40a83b85a.var_597c27bd871980d = getdvarint( @"hash_6197c0161edb1dc5", 1 );
    level.var_d8b853b40a83b85a.safedeletedelay = getdvarint( @"hash_bb228e00bd7b5c27", 45 );
    level.var_d8b853b40a83b85a.var_6e8b543291b3bd51 = getdvarfloat( @"hash_d2c15d7f43bb9e4c", 5 );
    level.var_d8b853b40a83b85a.var_a4dfe8291567c56b = getdvarint( @"hash_54dca27f5ecfa36e", 1000 );
    level.var_d8b853b40a83b85a.var_8fe0e04a07e07422 = getdvarfloat( @"hash_829de2bbb4cef69f", 4 );
    level.var_d8b853b40a83b85a.var_f45ed74a08f90a5a = getdvarint( @"hash_efae0b9a025ad8ba", 1 );
    level.var_d8b853b40a83b85a.var_613ab2b4a9b13b81 = getdvarint( @"hash_ababf6639b219f6b", 1 );
    level.var_d8b853b40a83b85a.capturetime = getdvarint( @"hash_dfc1e4fcc26f2764", 45 );
    level.var_d8b853b40a83b85a.captureradius = getdvarint( @"hash_d681bb57bdfccf53", 400 );
    level.var_d8b853b40a83b85a.playmusic = getdvarint( @"hash_1ac6446778df8828", 0 );
    level.var_d8b853b40a83b85a.var_56ad755924f1363 = 21;
    level.var_d8b853b40a83b85a.var_ca3bee0f7088468f = 0;
    assert( isdefined( game[ "<dev string:x1c>" ] ) );
    
    if ( getdvar( @"ui_gametype", "" ) != "limbo" )
    {
        game[ "dialog" ][ "mission_safecrack_accept" ] = "sfcr_grav_msss";
    }
    
    game[ "dialog" ][ "mission_safecrack_success" ] = "sfcr_grav_msnc";
    game[ "dialog" ][ "mission_safecrack_fail" ] = "sfcr_grav_tmlr";
    game[ "dialog" ][ "mission_safecrack_safe1" ] = "sfcr_grav_tmsn";
    game[ "dialog" ][ "mission_safecrack_safe1_first_person" ] = "sfcr_grav_plsn";
    game[ "dialog" ][ "mission_safecrack_safe2" ] = "sfcr_grav_tmst";
    game[ "dialog" ][ "mission_safecrack_safe2_first_person" ] = "sfcr_grav_plst";
    data.funcs[ "onInit" ] = &function_8c64a4f648288a95;
    data.funcs[ "onShowAgain" ] = &function_86cfd4337fedf826;
    data.funcs[ "onTeamAssigned" ] = &function_921a0be9ec330c6a;
    data.funcs[ "onEnterGulag" ] = &function_ca07a6ca5c3c8af5;
    data.funcs[ "onPlayerRespawn" ] = &function_f6755bd234f8e261;
    data.funcs[ "onPlayerKilled" ] = &quest_onplayerkilled;
    data.funcs[ "onMarkPlayerAsEliminated" ] = &function_4f702ea532a7ca6e;
    data.funcs[ "onPlayerDisconnect" ] = &quest_onplayerdisconnect;
    data.funcs[ "onCancel" ] = &quest_oncancel;
    data.funcs[ "onPlayerTearDown" ] = &function_83d3732a571f142a;
    data.funcs[ "onPlayerAssimilated" ] = &function_75b53ad947495f9c;
    data.funcs[ "circleTick" ] = &function_bcdfe083cc8168d7;
    data.funcs[ "onTimerExpired" ] = &function_a80693d6d6f626dc;
    data.funcs[ "validateContractNotInStronghold" ] = &function_3e354a7f7649493b;
    data.funcs[ "onEliteTearDown" ] = &function_3471a27045b7af9e;
    function_6852c1572300b4ef();
    
    /#
        debug_init();
    #/
}

#using_animtree( "script_model" );

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 0
// Checksum 0x0, Offset: 0xfa4
// Size: 0xc6
function function_f17124a7d7fbeaca()
{
    level.scr_animtree[ "safe_drill_player" ] = #animtree;
    level.scr_anim[ "safe_drill_player" ][ "safedrill_enter" ] = %jup_wz_cq_safedrill_enter_sdr;
    level.scr_eventanim[ "safe_drill_player" ][ "safedrill_enter" ] = %"cq_safedrill_enter";
    level.scr_viewmodelanim[ "safe_drill_player" ][ "safedrill_enter" ] = "jup_wz_cq_safedrill_enter_sdr";
    level.scr_anim[ "safe_drill_player" ][ "safedrill_exit" ] = %jup_wz_cq_safedrill_exit_sdr;
    level.scr_eventanim[ "safe_drill_player" ][ "safedrill_exit" ] = %"cq_safedrill_exit";
    level.scr_viewmodelanim[ "safe_drill_player" ][ "safedrill_exit" ] = "jup_wz_cq_safedrill_exit_sdr";
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 0
// Checksum 0x0, Offset: 0x1072
// Size: 0xe6, Type: bool
function function_8c64a4f648288a95()
{
    self.safestructs = [];
    safelocations = function_70c697e50d1a348f( self.iselite );
    
    if ( !function_cc660b55959b2e7f( safelocations ) )
    {
        logstring( "br_safecrack_quest::quest_onInit - Safecracker quest failed to find a Safe!" );
        return false;
    }
    
    foreach ( safelocation in safelocations )
    {
        safestruct = spawnstruct();
        safestruct.progressstruct = spawnstruct();
        safestruct.progressstruct.safelocation = safelocation;
        safestruct.safelocation = safelocation;
        self.safestructs[ self.safestructs.size ] = safestruct;
    }
    
    self.safescracked = 0;
    return true;
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 0
// Checksum 0x0, Offset: 0x1161
// Size: 0x3, Type: bool
function function_86cfd4337fedf826()
{
    return false;
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 0
// Checksum 0x0, Offset: 0x116d
// Size: 0x2b5
function function_921a0be9ec330c6a()
{
    self.category = "safecracker";
    teamname = self.teams[ 0 ];
    numsafes = level.var_d8b853b40a83b85a.numsafes;
    time = level.var_d8b853b40a83b85a.time;
    
    if ( !istrue( self.iselite ) )
    {
        uiobjectiveshowtoteam( "safecracker", teamname );
        time = function_9b6275085fbcb8f4( time );
        function_5a15174d34f0670c( time, 0 );
    }
    else
    {
        uiobjectiveshowtoteam( "elite_safecracker", teamname );
    }
    
    self.safes = [];
    
    foreach ( safestruct in self.safestructs )
    {
        safestruct.safe = safe_spawn( safestruct.safelocation.origin, safestruct.safelocation.angles );
        safestruct.safe.safestruct = safestruct;
        safestruct.safe.teams = self.teams;
    }
    
    if ( level.var_d8b853b40a83b85a.var_3aad62e7a6c7f662 )
    {
        foreach ( safestruct in self.safestructs )
        {
            safestruct function_37e73a6a4c1afb18( teamname, self.iselite );
            safestruct.progressstruct function_898564b067c0ad72( teamname, self.iselite );
            safestruct function_89e2eef706f41a37( teamname );
        }
    }
    else
    {
        self.safestructs[ 0 ] function_37e73a6a4c1afb18( teamname, self.iselite );
        safestruct.progressstruct function_898564b067c0ad72( teamname, self.iselite );
        self.safestructs[ 0 ] function_89e2eef706f41a37( teamname );
    }
    
    if ( !istrue( self.iselite ) )
    {
        displayteamsplash( teamname, "br_safecracker_quest_start_team" );
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "mission_safecrack_accept", teamname, 1, 2, undefined, "dx_br_jpbm_" );
    }
    else
    {
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "arrow_start_safecrack", teamname, undefined, 2 );
    }
    
    displaysquadmessagetoteam( teamname, self.var_d154ac2657c5f44, 6, getquestindex( "safecracker" ) );
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x142a
// Size: 0x1d
function function_ca07a6ca5c3c8af5( player )
{
    if ( function_42a0806457ea8039( player ) )
    {
        function_738b34ce3eb8143e( player );
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x144f
// Size: 0x32
function function_f6755bd234f8e261( player )
{
    if ( function_42a0806457ea8039( player ) )
    {
        function_eab871a28ae5f349( player );
    }
    
    if ( istrue( self.iselite ) )
    {
        namespace_2d7f47b19ccdb41d::function_dcf3929e77fe1de9( player );
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 2
// Checksum 0x0, Offset: 0x1489
// Size: 0x1b
function quest_onplayerkilled( attacker, victim )
{
    function_d7a3859ef519189d( victim );
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x14ac
// Size: 0x13
function function_4f702ea532a7ca6e( victim )
{
    function_d7a3859ef519189d( victim );
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x14c7
// Size: 0x13
function quest_onplayerdisconnect( player )
{
    function_d7a3859ef519189d( player );
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x14e2
// Size: 0x2b
function quest_oncancel( team )
{
    if ( istrue( self.teams[ 0 ] == team ) )
    {
        function_cd0f560fad2e9cb6( 0, undefined, undefined, "Cancel" );
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x1515
// Size: 0xa3
function function_d7a3859ef519189d( player )
{
    if ( istrue( self.iselite ) )
    {
        return;
    }
    
    if ( player.team == self.teams[ 0 ] )
    {
        filter = namespace_1eb3c4e0e28fac71::function_94a8dc26f5353759( player, level.contractmanager.defaultfilter );
        
        if ( !scripts\mp\gametypes\br_quest_util::isteamvalid( self.teams[ 0 ], filter ) )
        {
            if ( istrue( level.var_d8b853b40a83b85a.var_f45ed74a08f90a5a ) && istrue( self.finalbombplanted ) )
            {
                return;
            }
            
            function_cd0f560fad2e9cb6( 0, undefined, undefined, "Killed" );
        }
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 3
// Checksum 0x0, Offset: 0x15c0
// Size: 0xd8
function function_aa30a0b07502a038( success, results, endstate )
{
    self notify( "task_ended" );
    teamname = self.teams[ 0 ];
    endcontract( ter_op( istrue( success ), teamname, undefined ), results, undefined, endstate );
    function_e8c97d5848bb6ab4( teamname, !istrue( self.iselite ) );
    wait 1;
    
    if ( istrue( level.var_d8b853b40a83b85a.playmusic ) )
    {
        foreach ( teamplayer in getteamdata( teamname, "players" ) )
        {
            teamplayer stopplayermusicstate( "dmz_trap_drill" );
        }
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 3
// Checksum 0x0, Offset: 0x16a0
// Size: 0xe6
function function_83d3732a571f142a( player, oldteam, newteam )
{
    if ( oldteam == self.teams[ 0 ] )
    {
        function_738b34ce3eb8143e( player );
        player uiobjectivehide();
        
        foreach ( safestruct in self.safestructs )
        {
            if ( isdefined( safestruct.safe ) )
            {
                safestruct.safe disablescriptableplayeruse( player );
            }
        }
        
        if ( !scripts\mp\gametypes\br_quest_util::isteamvalid( self.teams[ 0 ], level.contractmanager.defaultfilter ) )
        {
            thread function_a199d7c38adeec99();
            thread function_aa30a0b07502a038( 0, undefined, "Assimilation" );
        }
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x178e
// Size: 0x2b
function function_3471a27045b7af9e( team )
{
    task = self;
    task thread function_a199d7c38adeec99();
    task function_e8c97d5848bb6ab4( team, 0 );
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 3
// Checksum 0x0, Offset: 0x17c1
// Size: 0xc2
function function_75b53ad947495f9c( player, oldteam, newteam )
{
    if ( newteam == self.teams[ 0 ] )
    {
        function_eab871a28ae5f349( player );
        player uiobjectiveshow( "safecracker" );
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
        
        foreach ( safestruct in self.safestructs )
        {
            if ( isdefined( safestruct.safe ) )
            {
                safestruct.safe enablescriptableplayeruse( player );
            }
        }
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 2
// Checksum 0x0, Offset: 0x188b
// Size: 0xfb
function function_bcdfe083cc8168d7( dangercircleorigin, var_52d59c928eb97c81 )
{
    if ( istrue( self.var_df2a5e89c3bba966 ) )
    {
        return;
    }
    
    foreach ( safestruct in self.safestructs )
    {
        if ( isdefined( safestruct.safe ) )
        {
            if ( istrue( safestruct.safe.bombplanted ) )
            {
                continue;
            }
            
            if ( istrue( safestruct.safe.drilling ) )
            {
                continue;
            }
            
            if ( !scripts\mp\gametypes\br_circle_util::ispointindangercircle( safestruct.safe.origin ) )
            {
                self.var_df2a5e89c3bba966 = 1;
                function_cd0f560fad2e9cb6( 1, "br_safecracker_quest_obj_circle", "mission_safecrack_fail", "Circle", "dx_br_jpbm_" );
                return;
            }
        }
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 0
// Checksum 0x0, Offset: 0x198e
// Size: 0x129
function function_a80693d6d6f626dc()
{
    if ( istrue( self.iselite ) )
    {
        return;
    }
    
    foreach ( safestruct in self.safestructs )
    {
        if ( isdefined( safestruct.safe ) && istrue( safestruct.safe.bombplanted ) && !istrue( safestruct.safe.opened ) )
        {
            wait level.var_d8b853b40a83b85a.var_6e8b543291b3bd51;
            function_51d3a2b4cde79545();
            return;
        }
        
        if ( isdefined( safestruct.safe ) && istrue( safestruct.safe.drilling ) && !istrue( safestruct.safe.opened ) )
        {
            wait 5;
            function_51d3a2b4cde79545();
            return;
        }
    }
    
    function_cd0f560fad2e9cb6( 1, "br_safecracker_quest_timer_expired", "mission_safecrack_fail", "Time", "dx_br_jpbm_" );
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 5
// Checksum 0x0, Offset: 0x1abf
// Size: 0x9d
function function_cd0f560fad2e9cb6( var_bef2d73950379fa0, splashref, voiceref, endstate, prefixoverride )
{
    if ( istrue( var_bef2d73950379fa0 ) )
    {
        params = spawnstruct();
        params.intvar = 0;
        
        if ( !istrue( self.iselite ) )
        {
            displayteamsplash( self.teams[ 0 ], splashref, params );
        }
        
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam( voiceref, self.teams[ 0 ], 1, 2, undefined, prefixoverride );
    }
    
    thread function_a199d7c38adeec99();
    thread function_aa30a0b07502a038( 0, undefined, endstate );
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x1b64
// Size: 0xe1
function function_89e2eef706f41a37( teamname )
{
    self.safe setscriptablepartstate( "safe", "usable_not_open" );
    
    foreach ( player in level.players )
    {
        self.safe disablescriptableplayeruse( player );
    }
    
    players = getteamdata( teamname, "players" );
    
    foreach ( player in players )
    {
        self.safe enablescriptableplayeruse( player );
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x1c4d
// Size: 0x3a4
function function_70c697e50d1a348f( iselite )
{
    safelocations = [];
    searchorigin = self.tablet.origin;
    var_fdc6ee1b91ebb7bf = undefined;
    
    if ( level.mapname == "mp_br_mechanics" || level.mapname == "mp_jup_br_mechanics" )
    {
        locations = function_450e9a473b54ac88( searchorigin );
    }
    else
    {
        locations = function_718e51890ebd699a( searchorigin );
    }
    
    maxrange = level.var_d8b853b40a83b85a.var_49d9de2a9cd31cdd;
    
    if ( istrue( iselite ) && !isdefined( locations ) )
    {
        maxrange = level.var_d8b853b40a83b85a.var_49d9de2a9cd31cdd * level.var_d8b853b40a83b85a.var_82c419a87816954;
        locations = function_263dca86a9d81467( searchorigin );
    }
    
    if ( !isdefined( locations ) || locations.size < level.var_d8b853b40a83b85a.numsafes )
    {
        return undefined;
    }
    
    if ( !level.br_circle_disabled )
    {
        var_527a7b84d978e792 = scripts\mp\gametypes\br_circle_util::function_60951b84c58915ab( self.tablet.origin );
        var_fdc6ee1b91ebb7bf = scripts\mp\gametypes\br_circle_util::function_7d8550b9a2c52852( var_527a7b84d978e792 );
    }
    
    for ( i = 0; i < level.var_d8b853b40a83b85a.numsafes ; i++ )
    {
        bestsafe = undefined;
        var_385b83e50b8e55e2 = maxrange;
        
        foreach ( safe in locations )
        {
            if ( istrue( safe.inuse ) )
            {
                continue;
            }
            
            dist = distance2d( safe.origin, searchorigin );
            
            if ( !level.br_circle_disabled )
            {
                if ( !isdefined( safe.circletimeline ) )
                {
                    safe.circletimeline = scripts\mp\gametypes\br_circle_util::function_60951b84c58915ab( safe.origin );
                }
                
                var_28deb7ff62e281d3 = scripts\mp\gametypes\br_circle_util::function_7d8550b9a2c52852( safe.circletimeline );
                
                if ( var_28deb7ff62e281d3 < var_fdc6ee1b91ebb7bf )
                {
                    continue;
                }
            }
            
            var_5435995e95681b89 = 0;
            
            if ( dist < level.var_d8b853b40a83b85a.var_b2193923c0e12a84 )
            {
                if ( dist < level.var_d8b853b40a83b85a.var_a127465b8187ac6 )
                {
                    var_5435995e95681b89 = level.var_d8b853b40a83b85a.var_a127465b8187ac6 - dist;
                }
            }
            else
            {
                var_5435995e95681b89 = dist - level.var_d8b853b40a83b85a.var_b2193923c0e12a84;
            }
            
            if ( var_5435995e95681b89 < var_385b83e50b8e55e2 )
            {
                if ( namespace_9823ee6035594d67::function_ae011f52b2b15baf( safe.origin, 0 ) )
                {
                    continue;
                }
                
                if ( scripts\mp\gametypes\br_scavenger_quest::function_c096a9a3d859cfce( safe.origin ) )
                {
                    continue;
                }
                
                if ( scripts\mp\gametypes\br_bunker_utility::function_5581450b830e0245( safe.origin ) )
                {
                    continue;
                }
                
                if ( scripts\mp\locksandkeys::function_64332f29e2409e55( safe.origin ) )
                {
                    continue;
                }
                
                var_385b83e50b8e55e2 = var_5435995e95681b89;
                bestsafe = safe;
                
                if ( var_5435995e95681b89 <= 0 )
                {
                    break;
                }
            }
        }
        
        if ( isdefined( bestsafe ) )
        {
            bestsafe.inuse = 1;
            safelocations[ i ] = bestsafe;
            searchorigin = bestsafe.origin;
        }
    }
    
    if ( getdvarint( @"hash_aeb9e701a8ae6d", 1 ) && istrue( self.iselite ) && safelocations.size == 0 )
    {
        safelocations = function_3e2943fe577f2e33();
    }
    
    if ( safelocations.size < level.var_d8b853b40a83b85a.numsafes )
    {
        return undefined;
    }
    
    return safelocations;
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 2
// Checksum 0x0, Offset: 0x1ffa
// Size: 0x3f
function function_be60cfa5df0a2025( origin, angles )
{
    var_48a52c8d018d3159 = spawnstruct();
    var_48a52c8d018d3159.origin = origin;
    var_48a52c8d018d3159.angles = angles;
    return var_48a52c8d018d3159;
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x2042
// Size: 0x21a
function function_450e9a473b54ac88( origin )
{
    var_45a953583bd24e64 = [];
    temparray = [];
    temparray = array_add( temparray, function_be60cfa5df0a2025( ( -543, -2456, 120 ), ( 0, 180, 0 ) ) );
    temparray = array_add( temparray, function_be60cfa5df0a2025( ( -375, -640, 120 ), ( 0, 180, 0 ) ) );
    temparray = array_add( temparray, function_be60cfa5df0a2025( ( 1921, -2767, 120 ), ( 0, 270, 0 ) ) );
    temparray = array_add( temparray, function_be60cfa5df0a2025( ( 727, -668, 120 ), ( 0, 0, 0 ) ) );
    temparray = array_add( temparray, function_be60cfa5df0a2025( ( 3949, 471, 120 ), ( 0, 90, 0 ) ) );
    temparray = array_add( temparray, function_be60cfa5df0a2025( ( 5259, 485, 120 ), ( 0, 270, 0 ) ) );
    temparray = array_add( temparray, function_be60cfa5df0a2025( ( 2914, 1449, 120 ), ( 0, 270, 0 ) ) );
    level.var_d8b853b40a83b85a.var_9da47341ba68c8bf = temparray;
    
    foreach ( safe in level.var_d8b853b40a83b85a.var_9da47341ba68c8bf )
    {
        if ( istrue( safe.inuse ) )
        {
            continue;
        }
        
        distsq = distance2dsquared( origin, safe.origin );
        
        if ( distsq >= level.var_d8b853b40a83b85a.var_59216a99e6c86d53 && distsq <= level.var_d8b853b40a83b85a.var_fc6c2c380a8177a1 )
        {
            var_45a953583bd24e64[ var_45a953583bd24e64.size ] = safe;
        }
    }
    
    if ( var_45a953583bd24e64.size == 0 )
    {
        return undefined;
    }
    
    return var_45a953583bd24e64;
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 0
// Checksum 0x0, Offset: 0x2265
// Size: 0x6b
function function_6852c1572300b4ef()
{
    if ( !isdefined( level.var_d8b853b40a83b85a.var_9da47341ba68c8bf ) )
    {
        dmz_safes = getstructarray( "dmz_safe", "script_noteworthy" );
        br_safes = getstructarray( "br_safe", "script_noteworthy" );
        level.var_d8b853b40a83b85a.var_9da47341ba68c8bf = array_combine( dmz_safes, br_safes );
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x22d8
// Size: 0x38
function function_718e51890ebd699a( origin )
{
    return function_52082f56e7d2a9c7( origin, level.var_d8b853b40a83b85a.var_59216a99e6c86d53, level.var_d8b853b40a83b85a.var_fc6c2c380a8177a1 );
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x2319
// Size: 0x83
function function_263dca86a9d81467( origin )
{
    var_96df90e54e2d0fe0 = level.var_d8b853b40a83b85a.var_82c419a87816954 * level.var_d8b853b40a83b85a.var_82c419a87816954;
    var_59216a99e6c86d53 = level.var_d8b853b40a83b85a.var_59216a99e6c86d53;
    var_fc6c2c380a8177a1 = level.var_d8b853b40a83b85a.var_fc6c2c380a8177a1 * var_96df90e54e2d0fe0;
    return function_52082f56e7d2a9c7( origin, var_59216a99e6c86d53, var_fc6c2c380a8177a1 );
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 3
// Checksum 0x0, Offset: 0x23a5
// Size: 0xcf
function function_52082f56e7d2a9c7( origin, var_59216a99e6c86d53, var_fc6c2c380a8177a1 )
{
    function_6852c1572300b4ef();
    var_45a953583bd24e64 = [];
    
    foreach ( safe in level.var_d8b853b40a83b85a.var_9da47341ba68c8bf )
    {
        if ( istrue( safe.inuse ) )
        {
            continue;
        }
        
        distsq = distance2dsquared( origin, safe.origin );
        
        if ( distsq >= var_59216a99e6c86d53 && distsq <= var_fc6c2c380a8177a1 )
        {
            var_45a953583bd24e64[ var_45a953583bd24e64.size ] = safe;
        }
    }
    
    if ( var_45a953583bd24e64.size == 0 )
    {
        return undefined;
    }
    
    return var_45a953583bd24e64;
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 0
// Checksum 0x0, Offset: 0x247d
// Size: 0x143
function function_3e2943fe577f2e33()
{
    circlecenter = scripts\mp\gametypes\br_circle::getnextsafecircleorigin();
    circleradius = scripts\mp\gametypes\br_circle::getnextsafecircleradius();
    safelocations = [];
    bestdist = undefined;
    bestsafe = undefined;
    
    foreach ( safe in level.var_d8b853b40a83b85a.var_9da47341ba68c8bf )
    {
        if ( istrue( safe.inuse ) )
        {
            continue;
        }
        
        if ( namespace_9823ee6035594d67::function_ae011f52b2b15baf( safe.origin, 0 ) )
        {
            continue;
        }
        
        if ( scripts\mp\gametypes\br_scavenger_quest::function_c096a9a3d859cfce( safe.origin ) )
        {
            continue;
        }
        
        if ( scripts\mp\gametypes\br_bunker_utility::function_5581450b830e0245( safe.origin ) )
        {
            continue;
        }
        
        if ( scripts\mp\locksandkeys::function_64332f29e2409e55( safe.origin ) )
        {
            continue;
        }
        
        dist = distance2dsquared( circlecenter, safe.origin );
        
        if ( !isdefined( bestdist ) || dist < bestdist )
        {
            bestdist = dist;
            bestsafe = safe;
        }
    }
    
    if ( isdefined( bestsafe ) )
    {
        safelocations[ 0 ] = bestsafe;
    }
    
    return safelocations;
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 2
// Checksum 0x0, Offset: 0x25c9
// Size: 0x151
function safe_spawn( origin, angles )
{
    if ( !isdefined( angles ) )
    {
        angles = ( 0, 0, 0 );
    }
    
    var_b66875eaf0848550 = "br_quest_safe";
    
    if ( istrue( self.iselite ) )
    {
        var_b66875eaf0848550 = "br_nuke_safe";
    }
    
    if ( isdefined( level.var_ffae696f4ef77d0e ) )
    {
        var_b66875eaf0848550 = [[ level.var_ffae696f4ef77d0e ]]();
    }
    
    safe = spawnscriptable( var_b66875eaf0848550, origin, angles );
    safe.task = self;
    safe.capturetime = level.var_d8b853b40a83b85a.capturetime;
    safe.trigger = spawn( "trigger_radius", origin, 0, int( level.var_d8b853b40a83b85a.captureradius ), int( level.var_d8b853b40a83b85a.captureradius ) );
    safe.trigger trigger_off();
    safe thread function_e210529ea288eb50( safe.trigger, level.var_d8b853b40a83b85a.captureradius );
    safe setscriptablepartstate( "safe", "unusable" );
    safe.bombplanted = 0;
    safe function_57257d1ed9ce2f48( &function_2217437346021976 );
    return safe;
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 0
// Checksum 0x0, Offset: 0x2723
// Size: 0x48, Type: bool
function function_2217437346021976()
{
    safe = self;
    
    if ( !istrue( self.opened ) && isdefined( safe.task ) )
    {
        safe.task function_cd0f560fad2e9cb6( 0, undefined, undefined, "AreaSwap" );
    }
    
    return false;
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 6
// Checksum 0x0, Offset: 0x2774
// Size: 0x446
function function_f156678b1297cfb2( instance, part, state, player, bautouse, usestring )
{
    if ( istrue( player scripts\mp\gametypes\br_gametypes::runbrgametypefunc( "playerSkipLootPickup", instance ) ) )
    {
        return;
    }
    
    task = instance.task;
    
    if ( state == "usable_not_open" )
    {
        if ( player.team != task.teams[ 0 ] )
        {
            /#
                player iprintlnbold( "<dev string:x26>" );
            #/
            
            return;
        }
        
        if ( istrue( level.var_d8b853b40a83b85a.var_613ab2b4a9b13b81 ) )
        {
            instance.drilling = 1;
        }
        else
        {
            instance.bombplanted = 1;
        }
        
        if ( getdvarint( @"hash_2bd07e31cfab5dbf", 1 ) )
        {
            forwardvector = anglestoforward( instance.angles );
            sidevector = anglestoleft( instance.angles );
            instance.lootspawnpoint = spawnstruct();
            instance.lootspawnpoint.origin = instance.origin + forwardvector * 18 + sidevector * 10;
            instance.lootspawnpoint.angles = instance.angles + ( 0, -70, 0 );
        }
        
        if ( istrue( level.var_d8b853b40a83b85a.var_613ab2b4a9b13b81 ) )
        {
            instance.trigger trigger_on();
            instance setscriptablepartstate( part, "unusable" );
            instance thread scripts\mp\gametypes\dmz_safes::function_24765a7aabf0093e( player );
            instance scripts\mp\gametypes\dmz_safes::function_7f10e8e120314f4b( player, part );
            
            if ( istrue( instance.successfuluse ) )
            {
                scripts\mp\objidpoolmanager::objective_set_play_intro( instance.safestruct.progressstruct.objectiveiconid, 0 );
                scripts\mp\objidpoolmanager::update_objective_state( instance.safestruct.progressstruct.objectiveiconid, "current" );
                scripts\mp\objidpoolmanager::objective_show_progress( instance.safestruct.progressstruct.objectiveiconid, 1 );
                scripts\mp\objidpoolmanager::objective_teammask_addtomask( instance.safestruct.progressstruct.objectiveiconid, player.team );
                
                if ( istrue( task.iselite ) )
                {
                    task uiobjectiveshowtoteam( "elite_safecracker_loot", task.teams[ 0 ] );
                    level thread namespace_1eb3c4e0e28fac71::utilflare_shootflare( instance.origin, "revive" );
                }
                
                if ( istrue( level.var_d8b853b40a83b85a.playmusic ) )
                {
                    function_c1fd3441ccfba6f8( player.team, "dmz_trap_drill", 0.5 );
                }
                
                instance thread function_fb153ea0d9d1f48f( player );
            }
            else
            {
                instance.drilling = 0;
                instance setscriptablepartstate( part, "usable_not_open" );
            }
        }
        else
        {
            instance thread function_7dc98f165fe5f59d( player );
        }
        
        return;
    }
    
    if ( state == "usable_open" )
    {
        if ( !isdefined( instance.contents ) )
        {
            safescracked = 1;
            
            if ( isdefined( task ) )
            {
                safescracked = task.safescracked;
            }
            
            items = getscriptcachecontents( "br_quest_safe", level.var_d8b853b40a83b85a.var_ca3bee0f7088468f );
            level.var_d8b853b40a83b85a.var_ca3bee0f7088468f += 1;
            
            if ( level.var_d8b853b40a83b85a.var_ca3bee0f7088468f >= level.var_d8b853b40a83b85a.var_56ad755924f1363 )
            {
                level.var_d8b853b40a83b85a.var_ca3bee0f7088468f = 0;
            }
            
            instance.containertype = 4;
            instance scripts\mp\gametypes\br_lootcache::lootcachespawncontents( items, 1, player, instance.contents );
            return;
        }
        
        instance scripts\mp\gametypes\br_lootcache::lootcachespawncontents( undefined, 1, player, instance.contents );
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x2bc2
// Size: 0x42
function function_2844b247ce15cfc2( dangericonent )
{
    dangericonent endon( "death" );
    self waittill( "death" );
    
    if ( isdefined( dangericonent.headiconid ) )
    {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon( dangericonent.headiconid );
    }
    
    dangericonent delete();
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x2c0c
// Size: 0x26f
function function_7dc98f165fe5f59d( player )
{
    level endon( "game_ended" );
    self setscriptablepartstate( "safe", "unusable" );
    dangericonent = player _launchgrenade( "safe_c4_danger_icon_mp", self.origin, ( 0, 0, 0 ), 100, 1 );
    dangericonent.weapon_object = makeweapon( "safe_c4_danger_icon_mp" );
    
    if ( self.task.safescracked == 2 || level.var_d8b853b40a83b85a.numsafes == 1 )
    {
        self.task.finalbombplanted = 1;
    }
    
    normforwardvec = vectornormalize( anglestoforward( self.angles ) );
    fwdoffset = normforwardvec * 19;
    origin = self.origin + fwdoffset + ( 0, 0, 30 );
    bomb = spawn( "script_model", origin );
    bomb.angles = self.angles + ( 0, -90, 0 );
    navobstacleoffset = normforwardvec * 139;
    navobstacle = createnavbadplacebybounds( self.origin + navobstacleoffset, ( 160, 280, 80 ), self.angles );
    bomb setmodel( "offhand_wm_c4_br_safe" );
    bomb setscriptablepartstate( "effects", "plant" );
    bomb thread function_2844b247ce15cfc2( dangericonent );
    bomb thread function_f0282e7dbd8851fd( level.var_d8b853b40a83b85a.var_6e8b543291b3bd51 );
    wait level.var_d8b853b40a83b85a.var_6e8b543291b3bd51;
    bomb.angles = self.angles;
    bomb.origin += fwdoffset;
    bomb setscriptablepartstate( "effects", "explodeWall" );
    wait 0.2;
    thread safe_opensafe( player );
    
    if ( isdefined( dangericonent.headiconid ) )
    {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon( dangericonent.headiconid );
    }
    
    if ( isdefined( dangericonent ) )
    {
        dangericonent delete();
    }
    
    bomb hide();
    
    if ( isdefined( navobstacle ) )
    {
        destroynavobstacle( navobstacle );
    }
    
    wait 1.8;
    bomb delete();
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x2e83
// Size: 0x19b
function function_f0282e7dbd8851fd( var_1a7062ca13af0fb0 )
{
    level endon( "game_ended" );
    self endon( "bomb_exploded" );
    self endon( "bomb_defused" );
    self endon( "death" );
    bomb = self;
    
    if ( soundexists( "breach_c4_plant_05" ) )
    {
        bomb playsound( "breach_c4_plant_05" );
    }
    
    var_8adaf4318d8a76e4 = int( var_1a7062ca13af0fb0 );
    var_d8da94a475707d63 = var_1a7062ca13af0fb0 - var_8adaf4318d8a76e4;
    
    if ( var_d8da94a475707d63 > 0 )
    {
        wait var_d8da94a475707d63;
        var_1a7062ca13af0fb0 = var_8adaf4318d8a76e4;
    }
    
    ticktime = 0.5;
    starttime = gettime();
    endtime = starttime + var_1a7062ca13af0fb0 * 1000;
    now = starttime;
    
    while ( now < endtime )
    {
        now = gettime();
        var_c301d652d9a73075 = endtime - now;
        
        if ( var_c301d652d9a73075 <= 1000 && soundexists( "breach_warning_beep_05" ) )
        {
            bomb playsound( "breach_warning_beep_05" );
            ticktime = 0.05;
        }
        else if ( var_c301d652d9a73075 <= 2000 && soundexists( "breach_warning_beep_04" ) )
        {
            bomb playsound( "breach_warning_beep_04" );
            ticktime = 0.25;
        }
        else if ( var_c301d652d9a73075 <= 3000 && soundexists( "breach_warning_beep_03" ) )
        {
            bomb playsound( "breach_warning_beep_03" );
            ticktime = 0.5;
        }
        else if ( var_c301d652d9a73075 <= 4000 && soundexists( "breach_warning_beep_02" ) )
        {
            bomb playsound( "breach_warning_beep_02" );
        }
        else if ( soundexists( "breach_warning_beep_01" ) )
        {
            bomb playsound( "breach_warning_beep_01" );
        }
        
        wait ticktime;
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x3026
// Size: 0x617
function safe_opensafe( player )
{
    task = self.task;
    teamname = task.teams[ 0 ];
    players = getteamdata( teamname, "players" );
    self setscriptablepartstate( "safe", "opening" );
    
    if ( istrue( level.var_d8b853b40a83b85a.playmusic ) )
    {
        foreach ( teamplayer in getteamdata( task.teams[ 0 ], "players" ) )
        {
            teamplayer stopplayermusicstate( "dmz_trap_drill" );
        }
    }
    
    self.opened = 1;
    
    if ( getdvarint( @"hash_2bd07e31cfab5dbf", 1 ) )
    {
        foreach ( player in level.players )
        {
            self disablescriptableplayeruse( player );
        }
        
        items = getscriptcachecontents( "br_quest_safe", level.var_d8b853b40a83b85a.var_ca3bee0f7088468f );
        level.var_d8b853b40a83b85a.var_ca3bee0f7088468f += 1;
        
        if ( level.var_d8b853b40a83b85a.var_ca3bee0f7088468f >= level.var_d8b853b40a83b85a.var_56ad755924f1363 )
        {
            level.var_d8b853b40a83b85a.var_ca3bee0f7088468f = 0;
        }
        
        foreach ( player in players )
        {
            self disablescriptableplayeruse( player );
        }
        
        wait 0.8;
        scripts\mp\gametypes\br_quest_util::questrewarddropitems( player.team, items, self.lootspawnpoint.origin, self.lootspawnpoint.angles, 1, 3, 50 );
    }
    
    thread function_885786e5ff464caa();
    
    if ( isdefined( task ) )
    {
        task.safescracked++;
        
        if ( task.safescracked < level.var_d8b853b40a83b85a.numsafes )
        {
            if ( task.safescracked == 2 )
            {
                level thread scripts\mp\gametypes\br_public::brleaderdialogteamexcludeplayer( "mission_safecrack_safe2", player.team, player, 1, undefined, 2 );
                level thread scripts\mp\gametypes\br_public::brleaderdialogplayer( "mission_safecrack_safe2_first_person", player, 1, undefined, 2 );
            }
            else if ( task.safescracked == 1 )
            {
                level thread scripts\mp\gametypes\br_public::brleaderdialogteamexcludeplayer( "mission_safecrack_safe1", player.team, player, 1, undefined, 2 );
                level thread scripts\mp\gametypes\br_public::brleaderdialogplayer( "mission_safecrack_safe1_first_person", player, 1, undefined, 2 );
            }
            
            displaysquadmessagetoteam( teamname, player, 7, getquestindex( "safecracker" ) );
            
            if ( level.var_d8b853b40a83b85a.var_597c27bd871980d )
            {
                time = task function_f69c3e487b364f2f( level.var_d8b853b40a83b85a.timebonus );
                task function_5606274c76b4a2df( time );
            }
            
            if ( !level.var_d8b853b40a83b85a.var_3aad62e7a6c7f662 )
            {
                if ( !istrue( task.iselite ) )
                {
                    displayteamsplash( teamname, "br_safecracker_quest_next_location" );
                }
                
                var_41ec09af5a3fb6ec = task.safestructs[ task.safescracked ];
                var_41ec09af5a3fb6ec.objectiveiconid = self.safestruct.objectiveiconid;
                self.safestruct.objectiveiconid = undefined;
                var_41ec09af5a3fb6ec movequestobjicon( var_41ec09af5a3fb6ec.safelocation.origin );
                var_41ec09af5a3fb6ec function_89e2eef706f41a37( teamname );
            }
            else
            {
                self.safestruct function_6bb69599d9063e0f( teamname, 0 );
            }
        }
        else
        {
            displaysquadmessagetoteam( teamname, player, 8, getquestindex( "safecracker" ) );
            rewards = undefined;
            
            if ( getdvarint( @"hash_2bd07e31cfab5dbf", 1 ) )
            {
                rewards = function_d212a5e7a40d7c8d( "safecracker", teamname, self.lootspawnpoint );
            }
            else
            {
                rewards = function_d212a5e7a40d7c8d( "safecracker", teamname, self );
            }
            
            if ( !scripts\mp\gametypes\br_public::istutorial() )
            {
                if ( isdefined( rewards ) && isdefined( rewards[ "plunder" ] ) && !istrue( task.iselite ) )
                {
                    thread function_878ebcc241b54505( "br_safecracker_quest_complete", function_3d262d56274bd22e( "safecracker" ), rewards[ "plunder" ], teamname, 1 );
                }
                
                level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "mission_safecrack_success", teamname, 1, 3.5 );
            }
            
            task thread function_aa30a0b07502a038( 1, rewards, "Win" );
        }
        
        foreach ( player in players )
        {
            player uiobjectivesetparameter( task.safescracked );
        }
        
        task function_e2aa45e2c6b5dec1( task.safescracked );
        assert( issharedfuncdefined( "<dev string:x4e>", "<dev string:x56>" ) );
        playersquad = [[ getsharedfunc( "game", "getFriendlyPlayers" ) ]]( player.team, 0 );
        
        foreach ( teammate in playersquad )
        {
            teammate notify( "calloutmarkerping_warzoneKillQuestIcon" );
        }
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 0
// Checksum 0x0, Offset: 0x3645
// Size: 0x105
function function_a199d7c38adeec99()
{
    foreach ( safestruct in self.safestructs )
    {
        if ( isdefined( safestruct.safe ) )
        {
            var_f451f1efd8b651c8 = safestruct.safe getscriptablepartstate( "safe" );
            
            if ( isdefined( var_f451f1efd8b651c8 ) && var_f451f1efd8b651c8 == "usable_not_open" )
            {
                safestruct.safe function_9ae7a4649c25e6b2();
                continue;
            }
            
            if ( isdefined( var_f451f1efd8b651c8 ) && ( var_f451f1efd8b651c8 == "unusable_intro_drilling" || var_f451f1efd8b651c8 == "unusable_drilling" ) )
            {
                safestruct.safe setscriptablepartstate( "safe", "usable_not_open" );
                waitframe();
                safestruct.safe setscriptablepartstate( "safe", "unusable" );
                safestruct.safe function_885786e5ff464caa();
            }
        }
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 0
// Checksum 0x0, Offset: 0x3752
// Size: 0x24
function function_885786e5ff464caa()
{
    level endon( "game_ended" );
    wait level.var_d8b853b40a83b85a.safedeletedelay;
    function_9ae7a4649c25e6b2();
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 0
// Checksum 0x0, Offset: 0x377e
// Size: 0x8f
function function_9ae7a4649c25e6b2()
{
    if ( isdefined( self.safestruct ) && istrue( self.safestruct.safelocation.inuse ) )
    {
        self.safestruct.safelocation.inuse = 0;
    }
    
    if ( isdefined( self.entity ) )
    {
        self.entity delete();
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    self freescriptable();
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x3815
// Size: 0x56, Type: bool
function function_cc660b55959b2e7f( safelocations )
{
    if ( !isdefined( safelocations ) )
    {
        return false;
    }
    
    for ( i = 0; i < level.var_d8b853b40a83b85a.numsafes ; i++ )
    {
        safelocation = safelocations[ i ];
        
        if ( !isdefined( safelocation ) )
        {
            safelocations = undefined;
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 0
// Checksum 0x0, Offset: 0x3874
// Size: 0x8e, Type: bool
function function_9fff9366482cee3b()
{
    player = self.var_d154ac2657c5f44;
    
    foreach ( safestruct in self.safestructs )
    {
        if ( !scripts\mp\gametypes\br_circle_util::function_77cec84f05ca9418( safestruct.safelocation.origin, player.origin ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 0
// Checksum 0x0, Offset: 0x390b
// Size: 0x188, Type: bool
function function_3e354a7f7649493b()
{
    if ( !isdefined( self.safestructs ) )
    {
        return false;
    }
    
    foreach ( safestruct in self.safestructs )
    {
        if ( namespace_9823ee6035594d67::function_ae011f52b2b15baf( safestruct.safelocation.origin, 0 ) )
        {
            foreach ( var_87b4fdfd5be4ac27 in self.safestructs )
            {
                var_87b4fdfd5be4ac27.safelocation.inuse = 0;
            }
            
            self.safestructs = undefined;
            resetsuccessful = function_8c64a4f648288a95();
            
            if ( !resetsuccessful )
            {
                /#
                    if ( !isdefined( level.contractmanager.var_b2c94adf9c0eb16 ) )
                    {
                        level.contractmanager.var_b2c94adf9c0eb16 = 0;
                    }
                    
                    level.contractmanager.var_b2c94adf9c0eb16 += 1;
                    println( "<dev string:x6c>" + level.contractmanager.var_b2c94adf9c0eb16 );
                #/
                
                self.tablet thread tablethide();
                return false;
            }
        }
    }
    
    return true;
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 2
// Checksum 0x0, Offset: 0x3a9c
// Size: 0xb3
function function_898564b067c0ad72( teamname, iselite )
{
    if ( iselite )
    {
        createquestobjicon( "ui_map_icon_elite_safe", "current", self.safelocation.origin + ( 0, 0, 55 ) );
        objective_setbackground( self.objectiveiconid, 1 );
        objective_settint( self.objectiveiconid, 246, 192, 72 );
    }
    else
    {
        createquestobjicon( "ui_mp_br_mapmenu_icon_safebreaker_objective", "current", self.safelocation.origin + ( 0, 0, 55 ) );
    }
    
    objective_removeallfrommask( self.objectiveiconid );
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 2
// Checksum 0x0, Offset: 0x3b57
// Size: 0xf4
function function_37e73a6a4c1afb18( teamname, iselite )
{
    if ( iselite )
    {
        createquestobjicon( "ui_map_icon_elite_safe", "current", self.safelocation.origin + ( 0, 0, 55 ) );
        objective_setdescription( self.objectiveiconid, &"MP_BR_INGAME/LOOT_CARD_ELITE_SAFE_TITLE" );
        objective_setbackground( self.objectiveiconid, 1 );
        objective_settint( self.objectiveiconid, 246, 192, 72 );
    }
    else
    {
        createquestobjicon( "ui_mp_br_mapmenu_icon_safebreaker_objective", "current", self.safelocation.origin + ( 0, 0, 55 ) );
    }
    
    objective_removeallfrommask( self.objectiveiconid );
    thread function_425f0abdafad5a76( self.objectiveiconid, teamname, iselite );
    objective_setshowdistance( self.objectiveiconid, 0 );
    thread function_a11aea6569521300( teamname, iselite );
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 2
// Checksum 0x0, Offset: 0x3c53
// Size: 0x88
function function_a11aea6569521300( teamname, iselite )
{
    level endon( "game_ended" );
    
    if ( level.var_d8b853b40a83b85a.var_8fe0e04a07e07422 > 0 )
    {
        wait level.var_d8b853b40a83b85a.var_8fe0e04a07e07422;
    }
    
    if ( istrue( iselite ) )
    {
        questchain = namespace_b11d742e70949af1::function_c6ec58a3c19cd74d( teamname );
        
        if ( isdefined( questchain ) )
        {
            objective_setshowdistance( self.objectiveiconid, 1 );
        }
        
        return;
    }
    
    objective_setshowdistance( self.objectiveiconid, 1 );
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 2
// Checksum 0x0, Offset: 0x3ce3
// Size: 0x69
function function_e8c97d5848bb6ab4( teamname, questcomplete )
{
    foreach ( safestruct in self.safestructs )
    {
        safestruct function_6bb69599d9063e0f( teamname, questcomplete );
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 2
// Checksum 0x0, Offset: 0x3d54
// Size: 0x11c
function function_6bb69599d9063e0f( teamname, hidewidget )
{
    if ( isdefined( self.objectiveiconid ) )
    {
        foreach ( player in getteamdata( teamname, "players" ) )
        {
            function_7087e66b57d92a78( player, hidewidget );
        }
        
        deletequestobjicon();
        self.objectiveiconid = undefined;
    }
    
    if ( isdefined( self.progressstruct.objectiveiconid ) )
    {
        foreach ( player in getteamdata( teamname, "players" ) )
        {
            self.progressstruct function_7087e66b57d92a78( player, hidewidget );
        }
        
        self.progressstruct deletequestobjicon();
        self.progressstruct.objectiveiconid = undefined;
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 2
// Checksum 0x0, Offset: 0x3e78
// Size: 0x28
function function_7087e66b57d92a78( player, hidewidget )
{
    hidequestobjiconfromplayer( player );
    
    if ( istrue( hidewidget ) )
    {
        player uiobjectivehide();
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x3ea8
// Size: 0x6f
function function_738b34ce3eb8143e( player )
{
    foreach ( safestruct in self.safestructs )
    {
        if ( isdefined( safestruct.objectiveiconid ) )
        {
            safestruct hidequestobjiconfromplayer( player );
        }
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x3f1f
// Size: 0x6f
function function_eab871a28ae5f349( player )
{
    foreach ( safestruct in self.safestructs )
    {
        if ( isdefined( safestruct.objectiveiconid ) )
        {
            safestruct showquestobjicontoplayer( player );
        }
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 1
// Checksum 0x0, Offset: 0x3f96
// Size: 0x18c
function function_fb153ea0d9d1f48f( player )
{
    level endon( "game_ended" );
    self endon( "safe_unlocked" );
    self.task endon( "task_ended" );
    self.progress = 0;
    shownplayers = [];
    
    while ( true )
    {
        if ( isdefined( self.trigger ) && !istrue( self.trigger.trigger_off ) )
        {
            if ( self.nearbyplayers.size > 0 )
            {
                self.drilling = 1;
                progressbefore = self.progress;
                self.progress = min( self.capturetime, self.progress + level.framedurationseconds );
            }
            else
            {
                self.drilling = 0;
                progressbefore = self.progress;
                self.progress = max( 0, self.progress - level.framedurationseconds * 0.5 );
            }
            
            progress = self.progress / self.capturetime;
            shownplayers = self.safestruct.progressstruct function_f64c5b47c182d6f2( self.nearbyplayers, shownplayers, progress );
            scripts\mp\objidpoolmanager::objective_set_progress( self.safestruct.progressstruct.objectiveiconid, progress );
            
            if ( self.progress >= self.capturetime )
            {
                thread safe_opensafe( player );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 3
// Checksum 0x0, Offset: 0x412a
// Size: 0x11c
function function_f64c5b47c182d6f2( nearbyplayers, shownplayers, progress )
{
    allplayers = array_combine( nearbyplayers, shownplayers );
    var_f6fd7b0e73c3270c = shownplayers;
    
    foreach ( player in allplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !array_contains( shownplayers, player ) && array_contains( nearbyplayers, player ) )
        {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( self.objectiveiconid, player );
            scripts\mp\objidpoolmanager::objective_pin_player( self.objectiveiconid, player );
            scripts\mp\objidpoolmanager::function_7299a742781a5030( 2, player );
            scripts\mp\objidpoolmanager::function_8f7a55bda12ebb21( &"MP_DMZ_MISSIONS/OPENING_SAFE", player );
            var_f6fd7b0e73c3270c = array_add( var_f6fd7b0e73c3270c, player );
            continue;
        }
        
        if ( array_contains( shownplayers, player ) && !array_contains( nearbyplayers, player ) )
        {
            scripts\mp\objidpoolmanager::objective_playermask_hidefrom( self.objectiveiconid, player );
            var_f6fd7b0e73c3270c = array_remove( var_f6fd7b0e73c3270c, player );
        }
    }
    
    return var_f6fd7b0e73c3270c;
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 2
// Checksum 0x0, Offset: 0x424f
// Size: 0xbb
function function_e210529ea288eb50( trigger, radius )
{
    level endon( "game_ended" );
    self endon( "safe_unlocked" );
    self.task endon( "task_ended" );
    self.nearbyplayers = [];
    
    while ( true )
    {
        trigger waittill( "trigger", player );
        
        if ( !isplayer( player ) || array_contains( self.nearbyplayers, player ) )
        {
            continue;
        }
        
        if ( !array_contains( self.teams, player.team ) )
        {
            continue;
        }
        
        self.nearbyplayers = array_add( self.nearbyplayers, player );
        thread function_19aa45f456e9a8c5( trigger, player, radius );
    }
}

// Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
// Params 3
// Checksum 0x0, Offset: 0x4312
// Size: 0x94
function function_19aa45f456e9a8c5( trigger, player, radius )
{
    while ( isdefined( player ) && isalive( player ) && isdefined( self.trigger ) && distance( trigger.origin, player.origin ) < radius * 1.2 )
    {
        wait 0.2;
    }
    
    if ( isdefined( self.nearbyplayers ) && isdefined( player ) )
    {
        self.nearbyplayers = array_remove( self.nearbyplayers, player );
    }
}

/#

    // Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
    // Params 0
    // Checksum 0x0, Offset: 0x43ae
    // Size: 0x2e, Type: dev
    function debug_init()
    {
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:xa3>" );
        scripts\common\devgui::function_a9a864379a098ad6( "<dev string:xc1>", "<dev string:xdd>", &function_105695786af8edd6 );
        scripts\common\devgui::function_fe953f000498048f();
    }

    // Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
    // Params 0
    // Checksum 0x0, Offset: 0x43e4
    // Size: 0x102, Type: dev
    function function_105695786af8edd6()
    {
        if ( !isdefined( level.var_d8b853b40a83b85a.var_34d04530be5ef6ac ) || !istrue( level.var_d8b853b40a83b85a.var_34d04530be5ef6ac ) )
        {
            level.var_d8b853b40a83b85a.var_34d04530be5ef6ac = 1;
            level thread function_5e53697221a32d8d();
            return;
        }
        
        level.var_d8b853b40a83b85a.var_34d04530be5ef6ac = 0;
        level notify( "<dev string:xf9>" );
        
        foreach ( safe in level.var_d8b853b40a83b85a.var_9da47341ba68c8bf )
        {
            if ( isdefined( safe.safe ) )
            {
                safe.safe freescriptable();
                safe.debug_spawned = 0;
            }
        }
        
        iprintlnbold( "<dev string:x10c>" );
    }

    // Namespace namespace_d8b853b40a83b85a / namespace_cc15148f4ce22771
    // Params 0
    // Checksum 0x0, Offset: 0x44ee
    // Size: 0x12f, Type: dev
    function function_5e53697221a32d8d()
    {
        level endon( "<dev string:x133>" );
        level endon( "<dev string:xf9>" );
        iprintlnbold( "<dev string:x141>" );
        
        while ( true )
        {
            foreach ( safe in level.var_d8b853b40a83b85a.var_9da47341ba68c8bf )
            {
                if ( distance2d( level.player.origin, safe.origin ) < 1500 )
                {
                    if ( !isdefined( safe.safe ) && !istrue( safe.debug_spawned ) )
                    {
                        safe.safe = safe_spawn( safe.origin, safe.angles );
                        safe.debug_spawned = 1;
                    }
                    
                    continue;
                }
                
                if ( isdefined( safe.safe ) )
                {
                    safe.safe freescriptable();
                    safe.debug_spawned = 0;
                }
            }
            
            wait 1;
        }
    }

#/
