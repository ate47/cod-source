#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_weapons;
#using scripts\cp\drone\utility;
#using scripts\cp\utility;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace scout_drone;

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 0
// Checksum 0x0, Offset: 0x3d5
// Size: 0x33
function init()
{
    level.use_scout_drone_func = &deploy_scout_drone;
    level.use_ac130_drone_func = &deploy_ac130_drone;
    level.use_detonate_drone_func = &deploy_scout_detonate_drone;
    load_fx();
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0x410
// Size: 0x63
function craft_scout_drone( drone_config )
{
    if ( istrue( self.using_drone ) )
    {
        return;
    }
    
    if ( istrue( self.tablet_out ) )
    {
        return;
    }
    
    self.nvg_was_on = 0;
    
    if ( self isnightvisionon() )
    {
        self.nvg_was_on = 1;
        self nightvisionviewoff();
    }
    
    if ( !isdefined( drone_config ) )
    {
        drone_config = make_scout_config();
    }
    
    thread scripts\cp\drone\utility::deploy_drone( self, drone_config );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0x47b
// Size: 0x26
function deploy_scout_drone( player )
{
    drone_config = make_scout_config();
    player thread craft_scout_drone( drone_config );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0x4a9
// Size: 0x26
function deploy_ac130_drone( player )
{
    drone_config = make_ac130_drone_config();
    player thread craft_scout_drone( drone_config );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0x4d7
// Size: 0x26
function deploy_scout_detonate_drone( player )
{
    drone_config = make_scout_detonate_config();
    player thread craft_scout_drone( drone_config );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0x505
// Size: 0x26
function deploy_collection_drone( player )
{
    drone_config = make_collection_config();
    player thread craft_scout_drone( drone_config );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0x533
// Size: 0x19
function deploy_scout_drone_generic( player )
{
    scripts\cp\drone\utility::deploy_drone( player, make_scout_config() );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 0
// Checksum 0x0, Offset: 0x554
// Size: 0xb6
function make_scout_config()
{
    scout_config = spawnstruct();
    scout_config.model = "veh8_mil_air_malfa_small";
    scout_config.vehicle_info = "veh_radar_drone_recon_mp";
    scout_config.health = 150;
    scout_config.speed = 180;
    scout_config.accel = 20;
    scout_config.timeout = 30;
    scout_config.use_func = &use_scout_drone;
    scout_config.self_destruct = 1;
    scout_config.mark_ai = 1;
    scout_config.mark_vehicles = 1;
    scout_config.play_intro = 1;
    return scout_config;
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 0
// Checksum 0x0, Offset: 0x613
// Size: 0xc4
function make_ac130_drone_config()
{
    ac130_drone_config = spawnstruct();
    ac130_drone_config.model = "veh8_mil_air_malfa_small";
    ac130_drone_config.vehicle_info = "veh_mine_drone_mp";
    ac130_drone_config.health = 150;
    ac130_drone_config.speed = 180;
    ac130_drone_config.accel = 20;
    ac130_drone_config.timeout = 30000;
    ac130_drone_config.use_func = &use_scout_drone;
    ac130_drone_config.self_destruct = 1;
    ac130_drone_config.mark_ai = 1;
    ac130_drone_config.mark_vehicles = 1;
    ac130_drone_config.play_intro = 0;
    ac130_drone_config.send_down = 1;
    return ac130_drone_config;
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 0
// Checksum 0x0, Offset: 0x6e0
// Size: 0x9a
function make_scout_detonate_config()
{
    var_128843d9cfef6831 = spawnstruct();
    var_128843d9cfef6831.model = "veh8_mil_air_malfa_small";
    var_128843d9cfef6831.vehicle_info = "veh_mine_drone_mp";
    var_128843d9cfef6831.health = 150;
    var_128843d9cfef6831.speed = 180;
    var_128843d9cfef6831.accel = 20;
    var_128843d9cfef6831.timeout = 30000;
    var_128843d9cfef6831.use_func = &use_scout_drone;
    var_128843d9cfef6831.detonate_mines = 1;
    var_128843d9cfef6831.play_intro = 0;
    return var_128843d9cfef6831;
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 0
// Checksum 0x0, Offset: 0x783
// Size: 0xc4
function make_collection_config()
{
    collection_config = spawnstruct();
    collection_config.model = "veh8_mil_air_malfa_small";
    collection_config.vehicle_info = "veh_radar_drone_recon_mp";
    collection_config.health = 150;
    collection_config.speed = 180;
    collection_config.accel = 20;
    collection_config.timeout = 30;
    collection_config.use_func = &use_scout_drone;
    collection_config.self_destruct = 1;
    collection_config.mark_ai = 1;
    collection_config.mark_vehicles = 1;
    collection_config.play_intro = 1;
    collection_config.no_control = 1;
    return collection_config;
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 2
// Checksum 0x0, Offset: 0x850
// Size: 0x1c3
function use_scout_drone( player, drone )
{
    drone endon( "death" );
    
    foreach ( p in level.players )
    {
        if ( p != player )
        {
            p thread scripts\cp\cp_hud_message::showsplash( "cp_used_assault_drone", undefined, player );
        }
    }
    
    drone.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on( "rcdmarker", player.owner, undefined, 0, 1 );
    drone.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on( "thermalvisionfriendlydefault", player, player, 1 );
    drone thread scout_drone_clean_up( player, drone );
    
    if ( istrue( drone.mark_ai ) )
    {
        drone thread scout_drone_mark_npcs();
    }
    
    if ( istrue( drone.mark_vehicles ) )
    {
        drone thread scout_drone_markvehicles();
    }
    
    if ( istrue( drone.self_destruct ) )
    {
        player notifyonplayercommand( "deploy_scout_blast", "+usereload" );
        
        while ( true )
        {
            player thread scripts\cp\utility::hint_prompt( "self_destruct", 1 );
            player waittill( "deploy_scout_blast" );
            drone radiusdamage( drone.origin, 160, 180, 10, player, "MOD_EXPLOSIVE" );
            drone thread notify_nearby_enemies();
            player thread scripts\cp\utility::hint_prompt( "self_destruct", 0 );
            break;
        }
        
        drone thread delay_exit_drone( player, drone );
        return;
    }
    
    if ( istrue( drone.detonate_mines ) )
    {
        player notifyonplayercommand( "break_drone", "+stance" );
        
        while ( true )
        {
            player waittill( "break_drone" );
            drone thread notify_nearby_enemies();
            break;
        }
        
        drone thread delay_exit_drone( player, drone );
    }
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 2
// Checksum 0x0, Offset: 0xa1b
// Size: 0x12b, Type: bool
function playremotesequence( streakinfo, var_3cff035c1ecbd186 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    if ( isusingremote() )
    {
        return false;
    }
    
    if ( !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return false;
    }
    
    self notify( "play_remote_sequence" );
    self playlocalsound( "mp_killstreak_tablet_gear" );
    remoteweapon = undefined;
    
    if ( self isonladder() || self ismantling() || !self isonground() )
    {
        return false;
    }
    
    remoteweapon = "ks_remote_device_mp";
    _giveweapon( remoteweapon, 0, 0, 1 );
    switchresult = switchtoweaponreliable( remoteweapon );
    
    if ( istrue( switchresult ) )
    {
        thread watchformanualweaponend( remoteweapon );
    }
    else
    {
        return false;
    }
    
    setusingremote( streakinfo.streakname );
    _freezecontrols( 1 );
    thread unfreezeonroundend();
    thread startfadetransition( 1.3 );
    result = waittill_any_timeout_1( 1.8, "death" );
    self notify( "ks_freeze_end" );
    _freezecontrols( 0 );
    clearusingremote();
    
    if ( isdefined( remoteweapon ) )
    {
        self takeweapon( remoteweapon );
    }
    
    self stoplocalsound( "mp_killstreak_tablet_gear" );
    return true;
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 0
// Checksum 0x0, Offset: 0xb4f
// Size: 0x121
function scout_drone_mark_npcs()
{
    droneowner = self.owner;
    droneowner endon( "disconnect" );
    self endon( "death" );
    self endon( "leaving" );
    self endon( "explode" );
    self endon( "switch_modes" );
    all_enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam( "axis" );
    
    while ( true )
    {
        foreach ( soldier in all_enemies )
        {
            if ( istrue( self.markingtarget ) )
            {
                continue;
            }
            
            if ( !soldier scripts\cp_mp\utility\player_utility::_isalive() )
            {
                continue;
            }
            
            if ( soldier _hasperk( "specialty_noscopeoutline" ) )
            {
                continue;
            }
            
            if ( isbeingmarked( soldier ) )
            {
                continue;
            }
            
            if ( isreconmarked( soldier ) )
            {
                continue;
            }
            
            if ( !isinmarkingrange( soldier ) )
            {
                continue;
            }
            
            if ( !canseetarget( soldier ) )
            {
                continue;
            }
            
            if ( droneowner helperdrone_istargetinreticle( soldier, 70, 50 ) )
            {
                thread startmarkingtarget( soldier, "enemy", 0, 1 );
            }
        }
        
        wait 0.05;
    }
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0xc78
// Size: 0xe9
function canseetarget( target )
{
    icansee = 0;
    contents = scripts\engine\trace::create_contents( 0, 1, 0, 1, 1, 1, 0, 1 );
    tracepoints = [ target.origin ];
    
    if ( isplayer( target ) || isagent( target ) )
    {
        tracepoints = [ target gettagorigin( "j_head" ), target gettagorigin( "j_mainroot" ), target.origin ];
    }
    
    ignorelist = [ self, target ];
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        if ( !scripts\engine\trace::ray_trace_passed( self.owner getvieworigin(), tracepoints[ i ], ignorelist, contents ) )
        {
            continue;
        }
        
        icansee = 1;
        break;
    }
    
    return icansee;
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0xd6a
// Size: 0x1a6
function scout_drone_markvehicles( config )
{
    droneowner = self.owner;
    droneowner endon( "disconnect" );
    self endon( "death" );
    self endon( "leaving" );
    self endon( "explode" );
    self endon( "switch_modes" );
    
    while ( true )
    {
        var_84dbb1ce5bd4fa7d = vehicle_getarray();
        
        foreach ( vehicle in var_84dbb1ce5bd4fa7d )
        {
            if ( istrue( self.markingtarget ) )
            {
                continue;
            }
            
            if ( !isdefined( vehicle ) )
            {
                continue;
            }
            
            if ( level.teambased && isdefined( vehicle.script_team ) && vehicle.script_team == self.team )
            {
                continue;
            }
            else if ( level.teambased && isdefined( vehicle.team ) && vehicle.team == self.team )
            {
                continue;
            }
            else if ( isdefined( vehicle.owner ) && vehicle.owner == self )
            {
                continue;
            }
            
            if ( isbeingmarked( vehicle ) )
            {
                continue;
            }
            
            if ( isreconmarked( vehicle ) )
            {
                continue;
            }
            
            if ( !isinmarkingrange( vehicle ) )
            {
                continue;
            }
            
            if ( !canseetarget( vehicle ) )
            {
                continue;
            }
            
            if ( droneowner helperdrone_istargetinreticle( vehicle, 70, 50 ) )
            {
                thread startmarkingtarget( vehicle, "equipment", 0, 1 );
            }
        }
        
        wait 0.1;
    }
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0xf18
// Size: 0x15c
function helperdrone_markequipment( config )
{
    droneowner = self.owner;
    droneowner endon( "disconnect" );
    self endon( "death" );
    self endon( "leaving" );
    self endon( "explode" );
    self endon( "switch_modes" );
    
    while ( true )
    {
        equipmentarray = [[ level.getactiveequipmentarray ]]();
        
        foreach ( equipment in equipmentarray )
        {
            if ( istrue( self.markingtarget ) )
            {
                continue;
            }
            
            if ( !isdefined( equipment ) )
            {
                continue;
            }
            
            if ( level.teambased && equipment.team == self.team )
            {
                continue;
            }
            else if ( isdefined( equipment.owner ) && equipment.owner == self )
            {
                continue;
            }
            
            if ( isbeingmarked( equipment ) )
            {
                continue;
            }
            
            if ( isreconmarked( equipment ) )
            {
                continue;
            }
            
            if ( !isinmarkingrange( equipment ) )
            {
                continue;
            }
            
            if ( !canseetarget( equipment ) )
            {
                continue;
            }
            
            if ( droneowner helperdrone_istargetinreticle( equipment, 70, 50 ) )
            {
                thread startmarkingtarget( equipment, "equipment", 0, 1 );
            }
        }
        
        waitframe();
    }
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0x107c
// Size: 0x15a
function helperdrone_markkillstreaks( config )
{
    droneowner = self.owner;
    droneowner endon( "disconnect" );
    self endon( "death" );
    self endon( "leaving" );
    self endon( "explode" );
    self endon( "switch_modes" );
    
    while ( true )
    {
        var_6c845d64be969ce8 = level.activekillstreaks;
        
        foreach ( killstreak in var_6c845d64be969ce8 )
        {
            if ( istrue( self.markingtarget ) )
            {
                continue;
            }
            
            if ( !isdefined( killstreak ) )
            {
                continue;
            }
            
            if ( level.teambased && killstreak.team == self.team )
            {
                continue;
            }
            else if ( isdefined( killstreak.owner ) && killstreak.owner == self )
            {
                continue;
            }
            
            if ( isbeingmarked( killstreak ) )
            {
                continue;
            }
            
            if ( isreconmarked( killstreak ) )
            {
                continue;
            }
            
            if ( !isinmarkingrange( killstreak ) )
            {
                continue;
            }
            
            if ( !canseetarget( killstreak ) )
            {
                continue;
            }
            
            if ( droneowner helperdrone_istargetinreticle( killstreak, 70, 50 ) )
            {
                thread startmarkingtarget( killstreak, "killstreak", 0, 1 );
            }
        }
        
        waitframe();
    }
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0x11de
// Size: 0x17, Type: bool
function isreconmarked( target )
{
    return istrue( target.reconmarked );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 2
// Checksum 0x0, Offset: 0x11fe
// Size: 0x25
function isinouterradius( markingdrone, target )
{
    return array_contains( markingdrone.targetsinouterradius, target );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0x122c
// Size: 0x17, Type: bool
function isbeingmarked( target )
{
    return isdefined( target.beingmarked );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0x124c
// Size: 0x2a, Type: bool
function isinmarkingrange( target )
{
    return distancesquared( self.origin, target.origin ) < 4000000;
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 4
// Checksum 0x0, Offset: 0x127f
// Size: 0x229
function startmarkingtarget( target, targettype, useheadicon, useoutline )
{
    droneowner = self.owner;
    droneowner endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self endon( "explode" );
    self endon( "switch_modes" );
    markergroup = self.enemytargetmarkergroup;
    
    if ( !isdefined( markergroup ) )
    {
        return;
    }
    
    if ( !isdefined( self.enemiesmarked ) )
    {
        self.enemiesmarked = [];
    }
    
    target.beingmarked = 1;
    self.markingtarget = 1;
    self.owner notify( "marking_target" );
    self.owner setclientomnvar( "cp_scout_drone_controls", 2 );
    var_2095b8a1afaaf65e = 0.5;
    
    while ( var_2095b8a1afaaf65e > 0 )
    {
        if ( !isdefined( target ) )
        {
            return;
        }
        
        if ( !droneowner helperdrone_istargetinreticle( target, 70, 50 ) )
        {
            target.beingmarked = undefined;
            self.markingtarget = undefined;
            self.owner setclientomnvar( "cp_scout_drone_controls", 1 );
            return;
        }
        
        var_2095b8a1afaaf65e -= 0.05;
        wait 0.05;
    }
    
    target.reconmarked = 1;
    self.markingtarget = undefined;
    markent( target, self, undefined, "end_mark" );
    self.owner setclientomnvar( "cp_scout_drone_controls", 3 );
    self.owner playlocalsound( "recondrone_tag" );
    playsoundatpos_safe( target.origin, "recondrone_tag" );
    targetmarkergroupsetentitystate( self.enemytargetmarkergroup, target, 1 );
    timeout = 30;
    target waittill_any_timeout_2( timeout, "death", "set_noscopeoutline" );
    
    if ( droneowner helperdrone_istargetinreticle( target, 70, 150 ) && !target _hasperk( "specialty_noscopeoutline" ) )
    {
        targetmarkergroupsetentitystate( self.enemytargetmarkergroup, target, 0 );
    }
    else
    {
        targetmarkergroupremoveentity( self.enemytargetmarkergroup, target );
    }
    
    target notify( "end_mark" );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0x14b0
// Size: 0x68
function resetreticlemarkingprogressstate( delaytime )
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "leaving" );
    self endon( "explode" );
    self endon( "switch_modes" );
    droneowner = self.owner;
    droneowner endon( "disconnect" );
    droneowner endon( "marking_target" );
    wait delaytime;
    self.owner setclientomnvar( "cp_scout_drone_controls", 1 );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 3
// Checksum 0x0, Offset: 0x1520
// Size: 0xdf
function helperdrone_istargetinreticle( scantarget, scanfov, var_5e43b44751d01b1a )
{
    inreticle = 0;
    pointstocheck = [ scantarget.origin ];
    
    if ( isplayer( scantarget ) || isagent( scantarget ) )
    {
        pointstocheck = [ scantarget.origin, scantarget gettagorigin( "j_mainroot" ), scantarget gettagorigin( "tag_eye" ) ];
    }
    
    foreach ( point in pointstocheck )
    {
        if ( self worldpointinreticle_circle( point, scanfov, var_5e43b44751d01b1a ) )
        {
            inreticle = 1;
            break;
        }
    }
    
    return inreticle;
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 4
// Checksum 0x0, Offset: 0x1608
// Size: 0x8a
function markent( target, drone, timeout, notifytoendmark )
{
    self.enemiesmarked[ self.enemiesmarked.size ] = target;
    showto = drone.owner;
    
    if ( level.teambased )
    {
        showto = drone.team;
    }
    
    target hudoutlineenable( 1, 0, 1 );
    drone thread markent_watchmarkingentstatus( target );
    drone thread markent_watchtargetstatus( target, timeout, notifytoendmark );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 2
// Checksum 0x0, Offset: 0x169a
// Size: 0xbc
function markent_getclassperkicon( defaulticon, target )
{
    var_5c6b6249312f5aea = defaulticon;
    var_235f68a2f521dff3 = undefined;
    
    if ( isdefined( target.loadoutperks ) )
    {
        foreach ( perk in target.loadoutperks )
        {
            if ( array_contains( level.perkpackagelist, perk ) )
            {
                var_235f68a2f521dff3 = perk;
                break;
            }
        }
        
        if ( isdefined( var_235f68a2f521dff3 ) )
        {
            var_5c6b6249312f5aea = level.perkbundles[ var_235f68a2f521dff3 ].npicon;
        }
    }
    
    return var_5c6b6249312f5aea;
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 3
// Checksum 0x0, Offset: 0x175f
// Size: 0x1a6
function markent_getweaponicon( defaulticon, defaultoffset, target )
{
    weaponicon = defaulticon;
    weaponoffset = defaultoffset;
    weaponstruct = spawnstruct();
    
    if ( isdefined( target.weapon_name ) )
    {
        weaponref = undefined;
        
        if ( issubstr( target.weapon_name, "claymore" ) )
        {
            weaponref = "equip_claymore";
        }
        else if ( issubstr( target.weapon_name, "c4" ) )
        {
            weaponref = "equip_c4";
        }
        else if ( issubstr( target.weapon_name, "atMine" ) )
        {
            weaponref = "equip_at_mine";
        }
        else if ( issubstr( target.weapon_name, "trophy" ) )
        {
            weaponref = "equip_trophy";
        }
        
        if ( isdefined( weaponref ) )
        {
            weaponicon = level.equipment.table[ weaponref ].image;
        }
    }
    else if ( isdefined( target.streakinfo ) )
    {
        streakref = target.streakinfo.streakname;
        streakbundle = level.streakglobals.streakbundles[ streakref ];
        weaponicon = ter_op( isdefined( streakbundle ) && isdefined( streakbundle.overheadicon ), streakbundle.overheadicon, "" );
        weaponoffset = 75;
    }
    
    weaponstruct.weaponicon = weaponicon;
    weaponstruct.weaponoffset = weaponoffset;
    return weaponstruct;
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0x190e
// Size: 0x3a
function markent_watchmarkingentstatus( target )
{
    level endon( "game_ended" );
    target endon( "unmarked" );
    waittill_any_3( "explode", "death", "leaving" );
    wait 3;
    unmark( target );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 3
// Checksum 0x0, Offset: 0x1950
// Size: 0x6d
function markent_watchtargetstatus( target, timeout, notifytoendmark )
{
    level endon( "game_ended" );
    target endon( "unmarked" );
    thread resetreticlemarkingprogressstate( 0.5 );
    
    if ( isdefined( timeout ) )
    {
        target waittill_any_timeout_3( timeout, "death", "disconnect", notifytoendmark );
    }
    else
    {
        target waittill_any_3( "death", "disconnect", notifytoendmark );
    }
    
    unmark( target );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 1
// Checksum 0x0, Offset: 0x19c5
// Size: 0xbe
function unmark( target )
{
    target hudoutlinedisable();
    
    if ( isdefined( target ) )
    {
        target.reconmarked = undefined;
        target.beingmarked = undefined;
        
        if ( isdefined( self ) )
        {
            if ( isdefined( self.enemiesmarked ) && self.enemiesmarked.size > 0 )
            {
                self.enemiesmarked = array_remove( self.enemiesmarked, target );
            }
        }
        
        if ( isplayer( target ) )
        {
            target setclientomnvar( "ui_rcd_target_notify", 0 );
        }
        
        target notify( "unmarked" );
        return;
    }
    
    if ( isdefined( self.enemiesmarked ) && self.enemiesmarked.size > 0 )
    {
        self.enemiesmarked = array_removeundefined( self.enemiesmarked );
    }
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 0
// Checksum 0x0, Offset: 0x1a8b
// Size: 0x116
function notify_nearby_enemies()
{
    enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam( "axis" );
    closest_enemies = get_array_of_closest( self.origin, enemies, undefined, undefined, 1000 );
    
    foreach ( enemy in closest_enemies )
    {
        if ( isdefined( enemy ) )
        {
            enemy notify( "bulletwhizby" );
            enemy notify( "icon_cancel_delete" );
        }
    }
    
    if ( !isdefined( closest_enemies ) || closest_enemies.size == 0 )
    {
        enemies = getaiarrayinradius( self.origin, 1000 );
        
        if ( enemies.size > 0 )
        {
            foreach ( actor in enemies )
            {
                if ( isai( actor ) )
                {
                    actor notify( "bulletwhizby" );
                    actor notify( "icon_cancel_delete" );
                }
            }
        }
    }
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 2
// Checksum 0x0, Offset: 0x1ba9
// Size: 0x34
function delay_exit_drone( player, drone )
{
    wait 0.3;
    
    if ( isdefined( player ) )
    {
        scripts\cp\drone\utility::exit_drone( player, drone );
    }
    
    if ( isdefined( drone ) )
    {
        scripts\cp\drone\utility::drone_explode( drone );
    }
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 2
// Checksum 0x0, Offset: 0x1be5
// Size: 0x89
function self_destruct_drone( player, drone )
{
    delay = 0.3;
    
    if ( isdefined( drone.extra_drone_delay ) )
    {
        delay = drone.extra_drone_delay;
    }
    
    if ( isdefined( drone ) )
    {
        playfx( level._effect[ "vfx_drone_explo" ], drone.origin );
    }
    
    if ( isdefined( player ) )
    {
        drone_exit_delayed( player, drone, drone.extra_drone_delay );
    }
    
    if ( isdefined( drone ) )
    {
        drone delete();
    }
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 3
// Checksum 0x0, Offset: 0x1c76
// Size: 0xd2
function drone_exit_delayed( player, drone, delay )
{
    if ( isent( drone ) )
    {
        drone playsound( "recondrone_destroyed" );
    }
    
    if ( !isent( drone ) )
    {
        return;
    }
    
    scripts\cp\drone\utility::turn_off_drone_hud( player );
    player setplayerangles( player.pre_drone_angles );
    player.using_drone = undefined;
    player.disable_map_tablet = undefined;
    wait delay;
    player remotecontrolvehicleoff();
    player cameraunlink( drone );
    player val::set( "drone", "weapon_switch", 1 );
    weapontoswitch = player scripts\cp\utility::getweapontoswitchbackto();
    player switchtoweapon( weapontoswitch );
    player takeweapon( "ks_remote_map_cp" );
    player val::reset_all( "drone" );
    player notify( "exiting_drone" );
    player notify( "exit_mine_drone" );
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 2
// Checksum 0x0, Offset: 0x1d50
// Size: 0x8a
function scout_drone_clean_up( player, drone )
{
    player endon( "disconnect" );
    drone waittill( "death" );
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off( drone.enemytargetmarkergroup );
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off( drone.friendlytargetmarkergroup );
    player thread scripts\cp\utility::hint_prompt( "scout_blast_ready", 0 );
    player thread scripts\cp\utility::hint_prompt( "scout_hit_target", 0 );
    player thread delay_nvgs();
    
    if ( isdefined( level.scout_drone_clean_up_func ) )
    {
        level thread [[ level.scout_drone_clean_up_func ]]( player, drone );
    }
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 0
// Checksum 0x0, Offset: 0x1de2
// Size: 0x1b
function delay_nvgs()
{
    wait 0.75;
    
    if ( self.nvg_was_on )
    {
        self nightvisionviewon();
    }
}

// Namespace scout_drone / scripts\cp\drone\scout_drone
// Params 0
// Checksum 0x0, Offset: 0x1e05
// Size: 0x9
function load_fx()
{
    scripts\cp\drone\utility::load_fx();
}

