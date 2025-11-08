#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;

#namespace statemachine;

// Namespace statemachine / scripts\sp\statemachine
// Params 2
// Checksum 0x0, Offset: 0x100
// Size: 0xb6
function begin_fsm( statearray, sinitialstate )
{
    self.previousstate = undefined;
    self.currentstate = undefined;
    self.permanentnotifyhandlers = undefined;
    self.currentnotifyhandlers = undefined;
    self.states = statearray;
    assertex( isdefined( self.states ) && self.states.size > 0, "No states defined for FSM" );
    
    if ( isdefined( sinitialstate ) )
    {
        self.initialstate = sinitialstate;
    }
    else if ( isdefined( self.states[ 0 ][ 0 ] ) )
    {
        self.initialstate = self.states[ 0 ][ 0 ];
    }
    
    goto_state( self.initialstate );
}

// Namespace statemachine / scripts\sp\statemachine
// Params 1
// Checksum 0x0, Offset: 0x1be
// Size: 0x14
function goto_state( newstatename )
{
    thread perform_state_change( newstatename );
}

// Namespace statemachine / scripts\sp\statemachine
// Params 1
// Checksum 0x0, Offset: 0x1da
// Size: 0x10f
function perform_state_change( newstatename )
{
    newstate = get_state( newstatename );
    
    if ( isdefined( newstate ) )
    {
        if ( isdefined( self.currentstate ) )
        {
            self.previousstate = self.currentstate;
        }
        
        self notify( "changed_state" );
        self.currentnotifyhandlers = [];
        
        if ( isdefined( self.previousstate ) )
        {
            if ( isdefined( self.previousstate[ 3 ] ) )
            {
                exitfunction = self.previousstate[ 3 ];
                [[ exitfunction ]]();
            }
        }
        
        self.currentstate = newstate;
        
        if ( isdefined( self.currentstate[ 1 ] ) )
        {
            var_63d751a32b8eb335 = self.currentstate[ 1 ];
            set_enter_function( var_63d751a32b8eb335 );
        }
        
        if ( isdefined( self.currentstate[ 2 ] ) )
        {
            var_91d038e0e74b6c98 = self.currentstate[ 2 ];
            thread set_update_function( var_91d038e0e74b6c98 );
        }
        
        return;
    }
    
    assertex( isdefined( newstate ), "State: " + newstatename + ", is not defined" );
}

// Namespace statemachine / scripts\sp\statemachine
// Params 0
// Checksum 0x0, Offset: 0x2f1
// Size: 0x21
function goto_state_previous()
{
    if ( isdefined( self.previousstate ) )
    {
        goto_state( self.previousstate[ 0 ] );
    }
}

// Namespace statemachine / scripts\sp\statemachine
// Params 1
// Checksum 0x0, Offset: 0x31a
// Size: 0x5f
function get_state( statename )
{
    foreach ( state in self.states )
    {
        if ( state[ 0 ] == statename )
        {
            return state;
        }
    }
    
    return undefined;
}

// Namespace statemachine / scripts\sp\statemachine
// Params 1
// Checksum 0x0, Offset: 0x382
// Size: 0x1f
function set_enter_function( function )
{
    self endon( "death" );
    self endon( "changed_state" );
    self childthread [[ function ]]();
}

// Namespace statemachine / scripts\sp\statemachine
// Params 1
// Checksum 0x0, Offset: 0x3a9
// Size: 0x26
function set_update_function( function )
{
    self endon( "death" );
    self endon( "changed_state" );
    
    while ( true )
    {
        [[ function ]]();
        waitframe();
    }
}

// Namespace statemachine / scripts\sp\statemachine
// Params 1
// Checksum 0x0, Offset: 0x3d7
// Size: 0x81
function set_notify_handlers( var_baf55632c23b48b4 )
{
    self.currentnotifyhandlers = var_baf55632c23b48b4;
    
    foreach ( handler in var_baf55632c23b48b4 )
    {
        var_107f1d5307246e8e = -1;
        
        if ( isdefined( handler[ 2 ] ) )
        {
            var_107f1d5307246e8e = handler[ 2 ];
        }
        
        thread state_nofity_handler( handler[ 0 ], handler[ 1 ], var_107f1d5307246e8e );
    }
}

// Namespace statemachine / scripts\sp\statemachine
// Params 1
// Checksum 0x0, Offset: 0x460
// Size: 0x81
function set_permanent_notify_handlers( var_baf55632c23b48b4 )
{
    self.permanentnotifyhandlers = var_baf55632c23b48b4;
    
    foreach ( handler in var_baf55632c23b48b4 )
    {
        var_107f1d5307246e8e = -1;
        
        if ( isdefined( handler[ 2 ] ) )
        {
            var_107f1d5307246e8e = handler[ 2 ];
        }
        
        thread permanent_notify_handler( handler[ 0 ], handler[ 1 ], var_107f1d5307246e8e );
    }
}

// Namespace statemachine / scripts\sp\statemachine
// Params 3
// Checksum 0x0, Offset: 0x4e9
// Size: 0x33
function state_nofity_handler( notifystring, var_dfeff47c18399f7, var_107f1d5307246e8e )
{
    self endon( "death" );
    self endon( "changed_state" );
    start_handler( notifystring, var_dfeff47c18399f7, var_107f1d5307246e8e );
}

// Namespace statemachine / scripts\sp\statemachine
// Params 3
// Checksum 0x0, Offset: 0x524
// Size: 0x2c
function permanent_notify_handler( notifystring, var_dfeff47c18399f7, var_107f1d5307246e8e )
{
    self endon( "death" );
    start_handler( notifystring, var_dfeff47c18399f7, var_107f1d5307246e8e );
}

// Namespace statemachine / scripts\sp\statemachine
// Params 3
// Checksum 0x0, Offset: 0x558
// Size: 0x69
function start_handler( notifystring, var_dfeff47c18399f7, var_107f1d5307246e8e )
{
    self notify( "new_handler" );
    
    for ( var_4cd932b295f4ca3c = 1; var_4cd932b295f4ca3c ; var_4cd932b295f4ca3c = 0 )
    {
        self waittill( notifystring, params );
        
        if ( isdefined( params ) )
        {
            [[ var_dfeff47c18399f7 ]]( params );
        }
        else
        {
            [[ var_dfeff47c18399f7 ]]();
        }
        
        if ( var_107f1d5307246e8e >= 0 )
        {
            var_107f1d5307246e8e--;
            
            if ( var_107f1d5307246e8e == 0 )
            {
            }
        }
    }
}

// Namespace statemachine / scripts\sp\statemachine
// Params 0
// Checksum 0x0, Offset: 0x5c9
// Size: 0x36
function get_current_state()
{
    if ( isdefined( self.currentstate ) )
    {
        return self.currentstate[ 0 ];
    }
    
    assertex( isdefined( self.currentstate ), "Current state does not exist" );
}

