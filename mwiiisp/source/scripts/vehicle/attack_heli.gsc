#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\helicopter_globals;
#using scripts\sp\utility;

#namespace attack_heli;

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x789
// Size: 0x27
function preload()
{
    precacheitem( "turret_attackheli" );
    precacheitem( "missile_attackheli" );
    attack_heli_fx();
    thread init();
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x7b8
// Size: 0x62
function attack_heli_fx()
{
    if ( getdvarint( @"hash_ad42ca33a427de58" ) && getdvar( @"hash_5c129cc6b6f612dc" ) != "0" )
    {
        level._effect[ "_attack_heli_spotlight" ] = loadfx( "vfx/core/vehicles/hunted_spotlight_model" );
        return;
    }
    
    level._effect[ "_attack_heli_spotlight" ] = loadfx( "vfx/core/vehicles/spotlight_large" );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x822
// Size: 0x1af
function init()
{
    if ( isdefined( level.attackheliaiburstsize ) )
    {
        return;
    }
    
    while ( !isdefined( level.gameskill ) )
    {
        wait 0.05;
    }
    
    if ( !isdefined( level.cosine ) )
    {
        level.cosine = [];
    }
    
    if ( !isdefined( level.cosine[ "25" ] ) )
    {
        level.cosine[ "25" ] = cos( 25 );
    }
    
    if ( !isdefined( level.cosine[ "35" ] ) )
    {
        level.cosine[ "35" ] = cos( 35 );
    }
    
    if ( !isdefined( level.attackhelirange ) )
    {
        level.attackhelirange = 3500;
    }
    
    if ( !isdefined( level.attackhelikillsai ) )
    {
        level.attackhelikillsai = 0;
    }
    
    if ( !isdefined( level.attackhelifov ) )
    {
        level.attackhelifov = cos( 30 );
    }
    
    level.attackheliaiburstsize = 1;
    level.attackhelimemory = 3;
    level.attackhelitargetreaquire = 6;
    level.attackhelimovetime = 3;
    
    switch ( level.gameskill )
    {
        case 0:
            level.attackheliplayerbreak = 9;
            level.attackhelitimeout = 1;
            break;
        case 1:
            level.attackheliplayerbreak = 7;
            level.attackhelitimeout = 2;
            break;
        case 2:
            level.attackheliplayerbreak = 5;
            level.attackhelitimeout = 3;
            break;
        case 3:
            level.attackheliplayerbreak = 3;
            level.attackhelitimeout = 5;
            break;
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x9d9
// Size: 0x33
function start_attack_heli( stargetname )
{
    if ( !isdefined( stargetname ) )
    {
        stargetname = "kill_heli";
    }
    
    eheli = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive( stargetname );
    eheli = begin_attack_heli_behavior( eheli );
    return eheli;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 2
// Checksum 0x0, Offset: 0xa15
// Size: 0x321
function begin_attack_heli_behavior( eheli, heli_points )
{
    eheli endon( "death" );
    eheli endon( "heli_players_dead" );
    
    if ( level.gameskill == 0 || level.gameskill == 1 )
    {
        org = spawn( "script_origin", eheli.origin + ( 0, 0, -20 ) );
        org linkto( eheli );
        eheli thread delete_on_death( org );
        strength = undefined;
        
        if ( level.gameskill == 0 )
        {
            strength = 2800;
        }
        else
        {
            strength = 2200;
        }
        
        if ( !isdefined( eheli.no_attractor ) )
        {
            eheli.attractor = missile_createattractorent( org, strength, 10000, level.player );
        }
    }
    
    eheli enableaimassist();
    eheli.startingorigin = spawn( "script_origin", eheli.origin );
    eheli thread delete_on_death( eheli.startingorigin );
    
    if ( !isdefined( eheli.circling ) )
    {
        eheli.circling = 0;
    }
    
    eheli.allowshoot = 1;
    eheli.firingmissiles = 0;
    eheli.moving = 1;
    eheli.istakingdamage = 0;
    eheli.heli_lastattacker = undefined;
    eheli thread notify_disable();
    eheli thread notify_enable();
    thread kill_heli_logic( eheli, heli_points );
    eheli.turrettype = undefined;
    eheli heli_default_target_setup();
    eheli thread detect_player_death();
    
    switch ( eheli.vehicletype )
    {
        case #"hash_7cbaf54a9583848":
        case #"hash_657241a1e3f14ce7":
        case #"hash_70514937441959cb":
        case #"hash_d29d1c641f811715":
            eheli.turrettype = "default";
            break;
        case #"hash_b5fd54495f0348e2":
        case #"hash_beeeed34c5017c21":
        case #"hash_bef1e634c503afb3":
            eheli.turrettype = "default";
            break;
        case #"hash_b55ba82d2cec3b73":
            eheli.turrettype = "default";
            break;
        case #"hash_1a1d956bedda953d":
        case #"hash_8c12ae8d5afba7a6":
            eheli setyawspeed( 90, 30, 20 );
            eheli setmaxpitchroll( 40, 40 );
            eheli sethoverparams( 100, 20, 5 );
            eheli setup_miniguns();
            break;
        default:
            assertmsg( "Need to set up this heli type in the _attack_heli.gsc script: " + self.vehicletype );
            break;
    }
    
    eheli.etarget = eheli.targetdefault;
    
    if ( isdefined( eheli.script_spotlight ) && eheli.script_spotlight == 1 && !isdefined( eheli.spotlight ) )
    {
        eheli thread heli_spotlight_on( undefined, 1 );
    }
    
    eheli thread attack_heli_cleanup();
    return eheli;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0xd3f
// Size: 0x6c
function detect_player_death()
{
    foreach ( player in level.players )
    {
        player add_wait( &waittill_msg, "death" );
    }
    
    do_wait_any();
    self notify( "heli_players_dead" );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0xdb3
// Size: 0x1b9
function heli_default_target_setup()
{
    up_offset = undefined;
    forward_offset = undefined;
    
    switch ( self.vehicletype )
    {
        case #"hash_7cbaf54a9583848":
        case #"hash_657241a1e3f14ce7":
        case #"hash_70514937441959cb":
        case #"hash_d29d1c641f811715":
            forward_offset = 600;
            up_offset = -100;
            break;
        case #"hash_b5fd54495f0348e2":
        case #"hash_beeeed34c5017c21":
        case #"hash_bef1e634c503afb3":
            forward_offset = 600;
            up_offset = -100;
            break;
        case #"hash_b55ba82d2cec3b73":
            forward_offset = 600;
            up_offset = -100;
            break;
        case #"hash_1a1d956bedda953d":
        case #"hash_8c12ae8d5afba7a6":
            forward_offset = 600;
            up_offset = -204;
            break;
        default:
            assertmsg( "Need to set up this heli type in the _attack_heli.gsc script: " + self.vehicletype );
            break;
    }
    
    self.targetdefault = spawn( "script_origin", self.origin );
    self.targetdefault.angles = self.angles;
    self.targetdefault.origin = self.origin;
    ent = spawnstruct();
    ent.entity = self.targetdefault;
    ent.forward = forward_offset;
    ent.up = up_offset;
    ent translate_local();
    self.targetdefault linkto( self );
    self.targetdefault thread heli_default_target_cleanup( self );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0xf74
// Size: 0x29
function get_turrets()
{
    if ( isdefined( self.turrets ) )
    {
        return self.turrets;
    }
    
    setup_miniguns();
    return self.turrets;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0xfa6
// Size: 0x73
function setup_miniguns()
{
    assertex( !isdefined( self.turrets ), ".turrets are already defined" );
    self.turrettype = "miniguns";
    self.minigunsspinning = 0;
    self.firingguns = 0;
    
    if ( !isdefined( self.mgturret ) )
    {
        return;
    }
    
    self.turrets = self.mgturret;
    array_thread( self.turrets, &littlebird_turrets_think, self );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x1021
// Size: 0x29
function heli_default_target_cleanup( eheli )
{
    eheli waittill_either( "death", "vehicle_crashDone" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 2
// Checksum 0x0, Offset: 0x1052
// Size: 0xac
function start_circling_heli( heli_targetname, heli_points )
{
    if ( !isdefined( heli_targetname ) )
    {
        heli_targetname = "kill_heli";
    }
    
    heli = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive( heli_targetname );
    heli.startingorigin = spawn( "script_origin", heli.origin );
    heli thread delete_on_death( heli.startingorigin );
    heli.circling = 1;
    heli.allowshoot = 1;
    heli.firingmissiles = 0;
    heli thread notify_disable();
    heli thread notify_enable();
    thread kill_heli_logic( heli, heli_points );
    return heli;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 2
// Checksum 0x0, Offset: 0x1107
// Size: 0x302
function kill_heli_logic( heli, heli_points )
{
    if ( !isdefined( heli ) )
    {
        heli = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive( "kill_heli" );
        assert( isdefined( heli ) );
        heli.allowshoot = 1;
        heli.firingmissiles = 0;
        heli thread notify_disable();
        heli thread notify_enable();
    }
    
    basespeed = undefined;
    
    if ( !isdefined( heli.script_airspeed ) )
    {
        basespeed = 40;
    }
    else
    {
        basespeed = heli.script_airspeed;
    }
    
    if ( !isdefined( level.enemy_heli_killed ) )
    {
        level.enemy_heli_killed = 0;
    }
    
    if ( !isdefined( level.commander_speaking ) )
    {
        level.commander_speaking = 0;
    }
    
    if ( !isdefined( level.enemy_heli_attacking ) )
    {
        level.enemy_heli_attacking = 0;
    }
    
    level.attack_heli_safe_volumes = undefined;
    volumes = getentarray( "attack_heli_safe_volume", "script_noteworthy" );
    
    if ( volumes.size > 0 )
    {
        level.attack_heli_safe_volumes = volumes;
    }
    
    if ( !level.enemy_heli_killed )
    {
        thread dialog_nags_heli( heli );
    }
    
    if ( !isdefined( heli.helicopter_predator_target_shader ) )
    {
        switch ( heli.vehicletype )
        {
            case #"hash_b5fd54495f0348e2":
            case #"hash_beeeed34c5017c21":
            case #"hash_bef1e634c503afb3":
                target_set( heli, ( 0, 0, -80 ) );
                break;
            case #"hash_7cbaf54a9583848":
            case #"hash_657241a1e3f14ce7":
            case #"hash_70514937441959cb":
            case #"hash_d29d1c641f811715":
                target_set( heli, ( 0, 0, -96 ) );
                break;
            case #"hash_b55ba82d2cec3b73":
                target_set( heli, ( 0, 0, -96 ) );
                break;
            case #"hash_1a1d956bedda953d":
            case #"hash_8c12ae8d5afba7a6":
                target_set( heli, ( 0, 0, -80 ) );
                break;
            default:
                assertmsg( "Need to set up this heli type in the _attack_heli.gsc script: " + self.vehicletype );
                break;
        }
        
        target_setjavelinonly( heli, 1 );
    }
    
    heli thread heli_damage_monitor();
    heli thread heli_death_monitor();
    heli endon( "death" );
    heli endon( "heli_players_dead" );
    heli endon( "returning_home" );
    heli setvehweapon( "turret_attackheli" );
    
    if ( !isdefined( heli.circling ) )
    {
        heli.circling = 0;
    }
    
    if ( !heli.circling )
    {
        heli setneargoalnotifydist( 100 );
        
        if ( !isdefined( heli.dontwaitforpathend ) )
        {
            heli waittill( "reached_dynamic_path_end" );
        }
    }
    else
    {
        heli setneargoalnotifydist( 500 );
        heli waittill( "near_goal" );
    }
    
    heli thread heli_shoot_think();
    
    if ( heli.circling )
    {
        heli thread heli_circling_think( heli_points, basespeed );
        return;
    }
    
    heli thread heli_goal_think( basespeed );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 2
// Checksum 0x0, Offset: 0x1411
// Size: 0x194
function heli_circling_think( heli_points, basespeed )
{
    if ( !isdefined( heli_points ) )
    {
        heli_points = "attack_heli_circle_node";
    }
    
    points = getentarray( heli_points, "targetname" );
    
    if ( !isdefined( points ) || points.size < 1 )
    {
        points = getstructarray( heli_points, "targetname" );
    }
    
    assert( isdefined( points ) );
    heli = self;
    heli endon( "stop_circling" );
    heli endon( "death" );
    heli endon( "returning_home" );
    heli endon( "heli_players_dead" );
    
    for ( ;; )
    {
        heli vehicle_setspeed( basespeed, basespeed / 4, basespeed / 4 );
        heli setneargoalnotifydist( 100 );
        player = level.player;
        playerorigin = player.origin;
        heli setlookatent( player );
        player_location = getclosest( playerorigin, points );
        heli_locations = getentarray( player_location.target, "targetname" );
        
        if ( !isdefined( heli_locations ) || heli_locations.size < 1 )
        {
            heli_locations = getstructarray( player_location.target, "targetname" );
        }
        
        assert( isdefined( heli_locations ) );
        goal = heli_locations[ randomint( heli_locations.size ) ];
        heli setvehgoalpos( goal.origin, 1 );
        heli waittill( "near_goal" );
        
        if ( !isdefined( player.is_controlling_uav ) )
        {
            wait 1;
            wait randomfloatrange( 0.8, 1.3 );
        }
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x15ad
// Size: 0x3a4
function heli_goal_think( basespeed )
{
    self endon( "death" );
    points = getentarray( "kill_heli_spot", "targetname" );
    assert( isdefined( points ) );
    heli = self;
    goal = getclosest( heli.origin, points );
    current_node = goal;
    assert( isdefined( goal ) );
    heli endon( "death" );
    heli endon( "returning_home" );
    heli endon( "heli_players_dead" );
    var_66a7fbc9d133f2bf = undefined;
    
    for ( ;; )
    {
        wait 0.05;
        heli vehicle_setspeed( basespeed, basespeed / 2, basespeed / 10 );
        heli setneargoalnotifydist( 100 );
        player = level.player;
        playerorigin = player.origin;
        
        if ( goal == current_node && heli.istakingdamage )
        {
            linked = get_linked_points( heli, goal, points, player, playerorigin );
            goal = getclosest( playerorigin, linked );
        }
        
        heli setvehgoalpos( goal.origin, 1 );
        heli.moving = 1;
        player = level.player;
        
        if ( isdefined( self.etarget ) && isdefined( self.etarget.classname ) && self.etarget.classname == "script_origin" )
        {
            var_66a7fbc9d133f2bf = player;
        }
        else if ( isdefined( self.etarget ) )
        {
            var_66a7fbc9d133f2bf = self.etarget;
        }
        else
        {
            var_66a7fbc9d133f2bf = self.targetdefault;
        }
        
        heli setlookatent( var_66a7fbc9d133f2bf );
        heli waittill( "near_goal" );
        heli.moving = 0;
        
        if ( level.gameskill == 0 || level.gameskill == 1 )
        {
            while ( player_is_aiming_with_rocket( heli ) )
            {
                wait 0.5;
            }
            
            wait 3;
        }
        
        player = level.player;
        playerorigin = player.origin;
        linked = get_linked_points( heli, goal, points, player, playerorigin );
        linked[ linked.size ] = goal;
        current_node = goal;
        player_location = getclosest( playerorigin, points );
        var_30ba4289875dd691 = getclosest( playerorigin, linked );
        
        foreach ( point in linked )
        {
            if ( player sightconetrace( point.origin, heli ) != 1 )
            {
                linked = array_remove( linked, point );
            }
        }
        
        closest_neighbor = getclosest( playerorigin, linked );
        
        if ( linked.size < 2 )
        {
            goal = var_30ba4289875dd691;
        }
        else if ( closest_neighbor != player_location )
        {
            goal = closest_neighbor;
        }
        else
        {
            excluders = [];
            excluders[ 0 ] = closest_neighbor;
            linked = get_array_of_closest( playerorigin, linked, excluders, 2 );
            irand = randomint( linked.size );
            
            if ( randomint( 100 ) > 50 )
            {
                goal = linked[ irand ];
            }
            else
            {
                goal = player_location;
            }
        }
        
        var_7a0c1f650bbe34c6 = randomfloatrange( level.attackhelimovetime - 0.5, level.attackhelimovetime + 0.5 );
        waittill_notify_or_timeout( "damage_by_player", var_7a0c1f650bbe34c6 );
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x1959
// Size: 0x6d, Type: bool
function player_is_aiming_with_rocket( eheli )
{
    if ( !level.player usingantiairweapon() )
    {
        return false;
    }
    
    if ( !level.player adsbuttonpressed() )
    {
        return false;
    }
    
    playereye = level.player geteye();
    
    if ( sighttracepassed( playereye, eheli.origin, 0, level.player ) )
    {
        return true;
    }
    
    return false;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x19cf
// Size: 0x268
function heli_shoot_think()
{
    self endon( "stop_shooting" );
    self endon( "death" );
    self endon( "heli_players_dead" );
    thread heli_missiles_think();
    var_13e19e01df44d953 = level.attackhelirange * level.attackhelirange;
    level.attackheligraceperiod = 0;
    
    while ( isdefined( self ) )
    {
        wait randomfloatrange( 0.8, 1.3 );
        
        if ( !heli_has_target() || !heli_has_player_target() )
        {
            etarget = heli_get_target_player_only();
            
            if ( isplayer( etarget ) )
            {
                self.etarget = etarget;
            }
        }
        
        if ( heli_has_player_target() )
        {
            if ( !heli_can_see_target() || level.attackheligraceperiod == 1 )
            {
                etarget = heli_get_target_ai_only();
                self.etarget = etarget;
            }
        }
        
        if ( isdefined( self.heli_lastattacker ) && isplayer( self.heli_lastattacker ) )
        {
            self.etarget = self.heli_lastattacker;
        }
        else if ( !heli_has_target() )
        {
            etarget = heli_get_target_ai_only();
            self.etarget = etarget;
        }
        
        if ( !heli_has_target() )
        {
            continue;
        }
        
        if ( self.etarget is_hidden_from_heli( self ) )
        {
            continue;
        }
        
        if ( heli_has_target() && distancesquared( self.etarget.origin, self.origin ) > var_13e19e01df44d953 )
        {
            continue;
        }
        
        if ( self.turrettype == "default" && heli_has_player_target() )
        {
            miss_player( self.etarget );
            wait randomfloatrange( 0.8, 1.3 );
            miss_player( self.etarget );
            wait randomfloatrange( 0.8, 1.3 );
            
            while ( can_see_player( self.etarget ) && !self.etarget is_hidden_from_heli( self ) )
            {
                fire_guns();
                wait randomfloatrange( 2, 4 );
            }
            
            continue;
        }
        
        if ( isplayer( self.etarget ) || isai( self.etarget ) )
        {
            fire_guns();
        }
        
        if ( isplayer( self.etarget ) )
        {
            thread player_grace_period( self );
        }
        
        waittill_notify_or_timeout( "damage_by_player", level.attackhelitargetreaquire );
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x1c3f
// Size: 0x45
function player_grace_period( eheli )
{
    level notify( "player_is_heli_target" );
    level endon( "player_is_heli_target" );
    level.attackheligraceperiod = 1;
    eheli waittill_notify_or_timeout( "damage_by_player", level.attackheliplayerbreak );
    level.attackheligraceperiod = 0;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x1c8c
// Size: 0x89
function heli_can_see_target()
{
    if ( !isdefined( self.etarget ) )
    {
        return 0;
    }
    
    org = self.etarget.origin + ( 0, 0, 32 );
    
    if ( isplayer( self.etarget ) )
    {
        org = self.etarget geteye();
    }
    
    var_4b9a91106f629c2b = self gettagorigin( "tag_flash" );
    can_sight = sighttracepassed( var_4b9a91106f629c2b, org, 0, self );
    return can_sight;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x1d1e
// Size: 0x2a
function heli_has_player_target()
{
    if ( !isdefined( self.etarget ) )
    {
        return 0;
    }
    
    if ( isplayer( self.etarget ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x1d50
// Size: 0x42
function heli_has_target()
{
    if ( !isdefined( self.etarget ) )
    {
        return 0;
    }
    
    if ( !isalive( self.etarget ) )
    {
        return 0;
    }
    
    if ( self.etarget == self.targetdefault )
    {
        return 0;
    }
    
    return 1;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x1d9a
// Size: 0x60
function heli_get_target()
{
    etarget = scripts\sp\helicopter_globals::getenemytarget( level.attackhelirange, level.attackhelifov, 1, 1, 0, 1, level.attackheliexcluders );
    
    if ( isdefined( etarget ) && isplayer( etarget ) )
    {
        etarget = self.targetdefault;
    }
    
    if ( !isdefined( etarget ) )
    {
        etarget = self.targetdefault;
    }
    
    return etarget;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x1e03
// Size: 0x51
function heli_get_target_player_only()
{
    var_a3658e5ee7a7dda1 = getaiarray( "allies" );
    etarget = scripts\sp\helicopter_globals::getenemytarget( level.attackhelirange, level.attackhelifov, 1, 0, 0, 0, var_a3658e5ee7a7dda1 );
    
    if ( !isdefined( etarget ) )
    {
        etarget = self.targetdefault;
    }
    
    return etarget;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x1e5d
// Size: 0x46
function heli_get_target_ai_only()
{
    etarget = scripts\sp\helicopter_globals::getenemytarget( level.attackhelirange, level.attackhelifov, 1, 1, 0, 1, level.players );
    
    if ( !isdefined( etarget ) )
    {
        etarget = self.targetdefault;
    }
    
    return etarget;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x1eac
// Size: 0x230
function heli_missiles_think()
{
    if ( !isdefined( self.script_missiles ) )
    {
        return;
    }
    
    self endon( "death" );
    self endon( "heli_players_dead" );
    self endon( "stop_shooting" );
    ishots = undefined;
    defaultweapon = "turret_attackheli";
    weaponname = "missile_attackheli";
    var_20b553d85ec7bc57 = undefined;
    var_8f26a943256ed058 = undefined;
    tags = [];
    
    switch ( self.vehicletype )
    {
        case #"hash_beeeed34c5017c21":
            ishots = 1;
            var_20b553d85ec7bc57 = 1;
            var_8f26a943256ed058 = 0.5;
            tags[ 0 ] = "tag_store_L_2_a";
            tags[ 1 ] = "tag_store_R_2_a";
            tags[ 2 ] = "tag_store_L_2_b";
            tags[ 3 ] = "tag_store_R_2_b";
            tags[ 4 ] = "tag_store_L_2_c";
            tags[ 5 ] = "tag_store_R_2_c";
            tags[ 6 ] = "tag_store_L_2_d";
            tags[ 7 ] = "tag_store_R_2_d";
            break;
        case #"hash_8c12ae8d5afba7a6":
        case #"hash_b55ba82d2cec3b73":
            ishots = 1;
            var_20b553d85ec7bc57 = 1;
            var_8f26a943256ed058 = 0.5;
            tags[ 0 ] = "tag_missile_left";
            tags[ 1 ] = "tag_missile_right";
            break;
        default:
            assertmsg( "Missiles have not been setup for helicoper model: " + self.vehicletype );
            break;
    }
    
    nextmissiletag = -1;
    
    while ( true )
    {
        wait 0.05;
        self waittill( "fire_missiles", other );
        
        if ( !isplayer( other ) )
        {
            continue;
        }
        
        player = other;
        
        if ( !player_is_good_missile_target( player ) )
        {
            continue;
        }
        
        for ( i = 0; i < ishots ; i++ )
        {
            nextmissiletag++;
            
            if ( nextmissiletag >= tags.size )
            {
                nextmissiletag = 0;
            }
            
            self setvehweapon( weaponname );
            self.firingmissiles = 1;
            emissile = self fireweapon( tags[ nextmissiletag ], player );
            emissile thread missilelosetarget( var_8f26a943256ed058 );
            emissile thread missile_earthquake();
            
            if ( i < ishots - 1 )
            {
                wait var_20b553d85ec7bc57;
            }
        }
        
        self.firingmissiles = 0;
        self setvehweapon( defaultweapon );
        wait 10;
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x20e4
// Size: 0x1f
function player_is_good_missile_target( player )
{
    if ( self.moving )
    {
        return 0;
    }
    
    return 1;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x210b
// Size: 0x6e
function missile_earthquake()
{
    if ( distancesquared( self.origin, level.player.origin ) > 9000000 )
    {
        return;
    }
    
    org = self.origin;
    
    while ( isdefined( self ) )
    {
        org = self.origin;
        wait 0.1;
    }
    
    earthquake( 0.7, 1.5, org, 1600 );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x2181
// Size: 0x27
function missilelosetarget( fdelay )
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    wait fdelay;
    
    if ( isdefined( self ) )
    {
        self missile_cleartarget();
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x21b0
// Size: 0x53
function get_different_player( player )
{
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( player != level.players[ i ] )
        {
            return level.players[ i ];
        }
    }
    
    return level.players[ 0 ];
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x220c
// Size: 0x34
function notify_disable()
{
    self notify( "notify_disable_thread" );
    self endon( "notify_disable_thread" );
    self endon( "death" );
    self endon( "heli_players_dead" );
    
    for ( ;; )
    {
        self waittill( "disable_turret" );
        self.allowshoot = 0;
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x2248
// Size: 0x35
function notify_enable()
{
    self notify( "notify_enable_thread" );
    self endon( "notify_enable_thread" );
    self endon( "death" );
    self endon( "heli_players_dead" );
    
    for ( ;; )
    {
        self waittill( "enable_turret" );
        self.allowshoot = 1;
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x2285
// Size: 0xce
function fire_guns()
{
    switch ( self.turrettype )
    {
        case #"hash_7038dec66d8275be":
            burstsize = randomintrange( 5, 10 );
            firetime = weaponfiretime( "turret_attackheli" );
            turret_default_fire( self.etarget, burstsize, firetime );
            break;
        case #"hash_5eb3a214d0fb4f01":
            burstsize = getburstsize( self.etarget );
            
            if ( self.allowshoot && !self.firingmissiles )
            {
                turret_minigun_fire( self.etarget, burstsize );
            }
            
            break;
        default:
            assertmsg( "Gun firing logic has not been set up in the _attack_heli.gsc script for helicopter type: " + self.turrettype );
            break;
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x235b
// Size: 0x7d
function getburstsize( etarget )
{
    burstsize = undefined;
    
    if ( !isplayer( etarget ) )
    {
        burstsize = level.attackheliaiburstsize;
        return burstsize;
    }
    
    switch ( level.gameskill )
    {
        case 0:
        case 1:
        case 2:
        case 3:
            burstsize = randomintrange( 2, 3 );
            break;
    }
    
    return burstsize;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x23e1
// Size: 0x3e
function fire_missiles( fdelay )
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    wait fdelay;
    
    if ( !isplayer( self.etarget ) )
    {
        return;
    }
    
    self notify( "fire_missiles", self.etarget );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 3
// Checksum 0x0, Offset: 0x2427
// Size: 0x87
function turret_default_fire( etarget, burstsize, firetime )
{
    thread fire_missiles( randomfloatrange( 0.2, 2 ) );
    
    for ( i = 0; i < burstsize ; i++ )
    {
        self setturrettargetent( etarget, randomvector( 50 ) + ( 0, 0, 32 ) );
        
        if ( self.allowshoot && !self.firingmissiles )
        {
            self fireweapon();
        }
        
        wait firetime;
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 3
// Checksum 0x0, Offset: 0x24b6
// Size: 0x101
function turret_minigun_fire( etarget, burstsize, var_f4f31ef6fe61050a )
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    self notify( "firing_miniguns" );
    self endon( "firing_miniguns" );
    turrets = get_turrets();
    array_thread( turrets, &turret_minigun_target_track, etarget, self );
    
    if ( !self.minigunsspinning )
    {
        self.firingguns = 1;
        thread play_sound_on_tag( "littlebird_gatling_spinup", "tag_flash" );
        wait 2.1;
        thread play_loop_sound_on_tag( "littlebird_minigun_spinloop", "tag_flash" );
    }
    
    self.minigunsspinning = 1;
    
    if ( !isdefined( var_f4f31ef6fe61050a ) )
    {
        var_f4f31ef6fe61050a = 3;
    }
    
    var_65213dd2c413d808 = 0.5;
    
    if ( var_65213dd2c413d808 > var_f4f31ef6fe61050a )
    {
        var_65213dd2c413d808 = var_f4f31ef6fe61050a;
    }
    
    if ( var_65213dd2c413d808 > 0 )
    {
        wait randomfloatrange( var_65213dd2c413d808, var_f4f31ef6fe61050a );
    }
    
    minigun_fire( etarget, burstsize );
    turrets = get_turrets();
    array_call( turrets, &stopfiring );
    thread minigun_spindown( etarget );
    self notify( "stopping_firing" );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 2
// Checksum 0x0, Offset: 0x25bf
// Size: 0x94
function minigun_fire( etarget, burstsize )
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    
    if ( isplayer( etarget ) )
    {
        self endon( "cant_see_player" );
    }
    
    turrets = get_turrets();
    array_call( turrets, &startfiring );
    wait randomfloatrange( 1, 2 );
    
    if ( isplayer( etarget ) )
    {
        thread target_track( etarget );
    }
    
    if ( isplayer( etarget ) )
    {
        var_7a0c1f650bbe34c6 = randomfloatrange( 0.5, 3 );
        thread fire_missiles( var_7a0c1f650bbe34c6 );
    }
    
    wait burstsize;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x265b
// Size: 0x5c
function target_track( etarget )
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    self endon( "stopping_firing" );
    self notify( "tracking_player" );
    self endon( "tracking_player" );
    
    while ( true )
    {
        if ( !can_see_player( etarget ) )
        {
            break;
        }
        
        wait 0.5;
    }
    
    wait level.attackhelitimeout;
    self notify( "cant_see_player" );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 2
// Checksum 0x0, Offset: 0x26bf
// Size: 0xab
function turret_minigun_target_track( etarget, eheli )
{
    eheli endon( "death" );
    eheli endon( "heli_players_dead" );
    self notify( "miniguns_have_new_target" );
    self endon( "miniguns_have_new_target" );
    
    if ( !isplayer( etarget ) && isai( etarget ) && level.attackhelikillsai == 0 )
    {
        var_692e37fea1e1cc0c = spawn( "script_origin", etarget.origin + ( 0, 0, 100 ) );
        var_692e37fea1e1cc0c linkto( etarget );
        thread minigun_ai_target_cleanup( var_692e37fea1e1cc0c );
        etarget = var_692e37fea1e1cc0c;
    }
    
    while ( true )
    {
        wait 0.5;
        self settargetentity( etarget );
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x2772
// Size: 0x23
function minigun_ai_target_cleanup( var_692e37fea1e1cc0c )
{
    waittill_either( "death", "miniguns_have_new_target" );
    var_692e37fea1e1cc0c delete();
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x279d
// Size: 0x52
function minigun_spindown( etarget )
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    self endon( "firing_miniguns" );
    
    if ( isplayer( etarget ) )
    {
        wait randomfloatrange( 3, 4 );
    }
    else
    {
        wait randomfloatrange( 1, 2 );
    }
    
    thread minigun_spindown_sound();
    self.firingguns = 0;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x27f7
// Size: 0x2b
function minigun_spindown_sound()
{
    self notify( "stop sound" + "littlebird_minigun_spinloop" );
    self.minigunsspinning = 0;
    play_sound_on_tag( "littlebird_gatling_cooldown", "tag_flash" );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x282a
// Size: 0xcd
function miss_player( player )
{
    println( "<dev string:x1c>" );
    forward = anglestoforward( level.player.angles );
    forwardfar = forward * 400;
    miss_vec = forwardfar + randomvector( 50 );
    burstsize = randomintrange( 10, 20 );
    firetime = weaponfiretime( "turret_attackheli" );
    
    for ( i = 0; i < burstsize ; i++ )
    {
        miss_vec = forwardfar + randomvector( 50 );
        self setturrettargetent( player, miss_vec );
        
        if ( self.allowshoot )
        {
            self fireweapon();
        }
        
        wait firetime;
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x28ff
// Size: 0x8a
function can_see_player( player )
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    var_4b9a91106f629c2b = self gettagorigin( "tag_flash" );
    pos = ( 0, 0, 0 );
    
    if ( isplayer( player ) )
    {
        pos = player geteye();
    }
    else
    {
        pos = player.origin;
    }
    
    if ( sighttracepassed( var_4b9a91106f629c2b, pos, 0, undefined ) )
    {
        return 1;
    }
    
    println( "<dev string:x46>" );
    return 0;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 5
// Checksum 0x0, Offset: 0x2991
// Size: 0x10f
function get_linked_points( heli, goal, points, player, playerorigin )
{
    linked = [];
    tokens = strtok( goal.script_linkto, " " );
    
    for ( i = 0; i < points.size ; i++ )
    {
        for ( j = 0; j < tokens.size ; j++ )
        {
            if ( points[ i ].script_linkname == tokens[ j ] )
            {
                linked[ linked.size ] = points[ i ];
            }
        }
    }
    
    foreach ( point in linked )
    {
        if ( point.origin[ 2 ] < playerorigin[ 2 ] )
        {
            linked = array_remove( linked, point );
        }
    }
    
    return linked;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x2aa9
// Size: 0xb2
function heli_damage_monitor()
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    self endon( "crashing" );
    self endon( "leaving" );
    self.damagetaken = 0;
    self.seen_attacker = undefined;
    
    for ( ;; )
    {
        self waittill( "damage", damage, attacker, direction_vec, p, type );
        
        if ( !isdefined( attacker ) || !isplayer( attacker ) )
        {
            continue;
        }
        
        self notify( "damage_by_player" );
        thread heli_damage_update();
        thread can_see_attacker_for_a_bit( attacker );
        
        if ( is_damagefeedback_enabled() )
        {
            attacker thread updatedamagefeedback();
        }
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x2b63
// Size: 0x37
function heli_damage_update()
{
    self notify( "taking damage" );
    self endon( "taking damage" );
    self endon( "death" );
    self endon( "heli_players_dead" );
    self.istakingdamage = 1;
    wait 1;
    self.istakingdamage = 0;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x2ba2
// Size: 0x4c
function can_see_attacker_for_a_bit( attacker )
{
    self notify( "attacker_seen" );
    self endon( "attacker_seen" );
    self.seen_attacker = attacker;
    self.heli_lastattacker = attacker;
    wait level.attackhelimemory;
    self.heli_lastattacker = undefined;
    self.seen_attacker = undefined;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x2bf6
// Size: 0x90, Type: bool
function is_hidden_from_heli( heli )
{
    if ( isdefined( heli.seen_attacker ) )
    {
        if ( heli.seen_attacker == self )
        {
            return false;
        }
    }
    
    if ( isdefined( level.attack_heli_safe_volumes ) )
    {
        foreach ( volume in level.attack_heli_safe_volumes )
        {
            if ( self istouching( volume ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x2c8f
// Size: 0x6c
function updatedamagefeedback()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.hud_damagefeedback setshader( "damage_feedback", 24, 48 );
    self playlocalsound( "player_feedback_hit_alert" );
    self.hud_damagefeedback.alpha = 1;
    self.hud_damagefeedback fadeovertime( 1 );
    self.hud_damagefeedback.alpha = 0;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x2d03
// Size: 0xfa
function damage_feedback_setup()
{
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        player.hud_damagefeedback = newclienthudelem( player );
        player.hud_damagefeedback.horzalign = "center";
        player.hud_damagefeedback.vertalign = "middle";
        player.hud_damagefeedback.x = -12;
        player.hud_damagefeedback.y = -12;
        player.hud_damagefeedback.alpha = 0;
        player.hud_damagefeedback.archived = 1;
        player.hud_damagefeedback setshader( "damage_feedback", 24, 48 );
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x2e05
// Size: 0x2a
function heli_death_monitor()
{
    self waittill( "death" );
    level notify( "attack_heli_destroyed" );
    level.enemy_heli_killed = 1;
    wait 15;
    level.enemy_heli_attacking = 0;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x2e37
// Size: 0x6a
function dialog_nags_heli( heli )
{
    heli endon( "death" );
    heli endon( "heli_players_dead" );
    wait 30;
    
    if ( !level.enemy_heli_attacking )
    {
        return;
    }
    
    commander_dialog( "co_cf_cmd_heli_small_fire" );
    
    if ( !level.enemy_heli_attacking )
    {
        return;
    }
    
    commander_dialog( "co_cf_cmd_rpg_stinger" );
    wait 30;
    
    if ( !level.enemy_heli_attacking )
    {
        return;
    }
    
    commander_dialog( "co_cf_cmd_heli_wonders" );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x2ea9
// Size: 0x5d
function commander_dialog( dialog_line )
{
    while ( level.commander_speaking )
    {
        wait 1;
    }
    
    level.commander_speaking = 1;
    level.player playsound( dialog_line, "sounddone" );
    level.player waittill( "sounddone" );
    wait 0.5;
    level.commander_speaking = 0;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x2f0e
// Size: 0x69, Type: bool
function usingantiairweapon()
{
    weapon = self getcurrentweapon();
    
    if ( !isdefined( weapon ) )
    {
        return false;
    }
    
    weaponname = tolower( weapon.basename );
    
    if ( issubstr( weaponname, "rpg" ) )
    {
        return true;
    }
    
    if ( issubstr( weaponname, "stinger" ) )
    {
        return true;
    }
    
    if ( issubstr( weaponname, "at4" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x2f80
// Size: 0x43
function heli_spotlight_cleanup( stag )
{
    waittill_any_3( "death", "vehicle_crashDone", "turn_off_spotlight" );
    self.spotlight = undefined;
    
    if ( isdefined( self ) )
    {
        stopfxontag( getfx( "_attack_heli_spotlight" ), self, stag );
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x2fcb
// Size: 0x207
function heli_spotlight_create_default_targets( default_target )
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    original_ent = self.targetdefault;
    
    if ( isdefined( default_target ) )
    {
        original_ent = default_target;
    }
    
    original_ent.targetname = "original_ent";
    self.left_ent = spawn( "script_origin", original_ent.origin );
    self.left_ent.origin = original_ent.origin;
    self.left_ent.angles = original_ent.angles;
    self.left_ent.targetname = "left_ent";
    self.right_ent = spawn( "script_origin", original_ent.origin );
    self.right_ent.origin = original_ent.origin;
    self.right_ent.angles = original_ent.angles;
    self.right_ent.targetname = "right_ent";
    ent = spawnstruct();
    ent.entity = self.left_ent;
    ent.right = 250;
    ent translate_local();
    self.left_ent linkto( self );
    ent2 = spawnstruct();
    ent2.entity = self.right_ent;
    ent2.right = -250;
    ent2 translate_local();
    self.right_ent linkto( self );
    aim_ents = [];
    aim_ents[ 0 ] = original_ent;
    aim_ents[ 1 ] = self.left_ent;
    aim_ents[ 2 ] = self.right_ent;
    level.spotlight_aim_ents = aim_ents;
    self.spottarget = original_ent;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x31da
// Size: 0x64
function heli_spotlight_destroy_default_targets()
{
    if ( isdefined( level.spotlight_aim_ents ) )
    {
        foreach ( aim_ent in level.spotlight_aim_ents )
        {
            if ( isdefined( aim_ent ) )
            {
                aim_ent delete();
            }
        }
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x3246
// Size: 0xba
function heli_spotlight_aim( var_8b9ffc712b48d29e )
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    
    if ( self.vehicletype != "littlebird" )
    {
        return;
    }
    
    thread heli_spotlight_think( var_8b9ffc712b48d29e );
    var_943f3eecf3858541 = undefined;
    
    while ( true )
    {
        wait 0.05;
        
        switch ( self.vehicletype )
        {
            case #"hash_1a1d956bedda953d":
            case #"hash_8c12ae8d5afba7a6":
                var_943f3eecf3858541 = self.spottarget;
                break;
            default:
                var_943f3eecf3858541 = self.etarget;
                break;
        }
        
        if ( isdefined( var_943f3eecf3858541 ) )
        {
            self setturrettargetent( var_943f3eecf3858541, ( 0, 0, 0 ) );
        }
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x3308
// Size: 0xbe
function heli_spotlight_think( var_8b9ffc712b48d29e )
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    heli_spotlight_create_default_targets();
    array_thread( level.spotlight_aim_ents, &heli_spotlight_aim_ents_cleanup, self );
    
    if ( isdefined( var_8b9ffc712b48d29e ) )
    {
        self thread [[ var_8b9ffc712b48d29e ]]();
        return;
    }
    
    while ( true )
    {
        wait randomfloatrange( 1, 3 );
        
        if ( heli_has_player_target() && !within_player_fov() )
        {
            self.spottarget = self.etarget;
            continue;
        }
        
        irand = randomint( level.spotlight_aim_ents.size );
        self.targetdefault = level.spotlight_aim_ents[ irand ];
        self.spottarget = self.targetdefault;
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x33ce
// Size: 0x7c
function within_player_fov()
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    
    if ( !isdefined( self.etarget ) )
    {
        return 0;
    }
    
    if ( !isplayer( self.etarget ) )
    {
        return 0;
    }
    
    player = self.etarget;
    var_594475c14b9b58e5 = within_fov( player geteye(), player getplayerangles(), self.origin, level.cosine[ "35" ] );
    return var_594475c14b9b58e5;
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x3453
// Size: 0x29
function heli_spotlight_aim_ents_cleanup( eheli )
{
    eheli waittill_either( "death", "vehicle_crashDone" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x3484
// Size: 0x82
function littlebird_turrets_think( eheli )
{
    eturret = self;
    eturret scripts\common\vehicle_code::turret_set_default_on_mode( "manual" );
    
    if ( isdefined( eheli.targetdefault ) )
    {
        eturret settargetentity( eheli.targetdefault );
    }
    
    eturret setmode( "manual" );
    eheli waittill( "death" );
    
    if ( isdefined( eheli.firingguns ) && eheli.firingguns == 1 )
    {
        thread minigun_spindown_sound();
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x350e
// Size: 0x4b
function attack_heli_cleanup()
{
    waittill_either( "death", "vehicle_crashDone" );
    
    if ( isdefined( self.attractor ) )
    {
        missile_deleteattractor( self.attractor );
    }
    
    if ( isdefined( self.attractor2 ) )
    {
        missile_deleteattractor( self.attractor2 );
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 1
// Checksum 0x0, Offset: 0x3561
// Size: 0x14a
function heli_default_missiles_on( var_f5c2e7c08c50919f )
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    self endon( "stop_default_heli_missiles" );
    self.preferredtarget = undefined;
    
    while ( isdefined( self ) )
    {
        wait 0.05;
        etarget = undefined;
        ishots = undefined;
        delay = undefined;
        self.preferredtarget = undefined;
        var_9a287933c5bfbd = undefined;
        
        if ( isdefined( self.currentnode ) && isdefined( self.currentnode.target ) )
        {
            var_9a287933c5bfbd = getent_or_struct( self.currentnode.target, "targetname" );
        }
        
        if ( isdefined( var_9a287933c5bfbd ) && isdefined( var_9a287933c5bfbd.script_linkto ) )
        {
            self.preferredtarget = getent_or_struct( var_9a287933c5bfbd.script_linkto, "script_linkname" );
        }
        
        if ( isdefined( self.preferredtarget ) )
        {
            etarget = self.preferredtarget;
            ishots = etarget.script_shotcount;
            delay = etarget.script_delay;
            var_9a287933c5bfbd waittill( "trigger" );
        }
        else
        {
            waittill_any_2( "near_goal", "goal" );
        }
        
        if ( isdefined( etarget ) )
        {
            thread heli_fire_missiles( etarget, ishots, delay, var_f5c2e7c08c50919f );
        }
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x36b3
// Size: 0xa
function heli_default_missiles_off()
{
    self notify( "stop_default_heli_missiles" );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 3
// Checksum 0x0, Offset: 0x36c5
// Size: 0xc9
function heli_spotlight_on( stag, var_af408e1e3636ab16, var_d8d5db80fb486480 )
{
    if ( !isdefined( stag ) )
    {
        stag = "tag_barrel";
    }
    
    if ( !isdefined( var_af408e1e3636ab16 ) )
    {
        var_af408e1e3636ab16 = 0;
    }
    
    if ( !isdefined( var_d8d5db80fb486480 ) )
    {
        var_d8d5db80fb486480 = 0;
    }
    
    playfxontag( getfx( "_attack_heli_spotlight" ), self, stag );
    self.spotlight = 1;
    thread heli_spotlight_cleanup( stag );
    
    if ( var_d8d5db80fb486480 )
    {
        self setturrettargetent( level.player );
        return;
    }
    
    if ( var_af408e1e3636ab16 )
    {
        self endon( "death" );
        self endon( "heli_players_dead" );
        spawn_origin = self gettagorigin( "tag_origin" );
        
        if ( !isdefined( self.targetdefault ) )
        {
            heli_default_target_setup();
        }
        
        self setturrettargetent( self.targetdefault );
        thread heli_spotlight_aim();
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x3796
// Size: 0xa
function heli_spotlight_off()
{
    self notify( "turn_off_spotlight" );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x37a8
// Size: 0x6c
function heli_spotlight_random_targets_on()
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    self endon( "stop_spotlight_random_targets" );
    
    if ( !isdefined( self.targetdefault ) )
    {
        thread heli_default_target_setup();
    }
    
    if ( !isdefined( self.left_ent ) )
    {
        thread heli_spotlight_think();
    }
    
    while ( isdefined( self ) )
    {
        wait 0.05;
        self setturrettargetent( self.targetdefault, ( 0, 0, 0 ) );
    }
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x381c
// Size: 0xa
function heli_spotlight_random_targets_off()
{
    self notify( "stop_spotlight_random_targets" );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 4
// Checksum 0x0, Offset: 0x382e
// Size: 0x299
function heli_fire_missiles( etarget, ishots, delay, var_f5c2e7c08c50919f )
{
    self endon( "death" );
    self endon( "heli_players_dead" );
    
    if ( isdefined( self.defaultweapon ) )
    {
        defaultweapon = self.defaultweapon;
    }
    else
    {
        defaultweapon = "turret_attackheli";
    }
    
    weaponname = "missile_attackheli";
    
    if ( isdefined( var_f5c2e7c08c50919f ) )
    {
        weaponname = var_f5c2e7c08c50919f;
    }
    
    var_8f26a943256ed058 = undefined;
    tags = [];
    self setvehweapon( defaultweapon );
    
    if ( !isdefined( ishots ) )
    {
        ishots = 1;
    }
    
    if ( !isdefined( delay ) )
    {
        delay = 1;
    }
    
    if ( !isdefined( etarget.classname ) )
    {
        if ( !isdefined( self.dummytarget ) )
        {
            self.dummytarget = spawn( "script_origin", etarget.origin );
            thread delete_on_death( self.dummytarget );
        }
        
        self.dummytarget.origin = etarget.origin;
        etarget = self.dummytarget;
    }
    
    switch ( self.vehicletype )
    {
        case #"hash_beeeed34c5017c21":
            var_8f26a943256ed058 = 0.5;
            tags[ 0 ] = "tag_store_L_2_a";
            tags[ 1 ] = "tag_store_R_2_a";
            tags[ 2 ] = "tag_store_L_2_b";
            tags[ 3 ] = "tag_store_R_2_b";
            tags[ 4 ] = "tag_store_L_2_c";
            tags[ 5 ] = "tag_store_R_2_c";
            tags[ 6 ] = "tag_store_L_2_d";
            tags[ 7 ] = "tag_store_R_2_d";
            break;
        case #"hash_8c12ae8d5afba7a6":
        case #"hash_b55ba82d2cec3b73":
            var_8f26a943256ed058 = 0.5;
            tags[ 0 ] = "tag_missile_left";
            tags[ 1 ] = "tag_missile_right";
            break;
        case #"hash_657241a1e3f14ce7":
            tags[ 0 ] = "tag_missile_left";
            tags[ 1 ] = "tag_missile_right";
            break;
        default:
            assertmsg( "Missiles have not been setup for helicoper model: " + self.vehicletype );
            break;
    }
    
    nextmissiletag = -1;
    
    for ( i = 0; i < ishots ; i++ )
    {
        nextmissiletag++;
        
        if ( nextmissiletag >= tags.size )
        {
            nextmissiletag = 0;
        }
        
        self setvehweapon( weaponname );
        self.firingmissiles = 1;
        emissile = self fireweapon( tags[ nextmissiletag ], etarget );
        emissile thread missile_earthquake();
        
        if ( i < ishots - 1 )
        {
            wait delay;
        }
    }
    
    self.firingmissiles = 0;
    self setvehweapon( defaultweapon );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x3acf
// Size: 0x46
function boneyard_style_heli_missile_attack()
{
    self waittill( "trigger", vehicle );
    struct_arr = getstructarray( self.target, "targetname" );
    struct_arr = array_index_by_script_index( struct_arr );
    boneyard_fire_at_targets( vehicle, struct_arr );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 0
// Checksum 0x0, Offset: 0x3b1d
// Size: 0x38
function boneyard_style_heli_missile_attack_linked()
{
    self waittill( "trigger", vehicle );
    struct_arr = get_linked_structs();
    struct_arr = array_index_by_script_index( struct_arr );
    boneyard_fire_at_targets( vehicle, struct_arr );
}

// Namespace attack_heli / scripts\vehicle\attack_heli
// Params 2
// Checksum 0x0, Offset: 0x3b5d
// Size: 0x155
function boneyard_fire_at_targets( vehicle, struct_arr )
{
    tags = [];
    tags[ 0 ] = "tag_missile_right";
    tags[ 1 ] = "tag_missile_left";
    
    if ( vehicle.vehicletype == "cobra" )
    {
        tags[ 0 ] = "tag_store_L_1_a";
        tags[ 1 ] = "tag_store_R_1_a";
    }
    
    ents = [];
    
    for ( i = 0; i < struct_arr.size ; i++ )
    {
        assertex( isdefined( struct_arr[ i ] ), "boneyard_style_heli_missile_attack requires script_index key/value to start at 0 and not have any gaps." );
        ents[ i ] = spawn( "script_origin", struct_arr[ i ].origin );
        vehicle setvehweapon( "littlebird_FFAR" );
        vehicle setturrettargetent( ents[ i ] );
        missile = vehicle fireweapon( tags[ i % tags.size ], ents[ i ], ( 0, 0, 0 ) );
        missile delaycall( 1, &missile_cleartarget );
        wait randomfloatrange( 0.2, 0.3 );
    }
    
    wait 2;
    
    foreach ( ent in ents )
    {
        ent delete();
    }
}

