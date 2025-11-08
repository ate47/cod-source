#using scripts\unittest\patch_far;
#using scripts\unittest\util;

#namespace unittest_patch;

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x519
// Size: 0xe
function add()
{
    test_print( "add" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x52f
// Size: 0x2
function patch_self_check()
{
    
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x539
// Size: 0xd
function meth_patch()
{
    self.value = 1;
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x54e
// Size: 0x39
function meth()
{
    s = spawnstruct();
    s meth_patch();
    test_print( "meth: " + s.value );
    patch_self_check();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x58f
// Size: 0x3, Type: bool
function func_patch()
{
    return false;
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x59b
// Size: 0x21
function func()
{
    x = func_patch();
    test_print( "func: " + x );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0x5c4
// Size: 0x3b
function vars_print( s )
{
    test_print( "s.active: " + s.active );
    test_print( "s.notcanon: " + s.notcanon );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0x607
// Size: 0x2b
function vars_update( s )
{
    test_print( "vars_update" );
    vars_print( s );
    test_print( "vars_update: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x63a
// Size: 0x61
function vars()
{
    s = spawnstruct();
    s.active = 1;
    s.notcanon = "hi";
    test_print( "vars" );
    vars_print( s );
    vars_update( s );
    vars_print( s );
    test_print( "vars: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x6a3
// Size: 0xe
function func_thread()
{
    test_print( "func_thread" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0x6b9
// Size: 0x6c
function thread_wait_patch( deep )
{
    x = 0;
    test_print( "thread_wait_patch:(" + x + "): " + deep );
    
    if ( deep == 0 )
    {
        level waittill( "thread_wait" );
    }
    else if ( deep > 0 )
    {
        thread_wait_native( deep - 1 );
    }
    else
    {
        thread thread_wait_native( deep + 1 );
    }
    
    test_print( "thread_wait_patch end: " + deep );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0x72d
// Size: 0x2f
function thread_wait_native( deep )
{
    test_print( "thread_wait_native: " + deep );
    thread_wait_patch( deep );
    test_print( "thread_wait_native end: " + deep );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x764
// Size: 0x2f
function thread_wait_local()
{
    x = 0;
    test_print( "thread_wait_local" );
    thread_wait( 1 );
    test_print( "thread_wait_local end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0x79b
// Size: 0x68
function thread_wait( ignorelocal )
{
    test_print( "thread_wait" );
    thread thread_wait_native( 0 );
    level notify( "thread_wait" );
    waittillframeend();
    thread thread_wait_native( 1 );
    level notify( "thread_wait" );
    waittillframeend();
    thread thread_wait_native( -1 );
    level notify( "thread_wait" );
    waittillframeend();
    
    if ( !istrue( ignorelocal ) )
    {
        thread_wait_local();
        waittillframeend();
    }
    
    test_print( "thread_wait end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x80b
// Size: 0xf
function native_wait()
{
    test_print( "native_wait" );
    waittillframeend();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x822
// Size: 0x3
function patch_wait_frameend()
{
    waittillframeend();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x82d
// Size: 0x22
function patch_wait()
{
    test_print( "patch_wait: start" );
    patch_wait_frameend();
    waittillframeend();
    test_print( "patch_wait: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x857
// Size: 0x1d
function define()
{
    test_print( "define: int: " + 1 + " float: " + 2.2 );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x87c
// Size: 0xe
function f1()
{
    test_print( "fp1" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0x892
// Size: 0x14
function f2( tp )
{
    [[ tp ]]( "fp2" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x8ae
// Size: 0x2e
function func_pointer()
{
    fp1 = &f1;
    [[ fp1 ]]();
    fp2 = &test_print;
    f2( fp2 );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x8e4
// Size: 0x9
function far()
{
    scripts\unittest\patch_far::patch_far();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 2
// Checksum 0x0, Offset: 0x8f5
// Size: 0x3c
function e5( t, n )
{
    test_print( "e5 start: " + t );
    f = 6;
    test_print( "e5 end: " + t );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 2
// Checksum 0x0, Offset: 0x939
// Size: 0x45
function e4( t, n )
{
    test_print( "e4 start: " + t );
    e = 5;
    e5( t, n );
    test_print( "e4 end: " + t );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 2
// Checksum 0x0, Offset: 0x986
// Size: 0x45
function e3( t, n )
{
    test_print( "e3 start: " + t );
    d = 4;
    e4( t, n );
    test_print( "e3 end: " + t );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 2
// Checksum 0x0, Offset: 0x9d3
// Size: 0x45
function e2( t, n )
{
    test_print( "e2 start: " + t );
    c = 3;
    e3( t, n );
    test_print( "e2 end: " + t );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 2
// Checksum 0x0, Offset: 0xa20
// Size: 0x45
function e1( t, n )
{
    test_print( "e1 start: " + t );
    b = 2;
    e2( t, n );
    test_print( "e1 end: " + t );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 2
// Checksum 0x0, Offset: 0xa6d
// Size: 0x51
function endontest_endon( t, n )
{
    test = "endontest_" + t;
    test_print( test + "_start: " + n );
    level endon( test );
    e1( t, n );
    test_print( test + "_end: " + n );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xac6
// Size: 0x2
function endontest()
{
    
}

#using_animtree( "multiplayer" );

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xad0
// Size: 0x2a
function anim_test()
{
    foo = %mp_stand_reload;
    bar = %mp_crouch_reload;
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xb02
// Size: 0xe
function stack_patch_waittill_leaf()
{
    test_print( "stack_patch_waittill_leaf" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xb18
// Size: 0x15
function stack_patch_waittill_node()
{
    test_print( "stack_patch_waittill_node" );
    stack_patch_waittill_leaf();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xb35
// Size: 0x15
function stack_patch_waittill_stack()
{
    test_print( "stack_patch_waittill_stack" );
    stack_patch_waittill_leaf();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xb52
// Size: 0x1c
function stack_patch_waittill_root()
{
    test_print( "stack_patch_waittill_root" );
    stack_patch_waittill_node();
    stack_patch_waittill_stack();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xb76
// Size: 0x1a
function stack_patch_waittill_context_patch()
{
    test_print( "stack_patch_waittill_context_patch" );
    test_print( "stack_patch_waittill_context_patch: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0xb98
// Size: 0x4f
function stack_patch_waittill_context( s )
{
    test_print( "stack_patch_waittill_context: start: " + s.value );
    s.value++;
    stack_patch_waittill_context_patch();
    waittillframeend();
    test_print( "stack_patch_waitill_context: end: " + s.value );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xbef
// Size: 0x1a
function stack_patch_waittill_context_far_patch()
{
    test_print( "stack_patch_waittill_context_far_patch" );
    test_print( "stack_patch_waittill_context_far_patch: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0xc11
// Size: 0x4f
function stack_patch_waittill_context_far( s )
{
    test_print( "stack_patch_waittill_context_far: start: " + s.value );
    s.value++;
    stack_patch_waittill_context_far_patch();
    waittillframeend();
    test_print( "stack_patch_waitill_context_far: end: " + s.value );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xc68
// Size: 0x22
function stack_patch_thread()
{
    test_print( "stack_patch_thread" );
    level waittill( "stack_patch" );
    test_print( "stack_patch_thread: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xc92
// Size: 0x21
function stack_patch_thread_leaf()
{
    test_print( "stack_patch_thread_leaf" );
    stack_patch_thread();
    test_print( "stack_patch_thread_leaf: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xcbb
// Size: 0x1a
function stack_patch_thread_node()
{
    test_print( "stack_patch_thread_node" );
    test_print( "stack_patch_thread_node: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xcdd
// Size: 0x21
function stack_patch_thread_root()
{
    test_print( "stack_patch_thread_root" );
    stack_patch_thread_node();
    test_print( "stack_patch_thread_root: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xd06
// Size: 0x61
function stack_patch()
{
    test_print( "stack_patch" );
    thread stack_patch_waittill_root();
    s = spawnstruct();
    s.value = 0;
    thread stack_patch_waittill_context( s );
    thread stack_patch_waittill_context_far( s );
    stack_patch_thread_root();
    test_print( "stack_patch: notify" );
    level notify( "stack_patch" );
    waittillframeend();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xd6f
// Size: 0x2b
function builtin_patch()
{
    x = getdvarint( @"builtin_patch", 1 );
    test_print( "builtin_patch: " + x );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xda2
// Size: 0x2
function sre()
{
    
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xdac
// Size: 0x95
function main()
{
    test_begin( "Patch" );
    s = spawnstruct();
    func();
    s meth();
    add();
    vars();
    thread func_thread();
    thread_wait();
    patch_wait();
    define();
    func_pointer();
    far();
    endontest();
    anim_test();
    stack_patch();
    builtin_patch();
    sre();
    test_end( "Patch" );
}

