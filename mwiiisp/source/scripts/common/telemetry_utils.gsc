#namespace telemetry_utils;

// Namespace telemetry_utils / scripts\common\telemetry_utils
// Params 2
// Checksum 0x0, Offset: 0x13d
// Size: 0x60
function function_aacbbe63c26687ae( callback, func )
{
    if ( !isdefined( level.telemetry_callbacks ) )
    {
        level.telemetry_callbacks = [];
    }
    
    if ( !isdefined( level.telemetry_callbacks[ callback ] ) )
    {
        level.telemetry_callbacks[ callback ] = [];
    }
    
    level.telemetry_callbacks[ callback ][ level.telemetry_callbacks[ callback ].size ] = func;
}

// Namespace telemetry_utils / scripts\common\telemetry_utils
// Params 1
// Checksum 0x0, Offset: 0x1a5
// Size: 0x2d, Type: bool
function function_9ce94b15ee6758ee( callback )
{
    if ( !isdefined( level.telemetry_callbacks ) )
    {
        return false;
    }
    
    if ( !isdefined( level.telemetry_callbacks[ callback ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace telemetry_utils / scripts\common\telemetry_utils
// Params 2
// Checksum 0x0, Offset: 0x1db
// Size: 0x86
function function_80820d6d364c1836( callback, data )
{
    if ( !function_9ce94b15ee6758ee( callback ) )
    {
        return;
    }
    
    if ( isdefined( data ) )
    {
        for ( i = 0; i < level.telemetry_callbacks[ callback ].size ; i++ )
        {
            thread [[ level.telemetry_callbacks[ callback ][ i ] ]]( data );
        }
        
        return;
    }
    
    for ( i = 0; i < level.telemetry_callbacks[ callback ].size ; i++ )
    {
        thread [[ level.telemetry_callbacks[ callback ][ i ] ]]();
    }
}

// Namespace telemetry_utils / scripts\common\telemetry_utils
// Params 1
// Checksum 0x0, Offset: 0x269
// Size: 0x41
function function_1b15450e092933cf( basetime )
{
    timefrom = basetime;
    
    if ( isdefined( level.starttimefrommatchstart ) )
    {
        timefrom -= level.starttimefrommatchstart;
        
        if ( timefrom < 0 )
        {
            timefrom = 0;
        }
    }
    else
    {
        timefrom = 0;
    }
    
    return timefrom;
}

// Namespace telemetry_utils / scripts\common\telemetry_utils
// Params 0
// Checksum 0x0, Offset: 0x2b3
// Size: 0x5c
function function_50989a55805a440b()
{
    mountstring = self playermounttype();
    
    if ( isdefined( mountstring ) )
    {
        switch ( mountstring )
        {
            case #"hash_b882c19d3b9f4eb6":
                return "MOUNT_LEFT";
            case #"hash_c00b1399e3e96eeb":
                return "MOUNT_RIGHT";
            case #"hash_d45b94ed344be47e":
                return "MOUNT_TOP";
        }
    }
    
    return "MOUNT_NONE";
}

// Namespace telemetry_utils / scripts\common\telemetry_utils
// Params 1
// Checksum 0x0, Offset: 0x318
// Size: 0x3d, Type: bool
function is_valid_client( client )
{
    if ( istrue( game[ "isLaunchChunk" ] ) )
    {
        return false;
    }
    
    if ( !isdefined( client ) )
    {
        return false;
    }
    else if ( isagent( client ) )
    {
        return false;
    }
    else if ( !isplayer( client ) )
    {
        return false;
    }
    
    return true;
}

// Namespace telemetry_utils / scripts\common\telemetry_utils
// Params 1
// Checksum 0x0, Offset: 0x35e
// Size: 0x85, Type: bool
function function_4b974d822d418a06( data )
{
    if ( !isdefined( data.player ) )
    {
        return false;
    }
    
    if ( !isdefined( data.player.pers ) )
    {
        return false;
    }
    
    if ( !isdefined( data.player.pers[ "telemetry" ] ) )
    {
        return false;
    }
    
    if ( !isdefined( data.player.pers[ "telemetry" ].life ) )
    {
        return false;
    }
    
    return true;
}

// Namespace telemetry_utils / scripts\common\telemetry_utils
// Params 0
// Checksum 0x0, Offset: 0x3ec
// Size: 0xaa
function get_objective_type()
{
    objectivetype = "hub";
    
    if ( isdefined( level.active_objectives_string ) )
    {
        objectivetype = level.active_objectives_string;
    }
    else if ( isdefined( level.contentmanager ) && isdefined( level.contentmanager.activeobjective ) )
    {
        instance = level.contentmanager.activeobjective;
        location = instance.targetname;
        
        if ( isdefined( location ) )
        {
            objectivetype = location;
        }
    }
    else if ( isdefined( level.lastobjective ) )
    {
        objectivetype = level.lastobjective;
    }
    
    return objectivetype;
}

// Namespace telemetry_utils / scripts\common\telemetry_utils
// Params 1
// Checksum 0x0, Offset: 0x49f
// Size: 0x30
function function_ff48d255c865806( client )
{
    if ( is_valid_client( client ) )
    {
        return ( client.clientid < level.maxlogclients );
    }
    
    return 0;
}

// Namespace telemetry_utils / scripts\common\telemetry_utils
// Params 1
// Checksum 0x0, Offset: 0x4d7
// Size: 0x31
function validatetuningdata( value )
{
    if ( !isdefined( value ) || !isfloat( value ) )
    {
        assert( "value is not a \"Float\". Defaulting to -1000000.0, since it is currently outside the scope of tuning values." );
        value = -1e+06;
    }
    
    return value;
}

