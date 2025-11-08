#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\utility;

#namespace vehicle_lights;

// Namespace vehicle_lights / scripts\common\vehicle_lights
// Params 2
// Checksum 0x0, Offset: 0x11e
// Size: 0x38
function lights_on( group, classname )
{
    groups = strtok( group, " " );
    array_levelthread( groups, &lights_on_internal, classname );
}

// Namespace vehicle_lights / scripts\common\vehicle_lights
// Params 3
// Checksum 0x0, Offset: 0x15e
// Size: 0x198
function group_light( model, name, group )
{
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group ) )
    {
        level.vehicle.templates.vehicle_lights_group = [];
    }
    
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group[ model ] ) )
    {
        level.vehicle.templates.vehicle_lights_group[ model ] = [];
    }
    
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group[ model ][ group ] ) )
    {
        level.vehicle.templates.vehicle_lights_group[ model ][ group ] = [];
    }
    
    foreach ( var_547909af7f4f97d4 in level.vehicle.templates.vehicle_lights_group[ model ][ group ] )
    {
        if ( name == var_547909af7f4f97d4 )
        {
            return;
        }
    }
    
    level.vehicle.templates.vehicle_lights_group[ model ][ group ][ level.vehicle.templates.vehicle_lights_group[ model ][ group ].size ] = name;
}

// Namespace vehicle_lights / scripts\common\vehicle_lights
// Params 0
// Checksum 0x0, Offset: 0x2fe
// Size: 0x73
function lights_delayfxforframe()
{
    level notify( "new_lights_delayfxforframe" );
    level endon( "new_lights_delayfxforframe" );
    
    if ( !isdefined( level.fxdelay ) )
    {
        level.fxdelay = 0;
    }
    
    level.fxdelay += randomfloatrange( 0.2, 0.4 );
    
    if ( level.fxdelay > 2 )
    {
        level.fxdelay = 0;
    }
    
    wait 0.05;
    level.fxdelay = undefined;
}

// Namespace vehicle_lights / scripts\common\vehicle_lights
// Params 3
// Checksum 0x0, Offset: 0x379
// Size: 0x22f
function lights_off_internal( group, model, classname )
{
    self notify( "lights_off" );
    
    if ( isdefined( classname ) )
    {
        model = classname;
    }
    else if ( !isdefined( model ) )
    {
        model = default_to( self.classname_mp, self.classname );
    }
    
    if ( !isdefined( group ) )
    {
        group = "all";
    }
    
    if ( !isdefined( self.lights ) )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group[ model ][ group ] ) )
    {
        /#
            println( "<dev string:x1c>" + self.vehicletype );
            println( "<dev string:x2d>" + self.classname );
            println( "<dev string:x3c>" + group );
        #/
        
        assertmsg( "<dev string:x4d>" );
        return;
    }
    
    lights = level.vehicle.templates.vehicle_lights_group[ model ][ group ];
    count = 0;
    maxlightstopsperframe = 2;
    
    if ( isdefined( self.maxlightstopsperframe ) )
    {
        maxlightstopsperframe = self.maxlightstopsperframe;
    }
    
    foreach ( light in lights )
    {
        template = level.vehicle.templates.vehicle_lights[ model ][ light ];
        
        if ( istrue( template.isscriptable ) )
        {
            utility::function_3677f2be30fdd581( template.part, "off" );
        }
        else if ( hastag( self.model, template.tag ) )
        {
            stopfxontag( template.effect, self, template.tag );
            count++;
            
            if ( count >= maxlightstopsperframe )
            {
                count = 0;
                wait 0.05;
            }
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.lights[ light ] = undefined;
    }
}

// Namespace vehicle_lights / scripts\common\vehicle_lights
// Params 2
// Checksum 0x0, Offset: 0x5b0
// Size: 0x2e9
function lights_on_internal( group, model )
{
    level.lastlighttime = gettime();
    self endon( "lights_off" );
    self endon( "death" );
    
    if ( !isdefined( group ) )
    {
        group = "all";
    }
    
    if ( !isdefined( model ) )
    {
        model = default_to( self.classname_mp, self.classname );
    }
    
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group ) )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle.templates.vehicle_lights_group[ model ] ) || !isdefined( level.vehicle.templates.vehicle_lights_group[ model ][ group ] ) )
    {
        return;
    }
    
    thread lights_delayfxforframe();
    
    if ( !isdefined( self.lights ) )
    {
        self.lights = [];
    }
    
    lights = level.vehicle.templates.vehicle_lights_group[ model ][ group ];
    count = 0;
    var_ccbc0e3634b40c2a = [];
    
    foreach ( light in lights )
    {
        if ( isdefined( self.lights[ light ] ) )
        {
            continue;
        }
        
        template = level.vehicle.templates.vehicle_lights[ model ][ light ];
        
        if ( isdefined( template.delay ) )
        {
            delay = template.delay;
        }
        else
        {
            delay = 0;
        }
        
        delay += level.fxdelay;
        
        while ( isdefined( var_ccbc0e3634b40c2a[ "" + delay ] ) )
        {
            delay += 0.05;
        }
        
        var_ccbc0e3634b40c2a[ "" + delay ] = 1;
        
        if ( istrue( template.isscriptable ) )
        {
            if ( scripts\common\vehicle::function_9b915d163f6d1d5a( template.part ) )
            {
                if ( group == "brakelights" )
                {
                    delaythread( delay, &function_3677f2be30fdd581, template.part, "brake" );
                }
                else if ( group == "daylights" )
                {
                    delaythread( delay, &function_3677f2be30fdd581, template.part, "day" );
                }
                else
                {
                    delaythread( delay, &function_3677f2be30fdd581, template.part, "on" );
                }
            }
        }
        else
        {
            childthread noself_delaycall_proc( &playfxontag, delay, template.effect, self, template.tag );
        }
        
        self.lights[ light ] = 1;
        
        if ( !isdefined( self ) )
        {
            break;
        }
    }
    
    level.fxdelay = 0;
}

// Namespace vehicle_lights / scripts\common\vehicle_lights
// Params 3
// Checksum 0x0, Offset: 0x8a1
// Size: 0x42
function lights_off( group, model, classname )
{
    groups = strtok( group, " ", model );
    array_levelthread( groups, &lights_off_internal, model, classname );
}

