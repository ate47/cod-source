#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\killstreaks\manual_turret;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;

#namespace remote_turret;

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0xba1
// Size: 0x18
function autoexec main()
{
    registerkillstreakinitfunction( getxhash( "remote_turret" ), &init );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xbc1
// Size: 0x85
function private init()
{
    if ( issharedfuncdefined( "remote_turret", "init" ) )
    {
        [[ getsharedfunc( "remote_turret", "init" ) ]]();
    }
    
    if ( issharedfuncdefined( "remote_turret", "initSentrySettings" ) )
    {
        [[ getsharedfunc( "remote_turret", "initSentrySettings" ) ]]();
    }
    
    registervisibilityomnvarforkillstreak( "remote_turret", "on", 16 );
    
    /#
        setdevdvarifuninitialized( @"hash_c9bd691ce96079ac", 0 );
        setdevdvarifuninitialized( @"hash_e19e5d308effeda3", 1 );
    #/
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 3
// Checksum 0x0, Offset: 0xc4e
// Size: 0x28
function function_cf9f8b598647e363( streakinfo, switchresult, weaponobj )
{
    if ( !istrue( switchresult ) )
    {
        scripts\cp_mp\killstreaks\killstreakdeploy::getridofkillstreakdeployweapon( weaponobj );
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0xc7e
// Size: 0x25
function tryuseremoteturret( streakname )
{
    streakinfo = createstreakinfo( streakname, self );
    return function_c916c5b82db1290( streakinfo );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0xcac
// Size: 0x24e, Type: bool
function function_c916c5b82db1290( streakinfo )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            self.bgivensentry = 0;
            return false;
        }
    }
    
    scripts\cp_mp\utility\weapon_utility::saveweaponstates();
    endonnotify = "sentry_placement_failed";
    
    if ( issharedfuncdefined( "weapons", "watchForPlacementFireState" ) )
    {
        self thread [[ getsharedfunc( "weapons", "watchForPlacementFireState" ) ]]( streakinfo, endonnotify );
    }
    
    deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, makeweapon( "deploy_remote_turret_mp" ), 1, undefined, undefined, &function_cf9f8b598647e363 );
    
    if ( !istrue( deployresult ) )
    {
        self.bgivensentry = 0;
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            self.bgivensentry = 0;
            return false;
        }
    }
    
    turret = remoteturret_create( "remote_turret", streakinfo );
    
    if ( !isdefined( turret ) )
    {
        self.bgivensentry = 0;
        return false;
    }
    
    marker = remoteturret_watchplacement( turret, streakinfo, 0, 1.25 );
    
    if ( !isdefined( marker ) )
    {
        turret delete();
        self.bgivensentry = 0;
        return false;
    }
    
    turret scripts\cp_mp\emp_debuff::set_start_emp_callback( &remoteturret_empstarted );
    turret scripts\cp_mp\emp_debuff::set_clear_emp_callback( &remoteturret_empcleared );
    turret scripts\cp_mp\equipment\haywire::function_172d848d58051fdf( &function_cc47405c2cd435e );
    turret scripts\cp_mp\equipment\haywire::function_aa823a31304ed981( &function_fe21c57503ab070f );
    
    if ( issharedfuncdefined( "emp", "setEMP_Applied_Callback" ) )
    {
        turret [[ getsharedfunc( "emp", "setEMP_Applied_Callback" ) ]]( &function_371131da10a20bb );
    }
    
    if ( issharedfuncdefined( "emp", "setEMP_Cleared_Callback" ) )
    {
        turret [[ getsharedfunc( "emp", "setEMP_Cleared_Callback" ) ]]( &function_958fed8d4d1143fa );
    }
    
    turret function_a6f142a3e83c312e( self );
    turret function_e68434bdb941ed1e( turret.streakinfo.streakname, self, &"KILLSTREAKS_HINTS/REMOTE_TURRET_USE", 1 );
    turret.useobj setuseholdduration( 250 );
    remoteturret_setplaced( turret, marker );
    
    if ( issharedfuncdefined( "remote_turret", "munitionUsed" ) )
    {
        self [[ getsharedfunc( "remote_turret", "munitionUsed" ) ]]();
    }
    
    thread function_3da5b516d6b9a223( turret );
    self.remoteturretactive = 1;
    return true;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0xf03
// Size: 0x6a
function function_a6f142a3e83c312e( owner )
{
    if ( !isdefined( owner ) || !isdefined( owner.var_c112b4aeaf6ce9ae ) )
    {
        return;
    }
    
    if ( isdefined( owner.var_c112b4aeaf6ce9ae[ self.streakinfo.streakname ] ) )
    {
        owner.var_c112b4aeaf6ce9ae[ self.streakinfo.streakname ] delete();
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0xf75
// Size: 0x5b
function function_3da5b516d6b9a223( turret )
{
    self endon( "disconnect" );
    turret endon( "death" );
    
    while ( true )
    {
        waittill_2( "killstreakActionCalled", "super_started" );
        val::set( "remote_turret", "usability", 0 );
        wait 2;
        val::reset( "remote_turret", "usability" );
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 4
// Checksum 0x0, Offset: 0xfd8
// Size: 0x13b
function remoteturret_watchplacement( turret, streakinfo, ignorecancel, var_290b1442271ab369 )
{
    self.bgivensentry = 1;
    thread remoteturret_delayplacementinstructions( var_290b1442271ab369 );
    marker = undefined;
    
    if ( issharedfuncdefined( "remote_turret", "watchForPlayerEnteringLastStand" ) )
    {
        self thread [[ getsharedfunc( "remote_turret", "watchForPlayerEnteringLastStand" ) ]]();
    }
    
    if ( issharedfuncdefined( "remote_turret", "getTargetMarker" ) )
    {
        marker = self [[ getsharedfunc( "remote_turret", "getTargetMarker" ) ]]( streakinfo, ignorecancel );
    }
    
    self notify( "turret_placement_finished" );
    
    if ( !isdefined( marker ) || !isdefined( marker.location ) )
    {
        if ( scripts\cp_mp\utility\player_utility::_isalive() )
        {
            killstreak_switchbacklastweapon( "deploy_remote_turret_mp" );
        }
        
        return undefined;
    }
    
    turret thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire( self, 1, 1 );
    
    if ( self hasweapon( "deploy_remote_turret_mp" ) )
    {
        thread killstreak_switchbacklastweapon( "deploy_remote_turret_mp", 1, 1 );
    }
    
    delayspawntime = 0.85;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( delayspawntime );
    params = spawnstruct();
    params.player = self;
    callback::callback( "remote_turret_deployed", params );
    return marker;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x111c
// Size: 0x50
function remoteturret_delayplacementinstructions( delaytime )
{
    self endon( "death_or_disconnect" );
    self endon( "turret_placement_finished" );
    level endon( "game_ended" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( delaytime );
    self setclientomnvar( "ui_turret_placement", 1 );
    thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions( "death" );
    thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions( "turret_placement_finished" );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 2
// Checksum 0x0, Offset: 0x1174
// Size: 0x3f8
function remoteturret_create( turrettype, streakinfo )
{
    config = level.sentrysettings[ turrettype ];
    turret = spawnturret( "misc_turret", self.origin, level.sentrysettings[ turrettype ].weaponinfo );
    turret.owner = self;
    turret.team = self.team;
    turret.angles = self.angles;
    turret.health = 9999;
    turret.maxhealth = config.maxhealth;
    turret.streakinfo = streakinfo;
    turret.turrettype = turrettype;
    turret.shouldsplash = 1;
    turret.ammocount = config.ammo;
    turret.timeout = config.timeout;
    turret.var_de4dbbca9f355800 = 0;
    
    if ( issharedfuncdefined( "remote_turret", "attachXRays" ) )
    {
        turret = [[ getsharedfunc( "remote_turret", "attachXRays" ) ]]( turret );
    }
    
    /#
        var_2a98d1683cf44153 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_2a98d1683cf44153 )
        {
            turret.timeout = 9999;
        }
    #/
    
    if ( !isdefined( turret.timeout ) )
    {
        turret.timeout = 120;
    }
    
    turret.maxtimeout = turret.timeout;
    turret.carriedby = self;
    turret remoteturret_setturretmodel( "placed" );
    turret setturretowner( turret.owner );
    turret setturretteam( turret.team );
    turret makeunusable();
    turret setnodeploy( 1 );
    turret setdefaultdroppitch( 0 );
    turret hide();
    turret setautorotationdelay( 0.2 );
    turret.momentum = 0;
    turret.heatlevel = 0;
    turret.overheated = 0;
    turret.cooldownwaittime = 0.1;
    
    switch ( turrettype )
    {
        case #"hash_ab5712e297cd430e":
        default:
            turret setleftarc( 80 );
            turret setrightarc( 80 );
            turret setbottomarc( 50 );
            turret settoparc( 60 );
            turret setconvergencetime( 0.6, "pitch" );
            turret setconvergencetime( 0.6, "yaw" );
            turret setconvergenceheightpercent( 0.65 );
            turret setdefaultdroppitch( -89 );
            break;
    }
    
    turret setturretmodechangewait( 1 );
    turret scripts\cp_mp\emp_debuff::allow_emp( 0 );
    killcamforward = anglestoforward( turret.angles );
    killcampos = turret gettagorigin( "tag_barrel" ) + ( 0, 0, 10 );
    killcampos -= killcamforward * 20;
    killcament = spawn( "script_model", killcampos );
    killcament linkto( turret );
    turret.killcament = killcament;
    turret.colmodel = spawn( "script_model", turret.origin );
    turret.colmodel.team = turret.team;
    turret.colmodel.owner = turret.owner;
    turret.colmodel setmodel( "wm_jup_2h_remote_turret_00_invis_base" );
    turret.colmodel dontinterpolate();
    turret.colmodel hide();
    turret function_9553839f6b149375();
    return turret;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 2
// Checksum 0x0, Offset: 0x1575
// Size: 0x665
function remoteturret_setplaced( turret, marker )
{
    bundle = level.streakglobals.streakbundles[ "remote_turret" ];
    config = level.sentrysettings[ turret.turrettype ];
    turret remoteturret_setturretmodel( "placed" );
    
    if ( !isdefined( self.placedsentries ) )
    {
        self.placedsentries = [];
    }
    
    if ( !isdefined( self.placedsentries[ turret.turrettype ] ) )
    {
        self.placedsentries[ turret.turrettype ] = [];
    }
    
    if ( istrue( turret.shouldsplash ) )
    {
        if ( issharedfuncdefined( "sound", "playKillstreakDeployDialog" ) )
        {
            [[ getsharedfunc( "sound", "playKillstreakDeployDialog" ) ]]( self, turret.streakinfo.streakname );
        }
        
        splashname = config.teamsplash;
        
        if ( issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
        {
            level thread [[ getsharedfunc( "hud", "teamPlayerCardSplash" ) ]]( splashname, self );
        }
        
        turret.shouldsplash = 0;
    }
    
    turret show();
    turret dontinterpolate();
    turret.angles = marker.angles;
    turret.carriedby = undefined;
    
    if ( isdefined( marker.moving_platform ) )
    {
        turret.moving_platform = marker.moving_platform;
        turret.moving_platform_offset = marker.moving_platform_offset;
        turret.moving_platform_angles_offset = marker.moving_platform_angles_offset;
    }
    
    self.bgivensentry = 0;
    turret.origin = marker.location;
    turret setscriptablepartstate( "turret_carry_state", "turret_plant" );
    turret setscriptablepartstate( "lights", "daytime", 0 );
    turret.colmodel show();
    turret.colmodel.angles = turret.angles;
    turret.colmodel.origin = turret.origin;
    turret.colmodel linkto( turret );
    turreticon = bundle.minimapicon;
    
    if ( issharedfuncdefined( "game", "createObjective" ) )
    {
        turret.minimapid = turret.colmodel [[ getsharedfunc( "game", "createObjective" ) ]]( turreticon, turret.team, undefined, 1, 1 );
    }
    
    turretcount = self.placedsentries[ turret.turrettype ].size;
    
    if ( turretcount + 1 > 1 )
    {
        self.placedsentries[ turret.turrettype ][ 0 ] notify( "kill_turret", 0, 0 );
    }
    
    headiconoffset = 70;
    
    if ( issharedfuncdefined( "killstreak", "addToActiveKillstreakList" ) )
    {
        turret [[ getsharedfunc( "killstreak", "addToActiveKillstreakList" ) ]]( turret.turrettype, "Killstreak_Ground", self, 0, 1, headiconoffset, "carried" );
    }
    
    turret setmode( level.sentrysettings[ turret.turrettype ].sentrymodeon );
    hinttag = "tag_aim_pivot";
    hintpos = turret gettagorigin( hinttag );
    
    if ( !isdefined( turret.useownerobj ) )
    {
        if ( issharedfuncdefined( "remote_turret", "createHintObject" ) )
        {
            turret.useownerobj = [[ getsharedfunc( "remote_turret", "createHintObject" ) ]]( hintpos, "HINT_BUTTON", undefined, config.ownerusehintstring, undefined, undefined, "show" );
        }
    }
    else
    {
        hintpos = turret gettagorigin( hinttag );
        turret.useownerobj function_dfb78b3e724ad620( 1 );
        turret.useownerobj dontinterpolate();
        turret.useownerobj.origin = hintpos;
    }
    
    turret.useownerobj linkto( turret, hinttag );
    
    foreach ( guy in level.players )
    {
        if ( guy != turret.owner )
        {
            turret.useownerobj disableplayeruse( guy );
        }
    }
    
    if ( issharedfuncdefined( "remote_turret", "handleMovingPlatform" ) )
    {
        [[ getsharedfunc( "remote_turret", "handleMovingPlatform" ) ]]( turret );
    }
    
    turret scripts\cp_mp\emp_debuff::allow_emp( 1 );
    
    if ( issharedfuncdefined( "game", "registerSentient" ) )
    {
        turret [[ getsharedfunc( "game", "registerSentient" ) ]]( "Killstreak_Static", self );
    }
    
    if ( !istrue( turret.owner.ksempd ) )
    {
        turret remoteturret_empupdate();
        turret thread remoteturret_attacktargets( undefined, self );
    }
    
    /#
        turret thread function_1223f321ae6ff9a5();
    #/
    
    turret thread remoteturret_beepsounds();
    function_3650adfd6e0d1fb9( scripts\cp_mp\utility\killstreak_utility::function_13276a05f9b52006( "remote_turret" ) );
    function_ca5bd9a5609d8ba3();
    thread remoteturret_delaydeletemarker( turret, marker );
    thread remoteturret_watchpickup( turret );
    thread remoteturret_disableplayeruseonconnect( turret, turret.useownerobj );
    
    if ( !istrue( turret.owner.ksempd ) )
    {
        thread function_2bd5e2012f429ae3( turret );
    }
    
    thread remoteturret_watchownerdeath( turret );
    thread remoteturret_watchdamage( turret );
    thread remoteturret_watchdeath( turret );
    thread remoteturret_watchtimeout( turret );
    thread remoteturret_watchdisown( turret );
    thread remoteturret_watchgameend( turret );
    turret function_13a319439a116d2( self );
    turret.isplaced = 1;
    self.placedsentries[ turret.turrettype ][ turretcount ] = turret;
    turret notify( "turret_place_successful" );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x1be2
// Size: 0x50
function function_3650adfd6e0d1fb9( killstreakid )
{
    assertex( isdefined( killstreakid ), "remote_turret.gsc: Killstreak Use Widget tried to show without a killstreakID reference" );
    
    if ( killstreakid == 0 )
    {
        self setclientomnvar( "ui_killstreak_use_widget", killstreakid );
        self.parkedwidgetid = undefined;
        return;
    }
    
    self setclientomnvar( "ui_killstreak_use_widget", killstreakid );
    self.parkedwidgetid = killstreakid;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x1c3a
// Size: 0x1fa
function function_2bd5e2012f429ae3( turret )
{
    self endon( "remote_turret_empd" );
    self endon( "remote_turret_death" );
    turret endon( "kill_turret" );
    turret endon( "carried" );
    turret.useobj waittill( "trigger", player );
    
    if ( istrue( turret.isplaced ) && !istrue( turret.owner.ksempd ) )
    {
        self disableweaponswitch();
        
        if ( istrue( turret.isbarrelspinning ) )
        {
            turret stopbarrelspin();
            turret.isbarrelspinning = undefined;
        }
        
        val::set( "remote_turret", "allow_movement", 0 );
        val::set( "remote_turret", "usability", 0 );
        val::set( "remote_turret", "killstreaks", 0 );
        val::set( "remote_turret", "supers", 0 );
        val::set( "remote_turret", "reload", 0 );
        val::set( "remote_turret", "offhand_weapons", 0 );
        turret setscriptablepartstate( "turret_mode", "turret_mode_pre_manual" );
        turret remoteturret_spindown();
        turret thread remoteturret_burstfirestop();
        turret thread function_13a319439a116d2( self );
        thread function_ca5bd9a5609d8ba3();
        turret setmode( "sentry_offline" );
        turret notify( "enterRemote" );
        turret thread function_9cc5ca1b073338ab( self );
        remoteturret_deploytablet( turret );
        
        if ( !istrue( turret.var_de4dbbca9f355800 ) )
        {
            wait 2;
            turret.var_de4dbbca9f355800 = 1;
        }
        else
        {
            wait 1;
        }
        
        function_478f159eb6d02ae8( turret );
        turret.var_ce4dc6c1d56eb0a9 = 1;
        turret notify( "remote_enter" );
        turret setscriptablepartstate( "turret_mode", "turret_mode_manual" );
        turret setscriptablepartstate( "lights", "remoted", 0 );
        function_178aa80b91f36bf4();
        turret remoteturret_applyoverlay( self );
        self remotecontrolturret( turret );
        thread function_dc251dedf977c842( turret );
        val::reset( "remote_turret", "allow_movement" );
    }
}

#using_animtree( "script_model" );

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x1e3c
// Size: 0x87
function remoteturret_deploytablet( turret )
{
    weaponbasename = "ks_remote_device_mp";
    weaponobj = makeweapon( weaponbasename );
    deployanim = %vm_ks_tablet_tap_raise;
    _giveweapon( weaponobj, 0, 0, 1 );
    switchresult = domonitoredweaponswitch( weaponobj, 0 );
    scripts\cp_mp\utility\killstreak_utility::starttabletscreen( turret.streakinfo.streakname, 0 );
    function_178aa80b91f36bf4();
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x1ecb
// Size: 0xb8
function function_478f159eb6d02ae8( turret )
{
    if ( _isalive() )
    {
        turretmodepartstate = turret getscriptablepartstate( "turret_mode" );
        
        if ( turretmodepartstate == "turret_mode_manual" )
        {
            turret setscriptablepartstate( "turret_mode_fade", "turret_mode_manualtosentry_fadestart" );
        }
        else
        {
            turret setscriptablepartstate( "turret_mode_fade", "turret_mode_sentrytomanual_fadestart" );
        }
        
        level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer( self, 1, 0.3 );
        result = waittill_any_timeout_1( 0.7, "death" );
        
        if ( !isdefined( result ) || result == "death" )
        {
            turret scripts\common\utility::function_3677f2be30fdd581( "turret_mode_fade", "turret_mode_sentrytomanual_fadeinterrupted" );
        }
        
        level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer( self, 0, 0.3 );
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x1f8b
// Size: 0x144
function function_dc251dedf977c842( turret )
{
    self endon( "remote_turret_empd" );
    self endon( "remote_turret_death" );
    turret endon( "kill_turret" );
    turret endon( "remote_turret_ownerDeath" );
    turret endon( "carried" );
    childthread function_7317b5e0cedc533d( turret, 0.75 );
    self waittill( "remoteCamExit" );
    
    if ( istrue( turret.isplaced ) )
    {
        turret stopbarrelspin();
        function_478f159eb6d02ae8( turret );
        self remotecontrolturretoff( turret );
        turret setmode( "sentry" );
        turret.var_ce4dc6c1d56eb0a9 = undefined;
        turret notify( "remote_exit" );
        turret setscriptablepartstate( "turret_mode", "turret_mode_sentry" );
        turret setscriptablepartstate( "lights", "daytime", 0 );
        turret function_13a319439a116d2( self );
        turret remoteturret_removeoverlay( self );
        _switchtoweapon( self.primaryweaponobj );
        self enableweaponswitch();
        turret thread remoteturret_attacktargets( undefined, self );
        wait 1;
        val::reset( "remote_turret", "usability" );
        val::reset( "remote_turret", "killstreaks" );
        val::reset( "remote_turret", "supers" );
        val::reset( "remote_turret", "reload" );
        val::reset( "remote_turret", "offhand_weapons" );
        thread function_2bd5e2012f429ae3( turret );
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x20d7
// Size: 0x108
function private function_7317b5e0cedc533d( turret, overrideholdtime )
{
    if ( !isdefined( self ) || !isdefined( turret ) )
    {
        return;
    }
    
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "end_remote" );
    self endon( "monitoringExit" );
    turret endon( "death" );
    
    while ( self usebuttonpressed() )
    {
        waitframe();
    }
    
    holdtime = 0.75;
    
    if ( isdefined( overrideholdtime ) )
    {
        holdtime = overrideholdtime;
    }
    
    updaterate = level.framedurationseconds;
    timerdirty = 1;
    
    while ( true )
    {
        timeused = 0;
        
        if ( timerdirty == 1 )
        {
            self setclientomnvar( "ui_exit_progress", 0 );
            timerdirty = 0;
        }
        
        while ( self usebuttonpressed() )
        {
            if ( !self usinggamepad() && !self getuseholdkbmprofile() )
            {
                self notify( "remoteCamExit" );
                return;
            }
            
            timeused += updaterate;
            timerdirty = 1;
            self setclientomnvar( "ui_exit_progress", timeused / holdtime );
            
            if ( timeused > holdtime )
            {
                self notify( "remoteCamExit" );
                return;
            }
            
            wait updaterate;
        }
        
        wait updaterate;
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x21e7
// Size: 0x28e
function remoteturret_setcarried( turret )
{
    turret endon( "kill_turret" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( getcompleteweaponname( self getcurrentweapon() ) == "iw8_lm_dblmg_mp" )
    {
        self notify( "switched_from_minigun" );
        
        while ( getcompleteweaponname( self getcurrentweapon() ) == "iw8_lm_dblmg_mp" )
        {
            waitframe();
        }
    }
    
    if ( isdefined( turret.moving_platform ) )
    {
        turret.moving_platform = undefined;
        turret.moving_platform_offset = undefined;
        turret.moving_platform_angles_offset = undefined;
        turret unlink();
    }
    
    turret scripts\cp_mp\emp_debuff::allow_emp( 0 );
    
    if ( issharedfuncdefined( "game", "unregisterSentient" ) )
    {
        turret [[ getsharedfunc( "game", "unregisterSentient" ) ]]( turret.sentientpool, turret.sentientpoolindex );
    }
    
    linkedchildren = turret getlinkedchildren();
    
    foreach ( child in linkedchildren )
    {
        if ( isdefined( child ) )
        {
            child unlink();
        }
    }
    
    if ( isdefined( turret.minimapid ) )
    {
        if ( issharedfuncdefined( "game", "returnObjectiveID" ) )
        {
            [[ getsharedfunc( "game", "returnObjectiveID" ) ]]( turret.minimapid );
        }
        
        turret.minimapid = undefined;
    }
    
    turret.colmodel unlink();
    turret.colmodel hide();
    remoteturret_setinactive( turret );
    turret hide();
    turret.carriedby = self;
    turret notify( "carried" );
    self playsound( "kls_remote_turret_pickup" );
    turret setscriptablepartstate( "turret_carry_state", "turret_pickup" );
    turret function_9cc5ca1b073338ab( self );
    thread function_ca5bd9a5609d8ba3();
    scripts\cp_mp\utility\weapon_utility::saveweaponstates();
    endonnotify = "sentry_placement_failed";
    
    if ( issharedfuncdefined( "weapons", "watchForPlacementFireState" ) )
    {
        self thread [[ getsharedfunc( "weapons", "watchForPlacementFireState" ) ]]( turret.streakinfo, endonnotify );
    }
    
    _giveweapon( "deploy_remote_turret_mp" );
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon( "deploy_remote_turret_mp" );
    marker = remoteturret_watchplacement( turret, turret.streakinfo, 1, 2 );
    
    if ( !isdefined( marker ) )
    {
        return 0;
    }
    
    remoteturret_setplaced( turret, marker );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x247d
// Size: 0x3f
function remoteturret_switchbacklastweapon( immediateswitch )
{
    if ( istrue( immediateswitch ) )
    {
        _switchtoweaponimmediate( self.lastdroppableweaponobj );
    }
    else
    {
        _switchtoweapon( self.lastdroppableweaponobj );
    }
    
    _takeweapon( "deploy_remote_turret_mp" );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x24c4
// Size: 0x68
function remoteturret_setinactive( turret )
{
    turret.isplaced = undefined;
    turret setdefaultdroppitch( 30 );
    turret setmode( level.sentrysettings[ turret.turrettype ].sentrymodeoff );
    turret.useownerobj function_dfb78b3e724ad620( 0 );
    turret.useownerobj unlink();
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 2
// Checksum 0x0, Offset: 0x2534
// Size: 0x47
function remoteturret_delaydeletemarker( turret, marker )
{
    turret endon( "kill_turret" );
    level endon( "game_ended" );
    wait 0.25;
    
    if ( isdefined( marker.visual ) )
    {
        marker.visual delete();
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 2
// Checksum 0x0, Offset: 0x2583
// Size: 0x57
function remoteturret_disableplayeruseonconnect( turret, useobj )
{
    if ( isdefined( turret ) )
    {
        turret endon( "kill_turret" );
        turret endon( "carried" );
    }
    
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "connected", player );
        useobj disableplayeruse( player );
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x25e2
// Size: 0x122
function remoteturret_watchpickup( turret )
{
    turret endon( "kill_turret" );
    turret endon( "carried" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        turret.useownerobj waittill( "trigger", player );
        
        if ( player != turret.owner )
        {
            continue;
        }
        
        if ( issharedfuncdefined( "remote_turret", "allowPickupOfTurret" ) )
        {
            if ( !player [[ getsharedfunc( "remote_turret", "allowPickupOfTurret" ) ]]() )
            {
                continue;
            }
        }
        
        turret.useownerobj function_dfb78b3e724ad620( 0 );
        turret setmode( level.sentrysettings[ turret.turrettype ].sentrymodeoff );
        turret.owner.placedsentries[ turret.turrettype ] = array_remove( turret.owner.placedsentries[ turret.turrettype ], turret );
        turret.owner thread remoteturret_setcarried( turret );
        waitframe();
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x270c
// Size: 0x5c
function remoteturret_disableplayerpickuponconnect( turret )
{
    turret endon( "kill_turret" );
    turret endon( "carried" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "connected", player );
        player waittill( "spawned_player" );
        turret.useownerobj disableplayeruse( player );
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x2770
// Size: 0xd6
function remoteturret_watchdismantle( turret )
{
    turret endon( "kill_turret" );
    turret endon( "carried" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    foreach ( player in level.players )
    {
        if ( level.teambased )
        {
            if ( player.team != self.team )
            {
                continue;
            }
            
            continue;
        }
        
        if ( player != self )
        {
        }
    }
    
    thread remoteturret_disableplayerdismantleonconnect( turret );
    
    while ( true )
    {
        turret.dismantleobj waittill( "trigger", player );
        turret notify( "kill_turret", 0, 1 );
        break;
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x284e
// Size: 0x4f
function remoteturret_watchdamage( turret )
{
    turret endon( "kill_turret" );
    turret endon( "carried" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    if ( issharedfuncdefined( "remote_turret", "monitorDamage" ) )
    {
        self [[ getsharedfunc( "remote_turret", "monitorDamage" ) ]]( turret );
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x28a5
// Size: 0x71
function remoteturret_disableplayerdismantleonconnect( turret )
{
    turret endon( "kill_turret" );
    turret endon( "carried" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "connected", player );
        player waittill( "spawned_player" );
        
        if ( level.teambased )
        {
            if ( player.team != self.team )
            {
                continue;
            }
        }
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x291e
// Size: 0x7f
function remoteturret_empstarted( data )
{
    if ( isdefined( data.attacker ) )
    {
        if ( issharedfuncdefined( "player", "doScoreEvent" ) )
        {
            data.attacker thread [[ getsharedfunc( "player", "doScoreEvent" ) ]]( "disabled_sentry_gun" );
        }
        
        if ( issharedfuncdefined( "remote_turret", "empStarted" ) )
        {
            self [[ getsharedfunc( "remote_turret", "empStarted" ) ]]();
        }
    }
    
    remoteturret_empupdate();
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x29a5
// Size: 0x3e
function remoteturret_empcleared( isdeath )
{
    if ( isdeath )
    {
        return;
    }
    
    if ( issharedfuncdefined( "remote_turret", "empStarted" ) )
    {
        self [[ getsharedfunc( "remote_turret", "empCleared" ) ]]();
    }
    
    remoteturret_empupdate();
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x29eb
// Size: 0x232
function function_371131da10a20bb( data )
{
    if ( isdefined( data.attacker ) )
    {
        if ( issharedfuncdefined( "player", "doScoreEvent" ) )
        {
            data.attacker thread [[ getsharedfunc( "player", "doScoreEvent" ) ]]( "disabled_sentry_gun" );
        }
        
        if ( issharedfuncdefined( "remote_turret", "empStarted" ) )
        {
            self [[ getsharedfunc( "remote_turret", "empStarted" ) ]]();
        }
    }
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj disableplayeruse( self.useobj.owner );
        self.useobj.activeuseobject = 0;
    }
    
    self.owner notify( "stopSentryFire" );
    self.owner notify( "remote_turret_empd" );
    
    if ( istrue( self.isbarrelspinning ) )
    {
        self stopbarrelspin();
        self.isbarrelspinning = undefined;
    }
    
    self setmode( "sentry_offline" );
    self setscriptablepartstate( "turret_mode", "turret_mode_sentry" );
    
    if ( istrue( self.var_ce4dc6c1d56eb0a9 ) )
    {
        self.owner remotecontrolturretoff( self );
        self.var_ce4dc6c1d56eb0a9 = undefined;
        self notify( "remote_exit" );
        self setscriptablepartstate( "lights", "daytime", 0 );
        function_9cc5ca1b073338ab( self.owner );
        remoteturret_removeoverlay( self.owner );
        self.owner _switchtoweapon( self.owner.primaryweaponobj );
        self.owner enableweaponswitch();
        wait 1;
        self.owner val::reset( "remote_turret", "usability" );
        self.owner val::reset( "remote_turret", "killstreaks" );
        self.owner val::reset( "remote_turret", "supers" );
        self.owner val::reset( "remote_turret", "reload" );
        self.owner val::reset( "remote_turret", "offhand_weapons" );
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x2c25
// Size: 0xb4
function function_958fed8d4d1143fa( data )
{
    if ( issharedfuncdefined( "remote_turret", "empStarted" ) )
    {
        self [[ getsharedfunc( "remote_turret", "empCleared" ) ]]();
    }
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj enableplayeruse( self.useobj.owner );
        self.useobj.activeuseobject = 1;
    }
    
    if ( istrue( self.isplaced ) )
    {
        self setmode( "sentry" );
        self.owner thread function_2bd5e2012f429ae3( self );
        thread remoteturret_attacktargets( undefined, self.owner );
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x2ce1
// Size: 0x1f7
function function_cc47405c2cd435e( data )
{
    if ( !istrue( self.ishaywire ) )
    {
        self.ishaywire = 1;
        
        if ( isdefined( data.attacker ) )
        {
            if ( issharedfuncdefined( "remote_turret", "empStarted" ) )
            {
                self [[ getsharedfunc( "remote_turret", "empStarted" ) ]]();
            }
        }
        
        if ( isdefined( self.useobj ) )
        {
            self.useobj disableplayeruse( self.useobj.owner );
            self.useobj.activeuseobject = 0;
        }
        
        self.owner notify( "remote_turret_empd" );
        self setscriptablepartstate( "turret_mode", "turret_mode_sentry" );
        
        if ( istrue( self.var_ce4dc6c1d56eb0a9 ) )
        {
            self.owner remotecontrolturretoff( self );
            self setmode( "sentry" );
            self.var_ce4dc6c1d56eb0a9 = undefined;
            self notify( "remote_exit" );
            self setscriptablepartstate( "lights", "daytime", 0 );
            function_13a319439a116d2( self.owner );
            remoteturret_removeoverlay( self.owner );
            self.owner _switchtoweapon( self.owner.primaryweaponobj );
            self.owner enableweaponswitch();
            thread remoteturret_attacktargets( undefined, self.owner );
            wait 1;
            self.owner val::reset( "remote_turret", "usability" );
            self.owner val::reset( "remote_turret", "killstreaks" );
            self.owner val::reset( "remote_turret", "supers" );
            self.owner val::reset( "remote_turret", "reload" );
            self.owner val::reset( "remote_turret", "offhand_weapons" );
        }
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x2ee0
// Size: 0xa0
function function_fe21c57503ab070f( data )
{
    if ( issharedfuncdefined( "remote_turret", "empStarted" ) )
    {
        self [[ getsharedfunc( "remote_turret", "empCleared" ) ]]();
    }
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj enableplayeruse( self.useobj.owner );
        self.useobj.activeuseobject = 1;
    }
    
    if ( istrue( self.isplaced ) )
    {
        self.owner thread function_2bd5e2012f429ae3( self );
    }
    
    self.ishaywire = undefined;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x2f88
// Size: 0x64
function remoteturret_empupdate()
{
    if ( scripts\cp_mp\emp_debuff::is_empd() )
    {
        self turretfiredisable();
        self setmode( level.sentrysettings[ self.turrettype ].sentrymodeoff );
        return;
    }
    
    self turretfireenable();
    self setmode( level.sentrysettings[ self.turrettype ].sentrymodeon );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x2ff4
// Size: 0x140
function remoteturret_watchownerdeath( turret )
{
    turret endon( "death" );
    turret endon( "carried" );
    
    while ( true )
    {
        if ( !_isalive() )
        {
            if ( istrue( turret.var_ce4dc6c1d56eb0a9 ) && istrue( turret.isplaced ) )
            {
                turret notify( "remote_turret_ownerDeath" );
                self remotecontrolturretoff( turret );
                turret setmode( "sentry" );
                turret.var_ce4dc6c1d56eb0a9 = undefined;
                turret notify( "remote_exit" );
                turret.overheated = 0;
                turret setscriptablepartstate( "turret_mode", "turret_mode_sentry" );
                turret setscriptablepartstate( "lights", "daytime", 0 );
                turret function_13a319439a116d2( self );
                turret remoteturret_removeoverlay( self );
                _switchtoweapon( self.primaryweaponobj );
                self enableweaponswitch();
                val::reset( "remote_turret", "usability" );
                val::reset( "remote_turret", "killstreaks" );
                val::reset( "remote_turret", "supers" );
                val::reset( "remote_turret", "reload" );
                val::reset( "remote_turret", "offhand_weapons" );
                turret thread remoteturret_attacktargets( undefined, self );
                thread function_2bd5e2012f429ae3( turret );
            }
        }
        
        wait 0.1;
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x313c
// Size: 0x35a
function remoteturret_watchdeath( turret )
{
    turret endon( "carried" );
    turret waittill( "kill_turret", skipshutdown, wasdestroyed );
    turret notify( "remote_turret_death" );
    waitframe();
    self.remoteturretactive = undefined;
    
    if ( istrue( turret.var_ce4dc6c1d56eb0a9 ) )
    {
        turret remoteturret_removeoverlay( self );
        self remotecontrolturretoff( turret );
        turret.var_ce4dc6c1d56eb0a9 = undefined;
        turret notify( "remote_exit" );
        turret.overheated = 0;
        turret setscriptablepartstate( "turret_mode", "turret_mode_sentry" );
        turret setscriptablepartstate( "lights", "daytime", 0 );
        _switchtoweapon( self.primaryweaponobj );
        self enableweaponswitch();
        val::reset( "remote_turret", "usability" );
        val::reset( "remote_turret", "killstreaks" );
        val::reset( "remote_turret", "supers" );
        val::reset( "remote_turret", "reload" );
        val::reset( "remote_turret", "offhand_weapons" );
    }
    
    if ( isdefined( self ) )
    {
        self.placedsentries[ turret.turrettype ] = array_remove( self.placedsentries[ turret.turrettype ], turret );
        remoteturret_setinactive( turret );
        turret thread function_9cc5ca1b073338ab( self );
        function_3650adfd6e0d1fb9( 0 );
        
        if ( issharedfuncdefined( "player", "printGameAction" ) )
        {
            self [[ getsharedfunc( "player", "printGameAction" ) ]]( "killstreak ended - manual_turret", self );
        }
        
        turret.streakinfo.expiredbydeath = istrue( wasdestroyed );
        scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats( turret.streakinfo );
    }
    
    if ( istrue( wasdestroyed ) )
    {
        playkillstreakteamleaderdialog( turret.streakinfo.streakname, turret.streakinfo.streakname + "_teamleader_destroyed" );
    }
    
    turret remoteturret_setturretmodel( "destroyed" );
    turret setturretowner( undefined );
    
    if ( !istrue( skipshutdown ) )
    {
        turret setscriptablepartstate( "shutdown", "on" );
        turret setscriptablepartstate( "turret_carry_state", "off" );
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( 2 );
        turret setscriptablepartstate( "explode", "regular" );
    }
    else
    {
        turret setscriptablepartstate( "explode", "violent" );
    }
    
    level callback::callback( "killstreak_finish_use", { #streakinfo:turret.streakinfo } );
    
    if ( isdefined( turret.killcament ) )
    {
        turret.killcament delete();
    }
    
    if ( isdefined( turret.useownerobj ) )
    {
        turret.useownerobj delete();
    }
    
    if ( isdefined( turret.useotherobj ) )
    {
        turret.useotherobj delete();
    }
    
    if ( isdefined( turret.colmodel ) )
    {
        turret.colmodel delete();
    }
    
    if ( isdefined( turret.minimapid ) )
    {
        if ( issharedfuncdefined( "game", "returnObjectiveID" ) )
        {
            [[ getsharedfunc( "game", "returnObjectiveID" ) ]]( turret.minimapid );
        }
        
        turret.minimapid = undefined;
    }
    
    wait 0.2;
    turret delete();
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x349e
// Size: 0x19
function remoteturret_delayscriptabledelete()
{
    level endon( "game_ended" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( 5 );
    self delete();
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x34bf
// Size: 0xfc
function remoteturret_watchtimeout( turret )
{
    turret endon( "kill_turret" );
    turret endon( "carried" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( turret.timeout > 0 )
    {
        if ( istrue( turret.isbarrelspinning ) )
        {
            turret stopbarrelspin();
            turret.isbarrelspinning = undefined;
        }
        
        timeoutpercentage = int( 100 * turret.timeout / turret.maxtimeout );
        self setclientomnvar( "ui_killstreak_countdown", timeoutpercentage );
        turret.timeout -= 0.05;
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( 0.05 );
    }
    
    playkillstreakteamleaderdialog( turret.streakinfo.streakname, turret.streakinfo.streakname + "_teamleader_timeout" );
    turret notify( "kill_turret", 0, 0 );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x35c3
// Size: 0x39
function remoteturret_watchdisown( turret )
{
    turret endon( "kill_turret" );
    turret endon( "carried" );
    waittill_any_3( "disconnect", "joined_team", "joined_spectators" );
    turret notify( "kill_turret", 0, 0 );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x3604
// Size: 0x2b
function remoteturret_watchgameend( turret )
{
    turret endon( "kill_turret" );
    turret endon( "carried" );
    level waittill( "game_ended" );
    turret notify( "kill_turret", 0, 0 );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x3637
// Size: 0xa3
function remoteturret_setturretmodel( type )
{
    turretmodel = undefined;
    
    if ( type == "placed" )
    {
        turretmodel = level.sentrysettings[ self.turrettype ].modelbaseground;
    }
    else
    {
        turretmodel = level.sentrysettings[ self.turrettype ].modeldestroyedground;
    }
    
    /#
        modeltype = getdvarint( @"hash_e19e5d308effeda3", 1 );
        
        if ( !modeltype )
        {
            turretmodel = "<dev string:x1c>";
        }
    #/
    
    assertex( isdefined( turretmodel ), "For some reason turretModel is not defined, this should never happen" );
    self setmodel( turretmodel );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 2
// Checksum 0x0, Offset: 0x36e2
// Size: 0xf1
function remoteturret_attacktargets( configoverride, player )
{
    /#
        self.owner endon( "<dev string:x37>" );
    #/
    
    self endon( "kill_turret" );
    self endon( "carried" );
    self endon( "enterRemote" );
    self.owner endon( "stopSentryFire" );
    level endon( "game_ended" );
    self.momentum = 0;
    self.heatlevel = 0;
    self.overheated = 0;
    thread turret_heatmonitor();
    thread turret_coolmonitor();
    
    while ( true )
    {
        self waittill( "turretstatechange" );
        
        if ( self isfiringturret() )
        {
            player thread function_57bec1aaf3404bf6();
            thread function_f38fae4f6dd4b035( player );
            thread remoteturret_burstfirestart( configoverride );
            continue;
        }
        
        self.heatlevel = 0;
        remoteturret_spindown();
        thread remoteturret_burstfirestop();
        thread function_13a319439a116d2( player );
        player thread function_ca5bd9a5609d8ba3();
        self setscriptablepartstate( "turret_target_found", "off" );
    }
}

/#

    // Namespace remote_turret / scripts\killstreaks\remote_turret
    // Params 1
    // Checksum 0x0, Offset: 0x37db
    // Size: 0x266, Type: dev
    function function_1223f321ae6ff9a5( configoverride )
    {
        self endon( "<dev string:x4e>" );
        self endon( "<dev string:x5a>" );
        level endon( "<dev string:x62>" );
        self.turrettarget = spawn( "<dev string:x6d>", self gettagorigin( "<dev string:x7a>" ) + anglestoforward( self gettagangles( "<dev string:x7a>" ) * 300 ) );
        self.turrettarget.targeton = 0;
        self.turrettarget dontinterpolate();
        self.turrettarget thread function_8ffe5560e2df8a72( self );
        self.turrettarget thread function_818d215a79eecafe( self );
        turretconfig = undefined;
        
        if ( isdefined( configoverride ) )
        {
            turretconfig = configoverride;
        }
        else
        {
            turretconfig = level.sentrysettings[ self.turrettype ];
        }
        
        sentrymode = turretconfig.sentrymodeon;
        manualmode = "<dev string:x84>";
        turretmode = sentrymode;
        notifyon = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_c9bd691ce96079ac", 0 ) == 1 )
            {
                if ( !istrue( notifyon ) )
                {
                    self.owner notifyonplayercommand( "<dev string:x37>", "<dev string:x92>" );
                    notifyon = 1;
                }
                
                self.owner waittill( "<dev string:x37>" );
                
                if ( turretmode != manualmode )
                {
                    self setmode( manualmode );
                    turretmode = manualmode;
                    starttrace = self.owner getvieworigin();
                    endtrace = starttrace + anglestoforward( self.owner getplayerangles() ) * 50000;
                    trace = scripts\engine\trace::ray_trace( starttrace, endtrace, self.owner );
                    endpos = undefined;
                    
                    if ( isdefined( trace[ "<dev string:x9f>" ] ) && trace[ "<dev string:x9f>" ] != "<dev string:xa7>" )
                    {
                        endpos = trace[ "<dev string:xb4>" ];
                    }
                    
                    if ( isdefined( endpos ) )
                    {
                        thread function_ee5cbfd60227d0b8( endpos );
                    }
                }
                else
                {
                    function_c151e4a17d929b78();
                    turretmode = sentrymode;
                    self setmode( turretmode );
                    thread remoteturret_attacktargets();
                }
                
                continue;
            }
            
            notifyon = 0;
            
            if ( turretmode != sentrymode )
            {
                self.owner notifyonplayercommandremove( "<dev string:x37>", "<dev string:x92>" );
                function_c151e4a17d929b78();
                turretmode = sentrymode;
                self setmode( turretmode );
                thread remoteturret_attacktargets();
            }
            
            waitframe();
        }
    }

    // Namespace remote_turret / scripts\killstreaks\remote_turret
    // Params 1
    // Checksum 0x0, Offset: 0x3a49
    // Size: 0x1a5, Type: dev
    function function_ee5cbfd60227d0b8( firepos )
    {
        self.owner endon( "<dev string:xbd>" );
        self.owner endon( "<dev string:x37>" );
        self endon( "<dev string:x4e>" );
        self endon( "<dev string:x5a>" );
        level endon( "<dev string:x62>" );
        thread remoteturret_burstfirestop();
        self.turrettarget.origin = firepos;
        self settargetentity( self.turrettarget );
        self.turrettarget.targeton = 1;
        starttag = "<dev string:xd0>";
        
        if ( self.streakinfo.streakname == "<dev string:xe1>" )
        {
            starttag = "<dev string:xec>";
        }
        
        endtag = "<dev string:x7a>";
        wait 1;
        
        while ( true )
        {
            var_30c9c9336ef2caaf = self gettagorigin( starttag );
            var_831cc1b8f4225351 = self gettagangles( starttag );
            thread drawsphere( var_30c9c9336ef2caaf, 2, 1, ( 0, 1, 1 ) );
            thread drawline( var_30c9c9336ef2caaf, var_30c9c9336ef2caaf + anglestoforward( var_831cc1b8f4225351 ) * 1800, 1, ( 0, 1, 1 ) );
            flashtagorigin = self gettagorigin( endtag );
            flashtagangles = self gettagangles( endtag );
            thread drawsphere( flashtagorigin, 2, 1, ( 1, 1, 0 ) );
            thread drawline( flashtagorigin, flashtagorigin + anglestoforward( flashtagangles ) * 1800, 1, ( 1, 1, 0 ) );
            remoteturret_burstfirestart( undefined, undefined, 1 );
            wait 1;
        }
    }

    // Namespace remote_turret / scripts\killstreaks\remote_turret
    // Params 0
    // Checksum 0x0, Offset: 0x3bf6
    // Size: 0x39, Type: dev
    function function_c151e4a17d929b78()
    {
        self cleartargetentity();
        thread remoteturret_burstfirestop();
        self.turrettarget.targeton = 0;
        self.owner notify( "<dev string:xbd>" );
    }

    // Namespace remote_turret / scripts\killstreaks\remote_turret
    // Params 1
    // Checksum 0x0, Offset: 0x3c37
    // Size: 0x61, Type: dev
    function function_8ffe5560e2df8a72( turret )
    {
        turret endon( "<dev string:x4e>" );
        turret endon( "<dev string:x5a>" );
        self endon( "<dev string:xff>" );
        level endon( "<dev string:x62>" );
        
        while ( true )
        {
            if ( istrue( self.targeton ) )
            {
                sphere( self.origin, 20, ( 1, 1, 0 ), 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace remote_turret / scripts\killstreaks\remote_turret
    // Params 1
    // Checksum 0x0, Offset: 0x3ca0
    // Size: 0x39, Type: dev
    function function_818d215a79eecafe( turret )
    {
        turret endon( "<dev string:x4e>" );
        turret endon( "<dev string:x5a>" );
        self endon( "<dev string:xff>" );
        level endon( "<dev string:x62>" );
        turret waittill( "<dev string:xff>" );
        self delete();
    }

#/

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x3ce1
// Size: 0x1a
function remoteturret_targetlocksound()
{
    self endon( "death" );
    self setscriptablepartstate( "turret_target_found", "target_found" );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x3d03
// Size: 0x6b
function remoteturret_spinup( configoverride )
{
    if ( !istrue( self.isbarrelspinning ) )
    {
        self startbarrelspin();
        self.isbarrelspinning = 1;
    }
    
    while ( self.momentum < configoverride.spinuptime )
    {
        self.momentum += 0.1;
        wait 0.1;
    }
    
    thread remoteturret_targetlocksound();
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x3d76
// Size: 0x2a
function remoteturret_spindown()
{
    self.momentum = 0;
    
    if ( istrue( self.isbarrelspinning ) )
    {
        self stopbarrelspin();
        self.isbarrelspinning = undefined;
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 3
// Checksum 0x0, Offset: 0x3da8
// Size: 0x189
function remoteturret_burstfirestart( configoverride, maxroundsoverride, var_7a4f7bd11952e7bc )
{
    self endon( "death" );
    self endon( "kill_turret" );
    self endon( "carried" );
    self endon( "enterRemote" );
    self endon( "stop_shooting" );
    self.owner endon( "stopSentryFire" );
    level endon( "game_ended" );
    turretconfig = undefined;
    
    if ( isdefined( configoverride ) )
    {
        turretconfig = configoverride;
    }
    else
    {
        turretconfig = level.sentrysettings[ self.turrettype ];
    }
    
    remoteturret_spinup( turretconfig );
    firetime = weaponfiretime( turretconfig.weaponinfo );
    minshots = turretconfig.burstmin;
    maxshots = turretconfig.burstmax;
    minpause = turretconfig.pausemin;
    maxpause = turretconfig.pausemax;
    lockstrength = turretconfig.lockstrength;
    
    while ( true )
    {
        numshots = randomintrange( minshots, maxshots + 1 );
        
        if ( isdefined( maxroundsoverride ) )
        {
            numshots = maxroundsoverride;
        }
        
        for ( i = 0; i < numshots ; i++ )
        {
            self shootturret( "tag_flash", lockstrength );
            self.streakinfo.shots_fired++;
            wait firetime;
        }
        
        if ( istrue( var_7a4f7bd11952e7bc ) )
        {
            break;
        }
        
        wait randomfloatrange( minpause, maxpause );
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x3f39
// Size: 0xa
function remoteturret_burstfirestop()
{
    self notify( "stop_shooting" );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x3f4b
// Size: 0x4a
function function_7bd876f944b5caf3()
{
    self endon( "death" );
    self endon( "kill_turret" );
    self endon( "carried" );
    level endon( "game_ended" );
    
    while ( true )
    {
        if ( istrue( self.overheated ) )
        {
        }
        else if ( self.heatlevel > 0 )
        {
        }
        
        wait 0.1;
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x3f9d
// Size: 0x9f
function turret_heatmonitor()
{
    /#
        self.owner endon( "<dev string:x37>" );
    #/
    
    self endon( "kill_turret" );
    self endon( "carried" );
    level endon( "game_ended" );
    overheattime = level.sentrysettings[ self.turrettype ].overheattime;
    
    while ( true )
    {
        if ( self.heatlevel > overheattime )
        {
            self.overheated = 1;
            
            while ( self.heatlevel )
            {
                wait 0.1;
            }
            
            self.overheated = 0;
            self notify( "not_overheated" );
        }
        
        wait 0.05;
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x4044
// Size: 0x5e
function playheatfx()
{
    self endon( "death" );
    self endon( "not_overheated" );
    level endon( "game_ended" );
    self notify( "playing_heat_fx" );
    self endon( "playing_heat_fx" );
    
    for ( ;; )
    {
        playfxontag( getfx( "sentry_overheat_mp" ), self, "tag_flash" );
        wait level.sentrysettings[ self.turrettype ].fxtime;
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x40aa
// Size: 0x92
function turret_coolmonitor()
{
    /#
        self.owner endon( "<dev string:x37>" );
    #/
    
    self endon( "kill_turret" );
    self endon( "carried" );
    level endon( "game_ended" );
    
    while ( true )
    {
        if ( self.heatlevel > 0 )
        {
            if ( self.cooldownwaittime <= 0 )
            {
                self.heatlevel = max( 0, self.heatlevel - 0.05 );
            }
            else
            {
                self.cooldownwaittime = max( 0, self.cooldownwaittime - 0.05 );
            }
        }
        
        wait 0.05;
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x4144
// Size: 0x39
function remoteturret_beepsounds()
{
    self endon( "death" );
    self endon( "carried" );
    self endon( "kill_turret" );
    level endon( "game_ended" );
    
    while ( true )
    {
        wait 3;
        
        if ( self isfiringturret() )
        {
            waitframe();
            continue;
        }
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x4185
// Size: 0x226
function function_1baea357653599af()
{
    level endon( "game_ended" );
    self.owner endon( "disconnect" );
    self endon( "death" );
    self endon( "entering" );
    
    while ( true )
    {
        function_62a0eac6f83f3455();
        
        foreach ( targetarray in level.var_e725f44030790232 function_df633f460888a47( self.origin ) )
        {
            foreach ( ent in targetarray )
            {
                if ( !isdefined( ent ) )
                {
                    continue;
                }
                
                if ( isplayer( ent ) || isbot( ent ) )
                {
                    if ( issharedfuncdefined( "player", "isReallyAlive" ) )
                    {
                        if ( ![[ getsharedfunc( "player", "isReallyAlive" ) ]]( ent ) )
                        {
                            continue;
                        }
                    }
                }
                
                if ( isagent( ent ) && !isalive( ent ) )
                {
                    continue;
                }
                
                if ( level.teambased )
                {
                    if ( isdefined( ent.team ) && ent.team == self.ownerteam )
                    {
                        continue;
                    }
                }
                else if ( ent == self.owner )
                {
                    continue;
                }
                
                if ( scripts\cp_mp\emp_debuff::is_empd() )
                {
                    continue;
                }
                
                targetinfo = function_a8c3018671379cee( ent );
                
                if ( !targetinfo.isinrange || !targetinfo.isvisible || !targetinfo.isindetectrange || !targetinfo.var_9ae205c4c40af967 )
                {
                    continue;
                }
                
                if ( self.owner function_d326d254331ad16b( ent ) )
                {
                    continue;
                }
                
                if ( istrue( self.markingtarget ) )
                {
                    continue;
                }
                
                params = function_1a5c1f370962e7bc( self.cameratype );
                function_b25c3111cbbcee44( ent, 3, "super_tac_camera" );
            }
        }
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x43b3
// Size: 0x2b
function function_62a0eac6f83f3455()
{
    if ( isdefined( level.var_e725f44030790232 ) )
    {
        return;
    }
    
    level.var_e725f44030790232 = create_partition( level.characters, 1575 );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x43e6
// Size: 0x75
function function_a8c3018671379cee( target )
{
    info = spawnstruct();
    info.isvisible = function_a13b737dd0cea460( target );
    info.var_9ae205c4c40af967 = function_f232be2b19471805( target );
    info.isinrange = remoteturret_isinmarkingrange( target );
    info.isindetectrange = remoteturret_isindetectrange( target );
    
    if ( isdefined( self.pilot ) )
    {
    }
    
    return info;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x4464
// Size: 0x22e
function private remoteturret_istargetinreticle( scantarget, scanfov, var_5e43b44751d01b1a )
{
    if ( !isdefined( scantarget ) )
    {
        return 0;
    }
    
    inreticle = 0;
    targetorigin = scantarget.origin;
    scanpoints = [ targetorigin ];
    var_c3d9e0b30c6f14a4 = distancesquared( self getvieworigin(), scantarget.origin );
    isusingextrapoints = 0;
    
    if ( var_c3d9e0b30c6f14a4 <= 2 )
    {
        var_5e43b44751d01b1a *= getdvarfloat( @"hash_20c9852b3129de04", 2.5 );
        isusingextrapoints = 1;
    }
    
    if ( isplayer( scantarget ) )
    {
        istargethanging = scantarget ishanging();
        headpos = scantarget scripts\cp_mp\utility\player_utility::getstancetop();
        centerpos = scantarget scripts\cp_mp\utility\player_utility::getstancecenter();
        scanpoints = [ headpos, centerpos ];
        
        if ( !istargethanging )
        {
            scanpoints = array_add( scanpoints, targetorigin );
        }
        
        if ( isusingextrapoints )
        {
            var_102502c44898b35c = ( headpos + centerpos ) / 2;
            extrapoints = [ var_102502c44898b35c ];
            
            if ( !istargethanging )
            {
                var_264b006395220d6 = ( centerpos + targetorigin ) / 2;
                extrapoints = array_add( extrapoints, var_264b006395220d6 );
            }
            
            scanpoints = array_combine( scanpoints, extrapoints );
        }
    }
    else if ( isagent( scantarget ) )
    {
        centerpos = scantarget scripts\cp_mp\utility\player_utility::getstancecenter();
        headpos = scantarget scripts\cp_mp\utility\player_utility::getstancetop();
        scanpoints = [ targetorigin + ( 0, 0, 1 ), centerpos, headpos ];
        
        if ( isusingextrapoints )
        {
            var_264b006395220d6 = ( centerpos + targetorigin ) / 2;
            var_102502c44898b35c = ( headpos + centerpos ) / 2;
            extrapoints = [ var_264b006395220d6, var_102502c44898b35c ];
            scanpoints = array_combine( scanpoints, extrapoints );
        }
    }
    
    foreach ( point in scanpoints )
    {
        if ( self worldpointinreticle_circle( point, scanfov, var_5e43b44751d01b1a ) )
        {
            inreticle = 1;
            break;
        }
    }
    
    return inreticle;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x469b
// Size: 0x77, Type: bool
function remoteturret_isinmarkingrange( target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    params = function_1a5c1f370962e7bc( self.cameratype );
    detectrangesq = 2480625;
    
    if ( istrue( self.isunderwater ) || istrue( target isswimmingunderwater() ) )
    {
        detectrangesq = 619369;
    }
    
    return distancesquared( self.origin, target.origin ) < detectrangesq;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x471b
// Size: 0x77, Type: bool
function remoteturret_isindetectrange( target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    params = function_1a5c1f370962e7bc( self.cameratype );
    detectrangesq = 2480625;
    
    if ( istrue( self.isunderwater ) || istrue( target isswimmingunderwater() ) )
    {
        detectrangesq = 619369;
    }
    
    return distancesquared( self.origin, target.origin ) < detectrangesq;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x479b
// Size: 0x271
function function_a13b737dd0cea460( target )
{
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    icansee = 0;
    tracecontents = physics_createcontents( [ "physicscontents_itemclip", "physicscontents_item", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_ainosight" ] );
    camorigin = undefined;
    
    if ( isdefined( self.pilot ) )
    {
        camorigin = self.pilot getvieworigin();
    }
    else
    {
        camorigin = self.origin;
    }
    
    defaultorigin = target.origin;
    tracepoints = [ defaultorigin ];
    
    if ( isplayer( target ) )
    {
        headpos = ( 0, 0, 0 );
        
        if ( issharedfuncdefined( "player", "isReallyAlive" ) )
        {
            headpos = target [[ getsharedfunc( "player", "getStanceTop" ) ]]();
        }
        
        centerpos = ( 0, 0, 0 );
        
        if ( issharedfuncdefined( "player", "isReallyAlive" ) )
        {
            centerpos = target [[ getsharedfunc( "player", "getStanceCenter" ) ]]();
        }
        
        tracepoints = [ headpos, centerpos, defaultorigin ];
    }
    else if ( isagent( target ) )
    {
        tracepoints = [ defaultorigin + ( 0, 0, 1 ) ];
    }
    
    ignorelist = [ self, target ];
    vehicle = target getvehicle();
    
    if ( isdefined( vehicle ) )
    {
        ignorelist[ ignorelist.size ] = vehicle;
        vehiclechildren = vehicle getlinkedchildren( 1 );
        
        foreach ( child in vehiclechildren )
        {
            ignorelist[ ignorelist.size ] = vehicle;
        }
    }
    
    icansee = 0;
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        trace = scripts\engine\trace::ray_trace( camorigin, tracepoints[ i ], ignorelist, tracecontents, 1 );
        
        if ( trace[ "hittype" ] == "hittype_none" )
        {
            icansee = 1;
            break;
        }
    }
    
    return icansee;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x4a15
// Size: 0x251
function function_f232be2b19471805( target )
{
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    camangles = self gettagangles( "tag_player" );
    var_51743d62f4cf524e = self gettagorigin( "tag_player" );
    
    if ( isdefined( self.pilot ) )
    {
        camangles = self.pilot getplayerangles();
        var_51743d62f4cf524e = self.pilot getvieworigin();
    }
    
    camfwdvec = anglestoforward( camangles );
    defaultorigin = target.origin;
    headpos = ( 0, 0, 0 );
    
    if ( issharedfuncdefined( "player", "isReallyAlive" ) )
    {
        headpos = target [[ getsharedfunc( "player", "getStanceTop" ) ]]();
    }
    
    centerpos = ( 0, 0, 0 );
    
    if ( issharedfuncdefined( "player", "isReallyAlive" ) )
    {
        centerpos = target [[ getsharedfunc( "player", "getStanceCenter" ) ]]();
    }
    
    tracepoints = [ headpos, centerpos, defaultorigin ];
    var_9ae205c4c40af967 = 0;
    
    foreach ( point in tracepoints )
    {
        cam2targetvec = point - var_51743d62f4cf524e;
        dotangle = scripts\engine\math::anglebetweenvectors( camfwdvec, cam2targetvec );
        var_878f0eb51ab6a646 = scripts\engine\math::anglebetweenvectors( camfwdvec, ( 0, 0, 1 ) );
        var_cea5805c08f245d2 = scripts\engine\math::anglebetweenvectors( cam2targetvec, ( 0, 0, 1 ) );
        
        if ( isdefined( self.pilot ) )
        {
            var_e077f4a68ed9a464 = distancesquared( var_51743d62f4cf524e, point );
            
            if ( var_e077f4a68ed9a464 > 10 )
            {
                if ( abs( abs( var_878f0eb51ab6a646 ) - abs( var_cea5805c08f245d2 ) ) > getdvarfloat( @"hash_77f60c1216fca977", 19 ) )
                {
                    return var_9ae205c4c40af967;
                }
            }
        }
        
        if ( dotangle <= getdvarfloat( @"hash_a20d9fbeab627f6", 31 ) )
        {
            var_9ae205c4c40af967 = 1;
        }
    }
    
    return var_9ae205c4c40af967;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4c6f
// Size: 0x51, Type: bool
function private function_d326d254331ad16b( target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    markcluster = function_bcc24554453f6d67( self );
    
    if ( !isdefined( markcluster ) )
    {
        return false;
    }
    
    markdata = markcluster[ target getentitynumber() ];
    
    if ( !isdefined( markdata ) )
    {
        return false;
    }
    
    return istrue( markdata.reconmarked );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x4cc9
// Size: 0xc2
function function_bcc24554453f6d67( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        if ( !isdefined( level.teammarkedents ) || !isdefined( level.teammarkedents[ player.team ] ) )
        {
            return;
        }
        
        if ( shouldmodesetsquads() )
        {
            if ( isdefined( level.teammarkedents[ player.team ][ player.sessionsquadid ] ) )
            {
                return level.teammarkedents[ player.team ][ player.sessionsquadid ];
            }
            else
            {
                return;
            }
        }
        else
        {
            return level.teammarkedents[ player.team ];
        }
        
        return;
    }
    
    return player.markedents;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x4d93
// Size: 0x34
function function_1a5c1f370962e7bc( cameratype )
{
    params = level.var_bb0266f422d9afa3[ cameratype ];
    assertex( isdefined( params ), "level.dCamSettings does not have an entry for " + cameratype );
    return params;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x4dd0
// Size: 0x7f
function private function_b25c3111cbbcee44( target, sensorduration, supername )
{
    sensordata = function_cb0d2df7f050aa8e( target );
    
    if ( !isdefined( sensordata ) )
    {
        return;
    }
    
    self playsoundtoplayer( "ui_camera_proximity_alert", self.owner, self );
    function_487185d4893d5f85( supername );
    self.owner thread function_e793fcf03710f124( self, self.ownerindex, 2, undefined, 3.25 );
    thread function_2a98f46d2b757869( sensordata, sensorduration, supername );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4e57
// Size: 0x7d
function private function_cb0d2df7f050aa8e( target )
{
    if ( !isdefined( self.var_dae7e92e87a31e4 ) )
    {
        self.var_dae7e92e87a31e4 = [];
    }
    
    if ( isdefined( self.var_dae7e92e87a31e4[ target getentitynumber() ] ) )
    {
        return;
    }
    
    sensordata = spawnstruct();
    sensordata.target = target;
    sensordata.entnum = target getentitynumber();
    self.var_dae7e92e87a31e4[ target getentitynumber() ] = sensordata;
    return sensordata;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4edc
// Size: 0x64
function private function_487185d4893d5f85( supername )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        function_768370d8be2da2d2( player, undefined, supername );
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x4f48
// Size: 0x7e
function function_9553839f6b149375()
{
    params = function_1a5c1f370962e7bc( "tacCam" );
    self.headiconbox = scripts\cp_mp\entityheadicons::setheadicon_singleimage( [], "jup_hud_icon_killstreaks_remote_turret", 5, 1, 1000, 100, undefined, 1 );
    self.headiconfaction = scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, 5, undefined, undefined, undefined, undefined, 1 );
    self.headiconalert = scripts\cp_mp\entityheadicons::setheadicon_singleimage( [], "icon_ping_warning", 5, 1, 1000, 100, undefined, 1 );
    function_487185d4893d5f85( "tacCam" );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 3
// Checksum 0x0, Offset: 0x4fce
// Size: 0x126
function function_768370d8be2da2d2( player, unset, supername )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    idbox = self.headiconbox;
    
    if ( !isdefined( idbox ) )
    {
        return;
    }
    
    idfaction = self.headiconfaction;
    
    if ( !isdefined( idfaction ) )
    {
        return;
    }
    
    idalert = self.headiconalert;
    
    if ( !isdefined( idalert ) )
    {
        return;
    }
    
    isfriendly = isfriendly( self.owner.team, player );
    usingcamerasuper = function_10aa38d58090b230( player, supername );
    
    if ( isfriendly )
    {
        if ( istrue( unset ) )
        {
            function_58672d602d2120d3( player );
            return;
        }
        
        if ( function_9b936bec0466b8b5() )
        {
            function_f38fae4f6dd4b035( player );
            return;
        }
        
        if ( usingcamerasuper )
        {
            if ( istrue( player.isusingcamera ) )
            {
                function_9cc5ca1b073338ab( player );
                return;
            }
            
            function_13a319439a116d2( player );
            return;
        }
        else
        {
            function_58672d602d2120d3( player );
        }
        
        return;
    }
    
    function_9cc5ca1b073338ab( player );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x50fc
// Size: 0x4f
function private function_10aa38d58090b230( player, supername )
{
    if ( isdefined( player.super ) && player.super.staticdata.ref == supername )
    {
        return 1;
    }
    
    return 0;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x5153
// Size: 0x24, Type: bool
function private function_9b936bec0466b8b5()
{
    if ( !isdefined( self.var_dae7e92e87a31e4 ) )
    {
        return false;
    }
    
    if ( self.var_dae7e92e87a31e4.size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5180
// Size: 0x3e
function private function_f38fae4f6dd4b035( player )
{
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( self.headiconbox, player );
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( self.headiconfaction, player );
    scripts\cp_mp\entityheadicons::setheadicon_addclienttomask( self.headiconalert, player );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x51c6
// Size: 0x3e
function private function_9cc5ca1b073338ab( player )
{
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( self.headiconbox, player );
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( self.headiconfaction, player );
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( self.headiconalert, player );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x520c
// Size: 0x3e
function private function_13a319439a116d2( player )
{
    scripts\cp_mp\entityheadicons::setheadicon_addclienttomask( self.headiconbox, player );
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( self.headiconfaction, player );
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( self.headiconalert, player );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5252
// Size: 0x3e
function private function_58672d602d2120d3( player )
{
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( self.headiconbox, player );
    scripts\cp_mp\entityheadicons::setheadicon_addclienttomask( self.headiconfaction, player );
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask( self.headiconalert, player );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 5
// Checksum 0x0, Offset: 0x5298
// Size: 0xbf
function function_e793fcf03710f124( camera, index, status, forcestate, var_be632e8c9259a360 )
{
    if ( !isdefined( self.var_2d5baa13a621c5eb ) )
    {
        self.var_2d5baa13a621c5eb = [];
    }
    
    struct = spawnstruct();
    struct.camera = camera;
    struct.index = index;
    struct.status = status;
    struct.forcestate = istrue( forcestate );
    struct.var_be632e8c9259a360 = ter_op( isdefined( var_be632e8c9259a360 ), var_be632e8c9259a360, 0 );
    self.var_2d5baa13a621c5eb[ self.var_2d5baa13a621c5eb.size ] = struct;
    thread function_d094908c5788a3e9();
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x535f
// Size: 0xcd
function function_d094908c5788a3e9()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "tacticalCamera_allCamerasRemoved" );
    self notify( "sentryTurret_statusQueue" );
    self endon( "sentryTurret_statusQueue" );
    
    if ( istrue( level.gameended ) || !isdefined( self ) )
    {
        return;
    }
    
    while ( isdefined( self.var_2d5baa13a621c5eb ) && self.var_2d5baa13a621c5eb.size > 0 )
    {
        waitframe();
        struct = array_get_first_item( self.var_2d5baa13a621c5eb );
        self notify( "personal_camera_status_updated", struct.camera, struct.index, struct.status, struct.forcestate, struct.var_be632e8c9259a360 );
        self.var_2d5baa13a621c5eb = array_remove( self.var_2d5baa13a621c5eb, struct );
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x5434
// Size: 0x4a
function private function_2a98f46d2b757869( sensordata, sensorduration, supername )
{
    level endon( "game_ended" );
    self.owner endon( "disconnect" );
    self endon( "death" );
    wait sensorduration;
    function_d27569772a3ad7d7( sensordata );
    function_487185d4893d5f85( supername );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5486
// Size: 0x39
function private function_d27569772a3ad7d7( sensordata )
{
    if ( isdefined( self.var_dae7e92e87a31e4[ sensordata.entnum ] ) )
    {
        self.var_dae7e92e87a31e4[ sensordata.entnum ] = undefined;
    }
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x54c7
// Size: 0x10
function function_57bec1aaf3404bf6()
{
    self setclientomnvar( "ui_remote_turret_status", 2 );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 0
// Checksum 0x0, Offset: 0x54df
// Size: 0x10
function function_ca5bd9a5609d8ba3()
{
    self setclientomnvar( "ui_remote_turret_status", 1 );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 2
// Checksum 0x0, Offset: 0x54f7
// Size: 0x61, Type: bool
function isfriendly( teamtocheck, var_c4b81997f0120a97 )
{
    assertex( isdefined( var_c4b81997f0120a97 ), "isFriendlyTeam argument 2 is not defined" );
    
    if ( !level.teambased )
    {
        return false;
    }
    
    if ( !isplayer( var_c4b81997f0120a97 ) && !isdefined( var_c4b81997f0120a97.team ) )
    {
        return false;
    }
    
    if ( teamtocheck != var_c4b81997f0120a97.team )
    {
        return false;
    }
    
    return true;
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x5561
// Size: 0x38
function remoteturret_applyoverlay( player )
{
    player _setvisibiilityomnvarforkillstreak( self.streakinfo.streakname, "on" );
    player setclientomnvar( "ui_killstreak_health", 0 );
}

// Namespace remote_turret / scripts\killstreaks\remote_turret
// Params 1
// Checksum 0x0, Offset: 0x55a1
// Size: 0x2b
function remoteturret_removeoverlay( player )
{
    player _setvisibiilityomnvarforkillstreak( self.streakinfo.streakname, "off" );
}

