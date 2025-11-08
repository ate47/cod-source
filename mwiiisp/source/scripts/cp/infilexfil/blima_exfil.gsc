#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\cp_anim;
#using scripts\cp\cp_infilexfil;
#using scripts\cp\cp_juggernaut;
#using scripts\cp\cp_objective_mechanics;
#using scripts\cp\cp_objectives;
#using scripts\cp\infilexfil\infilexfil;
#using scripts\cp\interaction;
#using scripts\cp\laststand;
#using scripts\cp\powers\cp_tactical_cover;
#using scripts\cp\utility;
#using scripts\cp\vehicles\cp_heli_trip;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\utility\infilexfil;

#namespace blima_exfil;

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 2
// Checksum 0x0, Offset: 0x6bf
// Size: 0xc1
function player_exfil_think( var_214da032eefdfe74, seat )
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "player_free_spot" );
    thread infil_player_rig( seat, "viewhands_base_iw8" );
    self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
    self.player_rig linkto( var_214da032eefdfe74, "body_animate_jnt", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self lerpfovbypreset( "80_instant" );
    self setdemeanorviewmodel( "safe", "iw8_ges_demeanor_safe_heli" );
    var_214da032eefdfe74 anim_player_solo( self, self.player_rig, "exfil", "body_animate_jnt" );
    var_214da032eefdfe74 thread rideloop( self );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 3
// Checksum 0x0, Offset: 0x788
// Size: 0x63
function spawnactors( team, scene_name, extra_crew )
{
    initanims();
    
    if ( !isdefined( self.actors ) )
    {
        self.actors = [];
    }
    
    self.actors[ self.actors.size ] = spawn_anim_model( "pilot", "body_animate_jnt", "allied_pilot_fullbody_3" );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 6
// Checksum 0x0, Offset: 0x7f3
// Size: 0x18c
function spawn_anim_model( animname, linkto_tag, body, head, weapon, hat )
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
    
    if ( isdefined( hat ) )
    {
        guy_hat = spawn( "script_model", ( 0, 0, 0 ) );
        guy_hat setmodel( hat );
        guy_hat linkto( guy.head, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        guy.hat = guy_hat;
        guy thread delete_on_death( guy_hat );
    }
    
    guy.animname = animname;
    guy setanimtree();
    
    if ( isdefined( linkto_tag ) )
    {
        thread delete_on_death( guy );
        guy linkto( self, linkto_tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    return guy;
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0x988
// Size: 0x19
function initanims( subtype )
{
    script_model_anims();
    vehicle_anims();
}

#using_animtree( "script_model" );

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0x9a9
// Size: 0x29c
function script_model_anims()
{
    level.scr_animtree[ "pilot" ] = #animtree;
    level.scr_anim[ "pilot" ][ "exfil" ] = %vh_blima_rappel_pilot;
    level.scr_animtree[ "copilot" ] = #animtree;
    level.scr_anim[ "copilot" ][ "exfil" ] = %vh_blima_rappel_copilot;
    level.scr_animtree[ "seat1" ] = #animtree;
    level.scr_anim[ "seat1" ][ "exfil" ] = %cp_exfil_blima_plr01_wm;
    level.scr_eventanim[ "seat1" ][ "exfil" ] = %"hash_1a45a000005b7977";
    level.scr_anim[ "seat1" ][ "exfil_idle" ] = %cp_exfil_blima_plr01_idle_wm;
    level.scr_eventanim[ "seat1" ][ "exfil_idle" ] = %"hash_45fdcebc7ada32aa";
    level.scr_animtree[ "seat2" ] = #animtree;
    level.scr_anim[ "seat2" ][ "exfil" ] = %cp_exfil_blima_plr02_wm;
    level.scr_eventanim[ "seat2" ][ "exfil" ] = %"hash_1a45a100005b7b2a";
    level.scr_anim[ "seat2" ][ "exfil_idle" ] = %cp_exfil_blima_plr02_idle_wm;
    level.scr_eventanim[ "seat2" ][ "exfil_idle" ] = %"hash_44236875bd5b27d";
    level.scr_animtree[ "seat3" ] = #animtree;
    level.scr_anim[ "seat3" ][ "exfil" ] = %cp_exfil_blima_plr03_wm;
    level.scr_eventanim[ "seat3" ][ "exfil" ] = %"hash_1a45a200005b7cdd";
    level.scr_anim[ "seat3" ][ "exfil_idle" ] = %cp_exfil_blima_plr03_idle_wm;
    level.scr_eventanim[ "seat3" ][ "exfil_idle" ] = %"hash_213c21a9b30a48d0";
    level.scr_animtree[ "seat4" ] = #animtree;
    level.scr_anim[ "seat4" ][ "exfil" ] = %cp_exfil_blima_plr04_wm;
    level.scr_eventanim[ "seat4" ][ "exfil" ] = %"hash_13e4ff431b84ab3";
    level.scr_anim[ "seat4" ][ "exfil_idle" ] = %cp_exfil_blima_plr04_idle_wm;
    level.scr_eventanim[ "seat4" ][ "exfil_idle" ] = %"hash_13e4ff431b84ab3";
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0xc4d
// Size: 0x14
function vehicle_anims()
{
    level.scr_animtree[ "exfil_chopper" ] = #animtree;
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 3
// Checksum 0x0, Offset: 0xc69
// Size: 0x2e
function exfil_players( var_214da032eefdfe74, objnum, custompassengerwaitfunc )
{
    exfil( var_214da032eefdfe74, objnum, custompassengerwaitfunc );
    var_214da032eefdfe74 thread leave_and_end_game();
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 3
// Checksum 0x0, Offset: 0xc9f
// Size: 0x6b
function function_9149f78899f36b7( var_214da032eefdfe74, objnum, custompassengerwaitfunc )
{
    exfil( var_214da032eefdfe74, objnum, custompassengerwaitfunc );
    var_214da032eefdfe74 heli_leave( 1, 1 );
    
    if ( isdefined( var_214da032eefdfe74.headicon ) )
    {
        deleteheadicon( var_214da032eefdfe74.headicon );
    }
    
    var_214da032eefdfe74 notify( "death" );
    wait 0.1;
    
    if ( isdefined( var_214da032eefdfe74 ) )
    {
        var_214da032eefdfe74 delete();
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 3
// Checksum 0x0, Offset: 0xd12
// Size: 0x9b
function exfil( var_214da032eefdfe74, objnum, custompassengerwaitfunc )
{
    scripts\cp\vehicles\cp_heli_trip::initanims();
    level.heli_trip_vehicle = var_214da032eefdfe74;
    
    if ( isdefined( custompassengerwaitfunc ) && isfunction( custompassengerwaitfunc ) )
    {
        level.heli_trip_vehicle thread [[ custompassengerwaitfunc ]]();
    }
    else
    {
        level.heli_trip_vehicle thread scripts\cp\vehicles\cp_heli_trip::wait_for_passengers( 0 );
    }
    
    objective_setlabel( objnum, &"COOP_GAME_PLAY/EXFIL" );
    var_214da032eefdfe74 notify( "waiting_to_leave" );
    level.heli_trip_vehicle waittill_any_2( "all_players_on_board", "heli_trip_timed_out" );
    level notify( "ready_to_exfil" );
    objective_delete( objnum );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0xdb5
// Size: 0x2d
function spawn_vehicle_actors( vehicle )
{
    vehicle.animname = "exfil_chopper";
    vehicle spawnactors();
    vehicle thread actorloopthink();
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0xdea
// Size: 0x10
function leave_and_end_game()
{
    heli_leave();
    end_game();
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 2
// Checksum 0x0, Offset: 0xe02
// Size: 0x196
function heli_leave( var_28fb9ce9b6706e97, var_4461656ab93d2faa )
{
    wait 1;
    self cleargoalyaw();
    self vehicle_setspeed( 15, 10 );
    org = self.origin + ( 0, 0, 1200 );
    self setvehgoalpos( org, 1 );
    wait 5;
    
    if ( isdefined( self.exfil_speed ) )
    {
        self vehicle_setspeed( self.exfil_speed, 20 );
    }
    else
    {
        self vehicle_setspeed( 60, 20 );
    }
    
    if ( isdefined( self.exfil_struct ) && isdefined( self.exfil_struct.target ) )
    {
        [ var_f1b25ad1d7caa88e ] = getstructarray( self.exfil_struct.target, "targetname" );
        var_f13e0951028d543f = ( var_f1b25ad1d7caa88e.origin[ 0 ], var_f1b25ad1d7caa88e.origin[ 1 ], self.origin[ 2 ] );
        var_1dc53a6f1393b456 = vectornormalize( var_f13e0951028d543f - self.origin );
        var_1dc53a6f1393b456 *= 20000;
        self setvehgoalpos( org + var_1dc53a6f1393b456 );
    }
    else
    {
        self setvehgoalpos( org + ( 0, -20000, 0 ) );
    }
    
    if ( istrue( var_28fb9ce9b6706e97 ) )
    {
        self waittill( "goal" );
    }
    
    if ( !istrue( var_4461656ab93d2faa ) )
    {
        if ( flag_exist( "endgame_delay" ) )
        {
            flag_wait( "endgame_delay" );
        }
        else
        {
            wait 4;
        }
        
        wait 3;
    }
    
    self notify( "end_of_path" );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0xfa0
// Size: 0x24
function end_game()
{
    level thread [[ level.endgame ]]( "allies", level.end_game_string_index[ "win" ] );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0xfcc
// Size: 0x110, Type: bool
function all_alive_players_in_chopper()
{
    var_44992e6b98f5ec99 = 0;
    playersinlaststand = 0;
    axis_players = [];
    allies_players = [];
    
    foreach ( player in level.players )
    {
        if ( player.team == "axis" )
        {
            axis_players[ axis_players.size ] = player;
            continue;
        }
        
        allies_players[ allies_players.size ] = player;
    }
    
    foreach ( player in allies_players )
    {
        if ( scripts\cp\laststand::player_in_laststand( player ) || player isspectatingplayer() )
        {
            playersinlaststand++;
        }
        
        if ( istrue( player.inchopper ) )
        {
            var_44992e6b98f5ec99++;
        }
    }
    
    return var_44992e6b98f5ec99 > 0 && allies_players.size == var_44992e6b98f5ec99 + playersinlaststand;
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0x10e5
// Size: 0x22
function wait_for_all_players_ready()
{
    while ( true )
    {
        if ( all_alive_players_in_chopper() )
        {
            level notify( "ready_to_exfil" );
            return;
        }
        
        wait 0.1;
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0x110f
// Size: 0x1a
function actorloopthink()
{
    thread actorloop( self.actors[ 0 ], "tag_seat_0" );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 2
// Checksum 0x0, Offset: 0x1131
// Size: 0x36
function actorloop( actor, tag )
{
    self endon( "unload" );
    self endon( "death" );
    actor endon( "death" );
    anim_single_solo( actor, "exfil", tag );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0x116f
// Size: 0x119
function init_interactions()
{
    fwd = anglestoforward( self.angles );
    rt = anglestoright( self.angles );
    lft = anglestoleft( self.angles );
    org = self.origin + ( 0, 0, -110 );
    pos4 = org + fwd * 20 + lft * 45;
    pos2 = org + fwd * 20 + rt * 45;
    pos3 = org + fwd * -20 + lft * 45;
    pos1 = org + fwd * -20 + rt * 45;
    create_vehicle_interaction( pos4, &"CP_VEHICLE_TRAVEL/ENTER", "seat4", self );
    create_vehicle_interaction( pos2, &"CP_VEHICLE_TRAVEL/ENTER", "seat2", self );
    create_vehicle_interaction( pos3, &"CP_VEHICLE_TRAVEL/ENTER", "seat3", self );
    create_vehicle_interaction( pos1, &"CP_VEHICLE_TRAVEL/ENTER", "seat1", self );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 4
// Checksum 0x0, Offset: 0x1290
// Size: 0xa0
function create_vehicle_interaction( loc, hintstring, name, vehicle )
{
    interaction = spawn( "script_model", loc );
    interaction setmodel( "tag_origin" );
    interaction sethintstring( hintstring );
    interaction setcursorhint( "HINT_BUTTON" );
    interaction sethintdisplayrange( 200 );
    interaction sethintdisplayfov( 90 );
    interaction setuserange( 72 );
    interaction setusefov( 90 );
    interaction sethintonobstruction( "hide" );
    interaction setuseholdduration( "duration_short" );
    interaction thread use_think( vehicle, name );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 2
// Checksum 0x0, Offset: 0x1338
// Size: 0x92
function use_think( vehicle, name )
{
    self makeusable();
    
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( !player scripts\cp\utility::is_valid_player() )
        {
            continue;
        }
        
        if ( isdefined( level.nuclear_core ) )
        {
            if ( !isdefined( level.nuclear_core_carrier ) )
            {
                iprintln( " PICK THE CORE UP BEFORE LEAVING! " );
                continue;
            }
        }
        
        self makeunusable();
        player scripts\cp\infilexfil\infilexfil::infil_player_allow_cp( 0 );
        waitframe();
        player thread scripts\cp\vehicles\cp_heli_trip::playerpassengerthink();
        player.inchopper = 1;
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0x13d2
// Size: 0x53
function allow_players_exfil()
{
    foreach ( player in level.players )
    {
        player notify( "allow_exfil" );
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0x142d
// Size: 0xb9
function player_listen_for_exfil()
{
    self endon( "disconnect" );
    self waittill( "allow_exfil" );
    
    while ( true )
    {
        if ( self usebuttonpressed() && self getcurrentweapon().basename == "ks_remote_map_cp" )
        {
            self iprintlnbold( "EXFIL CALLED" );
            level notify( "call_exfil", self.origin );
            return;
        }
        
        if ( self meleebuttonpressed() )
        {
            timepressed = 0;
            
            while ( self meleebuttonpressed() )
            {
                timepressed++;
                wait 0.05;
                
                if ( timepressed >= 60 )
                {
                    break;
                }
            }
            
            if ( timepressed >= 60 )
            {
                self iprintlnbold( "EXFIL CALLED" );
                level notify( "call_exfil", self.origin );
                return;
            }
        }
        
        wait 0.1;
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 4
// Checksum 0x0, Offset: 0x14ee
// Size: 0xe5
function function_387b5e2e4b970437( var_f94346053e3f63e5, var_e1e1732f234cf593, var_cf805cd60ef50d4f, custompassengerwaitfunc )
{
    if ( !isdefined( var_f94346053e3f63e5 ) )
    {
        var_f94346053e3f63e5 = "exfil_location";
    }
    
    self notify( "listen_for_exfil_" + var_f94346053e3f63e5 );
    self endon( "listen_for_exfil_" + var_f94346053e3f63e5 );
    
    if ( !isdefined( var_e1e1732f234cf593 ) )
    {
        var_e1e1732f234cf593 = "player_exfil";
    }
    
    level waittill( "call_exfil_" + var_f94346053e3f63e5, pos, return_heli );
    var_2f5be15466f1811d = getstruct( var_e1e1732f234cf593, "targetname" );
    
    if ( isdefined( level.player_exfil_struct ) )
    {
        var_2f5be15466f1811d = level.player_exfil_struct;
    }
    
    var_2f5be15466f1811d.vehicletype = "blima_cp";
    heli = function_aa22ac000bb68a77( var_2f5be15466f1811d );
    heli thread function_8e002faa7893c07c( pos, var_f94346053e3f63e5, var_cf805cd60ef50d4f, custompassengerwaitfunc );
    
    if ( istrue( return_heli ) )
    {
        level.exfil_heli = heli;
        return heli;
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 4
// Checksum 0x0, Offset: 0x15db
// Size: 0x10f
function function_8e002faa7893c07c( pos, var_f94346053e3f63e5, var_cf805cd60ef50d4f, custompassengerwaitfunc )
{
    heli = self;
    exfil_struct = getclosest( pos, getstructarray( var_f94346053e3f63e5, "targetname" ) );
    
    if ( isdefined( level.use_airdrop_fx ) )
    {
        magicgrenademanual( "deploy_airdrop_mp", getgroundposition( exfil_struct.origin, 16 ), ( 0, 90, 0 ), 0.01 );
    }
    else
    {
        exfil_struct.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn( exfil_struct.origin, 1 );
    }
    
    heli.exfil_struct = exfil_struct;
    objnum = function_283c1ba04595d987( heli, exfil_struct );
    heli thread rumble_nearby_players();
    heli thread wait_while_exfil_arrives( objnum );
    heli waittill( "wait_done" );
    
    if ( isdefined( var_cf805cd60ef50d4f ) )
    {
        heli go_to_exfil_location( exfil_struct, var_cf805cd60ef50d4f );
    }
    else
    {
        heli go_to_exfil_location( exfil_struct, 1 );
    }
    
    heli function_9149f78899f36b7( heli, objnum, custompassengerwaitfunc );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0x16f2
// Size: 0x96
function function_aa22ac000bb68a77( var_2f5be15466f1811d )
{
    heli = scripts\common\vehicle::vehicle_spawn( var_2f5be15466f1811d );
    heli thread damage_players_on_blades();
    heli.godmode = 1;
    heli.health = 100000;
    heli.maxhealth = 100000;
    heli.team = "allies";
    heli.script_team = "allies";
    heli setvehicleteam( "allies" );
    heli setcandamage( 0 );
    thread spawn_vehicle_actors( heli );
    return heli;
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 2
// Checksum 0x0, Offset: 0x1791
// Size: 0x105
function function_283c1ba04595d987( heli, exfil_struct )
{
    objnum = scripts\cp\cp_objectives::requestworldid( "exfil_loc", 10 );
    objective_state( objnum, "current" );
    objective_position( objnum, exfil_struct.origin - ( 0, 0, 100 ) );
    objective_icon( objnum, "icon_waypoint_objective_general" );
    objective_setminimapiconsize( objnum, "icon_regular" );
    objective_setshowdistance( objnum, 1 );
    objective_setplayintro( objnum, 1 );
    heli.headicon = createheadicon( heli );
    setheadiconimage( heli.headicon, "hud_icon_head_equipment_friendly" );
    setheadiconmaxdistance( heli.headicon, 12000 );
    setheadiconnaturaldistance( heli.headicon, 1500 );
    setheadiconzoffset( heli.headicon, 10 );
    setheadiconsnaptoedges( heli.headicon, 1 );
    heli.objnum = objnum;
    return objnum;
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 3
// Checksum 0x0, Offset: 0x189f
// Size: 0x2f2
function listen_for_exfil( var_f94346053e3f63e5, var_cf805cd60ef50d4f, custompassengerwaitfunc )
{
    self notify( "listen_for_exfil" );
    self endon( "listen_for_exfil" );
    
    if ( !isdefined( var_f94346053e3f63e5 ) )
    {
        var_f94346053e3f63e5 = "exfil_location";
    }
    
    level waittill( "call_exfil", pos, return_heli );
    var_2f5be15466f1811d = getstruct( "player_exfil", "targetname" );
    
    if ( isdefined( level.player_exfil_struct ) )
    {
        var_2f5be15466f1811d = level.player_exfil_struct;
    }
    
    var_2f5be15466f1811d.vehicletype = "blima_cp";
    heli = scripts\common\vehicle::vehicle_spawn( var_2f5be15466f1811d );
    heli thread damage_players_on_blades();
    heli.godmode = 1;
    heli.health = 100000;
    heli.maxhealth = 100000;
    heli.team = "allies";
    heli.script_team = "allies";
    heli setvehicleteam( "allies" );
    heli setcandamage( 0 );
    
    if ( istrue( return_heli ) )
    {
        level.exfil_heli = heli;
    }
    
    exfil_struct = getclosest( pos, getstructarray( var_f94346053e3f63e5, "targetname" ) );
    
    if ( isdefined( level.use_airdrop_fx ) )
    {
        magicgrenademanual( "deploy_airdrop_mp", getgroundposition( exfil_struct.origin, 16 ), ( 0, 90, 0 ), 0.01 );
    }
    else
    {
        exfil_struct.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn( exfil_struct.origin, 1 );
    }
    
    heli.exfil_struct = exfil_struct;
    objnum = scripts\cp\cp_objectives::requestworldid( "exfil_loc", 10 );
    objective_state( objnum, "current" );
    objective_position( objnum, exfil_struct.origin - ( 0, 0, 100 ) );
    objective_icon( objnum, "icon_waypoint_objective_general" );
    objective_setminimapiconsize( objnum, "icon_regular" );
    objective_setshowdistance( objnum, 1 );
    objective_setplayintro( objnum, 1 );
    heli.headicon = createheadicon( heli );
    setheadiconimage( heli.headicon, "hud_icon_head_equipment_friendly" );
    setheadiconmaxdistance( heli.headicon, 12000 );
    setheadiconnaturaldistance( heli.headicon, 1500 );
    setheadiconzoffset( heli.headicon, 10 );
    setheadiconsnaptoedges( heli.headicon, 1 );
    heli.objnum = objnum;
    spawn_vehicle_actors( heli );
    heli thread rumble_nearby_players();
    heli thread wait_while_exfil_arrives( objnum );
    heli waittill( "wait_done" );
    
    if ( isdefined( var_cf805cd60ef50d4f ) )
    {
        heli go_to_exfil_location( exfil_struct, var_cf805cd60ef50d4f );
    }
    else
    {
        heli go_to_exfil_location( exfil_struct, 1 );
    }
    
    heli exfil_players( heli, objnum, custompassengerwaitfunc );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 3
// Checksum 0x0, Offset: 0x1b99
// Size: 0xb2
function go_to_exfil_location( exfil_struct, do_cleanup, var_ea300f7c7016466d )
{
    if ( !isdefined( exfil_struct.angles ) )
    {
        exfil_struct.angles = ( 0, 0, 0 );
    }
    
    self.going_to_exfil = 1;
    
    if ( !isdefined( var_ea300f7c7016466d ) || !istrue( var_ea300f7c7016466d ) )
    {
        self vehicleplayanim( %est_blima_doors_open );
    }
    
    self vehicle_setspeed( 90, 30 );
    self setvehgoalpos( exfil_struct.origin + ( 0, 0, 1200 ), 1 );
    self waittill( "goal" );
    self vehicle_setspeed( 15, 10 );
    arrive_at_exfil_location( self );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0x1c53
// Size: 0x87
function wait_while_exfil_arrives( objectiveindex )
{
    objective_setlabel( objectiveindex, &"CP_BR_SYRK_OBJECTIVES/EXFIL_ENROUTE" );
    level thread scripts\cp\utility::objective_update( "exfil_enroute" );
    objective_setshowprogress( objectiveindex, 1 );
    objective_setprogress( objectiveindex, 0 );
    objective_setbackground( objectiveindex, 1 );
    time = 10;
    progress = 10;
    
    while ( true )
    {
        wait 1;
        progress--;
        objective_setprogress( objectiveindex, progress / time );
        
        if ( progress <= 15 )
        {
            self notify( "wait_done" );
        }
        
        if ( progress <= 0 )
        {
            return;
        }
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0x1ce2
// Size: 0x1ad
function heli_cleanup_exfil_area( heli )
{
    heli endon( "death" );
    level notify( "starting_cleanup" );
    heli.minigun setturretteam( "allies" );
    heli.minigun setmode( "manual" );
    nextfiretime = gettime();
    invalid_targets = 0;
    
    while ( true )
    {
        valid_target = heli get_nearby_enemy( heli.exfil_struct.origin + ( 0, 0, -150 ) );
        
        if ( !isdefined( valid_target ) )
        {
            heli.minigun cleartargetentity();
            wait 1;
            invalid_targets++;
            
            if ( invalid_targets >= 3 )
            {
                return;
            }
            
            continue;
        }
        
        invalid_targets = 0;
        dest_vec = valid_target.origin + ( 0, 0, 1100 );
        heli.minigun settargetentity( valid_target );
        
        if ( distance( dest_vec, heli.origin ) > 500 )
        {
            heli setvehgoalpos( dest_vec, 1 );
        }
        
        msg = heli.minigun waittill_notify_or_timeout_return( "turret_on_target", 3 );
        
        if ( msg == "timeout" )
        {
            heli.minigun cleartargetentity();
            continue;
        }
        
        if ( gettime() > nextfiretime )
        {
            for ( i = 0; i < 35 ; i++ )
            {
                heli.minigun shootturret();
                wait 0.1;
            }
            
            nextfiretime = gettime() + 1000;
        }
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0x1e97
// Size: 0xf3
function arrive_at_exfil_location( heli )
{
    heli setvehgoalpos( heli.exfil_struct.origin + ( 0, 0, 1200 ), 1 );
    heli waittill( "goal" );
    heli settargetyaw( heli.exfil_struct.angles[ 1 ] );
    heli setyawspeed( 50, 25, 25, 0 );
    wait 3;
    level notify( "arrive_at_exfil_location", heli.origin );
    level.exfil_heli_landing = heli;
    heli thread keep_from_crushing_players();
    heli thread destroy_vehicles();
    heli.goalradius = 4;
    heli setvehgoalpos( heli.exfil_struct.origin, 1 );
    heli waittill( "goal" );
    heli vehicle_setspeedimmediate( 0 );
    heli vehicle_cleardrivingstate();
    level notify( "arrived_at_exfil_location" );
    level.exfil_heli_landing = undefined;
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0x1f92
// Size: 0x127
function destroy_vehicles()
{
    self endon( "goal" );
    wait 4;
    
    if ( !isdefined( level.vehicle ) )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle.instances ) )
    {
        return;
    }
    
    foreach ( vehicles_instance in level.vehicle.instances )
    {
        foreach ( vehicle in vehicles_instance )
        {
            if ( !isdefined( vehicle ) || !isdefined( vehicle.origin ) )
            {
                continue;
            }
            
            if ( vehicle == self )
            {
                continue;
            }
            
            if ( distance2d( vehicle.origin, self.origin ) < 512 )
            {
                vehicle dodamage( vehicle.health + 1000, self.origin );
            }
        }
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0x20c1
// Size: 0x114
function keep_from_crushing_players()
{
    self endon( "goal" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( self ) )
            {
                thread move_player_from_under_heli( player );
            }
            
            thread kill_sentries( player );
            thread kill_tac_covers( player );
        }
        
        if ( isdefined( level.hvtlist ) )
        {
            foreach ( hvt in level.hvtlist )
            {
                if ( isdefined( hvt ) && !istrue( hvt.carried ) && distance2d( self.origin, hvt.origin ) <= 200 )
                {
                    thread move_hvt_from_under_heli( hvt );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0x21dd
// Size: 0xcc
function kill_tac_covers( player )
{
    if ( isdefined( player.taccovers ) && isarray( player.taccovers ) && player.taccovers.size > 0 )
    {
        foreach ( tac_cover in player.taccovers )
        {
            if ( isdefined( tac_cover ) && isdefined( tac_cover.collision ) )
            {
                if ( tac_cover istouching( self ) || tac_cover.collision istouching( self ) )
                {
                    tac_cover scripts\cp\powers\cp_tactical_cover::tac_cover_delete( 0.05 );
                }
            }
        }
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0x22b1
// Size: 0x175
function kill_sentries( player )
{
    if ( isdefined( player.placedsentries ) )
    {
        if ( isdefined( player.placedsentries[ "sentry_turret" ] ) && isarray( player.placedsentries[ "sentry_turret" ] ) && player.placedsentries[ "sentry_turret" ].size > 0 )
        {
            foreach ( turret in player.placedsentries[ "sentry_turret" ] )
            {
                if ( isdefined( turret ) )
                {
                    if ( turret istouching( self ) )
                    {
                        turret notify( "kill_turret", 1, 0 );
                    }
                }
            }
        }
        
        if ( isdefined( player.placedsentries[ "manual_turret" ] ) && isarray( player.placedsentries[ "manual_turret" ] ) && player.placedsentries[ "manual_turret" ].size > 0 )
        {
            foreach ( turret in player.placedsentries[ "manual_turret" ] )
            {
                if ( isdefined( turret ) )
                {
                    if ( turret istouching( self ) )
                    {
                        turret notify( "kill_turret", 1, 0 );
                    }
                }
            }
        }
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0x242e
// Size: 0x5a
function move_player_from_under_heli( player )
{
    vec = player.origin - self.origin;
    vec = vectornormalize( vec );
    vec *= 200;
    vec = ( vec[ 0 ], vec[ 1 ], 0 );
    player setorigin( player.origin + vec, 1 );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0x2490
// Size: 0x65
function move_hvt_from_under_heli( hvt )
{
    vec = hvt.origin - self.origin;
    vec = vectornormalize( vec );
    vec *= 200;
    vec = ( vec[ 0 ], vec[ 1 ], 0 );
    hvt.origin += vec;
    hvt notify( "displaced" );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 2
// Checksum 0x0, Offset: 0x24fd
// Size: 0xe7
function get_nearby_enemy( org, dist_check )
{
    if ( !isdefined( dist_check ) )
    {
        dist_check = 2250000;
    }
    
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam( "axis" );
    guys = sortbydistance( guys, self.origin );
    
    foreach ( guy in guys )
    {
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        if ( distancesquared( guy.origin, org ) < dist_check && scripts\engine\trace::ray_trace_passed( self.origin + ( 0, 0, -250 ), guy.origin + ( 0, 0, 100 ), guys ) )
        {
            return guy;
        }
    }
    
    return undefined;
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 2
// Checksum 0x0, Offset: 0x25ed
// Size: 0x184
function heli_mg_create( mg_model, turret_weapon )
{
    tag = "tag_flash";
    originoffset = ( -64, 0, 0 );
    origin = self gettagorigin( tag );
    
    if ( !isdefined( turret_weapon ) )
    {
        turret_weapon = "sentry_minigun_mp";
    }
    
    self.minigun = spawnturret( "misc_turret", origin, turret_weapon );
    self.minigun.angles = self gettagangles( tag );
    
    if ( isdefined( mg_model ) )
    {
        self.minigun setmodel( mg_model );
    }
    else
    {
        self.minigun setmodel( "veh8_mil_air_ahotel64_turret_wm" );
    }
    
    self.minigun linkto( self, tag, originoffset, ( 0, 0, 0 ) );
    self.minigun setturretteam( "axis" );
    self.minigun setmode( "auto_nonai" );
    self.minigun setdefaultdroppitch( 0 );
    self.minigun setleftarc( 360 );
    self.minigun setrightarc( 360 );
    self.minigun settoparc( 180 );
    self.minigun setbottomarc( 180 );
    self.minigun setconvergencetime( 0.05, "yaw" );
    self.minigun setconvergencetime( 0.05, "pitch" );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0x2779
// Size: 0x2b
function rumble_nearby_players()
{
    self endon( "death" );
    
    while ( true )
    {
        playrumbleonposition( "cp_chopper_rumble", self.origin );
        wait 0.2;
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0x27ac
// Size: 0x45
function rideloop( player )
{
    level endon( "game_ended" );
    player endon( "death" );
    player endon( "disconnect" );
    
    while ( true )
    {
        anim_player_solo( player, player.player_rig, "exfil_idle", "body_animate_jnt" );
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0x27f9
// Size: 0x8e
function damage_players_on_blades()
{
    self endon( "death" );
    rotor_trigger = spawn( "trigger_radius", self.origin, 0, 350, 64 );
    rotor_trigger enablelinkto();
    rotor_trigger linkto( self, "tag_origin" );
    tail_trigger = spawn( "trigger_radius", self gettagorigin( "tail_rotor_jnt" ), 0, 64, 64 );
    tail_trigger enablelinkto();
    tail_trigger linkto( self, "tail_rotor_jnt" );
    rotor_trigger thread blade_trigger_think( self );
    tail_trigger thread blade_trigger_think( self );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0x288f
// Size: 0xab
function blade_trigger_think( heli )
{
    heli endon( "death" );
    
    while ( true )
    {
        self waittill( "trigger", ent );
        
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        if ( istrue( ent.inlaststand ) )
        {
            ent notify( "force_bleed_out" );
            continue;
        }
        
        if ( istrue( ent.isjuggernaut ) )
        {
            ent scripts\cp\cp_juggernaut::jugg_removejuggernaut();
        }
        
        ent setvelocity( ( -500, 0, 500 ) );
        ent.shouldskiplaststand = 1;
        ent dodamage( ent.health + 1000, self.origin );
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 0
// Checksum 0x0, Offset: 0x2942
// Size: 0x25
function function_a195b29bf788fbc7()
{
    scripts\cp\interaction::register_interaction( "exfil_spot", "null", undefined, &function_1ef16b5bead75324, &function_f0e0473d6c709fdc, 0, 0, &function_b540a63f7d14e39f );
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0x296f
// Size: 0x12f
function function_53b91a8ca24ad84( active )
{
    while ( !isdefined( level.var_ec373b5131038e2d ) )
    {
        wait 0.1;
    }
    
    if ( istrue( active ) )
    {
        objnum = scripts\cp\cp_objectives::requestworldid( "exfil_loc", 10 );
        objective_state( objnum, "current" );
        objective_icon( objnum, "icon_waypoint_objective_general" );
        objective_setminimapiconsize( objnum, "icon_regular" );
        objective_setshowdistance( objnum, 1 );
        objective_setplayintro( objnum, 1 );
        objective_setlabel( objnum, &"CP_STRIKE/CALL_EXFIL" );
        
        foreach ( interaction_struct in level.var_ec373b5131038e2d )
        {
            objective_position( objnum, interaction_struct.origin );
            scripts\cp\interaction::add_to_current_interaction_list( interaction_struct );
        }
        
        return;
    }
    
    foreach ( interaction_struct in level.var_ec373b5131038e2d )
    {
        scripts\cp\interaction::remove_from_current_interaction_list( interaction_struct );
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 1
// Checksum 0x0, Offset: 0x2aa6
// Size: 0x5e
function function_b540a63f7d14e39f( var_6071184f8a3861b3 )
{
    level.var_ec373b5131038e2d = var_6071184f8a3861b3;
    
    foreach ( interaction_struct in var_6071184f8a3861b3 )
    {
        scripts\cp\interaction::add_to_current_interaction_list( interaction_struct );
    }
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 2
// Checksum 0x0, Offset: 0x2b0c
// Size: 0x18
function function_1ef16b5bead75324( interaction_struct, player )
{
    return &"CP_STRIKE/CALL_EXFIL";
}

// Namespace blima_exfil / scripts\cp\infilexfil\blima_exfil
// Params 2
// Checksum 0x0, Offset: 0x2b2d
// Size: 0x4b
function function_f0e0473d6c709fdc( interaction_struct, player )
{
    player endon( "disconnect" );
    scripts\cp\cp_objectives::freeworldid( "exfil_loc" );
    level notify( "call_exfil", player.origin, 1 );
    scripts\cp\interaction::remove_from_current_interaction_list( interaction_struct );
    player scripts\cp\interaction::refresh_interaction();
}

