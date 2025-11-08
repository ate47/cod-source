#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;

#namespace namespace_1c60d8e0447f29d1;

// Namespace namespace_1c60d8e0447f29d1 / namespace_61324f9e6ae38479
// Params 0
// Checksum 0x0, Offset: 0xe8
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_war();
}

/#

    // Namespace namespace_1c60d8e0447f29d1 / namespace_61324f9e6ae38479
    // Params 0
    // Checksum 0x0, Offset: 0x100
    // Size: 0x5, Type: dev
    function function_e45e46b7c35deadb()
    {
        
    }

#/

// Namespace namespace_1c60d8e0447f29d1 / namespace_61324f9e6ae38479
// Params 0
// Checksum 0x0, Offset: 0x10d
// Size: 0x17
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_war_think;
}

// Namespace namespace_1c60d8e0447f29d1 / namespace_61324f9e6ae38479
// Params 0
// Checksum 0x0, Offset: 0x12c
// Size: 0x2
function setup_bot_war()
{
    
}

// Namespace namespace_1c60d8e0447f29d1 / namespace_61324f9e6ae38479
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

