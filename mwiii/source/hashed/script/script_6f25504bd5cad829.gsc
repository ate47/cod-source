#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_c8486b8d494f563e;

// Namespace namespace_c8486b8d494f563e / namespace_af665e46b53ce249
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0xb2
// Size: 0x14
function autoexec init()
{
    level callback::add( "ob_season_main", &main );
}

// Namespace namespace_c8486b8d494f563e / namespace_af665e46b53ce249
// Params 1
// Checksum 0x0, Offset: 0xce
// Size: 0x1d
function main( params )
{
    level callback::remove( "ob_season_main", &main );
}

