#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\debug;
#using scripts\sp\door;
#using scripts\sp\door_internal;
#using scripts\sp\door_scriptable;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\starts;
#using scripts\sp\utility;

#namespace door_internal;

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x9ec
// Size: 0x11
function door_post_load()
{
    init_doors();
    thread trace_completion_thread();
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0xa05
// Size: 0x4a8
function init_window()
{
    assertex( isdefined( self.target ), "Window at " + self.origin + " has no targeted window panes." );
    panes = getentarray( self.target, "targetname" );
    
    foreach ( pane in panes )
    {
        if ( !isdefined( pane.script_linkto ) )
        {
            continue;
        }
        
        clip = pane get_linked_ent();
        clip linkto( pane );
    }
    
    linked_nodes = get_linked_nodes();
    
    foreach ( node in linked_nodes )
    {
        if ( is_equal( node.targetname, "traverse" ) )
        {
            destroynavlink( node );
            continue;
        }
        
        if ( is_equal( node.script_noteworthy, "cover" ) )
        {
            node disconnectnode();
        }
    }
    
    scripts\sp\player\cursor_hint::create_cursor_hint( undefined, ( 0, 0, 0 ), &"GAME/DOOR_OPEN", 55, 135 * level.interactive_doors.hint_dist_scale, 85 * level.interactive_doors.hint_dist_scale, 1 );
    self.cursor_hint_ent setusewhenhandsoccupied( 1 );
    event = waittill_window_event();
    scripts\sp\player\cursor_hint::remove_cursor_hint();
    
    if ( event == "trigger" )
    {
        thread player_window_gesture( 0.65 );
        opentime = 0.8;
        sound = "door_open_ajar";
    }
    else
    {
        door_bash_presentation();
        opentime = 0.35;
        sound = "door_open_bash";
    }
    
    stealtheventbroadcastbytacsight( "window_open", level.player, level.player.origin, 384, undefined, undefined, 80 );
    
    foreach ( pane in panes )
    {
        if ( is_equal( pane.script_noteworthy, "delete_on_open" ) )
        {
            pane delete();
            continue;
        }
        
        originalangles = pane.angles;
        vector = pane.origin - level.player.origin;
        forward = anglestoforward( originalangles );
        dot = vectordot( vector, forward );
        var_f25f65666bab9bcd = ter_op( dot > 0, anglestoright( originalangles ), anglestoleft( originalangles ) );
        var_d8bd7d9a61d3c70a = vectortoangles( var_f25f65666bab9bcd );
        goalangles = anglelerpquatfrac( originalangles, var_d8bd7d9a61d3c70a, randomfloatrange( 1, 1.15 ) );
        pane rotateto( goalangles, opentime, opentime * 0.8, opentime * 0.2 );
        pane playsound( sound );
        
        if ( event == "melee_pressed" )
        {
            if ( isdefined( level.stealth ) )
            {
                thread stealth_broadcast( 450, "combat" );
            }
            else
            {
                thread combat_getinfoinradius( 450 );
            }
            
            pane delaycall( opentime, &rotateto, var_d8bd7d9a61d3c70a, randomfloatrange( 0.75, 1.25 ) );
            pane delaycall( opentime, &playsound, "door_open_stop" );
            self notify( "trigger" );
        }
    }
    
    foreach ( node in linked_nodes )
    {
        if ( is_equal( node.targetname, "traverse" ) )
        {
            end_node = getnode( node.target, "targetname" );
            createnavlink( "window_traversal", node.origin, end_node.origin, node );
            continue;
        }
        
        if ( is_equal( node.script_noteworthy, "cover" ) )
        {
            node connectnode();
        }
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0xeb5
// Size: 0x48
function waittill_window_event()
{
    while ( true )
    {
        bashed = waittill_melee_or_interact();
        
        if ( !isdefined( bashed ) || window_melee_valid( self.origin ) )
        {
            return ter_op( !isdefined( bashed ), "trigger", "melee_pressed" );
        }
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0xf05
// Size: 0x21, Type: bool
function waittill_melee_or_interact()
{
    self endon( "trigger" );
    waitframe();
    
    while ( !level.player ismeleeing() )
    {
        waitframe();
    }
    
    return true;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0xf2f
// Size: 0x7d, Type: bool
function window_melee_valid( windoworigin )
{
    if ( distancesquared( level.player geteye(), windoworigin ) > 2025 )
    {
        return false;
    }
    
    if ( !within_fov( level.player.origin + anglestoforward( level.player.angles ) * -50, level.player.angles, windoworigin, 0.731353 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0xfb5
// Size: 0x55
function init_doors()
{
    doors = getentarray( "interactive_door", "script_noteworthy" );
    
    if ( doors.size > 0 )
    {
        global_door_threads();
    }
    
    array_thread( doors, level.interactive_doors.fndoorinit );
    
    /#
        array_thread( doors, &function_15e6179f97b90046 );
    #/
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x1012
// Size: 0x7a
function global_door_threads()
{
    if ( isdefined( level.doors_initialized ) )
    {
        return;
    }
    
    if ( scripts\sp\starts::is_no_game_start() )
    {
        return;
    }
    
    level.doors_initialized = 1;
    array_thread( getaiarray(), &scripts\sp\door::ai_monitor_doors );
    add_global_spawn_function( "allies", &scripts\sp\door::ai_monitor_doors );
    add_global_spawn_function( "axis", &scripts\sp\door::ai_monitor_doors );
    add_global_spawn_function( "neutral", &scripts\sp\door::ai_monitor_doors );
    add_global_spawn_function( "team3", &scripts\sp\door::ai_monitor_doors );
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x1094
// Size: 0x8bb
function init_door_internal( reset )
{
    if ( !istrue( reset ) )
    {
        assertex( !isdefined( self.doorid ), "door at " + self.origin + " is already initialized" );
    }
    
    self.pivots = [];
    self.closed_angles = ( 0, 0, 0 );
    self.openers = [];
    self.tryingopener = undefined;
    self.doorid = self getentitynumber();
    self.ai_anim_start = [];
    self.hinge_side = undefined;
    self.breached = 0;
    self.doortype = "wood";
    self.clip = undefined;
    self.linked_ents = undefined;
    self.no_bash = undefined;
    self.current_pivot_struct = undefined;
    
    if ( scripts\sp\starts::is_no_game_start() )
    {
        return;
    }
    
    if ( isdefined( self.open_struct ) )
    {
        self.open_struct.custom_hint_text = undefined;
        self.open_struct.no_open_interact = undefined;
    }
    
    if ( !isdefined( self.true_start_angles ) )
    {
        self.true_start_angles = self.angles;
    }
    
    if ( !isdefined( self.locked ) )
    {
        self.locked = 0;
    }
    
    if ( !ent_flag_exist( "initialized" ) )
    {
        ent_flag_init( "initialized" );
    }
    
    if ( istrue( reset ) )
    {
        self.script_spawn_open_yaw = undefined;
    }
    else
    {
        level.interactive_doors.ents[ level.interactive_doors.ents.size ] = self;
    }
    
    ents = get_linked_ents();
    structs = get_linked_structs();
    doopen = 1;
    
    if ( isdefined( self.script_parameters ) )
    {
        values = strtok( self.script_parameters, " " );
        
        foreach ( value in values )
        {
            switch ( value )
            {
                case #"hash_cb7d0a281b511f3":
                    if ( !istrue( reset ) )
                    {
                        self.locked = 1;
                    }
                    
                    break;
                case #"hash_8f8efed0bf72f563":
                    doopen = 0;
                    break;
                case #"hash_dc02c220d09e7dc1":
                    self.no_bash = 1;
                    break;
                case #"hash_2ef82190668f60b6":
                    self.no_handle_ajar = 1;
                    break;
                case #"hash_d8442f512bb8ab99":
                    thread scripts\sp\door::function_89be9fac0c81f3aa();
                    break;
                case #"hash_8833e927768f4e12":
                    thread scripts\sp\door::door_open_completely();
                    break;
            }
        }
    }
    
    foreach ( ent in ents )
    {
        if ( isdefined( ent.script_noteworthy ) )
        {
            ent.door = self;
            
            switch ( ent.script_noteworthy )
            {
                case #"hash_f1589029bfa1a45b":
                    /#
                        if ( isdefined( self.clip ) )
                        {
                            println( "<dev string:x1c>" + self.origin + "<dev string:x5a>" );
                        }
                    #/
                    
                    self.clip = ent;
                    ent linkto( self );
                    ent.doorclip = 1;
                    break;
                case #"hash_7d9407498809f178":
                    self.clip_nosight = ent;
                    ent linkto( self );
                    ent.doorclip = 1;
                    break;
                case #"hash_be53fa38f2c65d60":
                    self.unlock_volume = ent;
                    ent thread unlock_volume_logic();
                    break;
                case #"hash_6fb23e39e833ccc9":
                    if ( !isdefined( self.linked_ents ) )
                    {
                        self.linked_ents = [];
                    }
                    
                    self.linked_ents[ self.linked_ents.size ] = ent;
                    ent linkto( self );
                    ent.doorclip = 1;
                    break;
            }
        }
    }
    
    foreach ( struct in structs )
    {
        if ( isdefined( struct.script_noteworthy ) )
        {
            struct.door = self;
            
            switch ( struct.script_noteworthy )
            {
                case #"hash_61e6fe8f0d447a0f":
                    self.true_start_angles = struct.angles;
                    self.open_struct = struct;
                    self.length = distance2d( self.origin, self.open_struct.origin );
                    
                    if ( doopen )
                    {
                        setup_open_struct( struct );
                    }
                    
                    break;
                case #"hash_a42b56ce5d28f109":
                    self.pivots[ "open_left" ] = struct;
                    break;
                case #"hash_eda02527ade442aa":
                    self.pivots[ "open_right" ] = struct;
                    break;
                case #"hash_1da6ba65ec0ff8e0":
                    self.ai_anim_start[ "walk" ] = rotatevectorinverted( struct.origin - self.origin, self.true_start_angles );
                    break;
                case #"hash_79d4ad622880225a":
                    self.ai_anim_start[ "run" ] = rotatevectorinverted( struct.origin - self.origin, self.true_start_angles );
                    break;
            }
        }
    }
    
    self.forward = anglestoforward( self.true_start_angles );
    self.open_left = scripts\sp\door::should_open_left();
    self.bashed = 0;
    self.bashed_full = 0;
    self.ajar = 0;
    self.open_completely = 0;
    self.was_opened_halfway = 0;
    self.active = 1;
    self.team = ter_op( isdefined( self.script_team ), self.script_team, "" );
    get_door_bottom_center();
    initlinkednodes();
    updatenodelookpeek();
    scripts\sp\door_scriptable::init_destructible();
    
    if ( self.classname != "script_model" && !isdefined( self.clip ) && !is_clip_nosight() )
    {
        self.clip = self;
        self.clip.doorclip = 1;
    }
    
    linknameprefix = strtok( structs[ 0 ].script_linkname, "_" )[ 0 ];
    createinitialnavmodifier( linknameprefix );
    assertex( isdefined( self.clip ), "SP script_model doors: Door missing associated clip assignment. Door origin" + self.origin + " with model(" + default_to( self.model, "none" ) + ") targetname(" + default_to( self.targetname, "none" ) + "). " + ter_op( getentarrayinradius( "script_brushmodel", "classname" ).size == 0, "<<Your BSP has 0 script_brushmodels, is something wrong with the BSP?>>", "Does doormodel.script_linkto point to a scriptbrushmodel.script_linkname?" ) );
    assertex( !isdefined( self.clip ) || self.clip.spawnflags & 1, "SP script_model doors: Door clip spawnflags doesn't have DYNAMIC_PATH set, AI won't be able to use it. Door origin" + self.origin + " with model(" + default_to( self.model, "none" ) + ") targetname(" + default_to( self.targetname, "none" ) + ")" );
    self.clip connectpaths();
    assert( isdefined( self.true_start_angles ) );
    
    if ( self.locked )
    {
        scripts\sp\door::create_navobstacle();
    }
    
    self.nav_lastupdatetime = gettime();
    self.nav_lastupdateangle = self.true_start_angles[ 1 ];
    
    if ( !isdefined( self.script_spawn_open_yaw ) || istrue( level.interactive_doors.close_prompt ) )
    {
        thread cursor_hint_thread();
    }
    
    thread scripts\sp\door::init_max_yaws();
    thread door_open_think();
    
    if ( isdefined( self.doubledoors ) )
    {
        scripts\sp\door::double_doors_init( self.doubledoors[ 0 ], self.doubledoors[ 1 ] );
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x1957
// Size: 0x1f, Type: bool
function is_clip_nosight()
{
    return isdefined( self.script_noteworthy ) && self.script_noteworthy == "clip_nosight";
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x197f
// Size: 0x1de
function cursor_hint_thread( var_3443efedc8b77120 )
{
    self notify( "cursor_hint_thread" );
    self endon( "cursor_hint_thread" );
    self endon( "reset_door" );
    self endon( "entitydeleted" );
    self endon( "stop_cursor_hint_thread" );
    self.var_f2507a3c1b546d7c = -1;
    self.var_6cd0321e55f60f8f = -1;
    self.cursorhintdir = ( 0, 0, 0 );
    has_openstruct = isdefined( self.open_struct );
    
    while ( true )
    {
        set_player_side();
        
        if ( !has_openstruct && has_cursor_hint( self.open_struct ) || cursor_refresh( self.open_struct ) )
        {
            has_openstruct = 1;
            self.var_f2507a3c1b546d7c = -1;
        }
        
        if ( self.var_f2507a3c1b546d7c != self.var_6cd0321e55f60f8f )
        {
            if ( isdefined( self.open_struct ) )
            {
                adjust_cursor_hint_side( self.open_struct );
            }
            
            if ( isdefined( self.cam_structs ) )
            {
                foreach ( cam_struct in self.cam_structs )
                {
                    adjust_cursor_hint_side( cam_struct );
                }
            }
            
            if ( isdefined( self.c4_struct ) )
            {
                adjust_cursor_hint_side( self.c4_struct );
            }
        }
        
        if ( has_openstruct )
        {
            has_openstruct = has_cursor_hint( self.open_struct );
        }
        
        if ( isdefined( var_3443efedc8b77120 ) )
        {
            self [[ var_3443efedc8b77120 ]]();
        }
        
        dist = max( 0, distance( level.player geteye(), self.origin ) - 200 );
        level.player waittill_any_timeout_1( max( 0.05, dist / 528 ), "teleported" );
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x1b65
// Size: 0x29, Type: bool
function cursor_refresh( struct )
{
    if ( isdefined( struct.refresh ) )
    {
        struct.refresh = undefined;
        return true;
    }
    
    return false;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x1b97
// Size: 0x7f, Type: bool
function has_cursor_hint( struct )
{
    if ( !isdefined( struct ) )
    {
        return false;
    }
    
    if ( isarray( struct ) )
    {
        foreach ( s in struct )
        {
            if ( isdefined( s.cursor_hint_ent ) )
            {
                return true;
            }
        }
    }
    else
    {
        return isdefined( struct.cursor_hint_ent );
    }
    
    return false;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x1c1f
// Size: 0x110
function adjust_cursor_hint_side( struct )
{
    if ( !isdefined( struct.cursor_hint_ent ) )
    {
        return;
    }
    
    pos = struct.origin;
    door_angles = scripts\sp\door::get_door_angles() - self.true_start_angles;
    
    if ( abs( door_angles[ 1 ] ) > 0.01 && isdefined( self.pivot_ent ) )
    {
        pos_local = pos - self.pivot_ent.origin;
        pos_local = rotatevectorinverted( pos_local, self.true_start_angles );
        pos_local = rotatevector( pos_local, self.pivot_ent.angles );
        pos = pos_local + self.pivot_ent.origin;
    }
    
    pos += self.cursorhintdir * struct.radius;
    struct.cursor_hint_ent dontinterpolate();
    struct.cursor_hint_ent.origin = pos;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x1d37
// Size: 0xb2
function function_d6f79a2aa10afcb1()
{
    angles = vectortoangles( self.forward );
    
    if ( isdefined( self.pivot_ent ) )
    {
        angles = self.pivot_ent.angles;
    }
    
    right = anglestoright( angles );
    normal = vectornormalize( level.player.origin - self.origin );
    dot = vectordot( right, normal );
    
    if ( dot > 0 )
    {
        return [ 1, right ];
    }
    
    return [ 0, right * -1 ];
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x1df1
// Size: 0x3e
function set_player_side()
{
    var_6cd0321e55f60f8f = function_d6f79a2aa10afcb1();
    self.var_f2507a3c1b546d7c = self.var_6cd0321e55f60f8f;
    self.var_6cd0321e55f60f8f = var_6cd0321e55f60f8f[ 0 ];
    self.cursorhintdir = var_6cd0321e55f60f8f[ 1 ];
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x1e37
// Size: 0xd8
function trace_completion_thread()
{
    while ( true )
    {
        startagain = 0;
        
        foreach ( door in level.interactive_doors.ents )
        {
            if ( !isdefined( door.max_yaw_left ) || !isdefined( door.max_yaw_right ) )
            {
                startagain = 1;
                break;
            }
        }
        
        if ( !startagain )
        {
            break;
        }
    }
    
    if ( !flag( "scriptables_ready" ) )
    {
        println( "<dev string:x5c>" );
        flag_wait( "scriptables_ready" );
    }
    
    flag_set( "interactive_doors_ready_internal" );
    waitframe();
    flag_set( "interactive_doors_ready" );
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x1f17
// Size: 0x39
function get_hint_dist( defaultval )
{
    if ( isdefined( level.interactive_doors.hint_dist_scale ) )
    {
        return ( defaultval * level.interactive_doors.hint_dist_scale );
    }
    
    return defaultval;
}

/#

    // Namespace door_internal / scripts\sp\door_internal
    // Params 0
    // Checksum 0x0, Offset: 0x1f59
    // Size: 0x3cd, Type: dev
    function function_15e6179f97b90046()
    {
        self endon( "<dev string:x9f>" );
        self.debug_activity = "<dev string:xad>";
        
        while ( true )
        {
            if ( !getdvarint( @"hash_6985e82f27803483" ) || distancesquared( self.origin, level.player.origin ) > squared( 450 ) )
            {
                wait 0.15;
                continue;
            }
            
            space = 1.85;
            count = 0;
            base = self.origin + ( 5, 5, 58 );
            print3d( base + ( 0, 0, count * space * -1 ), "<dev string:xae>" + self.doorid, ( 1, 1, 1 ), 1, 0.15 );
            count++;
            print3d( base + ( 0, 0, count * space * -1 ), "<dev string:xb8>" + self.true_start_angles, ( 1, 1, 1 ), 1, 0.15 );
            count++;
            print3d( base + ( 0, 0, count * space * -1 ), "<dev string:xcc>" + scripts\sp\door::get_door_angles(), ( 1, 1, 1 ), 1, 0.15 );
            count++;
            
            if ( isdefined( self.current_pivot_struct ) )
            {
                print3d( base + ( 0, 0, count * space * -1 ), "<dev string:xdd>" + self.current_pivot_struct.script_noteworthy, ( 1, 1, 1 ), 1, 0.15 );
                count++;
            }
            
            if ( isdefined( self.pivot_ent ) )
            {
                print3d( self.pivot_ent.origin + ( 0, 0, 5 ), "<dev string:xe5>", ( 1, 1, 1 ), 1, 0.15 );
            }
            
            print3d( base + ( 0, 0, count * space * -1 ), "<dev string:xef>" + self.open_left, ( 1, 1, 1 ), 1, 0.15 );
            count++;
            print3d( base + ( 0, 0, count * space * -1 ), "<dev string:xfb>" + self.debug_activity, ( 1, 1, 1 ), 1, 0.15 );
            count++;
            
            if ( isdefined( self.pivot_ent ) )
            {
                spot = self.pivot_ent.origin;
            }
            else
            {
                spot = self.origin;
            }
            
            print3d( get_door_center(), "<dev string:x106>" );
            thread scripts\sp\debug::drawarrow( spot, scripts\sp\door::get_door_angles(), undefined, 3 );
            
            if ( isdefined( self.max_yaw_left ) )
            {
                thread draw_max_yaw( 1 );
            }
            
            if ( isdefined( self.max_yaw_right ) )
            {
                thread draw_max_yaw( 0 );
            }
            
            if ( isdefined( self.traces ) )
            {
                print3d( base + ( 0, 0, count * space * -1 ), "<dev string:x108>" + self.traces, ( 1, 1, 1 ), 1, 0.15 );
            }
            
            if ( isdefined( self.doorbottomcenter ) )
            {
                line( self.doorbottomcenter + ( 5, 0, 0 ), self.doorbottomcenter - ( 5, 0, 0 ) );
                line( self.doorbottomcenter + ( 0, 5, 0 ), self.doorbottomcenter - ( 0, 5, 0 ) );
                line( self.doorbottomcenter + ( 0, 0, 5 ), self.doorbottomcenter - ( 0, 0, 5 ) );
            }
            
            wait 0.015;
        }
    }

#/

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x232e
// Size: 0x159
function unlock_volume_logic()
{
    door = self.door;
    
    if ( isdefined( door.doubledoors ) )
    {
        door = door.doubledoors[ 0 ];
    }
    
    if ( !door.locked )
    {
        return;
    }
    
    self.active = 1;
    door endon( "first_interact" );
    door endon( "ai_opened" );
    door endon( "bashed" );
    door endon( "detonate" );
    door endon( "unlock_volume_logic" );
    
    while ( true )
    {
        while ( !level.player istouching( self ) && ( !isdefined( door.doubledoorother ) || !isdefined( door.doubledoorother.unlock_volume ) || !level.player istouching( door.doubledoorother.unlock_volume ) ) )
        {
            waitframe();
        }
        
        door scripts\sp\door::unlock_door();
        
        while ( level.player istouching( self ) || isdefined( door.doubledoorother ) && isdefined( door.doubledoorother.unlock_volume ) && level.player istouching( door.doubledoorother.unlock_volume ) )
        {
            waitframe();
        }
        
        door scripts\sp\door::lock_door();
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x248f
// Size: 0xd
function refresh_open_struct()
{
    self.refresh = 1;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x24a4
// Size: 0x76
function door_open_think()
{
    self notify( "door_open_think" );
    self endon( "door_open_think" );
    self endon( "reset_door" );
    self endon( "entitydeleted" );
    self endon( "stop_open_ability" );
    self endon( "ai_opened" );
    
    if ( !isdefined( self.script_spawn_open_yaw ) )
    {
        thread scripts\sp\door::bash_monitor();
        waittill_first_interact_or_bash();
    }
    else
    {
        thread scripts\sp\door::door_ajar();
    }
    
    if ( !self.bashed_full )
    {
        thread monitor_door_push();
        waittill_second_interact_or_bash();
    }
    
    scripts\sp\door::remove_open_ability();
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x2522
// Size: 0xc1
function get_max_yaw( left )
{
    var_341549370db541dd = 70;
    major_increment = 30;
    minor_increment = 5;
    
    if ( left )
    {
        if ( isdefined( self.script_max_left_angle ) )
        {
            self.max_yaw_left = self.script_max_left_angle;
            return;
        }
    }
    else if ( isdefined( self.script_max_right_angle ) )
    {
        self.max_yaw_right = self.script_max_right_angle;
        return;
    }
    
    var_3b95c8b5e7f3b716 = get_max_yaw_internal( var_341549370db541dd, major_increment, left );
    var_3b95c8b5e7f3b716 += minor_increment;
    var_775065760c0fb3ba = get_max_yaw_internal( var_3b95c8b5e7f3b716, minor_increment, left );
    
    if ( left )
    {
        self.max_yaw_left = var_775065760c0fb3ba;
        return;
    }
    
    self.max_yaw_right = var_775065760c0fb3ba;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 3
// Checksum 0x0, Offset: 0x25eb
// Size: 0xa1
function get_max_yaw_internal( test_yaw, increment, left )
{
    failed_once = 0;
    finished = 0;
    contents = scripts\engine\trace::create_default_contents( 1 );
    
    while ( !finished )
    {
        if ( test_yaw > 179 )
        {
            return 179;
        }
        
        safe_yaw = yaw_collision_check( test_yaw, left, contents );
        
        if ( safe_yaw )
        {
            if ( failed_once )
            {
                finish = 1;
            }
            
            test_yaw += increment;
            continue;
        }
        
        if ( !failed_once )
        {
            failed_once = 1;
        }
        
        test_yaw -= increment;
        finished = 1;
    }
    
    return test_yaw;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 3
// Checksum 0x0, Offset: 0x2695
// Size: 0x332, Type: bool
function yaw_collision_check( yaw, left, content_override )
{
    multiplier = 100;
    
    if ( left )
    {
        multiplier *= -1;
    }
    else
    {
        yaw *= -1;
    }
    
    trace_angles = self.true_start_angles + ( 0, yaw, 0 );
    
    if ( left )
    {
        basestart = self.pivots[ "open_left" ].origin + ( 0, 0, 2 );
    }
    else
    {
        basestart = self.pivots[ "open_right" ].origin + ( 0, 0, 2 );
    }
    
    start = basestart + anglestoforward( trace_angles ) * self.length * 0.2;
    end = start + anglestoright( trace_angles ) * multiplier;
    trace = scripts\engine\trace::capsule_trace( start, end, 6, 80, trace_angles, [ self, self.clip ], content_override, 0 );
    dist = distance2d( start, trace[ "position" ] );
    
    /#
        if ( getdvarint( @"hash_6985e82f27803483" ) )
        {
            if ( !isdefined( self.traces ) )
            {
                self.traces = 1;
            }
            else
            {
                self.traces++;
            }
            
            color = ( 1, 1, 1 );
            
            if ( dist > 50 )
            {
                color = ( 0, 1, 0 );
            }
            else if ( dist < 3 )
            {
                color = ( 1, 0, 0 );
            }
            else if ( dist < 50 )
            {
                color = ( 1, 1, 0 );
            }
            
            var_18c5ebb73f7639ce = basestart + anglestoforward( trace_angles ) * self.length;
            var_2bb3e172d183245b = start + anglestoright( trace_angles ) * dist;
            line( basestart, var_18c5ebb73f7639ce, ( 1, 1, 1 ), 1, 0, 60 );
            line( start, var_2bb3e172d183245b, color, 0.5, 0, 60 );
        }
    #/
    
    if ( dist > 3 )
    {
        start = basestart + anglestoforward( trace_angles ) * self.length * 0.9;
        trace = scripts\engine\trace::capsule_trace( start, end, 6, 80, trace_angles, [ self, self.clip ], content_override, 0 );
        
        /#
            if ( getdvarint( @"hash_6985e82f27803483" ) )
            {
                self.traces++;
                color = ( 1, 1, 1 );
                
                if ( dist > 50 )
                {
                    color = ( 0, 1, 0 );
                }
                else if ( dist < 5 )
                {
                    color = ( 1, 0, 0 );
                }
                else if ( dist < 50 )
                {
                    color = ( 1, 1, 0 );
                }
                
                var_2bb3e172d183245b = start + anglestoright( trace_angles ) * dist;
                line( start, var_2bb3e172d183245b, color, 0.5, 0, 60 );
            }
        #/
        
        dist = distance2d( start, trace[ "position" ] );
        return ( dist > 5 );
    }
    
    return false;
}

/#

    // Namespace door_internal / scripts\sp\door_internal
    // Params 1
    // Checksum 0x0, Offset: 0x29d0
    // Size: 0xc9, Type: dev
    function draw_max_yaw( left )
    {
        yaw = undefined;
        
        if ( left )
        {
            yaw = self.max_yaw_left;
            start = self.pivots[ "<dev string:x126>" ].origin;
        }
        else
        {
            yaw = self.max_yaw_right * -1;
            start = self.pivots[ "<dev string:x130>" ].origin;
        }
        
        trace_angles = self.true_start_angles + ( 0, yaw, 0 );
        line_end = start + anglestoforward( trace_angles ) * self.length;
        line( start, line_end, ( 1, 0, 0 ), 1, 0, 3 );
    }

#/

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x2aa1
// Size: 0xc9
function try_door_hint()
{
    self endon( "door_close" );
    
    if ( istrue( self.nohint ) )
    {
        return;
    }
    
    if ( !flag( "did_door_hint" ) )
    {
        thread display_hint_dist_check();
        
        while ( level.player usebuttonpressed() || isdefined( level.player getplayeruseentity() ) || isdefined( self.hint_delay_until ) && gettime() < self.hint_delay_until )
        {
            waitframe();
        }
        
        wait 0.25;
        
        if ( !flag( "door_second_interact" ) && !flag( "door_exceed_hint_dist" ) && !istrue( self.bashed ) )
        {
            flag_set( "did_door_hint" );
            thread display_hint( "door_hint_1", undefined, undefined, self, "bashed" );
        }
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x2b72
// Size: 0x3a, Type: bool
function first_hint_func()
{
    if ( flag( "door_second_interact" ) )
    {
        return true;
    }
    
    if ( flag( "door_exceed_hint_dist" ) )
    {
        return true;
    }
    
    if ( isdefined( level.player getplayeruseentity() ) )
    {
        return true;
    }
    
    return false;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x2bb5
// Size: 0x7b
function display_hint_dist_check()
{
    self notify( "display_hint_dist_check" );
    self endon( "display_hint_dist_check" );
    self endon( "death" );
    level.player endon( "death" );
    self endon( "reset_door" );
    flag_clear( "door_exceed_hint_dist" );
    
    while ( distancesquared( self.origin, level.player.origin ) < squared( 165 ) )
    {
        wait 0.1;
    }
    
    flag_set( "door_exceed_hint_dist" );
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x2c38
// Size: 0x27
function waittill_first_interact_or_bash()
{
    self endon( "entitydeleted" );
    self endon( "bashed" );
    self endon( "open_completely" );
    self waittill( "first_interact" );
    thread scripts\sp\door::door_ajar();
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x2c67
// Size: 0x73
function waittill_second_interact_or_bash()
{
    self endon( "bashed" );
    self waittill( "open_completely" );
    
    if ( getdvarint( @"hash_e76702af051fcb2b" ) )
    {
        thread player_door_gesture( 1 );
        wait 0.1;
    }
    
    level.player playrumbleonentity( "damage_light" );
    earthquake( 0.13, 0.2, level.player.origin, 200 );
    thread scripts\sp\door::door_open_completely();
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x2ce2
// Size: 0x4c, Type: bool
function can_pivot_change()
{
    if ( isdefined( self.pivot_ent ) && isdefined( self.current_pivot_struct ) && self.pivot_ent.angles != self.current_pivot_struct.angles )
    {
        return false;
    }
    
    return true;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x2d37
// Size: 0x15e
function set_pivot_point( left )
{
    if ( !can_pivot_change() )
    {
        if ( issubstr( self.current_pivot_struct.script_noteworthy, "pivot_left" ) )
        {
            self.hinge_side = "open_left";
            return;
        }
        
        self.hinge_side = "open_right";
        return;
    }
    
    if ( left )
    {
        new_pivot = "open_left";
    }
    else
    {
        new_pivot = "open_right";
    }
    
    self.hinge_side = new_pivot;
    
    if ( !isdefined( self.current_pivot_struct ) || self.current_pivot_struct != self.pivots[ new_pivot ] )
    {
        println( "<dev string:x13b>" + new_pivot );
        self.current_pivot_struct = self.pivots[ new_pivot ];
        
        if ( self islinked() )
        {
            self unlink();
        }
        
        if ( !isdefined( self.pivot_ent ) )
        {
            self.pivot_ent = spawn_script_origin( self.current_pivot_struct.origin, self.true_start_angles );
        }
        else
        {
            self.pivot_ent dontinterpolate();
            self.pivot_ent.origin = self.current_pivot_struct.origin;
        }
        
        wait 0.05;
        self linkto( self.pivot_ent );
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x2e9d
// Size: 0xaf
function monitor_open_completely()
{
    self endon( "open_completely" );
    self endon( "stop_monitoring_open_completely" );
    self endon( "entitydeleted" );
    self endon( "reset_door" );
    
    while ( level.player usebuttonpressed() )
    {
        wait 0.05;
    }
    
    while ( true )
    {
        if ( !istrue( self.bashed ) && scripts\sp\door::bash_door_isplayerclose() && level.player usebuttonpressed() && !isdefined( level.player getplayeruseentity() ) && pushents_clear() )
        {
            if ( !flag( "door_second_interact" ) )
            {
                flag_set( "door_second_interact" );
            }
            
            self notify( "open_completely" );
        }
        
        wait 0.05;
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x2f54
// Size: 0xda, Type: bool
function pushents_clear()
{
    if ( isdefined( self.pushents ) )
    {
        pushents = self.pushents;
        pushents = sortbydistance( pushents, self.origin );
        
        if ( distancesquared( self.origin, pushents[ 0 ].origin ) < 6400 )
        {
            origin = self.origin;
            angles = vectortoangles( self.forward );
            right = anglestoright( angles );
            normal = vectornormalize( pushents[ 0 ].origin - origin );
            dot = vectordot( right, normal );
            self.bashblocked = 1;
            
            if ( dot > 0 )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x3037
// Size: 0x41
function setup_open_struct( struct )
{
    if ( !isdefined( struct.radius ) )
    {
        struct.radius = 2.5;
    }
    
    if ( !isdefined( self.script_spawn_open_yaw ) )
    {
        struct thread open_struct_logic();
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x3080
// Size: 0x3b1
function open_struct_logic( display_locked )
{
    assertex( isstruct( self ), "Call this on the door.open_struct" );
    self.door endon( "stop_open_ability" );
    self.door endon( "stop_open_interact" );
    
    if ( !isdefined( self.openinteract ) )
    {
        self.openinteract = 0;
    }
    
    if ( ( istrue( display_locked ) || isdefined( self.door.lockpick ) ) && istrue( self.door.locked ) && !istrue( self.door.nohint ) )
    {
        if ( isdefined( self.door.lockpick ) )
        {
            self.door.lockpick.hint_string = undefined;
            self.door.lockpick.hint_icon = undefined;
        }
        
        scripts\sp\door::remove_open_interact_hint();
        self.no_open_interact = undefined;
        scripts\sp\door::create_open_interact_hint( &"SCRIPT/DOOR_HINT_LOCKED" );
        refresh_open_struct();
        
        if ( function_2998da25f4d455b1( self.door ) )
        {
            childthread function_a320f9f9dda13f8f();
        }
        else if ( isdefined( self.door.lockpick ) && isdefined( self.door.lockpick.var_6a6a7087aa17ffdd ) )
        {
            self [[ self.door.lockpick.var_6a6a7087aa17ffdd ]]();
        }
    }
    else
    {
        scripts\sp\door::create_open_interact_hint();
    }
    
    self.door thread door_open_think();
    
    if ( isdefined( self.cursor_hint_ent ) )
    {
        self.cursor_hint_ent waittill( "trigger" );
    }
    else
    {
        self waittill( "trigger" );
    }
    
    self notify( "stop_cursor_hint_thread" );
    self.door notify( "trigger" );
    level.player notify( "door_trigger", self.door );
    
    if ( getdvarint( @"hash_e76702af051fcb2b" ) )
    {
        thread player_door_gesture();
    }
    
    if ( function_e0b0300fbf1b645b( self.door ) )
    {
        if ( !isdefined( self.door.lockpick ) )
        {
            if ( getdvarint( @"hash_e76702af051fcb2b" ) )
            {
                wait 0.1;
            }
            
            if ( isdefined( self.door.script_sound_type ) && self.door.script_sound_type == "metal_heavy" )
            {
                thread play_sound_in_space( "scrpt_door_metal_open_locked", self.cursor_hint_ent.origin );
            }
            else
            {
                thread play_sound_in_space( "scrpt_door_wood_open_locked", self.cursor_hint_ent.origin );
            }
            
            level.player playrumbleonentity( "damage_heavy" );
            earthquake( 0.17, 0.2, level.player.origin, 200 );
            self.door notify( "locked" );
        }
        
        thread open_struct_logic( 1 );
        self.door thread scripts\sp\door_internal::cursor_hint_thread();
        return;
    }
    
    scripts\sp\door::remove_open_interact_hint();
    
    if ( getdvarint( @"hash_e76702af051fcb2b" ) )
    {
        wait 0.1;
    }
    else if ( isdefined( self.door.destructible ) )
    {
        self.door setscriptablepartstate( "main", "open_handle" );
    }
    
    self.door notify( "first_interact" );
    
    if ( !flag( "door_first_interact" ) )
    {
        flag_set( "door_first_interact" );
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x3439
// Size: 0xfd
function function_a320f9f9dda13f8f()
{
    self endon( "trigger" );
    self.cursor_hint_ent endon( "trigger" );
    previoushintstring = undefined;
    
    while ( isdefined( self.cursor_hint_ent ) )
    {
        hintstring = undefined;
        
        if ( isdefined( self.door.lockpick ) && isdefined( self.door.lockpick.var_6a6a7087aa17ffdd ) )
        {
            self [[ self.door.lockpick.var_6a6a7087aa17ffdd ]]();
        }
        else
        {
            if ( function_e0b0300fbf1b645b( self.door ) )
            {
                hintstring = &"SCRIPT/DOOR_HINT_LOCKED";
            }
            else if ( self.door door_bashable_by_player( 1 ) )
            {
                hintstring = &"SCRIPT/DOOR_HINT_USE";
            }
            else
            {
                hintstring = &"SCRIPT/DOOR_HINT_USE_NO_BASH";
            }
            
            if ( !is_equal( hintstring, previoushintstring ) )
            {
                self.cursor_hint_ent sethintstring( hintstring );
            }
            
            previoushintstring = hintstring;
        }
        
        waitframe();
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x353e
// Size: 0x17, Type: bool
function function_2998da25f4d455b1( door )
{
    return isdefined( door.script_side );
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x355e
// Size: 0x7a, Type: bool
function function_e0b0300fbf1b645b( door )
{
    if ( !door.locked )
    {
        return false;
    }
    
    if ( !isdefined( door.script_side ) )
    {
        return true;
    }
    
    var_65f355bcee376af7 = door function_d6f79a2aa10afcb1()[ 0 ];
    
    if ( door.script_side == "right" && var_65f355bcee376af7 )
    {
        return true;
    }
    
    if ( door.script_side == "left" && !var_65f355bcee376af7 )
    {
        return true;
    }
    
    return false;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x35e1
// Size: 0x16, Type: bool
function should_do_gesture()
{
    return !isnullweapon( level.player getcurrentweapon() );
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x3600
// Size: 0xc8
function player_door_gesture( pushhard )
{
    self notify( "player_door_gesture" );
    self endon( "player_door_gesture" );
    
    if ( isdefined( pushhard ) && pushhard )
    {
        gesture = level.interactive_doors.gesture_door_hard;
    }
    else
    {
        gesture = level.interactive_doors.gesture_door;
    }
    
    thread pushplayertodoor();
    target = spawn_tag_origin();
    target.origin = self.origin;
    
    if ( [[ level.interactive_doors.fnshoulddogesture ]]() )
    {
        level.player playgestureviewmodel( gesture, target );
        wait level.player getgestureanimlength( gesture );
    }
    
    target delete();
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x36d0
// Size: 0xde
function pushplayertodoor()
{
    decay = 0.04;
    growth = 0.2;
    timefactor = 0;
    level.player thread blend_movespeedscale( 0.1, 0.3, "doorOpen" );
    
    while ( timefactor < 0.99 )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        pushlogic( timefactor );
        timefactor += growth;
        wait 0.05;
    }
    
    timefactor = 1;
    level.player thread blend_movespeedscale( 1, 0.7, "doorOpen" );
    
    while ( timefactor > 0.01 )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        pushlogic( timefactor );
        timefactor -= decay;
        wait 0.05;
    }
    
    level.player pushplayervector( ( 0, 0, 0 ) );
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x37b6
// Size: 0x9d
function pushlogic( timefactor )
{
    vec = self.origin - level.player geteye();
    dist = length( vec );
    distfact = math::normalize_value( 20, 50, dist );
    distforce = math::factor_value( 5, 11, distfact );
    dir = vectornormalize( vec );
    force = timefactor * distforce;
    level.player pushplayervector( dir * force );
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x385b
// Size: 0x81
function player_window_gesture( duration )
{
    self notify( "player_window_gesture" );
    self endon( "player_window_gesture" );
    gesture = level.interactive_doors.gesture_window;
    
    if ( [[ level.interactive_doors.fnshoulddogesture ]]() )
    {
        duration = ter_op( isdefined( duration ), duration, 1 );
        level.player playgestureviewmodel( gesture );
        wait duration;
    }
    
    level.player stopgestureviewmodel( gesture, 2 );
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x38e4
// Size: 0x82, Type: bool
function door_bashable_by_player( forcursorhint )
{
    if ( istrue( self.no_bash ) || istrue( self.was_opened_halfway ) || istrue( self.open_completely ) || istrue( self.bashed ) )
    {
        /#
            self.debug_activity = "<dev string:x151>";
        #/
        
        return false;
    }
    
    if ( istrue( forcursorhint ) )
    {
        return true;
    }
    
    if ( isnullweapon( level.player getcurrentweapon() ) )
    {
        return false;
    }
    
    if ( function_4812cda9829d627a() )
    {
        return true;
    }
    
    return false;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x396f
// Size: 0x231, Type: bool
function function_4812cda9829d627a()
{
    if ( within_fov( level.player.origin, level.player.angles, get_door_bottom_center(), 0.82 ) )
    {
        /#
            if ( getdvarint( @"hash_6985e82f27803483" ) )
            {
                print3d( get_door_bottom_center(), "<dev string:x181>", ( 0, 1, 0 ), 1, 0.1, 1, 1 );
            }
        #/
        
        return true;
    }
    else
    {
        /#
            if ( getdvarint( @"hash_6985e82f27803483" ) )
            {
                print3d( get_door_bottom_center(), "<dev string:x192>", ( 1, 0, 0 ), 1, 0.1, 1, 1 );
            }
        #/
    }
    
    if ( within_fov( level.player.origin, level.player.angles, get_door_bottom_handle(), 0.82 ) )
    {
        /#
            if ( getdvarint( @"hash_6985e82f27803483" ) )
            {
                print3d( get_door_bottom_handle(), "<dev string:x181>", ( 0, 1, 0 ), 1, 0.1, 1, 1 );
            }
        #/
        
        return true;
    }
    else
    {
        /#
            if ( getdvarint( @"hash_6985e82f27803483" ) )
            {
                print3d( get_door_bottom_handle(), "<dev string:x192>", ( 1, 0, 0 ), 1, 0.1, 1, 1 );
            }
        #/
    }
    
    if ( within_fov( level.player.origin, level.player.angles, get_door_bottom_origin(), 0.82 ) )
    {
        /#
            if ( getdvarint( @"hash_6985e82f27803483" ) )
            {
                print3d( get_door_bottom_origin(), "<dev string:x181>", ( 0, 1, 0 ), 1, 0.1, 1, 1 );
            }
        #/
        
        return true;
    }
    else
    {
        /#
            if ( getdvarint( @"hash_6985e82f27803483" ) )
            {
                print3d( get_door_bottom_origin(), "<dev string:x192>", ( 1, 0, 0 ), 1, 0.1, 1, 1 );
            }
        #/
    }
    
    return false;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x3ba9
// Size: 0x13b, Type: bool
function should_bash_open()
{
    thread bash_debug( 1 );
    
    if ( door_bashable_by_player() )
    {
        /#
            if ( getdvarint( @"hash_6985e82f27803483" ) )
            {
                printtoscreen2d( 900, 700, "<dev string:x1a3>", ( 0, 1, 0 ), 2 );
            }
        #/
        
        if ( level.player ismeleeing() )
        {
            thread bash_debug( 2000 );
            return true;
        }
        
        if ( !level.player issprinting() )
        {
            return false;
        }
        
        if ( getdvarint( @"scr_door_bash_requires_use" ) )
        {
            if ( !level.player usebuttonpressed() )
            {
                return false;
            }
        }
        
        playerspeed = length( level.player getvelocity() );
        
        if ( playerspeed < 50 )
        {
            return false;
        }
        
        vec = vectornormalize( level.player geteye() - get_door_center() );
        doordot = vectordot( vec, anglestoforward( scripts\sp\door::get_door_angles() ) );
        
        if ( abs( doordot ) > 0.4 )
        {
            return false;
        }
        
        self.bashscale = math::lerp_fraction( 50, 195, playerspeed );
        thread bash_debug( 2000 );
        return true;
    }
    
    return false;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x3ced
// Size: 0x21f
function bash_debug( duration )
{
    /#
        if ( getdvarint( @"hash_6985e82f27803483" ) )
        {
            line( level.player.origin, get_door_center(), ( 1, 1, 1 ), 1, 0, duration );
            line( level.player.origin, self.doorbottomcenter, ( 1, 1, 1 ), 1, 0, duration );
            line( level.player.origin, level.player.origin + anglestoforward( level.player.angles ) * 32, ( 1, 0.5, 0 ), 1, 0, duration );
            normal = vectornormalize( self.doorbottomcenter - level.player.origin );
            forward = anglestoforward( level.player.angles );
            dot = vectordot( forward, normal );
            color = ter_op( dot >= 0.82, ( 0, 1, 0 ), ( 1, 0, 0 ) );
            print3d( get_door_center(), "<dev string:x1b1>" + dot, color, 1, 0.1, duration, 1 );
            vec = vectornormalize( level.player geteye() - get_door_center() );
            dot = vectordot( vec, anglestoforward( scripts\sp\door::get_door_angles() ) );
            color = ter_op( abs( dot ) <= 0.4, ( 0, 1, 0 ), ( 1, 0, 0 ) );
            print3d( get_door_center() + ( 0, 0, -1.5 ), "<dev string:x1be>" + dot, color, 1, 0.1, duration, 1 );
        }
    #/
}

// Namespace door_internal / scripts\sp\door_internal
// Params 3
// Checksum 0x0, Offset: 0x3f14
// Size: 0xdd
function stealth_broadcast( event, originator, radius )
{
    if ( !isdefined( radius ) && broadcaststealthevent( originator, event ) )
    {
        return;
    }
    
    dist = ter_op( isdefined( radius ), radius, 500 );
    guys = get_all_closest_living( self.origin, getaiarray( "axis" ), dist, 0 );
    
    if ( !guys.size )
    {
        return;
    }
    
    foreach ( g in guys )
    {
        if ( isdefined( g.stealth ) )
        {
            g aieventlistenerevent( event, level.player, self.origin );
        }
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x3ff9
// Size: 0x9f
function combat_getinfoinradius( radius )
{
    dist = ter_op( isdefined( radius ), radius, 500 );
    guys = get_all_closest_living( self.origin, getaiarray( "axis" ), dist, 0 );
    
    if ( !guys.size )
    {
        return;
    }
    
    foreach ( g in guys )
    {
        g getenemyinfo( level.player );
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x40a0
// Size: 0x1b8
function get_bash_yaw( scale )
{
    if ( self.open_left )
    {
        yaw_left = self.max_yaw_left;
        
        if ( scale < 1 )
        {
            yaw_left = math::factor_value( 55, 170, scale );
            yaw_left = min( yaw_left, self.max_yaw_left );
        }
        
        bash_yaw = self.true_start_angles[ 1 ] + yaw_left;
    }
    else
    {
        yaw_right = self.max_yaw_right;
        
        if ( scale < 1 )
        {
            yaw_right = math::factor_value( 55, 170, scale );
            yaw_right = min( yaw_right, self.max_yaw_right );
        }
        
        bash_yaw = self.true_start_angles[ 1 ] - yaw_right;
    }
    
    if ( isdefined( self.pushents ) )
    {
        pushents = self.pushents;
        pushents = sortbydistance( pushents, self.origin );
        
        if ( distancesquared( self.origin, pushents[ 0 ].origin ) < 6400 )
        {
            origin = self.origin;
            angles = vectortoangles( self.forward );
            right = anglestoright( angles );
            normal = vectornormalize( pushents[ 0 ].origin - origin );
            dot = vectordot( right, normal );
            self.bashblocked = 1;
            
            if ( dot > 0 )
            {
                bash_yaw = self.true_start_angles[ 1 ] - 4;
            }
            else
            {
                bash_yaw = self.true_start_angles[ 1 ] + 4;
            }
        }
    }
    
    return bash_yaw;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x4261
// Size: 0xdb
function bashed_locked_door( velocity )
{
    level.player endon( "death" );
    
    if ( isdefined( self.isbashing ) )
    {
        return;
    }
    
    self.isbashing = 1;
    thread bashed_locked_door_sfx();
    self notify( "trigger" );
    self notify( "bashing_while_locked" );
    self notify( "locked" );
    level.player viewkick( 10, get_door_center(), 0 );
    earthquake( 1, 0.3, level.player.origin, 75 );
    level.player playrumbleonentity( "heavy_1s" );
    self.open_struct thread open_struct_logic( 1 );
    thread scripts\sp\door_internal::cursor_hint_thread();
    
    while ( level.player ismeleeing() )
    {
        waitframe();
    }
    
    self.isbashing = undefined;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x4344
// Size: 0x91
function bashed_locked_door_sfx()
{
    if ( !isdefined( self.bashedsfx ) )
    {
        self.bashedsfx = 1;
        org = spawn( "script_origin", self.origin + ( 0, 0, 42 ) );
        org playsound( "door_locked_bashed", "sounddone" );
        
        if ( randomint( 100 ) < 40 )
        {
            level.player playsound( "breathing_limp" );
        }
        
        org waittill( "sounddone" );
        org delete();
        self.bashedsfx = undefined;
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x43dd
// Size: 0x5d
function door_bash_presentation()
{
    screenshake( level.player.origin, 16, 0, 0, 0.45 );
    level.player playrumbleonentity( "grenade_rumble" );
    earthquake( 0.6, 0.75, level.player.origin, 200 );
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x4442
// Size: 0x160
function close_prompt( delay )
{
    self notify( "close_prompt" );
    self endon( "close_prompt" );
    self endon( "reset_door" );
    self endon( "entitydeleted" );
    
    if ( !istrue( level.interactive_doors.close_prompt ) )
    {
        return;
    }
    
    flag_wait( "interactive_doors_ready" );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    while ( true )
    {
        self.open_struct.no_open_interact = undefined;
        self.open_struct thread scripts\sp\door::create_open_interact_hint( &"SCRIPT/DOOR_HINT_CLOSE" );
        thread cursor_hint_thread();
        waitframe();
        self.open_struct.cursor_hint_ent waittill( "trigger" );
        
        if ( !close_check() )
        {
            thread display_hint( "door_hint_obstructed", 1 );
            wait 1;
            continue;
        }
        
        self notify( "stop_monitoring_open_completely" );
        
        if ( isdefined( self.doubledoorother ) )
        {
            self.doubledoorother notify( "stop_monitoring_open_completely" );
        }
        
        if ( getdvarint( @"hash_e76702af051fcb2b" ) )
        {
            thread player_door_gesture();
        }
        
        if ( isdefined( self.doubledoorother ) )
        {
            self.doubledoorother thread scripts\sp\door::remove_open_prompts();
            self.doubledoorother thread scripts\sp\door::door_close();
        }
        
        scripts\sp\door::door_close();
        waitframe();
        
        if ( isdefined( self.doubledoorother ) )
        {
            self.doubledoorother thread scripts\sp\door::reset_door();
        }
        
        thread scripts\sp\door::reset_door();
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x45aa
// Size: 0xba, Type: bool
function close_check()
{
    contents = scripts\engine\trace::create_character_contents();
    yaw_start = scripts\sp\door::get_door_angles()[ 1 ];
    yaw_end = self.true_start_angles[ 1 ];
    trace_count = ceil( abs( yaw_end - yaw_start ) / 15 );
    left = self.current_pivot_struct == self.pivots[ "open_left" ];
    
    for ( trace = 0; trace < trace_count ; trace++ )
    {
        angle = yaw_start + ( yaw_end - yaw_start ) * trace / trace_count;
        
        if ( !yaw_collision_check( angle, left, contents ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x466d
// Size: 0xd3
function monitor_door_push( delay )
{
    self notify( "monitor_door_push" );
    self endon( "monitor_door_push" );
    self endon( "reset_door" );
    self endon( "stop_push_open" );
    self endon( "bashed_full" );
    self endon( "entitydeleted" );
    
    if ( !isdefined( delay ) )
    {
        delay = 0.5;
    }
    
    if ( self.bashed )
    {
        wait self.bashtime + 0.05;
        self.pivot_ent rotateto( self.pivot_ent.angles, 0.05 );
    }
    else if ( delay > 0 )
    {
        wait delay;
    }
    
    thread door_ease_in_open_input();
    
    while ( true )
    {
        if ( scripts\sp\door::interact_door_ispushentclose() )
        {
            push_door();
        }
        else if ( istrue( self.isplayingpushsound ) )
        {
            self.isplayingpushsound = 0;
            self notify( "stop_door_creak" );
        }
        
        waitframe();
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x4748
// Size: 0x66
function door_ease_in_open_input()
{
    maxtime = 1;
    time = maxtime;
    self.masterdoorratescale = 0;
    
    while ( true )
    {
        if ( !isdefined( self ) || time <= 0 )
        {
            break;
        }
        
        self.masterdoorratescale = 1 - time / maxtime;
        wait 0.05;
        time -= 0.05;
    }
    
    self.masterdoorratescale = 1;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x47b6
// Size: 0x53
function get_pushent()
{
    if ( isdefined( self.pushents ) )
    {
        pushents = array_add( self.pushents, level.player );
    }
    else
    {
        return level.player;
    }
    
    pushents = sortbydistance( pushents, self.origin );
    return pushents[ 0 ];
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x4812
// Size: 0x40f
function push_door()
{
    if ( self.bashed_full )
    {
        return;
    }
    
    if ( istrue( self.bash_opening ) )
    {
        return;
    }
    
    pushent = get_pushent();
    max_dist = 36;
    min_dist = 0;
    max_push = 25;
    endpoint = interact_door_get_endpoint();
    dist = distance( pushent.origin, endpoint );
    percent = math::normalize_value( min_dist, max_dist, dist );
    amount = max_push * ( 1 - percent );
    amount *= self.masterdoorratescale;
    push_left = scripts\sp\door::should_open_left( self.pivot_ent.angles, pushent );
    
    if ( abs( amount ) < 0.001 )
    {
        return;
    }
    
    self.open_struct scripts\sp\door::remove_open_interact_hint();
    currentyaw = scripts\sp\door::get_door_angles()[ 1 ];
    yaw_dir = ter_op( push_left == 1, 1, -1 );
    target_yaw = currentyaw + amount * yaw_dir;
    
    if ( push_left )
    {
        if ( self.hinge_side == "open_left" )
        {
            angle_diff = scripts\sp\door::angle_diff( target_yaw, self.true_start_angles[ 1 ] );
            
            if ( angle_diff > self.max_yaw_left )
            {
                self.debug_activity = "Pushed to max left yaw of " + self.max_yaw_left;
                self.open_completely = 1;
                thread scripts\sp\door::updatenavobstacle();
                self notify( "stop_push_open" );
                return;
            }
        }
        else if ( target_yaw > self.true_start_angles[ 1 ] )
        {
            self.debug_activity = "Pushed back closed, right hinge";
            
            if ( !function_9f4e269e748b55d0() )
            {
                thread scripts\sp\door::reset_door();
                self notify( "stop_push_open" );
                return;
            }
        }
    }
    else if ( self.hinge_side == "open_right" )
    {
        angle_diff = abs( scripts\sp\door::angle_diff( target_yaw, self.true_start_angles[ 1 ] ) );
        
        if ( angle_diff > self.max_yaw_right )
        {
            self.debug_activity = "Pushed to max right yaw of " + self.max_yaw_right;
            self.open_completely = 1;
            thread scripts\sp\door::updatenavobstacle();
            self notify( "stop_push_open" );
            return;
        }
    }
    else if ( target_yaw < self.true_start_angles[ 1 ] )
    {
        self.debug_activity = "Pushed back closed, left hinge";
        
        if ( !function_9f4e269e748b55d0() )
        {
            thread scripts\sp\door::reset_door();
            self notify( "stop_push_open" );
            return;
        }
    }
    
    if ( amount > 0.4 )
    {
        thread try_push_sound();
        
        if ( !flag( "door_second_interact" ) )
        {
            flag_set( "door_second_interact" );
        }
    }
    else if ( istrue( self.isplayingpushsound ) )
    {
        self.isplayingpushsound = 0;
        self notify( "stop_door_creak" );
    }
    
    /#
        self.debug_activity = "<dev string:x1d4>" + target_yaw;
    #/
    
    self.pivot_ent.angles = ( self.pivot_ent.angles[ 0 ], target_yaw, self.pivot_ent.angles[ 2 ] );
    self.forward = anglestoforward( self.pivot_ent.angles );
    
    if ( door_is_half_open() )
    {
        if ( !self.was_opened_halfway )
        {
            thread suspicious_door_stealth_check( 1 );
        }
        
        self.was_opened_halfway = 1;
        thread close_prompt( 0.25 );
    }
    
    updatenodelookpeek();
    curtime = gettime();
    
    if ( abs( angleclamp180( self.pivot_ent.angles[ 1 ] - self.nav_lastupdateangle ) ) > 20 && curtime - self.nav_lastupdatetime > 250 || curtime - self.nav_lastupdatetime > 1500 )
    {
        thread scripts\sp\door::updatenavobstacle( 1 );
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x4c29
// Size: 0xc3
function function_9f4e269e748b55d0()
{
    toodamaged = 0;
    
    if ( istrue( self.destructible ) || self isscriptable() )
    {
        if ( self getscriptablepartstate( "1" ) != "show" )
        {
            toodamaged = 1;
        }
        
        if ( !toodamaged )
        {
            destroyedcount = 0;
            
            foreach ( part in self.parts )
            {
                if ( part.health <= 0 )
                {
                    destroyedcount++;
                }
            }
            
            if ( destroyedcount / self.parts.size > 0.6 )
            {
                toodamaged = 1;
            }
        }
    }
    
    return toodamaged;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x4cf5
// Size: 0x5d1
function push_door_player_effects()
{
    push_left = scripts\sp\door::should_open_left( self.pivot_ent.angles, level.player );
    hinges = self.pivot_ent;
    channel = "doorPush" + self.doorid;
    
    if ( !isdefined( self.dooroffset ) )
    {
        self.dooroffset = ( 0, 0, 0 );
        self.doorrot = ( 0, 0, 0 );
        self.doorspeedscale = 1;
    }
    
    level.player notify( "newoffset" );
    level.player endon( "newoffset" );
    
    while ( true )
    {
        pushspot = door_get_pushspot();
        var_3cb06b55e15364aa = ( pushspot[ 0 ], pushspot[ 1 ], level.player.origin[ 2 ] ) - level.player.origin;
        var_1a291042071ca88b = vectornormalize( var_3cb06b55e15364aa );
        playerf = anglestoforward( level.player.angles );
        cross = vectorcross( playerf, var_1a291042071ca88b );
        dot = vectordot( playerf, var_1a291042071ca88b );
        var_271c6b91e677e543 = length( var_3cb06b55e15364aa );
        norminput = level.player getnormalizedmovement();
        norminput = ( norminput[ 0 ], -1 * norminput[ 1 ], 0 );
        localinput = rotatevector( norminput, level.player.angles );
        localinputdir = vectornormalize( localinput );
        localinputdot = vectordot( localinputdir, var_1a291042071ca88b );
        localinputmag = clamp( length( localinput ), 0, 1 );
        
        if ( cross[ 2 ] > 0 )
        {
            lr_offset = ( 0, 4, 0 );
            lr_rot = ( 0, -5, 0 );
        }
        else
        {
            lr_offset = ( 0, -2, 0 );
            lr_rot = ( 0, 2, 0 );
        }
        
        if ( dot > 0 )
        {
            if ( push_left )
            {
                fb_offset = ( 4, -1.5, 0 );
                fb_rot = ( -6, 5, 1.5 );
            }
            else
            {
                fb_offset = ( 4, -1.5, 0 );
                fb_rot = ( -6, -3, -1.5 );
            }
        }
        else
        {
            fb_offset = ( -3, 0, 0 );
            fb_rot = ( 0, 0, 0 );
        }
        
        var_67a920a30da099a0 = math::normalize_value( 0.6, 1, abs( dot ) );
        var_67a920a30da099a0 = math::normalized_float_smooth_in( var_67a920a30da099a0 );
        offset = math::factor_value( lr_offset, fb_offset, var_67a920a30da099a0 );
        rot = math::factor_value( lr_rot, fb_rot, var_67a920a30da099a0 );
        localinputdotfactor = math::normalize_value( 0, 1, localinputdot );
        var_f84a6367da0e58c8 = math::normalize_value( 0, 0.5, localinputmag );
        distfactor = 1 - math::normalize_value( 20, 50, var_271c6b91e677e543 );
        
        if ( level.player isfiring() )
        {
            firingfactor = 0.5;
        }
        else
        {
            firingfactor = 1;
        }
        
        var_969f06899b0abb5c = 1;
        var_969f06899b0abb5c *= localinputdotfactor;
        var_969f06899b0abb5c *= var_f84a6367da0e58c8;
        var_969f06899b0abb5c *= distfactor;
        var_969f06899b0abb5c *= firingfactor;
        offset *= var_969f06899b0abb5c;
        rot *= var_969f06899b0abb5c;
        
        if ( length( offset ) > length( self.dooroffset ) )
        {
            lerp = 0.312;
        }
        else
        {
            lerp = 0.234;
        }
        
        ads = 1 - level.player playerads();
        
        if ( level.player adsbuttonpressed() )
        {
            ads = math::normalize_value( 0.8, 1, ads );
        }
        
        self.dooroffset = math::lerp( self.dooroffset, offset, lerp );
        self.doorrot = math::lerp( self.doorrot, rot, lerp );
        speedscalefactor = 1;
        localinputdotfactor = math::normalize_value( 0, 1, localinputdot );
        var_f84a6367da0e58c8 = math::normalize_value( 0, 0.01, localinputmag );
        distfactor = 1 - math::normalize_value( 25, 70, var_271c6b91e677e543 );
        speedscalefactor *= localinputdotfactor;
        speedscalefactor *= var_f84a6367da0e58c8;
        speedscalefactor *= distfactor;
        speedscale = math::factor_value( 1, 0.2, speedscalefactor );
        lerp = 0.3;
        self.doorspeedscale = math::lerp( self.doorspeedscale, speedscale, lerp );
        level.player blend_movespeedscale( self.doorspeedscale, 0, channel );
        
        if ( length( self.dooroffset ) < 0.001 && self.doorspeedscale > 0.99 )
        {
            break;
        }
        
        if ( !isdefined( self ) )
        {
            break;
        }
        
        wait 0.05;
        offset = ( 0, 0, 0 );
    }
    
    if ( isdefined( self ) )
    {
        self.dooroffset = ( 0, 0, 0 );
        self.doorrot = ( 0, 0, 0 );
        self.doorspeedscale = 1;
    }
    
    level.player blend_movespeedscale( 1, 0, channel );
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x52ce
// Size: 0x8e
function door_get_pushspot()
{
    var_93271fe51551b254 = 12;
    playerspot = level.player.origin + anglestoforward( level.player.angles ) * var_93271fe51551b254;
    endpoint = interact_door_get_endpoint();
    startpoint = self.origin + self.forward * 5;
    pushspot = pointonsegmentnearesttopoint( startpoint, endpoint, playerspot );
    return pushspot;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x5365
// Size: 0x1b2
function initlinkednodes()
{
    bottomcenter = get_door_bottom_center();
    assert( isdefined( self.length ) );
    nodes = getnodesinradius( bottomcenter, self.length * 0.5 + 32, 0, 80, "cover" );
    assert( isdefined( nodes ) );
    
    if ( nodes.size > 0 )
    {
        self.linkednodes_hinge = [];
        self.linkednodes_knob = [];
        hingepos = undefined;
        
        if ( isdefined( self.pivots[ "open_left" ] ) )
        {
            hingepos = self.pivots[ "open_left" ].origin;
        }
        else if ( isdefined( self.pivots[ "open_right" ] ) )
        {
            hingepos = self.pivots[ "open_right" ].origin;
        }
        else
        {
            assertmsg( "door node setup - door has neither pivot left nor right" );
        }
        
        var_73752db085aa0240 = hingepos - bottomcenter;
        
        foreach ( node in nodes )
        {
            var_e86598e262fd7c11 = node.origin - bottomcenter;
            
            if ( vectordot( var_e86598e262fd7c11, var_73752db085aa0240 ) > 0 )
            {
                self.linkednodes_hinge[ self.linkednodes_hinge.size ] = node;
                continue;
            }
            
            self.linkednodes_knob[ self.linkednodes_knob.size ] = node;
        }
        
        return;
    }
    
    self.linkednodes_hinge = undefined;
    self.linkednodes_knob = undefined;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x551f
// Size: 0x17a
function updatenodelookpeek()
{
    dooryaw = angleclamp180( scripts\sp\door::get_door_angles()[ 1 ] );
    curangle = abs( angleclamp180( dooryaw - self.true_start_angles[ 1 ] ) );
    
    if ( isdefined( self.linkednodes_hinge ) )
    {
        doorforward = anglestoforward( ( 0, dooryaw, 0 ) );
        
        foreach ( node in self.linkednodes_hinge )
        {
            if ( curangle > 90 )
            {
                node setnodeallowlookpeek( 1 );
            }
            else
            {
                node setnodeallowlookpeek( 0 );
            }
            
            if ( curangle > 80 )
            {
                nodeforward = anglestoforward( node.angles );
                
                if ( vectordot( doorforward, nodeforward ) < 0 )
                {
                    node disconnectnode();
                }
                else
                {
                    node connectnode();
                }
                
                continue;
            }
            
            node connectnode();
        }
    }
    
    if ( isdefined( self.linkednodes_knob ) )
    {
        foreach ( node in self.linkednodes_knob )
        {
            if ( curangle > 45 )
            {
                node setnodeallowlookpeek( 1 );
                continue;
            }
            
            node setnodeallowlookpeek( 0 );
        }
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x56a1
// Size: 0xaf
function createinitialnavmodifier( linknameprefix )
{
    if ( !isdefined( self.navmodifier ) )
    {
        linkname = linknameprefix + "_nav_modifier";
        self.navmodifier = createnavmodifier( linkname, "script_linkname" );
        
        /#
            if ( !isdefined( self.navmodifier ) )
            {
                iprintln( "<dev string:x1df>" );
                line( ( 0, 0, 0 ), self.origin, ( 1, 0, 0 ), 1, 0, 100 );
                return;
            }
            
            println( "<dev string:x200>" + self.doorid + "<dev string:x226>" + self.origin );
        #/
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x5758
// Size: 0xc1
function suspicious_door_stealth_check( issuspicious )
{
    if ( !isdefined( level.stealth ) )
    {
        return;
    }
    
    if ( !getdvarint( @"hash_6109644d57e1122e" ) || !isdefined( level.stealth ) )
    {
        return;
    }
    
    if ( issuspicious )
    {
        level.stealth.suspicious_door.doors[ level.stealth.suspicious_door.doors.size ] = self;
        return;
    }
    
    level.stealth.suspicious_door.doors = array_remove( level.stealth.suspicious_door.doors, self );
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x5821
// Size: 0x38
function try_push_sound()
{
    if ( !isdefined( self.isplayingpushsound ) )
    {
        self.isplayingpushsound = 0;
    }
    
    if ( !self.isplayingpushsound )
    {
        self.isplayingpushsound = 1;
        thread door_creak_sound();
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x5861
// Size: 0x66
function door_creak_sound()
{
    self notify( "stop stopping door creak" );
    var_7da6017ed0aee8e = get_door_audio_material();
    self scalevolume( 1 );
    alias = "scrpt_door_" + var_7da6017ed0aee8e + "_creak_lp";
    
    if ( soundexists( alias ) )
    {
        self playloopsound( alias );
    }
    
    waittill_any( "stop_door_creak", "stop_push_open" );
    thread door_creak_sound_stop();
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x58cf
// Size: 0x23
function door_creak_sound_stop()
{
    self endon( "stop stopping door creak" );
    self scalevolume( 0, 0.5 );
    wait 0.55;
    self stoploopsound();
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x58fa
// Size: 0x1f
function interact_door_get_endpoint()
{
    return self.origin + self.forward * self.length;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x5922
// Size: 0x7e
function door_is_at_max_yaw( either )
{
    angle_diff = scripts\sp\door::angle_diff( scripts\sp\door::get_door_angles()[ 1 ], self.true_start_angles[ 1 ] );
    
    if ( isdefined( either ) )
    {
        return ( angle_diff >= self.max_yaw_left || angle_diff <= -1 * self.max_yaw_right );
    }
    
    if ( self.open_left )
    {
        return ( angle_diff >= self.max_yaw_left );
    }
    
    return angle_diff <= -1 * self.max_yaw_right;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x59a8
// Size: 0x55
function door_is_half_open()
{
    angle_diff = scripts\sp\door::angle_diff( scripts\sp\door::get_door_angles()[ 1 ], self.true_start_angles[ 1 ] );
    
    if ( self.open_left )
    {
        return ( angle_diff >= self.max_yaw_left / 2 );
    }
    
    return angle_diff <= self.max_yaw_right / -2;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x5a05
// Size: 0x39, Type: bool
function door_is_open_at_least( checkangle )
{
    angle_diff = scripts\sp\door::angle_diff( scripts\sp\door::get_door_angles()[ 1 ], self.true_start_angles[ 1 ] );
    return abs( angle_diff ) >= checkangle;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x5a47
// Size: 0x56
function get_door_center()
{
    angles = scripts\sp\door::get_door_angles();
    self.doorcenter = self.origin + ( 0, 0, 55 ) + anglestoforward( angles ) * self.length * 1.2 / 2;
    return self.doorcenter;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x5aa6
// Size: 0x47
function get_door_bottom_center()
{
    self.doorbottomcenter = get_door_center();
    self.doorbottomcenter = ( self.doorbottomcenter[ 0 ], self.doorbottomcenter[ 1 ], self.origin[ 2 ] );
    return self.doorbottomcenter;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x5af6
// Size: 0x3f
function get_door_bottom_handle()
{
    angles = scripts\sp\door::get_door_angles();
    self.doorbottomhandle = self.origin + anglestoforward( angles ) * self.length;
    return self.doorbottomhandle;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x5b3e
// Size: 0x1d
function get_door_bottom_origin()
{
    self.doorbottomorigin = self.origin;
    return self.doorbottomorigin;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 2
// Checksum 0x0, Offset: 0x5b64
// Size: 0xfc, Type: bool
function isnavpointaccesiblefrombehinddoor( targetpos, door )
{
    if ( isdefined( door.doorbottomcenter ) )
    {
        spot = door.doorbottomcenter;
    }
    else
    {
        spot = door.origin;
    }
    
    vec = vectornormalize( spot - self.origin );
    var_3e0586184e6fe4d5 = spot + anglestoforward( vectortoangles( vec ) ) * 7;
    trace = navtrace( var_3e0586184e6fe4d5, targetpos, self, 1 );
    
    /#
        color = ( 0, 1, 0 );
        
        if ( trace[ "<dev string:x233>" ] < 0.88 )
        {
            color = ( 1, 0, 0 );
        }
        
        line( var_3e0586184e6fe4d5, trace[ "<dev string:x23c>" ], color, 1, 0, 2 );
        iprintln( trace[ "<dev string:x233>" ] );
    #/
    
    return trace[ "fraction" ] >= 0.9;
}

/#

    // Namespace door_internal / scripts\sp\door_internal
    // Params 1
    // Checksum 0x0, Offset: 0x5c69
    // Size: 0xc7, Type: dev
    function print_navtrace( point )
    {
        self endon( "<dev string:x245>" );
        
        while ( true )
        {
            trace = navtrace( self.origin, point, self, 1 );
            line( self.origin, point, ( 0, 1, 0 ), 1, 0, 1 );
            line( self.origin, trace[ "<dev string:x23c>" ], ( 1, 0, 0 ), 1, 0, 1 );
            print3d( self.origin + ( 0, 0, 60 ), "<dev string:x24b>" + trace[ "<dev string:x233>" ], ( 1, 1, 1 ), 1, 1, 1 );
            wait 0.05;
        }
    }

#/

// Namespace door_internal / scripts\sp\door_internal
// Params 2
// Checksum 0x0, Offset: 0x5d38
// Size: 0x7d
function print3d_on_me( txt, duration )
{
    self endon( "death" );
    duration *= 1000;
    time = gettime();
    
    while ( gettime() < time + duration )
    {
        /#
            print3d( self.origin + ( 0, 0, 60 ), txt, ( 1, 0.5, 0.8 ), 1, 0.5, 1 );
        #/
        
        wait 0.05;
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x5dbd
// Size: 0x31
function get_door_audio_material()
{
    var_702d68f1ec16e21c = self.script_sound_type;
    
    if ( !isdefined( var_702d68f1ec16e21c ) )
    {
        var_702d68f1ec16e21c = "wood_heavy";
        println( "<dev string:x252>" );
    }
    
    return var_702d68f1ec16e21c;
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x5df7
// Size: 0x120
function double_doors_init_auto()
{
    foreach ( door in level.interactive_doors.ents )
    {
        otherdoorlist = getentarrayinradius( "interactive_door", "script_noteworthy", door.origin, 150 );
        doorfwd = anglestoforward( door.angles );
        
        foreach ( otherdoor in otherdoorlist )
        {
            if ( otherdoor == door )
            {
                continue;
            }
            
            if ( isdefined( otherdoor.doubledoors ) )
            {
                continue;
            }
            
            if ( vectordot( anglestoforward( otherdoor.angles ), doorfwd ) < -0.99 )
            {
                scripts\sp\door::double_doors_init( door, otherdoor );
                break;
            }
        }
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x5f1f
// Size: 0x37
function double_doors_waittill_interact()
{
    self notify( "double_doors_waittill_interact" );
    self endon( "double_doors_waittill_interact" );
    self endon( "bashed" );
    self endon( "open_completely" );
    self waittill( "first_interact" );
    self.doubledoorother notify( "first_interact" );
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x5f5e
// Size: 0x59
function double_doors_waittill_bashed()
{
    self notify( "double_doors_waittill_bashed" );
    self endon( "double_doors_waittill_bashed" );
    self endon( "first_interact" );
    self endon( "open_completely" );
    
    while ( true )
    {
        self waittill( "attempt_bash", opener );
        self.doubledoorother thread scripts\sp\door::door_bash_open( opener );
        
        if ( !self.locked )
        {
            return;
        }
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x5fbf
// Size: 0x62
function double_doors_waittill_open_completely()
{
    self notify( "double_doors_waittill_open_completely" );
    self endon( "double_doors_waittill_open_completely" );
    self endon( "first_interact" );
    self endon( "bashed" );
    self.doubledoorother endon( "open_completely" );
    self.doubledoorother endon( "opened_completely" );
    self waittill( "opened_completely", opener );
    self.doubledoorother thread scripts\sp\door::door_open_completely( opener );
}

// Namespace door_internal / scripts\sp\door_internal
// Params 1
// Checksum 0x0, Offset: 0x6029
// Size: 0xd3
function double_doors_hint_pos( door_other )
{
    flag_wait( "interactive_doors_ready_internal" );
    struct = spawnstruct();
    struct.origin = math::get_mid_point( self.open_struct.origin, door_other.open_struct.origin );
    scripts\sp\door::remove_open_prompts();
    struct.door = self;
    
    if ( isdefined( self.open_struct ) && isdefined( self.open_struct.radius ) )
    {
        struct.radius = self.open_struct.radius;
    }
    
    self.open_struct = struct;
    setup_open_struct( struct );
    thread cursor_hint_thread();
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x6104
// Size: 0x275
function door_watch_unresolved_collision()
{
    self endon( "death" );
    
    for ( ;; )
    {
        if ( isdefined( self.door_unresolved_collision_count ) && self.door_unresolved_collision_count >= 3 )
        {
            if ( !isdefined( self.notsolid ) )
            {
                /#
                    if ( getdvarint( @"hash_6985e82f27803483" ) )
                    {
                        print( "<dev string:x2d8>" + gettime() );
                        print3d( level.player.origin, "<dev string:x2fc>", ( 1, 0, 0 ), 1, 0.25, 1000, 1 );
                        debugaxis( level.player.origin, level.player getplayerangles( 1 ), 8, undefined, 0, 1000 );
                        line( level.player.origin, self.origin, ( 1, 0, 0 ), 1, 0, 1000 );
                    }
                #/
                
                self notsolid();
                self.notsolid = 1;
                self.door_unresolved_collision_origin = self.origin;
            }
            else if ( isdefined( self.notsolid ) && !level.player istouching( self ) )
            {
                /#
                    if ( getdvarint( @"hash_6985e82f27803483" ) )
                    {
                        print( "<dev string:x302>" + gettime() );
                        print3d( level.player.origin, "<dev string:x32c>", ( 0, 1, 0 ), 1, 0.25, 1000, 1 );
                        debugaxis( level.player.origin, level.player getplayerangles( 1 ), 8, undefined, 0, 1000 );
                        line( level.player.origin, self.origin, ( 0, 1, 0 ), 1, 0, 1000 );
                    }
                #/
                
                self solid();
                self.notsolid = undefined;
                self.door_unresolved_collision_count = undefined;
                self.door_unresolved_collision_start_time = undefined;
                break;
            }
        }
        else if ( isdefined( self.door_unresolved_collision_count ) && self.door_unresolved_collision_count > 0 && gettime() - self.door_unresolved_collision_start_time > 500 )
        {
            self.door_unresolved_collision_count = undefined;
            self.door_unresolved_collision_start_time = undefined;
            break;
        }
        
        waitframe();
    }
}

// Namespace door_internal / scripts\sp\door_internal
// Params 0
// Checksum 0x0, Offset: 0x6381
// Size: 0x7f
function door_watch_unresolved_collision_count()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "unresolved_collision", mover );
        
        if ( isdefined( mover ) && istrue( mover.doorclip ) )
        {
            if ( !isdefined( mover.door_unresolved_collision_count ) )
            {
                mover.door_unresolved_collision_count = 1;
                mover.door_unresolved_collision_start_time = gettime();
                mover thread door_watch_unresolved_collision();
                continue;
            }
            
            mover.door_unresolved_collision_count++;
        }
    }
}

