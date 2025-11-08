#using scripts\common\createfx;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;

#namespace lights;

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x413
// Size: 0x24b
function init()
{
    generic_lights = getentarray( "script_light", "targetname" );
    toggle_lights = getentarray( "script_light_toggle", "targetname" );
    destructable_lights = getentarray( "script_light_destructable", "targetname" );
    flicker_lights = getentarray( "script_light_flicker", "targetname" );
    pulse_lights = getentarray( "script_light_pulse", "targetname" );
    double_strobe = getentarray( "generic_double_strobe", "targetname" );
    burning_trash_fire = getentarray( "burning_trash_fire", "targetname" );
    cine_tank_fire = getentarray( "cine_tank_fire", "targetname" );
    var_855b623bf1b4fb59 = getentarray( "generic_pulsing", "targetname" );
    array_thread( generic_lights, &init_light_generic_iw7 );
    array_thread( toggle_lights, &init_light_generic_iw7 );
    array_thread( destructable_lights, &init_light_destructable );
    array_thread( flicker_lights, &init_light_flicker );
    array_thread( pulse_lights, &init_light_pulse_iw7 );
    array_thread( double_strobe, &generic_double_strobe );
    array_thread( burning_trash_fire, &burning_trash_fire );
    array_thread( var_855b623bf1b4fb59, &generic_pulsing );
    array_thread( cine_tank_fire, &cine_tank_fire );
    lights = getentarray( "light_spot", "classname" );
    lights = array_combine( getentarray( "light_omni", "classname" ), lights );
    lights = array_combine( getentarray( "light", "classname" ), lights );
    
    foreach ( light in lights )
    {
        if ( !isdefined( light.script_type ) )
        {
            continue;
        }
        
        switch ( light.script_type )
        {
            case #"hash_f16db92e8d0bbd7e":
                light thread init_pulse();
                break;
            case #"hash_5775d4ce52daadc8":
                light thread init_strobe();
                break;
        }
    }
    
    /#
    #/
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x666
// Size: 0x26
function init_pulse()
{
    init_light();
    
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        return;
    }
    
    thread light_think();
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x694
// Size: 0x5e
function init_strobe()
{
    init_light();
    
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        return;
    }
    
    if ( !isdefined( self.script_delay2 ) && !isdefined( self.script_delay2_max ) && !isdefined( self.script_delay2_min ) )
    {
        self.script_delay2 = 0.1;
    }
    
    thread light_think();
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x6fa
// Size: 0x179
function light_think()
{
    self endon( "death" );
    off_frac = self.script_intensity < self.script_intensity2;
    start_frac = off_frac;
    
    if ( isdefined( self.script_flag ) && !flag( self.script_flag ) )
    {
        if ( isdefined( self.script_start_intensity ) )
        {
            set_lights_internal( self.script_start_intensity );
        }
        else if ( isdefined( self.script_start_state ) )
        {
            if ( self.script_start_state == "on" )
            {
                start_frac = !off_frac;
            }
        }
    }
    
    started = 0;
    
    while ( true )
    {
        if ( isdefined( self.script_flag ) )
        {
            if ( !flag( self.script_flag ) )
            {
                if ( !started )
                {
                    if ( self.script_start_state == "off" )
                    {
                        set_lights_internal( 0 );
                    }
                    else
                    {
                        set_light_values_by_frac( start_frac );
                    }
                }
                else if ( isdefined( self.script_clear_intensity ) )
                {
                    set_lights_internal( self.script_clear_intensity );
                }
                else
                {
                    set_light_values_by_frac( off_frac );
                }
                
                flag_wait( self.script_flag );
            }
        }
        
        if ( !started )
        {
            started = 1;
            start_delay();
        }
        
        switch ( self.script_type )
        {
            case #"hash_f16db92e8d0bbd7e":
                pulse();
                break;
            case #"hash_5775d4ce52daadc8":
                strobe();
                break;
        }
    }
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x87b
// Size: 0x74
function pulse()
{
    self endon( "death" );
    time = get_script_delay();
    
    if ( has_script_delay2() )
    {
        time = get_script_delay2();
    }
    else
    {
        time = get_script_delay();
    }
    
    light_lerp( time );
    
    if ( has_script_wait() )
    {
        script_wait();
    }
    
    if ( has_script_delay2() )
    {
        time = get_script_delay2();
    }
    else
    {
        time = get_script_delay();
    }
    
    light_lerp( time, 1 );
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x8f7
// Size: 0xb7
function strobe()
{
    self endon( "death" );
    set_light_values_by_frac( 1 );
    time = get_script_delay();
    wait time;
    count = get_script_loop();
    
    for ( i = 0; i < count ; i++ )
    {
        set_light_values_by_frac( 0 );
        
        if ( has_script_delay2() )
        {
            time = get_script_delay2();
        }
        else
        {
            time = get_script_delay();
        }
        
        wait time;
        set_light_values_by_frac( 1 );
        
        if ( i == count - 1 )
        {
            break;
        }
        
        if ( has_script_delay2() )
        {
            time = get_script_delay2();
        }
        else
        {
            time = get_script_delay();
        }
        
        wait time;
    }
    
    if ( has_script_wait() )
    {
        script_wait();
    }
}

// Namespace lights / scripts\sp\lights
// Params 2
// Checksum 0x0, Offset: 0x9b6
// Size: 0xe8
function light_lerp( time, invert )
{
    self endon( "death" );
    
    if ( !isdefined( invert ) )
    {
        invert = 0;
    }
    
    steps = int( time * 20 );
    intensity_inc = ( self.script_intensity - self.script_intensity2 ) / steps;
    color = undefined;
    color_inc = undefined;
    
    if ( has_script_color() )
    {
        color_inc = ( self.script_color - self.script_color2 ) / steps;
    }
    
    for ( i = 1; i < steps ; i++ )
    {
        if ( invert )
        {
            frac = 1 - i / steps;
        }
        else
        {
            frac = i / steps;
        }
        
        set_light_values_by_frac( frac );
        waitframe();
    }
    
    if ( invert )
    {
        frac = 0;
    }
    else
    {
        frac = 1;
    }
    
    set_light_values_by_frac( frac );
    waitframe();
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0xaa6
// Size: 0x67
function set_light_values_by_frac( frac )
{
    intensity = math::lerp( self.script_intensity2, self.script_intensity, frac );
    color = undefined;
    
    if ( has_script_color() )
    {
        color = vectorlerp( self.script_color, self.script_color2, frac );
    }
    
    set_lights_internal( intensity, color );
}

// Namespace lights / scripts\sp\lights
// Params 2
// Checksum 0x0, Offset: 0xb15
// Size: 0x94
function set_lights_internal( intensity, color )
{
    if ( isdefined( intensity ) )
    {
        self setlightintensity( intensity );
        
        if ( isdefined( self.linked_lights ) )
        {
            array_call( self.linked_lights, &setlightintensity, intensity );
        }
    }
    
    if ( isdefined( color ) )
    {
        self setlightcolor( color );
        
        if ( isdefined( self.linked_lights ) )
        {
            array_call( self.linked_lights, &setlightcolor, color );
        }
    }
    
    if ( intensity > 0.0001 )
    {
        set_light_parts_on();
        return;
    }
    
    if ( intensity < 0.0001 )
    {
        set_light_parts_off();
    }
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0xbb1
// Size: 0x189
function set_light_parts_on()
{
    ent_flag_set( "light_on" );
    
    if ( isdefined( self.script_prefab_exploder ) )
    {
        exploder( self.script_prefab_exploder );
    }
    
    if ( isdefined( self.scriptables ) )
    {
        foreach ( scriptable in self.scriptables )
        {
            scriptable setscriptablepartstate( "onoff", "on" );
        }
    }
    
    array_call( self.models_unlit, &hide );
    
    foreach ( model in self.models_lit )
    {
        model show();
        
        if ( isdefined( model.script_fxid ) )
        {
            if ( isdefined( model.fxobj ) )
            {
                model.fxobj delete();
            }
            
            model.fxobj = spawnfx( getfx( model.script_fxid ), model.fx_origin, model.fx_forward, model.fx_up );
            triggerfx( model.fxobj );
            model.fxobj willneverchange();
        }
    }
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0xd42
// Size: 0x115
function set_light_parts_off()
{
    ent_flag_clear( "light_on" );
    
    if ( isdefined( self.script_prefab_exploder ) )
    {
        stop_exploder( self.script_prefab_exploder );
    }
    
    if ( isdefined( self.scriptables ) )
    {
        foreach ( scriptable in self.scriptables )
        {
            scriptable setscriptablepartstate( "onoff", "off" );
        }
    }
    
    foreach ( model in self.models_lit )
    {
        model hide();
        
        if ( isdefined( model.fxobj ) )
        {
            model.fxobj delete();
        }
    }
    
    array_call( self.models_unlit, &show );
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0xe5f
// Size: 0x459
function init_light()
{
    self.script_intensity = get_defined_value( [ self.script_intensity, self getlightintensity() ] );
    self.script_color = get_defined_value( [ self.script_color, self getlightcolor() ] );
    self.script_intensity2 = get_defined_value( [ self.script_intensity2, 0 ] );
    self.script_color2 = get_defined_value( [ self.script_color2 ] );
    self.script_notify_start = get_defined_value( [ self.script_notify_start ] );
    self.script_notify_stop = get_defined_value( [ self.script_notify_stop ] );
    self.script_startrunning = get_defined_value( [ self.script_startrunning ] );
    
    if ( !isdefined( self.script_delay ) && !isdefined( self.script_delay_max ) && !isdefined( self.script_delay_min ) )
    {
        self.script_delay = 0.8;
    }
    
    if ( !ent_flag_exist( "light_on" ) )
    {
        ent_flag_init( "light_on" );
    }
    
    self.models_lit = [];
    self.models_unlit = [];
    self.linked_lights = [];
    self.triggers = [];
    ents = get_linked_ents();
    
    foreach ( ent in ents )
    {
        if ( is_light_entity( ent ) )
        {
            self.linked_lights[ self.linked_lights.size ] = ent;
            continue;
        }
        
        if ( isdefined( ent.script_noteworthy ) && ent.script_noteworthy == "on" )
        {
            self.models_lit[ self.models_lit.size ] = ent;
            continue;
        }
        
        if ( isdefined( ent.script_noteworthy ) && ent.script_noteworthy == "off" )
        {
            self.models_unlit[ self.models_unlit.size ] = ent;
            continue;
        }
        
        if ( ent.code_classname == "trigger_multiple" || ent.code_classname == "trigger_once" )
        {
            self.triggers[ self.triggers.size ] = ent;
        }
    }
    
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        set_light_parts_off();
        set_lights_values( 0 );
        return;
    }
    
    flag_wait( "scriptables_ready" );
    
    if ( isdefined( self.target ) )
    {
        self.scriptables = getscriptablearray( self.target, "targetname" );
    }
    
    array_thread( self.triggers, &trigger_light, self );
    
    foreach ( model in self.models_lit )
    {
        if ( isdefined( model.script_fxid ) )
        {
            if ( isdefined( model.script_offset ) )
            {
                origin = model.origin + model.script_offset;
            }
            else
            {
                origin = model.origin;
            }
            
            if ( isdefined( model.script_angles ) )
            {
                angles = model.angles + model.script_angles;
            }
            else
            {
                angles = model.angles;
            }
            
            model.fx_origin = origin;
            model.fx_forward = anglestoforward( angles );
            model.fx_up = anglestoup( angles );
            model.fxobj = spawnfx( getfx( model.script_fxid ), model.fx_origin, model.fx_forward, model.fx_up );
        }
    }
    
    self notify( "init_light_complete" );
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0x12c0
// Size: 0x77
function trigger_light( light )
{
    self endon( "death" );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "stop" )
    {
        note = "trigger_light_stop";
        light.trig_notify_stop = note;
    }
    else
    {
        note = "trigger_light_start";
        light.trig_notify_start = note;
    }
    
    self waittill( "trigger" );
    
    if ( isdefined( light ) )
    {
        light notify( note );
    }
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0x133f
// Size: 0x54
function get_defined_value( value_array )
{
    foreach ( value in value_array )
    {
        if ( isdefined( value ) )
        {
            return value;
        }
    }
    
    return undefined;
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x139c
// Size: 0x4f
function start_delay()
{
    if ( isdefined( self.script_startdelay_min ) && isdefined( self.script_startdelay_max ) )
    {
        wait randomfloatrange( self.script_startdelay_min, self.script_startdelay_max );
        return;
    }
    
    if ( isdefined( self.script_startdelay ) )
    {
        wait self.script_startdelay;
    }
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x13f3
// Size: 0x4f
function script_delay2()
{
    if ( isdefined( self.script_delay2_min ) && isdefined( self.script_delay2_max ) )
    {
        wait randomfloatrange( self.script_wait2_min, self.script_delay2_max );
        return;
    }
    
    if ( isdefined( self.script_delay2 ) )
    {
        wait self.script_delay2;
    }
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x144a
// Size: 0x50
function get_script_delay()
{
    if ( isdefined( self.script_delay_min ) && isdefined( self.script_delay_max ) )
    {
        return randomfloatrange( self.script_delay_min, self.script_delay_max );
    }
    else if ( isdefined( self.script_delay ) )
    {
        return self.script_delay;
    }
    
    return 0;
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x14a3
// Size: 0x50
function get_script_delay2()
{
    if ( isdefined( self.script_delay2_min ) && isdefined( self.script_delay2_max ) )
    {
        return randomfloatrange( self.script_delay2_min, self.script_delay2_max );
    }
    else if ( isdefined( self.script_delay2 ) )
    {
        return self.script_delay2;
    }
    
    return 0;
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x14fc
// Size: 0x51
function get_script_loop()
{
    if ( isdefined( self.script_count_min ) && isdefined( self.script_count_max ) )
    {
        return randomintrange( self.script_count_min, self.script_count_max );
    }
    else if ( isdefined( self.script_count ) )
    {
        return self.script_count;
    }
    
    return 1;
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x1556
// Size: 0x34, Type: bool
function has_script_delay2()
{
    if ( isdefined( self.script_delay2_min ) && isdefined( self.script_delay2_max ) )
    {
        return true;
    }
    else if ( isdefined( self.script_delay2 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x1593
// Size: 0x34, Type: bool
function has_script_wait()
{
    if ( isdefined( self.script_wait_min ) && isdefined( self.script_wait_max ) )
    {
        return true;
    }
    else if ( isdefined( self.script_wait ) )
    {
        return true;
    }
    
    return false;
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x15d0
// Size: 0x21, Type: bool
function has_script_color()
{
    if ( isdefined( self.script_color ) && isdefined( self.script_color2 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0x15fa
// Size: 0x164
function function_adb0429de1a7284( trigger )
{
    trigger endon( "death" );
    lights = getentarray( trigger.target, "targetname" );
    
    foreach ( light in lights )
    {
        light.og_intensity = light getlightintensity();
        light setlightintensity( 0 );
    }
    
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( "trigger", other );
        
        foreach ( light in lights )
        {
            light setlightintensity( light.og_intensity );
        }
        
        while ( other istouching( trigger ) )
        {
            wait 0.1;
        }
        
        foreach ( light in lights )
        {
            light setlightintensity( 0 );
        }
    }
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x1766
// Size: 0xab
function light_debug_thread()
{
    lights = getentarray( "light_spot", "classname" );
    lights = array_combine( getentarray( "light_omni", "classname" ), lights );
    
    while ( true )
    {
        clearundefined = 0;
        
        foreach ( light in lights )
        {
            if ( isdefined( light ) )
            {
                light light_debug_draw();
                continue;
            }
            
            clearundefined = 1;
        }
        
        if ( clearundefined )
        {
            lights = array_removeundefined( lights );
        }
        
        waitframe();
    }
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x1819
// Size: 0x3e
function light_debug_draw()
{
    if ( distancesquared( self.origin, level.player.origin ) < 2000 )
    {
        return;
    }
    
    light_debug_print3d( "Intensity: " + self getlightintensity() );
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0x185f
// Size: 0x3b
function light_debug_print3d( msg )
{
    if ( !isdefined( msg ) )
    {
        return;
    }
    
    /#
        print3d( self.origin, msg, ( 1, 1, 1 ), 0.8, 0.5 );
    #/
}

// Namespace lights / scripts\sp\lights
// Params 8
// Checksum 0x0, Offset: 0x18a2
// Size: 0x5b1
function init_light_generic_iw7( intensity_01, color_01, intensity_02, color_02, notify_start, notify_stop, start_running, only_init )
{
    if ( isdefined( self.script_type ) )
    {
        return;
    }
    
    wait 0.05;
    self.intensity_01 = get_defined_value( [ self.script_intensity_01, intensity_01, self getlightintensity() ] );
    self.color_01 = get_defined_value( [ self.script_color_01, color_01, self getlightcolor() ] );
    self.intensity_02 = get_defined_value( [ self.script_intensity_02, intensity_02, 0 ] );
    self.color_02 = get_defined_value( [ self.script_color_02, color_02, ( 0, 0, 0 ) ] );
    self.notify_start = get_defined_value( [ self.script_light_startnotify, notify_start ] );
    self.notify_stop = get_defined_value( [ self.script_light_stopnotify, notify_stop ] );
    self.start_running = get_defined_value( [ self.script_startrunning, start_running ] );
    self.light_type = get_defined_value( [ self.script_type, "generic" ] );
    self.delay_start = issubstr( self.light_type, "delaystart" );
    
    if ( !ent_flag_exist( "light_on" ) )
    {
        ent_flag_init( "light_on" );
    }
    
    self.lit_models = [];
    self.unlit_models = [];
    self.linked_lights = [];
    self.triggers = [];
    ents = get_linked_ents();
    
    foreach ( ent in ents )
    {
        if ( is_light_entity( ent ) )
        {
            self.linked_lights[ self.linked_lights.size ] = ent;
            continue;
        }
        
        if ( isdefined( ent.script_noteworthy ) && ent.script_noteworthy == "on" )
        {
            self.lit_models[ self.lit_models.size ] = ent;
            continue;
        }
        
        if ( isdefined( ent.script_noteworthy ) && ent.script_noteworthy == "off" )
        {
            self.unlit_models[ self.unlit_models.size ] = ent;
            continue;
        }
        
        if ( issubstr( ent.classname, "trigger" ) )
        {
            self.triggers[ self.triggers.size ] = ent;
        }
    }
    
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        set_lights_values( 0, ( 0, 0, 0 ) );
        return;
    }
    
    flag_wait( "scriptables_ready" );
    
    if ( isdefined( self.target ) )
    {
        self.scriptables = getscriptablearray( self.target, "targetname" );
    }
    
    if ( self.lit_models.size != 0 || self.unlit_models.size != 0 )
    {
        assert( self.lit_models.size > 0, "Dynamic light at " + self.origin + " needs to script_LinkTo a prefab contains at least 1 script_model script_noteworthy of 'on'" );
        assert( self.unlit_models.size > 0, "Dynamic light at " + self.origin + " needs to script_LinkTo a prefab contains at least 1 script_model script_noteworthy of 'off'" );
    }
    
    array_thread( self.triggers, &init_light_trig, self );
    
    foreach ( model in self.lit_models )
    {
        if ( isdefined( model.script_fxid ) )
        {
            model.effect = createoneshoteffect( model.script_fxid );
            mod_origin = ( 0, 0, 0 );
            mod_angles = ( 0, 0, 0 );
            
            if ( isdefined( model.script_parameters ) )
            {
                tokens = strtok( model.script_parameters, ", " );
                assertex( tokens.size >= 3, "lit_model script_parameters are expected to have three numbers for the offset" );
                mod_origin = ( float( tokens[ 0 ] ), float( tokens[ 1 ] ), float( tokens[ 2 ] ) );
                
                if ( tokens.size >= 6 )
                {
                    mod_angles = ( float( tokens[ 3 ] ), float( tokens[ 4 ] ), float( tokens[ 5 ] ) );
                }
            }
            
            model.effect scripts\common\createfx::set_origin_and_angles( model.origin + mod_origin, model.angles + mod_angles );
        }
    }
    
    self.init_complete = 1;
    self notify( "script_light_init_complete" );
    
    if ( isdefined( only_init ) && only_init )
    {
        return;
    }
    
    if ( isdefined( self.notify_start ) || isdefined( self.notify_stop ) || self.triggers.size > 0 )
    {
        thread light_toggle_loop();
    }
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x1e5b
// Size: 0x17
function init_light_destructable()
{
    if ( isdefined( self.script_type ) )
    {
        return;
    }
    
    init_light_generic_iw7();
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x1e7a
// Size: 0x241
function light_toggle_loop()
{
    self endon( "death" );
    self notify( "stop_script_light_loop" );
    self endon( "stop_script_light_loop" );
    
    if ( isdefined( self.start_running ) && self.start_running )
    {
        light_turn_on();
    }
    else if ( isdefined( self.notify_start ) || isdefined( self.trig_notify_start ) )
    {
        light_turn_off();
    }
    
    while ( true )
    {
        if ( !ent_flag( "light_on" ) )
        {
            level waittill_any( "FAKE_WAITTILL", self.trig_notify_start, self.notify_start );
            script_delay();
            
            if ( isdefined( self.delay_start ) )
            {
                if ( isdefined( self.script_delay ) )
                {
                    self.old_script_delay = self.script_delay;
                }
                
                if ( isdefined( self.script_delay_max ) )
                {
                    self.old_script_delay_max = self.script_delay_max;
                }
                
                if ( isdefined( self.script_delay_min ) )
                {
                    self.old_script_delay_min = self.script_delay_min;
                }
                
                self.script_delay = undefined;
                self.script_delay_max = undefined;
                self.script_delay_min = undefined;
            }
            
            light_turn_on();
        }
        
        level waittill_any( "FAKE_WAITTILL", self.trig_notify_stop, self.notify_stop );
        script_delay();
        
        if ( isdefined( self.delay_start ) )
        {
            if ( isdefined( self.script_delay ) )
            {
                self.old_script_delay = self.script_delay;
            }
            
            if ( isdefined( self.script_delay_max ) )
            {
                self.old_script_delay_max = self.script_delay_max;
            }
            
            if ( isdefined( self.script_delay_min ) )
            {
                self.old_script_delay_min = self.script_delay_min;
            }
            
            self.script_delay = undefined;
            self.script_delay_max = undefined;
            self.script_delay_min = undefined;
        }
        
        light_turn_off();
        
        if ( isdefined( self.old_script_delay ) )
        {
            self.script_delay = self.old_script_delay;
        }
        
        if ( isdefined( self.old_script_delay_max ) )
        {
            self.script_delay_max = self.old_script_delay_max;
        }
        
        if ( isdefined( self.old_script_delay_min ) )
        {
            self.script_delay_min = self.old_script_delay_min;
        }
        
        wait 0.05;
    }
}

// Namespace lights / scripts\sp\lights
// Params 15
// Checksum 0x0, Offset: 0x20c3
// Size: 0xdb
function init_light_flicker( intensity_01, color_01, wait_01_min, wait_01_max, intensity_02, color_02, wait_02_min, wait_02_max, speed_scale, notify_start, notify_stop, start_running, light_type, on_off_time, only_init )
{
    if ( isdefined( self.script_type ) )
    {
        return;
    }
    
    init_light_generic_iw7( intensity_01, color_01, intensity_02, color_02, notify_start, notify_stop, start_running, 1 );
    
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        return;
    }
    
    make_light_flicker( wait_01_min, wait_01_max, wait_02_min, wait_02_max, speed_scale, light_type, on_off_time );
    
    if ( isdefined( only_init ) && only_init )
    {
        return;
    }
    
    thread start_light_flicker();
}

// Namespace lights / scripts\sp\lights
// Params 7
// Checksum 0x0, Offset: 0x21a6
// Size: 0x31c
function make_light_flicker( wait_01_min, wait_01_max, wait_02_min, wait_02_max, speed_scale, light_type, on_off_time )
{
    init_light_type( light_type );
    self.speed_scale = get_defined_value( [ self.script_speed_scale, speed_scale, 1 ] );
    self.on_off_time = max( get_defined_value( [ self.script_duration, on_off_time, 3 ] ) / self.speed_scale, 0.25 );
    
    if ( isdefined( self.script_wait_01_min ) && isdefined( self.script_wait_01_max ) )
    {
        self.hi_wait = max( get_defined_value( [ self.script_wait_01_min, self.script_wait_01_max ] ) / self.speed_scale, 0.05 );
    }
    else
    {
        self.wait_01_min = max( get_defined_value( [ self.script_wait_01_min, wait_01_min, 0.05 ] ) / self.speed_scale, 0.05 );
        self.wait_01_max = max( get_defined_value( [ self.script_wait_01_max, wait_01_max, 0.1 ] ) / self.speed_scale, 0.1 );
        
        if ( self.wait_01_min > self.wait_01_max )
        {
            max = self.wait_01_max;
            self.wait_01_max = self.wait_01_min;
            self.wait_01_min = max;
            
            /#
                iprintln( "<dev string:x1c>" + self.origin + "<dev string:x26>" );
            #/
        }
    }
    
    if ( isdefined( self.script_wait_02_min ) && isdefined( self.script_wait_02_max ) )
    {
        self.lo_wait = max( get_defined_value( [ self.script_wait_02_min, self.script_wait_02_max ] ) / self.speed_scale, 0.05 );
        return;
    }
    
    self.wait_02_min = max( get_defined_value( [ self.script_wait_02_min, wait_02_min, 0.05 ] ) / self.speed_scale, 0.05 );
    self.wait_02_max = max( get_defined_value( [ self.script_wait_02_max, wait_02_max, 0.75 ] ) / self.speed_scale, 0.1 );
    
    if ( self.wait_02_min > self.wait_02_max )
    {
        max = self.wait_02_max;
        self.wait_02_max = self.wait_02_min;
        self.wait_02_min = max;
        
        /#
            iprintln( "<dev string:x1c>" + self.origin + "<dev string:x7b>" );
        #/
    }
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x24ca
// Size: 0x2e
function start_light_flicker()
{
    if ( self.type_on || self.type_off )
    {
        thread light_flicker_on_off_loop();
        return;
    }
    
    thread light_flicker_loop();
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x2500
// Size: 0x1f1
function light_flicker_loop()
{
    self endon( "death" );
    self notify( "stop_script_light_loop" );
    self endon( "stop_script_light_loop" );
    
    if ( isdefined( self.start_running ) && self.start_running )
    {
        light_turn_on();
    }
    else if ( isdefined( self.notify_start ) || isdefined( self.trig_notify_start ) )
    {
        light_turn_off( undefined, self.two_color );
    }
    
    if ( isdefined( self.notify_start ) && isdefined( self.notify_stop ) )
    {
        while ( true )
        {
            script_delay();
            
            if ( isdefined( self.delay_start ) )
            {
                if ( isdefined( self.script_delay ) )
                {
                    self.old_script_delay = self.script_delay;
                }
                
                if ( isdefined( self.script_delay_max ) )
                {
                    self.old_script_delay_max = self.script_delay_max;
                }
                
                if ( isdefined( self.script_delay_min ) )
                {
                    self.old_script_delay_min = self.script_delay_min;
                }
                
                self.script_delay = undefined;
                self.script_delay_max = undefined;
                self.script_delay_min = undefined;
            }
            
            light_flicker_proc();
            
            if ( isdefined( self.start_running ) && self.start_running )
            {
                light_turn_on();
            }
            else
            {
                light_turn_off( undefined, self.two_color );
            }
            
            if ( isdefined( self.old_script_delay ) )
            {
                self.script_delay = self.old_script_delay;
            }
            
            if ( isdefined( self.old_script_delay_max ) )
            {
                self.script_delay_max = self.old_script_delay_max;
            }
            
            if ( isdefined( self.old_script_delay_min ) )
            {
                self.script_delay_min = self.old_script_delay_min;
            }
            
            waitframe();
        }
        
        return;
    }
    
    light_flicker_proc();
    
    if ( isdefined( self.start_running ) && self.start_running )
    {
        light_turn_on();
        return;
    }
    
    light_turn_off( undefined, self.two_color );
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x26f9
// Size: 0x2e2
function light_flicker_on_off_loop()
{
    self endon( "death" );
    self notify( "stop_script_light_loop" );
    self endon( "stop_script_light_loop" );
    
    if ( isdefined( self.start_running ) && self.start_running )
    {
        light_turn_on();
    }
    else if ( isdefined( self.notify_start ) || isdefined( self.trig_notify_start ) )
    {
        light_turn_off( undefined, self.two_color );
    }
    
    while ( true )
    {
        if ( !ent_flag( "light_on" ) && ( isdefined( self.trig_notify_start ) || isdefined( self.notify_start ) ) )
        {
            level waittill_any( "FAKE_WAITTILL", self.trig_notify_start, self.notify_start );
        }
        
        script_delay();
        
        if ( isdefined( self.delay_start ) )
        {
            if ( isdefined( self.script_delay ) )
            {
                self.old_script_delay = self.script_delay;
            }
            
            if ( isdefined( self.script_delay_max ) )
            {
                self.old_script_delay_max = self.script_delay_max;
            }
            
            if ( isdefined( self.script_delay_min ) )
            {
                self.old_script_delay_min = self.script_delay_min;
            }
            
            self.script_delay = undefined;
            self.script_delay_max = undefined;
            self.script_delay_min = undefined;
        }
        
        if ( self.type_on && !ent_flag( "light_on" ) )
        {
            childthread light_flicker_proc( 1, self.random_intensity_on );
            
            if ( self.static_time )
            {
                wait self.on_off_time;
            }
            else
            {
                wait randomfloat( self.on_off_time );
            }
            
            self notify( "stop_flicker" );
        }
        
        light_turn_on();
        
        if ( !isdefined( self.notify_start ) && !isdefined( self.trig_notify_start ) )
        {
            return;
        }
        
        if ( !self.type_run )
        {
            level waittill_any( "FAKE_WAITTILL", self.trig_notify_stop, self.notify_stop );
        }
        else
        {
            light_flicker_proc( 1 );
        }
        
        if ( self.type_off )
        {
            childthread light_flicker_proc( 1, self.random_intensity_off );
            
            if ( self.static_time )
            {
                wait self.on_off_time;
            }
            else
            {
                wait randomfloat( self.on_off_time );
            }
            
            self notify( "stop_flicker" );
        }
        
        light_turn_off( undefined, self.two_color );
        
        if ( isdefined( self.old_script_delay ) )
        {
            self.script_delay = self.old_script_delay;
        }
        
        if ( isdefined( self.old_script_delay_max ) )
        {
            self.script_delay_max = self.old_script_delay_max;
        }
        
        if ( isdefined( self.old_script_delay_min ) )
        {
            self.script_delay_min = self.old_script_delay_min;
        }
        
        wait 0.05;
        
        if ( !isdefined( self.notify_start ) && !isdefined( self.notify_stop ) )
        {
            return;
        }
    }
}

// Namespace lights / scripts\sp\lights
// Params 2
// Checksum 0x0, Offset: 0x29e3
// Size: 0x10f
function light_flicker_proc( start_now, random_intensity )
{
    self notify( "stop_flicker" );
    self endon( "stop_flicker" );
    
    if ( isdefined( self.trig_notify_stop ) )
    {
        level endon( self.trig_notify_stop );
    }
    
    if ( isdefined( self.notify_stop ) )
    {
        level endon( self.notify_stop );
    }
    
    if ( !isdefined( start_now ) && ( isdefined( self.trig_notify_start ) || isdefined( self.notify_start ) ) )
    {
        level waittill_any( "FAKE_WAITTILL", self.trig_notify_start, self.notify_start );
    }
    
    while ( true )
    {
        light_turn_on( random_intensity );
        
        if ( isdefined( self.hi_wait ) )
        {
            wait self.hi_wait;
        }
        else
        {
            wait randomfloatrange( self.wait_01_min, self.wait_01_max );
        }
        
        light_turn_off( random_intensity );
        
        if ( isdefined( self.lo_wait ) )
        {
            wait self.lo_wait;
            continue;
        }
        
        wait randomfloatrange( self.wait_02_min, self.wait_02_max );
    }
}

// Namespace lights / scripts\sp\lights
// Params 15
// Checksum 0x0, Offset: 0x2afa
// Size: 0xdc
function init_light_pulse_iw7( intensity_01, color_01, wait_01_min, wait_01_max, intensity_02, color_02, wait_02_min, wait_02_max, speed_scale, notify_start, notify_stop, start_running, light_type, on_off_time, only_init )
{
    if ( isdefined( self.script_type ) )
    {
        return;
    }
    
    init_light_generic_iw7( intensity_01, color_01, intensity_02, color_02, notify_start, notify_stop, undefined, 1 );
    
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        return;
    }
    
    make_light_pulse( wait_01_min, wait_01_max, wait_02_min, wait_02_max, speed_scale, light_type, on_off_time, start_running );
    
    if ( isdefined( only_init ) && only_init )
    {
        return;
    }
    
    thread start_light_pulse();
}

// Namespace lights / scripts\sp\lights
// Params 8
// Checksum 0x0, Offset: 0x2bde
// Size: 0x410
function make_light_pulse( wait_01_min, wait_01_max, wait_02_min, wait_02_max, speed_scale, light_type, on_off_time, start_running )
{
    self.start_running = get_defined_value( [ self.script_startrunning, start_running, 1 ] );
    init_light_type( light_type );
    self.speed_scale = get_defined_value( [ self.script_speed_scale, speed_scale, 1 ] );
    self.on_off_time = max( get_defined_value( [ self.script_duration, on_off_time, 3 ] ) / self.speed_scale, 3 );
    
    if ( isdefined( self.script_wait_01_min ) && !isdefined( self.script_wait_01_max ) || !isdefined( self.script_wait_01_min ) && isdefined( self.script_wait_01_max ) )
    {
        self.hi_wait = max( get_defined_value( [ self.script_wait_01_min, self.script_wait_01_max ] ) / self.speed_scale, 0.05 );
    }
    else
    {
        self.wait_01_min = max( get_defined_value( [ self.script_wait_01_min, wait_01_min, 0.05 ] ) / self.speed_scale, 0.05 );
        self.wait_01_max = max( get_defined_value( [ self.script_wait_01_max, wait_01_max, 0.5 ] ) / self.speed_scale, 0.1 );
        
        if ( self.wait_01_min > self.wait_01_max )
        {
            max = self.wait_01_max;
            self.wait_01_max = self.wait_01_min;
            self.wait_01_min = max;
            
            /#
                iprintln( "<dev string:x1c>" + self.origin + "<dev string:x26>" );
            #/
        }
    }
    
    if ( isdefined( self.script_wait_02_min ) && !isdefined( self.script_wait_02_max ) || !isdefined( self.script_wait_02_min ) && isdefined( self.script_wait_02_max ) )
    {
        self.lo_wait = max( get_defined_value( [ self.script_wait_02_min, self.script_wait_02_max ] ) / self.speed_scale, 0.05 );
        steps = int( self.lo_wait * 20 );
        self.step_inc = 2 / steps;
        self.intensity_inc = 2 * ( self.intensity_01 - self.intensity_02 ) / steps;
        return;
    }
    
    self.wait_02_min = max( get_defined_value( [ self.script_wait_02_min, wait_02_min, 0.25 ] ) / self.speed_scale, 0.05 );
    self.wait_02_max = max( get_defined_value( [ self.script_wait_02_max, wait_02_max, 0.75 ] ) / self.speed_scale, 0.1 );
    
    if ( self.wait_02_min > self.wait_02_max )
    {
        max = self.wait_02_max;
        self.wait_02_max = self.wait_02_min;
        self.wait_02_min = max;
        
        /#
            iprintln( "<dev string:x1c>" + self.origin + "<dev string:x7b>" );
        #/
    }
    
    steps = int( self.wait_02_max * 20 );
    self.step_inc = 2 / steps;
    self.intensity_inc = 2 * ( self.intensity_01 - self.intensity_02 ) / steps;
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x2ff6
// Size: 0x2e
function start_light_pulse()
{
    if ( self.type_on || self.type_off )
    {
        thread light_pulse_on_off_loop();
        return;
    }
    
    thread light_pulse_loop();
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x302c
// Size: 0x105
function light_pulse_loop()
{
    self endon( "death" );
    self notify( "stop_script_light_loop" );
    self endon( "stop_script_light_loop" );
    
    if ( isdefined( self.start_running ) && self.start_running )
    {
        light_turn_on();
    }
    else if ( isdefined( self.notify_start ) || isdefined( self.trig_notify_start ) )
    {
        light_turn_off( undefined, self.two_color );
    }
    
    if ( isdefined( self.notify_start ) && isdefined( self.notify_stop ) )
    {
        while ( true )
        {
            light_pulse_proc_iw7();
            
            if ( isdefined( self.start_running ) && self.start_running )
            {
                light_turn_on();
            }
            else
            {
                light_turn_off( undefined, self.two_color );
            }
            
            waitframe();
        }
        
        return;
    }
    
    light_pulse_proc_iw7();
    
    if ( isdefined( self.start_running ) && self.start_running )
    {
        light_turn_on();
        return;
    }
    
    light_turn_off( undefined, self.two_color );
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x3139
// Size: 0x2cb
function light_pulse_on_off_loop()
{
    self endon( "death" );
    self notify( "stop_script_light_loop" );
    self endon( "stop_script_light_loop" );
    
    if ( isdefined( self.start_running ) && self.start_running )
    {
        light_turn_on();
    }
    else if ( isdefined( self.notify_start ) || isdefined( self.trig_notify_start ) )
    {
        light_turn_off( undefined, self.two_color );
    }
    
    while ( true )
    {
        if ( !ent_flag( "light_on" ) && ( isdefined( self.trig_notify_start ) || isdefined( self.notify_start ) ) )
        {
            level waittill_any( "FAKE_WAITTILL", self.trig_notify_start, self.notify_start );
        }
        
        script_delay();
        
        if ( isdefined( self.delay_start ) )
        {
            if ( isdefined( self.script_delay ) )
            {
                self.old_script_delay = self.script_delay;
            }
            
            if ( isdefined( self.script_delay_max ) )
            {
                self.old_script_delay_max = self.script_delay_max;
            }
            
            if ( isdefined( self.script_delay_min ) )
            {
                self.old_script_delay_min = self.script_delay_min;
            }
            
            self.script_delay = undefined;
            self.script_delay_max = undefined;
            self.script_delay_min = undefined;
        }
        
        if ( self.type_on && !ent_flag( "light_on" ) )
        {
            childthread light_pulse_proc_iw7( 1 );
            
            if ( self.static_time )
            {
                wait self.on_off_time;
            }
            else
            {
                wait randomfloat( self.on_off_time );
            }
            
            self notify( "stop_pulse" );
        }
        
        light_turn_on();
        
        if ( !isdefined( self.notify_start ) && !isdefined( self.trig_notify_start ) )
        {
            return;
        }
        
        if ( !self.type_run )
        {
            level waittill_any( "FAKE_WAITTILL", self.trig_notify_stop, self.notify_stop );
        }
        else
        {
            light_pulse_proc_iw7( 1 );
        }
        
        if ( self.type_off )
        {
            childthread light_pulse_proc_iw7( 1 );
            
            if ( self.static_time )
            {
                wait self.on_off_time;
            }
            else
            {
                wait randomfloat( self.on_off_time );
            }
            
            self notify( "stop_flicker" );
        }
        
        light_turn_off( undefined, self.two_color );
        
        if ( isdefined( self.old_script_delay ) )
        {
            self.script_delay = self.old_script_delay;
        }
        
        if ( isdefined( self.old_script_delay_max ) )
        {
            self.script_delay_max = self.old_script_delay_max;
        }
        
        if ( isdefined( self.old_script_delay_min ) )
        {
            self.script_delay_min = self.old_script_delay_min;
        }
        
        waitframe();
        
        if ( !isdefined( self.notify_start ) && !isdefined( self.notify_stop ) )
        {
            return;
        }
    }
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0x340c
// Size: 0x10a
function light_pulse_proc_iw7( start_now )
{
    self notify( "stop_pulse" );
    self endon( "stop_pulse" );
    
    if ( isdefined( self.trig_notify_stop ) )
    {
        level endon( self.trig_notify_stop );
    }
    
    if ( isdefined( self.notify_stop ) )
    {
        level endon( self.notify_stop );
    }
    
    if ( !isdefined( start_now ) && ( isdefined( self.trig_notify_start ) || isdefined( self.notify_start ) ) )
    {
        level waittill_any( "FAKE_WAITTILL", self.trig_notify_start, self.notify_start );
    }
    
    while ( true )
    {
        light_turn_on();
        
        if ( isdefined( self.hi_wait ) )
        {
            wait self.hi_wait;
        }
        else
        {
            wait randomfloatrange( self.wait_01_min, self.wait_01_max );
        }
        
        if ( isdefined( self.lo_wait ) )
        {
            light_pulse( self.lo_wait );
            continue;
        }
        
        light_pulse( randomfloatrange( self.wait_02_min, self.wait_02_max ) );
    }
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0x351e
// Size: 0x77
function init_light_trig( light )
{
    self endon( "death" );
    
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "stop" )
    {
        note = "trigger_light_stop";
        light.trig_notify_stop = note;
    }
    else
    {
        note = "trigger_light_start";
        light.trig_notify_start = note;
    }
    
    self waittill( "trigger" );
    
    if ( isdefined( light ) )
    {
        light notify( note );
    }
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0x359d
// Size: 0x176
function light_turn_on( random_intensity )
{
    ent_flag_set( "light_on" );
    
    if ( isdefined( random_intensity ) && random_intensity && self.intensity_01 > 0 )
    {
        set_lights_values( randomfloatrange( self.intensity_01 * 0.25, self.intensity_01 ), self.color_01 );
    }
    else
    {
        set_lights_values( self.intensity_01, self.color_01 );
    }
    
    if ( isdefined( self.script_prefab_exploder ) )
    {
        exploder( self.script_prefab_exploder );
    }
    
    foreach ( scriptable in self.scriptables )
    {
        scriptable setscriptablepartstate( "onoff", "on" );
    }
    
    array_call( self.unlit_models, &hide );
    
    foreach ( model in self.lit_models )
    {
        model show();
        
        if ( isdefined( model.effect ) )
        {
            model.effect restarteffect();
        }
    }
}

// Namespace lights / scripts\sp\lights
// Params 2
// Checksum 0x0, Offset: 0x371b
// Size: 0x1a2
function light_turn_off( random_intensity, two_color )
{
    ent_flag_clear( "light_on" );
    
    if ( isdefined( two_color ) && two_color )
    {
        set_lights_values( 0, ( 0, 0, 0 ) );
    }
    else if ( isdefined( random_intensity ) && random_intensity && self.intensity_02 > 0 )
    {
        set_lights_values( randomfloatrange( self.intensity_02 * 0.25, self.intensity_02 ), self.color_02 );
    }
    else
    {
        set_lights_values( self.intensity_02, self.color_02 );
    }
    
    if ( isdefined( self.script_prefab_exploder ) )
    {
        stop_exploder( self.script_prefab_exploder );
    }
    
    foreach ( scriptable in self.scriptables )
    {
        scriptable setscriptablepartstate( "onoff", "off" );
    }
    
    foreach ( model in self.lit_models )
    {
        model hide();
        
        if ( isdefined( model.effect ) )
        {
            model.effect pauseeffect();
        }
    }
    
    array_call( self.unlit_models, &show );
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0x38c5
// Size: 0x108
function light_pulse( pulse_time )
{
    ent_flag_clear( "light_on" );
    steps = int( pulse_time / 0.1 );
    
    for ( i = 1; i <= steps ; i++ )
    {
        new_intensity = max( 0, self.intensity_01 - self.intensity_inc * i );
        new_color = vectorlerp( self.color_01, self.color_02, self.step_inc * i );
        set_lights_values( new_intensity, new_color );
        wait 0.05;
    }
    
    for ( i = steps; i > 0 ; i-- )
    {
        new_intensity = max( 0, self.intensity_01 - self.intensity_inc * i );
        new_color = vectorlerp( self.color_01, self.color_02, self.step_inc * i );
        set_lights_values( new_intensity, new_color );
        wait 0.05;
    }
}

// Namespace lights / scripts\sp\lights
// Params 5
// Checksum 0x0, Offset: 0x39d5
// Size: 0x4d
function lights_turn_on( name, key, intensity, color, kill_loops )
{
    lights = getentarray( name, key );
    array_thread( lights, &turn_on_proc, intensity, color, kill_loops );
}

// Namespace lights / scripts\sp\lights
// Params 3
// Checksum 0x0, Offset: 0x3a2a
// Size: 0x175
function turn_on_proc( intensity, color, kill_loops )
{
    if ( !isdefined( self.init_complete ) )
    {
        self waittill( "script_light_init_complete" );
    }
    
    if ( isdefined( kill_loops ) && kill_loops )
    {
        self notify( "stop_script_light_loop" );
    }
    
    my_intensity = self.intensity_01;
    my_color = self.color_01;
    
    if ( isdefined( intensity ) )
    {
        my_intensity = intensity;
    }
    
    if ( isdefined( color ) )
    {
        my_color = color;
    }
    
    ent_flag_set( "light_on" );
    set_lights_values( my_intensity, my_color );
    
    foreach ( scriptable in self.scriptables )
    {
        scriptable setscriptablepartstate( "onoff", "on" );
    }
    
    array_call( self.unlit_models, &hide );
    
    foreach ( model in self.lit_models )
    {
        model show();
        
        if ( isdefined( model.effect ) )
        {
            model.effect restarteffect();
        }
    }
}

// Namespace lights / scripts\sp\lights
// Params 5
// Checksum 0x0, Offset: 0x3ba7
// Size: 0x4d
function lights_turn_off( name, key, intensity, color, kill_loops )
{
    lights = getentarray( name, key );
    array_thread( lights, &turn_off_proc, intensity, color, kill_loops );
}

// Namespace lights / scripts\sp\lights
// Params 3
// Checksum 0x0, Offset: 0x3bfc
// Size: 0x175
function turn_off_proc( intensity, color, kill_loops )
{
    if ( !isdefined( self.init_complete ) )
    {
        self waittill( "script_light_init_complete" );
    }
    
    if ( isdefined( kill_loops ) && kill_loops )
    {
        self notify( "stop_script_light_loop" );
    }
    
    my_intensity = self.intensity_02;
    my_color = self.color_02;
    
    if ( isdefined( intensity ) )
    {
        my_intensity = intensity;
    }
    
    if ( isdefined( color ) )
    {
        my_color = color;
    }
    
    ent_flag_clear( "light_on" );
    set_lights_values( my_intensity, my_color );
    
    foreach ( scriptable in self.scriptables )
    {
        scriptable setscriptablepartstate( "onoff", "off" );
    }
    
    foreach ( model in self.lit_models )
    {
        model hide();
        
        if ( isdefined( model.effect ) )
        {
            model.effect pauseeffect();
        }
    }
    
    array_call( self.unlit_models, &show );
}

// Namespace lights / scripts\sp\lights
// Params 2
// Checksum 0x0, Offset: 0x3d79
// Size: 0xa2
function set_lights_values( intensity, color )
{
    if ( isdefined( intensity ) )
    {
        intensity = max( 0, intensity );
    }
    
    if ( isdefined( color ) )
    {
        color = ( max( 0, color[ 0 ] ), max( 0, color[ 1 ] ), max( 0, color[ 2 ] ) );
    }
    
    if ( isdefined( intensity ) )
    {
        self setlightintensity( intensity );
        
        if ( isdefined( self.linked_lights ) )
        {
            array_call( self.linked_lights, &setlightintensity, intensity );
        }
    }
    
    if ( isdefined( color ) )
    {
        self setlightcolor( color );
        
        if ( isdefined( self.linked_lights ) )
        {
            array_call( self.linked_lights, &setlightcolor, color );
        }
    }
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0x3e23
// Size: 0x46, Type: bool
function is_light_entity( ent )
{
    return ent.classname == "light_spot" || ent.classname == "light_omni" || ent.classname == "light";
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0x3e72
// Size: 0x116
function init_light_type( light_type )
{
    self.light_type = get_defined_value( [ self.script_type, light_type, "generic" ] );
    self.two_color = issubstr( self.light_type, "two_color" );
    self.type_on = issubstr( self.light_type, "on" );
    self.type_off = issubstr( self.light_type, "off" );
    self.type_run = issubstr( self.light_type, "running" );
    self.static_time = issubstr( self.light_type, "timed" );
    self.delay_start = issubstr( self.light_type, "delaystart" );
    self.random_intensity_on = issubstr( self.light_type, "on_random_intensity" );
    self.random_intensity_off = issubstr( self.light_type, "off_random_intensity" );
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x3f90
// Size: 0x129
function generic_pulsing()
{
    if ( isdefined( self.script_type ) )
    {
        return;
    }
    
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        self setlightintensity( 0 );
        return;
    }
    
    on = self getlightintensity();
    off = 0.05;
    curr = on;
    transition_on = 0.3;
    transition_off = 0.6;
    increment_on = ( on - off ) / transition_on / 0.05;
    increment_off = ( on - off ) / transition_off / 0.05;
    
    for ( ;; )
    {
        time = 0;
        
        while ( time < transition_off )
        {
            curr -= increment_off;
            curr = clamp( curr, 0, 100 );
            self setlightintensity( curr );
            time += 0.05;
            wait 0.05;
        }
        
        wait 1;
        time = 0;
        
        while ( time < transition_on )
        {
            curr += increment_on;
            curr = clamp( curr, 0, 100 );
            self setlightintensity( curr );
            time += 0.05;
            wait 0.05;
        }
        
        wait 0.5;
    }
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x40c1
// Size: 0x1aa
function generic_double_strobe()
{
    if ( isdefined( self.script_type ) )
    {
        return;
    }
    
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        self setlightintensity( 0 );
        return;
    }
    
    on = self getlightintensity();
    off = 0.05;
    linked_models = 0;
    lit_model = undefined;
    unlit_model = undefined;
    linked_lights = 0;
    var_67c79fb91abcbe6e = [];
    
    if ( isdefined( self.script_noteworthy ) )
    {
        linked_things = getentarray( self.script_noteworthy, "targetname" );
        
        for ( i = 0; i < linked_things.size ; i++ )
        {
            if ( is_light_entity( linked_things[ i ] ) )
            {
                linked_lights = 1;
                var_67c79fb91abcbe6e[ var_67c79fb91abcbe6e.size ] = linked_things[ i ];
            }
            
            if ( linked_things[ i ].classname == "script_model" )
            {
                lit_model = linked_things[ i ];
                unlit_model = getent( lit_model.target, "targetname" );
                linked_models = 1;
            }
        }
    }
    
    for ( ;; )
    {
        self setlightintensity( off );
        
        if ( linked_models )
        {
            lit_model hide();
            unlit_model show();
        }
        
        wait 0.8;
        self setlightintensity( on );
        
        if ( linked_models )
        {
            lit_model show();
            unlit_model hide();
        }
        
        wait 0.1;
        self setlightintensity( off );
        
        if ( linked_models )
        {
            lit_model hide();
            unlit_model show();
        }
        
        wait 0.12;
        self setlightintensity( on );
        
        if ( linked_models )
        {
            lit_model show();
            unlit_model hide();
        }
        
        wait 0.1;
    }
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x4273
// Size: 0x6
function generic_spot()
{
    for ( ;; )
    {
        waitframe();
    }
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x4281
// Size: 0xcf
function burning_trash_fire()
{
    if ( isdefined( self.script_type ) )
    {
        return;
    }
    
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        self setlightintensity( 0 );
        return;
    }
    
    full = self getlightintensity();
    
    for ( old_intensity = full;  ; old_intensity = intensity )
    {
        intensity = randomfloatrange( full * 0.7, full * 1.2 );
        timer = randomfloatrange( 0.3, 0.6 );
        timer *= 20;
        
        for ( i = 0; i < timer ; i++ )
        {
            new_intensity = intensity * i / timer + old_intensity * ( timer - i ) / timer;
            self setlightintensity( new_intensity );
            wait 0.05;
        }
    }
}

// Namespace lights / scripts\sp\lights
// Params 0
// Checksum 0x0, Offset: 0x4358
// Size: 0xcf
function cine_tank_fire()
{
    if ( isdefined( self.script_type ) )
    {
        return;
    }
    
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        self setlightintensity( 0 );
        return;
    }
    
    full = self getlightintensity();
    
    for ( old_intensity = full;  ; old_intensity = intensity )
    {
        intensity = randomfloatrange( full * 0.7, full * 1.3 );
        timer = randomfloatrange( 0.1, 0.4 );
        timer *= 20;
        
        for ( i = 0; i < timer ; i++ )
        {
            new_intensity = intensity * i / timer + old_intensity * ( timer - i ) / timer;
            self setlightintensity( new_intensity );
            wait 0.05;
        }
    }
}

// Namespace lights / scripts\sp\lights
// Params 4
// Checksum 0x0, Offset: 0x442f
// Size: 0xa0
function strobelight( intensity0, intensity1, period, kill_flag )
{
    frequency = 360 / period;
    time = 0;
    
    while ( true )
    {
        interpolation = sin( time * frequency ) * 0.5 + 0.5;
        self setlightintensity( intensity0 + ( intensity1 - intensity0 ) * interpolation );
        wait 0.05;
        time += 0.05;
        
        if ( time > period )
        {
            time -= period;
        }
        
        if ( isdefined( kill_flag ) )
        {
            if ( flag( kill_flag ) )
            {
                return;
            }
        }
    }
}

// Namespace lights / scripts\sp\lights
// Params 4
// Checksum 0x0, Offset: 0x44d7
// Size: 0x3f
function changelightcolorto( targetcolor, totaltime, acceltime, deceltime )
{
    if ( !isdefined( acceltime ) )
    {
        acceltime = 0;
    }
    
    if ( !isdefined( deceltime ) )
    {
        deceltime = 0;
    }
    
    thread changelightcolortoworkerthread( targetcolor, totaltime, acceltime, deceltime );
}

// Namespace lights / scripts\sp\lights
// Params 4
// Checksum 0x0, Offset: 0x451e
// Size: 0x129
function changelightcolortoworkerthread( targetcolor, totaltime, acceltime, deceltime )
{
    startcolor = self getlightcolor();
    timefactor = 1 / ( totaltime * 2 - acceltime + deceltime );
    time = 0;
    
    if ( time < acceltime )
    {
        halfrate = timefactor / acceltime;
        
        while ( time < acceltime )
        {
            fraction = halfrate * time * time;
            self setlightcolor( vectorlerp( startcolor, targetcolor, fraction ) );
            wait 0.05;
            time += 0.05;
        }
    }
    
    while ( time < totaltime - deceltime )
    {
        fraction = timefactor * ( 2 * time - acceltime );
        self setlightcolor( vectorlerp( startcolor, targetcolor, fraction ) );
        wait 0.05;
        time += 0.05;
    }
    
    time = totaltime - time;
    
    if ( time > 0 )
    {
        halfrate = timefactor / deceltime;
        
        while ( time > 0 )
        {
            fraction = 1 - halfrate * time * time;
            self setlightcolor( vectorlerp( startcolor, targetcolor, fraction ) );
            wait 0.05;
            time -= 0.05;
        }
    }
    
    self setlightcolor( targetcolor );
}

// Namespace lights / scripts\sp\lights
// Params 2
// Checksum 0x0, Offset: 0x464f
// Size: 0xa5
function flickerlightintensity( mindelay, maxdelay )
{
    on = self getlightintensity();
    off = 0;
    curr = on;
    num = 0;
    
    for ( ;; )
    {
        for ( num = randomintrange( 1, 10 ); num ; num-- )
        {
            wait randomfloatrange( 0.05, 0.1 );
            
            if ( curr > 0.2 )
            {
                curr = randomfloatrange( 0, 0.3 );
            }
            else
            {
                curr = on;
            }
            
            self setlightintensity( curr );
        }
        
        self setlightintensity( on );
        wait randomfloatrange( mindelay, maxdelay );
    }
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0x46fc
// Size: 0x58
function sun_shadow_trigger( trigger )
{
    duration = 1;
    
    if ( isdefined( trigger.script_duration ) )
    {
        duration = trigger.script_duration;
    }
    
    while ( true )
    {
        trigger waittill( "trigger", other );
        trigger set_sun_shadow_params( duration );
    }
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0x475c
// Size: 0x186
function set_sun_shadow_params( duration )
{
    sunenable = getdvarint( @"sm_sunenable", 1 );
    sunshadowscale = getdvarfloat( @"sm_sunshadowscale", 1 );
    sunsamplesizenear = getdvarfloat( @"sm_sunsamplesizenear", 0.25 );
    qualityspotshadow = getdvarfloat( @"sm_qualityspotshadow", 1 );
    
    if ( isdefined( self.script_sunenable ) )
    {
        sunenable = self.script_sunenable;
    }
    
    if ( isdefined( self.script_sunshadowscale ) )
    {
        sunshadowscale = self.script_sunshadowscale;
    }
    
    if ( isdefined( self.script_sunsamplesizenear ) )
    {
        sunsamplesizenear = self.script_sunsamplesizenear;
    }
    
    sunsamplesizenear = min( max( 0.016, sunsamplesizenear ), 32 );
    
    if ( isdefined( self.script_qualityspotshadow ) )
    {
        qualityspotshadow = self.script_qualityspotshadow;
    }
    
    curr_sunenable = getdvarint( @"sm_sunenable", 1 );
    curr_sunshadowscale = getdvarfloat( @"sm_sunshadowscale", 1 );
    curr_qualityspotshadow = getdvarint( @"sm_qualityspotshadow", 1 );
    setsaveddvar( @"sm_sunenable", sunenable );
    setsaveddvar( @"sm_sunshadowscale", sunshadowscale );
    setsaveddvar( @"sm_qualityspotshadow", qualityspotshadow );
    lerp_sunsamplesizenear_overtime( sunsamplesizenear, duration );
}

// Namespace lights / scripts\sp\lights
// Params 2
// Checksum 0x0, Offset: 0x48ea
// Size: 0xce
function lerp_sunsamplesizenear_overtime( value, time )
{
    level notify( "changing_sunsamplesizenear" );
    level endon( "changing_sunsamplesizenear" );
    old_value = getdvarfloat( @"sm_sunsamplesizenear", 0.25 );
    
    if ( value == old_value )
    {
        return;
    }
    
    diff = value - old_value;
    times = time / 0.05;
    
    if ( times > 0 )
    {
        d = diff / times;
        v = old_value;
        
        for ( i = 0; i < times ; i++ )
        {
            v += d;
            setsaveddvar( @"sm_sunsamplesizenear", v );
            wait 0.05;
        }
    }
    
    setsaveddvar( @"sm_sunsamplesizenear", value );
}

// Namespace lights / scripts\sp\lights
// Params 2
// Checksum 0x0, Offset: 0x49c0
// Size: 0x104
function lerp_intensity( intensity, time )
{
    steps = int( time * 20 );
    curr = self getlightintensity();
    inc = ( intensity - curr ) / steps;
    
    for ( i = 0; i < steps ; i++ )
    {
        thread handle_linked_ents( intensity );
        self setlightintensity( curr + i * inc );
        wait 0.05;
    }
    
    lights[ 0 ] = self;
    
    if ( isdefined( self.linked_lights ) )
    {
        lights = array_combine( lights, self.linked_lights );
    }
    
    foreach ( light in lights )
    {
        light thread handle_linked_ents( intensity );
        light setlightintensity( intensity );
    }
}

// Namespace lights / scripts\sp\lights
// Params 1
// Checksum 0x0, Offset: 0x4acc
// Size: 0x1a1
function handle_linked_ents( intensity )
{
    if ( isdefined( self.script_threshold ) )
    {
        is_on = intensity > self.script_threshold;
        
        foreach ( ent in self.lit_models )
        {
            if ( is_on && !ent.visible )
            {
                ent.visible = is_on;
                ent show();
                
                if ( isdefined( ent.effect ) )
                {
                    ent.effect thread restarteffect();
                }
                
                continue;
            }
            
            if ( !is_on && ent.visible )
            {
                ent.visible = is_on;
                ent hide();
                
                if ( isdefined( ent.effect ) )
                {
                    ent.effect thread pauseeffect();
                }
            }
        }
        
        foreach ( ent in self.unlit_models )
        {
            if ( !is_on && !ent.visible )
            {
                ent.visible = 1;
                ent show();
                continue;
            }
            
            if ( is_on && ent.visible )
            {
                ent.visible = 0;
                ent hide();
            }
        }
    }
}

// Namespace lights / scripts\sp\lights
// Params 3
// Checksum 0x0, Offset: 0x4c75
// Size: 0x74
function light_fade( start_intensity, end_intensity, var_b7b721442aee559a )
{
    lasttimestamp = gettime();
    t = 0;
    
    while ( t <= var_b7b721442aee559a )
    {
        t += 0.05;
        var_a1714a9ae7915519 = math::lerp( start_intensity, end_intensity, t / var_b7b721442aee559a );
        self setlightintensity( var_a1714a9ae7915519 );
        waitframe();
    }
    
    self setlightintensity( end_intensity );
}

