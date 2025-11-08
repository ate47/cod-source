#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\damage;
#using scripts\mp\events;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\helicopter;
#using scripts\mp\movers;
#using scripts\mp\supers;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\teams;
#using scripts\mp\weapons;

#namespace autosentry;

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0xf0f
// Size: 0x717
function init()
{
    level.sentrytype = [];
    level.sentrytype[ "super_trophy" ] = "super_trophy";
    level.sentrytype[ "sentry_shock" ] = "sentry_shock";
    level.sentrytype[ "manual_turret" ] = "manual_turret";
    assertmsg( "<dev string:x1c>" );
    level.sentrysettings = [];
    level.sentrysettings[ "super_trophy" ] = spawnstruct();
    level.sentrysettings[ "super_trophy" ].health = 999999;
    level.sentrysettings[ "super_trophy" ].maxhealth = 100;
    level.sentrysettings[ "super_trophy" ].sentrymodeon = "sentry";
    level.sentrysettings[ "super_trophy" ].sentrymodeoff = "sentry_offline";
    level.sentrysettings[ "super_trophy" ].weaponinfo = "sentry_laser_mp";
    level.sentrysettings[ "super_trophy" ].modelbase = "super_trophy_mp";
    level.sentrysettings[ "super_trophy" ].modelgood = "super_trophy_mp_placement";
    level.sentrysettings[ "super_trophy" ].modelbad = "super_trophy_mp_placement_fail";
    level.sentrysettings[ "super_trophy" ].modeldestroyed = "super_trophy_mp";
    level.sentrysettings[ "super_trophy" ].hintstring = &"SENTRY/PICKUP";
    level.sentrysettings[ "super_trophy" ].headicon = 1;
    level.sentrysettings[ "super_trophy" ].teamsplash = "used_super_trophy";
    level.sentrysettings[ "super_trophy" ].shouldsplash = 0;
    level.sentrysettings[ "super_trophy" ].lightfxtag = "tag_fx";
    level.sentrysettings[ "sentry_shock" ] = spawnstruct();
    level.sentrysettings[ "sentry_shock" ].health = 999999;
    level.sentrysettings[ "sentry_shock" ].maxhealth = 670;
    level.sentrysettings[ "sentry_shock" ].burstmin = 20;
    level.sentrysettings[ "sentry_shock" ].burstmax = 120;
    level.sentrysettings[ "sentry_shock" ].pausemin = 0.15;
    level.sentrysettings[ "sentry_shock" ].pausemax = 0.35;
    level.sentrysettings[ "sentry_shock" ].sentrymodeon = "sentry";
    level.sentrysettings[ "sentry_shock" ].sentrymodeoff = "sentry_offline";
    level.sentrysettings[ "sentry_shock" ].timeout = 90;
    level.sentrysettings[ "sentry_shock" ].spinuptime = 0.05;
    level.sentrysettings[ "sentry_shock" ].overheattime = 8;
    level.sentrysettings[ "sentry_shock" ].cooldowntime = 0.1;
    level.sentrysettings[ "sentry_shock" ].fxtime = 0.3;
    level.sentrysettings[ "sentry_shock" ].streakname = "sentry_shock";
    level.sentrysettings[ "sentry_shock" ].weaponinfo = "sentry_shock_mp";
    level.sentrysettings[ "sentry_shock" ].scriptable = "ks_shock_sentry_mp";
    level.sentrysettings[ "sentry_shock" ].modelbase = "shock_sentry_gun_wm";
    level.sentrysettings[ "sentry_shock" ].modelgood = "shock_sentry_gun_wm_obj";
    level.sentrysettings[ "sentry_shock" ].modelbad = "shock_sentry_gun_wm_obj_red";
    level.sentrysettings[ "sentry_shock" ].modeldestroyed = "shock_sentry_gun_wm_destroyed";
    level.sentrysettings[ "sentry_shock" ].hintstring = &"SENTRY/PICKUP";
    level.sentrysettings[ "sentry_shock" ].headicon = 1;
    level.sentrysettings[ "sentry_shock" ].teamsplash = "used_shock_sentry";
    level.sentrysettings[ "sentry_shock" ].destroyedsplash = "callout_destroyed_sentry_shock";
    level.sentrysettings[ "sentry_shock" ].shouldsplash = 1;
    level.sentrysettings[ "sentry_shock" ].votimeout = "sentry_gun_teamleader_crash";
    level.sentrysettings[ "sentry_shock" ].vodestroyed = "sentry_gun_teamleader_crash";
    level.sentrysettings[ "sentry_shock" ].scorepopup = "destroyed_sentry";
    level.sentrysettings[ "sentry_shock" ].lightfxtag = "tag_fx";
    level.sentrysettings[ "sentry_shock" ].iskillstreak = 1;
    level.sentrysettings[ "sentry_shock" ].headiconoffset = 75;
    level._effect[ "sentry_overheat_mp" ] = loadfx( "vfx/core/mp/killstreaks/vfx_sg_overheat_smoke" );
    level._effect[ "sentry_explode_mp" ] = loadfx( "vfx/iw7/_requests/mp/vfx_generic_equipment_exp_lg.vfx" );
    level._effect[ "sentry_sparks_mp" ] = loadfx( "vfx/core/mp/killstreaks/vfx_sentry_gun_explosion" );
    level._effect[ "sentry_smoke_mp" ] = loadfx( "vfx/iw7/_requests/mp/vfx_gen_equip_dam_spark_runner.vfx" );
    level._effect[ "sentry_shock_charge" ] = loadfx( "vfx/iw7/_requests/mp/vfx_sentry_shock_charge_up.vfx" );
    level._effect[ "sentry_shock_screen" ] = loadfx( "vfx/iw7/_requests/mp/vfx_sentry_shock_screen" );
    level._effect[ "sentry_shock_base" ] = loadfx( "vfx/iw7/_requests/mp/vfx_sentry_shock_base" );
    level._effect[ "sentry_shock_radius" ] = loadfx( "vfx/iw7/_requests/mp/vfx_sentry_shock_radius" );
    level._effect[ "sentry_shock_explosion" ] = loadfx( "vfx/iw7/_requests/mp/vfx_sentry_shock_end.vfx" );
    level._effect[ "sentry_shock_trail" ] = loadfx( "vfx/iw7/_requests/mp/vfx_sentry_shock_proj_trail.vfx" );
    level._effect[ "sentry_shock_arc" ] = loadfx( "vfx/iw7/_requests/mp/vfx_sentry_shock_arc.vfx" );
    
    /#
        setdevdvarifuninitialized( @"hash_7132e4633efb342c", 90 );
    #/
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 2
// Checksum 0x0, Offset: 0x162e
// Size: 0x61
function tryuseautosentry( lifeid, streakname )
{
    result = givesentry( "sentry_minigun" );
    
    if ( result )
    {
        utility::trycall( level.matchdata_logkillstreakevent, level.sentrysettings[ "sentry_minigun" ].streakname, self.origin );
    }
    
    return result;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 2
// Checksum 0x0, Offset: 0x1698
// Size: 0x61
function tryusesam( lifeid, streakname )
{
    result = givesentry( "sam_turret" );
    
    if ( result )
    {
        utility::trycall( level.matchdata_logkillstreakevent, level.sentrysettings[ "sam_turret" ].streakname, self.origin );
    }
    
    return result;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x1702
// Size: 0x51
function tryuseshocksentry( streakinfo )
{
    result = givesentry( "sentry_shock", undefined, streakinfo );
    
    if ( result )
    {
        utility::trycall( level.matchdata_logkillstreakevent, streakinfo.streakname, self.origin );
    }
    else
    {
        waitframe();
    }
    
    return result;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x175c
// Size: 0x51
function tryusemanualturret( streakinfo )
{
    result = givesentry( "manual_turret", undefined, streakinfo );
    
    if ( result )
    {
        utility::trycall( level.matchdata_logkillstreakevent, streakinfo.streakname, self.origin );
    }
    else
    {
        waitframe();
    }
    
    return result;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 3
// Checksum 0x0, Offset: 0x17b6
// Size: 0xe2
function givesentry( sentrytype, pickuptriggeroverride, streakinfo )
{
    self.last_sentry = sentrytype;
    
    if ( !isdefined( self.placedsentries ) )
    {
        self.placedsentries = [];
    }
    
    if ( !isdefined( self.placedsentries[ sentrytype ] ) )
    {
        self.placedsentries[ sentrytype ] = [];
    }
    
    enablepickup = 1;
    
    if ( isdefined( pickuptriggeroverride ) )
    {
        enablepickup = pickuptriggeroverride;
    }
    
    sentrygun = createsentryforplayer( sentrytype, self, enablepickup, streakinfo );
    
    if ( isdefined( streakinfo ) )
    {
        streakinfo.sentrygun = sentrygun;
    }
    
    removeperks();
    self.carriedsentry = sentrygun;
    result = setcarryingsentry( sentrygun, 1, enablepickup );
    self.carriedsentry = undefined;
    thread waitrestoreperks();
    self.iscarrying = 0;
    
    if ( isdefined( sentrygun ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 4
// Checksum 0x0, Offset: 0x18a0
// Size: 0x1a7
function setcarryingsentry( sentrygun, allowcancel, enablepickup, cancelondeath )
{
    self endon( "death_or_disconnect" );
    assert( isreallyalive( self ) );
    sentrygun sentry_setcarried( self, enablepickup, cancelondeath );
    val::set( "sentry", "usability", 0 );
    val::set( "sentry", "melee", 0 );
    allowweaponsforsentry( 0 );
    
    if ( !isai( self ) )
    {
        self notifyonplayercommand( "place_sentry", "+attack" );
        self notifyonplayercommand( "place_sentry", "+attack_akimbo_accessible" );
        self notifyonplayercommand( "cancel_sentry", "+actionslot 4" );
        
        if ( !self isconsoleplayer() )
        {
            self notifyonplayercommand( "cancel_sentry", "+actionslot 5" );
            self notifyonplayercommand( "cancel_sentry", "+actionslot 6" );
            self notifyonplayercommand( "cancel_sentry", "+actionslot 7" );
        }
    }
    
    for ( ;; )
    {
        result = waittill_any_return_4( "place_sentry", "cancel_sentry", "force_cancel_placement", "emp_applied" );
        
        if ( !isdefined( sentrygun ) )
        {
            allowweaponsforsentry( 1 );
            thread enablemeleeforsentry();
            return 1;
        }
        
        if ( result == "cancel_sentry" || result == "force_cancel_placement" || result == "emp_applied" )
        {
            if ( !allowcancel && ( result == "cancel_sentry" || result == "emp_applied" ) )
            {
                continue;
            }
            
            sentrygun sentry_setcancelled( result == "force_cancel_placement" && !isdefined( sentrygun.firstplacement ) );
            return 0;
        }
        
        if ( !sentrygun.canbeplaced )
        {
            continue;
        }
        
        sentrygun sentry_setplaced( enablepickup );
        return 1;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x1a4f
// Size: 0x1b
function enablemeleeforsentry()
{
    self endon( "death_or_disconnect" );
    wait 0.25;
    val::reset_all( "sentry" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x1a72
// Size: 0x2a
function removeweapons()
{
    if ( self hasweapon( "iw6_riotshield_mp" ) )
    {
        self.restoreweapon = "iw6_riotshield_mp";
        _takeweapon( "iw6_riotshield_mp" );
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x1aa4
// Size: 0x2a
function removeperks()
{
    if ( _hasperk( "specialty_explosivebullets" ) )
    {
        self.restoreperk = "specialty_explosivebullets";
        removeperk( "specialty_explosivebullets" );
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x1ad6
// Size: 0x29
function restoreweapons()
{
    if ( isdefined( self.restoreweapon ) )
    {
        _giveweapon( self.restoreweapon );
        self.restoreweapon = undefined;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x1b07
// Size: 0x29
function restoreperks()
{
    if ( isdefined( self.restoreperk ) )
    {
        giveperk( self.restoreperk );
        self.restoreperk = undefined;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x1b38
// Size: 0x18
function waitrestoreperks()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    waitframe();
    restoreperks();
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 4
// Checksum 0x0, Offset: 0x1b58
// Size: 0xd0
function createsentryforplayer( sentrytype, owner, enablepickup, streakinfo )
{
    assertex( isdefined( owner ), "<dev string:x6c>" );
    sentryweapon = level.sentrysettings[ sentrytype ].weaponinfo;
    sentrygun = spawnturret( "misc_turret", owner.origin, sentryweapon );
    sentrygun.angles = owner.angles;
    sentrygun.streakinfo = streakinfo;
    sentrygun sentry_initsentry( sentrytype, owner, enablepickup );
    sentrygun thread sentry_destroyongameend();
    sentrygun scripts\cp_mp\emp_debuff::allow_emp( 0 );
    sentrygun scripts\cp_mp\emp_debuff::set_start_emp_callback( &sentry_empstarted );
    sentrygun scripts\cp_mp\emp_debuff::set_clear_emp_callback( &sentry_empcleared );
    return sentrygun;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 4
// Checksum 0x0, Offset: 0x1c31
// Size: 0x4b6
function sentry_initsentry( sentrytype, owner, enablepickup, timeout )
{
    if ( !isdefined( timeout ) )
    {
        timeout = 1;
    }
    
    self.sentrytype = sentrytype;
    self.canbeplaced = 1;
    self setmodel( level.sentrysettings[ sentrytype ].modelbase );
    self setnodeploy( 1 );
    
    if ( level.sentrysettings[ sentrytype ].shouldsplash )
    {
        self.shouldsplash = 1;
    }
    else
    {
        self.shouldsplash = 0;
    }
    
    self.firstplacement = 1;
    self setcandamage( 1 );
    
    switch ( sentrytype )
    {
        case #"hash_8a144557bd5ac067":
        case #"hash_8f3bfcef6a436f5b":
        case #"hash_8f3bfdef6a4370ee":
        case #"hash_8f3bfeef6a437281":
        case #"hash_8f3bffef6a437414":
        case #"hash_9cc148005b0186d6":
        case #"hash_9cc14a005b0189fc":
        case #"hash_9cc14b005b018b8f":
        case #"hash_9cc14d005b018eb5":
        case #"hash_ce05fbb198b1f5dd":
            self setleftarc( 80 );
            self setrightarc( 80 );
            self setbottomarc( 50 );
            self setdefaultdroppitch( 0 );
            self.originalowner = owner;
            break;
        case #"hash_721f6bf62b0eb1bd":
        case #"hash_c72f9e2dc5fac20b":
            self maketurretinoperable();
            self setleftarc( 180 );
            self setrightarc( 180 );
            self settoparc( 80 );
            self setdefaultdroppitch( -89 );
            self.laser_on = 0;
            killcament = spawn( "script_model", self gettagorigin( "tag_laser" ) );
            killcament linkto( self );
            self.killcament = killcament;
            self.killcament setscriptmoverkillcam( "explosive" );
            break;
        case #"hash_576b868dbf9eab17":
            self maketurretinoperable();
            killcamforward = anglestoforward( self.angles );
            killcampos = self gettagorigin( "tag_laser" ) + ( 0, 0, 10 );
            killcampos -= killcamforward * 20;
            killcament = spawn( "script_model", killcampos );
            killcament linkto( self );
            self.killcament = killcament;
            break;
        case #"hash_52d9b7ed584bec3e":
            killcamforward = anglestoforward( self.angles );
            killcampos = self gettagorigin( "tag_laser" ) + ( 0, 0, 10 );
            killcampos -= killcamforward * 20;
            killcament = spawn( "script_model", killcampos );
            killcament linkto( self );
            self.killcament = killcament;
            break;
        default:
            self maketurretinoperable();
            self setdefaultdroppitch( -89 );
            break;
    }
    
    self setturretmodechangewait( 1 );
    sentry_setinactive();
    sentry_setowner( owner );
    
    if ( timeout )
    {
        thread sentry_timeout();
    }
    
    switch ( sentrytype )
    {
        case #"hash_8a144557bd5ac067":
        case #"hash_8f3bfcef6a436f5b":
        case #"hash_8f3bfdef6a4370ee":
        case #"hash_8f3bfeef6a437281":
        case #"hash_8f3bffef6a437414":
            self.momentum = 0;
            self.heatlevel = 0;
            self.overheated = 0;
            thread sentry_heatmonitor();
            break;
        case #"hash_9cc148005b0186d6":
        case #"hash_9cc14a005b0189fc":
        case #"hash_9cc14b005b018b8f":
        case #"hash_9cc14d005b018eb5":
        case #"hash_ce05fbb198b1f5dd":
            self.momentum = 0;
            self.heatlevel = 0;
            self.cooldownwaittime = 0;
            self.overheated = 0;
            thread turret_heatmonitor();
            thread turret_coolmonitor();
            break;
        case #"hash_576b868dbf9eab17":
        case #"hash_721f6bf62b0eb1bd":
        case #"hash_c72f9e2dc5fac20b":
            self.momentum = 0;
            thread sentry_handleuse( enablepickup );
            thread sentry_beepsounds();
            break;
        case #"hash_52d9b7ed584bec3e":
            self.momentum = 0;
            thread sentry_handlemanualuse();
            thread sentry_handlealteratepickup( enablepickup );
            break;
        case #"hash_b17ed5514d85b71b":
            thread sentry_handleuse( 0 );
            thread sentry_beepsounds();
            break;
        default:
            thread sentry_handleuse( enablepickup );
            thread sentry_attacktargets();
            thread sentry_beepsounds();
            break;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x20ef
// Size: 0x7f
function sentry_setteamheadicon()
{
    headiconoffset = level.sentrysettings[ self.sentrytype ].headiconoffset;
    
    if ( !isdefined( headiconoffset ) )
    {
        return;
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    owner = self.owner;
    team = owner.team;
    self.headiconid = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, headiconoffset, undefined, undefined, undefined, undefined, 1 );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x2176
// Size: 0x41
function sentry_clearteamheadicon()
{
    headiconoffset = level.sentrysettings[ self.sentrytype ].headiconoffset;
    
    if ( !isdefined( headiconoffset ) )
    {
        return;
    }
    
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconid );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x21bf
// Size: 0x23
function sentry_destroyongameend()
{
    self endon( "death" );
    level waittill_any_2( "bro_shot_start", "game_ended" );
    self notify( "death" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x21ea
// Size: 0x8f
function sentry_handledamage()
{
    self endon( "carried" );
    maxhealth = level.sentrysettings[ self.sentrytype ].maxhealth;
    var_4b9cd0374a51877c = 0;
    
    if ( self.owner _hasperk( "specialty_rugged_eqp" ) )
    {
        weaponname = self.weapon_name;
        
        if ( isdefined( weaponname ) )
        {
        }
    }
    
    maxhealth += int( var_4b9cd0374a51877c );
    scripts\mp\damage::monitordamage( maxhealth, "sentry", &sentryhandledeathdamage, &sentrymodifydamage, 1 );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x2281
// Size: 0xb8
function sentrymodifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    modifieddamage = damage;
    
    if ( type == "MOD_MELEE" )
    {
        modifieddamage = self.maxhealth * 0.34;
    }
    
    modifieddamage = getmodifiedantikillstreakdamage( attacker, objweapon, type, modifieddamage, self.maxhealth, 2, 3, 4 );
    return modifieddamage;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x2342
// Size: 0x18b
function sentryhandledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    config = level.sentrysettings[ self.sentrytype ];
    
    if ( config.iskillstreak )
    {
        notifyattacker = scripts\mp\damage::onkillstreakkilled( config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash );
        
        if ( notifyattacker )
        {
            attacker notify( "destroyed_equipment" );
        }
        
        return;
    }
    
    validattacker = undefined;
    var_43dbeb17e356bbb0 = attacker;
    
    if ( isdefined( var_43dbeb17e356bbb0 ) && isdefined( self.owner ) )
    {
        if ( isdefined( attacker.owner ) && isplayer( attacker.owner ) )
        {
            var_43dbeb17e356bbb0 = attacker.owner;
        }
        
        if ( self.owner scripts\cp_mp\utility\player_utility::isenemy( var_43dbeb17e356bbb0 ) )
        {
            validattacker = var_43dbeb17e356bbb0;
        }
    }
    
    if ( isdefined( validattacker ) )
    {
        validattacker thread scripts\mp\events::supershutdown( self.owner );
        validattacker notify( "destroyed_equipment" );
    }
    
    self notify( "death" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x24d5
// Size: 0x6d
function sentry_empstarted( data )
{
    self.disabled = 1;
    self setdefaultdroppitch( 40 );
    self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
    self cleartargetentity();
    self setscriptablepartstate( "muzzle", "neutral", 0 );
    self setscriptablepartstate( "stunned", "active" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x254a
// Size: 0x5b
function sentry_empcleared( isdeath )
{
    if ( isdeath )
    {
        return;
    }
    
    self setdefaultdroppitch( -89 );
    self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeon );
    self setscriptablepartstate( "stunned", "neutral" );
    self.disabled = undefined;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x25ad
// Size: 0x344
function sentry_handledeath()
{
    self endon( "carried" );
    self waittill( "death" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner.placedsentries[ self.sentrytype ] = array_remove( self.owner.placedsentries[ self.sentrytype ], self );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self cleartargetentity();
    self laseroff();
    self setmodel( level.sentrysettings[ self.sentrytype ].modeldestroyed );
    
    if ( isdefined( self.fxentdeletelist ) && self.fxentdeletelist.size > 0 )
    {
        foreach ( fxent in self.fxentdeletelist )
        {
            if ( isdefined( fxent ) )
            {
                fxent delete();
            }
        }
        
        self.fxentdeletelist = undefined;
    }
    
    sentry_setinactive();
    self setdefaultdroppitch( 40 );
    self setsentryowner( undefined );
    
    if ( isdefined( self.inuseby ) )
    {
        self useby( self.inuseby );
    }
    
    self setturretminimapvisible( 0 );
    
    if ( isdefined( self.ownertrigger ) )
    {
        self.ownertrigger delete();
    }
    
    self playsound( "mp_equip_destroyed" );
    
    switch ( self.sentrytype )
    {
        case #"hash_8a144557bd5ac067":
        case #"hash_ce05fbb198b1f5dd":
            self.forcedisable = 1;
            self turretfiredisable();
            break;
        default:
            break;
    }
    
    if ( isdefined( self.inuseby ) )
    {
        playfxontag( getfx( "sentry_explode_mp" ), self, "tag_origin" );
        playfxontag( getfx( "sentry_smoke_mp" ), self, "tag_aim" );
        self.inuseby.turret_overheat_bar destroyelem();
        self.inuseby restoreperks();
        self.inuseby restoreweapons();
        self notify( "deleting" );
        wait 1;
        stopfxontag( getfx( "sentry_explode_mp" ), self, "tag_origin" );
        stopfxontag( getfx( "sentry_smoke_mp" ), self, "tag_aim" );
    }
    else
    {
        self playsound( "sentry_explode_smoke" );
        self setscriptablepartstate( "destroyed", "sparks" );
        wait 5;
        playfx( getfx( "sentry_explode_mp" ), self.origin + ( 0, 0, 10 ) );
        self notify( "deleting" );
    }
    
    scripts\mp\weapons::equipmentdeletevfx();
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament delete();
    }
    
    if ( isdefined( self.airlookatent ) )
    {
        self.airlookatent delete();
    }
    
    if ( isdefined( self.manualpickuptrigger ) )
    {
        self.manualpickuptrigger delete();
    }
    
    printgameaction( "killstreak ended - shock_sentry", self.owner );
    self delete();
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x28f9
// Size: 0xeb
function sentry_handleuse( enablepickup )
{
    self endon( "death" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        self waittill( "trigger", player );
        assert( player == self.owner );
        assert( !isdefined( self.carriedby ) );
        
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        if ( self.sentrytype == "sam_turret" || self.sentrytype == "scramble_turret" )
        {
            self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
        }
        
        player.placedsentries[ self.sentrytype ] = array_remove( player.placedsentries[ self.sentrytype ], self );
        player setcarryingsentry( self, 0, enablepickup );
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x29ec
// Size: 0x161
function turret_handlepickup( turret )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    turret endon( "death" );
    
    if ( !isdefined( turret.ownertrigger ) )
    {
        return;
    }
    
    buttontime = 0;
    
    for ( ;; )
    {
        if ( isalive( self ) && self istouching( turret.ownertrigger ) && !isdefined( turret.inuseby ) && !isdefined( turret.carriedby ) && self isonground() )
        {
            if ( self usebuttonpressed() )
            {
                buttontime = 0;
                
                while ( self usebuttonpressed() )
                {
                    buttontime += level.framedurationseconds;
                    waitframe();
                }
                
                println( "<dev string:xa6>" + buttontime );
                
                if ( buttontime >= 0.5 )
                {
                    continue;
                }
                
                buttontime = 0;
                
                while ( !self usebuttonpressed() && buttontime < 0.5 )
                {
                    buttontime += level.framedurationseconds;
                    waitframe();
                }
                
                println( "<dev string:xb6>" + buttontime );
                
                if ( buttontime >= 0.5 )
                {
                    continue;
                }
                
                if ( !isreallyalive( self ) )
                {
                    continue;
                }
                
                turret setmode( level.sentrysettings[ turret.sentrytype ].sentrymodeoff );
                thread setcarryingsentry( turret, 0 );
                turret.ownertrigger delete();
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x2b55
// Size: 0x454
function turret_handleuse()
{
    self notify( "turret_handluse" );
    self endon( "turret_handleuse" );
    self endon( "deleting" );
    level endon( "game_ended" );
    self.forcedisable = 0;
    colorstable = ( 1, 0.9, 0.7 );
    colorunstable = ( 1, 0.65, 0 );
    coloroverheated = ( 1, 0.25, 0 );
    
    for ( ;; )
    {
        self waittill( "trigger", player );
        
        if ( isdefined( self.carriedby ) )
        {
            continue;
        }
        
        if ( isdefined( self.inuseby ) )
        {
            continue;
        }
        
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        player removeperks();
        player removeweapons();
        self.inuseby = player;
        self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
        sentry_setowner( player );
        self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeon );
        player thread turret_shotmonitor( self );
        player.turret_overheat_bar = player createbar( colorstable, 100, 6 );
        player.turret_overheat_bar setpoint( "CENTER", "BOTTOM", 0, -70 );
        player.turret_overheat_bar.alpha = 0.65;
        player.turret_overheat_bar.bar.alpha = 0.65;
        playingheatfx = 0;
        
        for ( ;; )
        {
            if ( !isreallyalive( player ) )
            {
                self.inuseby = undefined;
                player.turret_overheat_bar destroyelem();
                break;
            }
            
            if ( !player isusingturret() )
            {
                self notify( "player_dismount" );
                self.inuseby = undefined;
                player.turret_overheat_bar destroyelem();
                player restoreperks();
                player restoreweapons();
                self sethintstring( level.sentrysettings[ self.sentrytype ].hintstring );
                self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
                sentry_setowner( self.originalowner );
                self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeon );
                break;
            }
            
            if ( self.heatlevel >= level.sentrysettings[ self.sentrytype ].overheattime )
            {
                barfrac = 1;
            }
            else
            {
                barfrac = self.heatlevel / level.sentrysettings[ self.sentrytype ].overheattime;
            }
            
            player.turret_overheat_bar updatebar( barfrac );
            
            if ( string_starts_with( self.sentrytype, "minigun_turret" ) )
            {
                minigun_turret = "minigun_turret";
            }
            
            if ( self.forcedisable || self.overheated )
            {
                self turretfiredisable();
                player.turret_overheat_bar.bar.color = coloroverheated;
                playingheatfx = 0;
            }
            else if ( self.heatlevel > level.sentrysettings[ self.sentrytype ].overheattime * 0.75 && string_starts_with( self.sentrytype, "minigun_turret" ) )
            {
                player.turret_overheat_bar.bar.color = colorunstable;
                
                if ( randomintrange( 0, 10 ) < 6 )
                {
                    self turretfireenable();
                }
                else
                {
                    self turretfiredisable();
                }
                
                if ( !playingheatfx )
                {
                    playingheatfx = 1;
                    thread playheatfx();
                }
            }
            else
            {
                player.turret_overheat_bar.bar.color = colorstable;
                self turretfireenable();
                playingheatfx = 0;
                self notify( "not_overheated" );
            }
            
            wait 0.05;
        }
        
        self setdefaultdroppitch( 0 );
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x2fb1
// Size: 0x46
function sentry_handleownerdisconnect()
{
    self endon( "death" );
    level endon( "game_ended" );
    self notify( "sentry_handleOwner" );
    self endon( "sentry_handleOwner" );
    childthread sentry_watchownerstatus( "disconnect" );
    childthread sentry_watchownerstatus( "joined_team" );
    childthread sentry_watchownerstatus( "joined_spectators" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x2fff
// Size: 0x1f
function sentry_watchownerstatus( notifymsg )
{
    self.owner waittill( notifymsg );
    self notify( "death" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x3026
// Size: 0xa7
function sentry_setowner( owner )
{
    assertex( isdefined( owner ), "<dev string:xc5>" );
    assertex( isplayer( owner ), "<dev string:xf9>" + owner.classname );
    self.owner = owner;
    self setsentryowner( self.owner );
    self setturretminimapvisible( 1, self.sentrytype );
    
    if ( level.teambased )
    {
        self.team = self.owner.team;
        self setturretteam( self.team );
    }
    
    thread sentry_handleownerdisconnect();
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x30d5
// Size: 0x13
function sentry_moving_platform_death( data )
{
    self notify( "death" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x30f0
// Size: 0x3fc
function sentry_setplaced( enablepickup )
{
    if ( isdefined( self.owner ) )
    {
        sentrycount = self.owner.placedsentries[ self.sentrytype ].size;
        self.owner.placedsentries[ self.sentrytype ][ sentrycount ] = self;
        
        if ( sentrycount + 1 > 2 )
        {
            self.owner.placedsentries[ self.sentrytype ][ 0 ] notify( "death" );
        }
        
        self.owner allowweaponsforsentry( 1 );
        self.owner thread enablemeleeforsentry();
        self.owner enableworldup( 1 );
    }
    
    self setmodel( level.sentrysettings[ self.sentrytype ].modelbase );
    
    if ( self getmode() == "manual" )
    {
        self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
    }
    
    if ( self.sentrytype == "sentry_shock" )
    {
    }
    
    thread sentry_handledamage();
    thread sentry_handledeath();
    self setsentrycarrier( undefined );
    self setcandamage( 1 );
    
    switch ( self.sentrytype )
    {
        case #"hash_8a144557bd5ac067":
        case #"hash_8f3bfcef6a436f5b":
        case #"hash_8f3bfdef6a4370ee":
        case #"hash_8f3bfeef6a437281":
        case #"hash_8f3bffef6a437414":
        case #"hash_9cc148005b0186d6":
        case #"hash_9cc14a005b0189fc":
        case #"hash_9cc14b005b018b8f":
        case #"hash_9cc14d005b018eb5":
        case #"hash_ce05fbb198b1f5dd":
            if ( enablepickup )
            {
                self.angles = self.carriedby.angles;
                
                if ( isalive( self.originalowner ) )
                {
                    self.originalowner scripts\mp\utility\lower_message::setlowermessage( "pickup_hint", level.sentrysettings[ self.sentrytype ].ownerhintstring, 3, undefined, undefined, undefined, undefined, undefined, 1 );
                }
                
                self.ownertrigger = spawn( "trigger_radius", self.origin + ( 0, 0, 1 ), 0, 105, 64 );
                self.ownertrigger enablelinkto();
                self.ownertrigger linkto( self );
                assert( isdefined( self.ownertrigger ) );
                self.originalowner thread turret_handlepickup( self );
                thread turret_handleuse();
            }
            
            break;
        case #"hash_52d9b7ed584bec3e":
            self setdefaultdroppitch( 30 );
            break;
        default:
            break;
    }
    
    sentry_makesolid();
    
    if ( isdefined( self.bombsquadmodel ) )
    {
        self.bombsquadmodel show();
        level notify( "update_bombsquad" );
    }
    
    self.carriedby forceusehintoff();
    self.carriedby = undefined;
    self.firstplacement = undefined;
    
    if ( isdefined( self.owner ) )
    {
        self.owner.iscarrying = 0;
        self.owner notify( "new_sentry", self );
    }
    
    sentry_setactive( enablepickup );
    data = spawnstruct();
    
    if ( isdefined( self.moving_platform ) )
    {
        data.linkparent = self.moving_platform;
    }
    
    data.endonstring = "carried";
    data.deathoverridecallback = &sentry_moving_platform_death;
    thread scripts\mp\movers::handle_moving_platforms( data );
    
    if ( self.sentrytype != "multiturret" )
    {
        self playsound( "sentry_gun_plant" );
    }
    
    self notify( "placed" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x34f4
// Size: 0x9a
function sentry_setcancelled( var_ddd5b75d0cd367c5 )
{
    if ( isdefined( self.carriedby ) )
    {
        owner = self.carriedby;
        owner forceusehintoff();
        owner.iscarrying = undefined;
        owner.carrieditem = undefined;
        owner allowweaponsforsentry( 1 );
        owner thread enablemeleeforsentry();
        owner enableworldup( 1 );
        
        if ( isdefined( self.bombsquadmodel ) )
        {
            self.bombsquadmodel delete();
        }
    }
    
    if ( isdefined( var_ddd5b75d0cd367c5 ) && var_ddd5b75d0cd367c5 )
    {
        scripts\mp\weapons::equipmentdeletevfx();
    }
    
    self delete();
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 3
// Checksum 0x0, Offset: 0x3596
// Size: 0x173
function sentry_setcarried( carrier, enablepickup, cancelondeath )
{
    assert( isplayer( carrier ) );
    
    if ( isdefined( self.originalowner ) )
    {
        assertex( carrier == self.originalowner, "<dev string:x131>" );
    }
    else
    {
        assertex( carrier == self.owner, "<dev string:x131>" );
    }
    
    if ( self.sentrytype == "sentry_shock" )
    {
        self setscriptablepartstate( "muzzle", "neutral", 0 );
    }
    
    self setmodel( level.sentrysettings[ self.sentrytype ].modelgood );
    self setsentrycarrier( carrier );
    self setcandamage( 0 );
    sentry_makenotsolid();
    carrier enableworldup( 0 );
    self.carriedby = carrier;
    carrier.iscarrying = 1;
    self.pickupenabled = enablepickup;
    thread sentry_oncarrierdeathoremp( carrier, cancelondeath );
    carrier thread updatesentryplacement( self );
    thread sentry_oncarrierdisconnect( carrier );
    thread sentry_oncarrierchangedteam( carrier );
    thread sentry_ongameended();
    scripts\cp_mp\emp_debuff::allow_emp( 0 );
    self setdefaultdroppitch( -89 );
    sentry_setinactive();
    
    if ( isdefined( self getlinkedparent() ) )
    {
        self unlink();
    }
    
    self notify( "carried" );
    
    if ( isdefined( self.bombsquadmodel ) )
    {
        self.bombsquadmodel hide();
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x3711
// Size: 0x1e2
function updatesentryplacement( sentrygun )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    sentrygun endon( "placed" );
    sentrygun endon( "death" );
    sentrygun.canbeplaced = 1;
    var_a0c968fd72a36b5b = -1;
    
    for ( ;; )
    {
        placement = self canplayerplacesentry( 1, 40 );
        sentrygun.origin = placement[ "origin" ];
        sentrygun.angles = placement[ "angles" ];
        var_8509066f54f7c75a = array_combine( level.turrets, level.microturrets, level.supertrophy.trophies, level.mines );
        touchingturrets = sentrygun getistouchingentities( var_8509066f54f7c75a );
        sentrygun.canbeplaced = self isonground() && placement[ "result" ] && abs( sentrygun.origin[ 2 ] - self.origin[ 2 ] ) < 30 && !istouchingboundstrigger( self ) && touchingturrets.size == 0;
        
        if ( isdefined( placement[ "entity" ] ) )
        {
            sentrygun.moving_platform = placement[ "entity" ];
        }
        else
        {
            sentrygun.moving_platform = undefined;
        }
        
        if ( sentrygun.canbeplaced != var_a0c968fd72a36b5b )
        {
            if ( sentrygun.canbeplaced )
            {
                sentrygun setmodel( level.sentrysettings[ sentrygun.sentrytype ].modelgood );
                sentrygun placehinton();
            }
            else
            {
                sentrygun setmodel( level.sentrysettings[ sentrygun.sentrytype ].modelbad );
                sentrygun cannotplacehinton();
            }
        }
        
        var_a0c968fd72a36b5b = sentrygun.canbeplaced;
        wait 0.05;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 2
// Checksum 0x0, Offset: 0x38fb
// Size: 0x67
function sentry_oncarrierdeathoremp( carrier, cancelondeath )
{
    self endon( "placed" );
    self endon( "death" );
    carrier endon( "disconnect" );
    carrier waittill_any_2( "death", "emp_applied" );
    
    if ( self.canbeplaced && !istrue( cancelondeath ) )
    {
        sentry_setplaced( self.pickupenabled );
        return;
    }
    
    sentry_setcancelled( 0 );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x396a
// Size: 0x28
function sentry_oncarrierdisconnect( carrier )
{
    self endon( "placed" );
    self endon( "death" );
    carrier waittill( "disconnect" );
    self delete();
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x399a
// Size: 0x32
function sentry_oncarrierchangedteam( carrier )
{
    self endon( "placed" );
    self endon( "death" );
    carrier waittill_any_2( "joined_team", "joined_spectators" );
    self delete();
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x39d4
// Size: 0x28
function sentry_ongameended( carrier )
{
    self endon( "placed" );
    self endon( "death" );
    level waittill( "game_ended" );
    self delete();
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x3a04
// Size: 0x252
function sentry_setactive( enablepickup )
{
    self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeon );
    
    if ( enablepickup )
    {
        self setcursorhint( "HINT_NOICON" );
        self sethintstring( level.sentrysettings[ self.sentrytype ].hintstring );
        self makeusable();
    }
    
    foreach ( player in level.players )
    {
        switch ( self.sentrytype )
        {
            case #"hash_8a144557bd5ac067":
            case #"hash_8f3bfcef6a436f5b":
            case #"hash_8f3bfdef6a4370ee":
            case #"hash_8f3bfeef6a437281":
            case #"hash_8f3bffef6a437414":
            case #"hash_9cc148005b0186d6":
            case #"hash_9cc14a005b0189fc":
            case #"hash_9cc14b005b018b8f":
            case #"hash_9cc14d005b018eb5":
            case #"hash_ce05fbb198b1f5dd":
                if ( enablepickup )
                {
                    self enableplayeruse( player );
                }
                
                break;
            default:
                addtoactivekillstreaklist( self.sentrytype, "Killstreak_Ground", self.owner, 0, 1, 70, "carried" );
                
                if ( player == self.owner && enablepickup )
                {
                    self enableplayeruse( player );
                }
                else
                {
                    self disableplayeruse( player );
                }
                
                break;
        }
    }
    
    splashname = level.sentrysettings[ self.sentrytype ].teamsplash;
    
    if ( self.shouldsplash )
    {
        level thread teamplayercardsplash( splashname, self.owner );
        self.shouldsplash = 0;
    }
    
    if ( self.sentrytype == "sam_turret" )
    {
        thread sam_attacktargets();
    }
    
    if ( self.sentrytype == "scramble_turret" )
    {
        thread scrambleturretattacktargets();
    }
    
    if ( self.sentrytype == "sentry_shock" )
    {
        thread sentryshocktargets();
    }
    
    scripts\cp_mp\emp_debuff::allow_emp( 1 );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x3c5e
// Size: 0x52
function sentry_setinactive()
{
    if ( self.sentrytype == "manual_turret" )
    {
        self sethintstring( "" );
        self makeunusable();
    }
    
    self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
    self makeunusable();
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x3cb8
// Size: 0x9
function sentry_makesolid()
{
    self solid();
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x3cc9
// Size: 0x9
function sentry_makenotsolid()
{
    self notsolid();
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x3cda
// Size: 0x34, Type: bool
function isfriendlytosentry( sentrygun )
{
    if ( level.teambased && self.team == sentrygun.team )
    {
        return true;
    }
    
    return false;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x3d17
// Size: 0x6d
function sentry_attacktargets()
{
    self endon( "death" );
    level endon( "game_ended" );
    self.momentum = 0;
    self.heatlevel = 0;
    self.overheated = 0;
    thread sentry_heatmonitor();
    
    for ( ;; )
    {
        waittill_either( "turretstatechange", "cooled" );
        
        if ( self isfiringturret() )
        {
            thread sentry_burstfirestart();
            continue;
        }
        
        sentry_spindown();
        thread sentry_burstfirestop();
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x3d8c
// Size: 0x104
function sentry_timeout()
{
    self endon( "death" );
    level endon( "game_ended" );
    lifespan = level.sentrysettings[ self.sentrytype ].timeout;
    
    /#
        if ( !isdefined( lifespan ) )
        {
            lifespan = getdvarfloat( @"hash_7132e4633efb342c" );
        }
    #/
    
    if ( isdefined( lifespan ) && lifespan == 0 )
    {
        return;
    }
    
    while ( lifespan )
    {
        wait 1;
        scripts\mp\hostmigration::waittillhostmigrationdone();
        
        if ( !isdefined( self.carriedby ) )
        {
            lifespan = max( 0, lifespan - 1 );
        }
    }
    
    if ( isdefined( self.owner ) )
    {
        if ( isdefined( level.sentrysettings[ self.sentrytype ].votimeout ) )
        {
            self.owner scripts\cp_mp\utility\killstreak_utility::playkillstreakteamleaderdialog( self.streakinfo.streakname, level.sentrysettings[ self.sentrytype ].votimeout );
        }
    }
    
    self notify( "death" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x3e98
// Size: 0x39
function sentry_targetlocksound()
{
    self endon( "death" );
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
    wait 0.1;
    self playsound( "sentry_gun_beep" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x3ed9
// Size: 0x55
function sentry_spinup()
{
    thread sentry_targetlocksound();
    
    while ( self.momentum < level.sentrysettings[ self.sentrytype ].spinuptime )
    {
        self.momentum += 0.1;
        wait 0.1;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x3f36
// Size: 0xc
function sentry_spindown()
{
    self.momentum = 0;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x3f4a
// Size: 0x12b
function sentry_laser_burstfirestart()
{
    self endon( "death" );
    self endon( "stop_shooting" );
    level endon( "game_ended" );
    sentry_spinup();
    firetime = weaponfiretime( level.sentrysettings[ self.sentrytype ].weaponinfo );
    minshots = level.sentrysettings[ self.sentrytype ].burstmin;
    maxshots = level.sentrysettings[ self.sentrytype ].burstmax;
    
    if ( isdefined( self.supportturret ) && self.supportturret )
    {
        firetime = 0.05;
        numshots = 50;
    }
    else
    {
        firetime = 0.5 / ( self.listoffoundturrets.size + 1 );
        numshots = minshots;
    }
    
    for ( i = 0; i < numshots ; i++ )
    {
        turrettarget = self getturrettarget( 1 );
        
        if ( !isdefined( turrettarget ) )
        {
            break;
        }
        
        self shootturret();
        wait firetime;
    }
    
    self notify( "doneFiring" );
    self cleartargetentity();
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x407d
// Size: 0x152
function sentry_burstfirestart()
{
    self endon( "death" );
    self endon( "stop_shooting" );
    level endon( "game_ended" );
    sentry_spinup();
    firetime = weaponfiretime( level.sentrysettings[ self.sentrytype ].weaponinfo );
    minshots = level.sentrysettings[ self.sentrytype ].burstmin;
    maxshots = level.sentrysettings[ self.sentrytype ].burstmax;
    minpause = level.sentrysettings[ self.sentrytype ].pausemin;
    maxpause = level.sentrysettings[ self.sentrytype ].pausemax;
    
    for ( ;; )
    {
        numshots = randomintrange( minshots, maxshots + 1 );
        
        for ( i = 0; i < numshots && !self.overheated ; i++ )
        {
            self shootturret();
            self notify( "bullet_fired" );
            self.heatlevel += firetime;
            wait firetime;
        }
        
        wait randomfloatrange( minpause, maxpause );
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x41d7
// Size: 0xa
function sentry_burstfirestop()
{
    self notify( "stop_shooting" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x41e9
// Size: 0x88
function turret_shotmonitor( turret )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    turret endon( "death" );
    turret endon( "player_dismount" );
    firetime = weaponfiretime( level.sentrysettings[ turret.sentrytype ].weaponinfo );
    
    for ( ;; )
    {
        turret waittill( "turret_fire" );
        turret.heatlevel += firetime;
        turret.cooldownwaittime = firetime;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x4279
// Size: 0x1b8
function sentry_heatmonitor()
{
    self endon( "death" );
    firetime = weaponfiretime( level.sentrysettings[ self.sentrytype ].weaponinfo );
    var_c81d1ae9575cd803 = 0;
    var_6d613d4ed09f7ca = 0;
    overheattime = level.sentrysettings[ self.sentrytype ].overheattime;
    overheatcooldown = level.sentrysettings[ self.sentrytype ].cooldowntime;
    
    for ( ;; )
    {
        if ( self.heatlevel != var_c81d1ae9575cd803 )
        {
            wait firetime;
        }
        else
        {
            self.heatlevel = max( 0, self.heatlevel - 0.05 );
        }
        
        if ( self.heatlevel > overheattime )
        {
            self.overheated = 1;
            thread playheatfx();
            
            switch ( self.sentrytype )
            {
                case #"hash_8a144557bd5ac067":
                case #"hash_8f3bfcef6a436f5b":
                case #"hash_8f3bfdef6a4370ee":
                case #"hash_8f3bfeef6a437281":
                case #"hash_8f3bffef6a437414":
                    playfxontag( getfx( "sentry_smoke_mp" ), self, "tag_aim" );
                    break;
                default:
                    break;
            }
            
            while ( self.heatlevel )
            {
                self.heatlevel = max( 0, self.heatlevel - overheatcooldown );
                wait 0.1;
            }
            
            self.overheated = 0;
            self notify( "not_overheated" );
        }
        
        var_c81d1ae9575cd803 = self.heatlevel;
        wait 0.05;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x4439
// Size: 0xce
function turret_heatmonitor()
{
    self endon( "death" );
    overheattime = level.sentrysettings[ self.sentrytype ].overheattime;
    
    while ( true )
    {
        if ( self.heatlevel > overheattime )
        {
            self.overheated = 1;
            thread playheatfx();
            
            switch ( self.sentrytype )
            {
                case #"hash_ce05fbb198b1f5dd":
                    playfxontag( getfx( "sentry_smoke_mp" ), self, "tag_aim" );
                    break;
                default:
                    break;
            }
            
            while ( self.heatlevel )
            {
                wait 0.1;
            }
            
            self.overheated = 0;
            self notify( "not_overheated" );
        }
        
        wait 0.05;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x450f
// Size: 0x72
function turret_coolmonitor()
{
    self endon( "death" );
    
    while ( true )
    {
        if ( self.heatlevel > 0 )
        {
            if ( self.cooldownwaittime <= 0 )
            {
                self.heatlevel = max( 0, self.heatlevel - 0.05 );
            }
            else
            {
                self.cooldownwaittime = max( 0, self.cooldownwaittime - 0.05 );
            }
        }
        
        wait 0.05;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x4589
// Size: 0x5e
function playheatfx()
{
    self endon( "death" );
    self endon( "not_overheated" );
    level endon( "game_ended" );
    self notify( "playing_heat_fx" );
    self endon( "playing_heat_fx" );
    
    for ( ;; )
    {
        playfxontag( getfx( "sentry_overheat_mp" ), self, "tag_flash" );
        wait level.sentrysettings[ self.sentrytype ].fxtime;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x45ef
// Size: 0x37
function playsmokefx()
{
    self endon( "death" );
    self endon( "not_overheated" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        playfxontag( getfx( "sentry_smoke_mp" ), self, "tag_aim" );
        wait 0.4;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x462e
// Size: 0x32
function sentry_beepsounds()
{
    self endon( "death" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        wait 3;
        
        if ( !isdefined( self.carriedby ) )
        {
            self playsound( "sentry_gun_beep" );
        }
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x4668
// Size: 0x4f
function sam_attacktargets()
{
    self endon( "carried" );
    self endon( "death" );
    level endon( "game_ended" );
    self.samtargetent = undefined;
    self.sammissilegroups = [];
    
    while ( true )
    {
        self.samtargetent = sam_acquiretarget();
        sam_fireontarget();
        wait 0.05;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x46bf
// Size: 0x5d5
function sam_acquiretarget()
{
    eyeline = self gettagorigin( "tag_laser" );
    
    if ( !isdefined( self.samtargetent ) )
    {
        if ( level.teambased )
        {
            entitylist = [];
            enemyteams = getenemyteams( self.team );
            
            foreach ( entry in enemyteams )
            {
                foreach ( uav in level.uavmodels[ entry ] )
                {
                    entitylist[ entitylist.size ] = uav;
                }
            }
            
            foreach ( uav in entitylist )
            {
                if ( isdefined( uav.isleaving ) && uav.isleaving )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, uav.origin, 0, self ) )
                {
                    return uav;
                }
            }
            
            foreach ( lb in level.littlebirds )
            {
                if ( isdefined( lb.team ) && lb.team == self.team )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, lb.origin, 0, self ) )
                {
                    return lb;
                }
            }
            
            foreach ( heli in level.helis )
            {
                if ( isdefined( heli.team ) && heli.team == self.team )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, heli.origin, 0, self ) )
                {
                    return heli;
                }
            }
            
            foreach ( uav in level.remote_uav )
            {
                if ( !isdefined( uav ) )
                {
                    continue;
                }
                
                if ( isdefined( uav.team ) && uav.team == self.team )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, uav.origin, 0, self, uav ) )
                {
                    return uav;
                }
            }
        }
        else
        {
            foreach ( uav in level.uavmodels )
            {
                if ( isdefined( uav.isleaving ) && uav.isleaving )
                {
                    continue;
                }
                
                if ( isdefined( uav.owner ) && isdefined( self.owner ) && uav.owner == self.owner )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, uav.origin, 0, self ) )
                {
                    return uav;
                }
            }
            
            foreach ( lb in level.littlebirds )
            {
                if ( isdefined( lb.owner ) && isdefined( self.owner ) && lb.owner == self.owner )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, lb.origin, 0, self ) )
                {
                    return lb;
                }
            }
            
            foreach ( heli in level.helis )
            {
                if ( isdefined( heli.owner ) && isdefined( self.owner ) && heli.owner == self.owner )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, heli.origin, 0, self ) )
                {
                    return heli;
                }
            }
            
            foreach ( uav in level.remote_uav )
            {
                if ( !isdefined( uav ) )
                {
                    continue;
                }
                
                if ( isdefined( uav.owner ) && isdefined( self.owner ) && uav.owner == self.owner )
                {
                    continue;
                }
                
                if ( sighttracepassed( eyeline, uav.origin, 0, self, uav ) )
                {
                    return uav;
                }
            }
        }
        
        self cleartargetentity();
        return undefined;
    }
    
    if ( !sighttracepassed( eyeline, self.samtargetent.origin, 0, self ) )
    {
        self cleartargetentity();
        return undefined;
    }
    
    return self.samtargetent;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x4c9c
// Size: 0x25f
function sam_fireontarget()
{
    if ( isdefined( self.samtargetent ) )
    {
        if ( self.samtargetent == level.gunship.planemodel && !isdefined( level.gunshipplayer ) )
        {
            self.samtargetent = undefined;
            self cleartargetentity();
            return;
        }
        
        self settargetentity( self.samtargetent );
        self waittill( "turret_on_target" );
        
        if ( !isdefined( self.samtargetent ) )
        {
            return;
        }
        
        if ( !self.laser_on )
        {
            thread sam_watchlaser();
            thread sam_watchcrashing();
            thread sam_watchleaving();
            thread sam_watchlineofsight();
        }
        
        wait 2;
        
        if ( !isdefined( self.samtargetent ) )
        {
            return;
        }
        
        if ( self.samtargetent == level.gunship.planemodel && !isdefined( level.gunshipplayer ) )
        {
            self.samtargetent = undefined;
            self cleartargetentity();
            return;
        }
        
        rocketoffsets = [];
        rocketoffsets[ 0 ] = self gettagorigin( "tag_le_missile1" );
        rocketoffsets[ 1 ] = self gettagorigin( "tag_le_missile2" );
        rocketoffsets[ 2 ] = self gettagorigin( "tag_ri_missile1" );
        rocketoffsets[ 3 ] = self gettagorigin( "tag_ri_missile2" );
        missilegroup = self.sammissilegroups.size;
        
        for ( i = 0; i < 4 ; i++ )
        {
            if ( !isdefined( self.samtargetent ) )
            {
                return;
            }
            
            if ( isdefined( self.carriedby ) )
            {
                return;
            }
            
            self shootturret();
            rocket = _magicbullet( makeweapon( "sam_projectile_mp" ), rocketoffsets[ i ], self.samtargetent.origin, self.owner );
            rocket missile_settargetent( self.samtargetent );
            rocket missile_setflightmodedirect();
            rocket.samturret = self;
            rocket.sammissilegroup = missilegroup;
            self.sammissilegroups[ missilegroup ][ i ] = rocket;
            level notify( "sam_missile_fired", self.owner, rocket, self.samtargetent );
            
            if ( i == 3 )
            {
                break;
            }
            
            wait 0.25;
        }
        
        level notify( "sam_fired", self.owner, self.sammissilegroups[ missilegroup ], self.samtargetent );
        wait 3;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x4f03
// Size: 0x9b
function sam_watchlineofsight()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( isdefined( self.samtargetent ) && isdefined( self getturrettarget( 1 ) ) && self getturrettarget( 1 ) == self.samtargetent )
    {
        eyeline = self gettagorigin( "tag_laser" );
        
        if ( !sighttracepassed( eyeline, self.samtargetent.origin, 0, self, self.samtargetent ) )
        {
            self cleartargetentity();
            self.samtargetent = undefined;
            break;
        }
        
        wait 0.05;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x4fa6
// Size: 0x60
function sam_watchlaser()
{
    self endon( "death" );
    self laseron();
    self.laser_on = 1;
    
    while ( isdefined( self.samtargetent ) && isdefined( self getturrettarget( 1 ) ) && self getturrettarget( 1 ) == self.samtargetent )
    {
        waitframe();
    }
    
    self laseroff();
    self.laser_on = 0;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x500e
// Size: 0x51
function sam_watchcrashing()
{
    self endon( "death" );
    self.samtargetent endon( "death" );
    
    if ( !isdefined( self.samtargetent.helitype ) )
    {
        return;
    }
    
    self.samtargetent waittill( "crashing" );
    self cleartargetentity();
    self.samtargetent = undefined;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x5067
// Size: 0x6d
function sam_watchleaving()
{
    self endon( "death" );
    self.samtargetent endon( "death" );
    
    if ( !isdefined( self.samtargetent.model ) )
    {
        return;
    }
    
    if ( self.samtargetent.model == "vehicle_uav_static_mp" )
    {
        self.samtargetent waittill( "leaving" );
        self cleartargetentity();
        self.samtargetent = undefined;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x50dc
// Size: 0x81
function scrambleturretattacktargets()
{
    self endon( "carried" );
    self endon( "death" );
    level endon( "game_ended" );
    self.scrambletargetent = undefined;
    
    while ( true )
    {
        self.scrambletargetent = scramble_acquiretarget();
        
        if ( isdefined( self.scrambletargetent ) && isdefined( self.scrambletargetent.scrambled ) && !self.scrambletargetent.scrambled )
        {
            scrambletarget();
        }
        
        wait 0.05;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x5165
// Size: 0x8
function scramble_acquiretarget()
{
    return sam_acquiretarget();
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x5176
// Size: 0x128
function scrambletarget()
{
    if ( isdefined( self.scrambletargetent ) )
    {
        if ( self.scrambletargetent == level.gunship.planemodel && !isdefined( level.gunshipplayer ) )
        {
            self.scrambletargetent = undefined;
            self cleartargetentity();
            return;
        }
        
        self settargetentity( self.scrambletargetent );
        self waittill( "turret_on_target" );
        
        if ( !isdefined( self.scrambletargetent ) )
        {
            return;
        }
        
        if ( !self.laser_on )
        {
            thread scramble_watchlaser();
            thread scramble_watchcrashing();
            thread scramble_watchleaving();
            thread scramble_watchlineofsight();
        }
        
        wait 2;
        
        if ( !isdefined( self.scrambletargetent ) )
        {
            return;
        }
        
        if ( self.scrambletargetent == level.gunship.planemodel && !isdefined( level.gunshipplayer ) )
        {
            self.scrambletargetent = undefined;
            self cleartargetentity();
            return;
        }
        
        if ( !isdefined( self.scrambletargetent ) )
        {
            return;
        }
        
        if ( isdefined( self.carriedby ) )
        {
            return;
        }
        
        self shootturret();
        thread setscrambled();
        self notify( "death" );
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x52a6
// Size: 0x93
function setscrambled()
{
    scrambledtarget = self.scrambletargetent;
    scrambledtarget notify( "scramble_fired", self.owner );
    scrambledtarget endon( "scramble_fired" );
    scrambledtarget endon( "death" );
    scrambledtarget thread scripts\mp\killstreaks\helicopter::heli_targeting();
    scrambledtarget.scrambled = 1;
    scrambledtarget.secondowner = self.owner;
    scrambledtarget notify( "findNewTarget" );
    wait 30;
    
    if ( isdefined( scrambledtarget ) )
    {
        scrambledtarget.scrambled = 0;
        scrambledtarget.secondowner = undefined;
        scrambledtarget thread scripts\mp\killstreaks\helicopter::heli_targeting();
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x5341
// Size: 0x9b
function scramble_watchlineofsight()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( isdefined( self.scrambletargetent ) && isdefined( self getturrettarget( 1 ) ) && self getturrettarget( 1 ) == self.scrambletargetent )
    {
        eyeline = self gettagorigin( "tag_laser" );
        
        if ( !sighttracepassed( eyeline, self.scrambletargetent.origin, 0, self, self.scrambletargetent ) )
        {
            self cleartargetentity();
            self.scrambletargetent = undefined;
            break;
        }
        
        wait 0.05;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x53e4
// Size: 0x65
function scramble_watchlaser()
{
    self endon( "death" );
    self laseron();
    self.laser_on = 1;
    
    while ( isdefined( self.scrambletargetent ) && isdefined( self getturrettarget( 1 ) ) && self getturrettarget( 1 ) == self.scrambletargetent )
    {
        wait 0.05;
    }
    
    self laseroff();
    self.laser_on = 0;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x5451
// Size: 0x51
function scramble_watchcrashing()
{
    self endon( "death" );
    self.scrambletargetent endon( "death" );
    
    if ( !isdefined( self.scrambletargetent.helitype ) )
    {
        return;
    }
    
    self.scrambletargetent waittill( "crashing" );
    self cleartargetentity();
    self.scrambletargetent = undefined;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x54aa
// Size: 0x6d
function scramble_watchleaving()
{
    self endon( "death" );
    self.scrambletargetent endon( "death" );
    
    if ( !isdefined( self.scrambletargetent.model ) )
    {
        return;
    }
    
    if ( self.scrambletargetent.model == "vehicle_uav_static_mp" )
    {
        self.scrambletargetent waittill( "leaving" );
        self cleartargetentity();
        self.scrambletargetent = undefined;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x551f
// Size: 0xcd
function sentryshocktargets()
{
    self endon( "death" );
    self endon( "carried" );
    level endon( "game_ended" );
    thread watchsentryshockpickup();
    self.airlookatent = spawn_tag_origin( self.origin, self.angles );
    self.airlookatent linkto( self, "tag_flash" );
    
    while ( true )
    {
        result = waittill_any_timeout_1( 1, "turret_on_target" );
        
        if ( result == "timeout" )
        {
            continue;
        }
        
        self.sentryshocktargetent = self getturrettarget( 1 );
        
        if ( isdefined( self.sentryshocktargetent ) && isreallyalive( self.sentryshocktargetent ) )
        {
            thread shocktarget( self.sentryshocktargetent );
            self waittill( "done_firing" );
        }
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x55f4
// Size: 0x221
function searchforshocksentryairtarget()
{
    if ( isdefined( level.uavmodels ) )
    {
        if ( level.teambased )
        {
            enemyteams = getenemyteams( self.owner.team );
            
            foreach ( entry in enemyteams )
            {
                foreach ( uav in level.uavmodels[ entry ] )
                {
                    if ( targetvisibleinfront( uav ) )
                    {
                        return uav;
                    }
                }
            }
        }
        else
        {
            foreach ( uav in level.uavmodels )
            {
                if ( uav.owner == self.owner )
                {
                    continue;
                }
                
                if ( targetvisibleinfront( uav ) )
                {
                    return uav;
                }
            }
        }
    }
    
    if ( isdefined( level.helis ) )
    {
        foreach ( heli in level.helis )
        {
            if ( heli.streakname != "jackal" )
            {
                continue;
            }
            
            if ( level.teambased && heli.team == self.owner.team )
            {
                continue;
            }
            
            if ( !level.teambased && heli.owner == self.owner )
            {
                continue;
            }
            
            if ( targetvisibleinfront( heli ) )
            {
                return heli;
            }
        }
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x581d
// Size: 0x107
function targetvisibleinfront( target )
{
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    infront = 0;
    var_27653c8c1efd30b7 = self gettagorigin( "tag_flash" );
    targetpos = target.origin;
    var_11b27b4cc48cd1f4 = vectornormalize( targetpos - var_27653c8c1efd30b7 );
    attackerforward = anglestoforward( self.angles );
    ignorelist = [ self, self.owner, target ];
    contents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item" ] );
    
    if ( ray_trace_passed( var_27653c8c1efd30b7, targetpos, ignorelist, contents ) && vectordot( attackerforward, var_11b27b4cc48cd1f4 ) > 0.25 && distance2dsquared( var_27653c8c1efd30b7, targetpos ) > 10000 )
    {
        infront = 1;
    }
    
    return infront;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 2
// Checksum 0x0, Offset: 0x592d
// Size: 0x20c
function shootshocksentrysamtarget( target, var_bea243c252114a9c )
{
    self endon( "death" );
    self endon( "carried" );
    level endon( "game_ended" );
    self setmode( "manual" );
    thread setshocksamtargetent( target, var_bea243c252114a9c );
    self.sentryshocksamtarget = undefined;
    self waittill( "turret_on_target" );
    thread marktargetlaser( target );
    self playsound( "shock_sentry_charge_up" );
    playfxontag( getfx( "sentry_shock_charge" ), self, "tag_laser" );
    sentry_spinup();
    stopfxontag( getfx( "sentry_shock_charge" ), self, "tag_laser" );
    self notify( "start_firing" );
    self setscriptablepartstate( "coil", "active" );
    firedelay = 2;
    firenum = 1;
    
    while ( isdefined( target ) && targetvisibleinfront( target ) )
    {
        var_27653c8c1efd30b7 = self gettagorigin( "tag_flash" );
        seekingmissile = _magicbullet( makeweapon( "sentry_shock_missile_mp" ), var_27653c8c1efd30b7, target.origin, self.owner );
        seekingmissile missile_settargetent( target );
        seekingmissile missile_setflightmodedirect();
        seekingmissile.killcament = self.killcament;
        seekingmissile.streakinfo = self.streakinfo;
        self setscriptablepartstate( "muzzle", "fire" + firenum, 0 );
        level notify( "laserGuidedMissiles_incoming", self.owner, seekingmissile, target );
        firenum++;
        
        if ( firenum > 2 )
        {
            firenum = 1;
        }
        
        wait firedelay;
    }
    
    self setscriptablepartstate( "muzzle", "neutral", 0 );
    self notify( "sentry_lost_target" );
    var_bea243c252114a9c unlink();
    var_bea243c252114a9c.origin = self gettagorigin( "tag_flash" );
    var_bea243c252114a9c linkto( self, "tag_flash" );
    self setmode( "sentry" );
    self cleartargetentity();
    self setscriptablepartstate( "coil", "idle" );
    sentry_spindown();
    self notify( "done_firing" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x5b41
// Size: 0x4a
function sentry_handlemanualuse()
{
    self endon( "death" );
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        
        while ( player isusingturret() )
        {
            if ( player attackbuttonpressed() )
            {
                self shootturret();
            }
            
            waitframe();
        }
        
        waitframe();
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x5b93
// Size: 0x154
function sentry_handlealteratepickup( enablepickup )
{
    self endon( "death" );
    self.owner endon( "disconnect" );
    level endon( "game_ended" );
    self.owner notifyonplayercommand( "maunal_sentry_pickup", "+weapnext" );
    self.manualpickuptrigger = spawn( "trigger_radius", self.origin, 0, 128, 128 );
    self.manualpickuptrigger enablelinkto();
    self.manualpickuptrigger linkto( self, "tag_origin" );
    
    while ( true )
    {
        if ( isdefined( self.carriedby ) )
        {
            waitframe();
        }
        
        if ( !self.owner istouching( self.manualpickuptrigger ) )
        {
            waitframe();
        }
        
        self.owner waittill( "maunal_sentry_pickup" );
        assert( !isdefined( self.carriedby ) );
        self setmode( level.sentrysettings[ self.sentrytype ].sentrymodeoff );
        self.owner.placedsentries[ self.sentrytype ] = array_remove( self.owner.placedsentries[ self.sentrytype ], self );
        self.owner setcarryingsentry( self, 0, enablepickup );
    }
}

/#

    // Namespace autosentry / scripts\mp\killstreaks\autosentry
    // Params 0
    // Checksum 0x0, Offset: 0x5cef
    // Size: 0x36, Type: dev
    function function_edb5f98849f3a4d6()
    {
        self endon( "<dev string:x173>" );
        
        while ( true )
        {
            sphere( self.origin, 50, ( 0, 1, 0 ), 0, 20 );
            waitframe();
        }
    }

#/

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 2
// Checksum 0x0, Offset: 0x5d2d
// Size: 0xb2
function setshocksamtargetent( target, var_bea243c252114a9c )
{
    self endon( "death" );
    self endon( "carried" );
    self endon( "sentry_lost_target" );
    target endon( "death" );
    level endon( "game_ended" );
    
    while ( true )
    {
        startpoint = self gettagorigin( "tag_aim" );
        endpoint = target.origin;
        targetdirection = vectornormalize( endpoint - startpoint );
        var_180854261168edda = startpoint + targetdirection * 500;
        var_bea243c252114a9c unlink();
        var_bea243c252114a9c.origin = var_180854261168edda;
        var_bea243c252114a9c linkto( self );
        self settargetentity( var_bea243c252114a9c );
        waitframe();
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x5de7
// Size: 0x4e
function watchsentryshockpickup()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "carried" );
        
        if ( isdefined( self.sentryshocktargetent ) )
        {
            self.sentryshocktargetent = undefined;
        }
        
        if ( isdefined( self.sentryshocksamtarget ) )
        {
            self.sentryshocksamtarget = undefined;
        }
        
        self cleartargetentity();
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x5e3d
// Size: 0xf2
function shocktarget( target )
{
    self endon( "death" );
    self endon( "carried" );
    
    if ( !isdefined( target ) )
    {
        return;
    }
    
    thread marktargetlaser( target );
    self playsound( "shock_sentry_charge_up" );
    sentry_spinup();
    self notify( "start_firing" );
    level thread scripts\mp\battlechatter_mp::saytoself( target, "plr_killstreak_target" );
    firetime = weaponfiretime( level.sentrysettings[ self.sentrytype ].weaponinfo );
    
    while ( isdefined( target ) && isreallyalive( target ) && isdefined( self getturrettarget( 1 ) ) && self getturrettarget( 1 ) == target && !outlineoccluded( self gettagorigin( "tag_flash" ), target geteye() ) )
    {
        self shootturret();
        wait firetime;
    }
    
    self.sentryshocktargetent = undefined;
    self cleartargetentity();
    sentry_spindown();
    self notify( "done_firing" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x5f37
// Size: 0xf7
function missileburstfire( target )
{
    self endon( "death" );
    self endon( "carried" );
    missilecount = 3;
    firenum = 1;
    
    while ( missilecount > 0 )
    {
        if ( !isdefined( target ) )
        {
            return;
        }
        
        if ( !isdefined( self.owner ) )
        {
            return;
        }
        
        sentrymissile = _magicbullet( makeweapon( "sentry_shock_grenade_mp" ), self gettagorigin( "tag_flash" ), target.origin, self.owner );
        sentrymissile missile_settargetent( target, gettargetoffset( target ) );
        sentrymissile.killcament = self.killcament;
        sentrymissile.streakinfo = self.streakinfo;
        self setscriptablepartstate( "muzzle", "fire" + firenum, 0 );
        firenum++;
        
        if ( firenum > 2 )
        {
            firenum = 1;
        }
        
        sentrymissile thread watchtargetchange( target );
        missilecount--;
        wait 0.2;
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x6036
// Size: 0x98
function gettargetoffset( target )
{
    heightoffset = ( 0, 0, 40 );
    owner_stance = target getstance();
    
    switch ( owner_stance )
    {
        case #"hash_c6775c88e38f7803":
            heightoffset = ( 0, 0, 40 );
            break;
        case #"hash_3fed0cbd303639eb":
            heightoffset = ( 0, 0, 20 );
            break;
        case #"hash_d91940431ed7c605":
            heightoffset = ( 0, 0, 5 );
            break;
    }
    
    return heightoffset;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x60d7
// Size: 0x3c
function watchtargetchange( target )
{
    self endon( "death" );
    target endon( "disconnect" );
    
    while ( true )
    {
        if ( !isreallyalive( target ) )
        {
            self missile_settargetent( target getcorpseentity() );
            break;
        }
        
        waitframe();
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x611b
// Size: 0x46
function marktargetlaser( target )
{
    self endon( "death" );
    self laseron();
    self.laser_on = 1;
    waittill_any_2( "done_firing", "carried" );
    self laseroff();
    self.laser_on = 0;
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x6169
// Size: 0x1df
function watchshockdamage( target )
{
    self endon( "death" );
    self endon( "done_firing" );
    triggerradius = undefined;
    
    while ( true )
    {
        self waittill( "victim_damaged", victim, einflictor, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime );
        
        if ( victim == target )
        {
            damageradius = 100;
            var_b959b266290f9e13 = getplayersinradiusview( vpoint, damageradius, victim.team, self.owner );
            playfx( getfx( "sentry_shock_explosion" ), vpoint );
            
            if ( var_b959b266290f9e13.size > 0 )
            {
                foreach ( info in var_b959b266290f9e13 )
                {
                    if ( info.player != victim )
                    {
                        info.player dodamage( 5, vpoint, self.owner, self, smeansofdeath, objweapon );
                        var_879997a46f725f30 = undefined;
                        randomindex = undefined;
                        
                        if ( info.visiblelocations.size > 1 )
                        {
                            randomindex = randomint( info.visiblelocations.size );
                            var_879997a46f725f30 = info.visiblelocations[ randomindex ];
                        }
                        else
                        {
                            var_879997a46f725f30 = info.visiblelocations[ 0 ];
                        }
                        
                        playfxbetweenpoints( getfx( "sentry_shock_arc" ), vpoint, vectortoangles( var_879997a46f725f30 - vpoint ), var_879997a46f725f30 );
                    }
                }
            }
        }
    }
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 1
// Checksum 0x0, Offset: 0x6350
// Size: 0x40
function allowweaponsforsentry( allow )
{
    if ( allow )
    {
        val::reset_all( "sentry_weapons" );
        thread scripts\mp\supers::unstowsuperweapon();
        return;
    }
    
    thread scripts\mp\supers::allowsuperweaponstow();
    val::set( "sentry_weapons", "weapon", 0 );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x6398
// Size: 0x4d
function placehinton()
{
    sentrytype = self.sentrytype;
    
    if ( sentrytype == "super_trophy" )
    {
        self.owner forceusehinton( &"LUA_MENU_MP/PLACE_SUPER_TROPHY" );
        return;
    }
    
    self.owner forceusehinton( &"SENTRY/PLACE" );
}

// Namespace autosentry / scripts\mp\killstreaks\autosentry
// Params 0
// Checksum 0x0, Offset: 0x63ed
// Size: 0x4d
function cannotplacehinton()
{
    sentrytype = self.sentrytype;
    
    if ( sentrytype == "super_trophy" )
    {
        self.owner forceusehinton( &"LUA_MENU_MP/CANNOT_PLACE_SUPER_TROPHY" );
        return;
    }
    
    self.owner forceusehinton( &"SENTRY/CANNOT_PLACE" );
}

