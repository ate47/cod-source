#using scripts\common\createfx;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace createfxmenu;

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x63c
// Size: 0x59f
function init_menu()
{
    level._createfx.options = [];
    addoption( "string", "fxid", "FX id", "nil", "fx" );
    addoption( "float", "delay", "Repeat rate/start delay", 0.5, "fx" );
    addoption( "string", "flag", "Flag", "nil", "exploder" );
    
    if ( !level.mp_createfx )
    {
        addoption( "string", "firefx", "2nd FX id", "nil", "exploder" );
        addoption( "float", "firefxdelay", "2nd FX id repeat rate", 0.5, "exploder" );
        addoption( "float", "firefxtimeout", "2nd FX timeout", 5, "exploder" );
        addoption( "string", "firefxsound", "2nd FX soundalias", "nil", "exploder" );
        addoption( "float", "damage", "Radius damage", 150, "exploder" );
        addoption( "float", "damage_radius", "Radius of radius damage", 250, "exploder" );
        addoption( "bool", "envonly", "Environment Pulse Only", 0, "exploder" );
        addoption( "bool", "dotraces", "Occlusion Trace", 1, "exploder" );
        addoption( "string", "earthquake", "Earthquake", "nil", "exploder" );
        addoption( "string", "ender", "Level notify for ending 2nd FX", "nil", "exploder" );
    }
    
    addoption( "float", "delay_min", "Minimimum time between repeats", 1, "soundfx_interval" );
    addoption( "float", "delay_max", "Maximum time between repeats", 2, "soundfx_interval" );
    addoption( "int", "repeat", "Number of times to repeat", 5, "exploder" );
    addoption( "string", "exploder", "Exploder", "1", "exploder" );
    addoption( "string", "soundalias", "Soundalias", "nil", "all" );
    addoption( "string", "loopsound", "Loopsound", "nil", "exploder" );
    addoption( "int", "reactive_radius", "Reactive Radius", 100, "reactive_fx", &input_reactive_radius );
    
    if ( !level.mp_createfx )
    {
        addoption( "string", "rumble", "Rumble", "nil", "exploder" );
        addoption( "int", "stopable", "Can be stopped from script", "1", "all" );
    }
    
    level.effect_list_offset = 0;
    level.effect_list_offset_max = 10;
    
    if ( level.mp_createfx )
    {
        level.effect_list_offset_max = 6;
    }
    
    level.createfxmasks = [];
    level.createfxmasks[ "all" ] = [];
    level.createfxmasks[ "all" ][ "exploder" ] = 1;
    level.createfxmasks[ "all" ][ "oneshotfx" ] = 1;
    level.createfxmasks[ "all" ][ "loopfx" ] = 1;
    level.createfxmasks[ "all" ][ "soundfx" ] = 1;
    level.createfxmasks[ "all" ][ "soundfx_interval" ] = 1;
    level.createfxmasks[ "all" ][ "reactive_fx" ] = 1;
    level.createfxmasks[ "fx" ] = [];
    level.createfxmasks[ "fx" ][ "exploder" ] = 1;
    level.createfxmasks[ "fx" ][ "oneshotfx" ] = 1;
    level.createfxmasks[ "fx" ][ "loopfx" ] = 1;
    
    if ( !level.mp_createfx )
    {
        level.createfxmasks[ "fx" ][ "reactive_fx" ] = 1;
    }
    
    level.createfxmasks[ "exploder" ] = [];
    level.createfxmasks[ "exploder" ][ "exploder" ] = 1;
    level.createfxmasks[ "loopfx" ] = [];
    level.createfxmasks[ "loopfx" ][ "loopfx" ] = 1;
    level.createfxmasks[ "oneshotfx" ] = [];
    level.createfxmasks[ "oneshotfx" ][ "oneshotfx" ] = 1;
    level.createfxmasks[ "soundfx" ] = [];
    level.createfxmasks[ "soundfx" ][ "soundalias" ] = 1;
    level.createfxmasks[ "soundfx_interval" ] = [];
    level.createfxmasks[ "soundfx_interval" ][ "soundfx_interval" ] = 1;
    level.createfxmasks[ "reactive_fx" ] = [];
    level.createfxmasks[ "reactive_fx" ][ "reactive_fx" ] = 1;
    menus = [];
    menus[ "creation" ] = &menu_create_select;
    menus[ "create_oneshot" ] = &menu_create;
    menus[ "create_loopfx" ] = &menu_create;
    menus[ "change_fxid" ] = &menu_create;
    menus[ "none" ] = &menu_none;
    menus[ "add_options" ] = &menu_add_options;
    menus[ "select_by_name" ] = &menu_select_by_name;
    level._createfx.menus = menus;
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 1
// Checksum 0x0, Offset: 0xbe3
// Size: 0x16, Type: bool
function menu( name )
{
    return level.create_fx_menu == name;
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 1
// Checksum 0x0, Offset: 0xc02
// Size: 0x15
function setmenu( name )
{
    level.create_fx_menu = name;
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0xc1f
// Size: 0x5e
function create_fx_menu()
{
    if ( button_is_clicked( "escape", "x" ) )
    {
        exit_menu();
        return;
    }
    
    if ( isdefined( level._createfx.menus[ level.create_fx_menu ] ) )
    {
        [[ level._createfx.menus[ level.create_fx_menu ] ]]();
    }
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0xc85
// Size: 0x144
function menu_create_select()
{
    if ( !isdefined( level._createfx.menu_create_select ) )
    {
        level._createfx.menu_create_select = [];
        btnlist = [];
        btnlist[ "1" ] = &buttonpress_create_oneshot;
        
        if ( !level.mp_createfx )
        {
            btnlist[ "2" ] = &buttonpress_create_loopfx;
            btnlist[ "3" ] = &buttonpress_create_loopsound;
            btnlist[ "4" ] = &buttonpress_create_exploder;
            btnlist[ "5" ] = &buttonpress_create_interval_sound;
            btnlist[ "6" ] = &buttonpress_create_reactiveent;
        }
        else
        {
            btnlist[ "2" ] = &buttonpress_create_loopsound;
            btnlist[ "3" ] = &buttonpress_create_exploder;
            btnlist[ "4" ] = &buttonpress_create_interval_sound;
            btnlist[ "5" ] = &buttonpress_create_reactiveent;
        }
        
        level._createfx.menu_create_select = btnlist;
    }
    
    foreach ( index, func in level._createfx.menu_create_select )
    {
        if ( button_is_clicked( index ) )
        {
            [[ func ]]();
            return;
        }
    }
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0xdd1
// Size: 0x15
function buttonpress_create_oneshot()
{
    setmenu( "create_oneshot" );
    draw_effects_list();
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0xdee
// Size: 0x15
function buttonpress_create_loopfx()
{
    setmenu( "create_loopfx" );
    draw_effects_list();
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0xe0b
// Size: 0x28
function buttonpress_create_loopsound()
{
    setmenu( "create_loopsound" );
    ent = createloopsound();
    finish_creating_entity( ent );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0xe3b
// Size: 0x28
function buttonpress_create_exploder()
{
    setmenu( "create_exploder" );
    ent = createnewexploder();
    finish_creating_entity( ent );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0xe6b
// Size: 0x28
function buttonpress_create_interval_sound()
{
    setmenu( "create_interval_sound" );
    ent = createintervalsound();
    finish_creating_entity( ent );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0xe9b
// Size: 0x1c
function buttonpress_create_reactiveent()
{
    ent = createreactiveent();
    finish_creating_entity( ent );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0xebf
// Size: 0x3a
function menu_create()
{
    if ( next_button() )
    {
        increment_list_offset();
        draw_effects_list();
    }
    else if ( previous_button() )
    {
        decrement_list_offset();
        draw_effects_list();
    }
    
    menu_fx_creation();
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0xf01
// Size: 0x96
function menu_none()
{
    if ( button_is_clicked( "m" ) )
    {
        increment_list_offset();
    }
    
    menu_change_selected_fx();
    
    if ( entities_are_selected() )
    {
        last_selected_ent = get_last_selected_ent();
        
        if ( !isdefined( level.last_displayed_ent ) || last_selected_ent != level.last_displayed_ent )
        {
            display_fx_info( last_selected_ent );
            level.last_displayed_ent = last_selected_ent;
        }
        
        if ( button_is_clicked( "a" ) )
        {
            clear_settable_fx();
            setmenu( "add_options" );
        }
        
        return;
    }
    
    level.last_displayed_ent = undefined;
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0xf9f
// Size: 0x3c
function menu_add_options()
{
    if ( !entities_are_selected() )
    {
        clear_fx_hudelements();
        setmenu( "none" );
        return;
    }
    
    display_fx_add_options( get_last_selected_ent() );
    
    if ( next_button() )
    {
        increment_list_offset();
    }
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0xfe3
// Size: 0x44
function menu_select_by_name()
{
    if ( next_button() )
    {
        increment_list_offset();
        draw_effects_list( "Select by name" );
    }
    else if ( previous_button() )
    {
        decrement_list_offset();
        draw_effects_list( "Select by name" );
    }
    
    select_by_name();
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x102f
// Size: 0xd
function next_button()
{
    return button_is_clicked( "rightarrow" );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x1045
// Size: 0xd
function previous_button()
{
    return button_is_clicked( "leftarrow" );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x105b
// Size: 0x23
function exit_menu()
{
    clear_fx_hudelements();
    clear_entity_selection();
    update_selected_entities();
    setmenu( "none" );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x1086
// Size: 0x114
function menu_fx_creation()
{
    count = 0;
    picked_fx = undefined;
    keys = func_get_level_fx();
    
    for ( i = level.effect_list_offset; i < keys.size ; i++ )
    {
        count += 1;
        var_7356ab609cfad76c = count;
        
        if ( var_7356ab609cfad76c == 10 )
        {
            var_7356ab609cfad76c = 0;
        }
        
        if ( button_is_clicked( var_7356ab609cfad76c + "" ) )
        {
            picked_fx = keys[ i ];
            break;
        }
        
        if ( count > level.effect_list_offset_max )
        {
            break;
        }
    }
    
    if ( !isdefined( picked_fx ) )
    {
        return;
    }
    
    if ( menu( "change_fxid" ) )
    {
        apply_option_to_selected_fx( get_option( "fxid" ), picked_fx );
        level.effect_list_offset = 0;
        clear_fx_hudelements();
        setmenu( "none" );
        return;
    }
    
    ent = undefined;
    
    if ( menu( "create_loopfx" ) )
    {
        ent = createloopeffect( picked_fx );
    }
    
    if ( menu( "create_oneshot" ) )
    {
        ent = createoneshoteffect( picked_fx );
    }
    
    finish_creating_entity( ent );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 1
// Checksum 0x0, Offset: 0x11a2
// Size: 0xfe
function finish_creating_entity( ent )
{
    assert( isdefined( ent ) );
    ent.v[ "angles" ] = vectortoangles( ent.v[ "origin" ] + ( 0, 0, 100 ) - ent.v[ "origin" ] );
    
    if ( isdefined( level._effect ) && isdefined( level._effect[ ent.v[ "fxid" ] ] ) && isvfxfile( level._effect[ ent.v[ "fxid" ] ] ) )
    {
        ent.v[ "angles" ] = ( 0, 0, 0 );
    }
    
    ent post_entity_creation_function();
    clear_entity_selection();
    select_last_entity();
    move_selection_to_cursor();
    update_selected_entities();
    setmenu( "none" );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x12a8
// Size: 0x18, Type: bool
function entities_are_selected()
{
    return level._createfx.selected_fx_ents.size > 0;
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x12c9
// Size: 0x10b
function menu_change_selected_fx()
{
    if ( !level._createfx.selected_fx_ents.size )
    {
        return;
    }
    
    count = 0;
    drawncount = 0;
    ent = get_last_selected_ent();
    
    for ( i = 0; i < level._createfx.options.size ; i++ )
    {
        option = level._createfx.options[ i ];
        
        if ( !isdefined( ent.v[ option[ "name" ] ] ) )
        {
            continue;
        }
        
        count++;
        
        if ( count < level.effect_list_offset )
        {
            continue;
        }
        
        drawncount++;
        var_7356ab609cfad76c = drawncount;
        
        if ( var_7356ab609cfad76c == 10 )
        {
            var_7356ab609cfad76c = 0;
        }
        
        if ( button_is_clicked( var_7356ab609cfad76c + "" ) )
        {
            prepare_option_for_change( option, drawncount );
            break;
        }
        
        if ( drawncount > level.effect_list_offset_max )
        {
            more = 1;
            break;
        }
    }
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 2
// Checksum 0x0, Offset: 0x13dc
// Size: 0xcd
function prepare_option_for_change( option, drawncount )
{
    if ( option[ "name" ] == "fxid" )
    {
        setmenu( "change_fxid" );
        draw_effects_list();
        return;
    }
    
    level.createfx_inputlocked = 1;
    level._createfx.hudelems[ drawncount + 3 ][ 0 ].color = ( 1, 1, 0 );
    
    if ( isdefined( option[ "input_func" ] ) )
    {
        thread [[ option[ "input_func" ] ]]( drawncount + 3 );
    }
    else
    {
        createfx_centerprint( "To change " + option[ "description" ] + " on selected entities, type /fx newvalue" );
    }
    
    set_option_index( option[ "name" ] );
    setdvar( @"fx", "nil" );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x14b1
// Size: 0xdf
function menu_fx_option_set()
{
    if ( getdvar( @"fx" ) == "nil" )
    {
        return;
    }
    
    option = get_selected_option();
    setting = undefined;
    
    if ( option[ "type" ] == "string" )
    {
        setting = getdvar( @"fx" );
    }
    
    if ( option[ "type" ] == "int" )
    {
        setting = getdvarint( @"fx" );
    }
    
    if ( option[ "type" ] == "float" )
    {
        setting = getdvarfloat( @"fx" );
    }
    
    if ( option[ "type" ] == "bool" )
    {
        setting = getdvar( @"fx" );
        
        if ( setting == "0" || setting == "false" )
        {
            setting = 0;
        }
        else
        {
            setting = 1;
        }
    }
    
    apply_option_to_selected_fx( option, setting );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 2
// Checksum 0x0, Offset: 0x1598
// Size: 0xac
function apply_option_to_selected_fx( option, setting )
{
    for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
    {
        ent = level._createfx.selected_fx_ents[ i ];
        
        if ( mask( option[ "mask" ], ent.v[ "type" ] ) )
        {
            ent.v[ option[ "name" ] ] = setting;
        }
    }
    
    level.last_displayed_ent = undefined;
    update_selected_entities();
    clear_settable_fx();
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 1
// Checksum 0x0, Offset: 0x164c
// Size: 0x70
function set_option_index( name )
{
    for ( i = 0; i < level._createfx.options.size ; i++ )
    {
        if ( level._createfx.options[ i ][ "name" ] != name )
        {
            continue;
        }
        
        level._createfx.selected_fx_option_index = i;
        return;
    }
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x16c4
// Size: 0x29
function get_selected_option()
{
    return level._createfx.options[ level._createfx.selected_fx_option_index ];
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 2
// Checksum 0x0, Offset: 0x16f6
// Size: 0x21, Type: bool
function mask( type, name )
{
    return isdefined( level.createfxmasks[ type ][ name ] );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 6
// Checksum 0x0, Offset: 0x1720
// Size: 0xa6
function addoption( type, name, description, defaultsetting, mask, input_func )
{
    option = [];
    option[ "type" ] = type;
    option[ "name" ] = name;
    option[ "description" ] = description;
    option[ "default" ] = defaultsetting;
    option[ "mask" ] = mask;
    
    if ( isdefined( input_func ) )
    {
        option[ "input_func" ] = input_func;
    }
    
    level._createfx.options[ level._createfx.options.size ] = option;
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 1
// Checksum 0x0, Offset: 0x17ce
// Size: 0x6d
function get_option( name )
{
    for ( i = 0; i < level._createfx.options.size ; i++ )
    {
        if ( level._createfx.options[ i ][ "name" ] == name )
        {
            return level._createfx.options[ i ];
        }
    }
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 1
// Checksum 0x0, Offset: 0x1843
// Size: 0x186
function input_reactive_radius( menu_index )
{
    /#
        level._createfx.hudelems[ menu_index ][ 0 ] setdevtext( "<dev string:x1c>" );
    #/
    
    while ( true )
    {
        waitframe();
        
        if ( level.player buttonpressed( "escape" ) || level.player buttonpressed( "x" ) )
        {
            break;
        }
        
        val = 0;
        
        if ( level.player buttonpressed( "-" ) )
        {
            val = -10;
        }
        else if ( level.player buttonpressed( "=" ) )
        {
            val = 10;
        }
        
        if ( val != 0 )
        {
            foreach ( ent in level._createfx.selected_fx_ents )
            {
                if ( isdefined( ent.v[ "reactive_radius" ] ) )
                {
                    ent.v[ "reactive_radius" ] = ent.v[ "reactive_radius" ] + val;
                    ent.v[ "reactive_radius" ] = clamp( ent.v[ "reactive_radius" ], 10, 1000 );
                }
            }
        }
    }
    
    level.last_displayed_ent = undefined;
    update_selected_entities();
    clear_settable_fx();
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 1
// Checksum 0x0, Offset: 0x19d1
// Size: 0x225
function display_fx_add_options( ent )
{
    assert( menu( "<dev string:x3e>" ) );
    assert( entities_are_selected() );
    clear_fx_hudelements();
    set_fx_hudelement( "Name: " + ent.v[ "fxid" ] );
    set_fx_hudelement( "Type: " + ent.v[ "type" ] );
    set_fx_hudelement( "Origin: " + ent.v[ "origin" ] );
    set_fx_hudelement( "Angles: " + ent.v[ "angles" ] );
    count = 0;
    drawncount = 0;
    more = 0;
    
    if ( level.effect_list_offset >= level._createfx.options.size )
    {
        level.effect_list_offset = 0;
    }
    
    for ( i = 0; i < level._createfx.options.size ; i++ )
    {
        option = level._createfx.options[ i ];
        
        if ( isdefined( ent.v[ option[ "name" ] ] ) )
        {
            continue;
        }
        
        if ( !mask( option[ "mask" ], ent.v[ "type" ] ) )
        {
            continue;
        }
        
        count++;
        
        if ( count < level.effect_list_offset )
        {
            continue;
        }
        
        if ( drawncount >= level.effect_list_offset_max )
        {
            continue;
        }
        
        drawncount++;
        var_7356ab609cfad76c = drawncount;
        
        if ( var_7356ab609cfad76c == 10 )
        {
            var_7356ab609cfad76c = 0;
        }
        
        if ( button_is_clicked( var_7356ab609cfad76c + "" ) )
        {
            add_option_to_selected_entities( option );
            menunone();
            level.last_displayed_ent = undefined;
            return;
        }
        
        set_fx_hudelement( var_7356ab609cfad76c + ". " + option[ "description" ] );
    }
    
    if ( count > level.effect_list_offset_max )
    {
        set_fx_hudelement( "(->) More >" );
    }
    
    set_fx_hudelement( "(x) Exit >" );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 1
// Checksum 0x0, Offset: 0x1bfe
// Size: 0x9d
function add_option_to_selected_entities( option )
{
    setting = undefined;
    
    for ( i = 0; i < level._createfx.selected_fx_ents.size ; i++ )
    {
        ent = level._createfx.selected_fx_ents[ i ];
        
        if ( mask( option[ "mask" ], ent.v[ "type" ] ) )
        {
            ent.v[ option[ "name" ] ] = option[ "default" ];
        }
    }
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x1ca3
// Size: 0x1f
function menunone()
{
    level.effect_list_offset = 0;
    clear_fx_hudelements();
    setmenu( "none" );
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 1
// Checksum 0x0, Offset: 0x1cca
// Size: 0x258
function display_fx_info( ent )
{
    if ( !menu( "none" ) )
    {
        return;
    }
    
    clear_fx_hudelements();
    set_fx_hudelement( "Name: " + ent.v[ "fxid" ] );
    set_fx_hudelement( "Type: " + ent.v[ "type" ] );
    set_fx_hudelement( "Origin: " + ent.v[ "origin" ] );
    set_fx_hudelement( "Angles: " + ent.v[ "angles" ] );
    
    if ( entities_are_selected() )
    {
        count = 0;
        drawncount = 0;
        more = 0;
        
        for ( i = 0; i < level._createfx.options.size ; i++ )
        {
            option = level._createfx.options[ i ];
            
            if ( !isdefined( ent.v[ option[ "name" ] ] ) )
            {
                continue;
            }
            
            count++;
            
            if ( count < level.effect_list_offset )
            {
                continue;
            }
            
            drawncount++;
            set_fx_hudelement( drawncount + ". " + option[ "description" ] + ": " + ent.v[ option[ "name" ] ] );
            
            if ( drawncount > level.effect_list_offset_max )
            {
                more = 1;
                break;
            }
        }
        
        if ( count > level.effect_list_offset_max )
        {
            set_fx_hudelement( "(->) More >" );
        }
        
        set_fx_hudelement( "(a) Add >" );
        set_fx_hudelement( "(x) Exit >" );
        return;
    }
    
    count = 0;
    more = 0;
    
    for ( i = 0; i < level._createfx.options.size ; i++ )
    {
        option = level._createfx.options[ i ];
        
        if ( !isdefined( ent.v[ option[ "name" ] ] ) )
        {
            continue;
        }
        
        count++;
        set_fx_hudelement( option[ "description" ] + ": " + ent.v[ option[ "name" ] ] );
        
        if ( count > level._createfx.hudelem_count )
        {
            break;
        }
    }
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 1
// Checksum 0x0, Offset: 0x1f2a
// Size: 0xe1
function draw_effects_list( title )
{
    clear_fx_hudelements();
    count = 0;
    more = 0;
    keys = func_get_level_fx();
    
    if ( !isdefined( title ) )
    {
        title = "Pick an effect";
    }
    
    set_fx_hudelement( title + " [" + level.effect_list_offset + " - " + keys.size + "]:" );
    
    for ( i = level.effect_list_offset; i < keys.size ; i++ )
    {
        count += 1;
        set_fx_hudelement( count + ". " + keys[ i ] );
        
        if ( count >= level.effect_list_offset_max )
        {
            more = 1;
            break;
        }
    }
    
    if ( keys.size > level.effect_list_offset_max )
    {
        set_fx_hudelement( "(->) More >" );
        set_fx_hudelement( "(<-) Previous >" );
    }
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x2013
// Size: 0x56
function increment_list_offset()
{
    keys = func_get_level_fx();
    
    if ( level.effect_list_offset >= keys.size - level.effect_list_offset_max )
    {
        level.effect_list_offset = 0;
        return;
    }
    
    level.effect_list_offset += level.effect_list_offset_max;
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x2071
// Size: 0x53
function decrement_list_offset()
{
    level.effect_list_offset -= level.effect_list_offset_max;
    
    if ( level.effect_list_offset < 0 )
    {
        keys = func_get_level_fx();
        level.effect_list_offset = keys.size - level.effect_list_offset_max;
    }
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x20cc
// Size: 0x12b
function select_by_name()
{
    count = 0;
    picked_fx = undefined;
    keys = func_get_level_fx();
    
    for ( i = level.effect_list_offset; i < keys.size ; i++ )
    {
        count += 1;
        var_7356ab609cfad76c = count;
        
        if ( var_7356ab609cfad76c == 10 )
        {
            var_7356ab609cfad76c = 0;
        }
        
        if ( button_is_clicked( var_7356ab609cfad76c + "" ) )
        {
            picked_fx = keys[ i ];
            break;
        }
        
        if ( count > level.effect_list_offset_max )
        {
            break;
        }
    }
    
    if ( !isdefined( picked_fx ) )
    {
        return;
    }
    
    index_array = [];
    
    foreach ( i, ent in level.createfxent )
    {
        if ( issubstr( ent.v[ "fxid" ], picked_fx ) )
        {
            index_array[ index_array.size ] = i;
        }
    }
    
    deselect_all_ents();
    select_index_array( index_array );
    level._createfx.select_by_name = 1;
}

// Namespace createfxmenu / scripts\common\createfxmenu
// Params 0
// Checksum 0x0, Offset: 0x21ff
// Size: 0x2d
function get_last_selected_ent()
{
    return level._createfx.selected_fx_ents[ level._createfx.selected_fx_ents.size - 1 ];
}

