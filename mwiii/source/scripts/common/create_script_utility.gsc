#using scripts\common\utility;
#using scripts\engine\utility;

#namespace create_script_utility;

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 0
// Checksum 0x0, Offset: 0x44c
// Size: 0x9
function initialize_create_script()
{
    init_create_script_for_level();
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x45d
// Size: 0x9c
function init_create_script_for_level( bshouldthread )
{
    if ( isdefined( level.scripted_spawner_func ) )
    {
        return;
    }
    
    level.threadedscriptspawners = istrue( bshouldthread );
    level.create_script_file_ids = [];
    level.cs_scripted_spawners = [];
    level.scripted_spawners = [];
    level.cs_scripted_spawners_triggers = [];
    level.scripted_spawners_triggers = [];
    level.cs_scripted_spawners_models = [];
    level.scripted_spawners_models = [];
    level.createscriptfilesinitialized = 0;
    level.scripted_spawner_func_strings = [];
    level.scripted_spawner_map_strings = [];
    level.scripted_spawner_func = [];
    level.var_fd1365ce671037db = 0;
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 0
// Checksum 0x0, Offset: 0x501
// Size: 0x90
function initialize_registered_create_script_files()
{
    if ( isdefined( level.scripted_spawner_func ) )
    {
        level.cs_creation_counter = 0;
        
        if ( isarray( level.scripted_spawner_func ) )
        {
            for ( i = 0; i < level.scripted_spawner_func.size ; i++ )
            {
                [[ level.scripted_spawner_func[ i ] ]]( 1, "cs" + i );
            }
            
            return;
        }
        
        if ( istrue( level.threadedscriptspawners ) )
        {
            [[ level.scripted_spawner_func ]]( 1 );
            return;
        }
        
        [[ level.scripted_spawner_func ]]();
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 4
// Checksum 0x0, Offset: 0x599
// Size: 0x8c
function register_create_script_arrays( script, map, index, func )
{
    if ( isdefined( func ) )
    {
        level.scripted_spawner_func[ level.scripted_spawner_func.size ] = func;
    }
    
    if ( isdefined( script ) )
    {
        level.scripted_spawner_func_strings[ level.scripted_spawner_func_strings.size ] = script;
        
        if ( isdefined( index ) )
        {
            level.create_script_file_ids[ script ] = "cs" + index;
        }
    }
    
    if ( isdefined( map ) )
    {
        level.scripted_spawner_map_strings[ level.scripted_spawner_func_strings.size ] = map;
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x62d
// Size: 0x42
function initialize_create_script_file( file_name )
{
    if ( flag_exist( file_name ) )
    {
        flag_set( file_name );
        
        if ( flag_exist( file_name + "_completed" ) )
        {
            level endon( "game_ended" );
            flag_wait( file_name + "_completed" );
        }
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x677
// Size: 0x3b
function register_valid_gametypes_for_create_script( allowed_gametype )
{
    if ( !isdefined( level.allowed_gametypes ) )
    {
        level.allowed_gametypes = [];
    }
    
    level.allowed_gametypes = array_add( level.allowed_gametypes, allowed_gametype );
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x6ba
// Size: 0x3b
function register_valid_objectives_for_create_script( allowed_objective )
{
    if ( !isdefined( level.allowed_objectives ) )
    {
        level.allowed_objectives = [];
    }
    
    level.allowed_objectives = array_add( level.allowed_objectives, allowed_objective );
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 2
// Checksum 0x0, Offset: 0x6fd
// Size: 0x1cc
function strike_setup_arrays( index, cs_file )
{
    if ( !isdefined( level.scripted_spawners ) )
    {
        level.scripted_spawners = [];
    }
    
    if ( !isdefined( level.scripted_spawners_triggers ) )
    {
        level.scripted_spawners_triggers = [];
    }
    
    if ( !isdefined( level.scripted_spawners_models ) )
    {
        level.scripted_spawners_models = [];
    }
    
    if ( !isdefined( level.cs_origin_offset ) )
    {
        level.cs_origin_offset = [];
    }
    
    if ( !isdefined( level.cs_angle_offset ) )
    {
        level.cs_angle_offset = [];
    }
    
    if ( !isdefined( level.cs_scripted_spawners ) )
    {
        level.cs_scripted_spawners = [];
    }
    
    if ( !isdefined( level.cs_scripted_spawners_triggers ) )
    {
        level.cs_scripted_spawners_triggers = [];
    }
    
    if ( !isdefined( level.cs_scripted_spawners_models ) )
    {
        level.cs_scripted_spawners_models = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.scripted_spawners[ index ] ) )
    {
        level.scripted_spawners[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.scripted_spawners_triggers[ index ] ) )
    {
        level.scripted_spawners_triggers[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.scripted_spawners_models[ index ] ) )
    {
        level.scripted_spawners_models[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.cs_scripted_spawners[ index ] ) )
    {
        level.cs_scripted_spawners[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.cs_scripted_spawners_triggers[ index ] ) )
    {
        level.cs_scripted_spawners_triggers[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.cs_scripted_spawners_models[ index ] ) )
    {
        level.cs_scripted_spawners_models[ index ] = [];
    }
    
    if ( scripts\engine\utility::issharedfuncdefined( "create_script", "cleanupFuncInit" ) )
    {
        funcname = scripts\engine\utility::getsharedfunc( "create_script", "cleanupFuncInit" );
        [[ funcname ]]( cs_file, self );
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 2
// Checksum 0x0, Offset: 0x8d1
// Size: 0x1cc
function cs_setup_arrays( index, cs_file )
{
    if ( !isdefined( level.scripted_spawners ) )
    {
        level.scripted_spawners = [];
    }
    
    if ( !isdefined( level.scripted_spawners_triggers ) )
    {
        level.scripted_spawners_triggers = [];
    }
    
    if ( !isdefined( level.scripted_spawners_models ) )
    {
        level.scripted_spawners_models = [];
    }
    
    if ( !isdefined( level.cs_origin_offset ) )
    {
        level.cs_origin_offset = [];
    }
    
    if ( !isdefined( level.cs_angle_offset ) )
    {
        level.cs_angle_offset = [];
    }
    
    if ( !isdefined( level.cs_scripted_spawners ) )
    {
        level.cs_scripted_spawners = [];
    }
    
    if ( !isdefined( level.cs_scripted_spawners_triggers ) )
    {
        level.cs_scripted_spawners_triggers = [];
    }
    
    if ( !isdefined( level.cs_scripted_spawners_models ) )
    {
        level.cs_scripted_spawners_models = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.scripted_spawners[ index ] ) )
    {
        level.scripted_spawners[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.scripted_spawners_triggers[ index ] ) )
    {
        level.scripted_spawners_triggers[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.scripted_spawners_models[ index ] ) )
    {
        level.scripted_spawners_models[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.cs_scripted_spawners[ index ] ) )
    {
        level.cs_scripted_spawners[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.cs_scripted_spawners_triggers[ index ] ) )
    {
        level.cs_scripted_spawners_triggers[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.cs_scripted_spawners_models[ index ] ) )
    {
        level.cs_scripted_spawners_models[ index ] = [];
    }
    
    if ( scripts\engine\utility::issharedfuncdefined( "create_script", "cleanupFuncInit" ) )
    {
        funcname = scripts\engine\utility::getsharedfunc( "create_script", "cleanupFuncInit" );
        [[ funcname ]]( cs_file, self );
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 16
// Checksum 0x0, Offset: 0xaa5
// Size: 0x41f
function strike_additem( struct, index, cs_file, origin, angles, targetname, target, script_noteworthy, script_linkto, script_linkname, var_a1306ee53c20150f, var_e3c2f7a7f3d4cce6, radius, speed, spawnflags, script_unload )
{
    level endon( "game_ended" );
    
    if ( !struct object_is_valid() )
    {
        return;
    }
    
    if ( isdefined( level.cs_creation_counter ) && !cs_is_starttime() )
    {
        level.cs_creation_counter++;
        
        if ( level.cs_creation_counter % 25 == 0 )
        {
            waitframe();
        }
    }
    
    var_ed4382cb70a213e2 = 0;
    
    if ( isdefined( origin ) )
    {
        struct.origin = origin;
    }
    
    if ( isdefined( angles ) )
    {
        struct.angles = angles;
    }
    else if ( !isdefined( struct.angles ) )
    {
        struct.angles = ( 0, 0, 0 );
    }
    
    if ( isdefined( targetname ) )
    {
        var_ed4382cb70a213e2 = 1;
        struct.targetname = targetname;
    }
    
    if ( isdefined( target ) )
    {
        var_ed4382cb70a213e2 = 1;
        struct.target = target;
    }
    
    if ( isdefined( script_noteworthy ) )
    {
        var_ed4382cb70a213e2 = 1;
        struct.script_noteworthy = script_noteworthy;
    }
    
    if ( isdefined( script_linkto ) )
    {
        struct.script_linkto = script_linkto;
    }
    
    if ( isdefined( script_linkname ) )
    {
        var_ed4382cb70a213e2 = 1;
        struct.script_linkname = script_linkname;
    }
    
    if ( isdefined( speed ) )
    {
        struct.speed = speed;
    }
    
    if ( isdefined( radius ) )
    {
        struct.radius = radius;
    }
    
    if ( isdefined( spawnflags ) )
    {
        struct.spawnflags = int( spawnflags );
    }
    
    if ( isdefined( script_unload ) )
    {
        struct.script_unload = script_unload;
    }
    
    translate_position_with_offset_data( cs_file, struct, var_a1306ee53c20150f, var_e3c2f7a7f3d4cce6 );
    
    if ( !isdefined( index ) )
    {
        index = "_";
    }
    
    strike_fixautokvps( struct, index );
    typecast_kvps( struct );
    
    if ( isdefined( self.objects ) )
    {
        self.objects[ self.objects.size ] = struct;
    }
    
    if ( isdefined( struct.model ) )
    {
        if ( istrue( struct.is_cs_model ) )
        {
            struct.is_cs_model = undefined;
        }
        
        strike_modelcreate( struct, index );
        return;
    }
    
    if ( isdefined( struct.is_cs_script_origin ) )
    {
        struct.is_cs_script_origin = ter_op( struct.is_cs_script_origin == "1", 1, 0 );
    }
    
    if ( istrue( struct.is_cs_trigger ) )
    {
        struct.is_cs_trigger = undefined;
        strike_triggercreate( struct, index, 1, struct.var_857f45e57f5d5a7a );
        struct.var_857f45e57f5d5a7a = undefined;
        return;
    }
    
    if ( istrue( struct.is_cs_model ) )
    {
        strike_modelcreate( struct, index );
        struct.is_cs_model = undefined;
        return;
    }
    
    if ( istrue( struct.is_cs_script_origin ) )
    {
        struct.is_cs_script_origin = undefined;
        strike_scriptorigincreate( struct, index );
        return;
    }
    
    if ( isdefined( struct.targetname ) )
    {
        switch ( struct.targetname )
        {
            case #"hash_c54a2fb47decfc4b":
                strike_triggercreate( struct, index );
                break;
            case #"hash_39242cd548aa8ad2":
                strike_triggercreate( struct, index );
                break;
            case #"hash_9c00e8ccfe6f652f":
                strike_triggercreate( struct, index, 1 );
                break;
            case #"hash_e0468027719a9048":
                strike_triggercreate( struct, index, 1 );
                break;
            case #"hash_d9876aa54e2a4d2b":
                strike_interactioncreate( struct, index );
                break;
            case #"hash_1ca1f994ed1249f5":
                strike_triggercreate( struct, index, 1 );
                break;
            default:
                addstruct( struct );
                break;
        }
        
        return;
    }
    
    addstruct( struct );
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 0
// Checksum 0x0, Offset: 0xecc
// Size: 0x149, Type: bool
function object_is_valid()
{
    gametype_allowed = 0;
    objective_allowed = 0;
    
    if ( isdefined( level.allowed_gametypes ) )
    {
        if ( isdefined( self.script_gameobjectname ) )
        {
            for ( i = 0; i < level.allowed_gametypes.size ; i++ )
            {
                if ( getsubstr( level.allowed_gametypes[ i ], 0, 1 ) == "!" )
                {
                    invertlogic = 1;
                }
                else
                {
                    invertlogic = 0;
                }
                
                if ( is_object_allowed_in_gametype( self.script_gameobjectname, level.allowed_gametypes[ i ] ) != invertlogic )
                {
                    gametype_allowed = 1;
                    break;
                }
            }
        }
        else
        {
            gametype_allowed = 1;
        }
    }
    else
    {
        gametype_allowed = 1;
    }
    
    if ( isdefined( level.allowed_objectives ) )
    {
        if ( isdefined( self.script_gameobjectname ) )
        {
            for ( i = 0; i < level.allowed_objectives.size ; i++ )
            {
                if ( getsubstr( level.allowed_objectives[ i ], 0, 1 ) == "!" )
                {
                    invertlogic = 1;
                }
                else
                {
                    invertlogic = 0;
                }
                
                if ( is_object_allowed_in_gametype( self.script_gameobjectname, level.allowed_objectives[ i ] ) != invertlogic )
                {
                    objective_allowed = 1;
                    break;
                }
            }
        }
        else
        {
            objective_allowed = 1;
        }
    }
    else
    {
        objective_allowed = 1;
    }
    
    return istrue( gametype_allowed && objective_allowed );
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 2
// Checksum 0x0, Offset: 0x101e
// Size: 0x3e
function is_object_allowed_in_gametype( stringlist, gametype )
{
    if ( !isdefined( stringlist ) || stringlist == "" || !isdefined( gametype ) || gametype == "" )
    {
        return 0;
    }
    
    return issubstr( stringlist, gametype );
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 4
// Checksum 0x0, Offset: 0x1065
// Size: 0xf1
function translate_position_with_offset_data( cs_file, struct, var_5f0a2cdf1e857bac, var_82b752b102f67a72 )
{
    translate_and_rotate_from_level_overrides( cs_file, struct );
    
    if ( isdefined( var_5f0a2cdf1e857bac ) )
    {
        if ( !isdefined( var_82b752b102f67a72 ) )
        {
            var_82b752b102f67a72 = ( 0, 0, 0 );
        }
        
        obj_angles = ( 0, 0, 0 );
        
        if ( isdefined( struct.angles ) )
        {
            obj_angles = struct.angles;
        }
        
        obj_origin = struct.origin;
        struct.origin = var_5f0a2cdf1e857bac + rotatevector( obj_origin, var_82b752b102f67a72 );
        
        if ( isdefined( struct.script_origin_other ) )
        {
            struct.script_origin_other = var_5f0a2cdf1e857bac + rotatevector( struct.script_origin_other, var_82b752b102f67a72 );
        }
        
        var_d241032d837036a4 = combineangles( var_82b752b102f67a72, obj_angles );
        struct.angles = var_d241032d837036a4;
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 2
// Checksum 0x0, Offset: 0x115e
// Size: 0x10f
function translate_and_rotate_from_level_overrides( cs_file, struct )
{
    if ( isdefined( cs_file ) && isdefined( level.cs_origin_offset ) && isdefined( level.cs_angle_offset[ cs_file ] ) )
    {
        var_82b752b102f67a72 = level.cs_angle_offset[ cs_file ];
        var_5f0a2cdf1e857bac = level.cs_origin_offset[ cs_file ];
        obj_angles = ( 0, 0, 0 );
        
        if ( isdefined( struct.angles ) )
        {
            obj_angles = struct.angles;
        }
        
        obj_origin = struct.origin;
        struct.origin = var_5f0a2cdf1e857bac + rotatevector( obj_origin, var_82b752b102f67a72 );
        
        if ( isdefined( struct.script_origin_other ) )
        {
            struct.script_origin_other = var_5f0a2cdf1e857bac + rotatevector( struct.script_origin_other, var_82b752b102f67a72 );
        }
        
        var_d241032d837036a4 = combineangles( var_82b752b102f67a72, obj_angles );
        struct.angles = var_d241032d837036a4;
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 3
// Checksum 0x0, Offset: 0x1275
// Size: 0x115
function strike_add_to_cs_arrays( cs_type, struct, index )
{
    if ( !getdvarint( @"hash_ad6e2fed4a549f49", 0 ) )
    {
        return;
    }
    
    if ( cs_type == "struct" )
    {
        level.scripted_spawners[ index ][ level.scripted_spawners[ index ].size ] = struct;
    }
    else if ( cs_type == "trigger" )
    {
        level.scripted_spawners_triggers[ index ][ level.scripted_spawners_triggers[ index ].size ] = struct;
    }
    else if ( cs_type == "model" )
    {
        level.scripted_spawners_models[ index ][ level.scripted_spawners_models[ index ].size ] = struct;
    }
    
    /#
        if ( cs_type == "<dev string:x1c>" )
        {
            level.cs_scripted_spawners[ index ][ level.cs_scripted_spawners[ index ].size ] = struct;
            return;
        }
        
        if ( cs_type == "<dev string:x26>" )
        {
            level.cs_scripted_spawners_triggers[ index ][ level.cs_scripted_spawners_triggers[ index ].size ] = struct;
            return;
        }
        
        if ( cs_type == "<dev string:x31>" )
        {
            level.cs_scripted_spawners_models[ index ][ level.cs_scripted_spawners_models[ index ].size ] = struct;
        }
    #/
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 2
// Checksum 0x0, Offset: 0x1392
// Size: 0x1b
function strike_interactioncreate( struct, index )
{
    addstruct( struct );
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 2
// Checksum 0x0, Offset: 0x13b5
// Size: 0x185
function strike_scriptorigincreate( struct, index )
{
    model = spawn( "script_origin", struct.origin );
    
    if ( !isdefined( struct.angles ) )
    {
        model.angles = ( 0, 0, 0 );
    }
    else
    {
        model.angles = struct.angles;
    }
    
    if ( isdefined( struct.model ) )
    {
        model setmodel( struct.model );
    }
    
    if ( isdefined( struct.targetname ) )
    {
        model.targetname = struct.targetname;
    }
    
    if ( isdefined( struct.script_noteworthy ) )
    {
        model.script_noteworthy = struct.script_noteworthy;
    }
    
    if ( isdefined( struct.script_linkto ) )
    {
        model.script_linkto = struct.script_linkto;
    }
    
    if ( isdefined( struct.script_linkname ) )
    {
        model.script_linkname = struct.script_linkname;
    }
    
    if ( isdefined( struct.target ) )
    {
        model.target = struct.target;
    }
    
    model.struct = struct;
    
    if ( isdefined( self.objects ) )
    {
        self.objects[ self.objects.size ] = model;
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 2
// Checksum 0x0, Offset: 0x1542
// Size: 0x1bd
function strike_modelcreate( struct, index )
{
    strike_add_to_cs_arrays( "model", struct, index );
    
    if ( !isdefined( struct.angles ) )
    {
        struct.angles = ( 0, 0, 0 );
    }
    
    model = spawn( "script_model", struct.origin );
    model.angles = struct.angles;
    model setmodel( struct.model );
    
    if ( isdefined( struct.targetname ) )
    {
        model.targetname = struct.targetname;
    }
    
    if ( isdefined( struct.script_noteworthy ) )
    {
        model.script_noteworthy = struct.script_noteworthy;
    }
    
    if ( isdefined( struct.script_linkto ) )
    {
        model.script_linkto = struct.script_linkto;
    }
    
    if ( isdefined( struct.script_linkname ) )
    {
        model.script_linkname = struct.script_linkname;
    }
    
    if ( isdefined( struct.target ) )
    {
        model.target = struct.target;
    }
    
    if ( isdefined( struct.name ) )
    {
        model.name = struct.name;
    }
    
    model.struct = struct;
    struct.is_cs_model = undefined;
    struct.is_cs_scriptable = undefined;
    
    if ( isdefined( self.objects ) )
    {
        self.objects[ self.objects.size ] = model;
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 4
// Checksum 0x0, Offset: 0x1707
// Size: 0x20c
function strike_triggercreate( struct, index, var_edb06d254fff788c, noent_volume )
{
    strike_add_to_cs_arrays( "trigger", struct, index );
    
    if ( isdefined( struct.spawnflags ) )
    {
        spawnflags = struct.spawnflags;
    }
    else
    {
        spawnflags = 0;
    }
    
    if ( isdefined( struct.var_74e936bbadd15418 ) && isdefined( struct.var_750c4cbbadf7cc32 ) )
    {
        if ( istrue( noent_volume ) )
        {
            trigger = spawn( "noent_volume_trigger_box", struct.origin, spawnflags, struct.var_74e936bbadd15418, struct.var_750c4cbbadf7cc32 );
        }
        else
        {
            trigger = spawn( "trigger_box", struct.origin, spawnflags, struct.var_74e936bbadd15418, struct.var_750c4cbbadf7cc32 );
        }
    }
    else if ( istrue( noent_volume ) )
    {
        trigger = spawn( "noent_volume_trigger_rotatable_radius", struct.origin, spawnflags, int( struct.radius ), int( struct.height ) );
    }
    else
    {
        trigger = spawn( "trigger_rotatable_radius", struct.origin, spawnflags, int( struct.radius ), int( struct.height ) );
    }
    
    if ( isdefined( struct.angles ) && struct.angles != ( 0, 0, 0 ) )
    {
        if ( istrue( var_edb06d254fff788c ) )
        {
            trigger.angles = struct.angles;
        }
        else
        {
            trigger.angles = ( -90, 0, 0 ) + struct.angles;
        }
    }
    
    trigger.struct = struct;
    
    if ( isdefined( self.objects ) )
    {
        self.objects[ self.objects.size ] = trigger;
    }
    
    trigger strike_triggerassignvalues( struct );
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x191b
// Size: 0x254
function strike_triggerassignvalues( struct )
{
    if ( !isdefined( struct.angles ) )
    {
        struct.angles = ( 0, 0, 0 );
    }
    
    if ( isdefined( struct.script_label ) )
    {
        self.script_label = struct.script_label;
    }
    
    if ( isdefined( struct.script_function ) )
    {
        self.script_function = struct.script_function;
    }
    
    if ( isdefined( struct.script_noteworthy ) )
    {
        self.script_noteworthy = struct.script_noteworthy;
    }
    
    if ( isdefined( struct.script_gesture ) )
    {
        self.script_gesture = struct.script_gesture;
    }
    
    if ( isdefined( struct.target ) )
    {
        self.target = struct.target;
    }
    
    if ( isdefined( struct.script_wtf ) )
    {
        self.script_wtf = struct.script_wtf;
    }
    
    if ( isdefined( struct.script_flag ) )
    {
        self.script_flag = struct.script_flag;
    }
    
    if ( isdefined( struct.script_linkto ) )
    {
        self.script_linkto = struct.script_linkto;
    }
    
    if ( isdefined( struct.script_linkname ) )
    {
        self.script_linkname = struct.script_linkname;
    }
    
    if ( isdefined( struct.groupname ) )
    {
        self.groupname = struct.groupname;
    }
    
    if ( isdefined( struct.script_count ) )
    {
        self.script_count = struct.script_count;
    }
    
    if ( isdefined( struct.script_count_min ) )
    {
        self.script_count_min = struct.script_count_min;
    }
    
    if ( isdefined( struct.script_count_max ) )
    {
        self.script_count_max = struct.script_count_max;
    }
    
    if ( isdefined( struct.script_maxdist ) )
    {
        self.script_maxdist = struct.script_maxdist;
    }
    
    if ( isdefined( struct.script_parameters ) )
    {
        self.script_parameters = struct.script_parameters;
    }
    
    self.targetname = struct.targetname;
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 2
// Checksum 0x0, Offset: 0x1b77
// Size: 0x186
function strike_fixautokvps( struct, index )
{
    if ( isdefined( struct.target ) && issubstr( struct.target, "auto" ) )
    {
        struct.target = "CS|" + index + struct.target;
    }
    
    if ( isdefined( struct.targetname ) && issubstr( struct.targetname, "auto" ) )
    {
        struct.targetname = "CS|" + index + struct.targetname;
    }
    
    if ( isdefined( struct.script_linkto ) )
    {
        new_linkto = "";
        str_toks = strtok( struct.script_linkto, " " );
        
        foreach ( new_index, tok in str_toks )
        {
            if ( new_index != 0 )
            {
                new_linkto = new_linkto + " " + "CS|" + index + tok;
                continue;
            }
            
            new_linkto = new_linkto + "CS|" + index + tok;
        }
        
        struct.script_linkto = new_linkto;
    }
    
    if ( isdefined( struct.script_linkname ) )
    {
        struct.script_linkname = "CS|" + index + struct.script_linkname;
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x1d05
// Size: 0xb3c
function typecast_kvps( struct )
{
    if ( scripts\engine\utility::issharedfuncdefined( "createScript", "typeCast" ) )
    {
        if ( istrue( struct scripts\engine\utility::callsharedfunc( "createScript", "typeCast" ) ) )
        {
            return;
        }
    }
    
    if ( istrue( struct.ishelistruct ) )
    {
        if ( isdefined( struct.script_unload ) )
        {
            struct.script_unload = int( struct.script_unload );
        }
    }
    
    if ( isdefined( struct.script_wait_min ) )
    {
        struct.script_wait_min = float( struct.script_wait_min );
    }
    
    if ( isdefined( struct.script_wait_max ) )
    {
        struct.script_wait_max = float( struct.script_wait_max );
    }
    
    if ( isdefined( struct.script_wait_add ) )
    {
        struct.script_wait_add = float( struct.script_wait_add );
    }
    
    if ( isdefined( struct.script_brake ) )
    {
        struct.script_brake = float( struct.script_brake );
    }
    
    if ( isdefined( struct.var_9e5f6ca242b92628 ) )
    {
        struct.var_9e5f6ca242b92628 = int( struct.var_9e5f6ca242b92628 );
    }
    
    if ( isdefined( struct.lookahead ) )
    {
        struct.lookahead = int( struct.lookahead );
    }
    
    if ( isdefined( struct.speed ) )
    {
        struct.speed = int( struct.speed );
    }
    
    if ( isdefined( struct.var_3f0312e6382c878f ) )
    {
        if ( struct.var_3f0312e6382c878f == "true" || struct.var_3f0312e6382c878f == "1" )
        {
            struct.var_3f0312e6382c878f = 1;
        }
        else
        {
            struct.var_3f0312e6382c878f = 0;
        }
    }
    
    if ( isdefined( struct.dont_enter_combat ) )
    {
        struct.dont_enter_combat = int( struct.dont_enter_combat );
    }
    
    if ( isdefined( struct.script_goalradius ) )
    {
        struct.script_goalradius = int( struct.script_goalradius );
    }
    
    if ( isdefined( struct.script_accel ) )
    {
        struct.script_accel = int( struct.script_accel );
    }
    
    if ( isdefined( struct.script_decel ) )
    {
        struct.script_decel = int( struct.script_decel );
    }
    
    if ( isdefined( struct.script_speed ) )
    {
        struct.script_speed = int( struct.script_speed );
    }
    
    if ( isdefined( struct.repeat_interaction ) )
    {
        struct.repeat_interaction = int( struct.repeat_interaction );
    }
    
    if ( isdefined( struct.script_goal_threshold ) )
    {
        struct.script_goal_threshold = float( struct.script_goal_threshold );
    }
    
    if ( isdefined( struct.var_3efdd073323b953c ) )
    {
        if ( struct.var_3efdd073323b953c == "true" || struct.var_3efdd073323b953c == "1" )
        {
            struct.var_3efdd073323b953c = 1;
        }
        else
        {
            struct.var_3efdd073323b953c = undefined;
        }
    }
    
    if ( isdefined( struct.script_goalyaw ) )
    {
        if ( struct.script_goalyaw == "true" || struct.script_goalyaw == "1" )
        {
            struct.script_goalyaw = 1;
        }
        else
        {
            struct.script_goalyaw = undefined;
        }
    }
    
    if ( isdefined( struct.script_anglevehicle ) )
    {
        if ( struct.script_anglevehicle == "true" || struct.script_anglevehicle == "1" )
        {
            struct.script_goalyaw = 1;
        }
        else
        {
            struct.script_goalyaw = undefined;
        }
    }
    
    if ( isdefined( struct.script_delay ) )
    {
        struct.script_delay = float( struct.script_delay );
    }
    
    if ( isdefined( struct.script_onlyidle ) )
    {
        struct.script_onlyidle = int( struct.script_onlyidle );
    }
    
    if ( isdefined( struct.script_ignoreme ) )
    {
        struct.script_ignoreme = int( struct.script_ignoreme );
    }
    
    if ( isdefined( struct.script_ignoreall ) )
    {
        struct.script_ignoreall = int( struct.script_ignoreall );
    }
    
    if ( isdefined( struct.script_death ) )
    {
        struct.script_death = int( struct.script_death );
    }
    
    if ( isdefined( struct.script_wait ) )
    {
        struct.script_wait = float( struct.script_wait );
    }
    
    if ( isdefined( struct.script_forcespawn ) )
    {
        struct.script_forcespawn = int( struct.script_forcespawn );
    }
    
    if ( isdefined( struct.script_timer ) )
    {
        struct.script_timer = int( struct.script_timer );
    }
    
    if ( isdefined( struct.script_dist_only ) )
    {
        struct.script_dist_only = int( struct.script_dist_only ) * int( struct.script_dist_only );
    }
    
    if ( isdefined( struct.script_speed ) )
    {
        struct.script_speed = int( struct.script_speed );
    }
    
    if ( isdefined( struct.script_count ) )
    {
        struct.script_count = int( struct.script_count );
    }
    
    if ( isdefined( struct.script_radius ) )
    {
        struct.script_radius = int( struct.script_radius );
    }
    
    if ( isdefined( struct.script_delay_min ) )
    {
        struct.script_delay_min = float( struct.script_delay_min );
    }
    
    if ( isdefined( struct.script_delay_max ) )
    {
        struct.script_delay_max = float( struct.script_delay_max );
    }
    
    if ( isdefined( struct.script_escalation_level ) )
    {
        struct.script_escalation_level = int( struct.script_escalation_level );
    }
    
    if ( isdefined( struct.script_goalheight ) )
    {
        struct.script_goalheight = int( struct.script_goalheight );
    }
    
    if ( isdefined( struct.script_timeout ) )
    {
        struct.script_timeout = float( struct.script_timeout );
    }
    
    if ( isdefined( struct.script_pacifist ) )
    {
        struct.script_pacifist = int( struct.script_pacifist );
    }
    
    if ( isdefined( struct.script_forcespawn ) )
    {
        struct.script_forcespawn = int( struct.script_forcespawn );
    }
    
    if ( isdefined( struct.dontkilloff ) )
    {
        struct.dontkilloff = int( struct.dontkilloff );
    }
    
    if ( isdefined( struct.script_origin_other ) )
    {
        struct.script_origin_other = struct.script_origin_other;
    }
    
    if ( isdefined( struct.script_dot ) )
    {
        struct.script_dot = int( struct.script_dot );
    }
    
    if ( isdefined( struct.script_stopnode ) )
    {
        struct.script_stopnode = int( struct.script_stopnode );
    }
    
    if ( isdefined( struct.script_maxdist ) )
    {
        struct.script_maxdist = int( struct.script_maxdist );
    }
    
    if ( isdefined( struct.script_accuracy ) )
    {
        struct.script_accuracy = float( struct.script_accuracy );
    }
    
    if ( isdefined( struct.script_bcdialog ) )
    {
        struct.script_bcdialog = int( struct.script_bcdialog );
    }
    
    if ( isdefined( struct.script_fixednode ) )
    {
        struct.script_fixednode = int( struct.script_fixednode );
    }
    
    if ( isdefined( struct.script_pacifist ) )
    {
        struct.script_pacifist = int( struct.script_pacifist );
    }
    
    if ( isdefined( struct.script_moveoverride ) )
    {
        struct.script_moveoverride = int( struct.script_moveoverride );
    }
    
    if ( isdefined( struct.script_longdeath ) )
    {
        struct.script_longdeath = int( struct.script_longdeath );
    }
    
    if ( isdefined( struct.script_goalyaw ) )
    {
        struct.script_goalyaw = int( struct.script_goalyaw );
    }
    
    if ( isdefined( struct.script_forcegoal ) )
    {
        struct.script_forcegoal = int( struct.script_forcegoal );
    }
    
    if ( isdefined( struct.script_forcespawn ) )
    {
        struct.script_forcespawn = int( struct.script_forcespawn );
    }
    
    if ( isdefined( struct.script_useangles ) )
    {
        struct.script_useangles = int( struct.script_useangles );
    }
    
    if ( isdefined( struct.script_suspend ) )
    {
        struct.script_suspend = int( struct.script_suspend );
    }
    
    if ( isdefined( struct.count ) )
    {
        struct.count = int( struct.count );
    }
    
    if ( isdefined( struct.script_index ) )
    {
        struct.script_index = int( struct.script_index );
    }
    
    if ( isdefined( struct.script_faceangles ) )
    {
        if ( isstring( struct.script_faceangles ) && ( struct.script_faceangles == "true" || struct.script_faceangles == "1" ) )
        {
            struct.script_faceangles = 1;
        }
        
        if ( int( struct.script_faceangles ) != 0 )
        {
            struct.script_faceangles = 1;
        }
        else
        {
            struct.script_faceangles = undefined;
        }
    }
    
    if ( isdefined( struct.script_cleanexit ) )
    {
        if ( struct.script_cleanexit == "true" || struct.script_cleanexit == "1" )
        {
            struct.script_cleanexit = 1;
            return;
        }
        
        struct.script_cleanexit = undefined;
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 0
// Checksum 0x0, Offset: 0x2849
// Size: 0x34
function cs_is_starttime()
{
    if ( utility::iscp() )
    {
        return ( gettime() <= level.starttime + 250 );
    }
    
    return gettime() <= level.starttimeutcseconds + 250;
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x2885
// Size: 0x73
function cs_init_flags( newitem )
{
    if ( !flag_exist( "strike_init_done" ) )
    {
        flag_init( "strike_init_done" );
    }
    
    if ( !flag_exist( "create_script_initialized" ) )
    {
        flag_init( "create_script_initialized" );
    }
    
    newitem.objects = [];
    newitem ent_flag_init( "cs_structs_complete" );
    newitem ent_flag_init( "cs_models_complete" );
    newitem ent_flag_init( "cs_triggers_complete" );
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x2900
// Size: 0x59
function cs_flags_init( newitem )
{
    if ( !flag_exist( "strike_init_done" ) )
    {
        flag_init( "strike_init_done" );
    }
    
    if ( !flag_exist( "create_script_initialized" ) )
    {
        flag_init( "create_script_initialized" );
    }
    
    newitem.objects = [];
    newitem ent_flag_init( "cs_objects_created" );
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 2
// Checksum 0x0, Offset: 0x2961
// Size: 0x86
function wait_for_flags( newitem, complete_flag )
{
    if ( newitem ent_flag_exist( "cs_structs_complete" ) )
    {
        newitem ent_flag_wait( "cs_structs_complete" );
    }
    
    if ( newitem ent_flag_exist( "cs_triggers_complete" ) )
    {
        newitem ent_flag_wait( "cs_triggers_complete" );
    }
    
    if ( newitem ent_flag_exist( "cs_objects_created" ) )
    {
        newitem ent_flag_wait( "cs_objects_created" );
    }
    
    flag_set( complete_flag + "_completed" );
    
    if ( cs_is_starttime() )
    {
        endcreatescript( newitem );
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x29ef
// Size: 0x6c
function endcreatescript( newitem )
{
    if ( isdefined( level.createscriptfilesinitialized ) )
    {
        level.createscriptfilesinitialized++;
        
        if ( level.createscriptfilesinitialized >= level.scripted_spawner_func.size )
        {
            flag_set( "strike_init_done" );
            flag_set( "create_script_initialized" );
        }
        
        return;
    }
    
    flag_set( "strike_init_done" );
    flag_set( "create_script_initialized" );
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x2a63
// Size: 0x39
function wait_for_cs_flag( waittill_flag )
{
    level endon( "game_ended" );
    flag_init( waittill_flag + "_completed" );
    
    if ( !should_wait_for_cs_flag( waittill_flag ) )
    {
        endcreatescript();
        flag_wait( waittill_flag );
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x2aa4
// Size: 0x8d, Type: bool
function should_wait_for_cs_flag( waittill_flag )
{
    toks = strtok( getdvar( @"hash_db88b998734440cc", "" ), " " );
    toks = array_combine( toks, level.active_cs_files );
    
    if ( toks.size < 1 )
    {
        return true;
    }
    
    for ( i = 0; i < toks.size ; i++ )
    {
        tok = toks[ i ];
        
        if ( tok == "all" )
        {
            return true;
        }
        
        if ( waittill_flag == tok )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 3
// Checksum 0x0, Offset: 0x2b3a
// Size: 0x3f
function register_cs_offsets( cs_file, origin_offset, angle_offset )
{
    if ( isdefined( origin_offset ) )
    {
        level.cs_origin_offset[ cs_file ] = origin_offset;
    }
    
    if ( isdefined( angle_offset ) )
    {
        level.cs_angle_offset[ cs_file ] = angle_offset;
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x2b81
// Size: 0x21
function set_cs_file_dvar( file_name )
{
    level.active_cs_files[ level.active_cs_files.size ] = file_name;
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x2baa
// Size: 0xc8
function cleanup_cs_file_objects( cs_file )
{
    flag_clear( cs_file + "_completed" );
    flag_clear( cs_file );
    
    if ( isdefined( level.cs_object_container[ cs_file ] ) && isdefined( level.cs_object_container[ cs_file ].objects ) )
    {
        temp_array = level.cs_object_container[ cs_file ].objects;
        
        for ( i = 0; i < temp_array.size ; i++ )
        {
            object = temp_array[ i ];
            level.cs_object_container[ cs_file ].objects[ i ] = undefined;
            
            if ( isstruct( object ) )
            {
                deletestruct_ref( object );
            }
            
            if ( isent( object ) )
            {
                object delete();
            }
        }
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2c7a
// Size: 0x182
function private clean_cs_file_structs_array( type, cs_file )
{
    if ( !flag_exist( "clean_cs_file_structs_array" ) )
    {
        level.var_f21943413f226f76 = 0;
        flag_init( "clean_cs_file_structs_array" );
    }
    else
    {
        while ( level.var_f21943413f226f76 )
        {
            flag_wait( "clean_cs_file_structs_array" );
        }
        
        flag_clear( "clean_cs_file_structs_array" );
    }
    
    level.var_f21943413f226f76 = 1;
    typekeys = getarraykeys( level.struct_class_names[ type ] );
    waitframe();
    var_de8e12bdbe3a8729 = 50;
    var_5f8f62a5487a6e5d = 0;
    
    for ( targetnameindex = 0; targetnameindex < typekeys.size ; targetnameindex++ )
    {
        newarray = [];
        
        if ( targetnameindex % var_de8e12bdbe3a8729 == 0 )
        {
            waitframe();
        }
        
        typekey = typekeys[ targetnameindex ];
        typekeysize = level.struct_class_names[ type ][ typekey ].size;
        
        for ( index = 0; index < typekeysize ; index++ )
        {
            struct = level.struct_class_names[ type ][ typekey ][ index ];
            
            if ( isdefined( struct ) && ( !isdefined( struct.cs_flag ) || struct.cs_flag != cs_file ) )
            {
                newarray[ newarray.size ] = struct;
                continue;
            }
            
            var_5f8f62a5487a6e5d++;
        }
        
        level.struct_class_names[ type ][ typekey ] = newarray;
    }
    
    flag_set( "clean_cs_file_structs_array" );
    level.var_f21943413f226f76 = 0;
    return var_5f8f62a5487a6e5d;
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x2e05
// Size: 0xa0
function function_71a564b3bc009618( cs_file )
{
    types = [ "targetname", "target", "script_noteworthy", "script_linkname", "variantname" ];
    var_5f8f62a5487a6e5d = 0;
    
    foreach ( type in types )
    {
        var_5f8f62a5487a6e5d += clean_cs_file_structs_array( type, cs_file );
        waitframe();
    }
    
    return var_5f8f62a5487a6e5d;
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 0
// Checksum 0x0, Offset: 0x2eae
// Size: 0x7
function s()
{
    return spawnstruct();
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x2ebe
// Size: 0x2aa
function spawn_cover_nodes( struct_targetname )
{
    node_structs = getstructarray( struct_targetname, "targetname" );
    
    foreach ( struct in node_structs )
    {
        if ( !isdefined( struct.angles ) )
        {
            struct.angles = ( 0, 0, 0 );
        }
        
        type = "Cover Stand";
        
        switch ( struct.nodetype )
        {
            case #"hash_4ddb655e251e06c8":
                type = "Cover Left";
                break;
            case #"hash_175771022bc5e75d":
                type = "Cover Right";
                break;
            case #"hash_9d76c99eddd14433":
                type = "Cover Crouch";
                break;
            case #"hash_f1676baca0ae608b":
                type = "Cover Stand";
                break;
            case #"hash_8c335d77517de4f8":
                type = "Cover Crouch Window";
                break;
            case #"hash_42d1769dd06f8045":
                type = "Conceal Crouch";
                break;
            case #"hash_a315be2e1164ff6b":
                type = "Exposed";
            case #"hash_d4850e4dfbc48417":
                type = "Turret";
                break;
        }
        
        targetname = undefined;
        
        if ( isdefined( struct.node_targetname ) )
        {
            targetname = struct.node_targetname;
        }
        
        spawnflags = 0;
        
        if ( isdefined( struct.nostand ) && int( struct.nostand ) != 0 && struct.nostand != "false" )
        {
            spawnflags = 4;
        }
        
        if ( isdefined( struct.nocrouch ) && int( struct.nocrouch ) != 0 && struct.nocrouch != "false" )
        {
            spawnflags += 8;
        }
        
        if ( isdefined( struct.noprone ) && int( struct.noprone ) != 0 && struct.noprone != "false" )
        {
            spawnflags += 16;
        }
        
        struct.covernode = spawncovernode( struct.origin, struct.angles, type, spawnflags, targetname );
        
        if ( isdefined( struct.radius ) )
        {
            struct.covernode.radius = struct.radius;
        }
    }
    
    return node_structs;
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 1
// Checksum 0x0, Offset: 0x3171
// Size: 0x90
function delete_covernodes( struct_targetname )
{
    node_structs = getstructarray( struct_targetname, "targetname" );
    
    foreach ( struct in node_structs )
    {
        if ( isdefined( struct.covernode ) )
        {
            despawncovernode( struct.covernode );
            struct.covernode = undefined;
        }
    }
}

// Namespace create_script_utility / scripts\common\create_script_utility
// Params 0
// Checksum 0x0, Offset: 0x3209
// Size: 0x28
function function_b055d49370405173()
{
    return_value = level.var_fd1365ce671037db;
    level.var_fd1365ce671037db++;
    return "cs" + return_value;
}

