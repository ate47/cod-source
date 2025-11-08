#namespace hud;

// Namespace hud / scripts\sp\hud
// Params 0
// Checksum 0x0, Offset: 0xfd
// Size: 0x1d9
function init()
{
    level.uiparent = spawnstruct();
    level.uiparent.horzalign = "left";
    level.uiparent.vertalign = "top";
    level.uiparent.alignx = "left";
    level.uiparent.aligny = "top";
    level.uiparent.x = 0;
    level.uiparent.y = 0;
    level.uiparent.width = 0;
    level.uiparent.height = 0;
    level.uiparent.children = [];
    level.fontheight = 12;
    setdvar( @"hash_32cde99045864a11", 0 );
    setdvar( @"hash_787d2c09ca39aac4", 0 );
    setdvar( @"hash_9565929f2ba6b781", "off" );
    setdvar( @"hash_a1036b0b7af18aa8", "off" );
    setdvar( @"hash_f0b47c7069fd9933", "off" );
    setdvar( @"hash_fc22f9d5d3626cfa", "off" );
    setdvar( @"hidehudfast", 0 );
    setdvar( @"ui_securing", "" );
    setdvar( @"ui_securing_progress", 0 );
    setdvar( @"hash_9fb9448766c1f439", 1 );
    setdvar( @"hash_6a3a3c63c640148f", 1 );
    setdvar( @"minimap_sp", 0 );
    setdvar( @"hash_6b6a0dbe8c0bf7bf", 0 );
    helmet_meters_init();
}

// Namespace hud / scripts\sp\hud
// Params 0
// Checksum 0x0, Offset: 0x2de
// Size: 0x49
function helmet_meters_init()
{
    if ( isdefined( level.helmet_meters ) )
    {
        return;
    }
    
    meters = [];
    meters[ "oxygen" ] = 0;
    meters[ "temperature" ] = 0;
    meters[ "pressure" ] = 0;
    level.helmet_meters = meters;
}

// Namespace hud / scripts\sp\hud
// Params 2
// Checksum 0x0, Offset: 0x32f
// Size: 0x14f
function helmet_meters_on( environment, hidden )
{
    if ( environment == "suit" )
    {
        oxygen = randomfloatrange( 93.83, 93.87 );
        temperature = randomintrange( 18, 22 );
        pressure = randomfloatrange( 8.2, 8.4 );
    }
    else
    {
        oxygen = randomfloatrange( 20.93, 20.97 );
        temperature = randomintrange( 18, 22 );
        pressure = randomfloatrange( 14.5, 14.9 );
    }
    
    if ( isdefined( hidden ) && hidden )
    {
        level.helmet_meters[ "oxygen" ] = oxygen;
        level.helmet_meters[ "temperature" ] = temperature;
        level.helmet_meters[ "pressure" ] = pressure;
        return;
    }
    
    level.helmet_meters[ "oxygen" ] = 0;
    level.helmet_meters[ "temperature" ] = 0;
    level.helmet_meters[ "pressure" ] = 0;
    duration = randomfloatrange( 3, 4 );
    thread helmet_meters_ramp_and_stabilize( "oxygen", duration, oxygen );
    thread helmet_meters_ramp_and_stabilize( "temperature", duration, temperature );
    thread helmet_meters_ramp_and_stabilize( "pressure", duration, pressure );
}

// Namespace hud / scripts\sp\hud
// Params 1
// Checksum 0x0, Offset: 0x486
// Size: 0x58
function helmet_meters_off( hidden )
{
    thread helmet_meters_ramp( "oxygen", randomfloatrange( 3, 4 ), 0 );
    thread helmet_meters_ramp( "temperature", randomfloatrange( 3, 4 ), 0 );
    thread helmet_meters_ramp( "pressure", randomfloatrange( 3, 4 ), 0 );
}

// Namespace hud / scripts\sp\hud
// Params 2
// Checksum 0x0, Offset: 0x4e6
// Size: 0x111
function helmet_meters_normal_suit( duration, hidden )
{
    oxygen = randomfloatrange( 93.83, 93.87 );
    temperature = randomintrange( 18, 22 );
    pressure = randomfloatrange( 8.2, 8.4 );
    level.helmet_meters[ "oxygen" ] = oxygen;
    level.helmet_meters[ "temperature" ] = temperature;
    level.helmet_meters[ "pressure" ] = pressure;
    
    if ( isdefined( hidden ) && hidden )
    {
        return;
    }
    
    if ( !isdefined( duration ) )
    {
        setomnvar( "ui_helmet_meter_oxygen", helmet_meters_rounding( "oxygen", oxygen ) );
        setomnvar( "ui_helmet_meter_temperature", helmet_meters_rounding( "temperature", temperature ) );
        setomnvar( "ui_helmet_meter_pressure", helmet_meters_rounding( "pressure", pressure ) );
        return;
    }
    
    thread helmet_meters_ramp_and_stabilize( "oxygen", duration, oxygen );
    thread helmet_meters_ramp_and_stabilize( "temperature", duration, temperature );
    thread helmet_meters_ramp_and_stabilize( "pressure", duration, pressure );
}

// Namespace hud / scripts\sp\hud
// Params 2
// Checksum 0x0, Offset: 0x5ff
// Size: 0x111
function helmet_meters_normal_ship( duration, hidden )
{
    oxygen = randomfloatrange( 20.93, 20.97 );
    temperature = randomintrange( 18, 22 );
    pressure = randomfloatrange( 14.5, 14.9 );
    level.helmet_meters[ "oxygen" ] = oxygen;
    level.helmet_meters[ "temperature" ] = temperature;
    level.helmet_meters[ "pressure" ] = pressure;
    
    if ( isdefined( hidden ) && hidden )
    {
        return;
    }
    
    if ( !isdefined( duration ) )
    {
        setomnvar( "ui_helmet_meter_oxygen", helmet_meters_rounding( "oxygen", oxygen ) );
        setomnvar( "ui_helmet_meter_temperature", helmet_meters_rounding( "temperature", temperature ) );
        setomnvar( "ui_helmet_meter_pressure", helmet_meters_rounding( "pressure", pressure ) );
        return;
    }
    
    thread helmet_meters_ramp_and_stabilize( "oxygen", duration, oxygen );
    thread helmet_meters_ramp_and_stabilize( "temperature", duration, temperature );
    thread helmet_meters_ramp_and_stabilize( "pressure", duration, pressure );
}

// Namespace hud / scripts\sp\hud
// Params 3
// Checksum 0x0, Offset: 0x718
// Size: 0x61
function helmet_meters_set_oxygen( value, duration, hidden )
{
    if ( isdefined( hidden ) && hidden )
    {
        level.helmet_meters[ "oxygen" ] = value;
        return;
    }
    
    if ( !isdefined( duration ) )
    {
        duration = randomfloatrange( 3, 4 );
    }
    
    helmet_meters_ramp( "oxygen", duration, value );
    helmet_meters_stabilize( "oxygen" );
}

// Namespace hud / scripts\sp\hud
// Params 3
// Checksum 0x0, Offset: 0x781
// Size: 0x61
function helmet_meters_set_temperature( value, duration, hidden )
{
    if ( isdefined( hidden ) && hidden )
    {
        level.helmet_meters[ "temperature" ] = value;
        return;
    }
    
    if ( !isdefined( duration ) )
    {
        duration = randomfloatrange( 3, 4 );
    }
    
    helmet_meters_ramp( "temperature", duration, value );
    helmet_meters_stabilize( "temperature" );
}

// Namespace hud / scripts\sp\hud
// Params 3
// Checksum 0x0, Offset: 0x7ea
// Size: 0x61
function helmet_meters_set_pressure( value, duration, hidden )
{
    if ( isdefined( hidden ) && hidden )
    {
        level.helmet_meters[ "pressure" ] = value;
        return;
    }
    
    if ( !isdefined( duration ) )
    {
        duration = randomfloatrange( 3, 4 );
    }
    
    helmet_meters_ramp( "pressure", duration, value );
    helmet_meters_stabilize( "pressure" );
}

// Namespace hud / scripts\sp\hud
// Params 1
// Checksum 0x0, Offset: 0x853
// Size: 0xb0
function helmet_meters_airlock_in( duration )
{
    oxygen = randomfloatrange( 20.93, 20.97 );
    temperature = randomintrange( 18, 22 );
    pressure = randomfloatrange( 14.5, 14.9 );
    
    if ( !isdefined( duration ) )
    {
        duration = randomfloatrange( 3, 4 );
    }
    
    thread helmet_meters_ramp_and_stabilize( "oxygen", duration, oxygen );
    
    if ( !isdefined( duration ) )
    {
        duration = randomfloatrange( 3, 4 );
    }
    
    thread helmet_meters_ramp_and_stabilize( "temperature", duration, temperature );
    
    if ( !isdefined( duration ) )
    {
        duration = randomfloatrange( 3, 4 );
    }
    
    thread helmet_meters_ramp_and_stabilize( "pressure", duration, pressure );
}

// Namespace hud / scripts\sp\hud
// Params 1
// Checksum 0x0, Offset: 0x90b
// Size: 0xb0
function helmet_meters_airlock_out( duration )
{
    oxygen = randomfloatrange( 93.83, 93.87 );
    temperature = randomintrange( 18, 22 );
    pressure = randomfloatrange( 8.2, 8.4 );
    
    if ( !isdefined( duration ) )
    {
        duration = randomfloatrange( 3, 4 );
    }
    
    thread helmet_meters_ramp_and_stabilize( "oxygen", duration, oxygen );
    
    if ( !isdefined( duration ) )
    {
        duration = randomfloatrange( 3, 4 );
    }
    
    thread helmet_meters_ramp_and_stabilize( "temperature", duration, temperature );
    
    if ( !isdefined( duration ) )
    {
        duration = randomfloatrange( 3, 4 );
    }
    
    thread helmet_meters_ramp_and_stabilize( "pressure", duration, pressure );
}

// Namespace hud / scripts\sp\hud
// Params 2
// Checksum 0x0, Offset: 0x9c3
// Size: 0xe6
function helmet_meters_forced_decompress( environment, duration )
{
    if ( environment == "interior" )
    {
        oxygen = randomfloatrange( 20.93, 20.97 );
        temperature = randomintrange( 18, 22 );
        pressure = randomfloatrange( 14.5, 14.9 );
    }
    else
    {
        oxygen = randomfloatrange( 6, 8 );
        temperature = randomintrange( -60, -50 );
        pressure = randomfloatrange( 4, 6 );
    }
    
    if ( !isdefined( duration ) )
    {
        duration = randomfloatrange( 2, 3 );
    }
    
    thread helmet_meters_ramp_and_stabilize( "oxygen", duration, oxygen );
    
    if ( !isdefined( duration ) )
    {
        duration = randomfloatrange( 2, 3 );
    }
    
    thread helmet_meters_ramp_and_stabilize( "temperature", duration, temperature );
    
    if ( !isdefined( duration ) )
    {
        duration = randomfloatrange( 2, 3 );
    }
    
    thread helmet_meters_ramp_and_stabilize( "pressure", duration, pressure );
}

// Namespace hud / scripts\sp\hud
// Params 3
// Checksum 0x0, Offset: 0xab1
// Size: 0x1c0
function helmet_meters_ramp( type, duration, goal_value )
{
    accel = 0;
    decel = 0;
    var_78cd7a63f38d99d1 = 0;
    base_increment = abs( ( goal_value - level.helmet_meters[ type ] ) / duration * 0.05 );
    omnvarname = "ui_helmet_meter_" + type;
    
    if ( type == "oxygen" )
    {
        accel = 1;
        decel = 1;
    }
    else if ( type == "temperature" )
    {
        accel = 2;
        decel = 3;
    }
    else if ( type == "pressure" )
    {
        accel = 1;
        decel = 1;
    }
    
    accel_increment = accel * 0.05;
    decel_increment = decel * 0.05;
    value_raise = 1;
    
    if ( goal_value == level.helmet_meters[ type ] )
    {
        return;
    }
    else if ( goal_value < level.helmet_meters[ type ] )
    {
        value_raise = 0;
    }
    
    i = 0;
    
    while ( i < duration )
    {
        if ( value_raise )
        {
            level.helmet_meters[ type ] += base_increment;
        }
        else
        {
            level.helmet_meters[ type ] -= base_increment;
        }
        
        rounded_value = helmet_meters_rounding( type, level.helmet_meters[ type ] );
        setomnvar( omnvarname, rounded_value );
        wait 0.05;
        i += 0.05;
    }
    
    rounded_value = helmet_meters_rounding( type, level.helmet_meters[ type ] );
    setomnvar( omnvarname, rounded_value );
}

// Namespace hud / scripts\sp\hud
// Params 1
// Checksum 0x0, Offset: 0xc79
// Size: 0xd5
function helmet_meters_stabilize( type )
{
    goal_value = 0;
    
    if ( type == "oxygen" )
    {
        goal_value = randomfloatrange( -0.5, 0.5 ) + level.helmet_meters[ type ];
    }
    else if ( type == "temperature" )
    {
        goal_value = randomintrange( -1, 1 ) + level.helmet_meters[ type ];
    }
    else if ( type == "pressure" )
    {
        goal_value = randomfloatrange( -0.5, 0.5 ) + level.helmet_meters[ type ];
    }
    
    old_value = level.helmet_meters[ type ];
    duration = randomfloatrange( 1, 3 );
    helmet_meters_ramp( type, duration, goal_value );
    duration = randomfloatrange( 1, 2 );
    helmet_meters_ramp( type, duration, old_value );
}

// Namespace hud / scripts\sp\hud
// Params 3
// Checksum 0x0, Offset: 0xd56
// Size: 0x2d
function helmet_meters_ramp_and_stabilize( type, duration, goal_value )
{
    helmet_meters_ramp( type, duration, goal_value );
    helmet_meters_stabilize( type );
}

// Namespace hud / scripts\sp\hud
// Params 2
// Checksum 0x0, Offset: 0xd8b
// Size: 0x25
function helmet_meters_rounding( type, value )
{
    goal_value = int( value );
    return goal_value;
}

