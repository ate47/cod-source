#using scripts\engine\utility;

#namespace callback;

// Namespace callback / scripts\common\callbacks
// Params 2
// Checksum 0x0, Offset: 0x13f
// Size: 0xad
function callback( event, params )
{
    if ( !isdefined( params ) )
    {
        params = spawnstruct();
    }
    
    assertex( isstruct( params ), "Callbacks should always use a struct to pass parameters." );
    function_f3847410a67a3098( level, event, params );
    
    if ( self != level )
    {
        function_f3847410a67a3098( self, event, params );
        
        if ( isdefined( self.var_8d44c0f367e8d9c0 ) )
        {
            foreach ( callback_template in self.var_8d44c0f367e8d9c0 )
            {
                function_f3847410a67a3098( callback_template, event, params );
            }
        }
    }
}

// Namespace callback / scripts\common\callbacks
// Params 2
// Checksum 0x0, Offset: 0x1f4
// Size: 0x6f
function function_1ad95d714a56c8fa( event, params )
{
    ais = getaiarray();
    
    foreach ( ai in ais )
    {
        ai function_f3847410a67a3098( ai, event, params );
    }
}

// Namespace callback / scripts\common\callbacks
// Params 2
// Checksum 0x0, Offset: 0x26b
// Size: 0x7e
function function_ca1462b402444dd6( event, params )
{
    players = level.players;
    
    foreach ( player in players )
    {
        player function_f3847410a67a3098( level, event, params );
        player function_f3847410a67a3098( player, event, params );
    }
}

// Namespace callback / scripts\common\callbacks
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2f1
// Size: 0xfd
function private function_f3847410a67a3098( ent, event, params )
{
    callbacks = undefined;
    
    if ( isdefined( ent.callbacks ) )
    {
        callbacks = ent.callbacks[ event ];
    }
    
    if ( isdefined( callbacks ) )
    {
        for ( i = 0; i < callbacks.size ; i++ )
        {
            callback_fields = callbacks[ i ];
            
            if ( !isarray( callback_fields ) )
            {
                continue;
            }
            
            callback = callback_fields[ 0 ];
            assert( isfunction( callback ) );
            
            if ( !isfunction( callback ) )
            {
                return;
            }
            
            var_732ad454c46f92fd = callback_fields[ 1 ];
            
            if ( isdefined( var_732ad454c46f92fd ) )
            {
                self thread [[ callback ]]( params, var_732ad454c46f92fd );
                continue;
            }
            
            self thread [[ callback ]]( params );
        }
        
        if ( isdefined( ent.callbacks ) )
        {
            ent.callbacks[ event ] = function_816601f7d8ca5b92( ent.callbacks[ event ] );
        }
    }
}

// Namespace callback / scripts\common\callbacks
// Params 3
// Checksum 0x0, Offset: 0x3f6
// Size: 0x140
function add( event, func, var_732ad454c46f92fd )
{
    assertex( isfunction( func ), "Parameter for event '" + ( isxhash( event ) ? getxhashsourcename( event ) : event ) + "' is not a function pointer." );
    
    if ( !isfunction( func ) )
    {
        return;
    }
    
    assertex( isdefined( event ), "Trying to set a callback on an undefined event." );
    
    if ( !isdefined( self.callbacks ) || !isdefined( self.callbacks[ event ] ) )
    {
        self.callbacks[ event ] = [];
    }
    
    /#
        foreach ( callback in self.callbacks[ event ] )
        {
            if ( isarray( callback ) && callback[ 0 ] == func )
            {
                if ( !isdefined( callback[ 1 ] ) && !isdefined( var_732ad454c46f92fd ) || is_equal( callback[ 1 ], var_732ad454c46f92fd ) )
                {
                    assertmsg( "<dev string:x1c>" + event );
                }
            }
        }
    #/
    
    self.callbacks[ event ][ self.callbacks[ event ].size ] = [ func, var_732ad454c46f92fd ];
}

// Namespace callback / scripts\common\callbacks
// Params 3
// Checksum 0x0, Offset: 0x53e
// Size: 0x106
function remove( event, func, instant )
{
    if ( !isdefined( self.callbacks ) )
    {
        return;
    }
    
    assertex( isdefined( event ), "Trying to remove a callback on an undefined event." );
    
    if ( isdefined( func ) && isxhash( func ) && func == #"all" )
    {
        self.callbacks[ event ] = [];
        return;
    }
    
    if ( !isdefined( self.callbacks[ event ] ) )
    {
        return;
    }
    
    foreach ( func_group in self.callbacks[ event ] )
    {
        if ( isarray( func_group ) && func_group[ 0 ] == func )
        {
            self.callbacks[ event ][ index ] = 0;
            break;
        }
    }
    
    if ( istrue( instant ) )
    {
        self.callbacks[ event ] = function_816601f7d8ca5b92( self.callbacks[ event ] );
    }
}

// Namespace callback / scripts\common\callbacks
// Params 1
// Checksum 0x0, Offset: 0x64c
// Size: 0x4d
function get_template( template_name )
{
    if ( !isdefined( level.callback_templates ) )
    {
        level.callback_templates = [];
    }
    
    if ( !isdefined( level.callback_templates[ template_name ] ) )
    {
        level.callback_templates[ template_name ] = spawnstruct();
    }
    
    return level.callback_templates[ template_name ];
}

// Namespace callback / scripts\common\callbacks
// Params 1
// Checksum 0x0, Offset: 0x6a2
// Size: 0x5c
function function_d4f1fdfa332469ec( template_name )
{
    assertex( self != level, "<dev string:x4a>" );
    template_struct = get_template( template_name );
    
    if ( !isdefined( self.var_8d44c0f367e8d9c0 ) || !isdefined( self.var_8d44c0f367e8d9c0[ template_name ] ) )
    {
        self.var_8d44c0f367e8d9c0[ template_name ] = template_struct;
    }
}

// Namespace callback / scripts\common\callbacks
// Params 1
// Checksum 0x0, Offset: 0x706
// Size: 0x6b, Type: bool
function function_75a459cce09d9f29( template_name )
{
    return self != level && isdefined( template_name ) && isdefined( level.callback_templates ) && isdefined( level.callback_templates[ template_name ] ) && isdefined( self.var_8d44c0f367e8d9c0 ) && isdefined( self.var_8d44c0f367e8d9c0[ template_name ] ) && self.var_8d44c0f367e8d9c0[ template_name ] == level.callback_templates[ template_name ];
}

// Namespace callback / scripts\common\callbacks
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x77a
// Size: 0x72
function private function_816601f7d8ca5b92( callbacks )
{
    result = [];
    
    foreach ( cb in callbacks )
    {
        if ( isint( cb ) && cb == 0 )
        {
            continue;
        }
        
        result[ result.size ] = cb;
    }
    
    return result;
}

