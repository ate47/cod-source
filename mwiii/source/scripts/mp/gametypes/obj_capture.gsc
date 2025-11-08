#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_util;

#namespace obj_capture;

// Namespace obj_capture / scripts\mp\gametypes\obj_capture
// Params 0
// Checksum 0x0, Offset: 0x206
// Size: 0xbd
function init()
{
    settings = spawnstruct();
    settings.pickuptime = 0.5;
    settings.usetextfriendly = &"MP/RETURNING_FLAG";
    settings.usetextenemy = &"MP/GRABBING_FLAG";
    settings.onpickupfn = &onobjectpickup;
    settings.ondropfn = &onobjectdrop;
    settings.onresetfn = &onobjectreset;
    settings.ondelivered = &onobjectdelivered;
    settings.pickupicon = "waypoint_capture_take";
    settings.delivertime = 0.5;
    level.objectivesettings[ "ctf" ] = settings;
}

// Namespace obj_capture / scripts\mp\gametypes\obj_capture
// Params 3
// Checksum 0x0, Offset: 0x2cb
// Size: 0x7d
function createcaptureobjective( objectname, team, settings )
{
    if ( !isdefined( settings ) )
    {
        settings = level.objectivesettings[ "ctf" ];
    }
    
    carryobj = createcarryobject( objectname, team, settings );
    goal = creategoal( carryobj.visuals[ 0 ].target, carryobj, team, settings );
    carryobj.goal = goal;
}

// Namespace obj_capture / scripts\mp\gametypes\obj_capture
// Params 3
// Checksum 0x0, Offset: 0x350
// Size: 0x1eb
function createcarryobject( objectname, team, settings )
{
    objectvisuals = getent( objectname, "targetname" );
    
    if ( !isdefined( objectvisuals ) )
    {
        error( "No model named " + objectname + " found!" );
        return;
    }
    
    trigger = spawn( "trigger_radius", objectvisuals.origin, 0, 96, 120 );
    object = scripts\mp\gameobjects::createcarryobject( team, trigger, [ objectvisuals ], ( 0, 0, 85 ) );
    object scripts\mp\gameobjects::setteamusetime( "friendly", settings.pickuptime );
    object scripts\mp\gameobjects::setteamusetime( "enemy", settings.pickuptime );
    object scripts\mp\gameobjects::setteamusetext( "enemy", settings.usetextfriendly );
    object scripts\mp\gameobjects::setteamusetext( "friendly", settings.usetextenemy );
    object scripts\mp\gameobjects::allowcarry( "enemy" );
    object scripts\mp\gameobjects::setobjectivestatusicons( settings.pickupicon, settings.pickupicon );
    object scripts\mp\gameobjects::setvisibleteam( "enemy" );
    object.objidpingfriendly = 1;
    object.allowweapons = 1;
    object.onpickup = settings.onpickupfn;
    object.onpickupfailed = settings.onpickupfailfn;
    object.ondrop = settings.ondropfn;
    object.onreset = settings.onresetfn;
    object.settings = settings;
    
    if ( !isdefined( settings.carrymodel ) )
    {
        settings.carrymodel = objectvisuals.model;
    }
    
    object setnodeploy( 1 );
    object setnonstick( 1 );
    return object;
}

// Namespace obj_capture / scripts\mp\gametypes\obj_capture
// Params 4
// Checksum 0x0, Offset: 0x544
// Size: 0xe1
function creategoal( goalname, var_c07321ac837070b6, team, settings )
{
    goaltrigger = getent( goalname, "targetname" );
    
    if ( !isdefined( goaltrigger ) )
    {
        error( "No goal trigger named " + goaltrigger + " found!" );
        return;
    }
    
    goal = scripts\mp\gameobjects::createuseobject( team, goaltrigger, [], ( 0, 0, 85 ) );
    goal scripts\mp\gameobjects::allowuse( "enemy" );
    goal scripts\mp\gameobjects::setvisibleteam( "any" );
    goal scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_blitz_defend", "waypoint_blitz_goal" );
    goal scripts\mp\gameobjects::setusetime( settings.delivertime );
    goal scripts\mp\gameobjects::setkeyobject( var_c07321ac837070b6 );
    goal.onuse = settings.ondelivered;
    goal.settings = settings;
    return goal;
}

// Namespace obj_capture / scripts\mp\gametypes\obj_capture
// Params 3
// Checksum 0x0, Offset: 0x62e
// Size: 0x72
function onobjectpickup( player, playervo, defused )
{
    if ( player.team == scripts\mp\gameobjects::getownerteam() )
    {
        scripts\mp\gameobjects::returnhome();
        return;
    }
    
    player attachobjecttocarrier( self.settings.carrymodel );
    scripts\mp\gameobjects::setvisibleteam( "any" );
    scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_capture_kill", "waypoint_escort" );
}

// Namespace obj_capture / scripts\mp\gametypes\obj_capture
// Params 1
// Checksum 0x0, Offset: 0x6a8
// Size: 0x34
function onobjectdrop( player )
{
    scripts\mp\gameobjects::allowcarry( "any" );
    scripts\mp\gameobjects::setvisibleteam( "any" );
    scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_capture_recover", "waypoint_capture_take" );
}

// Namespace obj_capture / scripts\mp\gametypes\obj_capture
// Params 0
// Checksum 0x0, Offset: 0x6e4
// Size: 0x3c
function returnaftertime()
{
    if ( !isdefined( self.settings.returntime ) )
    {
        return;
    }
    
    self endon( "picked_up" );
    wait self.settings.returntime;
    scripts\mp\gameobjects::returnhome();
}

// Namespace obj_capture / scripts\mp\gametypes\obj_capture
// Params 0
// Checksum 0x0, Offset: 0x728
// Size: 0x2
function onobjectreset()
{
    
}

// Namespace obj_capture / scripts\mp\gametypes\obj_capture
// Params 1
// Checksum 0x0, Offset: 0x732
// Size: 0x44
function onobjectdelivered( player )
{
    self.keyobject scripts\mp\gameobjects::allowcarry( "none" );
    self.keyobject scripts\mp\gameobjects::setvisibleteam( "none" );
    player detachobjectifcarried();
    scripts\mp\gameobjects::deleteuseobject();
}

// Namespace obj_capture / scripts\mp\gametypes\obj_capture
// Params 1
// Checksum 0x0, Offset: 0x77e
// Size: 0x24
function attachobjecttocarrier( objectmodelname )
{
    self attach( objectmodelname, "tag_stowed_back3", 1 );
    self.carriedobject = objectmodelname;
}

// Namespace obj_capture / scripts\mp\gametypes\obj_capture
// Params 0
// Checksum 0x0, Offset: 0x7aa
// Size: 0x2e
function detachobjectifcarried()
{
    if ( isdefined( self.carriedobject ) )
    {
        self detach( self.carriedobject, "tag_stowed_back3" );
        self.carriedobject = undefined;
    }
}

// Namespace obj_capture / scripts\mp\gametypes\obj_capture
// Params 10
// Checksum 0x0, Offset: 0x7e0
// Size: 0x5a
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    detachobjectifcarried();
}

