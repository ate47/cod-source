#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_24f248b33b79e48d;
#using script_3ab210ea917601e7;
#using script_3ac7886f9e4eceef;
#using script_41387eecc35b88bf;
#using script_4fdefae8b7bcdf73;
#using script_7956d56c4922bd1;
#using scripts\common\callbacks;
#using scripts\common\conditional_container;
#using scripts\common\utility;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\teams;

#namespace namespace_553c3c813ee2de54;

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1
// Checksum 0x0, Offset: 0x2a2
// Size: 0x90
function function_c993d376e8f10816( var_d3f89f07fe3fa0ab )
{
    function_84ac3d5c82b5ba3c();
    callback::add( "player_connect", &function_e5594507f84bc271 );
    callback::add( "player_death", &function_f0ab0b7c533f4200 );
    var_d3f89f07fe3fa0ab.playerfocusconditions = spawnstruct();
    var_d3f89f07fe3fa0ab.playerfocusconditions function_a1f71337a6844055();
    addcondition( var_d3f89f07fe3fa0ab.playerfocusconditions, &function_935c3f2efd9c2a4a, [] );
    addcondition( var_d3f89f07fe3fa0ab.playerfocusconditions, &function_2febe1d03af425f7, [] );
    level thread function_dfae5859962924f2();
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1
// Checksum 0x0, Offset: 0x33a
// Size: 0x27
function function_1f99e5a11b5e285b( player )
{
    if ( !function_6152021549f1836b( player ) )
    {
        player.activities = function_fb0ef9f4034927f8();
    }
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1
// Checksum 0x0, Offset: 0x369
// Size: 0x17, Type: bool
function function_6152021549f1836b( player )
{
    return isdefined( player.activities );
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1
// Checksum 0x0, Offset: 0x389
// Size: 0x28
function function_5cc2fd3d10cbab56( player )
{
    if ( !function_6152021549f1836b( player ) )
    {
        function_1f99e5a11b5e285b( player );
    }
    
    return player.activities;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 0
// Checksum 0x0, Offset: 0x3ba
// Size: 0xa7
function function_dfae5859962924f2()
{
    level endon( "game_ended" );
    var_84136076a28f85b4 = spawnstruct();
    var_186eafd5a207b951 = function_a5424c44da084d6e();
    var_84136076a28f85b4.var_186eafd5a207b951 = var_186eafd5a207b951;
    
    while ( !isdefined( level.players ) && !isarray( level.players ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        var_be685114ee68c2f3 = gettime();
        var_84136076a28f85b4 function_ec65095e6f342856( level.players, &function_512997cf3f5c2f8a, &function_ef2b4cd10b36a1ae, undefined, 2, 0 );
        var_de12597002155e64 = gettime();
        
        if ( var_be685114ee68c2f3 == var_de12597002155e64 )
        {
            waitframe();
        }
    }
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1
// Checksum 0x0, Offset: 0x469
// Size: 0xd5
function function_dacf6dd70b828aad( player )
{
    closestid = undefined;
    closestdistance = undefined;
    var_32a6f9b3d487152d = function_553a690e1064cf0b( player );
    
    foreach ( instanceid, activityinfostruct in var_32a6f9b3d487152d )
    {
        activityinstance = getactivityinstance( instanceid );
        playerdistancesq = distancesquared( player.origin, namespace_68dc261109a9503f::function_8988a4c89289d7f4( self ) );
        
        if ( !isdefined( closestid ) || !isdefined( closestdistance ) || playerdistancesq < closestdistance )
        {
            closestdistance = playerdistancesq;
            closestid = instanceid;
        }
    }
    
    if ( isdefined( closestid ) )
    {
        return getactivityinstance( closestid );
    }
    
    return undefined;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0x547
// Size: 0x11a
function function_51c944aa48d1ce48( player, var_4224a1fc6427bcc7 )
{
    if ( function_2a1e9879f71ab677( @"hash_15cad8df54bccf1e" ) )
    {
        var_9aa1dc750ab65865 = function_deb5a4d2a7bda5e9( player );
        
        if ( isdefined( var_9aa1dc750ab65865 ) )
        {
            logtext = "Player Switched their Focus away from: " + function_68e0a0bea0dd792c( var_9aa1dc750ab65865 ) + " and onto: " + function_68e0a0bea0dd792c( var_4224a1fc6427bcc7 );
            activitynexuslog( logtext, @"hash_15cad8df54bccf1e", undefined, [ player ] );
        }
    }
    
    function_7a68246baec59148( player );
    var_871df5c434cefb0a = getinstanceid( var_4224a1fc6427bcc7 );
    var_32a6f9b3d487152d = function_553a690e1064cf0b( player );
    var_a5e113e92237f95a = var_32a6f9b3d487152d[ var_871df5c434cefb0a ];
    var_f06fa9ff431c0089 = istrue( var_a5e113e92237f95a.var_ab4cdd1bcafb1dff );
    player function_6fefd7e95fdfcc89( var_4224a1fc6427bcc7 );
    
    if ( var_f06fa9ff431c0089 )
    {
        relevantinfostruct = spawnstruct();
        relevantinfostruct.playerlist = [ player ];
        announceactivitymoment( var_4224a1fc6427bcc7, "PlayerRefocusedOnActivity", relevantinfostruct );
    }
    
    function_261533bdcfe64be0( player, var_4224a1fc6427bcc7 );
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1
// Checksum 0x0, Offset: 0x669
// Size: 0x5b
function function_d10ee44b55e7d8d4( player )
{
    var_21fe41e9dbb5c0fb = function_71e9ad7d057fc10d( player );
    
    if ( isdefined( var_21fe41e9dbb5c0fb ) )
    {
        var_3c214072a74a856c = getinstanceid( var_21fe41e9dbb5c0fb );
        var_69605a92b368f137 = player function_b9a4c528a6fd77cf();
        
        if ( !isdefined( var_69605a92b368f137 ) || var_3c214072a74a856c != var_69605a92b368f137 )
        {
            function_51c944aa48d1ce48( player, var_21fe41e9dbb5c0fb );
        }
    }
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1
// Checksum 0x0, Offset: 0x6cc
// Size: 0x20, Type: bool
function function_3e82ebe92b9fa877( player )
{
    var_1c69f70de3a758f1 = player function_b9a4c528a6fd77cf();
    return isdefined( var_1c69f70de3a758f1 );
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0x6f5
// Size: 0x41, Type: bool
function function_9a5bdd69b1e544f9( player, activityinstance )
{
    var_1c69f70de3a758f1 = player function_b9a4c528a6fd77cf();
    
    if ( !isdefined( var_1c69f70de3a758f1 ) || var_1c69f70de3a758f1 != activityinstance.id )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0x73f
// Size: 0x52, Type: bool
function function_bfda021631854371( player, activitytype )
{
    var_69605a92b368f137 = player function_b9a4c528a6fd77cf();
    
    if ( isdefined( var_69605a92b368f137 ) )
    {
        currentfocusedactivity = getactivityinstance( var_69605a92b368f137 );
        
        if ( isdefined( currentfocusedactivity ) && getactivitytype( currentfocusedactivity ) == activitytype )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1
// Checksum 0x0, Offset: 0x79a
// Size: 0x35
function function_7a68246baec59148( player )
{
    oldinstance = function_deb5a4d2a7bda5e9( player );
    
    if ( isdefined( oldinstance ) )
    {
        function_575933e868e5c6e8( player, oldinstance );
    }
    
    player function_69f5f64b2f31e8c3( undefined );
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0x7d7
// Size: 0x3b
function function_47e109e0d8027d54( player, activityinstance )
{
    if ( function_71d38726159c3f12( 6 ) )
    {
        return function_f541e4e4edaa8e99( 6, [ activityinstance, player ], 0 );
    }
    
    return function_ff52316e5fb7e838( player, activityinstance );
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0x81b
// Size: 0x33
function function_575933e868e5c6e8( player, activityinstance )
{
    activityinstance function_2d38888e45d6a28a( player );
    activityinstance function_94050b71cb4ef1ca( [ player ] );
    function_4f871ff9eb56f17( player, activityinstance );
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0x856
// Size: 0x33
function function_261533bdcfe64be0( player, activityinstance )
{
    activityinstance function_947973be56e0dbb2( [ player ] );
    activityinstance function_451ffc1b7133042f( player );
    function_39cdb60af8e36365( player, activityinstance );
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1
// Checksum 0x0, Offset: 0x891
// Size: 0x29
function function_1c121cfcda39970d( player )
{
    var_3900d8bea91376b4 = function_5cc2fd3d10cbab56( player );
    return var_3900d8bea91376b4.completedactivities;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1
// Checksum 0x0, Offset: 0x8c3
// Size: 0x2c
function function_deb5a4d2a7bda5e9( player )
{
    focusedactivityid = player function_b9a4c528a6fd77cf();
    
    if ( isdefined( focusedactivityid ) )
    {
        return getactivityinstance( focusedactivityid );
    }
    
    return undefined;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0x8f8
// Size: 0x88
function function_1015815db0b598c2( player, activityinstance )
{
    completedactivityinfo = spawnstruct();
    var_3900d8bea91376b4 = function_5cc2fd3d10cbab56( player );
    var_3900d8bea91376b4.completedactivities[ var_3900d8bea91376b4.completedactivities.size ] = completedactivityinfo;
    completedactivityinfo.success = function_bdd22095c4312f34( activityinstance );
    completedactivityinfo.activitytype = getactivitytype( activityinstance );
    completedactivityinfo.varianttag = function_a4748b32a824c79c( activityinstance );
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0x988
// Size: 0x50
function function_973730f0a5275485( player, params )
{
    assertex( params.size == 1 && isdefined( params[ 0 ] ), "<dev string:x1c>" );
    activityinstance = params[ 0 ];
    var_1206ca5d90319311 = function_9a5bdd69b1e544f9( player, activityinstance );
    return var_1206ca5d90319311;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0x9e1
// Size: 0x67, Type: bool
function function_d49dc10646971d24( player, params )
{
    assertex( params.size == 1 && isdefined( params[ 0 ] ), "<dev string:x1c>" );
    activityinstance = params[ 0 ];
    var_1206ca5d90319311 = function_9a5bdd69b1e544f9( player, activityinstance );
    var_2cfbf3c881517abf = isdefined( player function_b9a4c528a6fd77cf() );
    return var_1206ca5d90319311 || !var_2cfbf3c881517abf;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0xa51
// Size: 0x3c
function function_2febe1d03af425f7( player, params )
{
    var_3c2942567059c7bb = player function_1622a54acd6019d6();
    var_5529eb88d67ca2df = !isdefined( var_3c2942567059c7bb ) || var_3c2942567059c7bb > 10;
    return var_5529eb88d67ca2df;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0xa96
// Size: 0x2d, Type: bool
function function_3b6f0ac301030549( player, params )
{
    var_1eeab92b9ab50bde = isdefined( player.var_2fa5b49969def47 );
    return !var_1eeab92b9ab50bde;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0xacc
// Size: 0x1f, Type: bool
function function_388f018d407adc40( player, params )
{
    return isdefined( player ) && isplayer( player );
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0xaf4
// Size: 0x129, Type: bool
function function_bc33f8483c604d9b( player, params )
{
    assertex( params.size == 2 && isdefined( params[ 0 ] ) && isdefined( params[ 1 ] ), "<dev string:x1c>" );
    conditionalcontainer = params[ 0 ];
    activityinstance = params[ 1 ];
    
    if ( !isdefined( conditionalcontainer.broadcastdefinition ) )
    {
        return true;
    }
    
    activationmoment = namespace_c47da9d4c2db4f0d::function_c24185c47d989c1a( conditionalcontainer.broadcastdefinition );
    
    if ( activationmoment != "PlayerJoin" )
    {
        return true;
    }
    
    lastassimedplayer = undefined;
    
    if ( scripts\cp_mp\utility\squad_utility::issquadmode() && scripts\cp_mp\squads::function_be6ce63a202791c5( player.team, player.sessionsquadid, "lastAssimedPlayer" ) )
    {
        lastassimedplayer = scripts\cp_mp\squads::getsquaddata( player.team, player.sessionsquadid, "lastAssimedPlayer" );
    }
    else if ( scripts\mp\utility\teams::function_ef7cf07ba921200e( player.team, "lastAssimedPlayer" ) )
    {
        lastassimedplayer = scripts\mp\utility\teams::getteamdata( player.team, "lastAssimedPlayer" );
    }
    
    if ( !isdefined( lastassimedplayer ) )
    {
        return true;
    }
    
    return player == lastassimedplayer;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0xc26
// Size: 0x57, Type: bool
function function_7b4d0a8fdbbf4193( player, activityinstance )
{
    instanceid = getinstanceid( activityinstance );
    var_32a6f9b3d487152d = function_553a690e1064cf0b( player );
    activityinfostruct = var_32a6f9b3d487152d[ instanceid ];
    
    if ( isdefined( activityinfostruct ) )
    {
        return istrue( activityinfostruct.var_2cbce2fd25a1eac2 );
    }
    
    return false;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0xc86
// Size: 0x57
function function_d5c655d706be5a5a( player, activityinstance )
{
    instanceid = getinstanceid( activityinstance );
    var_32a6f9b3d487152d = function_553a690e1064cf0b( player );
    activityinfostruct = var_32a6f9b3d487152d[ instanceid ];
    
    if ( isdefined( activityinfostruct ) )
    {
        activityinfostruct.var_2cbce2fd25a1eac2 = 1;
    }
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0xce5
// Size: 0x56
function function_15b9cdad6fea7395( player, activityinstance )
{
    instanceid = getinstanceid( activityinstance );
    var_32a6f9b3d487152d = function_553a690e1064cf0b( player );
    activityinfostruct = var_32a6f9b3d487152d[ instanceid ];
    
    if ( isdefined( activityinfostruct ) )
    {
        activityinfostruct.var_2cbce2fd25a1eac2 = 0;
    }
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 5
// Checksum 0x0, Offset: 0xd43
// Size: 0xac
function function_5ce919b476495152( players, activityinstance, omnvar, value, resetvalue )
{
    if ( !isdefined( value ) )
    {
        activitynexuslog( "Could not set given value for Omnvar: " + omnvar + " because it was undefined.", @"hash_22e4e38cab273e93", activityinstance, players );
        return;
    }
    
    foreach ( player in players )
    {
        player setclientomnvar( omnvar, value );
    }
    
    function_26857d3de8354d4e( activityinstance, omnvar, value, resetvalue );
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 5
// Checksum 0x0, Offset: 0xdf7
// Size: 0x69
function function_94b6d84e134ecb15( player, activityinstance, omnvar, value, resetvalue )
{
    if ( !isdefined( value ) )
    {
        activitynexuslog( "Could not set given value for Omnvar: " + omnvar + " because it was undefined.", @"hash_22e4e38cab273e93", activityinstance, [ player ] );
        return;
    }
    
    player setclientomnvar( omnvar, value );
    function_26857d3de8354d4e( activityinstance, omnvar, value, resetvalue );
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0xe68
// Size: 0x84
function function_39cdb60af8e36365( player, activityinstance )
{
    var_14a8920a25d8a7a1 = function_b1e0c431ac8df0ed( activityinstance );
    
    foreach ( var_3b070ee0304422a8 in var_14a8920a25d8a7a1 )
    {
        storedomnvarvalue = function_297dc42ebf4f3b04( activityinstance, var_3b070ee0304422a8 );
        player setclientomnvar( var_3b070ee0304422a8, storedomnvarvalue );
    }
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0xef4
// Size: 0x89
function function_4f871ff9eb56f17( player, activityinstance )
{
    var_14a8920a25d8a7a1 = function_b1e0c431ac8df0ed( activityinstance );
    
    foreach ( var_3b070ee0304422a8 in var_14a8920a25d8a7a1 )
    {
        var_40f26b8193ffeb5d = function_402e97e252bb33ff( activityinstance, var_3b070ee0304422a8 );
        
        if ( isdefined( var_40f26b8193ffeb5d ) )
        {
            player setclientomnvar( var_3b070ee0304422a8, var_40f26b8193ffeb5d );
        }
    }
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2
// Checksum 0x0, Offset: 0xf85
// Size: 0xd0, Type: bool
function function_34e215db7fc6d16a( player, params )
{
    assertex( isdefined( params ) && params.size == 1, "<dev string:x82>" );
    activityinstance = params[ 0 ];
    activityinstancecategory = getactivitycategory( activityinstance );
    var_32a6f9b3d487152d = namespace_d886885225a713a7::function_553a690e1064cf0b( player );
    
    foreach ( instanceid, var_b2941d08f576eb6c in var_32a6f9b3d487152d )
    {
        var_33571bfdb08594f7 = getactivityinstance( instanceid );
        var_4c8d9ff06133bc6b = getactivitycategory( var_33571bfdb08594f7 );
        
        if ( var_4c8d9ff06133bc6b == activityinstancecategory )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x105e
// Size: 0x44
function private function_fb0ef9f4034927f8()
{
    playeractivitydata = spawnstruct();
    playeractivitydata.var_6ff9941006fb29cd = [];
    playeractivitydata.completedactivities = [];
    playeractivitydata.focusedactivityid = undefined;
    playeractivitydata.var_45bef2a1bc42602b = undefined;
    return playeractivitydata;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x10ab
// Size: 0x35
function private function_e5594507f84bc271( params )
{
    function_1f99e5a11b5e285b( self );
    callback::add( "player_spawned", &_onplayerspawned );
    callback::add( "player_disconnect", &function_db04e6dd6940b0a5 );
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x10e8
// Size: 0xf0
function private function_f0ab0b7c533f4200( params )
{
    player = self;
    activityinstancestoend = [];
    var_9d0a2cc88b985e38 = function_553a690e1064cf0b( player );
    
    foreach ( instanceid, instanceinfostruct in var_9d0a2cc88b985e38 )
    {
        activityinstance = getactivityinstance( instanceid );
        
        if ( isdefined( activityinstance ) )
        {
            activityinstance notify( "activity_player_died", player );
            
            if ( function_b5ec1b2b98c9a315( activityinstance ) )
            {
                activityinstancestoend[ activityinstancestoend.size ] = activityinstance;
            }
        }
    }
    
    foreach ( activityinstance in activityinstancestoend )
    {
        function_1c93e1762d4bf23f( activityinstance, player, 1 );
    }
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x11e0
// Size: 0x34
function private _onplayerspawned( params )
{
    player = self;
    
    if ( function_71d38726159c3f12( 5 ) )
    {
        function_f541e4e4edaa8e99( 5, [ player ], 1 );
    }
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x121c
// Size: 0x101
function private function_db04e6dd6940b0a5( params )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        foreach ( instance in level.activities.instances )
        {
            instance.playerparticipants = array_removeundefined( instance.playerparticipants );
        }
        
        return;
    }
    
    var_32a6f9b3d487152d = function_553a690e1064cf0b( player );
    
    foreach ( instanceid, activityinfostruct in var_32a6f9b3d487152d )
    {
        activityinstance = getactivityinstance( instanceid );
        function_91c9ad377a3c4725( activityinstance, player );
    }
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1325
// Size: 0x20
function private function_b9a4c528a6fd77cf()
{
    var_3900d8bea91376b4 = function_5cc2fd3d10cbab56( self );
    return var_3900d8bea91376b4.focusedactivityid;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x134e
// Size: 0x46
function private function_1622a54acd6019d6()
{
    var_3900d8bea91376b4 = function_5cc2fd3d10cbab56( self );
    
    if ( !isdefined( var_3900d8bea91376b4.var_45bef2a1bc42602b ) )
    {
        return undefined;
    }
    
    currenttimeinseconds = gettime() / 1000;
    return currenttimeinseconds - var_3900d8bea91376b4.var_45bef2a1bc42602b;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x139d
// Size: 0x63
function private function_6fefd7e95fdfcc89( activityinstance )
{
    player = self;
    instanceid = getinstanceid( activityinstance );
    player function_69f5f64b2f31e8c3( instanceid );
    var_32a6f9b3d487152d = function_553a690e1064cf0b( player );
    focusedactivityinfostruct = var_32a6f9b3d487152d[ instanceid ];
    
    if ( isdefined( focusedactivityinfostruct ) )
    {
        focusedactivityinfostruct.var_ab4cdd1bcafb1dff = 1;
    }
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1408
// Size: 0x40
function private function_69f5f64b2f31e8c3( id )
{
    var_3900d8bea91376b4 = function_5cc2fd3d10cbab56( self );
    var_3900d8bea91376b4.focusedactivityid = id;
    var_3900d8bea91376b4.var_45bef2a1bc42602b = gettime() / 1000;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1450
// Size: 0xfb
function private function_71e9ad7d057fc10d( player )
{
    var_df6a30597937d862 = -1;
    var_37fc436c2767d2b5 = [];
    var_32a6f9b3d487152d = function_553a690e1064cf0b( player );
    
    foreach ( instanceid, activityinfostruct in var_32a6f9b3d487152d )
    {
        var_73ed98ca917d666e = getactivityinstance( instanceid );
        var_a80610c132c32138 = function_47e109e0d8027d54( player, var_73ed98ca917d666e );
        
        if ( var_a80610c132c32138 > var_df6a30597937d862 )
        {
            var_df6a30597937d862 = var_a80610c132c32138;
            var_37fc436c2767d2b5 = [ var_73ed98ca917d666e ];
            continue;
        }
        
        if ( var_a80610c132c32138 == var_df6a30597937d862 )
        {
            var_37fc436c2767d2b5[ var_37fc436c2767d2b5.size ] = var_73ed98ca917d666e;
        }
    }
    
    var_e0814ddbe2fc8bca = undefined;
    
    if ( var_37fc436c2767d2b5.size == 1 )
    {
        var_e0814ddbe2fc8bca = var_37fc436c2767d2b5[ 0 ];
    }
    else if ( var_37fc436c2767d2b5.size > 1 )
    {
        var_e0814ddbe2fc8bca = function_8ba4c11453487949( player.origin, var_37fc436c2767d2b5 );
    }
    
    return var_e0814ddbe2fc8bca;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1554
// Size: 0x105
function private function_ff52316e5fb7e838( player, activityinstance )
{
    var_2327fcafae4f8a11 = 10;
    var_80ec1eb113d8b75c = 1;
    var_21072c8308b3cf6f = 0;
    var_7f2ac638edd9ec8e = function_be6214edfe52a31( activityinstance );
    var_21072c8308b3cf6f += var_7f2ac638edd9ec8e * var_2327fcafae4f8a11;
    var_88d02cafbb45b3f2 = getinstanceid( activityinstance );
    var_32a6f9b3d487152d = function_553a690e1064cf0b( player );
    var_ae40dfab935a458e = 0;
    var_12124d18c675f4aa = var_32a6f9b3d487152d[ var_88d02cafbb45b3f2 ];
    
    if ( isdefined( var_12124d18c675f4aa ) )
    {
        playerjoinreason = var_12124d18c675f4aa.joinreason;
        
        if ( playerjoinreason == "PlayerJoinedInteract" || playerjoinreason == "PlayerJoinedOther" )
        {
            var_ae40dfab935a458e = 10;
        }
        else if ( playerjoinreason == "PlayerJoinedDamage" || playerjoinreason == "PlayerJoinedSquad" )
        {
            var_ae40dfab935a458e = 6;
        }
        else if ( playerjoinreason == "PlayerJoinedProximity" )
        {
            var_ae40dfab935a458e = 4;
        }
        else
        {
            var_ae40dfab935a458e = 5;
        }
    }
    
    var_21072c8308b3cf6f += var_ae40dfab935a458e * var_80ec1eb113d8b75c;
    return var_21072c8308b3cf6f;
}

// Namespace namespace_553c3c813ee2de54 / namespace_cde84ab88f41f1a5
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1662
// Size: 0x35
function private function_512997cf3f5c2f8a( player )
{
    var_84136076a28f85b4 = self;
    
    if ( function_93587d5ba6247f36( var_84136076a28f85b4.var_186eafd5a207b951, player ) )
    {
        function_d10ee44b55e7d8d4( player );
    }
}

