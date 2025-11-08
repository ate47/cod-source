#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\laststand;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ammorestock;
#using scripts\mp\arbitrary_up;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\juggernaut;
#using scripts\mp\meatshield;
#using scripts\mp\movers;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace gameobjects;

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x1231
// Size: 0x1fb
function main( allowednames )
{
    allowednames[ allowednames.size ] = "airdrop_pallet";
    entities = getentarray();
    
    foreach ( entity in entities )
    {
        if ( isdefined( entity.targetname ) && entity.targetname == "ammo_restock_location" || scripts\mp\ammorestock::function_7923460ce1ee31c5( entity ) || istrue( entity.var_cefa8400ec818ee6 ) )
        {
            entity.var_cefa8400ec818ee6 = 1;
            
            if ( isdefined( entity.target ) )
            {
                foreach ( ent in getentarray( entity.target, "targetname" ) )
                {
                    ent.var_cefa8400ec818ee6 = 1;
                }
            }
            
            continue;
        }
        
        var_49c0bb15cb302f86 = entity.script_gameobjectname;
        
        if ( isdefined( var_49c0bb15cb302f86 ) )
        {
            invertlogic = 0;
            
            if ( getsubstr( var_49c0bb15cb302f86, 0, 1 ) == "!" )
            {
                var_49c0bb15cb302f86 = getsubstr( var_49c0bb15cb302f86, 1 );
                invertlogic = 1;
            }
            
            matches = 0;
            nameslist = strtok( var_49c0bb15cb302f86, " " );
            
            for ( j = 0; j < allowednames.size ; j++ )
            {
                for ( k = 0; k < nameslist.size ; k++ )
                {
                    if ( nameslist[ k ] == allowednames[ j ] )
                    {
                        matches = 1;
                        break;
                    }
                }
                
                if ( matches )
                {
                    break;
                }
            }
            
            if ( invertlogic )
            {
                if ( matches )
                {
                    entity delete();
                }
                
                continue;
            }
            
            if ( !matches )
            {
                entity delete();
            }
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x1434
// Size: 0x21
function init()
{
    level.numgametypereservedobjectives = 0;
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawned );
    level thread getleveltriggers();
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x145d
// Size: 0x6b
function onplayerspawned()
{
    if ( isbot( self ) )
    {
        level.botsenabled = 1;
    }
    
    shouldinit = !istrue( level.disableinitplayergameobjects );
    
    if ( getdvarint( @"hash_1e97927453ad138", 0 ) == 1 )
    {
        shouldinit = 1;
    }
    
    if ( shouldinit )
    {
        if ( isdefined( self.gameobject_fauxspawn ) )
        {
            self.gameobject_fauxspawn = undefined;
            return;
        }
        
        init_player_gameobjects();
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x14d0
// Size: 0x34
function init_player_gameobjects()
{
    thread ondeathordisconnect();
    self.touchtriggers = [];
    self.carryobject = undefined;
    self.canpickupobject = 1;
    self.initialized_gameobject_vars = 1;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x150c
// Size: 0x2e
function ondeathordisconnect()
{
    self notify( "gameobject_watch_drop" );
    level endon( "game_ended" );
    self endon( "drop_called" );
    self endon( "gameobject_watch_drop" );
    self waittill( "death_or_disconnect" );
    _ondeathordisconnectinternal();
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x1542
// Size: 0x20
function _ondeathordisconnectinternal()
{
    if ( isdefined( self.carryobject ) )
    {
        self.carryobject thread setdropped();
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x156a
// Size: 0x5a
function onjuggernaut()
{
    waittillframeend();
    
    if ( isdefined( self.carryobject ) )
    {
        assert( self.carryobject.carrier == self );
        self.var_c7945be244726ad0 = gettime();
        self.carryobject thread setdropped();
        self switchtoweapon( scripts\mp\juggernaut::jugg_getminigunweapon() );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0x15cc
// Size: 0x12d
function createtrackedobject( player, offset )
{
    trackedobject = spawn( "script_model", self.origin );
    trackedobject setmodel( "tag_origin" );
    carryobject = spawnstruct();
    carryobject.type = "carryObject";
    carryobject.carrier = player;
    carryobject.curorigin = player.origin;
    carryobject.entnum = trackedobject getentitynumber();
    carryobject.ownerteam = player.team;
    carryobject.offset3d = offset;
    carryobject.triggertype = "none";
    carryobject.compassicons = [];
    carryobject.objidpingfriendly = 0;
    carryobject.objidpingenemy = 0;
    carryobject.carriervisible = 0;
    carryobject.visibleteam = "none";
    carryobject requestid( 1, 1 );
    carryobject thread updatecarryobjectorigin();
    carryobject thread deletetrackedobjectoncarrierdisconnect();
    return carryobject;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x1702
// Size: 0x27
function deletetrackedobjectoncarrierdisconnect()
{
    self endon( "gameobject_deleted" );
    level endon( "game_ended" );
    self.carrier waittill( "disconnect" );
    deletetrackedobject();
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x1731
// Size: 0xb4
function deletetrackedobject()
{
    if ( !isdefined( self ) || !isdefined( self.type ) || self.type != "carryObject" )
    {
        return;
    }
    
    carryobject = self;
    carryobject.type = undefined;
    carryobject.carrier = undefined;
    carryobject.curorigin = undefined;
    carryobject.entnum = undefined;
    carryobject.ownerteam = undefined;
    carryobject.compassicons = undefined;
    carryobject.objidpingfriendly = undefined;
    carryobject.objidpingenemy = undefined;
    carryobject.carriervisible = undefined;
    carryobject.visibleteam = undefined;
    releaseid();
    self notify( "gameobject_deleted" );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 4
// Checksum 0x0, Offset: 0x17ed
// Size: 0x9c
function function_fd1b4a7d915fc9a6( origin, offset, showonminimap, var_182036c56e421297 )
{
    codcasterwaypoint = spawnstruct();
    codcasterwaypoint.type = "codcasterWaypoint";
    codcasterwaypoint.curorigin = origin;
    codcasterwaypoint.offset3d = offset;
    codcasterwaypoint.ownerteam = "neutral";
    codcasterwaypoint.compassicons = [];
    codcasterwaypoint.visibleteam = "codcaster";
    codcasterwaypoint requestid( showonminimap, var_182036c56e421297, undefined, 0, 0 );
    return codcasterwaypoint;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x1892
// Size: 0x80
function function_e3c8fb6519162627()
{
    if ( !isdefined( self ) || !isdefined( self.type ) || self.type != "codcasterWaypoint" )
    {
        return;
    }
    
    codcasterwaypoint = self;
    codcasterwaypoint.type = undefined;
    codcasterwaypoint.curorigin = undefined;
    codcasterwaypoint.offset3d = undefined;
    codcasterwaypoint.ownerteam = undefined;
    codcasterwaypoint.compassicons = undefined;
    codcasterwaypoint.visibleteam = undefined;
    releaseid();
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 6
// Checksum 0x0, Offset: 0x191a
// Size: 0x44b
function createcarryobject( ownerteam, trigger, visuals, offset, useifproximity, skipobjid )
{
    carryobject = spawnstruct();
    carryobject.type = "carryObject";
    carryobject.curorigin = trigger.origin;
    carryobject.ownerteam = ownerteam;
    carryobject.useifproximity = useifproximity;
    carryobject.entnum = trigger getentitynumber();
    
    if ( issubstr( trigger.classname, "use" ) || istrue( trigger.usetype ) )
    {
        carryobject.triggertype = "use";
    }
    else
    {
        carryobject.triggertype = "proximity";
    }
    
    trigger.gameobject = carryobject;
    trigger.baseorigin = trigger.origin;
    carryobject.trigger = trigger;
    
    if ( !isdefined( trigger.linktoenabledflag ) )
    {
        trigger.linktoenabledflag = 1;
        trigger enablelinkto();
    }
    
    carryobject.useweapon = undefined;
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    carryobject.offset3d = offset;
    
    for ( index = 0; index < visuals.size ; index++ )
    {
        visuals[ index ].baseorigin = visuals[ index ].origin;
        visuals[ index ].baseangles = visuals[ index ].angles;
    }
    
    carryobject.visuals = visuals;
    carryobject.compassicons = [];
    carryobject.objidpingfriendly = 0;
    carryobject.objidpingenemy = 0;
    
    if ( !isdefined( skipobjid ) )
    {
        carryobject requestid( 1, 1 );
    }
    
    carryobject.carrier = undefined;
    carryobject.isresetting = 0;
    carryobject.interactteam = "none";
    carryobject.allowweapons = 0;
    carryobject.carriervisible = 0;
    carryobject.visibleteam = "none";
    carryobject.carryicon = undefined;
    carryobject.ondrop = undefined;
    carryobject.onpickup = undefined;
    carryobject.onreset = undefined;
    carryobject.pickupchecks = [];
    
    if ( carryobject.triggertype == "use" )
    {
        carryobject thread carryobjectusethink();
    }
    else
    {
        carryobject.curprogress = 0;
        carryobject.teamprogress = [];
        carryobject.teamprogress[ "none" ] = 0;
        carryobject.usetime = 0;
        carryobject.userate = 0;
        carryobject.useratemultiplier = 1;
        carryobject.mustmaintainclaim = 0;
        carryobject.cancontestclaim = 0;
        carryobject.teamusetimes = [];
        carryobject.teamusetexts = [];
        carryobject.numtouching[ "neutral" ] = 0;
        carryobject.touchlist[ "neutral" ] = [];
        carryobject.numtouching[ "none" ] = 0;
        carryobject.touchlist[ "none" ] = [];
        
        foreach ( name in level.teamnamelist )
        {
            carryobject.teamprogress[ name ] = 0;
            carryobject.numtouching[ name ] = 0;
            carryobject.touchlist[ name ] = [];
        }
        
        carryobject.claimteam = "none";
        carryobject.claimplayer = undefined;
        carryobject.lastclaimteam = "none";
        carryobject.lastclaimtime = 0;
        carryobject thread carryobjectproxthink();
    }
    
    carryobject thread updatecarryobjectorigin();
    return carryobject;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x1d6e
// Size: 0x21
function registercarryobjectpickupcheck( delegate )
{
    self.pickupchecks[ self.pickupchecks.size ] = delegate;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x1d97
// Size: 0xe7
function checkcarryobjectpickupcheck( player )
{
    passed = 1;
    
    foreach ( check in self.pickupchecks )
    {
        passed &= [[ check ]]( player );
    }
    
    if ( isdefined( self.manualdropdata ) && isdefined( self.manualdropdata.pickupchecks ) )
    {
        foreach ( check in self.manualdropdata.pickupchecks )
        {
            passed &= [[ check ]]( player );
        }
    }
    
    return passed;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x1e87
// Size: 0x251
function deletecarryobject()
{
    if ( self.type != "carryObject" )
    {
        return;
    }
    
    carryobject = self;
    carryobject notify( "death" );
    carryobject notify( "deleted" );
    carryobject.type = undefined;
    carryobject.curorigin = undefined;
    carryobject.ownerteam = undefined;
    carryobject.entnum = undefined;
    carryobject.triggertype = undefined;
    carryobject.trigger unlink();
    carryobject.trigger = undefined;
    carryobject.useweapon = undefined;
    carryobject.offset3d = undefined;
    
    foreach ( visual in carryobject.visuals )
    {
        visual delete();
    }
    
    carryobject.visuals = undefined;
    carryobject.compassicons = undefined;
    carryobject.objidpingfriendly = undefined;
    carryobject.objidpingenemy = undefined;
    carryobject.objpingdelay = undefined;
    releaseid();
    carryobject.carrier = undefined;
    carryobject.isresetting = undefined;
    carryobject.interactteam = "none";
    carryobject.allowweapons = undefined;
    carryobject.keepprogress = undefined;
    carryobject.carriervisible = undefined;
    carryobject.visibleteam = "none";
    carryobject.carryicon = undefined;
    carryobject.ondrop = undefined;
    carryobject.onpickup = undefined;
    carryobject.onreset = undefined;
    carryobject.curprogress = undefined;
    carryobject.usetime = undefined;
    carryobject.userate = undefined;
    carryobject.useratemultiplier = 1;
    carryobject.mustmaintainclaim = undefined;
    carryobject.cancontestclaim = undefined;
    carryobject.teamusetimes = undefined;
    carryobject.teamusetexts = undefined;
    carryobject.numtouching = undefined;
    carryobject.touchlist = undefined;
    carryobject.claimteam = undefined;
    carryobject.claimplayer = undefined;
    carryobject.lastclaimteam = undefined;
    carryobject.lastclaimtime = undefined;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x20e0
// Size: 0x1b2
function carryobjectusethink()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        self.trigger waittill( "trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player ismeleeing() )
        {
            continue;
        }
        
        currentweapon = player getcurrentweapon();
        
        if ( isremotekillstreakweapon( currentweapon.basename ) )
        {
            continue;
        }
        
        if ( player isanymonitoredweaponswitchinprogress() )
        {
            nextweapon = player getcurrentmonitoredweaponswitchweapon();
            
            if ( isremotekillstreakweapon( nextweapon.basename ) )
            {
                continue;
            }
        }
        
        if ( istrue( player.inlaststand ) )
        {
            continue;
        }
        
        if ( self.isresetting )
        {
            continue;
        }
        
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !caninteractwith( player.pers[ "team" ], player ) )
        {
            continue;
        }
        
        if ( !player.canpickupobject )
        {
            continue;
        }
        
        if ( isdefined( player.nopickuptime ) && player.nopickuptime > gettime() )
        {
            continue;
        }
        
        if ( !isdefined( player.initialized_gameobject_vars ) )
        {
            continue;
        }
        
        if ( !isflagcarrymode() && player scripts\mp\utility\weapon::grenadeinpullback() )
        {
            offhandweapon = player getheldoffhand();
            
            if ( !isgesture( offhandweapon ) )
            {
                continue;
            }
        }
        
        if ( isdefined( self.carrier ) )
        {
            continue;
        }
        
        if ( player isusingremote() )
        {
            continue;
        }
        
        if ( !proxtriggerlos( player ) )
        {
            continue;
        }
        
        if ( istrue( level.var_9a8e3eb5bc672807 ) && !player isonground() )
        {
            continue;
        }
        
        setpickedup( player );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x229a
// Size: 0x42
function carryobjectproxthink()
{
    if ( getgametype() == "ball" || getgametype() == "tdef" || istrue( self.useifproximity ) )
    {
        thread carryobjectusethink();
        return;
    }
    
    thread carryobjectproxthinkdelayed();
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x22e4
// Size: 0x2d1
function carryobjectproxthinkdelayed()
{
    level endon( "game_ended" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger endon( "move_gameobject" );
    }
    
    thread proxtriggerthink();
    
    while ( true )
    {
        if ( self.usetime && self.teamprogress[ self.claimteam ] >= self.usetime )
        {
            self.curprogress = 0;
            self.teamprogress[ self.claimteam ] = self.curprogress;
            creditplayer = getearliestclaimplayer();
            setclaimteam( "none" );
            self.claimplayer = undefined;
            
            if ( isdefined( self.onenduse ) )
            {
                self [[ self.onenduse ]]( getlastclaimteam(), creditplayer, isdefined( creditplayer ) );
            }
            
            if ( isdefined( creditplayer ) )
            {
                setpickedup( creditplayer );
            }
        }
        
        if ( self.claimteam != "none" )
        {
            if ( self.usetime )
            {
                if ( !self.numtouching[ self.claimteam ] )
                {
                    setclaimteam( "none" );
                    self.claimplayer = undefined;
                    
                    if ( isdefined( self.onenduse ) )
                    {
                        self [[ self.onenduse ]]( getlastclaimteam(), self.claimplayer, 0 );
                    }
                }
                else if ( getgametype() == "bigctf" && istrue( self.stalemate ) )
                {
                }
                else
                {
                    self.curprogress += level.frameduration * self.userate;
                    self.teamprogress[ self.claimteam ] = self.curprogress;
                    enemyteams = getenemyteams( self.claimteam );
                    
                    foreach ( entry in enemyteams )
                    {
                        if ( self.ownerteam != entry )
                        {
                            self.teamprogress[ entry ] = 0;
                        }
                    }
                    
                    if ( isdefined( self.onuseupdate ) )
                    {
                        self [[ self.onuseupdate ]]( getclaimteam(), self.curprogress / self.usetime, level.frameduration * self.userate / self.usetime, self.claimplayer );
                    }
                }
            }
            else
            {
                if ( isreallyalive( self.claimplayer ) )
                {
                    setpickedup( self.claimplayer );
                }
                
                setclaimteam( "none" );
                self.claimplayer = undefined;
            }
        }
        
        waitframe();
        scripts\mp\hostmigration::waittillhostmigrationdone();
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x25bd
// Size: 0x88
function pickupobjectdelay( object )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self.canpickupobject = 0;
    
    if ( isdefined( object.ballindex ) )
    {
        distsqcheck = 1024;
    }
    else
    {
        distsqcheck = 4096;
    }
    
    for ( ;; )
    {
        if ( distancesquared( self.origin, object.trigger.origin ) > distsqcheck )
        {
            break;
        }
        
        wait 0.2;
    }
    
    self.canpickupobject = 1;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 3
// Checksum 0x0, Offset: 0x264d
// Size: 0x42f
function setpickedup( player, playervo, defused )
{
    if ( is_equal( getgametype(), "bigctf" ) )
    {
        if ( !scripts\mp\utility\player::isreallyalive( player ) || isai( player ) && isdefined( player.owner ) || isdefined( self.carryweapon ) && !player scripts\common\values::get( "weapon" ) || !scripts\mp\gameobjects::checkcarryobjectpickupcheck( player ) )
        {
            if ( isdefined( self.onpickupfailed ) )
            {
                self [[ self.onpickupfailed ]]( player );
            }
            
            return;
        }
        else if ( isdefined( player.carryobject ) && self.ownerteam == player.team )
        {
            if ( isdefined( self.trigger getlinkedparent() ) )
            {
                for ( index = 0; index < self.visuals.size ; index++ )
                {
                    self.visuals[ index ] unlink();
                }
                
                self.trigger unlink();
            }
            
            for ( index = 0; index < self.visuals.size ; index++ )
            {
                self.visuals[ index ] hide();
            }
            
            if ( !istrue( self.trigger.var_2768447445db282 ) )
            {
                self.trigger.origin += ( 0, 0, 10000 );
            }
            
            self.trigger scripts\mp\movers::stop_handling_moving_platforms();
            self notify( "pickup_object" );
            player notify( "pickup_object" );
            
            if ( isdefined( self.onpickup ) )
            {
                self [[ self.onpickup ]]( player, playervo, defused );
            }
            
            var_7e2c53b0bcf117d9 = spawnstruct();
            var_7e2c53b0bcf117d9.credit_player = player;
            var_7e2c53b0bcf117d9.objective_entity = self;
            scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_objective_state_changed", var_7e2c53b0bcf117d9 );
        }
    }
    
    if ( !scripts\mp\utility\player::isreallyalive( player ) || isai( player ) && isdefined( player.owner ) || isdefined( player.carryobject ) || isdefined( self.carryweapon ) && !player scripts\common\values::get( "weapon" ) || !scripts\mp\gameobjects::checkcarryobjectpickupcheck( player ) )
    {
        if ( getgametype() == "ctf" )
        {
            if ( scripts\mp\gameobjects::isfriendlyteam( player.pers[ "team" ] ) )
            {
                self [[ self.onpickup ]]( player, playervo, defused );
                return;
            }
            
            return;
        }
        
        if ( isdefined( self.onpickupfailed ) )
        {
            self [[ self.onpickupfailed ]]( player );
        }
        
        return;
    }
    
    player giveobject( self );
    setcarrier( player );
    
    if ( isdefined( self.trigger getlinkedparent() ) )
    {
        for ( index = 0; index < self.visuals.size ; index++ )
        {
            self.visuals[ index ] unlink();
        }
        
        self.trigger unlink();
    }
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        self.visuals[ index ] hide();
    }
    
    if ( !istrue( self.trigger.var_2768447445db282 ) )
    {
        self.trigger.origin += ( 0, 0, 10000 );
    }
    
    self.trigger scripts\mp\movers::stop_handling_moving_platforms();
    self notify( "pickup_object" );
    player notify( "pickup_object" );
    
    if ( isdefined( self.onpickup ) )
    {
        self [[ self.onpickup ]]( player, playervo, defused );
    }
    
    if ( isdefined( self.manualdropdata ) && getdvarint( @"hash_85b8d86d0ea96ee1", 1 ) )
    {
        if ( !istrue( self.var_856484af8370f6a1 ) )
        {
            setupmanualdrop( player, self.manualdropdata );
        }
    }
    
    var_7e2c53b0bcf117d9 = spawnstruct();
    var_7e2c53b0bcf117d9.credit_player = player;
    var_7e2c53b0bcf117d9.objective_entity = self;
    scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_objective_state_changed", var_7e2c53b0bcf117d9 );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 7
// Checksum 0x0, Offset: 0x2a84
// Size: 0xe1
function create_manual_drop_data_struct( ignoreents, trigger, triggerdelay, dropdist, var_d81857413879b334, onmanualdrop, var_8e58b28ef44cbe0 )
{
    manualdropdata = spawnstruct();
    
    if ( isdefined( ignoreents ) )
    {
        manualdropdata.ignoreents = ignoreents;
    }
    
    if ( isdefined( trigger ) )
    {
        manualdropdata.trigger = trigger;
    }
    
    if ( isdefined( triggerdelay ) )
    {
        manualdropdata.triggerdelay = triggerdelay;
    }
    
    if ( isdefined( dropdist ) )
    {
        manualdropdata.dropdist = dropdist;
    }
    
    if ( isdefined( var_d81857413879b334 ) )
    {
        manualdropdata.var_5338ab800fa9b63a = var_d81857413879b334;
    }
    
    if ( isdefined( onmanualdrop ) )
    {
        manualdropdata.onmanualdrop = onmanualdrop;
    }
    
    if ( !istrue( var_8e58b28ef44cbe0 ) )
    {
        manualdropdata.pickupchecks = [ &function_ffae0b2bdeb1bb92 ];
    }
    
    self.manualdropdata = manualdropdata;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0x2b6d
// Size: 0x4c
function setupmanualdrop( player, manualdropdata )
{
    if ( isbot( player ) )
    {
        return;
    }
    
    function_3a3c81e298ffb596( player, 0 );
    thread function_3fddadfd0f60d749( player, manualdropdata );
    thread manualdropwatch( player, manualdropdata );
    thread manualdropcleanup( player );
    thread function_a4729874a8daf9ac( player );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x2bc1
// Size: 0xad
function function_a4729874a8daf9ac( player )
{
    self endon( "manual_drop_cleanup" );
    self endon( "dropped" );
    self endon( "death" );
    player endon( "death_or_disconnect" );
    player endon( "manual_drop" );
    usingcontroller = player usinggamepad();
    
    while ( true )
    {
        updatedinput = player usinggamepad();
        
        if ( updatedinput != usingcontroller )
        {
            usingcontroller = updatedinput;
            
            if ( updatedinput )
            {
                player notifyonplayercommandremove( "manual_drop", "+armor" );
                player notifyonplayercommand( "manual_drop", "+actionslot 2" );
            }
            else
            {
                player notifyonplayercommandremove( "manual_drop", "+actionslot 2" );
                player notifyonplayercommand( "manual_drop", "+armor" );
            }
        }
        
        waitframe();
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x2c76
// Size: 0x34
function manualdropcleanup( player )
{
    waittill_any_3( "manual_drop_cleanup", "dropped", "death" );
    function_3a3c81e298ffb596( player, 0 );
    self.dropenabled = undefined;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0x2cb2
// Size: 0x7b
function manualdropwatch( player, manualdropdata )
{
    self endon( "manual_drop_cleanup" );
    self endon( "dropped" );
    self endon( "death" );
    self endon( "reset" );
    player endon( "death_or_disconnect" );
    
    while ( true )
    {
        player waittill_any_2( "manual_drop", "force_manual_drop" );
        
        if ( istrue( self.dropenabled ) )
        {
            thread function_1069580bc0a235cb( player, manualdropdata );
            return;
        }
        
        player thread scripts\mp\utility\print::tutorialprint( &"MP_JUP_WM/CAN_NOT_MANUAL_DROP", 2 );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0x2d35
// Size: 0x10e
function function_1069580bc0a235cb( player, manualdropdata )
{
    level endon( "game_ended" );
    usableobject = undefined;
    delaytrigger = isdefined( manualdropdata.trigger ) && isdefined( manualdropdata.triggerdelay );
    
    if ( delaytrigger )
    {
        if ( manualdropdata.trigger isusable() )
        {
            manualdropdata.trigger disableplayeruse( player );
        }
        else
        {
            player.pickupmanualdrop = 1;
        }
    }
    
    thread scripts\mp\gameobjects::setdropped( 0, undefined, 1, 1 );
    self notify( "manual_drop_cleanup" );
    self.manualdrop = 1;
    
    if ( isdefined( self.ondrop ) )
    {
        self [[ self.ondrop ]]( player );
    }
    
    if ( isdefined( manualdropdata.onmanualdrop ) && isfunction( manualdropdata.onmanualdrop ) )
    {
        self [[ manualdropdata.onmanualdrop ]]( player );
    }
    
    self.manualdrop = undefined;
    
    if ( delaytrigger )
    {
        thread function_eda9340b865645a3( player, manualdropdata );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0x2e4b
// Size: 0x60
function function_eda9340b865645a3( player, manualdropdata )
{
    level endon( "game_ended" );
    player endon( "disconnect" );
    wait manualdropdata.triggerdelay;
    
    if ( manualdropdata.trigger isusable() )
    {
        manualdropdata.trigger enableplayeruse( player );
        return;
    }
    
    player.pickupmanualdrop = undefined;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0x2eb3
// Size: 0x51f
function function_3fddadfd0f60d749( player, manualdropdata )
{
    self endon( "manual_drop_cleanup" );
    self endon( "dropped" );
    self endon( "death" );
    self endon( "reset" );
    player endon( "death_or_disconnect" );
    
    if ( !istrue( manualdropdata.var_1ecf2919ce07add ) )
    {
        player endon( "manual_drop" );
    }
    
    waitframe();
    var_af6bdfd2f2ee7bad = !isdefined( manualdropdata.dropdist ) || !isdefined( manualdropdata.var_5338ab800fa9b63a );
    offsetangle = undefined;
    dropdist = undefined;
    
    if ( !var_af6bdfd2f2ee7bad )
    {
        offsetangle = manualdropdata.var_5338ab800fa9b63a;
        dropdist = manualdropdata.dropdist;
    }
    else
    {
        assertex( !isdefined( manualdropdata.dropdist ) && !isdefined( manualdropdata.var_5338ab800fa9b63a ), "<dev string:x1c>" );
    }
    
    bombmode = isbombmode();
    ignoreents = [];
    
    if ( isdefined( manualdropdata.ignoreents ) )
    {
        ignoreents = manualdropdata.ignoreents;
    }
    
    ignoreents[ ignoreents.size ] = player;
    contents = create_contents( 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1 );
    
    while ( true )
    {
        if ( scripts\cp_mp\utility\player_utility::function_1e4a0e61fdb00e32( player ) || istrue( player.startedpickup ) )
        {
            function_3a3c81e298ffb596( player, 0 );
            waitframe();
            continue;
        }
        
        if ( bombmode )
        {
            touching = 0;
            
            foreach ( bombzone in level.objectives )
            {
                if ( player istouching( bombzone.trigger ) )
                {
                    function_3a3c81e298ffb596( player, 0 );
                    touching = 1;
                    break;
                }
            }
            
            if ( touching )
            {
                waitframe();
                continue;
            }
        }
        
        trace = undefined;
        height = player geteye()[ 2 ] - player.origin[ 2 ];
        end = player.origin + ( 0, 0, height / 2 );
        
        if ( !var_af6bdfd2f2ee7bad && isdefined( offsetangle ) && isdefined( dropdist ) )
        {
            forward = anglestoforward( player getplayerangles() );
            x = forward[ 0 ] * cos( offsetangle ) - forward[ 1 ] * sin( offsetangle );
            y = forward[ 0 ] * sin( offsetangle ) + forward[ 1 ] * cos( offsetangle );
            newforward = ( x, y, 0 );
            endvector = dropdist * vectornormalize( newforward );
            height = player geteye()[ 2 ] - player.origin[ 2 ];
            start = player.origin + ( 0, 0, height / 2 );
            end = start + endvector;
            trace = scripts\engine\trace::sphere_trace( start, end, height / 2 - 1, ignoreents, contents );
            
            /#
                if ( getdvarint( @"hash_a1028bc0f66ae86", 0 ) )
                {
                    scripts\engine\trace::draw_trace( trace, ( 0, 0, 1 ) );
                }
            #/
        }
        
        candrop = var_af6bdfd2f2ee7bad || !var_af6bdfd2f2ee7bad && isdefined( trace ) && trace[ "fraction" ] == 1;
        
        if ( istrue( manualdropdata.var_1ecf2919ce07add ) )
        {
            candrop = 1;
            end = getclosestpointonnavmesh( trace[ "position" ] ) + ( 0, 0, 20 );
            height = 60;
        }
        
        if ( !istrue( candrop ) )
        {
            trace = scripts\engine\trace::convert_surface_flag( trace );
            
            switch ( trace[ "surfacetype" ] )
            {
                case #"hash_bc95225f1fcb16e9":
                    candrop = 1;
                    break;
                default:
                    break;
            }
        }
        
        if ( istrue( candrop ) )
        {
            if ( function_babd6a87808a6651( player ) )
            {
                function_3a3c81e298ffb596( player, 0 );
            }
            else
            {
                secondtrace = scripts\engine\trace::ray_trace( end, end - ( 0, 0, height ), ignoreents, contents );
                
                /#
                    if ( getdvarint( @"hash_a1028bc0f66ae86", 0 ) )
                    {
                        scripts\engine\trace::draw_trace( secondtrace, ( 1, 0, 0 ) );
                    }
                #/
                
                if ( scripts\mp\outofbounds::ispointinoutofbounds( secondtrace[ "position" ] ) || scripts\mp\outofbounds::ispointinoutofbounds( secondtrace[ "position" ] + ( 0, 0, 12 ) ) || function_c3c18fcce2d382d( secondtrace[ "position" ] ) )
                {
                    function_3a3c81e298ffb596( player, 0 );
                }
                else if ( vectordot( secondtrace[ "normal" ], ( 0, 0, 1 ) ) > 0.8 )
                {
                    candrop = 1;
                    
                    if ( isdefined( secondtrace[ "entity" ] ) )
                    {
                        if ( function_4fcffd6d229b848a( secondtrace[ "entity" ] ) )
                        {
                            candrop = 0;
                        }
                    }
                    
                    function_3a3c81e298ffb596( player, candrop, secondtrace );
                }
                else
                {
                    function_3a3c81e298ffb596( player, 0 );
                }
            }
        }
        else
        {
            function_3a3c81e298ffb596( player, 0 );
        }
        
        if ( !player isonground() )
        {
            function_3a3c81e298ffb596( player, 0 );
        }
        
        waitframe();
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x33da
// Size: 0x81, Type: bool
function function_4fcffd6d229b848a( ent )
{
    if ( isdefined( ent.cover ) && isdefined( ent.cover.equipmentref ) && ent.cover.equipmentref == "equip_tac_cover" )
    {
        return true;
    }
    else if ( isdefined( ent.equipmentref ) && ent.equipmentref == "equip_tac_cover" )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 3
// Checksum 0x0, Offset: 0x3464
// Size: 0xe9
function function_3a3c81e298ffb596( player, enable, trace )
{
    if ( !isdefined( player ) || !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( trace ) && enable )
    {
        self.var_1972ccb1779c69d1 = trace;
    }
    
    if ( isdefined( self.dropenabled ) && self.dropenabled == enable )
    {
        return;
    }
    
    self.dropenabled = enable;
    enable = enable || istrue( self.manualdropdata.var_1ecf2919ce07add );
    
    if ( player usinggamepad() )
    {
        if ( enable )
        {
            player notifyonplayercommand( "manual_drop", "+actionslot 2" );
        }
        else
        {
            player notifyonplayercommandremove( "manual_drop", "+actionslot 2" );
        }
    }
    else if ( enable )
    {
        player notifyonplayercommand( "manual_drop", "+armor" );
    }
    else
    {
        player notifyonplayercommandremove( "manual_drop", "+armor" );
    }
    
    player setclientomnvar( "ui_carry_object_can_drop", enable );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x3555
// Size: 0x18, Type: bool
function function_ffae0b2bdeb1bb92( player )
{
    return !istrue( player.pickupmanualdrop );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x3576
// Size: 0xcf
function updatecurorigin()
{
    self endon( "gameobject_deleted" );
    level endon( "game_ended" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger endon( "move_gameobject" );
    }
    
    if ( getgametype() == "front" )
    {
        self.carrier endon( "disconnect" );
    }
    
    while ( true )
    {
        if ( isdefined( self.carrier ) )
        {
            self.curorigin = self.carrier.origin + ( 0, 0, 75 );
            self.curcarrierorigin = self.carrier.origin;
        }
        else
        {
            self.curorigin = self.trigger.origin;
            self.curcarrierorigin = undefined;
        }
        
        waitframe();
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x364d
// Size: 0x308
function updatecarryobjectorigin()
{
    self endon( "gameobject_deleted" );
    level endon( "game_ended" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger endon( "move_gameobject" );
    }
    
    thread updatecurorigin();
    
    if ( !isdefined( self.objpingdelay ) )
    {
        self.objpingdelay = 4;
    }
    
    for ( ;; )
    {
        if ( self.objpingdelay == 0 )
        {
            break;
        }
        
        if ( isdefined( self.carrier ) )
        {
            if ( self.objidpingfriendly )
            {
                foreach ( teamname in level.teamnamelist )
                {
                    if ( ( self.visibleteam == "friendly" || self.visibleteam == "any" ) && !isfriendlyteam( teamname ) )
                    {
                        if ( self.showworldicon )
                        {
                            if ( isdefined( self.pingobjidnum ) )
                            {
                                scripts\mp\objidpoolmanager::update_objective_position( self.pingobjidnum, self.carrier.origin );
                                
                                if ( istrue( self.pingplayers ) )
                                {
                                    objective_setpings( self.pingobjidnum, 1 );
                                }
                                else
                                {
                                    objective_setpingsforteam( self.pingobjidnum, teamname );
                                }
                                
                                objective_ping( self.pingobjidnum );
                                continue;
                            }
                            
                            if ( istrue( self.pingplayers ) )
                            {
                                objective_setpings( self.objidnum, 1 );
                            }
                            else
                            {
                                objective_setpingsforteam( self.objidnum, teamname );
                            }
                            
                            objective_ping( self.objidnum );
                        }
                    }
                }
            }
            
            if ( self.objidpingenemy )
            {
                foreach ( teamname in level.teamnamelist )
                {
                    if ( ( self.visibleteam == "enemy" || self.visibleteam == "any" ) && isfriendlyteam( teamname ) )
                    {
                        if ( self.showworldicon )
                        {
                            if ( isdefined( self.pingobjidnum ) )
                            {
                                scripts\mp\objidpoolmanager::update_objective_position( self.pingobjidnum, self.curorigin );
                                
                                if ( istrue( self.pingplayers ) )
                                {
                                    objective_setpings( self.pingobjidnum, 1 );
                                }
                                else
                                {
                                    objective_setpingsforteam( self.pingobjidnum, teamname );
                                }
                                
                                objective_ping( self.pingobjidnum );
                                continue;
                            }
                            
                            if ( istrue( self.pingplayers ) )
                            {
                                objective_setpings( self.objidnum, 1 );
                            }
                            else
                            {
                                objective_setpingsforteam( self.objidnum, teamname );
                            }
                            
                            objective_ping( self.objidnum );
                        }
                    }
                }
            }
            
            waittill_any_timeout_no_endon_death_2( self.objpingdelay, "dropped", "reset" );
            continue;
        }
        
        waitframe();
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x395d
// Size: 0x3a
function hidecarryiconongameend()
{
    self endon( "death_or_disconnect" );
    self endon( "drop_object" );
    level waittill( "game_ended" );
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 0;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x399f
// Size: 0x3d
function gameobjects_getcurrentprimaryweapon()
{
    curr = self getcurrentweapon();
    prim = self getcurrentprimaryweapon();
    var_a332a0449da18650 = prim getaltweapon();
    
    if ( var_a332a0449da18650 == curr )
    {
        return curr;
    }
    
    return prim;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x39e5
// Size: 0x6a
function watchcarryobjectweaponswitch( weapon )
{
    self endon( "goal_scored" );
    starttime = gettime();
    result = domonitoredweaponswitch( weapon, 1 );
    
    if ( isdefined( result ) )
    {
        if ( result == 0 )
        {
            if ( starttime == gettime() )
            {
                waittillframeend();
            }
            
            if ( isdefined( self.carryobject ) )
            {
                self.carryobject thread setdropped();
            }
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x3a57
// Size: 0x1ab
function giveobject( object )
{
    assert( !isdefined( self.carryobject ) );
    self.carryobject = object;
    thread trackcarrier();
    
    if ( isdefined( object.carryweapon ) )
    {
        object.carrierweaponcurrent = gameobjects_getcurrentprimaryweapon();
        object.carrierhascarryweaponinloadout = self hasweapon( object.carryweapon );
        
        if ( isdefined( object.carryweaponthink ) )
        {
            self thread [[ object.carryweaponthink ]]();
        }
        
        self giveweapon( object.carryweapon );
        thread watchcarryobjectweaponswitch( object.carryweapon );
        self disableweaponpickup();
        val::set( "giveObject", "weapon_switch", 0 );
    }
    else if ( !object.allowweapons )
    {
        val::set( "giveObject", "weapon", 0 );
        thread manualdropthink();
    }
    
    if ( isdefined( object.carryicon ) )
    {
        if ( level.splitscreen )
        {
            self.carryicon = createicon( object.carryicon, 33, 33 );
            self.carryicon setpoint( "BOTTOM LEFT", "BOTTOM LEFT", -50, -78 );
        }
        else
        {
            self.carryicon = createicon( object.carryicon, 50, 50 );
            self.carryicon setpoint( "BOTTOM LEFT", "BOTTOM LEFT", 175, -30 );
        }
        
        self.carryicon.hidewheninmenu = 1;
        thread hidecarryiconongameend();
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x3c0a
// Size: 0x221
function movetoposition( overrideorigin )
{
    if ( !isdefined( overrideorigin ) )
    {
        thread pickuptimeout( overrideorigin );
        return;
    }
    
    self notify( "manual_drop_cleanup" );
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        linkedparent = self.visuals[ index ] getlinkedparent();
        
        if ( isdefined( linkedparent ) )
        {
            self.visuals[ index ] unlink();
        }
        
        self.visuals[ index ] scriptmodelclearanim();
        
        if ( isdefined( overrideorigin ) )
        {
            self.visuals[ index ].origin = overrideorigin;
        }
        else if ( isbombmode() && self.visuals[ index ].targetname == "sd_bomb" )
        {
            self.visuals[ index ].origin = level.bombrespawnpoint;
            self.visuals[ index ].angles = level.bombrespawnangles;
        }
        else
        {
            self.visuals[ index ].origin = self.visuals[ index ].baseorigin;
            self.visuals[ index ].angles = self.visuals[ index ].baseangles;
        }
        
        self.visuals[ index ] show();
    }
    
    linkedparent = self.trigger getlinkedparent();
    
    if ( isdefined( linkedparent ) )
    {
        self.trigger unlink();
    }
    
    self.trigger.origin = self.trigger.baseorigin;
    
    if ( isdefined( overrideorigin ) )
    {
        self.trigger.origin = overrideorigin;
    }
    
    self.curorigin = self.trigger.origin;
    clearcarrier();
    
    if ( isdefined( self.var_4bcc694316c44d94 ) )
    {
        self [[ self.var_4bcc694316c44d94 ]]( self );
        return;
    }
    
    updatecompassicons();
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x3e33
// Size: 0x251
function returnhome( overrideorigin )
{
    self.isresetting = 1;
    self notify( "manual_drop_cleanup" );
    self notify( "reset" );
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        linkedparent = self.visuals[ index ] getlinkedparent();
        
        if ( isdefined( linkedparent ) )
        {
            self.visuals[ index ] unlink();
        }
        
        self.visuals[ index ] scriptmodelclearanim();
        
        if ( isdefined( overrideorigin ) )
        {
            self.visuals[ index ].origin = overrideorigin;
        }
        else if ( isbombmode() && self.visuals[ index ].targetname == "sd_bomb" )
        {
            self.visuals[ index ].origin = level.bombrespawnpoint;
            self.visuals[ index ].angles = level.bombrespawnangles;
        }
        else
        {
            self.visuals[ index ].origin = self.visuals[ index ].baseorigin;
            self.visuals[ index ].angles = self.visuals[ index ].baseangles;
        }
        
        self.visuals[ index ] show();
    }
    
    linkedparent = self.trigger getlinkedparent();
    
    if ( isdefined( linkedparent ) )
    {
        self.trigger unlink();
    }
    
    self.trigger.origin = self.trigger.baseorigin;
    
    if ( isdefined( overrideorigin ) )
    {
        self.trigger.origin = overrideorigin;
    }
    
    self.curorigin = self.trigger.origin;
    
    if ( isdefined( self.onreset ) )
    {
        self [[ self.onreset ]]();
    }
    
    clearcarrier();
    
    if ( isdefined( self.var_4bcc694316c44d94 ) )
    {
        self [[ self.var_4bcc694316c44d94 ]]( self );
    }
    else
    {
        updatecompassicons();
    }
    
    self.isresetting = 0;
    self notify( "reset_done" );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x408c
// Size: 0x35, Type: bool
function ishome()
{
    if ( isdefined( self.carrier ) )
    {
        return false;
    }
    
    if ( self.curorigin != self.trigger.baseorigin )
    {
        return false;
    }
    
    return true;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0x40ca
// Size: 0x101
function setposition( origin, angles )
{
    self.isresetting = 1;
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        self.visuals[ index ].origin = origin;
        self.visuals[ index ].angles = angles;
        self.visuals[ index ] show();
    }
    
    self.trigger.origin = origin;
    
    if ( getgametype() == "ball" || getgametype() == "tdef" )
    {
        self.trigger linkto( self.visuals[ 0 ] );
    }
    
    self.curorigin = self.trigger.origin;
    clearcarrier();
    updatecompassicons();
    self.isresetting = 0;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x41d3
// Size: 0x87
function carryobject_overridemovingplatformdeath( data )
{
    for ( index = 0; index < data.carryobject.visuals.size ; index++ )
    {
        data.carryobject.visuals[ index ] unlink();
    }
    
    data.carryobject.trigger unlink();
    waitframe();
    data.carryobject thread setdropped( 1 );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 4
// Checksum 0x0, Offset: 0x4262
// Size: 0xbdd
function setdropped( var_f2f5b1863e65433f, dropoffsetoverride, var_74435d86cb84be29, wasmanualdrop )
{
    if ( isdefined( self.setdropped ) && [[ self.setdropped ]]() )
    {
        return;
    }
    
    self.isresetting = 1;
    self.resetnow = undefined;
    self notify( "dropped" );
    
    foreach ( visual in self.visuals )
    {
        visual notsolid();
    }
    
    if ( isdefined( self.carrier ) )
    {
        droppoint = self.carrier.origin;
    }
    else
    {
        droppoint = self.curorigin;
    }
    
    if ( istrue( level.botsenabled ) || touchingdroptonavmeshtrigger( droppoint ) || level.mapname == "mp_junk" && ( level.gametype == "ctf" || level.gametype == "bigctf" ) && !self.carrier scripts\mp\gameobjects::touchingarbitraryuptrigger() || isdefined( self.manualdropdata ) && istrue( self.manualdropdata.var_1ecf2919ce07add ) )
    {
        droppoint = getclosestpointonnavmesh( droppoint );
    }
    
    if ( isdefined( level.bombdroploc ) )
    {
        droppoint = level.bombdroploc;
        level.bombdroploc = undefined;
    }
    
    if ( isdefined( dropoffsetoverride ) )
    {
        tstartoffset = dropoffsetoverride;
    }
    else
    {
        tstartoffset = 20;
    }
    
    var_12f59cd9e8d7e077 = 4000;
    upangles = ( 0, 0, 0 );
    tstart = droppoint + ( 0, 0, tstartoffset );
    tend = droppoint - ( 0, 0, var_12f59cd9e8d7e077 );
    contentoverride = create_contents( 0, 1, 1, 1, 0, 1, 1 );
    ignoreents = [];
    ignoreents[ ignoreents.size ] = self.visuals[ 0 ];
    
    if ( isdefined( self.carrier ) )
    {
        ignoreents[ ignoreents.size ] = self.carrier;
    }
    
    if ( isdefined( self.var_1972ccb1779c69d1 ) && istrue( wasmanualdrop ) )
    {
        trace = self.var_1972ccb1779c69d1;
        self.var_1972ccb1779c69d1 = undefined;
    }
    else if ( isdefined( self.carrier ) && self.carrier.team != "spectator" )
    {
        spheremin = 8;
        spheremax = 16;
        
        if ( getgametype() == "cyber" )
        {
            spheremin = 4;
            spheremax = 8;
        }
        else if ( getgametype() == "ctf" || getgametype() == "bigctf" || getgametype() == "tdef" || istrue( self.manualdropdata.var_1ecf2919ce07add ) )
        {
            spheremin = 2;
            spheremax = 4;
        }
        
        trace = capsule_trace( tstart, tend, spheremin, spheremax, ( 0, 0, 0 ), ignoreents, contentoverride, 0 );
        
        for ( i = 0; i < 4 ; i++ )
        {
            traceent = trace[ "entity" ];
            
            if ( isdefined( traceent ) )
            {
                if ( isdefined( traceent.code_classname ) && traceent.code_classname == "script_vehicle" && ( !isdefined( traceent.vehiclename ) || isdefined( traceent.vehiclename ) && traceent.vehiclename != "pac_sentry" ) || isdefined( traceent.objweapon ) && isweapon( traceent.objweapon ) || isdefined( traceent ) && istrue( traceent.issuper ) && isdefined( traceent.equipmentref ) && ( traceent.equipmentref == "equip_ammo_box" || traceent.equipmentref == "equip_trophy" ) || isdefined( traceent.code_classname ) && traceent.code_classname == "weapon_scavenger_bag_mp" || isdefined( traceent.code_classname ) && traceent.code_classname == "grenade" )
                {
                    ignoreents[ ignoreents.size ] = trace[ "entity" ];
                    trace = capsule_trace( tstart, tend, spheremin, spheremax, ( 0, 0, 0 ), ignoreents, contentoverride, 0 );
                }
                
                continue;
            }
            
            break;
        }
    }
    else
    {
        trace = ray_trace( self.safeorigin + ( 0, 0, 20 ), self.safeorigin - ( 0, 0, 20 ), ignoreents, contentoverride, 0 );
        
        if ( isplayer( trace[ "entity" ] ) )
        {
            trace[ "entity" ] = undefined;
        }
        
        if ( isdefined( trace[ "entity" ] ) && isdefined( trace[ "entity" ].code_classname ) && trace[ "entity" ].code_classname == "script_vehicle" )
        {
            ignoreents[ ignoreents.size ] = trace[ "entity" ];
            trace = ray_trace( self.safeorigin + ( 0, 0, 20 ), self.safeorigin - ( 0, 0, 20 ), ignoreents, contentoverride, 0 );
        }
    }
    
    foreach ( visual in self.visuals )
    {
        visual solid();
    }
    
    droppingplayer = self.carrier;
    
    if ( isdefined( trace ) )
    {
        tempangle = randomfloat( 360 );
        droporigin = trace[ "position" ];
        
        if ( isdefined( self.visualgroundoffset ) )
        {
            droporigin += self.visualgroundoffset;
        }
        
        forward = ( cos( tempangle ), sin( tempangle ), 0 );
        forward = vectornormalize( forward - trace[ "normal" ] * vectordot( forward, trace[ "normal" ] ) );
        var_6e1cff2315b21cee = 0;
        
        if ( getgametype() == "ctf" || getgametype() == "bigctf" || getgametype() == "tdef" || isbombmode() )
        {
            dropangles = ( 0, 0, 0 );
        }
        else
        {
            dropangles = vectortoangles( forward );
        }
        
        for ( index = 0; index < self.visuals.size ; index++ )
        {
            self.visuals[ index ].origin = droporigin;
            self.visuals[ index ].angles = dropangles;
            self.visuals[ index ] show();
        }
        
        self.trigger.origin = droporigin + ( 0, 0, var_6e1cff2315b21cee );
        self.curorigin = self.trigger.origin;
        mover = undefined;
        traceent = trace[ "entity" ];
        
        if ( isdefined( traceent ) && !isplayer( traceent ) && !isweapon( traceent ) && isdefined( traceent.objweapon ) && !isweapon( traceent.objweapon ) && !isbot( traceent ) && !isagent( traceent ) && !isturret( traceent ) && ( isdefined( traceent.classname ) || traceent.classname != "script_vehicle" && traceent.classname != "rocket" ) )
        {
            mover = trace[ "entity" ];
        }
        
        if ( isdefined( traceent ) && getgametype() == "bigctf" )
        {
            if ( traceent.classname == "script_vehicle" )
            {
                mover = trace[ "entity" ];
            }
        }
        
        level.traceent = trace[ "entity" ];
        
        if ( isdefined( traceent ) && ( istrue( traceent.issuper ) || isdefined( traceent.streakinfo ) ) )
        {
            neworigin = getclosestpointonnavmesh( self.curorigin + forward * 40 );
            
            if ( isdefined( self.visualgroundoffset ) )
            {
                neworigin += self.visualgroundoffset;
            }
            
            for ( index = 0; index < self.visuals.size ; index++ )
            {
                self.visuals[ index ].origin = neworigin;
            }
            
            self.trigger.origin = neworigin;
            self.curorigin = self.trigger.origin;
        }
        
        if ( isdefined( mover ) && isdefined( mover.owner ) )
        {
            linkedparent = mover getlinkedparent();
            
            if ( isdefined( linkedparent ) )
            {
                mover = linkedparent;
            }
        }
        
        if ( isdefined( mover ) )
        {
            if ( isdefined( mover.invalid_gameobject_mover ) && mover.invalid_gameobject_mover == 1 )
            {
                self.resetnow = 1;
            }
            else
            {
                for ( index = 0; index < self.visuals.size ; index++ )
                {
                    self.visuals[ index ] linkto( mover );
                }
                
                if ( self.trigger.classname == "trigger_radius" )
                {
                    self.var_9b5757415b1fcd6a = spawn( "script_origin", self.trigger.origin );
                    self.var_9b5757415b1fcd6a linkto( mover );
                    thread function_1d526ea6a817700c();
                }
                else
                {
                    self.trigger linkto( mover );
                }
                
                data = spawnstruct();
                data.carryobject = self;
                data.deathoverridecallback = &carryobject_overridemovingplatformdeath;
                self.trigger thread scripts\mp\movers::handle_moving_platforms( data );
            }
        }
        
        thread function_ae5131ddfa2b3af4( var_f2f5b1863e65433f );
    }
    else
    {
        for ( index = 0; index < self.visuals.size ; index++ )
        {
            self.visuals[ index ].origin = self.visuals[ index ].baseorigin;
            self.visuals[ index ].angles = self.visuals[ index ].baseangles;
            self.visuals[ index ] show();
        }
        
        self.trigger.origin = self.trigger.baseorigin;
        self.curorigin = self.trigger.baseorigin;
    }
    
    if ( isdefined( self.ondrop ) && !isdefined( var_f2f5b1863e65433f ) )
    {
        self [[ self.ondrop ]]( droppingplayer );
    }
    
    var_7e2c53b0bcf117d9 = spawnstruct();
    var_7e2c53b0bcf117d9.credit_player = droppingplayer;
    var_7e2c53b0bcf117d9.objective_entity = self;
    scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_objective_state_changed", var_7e2c53b0bcf117d9 );
    clearcarrier();
    
    if ( !istrue( var_74435d86cb84be29 ) )
    {
        if ( isdefined( self.var_4bcc694316c44d94 ) )
        {
            self [[ self.var_4bcc694316c44d94 ]]( self );
        }
        else
        {
            updatecompassicons();
        }
    }
    
    self.isresetting = 0;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x4e47
// Size: 0x76
function function_1d526ea6a817700c()
{
    level endon( "disconnect" );
    self endon( "pickup_object" );
    self endon( "reset" );
    self endon( "platformUnlinked" );
    thread function_416a3fe7e188a923();
    thread function_99ff6e53a4bfb995();
    
    while ( true )
    {
        if ( isdefined( self.var_9b5757415b1fcd6a ) )
        {
            self.trigger.origin = self.var_9b5757415b1fcd6a.origin;
            wait 0.01;
            continue;
        }
        
        break;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x4ec5
// Size: 0xad
function function_99ff6e53a4bfb995()
{
    level endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "platformUnlinked" );
    
    if ( !isdefined( self.var_9b5757415b1fcd6a getlinkedparent() ) )
    {
        return;
    }
    
    self.var_9b5757415b1fcd6a getlinkedparent() waittill( "death" );
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        self.visuals[ index ] unlink();
    }
    
    self.var_9b5757415b1fcd6a unlink();
    self.var_9b5757415b1fcd6a delete();
    movetoposition( getclosestpointonnavmesh( self.curorigin ) );
    self notify( "platformUnlinked" );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x4f7a
// Size: 0x78
function function_416a3fe7e188a923()
{
    level endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "platformUnlinked" );
    self waittill( "pickup_object" );
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        self.visuals[ index ] unlink();
    }
    
    self.var_9b5757415b1fcd6a unlink();
    self.var_9b5757415b1fcd6a delete();
    self notify( "platformUnlinked" );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x4ffa
// Size: 0x22
function function_ca7c06ef832aca23( traceent )
{
    self endon( "pickup_object" );
    traceent waittill( "death" );
    thread setdropped();
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x5024
// Size: 0x1d
function setcarrier( carrier )
{
    self.carrier = carrier;
    thread updatevisibilityaccordingtoradar();
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x5049
// Size: 0x46
function clearcarrier()
{
    if ( !isdefined( self.carrier ) )
    {
        return;
    }
    
    self notify( "dropped" );
    self.carrier thread takeobject( self );
    self.carrier = undefined;
    self.curcarrierorigin = undefined;
    self notify( "carrier_cleared" );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x5097
// Size: 0x85
function function_ae5131ddfa2b3af4( var_f2f5b1863e65433f )
{
    self endon( "pickup_object" );
    self endon( "reset_done" );
    level endon( "game_ended" );
    waitframe();
    
    if ( !isdefined( var_f2f5b1863e65433f ) )
    {
        safeorigin = undefined;
        
        if ( function_babd6a87808a6651( self.visuals[ 0 ], self.allowedintrigger ) && !function_29c0cf699c075f78() )
        {
            safeorigin = function_d1c485a557f40cd2();
            
            if ( isdefined( self.visualgroundoffset ) )
            {
                safeorigin += self.visualgroundoffset;
            }
        }
        
        thread movetoposition( safeorigin );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x5124
// Size: 0x273
function pickuptimeout( overrideorigin )
{
    self endon( "pickup_object" );
    self endon( "reset_done" );
    level endon( "game_ended" );
    
    if ( isdefined( overrideorigin ) )
    {
        returnhome( overrideorigin );
        return;
    }
    
    if ( isdefined( self.resetnow ) )
    {
        self.resetnow = undefined;
        returnhome();
        return;
    }
    
    for ( index = 0; index < level.radtriggers.size ; index++ )
    {
        if ( !self.visuals[ 0 ] istouching( level.radtriggers[ index ] ) )
        {
            continue;
        }
        
        returnhome();
        return;
    }
    
    for ( index = 0; index < level.minetriggers.size ; index++ )
    {
        if ( !self.visuals[ 0 ] istouching( level.minetriggers[ index ] ) )
        {
            continue;
        }
        
        returnhome();
        return;
    }
    
    for ( index = 0; index < level.hurttriggers.size ; index++ )
    {
        if ( !self.visuals[ 0 ] istouching( level.hurttriggers[ index ] ) )
        {
            continue;
        }
        
        returnhome( overrideorigin );
        return;
    }
    
    if ( istrue( level.ballallowedtriggers.size ) )
    {
        self.allowedintrigger = 0;
        
        foreach ( trigger in level.ballallowedtriggers )
        {
            if ( self.visuals[ 0 ] istouching( trigger ) )
            {
                self.allowedintrigger = 1;
                break;
            }
        }
    }
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( trigger in level.outofboundstriggers )
        {
            if ( istrue( self.allowedintrigger ) )
            {
                break;
            }
            
            if ( isdefined( trigger.script_noteworthy ) )
            {
                if ( trigger.script_noteworthy == "onlyVehOOB" )
                {
                    break;
                }
            }
            
            if ( !self.visuals[ 0 ] istouching( trigger ) )
            {
                continue;
            }
            
            returnhome( overrideorigin );
            return;
        }
    }
    
    if ( isdefined( self.autoresettime ) )
    {
        wait self.autoresettime;
        
        if ( !isdefined( self.carrier ) )
        {
            returnhome();
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x539f
// Size: 0x6f
function function_d1c485a557f40cd2()
{
    if ( isdefined( self.var_1972ccb1779c69d1 ) && isdefined( self.var_1972ccb1779c69d1[ "position" ] ) && !function_c3c18fcce2d382d( self.var_1972ccb1779c69d1[ "position" ], self.allowedintrigger ) )
    {
        return self.var_1972ccb1779c69d1[ "position" ];
    }
    
    return getclosestpointonnavmesh( self.visuals[ 0 ].origin );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x5417
// Size: 0x154
function takeobject( object )
{
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon destroyelem();
    }
    
    if ( isdefined( self ) )
    {
        self.carryobject = undefined;
    }
    
    self notify( "drop_object" );
    self notify( "manual_drop_cleanup" );
    
    if ( object.triggertype == "proximity" )
    {
        thread pickupobjectdelay( object );
    }
    
    if ( isreallyalive( self ) && !object.allowweapons )
    {
        if ( isdefined( object.carryweapon ) )
        {
            keepweapon = isdefined( object.keepcarryweapon ) && object.keepcarryweapon;
            
            if ( !object.carrierhascarryweaponinloadout && !keepweapon )
            {
                if ( isdefined( object.ballindex ) )
                {
                    wait 0.25;
                }
                
                self notify( "clear_carrier" );
                
                if ( isswitchingtoweaponwithmonitoring( object.carryweapon ) )
                {
                    abortmonitoredweaponswitch( object.carryweapon );
                }
                else
                {
                    _takeweapon( object.carryweapon );
                }
                
                thread forcevalidweapon( self.lastdroppableweaponobj );
            }
            else
            {
                assertmsg( "<dev string:x89>" );
            }
            
            self enableweaponpickup();
        }
        
        val::reset_all( "giveObject" );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x5573
// Size: 0xab
function trackcarrier()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "drop_object" );
    
    while ( isdefined( self.carryobject ) && isreallyalive( self ) )
    {
        if ( self isonground() )
        {
            trace = _bullet_trace( self.origin + ( 0, 0, 20 ), self.origin - ( 0, 0, 20 ), 0, undefined );
            
            if ( trace[ "fraction" ] < 1 )
            {
                self.carryobject.safeorigin = trace[ "position" ];
            }
        }
        
        wait 0.05;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x5626
// Size: 0xb1
function manualdropthink()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "drop_object" );
    self endon( "dropped" );
    self endon( "manual_drop_cleanup" );
    
    for ( ;; )
    {
        while ( self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed() )
        {
            wait 0.05;
        }
        
        while ( !self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() || self meleebuttonpressed() )
        {
            wait 0.05;
        }
        
        if ( isdefined( self.carryobject ) && !self usebuttonpressed() )
        {
            self.carryobject thread setdropped();
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x56df
// Size: 0x46
function deleteuseobject()
{
    releaseid();
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    else
    {
        error( "Tried deleting a use trigger that has already been removed!" );
    }
    
    self.trigger = undefined;
    self notify( "deleted" );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 7
// Checksum 0x0, Offset: 0x572d
// Size: 0x4d2
function createuseobject( ownerteam, trigger, visuals, var_e62df0718b7dcbca, reservedobjid, skipobjid, showoncompass )
{
    if ( istrue( trigger.isuseobject ) )
    {
        useobject = trigger;
    }
    else
    {
        useobject = spawnstruct();
    }
    
    useobject.type = "useObject";
    useobject.curorigin = trigger.origin;
    useobject.ownerteam = ownerteam;
    useobject.keyobject = undefined;
    
    if ( isent( trigger ) )
    {
        useobject.entnum = trigger getentitynumber();
    }
    else
    {
        useobject.entnum = trigger.index;
    }
    
    if ( issubstr( trigger.classname, "use" ) || istrue( trigger.usetype ) )
    {
        useobject.triggertype = "use";
    }
    else
    {
        useobject.triggertype = "proximity";
    }
    
    trigger.gameobject = useobject;
    useobject.trigger = trigger;
    
    for ( index = 0; index < visuals.size ; index++ )
    {
        visuals[ index ].baseorigin = visuals[ index ].origin;
        visuals[ index ].baseangles = visuals[ index ].angles;
    }
    
    useobject.visuals = visuals;
    
    if ( !isdefined( var_e62df0718b7dcbca ) )
    {
        var_e62df0718b7dcbca = ( 0, 0, 0 );
    }
    
    useobject.offset3d = var_e62df0718b7dcbca;
    useobject.compassicons = [];
    useobject requestid( 1, 1, reservedobjid, showoncompass, undefined, undefined, skipobjid );
    useobject.interactteam = "none";
    useobject.visibleteam = "none";
    useobject.onuse = undefined;
    useobject.oncantuse = undefined;
    useobject.usetext = "default";
    useobject.usetime = 10000;
    useobject.curprogress = 0;
    useobject.majoritycapprogress = 0;
    useobject.wasmajoritycapprogress = 0;
    useobject.stalemate = 0;
    useobject.wasstalemate = 0;
    useobject.captureblocked = 0;
    useobject.exclusiveuse = 1;
    useobject.teamprogress = [];
    useobject.teamprogress[ "none" ] = 0;
    
    if ( useobject.triggertype == "proximity" )
    {
        useobject.teamusetimes = [];
        useobject.teamusetexts = [];
        useobject.numtouching[ "neutral" ] = 0;
        useobject.touchlist[ "neutral" ] = [];
        useobject.numtouching[ "none" ] = 0;
        useobject.touchlist[ "none" ] = [];
        
        foreach ( name in level.teamnamelist )
        {
            useobject.teamprogress[ name ] = 0;
            useobject.numtouching[ name ] = 0;
            useobject.touchlist[ name ] = [];
            useobject.assisttouchlist[ name ] = [];
        }
        
        useobject.userate = 0;
        useobject.useratemultiplier = 1;
        useobject.var_f950eaa859b429c0 = 1;
        useobject.claimteam = "none";
        useobject.claimplayer = undefined;
        useobject.lastclaimteam = "none";
        useobject.lastclaimtime = 0;
        useobject.mustmaintainclaim = 0;
        useobject.cancontestclaim = 0;
        useobject thread useobjectproxthink();
    }
    else
    {
        foreach ( team in level.teamnamelist )
        {
            useobject.teamprogress[ team ] = 0;
        }
        
        useobject.userate = 1;
        useobject.useratemultiplier = 1;
        useobject thread useobjectusethink();
    }
    
    return useobject;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 4
// Checksum 0x0, Offset: 0x5c08
// Size: 0x27b
function createholduseobject( ownerteam, trigger, visuals, offset )
{
    useobject = spawnstruct();
    useobject.type = "useObject";
    useobject.curorigin = trigger.origin;
    useobject.ownerteam = ownerteam;
    useobject.entnum = trigger getentitynumber();
    useobject.keyobject = undefined;
    useobject.triggertype = "use";
    trigger.gameobject = useobject;
    useobject.trigger = trigger;
    
    for ( index = 0; index < visuals.size ; index++ )
    {
        visuals[ index ].baseorigin = visuals[ index ].origin;
        visuals[ index ].baseangles = visuals[ index ].angles;
    }
    
    useobject.visuals = visuals;
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    useobject.offset3d = offset;
    useobject.compassicons = [];
    useobject.interactteam = "none";
    useobject.visibleteam = "none";
    useobject.onuse = undefined;
    useobject.oncantuse = undefined;
    useobject.usetext = "default";
    useobject.usetime = 10000;
    useobject.curprogress = 0;
    useobject.stalemate = 0;
    useobject.wasstalemate = 0;
    useobject.captureblocked = 0;
    useobject.exclusiveuse = 1;
    useobject.teamprogress = [];
    useobject.teamprogress[ "none" ] = 0;
    
    foreach ( team in level.teamnamelist )
    {
        useobject.teamprogress[ team ] = 0;
    }
    
    useobject.userate = 1;
    useobject.useratemultiplier = 1;
    useobject thread useobjectusethink();
    return useobject;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 4
// Checksum 0x0, Offset: 0x5e8c
// Size: 0x24f
function createdynamicholduseobject( ownerteam, pos, visuals, offset )
{
    useobject = spawnstruct();
    useobject.type = "useObject";
    useobject.curorigin = pos;
    useobject.ownerteam = ownerteam;
    useobject.keyobject = undefined;
    useobject.triggertype = "use";
    
    for ( index = 0; index < visuals.size ; index++ )
    {
        visuals[ index ].baseorigin = visuals[ index ].origin;
        visuals[ index ].baseangles = visuals[ index ].angles;
    }
    
    useobject.visuals = visuals;
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    useobject.offset3d = offset;
    useobject.compassicons = [];
    useobject.interactteam = "none";
    useobject.visibleteam = "none";
    useobject.onuse = undefined;
    useobject.oncantuse = undefined;
    useobject.usetext = "default";
    useobject.usetime = 10000;
    useobject.curprogress = 0;
    useobject.stalemate = 0;
    useobject.wasstalemate = 0;
    useobject.captureblocked = 0;
    useobject.exclusiveuse = 1;
    useobject.teamprogress = [];
    useobject.teamprogress[ "none" ] = 0;
    
    foreach ( team in level.teamnamelist )
    {
        useobject.teamprogress[ team ] = 0;
    }
    
    useobject.userate = 1;
    useobject.useratemultiplier = 1;
    visuals[ 0 ] makeusable();
    visuals[ 0 ] thread usedynamicobjectusethink();
    return useobject;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x60e4
// Size: 0x15
function setkeyobject( object )
{
    self.keyobject = object;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x6101
// Size: 0x169
function usedynamicobjectusethink()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        println( "<dev string:x13d>" );
        
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !caninteractwith( player.pers[ "team" ], player ) )
        {
            continue;
        }
        
        if ( !player isonground() )
        {
            continue;
        }
        
        if ( player isusingremote() )
        {
            continue;
        }
        
        if ( iskillstreakweapon( player getcurrentweapon() ) )
        {
            continue;
        }
        
        if ( isdefined( self.usecondition ) )
        {
            if ( !self [[ self.usecondition ]]( player ) )
            {
                continue;
            }
        }
        
        if ( isdefined( self.keyobject ) && ( !isdefined( player.carryobject ) || player.carryobject != self.keyobject ) )
        {
            if ( isdefined( self.oncantuse ) )
            {
                self [[ self.oncantuse ]]( player );
            }
            
            continue;
        }
        
        if ( isdefined( self.useweapon ) && player hasweapon( self.useweapon ) )
        {
            continue;
        }
        
        if ( !player val::get( "weapon" ) )
        {
            continue;
        }
        
        if ( !self.exclusiveuse && !isdefined( self.exclusiveclaim ) )
        {
            thread useholdloop( player );
            continue;
        }
        
        useholdloop( player );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x6272
// Size: 0x196
function useobjectusethink()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    
    while ( true )
    {
        self.trigger waittill( "trigger", player );
        
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !caninteractwith( player.pers[ "team" ], player ) )
        {
            continue;
        }
        
        if ( !player isonground() && !( istrue( self.var_dbc472744080c5d7 ) && player isswimming() ) )
        {
            continue;
        }
        
        if ( player isusingremote() )
        {
            continue;
        }
        
        if ( isdefined( level.var_5fec67fa7f314c8a ) )
        {
            if ( ![[ level.var_5fec67fa7f314c8a ]]( player ) )
            {
                continue;
            }
        }
        
        if ( isdefined( self.usecondition ) )
        {
            if ( !self [[ self.usecondition ]]( player ) )
            {
                continue;
            }
        }
        
        if ( isdefined( self.keyobject ) && ( !isdefined( player.carryobject ) || player.carryobject != self.keyobject ) )
        {
            if ( isdefined( self.oncantuse ) )
            {
                self [[ self.oncantuse ]]( player );
            }
            
            continue;
        }
        
        if ( isdefined( self.useweapon ) && player hasweapon( self.useweapon ) )
        {
            continue;
        }
        
        if ( !player val::get( "weapon" ) )
        {
            continue;
        }
        
        if ( player ismeleeing() )
        {
            continue;
        }
        
        if ( !istrue( self.exclusiveuse ) && !isdefined( self.exclusiveclaim ) )
        {
            thread useholdloop( player );
            continue;
        }
        
        useholdloop( player );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x6410
// Size: 0x14e
function useholdloop( player )
{
    result = 1;
    var_56c1ce01138cf718 = 0;
    finished = 0;
    
    while ( result && ( !finished || isdefined( self.var_53f88be23696a633 ) && [[ self.var_53f88be23696a633 ]]( player ) ) )
    {
        if ( self.usetime > 0 )
        {
            if ( isdefined( self.onbeginuse ) )
            {
                player updateuiprogress( self, 0 );
                self [[ self.onbeginuse ]]( player );
            }
            
            if ( !isdefined( self.keyobject ) )
            {
                thread cantusehintthink();
            }
            
            team = player.pers[ "team" ];
            result = useholdthink( player );
            finished = 1;
            self notify( "finished_use" );
            
            if ( isdefined( self.onenduse ) )
            {
                self [[ self.onenduse ]]( team, player, result );
            }
        }
        
        if ( istrue( result ) )
        {
            if ( isdefined( self.onuse ) )
            {
                self [[ self.onuse ]]( player );
            }
            
            var_56c1ce01138cf718 = 1;
        }
    }
    
    if ( istrue( var_56c1ce01138cf718 ) )
    {
        var_7e2c53b0bcf117d9 = spawnstruct();
        var_7e2c53b0bcf117d9.credit_player = player;
        var_7e2c53b0bcf117d9.objective_entity = self;
        scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_objective_state_changed", var_7e2c53b0bcf117d9 );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x6566
// Size: 0x89, Type: bool
function checkobjectiskeyobject( player )
{
    keyobjects = self.keyobject;
    
    if ( !isarray( keyobjects ) )
    {
        keyobjects = [ keyobjects ];
    }
    
    foreach ( key in keyobjects )
    {
        if ( key istouching( self.trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x65f8
// Size: 0x87, Type: bool
function checkplayercarrykeyobject( player )
{
    keyobjects = self.keyobject;
    
    if ( !isarray( keyobjects ) )
    {
        keyobjects = [ keyobjects ];
    }
    
    foreach ( key in keyobjects )
    {
        if ( key == player.carryobject )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x6688
// Size: 0x8f
function cantusehintthink()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    self endon( "finished_use" );
    
    if ( !isdefined( self.trigger ) )
    {
        return;
    }
    
    while ( true )
    {
        self.trigger waittill( "trigger", player );
        
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !caninteractwith( player.pers[ "team" ], player ) )
        {
            continue;
        }
        
        if ( isdefined( self.oncantuse ) )
        {
            self [[ self.oncantuse ]]( player );
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x671f
// Size: 0x100
function getearliestclaimplayer()
{
    assert( self.claimteam != "<dev string:x16d>" );
    team = self.claimteam;
    earliestplayer = self.claimplayer;
    
    if ( self.touchlist[ team ].size > 0 )
    {
        earliesttime = undefined;
        players = getarraykeys( self.touchlist[ team ] );
        
        for ( index = 0; index < players.size ; index++ )
        {
            touchdata = self.touchlist[ team ][ players[ index ] ];
            
            if ( isdefined( touchdata.player ) && isreallyalive( touchdata.player ) && ( !isdefined( earliesttime ) || touchdata.starttime < earliesttime ) )
            {
                earliestplayer = touchdata.player;
                earliesttime = touchdata.starttime;
            }
        }
    }
    
    return earliestplayer;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x6828
// Size: 0x78, Type: bool
function isteamtouching()
{
    teamtouching = "none";
    
    foreach ( entry in level.teamnamelist )
    {
        if ( self.numtouching[ entry ] )
        {
            teamtouching = entry;
            break;
        }
    }
    
    return teamtouching != "none";
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x68a9
// Size: 0xe0d
function useobjectproxthink()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    thread proxtriggerthink();
    
    if ( !isdefined( self.ignorestomp ) )
    {
        self.ignorestomp = 0;
    }
    
    while ( true )
    {
        if ( !isdefined( self.interactteam ) || self.interactteam == "none" )
        {
            waitframe();
            scripts\mp\hostmigration::waittillhostmigrationdone();
            continue;
        }
        
        var_56c1ce01138cf718 = 0;
        creditplayer = undefined;
        self.wasuncontested = 0;
        
        if ( self.cancontestclaim )
        {
            if ( self.stalemate != self.wasstalemate )
            {
                if ( self.stalemate )
                {
                    if ( isdefined( self.oncontested ) )
                    {
                        self [[ self.oncontested ]]();
                    }
                    
                    var_56c1ce01138cf718 = 1;
                }
                else
                {
                    team = "none";
                    
                    foreach ( entry in level.teamnamelist )
                    {
                        if ( self.numtouching[ entry ] )
                        {
                            team = entry;
                            break;
                        }
                    }
                    
                    if ( team == "none" && self.ownerteam != "neutral" )
                    {
                        team = self.ownerteam;
                        setclaimteam( "none" );
                        self.claimplayer = undefined;
                    }
                    
                    foreach ( entry in level.teamnamelist )
                    {
                        if ( self.touchlist[ entry ].size )
                        {
                            touchlist = self.touchlist[ entry ];
                            players_touching = getarraykeys( touchlist );
                            
                            for ( index = 0; index < players_touching.size ; index++ )
                            {
                                player = touchlist[ players_touching[ index ] ].player;
                                
                                if ( !isalive( player ) )
                                {
                                    continue;
                                }
                                
                                if ( player.team == self.ownerteam )
                                {
                                    scripts\mp\objidpoolmanager::function_8f7a55bda12ebb21( &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", player );
                                }
                                else
                                {
                                    player scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, undefined, 0 );
                                }
                                
                                creditplayer = player;
                            }
                            
                            break;
                        }
                    }
                    
                    if ( isdefined( self.onuncontested ) )
                    {
                        self [[ self.onuncontested ]]( team );
                    }
                    
                    var_56c1ce01138cf718 = 1;
                    self.wasuncontested = 1;
                }
                
                self.wasstalemate = self.stalemate;
            }
            
            if ( !self.stalemate && self.majoritycapprogress != self.wasmajoritycapprogress )
            {
                self.wasmajoritycapprogress = self.majoritycapprogress;
            }
        }
        
        if ( !self.stalemate && !self.majoritycapprogress && !self.wasuncontested )
        {
            if ( self.mustmaintainclaim && !istrue( self.isunoccupied ) )
            {
                if ( self.ownerteam != "neutral" && !self.numtouching[ self.ownerteam ] )
                {
                    if ( isdefined( self.onunoccupied ) )
                    {
                        self [[ self.onunoccupied ]]();
                    }
                    
                    var_56c1ce01138cf718 = 1;
                    self.isunoccupied = 1;
                    setclaimteam( "none" );
                    self.claimplayer = undefined;
                }
                else if ( self.ownerteam == "neutral" )
                {
                    if ( !isteamtouching() )
                    {
                        if ( isdefined( self.onunoccupied ) )
                        {
                            self [[ self.onunoccupied ]]();
                        }
                        
                        var_56c1ce01138cf718 = 1;
                        self.isunoccupied = 1;
                        setclaimteam( "none" );
                        self.claimplayer = undefined;
                    }
                    else if ( isdefined( self.numtouchrequireduse ) )
                    {
                        self [[ self.numtouchrequireduse ]]( self.claimplayer.team );
                    }
                }
            }
            else if ( !istrue( self.isunoccupied ) && isdefined( self.onunoccupied ) )
            {
                team = "none";
                
                foreach ( entry in level.teamnamelist )
                {
                    if ( self.numtouching[ entry ] )
                    {
                        team = entry;
                        break;
                    }
                }
                
                if ( team == "none" )
                {
                    self.isunoccupied = 1;
                    self [[ self.onunoccupied ]]();
                }
            }
        }
        
        allowcapture = 1;
        
        if ( isdefined( self.numtouchrequired ) && self.numtouchrequired > self.numtouching[ self.claimteam ] )
        {
            allowcapture = 0;
        }
        
        if ( self.claimteam != "none" && self.lastclaimteam != self.claimteam )
        {
            var_56c1ce01138cf718 = 1;
            creditplayer = getearliestclaimplayer();
        }
        
        if ( self.claimteam != "none" && allowcapture )
        {
            if ( !self.usetime )
            {
                if ( !self.stalemate )
                {
                    if ( isdefined( self.var_f56edb5df74ae868 ) )
                    {
                        creditplayer = self [[ self.var_f56edb5df74ae868 ]]();
                    }
                    else
                    {
                        creditplayer = getearliestclaimplayer();
                    }
                    
                    setclaimteam( "none" );
                    self.claimplayer = undefined;
                    
                    if ( isdefined( creditplayer ) && isdefined( self.onuse ) )
                    {
                        self [[ self.onuse ]]( creditplayer );
                    }
                    
                    var_56c1ce01138cf718 = 1;
                    self.var_2dda7caa18ddd5f8 = 0;
                }
            }
            else if ( self.usetime && self.teamprogress[ self.claimteam ] >= self.usetime )
            {
                self.curprogress = 0;
                self.teamprogress[ self.claimteam ] = self.curprogress;
                creditplayer = getearliestclaimplayer();
                setclaimteam( "none" );
                self.claimplayer = undefined;
                
                if ( isdefined( self.onenduse ) )
                {
                    self [[ self.onenduse ]]( self.claimteam, creditplayer, isdefined( creditplayer ) );
                }
                
                if ( isdefined( creditplayer ) && isdefined( self.onuse ) )
                {
                    self [[ self.onuse ]]( creditplayer );
                }
                
                var_56c1ce01138cf718 = 1;
                self.var_2dda7caa18ddd5f8 = 0;
            }
            else if ( !self.stalemate && self.usetime && ( self.ownerteam != self.claimteam || istrue( self.majoritycapprogress ) ) )
            {
                if ( !self.numtouching[ self.claimteam ] )
                {
                    setclaimteam( "none" );
                    
                    if ( isdefined( self.onenduse ) )
                    {
                        self [[ self.onenduse ]]( self.claimteam, self.claimplayer, 0 );
                    }
                    
                    self.claimplayer = undefined;
                    var_56c1ce01138cf718 = 1;
                    self.var_2dda7caa18ddd5f8 = 0;
                }
                else if ( canstompprogresswithstalemate( self.claimteam ) && self.ownerteam == "neutral" )
                {
                    if ( self.lastclaimteam == self.claimteam && istrue( self.majoritycapprogress ) )
                    {
                        if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.claimteam ] == 0 )
                        {
                            stompenemyteamprogress( self.claimteam );
                        }
                        else
                        {
                            self.lastprogressteam = self.claimteam;
                            applycaptureprogressanduseupdate();
                        }
                    }
                }
                else if ( canstompprogress( self.claimteam ) && self.ownerteam == "neutral" && self.lastclaimteam != self.claimteam )
                {
                    if ( self.lastclaimteam != self.claimteam )
                    {
                        if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.claimteam ] == 0 )
                        {
                            stompenemyteamprogress( self.claimteam );
                        }
                        else if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.lastprogressteam ] > 0 )
                        {
                            stompenemyteamprogress( self.claimteam );
                        }
                        else
                        {
                            self.lastprogressteam = self.claimteam;
                            applycaptureprogressanduseupdate();
                        }
                    }
                }
                else if ( canstompprogress( self.claimteam ) && self.ownerteam == self.claimteam && ( !istrue( self.var_823c5a7bf6a0e64a ) || !istrue( self.teamprogress[ self.ownerteam ] ) ) )
                {
                    if ( isdefined( self.lastprogressteam ) && self.lastprogressteam == self.claimteam && self.teamprogress[ self.claimteam ] == 0 )
                    {
                        stompenemyteamprogress( self.claimteam );
                    }
                    else if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.lastprogressteam ] > 0 && self.teamprogress[ self.claimteam ] == 0 )
                    {
                        stompenemyteamprogress( self.claimteam );
                    }
                }
                else if ( canstompprogress( self.claimteam ) && self.ownerteam != self.claimteam && istrue( self.var_823c5a7bf6a0e64a ) && istrue( self.teamprogress[ self.ownerteam ] ) )
                {
                    if ( isdefined( self.lastprogressteam ) && self.lastprogressteam == self.claimteam && self.teamprogress[ self.claimteam ] == 0 )
                    {
                        stompenemyteamprogress( self.claimteam );
                    }
                    else if ( isdefined( self.lastprogressteam ) && self.lastprogressteam != self.claimteam && self.teamprogress[ self.lastprogressteam ] > 0 && self.teamprogress[ self.claimteam ] == 0 )
                    {
                        stompenemyteamprogress( self.claimteam );
                    }
                }
                else if ( isdefined( self.stronghold ) && isdefined( self.stronghold.capturedteam ) && self.claimteam == self.stronghold.capturedteam )
                {
                }
                else if ( self.ownerteam != self.claimteam )
                {
                    self.setblocking = 0;
                    self.setdefending = 0;
                    self.lastprogressteam = self.claimteam;
                    applycaptureprogressanduseupdate();
                }
                else if ( self.ownerteam == self.claimteam && istrue( self.var_823c5a7bf6a0e64a ) && ( !istrue( self.reinforced ) || self.curprogress < self.reinforcementmax ) )
                {
                    self.setblocking = 0;
                    self.setdefending = 0;
                    self.lastprogressteam = self.claimteam;
                    applycaptureprogressanduseupdate();
                }
                else if ( self.ownerteam == self.claimteam && istrue( self.majoritycapprogress ) )
                {
                    numothertouching = getnumtouchingexceptteam( self.claimteam );
                    
                    if ( numothertouching && !istrue( self.setblocking ) )
                    {
                        self.setblocking = 1;
                        self.setdefending = 0;
                        scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS" );
                        scripts\mp\objidpoolmanager::update_objective_setenemylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS" );
                    }
                    else if ( !numothertouching && !istrue( self.setdefending ) )
                    {
                        self.setblocking = 0;
                        self.setdefending = 1;
                        scripts\mp\gameobjects::setobjectivestatusicons( level.var_a58e0495b821276, level.iconcapture );
                    }
                }
            }
            else if ( !self.stalemate && self.usetime && self.ownerteam == self.claimteam )
            {
                if ( !self.numtouching[ self.claimteam ] )
                {
                    setclaimteam( "none" );
                    self.claimplayer = undefined;
                    
                    if ( isdefined( self.onenduse ) )
                    {
                        self [[ self.onenduse ]]( self.claimteam, self.claimplayer, 0 );
                    }
                    
                    self.var_2dda7caa18ddd5f8 = 0;
                }
            }
        }
        else if ( canstompprogress( self.ownerteam ) && self.ownerteam != "neutral" )
        {
            stompenemyteamprogress( self.ownerteam );
        }
        
        if ( var_56c1ce01138cf718 )
        {
            var_7e2c53b0bcf117d9 = spawnstruct();
            var_7e2c53b0bcf117d9.credit_player = creditplayer;
            var_7e2c53b0bcf117d9.objective_entity = self;
            scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_objective_state_changed", var_7e2c53b0bcf117d9 );
        }
        
        waitframe();
        scripts\mp\hostmigration::waittillhostmigrationdone();
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x76be
// Size: 0x45, Type: bool
function canstompprogress( var_c8200acbb85ac41f )
{
    return !istrue( self.ignorestomp ) && self.touchlist[ var_c8200acbb85ac41f ].size > 0 && !istrue( self.stalemate ) && self.curprogress > 0;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x770c
// Size: 0x44, Type: bool
function canstompprogresswithstalemate( var_c8200acbb85ac41f )
{
    return !istrue( self.ignorestomp ) && self.touchlist[ var_c8200acbb85ac41f ].size > 0 && self.majoritycapprogress && self.curprogress > 0;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x7759
// Size: 0xd3
function applycaptureprogressanduseupdate()
{
    if ( isdefined( self.var_944611b28b2c72b9 ) )
    {
        var_943409b28b1823c5 = self [[ self.var_944611b28b2c72b9 ]]( 1 );
        
        if ( !var_943409b28b1823c5 )
        {
            return;
        }
    }
    
    applycaptureprogress( self.claimteam, level.frameduration * self.userate );
    
    if ( isdefined( self.onuseupdate ) )
    {
        self [[ self.onuseupdate ]]( self.claimteam, self.teamprogress[ self.claimteam ] / self.usetime, level.frameduration * self.userate / self.usetime, self.claimplayer );
    }
    
    if ( isdefined( self.var_1b36c96ff904e7e6 ) )
    {
        self [[ self.var_1b36c96ff904e7e6 ]]( 1 );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x7834
// Size: 0x4c7
function stompenemyteamprogress( team )
{
    if ( isdefined( self.stompeenemyprogressupdate ) )
    {
        self [[ self.stompeenemyprogressupdate ]]( team );
    }
    
    delta = level.frameduration * self.userate;
    
    if ( istrue( self.var_823c5a7bf6a0e64a ) && self.ownerteam != "neutral" && team != self.ownerteam )
    {
        if ( isdefined( self.reinforcementstompscalar ) && self.reinforcementstompscalar > 0 )
        {
            delta *= self.reinforcementstompscalar;
        }
    }
    
    numtouching = getnumtouchingforteam( self.claimteam );
    numother = getnumtouchingexceptteam( self.claimteam );
    enemyteams = getenemyteams( team );
    
    foreach ( entry in enemyteams )
    {
        otherprogress = self.teamprogress[ entry ];
        
        if ( otherprogress > 0 )
        {
            if ( otherprogress < delta )
            {
                self.teamprogress[ entry ] = 0;
                self.curprogress = self.teamprogress[ entry ];
                scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 0 );
                scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, 0 );
                delta -= otherprogress;
                continue;
            }
            
            self.isunoccupied = 0;
            self.setclearing = 1;
            self.teamprogress[ entry ] -= delta;
            var_159b97bd7931576c = 0;
            
            if ( isdefined( self.segmentupdate ) )
            {
                lockedprogress = self.usetime * self.segmentupdate / level.capturesegments;
                
                if ( self.teamprogress[ entry ] < lockedprogress )
                {
                    self.teamprogress[ entry ] = lockedprogress;
                    var_159b97bd7931576c = 1;
                }
            }
            
            delta = 0;
            self.curprogress = self.teamprogress[ entry ];
            scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 1 );
            scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, entry );
            scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, self.curprogress / self.usetime );
            
            if ( !var_159b97bd7931576c )
            {
                scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_CLEARING_CAPS" );
                
                if ( isdefined( self.segmentupdate ) )
                {
                    scripts\mp\objidpoolmanager::update_objective_setenemylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_LOSING_CAPS" );
                    continue;
                }
                
                foreach ( player in getteamdata( team, "players" ) )
                {
                    if ( numtouching > 0 && numother > 0 )
                    {
                        player scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 3 );
                        continue;
                    }
                    
                    if ( istrue( self.var_823c5a7bf6a0e64a ) && istrue( self.reinforced ) && self.ownerteam != team )
                    {
                        player scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, "MP_INGAME_ONLY/OBJ_PUSHING_CAPS" );
                        continue;
                    }
                    
                    if ( self.curprogress > 0 )
                    {
                        player scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, "MP_INGAME_ONLY/OBJ_CLEARING_CAPS" );
                        continue;
                    }
                    
                    player scripts\mp\objidpoolmanager::function_160f522b63c32d76( 0, undefined, 0 );
                }
                
                if ( numtouching > 0 && numother > 0 )
                {
                    foreach ( player in getteamdata( entry, "players" ) )
                    {
                        player scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 3 );
                    }
                }
            }
        }
    }
    
    if ( self.curprogress <= 0 )
    {
        foreach ( p in self.touchlist[ self.ownerteam ] )
        {
            if ( isdefined( self.stompprogressreward ) )
            {
                [[ self.stompprogressreward ]]( p.player );
            }
        }
        
        if ( isdefined( self.oncleared ) )
        {
            [[ self.oncleared ]]( team );
        }
        
        self.setclearing = undefined;
        self.lastprogressteam = undefined;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x7d03
// Size: 0x3c3
function useobjectdecay( team )
{
    if ( getcapturebehavior() != "normal" && getgametype() != "arm" && getgametype() != "conflict" )
    {
        return;
    }
    
    level endon( "game_ended" );
    self endon( "deleted" );
    self notify( "useObjectDecay" );
    self endon( "useObjectDecay" );
    decaydelay = 0;
    
    while ( true )
    {
        waitframe();
        objid = self.objidnum;
        
        if ( self.stalemate )
        {
            decaydelay = 0;
        }
        
        if ( self.claimteam == "none" || istrue( self.var_a54131d8e1f9237a ) )
        {
            if ( self.usetime )
            {
                if ( !self.stalemate )
                {
                    if ( istrue( self.decaygraceperiod ) && decaydelay < self.decaygraceperiod )
                    {
                        decaydelay += level.framedurationseconds;
                        continue;
                    }
                    
                    if ( isdefined( self.permcapturethresholds ) )
                    {
                        if ( !isdefined( self.decaythreshold ) )
                        {
                            self.decaythreshold = 0;
                        }
                        
                        progress = self.curprogress / self.usetime;
                        
                        foreach ( frac in self.permcapturethresholds )
                        {
                            if ( progress >= frac && frac > self.decaythreshold )
                            {
                                self.decaythreshold = frac;
                            }
                        }
                        
                        if ( !isdefined( self.decayrate ) )
                        {
                            self.decayrate = self.usetime * 0.025 * level.framedurationseconds;
                        }
                        
                        if ( progress > self.decaythreshold )
                        {
                            self.curprogress -= self.decayrate;
                        }
                    }
                    else
                    {
                        if ( !isdefined( self.decayrate ) )
                        {
                            self.decayrate = 0.1 * level.frameduration;
                        }
                        
                        decayfactor = 1;
                        
                        if ( isdefined( self.var_b396ac0ad1624624 ) )
                        {
                            decayfactor = [[ self.var_b396ac0ad1624624 ]]();
                        }
                        
                        self.curprogress -= self.decayrate * decayfactor;
                        
                        if ( isdefined( self.var_1b36c96ff904e7e6 ) )
                        {
                            self [[ self.var_1b36c96ff904e7e6 ]]( 0 );
                        }
                    }
                }
                
                self.teamprogress[ team ] = self.curprogress;
            }
            
            if ( self.teamprogress[ team ] <= 0 )
            {
                self.curprogress = 0;
                self.teamprogress[ team ] = self.curprogress;
                self.lastprogressteam = undefined;
                scripts\mp\objidpoolmanager::objective_show_progress( objid, 0 );
                
                if ( isdefined( self.ondecayed ) )
                {
                    [[ self.ondecayed ]]( "none" );
                }
                
                break;
            }
            
            scripts\mp\hostmigration::waittillhostmigrationdone();
            
            if ( isdefined( self.objidnum ) )
            {
                if ( isdefined( self.overrideprogressteam ) )
                {
                    progress = self.teamprogress[ self.overrideprogressteam ] / self.usetime;
                    scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, progress );
                    continue;
                }
                
                if ( isdefined( self.lastprogressteam ) )
                {
                    progress = self.teamprogress[ self.lastprogressteam ] / self.usetime;
                    scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, progress );
                    continue;
                }
                
                progress = self.teamprogress[ self.lastclaimteam ] / self.usetime;
                scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, progress );
            }
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x80ce
// Size: 0x162, Type: bool
function canclaim( player )
{
    if ( isdefined( self.carrier ) )
    {
        return false;
    }
    
    if ( self.cancontestclaim )
    {
        playerteam = player scripts\mp\utility\stats::getpersstat( "team" );
        numtouching = getnumtouchingforteam( playerteam );
        
        if ( is_equal( level.gametype, "xfire" ) )
        {
            numother = function_47ab1f277f139986( playerteam );
        }
        else
        {
            numother = getnumtouchingexceptteam( playerteam );
        }
        
        if ( numtouching && !numother || numtouching && numother && numtouching != numother )
        {
            if ( numother && istrue( level.disablemajoritycapprogress ) )
            {
                self.stalemate = 1;
                self.majoritycapprogress = 0;
                self.wasmajoritycapprogress = 1;
                return false;
            }
            
            self.majoritycapprogress = 1;
            self.wasmajoritycapprogress = 0;
            return true;
        }
        
        if ( numtouching && numother && numtouching == numother )
        {
            self.stalemate = 1;
            self.majoritycapprogress = 0;
            self.wasmajoritycapprogress = 1;
            return false;
        }
    }
    
    if ( !isdefined( self.keyobject ) )
    {
        return true;
    }
    
    if ( isdefined( self.nocarryobject ) )
    {
        if ( checkobjectiskeyobject( player ) )
        {
            return true;
        }
    }
    
    if ( isdefined( player.carryobject ) )
    {
        if ( checkplayercarrykeyobject( player ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x8239
// Size: 0xe7
function proxtriggerthink()
{
    level endon( "game_ended" );
    self endon( "deleted" );
    entitynumber = self.entnum;
    
    while ( true )
    {
        self.trigger waittill( "trigger", ent );
        
        if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isdefined( ent.streakinfo ) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered( ent ) )
        {
            occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( ent );
            
            foreach ( occupant in occupants )
            {
                if ( function_42430bcb47389f23( occupant, 1 ) )
                {
                    processtouchent( occupant, entitynumber );
                }
            }
        }
        
        if ( function_42430bcb47389f23( ent ) )
        {
            processtouchent( ent, entitynumber );
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0x8328
// Size: 0x174, Type: bool
function function_42430bcb47389f23( player, var_372a5049b4c8b20a )
{
    if ( !isreallyalive( player ) )
    {
        return false;
    }
    
    if ( istrue( self.trigger.trigger_off ) )
    {
        return false;
    }
    
    if ( isagent( player ) && ( !isdefined( player.team ) || !isdefined( self.numtouching[ player.team ] ) ) )
    {
        return false;
    }
    
    if ( !scripts\cp_mp\utility\game_utility::isgameparticipant( player ) )
    {
        return false;
    }
    
    if ( isdefined( self.carrier ) )
    {
        return false;
    }
    
    if ( isdefined( player.classname ) && player.classname == "script_vehicle" )
    {
        return false;
    }
    
    if ( !isdefined( player.initialized_gameobject_vars ) )
    {
        return false;
    }
    
    if ( isdefined( self.usecondition ) )
    {
        if ( !self [[ self.usecondition ]]( player ) )
        {
            return false;
        }
    }
    
    relativeteam = getrelativeteam( player scripts\mp\utility\stats::getpersstat( "team" ) );
    
    if ( isdefined( self.teamusetimes[ relativeteam ] ) && self.teamusetimes[ relativeteam ] < 0 )
    {
        return false;
    }
    
    if ( istrue( var_372a5049b4c8b20a ) && getdvarint( @"hash_7d0a246e9851ce94", 1 ) == 1 && !ispointinvolume( player.origin, self.trigger ) && !ispointinvolume( player geteye(), self.trigger ) )
    {
        return false;
    }
    
    return true;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0x84a5
// Size: 0x54f
function processtouchent( player, entitynumber )
{
    if ( isreallyalive( player ) && !isdefined( player.touchtriggers[ entitynumber ] ) && player scripts\mp\meatshield::function_10de2964abd64e1f() )
    {
        if ( isdefined( self.onplayerenter ) )
        {
            self [[ self.onplayerenter ]]( player );
        }
        
        team = player scripts\mp\utility\stats::getpersstat( "team" );
        
        if ( istrue( level.var_d914655fe46b8e34 ) )
        {
            if ( !isdefined( self.var_2b085e33da6ed3f3 ) || !isdefined( self.var_2b085e33da6ed3f3[ team ] ) )
            {
                self.var_2b085e33da6ed3f3[ team ] = 0;
            }
            
            self.var_2b085e33da6ed3f3[ team ]++;
        }
        
        self.numtouching[ team ]++;
        touchname = player.guid;
        struct = spawnstruct();
        struct.player = player;
        struct.starttime = gettime();
        struct.var_d96989d14549fd76 = !isplayer( struct.player ) && function_21f4c6f630b17fc4( struct.player );
        struct.owner = struct.var_d96989d14549fd76 && isdefined( player.owner ) ? player.owner : undefined;
        self.touchlist[ team ][ touchname ] = struct;
        
        if ( isdefined( self.assisttouchlist ) )
        {
            if ( !isdefined( self.assisttouchlist[ team ][ touchname ] ) )
            {
                self.assisttouchlist[ team ][ touchname ] = struct;
            }
        }
    }
    
    if ( self.cancontestclaim )
    {
        playerteam = player scripts\mp\utility\stats::getpersstat( "team" );
        numtouching = getnumtouchingforteam( playerteam );
        numother = getnumtouchingexceptteam( playerteam );
        
        if ( numtouching && !numother || numtouching && numother && numtouching != numother )
        {
            if ( !( getgametype() == "wm" && istrue( level.disablemajoritycapprogress ) ) )
            {
                self.majoritycapprogress = 1;
                self.isunoccupied = 0;
            }
        }
    }
    
    if ( self.claimteam == "none" || !istrue( self.allowcapture ) || istrue( self.majoritycapprogress ) )
    {
        playerteam = player scripts\mp\utility\stats::getpersstat( "team" );
        
        if ( caninteractwith( playerteam, player ) )
        {
            if ( canclaim( player ) )
            {
                if ( function_ae3f61dab7aa5fec( player ) )
                {
                    player setclientomnvar( "ui_owned_player_capturing_index", self.objidnum + 1 );
                }
                
                if ( !proxtriggerlos( player ) )
                {
                    return;
                }
                
                if ( istrue( self.majoritycapprogress ) )
                {
                    if ( isdefined( self.mostnumtouching ) && isdefined( self.mostnumtouchingteam ) )
                    {
                        if ( !istrue( self.var_88806e65c3197677 ) || self.mostnumtouchingteam != self.ownerteam )
                        {
                            setclaimteam( self.mostnumtouchingteam );
                            claimplayer = getearliestclaimplayer();
                            self.claimplayer = claimplayer;
                        }
                    }
                }
                else
                {
                    setclaimteam( playerteam );
                    self.claimplayer = player;
                }
                
                relativeteam = getrelativeteam( playerteam );
                
                if ( isdefined( self.teamusetimes[ relativeteam ] ) )
                {
                    self.usetime = self.teamusetimes[ relativeteam ];
                }
                
                self.allowcapture = 1;
                
                if ( isdefined( self.numtouchrequired ) && self.numtouchrequired > self.numtouching[ self.claimteam ] )
                {
                    self.allowcapture = 0;
                }
                
                if ( self.usetime && isdefined( self.onbeginuse ) && self.allowcapture && self.ownerteam != self.claimteam )
                {
                    self.isunoccupied = 0;
                    var_e7f80702e259e98a = 1;
                    
                    if ( var_e7f80702e259e98a )
                    {
                        if ( !istrue( self.var_2dda7caa18ddd5f8 ) && isdefined( self.claimplayer ) )
                        {
                            self [[ self.onbeginuse ]]( self.claimplayer );
                            self.var_2dda7caa18ddd5f8 = 1;
                        }
                    }
                    else if ( isdefined( self.claimplayer ) )
                    {
                        if ( isdefined( self.didstatusnotify ) && !self.didstatusnotify )
                        {
                            self [[ self.onbeginuse ]]( self.claimplayer );
                        }
                        else if ( !isdefined( self.didstatusnotify ) )
                        {
                            self [[ self.onbeginuse ]]( self.claimplayer );
                        }
                    }
                }
            }
            else if ( isdefined( self.oncantuse ) )
            {
                self [[ self.oncantuse ]]( player );
            }
        }
        
        if ( canclaim( player ) )
        {
            if ( function_ae3f61dab7aa5fec( player ) )
            {
                player setclientomnvar( "ui_owned_player_capturing_index", self.objidnum + 1 );
            }
        }
    }
    
    if ( isreallyalive( player ) && !isdefined( player.touchtriggers[ entitynumber ] ) && player scripts\mp\meatshield::function_10de2964abd64e1f() )
    {
        player thread triggertouchthink( self );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x89fc
// Size: 0x68, Type: bool
function function_ae3f61dab7aa5fec( player )
{
    if ( scripts\mp\gameobjects::function_21f4c6f630b17fc4( player ) )
    {
        return false;
    }
    
    gametype = getdvar( @"ui_gametype", "" );
    
    if ( gametype == "conf" )
    {
        return false;
    }
    
    if ( gametype == "conf_tw" )
    {
        return false;
    }
    
    if ( gametype == "grind" )
    {
        return false;
    }
    
    if ( gametype == "grind" )
    {
        return false;
    }
    
    return true;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x8a6d
// Size: 0x211, Type: bool
function proxtriggerlos( player )
{
    if ( !isdefined( self.requireslos ) )
    {
        return true;
    }
    
    tracestart = player geteye();
    contentoverride = create_contents( 0, 1, 1, 1, 0, 1, 0 );
    ignoreents = [];
    
    if ( getgametype() == "tdef" || istrue( level.devball ) )
    {
        traceend = self.trigger.origin + ( 0, 0, 16 );
        checktrace = 0;
        ignoreents[ 0 ] = self.visuals[ 0 ];
    }
    else if ( getgametype() == "ball" || istrue( level.debughostagegame ) )
    {
        traceend = self.trigger.origin + ( 0, 0, 8 );
        checktrace = 0;
        ignoreents[ 0 ] = self.visuals[ 0 ];
    }
    else
    {
        traceend = self.trigger.origin + ( 0, 0, 32 );
        checktrace = 1;
        
        if ( isarray( self.visuals ) )
        {
            ignoreents[ 0 ] = self.visuals[ 0 ];
        }
        else
        {
            ignoreents[ 0 ] = self.visuals;
        }
    }
    
    ignoreents[ 1 ] = self.carrier;
    trace = ray_trace( tracestart, traceend, ignoreents, contentoverride, 0 );
    
    if ( trace[ "fraction" ] != 1 && checktrace )
    {
        traceend = self.trigger.origin + ( 0, 0, 16 );
        trace = ray_trace( tracestart, traceend, ignoreents, contentoverride, 0 );
    }
    
    if ( trace[ "fraction" ] != 1 )
    {
        traceend = self.trigger.origin + ( 0, 0, 0 );
        trace = ray_trace( tracestart, traceend, ignoreents, contentoverride, 0 );
    }
    
    return trace[ "fraction" ] == 1;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x8c87
// Size: 0xae
function setclaimteam( newteam )
{
    if ( getcapturebehavior() == "normal" )
    {
        if ( !istrue( self.ignorestomp ) && isgameplayteam( newteam ) )
        {
            if ( self.lastclaimteam != "none" )
            {
                if ( !isdefined( self.lastprogressteam ) )
                {
                    self.lastprogressteam = self.lastclaimteam;
                }
            }
        }
    }
    
    self.lastclaimteam = self.claimteam;
    self.lastclaimtime = gettime();
    self.claimteam = newteam;
    scripts\mp\objidpoolmanager::function_9b1a086f348520b0( self.objidnum, self.claimteam );
    updateuserate();
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x8d3d
// Size: 0xb
function getclaimteam()
{
    return self.claimteam;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x8d51
// Size: 0xb
function getlastclaimteam()
{
    return self.lastclaimteam;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x8d65
// Size: 0x5ce
function triggertouchthink( object )
{
    team = scripts\mp\utility\stats::getpersstat( "team" );
    guid = self.guid;
    
    if ( object function_9a19ccf8dc6c3caf() )
    {
        scripts\mp\objidpoolmanager::objective_pin_player( object.objidnum, self );
        self.pinnedobjid = object.objidnum;
        
        if ( isdefined( object.onpinnedstate ) )
        {
            object [[ object.onpinnedstate ]]( self );
        }
    }
    else if ( object function_dc06030ceb03363b() )
    {
        scripts\mp\objidpoolmanager::objective_pin_player( object.trigger.objidnum, self );
        self.pinnedobjid = object.trigger.objidnum;
        
        if ( isdefined( object.onpinnedstate ) )
        {
            object [[ object.onpinnedstate ]]( self );
        }
    }
    
    if ( !isdefined( self.touchinggameobjects ) )
    {
        self.touchinggameobjects = [];
    }
    
    objectnum = object.trigger getentitynumber();
    self.touchinggameobjects[ objectnum ] = object;
    
    if ( !isdefined( object.nousebar ) )
    {
        object.nousebar = 0;
    }
    
    self.touchtriggers[ object.entnum ] = object.trigger;
    object updateuserate();
    
    while ( function_f9e021b5763236b( object, team ) )
    {
        if ( object function_9a19ccf8dc6c3caf() && !isusingremote() && istrue( self.remoteunpinned ) )
        {
            scripts\mp\objidpoolmanager::objective_pin_player( object.objidnum, self );
            self.remoteunpinned = undefined;
        }
        else if ( object function_dc06030ceb03363b() && !isusingremote() && istrue( self.remoteunpinned ) )
        {
            scripts\mp\objidpoolmanager::objective_pin_player( object.objidnum, self );
            self.remoteunpinned = undefined;
        }
        
        if ( ( isplayer( self ) || isagent( self ) && istrue( self.var_599b158d152c358d ) || function_781844c0c05b5ac7() ) && object.usetime > 50 )
        {
            updateuiprogress( object, 1 );
        }
        
        waitframe();
    }
    
    if ( isdefined( self ) )
    {
        if ( object.usetime > 50 )
        {
            if ( isplayer( self ) || isagent( self ) && istrue( self.var_599b158d152c358d ) )
            {
                updateuiprogress( object, 0 );
            }
            
            if ( isdefined( self.touchtriggers ) )
            {
                self.touchtriggers[ object.entnum ] = undefined;
            }
        }
        else if ( isdefined( self.touchtriggers ) )
        {
            self.touchtriggers[ object.entnum ] = undefined;
        }
        
        if ( isdefined( self.touchtriggers ) )
        {
            self.touchinggameobjects[ objectnum ] = undefined;
        }
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    object.oldtouchlist = object.touchlist;
    
    if ( isdefined( self ) )
    {
        object.touchlist[ team ][ guid ] = undefined;
    }
    else
    {
        var_b05a747ea1537870 = [];
        
        foreach ( guid, touchstruct in object.touchlist[ team ] )
        {
            if ( !isdefined( touchstruct.player ) || !isalive( touchstruct.player ) )
            {
                var_b05a747ea1537870[ var_b05a747ea1537870.size ] = guid;
            }
        }
        
        foreach ( guid in var_b05a747ea1537870 )
        {
            object.touchlist[ team ][ guid ] = undefined;
        }
    }
    
    if ( isdefined( self ) && isdefined( object.trigger ) && isdefined( object.trigger.objidnum ) )
    {
        scripts\mp\objidpoolmanager::objective_unpin_player( object.trigger.objidnum, self );
        self.pinnedobjid = undefined;
        
        if ( object.lastclaimteam == "none" )
        {
            if ( isdefined( object.capturebehavior ) && object.capturebehavior == "persistent" )
            {
                scripts\mp\objidpoolmanager::objective_show_progress( object.trigger.objidnum, 0 );
            }
        }
    }
    
    if ( isdefined( self ) && isdefined( object.objidnum ) )
    {
        scripts\mp\objidpoolmanager::objective_unpin_player( object.objidnum, self, object.showoncompass );
        self.pinnedobjid = undefined;
        
        if ( object.lastclaimteam == "none" )
        {
            if ( isdefined( object.capturebehavior ) && object.capturebehavior == "persistent" )
            {
                scripts\mp\objidpoolmanager::objective_show_progress( object.objidnum, 0 );
            }
        }
    }
    
    object.numtouching[ team ]--;
    
    if ( istrue( level.var_d914655fe46b8e34 ) )
    {
        object.var_2b085e33da6ed3f3[ team ]--;
        
        if ( object.var_2b085e33da6ed3f3[ team ] < 1 )
        {
            object.var_2b085e33da6ed3f3 = array_remove_key( object.var_2b085e33da6ed3f3, team );
        }
    }
    
    object updateuserate();
    
    if ( isdefined( self ) && function_ae3f61dab7aa5fec( self ) )
    {
        self setclientomnvar( "ui_owned_player_capturing_index", -1 );
    }
    
    if ( isdefined( object.onunpinnedstate ) )
    {
        object [[ object.onunpinnedstate ]]( self );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0x933b
// Size: 0x1cc, Type: bool
function function_f9e021b5763236b( object, team )
{
    if ( !isreallyalive( self ) )
    {
        return false;
    }
    
    if ( !isdefined( object.trigger ) )
    {
        return false;
    }
    
    if ( function_781844c0c05b5ac7() )
    {
        if ( !issharedfuncdefined( "super_capture_bot", "captureBot_shouldCaptureObjective" ) )
        {
            return false;
        }
        
        if ( !callsharedfunc( "super_capture_bot", "captureBot_shouldCaptureObjective", object ) )
        {
            return false;
        }
    }
    else if ( !( self istouching( object.trigger ) || isdefined( self.vehicle ) && self.vehicle istouching( object.trigger ) ) )
    {
        return false;
    }
    
    if ( level.gameended )
    {
        return false;
    }
    
    if ( isdefined( object.checkinteractteam ) && object.team != team )
    {
        return false;
    }
    
    if ( istrue( self.inlaststand ) )
    {
        return false;
    }
    
    if ( isdefined( object.interactsquads ) && !isdefined( object.interactsquads[ self.team ] ) || isdefined( object.interactsquads ) && !array_contains( object.interactsquads[ self.team ], self.sessionsquadid ) )
    {
        return false;
    }
    
    if ( istrue( object.trigger.trigger_off ) )
    {
        return false;
    }
    
    if ( istrue( object.checkuseconditioninthink ) && isdefined( object.usecondition ) && !object [[ object.usecondition ]]( self ) )
    {
        return false;
    }
    
    if ( scripts\mp\utility\game::getgametype() == "bigctf" )
    {
        if ( !istrue( object caninteractwith( self.team, team ) ) )
        {
            return false;
        }
    }
    
    if ( !scripts\mp\meatshield::function_10de2964abd64e1f() )
    {
        return false;
    }
    
    return true;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x9510
// Size: 0x52
function migrationcapturereset( player )
{
    player.migrationcapturereset = 1;
    level waittill( "host_migration_begin" );
    
    if ( !isdefined( player ) || !isdefined( self ) )
    {
        return;
    }
    
    player setclientomnvar( "ui_securing", 0 );
    player setclientomnvar( "ui_securing_progress", 0 );
    self.migrationcapturereset = undefined;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x956a
// Size: 0x127
function getnumtouchingforteam( team )
{
    numtouching = self.numtouching[ team ];
    var_ce6ec2d4fa13ca16 = 0;
    numtouchingtemp = numtouching;
    
    foreach ( struct in self.touchlist[ team ] )
    {
        if ( !isdefined( struct.player ) )
        {
            continue;
        }
        
        if ( !isalive( struct.player ) )
        {
            continue;
        }
        
        if ( struct.player scripts\mp\utility\stats::getpersstat( "team" ) != team )
        {
            continue;
        }
        
        if ( isagent( struct.player ) && !istrue( struct.player.var_599b158d152c358d ) )
        {
            var_ce6ec2d4fa13ca16 += 1;
        }
    }
    
    numtouchingtemp -= var_ce6ec2d4fa13ca16;
    
    if ( numtouchingtemp == 0 )
    {
        self.var_15770ae4f644e96d = 1;
    }
    else
    {
        numtouching = numtouchingtemp;
        self.var_15770ae4f644e96d = 0;
    }
    
    return numtouching;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x969a
// Size: 0x179
function getnumtouchingexceptteam( ignoreteam )
{
    numtouching = 0;
    tempnumtouching = 0;
    self.mostnumtouching = 0;
    self.mostnumtouchingteam = "none";
    
    if ( istrue( level.var_d914655fe46b8e34 ) )
    {
        foreach ( teamname, var_54a3fcca5d3f54ff in self.var_2b085e33da6ed3f3 )
        {
            tempnumtouching += var_54a3fcca5d3f54ff;
            
            if ( tempnumtouching > 0 && tempnumtouching > self.mostnumtouching )
            {
                self.mostnumtouching = tempnumtouching;
                self.mostnumtouchingteam = teamname;
                tempnumtouching = 0;
            }
            
            if ( teamname != ignoreteam )
            {
                numtouching += var_54a3fcca5d3f54ff;
            }
        }
    }
    else
    {
        foreach ( entry in level.teamnamelist )
        {
            tempnumtouching += self.numtouching[ entry ];
            
            if ( tempnumtouching > 0 && tempnumtouching > self.mostnumtouching )
            {
                self.mostnumtouching = tempnumtouching;
                self.mostnumtouchingteam = entry;
                tempnumtouching = 0;
            }
            
            if ( entry != ignoreteam )
            {
                numtouching += self.numtouching[ entry ];
            }
        }
    }
    
    return numtouching;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x981c
// Size: 0x89
function function_47ab1f277f139986( ignoreteam )
{
    var_ec7483279f60efdb = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( entry == ignoreteam )
        {
            continue;
        }
        
        if ( self.numtouching[ entry ] > var_ec7483279f60efdb )
        {
            var_ec7483279f60efdb = self.numtouching[ entry ];
        }
    }
    
    return var_ec7483279f60efdb;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 3
// Checksum 0x0, Offset: 0x98ae
// Size: 0x17a7
function updateuiprogress( object, securing, progressobject )
{
    if ( !isdefined( level.hostmigrationtimer ) )
    {
        var_e44d265baccd0e6c = ter_op( isdefined( object.var_14d7b0ecc80353b ), object.var_14d7b0ecc80353b, &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS" );
        var_fe62d726a93f1f9b = ter_op( isdefined( object.var_956f480af849a6ca ), object.var_956f480af849a6ca, &"MP/GRABBING_FLAG" );
        var_ce9728bac543fa33 = ter_op( isdefined( object.var_f526ef46fecf38b2 ), object.var_f526ef46fecf38b2, &"MP/RETURNING_FLAG" );
        var_1cbde9e31bd172cb = ter_op( isdefined( object.var_b2dfb3f0778c829a ), object.var_b2dfb3f0778c829a, &"MP_INGAME_ONLY/OBJ_SECURING_CAPS" );
        var_2a63708633bd227b = ter_op( isdefined( object.var_c767098338453a2a ), object.var_c767098338453a2a, &"MP_INGAME_ONLY/OBJ_DESTROYING_CAPS" );
        var_de151c192e2ec2b1 = ter_op( isdefined( object.var_66993f4666bfa134 ), object.var_66993f4666bfa134, &"MP_INGAME_ONLY/NEUTRALIZING" );
        var_f40e023c11cb4137 = ter_op( isdefined( object.var_baa644f30eca9796 ), object.var_baa644f30eca9796, &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS" );
        var_7c84ca05b5d89121 = ter_op( isdefined( object.var_a761f33f4834f584 ), object.var_a761f33f4834f584, &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS" );
        var_aa979ec1219ea3fb = ter_op( isdefined( object.var_b7827c280b90eaa ), object.var_b7827c280b90eaa, &"MP_INGAME_ONLY/OBJ_BLOCKED_CAPS" );
        var_1d748649dc019efc = ter_op( isdefined( object.var_73d0a540867d306b ), object.var_73d0a540867d306b, &"MP_INGAME_ONLY/OBJ_BLOCKING_CAPS" );
        var_1cb654297b9afbf3 = ter_op( isdefined( object.var_fbe10b7e6c62a772 ), object.var_fbe10b7e6c62a772, &"MP_INGAME_ONLY/OBJ_LOSING_CAPS" );
        var_d5f6773674c728c3 = ter_op( isdefined( object.var_322784c331f286e2 ), object.var_322784c331f286e2, &"MP_INGAME_ONLY/CAPTURE_LOCKED" );
        var_97d0bfcd24e5718c = ter_op( isdefined( object.var_4d623d4bed3d5adb ), object.var_4d623d4bed3d5adb, &"MP_INGAME_ONLY/OBJ_CAPTURE_LOCK_CAPS" );
        
        if ( isdefined( object.interactteam ) && object.interactteam == "none" )
        {
            if ( istrue( object.capturelocked ) )
            {
                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 1, var_d5f6773674c728c3, 0 );
                return;
            }
            
            scripts\mp\objidpoolmanager::function_160f522b63c32d76( 0, undefined, 0 );
            return;
        }
        
        if ( !isdefined( progressobject ) )
        {
            progressobject = object;
        }
        
        objid = default_to( object.objidnum, -1 );
        progress = 0;
        
        if ( isdefined( object.clientprogress ) )
        {
            if ( !isdefined( object.clientprogress[ self.clientid ] ) )
            {
                object.clientprogress[ self.clientid ] = 0;
            }
            
            if ( object.clientprogress[ self.clientid ] > progressobject.usetime )
            {
                object.clientprogress[ self.clientid ] = progressobject.usetime;
            }
            
            progress = object.clientprogress[ self.clientid ] / progressobject.usetime;
        }
        else if ( isdefined( object.teamprogress ) && isdefined( object.claimteam ) )
        {
            if ( object.teamprogress[ object.claimteam ] > progressobject.usetime )
            {
                object.teamprogress[ object.claimteam ] = progressobject.usetime;
            }
            
            progress = object.teamprogress[ object.claimteam ] / progressobject.usetime;
            
            if ( getgametype() == "bigctf" )
            {
                if ( object.claimteam == "axis" && object.claimteam != object.originalownerteam )
                {
                    setomnvar( "ui_ctf_flag_axis_return", progress );
                }
                else if ( object.claimteam == "allies" && object.claimteam != object.originalownerteam )
                {
                    setomnvar( "ui_ctf_flag_allies_return", progress );
                }
            }
        }
        else
        {
            if ( progressobject.curprogress > progressobject.usetime )
            {
                progressobject.curprogress = progressobject.usetime;
            }
            
            progress = progressobject.curprogress / progressobject.usetime;
            
            if ( progressobject.usetime <= 1000 )
            {
                progress = min( progress + 0.05, 1 );
            }
            else
            {
                progress = min( progress + 0.01, 1 );
            }
        }
        
        if ( ( getgametype() == "ctf" || getgametype() == "bigctf" || getgametype() == "tdef" || getgametype() == "blitz" ) && !isdefined( object.id ) )
        {
            if ( securing && istrue( object.stalemate ) )
            {
                if ( !isdefined( self.ui_ctf_stalemate ) )
                {
                    var_1fd0e45b79c017d8 = 2;
                    
                    if ( !isdefined( self.ui_ctf_securing ) )
                    {
                        self.ui_ctf_securing = 1;
                    }
                    
                    if ( getgametype() == "bigctf" )
                    {
                        var_1fd0e45b79c017d8 = 1;
                    }
                    
                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( var_1fd0e45b79c017d8, var_e44d265baccd0e6c, -1 );
                    self.ui_ctf_stalemate = 1;
                }
                
                progress = 0.01;
            }
            else if ( securing && isdefined( self.ui_ctf_securing ) && isdefined( object.stalemate ) && !object.stalemate && object.ownerteam != self.team )
            {
                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_fe62d726a93f1f9b, 1 );
                self.ui_ctf_securing = 1;
                self.ui_ctf_stalemate = undefined;
            }
            else if ( securing && isdefined( self.ui_ctf_securing ) && isdefined( object.stalemate ) && !object.stalemate && object.ownerteam == self.team )
            {
                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_ce9728bac543fa33, 2 );
                self.ui_ctf_securing = 1;
                self.ui_ctf_stalemate = undefined;
            }
            else
            {
                if ( !securing && isdefined( self.ui_ctf_stalemate ) )
                {
                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 0, undefined, 0 );
                    self.ui_ctf_securing = undefined;
                }
                
                if ( securing && !isdefined( self.ui_ctf_stalemate ) && object.ownerteam == self.team )
                {
                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 0, undefined, 0 );
                    self.ui_ctf_securing = undefined;
                }
                
                if ( securing && !isdefined( self.ui_ctf_securing ) )
                {
                    if ( object.ownerteam != self.team )
                    {
                        scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_fe62d726a93f1f9b, 1 );
                        self.ui_ctf_securing = 1;
                    }
                    else if ( object.interactteam == "any" )
                    {
                        scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_ce9728bac543fa33, 2 );
                        self.ui_ctf_securing = 1;
                    }
                }
                
                self.ui_ctf_stalemate = undefined;
            }
            
            if ( !securing )
            {
                progress = 0.01;
                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 0, undefined, 0 );
                self.ui_ctf_securing = undefined;
            }
            
            if ( progress != 0 )
            {
                scripts\mp\objidpoolmanager::objective_set_progress_team( objid, self.team );
                scripts\mp\objidpoolmanager::objective_show_progress( objid, 1 );
                scripts\mp\objidpoolmanager::objective_set_progress( objid, progress );
            }
        }
        
        if ( hasdomflags() && isdefined( object.id ) && ( object.id == "domFlag" || object.id == "hardpoint" || object.id == "bomb_site" || object.id == "rugby_jugg" ) )
        {
            if ( securing && isdefined( object.stalemate ) && object.stalemate && !istrue( object.majoritycapprogress ) )
            {
                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_e44d265baccd0e6c, 3 );
            }
            else if ( securing && isdefined( object.stalemate ) && !object.stalemate && !istrue( object.majoritycapprogress ) && object.ownerteam != self.team )
            {
                if ( getgametype() == "hq" )
                {
                    if ( object.ownerteam == "neutral" )
                    {
                        scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1cbde9e31bd172cb, 1 );
                    }
                    else
                    {
                        scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_2a63708633bd227b, 2 );
                    }
                }
                else if ( istrue( object.neutralizing ) && object.ownerteam != self.team && object.ownerteam != "neutral" )
                {
                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_de151c192e2ec2b1 );
                }
                else
                {
                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1cbde9e31bd172cb, 1 );
                }
            }
            else
            {
                if ( !securing )
                {
                    if ( isdefined( object.overrideprogressteam ) )
                    {
                        scripts\mp\objidpoolmanager::objective_set_progress_team( objid, object.overrideprogressteam );
                    }
                    else if ( isdefined( object.lastprogressteam ) && object.lastprogressteam != object.claimteam && ( object.lastprogressteam != object.ownerteam || istrue( object.var_823c5a7bf6a0e64a ) ) )
                    {
                        scripts\mp\objidpoolmanager::objective_set_progress_team( objid, object.lastprogressteam );
                    }
                    else if ( object.claimteam != "none" )
                    {
                        scripts\mp\objidpoolmanager::objective_set_progress_team( objid, object.claimteam );
                    }
                    
                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 0, undefined, 0 );
                }
                else if ( securing && istrue( object.majoritycapprogress ) && isdefined( object.lastprogressteam ) && object.lastprogressteam == object.claimteam )
                {
                    if ( isdefined( object.overrideprogressteam ) )
                    {
                        scripts\mp\objidpoolmanager::objective_set_progress_team( objid, object.overrideprogressteam );
                    }
                    else if ( object.ownerteam != "neutral" && object.claimteam == object.ownerteam )
                    {
                        if ( self.team == object.ownerteam )
                        {
                        }
                        
                        scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, undefined, 0 );
                    }
                    else if ( object.claimteam != "none" )
                    {
                        if ( istrue( level.var_38b051a92ef5f144 ) )
                        {
                        }
                        else if ( getgametype() == "hq" )
                        {
                            if ( object.ownerteam == "neutral" )
                            {
                                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1cbde9e31bd172cb, 1 );
                            }
                            else
                            {
                                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_2a63708633bd227b, 2 );
                            }
                        }
                        else
                        {
                            numtouching = object getnumtouchingforteam( object.claimteam );
                            numother = object getnumtouchingexceptteam( object.claimteam );
                            
                            if ( istrue( object.capblocked ) )
                            {
                                if ( self.team == object.claimteam )
                                {
                                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_aa979ec1219ea3fb, 4 );
                                }
                                else
                                {
                                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1d748649dc019efc, 4 );
                                }
                            }
                            else if ( numtouching > 0 && numother > 0 )
                            {
                                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_e44d265baccd0e6c, 3 );
                            }
                            else if ( istrue( object.neutralizing ) && object.ownerteam != self.team && object.ownerteam != "neutral" )
                            {
                                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_de151c192e2ec2b1 );
                            }
                            else if ( !istrue( object.capblocked ) )
                            {
                                if ( object.ownerteam == self.team )
                                {
                                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_f40e023c11cb4137, 1 );
                                }
                                else
                                {
                                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1cbde9e31bd172cb, 1 );
                                }
                            }
                            else if ( isdefined( object.var_97feb74e7c5669c7 ) )
                            {
                                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, object.var_97feb74e7c5669c7, 1 );
                            }
                        }
                        
                        scripts\mp\objidpoolmanager::objective_set_progress_team( objid, object.claimteam );
                    }
                }
                else if ( getgametype() == "rugby" )
                {
                    if ( !isdefined( object.claimteam ) || object.claimteam == "none" )
                    {
                        object.numtouching[ self.team ] = 1;
                        
                        if ( !isdefined( object.lastclaimteam ) )
                        {
                            object.lastclaimteam = "none";
                        }
                        
                        object setclaimteam( self.pers[ "team" ] );
                        object setownerteam( self.pers[ "team" ] );
                    }
                    
                    if ( securing )
                    {
                        if ( object.claimteam != "none" )
                        {
                            scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1cbde9e31bd172cb, 1 );
                            scripts\mp\objidpoolmanager::objective_set_progress_team( objid, object.claimteam );
                            scripts\mp\objidpoolmanager::objective_show_progress( objid, 1 );
                            scripts\mp\objidpoolmanager::objective_set_progress( objid, progress );
                        }
                    }
                    else
                    {
                        object.claimteam = "none";
                    }
                }
                
                if ( securing && object.ownerteam == self.team )
                {
                }
            }
            
            if ( getgametype() != "rush" )
            {
                if ( !securing || !object caninteractwith( self.team, self ) && ( !isdefined( object.stalemate ) || isdefined( object.stalemate ) && !object.stalemate ) )
                {
                    if ( progressobject.curprogress == 0 && !istrue( object.capturelocked ) )
                    {
                        scripts\mp\objidpoolmanager::objective_show_progress( objid, 0 );
                    }
                }
            }
            
            if ( progress != 0 )
            {
                if ( showspecificteamprogress( object ) )
                {
                    scripts\mp\objidpoolmanager::objective_show_team_progress( objid, object.claimteam );
                }
                else
                {
                    scripts\mp\objidpoolmanager::objective_show_progress( objid, 1 );
                }
                
                if ( level.teambased && isdefined( object.teamprogress ) && isdefined( object.claimteam ) && securing )
                {
                    if ( !object.stalemate )
                    {
                        if ( isdefined( object.overrideprogressteam ) )
                        {
                            scripts\mp\objidpoolmanager::objective_set_progress_team( objid, object.overrideprogressteam );
                            scripts\mp\objidpoolmanager::objective_set_progress( objid, object.teamprogress[ object.overrideprogressteam ] / progressobject.usetime );
                        }
                        else
                        {
                            scripts\mp\objidpoolmanager::objective_set_progress_team( objid, object.claimteam );
                            scripts\mp\objidpoolmanager::objective_set_progress( objid, progress );
                        }
                        
                        if ( self.team == object.claimteam )
                        {
                            if ( istrue( level.var_38b051a92ef5f144 ) )
                            {
                            }
                            else if ( getgametype() == "hq" )
                            {
                                if ( object.ownerteam == "neutral" )
                                {
                                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1cbde9e31bd172cb, 1 );
                                }
                                else
                                {
                                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_2a63708633bd227b, 2 );
                                }
                            }
                            else if ( istrue( object.neutralizing ) && object.ownerteam != self.team && object.ownerteam != "neutral" )
                            {
                                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_de151c192e2ec2b1 );
                            }
                            else if ( !istrue( object.capblocked ) )
                            {
                                if ( object.ownerteam == self.team )
                                {
                                    if ( istrue( object.var_823c5a7bf6a0e64a ) )
                                    {
                                        scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_7c84ca05b5d89121, 1 );
                                    }
                                    else
                                    {
                                        scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_f40e023c11cb4137, 1 );
                                    }
                                }
                                else
                                {
                                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1cbde9e31bd172cb, 1 );
                                }
                            }
                            else if ( isdefined( object.var_97feb74e7c5669c7 ) )
                            {
                                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, object.var_97feb74e7c5669c7, 1 );
                            }
                        }
                        else
                        {
                            numtouching = 0;
                            numother = 0;
                            
                            if ( object.ownerteam == "neutral" && isdefined( object.claimteam ) )
                            {
                                numtouching = object getnumtouchingforteam( object.claimteam );
                                numother = object getnumtouchingexceptteam( object.ownerteam );
                            }
                            else
                            {
                                numtouching = object getnumtouchingforteam( object.ownerteam );
                                numother = object getnumtouchingexceptteam( object.ownerteam );
                            }
                            
                            if ( istrue( object.capblocked ) )
                            {
                                if ( self.team == object.claimteam )
                                {
                                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_aa979ec1219ea3fb, 4 );
                                }
                                else
                                {
                                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1d748649dc019efc, 4 );
                                }
                            }
                            else if ( numtouching > 0 && numother > 0 )
                            {
                                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_e44d265baccd0e6c, 3 );
                            }
                            else
                            {
                                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1cb654297b9afbf3, 5 );
                            }
                        }
                    }
                    else if ( object.stalemate && istrue( object.majoritycapprogress ) )
                    {
                        scripts\mp\objidpoolmanager::objective_set_progress_team( objid, object.claimteam );
                        scripts\mp\objidpoolmanager::objective_set_progress( objid, progress );
                        
                        if ( self.team == object.claimteam )
                        {
                            if ( getgametype() == "hq" )
                            {
                                if ( object.ownerteam == "neutral" )
                                {
                                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1cbde9e31bd172cb, 1 );
                                }
                                else
                                {
                                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_2a63708633bd227b, 2 );
                                }
                            }
                            else if ( istrue( object.neutralizing ) && object.ownerteam != self.team && object.ownerteam != "neutral" )
                            {
                                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_de151c192e2ec2b1, 6 );
                            }
                            else
                            {
                                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1cbde9e31bd172cb, 1 );
                            }
                        }
                        else
                        {
                            scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1cb654297b9afbf3, 5 );
                        }
                    }
                    else
                    {
                        scripts\mp\objidpoolmanager::objective_set_progress_team( objid, undefined );
                    }
                }
                else if ( !level.teambased )
                {
                    scripts\mp\objidpoolmanager::objective_set_progress_client( objid, self );
                }
            }
            else if ( isdefined( object.teamprogress ) && isdefined( object.claimteam ) )
            {
                if ( istrue( object.capturelocked ) )
                {
                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_97d0bfcd24e5718c, 1 );
                }
                else
                {
                    foreach ( progressteam, progress in object.teamprogress )
                    {
                        if ( isdefined( self.team ) && !object.stalemate && istrue( object.majoritycapprogress ) )
                        {
                            if ( self.team == progressteam && progress > 0 )
                            {
                                scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_1cb654297b9afbf3, 5 );
                            }
                            else if ( self.team == object.ownerteam && progress == 0 && !istrue( object.setclearing ) )
                            {
                                if ( istrue( object.var_823c5a7bf6a0e64a ) )
                                {
                                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_7c84ca05b5d89121, 5 );
                                }
                                else
                                {
                                    scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, var_f40e023c11cb4137, 5 );
                                }
                            }
                            
                            break;
                        }
                    }
                }
            }
            
            return;
        }
        
        if ( isbombmode() && isdefined( object.id ) && ( object.id == "bomb_zone" || object.id == "defuse_object" ) )
        {
            if ( isdefined( self ) )
            {
                if ( securing && isdefined( self ) )
                {
                    if ( !isdefined( self.ui_bomb_planting_defusing ) )
                    {
                        idx = 0;
                        
                        if ( object.id == "bomb_zone" )
                        {
                            idx = 1;
                        }
                        else if ( object.id == "defuse_object" )
                        {
                            idx = 2;
                        }
                        
                        self.ui_bomb_planting_defusing = 1;
                    }
                }
                else
                {
                    self.ui_bomb_planting_defusing = undefined;
                    
                    if ( !isdefined( object.resetprogress ) || istrue( object.resetprogress ) )
                    {
                        progress = 0.01;
                    }
                }
                
                if ( progress != 0 )
                {
                    if ( !isdefined( object.showprogressforteam ) )
                    {
                        scripts\mp\objidpoolmanager::objective_set_progress_team( objid, self.team );
                        objective_show_team_progress( objid, self.team );
                        object.showprogressforteam = self.team;
                    }
                    else if ( object.showprogressforteam != self.team )
                    {
                        scripts\mp\objidpoolmanager::objective_hide_team_progress( objid, object.showprogressforteam );
                        scripts\mp\objidpoolmanager::objective_set_progress_team( objid, self.team );
                        scripts\mp\objidpoolmanager::objective_show_team_progress( objid, self.team );
                        object.showprogressforteam = self.team;
                    }
                    
                    scripts\mp\objidpoolmanager::objective_set_progress( objid, progress );
                    setomnvar( "ui_bomb_progress", progress );
                }
            }
            
            return;
        }
        
        if ( isdefined( object.id ) )
        {
            idx = 0;
            
            switch ( object.id )
            {
                case #"hash_3fd866e3da61a87":
                case #"hash_e477c24ee18bb2f6":
                    idx = 1;
                    
                    if ( istrue( self.var_9ee2c87e0747c021 ) )
                    {
                        idx = 61;
                    }
                    
                    break;
                case #"hash_bf5597954aaed3d7":
                    idx = 2;
                    break;
                case #"hash_dbf719cee2feda22":
                    idx = 3;
                    break;
                case #"hash_82aad0a51185a053":
                    idx = 4;
                    break;
                case #"hash_6686a1466f9a8d41":
                    idx = 5;
                    break;
                case #"hash_668692466f9a75a4":
                    idx = 6;
                    break;
                case #"hash_c63c3cbdbdbd5178":
                    idx = 7;
                    break;
                case #"hash_631f416c3d8360d4":
                    idx = 8;
                    break;
                case #"hash_e726fddec3f4a467":
                    idx = 9;
                    break;
                case #"hash_973d1db8b6644466":
                    idx = 10;
                    break;
                case #"hash_cc625e548a303e68":
                    idx = 13;
                    break;
                case #"hash_3f4b70eb42439fbe":
                    idx = 15;
                    break;
                case #"hash_32eeb14581d379aa":
                    idx = 19;
                    break;
                case #"hash_7f7fd592a3f31def":
                    idx = 21;
                    break;
                case #"hash_ec25beb87c3d651a":
                    idx = 22;
                    break;
                case #"hash_81085f42186ab362":
                    idx = 23;
                    break;
                case #"hash_d39f3f9905d4cc88":
                    idx = 24;
                    break;
                case #"hash_5a9b08740c00857a":
                    idx = 27;
                    break;
                case #"hash_25c39dcba398587f":
                    idx = 28;
                    break;
                case #"hash_d747fa3ff1b78b29":
                    idx = 36;
                    break;
            }
            
            updateuisecuring( progress, securing, idx, object, progressobject.usetime, progressobject );
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xb05d
// Size: 0x3f, Type: bool
function showspecificteamprogress( object )
{
    switch ( getgametype() )
    {
        case #"hash_7b0c576c4a7e4890":
            if ( object.claimteam == game[ "attackers" ] )
            {
                return true;
            }
            
            break;
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xb0a5
// Size: 0x20b, Type: bool
function hasdomflags()
{
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        if ( getsubgametype() == "zonecontrol" )
        {
            return false;
        }
        
        return true;
    }
    
    var_c8f4c582625f492d = getxhash( getgametype() );
    
    if ( var_c8f4c582625f492d == #"landgrab" )
    {
        return true;
    }
    
    switch ( getgametype() )
    {
        case #"hash_4cb5825e78aaa8c":
        case #"hash_ca6516c10db2c95":
        case #"hash_1aac086c17fe5ccb":
        case #"hash_1b1eecd3863a50cf":
        case #"hash_214e6c6c1b43ae4a":
        case #"hash_25397d96e5bc8403":
        case #"hash_2f5af599c5c220d3":
        case #"hash_3ae8dcf2840c03a0":
        case #"hash_53825b446469ac4c":
        case #"hash_5e78ea9021845d4a":
        case #"hash_5ff8e011d5b9d1c8":
        case #"hash_634e449bb53a8268":
        case #"hash_6efb0f59a62300fb":
        case #"hash_75b6db03edb1e84e":
        case #"hash_78ebb3b7ce8f864f":
        case #"hash_7f9c384a34cc392f":
        case #"hash_8c758b84936e8d42":
        case #"hash_8eb3658fb4985833":
        case #"hash_99a69534b169e838":
        case #"hash_9ccabb62c3d37fb0":
        case #"hash_a1313b745c17c07e":
        case #"hash_a6b6d6b8dc1096cd":
        case #"hash_b8aae84522ccf348":
        case #"hash_b9aaf1c4459d9a15":
        case #"hash_c7f4420f385eeb3d":
        case #"hash_cf3000550ee7e8b3":
        case #"hash_d82d642e83fb9772":
        case #"hash_dd5b900f435d3f36":
        case #"hash_e2e043391c7c9074":
        case #"hash_ec24570718a340f5":
        case #"hash_ec72fd25bbbac99e":
        case #"hash_f25c018be2dd3f5f":
        case #"hash_f4a9126c03d3385b":
        case #"hash_fa34c5f6bd6d4432":
        case #"hash_fa44d9f6bd7a2fa1":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 6
// Checksum 0x0, Offset: 0xb2b9
// Size: 0x4e4
function updateuisecuring( progress, securing, idx, object, usetime, progressobject )
{
    objid = undefined;
    
    if ( !isdefined( progressobject ) )
    {
        progressobject = object;
    }
    
    if ( securing )
    {
        if ( !isdefined( object.usedby ) )
        {
            object.usedby = [];
        }
        
        if ( !isdefined( self.migrationcapturereset ) )
        {
            object thread migrationcapturereset( self );
        }
        
        if ( !existinarray( self, object.usedby ) )
        {
            object.usedby[ object.usedby.size ] = self;
        }
        
        if ( !isdefined( self.ui_securing ) )
        {
            self setclientomnvar( "ui_securing", idx );
            self.ui_securing = 1;
            
            if ( isdefined( object ) && ( object isrevivetrigger() || object function_89ae7f031dd8bc23() ) )
            {
                if ( isdefined( object.owner ) )
                {
                    reviver = default_to( self.reviver, self );
                    object.owner setclientomnvar( "ui_reviver_id", reviver getentitynumber() );
                    object.owner setclientomnvar( "ui_securing", 6 );
                }
            }
        }
        
        if ( object.id == "laststand_reviver" || object.id == "plea_for_help_looting" )
        {
            revivee = undefined;
            reviver = undefined;
            
            if ( isdefined( object ) && ( object isrevivetrigger() || object function_89ae7f031dd8bc23() ) )
            {
                revivee = object.owner;
                reviver = default_to( revivee.reviver, self );
            }
            
            if ( isdefined( revivee ) && isdefined( reviver ) && reviver == revivee )
            {
                self setclientomnvar( "ui_securing", 16 );
            }
            
            if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() || istrue( level.var_6d63cbd43e47315e ) )
            {
                scripts\mp\gametypes\br::updatesquadmemberlaststandreviveprogress( revivee, self, progress );
            }
        }
        else if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() && object.id == "laststand_interrogator" )
        {
            var_5bebd2013b0f01ec = undefined;
            
            if ( isdefined( object ) && object function_ab8d64fe065bf6f7() )
            {
                var_5bebd2013b0f01ec = object.owner;
            }
            
            if ( isdefined( var_5bebd2013b0f01ec ) && self != var_5bebd2013b0f01ec )
            {
                var_5bebd2013b0f01ec setclientomnvar( "ui_securing", 19 );
            }
        }
    }
    else
    {
        if ( isdefined( object.usedby ) && existinarray( self, object.usedby ) )
        {
            object.usedby = array_remove( object.usedby, self );
        }
        
        self setclientomnvar( "ui_securing", 0 );
        self.ui_securing = undefined;
        
        if ( isdefined( object ) && ( object isrevivetrigger() || object function_89ae7f031dd8bc23() ) )
        {
            if ( isdefined( object.owner ) )
            {
                object.owner setclientomnvar( "ui_reviver_id", -1 );
                object.owner setclientomnvar( "ui_securing", 0 );
            }
        }
        
        progress = 0.01;
        
        if ( isdefined( object.objidnum ) )
        {
            objid = object.objidnum;
        }
    }
    
    if ( usetime == 500 )
    {
        progress = min( progress + 0.15, 1 );
    }
    
    if ( progress != 0 )
    {
        if ( progressobject.curprogress > 0 )
        {
            progress = min( progressobject.curprogress / progressobject.usetime, 1 );
        }
        
        if ( isdefined( object ) && ( object isrevivetrigger() || object function_89ae7f031dd8bc23() || object function_ab8d64fe065bf6f7() ) )
        {
            if ( isdefined( object.owner ) )
            {
                object.owner setclientomnvar( "ui_securing_progress", progress );
                
                if ( istrue( self.var_93018d510a589832 ) || object function_89ae7f031dd8bc23() )
                {
                    self setclientomnvar( "ui_securing_progress", progress );
                }
                
                if ( isdefined( object.owner.reviver ) && istrue( object.owner.reviver == self ) )
                {
                    if ( is_equal( scripts\cp_mp\laststand::function_538e8d0f5b4d6383(), object.owner ) || !isdefined( self.var_3c3de22bd4680edb ) )
                    {
                        self setclientomnvar( "ui_securing_progress", progress );
                    }
                }
                
                if ( isdefined( object.objidnum ) && getgametype() == "cyber" )
                {
                    scripts\mp\objidpoolmanager::objective_unpin_player( object.objidnum, self );
                }
            }
        }
        else
        {
            self setclientomnvar( "ui_securing_progress", progress );
        }
        
        if ( isdefined( object.objidnum ) )
        {
            scripts\mp\objidpoolmanager::objective_set_progress( object.objidnum, progress );
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xb7a5
// Size: 0x68, Type: bool
function existinarray( ent, array )
{
    if ( array.size > 0 )
    {
        foreach ( entity in array )
        {
            if ( entity == ent )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xb816
// Size: 0x7eb
function updateuserate()
{
    if ( self.claimteam == "none" && self.ownerteam != "neutral" && self.ownerteam != "any" )
    {
        team = self.ownerteam;
    }
    else
    {
        team = self.claimteam;
    }
    
    numclaimants = self.numtouching[ team ];
    var_773eb33d831d5bb8 = 0;
    var_6c3b950f29ab2ef3 = 0;
    numother = 0;
    var_f3158d80c9ee245c = 0;
    var_3c3d61129f8f8827 = 0;
    var_cc0da48e9a204a66 = 0;
    self.var_eb8e721d46f12e18 = 0;
    self.var_57040f129b0e27fb = 0;
    self.var_51f08547fa39ce14 = [];
    self.var_51f08547fa39ce14[ 1 ] = 0;
    self.var_51f08547fa39ce14[ 2 ] = 0;
    self.var_51f08547fa39ce14[ 3 ] = 0;
    teamlist = level.teamnamelist;
    
    if ( istrue( level.var_d914655fe46b8e34 ) )
    {
        teamlist = getarraykeys( self.var_2b085e33da6ed3f3 );
    }
    
    foreach ( teamname in teamlist )
    {
        if ( team != teamname )
        {
            foreach ( struct in self.touchlist[ teamname ] )
            {
                if ( !isdefined( struct.player ) )
                {
                    continue;
                }
                
                if ( scripts\mp\gameobjects::function_21f4c6f630b17fc4( struct.player ) )
                {
                    if ( isdefined( struct.player.owner ) )
                    {
                        function_f1e265068d2e3fc5( struct.player.owner, self.claimteam );
                    }
                }
                
                if ( !isalive( struct.player ) )
                {
                    continue;
                }
                
                if ( struct.player scripts\mp\utility\stats::getpersstat( "team" ) != teamname )
                {
                    continue;
                }
                
                if ( isagent( struct.player ) && !istrue( struct.player.var_599b158d152c358d ) )
                {
                    var_3c3d61129f8f8827 += 1;
                }
            }
            
            numother += self.numtouching[ teamname ];
            continue;
        }
        
        foreach ( struct in self.touchlist[ team ] )
        {
            if ( !isdefined( struct.player ) )
            {
                continue;
            }
            
            if ( scripts\mp\gameobjects::function_21f4c6f630b17fc4( struct.player ) )
            {
                if ( isdefined( struct.player.owner ) )
                {
                    function_f1e265068d2e3fc5( struct.player.owner, self.claimteam );
                }
            }
            
            if ( !isalive( struct.player ) )
            {
                continue;
            }
            
            if ( struct.player scripts\mp\utility\stats::getpersstat( "team" ) != team )
            {
                continue;
            }
            
            if ( isagent( struct.player ) && !istrue( struct.player.var_599b158d152c358d ) )
            {
                var_6c3b950f29ab2ef3 += 1;
            }
            
            if ( struct.player.objectivescaler == 1 )
            {
                continue;
            }
            
            numclaimants *= struct.player.objectivescaler;
            var_cc0da48e9a204a66 = struct.player.objectivescaler;
        }
    }
    
    foreach ( teamname in teamlist )
    {
        foreach ( struct in self.touchlist[ teamname ] )
        {
            if ( scripts\mp\gameobjects::function_21f4c6f630b17fc4( struct.player ) )
            {
                if ( issharedfuncdefined( "super_capture_bot", "captureBot_getTeamIndex" ) )
                {
                    teamindex = self thread [[ getsharedfunc( "super_capture_bot", "captureBot_getTeamIndex" ) ]]( teamname );
                    
                    if ( teamindex > 0 )
                    {
                        self.var_51f08547fa39ce14[ teamindex ]++;
                    }
                }
                
                if ( team == teamname )
                {
                    var_773eb33d831d5bb8++;
                    continue;
                }
                
                var_f3158d80c9ee245c++;
            }
        }
    }
    
    var_4d9bd2cd1ce666ee = numother - var_3c3d61129f8f8827;
    
    if ( var_4d9bd2cd1ce666ee != numother )
    {
        if ( var_4d9bd2cd1ce666ee == 0 )
        {
            var_4d9bd2cd1ce666ee = numother;
        }
        else if ( numother > numclaimants )
        {
            var_4d9bd2cd1ce666ee = max( var_4d9bd2cd1ce666ee, numclaimants );
        }
    }
    
    var_ea2744afc870c5ce = numclaimants - var_6c3b950f29ab2ef3;
    
    if ( var_ea2744afc870c5ce != numclaimants )
    {
        if ( var_ea2744afc870c5ce == 0 )
        {
            var_ea2744afc870c5ce = numclaimants;
        }
        else if ( numclaimants > numother )
        {
            var_ea2744afc870c5ce = max( var_ea2744afc870c5ce, numother );
        }
    }
    
    self.stalemate = ter_op( istrue( self.alwaysstalemate ), var_ea2744afc870c5ce && var_4d9bd2cd1ce666ee, var_ea2744afc870c5ce && var_4d9bd2cd1ce666ee && var_ea2744afc870c5ce == var_4d9bd2cd1ce666ee );
    
    if ( getcapturebehavior() == "all_teams_dom_together" )
    {
        self.stalemate = 0;
    }
    
    if ( !numclaimants && !numother )
    {
        self.majoritycapprogress = 0;
    }
    
    if ( !self.stalemate && istrue( self.wasstalemate ) && numclaimants > numother )
    {
        self.majoritycapprogress = 1;
    }
    
    if ( isdefined( self.triggertype ) && self.triggertype == "use" )
    {
    }
    else
    {
        self.userate = 0;
    }
    
    var_39acbf9baa6e7ec6 = 0;
    var_2ffcb75e45e03a66 = 0;
    numclaimants -= var_6c3b950f29ab2ef3;
    var_39acbf9baa6e7ec6 = max( numclaimants - var_773eb33d831d5bb8, 0 );
    var_2ffcb75e45e03a66 = max( numother - var_f3158d80c9ee245c, 0 );
    
    if ( issharedfuncdefined( "super_capture_bot", "captureBot_setClaimants" ) )
    {
        self thread [[ getsharedfunc( "super_capture_bot", "captureBot_setClaimants" ) ]]( team, self.var_51f08547fa39ce14, self.objidnum + 1 );
    }
    
    if ( numclaimants )
    {
        if ( numclaimants > numother )
        {
            if ( var_773eb33d831d5bb8 > 0 || var_f3158d80c9ee245c > 0 )
            {
                if ( team == "axis" )
                {
                    self.var_eb8e721d46f12e18 = var_773eb33d831d5bb8;
                    self.var_57040f129b0e27fb = var_f3158d80c9ee245c;
                }
                else if ( team == "allies" )
                {
                    self.var_eb8e721d46f12e18 = var_f3158d80c9ee245c;
                    self.var_57040f129b0e27fb = var_773eb33d831d5bb8;
                }
                
                self.userate = min( function_3f702f8fed26558a( var_39acbf9baa6e7ec6, var_2ffcb75e45e03a66, var_773eb33d831d5bb8, var_f3158d80c9ee245c ), ter_op( isdefined( level.objectivescaler ), level.objectivescaler, 4 ) );
            }
            else
            {
                self.userate = min( numclaimants - numother, ter_op( isdefined( level.objectivescaler ), level.objectivescaler, 4 ) );
            }
            
            if ( self.userate > 1 || getdvarint( @"hash_4753586a2ac8718f", 0 ) == 1 )
            {
                self.userate *= self.useratemultiplier;
            }
        }
    }
    
    if ( isdefined( self.isarena ) && self.isarena && var_cc0da48e9a204a66 != 0 )
    {
        self.userate = 1 * var_cc0da48e9a204a66;
        return;
    }
    
    if ( isdefined( self.isarena ) && self.isarena )
    {
        self.userate = 1;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xc009
// Size: 0x774, Type: bool
function useholdthink( player )
{
    self endon( "deleted" );
    player notify( "use_hold" );
    
    if ( istrue( self.exclusiveuse ) && isdefined( self.trigger ) && ( self.trigger.classname == "trigger_use" || self.trigger.classname == "trigger_use_touch" ) )
    {
        player clientclaimtrigger( self.trigger );
    }
    
    if ( !istrue( self.var_2efb40714a6e9468 ) )
    {
        player allowmovement( 0 );
    }
    
    var_d9842c97badaba31 = isdefined( self.id ) && ( self.id == "traversalassist" || self.id == "breach" || self.id == "care_package" || self.id == "wm_buildable" || self.id == "wm_IED" );
    
    if ( isbombmode() )
    {
        if ( !var_d9842c97badaba31 && level.gametype != "cyber" )
        {
            if ( isanymlgmatch() || istrue( level.silentplant ) )
            {
                player setentitysoundcontext( "silent_plant", "on" );
                
                if ( istrue( player.isdefusing ) )
                {
                    self.useweapon = makeweapon( "briefcase_defuse_silent_mp" );
                }
                else
                {
                    self.useweapon = makeweapon( "briefcase_silent_mp" );
                }
            }
        }
    }
    
    useweapon = self.useweapon;
    lastweapon = player getcurrentweapon();
    isrevivetrigger = isrevivetrigger();
    
    if ( isdefined( useweapon ) )
    {
        assert( isdefined( lastweapon ) );
        switchimmediate = 0;
        
        if ( lastweapon.basename == "iw9_cyberemp_mp" )
        {
            switchimmediate = 1;
        }
        
        if ( lastweapon == useweapon )
        {
            assert( isdefined( player.lastnonuseweapon ) );
            lastweapon = player.lastnonuseweapon;
        }
        
        assert( lastweapon != useweapon );
        player.lastnonuseweapon = lastweapon;
        setammo = 0;
        usedbefore = 0;
        
        if ( getgametype() == "cyber" || isrevivetrigger )
        {
            setammo = 1;
            usedbefore = 0;
        }
        
        player _giveweapon( useweapon, undefined, undefined, 0 );
        player setweaponammostock( useweapon, setammo );
        player setweaponammoclip( useweapon, setammo );
        player thread switchtouseweapon( useweapon, switchimmediate );
    }
    else if ( !var_d9842c97badaba31 && !istrue( self.var_70814aa80e0d3d1 ) )
    {
        if ( isdefined( self ) && isrevivetrigger || isdefined( self.id ) && self.id == "rugby_jugg" )
        {
            player.weaponsdisabledwhilereviving = 1;
            
            if ( !level.allowreviveweapons )
            {
                player thread forceunsetdemeanor( 1 );
                player val::set( "useHold", "sprint", 0 );
                player val::set( "useHold", "fire", 0 );
                player val::set( "useHold", "ads", 0 );
                player val::set( "useHold", "offhand_weapons", 0 );
            }
            else
            {
                player val::group_set( "reviveShoot", 0 );
            }
        }
        
        if ( !istrue( self.allowsweapon ) )
        {
            player val::set( "useHold", "weapon", 0 );
        }
        
        if ( !istrue( self.var_cc367d287df0480b ) )
        {
            player val::set( "useHold", "ads", 0 );
        }
    }
    
    if ( !isdefined( player.usinggameobjects ) )
    {
        player.usinggameobjects = [];
    }
    
    objectnum = undefined;
    
    if ( isdefined( self.index ) )
    {
        objectnum = self.index;
    }
    else
    {
        objectnum = self.trigger getentitynumber();
    }
    
    player.usinggameobjects[ objectnum ] = self;
    
    if ( !isdefined( self.resetprogress ) || istrue( self.resetprogress ) )
    {
        self.curprogress = 0;
        
        if ( isdefined( self.clientprogress ) && isdefined( self.clientprogress[ player.clientid ] ) )
        {
            self.clientprogress[ player.clientid ] = 0;
        }
    }
    
    self.inuse = 1;
    self.userate = 0;
    result = useholdthinkloop( player, lastweapon );
    
    if ( isdefined( player ) )
    {
        player.usinggameobjects[ objectnum ] = undefined;
        player detachusemodels();
        player notify( "done_using" );
    }
    
    if ( isdefined( useweapon ) && isdefined( player ) )
    {
        if ( getgametype() == "cyber" && !isrevivetrigger && !istrue( result ) )
        {
            player setweaponammostock( useweapon, 0 );
            player setweaponammoclip( useweapon, 0 );
        }
        
        player scripts\mp\supers::unstowsuperweapon();
        
        if ( player isswitchingtoweaponwithmonitoring( useweapon ) )
        {
            player abortmonitoredweaponswitch( useweapon );
            player _switchtoweaponimmediate( lastweapon );
        }
        else
        {
            skipdrop = istrue( self.var_5d00f287c09eac5 ) && !istrue( result );
            
            if ( getbasegametype() == "sd" )
            {
                if ( !istrue( result ) )
                {
                    player setweaponammostock( useweapon, 1 );
                    player setweaponammoclip( useweapon, 1 );
                }
            }
            
            if ( player scripts\mp\utility\killstreak::isjuggernaut() )
            {
                var_acf2963740b6f292 = player scripts\mp\juggernaut::jugg_getminigunweapon();
                player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( var_acf2963740b6f292 );
                player _takeweapon( useweapon );
                player thread function_6503ca663eb11045();
            }
            else
            {
                player thread getridofweapon( useweapon, skipdrop );
            }
        }
    }
    
    if ( istrue( result ) )
    {
        player allowmovement( 1 );
        return true;
    }
    else if ( !istrue( result ) && isdefined( self ) )
    {
        if ( !isdefined( self.resetprogress ) || istrue( self.resetprogress ) )
        {
            self.curprogress = 0;
            
            if ( isdefined( self.clientprogress ) && isdefined( self.clientprogress[ player.clientid ] ) )
            {
                self.clientprogress[ player.clientid ] = 0;
            }
        }
        else
        {
            managecurprogress( player );
        }
    }
    
    if ( isdefined( player ) )
    {
        if ( !isdefined( useweapon ) && !var_d9842c97badaba31 )
        {
            if ( isdefined( self ) && isrevivetrigger || isdefined( self.id ) && self.id == "rugby_jugg" )
            {
                if ( istrue( player.weaponsdisabledwhilereviving ) )
                {
                    player.weaponsdisabledwhilereviving = undefined;
                    
                    if ( !level.allowreviveweapons )
                    {
                        player thread forceunsetdemeanor( 0 );
                    }
                    else
                    {
                        player val::group_reset( "reviveShoot" );
                    }
                }
            }
            
            player val::reset_all( "useHold" );
        }
        
        if ( !istrue( self.var_c750f84cf6cd01d8 ) )
        {
            player unlink();
        }
        
        player allowmovement( 1 );
    }
    
    if ( isdefined( self ) )
    {
        self.inuse = 0;
        
        if ( istrue( self.exclusiveuse ) && isdefined( self.trigger ) && ( self.trigger.classname == "trigger_use" || self.trigger.classname == "trigger_use_touch" ) )
        {
            self.trigger releaseclaimedtrigger();
        }
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xc786
// Size: 0x19
function function_6503ca663eb11045()
{
    self endon( "death_or_disconnect" );
    self waittill( "gameobject_endUse" );
    self notify( "bomb_allow_offhands" );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xc7a7
// Size: 0x6d
function forceunsetdemeanor( bool )
{
    self endon( "death" );
    self notify( "forceDemeanorSafe" );
    self endon( "forceDemeanorSafe" );
    
    if ( bool )
    {
        while ( self issprinting() )
        {
            wait 0.5;
        }
        
        self setdemeanorviewmodel( "safe", "iw8_ges_demeanor_safe" );
        return;
    }
    
    result = 0;
    
    while ( !result )
    {
        result = self setdemeanorviewmodel( "normal" );
        waitframe();
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xc81c
// Size: 0x23e
function managecurprogress( player )
{
    if ( !isdefined( self.prevprogress ) )
    {
        self.prevprogress = 0;
    }
    
    progress = self.curprogress - self.prevprogress;
    
    if ( progress <= 1000 )
    {
        self.curprogress = self.prevprogress;
    }
    
    usetimeleft = self.usetime - self.curprogress;
    
    if ( usetimeleft < 1000 )
    {
        if ( self.usetime <= 1000 )
        {
            self.curprogress = self.usetime;
        }
        else
        {
            self.curprogress = self.usetime - 1000;
        }
    }
    
    progress = 0;
    
    if ( self.curprogress > 0 )
    {
        if ( isdefined( self.teamprogress ) && isdefined( self.claimteam ) )
        {
            if ( self.teamprogress[ self.claimteam ] > self.usetime )
            {
                self.teamprogress[ self.claimteam ] = self.usetime;
            }
            
            progress = self.teamprogress[ self.claimteam ] / self.usetime;
        }
        else
        {
            if ( self.curprogress > self.usetime )
            {
                self.curprogress = self.usetime;
            }
            
            progress = self.curprogress / self.usetime;
            
            if ( self.usetime <= 1000 )
            {
                progress = min( progress + 0.05, 1 );
            }
            else
            {
                progress = min( progress + 0.01, 1 );
            }
        }
    }
    
    if ( isdefined( self.objidnum ) )
    {
        scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, player.team );
        scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, progress );
        
        if ( self.curprogress > 0 )
        {
            scripts\mp\objidpoolmanager::objective_show_team_progress( self.objidnum, player.team );
        }
        else
        {
            scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 0 );
        }
    }
    
    self.prevprogress = self.curprogress;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xca62
// Size: 0x2e
function detachusemodels()
{
    if ( isdefined( self.attachedusemodel ) )
    {
        self detach( self.attachedusemodel, "tag_inhand" );
        self.attachedusemodel = undefined;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 3
// Checksum 0x0, Offset: 0xca98
// Size: 0x68
function switchtouseweapon( useweapon, switchimmediate, var_26ca36763fa5b82 )
{
    scripts\mp\supers::allowsuperweaponstow();
    switchresult = domonitoredweaponswitch( useweapon, switchimmediate, var_26ca36763fa5b82 );
    
    if ( !istrue( switchresult ) )
    {
        self notify( "bomb_allow_offhands" );
        scripts\mp\supers::unstowsuperweapon();
        
        if ( isswitchingtoweaponwithmonitoring( useweapon ) )
        {
            abortmonitoredweaponswitch( useweapon );
            return;
        }
        
        _takeweapon( useweapon );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 4
// Checksum 0x0, Offset: 0xcb08
// Size: 0x2d8, Type: bool
function usetest( player, waitforweapon, timedout, maxwaittime )
{
    if ( isdefined( self.curprogress ) && isdefined( self.usetime ) && self.curprogress >= self.usetime )
    {
        return false;
    }
    
    if ( istrue( self.remoterevive ) )
    {
        return true;
    }
    
    if ( !isreallyalive( player ) )
    {
        return false;
    }
    
    if ( !player val::get( "usability" ) )
    {
        return false;
    }
    
    if ( !isdefined( self.skiptouching ) && isdefined( self.trigger ) && !player istouching( self.trigger ) )
    {
        return false;
    }
    
    if ( !level.allowreviveweapons && ( !player usebuttonpressed( 1 ) || istrue( player.var_aa03057bfe41a2f0 ) ) )
    {
        return false;
    }
    
    if ( player scripts\mp\utility\weapon::grenadeinpullback() && !istrue( self.id == "wm_buildable" ) && !istrue( self.id == "wm_IED" ) )
    {
        return false;
    }
    
    if ( !istrue( self.var_ac2702c39ae20d26 ) && player meleebuttonpressed() )
    {
        return false;
    }
    
    if ( player isinexecutionattack() )
    {
        return false;
    }
    
    if ( player isinexecutionvictim() )
    {
        return false;
    }
    
    distancelimit = undefined;
    
    if ( isdefined( self.trigger ) && isdefined( self.trigger.var_b9abe6bdf97e9a79 ) )
    {
        distancelimit = self.trigger.var_b9abe6bdf97e9a79;
    }
    else if ( isdefined( self.var_b9abe6bdf97e9a79 ) )
    {
        distancelimit = self.var_b9abe6bdf97e9a79;
    }
    
    if ( isdefined( distancelimit ) )
    {
        testorigin = self.origin;
        
        if ( isdefined( self.trigger ) )
        {
            testorigin = self.trigger.origin;
        }
        
        if ( isdefined( testorigin ) && distance2dsquared( testorigin, player.origin ) >= distancelimit )
        {
            return false;
        }
    }
    
    if ( !self.userate && !waitforweapon )
    {
        return false;
    }
    
    if ( waitforweapon && timedout > maxwaittime )
    {
        return false;
    }
    
    if ( istrue( self.checkuseconditioninthink ) && isdefined( self.usecondition ) && !self [[ self.usecondition ]]( player ) )
    {
        return false;
    }
    
    if ( isdefined( self.useweapon ) )
    {
        if ( player getcurrentweapon() != self.useweapon && !player isswitchingtoweaponwithmonitoring( self.useweapon ) && !player isswimming() )
        {
            return false;
        }
    }
    
    if ( isrevivetrigger() )
    {
        if ( !player islinked() && !player isonground() && !( istrue( self.var_dbc472744080c5d7 ) && player isswimming() ) )
        {
            return false;
        }
        
        if ( istrue( player.var_a23f35f8460d8857 ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xcde9
// Size: 0x441
function useholdthinkloop( player, lastweapon )
{
    level endon( "game_ended" );
    self endon( "disabled" );
    self endon( "deleted" );
    useweapon = self.useweapon;
    waitforweapon = 1;
    
    if ( isdefined( self.waitforweapononuse ) )
    {
        waitforweapon = self.waitforweapononuse;
    }
    
    if ( !istrue( waitforweapon ) )
    {
        self.userate = 1 * player.objectivescaler;
    }
    
    timedout = 0;
    maxwaittime = 1.5;
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    objid = undefined;
    var_51666fd2d9bee728 = isdefined( self.clientprogress );
    
    if ( var_51666fd2d9bee728 && !isdefined( self.clientprogress[ player.clientid ] ) )
    {
        self.clientprogress[ player.clientid ] = 0;
    }
    
    while ( usetest( player, waitforweapon, timedout, maxwaittime ) || istrue( player.var_82300c21f62a6edb ) )
    {
        if ( isdefined( self.objidnum ) )
        {
            scripts\mp\objidpoolmanager::objective_pin_player( self.objidnum, player );
        }
        
        timedout += updaterate;
        
        if ( !waitforweapon || !isdefined( useweapon ) || player getcurrentweapon() == useweapon )
        {
            if ( var_51666fd2d9bee728 )
            {
                self.clientprogress[ player.clientid ] += updateratems * self.userate;
            }
            else
            {
                self.curprogress += updateratems * self.userate;
            }
            
            self.userate = 1 * player.objectivescaler;
            waitforweapon = 0;
        }
        else
        {
            self.userate = 0;
        }
        
        player updateuiprogress( self, 1 );
        currentprogress = var_51666fd2d9bee728 ? self.clientprogress[ player.clientid ] : self.curprogress;
        
        if ( currentprogress >= self.usetime )
        {
            self.inuse = 0;
            
            if ( istrue( self.exclusiveuse ) && isdefined( self.trigger ) && ( self.trigger.classname == "trigger_use" || self.trigger.classname == "trigger_use_touch" ) )
            {
                player clientreleasetrigger( self.trigger );
            }
            
            var_d9842c97badaba31 = isdefined( self.id ) && ( self.id == "traversalassist" || self.id == "breach" || self.id == "care_package" || self.id == "wm_buildable" || self.id == "wm_IED" );
            
            if ( !isdefined( useweapon ) && !istrue( var_d9842c97badaba31 ) )
            {
                if ( isrevivetrigger() || isdefined( self.id ) && self.id == "rugby_jugg" )
                {
                    if ( istrue( player.weaponsdisabledwhilereviving ) )
                    {
                        player.weaponsdisabledwhilereviving = undefined;
                        
                        if ( !istrue( level.allowreviveweapons ) )
                        {
                            player thread forceunsetdemeanor( 0 );
                            player val::reset_all( "useHold" );
                        }
                        else
                        {
                            player val::group_reset( "reviveShoot" );
                        }
                    }
                }
                else
                {
                    player val::reset_all( "useHold" );
                }
            }
            
            if ( !istrue( self.var_c750f84cf6cd01d8 ) )
            {
                player unlink();
            }
            
            if ( isdefined( self.objidnum ) )
            {
                scripts\mp\objidpoolmanager::objective_unpin_player( self.objidnum, player );
            }
            
            player.var_82300c21f62a6edb = undefined;
            return isreallyalive( player );
        }
        
        wait updaterate;
        scripts\mp\hostmigration::waittillhostmigrationdone();
    }
    
    if ( isdefined( self.objidnum ) )
    {
        scripts\mp\objidpoolmanager::objective_unpin_player( self.objidnum, player );
    }
    
    player.var_82300c21f62a6edb = undefined;
    player updateuiprogress( self, 0 );
    return 0;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xd233
// Size: 0x259
function updatetrigger()
{
    if ( self.triggertype != "use" )
    {
        return;
    }
    
    if ( self.trigger.classname != "trigger_use" && self.trigger.classname != "trigger_use_touch" )
    {
        return;
    }
    
    if ( self.interactteam == "none" )
    {
        self.trigger.origin -= ( 0, 0, 10000 );
        
        if ( isdefined( self.trigger.classname ) && self.trigger.classname != "script_model" )
        {
            self.trigger setteamfortrigger( "none" );
        }
        
        return;
    }
    
    if ( self.interactteam == "any" )
    {
        self.trigger.origin = self.curorigin;
        self.trigger setteamfortrigger( "none" );
        return;
    }
    
    if ( self.interactteam == "friendly" )
    {
        self.trigger.origin = self.curorigin;
        
        if ( array_contains( level.teamnamelist, self.ownerteam ) )
        {
            self.trigger setteamfortrigger( self.ownerteam );
        }
        else
        {
            self.trigger.origin -= ( 0, 0, 50000 );
        }
        
        return;
    }
    
    if ( self.interactteam == "enemy" )
    {
        self.trigger.origin = self.curorigin;
        
        if ( self.ownerteam == "allies" )
        {
            self.trigger setteamfortrigger( "axis" );
            return;
        }
        
        if ( self.ownerteam == "axis" )
        {
            self.trigger setteamfortrigger( "allies" );
            return;
        }
        
        self.trigger setteamfortrigger( "none" );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xd494
// Size: 0x4b
function getmlgteamcolor( team )
{
    if ( team == "allies" )
    {
        return game[ "colors" ][ "friendly" ];
    }
    else if ( team == "axis" )
    {
        return game[ "colors" ][ "enemy" ];
    }
    
    return ( 1, 1, 1 );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 3
// Checksum 0x0, Offset: 0xd4e8
// Size: 0x150
function setobjpointteamcolor( objpoint, updateteam, relativeteam )
{
    if ( updateteam == "mlg_allies" )
    {
        objpoint setmlgdraw( 1, 0 );
        colortype = self.objiconscolor[ relativeteam ];
        
        if ( colortype == "friendly" )
        {
            objpoint.color = getmlgteamcolor( "allies" );
        }
        else if ( colortype == "enemy" )
        {
            objpoint.color = getmlgteamcolor( "axis" );
        }
        else
        {
            objpoint.color = game[ "colors" ][ colortype ];
        }
        
        return;
    }
    
    if ( updateteam == "mlg_axis" )
    {
        objpoint setmlgdraw( 1, 0 );
        colortype = self.objiconscolor[ relativeteam ];
        
        if ( colortype == "friendly" )
        {
            objpoint.color = getmlgteamcolor( "axis" );
        }
        else if ( colortype == "enemy" )
        {
            objpoint.color = getmlgteamcolor( "allies" );
        }
        else
        {
            objpoint.color = game[ "colors" ][ colortype ];
        }
        
        return;
    }
    
    objpoint.color = game[ "colors" ][ self.objiconscolor[ relativeteam ] ];
    objpoint setmlgdraw( 0, 1 );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xd640
// Size: 0x2f
function hideworldiconongameend()
{
    self notify( "hideWorldIconOnGameEnd" );
    self endon( "hideWorldIconOnGameEnd" );
    self endon( "death" );
    level waittill( "game_ended" );
    
    if ( isdefined( self ) )
    {
        self.alpha = 0;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xd677
// Size: 0x13
function updatetimer( seconds, showicon )
{
    
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 5
// Checksum 0x0, Offset: 0xd692
// Size: 0xe2
function setobjectivestatusallicons( friendlyicon, enemyicon, mlgicon, objid, ownerteam )
{
    if ( istrue( self.lockupdatingicons ) )
    {
        return;
    }
    
    if ( !isdefined( friendlyicon ) )
    {
        friendlyicon = enemyicon;
    }
    
    if ( !isdefined( enemyicon ) )
    {
        enemyicon = friendlyicon;
    }
    
    if ( !isdefined( self.iconname ) )
    {
        self.iconname = "";
    }
    
    if ( istrue( level.codcasterenabled ) )
    {
        if ( !isdefined( mlgicon ) )
        {
            self.compassicons[ "codcaster" ] = undefined;
        }
        else
        {
            self.compassicons[ "codcaster" ] = mlgicon + self.iconname;
        }
    }
    
    self.compassicons[ "friendly" ] = friendlyicon + self.iconname;
    self.compassicons[ "enemy" ] = enemyicon + self.iconname;
    updatecompassicons( objid, ownerteam );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 5
// Checksum 0x0, Offset: 0xd77c
// Size: 0xa8
function setobjectivestatusicons( friendlyicon, enemyicon, objid, ownerteam, skipupdate )
{
    if ( istrue( self.lockupdatingicons ) )
    {
        return;
    }
    
    if ( !isdefined( friendlyicon ) )
    {
        friendlyicon = enemyicon;
    }
    
    if ( !isdefined( enemyicon ) )
    {
        enemyicon = friendlyicon;
    }
    
    if ( !isdefined( self.iconname ) )
    {
        self.iconname = "";
    }
    
    self.compassicons[ "friendly" ] = friendlyicon + self.iconname;
    self.compassicons[ "enemy" ] = enemyicon + self.iconname;
    
    if ( !istrue( skipupdate ) )
    {
        updatecompassicons( objid, ownerteam );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 3
// Checksum 0x0, Offset: 0xd82c
// Size: 0x6e
function setmlgobjectivestatusicon( mlgicon, objid, ownerteam )
{
    if ( !istrue( level.codcasterenabled ) )
    {
        return;
    }
    
    if ( !isdefined( mlgicon ) )
    {
        return;
    }
    
    if ( !isdefined( self.iconname ) )
    {
        self.iconname = "";
    }
    
    self.compassicons[ "codcaster" ] = mlgicon + self.iconname;
    updatecompassicons( objid, ownerteam );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xd8a2
// Size: 0x2b
function resetmlgobjectivestatusicon( objid, ownerteam )
{
    self.compassicons[ "codcaster" ] = undefined;
    updatecompassicons( objid, ownerteam );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xd8d5
// Size: 0x75
function updatecompassicons( objid, ownerteam )
{
    visibleteam = self.visibleteam;
    
    if ( !isdefined( self.visibleteam ) )
    {
        visibleteam = "none";
    }
    
    updatecompassicon( visibleteam, objid, ownerteam );
    
    if ( isdefined( self.var_b8cc16dcaf5a0746 ) )
    {
        if ( !isdefined( objid ) )
        {
            objid = self.objidnum;
        }
        
        level scripts\mp\objidpoolmanager::function_c3c6bff089dfdd34( objid, self.var_b8cc16dcaf5a0746 );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xd952
// Size: 0x26
function function_4ac89e9b562bf080()
{
    teamnames = level.teamnamelist;
    teamnames = array_add( teamnames, "codcaster" );
    return teamnames;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 3
// Checksum 0x0, Offset: 0xd981
// Size: 0x7db
function updatecompassicon( relativeteam, objid, ownerteam )
{
    var_dca4604f39117a = relativeteam == "any";
    var_c0d426fb0da57cf2 = relativeteam == "none";
    var_aa4f261ba2f9905a = relativeteam == "codcaster";
    
    if ( var_dca4604f39117a || var_c0d426fb0da57cf2 )
    {
        updateteams = function_4ac89e9b562bf080();
    }
    else
    {
        updateteamsstruct = getupdateteams( relativeteam );
        updateteams = updateteamsstruct.teams;
    }
    
    var_1341915118cc82b = 0;
    
    for ( index = 0; index < updateteams.size ; index++ )
    {
        updateteam = updateteams[ index ];
        
        if ( var_dca4604f39117a || var_c0d426fb0da57cf2 )
        {
            var_5c5d470bd64763f8 = updateteam;
        }
        else
        {
            var_5c5d470bd64763f8 = updateteam.team;
        }
        
        if ( !var_c0d426fb0da57cf2 && !var_dca4604f39117a && !var_aa4f261ba2f9905a && !isgameplayteam( var_5c5d470bd64763f8 ) )
        {
            continue;
        }
        
        var_58498fc5d5879ba1 = !var_c0d426fb0da57cf2 && ( var_dca4604f39117a || updateteam.showtoteam );
        
        if ( !var_58498fc5d5879ba1 && shouldshowcompassduetoradar( var_5c5d470bd64763f8 ) )
        {
            var_58498fc5d5879ba1 = 1;
        }
        
        if ( !isdefined( objid ) )
        {
            objid = self.objidnum;
        }
        
        if ( objid != -1 )
        {
            if ( !istrue( self.visibilitymanuallycontrolled ) )
            {
                if ( !isdefined( self.compassicons[ "friendly" ] ) || !var_58498fc5d5879ba1 )
                {
                    scripts\mp\objidpoolmanager::objective_teammask_removefrommask( objid, var_5c5d470bd64763f8 );
                    continue;
                }
                else
                {
                    scripts\mp\objidpoolmanager::objective_teammask_addtomask( objid, var_5c5d470bd64763f8 );
                }
                
                if ( !isdefined( self.compassicons[ "enemy" ] ) || !var_58498fc5d5879ba1 )
                {
                    scripts\mp\objidpoolmanager::objective_teammask_removefrommask( objid, var_5c5d470bd64763f8 );
                    continue;
                }
                else
                {
                    scripts\mp\objidpoolmanager::objective_teammask_addtomask( objid, var_5c5d470bd64763f8 );
                }
            }
            
            if ( !var_1341915118cc82b )
            {
                icon = getwaypointshader( self.compassicons[ "friendly" ] );
                scripts\mp\objidpoolmanager::update_objective_icon( objid, icon );
                iconid = function_3672af010e23dfc8( self.compassicons[ "friendly" ] );
                
                if ( iconid )
                {
                    scripts\mp\objidpoolmanager::function_79a1a16de6b22b2d( objid, iconid );
                }
                
                objstatefriendly = getwaypointbackgroundcolor( self.compassicons[ "friendly" ] );
                objstatefriendly = ter_op( isdefined( objstatefriendly ), objstatefriendly, "neutral" );
                objstateenemy = getwaypointbackgroundcolor( self.compassicons[ "enemy" ] );
                objstateenemy = ter_op( isdefined( objstateenemy ), objstateenemy, "neutral" );
                iscontested = 0;
                objstate = getobjectivestate( objstatefriendly, objstateenemy );
                
                if ( objstate == "contest" )
                {
                    iscontested = 1;
                }
                
                if ( iscontested )
                {
                    scripts\mp\objidpoolmanager::objective_set_progress_team( objid, undefined );
                    scripts\mp\objidpoolmanager::update_objective_sethot( objid, 1 );
                }
                else
                {
                    scripts\mp\objidpoolmanager::update_objective_sethot( objid, 0 );
                }
                
                if ( getgametype() == "wm" )
                {
                    islocked = ter_op( istrue( self.locked ), 1, 0 );
                    
                    if ( isdefined( self.objectivekey ) && isdefined( level.objectives ) && isdefined( level.objectives[ self.objectivekey ] ) )
                    {
                        setomnvar( "ui_wm_locked_objective" + self.objectivekey, islocked );
                    }
                }
                
                if ( isdefined( ownerteam ) )
                {
                    self.ownerteam = ownerteam;
                }
                
                var_a041bea72ba46e04 = getwaypointstring( self.compassicons[ "friendly" ] );
                var_ba5c3a2b11fff3f5 = getwaypointstring( self.compassicons[ "enemy" ] );
                
                if ( objstate == "neutral" || !isdefined( self.ownerteam ) )
                {
                    if ( isdefined( self.claimteam ) && self.claimteam != "none" )
                    {
                        if ( isdefined( self.ownerteam ) && self.ownerteam != "neutral" )
                        {
                            scripts\mp\objidpoolmanager::update_objective_ownerteam( objid, self.claimteam );
                            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( objid, var_a041bea72ba46e04 );
                            scripts\mp\objidpoolmanager::update_objective_setenemylabel( objid, var_ba5c3a2b11fff3f5 );
                        }
                        else
                        {
                            scripts\mp\objidpoolmanager::update_objective_ownerteam( objid, undefined );
                            scripts\mp\objidpoolmanager::update_objective_setneutrallabel( objid, var_a041bea72ba46e04 );
                        }
                    }
                    else
                    {
                        scripts\mp\objidpoolmanager::update_objective_ownerteam( objid, undefined );
                        scripts\mp\objidpoolmanager::update_objective_setneutrallabel( objid, var_a041bea72ba46e04 );
                    }
                }
                else if ( objstate == "claimed" )
                {
                    if ( self.ownerteam != "neutral" )
                    {
                        scripts\mp\objidpoolmanager::update_objective_ownerteam( objid, self.ownerteam );
                    }
                    else
                    {
                        scripts\mp\objidpoolmanager::update_objective_ownerteam( objid, undefined );
                    }
                    
                    scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( objid, var_a041bea72ba46e04 );
                    scripts\mp\objidpoolmanager::update_objective_setenemylabel( objid, var_ba5c3a2b11fff3f5 );
                }
                else if ( objstate == "contest" )
                {
                    if ( self.cancontestclaim && self.stalemate != self.wasstalemate || self.cancontestclaim && istrue( self.majoritycapprogress ) && self.majoritycapprogress != self.wasmajoritycapprogress )
                    {
                        objective_setlabel( objid, var_a041bea72ba46e04 );
                    }
                    else
                    {
                        if ( !isgameplayteam( self.claimteam ) )
                        {
                            continue;
                        }
                        
                        scripts\mp\objidpoolmanager::update_objective_ownerteam( objid, self.claimteam );
                        scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( objid, var_a041bea72ba46e04 );
                        scripts\mp\objidpoolmanager::update_objective_setenemylabel( objid, var_ba5c3a2b11fff3f5 );
                    }
                }
                
                backgroundtype = getwaypointbackgroundtype( self.compassicons[ "friendly" ] );
                scripts\mp\objidpoolmanager::update_objective_setbackground( objid, backgroundtype );
                pulsestate = getwaypointobjpulse( self.compassicons[ "friendly" ] );
                scripts\mp\objidpoolmanager::objective_set_pulsate( objid, pulsestate );
                
                if ( hasdomflags() && getgametype() != "wm" && getbasegametype() != "escort" )
                {
                    if ( !istrue( self.stalemate ) && self.ownerteam != "neutral" )
                    {
                        if ( self.numtouching[ "axis" ] > 0 && self.numtouching[ "allies" ] > 0 )
                        {
                            self.captureblocked = 1;
                            scripts\mp\objidpoolmanager::update_objective_sethot( objid, 1 );
                        }
                        else
                        {
                            self.captureblocked = 0;
                            scripts\mp\objidpoolmanager::update_objective_sethot( objid, 0 );
                        }
                    }
                }
                
                if ( self.type == "carryObject" )
                {
                    if ( isreallyalive( self.carrier ) && !shouldpingobject( relativeteam ) )
                    {
                        scripts\mp\objidpoolmanager::update_objective_onentity( objid, self.carrier );
                        scripts\mp\objidpoolmanager::update_objective_setzoffset( objid, self.offset3d[ 2 ] );
                    }
                    else if ( isdefined( self.visuals ) && isdefined( self.visuals[ 0 ] ) && isdefined( self.visuals[ 0 ] getlinkedparent() ) )
                    {
                        scripts\mp\objidpoolmanager::update_objective_onentity( objid, self.visuals[ 0 ] );
                    }
                    else if ( isdefined( self.objectiveonvisuals ) && self.objectiveonvisuals )
                    {
                        if ( !shouldpingobject( relativeteam ) )
                        {
                            scripts\mp\objidpoolmanager::update_objective_onentity( objid, self.visuals[ 0 ] );
                            
                            if ( isdefined( self.objectiveonvisualsoffset3d ) )
                            {
                                scripts\mp\objidpoolmanager::update_objective_setzoffset( objid, self.objectiveonvisualsoffset3d[ 2 ] );
                            }
                        }
                        else if ( isdefined( self.objectiveonvisualsoffset3d ) )
                        {
                            scripts\mp\objidpoolmanager::update_objective_position( objid, self.curorigin + ( 0, 0, self.objectiveonvisualsoffset3d[ 2 ] ) );
                        }
                        else
                        {
                            scripts\mp\objidpoolmanager::update_objective_position( objid, self.curorigin );
                        }
                    }
                    else
                    {
                        scripts\mp\objidpoolmanager::update_objective_position( objid, self.curorigin );
                        scripts\mp\objidpoolmanager::update_objective_setzoffset( objid, self.offset3d[ 2 ] );
                    }
                }
                else if ( isdefined( self.objiconent ) )
                {
                    scripts\mp\objidpoolmanager::update_objective_onentity( objid, self.objiconent );
                }
                
                var_1341915118cc82b = 1;
            }
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xe164
// Size: 0x43, Type: bool
function shouldpingobject( relativeteam )
{
    if ( relativeteam == "friendly" && self.objidpingenemy )
    {
        return true;
    }
    else if ( relativeteam == "enemy" && self.objidpingfriendly )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xe1b0
// Size: 0x2e2
function getupdateteams( relativeteam )
{
    updateteams = spawnstruct();
    updateteams.teams = [];
    teamnamelist = function_4ac89e9b562bf080();
    
    foreach ( teamname in teamnamelist )
    {
        index = updateteams.teams.size;
        updateteams.teams[ index ] = spawnstruct();
        
        if ( relativeteam == "any" )
        {
            updateteams.teams[ index ].team = teamname;
            updateteams.teams[ index ].showtoteam = 1;
            continue;
        }
        
        if ( relativeteam == "none" )
        {
            updateteams.teams[ index ].team = teamname;
            updateteams.teams[ index ].showtoteam = 0;
            continue;
        }
        
        if ( relativeteam == "codcaster" )
        {
            if ( teamname == "codcaster" )
            {
                updateteams.teams[ index ].team = teamname;
                updateteams.teams[ index ].showtoteam = 1;
            }
            else
            {
                updateteams.teams[ index ].team = teamname;
                updateteams.teams[ index ].showtoteam = 0;
            }
            
            continue;
        }
        
        if ( isgameplayteam( teamname ) )
        {
            if ( relativeteam == "friendly" )
            {
                if ( isfriendlyteam( teamname ) )
                {
                    updateteams.teams[ index ].team = teamname;
                    updateteams.teams[ index ].showtoteam = 1;
                }
                else
                {
                    updateteams.teams[ index ].team = teamname;
                    updateteams.teams[ index ].showtoteam = 0;
                }
            }
            else if ( relativeteam == "enemy" )
            {
                if ( isfriendlyteam( teamname ) )
                {
                    updateteams.teams[ index ].team = teamname;
                    updateteams.teams[ index ].showtoteam = 0;
                }
                else
                {
                    updateteams.teams[ index ].team = teamname;
                    updateteams.teams[ index ].showtoteam = 1;
                }
            }
            
            continue;
        }
        
        updateteams.teams[ index ].team = teamname;
        updateteams.teams[ index ].showtoteam = 0;
    }
    
    return updateteams;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xe49b
// Size: 0x55
function getobjectivestate( objstatefriendly, objstateenemy )
{
    if ( objstatefriendly == "contest" || objstateenemy == "contest" )
    {
        return "contest";
    }
    
    if ( objstatefriendly == "neutral" || objstateenemy == "neutral" )
    {
        return "neutral";
    }
    
    return "claimed";
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xe4f8
// Size: 0x39
function shouldshowcompassduetoradar( team )
{
    if ( !isdefined( self.carrier ) )
    {
        return 0;
    }
    
    if ( self.carrier _hasperk( "specialty_gpsjammer" ) )
    {
        return 0;
    }
    
    return getteamradar( team );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xe53a
// Size: 0x27
function updatevisibilityaccordingtoradar()
{
    self endon( "death" );
    self endon( "carrier_cleared" );
    
    while ( true )
    {
        level waittill( "radar_status_change" );
        updatecompassicons();
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xe569
// Size: 0x37
function setownerteam( team )
{
    self.ownerteam = team;
    updatetrigger();
    updatecompassicons();
    
    if ( team != "neutral" )
    {
        self.prevownerteam = team;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xe5a8
// Size: 0xb
function getownerteam()
{
    return self.ownerteam;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xe5bc
// Size: 0x41
function setusetime( time, cacheprevioustime )
{
    if ( istrue( cacheprevioustime ) )
    {
        self.prevusetime = self.usetime / 1000;
    }
    
    self.usetime = int( time * 1000 );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xe605
// Size: 0xd
function pinobjiconontriggertouch()
{
    self.pinobj = 1;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xe61a
// Size: 0xc, Type: bool
function function_9a19ccf8dc6c3caf()
{
    return istrue( self.pinobj );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xe62f
// Size: 0x47, Type: bool
function function_dc06030ceb03363b()
{
    if ( scripts\cp_mp\utility\game_utility::function_42e2dcfd4571b89b() && isdefined( self.trigger ) && isdefined( self.trigger.objidnum ) )
    {
        return istrue( self.trigger.pinobj );
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xe67f
// Size: 0x15
function setwaitweaponchangeonuse( bool )
{
    self.waitforweapononuse = bool;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xe69c
// Size: 0x15
function setusetext( text )
{
    self.usetext = text;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xe6b9
// Size: 0x29
function setteamusetime( relativeteam, time )
{
    self.teamusetimes[ relativeteam ] = int( time * 1000 );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xe6ea
// Size: 0x20
function setteamusetext( relativeteam, text )
{
    self.teamusetexts[ relativeteam ] = text;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xe712
// Size: 0x1b
function setusehinttext( text )
{
    self.trigger sethintstring( text );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xe735
// Size: 0x15
function allowcarry( relativeteam )
{
    self.interactteam = relativeteam;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xe752
// Size: 0x1c
function allowuse( relativeteam )
{
    self.interactteam = relativeteam;
    updatetrigger();
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xe776
// Size: 0x75
function squadallowuse( team, squadindex )
{
    if ( !isdefined( self.interactsquads ) )
    {
        self.interactsquads = [];
    }
    
    if ( !isdefined( self.interactsquads[ team ] ) )
    {
        self.interactsquads[ team ] = [];
    }
    
    if ( !array_contains( self.interactsquads[ team ], squadindex ) )
    {
        self.interactsquads[ team ][ self.interactsquads[ team ].size ] = squadindex;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xe7f3
// Size: 0x79
function squaddenyuse( team, squadindex )
{
    if ( !isdefined( self.interactsquads ) )
    {
        self.interactsquads = [];
    }
    
    if ( !isdefined( self.interactsquads[ team ] ) )
    {
        self.interactsquads[ team ] = [];
    }
    
    if ( array_contains( self.interactsquads[ team ], squadindex ) )
    {
        self.interactsquads[ team ] = array_remove( self.interactsquads[ team ], squadindex );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 3
// Checksum 0x0, Offset: 0xe874
// Size: 0x32
function setvisibleteam( relativeteam, objid, skipupdate )
{
    self.visibleteam = relativeteam;
    
    if ( !istrue( skipupdate ) )
    {
        updatecompassicons( objid );
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xe8ae
// Size: 0x49
function setlocked( islocked, objid )
{
    self.locked = islocked;
    
    if ( istrue( self.locked ) )
    {
        setownerteam( "neutral" );
        return;
    }
    
    setownerteam( self.prevownerteam );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xe8ff
// Size: 0x184
function setmodelvisibility( visibility )
{
    if ( visibility )
    {
        for ( index = 0; index < self.visuals.size ; index++ )
        {
            self.visuals[ index ] show();
            
            if ( self.visuals[ index ].classname == "script_brushmodel" || self.visuals[ index ].classname == "script_model" )
            {
                foreach ( player in level.players )
                {
                    if ( player istouching( self.visuals[ index ] ) )
                    {
                        player _suicide();
                    }
                }
                
                self.visuals[ index ] thread makesolid();
            }
        }
        
        return;
    }
    
    for ( index = 0; index < self.visuals.size ; index++ )
    {
        self.visuals[ index ] hide();
        
        if ( self.visuals[ index ].classname == "script_brushmodel" || self.visuals[ index ].classname == "script_model" )
        {
            self.visuals[ index ] notify( "changing_solidness" );
            self.visuals[ index ] notsolid();
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xea8b
// Size: 0x7a
function function_c882c384f0e771a1( var_f28b9b572a5954b6 )
{
    if ( getgametype() == "wm" )
    {
        shouldshow = ter_op( istrue( var_f28b9b572a5954b6 ), 1, 0 );
        
        if ( isdefined( self.objectivekey ) && isdefined( level.objectives ) && isdefined( level.objectives[ self.objectivekey ] ) )
        {
            setomnvar( "ui_wm_show_objective_icon_on_waypoint" + self.objectivekey, shouldshow );
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xeb0d
// Size: 0x7a
function function_3e4a31be47aee8f3( skip )
{
    if ( getgametype() == "wm" )
    {
        shouldskip = ter_op( istrue( skip ), 1, 0 );
        
        if ( isdefined( self.objectivekey ) && isdefined( level.objectives ) && isdefined( level.objectives[ self.objectivekey ] ) )
        {
            setomnvar( "ui_wm_skip_objective_icon_update_on_distance" + self.objectivekey, shouldskip );
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xeb8f
// Size: 0x78
function makesolid()
{
    self endon( "death" );
    self notify( "changing_solidness" );
    self endon( "changing_solidness" );
    
    while ( true )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            if ( level.players[ i ] istouching( self ) )
            {
                break;
            }
        }
        
        if ( i == level.players.size )
        {
            self solid();
            break;
        }
        
        wait 0.05;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xec0f
// Size: 0x15
function setcarriervisible( relativeteam )
{
    self.carriervisible = relativeteam;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xec2c
// Size: 0x15
function setcanuse( relativeteam )
{
    self.useteam = relativeteam;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xec49
// Size: 0x2e
function getwaypointshader( shader )
{
    image = level.waypointshader[ shader ];
    
    if ( !isdefined( image ) )
    {
        return "icon_waypoint_dom_a";
    }
    
    return image;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xec80
// Size: 0x2a
function getwaypointbackgroundtype( shader )
{
    backgroundtype = level.waypointbgtype[ shader ];
    
    if ( !isdefined( backgroundtype ) )
    {
        return 0;
    }
    
    return backgroundtype;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xecb3
// Size: 0x2e
function getwaypointbackgroundcolor( shader )
{
    colortype = level.waypointcolors[ shader ];
    
    if ( !isdefined( colortype ) )
    {
        return "neutral";
    }
    
    return colortype;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xecea
// Size: 0x2e
function getwaypointstring( shader )
{
    stringref = level.waypointstring[ shader ];
    
    if ( !isdefined( stringref ) )
    {
        return "MP_INGAME_ONLY/MISSING_STRING";
    }
    
    return stringref;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xed21
// Size: 0x2a
function getwaypointobjpulse( shader )
{
    pulse = level.waypointpulses[ shader ];
    
    if ( !isdefined( pulse ) )
    {
        return 0;
    }
    
    return pulse;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xed54
// Size: 0x2a
function function_3672af010e23dfc8( name )
{
    iconid = level.var_ed9acfb4a79fb6be[ name ];
    
    if ( !isdefined( iconid ) )
    {
        return 0;
    }
    
    return iconid;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xed87
// Size: 0x20
function set3duseicon( relativeteam, shader )
{
    self.worlduseicons[ relativeteam ] = shader;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xedaf
// Size: 0x15
function setcarryicon( shader )
{
    self.carryicon = shader;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xedcc
// Size: 0x89
function disableobject()
{
    self notify( "disabled" );
    
    if ( self.type == "carryObject" )
    {
        if ( isdefined( self.carrier ) )
        {
            self.carrier takeobject( self );
        }
        
        for ( index = 0; index < self.visuals.size ; index++ )
        {
            self.visuals[ index ] hide();
        }
    }
    
    self.trigger scripts\engine\utility::trigger_off();
    setvisibleteam( "none" );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xee5d
// Size: 0x63
function enableobject()
{
    if ( self.type == "carryObject" )
    {
        for ( index = 0; index < self.visuals.size ; index++ )
        {
            self.visuals[ index ] show();
        }
    }
    
    self.trigger scripts\engine\utility::trigger_on();
    setvisibleteam( "any" );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xeec8
// Size: 0x28
function getrelativeteam( team )
{
    if ( team == self.ownerteam )
    {
        return "friendly";
    }
    
    return "enemy";
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xeef8
// Size: 0x64, Type: bool
function isfriendlyteam( team )
{
    if ( self.ownerteam == "any" )
    {
        return true;
    }
    
    if ( self.ownerteam == team )
    {
        return true;
    }
    
    if ( self.ownerteam == "neutral" && isdefined( self.prevownerteam ) && self.prevownerteam == team )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xef65
// Size: 0xf9
function caninteractwith( team, player )
{
    if ( isdefined( player ) && isdefined( self.interactsquads ) )
    {
        return ( isdefined( self.interactsquads[ player.team ] ) && array_contains( self.interactsquads[ player.team ], player.sessionsquadid ) );
    }
    
    switch ( self.interactteam )
    {
        case #"hash_db653a4972b3c13b":
            return 0;
        case #"hash_c4e456c1095f52d":
            return 1;
        case #"hash_ecada18a31eceade":
            if ( team == self.ownerteam )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        case #"hash_3e323a3a6f36e18b":
            if ( team != self.ownerteam )
            {
                return 1;
            }
            else
            {
                return 0;
            }
        default:
            assertex( 0, "<dev string:x175>" );
            return 0;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xf066
// Size: 0x88, Type: bool
function isteam( team )
{
    if ( team == "neutral" )
    {
        return true;
    }
    
    if ( team == "any" )
    {
        return true;
    }
    
    if ( team == "none" )
    {
        return true;
    }
    
    foreach ( teamname in level.teamnamelist )
    {
        if ( team == teamname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xf0f7
// Size: 0x40, Type: bool
function isrelativeteam( relativeteam )
{
    if ( relativeteam == "friendly" )
    {
        return true;
    }
    
    if ( relativeteam == "enemy" )
    {
        return true;
    }
    
    if ( relativeteam == "any" )
    {
        return true;
    }
    
    if ( relativeteam == "none" )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xf140
// Size: 0x36
function getlabel()
{
    if ( !isdefined( self.trigger.script_label ) )
    {
        return "";
    }
    
    return self.trigger.script_label;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xf17e
// Size: 0x20
function initializetagpathvariables()
{
    self.nearest_node = undefined;
    self.calculated_nearest_node = 0;
    self.on_path_grid = undefined;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xf1a6
// Size: 0x15
function mustmaintainclaim( enabled )
{
    self.mustmaintainclaim = enabled;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xf1c3
// Size: 0x15
function cancontestclaim( enabled )
{
    self.cancontestclaim = enabled;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xf1e0
// Size: 0x9a
function getleveltriggers()
{
    level.minetriggers = getentarray( "minefield", "targetname" );
    level.hurttriggers = getentarray( "trigger_hurt", "classname" );
    level.radtriggers = getentarray( "radiation", "targetname" );
    level.ballallowedtriggers = getentarray( "uplinkAllowedOOB", "targetname" );
    level.nozonetriggers = getentarray( "uplink_nozone", "targetname" );
    level.droptonavmeshtriggers = getentarray( "dropToNavMesh", "targetname" );
    thread scripts\mp\arbitrary_up::initarbitraryuptriggers();
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xf282
// Size: 0x75
function isbombmode()
{
    switch ( getbasegametype() )
    {
        case #"hash_1aac086c17fe5ccb":
        case #"hash_214e6c6c1b43ae4a":
        case #"hash_9a6f07d0214a87db":
        case #"hash_eb5e5f470e0c1dc2":
        case #"hash_fa0ed2f6bd4f4395":
        case #"hash_fa50b0f6bd82e972":
        case #"hash_fa50baf6bd82f930":
            return 1;
        default:
            return 0;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xf2ff
// Size: 0x45
function isflagcarrymode()
{
    switch ( getgametype() )
    {
        case #"hash_1e4846dca3ccf38":
        case #"hash_1a5d186c17c00d3c":
        case #"hash_3a17de6e294210d2":
            return 1;
        default:
            return 0;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xf34c
// Size: 0x10f, Type: bool
function touchingdroptonavmeshtrigger( droppoint )
{
    if ( level.droptonavmeshtriggers.size > 0 )
    {
        if ( isbombmode() || getgametype() == "ctf" || getgametype() == "bigctf" || getgametype() == "tdef" )
        {
            self.visuals[ 0 ].origin = droppoint;
        }
        
        foreach ( trigger in level.droptonavmeshtriggers )
        {
            foreach ( visual in self.visuals )
            {
                if ( visual istouching( trigger ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xf464
// Size: 0x6b, Type: bool
function touchingarbitraryuptrigger()
{
    if ( level.arbitraryuptriggers.size > 0 )
    {
        foreach ( trigger in level.arbitraryuptriggers )
        {
            if ( self istouching( trigger ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xf4d8
// Size: 0x68
function resetcaptureprogress()
{
    if ( isdefined( self.teamprogress ) )
    {
        foreach ( team, progress in self.teamprogress )
        {
            self.teamprogress[ team ] = 0;
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xf548
// Size: 0x73
function getcaptureprogress()
{
    if ( isdefined( self.teamprogress ) && isdefined( self.claimteam ) )
    {
        if ( self.claimteam != "none" )
        {
            return ( self.teamprogress[ self.claimteam ] / self.usetime );
        }
        else
        {
            return ( self.teamprogress[ self.lastclaimteam ] / self.usetime );
        }
    }
    
    return 0;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 7
// Checksum 0x0, Offset: 0xf5c4
// Size: 0x18b
function requestid( minimap, world, reservedid, showoncompass, dointro, iconsize, skipobjid )
{
    if ( istrue( skipobjid ) )
    {
        self.objidnum = -1;
        return;
    }
    
    if ( isdefined( reservedid ) )
    {
        self.objidnum = scripts\mp\objidpoolmanager::requestreservedid( reservedid );
    }
    else
    {
        self.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
    }
    
    if ( self.objidnum != -1 )
    {
        objectivestate = "done";
        
        if ( minimap && world )
        {
            objectivestate = "current";
        }
        else if ( minimap )
        {
            objectivestate = "active";
        }
        else if ( world )
        {
            objectivestate = "invisible";
        }
        
        scripts\mp\objidpoolmanager::objective_add_objective( self.objidnum, objectivestate, self.curorigin + self.offset3d, undefined, iconsize );
        
        if ( getdvarint( @"hash_5fb9811d17b52a04", 0 ) == 1 )
        {
            if ( isdefined( showoncompass ) && showoncompass == 0 )
            {
                objective_setshowoncompass( self.objidnum, 0 );
                self.showoncompass = 0;
            }
            else
            {
                objective_setshowoncompass( self.objidnum, 1 );
            }
        }
        
        if ( isdefined( dointro ) )
        {
            scripts\mp\objidpoolmanager::objective_set_play_intro( self.objidnum, dointro );
            scripts\mp\objidpoolmanager::objective_set_play_outro( self.objidnum, dointro );
        }
        
        self.showworldicon = 0;
        scripts\mp\objidpoolmanager::objective_playermask_showtoall( self.objidnum );
        
        if ( world )
        {
            self.showworldicon = 1;
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xf757
// Size: 0x47
function releaseid( var_321e7a51d3237066, var_301ec764dd09b364 )
{
    if ( istrue( var_321e7a51d3237066 ) )
    {
        scripts\mp\objidpoolmanager::returnreservedobjectiveid( self.objidnum, var_301ec764dd09b364 );
    }
    else
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( self.objidnum );
    }
    
    self.objidnum = -1;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0xf7a6
// Size: 0x24
function getcapturebehavior()
{
    if ( !isdefined( self.capturebehavior ) )
    {
        setcapturebehavior( "normal" );
    }
    
    return self.capturebehavior;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0xf7d3
// Size: 0x15
function setcapturebehavior( type )
{
    self.capturebehavior = type;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0xf7f0
// Size: 0x851
function applycaptureprogress( team, delta )
{
    enemyteams = [];
    
    if ( !istrue( level.var_d914655fe46b8e34 ) )
    {
        enemyteams = getenemyteams( team );
    }
    
    switch ( getcapturebehavior() )
    {
        case #"hash_aba5a17ce738e820":
            self.teamprogress[ team ] += delta;
            self.curprogress = self.teamprogress[ team ];
            break;
        case #"hash_9236a87bf25f2cf2":
            if ( !isdefined( self.ownerteam ) || self.ownerteam == team )
            {
                return;
            }
            
            break;
        case #"hash_cac451c4df417b3a":
            if ( istrue( level.var_d914655fe46b8e34 ) )
            {
                enemyteams = getenemyteams( team );
            }
            
            foreach ( entry in enemyteams )
            {
                otherprogress = self.teamprogress[ entry ];
                
                if ( otherprogress > 0 )
                {
                    if ( otherprogress < delta )
                    {
                        self.teamprogress[ entry ] = 0;
                        delta -= otherprogress;
                        continue;
                    }
                    
                    self.teamprogress[ entry ] -= delta;
                    delta = 0;
                    self.curprogress = self.teamprogress[ entry ];
                    scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 1 );
                    scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, self.curprogress / self.usetime );
                }
            }
            
            if ( delta > 0 )
            {
                self.teamprogress[ team ] += delta;
                self.curprogress = self.teamprogress[ team ];
            }
            
            break;
        case #"hash_960e9b6651d8fa0f":
            if ( !isdefined( self.associatedteams ) || !array_contains( self.associatedteams, team ) )
            {
                return;
            }
            
            if ( istrue( level.var_d914655fe46b8e34 ) )
            {
                enemyteams = getenemyteams( team );
            }
            
            foreach ( entry in enemyteams )
            {
                otherprogress = self.teamprogress[ entry ];
                
                if ( otherprogress > 0 )
                {
                    if ( otherprogress < delta )
                    {
                        self.teamprogress[ entry ] = 0;
                        delta -= otherprogress;
                        continue;
                    }
                    
                    self.teamprogress[ entry ] -= delta;
                    delta = 0;
                    self.curprogress = self.teamprogress[ entry ];
                    scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 1 );
                    scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, self.curprogress / self.usetime );
                }
            }
            
            if ( delta > 0 )
            {
                self.teamprogress[ team ] += delta;
                self.curprogress = self.teamprogress[ team ];
            }
            
            break;
        case #"hash_f461a0075f6ed30f":
            if ( team != self.team )
            {
                return;
            }
            
            if ( team == self.team )
            {
                if ( istrue( level.var_d914655fe46b8e34 ) )
                {
                    enemyteams = getenemyteams( team );
                }
                
                foreach ( enemyteam in enemyteams )
                {
                    if ( self.numtouching[ enemyteam ] > 0 )
                    {
                        return;
                    }
                }
            }
            
            self.teamprogress[ team ] += delta;
            self.curprogress = self.teamprogress[ team ];
            break;
        case #"hash_d195b93b682ce6f1":
            self.cancontestclaim = 0;
            var_8ab430c83ac9f21c = 0;
            
            foreach ( touchteam in self.touchlist )
            {
                if ( touchteam.size == 0 )
                {
                    continue;
                }
                
                players_touching = getarraykeys( touchteam );
                var_8ab430c83ac9f21c += players_touching.size;
            }
            
            self.curprogress += delta * var_8ab430c83ac9f21c;
            self.teamprogress[ team ] = self.curprogress;
            self.capblocked = undefined;
            break;
        default:
            progress = self.teamprogress[ team ];
            progress += delta;
            blockcap = 0;
            numtouching = getnumtouchingforteam( team );
            numother = getnumtouchingexceptteam( team );
            
            if ( numtouching && numother && numtouching != numother && !istrue( self.blockcapdisabled ) )
            {
                blockcap = 1;
            }
            
            if ( istrue( self.majoritycapprogress ) && progress >= self.usetime * 0.95 && istrue( blockcap ) )
            {
                if ( self.ownerteam == "neutral" )
                {
                    foreach ( team in level.teamnamelist )
                    {
                        if ( self.touchlist[ team ].size )
                        {
                            touchlist = self.touchlist[ team ];
                            players_touching = getarraykeys( touchlist );
                            
                            for ( index = 0; index < players_touching.size ; index++ )
                            {
                                player = touchlist[ players_touching[ index ] ].player;
                                
                                if ( !isdefined( player ) || !isalive( player ) )
                                {
                                    continue;
                                }
                                
                                if ( team == self.claimteam )
                                {
                                    player scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 4 );
                                    continue;
                                }
                                
                                player scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 4 );
                            }
                        }
                    }
                    
                    self.capblocked = 1;
                    scripts\mp\objidpoolmanager::update_objective_sethot( self.objidnum, 1 );
                    scripts\mp\objidpoolmanager::update_objective_setneutrallabel( self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS" );
                }
                else
                {
                    foreach ( team in level.teamnamelist )
                    {
                        if ( self.touchlist[ team ].size )
                        {
                            touchlist = self.touchlist[ team ];
                            players_touching = getarraykeys( touchlist );
                            
                            for ( index = 0; index < players_touching.size ; index++ )
                            {
                                player = touchlist[ players_touching[ index ] ].player;
                                
                                if ( !isdefined( player ) || !isalive( player ) )
                                {
                                    continue;
                                }
                                
                                if ( team == self.ownerteam )
                                {
                                    player scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 4 );
                                    continue;
                                }
                                
                                player scripts\mp\objidpoolmanager::function_160f522b63c32d76( 2, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 4 );
                            }
                        }
                    }
                    
                    self.capblocked = 1;
                    scripts\mp\objidpoolmanager::update_objective_sethot( self.objidnum, 1 );
                    scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS" );
                    scripts\mp\objidpoolmanager::update_objective_setenemylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS" );
                }
            }
            else
            {
                if ( self.ownerteam != "neutral" )
                {
                    if ( self.ownerteam != team )
                    {
                        scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( self.objidnum, "MP_INGAME_ONLY/OBJ_LOSING_CAPS" );
                    }
                }
                
                self.teamprogress[ team ] += delta;
                self.curprogress = self.teamprogress[ team ];
                self.capblocked = undefined;
            }
            
            break;
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 11
// Checksum 0x0, Offset: 0x10049
// Size: 0x16f
function createhintobject( hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov )
{
    hintobj = spawn( "script_model", hintpos );
    hintobj makeusable();
    
    if ( isdefined( hinttype ) )
    {
        hintobj setcursorhint( hinttype );
    }
    else
    {
        hintobj setcursorhint( "HINT_NOICON" );
    }
    
    if ( isdefined( hinticon ) )
    {
        hintobj sethinticon( hinticon );
    }
    
    if ( isdefined( hintstring ) )
    {
        hintobj sethintstring( hintstring );
    }
    
    if ( isdefined( priority ) )
    {
        hintobj setusepriority( priority );
    }
    else
    {
        hintobj setusepriority( 0 );
    }
    
    if ( isdefined( duration ) )
    {
        hintobj setuseholdduration( duration );
    }
    else
    {
        hintobj setuseholdduration( "duration_short" );
    }
    
    if ( isdefined( onobstruction ) )
    {
        hintobj sethintonobstruction( onobstruction );
    }
    else
    {
        hintobj sethintonobstruction( "hide" );
    }
    
    if ( isdefined( hintdist ) )
    {
        hintobj sethintdisplayrange( hintdist );
    }
    else
    {
        hintobj sethintdisplayrange( 200 );
    }
    
    if ( isdefined( hintfov ) )
    {
        hintobj sethintdisplayfov( hintfov );
    }
    else
    {
        hintobj sethintdisplayfov( 160 );
    }
    
    if ( isdefined( usedist ) )
    {
        hintobj setuserange( usedist );
    }
    else
    {
        hintobj setuserange( 50 );
    }
    
    if ( isdefined( usefov ) )
    {
        hintobj setusefov( usefov );
    }
    else
    {
        hintobj setusefov( 120 );
    }
    
    return hintobj;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 11
// Checksum 0x0, Offset: 0x101c1
// Size: 0x16f
function sethintobject( hinttag, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov )
{
    if ( scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924() )
    {
        hintstring = undefined;
    }
    
    self makeusable();
    
    if ( isdefined( hinttag ) )
    {
        self sethinttag( hinttag );
    }
    
    if ( isdefined( hinttype ) )
    {
        self setcursorhint( hinttype );
    }
    else
    {
        self setcursorhint( "HINT_NOICON" );
    }
    
    if ( isdefined( hinticon ) )
    {
        self sethinticon( hinticon );
    }
    
    if ( isdefined( hintstring ) )
    {
        self sethintstring( hintstring );
    }
    
    if ( isdefined( priority ) )
    {
        self setusepriority( priority );
    }
    else
    {
        self setusepriority( 0 );
    }
    
    if ( isdefined( duration ) )
    {
        self setuseholdduration( duration );
    }
    else
    {
        self setuseholdduration( "duration_short" );
    }
    
    if ( isdefined( onobstruction ) )
    {
        self sethintonobstruction( onobstruction );
    }
    else
    {
        self sethintonobstruction( "hide" );
    }
    
    if ( isdefined( hintdist ) )
    {
        self sethintdisplayrange( hintdist );
    }
    else
    {
        self sethintdisplayrange( 200 );
    }
    
    if ( isdefined( hintfov ) )
    {
        self sethintdisplayfov( hintfov );
    }
    else
    {
        self sethintdisplayfov( 160 );
    }
    
    if ( isdefined( usedist ) )
    {
        self setuserange( usedist );
    }
    else
    {
        self setuserange( 50 );
    }
    
    if ( isdefined( usefov ) )
    {
        self setusefov( usefov );
        return;
    }
    
    self setusefov( 120 );
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 7
// Checksum 0x0, Offset: 0x10338
// Size: 0xef
function createobjidobject( position, ownerteam, offset, reservedobjid, visibleteam, showoncompass, iconsize )
{
    object = spawnstruct();
    object.type = "useObject";
    object.curorigin = position;
    object.ownerteam = ownerteam;
    
    if ( !isdefined( offset ) )
    {
        offset = ( 0, 0, 0 );
    }
    
    object.offset3d = offset;
    object requestid( 1, 1, reservedobjid, showoncompass, undefined, iconsize );
    object.compassicons = [];
    object.interactteam = "none";
    
    if ( isdefined( visibleteam ) )
    {
        object.visibleteam = visibleteam;
    }
    else
    {
        object.visibleteam = "none";
    }
    
    return object;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x10430
// Size: 0x26, Type: bool
function isrevivetrigger()
{
    if ( isdefined( self.id ) && self.id == "laststand_reviver" )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x1045f
// Size: 0x26, Type: bool
function function_89ae7f031dd8bc23()
{
    if ( isdefined( self.id ) && self.id == "plea_for_help_looting" )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x1048e
// Size: 0x26, Type: bool
function function_ab8d64fe065bf6f7()
{
    if ( isdefined( self.id ) && self.id == "laststand_interrogator" )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x104bd
// Size: 0x39, Type: bool
function function_693c0c5a3d8e214e()
{
    if ( isdefined( self.id ) && ( self.id == "elite_arrow_arm" || self.id == "elite_arrow_fuse" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x104ff
// Size: 0x65, Type: bool
function function_21f4c6f630b17fc4( entity )
{
    if ( isagent( entity ) && isdefined( entity.subclass ) )
    {
        switch ( entity.subclass )
        {
            case #"hash_849c32fe9df2b823":
                return true;
            default:
                return false;
        }
    }
    else if ( entity function_781844c0c05b5ac7() )
    {
        return true;
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x1056d
// Size: 0x27
function function_781844c0c05b5ac7()
{
    if ( issharedfuncdefined( "super_capture_bot", "captureBot_isGrenadeEntity" ) )
    {
        return callsharedfunc( "super_capture_bot", "captureBot_isGrenadeEntity" );
    }
    
    return 0;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 4
// Checksum 0x0, Offset: 0x1059d
// Size: 0xbf
function function_3f702f8fed26558a( numclaimants, numother, var_773eb33d831d5bb8, var_f3158d80c9ee245c )
{
    if ( numclaimants > numother && var_773eb33d831d5bb8 > var_f3158d80c9ee245c )
    {
        return ( numclaimants - numother + ( var_773eb33d831d5bb8 - var_f3158d80c9ee245c ) * self.var_f950eaa859b429c0 );
    }
    else if ( numclaimants > numother && var_773eb33d831d5bb8 < var_f3158d80c9ee245c )
    {
        return ( numclaimants - numother + var_773eb33d831d5bb8 - var_f3158d80c9ee245c );
    }
    else if ( numclaimants < numother && var_773eb33d831d5bb8 > var_f3158d80c9ee245c )
    {
        return ( ( numclaimants - numother + var_773eb33d831d5bb8 - var_f3158d80c9ee245c ) * self.var_f950eaa859b429c0 );
    }
    
    if ( numclaimants == numother && var_773eb33d831d5bb8 > var_f3158d80c9ee245c )
    {
        return ( ( var_773eb33d831d5bb8 - var_f3158d80c9ee245c ) * self.var_f950eaa859b429c0 );
    }
    
    if ( numclaimants > numother && var_773eb33d831d5bb8 == var_f3158d80c9ee245c )
    {
        return ( numclaimants - numother );
    }
    
    if ( numclaimants < numother && var_773eb33d831d5bb8 < var_f3158d80c9ee245c )
    {
        return 0;
    }
    
    return 0;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x10664
// Size: 0xb0
function function_d36dcacac1708708( timer )
{
    level endon( "game_ended" );
    updaterate = level.framedurationseconds;
    updateratems = updaterate * 1000;
    lockendtime = timer * 1000;
    subtime = lockendtime - updateratems;
    endtime = gettime() + lockendtime;
    
    while ( gettime() < endtime )
    {
        var_6403fb28fbb44896 = subtime / lockendtime;
        scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 1, 1 );
        scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, var_6403fb28fbb44896 );
        subtime = max( subtime - updateratems, 1 );
        waitframe();
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0x1071c
// Size: 0x314, Type: bool
function function_babd6a87808a6651( var_d665271789f9526d, allowedintrigger )
{
    if ( !isdefined( var_d665271789f9526d ) )
    {
        return true;
    }
    
    if ( getdvarint( @"hash_74e15cd785909df1", 1 ) == 1 )
    {
        ignoreents = [];
        ignoreents[ ignoreents.size ] = var_d665271789f9526d;
        contents = create_contents( 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1 );
        trace = ray_trace( var_d665271789f9526d.origin + ( 0, 0, 20 ), var_d665271789f9526d.origin - ( 0, 0, 20 ), ignoreents, contents, 1 );
        
        if ( ispointinwater( trace[ "position" ] ) && getgametype() != "bigctf" )
        {
            return true;
        }
        
        if ( isdefined( trace[ "surfaceflags" ] ) )
        {
            surfacetype = scripts\engine\trace::convert_surface_flag( trace );
            
            switch ( trace[ "surfacetype" ] )
            {
                case #"hash_386826e81c2469e":
                case #"hash_7035b789141ab570":
                case #"hash_8a8bd0144f89a1a2":
                case #"hash_94a21aede95bbed1":
                case #"hash_cccdf76df9364805":
                    return true;
            }
        }
        
        if ( isdefined( level.extractzones ) )
        {
            foreach ( zone in level.extractzones )
            {
                if ( !isdefined( zone.trigger ) )
                {
                    continue;
                }
                
                if ( var_d665271789f9526d istouching( zone.trigger ) )
                {
                    return true;
                }
            }
        }
    }
    
    for ( index = 0; index < level.radtriggers.size ; index++ )
    {
        if ( var_d665271789f9526d istouching( level.radtriggers[ index ] ) )
        {
            return true;
        }
    }
    
    for ( index = 0; index < level.minetriggers.size ; index++ )
    {
        if ( var_d665271789f9526d istouching( level.minetriggers[ index ] ) )
        {
            return true;
        }
    }
    
    for ( index = 0; index < level.hurttriggers.size ; index++ )
    {
        if ( var_d665271789f9526d istouching( level.hurttriggers[ index ] ) )
        {
            return true;
        }
    }
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( trigger in level.outofboundstriggers )
        {
            if ( isdefined( trigger.script_noteworthy ) )
            {
                if ( trigger.script_noteworthy == "onlyVehOOB" )
                {
                    break;
                }
            }
            
            if ( istrue( allowedintrigger ) )
            {
                break;
            }
            
            if ( var_d665271789f9526d istouching( trigger ) )
            {
                return true;
            }
            
            if ( ispointinvolume( var_d665271789f9526d.origin + ( 0, 0, 12 ), trigger ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0x10a39
// Size: 0x2d8, Type: bool
function function_c3c18fcce2d382d( point, allowedintrigger )
{
    if ( !isdefined( point ) )
    {
        return true;
    }
    
    if ( getdvarint( @"hash_74e15cd785909df1", 1 ) == 1 )
    {
        contents = create_contents( 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1 );
        trace = ray_trace( point + ( 0, 0, 20 ), point - ( 0, 0, 20 ), undefined, contents, 1 );
        
        if ( ispointinwater( trace[ "position" ] ) && getgametype() != "bigctf" )
        {
            return true;
        }
        
        if ( isdefined( trace[ "surfaceflags" ] ) )
        {
            surfacetype = scripts\engine\trace::convert_surface_flag( trace );
            
            switch ( trace[ "surfacetype" ] )
            {
                case #"hash_386826e81c2469e":
                case #"hash_7035b789141ab570":
                case #"hash_8a8bd0144f89a1a2":
                case #"hash_94a21aede95bbed1":
                case #"hash_cccdf76df9364805":
                    return true;
            }
        }
        
        if ( isdefined( level.extractzones ) )
        {
            foreach ( zone in level.extractzones )
            {
                if ( !isdefined( zone.trigger ) )
                {
                    continue;
                }
                
                if ( !ispointinvolume( point, zone.trigger ) )
                {
                    continue;
                }
                
                return true;
            }
        }
    }
    
    for ( index = 0; index < level.radtriggers.size ; index++ )
    {
        if ( !ispointinvolume( point, level.radtriggers[ index ] ) )
        {
            continue;
        }
        
        return true;
    }
    
    for ( index = 0; index < level.minetriggers.size ; index++ )
    {
        if ( !ispointinvolume( point, level.minetriggers[ index ] ) )
        {
            continue;
        }
        
        return true;
    }
    
    for ( index = 0; index < level.hurttriggers.size ; index++ )
    {
        if ( !ispointinvolume( point, level.hurttriggers[ index ] ) )
        {
            continue;
        }
        
        return true;
    }
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( trigger in level.outofboundstriggers )
        {
            if ( istrue( allowedintrigger ) )
            {
                break;
            }
            
            if ( isdefined( trigger.script_noteworthy ) )
            {
                if ( trigger.script_noteworthy == "onlyVehOOB" )
                {
                    break;
                }
            }
            
            if ( !ispointinvolume( point, trigger ) )
            {
                continue;
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 0
// Checksum 0x0, Offset: 0x10d1a
// Size: 0x30, Type: bool
function function_29c0cf699c075f78()
{
    if ( getdvarint( @"hash_ab99c7252936d7ed", 0 ) )
    {
        return true;
    }
    
    gt = getgametype();
    return gt == "ctf";
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 2
// Checksum 0x0, Offset: 0x10d53
// Size: 0x90
function function_f1e265068d2e3fc5( player, claimteam )
{
    if ( claimteam == "none" )
    {
        return;
    }
    
    if ( level.gametype == "hc_dom" )
    {
        return;
    }
    
    if ( gettime() - player.var_6fbd39a3be3e9cb4 >= 1000 )
    {
        if ( scripts\engine\utility::issharedfuncdefined( "damage", "updateDamageFeedback" ) )
        {
            player [[ scripts\engine\utility::getsharedfunc( "damage", "updateDamageFeedback" ) ]]( "capturebotcapture", undefined, undefined, "capturebotcapture", undefined, 1 );
            player.var_6fbd39a3be3e9cb4 = gettime();
        }
    }
}

// Namespace gameobjects / scripts\mp\gameobjects
// Params 1
// Checksum 0x0, Offset: 0x10deb
// Size: 0x5f
function function_15a05ddc354746a2( player )
{
    if ( !isplayer( player ) )
    {
        if ( isdefined( player.owner ) )
        {
            if ( function_21f4c6f630b17fc4( player ) && isplayer( player.owner ) )
            {
                player = player.owner;
                return player;
            }
            else
            {
                return player;
            }
        }
        else
        {
            return player;
        }
        
        return;
    }
    
    return player;
}

