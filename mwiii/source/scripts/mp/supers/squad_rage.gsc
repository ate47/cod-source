#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\equipment\battlerage;
#using scripts\mp\hud_message;
#using scripts\mp\supers;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;

#namespace squad_rage;

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x3b8
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &function_8a2c6f6a885e4f55 );
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3d8
// Size: 0x7f
function private function_8a2c6f6a885e4f55( params )
{
    if ( isdefined( params.var_47ce480103f7129f ) )
    {
        level [[ params.var_47ce480103f7129f ]]( "super_squadrage", undefined, &function_e159fabaa36f8e06, &function_247c0da754494285, &function_c25d4d8225b22919, undefined, &function_83a05073c0b69a18 );
        assertex( isdefined( level.var_b2b35840c12ce55c ), "<dev string:x1c>" );
        level.var_b2b35840c12ce55c[ "squad_rage" ] = &function_53c04fa3cdca4a85;
        initdevgui();
        initvariables();
    }
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x45f
// Size: 0x29
function private initdevgui()
{
    /#
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x54>" );
        scripts\common\devgui::add_devgui_command( "<dev string:x6f>", "<dev string:x7d>" );
        scripts\common\devgui::function_fe953f000498048f();
    #/
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x490
// Size: 0xfa
function private initvariables()
{
    level.var_699a1785b1375779 = spawnstruct();
    level.var_699a1785b1375779.radius = getdvarint( @"hash_8df48004492a7509", 300 );
    level.var_699a1785b1375779.var_dd96ee76756a81c0 = squared( level.var_699a1785b1375779.radius );
    level.var_699a1785b1375779.var_82aefcede8e367d3 = getdvarint( @"hash_eea5e2856675f9de", 1 );
    level.var_699a1785b1375779.superid = scripts\mp\supers::getsuperid( "super_squadrage" );
    level.var_699a1785b1375779.throttle = throttle_initialize( "squad_rage_throttle", 3, 0.2 );
    level.var_699a1785b1375779.var_6bca48baec64109c = getdvarint( @"hash_b4e3b6bb467a6aef", 1 );
    function_f1aed36ab4598ea( "eqp_squadrage" );
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x592
// Size: 0x1bd, Type: bool
function private function_247c0da754494285()
{
    player = self;
    player endon( "death" );
    player childthread function_7fa239779fe78754();
    msg = function_ac1863f0deb8a63e( 1.5, player, "giveAndFireOffhandReliableFailed", player, "giveAndFireOffhandReliableSucceeded" );
    
    if ( !isdefined( msg ) || msg == "giveAndFireOffhandReliableFailed" )
    {
        function_a8be3990b76f02a1();
        return false;
    }
    
    function_724f7991cf1b188f( player );
    var_44b61bed3d930343 = player function_b389246eb36d7304();
    player.var_d4afb17212d1b2cc = [];
    var_67d84be6232392d2 = player getentitynumber();
    var_f4e3f676327fb6d1 = 0;
    
    foreach ( targetplayer in var_44b61bed3d930343 )
    {
        if ( function_50755760e28c7650( targetplayer, player ) )
        {
            function_724f7991cf1b188f( targetplayer, player );
            player.var_d4afb17212d1b2cc = array_add( player.var_d4afb17212d1b2cc, targetplayer );
            
            if ( player.team == targetplayer.team )
            {
                scripts\cp_mp\challenges::function_8359cadd253f9604( player, "teammate_squad_rage", 1 );
                var_f4e3f676327fb6d1++;
            }
        }
    }
    
    squadsize = scripts\cp_mp\utility\squad_utility::getsquadsize( player );
    
    if ( squadsize > 1 && var_f4e3f676327fb6d1 == squadsize - 1 )
    {
        scripts\cp_mp\challenges::function_8359cadd253f9604( player, "full_team_squad_rage", 1 );
    }
    
    player thread function_92e76fa20cb89f9a( player.var_d4afb17212d1b2cc, var_67d84be6232392d2 );
    var_9c4c9186f375df3b = 0;
    player function_c35c3441b3cbdb88( var_9c4c9186f375df3b );
    function_6fce2e1d1f1f4e9b( player, player.var_d4afb17212d1b2cc );
    return true;
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x758
// Size: 0x21
function private function_7fa239779fe78754()
{
    waittillframeend();
    objweapon = makeweapon( "squad_rage_br" );
    scripts\cp_mp\utility\weapon_utility::giveandfireoffhandreliable( objweapon );
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x781
// Size: 0x5f, Type: bool
function private function_c25d4d8225b22919( fromdeath, attacker )
{
    player = self;
    player notify( "squadRageEnd" );
    var_67d84be6232392d2 = player getentitynumber();
    function_f97ae6f81b6d1a2a( player );
    function_5fa30f3682e17f8e( player.var_d4afb17212d1b2cc, var_67d84be6232392d2 );
    player.var_d4afb17212d1b2cc = undefined;
    return false;
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x7e9
// Size: 0x23
function private function_e159fabaa36f8e06()
{
    player = self;
    var_9c4c9186f375df3b = 0;
    player function_c35c3441b3cbdb88( var_9c4c9186f375df3b );
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x814
// Size: 0x24
function private function_83a05073c0b69a18()
{
    player = self;
    var_9c4c9186f375df3b = 1;
    player function_c35c3441b3cbdb88( var_9c4c9186f375df3b );
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x840
// Size: 0x78
function private function_50755760e28c7650( targetplayer, sourceplayer )
{
    var_50755760e28c7650 = 1;
    
    if ( !scripts\mp\utility\player::isaliveandnotinlaststand( targetplayer ) )
    {
        var_50755760e28c7650 = 0;
    }
    else if ( distance2dsquared( targetplayer.origin, sourceplayer.origin ) > level.var_699a1785b1375779.var_dd96ee76756a81c0 )
    {
        var_50755760e28c7650 = 0;
    }
    else if ( function_60c3cdee76647fbb( sourceplayer, targetplayer ) )
    {
        var_50755760e28c7650 = 0;
    }
    
    return var_50755760e28c7650;
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x8c1
// Size: 0xa9
function private function_60c3cdee76647fbb( playera, playerb )
{
    contents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight" ] );
    ignorelist = [ playera, playerb ];
    caststart = playera getvieworigin();
    castend = playerb getvieworigin();
    castresult = physics_raycast( caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1 );
    ishit = isdefined( castresult ) && castresult.size > 0;
    return ishit;
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x973
// Size: 0xb2
function private function_724f7991cf1b188f( player, var_a55d0c63a6a8001f )
{
    var_6f11f4b0bc82a74f = isdefined( var_a55d0c63a6a8001f );
    
    if ( istrue( var_6f11f4b0bc82a74f ) )
    {
        var_67d84be6232392d2 = var_a55d0c63a6a8001f getentitynumber();
        player thread scripts\mp\equipment\battlerage::function_905b7bada6fd91cb( 4, var_67d84be6232392d2 );
        player thread scripts\mp\hud_message::showsplash( "br_squad_rage_received_from_teammate", undefined, var_a55d0c63a6a8001f );
        
        if ( var_a55d0c63a6a8001f.team == player.team )
        {
            var_a55d0c63a6a8001f scripts\mp\utility\points::doscoreevent( #"hash_5df669a5faf48e22" );
        }
        
        return;
    }
    
    player thread scripts\mp\equipment\battlerage::function_905b7bada6fd91cb( 3 );
    
    if ( !istrue( level.var_699a1785b1375779.var_6bca48baec64109c ) )
    {
        player thread scripts\mp\hud_message::showsplash( "br_squad_rage_received_from_teammate", undefined, player );
    }
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xa2d
// Size: 0x40
function private function_f97ae6f81b6d1a2a( player, var_67d84be6232392d2 )
{
    var_6f11f4b0bc82a74f = isdefined( var_67d84be6232392d2 );
    
    if ( istrue( var_6f11f4b0bc82a74f ) )
    {
        player thread scripts\mp\equipment\battlerage::function_739a5f064c7debdf( 4, var_67d84be6232392d2 );
        return;
    }
    
    player thread scripts\mp\equipment\battlerage::function_739a5f064c7debdf( 3 );
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xa75
// Size: 0x38
function private function_92e76fa20cb89f9a( var_9cd097913ee71546, var_67d84be6232392d2 )
{
    player = self;
    player endon( "squadRageEnd" );
    player waittill( "disconnect" );
    function_5fa30f3682e17f8e( var_9cd097913ee71546, var_67d84be6232392d2 );
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xab5
// Size: 0x69
function private function_5fa30f3682e17f8e( var_9cd097913ee71546, var_67d84be6232392d2 )
{
    var_9cd097913ee71546 = array_removeundefined( var_9cd097913ee71546 );
    
    foreach ( player in var_9cd097913ee71546 )
    {
        function_f97ae6f81b6d1a2a( player, var_67d84be6232392d2 );
    }
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xb26
// Size: 0x7a
function private function_b389246eb36d7304()
{
    player = self;
    excludeent = player;
    desiredteam = ter_op( level.var_699a1785b1375779.var_82aefcede8e367d3, undefined, player.team );
    playersinrange = scripts\mp\utility\player::getplayersinradius( player.origin, level.var_699a1785b1375779.radius, desiredteam, excludeent );
    return playersinrange;
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xba9
// Size: 0x9a
function private function_c35c3441b3cbdb88( ison )
{
    player = self;
    
    if ( !istrue( player.var_8b7b081e7138be08 ) && ison )
    {
        player.var_8b7b081e7138be08 = 1;
        player scripts\mp\supers::function_7203e7aa96ff0ba9( level.var_699a1785b1375779.superid );
        player thread function_e35cc19118b077eb();
        player notify( "targetsDetectorWidgetCreated" );
        return;
    }
    
    if ( istrue( player.var_8b7b081e7138be08 ) && !ison )
    {
        player.var_8b7b081e7138be08 = undefined;
        player scripts\mp\supers::function_7203e7aa96ff0ba9( 0 );
        player notify( "targetsDetectorWidgetDestroyed" );
    }
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xc4b
// Size: 0xde
function private function_e35cc19118b077eb()
{
    player = self;
    level endon( "game_ended" );
    player endon( "targetsDetectorWidgetDestroyed" );
    player endon( "death_or_disconnect" );
    
    while ( true )
    {
        var_44b61bed3d930343 = player function_b389246eb36d7304();
        var_9d40510c508ac602 = [];
        
        foreach ( targetplayer in var_44b61bed3d930343 )
        {
            if ( function_50755760e28c7650( targetplayer, player ) && targetplayer.team == player.team )
            {
                var_9d40510c508ac602 = array_add( var_9d40510c508ac602, targetplayer );
            }
        }
        
        player function_1ed109091d07c347( var_9d40510c508ac602 );
        function_f632348cbb773537( level.var_699a1785b1375779.throttle, player );
    }
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xd31
// Size: 0x84
function private function_1ed109091d07c347( var_9d40510c508ac602 )
{
    player = self;
    packedvalue = 0;
    
    foreach ( targetplayer in var_9d40510c508ac602 )
    {
        packedvalue |= 1 << targetplayer.sessionuimemberindex;
    }
    
    player setclientomnvar( "ui_br_squad_rage_allies_in_range", packedvalue );
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xdbd
// Size: 0x34
function private function_a8be3990b76f02a1()
{
    player = self;
    
    if ( player isswimunderwater() )
    {
        player playlocalsound( "br_pickup_deny" );
        player scripts\mp\utility\lower_message::setlowermessageomnvar( "squad_rage_underwater", undefined, 5 );
    }
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xdf9
// Size: 0x23
function private function_23a9c3e65f94d2f7( var_24053699381a93f0 )
{
    level endon( "game_ended" );
    var_24053699381a93f0 endon( "death" );
    wait 30;
    var_24053699381a93f0 delete();
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xe24
// Size: 0x1f
function private function_53c04fa3cdca4a85( var_24053699381a93f0 )
{
    assert( isdefined( var_24053699381a93f0 ) );
    thread function_23a9c3e65f94d2f7( var_24053699381a93f0 );
}

// Namespace squad_rage / scripts\mp\supers\squad_rage
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xe4b
// Size: 0xe3
function private function_6fce2e1d1f1f4e9b( player, targetplayers )
{
    assert( isdefined( player ) );
    var_c8c2ad10041e3d13 = 0;
    
    foreach ( targetplayer in targetplayers )
    {
        assert( isdefined( targetplayer ) );
        
        if ( targetplayer.team == player.team )
        {
            var_c8c2ad10041e3d13++;
        }
    }
    
    var_dc85461061002fe = scripts\mp\utility\teams::getteamdata( player.team, "aliveCount" ) - 1;
    player dlog_recordplayerevent( "dlog_event_player_squad_rage_activated", [ "assisted_squadmates_count", var_c8c2ad10041e3d13, "alive_squadmates_count", var_dc85461061002fe ] );
}

