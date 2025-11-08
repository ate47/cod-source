#using scripts\common\utility;
#using scripts\engine\utility;

#namespace conditional_container;

// Namespace conditional_container / scripts\common\conditional_container
// Params 0
// Checksum 0x0, Offset: 0xb1
// Size: 0x17
function function_a1f71337a6844055()
{
    self.conditions = [];
    self.var_cb7d9fafcbb7a3da = 1;
}

// Namespace conditional_container / scripts\common\conditional_container
// Params 0
// Checksum 0x0, Offset: 0xd0
// Size: 0xc, Type: bool
function function_cb7d9fafcbb7a3da()
{
    return istrue( self.var_cb7d9fafcbb7a3da );
}

// Namespace conditional_container / scripts\common\conditional_container
// Params 5
// Checksum 0x0, Offset: 0xe5
// Size: 0xb5
function addcondition( conditionalcontainer, conditionalfunction, var_a5bcfea80579d73d, uniquename, description )
{
    if ( !isdefined( uniquename ) )
    {
        uniquename = undefined;
    }
    
    if ( !isdefined( description ) )
    {
        description = "No Description Given.";
    }
    
    assertex( conditionalcontainer function_cb7d9fafcbb7a3da(), "<dev string:x1c>" );
    conditioninfo = spawnstruct();
    conditioninfo.function = conditionalfunction;
    conditioninfo.params = var_a5bcfea80579d73d;
    conditioninfo.uniquename = uniquename;
    conditioninfo.description = description;
    conditionalcontainer.conditions[ conditionalcontainer.conditions.size ] = conditioninfo;
}

// Namespace conditional_container / scripts\common\conditional_container
// Params 2
// Checksum 0x0, Offset: 0x1a2
// Size: 0xa4
function removecondition( conditionalcontainer, uniquename )
{
    assertex( conditionalcontainer function_cb7d9fafcbb7a3da(), "<dev string:x1c>" );
    
    for ( index = 0; index < conditionalcontainer.conditions.size ; index++ )
    {
        conditioninfo = conditionalcontainer.conditions[ index ];
        
        if ( isdefined( conditioninfo.uniquename ) && conditioninfo.uniquename == uniquename )
        {
            conditionalcontainer.conditions = array_remove_index( conditionalcontainer.conditions, index );
            break;
        }
    }
}

// Namespace conditional_container / scripts\common\conditional_container
// Params 1
// Checksum 0x0, Offset: 0x24e
// Size: 0x2d
function removeallconditions( conditionalcontainer )
{
    assertex( conditionalcontainer function_cb7d9fafcbb7a3da(), "<dev string:x1c>" );
    conditionalcontainer.conditions = [];
}

// Namespace conditional_container / scripts\common\conditional_container
// Params 2
// Checksum 0x0, Offset: 0x283
// Size: 0xa1, Type: bool
function function_93587d5ba6247f36( conditionalcontainer, object )
{
    assertex( conditionalcontainer function_cb7d9fafcbb7a3da(), "<dev string:x1c>" );
    
    foreach ( condition in conditionalcontainer.conditions )
    {
        result = [[ condition.function ]]( object, condition.params );
        
        if ( !result )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace conditional_container / scripts\common\conditional_container
// Params 2
// Checksum 0x0, Offset: 0x32d
// Size: 0xb8
function function_ff013f3a89dabca4( conditionalcontainer, object )
{
    assertex( conditionalcontainer function_cb7d9fafcbb7a3da(), "<dev string:x1c>" );
    
    foreach ( condition in conditionalcontainer.conditions )
    {
        result = [[ condition.function ]]( object, condition.params );
        
        if ( !result )
        {
            return function_8a34819737ceea8f( 0, condition.description );
        }
    }
    
    return function_8a34819737ceea8f( 1 );
}

// Namespace conditional_container / scripts\common\conditional_container
// Params 6
// Checksum 0x0, Offset: 0x3ee
// Size: 0xfc
function function_21987527fd4733ad( conditionalcontainer, object, var_ef09bb69811327d1, var_5288a299caa0504e, var_717b087350a6df2f, var_3b7ed38c07818629 )
{
    /#
        var_cb7d9fafcbb7a3da = conditionalcontainer function_cb7d9fafcbb7a3da();
        objectisdefined = isdefined( object );
        var_3938d5f50103e0fa = isfunction( var_ef09bb69811327d1 );
        var_8105433f3dcf58a = !isdefined( var_5288a299caa0504e ) || isstruct( var_5288a299caa0504e );
        var_a28904f7e273e263 = 1;
        
        if ( !var_cb7d9fafcbb7a3da )
        {
            iprintln( "<dev string:x92>" );
            var_a28904f7e273e263 = 0;
        }
        
        if ( !objectisdefined )
        {
            iprintln( "<dev string:xca>" );
            var_a28904f7e273e263 = 0;
        }
        
        if ( !var_3938d5f50103e0fa )
        {
            iprintln( "<dev string:xf6>" );
            var_a28904f7e273e263 = 0;
        }
        
        if ( !var_8105433f3dcf58a )
        {
            iprintln( "<dev string:x157>" );
            var_a28904f7e273e263 = 0;
        }
        
        if ( !var_a28904f7e273e263 )
        {
            assertmsg( "<dev string:x1be>" );
            return;
        }
    #/
    
    level thread function_1b7df7adf29a85c6( conditionalcontainer, object, var_ef09bb69811327d1, var_5288a299caa0504e, var_717b087350a6df2f, var_3b7ed38c07818629 );
}

// Namespace conditional_container / scripts\common\conditional_container
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x4f2
// Size: 0xc0
function private function_1b7df7adf29a85c6( conditionalcontainer, object, var_ef09bb69811327d1, var_5288a299caa0504e, var_717b087350a6df2f, var_3b7ed38c07818629 )
{
    var_3b7ed38c07818629 = default_to( var_3b7ed38c07818629, 0.5 );
    var_717b087350a6df2f = default_to( var_717b087350a6df2f, 5 );
    var_be685114ee68c2f3 = gettime();
    shouldcontinuecheckingconditions = 1;
    
    while ( shouldcontinuecheckingconditions )
    {
        var_b7d39a4661f3460 = gettime();
        timepassedinseconds = ( var_b7d39a4661f3460 - var_be685114ee68c2f3 ) / 1000;
        
        if ( isdefined( object ) && function_93587d5ba6247f36( conditionalcontainer, object ) )
        {
            object thread [[ var_ef09bb69811327d1 ]]( var_5288a299caa0504e );
            shouldcontinuecheckingconditions = 0;
            return;
        }
        
        if ( timepassedinseconds >= var_717b087350a6df2f )
        {
            shouldcontinuecheckingconditions = 0;
            break;
        }
        
        wait var_3b7ed38c07818629;
    }
}

// Namespace conditional_container / scripts\common\conditional_container
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5ba
// Size: 0x4c
function private function_8a34819737ceea8f( var_f422d25d885419b5, description )
{
    if ( !isdefined( description ) )
    {
        description = "No Description Given.";
    }
    
    var_2e1dd56cac3d3e71 = spawnstruct();
    var_2e1dd56cac3d3e71.var_3cae69b2d0f4ae72 = var_f422d25d885419b5;
    var_2e1dd56cac3d3e71.var_4b6d8587438ed9aa = description;
    return var_2e1dd56cac3d3e71;
}

