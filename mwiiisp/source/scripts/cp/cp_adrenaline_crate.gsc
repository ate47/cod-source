#using scripts\common\utility;
#using scripts\cp\cp_deployablebox;
#using scripts\cp\cp_visionsets;
#using scripts\cp\laststand;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace cp_adrenaline_crate;

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 0
// Checksum 0x0, Offset: 0x38b
// Size: 0x1bd
function adrenaline_crate_init()
{
    var_86280fefb94b6b28 = spawnstruct();
    var_86280fefb94b6b28.id = "adrenaline";
    var_86280fefb94b6b28.modelbase = "offhand_wm_supportbox";
    var_86280fefb94b6b28.hintstring = &"COOP_CRAFTING/ADRENALINE_TAKE";
    var_86280fefb94b6b28.streakname = "adrenaline";
    var_86280fefb94b6b28.splashname = "used_support_box";
    var_86280fefb94b6b28.shadername = "compass_objpoint_deploy_friendly";
    var_86280fefb94b6b28.headiconoffset = 20;
    var_86280fefb94b6b28.lifespan = 90;
    var_86280fefb94b6b28.usexp = 50;
    var_86280fefb94b6b28.onusesfx = "ammo_crate_use";
    var_86280fefb94b6b28.deployedsfx = "ammo_crate_use";
    var_86280fefb94b6b28.deathvfx = loadfx( "vfx/iw7/core/mp/killstreaks/vfx_dp_pickup_dust.vfx" );
    var_86280fefb94b6b28.onusecallback = &adrenalinebox_onusedeployable;
    var_86280fefb94b6b28.canusecallback = &adrenalinebox_canusedeployable;
    var_86280fefb94b6b28.deployfunc = &adrenalinebox_onusedeployable;
    var_86280fefb94b6b28.usetime = 1000;
    var_86280fefb94b6b28.maxhealth = 100;
    var_86280fefb94b6b28.maxuses = 4;
    var_86280fefb94b6b28.canreusebox = 0;
    var_86280fefb94b6b28.allowmeleedamage = 1;
    var_86280fefb94b6b28.damagefeedback = "";
    var_86280fefb94b6b28.grenadeusefunc = &supportbox_grenadelaunchfunc;
    var_86280fefb94b6b28.ondeploycallback = &supportbox_ondeploy;
    var_86280fefb94b6b28.deployanimduration = supportbox_getdeployanimduration();
    level.boxsettings[ "adrenaline" ] = var_86280fefb94b6b28;
    level.deployable_box[ "adrenaline" ] = [];
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 2
// Checksum 0x0, Offset: 0x550
// Size: 0x21
function weaponswitchendedsupportbox( streakinfo, switchresult )
{
    if ( istrue( switchresult ) )
    {
        thread supportbox_watchplayerweapon( streakinfo );
    }
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 2
// Checksum 0x0, Offset: 0x579
// Size: 0x15, Type: bool
function tryusesupportbox( streakinfo, grenade )
{
    return true;
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 1
// Checksum 0x0, Offset: 0x597
// Size: 0xd, Type: bool
function adrenalinebox_canusedeployable( boxent )
{
    return true;
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 1
// Checksum 0x0, Offset: 0x5ad
// Size: 0xb0
function supportbox_grenadelaunchfunc( boxent )
{
    start = self gettagorigin( "tag_accessory_left" );
    speed = 400;
    f = anglestoforward( self.angles );
    u = anglestoup( self.angles );
    u *= 0.6;
    dir = vectornormalize( f + u );
    velocity = dir * speed;
    throwngrenade = magicbullet( "iw8_ammocrate_marker_zm", start, start + velocity, self );
    self notify( "grenade_fire", throwngrenade );
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 1
// Checksum 0x0, Offset: 0x665
// Size: 0x28
function adrenalinebox_onusedeployable( boxent )
{
    self endon( "disconnect" );
    thread give_auto_revive();
    self setclientomnvar( "ui_self_revive", 1 );
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 1
// Checksum 0x0, Offset: 0x695
// Size: 0x128
function give_adrenaline_for_time( timer )
{
    var_2099048a1823ba6b = self.perk_data[ "regen_time_scalar" ];
    self.perk_data[ "regen_time_scalar" ] = 5;
    giveperk( "specialty_quickdraw" );
    giveperk( "specialty_quickswap" );
    giveperk( "specialty_lightweight" );
    giveperk( "specialty_fastreload" );
    giveperk( "specialty_stalker" );
    giveperk( "specialty_fastoffhand" );
    giveperk( "specialty_fastsprintrecovery" );
    scripts\cp\cp_visionsets::add_visionset_to_stack( self, "alien_feral", 2 );
    self lerpfovbypreset( "80_instant" );
    wait timer;
    self.perk_data[ "regen_time_scalar" ] = var_2099048a1823ba6b;
    _unsetperk( "specialty_quickswap" );
    _unsetperk( "specialty_quickdraw" );
    _unsetperk( "specialty_lightweight" );
    _unsetperk( "specialty_fastreload" );
    _unsetperk( "specialty_stalker" );
    _unsetperk( "specialty_fastoffhand" );
    _unsetperk( "specialty_fastsprintrecovery" );
    self lerpfovbypreset( "default_2seconds" );
    scripts\cp\cp_visionsets::remove_visionset_specific_from_stack( self, "alien_feral", 2 );
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 0
// Checksum 0x0, Offset: 0x7c5
// Size: 0x5a
function give_auto_revive()
{
    self endon( "disconnect" );
    self.has_auto_revive = 1;
    self waittill( "last_stand" );
    wait 0.1;
    
    if ( scripts\cp\laststand::player_in_laststand( self ) )
    {
        scripts\cp\laststand::instant_revive( self );
        
        if ( isdefined( self.dogtag ) )
        {
            self.dogtag delete();
        }
    }
    
    self.has_auto_revive = 0;
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 1
// Checksum 0x0, Offset: 0x827
// Size: 0xde
function supportbox_watchplayerweapon( streakinfo )
{
    self endon( "disconnect" );
    self endon( "deployable_deployed" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 3" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 4" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 5" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 6" );
    result = waittill_any_return_3( "grenade_fire", "cancel_deploy", "weapon_switch_started" );
    
    if ( !isdefined( result ) )
    {
        return;
    }
    
    if ( result == "cancel_deploy" )
    {
        self switchtoweapon( self.lastdroppableweaponobj );
    }
    
    while ( true )
    {
        currentweapon = self getcurrentweapon();
        
        if ( currentweapon != streakinfo.objweapon )
        {
            self notify( "killstreak_finished_with_weapon_" + streakinfo.weaponname );
            break;
        }
        
        waitframe();
    }
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 0
// Checksum 0x0, Offset: 0x90d
// Size: 0x20
function supportbox_handledamage()
{
    var_86280fefb94b6b28 = level.boxsettings[ self.boxtype ];
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 1
// Checksum 0x0, Offset: 0x935
// Size: 0x89
function supportbox_handledeathdamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    var_86280fefb94b6b28 = level.boxsettings[ self.boxtype ];
    attacker notify( "destroyed_equipment" );
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 1
// Checksum 0x0, Offset: 0x9c6
// Size: 0xa4
function supportbox_modifydamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    idflags = data.idflags;
    modifieddamage = damage;
    var_86280fefb94b6b28 = level.boxsettings[ self.boxtype ];
    return modifieddamage;
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 2
// Checksum 0x0, Offset: 0xa73
// Size: 0x9d
function supportbox_waittill_removeorweaponchange( removenotify, var_e12eb6c8616be7dc )
{
    self endon( "death" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    ent = spawnstruct();
    thread supportbox_waittill_notify( removenotify, ent );
    thread supportbox_waittill_notify( var_e12eb6c8616be7dc, ent );
    ent waittill( "returned", msg, param );
    ent notify( "die" );
    info = spawnstruct();
    info.msg = msg;
    info.param = param;
    return info;
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 2
// Checksum 0x0, Offset: 0xb19
// Size: 0x41
function supportbox_waittill_notify( msg, ent )
{
    self endon( "death" );
    self endon( "disconnect" );
    ent endon( "die" );
    self waittill( msg, param );
    ent notify( "returned", msg, param );
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 2
// Checksum 0x0, Offset: 0xb62
// Size: 0x3b
function give_crafted_ammo_crate( interaction_struct, player )
{
    player thread watch_dpad();
    player notify( "new_power", "crafted_autosentry" );
    set_crafted_inventory_item( "crafted_autosentry", &give_crafted_ammo_crate, player );
}

// Namespace cp_adrenaline_crate / scripts\cp\cp_adrenaline_crate
// Params 0
// Checksum 0x0, Offset: 0xba5
// Size: 0x92
function watch_dpad()
{
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "remove_sentry" );
    self notify( "craft_dpad_watcher" );
    self endon( "craft_dpad_watcher" );
    self notifyonplayercommand( "pullout_sentry", "+actionslot 4" );
    
    while ( true )
    {
        self waittill( "pullout_sentry" );
        
        if ( istrue( self.iscarrying ) )
        {
            continue;
        }
        
        if ( istrue( self.linked_to_coaster ) )
        {
            continue;
        }
        
        if ( isdefined( self.allow_carry ) && self.allow_carry == 0 )
        {
            continue;
        }
        
        if ( is_valid_player() )
        {
            break;
        }
    }
}

