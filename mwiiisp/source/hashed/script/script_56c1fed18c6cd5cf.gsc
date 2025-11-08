#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_c05035b64370f782;

// Namespace namespace_c05035b64370f782 / namespace_1f1391e200f6153
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0xab
// Size: 0x18
function autoexec main()
{
    scripts\engine\utility::registersharedfunc( "switchblade_drone", "init", &init );
}

// Namespace namespace_c05035b64370f782 / namespace_1f1391e200f6153
// Params 0
// Checksum 0x0, Offset: 0xcb
// Size: 0x18
function init()
{
    scripts\engine\utility::registersharedfunc( "switchblade_drone", "munitionUsed", &function_63ef15a26ef7e9f1 );
}

// Namespace namespace_c05035b64370f782 / namespace_1f1391e200f6153
// Params 0
// Checksum 0x0, Offset: 0xeb
// Size: 0xf
function function_63ef15a26ef7e9f1()
{
    self notify( "munitions_used", "switchblade_drone" );
}

