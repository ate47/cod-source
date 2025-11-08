#using scripts\engine\utility;

#namespace ui;

// Namespace ui / scripts\common\ui
// Params 2
// Checksum 0x0, Offset: 0xa3
// Size: 0x92
function lui_registercallback( channel, callback )
{
    if ( !isdefined( level.lui_callbacks ) )
    {
        level.lui_callbacks = [];
    }
    
    assert( isstring( channel ) && channel != "<dev string:x1c>" && isfunction( callback ) );
    
    if ( !isdefined( level.lui_callbacks[ channel ] ) || !array_contains( level.lui_callbacks[ channel ], callback ) )
    {
        level.lui_callbacks[ channel ] = array_add_safe( level.lui_callbacks[ channel ], callback );
    }
}

// Namespace ui / scripts\common\ui
// Params 3
// Checksum 0x0, Offset: 0x13d
// Size: 0xbf
function lui_notify_callback( channel, value, value2 )
{
    if ( isdefined( self ) )
    {
        if ( isdefined( level.lui_callbacks ) && isdefined( level.lui_callbacks[ channel ] ) )
        {
            foreach ( callback in level.lui_callbacks[ channel ] )
            {
                if ( isdefined( value2 ) )
                {
                    self thread [[ callback ]]( value, value2 );
                    continue;
                }
                
                self thread [[ callback ]]( value );
            }
        }
        
        if ( isdefined( value2 ) )
        {
            self notify( "luinotifyserver", channel, value, value2 );
            return;
        }
        
        self notify( "luinotifyserver", channel, value );
    }
}

