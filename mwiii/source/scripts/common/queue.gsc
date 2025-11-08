#using scripts\engine\utility;

#namespace queue;

// Namespace queue / scripts\common\queue
// Params 10
// Checksum 0x0, Offset: 0xef
// Size: 0xf9
function function_e6d5d1b10a962759( queue, ref, init_func, break_func, interrupt_func, finish_func, func_params, priority, duration, break_notify )
{
    item = spawnstruct();
    item.ref = default_to( ref, "default" );
    item.init_func = init_func;
    item.break_func = break_func;
    item.interrupt_func = interrupt_func;
    item.finish_func = finish_func;
    item.func_params = func_params;
    item.priority = default_to( priority, 0 );
    item.duration = duration;
    item.break_notify = break_notify;
    function_ffbf82197897dac9( queue, item );
}

// Namespace queue / scripts\common\queue
// Params 2
// Checksum 0x0, Offset: 0x1f0
// Size: 0x295
function function_ffbf82197897dac9( queue, item )
{
    if ( !isdefined( self.priority_queues ) )
    {
        self.priority_queues = [];
    }
    
    if ( !isdefined( self.priority_queues[ queue ] ) )
    {
        self.priority_queues[ queue ] = spawnstruct();
    }
    
    item.ref = default_to( item.ref, "default" );
    item.priority = default_to( item.priority, 0 );
    
    if ( !isdefined( self.priority_queues[ queue ].items ) || self.priority_queues[ queue ].items.size == 0 )
    {
        self.priority_queues[ queue ].items = [];
        self.priority_queues[ queue ].items[ 0 ] = item;
        thread function_a21a0cb1935daf63( queue );
        return;
    }
    
    index = self.priority_queues[ queue ].items.size;
    ref_updated = 0;
    
    foreach ( idx, data in self.priority_queues[ queue ].items )
    {
        if ( item.ref != "default" && item.ref == data.ref )
        {
            if ( idx == 0 )
            {
                assert( "<dev string:x1c>" + item.ref + "<dev string:x29>" + queue + "<dev string:x37>" );
                return;
            }
            
            self.priority_queues[ queue ].items[ idx ] = item;
            ref_updated = 1;
            break;
        }
        
        if ( !isdefined( index ) && item.priority > data.priority )
        {
            index = idx;
        }
    }
    
    if ( !ref_updated && isdefined( index ) )
    {
        self.priority_queues[ queue ].items = array_insert( self.priority_queues[ queue ].items, item, index );
        
        if ( index == 0 )
        {
            thread function_b4f70eec2b62bbc5( queue, self.priority_queues[ queue ].items[ 1 ] );
        }
    }
}

// Namespace queue / scripts\common\queue
// Params 2
// Checksum 0x0, Offset: 0x48d
// Size: 0xc9
function function_46d80f020560ce6( queue, ref )
{
    if ( isdefined( self.priority_queues ) && isdefined( self.priority_queues[ queue ] ) )
    {
        for ( i = self.priority_queues[ queue ].items.size - 1; i >= 0 ; i-- )
        {
            if ( self.priority_queues[ queue ].items[ i ].ref == ref )
            {
                self.priority_queues[ queue ].items = array_remove_index( self.priority_queues[ queue ].items, i );
                
                if ( i == 0 )
                {
                    self notify( queue + "_removed" );
                }
            }
        }
    }
}

// Namespace queue / scripts\common\queue
// Params 1
// Checksum 0x0, Offset: 0x55e
// Size: 0x58
function function_5bf3778b0956a0ab( queue )
{
    if ( isdefined( self.priority_queues ) && isdefined( self.priority_queues[ queue ] ) )
    {
        if ( self.priority_queues[ queue ].items.size > 0 )
        {
            self notify( queue + "_removed" );
        }
        
        self.priority_queues[ queue ] = undefined;
    }
}

// Namespace queue / scripts\common\queue
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5be
// Size: 0x293
function private function_a21a0cb1935daf63( queue )
{
    self endon( "death" );
    self endon( "entitydeleted" );
    
    while ( isdefined( self.priority_queues[ queue ] ) && self.priority_queues[ queue ].items.size > 0 )
    {
        item = self.priority_queues[ queue ].items[ 0 ];
        item.start_time = gettime();
        
        if ( isdefined( item.break_func ) && self [[ item.break_func ]]( item.func_params, item.start_time, 1 ) )
        {
            self.priority_queues[ queue ].items = array_remove_index( self.priority_queues[ queue ].items, 0 );
            continue;
        }
        
        if ( isdefined( item.init_func ) )
        {
            self thread [[ item.init_func ]]( item.func_params, item.start_time, [ queue + "_removed", queue + "_interrupted", queue + "_done" ] );
        }
        
        if ( isdefined( item.break_func ) )
        {
            childthread function_83c2eeef11738a5d( queue, item );
        }
        
        ret = undefined;
        
        if ( isdefined( item.duration ) )
        {
            if ( isdefined( item.break_notify ) )
            {
                ret = waittill_any_timeout_4( item.duration, item.break_notify, queue + "_break", queue + "_removed", queue + "_interrupted" );
            }
            else
            {
                ret = waittill_any_timeout_3( item.duration, queue + "_break", queue + "_removed", queue + "_interrupted" );
            }
        }
        else if ( isdefined( item.break_notify ) )
        {
            ret = waittill_any_return_4( item.break_notify, queue + "_break", queue + "_removed", queue + "_interrupted" );
        }
        else
        {
            ret = waittill_any_return_3( queue + "_break", queue + "_removed", queue + "_interrupted" );
        }
        
        if ( ret == "timeout" || ret == queue + "_break" || isdefined( item.break_notify ) && ret == item.break_notify )
        {
            function_e4f3902eebc8816d( queue, item );
            continue;
        }
        
        if ( ret == queue + "_removed" )
        {
            function_b4f70eec2b62bbc5( queue, item );
        }
    }
}

// Namespace queue / scripts\common\queue
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x859
// Size: 0x63
function private function_83c2eeef11738a5d( queue, item )
{
    self endon( queue + "_done" );
    self endon( queue + "_removed" );
    self endon( queue + "_interrupted" );
    
    while ( !self [[ item.break_func ]]( item.func_params, item.start_time ) )
    {
        waitframe();
    }
    
    self notify( queue + "_break" );
}

// Namespace queue / scripts\common\queue
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x8c4
// Size: 0x52
function private function_b4f70eec2b62bbc5( queue, item )
{
    if ( isdefined( item.interrupt_func ) )
    {
        self thread [[ item.interrupt_func ]]( item.func_params, item.start_time );
    }
    
    self notify( queue + "_interrupted" );
}

// Namespace queue / scripts\common\queue
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x91e
// Size: 0x84
function private function_e4f3902eebc8816d( queue, item )
{
    if ( isdefined( item.finish_func ) )
    {
        self thread [[ item.finish_func ]]( item.func_params, item.start_time );
    }
    
    self notify( queue + "_done" );
    self.priority_queues[ queue ].items = array_remove_index( self.priority_queues[ queue ].items, 0 );
}

