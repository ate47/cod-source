#using scripts\cp\utility;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp_mp\stealth\stealth_music;
#using scripts\engine\utility;

#namespace namespace_17e488825cae945a;

// Namespace namespace_17e488825cae945a / namespace_7421af812c81d88b
// Params 0
// Checksum 0x0, Offset: 0x88
// Size: 0xe
function init()
{
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &scripts\cp_mp\stealth\stealth_music::function_9ff225017ef5ce19 );
}

