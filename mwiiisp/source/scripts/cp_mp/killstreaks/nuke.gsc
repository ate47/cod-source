#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace nuke;

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x9ea
// Size: 0x98
function init()
{
    if ( issharedfuncdefined( "nuke", "init" ) )
    {
        [[ getsharedfunc( "nuke", "init" ) ]]();
    }
    
    level.nuke_expl_struct = scripts\cp_mp\utility\game_utility::getlocalestruct( "nuke_expl_pos" );
    
    /#
        setdevdvarifuninitialized( @"hash_9d7c4e6216d74263", 0 );
        setdevdvarifuninitialized( @"hash_aff3efc76e4dfeb2", 1 );
        setdevdvarifuninitialized( @"hash_35e0e06e57d92306", 0 );
        setdevdvarifuninitialized( @"hash_7943c6ec7e44f87c", 0 );
    #/
    
    level function_c406cde778937505();
    level function_ae8a4b0e2c6b7396();
    level function_af7b6584a27af59f();
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0xa8a
// Size: 0x34
function function_c406cde778937505()
{
    game[ "dialog" ][ "nuke_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "nuke_multi_use" ] = "killstreak_remote_operator" + "_request_response";
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0xac6
// Size: 0x2
function function_ae8a4b0e2c6b7396()
{
    
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0xad0
// Size: 0x10
function function_af7b6584a27af59f()
{
    level.nukeinfo = spawnstruct();
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0xae8
// Size: 0x46
function tryusenuke( var_ea8ab1373211e7e6, var_66cdedd14979a988 )
{
    nukestreak = "nuke";
    
    if ( isdefined( var_ea8ab1373211e7e6 ) )
    {
        nukestreak = var_ea8ab1373211e7e6;
    }
    
    streakinfo = createstreakinfo( nukestreak, self );
    return tryusenukefromstruct( streakinfo, var_66cdedd14979a988 );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0xb37
// Size: 0x352, Type: bool
function tryusenukefromstruct( streakinfo, var_66cdedd14979a988 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            streakinfo notify( "killstreak_finished_with_deploy_weapon" );
            return false;
        }
    }
    
    var_b87822b980d6e763 = ter_op( isdefined( streakinfo.var_b87822b980d6e763 ), streakinfo.var_b87822b980d6e763, undefined );
    var_eb9cbd43baeae1c6 = undefined;
    var_3dabfa23bef362b5 = ter_op( isdefined( streakinfo.var_3dabfa23bef362b5 ), streakinfo.var_3dabfa23bef362b5, undefined );
    
    if ( !isdefined( level.nukeinfo.incoming ) )
    {
        level.nukeinfo.incoming = 1;
        level.nukeinfo.player = self;
    }
    else
    {
        if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/NUKE_ALREADY_INBOUND" );
        }
        
        return false;
    }
    
    bundle = level.streakglobals.streakbundles[ "nuke" ];
    var_33e40859dae8ac8d = isdefined( bundle ) && isdefined( bundle.deployweaponname );
    
    if ( streakinfo.streakname == "nuke_select_location" )
    {
        if ( var_33e40859dae8ac8d )
        {
            var_dd21567fdd9a3a6a = bundle.deployweaponname;
        }
        else
        {
            var_dd21567fdd9a3a6a = "iw9_spotter_scope_mp";
        }
        
        deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, function_eeaa22f0cd1ff845( var_dd21567fdd9a3a6a ), "weapon_fired", &weapongivennuke, &weaponswitchendednuke, &weaponfirednuke );
        var_eb9cbd43baeae1c6 = scripts\cp_mp\killstreaks\airstrike::airstrike_getownerlookatpos( self );
        var_3dabfa23bef362b5 = 25;
        otherteams = undefined;
        
        if ( issharedfuncdefined( "game", "getOtherTeam" ) )
        {
            otherteams = [[ getsharedfunc( "game", "getOtherTeam" ) ]]( streakinfo.owner.team );
        }
        
        if ( isdefined( otherteams ) )
        {
            level thread nuke_warnenemiesnukeincoming( otherteams[ 0 ] );
        }
    }
    else if ( !istrue( level.mercywintriggered ) )
    {
        if ( var_33e40859dae8ac8d )
        {
            var_dd21567fdd9a3a6a = bundle.deployweaponname;
        }
        else
        {
            var_dd21567fdd9a3a6a = "ks_remote_nuke_mp";
        }
        
        deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy( streakinfo, undefined, undefined, undefined, undefined, var_dd21567fdd9a3a6a, 0 );
    }
    else
    {
        deployresult = 1;
    }
    
    if ( !istrue( deployresult ) || level.gameended )
    {
        level.nukeinfo.incoming = undefined;
        level.nukeinfo.player = undefined;
        streakinfo notify( "killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            level.nukeinfo.incoming = undefined;
            level.nukeinfo.player = undefined;
            streakinfo notify( "killstreak_finished_with_deploy_weapon" );
            return false;
        }
    }
    
    thread nuke_start( streakinfo, 0, undefined, var_eb9cbd43baeae1c6, var_b87822b980d6e763, var_3dabfa23bef362b5, var_66cdedd14979a988 );
    
    if ( streakinfo.streakname != "nuke_select_location" && !istrue( level.mercywintriggered ) )
    {
        utility::trycall( level.matchdata_logkillstreakevent, "nuke", self.origin );
    }
    
    return true;
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 1
// Checksum 0x0, Offset: 0xe92
// Size: 0xd, Type: bool
function weapongivennuke( streakinfo )
{
    return true;
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0xea8
// Size: 0x26
function weaponswitchendednuke( streakinfo, switchresult )
{
    if ( istrue( switchresult ) )
    {
        thread scripts\cp_mp\killstreaks\airstrike::airstrike_watchforads( streakinfo, "splash_icon_nuke" );
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 3
// Checksum 0x0, Offset: 0xed6
// Size: 0x69
function weaponfirednuke( streakinfo, firedweaponobj, firedprojectile )
{
    mappoint = scripts\cp_mp\killstreaks\airstrike::airstrike_getownerlookatpos( self );
    
    if ( !isdefined( mappoint ) )
    {
        if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/INVALID_POINT" );
        }
        
        return "continue";
    }
    
    return "success";
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 4
// Checksum 0x0, Offset: 0xf48
// Size: 0x5e
function nuke_delaythread( delay, func, owner, streakinfo )
{
    level endon( "nuke_cancelled" );
    
    if ( isdefined( delay ) )
    {
        if ( issharedfuncdefined( "nuke", "hostmigration_waitLongDurationWithPause" ) )
        {
            [[ getsharedfunc( "nuke", "hostmigration_waitLongDurationWithPause" ) ]]( delay );
        }
    }
    
    level thread [[ func ]]( owner, streakinfo );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 7
// Checksum 0x0, Offset: 0xfae
// Size: 0x504
function nuke_start( streakinfo, allowcancel, launchposoverride, explodeposoverride, var_b87822b980d6e763, var_3dabfa23bef362b5, weaponoverride )
{
    level endon( "nuke_cancelled" );
    level notify( "used_nuke" );
    self notify( "used_nuke" );
    streakinfo notify( "killstreak_finished_with_deploy_weapon", 1 );
    nukeinfo = spawnstruct();
    nukeinfo.team = self.pers[ "team" ];
    nukeinfo.allowcancel = istrue( allowcancel );
    nukeinfo.cancelled = undefined;
    nukeinfo.detonated = undefined;
    nukeinfo.gameover = undefined;
    nukeinfo.visioninprogress = 0;
    nukeinfo.timescalefactor = 0;
    nukeinfo.nuketype = streakinfo.streakname;
    nukeinfo.streakinfo = streakinfo;
    nukeinfo.incoming = 1;
    
    if ( isplayer( self ) )
    {
        nukeinfo.player = self;
    }
    
    nukegoalpoint = function_b913fa4052092442( nukeinfo.nuketype, explodeposoverride );
    var_ffb179778403bed7 = function_5e29f303004c9602( nukeinfo.nuketype, nukegoalpoint, launchposoverride );
    nukestarttimer = function_4eb440a17165aeee( nukeinfo.nuketype, 6, var_b87822b980d6e763 );
    var_fc0ffdf77aeec040 = function_cd3712661b44dfb( nukeinfo.nuketype, 10, var_3dabfa23bef362b5 );
    nukeweapon = nuke_getweapon( nukeinfo.nuketype, weaponoverride );
    
    if ( !isdefined( nukeinfo.clockobject ) )
    {
        nukeinfo.clockobject = spawn( "script_origin", var_ffb179778403bed7 + ( 0, 0, 100 ) );
        nukeinfo.clockobject dontinterpolate();
        nukeinfo.clockobject hide();
    }
    else
    {
        nukeinfo.clockobject.origin = var_ffb179778403bed7 + ( 0, 0, 100 );
    }
    
    nukeinfo.launchpoint = var_ffb179778403bed7;
    nukeinfo.goalpoint = nukegoalpoint;
    nukeinfo.starttimer = nukestarttimer;
    nukeinfo.explosiontimer = var_fc0ffdf77aeec040;
    nukeinfo.var_6ea387e8dfa3cccd = nukestarttimer + var_fc0ffdf77aeec040;
    nukeinfo.weapon = nukeweapon;
    nukeinfo.inflictor = spawn( "script_model", nukegoalpoint + ( 0, 0, 5000 ) );
    nukeinfo.inflictor setmodel( "tag_origin" );
    nukeinfo.inflictor.team = nukeinfo.team;
    nukeinfo.inflictor.owner = self;
    nukeinfo.inflictor.streakinfo = streakinfo;
    level.nukeinfo = nukeinfo;
    level thread nuke_startlaunchsequence( self, streakinfo );
    
    if ( nukeinfo.nuketype == "nuke_multi" )
    {
        level thread nuke_delaythread( nukeinfo.starttimer, &function_2f5646d1ef5c8b81, self, streakinfo );
        level thread nuke_delaythread( nukeinfo.starttimer, &function_e361a03e34d52440, self, streakinfo );
        level thread nuke_delaythread( nukeinfo.starttimer, &function_36fb604b46a1514a, self, streakinfo );
        level thread nuke_delaythread( nukeinfo.starttimer, &function_acb30efb36c7f230, self, streakinfo );
    }
    else
    {
        if ( isdefined( streakinfo.nuketype ) && streakinfo.nuketype == "nuke_select_location" )
        {
            level thread nuke_delaythread( nukeinfo.var_6ea387e8dfa3cccd, &nuke_createradiationzone, self, streakinfo );
        }
        
        level thread nuke_delaythread( nukeinfo.var_6ea387e8dfa3cccd, &nuke_slowmo, self, streakinfo );
        level thread nuke_delaythread( nukeinfo.var_6ea387e8dfa3cccd, &nuke_explosion, self, streakinfo );
        level thread nuke_delaythread( nukeinfo.var_6ea387e8dfa3cccd, &nuke_earthquake, self, streakinfo );
        level thread nuke_delaythread( nukeinfo.var_6ea387e8dfa3cccd + 0.075, &nuke_vision, self, streakinfo );
        level thread nuke_delaythread( nukeinfo.var_6ea387e8dfa3cccd + 5, &nuke_death, self, streakinfo );
    }
    
    level callback::callback( "killstreak_finish_use", { #streakinfo:streakinfo } );
    
    if ( issharedfuncdefined( "nuke", "addTeamRankXPMultiplier" ) )
    {
        [[ getsharedfunc( "nuke", "addTeamRankXPMultiplier" ) ]]( 2, level.nukeinfo.team, "nuke" );
    }
    
    if ( level.nukeinfo.allowcancel )
    {
        level thread nuke_watchownerdisconnect( nukeinfo.player );
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 1
// Checksum 0x0, Offset: 0x14ba
// Size: 0x59
function nuke_watchownerdisconnect( owner )
{
    if ( !istrue( level.nukeinfo.timescalefactor ) )
    {
        soundsettimescalefactorfromtable( "nuke" );
        level.nukeinfo.timescalefactor = 1;
    }
    
    level endon( "game_ended" );
    owner waittill( "disconnect" );
    nuke_cancel();
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x151b
// Size: 0x58
function nuke_cancel()
{
    level.nukeinfo.cancelled = 1;
    level.nukeinfo.incoming = undefined;
    level.nukeinfo.player = undefined;
    nuke_cleartimer();
    setslowmotion( 1, 1, 0 );
    level notify( "nuke_cancelled" );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 1
// Checksum 0x0, Offset: 0x157b
// Size: 0x144
function nuke_starttimer( traveltime )
{
    level endon( "nuke_cancelled" );
    
    if ( traveltime <= 1 )
    {
        return;
    }
    
    if ( istrue( level.mercywintriggered ) )
    {
        setomnvar( "ui_nuke_timer_type", 2 );
    }
    else
    {
        setomnvar( "ui_nuke_timer_type", 0 );
    }
    
    setomnvar( "ui_nuke_countdown_active", 1 );
    
    if ( isdefined( level.nukeinfo.player ) )
    {
        setomnvar( "ui_nuke_player_id", level.nukeinfo.player getentitynumber() );
    }
    
    level thread nuke_updateuitimers( traveltime );
    nuketimer = traveltime;
    var_4301659e40735d70 = 0;
    var_8a02211e4ff9cb79 = 0;
    level.nukeinfo.clockobject playsound( "iw9_mgb_splash" );
    
    while ( nuketimer > 0 )
    {
        if ( nuketimer <= 10 )
        {
            if ( isdefined( level.nukeinfo.missile ) && !istrue( var_4301659e40735d70 ) )
            {
                level thread nuke_startmissileflightaudio();
                var_4301659e40735d70 = 1;
            }
        }
        
        if ( nuketimer <= 4.9 )
        {
            if ( isdefined( level.nukeinfo.missile ) && !istrue( var_8a02211e4ff9cb79 ) )
            {
                var_8a02211e4ff9cb79 = 1;
            }
        }
        
        wait 1;
        nuketimer--;
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x16c7
// Size: 0x28
function nuke_startmissileflightaudio()
{
    level.nukeinfo.missile endon( "death" );
    level endon( "game_ended" );
    wait 7;
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x16f7
// Size: 0xf
function nuke_cleartimer()
{
    setomnvar( "ui_nuke_countdown_active", -1 );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x170e
// Size: 0x2ec
function nuke_startlaunchsequence( owner, streakinfo )
{
    nuketype = level.nukeinfo.nuketype;
    nukestarttimer = level.nukeinfo.starttimer;
    var_fc0ffdf77aeec040 = level.nukeinfo.explosiontimer;
    var_81c12fe9c2d29fa7 = level.nukeinfo.var_6ea387e8dfa3cccd;
    launchpos = level.nukeinfo.launchpoint;
    explodepos = level.nukeinfo.goalpoint;
    nukeweapon = level.nukeinfo.weapon;
    var_22e6bb02f93c20d1 = nuketype == "nuke_multi";
    var_a3c021e65ff921dc = nuketype == "nuke_select_location";
    level thread nuke_startprelaunchalarm( nukestarttimer, streakinfo, owner );
    
    if ( var_22e6bb02f93c20d1 )
    {
        level thread function_74f04922f32f9f6c( launchpos, explodepos, var_81c12fe9c2d29fa7, streakinfo, owner );
    }
    
    if ( isplayer( owner ) && owner ispcplayer() )
    {
        owner setclientomnvar( "nVidiaHighlights_events", 15 );
    }
    
    if ( !istrue( var_a3c021e65ff921dc ) )
    {
        gametype = "";
        
        if ( issharedfuncdefined( "game", "getGameType" ) )
        {
            gametype = [[ getsharedfunc( "game", "getGameType" ) ]]();
        }
        
        timelimitdvar = undefined;
        
        if ( issharedfuncdefined( "nuke", "stopTheClock" ) )
        {
            timelimitdvar = [[ getsharedfunc( "nuke", "stopTheClock" ) ]]( gametype );
        }
        
        if ( isdefined( timelimitdvar ) )
        {
            hashvalue = getdvarfloat( timelimitdvar, 0 );
            
            if ( issharedfuncdefined( "game", "setOverTimeLimitDvar" ) )
            {
                [[ getsharedfunc( "game", "setOverTimeLimitDvar" ) ]]( hashvalue );
            }
        }
        
        level.dontendonscore = 1;
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                player notify( "abort_killcam" );
                player.cancelkillcam = 1;
            }
        }
        
        level thread nuke_abortkillcamonspawn();
        level.disablespawncamera = 1;
    }
    
    if ( issharedfuncdefined( "nuke", "hostmigration_waitLongDurationWithPause" ) )
    {
        [[ getsharedfunc( "nuke", "hostmigration_waitLongDurationWithPause" ) ]]( nukestarttimer );
    }
    
    level thread nuke_starttimer( var_fc0ffdf77aeec040 );
    
    if ( istrue( var_22e6bb02f93c20d1 ) )
    {
        level thread function_3eb69e3deebb567( owner, streakinfo, explodepos, var_fc0ffdf77aeec040, nukeweapon );
        return;
    }
    
    level thread nuke_launchmissile( owner, streakinfo, launchpos, explodepos, var_fc0ffdf77aeec040, nukeweapon );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 3
// Checksum 0x0, Offset: 0x1a02
// Size: 0xe8
function nuke_startprelaunchalarm( var_b807a7599e6f56dc, streakinfo, owner )
{
    level endon( "game_ended" );
    
    if ( istrue( streakinfo.var_93dbd6174ca50e88 ) )
    {
        return;
    }
    
    var_1d2e95f090749d20 = 0;
    
    if ( isdefined( streakinfo ) && isdefined( owner ) )
    {
        owner thread playkillstreakoperatordialog( streakinfo.streakname, streakinfo.streakname + "_use", 1, 1 );
    }
    
    while ( var_b807a7599e6f56dc > 0 )
    {
        if ( isdefined( level.nukeinfo.clockobject ) && !istrue( var_1d2e95f090749d20 ) )
        {
            level.nukeinfo.clockobject playsound( "iw9_mgb_siren" );
            var_1d2e95f090749d20 = 1;
        }
        
        if ( issharedfuncdefined( "nuke", "hostmigration_waitLongDurationWithPause" ) )
        {
            [[ getsharedfunc( "nuke", "hostmigration_waitLongDurationWithPause" ) ]]( 2 );
        }
        
        var_b807a7599e6f56dc -= 2;
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 5
// Checksum 0x0, Offset: 0x1af2
// Size: 0xc5
function function_74f04922f32f9f6c( var_5f4190c47572964f, baseexplosionpoint, var_81c12fe9c2d29fa7, streakinfo, owner )
{
    level endon( "game_ended" );
    drone = spawn( "script_model", var_5f4190c47572964f );
    drone setmodel( "veh9_mil_air_large_drone_mp" );
    drone setcandamage( 0 );
    drone.angles = vectortoangles( ( baseexplosionpoint[ 0 ], baseexplosionpoint[ 1 ], 0 ) - ( var_5f4190c47572964f[ 0 ], var_5f4190c47572964f[ 1 ], 0 ) );
    drone setscriptablepartstate( "engine", "on", 0 );
    drone moveto( var_5f4190c47572964f + anglestoforward( drone.angles ) * 5000, var_81c12fe9c2d29fa7 );
    level.nukeinfo.drone = drone;
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 5
// Checksum 0x0, Offset: 0x1bbf
// Size: 0x3b9
function function_3eb69e3deebb567( owner, streakinfo, explodepos, traveltime, nukeweapon )
{
    level endon( "game_ended" );
    assertex( isdefined( level.nukeinfo.drone ), "nuke_launchBombs: Missing drone to launch the bombs from" );
    
    if ( isdefined( owner ) && isplayer( owner ) )
    {
        if ( issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
        {
            level thread [[ getsharedfunc( "hud", "teamPlayerCardSplash" ) ]]( "used_nuke_multi", owner );
        }
    }
    
    level.nukeinfo.bombs = [];
    drone = level.nukeinfo.drone;
    nukegravity = ( 0, 0, -1 * getdvarint( @"bg_gravity", 800 ) );
    explodeposlist = [ explodepos - anglestoforward( drone.angles ) * 2500, explodepos - anglestoforward( drone.angles ) * 1000, explodepos + anglestoforward( drone.angles ) * 1000, explodepos + anglestoforward( drone.angles ) * 2500, explodepos ];
    tracecontents = scripts\engine\trace::create_contents( 0, 1, 1, 1 );
    rightoffset = 500;
    
    for ( i = 0; i < 5 ; i++ )
    {
        lastbomb = 0;
        nextindex = i + 1;
        
        if ( nextindex == 5 )
        {
            lastbomb = 1;
        }
        
        launchoffset = drone.origin - ( 0, 0, 100 ) + anglestoforward( drone.angles ) * 500;
        launchpos = launchoffset + anglestoright( drone.angles ) * rightoffset;
        potentialpos = explodeposlist[ i ];
        
        if ( !istrue( lastbomb ) )
        {
            randdist = randomintrange( 1000, 2500 );
            randangle = randomint( 360 );
            x = explodeposlist[ i ][ 0 ] + randdist * cos( randangle );
            y = explodeposlist[ i ][ 1 ] + randdist * sin( randangle );
            z = explodeposlist[ i ][ 2 ];
            potentialpos = ( x, y, z );
        }
        
        bombtrace = scripts\engine\trace::ray_trace( launchpos, potentialpos, drone, tracecontents );
        newexplodepos = potentialpos;
        
        if ( isdefined( bombtrace ) && isdefined( bombtrace[ "hittype" ] != "hittype_none" ) )
        {
            newexplodepos = bombtrace[ "position" ];
        }
        
        nukevelocity = ( newexplodepos - 0.5 * nukegravity * squared( traveltime ) - launchpos ) / traveltime;
        bomb = magicgrenademanual( nukeweapon, launchpos, nukevelocity, traveltime );
        bomb setscriptablepartstate( "launch_bomb_source", "on", 0 );
        bomb setscriptablepartstate( "launch", "on", 0 );
        
        if ( istrue( lastbomb ) )
        {
            level notify( "nuke_last_bomb_launch" );
        }
        
        level thread function_610c4d047fafd311( bomb, streakinfo, traveltime, lastbomb );
        level.nukeinfo.bombs[ level.nukeinfo.bombs.size ] = bomb;
        wait randomfloatrange( 0.5, 1 );
        rightoffset -= 250;
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 4
// Checksum 0x0, Offset: 0x1f80
// Size: 0x1dd
function function_610c4d047fafd311( bomb, streakinfo, traveltime, lastbomb )
{
    if ( istrue( lastbomb ) )
    {
        wait traveltime - 2.8;
        bomb setscriptablepartstate( "last_bomb_sfx", "on", 0 );
        wait 2.8;
    }
    else
    {
        wait traveltime;
    }
    
    position = bomb.origin;
    shakeduration = 3;
    var_ff85637831346339 = 0.3;
    var_ff624f78310def85 = 0.15;
    var_ff625578310dfcb7 = 0.1;
    radiusscalemax = 1500;
    radiusscalemid = 5000;
    radiusscalemin = 10000;
    
    if ( issharedfuncdefined( "shellshock", "artillery_earthQuake" ) )
    {
        [[ getsharedfunc( "shellshock", "artillery_earthQuake" ) ]]( position, shakeduration, var_ff85637831346339, var_ff624f78310def85, var_ff625578310dfcb7, radiusscalemax, radiusscalemid, radiusscalemin, undefined, 1, 1 );
    }
    
    bombowner = level.nukeinfo.player;
    killradius = 3000;
    var_d0712dbca713335f = nuke_cankilleverything();
    
    if ( istrue( lastbomb ) )
    {
        level notify( "nuke_last_bomb_impact" );
        nuke_cleartimer();
        level.nukeinfo.detonated = 1;
        level notify( "nuke_detonated" );
        thread play_loopsound_in_space( "iw9_mgb_post_fire", bomb.origin );
        
        if ( !istrue( level.mercywintriggered ) )
        {
            if ( isdefined( level.nukeinfo.player ) && isdefined( streakinfo ) )
            {
                level.nukeinfo.player scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats( streakinfo );
            }
        }
    }
    
    bomb detonate();
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x2165
// Size: 0x5a
function function_9e9a2fdc07dcdd72( bomb, traveltime )
{
    bomb endon( "death" );
    bomb endon( "explode" );
    timecounter = 0;
    var_8a02211e4ff9cb79 = 0;
    
    while ( true )
    {
        if ( timecounter >= 8 )
        {
            break;
        }
        
        timecounter += 0.05;
        wait 0.05;
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 3
// Checksum 0x0, Offset: 0x21c7
// Size: 0x33b
function function_44b8d70a3d3ca307( owner, position, killradius )
{
    killradiussq = killradius * killradius;
    var_705cc2040029edb7 = owner;
    nukeweapon = makeweapon( level.nukeinfo.weapon );
    characterlist = utility::function_2d7fd59d039fa69b( position, killradius );
    
    foreach ( character in characterlist )
    {
        if ( !isdefined( character ) )
        {
            continue;
        }
        
        if ( issharedfuncdefined( "player", "isReallyAlive" ) )
        {
            if ( [[ getsharedfunc( "player", "isReallyAlive" ) ]]( character ) )
            {
                character.nuked = 1;
                
                if ( level.teambased )
                {
                    if ( isdefined( owner ) && character.team == owner.team || !isdefined( owner ) )
                    {
                        var_705cc2040029edb7 = character;
                    }
                }
                else if ( !isdefined( owner ) )
                {
                    var_705cc2040029edb7 = character;
                }
                
                character dodamage( 999999, level.nukeinfo.inflictor.origin, var_705cc2040029edb7, level.nukeinfo.inflictor, "MOD_EXPLOSIVE", nukeweapon, "none" );
            }
        }
    }
    
    killstreaklist = level.activekillstreaks;
    vehiclelist = undefined;
    
    if ( isdefined( level.vehicle ) && isdefined( level.vehicle.interact ) && isdefined( level.vehicle.interact.vehicles ) )
    {
        vehiclelist = level.vehicle.interact.vehicles;
    }
    
    equipmentlist = [[ level.getactiveequipmentarray ]]();
    activeobjects = [];
    
    if ( isdefined( killstreaklist ) )
    {
        activeobjects = array_combine_unique( activeobjects, killstreaklist );
    }
    
    if ( isdefined( vehiclelist ) )
    {
        activeobjects = array_combine_unique( activeobjects, vehiclelist );
    }
    
    if ( isdefined( equipmentlist ) )
    {
        activeobjects = array_combine_unique( activeobjects, equipmentlist );
    }
    
    foreach ( object in activeobjects )
    {
        if ( !isdefined( object ) )
        {
            continue;
        }
        
        if ( distancesquared( object.origin, position ) > killradiussq )
        {
            continue;
        }
        
        if ( object scripts\cp_mp\vehicles\vehicle::isvehicle() && !isdefined( object.streakinfo ) )
        {
            object.dontspawnhusk = 1;
            object scripts\cp_mp\vehicles\vehicle::vehicle_explode();
            continue;
        }
        
        object dodamage( 99999, level.nukeinfo.inflictor.origin, var_705cc2040029edb7, level.nukeinfo.inflictor, "MOD_EXPLOSIVE", nukeweapon, "none" );
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 6
// Checksum 0x0, Offset: 0x250a
// Size: 0x1ac
function nuke_launchmissile( owner, streakinfo, launchpos, explodepos, traveltime, nukeweapon )
{
    level endon( "game_ended" );
    
    if ( isdefined( owner ) && isplayer( owner ) )
    {
        if ( issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
        {
            level thread [[ getsharedfunc( "hud", "teamPlayerCardSplash" ) ]]( "used_nuke", owner );
        }
    }
    
    nukegravity = ( 0, 0, -1 * getdvarint( @"bg_gravity", 800 ) );
    nukevelocity = ( explodepos - 0.5 * nukegravity * squared( traveltime ) - launchpos ) / traveltime;
    level.nukeinfo.missile = magicgrenademanual( nukeweapon, launchpos, nukevelocity, traveltime );
    level.nukeinfo.missile setscriptablepartstate( "launch", "on", 0 );
    
    /#
        var_5c563a9f55dea93d = getdvarint( @"hash_35e0e06e57d92306", 0 );
        
        if ( istrue( var_5c563a9f55dea93d ) )
        {
            sphere( launchpos, 500, ( 0, 1, 0 ), 0, 1000 );
            sphere( explodepos, 500, ( 1, 0, 0 ), 0, 1000 );
            
            while ( isdefined( level.nukeinfo.missile ) )
            {
                sphere( level.nukeinfo.missile.origin, 100, ( 1, 1, 1 ), 0, 1 );
                wait 0.05;
            }
        }
    #/
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 3
// Checksum 0x0, Offset: 0x26be
// Size: 0x158
function nuke_findunobstructedfiringinfo( nukestart, nukeend, var_cf90f734f1c34521 )
{
    nukeinfo = spawnstruct();
    collisioncontents = physics_createcontents( [ "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot" ] );
    currentmin = -2000;
    currentmax = 2000;
    nukegravity = ( 0, 0, -1 * getdvarint( @"bg_gravity", 800 ) );
    
    while ( true )
    {
        var_be819573448d27bc = nukestart;
        var_969bf3922a5aa40b = var_be819573448d27bc + ( 0, 0, 5000 );
        
        if ( scripts\engine\trace::ray_trace_passed( var_be819573448d27bc, var_969bf3922a5aa40b, undefined, collisioncontents ) )
        {
            nukevelocity = ( nukeend - 0.5 * nukegravity * squared( var_cf90f734f1c34521 ) - var_be819573448d27bc ) / var_cf90f734f1c34521;
            nukeinfo.sourcepos = var_be819573448d27bc;
            nukeinfo.goalpos = nukeend;
            nukeinfo.initvelocity = nukevelocity;
            break;
        }
        
        var_be819573448d27bc += anglestoright( self.angles ) * randomintrange( currentmin, currentmax );
        currentmin = int( currentmin * 1.3 );
        currentmax = int( currentmax * 1.3 );
        waitframe();
    }
    
    return nukeinfo;
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x281f
// Size: 0x256
function nuke_explosion( owner, streakinfo )
{
    level endon( "nuke_cancelled" );
    nuke_cleartimer();
    level.nukeinfo.detonated = 1;
    level notify( "nuke_detonated" );
    
    if ( istrue( streakinfo.skipexplosion ) )
    {
        return;
    }
    
    if ( isdefined( level.nukeinfo.missile ) )
    {
        level.nukeinfo.missile setscriptablepartstate( "launch", "off", 0 );
        level.nukeinfo.missile delete();
    }
    
    var_b19d10a33613ef12 = spawn( "script_model", level.nukeinfo.goalpoint );
    var_b19d10a33613ef12 setmodel( "ks_nuke_mp" );
    var_b19d10a33613ef12 setscriptablepartstate( "explode", "on", 0 );
    
    if ( issharedfuncdefined( "entity", "delayEntDelete" ) )
    {
        var_b19d10a33613ef12 thread [[ getsharedfunc( "entity", "delayEntDelete" ) ]]( 50 );
    }
    
    thread nuke_startexplosionaudio( level.nukeinfo.goalpoint );
    
    if ( level.nukeinfo.nuketype != "nuke_select_location" )
    {
        foreach ( character in level.characters )
        {
            if ( [[ getsharedfunc( "nuke", "cankill" ) ]]( character, nuke_cankilleverything() ) )
            {
                if ( isplayer( character ) )
                {
                    if ( issharedfuncdefined( "player", "isReallyAlive" ) )
                    {
                        if ( [[ getsharedfunc( "player", "isReallyAlive" ) ]]( character ) )
                        {
                            character thread nuke_startnukedeathfx();
                        }
                    }
                }
            }
        }
        
        return;
    }
    
    foreach ( character in level.characters )
    {
        if ( isplayer( character ) && [[ getsharedfunc( "player", "isReallyAlive" ) ]]( character ) )
        {
            character thread nuke_startnukedeathfx_chooselocationversion();
        }
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 1
// Checksum 0x0, Offset: 0x2a7d
// Size: 0x62
function nuke_startexplosionaudio( explosionpos )
{
    foreach ( player in level.players )
    {
        player setsoundsubmix( "mp_killstreak_nuke", 6 );
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x2ae7
// Size: 0x9b
function nuke_slowmo( owner, streakinfo )
{
    if ( level.nukeinfo.nuketype == "nuke_select_location" )
    {
        return;
    }
    
    level endon( "nuke_cancelled" );
    
    if ( istrue( streakinfo.var_e723bc4541254543 ) )
    {
        return;
    }
    
    setnuketimescalefactor();
    level waittill( "nuke_death" );
    setslowmotion( 1, 0.25, 0.1 );
    
    /#
        endgameoff = getdvarint( @"hash_aff3efc76e4dfeb2", 1 );
        
        if ( !endgameoff )
        {
            wait 3;
            setslowmotion( 0.25, 1, 0 );
        }
    #/
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x2b8a
// Size: 0x3a
function setnuketimescalefactor()
{
    if ( !istrue( level.nukeinfo.timescalefactor ) )
    {
        soundsettimescalefactorfromtable( "nuke" );
        level.nukeinfo.timescalefactor = 1;
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x2bcc
// Size: 0x6c
function nuke_dof( owner, streakinfo )
{
    level endon( "nuke_cancelled" );
    
    foreach ( player in level.players )
    {
        player thread nuke_adjustexplosiondof();
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x2c40
// Size: 0x18
function nuke_adjustexplosiondof()
{
    self endon( "disconnect" );
    self setphysicaldepthoffield( 2, 1500 );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x2c60
// Size: 0x155
function nuke_vision( owner, streakinfo )
{
    level endon( "nuke_cancelled" );
    level.nukeinfo.visioninprogress = 1;
    
    if ( istrue( streakinfo.skipvision ) )
    {
        return;
    }
    
    visionsetnaked( "nuke_global_flash", 0.05 );
    setdvar( @"hash_d18838f3e4b65d16", 0 );
    
    if ( issharedfuncdefined( "nuke", "hostmigration_waitLongDurationWithPause" ) )
    {
        [[ getsharedfunc( "nuke", "hostmigration_waitLongDurationWithPause" ) ]]( 0.5 );
    }
    
    level notify( "nuke_aftermath_post_started" );
    level thread nuke_fadeflashvision( 1, 2 );
    level waittill( "nuke_death" );
    level thread nuke_updatevisiononhostmigration();
    level nuke_setaftermathvision( 5 );
    wait 1;
    
    if ( !istrue( level.var_587f8a02a3f577 ) )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player setclientomnvar( "ui_world_fade", 1 );
            level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer( player, 0, 0.25 );
        }
    }
    
    level.nukeinfo.visioninprogress = 0;
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x2dbd
// Size: 0x46
function nuke_fadeflashvision( var_a327466df35c5c88, var_9d7a33ca9811c391 )
{
    if ( issharedfuncdefined( "nuke", "hostmigration_waitLongDurationWithPause" ) )
    {
        [[ getsharedfunc( "nuke", "hostmigration_waitLongDurationWithPause" ) ]]( var_a327466df35c5c88 );
    }
    
    visionsetnaked( "", var_9d7a33ca9811c391 );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x2e0b
// Size: 0x4a0
function nuke_death( owner, streakinfo )
{
    level endon( "nuke_cancelled" );
    level endon( "game_ended" );
    level notify( "nuke_death" );
    winner = level.nukeinfo.player;
    
    if ( level.teambased )
    {
        winner = level.nukeinfo.inflictor.team;
    }
    
    if ( issharedfuncdefined( "nuke", "hostmigration_waitTillHostMigrationDone" ) )
    {
        [[ getsharedfunc( "nuke", "hostmigration_waitTillHostMigrationDone" ) ]]();
    }
    
    var_cfc1a4c269cffb70 = nuke_cankilleverything();
    
    if ( isdefined( level.nukeinfo.player ) )
    {
        if ( level.nukeinfo.nuketype != "nuke_select_location" )
        {
            foreach ( character in level.characters )
            {
                if ( [[ getsharedfunc( "nuke", "cankill" ) ]]( character, var_cfc1a4c269cffb70 ) )
                {
                    if ( isplayer( character ) )
                    {
                        character.nuked = 1;
                        
                        if ( issharedfuncdefined( "player", "isReallyAlive" ) )
                        {
                            if ( [[ getsharedfunc( "player", "isReallyAlive" ) ]]( character ) )
                            {
                                if ( !istrue( character.safefromnuke ) )
                                {
                                    if ( issharedfuncdefined( "nuke", "killPlayerWithAttacker" ) )
                                    {
                                        [[ getsharedfunc( "nuke", "killPlayerWithAttacker" ) ]]( character );
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            if ( istrue( var_cfc1a4c269cffb70 ) )
            {
                if ( issharedfuncdefined( "nuke", "destroyActiveObjects" ) )
                {
                    [[ getsharedfunc( "nuke", "destroyActiveObjects" ) ]]();
                }
            }
            else if ( !istrue( level.blocknukekills ) )
            {
                enemyteams = undefined;
                
                if ( issharedfuncdefined( "game", "getEnemyTeams" ) )
                {
                    enemyteams = [[ getsharedfunc( "game", "getEnemyTeams" ) ]]( level.nukeinfo.inflictor.team );
                }
                
                foreach ( entry in enemyteams )
                {
                    if ( issharedfuncdefined( "nuke", "destroyActiveObjects" ) )
                    {
                        [[ getsharedfunc( "nuke", "destroyActiveObjects" ) ]]( entry );
                    }
                }
            }
            
            if ( issharedfuncdefined( "player", "printGameAction" ) )
            {
                [[ getsharedfunc( "player", "printGameAction" ) ]]( "killstreak ended - nuke", level.nukeinfo.player );
            }
        }
        else
        {
            foreach ( character in level.characters )
            {
                isplayerinradzone = 0;
                
                if ( issharedfuncdefined( "nuke", "isPlayerInRadZone" ) )
                {
                    isplayerinradzone = [[ getsharedfunc( "nuke", "isPlayerInRadZone" ) ]]( character, level.nukeinfo.goalpoint, 25000000 );
                }
                
                if ( isplayerinradzone )
                {
                    character.nuked = 1;
                    
                    if ( [[ getsharedfunc( "player", "isReallyAlive" ) ]]( character ) )
                    {
                        if ( issharedfuncdefined( "nuke", "killPlayer" ) )
                        {
                            [[ getsharedfunc( "nuke", "killPlayer" ) ]]( character );
                        }
                    }
                }
            }
        }
        
        if ( !istrue( level.mercywintriggered ) )
        {
            if ( isdefined( level.nukeinfo.player ) && isdefined( streakinfo ) )
            {
                level.nukeinfo.player scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats( streakinfo );
            }
        }
    }
    
    if ( istrue( var_cfc1a4c269cffb70 ) )
    {
        /#
            var_f56513277692f024 = getdvarint( @"hash_aff3efc76e4dfeb2", 1 );
            
            if ( !istrue( var_f56513277692f024 ) )
            {
                level.nukeinfo.incoming = undefined;
                level.nukeinfo.player = undefined;
                return;
            }
        #/
        
        while ( istrue( level.nukeinfo.visioninprogress ) )
        {
            waitframe();
        }
        
        level.nukeinfo.gameover = 1;
        level thread nuke_delayendgame( 0, winner );
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x32b3
// Size: 0xbf
function function_2f5646d1ef5c8b81( owner, streakinfo )
{
    level endon( "nuke_cancelled" );
    level endon( "game_ended" );
    level waittill( "nuke_last_bomb_launch" );
    
    if ( !istrue( streakinfo.var_8b07383e09b74fad ) )
    {
        explodetime = level.nukeinfo.explosiontimer;
        visionsetfadetoblack( "nuke_global_flash", explodetime * 1.75 );
    }
    
    foreach ( player in level.players )
    {
        player setsoundsubmix( "mp_killstreak_nuke", 6 );
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x337a
// Size: 0xf3
function function_36fb604b46a1514a( owner, streakinfo )
{
    level endon( "nuke_cancelled" );
    level endon( "game_ended" );
    level waittill( "nuke_last_bomb_impact" );
    
    foreach ( player in level.players )
    {
        player _freezecontrols( 1 );
    }
    
    function_e6e629829270e1fa();
    wait 0.05;
    
    if ( !istrue( level.var_587f8a02a3f577 ) )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer( player, 0, 3 );
        }
    }
    
    level notify( "nuke_bomb_slam_white_finished" );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x3475
// Size: 0x14b
function function_e361a03e34d52440( owner, streakinfo )
{
    level endon( "nuke_cancelled" );
    level endon( "game_ended" );
    explodetime = level.nukeinfo.explosiontimer;
    var_d15ea961076c2a0f = explodetime / 3;
    var_895e3bf2db2f84fb = [ "far", "mid", "near" ];
    
    for ( motionindex = 0; motionindex < var_895e3bf2db2f84fb.size ; motionindex++ )
    {
        var_f4fa9d362463d738 = "player_mgb_shake_" + var_895e3bf2db2f84fb[ motionindex ] + "_mp";
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player notify( "nuke_bomb_next_stage" );
            
            if ( !player _isalive() )
            {
                level thread function_f903c3e8aabfc042( player, var_f4fa9d362463d738, "spawned_player" );
                continue;
            }
            
            if ( player isusingremote() )
            {
                level thread function_f903c3e8aabfc042( player, var_f4fa9d362463d738, "stopped_using_remote" );
                continue;
            }
            
            function_f7348e400b4a608d( player, var_f4fa9d362463d738, 0, 1 );
        }
        
        wait var_d15ea961076c2a0f;
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 3
// Checksum 0x0, Offset: 0x35c8
// Size: 0x4f
function function_f903c3e8aabfc042( player, var_f4fa9d362463d738, triggernotify )
{
    player endon( "death_or_disconnect" );
    player endon( "nuke_bomb_next_stage" );
    player endon( "nuke_bomb_delayed_earthquake" );
    level endon( "game_ended" );
    player waittill( triggernotify );
    function_f7348e400b4a608d( player, var_f4fa9d362463d738, 0, 1 );
    player notify( "nuke_bomb_delayed_earthquake" );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x361f
// Size: 0xfd
function function_acb30efb36c7f230( owner, streakinfo )
{
    level endon( "nuke_cancelled" );
    level endon( "game_ended" );
    level waittill( "nuke_bomb_slam_white_finished" );
    
    if ( getdvarint( @"hash_d5fd9067cafb06b9" ) == 1 )
    {
        return;
    }
    
    level notify( "nuke_end_game" );
    winner = level.nukeinfo.player;
    
    if ( level.teambased )
    {
        winner = level.nukeinfo.inflictor.team;
    }
    
    /#
        var_f56513277692f024 = getdvarint( @"hash_aff3efc76e4dfeb2", 1 );
        
        if ( !istrue( var_f56513277692f024 ) )
        {
            level.nukeinfo.incoming = undefined;
            level.nukeinfo.player = undefined;
            return;
        }
    #/
    
    level.nukeinfo.gameover = 1;
    level thread nuke_delayendgame( 10, winner, 1 );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 4
// Checksum 0x0, Offset: 0x3724
// Size: 0x61
function nuke_delayendgame( delaytime, winner, playbnk, var_3a4c75a01773062c )
{
    level endon( "game_ended" );
    
    if ( istrue( playbnk ) )
    {
        level thread function_54a492aef8fd981f( var_3a4c75a01773062c );
    }
    
    if ( issharedfuncdefined( "nuke", "delayEndGame" ) )
    {
        [[ getsharedfunc( "nuke", "delayEndGame" ) ]]( delaytime, winner );
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 1
// Checksum 0x0, Offset: 0x378d
// Size: 0x9f
function function_54a492aef8fd981f( delaytime )
{
    level endon( "game_ended" );
    
    if ( isdefined( delaytime ) )
    {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( delaytime );
    }
    
    level notify( "play_nuke_bnk" );
    setomnvarforallclients( "post_game_state", 12 );
    
    if ( !istrue( level.var_587f8a02a3f577 ) )
    {
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            level thread scripts\cp_mp\utility\game_utility::function_852712268d005332( player, 0, 1 );
        }
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x3834
// Size: 0xfa
function nuke_earthquake( owner, streakinfo )
{
    level endon( "nuke_cancelled" );
    earthquakeorigin = level.nukeinfo.goalpoint;
    earthquake( 0.4, 1.5, earthquakeorigin, 100000 );
    level thread nuke_playshockwaveearthquake( streakinfo );
    level waittill( "nuke_death" );
    
    if ( level.nukeinfo.nuketype == "nuke_select_location" )
    {
        earthquake( 0.3, 1, earthquakeorigin, 100000 );
    }
    else
    {
        earthquake( 0.7, 3, earthquakeorigin, 100000 );
    }
    
    foreach ( player in level.players )
    {
        player playrumbleonentity( "damage_heavy" );
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 1
// Checksum 0x0, Offset: 0x3936
// Size: 0x81
function nuke_playshockwaveearthquake( streakinfo )
{
    level endon( "nuke_cancelled" );
    level endon( "nuke_death" );
    earthquakeintensity = 0.01;
    earthquakeorigin = level.nukeinfo.goalpoint;
    
    while ( true )
    {
        earthquake( earthquakeintensity, 0.05, earthquakeorigin, 100000 );
        wait 0.05;
        earthquakeintensity += 0.0015;
        
        if ( earthquakeintensity >= 0.3 )
        {
            earthquakeintensity = 0.3;
        }
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x39bf
// Size: 0x23
function onplayerspawned()
{
    if ( isdefined( level.nukeinfo.detonated ) )
    {
        thread nuke_setvisionforplayer( 0, 0 );
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x39ea
// Size: 0x51
function nuke_setvisionforplayer( delaytime, transitiontime )
{
    if ( isdefined( delaytime ) && delaytime > 0 )
    {
        wait delaytime;
    }
    
    /#
        var_f56513277692f024 = getdvarint( @"hash_aff3efc76e4dfeb2", 1 );
        
        if ( !var_f56513277692f024 )
        {
            return;
        }
    #/
    
    self visionsetnakedforplayer( "nuke_global_aftermath", transitiontime );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 1
// Checksum 0x0, Offset: 0x3a43
// Size: 0x98
function nuke_updateuitimers( traveltime )
{
    level endon( "game_ended" );
    level endon( "disconnect" );
    level endon( "nuke_cancelled" );
    level endon( "nuke_death" );
    var_ef2f4de95e92eec7 = traveltime * 1000 + gettime();
    setomnvar( "ui_nuke_end_milliseconds", var_ef2f4de95e92eec7 );
    level waittill( "host_migration_begin" );
    timepassed = 0;
    
    if ( issharedfuncdefined( "nuke", "hostmigration_waitTillHostMigrationDone" ) )
    {
        timepassed = [[ getsharedfunc( "nuke", "hostmigration_waitLongDurationWithPause" ) ]]();
    }
    
    if ( timepassed > 0 )
    {
        setomnvar( "ui_nuke_end_milliseconds", var_ef2f4de95e92eec7 + timepassed );
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x3ae3
// Size: 0x22
function nuke_updatevisiononhostmigration()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "host_migration_end" );
        level nuke_setaftermathvision( 0 );
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 1
// Checksum 0x0, Offset: 0x3b0d
// Size: 0x6e
function nuke_setaftermathvision( transitiontime )
{
    /#
        var_f56513277692f024 = getdvarint( @"hash_aff3efc76e4dfeb2", 1 );
        
        if ( !var_f56513277692f024 )
        {
            return;
        }
    #/
    
    shouldnukeendgame = 1;
    
    if ( issharedfuncdefined( "nuke", "shouldNukeEndGame" ) )
    {
        shouldnukeendgame = [[ getsharedfunc( "nuke", "shouldNukeEndGame" ) ]]();
    }
    
    if ( !shouldnukeendgame )
    {
        return;
    }
    
    function_e6e629829270e1fa();
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x3b83
// Size: 0x91
function function_e6e629829270e1fa()
{
    setomnvarforallclients( "post_game_state", 11 );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !istrue( level.var_587f8a02a3f577 ) )
        {
            level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer( player, 1 );
        }
        
        player setclienttriggeraudiozonepartialwithfade( "nuke_killstreak", 2, "ambient", "ambient_events" );
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x3c1c
// Size: 0xc7
function nuke_startnukedeathfx()
{
    self endon( "disconnect" );
    
    if ( !istrue( self.safefromnuke ) )
    {
        if ( issharedfuncdefined( "weapons", "enableBurnFX" ) )
        {
            self [[ getsharedfunc( "weapons", "enableBurnFX" ) ]]( 1, "nuke_active" );
        }
    }
    
    thread nuke_playrollingdeathfx( 3.25 );
    level waittill( "nuke_death" );
    
    if ( isdefined( self.burnfxenabled ) && self.burnfxenabled > 0 )
    {
        if ( issharedfuncdefined( "weapons", "disableBurnFX" ) )
        {
            self [[ getsharedfunc( "weapons", "disableBurnFX" ) ]]( 1, "nuke_active" );
        }
    }
    
    var_367958fe652704c6 = 0;
    
    /#
        var_367958fe652704c6 = getdvarint( @"hash_7943c6ec7e44f87c", 0 );
    #/
    
    if ( var_367958fe652704c6 )
    {
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x3ceb
// Size: 0x7a
function nuke_startnukedeathfx_chooselocationversion()
{
    self endon( "disconnect" );
    
    if ( issharedfuncdefined( "weapons", "enableBurnFX" ) )
    {
        self [[ getsharedfunc( "weapons", "enableBurnFX" ) ]]( 1, "nuke_active" );
    }
    
    thread nuke_playrollingdeathfx( 3.25 );
    level waittill( "nuke_death" );
    
    if ( issharedfuncdefined( "weapons", "disableBurnFX" ) )
    {
        self [[ getsharedfunc( "weapons", "disableBurnFX" ) ]]( 1, "nuke_active" );
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 1
// Checksum 0x0, Offset: 0x3d6d
// Size: 0xb1
function nuke_playrollingdeathfx( delaytime )
{
    self endon( "disconnect" );
    
    if ( issharedfuncdefined( "nuke", "hostmigration_waitLongDurationWithPause" ) )
    {
        [[ getsharedfunc( "nuke", "hostmigration_waitLongDurationWithPause" ) ]]( delaytime );
    }
    
    if ( !isusingremote() )
    {
        self visionsetnakedforplayer( "nuke_deathblur", 4 );
    }
    
    fxlocation = self.origin;
    explosionloc = level.nukeinfo.goalpoint;
    bodyloc = fxlocation;
    bodyfx = "nuke_rolling_death";
    playfx( getfx( bodyfx ), fxlocation, explosionloc - bodyloc, undefined, self );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x3e26
// Size: 0x2ca
function nuke_atomizebody()
{
    self endon( "disconnect" );
    loc[ 0 ][ 0 ][ "org" ] = self gettagorigin( "j_spineupper" );
    loc[ 0 ][ 0 ][ "angles" ] = self gettagangles( "j_spineupper" );
    loc[ 0 ][ 1 ][ "org" ] = self gettagorigin( "j_spinelower" );
    loc[ 0 ][ 1 ][ "angles" ] = self gettagangles( "j_spinelower" );
    loc[ 0 ][ 2 ][ "org" ] = self gettagorigin( "j_head" );
    loc[ 0 ][ 2 ][ "angles" ] = self gettagangles( "j_head" );
    loc[ 1 ][ 0 ][ "org" ] = self gettagorigin( "j_knee_ri" );
    loc[ 1 ][ 0 ][ "angles" ] = self gettagangles( "j_knee_ri" );
    loc[ 1 ][ 1 ][ "org" ] = self gettagorigin( "j_knee_le" );
    loc[ 1 ][ 1 ][ "angles" ] = self gettagangles( "j_knee_le" );
    loc[ 1 ][ 2 ][ "org" ] = self gettagorigin( "j_elbow_ri" );
    loc[ 1 ][ 2 ][ "angles" ] = self gettagangles( "j_elbow_ri" );
    loc[ 1 ][ 3 ][ "org" ] = self gettagorigin( "j_elbow_le" );
    loc[ 1 ][ 3 ][ "angles" ] = self gettagangles( "j_elbow_le" );
    loc[ 2 ][ 0 ][ "org" ] = self gettagorigin( "j_ankle_le" );
    loc[ 2 ][ 0 ][ "angles" ] = self gettagangles( "j_ankle_le" );
    loc[ 2 ][ 1 ][ "org" ] = self gettagorigin( "j_ankle_ri" );
    loc[ 2 ][ 1 ][ "angles" ] = self gettagangles( "j_ankle_ri" );
    loc[ 2 ][ 2 ][ "org" ] = self gettagorigin( "j_wrist_le" );
    loc[ 2 ][ 2 ][ "angles" ] = self gettagangles( "j_wrist_le" );
    loc[ 2 ][ 3 ][ "org" ] = self gettagorigin( "j_wrist_ri" );
    loc[ 2 ][ 3 ][ "angles" ] = self gettagangles( "j_wrist_ri" );
    self.body hide();
    fxlocation = self.body.origin;
    inflictorloc = level.nukeinfo.inflictor.origin * ( 1, 1, 0 );
    bodyloc = fxlocation * ( 1, 1, 0 );
    bodyfx = "nuke_atomize_body";
    playfx( getfx( bodyfx ), fxlocation, inflictorloc - bodyloc );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x40f8
// Size: 0x26
function nuke_cankilleverything()
{
    var_cfc1a4c269cffb70 = 1;
    
    if ( getdvarint( @"hash_d5fd9067cafb06b9" ) == 1 )
    {
        return 0;
    }
    
    return var_cfc1a4c269cffb70;
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x4127
// Size: 0x253
function nuke_createradiationzone( owner, streakinfo )
{
    if ( !iscp() )
    {
        if ( false )
        {
            wait 10;
            playfx( getfx( "vfx_nuke_zone_5000_static_s" ), ( 0, 0, 0 ) );
            nuke_registerradzone( ( 0, 0, 0 ) );
            
            if ( !isdefined( level.nukedangerzones ) )
            {
                level.nukedangerzones = [];
            }
            
            level.nukedangerzones[ level.nukedangerzones.size ] = [[ getsharedfunc( "spawn", "addSpawnDangerZone" ) ]]( level.nukeinfo.goalpoint - ( 0, 0, 1000 ), 5000, 15000, "axis", 4000 );
            level.nukedangerzones[ level.nukedangerzones.size ] = [[ getsharedfunc( "spawn", "addSpawnDangerZone" ) ]]( level.nukeinfo.goalpoint - ( 0, 0, 1000 ), 5000, 15000, "allies", 4000 );
        }
        else
        {
            streakinfo.sealevelorigin = ( level.nukeinfo.goalpoint[ 0 ], level.nukeinfo.goalpoint[ 1 ], scripts\cp_mp\parachute::getc130sealevel() );
            playfx( getfx( "vfx_nuke_zone_5000_static_s" ), streakinfo.sealevelorigin );
            nuke_registerradzone( streakinfo.sealevelorigin );
            
            if ( !isdefined( level.nukedangerzones ) )
            {
                level.nukedangerzones = [];
            }
            
            level.nukedangerzones[ level.nukedangerzones.size ] = [[ getsharedfunc( "spawn", "addSpawnDangerZone" ) ]]( level.nukeinfo.goalpoint - ( 0, 0, 1000 ), 5000, 15000, "axis", 4000 );
            level.nukedangerzones[ level.nukedangerzones.size ] = [[ getsharedfunc( "spawn", "addSpawnDangerZone" ) ]]( level.nukeinfo.goalpoint - ( 0, 0, 1000 ), 5000, 15000, "allies", 4000 );
        }
    }
    
    thread nuke_finalizelocationnuke( owner );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 1
// Checksum 0x0, Offset: 0x4382
// Size: 0x41
function nuke_registerradzone( origin )
{
    if ( !isdefined( level.radzones ) )
    {
        level.radzones = [];
        level thread nuke_radzones_think();
    }
    
    level.radzones[ level.radzones.size ] = origin;
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 1
// Checksum 0x0, Offset: 0x43cb
// Size: 0x24
function nuke_removeradzone( zoneent )
{
    level.radzones = array_remove( level.radzones, zoneent );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x43f7
// Size: 0x234
function nuke_radzones_think()
{
    level endon( "game_ended" );
    damagetick = 10;
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            player.inradzone = 0;
            
            foreach ( zoneorigin in level.radzones )
            {
                isplayerinradzone = 0;
                
                if ( issharedfuncdefined( "nuke", "isPlayerInRadZone" ) )
                {
                    isplayerinradzone = [[ getsharedfunc( "nuke", "isPlayerInRadZone" ) ]]( player, zoneorigin, 25000000 );
                }
                
                if ( isplayerinradzone )
                {
                    if ( istrue( player.gasmaskequipped ) )
                    {
                        player scripts\cp_mp\gasmask::processdamage( damagetick );
                    }
                    else
                    {
                        if ( issharedfuncdefined( "game", "tutorialPrint" ) )
                        {
                            player thread [[ getsharedfunc( "game", "tutorialPrint" ) ]]( "MP/NUKE_RADIATION_HURT", 2 );
                        }
                        
                        player dodamage( damagetick, player.origin, player, undefined, "MOD_TRIGGER_HURT" );
                    }
                    
                    player.inradzone = 1;
                    break;
                }
            }
            
            if ( player.inradzone )
            {
                continue;
            }
            
            foreach ( zoneorigin in level.radzones )
            {
                isplayerinradzone = 0;
                
                if ( issharedfuncdefined( "nuke", "isPlayerInRadZone" ) )
                {
                    isplayerinradzone = [[ getsharedfunc( "nuke", "isPlayerInRadZone" ) ]]( player, zoneorigin, 36000000 );
                }
                
                if ( isplayerinradzone )
                {
                    if ( issharedfuncdefined( "game", "tutorialPrint" ) )
                    {
                        player thread [[ getsharedfunc( "game", "tutorialPrint" ) ]]( "MP/NUKE_RADIATION_WARNING", 2 );
                    }
                    
                    break;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 1
// Checksum 0x0, Offset: 0x4633
// Size: 0xa5
function nuke_warnenemiesnukeincoming( var_9464d7d05c5ca6b5 )
{
    level endon( "nuke_death" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player.team == var_9464d7d05c5ca6b5 )
            {
                if ( issharedfuncdefined( "game", "tutorialPrint" ) )
                {
                    player thread [[ getsharedfunc( "game", "tutorialPrint" ) ]]( "MP/NUKE_SELECT_LAUNCH_DETECTED", 2 );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 1
// Checksum 0x0, Offset: 0x46e0
// Size: 0x53
function nuke_finalizelocationnuke( owner )
{
    wait 20;
    
    if ( istrue( owner.hasnukeselectks ) )
    {
        owner.hasnukeselectks = 0;
    }
    
    if ( isdefined( owner.killcountthislife ) )
    {
        owner.killcountthislife = 0;
    }
    
    visionsetnaked( "", 1 );
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 0
// Checksum 0x0, Offset: 0x473b
// Size: 0x3f
function nuke_abortkillcamonspawn()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        
        if ( isdefined( player ) )
        {
            player notify( "abort_killcam" );
            player.cancelkillcam = 1;
        }
    }
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x4782
// Size: 0xd3
function function_b913fa4052092442( nuketype, goalposoverride )
{
    goalpoint = self.origin + anglestoforward( self.angles ) * 15000;
    
    if ( isdefined( level.nuke_expl_struct ) )
    {
        goalpoint = level.nuke_expl_struct.origin;
    }
    
    if ( nuketype == "nuke_multi" )
    {
        goalpoint = level.mapcenter;
        
        if ( islargemap() )
        {
            if ( level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "gwtdm" )
            {
                if ( isdefined( level.hqmidpoint ) )
                {
                    goalpoint = level.hqmidpoint;
                }
            }
        }
    }
    
    if ( isdefined( goalposoverride ) )
    {
        goalpoint = goalposoverride;
    }
    
    return goalpoint;
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 3
// Checksum 0x0, Offset: 0x485e
// Size: 0x107
function function_5e29f303004c9602( nuketype, goalpoint, launchposoverride )
{
    launchpoint = goalpoint + ( 0, 0, 30000 ) + anglestoforward( self.angles ) * 30000;
    
    if ( nuketype == "nuke_multi" )
    {
        launchpoint = goalpoint + ( 0, 0, 15000 ) + anglestoforward( self.angles ) * 15000;
    }
    else if ( isdefined( level.nuke_expl_struct ) )
    {
        var_48a3e962b69604ac = vectornormalize( ( goalpoint[ 0 ], goalpoint[ 1 ], 0 ) - ( self.origin[ 0 ], self.origin[ 1 ], 0 ) );
        launchpoint = goalpoint + var_48a3e962b69604ac * 15000;
        launchpoint = launchpoint + ( 0, 0, 30000 ) + var_48a3e962b69604ac * 5000;
    }
    else if ( nuketype != "nuke_select_location" )
    {
        /#
            self iprintlnbold( "<dev string:x1c>" );
        #/
    }
    
    if ( isdefined( launchposoverride ) )
    {
        var_ffb179778403bed7 = launchposoverride;
    }
    
    return launchpoint;
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 3
// Checksum 0x0, Offset: 0x496e
// Size: 0x44
function function_4eb440a17165aeee( nuketype, starttime, starttimeoverride )
{
    starttimer = starttime;
    
    if ( istrue( level.mercywintriggered ) )
    {
        starttimer = 0.7;
    }
    
    if ( isdefined( starttimeoverride ) )
    {
        starttimer = starttimeoverride;
    }
    
    return starttimer;
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 3
// Checksum 0x0, Offset: 0x49bb
// Size: 0x30
function function_cd3712661b44dfb( nuketype, explodetime, var_3dabfa23bef362b5 )
{
    explodetimer = explodetime;
    
    if ( isdefined( var_3dabfa23bef362b5 ) )
    {
        explodetimer = var_3dabfa23bef362b5;
    }
    
    return explodetimer;
}

// Namespace nuke / scripts\cp_mp\killstreaks\nuke
// Params 2
// Checksum 0x0, Offset: 0x49f4
// Size: 0x3d
function nuke_getweapon( nuketype, weaponoverride )
{
    baseweapon = "nuke_mp";
    
    if ( nuketype == "nuke_multi" )
    {
        baseweapon = "nuke_multi_mp";
    }
    
    if ( isdefined( weaponoverride ) )
    {
        baseweapon = weaponoverride;
    }
    
    return baseweapon;
}

