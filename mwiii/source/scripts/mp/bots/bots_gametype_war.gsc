#using script_3d2770dc09c1243;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\autopilot;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\mgl_mp;

#namespace bots_gametype_war;

// Namespace bots_gametype_war / scripts\mp\bots\bots_gametype_war
// Params 0
// Checksum 0x0, Offset: 0x120
// Size: 0x5b
function main()
{
    if ( scripts\cp_mp\utility\game_utility::IsMagellanMode() || scripts\cp_mp\utility\game_utility::function_6493ec89ae923684() )
    {
        scripts\mp\gametypes\mgl_mp::function_53ae52a625b5c703();
        return;
    }
    else if ( namespace_ef54497d29a56093::function_5a60778277d6ae4b() )
    {
        namespace_ef54497d29a56093::initialize();
        return;
    }
    
    setup_callbacks();
    setup_bot_war();
    scripts\mp\autopilot::initialize( undefined, undefined, [ "bot_war_think", "clear_script_goal_on" ] );
}

/#

    // Namespace bots_gametype_war / scripts\mp\bots\bots_gametype_war
    // Params 0
    // Checksum 0x0, Offset: 0x183
    // Size: 0x5, Type: dev
    function function_e45e46b7c35deadb()
    {
        
    }

#/

// Namespace bots_gametype_war / scripts\mp\bots\bots_gametype_war
// Params 0
// Checksum 0x0, Offset: 0x190
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_war_think;
}

// Namespace bots_gametype_war / scripts\mp\bots\bots_gametype_war
// Params 0
// Checksum 0x0, Offset: 0x1af
// Size: 0x2
function setup_bot_war()
{
    
}

// Namespace bots_gametype_war / scripts\mp\bots\bots_gametype_war
// Params 0
// Checksum 0x0, Offset: 0x1b9
// Size: 0x57
function bot_war_think()
{
    self notify( "bot_war_think" );
    self endon( "bot_war_think" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_c2de8ca6dc8512c1" ) )
            {
                wait 0.05;
                continue;
            }
        #/
        
        self [[ self.personality_update_function ]]();
        wait 0.05;
    }
}

