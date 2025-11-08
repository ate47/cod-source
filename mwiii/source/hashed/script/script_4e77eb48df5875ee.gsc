#using script_58fe895fd0fbe620;
#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\cp_mp\overlord;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace namespace_4603f2940296a095;

// Namespace namespace_4603f2940296a095 / namespace_78324ffeb3033698
// Params 1
// Checksum 0x0, Offset: 0x4d1
// Size: 0x35a
function getcontractdata( data )
{
    level.demoprops = spawnstruct();
    level.demoprops.contracttime = getdvarint( @"hash_fde84813012bba7d", 300 );
    level.demoprops.explodetime = getdvarint( @"hash_8d4d8d285e849ccb", 45 );
    level.demoprops.planttime = getdvarint( @"hash_e64f2457394ee5fb", 5 );
    level.demoprops.defusetime = getdvarint( @"hash_6802c4a92950d2e6", 5 );
    assert( isdefined( game[ "<dev string:x1c>" ] ) );
    game[ "dialog" ][ "mission_dom_accept" ] = "mission_mission_dom_accept_secure";
    game[ "dialog" ][ "mission_dom_success" ] = "mission_mission_dom_success";
    level._effect[ "samsite_bomb_explosion" ] = loadfx( "vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx" );
    potentialnodes = array_randomize( getstructarray( "dmz_supply_site", "script_noteworthy" ) );
    var_78e1e12738c48fd3 = [];
    
    foreach ( node in potentialnodes )
    {
        if ( !isdefined( var_78e1e12738c48fd3[ node.poi ] ) )
        {
            var_78e1e12738c48fd3[ node.poi ] = [];
        }
        
        var_78e1e12738c48fd3[ node.poi ][ var_78e1e12738c48fd3[ node.poi ].size ] = node;
    }
    
    level.var_364dc596f40b8927 = [];
    
    foreach ( arr in var_78e1e12738c48fd3 )
    {
        foreach ( node in arr )
        {
            if ( istrue( node.inuse ) )
            {
                continue;
            }
            
            foreach ( othernode in arr )
            {
                if ( node == othernode )
                {
                    continue;
                }
                
                if ( istrue( othernode.inuse ) )
                {
                    continue;
                }
                
                distance = distancesquared( node.origin, othernode.origin );
                
                if ( distance < 4000000 || distance > 144000000 )
                {
                    continue;
                }
                
                node.end = othernode;
                node.inuse = 1;
                othernode.inuse = 1;
                level.var_364dc596f40b8927[ level.var_364dc596f40b8927.size ] = node;
            }
        }
    }
    
    scripts\engine\scriptable::scriptable_addusedcallback( &function_4cadbb00ef649ee1 );
    data.funcs[ "onInit" ] = &function_a5b36afc40a950f8;
    data.funcs[ "onTeamAssigned" ] = &function_914b17f8974317b;
}

// Namespace namespace_4603f2940296a095 / namespace_78324ffeb3033698
// Params 1
// Checksum 0x0, Offset: 0x833
// Size: 0x9c
function function_1044844917e715c5( node )
{
    self.node = node;
    self.end = self.node.end;
    self.node.task = self;
    self.end.task = self;
    level.var_364dc596f40b8927 = array_remove( level.var_364dc596f40b8927, self.node );
    self.node namespace_5ffce5a43b2d1ec2::function_402ebb691260e816();
    self.end namespace_5ffce5a43b2d1ec2::function_402ebb691260e816();
}

// Namespace namespace_4603f2940296a095 / namespace_78324ffeb3033698
// Params 0
// Checksum 0x0, Offset: 0x8d7
// Size: 0x42, Type: bool
function function_a5b36afc40a950f8()
{
    placement = self.tablet function_bc9367aee36e166b();
    self.bombsplanted = 0;
    self.bombsexploded = 0;
    
    if ( !isdefined( placement ) )
    {
        return false;
    }
    
    function_1044844917e715c5( placement );
    return true;
}

// Namespace namespace_4603f2940296a095 / namespace_78324ffeb3033698
// Params 0
// Checksum 0x0, Offset: 0x922
// Size: 0x277
function function_914b17f8974317b()
{
    uiobjectiveshowtoteam( "br_demo_first", self.teams[ 0 ] );
    time = function_9b6275085fbcb8f4( level.demoprops.contracttime );
    
    if ( !isdefined( self.node ) )
    {
        placement = self.tablet function_bc9367aee36e166b();
        
        if ( !isdefined( placement ) )
        {
            return;
        }
        
        function_1044844917e715c5( placement );
    }
    
    self.curorigin = self.node.origin;
    self.offset3d = ( 0, 0, 100 );
    scripts\mp\gameobjects::requestid( 1, 1, undefined, 1 );
    scripts\mp\objidpoolmanager::update_objective_icon( self.objidnum, "ui_map_icon_obj_bomb_collect" );
    var_88bc5ca990516a9f = sortbydistance( [ self.node, self.end ], self.tablet.origin )[ 0 ];
    objective_position( self.objidnum, var_88bc5ca990516a9f.origin + self.offset3d );
    function_bdbeefc9f251434b();
    thread function_b9e2920f98adbe0f( time );
    self.node scripts\mp\gametypes\dmz_task_utils::function_8cd2ac82037f025c( "Hostage_Dmz", self.node.origin, 1000 );
    self.end scripts\mp\gametypes\dmz_task_utils::function_8cd2ac82037f025c( "Hostage_Dmz", self.end.origin, 1000 );
    playersonteam = getteamdata( self.teams[ 0 ], "players" );
    uiobjectiveshowtoteam( "br_demo_first", self.teams[ 0 ] );
    
    foreach ( player in playersonteam )
    {
        player thread scripts\mp\hud_message::showsplash( "br_demolition_quest_start_team" );
        self.node scripts\mp\gametypes\dmz_task_utils::function_1851e9cfb7687f68( player );
        self.end scripts\mp\gametypes\dmz_task_utils::function_1851e9cfb7687f68( player );
    }
    
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "mission_dom_accept", self.teams[ 0 ], 1 );
    self.node thread function_d78aca20601416cd();
    self.end thread function_d78aca20601416cd();
}

// Namespace namespace_4603f2940296a095 / namespace_78324ffeb3033698
// Params 1
// Checksum 0x0, Offset: 0xba1
// Size: 0x66
function function_2b3bf2d2ce4b86ff( success )
{
    self notify( "task_ended" );
    self.ended = 1;
    scripts\mp\gameobjects::releaseid();
    self.node namespace_5ffce5a43b2d1ec2::cleanupbombsite();
    self.end namespace_5ffce5a43b2d1ec2::cleanupbombsite();
    wait 1;
    endcontract( ter_op( istrue( success ), self.teams[ 0 ], undefined ) );
}

// Namespace namespace_4603f2940296a095 / namespace_78324ffeb3033698
// Params 1
// Checksum 0x0, Offset: 0xc0f
// Size: 0x7e
function function_b9e2920f98adbe0f( time )
{
    self endon( "task_ended" );
    level endon( "game_ended" );
    waitframe();
    function_5a15174d34f0670c( time );
    wait time;
    params = spawnstruct();
    params.intvar = 0;
    displayteamsplash( self.teams[ 0 ], "br_demolition_quest_timer_expired", params );
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "mission_gen_fail", self.teams[ 0 ], 1 );
    thread function_2b3bf2d2ce4b86ff( 0 );
}

// Namespace namespace_4603f2940296a095 / namespace_78324ffeb3033698
// Params 0
// Checksum 0x0, Offset: 0xc95
// Size: 0x1d5
function function_d78aca20601416cd()
{
    namespace_5ffce5a43b2d1ec2::function_dda2d720bbb26623();
    self waittill( "bomb_planted" );
    self.task.bombsplanted++;
    playersonteam = getteamdata( self.task.teams[ 0 ], "players" );
    
    if ( self.task.bombsplanted == 2 )
    {
        scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "demolition_second_plant", self.plantplayer.team );
        objective_position( self.task.objidnum, self.plantedbomb.origin + ( 0, 0, 50 ) );
        self.task function_473ab9452660e60f( "br_demo_defend" );
    }
    else if ( self.task.bombsplanted == 1 )
    {
        scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "demolition_first_plant", self.plantplayer.team );
        node = ter_op( self == self.task.node, self.task.end, self.task.node );
        objective_position( self.task.objidnum, node.origin + self.task.offset3d );
        self.task function_473ab9452660e60f( "br_demo_second" );
    }
    
    namespace_5ffce5a43b2d1ec2::function_ebaa4417a40158f5();
    thread function_adb1b940d140cde0();
    thread function_5666e11b17254d43( level.demoprops.explodetime );
}

// Namespace namespace_4603f2940296a095 / namespace_78324ffeb3033698
// Params 0
// Checksum 0x0, Offset: 0xe72
// Size: 0x22b
function function_adb1b940d140cde0()
{
    level endon( "game_ended" );
    self.task endon( "task_ended" );
    self endon( "bomb_exploded" );
    self waittill( "bomb_defused" );
    self.scriptable freescriptable();
    defuseteam = self.defuseplayer.team;
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "demolition_defused_others", defuseteam, 1.5 );
    thread scripts\mp\music_and_dialog::dmz_activity_win( getteamdata( defuseteam, "players" ) );
    planterteam = self.task.teams[ 0 ];
    thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "demolition_defused", planterteam, 1.5 );
    thread scripts\mp\music_and_dialog::dmz_activity_lose( getteamdata( planterteam, "players" ) );
    params = spawnstruct();
    missionid = getquestindex( "br_demo_first" );
    rewardcash = function_d282041688c032b5( "br_demo_first" );
    params.intvar = rewardcash;
    
    foreach ( player in getteamdata( defuseteam, "players" ) )
    {
        player scripts\mp\gametypes\br_plunder::playerplunderpickup( rewardcash );
        player scripts\mp\gametypes\br_plunder::function_5a2284274d70f7d( 1, rewardcash );
    }
    
    rewards = function_d212a5e7a40d7c8d( "demo", defuseteam );
    
    if ( isdefined( rewards ) && isdefined( rewards[ 0 ] ) )
    {
        function_878ebcc241b54505( "br_demolition_quest_complete", function_3d262d56274bd22e( "demo" ), rewards[ 0 ], defuseteam );
    }
    
    function_878ebcc241b54505( "br_demolition_quest_failure", function_3d262d56274bd22e( "demo" ), 0, planterteam );
    displaysquadmessagetoteam( self.task.teams[ 0 ], self.defuseplayer, 8, missionid );
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "mission_dom_success", defuseteam, 1, 1 );
    self.task thread function_2b3bf2d2ce4b86ff( 0 );
    wait 10;
    self.plantedbomb delete();
}

// Namespace namespace_4603f2940296a095 / namespace_78324ffeb3033698
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x10a5
// Size: 0x1d2
function private function_5666e11b17254d43( time )
{
    level endon( "game_ended" );
    self.task endon( "task_ended" );
    self endon( "bomb_defused" );
    namespace_5ffce5a43b2d1ec2::function_b73c05a413966ab2( time );
    namespace_5ffce5a43b2d1ec2::function_accead05b2c47cb7();
    wait 0.1;
    self.task.bombsexploded++;
    namespace_5ffce5a43b2d1ec2::cleanupbombsite();
    team = self.task.teams[ 0 ];
    
    if ( self.task.bombsexploded == 2 )
    {
        thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "demolition_second_exploded", team, 1.5 );
        thread scripts\mp\music_and_dialog::dmz_activity_win( getteamdata( team, "players" ) );
        missionid = getquestindex( "br_demo_first" );
        rewards = function_d212a5e7a40d7c8d( "demo", self.task.teams[ 0 ] );
        
        if ( isdefined( rewards ) && isdefined( rewards[ 0 ] ) )
        {
            function_878ebcc241b54505( "dmz_demo_win", function_3d262d56274bd22e( "demo" ), rewards[ 0 ], self.task.teams[ 0 ] );
        }
        
        displaysquadmessagetoteam( self.task.teams[ 0 ], self.plantplayer, 8, missionid );
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "mission_dom_success", self.task.teams[ 0 ], 1, 1 );
        self.task thread function_2b3bf2d2ce4b86ff( 1 );
        return;
    }
    
    if ( self.task.bombsexploded == 1 )
    {
        thread scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "demolition_first_exploded", team, 1.5 );
        displayteamsplash( team, "dmz_demo_first_explosion" );
    }
}

// Namespace namespace_4603f2940296a095 / namespace_78324ffeb3033698
// Params 6
// Checksum 0x0, Offset: 0x127f
// Size: 0x3dc
function function_4cadbb00ef649ee1( instance, part, state, player, bautouse, usestring )
{
    if ( part != "dmz_supply_site" )
    {
        return;
    }
    
    if ( state == "usable" )
    {
        instance setscriptablepartstate( "dmz_supply_site", "unusable" );
        node = instance.node;
        
        if ( isdefined( node.planting ) && istrue( node.planting ) )
        {
            return;
        }
        
        node.planting = 1;
        bomb = namespace_5ffce5a43b2d1ec2::function_cadc5181c3b67e3f( player );
        thread scripts\mp\gametypes\dmz_task_utils::function_d86771edadba8b4a( node, node, player );
        buttontime = 0;
        
        while ( buttontime < level.demoprops.planttime )
        {
            if ( node.cancel || !isalive( player ) || isdefined( player.fauxdeath ) && player.fauxdeath )
            {
                node.planting = 0;
                namespace_5ffce5a43b2d1ec2::function_db896f4486ca187( player, bomb );
                instance setscriptablepartstate( "dmz_supply_site", "usable" );
                return;
            }
            
            buttontime += level.framedurationseconds;
            waitframe();
        }
        
        namespace_5ffce5a43b2d1ec2::function_db896f4486ca187( player, bomb );
        bombent = spawn( "script_model", player.origin );
        bombent setmodel( "offhand_2h_wm_briefcase_bomb_v0" );
        bombent.visuals = [];
        bombent.visuals[ 0 ] = spawn( "script_model", player.origin );
        bombent.visuals[ 0 ] setmodel( "tag_origin" );
        bombent.curorigin = bombent.origin;
        bombent.offset3d = ( 0, 0, 15 );
        bombent.safeorigin = bombent.origin;
        bombent.trigger = spawnstruct();
        bombent.objidnum = -1;
        bombent scripts\mp\gameobjects::setdropped( undefined, undefined );
        node.plantedbomb = bombent;
        node.plantedbomb.node = node;
        node.bombplanted = 1;
        node.plantplayer = player;
        node notify( "bomb_planted" );
        return;
    }
    
    if ( state == "defusable" )
    {
        instance setscriptablepartstate( "dmz_supply_site", "unusable" );
        node = instance.node;
        
        if ( isdefined( node.defusing ) && istrue( node.defusing ) )
        {
            return;
        }
        
        node.defusing = 1;
        node.plantedbomb hide();
        bomb = namespace_5ffce5a43b2d1ec2::function_cadc5181c3b67e3f( player );
        thread scripts\mp\gametypes\dmz_task_utils::function_d86771edadba8b4a( node, node, player );
        buttontime = 0;
        
        while ( buttontime < level.demoprops.defusetime )
        {
            if ( node.cancel || !isalive( player ) || isdefined( player.fauxdeath ) && player.fauxdeath )
            {
                node.defusing = 0;
                namespace_5ffce5a43b2d1ec2::function_db896f4486ca187( player, bomb );
                node.plantedbomb show();
                instance setscriptablepartstate( "dmz_supply_site", "defusable" );
                return;
            }
            
            buttontime += level.framedurationseconds;
            waitframe();
        }
        
        node notify( "bomb_defused" );
        node.defuseplayer = player;
        namespace_5ffce5a43b2d1ec2::function_db896f4486ca187( player, bomb );
        node.plantedbomb show();
    }
}

// Namespace namespace_4603f2940296a095 / namespace_78324ffeb3033698
// Params 0
// Checksum 0x0, Offset: 0x1663
// Size: 0x14d
function function_bc9367aee36e166b()
{
    var_fdc6ee1b91ebb7bf = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle( self.origin );
    placement = undefined;
    bestlocindex = undefined;
    var_be0f4d48fa40793f = 24000;
    
    foreach ( i, node in level.var_364dc596f40b8927 )
    {
        dist = distance2d( node.origin, self.origin );
        
        if ( dist > var_be0f4d48fa40793f )
        {
            continue;
        }
        
        if ( !level.br_circle_disabled )
        {
            var_28deb7ff62e281d3 = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle( node.origin );
            
            if ( var_28deb7ff62e281d3 < var_fdc6ee1b91ebb7bf )
            {
                continue;
            }
            
            traveltime = dist / 190;
            var_28deb7ff62e281d3 -= traveltime;
            
            if ( var_28deb7ff62e281d3 < 30 )
            {
                continue;
            }
            
            var_5435995e95681b89 = 0;
            
            if ( dist < 8000 )
            {
                if ( dist < 6000 )
                {
                    var_5435995e95681b89 = 6000 - dist;
                }
            }
            else
            {
                var_5435995e95681b89 = dist - 8000;
            }
            
            if ( var_5435995e95681b89 < var_be0f4d48fa40793f )
            {
                var_be0f4d48fa40793f = var_5435995e95681b89;
                bestlocindex = i;
                placement = node;
                
                if ( var_5435995e95681b89 <= 0 )
                {
                    break;
                }
            }
        }
    }
    
    return placement;
}

// Namespace namespace_4603f2940296a095 / namespace_78324ffeb3033698
// Params 0
// Checksum 0x0, Offset: 0x17b9
// Size: 0x93
function function_bdbeefc9f251434b()
{
    objective_showtoplayersinmask( self.objidnum );
    objective_removeallfrommask( self.objidnum );
    
    foreach ( player in getteamdata( self.teams[ 0 ], "players" ) )
    {
        if ( !player scripts\mp\gametypes\br_public::isplayeringulag() )
        {
            objective_addclienttomask( self.objidnum, player );
        }
    }
}

