#using script_3798db193e76a866;
#using scripts\anim\notetracks_sp;
#using scripts\asm\asm_sp;
#using scripts\common\concussion_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\hud_util;
#using scripts\sp\player;
#using scripts\sp\spawner;
#using scripts\sp\vehicle;

#namespace namespace_657dc7e018dcfce9;

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x4f9
// Size: 0x138
function init()
{
    level.var_19d38dec02a818ce = &scripts\engine\utility::issharedfuncdefined;
    level.var_49b393a31d0b0b95 = &scripts\engine\utility::getsharedfunc;
    anim_init();
    hud_init();
    killstreak_init();
    equipment_init();
    perk_init();
    player_init();
    vehicle_init();
    game_init();
    spawn_init();
    emp_init();
    execution_init();
    entity_init();
    weapons_init();
    damage_init();
    sound_init();
    flares_init();
    shellshock_init();
    fx_init();
    ai_init();
    bots_init();
    agents_init();
    outline_init();
    game_utility_init();
    rank_init();
    supers_init();
    gamescore_init();
    pers_init();
    dlog_init();
    challenges_init();
    function_a92ed2f4c44e5ffa();
    stealth_init();
    gameskill_init();
    poi_init();
    aggregator_init();
    level thread activities_init();
    cameras_init();
    function_a30b248a8fc67a00();
    battlechatter_init();
    host_migration_init();
    function_f677f2d747d21482();
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x639
// Size: 0x2
function gameskill_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x643
// Size: 0x2
function poi_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x64d
// Size: 0x2
function stealth_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x657
// Size: 0x44
function anim_init()
{
    registersharedfunc( "anim", "scriptModelPlayAnimDeltaMotion", &scriptmodelplayanimdeltamotion_sp );
    registersharedfunc( "anim", "ASM_PlayFacialAnim", &asm_playfacialanim_sp );
    registersharedfunc( "anim", "HandleNoteTrack", &handlenotetrack );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x6a3
// Size: 0x2
function hud_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x6ad
// Size: 0x10a
function killstreak_init()
{
    registersharedfunc( "killstreak", "createStreakInfo", &namespace_2032e3f42315b9b2::createstreakinfo );
    registersharedfunc( "killstreak", "streakDeploy_doWeaponTabletDeploy", &namespace_2032e3f42315b9b2::function_8eafa4c9894723a3 );
    registersharedfunc( "killstreak", "getKillstreakAirStrikeHeightEnt", &namespace_2032e3f42315b9b2::getkillstreakairstrikeheightent );
    registersharedfunc( "killstreak", "killstreak_setMainVision", &namespace_2032e3f42315b9b2::killstreak_setmainvision );
    registersharedfunc( "killstreak", "killstreak_setSubVision", &namespace_2032e3f42315b9b2::killstreak_setsubvision );
    registersharedfunc( "killstreak", "restoreKillstreakPlayerAngles", &namespace_2032e3f42315b9b2::restorekillstreakplayerangles );
    registersharedfunc( "killstreak", "killstreak_setupVehicleDamageFunctionality", &namespace_2032e3f42315b9b2::killstreak_setupvehicledamagefunctionality );
    registersharedfunc( "killstreak", "streakDeploy_doWeaponFiredDeploy", &namespace_2032e3f42315b9b2::function_edd13bb02e6204e4 );
    registersharedfunc( "hellstorm_missile", "assignTargetMarkers", &namespace_2032e3f42315b9b2::killstreak_assigntargetmarkers );
    registersharedfunc( "chopper_gunner", "assignTargetMarkers", &namespace_2032e3f42315b9b2::killstreak_assigntargetmarkers );
    registersharedfunc( "gunship", "assignTargetMarkers", &namespace_2032e3f42315b9b2::killstreak_assigntargetmarkers );
    registersharedfunc( "cruise_predator", "assignTargetMarkers", &namespace_2032e3f42315b9b2::killstreak_assigntargetmarkers );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x7bf
// Size: 0x18
function equipment_init()
{
    scripts\engine\utility::registersharedfunc( "shellshock", "concussionInterruptDelayFunc", &scripts\common\concussion_utility::calculateinterruptdelay );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x7df
// Size: 0x2
function entity_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x7e9
// Size: 0x2
function perk_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x7f3
// Size: 0xd6
function player_init()
{
    registersharedfunc( "player", "_isAlive", &playerisalive );
    registersharedfunc( "player", "fadeToBlackForPlayer", &fadetoblackforplayer );
    registersharedfunc( "player", "freezeControls", &function_9e4bdc60395a22be );
    registersharedfunc( "player", "getSuperFaction", &getsuperfactionsp );
    registersharedfunc( "player", "getPlayersInRadius", &scripts\sp\player::getplayersinradius );
    registersharedfunc( "player", "get_rumble_ent", &utility::get_rumble_ent );
    registersharedfunc( "player", "rumble_ramp_to", &utility::rumble_ramp_to );
    val::register( "player_for_spawn_logic", 1, 0, "$self", &function_3b7b5cc9ae0f8ee2, "$value" );
    level.enableexecutionattackfunc = &empty_func;
    level.disableexecutionattackfunc = &empty_func;
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x8d1
// Size: 0x18
function host_migration_init()
{
    registersharedfunc( "hostmigration", "waitLongDurationWithPause", &function_3a8153b287c5ec7 );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x8f1
// Size: 0x70
function vehicle_init()
{
    registersharedfunc( "vehicle", "reserveVehicle", &scripts\sp\vehicle::reservevehicle );
    registersharedfunc( "vehicle", "spawnVehicle", &scripts\sp\vehicle::spawnvehicle_sp );
    registersharedfunc( "vehicle", "deleteVehicle", &scripts\sp\vehicle::deletevehicle_sp );
    registersharedfunc( "vehicle", "vehicle_damage_setCanDamage", &scripts\sp\vehicle::function_36dbb623c325c79 );
    registersharedfunc( "vehicle", "vehicle_driverShowViewModel", &scripts\sp\vehicle::function_9b59f5c375018695 );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x969
// Size: 0x56
function game_init()
{
    registersharedfunc( "game", "targetMarkerGroup_off", &targetmarkergroup_off );
    registersharedfunc( "game", "targetMarkerGroup_on", &targetmarkergroup_on );
    registersharedfunc( "game", "getPlayerProgression", &getplayerprogression );
    registersharedfunc( "game", "setPlayerProgression", &setplayerprogression );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x9c7
// Size: 0x2
function spawn_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x9d1
// Size: 0x2
function emp_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x9db
// Size: 0x18
function execution_init()
{
    registersharedfunc( "executions", "is_in_takedown", &scripts\common\utility::function_bbebfbddd1b77a34 );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0x9fb
// Size: 0x2
function weapons_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xa05
// Size: 0x2
function damage_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xa0f
// Size: 0x18
function sound_init()
{
    registersharedfunc( "sound", "playSoundToPlayer", &playsoundtoplayer_sp );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xa2f
// Size: 0x2
function flares_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xa39
// Size: 0x2
function shellshock_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xa43
// Size: 0x18
function fx_init()
{
    registersharedfunc( "fx", "SpawnFXForClient", &spawnfxforclient_sp );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xa63
// Size: 0x44
function ai_init()
{
    registersharedfunc( "ai", "giveAIWeapon", &giveaiweapon_sp );
    registersharedfunc( "ai", "GetFreeAICount", &getfreeaicount_sp );
    registersharedfunc( "ai", "spawnNewAIType_SharedFunc", &spawnnewaitype_sp );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xaaf
// Size: 0x2
function bots_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xab9
// Size: 0x2
function agents_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xac3
// Size: 0x2
function outline_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xacd
// Size: 0x2
function game_utility_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xad7
// Size: 0x2
function rank_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xae1
// Size: 0x2
function supers_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xaeb
// Size: 0x2
function gamescore_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xaf5
// Size: 0x2
function pers_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xaff
// Size: 0x2
function dlog_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xb09
// Size: 0x2
function challenges_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xb13
// Size: 0x2
function function_a92ed2f4c44e5ffa()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xb1d
// Size: 0x2
function aggregator_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xb27
// Size: 0x2
function cameras_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xb31
// Size: 0x2
function function_a30b248a8fc67a00()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xb3b
// Size: 0x2
function battlechatter_init()
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xb45
// Size: 0x11
function function_f677f2d747d21482()
{
    create_func_ref( "setsaveddvar", &setsaveddvar );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xb5e
// Size: 0x22
function activities_init()
{
    while ( !isdefined( level.mapname ) )
    {
        waitframe();
    }
    
    startactivity( level.mapname );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb88
// Size: 0x1d
function private function_3a8153b287c5ec7( delay )
{
    delay = default_to( delay, 0 );
    
    if ( delay > 0 )
    {
        wait delay;
    }
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xbad
// Size: 0x2c
function private playsoundtoplayer_sp( aliasname, player, srcentity )
{
    if ( soundexists( aliasname ) )
    {
        self playsound( aliasname );
    }
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0xbe1
// Size: 0x56
function private spawnfxforclient_sp( fxid, position, player, forward, up )
{
    assert( isdefined( level.player ) && player == level.player );
    return spawnfx( fxid, position, forward, up );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xc40
// Size: 0x15
function private giveaiweapon_sp( weapname )
{
    self.weapon = weapname;
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xc5d
// Size: 0x7
function private getfreeaicount_sp()
{
    return getfreeaicount();
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0xc6d
// Size: 0x54
function private spawnnewaitype_sp( aitype, position, angles, team, characterlistname )
{
    newai = dospawnaitype( aitype, position, angles, 1, undefined, undefined, undefined, undefined, characterlistname );
    
    if ( isdefined( newai ) )
    {
        newai thread scripts\sp\spawner::spawn_think();
    }
    
    return newai;
}

#using_animtree( "script_model" );

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0xcca
// Size: 0x8e
function private scriptmodelplayanimdeltamotion_sp( animname, notifystring, animstarttimeseconds, blendtype )
{
    animation = function_d2fff5ce136ca7b( animname, #animtree );
    
    if ( isdefined( animation ) )
    {
        notifystring = default_to( notifystring, "anim_scripted" );
        self useanimtree( #animtree );
        self animscripted( notifystring, self.origin, self.angles, animation );
        
        if ( isdefined( animstarttimeseconds ) )
        {
            coef = animstarttimeseconds / getanimlength( animation );
            self setanimtime( animname, coef );
        }
    }
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 3
// Checksum 0x0, Offset: 0xd60
// Size: 0x47
function fadetoblackforplayer( player, fadetoblack, fadetime )
{
    fadetime = default_to( fadetime, 0 );
    
    if ( istrue( fadetoblack ) )
    {
        scripts\sp\hud_util::fade_out( fadetime, "black" );
        return;
    }
    
    scripts\sp\hud_util::fade_in( fadetime, "black" );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 3
// Checksum 0x0, Offset: 0xdaf
// Size: 0x45
function function_9e4bdc60395a22be( frozen, force, debug )
{
    if ( frozen )
    {
        val::set( "sharedFunc", "freezecontrols", frozen );
        return;
    }
    
    val::reset( "sharedFunc", "freezecontrols" );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 1
// Checksum 0x0, Offset: 0xdfc
// Size: 0xc, Type: bool
function getsuperfactionsp( player )
{
    return false;
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 0
// Checksum 0x0, Offset: 0xe11
// Size: 0x8
function playerisalive()
{
    return isalive( self );
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 7
// Checksum 0x0, Offset: 0xe22
// Size: 0xcb
function targetmarkergroup_on( markerwidgetname, showto, tomark, groupowner, friendlymarker, markonspawn, var_262f4b55aa151de1 )
{
    if ( isdefined( tomark ) && !isarray( tomark ) )
    {
        tomark = [ tomark ];
    }
    
    if ( !isdefined( level.activetargetmarkergroups ) )
    {
        level.activetargetmarkergroups = [];
    }
    
    id = level.activetargetmarkergroups.size;
    level.activetargetmarkergroups[ id ] = tomark;
    
    if ( isarray( tomark ) )
    {
        if ( issubstr( markerwidgetname, "enemy" ) )
        {
            array_thread( tomark, &scripts\engine\sp\utility::hudoutline_enable_new, "outline_nodepth_red" );
        }
        else
        {
            array_thread( tomark, &scripts\engine\sp\utility::hudoutline_enable_new, "outline_nodepth_green" );
        }
    }
    
    return id;
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 1
// Checksum 0x0, Offset: 0xef6
// Size: 0x4f
function targetmarkergroup_off( targetmarkergroupid )
{
    if ( isdefined( level.activetargetmarkergroups[ targetmarkergroupid ] ) )
    {
        if ( isarray( level.activetargetmarkergroups[ targetmarkergroupid ] ) )
        {
            array_thread( level.activetargetmarkergroups[ targetmarkergroupid ], &scripts\engine\sp\utility::hudoutline_disable );
        }
    }
    
    level.activetargetmarkergroups[ targetmarkergroupid ] = undefined;
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xf4d
// Size: 0xb
function private function_3b7b5cc9ae0f8ee2( b_value )
{
    
}

// Namespace namespace_657dc7e018dcfce9 / namespace_8b9b2769a8e84272
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xf60
// Size: 0xb
function private empty_func( b_value )
{
    
}

