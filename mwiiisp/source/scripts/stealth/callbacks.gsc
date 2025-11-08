#using scripts\common\utility;
#using scripts\engine\utility;

#namespace callbacks;

// Namespace callbacks / scripts\stealth\callbacks
// Params 0
// Checksum 0x0, Offset: 0x1c7
// Size: 0xd0
function init_callbacks()
{
    level.global_callbacks = [];
    
    foreach ( callback in [ "_autosave_stealthcheck", "_patrol_endon_spotted_flag", "_spawner_stealth_default", "_idle_call_idle_func" ] )
    {
        level.global_callbacks[ callback ] = &global_empty_callback;
    }
    
    if ( !flag_exist( "stealth_spotted" ) )
    {
        flag_init( "stealth_spotted" );
    }
    
    if ( !flag_exist( "stealth_enabled" ) )
    {
        flag_init( "stealth_enabled" );
    }
    
    if ( !flag_exist( "stealth_music_pause" ) )
    {
        flag_init( "stealth_music_pause" );
    }
}

// Namespace callbacks / scripts\stealth\callbacks
// Params 5
// Checksum 0x0, Offset: 0x29f
// Size: 0x39
function global_empty_callback( empty1, empty2, empty3, empty4, empty5 )
{
    assertmsg( "a _stealth or _idle related function was called in a global script without being initilized by the stealth system.  If you've already initilized those scripts, then this is a bug for Mo." );
}

// Namespace callbacks / scripts\stealth\callbacks
// Params 1
// Checksum 0x0, Offset: 0x2e0
// Size: 0x9c
function stealth_get_func( type )
{
    if ( isdefined( self.stealth ) && isdefined( self.stealth.funcs ) && isdefined( self.stealth.funcs[ type ] ) )
    {
        return self.stealth.funcs[ type ];
    }
    
    if ( isdefined( level.stealth ) && isdefined( level.stealth.funcs ) )
    {
        return level.stealth.funcs[ type ];
    }
    
    return undefined;
}

// Namespace callbacks / scripts\stealth\callbacks
// Params 5
// Checksum 0x0, Offset: 0x385
// Size: 0x86
function stealth_call( type, parm1, parm2, parm3, parm4 )
{
    func = stealth_get_func( type );
    
    if ( isdefined( func ) )
    {
        if ( isdefined( parm4 ) )
        {
            return self [[ func ]]( parm1, parm2, parm3, parm4 );
        }
        else if ( isdefined( parm3 ) )
        {
            return self [[ func ]]( parm1, parm2, parm3 );
        }
        else if ( isdefined( parm2 ) )
        {
            return self [[ func ]]( parm1, parm2 );
        }
        else if ( isdefined( parm1 ) )
        {
            return self [[ func ]]( parm1 );
        }
        else
        {
            return self [[ func ]]();
        }
    }
    
    return undefined;
}

// Namespace callbacks / scripts\stealth\callbacks
// Params 5
// Checksum 0x0, Offset: 0x414
// Size: 0x8b
function stealth_call_thread( type, parm1, parm2, parm3, parm4 )
{
    func = stealth_get_func( type );
    
    if ( isdefined( func ) )
    {
        if ( isdefined( parm4 ) )
        {
            return self thread [[ func ]]( parm1, parm2, parm3, parm4 );
        }
        else if ( isdefined( parm3 ) )
        {
            return self thread [[ func ]]( parm1, parm2, parm3 );
        }
        else if ( isdefined( parm2 ) )
        {
            return self thread [[ func ]]( parm1, parm2 );
        }
        else if ( isdefined( parm1 ) )
        {
            return self thread [[ func ]]( parm1 );
        }
        else
        {
            return self thread [[ func ]]();
        }
    }
    
    return undefined;
}

