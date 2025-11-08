#using scripts\common\system;
#using scripts\engine\utility;

#namespace namespace_4126fdfb94a2125e;

// Namespace namespace_4126fdfb94a2125e / namespace_dfb591bd8b68de85
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xad
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_ffa629c8a67e2a72", #"ww_raygun", &pre_main, undefined );
}

// Namespace namespace_4126fdfb94a2125e / namespace_dfb591bd8b68de85
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xd6
// Size: 0x18
function private pre_main()
{
    utility::registersharedfunc( "ww_raygun", "init", &init );
}

// Namespace namespace_4126fdfb94a2125e / namespace_dfb591bd8b68de85
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xf6
// Size: 0x2
function private init()
{
    
}

