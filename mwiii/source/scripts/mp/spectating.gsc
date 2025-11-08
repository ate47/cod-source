#using script_548072087c9fd504;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\playerlogic;
#using scripts\mp\tweakables;
#using scripts\mp\utility\game;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;

#namespace spectating;

// Namespace spectating / scripts\mp\spectating
// Params 0
// Checksum 0x0, Offset: 0x332
// Size: 0x94
function init()
{
    foreach ( entry in level.teamnamelist )
    {
        level.spectateoverride[ entry ] = spawnstruct();
    }
    
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( &freecamcallback );
    scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback( &onjoinedteam );
    
    if ( getdvarint( @"hash_242c4deac00b8e5b", 0 ) != 0 )
    {
        level thread getlevelmlgcams();
    }
}

// Namespace spectating / scripts\mp\spectating
// Params 2
// Checksum 0x0, Offset: 0x3ce
// Size: 0x63
function createmlgcamobject( icon, followrotation )
{
    precacheshader( icon );
    camera = spawn( "script_model", ( 0, 0, 0 ) );
    camera setmodel( "tag_origin" );
    camera.angles = ( 0, 0, 0 );
    return camera;
}

// Namespace spectating / scripts\mp\spectating
// Params 2
// Checksum 0x0, Offset: 0x43a
// Size: 0x10c
function setlevelmlgcam( index, csvfile )
{
    tableindex = index;
    
    if ( tableindex >= 4 )
    {
        tableindex -= 4;
    }
    
    mapname = tolower( getdvar( @"g_mapname" ) );
    var_d9733d3b5b9c44ce = tablelookup( csvfile, 0, mapname, tableindex * 2 + 1 );
    
    if ( var_d9733d3b5b9c44ce != "" )
    {
        var_dd0f1974b9c2c56a = index + 1;
        
        if ( index >= 5 )
        {
            var_dd0f1974b9c2c56a -= 4;
        }
        
        level.cameramapobjs[ index ] = createmlgcamobject( "compass_icon_codcaster_cam", 1 );
        level.numbermapobjs[ index ] = createmlgcamobject( "compass_icon_codcaster_num" + var_dd0f1974b9c2c56a, 0 );
        var_ffb7ba3abbf69f8c = tablelookup( csvfile, 0, mapname, tableindex * 2 + 2 );
        level.camerapos[ index ] = getcameravecorang( var_d9733d3b5b9c44ce );
        level.cameraang[ index ] = getcameravecorang( var_ffb7ba3abbf69f8c );
        level.camerahighestindex = index;
    }
}

// Namespace spectating / scripts\mp\spectating
// Params 0
// Checksum 0x0, Offset: 0x54e
// Size: 0x9a
function getlevelmlgcams()
{
    while ( !isdefined( level.objectiveidpool ) )
    {
        waitframe();
    }
    
    csvfile = "mp/CameraPositions";
    var_3b2139bfd025890b = csvfile + "_" + getgametype() + ".csv";
    csvfile += ".csv";
    level.cameramapobjs = [];
    level.numbermapobjs = [];
    
    for ( index = 0; index < 4 ; index++ )
    {
        setlevelmlgcam( index, csvfile );
    }
    
    for ( index = 4; index < 8 ; index++ )
    {
        setlevelmlgcam( index, var_3b2139bfd025890b );
    }
}

// Namespace spectating / scripts\mp\spectating
// Params 1
// Checksum 0x0, Offset: 0x5f0
// Size: 0x70
function getcameravecorang( elementstring )
{
    var_26fa16ced67d6ad0 = strtok( elementstring, " " );
    var_d2f65e1abe223ead = ( 0, 0, 0 );
    
    if ( isdefined( var_26fa16ced67d6ad0[ 0 ] ) && isdefined( var_26fa16ced67d6ad0[ 1 ] ) && isdefined( var_26fa16ced67d6ad0[ 2 ] ) )
    {
        var_d2f65e1abe223ead = ( int( var_26fa16ced67d6ad0[ 0 ] ), int( var_26fa16ced67d6ad0[ 1 ] ), int( var_26fa16ced67d6ad0[ 2 ] ) );
    }
    
    return var_d2f65e1abe223ead;
}

// Namespace spectating / scripts\mp\spectating
// Params 1
// Checksum 0x0, Offset: 0x669
// Size: 0x13
function onjoinedteam( player )
{
    player setspectatepermissions();
}

// Namespace spectating / scripts\mp\spectating
// Params 1
// Checksum 0x0, Offset: 0x684
// Size: 0x91
function onjoinedspectators( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player thread onspectatingclient();
    player thread onspectatingmlgcamera();
    player setspectatepermissions();
    player setclientomnvar( "ui_callout_area_id", -1 );
    
    if ( player iscodcaster() || isdefined( player.pers[ "codcaster" ] ) && player.pers[ "codcaster" ] )
    {
        player setcodcaster( 1 );
        player thread function_de89a33a1571dd0a();
        player thread autoattachtoplayer();
        player thread saveendgamelocals();
    }
}

// Namespace spectating / scripts\mp\spectating
// Params 0
// Checksum 0x0, Offset: 0x71d
// Size: 0x170
function onspectatingclient()
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    
    for ( ;; )
    {
        self waittill( "spectating_cycle" );
        player = self getspectatingplayer();
        
        if ( isdefined( player ) )
        {
            if ( isdefined( player.calloutarea ) )
            {
                areaid = level.calloutglobals.areaidmap[ player.calloutarea ];
                self setclientomnvar( "ui_callout_area_id", areaid );
            }
            
            if ( game[ "state" ] == "playing" && level.teamdata[ player.team ][ "alivePlayers" ].size > 0 && !isinkillcam() )
            {
                gametype = getbasegametype();
                var_b19d8f6eee9278c4 = getdvarint( @"hash_2167cbfc86b6839", 0 ) == 1;
                
                if ( gametype == "sd" || gametype == "arena" && var_b19d8f6eee9278c4 || gametype == "warrior" )
                {
                    if ( player.team == "allies" )
                    {
                        self setclientomnvar( "ui_team_before_spectating", 1 );
                        continue;
                    }
                    
                    if ( player.team == "axis" )
                    {
                        self setclientomnvar( "ui_team_before_spectating", 2 );
                        continue;
                    }
                    
                    if ( player.team == "team_three" )
                    {
                        self setclientomnvar( "ui_team_before_spectating", 3 );
                    }
                }
            }
        }
    }
}

// Namespace spectating / scripts\mp\spectating
// Params 0
// Checksum 0x0, Offset: 0x895
// Size: 0x73
function onspectatingmlgcamera()
{
    self endon( "disconnect" );
    self endon( "joined_team" );
    
    for ( ;; )
    {
        self waittill( "spectating_mlg_camera" );
        selectedcamera = self getmlgselectedcamera();
        
        if ( self iscodcaster() || isdefined( self.pers[ "codcaster" ] ) && self.pers[ "codcaster" ] )
        {
            if ( isdefined( selectedcamera ) )
            {
                self setclientomnvar( "ui_callout_area_id", -1 );
            }
        }
    }
}

// Namespace spectating / scripts\mp\spectating
// Params 2
// Checksum 0x0, Offset: 0x910
// Size: 0x24
function freecamcallback( channel, view )
{
    if ( channel == "mlg_view_change" )
    {
        scripts\mp\playerlogic::resetuidvarsonspectate();
    }
}

// Namespace spectating / scripts\mp\spectating
// Params 0
// Checksum 0x0, Offset: 0x93c
// Size: 0x3d
function updatespectatesettings()
{
    level endon( "game_ended" );
    
    for ( index = 0; index < level.players.size ; index++ )
    {
        level.players[ index ] setspectatepermissions();
    }
}

// Namespace spectating / scripts\mp\spectating
// Params 0
// Checksum 0x0, Offset: 0x981
// Size: 0x13e
function autoattachtoplayer()
{
    self endon( "disconnect" );
    self endon( "game_ended" );
    self endon( "spectating_mlg_camera" );
    level waittill_any_4( "prematch_started", "prematch_done", "start_mode_setup", "infil_started" );
    level.lastspectatedplayer = game[ "lastSpectatedPlayer" ];
    
    for ( ;; )
    {
        selectedclientnum = undefined;
        
        if ( !self iscodcaster() || self isspectatingplayer() || self ismlgfreecamenabled() || self ismlgaerialcamenabled() )
        {
            break;
        }
        
        if ( level.players.size > 1 )
        {
            if ( level.currentround > 1 && isdefined( level.lastspectatedplayer ) )
            {
                selectedclientnum = level.lastspectatedplayer;
            }
            else
            {
                foreach ( entry in level.teamnamelist )
                {
                    aliveplayers = getfriendlyplayers( entry, 1 );
                    
                    if ( aliveplayers.size > 0 )
                    {
                        selectedclientnum = getlowestclientnum( aliveplayers, 1 );
                    }
                }
            }
            
            if ( isdefined( selectedclientnum ) )
            {
                self spectateclientnum( selectedclientnum );
                break;
            }
        }
        
        wait 1;
    }
}

// Namespace spectating / scripts\mp\spectating
// Params 0
// Checksum 0x0, Offset: 0xac7
// Size: 0x7e
function function_de89a33a1571dd0a()
{
    self endon( "joined_team" );
    self endon( "disconnect" );
    self.iswatchingcodcasterball = 0;
    self.codcasterballcamfollow = undefined;
    self.spectatingplayerbeforeballcam = undefined;
    
    for ( ;; )
    {
        if ( self iscodcaster() && self isspectatingplayer() )
        {
            player = self getspectatingplayer();
            
            if ( isdefined( player ) )
            {
                level.lastspectatedplayer = player.clientid;
            }
            
            player namespace_f5675568ccc8acc6::function_20038a4ada38be4d( self );
        }
        
        wait 0.05;
    }
}

// Namespace spectating / scripts\mp\spectating
// Params 0
// Checksum 0x0, Offset: 0xb4d
// Size: 0x1b
function saveendgamelocals()
{
    level waittill( "game_ended" );
    game[ "lastSpectatedPlayer" ] = level.lastspectatedplayer;
}

// Namespace spectating / scripts\mp\spectating
// Params 1
// Checksum 0x0, Offset: 0xb70
// Size: 0x5b1
function setspectatepermissions( gameended )
{
    if ( level.gameended && gettime() - level.gameendtime >= 2000 && !istrue( level.postgameexfil ) )
    {
        if ( level.teambased )
        {
            foreach ( entry in level.teamnamelist )
            {
                self allowspectateteam( entry, 0 );
            }
        }
        
        self allowspectateteam( "freelook", 0 );
        self allowspectateteam( "none", 1 );
        return;
    }
    
    spectatetype = scripts\mp\tweakables::gettweakablevalue( "game", "spectatetype" );
    
    if ( getdvarint( @"hash_e32ebdbb97a1ec4e", 0 ) == 1 )
    {
        spectatetype = 2;
    }
    
    if ( self iscodcaster() )
    {
        spectatetype = 2;
    }
    
    if ( istrue( self.inspawncamera ) || isdefined( self.setspawnpoint ) && scripts\mp\playerlogic::mayspawn() )
    {
        spectatetype = 0;
    }
    
    if ( istrue( gameended ) )
    {
        spectatetype = 2;
    }
    
    if ( istrue( level.disablespectate ) )
    {
        spectatetype = 0;
    }
    
    team = self.sessionteam;
    
    switch ( spectatetype )
    {
        case 0:
            setdisabled();
            break;
        case 1:
            self notify( "waitForGameStartSpectate" );
            
            if ( team != "spectator" && team != "codcaster" )
            {
                if ( level.gametype == "sd" || level.gametype == "arena" || level.gametype == "warrior" )
                {
                    if ( team == "allies" )
                    {
                        self setclientomnvar( "ui_team_before_spectating", 1 );
                    }
                    else if ( team == "axis" )
                    {
                        self setclientomnvar( "ui_team_before_spectating", 2 );
                    }
                    else if ( team == "team_three" )
                    {
                        self setclientomnvar( "ui_team_before_spectating", 3 );
                    }
                }
                
                setteamorplayeronly( team );
            }
            else if ( isdefined( self.pers[ "last_team" ] ) )
            {
                if ( level.gametype == "sd" || level.gametype == "arena" || level.gametype == "warrior" )
                {
                    if ( self.pers[ "last_team" ] == "allies" )
                    {
                        self setclientomnvar( "ui_team_before_spectating", 1 );
                    }
                    else if ( self.pers[ "last_team" ] == "axis" )
                    {
                        self setclientomnvar( "ui_team_before_spectating", 2 );
                    }
                    else if ( self.pers[ "last_team" ] == "team_three" )
                    {
                        self setclientomnvar( "ui_team_before_spectating", 3 );
                    }
                }
                
                team = self.pers[ "last_team" ];
                setteamorplayeronly( team );
            }
            else if ( istrue( level.prematchstarted ) )
            {
                randidx = randomint( level.teamnamelist.size );
                setteamorplayeronly( level.teamnamelist[ randidx ] );
                
                if ( level.gametype == "sd" || level.gametype == "arena" || level.gametype == "warrior" )
                {
                    self setclientomnvar( "ui_team_before_spectating", randidx );
                }
            }
            else
            {
                setteamorplayeronly( "allies" );
                
                if ( level.gametype == "sd" || level.gametype == "arena" || level.gametype == "warrior" )
                {
                    self setclientomnvar( "ui_team_before_spectating", 1 );
                }
                
                thread waitforgamestartspectate();
                return;
            }
            
            break;
        case 2:
            setfreelook( gameended );
            break;
        case 3:
            if ( team == "spectator" || team == "codcaster" )
            {
                setfreelook();
            }
            else
            {
                setteamorplayeronly( team );
            }
            
            break;
    }
    
    if ( isdefined( team ) && isgameplayteam( team ) )
    {
        if ( istrue( level.spectateoverride[ team ].allowfreespectate ) )
        {
            self allowspectateteam( "freelook", 1 );
        }
        
        if ( istrue( level.spectateoverride[ team ].allowenemyspectate ) )
        {
            enemyteams = getenemyteams( team );
            
            foreach ( entry in enemyteams )
            {
                self allowspectateteam( entry, 1 );
            }
        }
    }
    
    var_929fd4bdfabd747b = privatematch() && scripts\cp_mp\utility\game_utility::isbrstylegametype();
    
    /#
        if ( getdvarint( @"hash_f7fccc8ff6925d24", 0 ) != 0 )
        {
            var_929fd4bdfabd747b = 1;
        }
    #/
    
    if ( var_929fd4bdfabd747b && ( self.sessionteam == "spectator" || self.sessionteam == "codcaster" ) )
    {
        foreach ( entry in level.teamnamelist )
        {
            if ( !isgameplayteam( entry ) )
            {
                continue;
            }
            
            self allowspectateteam( entry, 1 );
        }
        
        updatesessionstate( "spectator" );
    }
}

// Namespace spectating / scripts\mp\spectating
// Params 0
// Checksum 0x0, Offset: 0x1129
// Size: 0x20
function waitforgamestartspectate()
{
    self endon( "waitForGameStartSpectate" );
    self endon( "disconnect" );
    level waittill( "prematch_started" );
    thread setspectatepermissions();
}

// Namespace spectating / scripts\mp\spectating
// Params 0
// Checksum 0x0, Offset: 0x1151
// Size: 0x71
function setdisabled()
{
    self allowspectateteam( "freelook", 0 );
    self allowspectateteam( "none", 0 );
    
    foreach ( entry in level.teamnamelist )
    {
        self allowspectateteam( entry, 0 );
    }
}

// Namespace spectating / scripts\mp\spectating
// Params 1
// Checksum 0x0, Offset: 0x11ca
// Size: 0xf6
function setteamorplayeronly( team )
{
    self allowspectateteam( "freelook", 0 );
    
    if ( level.teambased )
    {
        self allowspectateteam( "none", 0 );
        
        foreach ( entry in level.teamnamelist )
        {
            if ( team == entry )
            {
                self allowspectateteam( entry, 1 );
                continue;
            }
            
            self allowspectateteam( entry, 0 );
        }
        
        return;
    }
    
    self allowspectateteam( "none", 1 );
    
    foreach ( entry in level.teamnamelist )
    {
        self allowspectateteam( entry, 1 );
    }
}

// Namespace spectating / scripts\mp\spectating
// Params 1
// Checksum 0x0, Offset: 0x12c8
// Size: 0x12b
function setfreelook( gameended )
{
    self allowspectateteam( "freelook", 1 );
    self allowspectateteam( "none", 1 );
    
    if ( scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        foreach ( entry in level.teamnamelist )
        {
            self allowspectateteam( entry, 1 );
        }
        
        if ( istrue( gameended ) )
        {
            thread scripts\mp\playerlogic::spawnspectator( undefined, undefined, 1 );
        }
        
        return;
    }
    
    if ( self iscodcaster() )
    {
        self allowspectateteam( "allies", 1 );
        self allowspectateteam( "axis", 1 );
        thread waitforgamestartspectate();
        return;
    }
    
    team = self.sessionteam;
    
    if ( self == level.players[ 0 ] || team == "spectator" || team == "codcaster" )
    {
        self allowspectateteam( "allies", 1 );
        self allowspectateteam( "axis", 0 );
        thread waitforgamestartspectate();
    }
}

