#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\vehicle_paths;
#using scripts\cp\cp_anim;
#using scripts\cp\cp_infilexfil;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\globallogic;
#using scripts\cp\infilexfil\infilexfil;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\utility\infilexfil;

#namespace lbravo_infil_cp;

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 1
// Checksum 0x0, Offset: 0x994
// Size: 0x8d
function lbravo_init( subtype )
{
    /#
        setdevdvarifuninitialized( @"hash_3dc902e1a71dd25d", 0 );
    #/
    
    initanims( subtype );
    var_453e4fc2c649fea4 = [];
    var_453e4fc2c649fea4[ 0 ] = [ 0, 1 ];
    var_453e4fc2c649fea4[ 1 ] = [ 4, 5 ];
    var_453e4fc2c649fea4[ 2 ] = [ 2 ];
    var_453e4fc2c649fea4[ 3 ] = [ 3 ];
    infil_add( "infil_lbravo", subtype, 6, 4, var_453e4fc2c649fea4, &lbravo_spawn, &lbravo_get_length, &player_lbravo_infil_think );
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 3
// Checksum 0x0, Offset: 0xa29
// Size: 0x130
function lbravo_spawn( team, target, subtype )
{
    scene_node = getstruct( target, "targetname" );
    infil = spawn( "script_origin", scene_node.origin );
    infil.angles = scene_node.angles;
    infil.scene_node = scene_node;
    infil.subtype = subtype;
    infil.allow_fire = 0;
    
    if ( getdvarint( @"hash_34af8ca56a01ed17", 0 ) > 0 )
    {
        infil.allow_fire = getdvarint( @"hash_34af8ca56a01ed17" );
    }
    
    if ( isdefined( scene_node.target ) )
    {
        infil.path = getstruct( "lbravoAlphaAdvancedPath", "targetname" );
    }
    
    if ( isdefined( scene_node.script_label ) )
    {
        infil.exit_path = getstruct( scene_node.script_label, "targetname" );
    }
    
    infil thread infilthink( team, subtype );
    level.infil_struct = infil;
    return infil;
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 1
// Checksum 0x0, Offset: 0xb62
// Size: 0xe1
function lbravo_get_length( subtype )
{
    if ( isdefined( self.path ) )
    {
        duration = parsepathlength();
        duration += getanimlength( level.scr_anim[ "slot_0" ][ "lbravo_infil" + "_" + subtype + "_loop_exit" ] );
        duration += getanimlength( level.scr_anim[ "slot_0" ][ "lbravo_infil" + "_" + subtype + "_exit" ] );
        return duration;
    }
    
    animlength = getanimlength( level.scr_anim[ "slot_0" ][ "lbravo_infil" + "_" + subtype ] );
    animlength += getanimlength( level.scr_anim[ "slot_0" ][ "lbravo_infil" + "_" + subtype + "_exit" ] );
    return animlength;
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 2
// Checksum 0x0, Offset: 0xc4b
// Size: 0x46a
function player_lbravo_infil_think( infil, spot_index )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "player_free_spot" );
    self endon( "joined_team" );
    scripts\cp\cp_outofbounds::enableoobimmunity( self );
    
    if ( getdvarint( @"hash_a7f868995fc7d3", -1 ) >= 0 )
    {
        spot_index = getdvarint( @"hash_a7f868995fc7d3", -1 );
    }
    
    if ( isplayer( self ) )
    {
        self setclienttriggeraudiozone( "cp_obsv_heli_infil", 1 );
        allow_player_ignore_me( 1 );
    }
    
    thread player_infil_end( infil );
    
    if ( istrue( infil.allow_fire ) )
    {
        player_xanim = level.scr_anim[ infil.linktoent.animname ][ "lbravo_infil" + "_" + infil.subtype ];
        var_4a5e5c0f661ee5e2 = getstartorigin( infil.linktoent.origin, infil.linktoent.angles, player_xanim );
        var_70a3110ec679bbc8 = getstartangles( infil.linktoent.origin, infil.linktoent.angles, player_xanim );
        var_4a5e5c0f661ee5e2 -= infil.linktoent.origin;
        var_d95a174b2292916d = ( 0, 0, 0 );
        var_a2259b9f41f55197 = ( 0, 0, 0 );
        
        switch ( spot_index )
        {
            case 0:
                var_d95a174b2292916d = ( 47, 60, -106 );
                var_a2259b9f41f55197 = ( 10, 90, 0 );
                break;
            case 1:
                var_d95a174b2292916d = ( 47, -60, -106 );
                var_a2259b9f41f55197 = ( 10, 90, 0 );
                break;
        }
        
        var_77e029a941c20b53 = spawn_tag_origin( var_4a5e5c0f661ee5e2, var_70a3110ec679bbc8 );
        var_77e029a941c20b53 linkto( infil.linktoent, "tag_origin_animate", var_4a5e5c0f661ee5e2 + var_d95a174b2292916d, var_70a3110ec679bbc8 + var_a2259b9f41f55197 );
        self playerlinkto( var_77e029a941c20b53, "tag_origin", 1, 180, 180, 90, 90 );
        self setdemeanorviewmodel( "normal" );
        self [[ level.prematchallowfunc ]]( 0 );
    }
    else
    {
        thread infil_player_rig( "slot_" + spot_index, "viewhands_base_iw8" );
        self.player_rig.weapon_state_func = &handleweaponstatenotetrackcp;
        self.player_rig linkto( infil.linktoent, "tag_origin_animate", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        self setdemeanorviewmodel( "safe", "iw8_ges_demeanor_safe_heli" );
    }
    
    self.var_3a44c5bc4019f640 = infil.linktoent.origin;
    self function_b88c89bb7cd1ab8e( infil.linktoent.origin );
    self lerpfovbypreset( "80_instant" );
    self lerpfovscalefactor( 0, 0 );
    thread infil_scene_fade_in( 0, 1.55, "fade_up" );
    thread player_van_disconnect();
    
    if ( !gameflag( "infil_started" ) )
    {
        waittill_any_ents( level, "start_scene", infil, "start_scene" );
    }
    else
    {
        wait 0.05;
    }
    
    /#
        if ( !istrue( infil.allow_fire ) )
        {
            println( "<dev string:x1c>" + self.name + "<dev string:x51>" + self.animname + "<dev string:x5e>" + isdefined( self.player_rig ) );
        }
    #/
    
    if ( isdefined( self.team ) && self.team != "spectator" )
    {
        self setsoundsubmix( "iw9_cp_obsv_infil_heli" );
    }
    
    self.is_doing_infil = 1;
    
    if ( !istrue( level.var_85af047f9154dc4c ) )
    {
        self notify( "open_loadout_menu" );
    }
    
    self notify( "fade_up" );
    self setcinematicmotionoverride( "disabled" );
    
    if ( isdefined( infil.path ) )
    {
        thread playerthinkpath( infil, spot_index );
    }
    else
    {
        thread playerthinkanim( infil, spot_index );
    }
    
    self lerpfovbypreset( "default" );
    scripts\cp\globallogic::function_db31ae430d191461( 1 );
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 2
// Checksum 0x0, Offset: 0x10bd
// Size: 0x221
function playerthinkpath( infil, spot_index )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "player_free_spot" );
    self endon( "joined_team" );
    
    if ( spot_index == 0 )
    {
        if ( istrue( infil.allow_fire ) )
        {
            self lerpviewangleclamp( 1, 0.25, 0.25, 15, 100, 45, 30 );
        }
        else
        {
            self lerpviewangleclamp( 1, 0.25, 0.25, 10, 45, 45, 30 );
        }
    }
    else if ( spot_index == 1 )
    {
        if ( istrue( infil.allow_fire ) )
        {
            self lerpviewangleclamp( 1, 0.25, 0.25, 100, 15, 45, 30 );
        }
        else
        {
            self lerpviewangleclamp( 1, 0.25, 0.25, 45, 10, 45, 30 );
        }
    }
    else
    {
        self lerpviewangleclamp( 1, 0.25, 0.25, 45, 45, 45, 30 );
    }
    
    rideloop( infil );
    
    if ( self islinked() )
    {
        self lerpviewangleclamp( 1, 0.25, 0.25, 0, 0, 0, 0 );
        self lerpfovbypreset( "default_2seconds" );
        self lerpfovscalefactor( 1, 2 );
    }
    
    self stopanimscriptsceneevent();
    self setcinematicmotionoverride( "iw9_playermotion" );
    
    if ( isdefined( self.player_rig ) )
    {
        self.player_rig unlink();
    }
    
    if ( isdefined( self.var_3a44c5bc4019f640 ) )
    {
        self clearpredictedstreampos();
        self.var_3a44c5bc4019f640 = undefined;
    }
    
    if ( istrue( infil.allow_fire ) && self islinked() )
    {
        self [[ level.prematchallowfunc ]]( 1 );
        self playerunlinkblend( 1 );
    }
    
    self.is_doing_infil = undefined;
    self notify( "player_finished_infil" );
    scripts\cp\cp_outofbounds::disableoobimmunity( self );
    self setdemeanorviewmodel( "normal" );
    self stopviewmodelanim();
    takegunlesscp();
    self setstance( "stand" );
    scripts\cp\globallogic::function_db31ae430d191461( 0 );
    self clearsoundsubmix( "iw9_cp_obsv_infil_heli" );
    infil notify( "prematch_over" );
    level notify( "prematch_over" );
    flag_set( "infil_over" );
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 1
// Checksum 0x0, Offset: 0x12e6
// Size: 0xa5
function rideloop( infil )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "player_free_spot" );
    self endon( "joined_team" );
    infil.linktoent endon( "unload" );
    
    if ( istrue( infil.allow_fire ) )
    {
        while ( true )
        {
            wait 60;
        }
        
        return;
    }
    
    while ( true )
    {
        infil.linktoent anim_player_solo( self, self.player_rig, "lbravo_infil" + "_" + infil.subtype + "_loop", "tag_origin_animate" );
    }
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 2
// Checksum 0x0, Offset: 0x1393
// Size: 0x1fd
function playerthinkanim( infil, spot_index )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "player_free_spot" );
    self endon( "joined_team" );
    
    if ( istrue( infil.allow_fire ) )
    {
        println( "<dev string:x66>" + self.name );
        self lerpviewangleclamp( 1, 0.25, 0.25, 90, 90, 90, 90 );
        infil.linktoent waittill( "unload" );
        self [[ level.prematchallowfunc ]]( 1 );
    }
    else
    {
        println( "<dev string:xa3>" + self.name + "<dev string:x51>" + self.animname + "<dev string:x5e>" + isdefined( self.player_rig ) );
        self lerpviewangleclamp( 1, 0.25, 0.25, 30, 30, 30, 30 );
        infil.linktoent anim_player_solo( self, self.player_rig, "lbravo_infil" + "_" + infil.subtype, "tag_origin_animate" );
    }
    
    println( "<dev string:xe0>" + self.name + "<dev string:x51>" + self.animname + "<dev string:x5e>" + isdefined( self.player_rig ) );
    self lerpviewangleclamp( 1, 0.25, 0.25, 0, 0, 0, 0 );
    self.player_rig unlink();
    self setdemeanorviewmodel( "normal" );
    self stopviewmodelanim();
    takegunlesscp();
    self clearsoundsubmix( "iw9_cp_obsv_infil_heli" );
    infil notify( "prematch_over" );
    level notify( "prematch_over" );
    flag_set( "infil_over" );
    thread scriptswitchweaponhack();
    thread clear_infil_ambient_zone();
    self visionsetnakedforplayer( "", 0.75 );
    self setdemeanorviewmodel( "normal" );
    self clearcinematicmotionoverride();
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 0
// Checksum 0x0, Offset: 0x1598
// Size: 0xb
function scriptswitchweaponhack()
{
    waitframe();
    self notify( "complete_late_infil_allows" );
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 0
// Checksum 0x0, Offset: 0x15ab
// Size: 0xe
function clear_infil_ambient_zone()
{
    wait 1;
    self clearclienttriggeraudiozone( 2 );
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 1
// Checksum 0x0, Offset: 0x15c1
// Size: 0x48
function player_infil_end( infil )
{
    self endon( "disconnect" );
    waittill_any_ents( level, "prematch_over", infil, "prematch_over" );
    self notify( "remove_rig" );
    self clearclienttriggeraudiozone( 1 );
    allow_player_ignore_me( 0 );
    scripts\cp\utility\player::setdof_default();
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 0
// Checksum 0x0, Offset: 0x1611
// Size: 0x66
function player_van_disconnect()
{
    level endon( "prematch_over" );
    waittill_either( "death", "disconnect" );
    
    if ( isdefined( self ) )
    {
        self visionsetnakedforplayer( "" );
        self clearclienttriggeraudiozone( 0 );
        self lerpfovbypreset( "default" );
        self lerpfovscalefactor( 1, 0 );
        self setviewmodeldepthoffield( 0, 0, 18 );
        scripts\cp\utility\player::setdof_default();
    }
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 2
// Checksum 0x0, Offset: 0x167f
// Size: 0x127
function infilthink( team, scene_name )
{
    level endon( "game_ended" );
    
    foreach ( ent in getentarray( "infil_delete", "script_noteworthy" ) )
    {
        ent delete();
    }
    
    thread vehiclethink( team, self.scene_node, scene_name );
    thread actorthink( team, self.scene_node, scene_name );
    waittill_any_ents( level, "infil_started", self, "infil_started" );
    setdvar( @"r_spotlightentityshadows", 1 );
    level notify( "start_scene" );
    self notify( "start_scene" );
    duration = lbravo_get_length( scene_name );
    wait duration;
    waittill_any_ents( level, "prematch_over", self, "prematch_over" );
    setdvar( @"r_spotlightentityshadows", 0 );
    
    while ( isdefined( self.linktoent ) || isdefined( self.actors ) )
    {
        waitframe();
    }
    
    self delete();
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 4
// Checksum 0x0, Offset: 0x17ae
// Size: 0x64
function vehiclethink( team, scene_node, scene_name, extra_crew )
{
    level endon( "game_ended" );
    self.linktoent = spawninfilvehicle( scene_node, team, scene_name );
    
    if ( isdefined( self.path ) )
    {
        thread vehiclethinkpath( team, scene_node, scene_name, extra_crew );
        return;
    }
    
    thread vehiclethinkanim( team, scene_node, scene_name, extra_crew );
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 4
// Checksum 0x0, Offset: 0x181a
// Size: 0xc7
function vehiclethinkanim( team, scene_node, scene_name, extra_crew )
{
    anim_first_frame_solo( self.linktoent, "lbravo_infil" + "_" + scene_name );
    waittill_any_ents( level, "infil_started", self, "infil_started" );
    thread anim_single_solo( self.linktoent, "lbravo_infil" + "_" + scene_name );
    duration = getanimlength( level.scr_anim[ self.linktoent.animname ][ "lbravo_infil" + "_" + scene_name ] );
    wait duration;
    self.linktoent delete();
    self.linktoent = undefined;
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 3
// Checksum 0x0, Offset: 0x18e9
// Size: 0x172
function spawninfilvehicle( scene_node, team, scene_name )
{
    spawnpos = scene_node.origin;
    spawnang = scene_node.angles;
    
    if ( isdefined( self.path ) )
    {
        spawnpos = self.path.origin;
        spawnang = self.path.angles;
    }
    
    spawnpoint = spawnstruct();
    spawnpoint.origin = spawnpos;
    spawnpoint.angles = spawnang;
    spawnpoint.vehicletype = "veh9_mil_air_heli_medium_physics_mp";
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( "little_bird", spawnpoint );
    vehicle function_247ad6a91f6a4ffe( 1 );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable( vehicle );
    vehicle.spawnpoint = spawnpoint;
    vehicle setvehicleteam( team );
    vehicle.animname = "lbravo";
    vehicle setcandamage( 0 );
    vehicle setscriptablepartstate( "engine", "on", 0 );
    vehicle.infil = self;
    vehicle ent_flag_init( "unloaded" );
    vehicle ent_flag_init( "loaded" );
    vehicle.riders = [];
    
    if ( isdefined( level.spawn_infil_lbravo ) )
    {
        level thread [[ level.spawn_infil_lbravo ]]( vehicle );
    }
    
    return vehicle;
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 4
// Checksum 0x0, Offset: 0x1a64
// Size: 0x15d
function actorthink( team, scene_node, scene_name, extra_crew )
{
    level endon( "game_ended" );
    self.actors = spawnactors( team, scene_name, extra_crew );
    self.actors[ 0 ].anim_playsound_func = &commander_play_sound_func;
    
    if ( isdefined( self.linktoent.var_1592c4b325ffff4 ) )
    {
        self.linktoent.var_1592c4b325ffff4 anim_first_frame( [ self.actors[ 0 ] ], "lbravo_infil" + "_" + scene_name, self.actors[ 0 ].var_1fef77784cb19c0b );
        self.linktoent.var_1592c4b325ffff4 anim_first_frame( [ self.actors[ 1 ] ], "lbravo_infil" + "_" + scene_name, self.actors[ 1 ].var_1fef77784cb19c0b );
    }
    else
    {
        logprint( "**Warning: Pilot anim not loaded for infil." );
    }
    
    hideactors();
    waittill_any_ents( level, "infil_started", self, "infil_started" );
    showactors();
    
    if ( isdefined( self.path ) )
    {
        actorthinkpath( team, scene_node, scene_name, extra_crew );
        return;
    }
    
    actorthinkanim( team, scene_node, scene_name, extra_crew );
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 4
// Checksum 0x0, Offset: 0x1bc9
// Size: 0x4a
function actorthinkpath( team, scene_node, scene_name, extra_crew )
{
    if ( isdefined( level.lbravo_actorthinkpath ) )
    {
        level thread [[ level.lbravo_actorthinkpath ]]( self );
        return;
    }
    
    actorthinkpath_default( self );
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 1
// Checksum 0x0, Offset: 0x1c1b
// Size: 0x38
function actorthinkpath_default( infil )
{
    infil thread actorloopthink( infil.actors[ 0 ] );
    infil thread actorloopthink( infil.actors[ 1 ] );
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 1
// Checksum 0x0, Offset: 0x1c5b
// Size: 0x54
function actorloopthink( actor )
{
    actorloop( actor );
    self.linktoent.var_1592c4b325ffff4 anim_single_solo( actor, "lbravo_infil" + "_" + self.subtype + "_loop_exit", actor.var_1fef77784cb19c0b );
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 1
// Checksum 0x0, Offset: 0x1cb7
// Size: 0x69
function actorloop( actor )
{
    self.linktoent endon( "unload" );
    
    while ( true )
    {
        self.linktoent.var_1592c4b325ffff4 anim_single_solo( actor, "lbravo_infil" + "_" + self.subtype + "_loop", actor.var_1fef77784cb19c0b );
        wait 0.05;
    }
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 4
// Checksum 0x0, Offset: 0x1d28
// Size: 0xd8
function actorthinkanim( team, scene_node, scene_name, extra_crew )
{
    self.linktoent thread anim_single( self.actors, "lbravo_infil" + "_" + scene_name, "tag_origin_animate" );
    duration = getanimlength( level.scr_anim[ "pilot" ][ "lbravo_infil" + "_" + scene_name ] );
    wait duration;
    
    foreach ( actor in self.actors )
    {
        actor delete();
    }
    
    self.actors = undefined;
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 3
// Checksum 0x0, Offset: 0x1e08
// Size: 0x1f8
function spawnactors( team, scene_name, extra_crew )
{
    actors = [];
    var_5e4fb41f759ab359 = self.linktoent gettagorigin( "tag_pilot1" ) + rotatevector( ( -28, -15, 62 ), self.linktoent.angles );
    var_a762931b3f542116 = self.linktoent gettagorigin( "tag_pilot2" ) + rotatevector( ( -28, 15, 62 ), self.linktoent.angles );
    self.linktoent.var_1592c4b325ffff4 = spawn_tag_origin( var_5e4fb41f759ab359, self.linktoent.angles );
    self.linktoent.var_1592c4b325ffff4 linkto( self.linktoent );
    self.linktoent.var_1592f4b3260068d = spawn_tag_origin( var_a762931b3f542116, self.linktoent.angles );
    self.linktoent.var_1592f4b3260068d linkto( self.linktoent );
    actors[ actors.size ] = self.linktoent.var_1592c4b325ffff4 spawn_anim_model( "pilot", "tag_origin", "allied_pilot_fullbody_1" );
    actors[ actors.size ] = self.linktoent.var_1592f4b3260068d spawn_anim_model( "copilot", "tag_origin", "allied_pilot_fullbody_2" );
    
    foreach ( actor in actors )
    {
        actor.infil = self;
    }
    
    return actors;
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 5
// Checksum 0x0, Offset: 0x2009
// Size: 0x187
function spawn_anim_model( animname, linkto_ent, body, head, weapon )
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
        guy.var_1fef77784cb19c0b = linkto_ent;
    }
    
    return guy;
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 1
// Checksum 0x0, Offset: 0x2199
// Size: 0x4ef
function initanims( subtype )
{
    script_model_alpha_anims( subtype );
    vehicles_alpha_anims( subtype );
    addnotetrack_customfunction( "slot_0", "free_look", &player_free_look, "lbravo_infil_alpha_exit" );
    addnotetrack_customfunction( "slot_1", "free_look", &player_free_look, "lbravo_infil_alpha_exit" );
    addnotetrack_customfunction( "slot_2", "free_look", &player_free_look, "lbravo_infil_alpha_exit" );
    addnotetrack_customfunction( "slot_3", "free_look", &player_free_look, "lbravo_infil_alpha_exit" );
    addnotetrack_customfunction( "slot_4", "free_look", &player_free_look, "lbravo_infil_alpha_exit" );
    addnotetrack_customfunction( "slot_5", "free_look", &player_free_look, "lbravo_infil_alpha_exit" );
    addnotetrack_customfunction( "slot_0", "free_look", &player_free_look, "lbravo_infil_bravo_exit" );
    addnotetrack_customfunction( "slot_1", "free_look", &player_free_look, "lbravo_infil_bravo_exit" );
    addnotetrack_customfunction( "slot_2", "free_look", &player_free_look, "lbravo_infil_bravo_exit" );
    addnotetrack_customfunction( "slot_3", "free_look", &player_free_look, "lbravo_infil_bravo_exit" );
    addnotetrack_customfunction( "slot_4", "free_look", &player_free_look, "lbravo_infil_bravo_exit" );
    addnotetrack_customfunction( "slot_5", "free_look", &player_free_look, "lbravo_infil_bravo_exit" );
    addnotetrack_customfunction( "slot_0", "fov_80_instant", &player_fov_80_instant );
    addnotetrack_customfunction( "slot_1", "fov_80_instant", &player_fov_80_instant );
    addnotetrack_customfunction( "slot_2", "fov_80_instant", &player_fov_80_instant );
    addnotetrack_customfunction( "slot_3", "fov_80_instant", &player_fov_80_instant );
    addnotetrack_customfunction( "slot_4", "fov_80_instant", &player_fov_80_instant );
    addnotetrack_customfunction( "slot_5", "fov_80_instant", &player_fov_80_instant );
    addnotetrack_customfunction( "slot_0", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_1", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_2", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_3", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_4", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_5", "fov_63_2", &player_fov_default_2 );
    addnotetrack_customfunction( "slot_0", "shake_on", &cam_shake_low, "lbravo_infil_alpha" );
    addnotetrack_customfunction( "slot_1", "shake_on", &cam_shake_low, "lbravo_infil_alpha" );
    addnotetrack_customfunction( "slot_2", "shake_on", &cam_shake_low, "lbravo_infil_alpha" );
    addnotetrack_customfunction( "slot_3", "shake_on", &cam_shake_low, "lbravo_infil_alpha" );
    addnotetrack_customfunction( "slot_4", "shake_on", &cam_shake_low, "lbravo_infil_alpha" );
    addnotetrack_customfunction( "slot_5", "shake_on", &cam_shake_low, "lbravo_infil_alpha" );
    addnotetrack_customfunction( "slot_0", "shake_on", &cam_shake_low, "lbravo_infil_bravo" );
    addnotetrack_customfunction( "slot_1", "shake_on", &cam_shake_low, "lbravo_infil_bravo" );
    addnotetrack_customfunction( "slot_2", "shake_on", &cam_shake_low, "lbravo_infil_bravo" );
    addnotetrack_customfunction( "slot_3", "shake_on", &cam_shake_low, "lbravo_infil_bravo" );
    addnotetrack_customfunction( "slot_4", "shake_on", &cam_shake_low, "lbravo_infil_bravo" );
    addnotetrack_customfunction( "slot_5", "shake_on", &cam_shake_low, "lbravo_infil_bravo" );
    addnotetrack_customfunction( "slot_0", "shake_off", &cam_shake_off, "lbravo_infil_alpha_exit" );
    addnotetrack_customfunction( "slot_1", "shake_off", &cam_shake_off, "lbravo_infil_alpha_exit" );
    addnotetrack_customfunction( "slot_2", "shake_off", &cam_shake_off, "lbravo_infil_alpha_exit" );
    addnotetrack_customfunction( "slot_3", "shake_off", &cam_shake_off, "lbravo_infil_alpha_exit" );
    addnotetrack_customfunction( "slot_4", "shake_off", &cam_shake_off, "lbravo_infil_alpha_exit" );
    addnotetrack_customfunction( "slot_5", "shake_off", &cam_shake_off, "lbravo_infil_alpha_exit" );
    addnotetrack_customfunction( "slot_0", "shake_off", &cam_shake_off, "lbravo_infil_bravo_exit" );
    addnotetrack_customfunction( "slot_1", "shake_off", &cam_shake_off, "lbravo_infil_bravo_exit" );
    addnotetrack_customfunction( "slot_2", "shake_off", &cam_shake_off, "lbravo_infil_bravo_exit" );
    addnotetrack_customfunction( "slot_3", "shake_off", &cam_shake_off, "lbravo_infil_bravo_exit" );
    addnotetrack_customfunction( "slot_4", "shake_off", &cam_shake_off, "lbravo_infil_bravo_exit" );
    addnotetrack_customfunction( "slot_5", "shake_off", &cam_shake_off, "lbravo_infil_bravo_exit" );
}

#using_animtree( "script_model" );

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 1
// Checksum 0x0, Offset: 0x2690
// Size: 0xd2a
function script_model_alpha_anims( subtype )
{
    switch ( subtype )
    {
        case #"hash_6829ee5abc10c38b":
            level.scr_animtree[ "pilot" ] = #animtree;
            level.scr_anim[ "pilot" ][ "lbravo_infil" + "_alpha" ] = %mp_infil_lbravo_a_pilot;
            level.scr_animtree[ "pilot" ] = #animtree;
            level.scr_anim[ "pilot" ][ "lbravo_infil" + "_alpha_loop" ] = %mp_infil_lbravo_a_pilot_loop;
            level.scr_animtree[ "pilot" ] = #animtree;
            level.scr_anim[ "pilot" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %mp_infil_lbravo_a_pilot_loop_exit;
            level.scr_animtree[ "copilot" ] = #animtree;
            level.scr_anim[ "copilot" ][ "lbravo_infil" + "_alpha" ] = %mp_infil_lbravo_a_copilot;
            level.scr_animtree[ "copilot" ] = #animtree;
            level.scr_anim[ "copilot" ][ "lbravo_infil" + "_alpha_loop" ] = %mp_infil_lbravo_a_copilot_loop;
            level.scr_animtree[ "copilot" ] = #animtree;
            level.scr_anim[ "copilot" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %mp_infil_lbravo_a_copilot_loop_exit;
            level.scr_animtree[ "slot_0" ] = #animtree;
            level.scr_anim[ "slot_0" ][ "lbravo_infil" + "_alpha" ] = %mp_infil_lbravo_a_guy1_wm;
            level.scr_eventanim[ "slot_0" ][ "lbravo_infil" + "_alpha" ] = %"hash_6aa54cc19a4558d9";
            level.scr_anim[ "slot_0" ][ "lbravo_infil" + "_alpha_exit" ] = %mp_infil_lbravo_b_guy1_exit_wm;
            level.scr_eventanim[ "slot_0" ][ "lbravo_infil" + "_alpha_exit" ] = %"hash_639b497ae89fd45";
            level.scr_anim[ "slot_0" ][ "lbravo_infil" + "_alpha_loop" ] = %mp_infil_lbravo_b_guy1_wm;
            level.scr_eventanim[ "slot_0" ][ "lbravo_infil" + "_alpha_loop" ] = %"hash_5152e5c18c1dedd4";
            level.scr_anim[ "slot_0" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %mp_infil_lbravo_a_guy1_loop_exit_wm;
            level.scr_eventanim[ "slot_0" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %"hash_79b2b2b224293f55";
            level.scr_animtree[ "slot_1" ] = #animtree;
            level.scr_anim[ "slot_1" ][ "lbravo_infil" + "_alpha" ] = %mp_infil_lbravo_a_guy2_wm;
            level.scr_eventanim[ "slot_1" ][ "lbravo_infil" + "_alpha" ] = %"hash_6aa549c19a4553c0";
            level.scr_anim[ "slot_1" ][ "lbravo_infil" + "_alpha_exit" ] = %mp_infil_lbravo_b_guy2_exit_wm;
            level.scr_eventanim[ "slot_1" ][ "lbravo_infil" + "_alpha_exit" ] = %"hash_639b197ae89f82c";
            level.scr_anim[ "slot_1" ][ "lbravo_infil" + "_alpha_loop" ] = %mp_infil_lbravo_b_guy2_wm;
            level.scr_eventanim[ "slot_1" ][ "lbravo_infil" + "_alpha_loop" ] = %"hash_5152e8c18c1df2ed";
            level.scr_anim[ "slot_1" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %mp_infil_lbravo_a_guy2_loop_exit_wm;
            level.scr_eventanim[ "slot_1" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %"hash_79b2afb224293a3c";
            level.scr_animtree[ "slot_2" ] = #animtree;
            level.scr_anim[ "slot_2" ][ "lbravo_infil" + "_alpha" ] = %mp_infil_lbravo_a_guy3_wm;
            level.scr_eventanim[ "slot_2" ][ "lbravo_infil" + "_alpha" ] = %"hash_6aa54ac19a455573";
            level.scr_anim[ "slot_2" ][ "lbravo_infil" + "_alpha_exit" ] = %mp_infil_lbravo_b_guy3_exit_wm;
            level.scr_eventanim[ "slot_2" ][ "lbravo_infil" + "_alpha_exit" ] = %"hash_639b297ae89f9df";
            level.scr_anim[ "slot_2" ][ "lbravo_infil" + "_alpha_loop" ] = %mp_infil_lbravo_b_guy3_wm;
            level.scr_eventanim[ "slot_2" ][ "lbravo_infil" + "_alpha_loop" ] = %"hash_5152e7c18c1df13a";
            level.scr_anim[ "slot_2" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %mp_infil_lbravo_a_guy3_loop_exit_wm;
            level.scr_eventanim[ "slot_2" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %"hash_79b2b0b224293bef";
            level.scr_animtree[ "slot_3" ] = #animtree;
            level.scr_anim[ "slot_3" ][ "lbravo_infil" + "_alpha" ] = %mp_infil_lbravo_a_guy4_wm;
            level.scr_eventanim[ "slot_3" ][ "lbravo_infil" + "_alpha" ] = %"hash_6aa54fc19a455df2";
            level.scr_anim[ "slot_3" ][ "lbravo_infil" + "_alpha_exit" ] = %mp_infil_lbravo_b_guy4_exit_wm;
            level.scr_eventanim[ "slot_3" ][ "lbravo_infil" + "_alpha_exit" ] = %"hash_639af97ae89f4c6";
            level.scr_anim[ "slot_3" ][ "lbravo_infil" + "_alpha_loop" ] = %mp_infil_lbravo_b_guy4_wm;
            level.scr_eventanim[ "slot_3" ][ "lbravo_infil" + "_alpha_loop" ] = %"hash_5152e2c18c1de8bb";
            level.scr_anim[ "slot_3" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %mp_infil_lbravo_a_guy4_loop_exit_wm;
            level.scr_eventanim[ "slot_3" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %"hash_79b2adb2242936d6";
            level.scr_animtree[ "slot_4" ] = #animtree;
            level.scr_anim[ "slot_4" ][ "lbravo_infil" + "_alpha" ] = %mp_infil_lbravo_a_guy5_wm;
            level.scr_eventanim[ "slot_4" ][ "lbravo_infil" + "_alpha" ] = %"hash_6aa550c19a455fa5";
            level.scr_anim[ "slot_4" ][ "lbravo_infil" + "_alpha_exit" ] = %mp_infil_lbravo_b_guy5_exit_wm;
            level.scr_eventanim[ "slot_4" ][ "lbravo_infil" + "_alpha_exit" ] = %"hash_639b097ae89f679";
            level.scr_anim[ "slot_4" ][ "lbravo_infil" + "_alpha_loop" ] = %mp_infil_lbravo_b_guy5_wm;
            level.scr_eventanim[ "slot_4" ][ "lbravo_infil" + "_alpha_loop" ] = %"hash_5152e1c18c1de708";
            level.scr_anim[ "slot_4" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %mp_infil_lbravo_a_guy5_loop_exit_wm;
            level.scr_eventanim[ "slot_4" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %"hash_79b2aeb224293889";
            level.scr_animtree[ "slot_5" ] = #animtree;
            level.scr_anim[ "slot_5" ][ "lbravo_infil" + "_alpha" ] = %mp_infil_lbravo_a_guy6_wm;
            level.scr_eventanim[ "slot_5" ][ "lbravo_infil" + "_alpha" ] = %"hash_6aa54dc19a455a8c";
            level.scr_anim[ "slot_5" ][ "lbravo_infil" + "_alpha_exit" ] = %mp_infil_lbravo_b_guy6_exit_wm;
            level.scr_eventanim[ "slot_5" ][ "lbravo_infil" + "_alpha_exit" ] = %"hash_639ad97ae89f160";
            level.scr_anim[ "slot_5" ][ "lbravo_infil" + "_alpha_loop" ] = %mp_infil_lbravo_b_guy6_wm;
            level.scr_eventanim[ "slot_5" ][ "lbravo_infil" + "_alpha_loop" ] = %"hash_5152e4c18c1dec21";
            level.scr_anim[ "slot_5" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %mp_infil_lbravo_a_guy6_loop_exit_wm;
            level.scr_eventanim[ "slot_5" ][ "lbravo_infil" + "_alpha_loop_exit" ] = %"hash_79b2abb224293370";
            break;
        case #"hash_1cc79b02710cab23":
            level.scr_animtree[ "pilot" ] = #animtree;
            level.scr_anim[ "pilot" ][ "lbravo_infil" + "_bravo" ] = %mp_infil_lbravo_b_pilot;
            level.scr_animtree[ "copilot" ] = #animtree;
            level.scr_anim[ "copilot" ][ "lbravo_infil" + "_bravo" ] = %mp_infil_lbravo_b_copilot;
            level.scr_animtree[ "slot_0" ] = #animtree;
            level.scr_anim[ "slot_0" ][ "lbravo_infil" + "_bravo" ] = %mp_infil_lbravo_b_guy1_wm;
            level.scr_eventanim[ "slot_0" ][ "lbravo_infil" + "_bravo" ] = %"hash_5152e5c18c1dedd4";
            level.scr_anim[ "slot_0" ][ "lbravo_infil" + "_bravo_exit" ] = %mp_infil_lbravo_b_guy1_exit_wm;
            level.scr_eventanim[ "slot_0" ][ "lbravo_infil" + "_bravo_exit" ] = %"hash_639b497ae89fd45";
            level.scr_animtree[ "slot_1" ] = #animtree;
            level.scr_anim[ "slot_1" ][ "lbravo_infil" + "_bravo" ] = %mp_infil_lbravo_b_guy2_wm;
            level.scr_eventanim[ "slot_1" ][ "lbravo_infil" + "_bravo" ] = %"hash_5152e8c18c1df2ed";
            level.scr_anim[ "slot_1" ][ "lbravo_infil" + "_bravo_exit" ] = %mp_infil_lbravo_b_guy2_exit_wm;
            level.scr_eventanim[ "slot_1" ][ "lbravo_infil" + "_bravo_exit" ] = %"hash_639b197ae89f82c";
            level.scr_animtree[ "slot_2" ] = #animtree;
            level.scr_anim[ "slot_2" ][ "lbravo_infil" + "_bravo" ] = %mp_infil_lbravo_b_guy3_wm;
            level.scr_eventanim[ "slot_2" ][ "lbravo_infil" + "_bravo" ] = %"hash_5152e7c18c1df13a";
            level.scr_anim[ "slot_2" ][ "lbravo_infil" + "_bravo_exit" ] = %mp_infil_lbravo_b_guy3_exit_wm;
            level.scr_eventanim[ "slot_2" ][ "lbravo_infil" + "_bravo_exit" ] = %"hash_639b297ae89f9df";
            level.scr_animtree[ "slot_3" ] = #animtree;
            level.scr_anim[ "slot_3" ][ "lbravo_infil" + "_bravo" ] = %mp_infil_lbravo_b_guy4_wm;
            level.scr_eventanim[ "slot_3" ][ "lbravo_infil" + "_bravo" ] = %"hash_5152e2c18c1de8bb";
            level.scr_anim[ "slot_3" ][ "lbravo_infil" + "_bravo_exit" ] = %mp_infil_lbravo_b_guy4_exit_wm;
            level.scr_eventanim[ "slot_3" ][ "lbravo_infil" + "_bravo_exit" ] = %"hash_639af97ae89f4c6";
            level.scr_animtree[ "slot_4" ] = #animtree;
            level.scr_anim[ "slot_4" ][ "lbravo_infil" + "_bravo" ] = %mp_infil_lbravo_b_guy5_wm;
            level.scr_eventanim[ "slot_4" ][ "lbravo_infil" + "_bravo" ] = %"hash_5152e1c18c1de708";
            level.scr_anim[ "slot_4" ][ "lbravo_infil" + "_bravo_exit" ] = %mp_infil_lbravo_b_guy5_exit_wm;
            level.scr_eventanim[ "slot_4" ][ "lbravo_infil" + "_bravo_exit" ] = %"hash_639b097ae89f679";
            level.scr_animtree[ "slot_5" ] = #animtree;
            level.scr_anim[ "slot_5" ][ "lbravo_infil" + "_bravo" ] = %mp_infil_lbravo_b_guy6_wm;
            level.scr_eventanim[ "slot_5" ][ "lbravo_infil" + "_bravo" ] = %"hash_5152e4c18c1dec21";
            level.scr_anim[ "slot_5" ][ "lbravo_infil" + "_bravo_exit" ] = %mp_infil_lbravo_b_guy6_exit_wm;
            level.scr_eventanim[ "slot_5" ][ "lbravo_infil" + "_bravo_exit" ] = %"hash_639ad97ae89f160";
            break;
    }
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 1
// Checksum 0x0, Offset: 0x33c2
// Size: 0xf9
function vehicles_alpha_anims( subtype )
{
    switch ( subtype )
    {
        case #"hash_6829ee5abc10c38b":
            level.scr_animtree[ "lbravo" ] = #animtree;
            level.scr_anim[ "lbravo" ][ "lbravo_infil" + "_alpha" ] = %mp_infil_lbravo_a_heli;
            break;
        case #"hash_1cc79b02710cab23":
            level.scr_animtree[ "lbravo" ] = #animtree;
            
            switch ( getdvar( @"g_mapname" ) )
            {
                case #"hash_688334408379d4fb":
                    level.scr_anim[ "lbravo" ][ "lbravo_infil" + "_bravo" ] = %mp_infil_lbravo_b_heli_runner;
                    break;
                default:
                    level.scr_anim[ "lbravo" ][ "lbravo_infil" + "_bravo" ] = %mp_infil_lbravo_b_heli;
                    break;
            }
            
            break;
    }
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 3
// Checksum 0x0, Offset: 0x34c3
// Size: 0x77
function commander_play_sound_func( alias, notification, stoppable )
{
    foreach ( player in self.infil.players )
    {
        self playsoundtoplayer( alias, player );
    }
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 4
// Checksum 0x0, Offset: 0x3542
// Size: 0x202
function vehiclethinkpath( team, scene_node, scene_name, extra_crew )
{
    level waittill( "infil_started" );
    self.linktoent endon( "death" );
    self.linktoent.unload_hover_offset = 130;
    self.linktoent.unload_time = 3.5;
    self.linktoent vehicle_teleport( self.linktoent.spawnpoint.origin, self.linktoent.spawnpoint.angles );
    self.linktoent scripts\common\vehicle_paths::vehicle_paths_helicopter( self.path );
    self.linktoent thread function_eb5aae60eb60077d( self.linktoent.origin );
    self.linktoent notify( "unload" );
    
    if ( isdefined( self.linktoent.unload_time ) )
    {
        wait self.linktoent.unload_time;
    }
    
    level notify( "players_unloaded_from_infil" );
    
    if ( isdefined( self.exit_path ) )
    {
        maxdist = 122500;
        
        while ( any_player_nearby( self.linktoent.origin, maxdist ) )
        {
            wait 0.1;
        }
        
        self.linktoent thread scripts\common\vehicle_paths::vehicle_paths_helicopter( self.exit_path );
        self.linktoent thread function_ab9df6c53fe81fd9();
        self.linktoent.script_vehicle_selfremove = 1;
        self.linktoent notify( "vehicle_exfil_start" );
        level notify( "infil_exfil_start", self.linktoent );
        
        if ( soundexists( "cp_observatory_infil_chopper_takeoff" ) )
        {
            level.infil_struct.linktoent playsoundonmovingent( "cp_observatory_infil_chopper_takeoff" );
        }
    }
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 0
// Checksum 0x0, Offset: 0x374c
// Size: 0x83
function function_ab9df6c53fe81fd9()
{
    level endon( "game_ended" );
    self waittill( "reached_dynamic_path_end" );
    
    if ( !isdefined( self.infil.actors ) )
    {
        return;
    }
    
    foreach ( actor in self.infil.actors )
    {
        actor delete();
    }
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 1
// Checksum 0x0, Offset: 0x37d7
// Size: 0x51
function function_eb5aae60eb60077d( origin )
{
    var_65c0c475c179ea29 = createnavbadplacebybounds( origin, ( 80, 80, 350 ), ( 0, 0, 0 ) );
    waittill_any_2( "vehicle_exfil_start", "death" );
    wait 2;
    destroynavobstacle( var_65c0c475c179ea29 );
}

// Namespace lbravo_infil_cp / scripts\cp\infilexfil\lbravo_infil_cp
// Params 0
// Checksum 0x0, Offset: 0x3830
// Size: 0x13c
function parsepathlength()
{
    if ( !isdefined( self.path ) )
    {
        return 0;
    }
    
    if ( isdefined( self.pathduration ) )
    {
        return self.pathduration;
    }
    
    self.pathduration = 0;
    node = self.path;
    speed = node.speed;
    
    while ( true )
    {
        if ( isdefined( node.script_unload ) )
        {
            break;
        }
        
        if ( !isdefined( node.target ) )
        {
            break;
        }
        
        next = getstruct( node.target, "targetname" );
        
        if ( !isdefined( next ) )
        {
            break;
        }
        
        var_9eb9e52b1dcd019d = distance( node.origin, next.origin );
        
        if ( isdefined( node.speed ) )
        {
            speed = node.speed;
        }
        else
        {
            speed = 30;
        }
        
        conversion = 17.6;
        self.pathduration += var_9eb9e52b1dcd019d * 1.8 / speed * conversion;
        node = next;
    }
    
    return self.pathduration;
}

