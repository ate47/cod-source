#using scripts\common\system;
#using scripts\engine\utility;

#namespace ww_raygun;

// Namespace ww_raygun / scripts\cp_mp\weapons\ww_raygun
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0xad
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ww_raygun", undefined, undefined, &post_main );
}

// Namespace ww_raygun / scripts\cp_mp\weapons\ww_raygun
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xce
// Size: 0x13
function private post_main()
{
    utility::callsharedfunc( "ww_raygun", "init" );
}

