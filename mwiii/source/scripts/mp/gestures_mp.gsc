#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\lui_game_event_aggregator;

#namespace gestures_mp;

// Namespace gestures_mp / scripts\mp\gestures_mp
// Params 0
// Checksum 0x0, Offset: 0xb8
// Size: 0x15
function init_mp()
{
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &watchradialgestureactivation );
    scripts\common\notetrack::function_11f8c6d6f5ba948();
}

