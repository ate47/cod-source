#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace emp_drone_targeted;

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 0
// Checksum 0x0, Offset: 0x6ea
// Size: 0x4b
function init()
{
    if ( issharedfuncdefined( "emp_drone_targeted", "init" ) )
    {
        [[ getsharedfunc( "emp_drone_targeted", "init" ) ]]();
    }
    
    /#
        setdevdvarifuninitialized( @"hash_9a501fd816a448b6", 0 );
        setdevdvarifuninitialized( @"hash_8bfee5c0dec14aca", 0 );
    #/
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 0
// Checksum 0x0, Offset: 0x73d
// Size: 0x21, Type: bool
function empdrone_beginsuper()
{
    self endon( "death_or_disconnect" );
    self endon( "reconDroneEnded" );
    self endon( "reconDroneUnset" );
    thread empdrone_superusethink();
    return true;
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 0
// Checksum 0x0, Offset: 0x767
// Size: 0xc6
function empdrone_superusethink()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    streakinfo = createstreakinfo( "emp_drone", self );
    result = empdrone_tryuse( streakinfo );
    wait 0.05;
    
    if ( result )
    {
        if ( issharedfuncdefined( "supers", "superUseFinished" ) )
        {
            [[ getsharedfunc( "supers", "superUseFinished" ) ]]();
        }
        
        if ( issharedfuncdefined( "sound", "trySayLocalSound" ) )
        {
            level thread [[ getsharedfunc( "sound", "trySayLocalSound" ) ]]( self, #"bc_fieldupgrade_action_emppulse" );
        }
        
        return;
    }
    
    if ( issharedfuncdefined( "supers", "superUseFinished" ) )
    {
        [[ getsharedfunc( "supers", "superUseFinished" ) ]]( 1 );
    }
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 1
// Checksum 0x0, Offset: 0x835
// Size: 0xb
function empdrone_tryuse( streakinfo )
{
    
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 3
// Checksum 0x0, Offset: 0x848
// Size: 0x9d
function empdrone_equipment_wrapper( ref, slot, objweapon )
{
    if ( issharedfuncdefined( "equipment", "takeEquipment" ) )
    {
        self [[ getsharedfunc( "equipment", "takeEquipment" ) ]]( slot );
    }
    
    streakinfo = createstreakinfo( "emp_drone", self );
    used = empdrone_tryuse( streakinfo );
    
    if ( !used )
    {
        if ( issharedfuncdefined( "equipment", "giveEquipment" ) )
        {
            self [[ getsharedfunc( "equipment", "giveEquipment" ) ]]( "equip_empdrone", slot );
        }
    }
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 1
// Checksum 0x0, Offset: 0x8ed
// Size: 0x3e, Type: bool
function empdrone_weapongiven( streakinfo )
{
    if ( issharedfuncdefined( "empDroneTargeted", "startMapSelectSequence" ) )
    {
        self [[ getsharedfunc( "empDroneTargeted", "startMapSelectSequence" ) ]]( 0, 0, undefined, 3 );
    }
    else
    {
        return false;
    }
    
    return true;
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 2
// Checksum 0x0, Offset: 0x934
// Size: 0x268
function empdrone_createdrone( streakinfo, targetpos )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    posstruct = empdrone_calculatepositions( targetpos );
    drone = scripts\cp_mp\utility\weapon_utility::_magicbullet( makeweapon( "emp_drone_proj_mp" ), posstruct.startpos, posstruct.targetpos, self );
    
    /#
        if ( getdvarint( @"hash_8bfee5c0dec14aca", 0 ) != 0 )
        {
            sphere( drone.origin, 25, ( 0, 1, 0 ), 0, 2000 );
        }
    #/
    
    drone setentityowner( self );
    drone.owner = self;
    drone.ownerid = self getentitynumber();
    drone.team = self.team;
    drone.streakinfo = streakinfo;
    drone.usedcount = 0;
    drone.superid = level.superglobals.staticsuperdata[ "super_emp_drone" ].id;
    drone hidepart( "j_propeller" );
    playfxontag( getfx( "vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx" ), drone, "tag_origin" );
    playfxontag( getfx( "vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_contrails.vfx" ), drone, "tag_origin" );
    playfxontag( getfx( "vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_heat_dist.vfx" ), drone, "tag_origin" );
    playfxontag( getfx( "vfx/iw8_mp/killstreak/vfx_rc_plane_rotor.vfx" ), drone, "j_propeller" );
    
    if ( issharedfuncdefined( "empDroneTargeted", "monitorDamage" ) )
    {
        drone thread [[ getsharedfunc( "empDroneTargeted", "monitorDamage" ) ]]( 25, "hitequip", &empdrone_handledeathdamage, undefined, 0 );
    }
    
    if ( issharedfuncdefined( "killstreak", "addToActiveKillstreakList" ) )
    {
        drone [[ getsharedfunc( "killstreak", "addToActiveKillstreakList" ) ]]( streakinfo.streakname, "Killstreak_Air", self, 0, 1, 25 );
    }
    
    drone playloopsound( "iw8_rc_plane_engine" );
    drone thread empdrone_timeoutthink();
    drone thread empdrone_gameendedthink();
    drone thread empdrone_collidethink();
    
    if ( getdvarint( @"hash_9a501fd816a448b6", 0 ) == 0 )
    {
        drone thread empdrone_divebombthink( posstruct );
    }
    else
    {
        drone thread empdrone_killstreaktargetthink( posstruct );
    }
    
    drone scripts\cp_mp\emp_debuff::set_apply_emp_callback( &empdrone_empapplied );
    self setplayerusingdrone( drone );
    return drone;
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 1
// Checksum 0x0, Offset: 0xba5
// Size: 0x217
function empdrone_calculatepositions( targetpos )
{
    heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
    heightoffset = ( 0, 0, 1500 );
    
    if ( isdefined( heightent ) )
    {
        heightz = heightent.origin[ 2 ] + -1500;
        heightoffset = ( 0, 0, heightz );
    }
    
    forwardvector = anglestoforward( self.angles );
    startpos = undefined;
    tracepassed = 0;
    angledelta = 0;
    safetyvalve = 0;
    
    while ( true )
    {
        rotatedvector = rotatevector( forwardvector, ( 0, angledelta, 0 ) );
        aboveplayerpos = heightoffset + targetpos;
        startpos = aboveplayerpos - rotatedvector * 4500;
        extraoffset = 1500 * ( 0, 0, 1 );
        startpos += extraoffset;
        collisioncontents = physics_createcontents( [ "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot" ] );
        tracepassed = ray_trace_passed( startpos, aboveplayerpos, undefined, collisioncontents );
        safetyvalve++;
        
        if ( tracepassed )
        {
            /#
                if ( getdvarint( @"hash_8bfee5c0dec14aca", 0 ) != 0 )
                {
                    line( startpos, aboveplayerpos, ( 0, 1, 0 ), 1, 0, 2000 );
                }
            #/
            
            break;
        }
        
        /#
            if ( getdvarint( @"hash_8bfee5c0dec14aca", 0 ) != 0 )
            {
                line( startpos, aboveplayerpos, ( 1, 0, 0 ), 1, 0, 2000 );
            }
        #/
        
        if ( safetyvalve >= 13 )
        {
            break;
        }
        
        wait 0.05;
        angledelta += 55.3;
    }
    
    divebombpos = vectornormalize( startpos - aboveplayerpos ) * 1000 + aboveplayerpos;
    struct = spawnstruct();
    struct.startpos = startpos;
    struct.divebombpos = divebombpos;
    struct.targetpos = targetpos;
    return struct;
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 0
// Checksum 0x0, Offset: 0xdc5
// Size: 0x54
function empdrone_timeoutthink()
{
    level endon( "game_ended" );
    self.owner endon( "disconnect" );
    self endon( "death" );
    currenttime = gettime() * 0.001;
    timeouttime = currenttime + 20;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( timeouttime );
    thread empdrone_destroy();
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 0
// Checksum 0x0, Offset: 0xe21
// Size: 0x32
function empdrone_gameendedthink()
{
    self.owner endon( "disconnect" );
    self endon( "death" );
    level waittill_any_2( "game_ended", "prematch_cleanup" );
    thread empdrone_destroy();
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 0
// Checksum 0x0, Offset: 0xe5b
// Size: 0x68
function empdrone_collidethink()
{
    level endon( "game_ended" );
    self.owner endon( "disconnect" );
    self endon( "death" );
    self waittill( "missile_stuck" );
    
    /#
        if ( getdvarint( @"hash_8bfee5c0dec14aca", 0 ) != 0 )
        {
            sphere( self.origin, 25, ( 1, 0, 0 ), 0, 2000 );
        }
    #/
    
    thread empdrone_explode();
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 1
// Checksum 0x0, Offset: 0xecb
// Size: 0x139
function empdrone_divebombthink( posstruct )
{
    level endon( "game_ended" );
    self.owner endon( "disconnect" );
    self endon( "death" );
    self missile_settargetpos( posstruct.divebombpos );
    closeenough = 50;
    
    while ( distancesquared( posstruct.divebombpos, self.origin ) > closeenough * closeenough )
    {
        wait 0.05;
    }
    
    forwardvector = anglestoforward( self.angles );
    dist = distance( posstruct.targetpos, self.origin );
    forwardtarget = self.origin + forwardvector * dist;
    starttime = gettime();
    relativevalue = 0;
    angularrotation = 0;
    
    while ( true )
    {
        wait 0.05;
        relativevalue = ( gettime() - starttime ) / 1300;
        relativevalue = clamp( relativevalue, 0, 1 );
        relativepoint = forwardtarget * ( 1 - relativevalue ) + posstruct.targetpos * relativevalue;
        self missile_settargetpos( relativepoint );
    }
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 1
// Checksum 0x0, Offset: 0x100c
// Size: 0xb
function empdrone_killstreaktargetthink( posstruct )
{
    
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 3
// Checksum 0x0, Offset: 0x101f
// Size: 0x2a
function empdrone_handledeathdamage( attacker, weapon, damagetype )
{
    empdrone_givepointsfordeath( attacker );
    empdrone_destroy();
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 0
// Checksum 0x0, Offset: 0x1051
// Size: 0x51
function empdrone_explode()
{
    self playsound( "iw8_rc_plane_engine_exp" );
    forward = anglestoforward( self.angles );
    playfx( getfx( "vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx" ), self.origin, forward );
    empdrone_explodeemp();
    empdrone_delete();
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 0
// Checksum 0x0, Offset: 0x10aa
// Size: 0x4a
function empdrone_destroy()
{
    self playsound( "recondrone_damaged" );
    forward = anglestoforward( self.angles );
    playfx( getfx( "vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx" ), self.origin, forward );
    empdrone_delete();
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 0
// Checksum 0x0, Offset: 0x10fc
// Size: 0x96
function empdrone_delete()
{
    self stoploopsound( "iw8_rc_plane_engine" );
    
    if ( issharedfuncdefined( "challenges", "onFieldUpgradeEnd" ) )
    {
        self.owner [[ getsharedfunc( "challenges", "onFieldUpgradeEnd" ) ]]( "super_emp_drone", self.usedcount );
    }
    
    if ( issharedfuncdefined( "dlog", "fieldUpgradeExpired" ) )
    {
        self thread [[ getsharedfunc( "dlog", "fieldUpgradeExpired" ) ]]( self.owner, self.superid, self.usedcount, 0 );
    }
    
    self delete();
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 1
// Checksum 0x0, Offset: 0x119a
// Size: 0x31
function empdrone_empapplied( data )
{
    attacker = data.attacker;
    empdrone_givepointsfordeath( attacker );
    empdrone_destroy();
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 1
// Checksum 0x0, Offset: 0x11d3
// Size: 0x54
function empdrone_givepointsfordeath( attacker )
{
    if ( istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker notify( "destroyed_equipment" );
        
        if ( issharedfuncdefined( "player", "doScoreEvent" ) )
        {
            attacker thread [[ getsharedfunc( "player", "doScoreEvent" ) ]]( "destroyed_equipment" );
        }
    }
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 0
// Checksum 0x0, Offset: 0x122f
// Size: 0x44e
function empdrone_explodeemp()
{
    indirectweapon = makeweapon( "emp_drone_non_player_mp" );
    directhitweapon = makeweapon( "emp_drone_non_player_direct_mp" );
    var_9644d3f7dc618eab = [];
    ents = empdebuff_get_emp_ents( self.origin, 800 );
    
    foreach ( ent in ents )
    {
        if ( ent == self )
        {
            continue;
        }
        
        entowner = ent.owner;
        
        if ( isdefined( entowner ) )
        {
            if ( entowner != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, entowner ) )
            {
                continue;
            }
        }
        
        isvehicle = ent scripts\cp_mp\vehicles\vehicle::isvehicle();
        var_609019899015ed5d = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered( ent );
        
        if ( isvehicle && var_609019899015ed5d )
        {
            occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( ent );
            
            foreach ( occupant in occupants )
            {
                var_9644d3f7dc618eab[ var_9644d3f7dc618eab.size ] = occupant;
            }
        }
        
        distsqr = distancesquared( self.origin, ent.origin );
        weapon = ter_op( distsqr > 6400, indirectweapon, directhitweapon );
        ent dodamage( 1, self.origin, self.owner, self, "MOD_EXPLOSIVE", weapon );
        data = packdamagedata( self.owner, ent, 1, weapon, "MOD_EXPLOSIVE", self, self.origin );
        thread empdrone_applyemp( data );
    }
    
    playerweapon = makeweapon( "emp_drone_player_mp" );
    self radiusdamage( self.origin, 80, 120, 80, self.owner, "MOD_EXPLOSIVE", playerweapon );
    players = utility::playersinsphere( self.origin, 800 );
    players = array_combine_unique( players, var_9644d3f7dc618eab );
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !player can_be_empd() )
        {
            continue;
        }
        
        if ( player != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, player ) )
        {
            continue;
        }
        
        player dodamage( 1, self.origin, self.owner, self, "MOD_EXPLOSIVE", playerweapon );
        data = packdamagedata( self.owner, player, 1, playerweapon, "MOD_EXPLOSIVE", self, self.origin );
        thread empdrone_applyemp( data );
    }
    
    playersrumble = playersinsphere( self.origin, 2000 );
    playersrumble = array_combine_unique( playersrumble, var_9644d3f7dc618eab );
    
    foreach ( player in playersrumble )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player == self.owner )
        {
            continue;
        }
        
        player earthquakeforplayer( 0.3, 1, self.origin, 2000 );
        player setclientomnvar( "ui_hud_shake", 1 );
        player playrumbleonpositionforclient( "artillery_rumble_light", self.origin );
    }
    
    self.owner earthquakeforplayer( 0.2, 1, self.owner.origin, 2000 );
    self.owner setclientomnvar( "ui_hud_shake", 1 );
    self.owner playrumbleonpositionforclient( "artillery_rumble_light", self.origin );
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 1
// Checksum 0x0, Offset: 0x1685
// Size: 0x220
function empdrone_applyemp( data )
{
    apply_emp_struct( data );
    duration = 8;
    
    if ( isplayer( data.victim ) )
    {
        if ( issharedfuncdefined( "perk", "hasPerk" ) )
        {
            if ( data.victim != self.owner && data.victim [[ getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_emp_resist" ) )
            {
                duration = 2;
                
                if ( issharedfuncdefined( "damage", "updateDamageFeedback" ) )
                {
                    self.owner [[ getsharedfunc( "damage", "updateDamageFeedback" ) ]]( "hittacresist" );
                }
            }
        }
        
        if ( issharedfuncdefined( "gamescore", "trackDebuffAssist" ) )
        {
            [[ getsharedfunc( "gamescore", "trackDebuffAssist" ) ]]( data.attacker, data.victim, data.objweapon.basename );
        }
    }
    
    if ( issharedfuncdefined( "pers", "incPersStat" ) )
    {
        self.owner [[ getsharedfunc( "pers", "incPersStat" ) ]]( "empDroneHits", 1 );
    }
    
    if ( issharedfuncdefined( "supers", "combatRecordSuperMisc" ) )
    {
        self.owner [[ getsharedfunc( "supers", "combatRecordSuperMisc" ) ]]( "super_emp_drone" );
    }
    
    self.usedcount++;
    empdrone_empendearly( data, duration );
    
    if ( isdefined( data.victim ) )
    {
        data.victim remove_emp();
        
        if ( isdefined( data.attacker ) && isplayer( data.victim ) )
        {
            if ( issharedfuncdefined( "gamescore", "untrackDebuffAssist" ) )
            {
                [[ getsharedfunc( "gamescore", "untrackDebuffAssist" ) ]]( data.attacker, data.victim, data.objweapon.basename );
            }
        }
    }
}

// Namespace emp_drone_targeted / scripts\cp_mp\killstreaks\emp_drone_targeted
// Params 2
// Checksum 0x0, Offset: 0x18ad
// Size: 0x5b
function empdrone_empendearly( data, duration )
{
    data.victim endon( "death_or_disconnect" );
    level endon( "game_ended" );
    result = waittill_notify_or_timeout_return( "emp_cleared", duration );
    
    if ( result != "emp_cleared" )
    {
        data.empremoved = 1;
    }
}

