#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\arm_vehicles;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\game;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\teams;
#using scripts\mp\vehicles\damage;
#using scripts\mp\vehicles\vehicle_oob_mp;

#namespace light_tank_mp;

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 0
// Checksum 0x0, Offset: 0x3de
// Size: 0xf3
function light_tank_mp_init()
{
    registersharedfunc( "light_tank", "activate", &light_tank_mp_activate );
    registersharedfunc( "light_tank", "startCapture", &light_tank_mp_startcapture );
    registersharedfunc( "light_tank", "endCapture", &light_tank_mp_endcapture );
    registersharedfunc( "light_tank", "filterDropSpawns", &light_tank_mp_filterdropspawns );
    registersharedfunc( "light_tank", "getDropSpawnIgnoreList", &light_tank_mp_getdropspawnignorelist );
    registersharedfunc( "light_tank", "spawn", &light_tank_mp_spawncallback );
    registersharedfunc( "light_tank", "initLate", &light_tank_mp_initlate );
    registersharedfunc( "light_tank", "onDeathRespawn", &light_tank_mp_ondeathrespawncallback );
    vehicle_tracking_limitgameinstances( "light_tank", 6 );
    vehicle_tracking_limitteaminstances( "light_tank", 3 );
    scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback( getsharedfunc( "light_tank", "updateHeadIconForPlayerOnJoinTeam" ) );
    light_tank_mp_initspawning();
    light_tank_mp_initcapture();
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 0
// Checksum 0x0, Offset: 0x4d9
// Size: 0x2
function light_tank_mp_initlate()
{
    
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 0
// Checksum 0x0, Offset: 0x4e3
// Size: 0x88
function light_tank_mp_initspawning()
{
    leveldataforvehicle = vehicle_spawn_getleveldataforvehicle( "light_tank" );
    leveldataforvehicle.abandonedtimeoutcallback = getsharedfunc( "light_tank", "timeOut" );
    
    if ( getgametype() == "arm" || getgametype() == "risk" )
    {
        leveldataforvehicle.abandonedtimeoutdelay = 105;
        leveldataforvehicle.respawndelay = level.tankrespawntime;
        return;
    }
    
    leveldataforvehicle.abandonedtimeoutdelay = 40;
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 0
// Checksum 0x0, Offset: 0x573
// Size: 0x33
function light_tank_mp_initcapture()
{
    val::group_register( "vehicleCapture", [ "offhand_weapons", "weapon", "killstreaks", "supers" ] );
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 1
// Checksum 0x0, Offset: 0x5ae
// Size: 0x21
function light_tank_mp_activate( vehicle )
{
    vehicle thread bctracking();
    scripts\mp\outofbounds::registerentforoob( vehicle, "vehicle" );
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 3
// Checksum 0x0, Offset: 0x5d7
// Size: 0x3d
function light_tank_mp_startcapture( vehicle, owner, team )
{
    if ( isdefined( owner ) )
    {
        light_tank_mp_createownercaptureobject( vehicle, owner );
    }
    
    if ( level.teambased )
    {
        light_tank_mp_createothercaptureobject( vehicle );
    }
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 1
// Checksum 0x0, Offset: 0x61c
// Size: 0x13
function light_tank_mp_endcapture( vehicle )
{
    vehicle light_tank_mp_deletecaptureobjects();
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 2
// Checksum 0x0, Offset: 0x637
// Size: 0x79
function light_tank_mp_createownercaptureobject( vehicle, owner )
{
    captureobject = spawn( "script_model", vehicle gettagorigin( "TAG_PLAYER" ) );
    captureobject linkto( vehicle );
    captureobject light_tank_mp_setupcaptureobject( 0.5 );
    captureobject.vehicle = vehicle;
    vehicle.ownercaptureobject = captureobject;
    captureobject thread light_tank_mp_monitorownercapture( owner, vehicle );
    captureobject thread light_tank_mp_monitorownercapturevisibility( owner );
    return captureobject;
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 1
// Checksum 0x0, Offset: 0x6b9
// Size: 0x6c
function light_tank_mp_createothercaptureobject( vehicle )
{
    captureobject = spawn( "script_model", vehicle gettagorigin( "TAG_PLAYER" ) );
    captureobject linkto( vehicle );
    captureobject light_tank_mp_setupcaptureobject( 3 );
    captureobject.vehicle = vehicle;
    vehicle.othercaptureobject = captureobject;
    captureobject thread light_tank_mp_monitorothercapture( vehicle );
    captureobject thread light_tank_mp_monitorothercapturevisibility();
    return captureobject;
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 1
// Checksum 0x0, Offset: 0x72e
// Size: 0xc7
function light_tank_mp_setupcaptureobject( usetime )
{
    self makeusable();
    self setcursorhint( "HINT_BUTTON" );
    
    if ( !scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924() )
    {
        self sethintstring( &"KILLSTREAKS_HINTS/BRADLEY_CAPTURE" );
    }
    
    self sethinttag( "none" );
    self sethintdisplayrange( 200 );
    self sethintdisplayfov( 360 );
    self setuserange( 200 );
    self setusefov( 360 );
    self sethintonobstruction( "show" );
    self setuseholdduration( "duration_none" );
    self setusehideprogressbar( 1 );
    self.userate = 1;
    self.curprogress = 0;
    self.usetime = usetime;
    self.inuse = 0;
    self.playerusing = undefined;
    self.id = "care_package";
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 0
// Checksum 0x0, Offset: 0x7fd
// Size: 0x26
function light_tank_mp_deletecaptureobject()
{
    if ( isdefined( self.playerusing ) )
    {
        light_tank_mp_playerstopcapture( self.playerusing );
    }
    
    self delete();
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 0
// Checksum 0x0, Offset: 0x82b
// Size: 0x3c
function light_tank_mp_deletecaptureobjects()
{
    if ( isdefined( self.ownercaptureobject ) )
    {
        self.ownercaptureobject light_tank_mp_deletecaptureobject();
    }
    
    if ( isdefined( self.othercaptureobject ) )
    {
        self.othercaptureobject light_tank_mp_deletecaptureobject();
    }
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 2
// Checksum 0x0, Offset: 0x86f
// Size: 0xcd
function light_tank_mp_monitorownercapture( owner, vehicle )
{
    self endon( "death" );
    owner endon( "disconnect" );
    self.vehicle = vehicle;
    
    while ( true )
    {
        self waittillmatch( "trigger", owner );
        
        if ( light_tank_mp_canstartcapture( owner ) )
        {
            self.playerusing = owner;
            self.inuse = 1;
            light_tank_mp_playerstartcapture( owner );
            captured = light_tank_mp_monitorcaptureinternal();
            self.playerusing = undefined;
            self.curprogress = 0;
            self.inuse = 0;
            light_tank_mp_playerstopcapture( owner );
            
            if ( istrue( captured ) && issharedfuncdefined( "light_tank", "capture" ) )
            {
                thread [[ getsharedfunc( "light_tank", "capture" ) ]]( vehicle, owner );
            }
            
            waitframe();
        }
    }
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 1
// Checksum 0x0, Offset: 0x944
// Size: 0xc0
function light_tank_mp_monitorothercapture( vehicle )
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( light_tank_mp_canstartcapture( player ) )
        {
            self.playerusing = player;
            self.inuse = 1;
            light_tank_mp_playerstartcapture( player );
            captured = light_tank_mp_monitorcaptureinternal();
            self.playerusing = undefined;
            self.curprogress = 0;
            self.inuse = 0;
            
            if ( isdefined( player ) )
            {
                light_tank_mp_playerstopcapture( player );
            }
            
            if ( istrue( captured ) && issharedfuncdefined( "light_tank", "capture" ) )
            {
                thread [[ getsharedfunc( "light_tank", "capture" ) ]]( vehicle, player );
            }
            
            waitframe();
        }
    }
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 0
// Checksum 0x0, Offset: 0xa0c
// Size: 0x70
function light_tank_mp_monitorcaptureinternal()
{
    self.playerusing endon( "death_or_disconnect" );
    
    while ( light_tank_mp_cankeepcapturing() )
    {
        self.curprogress += level.framedurationseconds * self.userate;
        
        if ( self.curprogress >= self.usetime )
        {
            return 1;
        }
        
        self.playerusing scripts\mp\gameobjects::updateuiprogress( self, 1 );
        waitframe();
    }
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 1
// Checksum 0x0, Offset: 0xa84
// Size: 0xb5
function light_tank_mp_monitorownercapturevisibility( owner )
{
    self endon( "death" );
    
    while ( isdefined( owner ) )
    {
        foreach ( player in level.players )
        {
            self disableplayeruse( player );
            
            if ( player == owner )
            {
                if ( isdefined( self.playerusing ) )
                {
                    if ( light_tank_mp_cankeepcapturing() )
                    {
                        self enableplayeruse( owner );
                    }
                    
                    continue;
                }
                
                if ( light_tank_mp_canstartcapture( owner ) )
                {
                    self enableplayeruse( owner );
                }
            }
        }
        
        wait 0.1;
    }
    
    thread light_tank_mp_deletecaptureobject();
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 0
// Checksum 0x0, Offset: 0xb41
// Size: 0xf6
function light_tank_mp_monitorothercapturevisibility()
{
    self endon( "death" );
    
    while ( true )
    {
        if ( isdefined( self.playerusing ) )
        {
            foreach ( player in level.players )
            {
                self disableplayeruse( player );
                
                if ( player == self.playerusing )
                {
                    if ( light_tank_mp_cankeepcapturing() )
                    {
                        self enableplayeruse( player );
                    }
                }
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                self disableplayeruse( player );
                
                if ( light_tank_mp_canstartcapture( player ) )
                {
                    self enableplayeruse( player );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 1
// Checksum 0x0, Offset: 0xc3f
// Size: 0x76, Type: bool
function light_tank_mp_canstartcapture( player )
{
    if ( istrue( self.vehicle.isdestroyed ) )
    {
        return false;
    }
    
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( !player _isalive() )
    {
        return false;
    }
    
    if ( player.team == "spectator" )
    {
        return false;
    }
    
    if ( !player val::get( "vehicle_use" ) )
    {
        return false;
    }
    
    if ( !istrue( vehicle_interact_playercanusevehicle( player, self.vehicle ) ) )
    {
        return false;
    }
    
    return true;
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 0
// Checksum 0x0, Offset: 0xcbe
// Size: 0xb9, Type: bool
function light_tank_mp_cankeepcapturing()
{
    if ( istrue( self.vehicle.isdestroyed ) )
    {
        return false;
    }
    
    if ( !self.playerusing val::get( "vehicle_use" ) )
    {
        return false;
    }
    
    if ( !istrue( vehicle_interact_playercanusevehicle( self.playerusing, self.vehicle ) ) )
    {
        return false;
    }
    
    if ( !self.playerusing usebuttonpressed() )
    {
        return false;
    }
    
    if ( self.playerusing isonladder() )
    {
        return false;
    }
    
    if ( self.playerusing meleebuttonpressed() )
    {
        return false;
    }
    
    if ( distancesquared( self.playerusing.origin, self.origin ) > 90000 )
    {
        return false;
    }
    
    return true;
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 1
// Checksum 0x0, Offset: 0xd80
// Size: 0x23
function light_tank_mp_playerstartcapture( player )
{
    player val::group_set( "vehicleCapture", 0 );
    player scripts\mp\gameobjects::updateuiprogress( self, 0 );
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 1
// Checksum 0x0, Offset: 0xdab
// Size: 0x2c
function light_tank_mp_playerstopcapture( player )
{
    if ( player _isalive() )
    {
        player val::group_reset( "vehicleCapture" );
    }
    
    player scripts\mp\gameobjects::updateuiprogress( self, 0 );
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 2
// Checksum 0x0, Offset: 0xddf
// Size: 0x67, Type: bool
function light_tank_mp_shouldawardattacker( vehicle, attacker )
{
    if ( !isdefined( attacker ) )
    {
        return false;
    }
    
    if ( level.teambased && attacker.team == vehicle.team )
    {
        return false;
    }
    
    if ( isdefined( vehicle.owner ) && attacker == vehicle.owner )
    {
        return false;
    }
    
    return true;
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 0
// Checksum 0x0, Offset: 0xe4f
// Size: 0x119
function bctracking()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        if ( scripts\mp\utility\teams::isgameplayteam( self.team ) )
        {
            nearplayers = utility::playersinsphere( self.origin, 3000 );
            
            foreach ( player in nearplayers )
            {
                validplayer = isdefined( player ) && player _isalive() && scripts\cp_mp\utility\player_utility::isenemy( player );
                
                if ( !validplayer )
                {
                    continue;
                }
                
                playerfacingdir = anglestoforward( player getplayerangles() );
                var_e402c093911c20ee = math::anglebetweenvectors( playerfacingdir, self.origin - player.origin );
                
                if ( isdefined( var_e402c093911c20ee ) && var_e402c093911c20ee <= 60 )
                {
                    if ( self sightconetrace( player geteye(), self ) > 0.1 )
                    {
                    }
                    
                    waitframe();
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 2
// Checksum 0x0, Offset: 0xf70
// Size: 0xa5
function light_tank_mp_spawncallback( spawndata, faildata )
{
    assert( scripts\cp_mp\vehicles\vehicle::function_fa537f1ab52a76d1( "<dev string:x1c>" ) );
    [[ getsharedfunc( "light_tank", "initSpawnData" ) ]]( spawndata );
    
    if ( !isdefined( spawndata.spawnmethod ) )
    {
        spawndata.spawnmethod = "place_at_position_unsafe";
    }
    
    if ( !isdefined( spawndata.showheadicon ) )
    {
        spawndata.showheadicon = 0;
    }
    
    spawndata.cantimeout = 0;
    vehicle = [[ getsharedfunc( "light_tank", "tankSpawn" ) ]]( spawndata, faildata );
    return vehicle;
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 0
// Checksum 0x0, Offset: 0x101e
// Size: 0xa
function light_tank_mp_ondeathrespawncallback()
{
    thread light_tank_mp_waitandspawn();
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 0
// Checksum 0x0, Offset: 0x1030
// Size: 0x143
function light_tank_mp_waitandspawn()
{
    if ( !scripts\cp_mp\vehicles\vehicle::function_fa537f1ab52a76d1( "light_tank" ) )
    {
        return;
    }
    
    oldspawndata = getvehiclespawndata( self );
    
    if ( isdefined( oldspawndata.basevehiclespawndata ) )
    {
        oldspawndata = oldspawndata.basevehiclespawndata;
    }
    
    spawndata = spawnstruct();
    copyvehiclespawndata( oldspawndata, spawndata );
    [[ getsharedfunc( "light_tank", "copySpawnData" ) ]]( oldspawndata, spawndata );
    faildata = spawnstruct();
    vehicle = vehicle_spawn_waitandrespawn( "light_tank", spawndata, faildata );
    
    if ( isdefined( vehicle ) )
    {
        if ( getgametype() == "arm" || getgametype() == "risk" )
        {
            if ( scripts\mp\flags::gameflag( "prematch_done" ) )
            {
                scripts\mp\gametypes\arm_vehicles::droptank_playincomingdialog( spawndata );
            }
            
            foreach ( player in level.players )
            {
                if ( player.team == vehicle.team )
                {
                    player scripts\mp\utility\lower_message::setlowermessageomnvar( "gw_iav_respawn", undefined, 5 );
                }
            }
        }
    }
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 1
// Checksum 0x0, Offset: 0x117b
// Size: 0x8d
function light_tank_mp_filterdropspawns( dropspawns )
{
    var_30492e606ac5ccff = dropspawns;
    
    if ( isdefined( level.vehspawnvol ) )
    {
        var_30492e606ac5ccff = [];
        
        foreach ( dropspawn in dropspawns )
        {
            if ( ispointinvolume( dropspawn.origin, level.vehspawnvol ) )
            {
                var_30492e606ac5ccff[ var_30492e606ac5ccff.size ] = dropspawn;
            }
        }
    }
    
    return var_30492e606ac5ccff;
}

// Namespace light_tank_mp / scripts\mp\vehicles\light_tank_mp
// Params 1
// Checksum 0x0, Offset: 0x1211
// Size: 0x96
function light_tank_mp_getdropspawnignorelist( ignorelist )
{
    var_8496e2572c67cb8c = [];
    var_8496e2572c67cb8c[ var_8496e2572c67cb8c.size ] = ignorelist;
    
    if ( isdefined( level.helis ) )
    {
        var_8496e2572c67cb8c[ var_8496e2572c67cb8c.size ] = level.helis;
    }
    
    if ( isdefined( level.littlebirds ) )
    {
        var_8496e2572c67cb8c[ var_8496e2572c67cb8c.size ] = level.littlebirds;
    }
    
    if ( isdefined( level.supportdrones ) )
    {
        var_8496e2572c67cb8c[ var_8496e2572c67cb8c.size ] = level.supportdrones;
    }
    
    var_8496e2572c67cb8c[ var_8496e2572c67cb8c.size ] = vehicle_tracking_getgameinstances( "emp_drone" );
    var_8496e2572c67cb8c[ var_8496e2572c67cb8c.size ] = vehicle_tracking_getgameinstances( "cruise_predator" );
    return scripts\engine\utility::array_combine_multiple( var_8496e2572c67cb8c );
}

