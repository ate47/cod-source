#using script_7e018ed120c71de8;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_ab78858d3444062c;

// Namespace namespace_ab78858d3444062c / namespace_92961846a030bf17
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0xba
// Size: 0x14
function autoexec init()
{
    level callback::add( "ob_season_main", &main );
}

// Namespace namespace_ab78858d3444062c / namespace_92961846a030bf17
// Params 1
// Checksum 0x0, Offset: 0xd6
// Size: 0x36
function main( params )
{
    if ( getdvarint( @"hash_b338e81ddf2be38a", 0 ) )
    {
        namespace_a304e973fe7f3f00::init();
    }
    
    level callback::remove( "ob_season_main", &main );
}

