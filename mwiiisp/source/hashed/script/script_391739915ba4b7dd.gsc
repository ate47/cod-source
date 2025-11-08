#using script_6c1b22ea36b176be;
#using scripts\common\values;
#using scripts\cp\cp_compass;
#using scripts\cp\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\player;

#namespace namespace_fad6b63f0287902;

// Namespace namespace_fad6b63f0287902 / namespace_16d9c1530a364ee9
// Params 0
// Checksum 0x0, Offset: 0x29a
// Size: 0x73
function init_script_triggers()
{
    trigger_classes = get_load_trigger_classes();
    
    foreach ( function in trigger_classes )
    {
        triggers = getentarray( classname, "classname" );
        array_levelthread( triggers, function );
    }
}

// Namespace namespace_fad6b63f0287902 / namespace_16d9c1530a364ee9
// Params 0
// Checksum 0x0, Offset: 0x315
// Size: 0x9e
function get_load_trigger_classes()
{
    trigger_classes = [];
    trigger_classes[ "trigger_multiple_stealth_shadow" ] = &trigger_stealth_shadow;
    trigger_classes[ "trigger_multiple_fx_fxzone" ] = &trigger_flag_set_touching;
    trigger_classes[ "trigger_multiple_flag_set" ] = &trigger_flag_set;
    trigger_classes[ "trigger_multiple_flag_set_touching" ] = &trigger_flag_set_touching;
    trigger_classes[ "trigger_multiple_flag_clear" ] = &trigger_flag_clear;
    trigger_classes[ "trigger_radius_flag_set" ] = &trigger_flag_set;
    trigger_classes[ "trigger_radius_flag_clear" ] = &trigger_flag_clear;
    trigger_classes[ "trigger_use_flag_set" ] = &trigger_flag_set;
    trigger_classes[ "trigger_use_flag_clear" ] = &trigger_flag_clear;
    trigger_classes[ "trigger_multiple_slide" ] = &namespace_7b69f911b6d80230::trigger_slide;
    trigger_classes[ "trigger_multiple_set_minimap_floor" ] = &function_1dd1344e1eaa3ff1;
    return trigger_classes;
}

// Namespace namespace_fad6b63f0287902 / namespace_16d9c1530a364ee9
// Params 1
// Checksum 0x0, Offset: 0x3bc
// Size: 0xa6
function trigger_stealth_shadow( trigger )
{
    trigger endon( "death" );
    the_flag = "stealth_in_shadow";
    
    if ( !isdefined( level.trigger_stealth_shadow ) )
    {
        level.trigger_stealth_shadow = [];
    }
    
    level.trigger_stealth_shadow[ level.trigger_stealth_shadow.size ] = trigger;
    registerstealthshadowtrigger( trigger );
    
    while ( true )
    {
        trigger waittill( "trigger", other );
        
        if ( trigger function_5b4909bf3b589e4f( other ) )
        {
            continue;
        }
        
        if ( !other ent_flag_exist( the_flag ) )
        {
            continue;
        }
        
        if ( other ent_flag( the_flag ) )
        {
            continue;
        }
        
        other thread in_shadow_thread( trigger, the_flag );
    }
}

// Namespace namespace_fad6b63f0287902 / namespace_16d9c1530a364ee9
// Params 2
// Checksum 0x0, Offset: 0x46a
// Size: 0x43
function in_shadow_thread( volume, the_flag )
{
    self endon( "death" );
    scripts\stealth\player::function_e403865f115834a8( the_flag );
    
    while ( isdefined( volume ) && self istouching( volume ) )
    {
        wait 0.05;
    }
    
    scripts\stealth\player::function_3718fc282393305( the_flag );
}

// Namespace namespace_fad6b63f0287902 / namespace_16d9c1530a364ee9
// Params 0
// Checksum 0x0, Offset: 0x4b5
// Size: 0x4f
function get_trigger_flag()
{
    if ( isdefined( self.script_flag ) )
    {
        return self.script_flag;
    }
    
    if ( isdefined( self.script_noteworthy ) )
    {
        return self.script_noteworthy;
    }
    
    assertex( 0, "Flag trigger at " + self.origin + " has no script_flag set." );
}

// Namespace namespace_fad6b63f0287902 / namespace_16d9c1530a364ee9
// Params 1
// Checksum 0x0, Offset: 0x50c
// Size: 0x118
function trigger_flag_set_touching( trigger )
{
    flag = trigger get_trigger_flag();
    
    if ( !isdefined( level.flag[ flag ] ) )
    {
        flag_init( flag );
    }
    
    poll_rate = default_to( trigger.var_8b723ed1346786b3, 0.25 );
    
    if ( !isnumber( poll_rate ) )
    {
        poll_rate = 0.25;
    }
    
    for ( ;; )
    {
        trigger waittill( "trigger", other );
        
        if ( trigger function_5b4909bf3b589e4f( other ) )
        {
            continue;
        }
        
        if ( trigger.classname == "trigger_multiple_fx_fxzone" )
        {
            if ( isdefined( other.connect_time ) && gettime() - other.connect_time <= 50 )
            {
                wait 2;
            }
        }
        
        trigger script_delay();
        
        if ( isalive( other ) && isdefined( trigger ) && other istouching( trigger ) )
        {
            flag_set( flag );
        }
        
        while ( isalive( other ) && isdefined( trigger ) && other istouching( trigger ) )
        {
            wait poll_rate;
        }
        
        flag_clear( flag );
    }
}

// Namespace namespace_fad6b63f0287902 / namespace_16d9c1530a364ee9
// Params 1
// Checksum 0x0, Offset: 0x62c
// Size: 0xa0, Type: bool
function function_5b4909bf3b589e4f( other )
{
    if ( !isai( other ) )
    {
        return false;
    }
    
    if ( !isdefined( other.team ) )
    {
        return false;
    }
    
    if ( !( self.spawnflags & 1 ) && other.team == "axis" )
    {
        return true;
    }
    
    if ( !( self.spawnflags & 2 ) && other.team == "allies" )
    {
        return true;
    }
    
    if ( !( self.spawnflags & 4 ) && other.team == "neutral" )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_fad6b63f0287902 / namespace_16d9c1530a364ee9
// Params 1
// Checksum 0x0, Offset: 0x6d5
// Size: 0x71
function trigger_flag_set( trigger )
{
    flag = trigger get_trigger_flag();
    
    if ( !isdefined( level.flag[ flag ] ) )
    {
        flag_init( flag );
    }
    
    for ( ;; )
    {
        trigger waittill( "trigger", other );
        
        if ( trigger function_5b4909bf3b589e4f( other ) )
        {
            continue;
        }
        
        trigger script_delay();
        flag_set( flag, other );
        
        if ( !isdefined( trigger ) )
        {
            break;
        }
    }
}

// Namespace namespace_fad6b63f0287902 / namespace_16d9c1530a364ee9
// Params 1
// Checksum 0x0, Offset: 0x74e
// Size: 0x68
function trigger_flag_clear( trigger )
{
    flag = trigger get_trigger_flag();
    
    if ( !isdefined( level.flag[ flag ] ) )
    {
        flag_init( flag );
    }
    
    for ( ;; )
    {
        trigger waittill( "trigger", other );
        
        if ( trigger function_5b4909bf3b589e4f( other ) )
        {
            continue;
        }
        
        trigger script_delay();
        flag_clear( flag );
    }
}

// Namespace namespace_fad6b63f0287902 / namespace_16d9c1530a364ee9
// Params 1
// Checksum 0x0, Offset: 0x7be
// Size: 0x92
function function_1dd1344e1eaa3ff1( trigger )
{
    minimap_floor = trigger.script_floor_number;
    assertex( isdefined( minimap_floor ), "trigger_multiple_set_minimap_floor has no floor number." );
    
    for ( ;; )
    {
        trigger waittill( "trigger", player );
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.var_7f574731fa72c7af ) || player.var_7f574731fa72c7af != minimap_floor )
        {
            player scripts\cp\cp_compass::function_fb7bad834ce4b28c( minimap_floor );
            player.var_7f574731fa72c7af = minimap_floor;
        }
    }
}

// Namespace namespace_fad6b63f0287902 / namespace_16d9c1530a364ee9
// Params 2
// Checksum 0x0, Offset: 0x858
// Size: 0x5c
function trigger_wait( strname, strkey )
{
    etrigger = getent( strname, strkey );
    
    if ( !isdefined( etrigger ) )
    {
        assertmsg( "trigger not found: " + strname + " key: " + strkey );
        return;
    }
    
    etrigger waittill( "trigger", eother );
    level notify( strname, eother );
    return eother;
}

// Namespace namespace_fad6b63f0287902 / namespace_16d9c1530a364ee9
// Params 1
// Checksum 0x0, Offset: 0x8bd
// Size: 0x17
function trigger_wait_targetname( strname )
{
    return trigger_wait( strname, "targetname" );
}

