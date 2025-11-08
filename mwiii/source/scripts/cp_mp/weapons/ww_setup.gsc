#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\engine\utility;

#namespace ww_setup;

// Namespace ww_setup / scripts\cp_mp\weapons\ww_setup
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xb4
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ww_setup", undefined, undefined, &post_main );
}

// Namespace ww_setup / scripts\cp_mp\weapons\ww_setup
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xd5
// Size: 0x13
function private post_main()
{
    utility::callsharedfunc( "ww_setup", "init" );
}

