#using scripts\engine\trace;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_killstreaks;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\hud_message;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\spawn_event_aggregator;

#namespace br_alt_mode_inflation;

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 0
// Checksum 0x0, Offset: 0x31b
// Size: 0x1bc
function init()
{
    if ( !getdvarint( @"scr_br_alt_mode_inflation", 0 ) )
    {
        return;
    }
    
    level.br_alt_mode_inflation = spawnstruct();
    level.br_alt_mode_inflation.disabled = 0;
    level.br_alt_mode_inflation.cost = getdvarint( @"hash_ec3657bee62b649e", 450 );
    level.br_alt_mode_inflation.drop_percent = getdvarfloat( @"scr_br_alt_mode_inflation_drop_percent", 0.5 );
    level.br_alt_mode_inflation.drop_max = getdvarint( @"scr_br_alt_mode_inflation_drop_max", -1 );
    level.br_alt_mode_inflation.end_circle = getdvarint( @"hash_eebc33bdcbc28415", 5 );
    level.br_alt_mode_inflation.respawn_delay = getdvarfloat( @"hash_82a04f5b65ed7d09", 10 );
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc( "onPrematchDone", &function_57b3ca6a58c2c42b );
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc( "playerDropPlunderOnDeath", &playerdropplunderondeath );
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc( "circleTimer", &circletimer );
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc( "postPlunder", &postplunder );
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc( "markPlayerAsEliminatedOnKilled", &markplayeraseliminatedonkilled );
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc( "playerGulagAutoWinWait", &playergulagautowinwait );
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc( "triggerRespawnOverlay", &triggerrespawnoverlay );
    
    if ( !getdvarint( @"hash_83fc1574c6a65efd", 0 ) )
    {
        scripts\mp\gametypes\br_gametypes::disablefeature( "gulag" );
    }
    
    scripts\mp\gametypes\br_gametypes::disablefeature( "useTokenToReviveTeammate" );
    initdialog();
    thread initcallbacks();
    level.var_e6ed580a1409cf0e = &spectatorrespawntimer;
    
    /#
        thread function_fbfcdb4534b7b0d8();
    #/
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 0
// Checksum 0x0, Offset: 0x4df
// Size: 0x6a
function initdialog()
{
    level.brgametype.var_98ade9e8627af484 = 1;
    level.brgametype.dialogprefix = "dx_br_urzi_";
    game[ "dialog" ][ "match_start" ] = "urzk_grav_bybk";
    game[ "dialog" ][ "offense_obj" ] = "urzk_grav_byde";
    game[ "dialog" ][ "cash_deployment_ended" ] = "urzk_grav_cacd";
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 0
// Checksum 0x0, Offset: 0x551
// Size: 0x1f
function initcallbacks()
{
    while ( !isdefined( level.onplayerspawncallbacks ) )
    {
        waitframe();
    }
    
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 0
// Checksum 0x0, Offset: 0x578
// Size: 0x9
function onplayerspawned()
{
    updaterespawnstatus();
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 0
// Checksum 0x0, Offset: 0x589
// Size: 0x52, Type: bool
function playercanbuyrespawn()
{
    return istrue( level.br_prematchstarted ) && !istrue( self.br_iseliminated ) && !level.br_alt_mode_inflation.disabled && self.plundercount >= level.br_alt_mode_inflation.cost;
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 2
// Checksum 0x0, Offset: 0x5e4
// Size: 0xe5
function playerdropplunderondeath( dropstruct, attacker )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_43e1b640eec49671 = self.plundercount;
    
    if ( istrue( self.respawningfromtoken ) )
    {
        var_43e1b640eec49671 -= level.br_alt_mode_inflation.cost;
        
        if ( var_43e1b640eec49671 < 0 )
        {
            var_43e1b640eec49671 = 0;
        }
    }
    
    if ( !isdefined( var_43e1b640eec49671 ) || var_43e1b640eec49671 < 0 )
    {
        var_43e1b640eec49671 = 0;
    }
    
    var_b64f283113c99581 = int( var_43e1b640eec49671 * level.br_alt_mode_inflation.drop_percent );
    var_43e1b640eec49671 -= var_b64f283113c99581;
    scripts\mp\gametypes\br_plunder::playersetplundercount( var_43e1b640eec49671, getsetplundercountdatanosplash() );
    
    if ( level.br_alt_mode_inflation.drop_max >= 0 )
    {
        var_b64f283113c99581 = int( min( level.br_alt_mode_inflation.drop_max, var_b64f283113c99581 ) );
    }
    
    scripts\mp\gametypes\br_plunder::dropcondensedplunder( var_b64f283113c99581, dropstruct );
    return 1;
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 0
// Checksum 0x0, Offset: 0x6d2
// Size: 0x1c
function function_57b3ca6a58c2c42b()
{
    scripts\mp\gametypes\br_gulag::setupgulagtimer( level.br_alt_mode_inflation.end_circle );
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 1
// Checksum 0x0, Offset: 0x6f6
// Size: 0xf6, Type: bool
function circletimer( circleindex )
{
    endcircle = level.br_alt_mode_inflation.end_circle;
    
    if ( level.br_alt_mode_inflation.disabled || circleindex < endcircle )
    {
        return false;
    }
    
    level.br_alt_mode_inflation.disabled = 1;
    setomnvar( "ui_gulag_timer", 0 );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) || !isalive( player ) )
        {
            continue;
        }
        
        player updaterespawnstatus();
        scripts\mp\gametypes\br_killstreaks::dangernotifyplayer( player, "cash_deploy_closed", 3 );
        scripts\mp\gametypes\br_public::brleaderdialogplayer( "cash_deployment_ended", player, undefined, undefined, undefined, undefined, "dx_br_urzi_" );
    }
    
    return false;
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 1
// Checksum 0x0, Offset: 0x7f5
// Size: 0x32
function postplunder( data )
{
    skipsplash = 0;
    
    if ( isdefined( data ) )
    {
        skipsplash = data.skipsplash;
    }
    
    updaterespawnstatus( skipsplash );
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 1
// Checksum 0x0, Offset: 0x82f
// Size: 0x5d
function updaterespawnstatus( skipsplash )
{
    if ( playercanbuyrespawn() )
    {
        if ( !scripts\mp\gametypes\br_public::hasrespawntoken() )
        {
            scripts\mp\gametypes\br_pickups::addrespawntoken( 1 );
            
            if ( !istrue( skipsplash ) )
            {
                thread scripts\mp\hud_message::showsplash( "br_inflation_respawn_token_pickup" );
            }
        }
        
        return;
    }
    
    if ( scripts\mp\gametypes\br_public::hasrespawntoken() )
    {
        scripts\mp\gametypes\br_pickups::removerespawntoken();
        
        if ( !istrue( skipsplash ) )
        {
            thread scripts\mp\hud_message::showsplash( "br_inflation_respawn_token_lost" );
        }
    }
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 1
// Checksum 0x0, Offset: 0x894
// Size: 0x39
function showrespawntimer( timer )
{
    waittillframeend();
    scripts\mp\utility\lower_message::setlowermessageomnvar( "waiting_to_spawn", int( gettime() + timer * 1000 ) );
    scripts\mp\gametypes\br_gulag::setplayeringulagjailextrainfo( 1 );
    hiderespawntimer( timer );
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 1
// Checksum 0x0, Offset: 0x8d5
// Size: 0x35
function hiderespawntimer( waittime )
{
    self endon( "disconnect" );
    
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    self notify( "inflation_hide_timer" );
    scripts\mp\gametypes\br_gulag::setplayeringulagjailextrainfo( 0 );
    scripts\mp\utility\lower_message::setlowermessageomnvar( "clear_lower_msg" );
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 0
// Checksum 0x0, Offset: 0x912
// Size: 0x22
function getsetplundercountdatanosplash()
{
    data = spawnstruct();
    data.skipsplash = 1;
    return data;
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 0
// Checksum 0x0, Offset: 0x93d
// Size: 0x3, Type: bool
function markplayeraseliminatedonkilled()
{
    return false;
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 1
// Checksum 0x0, Offset: 0x949
// Size: 0x67
function spectatorrespawntimer( victim )
{
    self notify( "spectatorRespawnTimer" );
    self endon( "spectatorRespawnTimer" );
    self endon( "disconnect" );
    
    if ( level.br_alt_mode_inflation.respawn_delay )
    {
        respawndelay = level.br_alt_mode_inflation.respawn_delay;
        thread function_c178be44974d74ea( victim );
        showrespawntimer( respawndelay );
    }
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 1
// Checksum 0x0, Offset: 0x9b8
// Size: 0x37
function function_c178be44974d74ea( victim )
{
    self endon( "spectatorRespawnTimer" );
    self endon( "disconnect" );
    victim endon( "spawned_player" );
    self endon( "inflation_hide_timer" );
    victim waittill( "disconnect" );
    thread hiderespawntimer();
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 2
// Checksum 0x0, Offset: 0x9f7
// Size: 0x5c, Type: bool
function playergulagautowinwait( sponsor, tokenused )
{
    if ( !isdefined( sponsor ) )
    {
        if ( level.br_alt_mode_inflation.respawn_delay )
        {
            respawndelay = level.br_alt_mode_inflation.respawn_delay;
            thread showrespawntimer( respawndelay );
            wait respawndelay;
            return true;
        }
    }
    
    return false;
}

// Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
// Params 1
// Checksum 0x0, Offset: 0xa5c
// Size: 0xd, Type: bool
function triggerrespawnoverlay( overlaytype )
{
    return true;
}

/#

    // Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
    // Params 0
    // Checksum 0x0, Offset: 0xa72
    // Size: 0x96, Type: dev
    function function_fbfcdb4534b7b0d8()
    {
        scripts\mp\gametypes\br_dev::registerhandlecommand( &function_94d8f65b7519f9fe );
        debughud = "<dev string:x1c>";
        thread scripts\mp\gametypes\br_quest_util::adddebugcommanddelayed( debughud + "<dev string:x46>" );
        thread scripts\mp\gametypes\br_quest_util::adddebugcommanddelayed( debughud + "<dev string:x83>" );
        
        for ( i = 0; i < 5 ; i++ )
        {
            thread scripts\mp\gametypes\br_quest_util::adddebugcommanddelayed( debughud + "<dev string:xc6>" + i + "<dev string:xd6>" + i + "<dev string:xfa>" );
            thread scripts\mp\gametypes\br_quest_util::adddebugcommanddelayed( debughud + "<dev string:x100>" + i + "<dev string:x113>" + i + "<dev string:xfa>" );
        }
    }

    // Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
    // Params 1
    // Checksum 0x0, Offset: 0xb10
    // Size: 0x168, Type: dev
    function function_cd5dfc5762199c46( args )
    {
        target = undefined;
        
        if ( args[ 0 ] == "<dev string:x13a>" )
        {
            looker = undefined;
            
            foreach ( player in level.players )
            {
                if ( player isplayerheadless() )
                {
                    continue;
                }
                
                if ( isbot( player ) )
                {
                    continue;
                }
                
                looker = player;
                break;
            }
            
            if ( !isdefined( looker ) )
            {
                return;
            }
            
            tracestart = looker geteye();
            traceend = tracestart + anglestoforward( looker getplayerangles() ) * 100000;
            tracecontents = scripts\engine\trace::create_character_contents();
            trace = scripts\engine\trace::ray_trace( tracestart, traceend, looker, tracecontents );
            target = trace[ "<dev string:x145>" ];
            color = ( 1, 0, 0 );
            
            if ( isdefined( target ) )
            {
                color = ( 0, 1, 0 );
            }
            
            sphere( trace[ "<dev string:x14f>" ], 10, color, 0, 20 );
        }
        else
        {
            entnum = int( args[ 0 ] );
            target = level.players[ entnum ];
        }
        
        return target;
    }

    // Namespace br_alt_mode_inflation / scripts\mp\gametypes\br_alt_mode_inflation
    // Params 2
    // Checksum 0x0, Offset: 0xc80
    // Size: 0x83, Type: dev
    function function_94d8f65b7519f9fe( command, args )
    {
        switch ( command )
        {
            case #"hash_158e32183cf66266":
                target = function_cd5dfc5762199c46( args );
                
                if ( isdefined( target ) )
                {
                    target kill();
                }
                
                break;
            case #"hash_4bb95b0621e981e8":
                target = function_cd5dfc5762199c46( args );
                
                if ( isdefined( target ) )
                {
                    target scripts\mp\gametypes\br_plunder::playerplunderpickup( 100 );
                }
                
                break;
            default:
                break;
        }
    }

#/
