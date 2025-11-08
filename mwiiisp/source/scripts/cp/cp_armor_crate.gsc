#using scripts\common\utility;
#using scripts\cp\challenges_cp;
#using scripts\cp\cp_deployablebox;
#using scripts\cp\utility;
#using scripts\cp_mp\armor;
#using scripts\engine\utility;

#namespace cp_armor_crate;

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 0
// Checksum 0x0, Offset: 0x2d1
// Size: 0x1e1
function armor_crate_init()
{
    var_86280fefb94b6b28 = spawnstruct();
    var_86280fefb94b6b28.id = "armor";
    var_86280fefb94b6b28.weaponinfo = "iw8_armor_marker_cp";
    var_86280fefb94b6b28.modelbase = "offhand_2h_wm_armor_box_v0";
    var_86280fefb94b6b28.hintstring = &"EQUIPMENT_HINTS/ARMOR_BOX_USE";
    var_86280fefb94b6b28.streakname = "armor";
    var_86280fefb94b6b28.splashname = "used_support_box";
    var_86280fefb94b6b28.shadername = "hud_icon_fieldupgrade_armor_box";
    var_86280fefb94b6b28.headicon = "hud_icon_fieldupgrade_armor_box";
    var_86280fefb94b6b28.headiconoffset = 20;
    var_86280fefb94b6b28.lifespan = 300;
    var_86280fefb94b6b28.usexp = 50;
    var_86280fefb94b6b28.onusesfx = "ammo_crate_use";
    var_86280fefb94b6b28.deployedsfx = "ammo_crate_use";
    var_86280fefb94b6b28.deathvfx = loadfx( "vfx/iw9/fieldupgrades/ammobox/vfx_armorbox_timeout.vfx" );
    var_86280fefb94b6b28.onusecallback = &armorbox_onusedeployable;
    var_86280fefb94b6b28.canusecallback = &armorbox_canusedeployable;
    var_86280fefb94b6b28.onusethanksbc = #"ping_social_thanks";
    var_86280fefb94b6b28.usetime = 1000;
    var_86280fefb94b6b28.maxhealth = 100;
    var_86280fefb94b6b28.maxuses = 3;
    var_86280fefb94b6b28.canreusebox = 0;
    var_86280fefb94b6b28.allowmeleedamage = 1;
    var_86280fefb94b6b28.damagefeedback = "";
    var_86280fefb94b6b28.grenadeusefunc = &supportbox_grenadelaunchfunc;
    var_86280fefb94b6b28.ondeploycallback = &supportbox_ondeploy;
    var_86280fefb94b6b28.deployanimduration = supportbox_getdeployanimduration();
    level.boxsettings[ "armor" ] = var_86280fefb94b6b28;
    level.deployable_box[ "armor" ] = [];
}

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 2
// Checksum 0x0, Offset: 0x4ba
// Size: 0x21
function weaponswitchendedsupportbox( streakinfo, switchresult )
{
    if ( istrue( switchresult ) )
    {
        thread supportbox_watchplayerweapon( streakinfo );
    }
}

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 2
// Checksum 0x0, Offset: 0x4e3
// Size: 0x15, Type: bool
function tryusesupportbox( streakinfo, grenade )
{
    return true;
}

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 1
// Checksum 0x0, Offset: 0x501
// Size: 0xd, Type: bool
function armorbox_canusedeployable( boxent )
{
    return true;
}

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 1
// Checksum 0x0, Offset: 0x517
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

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 1
// Checksum 0x0, Offset: 0x5cf
// Size: 0x58, Type: bool
function armorbox_onusedeployable( boxent )
{
    self endon( "disconnect" );
    
    if ( scripts\cp_mp\armor::function_79e0ab2aa0304a2c() )
    {
        scripts\cp\utility::hint_prompt( "max_armor", 1, 3 );
        return false;
    }
    
    scripts\cp_mp\armor::function_9c6e9a6643b6c9a6( scripts\cp_mp\armor::function_47320a25b8ee003() );
    scripts\cp\challenges_cp::function_3d55d46e36d8430b();
    self playlocalsound( "weap_ammo_pickup" );
    boxent box_disableplayeruse( self );
    return true;
}

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 1
// Checksum 0x0, Offset: 0x630
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

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 0
// Checksum 0x0, Offset: 0x716
// Size: 0x20
function supportbox_handledamage()
{
    var_86280fefb94b6b28 = level.boxsettings[ self.boxtype ];
}

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 1
// Checksum 0x0, Offset: 0x73e
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

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 1
// Checksum 0x0, Offset: 0x7cf
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

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 2
// Checksum 0x0, Offset: 0x87c
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

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 2
// Checksum 0x0, Offset: 0x922
// Size: 0x41
function supportbox_waittill_notify( msg, ent )
{
    self endon( "death" );
    self endon( "disconnect" );
    ent endon( "die" );
    self waittill( msg, param );
    ent notify( "returned", msg, param );
}

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 0
// Checksum 0x0, Offset: 0x96b
// Size: 0x6e
function cangive_ammo()
{
    currentweapon = getvalidtakeweapon();
    current_ammo = self getweaponammoclip( currentweapon );
    max_clip = weaponclipsize( currentweapon );
    max_stock = weaponmaxammo( currentweapon );
    player_stock = self getweaponammostock( currentweapon );
    
    if ( player_stock < max_stock || current_ammo < max_clip )
    {
        return 1;
    }
    
    return 0;
}

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 5
// Checksum 0x0, Offset: 0x9e1
// Size: 0xd8
function adjust_clip_ammo_from_stock( player, sweapon, hand, maxclipammo, var_6747b178b5fc3b95 )
{
    if ( !istrue( var_6747b178b5fc3b95 ) )
    {
        maxstock = weaponmaxammo( sweapon );
        currentstock = player getweaponammostock( sweapon );
        stockdifference = maxstock - currentstock;
        var_db98701b04a114db = ter_op( stockdifference >= maxclipammo, currentstock + maxclipammo, maxstock );
        player setweaponammostock( sweapon, var_db98701b04a114db );
    }
    
    currammo = player getweaponammoclip( sweapon, hand );
    difference = maxclipammo - currammo;
    newammo = min( currammo + difference, maxclipammo );
    player setweaponammoclip( sweapon, int( newammo ), hand );
}

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 1
// Checksum 0x0, Offset: 0xac1
// Size: 0x33
function test_ammo_crate( player )
{
    player thread watch_dpad();
    player notify( "new_power", "crafted_autosentry" );
    set_crafted_inventory_item( "crafted_autosentry", &give_crafted_ammo_crate, player );
}

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 2
// Checksum 0x0, Offset: 0xafc
// Size: 0x3b
function give_crafted_ammo_crate( interaction_struct, player )
{
    player thread watch_dpad();
    player notify( "new_power", "crafted_autosentry" );
    set_crafted_inventory_item( "crafted_autosentry", &give_crafted_ammo_crate, player );
}

// Namespace cp_armor_crate / scripts\cp\cp_armor_crate
// Params 0
// Checksum 0x0, Offset: 0xb3f
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

