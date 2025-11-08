#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\flares;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;

#namespace helicopter;

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x804
// Size: 0x48
function init()
{
    level._effect[ "vehicle_flares" ] = loadfx( "vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx" );
    level._effect[ "jet_flares" ] = loadfx( "vfx/iw8_mp/killstreak/vfx_harrier_angel_flares.vfx" );
    
    if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        level thread getaveragelowspawnpoint();
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x854
// Size: 0xaa
function getaveragelowspawnpoint()
{
    spawnpoints = scripts\mp\spawnlogic::function_32d25b070a9516de( getspawnarray( "mp_tdm_spawn_allies_start" ) );
    count = 0;
    totalz = 0;
    
    foreach ( point in spawnpoints )
    {
        count++;
        totalz += point.origin[ 2 ];
    }
    
    if ( count > 0 )
    {
        level.averagealliesz = totalz / count;
        return;
    }
    
    level.averagealliesz = 0;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 3
// Checksum 0x0, Offset: 0x906
// Size: 0x46
function makehelitype( helitype, deathfx, lightfxfunc )
{
    level.chopper_fx[ "explode" ][ "death" ][ helitype ] = loadfx( deathfx );
    level.lightfxfunc[ helitype ] = lightfxfunc;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 2
// Checksum 0x0, Offset: 0x954
// Size: 0x31
function addairexplosion( helitype, explodefx )
{
    level.chopper_fx[ "explode" ][ "air_death" ][ helitype ] = loadfx( explodefx );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x98d
// Size: 0x98
function defaultlightfx()
{
    playfxontag( level.chopper_fx[ "light" ][ "left" ], self, "tag_light_L_wing" );
    wait 0.05;
    playfxontag( level.chopper_fx[ "light" ][ "right" ], self, "tag_light_R_wing" );
    wait 0.05;
    playfxontag( level.chopper_fx[ "light" ][ "belly" ], self, "tag_light_belly" );
    wait 0.05;
    playfxontag( level.chopper_fx[ "light" ][ "tail" ], self, "tag_light_tail" );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 2
// Checksum 0x0, Offset: 0xa2d
// Size: 0x1f
function usehelicopter( lifeid, streakname )
{
    return tryusehelicopter( lifeid, "helicopter" );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 2
// Checksum 0x0, Offset: 0xa55
// Size: 0x149, Type: bool
function tryusehelicopter( lifeid, helitype )
{
    var_4440147083abaf0a = 1;
    
    if ( isdefined( level.chopper ) )
    {
        shouldqueue = 1;
    }
    else
    {
        shouldqueue = 0;
    }
    
    if ( isdefined( level.chopper ) && shouldqueue )
    {
        self iprintlnbold( &"KILLSTREAKS_HELI_IN_QUEUE" );
        
        if ( isdefined( helitype ) && helitype != "helicopter" )
        {
            streakname = "helicopter_" + helitype;
        }
        else
        {
            streakname = "helicopter";
        }
        
        queueent = spawn( "script_origin", ( 0, 0, 0 ) );
        queueent hide();
        queueent thread deleteonentnotify( self, "disconnect" );
        queueent.player = self;
        queueent.lifeid = lifeid;
        queueent.helitype = helitype;
        queueent.streakname = streakname;
        queueadd( "helicopter", queueent );
        return false;
    }
    else if ( currentactivevehiclecount() >= maxvehiclesallowed() || level.fauxvehiclecount + var_4440147083abaf0a >= maxvehiclesallowed() )
    {
        self iprintlnbold( &"KILLSTREAKS/TOO_MANY_VEHICLES" );
        return false;
    }
    
    var_4440147083abaf0a = 1;
    starthelicopter( lifeid, helitype );
    return true;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 2
// Checksum 0x0, Offset: 0xba7
// Size: 0x25
function deleteonentnotify( ent, notifystring )
{
    self endon( "death" );
    ent waittill( notifystring );
    self delete();
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 2
// Checksum 0x0, Offset: 0xbd4
// Size: 0xab
function starthelicopter( lifeid, helitype )
{
    incrementfauxvehiclecount();
    startnode = undefined;
    
    if ( !isdefined( helitype ) )
    {
        helitype = "";
    }
    
    eventtype = "helicopter";
    team = self.pers[ "team" ];
    startnode = level.heli_start_nodes[ randomint( level.heli_start_nodes.size ) ];
    utility::trycall( level.matchdata_logkillstreakevent, eventtype, self.origin );
    thread heli_think( lifeid, self, startnode, self.pers[ "team" ], helitype );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0xc87
// Size: 0x146
function precachehelicoptersounds()
{
    level.heli_sound[ "allies" ][ "hit" ] = "veh_chopper_support_hit";
    level.heli_sound[ "allies" ][ "hitsecondary" ] = "cobra_helicopter_secondary_exp";
    level.heli_sound[ "allies" ][ "spinloop" ] = "cobra_helicopter_dying_loop";
    level.heli_sound[ "allies" ][ "spinstart" ] = "cobra_helicopter_dying_layer";
    level.heli_sound[ "allies" ][ "crash" ] = "exp_helicopter_fuel";
    level.heli_sound[ "allies" ][ "missilefire" ] = "weap_cobra_missile_fire";
    level.heli_sound[ "axis" ][ "hit" ] = "veh_chopper_support_hit";
    level.heli_sound[ "axis" ][ "hitsecondary" ] = "cobra_helicopter_secondary_exp";
    level.heli_sound[ "axis" ][ "spinloop" ] = "cobra_helicopter_dying_loop";
    level.heli_sound[ "axis" ][ "spinstart" ] = "cobra_helicopter_dying_layer";
    level.heli_sound[ "axis" ][ "crash" ] = "exp_helicopter_fuel";
    level.heli_sound[ "axis" ][ "missilefire" ] = "weap_cobra_missile_fire";
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0xdd5
// Size: 0x2b
function heli_getteamforsoundclip()
{
    teamname = self.team;
    
    if ( level.multiteambased )
    {
        teamname = "axis";
    }
    
    return teamname;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 5
// Checksum 0x0, Offset: 0xe09
// Size: 0xf6
function spawn_helicopter( owner, origin, angles, vehicletype, modelname )
{
    chopper = spawnhelicopter( owner, origin, angles, vehicletype, modelname );
    
    if ( !isdefined( chopper ) )
    {
        return undefined;
    }
    
    if ( modelname == "vehicle_battle_hind" )
    {
        chopper.heli_type = "cobra";
    }
    else
    {
        chopper.heli_type = level.heli_types[ modelname ];
    }
    
    chopper thread [[ level.lightfxfunc[ chopper.heli_type ] ]]();
    chopper addtohelilist( chopper getentitynumber() );
    chopper.zoffset = ( 0, 0, chopper gettagorigin( "tag_origin" )[ 2 ] - chopper gettagorigin( "tag_ground" )[ 2 ] );
    chopper.attractor = missile_createattractorent( chopper, level.heli_attract_strength, level.heli_attract_range );
    return chopper;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0xf08
// Size: 0x8d
function helidialog( dialoggroup )
{
    if ( gettime() - level.lasthelidialogtime < 6000 )
    {
        return;
    }
    
    level.lasthelidialogtime = gettime();
    randomindex = randomint( level.helidialog[ dialoggroup ].size );
    soundalias = level.helidialog[ dialoggroup ][ randomindex ];
    fullsoundalias = getteamvoiceinfix( self.team ) + "tl" + soundalias;
    self playlocalsound( fullsoundalias );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0xf9d
// Size: 0x2a6
function updateareanodes( areanodes )
{
    validenemies = [];
    
    foreach ( node in areanodes )
    {
        node.validplayers = [];
        node.nodescore = 0;
    }
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player.team == self.team )
        {
            continue;
        }
        
        foreach ( node in areanodes )
        {
            if ( distancesquared( player.origin, node.origin ) > 1048576 )
            {
                continue;
            }
            
            node.validplayers[ node.validplayers.size ] = player;
        }
    }
    
    bestnode = areanodes[ 0 ];
    
    foreach ( node in areanodes )
    {
        helinode = getent( node.target, "targetname" );
        
        foreach ( player in node.validplayers )
        {
            node.nodescore += 1;
            
            if ( scripts\engine\trace::_bullet_trace_passed( player.origin + ( 0, 0, 32 ), helinode.origin, 0, player ) )
            {
                node.nodescore += 3;
            }
        }
        
        if ( node.nodescore > bestnode.nodescore )
        {
            bestnode = node;
        }
    }
    
    return getent( bestnode.target, "targetname" );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 5
// Checksum 0x0, Offset: 0x124c
// Size: 0x288
function heli_think( lifeid, owner, startnode, heli_team, helitype )
{
    heliorigin = startnode.origin;
    heliangles = startnode.angles;
    vehicletype = "cobra_mp";
    vehiclemodel = "vehicle_battle_hind";
    chopper = spawn_helicopter( owner, heliorigin, heliangles, vehicletype, vehiclemodel );
    
    if ( !isdefined( chopper ) )
    {
        return;
    }
    
    level.chopper = chopper;
    
    if ( heli_team == "allies" )
    {
        level.allieschopper = chopper;
    }
    else
    {
        level.axischopper = chopper;
    }
    
    chopper.helitype = helitype;
    chopper.lifeid = lifeid;
    chopper.team = heli_team;
    chopper.pers[ "team" ] = heli_team;
    chopper.owner = owner;
    chopper setotherent( owner );
    chopper.startnode = startnode;
    chopper.maxhealth = level.heli_maxhealth;
    chopper.targeting_delay = level.heli_targeting_delay;
    chopper.primarytarget = undefined;
    chopper.secondarytarget = undefined;
    chopper.attacker = undefined;
    chopper.currentstate = "ok";
    chopper scripts\mp\sentientpoolmanager::registersentient( "Killstreak_Air", owner );
    chopper.empgrenaded = 0;
    
    if ( helitype == "flares" || helitype == "minigun" )
    {
        chopper thread scripts\mp\killstreaks\flares::flares_monitor( 1 );
    }
    
    chopper thread heli_leave_on_disconnect( owner );
    chopper thread heli_leave_on_changeteams( owner );
    chopper thread heli_leave_on_gameended( owner );
    chopper thread heli_damage_monitor( helitype );
    chopper thread heli_watchempdamage();
    chopper thread heli_watchdeath();
    chopper thread heli_existance();
    chopper endon( "helicopter_done" );
    chopper endon( "crashing" );
    chopper endon( "leaving" );
    chopper endon( "death" );
    attackareas = getentarray( "heli_attack_area", "targetname" );
    loopnode = undefined;
    loopnode = level.heli_loop_nodes[ randomint( level.heli_loop_nodes.size ) ];
    chopper heli_fly_simple_path( startnode );
    chopper thread heli_targeting();
    chopper thread heli_leave_on_timeout( 60 );
    chopper thread heli_fly_loop_path( loopnode );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x14dc
// Size: 0x10b
function heli_existance()
{
    entitynumber = self getentitynumber();
    waittill_any_3( "death", "crashing", "leaving" );
    removefromhelilist( entitynumber );
    self notify( "helicopter_done" );
    self notify( "helicopter_removed" );
    player = undefined;
    queueent = queueremovefirst( "helicopter" );
    
    if ( !isdefined( queueent ) )
    {
        level.chopper = undefined;
        return;
    }
    
    player = queueent.player;
    lifeid = queueent.lifeid;
    streakname = queueent.streakname;
    helitype = queueent.helitype;
    queueent delete();
    
    if ( isdefined( player ) && ( player.sessionstate == "playing" || player.sessionstate == "dead" ) )
    {
        player starthelicopter( lifeid, helitype );
        return;
    }
    
    level.chopper = undefined;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x15ef
// Size: 0x106
function heli_targeting()
{
    self notify( "heli_targeting" );
    self endon( "heli_targeting" );
    self endon( "death" );
    self endon( "helicopter_done" );
    
    for ( ;; )
    {
        targets = [];
        self.primarytarget = undefined;
        self.secondarytarget = undefined;
        
        foreach ( player in level.characters )
        {
            wait 0.05;
            
            if ( !cantarget_turret( player ) )
            {
                continue;
            }
            
            targets[ targets.size ] = player;
        }
        
        if ( targets.size )
        {
            for ( targetplayer = getbestprimarytarget( targets ); !isdefined( targetplayer ) ; targetplayer = getbestprimarytarget( targets ) )
            {
                waitframe();
            }
            
            self.primarytarget = targetplayer;
            self notify( "primary acquired" );
        }
        
        if ( isdefined( self.primarytarget ) )
        {
            fireontarget( self.primarytarget );
            continue;
        }
        
        wait 0.25;
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x16fd
// Size: 0x126
function cantarget_turret( player )
{
    cantarget = 1;
    
    if ( !isalive( player ) || isdefined( player.sessionstate ) && player.sessionstate != "playing" )
    {
        return 0;
    }
    
    if ( distance( player.origin, self.origin ) > level.heli_visual_range )
    {
        return 0;
    }
    
    if ( !self.owner scripts\cp_mp\utility\player_utility::isenemy( player ) )
    {
        return 0;
    }
    
    if ( isdefined( player.spawntime ) && ( gettime() - player.spawntime ) / 1000 <= 5 )
    {
        return 0;
    }
    
    if ( player _hasperk( "specialty_blindeye" ) )
    {
        return 0;
    }
    
    heli_centroid = self.origin + ( 0, 0, -160 );
    heli_forward_norm = anglestoforward( self.angles );
    heli_turret_point = heli_centroid + 144 * heli_forward_norm;
    
    if ( player sightconetrace( heli_turret_point, self ) < level.heli_target_recognition )
    {
        return 0;
    }
    
    return cantarget;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x182c
// Size: 0x27d
function getbestprimarytarget( targets )
{
    foreach ( player in targets )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        update_player_threat( player );
    }
    
    highest = 0;
    primarytarget = undefined;
    corners = getentarray( "minimap_corner", "targetname" );
    
    foreach ( player in targets )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        assertex( isdefined( player.threatlevel ), "<dev string:x1c>" );
        
        if ( corners.size == 2 )
        {
            min = corners[ 0 ].origin;
            max = corners[ 0 ].origin;
            
            if ( corners[ 1 ].origin[ 0 ] > max[ 0 ] )
            {
                max = ( corners[ 1 ].origin[ 0 ], max[ 1 ], max[ 2 ] );
            }
            else
            {
                min = ( corners[ 1 ].origin[ 0 ], min[ 1 ], min[ 2 ] );
            }
            
            if ( corners[ 1 ].origin[ 1 ] > max[ 1 ] )
            {
                max = ( max[ 0 ], corners[ 1 ].origin[ 1 ], max[ 2 ] );
            }
            else
            {
                min = ( min[ 0 ], corners[ 1 ].origin[ 1 ], min[ 2 ] );
            }
            
            if ( player.origin[ 0 ] < min[ 0 ] || player.origin[ 0 ] > max[ 0 ] || player.origin[ 1 ] < min[ 1 ] || player.origin[ 1 ] > max[ 1 ] )
            {
                continue;
            }
        }
        
        if ( player.threatlevel < highest )
        {
            continue;
        }
        
        if ( !scripts\engine\trace::_bullet_trace_passed( player.origin + ( 0, 0, 32 ), self.origin, 0, self ) )
        {
            wait 0.05;
            continue;
        }
        
        highest = player.threatlevel;
        primarytarget = player;
    }
    
    return primarytarget;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x1ab2
// Size: 0x122
function update_player_threat( player )
{
    player.threatlevel = 0;
    dist = distance( player.origin, self.origin );
    player.threatlevel += ( level.heli_visual_range - dist ) / level.heli_visual_range * 100;
    
    if ( isdefined( self.attacker ) && player == self.attacker )
    {
        player.threatlevel += 100;
    }
    
    if ( isplayer( player ) )
    {
        player.threatlevel += player.score * 4;
    }
    
    if ( isdefined( player.antithreat ) )
    {
        player.threatlevel -= player.antithreat;
    }
    
    if ( player.threatlevel <= 0 )
    {
        player.threatlevel = 1;
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x1bdc
// Size: 0x49
function heli_reset()
{
    self cleartargetyaw();
    self cleargoalyaw();
    self vehicle_setspeed( 80, 35 );
    self setyawspeed( 75, 45, 45 );
    self setmaxpitchroll( 30, 30 );
    self setneargoalnotifydist( 256 );
    self setturningability( 0.9 );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x1c2d
// Size: 0x40
function addrecentdamage( damage )
{
    self endon( "death" );
    self.recentdamageamount += damage;
    wait 4;
    self.recentdamageamount -= damage;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x1c75
// Size: 0xfe
function modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    modifieddamage = damage;
    divisorlrg = 2;
    divisormed = 3;
    divisorlow = 4;
    
    if ( isdefined( self.helitype ) && self.helitype == "dronedrop" )
    {
        divisorlrg = 1;
        divisormed = 1;
        divisorlow = 2;
    }
    
    modifieddamage = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage( attacker, objweapon, type, modifieddamage, self.maxhealth, divisorlrg, divisormed, divisorlow );
    thread addrecentdamage( modifieddamage );
    self notify( "heli_damage_fx" );
    return modifieddamage;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x1d7c
// Size: 0xf0
function handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    
    if ( isdefined( attacker ) )
    {
        config = level.heliconfigs[ self.streakname ];
        notifyattacker = scripts\mp\damage::onkillstreakkilled( self.streakname, attacker, objweapon, type, damage, config.scorepopup, config.destroyedvo, config.callout );
        
        if ( notifyattacker )
        {
            attacker notify( "destroyed_helicopter" );
            self.killingattacker = attacker;
        }
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 3
// Checksum 0x0, Offset: 0x1e74
// Size: 0x6c
function heli_damage_monitor( type, shouldrumble, var_a39ff9e13bbc6340 )
{
    self endon( "crashing" );
    self endon( "leaving" );
    self.streakname = type;
    self.recentdamageamount = 0;
    
    if ( !istrue( var_a39ff9e13bbc6340 ) )
    {
        thread heli_health();
    }
    
    scripts\mp\damage::monitordamage( self.maxhealth, "helicopter", &handledeathdamage, &modifydamage, 1, shouldrumble );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x1ee8
// Size: 0xde
function heli_watchempdamage()
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "emp_damage", attacker, duration );
        self.empgrenaded = 1;
        
        if ( isdefined( self.mgturretleft ) )
        {
            self.mgturretleft notify( "stop_shooting" );
        }
        
        if ( isdefined( self.mgturretright ) )
        {
            self.mgturretright notify( "stop_shooting" );
        }
        
        wait duration;
        self.empgrenaded = 0;
        
        if ( isdefined( self.mgturretleft ) )
        {
            self.mgturretleft notify( "turretstatechange" );
        }
        
        if ( isdefined( self.mgturretright ) )
        {
            self.mgturretright notify( "turretstatechange" );
        }
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x1fce
// Size: 0x1c9
function heli_health()
{
    self endon( "leaving" );
    self endon( "crashing" );
    self.currentstate = "ok";
    self.laststate = "ok";
    self setdamagestage( 3 );
    damagestate = 3;
    self setdamagestage( damagestate );
    config = level.heliconfigs[ self.streakname ];
    
    while ( true )
    {
        self waittill( "heli_damage_fx" );
        
        if ( damagestate > 0 && self.damagetaken >= self.maxhealth )
        {
            damagestate = 0;
            self setdamagestage( damagestate );
            stopfxontag( level.chopper_fx[ "damage" ][ "heavy_smoke" ], self, config.enginevfxtag );
            self notify( "death" );
            break;
        }
        
        if ( damagestate > 1 && self.damagetaken >= self.maxhealth * 0.66 )
        {
            damagestate = 1;
            self setdamagestage( damagestate );
            self.currentstate = "heavy smoke";
            stopfxontag( level.chopper_fx[ "damage" ][ "light_smoke" ], self, config.enginevfxtag );
            playfxontag( level.chopper_fx[ "damage" ][ "heavy_smoke" ], self, config.enginevfxtag );
            continue;
        }
        
        if ( damagestate > 2 && self.damagetaken >= self.maxhealth * 0.33 )
        {
            damagestate = 2;
            self setdamagestage( damagestate );
            self.currentstate = "light smoke";
            playfxontag( level.chopper_fx[ "damage" ][ "light_smoke" ], self, config.enginevfxtag );
        }
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x219f
// Size: 0x8d
function heli_watchdeath()
{
    level endon( "game_ended" );
    self endon( "gone" );
    self waittill( "death" );
    
    if ( isdefined( self.largeprojectiledamage ) && self.largeprojectiledamage )
    {
        thread heli_explode( 1 );
        return;
    }
    
    config = level.heliconfigs[ self.streakname ];
    playfxontag( level.chopper_fx[ "damage" ][ "on_fire" ], self, config.enginevfxtag );
    thread heli_crash();
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x2234
// Size: 0x92
function heli_crash()
{
    self notify( "crashing" );
    self clearlookatent();
    crashnode = level.heli_crash_nodes[ randomint( level.heli_crash_nodes.size ) ];
    
    if ( isdefined( self.mgturretleft ) )
    {
        self.mgturretleft notify( "stop_shooting" );
    }
    
    if ( isdefined( self.mgturretright ) )
    {
        self.mgturretright notify( "stop_shooting" );
    }
    
    thread heli_spin( 180 );
    thread heli_secondary_explosions();
    heli_fly_simple_path( crashnode );
    thread heli_explode();
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x22ce
// Size: 0xbb
function heli_secondary_explosions()
{
    teamname = heli_getteamforsoundclip();
    config = level.heliconfigs[ self.streakname ];
    playfxontag( level.chopper_fx[ "explode" ][ "large" ], self, config.enginevfxtag );
    self playsound( level.heli_sound[ teamname ][ "hitsecondary" ] );
    wait 3;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    playfxontag( level.chopper_fx[ "explode" ][ "large" ], self, config.enginevfxtag );
    self playsound( level.heli_sound[ teamname ][ "hitsecondary" ] );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x2391
// Size: 0x74
function heli_spin( speed )
{
    self endon( "death" );
    teamname = heli_getteamforsoundclip();
    self playsound( level.heli_sound[ teamname ][ "hit" ] );
    thread spinsoundshortly();
    self setyawspeed( speed, speed, speed );
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] + speed * 0.9 );
        wait 1;
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x240d
// Size: 0x64
function spinsoundshortly()
{
    self endon( "death" );
    wait 0.25;
    teamname = heli_getteamforsoundclip();
    self stoploopsound();
    wait 0.05;
    self playloopsound( level.heli_sound[ teamname ][ "spinloop" ] );
    wait 0.05;
    self playloopsound( level.heli_sound[ teamname ][ "spinstart" ] );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x2479
// Size: 0x14a
function heli_explode( altstyle )
{
    self notify( "death" );
    
    if ( isdefined( altstyle ) && isdefined( level.chopper_fx[ "explode" ][ "air_death" ][ self.heli_type ] ) )
    {
        deathangles = self gettagangles( "tag_deathfx" );
        playfx( level.chopper_fx[ "explode" ][ "air_death" ][ self.heli_type ], self gettagorigin( "tag_deathfx" ), anglestoforward( deathangles ), anglestoup( deathangles ) );
    }
    else
    {
        org = self.origin;
        forward = self.origin + ( 0, 0, 1 ) - self.origin;
        playfx( level.chopper_fx[ "explode" ][ "death" ][ self.heli_type ], org, forward );
    }
    
    teamname = heli_getteamforsoundclip();
    self playsound( level.heli_sound[ teamname ][ "crash" ] );
    waitframe();
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    decrementfauxvehiclecount();
    self delete();
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x25cb
// Size: 0x61, Type: bool
function check_owner()
{
    if ( !isdefined( self.owner ) || !isdefined( self.owner.pers[ "team" ] ) || self.owner.pers[ "team" ] != self.team )
    {
        thread heli_leave();
        return false;
    }
    
    return true;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x2635
// Size: 0x29
function heli_leave_on_disconnect( owner )
{
    self endon( "death" );
    self endon( "helicopter_done" );
    owner waittill( "disconnect" );
    thread heli_leave();
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x2666
// Size: 0x33
function heli_leave_on_changeteams( owner )
{
    self endon( "death" );
    self endon( "helicopter_done" );
    owner waittill_any_2( "joined_team", "joined_spectators" );
    thread heli_leave();
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x26a1
// Size: 0x29
function heli_leave_on_spawned( owner )
{
    self endon( "death" );
    self endon( "helicopter_done" );
    owner waittill( "spawned" );
    thread heli_leave();
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x26d2
// Size: 0x29
function heli_leave_on_gameended( owner )
{
    self endon( "death" );
    self endon( "helicopter_done" );
    level waittill( "game_ended" );
    thread heli_leave();
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x2703
// Size: 0x29
function heli_leave_on_timeout( timeout )
{
    self endon( "death" );
    self endon( "helicopter_done" );
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( timeout );
    thread heli_leave();
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x2734
// Size: 0x366
function fireontarget( targetplayer )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    var_f8819918db5085ef = 15;
    loopscount = 0;
    totalheight = 0;
    
    foreach ( node in level.heli_loop_nodes )
    {
        loopscount++;
        totalheight += node.origin[ 2 ];
    }
    
    var_9b53fc8fa63d4127 = totalheight / loopscount;
    self notify( "newTarget" );
    
    if ( isdefined( self.secondarytarget ) && self.secondarytarget.damagetaken < self.secondarytarget.maxhealth )
    {
        return;
    }
    
    if ( isdefined( self.isperformingmaneuver ) && self.isperformingmaneuver )
    {
        return;
    }
    
    currenttarget = self.primarytarget;
    currenttarget.antithreat = 0;
    var_bbe89bb08d4aaa08 = self.primarytarget.origin * ( 1, 1, 0 );
    var_4bb61811b9080546 = self.origin * ( 0, 0, 1 );
    var_2a530280d4341a8a = var_bbe89bb08d4aaa08 + var_4bb61811b9080546;
    targetdistance2d = distance2d( self.origin, currenttarget.origin );
    
    if ( targetdistance2d < 1000 )
    {
        var_f8819918db5085ef = 600;
    }
    
    var_4a05b5b6307a4629 = anglestoforward( currenttarget.angles );
    var_4a05b5b6307a4629 *= ( 1, 1, 0 );
    moveIntoPosition = var_2a530280d4341a8a + var_f8819918db5085ef * var_4a05b5b6307a4629;
    attackvector = moveIntoPosition - var_2a530280d4341a8a;
    attackangle = vectortoangles( attackvector );
    attackangle *= ( 1, 1, 0 );
    thread attackgroundtarget( currenttarget );
    self vehicle_setspeed( 80 );
    
    if ( distance2d( self.origin, moveIntoPosition ) < 1000 )
    {
        moveIntoPosition *= 1.5;
    }
    
    moveIntoPosition *= ( 1, 1, 0 );
    moveIntoPosition += ( 0, 0, var_9b53fc8fa63d4127 );
    _setvehgoalpos( moveIntoPosition, 1, 1 );
    self waittill( "near_goal" );
    
    if ( !isdefined( currenttarget ) || !isalive( currenttarget ) )
    {
        return;
    }
    
    self setlookatent( currenttarget );
    thread isfacing( 10, currenttarget );
    waittill_any_timeout_1( 4, "facing" );
    
    if ( !isdefined( currenttarget ) || !isalive( currenttarget ) )
    {
        return;
    }
    
    self clearlookatent();
    var_1969616b8d0c188c = var_2a530280d4341a8a + var_f8819918db5085ef * anglestoforward( attackangle );
    self setmaxpitchroll( 40, 30 );
    _setvehgoalpos( var_1969616b8d0c188c, 1, 1 );
    self setmaxpitchroll( 30, 30 );
    
    if ( isdefined( currenttarget ) && isalive( currenttarget ) )
    {
        if ( isdefined( currenttarget.antithreat ) )
        {
            currenttarget.antithreat += 100;
        }
        else
        {
            currenttarget.antithreat = 100;
        }
    }
    
    waittill_any_timeout_1( 3, "near_goal" );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x2aa2
// Size: 0x1e0
function attackgroundtarget( currenttarget )
{
    self notify( "attackGroundTarget" );
    self endon( "attackGroundTarget" );
    self stoploopsound();
    self.isattacking = 1;
    self setturrettargetent( currenttarget );
    waitontargetordeath( currenttarget, 3 );
    
    if ( !isalive( currenttarget ) )
    {
        self.isattacking = 0;
        return;
    }
    
    dist2dsq = distance2dsquared( self.origin, currenttarget.origin );
    
    if ( dist2dsq < 640000 )
    {
        thread dropbombs( currenttarget );
        self.isattacking = 0;
        return;
    }
    
    if ( checkisfacing( 50, currenttarget ) && cointoss() )
    {
        thread firemissile( currenttarget );
        self.isattacking = 0;
        return;
    }
    
    weaponshoottime = weaponfiretime( "cobra_20mm_mp" );
    var_922819de2d68c5e7 = 0;
    loopsoundplaying = 0;
    
    for ( i = 0; i < level.heli_turretclipsize ; i++ )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        if ( self.empgrenaded )
        {
            break;
        }
        
        if ( !isdefined( currenttarget ) )
        {
            break;
        }
        
        if ( !isalive( currenttarget ) )
        {
            break;
        }
        
        if ( self.damagetaken >= self.maxhealth )
        {
            continue;
        }
        
        if ( !checkisfacing( 55, currenttarget ) )
        {
            self stoploopsound();
            loopsoundplaying = 0;
            wait weaponshoottime;
            i--;
            continue;
        }
        
        if ( i < level.heli_turretclipsize - 1 )
        {
            wait weaponshoottime;
        }
        
        if ( !isdefined( currenttarget ) || !isalive( currenttarget ) )
        {
            break;
        }
        
        if ( !loopsoundplaying )
        {
            self playloopsound( "weap_hind_20mm_fire_npc" );
            loopsoundplaying = 1;
        }
        
        self setvehweapon( "cobra_20mm_mp" );
        self fireweapon( "tag_flash", currenttarget );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self stoploopsound();
    loopsoundplaying = 0;
    self.isattacking = 0;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 2
// Checksum 0x0, Offset: 0x2c8a
// Size: 0xc4
function checkisfacing( tolerance, currenttarget )
{
    self endon( "death" );
    self endon( "leaving" );
    
    if ( !isdefined( tolerance ) )
    {
        tolerance = 10;
    }
    
    heliforwardvector = anglestoforward( self.angles );
    var_6d9d6722a1121a79 = currenttarget.origin - self.origin;
    heliforwardvector *= ( 1, 1, 0 );
    var_6d9d6722a1121a79 *= ( 1, 1, 0 );
    var_6d9d6722a1121a79 = vectornormalize( var_6d9d6722a1121a79 );
    heliforwardvector = vectornormalize( heliforwardvector );
    targetcosine = vectordot( var_6d9d6722a1121a79, heliforwardvector );
    facingcosine = cos( tolerance );
    
    if ( targetcosine >= facingcosine )
    {
        return 1;
    }
    
    return 0;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 2
// Checksum 0x0, Offset: 0x2d56
// Size: 0xd9
function isfacing( tolerance, currenttarget )
{
    self endon( "death" );
    self endon( "leaving" );
    
    if ( !isdefined( tolerance ) )
    {
        tolerance = 10;
    }
    
    while ( isalive( currenttarget ) )
    {
        heliforwardvector = anglestoforward( self.angles );
        var_6d9d6722a1121a79 = currenttarget.origin - self.origin;
        heliforwardvector *= ( 1, 1, 0 );
        var_6d9d6722a1121a79 *= ( 1, 1, 0 );
        var_6d9d6722a1121a79 = vectornormalize( var_6d9d6722a1121a79 );
        heliforwardvector = vectornormalize( heliforwardvector );
        targetcosine = vectordot( var_6d9d6722a1121a79, heliforwardvector );
        facingcosine = cos( tolerance );
        
        if ( targetcosine >= facingcosine )
        {
            self notify( "facing" );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 2
// Checksum 0x0, Offset: 0x2e37
// Size: 0x35
function waitontargetordeath( target, timeout )
{
    self endon( "death" );
    self endon( "helicopter_done" );
    target endon( "death_or_disconnect" );
    waittill_notify_or_timeout( "turret_on_target", timeout );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x2e74
// Size: 0x12f
function firemissile( missiletarget )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    assert( self.health > 0 );
    var_585f84a1c35d91b1 = 2;
    
    for ( i = 0; i < var_585f84a1c35d91b1 ; i++ )
    {
        if ( !isdefined( missiletarget ) )
        {
            return;
        }
        
        if ( cointoss() )
        {
            missile = scripts\cp_mp\utility\weapon_utility::_magicbullet( makeweapon( "hind_missile_mp" ), self gettagorigin( "tag_missile_right" ) - ( 0, 0, 64 ), missiletarget.origin, self.owner );
            missile.vehicle_fired_from = self;
        }
        else
        {
            missile = scripts\cp_mp\utility\weapon_utility::_magicbullet( makeweapon( "hind_missile_mp" ), self gettagorigin( "tag_missile_left" ) - ( 0, 0, 64 ), missiletarget.origin, self.owner );
            missile.vehicle_fired_from = self;
        }
        
        missile missile_settargetent( missiletarget );
        missile.owner = self;
        missile missile_setflightmodedirect();
        wait 0.5 / var_585f84a1c35d91b1;
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x2fab
// Size: 0x103
function dropbombs( missiletarget )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    
    if ( !isdefined( missiletarget ) )
    {
        return;
    }
    
    for ( i = 0; i < randomintrange( 2, 5 ) ; i++ )
    {
        if ( cointoss() )
        {
            missile = scripts\cp_mp\utility\weapon_utility::_magicbullet( makeweapon( "hind_bomb_mp" ), self gettagorigin( "tag_missile_left" ) - ( 0, 0, 45 ), missiletarget.origin, self.owner );
            missile.vehicle_fired_from = self;
        }
        else
        {
            missile = scripts\cp_mp\utility\weapon_utility::_magicbullet( makeweapon( "hind_bomb_mp" ), self gettagorigin( "tag_missile_right" ) - ( 0, 0, 45 ), missiletarget.origin, self.owner );
            missile.vehicle_fired_from = self;
        }
        
        wait randomfloatrange( 0.35, 0.65 );
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x30b6
// Size: 0x153
function getoriginoffsets( goalnode )
{
    startorigin = self.origin;
    endorigin = goalnode.origin;
    numtraces = 0;
    maxtraces = 40;
    traceoffset = ( 0, 0, -196 );
    
    for ( traceorigin = scripts\engine\trace::_bullet_trace( startorigin + traceoffset, endorigin + traceoffset, 0, self ); distancesquared( traceorigin[ "position" ], endorigin + traceoffset ) > 10 && numtraces < maxtraces ; traceorigin = scripts\engine\trace::_bullet_trace( startorigin + traceoffset, endorigin + traceoffset, 0, self ) )
    {
        println( "<dev string:x48>" + distancesquared( traceorigin[ "<dev string:x5a>" ], endorigin + traceoffset ) );
        
        if ( startorigin[ 2 ] < endorigin[ 2 ] )
        {
            startorigin += ( 0, 0, 128 );
        }
        else if ( startorigin[ 2 ] > endorigin[ 2 ] )
        {
            endorigin += ( 0, 0, 128 );
        }
        else
        {
            startorigin += ( 0, 0, 128 );
            endorigin += ( 0, 0, 128 );
        }
        
        /#
        #/
        
        numtraces++;
    }
    
    offsets = [];
    offsets[ "start" ] = startorigin;
    offsets[ "end" ] = endorigin;
    return offsets;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x3212
// Size: 0x14a
function traveltonode( goalnode )
{
    originoffets = getoriginoffsets( goalnode );
    
    if ( originoffets[ "start" ] != self.origin )
    {
        self vehicle_setspeed( 75, 35 );
        _setvehgoalpos( originoffets[ "start" ] + ( 0, 0, 30 ), 0 );
        self setgoalyaw( goalnode.angles[ 1 ] + level.heli_angle_offset );
        self waittill( "goal" );
    }
    
    if ( originoffets[ "end" ] != goalnode.origin )
    {
        if ( isdefined( goalnode.script_airspeed ) && isdefined( goalnode.script_accel ) )
        {
            heli_speed = goalnode.script_airspeed;
            heli_accel = goalnode.script_accel;
        }
        else
        {
            heli_speed = 30 + randomint( 20 );
            heli_accel = 15 + randomint( 15 );
        }
        
        self vehicle_setspeed( 75, 35 );
        _setvehgoalpos( originoffets[ "end" ] + ( 0, 0, 30 ), 0 );
        self setgoalyaw( goalnode.angles[ 1 ] + level.heli_angle_offset );
        self waittill( "goal" );
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 3
// Checksum 0x0, Offset: 0x3364
// Size: 0x40
function _setvehgoalpos( goalposition, shouldstop, adheretomesh )
{
    if ( !isdefined( shouldstop ) )
    {
        shouldstop = 0;
    }
    
    adheretomesh = 0;
    
    if ( adheretomesh )
    {
        thread _setvehgoalposadheretomesh( goalposition, shouldstop );
        return;
    }
    
    self setvehgoalpos( goalposition, shouldstop );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 2
// Checksum 0x0, Offset: 0x33ac
// Size: 0x251
function _setvehgoalposadheretomesh( goalposition, shouldstop )
{
    self endon( "death" );
    self endon( "leaving" );
    self endon( "crashing" );
    finalgoalposition = goalposition;
    
    for ( ;; )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( distance_2d_squared( self.origin, finalgoalposition ) < 65536 )
        {
            self setvehgoalpos( finalgoalposition, shouldstop );
            println( "<dev string:x66>" );
            break;
        }
        
        vecangles = vectortoangles( finalgoalposition - self.origin );
        vecforward = anglestoforward( vecangles );
        var_7a7eaf576c2dcc51 = self.origin + vecforward * ( 1, 1, 0 ) * 250;
        traceoffset = ( 0, 0, 2500 );
        tracestart = var_7a7eaf576c2dcc51 + gethelipilotmeshoffset() + traceoffset;
        traceend = var_7a7eaf576c2dcc51 + gethelipilotmeshoffset() - traceoffset;
        tracepos = scripts\engine\trace::_bullet_trace( tracestart, traceend, 0, self, 0, 0, 1 );
        microgoalposition = tracepos;
        
        if ( isdefined( tracepos[ "entity" ] ) && tracepos[ "entity" ] == self && tracepos[ "normal" ][ 2 ] > 0.1 )
        {
            traceposz = tracepos[ "position" ][ 2 ] - 4400;
            zchange = traceposz - self.origin[ 2 ];
            
            if ( zchange > 256 )
            {
                tracepos[ "position" ] = tracepos[ "position" ] * ( 1, 1, 0 );
                tracepos[ "position" ] = tracepos[ "position" ] + ( 0, 0, self.origin[ 2 ] + 256 );
            }
            else if ( zchange < -256 )
            {
                tracepos[ "position" ] = tracepos[ "position" ] * ( 1, 1, 0 );
                tracepos[ "position" ] = tracepos[ "position" ] + ( 0, 0, self.origin[ 2 ] - 256 );
            }
            
            microgoalposition = tracepos[ "position" ] - gethelipilotmeshoffset() + ( 0, 0, 600 );
        }
        else
        {
            microgoalposition = finalgoalposition;
        }
        
        self setvehgoalpos( microgoalposition, 0 );
        wait 0.15;
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x3605
// Size: 0x1d4
function heli_fly_simple_path( startnode )
{
    self endon( "death" );
    self endon( "leaving" );
    self notify( "flying" );
    self endon( "flying" );
    heli_reset();
    
    for ( currentnode = startnode; isdefined( currentnode.target ) ; currentnode = nextnode )
    {
        nextnode = getent( currentnode.target, "targetname" );
        assertex( isdefined( nextnode ), "<dev string:x83>" + currentnode.origin );
        
        if ( isdefined( currentnode.script_airspeed ) && isdefined( currentnode.script_accel ) )
        {
            heli_speed = currentnode.script_airspeed;
            heli_accel = currentnode.script_accel;
        }
        else
        {
            heli_speed = 30 + randomint( 20 );
            heli_accel = 15 + randomint( 15 );
        }
        
        if ( isdefined( self.isattacking ) && self.isattacking )
        {
            waitframe();
            continue;
        }
        
        if ( isdefined( self.isperformingmaneuver ) && self.isperformingmaneuver )
        {
            waitframe();
            continue;
        }
        
        self vehicle_setspeed( 75, 35 );
        
        if ( !isdefined( nextnode.target ) )
        {
            _setvehgoalpos( nextnode.origin + self.zoffset, 1 );
            self waittill( "near_goal" );
            continue;
        }
        
        _setvehgoalpos( nextnode.origin + self.zoffset, 0 );
        self waittill( "near_goal" );
        self setgoalyaw( nextnode.angles[ 1 ] );
        self waittill( "goal" );
    }
    
    /#
        println( currentnode.origin );
        println( self.origin );
    #/
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x37e1
// Size: 0x236
function heli_fly_loop_path( startnode )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    self notify( "flying" );
    self endon( "flying" );
    heli_reset();
    thread heli_loop_speed_control( startnode );
    
    for ( currentnode = startnode; isdefined( currentnode.target ) ; currentnode = nextnode )
    {
        nextnode = getent( currentnode.target, "targetname" );
        assertex( isdefined( nextnode ), "<dev string:x83>" + currentnode.origin );
        
        if ( isdefined( self.isperformingmaneuver ) && self.isperformingmaneuver )
        {
            wait 0.25;
            continue;
        }
        
        if ( isdefined( self.isattacking ) && self.isattacking )
        {
            wait 0.1;
            continue;
        }
        
        if ( isdefined( currentnode.script_airspeed ) && isdefined( currentnode.script_accel ) )
        {
            self.desired_speed = currentnode.script_airspeed;
            self.desired_accel = currentnode.script_accel;
        }
        else
        {
            self.desired_speed = 30 + randomint( 20 );
            self.desired_accel = 15 + randomint( 15 );
        }
        
        if ( self.helitype == "flares" )
        {
            self.desired_speed *= 0.5;
            self.desired_accel *= 0.5;
        }
        
        if ( isdefined( nextnode.script_delay ) && isdefined( self.primarytarget ) && !heli_is_threatened() )
        {
            _setvehgoalpos( nextnode.origin + self.zoffset, 1, 1 );
            self waittill( "near_goal" );
            wait nextnode.script_delay;
            continue;
        }
        
        _setvehgoalpos( nextnode.origin + self.zoffset, 0, 1 );
        self waittill( "near_goal" );
        self setgoalyaw( nextnode.angles[ 1 ] );
        self waittill( "goal" );
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x3a1f
// Size: 0x14b
function heli_loop_speed_control( currentnode )
{
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    
    if ( isdefined( currentnode.script_airspeed ) && isdefined( currentnode.script_accel ) )
    {
        self.desired_speed = currentnode.script_airspeed;
        self.desired_accel = currentnode.script_accel;
    }
    else
    {
        self.desired_speed = 30 + randomint( 20 );
        self.desired_accel = 15 + randomint( 15 );
    }
    
    lastspeed = 0;
    var_b1d46319aa26b913 = 0;
    
    while ( true )
    {
        goalspeed = self.desired_speed;
        var_4c3fe0af18132696 = self.desired_accel;
        
        if ( isdefined( self.isattacking ) && self.isattacking )
        {
            waitframe();
            continue;
        }
        
        if ( self.helitype != "flares" && isdefined( self.primarytarget ) && !heli_is_threatened() )
        {
            goalspeed *= 0.25;
        }
        
        if ( lastspeed != goalspeed || var_b1d46319aa26b913 != var_4c3fe0af18132696 )
        {
            self vehicle_setspeed( 75, 35 );
            lastspeed = goalspeed;
            var_b1d46319aa26b913 = var_4c3fe0af18132696;
        }
        
        wait 0.05;
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x3b72
// Size: 0x2a, Type: bool
function heli_is_threatened()
{
    if ( self.recentdamageamount > 50 )
    {
        return true;
    }
    
    if ( self.currentstate == "heavy smoke" )
    {
        return true;
    }
    
    return false;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x3ba5
// Size: 0x173
function heli_fly_well( destnodes )
{
    self notify( "flying" );
    self endon( "flying" );
    self endon( "death" );
    self endon( "crashing" );
    self endon( "leaving" );
    
    for ( ;; )
    {
        if ( isdefined( self.isattacking ) && self.isattacking )
        {
            waitframe();
            continue;
        }
        
        currentnode = get_best_area_attack_node( destnodes );
        traveltonode( currentnode );
        
        if ( isdefined( currentnode.script_airspeed ) && isdefined( currentnode.script_accel ) )
        {
            heli_speed = currentnode.script_airspeed;
            heli_accel = currentnode.script_accel;
        }
        else
        {
            heli_speed = 30 + randomint( 20 );
            heli_accel = 15 + randomint( 15 );
        }
        
        self vehicle_setspeed( 75, 35 );
        _setvehgoalpos( currentnode.origin + self.zoffset, 1 );
        self setgoalyaw( currentnode.angles[ 1 ] + level.heli_angle_offset );
        
        if ( level.heli_forced_wait != 0 )
        {
            self waittill( "near_goal" );
            wait level.heli_forced_wait;
            continue;
        }
        
        if ( !isdefined( currentnode.script_delay ) )
        {
            self waittill( "near_goal" );
            wait 5 + randomint( 5 );
            continue;
        }
        
        self waittill( "goal" );
        wait currentnode.script_delay;
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x3d20
// Size: 0x12
function get_best_area_attack_node( destnodes )
{
    return updateareanodes( destnodes );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x3d3b
// Size: 0x14d
function heli_leave( leavepos )
{
    self notify( "leaving" );
    self clearlookatent();
    
    if ( isdefined( self.helitype ) && self.helitype == "osprey" && isdefined( self.pathgoal ) )
    {
        _setvehgoalpos( self.pathgoal, 1 );
        waittill_any_timeout_1( 5, "goal" );
    }
    
    if ( !isdefined( leavepos ) )
    {
        leavenode = level.heli_leave_nodes[ randomint( level.heli_leave_nodes.size ) ];
        leavepos = leavenode.origin;
    }
    
    endent = spawn( "script_origin", leavepos );
    
    if ( isdefined( endent ) )
    {
        self setlookatent( endent );
        endent thread wait_and_delete( 3 );
    }
    
    var_b2805e2f86ac4904 = ( leavepos - self.origin ) * 2000;
    heli_reset();
    self vehicle_setspeed( 180, 45 );
    _setvehgoalpos( var_b2805e2f86ac4904, 1 );
    waittill_any_timeout_1( 12, "goal" );
    self notify( "gone" );
    self notify( "death" );
    waitframe();
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    decrementfauxvehiclecount();
    self delete();
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x3e90
// Size: 0x22
function wait_and_delete( waittime )
{
    self endon( "death" );
    level endon( "game_ended" );
    wait waittime;
    self delete();
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 5
// Checksum 0x0, Offset: 0x3eba
// Size: 0x58
function debug_print3d( message, color, ent, origin_offset, frames )
{
    if ( isdefined( level.heli_debug ) && level.heli_debug == 1 )
    {
        thread draw_text( message, color, ent, origin_offset, frames );
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 4
// Checksum 0x0, Offset: 0x3f1a
// Size: 0x7d
function debug_print3d_simple( message, ent, offset, frames )
{
    if ( isdefined( level.heli_debug ) && level.heli_debug == 1 )
    {
        if ( isdefined( frames ) )
        {
            thread draw_text( message, ( 0.8, 0.8, 0.8 ), ent, offset, frames );
            return;
        }
        
        thread draw_text( message, ( 0.8, 0.8, 0.8 ), ent, offset, 0 );
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 4
// Checksum 0x0, Offset: 0x3f9f
// Size: 0x83
function debug_line( from, to, color, frames )
{
    if ( isdefined( level.heli_debug ) && level.heli_debug == 1 && !isdefined( frames ) )
    {
        thread draw_line( from, to, color );
        return;
    }
    
    if ( isdefined( level.heli_debug ) && level.heli_debug == 1 )
    {
        thread draw_line( from, to, color, frames );
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 5
// Checksum 0x0, Offset: 0x402a
// Size: 0xa7
function draw_text( msg, color, ent, offset, frames )
{
    if ( frames == 0 )
    {
        while ( isdefined( ent ) )
        {
            /#
                print3d( ent.origin + offset, msg, color, 0.5, 4 );
            #/
            
            wait 0.05;
        }
        
        return;
    }
    
    for ( i = 0; i < frames ; i++ )
    {
        if ( !isdefined( ent ) )
        {
            break;
        }
        
        /#
            print3d( ent.origin + offset, msg, color, 0.5, 4 );
        #/
        
        wait 0.05;
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 4
// Checksum 0x0, Offset: 0x40d9
// Size: 0x68
function draw_line( from, to, color, frames )
{
    /#
        if ( isdefined( frames ) )
        {
            for ( i = 0; i < frames ; i++ )
            {
                line( from, to, color );
                wait 0.05;
            }
            
            return;
        }
        
        for ( ;; )
        {
            line( from, to, color );
            wait 0.05;
        }
    #/
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x4149
// Size: 0x3f
function exceededmaxlittlebirds( streakname )
{
    if ( level.littlebirds.size >= 4 || level.littlebirds.size >= 2 && streakname == "littlebird_flock" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x4190
// Size: 0x4b
function pavelowmadeselectionvo()
{
    self endon( "death_or_disconnect" );
    self playlocalsound( game[ "voice" ][ self.team ] + "KS_hqr_pavelow" );
    wait 3.5;
    self playlocalsound( game[ "voice" ][ self.team ] + "KS_pvl_inbound" );
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x41e3
// Size: 0x68
function lbonkilled()
{
    self endon( "gone" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( "crashing" );
    
    if ( isdefined( self.largeprojectiledamage ) && self.largeprojectiledamage )
    {
        waitframe();
    }
    else
    {
        self vehicle_setspeed( 25, 5 );
        thread lbspin( randomintrange( 180, 220 ) );
        wait randomfloatrange( 1, 2 );
    }
    
    lbexplode();
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 1
// Checksum 0x0, Offset: 0x4253
// Size: 0x8a
function lbspin( speed )
{
    self endon( "explode" );
    playfxontag( level.chopper_fx[ "explode" ][ "medium" ], self, "tail_rotor_jnt" );
    thread trail_fx( level.chopper_fx[ "smoke" ][ "trail" ], "tail_rotor_jnt", "stop tail smoke" );
    self setyawspeed( speed, speed, speed );
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] + speed * 0.9 );
        wait 1;
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x42e5
// Size: 0x97
function lbexplode()
{
    forward = self.origin + ( 0, 0, 1 ) - self.origin;
    deathangles = self gettagangles( "tag_deathfx" );
    playfx( level.chopper_fx[ "explode" ][ "air_death" ][ "littlebird" ], self gettagorigin( "tag_deathfx" ), anglestoforward( deathangles ), anglestoup( deathangles ) );
    self playsound( "exp_helicopter_fuel" );
    self notify( "explode" );
    removelittlebird();
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 3
// Checksum 0x0, Offset: 0x4384
// Size: 0x40
function trail_fx( trail_fx, trail_tag, stop_notify )
{
    self notify( stop_notify );
    self endon( stop_notify );
    self endon( "death" );
    
    while ( true )
    {
        playfxontag( trail_fx, self, trail_tag );
        wait 0.05;
    }
}

// Namespace helicopter / scripts\mp\killstreaks\helicopter
// Params 0
// Checksum 0x0, Offset: 0x43cc
// Size: 0x107
function removelittlebird()
{
    if ( isdefined( self.mgturretleft ) )
    {
        if ( isdefined( self.mgturretleft.killcament ) )
        {
            self.mgturretleft.killcament delete();
        }
        
        self.mgturretleft delete();
    }
    
    if ( isdefined( self.mgturretright ) )
    {
        if ( isdefined( self.mgturretright.killcament ) )
        {
            self.mgturretright.killcament delete();
        }
        
        self.mgturretright delete();
    }
    
    if ( isdefined( self.marker ) )
    {
        self.marker delete();
    }
    
    if ( isdefined( level.heli_pilot[ self.team ] ) && level.heli_pilot[ self.team ] == self )
    {
        level.heli_pilot[ self.team ] = undefined;
    }
    
    decrementfauxvehiclecount();
    self delete();
}

