#using scripts\unittest\util;

#namespace unittest_threads;

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x423
// Size: 0x32
function thread_wait()
{
    test_print( "thread_wait: 0" );
    wait 0.1;
    test_print( "thread_wait: 1" );
    wait 0.1;
    test_print( "thread_wait: 2" );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 1
// Checksum 0x0, Offset: 0x45d
// Size: 0x2d
function f_resume( i )
{
    test_print( "f_resume: 0: " + i );
    wait 0.1;
    test_print( "f_resume: 1: " + i );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x492
// Size: 0x2a
function thread_resume()
{
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_resume( i );
    }
    
    wait 0.2;
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 1
// Checksum 0x0, Offset: 0x4c4
// Size: 0x55
function f_notify( i )
{
    test_print( "f_notify wait: " + i );
    level waittill( "f", x, y );
    test_print( "f_notify: " + i + " " + x + " " + y );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x521
// Size: 0x33
function thread_wait_notify()
{
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_notify( i );
    }
    
    level notify( "f", 1, "a" );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x55c
// Size: 0xc
function thread_terminate_child()
{
    level notify( "thread_terminate_endon" );
    return 2;
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x571
// Size: 0x14, Type: bool
function thread_terminate_wrapper()
{
    level endon( "thread_terminate_endon" );
    level thread thread_terminate_child();
    return true;
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x58e
// Size: 0x35
function thread_terminate_notify()
{
    x = thread_terminate_wrapper();
    
    if ( !isdefined( x ) )
    {
        test_print( "thread_terminate_notify: <undefined>" );
        return;
    }
    
    test_print( "thread_terminate_notify: " + x );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 2
// Checksum 0x0, Offset: 0x5cb
// Size: 0x3a
function f_match( notifystr, i )
{
    test_print( "f_match wait: " + i );
    level waittillmatch( notifystr, "yes" );
    test_print( "f_match: " + i );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 1
// Checksum 0x0, Offset: 0x60d
// Size: 0x2d
function waittillmatch_wait( index )
{
    test_print( "waittillmatch_wait: " + index );
    wait 1;
    test_print( "waittillmatch_wait end: " + index );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 1
// Checksum 0x0, Offset: 0x642
// Size: 0x33
function waittillmatch_loop( index )
{
    level endon( "waittillmatch_end" );
    
    while ( true )
    {
        level waittillmatch( "wtm_loop", "loop" );
        level thread waittillmatch_wait( index );
    }
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x67d
// Size: 0xaa
function thread_waittill_match()
{
    notifystr = "f";
    
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_match( notifystr, i );
    }
    
    test_print( "thread waittillmatch no" );
    level notify( notifystr, "no" );
    test_print( "thread waittillmatch yes" );
    level notify( notifystr, "yes" );
    
    for ( i = 0; i < 4 ; i++ )
    {
        level thread waittillmatch_loop( i );
    }
    
    waittillframeend();
    level notify( "wtm_loop", "nope" );
    level notify( "wtm_loop", "loop" );
    waittillframeend();
    level notify( "wtm_loop", "loop" );
    level notify( "waittillmatch_end" );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 1
// Checksum 0x0, Offset: 0x72f
// Size: 0x26
function f_endon( i )
{
    level endon( "f_endon" );
    
    for ( ;; )
    {
        test_print( "f_endon: " + i );
        wait 10;
    }
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 1
// Checksum 0x0, Offset: 0x75d
// Size: 0x56
function stack_endon_recurse( i )
{
    if ( i < 0 )
    {
        test_print( "stack_endon: notify before" );
        level notify( "stack_endon" );
        test_print( "stack_endon: notify after" );
    }
    
    test_print( "stack_endon: " + i );
    stack_endon_recurse( i - 1 );
    test_print( "stack_endon_recurse: end" );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x7bb
// Size: 0x12
function stack_endon()
{
    level endon( "stack_endon" );
    stack_endon_recurse( 3 );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x7d5
// Size: 0x51
function thread_endon()
{
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_endon( i );
    }
    
    wait 0.1;
    level notify( "f_endon" );
    test_print( "stack_endon: begin" );
    stack_endon();
    test_print( "stack_endon: end" );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 1
// Checksum 0x0, Offset: 0x82e
// Size: 0x42
function f_churn( i )
{
    test_print( "f_churn wait: " + i );
    level waittill( "churn", x );
    test_print( "f_churn notify: " + i + ": " + x );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x878
// Size: 0x24
function thread_churn()
{
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_churn( i );
    }
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x8a4
// Size: 0xc
function thread_churn_notify()
{
    level notify( "churn", 4 );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 1
// Checksum 0x0, Offset: 0x8b8
// Size: 0x28
function f_waitframe( i )
{
    test_print( "f_waitframe wait: " + i );
    waitframe();
    test_print( "f_waitframe: " + i );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x8e8
// Size: 0x24
function thread_waitframe()
{
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_waitframe( i );
    }
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 1
// Checksum 0x0, Offset: 0x914
// Size: 0x28
function f_waitframeend( i )
{
    test_print( "f_waitframeend wait: " + i );
    waittillframeend();
    test_print( "f_waitframeend: " + i );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x944
// Size: 0x24
function thread_waitframeend()
{
    for ( i = 0; i < 10 ; i++ )
    {
        thread f_waitframeend( i );
    }
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x970
// Size: 0x37
function f_running_func()
{
    for ( i = 0; true ; i++ )
    {
        test_print( "f_running: " + i );
        
        if ( i == 3 )
        {
            level notify( "f_running" );
        }
    }
    
    return i;
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x9b0
// Size: 0xf
function f_running_func_call()
{
    level endon( "f_running" );
    return f_running_func();
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x9c8
// Size: 0x10
function f_running_thread_call()
{
    level endon( "f_running" );
    return childthread f_running_func();
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0x9e1
// Size: 0x21
function f_running_nested_1()
{
    test_print( "f_nested_1: pre" );
    f_running_nested_2();
    test_print( "f_nested_1: post" );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0xa0a
// Size: 0x28
function f_running_nested_2()
{
    level endon( "f_running" );
    test_print( "f_nested_2: pre" );
    f_running_nested_3();
    test_print( "f_nested_2: post" );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0xa3a
// Size: 0x21
function f_running_nested_3()
{
    test_print( "f_nested_3: pre" );
    f_running_nested_4();
    test_print( "f_nested_3: post" );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0xa63
// Size: 0x29
function f_running_nested_4()
{
    test_print( "f_nested_4: pre" );
    f_running_nested_5();
    level notify( "f_running" );
    test_print( "f_nested_4: post" );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0xa94
// Size: 0xe
function f_running_nested_5()
{
    test_print( "f_nested_5" );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0xaaa
// Size: 0x22
function f_running_nested_call()
{
    test_print( "f_nested: pre" );
    thread f_running_nested_1();
    test_print( "f_nested: post" );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0xad4
// Size: 0x53
function thread_running_notify()
{
    i = thread f_running_func_call();
    test_print( "thread_running_func_call: IsDefined: " + isdefined( i ) );
    i = thread f_running_thread_call();
    test_print( "thread_running_thread_call: IsDefined: " + isdefined( i ) );
    i = thread f_running_nested_call();
    test_print( "thread_running_nested_call: IsDefined: " + isdefined( i ) );
}

// Namespace unittest_threads / scripts\unittest\threads
// Params 0
// Checksum 0x0, Offset: 0xb2f
// Size: 0x98
function main()
{
    test_begin( "Threads" );
    thread_churn();
    thread_wait();
    wait 0.1;
    thread_resume();
    wait 0.1;
    thread_wait_notify();
    wait 0.1;
    thread_terminate_notify();
    wait 0.1;
    thread_waittill_match();
    wait 0.1;
    thread_endon();
    wait 0.1;
    thread_waitframe();
    wait 0.1;
    thread_waitframeend();
    wait 0.1;
    thread_running_notify();
    thread_churn_notify();
    waittillframeend();
    test_end( "Threads" );
}

