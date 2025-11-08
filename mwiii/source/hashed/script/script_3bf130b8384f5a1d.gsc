#using script_41387eecc35b88bf;
#using script_62a4f7a62643fe8;
#using script_749ff6f56673a813;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\gametypes\ob_pvpve;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\teamrevive;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\teams;

#namespace namespace_910f1c9e49a229ca;

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xa09
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_23b157aee842e25e", undefined, undefined, &function_144097189064ffad );
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0
// Checksum 0x0, Offset: 0xa2a
// Size: 0x24d
function function_144097189064ffad()
{
    if ( getdvarint( @"hash_95e91827f8d9304a", 0 ) != 1 )
    {
        return;
    }
    
    level.var_319c5fcabbf91284 = 1;
    level.var_b66406c81d84e91f = [];
    level.var_867a2a58a53c66f2 = &function_777650b23d69e74e;
    level.var_8d0eb92efe17b1c0 = getdvarint( @"hash_c1fac26e33ca48af", 1 );
    level.var_10eebe39d476816e = getdvarint( @"hash_dfce5fa223df2cad", 5 );
    level.var_1764c13968c16a53 = getdvarint( @"hash_285e2b8266522669", 0 );
    level.var_6583f8d86afcc61a = getdvarint( @"hash_27fe27abbde8fd64", 0 );
    level.var_ad34cf1255372b35 = getdvarint( @"hash_a11d5d6a27c6be24", 1 );
    level.var_84e6692f7dce674a = getdvarint( @"hash_53e0ee5a932df698", 0 );
    level.var_4089ec169f21a24e = getdvarint( @"hash_f08099780025ff11", 1 );
    level.var_91b26b191aee211d = getdvarint( @"hash_733cb0dc88e4bdec", 1 );
    level.var_135fcaa8f9802c71 = getdvarint( @"hash_736b8ddd707b3d8e", 1 );
    level.var_f638d0429eb0ffd6 = getdvarint( @"hash_d35ec6cf08b913ca", 3 );
    level.var_8af7200f711796c7 = getdvarint( @"hash_ef6ec0733fcc3eb8", 15 );
    level.var_22753af4cd04bb82 = getdvarint( @"hash_30949967eb7968ed", 0 );
    
    if ( istrue( level.var_91b26b191aee211d ) )
    {
        level.var_fd15b9ad0f909a26 = &function_be25d212fb44b9a9;
    }
    
    scripts\mp\teamrevive::function_5343ecb486b66bf1( "recon_points", &onspawnrevivetrigger );
    
    if ( istrue( level.var_22753af4cd04bb82 ) )
    {
        level thread function_2950b8b7b06664d7();
    }
    
    level callback::add( "on_ai_killed", &onaikilled );
    level callback::add( "on_ob_laststand_player_killed", &onplayerkilled );
    level callback::add( "player_connect", &onplayerconnected );
    level callback::add( "player_disconnect", &onplayerdisconnected );
    level callback::add( "spectating_target_death_or_disconnect", &function_96357a61d1fdb3f6 );
    level callback::add( "player_bleedout", &function_c9df4b28bedf5ec1 );
    level callback::add( "player_death", &onplayerdeath );
    
    if ( istrue( level.var_1764c13968c16a53 ) )
    {
        function_8b5b2a3392fc7e2a( "ActivitySuccess", &function_e07daf5fb2a4ecd3 );
    }
    
    /#
        level thread initdebug();
    #/
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xc7f
// Size: 0x64
function private onplayerconnected( params )
{
    playerid = self getentitynumber();
    level.var_b66406c81d84e91f[ playerid ] = clamp( level.var_8d0eb92efe17b1c0, 0, level.var_10eebe39d476816e );
    
    /#
        self.zombiedamagemultiplier = getdvarint( @"hash_59c18d87dd312e0b", 1 );
    #/
    
    function_2f5cbe081bc2430();
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xceb
// Size: 0x36
function private onplayerdisconnected( params )
{
    function_2f5cbe081bc2430();
    
    if ( self.sessionstate == "playing" )
    {
        level thread function_220efee7b4271691( self.team );
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xd29
// Size: 0x9a
function private function_96357a61d1fdb3f6( params )
{
    player = params.spectatingplayer;
    player endon( "disconnect" );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( player.team == "spectator" || player.team == "codcaster" )
    {
        return;
    }
    
    wait 1;
    alivecount = getteamdata( player.team, "aliveCount" );
    
    if ( alivecount > 0 )
    {
        return;
    }
    
    level thread scripts\cp_mp\utility\game_utility::function_852712268d005332( player, 0, 0.25 );
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xdcb
// Size: 0x25
function private function_1516111d965f0f5( val )
{
    self setclientomnvar( "ui_securing", val );
    self setclientomnvar( "ui_securing_solo", val );
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xdf8
// Size: 0x25
function private function_be2a38379b60c50( val )
{
    self setclientomnvar( "ui_securing_progress", val );
    self setclientomnvar( "ui_securing_progress_solo", val );
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xe25
// Size: 0x61
function private function_c676385595f09300()
{
    lowermessage = "press_to_spawn";
    timer = undefined;
    
    if ( level.var_135fcaa8f9802c71 > 0 )
    {
        if ( isdefined( self.var_606e5479d161ed16 ) )
        {
            lowermessage = "recon_points_respawn_enabled_timeout";
            timer = self.var_606e5479d161ed16;
        }
        else
        {
            lowermessage = "recon_points_respawn_enabled";
            timer = 0;
        }
    }
    
    scripts\mp\utility\lower_message::setlowermessageomnvar( lowermessage, timer );
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xe8e
// Size: 0x5c
function private onspawnrevivetrigger()
{
    deadplayer = self.victim;
    
    if ( isdefined( deadplayer ) && istrue( deadplayer.var_f8e619cb980be7d3 ) )
    {
        logstring( "[recon_points] OnSpawnReviveTrigger DisablePlayerUseForAllPlayers" );
        level.revivetriggers[ deadplayer.guid ] setscriptablepartstate( "cyber_revive_icon", "unusable" );
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xef2
// Size: 0x2c7
function private function_220efee7b4271691( team )
{
    level endon( "game_ended" );
    self notify( "end_player_use_hold_think_" + team );
    self endon( "end_player_use_hold_think_" + team );
    teammates = getteamdata( team, "players" );
    
    foreach ( player in teammates )
    {
        if ( player.sessionstate == "playing" )
        {
            return;
        }
    }
    
    endusetime = gettime() + level.var_8af7200f711796c7 * 1000;
    
    foreach ( player in teammates )
    {
        if ( !isdefined( player.var_606e5479d161ed16 ) )
        {
            player.var_606e5479d161ed16 = endusetime;
        }
    }
    
    var_c74157caaaf53945 = "player_use_hold_respawned_" + team;
    reason = level waittill_any_timeout_1( level.var_8af7200f711796c7, var_c74157caaaf53945 );
    teammates = getteamdata( team, "players" );
    var_3f9eb2eca674eeed = 1;
    
    foreach ( player in teammates )
    {
        player.var_606e5479d161ed16 = undefined;
        
        if ( player.sessionstate == "playing" )
        {
            var_3f9eb2eca674eeed = 0;
        }
    }
    
    if ( !var_3f9eb2eca674eeed )
    {
        return;
    }
    
    if ( !is_equal( reason, var_c74157caaaf53945 ) )
    {
        foreach ( player in teammates )
        {
            var_7bf7b14acaf96c1d = player function_33a21b2ea282d115();
            player function_14debcad04282fbf( var_7bf7b14acaf96c1d * -1 );
            player function_4f10add3b5c17e5e();
            player scripts\mp\utility\lower_message::setlowermessageomnvar( "clear_lower_msg", 0 );
            player notify( "player_use_hold_think" );
        }
        
        var_192c781ad2c7d253 = 0;
        
        foreach ( player in level.players )
        {
            if ( player.sessionstate == "playing" )
            {
                var_192c781ad2c7d253 = 1;
                break;
            }
            
            if ( !player function_be25d212fb44b9a9() )
            {
                var_192c781ad2c7d253 = 1;
                break;
            }
        }
        
        level thread scripts\mp\gametypes\ob::onsquadeliminated( teammates, var_192c781ad2c7d253 );
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x11c1
// Size: 0x58
function private function_f76c23c258e81220()
{
    self.var_f8e619cb980be7d3 = 1;
    function_1516111d965f0f5( 5 );
    function_be2a38379b60c50( 0 );
    
    if ( isdefined( level.revivetriggers[ self.guid ] ) )
    {
        level.revivetriggers[ self.guid ] setscriptablepartstate( "cyber_revive_icon", "unusable" );
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1221
// Size: 0x56
function private function_4f10add3b5c17e5e()
{
    self.var_f8e619cb980be7d3 = undefined;
    function_1516111d965f0f5( 0 );
    function_be2a38379b60c50( 0 );
    
    if ( isdefined( level.revivetriggers[ self.guid ] ) )
    {
        level.revivetriggers[ self.guid ] setscriptablepartstate( "cyber_revive_icon", "usable" );
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x127f
// Size: 0x19f
function private playeruseholdthink()
{
    level endon( "game_ended" );
    self notify( "player_use_hold_think" );
    self endon( "disconnect" );
    self endon( "player_use_hold_think" );
    logstring( "[recon_points] respawn thread begins !!! " + self.name + " sessionstate: " + self.sessionstate );
    
    while ( self.sessionstate != "playing" )
    {
        if ( !self getbeingrevived() )
        {
            if ( function_33a21b2ea282d115() < level.var_135fcaa8f9802c71 )
            {
                scripts\mp\utility\lower_message::setlowermessageomnvar( "recon_points_respawn_disabled" );
            }
            else
            {
                function_c676385595f09300();
                
                if ( self usebuttonpressed() )
                {
                    usedtime = 0;
                    waittimestep = 0.05;
                    function_f76c23c258e81220();
                    
                    while ( self usebuttonpressed() && self.sessionstate != "playing" && usedtime < level.var_f638d0429eb0ffd6 )
                    {
                        function_be2a38379b60c50( usedtime / level.var_f638d0429eb0ffd6 );
                        usedtime += waittimestep;
                        wait waittimestep;
                    }
                    
                    function_4f10add3b5c17e5e();
                    
                    if ( usedtime >= level.var_f638d0429eb0ffd6 )
                    {
                        logstring( "[recon_points] useTime  !!! " + usedtime );
                        break;
                    }
                }
            }
        }
        else
        {
            scripts\mp\utility\lower_message::setlowermessageomnvar( "clear_lower_msg", 0 );
        }
        
        wait 0.2;
    }
    
    logstring( "[recon_points] respawn thread end !!! " + self.name + " sessionstate: " + self.sessionstate );
    scripts\mp\utility\lower_message::setlowermessageomnvar( "clear_lower_msg", 0 );
    
    if ( self.sessionstate != "playing" )
    {
        level notify( "player_use_hold_respawned_" + self.team );
        function_777650b23d69e74e( #"hash_f448446b03528bac" );
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1426
// Size: 0x32
function private onplayerkilled( params )
{
    if ( istrue( level.var_91b26b191aee211d ) )
    {
        thread playeruseholdthink();
        level thread function_220efee7b4271691( self.team );
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1460
// Size: 0xb0
function private function_e07daf5fb2a4ecd3( params )
{
    activity = self;
    playerlist = params.playerlist;
    
    if ( isdefined( playerlist ) && isdefined( activity ) && isdefined( activity.category ) && activity.category == "Contract" )
    {
        foreach ( player in playerlist )
        {
            player thread function_777650b23d69e74e( #"contracts_completed" );
        }
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1518
// Size: 0x57
function private function_c9df4b28bedf5ec1( params )
{
    if ( isdefined( level.var_867a2a58a53c66f2 ) && isplayer( self.laststandattacker ) && self != self.laststandattacker )
    {
        self.laststandattacker [[ level.var_867a2a58a53c66f2 ]]( #"enemy_killed" );
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1577
// Size: 0x5d
function private onplayerdeath( params )
{
    if ( isdefined( level.var_867a2a58a53c66f2 ) && isplayer( params.attacker ) && self != params.attacker )
    {
        params.attacker [[ level.var_867a2a58a53c66f2 ]]( #"enemy_killed" );
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0
// Checksum 0x0, Offset: 0x15dc
// Size: 0x2e
function function_33a21b2ea282d115()
{
    if ( !istrue( level.var_319c5fcabbf91284 ) )
    {
        return 0;
    }
    
    playerid = self getentitynumber();
    return level.var_b66406c81d84e91f[ playerid ];
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1613
// Size: 0x13e
function private function_df4b133a2c53cb24( s_exfil, var_ae579781d2b3fea1, nextobjectiveid )
{
    if ( isdefined( self.var_64891db3f3c85d57 ) && self.var_64891db3f3c85d57 != -1 )
    {
        if ( is_equal( self.var_64891db3f3c85d57, var_ae579781d2b3fea1 ) )
        {
            scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout( self.var_3c32c1f7963d00d );
            self.var_64891db3f3c85d57 = nextobjectiveid;
            self.var_3c32c1f7963d00d = scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout( 11, s_exfil.origin, nextobjectiveid );
            thread function_54f1ae7e02711fc9();
        }
        
        return;
    }
    
    if ( isdefined( s_exfil.var_d182b8d3f3aaa93b ) && isdefined( s_exfil.var_d182b8d3f3aaa93b.var_a49938597b3587f0 ) && array_contains( s_exfil.var_d182b8d3f3aaa93b.var_a49938597b3587f0, self ) )
    {
        for ( pingindex = 0; pingindex < 10 ; pingindex++ )
        {
            target = self calloutmarkerping_getent( pingindex );
            
            if ( is_equal( target, s_exfil.var_d182b8d3f3aaa93b ) )
            {
                scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout( pingindex );
                self.var_3c32c1f7963d00d = scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout( 11, s_exfil.origin, nextobjectiveid );
                break;
            }
        }
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1759
// Size: 0xa3
function private function_10972832881180ee( s_exfil, showprimary )
{
    if ( istrue( showprimary ) )
    {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( s_exfil.objectiveidprimary, self );
        scripts\mp\objidpoolmanager::objective_playermask_hidefrom( s_exfil.objectiveidsecondary, self );
        function_df4b133a2c53cb24( s_exfil, s_exfil.objectiveidsecondary, s_exfil.objectiveidprimary );
        return;
    }
    
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer( s_exfil.objectiveidsecondary, self );
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom( s_exfil.objectiveidprimary, self );
    function_df4b133a2c53cb24( s_exfil, s_exfil.objectiveidprimary, s_exfil.objectiveidsecondary );
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1804
// Size: 0xa8
function private function_4f67cc94e9d23825( s_exfil )
{
    if ( !isdefined( s_exfil ) || !isdefined( s_exfil.var_d182b8d3f3aaa93b ) )
    {
        return;
    }
    
    if ( !is_equal( s_exfil.var_d182b8d3f3aaa93b.type, "cp_mp_recon_points_exfil_site_entityless" ) )
    {
        return;
    }
    
    if ( isdefined( s_exfil.player_activator ) )
    {
        function_10972832881180ee( s_exfil, is_equal( self.team, s_exfil.player_activator.team ) );
        return;
    }
    
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( s_exfil.objectiveidprimary );
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( s_exfil.objectiveidsecondary );
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x18b4
// Size: 0x80
function private function_bc9f002d4decfa9e( s_exfil )
{
    if ( !isdefined( s_exfil ) || !isdefined( s_exfil.var_d182b8d3f3aaa93b ) )
    {
        return;
    }
    
    if ( !is_equal( s_exfil.var_d182b8d3f3aaa93b.type, "cp_mp_recon_points_exfil_site_entityless" ) )
    {
        return;
    }
    
    if ( function_9a63dbbe0ab75279( s_exfil.var_d182b8d3f3aaa93b ) )
    {
        return;
    }
    
    var_ed989f1ff40d4df4 = function_33a21b2ea282d115() >= level.var_8571b4c6c544a92c;
    function_10972832881180ee( s_exfil, var_ed989f1ff40d4df4 );
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x193c
// Size: 0x165
function private function_2f5cbe081bc2430()
{
    var_41445c1d24a2bc4b = 0;
    offset = 4;
    teammates = getteamdata( self.team, "players" );
    
    foreach ( player in teammates )
    {
        squadmemberindex = player.sessionuimemberindex;
        shiftoffset = squadmemberindex * offset;
        amount = int( player function_33a21b2ea282d115() );
        var_41445c1d24a2bc4b = amount << shiftoffset | var_41445c1d24a2bc4b;
    }
    
    foreach ( player in teammates )
    {
        player setclientomnvar( "ui_ob_recon_points_count", var_41445c1d24a2bc4b );
    }
    
    var_30706430d8caaeb7 = function_8e6454dd6d0cedd3();
    
    foreach ( s_exfil in var_30706430d8caaeb7 )
    {
        function_bc9f002d4decfa9e( s_exfil );
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1aa9
// Size: 0xd1
function private function_14debcad04282fbf( delta )
{
    if ( is_equal( delta, 0 ) )
    {
        return;
    }
    
    playerid = self getentitynumber();
    var_20d7ec5e9edb74a3 = level.var_b66406c81d84e91f[ playerid ];
    level.var_b66406c81d84e91f[ playerid ] = clamp( var_20d7ec5e9edb74a3 + delta, 0, level.var_10eebe39d476816e );
    
    if ( var_20d7ec5e9edb74a3 < level.var_b66406c81d84e91f[ playerid ] )
    {
        scripts\mp\hud_message::showsplash( "recon_points_earned", undefined, undefined, undefined, undefined, "splash_list_jup_ob_pvpve" );
        level thread scripts\cp_mp\overlord::playevent( "recon_points_acquired", [ self ] );
    }
    else if ( is_equal( level.var_b66406c81d84e91f[ playerid ], level.var_10eebe39d476816e ) )
    {
        scripts\mp\hud_message::showsplash( "recon_points_max", undefined, undefined, undefined, undefined, "splash_list_jup_ob_pvpve" );
    }
    
    function_2f5cbe081bc2430();
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1b82
// Size: 0x19, Type: bool
function private function_be25d212fb44b9a9()
{
    if ( function_33a21b2ea282d115() >= level.var_135fcaa8f9802c71 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1ba4
// Size: 0x111
function private function_777650b23d69e74e( event, params )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( !istrue( level.var_319c5fcabbf91284 ) || !isdefined( event ) )
    {
        return 0;
    }
    
    var_ada5a9c1e47b30de = undefined;
    
    switch ( event )
    {
        case #"boss_killed":
            var_ada5a9c1e47b30de = level.var_ad34cf1255372b35;
            break;
        case #"hash_2a29c734c3883c89":
            var_ada5a9c1e47b30de = level.var_84e6692f7dce674a;
            break;
        case #"contracts_completed":
            var_ada5a9c1e47b30de = level.var_6583f8d86afcc61a;
            break;
        case #"enemy_killed":
            var_ada5a9c1e47b30de = level.var_4089ec169f21a24e;
            break;
        case #"hash_eea98455a74fc364":
            return doexfil( params );
        case #"hash_f448446b03528bac":
            return function_5e077dbd13c9817f();
        default:
            /#
                logstring( "<dev string:x1c>" + getxhashsourcename( event ) );
            #/
            
            break;
    }
    
    if ( isdefined( var_ada5a9c1e47b30de ) )
    {
        function_14debcad04282fbf( var_ada5a9c1e47b30de );
        return 1;
    }
    
    return 0;
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1cbe
// Size: 0x7a, Type: bool
function private doexfil( params )
{
    if ( isdefined( params ) && isdefined( params.s_exfil ) && function_9a63dbbe0ab75279( params.s_exfil.var_d182b8d3f3aaa93b ) )
    {
        /#
            logstring( "<dev string:x63>" );
        #/
        
        return true;
    }
    
    if ( function_33a21b2ea282d115() < level.var_8571b4c6c544a92c )
    {
        return false;
    }
    
    function_14debcad04282fbf( level.var_8571b4c6c544a92c * -1 );
    return true;
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1d41
// Size: 0x23
function private function_c16b35933a0b12e1()
{
    scripts\mp\gametypes\ob_pvpve::function_a6a654c500d6b6c2();
    wait 2;
    level thread scripts\cp_mp\overlord::playevent( "recon_points_respawn", [ self ] );
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1d6c
// Size: 0x5a, Type: bool
function private function_5e077dbd13c9817f()
{
    if ( function_33a21b2ea282d115() < level.var_135fcaa8f9802c71 )
    {
        return false;
    }
    
    function_14debcad04282fbf( level.var_135fcaa8f9802c71 * -1 );
    
    if ( isalive( self ) && self.sessionstate != "playing" )
    {
        self.health = 0;
    }
    
    thread function_c16b35933a0b12e1();
    return true;
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1
// Checksum 0x0, Offset: 0x1dcf
// Size: 0xcc
function onaikilled( params )
{
    var_168224244dcb1447 = isdefined( self.subclass ) && string_starts_with( self.subclass, "ob_warlord_" );
    var_a7d68498d3a48332 = isdefined( self.subclass ) && self.subclass == "zombie_abom_mega";
    
    if ( !var_168224244dcb1447 && !var_a7d68498d3a48332 )
    {
        return;
    }
    
    playerattacker = params.eattacker;
    
    if ( isdefined( playerattacker ) && !isplayer( playerattacker ) && isplayer( playerattacker.owner ) )
    {
        playerattacker = playerattacker.owner;
    }
    
    if ( !isplayer( playerattacker ) )
    {
        return;
    }
    
    playerattacker thread function_777650b23d69e74e( #"boss_killed" );
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1ea3
// Size: 0xb5, Type: bool
function private function_9a63dbbe0ab75279( a_exfil )
{
    if ( level.var_8571b4c6c544a92c == 0 )
    {
        return true;
    }
    
    if ( isdefined( a_exfil ) )
    {
        if ( isdefined( a_exfil.s_exfil ) && function_4027f5445bb7c8fb( a_exfil.s_exfil ) )
        {
            return true;
        }
        
        if ( isdefined( level.var_27aad97b556a4fcf ) )
        {
            foreach ( s_exfil in level.var_27aad97b556a4fcf )
            {
                if ( a_exfil == s_exfil.var_d182b8d3f3aaa93b )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1f61
// Size: 0x6e, Type: bool
function private function_50ff57d0f4bd0d0e( player )
{
    if ( !istrue( level.var_34a7933267810c4 ) )
    {
        return false;
    }
    
    if ( !isdefined( player ) )
    {
        return true;
    }
    
    maxdistancesqrt = level.var_31f34dcf808ad455 * level.var_31f34dcf808ad455;
    var_d9c6176b077a7891 = distance2dsquared( player.origin, self.origin );
    
    if ( var_d9c6176b077a7891 > maxdistancesqrt )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1fd8
// Size: 0xf, Type: bool
function private function_14d4e08fe0b364e7()
{
    if ( namespace_6776e8e74ed64842::expansion_started() )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1ff0
// Size: 0xab
function private function_4bc55e63d13224ef()
{
    logstring( "[recon_points] StartCommunalExfil " + self.name );
    self.var_d182b8d3f3aaa93b.interact setscriptablepartstate( "cp_mp_exfil_site", "free_exfil_site" );
    self.var_1c13f1737dccef9a = 1;
    level.var_44194c664b77bf1b = array_remove( level.var_44194c664b77bf1b, self );
    self.var_81fff6332116316f = level.var_dae00956e0a3d5c5;
    self.var_cfaabfb649760fac = &function_50ff57d0f4bd0d0e;
    self.var_c9b6fe30b53a07f8 = level.var_cafbd8eacf78a549;
    function_1590a66b9f6c2c3b( self, level.var_dae00956e0a3d5c5 );
    level thread function_748fd8b59180efd1( self );
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x20a3
// Size: 0xda
function private function_d2f63cdbcf2830e8()
{
    self.var_1c13f1737dccef9a = 0;
    self.player_activator = undefined;
    level.var_27aad97b556a4fcf = array_remove( level.var_27aad97b556a4fcf, self );
    var_30706430d8caaeb7 = function_8e6454dd6d0cedd3();
    
    if ( array_contains( var_30706430d8caaeb7, self ) )
    {
        foreach ( player in level.players )
        {
            player function_bc9f002d4decfa9e( self );
        }
        
        self.var_d182b8d3f3aaa93b.interact setscriptablepartstate( "cp_mp_exfil_icon", "default_icon" );
    }
    
    /#
        logstring( "<dev string:x8a>" + self.name );
    #/
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2185
// Size: 0x6d
function private function_959e7645849321e5()
{
    if ( isdefined( level.var_27aad97b556a4fcf ) )
    {
        foreach ( s_exfil in level.var_27aad97b556a4fcf )
        {
            s_exfil function_d2f63cdbcf2830e8();
        }
    }
    
    level.var_27aad97b556a4fcf = [];
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x21fa
// Size: 0x22b
function private function_ca9c0366894334e8()
{
    var_56cbe00f8fc22d4b = [];
    
    foreach ( s_exfil in function_8e6454dd6d0cedd3() )
    {
        if ( function_4027f5445bb7c8fb( s_exfil ) )
        {
            continue;
        }
        
        var_56cbe00f8fc22d4b[ var_56cbe00f8fc22d4b.size ] = s_exfil;
    }
    
    if ( isdefined( level.var_35ac4ef8ead6f796 ) )
    {
        var_56cbe00f8fc22d4b = array_remove( var_56cbe00f8fc22d4b, level.var_35ac4ef8ead6f796 );
    }
    
    if ( var_56cbe00f8fc22d4b.size <= 0 )
    {
        foreach ( player in level.players )
        {
            player scripts\mp\hud_message::showsplash( "recon_points_free_exfil_not_found", undefined, undefined, undefined, undefined, "splash_list_jup_ob_pvpve" );
        }
        
        return;
    }
    
    var_3a80af333de4222 = random( var_56cbe00f8fc22d4b );
    level.var_27aad97b556a4fcf[ level.var_27aad97b556a4fcf.size ] = var_3a80af333de4222;
    level.var_35ac4ef8ead6f796 = var_3a80af333de4222;
    
    foreach ( player in level.players )
    {
        if ( var_3a80af333de4222 function_50ff57d0f4bd0d0e( player ) )
        {
            continue;
        }
        
        player scripts\mp\hud_message::showsplash( "recon_points_free_exfil_activated", undefined, undefined, undefined, undefined, "splash_list_jup_ob_pvpve" );
    }
    
    var_3a80af333de4222.var_d182b8d3f3aaa93b.interact setscriptablepartstate( "cp_mp_exfil_icon", "free_exfil_icon" );
    
    if ( istrue( level.var_34a7933267810c4 ) )
    {
        var_3a80af333de4222 function_4bc55e63d13224ef();
    }
    else
    {
        foreach ( player in level.players )
        {
            player function_4f67cc94e9d23825( var_3a80af333de4222 );
        }
    }
    
    var_3a80af333de4222 thread function_fc46b6e2c35361c4( level.var_34a7933267810c4 );
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x242d
// Size: 0x8a
function private function_c28fc02badb3bf98( var_cc371abb7f83dd1b, var_8cbf72799df0c438 )
{
    var_ee71204034f2c8d1 = var_cc371abb7f83dd1b - var_8cbf72799df0c438;
    
    if ( var_ee71204034f2c8d1 > 0 )
    {
        wait var_ee71204034f2c8d1;
        
        foreach ( player in level.players )
        {
            player scripts\mp\hud_message::showsplash( "recon_points_free_exfil_coming", undefined, undefined, undefined, undefined, "splash_list_jup_ob_pvpve" );
        }
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x24bf
// Size: 0x2c
function private function_fc46b6e2c35361c4( var_68dbff394c9f2dce )
{
    if ( istrue( var_68dbff394c9f2dce ) )
    {
        self waittill( "exfil_complete_timeout" );
    }
    else
    {
        wait level.var_1422423eba8353d6;
    }
    
    function_d2f63cdbcf2830e8();
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x24f3
// Size: 0x69
function private function_5ac28eb279e004dc( var_cc371abb7f83dd1b, var_8cbf72799df0c438 )
{
    if ( istrue( level.var_34a7933267810c4 ) )
    {
        thread function_c28fc02badb3bf98( var_cc371abb7f83dd1b, var_8cbf72799df0c438 );
    }
    
    wait var_cc371abb7f83dd1b;
    
    if ( !flag( "exfil_initialized" ) )
    {
        logstring( "[recon_points] WaitAndStartRandomExfil exfil not initialized " );
        return;
    }
    
    if ( function_14d4e08fe0b364e7() )
    {
        function_959e7645849321e5();
        logstring( "[recon_points] WaitAndStartRandomExfil free exfil finished " );
        return;
    }
    
    function_ca9c0366894334e8();
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2564
// Size: 0x81
function private function_36763cf05948f767()
{
    level notify( "recon_points_free_exfil_think" );
    level endon( "game_ended" );
    level endon( "recon_points_free_exfil_think" );
    level waittill( "prematch_done" );
    logstring( "[recon_points] FreeExfilThink starts: Delay " + level.var_7c5c009a2bb8fdf0 + " Interval: " + level.var_1422423eba8353d6 );
    var_d25ce37b0193c4cf = 30;
    function_5ac28eb279e004dc( level.var_7c5c009a2bb8fdf0, var_d25ce37b0193c4cf );
    
    while ( !function_14d4e08fe0b364e7() )
    {
        function_5ac28eb279e004dc( level.var_1422423eba8353d6, var_d25ce37b0193c4cf );
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x25ed
// Size: 0xfc
function private onexfilstart( s_exfil )
{
    if ( function_4027f5445bb7c8fb( s_exfil ) )
    {
        return;
    }
    
    if ( !istrue( level.var_34a7933267810c4 ) && istrue( function_9a63dbbe0ab75279( s_exfil.var_d182b8d3f3aaa93b ) ) )
    {
        s_exfil.var_d182b8d3f3aaa93b.interact setscriptablepartstate( "cp_mp_exfil_icon", "default_icon" );
    }
    
    scripts\mp\objidpoolmanager::update_objective_icon( s_exfil.objectiveidprimary, "ui_map_icon_extraction_friendly" );
    scripts\mp\objidpoolmanager::update_objective_icon( s_exfil.objectiveidsecondary, "ui_map_icon_extraction_enemy" );
    
    foreach ( player in level.players )
    {
        player function_4f67cc94e9d23825( s_exfil );
    }
    
    /#
        logstring( "<dev string:xac>" + s_exfil.name );
    #/
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x26f1
// Size: 0x3a
function private function_b3c36611131bd74a( s_exfil )
{
    if ( function_4027f5445bb7c8fb( s_exfil ) )
    {
        return;
    }
    
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( s_exfil.objectiveidprimary );
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( s_exfil.objectiveidsecondary );
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2733
// Size: 0xed
function private onexfilreset( s_exfil )
{
    if ( function_4027f5445bb7c8fb( s_exfil ) )
    {
        return;
    }
    
    if ( istrue( function_9a63dbbe0ab75279( s_exfil.var_d182b8d3f3aaa93b ) ) )
    {
        s_exfil.var_d182b8d3f3aaa93b.interact setscriptablepartstate( "cp_mp_exfil_icon", "free_exfil_icon" );
    }
    
    scripts\mp\objidpoolmanager::update_objective_icon( s_exfil.objectiveidprimary, "ui_map_icon_extraction_recon_points" );
    scripts\mp\objidpoolmanager::update_objective_icon( s_exfil.objectiveidsecondary, "ui_map_icon_extraction_recon_points_disabled" );
    
    foreach ( player in level.players )
    {
        player function_bc9f002d4decfa9e( s_exfil );
    }
    
    /#
        logstring( "<dev string:xd0>" + s_exfil.name );
    #/
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2828
// Size: 0x121
function private function_7b7d449978e92e60( pingowner, pingindex )
{
    target = scripts\cp_mp\calloutmarkerping::function_b6cb97b6f81f0fd2( pingowner, pingindex );
    params = spawnstruct();
    params.player = pingowner;
    params.pingindex = pingindex;
    params.obj = target;
    
    if ( isdefined( target ) )
    {
        target callback::callback( "on_ping", params );
        
        if ( is_equal( target.type, "cp_mp_recon_points_exfil_site_entityless" ) && isdefined( self.var_3c32c1f7963d00d ) )
        {
            scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout( self.var_3c32c1f7963d00d );
        }
        
        return;
    }
    
    gscobjectiveid = self calloutmarkerping_getgscobjectiveindex( pingindex );
    
    if ( gscobjectiveid != -1 )
    {
        self.var_3c32c1f7963d00d = pingindex;
        self.var_64891db3f3c85d57 = gscobjectiveid;
        thread function_54f1ae7e02711fc9();
    }
    
    for ( pingindex = 0; pingindex < 10 ; pingindex++ )
    {
        target = self calloutmarkerping_getent( pingindex );
        
        if ( isdefined( target ) && is_equal( target.type, "cp_mp_recon_points_exfil_site_entityless" ) )
        {
            scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout( pingindex );
            break;
        }
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2951
// Size: 0x3e
function private function_54f1ae7e02711fc9()
{
    self notify( "wait_gsc_objective_id_ping_removed" );
    self endon( "death_or_disconnect" );
    self endon( "wait_gsc_objective_id_ping_removed" );
    self waittill( "predictiveCalloutClear_" + self.var_3c32c1f7963d00d );
    self.var_3c32c1f7963d00d = undefined;
    self.var_64891db3f3c85d57 = undefined;
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2997
// Size: 0x22f
function private function_2950b8b7b06664d7( params )
{
    level endon( "game_ended" );
    level.var_8571b4c6c544a92c = getdvarint( @"hash_bf8760b03bb33e61", 3 );
    level.var_f08929157ba33935 = "cp_mp_recon_points_exfil_site_entityless";
    level callback::add( "on_exfil_start", &onexfilstart );
    level callback::add( "on_exfil_complete_timeout", &function_b3c36611131bd74a );
    level callback::add( "on_exfil_reset", &onexfilreset );
    level.var_ace7dc473d9a419c = getdvarint( @"hash_9d775aefdae1feca", 1 );
    
    if ( istrue( level.var_ace7dc473d9a419c ) )
    {
        level.var_7c5c009a2bb8fdf0 = getdvarint( @"hash_fa3f338b67619453", 0 );
        level.var_1422423eba8353d6 = getdvarint( @"hash_6dada563188d81ec", 300 );
        level.var_34a7933267810c4 = getdvarint( @"hash_c3bcce1b831ac283", 0 );
        level.var_dae00956e0a3d5c5 = getdvarint( @"hash_9ccf5d0dade47f04", 45 );
        level.var_31f34dcf808ad455 = getdvarint( @"hash_9de7f0c50de4427f", 2000 ) / 0.0254;
        level.var_cafbd8eacf78a549 = getdvarint( @"hash_5d81b35300440f5d", 500 ) / 0.0254;
        level.var_27aad97b556a4fcf = [];
        level thread function_36763cf05948f767();
    }
    
    level flag_wait( "exfil_initialized" );
    level.var_5f9eb8185e287adc = &function_26704c4a43488f1;
    utility::registersharedfunc( "ping", "calloutMarkerPing_markerAdded", &function_7b7d449978e92e60 );
    var_30706430d8caaeb7 = function_8e6454dd6d0cedd3();
    
    foreach ( s_exfil in var_30706430d8caaeb7 )
    {
        if ( !isdefined( s_exfil.var_d182b8d3f3aaa93b ) || !isdefined( s_exfil.var_d182b8d3f3aaa93b.interact ) )
        {
            continue;
        }
        
        s_exfil function_7d5272871e474c76();
        s_exfil.var_d182b8d3f3aaa93b.interact scripts\cp_mp\interaction::function_e6c63f16f2258b80( &function_eed2d218028f84f2 );
        s_exfil thread function_38d627664128e832();
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2bce
// Size: 0xaf
function private function_7d5272871e474c76()
{
    if ( !isdefined( self.var_d182b8d3f3aaa93b ) )
    {
        return;
    }
    
    if ( !is_equal( self.var_d182b8d3f3aaa93b.type, "cp_mp_recon_points_exfil_site_entityless" ) )
    {
        return;
    }
    
    self.objectiveidprimary = function_3472777904abc5b8( "ui_map_icon_extraction_recon_points" );
    self.objectiveidsecondary = function_3472777904abc5b8( "ui_map_icon_extraction_recon_points_disabled" );
    
    foreach ( player in level.players )
    {
        player function_bc9f002d4decfa9e( self );
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2c85
// Size: 0xba
function private function_3472777904abc5b8( markericon )
{
    objectivemarkerid = scripts\mp\objidpoolmanager::requestobjectiveid( 0 );
    scripts\mp\objidpoolmanager::objective_add_objective( objectivemarkerid, "active" );
    scripts\mp\objidpoolmanager::function_bf66c6833e867284( objectivemarkerid, objective_getextractionpointobjectivetype() );
    scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9( objectivemarkerid, 0 );
    scripts\mp\objidpoolmanager::objective_set_play_intro( objectivemarkerid, 0 );
    scripts\mp\objidpoolmanager::objective_set_play_outro( objectivemarkerid, 0 );
    scripts\mp\objidpoolmanager::function_2946e9eb07acb3f1( objectivemarkerid, &"SHARED_HINTSTRINGS/EXFIL" );
    scripts\mp\objidpoolmanager::update_objective_icon( objectivemarkerid, markericon );
    scripts\mp\objidpoolmanager::update_objective_setbackground( objectivemarkerid, 1 );
    scripts\mp\objidpoolmanager::update_objective_setzoffset( objectivemarkerid, 60 );
    scripts\mp\objidpoolmanager::function_c3c6bff089dfdd34( objectivemarkerid, "icon_regular" );
    scripts\mp\objidpoolmanager::update_objective_ownerteam( objectivemarkerid, "neutral" );
    scripts\mp\objidpoolmanager::update_objective_position( objectivemarkerid, self.origin );
    scripts\mp\objidpoolmanager::function_98ba077848896a3( objectivemarkerid, 0 );
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( objectivemarkerid );
    return objectivemarkerid;
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2d48
// Size: 0xd4
function private function_eed2d218028f84f2( usable, player )
{
    if ( isdefined( player ) && istrue( player.interactions_disabled ) )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( isdefined( usable ) && function_9a63dbbe0ab75279( usable ) )
    {
        return { #string:&"SHARED_HINTSTRINGS/EXFIL_START_USE_GENERIC", #type:"HINT_BUTTON" };
    }
    
    var_b68f84bc1bd7a8a5 = player function_33a21b2ea282d115();
    
    if ( var_b68f84bc1bd7a8a5 < level.var_8571b4c6c544a92c )
    {
        return { #string:&"SHARED_HINTSTRINGS/RECON_POINTS_EXFIL_DISABLED", #type:"HINT_BUTTON" };
    }
    
    return { #string:&"SHARED_HINTSTRINGS/RECON_POINTS_EXFIL_ENABLED", #type:"HINT_BUTTON" };
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 0
// Checksum 0x0, Offset: 0x2e24
// Size: 0x43
function function_38d627664128e832()
{
    level endon( "game_ended" );
    self.var_d182b8d3f3aaa93b waittill( "end_exfil_interact_objective_distance" );
    
    if ( !function_4027f5445bb7c8fb( self ) )
    {
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall( self.objectiveidprimary );
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall( self.objectiveidsecondary );
    }
}

// Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
// Params 3
// Checksum 0x0, Offset: 0x2e6f
// Size: 0x41
function function_26704c4a43488f1( var_c1074ab6cac2169f, pingtype, pingindex )
{
    if ( is_equal( self.var_3c32c1f7963d00d, pingindex ) )
    {
        return #"ping_exfil_lz";
    }
    
    return scripts\mp\gametypes\ob::function_1cb9f6a2397a8029( var_c1074ab6cac2169f, pingtype, pingindex );
}

/#

    // Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x2eb9
    // Size: 0xe, Type: dev
    function private initdebug()
    {
        level thread function_5be6f854fd9386d8();
    }

    // Namespace namespace_910f1c9e49a229ca / namespace_dff82f9820538a93
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x2ecf
    // Size: 0xea, Type: dev
    function private function_5be6f854fd9386d8()
    {
        while ( true )
        {
            if ( !isdefined( level.players ) || level.players.size <= 0 )
            {
                waitframe();
                continue;
            }
            
            var_5a2901b28853284c = getdvarint( @"hash_6009a9b7652ef648", 0 );
            
            if ( var_5a2901b28853284c != 0 )
            {
                setdvar( @"hash_6009a9b7652ef648", 0 );
                
                foreach ( player in level.players )
                {
                    player function_14debcad04282fbf( var_5a2901b28853284c );
                }
            }
            
            var_4ef1432760234ab6 = getdvarint( @"hash_ff0ad2ee4fe8a96c", 0 );
            
            if ( var_4ef1432760234ab6 != 0 )
            {
                setdvar( @"hash_ff0ad2ee4fe8a96c", 0 );
                function_ca9c0366894334e8();
            }
            
            waitframe();
        }
    }

#/
