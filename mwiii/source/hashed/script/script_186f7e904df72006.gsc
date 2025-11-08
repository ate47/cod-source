#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_37a51e846783d065;

// Namespace namespace_37a51e846783d065 / namespace_6c6c72360f77be5c
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xca
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8fb59c54d63f6b9", #"lightning_chain", &pre_main, undefined );
}

// Namespace namespace_37a51e846783d065 / namespace_6c6c72360f77be5c
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xf3
// Size: 0x18
function private pre_main()
{
    utility::registersharedfunc( "lightning_chain", "init", &init );
}

// Namespace namespace_37a51e846783d065 / namespace_6c6c72360f77be5c
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x113
// Size: 0x2
function private init()
{
    
}

