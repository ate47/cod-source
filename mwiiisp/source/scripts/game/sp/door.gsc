#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\door;
#using scripts\sp\door_internal;
#using scripts\sp\hud_util;
#using scripts\sp\outline;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;

#namespace door;

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x53d
// Size: 0x137
function init()
{
    level.interactive_doors.snakecamvision = "snake_cam";
    level.interactive_doors.fndoorinit = &_init_door_internal;
    
    if ( isdefined( level.lockpicking ) && isdefined( level.lockpicking.var_235d6de649b1ce75 ) )
    {
        level.interactive_doors.var_235d6de649b1ce75 = level.lockpicking.var_235d6de649b1ce75;
    }
    
    precacheshader( "nightvision_overlay_goggles_grain" );
    precachemodel( "offhand_wm_c4" );
    hudoutline_add_channel( "snake_cam" );
    flag_init( "snakecam_allow_exit" );
    flag_init( "exit_snakecam_immediately" );
    level.player ent_flag_init( "using_snakecam" );
    level._effect[ "c4_detonate" ] = loadfx( "vfx/iw9/core/equipment/vfx_equip_frag.vfx" );
    level._effect[ "c4_light_green" ] = loadfx( "vfx/iw8/core/c4/vfx_c4_light_green.vfx" );
    level._effect[ "c4_light_red" ] = loadfx( "vfx/iw8/core/c4/vfx_c4_light_red.vfx" );
    level._effect[ "enemy_marker" ] = loadfx( "vfx/iw8/ui/vfx_ui_snakecam_enemy_marker.vfx" );
}

// Namespace door / scripts\game\sp\door
// Params 1
// Checksum 0x0, Offset: 0x67c
// Size: 0x419
function _init_door_internal( reset )
{
    scripts\sp\door_internal::init_door_internal( reset );
    doc4 = undefined;
    docam = undefined;
    
    if ( isdefined( self.script_parameters ) )
    {
        values = strtok( self.script_parameters, " " );
        
        foreach ( value in values )
        {
            switch ( value )
            {
                case #"hash_fa1e80f6bd5b8e72":
                    doc4 = 1;
                    self.c4_breachable = 0;
                    break;
                case #"hash_34ee66c45897bc9b":
                    docam = 1;
                    self.cam_structs = [];
                    self.snakecam_active = 0;
                    break;
                case #"hash_4683ba2754c4bcb3":
                    if ( isdefined( level.interactive_doors.var_235d6de649b1ce75 ) )
                    {
                        self [[ level.interactive_doors.var_235d6de649b1ce75 ]]( self.script_parameters );
                    }
                    
                    break;
            }
        }
    }
    
    if ( isdefined( doc4 ) || isdefined( docam ) || isdefined( self.lockpick ) )
    {
        structs = get_linked_structs();
        c4_structs = [];
        
        foreach ( struct in structs )
        {
            if ( isdefined( struct.script_noteworthy ) )
            {
                struct.door = self;
                
                switch ( struct.script_noteworthy )
                {
                    case #"hash_3377515bbda6817c":
                        if ( !isdefined( docam ) )
                        {
                            break;
                        }
                        
                        if ( !isdefined( struct.radius ) )
                        {
                            struct.radius = 2.5;
                        }
                        
                        struct thread snake_cam_logic();
                        self.cam_structs[ self.cam_structs.size ] = struct;
                        break;
                    case #"hash_fa1e80f6bd5b8e72":
                        if ( !isdefined( doc4 ) )
                        {
                            break;
                        }
                        
                        if ( !isdefined( struct.radius ) )
                        {
                            struct.radius = 2.5;
                        }
                        
                        c4_structs[ c4_structs.size ] = struct;
                        break;
                }
            }
            
            thread door_event_wait();
        }
        
        if ( c4_structs.size > 0 )
        {
            self.c4_struct = spawn_script_origin();
            self.c4_struct.origin = ( 0, 0, 0 );
            self.c4_struct.radius = 0;
            self.c4_struct.door = self;
            
            if ( isdefined( self.angles ) )
            {
                self.c4_struct.angles = self.angles;
            }
            else
            {
                self.c4_struct.angles = ( 0, 0, 0 );
            }
            
            foreach ( struct in c4_structs )
            {
                self.c4_struct.origin += struct.origin * 1 / c4_structs.size;
                self.c4_struct.radius += struct.radius * 1 / c4_structs.size;
            }
            
            self.c4_struct.breachpoints = c4_structs;
        }
        
        if ( isdefined( self.lockpick ) && istrue( self.locked ) )
        {
            thread enable_lockpicking();
        }
    }
    
    if ( !isdefined( self.script_spawn_open_yaw ) )
    {
        thread scripts\sp\door_internal::cursor_hint_thread();
    }
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0xa9d
// Size: 0xac
function door_event_wait()
{
    self notify( "door_event_wait" );
    self endon( "door_event_wait" );
    self endon( "entitydeleted" );
    
    while ( true )
    {
        event = waittill_any_return( "locked", "door_unlock", "unusable", "opening" );
        
        if ( event == "locked" )
        {
            thread enable_lockpicking();
            thread enable_c4_on_locked();
            continue;
        }
        
        if ( event == "unusable" || event == "opening" )
        {
            thread remove_door_snake_cam_ability();
            thread remove_door_c4_ability();
            thread disable_lockpicking();
            continue;
        }
        
        if ( event == "door_unlock" )
        {
            thread remove_door_c4_ability();
            thread disable_lockpicking();
        }
    }
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0xb51
// Size: 0x35
function enable_lockpicking()
{
    if ( !isdefined( self.lockpick ) )
    {
        return;
    }
    
    if ( !istrue( self.isbashing ) )
    {
        self thread [[ self.lockpick.enable_callback ]]();
    }
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0xb8e
// Size: 0x28
function disable_lockpicking()
{
    if ( !isdefined( self.lockpick ) )
    {
        return;
    }
    
    self thread [[ self.lockpick.disable_callback ]]();
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0xbbe
// Size: 0x98
function enable_c4_on_locked()
{
    self endon( "stop_open_interact" );
    
    if ( !isdefined( self.c4_struct ) )
    {
        return;
    }
    
    self.c4_struct thread c4_breach();
    self.open_struct scripts\sp\door::remove_open_interact_hint();
    self.c4_struct endon( "c4_planted" );
    
    while ( distancesquared( level.player.origin, self.origin ) < squared( 200 ) )
    {
        waitframe();
    }
    
    remove_door_c4_ability();
    self.open_struct delaythread( 0.05, &scripts\sp\door_internal::open_struct_logic );
}

// Namespace door / scripts\game\sp\door
// Params 1
// Checksum 0x0, Offset: 0xc5e
// Size: 0x4d
function set_snake_cam_ignore_ents( ents )
{
    if ( !isarray( ents ) )
    {
        ents = [ ents ];
    }
    
    door = self;
    cam_struct = door.cam_structs[ 0 ];
    cam_struct.ignoremarkedents = ents;
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0xcb3
// Size: 0x44
function remove_from_snakecam_immediate()
{
    if ( !ent_flag( "using_snakecam" ) )
    {
        return;
    }
    
    if ( flag( "exit_snakecam_immediately" ) )
    {
        return;
    }
    
    flag_set( "exit_snakecam_immediately" );
    ent_flag_waitopen( "using_snakecam" );
    flag_clear( "exit_snakecam_immediately" );
}

// Namespace door / scripts\game\sp\door
// Params 1
// Checksum 0x0, Offset: 0xcff
// Size: 0x61
function set_snake_cam_vision( vision )
{
    if ( !isdefined( vision ) )
    {
        vision = "snake_cam";
    }
    
    level.interactive_doors.snakecamvision = vision;
    
    if ( level.player ent_flag( "using_snakecam" ) )
    {
        visionsetfadetoblack( level.interactive_doors.snakecamvision, 0.05 );
    }
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0xd68
// Size: 0x93
function remove_door_snake_cam_ability()
{
    println( "<dev string:x1c>" + self getentnum() + "<dev string:x4e>" + self.origin );
    
    if ( !isdefined( self.cam_structs ) )
    {
        return;
    }
    
    foreach ( struct in self.cam_structs )
    {
        if ( isdefined( struct ) )
        {
            struct notify( "stop_snake_cam" );
            struct scripts\sp\player\cursor_hint::remove_cursor_hint();
        }
    }
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0xe03
// Size: 0x77f
function snake_cam_logic()
{
    self endon( "stop_snake_cam" );
    dwn = anglestoup( self.angles * -1 );
    nvg_was_on = 0;
    
    while ( true )
    {
        scripts\sp\player\cursor_hint::create_cursor_hint( undefined, undefined, &"SCRIPT/DOOR_HINT_SNAKE_CAM", undefined, 120 * level.interactive_doors.hint_dist_scale, 100 * level.interactive_doors.hint_dist_scale, 0, undefined, undefined, undefined, undefined, undefined, undefined, 15 );
        self.door scripts\sp\door_internal::adjust_cursor_hint_side( self );
        self waittill( "trigger" );
        var_f5da26d4069adb12 = self.door.lockedforai;
        level.player ent_flag_set( "using_snakecam" );
        self.door notify( "snake_cam" );
        scripts\sp\outline::outline_fade_alpha_for_index( 6, 0, 0 );
        
        if ( level.player isnightvisionon() )
        {
            nvg_was_on = 1;
            level.player nightvisiongogglesforceoff();
        }
        
        level.player val::set( "snakeCam", "nvg", -1 );
        
        if ( isdefined( self.door ) )
        {
            self.door.snakecam_active = 1;
            
            /#
                self.door.debug_activity = "<dev string:x53>";
            #/
        }
        
        level.player modifybasefov( 115, 0.4 );
        level thread static_burst( 0.1 );
        level.player notify( "enter_cam" );
        level.player.og_origin = level.player.origin;
        level.player.og_angles = level.player getplayerangles();
        level.player.og_stance = level.player getstance();
        level.player freezecontrols( 1 );
        level.player disableweapons();
        
        if ( flag_exist( "hold_context_melee" ) )
        {
            flag_set( "hold_context_melee" );
        }
        
        level.player.ignore_stealth_sight = 1;
        level.player.ignoreme = 1;
        flag_wait_or_timeout( "exit_snakecam_immediately", 0.5 );
        fwd = anglestoforward( self.angles );
        to_door = vectornormalize( self.origin - level.player getorigin() );
        dot = vectordot( fwd, to_door );
        tag = level.player spawn_tag_origin();
        tag.origin = self.origin;
        tag.angles = self.angles;
        
        if ( isdefined( self.target ) )
        {
            offset_struct = getstruct( self.target, "targetname" );
            
            if ( !isdefined( offset_struct ) )
            {
                offset_struct = getent( self.target, "targetname" );
            }
            
            if ( isdefined( offset_struct ) )
            {
                tag.origin = offset_struct.origin;
                tag.angles = offset_struct.angles;
            }
        }
        
        if ( dot < 0 )
        {
            tag.angles += ( 0, 180, 0 );
        }
        
        put_player_on_cam( tag );
        temp = level.player spawn_script_origin();
        tag.tempmovesoundent = level.player spawn_script_origin();
        tag.rumbleent = level.player spawn_script_origin();
        temp scalevolume( 0, 0 );
        temp playloopsound( "snake_cam_roomtone" );
        temp scalevolume( 1, 1 );
        tag.tempmovesoundent playloopsound( "snake_cam_foley" );
        tag thread snake_cam_control();
        level.cam_hud = snake_door_cam_hud();
        
        while ( level.player usebuttonpressed() )
        {
            if ( flag( "exit_snakecam_immediately" ) )
            {
                break;
            }
            
            wait 0.05;
        }
        
        flag_wait( "snakecam_allow_exit" );
        waittill_player_exits_cam();
        nudge_spot = tag.origin + anglestoforward( tag.angles ) * -20;
        
        if ( flag( "exit_snakecam_immediately" ) )
        {
            tag moveto( nudge_spot, 0.05 );
        }
        else
        {
            tag moveto( nudge_spot, 0.5, 0.125 );
        }
        
        flag_wait_or_timeout( "exit_snakecam_immediately", 0.25 );
        level.player notify( "leave_cam" );
        
        foreach ( thing in level.cam_hud )
        {
            thing destroy();
        }
        
        level thread static_burst( 0.125 );
        level add_wait( &flag_wait, "exit_snakecam_immediately" );
        level add_wait( &waittill_msg, "static_faded_in" );
        do_wait_any();
        scripts\sp\outline::outline_fade_alpha_for_index( 6, 0.8, 0 );
        temp stoploopsound( "snake_cam_roomtone" );
        tag.tempmovesoundent stoploopsound( "snake_cam_foley" );
        visionsetfadetoblack( "", 0.05 );
        setsaveddvar( @"hash_83bbe73116f488d6", 0 );
        setsaveddvar( @"hash_ed28298c207316ae", 0 );
        setsaveddvar( @"hash_979b5474be3b9b47", 0 );
        setsaveddvar( @"hash_960ef00238357bbc", 0 );
        
        if ( nvg_was_on )
        {
            level.player nightvisiongogglesforceon();
        }
        
        flag_wait_or_timeout( "exit_snakecam_immediately", 0.1 );
        
        if ( !isdefined( level.fov_default ) )
        {
            level.fov_default = 65;
        }
        
        level.player modifybasefov( level.fov_default, 0.05 );
        remove_player_from_cam();
        
        if ( flag_exist( "hold_context_melee" ) )
        {
            flag_clear( "hold_context_melee" );
        }
        
        level.player.ignore_stealth_sight = undefined;
        level.player.ignoreme = 0;
        tag.tempmovesoundent delete();
        tag.rumbleent delete();
        tag delete();
        temp delete();
        
        if ( isdefined( self.door ) )
        {
            self.door.snakecam_active = 0;
        }
        
        while ( level.player usebuttonpressed() )
        {
            if ( flag( "exit_snakecam_immediately" ) )
            {
                break;
            }
            
            wait 0.05;
        }
        
        self.door.lockedforai = var_f5da26d4069adb12;
        level.player ent_flag_clear( "using_snakecam" );
        scripts\sp\outline::outline_fade_alpha_for_index( 6, 0, 6 );
    }
}

// Namespace door / scripts\game\sp\door
// Params 1
// Checksum 0x0, Offset: 0x158a
// Size: 0x5d4
function snake_cam_control( tempmovesoundent )
{
    level.player endon( "leave_cam" );
    og_angles = self.angles;
    minpitch = -24;
    maxpitch = 0;
    yawdeltamax = 55;
    minyaw = og_angles[ 1 ] - yawdeltamax;
    maxyaw = og_angles[ 1 ] + yawdeltamax;
    minroll = og_angles[ 2 ] - 10;
    maxroll = og_angles[ 2 ] + 10;
    ddeadzone = 20;
    dmaxroll = 10;
    var_440ebeeb83bd05a8 = 0.6;
    var_75eb1524afeb7f2b = 0.8;
    dmaxangle = 10;
    dyaw = 4;
    dpitch = 1.2;
    var_d296b0eaf4a6b00f = [ 0, 0 ];
    var_d5e6310914396ac3 = 0.2;
    var_848e35f763ce65b0 = 0.2;
    rumble_playing = 0;
    
    while ( true )
    {
        currentangles = self.angles;
        currentcamangles = level.player.cam_ent.angles;
        input = level.player getnormalizedcameramovement();
        multiplier = 0;
        normalinput = ( input[ 0 ], input[ 1 ], 0 );
        normalinput = length( normalinput );
        inputlerprate = math::factor_value( var_848e35f763ce65b0, var_d5e6310914396ac3, normalinput );
        var_d296b0eaf4a6b00f[ 0 ] = math::lerp( var_d296b0eaf4a6b00f[ 0 ], input[ 0 ], inputlerprate );
        var_d296b0eaf4a6b00f[ 1 ] = math::lerp( var_d296b0eaf4a6b00f[ 1 ], input[ 1 ], inputlerprate );
        
        if ( currentangles[ 0 ] > 0 && var_d296b0eaf4a6b00f[ 0 ] < 0 )
        {
            var_13a3fd6ddfa8548f = 1 - math::normalize_value( maxpitch * var_440ebeeb83bd05a8, maxpitch, currentangles[ 0 ] );
        }
        else if ( currentangles[ 0 ] < 0 && var_d296b0eaf4a6b00f[ 0 ] > 0 )
        {
            var_13a3fd6ddfa8548f = math::normalize_value( minpitch, minpitch * var_440ebeeb83bd05a8, currentangles[ 0 ] );
        }
        else
        {
            var_13a3fd6ddfa8548f = 1;
        }
        
        if ( currentangles[ 1 ] > og_angles[ 1 ] && var_d296b0eaf4a6b00f[ 1 ] < 0 )
        {
            var_8366082d034c6132 = 1 - math::normalize_value( maxyaw - yawdeltamax * var_75eb1524afeb7f2b, maxyaw, currentangles[ 1 ] );
        }
        else if ( currentangles[ 1 ] < og_angles[ 1 ] && var_d296b0eaf4a6b00f[ 1 ] > 0 )
        {
            var_8366082d034c6132 = math::normalize_value( minyaw, minyaw + yawdeltamax * var_75eb1524afeb7f2b, currentangles[ 1 ] );
        }
        else
        {
            var_8366082d034c6132 = 1;
        }
        
        inputyaw = var_d296b0eaf4a6b00f[ 1 ] * -1;
        nextyaw = currentangles[ 1 ] + dyaw * inputyaw * var_8366082d034c6132;
        
        if ( nextyaw > og_angles[ 1 ] )
        {
            multiplier = math::normalized_float_smooth_out( math::normalize_value( og_angles[ 1 ], maxyaw, nextyaw ) ) * -1;
        }
        
        if ( nextyaw < og_angles[ 1 ] )
        {
            multiplier = 1 - math::normalized_float_smooth_in( math::normalize_value( minyaw, og_angles[ 1 ], nextyaw ) );
        }
        
        inputroll = input[ 1 ];
        nextroll = og_angles[ 2 ] + dmaxroll * multiplier;
        maxroll *= multiplier;
        nextyaw = clamp( nextyaw, minyaw, maxyaw );
        inputpitch = var_d296b0eaf4a6b00f[ 0 ] * -1;
        nextpitch = currentangles[ 0 ] + dpitch * inputpitch * var_13a3fd6ddfa8548f;
        minpitchclamp = minpitch;
        maxpitchclamp = maxpitch;
        nextpitch = clamp( nextpitch, minpitchclamp, maxpitchclamp );
        snakeangles = ( nextpitch, nextyaw, nextroll );
        movementfactor = length( snakeangles - self.angles );
        movementfactor = math::normalize_value( 0, 1.5, movementfactor );
        quake = math::factor_value( 0, 0.105, movementfactor );
        rumble = math::factor_value( 0, 0.08, movementfactor );
        volume = math::factor_value( 0, 0.2, movementfactor );
        
        if ( quake > 0.005 )
        {
            earthquake( quake, 0.07, level.player.origin, 2000 );
        }
        
        if ( rumble > 0.0001 )
        {
            if ( !rumble_playing )
            {
                self.rumbleent playrumblelooponentity( "steady_rumble" );
                rumble_playing = 1;
            }
        }
        else if ( rumble_playing )
        {
            self.rumbleent stoprumble( "steady_rumble" );
            rumble_playing = 0;
        }
        
        height = 1 - rumble;
        height *= 1000;
        self.rumbleent.origin = level.player geteye() + ( 0, 0, height );
        self.tempmovesoundent scalevolume( volume, 0.05 );
        self.angles = snakeangles;
        nudge_spot = self.origin + anglestoforward( self.angles ) * 12 + anglestoup( self.angles ) * -55 + ( 0, 0, 3 );
        level.player.cam_ent.origin = nudge_spot;
        level.player.cam_ent.angles = ( self.angles[ 0 ], self.angles[ 1 ], self.angles[ 2 ] );
        wait 0.05;
    }
}

// Namespace door / scripts\game\sp\door
// Params 1
// Checksum 0x0, Offset: 0x1b66
// Size: 0x1c8
function put_player_on_cam( tag )
{
    nudge_spot = tag.origin + anglestoforward( tag.angles ) * 12 - ( 0, 0, 55 );
    level.player.cam_ent = spawn_tag_origin( nudge_spot, tag.angles );
    level.player val::set( "snakeCam", "stand", 1 );
    level.player val::set( "snakeCam", "crouch", 0 );
    level.player val::set( "snakeCam", "prone", 0 );
    level.player val::set( "snakeCam", "usability", 0 );
    level.player val::set( "snakeCam", "weapon", 0 );
    level.player context_melee_enable( 0 );
    level.player playerdisabletriggers();
    level.player setstance( "stand", 1, 1, 1 );
    level.player setorigin( level.player.cam_ent.origin );
    level.player playerlinktodelta( level.player.cam_ent, "tag_origin", 1, 20, 20, 20, 20, 1 );
    level.player springcamenabled( 0, 2, 1 );
    level.player setplayerangles( tag.angles );
    level.player freezecontrols( 0 );
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x1d36
// Size: 0xe
function snakecam_allow_exit()
{
    flag_set( "snakecam_allow_exit" );
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x1d4c
// Size: 0x19
function snakecam_allow_exit_prompt()
{
    level.cam_hud[ 2 ] settext( "Press [{+activate}] To Exit" );
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x1d6d
// Size: 0xe
function snakecam_force_exit()
{
    flag_set( "exit_snakecam_immediately" );
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x1d83
// Size: 0xec
function remove_player_from_cam()
{
    level.player unlink();
    level.player.cam_ent delete();
    level.player setorigin( level.player.og_origin );
    level.player setplayerangles( level.player.og_angles );
    level.player setstance( level.player.og_stance );
    flag_wait_or_timeout( "exit_snakecam_immediately", 0.25 );
    level.player.ignoreme = 0;
    level.player val::reset_all( "snakeCam" );
    level.player playerenabletriggers();
    level.player context_melee_enable( 1 );
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x1e77
// Size: 0x2e
function waittill_player_exits_cam()
{
    while ( true )
    {
        if ( player_is_trying_to_exit_camera() )
        {
            break;
        }
        
        if ( flag( "exit_snakecam_immediately" ) )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x1ead
// Size: 0x8b, Type: bool
function player_is_trying_to_exit_camera()
{
    return level.player usebuttonpressed() || level.player fragbuttonpressed() || level.player meleebuttonpressed() || level.player buttonpressed( "BUTTON_B" ) || level.player jumpbuttonpressed() || level.player buttonpressed( "BUTTON_LSTICK" ) || level.player buttonpressed( "BUTTON_RSTICK" );
}

// Namespace door / scripts\game\sp\door
// Params 1
// Checksum 0x0, Offset: 0x1f41
// Size: 0xac
function static_burst( duration )
{
    fade_time = 0.25;
    duration = ter_op( isdefined( duration ), duration, 0.5 );
    level.player playsound( "snake_cam_static" );
    static = scripts\sp\hud_util::create_client_overlay( "overlay_static", 1 );
    static.alpha = 0;
    static fadeovertime( fade_time );
    static.alpha = 1;
    wait fade_time;
    level notify( "static_faded_in" );
    wait duration;
    static fadeovertime( fade_time );
    static.alpha = 0;
    wait fade_time;
    level notify( "static_faded_out" );
    static destroy();
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x1ff5
// Size: 0x12f
function cam_enemy_marking()
{
    level.player endon( "leave_cam" );
    level.player notifyonplayercommand( "trigger_pressed", "+attack" );
    
    while ( true )
    {
        level.player waittill( "trigger_pressed" );
        ignore_ents = [ self.door, level.player ];
        
        if ( isdefined( self.ignoremarkedents ) )
        {
            ignore_ents = array_combine( ignore_ents, self.ignoremarkedents );
        }
        
        fwd = anglestoforward( level.player getplayerangles() );
        endorigin = level.player geteye() + fwd * 1000;
        trace = scripts\engine\trace::sphere_trace( level.player geteye(), endorigin, 2, ignore_ents );
        ent = trace[ "entity" ];
        
        if ( isdefined( ent ) )
        {
            if ( isai( ent ) && isalive( ent ) && ent.team == "axis" )
            {
                ent thread handle_cam_enemy_marking();
            }
        }
    }
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x212c
// Size: 0x1aa
function snake_door_cam_hud()
{
    crosshair = newhudelem();
    crosshair.archived = 0;
    crosshair.location = 0;
    crosshair.alignx = "center";
    crosshair.aligny = "middle";
    crosshair.foreground = 1;
    crosshair.fontscale = 1;
    crosshair.sort = 20;
    crosshair.alpha = 0.7;
    crosshair.y = 233;
    crosshair settext( "+" );
    overlay = newhudelem();
    overlay.x = 292;
    overlay.y = 60;
    overlay.alignx = "center";
    overlay.aligny = "middle";
    overlay.font = "smallfixed";
    overlay.fontscale = 0.75;
    goggles = scripts\sp\hud_util::create_client_overlay( "nightvision_overlay_goggles_grain", 1 );
    visionsetfadetoblack( level.interactive_doors.snakecamvision, 0.05 );
    setsaveddvar( @"hash_83bbe73116f488d6", 0.5 );
    setsaveddvar( @"hash_ed28298c207316ae", 0.2 );
    setsaveddvar( @"hash_979b5474be3b9b47", -0.75 );
    setsaveddvar( @"hash_960ef00238357bbc", 0.011 );
    return [ crosshair, goggles, overlay ];
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x22df
// Size: 0x1aa
function snake_door_cam_hud_blur_v2()
{
    crosshair = newhudelem();
    crosshair.archived = 0;
    crosshair.location = 0;
    crosshair.alignx = "center";
    crosshair.aligny = "middle";
    crosshair.foreground = 1;
    crosshair.fontscale = 1;
    crosshair.sort = 20;
    crosshair.alpha = 0.7;
    crosshair.y = 233;
    crosshair settext( "+" );
    overlay = newhudelem();
    overlay.x = 400;
    overlay.y = 180;
    overlay.alignx = "center";
    overlay.aligny = "middle";
    overlay.font = "smallfixed";
    overlay.fontscale = 0.75;
    goggles = scripts\sp\hud_util::create_client_overlay( "nightvision_overlay_goggles_grain", 1 );
    visionsetfadetoblack( level.interactive_doors.snakecamvision, 0.05 );
    setsaveddvar( @"hash_83bbe73116f488d6", 0.5 );
    setsaveddvar( @"hash_ed28298c207316ae", 0.2 );
    setsaveddvar( @"hash_979b5474be3b9b47", -0.75 );
    setsaveddvar( @"hash_960ef00238357bbc", 0.011 );
    return [ crosshair, goggles, overlay ];
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x2492
// Size: 0x73
function handle_cam_enemy_marking()
{
    if ( !ent_flag_exist( "snake_cam_marked" ) )
    {
        ent_flag_init( "snake_cam_marked" );
    }
    
    if ( ent_flag( "snake_cam_marked" ) )
    {
        return;
    }
    
    ent_flag_set( "snake_cam_marked" );
    handle_cam_enemy_caret();
    
    if ( isalive( self ) && ent_flag( "snake_cam_marked" ) )
    {
        hudoutline_enable_new( "outline_nodepth_red", "snake_cam" );
        ent_flag_clear( "snake_cam_marked" );
    }
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x250d
// Size: 0x4d
function handle_cam_enemy_caret()
{
    caret = spawn_tag_origin();
    level.player playsound( "support_drone_targeting" );
    playfxontag( getfx( "enemy_marker" ), caret, "tag_origin" );
    cam_enemy_caret_follow_target_til_cleanup( caret );
    caret delete();
}

// Namespace door / scripts\game\sp\door
// Params 1
// Checksum 0x0, Offset: 0x2562
// Size: 0x72
function cam_enemy_caret_follow_target_til_cleanup( caret )
{
    self endon( "death" );
    
    while ( level.player ent_flag( "using_snakecam" ) && ent_flag( "snake_cam_marked" ) )
    {
        org = self gettagorigin( "j_head" );
        caret.origin = org + ( 0, 0, 18 );
        wait 0.05;
    }
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x25dc
// Size: 0x131
function c4_breach()
{
    self.door endon( "entitydeleted" );
    self.door endon( "stop_c4_ability" );
    self.door.c4_breachable = 1;
    
    if ( !isbreachableinit() )
    {
        return;
    }
    
    scripts\sp\player\cursor_hint::create_cursor_hint( undefined, undefined, "Breach", undefined, 110 * level.interactive_doors.hint_dist_scale, 60 * level.interactive_doors.hint_dist_scale, 0 );
    self.door scripts\sp\door_internal::adjust_cursor_hint_side( self );
    self waittill( "trigger" );
    self notify( "stop_cursor_hint_thread" );
    
    /#
        self.door.debug_activity = "<dev string:x5d>";
    #/
    
    self notify( "c4_planted" );
    self.door scripts\sp\door::create_navobstacle();
    self.breached = 1;
    self.door scripts\sp\door::remove_open_ability();
    self.door remove_door_snake_cam_ability();
    c4_on_door();
    c4_countdown();
    c4_detonate();
    self.door scripts\sp\door::clear_navobstacle();
    self.door scripts\sp\door::delete_door();
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x2715
// Size: 0x20
function isbreachableinit()
{
    if ( self.door.locked )
    {
        return 1;
    }
    
    return 0;
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x273d
// Size: 0xf0
function c4_on_door()
{
    self.breachpoints = sortbydistance( self.breachpoints, level.player.origin );
    breachpoint = self.breachpoints[ 0 ];
    level.player playgestureviewmodel( "ges_equip_frag_throw" );
    wait 0.5;
    self.door.c4 = spawn( "script_model", breachpoint.origin );
    self.door.c4.angles = breachpoint.angles;
    self.door.c4 setmodel( "offhand_wm_c4" );
    playsoundatpos( self.origin, "sp_c4_plant" );
    self.door notify( "c4_planted" );
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x2835
// Size: 0x9d
function c4_monitor_dmg()
{
    self endon( "detonate" );
    self.door.c4 setcandamage( 1 );
    
    while ( true )
    {
        self.door.c4 waittill( "damage", unused, attacker, unused, unused, type );
        
        if ( isdefined( attacker ) && attacker == level.player && isdefined( type ) )
        {
            if ( type == "MOD_MELEE" )
            {
                continue;
            }
            
            self notify( "kill_timer" );
        }
    }
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x28da
// Size: 0x10d
function c4_detonate()
{
    self.door notify( "detonate" );
    playsoundatpos( self.origin, "iw9_frag_grenade_expl_trans" );
    playfx( level._effect[ "c4_detonate" ], self.origin );
    self.door.c4 delete();
    self.door hide();
    earthquake( 0.7, 0.8, self.origin, 600 );
    radiusdamage( self.origin, 120, 150, 30, level.player, "MOD_EXPLOSIVE" );
    self.door.clip notsolid();
    
    if ( isdefined( self.door.navmodifier ) )
    {
        destroynavobstacle( self.door.navmodifier );
    }
    
    delaythread( 0.5, &scripts\sp\door_internal::stealth_broadcast, 500, "gunshot" );
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x29ef
// Size: 0x12d
function c4_countdown()
{
    self endon( "kill_timer" );
    thread c4_monitor_dmg();
    wait 0.7;
    
    for ( i = 0; i < 3 ; i++ )
    {
        playsoundatpos( self.origin, "hack_robot_explode_beep" );
        playfxontag( level._effect[ "c4_light_green" ], self.door.c4, "tag_fx" );
        wait 0.5;
    }
    
    for ( i = 0; i < 6 ; i++ )
    {
        playsoundatpos( self.origin, "hack_robot_explode_beep" );
        playfxontag( level._effect[ "c4_light_green" ], self.door.c4, "tag_fx" );
        wait 0.25;
    }
    
    for ( i = 0; i < 20 ; i++ )
    {
        playsoundatpos( self.origin, "hack_robot_explode_beep" );
        playfxontag( level._effect[ "c4_light_red" ], self.door.c4, "tag_fx" );
        wait 0.1;
    }
    
    self notify( "detonate" );
}

// Namespace door / scripts\game\sp\door
// Params 0
// Checksum 0x0, Offset: 0x2b24
// Size: 0x64
function remove_door_c4_ability()
{
    println( "<dev string:x67>" + self getentnum() + "<dev string:x4e>" + self.origin );
    
    if ( !istrue( self.c4_breachable ) )
    {
        return;
    }
    
    self.c4_breachable = 0;
    self notify( "stop_c4_ability" );
    
    if ( isdefined( self.c4_struct ) )
    {
        self.c4_struct scripts\sp\player\cursor_hint::remove_cursor_hint();
    }
}

