#using script_3008e3767a2a503c;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;

#namespace ob_season6;

// Namespace ob_season6 / scripts\mp\gametypes\ob_season6
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0xe9
// Size: 0x14
function autoexec init()
{
    level callback::add( "ob_season_main", &main );
}

// Namespace ob_season6 / scripts\mp\gametypes\ob_season6
// Params 1
// Checksum 0x0, Offset: 0x105
// Size: 0x2d
function main( params )
{
    level callback::remove( "ob_season_main", &main );
    
    if ( scripts\mp\utility\game::function_966592fd716d49c7() )
    {
        function_faa8aae58d956943();
    }
}

// Namespace ob_season6 / scripts\mp\gametypes\ob_season6
// Params 0
// Checksum 0x0, Offset: 0x13a
// Size: 0x13
function function_faa8aae58d956943()
{
    callback::add( "on_ai_killed", &function_d6516a2de5c30aca );
}

// Namespace ob_season6 / scripts\mp\gametypes\ob_season6
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x155
// Size: 0x30
function private function_d6516a2de5c30aca( params )
{
    level thread namespace_bc22b8386eb4de80::function_7502f58e600e74a2( self, params.eattacker, "new_loot_item_spawned", params.smeansofdeath );
}

