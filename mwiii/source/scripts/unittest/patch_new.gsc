#using scripts\unittest\util;

#namespace patch_new;

// Namespace patch_new / scripts\unittest\patch_new
// Params 0
// Checksum 0x0, Offset: 0xc6
// Size: 0xe
function patch_new()
{
    test_print( "patch_new" );
}

// Namespace patch_new / scripts\unittest\patch_new
// Params 0
// Checksum 0x0, Offset: 0xdc
// Size: 0x15
function patch_new2()
{
    test_print( "patch_new2" );
    patch_new3();
}

// Namespace patch_new / scripts\unittest\patch_new
// Params 0
// Checksum 0x0, Offset: 0xf9
// Size: 0xe
function patch_new3()
{
    test_print( "patch_new3" );
}

// Namespace patch_new / scripts\unittest\patch_new
// Params 0
// Checksum 0x0, Offset: 0x10f
// Size: 0xe
function patch_new4()
{
    test_print( "patch_new4" );
}

