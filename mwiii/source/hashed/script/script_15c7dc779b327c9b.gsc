#using scripts\cp_mp\stealth\stealth_music;
#using scripts\engine\utility;
#using scripts\mp\utility\spawn_event_aggregator;

#namespace namespace_17ca84825c926284;

// Namespace namespace_17ca84825c926284 / namespace_fc31f517a806b2d3
// Params 0
// Checksum 0x0, Offset: 0xa0
// Size: 0xe
function init()
{
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &scripts\cp_mp\stealth\stealth_music::function_9ff225017ef5ce19 );
}

