#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\gamescore;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;

#namespace remoteuav;

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0xb8b
// Size: 0x2bf
function init()
{
    level.remoteuav_fx[ "explode" ] = loadfx( "vfx/core/expl/bouncing_betty_explosion" );
    level.remoteuav_fx[ "missile_explode" ] = loadfx( "vfx/iw8_mp/killstreak/vfx_apache_explosion" );
    level.remoteuav_dialog[ "launch" ][ 0 ] = "ac130_plt_yeahcleared";
    level.remoteuav_dialog[ "launch" ][ 1 ] = "ac130_plt_rollinin";
    level.remoteuav_dialog[ "launch" ][ 2 ] = "ac130_plt_scanrange";
    level.remoteuav_dialog[ "out_of_range" ][ 0 ] = "ac130_plt_cleanup";
    level.remoteuav_dialog[ "out_of_range" ][ 1 ] = "ac130_plt_targetreset";
    level.remoteuav_dialog[ "track" ][ 0 ] = "ac130_fco_moreenemy";
    level.remoteuav_dialog[ "track" ][ 1 ] = "ac130_fco_getthatguy";
    level.remoteuav_dialog[ "track" ][ 2 ] = "ac130_fco_guymovin";
    level.remoteuav_dialog[ "track" ][ 3 ] = "ac130_fco_getperson";
    level.remoteuav_dialog[ "track" ][ 4 ] = "ac130_fco_guyrunnin";
    level.remoteuav_dialog[ "track" ][ 5 ] = "ac130_fco_gotarunner";
    level.remoteuav_dialog[ "track" ][ 6 ] = "ac130_fco_backonthose";
    level.remoteuav_dialog[ "track" ][ 7 ] = "ac130_fco_gonnagethim";
    level.remoteuav_dialog[ "track" ][ 8 ] = "ac130_fco_personnelthere";
    level.remoteuav_dialog[ "track" ][ 9 ] = "ac130_fco_rightthere";
    level.remoteuav_dialog[ "track" ][ 10 ] = "ac130_fco_tracking";
    level.remoteuav_dialog[ "tag" ][ 0 ] = "ac130_fco_nice";
    level.remoteuav_dialog[ "tag" ][ 1 ] = "ac130_fco_yougothim";
    level.remoteuav_dialog[ "tag" ][ 2 ] = "ac130_fco_yougothim2";
    level.remoteuav_dialog[ "tag" ][ 3 ] = "ac130_fco_okyougothim";
    level.remoteuav_dialog[ "assist" ][ 0 ] = "ac130_fco_goodkill";
    level.remoteuav_dialog[ "assist" ][ 1 ] = "ac130_fco_thatsahit";
    level.remoteuav_dialog[ "assist" ][ 2 ] = "ac130_fco_directhit";
    level.remoteuav_dialog[ "assist" ][ 3 ] = "ac130_fco_rightontarget";
    level.remoteuav_lastdialogtime = 0;
    level.remoteuav_nodeployzones = getentarray( "no_vehicles", "targetname" );
    assertmsg( "<dev string:x1c>" );
    level.remote_uav = [];
    
    /#
        setdevdvarifuninitialized( @"hash_da7c6c2551fb9f41", 60 );
    #/
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 2
// Checksum 0x0, Offset: 0xe52
// Size: 0x1f
function useremoteuav( lifeid, streakname )
{
    return tryuseremoteuav( lifeid, "remote_uav" );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0xe7a
// Size: 0x63
function exceededmaxremoteuavs( team )
{
    if ( getgametype() == "dm" )
    {
        if ( isdefined( level.remote_uav[ team ] ) || isdefined( level.remote_uav[ getotherteam( team )[ 0 ] ] ) )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    if ( isdefined( level.remote_uav[ team ] ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 2
// Checksum 0x0, Offset: 0xee5
// Size: 0x16a
function tryuseremoteuav( lifeid, streakname )
{
    val::set( "remote_uav", "usability", 0 );
    
    if ( isusingremote() || self isusingturret() || isdefined( level.nukeinfo.incoming ) )
    {
        val::reset_all( "remote_uav" );
        return 0;
    }
    
    var_4440147083abaf0a = 1;
    
    if ( exceededmaxremoteuavs( self.team ) || level.littlebirds.size >= 4 )
    {
        self iprintlnbold( &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        val::reset_all( "remote_uav" );
        return 0;
    }
    else if ( currentactivevehiclecount() >= maxvehiclesallowed() || level.fauxvehiclecount + var_4440147083abaf0a >= maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS/TOO_MANY_VEHICLES" );
        val::reset_all( "remote_uav" );
        return 0;
    }
    
    self setplayerdata( "reconDroneState", "staticAlpha", 0 );
    self setplayerdata( "reconDroneState", "incomingMissile", 0 );
    incrementfauxvehiclecount();
    result = givecarryremoteuav( lifeid, streakname );
    
    if ( result )
    {
        utility::trycall( level.matchdata_logkillstreakevent, streakname, self.origin );
        thread teamplayercardsplash( "used_remote_uav", self );
    }
    else
    {
        decrementfauxvehiclecount();
    }
    
    self.iscarrying = 0;
    return result;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 2
// Checksum 0x0, Offset: 0x1058
// Size: 0xde
function givecarryremoteuav( lifeid, streakname )
{
    carryremoteuav = createcarryremoteuav( streakname, self );
    _takeweapon( "killstreak_uav_mp" );
    _giveweapon( "killstreak_remote_uav_mp" );
    _switchtoweaponimmediate( "killstreak_remote_uav_mp" );
    setcarryingremoteuav( carryremoteuav );
    
    if ( isalive( self ) && isdefined( carryremoteuav ) )
    {
        origin = carryremoteuav.origin;
        angles = self.angles;
        carryremoteuav.soundent delete();
        carryremoteuav delete();
        result = startremoteuav( lifeid, streakname, origin, angles );
    }
    else
    {
        result = 0;
        
        if ( isalive( self ) )
        {
            _takeweapon( "killstreak_remote_uav_mp" );
            _giveweapon( "killstreak_uav_mp" );
        }
    }
    
    return result;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 2
// Checksum 0x0, Offset: 0x113f
// Size: 0x204
function createcarryremoteuav( streakname, owner )
{
    pos = owner.origin + anglestoforward( owner.angles ) * 4 + anglestoup( owner.angles ) * 50;
    carryremoteuav = spawnturret( "misc_turret", pos, "sentry_minigun_mp" );
    carryremoteuav.origin = pos;
    carryremoteuav.angles = owner.angles;
    carryremoteuav.sentrytype = "sentry_minigun";
    carryremoteuav.canbeplaced = 1;
    carryremoteuav setturretmodechangewait( 1 );
    carryremoteuav setmode( "sentry_offline" );
    carryremoteuav makeunusable();
    carryremoteuav maketurretinoperable();
    carryremoteuav.owner = owner;
    carryremoteuav setsentryowner( carryremoteuav.owner );
    carryremoteuav.scale = 3;
    carryremoteuav.inheliproximity = 0;
    carryremoteuav thread carryremoteuav_handleexistence();
    carryremoteuav.rangetrigger = getent( "remote_uav_range", "targetname" );
    
    if ( !isdefined( carryremoteuav.rangetrigger ) )
    {
        heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
        carryremoteuav.maxheight = heightent.origin[ 2 ];
        carryremoteuav.maxdistance = 3600;
    }
    
    carryremoteuav.soundent = spawn( "script_origin", carryremoteuav.origin );
    carryremoteuav.soundent.angles = carryremoteuav.angles;
    carryremoteuav.soundent.origin = carryremoteuav.origin;
    carryremoteuav.soundent linkto( carryremoteuav );
    carryremoteuav.soundent playloopsound( "recondrone_idle_high" );
    return carryremoteuav;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x134c
// Size: 0x177
function setcarryingremoteuav( carryremoteuav )
{
    carryremoteuav thread carryremoteuav_setcarried( self );
    self notifyonplayercommand( "place_carryRemoteUAV", "+attack" );
    self notifyonplayercommand( "place_carryRemoteUAV", "+attack_akimbo_accessible" );
    self notifyonplayercommand( "cancel_carryRemoteUAV", "+actionslot 4" );
    
    if ( !self isconsoleplayer() )
    {
        self notifyonplayercommand( "cancel_carryRemoteUAV", "+actionslot 5" );
        self notifyonplayercommand( "cancel_carryRemoteUAV", "+actionslot 6" );
        self notifyonplayercommand( "cancel_carryRemoteUAV", "+actionslot 7" );
    }
    
    for ( ;; )
    {
        result = local_waittill_any_return_6( "place_carryRemoteUAV", "cancel_carryRemoteUAV", "weapon_switch_started", "force_cancel_placement", "death_or_disconnect" );
        self forceusehintoff();
        
        if ( result != "place_carryRemoteUAV" )
        {
            carryremoteuav_delete( carryremoteuav );
            break;
        }
        
        if ( !carryremoteuav.canbeplaced )
        {
            if ( self.team != "spectator" )
            {
                self forceusehinton( &"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE" );
            }
            
            continue;
        }
        
        if ( exceededmaxremoteuavs( self.team ) || currentactivevehiclecount() >= maxvehiclesallowed() || level.fauxvehiclecount >= maxvehiclesallowed() )
        {
            self iprintlnbold( &"KILLSTREAKS/TOO_MANY_VEHICLES" );
            carryremoteuav_delete( carryremoteuav );
            break;
        }
        
        self.iscarrying = 0;
        carryremoteuav.carriedby = undefined;
        carryremoteuav playsound( "sentry_gun_plant" );
        carryremoteuav notify( "placed" );
        break;
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 6
// Checksum 0x0, Offset: 0x14cb
// Size: 0x121
function local_waittill_any_return_6( string1, string2, string3, string4, string5, string6 )
{
    if ( ( !isdefined( string1 ) || string1 != "death" ) && ( !isdefined( string2 ) || string2 != "death" ) && ( !isdefined( string3 ) || string3 != "death" ) && ( !isdefined( string4 ) || string4 != "death" ) && ( !isdefined( string5 ) || string5 != "death" ) )
    {
        self endon( "death" );
    }
    
    ent = spawnstruct();
    
    if ( isdefined( string1 ) )
    {
        thread waittill_string( string1, ent );
    }
    
    if ( isdefined( string2 ) )
    {
        thread waittill_string( string2, ent );
    }
    
    if ( isdefined( string3 ) )
    {
        thread waittill_string( string3, ent );
    }
    
    if ( isdefined( string4 ) )
    {
        thread waittill_string( string4, ent );
    }
    
    if ( isdefined( string5 ) )
    {
        thread waittill_string( string5, ent );
    }
    
    if ( isdefined( string6 ) )
    {
        thread waittill_string( string6, ent );
    }
    
    ent waittill( "returned", msg );
    ent notify( "die" );
    return msg;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x15f5
// Size: 0x4c
function carryremoteuav_setcarried( carrier )
{
    self setcandamage( 0 );
    self setsentrycarrier( carrier );
    self notsolid();
    self.carriedby = carrier;
    carrier.iscarrying = 1;
    carrier thread updatecarryremoteuavplacement( self );
    self notify( "carried" );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x1649
// Size: 0x41
function carryremoteuav_delete( carryremoteuav )
{
    self.iscarrying = 0;
    
    if ( isdefined( carryremoteuav ) )
    {
        if ( isdefined( carryremoteuav.soundent ) )
        {
            carryremoteuav.soundent delete();
        }
        
        carryremoteuav delete();
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x1692
// Size: 0x77, Type: bool
function isinremotenodeploy()
{
    if ( isdefined( level.remoteuav_nodeployzones ) && level.remoteuav_nodeployzones.size )
    {
        foreach ( zone in level.remoteuav_nodeployzones )
        {
            if ( self istouching( zone ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x1712
// Size: 0x1a8
function updatecarryremoteuavplacement( carryremoteuav )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    carryremoteuav endon( "placed" );
    carryremoteuav endon( "death" );
    carryremoteuav.canbeplaced = 1;
    var_b89a549815ee28d3 = -1;
    val::reset_all( "remote_uav" );
    
    for ( ;; )
    {
        heightoffset = 18;
        
        switch ( self getstance() )
        {
            case #"hash_c6775c88e38f7803":
                heightoffset = 40;
                break;
            case #"hash_3fed0cbd303639eb":
                heightoffset = 25;
                break;
            case #"hash_d91940431ed7c605":
                heightoffset = 10;
                break;
        }
        
        placement = self canplayerplacetank( 22, 22, 50, heightoffset, 0, 0 );
        carryremoteuav.origin = placement[ "origin" ] + anglestoup( self.angles ) * ( 18 - -9 );
        carryremoteuav.angles = placement[ "angles" ];
        carryremoteuav.canbeplaced = self isonground() && placement[ "result" ] && carryremoteuav remoteuav_in_range() && !carryremoteuav isinremotenodeploy();
        
        if ( carryremoteuav.canbeplaced != var_b89a549815ee28d3 )
        {
            if ( carryremoteuav.canbeplaced )
            {
                if ( self.team != "spectator" )
                {
                    self forceusehinton( &"KILLSTREAKS_REMOTE_UAV_PLACE" );
                }
                
                if ( self attackbuttonpressed() )
                {
                    self notify( "place_carryRemoteUAV" );
                }
            }
            else if ( self.team != "spectator" )
            {
                self forceusehinton( &"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE" );
            }
        }
        
        var_b89a549815ee28d3 = carryremoteuav.canbeplaced;
        waitframe();
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x18c2
// Size: 0x6e
function carryremoteuav_handleexistence()
{
    level endon( "game_ended" );
    self.owner endon( "place_carryRemoteUAV" );
    self.owner endon( "cancel_carryRemoteUAV" );
    self.owner waittill_any_3( "death_or_disconnect", "joined_team", "joined_spectators" );
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.soundent ) )
        {
            self.soundent delete();
        }
        
        self delete();
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x1938
// Size: 0x16
function removeremoteweapon()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    wait 0.7;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 4
// Checksum 0x0, Offset: 0x1956
// Size: 0x163
function startremoteuav( lifeid, streakname, origin, angles )
{
    lockplayerforremoteuavlaunch();
    setusingremote( streakname );
    _giveweapon( "uav_remote_mp" );
    _switchtoweaponimmediate( "uav_remote_mp" );
    self visionsetnakedforplayer( "black_bw", 0 );
    result = scripts\mp\killstreaks\killstreaks::initridekillstreak( "remote_uav" );
    
    if ( result != "success" )
    {
        if ( result != "disconnect" )
        {
            self notify( "remoteuav_unlock" );
            _takeweapon( "uav_remote_mp" );
            clearusingremote();
        }
        
        val::reset_all( "ride_killstreak" );
        return 0;
    }
    
    if ( exceededmaxremoteuavs( self.team ) || currentactivevehiclecount() >= maxvehiclesallowed() || level.fauxvehiclecount >= maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS/TOO_MANY_VEHICLES" );
        self notify( "remoteuav_unlock" );
        _takeweapon( "uav_remote_mp" );
        clearusingremote();
        return 0;
    }
    
    self notify( "remoteuav_unlock" );
    remoteuav = createremoteuav( lifeid, self, streakname, origin, angles );
    
    if ( isdefined( remoteuav ) )
    {
        thread remoteuav_ride( lifeid, remoteuav, streakname );
        return 1;
    }
    
    self iprintlnbold( &"KILLSTREAKS/TOO_MANY_VEHICLES" );
    _takeweapon( "uav_remote_mp" );
    clearusingremote();
    return 0;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x1ac1
// Size: 0x39
function lockplayerforremoteuavlaunch()
{
    lockspot = spawn( "script_origin", self.origin );
    lockspot hide();
    self playerlinkto( lockspot );
    thread clearplayerlockfromremoteuavlaunch( lockspot );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x1b02
// Size: 0x46
function clearplayerlockfromremoteuavlaunch( lockspot )
{
    level endon( "game_ended" );
    msg = waittill_any_return_2( "death_or_disconnect", "remoteuav_unlock" );
    
    if ( msg != "disconnect" )
    {
        self unlink();
    }
    
    lockspot delete();
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 5
// Checksum 0x0, Offset: 0x1b50
// Size: 0x23b
function createremoteuav( lifeid, owner, streakname, origin, angles )
{
    if ( owner isconsoleplayer() )
    {
        remoteuav = spawnhelicopter( owner, origin, angles, "remote_uav_mp", "vehicle_remote_uav" );
    }
    else
    {
        remoteuav = spawnhelicopter( owner, origin, angles, "remote_uav_mp_pc", "vehicle_remote_uav" );
    }
    
    if ( !isdefined( remoteuav ) )
    {
        return undefined;
    }
    
    assertmsg( "<dev string:x7b>" );
    remoteuav makevehiclesolidcapsule( 18, -9, 18 );
    remoteuav.lifeid = lifeid;
    remoteuav.team = owner.team;
    remoteuav.pers[ "team" ] = owner.team;
    remoteuav.owner = owner;
    remoteuav setotherent( owner );
    remoteuav scripts\mp\sentientpoolmanager::registersentient( "Killstreak_Air", owner );
    remoteuav.maxhealth = 250;
    remoteuav.scrambler = spawn( "script_model", origin );
    remoteuav.scrambler linkto( remoteuav, "tag_origin", ( 0, 0, -160 ), ( 0, 0, 0 ) );
    remoteuav.scrambler makescrambler( owner );
    remoteuav.smoking = 0;
    remoteuav.inheliproximity = 0;
    remoteuav.helitype = "remote_uav";
    remoteuav.markedplayers = [];
    remoteuav thread remoteuav_light_fx();
    remoteuav thread remoteuav_explode_on_disconnect();
    remoteuav thread remoteuav_explode_on_changeteams();
    remoteuav thread remoteuav_explode_on_death();
    remoteuav thread remoteuav_clear_marked_on_gameended();
    remoteuav thread remoteuav_leave_on_timeout();
    remoteuav thread remoteuav_watch_distance();
    remoteuav thread remoteuav_watchheliproximity();
    remoteuav thread remoteuav_handledamage();
    remoteuav.numflares = 2;
    remoteuav.hasincoming = 0;
    remoteuav.incomingmissiles = [];
    remoteuav thread remoteuav_clearincomingwarning();
    remoteuav thread remoteuav_handleincomingstinger();
    remoteuav thread remoteuav_handleincomingsam();
    level.remote_uav[ remoteuav.team ] = remoteuav;
    return remoteuav;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 3
// Checksum 0x0, Offset: 0x1d94
// Size: 0xbb
function remoteuav_ride( lifeid, remoteuav, streakname )
{
    remoteuav.playerlinked = 1;
    self.restoreangles = self.angles;
    
    if ( getdvarint( @"camera_thirdperson" ) )
    {
        setthirdpersondof( 0 );
    }
    
    self cameralinkto( remoteuav, "tag_origin" );
    self remotecontrolvehicle( remoteuav );
    thread remoteuav_playerexit( remoteuav );
    thread remoteuav_track( remoteuav );
    thread remoteuav_fire( remoteuav );
    self.remote_uav_ridelifeid = lifeid;
    self.remoteuav = remoteuav;
    thread remoteuav_delaylaunchdialog( remoteuav );
    self visionsetnakedforplayer( "black_bw", 0 );
    restorebasevisionset( 1 );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x1e57
// Size: 0x3d
function remoteuav_delaylaunchdialog( remoteuav )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    remoteuav endon( "death" );
    remoteuav endon( "end_remote" );
    remoteuav endon( "end_launch_dialog" );
    wait 3;
    remoteuav_dialog( "launch" );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x1e9c
// Size: 0xb7
function remoteuav_endride( remoteuav )
{
    if ( isdefined( remoteuav ) )
    {
        remoteuav.playerlinked = 0;
        remoteuav notify( "end_remote" );
        clearusingremote();
        
        if ( getdvarint( @"camera_thirdperson" ) )
        {
            setthirdpersondof( 1 );
        }
        
        self cameraunlink( remoteuav );
        self remotecontrolvehicleoff( remoteuav );
        self thermalvisionoff();
        self setplayerangles( self.restoreangles );
        objlastweapon = getlastweapon();
        
        if ( !self hasweapon( objlastweapon ) )
        {
            objlastweapon = getfirstprimaryweapon();
        }
        
        _switchtoweapon( objlastweapon );
        _takeweapon( "uav_remote_mp" );
        thread remoteuav_freezebuffer();
    }
    
    self.remoteuav = undefined;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x1f5b
// Size: 0x33
function remoteuav_freezebuffer()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    _freezecontrols( 1, undefined, "remoteuav" );
    wait 0.5;
    _freezecontrols( 0, undefined, "remoteuav" );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x1f96
// Size: 0x7a
function remoteuav_playerexit( remoteuav )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    remoteuav endon( "death" );
    remoteuav endon( "end_remote" );
    wait 2;
    updaterate = level.framedurationseconds;
    
    while ( true )
    {
        timeused = 0;
        
        while ( self usebuttonpressed() )
        {
            timeused += updaterate;
            
            if ( timeused > 0.75 )
            {
                remoteuav thread remoteuav_leave();
                return;
            }
            
            wait updaterate;
        }
        
        waitframe();
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x2018
// Size: 0x2c4
function remoteuav_track( remoteuav )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    remoteuav endon( "death" );
    remoteuav endon( "end_remote" );
    remoteuav.lasttrackingdialogtime = 0;
    self.lockedtarget = undefined;
    self weaponlockfree();
    wait 1;
    
    while ( true )
    {
        pos = remoteuav gettagorigin( "tag_turret" );
        forward = anglestoforward( self getplayerangles() );
        endpos = pos + forward * 1024;
        trace = scripts\engine\trace::_bullet_trace( pos, endpos, 1, remoteuav );
        
        if ( isdefined( trace[ "position" ] ) )
        {
            targetpos = trace[ "position" ];
        }
        else
        {
            targetpos = endpos;
            trace[ "endpos" ] = endpos;
        }
        
        remoteuav.trace = trace;
        lockedplayer = remoteuav_trackentities( remoteuav, level.players, targetpos );
        lockedturret = remoteuav_trackentities( remoteuav, level.turrets, targetpos );
        lockeduav = undefined;
        
        if ( level.teambased )
        {
            entitylist = [];
            enemyteams = getenemyteams( self.team );
            
            foreach ( entry in level.teamnamelist )
            {
                foreach ( model in level.uavmodels[ entry ] )
                {
                    entitylist[ entitylist.size ] = model;
                }
            }
            
            lockeduav = remoteuav_trackentities( remoteuav, entitylist, targetpos );
        }
        else
        {
            lockeduav = remoteuav_trackentities( remoteuav, level.uavmodels, targetpos );
        }
        
        lockedtarget = undefined;
        
        if ( isdefined( lockedplayer ) )
        {
            lockedtarget = lockedplayer;
        }
        else if ( isdefined( lockedturret ) )
        {
            lockedtarget = lockedturret;
        }
        else if ( isdefined( lockeduav ) )
        {
            lockedtarget = lockeduav;
        }
        
        if ( isdefined( lockedtarget ) )
        {
            if ( !isdefined( self.lockedtarget ) || isdefined( self.lockedtarget ) && self.lockedtarget != lockedtarget )
            {
                self weaponlockfinalize( lockedtarget );
                self.lockedtarget = lockedtarget;
                
                if ( isdefined( lockedplayer ) )
                {
                    remoteuav notify( "end_launch_dialog" );
                    remoteuav_dialog( "track" );
                }
            }
        }
        else
        {
            self weaponlockfree();
            self.lockedtarget = undefined;
        }
        
        wait 0.05;
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 3
// Checksum 0x0, Offset: 0x22e4
// Size: 0x578
function remoteuav_trackentities( remoteuav, entities, targetpos )
{
    level endon( "game_ended" );
    lockedtarget = undefined;
    
    foreach ( entity in entities )
    {
        if ( level.teambased && ( !isdefined( entity.team ) || entity.team == self.team ) )
        {
            continue;
        }
        
        if ( isplayer( entity ) )
        {
            if ( !isreallyalive( entity ) )
            {
                continue;
            }
            
            if ( entity == self )
            {
                continue;
            }
            
            id = entity.guid;
        }
        else
        {
            id = entity.birthtime;
        }
        
        if ( isdefined( entity.sentrytype ) || isdefined( entity.turrettype ) )
        {
            offset = 32;
            var_ee22627fdcfe58bf = "hud_fofbox_hostile_vehicle";
        }
        else if ( isdefined( entity.uavtype ) )
        {
            offset = -52;
            var_ee22627fdcfe58bf = "hud_fofbox_hostile_vehicle";
        }
        else
        {
            offset = 26;
            var_ee22627fdcfe58bf = "veh_hud_target_unmarked";
        }
        
        if ( isdefined( entity.uavremotemarkedby ) )
        {
            if ( !isdefined( remoteuav.markedplayers[ id ] ) )
            {
                remoteuav.markedplayers[ id ] = [];
                remoteuav.markedplayers[ id ][ "player" ] = entity;
                remoteuav.markedplayers[ id ][ "icon" ] = entity thread scripts\cp_mp\entityheadicons::setheadicon_singleimage( self, "veh_hud_target_marked", offset );
                remoteuav.markedplayers[ id ][ "icon" ].shader = "veh_hud_target_marked";
                
                if ( !isdefined( entity.sentrytype ) || !isdefined( entity.turrettype ) )
                {
                    remoteuav.markedplayers[ id ][ "icon" ] settargetent( entity );
                }
            }
            else if ( isdefined( remoteuav.markedplayers[ id ] ) && isdefined( remoteuav.markedplayers[ id ][ "icon" ] ) && isdefined( remoteuav.markedplayers[ id ][ "icon" ].shader ) && remoteuav.markedplayers[ id ][ "icon" ].shader != "veh_hud_target_marked" )
            {
                remoteuav.markedplayers[ id ][ "icon" ].shader = "veh_hud_target_marked";
                remoteuav.markedplayers[ id ][ "icon" ] setshader( "veh_hud_target_marked", 10, 10 );
                remoteuav.markedplayers[ id ][ "icon" ] setwaypoint( 0, 0, 0, 0 );
            }
            
            continue;
        }
        
        if ( isplayer( entity ) )
        {
            spawnprotected = isdefined( entity.spawntime ) && ( gettime() - entity.spawntime ) / 1000 <= 5;
            var_63c3dab9425623f3 = entity _hasperk( "specialty_blindeye" );
            carried = 0;
            leaving = 0;
        }
        else
        {
            spawnprotected = 0;
            var_63c3dab9425623f3 = 0;
            carried = isdefined( entity.carriedby );
            leaving = isdefined( entity.isleaving ) && entity.isleaving == 1;
        }
        
        if ( !isdefined( remoteuav.markedplayers[ id ] ) && !spawnprotected && !var_63c3dab9425623f3 && !carried && !leaving )
        {
            remoteuav.markedplayers[ id ] = [];
            remoteuav.markedplayers[ id ][ "player" ] = entity;
            remoteuav.markedplayers[ id ][ "icon" ] = entity scripts\cp_mp\entityheadicons::setheadicon_singleimage( self, var_ee22627fdcfe58bf, offset );
            remoteuav.markedplayers[ id ][ "icon" ].shader = var_ee22627fdcfe58bf;
            
            if ( !isdefined( entity.sentrytype ) || !isdefined( entity.turrettype ) )
            {
                remoteuav.markedplayers[ id ][ "icon" ] settargetent( entity );
            }
        }
        
        if ( ( !isdefined( lockedtarget ) || lockedtarget != entity ) && isdefined( remoteuav.trace[ "entity" ] ) && remoteuav.trace[ "entity" ] == entity && !carried && !leaving || distance( entity.origin, targetpos ) < 200 * remoteuav.trace[ "fraction" ] && !spawnprotected && !carried && !leaving || !leaving && remoteuav_cantargetuav( remoteuav, entity ) )
        {
            trace = scripts\engine\trace::_bullet_trace( remoteuav.origin, entity.origin + ( 0, 0, 32 ), 1, remoteuav );
            
            if ( isdefined( trace[ "entity" ] ) && trace[ "entity" ] == entity || trace[ "fraction" ] == 1 )
            {
                self playlocalsound( "recondrone_lockon" );
                lockedtarget = entity;
            }
        }
    }
    
    return lockedtarget;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 2
// Checksum 0x0, Offset: 0x2865
// Size: 0x7e, Type: bool
function remoteuav_cantargetuav( remoteuav, uav )
{
    if ( isdefined( uav.uavtype ) )
    {
        forward = anglestoforward( self getplayerangles() );
        touav = vectornormalize( uav.origin - remoteuav gettagorigin( "tag_turret" ) );
        dot = vectordot( forward, touav );
        
        if ( dot > 0.985 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x28ec
// Size: 0xa7
function remoteuav_fire( remoteuav )
{
    self endon( "disconnect" );
    remoteuav endon( "death" );
    level endon( "game_ended" );
    remoteuav endon( "end_remote" );
    wait 1;
    self notifyonplayercommand( "remoteUAV_tag", "+attack" );
    self notifyonplayercommand( "remoteUAV_tag", "+attack_akimbo_accessible" );
    
    while ( true )
    {
        self waittill( "remoteUAV_tag" );
        
        if ( isdefined( self.lockedtarget ) )
        {
            self playlocalsound( "recondrone_tag" );
            updatedamagefeedback( "" );
            thread remoteuav_markplayer( self.lockedtarget );
            thread remoteuav_rumble( remoteuav, 3 );
            wait 0.25;
            continue;
        }
        
        waitframe();
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 2
// Checksum 0x0, Offset: 0x299b
// Size: 0x69
function remoteuav_rumble( remoteuav, amount )
{
    self endon( "disconnect" );
    remoteuav endon( "death" );
    level endon( "game_ended" );
    remoteuav endon( "end_remote" );
    remoteuav notify( "end_rumble" );
    remoteuav endon( "end_rumble" );
    
    for ( i = 0; i < amount ; i++ )
    {
        self playrumbleonentity( "damage_heavy" );
        wait 0.05;
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x2a0c
// Size: 0x29e
function remoteuav_markplayer( targetplayer )
{
    level endon( "game_ended" );
    targetplayer.uavremotemarkedby = self;
    
    if ( isplayer( targetplayer ) && !targetplayer isusingremote() )
    {
    }
    else if ( isdefined( targetplayer.uavtype ) )
    {
        targetplayer.birth_time = targetplayer.birthtime;
    }
    else if ( isdefined( targetplayer.owner ) && isalive( targetplayer.owner ) )
    {
        targetplayer.owner thread scripts\mp\rank::scoreeventpopup( #"hash_508e80998122a1a4" );
    }
    
    remoteuav_dialog( "tag" );
    
    if ( getgametype() != "dm" )
    {
        if ( isplayer( targetplayer ) )
        {
            thread doscoreevent( #"kill" );
        }
    }
    
    if ( isplayer( targetplayer ) )
    {
        targetplayer setperk( "specialty_radarblip", 1 );
    }
    else
    {
        if ( isdefined( targetplayer.uavtype ) )
        {
            shadername = "compassping_enemy_uav";
        }
        else
        {
            shadername = "compassping_sentry_enemy";
        }
        
        if ( level.teambased )
        {
            curobjid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
            
            if ( curobjid != -1 )
            {
                scripts\mp\objidpoolmanager::objective_add_objective( curobjid, "invisible", ( 0, 0, 0 ) );
                scripts\mp\objidpoolmanager::update_objective_onentity( curobjid, targetplayer );
                scripts\mp\objidpoolmanager::update_objective_state( curobjid, "active" );
                scripts\mp\objidpoolmanager::objective_teammask_single( curobjid, self.team );
                scripts\mp\objidpoolmanager::update_objective_icon( curobjid, shadername );
                scripts\mp\objidpoolmanager::update_objective_setbackground( curobjid, 1 );
            }
            
            targetplayer.remoteuavmarkedobjid01 = curobjid;
        }
        else
        {
            curobjid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
            
            if ( curobjid != -1 )
            {
                scripts\mp\objidpoolmanager::objective_add_objective( curobjid, "invisible", ( 0, 0, 0 ) );
                scripts\mp\objidpoolmanager::update_objective_onentity( curobjid, targetplayer );
                scripts\mp\objidpoolmanager::update_objective_state( curobjid, "active" );
                scripts\mp\objidpoolmanager::objective_teammask_single( curobjid, getotherteam( self.team )[ 0 ] );
                scripts\mp\objidpoolmanager::update_objective_icon( curobjid, shadername );
                scripts\mp\objidpoolmanager::update_objective_setbackground( curobjid, 1 );
            }
            
            targetplayer.remoteuavmarkedobjid02 = curobjid;
            curobjid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
            
            if ( curobjid != -1 )
            {
                scripts\mp\objidpoolmanager::objective_add_objective( curobjid, "invisible", ( 0, 0, 0 ) );
                scripts\mp\objidpoolmanager::update_objective_onentity( curobjid, targetplayer );
                scripts\mp\objidpoolmanager::update_objective_state( curobjid, "active" );
                scripts\mp\objidpoolmanager::objective_teammask_single( curobjid, self.team );
                scripts\mp\objidpoolmanager::update_objective_icon( curobjid, shadername );
                scripts\mp\objidpoolmanager::update_objective_setbackground( curobjid, 1 );
            }
            
            targetplayer.remoteuavmarkedobjid03 = curobjid;
        }
    }
    
    targetplayer thread remoteuav_unmarkremovedplayer( self.remoteuav );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x2cb2
// Size: 0x53
function remoteuav_processtaggedassist( victim )
{
    remoteuav_dialog( "assist" );
    
    if ( getgametype() != "dm" )
    {
        self.taggedassist = 1;
        
        if ( isdefined( victim ) )
        {
            thread scripts\mp\gamescore::processassist( victim );
            return;
        }
        
        thread doscoreevent( #"assist" );
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x2d0d
// Size: 0x1a9
function remoteuav_unmarkremovedplayer( remoteuav )
{
    level endon( "game_ended" );
    msg = waittill_any_return_3( "death_or_disconnect", "carried", "leaving" );
    
    if ( msg == "leaving" || !isdefined( self.uavtype ) )
    {
        self.uavremotemarkedby = undefined;
    }
    
    if ( isdefined( remoteuav ) )
    {
        if ( isplayer( self ) )
        {
            id = self.guid;
        }
        else if ( isdefined( self.birthtime ) )
        {
            id = self.birthtime;
        }
        else
        {
            id = self.birth_time;
        }
        
        if ( msg == "carried" || msg == "leaving" )
        {
            if ( isdefined( remoteuav.markedplayers[ id ][ "icon" ] ) )
            {
                remoteuav.markedplayers[ id ][ "icon" ] destroy();
                remoteuav.markedplayers[ id ][ "icon" ] = undefined;
            }
        }
        
        if ( isdefined( id ) && isdefined( remoteuav.markedplayers[ id ] ) )
        {
            remoteuav.markedplayers[ id ] = undefined;
            remoteuav.markedplayers = array_removeundefined( remoteuav.markedplayers );
        }
    }
    
    if ( isplayer( self ) )
    {
        self unsetperk( "specialty_radarblip", 1 );
        return;
    }
    
    if ( isdefined( self.remoteuavmarkedobjid01 ) )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( self.remoteuavmarkedobjid01 );
    }
    
    if ( isdefined( self.remoteuavmarkedobjid02 ) )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( self.remoteuavmarkedobjid02 );
    }
    
    if ( isdefined( self.remoteuavmarkedobjid03 ) )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( self.remoteuavmarkedobjid03 );
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x2ebe
// Size: 0x78
function remoteuav_clearmarkedforowner()
{
    foreach ( markedplayer in self.markedplayers )
    {
        if ( isdefined( markedplayer[ "icon" ] ) )
        {
            markedplayer[ "icon" ] destroy();
            markedplayer[ "icon" ] = undefined;
        }
    }
    
    self.markedplayers = undefined;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x2f3e
// Size: 0x41
function remoteuav_operationrumble( remoteuav )
{
    self endon( "disconnect" );
    remoteuav endon( "death" );
    level endon( "game_ended" );
    remoteuav endon( "end_remote" );
    
    while ( true )
    {
        self playrumbleonentity( "damage_light" );
        wait 0.5;
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x2f87
// Size: 0x1a4
function remoteuav_watch_distance()
{
    self endon( "death" );
    self.rangetrigger = getent( "remote_uav_range", "targetname" );
    
    if ( !isdefined( self.rangetrigger ) )
    {
        heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
        self.maxheight = heightent.origin[ 2 ];
        self.maxdistance = 12800;
    }
    
    self.centerref = spawn( "script_model", level.mapcenter );
    inrangepos = self.origin;
    self.rangecountdownactive = 0;
    
    while ( true )
    {
        if ( !remoteuav_in_range() )
        {
            staticalpha = 0;
            
            while ( !remoteuav_in_range() )
            {
                self.owner remoteuav_dialog( "out_of_range" );
                
                if ( !self.rangecountdownactive )
                {
                    self.rangecountdownactive = 1;
                    thread remoteuav_rangecountdown();
                }
                
                if ( isdefined( self.heliinproximity ) )
                {
                    dist = distance( self.origin, self.heliinproximity.origin );
                    staticalpha = 1 - ( dist - 150 ) / 150;
                }
                else
                {
                    dist = distance( self.origin, inrangepos );
                    staticalpha = min( 1, dist / 200 );
                }
                
                self.owner setplayerdata( "reconDroneState", "staticAlpha", staticalpha );
                wait 0.05;
            }
            
            self notify( "in_range" );
            self.rangecountdownactive = 0;
            thread remoteuav_staticfade( staticalpha );
        }
        
        inrangepos = self.origin;
        waitframe();
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x3133
// Size: 0x84, Type: bool
function remoteuav_in_range()
{
    if ( isdefined( self.rangetrigger ) )
    {
        if ( !self istouching( self.rangetrigger ) && !self.inheliproximity )
        {
            return true;
        }
    }
    else if ( distance2d( self.origin, level.mapcenter ) < self.maxdistance && self.origin[ 2 ] < self.maxheight && !self.inheliproximity )
    {
        return true;
    }
    
    return false;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x31c0
// Size: 0x6a
function remoteuav_staticfade( staticalpha )
{
    self endon( "death" );
    
    while ( remoteuav_in_range() )
    {
        staticalpha -= 0.05;
        
        if ( staticalpha < 0 )
        {
            self.owner setplayerdata( "reconDroneState", "staticAlpha", 0 );
            break;
        }
        
        self.owner setplayerdata( "reconDroneState", "staticAlpha", staticalpha );
        wait 0.05;
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x3232
// Size: 0x42
function remoteuav_rangecountdown()
{
    self endon( "death" );
    self endon( "in_range" );
    
    if ( isdefined( self.heliinproximity ) )
    {
        countdown = 3;
    }
    else
    {
        countdown = 6;
    }
    
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( countdown );
    self notify( "death" );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x327c
// Size: 0x21
function remoteuav_explode_on_disconnect()
{
    self endon( "death" );
    self.owner waittill( "disconnect" );
    self notify( "death" );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x32a5
// Size: 0x2b
function remoteuav_explode_on_changeteams()
{
    self endon( "death" );
    self.owner waittill_any_2( "joined_team", "joined_spectators" );
    self notify( "death" );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x32d8
// Size: 0x18
function remoteuav_clear_marked_on_gameended()
{
    self endon( "death" );
    level waittill( "game_ended" );
    remoteuav_clearmarkedforowner();
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x32f8
// Size: 0x3e
function remoteuav_leave_on_timeout()
{
    self endon( "death" );
    flytime = 60;
    
    /#
        flytime = getdvarint( @"hash_da7c6c2551fb9f41", flytime );
    #/
    
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( flytime );
    thread remoteuav_leave();
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x333e
// Size: 0x31
function remoteuav_leave()
{
    level endon( "game_ended" );
    self endon( "death" );
    self notify( "leaving" );
    self.owner remoteuav_endride( self );
    self notify( "death" );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x3377
// Size: 0x42
function remoteuav_explode_on_death()
{
    level endon( "game_ended" );
    self waittill( "death" );
    self playsound( "recondrone_destroyed" );
    playfx( level.remoteuav_fx[ "explode" ], self.origin );
    remoteuav_cleanup();
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x33c1
// Size: 0xab
function remoteuav_cleanup()
{
    if ( self.playerlinked == 1 && isdefined( self.owner ) )
    {
        self.owner remoteuav_endride( self );
    }
    
    if ( isdefined( self.scrambler ) )
    {
        self.scrambler delete();
    }
    
    if ( isdefined( self.centerref ) )
    {
        self.centerref delete();
    }
    
    remoteuav_clearmarkedforowner();
    stopfxontag( level.remoteuav_fx[ "smoke" ], self, "tag_origin" );
    level.remote_uav[ self.team ] = undefined;
    decrementfauxvehiclecount();
    self delete();
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x3474
// Size: 0x4a
function remoteuav_light_fx()
{
    playfxontag( level.chopper_fx[ "light" ][ "belly" ], self, "tag_light_nose" );
    wait 0.05;
    playfxontag( level.chopper_fx[ "light" ][ "tail" ], self, "tag_light_tail1" );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x34c6
// Size: 0xaa
function remoteuav_dialog( dialoggroup )
{
    if ( dialoggroup == "tag" )
    {
        waittime = 1000;
    }
    else
    {
        waittime = 5000;
    }
    
    if ( gettime() - level.remoteuav_lastdialogtime < waittime )
    {
        return;
    }
    
    level.remoteuav_lastdialogtime = gettime();
    randomindex = randomint( level.remoteuav_dialog[ dialoggroup ].size );
    soundalias = level.remoteuav_dialog[ dialoggroup ][ randomindex ];
    fullsoundalias = getteamvoiceinfix( self.team ) + "tl" + soundalias;
    self playlocalsound( fullsoundalias );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x3578
// Size: 0xc4
function remoteuav_handleincomingstinger()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "end_remote" );
    
    while ( true )
    {
        level waittill( "stinger_fired", player, missile, locktarget );
        
        if ( !isdefined( missile ) || !isdefined( locktarget ) || locktarget != self )
        {
            continue;
        }
        
        self.owner playlocalsound( "javelin_clu_lock" );
        self.owner setplayerdata( "reconDroneState", "incomingMissile", 1 );
        self.hasincoming = 1;
        self.incomingmissiles[ self.incomingmissiles.size ] = missile;
        missile.owner = player;
        missile thread watchstingerproximity( locktarget );
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x3644
// Size: 0x119
function remoteuav_handleincomingsam()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "end_remote" );
    
    while ( true )
    {
        level waittill( "sam_fired", player, missilegroup, locktarget );
        
        if ( !isdefined( locktarget ) || locktarget != self )
        {
            continue;
        }
        
        var_5106e97c176bc70c = 0;
        
        foreach ( missile in missilegroup )
        {
            if ( isdefined( missile ) )
            {
                self.incomingmissiles[ self.incomingmissiles.size ] = missile;
                missile.owner = player;
                var_5106e97c176bc70c++;
            }
        }
        
        if ( var_5106e97c176bc70c )
        {
            self.owner playlocalsound( "javelin_clu_lock" );
            self.owner setplayerdata( "reconDroneState", "incomingMissile", 1 );
            self.hasincoming = 1;
            level thread watchsamproximity( locktarget, missilegroup );
        }
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x3765
// Size: 0x189
function watchstingerproximity( missiletarget )
{
    level endon( "game_ended" );
    self endon( "death" );
    self missile_settargetent( missiletarget );
    lastvectotarget = vectornormalize( missiletarget.origin - self.origin );
    
    while ( isdefined( missiletarget ) )
    {
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( missiletarget.numflares > 0 && curdist < 4000 )
        {
            newtarget = missiletarget deployflares();
            self missile_settargetent( newtarget );
            return;
        }
        else
        {
            curvectotarget = vectornormalize( missiletarget.origin - self.origin );
            
            if ( vectordot( curvectotarget, lastvectotarget ) < 0 )
            {
                self playsound( "exp_stinger_armor_destroy" );
                playfx( level.remoteuav_fx[ "missile_explode" ], self.origin );
                
                if ( isdefined( self.owner ) )
                {
                    radiusdamage( self.origin, 400, 1000, 1000, self.owner, "MOD_EXPLOSIVE", "stinger_mp" );
                }
                else
                {
                    radiusdamage( self.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp" );
                }
                
                self hide();
                wait 0.05;
                self delete();
            }
            else
            {
                lastvectotarget = curvectotarget;
            }
        }
        
        wait 0.05;
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 2
// Checksum 0x0, Offset: 0x38f6
// Size: 0x2ba
function watchsamproximity( missiletarget, missilegroup )
{
    level endon( "game_ended" );
    missiletarget endon( "death" );
    
    foreach ( missile in missilegroup )
    {
        if ( isdefined( missile ) )
        {
            missile missile_settargetent( missiletarget );
            missile.lastvectotarget = vectornormalize( missiletarget.origin - missile.origin );
        }
    }
    
    while ( missilegroup.size && isdefined( missiletarget ) )
    {
        center = missiletarget getpointinbounds( 0, 0, 0 );
        
        foreach ( missile in missilegroup )
        {
            if ( isdefined( missile ) )
            {
                if ( isdefined( self.markfordetete ) )
                {
                    self delete();
                    continue;
                }
                
                if ( missiletarget.numflares > 0 )
                {
                    disttotarget = distance( missile.origin, center );
                    
                    if ( disttotarget < 4000 )
                    {
                        newtarget = missiletarget deployflares();
                        
                        foreach ( var_7ea79feb6d88b3e in missilegroup )
                        {
                            if ( isdefined( var_7ea79feb6d88b3e ) )
                            {
                                var_7ea79feb6d88b3e missile_settargetent( newtarget );
                            }
                        }
                        
                        return;
                    }
                    
                    continue;
                }
                
                curvectotarget = vectornormalize( missiletarget.origin - missile.origin );
                
                if ( vectordot( curvectotarget, missile.lastvectotarget ) < 0 )
                {
                    missile playsound( "exp_stinger_armor_destroy" );
                    playfx( level.remoteuav_fx[ "missile_explode" ], missile.origin );
                    
                    if ( isdefined( missile.owner ) )
                    {
                        radiusdamage( missile.origin, 400, 1000, 1000, missile.owner, "MOD_EXPLOSIVE", "stinger_mp" );
                    }
                    else
                    {
                        radiusdamage( missile.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp" );
                    }
                    
                    missile hide();
                    missile.markfordetete = 1;
                    continue;
                }
                
                missile.lastvectotarget = curvectotarget;
            }
        }
        
        missilegroup = array_removeundefined( missilegroup );
        wait 0.05;
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x3bb8
// Size: 0xa9
function deployflares()
{
    self.numflares--;
    self.owner thread remoteuav_rumble( self, 6 );
    self playsound( "WEAP_SHOTGUNATTACH_FIRE_NPC" );
    thread playflarefx();
    spawnpos = self.origin + ( 0, 0, -100 );
    flareobject = spawn( "script_origin", spawnpos );
    flareobject.angles = self.angles;
    flareobject movegravity( ( 0, 0, -1 ), 5 );
    flareobject thread deleteaftertime( 5 );
    return flareobject;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x3c6a
// Size: 0x43
function playflarefx()
{
    for ( i = 0; i < 5 ; i++ )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        playfxontag( level._effect[ "vehicle_flares" ], self, "TAG_FLARE" );
        wait 0.15;
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x3cb5
// Size: 0x14
function deleteaftertime( delay )
{
    wait delay;
    self delete();
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x3cd1
// Size: 0xc7
function remoteuav_clearincomingwarning()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "end_remote" );
    
    while ( true )
    {
        numincoming = 0;
        
        for ( i = 0; i < self.incomingmissiles.size ; i++ )
        {
            if ( isdefined( self.incomingmissiles[ i ] ) && missile_isincoming( self.incomingmissiles[ i ], self ) )
            {
                numincoming++;
            }
        }
        
        if ( self.hasincoming && !numincoming )
        {
            self.hasincoming = 0;
            self.owner setplayerdata( "reconDroneState", "incomingMissile", 0 );
        }
        
        self.incomingmissiles = array_removeundefined( self.incomingmissiles );
        wait 0.05;
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 2
// Checksum 0x0, Offset: 0x3da0
// Size: 0x5e, Type: bool
function missile_isincoming( missile, remoteuav )
{
    vectoremote = vectornormalize( remoteuav.origin - missile.origin );
    var_d2fad66c97b5f8ba = anglestoforward( missile.angles );
    return vectordot( vectoremote, var_d2fad66c97b5f8ba ) > 0;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x3e07
// Size: 0x191
function remoteuav_watchheliproximity()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "end_remote" );
    
    while ( true )
    {
        inheliproximity = 0;
        
        foreach ( heli in level.helis )
        {
            if ( distance( heli.origin, self.origin ) < 300 )
            {
                inheliproximity = 1;
                self.heliinproximity = heli;
            }
        }
        
        foreach ( littlebird in level.littlebirds )
        {
            if ( littlebird != self && ( !isdefined( littlebird.helitype ) || littlebird.helitype != "remote_uav" ) && distance( littlebird.origin, self.origin ) < 300 )
            {
                inheliproximity = 1;
                self.heliinproximity = littlebird;
            }
        }
        
        if ( !self.inheliproximity && inheliproximity )
        {
            self.inheliproximity = 1;
        }
        else if ( self.inheliproximity && !inheliproximity )
        {
            self.inheliproximity = 0;
            self.heliinproximity = undefined;
        }
        
        waitframe();
    }
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 0
// Checksum 0x0, Offset: 0x3fa0
// Size: 0x2a
function remoteuav_handledamage()
{
    self endon( "end_remote" );
    scripts\mp\damage::monitordamage( self.maxhealth, "remote_uav", &handledeathdamage, &modifydamage, 1 );
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x3fd2
// Size: 0x122
function modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    modifieddamage = damage;
    modifieddamage = scripts\mp\damage::handleempdamage( objweapon, type, modifieddamage );
    modifieddamage = scripts\mp\damage::handlemissiledamage( objweapon, type, modifieddamage );
    modifieddamage = scripts\mp\damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    playfxontagforclients( level.remoteuav_fx[ "hit" ], self, "tag_origin", self.owner );
    self playsound( "recondrone_damaged" );
    
    if ( self.smoking == 0 && self.damagetaken >= self.maxhealth / 2 )
    {
        self.smoking = 1;
        playfxontag( level.remoteuav_fx[ "smoke" ], self, "tag_origin" );
    }
    
    return modifieddamage;
}

// Namespace remoteuav / scripts\mp\killstreaks\remoteuav
// Params 1
// Checksum 0x0, Offset: 0x40fd
// Size: 0x7c
function handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    scripts\mp\damage::onkillstreakkilled( "remote_uav", attacker, objweapon, type, damage, "destroyed_remote_uav", undefined, "callout_destroyed_remote_uav" );
}

