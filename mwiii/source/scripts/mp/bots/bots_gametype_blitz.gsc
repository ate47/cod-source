#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;

#namespace bots_gametype_blitz;

// Namespace bots_gametype_blitz / scripts\mp\bots\bots_gametype_blitz
// Params 0
// Checksum 0x0, Offset: 0xea
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_blitz();
}

/#

    // Namespace bots_gametype_blitz / scripts\mp\bots\bots_gametype_blitz
    // Params 0
    // Checksum 0x0, Offset: 0x102
    // Size: 0x5, Type: dev
    function function_e45e46b7c35deadb()
    {
        
    }

#/

// Namespace bots_gametype_blitz / scripts\mp\bots\bots_gametype_blitz
// Params 0
// Checksum 0x0, Offset: 0x10f
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_blitz_think;
}

// Namespace bots_gametype_blitz / scripts\mp\bots\bots_gametype_blitz
// Params 0
// Checksum 0x0, Offset: 0x12e
// Size: 0x2
function setup_bot_blitz()
{
    
}

// Namespace bots_gametype_blitz / scripts\mp\bots\bots_gametype_blitz
// Params 0
// Checksum 0x0, Offset: 0x138
// Size: 0x57
function bot_blitz_think()
{
    self notify( "bot_blitz_think" );
    self endon( "bot_blitz_think" );
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

