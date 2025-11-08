#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace hud_management;

// Namespace hud_management / scripts\engine\hud_management
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x3c0
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hud_management", undefined, &pre_main, undefined );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3e1
// Size: 0x10c
function private pre_main()
{
    if ( !isdefined( level.player ) )
    {
        level.player = getentarray( "player", "classname" )[ 0 ];
    }
    
    if ( !isdefined( level.hud_management ) )
    {
        level.hud_management = spawnstruct();
    }
    
    if ( !isdefined( level.hud_management.scripted_widgets ) )
    {
        level.hud_management.scripted_widgets = spawnstruct();
    }
    
    data = level.hud_management.scripted_widgets;
    data.widget_types = [];
    data.anchor_types = [];
    data.archetypes = [];
    data.var_56a961d04403887 = spawnstruct();
    function_ce0d74e919485109( function_fac756723bad75d7() );
    function_ce0d74e919485109( function_f47d44a82f05a2bd() );
    function_ce0d74e919485109( function_ac835b45b726185c() );
    function_ce0d74e919485109( function_1e95884aa052ae3e() );
    scripts\common\ui::lui_registercallback( "scripted_widget_closed", &scripted_widget_closed );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4f5
// Size: 0x510
function private function_ce0d74e919485109( scripted_widgets )
{
    if ( !isdefined( scripted_widgets ) )
    {
        return;
    }
    
    data = level.hud_management.scripted_widgets;
    data.max_widgets = scripted_widgets.var_348f35d05ac9a37e;
    
    if ( isdefined( scripted_widgets.archetypes ) )
    {
        foreach ( archetype in scripted_widgets.archetypes )
        {
            archetype_data = getscriptbundle( "scriptedwidgetarchetype:" + archetype.archetype );
            archetype_name = tolower( archetype.archetype );
            
            if ( isdefined( archetype_data ) && !isdefined( data.archetypes[ archetype_name ] ) )
            {
                data.archetypes[ archetype_name ] = [];
                shift = 0;
                
                foreach ( field_data in archetype_data.fields )
                {
                    field = tolower( field_data.field_name );
                    max_value = field_data.max_value;
                    step_increment = field_data.step_increment;
                    assertex( max_value >= step_increment, "<dev string:x1c>" + max_value + "<dev string:x2f>" + archetype_name + "<dev string:x4b>" + field + "<dev string:x59>" + step_increment + "<dev string:x7d>" + step_increment );
                    max_value = max( max_value, step_increment );
                    bits = int( ceil( log( max_value / step_increment + 1 ) / log( 2 ) ) );
                    data.archetypes[ archetype_name ][ field ] = spawnstruct();
                    data.archetypes[ archetype_name ][ field ].bits = bits;
                    data.archetypes[ archetype_name ][ field ].max_value = max_value;
                    data.archetypes[ archetype_name ][ field ].step_increment = step_increment;
                    data.archetypes[ archetype_name ][ field ].shift = shift;
                    data.archetypes[ archetype_name ][ field ].mask = int( pow( 2, bits ) - 1 ) << shift;
                    shift += bits;
                    assertex( shift <= 32, "<dev string:x99>" + archetype_name + "<dev string:xae>" + archetype_name + "<dev string:x10b>" );
                }
            }
        }
    }
    
    if ( isdefined( scripted_widgets.anchors ) )
    {
        foreach ( anchor in scripted_widgets.anchors )
        {
            anchor_data = getscriptbundle( "scriptedwidgetanchorsettings:" + anchor.anchor );
            anchor_name = tolower( anchor.anchor );
            
            if ( isdefined( anchor_data ) && !isdefined( data.anchor_types[ anchor_name ] ) )
            {
                data.anchor_types[ anchor_name ] = data.anchor_types.size;
            }
        }
    }
    
    foreach ( widget in scripted_widgets.scripted_widgets )
    {
        function_26f299852d555394( widget.scripted_widget );
    }
    
    if ( isdefined( scripted_widgets.var_fe35ca9b37873aa2 ) && scripted_widgets.var_fe35ca9b37873aa2 > 0 )
    {
        data.var_56a961d04403887.max_items = scripted_widgets.var_fe35ca9b37873aa2;
        data.var_56a961d04403887.num_groups = ceil( data.var_56a961d04403887.max_items / 8 );
        data.var_56a961d04403887.group_mask = 0;
        data.var_56a961d04403887.group_shift = 0;
        
        if ( data.var_56a961d04403887.num_groups > 1 )
        {
            data.var_56a961d04403887.group_mask = 8;
            data.var_56a961d04403887.group_shift = int( 28 );
        }
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xa0d
// Size: 0x4bc
function private function_26f299852d555394( widget_name )
{
    data = level.hud_management.scripted_widgets;
    widget_data = getscriptbundle( "scriptedwidget:" + widget_name );
    widget_name = tolower( widget_name );
    
    if ( isdefined( widget_data ) && !isdefined( data.widget_types[ widget_name ] ) )
    {
        data.widget_types[ widget_name ] = spawnstruct();
        data.widget_types[ widget_name ].index = data.widget_types.size;
        
        if ( isdefined( widget_data.archetype ) && widget_data.archetype != "" )
        {
            archetype = getscriptbundle( "scriptedwidgetarchetype:" + widget_data.archetype );
            archetype_name = tolower( widget_data.archetype );
            assertex( isdefined( data.archetypes[ archetype_name ] ), "<dev string:x148>" + widget_name + "<dev string:x16e>" + archetype_name + "<dev string:x185>" );
            
            if ( isdefined( archetype ) && isdefined( data.archetypes[ archetype_name ] ) )
            {
                data.widget_types[ widget_name ].archetype = archetype_name;
            }
        }
        
        data.widget_types[ widget_name ].parameters = [];
        
        if ( isdefined( widget_data.parameters ) )
        {
            foreach ( param_index, param in widget_data.parameters )
            {
                if ( isdefined( param.name ) && param.name != "" )
                {
                    data.widget_types[ widget_name ].parameters[ tolower( param.name ) ] = param_index;
                }
            }
        }
        
        data.widget_types[ widget_name ].states = [];
        
        if ( isdefined( widget_data.states ) )
        {
            foreach ( state_index, state in widget_data.states )
            {
                if ( isdefined( state.name ) && state.name != "" )
                {
                    data.widget_types[ widget_name ].states[ tolower( state.name ) ] = state_index;
                }
            }
        }
        
        data.widget_types[ widget_name ].children = [];
        
        if ( isdefined( widget_data.children ) )
        {
            foreach ( child in widget_data.children )
            {
                if ( isdefined( child.name ) && child.name != "" )
                {
                    child_name = tolower( child.name );
                    data.widget_types[ widget_name ].children[ child_name ] = [];
                    
                    foreach ( var_f5de074125c2d341, child_widget in child.widgets )
                    {
                        if ( isdefined( child_widget.name ) )
                        {
                            var_35de4a7a76aee370 = tolower( child_widget.name );
                            data.widget_types[ widget_name ].children[ child_name ][ var_35de4a7a76aee370 ] = spawnstruct();
                            data.widget_types[ widget_name ].children[ child_name ][ var_35de4a7a76aee370 ].index = var_f5de074125c2d341 + 1;
                            data.widget_types[ widget_name ].children[ child_name ][ var_35de4a7a76aee370 ].widget = child_widget.scriptedwidget;
                            function_26f299852d555394( child_widget.scriptedwidget );
                        }
                    }
                }
            }
        }
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0xed1
// Size: 0xf1
function function_efa7d98eea1fb836( widget_name, child_name, var_35de4a7a76aee370 )
{
    widget_name = tolower( widget_name );
    child_name = tolower( child_name );
    var_35de4a7a76aee370 = tolower( var_35de4a7a76aee370 );
    
    if ( isdefined( level.hud_management.scripted_widgets.widget_types[ widget_name ] ) && isdefined( level.hud_management.scripted_widgets.widget_types[ widget_name ].children[ child_name ] ) && isdefined( level.hud_management.scripted_widgets.widget_types[ widget_name ].children[ child_name ][ var_35de4a7a76aee370 ] ) )
    {
        return level.hud_management.scripted_widgets.widget_types[ widget_name ].children[ child_name ][ var_35de4a7a76aee370 ].widget;
    }
    
    return undefined;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0xfcb
// Size: 0xf1
function function_ade28fda795d5664( widget_name, child_name, var_35de4a7a76aee370 )
{
    widget_name = tolower( widget_name );
    child_name = tolower( child_name );
    var_35de4a7a76aee370 = tolower( var_35de4a7a76aee370 );
    
    if ( isdefined( level.hud_management.scripted_widgets.widget_types[ widget_name ] ) && isdefined( level.hud_management.scripted_widgets.widget_types[ widget_name ].children[ child_name ] ) && isdefined( level.hud_management.scripted_widgets.widget_types[ widget_name ].children[ child_name ][ var_35de4a7a76aee370 ] ) )
    {
        return level.hud_management.scripted_widgets.widget_types[ widget_name ].children[ child_name ][ var_35de4a7a76aee370 ].index;
    }
    
    return undefined;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2
// Checksum 0x0, Offset: 0x10c5
// Size: 0xfd
function function_63d35b39e955e65c( var_fee88e2c79edd2f, var_1212b8095077474c )
{
    if ( !isdefined( level.hud_management ) )
    {
        level.hud_management = spawnstruct();
    }
    
    if ( !isdefined( level.hud_management.var_f212ecf957ec73f0 ) )
    {
        level.hud_management.var_f212ecf957ec73f0 = spawnstruct();
    }
    
    data = level.hud_management.var_f212ecf957ec73f0;
    data.omnvar = var_fee88e2c79edd2f;
    data.widgets = [];
    
    if ( isdefined( var_1212b8095077474c ) && tableexists( var_1212b8095077474c ) )
    {
        rows = tablelookupgetnumrows( var_1212b8095077474c );
        
        for ( row = 0; row < rows ; row++ )
        {
            script_name = tablelookupbyrow( var_1212b8095077474c, row, 0 );
            
            if ( script_name != "" )
            {
                data.widgets[ tolower( script_name ) ] = row;
            }
        }
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2
// Checksum 0x0, Offset: 0x11ca
// Size: 0x16d
function function_5c5dd45babfb8d7d( widgets, shouldhide )
{
    assertex( isdefined( level.hud_management ), "<dev string:x1dc>" );
    assertex( isdefined( level.hud_management.var_f212ecf957ec73f0 ), "<dev string:x1dc>" );
    assertex( isdefined( level.hud_management.var_f212ecf957ec73f0.widgets ), "<dev string:x1dc>" );
    assertex( isdefined( level.hud_management.var_f212ecf957ec73f0.omnvar ), "<dev string:x228>" );
    data = level.hud_management.var_f212ecf957ec73f0;
    
    if ( !isarray( widgets ) )
    {
        widgets = [ widgets ];
    }
    
    foreach ( widget in widgets )
    {
        widget = tolower( widget );
        assertex( isdefined( data.widgets[ widget ] ), "<dev string:x28c>" + widget + "<dev string:x2ad>" );
        shouldhide = function_f801c3e967c7768a( widget, shouldhide );
        self setclientomnvarbit( data.omnvar, data.widgets[ widget ], shouldhide );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x133f
// Size: 0x2e7
function function_90de31b2cbef19f9( widget_ref, widget_type, widget_struct )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:x30e>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x30e>" );
    data = level.hud_management.scripted_widgets;
    widget_ref = tolower( widget_ref );
    widget_type = tolower( widget_type );
    
    if ( function_ada0825249682644( widget_ref ) )
    {
        assert( "<dev string:x35b>" + widget_ref + "<dev string:x37e>" );
        return;
    }
    
    index = function_f94203b920f0ba27( widget_ref, widget_type );
    
    if ( isdefined( index ) )
    {
        if ( isdefined( widget_struct ) )
        {
            if ( isdefined( widget_struct.param ) )
            {
                function_cc46ab20b75d5c58( widget_struct.param, "ui_scripted_widget_" + "param_" + index, data.widget_types[ widget_type ].parameters );
            }
            
            if ( isdefined( widget_struct.data ) )
            {
                function_cc46ab20b75d5c58( widget_struct.data, "ui_scripted_widget_" + "data_" + index );
            }
            
            if ( isdefined( widget_struct.state ) )
            {
                function_cc46ab20b75d5c58( widget_struct.state, "ui_scripted_widget_" + "state_" + index, data.widget_types[ widget_type ].states );
            }
            
            if ( isdefined( widget_struct.priority ) )
            {
                function_cc46ab20b75d5c58( widget_struct.priority, "ui_scripted_widget_" + "priority_" + index );
            }
            
            if ( istrue( widget_struct.under_hud ) )
            {
                function_cc46ab20b75d5c58( 1, "ui_scripted_widget_" + "under_hud_" + index );
            }
            
            if ( isent( widget_struct.ent ) )
            {
                assertex( isdefined( widget_struct.anchor_type ), "<dev string:x3a6>" );
                function_7a82d07837107ae6( widget_ref, widget_struct.ent, widget_struct.anchor_type );
            }
            
            if ( isdefined( widget_struct.position ) )
            {
                function_f4c37324750dc183( widget_ref, widget_struct.position.left, widget_struct.position.top, widget_struct.position.horizontal_anchor, widget_struct.position.vertical_anchor, widget_struct.position.var_5bf6089ef591d224 );
            }
        }
        
        self setclientomnvar( "ui_scripted_widget_" + "type_" + index, data.widget_types[ widget_type ].index );
        return;
    }
    
    assert( "<dev string:x3fa>" );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1
// Checksum 0x0, Offset: 0x162e
// Size: 0x14e
function function_6cd0a8e23ff14e13( widget_prefix )
{
    assertex( isdefined( level.hud_management ), "<dev string:x436>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x436>" );
    assertex( isdefined( widget_prefix ), "<dev string:x494>" );
    widget = function_6627dd3016f3d63f( widget_prefix, getdvar( @"g_mapname" ) );
    
    if ( isdefined( widget ) )
    {
        return widget;
    }
    
    widget = function_6627dd3016f3d63f( widget_prefix, [ getprojectname(), level.gametype ] );
    
    if ( isdefined( widget ) )
    {
        return widget;
    }
    
    mode = "mp";
    
    if ( utility::iscp() )
    {
        mode = "cp";
    }
    else if ( utility::issp() )
    {
        mode = "sp";
    }
    
    widget = function_6627dd3016f3d63f( widget_prefix, [ getprojectname(), mode ] );
    
    if ( isdefined( widget ) )
    {
        return widget;
    }
    
    widget = function_6627dd3016f3d63f( widget_prefix, getprojectname() );
    
    if ( isdefined( widget ) )
    {
        return widget;
    }
    
    if ( isdefined( level.gametype ) )
    {
        widget = function_6627dd3016f3d63f( widget_prefix, level.gametype );
        
        if ( isdefined( widget ) )
        {
            return widget;
        }
    }
    
    widget = function_6627dd3016f3d63f( widget_prefix, mode );
    
    if ( isdefined( widget ) )
    {
        return widget;
    }
    
    if ( function_a0ae4b54aa48ade2( widget_prefix ) )
    {
        return widget_prefix;
    }
    
    return undefined;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2
// Checksum 0x0, Offset: 0x1785
// Size: 0x110
function function_6627dd3016f3d63f( widget_prefix, params )
{
    assertex( isdefined( level.hud_management ), "<dev string:x436>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x436>" );
    assertex( isdefined( widget_prefix ), "<dev string:x494>" );
    assertex( isdefined( params ) && ( isstring( params ) || isarray( params ) ), "<dev string:x4df>" );
    var_25f11f8236d36f82 = "";
    
    if ( isstring( params ) )
    {
        var_25f11f8236d36f82 = widget_prefix + "_" + params;
    }
    else if ( isarray( params ) )
    {
        for ( i = 0; i < params.size ; i++ )
        {
            if ( !isdefined( params[ i ] ) )
            {
                return undefined;
            }
            
            var_25f11f8236d36f82 += params[ i ];
            
            if ( i + 1 < params.size )
            {
                var_25f11f8236d36f82 += "_";
            }
        }
        
        var_25f11f8236d36f82 = widget_prefix + "_" + var_25f11f8236d36f82;
    }
    else
    {
        var_25f11f8236d36f82 = widget_prefix;
    }
    
    if ( function_a0ae4b54aa48ade2( var_25f11f8236d36f82 ) )
    {
        return tolower( var_25f11f8236d36f82 );
    }
    
    return undefined;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1
// Checksum 0x0, Offset: 0x189e
// Size: 0x59, Type: bool
function function_a0ae4b54aa48ade2( widget_type )
{
    widget_type = tolower( widget_type );
    return isdefined( level.hud_management ) && isdefined( level.hud_management.scripted_widgets ) && isdefined( level.hud_management.scripted_widgets.widget_types[ widget_type ] );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x1900
// Size: 0x118
function function_956ab5009d077253( widget_asset, param_name, property_name )
{
    assertex( isdefined( level.hud_management ), "<dev string:x562>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x562>" );
    widget_data = getscriptbundle( "scriptedwidget:" + widget_asset );
    param_index = function_7be2b65191088c8a( widget_asset, param_name );
    
    if ( isdefined( param_index ) )
    {
        property_name = tolower( property_name );
        
        foreach ( property in widget_data.parameters[ param_index ].properties )
        {
            if ( property.variant_object.property == property_name )
            {
                return property.variant_object.value;
            }
        }
    }
    
    return undefined;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2
// Checksum 0x0, Offset: 0x1a21
// Size: 0x88
function function_7be2b65191088c8a( widget_asset, param_name )
{
    assertex( isdefined( level.hud_management ), "<dev string:x436>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x436>" );
    widget_asset = tolower( widget_asset );
    param_name = tolower( param_name );
    return level.hud_management.scripted_widgets.widget_types[ widget_asset ].parameters[ param_name ];
}

// Namespace hud_management / scripts\engine\hud_management
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x1ab2
// Size: 0x11f
function private function_95809d3a84b2020b( widget_ref, omnvar_suffix, omnvar_override, var_5a4ed2926457d0b )
{
    var_b8868bce74340be6 = spawnstruct();
    data = level.hud_management.scripted_widgets;
    widget_ref = tolower( widget_ref );
    
    if ( isdefined( omnvar_override ) )
    {
        var_b8868bce74340be6.omnvar = omnvar_override;
        var_b8868bce74340be6.type = widget_ref;
        var_b8868bce74340be6.time_omnvar = var_5a4ed2926457d0b;
        assert( isdefined( data.widget_types[ widget_ref ] ) );
    }
    else
    {
        if ( !function_ada0825249682644( widget_ref ) )
        {
            return undefined;
        }
        
        active_widget = self.var_a14cb42739301f30[ widget_ref ];
        var_b8868bce74340be6.omnvar = "ui_scripted_widget_" + omnvar_suffix + active_widget.index;
        var_b8868bce74340be6.type = active_widget.widget_type;
        var_b8868bce74340be6.time_omnvar = "ui_scripted_widget_" + "time_" + active_widget.index;
    }
    
    return var_b8868bce74340be6;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x1bda
// Size: 0xd8
function function_af4f62f0f944a8f1( widget_ref, param_ref, omnvar_override )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:x5bb>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x5bb>" );
    data = function_95809d3a84b2020b( widget_ref, "param_", omnvar_override );
    
    if ( isdefined( data ) )
    {
        parameters = level.hud_management.scripted_widgets.widget_types[ data.type ].parameters;
        function_cc46ab20b75d5c58( param_ref, data.omnvar, parameters );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x1cba
// Size: 0x9a
function function_b52897e8afbb0968( widget_ref, data_val, omnvar_override )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:x613>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x613>" );
    data = function_95809d3a84b2020b( widget_ref, "data_", omnvar_override );
    
    if ( isdefined( data ) )
    {
        function_cc46ab20b75d5c58( data_val, data.omnvar );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2
// Checksum 0x0, Offset: 0x1d5c
// Size: 0x80
function function_daff24f3e11825ae( widget_asset, state_name )
{
    assertex( isdefined( level.hud_management ), "<dev string:x66a>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x66a>" );
    state_name = tolower( state_name );
    return level.hud_management.scripted_widgets.widget_types[ widget_asset ].states[ state_name ];
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x1de5
// Size: 0xd8
function function_d28fa5295a04d555( widget_ref, state, omnvar_override )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:x6c8>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x6c8>" );
    data = function_95809d3a84b2020b( widget_ref, "state_", omnvar_override );
    
    if ( isdefined( data ) )
    {
        states = level.hud_management.scripted_widgets.widget_types[ data.type ].states;
        function_cc46ab20b75d5c58( state, data.omnvar, states );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x1ec5
// Size: 0x1e8
function function_7a82d07837107ae6( widget_ref, anchor_ent, anchor_type )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    widget_ref = tolower( widget_ref );
    
    if ( !function_ada0825249682644( widget_ref ) )
    {
        return;
    }
    
    anchor_type = tolower( anchor_type );
    data = level.hud_management.scripted_widgets;
    assertex( isdefined( data.anchor_types ) && isdefined( data.anchor_types[ anchor_type ] ), "<dev string:x720>" + anchor_type + "<dev string:x730>" );
    
    if ( !isdefined( self.var_414b9a0d57c1e081 ) )
    {
        self.var_414b9a0d57c1e081 = [];
    }
    
    ent_num = anchor_ent getentitynumber();
    
    if ( !isdefined( self.var_414b9a0d57c1e081[ ent_num ] ) )
    {
        self.var_414b9a0d57c1e081[ ent_num ] = [];
    }
    
    active_widget = self.var_a14cb42739301f30[ widget_ref ];
    
    if ( isdefined( active_widget.ent_num ) )
    {
        self.var_414b9a0d57c1e081[ active_widget.ent_num ][ widget_ref ] = undefined;
        
        if ( self.var_414b9a0d57c1e081[ active_widget.ent_num ].size == 0 )
        {
            self.var_414b9a0d57c1e081[ active_widget.ent_num ] = undefined;
            self notify( "_automatic_remove_anchored_widget_" + active_widget.ent_num );
        }
    }
    
    active_widget.ent_num = ent_num;
    self.var_414b9a0d57c1e081[ ent_num ][ widget_ref ] = active_widget.index;
    ent_omnvar = "ui_scripted_widget_" + "ent_" + active_widget.index;
    self setclientomnvar( ent_omnvar, anchor_ent );
    function_cc46ab20b75d5c58( data.anchor_types[ anchor_type ], "ui_scripted_widget_" + "position_" + active_widget.index );
    thread function_583777ac2b762d3( anchor_ent );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 7
// Checksum 0x0, Offset: 0x20b5
// Size: 0x2e6
function function_f4c37324750dc183( widget_ref, x_pos, y_pos, horizontal_anchor, vertical_anchor, var_5bf6089ef591d224, omnvar_override )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    data = function_95809d3a84b2020b( widget_ref, "position_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    if ( !isdefined( var_5bf6089ef591d224 ) )
    {
        var_5bf6089ef591d224 = 1;
    }
    
    x_pos = int( x_pos );
    y_pos = int( y_pos );
    
    switch ( horizontal_anchor )
    {
        case 0:
            assertex( x_pos >= -63 && x_pos <= 1984, "<dev string:x7cf>" + -63 + "<dev string:x815>" + 1984 + "<dev string:x81e>" );
            x_pos -= -63;
            break;
        case 1:
        case 3:
            assertex( x_pos >= -1023 && x_pos <= 1024, "<dev string:x7cf>" + -1023 + "<dev string:x815>" + 1024 + "<dev string:x835>" );
            x_pos -= -1023;
            break;
        case 2:
            assertex( x_pos >= -1984 && x_pos <= 0 - -63, "<dev string:x7cf>" + -1984 + "<dev string:x815>" + 0 - -63 + "<dev string:x84e>" );
            x_pos += 1984;
            break;
    }
    
    switch ( vertical_anchor )
    {
        case 0:
            assertex( y_pos >= -483 && y_pos <= 1564, "<dev string:x866>" + -483 + "<dev string:x815>" + 1564 + "<dev string:x8ac>" );
            y_pos -= -483;
            break;
        case 1:
        case 3:
            assertex( y_pos >= -1023 && y_pos <= 1024, "<dev string:x866>" + -1023 + "<dev string:x815>" + 1024 + "<dev string:x8c2>" );
            y_pos -= -1023;
            break;
        case 2:
            assertex( y_pos >= -1564 && y_pos <= 0 - -483, "<dev string:x866>" + -1564 + "<dev string:x815>" + 0 - -483 + "<dev string:x8db>" );
            y_pos += 1564;
            break;
    }
    
    y_bits = y_pos << 11;
    var_f7e258d3c20bfb80 = horizontal_anchor << 22;
    var_91800f6a184e5dca = vertical_anchor << 22 + 2;
    var_b086c1951a364c8d = ter_op( var_5bf6089ef591d224, 1, 0 ) << 22 + 2 + 2;
    packed_position = x_pos + y_bits + var_f7e258d3c20bfb80 + var_91800f6a184e5dca + var_b086c1951a364c8d;
    self setclientomnvar( data.omnvar, packed_position );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1
// Checksum 0x0, Offset: 0x23a3
// Size: 0x56
function function_f845164fd6027e79( datatype )
{
    if ( !isdefined( datatype ) )
    {
        return 0;
    }
    
    switch ( datatype )
    {
        case #"hash_a653d8ebf51ebac4":
            return 1;
        case #"hash_5b6fb3c943bab625":
            return 2;
        case #"hash_175a301ae8d1236a":
            return 3;
        default:
            return 0;
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1
// Checksum 0x0, Offset: 0x2401
// Size: 0x56
function function_863b22a1564f8eb( datatype )
{
    if ( !isdefined( datatype ) )
    {
        return 0;
    }
    
    switch ( datatype )
    {
        case #"hash_4fdc8686e8ea358":
            return 1;
        case #"hash_62df33229372c36a":
            return 2;
        case #"hash_175a301ae8d1236a":
            return 3;
        default:
            return 0;
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x245f
// Size: 0x1c1
function function_d2da2b563383891f( widget_ref, var_d66aa55144b09de9, omnvar_override )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    data = function_95809d3a84b2020b( widget_ref, "position_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return undefined;
    }
    
    position_data = self getclientomnvar( data.omnvar );
    x_pos = ( position_data & int( pow( 2, 11 ) - 1 ) ) >> 0;
    y_pos = ( position_data & int( pow( 2, 11 ) - 1 ) ) >> 11;
    vertical_anchor = ( position_data & int( pow( 2, 2 ) - 1 ) ) >> 22;
    horizontal_anchor = ( position_data & int( pow( 2, 2 ) - 1 ) ) >> 22 + 2;
    
    switch ( horizontal_anchor )
    {
        case 0:
            x_pos += -63;
            break;
        case 1:
        case 3:
            x_pos += -1023;
            break;
        case 2:
            x_pos -= 1984;
            break;
    }
    
    switch ( vertical_anchor )
    {
        case 0:
            y_pos += -483;
            break;
        case 1:
        case 3:
            y_pos += -1023;
            break;
        case 2:
            y_pos -= 1564;
            break;
    }
    
    if ( istrue( var_d66aa55144b09de9 ) )
    {
        x_pos = ( x_pos - -63 ) / ( 1984 - -63 );
        y_pos = ( y_pos - -483 ) / ( 1564 - -483 );
    }
    
    return ( x_pos, y_pos, 0 );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x2629
// Size: 0x60
function function_1ec2f3bcef4a8818( widget_ref, priority, omnvar_override )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    data = function_95809d3a84b2020b( widget_ref, "priority_", omnvar_override );
    
    if ( isdefined( data ) )
    {
        self setclientomnvar( data.omnvar, priority );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 5
// Checksum 0x0, Offset: 0x2691
// Size: 0xc2
function function_14a0ee2aaf9128c3( widget_ref, field_values, no_timestamp, omnvar_override, var_5a4ed2926457d0b )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:x8f4>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x8f4>" );
    data = function_95809d3a84b2020b( widget_ref, "data_", omnvar_override, var_5a4ed2926457d0b );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_e375e5ca24ea7bf4( data.type, data.omnvar, field_values, data.time_omnvar );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 4
// Checksum 0x0, Offset: 0x275b
// Size: 0xaf
function function_6e45b720d0914f42( widget_ref, field, value, omnvar_override )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:x8f4>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x8f4>" );
    data = function_95809d3a84b2020b( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_e6df6627eb26284f( data.type, data.omnvar, field, value );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x2812
// Size: 0xd6
function function_2d3bf675525ba34c( widget_ref, field, omnvar_override )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:x8f4>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x8f4>" );
    data = function_95809d3a84b2020b( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    value = function_61dda643ffbb43a0( data.type, data.omnvar, [ field ] );
    function_e6df6627eb26284f( data.type, data.omnvar, field, !value[ field ] );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 6
// Checksum 0x0, Offset: 0x28f0
// Size: 0xcc
function function_ddc9d8c3b0ef6b87( widget_ref, current_pct, target_pct, time, omnvar_override, var_5a4ed2926457d0b )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:x953>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x953>" );
    data = function_95809d3a84b2020b( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_ab8c8292f0d469c4( data.type, data.omnvar, current_pct, target_pct, time, data.time_omnvar );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 5
// Checksum 0x0, Offset: 0x29c4
// Size: 0xc2
function function_315df71064cc10b8( widget_ref, current_pct, bool, omnvar_override, var_5a4ed2926457d0b )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:x9ae>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x9ae>" );
    data = function_95809d3a84b2020b( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_42866bf1e84c1d21( data.type, data.omnvar, current_pct, bool, data.time_omnvar );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 5
// Checksum 0x0, Offset: 0x2a8e
// Size: 0xc2
function function_a435f7db4b861f0c( widget_ref, current_pct, current_alpha, omnvar_override, var_5a4ed2926457d0b )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:xa0e>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:xa0e>" );
    data = function_95809d3a84b2020b( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_7db1020b4d70e9e7( data.type, data.omnvar, current_pct, current_alpha, data.time_omnvar );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 6
// Checksum 0x0, Offset: 0x2b58
// Size: 0xcc
function function_2181b4358a46aab3( widget_ref, count, max_count, time, omnvar_override, var_5a4ed2926457d0b )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:xa6f>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:xa6f>" );
    data = function_95809d3a84b2020b( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_99bfbb496e5ac12a( data.type, data.omnvar, count, max_count, time, data.time_omnvar );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 4
// Checksum 0x0, Offset: 0x2c2c
// Size: 0xaf
function function_b93f1b828644c021( widget_ref, horizontal_alignment, vertical_alignment, omnvar_override )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:xac7>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:xac7>" );
    data = function_95809d3a84b2020b( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_36bba30ae80af891( data.type, data.omnvar, horizontal_alignment, vertical_alignment );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x2ce3
// Size: 0x9b
function function_1f51eabeded054f0( widget_ref, timestamp, omnvar_override )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:xb2d>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:xb2d>" );
    data = function_95809d3a84b2020b( widget_ref, "time_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    self setclientomnvar( data.omnvar, timestamp );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x2d86
// Size: 0xa5
function function_1f1c11d26b17770f( widget_ref, fields, omnvar_override )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:x8f4>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:x8f4>" );
    data = function_95809d3a84b2020b( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    return function_61dda643ffbb43a0( data.type, data.omnvar, fields );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1
// Checksum 0x0, Offset: 0x2e34
// Size: 0xcb
function scripted_widget_destroy( widget_ref )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    assertex( isdefined( level.hud_management ), "<dev string:xb89>" );
    assertex( isdefined( level.hud_management.scripted_widgets ), "<dev string:xb89>" );
    widget_ref = tolower( widget_ref );
    
    if ( !function_ada0825249682644( widget_ref ) )
    {
        return;
    }
    
    index = function_cca9604860a60e2a( widget_ref );
    
    if ( isdefined( index ) )
    {
        data = level.hud_management.scripted_widgets;
        type_omnvar = "ui_scripted_widget_" + "type_" + index;
        self setclientomnvar( type_omnvar, 0 );
        self notify( "scripted_widget_destroyed_" + widget_ref );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1
// Checksum 0x0, Offset: 0x2f07
// Size: 0x60, Type: bool
function function_ada0825249682644( widget_ref )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    widget_ref = tolower( widget_ref );
    data = level.hud_management.scripted_widgets;
    return isdefined( self.var_a14cb42739301f30 ) && isdefined( self.var_a14cb42739301f30[ widget_ref ] );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 0
// Checksum 0x0, Offset: 0x2f70
// Size: 0x31, Type: bool
function function_114fb9814c0b068d()
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    return !isdefined( self.var_a219288779b991ce ) || self.var_a219288779b991ce.size > 0;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x2faa
// Size: 0x65
function function_440f285bc17a2787( list_ref, widget_type, list_items )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    function_90de31b2cbef19f9( list_ref, widget_type );
    self.var_a14cb42739301f30[ list_ref ].list = [];
    
    if ( isdefined( list_items ) )
    {
        function_c9e5319d68e22011( list_ref, list_items );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1
// Checksum 0x0, Offset: 0x3017
// Size: 0x37
function function_cf43a9641fd024af( list_ref )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    scripted_widget_destroy( list_ref );
    function_b267732c9e92f306( list_ref );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 4
// Checksum 0x0, Offset: 0x3056
// Size: 0x53
function function_872bbb1fa784b8d8( list_ref, item_ref, item_type, var_3cefc2b0c7f6f3ec )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    items = [];
    items[ item_ref ] = item_type;
    function_c9e5319d68e22011( list_ref, items, var_3cefc2b0c7f6f3ec );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x30b1
// Size: 0xe2
function function_c9e5319d68e22011( list_ref, list_items, var_3cefc2b0c7f6f3ec )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    items = [];
    omnvars = [];
    
    foreach ( item_ref, item_type in list_items )
    {
        item_type = tolower( item_type );
        omnvar_index = function_eabc5d231d49caab( list_ref, tolower( item_ref ), item_type );
        assertex( isdefined( omnvar_index ), "<dev string:xbd7>" );
        
        if ( isdefined( omnvar_index ) )
        {
            items[ items.size ] = item_type;
            omnvars[ omnvars.size ] = omnvar_index;
        }
    }
    
    function_5afd39d9a06be177( list_ref, items, omnvars, var_3cefc2b0c7f6f3ec );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2
// Checksum 0x0, Offset: 0x319b
// Size: 0x106
function function_1114ac444eb63515( list_ref, items )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    assertex( self.var_a14cb42739301f30[ list_ref ].list.size == items.size, "<dev string:xc44>" );
    self.var_a14cb42739301f30[ list_ref ].list = [];
    
    foreach ( index, item_ref in items )
    {
        item_data = function_9cee54c391590f92( list_ref, item_ref );
        assertex( isdefined( item_data ), "<dev string:xc8b>" + item_ref + "<dev string:xcd8>" );
        self.var_a14cb42739301f30[ list_ref ].list[ index ] = item_data.omnvar_index;
    }
    
    function_989fbe51aaf74cb( list_ref );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x32a9
// Size: 0x191
function function_5270193c147bd4f( list_ref, var_e9648468480b0e14, var_e9648768480b14ad )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    var_8ad345cd8693672b = function_9cee54c391590f92( list_ref, var_e9648468480b0e14 );
    var_8ad346cd8693695e = function_9cee54c391590f92( list_ref, var_e9648768480b14ad );
    assertex( isdefined( var_8ad345cd8693672b ), "<dev string:xcdd>" + var_e9648468480b0e14 + "<dev string:xd00>" );
    assertex( isdefined( var_8ad346cd8693695e ), "<dev string:xcdd>" + var_e9648768480b14ad + "<dev string:xd00>" );
    index_1 = undefined;
    index_2 = undefined;
    var_ee925786ed8c373f = var_8ad345cd8693672b.omnvar_index;
    var_ee925886ed8c3972 = var_8ad346cd8693695e.omnvar_index;
    
    foreach ( index, omnvar_index in self.var_a14cb42739301f30[ list_ref ].list )
    {
        if ( omnvar_index == var_ee925786ed8c373f )
        {
            index_1 = index;
        }
        
        if ( omnvar_index == var_ee925886ed8c3972 )
        {
            index_2 = index;
        }
    }
    
    self.var_a14cb42739301f30[ list_ref ].list[ index_1 ] = var_8ad346cd8693695e.omnvar_index;
    self.var_a14cb42739301f30[ list_ref ].list[ index_2 ] = var_8ad345cd8693672b.omnvar_index;
    function_989fbe51aaf74cb( list_ref );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2
// Checksum 0x0, Offset: 0x3442
// Size: 0x109
function function_52c3bc127d006d2a( list_ref, shift_amount )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    list_size = self.var_a14cb42739301f30[ list_ref ].list.size;
    assertex( list_size >= abs( shift_amount ), "<dev string:xd20>" + list_ref + "<dev string:xd3e>" + shift_amount + "<dev string:xd47>" + list_size + "<dev string:xd55>" );
    shift_index = shift_amount;
    
    if ( shift_amount < 0 )
    {
        shift_index += list_size;
    }
    
    var_50bd74501466d521 = array_slice( self.var_a14cb42739301f30[ list_ref ].list, 0, shift_index );
    var_50bd71501466ce88 = array_slice( self.var_a14cb42739301f30[ list_ref ].list, shift_index, list_size );
    self.var_a14cb42739301f30[ list_ref ].list = array_combine( var_50bd71501466ce88, var_50bd74501466d521 );
    function_989fbe51aaf74cb( list_ref );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1
// Checksum 0x0, Offset: 0x3553
// Size: 0x60
function function_b33be752bae80ae0( list_ref )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    self.var_a14cb42739301f30[ list_ref ].list = array_reverse( self.var_a14cb42739301f30[ list_ref ].list );
    function_989fbe51aaf74cb( list_ref );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1
// Checksum 0x0, Offset: 0x35bb
// Size: 0x67
function function_6e7b649d7feb6bb8( list_ref )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    assertex( isdefined( self.var_5805a2cdb3ddbe56 ) && isdefined( self.var_5805a2cdb3ddbe56[ list_ref ] ), "<dev string:xd71>" + list_ref + "<dev string:xda0>" );
    return getarraykeys( self.var_5805a2cdb3ddbe56[ list_ref ] );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x362b
// Size: 0x3e
function function_58cce4d095e706ab( list_ref, item_ref, var_7a0a75a3e70333fe )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    function_31a20eb9ab140d08( list_ref, [ item_ref ], var_7a0a75a3e70333fe );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x3671
// Size: 0xe1
function function_31a20eb9ab140d08( list_ref, list_items, var_7a0a75a3e70333fe )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    
    if ( !function_ada0825249682644( list_ref ) )
    {
        return;
    }
    
    omnvars = [];
    
    foreach ( item_ref in list_items )
    {
        item_ref = tolower( item_ref );
        omnvar_index = function_fbb932b933235b5e( list_ref, item_ref );
        
        if ( isdefined( omnvar_index ) )
        {
            omnvars[ omnvars.size - 1 ] = omnvar_index;
        }
    }
    
    function_2654508daa8b0930( list_ref, omnvars );
    
    if ( istrue( var_7a0a75a3e70333fe ) && !function_714a8c636f582042( list_ref ) )
    {
        function_cf43a9641fd024af( list_ref );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1
// Checksum 0x0, Offset: 0x375a
// Size: 0x5a
function function_5df3186604c72b24( list_ref )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    
    if ( !function_ada0825249682644( list_ref ) )
    {
        return;
    }
    
    function_b267732c9e92f306( list_ref );
    self.var_a14cb42739301f30[ list_ref ].list = [];
    function_b52897e8afbb0968( list_ref, 0 );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x37bc
// Size: 0xe2
function function_88f7dd62c7058ef5( list_ref, item_ref, param )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_9cee54c391590f92( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        data = level.hud_management.scripted_widgets;
        group = self.var_a14cb42739301f30[ list_ref ].group;
        omnvar = function_e5a3c7e8ca795281( group, item_data.omnvar_index, "param_" );
        function_cc46ab20b75d5c58( param, omnvar, data.widget_types[ item_data.widget_type ].parameters );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x38a6
// Size: 0xe2
function function_1f9e6ee15b7f47c9( list_ref, item_ref, state )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_9cee54c391590f92( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        data = level.hud_management.scripted_widgets;
        group = self.var_a14cb42739301f30[ list_ref ].group;
        omnvar = function_e5a3c7e8ca795281( group, item_data.omnvar_index, "state_" );
        function_cc46ab20b75d5c58( state, omnvar, data.widget_types[ item_data.widget_type ].states );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x3990
// Size: 0xc1
function function_cee2207c6855e73c( list_ref, item_ref, data_val )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_9cee54c391590f92( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        data = level.hud_management.scripted_widgets;
        group = self.var_a14cb42739301f30[ list_ref ].group;
        omnvar = function_e5a3c7e8ca795281( group, item_data.omnvar_index, "data_" );
        function_cc46ab20b75d5c58( data_val, omnvar );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 4
// Checksum 0x0, Offset: 0x3a59
// Size: 0xe3
function function_3eec25a52a78f31f( list_ref, item_ref, field_values, no_timestamp )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_9cee54c391590f92( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        group = self.var_a14cb42739301f30[ list_ref ].group;
        omnvar = function_e5a3c7e8ca795281( group, item_data.omnvar_index, "data_" );
        time_omnvar = undefined;
        
        if ( !istrue( no_timestamp ) )
        {
            time_omnvar = function_e5a3c7e8ca795281( group, item_data.omnvar_index, "time_" );
        }
        
        function_e375e5ca24ea7bf4( item_data.widget_type, omnvar, field_values, time_omnvar );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 5
// Checksum 0x0, Offset: 0x3b44
// Size: 0xe6
function function_9d1591ce32fb0823( list_ref, item_ref, current_pct, target_pct, time )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_9cee54c391590f92( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        group = self.var_a14cb42739301f30[ list_ref ].group;
        omnvar = function_e5a3c7e8ca795281( group, item_data.omnvar_index, "data_" );
        time_omnvar = function_e5a3c7e8ca795281( group, item_data.omnvar_index, "time_" );
        function_ab8c8292f0d469c4( item_data.widget_type, omnvar, current_pct, target_pct, time, time_omnvar );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 5
// Checksum 0x0, Offset: 0x3c32
// Size: 0xe6
function function_6f4f043fa2101c0f( list_ref, item_ref, count, max_count, time )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_9cee54c391590f92( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        group = self.var_a14cb42739301f30[ list_ref ].group;
        omnvar = function_e5a3c7e8ca795281( group, item_data.omnvar_index, "data_" );
        time_omnvar = function_e5a3c7e8ca795281( group, item_data.omnvar_index, "time_" );
        function_99bfbb496e5ac12a( item_data.widget_type, omnvar, count, max_count, time, time_omnvar );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x3d20
// Size: 0xa1
function function_f86a348db854d294( list_ref, item_ref, timestamp )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_9cee54c391590f92( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        group = self.var_a14cb42739301f30[ list_ref ].group;
        omnvar = function_e5a3c7e8ca795281( group, item_data.omnvar_index, "time_" );
        function_cc46ab20b75d5c58( timestamp, omnvar );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2
// Checksum 0x0, Offset: 0x3dc9
// Size: 0x63, Type: bool
function function_91fe3a20ea5f30c5( list_ref, item_ref )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    return isdefined( self.var_5805a2cdb3ddbe56 ) && isdefined( self.var_5805a2cdb3ddbe56[ list_ref ] ) && isdefined( self.var_5805a2cdb3ddbe56[ list_ref ][ item_ref ] );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1
// Checksum 0x0, Offset: 0x3e35
// Size: 0x53, Type: bool
function function_714a8c636f582042( list_ref )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    list_ref = tolower( list_ref );
    return isdefined( self.var_5805a2cdb3ddbe56 ) && isdefined( self.var_5805a2cdb3ddbe56[ list_ref ] ) && self.var_5805a2cdb3ddbe56[ list_ref ].size > 0;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 5
// Checksum 0x0, Offset: 0x3e91
// Size: 0x7e
function function_2acd5041c3f3305e( anchor_ent, widget_ref, widget_type, anchor_type, widget_struct )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    
    if ( !isdefined( widget_struct ) )
    {
        widget_struct = spawnstruct();
    }
    
    widget_struct.ent = anchor_ent;
    widget_struct.anchor_type = anchor_type;
    function_90de31b2cbef19f9( widget_ref, widget_type, widget_struct );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x3f17
// Size: 0x47
function function_d54d04e9ec5b38e3( anchor_ent, widget_ref, param )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    function_af4f62f0f944a8f1( widget_ref, param );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x3f66
// Size: 0x47
function function_1d125bd1128e9582( anchor_ent, widget_ref, data )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    function_b52897e8afbb0968( widget_ref, data );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x3fb5
// Size: 0x47
function function_ad5527feaeffa977( anchor_ent, widget_ref, state )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    function_d28fa5295a04d555( widget_ref, state );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 4
// Checksum 0x0, Offset: 0x4004
// Size: 0x4f
function function_e426dd1d2fd9f6b5( anchor_ent, widget_ref, field_values, omnvar_override )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    return function_1f1c11d26b17770f( widget_ref, field_values, omnvar_override );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 4
// Checksum 0x0, Offset: 0x405c
// Size: 0x50
function function_d0cd9bfbc5529d31( anchor_ent, widget_ref, field_values, no_timestamp )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    function_14a0ee2aaf9128c3( widget_ref, field_values, no_timestamp );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 5
// Checksum 0x0, Offset: 0x40b4
// Size: 0x59
function function_7d0a2b811ae8aebd( anchor_ent, widget_ref, current_pct, target_pct, time )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    function_ddc9d8c3b0ef6b87( widget_ref, current_pct, target_pct, time );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 4
// Checksum 0x0, Offset: 0x4115
// Size: 0x50
function function_34831569ded8586a( anchor_ent, widget_ref, current_pct, bool )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    function_315df71064cc10b8( widget_ref, current_pct, bool );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 4
// Checksum 0x0, Offset: 0x416d
// Size: 0x50
function function_2b6611deface24de( anchor_ent, widget_ref, current_pct, current_alpha )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    function_a435f7db4b861f0c( widget_ref, current_pct, current_alpha );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3
// Checksum 0x0, Offset: 0x41c5
// Size: 0x47
function function_5c09e38e4b882a2a( anchor_ent, widget_ref, timestamp )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    function_1f51eabeded054f0( widget_ref, timestamp );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2
// Checksum 0x0, Offset: 0x4214
// Size: 0x4c
function function_aae81ea024d45e77( anchor_ent, widget_ref )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    ent_num = anchor_ent getentitynumber();
    widget_ref = tolower( widget_ref ) + ent_num;
    function_bb8cf49fbbe8c0d8( widget_ref, ent_num );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1
// Checksum 0x0, Offset: 0x4268
// Size: 0x2c
function function_bb17fbfad71dc49b( anchor_ent )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    function_984451ca1b1af664( anchor_ent getentitynumber() );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2
// Checksum 0x0, Offset: 0x429c
// Size: 0x6f, Type: bool
function function_b76083c9909e209a( anchor_ent, widget_ref )
{
    assertex( isplayer( self ), "<dev string:x2ef>" );
    ent_num = anchor_ent getentitynumber();
    widget_ref = tolower( widget_ref ) + ent_num;
    return isdefined( self.var_414b9a0d57c1e081 ) && isdefined( self.var_414b9a0d57c1e081[ ent_num ] ) && isdefined( self.var_414b9a0d57c1e081[ ent_num ][ widget_ref ] );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4314
// Size: 0x6e
function private function_bb8cf49fbbe8c0d8( widget_ref, ent_num )
{
    if ( isdefined( self.var_414b9a0d57c1e081[ ent_num ] ) )
    {
        if ( isdefined( self.var_414b9a0d57c1e081[ ent_num ][ widget_ref ] ) )
        {
            scripted_widget_destroy( widget_ref );
        }
        
        self.var_414b9a0d57c1e081[ ent_num ][ widget_ref ] = undefined;
        
        if ( self.var_414b9a0d57c1e081[ ent_num ].size == 0 )
        {
            self.var_414b9a0d57c1e081[ ent_num ] = undefined;
            self notify( "_automatic_remove_anchored_widget_" + ent_num );
        }
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x438a
// Size: 0x93
function private function_984451ca1b1af664( ent_num )
{
    if ( isdefined( self.var_414b9a0d57c1e081 ) && isdefined( self.var_414b9a0d57c1e081[ ent_num ] ) )
    {
        foreach ( widget_ref, index in self.var_414b9a0d57c1e081[ ent_num ] )
        {
            scripted_widget_destroy( widget_ref );
        }
        
        self.var_414b9a0d57c1e081[ ent_num ] = undefined;
        self notify( "_automatic_remove_anchored_widget_" + ent_num );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4425
// Size: 0x60
function private function_583777ac2b762d3( ent )
{
    if ( isplayer( self ) )
    {
        self endon( "disconnected" );
    }
    
    ent_num = ent getentitynumber();
    self notify( "_automatic_remove_anchored_widget_" + ent_num );
    self endon( "_automatic_remove_anchored_widget_" + ent_num );
    ent waittill_any( "death", "disconnected", "deleted" );
    thread function_984451ca1b1af664( ent_num );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x448d
// Size: 0x13d
function private function_b36e048ccaca2da4( value, archetype, field, packed_value, clear )
{
    data = level.hud_management.scripted_widgets.archetypes;
    assertex( isdefined( data[ archetype ] ), "<dev string:xdbe>" + archetype + "<dev string:xe06>" );
    assertex( isdefined( data[ archetype ][ field ] ), "<dev string:xe21>" + archetype + "<dev string:xe69>" + field + "<dev string:xe7b>" );
    
    if ( value > data[ archetype ][ field ].max_value )
    {
        assert( "<dev string:xe90>" + archetype + "<dev string:x4b>" + field + "<dev string:xeb4>" + value + "<dev string:xece>" + data[ archetype ][ field ].max_value + "<dev string:xee2>" );
        value = data[ archetype ][ field ].max_value;
    }
    
    value /= data[ archetype ][ field ].step_increment;
    value = int( value );
    
    if ( istrue( clear ) )
    {
        packed_value &= ~data[ archetype ][ field ].mask;
    }
    
    packed_value |= value << data[ archetype ][ field ].shift;
    return packed_value;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x45d3
// Size: 0xb9
function private function_f58cb12303817e47( value, archetype, field )
{
    data = level.hud_management.scripted_widgets.archetypes;
    assertex( isdefined( data[ archetype ] ), "<dev string:xdbe>" + archetype + "<dev string:xe06>" );
    assertex( isdefined( data[ archetype ][ field ] ), "<dev string:xe21>" + archetype + "<dev string:xe69>" + field + "<dev string:xe7b>" );
    value = ( value & data[ archetype ][ field ].mask ) >> data[ archetype ][ field ].shift;
    value *= data[ archetype ][ field ].step_increment;
    return value;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x4695
// Size: 0x182
function private function_e375e5ca24ea7bf4( widget_type, omnvar, field_values, time_omnvar )
{
    data = level.hud_management.scripted_widgets;
    widget_archetypes = level.hud_management.scripted_widgets.archetypes;
    assertex( isdefined( data.widget_types[ widget_type ] ), "<dev string:xeff>" + widget_type + "<dev string:xe7b>" );
    archetype = data.widget_types[ widget_type ].archetype;
    assertex( isdefined( archetype ), "<dev string:xeff>" + widget_type + "<dev string:xf10>" );
    packed_value = 0;
    
    foreach ( field, value in field_values )
    {
        assertex( isdefined( widget_archetypes[ archetype ][ field ] ), "<dev string:xf2a>" + field + "<dev string:xf35>" + archetype + "<dev string:xf5f>" );
        value = clamp( value, 0, widget_archetypes[ archetype ][ field ].max_value );
        packed_value = function_b36e048ccaca2da4( value, archetype, field, packed_value );
    }
    
    self setclientomnvar( omnvar, packed_value );
    
    if ( isdefined( time_omnvar ) )
    {
        self setclientomnvar( time_omnvar, gettime() );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x481f
// Size: 0x134
function private function_e6df6627eb26284f( widget_type, omnvar, field, value )
{
    data = level.hud_management.scripted_widgets;
    widget_archetypes = level.hud_management.scripted_widgets.archetypes;
    assertex( isdefined( data.widget_types[ widget_type ] ), "<dev string:xeff>" + widget_type + "<dev string:xe7b>" );
    archetype = data.widget_types[ widget_type ].archetype;
    assertex( isdefined( archetype ), "<dev string:xeff>" + widget_type + "<dev string:xf10>" );
    packed_value = self getclientomnvar( omnvar );
    assertex( isdefined( widget_archetypes[ archetype ][ field ] ), "<dev string:xf2a>" + field + "<dev string:xf35>" + archetype + "<dev string:xf5f>" );
    value = clamp( value, 0, widget_archetypes[ archetype ][ field ].max_value );
    packed_value = function_b36e048ccaca2da4( value, archetype, field, packed_value, 1 );
    self setclientomnvar( omnvar, packed_value );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x495b
// Size: 0x1ae
function private function_61dda643ffbb43a0( widget_type, omnvar, fields )
{
    data = level.hud_management.scripted_widgets;
    widget_archetypes = level.hud_management.scripted_widgets.archetypes;
    assertex( isdefined( data.widget_types[ widget_type ] ), "<dev string:xeff>" + widget_type + "<dev string:xe7b>" );
    archetype = data.widget_types[ widget_type ].archetype;
    assertex( isdefined( archetype ), "<dev string:xeff>" + widget_type + "<dev string:xf10>" );
    value = self getclientomnvar( omnvar );
    ret_fields = [];
    
    if ( isdefined( fields ) )
    {
        foreach ( field in fields )
        {
            assertex( isdefined( widget_archetypes[ archetype ][ field ] ), "<dev string:xf2a>" + field + "<dev string:xf35>" + archetype + "<dev string:xf5f>" );
            ret_fields[ field ] = function_f58cb12303817e47( value, archetype, field );
        }
    }
    else
    {
        foreach ( field, unused in widget_archetypes[ archetype ] )
        {
            ret_fields[ field ] = function_f58cb12303817e47( value, archetype, field );
        }
    }
    
    return ret_fields;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x4b12
// Size: 0x157
function private function_ab8c8292f0d469c4( widget_type, omnvar, current_pct, target_pct, time, time_omnvar )
{
    data = level.hud_management.scripted_widgets;
    widget_archetypes = level.hud_management.scripted_widgets.archetypes;
    archetype = "scripted_widget_archetype_progress";
    assertex( data.widget_types[ widget_type ].archetype == archetype, "<dev string:xeff>" + widget_type + "<dev string:xf65>" + archetype + "<dev string:xf75>" );
    current_pct = clamp( current_pct, 0, widget_archetypes[ archetype ][ "current_pct" ].max_value );
    target_pct = clamp( target_pct, 0, widget_archetypes[ archetype ][ "target_pct" ].max_value );
    packed_value = 0;
    packed_value = function_b36e048ccaca2da4( current_pct, archetype, "current_pct", packed_value );
    packed_value = function_b36e048ccaca2da4( target_pct, archetype, "target_pct", packed_value );
    packed_value = function_b36e048ccaca2da4( time, archetype, "time", packed_value );
    self setclientomnvar( omnvar, packed_value );
    self setclientomnvar( time_omnvar, gettime() );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x4c71
// Size: 0x11d
function private function_42866bf1e84c1d21( widget_type, omnvar, current_pct, bool, time_omnvar )
{
    data = level.hud_management.scripted_widgets;
    widget_archetypes = level.hud_management.scripted_widgets.archetypes;
    archetype = "scripted_widget_archetype_progress_bool";
    assertex( data.widget_types[ widget_type ].archetype == archetype, "<dev string:xeff>" + widget_type + "<dev string:xf65>" + archetype + "<dev string:xf75>" );
    current_pct = clamp( current_pct, 0, widget_archetypes[ archetype ][ "current_pct" ].max_value );
    packed_value = 0;
    packed_value = function_b36e048ccaca2da4( current_pct, archetype, "current_pct", packed_value );
    packed_value = function_b36e048ccaca2da4( bool, archetype, "bool", packed_value );
    self setclientomnvar( omnvar, packed_value );
    self setclientomnvar( time_omnvar, gettime() );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x4d96
// Size: 0x13d
function private function_7db1020b4d70e9e7( widget_type, omnvar, current_pct, current_alpha, time_omnvar )
{
    data = level.hud_management.scripted_widgets;
    widget_archetypes = level.hud_management.scripted_widgets.archetypes;
    archetype = "scripted_widget_archetype_progress_alpha";
    assertex( data.widget_types[ widget_type ].archetype == archetype, "<dev string:xeff>" + widget_type + "<dev string:xf65>" + archetype + "<dev string:xf75>" );
    current_pct = clamp( current_pct, 0, widget_archetypes[ archetype ][ "current_pct" ].max_value );
    current_alpha = clamp( current_alpha, 0, widget_archetypes[ archetype ][ "current_alpha" ].max_value );
    packed_value = 0;
    packed_value = function_b36e048ccaca2da4( current_pct, archetype, "current_pct", packed_value );
    packed_value = function_b36e048ccaca2da4( current_alpha, archetype, "current_alpha", packed_value );
    self setclientomnvar( omnvar, packed_value );
    self setclientomnvar( time_omnvar, gettime() );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x4edb
// Size: 0x17f
function private function_99bfbb496e5ac12a( widget_type, omnvar, count, max_count, time, time_omnvar )
{
    data = level.hud_management.scripted_widgets;
    widget_archetypes = level.hud_management.scripted_widgets.archetypes;
    archetype = "scripted_widget_archetype_count";
    assertex( data.widget_types[ widget_type ].archetype == archetype, "<dev string:xeff>" + widget_type + "<dev string:xf65>" + archetype + "<dev string:xf75>" );
    count = clamp( count, 0, widget_archetypes[ archetype ][ "count" ].max_value );
    
    if ( isdefined( max_count ) )
    {
        max_count = clamp( max_count, 0, widget_archetypes[ archetype ][ "max_count" ].max_value );
    }
    else
    {
        max_count = 0;
    }
    
    if ( !isdefined( time ) )
    {
        time = 0;
    }
    
    packed_value = 0;
    packed_value = function_b36e048ccaca2da4( count, archetype, "count", packed_value );
    packed_value = function_b36e048ccaca2da4( max_count, archetype, "max_count", packed_value );
    packed_value = function_b36e048ccaca2da4( time, archetype, "time", packed_value );
    self setclientomnvar( omnvar, packed_value );
    
    if ( time > 0 && isdefined( time_omnvar ) )
    {
        self setclientomnvar( time_omnvar, gettime() );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x5062
// Size: 0x126
function private function_36bba30ae80af891( widget_type, omnvar, horizontal_alignment, vertical_alignment )
{
    data = level.hud_management.scripted_widgets;
    widget_archetypes = level.hud_management.scripted_widgets.archetypes;
    archetype = "scripted_widget_archetype_list_item_alignment";
    assertex( data.widget_types[ widget_type ].archetype == archetype, "<dev string:xeff>" + widget_type + "<dev string:xf65>" + archetype + "<dev string:xf75>" );
    horizontal_alignment = clamp( horizontal_alignment, 0, widget_archetypes[ archetype ][ "horizontal_alignment" ].max_value );
    vertical_alignment = clamp( vertical_alignment, 0, widget_archetypes[ archetype ][ "vertical_alignment" ].max_value );
    packed_value = 0;
    packed_value = function_b36e048ccaca2da4( horizontal_alignment, archetype, "horizontal_alignment", packed_value );
    packed_value = function_b36e048ccaca2da4( vertical_alignment, archetype, "vertical_alignment", packed_value );
    self setclientomnvar( omnvar, packed_value );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x5190
// Size: 0x88
function private function_cc46ab20b75d5c58( value, omnvar, ref_table, mask, shift )
{
    if ( isint( value ) )
    {
        value = value;
    }
    else if ( isdefined( ref_table ) )
    {
        value = ref_table[ tolower( value ) ];
    }
    
    if ( isint( value ) )
    {
        if ( isdefined( shift ) )
        {
            value <<= shift;
        }
        
        if ( isdefined( mask ) )
        {
            omnvar_value = self getclientomnvar( omnvar );
            omnvar_value &= ~mask;
            value |= omnvar_value;
        }
        
        self setclientomnvar( omnvar, value );
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5220
// Size: 0x82, Type: bool
function private function_f801c3e967c7768a( widget, shouldhide )
{
    if ( !isdefined( self.var_5b0479a29905e04d ) )
    {
        self.var_5b0479a29905e04d = [];
    }
    
    if ( !isdefined( self.var_5b0479a29905e04d[ widget ] ) )
    {
        self.var_5b0479a29905e04d[ widget ] = 0;
    }
    
    if ( !shouldhide )
    {
        if ( self.var_5b0479a29905e04d[ widget ] > 0 )
        {
            self.var_5b0479a29905e04d[ widget ]--;
        }
    }
    else
    {
        self.var_5b0479a29905e04d[ widget ]++;
    }
    
    return self.var_5b0479a29905e04d[ widget ] > 0;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x52ab
// Size: 0x12a
function private function_f94203b920f0ba27( widget_ref, widget_type )
{
    data = level.hud_management.scripted_widgets;
    index = undefined;
    assertex( isplayer( self ), "<dev string:xf8b>" );
    
    if ( !isdefined( self.var_a219288779b991ce ) )
    {
        self.var_a219288779b991ce = [];
        
        for ( i = 0; i < data.max_widgets ; i++ )
        {
            self.var_a219288779b991ce[ i ] = i;
        }
    }
    
    if ( !isdefined( self.var_a14cb42739301f30 ) )
    {
        self.var_a14cb42739301f30 = [];
    }
    
    if ( self.var_a219288779b991ce.size > 0 )
    {
        index = self.var_a219288779b991ce[ 0 ];
        self.var_a219288779b991ce = array_remove_index( self.var_a219288779b991ce, 0 );
        self.var_a14cb42739301f30[ widget_ref ] = spawnstruct();
        self.var_a14cb42739301f30[ widget_ref ].index = index;
        self.var_a14cb42739301f30[ widget_ref ].widget_type = widget_type;
        function_f77df8178a108beb( index );
    }
    
    return index;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x53de
// Size: 0x96
function private function_cca9604860a60e2a( widget_ref )
{
    data = level.hud_management.scripted_widgets;
    index = undefined;
    assertex( isplayer( self ), "<dev string:xf8b>" );
    
    if ( isdefined( self.var_a14cb42739301f30[ widget_ref ] ) )
    {
        index = self.var_a14cb42739301f30[ widget_ref ].index;
    }
    
    if ( isdefined( index ) )
    {
        self.var_a219288779b991ce[ self.var_a219288779b991ce.size ] = index;
        self.var_a14cb42739301f30[ widget_ref ] = undefined;
    }
    
    return index;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x547d
// Size: 0x71
function private scripted_widget_closed( index )
{
    foreach ( widget_ref, data in self.var_a14cb42739301f30 )
    {
        if ( data.index == index )
        {
            thread scripted_widget_destroy( widget_ref );
            return;
        }
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x54f6
// Size: 0x156
function private function_f77df8178a108beb( index )
{
    data = level.hud_management.scripted_widgets;
    type_omnvar = "ui_scripted_widget_" + "type_" + index;
    param_omnvar = "ui_scripted_widget_" + "param_" + index;
    data_omnvar = "ui_scripted_widget_" + "data_" + index;
    state_omnvar = "ui_scripted_widget_" + "state_" + index;
    time_omnvar = "ui_scripted_widget_" + "time_" + index;
    position_omnvar = "ui_scripted_widget_" + "position_" + index;
    priority_omnvar = "ui_scripted_widget_" + "priority_" + index;
    ent_omnvar = "ui_scripted_widget_" + "ent_" + index;
    var_5410df86be1ea9f = "ui_scripted_widget_" + "under_hud_" + index;
    self setclientomnvar( type_omnvar, 0 );
    self setclientomnvar( param_omnvar, 0 );
    self setclientomnvar( data_omnvar, 0 );
    self setclientomnvar( state_omnvar, 0 );
    self setclientomnvar( time_omnvar, 0 );
    self setclientomnvar( position_omnvar, 0 );
    self setclientomnvar( priority_omnvar, 0 );
    self setclientomnvar( ent_omnvar, undefined );
    self setclientomnvar( var_5410df86be1ea9f, 0 );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x5654
// Size: 0x262
function private function_eabc5d231d49caab( list_ref, item_ref, widget_type )
{
    data = level.hud_management.scripted_widgets.var_56a961d04403887;
    omnvar_index = undefined;
    
    if ( !isdefined( self.var_1dcdf3ab55136138 ) )
    {
        self.var_1dcdf3ab55136138 = [];
        var_73e244a1fc96fa27 = 8;
        
        if ( data.num_groups > 1 )
        {
            var_73e244a1fc96fa27 -= 1;
        }
        
        for ( i = 0; i < data.max_items ; i++ )
        {
            group = int( floor( i / var_73e244a1fc96fa27 ) );
            index = i % var_73e244a1fc96fa27;
            
            if ( !isdefined( self.var_1dcdf3ab55136138[ group ] ) )
            {
                self.var_1dcdf3ab55136138[ group ] = [];
            }
            
            self.var_1dcdf3ab55136138[ group ][ index ] = index + 1;
        }
    }
    
    if ( !isdefined( self.var_5805a2cdb3ddbe56 ) )
    {
        self.var_5805a2cdb3ddbe56 = [];
    }
    
    if ( !isdefined( self.var_a14cb42739301f30[ list_ref ].group ) )
    {
        best_group = undefined;
        var_74a5ab73c5ee76c9 = 0;
        
        for ( i = 0; i < data.num_groups ; i++ )
        {
            group_size = self.var_1dcdf3ab55136138[ i ].size;
            
            if ( group_size > var_74a5ab73c5ee76c9 )
            {
                best_group = i;
                var_74a5ab73c5ee76c9 = group_size;
            }
        }
        
        if ( !isdefined( best_group ) )
        {
            return undefined;
        }
        
        function_91905deae6454c5d( list_ref, best_group );
    }
    
    group = self.var_a14cb42739301f30[ list_ref ].group;
    array_index = self.var_1dcdf3ab55136138[ group ].size - 1;
    
    if ( array_index >= 0 )
    {
        omnvar_index = self.var_1dcdf3ab55136138[ group ][ array_index ];
        self.var_1dcdf3ab55136138[ group ][ array_index ] = undefined;
        
        if ( !isdefined( self.var_5805a2cdb3ddbe56[ list_ref ] ) )
        {
            self.var_5805a2cdb3ddbe56[ list_ref ] = [];
        }
        
        self.var_5805a2cdb3ddbe56[ list_ref ][ item_ref ] = spawnstruct();
        self.var_5805a2cdb3ddbe56[ list_ref ][ item_ref ].omnvar_index = omnvar_index;
        self.var_5805a2cdb3ddbe56[ list_ref ][ item_ref ].widget_type = widget_type;
        function_496f711a9ab7a47f( group, omnvar_index );
    }
    
    return omnvar_index;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x58bf
// Size: 0xd0
function private function_91905deae6454c5d( list_ref, group_index )
{
    group_mask = level.hud_management.scripted_widgets.var_56a961d04403887.group_mask;
    group_shift = level.hud_management.scripted_widgets.var_56a961d04403887.group_shift;
    
    if ( isdefined( group_mask ) && isdefined( group_shift ) )
    {
        omnvar = "ui_scripted_widget_" + "data_" + self.var_a14cb42739301f30[ list_ref ].index;
        function_cc46ab20b75d5c58( group_index, omnvar, undefined, group_mask, group_shift );
    }
    
    self.var_a14cb42739301f30[ list_ref ].group = group_index;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5997
// Size: 0xe9
function private function_fbb932b933235b5e( list_ref, item_ref )
{
    data = level.hud_management.scripted_widgets.var_56a961d04403887;
    omnvar_index = undefined;
    
    if ( isdefined( self.var_5805a2cdb3ddbe56[ list_ref ] ) && isdefined( self.var_5805a2cdb3ddbe56[ list_ref ][ item_ref ] ) )
    {
        omnvar_index = self.var_5805a2cdb3ddbe56[ list_ref ][ item_ref ].omnvar_index;
        
        if ( isdefined( omnvar_index ) )
        {
            group = self.var_a14cb42739301f30[ list_ref ].group;
            self.var_1dcdf3ab55136138[ group ][ self.var_1dcdf3ab55136138[ group ].size ] = omnvar_index;
            self.var_5805a2cdb3ddbe56[ list_ref ][ item_ref ] = undefined;
            
            if ( self.var_5805a2cdb3ddbe56[ list_ref ].size == 0 )
            {
                self.var_5805a2cdb3ddbe56[ list_ref ] = undefined;
            }
        }
    }
    
    return omnvar_index;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5a89
// Size: 0xee
function private function_b267732c9e92f306( list_ref )
{
    data = level.hud_management.scripted_widgets.var_56a961d04403887;
    
    if ( isdefined( self.var_5805a2cdb3ddbe56[ list_ref ] ) )
    {
        if ( self.var_5805a2cdb3ddbe56[ list_ref ].size > 0 )
        {
            group = self.var_a14cb42739301f30[ list_ref ].group;
            
            foreach ( item_data in self.var_5805a2cdb3ddbe56[ list_ref ] )
            {
                self.var_1dcdf3ab55136138[ group ][ self.var_1dcdf3ab55136138[ group ].size ] = item_data.omnvar_index;
            }
        }
        
        self.var_5805a2cdb3ddbe56[ list_ref ] = undefined;
    }
}

// Namespace hud_management / scripts\engine\hud_management
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x5b7f
// Size: 0x14d
function private function_5afd39d9a06be177( list_ref, items, omnvars, var_3cefc2b0c7f6f3ec )
{
    if ( istrue( var_3cefc2b0c7f6f3ec ) )
    {
        self.var_a14cb42739301f30[ list_ref ].list = array_combine( omnvars, self.var_a14cb42739301f30[ list_ref ].list );
    }
    else
    {
        self.var_a14cb42739301f30[ list_ref ].list = array_combine( self.var_a14cb42739301f30[ list_ref ].list, omnvars );
    }
    
    data = level.hud_management.scripted_widgets;
    
    foreach ( index, item in items )
    {
        type_omnvar = function_e5a3c7e8ca795281( self.var_a14cb42739301f30[ list_ref ].group, omnvars[ index ], "type_" );
        self setclientomnvar( type_omnvar, data.widget_types[ item ].index );
    }
    
    function_989fbe51aaf74cb( list_ref );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5cd4
// Size: 0x4d
function private function_2654508daa8b0930( list_ref, items )
{
    self.var_a14cb42739301f30[ list_ref ].list = array_remove_array( self.var_a14cb42739301f30[ list_ref ].list, items );
    function_989fbe51aaf74cb( list_ref );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5d29
// Size: 0xeb
function private function_989fbe51aaf74cb( list_ref )
{
    max_items = 8;
    value = 0;
    
    if ( level.hud_management.scripted_widgets.var_56a961d04403887.num_groups > 1 )
    {
        max_items -= 1;
        value = self.var_a14cb42739301f30[ list_ref ].group << level.hud_management.scripted_widgets.var_56a961d04403887.group_shift;
    }
    
    list = self.var_a14cb42739301f30[ list_ref ].list;
    
    for ( i = 0; i < max_items ; i++ )
    {
        if ( isdefined( list[ i ] ) )
        {
            value |= list[ i ] << 4 * i;
        }
    }
    
    function_b52897e8afbb0968( list_ref, value );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5e1c
// Size: 0xc0
function private function_496f711a9ab7a47f( group, omnvar_index )
{
    omnvar_index = function_3e551e16074e030e( group, omnvar_index );
    type_omnvar = "ui_scripted_list_item_" + "type_" + omnvar_index;
    param_omnvar = "ui_scripted_list_item_" + "param_" + omnvar_index;
    data_omnvar = "ui_scripted_list_item_" + "data_" + omnvar_index;
    state_omnvar = "ui_scripted_list_item_" + "state_" + omnvar_index;
    time_omnvar = "ui_scripted_list_item_" + "time_" + omnvar_index;
    self setclientomnvar( type_omnvar, 0 );
    self setclientomnvar( param_omnvar, 0 );
    self setclientomnvar( data_omnvar, 0 );
    self setclientomnvar( state_omnvar, 0 );
    self setclientomnvar( time_omnvar, 0 );
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5ee4
// Size: 0x19
function private function_3e551e16074e030e( group, index )
{
    return index + group * 8;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x5f06
// Size: 0x2e
function private function_e5a3c7e8ca795281( group, omnvar_index, omnvar_suffix )
{
    omnvar_index = function_3e551e16074e030e( group, omnvar_index );
    return "ui_scripted_list_item_" + omnvar_suffix + omnvar_index;
}

// Namespace hud_management / scripts\engine\hud_management
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5f3d
// Size: 0x7a
function private function_9cee54c391590f92( list_ref, item_ref )
{
    data = level.hud_management.scripted_widgets.var_56a961d04403887;
    
    if ( isdefined( self.var_5805a2cdb3ddbe56 ) && isdefined( self.var_5805a2cdb3ddbe56[ list_ref ] ) && isdefined( self.var_5805a2cdb3ddbe56[ list_ref ][ item_ref ] ) )
    {
        return self.var_5805a2cdb3ddbe56[ list_ref ][ item_ref ];
    }
    
    return undefined;
}

