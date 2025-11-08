#using scripts\common\utility;
#using scripts\cp\cp_deployablebox;
#using scripts\cp\equipment;
#using scripts\cp\utility;
#using scripts\cp_mp\equipment;
#using scripts\engine\utility;

#namespace cp_grenade_crate;

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 0
// Checksum 0x0, Offset: 0x34f
// Size: 0x1f4
function grenade_crate_init()
{
    var_86280fefb94b6b28 = spawnstruct();
    var_86280fefb94b6b28.id = "grenade_crate";
    var_86280fefb94b6b28.weaponinfo = "iw8_health_marker_cp";
    var_86280fefb94b6b28.modelbase = "offhand_wm_supportbox_explosives";
    var_86280fefb94b6b28.hintstring = &"COOP_CRAFTING/GRENADE_TAKE";
    var_86280fefb94b6b28.streakname = "grenade_crate";
    var_86280fefb94b6b28.splashname = "used_support_box";
    var_86280fefb94b6b28.shadername = "compass_objpoint_deploy_friendly";
    var_86280fefb94b6b28.headicon = "cp_crate_icon_lethalrefill";
    var_86280fefb94b6b28.headiconoffset = 20;
    var_86280fefb94b6b28.lifespan = 90;
    var_86280fefb94b6b28.usexp = 50;
    var_86280fefb94b6b28.onusesfx = "ammo_crate_use";
    var_86280fefb94b6b28.deployedsfx = "ammo_crate_use";
    var_86280fefb94b6b28.deathvfx = loadfx( "vfx/iw8/prop/scriptables/vfx_offhand_wm_supportbox_explosives_timeout.vfx" );
    var_86280fefb94b6b28.onusecallback = &healthbox_onusedeployable;
    var_86280fefb94b6b28.canusecallback = &healthbox_canusedeployable;
    var_86280fefb94b6b28.deployfunc = &healthbox_onusedeployable;
    var_86280fefb94b6b28.onusethanksbc = #"ping_social_thanks";
    var_86280fefb94b6b28.usetime = 1000;
    var_86280fefb94b6b28.maxhealth = 100;
    var_86280fefb94b6b28.maxuses = 4;
    var_86280fefb94b6b28.canreusebox = 0;
    var_86280fefb94b6b28.allowmeleedamage = 1;
    var_86280fefb94b6b28.damagefeedback = "";
    var_86280fefb94b6b28.grenadeusefunc = &healthbox_grenadelaunchfunc;
    var_86280fefb94b6b28.ondeploycallback = &supportbox_ondeploy;
    var_86280fefb94b6b28.deployanimduration = supportbox_getdeployanimduration();
    level.boxsettings[ "grenade_crate" ] = var_86280fefb94b6b28;
    level.deployable_box[ "grenade_crate" ] = [];
}

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 2
// Checksum 0x0, Offset: 0x54b
// Size: 0x21
function weaponswitchendedsupportbox( streakinfo, switchresult )
{
    if ( istrue( switchresult ) )
    {
        thread supportbox_watchplayerweapon( streakinfo );
    }
}

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 2
// Checksum 0x0, Offset: 0x574
// Size: 0x15, Type: bool
function tryusesupportbox( streakinfo, grenade )
{
    return true;
}

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 1
// Checksum 0x0, Offset: 0x592
// Size: 0xd, Type: bool
function healthbox_canusedeployable( boxent )
{
    return true;
}

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 1
// Checksum 0x0, Offset: 0x5a8
// Size: 0xb0
function healthbox_grenadelaunchfunc( boxent )
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

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 1
// Checksum 0x0, Offset: 0x660
// Size: 0x16d, Type: bool
function healthbox_onusedeployable( showhint )
{
    self endon( "disconnect" );
    grenade_full = 1;
    projectile_full = 1;
    primary_weapons = self getweaponslistprimaries();
    
    foreach ( weapon in primary_weapons )
    {
        if ( weapontype( weapon ) == "projectile" )
        {
            if ( weapon.basename == "iw8_la_mike32_mp" )
            {
                if ( self.gl_proj_override == "thermite" )
                {
                    continue;
                }
            }
            
            if ( !max_projectile_check( weapon ) )
            {
                projectile_full = 0;
                self setweaponammoclip( weapon, weaponclipsize( weapon ) );
                self givemaxammo( weapon );
            }
        }
        
        if ( weapon.inventorytype == "altmode" && isdefined( weapon.underbarrel ) && weapon.underbarrel == "ubshtgn" )
        {
            if ( !max_projectile_check( weapon ) )
            {
                projectile_full = 0;
                self setweaponammoclip( weapon, weaponclipsize( weapon ) );
                self setweaponammostock( weapon, 0 );
            }
        }
    }
    
    if ( scripts\cp\equipment::function_a6c819e1c09a2472() )
    {
        if ( !isdefined( showhint ) || showhint == 1 )
        {
            thread scripts\cp\utility::hint_prompt( "max_grenades", 1, 3 );
        }
        
        return false;
    }
    
    thread refill_grenades( self );
    return true;
}

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 1
// Checksum 0x0, Offset: 0x7d6
// Size: 0x62, Type: bool
function max_projectile_check( weapon )
{
    current_clip = self getweaponammoclip( weapon );
    current_stock = self getweaponammostock( weapon );
    max_clip = weaponclipsize( weapon );
    max_stock = weaponmaxammo( weapon );
    
    if ( current_stock < max_stock || current_clip < max_clip )
    {
        return false;
    }
    
    return true;
}

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 1
// Checksum 0x0, Offset: 0x841
// Size: 0x6f
function refill_grenades( player )
{
    player notify( "stop_restock_recharge" );
    primaries = player scripts\cp_mp\equipment::getcurrentequipment( "primary" );
    secondaries = player scripts\cp_mp\equipment::getcurrentequipment( "secondary" );
    
    if ( isdefined( primaries ) )
    {
        player thread scripts\cp_mp\equipment::setequipmentammo( primaries, 4 );
    }
    
    if ( isdefined( secondaries ) )
    {
        player thread scripts\cp_mp\equipment::setequipmentammo( secondaries, 4 );
    }
    
    player playlocalsound( "weap_ammo_pickup" );
}

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 1
// Checksum 0x0, Offset: 0x8b8
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

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 0
// Checksum 0x0, Offset: 0x99e
// Size: 0x20
function supportbox_handledamage()
{
    var_86280fefb94b6b28 = level.boxsettings[ self.boxtype ];
}

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 1
// Checksum 0x0, Offset: 0x9c6
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

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 1
// Checksum 0x0, Offset: 0xa57
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

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 2
// Checksum 0x0, Offset: 0xb04
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

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 2
// Checksum 0x0, Offset: 0xbaa
// Size: 0x41
function supportbox_waittill_notify( msg, ent )
{
    self endon( "death" );
    self endon( "disconnect" );
    ent endon( "die" );
    self waittill( msg, param );
    ent notify( "returned", msg, param );
}

// Namespace cp_grenade_crate / scripts\cp\cp_grenade_crate
// Params 0
// Checksum 0x0, Offset: 0xbf3
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

