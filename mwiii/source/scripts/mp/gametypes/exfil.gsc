#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_extract_chopper;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\lightarmor;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\teamrevive;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;

#namespace exfil;

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 0
// Checksum 0x0, Offset: 0x862
// Size: 0x1c
function exfilinit()
{
    level._effect[ "vfx_smk_signal" ] = loadfx( "vfx/_requests/mp_gameplay/vfx_smk_signal" );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 4
// Checksum 0x0, Offset: 0x886
// Size: 0x147
function onexfilstart( winner, getexfilloccallback, var_7c52b433f53d39ee, onexfilkilled )
{
    level.getexfilloccallback = getexfilloccallback;
    level.onexfilfinishedcallback = var_7c52b433f53d39ee;
    level.onexfilkilledcallback = onexfilkilled;
    level.exfilgoaltrigger = getent( winner + "_exfil_trigger", "targetname" );
    level.exfilstarted = 1;
    
    if ( isdefined( level.onexfilstarted ) )
    {
        [[ level.onexfilstarted ]]();
    }
    
    if ( isdefined( level.objectives ) && level.objectives.size > 0 )
    {
        thread removeallobjids();
    }
    
    level.ignorescoring = 1;
    scripts\mp\gamelogic::resumetimer();
    level.starttime = gettime();
    level.discardtime = 0;
    level.timerpausetime = 0;
    timelimit = level.exfilactivetimer + level.exfilextracttimer;
    gamemode = hashcat( @"scr_", getgametype(), "_timelimit" );
    level.watchdvars[ gamemode ].value = timelimit;
    level.overridewatchdvars[ gamemode ] = timelimit;
    runexfil( winner, onexfilkilled );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 0
// Checksum 0x0, Offset: 0x9d5
// Size: 0xa0
function removeallobjids()
{
    foreach ( o in level.objectives )
    {
        if ( isdefined( o.objidnum ) )
        {
            o scripts\mp\gameobjects::releaseid();
        }
        
        if ( isdefined( o.trigger ) && isdefined( o.trigger.objidnum ) )
        {
            o.trigger scripts\mp\gameobjects::releaseid();
        }
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 2
// Checksum 0x0, Offset: 0xa7d
// Size: 0x82
function runexfil( winner, onhelikilled )
{
    level thread scripts\mp\hud_message::notifyteam( "callout_exfil_winners", "callout_exfil_losers", winner );
    level thread spawnexfilzone( winner );
    level thread spawnexfilplayers( winner );
    leaderdialog( "enemy_exfil", getotherteam( winner )[ 0 ], "status" );
    leaderdialog( "friendly_exfil", winner, "status" );
    level.timelimitoverride = 0;
    wait 1;
    level.ontimelimit = &onexfiltimelimit;
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0xb07
// Size: 0x72
function spawnexfilplayers( winner )
{
    gamemode = hashcat( @"scr_", getgametype(), "_numlives" );
    level.watchdvars[ gamemode ].value = 1;
    level.overridewatchdvars[ gamemode ] = 1;
    level notify( "extract_players_spawned" );
    level thread scripts\mp\hud_message::updatematchstatushintforallplayers( winner, "exfil_prevent", "exfil_go" );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 0
// Checksum 0x0, Offset: 0xb81
// Size: 0x8e
function skipkillcamandspawn()
{
    self notify( "abort_killcam" );
    self.cancelkillcam = 1;
    waitframe();
    thread scripts\mp\playerlogic::spawnplayer( 0, 1 );
    
    if ( isteamreviveenabled() && isdefined( level.revivetriggers[ self.guid ] ) )
    {
        level.revivetriggers[ self.guid ].victim thread scripts\mp\teamrevive::removetrigger( level.revivetriggers[ self.guid ].victim.guid );
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0xc17
// Size: 0x456
function spawnexfilzone( winner )
{
    level endon( "game_ended" );
    self endon( "death" );
    var_c8a41ae10dd3b1d2 = getotherteam( winner )[ 0 ];
    
    if ( !isdefined( level.exfilgoaltrigger ) )
    {
        primaryflags = getentarray( "flag_primary", "targetname" );
        triggers = [];
        
        for ( index = 0; index < primaryflags.size ; index++ )
        {
            triggers[ triggers.size ] = primaryflags[ index ];
        }
        
        foreach ( trigger in triggers )
        {
            if ( trigger.script_label == "_b" )
            {
                trigger.script_label = "_b";
                level.exfilgoaltrigger = trigger;
                
                if ( !isdefined( level.exfilgoaltrigger ) )
                {
                    level notify( "exfil_continue_game_end" );
                    return;
                }
            }
        }
    }
    
    level.exfilgoalent = spawn( "script_model", level.exfilgoaltrigger.origin );
    level.exfilgoalent.angles = ( 0, 270, 0 );
    level.exfilgoalent.team = var_c8a41ae10dd3b1d2;
    level.exfilgoalent.visibleteam = "any";
    level.exfilgoalent.ownerteam = var_c8a41ae10dd3b1d2;
    level.exfilgoalent.type = "";
    droppoint = level.exfilgoaltrigger.origin;
    contentoverride = scripts\engine\trace::create_contents( 0, 1, 1, 0, 0, 1, 1 );
    ignoreents = [];
    trace = scripts\engine\trace::ray_trace( level.exfilgoalent.origin + ( 0, 0, 20 ), level.exfilgoalent.origin - ( 0, 0, 4000 ), ignoreents, contentoverride, 0 );
    
    if ( isplayer( trace[ "entity" ] ) )
    {
        trace[ "entity" ] = undefined;
    }
    
    if ( isdefined( trace ) )
    {
        tempangle = randomfloat( 360 );
        droporigin = trace[ "position" ];
        
        if ( isdefined( self.visualgroundoffset ) )
        {
            droporigin += self.visualgroundoffset;
        }
        
        forward = ( cos( tempangle ), sin( tempangle ), 0 );
        forward = vectornormalize( forward - trace[ "normal" ] * vectordot( forward, trace[ "normal" ] ) );
        dropangles = vectortoangles( forward );
        level.exfilgoalent.origin = droporigin;
        level.exfilgoalent setmodel( "cop_marker_scriptable" );
        level.exfilgoalent setscriptablepartstate( "marker", "red" );
        level.exfilgoalent playloopsound( "mp_flare_burn_lp" );
    }
    
    level.exfilgoaltrigger thread goaltriggerwatcher( self );
    level.exfilobjid = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
    
    if ( level.exfilobjid != -1 )
    {
        objectivestate = "current";
        scripts\mp\objidpoolmanager::objective_add_objective( level.exfilobjid, objectivestate, level.exfilgoaltrigger.origin + ( 0, 0, 60 ) );
        scripts\mp\objidpoolmanager::objective_set_play_intro( level.exfilobjid, 1 );
        scripts\mp\objidpoolmanager::objective_set_play_outro( level.exfilobjid, 1 );
        scripts\mp\objidpoolmanager::objective_playermask_showtoall( level.exfilobjid );
        self.showworldicon = 1;
    }
    
    level.exfilgoalent scripts\mp\gameobjects::setobjectivestatusicons( "icon_waypoint_waitfor_exfil", "icon_waypoint_prevent_exfil", level.exfilobjid );
    objective_sethot( level.exfilobjid, 1 );
    level thread watchforexfilactive( winner );
    waitframe();
    playfxontag( level._effect[ "vfx_smk_signal" ], level.exfilgoalent, "tag_origin" );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x1075
// Size: 0x77
function goaltriggerwatcher( player )
{
    level endon( "game_ended" );
    self notify( "trigger_start" );
    self endon( "trigger_start" );
    level waittill( "extract_trigger_active" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( player.team == level.exfilgoalent.team && !istrue( player.extracted ) )
        {
            level thread onexfilsuccess( player );
        }
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x10f4
// Size: 0x72
function watchforexfilactive( winner )
{
    level endon( "game_ended" );
    level thread runexfilnotactivefill( winner );
    level thread runexfilwaitactiveunfill( winner );
    exfilactivetime = level.exfilactivetimer;
    wait exfilactivetime;
    level.exfilnotactive = 0;
    level notify( "extract_trigger_active" );
    level.exfilgoalent scripts\mp\gameobjects::setobjectivestatusicons( "icon_waypoint_active_exfil", "icon_waypoint_prevent_exfil", level.exfilobjid );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x116e
// Size: 0xfb
function runexfilnotactivefill( winner )
{
    level endon( "game_ended" );
    level.exfilnotactive = 1;
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    exfilactivetime = level.exfilactivetimer;
    exfilactivetime *= 1000;
    addtime = updateratems;
    
    while ( level.exfilnotactive )
    {
        if ( addtime != 0 )
        {
            var_5f6264f695308483 = min( addtime / exfilactivetime, 1 );
            scripts\mp\objidpoolmanager::objective_set_progress_team( self.exfilobjid, undefined );
            scripts\mp\objidpoolmanager::objective_show_progress( self.exfilobjid, 1 );
            scripts\mp\objidpoolmanager::objective_set_progress( self.exfilobjid, var_5f6264f695308483 );
            addtime = min( addtime + updateratems, exfilactivetime );
        }
        
        waitframe();
    }
    
    leaderdialog( "exfilarrive_enemy", getotherteam( winner )[ 0 ], "status" );
    leaderdialog( "exfilarrive_friendly", winner, "status" );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x1271
// Size: 0x101
function runexfilwaitactiveunfill( winner )
{
    level endon( "game_ended" );
    level waittill( "extract_trigger_active" );
    level.exfilactive = 1;
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    var_75f51a7eb662fe97 = level.exfilextracttimer;
    var_75f51a7eb662fe97 *= 1000;
    subtime = var_75f51a7eb662fe97 - updateratems;
    
    while ( level.exfilactive )
    {
        var_5f6264f695308483 = subtime / var_75f51a7eb662fe97;
        scripts\mp\objidpoolmanager::objective_set_progress_team( self.exfilobjid, getotherteam( winner )[ 0 ] );
        scripts\mp\objidpoolmanager::objective_show_progress( self.exfilobjid, 1 );
        scripts\mp\objidpoolmanager::objective_set_progress( self.exfilobjid, var_5f6264f695308483 );
        subtime = max( subtime - updateratems, 1 );
        waitframe();
    }
    
    leaderdialog( "exfilend_enemy", getotherteam( winner )[ 0 ], "status" );
    leaderdialog( "exfilend_friendly", winner, "status" );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 2
// Checksum 0x0, Offset: 0x137a
// Size: 0xc4
function switchtoexfilweapons( winner, exfilweapon )
{
    level waittill( "extract_players_spawned" );
    var_c8a41ae10dd3b1d2 = getotherteam( winner )[ 0 ];
    
    if ( var_c8a41ae10dd3b1d2 != "tie" )
    {
        foreach ( p in level.players )
        {
            if ( p.team == var_c8a41ae10dd3b1d2 )
            {
                p takeallweapons();
                p scripts\cp_mp\utility\inventory_utility::_giveweapon( exfilweapon, undefined, undefined, 1 );
                p thread switchtoexfilweapon( exfilweapon );
                p scripts\mp\equipment::giveequipment( "equip_throwing_knife", "primary" );
            }
        }
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x1446
// Size: 0x2b
function switchtoexfilweapon( exfilweapon )
{
    self endon( "death_or_disconnect" );
    self endon( "end_switchToFists" );
    
    while ( domonitoredweaponswitch( exfilweapon, 1 ) == 0 )
    {
        waitframe();
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 0
// Checksum 0x0, Offset: 0x1479
// Size: 0x20
function onexfiltimelimit()
{
    level.exfilactive = 0;
    
    if ( level.exfilactive )
    {
        level notify( "exfil_continue_game_end" );
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x14a1
// Size: 0x115
function onexfilsuccess( player )
{
    level endon( "game_ended" );
    player.extracted = 1;
    player.spawnprotection = 1;
    player scripts\mp\lightarmor::setlightarmorvalue( player, 1000, undefined, 0 );
    player val::group_register( "exfil_success", [ "usability", "offhand_weapons", "killstreaks", "supers", "gesture", "weapon", "weapon_switch" ] );
    player val::group_set( "exfil_success", 0 );
    player thread scripts\mp\hud_message::showsplash( "callout_exfil_success" );
    
    while ( !player isonground() )
    {
        waitframe();
    }
    
    player allowmovement( 0 );
    movetoent = spawn( "script_origin", player.origin );
    movetoent setmodel( "tag_origin" );
    player playerlinkto( movetoent );
    movetoent moveto( movetoent.origin + ( 0, 0, 10000 ), 5, 2, 2 );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x15be
// Size: 0x17
function stopunfillthread( time )
{
    wait time;
    self.exfilactive = 0;
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 3
// Checksum 0x0, Offset: 0x15dd
// Size: 0x251
function assignhelitoexfilpoint( onhelikilled, timeoffsetnum, team )
{
    wait timeoffsetnum + randomint( 10 );
    vehicle = level.players[ 0 ] scripts\mp\gametypes\br_extract_chopper::spawnextractchopper( self, self.origin, onhelikilled, 10 + timeoffsetnum );
    vehicle playloopsound( "br_exfil_lbravo_engine_temp" );
    colmodel = getent( "clip64x64x256", "targetname" );
    colmodelent = spawn( "script_model", vehicle gettagorigin( "tag_origin" ) );
    colmodelent dontinterpolate();
    colmodelent.angles = ( -90, 0, 0 );
    colmodelent clonebrushmodeltoscriptmodel( colmodel );
    var_118e33b11df01435 = anglestoforward( vehicle.angles * ( 1, 0, 0 ) );
    var_2b67713c58007394 = vectornormalize( var_118e33b11df01435 ) * 85;
    colmodelent linkto( vehicle, "tag_origin", var_2b67713c58007394 + ( 0, 0, -60 ), colmodelent.angles );
    vehicle.colmodelent = colmodelent;
    vehicle sethoverparams( 5, 10, 5 );
    self.choppers[ self.choppers.size ] = vehicle;
    vehicle.extractzone = self;
    
    if ( !isdefined( team ) )
    {
        team = self.team;
    }
    
    vehicle.team = team;
    vehicle.exfilspace = 6;
    vehicle.passengers[ 0 ] = self;
    vehicle.passengers[ 1 ] = self;
    vehicle.passengers[ 2 ] = self;
    vehicle.passengers[ 3 ] = self;
    vehicle.passengers[ 4 ] = self;
    vehicle.passengers[ 5 ] = self;
    self.curorigin = self.origin;
    self.offset3d = ( 0, 0, 30 );
    vehicle init_useprompt_interactions();
    thread bugoutontimeout( vehicle );
    vehicle.scene_node = undefined;
    scene_name = undefined;
    vehicle thread exfilpilotactorthink( team, vehicle.scene_node, scene_name );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 0
// Checksum 0x0, Offset: 0x1836
// Size: 0x24
function createextractvfx()
{
    wait 1;
    playfxontag( getfx( "vfx_smk_signal_gr" ), self.vfxent, "tag_origin" );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 4
// Checksum 0x0, Offset: 0x1862
// Size: 0x8b
function exfilpilotactorthink( team, scene_node, scene_name, extra_crew )
{
    level endon( "game_ended" );
    self.actors = thread spawnexfilpilotactors( team, scene_name, extra_crew );
    anim_first_frame( self.actors, "lbravo_exfil", "origin_animate_jnt" );
    hideactors();
    showactors();
    
    if ( isdefined( self.path ) )
    {
        exfilactorthinkpath( team, scene_node, scene_name, extra_crew );
        return;
    }
    
    exfilactorthinkanim( team, scene_node, scene_name, extra_crew );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 4
// Checksum 0x0, Offset: 0x18f5
// Size: 0x4a
function exfilactorthinkpath( team, scene_node, scene_name, extra_crew )
{
    thread exfilactorloopthink( self.actors[ 0 ] );
    thread exfilactorloopthink( self.actors[ 1 ] );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x1947
// Size: 0x25
function exfilactorloopthink( actor )
{
    exfilactorloop( actor );
    anim_single_solo( actor, "lbravo_exfil_loop_exit", "origin_animate_jnt" );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x1974
// Size: 0x2c
function exfilactorloop( actor )
{
    self endon( "unload" );
    
    while ( true )
    {
        anim_single_solo( actor, "lbravo_exfil_loop", "origin_animate_jnt" );
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 4
// Checksum 0x0, Offset: 0x19a8
// Size: 0xc1
function exfilactorthinkanim( team, scene_node, scene_name, extra_crew )
{
    thread anim_single( self.actors, "lbravo_exfil", "origin_animate_jnt" );
    duration = getanimlength( level.scr_anim[ "pilot" ][ "lbravo_exfil" ] );
    wait duration;
    
    foreach ( actor in self.actors )
    {
        actor delete();
    }
    
    self.actors = undefined;
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 3
// Checksum 0x0, Offset: 0x1a71
// Size: 0xac
function spawnexfilpilotactors( team, scene_name, extra_crew )
{
    actors = [];
    actors[ actors.size ] = exfil_spawn_anim_model( "pilot", "origin_animate_jnt", "fullbody_ppilot_crew_a" );
    actors[ actors.size ] = exfil_spawn_anim_model( "copilot", "origin_animate_jnt", "fullbody_ppilot_crew_a" );
    
    foreach ( actor in actors )
    {
        actor.infil = self;
    }
    
    return actors;
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 5
// Checksum 0x0, Offset: 0x1b26
// Size: 0x178
function exfil_spawn_anim_model( animname, linkto_ent, body, head, weapon )
{
    guy = spawn( "script_model", ( 0, 0, 0 ) );
    guy setmodel( body );
    
    if ( isdefined( head ) )
    {
        guy_head = spawn( "script_model", ( 0, 0, 0 ) );
        guy_head setmodel( head );
        guy_head linkto( guy, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        guy.head = guy_head;
        guy thread delete_on_death( guy_head );
    }
    
    if ( isdefined( weapon ) )
    {
        guy_weapon = spawn( "script_model", ( 0, 0, 0 ) );
        guy_weapon setmodel( weapon );
        guy_weapon linkto( guy, "j_gun", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        guy thread delete_on_death( guy_weapon );
        guy.weapon = guy_weapon;
    }
    
    guy.animname = animname;
    guy setanimtree();
    
    if ( isdefined( linkto_ent ) )
    {
        thread delete_on_death( guy );
        guy linkto( self, linkto_ent, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    return guy;
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x1ca7
// Size: 0x54
function bugoutontimeout( heli )
{
    level waittill_any_2( "exfil_continue_game_end", "exfil_on_nuke_arrival" );
    scripts\mp\objidpoolmanager::returnobjectiveid( self.exfilgoalent.exfilobjid );
    thread forcelinkgoaltriggerwatcher( heli );
    heli thread exfilleavesequence( heli.origin );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x1d03
// Size: 0x98
function forcelinkgoaltriggerwatcher( heli )
{
    level endon( "game_ended" );
    self notify( "trigger_start" );
    self endon( "trigger_start" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( player.team == self.exfilgoalent.team && !istrue( player.extracted ) )
        {
            player thread playeranimlinktochopper( heli );
            heli.exfilspace--;
            
            if ( heli.exfilspace <= 0 )
            {
                break;
            }
        }
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 3
// Checksum 0x0, Offset: 0x1da3
// Size: 0x97
function exfilusetriggerused( player, seatnum, var_7838d4d4a6f522d6 )
{
    if ( !isdefined( self.exfilspace ) )
    {
        self.exfilspace = 6;
    }
    
    if ( self.exfilspace > 0 )
    {
        playerlinktochopper( player, self, self.exfilspace );
        thread disableotherseats( player, seatnum, var_7838d4d4a6f522d6 );
        self.exfilspace--;
        return;
    }
    
    thread exfilleavesequence();
    scripts\mp\objidpoolmanager::returnobjectiveid( self.extractzone.exfilgoalent.exfilobjid );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x1e42
// Size: 0xab
function waitforsquadthenleave( player )
{
    teamplayers = level.teamdata[ player.team ][ "players" ];
    
    foreach ( p in teamplayers )
    {
        if ( p != player )
        {
            p thread scripts\mp\utility\print::tutorialprint( "MP_INGAME_ONLY/GET_ON_CHOPPER", 10 );
            continue;
        }
        
        p thread scripts\mp\utility\print::tutorialprint( "MP_INGAME_ONLY/CHOPPER_LEAVING_SOON", 10 );
    }
    
    wait 10;
    thread exfilleavesequence( undefined, 1 );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 3
// Checksum 0x0, Offset: 0x1ef5
// Size: 0x80
function disableotherseats( player, usedseat, var_7838d4d4a6f522d6 )
{
    foreach ( interact in self.interactiontriggers )
    {
        interact disableplayeruse( player );
    }
    
    if ( isdefined( var_7838d4d4a6f522d6 ) )
    {
        player thread enableexitprompt( usedseat, self, var_7838d4d4a6f522d6 );
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 3
// Checksum 0x0, Offset: 0x1f7d
// Size: 0xbd
function enableexitprompt( usedseat, vehicle, var_7838d4d4a6f522d6 )
{
    interaction = spawn( "script_model", self.origin );
    interaction setmodel( "tag_origin" );
    interaction linkto( self );
    interaction sethintstring( &"MP/HOLD_TO_GET_OFF_CHOPPER" );
    interaction setcursorhint( "HINT_NOICON" );
    interaction sethintdisplayrange( 200 );
    interaction sethintdisplayfov( 90 );
    interaction setuserange( 200 );
    interaction setusefov( 360 );
    interaction sethintonobstruction( "hide" );
    interaction setuseholdduration( "duration_short" );
    interaction thread exfil_hopoff_think( vehicle, self, usedseat, var_7838d4d4a6f522d6 );
    vehicle.exitinteract = interaction;
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 4
// Checksum 0x0, Offset: 0x2042
// Size: 0xfb
function exfil_hopoff_think( vehicle, player, usedseat, var_7838d4d4a6f522d6 )
{
    makechopperseatplayerusable( player );
    
    while ( true )
    {
        self waittill( "trigger", player );
        self makeunusable();
        player stopanimscriptsceneevent();
        vehicle anim_player_solo( player, player.player_rig, "lbravo_exfil_loop_exit", "origin_animate_jnt" );
        player.player_rig unlink();
        player unlink();
        var_7838d4d4a6f522d6 makechopperseatteamusable( vehicle.team );
        
        foreach ( interact in vehicle.interactiontriggers )
        {
            interact enableplayeruse( player );
        }
        
        vehicle notify( "unloaded" );
        self delete();
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 3
// Checksum 0x0, Offset: 0x2145
// Size: 0x8c
function playerlinktochopper( player, heli, linktotag )
{
    level endon( "game_ended" );
    player.extracted = 1;
    player.spawnprotection = 1;
    player scripts\mp\lightarmor::setlightarmorvalue( player, 1000, undefined, 0 );
    player thread scripts\mp\hud_message::showsplash( "callout_exfil_success" );
    
    while ( !player isonground() )
    {
        waitframe();
    }
    
    player allowmovement( 0 );
    player playerlinkto( heli, "tag_passenger" + linktotag, 1, 180, -180, 180, 180, 0 );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 2
// Checksum 0x0, Offset: 0x21d9
// Size: 0x1f8
function playeranimlinktochopper( exfil, spot_index )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "player_free_spot" );
    self endon( "joined_team" );
    
    if ( !isdefined( spot_index ) )
    {
        for ( i = 0; i < exfil.passengers.size ; i++ )
        {
            if ( exfil.passengers[ i ] == exfil.extractzone )
            {
                exfil.passengers[ i ] = self;
                spot_index = i;
            }
        }
        
        exfil thread disableotherseats( self );
    }
    
    thread infil_player_rig( "slot_" + spot_index, "viewhands_base_iw8" );
    self.player_rig linkto( exfil, "origin_animate_jnt", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    switch ( spot_index )
    {
        case 0:
            self lerpviewangleclamp( 1, 0.25, 0.25, 35, 180, 90, 45 );
            break;
        case 1:
            self lerpviewangleclamp( 1, 0.25, 0.25, 180, 35, 90, 45 );
            break;
        case 2:
        case 4:
            self lerpviewangleclamp( 1, 0.25, 0.25, 75, 135, 90, 45 );
            break;
        case 3:
        case 5:
            self lerpviewangleclamp( 1, 0.25, 0.25, 135, 45, 90, 45 );
            break;
        default:
            self lerpviewangleclamp( 1, 0.25, 0.25, 45, 45, 45, 45 );
            break;
    }
    
    level endon( "game_ended" );
    self.extracted = 1;
    self.spawnprotection = 1;
    scripts\mp\lightarmor::setlightarmorvalue( self, 1000, undefined, 0 );
    rideloop( exfil );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x23d9
// Size: 0x52
function rideloop( exfil )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "player_free_spot" );
    self endon( "joined_team" );
    exfil endon( "unload" );
    
    while ( isdefined( exfil ) )
    {
        exfil anim_player_solo( self, self.player_rig, "lbravo_exfil_loop", "origin_animate_jnt" );
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 2
// Checksum 0x0, Offset: 0x2433
// Size: 0x86
function exfilleavesequence( nukeposition, endgame )
{
    if ( isdefined( self.exitinteract ) )
    {
        self.exitinteract makeunusable();
    }
    
    thread scripts\mp\gametypes\br_extract_chopper::littlebirdleave();
    playannouncerbattlechatter( self.team, "extract_littlebird_leaving_a_friendly", 10 );
    thread doexfilsplashforpassengers();
    
    if ( isdefined( level.onexfilfinishedcallback ) )
    {
        self [[ level.onexfilfinishedcallback ]]( nukeposition );
    }
    
    if ( isdefined( endgame ) )
    {
        waitthenendgame( self.team );
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x24c1
// Size: 0x24
function waitthenendgame( winningteam )
{
    wait 5;
    thread scripts\mp\gamelogic::endgame( winningteam, game[ "end_reason" ][ "objective_completed" ] );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 0
// Checksum 0x0, Offset: 0x24ed
// Size: 0x57
function doexfilsplashforpassengers()
{
    wait 1;
    
    for ( i = 0; i < self.passengers.size ; i++ )
    {
        if ( self.passengers[ i ] != self.extractzone )
        {
            self.passengers[ i ] thread scripts\mp\hud_message::showsplash( "callout_exfil_success" );
        }
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x254c
// Size: 0xfa
function init_useprompt_interactions( player )
{
    self.interactiontriggers = [];
    pos1 = self gettagorigin( "tag_passenger1" );
    pos2 = self gettagorigin( "tag_passenger2" );
    pos3 = self gettagorigin( "tag_passenger3" );
    pos4 = self gettagorigin( "tag_passenger4" );
    pos5 = self gettagorigin( "tag_passenger5" );
    pos6 = self gettagorigin( "tag_passenger6" );
    create_exfil_interaction( pos1, &"MP/HOLD_TO_GET_ON_CHOPPER", 0, player );
    create_exfil_interaction( pos2, &"MP/HOLD_TO_GET_ON_CHOPPER", 2, player );
    create_exfil_interaction( pos3, &"MP/HOLD_TO_GET_ON_CHOPPER", 4, player );
    create_exfil_interaction( pos4, &"MP/HOLD_TO_GET_ON_CHOPPER", 1, player );
    create_exfil_interaction( pos5, &"MP/HOLD_TO_GET_ON_CHOPPER", 3, player );
    create_exfil_interaction( pos6, &"MP/HOLD_TO_GET_ON_CHOPPER", 5, player );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 4
// Checksum 0x0, Offset: 0x264e
// Size: 0xc0
function create_exfil_interaction( loc, hintstring, seatnum, player )
{
    interaction = spawn( "script_model", loc );
    interaction setmodel( "tag_origin" );
    interaction linkto( self );
    interaction sethintstring( hintstring );
    interaction setcursorhint( "HINT_BUTTON" );
    interaction sethintdisplayrange( 200 );
    interaction sethintdisplayfov( 90 );
    interaction setuserange( 72 );
    interaction setusefov( 90 );
    interaction sethintonobstruction( "hide" );
    interaction setuseholdduration( "duration_short" );
    interaction thread exfil_use_think( self, seatnum, player );
    self.interactiontriggers[ self.interactiontriggers.size ] = interaction;
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 3
// Checksum 0x0, Offset: 0x2716
// Size: 0x61
function exfil_use_think( vehicle, seatnum, player )
{
    if ( isdefined( player ) )
    {
        makechopperseatplayerusable( player );
    }
    else
    {
        makechopperseatteamusable( vehicle.team );
    }
    
    while ( true )
    {
        self waittill( "trigger", player );
        self makeunusable();
        vehicle exfilusetriggerused( player, seatnum, self );
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x277f
// Size: 0x1b
function makechopperseatteamusable( team )
{
    self makeusable();
    thread _updatechopperseatteamusable( team );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x27a2
// Size: 0x1b
function makechopperseatplayerusable( player )
{
    self makeusable();
    thread _updatechopperseatplayerusable( player );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x27c5
// Size: 0x9c
function _updatechopperseatteamusable( team )
{
    self endon( "death" );
    
    for ( ;; )
    {
        foreach ( player in level.players )
        {
            if ( player.team == team )
            {
                self showtoplayer( player );
                self enableplayeruse( player );
                continue;
            }
            
            self disableplayeruse( player );
            self hidefromplayer( player );
        }
        
        level waittill( "joined_team" );
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 1
// Checksum 0x0, Offset: 0x2869
// Size: 0x92
function _updatechopperseatplayerusable( useplayer )
{
    self endon( "death" );
    
    for ( ;; )
    {
        foreach ( player in level.players )
        {
            if ( player == useplayer )
            {
                self showtoplayer( player );
                self enableplayeruse( player );
                continue;
            }
            
            self disableplayeruse( player );
            self hidefromplayer( player );
        }
        
        level waittill( "joined_team" );
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 3
// Checksum 0x0, Offset: 0x2903
// Size: 0xc5
function playannouncerbattlechatter( team, soundname, suffix )
{
    level endon( "game_ended" );
    faction = "ustl";
    soundalias = "dx_mpa_" + faction + "_" + soundname + "_" + suffix;
    
    if ( soundexists( soundalias ) )
    {
        foreach ( player in level.players )
        {
            if ( player.team == team )
            {
                player queuedialogforplayer( soundalias, soundname, 2 );
            }
        }
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 0
// Checksum 0x0, Offset: 0x29d0
// Size: 0x26
function votimeendingsoon()
{
    level endon( "game_ended" );
    level waittill( "match_ending_very_soon" );
    playannouncerbattlechatter( game[ "attackers" ], "extract_littlebird_leaving_soon_a_friendly", 10 );
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 3
// Checksum 0x0, Offset: 0x29fe
// Size: 0x7a
function commander_play_sound_func( alias, notification, stoppable )
{
    foreach ( player in self.infil.players )
    {
        self playsoundtoplayer( alias, player );
    }
}

// Namespace exfil / scripts\mp\gametypes\exfil
// Params 0
// Checksum 0x0, Offset: 0x2a80
// Size: 0x2
function script_model_exfil_anims()
{
    
}

