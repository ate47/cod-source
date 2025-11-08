#using script_1096bc9315122e88;
#using script_575fda2758b0a36e;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;

#namespace namespace_9d3605fe2ce73dd9;

// Namespace namespace_9d3605fe2ce73dd9 / namespace_6d3783f7267c4bca
// Params 0
// Checksum 0x0, Offset: 0x152
// Size: 0xa
function init()
{
    thread activities_init();
}

// Namespace namespace_9d3605fe2ce73dd9 / namespace_6d3783f7267c4bca
// Params 0
// Checksum 0x0, Offset: 0x164
// Size: 0xd4
function activities_init()
{
    if ( isplatformps5() )
    {
        while ( !isdefined( level.script ) )
        {
            waitframe();
        }
        
        index = namespace_d6cca25f4b0ab62::getlevelindex( level.script );
        
        if ( isdefined( index ) )
        {
            level.ps5activity = level.missionsettings.levels[ index ].name;
        }
        else
        {
            level.ps5activity = level.script;
        }
        
        /#
            if ( level.ps5activity == "<dev string:x1c>" )
            {
                level.ps5activity = "<dev string:x29>";
            }
        #/
        
        /#
            setdvarifuninitialized( @"hash_f270b4040fc5585b", 0 );
        #/
        
        println( "<dev string:x39>" + level.ps5activity );
        startactivity( level.ps5activity );
    }
}

// Namespace namespace_9d3605fe2ce73dd9 / namespace_6d3783f7267c4bca
// Params 3
// Checksum 0x0, Offset: 0x240
// Size: 0x66
function function_61cb8298cb7adf01( activityname, state, stopstate )
{
    if ( !isplatformps5() )
    {
        return;
    }
    
    if ( !isdefined( activityname ) )
    {
        return;
    }
    
    if ( !isdefined( state ) )
    {
        return;
    }
    
    if ( state == "start" )
    {
        startactivity( activityname );
        return;
    }
    
    if ( state == "stop" )
    {
        if ( !isdefined( stopstate ) )
        {
            stopstate = "completed";
        }
        
        stopactivity( activityname, stopstate );
        return;
    }
    
    return;
}

// Namespace namespace_9d3605fe2ce73dd9 / namespace_6d3783f7267c4bca
// Params 3
// Checksum 0x0, Offset: 0x2ae
// Size: 0x66
function function_d1a8270c167e8a4f( taskname, state, stopstate )
{
    if ( !isplatformps5() )
    {
        return;
    }
    
    if ( !isdefined( taskname ) )
    {
        return;
    }
    
    if ( !isdefined( state ) )
    {
        return;
    }
    
    if ( state == "start" )
    {
        startactivitytask( taskname );
        return;
    }
    
    if ( state == "stop" )
    {
        if ( !isdefined( stopstate ) )
        {
            stopstate = "completed";
        }
        
        stopactivitytask( taskname, stopstate );
        return;
    }
    
    return;
}

// Namespace namespace_9d3605fe2ce73dd9 / namespace_6d3783f7267c4bca
// Params 1
// Checksum 0x0, Offset: 0x31c
// Size: 0x56
function function_1c2bbc8867668ba3( first_task )
{
    if ( !isplatformps5() )
    {
        return;
    }
    
    assertex( isstring( first_task ), "Need a id for the first task to start!" );
    
    /#
        if ( getdvarint( @"hash_f270b4040fc5585b" ) )
        {
            iprintln( "<dev string:x59>" + first_task );
        }
    #/
    
    namespace_6d3783f7267c4bca::function_d1a8270c167e8a4f( first_task, "start" );
}

// Namespace namespace_9d3605fe2ce73dd9 / namespace_6d3783f7267c4bca
// Params 2
// Checksum 0x0, Offset: 0x37a
// Size: 0x82
function function_e001fad729f058b0( last_task, next_task )
{
    if ( !isplatformps5() )
    {
        return;
    }
    
    assertex( isstring( last_task ) && isstring( next_task ), "Please provide an id for the task to close and the new task to begin." );
    
    /#
        if ( getdvarint( @"hash_f270b4040fc5585b" ) )
        {
            iprintln( "<dev string:x8e>" + last_task + "<dev string:xba>" + next_task );
        }
    #/
    
    namespace_6d3783f7267c4bca::function_d1a8270c167e8a4f( last_task, "stop", "completed" );
    namespace_6d3783f7267c4bca::function_d1a8270c167e8a4f( next_task, "start" );
}

// Namespace namespace_9d3605fe2ce73dd9 / namespace_6d3783f7267c4bca
// Params 1
// Checksum 0x0, Offset: 0x404
// Size: 0x61
function function_849e707497dfdd92( last_task )
{
    if ( !isplatformps5() )
    {
        return;
    }
    
    assertex( isstring( last_task ), "Need an id for the last task for the currently active activity." );
    
    /#
        if ( getdvarint( @"hash_f270b4040fc5585b" ) )
        {
            iprintln( "<dev string:xbf>" + last_task + "<dev string:xf2>" );
        }
    #/
    
    namespace_6d3783f7267c4bca::function_d1a8270c167e8a4f( last_task, "stop", "completed" );
}

