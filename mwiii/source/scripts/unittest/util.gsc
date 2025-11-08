#namespace util;

// Namespace util / scripts\unittest\util
// Params 1
// Checksum 0x0, Offset: 0xa7
// Size: 0x1b
function test_print( msg )
{
    msg = "SCR_TEST: " + msg;
    sysprint( msg );
}

// Namespace util / scripts\unittest\util
// Params 1
// Checksum 0x0, Offset: 0xca
// Size: 0x19
function test_begin( tag )
{
    test_print( tag + "_begin" );
}

// Namespace util / scripts\unittest\util
// Params 1
// Checksum 0x0, Offset: 0xeb
// Size: 0x19
function test_end( tag )
{
    test_print( tag + "_end" );
}

