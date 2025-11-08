#using script_422801cfe4074e05;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_5b79e0098b7edf4d;

// Namespace namespace_5b79e0098b7edf4d / namespace_fffc43c197b763f7
// Params 0
// Checksum 0x0, Offset: 0xbe
// Size: 0x2a
function init()
{
    assert( flag( "<dev string:x1c>" ) );
    callback::add( "player_spawned", &on_player_spawn );
}

// Namespace namespace_5b79e0098b7edf4d / namespace_fffc43c197b763f7
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xf0
// Size: 0x37
function private on_player_spawn( params )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    analytics::addevent( "player_spawned", player getorigin(), 0, "", player );
}

