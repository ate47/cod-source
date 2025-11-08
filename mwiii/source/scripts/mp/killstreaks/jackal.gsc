#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\damage;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\killstreaks\flares;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\weapon;

#namespace jackal;

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 5
// Checksum 0x0, Offset: 0x8c3
// Size: 0x37f
function beginjackal( lifeid, startpoint, pos, streakinfo, tacopslz )
{
    if ( !isdefined( level.jackals ) )
    {
        level.jackals = [];
    }
    
    marker = undefined;
    
    if ( isdefined( tacopslz ) )
    {
        marker = tacopslz.marker;
        var_4f358d69033a2c70 = 2;
        
        if ( !isdefined( marker ) )
        {
            marker = spawnstruct();
            
            if ( isdefined( tacopslz.location ) )
            {
                marker.location = tacopslz.location;
            }
            else
            {
                marker.location = tacopslz.trigger.origin;
            }
            
            marker.angles = ( 0, 0, 0 );
            marker.string = "equip_deploy_succeeded";
            marker.visual = spawn( "script_model", marker.location );
            marker.visual setmodel( "ks_marker_mp" );
            marker.visual setotherent( self );
        }
        
        if ( !isdefined( marker.location ) )
        {
            self notify( "cancel_jackal" );
            return 0;
        }
        else if ( isdefined( level.jackal_incoming ) || level.jackals.size >= var_4f358d69033a2c70 )
        {
            if ( isdefined( marker.visual ) )
            {
                marker.visual delete();
            }
            
            scripts\mp\hud_message::showerrormessage( "KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
            
            if ( isdefined( streakinfo.objweapon ) && streakinfo.objweapon.basename != "none" )
            {
                self notify( "killstreak_finished_with_weapon_" + streakinfo.weaponname );
            }
            
            self notify( "cancel_jackal" );
            return 0;
        }
    }
    
    self notify( "called_in_jackal" );
    level.jackal_incoming = 1;
    heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
    
    if ( isdefined( heightent ) )
    {
        trueheight = heightent.origin[ 2 ] + 500;
    }
    else
    {
        trueheight = 1300;
    }
    
    if ( isdefined( marker ) && isdefined( marker.location ) )
    {
        pos = marker.location;
    }
    
    pos *= ( 1, 1, 0 );
    pathgoal = pos + ( 0, 0, trueheight );
    jackal = spawnksjackal( lifeid, self, startpoint, pathgoal, streakinfo, tacopslz );
    jackal.tacopslz = tacopslz;
    var_ec558bcb59d5d0b9 = pathgoal;
    var_ec5588cb59d5ca20 = pathgoal + anglestoright( self.angles ) * 2000;
    var_ec5589cb59d5cc53 = pathgoal - anglestoright( self.angles ) * 2000;
    approachgoals = [ var_ec558bcb59d5d0b9, var_ec5588cb59d5ca20, var_ec5589cb59d5cc53 ];
    
    foreach ( goal in approachgoals )
    {
        if ( !jackalcanseelocation( jackal, goal ) )
        {
            continue;
        }
        
        pathgoal = goal;
        break;
    }
    
    jackal.pathgoal = pathgoal;
    thread defendlocation( jackal, marker );
    return jackal;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 6
// Checksum 0x0, Offset: 0xc4b
// Size: 0x71c
function spawnksjackal( lifeid, owner, pathstart, pathgoal, streakinfo, tacopslz )
{
    forward = vectortoangles( pathgoal - pathstart );
    numflares = 4;
    var_f751b396e9b232e6 = 50;
    var_a001268025a19c55 = 175;
    maxhealth = 10000;
    var_1abfbb19b71bccf8 = "veh8_mil_air_lbravo";
    jackalturret = "jackal_turret_mp";
    var_c5836308d0a5013a = "veh_mil_air_ca_dropship_mp_turret";
    var_d9f3116109296870 = 1;
    jackalcannon = "jackal_cannon_mp";
    var_c3203d1148c1e58b = "veh_mil_air_ca_dropship_turret_missile";
    var_403a5aabbd2fdab7 = 1;
    currentstring = &"KILLSTREAKS_HINTS_JACKAL_GUARD";
    var_9b3f7c7b98c0754 = "follow_player";
    
    if ( isdefined( tacopslz ) )
    {
        var_9b3f7c7b98c0754 = "guard_location";
    }
    
    jackal = spawnhelicopter( owner, pathstart, forward, "veh_airdrop_mp", var_1abfbb19b71bccf8 );
    
    if ( !isdefined( jackal ) )
    {
        return;
    }
    
    if ( isdefined( tacopslz ) )
    {
        jackal.lz = tacopslz;
    }
    
    jackal thread handledestroydamage();
    jackal.damagecallback = &callback_vehicledamage;
    jackal.speed = var_f751b396e9b232e6;
    jackal.accel = var_a001268025a19c55;
    jackal.health = maxhealth;
    jackal.maxhealth = jackal.health;
    jackal.team = owner.team;
    jackal.owner = owner;
    jackal setcandamage( 1 );
    jackal.defendloc = pathgoal;
    jackal.lifeid = lifeid;
    jackal.jackal = 1;
    jackal.streakinfo = streakinfo;
    jackal.streakname = streakinfo.streakname;
    jackal.evasivemaneuvers = 0;
    jackal.combatmode = var_9b3f7c7b98c0754;
    jackal.currentstring = currentstring;
    jackal.streakinfo = streakinfo;
    jackal.flaresreservecount = numflares;
    jackal.turreton = var_d9f3116109296870;
    jackal.turretweapon = jackalturret;
    jackal.cannonweapon = jackalcannon;
    jackal.cannonon = var_403a5aabbd2fdab7;
    jackal addtoactivekillstreaklist( streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100 );
    jackal setmaxpitchroll( 0, 90 );
    jackal vehicle_setspeed( jackal.speed, jackal.accel );
    jackal sethoverparams( 50, 100, 50 );
    jackal setturningability( 0.05 );
    jackal setyawspeed( 45, 25, 25, 0.5 );
    jackal setotherent( owner );
    forwardangle = anglestoforward( jackal.angles );
    
    if ( !isdefined( tacopslz ) )
    {
        jackal.turret = spawnturret( "misc_turret", jackal gettagorigin( "tag_origin" ), jackalturret );
        jackal.turret setmodel( var_c5836308d0a5013a );
        jackal.turret.owner = owner;
        jackal.turret.team = owner.team;
        jackal.turret.angles = jackal.angles;
        jackal.turret.type = "Machine_Gun";
        jackal.turret.streakinfo = streakinfo;
        jackal.turret linkto( jackal, "tag_origin", ( 200, 0, 55 ), ( 0, 0, 0 ) );
        jackal.turret setturretmodechangewait( 0 );
        jackal.turret setmode( "manual_target" );
        jackal.turret setsentryowner( owner );
        jackal.cannon = spawnturret( "misc_turret", jackal gettagorigin( "tag_origin" ), jackalcannon );
        jackal.cannon setmodel( var_c3203d1148c1e58b );
        jackal.cannon.owner = owner;
        jackal.cannon.team = owner.team;
        jackal.cannon.angles = jackal.angles;
        jackal.cannon.type = "Cannon";
        jackal.cannon.streakinfo = streakinfo;
        jackal.cannon linkto( jackal, "tag_origin", ( -100, 0, 55 ), ( 0, 0, 0 ) );
        jackal.cannon setturretmodechangewait( 0 );
        jackal.cannon setmode( "manual_target" );
        jackal.cannon setsentryowner( owner );
    }
    
    jackal.useobj = spawn( "script_model", jackal gettagorigin( "tag_origin" ) );
    jackal.useobj linkto( jackal, "tag_origin" );
    level.jackals[ level.jackals.size ] = jackal;
    level.jackals = array_removeundefined( level.jackals );
    level.jackal_incoming = undefined;
    
    if ( isdefined( tacopslz ) )
    {
        jackal thread scripts\mp\killstreaks\flares::flares_handleincomingstinger( undefined, undefined );
    }
    
    jackal thread jackaldestroyed();
    jackal thread delayjackalloopsfx( 0.05, "dropship_enemy_hover_world_grnd" );
    jackal thread delay_jackal_arrive_sfx();
    
    if ( !isdefined( tacopslz ) )
    {
        jackal.turret.vehicle_fired_from = jackal;
        jackal.cannon.vehicle_fired_from = jackal;
        jackal.turret.vehicle_fired_from.killcament = spawn( "script_model", jackal gettagorigin( "tag_origin" ) );
        jackal.turret.vehicle_fired_from.killcament linkto( jackal, "tag_origin" );
        jackal.cannon.vehicle_fired_from.killcament = jackal.turret.vehicle_fired_from.killcament;
    }
    
    planedir = anglestoforward( jackal.angles );
    return jackal;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x1370
// Size: 0xeb
function getnumownedjackals( owner )
{
    counter = 0;
    
    if ( level.teambased )
    {
        foreach ( jackal in level.jackals )
        {
            if ( jackal.team != owner.team )
            {
                continue;
            }
            
            counter++;
        }
    }
    else
    {
        foreach ( jackal in level.jackals )
        {
            if ( jackal.owner != owner )
            {
                continue;
            }
            
            counter++;
        }
    }
    
    return counter;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x1464
// Size: 0x12
function delay_jackal_arrive_sfx()
{
    self endon( "death" );
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 6 );
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 2
// Checksum 0x0, Offset: 0x147e
// Size: 0x2a
function delayjackalloopsfx( delaytime, alias )
{
    self endon( "death" );
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( delaytime );
    self playloopsound( alias );
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 2
// Checksum 0x0, Offset: 0x14b0
// Size: 0x247
function defendlocation( jackal, marker )
{
    jackal endon( "death" );
    assert( isdefined( jackal ) );
    jackal setvehgoalpos( jackal.pathgoal, 1 );
    jackal thread closetogoalcheck( jackal.pathgoal );
    jackal thread monitorowner();
    
    if ( isdefined( jackal.dropcrates ) )
    {
        jackal thread watchdropcratesearly( marker );
    }
    
    jackal waittill( "goal" );
    
    if ( isdefined( marker ) && isdefined( jackal.lz ) )
    {
        jackal thread jackaltimer();
        jackal thread watchgameendleave();
        jackal thread engageprimarytarget();
        jackal.speed = 250;
        jackal vehicle_setspeed( 50, 15 );
        jackal jackalmovetolocation( marker.location );
        jackal waittill( "extract_hostages" );
        jackal thread jackalleave( 50, 15 );
    }
    else if ( isdefined( marker ) && isdefined( jackal.dropcrates ) )
    {
        jackal thread jackaltimer();
        jackal thread watchgameendleave();
        jackal thread engageprimarytarget();
        jackal thread engagesecondarytarget();
        jackal vehicle_setspeed( 50, 15 );
        jackal jackalmovetolocation( marker.location );
        jackal thread dropcrates( jackal.dropcrates, marker );
        jackal thread watchjackalcratepickup();
        jackal waittill_any_timeout_1( 10, "all_crates_gone" );
        jackal.combatmode = "follow_player";
    }
    else
    {
        jackal thread jackaltimer();
        jackal thread watchgameendleave();
        jackal thread engageprimarytarget();
        jackal thread engagesecondarytarget();
        jackal vehicle_setspeed( int( jackal.speed / 14 ), int( jackal.accel / 16 ) );
    }
    
    if ( !isdefined( jackal.lz ) )
    {
        jackal.useobj setkillstreakcontrolpriority( jackal.owner, jackal.currentstring, 360, 360, 30000, 30000, 2 );
        jackal thread patrolfield();
        jackal thread watchmodechange( getothermode( jackal.combatmode ), jackal.currentstring );
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x16ff
// Size: 0xa6
function engageprimarytarget()
{
    self notify( "engagePrimary" );
    self endon( "engagePrimary" );
    self endon( "leaving" );
    self endon( "death" );
    self.lastaction = undefined;
    
    if ( istrue( self.turreton ) )
    {
        while ( true )
        {
            targets = jackalgettargets();
            
            if ( isdefined( targets ) && targets.size > 0 )
            {
                acquireturrettarget( targets );
                self.turret waittill( "stop_firing" );
                
                if ( self.combatmode == "follow_player" )
                {
                    thread patrolfield();
                }
            }
            else
            {
                self.lastaction = "noTargetsFound";
            }
            
            wait 0.05;
        }
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x17ad
// Size: 0x81
function engagesecondarytarget()
{
    self notify( "engageSecondary" );
    self endon( "engageSecondary" );
    self endon( "leaving" );
    self endon( "death" );
    firedelay = weaponfiretime( self.cannonweapon );
    
    if ( istrue( self.cannonon ) )
    {
        while ( true )
        {
            targets = jackalgettargets();
            
            if ( !isdefined( targets ) || targets.size < 2 )
            {
                waitframe();
                continue;
            }
            
            acquirecannontarget( targets );
            scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( firedelay );
        }
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x1836
// Size: 0x181
function followplayer()
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "guard_location" );
    self endon( "priority_target" );
    self endon( "jackal_crashing" );
    self.owner endon( "disconnect" );
    self notify( "following_player" );
    self vehicle_setspeed( 50, 15 );
    
    while ( true )
    {
        newpos = undefined;
        
        if ( istrue( self.evasivemaneuvers ) )
        {
            playerx = self.owner.origin[ 0 ];
            playery = self.owner.origin[ 1 ];
            newx = playerx + randomintrange( -500, 500 );
            newy = playery + randomintrange( -500, 500 );
            properz = getcorrectheight( newx, newy, 350 );
            newpos = ( newx, newy, properz );
        }
        else
        {
            playerx = self.owner.origin[ 0 ];
            playery = self.owner.origin[ 1 ];
            properz = getcorrectheight( playerx, playery, 20 );
            newpos = ( playerx, playery, properz );
        }
        
        self setlookatent( self.owner );
        self setvehgoalpos( newpos, 1 );
        self.lastaction = "following_player";
        waittill_any_2( "goal", "begin_evasive_maneuvers" );
        self clearlookatent();
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 0.1 );
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x19bf
// Size: 0x1ab
function guardposition( position )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "follow_player" );
    self endon( "jackal_crashing" );
    self.owner endon( "disconnect" );
    self vehicle_setspeed( int( self.speed / 14 ), int( self.accel / 16 ) );
    newpos = undefined;
    
    if ( isdefined( position ) )
    {
        playerx = position[ 0 ];
        playery = position[ 1 ];
        properz = getcorrectheight( playerx, playery, 20 );
        newpos = ( playerx, playery, properz );
    }
    else if ( istrue( self.evasivemaneuvers ) )
    {
        playerx = self.owner.origin[ 0 ];
        playery = self.owner.origin[ 1 ];
        newx = playerx + randomintrange( -500, 500 );
        newy = playery + randomintrange( -500, 500 );
        properz = getcorrectheight( newx, newy, 350 );
        newpos = ( newx, newy, properz );
    }
    else
    {
        playerx = self.owner.origin[ 0 ];
        playery = self.owner.origin[ 1 ];
        properz = getcorrectheight( playerx, playery, 20 );
        newpos = ( playerx, playery, properz );
    }
    
    self setlookatent( self.owner );
    self setvehgoalpos( newpos, 1 );
    self.lastaction = "following_player";
    waittill_any_2( "goal", "begin_evasive_maneuvers" );
    self clearlookatent();
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x1b72
// Size: 0x17b
function patrolfield()
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "guard_location" );
    self endon( "priority_target" );
    self endon( "jackal_crashing" );
    self.owner endon( "disconnect" );
    self vehicle_setspeed( int( self.speed / 14 ), int( self.accel / 16 ) );
    
    while ( true )
    {
        newpos = undefined;
        
        if ( isdefined( self.patroltarget ) && isalive( self.patroltarget ) && isplayer( self.patroltarget ) && !self.patroltarget _hasperk( "specialty_blindeye" ) )
        {
            if ( !jackalcanseeenemy( self.patroltarget ) || distance2dsquared( self.origin, self.patroltarget.origin ) > 4194304 )
            {
                jackalmovetoenemy( self.patroltarget );
            }
        }
        else
        {
            target = jackalfindclosestenemy();
            
            if ( isdefined( target ) )
            {
                self.patroltarget = target;
                thread watchpatroltarget();
                jackalmovetoenemy( target );
            }
            else
            {
                self.patroltarget = undefined;
                location = jackalfindfirstopenpoint();
                
                if ( isdefined( location ) )
                {
                    jackalmovetolocation( location.origin );
                }
            }
        }
        
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 0.1 );
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x1cf5
// Size: 0x152
function jackalfindfirstopenpoint()
{
    point = undefined;
    
    if ( isdefined( level.carepackagedropnodes ) && level.carepackagedropnodes.size > 0 )
    {
        foreach ( loc in level.carepackagedropnodes )
        {
            if ( isdefined( loc.free ) && !loc.free )
            {
                continue;
            }
            
            if ( !jackalcanseelocation( self, loc.origin ) )
            {
                continue;
            }
            
            loc.free = 0;
            point = loc;
            
            if ( !isdefined( self.initialpatrolpoint ) )
            {
                self.initialpatrolpoint = point;
            }
            
            break;
        }
        
        if ( !isdefined( point ) )
        {
            if ( isdefined( self.initialpatrolpoint ) )
            {
                foreach ( loc in level.carepackagedropnodes )
                {
                    if ( loc != self.initialpatrolpoint )
                    {
                        loc.free = undefined;
                    }
                }
                
                point = self.initialpatrolpoint;
            }
        }
    }
    
    return point;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 2
// Checksum 0x0, Offset: 0x1e50
// Size: 0x58
function jackalcanseelocation( jackal, loc )
{
    icansee = 0;
    contents = scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 1, 0 );
    
    if ( scripts\engine\trace::ray_trace_passed( jackal.origin, loc, jackal, contents ) )
    {
        icansee = 1;
    }
    
    return icansee;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x1eb1
// Size: 0xa3
function jackalcanseeenemy( target )
{
    icansee = 0;
    contents = scripts\engine\trace::create_contents( 0, 1, 0, 1, 1, 0 );
    tracepoints = [ target gettagorigin( "j_head" ), target gettagorigin( "j_mainroot" ), target gettagorigin( "tag_origin" ) ];
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        if ( !scripts\engine\trace::ray_trace_passed( self.origin, tracepoints[ i ], self, contents ) )
        {
            continue;
        }
        
        icansee = 1;
        break;
    }
    
    return icansee;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x1f5d
// Size: 0x1cf
function jackalmovetoenemy( target )
{
    if ( isdefined( self.patroltarget ) )
    {
        target = self.patroltarget;
    }
    
    if ( jackalcanseeenemy( target ) )
    {
        self setlookatent( target );
    }
    
    newpos = undefined;
    
    if ( istrue( self.evasivemaneuvers ) )
    {
        playerx = target.origin[ 0 ];
        playery = target.origin[ 1 ];
        newx = playerx + randomintrange( -500, 500 );
        newy = playery + randomintrange( -500, 500 );
        properz = getcorrectheight( newx, newy, 350 );
        newpos = ( newx, newy, properz );
    }
    else
    {
        playerx = target.origin[ 0 ];
        playery = target.origin[ 1 ];
        properz = getcorrectheight( playerx, playery, 20 );
        newpos = ( playerx, playery, properz );
    }
    
    contentoverride = scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 1, 0 );
    trace = scripts\engine\trace::ray_trace( self.origin, newpos, level.characters, contentoverride );
    
    if ( trace[ "hittype" ] != "hittype_none" )
    {
        newz = getcorrectheight( trace[ "position" ][ 0 ], trace[ "position" ][ 1 ], 20 );
        newpos = ( trace[ "position" ][ 0 ], trace[ "position" ][ 1 ], newz );
    }
    
    self setvehgoalpos( newpos + ( 0, 0, 500 ), 2 );
    self.lastaction = "patrol";
    waittill_any_2( "goal", "begin_evasive_maneuvers" );
    self clearlookatent();
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x2134
// Size: 0x133
function jackalfindclosestenemy()
{
    aliveenemies = [];
    
    foreach ( character in level.players )
    {
        if ( character.ignoreme || isdefined( character.owner ) && character.owner.ignoreme )
        {
            continue;
        }
        
        if ( !isalive( character ) )
        {
            continue;
        }
        
        if ( isdefined( level.teambased ) && isdefined( character.team ) && self.team == character.team )
        {
            continue;
        }
        
        if ( character _hasperk( "specialty_blindeye" ) )
        {
            continue;
        }
        
        if ( character isjackalenemyindoors() )
        {
            continue;
        }
        
        aliveenemies[ aliveenemies.size ] = character;
        waitframe();
    }
    
    nearestenemies = undefined;
    
    if ( aliveenemies.size > 0 )
    {
        nearestenemies = sortbydistance( aliveenemies, self.origin );
    }
    
    if ( isdefined( nearestenemies ) && nearestenemies.size > 0 )
    {
        return nearestenemies[ 0 ];
    }
    
    return undefined;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x2270
// Size: 0x58
function isjackalenemyindoors()
{
    indoors = 0;
    contents = scripts\engine\trace::create_contents( 0, 1, 0, 1, 1, 0 );
    
    if ( !scripts\engine\trace::ray_trace_passed( self.origin, self.origin + ( 0, 0, 10000 ), self, contents ) )
    {
        indoors = 1;
    }
    
    return indoors;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x22d1
// Size: 0x52
function watchpatroltarget()
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "jackal_crashing" );
    self.owner endon( "disconnect" );
    result = self.patroltarget waittill_any_timeout_1( 5, "death_or_disconnect" );
    self.patroltarget = undefined;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x232b
// Size: 0xed
function jackalmovetolocation( location )
{
    newpos = undefined;
    
    if ( istrue( self.evasivemaneuvers ) )
    {
        locationx = location[ 0 ];
        locationy = location[ 1 ];
        newx = locationx + randomintrange( -500, 500 );
        newy = locationy + randomintrange( -500, 500 );
        properz = getcorrectheight( newx, newy, 350 );
        newpos = ( newx, newy, properz );
    }
    else
    {
        locationx = location[ 0 ];
        locationy = location[ 1 ];
        
        if ( !isdefined( self.tacopslz ) )
        {
            properz = getcorrectheight( locationx, locationy, 20 );
        }
        else
        {
            properz = 160;
        }
        
        newpos = ( locationx, locationy, properz );
    }
    
    self clearlookatent();
    self setvehgoalpos( newpos + ( 0, 0, 500 ), 10 );
    waittill_any_2( "goal", "begin_evasive_maneuvers" );
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 2
// Checksum 0x0, Offset: 0x2420
// Size: 0x189
function jackalleave( speedoverride, acceloverride )
{
    self endon( "death" );
    self setmaxpitchroll( 0, 0 );
    self notify( "leaving" );
    self clearlookatent();
    self.turret setsentryowner( undefined );
    
    if ( isdefined( self.turrettarget ) && isdefined( self.targetoutline ) )
    {
        outlinedisable( self.targetoutline, self.turrettarget );
    }
    
    var_f751b396e9b232e6 = int( self.speed / 14 );
    var_a001268025a19c55 = int( self.accel / 16 );
    
    if ( isdefined( speedoverride ) )
    {
        var_f751b396e9b232e6 = speedoverride;
    }
    
    if ( isdefined( acceloverride ) )
    {
        var_a001268025a19c55 = acceloverride;
    }
    
    self vehicle_setspeed( var_f751b396e9b232e6, var_a001268025a19c55 );
    pathgoal = self.origin + anglestoforward( ( 0, randomint( 360 ), 0 ) ) * 500;
    pathgoal += ( 0, 0, 1000 );
    self setvehgoalpos( pathgoal, 1 );
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    self waittill( "goal" );
    pathend = getpathend();
    self vehicle_setspeed( 250, 75 );
    self setvehgoalpos( pathend, 1 );
    self waittill( "goal" );
    self stoploopsound();
    level.jackals[ level.jackals.size - 1 ] = undefined;
    self notify( "jackal_gone" );
    thread jackaldelete();
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x25b1
// Size: 0xc9
function jackaldelete()
{
    printgameaction( "killstreak ended - jackal", self.owner );
    
    if ( isdefined( self.turret ) )
    {
        self.turret delete();
    }
    
    if ( isdefined( self.cannon ) )
    {
        self.cannon delete();
    }
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    foreach ( loc in level.carepackagedropnodes )
    {
        loc.free = undefined;
    }
    
    self delete();
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x2682
// Size: 0x2f
function jackaltimer()
{
    self endon( "death" );
    level endon( "game_ended" );
    lifetime = 9999;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( lifetime );
    thread jackalleave();
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x26b9
// Size: 0x20
function watchgameendleave()
{
    self endon( "death" );
    self endon( "leaving" );
    level waittill( "game_ended" );
    thread jackalleave();
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x26e1
// Size: 0x95
function randomjackalmovement()
{
    self notify( "randomJackalMovement" );
    self endon( "randomJackalMovement" );
    self endon( "death" );
    self endon( "acquiringTarget" );
    self endon( "leaving" );
    self.lastaction = "randomMovement";
    pos = self.defendloc;
    newpos = getrandompoint( self.origin );
    self setvehgoalpos( newpos, 1 );
    thread drawline( self.origin, newpos, 5, ( 1, 0, 1 ) );
    self waittill( "goal" );
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x277e
// Size: 0x1c7
function getrandompoint( pos )
{
    self clearlookatent();
    
    if ( distance2dsquared( self.origin, self.owner.origin ) > 4194304 )
    {
        x = self.owner.origin[ 0 ];
        y = self.owner.origin[ 1 ];
        z = getcorrectheight( x, y, 20 );
        centerpoint = ( x, y, z );
        self setlookatent( self.owner );
        return centerpoint;
    }
    
    yaw = self.angles[ 1 ];
    yawmin = int( yaw - 60 );
    yawmax = int( yaw + 60 );
    randyaw = randomintrange( yawmin, yawmax );
    direction = ( 0, randyaw, 0 );
    movetopoint = self.origin + anglestoforward( direction ) * randomintrange( 400, 800 );
    pointx = movetopoint[ 0 ];
    pointy = movetopoint[ 1 ];
    newheight = getcorrectheight( pointx, pointy, 20 );
    point = tracenewpoint( pointx, pointy, newheight );
    
    if ( point != 0 )
    {
        return point;
    }
    
    pointx = randomfloatrange( pos[ 0 ] - 1200, pos[ 0 ] + 1200 );
    pointy = randomfloatrange( pos[ 1 ] - 1200, pos[ 1 ] + 1200 );
    bspoint = ( pointx, pointy, newheight );
    return bspoint;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 2
// Checksum 0x0, Offset: 0x294d
// Size: 0x1c5
function getnewpoint( pos, targ )
{
    self endon( "death" );
    self endon( "acquiringTarget" );
    self endon( "leaving" );
    
    if ( !isdefined( targ ) )
    {
        return;
    }
    
    enemypoints = [];
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        if ( !level.teambased || player.team != self.team )
        {
            enemypoints[ enemypoints.size ] = player.origin;
        }
    }
    
    if ( enemypoints.size > 0 )
    {
        gotopoint = averagepoint( enemypoints );
        pointx = gotopoint[ 0 ];
        pointy = gotopoint[ 1 ];
    }
    else
    {
        center = level.mapcenter;
        movementdist = level.mapsize / 4;
        pointx = randomfloatrange( center[ 0 ] - movementdist, center[ 0 ] + movementdist );
        pointy = randomfloatrange( center[ 1 ] - movementdist, center[ 1 ] + movementdist );
    }
    
    newheight = getcorrectheight( pointx, pointy, 20 );
    point = tracenewpoint( pointx, pointy, newheight );
    
    if ( point != 0 )
    {
        return point;
    }
    
    pointx = randomfloatrange( pos[ 0 ] - 1200, pos[ 0 ] + 1200 );
    pointy = randomfloatrange( pos[ 1 ] - 1200, pos[ 1 ] + 1200 );
    newheight = getcorrectheight( pointx, pointy, 20 );
    bspoint = ( pointx, pointy, newheight );
    return bspoint;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x2b1b
// Size: 0x7c
function getpathstart( coord )
{
    pathrandomness = 100;
    halfdistance = 15000;
    yaw = randomfloat( 360 );
    direction = ( 0, yaw, 0 );
    startpoint = coord + anglestoforward( direction ) * -1 * halfdistance;
    startpoint += ( ( randomfloat( 2 ) - 1 ) * pathrandomness, ( randomfloat( 2 ) - 1 ) * pathrandomness, 0 );
    return startpoint;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x2ba0
// Size: 0x5e
function getpathend()
{
    pathrandomness = 150;
    halfdistance = 15000;
    yaw = self.angles[ 1 ];
    direction = ( 0, yaw, 0 );
    endpoint = self.origin + anglestoforward( direction ) * halfdistance;
    return endpoint;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x2c07
// Size: 0x193
function fireonturrettarget( playdialog )
{
    self endon( "leaving" );
    self endon( "explode" );
    self endon( "death" );
    self endon( "target_timeout" );
    
    if ( istrue( playdialog ) && isreallyalive( self.owner ) && ( !isdefined( self.lastfiretime ) || self.lastfiretime + 10000 <= gettime() ) )
    {
        self.lastfiretime = gettime();
    }
    
    outline = outlineenableforplayer( self.turrettarget, self.owner, "outline_depth_orange", "killstreak_personal" );
    self.targetoutline = outline;
    timeouttime = 3;
    thread watchforlosttarget( self.turret, self.turrettarget, "target_timeout", timeouttime );
    self.turret waittill( "turret_on_target" );
    level thread scripts\mp\battlechatter_mp::saytoself( self.turrettarget, "plr_killstreak_target" );
    self.turret notify( "start_firing" );
    firetime = weaponfiretime( self.turretweapon );
    
    while ( isdefined( self.turrettarget ) && isreallyalive( self.turrettarget ) && isdefined( self.turret getturrettarget( 1 ) ) && self.turret getturrettarget( 1 ) == self.turrettarget )
    {
        self.turret shootturret();
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( firetime );
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x2da2
// Size: 0x117
function fireoncannontarget( playdialog )
{
    self endon( "leaving" );
    self endon( "explode" );
    self endon( "death" );
    self endon( "target_cannon_timeout" );
    timeouttime = 3;
    thread watchforlosttarget( self.cannon, self.cannontarget, "target_cannon_timeout", timeouttime );
    self.cannon waittill( "turret_on_target" );
    level thread scripts\mp\battlechatter_mp::saytoself( self.cannontarget, "plr_killstreak_target" );
    self.cannon notify( "start_firing" );
    firetime = weaponfiretime( self.cannonweapon );
    
    if ( isdefined( self.cannontarget ) && isreallyalive( self.cannontarget ) && isdefined( self.cannon getturrettarget( 1 ) ) && self.cannon getturrettarget( 1 ) == self.cannontarget )
    {
        self.cannon thread watchmissilelaunch();
        self.cannon shootturret();
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x2ec1
// Size: 0x32
function watchmissilelaunch()
{
    self endon( "death" );
    self waittill( "missile_fire", missile );
    missile.streakinfo = self.streakinfo;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x2efb
// Size: 0x7a
function setmissilekillcament()
{
    self endon( "leaving" );
    self endon( "explode" );
    self endon( "death" );
    self endon( "target_cannon_timeout" );
    self.cannon waittill( "missile_fire", missile );
    missile.vehicle_fired_from = self;
    missile.vehicle_fired_from.killcament = self.cannon.vehicle_fired_from.killcament;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 4
// Checksum 0x0, Offset: 0x2f7d
// Size: 0xb0
function watchforlosttarget( turret, besttarget, timeoutnotify, cooldowntime )
{
    self endon( "death" );
    self endon( "leaving" );
    turret endon( "stop_firing" );
    var_fd5bec4b454541ff = self.targetoutline;
    result = besttarget waittill_any_timeout_1( cooldowntime, "death_or_disconnect" );
    
    if ( result == "timeout" )
    {
        self notify( timeoutnotify );
    }
    
    if ( turret.type == "Machine_Gun" )
    {
        if ( isdefined( var_fd5bec4b454541ff ) && isdefined( besttarget ) )
        {
            outlinedisable( var_fd5bec4b454541ff, besttarget );
        }
        
        self clearlookatent();
    }
    
    turret cleartargetentity();
    turret notify( "stop_firing" );
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x3035
// Size: 0xc4
function isreadytofire( tolerance )
{
    self endon( "death" );
    self endon( "leaving" );
    
    if ( !isdefined( tolerance ) )
    {
        tolerance = 10;
    }
    
    var_6ad4cdf6404eb26f = anglestoforward( self.angles );
    var_6fa7e7954b1f35e7 = self.turrettarget.origin - self.origin;
    var_6ad4cdf6404eb26f *= ( 1, 1, 0 );
    var_6fa7e7954b1f35e7 *= ( 1, 1, 0 );
    var_6fa7e7954b1f35e7 = vectornormalize( var_6fa7e7954b1f35e7 );
    var_6ad4cdf6404eb26f = vectornormalize( var_6ad4cdf6404eb26f );
    targetcosine = vectordot( var_6fa7e7954b1f35e7, var_6ad4cdf6404eb26f );
    facingcosine = cos( tolerance );
    
    if ( targetcosine >= facingcosine )
    {
        return 1;
    }
    
    return 0;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x3101
// Size: 0xd0
function acquireturrettarget( targets )
{
    self endon( "death" );
    self endon( "leaving" );
    self notify( "priority_target" );
    
    if ( isdefined( self.outlinedent ) && isdefined( self.turrettarget ) )
    {
        outlinedisable( self.outlinedent, self.turrettarget );
    }
    
    if ( targets.size == 1 )
    {
        self.turrettarget = targets[ 0 ];
    }
    else
    {
        self.turrettarget = getbesttarget( targets );
    }
    
    if ( isdefined( self.turrettarget ) )
    {
        self clearlookatent();
        self setlookatent( self.turrettarget );
        self.turret settargetentity( self.turrettarget );
        self.lastaction = "attackTarget";
        thread fireonturrettarget( 1 );
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x31d9
// Size: 0x57
function acquirecannontarget( targets )
{
    self endon( "death" );
    self endon( "leaving" );
    self.cannontarget = getbesttarget( targets );
    
    if ( isdefined( self.cannontarget ) )
    {
        self.cannon settargetentity( self.cannontarget );
        thread fireoncannontarget( 0 );
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x3238
// Size: 0x7b
function jackalgettargets()
{
    self endon( "death" );
    self endon( "leaving" );
    targets = [];
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        potentialtarget = players[ i ];
        
        if ( istarget( potentialtarget ) )
        {
            if ( isdefined( players[ i ] ) )
            {
                targets[ targets.size ] = players[ i ];
            }
        }
        else
        {
            continue;
        }
        
        wait 0.05;
    }
    
    return targets;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x32bc
// Size: 0x18b, Type: bool
function istarget( potentialtarget )
{
    self endon( "death" );
    
    if ( !isalive( potentialtarget ) || potentialtarget.sessionstate != "playing" )
    {
        return false;
    }
    
    if ( isdefined( self.owner ) && potentialtarget == self.owner )
    {
        return false;
    }
    
    if ( !isdefined( potentialtarget.pers[ "team" ] ) )
    {
        return false;
    }
    
    if ( level.teambased && potentialtarget.pers[ "team" ] == self.team )
    {
        return false;
    }
    
    if ( potentialtarget.pers[ "team" ] == "spectator" )
    {
        return false;
    }
    
    if ( isdefined( potentialtarget.spawntime ) && ( gettime() - potentialtarget.spawntime ) / 1000 <= 5 )
    {
        return false;
    }
    
    if ( potentialtarget _hasperk( "specialty_blindeye" ) )
    {
        return false;
    }
    
    if ( distance2dsquared( self.origin, potentialtarget.origin ) > 4194304 )
    {
        return false;
    }
    
    offset = ( 0, 0, 35 );
    endpoint = potentialtarget.origin + rotatevector( offset, potentialtarget getworldupreferenceangles() );
    ignorelist = [ self ];
    var_d740d9b67690a550 = ray_trace( self.origin, endpoint, ignorelist, undefined, 1 );
    
    if ( !isdefined( var_d740d9b67690a550[ "entity" ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x3450
// Size: 0x1b7
function getbesttarget( targets )
{
    self endon( "death" );
    bestyaw = undefined;
    besttarget = undefined;
    
    foreach ( targ in targets )
    {
        if ( isdefined( self.turrettarget ) && self.turrettarget == targ )
        {
            continue;
        }
        
        angle = abs( vectortoangles( targ.origin - self.origin )[ 1 ] );
        var_a6f54781e7e6cb25 = abs( self gettagangles( "tag_origin" )[ 1 ] );
        angle = abs( angle - var_a6f54781e7e6cb25 );
        weaponsarray = targ getweaponslistitems();
        
        foreach ( weapon in weaponsarray )
        {
            weaponname = weapon.basename;
            
            if ( issubstr( weaponname, "chargeshot" ) || issubstr( weaponname, "lockon" ) )
            {
                angle -= 40;
            }
        }
        
        if ( distance( self.origin, targ.origin ) > 4000 )
        {
            angle += 40;
        }
        
        if ( !isdefined( bestyaw ) )
        {
            bestyaw = angle;
            besttarget = targ;
            continue;
        }
        
        if ( bestyaw > angle )
        {
            bestyaw = angle;
            besttarget = targ;
        }
    }
    
    return besttarget;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x3610
// Size: 0x112
function handledestroydamage()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        objweapon = mapweapon( objweapon, inflictor );
        
        if ( ( objweapon.basename == "aamissile_projectile_mp" || objweapon.basename == "nuke_mp" ) && meansofdeath == "MOD_EXPLOSIVE" && damage >= self.health )
        {
            callback_vehicledamage( attacker, attacker, 9001, 0, meansofdeath, objweapon, point, direction_vec, point, 0, 0, partname );
        }
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 12
// Checksum 0x0, Offset: 0x372a
// Size: 0x1fc
function callback_vehicledamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname )
{
    if ( isdefined( attacker ) )
    {
        if ( isdefined( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
    }
    
    if ( ( attacker == self || isdefined( attacker.pers ) && attacker.pers[ "team" ] == self.team && !level.friendlyfire && level.teambased ) && attacker != self.owner )
    {
        return;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    damage = getmodifiedantikillstreakdamage( attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5 );
    scripts\mp\killstreaks\killstreaks::killstreakhit( attacker, objweapon, self, meansofdeath, damage );
    attacker updatedamagefeedback( "" );
    scripts\mp\damage::logattackerkillstreak( self, damage, attacker, dir, point, meansofdeath, modelindex, undefined, partname, dflags, getcompleteweaponname( objweapon ) );
    
    if ( self.health <= damage )
    {
        if ( isplayer( attacker ) && ( !isdefined( self.owner ) || attacker != self.owner ) )
        {
            scripts\mp\damage::onkillstreakkilled( "jackal", attacker, objweapon, meansofdeath, damage, "destroyed_jackal", "jackal_destroyed", "callout_destroyed_harrier" );
        }
    }
    
    if ( self.health - damage <= 900 && ( !isdefined( self.smoking ) || !self.smoking ) )
    {
        self.smoking = 1;
    }
    
    self vehicle_finishdamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname );
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 3
// Checksum 0x0, Offset: 0x392e
// Size: 0x54
function getcorrectheight( x, y, rand )
{
    offgroundheight = 600;
    groundheight = tracegroundpoint( x, y );
    trueheight = groundheight + offgroundheight;
    trueheight += randomint( rand );
    return trueheight;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x398b
// Size: 0xde
function playdamageefx()
{
    self endon( "death" );
    stopfxontag( level.harrier_afterburnerfx, self, "tag_engine_left" );
    playfxontag( level.harrier_smoke, self, "tag_engine_left" );
    stopfxontag( level.harrier_afterburnerfx, self, "tag_engine_right" );
    playfxontag( level.harrier_smoke, self, "tag_engine_right" );
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 0.15 );
    stopfxontag( level.harrier_afterburnerfx, self, "tag_engine_left2" );
    playfxontag( level.harrier_smoke, self, "tag_engine_left2" );
    stopfxontag( level.harrier_afterburnerfx, self, "tag_engine_right2" );
    playfxontag( level.harrier_smoke, self, "tag_engine_right2" );
    playfxontag( level.chopper_fx[ "damage" ][ "heavy_smoke" ], self, "tag_engine_left" );
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x3a71
// Size: 0xd1
function jackaldestroyed()
{
    self endon( "jackal_gone" );
    owner = self.owner;
    self waittill( "death" );
    
    if ( isdefined( self.turrettarget ) && isdefined( self.targetoutline ) )
    {
        outlinedisable( self.targetoutline, self.turrettarget );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.owner scripts\mp\utility\lower_message::clearlowermessage( getothermode( self.combatmode ) );
    
    if ( !isdefined( self.largeprojectiledamage ) )
    {
        self vehicle_setspeed( 25, 5 );
        thread jackalcrash( 75 );
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 2.7 );
    }
    
    if ( isdefined( self.lz ) )
    {
        self.lz notify( "extraction_destroyed" );
    }
    
    jackalexplode();
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x3b4a
// Size: 0x5f
function jackalexplode()
{
    self playsound( "dropship_explode_mp" );
    level.jackals[ level.jackals.size - 1 ] = undefined;
    self notify( "explode" );
    
    if ( isdefined( self.lz ) )
    {
        playfxontag( getfx( "jackal_explosion" ), self, "tag_origin" );
    }
    
    wait 0.35;
    thread jackaldelete();
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x3bb1
// Size: 0x72
function jackalcrash( speed )
{
    self endon( "explode" );
    self clearlookatent();
    self notify( "jackal_crashing" );
    self setvehgoalpos( self.origin + ( 0, 0, 100 ), 1 );
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 1.5 );
    self setyawspeed( speed, speed, speed );
    self settargetyaw( self.angles[ 1 ] + speed * 2.5 );
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 3
// Checksum 0x0, Offset: 0x3c2b
// Size: 0x7e
function tracenewpoint( x, y, z )
{
    self endon( "death" );
    self endon( "acquiringTarget" );
    self endon( "leaving" );
    self endon( "randMove" );
    trc = sphere_trace( self.origin, ( x, y, z ), 256, self, undefined, 1 );
    
    if ( trc[ "surfacetype" ] != "surftype_none" )
    {
        return 0;
    }
    
    pathgoal = ( x, y, z );
    return pathgoal;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 2
// Checksum 0x0, Offset: 0x3cb2
// Size: 0x124
function tracegroundpoint( x, y )
{
    self endon( "death" );
    self endon( "acquiringTarget" );
    self endon( "leaving" );
    z = -99999;
    currz = self.origin[ 2 ] + 2000;
    minz = level.averagealliesz;
    ignorelist = [ self ];
    
    if ( isdefined( self.dropcrates ) )
    {
        foreach ( crate in self.dropcrates )
        {
            ignorelist[ ignorelist.size ] = crate;
        }
    }
    
    trc = sphere_trace( ( x, y, currz ), ( x, y, z ), 256, ignorelist, undefined, 1 );
    
    if ( trc[ "position" ][ 2 ] < minz )
    {
        hightrace = minz;
    }
    else
    {
        hightrace = trc[ "position" ][ 2 ];
    }
    
    return hightrace;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x3ddf
// Size: 0x46
function closetogoalcheck( pathgoal )
{
    self endon( "goal" );
    self endon( "death" );
    
    for ( ;; )
    {
        if ( distance2d( self.origin, pathgoal ) < 768 )
        {
            self setmaxpitchroll( 10, 25 );
            break;
        }
        
        wait 0.05;
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x3e2d
// Size: 0x69
function monitorowner()
{
    self endon( "death" );
    self endon( "leaving" );
    
    if ( !isdefined( self.owner ) || self.owner.team != self.team )
    {
        thread jackalexplode();
        return;
    }
    
    self.owner waittill_any_2( "joined_team", "disconnect" );
    jackalexplode();
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 2
// Checksum 0x0, Offset: 0x3e9e
// Size: 0x287
function watchmodechange( msgname, msgstring )
{
    self.owner endon( "disconnect" );
    self endon( "death" );
    self endon( "leaving" );
    level endon( "game_ended" );
    updaterate = level.framedurationseconds;
    
    while ( true )
    {
        self.useobj waittill( "trigger", player );
        
        if ( player != self.owner )
        {
            continue;
        }
        
        if ( self.owner isusingremote() )
        {
            continue;
        }
        
        if ( !self.owner val::get( "usability" ) )
        {
            continue;
        }
        
        if ( istouchingboundstrigger( self.owner ) )
        {
            continue;
        }
        
        timeused = 0;
        
        while ( self.owner usebuttonpressed() )
        {
            timeused += updaterate;
            
            if ( timeused > 0.1 )
            {
                othercombatmode = getothermode( self.combatmode );
                
                if ( othercombatmode == "guard_location" )
                {
                    playerx = self.owner.origin[ 0 ];
                    playery = self.owner.origin[ 1 ];
                    shipz = self.origin[ 2 ];
                    newpos = ( playerx, playery, shipz );
                    contents = create_contents( 0, 1, 1, 1, 1, 1, 0 );
                    
                    if ( !ray_trace_passed( self.origin, newpos, self, contents ) )
                    {
                        self.owner scripts\mp\hud_message::showerrormessage( "KILLSTREAKS/CANNOT_BE_CALLED" );
                        break;
                    }
                }
                
                self.combatmode = othercombatmode;
                self notify( self.combatmode );
                
                if ( self.combatmode == "guard_location" )
                {
                    msgname = "follow_player";
                    msgstring = &"KILLSTREAKS_HINTS_JACKAL_FOLLOW";
                    thread dropship_change_thrust_sfx();
                    thread guardposition();
                }
                else
                {
                    msgname = "guard_location";
                    msgstring = &"KILLSTREAKS_HINTS_JACKAL_GUARD";
                    thread patrolfield();
                    thread dropship_change_thrust_sfx();
                }
                
                self.useobj makeunusable();
                scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 1 );
                self.currentstring = msgstring;
                self.useobj setkillstreakcontrolpriority( self.owner, self.currentstring, 360, 360, 30000, 30000, 2 );
                break;
            }
            
            wait updaterate;
        }
        
        wait updaterate;
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x412d
// Size: 0x1a
function dropship_change_thrust_sfx()
{
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 0.3 );
    self playsoundonmovingent( "dropship_killstreak_thrust_change" );
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x414f
// Size: 0x27
function getothermode( mode )
{
    if ( mode == "follow_player" )
    {
        mode = "guard_location";
    }
    else
    {
        mode = "follow_player";
    }
    
    return mode;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 2
// Checksum 0x0, Offset: 0x417f
// Size: 0x45
function looptriggeredeffect( effect, missile )
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        triggerfx( effect );
        wait 0.05;
        
        if ( !isdefined( missile ) || !isdefined( effect ) )
        {
            break;
        }
    }
    
    if ( isdefined( effect ) )
    {
        effect delete();
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 2
// Checksum 0x0, Offset: 0x41cc
// Size: 0x347
function attacklasedtarget( targpoint, lastmissile )
{
    finaltargetent = undefined;
    midtargetent = undefined;
    upquantity = 6000;
    upvector = ( 0, 0, upquantity );
    backdist = 3000;
    forward = anglestoforward( self.angles );
    ownerorigin = self.origin;
    startpos = ownerorigin + upvector + forward * backdist * -1;
    ignorelist = [ self ];
    var_2a224218e7468e4a = 0;
    skytrace = ray_trace( targpoint + ( 0, 0, upquantity ), targpoint );
    
    if ( skytrace[ "fraction" ] > 0.99 )
    {
        var_2a224218e7468e4a = 1;
        startpos = targpoint + ( 0, 0, upquantity );
    }
    
    if ( !var_2a224218e7468e4a )
    {
        skytrace = ray_trace( targpoint + ( 300, 0, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            var_2a224218e7468e4a = 1;
            startpos = targpoint + ( 300, 0, upquantity );
        }
    }
    
    if ( !var_2a224218e7468e4a )
    {
        skytrace = ray_trace( targpoint + ( 0, 300, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            var_2a224218e7468e4a = 1;
            startpos = targpoint + ( 0, 300, upquantity );
        }
    }
    
    if ( !var_2a224218e7468e4a )
    {
        skytrace = ray_trace( targpoint + ( 0, -300, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            var_2a224218e7468e4a = 1;
            startpos = targpoint + ( 0, -300, upquantity );
        }
    }
    
    if ( !var_2a224218e7468e4a )
    {
        skytrace = ray_trace( targpoint + ( 300, 300, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            var_2a224218e7468e4a = 1;
            startpos = targpoint + ( 300, 300, upquantity );
        }
    }
    
    if ( !var_2a224218e7468e4a )
    {
        skytrace = ray_trace( targpoint + ( -300, 0, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            var_2a224218e7468e4a = 1;
            startpos = targpoint + ( -300, 0, upquantity );
        }
    }
    
    if ( !var_2a224218e7468e4a )
    {
        skytrace = ray_trace( targpoint + ( -300, -300, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            var_2a224218e7468e4a = 1;
            startpos = targpoint + ( -300, -300, upquantity );
        }
    }
    
    if ( !var_2a224218e7468e4a )
    {
        skytrace = ray_trace( targpoint + ( 300, -300, upquantity ), targpoint );
        
        if ( skytrace[ "fraction" ] > 0.99 )
        {
            var_2a224218e7468e4a = 1;
            startpos = targpoint + ( 300, -300, upquantity );
        }
    }
    
    if ( !var_2a224218e7468e4a )
    {
        for ( i = 0; i < 5 ; i++ )
        {
            upquantity /= 2;
            upvector = ( 0, 0, upquantity );
            startpos = ownerorigin + upvector + forward * backdist * -1;
            var_981de761dfbb8f8b = ray_trace( targpoint, startpos, ignorelist );
            
            if ( var_981de761dfbb8f8b[ "fraction" ] > 0.99 )
            {
                var_2a224218e7468e4a = 1;
                break;
            }
            
            wait 0.05;
        }
    }
    
    if ( !var_2a224218e7468e4a )
    {
        for ( i = 0; i < 5 ; i++ )
        {
            upquantity *= 2.5;
            upvector = ( 0, 0, upquantity );
            startpos = ownerorigin + upvector + forward * backdist * -1;
            var_981de761dfbb8f8b = ray_trace( targpoint, startpos, ignorelist );
            
            if ( var_981de761dfbb8f8b[ "fraction" ] > 0.99 )
            {
                var_2a224218e7468e4a = 1;
                break;
            }
            
            wait 0.05;
        }
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x451b
// Size: 0x5f
function playlocksound()
{
    if ( isdefined( self.playinglocksound ) && self.playinglocksound )
    {
        return;
    }
    
    play_loopsound_in_space( "javelin_clu_lock", self.origin );
    self.playinglocksound = 1;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 0.75 );
    self stoploopsound( "javelin_clu_lock" );
    self.playinglocksound = 0;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x4582
// Size: 0x56
function playlockerrorsound()
{
    if ( isdefined( self.playinglocksound ) && self.playinglocksound )
    {
        return;
    }
    
    self playlocalsound( "javelin_clu_aquiring_lock" );
    self.playinglocksound = 1;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 0.75 );
    self stoplocalsound( "javelin_clu_aquiring_lock" );
    self.playinglocksound = 0;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x45e0
// Size: 0x53
function beginevasivemaneuvers()
{
    self endon( "death" );
    self notify( "begin_evasive_maneuvers" );
    self endon( "begin_evasive_maneuvers" );
    self.evasivemaneuvers = 1;
    result = waittill_any_timeout_1( 3, "death" );
    
    if ( result == "timeout" )
    {
        self.evasivemaneuvers = 0;
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x463b
// Size: 0xdc
function watchguardevadedamage()
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "following_player" );
    
    while ( true )
    {
        newpos = undefined;
        
        if ( istrue( self.evasivemaneuvers ) )
        {
            playerx = self.owner.origin[ 0 ];
            playery = self.owner.origin[ 1 ];
            newx = playerx + randomintrange( -500, 500 );
            newy = playery + randomintrange( -500, 500 );
            properz = getcorrectheight( newx, newy, 350 );
            newpos = ( newx, newy, properz );
        }
        
        if ( isdefined( newpos ) )
        {
            self setvehgoalpos( newpos, 1 );
        }
        
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 0.1 );
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 1
// Checksum 0x0, Offset: 0x471f
// Size: 0x39
function watchdropcratesearly( marker )
{
    self endon( "dropped_crates" );
    var_2e0d8ba0a46ce1b1 = self.dropcrates;
    self waittill( "death" );
    thread dropcrates( var_2e0d8ba0a46ce1b1, marker );
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 2
// Checksum 0x0, Offset: 0x4760
// Size: 0x29
function dropcrates( var_2e0d8ba0a46ce1b1, marker )
{
    assertmsg( "<dev string:x1c>" );
    self notify( "dropped_crates" );
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 2
// Checksum 0x0, Offset: 0x4791
// Size: 0x2e
function watchforcapture( jackal, index )
{
    waittill_any_2( "captured", "death" );
    jackal notify( "crate_captured_" + index );
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 0
// Checksum 0x0, Offset: 0x47c7
// Size: 0x58
function watchjackalcratepickup()
{
    self endon( "death" );
    self endon( "leaving" );
    cratecounter = 0;
    
    while ( true )
    {
        waittill_any_3( "crate_captured_0", "crate_captured_1", "crate_captured_2" );
        cratecounter++;
        
        if ( cratecounter == self.dropcrates.size )
        {
            self notify( "all_crates_gone" );
            break;
        }
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 6
// Checksum 0x0, Offset: 0x4827
// Size: 0xd1
function beginjackalescort( lifeid, startpoint, pos, streakinfo, tacopslz, approachvector )
{
    if ( !isdefined( level.jackals ) )
    {
        level.jackals = [];
    }
    
    marker = undefined;
    self notify( "called_in_jackal" );
    heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
    pos *= ( 1, 1, 0 );
    trueheight = 1000;
    pathgoal = pos + ( 0, 0, trueheight );
    jackal = spawnksjackal( lifeid, self, startpoint, pathgoal, streakinfo, tacopslz );
    jackal.pathgoal = pathgoal;
    thread defendlocationescort( jackal, marker );
    return jackal;
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 2
// Checksum 0x0, Offset: 0x4901
// Size: 0xb2
function defendlocationescort( jackal, marker )
{
    jackal endon( "death" );
    assert( isdefined( jackal ) );
    jackal setvehgoalpos( jackal.pathgoal, 1 );
    jackal playsoundonmovingent( "dropship_killstreak_thrust_change" );
    jackal thread closetogoalcheck( jackal.pathgoal );
    jackal thread monitorowner();
    jackal waittill( "goal" );
    jackal thread watchgameendleave();
    jackal thread engageprimarytarget();
    jackal thread engagesecondarytarget();
    jackal vehicle_setspeed( int( jackal.speed / 14 ), int( jackal.accel / 16 ) );
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 3
// Checksum 0x0, Offset: 0x49bb
// Size: 0x158
function guardpositionescort( position, lookat, offgroundheight )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "follow_player" );
    self endon( "jackal_crashing" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner endon( "disconnect" );
    }
    
    self vehicle_setspeed( int( self.speed / 14 ), int( self.accel / 16 ) );
    
    if ( isdefined( lookat ) )
    {
        self setlookatent( lookat );
    }
    
    if ( isdefined( position ) )
    {
        newpos = undefined;
        playerx = position[ 0 ];
        playery = position[ 1 ];
        
        if ( istrue( self.evasivemaneuvers ) )
        {
            newx = playerx + randomintrange( -500, 500 );
            newy = playery + randomintrange( -500, 500 );
            properz = getcorrectheightescort( newx, newy, 350, offgroundheight );
            newpos = ( newx, newy, properz );
        }
        else
        {
            properz = getcorrectheightescort( playerx, playery, 20, offgroundheight );
            newpos = ( playerx, playery, properz );
        }
        
        self setvehgoalpos( newpos, 1 );
        self.lastaction = "following_player";
        waittill_any_2( "goal", "begin_evasive_maneuvers" );
        self clearlookatent();
    }
}

// Namespace jackal / scripts\mp\killstreaks\jackal
// Params 4
// Checksum 0x0, Offset: 0x4b1b
// Size: 0x64
function getcorrectheightescort( x, y, rand, minheight )
{
    offgroundheight = 200;
    
    if ( isdefined( minheight ) )
    {
        offgroundheight = minheight;
    }
    
    groundheight = tracegroundpoint( x, y );
    trueheight = groundheight + offgroundheight;
    trueheight += randomint( rand );
    return trueheight;
}

