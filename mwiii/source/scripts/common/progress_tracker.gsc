#using scripts\common\utility;
#using scripts\engine\utility;

#namespace progress_tracker;

// Namespace progress_tracker / scripts\common\progress_tracker
// Params 2
// Checksum 0x0, Offset: 0x98
// Size: 0x83
function createprogresstracker( startingprogressvalue, finalprogressvalue )
{
    progresstracker = spawnstruct();
    progresstracker.progresscomplete = 0;
    progresstracker.callbacks = [];
    progresstracker.startingprogressvalue = startingprogressvalue;
    progresstracker.currentprogressvalue = startingprogressvalue;
    progresstracker.finalprogressvalue = finalprogressvalue;
    
    /#
        if ( isdefined( finalprogressvalue ) && startingprogressvalue == finalprogressvalue )
        {
            assertmsg( "<dev string:x1c>" );
        }
    #/
    
    return progresstracker;
}

// Namespace progress_tracker / scripts\common\progress_tracker
// Params 0
// Checksum 0x0, Offset: 0x124
// Size: 0x32
function function_cfeb21bf93c30dae()
{
    assertex( isdefined( self.finalprogressvalue ), "<dev string:x8c>" );
    return abs( self.finalprogressvalue - self.currentprogressvalue );
}

// Namespace progress_tracker / scripts\common\progress_tracker
// Params 1
// Checksum 0x0, Offset: 0x15f
// Size: 0x15
function setuniquename( uniquename )
{
    self.uniquename = uniquename;
}

// Namespace progress_tracker / scripts\common\progress_tracker
// Params 0
// Checksum 0x0, Offset: 0x17c
// Size: 0x3d
function getuniquename()
{
    /#
        if ( !isdefined( self.uniquename ) || self.uniquename == "<dev string:xd3>" )
        {
            assertmsg( "<dev string:xd7>" );
        }
    #/
    
    return self.uniquename;
}

// Namespace progress_tracker / scripts\common\progress_tracker
// Params 0
// Checksum 0x0, Offset: 0x1c2
// Size: 0xb
function iscomplete()
{
    return self.progresscomplete;
}

// Namespace progress_tracker / scripts\common\progress_tracker
// Params 2
// Checksum 0x0, Offset: 0x1d6
// Size: 0x54
function addcallback( callonobject, callbackfunction )
{
    newcallback = spawnstruct();
    newcallback.callon = callonobject;
    newcallback.callbackfunction = callbackfunction;
    self.callbacks[ self.callbacks.size ] = newcallback;
}

// Namespace progress_tracker / scripts\common\progress_tracker
// Params 0
// Checksum 0x0, Offset: 0x232
// Size: 0x9b
function function_e619a5f97879fa4a()
{
    var_9eb651441b8f9d6f = 0;
    
    foreach ( callback in self.callbacks )
    {
        if ( isdefined( callback ) )
        {
            callback.callon [[ callback.callbackfunction ]]( self );
            continue;
        }
        
        var_9eb651441b8f9d6f = 1;
    }
    
    if ( var_9eb651441b8f9d6f )
    {
        self.callbacks = array_removeundefined( self.callbacks );
    }
}

// Namespace progress_tracker / scripts\common\progress_tracker
// Params 1
// Checksum 0x0, Offset: 0x2d5
// Size: 0x3d
function incrementcurrentprogress( incrementvalue )
{
    if ( iscomplete() )
    {
        return;
    }
    
    if ( !isdefined( incrementvalue ) )
    {
        incrementvalue = 1;
    }
    
    var_8ccf1248fb22534c = self.currentprogressvalue + incrementvalue;
    function_c664e1d4584b1dcd( var_8ccf1248fb22534c );
}

// Namespace progress_tracker / scripts\common\progress_tracker
// Params 1
// Checksum 0x0, Offset: 0x31a
// Size: 0x46
function decrementcurrentprogress( decrementvalue )
{
    if ( iscomplete() )
    {
        return;
    }
    
    if ( !isdefined( decrementvalue ) )
    {
        decrementvalue = 1;
    }
    
    decrementedprogress = self.currentprogressvalue - decrementvalue;
    decrementedprogress = max( decrementedprogress, 0 );
    function_c664e1d4584b1dcd( decrementedprogress );
}

// Namespace progress_tracker / scripts\common\progress_tracker
// Params 1
// Checksum 0x0, Offset: 0x368
// Size: 0x40
function setcurrentprogress( progressvalue )
{
    if ( progressvalue < self.currentprogressvalue )
    {
        decrementcurrentprogress( self.currentprogressvalue - progressvalue );
        return;
    }
    
    incrementcurrentprogress( progressvalue - self.currentprogressvalue );
}

// Namespace progress_tracker / scripts\common\progress_tracker
// Params 1
// Checksum 0x0, Offset: 0x3b0
// Size: 0x3f
function setfinalvalue( finalvalue )
{
    if ( iscomplete() )
    {
        return;
    }
    
    assertex( isdefined( finalvalue ), "<dev string:x112>" );
    self.finalprogressvalue = finalvalue;
    function_c664e1d4584b1dcd( self.currentprogressvalue );
}

// Namespace progress_tracker / scripts\common\progress_tracker
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3f7
// Size: 0x4d
function private function_c664e1d4584b1dcd( newprogressvalue )
{
    self.progresscomplete = function_c076b6b5c85274d8( newprogressvalue );
    
    if ( self.progresscomplete )
    {
        self.currentprogressvalue = self.finalprogressvalue;
    }
    else
    {
        self.currentprogressvalue = newprogressvalue;
    }
    
    function_e619a5f97879fa4a();
}

// Namespace progress_tracker / scripts\common\progress_tracker
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x44c
// Size: 0xdc, Type: bool
function private function_c076b6b5c85274d8( newprogressvalue )
{
    if ( !isdefined( self.finalprogressvalue ) )
    {
        return false;
    }
    
    var_47378a790f40bbe2 = self.startingprogressvalue < self.finalprogressvalue && newprogressvalue >= self.finalprogressvalue;
    var_e1836bac44cbf54a = self.startingprogressvalue > self.finalprogressvalue && newprogressvalue <= self.finalprogressvalue;
    var_feef1209b8b0a9ea = self.startingprogressvalue == self.finalprogressvalue || iscomplete();
    var_d49232a821579d29 = isfloat( newprogressvalue ) && abs( newprogressvalue - self.finalprogressvalue ) <= 0.25;
    
    if ( var_47378a790f40bbe2 || var_e1836bac44cbf54a || var_feef1209b8b0a9ea || var_d49232a821579d29 )
    {
        return true;
    }
    
    return false;
}

