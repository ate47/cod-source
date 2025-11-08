#using scripts\common\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hud_util;
#using scripts\mp\menus;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\print;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;

#namespace mtmc;

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 0
// Checksum 0x0, Offset: 0x522
// Size: 0x283
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    allowed[ 0 ] = "mtmc";
    scripts\mp\gameobjects::main( allowed );
    
    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = &initializematchrules;
        [[ level.initializematchrules ]]();
        level thread reinitializematchrulesonmigration();
    }
    else
    {
        registertimelimitdvar( getgametype(), 0 );
        registerscorelimitdvar( getgametype(), 0 );
        registerroundlimitdvar( getgametype(), 0 );
        registerroundswitchdvar( getgametype(), 1, 0, 1 );
        registerwinlimitdvar( getgametype(), 1 );
        registernumlivesdvar( getgametype(), 1 );
        registerhalftimedvar( getgametype(), 0 );
    }
    
    updategametypedvars();
    level.teambased = 1;
    level.disablebuddyspawn = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onplayerkilled = &onplayerkilled;
    level.modeonspawnplayer = &onspawnplayer;
    level.onobjectivecomplete = &onflagcapture;
    level.ondeadevent = &ondeadevent;
    level.lastcaptime = gettime();
    game[ "dialog" ][ "gametype" ] = "gametype_domination";
    game[ "dialog" ][ "offense_obj" ] = "capture_objs";
    game[ "dialog" ][ "defense_obj" ] = "capture_objs";
    game[ "dialog" ][ "securing_a" ] = "securing_a";
    game[ "dialog" ][ "securing_b" ] = "securing_b";
    game[ "dialog" ][ "securing_c" ] = "securing_c";
    game[ "dialog" ][ "secured_a" ] = "secure_a";
    game[ "dialog" ][ "secured_b" ] = "secure_b";
    game[ "dialog" ][ "secured_c" ] = "secure_c";
    game[ "dialog" ][ "losing_a" ] = "losing_a";
    game[ "dialog" ][ "losing_b" ] = "losing_b";
    game[ "dialog" ][ "losing_c" ] = "losing_c";
    game[ "dialog" ][ "lost_a" ] = "lost_a";
    game[ "dialog" ][ "lost_b" ] = "lost_b";
    game[ "dialog" ][ "lost_c" ] = "lost_c";
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 0
// Checksum 0x0, Offset: 0x7ad
// Size: 0xda
function initializematchrules()
{
    setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_dceb221c25aecc14", getmatchrulesdata( "domData", "flagCaptureTime" ) );
    setdynamicdvar( @"hash_893144fa8142f154", getmatchrulesdata( "domData", "flagNeutralization" ) );
    setdynamicdvar( @"hash_347ffd1b942e9310", getmatchrulesdata( "domData", "objScalar" ) );
    setdynamicdvar( @"hash_2b790c4f6834b087", getmatchrulesdata( "siegeData", "preCapPoints" ) );
    setdynamicdvar( @"hash_c0afffc882cf1c47", getmatchrulesdata( "captureData", "captureType" ) );
    setdynamicdvar( @"hash_6b9c2f7d2ece6e97", getmatchrulesdata( "captureData", "captureDecay" ) );
    setdynamicdvar( @"hash_a132f0cb12c4eb3b", 0 );
    registerhalftimedvar( "mtmc", 0 );
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 0
// Checksum 0x0, Offset: 0x88f
// Size: 0x64
function seticonnames()
{
    level.iconneutral = "waypoint_captureneutral";
    level.iconcapture = "waypoint_capture";
    level.icondefend = "waypoint_defend";
    level.iconcontested = "waypoint_contested";
    level.icontaking = "waypoint_taking";
    level.iconlosing = "waypoint_losing";
    level.icontarget = "icon_waypoint_target";
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 0
// Checksum 0x0, Offset: 0x8fb
// Size: 0xea
function onstartgametype()
{
    seticonnames();
    
    foreach ( entry in level.teamnamelist )
    {
        setobjectivetext( entry, &"OBJECTIVES/DOM" );
        
        if ( level.splitscreen )
        {
            setobjectivescoretext( entry, &"OBJECTIVES/DOM" );
        }
        else
        {
            setobjectivescoretext( entry, &"OBJECTIVES/DOM_SCORE" );
        }
        
        setobjectivehinttext( entry, &"OBJECTIVES/DOM_HINT" );
    }
    
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( !isdefined( game[ "remainingTeams" ] ) )
    {
        game[ "remainingTeams" ] = level.teamnamelist;
    }
    
    initspawns();
    thread setupflags();
    thread startgame();
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 0
// Checksum 0x0, Offset: 0x9ed
// Size: 0x9a
function startgame()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    wait 15;
    
    foreach ( obj in level.objectives )
    {
        obj scripts\mp\gameobjects::setobjectivestatusicons( level.iconneutral );
        obj scripts\mp\gameobjects::enableobject();
        obj scripts\mp\gameobjects::setvisibleteam( "any" );
        obj scripts\mp\gameobjects::allowuse( "any" );
    }
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 0
// Checksum 0x0, Offset: 0xa8f
// Size: 0x9e
function updategametypedvars()
{
    scripts\mp\gametypes\common::updatecommongametypedvars();
    level.flagcapturetime = dvarfloatvalue( "flagCaptureTime", 30, 0, 30 );
    level.flagneutralization = dvarintvalue( "flagNeutralization", 0, 0, 1 );
    level.precappoints = dvarintvalue( "preCapPoints", 0, 0, 1 );
    level.capturedecay = dvarintvalue( "captureDecay", 1, 0, 1 );
    level.capturetype = dvarintvalue( "captureType", 1, 0, 3 );
    level.objectivescaler = dvarfloatvalue( "objScalar", 4, 1, 10 );
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 0
// Checksum 0x0, Offset: 0xb35
// Size: 0x308
function initspawns()
{
    if ( function_bff229a11ecd1e34() )
    {
        scripts\mp\spawnlogic::setactivespawnlogic( #"default" );
    }
    else
    {
        scripts\mp\spawnlogic::setactivespawnlogic( "MTMC", "Crit_Default" );
    }
    
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2147483647, -2147483647, -2147483647 );
    spawns = scripts\mp\spawnlogic::getspawnpointarray( "mp_mtmc_spawn_start" );
    
    foreach ( entry in game[ "remainingTeams" ] )
    {
        scripts\mp\spawnlogic::registerspawnpoints( entry, spawns );
    }
    
    level.startlocations = [];
    
    foreach ( s in spawns )
    {
        if ( !isdefined( s.target ) || s.target == "" )
        {
            continue;
        }
        
        if ( !isdefined( s.script_noteworthy ) || s.script_noteworthy == "" )
        {
            assertmsg( "<dev string:x1c>" + s.origin );
        }
        
        if ( int( s.script_noteworthy ) != game[ "remainingTeams" ].size )
        {
            continue;
        }
        
        loc = level.startlocations[ s.target ];
        
        if ( isdefined( loc ) )
        {
            loc.spawnpoints[ loc.spawnpoints.size ] = s;
            continue;
        }
        
        target = getstruct( s.target, "targetname" );
        struct = spawnstruct();
        struct.origin = target.origin;
        struct.angles = target.angles;
        struct.spawnpoints = [];
        struct.spawnpoints[ 0 ] = s;
        struct.inuse = 0;
        level.startlocations[ s.target ] = struct;
    }
    
    foreach ( key, loc in level.startlocations )
    {
        scripts\mp\spawnlogic::registerspawnset( key, loc.spawnpoints );
        scripts\mp\spawnlogic::activatespawnset( key );
    }
    
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 0
// Checksum 0x0, Offset: 0xe45
// Size: 0x11f
function getspawnpoint()
{
    scripts\mp\spawnlogic::deactivateallspawnsets();
    
    if ( !isdefined( level.teamspawnlocations ) )
    {
        level.teamspawnlocations = [];
    }
    
    key = level.teamspawnlocations[ self.team ];
    
    if ( isdefined( key ) )
    {
        scripts\mp\spawnlogic::activatespawnset( key );
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint( self, self.team, undefined, undefined, 2 );
        return spawnpoint;
    }
    
    foreach ( key, loc in level.startlocations )
    {
        if ( loc.inuse )
        {
            continue;
        }
        
        scripts\mp\spawnlogic::activatespawnset( key );
    }
    
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint( self, self.team, undefined, undefined, 2 );
    level.startlocations[ spawnpoint.target ].inuse = 1;
    level.teamspawnlocations[ self.team ] = spawnpoint.target;
    return spawnpoint;
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 0
// Checksum 0x0, Offset: 0xf6d
// Size: 0x12e
function setupflags()
{
    triggers = getentarray( "mtmc_dom", "targetname" );
    
    if ( !triggers.size )
    {
        assertmsg( "<dev string:x3f>" );
        return;
    }
    
    foreach ( trigger in triggers )
    {
        if ( !isdefined( trigger.script_noteworthy ) || trigger.script_noteworthy == "" )
        {
            assertmsg( "<dev string:x70>" + trigger.origin );
        }
        
        if ( int( trigger.script_noteworthy ) != game[ "remainingTeams" ].size )
        {
            continue;
        }
        
        domflag = scripts\mp\gametypes\obj_dom::setupobjective( trigger, 1 );
        domflag scripts\mp\gameobjects::setobjectivestatusicons( level.icontarget );
        domflag scripts\mp\gameobjects::disableobject();
        domflag scripts\mp\gameobjects::setvisibleteam( "any" );
        domflag scripts\mp\gameobjects::allowuse( "none" );
        level.objectives[ domflag.objectivekey ] = domflag;
    }
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 10
// Checksum 0x0, Offset: 0x10a3
// Size: 0xa8
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    if ( !isplayer( attacker ) || attacker.team == self.team )
    {
        return;
    }
    
    if ( isdefined( objweapon ) && scripts\cp_mp\weapon::iskillstreakweapon( objweapon.basename ) )
    {
        return;
    }
    
    scripts\mp\gametypes\obj_dom::awardgenericmedals( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 1
// Checksum 0x0, Offset: 0x1153
// Size: 0xb
function onspawnplayer( revivespawn )
{
    
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 1
// Checksum 0x0, Offset: 0x1166
// Size: 0x14
function onplayerconnect( player )
{
    player thread onplayerspawned();
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 1
// Checksum 0x0, Offset: 0x1182
// Size: 0x84
function onplayerspawned( player )
{
    self endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "spawned" );
        setextrascore0( 0 );
        
        if ( isdefined( self.pers[ "captures" ] ) )
        {
            setextrascore0( self.pers[ "captures" ] );
        }
        
        setextrascore1( 0 );
        
        if ( isdefined( self.pers[ "defends" ] ) )
        {
            setextrascore1( self.pers[ "defends" ] );
        }
    }
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 6
// Checksum 0x0, Offset: 0x120e
// Size: 0x140
function onflagcapture( objectivetype, label, credit_player, team, oldteam, flagobj )
{
    assert( team != "<dev string:x95>" );
    scripts\mp\utility\dialog::statusdialog( "secured" + self.objectivekey, team, 1 );
    otherteams = getotherteam( team );
    
    foreach ( entry in otherteams )
    {
        scripts\mp\utility\dialog::statusdialog( "lost_" + self.objectivekey, entry, 1 );
    }
    
    scripts\mp\gameobjects::setvisibleteam( "none" );
    scripts\mp\gameobjects::allowuse( "none" );
    
    if ( isdefined( self.flagmodel ) )
    {
        self.flagmodel hide();
    }
    
    if ( !isdefined( level.remainingflags ) )
    {
        level.remainingflags = level.objectives.size;
    }
    
    level.remainingflags--;
    
    if ( level.remainingflags == 0 )
    {
        setremainingteams();
    }
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 1
// Checksum 0x0, Offset: 0x1356
// Size: 0x1c2
function ondeadevent( team )
{
    if ( team == "all" )
    {
        setremainingteams();
        return;
    }
    
    enemyteams = getenemyteams( team );
    livescount = [];
    
    foreach ( entry in enemyteams )
    {
        livescount[ entry ] = 0;
    }
    
    if ( !istrue( level.disablespawning ) )
    {
        foreach ( entry in enemyteams )
        {
            foreach ( player in getteamdata( entry, "players" ) )
            {
                if ( !istrue( player.hasspawned ) )
                {
                    continue;
                }
                
                livescount[ entry ] += player.pers[ "lives" ];
            }
        }
    }
    
    remainingteams = [];
    
    foreach ( entry in enemyteams )
    {
        if ( getteamdata( entry, "aliveCount" ) || livescount[ entry ] )
        {
            remainingteams[ remainingteams.size ] = entry;
        }
    }
    
    if ( remainingteams.size == 1 )
    {
        setremainingteams( remainingteams[ 0 ] );
    }
}

// Namespace mtmc / scripts\mp\gametypes\mtmc
// Params 1
// Checksum 0x0, Offset: 0x1520
// Size: 0x1f5
function setremainingteams( team )
{
    if ( istrue( level.remainingteamsset ) )
    {
        return;
    }
    
    level.remainingteamsset = 1;
    game[ "remainingTeams" ] = [];
    
    foreach ( objective in level.objectives )
    {
        if ( objective.ownerteam == "neutral" )
        {
            continue;
        }
        
        if ( !array_contains( game[ "remainingTeams" ], objective.ownerteam ) )
        {
            game[ "remainingTeams" ][ game[ "remainingTeams" ].size ] = objective.ownerteam;
        }
    }
    
    if ( isdefined( team ) && !array_contains( game[ "remainingTeams" ], team ) && game[ "remainingTeams" ].size < level.objectives.size )
    {
        game[ "remainingTeams" ][ game[ "remainingTeams" ].size ] = team;
    }
    
    foreach ( player in level.players )
    {
        if ( array_contains( level.teamnamelist, player.team ) )
        {
            if ( !array_contains( game[ "remainingTeams" ], player.team ) )
            {
                player scripts\mp\menus::addtoteam( "spectator" );
            }
        }
    }
    
    if ( game[ "remainingTeams" ].size == 1 )
    {
        scripts\mp\gamescore::giveteamscoreforobjective( game[ "remainingTeams" ][ 0 ], 1, 0 );
        thread scripts\mp\gamelogic::endgame( game[ "remainingTeams" ][ 0 ], game[ "end_reason" ][ "enemies_eliminated" ] );
        return;
    }
    
    thread scripts\mp\gamelogic::endgame( "tie", game[ "end_reason" ][ "objective_completed" ] );
}

