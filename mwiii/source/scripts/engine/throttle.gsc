#using scripts\engine\utility;

#namespace throttle;

// Namespace throttle / scripts\engine\throttle
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x419
// Size: 0x34
function private function_9520a7d8b5aee737( throttle )
{
    throttle endon( throttle.var_a7774b82d7309ed7 );
    
    while ( isdefined( throttle ) )
    {
        function_4707c765d202d592( throttle );
        wait throttle.updaterate_;
    }
}

// Namespace throttle / scripts\engine\throttle
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x455
// Size: 0xae
function private function_4707c765d202d592( throttle )
{
    processed = 0;
    
    foreach ( item in throttle.queue_ )
    {
        if ( !isdefined( item ) )
        {
            continue;
        }
        
        throttle.queue_ = array_remove( throttle.queue_, item );
        item notify( throttle.var_35615e062783af3e );
        processed++;
        
        if ( processed >= throttle.processlimit_ )
        {
            break;
        }
    }
}

// Namespace throttle / scripts\engine\throttle
// Params 4
// Checksum 0x0, Offset: 0x50b
// Size: 0xcf
function throttle_initialize( name, processlimit, updaterate, queuelimit )
{
    processlimit = default_to( processlimit, 1 );
    
    if ( processlimit == 0 )
    {
        return undefined;
    }
    
    assert( isdefined( name ) && isstring( name ) );
    throttle = spawnstruct();
    throttle.queue_ = [];
    throttle.var_35615e062783af3e = name + "_wake_up";
    throttle.var_a7774b82d7309ed7 = name + "_stop_threads";
    throttle.processlimit_ = processlimit;
    throttle.updaterate_ = default_to( updaterate, level.framedurationseconds );
    throttle.queuelimit_ = queuelimit;
    thread function_9520a7d8b5aee737( throttle );
    return throttle;
}

// Namespace throttle / scripts\engine\throttle
// Params 1
// Checksum 0x0, Offset: 0x5e3
// Size: 0x21
function throttle_destroy( throttle )
{
    if ( isdefined( throttle ) )
    {
        throttle notify( throttle.var_a7774b82d7309ed7 );
        throttle = undefined;
    }
}

// Namespace throttle / scripts\engine\throttle
// Params 2
// Checksum 0x0, Offset: 0x60c
// Size: 0xed
function function_f632348cbb773537( throttle, entity )
{
    assertex( !isdefined( throttle.gate ), "<dev string:x1c>" );
    throttle endon( throttle.var_a7774b82d7309ed7 );
    
    if ( !isdefined( throttle ) )
    {
        assertmsg( "<dev string:x75>" );
        return;
    }
    
    while ( isdefined( throttle.queuelimit_ ) && throttle.queue_.size > throttle.queuelimit_ )
    {
        function_4707c765d202d592( throttle );
    }
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( !isent( entity ) && !isstruct( entity ) )
    {
        return;
    }
    
    if ( !arraycontains( throttle.queue_, entity ) )
    {
        throttle.queue_[ throttle.queue_.size ] = entity;
    }
    
    entity endon( "death" );
    entity endon( "delete" );
    entity waittill( throttle.var_35615e062783af3e );
}

// Namespace throttle / scripts\engine\throttle
// Params 2
// Checksum 0x0, Offset: 0x701
// Size: 0x25
function function_11ab6d104bf77779( throttle, entity )
{
    return array_contains( throttle.queue_, entity );
}

// Namespace throttle / scripts\engine\throttle
// Params 2
// Checksum 0x0, Offset: 0x72f
// Size: 0x31
function function_8ce6c42c18618555( throttle, entity )
{
    throttle.queue_ = array_remove( throttle.queue_, entity );
}

// Namespace throttle / scripts\engine\throttle
// Params 3
// Checksum 0x0, Offset: 0x768
// Size: 0xaf
function function_af33edfaf05fc572( name, processlimit, updaterate )
{
    processlimit = default_to( processlimit, 1 );
    
    if ( processlimit == 0 )
    {
        return undefined;
    }
    
    assert( isdefined( name ) && isstring( name ) );
    throttle = spawnstruct();
    throttle.var_a7774b82d7309ed7 = name + "_stop_threads";
    throttle.var_be94a08fd7e08d14 = 0;
    throttle.processlimit_ = processlimit;
    throttle.updaterate_ = default_to( updaterate, level.framedurationseconds );
    
    /#
        throttle.gate = 1;
    #/
    
    return throttle;
}

// Namespace throttle / scripts\engine\throttle
// Params 1
// Checksum 0x0, Offset: 0x820
// Size: 0x87
function function_6f7b33660ae155ef( throttle )
{
    assertex( throttle.gate, "<dev string:x91>" );
    
    if ( !isdefined( throttle ) )
    {
        assertmsg( "<dev string:x75>" );
        return;
    }
    
    if ( throttle.var_be94a08fd7e08d14 >= throttle.processlimit_ )
    {
        throttle endon( throttle.var_a7774b82d7309ed7 );
        wait throttle.updaterate_;
        throttle.var_be94a08fd7e08d14 = 0;
    }
    
    throttle.var_be94a08fd7e08d14++;
}

// Namespace throttle / scripts\engine\throttle
// Params 0
// Checksum 0x0, Offset: 0x8af
// Size: 0x25
function function_ffc20a0cd9408d3e()
{
    throttle_ut_initialize();
    throttle_ut_queue();
    throttle_ut_queue_10();
    throttle_ut_queue_10_threaded();
    throttle_ut_leave_queue();
}

// Namespace throttle / scripts\engine\throttle
// Params 1
// Checksum 0x0, Offset: 0x8dc
// Size: 0x1e
function test_print( msg )
{
    /#
        msg = "<dev string:xeb>" + msg;
        println( msg );
    #/
}

// Namespace throttle / scripts\engine\throttle
// Params 0
// Checksum 0x0, Offset: 0x902
// Size: 0x259
function throttle_ut_initialize()
{
    test_print( "BEGIN throttle_UT_initialize" );
    test_throttle = throttle_initialize( "test_throttle_1", 1, level.framedurationseconds );
    test_print( "CALL - throttle_initialize( test_throttle_1, " + 1 + ", " + level.framedurationseconds + ")" );
    assert( isarray( test_throttle.queue_ ) && test_throttle.queue_.size == 0 );
    assert( test_throttle.var_35615e062783af3e == "<dev string:xfe>" + "<dev string:x111>" );
    assert( test_throttle.processlimit_ == 1 );
    assert( test_throttle.updaterate_ == level.framedurationseconds );
    assert( test_throttle.queuelimit_ == undefined );
    test_throttle = throttle_initialize( "test_throttle_2", 2, level.framedurationseconds );
    test_print( "CALL - throttle_initialize( test_throttle_2, " + 2 + ", " + level.framedurationseconds + ")" );
    assert( test_throttle.processlimit_ == 2 );
    test_throttle = throttle_initialize( "test_throttle_queueLimit", 1, level.framedurationseconds, 3 );
    test_print( "CALL - throttle_initialize( test_throttle_queueLimit, " + 1 + ", " + level.framedurationseconds + ", " + 3 + ")" );
    assert( test_throttle.queuelimit_ == 3 );
    test_throttle = throttle_initialize( "test_throttle_defaults" );
    test_print( "CALL - throttle_initialize( test_throttle_defaults )" );
    assert( isarray( test_throttle.queue_ ) && test_throttle.queue_.size == 0 );
    assert( test_throttle.var_35615e062783af3e == "<dev string:x11d>" + "<dev string:x111>" );
    assert( test_throttle.processlimit_ == 1 );
    assert( test_throttle.updaterate_ == level.framedurationseconds );
    assert( test_throttle.queuelimit_ == undefined );
    test_print( "END throttle_UT_initialize" );
}

// Namespace throttle / scripts\engine\throttle
// Params 0
// Checksum 0x0, Offset: 0xb63
// Size: 0xc2
function throttle_ut_queue()
{
    test_print( "BEGIN throttle_UT_queue" );
    test_throttle = throttle_initialize( "test_throttle_wait", 1, level.framedurationseconds );
    test_print( "CALL - throttle_initialize( " + 1 + ", " + level.framedurationseconds + ")" );
    entity = spawn( "script_model", ( 0, 0, 0 ) );
    function_f632348cbb773537( test_throttle, entity );
    test_print( "CALL - wait_in_queue" );
    isinqueue = function_11ab6d104bf77779( test_throttle, entity );
    test_print( "Ent in queue: " + isinqueue );
    assert( !isinqueue );
    test_print( "END throttle_UT_queue" );
}

// Namespace throttle / scripts\engine\throttle
// Params 0
// Checksum 0x0, Offset: 0xc2d
// Size: 0x117
function throttle_ut_queue_10()
{
    test_print( "BEGIN throttle_UT_queue_10" );
    test_throttle = throttle_initialize( "test_throttle_wait", 1, level.framedurationseconds );
    test_print( "CALL - throttle_initialize( " + 1 + ", " + level.framedurationseconds + ")" );
    ents = [];
    
    for ( i = 1; i <= 10 ; i++ )
    {
        ents[ ents.size ] = spawn( "script_model", ( 0, 0, 0 ) );
        function_f632348cbb773537( test_throttle, ents[ ents.size - 1 ] );
        test_print( "CALL - wait_in_queue " + i );
        test_print( "Time - " + gettime() );
        test_print( "Ents in Queue - " + test_throttle.queue_.size );
    }
    
    isinqueue = function_11ab6d104bf77779( test_throttle, ents[ 3 ] );
    test_print( "Ent 3 in queue: " + isinqueue );
    assert( !isinqueue );
    test_print( "END throttle_UT_queue_10" );
}

// Namespace throttle / scripts\engine\throttle
// Params 0
// Checksum 0x0, Offset: 0xd4c
// Size: 0x117
function throttle_ut_queue_10_threaded()
{
    test_print( "BEGIN throttle_UT_queue_10_threaded" );
    test_throttle = throttle_initialize( "test_throttle_wait", 1, level.framedurationseconds );
    test_print( "CALL - throttle_initialize( " + 1 + ", " + level.framedurationseconds + ")" );
    ents = [];
    
    for ( i = 1; i <= 10 ; i++ )
    {
        ents[ ents.size ] = spawn( "script_model", ( 0, 0, 0 ) );
        thread function_f632348cbb773537( test_throttle, ents[ ents.size - 1 ] );
        test_print( "CALL - wait_in_queue " + i );
        test_print( "Time - " + gettime() );
        test_print( "Ents in Queue - " + test_throttle.queue_.size );
    }
    
    isinqueue = function_11ab6d104bf77779( test_throttle, ents[ 3 ] );
    test_print( "Ent 3 in queue: " + isinqueue );
    assert( isinqueue );
    test_print( "END throttle_UT_queue_10_threaded" );
}

// Namespace throttle / scripts\engine\throttle
// Params 0
// Checksum 0x0, Offset: 0xe6b
// Size: 0x13c
function throttle_ut_leave_queue()
{
    test_print( "BEGIN throttle_UT_leave_queue" );
    test_throttle = throttle_initialize( "test_throttle_wait", 1, level.framedurationseconds );
    test_print( "CALL - throttle_initialize( " + 1 + ", " + level.framedurationseconds + ")" );
    ents = [];
    
    for ( i = 1; i <= 10 ; i++ )
    {
        ents[ ents.size ] = spawn( "script_model", ( 0, 0, 0 ) );
        thread function_f632348cbb773537( test_throttle, ents[ ents.size - 1 ] );
        test_print( "CALL - wait_in_queue " + i );
        test_print( "Time - " + gettime() );
    }
    
    isinqueue = function_11ab6d104bf77779( test_throttle, ents[ 3 ] );
    test_print( "ent 3 in queue: " + isinqueue );
    assert( isinqueue );
    function_8ce6c42c18618555( test_throttle, ents[ 3 ] );
    test_print( "CALL - leave_queue" );
    isinqueue = function_11ab6d104bf77779( test_throttle, ents[ 3 ] );
    test_print( "ent 3 in queue: " + isinqueue );
    assert( !isinqueue );
    test_print( "END throttle_UT_leave_queue" );
}

