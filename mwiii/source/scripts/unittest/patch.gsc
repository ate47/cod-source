#using scripts\unittest\patch_far;
#using scripts\unittest\util;

#namespace unittest_patch;

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x602
// Size: 0xe
function add()
{
    test_print( "add" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x618
// Size: 0x2
function patch_self_check()
{
    
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x622
// Size: 0xd
function meth_patch()
{
    self.value = 1;
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x637
// Size: 0x3a
function meth()
{
    s = spawnstruct();
    s meth_patch();
    test_print( "meth: " + s.value );
    patch_self_check();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x679
// Size: 0x3, Type: bool
function func_patch()
{
    return false;
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x685
// Size: 0x22
function func()
{
    x = func_patch();
    test_print( "func: " + x );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0x6af
// Size: 0x3b
function vars_print( s )
{
    test_print( "s.active: " + s.active );
    test_print( "s.notcanon: " + s.notcanon );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0x6f2
// Size: 0x2b
function vars_update( s )
{
    test_print( "vars_update" );
    vars_print( s );
    test_print( "vars_update: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x725
// Size: 0x62
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
// Checksum 0x0, Offset: 0x78f
// Size: 0xe
function func_thread()
{
    test_print( "func_thread" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0x7a5
// Size: 0x6d
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
// Checksum 0x0, Offset: 0x81a
// Size: 0x2f
function thread_wait_native( deep )
{
    test_print( "thread_wait_native: " + deep );
    thread_wait_patch( deep );
    test_print( "thread_wait_native end: " + deep );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x851
// Size: 0x30
function thread_wait_local()
{
    x = 0;
    test_print( "thread_wait_local" );
    thread_wait( 1 );
    test_print( "thread_wait_local end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0x889
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
// Checksum 0x0, Offset: 0x8f9
// Size: 0xf
function native_wait()
{
    test_print( "native_wait" );
    waittillframeend();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x910
// Size: 0x3
function patch_wait_frameend()
{
    waittillframeend();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x91b
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
// Checksum 0x0, Offset: 0x945
// Size: 0x1d
function define()
{
    test_print( "define: int: " + 1 + " float: " + 2.2 );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x96a
// Size: 0xe
function f1()
{
    test_print( "fp1" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0x980
// Size: 0x14
function f2( tp )
{
    [[ tp ]]( "fp2" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0x99c
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
// Checksum 0x0, Offset: 0x9d2
// Size: 0x9
function far()
{
    scripts\unittest\patch_far::patch_far();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 2
// Checksum 0x0, Offset: 0x9e3
// Size: 0x3d
function e5( t, n )
{
    test_print( "e5 start: " + t );
    f = 6;
    test_print( "e5 end: " + t );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 2
// Checksum 0x0, Offset: 0xa28
// Size: 0x46
function e4( t, n )
{
    test_print( "e4 start: " + t );
    e = 5;
    e5( t, n );
    test_print( "e4 end: " + t );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 2
// Checksum 0x0, Offset: 0xa76
// Size: 0x46
function e3( t, n )
{
    test_print( "e3 start: " + t );
    d = 4;
    e4( t, n );
    test_print( "e3 end: " + t );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 2
// Checksum 0x0, Offset: 0xac4
// Size: 0x46
function e2( t, n )
{
    test_print( "e2 start: " + t );
    c = 3;
    e3( t, n );
    test_print( "e2 end: " + t );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 2
// Checksum 0x0, Offset: 0xb12
// Size: 0x46
function e1( t, n )
{
    test_print( "e1 start: " + t );
    b = 2;
    e2( t, n );
    test_print( "e1 end: " + t );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 2
// Checksum 0x0, Offset: 0xb60
// Size: 0x52
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
// Checksum 0x0, Offset: 0xbba
// Size: 0x2
function endontest()
{
    
}

#using_animtree( "multiplayer" );

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xbc4
// Size: 0x2a
function anim_test()
{
    foo = %mp_stand_reload;
    bar = %mp_crouch_reload;
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xbf6
// Size: 0xe
function stack_patch_waittill_leaf()
{
    test_print( "stack_patch_waittill_leaf" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xc0c
// Size: 0x15
function stack_patch_waittill_node()
{
    test_print( "stack_patch_waittill_node" );
    stack_patch_waittill_leaf();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xc29
// Size: 0x15
function stack_patch_waittill_stack()
{
    test_print( "stack_patch_waittill_stack" );
    stack_patch_waittill_leaf();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xc46
// Size: 0x1c
function stack_patch_waittill_root()
{
    test_print( "stack_patch_waittill_root" );
    stack_patch_waittill_node();
    stack_patch_waittill_stack();
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xc6a
// Size: 0x1a
function stack_patch_waittill_context_patch()
{
    test_print( "stack_patch_waittill_context_patch" );
    test_print( "stack_patch_waittill_context_patch: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0xc8c
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
// Checksum 0x0, Offset: 0xce3
// Size: 0x1a
function stack_patch_waittill_context_far_patch()
{
    test_print( "stack_patch_waittill_context_far_patch" );
    test_print( "stack_patch_waittill_context_far_patch: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 1
// Checksum 0x0, Offset: 0xd05
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
// Checksum 0x0, Offset: 0xd5c
// Size: 0x22
function stack_patch_thread()
{
    test_print( "stack_patch_thread" );
    level waittill( "stack_patch" );
    test_print( "stack_patch_thread: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xd86
// Size: 0x21
function stack_patch_thread_leaf()
{
    test_print( "stack_patch_thread_leaf" );
    stack_patch_thread();
    test_print( "stack_patch_thread_leaf: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xdaf
// Size: 0x1a
function stack_patch_thread_node()
{
    test_print( "stack_patch_thread_node" );
    test_print( "stack_patch_thread_node: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xdd1
// Size: 0x21
function stack_patch_thread_root()
{
    test_print( "stack_patch_thread_root" );
    stack_patch_thread_node();
    test_print( "stack_patch_thread_root: end" );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xdfa
// Size: 0x62
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
// Checksum 0x0, Offset: 0xe64
// Size: 0x2c
function builtin_patch()
{
    x = getdvarint( @"builtin_patch", 1 );
    test_print( "builtin_patch: " + x );
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xe98
// Size: 0x2
function sre()
{
    
}

// Namespace unittest_patch / scripts\unittest\patch
// Params 0
// Checksum 0x0, Offset: 0xea2
// Size: 0x96
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

