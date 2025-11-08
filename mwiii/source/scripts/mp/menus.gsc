#using scripts\common\progression_utility;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\bounty;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\hud_message;
#using scripts\mp\playerlogic;
#using scripts\mp\spectating;
#using scripts\mp\teams;
#using scripts\mp\utility\game;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;

#namespace menus;

// Namespace menus / scripts\mp\menus
// Params 0
// Checksum 0x0, Offset: 0x83b
// Size: 0x283
function init()
{
    if ( !isdefined( game[ "gamestarted" ] ) )
    {
        game[ "menu_team" ] = "team_marinesopfor";
        
        if ( level.multiteambased )
        {
            game[ "menu_team" ] = "team_mt_options";
        }
        
        game[ "menu_class" ] = "class";
        game[ "menu_class_allies" ] = "class_marines";
        game[ "menu_class_axis" ] = "class_opfor";
        game[ "menu_changeclass_allies" ] = "changeclass_marines";
        game[ "menu_changeclass_axis" ] = "changeclass_opfor";
        
        if ( level.multiteambased )
        {
            for ( i = 0; i < level.teamnamelist.size ; i++ )
            {
                var_62890c80c835c4a5 = "menu_class_" + level.teamnamelist[ i ];
                var_90e671d45a71be99 = "menu_changeclass_" + level.teamnamelist[ i ];
                game[ var_62890c80c835c4a5 ] = game[ "menu_class_allies" ];
                game[ var_90e671d45a71be99 ] = "changeclass_marines";
            }
        }
        
        game[ "menu_changeclass" ] = "changeclass";
        game[ "menu_controls" ] = "ingame_controls";
        
        if ( level.splitscreen )
        {
            if ( level.multiteambased )
            {
                for ( i = 0; i < level.teamnamelist.size ; i++ )
                {
                    var_62890c80c835c4a5 = "menu_class_" + level.teamnamelist[ i ];
                    var_90e671d45a71be99 = "menu_changeclass_" + level.teamnamelist[ i ];
                    game[ var_62890c80c835c4a5 ] += "_splitscreen";
                    game[ var_90e671d45a71be99 ] += "_splitscreen";
                }
            }
            
            game[ "menu_team" ] = game[ "menu_team" ] + "_splitscreen";
            game[ "menu_class_allies" ] = game[ "menu_class_allies" ] + "_splitscreen";
            game[ "menu_class_axis" ] = game[ "menu_class_axis" ] + "_splitscreen";
            game[ "menu_changeclass_allies" ] = game[ "menu_changeclass_allies" ] + "_splitscreen";
            game[ "menu_changeclass_axis" ] = game[ "menu_changeclass_axis" ] + "_splitscreen";
            game[ "menu_controls" ] = game[ "menu_controls" ] + "_splitscreen";
            game[ "menu_changeclass_defaults_splitscreen" ] = "changeclass_splitscreen_defaults";
            game[ "menu_changeclass_custom_splitscreen" ] = "changeclass_splitscreen_custom";
        }
        
        precachestring( &"MP/HOST_ENDED_GAME" );
        precachestring( &"MP/HOST_ENDGAME_RESPONSE" );
    }
    
    level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &onleavegamecallback );
    level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &onteamchangecallback );
    level scripts\common\ui::lui_registercallback( "class_edit", &onclasseditcallback );
    level scripts\common\ui::lui_registercallback( "class_select", &onclasschoicecallback );
    level.var_ce4945d1893fbaca = getdvarint( @"hash_6cb6994f3a89112c", 0 );
    level thread setintrocamnetworkmodel();
}

// Namespace menus / scripts\mp\menus
// Params 2
// Checksum 0x0, Offset: 0xac6
// Size: 0x67
function onteamchangecallback( channel, teamselected )
{
    if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        println( "<dev string:x1c>" + self getentitynumber() + "<dev string:x28>" + self.name + "<dev string:x36>" + channel );
        
        if ( channel != "team_select" )
        {
            return;
        }
        
        if ( matchmakinggame() )
        {
            return;
        }
        
        handleteamchange( channel, teamselected );
    }
}

// Namespace menus / scripts\mp\menus
// Params 0
// Checksum 0x0, Offset: 0xb35
// Size: 0x19
function setintrocamnetworkmodel()
{
    setintrocameraactive( 1 );
    level waittill( "prematch_over" );
    setintrocameraactive( 0 );
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0xb56
// Size: 0xf, Type: bool
function isloadoutindexdefault( index )
{
    return index >= 100;
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0xb6e
// Size: 0x5a
function getclasschoice( menuindex )
{
    menuindex++;
    newclasschoice = undefined;
    
    if ( menuindex > 100 )
    {
        classindex = menuindex - 100;
        newclasschoice = "default" + classindex;
    }
    else if ( function_788bcfab4101649a( self ) )
    {
        newclasschoice = "custom" + menuindex;
    }
    else
    {
        newclasschoice = "default1";
    }
    
    return newclasschoice;
}

// Namespace menus / scripts\mp\menus
// Params 2
// Checksum 0x0, Offset: 0xbd1
// Size: 0x175
function executeclasschange( newclass, var_fda7f7e8fc307aba )
{
    if ( isbot( self ) || istestclient( self ) )
    {
        self.pers[ "class" ] = newclass;
        self.class = newclass;
        return;
    }
    
    newclasschoice = getclasschoice( newclass );
    
    if ( !isdefined( self.pers[ "class" ] ) || newclasschoice != self.pers[ "class" ] || var_fda7f7e8fc307aba )
    {
        self.pers[ "class" ] = newclasschoice;
        self.class = newclasschoice;
        scripts\mp\class::preloadandqueueclass( newclasschoice );
    }
    
    var_cd83a28652a3f837 = 1;
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() && !scripts\mp\gamelogic::function_20fcd7762daec487() )
    {
        var_cd83a28652a3f837 = 0;
    }
    
    error = spawnstruct();
    
    if ( scripts\mp\class::shouldallowinstantclassswap( error ) && var_cd83a28652a3f837 )
    {
        thread scripts\mp\class::swaploadout();
        return;
    }
    
    var_5e6a291a22a0d249 = scripts\cp_mp\utility\game_utility::isbrstylegametype() && self getclientomnvar( "ui_open_loadout_bag" );
    
    if ( isalive( self ) && !var_5e6a291a22a0d249 && isdefined( error.string ) )
    {
        scripts\mp\hud_message::showerrormessage( error.string, error.param );
    }
    
    if ( newclass < 100 )
    {
        self setclientomnvar( "ui_loadout_changed", scripts\mp\class::getclassindex( self.pers[ "class" ] ) );
    }
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0xd4e
// Size: 0x58
function setnextroundclass( newclass )
{
    newclasschoice = newclass;
    
    if ( !isbot( self ) )
    {
        if ( isalive( self ) )
        {
            self iprintlnbold( game[ "strings" ][ "revive_class" ] );
        }
        
        newclasschoice = getclasschoice( newclass );
    }
    
    self.pers[ "next_round_class" ] = newclasschoice;
}

// Namespace menus / scripts\mp\menus
// Params 2
// Checksum 0x0, Offset: 0xdae
// Size: 0x64
function onleavegamecallback( channel, val )
{
    if ( channel != "end_game" )
    {
        return;
    }
    
    if ( matchmakinggame() )
    {
        return;
    }
    
    if ( isdedicatedserver() && !isprivatedsmatchhost( self ) )
    {
        return;
    }
    
    if ( isdefined( level.var_30c7107330cebcce ) )
    {
        level thread [[ level.var_30c7107330cebcce ]]( val );
        return;
    }
    
    level thread scripts\mp\gamelogic::forceend( val );
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0xe1a
// Size: 0x38
function onclasseditcallback( newclass )
{
    self endon( "disconnect" );
    waittillframeend();
    handleclassedit( newclass );
    
    if ( getgametype() == "br" )
    {
        scripts\mp\gametypes\br::function_4043e420432f59f0( getclasschoice( newclass ) );
    }
}

// Namespace menus / scripts\mp\menus
// Params 2
// Checksum 0x0, Offset: 0xe5a
// Size: 0x153
function onclasschoicecallback( newclass, var_f01f8e178ff54eda )
{
    self notify( "loadout_class_selected", newclass );
    
    if ( level.systemlink && getdvarint( @"xblive_competitionmatch" ) && self iscodcaster() )
    {
        self setclientomnvar( "ui_options_menu", 0 );
        return;
    }
    
    if ( istrue( self.waitingtoselectclass ) )
    {
        if ( isdefined( self.revive_chosenclass ) )
        {
            setnextroundclass( newclass );
        }
        
        if ( istrue( level.var_ce4945d1893fbaca ) )
        {
            self.waitingtoselectclass = 0;
            self setclientomnvar( "ui_options_menu", 4 );
            self.var_48366f4aaeafcf5d = 1;
            return;
        }
        
        self setclientomnvar( "ui_options_menu", 0 );
        return;
    }
    
    self setclientomnvar( "ui_options_menu", 0 );
    
    if ( !allowclasschoice() || showfakeloadout() )
    {
        return;
    }
    
    if ( isdefined( self.revive_chosenclass ) && isdefined( self.instantclassswapallowed ) && !scripts\mp\class::shouldallowinstantclassswap() )
    {
        setnextroundclass( newclass );
        return;
    }
    
    if ( "" + newclass != "callback" )
    {
        executeclasschange( newclass, istrue( var_f01f8e178ff54eda ) );
        
        if ( istrue( self.var_48366f4aaeafcf5d ) )
        {
            self setclientomnvar( "ui_options_menu", 0 );
            self.var_48366f4aaeafcf5d = 0;
            return;
        }
        
        return;
    }
    
    menuclass( "callback" );
}

// Namespace menus / scripts\mp\menus
// Params 2
// Checksum 0x0, Offset: 0xfb5
// Size: 0x247
function handleteamchange( channel, teamselected )
{
    var_80b8e166e8e16ba6 = 0;
    
    if ( teamselected >= 3 )
    {
        var_80b8e166e8e16ba6 = 1;
    }
    
    if ( var_80b8e166e8e16ba6 )
    {
        self setclientomnvar( "ui_spectator_selected", 1 );
        self.spectating_actively = 1;
    }
    else
    {
        self setclientomnvar( "ui_spectator_selected", -1 );
        self.spectating_actively = 0;
    }
    
    var_fff3522de2da93f8 = self iscodcaster();
    wasspectator = !var_fff3522de2da93f8 && isdefined( self.team ) && ( self.team == "spectator" || self.team == "codcaster" );
    needrespawn = var_fff3522de2da93f8 && teamselected == 3 || wasspectator && ( teamselected == 4 || teamselected == 5 );
    
    if ( teamselected == 4 || teamselected == 5 )
    {
        teamselected = 3;
        self setcodcaster( 1 );
    }
    else
    {
        self setcodcaster( 0 );
    }
    
    if ( teamselected == 0 )
    {
        teamselected = "axis";
    }
    else if ( teamselected == 1 )
    {
        teamselected = "allies";
    }
    else if ( teamselected == 2 )
    {
        teamselected = "random";
    }
    else if ( teamselected == 4 )
    {
        teamselected = "codcaster";
    }
    else
    {
        teamselected = "spectator";
    }
    
    if ( !needrespawn && isdefined( self.pers[ "team" ] ) && teamselected == self.pers[ "team" ] )
    {
        return;
    }
    
    if ( isdefined( self.operatorcustomization ) )
    {
        self.operatorcustomization.rebuild = 1;
    }
    
    thread logteamselection( teamselected );
    
    if ( teamselected != "spectator" )
    {
        self.pers[ "playerChoseSpectatorTeam" ] = undefined;
    }
    else
    {
        self.pers[ "playerChoseSpectatorTeam" ] = 1;
    }
    
    if ( teamselected == "axis" )
    {
        thread setteam( "axis" );
        return;
    }
    
    if ( teamselected == "allies" )
    {
        thread setteam( "allies" );
        return;
    }
    
    if ( teamselected == "random" )
    {
        thread autoassign();
        return;
    }
    
    if ( teamselected == "codcaster" )
    {
        thread function_9ff5c7531349cdfc( needrespawn );
        return;
    }
    
    if ( teamselected == "spectator" )
    {
        thread setspectator( needrespawn );
    }
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0x1204
// Size: 0x86
function handleclassedit( newclass )
{
    classname = getclasschoice( newclass );
    var_a022fbcafc053c4a = scripts\mp\class::loadout_editcachedclassstruct( classname );
    var_5410628ddd8dfd8a = scripts\mp\class::loadout_editglobalclassstruct();
    anydifference = var_a022fbcafc053c4a || var_5410628ddd8dfd8a;
    
    if ( isdefined( self.pers[ "class" ] ) && classname == self.pers[ "class" ] && anydifference )
    {
        onclasschoicecallback( newclass, 1 );
    }
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0x1292
// Size: 0x10e, Type: bool
function function_c69c22ef9e1e92a0( var_f0c136ca13f8bc76 )
{
    for ( teamindex = level.teamnamelist.size - 1; teamindex >= 0 ; teamindex-- )
    {
        candidate = level.teamnamelist[ teamindex ];
        teamplayers = getteamdata( candidate, "players" );
        hashuman = 0;
        
        foreach ( player in teamplayers )
        {
            if ( !isbot( player ) )
            {
                hashuman = 1;
                break;
            }
        }
        
        count = teamplayers.size;
        
        if ( var_f0c136ca13f8bc76 )
        {
            count += getteamdata( candidate, "UnlockedUIBotCount" );
        }
        
        if ( !hashuman && ( level.maxteamsize == 0 || count < level.maxteamsize ) )
        {
            thread setteam( candidate );
            return true;
        }
    }
    
    return false;
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0x13a9
// Size: 0x3c6
function autoassign( firstconnect )
{
    if ( scripts\cp_mp\utility\game_utility::isinfectedgametype() )
    {
        thread setteam( "allies" );
        return;
    }
    
    forceteam = getdvar( @"scr_force_team", "" );
    
    if ( isgameplayteam( forceteam ) )
    {
        setsessionteam( forceteam );
        thread setteam( forceteam, firstconnect );
        return;
    }
    
    if ( getdvarint( @"hash_3f36284b49b3d7a", 0 ) != 0 )
    {
        thread setteam( "allies" );
        return;
    }
    
    var_f0c136ca13f8bc76 = level.maxteamsize > 0 && isdefined( level.var_7b37b2193f163b9b );
    
    if ( isbot( self ) && isdefined( self.bot_team ) && self.bot_team != "autoassign" )
    {
        thread setteam( self.bot_team );
        
        if ( var_f0c136ca13f8bc76 )
        {
            function_e9a6fdc468a5fa73( self.bot_team );
        }
        
        return;
    }
    
    if ( self iscodcaster() )
    {
        thread function_9ff5c7531349cdfc();
        return;
    }
    
    if ( self.sessionteam == "spectator" )
    {
        thread setspectator();
        return;
    }
    
    if ( istrue( level.teammaxfill ) )
    {
        println( "<dev string:x47>" );
        var_cf36f495aef1cf75 = isbot( self ) && getdvarint( @"hash_d356a7876f773136", 0 ) != 0;
        
        if ( var_cf36f495aef1cf75 && function_c69c22ef9e1e92a0( var_f0c136ca13f8bc76 ) )
        {
            return;
        }
        
        for ( teamindex = 0; teamindex < level.teamnamelist.size ; teamindex++ )
        {
            entry = level.teamnamelist[ teamindex ];
            
            if ( var_f0c136ca13f8bc76 )
            {
                function_e9a6fdc468a5fa73( entry );
            }
            
            count = getteamdata( entry, "teamCount" );
            
            if ( var_f0c136ca13f8bc76 )
            {
                count += getteamdata( entry, "UnlockedUIBotCount" );
            }
            
            if ( level.maxteamsize == 0 || count < level.maxteamsize )
            {
                thread setteam( entry );
                break;
            }
        }
        
        /#
            if ( !isdefined( self.team ) )
            {
                assertmsg( "<dev string:x6f>" );
                kick( self getentitynumber() );
            }
        #/
        
        return;
    }
    
    lowestcount = 0;
    lowestteams = [];
    
    foreach ( entry in level.teamnamelist )
    {
        count = getteamdata( entry, "teamCount" );
        
        if ( isdefined( self.team ) && self.team == entry )
        {
            count--;
        }
        
        if ( !lowestteams.size || count < lowestcount )
        {
            lowestcount = count;
            lowestteams = [];
            lowestteams[ lowestteams.size ] = entry;
            continue;
        }
        
        if ( count == lowestcount )
        {
            lowestteams[ lowestteams.size ] = entry;
        }
    }
    
    if ( lowestteams.size == 1 )
    {
        if ( !isdefined( self.team ) || self.team != lowestteams[ 0 ] )
        {
            thread setteam( lowestteams[ 0 ] );
        }
        
        return;
    }
    
    if ( level.teambased )
    {
        bestteam = scripts\mp\gamescore::gethighestscoringteam();
        
        if ( array_contains( lowestteams, bestteam ) )
        {
            lowestteams = array_remove( lowestteams, bestteam );
        }
    }
    
    if ( isdefined( self.team ) && array_contains( lowestteams, self.team ) )
    {
        lowestteams = array_remove( lowestteams, self.team );
    }
    
    if ( lowestteams.size > 0 )
    {
        randidx = randomint( lowestteams.size );
        
        if ( istrue( level.autoassignlowteamconsistent ) )
        {
            randidx = 0;
        }
        
        thread setteam( lowestteams[ randidx ] );
    }
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0x1777
// Size: 0x79
function function_e9a6fdc468a5fa73( team )
{
    var_3232b53ef5690097 = getteamdata( team, "teamCount" );
    var_2b68f240fb19593d = getteamdata( team, "UnlockedUIBotCount" );
    
    if ( var_3232b53ef5690097 + var_2b68f240fb19593d > level.maxteamsize )
    {
        assertmsg( "<dev string:xd4>" + level.maxteamsize + "<dev string:x11a>" + team + "<dev string:x124>" + var_3232b53ef5690097 + "<dev string:x136>" + var_2b68f240fb19593d );
    }
}

// Namespace menus / scripts\mp\menus
// Params 2
// Checksum 0x0, Offset: 0x17f8
// Size: 0x365
function setteam( selection, firstconnect )
{
    self endon( "disconnect" );
    
    if ( !isai( self ) && level.teambased && !scripts\mp\teams::getjointeampermissions( selection ) && !lobbyteamselectenabled() )
    {
        return;
    }
    
    if ( level.ingraceperiod && !istrue( self.hasdonecombat ) )
    {
        self.hasspawned = 0;
        self.pers[ "lives" ] = getgametypenumlives();
    }
    
    if ( self.sessionstate == "playing" )
    {
        self.switching_teams = 1;
        self.joining_team = selection;
        self.leaving_team = self.pers[ "team" ];
        
        if ( getgametype() == "arena" )
        {
            self.switching_teams_arena = 1;
        }
    }
    else if ( istrue( firstconnect ) && isdefined( level.var_d37d95ac1717903c ) )
    {
        selection = self [[ level.var_d37d95ac1717903c ]]();
    }
    
    if ( istrue( game[ "isLaunchChunk" ] ) && isbot( self ) == 0 )
    {
        selection = "allies";
    }
    
    addtoteam( selection );
    thread scripts\cp_mp\squads::setsquad( selection );
    
    if ( isragdollzerog() )
    {
        self lockdeathcamera( 1 );
    }
    
    if ( self.sessionstate == "playing" )
    {
        self suicide();
        updatesessionstate( "spectator" );
        self.suicideswitched = 1;
    }
    
    if ( allowclasschoice() || showfakeloadout() && !isai( self ) )
    {
        if ( getdvarint( @"hash_206a763969420ce0", 0 ) == 1 && scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "dmz" && getsubgametype() != "exgm" && getsubgametype() != "plunder" && getsubgametype() != "risk" && getsubgametype() != "sandbox" && getsubgametype() != "rumble_mgl" )
        {
            classchoicefunc = isdefined( level.allowclasschoicefunc ) && istrue( self [[ level.allowclasschoicefunc ]]() );
            scripts\mp\utility\script::demoforcesre( "setTeam() " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + classchoicefunc );
        }
        
        if ( !istrue( self.var_5354295b99468cef ) && !istrue( self.var_10844ddcb34694ee ) && getdvarint( @"hash_89556297eaab6b6a", 0 ) == 0 )
        {
            self setclientomnvar( "ui_options_menu", 2 );
        }
    }
    
    if ( isdefined( level.onplayerconnectstream ) )
    {
        self thread [[ level.onplayerconnectstream ]]();
    }
    
    if ( !istrue( self.var_5354295b99468cef ) )
    {
        waitforclassselect();
    }
    
    endrespawnnotify();
    
    if ( ( self.sessionstate == "spectator" || playerisstreaming() ) && !istrue( self.suicideswitched ) )
    {
        if ( game[ "state" ] == "postgame" )
        {
            return;
        }
        
        if ( game[ "state" ] == "playing" && !isinkillcam() )
        {
            if ( isdefined( self.waitingtospawnamortize ) && self.waitingtospawnamortize )
            {
                return;
            }
            
            thread scripts\mp\playerlogic::spawnclient();
        }
        
        thread scripts\mp\spectating::setspectatepermissions();
    }
    
    self.suicideswitched = undefined;
    self notify( "okToSpawn" );
}

// Namespace menus / scripts\mp\menus
// Params 0
// Checksum 0x0, Offset: 0x1b65
// Size: 0x1c, Type: bool
function playerisstreaming()
{
    return isdefined( level.playerisstreaming ) && self [[ level.playerisstreaming ]]();
}

// Namespace menus / scripts\mp\menus
// Params 0
// Checksum 0x0, Offset: 0x1b8a
// Size: 0x13, Type: bool
function squadAsTeamEnabled()
{
    return getdvarint( @"hash_61be9f6a05f64523", 0 ) != 0;
}

// Namespace menus / scripts\mp\menus
// Params 0
// Checksum 0x0, Offset: 0x1ba6
// Size: 0x13, Type: bool
function function_2c0eb018b319f66()
{
    return getdvarint( @"hash_a9194b992d1058d6", 0 ) != 0;
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0x1bc2
// Size: 0xe5
function setspectator( needrespawn )
{
    if ( ( !isdefined( needrespawn ) || !needrespawn ) && isdefined( self.pers[ "team" ] ) && self.pers[ "team" ] == "spectator" )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        assert( isdefined( self.pers[ "<dev string:x191>" ] ) );
        self.switching_teams = 1;
        self.joining_team = "spectator";
        self.leaving_team = self.pers[ "team" ];
        
        if ( self.sessionstate == "playing" )
        {
            self suicide();
        }
    }
    
    self notify( "becameSpectator" );
    addtoteam( "spectator" );
    self.pers[ "class" ] = undefined;
    self.class = undefined;
    thread scripts\mp\playerlogic::spawnspectator();
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0x1caf
// Size: 0xd3
function function_9ff5c7531349cdfc( needrespawn )
{
    if ( ( !isdefined( needrespawn ) || !needrespawn ) && isdefined( self.pers[ "team" ] ) && self.pers[ "team" ] == "codcaster" )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        assert( isdefined( self.pers[ "<dev string:x191>" ] ) );
        self.switching_teams = 1;
        self.joining_team = "codcaster";
        self.leaving_team = self.pers[ "team" ];
        self suicide();
    }
    
    self notify( "becameSpectator" );
    addtoteam( "codcaster" );
    self.pers[ "class" ] = undefined;
    self.class = undefined;
    thread scripts\mp\playerlogic::spawnspectator();
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0x1d8a
// Size: 0x94, Type: bool
function function_788bcfab4101649a( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_6fbfdde9fc5d2964", 0 ) != 0 )
    {
        return true;
    }
    
    /#
        if ( getdvarint( @"hash_955ca650f9a9bdef" ) != 0 )
        {
            return true;
        }
    #/
    
    if ( scripts\mp\utility\game::privatematch() )
    {
        return true;
    }
    
    if ( istrue( level.systemlink ) )
    {
        return true;
    }
    
    if ( istrue( level.leagueplaymatch ) && getdvarint( @"hash_48d877b577f2565b", 1 ) != 0 )
    {
        return true;
    }
    
    if ( getrank() >= 4 )
    {
        return true;
    }
    
    return false;
}

// Namespace menus / scripts\mp\menus
// Params 0
// Checksum 0x0, Offset: 0x1e27
// Size: 0x3cc
function waitforclassselect()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self.waitingtoselectclass = 1;
    
    if ( gameflag( "prematch_done" ) && istrue( level.usespawnselection ) && !istrue( self.hasspawned ) )
    {
        self setclientomnvar( "ui_world_fade", 1 );
        self setclientomnvar( "ui_hide_objectives", 1 );
        self setclientomnvar( "ui_in_spawn_camera", 1 );
    }
    
    for ( ;; )
    {
        var_40645c66e8a85816 = scripts\cp_mp\utility\game_utility::isbrstylegametype() && allowclasschoice() && ( !gameflag( "prematch_done" ) || istrue( level.skipprematch ) );
        var_7e61909352db412d = teamhasinfil( self.team ) && !gameflag( "infil_started" ) && !isdefined( level.bypassclasschoicefunc );
        var_9cfda0afbbf50688 = islifelimited() && !isdefined( level.bypassclasschoicefunc ) && isgameplayteam( self.team );
        
        if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() && ( getsubgametype() == "dmz" || getsubgametype() == "exgm" ) && !istrue( level.br_allowloadout ) )
        {
            newclass = 0;
        }
        else if ( var_40645c66e8a85816 || var_7e61909352db412d || var_9cfda0afbbf50688 )
        {
            channel = "class_select";
            
            if ( istestclient( self ) )
            {
                newclass = "default1";
            }
            else if ( !isai( self ) )
            {
                var_788bcfab4101649a = function_788bcfab4101649a( self );
                
                if ( var_788bcfab4101649a && !function_1e098780c33853f2() || getdvarint( @"hash_89556297eaab6b6a", 0 ) )
                {
                    newclass = self getplayerdata( level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex" );
                }
                else
                {
                    newclass = 100;
                }
            }
            else
            {
                newclass = "callback";
            }
        }
        else if ( allowclasschoice() || showfakeloadout() && !isai( self ) )
        {
            if ( scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73() )
            {
                if ( gameflag( "prematch_done" ) && ( !isdefined( level.infilcinematicactive ) || level.infilcinematicactive ) )
                {
                    bypassclasschoice();
                    break;
                }
            }
            
            if ( !self iscodcaster() && getdvarint( @"hash_e32ebdbb97a1ec4e", 0 ) == 0 && self.team != "spectator" && getgametype() != "arm" && getgametype() != "conflict" )
            {
                scripts\mp\utility\lower_message::setlowermessageomnvar( "must_select_loadout_to_spawn" );
            }
            
            var_3c8dceee54a35f62 = getdvarint( @"hash_d831c84920a830ff", 0 );
            
            if ( var_3c8dceee54a35f62 > 0 )
            {
                thread function_941a6cafc9c004e4( var_3c8dceee54a35f62 );
            }
            
            self waittill( "loadout_class_selected", newclass );
        }
        else
        {
            bypassclasschoice();
            break;
        }
        
        if ( self.team == "spectator" )
        {
            waitframe();
            continue;
        }
        
        if ( ( isjuggermoshgamemode() || ismutationgamemodezombie() ) && !isbot( self ) && !isloadoutindexdefault( newclass ) )
        {
            newclass = 100;
        }
        
        if ( "" + newclass != "callback" )
        {
            if ( isbot( self ) || istestclient( self ) )
            {
                self.pers[ "class" ] = newclass;
                self.class = newclass;
            }
            else
            {
                newclass = newclass;
                self.pers[ "class" ] = getclasschoice( newclass );
                self.class = getclasschoice( newclass );
            }
            
            scripts\mp\utility\lower_message::setlowermessageomnvar( "clear_lower_msg" );
            self.waitingtoselectclass = 0;
        }
        else
        {
            self.waitingtoselectclass = 0;
            menuclass( "callback" );
        }
        
        break;
    }
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0x21fb
// Size: 0x2c
function function_941a6cafc9c004e4( var_3c8dceee54a35f62 )
{
    self endon( "disconnect" );
    self endon( "loadout_class_selected" );
    wait var_3c8dceee54a35f62;
    thread onclasschoicecallback( randomintrange( 100, 110 ) );
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0x222f
// Size: 0x1ea
function beginclasschoice( forcenewchoice )
{
    team = self.pers[ "team" ];
    assert( team == "<dev string:x199>" || team == "<dev string:x1a1>" || issubstr( team, "<dev string:x1ab>" ) );
    
    if ( allowclasschoice() || showfakeloadout() && !isai( self ) )
    {
        if ( getdvarint( @"hash_206a763969420ce0", 0 ) == 1 && scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "dmz" && getsubgametype() != "exgm" && getsubgametype() != "plunder" && getsubgametype() != "risk" && getsubgametype() != "sandbox" && getsubgametype() != "rumble_mgl" )
        {
            classchoicefunc = isdefined( level.allowclasschoicefunc ) && istrue( self [[ level.allowclasschoicefunc ]]() );
            scripts\mp\utility\script::demoforcesre( "beginClassChoice() " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + classchoicefunc );
        }
        
        if ( !istrue( self.var_10844ddcb34694ee ) )
        {
            self setclientomnvar( "ui_options_menu", 2 );
        }
        
        if ( !self iscodcaster() )
        {
            waitforclassselect();
        }
        
        endrespawnnotify();
        
        if ( self.sessionstate == "spectator" )
        {
            if ( game[ "state" ] == "postgame" )
            {
                return;
            }
            
            if ( game[ "state" ] == "playing" && !isinkillcam() )
            {
                if ( isdefined( self.waitingtospawnamortize ) && self.waitingtospawnamortize )
                {
                    return;
                }
                
                thread scripts\mp\playerlogic::spawnclient();
            }
            
            thread scripts\mp\spectating::setspectatepermissions();
        }
        
        self.connecttime = gettime();
        self notify( "okToSpawn" );
        return;
    }
    
    thread bypassclasschoice();
}

// Namespace menus / scripts\mp\menus
// Params 0
// Checksum 0x0, Offset: 0x2421
// Size: 0x127
function bypassclasschoice()
{
    self.selectedclass = 1;
    self.waitingtoselectclass = 0;
    
    if ( ispresstofirstspawnmode() && level.enforceantiboosting && !isbot( self ) )
    {
        scripts\mp\utility\lower_message::setlowermessageomnvar( "press_to_spawn" );
        self notifyonplayercommand( "pressToSpawn", "+usereload" );
        self notifyonplayercommand( "pressToSpawn", "+activate" );
        thread waitthensetspawnomnvar();
        self waittill( "pressToSpawn" );
    }
    
    if ( isdefined( level.bypassclasschoicefunc ) )
    {
        class_choice = self [[ level.bypassclasschoicefunc ]]();
        self.class = class_choice;
        return;
    }
    
    self.class = "class0";
    
    if ( isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.namekey ) )
    {
        namekey = getxhash( level.gametypebundle.namekey );
        
        if ( namekey == #"zm_rb" || namekey == #"zm_turned" )
        {
            self.class = "default1";
        }
    }
}

// Namespace menus / scripts\mp\menus
// Params 0
// Checksum 0x0, Offset: 0x2550
// Size: 0x5d, Type: bool
function ispresstofirstspawnmode()
{
    if ( getdvarint( @"hash_eeaebebf98d1e9e7", 0 ) == 0 )
    {
        return false;
    }
    
    if ( scripts\cp_mp\utility\game_utility::isinfectedgametype() )
    {
        return true;
    }
    else if ( getgametype() == "dm" && istrue( level.aonrules ) )
    {
        return true;
    }
    else if ( getgametype() == "gun" )
    {
        return true;
    }
    
    return false;
}

// Namespace menus / scripts\mp\menus
// Params 0
// Checksum 0x0, Offset: 0x25b6
// Size: 0x1d
function waitthensetspawnomnvar()
{
    self endon( "pressToSpawn" );
    wait 1;
    
    if ( isdefined( self ) )
    {
        scripts\mp\utility\lower_message::setlowermessageomnvar( "press_to_spawn" );
    }
}

// Namespace menus / scripts\mp\menus
// Params 0
// Checksum 0x0, Offset: 0x25db
// Size: 0x10
function beginteamchoice()
{
    self setclientomnvar( "ui_options_menu", 1 );
}

// Namespace menus / scripts\mp\menus
// Params 0
// Checksum 0x0, Offset: 0x25f3
// Size: 0xb6
function menuspectator()
{
    if ( isdefined( self.pers[ "team" ] ) && self.pers[ "team" ] == "spectator" )
    {
        return;
    }
    
    if ( isalive( self ) )
    {
        assert( isdefined( self.pers[ "<dev string:x191>" ] ) );
        self.switching_teams = 1;
        self.joining_team = "spectator";
        self.leaving_team = self.pers[ "team" ];
        self suicide();
    }
    
    addtoteam( "spectator" );
    self.pers[ "class" ] = undefined;
    self.class = undefined;
    thread scripts\mp\playerlogic::spawnspectator();
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0x26b1
// Size: 0x2ed
function menuclass( response )
{
    assert( isdefined( self.pers[ "<dev string:x191>" ] ) );
    team = self.pers[ "team" ];
    assert( team == "<dev string:x1a1>" || team == "<dev string:x199>" || issubstr( team, "<dev string:x1ab>" ) );
    class = scripts\mp\class::getclasschoice( response );
    primary = scripts\mp\class::getweaponchoice( response );
    
    if ( class == "restricted" )
    {
        beginclasschoice();
        return;
    }
    
    if ( isdefined( self.pers[ "class" ] ) && self.pers[ "class" ] == class && isdefined( self.pers[ "primary" ] ) && self.pers[ "primary" ] == primary )
    {
        return;
    }
    
    if ( self.sessionstate == "playing" )
    {
        if ( isdefined( self.pers[ "lastClass" ] ) && isdefined( self.pers[ "class" ] ) )
        {
            self.pers[ "lastClass" ] = self.pers[ "class" ];
            self.lastclass = self.pers[ "lastClass" ];
        }
        
        self.pers[ "class" ] = class;
        self.class = class;
        self.pers[ "primary" ] = primary;
        
        if ( game[ "state" ] == "postgame" )
        {
            return;
        }
        
        if ( level.ingraceperiod && !self.hasdonecombat )
        {
            scripts\mp\class::setclass( self.pers[ "class" ] );
            self.tag_stowed_back = undefined;
            self.tag_stowed_hip = undefined;
            scripts\mp\class::giveloadout( self.pers[ "team" ], self.pers[ "class" ] );
        }
        else
        {
            self iprintlnbold( game[ "strings" ][ "change_class" ] );
        }
    }
    else
    {
        if ( isdefined( self.pers[ "lastClass" ] ) && isdefined( self.pers[ "class" ] ) )
        {
            self.pers[ "lastClass" ] = self.pers[ "class" ];
            self.lastclass = self.pers[ "lastClass" ];
        }
        
        self.pers[ "class" ] = class;
        self.class = class;
        self.pers[ "primary" ] = primary;
        
        if ( game[ "state" ] == "postgame" )
        {
            return;
        }
        
        if ( game[ "state" ] == "playing" && !isinkillcam() && !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
        {
            thread scripts\mp\playerlogic::spawnclient();
        }
    }
    
    thread scripts\mp\spectating::setspectatepermissions();
}

// Namespace menus / scripts\mp\menus
// Params 4
// Checksum 0x0, Offset: 0x29a6
// Size: 0x2de
function addtoteam( team, firstconnect, var_67d0631ad9027f83, var_26c802633f90a05c )
{
    if ( isdefined( self.team ) )
    {
        scripts\mp\playerlogic::removefromteamcount();
        
        if ( isdefined( var_67d0631ad9027f83 ) && var_67d0631ad9027f83 )
        {
            scripts\mp\playerlogic::decrementalivecount( self.team, undefined, "addToTeam" );
        }
        
        scripts\cp_mp\squads::leavesquad( self.team, self.sessionsquadid );
    }
    
    if ( isdefined( self.pers[ "team" ] ) && self.pers[ "team" ] != "" && self.pers[ "team" ] != "spectator" && self.pers[ "team" ] != "codcaster" )
    {
        self.pers[ "last_team" ] = self.pers[ "team" ];
    }
    
    self.changedteams = isdefined( self.pers[ "last_team" ] ) && self.pers[ "last_team" ] != team;
    
    if ( !level.teambased )
    {
        if ( isbot( self ) && team != "allies" && team != "axis" )
        {
            self.pers[ "team" ] = ter_op( cointoss(), "allies", "axis" );
            self.team = "allies";
        }
        else
        {
            self.pers[ "team" ] = team;
            self.team = team;
        }
    }
    else
    {
        self.pers[ "team" ] = team;
        self.team = team;
    }
    
    isbotplayer = isbot( self ) || istestclient( self );
    
    if ( isbotplayer || function_d7ec918e29c0b2f4() )
    {
        setsessionteam( team );
    }
    else if ( !denysystemicteamchoice() )
    {
        if ( matchmakinggame() && !istrue( var_26c802633f90a05c ) )
        {
            if ( !allowteamassignment() )
            {
                if ( scripts\cp_mp\utility\game_utility::isinfectedgametype() )
                {
                    setsessionteam( team );
                }
            }
        }
        else if ( !function_1eb7d2791d3c536f() )
        {
            setsessionteam( team );
        }
    }
    else if ( getdvarint( @"hash_c11db9baa9e5bc9b", 0 ) > 0 )
    {
        if ( !level.matchmakingmatch )
        {
            setsessionteam( team );
        }
    }
    
    if ( game[ "state" ] != "postgame" )
    {
        scripts\mp\playerlogic::addtoteamcount( istrue( var_67d0631ad9027f83 ) );
    }
    
    updateobjectivetext();
    
    if ( isdefined( firstconnect ) && firstconnect )
    {
        waittillframeend();
    }
    
    if ( team == "spectator" || team == "codcaster" )
    {
        self notify( "joined_spectators" );
        scripts\mp\teams::onjoinedspectators( self );
        scripts\mp\spectating::onjoinedspectators( self );
        scripts\mp\bounty::onplayerjoinedspectators( self );
        scripts\cp_mp\pet_watch::onjoinspectators();
    }
    else
    {
        self notify( "joined_team" );
    }
    
    scripts\mp\utility\join_team_aggregator::onplayerjointeam( self );
    level notify( "add_to_team", self );
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0x2c8c
// Size: 0x2c
function setsessionteam( teamset )
{
    if ( level.teambased )
    {
        self.sessionteam = teamset;
        return;
    }
    
    setemptysessionteam( teamset );
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0x2cc0
// Size: 0x4f
function setemptysessionteam( teamset )
{
    if ( teamset == "spectator" )
    {
        self.sessionteam = "spectator";
        return;
    }
    
    if ( teamset == "codcaster" )
    {
        self.sessionteam = "codcaster";
        return;
    }
    
    self.sessionteam = "none";
}

// Namespace menus / scripts\mp\menus
// Params 0
// Checksum 0x0, Offset: 0x2d17
// Size: 0x14
function endrespawnnotify()
{
    self.waitingtospawn = 0;
    self notify( "end_respawn" );
}

// Namespace menus / scripts\mp\menus
// Params 1
// Checksum 0x0, Offset: 0x2d33
// Size: 0x45
function logteamselection( teamselection )
{
    if ( getdvarint( @"scr_playtest", 0 ) == 0 )
    {
        return;
    }
    
    if ( teamselection != "random" )
    {
        iprintlnbold( "" + self.name + " did not select auto-assign" );
    }
}

// Namespace menus / scripts\mp\menus
// Params 0
// Checksum 0x0, Offset: 0x2d80
// Size: 0x236
function debugprintsquads()
{
    stepy = 25;
    
    while ( true )
    {
        if ( isdefined( level.squaddata ) )
        {
            startx = 800;
            starty = 25;
            linecount = 1;
            
            /#
                printtoscreen2d( startx + 250, starty, "<dev string:x1b4>", ( 1, 1, 1 ), 1 );
            #/
            
            foreach ( team, var_70643c8580524236 in level.squaddata )
            {
                linecount = 1;
                
                /#
                    printtoscreen2d( startx, starty + stepy * linecount, "<dev string:x1c2>" + team, ( 1, 1, 1 ), 1 );
                #/
                
                linecount++;
                
                foreach ( squad in var_70643c8580524236 )
                {
                    color = ( 1, 1, 1 );
                    
                    if ( isdefined( squad.activemission ) )
                    {
                        color = ( 1, 1, 0 );
                    }
                    
                    /#
                        printtoscreen2d( startx + 25, starty + stepy * linecount, "<dev string:x1cc>" + squad.index, color, 1 );
                    #/
                    
                    linecount++;
                    
                    foreach ( player in squad.players )
                    {
                        color = ( 1, 1, 1 );
                        
                        if ( istrue( player.squadassignedfromlobby ) )
                        {
                            color = ( 0, 1, 0 );
                        }
                        
                        /#
                            printtoscreen2d( startx + 50, starty + stepy * linecount, player.name, color, 1 );
                        #/
                        
                        linecount++;
                    }
                }
                
                startx += 200;
            }
        }
        
        waitframe();
    }
}

