#using scripts\unittest\util;

#namespace patch_far;

// Namespace patch_far / scripts\unittest\patch_far
// Params 0
// Checksum 0x0, Offset: 0xc3
// Size: 0xe
function patch_far()
{
    test_print( "patch_far" );
}

// Namespace patch_far / scripts\unittest\patch_far
// Params 0
// Checksum 0x0, Offset: 0xd9
// Size: 0x16
function patch_far_notify()
{
    test_print( "patch_far_notify" );
    level notify( "patch_far_notify" );
}

// Namespace patch_far / scripts\unittest\patch_far
// Params 0
// Checksum 0x0, Offset: 0xf7
// Size: 0xe
function patch_far_wait()
{
    test_print( "patch_far_wait" );
}

