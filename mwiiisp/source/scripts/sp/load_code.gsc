#using script_3254d90a426b13a0;
#using script_45d238a595862e40;
#using script_575fda2758b0a36e;
#using script_6a04c207a6c69f43;
#using scripts\common\ai;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\debug;
#using scripts\sp\dev;
#using scripts\sp\nvg\nvg_player;
#using scripts\sp\scripted_weapon_assignment;
#using scripts\sp\starts;
#using scripts\sp\utility;

#namespace load_code;

// Namespace load_code / scripts\sp\load_code
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x65f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_6999f162b67c3039", #"val", &pre_main, undefined );
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0x688
// Size: 0x9
function pre_main()
{
    function_8dbb468af531b648();
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0x699
// Size: 0xdb
function function_8dbb468af531b648()
{
    if ( isdefined( level.var_8dbb468af531b648 ) )
    {
        return;
    }
    
    val::register( "cg_drawcrosshair", 1, 0, "$self", &set_allow_crosshair, "$value" );
    val::register( "weapon_scanning", 1, 0, "$self", &function_f372a21bcb8fc73b, "$value" );
    val::register( "antigrav_float", 0, 1, "$self", &function_493c39f4df2e5b50, "$value" );
    val::register( "hands", 1, 0, "$self", &function_9a83d95d2b6bd514, "$value" );
    val::register( "show_legs_and_shadow", 1, 0, "$self", &function_6172dea499dc136a, "$value" );
    val::unregister( "nvg" );
    val::register( "nvg", 1, 0, "$self", &function_120c300530a9fb46, "$value" );
    level.var_8dbb468af531b648 = 1;
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0x77c
// Size: 0x1e
function init_values()
{
    if ( isdefined( level.values ) )
    {
        return;
    }
    
    val::pre_main();
    function_8dbb468af531b648();
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0x7a2
// Size: 0x6b
function init_level()
{
    assertex( !isdefined( level.script ), "level.script defined before load::main()" );
    scripts\sp\starts::init_starts();
    level.script = tolower( getdvar( @"g_mapname" ) );
    println( "<dev string:x1c>", level.script );
    level.framedurationseconds = level.frameduration / 1000;
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0x815
// Size: 0x197
function init_global_dvars()
{
    setsaveddvar( @"hash_1cc4e4a2542af7f5", "0" );
    setsaveddvar( @"hash_682a9bc40f96ca4a", "1" );
    setsaveddvar( @"hash_9b1982d1c7accfb2", !is_trials_level() );
    setsaveddvar( @"hash_1dde331a8e0153d8", 4 );
    setsaveddvar( @"hash_63eb1893f96ac98d", 4 );
    setsaveddvar( @"hash_79a0c60ce3306d67", "0.000 0.000 0.000 0.000" );
    setsaveddvar( @"hash_79a0c50ce3306b34", "0.882 0.882 0.882 1.000" );
    setsaveddvar( @"hash_79a0c80ce33071cd", "0.804 0.157 0.157 1.000" );
    setsaveddvar( @"hash_79a0c70ce3306f9a", "0.431 0.745 0.235 1.000" );
    setsaveddvar( @"hash_79a0c20ce330649b", "0.157 0.784 0.784 1.000" );
    setsaveddvar( @"hash_79a0c10ce3306268", "0.784 0.490 0.157 1.000" );
    setsaveddvar( @"hash_79a0c40ce3306901", "0.804 0.804 0.035 1.000" );
    setsaveddvar( @"hash_79a0c30ce33066ce", "0.000 0.000 0.000 0.000" );
    setdvarifuninitialized( @"hash_f07ae454d79d2299", !isdefined( level.gamemodebundle ) || !istrue( level.gamemodebundle.damagefeedback ) );
    setdvarifuninitialized( @"hash_46d6ca4c8b20782d", 0 );
    setdvarifuninitialized( @"hash_2fb5684532ad1a80", !isdefined( level.gamemodebundle ) || !istrue( level.gamemodebundle.hitmarkers ) );
    setsaveddvar( @"hash_191cc88f6727f6c8", 0 );
    setsaveddvar( @"hash_770dcc95c434a4a7", 1 );
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0x9b4
// Size: 0x12
function init_global_omnvars()
{
    setomnvar( "ui_gettocover_text", "game/get_to_cover" );
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0x9ce
// Size: 0xde
function init_global_precache()
{
    precacheshader( "black" );
    precacheshader( "white" );
    precacheshader( "overlay_static" );
    precachemodel( "fx" );
    precachemodel( "tag_origin" );
    precachemodel( "tag_laser" );
    precachemodel( "tag_ik_target_left" );
    precachemodel( "tag_ik_target_right" );
    precacherumble( "damage_heavy" );
    precacherumble( "damage_light" );
    precacherumble( "grenade_rumble" );
    precacherumble( "artillery_rumble" );
    precacherumble( "slide_start" );
    precacherumble( "slide_loop" );
    precacherumble( "leap_end" );
    precacheitem( "defaultweapon" );
    precacheshader( "widg_gradient_left_to_right" );
    precacheshader( "widg_gradient_right_to_left" );
    precacheshader( "widg_gradient_bottom_to_top" );
    precacheshader( "widg_gradient_top_to_bottom" );
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0xab4
// Size: 0x2ae
function init_funcs()
{
    create_func_ref( "useanimtree", &useanimtree );
    create_func_ref( "setanim", &setanim );
    create_func_ref( "setanimknob", &setanimknob );
    create_func_ref( "setflaggedanimknob", &setflaggedanimknob );
    create_func_ref( "setflaggedanimknobrestart", &setflaggedanimknobrestart );
    create_func_ref( "setanimlimited", &setanimlimited );
    create_func_ref( "setanimtime", &setanimtime );
    create_func_ref( "getanimtime", &getanimtime );
    create_func_ref( "getanimlength", &getanimlength );
    create_func_ref( "clearanim", &clearanim );
    create_func_ref( "kill", &kill );
    create_func_ref( "magicgrenade", &magicgrenade );
    create_func_ref( "connectPaths", &connectpaths );
    create_func_ref( "disconnectPaths", &disconnectpaths );
    create_func_ref( "makeEntitySentient", &makeentitysentient );
    create_func_ref( "laserForceOn", &laserforceon );
    create_func_ref( "laserForceOff", &laserforceoff );
    create_func_ref( "badPlaceDelete", &badplace_delete );
    create_func_ref( "badPlaceCylinder", &badplace_cylinder );
    create_func_ref( "freeEntitySentient", &freeentitysentient );
    create_func_ref( "stat_track_kill_func", &laserforceoff );
    create_func_ref( "laserForceOff", &laserforceoff );
    create_func_ref( "getspawner", &getspawner );
    create_func_ref( "ai_has_color", &has_color );
    create_func_ref( "playsound_on_tag", &play_sound_on_tag );
    create_func_ref( "playloopsound_on_tag", &play_loop_sound_on_tag );
    create_func_ref( "playsound_on_entity", &play_sound_on_entity );
    create_func_ref( "playloopsound_on_entity", &play_loop_sound_on_entity );
    create_func_ref( "display_hint", &display_hint );
    create_func_ref( "add_hint_string", &add_hint_string );
    create_func_ref( "spawn_ai", &spawn_ai );
    create_func_ref( "spawn_failed", &spawn_failed );
    create_func_ref( "dronespawn_bodyonly", &dronespawn_bodyonly );
    create_func_ref( "bodyonlyspawn", &bodyonlyspawn );
    scripts\engine\sp\utility::setupglobalcallbackfunctions_sp();
    scripts\common\visibility_mode::main( &namespace_c9004e665a1c17b4::function_764239e6a246c46a );
    level.dopickyautosavechecks = 1;
    level.autosave_threat_check_enabled = 1;
    level.getnodefunction = &getnode;
    level.getnodearrayfunction = &getnodearray;
    level.addaieventlistener_func = &addaieventlistener;
    level.getspawnerarrayfunction = &getspawnerarray;
    level.fnbuildweapon = &make_weapon;
    level.fnbuildweaponspecial = &make_weapon_special;
    level.fnscriptedweaponassignment = &scripts\sp\scripted_weapon_assignment::getscriptedweapon;
    
    if ( getprojectname() != "T10" )
    {
        namespace_689de5b2bc60d21a::function_2fce2f81588a2462();
    }
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0xd6a
// Size: 0x4f
function init_global_variables()
{
    if ( !isdefined( level.missionfailed ) )
    {
        level.missionfailed = 0;
    }
    
    if ( !isdefined( level.g_effect ) )
    {
        level.g_effect = [];
    }
    
    if ( !isdefined( level.var_e58efb25be1ee016 ) )
    {
        level.var_e58efb25be1ee016 = 0;
    }
    
    thread do_level_first_frame();
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0xdc1
// Size: 0x42
function init_objective_colors()
{
    my_textbrightness_default = "1.0 1.0 1.0";
    my_textbrightness_90 = "0.9 0.9 0.9";
    var_2e56954df5eab66a = "0.85 0.85 0.85";
    setsaveddvar( @"con_typewritercolorbase", my_textbrightness_default );
}

// Namespace load_code / scripts\sp\load_code
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xe0b
// Size: 0x1c
function private set_allow_crosshair( b_value )
{
    if ( !isdefined( b_value ) )
    {
        b_value = 0;
    }
    
    childthread set_allow_crosshair_delayed( b_value );
}

// Namespace load_code / scripts\sp\load_code
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xe2f
// Size: 0x2b
function private set_allow_crosshair_delayed( b_value )
{
    self notify( "set_allow_crosshair_delayed" );
    self endon( "set_allow_crosshair_delayed" );
    waitframe();
    setsaveddvar( @"cg_drawcrosshair", b_value );
}

// Namespace load_code / scripts\sp\load_code
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xe62
// Size: 0x32
function private function_f372a21bcb8fc73b( b_value )
{
    if ( !isdefined( b_value ) )
    {
        b_value = 0;
    }
    
    if ( b_value )
    {
        flag_clear( "weapon_scanning_off" );
        return;
    }
    
    flag_set( "weapon_scanning_off" );
}

// Namespace load_code / scripts\sp\load_code
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xe9c
// Size: 0x71
function private function_493c39f4df2e5b50( b_value )
{
    if ( !isdefined( b_value ) )
    {
        b_value = 1;
    }
    
    if ( b_value )
    {
        level.player ent_flag_clear( "disable_antigrav_float" );
        return;
    }
    
    if ( !level.player ent_flag_exist( "disable_antigrav_float" ) )
    {
        level.player ent_flag_init( "disable_antigrav_float" );
    }
    
    level.player ent_flag_set( "disable_antigrav_float" );
}

// Namespace load_code / scripts\sp\load_code
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xf15
// Size: 0x1c
function private function_9a83d95d2b6bd514( b_value )
{
    if ( !isdefined( b_value ) )
    {
        b_value = 0;
    }
    
    self sethandsoccupied( !b_value );
}

// Namespace load_code / scripts\sp\load_code
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xf39
// Size: 0x49
function private function_120c300530a9fb46( value )
{
    assert( isplayer( self ), "cannot allow nvg on a non-player" );
    
    if ( !isdefined( value ) )
    {
        value = 1;
    }
    
    if ( value != 1 )
    {
        thread scripts\sp\nvg\nvg_player::disable_nvg_proc( 1, value == -1 );
        return;
    }
    
    thread scripts\sp\nvg\nvg_player::disable_nvg_proc( 0 );
}

// Namespace load_code / scripts\sp\load_code
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xf8a
// Size: 0x2a
function private function_6172dea499dc136a( b_value )
{
    if ( !isdefined( b_value ) )
    {
        b_value = 1;
    }
    
    if ( istrue( b_value ) )
    {
        self showlegsandshadow();
        return;
    }
    
    self hidelegsandshadow();
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0xfbc
// Size: 0x1e
function do_level_first_frame()
{
    level.first_frame = 1;
    wait 0.05;
    level.first_frame = -1;
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0xfe2
// Size: 0x68
function post_load_functions()
{
    flag_set( "load_finished" );
    
    if ( isdefined( level.post_load_funcs ) )
    {
        foreach ( func in level.post_load_funcs )
        {
            [[ func ]]();
        }
    }
}

/#

    // Namespace load_code / scripts\sp\load_code
    // Params 0
    // Checksum 0x0, Offset: 0x1052
    // Size: 0x2c, Type: dev
    function function_b265d5c7cc69cb92()
    {
        function_851b7e474a5af3e7();
        createprintchannel( "<dev string:x2b>" );
        scripts\sp\debug::function_90f1dceaf8276e36();
        scripts\sp\debug::maindebug();
        scripts\sp\dev::init();
    }

    // Namespace load_code / scripts\sp\load_code
    // Params 0
    // Checksum 0x0, Offset: 0x1086
    // Size: 0xc, Type: dev
    function function_165238c37df21055()
    {
        scripts\sp\debug::maindebugpostload();
    }

#/

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0x109a
// Size: 0x4d
function load_binks()
{
    if ( is_default_start() )
    {
        index = namespace_d6cca25f4b0ab62::getlevelindex( level.script );
        
        if ( isdefined( index ) )
        {
            bink = namespace_d6cca25f4b0ab62::getlevelbink( index );
            
            if ( isdefined( bink ) )
            {
                setomnvar( "ui_transition_movie", bink );
            }
        }
    }
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0x10ef
// Size: 0x38
function delete_on_load()
{
    array_delete( getentarray( "delete_on_load", "targetname" ) );
    delaythread( 0.05, &array_delete, getentarray( "delete_on_firstframeend", "targetname" ) );
}

// Namespace load_code / scripts\sp\load_code
// Params 0
// Checksum 0x0, Offset: 0x112f
// Size: 0x23
function post_cl_pregame()
{
    while ( getdvarint( @"cl_pregame" ) )
    {
        waitframe();
    }
    
    flag_set( "post_cl_pregame" );
}

