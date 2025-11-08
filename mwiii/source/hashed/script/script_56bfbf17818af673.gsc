#using script_16ea1b94f0f381b3;
#using script_30997c5077be5db6;
#using scripts\common\system;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapons\ww_setup;
#using scripts\engine\utility;

#namespace namespace_9791aee7cc89723a;

// Namespace namespace_9791aee7cc89723a / namespace_61bb123eebb31bd9
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xcc
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_eb288affe3ef61e", #"ww_setup", &pre_main, undefined );
}

// Namespace namespace_9791aee7cc89723a / namespace_61bb123eebb31bd9
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xf5
// Size: 0x18
function private pre_main()
{
    utility::registersharedfunc( "ww_setup", "init", &init );
}

// Namespace namespace_9791aee7cc89723a / namespace_61bb123eebb31bd9
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x115
// Size: 0x2
function private init()
{
    
}

