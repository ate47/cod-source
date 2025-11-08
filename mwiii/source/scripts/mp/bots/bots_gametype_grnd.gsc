#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;

#namespace bots_gametype_grnd;

// Namespace bots_gametype_grnd / scripts\mp\bots\bots_gametype_grnd
// Params 0
// Checksum 0x0, Offset: 0x122
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_grnd();
}

/#

    // Namespace bots_gametype_grnd / scripts\mp\bots\bots_gametype_grnd
    // Params 0
    // Checksum 0x0, Offset: 0x13a
    // Size: 0x5, Type: dev
    function function_e45e46b7c35deadb()
    {
        
    }

#/

// Namespace bots_gametype_grnd / scripts\mp\bots\bots_gametype_grnd
// Params 0
// Checksum 0x0, Offset: 0x147
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_grnd_think;
}

// Namespace bots_gametype_grnd / scripts\mp\bots\bots_gametype_grnd
// Params 0
// Checksum 0x0, Offset: 0x166
// Size: 0x21
function setup_bot_grnd()
{
    bot_waittill_bots_enabled( 1 );
    level.protect_radius = 128;
    level.bot_gametype_precaching_done = 1;
}

// Namespace bots_gametype_grnd / scripts\mp\bots\bots_gametype_grnd
// Params 0
// Checksum 0x0, Offset: 0x18f
// Size: 0xde
function bot_grnd_think()
{
    self notify( "bot_grnd_think" );
    self endon( "bot_grnd_think" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self botclearscriptgoal();
    
    while ( !isdefined( level.bot_gametype_precaching_done ) )
    {
        wait 0.05;
    }
    
    self botsetflag( "separation", 0 );
    thread clear_defend();
    
    while ( true )
    {
        wait 0.05;
        
        if ( bot_has_tactical_goal() )
        {
            continue;
        }
        
        if ( !self bothasscriptgoal() )
        {
            position = getnodeinzone();
            
            if ( isdefined( position ) )
            {
                self botsetscriptgoal( position.origin, 0, "objective" );
            }
            
            continue;
        }
        
        if ( !bot_is_defending() )
        {
            self botclearscriptgoal();
            position = getnodeinzone();
            
            if ( isdefined( position ) )
            {
                bot_protect_point( position.origin, level.protect_radius );
            }
        }
    }
}

// Namespace bots_gametype_grnd / scripts\mp\bots\bots_gametype_grnd
// Params 0
// Checksum 0x0, Offset: 0x275
// Size: 0x22
function clear_defend()
{
    while ( true )
    {
        level waittill( "zone_reset" );
        
        if ( bot_is_defending() )
        {
            bot_defend_stop();
        }
    }
}

// Namespace bots_gametype_grnd / scripts\mp\bots\bots_gametype_grnd
// Params 0
// Checksum 0x0, Offset: 0x29f
// Size: 0x55
function getnodeinzone()
{
    nodes = getnodesintrigger( level.zone.trigger );
    
    if ( nodes.size == 0 || !isdefined( nodes ) )
    {
        return undefined;
    }
    
    nodesnum = randomintrange( 0, nodes.size );
    position = nodes[ nodesnum ];
    return position;
}

// Namespace bots_gametype_grnd / scripts\mp\bots\bots_gametype_grnd
// Params 0
// Checksum 0x0, Offset: 0x2fd
// Size: 0x2
function temp()
{
    
}

