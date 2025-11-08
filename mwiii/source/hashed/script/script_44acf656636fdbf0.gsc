#using script_44acf656636fdbf0;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_gametype_resurgence;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\utility\connect_event_aggregator;

#namespace br_gametype_resurgence_poi;

// Namespace br_gametype_resurgence_poi / namespace_bd2df931a45390c
// Params 0
// Checksum 0x0, Offset: 0x164
// Size: 0x23
function main()
{
    level.var_cdc15ee14362fbf = &namespace_bd2df931a45390c::init;
    scripts\mp\utility\connect_event_aggregator::registeronconnectcallback( &onplayerconnect );
    scripts\mp\gametypes\br::main();
}

// Namespace br_gametype_resurgence_poi / namespace_bd2df931a45390c
// Params 0
// Checksum 0x0, Offset: 0x18f
// Size: 0x4c
function init()
{
    scripts\mp\gametypes\br_gametype_resurgence::init();
    scripts\mp\gametypes\br_gametypes::function_ec416fa15d5fa6af( "getPlacementXPShareValues" );
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc( "getPlacementXPShareValues", &function_b0bb8889afbb0c83 );
    scripts\mp\gametypes\br_gametypes::function_ec416fa15d5fa6af( "getBRBonusXPperMillisecond" );
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc( "getBRBonusXPperMillisecond", &function_843d05502816cbce );
    level thread function_616dc995608c8f34();
}

// Namespace br_gametype_resurgence_poi / namespace_bd2df931a45390c
// Params 0
// Checksum 0x0, Offset: 0x1e3
// Size: 0x9
function onplayerconnect()
{
    function_d00f5e738d7fb50d();
}

// Namespace br_gametype_resurgence_poi / namespace_bd2df931a45390c
// Params 0
// Checksum 0x0, Offset: 0x1f4
// Size: 0x76
function function_616dc995608c8f34()
{
    level endon( "game_ended" );
    scripts\mp\flags::function_1240434f4201ac9d( "prematch_done" );
    scripts\mp\flags::function_1240434f4201ac9d( "prematch_fade_done" );
    
    foreach ( player in level.players )
    {
        player thread function_9c0a51de4eba66f3();
    }
}

// Namespace br_gametype_resurgence_poi / namespace_bd2df931a45390c
// Params 0
// Checksum 0x0, Offset: 0x272
// Size: 0x51
function function_9c0a51de4eba66f3()
{
    level endon( "game_ended" );
    self endon( "disonnect" );
    
    if ( isbot( self ) )
    {
        return;
    }
    
    br::function_258c4f40dee8189a( -1, -1, -1 );
    
    if ( !self istacmapactive() )
    {
        self notifyonplayercommand( "tac_map_toggle", "togglemap" );
        self waittill( "tac_map_toggle" );
    }
    
    waitframe();
    function_d00f5e738d7fb50d();
}

// Namespace br_gametype_resurgence_poi / namespace_bd2df931a45390c
// Params 0
// Checksum 0x0, Offset: 0x2cb
// Size: 0x3c
function function_d00f5e738d7fb50d()
{
    endpos = getdvarvector( @"hash_d125978f792e63d0", ( 0, 0, 0 ) );
    br::function_258c4f40dee8189a( endpos[ 0 ], endpos[ 1 ], 0.5 );
}

// Namespace br_gametype_resurgence_poi / namespace_bd2df931a45390c
// Params 0
// Checksum 0x0, Offset: 0x30f
// Size: 0x39
function function_b0bb8889afbb0c83()
{
    var_e0f4d3685ff5c5bc = 50000;
    var_2121aa51c2c8132e = 80;
    var_409d356961c27474 = 15;
    return [ var_e0f4d3685ff5c5bc, var_2121aa51c2c8132e, var_409d356961c27474 ];
}

// Namespace br_gametype_resurgence_poi / namespace_bd2df931a45390c
// Params 0
// Checksum 0x0, Offset: 0x351
// Size: 0x7
function function_843d05502816cbce()
{
    return 0.001;
}

