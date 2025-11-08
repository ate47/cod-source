#using scripts\common\utility;
#using scripts\cp_mp\execution;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player_frame_update_aggregator;

#namespace execution_mp;

// Namespace execution_mp / scripts\mp\execution_mp
// Params 0
// Checksum 0x0, Offset: 0xb0
// Size: 0x17
function execution_mp_init()
{
    if ( !scripts\mp\utility\game::runleanthreadmode() )
    {
        scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback( &execution_blockladders );
    }
}

