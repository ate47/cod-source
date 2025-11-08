#using scripts\engine\utility;

#namespace callback;

// Namespace callback / scripts\common\callbacks
// Params 2
// Checksum 0x0, Offset: 0x90
// Size: 0xb0
function callback( event, params )
{
    if ( !isdefined( params ) )
    {
        params = spawnstruct();
    }
    
    assertex( isstruct( params ), "<dev string:x1c>" );
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
// Checksum 0x0, Offset: 0x148
// Size: 0x71
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
// Checksum 0x0, Offset: 0x1c1
// Size: 0x80
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
// Checksum 0x0, Offset: 0x249
// Size: 0x150
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
            if ( isdefined( ent.var_fab0247ea0a3a375 ) && isdefined( ent.var_fab0247ea0a3a375[ event ] ) )
            {
                ent.callbacks[ event ] = function_816601f7d8ca5b92( ent.callbacks[ event ] );
                ent.var_fab0247ea0a3a375[ event ] = undefined;
            }
            
            assertex( function_c2791ffb5f62cc92( ent.callbacks[ event ] ) == 0, "<dev string:x58>" );
        }
    }
}

// Namespace callback / scripts\common\callbacks
// Params 3
// Checksum 0x0, Offset: 0x3a1
// Size: 0x143
function add( event, func, var_732ad454c46f92fd )
{
    assertex( isfunction( func ), "<dev string:xa4>" + ( isxhash( event ) ? getxhashsourcename( event ) : event ) + "<dev string:xbd>" );
    
    if ( !isfunction( func ) )
    {
        return;
    }
    
    assertex( isdefined( event ), "<dev string:xdd>" );
    
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
                    assertmsg( "<dev string:x110>" + event );
                }
            }
        }
    #/
    
    self.callbacks[ event ][ self.callbacks[ event ].size ] = [ func, var_732ad454c46f92fd ];
}

// Namespace callback / scripts\common\callbacks
// Params 3
// Checksum 0x0, Offset: 0x4ec
// Size: 0x17a
function remove( event, func, instant )
{
    if ( !isdefined( self.callbacks ) )
    {
        return;
    }
    
    assertex( isdefined( event ), "<dev string:x141>" );
    
    if ( isdefined( func ) && isxhash( func ) && func == #"all" )
    {
        self.callbacks[ event ] = [];
        
        if ( isdefined( self.var_fab0247ea0a3a375 ) )
        {
            self.var_fab0247ea0a3a375[ event ] = undefined;
        }
        
        return;
    }
    
    if ( !isdefined( self.callbacks[ event ] ) )
    {
        return;
    }
    
    foreach ( index, func_group in self.callbacks[ event ] )
    {
        if ( isarray( func_group ) && func_group[ 0 ] == func )
        {
            self.callbacks[ event ][ index ] = 0;
            self.var_fab0247ea0a3a375[ event ] = 1;
            break;
        }
    }
    
    if ( istrue( instant ) )
    {
        if ( isdefined( self.var_fab0247ea0a3a375 ) && isdefined( self.var_fab0247ea0a3a375[ event ] ) )
        {
            self.callbacks[ event ] = function_816601f7d8ca5b92( self.callbacks[ event ] );
            self.var_fab0247ea0a3a375[ event ] = undefined;
        }
        
        assertex( function_c2791ffb5f62cc92( self.callbacks[ event ] ) == 0, "<dev string:x58>" );
    }
}

// Namespace callback / scripts\common\callbacks
// Params 1
// Checksum 0x0, Offset: 0x66e
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
// Checksum 0x0, Offset: 0x6c4
// Size: 0x5d
function function_d4f1fdfa332469ec( template_name )
{
    assertex( self != level, "<dev string:x177>" );
    template_struct = get_template( template_name );
    
    if ( !isdefined( self.var_8d44c0f367e8d9c0 ) || !isdefined( self.var_8d44c0f367e8d9c0[ template_name ] ) )
    {
        self.var_8d44c0f367e8d9c0[ template_name ] = template_struct;
    }
}

// Namespace callback / scripts\common\callbacks
// Params 1
// Checksum 0x0, Offset: 0x729
// Size: 0x6b, Type: bool
function function_75a459cce09d9f29( template_name )
{
    return self != level && isdefined( template_name ) && isdefined( level.callback_templates ) && isdefined( level.callback_templates[ template_name ] ) && isdefined( self.var_8d44c0f367e8d9c0 ) && isdefined( self.var_8d44c0f367e8d9c0[ template_name ] ) && self.var_8d44c0f367e8d9c0[ template_name ] == level.callback_templates[ template_name ];
}

// Namespace callback / scripts\common\callbacks
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x79d
// Size: 0x87
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
    
    assertex( result.size < callbacks.size, "<dev string:x1b2>" );
    return result;
}

// Namespace callback / scripts\common\callbacks
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x82d
// Size: 0x63, Type: bool
function private function_c2791ffb5f62cc92( callbacks )
{
    foreach ( cb in callbacks )
    {
        if ( isint( cb ) && cb == 0 )
        {
            return true;
        }
    }
    
    return false;
}

