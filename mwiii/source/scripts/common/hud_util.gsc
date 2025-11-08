#using scripts\anim\utility;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace hud_util;

// Namespace hud_util / scripts\common\hud_util
// Params 3
// Checksum 0x0, Offset: 0xc6
// Size: 0xd2
function create_client_overlay( shader_name, start_alpha, player )
{
    if ( isdefined( player ) )
    {
        overlay = newclienthudelem( player );
    }
    else
    {
        overlay = newhudelem();
    }
    
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader( shader_name, 640, 480 );
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.sort = 1;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = start_alpha;
    overlay.foreground = 1;
    return overlay;
}

// Namespace hud_util / scripts\common\hud_util
// Params 2
// Checksum 0x0, Offset: 0x1a1
// Size: 0x63
function fade_in( time, shader )
{
    if ( istrue( level.missionfailed ) )
    {
        return;
    }
    
    if ( !isdefined( time ) )
    {
        time = 0.3;
    }
    
    overlay = get_optional_overlay( shader );
    
    if ( time > 0 )
    {
        overlay fadeovertime( time );
    }
    
    overlay.alpha = 0;
    
    if ( time > 0 )
    {
        wait time;
    }
}

// Namespace hud_util / scripts\common\hud_util
// Params 1
// Checksum 0x0, Offset: 0x20c
// Size: 0x1e
function get_optional_overlay( shader )
{
    if ( !isdefined( shader ) )
    {
        shader = "black";
    }
    
    return get_overlay( shader );
}

// Namespace hud_util / scripts\common\hud_util
// Params 2
// Checksum 0x0, Offset: 0x233
// Size: 0x56
function fade_out( time, shader )
{
    if ( !isdefined( time ) )
    {
        time = 0.3;
    }
    
    overlay = get_optional_overlay( shader );
    
    if ( time > 0 )
    {
        overlay fadeovertime( time );
    }
    
    overlay.alpha = 1;
    
    if ( time > 0 )
    {
        wait time;
    }
}

// Namespace hud_util / scripts\common\hud_util
// Params 1
// Checksum 0x0, Offset: 0x291
// Size: 0xb3
function get_overlay( shader )
{
    if ( isplayer( self ) )
    {
        guy = self;
    }
    else
    {
        guy = level.player;
    }
    
    if ( !isdefined( guy.overlay ) )
    {
        guy.overlay = [];
    }
    
    if ( !isdefined( guy.overlay[ shader ] ) )
    {
        guy.overlay[ shader ] = create_client_overlay( shader, 0, guy );
    }
    
    guy.overlay[ shader ].sort = 0;
    guy.overlay[ shader ].foreground = 1;
    return guy.overlay[ shader ];
}

