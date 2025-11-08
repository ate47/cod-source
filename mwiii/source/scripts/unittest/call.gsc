#using scripts\unittest\util;

#namespace unittest_call;

// Namespace unittest_call / scripts\unittest\call
// Params 0
// Checksum 0x0, Offset: 0x25e
// Size: 0xe
function noargs()
{
    test_print( "noargs" );
}

// Namespace unittest_call / scripts\unittest\call
// Params 1
// Checksum 0x0, Offset: 0x274
// Size: 0x25
function onearg( a )
{
    if ( !isdefined( a ) )
    {
        a = "<undefined>";
    }
    
    test_print( "onearg: " + a );
}

// Namespace unittest_call / scripts\unittest\call
// Params 3
// Checksum 0x0, Offset: 0x2a1
// Size: 0x39
function multiarg( a, b, c )
{
    test_print( "multiarg: " + a + " " + b + " " + c );
}

// Namespace unittest_call / scripts\unittest\call
// Params 1
// Checksum 0x0, Offset: 0x2e2
// Size: 0x2f
function recurse_internal( n )
{
    if ( n > 0 )
    {
        test_print( "recurse_internal: " + n );
        return recurse_internal( n - 1 );
    }
    
    return n;
}

// Namespace unittest_call / scripts\unittest\call
// Params 1
// Checksum 0x0, Offset: 0x319
// Size: 0x1f
function recurse( n )
{
    test_print( "recurse: " + recurse_internal( n ) );
}

// Namespace unittest_call / scripts\unittest\call
// Params 1
// Checksum 0x0, Offset: 0x340
// Size: 0x4f
function function_3ee3cd6fe2c81bd1( count )
{
    level endon( "vm_execute_context" );
    new_count = count - 1;
    test_print( "vm_execute_context: " + count );
    
    if ( count <= 0 )
    {
        test_print( "vm_execute_context: done" );
        return;
    }
    
    functionvmexec( &vm_execute_context, new_count );
}

// Namespace unittest_call / scripts\unittest\call
// Params 1
// Checksum 0x0, Offset: 0x397
// Size: 0x13
function function_3ee3ca6fe2c81538( count )
{
    function_3ee3cd6fe2c81bd1( count );
}

// Namespace unittest_call / scripts\unittest\call
// Params 1
// Checksum 0x0, Offset: 0x3b2
// Size: 0x13
function vm_execute_context( count )
{
    function_3ee3ca6fe2c81538( count );
}

// Namespace unittest_call / scripts\unittest\call
// Params 1
// Checksum 0x0, Offset: 0x3cd
// Size: 0x48
function function_d71cba50ce323656( count )
{
    new_count = count - 1;
    test_print( "vm_execute_stack: " + count );
    
    if ( count <= 0 )
    {
        test_print( "vm_execute_stack: done" );
        return;
    }
    
    functionvmexec( &vm_execute_stack, new_count );
}

// Namespace unittest_call / scripts\unittest\call
// Params 1
// Checksum 0x0, Offset: 0x41d
// Size: 0x13
function function_d71cb950ce323423( count )
{
    function_d71cba50ce323656( count );
}

// Namespace unittest_call / scripts\unittest\call
// Params 1
// Checksum 0x0, Offset: 0x438
// Size: 0x13
function vm_execute_stack( count )
{
    function_d71cb950ce323423( count );
}

// Namespace unittest_call / scripts\unittest\call
// Params 0
// Checksum 0x0, Offset: 0x453
// Size: 0x14
function function_234f3c181e22628e()
{
    vm_execute_context( 3 );
    vm_execute_stack( 3 );
}

// Namespace unittest_call / scripts\unittest\call
// Params 0
// Checksum 0x0, Offset: 0x46f
// Size: 0x404
function main()
{
    test_begin( "Call" );
    noargs();
    onearg( 1 );
    onearg( "hi" );
    onearg();
    multiarg( 1, 2, 3 );
    multiarg( 1, "hi", 2 );
    test_print( "Method" );
    s = spawnstruct();
    s noargs();
    s onearg( 1 );
    s onearg( "hi" );
    s onearg();
    s multiarg( 1, 2, 3 );
    s multiarg( 1, "hi", 2 );
    test_print( "Thread" );
    thread noargs();
    thread onearg( 1 );
    thread onearg( "hi" );
    thread onearg();
    thread multiarg( 1, 2, 3 );
    thread multiarg( 1, "hi", 2 );
    test_print( "Method Thread" );
    s thread noargs();
    s thread onearg( 1 );
    s thread onearg( "hi" );
    s thread onearg();
    s thread multiarg( 1, 2, 3 );
    s thread multiarg( 1, "hi", 2 );
    test_print( "Child Thread" );
    childthread noargs();
    childthread onearg( 1 );
    childthread onearg( "hi" );
    childthread onearg();
    childthread multiarg( 1, 2, 3 );
    childthread multiarg( 1, "hi", 2 );
    test_print( "Method Child Thread" );
    s childthread noargs();
    s childthread onearg( 1 );
    s childthread onearg( "hi" );
    s childthread onearg();
    s childthread multiarg( 1, 2, 3 );
    s childthread multiarg( 1, "hi", 2 );
    test_print( "Function Pointer" );
    var_bc867423ff8eb756 = &noargs;
    var_8b5a8f4beb53dfa4 = &onearg;
    var_8564d715b7cd5cd3 = &multiarg;
    [[ var_bc867423ff8eb756 ]]();
    [[ var_8b5a8f4beb53dfa4 ]]( 1 );
    [[ var_8b5a8f4beb53dfa4 ]]( "hi" );
    [[ var_8b5a8f4beb53dfa4 ]]();
    [[ var_8564d715b7cd5cd3 ]]( 1, 2, 3 );
    [[ var_8564d715b7cd5cd3 ]]( 1, "hi", 2 );
    test_print( "Method Pointer" );
    s [[ var_bc867423ff8eb756 ]]();
    s [[ var_8b5a8f4beb53dfa4 ]]( 1 );
    s [[ var_8b5a8f4beb53dfa4 ]]( "hi" );
    s [[ var_8b5a8f4beb53dfa4 ]]();
    s [[ var_8564d715b7cd5cd3 ]]( 1, 2, 3 );
    s [[ var_8564d715b7cd5cd3 ]]( 1, "hi", 2 );
    test_print( "Thread Pointer" );
    thread [[ var_bc867423ff8eb756 ]]();
    thread [[ var_8b5a8f4beb53dfa4 ]]( 1 );
    thread [[ var_8b5a8f4beb53dfa4 ]]( "hi" );
    thread [[ var_8b5a8f4beb53dfa4 ]]();
    thread [[ var_8564d715b7cd5cd3 ]]( 1, 2, 3 );
    thread [[ var_8564d715b7cd5cd3 ]]( 1, "hi", 2 );
    test_print( "Method Thread Pointer" );
    s thread [[ var_bc867423ff8eb756 ]]();
    s thread [[ var_8b5a8f4beb53dfa4 ]]( 1 );
    s thread [[ var_8b5a8f4beb53dfa4 ]]( "hi" );
    s thread [[ var_8b5a8f4beb53dfa4 ]]();
    s thread [[ var_8564d715b7cd5cd3 ]]( 1, 2, 3 );
    s thread [[ var_8564d715b7cd5cd3 ]]( 1, "hi", 2 );
    test_print( "Child Thread Pointer" );
    childthread [[ var_bc867423ff8eb756 ]]();
    childthread [[ var_8b5a8f4beb53dfa4 ]]( 1 );
    childthread [[ var_8b5a8f4beb53dfa4 ]]( "hi" );
    childthread [[ var_8b5a8f4beb53dfa4 ]]();
    childthread [[ var_8564d715b7cd5cd3 ]]( 1, 2, 3 );
    childthread [[ var_8564d715b7cd5cd3 ]]( 1, "hi", 2 );
    test_print( "Method Child Thread Pointer" );
    s childthread [[ var_bc867423ff8eb756 ]]();
    s childthread [[ var_8b5a8f4beb53dfa4 ]]( 1 );
    s childthread [[ var_8b5a8f4beb53dfa4 ]]( "hi" );
    s childthread [[ var_8b5a8f4beb53dfa4 ]]();
    s childthread [[ var_8564d715b7cd5cd3 ]]( 1, 2, 3 );
    s childthread [[ var_8564d715b7cd5cd3 ]]( 1, "hi", 2 );
    test_print( "Misc Function Logic" );
    recurse( 10 );
    function_234f3c181e22628e();
    test_end( "Call" );
}

