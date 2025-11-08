#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\utility;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\vo;
#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;

#namespace ai_flare;

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 0
// Checksum 0x0, Offset: 0x843
// Size: 0xa3
function load_fx()
{
    level._effect[ "vfx_flare_launch" ] = loadfx( "vfx/iw8/level/embassy/vfx_mortar_fire.vfx" );
    level._effect[ "vfx_flare_trail" ] = loadfx( "vfx/iw8/level/embassy/vfx_illumination_flare_launch_trail.vfx" );
    level._effect[ "vfx_mortar_trail" ] = loadfx( "vfx/iw9/cp/vfx_cp_mortar_trail.vfx" );
    level._effect[ "alarm_light_flash" ] = loadfx( "vfx/iw8_cp/level/cp_millbase/vfx_alarm_light.vfx" );
    level._effect[ "vfx_mortar_explosion" ] = loadfx( "vfx/iw8/weap/_explo/mortar/vfx_mortar_explosion_bm.vfx" );
    script_model_anims();
    level.next_mortar_vo = gettime();
    level.mortars = [];
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0x8ee
// Size: 0x141
function run_to_and_launch_flare( launcher, var_68ee057779a106c1 )
{
    self endon( "death" );
    self endon( "teleport_to_nearby_spawner" );
    launcher.fired = 0;
    thread handle_ai_launcher_death( launcher );
    self.going_to_object = launcher;
    old_radius = self.goalradius;
    utility::demeanor_override( "sprint" );
    self.never_kill_off_old = self.never_kill_off;
    self.never_kill_off = 1;
    self.dont_kill_off_old = self.dont_kill_off;
    self.dont_kill_off = 1;
    run_to_launcher( launcher );
    enter_launcher( launcher );
    fire_launcher( launcher );
    exit_launcher( launcher );
    self.goalradius = old_radius;
    self.going_to_object = undefined;
    
    if ( isdefined( var_68ee057779a106c1 ) )
    {
        self.goalradius = 128;
        launcher.operator = self;
        thread mortar_cooldown( launcher );
    }
    
    clear_custom_anim();
    utility::clear_demeanor_override();
    
    if ( isdefined( self.never_kill_off_old ) )
    {
        self.never_kill_off = self.never_kill_off_old;
    }
    
    if ( isdefined( self.dont_kill_off_old ) )
    {
        self.dont_kill_off = self.dont_kill_off_old;
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0xa37
// Size: 0x4b
function mortar_cooldown( launcher )
{
    waittill_any_2( "death", "teleport_to_nearby_spawner" );
    
    if ( isdefined( launcher ) && isent( launcher ) )
    {
        launcher.operator = undefined;
        launcher.oncooldown = gettime() + 45000;
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0xa8a
// Size: 0x4f
function enter_launcher( launcher )
{
    ai_anim( "sdr_mortar_enter", 0.7 );
    launcher scriptmodelplayanimdeltamotion( "emb_vm_mortar_mortar", "mortar", 0.7 );
    wait 0.5;
    launcher showpart( "j_mortar_shell", "misc_wm_mortar" );
    wait 0.2;
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0xae1
// Size: 0x75
function fire_launcher( launcher )
{
    ai_anim( "sdr_mortar_launch", 0.4 );
    
    if ( launcher.script_noteworthy == "flare" )
    {
        launcher thread launch_illumination_flare();
    }
    else
    {
        launcher thread launch_mortar( undefined, undefined, self );
    }
    
    launcher hidepart( "j_mortar_shell", "misc_wm_mortar" );
    wait 0.4;
    self notify( "launch_done" );
    launcher.fired = 1;
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0xb5e
// Size: 0x17
function exit_launcher( launcher )
{
    ai_anim( "sdr_mortar_exit" );
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0xb7d
// Size: 0x23
function reload_launcher( launcher )
{
    launcher scriptmodelplayanimdeltamotion( "emb_wm_mortar_reload_mortar" );
    ai_anim( "sdr_mortar_reload" );
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0xba8
// Size: 0x27
function run_to_launcher( launcher )
{
    goal = get_flare_launch_entrance( self, launcher );
    goto_anim_pos( goal, 0 );
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0xbd7
// Size: 0x15c
function get_flare_launch_entrance( agent, launcher )
{
    if ( getdvar( @"ui_mapname" ) == "cp_observatory" || getdvar( @"ui_mapname" ) == "cp_lone" )
    {
        org = launcher gettagorigin( "tag_origin" );
        ang = launcher gettagangles( "tag_origin" );
        pos = spawnstruct();
        pos.origin = org + anglestoforward( launcher.angles ) * 5;
        pos.angles = ang;
        return pos;
    }
    
    animindex = agent scripts\asm\asm::asm_lookupanimfromalias( "animscripted", "sdr_mortar_enter" );
    xanim = agent scripts\asm\asm::asm_getxanim( "animscripted", animindex );
    org = launcher gettagorigin( "tag_origin" );
    ang = launcher gettagangles( "tag_origin" );
    pos = spawnstruct();
    pos.origin = getstartorigin( org, ang, xanim ) + anglestoforward( launcher.angles ) * 5;
    pos.angles = getstartangles( org, ang, xanim );
    pos.animindex = animindex;
    pos.xanim = xanim;
    return pos;
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0xd3c
// Size: 0x52
function ai_anim( animalias, early_return )
{
    if ( getdvar( @"ui_mapname" ) == "cp_observatory" )
    {
        return;
    }
    
    take_ai_weapon();
    
    if ( isdefined( early_return ) )
    {
        scripts\asm\shared\mp\utility::animscripted_single_earlyend( animalias, early_return );
    }
    else
    {
        scripts\asm\shared\mp\utility::animscripted_single( animalias );
    }
    
    restore_ai_weapon();
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0xd96
// Size: 0x2a
function ai_anim_relative( animalias, ent )
{
    take_ai_weapon();
    scripts\asm\shared\mp\utility::animscripted_single_relative( animalias, ent );
    restore_ai_weapon();
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0xdc8
// Size: 0x14d
function goto_anim_pos( goal, link )
{
    self.scripted_mode = 1;
    self.playing_skit = 1;
    self.goalradius = 8;
    self.script_radius = 8;
    self setgoalpos( self getclosestreachablepointonnavmesh( goal.origin ) );
    waittill_near_goal( goal.origin, squared( 384 ) );
    self.goalradius = 8;
    self.script_radius = 8;
    self.ignoreall = 1;
    self.allowpain = 0;
    self waittill( "goal" );
    
    if ( !isdefined( goal.angles ) )
    {
        goal.angles = ( 0, 0, 0 );
    }
    
    self setplayerangles( goal.angles );
    self forceteleport( goal.origin, goal.angles );
    
    if ( istrue( link ) )
    {
        self.anchor = spawn( "script_origin", goal.origin );
        self.anchor.angles = goal.angles;
        self linkto( self.anchor );
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0xf1d
// Size: 0x1a9
function launch_illumination_flare( start, end )
{
    if ( !isdefined( start ) )
    {
        start = self gettagorigin( "j_shaft_top" );
    }
    
    if ( !isdefined( end ) )
    {
        end = self.origin + anglestoforward( self.angles ) * 2000 + ( 0, 0, 1000 );
    }
    
    flare = spawn_tag_origin( self gettagorigin( "j_shaft_top" ), ( 0, 0, 0 ) );
    playfx( getfx( "vfx_flare_launch" ), self.origin + ( 0, 0, 3 ) + anglestoforward( self.angles ) * 8, anglestoforward( self.angles ) );
    playsoundatpos( self gettagorigin( "j_shaft_top" ), "weap_mortar_flare_launch" );
    flare show();
    time = 2.25;
    thread movemortar( flare, start, end, time, 400 );
    wait 0.1;
    playfxontag( getfx( "vfx_flare_trail" ), flare, "tag_origin" );
    flare playsoundonmovingent( "weap_mortar_flare_whistle" );
    wait time;
    playfxontag( getfx( "vfx_flare" ), flare, "tag_origin" );
    stopfxontag( getfx( "vfx_flare_trail" ), flare, "tag_origin" );
    flare thread flare_mover( end );
    flare playsound( "weap_mortar_flare_burst" );
    flare playsound( "weap_mortar_flare_phosphorus_start" );
    wait 0.1;
    flare playloopsound( "weap_mortar_flare_phosphorus_lp" );
    wait 8;
    flare playsound( "weap_mortar_flare_phosphorus_end" );
    wait 2;
    flare delete();
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 4
// Checksum 0x0, Offset: 0x10ce
// Size: 0x292
function launch_mortar( start, end, agent, optional_height )
{
    if ( !isdefined( start ) )
    {
        start = self gettagorigin( "j_shaft_top" );
    }
    
    if ( isdefined( level.get_mortar_impact_pos ) )
    {
        end = agent [[ level.get_mortar_impact_pos ]]( self );
    }
    
    if ( !isdefined( end ) )
    {
        end = getgroundposition( self.origin + anglestoforward( self.angles ) * 2000, 8, 1000 );
    }
    
    thread vo_incoming_mortar( end );
    mortar = spawn_tag_origin( self gettagorigin( "j_shaft_top" ), ( 0, 0, 0 ) );
    playfx( getfx( "vfx_flare_launch" ), self.origin + ( 0, 0, 3 ) + anglestoforward( self.angles ) * 8, anglestoforward( self.angles ) );
    playsoundatpos( self gettagorigin( "j_shaft_top" ), "weap_mortar_fire_dist" );
    mortar show();
    level.mortars = array_add( level.mortars, mortar );
    time = 5;
    apex_height = 1200;
    
    if ( isdefined( optional_height ) )
    {
        apex_height = optional_height;
    }
    
    thread movemortar( mortar, start, end, time, apex_height );
    wait_until_impact( mortar, time );
    
    if ( isdefined( mortar ) )
    {
        stopfxontag( getfx( "vfx_mortar_trail" ), mortar, "tag_origin" );
        mortar stoploopsound();
        end = mortar.origin;
        z_offset = ( 0, 0, 40 );
        
        if ( isalive( agent ) )
        {
            radiusdamage( end + z_offset, 256, 200, 150, agent, "MOD_EXPLOSIVE", "c4_mp" );
        }
        else
        {
            radiusdamage( end + z_offset, 256, 200, 150, mortar, "MOD_EXPLOSIVE", "c4_mp" );
        }
        
        playfx( getfx( "vfx_mortar_explosion" ), end );
        earthquake( 0.25, 3, end, 2048 );
        playrumbleonposition( "cp_chopper_rumble", end );
        magicgrenademanual( "mortar_mp", end + ( 0, 0, 5 ), ( 0, 0, 0 ), 0.05 );
        level.mortars = array_remove( level.mortars, mortar );
        mortar delete();
        return;
    }
    
    level.mortars = scripts\engine\utility::array_removeundefined( level.mortars );
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0x1368
// Size: 0x70
function wait_until_impact( mortar, time )
{
    mortar endon( "early_impact" );
    mortar endon( "death" );
    mortar setmodel( "equipment_mortar_shell_improvised_01" );
    wait 0.1;
    playfxontag( getfx( "vfx_mortar_trail" ), mortar, "tag_origin" );
    mortar playloopsound( "weap_mortar_fly_lp" );
    wait time - 1.7;
    mortar playsound( "weap_mortar_incoming" );
    wait 1.7;
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x13e0
// Size: 0x85
function flare_mover( end )
{
    self endon( "death" );
    
    while ( isdefined( self ) )
    {
        x = self.origin[ 0 ] + randomintrange( -5, 5 );
        y = self.origin[ 1 ] + randomintrange( -5, 5 );
        z = self.origin[ 2 ] - 15;
        self moveto( ( x, y, z ), 1 );
        wait 1;
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 5
// Checksum 0x0, Offset: 0x146d
// Size: 0x19d
function movemortar( model, start, end, time, height )
{
    model endon( "death" );
    apex = 1200;
    
    if ( isdefined( height ) )
    {
        apex = height;
    }
    
    framefrac = 1 / time / 0.05;
    frac = 0;
    impact_point = undefined;
    
    while ( frac < 1 )
    {
        if ( isdefined( impact_point ) )
        {
            if ( frac + framefrac < 1 )
            {
                model.origin = impact_point;
                model notify( "early_impact" );
                return;
            }
        }
        
        model.origin = math::get_point_on_parabola( start, end, apex, frac );
        next_frac = frac + framefrac;
        next_point = math::get_point_on_parabola( start, end, apex, next_frac );
        impact_point = check_for_early_impact( model, next_point );
        model anglemortar();
        
        /#
            if ( istrue( level.mortar_debug ) )
            {
                thread draw_line_for_time( model.origin, model.origin + ( 0, 0, 128 ), 1, 1, 1, 0.05 );
            }
        #/
        
        frac += framefrac;
        wait 0.05;
    }
    
    model.origin = end;
    
    /#
        if ( istrue( level.mortar_debug ) )
        {
            thread draw_line_for_time( model.origin, model.origin + ( 0, 0, 128 ), 1, 1, 1, 5 );
        }
    #/
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0x1612
// Size: 0x79
function check_for_early_impact( mortar, next_loc )
{
    collisioncontents = physics_createcontents( [ "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot" ] );
    raytrace = scripts\engine\trace::ray_trace( mortar.origin, next_loc, mortar, collisioncontents );
    
    if ( raytrace[ "hittype" ] != "hittype_none" )
    {
        return next_loc;
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 0
// Checksum 0x0, Offset: 0x1693
// Size: 0x5f
function anglemortar()
{
    if ( !isdefined( self.prevorigin ) )
    {
        self.prevorigin = self.origin;
        self.roll = 0;
        return;
    }
    
    self.angles = vectortoangles( self.origin - self.prevorigin );
    self.prevorigin = self.origin;
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x16fa
// Size: 0x34
function handle_ai_launcher_death( launcher )
{
    self waittill( "death" );
    self endon( "launch_done" );
    
    if ( isent( launcher ) )
    {
        launcher hidepart( "j_mortar_shell", "misc_wm_mortar" );
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x1736
// Size: 0xc7
function run_to_and_set_alarm( var_deb561f66ca63d05 )
{
    self endon( "death" );
    old_radius = self.goalradius;
    
    if ( !isdefined( var_deb561f66ca63d05.angles ) )
    {
        var_deb561f66ca63d05.angles = ( 0, 0, 0 );
    }
    
    alarm_box = getent( var_deb561f66ca63d05.target, "targetname" );
    
    if ( istrue( alarm_box.alarm_on ) )
    {
        return;
    }
    
    self.going_to_object = var_deb561f66ca63d05;
    goto_anim_pos( var_deb561f66ca63d05, 1 );
    ai_turnon_alarm( alarm_box );
    self.goalradius = old_radius;
    self.going_to_object = undefined;
    self.script_radius = self.goalradius;
    clear_custom_anim();
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x1805
// Size: 0x43
function ai_turnon_alarm( alarm_box )
{
    alarm_box scriptmodelplayanim( "wm_eq_fusebox_turn_on_prop" );
    ai_anim( "sdr_fusebox_on" );
    alarm_fx_on( alarm_box );
    alarm_box ent_flag_set( "switch_on" );
    alarm_box thread auto_alarm_turnoff( 60 );
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x1850
// Size: 0x45
function auto_alarm_turnoff( timeout )
{
    self endon( "turned_off" );
    wait timeout;
    self makeunusable();
    self scriptmodelplayanim( "wm_eq_fusebox_prop" );
    alarm_fx_off( self );
    ent_flag_clear( "switch_on" );
    wait 1;
    self makeusable();
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x189d
// Size: 0x2b
function ai_turnoff_alarm( alarm_box )
{
    alarm_box scriptmodelplayanim( "wm_eq_fusebox_prop" );
    ai_anim( "sdr_fusebox_off" );
    alarm_fx_off( alarm_box );
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0x18d0
// Size: 0x87
function alarm_box_player_interaction( alarm_box, toggle_fx )
{
    alarm_box makeusable();
    alarm_box sethintstring( &"CP_STRIKE/TURN_ON_ALARM" );
    alarm_box sethinttag( "j_handle" );
    alarm_box sethintdisplayrange( 128 );
    alarm_box setcursorhint( "HINT_BUTTON" );
    alarm_box sethinticon( "icon_electrical_box" );
    alarm_box sethintdisplayfov( 120 );
    alarm_box sethintonobstruction( "hide" );
    alarm_box sethintrequiresholding( 0 );
    alarm_box setuseholdduration( "duration_short" );
    alarm_box thread alarmbox2_logic( alarm_box, toggle_fx );
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x195f
// Size: 0x7d
function toggle_alarm( alarm_box )
{
    alarm_box.alarm_on = 0;
    
    while ( true )
    {
        alarm_box waittill( "trigger" );
        alarm_box makeunusable();
        
        if ( alarm_box.alarm_on )
        {
            alarm_box scriptmodelplayanim( "wm_eq_fusebox_prop" );
            alarm_fx_off( alarm_box );
        }
        else
        {
            scripts\asm\shared\mp\utility::animscripted_single( "sdr_fusebox_on" );
            alarm_fx_on( alarm_box );
            alarm_box thread auto_alarm_turnoff( 60 );
        }
        
        wait 3;
        alarm_box makeusable();
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0x19e4
// Size: 0x126
function attract_agent_to_alarm( attract_pos, alarm_box )
{
    attract_pos endon( "stop_attracting" );
    mortar = getclosest( attract_pos.origin, getentarray( "ai_flare", "targetname" ), 512 );
    
    if ( isdefined( mortar ) )
    {
        mortar.attracting = 0;
        mortar.fired = 0;
    }
    
    while ( true )
    {
        if ( istrue( alarm_box.alarm_on ) )
        {
            while ( istrue( alarm_box.alarm_on ) )
            {
                wait 1;
            }
            
            if ( isdefined( mortar ) )
            {
                mortar notify( "stop_attracting" );
                mortar.attracting = 0;
            }
        }
        else
        {
            if ( isdefined( mortar ) && !mortar.attracting && !mortar.fired )
            {
                mortar thread attract_agent_to_mortar( mortar );
                mortar.attracting = 1;
            }
            
            runner = attract_an_agent( attract_pos, 2048 );
            
            if ( isdefined( runner ) )
            {
                runner run_to_and_set_alarm( attract_pos );
                
                if ( !alarm_box.alarm_on )
                {
                    wait 2;
                }
                else
                {
                    return;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 3
// Checksum 0x0, Offset: 0x1b12
// Size: 0xfb
function attract_agent_to_mortar( mortar, var_68ee057779a106c1, radius_override )
{
    mortar endon( "stop_attracting" );
    
    while ( true )
    {
        runner = undefined;
        
        if ( isdefined( mortar.operator ) && isalive( mortar.operator ) )
        {
            runner = mortar.operator;
        }
        else
        {
            if ( isdefined( mortar.oncooldown ) && gettime() < mortar.oncooldown )
            {
                wait 1;
                continue;
            }
            
            mortar.operator = undefined;
            rad = 1024;
            
            if ( isdefined( radius_override ) )
            {
                rad = radius_override;
            }
            
            runner = attract_an_agent( mortar, rad );
        }
        
        if ( isdefined( runner ) )
        {
            runner run_to_and_launch_flare( mortar, var_68ee057779a106c1 );
            
            if ( istrue( mortar.fired ) )
            {
                level notify( "flare_launched" );
                mortar.attracting = 0;
                return;
            }
            else
            {
                wait 5;
            }
        }
        
        wait 1;
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0x1c15
// Size: 0x6c
function initialize_alarm_box( var_deb561f66ca63d05, toggle_fx )
{
    if ( !isdefined( toggle_fx ) )
    {
        toggle_fx = 1;
    }
    
    alarm_box = getent( var_deb561f66ca63d05.target, "targetname" );
    alarm_box_player_interaction( alarm_box, toggle_fx );
    var_deb561f66ca63d05.alarm_box = alarm_box;
    alarm_box ent_flag_init( "switch_on" );
    alarm_box.scenenode = var_deb561f66ca63d05;
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0x1c89
// Size: 0x1f2
function attract_an_agent( object, attract_radius )
{
    alive_enemies = scripts\mp\mp_agent::getaliveagentsofteam( "axis" );
    players_close = !istrue( object.ignoreplayers ) && any_player_nearby( object.origin, squared( 384 ) );
    
    if ( !alive_enemies.size || players_close )
    {
        return undefined;
    }
    
    closest_enemies = get_array_of_closest( object.origin, alive_enemies, undefined, 4, attract_radius );
    
    for ( i = 0; i < closest_enemies.size ; i++ )
    {
        if ( isdefined( closest_enemies[ i ].going_to_object ) )
        {
            continue;
        }
        
        if ( isdefined( closest_enemies[ i ].spawnpoint ) && isdefined( closest_enemies[ i ].spawnpoint.script_aigroup ) && closest_enemies[ i ].spawnpoint.script_aigroup == "nomortars" )
        {
            continue;
        }
        
        if ( !istrue( closest_enemies[ i ].entered_combat ) )
        {
            continue;
        }
        
        if ( closest_enemies[ i ] isjuggernaut() )
        {
            continue;
        }
        
        if ( isdefined( closest_enemies[ i ].unittype ) && closest_enemies[ i ].unittype == "suicidebomber" )
        {
            continue;
        }
        
        if ( istrue( closest_enemies[ i ].playing_skit ) )
        {
            continue;
        }
        
        if ( closest_enemies[ i ] scripts\cp\spawning::is_riding_vehicle() )
        {
            continue;
        }
        
        if ( istrue( closest_enemies[ i ].attempting_teleport ) )
        {
            continue;
        }
        
        arcname = undefined;
        
        if ( isdefined( closest_enemies[ i ].animationarchetype ) )
        {
            arcname = closest_enemies[ i ].animationarchetype;
        }
        else
        {
            arcname = closest_enemies[ i ].animsetname;
        }
        
        if ( !isdefined( arcname ) )
        {
            continue;
        }
        
        if ( arcname != "soldier" && arcname != "soldier_cp" )
        {
            continue;
        }
        
        return closest_enemies[ i ];
    }
    
    return undefined;
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 0
// Checksum 0x0, Offset: 0x1e84
// Size: 0x6d
function clear_custom_anim()
{
    self allowedstances( "stand", "prone", "crouch" );
    scripts\asm\shared\mp\utility::animscripted_clear();
    
    if ( !istrue( self.dont_enter_combat ) )
    {
        self.ignoreall = 0;
    }
    
    self.scripted_mode = 0;
    self.playing_skit = undefined;
    
    if ( isdefined( self.anchor ) )
    {
        self unlink();
        self.anchor delete();
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x1ef9
// Size: 0x97
function alarm_fx_off( alarm_box )
{
    light = getent( alarm_box.target, "targetname" );
    speaker = getent( light.target, "targetname" );
    light setmodel( "ee_light_mounted_exterior_industrial_caged_02" );
    stopfxontag( level._effect[ "alarm_light_flash" ], light, "tag_origin" );
    speaker stoploopsound();
    self.alarm_on = 0;
    self sethintstring( &"CP_STRIKE/TURN_ON_ALARM" );
    alarm_box notify( "turned_off" );
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x1f98
// Size: 0xa8
function alarm_fx_on( alarm_box )
{
    light = getent( alarm_box.target, "targetname" );
    speaker = getent( light.target, "targetname" );
    light setmodel( "ee_light_mounted_exterior_industrial_caged_02_on" );
    playfxontag( level._effect[ "alarm_light_flash" ], light, "tag_origin" );
    speaker playloopsound( "milbase_alarm" );
    alarm_box sethintstring( &"CP_STRIKE/TURN_OFF_ALARM" );
    alarm_box.alarm_on = 1;
    level notify( "alarm_on" );
    level notify( "weapons_free" );
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x2048
// Size: 0x77
function run_to_and_plant_bomb( bomb_ent )
{
    self endon( "death" );
    bomb_ent.planted = 0;
    self.going_to_object = bomb_ent;
    old_radius = self.goalradius;
    run_to_bomb_location( self, bomb_ent );
    plant_bomb( bomb_ent );
    bomb_ent.planted = 1;
    self.goalradius = old_radius;
    self.going_to_object = undefined;
    clear_custom_anim();
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0x20c7
// Size: 0xe0
function run_to_bomb_location( agent, bomb_ent )
{
    animindex = agent scripts\asm\asm::asm_lookupanimfromalias( "animscripted", "sdr_plant_bomb" );
    xanim = agent scripts\asm\asm::asm_getxanim( "animscripted", animindex );
    org = bomb_ent gettagorigin( "tag_origin" );
    ang = bomb_ent gettagangles( "tag_origin" );
    pos = spawnstruct();
    pos.origin = getstartorigin( org, ang, xanim );
    pos.angles = getstartangles( org, ang, xanim );
    pos.animindex = animindex;
    pos.xanim = xanim;
    agent.ignoreall = 1;
    agent goto_anim_pos( pos, 0 );
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x21af
// Size: 0x8b
function plant_bomb( bomb_ent )
{
    charge = spawn( "script_model", self.origin );
    charge.angles = self.angles;
    charge setmodel( "offhand_wm_c4" );
    charge scriptmodelplayanimdeltamotion( "wm_equip_c4_attach_c4" );
    bomb_ent.charge = charge;
    thread plant_bomb_cleanup_on_death( bomb_ent, charge );
    charge thread show_charge();
    ai_anim_relative( "sdr_plant_bomb", bomb_ent );
    self notify( "bomb_planted" );
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 0
// Checksum 0x0, Offset: 0x2242
// Size: 0x1d
function show_charge()
{
    self endon( "death" );
    self hide();
    wait 0.5;
    self show();
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0x2267
// Size: 0x2e
function plant_bomb_cleanup_on_death( bomb_ent, charge )
{
    self endon( "bomb_planted" );
    self waittill( "death" );
    
    if ( isdefined( charge ) )
    {
        charge delete();
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x229d
// Size: 0x6a
function attract_agent_to_bomb_plant( bomb_plant )
{
    bomb_plant endon( "stop_attracting" );
    
    while ( true )
    {
        runner = attract_an_agent( bomb_plant, 1024 );
        
        if ( isdefined( runner ) )
        {
            runner run_to_and_plant_bomb( bomb_plant );
            
            if ( istrue( bomb_plant.planted ) )
            {
                bomb_plant.attracting = 0;
                return;
            }
            else
            {
                wait randomintrange( 5, 10 );
            }
        }
        
        wait 1;
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0x230f
// Size: 0x15d
function alarmbox2_logic( alarm_box, toggle_fx )
{
    level endon( "game_ended" );
    alarm_box.alarm_on = 0;
    
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        alarm_box makeunusable();
        actorplayer = anim_scene_create_actor( player, "player_rig", 1 );
        var_3a5cd5b61d43290c = anim_scene_create_actor( self, "fusebox_prop" );
        
        if ( !ent_flag( "switch_on" ) )
        {
            var_3a5cd5b61d43290c anim_scene_set_actor_interruptable( 1, "interact_on", 1 );
            result = self.scenenode anim_scene( [ var_3a5cd5b61d43290c ], "interact_on" );
            ent_flag_set( "switch_on" );
            alarm_box.alarm_on = 1;
            
            if ( result && istrue( toggle_fx ) )
            {
                alarm_fx_on( alarm_box );
            }
        }
        else
        {
            var_3a5cd5b61d43290c anim_scene_set_actor_interruptable( 1, "interact", 1 );
            result = self.scenenode anim_scene( [ var_3a5cd5b61d43290c ], "interact" );
            ent_flag_clear( "switch_on" );
            alarm_box.alarm_on = 0;
            
            if ( result && istrue( toggle_fx ) )
            {
                alarm_fx_off( alarm_box );
            }
        }
        
        alarm_box makeusable();
        actorplayer = undefined;
        var_3a5cd5b61d43290c = undefined;
    }
}

#using_animtree( "script_model" );

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 0
// Checksum 0x0, Offset: 0x2474
// Size: 0xe0
function script_model_anims()
{
    level.scr_animtree[ "player_rig" ] = #animtree;
    level.scr_anim[ "player_rig" ][ "interact" ] = %wm_eq_fusebox_plr;
    level.scr_eventanim[ "player_rig" ][ "interact" ] = %"wm_eq_fusebox_plr";
    level.scr_anim[ "player_rig" ][ "interact_on" ] = %wm_eq_fusebox_turn_on_plr;
    level.scr_eventanim[ "player_rig" ][ "interact_on" ] = %"wm_eq_fusebox_turn_on_plr";
    level.scr_animtree[ "fusebox_prop" ] = #animtree;
    level.scr_anim[ "fusebox_prop" ][ "interact" ] = %wm_eq_fusebox_prop;
    level.scr_anim[ "fusebox_prop" ][ "interact_on" ] = %wm_eq_fusebox_turn_on_prop;
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x255c
// Size: 0x106
function vo_incoming_mortar( pos )
{
    snds = [ "dx_cps_kama_callout_mortar_attacking_10", "dx_cps_kama_callout_mortar_attacking_20", "dx_cps_lass_callout_mortar_attacking_10", "dx_cps_lass_callout_mortar_attacking_20" ];
    players = give_all_players_nearby( pos, squared( 512 ) );
    snd = random( snds );
    
    foreach ( player in players )
    {
        if ( !isdefined( player.next_mortar_vo ) )
        {
            player.next_mortar_vo = gettime() + 30000;
        }
        else if ( gettime() < player.next_mortar_vo )
        {
            continue;
        }
        
        player.next_mortar_vo = gettime() + 30000;
        thread scripts\cp\vo::try_to_play_vo_for_one_player( snd, player );
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 0
// Checksum 0x0, Offset: 0x266a
// Size: 0x65
function take_ai_weapon()
{
    self.old_weapon = self.weapon;
    self.anim_weapon = scripts\cp_mp\weapon::buildweapon( "iw9_me_fists_mp", [], "none", "none", -1 );
    self giveweapon( self.anim_weapon );
    self takeweapon( self.old_weapon );
    self setspawnweapon( self.anim_weapon );
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 0
// Checksum 0x0, Offset: 0x26d7
// Size: 0x32
function restore_ai_weapon()
{
    self giveweapon( self.old_weapon );
    self takeweapon( self.anim_weapon );
    self setspawnweapon( self.old_weapon );
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 2
// Checksum 0x0, Offset: 0x2711
// Size: 0x47
function waittill_near_goal( origin, radius )
{
    if ( !isdefined( origin ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    while ( distancesquared( self.origin, origin ) > radius )
    {
        wait 0.1;
    }
}

// Namespace ai_flare / namespace_b430cd84d48ee8d6
// Params 1
// Checksum 0x0, Offset: 0x2760
// Size: 0x5f
function clear_mortar_settings( launcher )
{
    launcher notify( "stop_attracting" );
    clear_custom_anim();
    utility::clear_demeanor_override();
    
    if ( isdefined( self.never_kill_off_old ) )
    {
        self.never_kill_off = self.never_kill_off_old;
    }
    
    if ( isdefined( self.dont_kill_off_old ) )
    {
        self.dont_kill_off = self.dont_kill_off_old;
    }
}

