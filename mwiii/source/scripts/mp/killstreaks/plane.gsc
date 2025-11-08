#using scripts\common\utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;

#namespace plane;

// Namespace plane / scripts\mp\killstreaks\plane
// Params 0
// Checksum 0x0, Offset: 0x24e
// Size: 0x8f
function init()
{
    if ( !isdefined( level.planes ) )
    {
        level.planes = [];
    }
    
    if ( !isdefined( level.planeconfigs ) )
    {
        level.planeconfigs = [];
    }
    
    level.fighter_deathfx = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
    level.fx_airstrike_afterburner = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
    level.fx_airstrike_contrail = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
    level.fx_airstrike_wingtip_light_green = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
    level.fx_airstrike_wingtip_light_red = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 8
// Checksum 0x0, Offset: 0x2e5
// Size: 0x11d
function getflightpath( coord, directionvector, planehalfdistance, absoluteheight, planeflyheight, planeflyspeed, attackdistance, streakname )
{
    startpoint = coord + directionvector * -1 * planehalfdistance;
    endpoint = coord + directionvector * planehalfdistance;
    
    if ( absoluteheight )
    {
        startpoint *= ( 1, 1, 0 );
        endpoint *= ( 1, 1, 0 );
    }
    
    startpoint += ( 0, 0, planeflyheight );
    endpoint += ( 0, 0, planeflyheight );
    d = length( startpoint - endpoint );
    flytime = d / planeflyspeed;
    d = abs( 0.5 * d + attackdistance );
    attacktime = d / planeflyspeed;
    assert( flytime > attacktime );
    flightpath[ "startPoint" ] = startpoint;
    flightpath[ "endPoint" ] = endpoint;
    flightpath[ "attackTime" ] = attacktime;
    flightpath[ "flyTime" ] = flytime;
    return flightpath;
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 9
// Checksum 0x0, Offset: 0x40b
// Size: 0xb4
function doflyby( lifeid, owner, requireddeathcount, startpoint, endpoint, attacktime, flytime, directionvector, streakname )
{
    plane = planespawn( lifeid, owner, startpoint, directionvector, streakname );
    plane endon( "death" );
    endpathrandomness = 150;
    pathend = endpoint + ( ( randomfloat( 2 ) - 1 ) * endpathrandomness, ( randomfloat( 2 ) - 1 ) * endpathrandomness, 0 );
    plane planemove( pathend, flytime, attacktime, streakname );
    plane planecleanup();
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 5
// Checksum 0x0, Offset: 0x4c7
// Size: 0x18c
function planespawn( lifeid, owner, startpoint, directionvector, streakname )
{
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    startpathrandomness = 100;
    pathstart = startpoint + ( ( randomfloat( 2 ) - 1 ) * startpathrandomness, ( randomfloat( 2 ) - 1 ) * startpathrandomness, 0 );
    configdata = level.planeconfigs[ streakname ];
    plane = undefined;
    plane = spawn( "script_model", pathstart );
    plane.team = owner.team;
    plane.origin = pathstart;
    plane.angles = vectortoangles( directionvector );
    plane.lifeid = lifeid;
    plane.streakname = streakname;
    plane.owner = owner;
    plane setmodel( configdata.modelnames[ owner.team ] );
    
    if ( isdefined( configdata.compassiconfriendly ) )
    {
        plane setobjectiveicons( configdata.compassiconfriendly, configdata.compassiconenemy );
    }
    
    plane thread handledamage();
    plane thread handledeath();
    starttrackingplane( plane );
    
    if ( !isdefined( configdata.nolightfx ) )
    {
        plane thread playplanefx();
    }
    
    plane playloopsound( configdata.inboundsfx );
    plane createkillcam( streakname );
    return plane;
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 4
// Checksum 0x0, Offset: 0x65c
// Size: 0xf3
function planemove( destination, flytime, attacktime, streakname )
{
    configdata = level.planeconfigs[ streakname ];
    self moveto( destination, flytime, 0, 0 );
    
    if ( isdefined( configdata.onattackdelegate ) )
    {
        self thread [[ configdata.onattackdelegate ]]( destination, flytime, attacktime, self.owner, streakname );
    }
    
    if ( isdefined( configdata.sonicboomsfx ) )
    {
        thread playsonicboom( configdata.sonicboomsfx, 0.5 * flytime );
    }
    
    wait 0.65 * flytime;
    
    if ( isdefined( configdata.outboundsfx ) )
    {
        self stoploopsound();
        self playloopsound( configdata.outboundsfx );
    }
    
    if ( isdefined( configdata.outboundflightanim ) )
    {
        self scriptmodelplayanimdeltamotion( configdata.outboundflightanim );
    }
    
    wait 0.35 * flytime;
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 0
// Checksum 0x0, Offset: 0x757
// Size: 0xb2
function planecleanup()
{
    configdata = level.planeconfigs[ self.streakname ];
    
    if ( isdefined( configdata.onflybycompletedelegate ) )
    {
        thread [[ configdata.onflybycompletedelegate ]]( self.owner, self, self.streakname );
    }
    
    if ( isdefined( self.friendlyteamid ) )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( self.friendlyteamid );
        scripts\mp\objidpoolmanager::returnobjectiveid( self.enemyteamid );
    }
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    stoptrackingplane( self );
    self notify( "delete" );
    self delete();
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 0
// Checksum 0x0, Offset: 0x811
// Size: 0x56
function handledeath()
{
    level endon( "game_ended" );
    self endon( "delete" );
    self waittill( "death" );
    forward = anglestoforward( self.angles ) * 200;
    playfx( level.fighter_deathfx, self.origin, forward );
    thread planecleanup();
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 0
// Checksum 0x0, Offset: 0x86f
// Size: 0x24
function handledamage()
{
    self endon( "end_remote" );
    scripts\mp\damage::monitordamage( 800, "helicopter", &handledeathdamage, &modifydamage, 1 );
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 1
// Checksum 0x0, Offset: 0x89b
// Size: 0x99
function modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    modifieddamage = damage;
    modifieddamage = scripts\mp\damage::handlemissiledamage( objweapon, type, modifieddamage );
    modifieddamage = scripts\mp\damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    return modifieddamage;
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 1
// Checksum 0x0, Offset: 0x93d
// Size: 0xb3
function handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    config = level.planeconfigs[ self.streakname ];
    scripts\mp\damage::onkillstreakkilled( self.streakname, attacker, objweapon, type, damage, config.scorepopup, config.destroyedvo, config.callout );
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 0
// Checksum 0x0, Offset: 0x9f8
// Size: 0xab
function playplanefx()
{
    self endon( "death" );
    wait 0.5;
    playfxontag( level.fx_airstrike_afterburner, self, "tag_engine_right" );
    wait 0.5;
    playfxontag( level.fx_airstrike_afterburner, self, "tag_engine_left" );
    wait 0.5;
    playfxontag( level.fx_airstrike_contrail, self, "tag_right_wingtip" );
    wait 0.5;
    playfxontag( level.fx_airstrike_contrail, self, "tag_left_wingtip" );
    wait 0.5;
    playfxontag( level.fx_airstrike_wingtip_light_red, self, "tag_right_wingtip" );
    wait 0.5;
    playfxontag( level.fx_airstrike_wingtip_light_green, self, "tag_left_wingtip" );
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 0
// Checksum 0x0, Offset: 0xaab
// Size: 0x48
function getplaneflyheight()
{
    heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
    
    if ( isdefined( heightent ) )
    {
        return heightent.origin[ 2 ];
    }
    
    println( "<dev string:x1c>" );
    planeflyheight = 950;
    return planeflyheight;
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 1
// Checksum 0x0, Offset: 0xafb
// Size: 0x11e
function getplaneflightplan( distfromplayer )
{
    result = spawnstruct();
    result.height = getplaneflyheight();
    heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
    
    if ( isdefined( heightent ) && isdefined( heightent.script_noteworthy ) && heightent.script_noteworthy == "fixedposition" )
    {
        result.targetpos = heightent.origin;
        result.flightdir = anglestoforward( heightent.angles );
        
        if ( randomint( 2 ) == 0 )
        {
            result.flightdir *= -1;
        }
    }
    else
    {
        forwardvec = anglestoforward( self.angles );
        rightvec = anglestoright( self.angles );
        result.targetpos = self.origin + distfromplayer * forwardvec;
        result.flightdir = -1 * rightvec;
    }
    
    return result;
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 1
// Checksum 0x0, Offset: 0xc22
// Size: 0x42
function getexplodedistance( height )
{
    standardheight = 850;
    standarddistance = 1500;
    distancefrac = standardheight / height;
    newdistance = distancefrac * standarddistance;
    return newdistance;
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 1
// Checksum 0x0, Offset: 0xc6d
// Size: 0x2a
function starttrackingplane( obj )
{
    entnum = obj getentitynumber();
    level.planes[ entnum ] = obj;
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 1
// Checksum 0x0, Offset: 0xc9f
// Size: 0x28
function stoptrackingplane( obj )
{
    entnum = obj getentitynumber();
    level.planes[ entnum ] = undefined;
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 3
// Checksum 0x0, Offset: 0xccf
// Size: 0x134, Type: bool
function selectairstrikelocation( lifeid, streakname, var_9dd357e6fee9854e )
{
    targetsize = level.mapsize / 6.46875;
    
    if ( level.splitscreen )
    {
        targetsize *= 1.5;
    }
    
    config = level.planeconfigs[ streakname ];
    
    if ( isdefined( config.selectlocationvo ) )
    {
        self playlocalsound( game[ "voice" ][ self.team ] + config.selectlocationvo );
    }
    
    _beginlocationselection( streakname, "map_artillery_selector", config.choosedirection, targetsize );
    self endon( "stop_location_selection" );
    self waittill( "confirm_location", location, directionyaw );
    
    if ( !config.choosedirection )
    {
        directionyaw = randomint( 360 );
    }
    
    self setblurforplayer( 0, 0.3 );
    
    if ( isdefined( config.inboundvo ) )
    {
        self playlocalsound( game[ "voice" ][ self.team ] + config.inboundvo );
    }
    
    self thread [[ var_9dd357e6fee9854e ]]( lifeid, location, directionyaw, streakname );
    return true;
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 2
// Checksum 0x0, Offset: 0xe0c
// Size: 0x11a
function setobjectiveicons( friendlyicon, enemyicon )
{
    friendlyteamid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( friendlyteamid != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( friendlyteamid, "active", ( 0, 0, 0 ), friendlyicon );
        scripts\mp\objidpoolmanager::update_objective_onentitywithrotation( friendlyteamid, self );
    }
    
    self.friendlyteamid = friendlyteamid;
    enemyteamid = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( enemyteamid != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( enemyteamid, "active", ( 0, 0, 0 ), enemyicon );
        scripts\mp\objidpoolmanager::update_objective_onentitywithrotation( enemyteamid, self );
    }
    
    self.enemyteamid = enemyteamid;
    
    if ( level.teambased )
    {
        if ( friendlyteamid != -1 )
        {
            scripts\mp\objidpoolmanager::objective_teammask_single( friendlyteamid, self.team );
        }
        
        if ( enemyteamid != -1 )
        {
            scripts\mp\objidpoolmanager::objective_teammask_single( enemyteamid, getotherteam( self.team )[ 0 ] );
        }
        
        return;
    }
    
    if ( friendlyteamid != -1 )
    {
        scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam( friendlyteamid, self.owner );
    }
    
    if ( enemyteamid != -1 )
    {
        scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam( enemyteamid, self.owner );
    }
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 2
// Checksum 0x0, Offset: 0xf2e
// Size: 0x24
function playsonicboom( soundname, delay )
{
    self endon( "death" );
    wait delay;
    self playsoundonmovingent( soundname );
}

// Namespace plane / scripts\mp\killstreaks\plane
// Params 1
// Checksum 0x0, Offset: 0xf5a
// Size: 0xc5
function createkillcam( streakname )
{
    configdata = level.planeconfigs[ streakname ];
    
    if ( isdefined( configdata.killcamoffset ) )
    {
        planedir = anglestoforward( self.angles );
        killcament = spawn( "script_model", self.origin + ( 0, 0, 100 ) - planedir * 200 );
        killcament.starttime = gettime();
        killcament setscriptmoverkillcam( "airstrike" );
        killcament linkto( self, "tag_origin", configdata.killcamoffset, ( 0, 0, 0 ) );
        self.killcament = killcament;
    }
}

