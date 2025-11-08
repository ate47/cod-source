#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\final_killcam;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\globallogic;
#using scripts\mp\hud_util;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;

#namespace assault;

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0x789
// Size: 0x271
function main()
{
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    allowed[ 0 ] = getgametype();
    allowed[ 1 ] = "sd";
    allowed[ 2 ] = "bombzone";
    allowed[ 3 ] = "blocker";
    scripts\mp\gameobjects::main( allowed );
    
    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = &initializematchrules;
        [[ level.initializematchrules ]]();
        level thread reinitializematchrulesonmigration();
    }
    else
    {
        registerroundswitchdvar( getgametype(), 1, 0, 9 );
        registertimelimitdvar( getgametype(), 3 );
        registerscorelimitdvar( getgametype(), 1 );
        registerroundlimitdvar( getgametype(), 0 );
        registerwinlimitdvar( getgametype(), 3 );
        registernumlivesdvar( getgametype(), 0 );
        registerhalftimedvar( getgametype(), 0 );
    }
    
    timelimit = getwatcheddvar( "timelimit" );
    registerwatchdvarint( "addObjectiveTime", timelimit );
    updategametypedvars();
    level.objectivebased = 1;
    level.teambased = 1;
    level.nobuddyspawns = 1;
    level.onprecachegametype = &onprecachegametype;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.onplayerkilled = &onplayerkilled;
    level.ontimelimit = &ontimelimit;
    level.onnormaldeath = &onnormaldeath;
    level.onobjectivecomplete = &onobjectivecomplete;
    level.resetuiomnvargamemode = &scripts\mp\gametypes\obj_bombzone::resetuiomnvargamemode;
    level.allowlatecomers = 0;
    game[ "dialog" ][ "offense_obj" ] = "obj_destroy";
    game[ "dialog" ][ "defense_obj" ] = "obj_defend";
    game[ "dialog" ][ "lead_lost" ] = "null";
    game[ "dialog" ][ "lead_tied" ] = "null";
    game[ "dialog" ][ "lead_taken" ] = "null";
    game[ "dialog" ][ "lost_a" ] = "lost_a";
    game[ "dialog" ][ "lost_b" ] = "lost_b";
    game[ "dialog" ][ "lost_c" ] = "lost_c";
    
    /#
        setdevdvarifuninitialized( @"hash_4de61d8bda8dfa5e", 0 );
        setdvarifuninitialized( @"hash_1e8e3ef72c5de769", 0 );
    #/
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0xa02
// Size: 0x19f
function initializematchrules()
{
    setcommonrulesfrommatchrulesdata();
    roundlength = getmatchrulesdata( "assaultData", "roundLength" );
    setdynamicdvar( @"hash_69ac63dc288bd7d1", roundlength );
    registertimelimitdvar( "assault", roundlength );
    roundswitch = getmatchrulesdata( "assaultData", "roundSwitch" );
    setdynamicdvar( @"hash_84421db73add1fbd", roundswitch );
    registerroundswitchdvar( "assault", roundswitch, 0, 9 );
    winlimit = getmatchrulesdata( "commonOption", "scoreLimit" );
    setdynamicdvar( @"hash_90a70dc66ba00706", winlimit );
    registerwinlimitdvar( "assault", winlimit );
    setdynamicdvar( @"hash_9ac09ec01293d68", getmatchrulesdata( "assaultData", "bombTimer" ) );
    setdynamicdvar( @"hash_7c1d7d49fdf5b019", getmatchrulesdata( "assaultData", "plantTime" ) );
    setdynamicdvar( @"hash_25b441b7b86466fc", getmatchrulesdata( "assaultData", "defuseTime" ) );
    setdynamicdvar( @"hash_63fc8f611cc686cc", getmatchrulesdata( "assaultData", "multiBomb" ) );
    setdynamicdvar( @"hash_7a356a57ff5cead3", getmatchrulesdata( "assaultData", "bombResetTimer" ) );
    setdynamicdvar( @"hash_1a82e6c2881430d0", 0 );
    registerroundlimitdvar( "assault", 0 );
    setdynamicdvar( @"hash_97b9f980e3b246f2", 1 );
    registerscorelimitdvar( "assault", 1 );
    setdynamicdvar( @"hash_de136a2eac5ac987", 0 );
    registerhalftimedvar( "assault", 0 );
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0xba9
// Size: 0x1c
function onprecachegametype()
{
    game[ "bomb_dropped_sound" ] = "iw9_mp_ui_objective_lost";
    game[ "bomb_recovered_sound" ] = "iw9_mp_ui_objective_taken";
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0xbcd
// Size: 0x16c
function onstartgametype()
{
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    setclientnamemode( "manual_change" );
    level._effect[ "bomb_explosion" ] = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
    level._effect[ "vehicle_explosion" ] = loadfx( "vfx/core/expl/small_vehicle_explosion_new.vfx" );
    level._effect[ "building_explosion" ] = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
    setobjectivetext( game[ "attackers" ], &"OBJECTIVES/SD_ATTACKER" );
    setobjectivetext( game[ "defenders" ], &"OBJECTIVES/SD_DEFENDER" );
    
    if ( level.splitscreen )
    {
        setobjectivescoretext( game[ "attackers" ], &"OBJECTIVES/SD_ATTACKER" );
        setobjectivescoretext( game[ "defenders" ], &"OBJECTIVES/SD_DEFENDER" );
    }
    else
    {
        setobjectivescoretext( game[ "attackers" ], &"OBJECTIVES/SD_ATTACKER_SCORE" );
        setobjectivescoretext( game[ "defenders" ], &"OBJECTIVES/SD_DEFENDER_SCORE" );
    }
    
    setobjectivehinttext( game[ "attackers" ], &"OBJECTIVES/SD_ATTACKER_HINT" );
    setobjectivehinttext( game[ "defenders" ], &"OBJECTIVES/SD_DEFENDER_HINT" );
    initspawns();
    setspecialloadout();
    thread initializeobjectives();
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0xd41
// Size: 0x9b
function initspawns()
{
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2147483647, -2147483647, -2147483647 );
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_assault_spawn_attacker_start" );
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_assault_spawn_defender_start" );
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    level.assaultspawns = [];
    initbombsitespawns( "attacker" );
    initbombsitespawns( "defender" );
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 1
// Checksum 0x0, Offset: 0xde4
// Size: 0xd7
function initbombsitespawns( side )
{
    level.assaultspawns[ side ] = [];
    spawnpointname = "mp_assault_spawn_" + side;
    spawnpoints = scripts\mp\spawnlogic::getspawnpointarray( spawnpointname );
    
    foreach ( point in spawnpoints )
    {
        pointlabel = point.script_noteworthy;
        
        if ( !isdefined( level.assaultspawns[ side ][ pointlabel ] ) )
        {
            level.assaultspawns[ side ][ pointlabel ] = [];
        }
        
        level.assaultspawns[ side ][ pointlabel ][ level.assaultspawns[ side ][ pointlabel ].size ] = point;
    }
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0xec3
// Size: 0xba
function getspawnpoint()
{
    myteam = self.pers[ "team" ];
    side = "defender";
    
    if ( myteam == game[ "attackers" ] )
    {
        side = "attacker";
    }
    
    if ( level.ingraceperiod )
    {
        spawnpoints = scripts\mp\spawnlogic::getspawnpointarray( "mp_assault_spawn_" + side + "_start" );
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint_startspawn( spawnpoints );
    }
    else
    {
        zonelabel = level.curobj.label;
        filteredspawnpoints = level.assaultspawns[ side ][ zonelabel ];
        spawnpoint = scripts\mp\spawnlogic::getspawnpoint_random( filteredspawnpoints );
    }
    
    return spawnpoint;
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 1
// Checksum 0x0, Offset: 0xf86
// Size: 0xea
function onspawnplayer( revivespawn )
{
    if ( scripts\cp_mp\utility\game_utility::isgameparticipant( self ) )
    {
        self.isplanting = 0;
        self.isdefusing = 0;
        self.isbombcarrier = 0;
    }
    
    if ( level.multibomb && self.pers[ "team" ] == game[ "attackers" ] )
    {
        self setclientomnvar( "ui_carrying_bomb", 1 );
    }
    else
    {
        self setclientomnvar( "ui_carrying_bomb", 0 );
    }
    
    setextrascore0( 0 );
    
    if ( isdefined( self.pers[ "plants" ] ) )
    {
        setextrascore0( self.pers[ "plants" ] );
    }
    
    level notify( "spawned_player" );
    setuppingwatcher();
    allowjump = getdvarint( @"hash_1e8e3ef72c5de769" );
    self allowhighjump( allowjump );
    self allowhighjump( allowjump );
    self allowboostjump( allowjump );
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 10
// Checksum 0x0, Offset: 0x1078
// Size: 0x68
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    self setclientomnvar( "ui_carrying_bomb", 0 );
    thread checkallowspectating();
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0x10e8
// Size: 0x89
function checkallowspectating()
{
    waitframe();
    update = 0;
    
    if ( !getteamdata( game[ "attackers" ], "aliveCount" ) )
    {
        level.spectateoverride[ game[ "attackers" ] ].allowenemyspectate = 1;
        update = 1;
    }
    
    if ( !getteamdata( game[ "defenders" ], "aliveCount" ) )
    {
        level.spectateoverride[ game[ "defenders" ] ].allowenemyspectate = 1;
        update = 1;
    }
    
    if ( update )
    {
        scripts\mp\spectating::updatespectatesettings();
    }
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 2
// Checksum 0x0, Offset: 0x1179
// Size: 0xe8
function sd_endgame( winningteam, endreasontext )
{
    foreach ( player in level.players )
    {
        if ( !isai( player ) )
        {
            player setclientomnvar( "ui_objective_pinned_text_param", 0 );
        }
    }
    
    level.finalkillcam_winner = winningteam;
    
    if ( endreasontext == game[ "end_reason" ][ "target_destroyed" ] || endreasontext == game[ "end_reason" ][ "bomb_defused" ] )
    {
        if ( !isdefined( level.finalkillcam_killcamentityindex[ winningteam ] ) || level.finalkillcam_killcamentityindex[ winningteam ] != level.curobj.killcamentnum )
        {
            scripts\mp\final_killcam::erasefinalkillcam();
        }
    }
    
    thread scripts\mp\gamelogic::endgame( winningteam, endreasontext );
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 6
// Checksum 0x0, Offset: 0x1269
// Size: 0x14b
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    score = scripts\mp\rank::getscoreinfovalue( #"kill" );
    assert( isdefined( score ) );
    team = victim.team;
    
    if ( victim.isplanting )
    {
        thread utility::trycall( level.matchdata_logvictimkillevent, lifeid, "planting" );
        attacker incpersstat( "defends", 1 );
        attacker scripts\mp\persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
        return;
    }
    
    if ( victim.isbombcarrier )
    {
        thread utility::trycall( level.matchdata_logvictimkillevent, lifeid, "carrying" );
        return;
    }
    
    if ( victim.isdefusing )
    {
        thread utility::trycall( level.matchdata_logvictimkillevent, lifeid, "defusing" );
        attacker incpersstat( "defends", 1 );
        attacker scripts\mp\persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
    }
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0x13bc
// Size: 0x8e
function ontimelimit()
{
    sd_endgame( game[ "defenders" ], game[ "end_reason" ][ "time_limit_reached" ] );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.bombplantweapon ) )
        {
            player _takeweapon( player.bombplantweapon );
            break;
        }
    }
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0x1452
// Size: 0x87
function updategametypedvars()
{
    scripts\mp\gametypes\common::updatecommongametypedvars();
    level.planttime = dvarfloatvalue( "planttime", 5, 0, 20 );
    level.defusetime = dvarfloatvalue( "defusetime", 5, 0, 20 );
    level.bombtimer = dvarfloatvalue( "bombtimer", 45, 1, 300 );
    level.multibomb = dvarintvalue( "multibomb", 0, 0, 1 );
    level.bombresettimer = dvarintvalue( "bombResetTimer", 60, 0, 180 );
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0x14e1
// Size: 0x4d
function setspecialloadout()
{
    if ( isusingmatchrulesdata() && getmatchrulesdatawithteamandindex( "defaultClasses", game[ "attackers" ], 5, "class", "inUse" ) )
    {
        level.sd_loadout[ game[ "attackers" ] ] = getmatchrulesspecialclass( game[ "attackers" ], 5 );
    }
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 1
// Checksum 0x0, Offset: 0x1536
// Size: 0x33
function isplayeroutsideofcurbombsite( weaponname )
{
    if ( isdefined( level.curbombzone ) )
    {
        return self istouching( level.curbombzone.trigger );
    }
    
    return 0;
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0x1572
// Size: 0x54
function initializeobjectives()
{
    level.firsttimebomb = 1;
    tempobjectives = getentarray( "bombzone", "targetname" );
    level.objectives = tempobjectives;
    level.curobjectiveindex = 0;
    level.curobj = setupnextobjective( level.curobjectiveindex );
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 1
// Checksum 0x0, Offset: 0x15ce
// Size: 0x103
function setupnextobjective( index )
{
    objectiveent = level.objectives[ index ];
    objectivetype = objectiveent.script_noteworthy;
    
    if ( !isdefined( objectivetype ) )
    {
        objectivetype = "bombzone";
    }
    
    objective = undefined;
    
    switch ( objectivetype )
    {
        case #"hash_a8ca4a84621810fb":
            if ( isdefined( level.firsttimebomb ) )
            {
                scripts\mp\gametypes\obj_bombzone::bombzone_setupbombcase( "sd_bomb" );
                level.firsttimebomb = undefined;
            }
            else
            {
                scripts\mp\gametypes\obj_bombzone::advancebombcase();
            }
            
            objective = scripts\mp\gametypes\obj_bombzone::setupobjective( index );
            scripts\mp\utility\dialog::leaderdialog( "offense_obj", game[ "attackers" ] );
            scripts\mp\utility\dialog::leaderdialog( "defense_obj", game[ "defenders" ] );
            break;
        case #"hash_55dd4aa166877663":
            objective = scripts\mp\gametypes\obj_dom::setupobjective( level.objectives[ index ] );
            break;
        case #"hash_c749446269c21985":
            break;
        case #"hash_1a5d186c17c00d3c":
            break;
    }
    
    return objective;
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 5
// Checksum 0x0, Offset: 0x16da
// Size: 0x107
function onobjectivecomplete( objectivetype, objectivelabel, creditplayer, creditteam, otherdata )
{
    switch ( objectivetype )
    {
        case #"hash_55dd4aa166877663":
            ondompointobjectivecomplete( objectivelabel, creditplayer, creditteam, otherdata );
            break;
        case #"hash_a8ca4a84621810fb":
            onbombzoneobjectivecomplete( objectivelabel, creditplayer, creditteam, otherdata );
            break;
    }
    
    if ( creditteam == game[ "attackers" ] )
    {
        level.curobjectiveindex++;
        
        if ( level.curobjectiveindex < level.objectives.size )
        {
            additionaltime = getwatcheddvar( "addObjectiveTime" );
            setoverridewatchdvar( "timelimit", gettimelimit() + additionaltime );
            restarttimer();
            level.curobj = setupnextobjective( level.curobjectiveindex );
            return;
        }
        
        setgameendtime( 0 );
        wait 3;
        sd_endgame( game[ "attackers" ], game[ "end_reason" ][ "target_destroyed" ] );
    }
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 4
// Checksum 0x0, Offset: 0x17e9
// Size: 0xac
function ondompointobjectivecomplete( objectivelabel, creditplayer, creditteam, oldteam )
{
    team = creditplayer.team;
    assert( team != "<dev string:x1c>" );
    
    if ( oldteam == "neutral" )
    {
        otherteam = getotherteam( team )[ 0 ];
        thread printandsoundoneveryone( team, otherteam, undefined, undefined, "mp_dom_flag_captured", undefined, creditplayer );
        scripts\mp\utility\dialog::statusdialog( "secured" + self.label, team, 1 );
        scripts\mp\utility\dialog::statusdialog( "lost_" + self.label, otherteam, 1 );
    }
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 4
// Checksum 0x0, Offset: 0x189d
// Size: 0x56
function onbombzoneobjectivecomplete( objectivelabel, creditplayer, creditteam, otherdata )
{
    if ( creditteam == game[ "defenders" ] )
    {
        restarttimer();
        thread scripts\mp\gametypes\obj_bombzone::respawnbombcase();
        level.curobj = scripts\mp\gametypes\obj_bombzone::setupobjective( level.curobjectiveindex );
    }
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0x18fb
// Size: 0x2b
function restarttimer()
{
    scripts\mp\gamelogic::resumetimer();
    level.timepaused = gettime() - level.timepausestart;
    level.timelimitoverride = 0;
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0x192e
// Size: 0x25
function setuppingwatcher()
{
    if ( isai( self ) )
    {
        return;
    }
    
    self notifyonplayercommand( "playerPing", "+breath_sprint" );
    thread waitforplayerping();
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0x195b
// Size: 0x50
function waitforplayerping()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "playerPing" );
        
        if ( isreallyalive( self ) && !isusingremote() )
        {
            if ( self adsbuttonpressed() )
            {
                doping();
                wait 0.5;
            }
        }
        
        wait 0.1;
    }
}

// Namespace assault / scripts\mp\gametypes\assault
// Params 0
// Checksum 0x0, Offset: 0x19b3
// Size: 0x1bb
function doping()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    tracestart = self geteye();
    traceend = tracestart + anglestoforward( self getplayerangles() ) * 2000;
    result = scripts\engine\trace::ray_trace( tracestart, traceend, self );
    hitent = result[ "entity" ];
    message = "WAYPOINT";
    messagecolor = ( 1, 1, 1 );
    
    if ( isdefined( hitent ) )
    {
        if ( isdefined( hitent.team ) && hitent.team != self.team )
        {
            messagecolor = ( 1, 0, 0 );
            
            if ( isplayer( hitent ) )
            {
                message = "KILL";
                self notify( "enemy_sighted" );
            }
            else
            {
                message = "DESTROY";
            }
        }
        else if ( isdefined( hitent.script_gameobjectname ) )
        {
            if ( hitent.script_gameobjectname == "bombzone" )
            {
                if ( self.team == game[ "attackers" ] )
                {
                    message = "ATTACK";
                    messagecolor = ( 1, 1, 0 );
                }
                else
                {
                    message = "DEFEND";
                    messagecolor = ( 0, 0, 1 );
                }
            }
            else if ( hitent.script_gameobjectname == "sd" )
            {
                if ( self.team == game[ "attackers" ] )
                {
                    message = "OBJECTIVE";
                    messagecolor = ( 1, 1, 0 );
                }
            }
        }
    }
    
    /#
        print3d( result[ "<dev string:x27>" ], message, messagecolor, 1, 1, 200 );
        sphere( result[ "<dev string:x27>" ], 2, messagecolor, 1, 200 );
    #/
}

