#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;

#namespace bots_gametype_warrior;

// Namespace bots_gametype_warrior / scripts\mp\bots\bots_gametype_warrior
// Params 0
// Checksum 0x0, Offset: 0xe8
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_war();
}

/#

    // Namespace bots_gametype_warrior / scripts\mp\bots\bots_gametype_warrior
    // Params 0
    // Checksum 0x0, Offset: 0x100
    // Size: 0x5, Type: dev
    function function_e45e46b7c35deadb()
    {
        
    }

#/

// Namespace bots_gametype_warrior / scripts\mp\bots\bots_gametype_warrior
// Params 0
// Checksum 0x0, Offset: 0x10d
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_war_think;
}

// Namespace bots_gametype_warrior / scripts\mp\bots\bots_gametype_warrior
// Params 0
// Checksum 0x0, Offset: 0x12c
// Size: 0x2
function setup_bot_war()
{
    
}

// Namespace bots_gametype_warrior / scripts\mp\bots\bots_gametype_warrior
// Params 0
// Checksum 0x0, Offset: 0x136
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

