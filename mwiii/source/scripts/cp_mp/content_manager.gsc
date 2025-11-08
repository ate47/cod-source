#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\interaction;
#using scripts\engine\utility;

#namespace content_manager;

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 2
// Checksum 0x0, Offset: 0x199
// Size: 0x34
function function_9218617331ba59ff( instance, string )
{
    if ( isdefined( instance.contentgroups[ string ] ) )
    {
        return instance.contentgroups[ string ][ 0 ];
    }
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 2
// Checksum 0x0, Offset: 0x1d5
// Size: 0x41
function function_223d2522d69e265d( instance, string )
{
    content_array = [];
    
    if ( isdefined( instance.contentgroups[ string ] ) )
    {
        content_array = instance.contentgroups[ string ];
    }
    
    return content_array;
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 0
// Checksum 0x0, Offset: 0x21f
// Size: 0x81
function function_3e419ffd7ff0650d()
{
    flag_init( "content_manager_initialized" );
    level.contentmanager = spawnstruct();
    level.contentmanager.registeredscripts = [];
    level.contentmanager.scriptcategories = [];
    setup_destinations();
    setup_locations();
    level.contentmanager.spawnedinstances = [];
    flag_set( "content_manager_initialized" );
    
    /#
        level thread init_devgui();
    #/
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 0
// Checksum 0x0, Offset: 0x2a8
// Size: 0x1c
function function_25d8f4a67b2f6fa6()
{
    setup_destinations();
    setup_locations();
    
    /#
        level thread init_devgui();
    #/
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 3
// Checksum 0x0, Offset: 0x2cc
// Size: 0xbf
function register_script( scriptname, spawncallback, var_76c7d77c9c5c25cb )
{
    assert( isstring( scriptname ) );
    assert( isdefined( spawncallback ) );
    assertex( !isdefined( level.contentmanager.registeredscripts[ scriptname ] ), scriptname + "<dev string:x1c>" );
    script = spawnstruct();
    script.scriptname = scriptname;
    script.spawncallback = spawncallback;
    level.contentmanager.registeredscripts[ scriptname ] = script;
    
    if ( istrue( var_76c7d77c9c5c25cb ) )
    {
        array_add( level.contentmanager.var_be6410a3e31c071b, scriptname );
    }
    
    return script;
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 1
// Checksum 0x0, Offset: 0x394
// Size: 0x2f
function get_script( scriptname )
{
    assert( isstring( scriptname ) );
    return level.contentmanager.registeredscripts[ scriptname ];
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 2
// Checksum 0x0, Offset: 0x3cc
// Size: 0xec
function function_2643181f53446ac4( key, value )
{
    assert( isstring( key ) );
    
    if ( !isdefined( value ) )
    {
        return [];
    }
    
    scripts = getstructarray( value, key );
    var_2d9173702eb7f54e = [];
    
    foreach ( script in scripts )
    {
        foreach ( var_e5feb06a255e7309 in level.contentmanager.registeredscripts )
        {
            var_2d9173702eb7f54e[ var_2d9173702eb7f54e.size ] = var_e5feb06a255e7309;
        }
    }
    
    return var_2d9173702eb7f54e;
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 2
// Checksum 0x0, Offset: 0x4c1
// Size: 0x149
function function_1d0ccd8d315db185( destination, content_category )
{
    locations = array_randomize( get_children( destination ) );
    
    for ( i = 0; i < locations.size ; i++ )
    {
        if ( isdefined( locations[ i ].variantname ) && locations[ i ].variantname != "content_location" )
        {
            array_remove_index( locations, i, 1 );
        }
    }
    
    array_removeundefined( locations, 1 );
    
    foreach ( location in locations )
    {
        instances = array_randomize( get_children( location ) );
        
        foreach ( instance in instances )
        {
            if ( isdefined( instance.content_script_name ) && instance.content_script_name == content_category )
            {
                return instance;
            }
        }
    }
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 0
// Checksum 0x0, Offset: 0x612
// Size: 0x1e9
function setup_destinations()
{
    level.contentmanager.destinations = [];
    
    if ( !isdefined( level.struct_class_names[ "variantname" ] ) )
    {
        return;
    }
    
    mapdestinations = getstructarray( "content_destination", "variantname" );
    
    foreach ( destination in mapdestinations )
    {
        assert( isdefined( destination.targetname ) );
        assert( !isdefined( level.contentmanager.destinations[ destination.targetname ] ) );
        level.contentmanager.destinations[ destination.targetname ] = destination;
        function_dcb921c0f1ffc7a2( destination );
        destination.locations = [];
        children = get_children( destination );
        
        foreach ( child in children )
        {
            if ( child.variantname != "content_location" )
            {
                continue;
            }
            
            assert( isdefined( child.targetname ) );
            assert( !isdefined( destination.locations[ child.targetname ] ) );
            destination.locations[ child.targetname ] = child;
        }
    }
    
    level.contentmanager.destinations = array_randomize( level.contentmanager.destinations );
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 2
// Checksum 0x0, Offset: 0x803
// Size: 0xd4
function setup_adjacencies( str_destination, var_29d15208128f7711 )
{
    assert( isdefined( level.contentmanager.destinations[ str_destination ] ), "<dev string:x54>" + str_destination );
    i = 0;
    
    foreach ( var_bb24acdfc3f6728 in var_29d15208128f7711 )
    {
        adjacency = getstruct( var_bb24acdfc3f6728 );
        assert( isdefined( adjacency ), "<dev string:x83>" + var_bb24acdfc3f6728 );
        level.contentmanager.destinations[ str_destination ].adjacencies[ i ] = adjacency;
        i++;
    }
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 1
// Checksum 0x0, Offset: 0x8df
// Size: 0x63
function function_38c2d8befceaca58( location )
{
    assert( isstruct( location ) );
    assert( location.variantname == "<dev string:xbc>" );
    spawned_instances = isarray( location.spawnedinstances ) && location.spawnedinstances.size > 0;
    return spawned_instances;
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 0
// Checksum 0x0, Offset: 0x94b
// Size: 0x2f5
function setup_locations()
{
    level.contentmanager.locations = [];
    
    if ( !isdefined( level.struct_class_names[ "variantname" ] ) )
    {
        return;
    }
    
    maplocations = getstructarray( "content_location", "variantname" );
    
    foreach ( location in maplocations )
    {
        assert( isdefined( location.targetname ) );
        assert( !isdefined( level.contentmanager.locations[ location.targetname ] ) );
        level.contentmanager.locations[ location.targetname ] = location;
        
        if ( isdefined( location.target ) )
        {
            parent = getstruct( location.target, "targetname" );
            
            if ( isdefined( parent ) && isdefined( parent.variantname ) && parent.variantname == "content_destination" )
            {
                location.destination = parent;
            }
        }
        
        function_dcb921c0f1ffc7a2( location );
        location.instances = [];
        children = get_children( location );
        
        foreach ( child in children )
        {
            if ( !isdefined( child.variantname ) || child.variantname != "content_instance" )
            {
                continue;
            }
            
            assert( isdefined( child.content_script_name ) );
            
            if ( !isdefined( location.instances[ child.content_script_name ] ) )
            {
                location.instances[ child.content_script_name ] = spawnstruct();
                location.instances[ child.content_script_name ].versions = [];
            }
            
            location.instances[ child.content_script_name ].versions = default_to( location.instances[ child.content_script_name ].versions, [] );
            location.instances[ child.content_script_name ].versions = function_6d6af8144a5131f1( location.instances[ child.content_script_name ].versions, child );
            child.location = location;
        }
    }
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 1
// Checksum 0x0, Offset: 0xc48
// Size: 0xc1
function spawn_instance( instance )
{
    assert( isstruct( instance ) );
    assert( instance.variantname == "<dev string:xd0>" );
    assert( isstring( instance.content_script_name ) );
    assert( isstruct( instance.location ) );
    function_dcb921c0f1ffc7a2( instance );
    script = level.contentmanager.registeredscripts[ instance.content_script_name ];
    
    if ( isdefined( script.spawncallback ) )
    {
        level thread [[ script.spawncallback ]]( instance );
    }
    
    function_83373446144cfe7d( instance );
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 1
// Checksum 0x0, Offset: 0xd11
// Size: 0x78, Type: bool
function function_200f782ea3757585( instance )
{
    assert( isstruct( instance ) );
    assert( instance.variantname == "<dev string:xd0>" );
    assert( isstring( instance.content_script_name ) );
    assert( isstruct( instance.location ) );
    return !function_38c2d8befceaca58( instance.location );
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 1
// Checksum 0x0, Offset: 0xd92
// Size: 0x100
function function_83373446144cfe7d( instance )
{
    assert( isarray( level.contentmanager.spawnedinstances ) );
    instance.location.spawnedinstances = default_to( instance.location.spawnedinstances, [] );
    instance.location.spawnedinstances[ instance.location.spawnedinstances.size ] = instance;
    spawnedinstances = level.contentmanager.spawnedinstances;
    spawnedinstances[ instance.content_script_name ] = default_to( spawnedinstances[ instance.content_script_name ], [] );
    spawnedinstances[ instance.content_script_name ][ spawnedinstances[ instance.content_script_name ].size ] = instance;
    level.contentmanager.spawnedinstances = spawnedinstances;
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 4
// Checksum 0x0, Offset: 0xe9a
// Size: 0x91
function spawn_interact( struct, scriptable_name, usecallback, offset )
{
    assert( isstruct( struct ) );
    assert( isdefined( usecallback ) );
    offset = default_to( offset, ( 0, 0, 0 ) );
    interact = spawnscriptable( scriptable_name, struct.origin + offset, struct.angles );
    function_32645103f7520635( interact, usecallback );
    interact interact_show( 1 );
    return interact;
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 1
// Checksum 0x0, Offset: 0xf34
// Size: 0x34
function interact_show( b_show )
{
    state_name = "visible";
    
    if ( !b_show )
    {
        state_name = "hidden";
    }
    
    self setscriptablepartstate( "content_interact", state_name );
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 0
// Checksum 0x0, Offset: 0xf70
// Size: 0x13
function function_1ab52e17fab56634()
{
    self setscriptablepartstate( "content_interact", "inactive" );
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 6
// Checksum 0x0, Offset: 0xf8b
// Size: 0x54
function interact_used( interact, part, state, player, auto_use, use_string )
{
    if ( !isdefined( interact.var_e9c2e3596843e78 ) )
    {
        return;
    }
    
    interact thread [[ interact.var_e9c2e3596843e78 ]]( player );
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 4
// Checksum 0x0, Offset: 0xfe7
// Size: 0xa4
function function_a6df741f1a9b67b1( contentstructs, modelname, var_4056e5ccaf62d67d, pingable )
{
    default_to( var_4056e5ccaf62d67d, 0 );
    default_to( pingable, 1 );
    models = [];
    
    foreach ( struct in contentstructs )
    {
        model = spawn_script_model( struct, modelname, var_4056e5ccaf62d67d, pingable );
        models[ models.size ] = model;
    }
    
    return models;
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 5
// Checksum 0x0, Offset: 0x1094
// Size: 0x1ee
function spawn_script_model( struct, modelname, var_4056e5ccaf62d67d, pingable, var_194ed46ea3828b33 )
{
    var_4056e5ccaf62d67d = default_to( var_4056e5ccaf62d67d, 0 );
    pingable = default_to( pingable, 1 );
    var_194ed46ea3828b33 = default_to( var_194ed46ea3828b33, struct.origin );
    model = spawn( "script_model", var_194ed46ea3828b33 );
    model.angles = default_to( struct.angles, ( 0, 0, 0 ) );
    model setmodel( modelname );
    
    if ( isdefined( struct.targetname ) )
    {
        model.targetname = struct.targetname;
    }
    
    if ( isdefined( struct.script_noteworthy ) )
    {
        model.script_noteworthy = struct.script_noteworthy;
    }
    
    if ( isdefined( struct.script_string ) )
    {
        model.script_string = struct.script_string;
    }
    
    if ( var_4056e5ccaf62d67d )
    {
        model disconnectpaths();
    }
    
    if ( pingable )
    {
    }
    
    parent = struct;
    
    while ( true )
    {
        if ( isdefined( parent.variantname ) && parent.variantname == "content_instance" && isdefined( parent.a ) )
        {
            if ( !array_contains( parent.a.models, model ) )
            {
                parent.a.models = array_add( parent.a.models, model );
            }
            
            break;
        }
        
        if ( !isdefined( parent.target ) )
        {
            break;
        }
        
        parent = getstruct( parent.target, "targetname" );
        
        if ( !isdefined( parent ) )
        {
            break;
        }
        
        waitframe();
    }
    
    return model;
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 3
// Checksum 0x0, Offset: 0x128b
// Size: 0xfa
function spawn_zbarrier( struct, zbarrier_classname, var_52bec72bdd3b32dd )
{
    default_to( var_52bec72bdd3b32dd, 0 );
    zbarrier = spawn( zbarrier_classname, struct.origin );
    zbarrier.angles = struct.angles;
    
    if ( var_52bec72bdd3b32dd )
    {
        zbarrier disconnectpaths();
    }
    
    parent = struct;
    
    while ( true )
    {
        if ( parent.variantname == "content_instance" )
        {
            if ( !array_contains( parent.a.models, zbarrier ) )
            {
                parent.a.models = array_add( parent.a.models, zbarrier );
            }
            
            break;
        }
        
        parent = getstruct( parent.target );
        
        if ( !isdefined( parent ) )
        {
            break;
        }
    }
    
    return zbarrier;
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 0
// Checksum 0x0, Offset: 0x138e
// Size: 0x29b
function cleanup_spawned_instances()
{
    level notify( "cleanup_spawned_instances" );
    var_c2e3697f2eabf2ea = 10;
    models_cleaned = 0;
    
    foreach ( group in level.contentmanager.spawnedinstances )
    {
        foreach ( instance in group )
        {
            if ( isdefined( instance.a_models ) )
            {
                foreach ( model in instance.a_models )
                {
                    if ( isdefined( model ) )
                    {
                        if ( isdefined( model.trigger ) )
                        {
                            model.trigger delete();
                        }
                        
                        if ( isdefined( model.var_eb28965081694d6 ) )
                        {
                            if ( isdefined( level.var_4108d934ddee914 ) )
                            {
                                [[ level.var_4108d934ddee914 ]]( model.var_eb28965081694d6 );
                            }
                            else
                            {
                                objective_delete( model.var_eb28965081694d6 );
                            }
                        }
                        
                        if ( isdefined( model.objectiveid ) )
                        {
                            if ( isdefined( level.var_4108d934ddee914 ) )
                            {
                                [[ level.var_4108d934ddee914 ]]( model.objectiveid );
                            }
                            else
                            {
                                objective_delete( model.objectiveid );
                            }
                        }
                        
                        model anim_scene_stop();
                        model delete();
                        models_cleaned += 1;
                        
                        if ( models_cleaned % var_c2e3697f2eabf2ea == 0 )
                        {
                            wait 0.05;
                        }
                    }
                }
                
                instance.a_models = array_removeundefined( instance.a_models );
            }
            
            group = array_remove( group, instance );
            instance.location.spawnedinstances = array_remove( instance.location.spawnedinstances, instance );
        }
        
        group = array_removeundefined( group );
        level.contentmanager.spawnedinstances = array_remove( level.contentmanager.spawnedinstances, group );
    }
    
    array_removeundefined( level.contentmanager.spawnedinstances );
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 1
// Checksum 0x0, Offset: 0x1631
// Size: 0xbb
function function_dcb921c0f1ffc7a2( parent )
{
    children = get_children( parent );
    contentgroups = function_8133fcadd8a74b66( children );
    parent.contentgroups = contentgroups;
    
    foreach ( child in children )
    {
        if ( !isdefined( child.content_key ) || child.variantname != "content_struct" )
        {
            continue;
        }
        
        child.parent = parent;
        function_dcb921c0f1ffc7a2( child );
    }
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 1
// Checksum 0x0, Offset: 0x16f4
// Size: 0xc3
function function_8133fcadd8a74b66( children )
{
    groups = [];
    
    foreach ( child in children )
    {
        if ( !isdefined( child.content_key ) || child.variantname != "content_struct" )
        {
            continue;
        }
        
        groups[ child.content_key ] = default_to( groups[ child.content_key ], [] );
        groups[ child.content_key ][ groups[ child.content_key ].size ] = child;
    }
    
    return groups;
}

// Namespace content_manager / scripts\cp_mp\content_manager
// Params 1
// Checksum 0x0, Offset: 0x17c0
// Size: 0x32
function get_children( parent )
{
    if ( !isdefined( parent.targetname ) )
    {
        return [];
    }
    
    return getstructarray( parent.targetname, "target" );
}

/#

    // Namespace content_manager / scripts\cp_mp\content_manager
    // Params 0
    // Checksum 0x0, Offset: 0x17fb
    // Size: 0x369, Type: dev
    function init_devgui()
    {
        level notify( "<dev string:xe4>" );
        level endon( "<dev string:xe4>" );
        wait 0.05;
        adddebugcommand( "<dev string:x109>" + "<dev string:x116>" + "<dev string:x134>" );
        path = devgui_path( "<dev string:x13e>", 0 );
        add_devgui( devgui_path( "<dev string:x13e>", 0 ), "<dev string:x153>" + "<dev string:x116>" + "<dev string:x15e>" );
        
        foreach ( destination in level.contentmanager.destinations )
        {
            foreach ( location in destination.locations )
            {
                foreach ( instance_type in location.instances )
                {
                    foreach ( instance in instance_type.versions )
                    {
                        instancekey = location.targetname + "<dev string:x166>" + instance.content_script_name;
                        path = devgui_path( "<dev string:x16b>", 1, destination.targetname + "<dev string:x17b>" + location.targetname + "<dev string:x17b>" + instance.content_script_name );
                        add_devgui( path, "<dev string:x180>" + "<dev string:x188>" + instancekey );
                    }
                }
            }
        }
        
        foreach ( location in level.contentmanager.locations )
        {
            foreach ( instance_type in location.instances )
            {
                foreach ( instance in instance_type.versions )
                {
                    instancekey = location.targetname + "<dev string:x166>" + instance.content_script_name;
                    path = devgui_path( "<dev string:x1a9>", 2, location.targetname + "<dev string:x17b>" + instance.content_script_name );
                    add_devgui( path, "<dev string:x180>" + "<dev string:x188>" + instancekey );
                }
            }
        }
        
        level thread debug_draw();
        level thread function_35cf2e81c8407bf7();
    }

    // Namespace content_manager / scripts\cp_mp\content_manager
    // Params 3
    // Checksum 0x0, Offset: 0x1b6c
    // Size: 0x54, Type: dev
    function devgui_path( name, pos, str )
    {
        path = "<dev string:x1b6>";
        path += "<dev string:x17b>" + name + "<dev string:x166>" + pos;
        
        if ( isdefined( str ) )
        {
            path += "<dev string:x17b>" + str;
        }
        
        return path;
    }

    // Namespace content_manager / scripts\cp_mp\content_manager
    // Params 2
    // Checksum 0x0, Offset: 0x1bc8
    // Size: 0x3f, Type: dev
    function add_devgui( menu_path, commands )
    {
        cmd = "<dev string:x1d0>" + menu_path + "<dev string:x1e0>" + commands + "<dev string:x1e7>";
        addentrytodevgui( cmd );
    }

    // Namespace content_manager / scripts\cp_mp\content_manager
    // Params 1
    // Checksum 0x0, Offset: 0x1c0f
    // Size: 0x18, Type: dev
    function addentrytodevgui( command )
    {
        level thread addentrytodevgui_internal( command );
    }

    // Namespace content_manager / scripts\cp_mp\content_manager
    // Params 1
    // Checksum 0x0, Offset: 0x1c2f
    // Size: 0x162, Type: dev
    function addentrytodevgui_internal( command )
    {
        if ( !isdefined( command ) )
        {
            return;
        }
        
        wait 5;
        
        if ( isdefined( game[ "<dev string:x1ed>" ] ) && game[ "<dev string:x1ed>" ] == "<dev string:x1f6>" )
        {
            return;
        }
        
        final_command = "<dev string:x202>";
        toks = strtok( command, "<dev string:x17b>" );
        space = "<dev string:x206>";
        num_toks = 0;
        
        foreach ( tok in toks )
        {
            new_toks = strtok( tok, "<dev string:x206>" );
            count = 1;
            size = new_toks.size;
            
            foreach ( new_tok in new_toks )
            {
                if ( count < size )
                {
                    final_command = final_command + new_tok + space;
                }
                else
                {
                    final_command += new_tok;
                }
                
                count++;
            }
            
            num_toks++;
            
            if ( num_toks < toks.size )
            {
                final_command += "<dev string:x17b>";
            }
        }
        
        adddebugcommand( final_command );
    }

    // Namespace content_manager / scripts\cp_mp\content_manager
    // Params 0
    // Checksum 0x0, Offset: 0x1d99
    // Size: 0x12c, Type: dev
    function function_35cf2e81c8407bf7()
    {
        self notify( "<dev string:x20b>" );
        self endon( "<dev string:x20b>" );
        
        while ( true )
        {
            setdvar( @"hash_861046be2917f04e", "<dev string:x202>" );
            wait 0.05;
            instancekey = getdvar( @"hash_861046be2917f04e", "<dev string:x202>" );
            
            if ( instancekey == "<dev string:x202>" )
            {
                continue;
            }
            
            keys = strtok( instancekey, "<dev string:x166>" );
            
            if ( keys.size != 2 )
            {
                continue;
            }
            
            location = level.contentmanager.locations[ keys[ 0 ] ];
            
            if ( !isdefined( location ) )
            {
                continue;
            }
            
            if ( isdefined( location.spawnedinstance ) )
            {
                continue;
            }
            
            instance = location.instances.versions[ keys[ 1 ] ];
            
            if ( !isdefined( instance ) )
            {
                continue;
            }
            
            teleport = function_9218617331ba59ff( instance, "<dev string:x23a>" );
            default_to( teleport, instance );
            level.players[ 0 ] setorigin( teleport.origin );
            spawn_instance( instance );
        }
    }

    // Namespace content_manager / scripts\cp_mp\content_manager
    // Params 0
    // Checksum 0x0, Offset: 0x1ecd
    // Size: 0xf9, Type: dev
    function debug_draw()
    {
        self notify( "<dev string:x243>" );
        self endon( "<dev string:x243>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_8a58a350fd3df60e", 0 ) )
            {
                foreach ( destination in level.contentmanager.destinations )
                {
                    draw_destination( destination );
                }
                
                foreach ( location in level.contentmanager.locations )
                {
                    draw_location( location, location.destination );
                }
            }
            
            wait 0.05;
        }
    }

    // Namespace content_manager / scripts\cp_mp\content_manager
    // Params 1
    // Checksum 0x0, Offset: 0x1fce
    // Size: 0x2f, Type: dev
    function draw_destination( destination )
    {
        draw_struct( destination, ( 0, 1, 0 ), undefined, destination.targetname );
    }

    // Namespace content_manager / scripts\cp_mp\content_manager
    // Params 2
    // Checksum 0x0, Offset: 0x2005
    // Size: 0xdd, Type: dev
    function draw_location( location, destination )
    {
        draw_struct( location, ( 0, 1, 1 ), destination, location.targetname );
        
        foreach ( instance_type in location.instances )
        {
            foreach ( instance in instance_type.versions )
            {
                draw_instance( instance, location );
            }
        }
    }

    // Namespace content_manager / scripts\cp_mp\content_manager
    // Params 2
    // Checksum 0x0, Offset: 0x20ea
    // Size: 0x34, Type: dev
    function draw_instance( instance, location )
    {
        draw_struct( instance, ( 0, 0, 1 ), location );
        function_151de086961dc5d6( instance );
    }

    // Namespace content_manager / scripts\cp_mp\content_manager
    // Params 1
    // Checksum 0x0, Offset: 0x2126
    // Size: 0xd0, Type: dev
    function function_151de086961dc5d6( node )
    {
        if ( isarray( node.contentgroups ) )
        {
            foreach ( group in node.contentgroups )
            {
                foreach ( child in group )
                {
                    draw_struct( child, ( 1, 0, 1 ), node );
                    function_151de086961dc5d6( child );
                }
            }
        }
    }

    // Namespace content_manager / scripts\cp_mp\content_manager
    // Params 4
    // Checksum 0x0, Offset: 0x21fe
    // Size: 0xc1, Type: dev
    function draw_struct( struct, color, parent, extrastr )
    {
        debugstr = undefined;
        debugstr = function_8d3f50d17aeb1eae( debugstr, struct.variantname );
        debugstr = function_8d3f50d17aeb1eae( debugstr, struct.content_script_name );
        debugstr = function_8d3f50d17aeb1eae( debugstr, struct.content_key );
        debugstr = function_8d3f50d17aeb1eae( debugstr, extrastr );
        
        if ( isdefined( parent ) )
        {
            line( struct.origin, parent.origin, color );
        }
        
        sphere( struct.origin, 8, color );
        print3d( struct.origin, debugstr );
    }

    // Namespace content_manager / scripts\cp_mp\content_manager
    // Params 2
    // Checksum 0x0, Offset: 0x22c7
    // Size: 0x31, Type: dev
    function function_8d3f50d17aeb1eae( str, append )
    {
        if ( !isdefined( str ) )
        {
            return append;
        }
        else if ( isdefined( append ) )
        {
            return ( str + "<dev string:x267>" + append );
        }
        
        return str;
    }

#/
