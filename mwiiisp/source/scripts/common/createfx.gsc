#using scripts\common\createfxmenu;
#using scripts\common\fx;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace createfx;

// Namespace createfx / scripts\common\createfx
// Params 3
// Checksum 0x0, Offset: 0xab8
// Size: 0xf3
function createeffect( type, fxid, islevelexploder )
{
    ent = spawnstruct();
    
    if ( !isdefined( level.createfxent ) )
    {
        level.createfxent = [];
    }
    
    if ( !isdefined( islevelexploder ) )
    {
        level.createfxent[ level.createfxent.size ] = ent;
    }
    
    ent.v = [];
    ent.v[ "type" ] = type;
    ent.v[ "fxid" ] = fxid;
    ent.v[ "angles" ] = ( 0, 0, 0 );
    ent.v[ "origin" ] = ( 0, 0, 0 );
    
    /#
        set_createfx_enabled();
        
        if ( level.createfx_enabled )
        {
            ent.drawn = 1;
        }
    #/
    
    return ent;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0xbb4
// Size: 0x7
function getloopeffectdelaydefault()
{
    return 0.5;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0xbc4
// Size: 0x4
function getoneshoteffectdelaydefault()
{
    return -4;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0xbd1
// Size: 0x3, Type: bool
function getexploderdelaydefault()
{
    return false;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0xbdd
// Size: 0x7
function getintervalsounddelaymindefault()
{
    return 0.75;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0xbed
// Size: 0x4
function getintervalsounddelaymaxdefault()
{
    return 2;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0xbfa
// Size: 0x132
function createloopsound()
{
    ent = spawnstruct();
    
    if ( !isdefined( level.createfxent ) )
    {
        level.createfxent = [];
    }
    
    level.createfxent[ level.createfxent.size ] = ent;
    ent.v = [];
    ent.v[ "type" ] = "soundfx";
    ent.v[ "fxid" ] = "No FX";
    ent.v[ "soundalias" ] = "nil";
    ent.v[ "angles" ] = ( 0, 0, 0 );
    ent.v[ "origin" ] = ( 0, 0, 0 );
    ent.v[ "server_culled" ] = 1;
    
    if ( getdvar( @"hash_7ebee7a942eed3c8" ) != "1" )
    {
        ent.v[ "server_culled" ] = 0;
    }
    
    /#
        set_createfx_enabled();
        
        if ( level.createfx_enabled )
        {
            ent.drawn = 1;
        }
    #/
    
    return ent;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0xd35
// Size: 0x5b
function createintervalsound()
{
    ent = createloopsound();
    ent.v[ "type" ] = "soundfx_interval";
    ent.v[ "delay_min" ] = getintervalsounddelaymindefault();
    ent.v[ "delay_max" ] = getintervalsounddelaymaxdefault();
    return ent;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0xd99
// Size: 0x41
function createnewexploder()
{
    if ( !isdefined( level.createfxent ) )
    {
        level.createfxent = [];
    }
    
    ent = createnewexploder_internal();
    level.createfxent[ level.createfxent.size ] = ent;
    return ent;
}

// Namespace createfx / scripts\common\createfx
// Params 2
// Checksum 0x0, Offset: 0xde3
// Size: 0x4e
function add_exploder( exploderid, ent )
{
    array = [];
    
    if ( isdefined( level.createfxexploders[ exploderid ] ) )
    {
        array = level.createfxexploders[ exploderid ];
    }
    
    array[ array.size ] = ent;
    level.createfxexploders[ exploderid ] = array;
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0xe39
// Size: 0x1fd
function createnewexploder_internal( ent )
{
    if ( !isdefined( ent ) )
    {
        ent = spawnstruct();
        ent.v = [];
    }
    
    ent.v[ "type" ] = "exploder";
    ent.v[ "exploder_type" ] = "normal";
    
    if ( !isdefined( ent.v[ "fxid" ] ) )
    {
        ent.v[ "fxid" ] = "No FX";
    }
    
    if ( !isdefined( ent.v[ "soundalias" ] ) )
    {
        ent.v[ "soundalias" ] = "nil";
    }
    
    if ( !isdefined( ent.v[ "loopsound" ] ) )
    {
        ent.v[ "loopsound" ] = "nil";
    }
    
    if ( !isdefined( ent.v[ "angles" ] ) )
    {
        ent.v[ "angles" ] = ( 0, 0, 0 );
    }
    
    if ( !isdefined( ent.v[ "origin" ] ) )
    {
        ent.v[ "origin" ] = ( 0, 0, 0 );
    }
    
    if ( !isdefined( ent.v[ "exploder" ] ) )
    {
        ent.v[ "exploder" ] = 1;
    }
    
    if ( !isdefined( ent.v[ "flag" ] ) )
    {
        ent.v[ "flag" ] = "nil";
    }
    
    if ( !isdefined( ent.v[ "delay" ] ) || ent.v[ "delay" ] < 0 )
    {
        ent.v[ "delay" ] = getexploderdelaydefault();
    }
    
    /#
        set_createfx_enabled();
        
        if ( level.createfx_enabled )
        {
            ent.drawn = 1;
        }
    #/
    
    return ent;
}

// Namespace createfx / scripts\common\createfx
// Params 2
// Checksum 0x0, Offset: 0x103f
// Size: 0x39
function createexploderex( fxid, exploderid )
{
    ent = createexploder( fxid );
    ent.v[ "exploder" ] = exploderid;
    return ent;
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x1081
// Size: 0xea
function createreactiveent( fxid )
{
    ent = spawnstruct();
    
    if ( !isdefined( level.createfxent ) )
    {
        level.createfxent = [];
    }
    
    level.createfxent[ level.createfxent.size ] = ent;
    ent.v = [];
    ent.v[ "origin" ] = ( 0, 0, 0 );
    ent.v[ "reactive_radius" ] = 350;
    
    if ( isdefined( fxid ) )
    {
        ent.v[ "fxid" ] = fxid;
    }
    else
    {
        ent.v[ "fxid" ] = "No FX";
    }
    
    ent.v[ "type" ] = "reactive_fx";
    ent.v[ "soundalias" ] = "nil";
    return ent;
}

// Namespace createfx / scripts\common\createfx
// Params 2
// Checksum 0x0, Offset: 0x1174
// Size: 0x4f
function set_origin_and_angles( origin, angles )
{
    if ( isdefined( level.createfx_offset ) )
    {
        origin += level.createfx_offset;
    }
    
    self.v[ "origin" ] = origin;
    self.v[ "angles" ] = angles;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x11cb
// Size: 0x4a
function set_forward_and_up_vectors()
{
    self.v[ "up" ] = anglestoup( self.v[ "angles" ] );
    self.v[ "forward" ] = anglestoforward( self.v[ "angles" ] );
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x121d
// Size: 0x10a
function createfx_common()
{
    precacheshader( "black" );
    level._createfx = spawnstruct();
    level._createfx.grenade = spawn( "script_origin", ( 0, 0, 0 ) );
    level._createfx.grenade.fx = loadfx( "vfx/core/expl/grenadeexp_default" );
    level._createfx.grenade.sound = "iw9_frag_grenade_expl_trans";
    level._createfx.grenade.radius = 256;
    precachemodel( "axis_guide_createfx_rot" );
    precachemodel( "axis_guide_createfx" );
    flag_init( "createfx_saving" );
    flag_init( "createfx_started" );
    
    if ( !isdefined( level.createfx ) )
    {
        level.createfx = [];
    }
    
    level.createfx_loopcounter = 0;
    waitframe();
    level notify( "createfx_common_done" );
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x132f
// Size: 0x17f
function init_level_variables()
{
    level._createfx.selectedmove_up = 0;
    level._createfx.selectedmove_forward = 0;
    level._createfx.selectedmove_right = 0;
    level._createfx.selectedrotate_pitch = 0;
    level._createfx.selectedrotate_roll = 0;
    level._createfx.selectedrotate_yaw = 0;
    level._createfx.selected_fx = [];
    level._createfx.selected_fx_ents = [];
    level._createfx.rate = 1;
    level._createfx.snap2normal = 0;
    level._createfx.snap2angle = 0;
    level._createfx.snap2anglesnaps = [ 0, 90, 45, 15 ];
    level._createfx.axismode = 0;
    level._createfx.select_by_name = 0;
    level._createfx.drawaxis = 1;
    level._createfx.player_speed = getdvarfloat( @"g_speed" );
    set_player_speed_hud();
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x14b6
// Size: 0xbf
function init_locked_list()
{
    level._createfx.lockedlist = [];
    level._createfx.lockedlist[ "escape" ] = 1;
    level._createfx.lockedlist[ "BUTTON_LSHLDR" ] = 1;
    level._createfx.lockedlist[ "BUTTON_RSHLDR" ] = 1;
    level._createfx.lockedlist[ "mouse1" ] = 1;
    level._createfx.lockedlist[ "lctrl" ] = 1;
    level._createfx.lockedlist[ "rctrl" ] = 1;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x157d
// Size: 0x25a
function init_colors()
{
    colors = [];
    colors[ "loopfx" ][ "selected" ] = ( 1, 1, 0.2 );
    colors[ "loopfx" ][ "highlighted" ] = ( 0.4, 0.95, 1 );
    colors[ "loopfx" ][ "default" ] = ( 0.3, 0.8, 1 );
    colors[ "oneshotfx" ][ "selected" ] = ( 1, 1, 0.2 );
    colors[ "oneshotfx" ][ "highlighted" ] = ( 0.4, 0.95, 1 );
    colors[ "oneshotfx" ][ "default" ] = ( 0.3, 0.8, 1 );
    colors[ "exploder" ][ "selected" ] = ( 1, 1, 0.2 );
    colors[ "exploder" ][ "highlighted" ] = ( 1, 0.2, 0.2 );
    colors[ "exploder" ][ "default" ] = ( 1, 0.1, 0.1 );
    colors[ "rainfx" ][ "selected" ] = ( 1, 1, 0.2 );
    colors[ "rainfx" ][ "highlighted" ] = ( 0.95, 0.4, 0.95 );
    colors[ "rainfx" ][ "default" ] = ( 0.78, 0, 0.73 );
    colors[ "soundfx" ][ "selected" ] = ( 1, 1, 0.2 );
    colors[ "soundfx" ][ "highlighted" ] = ( 0.5, 1, 0.75 );
    colors[ "soundfx" ][ "default" ] = ( 0.2, 0.9, 0.2 );
    colors[ "soundfx_interval" ][ "selected" ] = ( 1, 1, 0.2 );
    colors[ "soundfx_interval" ][ "highlighted" ] = ( 0.5, 1, 0.75 );
    colors[ "soundfx_interval" ][ "default" ] = ( 0.2, 0.9, 0.2 );
    colors[ "reactive_fx" ][ "selected" ] = ( 1, 1, 0.2 );
    colors[ "reactive_fx" ][ "highlighted" ] = ( 0.5, 1, 0.75 );
    colors[ "reactive_fx" ][ "default" ] = ( 0.2, 0.9, 0.2 );
    level._createfx.colors = colors;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x17df
// Size: 0x784
function createfxlogic()
{
    waittillframeend();
    waitframe();
    
    if ( !isdefined( level._effect ) )
    {
        level._effect = [];
    }
    
    if ( getdvar( @"createfx_map" ) == "" )
    {
        /#
            setdevdvar( @"createfx_map", level.script );
        #/
    }
    else if ( getdvar( @"createfx_map" ) == level.script )
    {
        [[ level.func_position_player ]]();
    }
    
    init_crosshair();
    init_menu();
    init_huds();
    init_tool_hud();
    init_level_variables();
    init_locked_list();
    init_colors();
    level.player setclientomnvar( "ui_hide_hud", 1 );
    
    /#
        setdevdvar( @"fx", "<dev string:x1c>" );
        setdevdvar( @"select_by_substring", "<dev string:x20>" );
    #/
    
    setdvarifuninitialized( @"createfx_filter", "" );
    setdvarifuninitialized( @"createfx_vfxonly", "0" );
    
    /#
        if ( getdvar( @"hash_1b7eec3c3206970b" ) == "<dev string:x20>" )
        {
            setdevdvar( @"hash_1b7eec3c3206970b", "<dev string:x21>" );
        }
        
        if ( getdvar( @"hash_cbfe648b557aa861" ) == "<dev string:x20>" )
        {
            setdevdvar( @"hash_cbfe648b557aa861", "<dev string:x21>" );
        }
    #/
    
    level.createfx_draw_enabled = 1;
    level.last_displayed_ent = undefined;
    level.buttonisheld = [];
    lastplayerorigin = ( 0, 0, 0 );
    flag_set( "createfx_started" );
    
    if ( !level.mp_createfx )
    {
        lastplayerorigin = level.player.origin;
    }
    
    lasthighlightedent = undefined;
    level.fx_rotating = 0;
    setmenu( "none" );
    level.createfx_selecting = 0;
    level.createfx_inputlocked = 0;
    
    foreach ( ent in level.createfxent )
    {
        ent post_entity_creation_function();
    }
    
    thread draw_distance();
    lastselectentity = undefined;
    thread createfx_autosave();
    
    for ( ;; )
    {
        changedselectedents = 0;
        right = anglestoright( level.player getplayerangles() );
        forward = anglestoforward( level.player getplayerangles() );
        up = anglestoup( level.player getplayerangles() );
        dot = 0.85;
        var_fc03616d10f9d715 = forward * 750;
        level.createfxcursor = scripts\engine\trace::_bullet_trace( level.player geteye(), level.player geteye() + var_fc03616d10f9d715, 0, undefined );
        highlightedent = undefined;
        level.buttonclick = [];
        level.button_is_kb = [];
        process_button_held_and_clicked();
        ctrlheld = button_is_held( "lctrl", "rctrl", "BUTTON_LSHLDR" );
        shiftheld = button_is_held( "lshift", "rshift" );
        leftclick = button_is_clicked( "mouse1", "BUTTON_A" );
        leftheld = button_is_held( "mouse1", "BUTTON_A" );
        create_fx_menu();
        btn = "F5";
        
        if ( getdvarint( @"hash_1b7eec3c3206970b" ) )
        {
            btn = "F4";
        }
        
        /#
            if ( button_is_clicked( btn ) )
            {
                setdevdvar( @"hash_47822f6cb09b386c", 1 );
            }
            
            if ( getdvarint( @"hash_47822f6cb09b386c" ) )
            {
                setdevdvar( @"hash_47822f6cb09b386c", 0 );
                generate_fx_log();
            }
        #/
        
        if ( button_is_clicked( "F2" ) )
        {
            toggle_createfx_drawing();
        }
        
        if ( button_is_clicked( "z" ) )
        {
            toggle_createfx_axis();
        }
        
        if ( button_is_clicked( "ins" ) )
        {
            insert_effect();
        }
        
        if ( button_is_clicked( "del" ) )
        {
            delete_pressed();
        }
        
        if ( button_is_clicked( "escape" ) )
        {
            clear_settable_fx();
        }
        
        if ( button_is_clicked( "space" ) )
        {
            set_off_exploders();
        }
        
        if ( button_is_clicked( "u" ) )
        {
            select_by_name_list();
        }
        
        modify_player_speed();
        
        if ( !ctrlheld && !shiftheld && button_is_clicked( "g" ) )
        {
            select_all_exploders_of_currently_selected( "exploder" );
            select_all_exploders_of_currently_selected( "flag" );
        }
        
        if ( shiftheld )
        {
            if ( button_is_clicked( "g" ) )
            {
                goto_selected();
            }
        }
        
        if ( button_is_held( "h", "F1" ) && !level.mp_createfx )
        {
            show_help();
            waitframe();
            continue;
        }
        
        if ( button_is_clicked( "BUTTON_LSTICK" ) )
        {
            copy_ents();
        }
        
        if ( button_is_clicked( "BUTTON_RSTICK" ) )
        {
            paste_ents();
        }
        
        if ( ctrlheld )
        {
            if ( button_is_clicked( "c" ) )
            {
                copy_ents();
            }
            
            if ( button_is_clicked( "v" ) )
            {
                paste_ents();
            }
            
            if ( button_is_clicked( "g" ) )
            {
                spawn_grenade();
            }
        }
        
        if ( isdefined( level._createfx.selected_fx_option_index ) )
        {
            menu_fx_option_set();
        }
        
        for ( i = 0; i < level.createfxent.size ; i++ )
        {
            ent = level.createfxent[ i ];
            difference = vectornormalize( ent.v[ "origin" ] - level.player.origin + ( 0, 0, 55 ) );
            newdot = vectordot( forward, difference );
            
            if ( newdot < dot )
            {
                continue;
            }
            
            dot = newdot;
            highlightedent = ent;
        }
        
        level.fx_highlightedent = highlightedent;
        
        if ( isdefined( highlightedent ) )
        {
            if ( isdefined( lasthighlightedent ) )
            {
                if ( lasthighlightedent != highlightedent )
                {
                    if ( !ent_is_selected( lasthighlightedent ) )
                    {
                        lasthighlightedent thread entity_highlight_disable();
                    }
                    
                    if ( !ent_is_selected( highlightedent ) )
                    {
                        highlightedent thread entity_highlight_enable();
                    }
                }
            }
            else if ( !ent_is_selected( highlightedent ) )
            {
                highlightedent thread entity_highlight_enable();
            }
        }
        
        manipulate_createfx_ents( highlightedent, leftclick, leftheld, ctrlheld, right );
        changedselectedents = handle_selected_ents( changedselectedents );
        waitframe();
        
        if ( changedselectedents )
        {
            update_selected_entities();
        }
        
        if ( !level.mp_createfx )
        {
            lastplayerorigin = [[ level.func_position_player_get ]]( lastplayerorigin );
        }
        
        lasthighlightedent = highlightedent;
        
        if ( last_selected_entity_has_changed( lastselectentity ) )
        {
            level.effect_list_offset = 0;
            clear_settable_fx();
            setmenu( "none" );
        }
        
        if ( level._createfx.selected_fx_ents.size )
        {
            lastselectentity = level._createfx.selected_fx_ents[ level._createfx.selected_fx_ents.size - 1 ];
            continue;
        }
        
        lastselectentity = undefined;
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x1f6b
// Size: 0x1b2
function modify_player_speed()
{
    modify_speed = 0;
    ctrl_held = button_is_held( "lctrl", "rctrl" );
    
    if ( button_is_held( "." ) )
    {
        if ( ctrl_held )
        {
            if ( level._createfx.player_speed < 190 )
            {
                level._createfx.player_speed = 190;
            }
            else
            {
                level._createfx.player_speed += 10;
            }
        }
        else
        {
            level._createfx.player_speed += 5;
        }
        
        modify_speed = 1;
    }
    else if ( button_is_held( "," ) )
    {
        if ( ctrl_held )
        {
            if ( level._createfx.player_speed > 190 )
            {
                level._createfx.player_speed = 190;
            }
            else
            {
                level._createfx.player_speed -= 10;
            }
        }
        else
        {
            level._createfx.player_speed -= 5;
        }
        
        modify_speed = 1;
    }
    
    if ( modify_speed )
    {
        level._createfx.player_speed = clamp( level._createfx.player_speed, 5, 500 );
        [[ level.func_player_speed ]]();
        set_player_speed_hud();
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x2125
// Size: 0x16b
function set_player_speed_hud()
{
    if ( level.mp_createfx )
    {
        return;
    }
    
    if ( !isdefined( level._createfx.player_speed_hud ) )
    {
        hud = newhudelem();
        hud.alignx = "right";
        hud.foreground = 1;
        hud.fontscale = 1.2;
        hud.alpha = 0.2;
        hud.x = 320;
        hud.y = 420;
        
        /#
            hud setdevtext( "<dev string:x23>" );
        #/
        
        hud_value = newhudelem();
        hud_value.alignx = "left";
        hud_value.foreground = 1;
        hud_value.fontscale = 1.2;
        hud_value.alpha = 0.2;
        hud_value.x = 320;
        hud_value.y = 420;
        hud.hud_value = hud_value;
        level._createfx.player_speed_hud = hud;
    }
    
    level._createfx.player_speed_hud.hud_value setvalue( level._createfx.player_speed );
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x2298
// Size: 0x15
function toggle_createfx_drawing()
{
    level.createfx_draw_enabled = !level.createfx_draw_enabled;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x22b5
// Size: 0xca
function insert_effect()
{
    setmenu( "creation" );
    level.effect_list_offset = 0;
    clear_fx_hudelements();
    set_fx_hudelement( "Pick effect type to create:" );
    set_fx_hudelement( "1. One Shot FX" );
    
    if ( !level.mp_createfx )
    {
        set_fx_hudelement( "2. Looping FX" );
        set_fx_hudelement( "3. Looping sound" );
        set_fx_hudelement( "4. Exploder" );
        set_fx_hudelement( "5. One Shot Sound" );
        set_fx_hudelement( "6. Reactive FX" );
    }
    else
    {
        set_fx_hudelement( "2. Looping sound" );
        set_fx_hudelement( "3. Exploder" );
        set_fx_hudelement( "4. One Shot Sound" );
        set_fx_hudelement( "5. Reactive FX" );
    }
    
    set_fx_hudelement( "(c) Cancel >" );
    set_fx_hudelement( "(x) Exit >" );
}

// Namespace createfx / scripts\common\createfx
// Params 2
// Checksum 0x0, Offset: 0x2387
// Size: 0xbd, Type: bool
function is_ent_filtered_out( ent, filter )
{
    if ( filter != "" )
    {
        if ( isdefined( ent.v[ "type" ] ) && issubstr( ent.v[ "type" ], filter ) )
        {
            return false;
        }
        else if ( isdefined( ent.v[ "fxid" ] ) && issubstr( ent.v[ "fxid" ], filter ) )
        {
            return false;
        }
        else if ( isdefined( ent.v[ "soundalias" ] ) && issubstr( ent.v[ "soundalias" ], filter ) )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace createfx / scripts\common\createfx
// Params 5
// Checksum 0x0, Offset: 0x244d
// Size: 0x1e9
function manipulate_createfx_ents( highlightedent, leftclick, leftheld, ctrlheld, right )
{
    if ( !level.createfx_draw_enabled )
    {
        return;
    }
    
    if ( level._createfx.select_by_name )
    {
        level._createfx.select_by_name = 0;
        highlightedent = undefined;
    }
    else if ( select_by_substring() )
    {
        highlightedent = undefined;
    }
    
    for ( i = 0; i < level.createfxent.size ; i++ )
    {
        ent = level.createfxent[ i ];
        
        if ( !ent.drawn )
        {
            continue;
        }
        
        if ( is_ent_filtered_out( ent, getdvar( @"createfx_filter" ) ) )
        {
            continue;
        }
        
        scale = getdvarfloat( @"hash_af4eccdbca5a551c" );
        
        if ( isdefined( highlightedent ) && ent == highlightedent )
        {
            if ( !entities_are_selected() )
            {
                display_fx_info( ent );
            }
            
            if ( leftclick )
            {
                var_915bf244079e233e = index_is_selected( i );
                level.createfx_selecting = !var_915bf244079e233e;
                
                if ( !ctrlheld )
                {
                    selectedsize = level._createfx.selected_fx_ents.size;
                    clear_entity_selection();
                    
                    if ( var_915bf244079e233e && selectedsize == 1 )
                    {
                        select_entity( i, ent );
                    }
                }
                
                toggle_entity_selection( i, ent );
            }
            else if ( leftheld )
            {
                if ( ctrlheld )
                {
                    if ( level.createfx_selecting )
                    {
                        select_entity( i, ent );
                    }
                    
                    if ( !level.createfx_selecting )
                    {
                        deselect_entity( i, ent );
                    }
                }
            }
            
            colorindex = "highlighted";
        }
        else
        {
            colorindex = "default";
        }
        
        if ( index_is_selected( i ) )
        {
            colorindex = "selected";
        }
        
        ent createfx_print3d( colorindex, scale, right );
    }
}

// Namespace createfx / scripts\common\createfx
// Params 2
// Checksum 0x0, Offset: 0x263e
// Size: 0x2f0
function draw_origin( scale, colorindex )
{
    view_origin = level.player getvieworigin();
    view_angles = level.player getplayerangles();
    color = level._createfx.colors[ self.v[ "type" ] ][ colorindex ];
    line_alpha = 0;
    sprite_alpha = 1;
    angles_offset = ( 0, 0, 0 );
    isclose = distancesquared( view_origin, self.v[ "origin" ] ) < 36864;
    
    if ( isclose )
    {
        view_distance = distance( view_origin, self.v[ "origin" ] );
        distance_delta = view_distance / 176;
        line_alpha = 1 - clamp( distance_delta, 0, 1 );
        sprite_alpha = clamp( distance_delta, 0.333, 1 );
        offset_right = anglestoright( view_angles ) * -4;
        offset_up = anglestoup( view_angles ) * -4.666;
        angles_offset = offset_right + offset_up;
    }
    
    /#
        print3d( self.v[ "<dev string:x2b>" ] + angles_offset, "<dev string:x32>", color, sprite_alpha, scale );
        
        if ( line_alpha > 0 )
        {
            iswithinfov = within_fov( view_origin, view_angles, self.v[ "<dev string:x2b>" ], 0.422618 );
            
            if ( iswithinfov )
            {
                ssize = 2;
                lsize = 4;
                sphere( self.v[ "<dev string:x2b>" ], ssize * scale, color );
                forward = anglestoforward( self.v[ "<dev string:x34>" ] );
                forward *= lsize * scale;
                right = anglestoright( self.v[ "<dev string:x34>" ] ) * -1;
                right *= lsize * scale;
                up = anglestoup( self.v[ "<dev string:x34>" ] );
                up *= lsize * scale;
                line( self.v[ "<dev string:x2b>" ] - forward, self.v[ "<dev string:x2b>" ] + forward, color, line_alpha );
                line( self.v[ "<dev string:x2b>" ] - right, self.v[ "<dev string:x2b>" ] + right, color, line_alpha );
                line( self.v[ "<dev string:x2b>" ] - up, self.v[ "<dev string:x2b>" ] + up, color, line_alpha );
            }
        }
    #/
}

// Namespace createfx / scripts\common\createfx
// Params 3
// Checksum 0x0, Offset: 0x2936
// Size: 0x190
function createfx_print3d( colorindex, scale, right )
{
    draw_origin( scale, colorindex );
    
    if ( self.textalpha > 0 )
    {
        texts = get_print3d_text();
        printright = right * texts[ 0 ].size * -2.93;
        color = level._createfx.colors[ self.v[ "type" ] ][ colorindex ];
        
        if ( isdefined( self.is_playing ) )
        {
            color = ( 1, 0.5, 0 );
        }
        
        height = 15;
        
        foreach ( text in texts )
        {
            /#
                print3d( self.v[ "<dev string:x2b>" ] + printright + ( 0, 0, height ), text, color, self.textalpha, scale );
            #/
            
            height -= 13;
        }
        
        /#
            if ( isdefined( self.v[ "<dev string:x3b>" ] ) )
            {
                if ( self.v[ "<dev string:x4b>" ] == "<dev string:x50>" && !getdvarint( @"createfx_vfxonly" ) )
                {
                    sphere( self.v[ "<dev string:x2b>" ], self.v[ "<dev string:x3b>" ], color );
                }
            }
        #/
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x2ace
// Size: 0xbd
function get_print3d_text()
{
    switch ( self.v[ "type" ] )
    {
        case #"hash_46a741fcf24ab59":
            texts[ 0 ] = "reactive sound: " + self.v[ "soundalias" ];
            
            if ( !level.mp_createfx )
            {
                texts[ 1 ] = "reactive FX: " + self.v[ "fxid" ];
            }
            
            return texts;
        case #"hash_c9ec51ce0335258e":
        case #"hash_fbc4edc91b6c146a":
            return [ self.v[ "soundalias" ] ];
        default:
            return [ self.v[ "fxid" ] ];
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x2b93
// Size: 0x26
function select_by_name_list()
{
    level.effect_list_offset = 0;
    clear_fx_hudelements();
    setmenu( "select_by_name" );
    draw_effects_list();
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x2bc1
// Size: 0x296
function handle_selected_ents( changedselectedents )
{
    if ( level._createfx.selected_fx_ents.size > 0 )
    {
        changedselectedents = selected_ent_buttons( changedselectedents );
        
        if ( !current_mode_hud( "selected_ents" ) )
        {
            new_tool_hud( "selected_ents" );
            set_tool_hudelem( "Selected Ent Mode" );
            set_tool_hudelem( "Mode:", "move" );
            set_tool_hudelem( "Rate:", level._createfx.rate );
            set_tool_hudelem( "Snap2Normal:", level._createfx.snap2normal );
            set_tool_hudelem( "Snap2Angle:", level._createfx.snap2anglesnaps[ level._createfx.snap2angle ] );
        }
        
        if ( level._createfx.axismode && level._createfx.selected_fx_ents.size > 0 )
        {
            set_tool_hudelem( "Mode:", "rotate" );
            thread [[ level.func_process_fx_rotater ]]();
            
            if ( button_is_clicked( "enter", "p" ) )
            {
                reset_axis_of_selected_ents();
            }
            
            if ( button_is_clicked( "v" ) )
            {
                copy_angles_of_selected_ents();
            }
            
            for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
            {
                level._createfx.selected_fx_ents[ i ] draw_axis();
            }
            
            if ( level.selectedrotate_pitch != 0 || level.selectedrotate_yaw != 0 || level.selectedrotate_roll != 0 )
            {
                changedselectedents = 1;
            }
        }
        else
        {
            set_tool_hudelem( "Mode:", "move" );
            selectedmove_vector = get_selected_move_vector();
            
            for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
            {
                ent = level._createfx.selected_fx_ents[ i ];
                
                if ( isdefined( ent.model ) )
                {
                    continue;
                }
                
                ent draw_cross();
                ent.v[ "origin" ] = ent.v[ "origin" ] + selectedmove_vector;
            }
            
            if ( distance( ( 0, 0, 0 ), selectedmove_vector ) > 0 )
            {
                changedselectedents = 1;
            }
        }
    }
    else
    {
        clear_tool_hud();
    }
    
    return changedselectedents;
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x2e60
// Size: 0xb1
function selected_ent_buttons( changedselectedents )
{
    if ( button_is_clicked( "lshift", "rshift", "BUTTON_X" ) )
    {
        toggle_axismode();
    }
    
    modify_rate();
    
    if ( button_is_clicked( "s" ) )
    {
        toggle_snap2normal();
    }
    
    if ( button_is_clicked( "r" ) )
    {
        toggle_snap2angle();
    }
    
    if ( button_is_clicked( "end", "l" ) )
    {
        drop_selection_to_ground();
        changedselectedents = 1;
    }
    
    if ( button_is_clicked( "tab", "BUTTON_RSHLDR" ) )
    {
        move_selection_to_cursor();
        changedselectedents = 1;
    }
    
    if ( button_is_clicked( "e" ) )
    {
        convert_selection_to_exploder();
        changedselectedents = 1;
    }
    
    return changedselectedents;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x2f1a
// Size: 0x21a
function modify_rate()
{
    shift_held = button_is_held( "lshift", "rshift" );
    ctrl_held = button_is_held( "lctrl", "rctrl" );
    
    if ( button_is_clicked( "=" ) )
    {
        if ( shift_held )
        {
            level._createfx.rate += 1;
        }
        else if ( ctrl_held )
        {
            if ( level._createfx.rate < 1 )
            {
                level._createfx.rate = 1;
            }
            else
            {
                level._createfx.rate += 10;
            }
        }
        else
        {
            level._createfx.rate += 0.1;
        }
    }
    else if ( button_is_clicked( "-" ) )
    {
        if ( shift_held )
        {
            level._createfx.rate -= 1;
        }
        else if ( ctrl_held )
        {
            if ( level._createfx.rate > 1 )
            {
                level._createfx.rate = 1;
            }
            else
            {
                level._createfx.rate = 0.1;
            }
        }
        else
        {
            level._createfx.rate -= 0.1;
        }
    }
    
    level._createfx.rate = clamp( level._createfx.rate, 0.1, 100 );
    set_tool_hudelem( "Rate:", level._createfx.rate );
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x313c
// Size: 0x2a
function toggle_axismode()
{
    level._createfx.axismode = !level._createfx.axismode;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x316e
// Size: 0x49
function toggle_snap2normal()
{
    level._createfx.snap2normal = !level._createfx.snap2normal;
    set_tool_hudelem( "Snap2Normal:", level._createfx.snap2normal );
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x31bf
// Size: 0x9f
function toggle_snap2angle()
{
    level._createfx.snap2angle += 1;
    
    if ( level._createfx.snap2angle >= level._createfx.snap2anglesnaps.size )
    {
        level._createfx.snap2angle = 0;
    }
    
    set_tool_hudelem( "Snap2Angle:", level._createfx.snap2anglesnaps[ level._createfx.snap2angle ] );
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x3266
// Size: 0xb1
function copy_angles_of_selected_ents()
{
    level notify( "new_ent_selection" );
    
    for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
    {
        ent = level._createfx.selected_fx_ents[ i ];
        ent.v[ "angles" ] = level._createfx.selected_fx_ents[ level._createfx.selected_fx_ents.size - 1 ].v[ "angles" ];
        ent set_forward_and_up_vectors();
    }
    
    update_selected_entities();
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x331f
// Size: 0x83
function reset_axis_of_selected_ents()
{
    level notify( "new_ent_selection" );
    
    for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
    {
        ent = level._createfx.selected_fx_ents[ i ];
        ent.v[ "angles" ] = ( 0, 0, 0 );
        ent set_forward_and_up_vectors();
    }
    
    update_selected_entities();
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x33aa
// Size: 0x53
function last_selected_entity_has_changed( lastselectentity )
{
    if ( isdefined( lastselectentity ) )
    {
        if ( !entities_are_selected() )
        {
            return 1;
        }
    }
    else
    {
        return entities_are_selected();
    }
    
    return lastselectentity != level._createfx.selected_fx_ents[ level._createfx.selected_fx_ents.size - 1 ];
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x3406
// Size: 0xa9
function drop_selection_to_ground()
{
    for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
    {
        ent = level._createfx.selected_fx_ents[ i ];
        trace = scripts\engine\trace::_bullet_trace( ent.v[ "origin" ], ent.v[ "origin" ] + ( 0, 0, -2048 ), 0, undefined );
        ent.v[ "origin" ] = trace[ "position" ];
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x34b7
// Size: 0xde
function set_off_exploders()
{
    level notify( "createfx_exploder_reset" );
    exploders = [];
    
    foreach ( ent in level._createfx.selected_fx_ents )
    {
        if ( isdefined( ent.v[ "exploder" ] ) )
        {
            exploders[ ent.v[ "exploder" ] ] = 1;
        }
    }
    
    foreach ( _ in exploders )
    {
        exploder( key );
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x359d
// Size: 0xe5
function draw_distance()
{
    count = 0;
    
    /#
        if ( getdvarint( @"createfx_drawdist" ) == 0 )
        {
            setdevdvar( @"createfx_drawdist", "<dev string:x56>" );
        }
    #/
    
    for ( ;; )
    {
        maxdist = getdvarint( @"createfx_drawdist" );
        maxdist *= maxdist;
        
        for ( i = 0; i < level.createfxent.size ; i++ )
        {
            ent = level.createfxent[ i ];
            ent.drawn = distancesquared( level.player.origin, ent.v[ "origin" ] ) <= maxdist;
            count++;
            
            if ( count > 100 )
            {
                count = 0;
                waitframe();
            }
        }
        
        if ( level.createfxent.size == 0 )
        {
            waitframe();
        }
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x368a
// Size: 0x51
function createfx_autosave()
{
    setdvarifuninitialized( @"hash_9dbf8e4641a6231d", "300" );
    
    for ( ;; )
    {
        wait getdvarint( @"hash_9dbf8e4641a6231d" );
        flag_waitopen( "createfx_saving" );
        
        if ( getdvarint( @"hash_cbfe648b557aa861" ) )
        {
            continue;
        }
        
        generate_fx_log( 1 );
    }
}

// Namespace createfx / scripts\common\createfx
// Params 2
// Checksum 0x0, Offset: 0x36e3
// Size: 0x13b
function rotate_over_time( org, rotater )
{
    level endon( "new_ent_selection" );
    timer = 0.1;
    
    for ( p = 0; p < timer * 20 ; p++ )
    {
        if ( level.selectedrotate_pitch != 0 )
        {
            org addpitch( level.selectedrotate_pitch );
        }
        else if ( level.selectedrotate_yaw != 0 )
        {
            org addyaw( level.selectedrotate_yaw );
        }
        else
        {
            org addroll( level.selectedrotate_roll );
        }
        
        waitframe();
        org draw_axis();
        
        for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
        {
            ent = level._createfx.selected_fx_ents[ i ];
            
            if ( isdefined( ent.model ) )
            {
                continue;
            }
            
            ent.v[ "origin" ] = rotater[ i ].origin;
            ent.v[ "angles" ] = rotater[ i ].angles;
        }
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x3826
// Size: 0x1d
function delete_pressed()
{
    if ( level.createfx_inputlocked )
    {
        remove_selected_option();
        return;
    }
    
    delete_selection();
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x384b
// Size: 0xad
function remove_selected_option()
{
    if ( !isdefined( level._createfx.selected_fx_option_index ) )
    {
        return;
    }
    
    name = level._createfx.options[ level._createfx.selected_fx_option_index ][ "name" ];
    
    for ( i = 0; i < level.createfxent.size ; i++ )
    {
        ent = level.createfxent[ i ];
        
        if ( !ent_is_selected( ent ) )
        {
            continue;
        }
        
        ent remove_option( name );
    }
    
    update_selected_entities();
    clear_settable_fx();
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x3900
// Size: 0x16
function remove_option( name )
{
    self.v[ name ] = undefined;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x391e
// Size: 0xf3
function delete_selection()
{
    newarray = [];
    
    for ( i = 0; i < level.createfxent.size ; i++ )
    {
        ent = level.createfxent[ i ];
        
        if ( ent_is_selected( ent ) )
        {
            if ( isdefined( ent.loopsound_ent ) )
            {
                ent.loopsound_ent stoploopsound();
                ent.loopsound_ent delete();
            }
            
            if ( isdefined( ent.looper ) )
            {
                ent.looper delete();
            }
            
            ent notify( "stop_loop" );
            continue;
        }
        
        newarray[ newarray.size ] = ent;
    }
    
    level.createfxent = newarray;
    level._createfx.selected_fx = [];
    level._createfx.selected_fx_ents = [];
    clear_fx_hudelements();
    remove_axis_model();
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x3a19
// Size: 0x139
function move_selection_to_cursor()
{
    origin = level.createfxcursor[ "position" ];
    
    if ( level._createfx.selected_fx_ents.size <= 0 )
    {
        return;
    }
    
    center = get_center_of_array( level._createfx.selected_fx_ents );
    difference = center - origin;
    
    for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
    {
        ent = level._createfx.selected_fx_ents[ i ];
        
        if ( isdefined( ent.model ) )
        {
            continue;
        }
        
        ent.v[ "origin" ] = ent.v[ "origin" ] - difference;
        
        if ( level._createfx.snap2normal )
        {
            if ( isdefined( level.createfxcursor[ "normal" ] ) )
            {
                ent.v[ "angles" ] = vectortoangles( level.createfxcursor[ "normal" ] );
            }
        }
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x3b5a
// Size: 0xfa
function convert_selection_to_exploder()
{
    if ( level._createfx.selected_fx_ents.size < 1 )
    {
        return;
    }
    
    converted = 0;
    
    foreach ( ent in level._createfx.selected_fx_ents )
    {
        if ( ent.v[ "type" ] == "oneshotfx" )
        {
            converted = 1;
            createnewexploder_internal( ent );
            continue;
        }
        
        println( "<dev string:x5a>" + ent.v[ "<dev string:x8a>" ] + "<dev string:x8f>" + ent.v[ "<dev string:x2b>" ] );
    }
    
    if ( converted )
    {
        setmenu( "none" );
        display_fx_info( get_last_selected_ent() );
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x3c5c
// Size: 0x2d
function select_last_entity()
{
    select_entity( level.createfxent.size - 1, level.createfxent[ level.createfxent.size - 1 ] );
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x3c91
// Size: 0x160
function select_all_exploders_of_currently_selected( key )
{
    selected_exploders = [];
    
    foreach ( ent in level._createfx.selected_fx_ents )
    {
        if ( !isdefined( ent.v[ key ] ) )
        {
            continue;
        }
        
        value = ent.v[ key ];
        selected_exploders[ value ] = 1;
    }
    
    foreach ( value, _ in selected_exploders )
    {
        foreach ( index, ent in level.createfxent )
        {
            if ( index_is_selected( index ) )
            {
                continue;
            }
            
            if ( !isdefined( ent.v[ key ] ) )
            {
                continue;
            }
            
            if ( ent.v[ key ] != value )
            {
                continue;
            }
            
            select_entity( index, ent );
        }
    }
    
    update_selected_entities();
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x3df9
// Size: 0xb2
function copy_ents()
{
    if ( level._createfx.selected_fx_ents.size <= 0 )
    {
        return;
    }
    
    array = [];
    
    for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
    {
        ent = level._createfx.selected_fx_ents[ i ];
        newent = spawnstruct();
        newent.v = ent.v;
        newent post_entity_creation_function();
        array[ array.size ] = newent;
    }
    
    level.stored_ents = array;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x3eb3
// Size: 0x17
function post_entity_creation_function()
{
    self.textalpha = 0;
    self.drawn = 1;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x3ed2
// Size: 0x69
function paste_ents()
{
    if ( !isdefined( level.stored_ents ) )
    {
        return;
    }
    
    clear_entity_selection();
    
    for ( i = 0; i < level.stored_ents.size ; i++ )
    {
        add_and_select_entity( level.stored_ents[ i ] );
    }
    
    move_selection_to_cursor();
    update_selected_entities();
    level.stored_ents = [];
    copy_ents();
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x3f43
// Size: 0x28
function add_and_select_entity( ent )
{
    level.createfxent[ level.createfxent.size ] = ent;
    select_last_entity();
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x3f73
// Size: 0xa3
function get_center_of_array( array )
{
    center = ( 0, 0, 0 );
    
    for ( i = 0; i < array.size ; i++ )
    {
        center = ( center[ 0 ] + array[ i ].v[ "origin" ][ 0 ], center[ 1 ] + array[ i ].v[ "origin" ][ 1 ], center[ 2 ] + array[ i ].v[ "origin" ][ 2 ] );
    }
    
    return ( center[ 0 ] / array.size, center[ 1 ] / array.size, center[ 2 ] / array.size );
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x401f
// Size: 0xf1
function goto_selected()
{
    origin = undefined;
    
    if ( level._createfx.selected_fx_ents.size > 0 )
    {
        origin = get_center_of_array( level._createfx.selected_fx_ents );
    }
    else if ( isdefined( level.fx_highlightedent ) )
    {
        origin = level.fx_highlightedent.v[ "origin" ];
    }
    
    if ( !isdefined( origin ) )
    {
        println( "<dev string:x94>" );
        return;
    }
    
    angles = vectortoangles( level.player.origin - origin );
    new_origin = origin + anglestoforward( angles ) * 200;
    level.player setorigin( new_origin + ( 0, 0, -60 ) );
    level.player setplayerangles( vectortoangles( origin - new_origin ) );
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x4118
// Size: 0x14
function ent_draw_axis()
{
    self endon( "death" );
    
    for ( ;; )
    {
        draw_axis();
        waitframe();
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x4134
// Size: 0x2f, Type: bool
function rotation_is_occuring()
{
    if ( level.selectedrotate_roll != 0 )
    {
        return true;
    }
    
    if ( level.selectedrotate_pitch != 0 )
    {
        return true;
    }
    
    return level.selectedrotate_yaw != 0;
}

// Namespace createfx / scripts\common\createfx
// Params 3
// Checksum 0x0, Offset: 0x416c
// Size: 0x212
function print_fx_options( ent, tab, autosave )
{
    for ( i = 0; i < level._createfx.options.size ; i++ )
    {
        option = level._createfx.options[ i ];
        optionname = option[ "name" ];
        
        if ( !isdefined( ent.v[ optionname ] ) )
        {
            continue;
        }
        
        if ( !mask( option[ "mask" ], ent.v[ "type" ] ) )
        {
            continue;
        }
        
        if ( !level.mp_createfx )
        {
            if ( mask( "fx", ent.v[ "type" ] ) && optionname == "fxid" )
            {
                continue;
            }
            
            if ( ent.v[ "type" ] == "exploder" && optionname == "exploder" )
            {
                continue;
            }
            
            key = ent.v[ "type" ] + "/" + optionname;
            
            if ( isdefined( level._createfx.defaults[ key ] ) && level._createfx.defaults[ key ] == ent.v[ optionname ] )
            {
                continue;
            }
        }
        
        if ( option[ "type" ] == "string" )
        {
            stringvalue = ent.v[ optionname ] + "";
            
            if ( stringvalue == "nil" )
            {
                continue;
            }
            
            /#
                cfxprintln( tab + "<dev string:xcc>" + optionname + "<dev string:xd5>" + ent.v[ optionname ] + "<dev string:xdd>" );
            #/
            
            continue;
        }
        
        /#
            cfxprintln( tab + "<dev string:xcc>" + optionname + "<dev string:xe0>" + ent.v[ optionname ] + "<dev string:xe7>" );
        #/
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x4386
// Size: 0x65
function entity_highlight_disable()
{
    self notify( "highlight change" );
    self endon( "highlight change" );
    
    for ( ;; )
    {
        self.textalpha *= 0.85;
        self.textalpha -= 0.05;
        
        if ( self.textalpha < 0 )
        {
            break;
        }
        
        wait 0.05;
    }
    
    self.textalpha = 0;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x43f3
// Size: 0x62
function entity_highlight_enable()
{
    self notify( "highlight change" );
    self endon( "highlight change" );
    
    for ( ;; )
    {
        self.textalpha += 0.05;
        self.textalpha *= 1.25;
        
        if ( self.textalpha > 1 )
        {
            break;
        }
        
        waitframe();
    }
    
    self.textalpha = 1;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x445d
// Size: 0x3d
function clear_settable_fx()
{
    level.createfx_inputlocked = 0;
    
    /#
        setdevdvar( @"fx", "<dev string:x1c>" );
    #/
    
    level._createfx.selected_fx_option_index = undefined;
    reset_fx_hud_colors();
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x44a2
// Size: 0x5b
function reset_fx_hud_colors()
{
    for ( i = 0; i < level._createfx.hudelem_count ; i++ )
    {
        level._createfx.hudelems[ i ][ 0 ].color = ( 1, 1, 1 );
    }
}

// Namespace createfx / scripts\common\createfx
// Params 2
// Checksum 0x0, Offset: 0x4505
// Size: 0x41
function toggle_entity_selection( index, ent )
{
    if ( isdefined( level._createfx.selected_fx[ index ] ) )
    {
        deselect_entity( index, ent );
        return;
    }
    
    select_entity( index, ent );
}

// Namespace createfx / scripts\common\createfx
// Params 2
// Checksum 0x0, Offset: 0x454e
// Size: 0x87
function select_entity( index, ent )
{
    if ( isdefined( level._createfx.selected_fx[ index ] ) )
    {
        return;
    }
    
    clear_settable_fx();
    level notify( "new_ent_selection" );
    ent thread entity_highlight_enable();
    level._createfx.selected_fx[ index ] = 1;
    level._createfx.selected_fx_ents[ level._createfx.selected_fx_ents.size ] = ent;
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x45dd
// Size: 0x25, Type: bool
function ent_is_highlighted( ent )
{
    if ( !isdefined( level.fx_highlightedent ) )
    {
        return false;
    }
    
    return ent == level.fx_highlightedent;
}

// Namespace createfx / scripts\common\createfx
// Params 2
// Checksum 0x0, Offset: 0x460b
// Size: 0xe4
function deselect_entity( index, ent )
{
    if ( !isdefined( level._createfx.selected_fx[ index ] ) )
    {
        return;
    }
    
    clear_settable_fx();
    level notify( "new_ent_selection" );
    level._createfx.selected_fx[ index ] = undefined;
    
    if ( !ent_is_highlighted( ent ) )
    {
        ent thread entity_highlight_disable();
    }
    
    newarray = [];
    
    for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
    {
        if ( level._createfx.selected_fx_ents[ i ] != ent )
        {
            newarray[ newarray.size ] = level._createfx.selected_fx_ents[ i ];
        }
    }
    
    level._createfx.selected_fx_ents = newarray;
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x46f7
// Size: 0x21, Type: bool
function index_is_selected( index )
{
    return isdefined( level._createfx.selected_fx[ index ] );
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x4721
// Size: 0x54, Type: bool
function ent_is_selected( ent )
{
    for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
    {
        if ( level._createfx.selected_fx_ents[ i ] == ent )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x477e
// Size: 0x92
function clear_entity_selection()
{
    for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
    {
        if ( !ent_is_highlighted( level._createfx.selected_fx_ents[ i ] ) )
        {
            level._createfx.selected_fx_ents[ i ] thread entity_highlight_disable();
        }
    }
    
    level._createfx.selected_fx = [];
    level._createfx.selected_fx_ents = [];
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x4818
// Size: 0x21f
function draw_axis()
{
    /#
        if ( level._createfx.drawaxis == 1 )
        {
            set_axis_model( "<dev string:xe9>" );
            level._createfx.axis.origin = self.v[ "<dev string:x2b>" ];
            level._createfx.axis.angles = self.v[ "<dev string:x34>" ];
        }
        else if ( level._createfx.drawaxis == 2 )
        {
            range = 25 * getdvarfloat( @"hash_af4eccdbca5a551c" );
            forward = anglestoforward( self.v[ "<dev string:x34>" ] );
            forward *= range;
            right = anglestoright( self.v[ "<dev string:x34>" ] ) * -1;
            right *= range;
            up = anglestoup( self.v[ "<dev string:x34>" ] );
            up *= range;
            line( self.v[ "<dev string:x2b>" ], self.v[ "<dev string:x2b>" ] + forward, ( 1, 0, 0 ), 1 );
            line( self.v[ "<dev string:x2b>" ], self.v[ "<dev string:x2b>" ] + up, ( 0, 1, 0 ), 1 );
            line( self.v[ "<dev string:x2b>" ], self.v[ "<dev string:x2b>" ] + right, ( 0, 0, 1 ), 1 );
        }
        
        if ( isdefined( self.v[ "<dev string:x101>" ] ) )
        {
            drawsoundshape( self.v[ "<dev string:x2b>" ], self.v[ "<dev string:x34>" ], self.v[ "<dev string:x101>" ], ( 1, 0, 1 ), 1 );
        }
    #/
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x4a3f
// Size: 0x8c
function set_axis_model( model )
{
    if ( !isdefined( level._createfx.axis ) )
    {
        level._createfx.axis = spawn( "script_model", ( 0, 0, 0 ) );
        return;
    }
    
    if ( level._createfx.axis.model != model )
    {
        level._createfx.axis setmodel( model );
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x4ad3
// Size: 0x33
function remove_axis_model()
{
    if ( !isdefined( level._createfx.axis ) )
    {
        return;
    }
    
    level._createfx.axis delete();
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x4b0e
// Size: 0x137
function draw_cross()
{
    /#
        if ( level._createfx.drawaxis == 1 )
        {
            set_axis_model( "<dev string:x10c>" );
            level._createfx.axis.origin = self.v[ "<dev string:x2b>" ];
            level._createfx.axis.angles = self.v[ "<dev string:x34>" ];
            return;
        }
        
        if ( level._createfx.drawaxis == 2 )
        {
            range = 4;
            line( self.v[ "<dev string:x2b>" ] - ( 0, 0, range ), self.v[ "<dev string:x2b>" ] + ( 0, 0, range ) );
            line( self.v[ "<dev string:x2b>" ] - ( 0, range, 0 ), self.v[ "<dev string:x2b>" ] + ( 0, range, 0 ) );
            line( self.v[ "<dev string:x2b>" ] - ( range, 0, 0 ), self.v[ "<dev string:x2b>" ] + ( range, 0, 0 ) );
        }
    #/
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x4c4d
// Size: 0x64
function toggle_createfx_axis()
{
    level._createfx.drawaxis++;
    
    if ( level._createfx.drawaxis > 2 )
    {
        level._createfx.drawaxis = 0;
    }
    
    if ( level._createfx.drawaxis != 1 )
    {
        remove_axis_model();
    }
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x4cb9
// Size: 0x14
function createfx_centerprint( text )
{
    thread createfx_centerprint_thread( text );
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x4cd5
// Size: 0x47
function createfx_centerprint_thread( text )
{
    level notify( "new_createfx_centerprint" );
    level endon( "new_createfx_centerprint" );
    
    /#
        level.createfx_centerprint setdevtext( text );
        wait 4.5;
        level.createfx_centerprint setdevtext( "<dev string:x20>" );
    #/
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x4d24
// Size: 0x274
function get_selected_move_vector()
{
    yaw = level.player getplayerangles()[ 1 ];
    angles = ( 0, yaw, 0 );
    right = anglestoright( angles );
    forward = anglestoforward( angles );
    up = anglestoup( angles );
    keypressed = 0;
    rate = level._createfx.rate;
    
    if ( buttondown( "kp_uparrow", "DPAD_UP" ) )
    {
        if ( level.selectedmove_forward < 0 )
        {
            level.selectedmove_forward = 0;
        }
        
        level.selectedmove_forward += rate;
    }
    else if ( buttondown( "kp_downarrow", "DPAD_DOWN" ) )
    {
        if ( level.selectedmove_forward > 0 )
        {
            level.selectedmove_forward = 0;
        }
        
        level.selectedmove_forward -= rate;
    }
    else
    {
        level.selectedmove_forward = 0;
    }
    
    if ( buttondown( "kp_rightarrow", "DPAD_RIGHT" ) )
    {
        if ( level.selectedmove_right < 0 )
        {
            level.selectedmove_right = 0;
        }
        
        level.selectedmove_right += rate;
    }
    else if ( buttondown( "kp_leftarrow", "DPAD_LEFT" ) )
    {
        if ( level.selectedmove_right > 0 )
        {
            level.selectedmove_right = 0;
        }
        
        level.selectedmove_right -= rate;
    }
    else
    {
        level.selectedmove_right = 0;
    }
    
    if ( buttondown( "BUTTON_Y" ) )
    {
        if ( level.selectedmove_up < 0 )
        {
            level.selectedmove_up = 0;
        }
        
        level.selectedmove_up += rate;
    }
    else if ( buttondown( "BUTTON_B" ) )
    {
        if ( level.selectedmove_up > 0 )
        {
            level.selectedmove_up = 0;
        }
        
        level.selectedmove_up -= rate;
    }
    else
    {
        level.selectedmove_up = 0;
    }
    
    vector = ( 0, 0, 0 );
    vector += forward * level.selectedmove_forward;
    vector += right * level.selectedmove_right;
    vector += up * level.selectedmove_up;
    return vector;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x4fa1
// Size: 0x207
function set_anglemod_move_vector()
{
    rate = level._createfx.rate;
    snap = level._createfx.snap2anglesnaps[ level._createfx.snap2angle ];
    
    if ( snap != 0 )
    {
        rate = 0;
    }
    
    if ( buttondown( "kp_uparrow", "DPAD_UP" ) )
    {
        if ( level.selectedrotate_pitch < 0 )
        {
            level.selectedrotate_pitch = 0;
        }
        
        level.selectedrotate_pitch = level.selectedrotate_pitch + snap + rate;
    }
    else if ( buttondown( "kp_downarrow", "DPAD_DOWN" ) )
    {
        if ( level.selectedrotate_pitch > 0 )
        {
            level.selectedrotate_pitch = 0;
        }
        
        level.selectedrotate_pitch = level.selectedrotate_pitch - snap - rate;
    }
    else
    {
        level.selectedrotate_pitch = 0;
    }
    
    if ( buttondown( "kp_leftarrow", "DPAD_LEFT" ) )
    {
        if ( level.selectedrotate_yaw < 0 )
        {
            level.selectedrotate_yaw = 0;
        }
        
        level.selectedrotate_yaw = level.selectedrotate_yaw + snap + rate;
    }
    else if ( buttondown( "kp_rightarrow", "DPAD_RIGHT" ) )
    {
        if ( level.selectedrotate_yaw > 0 )
        {
            level.selectedrotate_yaw = 0;
        }
        
        level.selectedrotate_yaw = level.selectedrotate_yaw - snap - rate;
    }
    else
    {
        level.selectedrotate_yaw = 0;
    }
    
    if ( buttondown( "BUTTON_Y" ) )
    {
        if ( level.selectedrotate_roll < 0 )
        {
            level.selectedrotate_roll = 0;
        }
        
        level.selectedrotate_roll = level.selectedrotate_roll + snap + rate;
        return;
    }
    
    if ( buttondown( "BUTTON_B" ) )
    {
        if ( level.selectedrotate_roll > 0 )
        {
            level.selectedrotate_roll = 0;
        }
        
        level.selectedrotate_roll = level.selectedrotate_roll - snap - rate;
        return;
    }
    
    level.selectedrotate_roll = 0;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x51b0
// Size: 0x97
function update_selected_entities()
{
    var_dfbf17dfa0d31efe = 0;
    
    foreach ( ent in level._createfx.selected_fx_ents )
    {
        if ( ent.v[ "type" ] == "reactive_fx" )
        {
            var_dfbf17dfa0d31efe = 1;
        }
        
        ent [[ level.func_updatefx ]]();
    }
    
    if ( var_dfbf17dfa0d31efe )
    {
        refresh_reactive_fx_ents();
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x524f
// Size: 0x25
function stop_fx_looper()
{
    if ( isdefined( self.looper ) )
    {
        self.looper delete();
    }
    
    stop_loopsound();
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x527c
// Size: 0xa
function stop_loopsound()
{
    self notify( "stop_loop" );
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x528e
// Size: 0x8f
function func_get_level_fx()
{
    assertex( isdefined( level._effect ), "No effect aliases defined!" );
    
    if ( !isdefined( level._effect_keys ) )
    {
        keys = getarraykeys( level._effect );
    }
    else
    {
        keys = getarraykeys( level._effect );
        
        if ( keys.size == level._effect_keys.size )
        {
            return level._effect_keys;
        }
    }
    
    println( "<dev string:x120>" );
    keys = alphabetize( keys );
    level._effect_keys = keys;
    return keys;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x5326
// Size: 0x7f
function restart_fx_looper()
{
    stop_fx_looper();
    set_forward_and_up_vectors();
    
    switch ( self.v[ "type" ] )
    {
        case #"hash_16b43f355b98c009":
            create_triggerfx();
            break;
        case #"hash_1ac9f75b98e637fd":
            create_looper();
            break;
        case #"hash_fbc4edc91b6c146a":
            create_loopsound();
            break;
        case #"hash_c9ec51ce0335258e":
            create_interval_sound();
            break;
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x53ad
// Size: 0x88
function refresh_reactive_fx_ents()
{
    level._fx.reactive_fx_ents = undefined;
    
    foreach ( ent in level.createfxent )
    {
        if ( ent.v[ "type" ] == "reactive_fx" )
        {
            ent set_forward_and_up_vectors();
            ent add_reactive_fx();
        }
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x543d
// Size: 0x28d
function process_fx_rotater()
{
    if ( level.fx_rotating )
    {
        return;
    }
    
    set_anglemod_move_vector();
    
    if ( !rotation_is_occuring() )
    {
        return;
    }
    
    level.fx_rotating = 1;
    
    if ( level._createfx.selected_fx_ents.size > 1 )
    {
        center = get_center_of_array( level._createfx.selected_fx_ents );
        org = spawn( "script_origin", center );
        org.v[ "angles" ] = level._createfx.selected_fx_ents[ 0 ].v[ "angles" ];
        org.v[ "origin" ] = center;
        rotater = [];
        
        for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
        {
            rotater[ i ] = spawn( "script_origin", level._createfx.selected_fx_ents[ i ].v[ "origin" ] );
            rotater[ i ].angles = level._createfx.selected_fx_ents[ i ].v[ "angles" ];
            rotater[ i ] linkto( org );
        }
        
        rotate_over_time( org, rotater );
        org delete();
        
        for ( i = 0; i < rotater.size ; i++ )
        {
            rotater[ i ] delete();
        }
    }
    else if ( level._createfx.selected_fx_ents.size == 1 )
    {
        ent = level._createfx.selected_fx_ents[ 0 ];
        rotater = spawn( "script_origin", ( 0, 0, 0 ) );
        rotater.angles = ent.v[ "angles" ];
        
        if ( level.selectedrotate_pitch != 0 )
        {
            rotater addpitch( level.selectedrotate_pitch );
        }
        else if ( level.selectedrotate_yaw != 0 )
        {
            rotater addyaw( level.selectedrotate_yaw );
        }
        else
        {
            rotater addroll( level.selectedrotate_roll );
        }
        
        ent.v[ "angles" ] = rotater.angles;
        rotater delete();
        waitframe();
    }
    
    level.fx_rotating = 0;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x56d2
// Size: 0xdb
function spawn_grenade()
{
    playfx( level._createfx.grenade.fx, level.createfxcursor[ "position" ] );
    level._createfx.grenade playsound( level._createfx.grenade.sound );
    radiusdamage( level.createfxcursor[ "position" ], level._createfx.grenade.radius, 50, 5, undefined, "MOD_EXPLOSIVE" );
    level notify( "code_damageradius", undefined, level._createfx.grenade.radius, level.createfxcursor[ "position" ] );
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x57b5
// Size: 0x14d
function show_help()
{
    clear_fx_hudelements();
    set_fx_hudelement( "Help:" );
    set_fx_hudelement( "Insert          Insert entity" );
    set_fx_hudelement( "L               Drop selected entities to the ground" );
    set_fx_hudelement( "A               Add option to the selected entities" );
    set_fx_hudelement( "P               Reset the rotation of the selected entities" );
    set_fx_hudelement( "V               Copy the angles from the most recently selected fx onto all selected fx." );
    set_fx_hudelement( "Delete          Kill the selected entities" );
    set_fx_hudelement( "ESCAPE          Cancel out of option-modify-mode, must have console open" );
    set_fx_hudelement( "Ctrl-C          Copy" );
    set_fx_hudelement( "Ctrl-V          Paste" );
    set_fx_hudelement( "F2              Toggle createfx dot and text drawing" );
    set_fx_hudelement( "F5              SAVES your work" );
    set_fx_hudelement( "Dpad            Move selected entitise on X/Y or rotate pitch/yaw" );
    set_fx_hudelement( "A button        Toggle the selection of the current entity" );
    set_fx_hudelement( "X button        Toggle entity rotation mode" );
    set_fx_hudelement( "Y button        Move selected entites up or rotate roll" );
    set_fx_hudelement( "B button        Move selected entites down or rotate roll" );
    set_fx_hudelement( "R Shoulder      Move selected entities to the cursor" );
    set_fx_hudelement( "L Shoulder      Hold to select multiple entites" );
    set_fx_hudelement( "L JoyClick      Copy" );
    set_fx_hudelement( "R JoyClick      Paste" );
    set_fx_hudelement( "N               UFO" );
    set_fx_hudelement( "T               Toggle Timescale FAST" );
    set_fx_hudelement( "Y               Toggle Timescale SLOW" );
    set_fx_hudelement( "[               Toggle FX Visibility" );
    set_fx_hudelement( "]               Toggle ShowTris" );
    set_fx_hudelement( "F11             Toggle FX Profile" );
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x590a
// Size: 0x160
function generate_fx_log( autosave )
{
    /#
        check_createfx_limit();
        flag_waitopen( "<dev string:x131>" );
        flag_set( "<dev string:x131>" );
        autosave = isdefined( autosave );
        tab = "<dev string:x141>";
        var_331d6624ff42ad58 = "<dev string:x20>";
        
        if ( getdvarint( @"hash_85b139dc623fa880" ) )
        {
            var_331d6624ff42ad58 = "<dev string:x143>";
        }
        
        createfx_filter_types();
        createfx_adjust_array();
        level._createfx.defaults = [];
        level._createfx.defaults[ "<dev string:x156>" ] = getexploderdelaydefault();
        level._createfx.defaults[ "<dev string:x165>" ] = getoneshoteffectdelaydefault();
        level._createfx.defaults[ "<dev string:x175>" ] = getintervalsounddelaymindefault();
        level._createfx.defaults[ "<dev string:x190>" ] = getintervalsounddelaymaxdefault();
        type = "<dev string:x1ab>";
        array = get_createfx_array( type );
        write_log( array, type, autosave, var_331d6624ff42ad58 );
        type = "<dev string:x1ae>";
        array = get_createfx_array( type );
        write_log( array, type, autosave, var_331d6624ff42ad58 );
        flag_clear( "<dev string:x131>" );
    #/
}

/#

    // Namespace createfx / scripts\common\createfx
    // Params 4
    // Checksum 0x0, Offset: 0x5a72
    // Size: 0x421, Type: dev
    function write_log( array, type, autosave, var_331d6624ff42ad58 )
    {
        tab = "<dev string:x141>";
        cfxprintlnstart();
        cfxprintln( "<dev string:x1b4>" );
        cfxprintln( "<dev string:x1da>" );
        cfxprintln( "<dev string:x1fb>" );
        cfxprintln( "<dev string:x21c>" );
        cfxprintln( "<dev string:x20>" );
        cfxprintln( "<dev string:x23f>" );
        cfxprintln( "<dev string:x246>" );
        cfxprintln( tab + "<dev string:x248>" + type + "<dev string:x255>" + array.size );
        
        foreach ( e in array )
        {
            if ( level.createfx_loopcounter > 16 )
            {
                level.createfx_loopcounter = 0;
                wait 0.1;
            }
            
            level.createfx_loopcounter++;
            assertex( isdefined( e.v[ "<dev string:x8a>" ] ), "<dev string:x268>" + e.v[ "<dev string:x2b>" ] + "<dev string:x27a>" );
            
            if ( getdvarint( @"hash_85b139dc623fa880" ) )
            {
                if ( !isdefined( e.model ) )
                {
                    continue;
                }
            }
            else if ( isdefined( e.model ) )
            {
                continue;
            }
            
            if ( e.v[ "<dev string:x8a>" ] == "<dev string:x287>" )
            {
                cfxprintln( tab + "<dev string:x291>" + e.v[ "<dev string:x4b>" ] + "<dev string:x2ae>" );
            }
            
            if ( e.v[ "<dev string:x8a>" ] == "<dev string:x2b3>" )
            {
                cfxprintln( tab + "<dev string:x2ba>" + e.v[ "<dev string:x4b>" ] + "<dev string:x2ae>" );
            }
            
            if ( e.v[ "<dev string:x8a>" ] == "<dev string:x2d4>" )
            {
                if ( isdefined( e.v[ "<dev string:x2d4>" ] ) && !level.mp_createfx )
                {
                    cfxprintln( tab + "<dev string:x2dd>" + e.v[ "<dev string:x4b>" ] + "<dev string:x2f7>" + e.v[ "<dev string:x2d4>" ] + "<dev string:x2ae>" );
                }
                else
                {
                    cfxprintln( tab + "<dev string:x2fc>" + e.v[ "<dev string:x4b>" ] + "<dev string:x2ae>" );
                }
            }
            
            if ( e.v[ "<dev string:x8a>" ] == "<dev string:x314>" )
            {
                cfxprintln( tab + "<dev string:x31c>" );
            }
            
            if ( e.v[ "<dev string:x8a>" ] == "<dev string:x335>" )
            {
                cfxprintln( tab + "<dev string:x346>" );
            }
            
            if ( e.v[ "<dev string:x8a>" ] == "<dev string:x363>" )
            {
                if ( type == "<dev string:x1ab>" && e.v[ "<dev string:x4b>" ] != "<dev string:x50>" && !level.mp_createfx )
                {
                    cfxprintln( tab + "<dev string:x36f>" + e.v[ "<dev string:x4b>" ] + "<dev string:x2ae>" );
                }
                else if ( type == "<dev string:x1ae>" && e.v[ "<dev string:x4b>" ] == "<dev string:x50>" )
                {
                    cfxprintln( tab + "<dev string:x38a>" );
                }
                else
                {
                    continue;
                }
            }
            
            cfxprintln( tab + "<dev string:x3a5>" + e.v[ "<dev string:x2b>" ] + "<dev string:x3c1>" + e.v[ "<dev string:x34>" ] + "<dev string:x3c4>" );
            print_fx_options( e, tab, autosave );
            cfxprintln( "<dev string:x20>" );
        }
        
        cfxprintln( "<dev string:x3c8>" );
        cfxprintln( "<dev string:x3ca>" );
        cfxprintlnend( autosave, var_331d6624ff42ad58, type );
    }

#/

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x5e9b
// Size: 0x12c
function createfx_adjust_array()
{
    limit = 0.1;
    
    foreach ( ent in level.createfxent )
    {
        origin = [];
        angles = [];
        
        for ( i = 0; i < 3 ; i++ )
        {
            origin[ i ] = ent.v[ "origin" ][ i ];
            angles[ i ] = ent.v[ "angles" ][ i ];
            
            if ( origin[ i ] < limit && origin[ i ] > limit * -1 )
            {
                origin[ i ] = 0;
            }
            
            if ( angles[ i ] < limit && angles[ i ] > limit * -1 )
            {
                angles[ i ] = 0;
            }
        }
        
        ent.v[ "origin" ] = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] );
        ent.v[ "angles" ] = ( angles[ 0 ], angles[ 1 ], angles[ 2 ] );
    }
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x5fcf
// Size: 0x18d
function get_createfx_array( type )
{
    types = get_createfx_types( type );
    array = [];
    
    foreach ( index, _ in types )
    {
        array[ index ] = [];
    }
    
    foreach ( ent in level.createfxent )
    {
        found_type = 0;
        
        foreach ( index, type in types )
        {
            if ( ent.v[ "type" ] != type )
            {
                continue;
            }
            
            found_type = 1;
            array[ index ][ array[ index ].size ] = ent;
            break;
        }
    }
    
    new_array = [];
    
    for ( i = 0; i < types.size ; i++ )
    {
        foreach ( ent in array[ i ] )
        {
            new_array[ new_array.size ] = ent;
        }
    }
    
    return new_array;
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x6165
// Size: 0x69
function get_createfx_types( type )
{
    types = [];
    
    if ( type == "fx" )
    {
        types[ 0 ] = "oneshotfx";
        types[ 1 ] = "loopfx";
        types[ 2 ] = "exploder";
        types[ 3 ] = "reactive_fx";
    }
    else
    {
        types[ 0 ] = "soundfx";
        types[ 1 ] = "soundfx_interval";
        types[ 2 ] = "reactive_fx";
    }
    
    return types;
}

// Namespace createfx / scripts\common\createfx
// Params 2
// Checksum 0x0, Offset: 0x61d7
// Size: 0x64, Type: bool
function check_reactive_fx_type( ent, type )
{
    if ( ent.v[ "fxid" ] != "No FX" && type == "fx" )
    {
        return true;
    }
    
    if ( ent.v[ "fxid" ] == "No FX" && type == "sound" )
    {
        return true;
    }
    
    return false;
}

// Namespace createfx / scripts\common\createfx
// Params 2
// Checksum 0x0, Offset: 0x6244
// Size: 0xad, Type: bool
function is_createfx_type( ent, type )
{
    types = get_createfx_types( type );
    
    if ( ent.v[ "type" ] == "reactive_fx" )
    {
        if ( check_reactive_fx_type( ent, type ) )
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    foreach ( t in types )
    {
        if ( ent.v[ "type" ] == t )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x62fa
// Size: 0x1fe
function createfx_filter_types()
{
    types = [];
    types[ types.size ] = "soundfx";
    types[ types.size ] = "oneshotfx";
    types[ types.size ] = "exploder";
    types[ types.size ] = "soundfx_interval";
    types[ types.size ] = "reactive_fx";
    
    if ( !level.mp_createfx )
    {
        types[ types.size ] = "loopfx";
    }
    
    array = [];
    
    foreach ( index, _ in types )
    {
        array[ index ] = [];
    }
    
    foreach ( ent in level.createfxent )
    {
        found_type = 0;
        
        foreach ( index, type in types )
        {
            if ( ent.v[ "type" ] != type )
            {
                continue;
            }
            
            found_type = 1;
            array[ index ][ array[ index ].size ] = ent;
            break;
        }
        
        assertex( found_type, "Unsupported CreateFX Type: " + ent.v[ "type" ] );
    }
    
    new_array = [];
    
    for ( i = 0; i < types.size ; i++ )
    {
        foreach ( ent in array[ i ] )
        {
            new_array[ new_array.size ] = ent;
        }
    }
    
    level.createfxent = new_array;
}

/#

    // Namespace createfx / scripts\common\createfx
    // Params 0
    // Checksum 0x0, Offset: 0x6500
    // Size: 0xc, Type: dev
    function cfxprintlnstart()
    {
        fileprint_launcher_start_file();
    }

    // Namespace createfx / scripts\common\createfx
    // Params 1
    // Checksum 0x0, Offset: 0x6514
    // Size: 0x16, Type: dev
    function cfxprintln( string )
    {
        fileprint_launcher( string );
    }

    // Namespace createfx / scripts\common\createfx
    // Params 3
    // Checksum 0x0, Offset: 0x6532
    // Size: 0x100, Type: dev
    function cfxprintlnend( autosave, var_331d6624ff42ad58, type )
    {
        bp4add = 1;
        
        if ( var_331d6624ff42ad58 != "<dev string:x20>" || autosave )
        {
            bp4add = 0;
        }
        
        if ( utility::issp() )
        {
            scriptname = level.script + var_331d6624ff42ad58 + "<dev string:x3cc>" + type + "<dev string:x3ce>";
            
            if ( autosave )
            {
                scriptname = "<dev string:x3d3>" + "<dev string:x3cc>" + type + "<dev string:x3ce>";
            }
        }
        else
        {
            scriptname = level.script + var_331d6624ff42ad58 + "<dev string:x3cc>" + type + "<dev string:x3ce>";
            
            if ( autosave )
            {
                scriptname = "<dev string:x3da>";
            }
        }
        
        raw_or_devraw_subdir = get_raw_or_devraw_subdir();
        gamemode_subdir = get_gamemode_subdir();
        fileprint_launcher_end_file( "<dev string:x3e5>" + raw_or_devraw_subdir + "<dev string:x3ed>" + gamemode_subdir + "<dev string:x3f7>" + level.script + "<dev string:x3fe>" + scriptname, bp4add );
    }

#/

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x663a
// Size: 0x2b
function get_raw_or_devraw_subdir()
{
    if ( isdefined( level.createfx_devraw_map ) && level.createfx_devraw_map )
    {
        return "devraw";
    }
    
    return "raw";
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x666d
// Size: 0x2c
function get_gamemode_subdir()
{
    if ( utility::iscp() )
    {
        return "cp";
    }
    
    if ( utility::issp() )
    {
        return "sp";
    }
    
    return "mp";
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x66a1
// Size: 0x30e
function process_button_held_and_clicked()
{
    add_button( "mouse1" );
    add_button( "BUTTON_RSHLDR" );
    add_button( "BUTTON_LSHLDR" );
    add_button( "BUTTON_RSTICK" );
    add_button( "BUTTON_LSTICK" );
    add_button( "BUTTON_A" );
    add_button( "BUTTON_B" );
    add_button( "BUTTON_X" );
    add_button( "BUTTON_Y" );
    add_button( "DPAD_UP" );
    add_button( "DPAD_LEFT" );
    add_button( "DPAD_RIGHT" );
    add_button( "DPAD_DOWN" );
    add_kb_button( "lshift" );
    add_kb_button( "rshift" );
    add_kb_button( "lctrl" );
    add_kb_button( "rctrl" );
    add_kb_button( "escape" );
    add_kb_button( "F1" );
    add_kb_button( "F5" );
    add_kb_button( "F4" );
    add_kb_button( "F2" );
    add_kb_button( "a" );
    add_kb_button( "e" );
    add_kb_button( "g" );
    add_kb_button( "c" );
    add_kb_button( "h" );
    add_kb_button( "i" );
    add_kb_button( "k" );
    add_kb_button( "l" );
    add_kb_button( "m" );
    add_kb_button( "p" );
    add_kb_button( "r" );
    add_kb_button( "s" );
    add_kb_button( "u" );
    add_kb_button( "v" );
    add_kb_button( "x" );
    add_kb_button( "z" );
    add_kb_button( "del" );
    add_kb_button( "end" );
    add_kb_button( "tab" );
    add_kb_button( "ins" );
    add_kb_button( "add" );
    add_kb_button( "space" );
    add_kb_button( "enter" );
    add_kb_button( "1" );
    add_kb_button( "2" );
    add_kb_button( "3" );
    add_kb_button( "4" );
    add_kb_button( "5" );
    add_kb_button( "6" );
    add_kb_button( "7" );
    add_kb_button( "8" );
    add_kb_button( "9" );
    add_kb_button( "0" );
    add_kb_button( "-" );
    add_kb_button( "=" );
    add_kb_button( "," );
    add_kb_button( "." );
    add_kb_button( "[" );
    add_kb_button( "]" );
    add_kb_button( "leftarrow" );
    add_kb_button( "rightarrow" );
    add_kb_button( "uparrow" );
    add_kb_button( "downarrow" );
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x69b7
// Size: 0x2d
function locked( name )
{
    if ( isdefined( level._createfx.lockedlist[ name ] ) )
    {
        return 0;
    }
    
    return kb_locked( name );
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x69ed
// Size: 0x24, Type: bool
function kb_locked( name )
{
    return level.createfx_inputlocked && isdefined( level.button_is_kb[ name ] );
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x6a1a
// Size: 0x73
function add_button( name )
{
    if ( locked( name ) )
    {
        return;
    }
    
    if ( !isdefined( level.buttonisheld[ name ] ) )
    {
        if ( level.player buttonpressed( name ) )
        {
            level.buttonisheld[ name ] = 1;
            level.buttonclick[ name ] = 1;
        }
        
        return;
    }
    
    if ( !level.player buttonpressed( name ) )
    {
        level.buttonisheld[ name ] = undefined;
    }
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x6a95
// Size: 0x21
function add_kb_button( name )
{
    level.button_is_kb[ name ] = 1;
    add_button( name );
}

// Namespace createfx / scripts\common\createfx
// Params 2
// Checksum 0x0, Offset: 0x6abe
// Size: 0x25, Type: bool
function buttondown( button, button2 )
{
    return buttonpressed_internal( button ) || buttonpressed_internal( button2 );
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x6aec
// Size: 0x2d
function buttonpressed_internal( button )
{
    if ( !isdefined( button ) )
    {
        return 0;
    }
    
    if ( kb_locked( button ) )
    {
        return 0;
    }
    
    return level.player buttonpressed( button );
}

// Namespace createfx / scripts\common\createfx
// Params 3
// Checksum 0x0, Offset: 0x6b22
// Size: 0x55, Type: bool
function button_is_held( name, name2, name3 )
{
    if ( isdefined( name3 ) )
    {
        if ( isdefined( level.buttonisheld[ name3 ] ) )
        {
            return true;
        }
    }
    
    if ( isdefined( name2 ) )
    {
        if ( isdefined( level.buttonisheld[ name2 ] ) )
        {
            return true;
        }
    }
    
    return isdefined( level.buttonisheld[ name ] );
}

// Namespace createfx / scripts\common\createfx
// Params 3
// Checksum 0x0, Offset: 0x6b80
// Size: 0x55, Type: bool
function button_is_clicked( name, name2, name3 )
{
    if ( isdefined( name3 ) )
    {
        if ( isdefined( level.buttonclick[ name3 ] ) )
        {
            return true;
        }
    }
    
    if ( isdefined( name2 ) )
    {
        if ( isdefined( level.buttonclick[ name2 ] ) )
        {
            return true;
        }
    }
    
    return isdefined( level.buttonclick[ name ] );
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x6bde
// Size: 0x2c0
function init_huds()
{
    level._createfx.hudelems = [];
    level._createfx.hudelem_count = 30;
    
    if ( level.mp_createfx )
    {
        level._createfx.hudelem_count = 16;
    }
    
    stroffsetx = [];
    stroffsety = [];
    stroffsetx[ 0 ] = 0;
    stroffsety[ 0 ] = 0;
    stroffsetx[ 1 ] = 1;
    stroffsety[ 1 ] = 1;
    stroffsetx[ 2 ] = -2;
    stroffsety[ 2 ] = 1;
    stroffsetx[ 3 ] = 1;
    stroffsety[ 3 ] = -1;
    stroffsetx[ 4 ] = -2;
    stroffsety[ 4 ] = -1;
    level.cleartextmarker = newhudelem();
    level.cleartextmarker.alpha = 0;
    level.cleartextmarker.archived = 0;
    
    /#
        level.cleartextmarker setdevtext( "<dev string:x404>" );
    #/
    
    for ( i = 0; i < level._createfx.hudelem_count ; i++ )
    {
        newstrarray = [];
        
        for ( p = 0; p < 1 ; p++ )
        {
            newstr = newhudelem();
            newstr.alignx = "left";
            newstr.archived = 0;
            newstr.location = 0;
            newstr.foreground = 1;
            newstr.fontscale = 1.4;
            newstr.sort = 20 - p;
            newstr.alpha = 1;
            newstr.x = 0 + stroffsetx[ p ];
            newstr.y = 60 + stroffsety[ p ] + i * 15;
            
            if ( p > 0 )
            {
                newstr.color = ( 0, 0, 0 );
            }
            
            newstrarray[ newstrarray.size ] = newstr;
        }
        
        level._createfx.hudelems[ i ] = newstrarray;
    }
    
    hud = newhudelem();
    hud.archived = 0;
    hud.alignx = "center";
    hud.location = 0;
    hud.foreground = 1;
    hud.fontscale = 1.4;
    hud.sort = 20;
    hud.alpha = 1;
    hud.x = 320;
    hud.y = 40;
    level.createfx_centerprint = hud;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x6ea6
// Size: 0xb2
function init_crosshair()
{
    crosshair = newhudelem();
    crosshair.archived = 0;
    crosshair.location = 0;
    crosshair.alignx = "center";
    crosshair.aligny = "middle";
    crosshair.foreground = 1;
    crosshair.fontscale = 1;
    crosshair.sort = 20;
    crosshair.alpha = 1;
    crosshair.x = 320;
    crosshair.y = 233;
    
    /#
        crosshair setdevtext( "<dev string:x32>" );
    #/
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x6f60
// Size: 0x83
function clear_fx_hudelements()
{
    level.cleartextmarker clearalltextafterhudelem();
    
    /#
        for ( i = 0; i < level._createfx.hudelem_count ; i++ )
        {
            for ( p = 0; p < 1 ; p++ )
            {
                level._createfx.hudelems[ i ][ p ] setdevtext( "<dev string:x20>" );
            }
        }
    #/
    
    level.fxhudelements = 0;
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x6feb
// Size: 0x7d
function set_fx_hudelement( text )
{
    /#
        for ( p = 0; p < 1 ; p++ )
        {
            level._createfx.hudelems[ level.fxhudelements ][ p ] setdevtext( text );
        }
    #/
    
    level.fxhudelements++;
    assert( level.fxhudelements <= level._createfx.hudelem_count );
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x7070
// Size: 0x8b
function init_tool_hud()
{
    if ( !isdefined( level._createfx.tool_hudelems ) )
    {
        level._createfx.tool_hudelems = [];
    }
    
    if ( !isdefined( level._createfx.tool_hud_visible ) )
    {
        level._createfx.tool_hud_visible = 1;
    }
    
    if ( !isdefined( level._createfx.tool_hud ) )
    {
        level._createfx.tool_hud = "";
    }
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x7103
// Size: 0xaf
function new_tool_hud( name )
{
    foreach ( hud in level._createfx.tool_hudelems )
    {
        if ( isdefined( hud.value_hudelem ) )
        {
            hud.value_hudelem destroy();
        }
        
        hud destroy();
        level._createfx.tool_hudelems[ idx ] = undefined;
    }
    
    level._createfx.tool_hud = name;
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x71ba
// Size: 0x20, Type: bool
function current_mode_hud( name )
{
    return level._createfx.tool_hud == name;
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x71e3
// Size: 0xe
function clear_tool_hud()
{
    new_tool_hud( "" );
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x71f9
// Size: 0x95
function new_tool_hudelem( n )
{
    hud = newhudelem();
    hud.archived = 0;
    hud.alignx = "left";
    hud.location = 0;
    hud.foreground = 1;
    hud.fontscale = 1.2;
    hud.alpha = 1;
    hud.x = 0;
    hud.y = 320 + n * 15;
    return hud;
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x7297
// Size: 0x3b
function get_tool_hudelem( name )
{
    if ( isdefined( level._createfx.tool_hudelems[ name ] ) )
    {
        return level._createfx.tool_hudelems[ name ];
    }
    
    return undefined;
}

// Namespace createfx / scripts\common\createfx
// Params 2
// Checksum 0x0, Offset: 0x72db
// Size: 0x142
function set_tool_hudelem( var, value )
{
    if ( level.mp_createfx )
    {
        return;
    }
    
    hud = get_tool_hudelem( var );
    
    if ( !isdefined( hud ) )
    {
        hud = new_tool_hudelem( level._createfx.tool_hudelems.size );
        level._createfx.tool_hudelems[ var ] = hud;
        
        /#
            hud setdevtext( var );
        #/
        
        hud.text = var;
    }
    
    if ( isdefined( value ) )
    {
        if ( isdefined( hud.value_hudelem ) )
        {
            value_hud = hud.value_hudelem;
        }
        else
        {
            value_hud = new_tool_hudelem( level._createfx.tool_hudelems.size );
            value_hud.x += 100;
            value_hud.y = hud.y;
            hud.value_hudelem = value_hud;
        }
        
        if ( isdefined( value_hud.text ) && value_hud.text == value )
        {
            return;
        }
        
        /#
            value_hud setdevtext( value );
        #/
        
        value_hud.text = value;
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x7425
// Size: 0x15f, Type: bool
function select_by_substring()
{
    substring = getdvar( @"select_by_substring" );
    
    if ( substring == "" )
    {
        return false;
    }
    
    setdvar( @"select_by_substring", "" );
    index_array = [];
    
    foreach ( ent in level.createfxent )
    {
        if ( issubstr( ent.v[ "fxid" ], substring ) )
        {
            index_array[ index_array.size ] = i;
        }
    }
    
    if ( index_array.size == 0 )
    {
        println( "<dev string:x40b>" + substring + "<dev string:x432>" );
        return false;
    }
    
    deselect_all_ents();
    select_index_array( index_array );
    
    foreach ( index in index_array )
    {
        ent = level.createfxent[ index ];
        select_entity( index, ent );
    }
    
    println( "<dev string:x434>" + substring + "<dev string:x450>" + index_array.size + "<dev string:x454>" );
    return true;
}

// Namespace createfx / scripts\common\createfx
// Params 1
// Checksum 0x0, Offset: 0x758d
// Size: 0x6b
function select_index_array( index_array )
{
    foreach ( index in index_array )
    {
        ent = level.createfxent[ index ];
        select_entity( index, ent );
    }
}

// Namespace createfx / scripts\common\createfx
// Params 0
// Checksum 0x0, Offset: 0x7600
// Size: 0x5e
function deselect_all_ents()
{
    foreach ( ent in level._createfx.selected_fx_ents )
    {
        deselect_entity( i, ent );
    }
}

