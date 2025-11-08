#using script_2d9d24f7c63ac143;
#using script_b7a9ce0a2282b79;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\dmz_dog_tag;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\game;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;

#namespace dmz_dog_tag;

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 0
// Checksum 0x0, Offset: 0x32f
// Size: 0x170
function function_d22b3026c3183ead()
{
    level.var_ec3a072500042491 = [ 13448, 13445, 13447, 13446 ];
    level.var_a98214b4bdc952cd = [ "brloot_dogtag_bronze", "brloot_dogtag_silver", "brloot_dogtag_gold", "brloot_dogtag_damascus" ];
    
    if ( !isdefined( level.br_pickups ) )
    {
        level waittill( "br_pickups_init" );
    }
    
    if ( !getdvarint( @"hash_ec32cd72ead6b977", 1 ) )
    {
        return;
    }
    
    level.dogtagobjectives = spawnstruct();
    level.dogtagobjectives.objectives = [];
    level.dogtagobjectives.playerobjectives = [];
    level.dogtagupdaterate = getdvarfloat( @"hash_5a1b0676e3c6c467", 10 );
    level.dogtagcircleradius = getdvarint( @"hash_2f56d4a76dc729e4", 2000 );
    scripts\mp\gametypes\br_pickups::registerpickupcreatedcallback( "brloot_dogtag_bronze", &function_ab266ca8693e5618 );
    scripts\mp\gametypes\br_pickups::registerpickupcreatedcallback( "brloot_dogtag_silver", &function_ab266ca8693e5618 );
    scripts\mp\gametypes\br_pickups::registerpickupcreatedcallback( "brloot_dogtag_gold", &function_ab266ca8693e5618 );
    scripts\mp\gametypes\br_pickups::registerpickupcreatedcallback( "brloot_dogtag_damascus", &function_ab266ca8693e5618 );
    scripts\common\callbacks::add( "player_connect", &onplayerconnect );
    scripts\engine\utility::registersharedfunc( "dogtag", "getDogTagVictimAndKiller", &getdogtagvictimandkiller );
    scripts\mp\team_assimilation::registerteamassimilatecallback( &onteamchange );
    
    /#
        level thread debugdogtags();
    #/
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4a7
// Size: 0x1e
function private onplayerconnect( params )
{
    self setclientomnvar( "ui_dmz_dog_tag", function_de2c669caf6fb1d( self ) );
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x4cd
// Size: 0x18b
function private onteamchange( player, oldteam, newteam )
{
    playerinfo = function_55b287be60b2ae11( player );
    
    if ( !isdefined( playerinfo ) )
    {
        return;
    }
    
    playerinfo.team = newteam;
    
    foreach ( teammember in getteamdata( newteam, "players" ) )
    {
        for ( i = 0; i < namespace_aead94004cf4c147::getplayerbackpacksize( teammember ) ; i++ )
        {
            if ( !function_3c17a26ce6a4668( teammember namespace_aead94004cf4c147::getlootidatbackpackindex( i ) ) )
            {
                continue;
            }
            
            quantity = teammember namespace_aead94004cf4c147::getQuantityAtBackpackIndex( i );
            
            if ( !scripts\mp\gametypes\dmz_dog_tag::function_d9f5c5090de1241b( teammember, quantity ) )
            {
                continue;
            }
            
            teammember namespace_aead94004cf4c147::function_db1dd76061352e5b( i, quantity );
            [ victimindex, _ ] = getdogtagvictimandkiller( quantity );
            victiminfo = level.dogtaginfo[ victimindex ];
            
            if ( isdefined( victiminfo.player ) )
            {
                function_8e643d6706defeea( victiminfo.player, quantity );
            }
            
            if ( !isdefined( victiminfo.player ) || victiminfo.player != teammember )
            {
                scripts\mp\gametypes\br_gametype_dmz::showdmzsplash( "dmz_recover_dog_tag", [ teammember ] );
            }
        }
    }
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 0
// Checksum 0x0, Offset: 0x660
// Size: 0xc, Type: bool
function function_2f6772930123576c()
{
    return isdefined( level.dogtagobjectives );
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0x675
// Size: 0x7a
function function_8e643d6706defeea( player, dogtagcount )
{
    function_bc03aa369196f2bf( player, 1 );
    
    if ( !istrue( level.var_2d15c14a954ff12f ) )
    {
        scripts\mp\gametypes\br_gametype_dmz::showdmzsplash( "dmz_recover_dog_tag", [ player ], undefined );
    }
    
    if ( function_2f6772930123576c() && function_6cd8c4885cb6775c( dogtagcount ) )
    {
        objstruct = level.dogtagobjectives.objectives[ dogtagcount ];
        function_e98b03b1ec8385fe( objstruct );
    }
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0x6f7
// Size: 0x15f
function function_b5fbe3cb4ed955f4( enemy, dogtagcount )
{
    if ( function_2f6772930123576c() )
    {
        if ( function_6cd8c4885cb6775c( dogtagcount ) )
        {
            objstruct = level.dogtagobjectives.objectives[ dogtagcount ];
            function_e98b03b1ec8385fe( objstruct );
        }
        
        if ( function_1a21a83169ad19f9( enemy ) )
        {
            function_8945131b7b8a89c8( enemy, dogtagcount );
        }
        else
        {
            function_433d4c5bc4da9ead( enemy, dogtagcount );
        }
        
        [ victimindex, _ ] = getdogtagvictimandkiller( dogtagcount );
        info = level.dogtaginfo[ victimindex ];
        
        if ( isdefined( info ) && isdefined( info.team ) )
        {
            teammembers = getteamdata( info.team, "players" );
            
            if ( isdefined( info.player ) )
            {
                teammembers = array_remove( teammembers, info.player );
                scripts\cp_mp\overlord::playevent( "dogtag_stolen_from_you", [ info.player ] );
            }
            
            scripts\cp_mp\overlord::playevent( "dogtag_stolen_from_teammate", teammembers );
        }
        
        if ( isdefined( enemy.team ) )
        {
            scripts\cp_mp\overlord::function_9793a81bc3bc19e9( "dogtag_stolen_from_enemy", enemy.team );
        }
    }
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 0
// Checksum 0x0, Offset: 0x85e
// Size: 0x9b
function function_ab266ca8693e5618()
{
    if ( function_2f6772930123576c() )
    {
        count = scripts\mp\gametypes\br_pickups::loot_getitemcount( self );
        countlefthand = scripts\mp\gametypes\br_pickups::loot_getitemcountlefthand( self );
        countalt = scripts\mp\gametypes\br_pickups::function_3a5f7703319142dd( self );
        dogtagcount = function_b5d4fcc3fab92696( self );
        
        if ( function_6cd8c4885cb6775c( dogtagcount ) )
        {
            objstruct = level.dogtagobjectives.objectives[ dogtagcount ];
            
            if ( isdefined( objstruct.carryingplayer ) )
            {
                function_a9e95e007eb70709( objstruct, dogtagcount );
                function_42426b559596ae56( self, dogtagcount );
            }
        }
    }
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0x901
// Size: 0xa9
function function_ea29bccf97cb1b9a( killer, dogtagcount )
{
    [ victimindex, _ ] = getdogtagvictimandkiller( dogtagcount );
    
    if ( isdefined( victimindex ) && isdefined( level.dogtaginfo ) && isdefined( level.dogtaginfo[ victimindex ] ) && !istrue( level.dogtaginfo[ victimindex ].var_c9efb56fdfb33e52 ) )
    {
        level.dogtaginfo[ victimindex ].var_c9efb56fdfb33e52 = 1;
        scripts\mp\gametypes\br_gametype_dmz::showdmzsplash( "dmz_kill_confirm_dog_tag", [ killer ] );
    }
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x9b2
// Size: 0x3e
function function_1a21a83169ad19f9( player )
{
    if ( isdefined( level.dogtagobjectives ) )
    {
        return isdefined( level.dogtagobjectives.playerobjectives[ player.guid ] );
    }
    
    return 0;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x9f8
// Size: 0x34
function function_6cd8c4885cb6775c( dogtagcount )
{
    if ( isdefined( level.dogtagobjectives ) )
    {
        return isdefined( level.dogtagobjectives.objectives[ dogtagcount ] );
    }
    
    return 0;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0xa34
// Size: 0x99
function function_3bfe56fc3c2bb91e( origin, inworld )
{
    objstruct = spawnstruct();
    objstruct.curorigin = origin;
    objstruct.offset3d = ( 0, 0, 100 );
    objstruct scripts\mp\gameobjects::requestid( 1, inworld, undefined, 1, 0 );
    scripts\mp\objidpoolmanager::update_objective_icon( objstruct.objidnum, "hud_icon_objective_dog_tag" );
    scripts\mp\objidpoolmanager::update_objective_setbackground( objstruct.objidnum, 1 );
    scripts\mp\objidpoolmanager::update_objective_setzoffset( objstruct.objidnum, 100 );
    return objstruct;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0xad6
// Size: 0xf1
function function_42426b559596ae56( scriptable, dogtagcount )
{
    [ victimindex, _ ] = getdogtagvictimandkiller( dogtagcount );
    objstruct = function_3bfe56fc3c2bb91e( scriptable.origin, 1 );
    objstruct.scriptable = scriptable;
    scripts\mp\objidpoolmanager::update_objective_position( objstruct.objidnum, objstruct.scriptable.origin + ( 0, 0, 50 ) );
    scripts\mp\objidpoolmanager::objective_teammask_addtomask( objstruct.objidnum, level.dogtaginfo[ victimindex ].team );
    objstruct.dogtags = [ dogtagcount ];
    level.dogtagobjectives.objectives[ dogtagcount ] = objstruct;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0xbcf
// Size: 0x6e
function function_62b5f185de3ab25d( array, objstruct )
{
    newarray = [];
    
    foreach ( dogtagcount, obj in array )
    {
        if ( obj != objstruct )
        {
            newarray[ dogtagcount ] = obj;
        }
    }
    
    return newarray;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0xc46
// Size: 0xdb
function function_e98b03b1ec8385fe( objstruct )
{
    objstruct notify( "stop_tracking" );
    objstruct scripts\mp\gameobjects::releaseid();
    objstruct scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
    
    foreach ( obj in level.dogtagobjectives.objectives )
    {
        if ( obj == objstruct )
        {
        }
    }
    
    level.dogtagobjectives.objectives = function_62b5f185de3ab25d( level.dogtagobjectives.objectives, objstruct );
    level.dogtagobjectives.playerobjectives = function_62b5f185de3ab25d( level.dogtagobjectives.playerobjectives, objstruct );
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0xd29
// Size: 0x3f
function function_77060da87f0214f7( origin )
{
    point = function_d553466cf817a4da();
    point = ( point[ 0 ] * level.dogtagcircleradius, point[ 1 ] * level.dogtagcircleradius, 0 );
    return point + origin;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0xd71
// Size: 0x65
function function_3de97c52c88c8a20( objstruct, player )
{
    origin = function_77060da87f0214f7( player.origin );
    origin += ( 0, 0, player.origin[ 2 ] + 750 );
    scripts\mp\objidpoolmanager::update_objective_position( objstruct.objidnum, origin );
    objstruct scripts\cp_mp\utility\game_utility::function_6e148c8da2e4db13( origin );
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0xdde
// Size: 0x1b9
function function_433d4c5bc4da9ead( player, dogtagcount )
{
    [ victimindex, _ ] = getdogtagvictimandkiller( dogtagcount );
    
    if ( !isdefined( victimindex ) || !isdefined( level.dogtaginfo[ victimindex ] ) )
    {
        return;
    }
    
    team = level.dogtaginfo[ victimindex ].team;
    objstruct = function_3bfe56fc3c2bb91e( player.origin, 0 );
    scripts\mp\objidpoolmanager::objective_teammask_addtomask( objstruct.objidnum, team );
    objstruct.carryingplayer = player;
    objstruct.dogtags = [ dogtagcount ];
    objstruct scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522( "DogTagObj_Dmz", function_77060da87f0214f7( objstruct.carryingplayer.origin ), level.dogtagcircleradius );
    objstruct scripts\cp_mp\utility\game_utility::function_4eaf685bc40a3b9();
    teammates = getteamdata( team, "players" );
    
    foreach ( teammate in teammates )
    {
        objstruct scripts\cp_mp\utility\game_utility::function_cfd53c8f6878014f( teammate );
    }
    
    objstruct notify( "stop_tracking" );
    thread function_8a3a6225b2e11801( objstruct );
    thread function_dfe0992113030bd0( objstruct );
    level.dogtagobjectives.objectives[ dogtagcount ] = objstruct;
    level.dogtagobjectives.playerobjectives[ player.guid ] = objstruct;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0xf9f
// Size: 0x150
function function_8945131b7b8a89c8( player, dogtagcount )
{
    [ victimindex, _ ] = getdogtagvictimandkiller( dogtagcount );
    
    if ( !isdefined( victimindex ) || !isdefined( level.dogtaginfo[ victimindex ] ) )
    {
        return;
    }
    
    team = level.dogtaginfo[ victimindex ].team;
    objstruct = level.dogtagobjectives.playerobjectives[ player.guid ];
    objstruct.dogtags = array_add( objstruct.dogtags, dogtagcount );
    level.dogtagobjectives.objectives[ dogtagcount ] = objstruct;
    teammates = getteamdata( team, "players" );
    
    foreach ( teammate in teammates )
    {
        objstruct scripts\cp_mp\utility\game_utility::function_cfd53c8f6878014f( teammate );
    }
    
    scripts\mp\objidpoolmanager::objective_teammask_addtomask( objstruct.objidnum, team );
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0x10f7
// Size: 0x142
function function_a9e95e007eb70709( objstruct, dogtagcount )
{
    [ victimindex, _ ] = getdogtagvictimandkiller( dogtagcount );
    
    if ( !isdefined( victimindex ) || !isdefined( level.dogtaginfo[ victimindex ] ) )
    {
        return;
    }
    
    team = level.dogtaginfo[ victimindex ].team;
    level.dogtagobjectives.objectives[ dogtagcount ] = undefined;
    objstruct.dogtags = array_remove( objstruct.dogtags, dogtagcount );
    
    if ( !function_2e13cc7d90ee5683( objstruct.carryingplayer, team ) )
    {
        teammates = getteamdata( team, "players" );
        
        foreach ( teammate in teammates )
        {
            objstruct scripts\cp_mp\utility\game_utility::function_d7d113d56ef0ef5b( teammate );
        }
    }
    
    if ( objstruct.dogtags.size == 0 )
    {
        function_e98b03b1ec8385fe( objstruct );
    }
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x1241
// Size: 0xcc
function function_8a3a6225b2e11801( objstruct )
{
    objstruct endon( "stop_tracking" );
    objstruct.carryingplayer endon( "death_or_disconnect" );
    objstruct.carryingplayer endon( "enter_live_ragdoll" );
    level endon( "game_ended" );
    
    while ( true )
    {
        objstruct.carryingplayer waittill( "item_added_to_cache", itemtype, itemindex, lootid, quantity );
        
        if ( isdefined( objstruct ) && isdefined( objstruct.carryingplayer ) && isdefined( lootid ) && isdefined( quantity ) && isdefined( level.var_ec3a072500042491 ) && array_contains( level.var_ec3a072500042491, lootid ) )
        {
            thread function_a9e95e007eb70709( objstruct, quantity );
        }
    }
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x1315
// Size: 0x89
function function_dfe0992113030bd0( objstruct )
{
    objstruct endon( "stop_tracking" );
    objstruct.carryingplayer endon( "death_or_disconnect" );
    objstruct.carryingplayer endon( "enter_live_ragdoll" );
    level endon( "game_ended" );
    
    while ( true )
    {
        if ( isdefined( objstruct.carryingplayer ) && isdefined( objstruct.carryingplayer.origin ) )
        {
            function_3de97c52c88c8a20( objstruct, objstruct.carryingplayer );
        }
        
        wait level.dogtagupdaterate;
    }
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0x13a6
// Size: 0x11f, Type: bool
function function_2e13cc7d90ee5683( player, team )
{
    if ( isdefined( level.dogtagobjectives ) && function_1a21a83169ad19f9( player ) )
    {
        objstruct = level.dogtagobjectives.playerobjectives[ player.guid ];
        
        foreach ( dogtagcount in objstruct.dogtags )
        {
            [ victimindex, _ ] = getdogtagvictimandkiller( dogtagcount );
            
            if ( isdefined( victimindex ) && isdefined( level.dogtaginfo[ victimindex ] ) && isdefined( level.dogtaginfo[ victimindex ].team ) && level.dogtaginfo[ victimindex ].team == team )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x14ce
// Size: 0x80, Type: bool
function hasdogtag( player )
{
    if ( !namespace_aead94004cf4c147::function_720d227d0e55a960() )
    {
        return false;
    }
    
    if ( player scripts\mp\gametypes\br_public::isplayeringulag() )
    {
        return false;
    }
    
    if ( !isdefined( level.dogtaginfo ) )
    {
        level.dogtaginfo = [];
    }
    
    if ( !isdefined( level.var_9a595fc01ad18995 ) )
    {
        level.var_9a595fc01ad18995 = [];
    }
    
    deathindex = function_fb2923d9d7eb7aac( player );
    return !isdefined( deathindex ) || !istrue( level.var_9a595fc01ad18995[ player.guid ] );
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x1557
// Size: 0x64
function function_59771b0cc100410a( player )
{
    if ( scripts\mp\utility\game::getsubgametype() != "dmz" && getdvarint( @"hash_7bea5a5cf88445dc", 0 ) )
    {
        return "brloot_dogtag";
    }
    
    tier = function_de2c669caf6fb1d( player );
    
    if ( isdefined( level.var_a98214b4bdc952cd ) )
    {
        return level.var_a98214b4bdc952cd[ tier ];
    }
    
    return "brloot_dogtag_bronze";
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x15c4
// Size: 0x3a
function function_777013e79be19c16( player )
{
    tier = function_de2c669caf6fb1d( player );
    
    if ( isdefined( level.var_ec3a072500042491 ) )
    {
        return level.var_ec3a072500042491[ tier ];
    }
    
    return 13448;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x1607
// Size: 0x5d
function function_2d2f7e8a6547ae42( lootid )
{
    switch ( lootid )
    {
        case 13448:
            return 0;
        case 13445:
            return 1;
        case 13447:
            return 2;
        case 13446:
            return 3;
        default:
            return 0;
    }
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x166c
// Size: 0xcc
function private function_de2c669caf6fb1d( player )
{
    if ( !isdefined( level.var_a98214b4bdc952cd ) && isdefined( level.var_ec3a072500042491 ) )
    {
        assertmsg( "<dev string:x1c>" );
        return 0;
    }
    
    if ( !isdefined( player ) )
    {
        assertmsg( "<dev string:x51>" );
        return 0;
    }
    
    /#
        overridetier = getdvarint( @"hash_855a310cd1834a3e", -1 );
        
        if ( overridetier >= 0 )
        {
            return overridetier;
        }
    #/
    
    [ streak, _ ] = namespace_a38a2e1fe7519183::function_1558f8fb859c492a( player );
    
    if ( !isdefined( streak ) )
    {
        return 0;
    }
    
    if ( streak >= 10 )
    {
        return 3;
    }
    else if ( streak >= 5 )
    {
        return 2;
    }
    else if ( streak >= 2 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0x1741
// Size: 0x83
function function_bc03aa369196f2bf( player, hastag )
{
    if ( !isdefined( level.var_9a595fc01ad18995 ) )
    {
        level.var_9a595fc01ad18995 = [];
    }
    
    if ( istrue( hastag ) )
    {
        level.var_9a595fc01ad18995[ player.guid ] = undefined;
        omnvarvalue = function_de2c669caf6fb1d( player );
    }
    else
    {
        level.var_9a595fc01ad18995[ player.guid ] = 1;
        omnvarvalue = -1;
    }
    
    player setclientomnvar( "ui_dmz_dog_tag", omnvarvalue );
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0x17cc
// Size: 0x6a, Type: bool
function function_dd15435220e4207( player, dogtagcount )
{
    if ( !isdefined( dogtagcount ) )
    {
        return false;
    }
    
    var_f3c7c0cfc3e37302 = function_fb2923d9d7eb7aac( player );
    
    if ( !isdefined( var_f3c7c0cfc3e37302 ) )
    {
        return false;
    }
    
    [ victimindex, _ ] = getdogtagvictimandkiller( dogtagcount );
    return isdefined( victimindex ) && victimindex == var_f3c7c0cfc3e37302;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x183f
// Size: 0x2f, Type: bool
function function_3c17a26ce6a4668( lootid )
{
    return isdefined( lootid ) && isdefined( level.var_ec3a072500042491 ) && array_contains( level.var_ec3a072500042491, lootid );
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0x1877
// Size: 0xb3, Type: bool
function function_d9f5c5090de1241b( player, dogtagcount )
{
    if ( !isdefined( player.team ) || !isdefined( level.dogtaginfo ) )
    {
        return false;
    }
    
    [ victimindex, _ ] = getdogtagvictimandkiller( dogtagcount );
    return isdefined( victimindex ) && isdefined( level.dogtaginfo[ victimindex ] ) && isdefined( level.dogtaginfo[ victimindex ].team ) && level.dogtaginfo[ victimindex ].team == player.team;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2
// Checksum 0x0, Offset: 0x1933
// Size: 0xb9, Type: bool
function function_1129ba5718d33025( killer, dogtagcount )
{
    if ( !isdefined( killer ) || !isdefined( killer.guid ) || !isdefined( level.dogtaginfo ) )
    {
        return false;
    }
    
    [ _, killerindex ] = getdogtagvictimandkiller( dogtagcount );
    return isdefined( killerindex ) && isdefined( level.dogtaginfo[ killerindex ] ) && isdefined( level.dogtaginfo[ killerindex ].guid ) && level.dogtaginfo[ killerindex ].guid == killer.guid;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x19f5
// Size: 0x7a
function function_57711583c5d26490( victim )
{
    if ( !isdefined( victim ) )
    {
        return 0;
    }
    
    victimindex = function_fb2923d9d7eb7aac( victim );
    
    if ( !isdefined( victimindex ) )
    {
        return ( 61 | 61 << 6 );
    }
    
    playerinfo = function_55b287be60b2ae11( victim );
    killerindex = 61;
    
    if ( isdefined( playerinfo ) && isdefined( playerinfo.killer ) )
    {
        killerindex = playerinfo.killer;
    }
    
    return function_99cbbc040233be98( victimindex, killerindex );
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x1a78
// Size: 0x3c
function function_379463a84adb07b4( count )
{
    if ( !isdefined( count ) )
    {
        return [ 61, 61, 0 ];
    }
    
    return [ count & 64 - 1, count >> 6, 0 ];
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x1abd
// Size: 0xa0
function function_b5d4fcc3fab92696( pickup )
{
    if ( istrue( pickup.var_5754163e12f63fa7 ) || pickup.count > 61 )
    {
        return pickup.count;
    }
    
    pickup.var_5754163e12f63fa7 = 1;
    result = 0;
    
    if ( isdefined( pickup.count ) )
    {
        result += pickup.count;
    }
    
    if ( isdefined( pickup.countlefthand ) )
    {
        result += pickup.countlefthand << 6;
    }
    
    pickup.count = result;
    return result;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 3
// Checksum 0x0, Offset: 0x1b66
// Size: 0x90
function function_f6d685cabfad2ce9( victim, killer, weapon )
{
    if ( !isdefined( level.dogtaginfo ) )
    {
        level.dogtaginfo = [];
    }
    
    if ( !isdefined( function_fb2923d9d7eb7aac( victim ) ) )
    {
        function_ad150ee445d765a6( victim );
    }
    
    if ( isdefined( killer ) && isplayer( killer ) && !isdefined( function_fb2923d9d7eb7aac( killer ) ) )
    {
        function_ad150ee445d765a6( killer );
    }
    
    if ( isdefined( victim ) && isdefined( killer ) && ( victim == killer || !isplayer( killer ) ) )
    {
        killer = undefined;
    }
    
    function_56995ecb525c7b1( victim, killer );
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1bfe
// Size: 0x106
function private function_ad150ee445d765a6( player )
{
    if ( level.dogtaginfo.size >= 60 )
    {
        return;
    }
    
    info = spawnstruct();
    info.xuid = function_b362c4581e1071bb( player getxuid() );
    info.team = player.team;
    info.guid = player.guid;
    info.player = player;
    
    foreach ( player in level.players )
    {
        player setplayerdata( level.progressiongroup, "dogTagInfo", level.dogtaginfo.size, "deadPlayerXuid", info.xuid );
    }
    
    level.dogtaginfo[ level.dogtaginfo.size ] = info;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x1d0c
// Size: 0x58
function getdogtagvictimandkiller( dogtagcount )
{
    if ( !isdefined( dogtagcount ) )
    {
        return [ undefined, undefined ];
    }
    
    dogtagcount -= 1;
    victimindex = dogtagcount & 64 - 1;
    killerindex = dogtagcount >> 6;
    
    if ( killerindex > 60 )
    {
        killerindex = undefined;
    }
    
    return [ victimindex, killerindex ];
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1d6d
// Size: 0x2a
function private function_99cbbc040233be98( victimindex, killerindex )
{
    if ( !isdefined( victimindex ) || !isdefined( killerindex ) )
    {
        return undefined;
    }
    
    return ( killerindex << 6 | victimindex ) + 1;
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x1da0
// Size: 0x86
function function_fb2923d9d7eb7aac( player )
{
    if ( isdefined( player ) && isdefined( level.dogtaginfo ) )
    {
        foreach ( index, info in level.dogtaginfo )
        {
            if ( info.guid == player.guid )
            {
                return index;
            }
        }
    }
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1e2e
// Size: 0x86
function private function_55b287be60b2ae11( player )
{
    if ( isdefined( player ) && isdefined( level.dogtaginfo ) )
    {
        foreach ( info in level.dogtaginfo )
        {
            if ( info.guid == player.guid )
            {
                return info;
            }
        }
    }
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1ebc
// Size: 0xc5
function private function_56995ecb525c7b1( victim, killer )
{
    if ( isdefined( victim ) && isdefined( level.dogtaginfo ) )
    {
        foreach ( info in level.dogtaginfo )
        {
            if ( info.guid == victim.guid )
            {
                info.var_c9efb56fdfb33e52 = 0;
                
                if ( isdefined( killer ) )
                {
                    info.killer = function_fb2923d9d7eb7aac( killer );
                }
                else
                {
                    info.killer = 61;
                }
                
                break;
            }
        }
    }
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 1
// Checksum 0x0, Offset: 0x1f89
// Size: 0xa7
function function_941fe2b16d6fff9d( player )
{
    if ( !isdefined( level.dogtaginfo ) )
    {
        level.dogtaginfo = [];
    }
    
    for ( index = 0; index < 60 ; index++ )
    {
        xuid = "0";
        
        if ( isdefined( level.dogtaginfo[ index ] ) && isdefined( level.dogtaginfo[ index ].xuid ) )
        {
            xuid = level.dogtaginfo[ index ].xuid;
        }
        
        player setplayerdata( level.progressiongroup, "dogTagInfo", index, "deadPlayerXuid", xuid );
    }
}

// Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
// Params 0
// Checksum 0x0, Offset: 0x2038
// Size: 0xa
function function_20d00accaa12c27f()
{
    return 61 | 61 << 6;
}

/#

    // Namespace dmz_dog_tag / scripts\mp\gametypes\dmz_dog_tag
    // Params 0
    // Checksum 0x0, Offset: 0x204b
    // Size: 0x288, Type: dev
    function debugdogtags()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_b044a50f64f8d1f4", 0 ) )
            {
                setdvar( @"hash_b044a50f64f8d1f4", 0 );
                dogtags = getentitylessscriptablearray( "<dev string:x90>" );
                
                if ( dogtags.size )
                {
                    dogtag = dogtags[ 0 ];
                    bot = undefined;
                    
                    foreach ( player in level.players )
                    {
                        if ( isbot( player ) && isalive( player ) && player.team != level.players[ 0 ].team )
                        {
                            bot = player;
                            break;
                        }
                    }
                    
                    scripts\mp\gametypes\br_pickups::lootused( dogtag, "<dev string:x90>", "<dev string:xa8>", bot );
                }
            }
            
            if ( getdvarint( @"hash_db9e3d9e8570dfb3", 0 ) )
            {
                setdvar( @"hash_db9e3d9e8570dfb3", 0 );
                enemybot = undefined;
                
                foreach ( player in level.players )
                {
                    if ( isbot( player ) && isalive( player ) && player.team != level.players[ 0 ].team )
                    {
                        enemybot = player;
                        break;
                    }
                }
                
                friendlybot = undefined;
                
                foreach ( player in level.players )
                {
                    if ( isbot( player ) && isalive( player ) && player.health > 50 && player.team == level.players[ 0 ].team )
                    {
                        friendlybot = player;
                        break;
                    }
                }
                
                friendlybot dodamage( 10000, enemybot.origin, enemybot, enemybot );
                wait 3;
                friendlybot dodamage( 10000, enemybot.origin, enemybot, enemybot );
            }
            
            waitframe();
        }
    }

#/
