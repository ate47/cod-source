#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_juggernaut;
#using scripts\cp\cp_loadout;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\loadout;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\juggernaut;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;

#namespace juggernaut_cp;

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 0
// Checksum 0x0, Offset: 0x301
// Size: 0x136
function init()
{
    scripts\engine\utility::registersharedfunc( "juggernaut", "initConfig", &jugg_initconfig );
    scripts\engine\utility::registersharedfunc( "juggernaut", "levelData", &jugg_leveldata );
    scripts\engine\utility::registersharedfunc( "juggernaut", "registerActionSet", &jugg_registeractionset );
    scripts\engine\utility::registersharedfunc( "juggernaut", "registerOnPlayerSpawnCallback", &jugg_registeronplayerspawncallback );
    scripts\engine\utility::registersharedfunc( "juggernaut", "dropCrateFromScriptedHeli", &jugg_dropcratefromscriptedheli );
    scripts\engine\utility::registersharedfunc( "juggernaut", "makeJuggernaut", &jugg_makejuggernautcallback );
    scripts\engine\utility::registersharedfunc( "juggernaut", "watchPickup", &jugg_watchpickup );
    scripts\engine\utility::registersharedfunc( "juggernaut", "getMoveSpeedScalar", &jugg_getmovespeedscalar );
    scripts\engine\utility::registersharedfunc( "juggernaut", "updateMoveSpeedScale", &jugg_updatemovespeedscale );
    scripts\engine\utility::registersharedfunc( "juggernaut", "allowActionSet", &jugg_allowactionset );
    scripts\engine\utility::registersharedfunc( "juggernaut", "canTriggerJuggernaut", &jugg_cantriggerjuggernaut );
    scripts\engine\utility::registersharedfunc( "juggernaut", "playOperatorUseLine", &jugg_playoperatoruseline );
    scripts\engine\utility::registersharedfunc( "juggernaut", "getMinigunWeapon", &jugg_getminigunweapon );
    scripts\engine\utility::registersharedfunc( "juggernaut", "juggernautWeaponPickedUp", &juggernautweaponpickedup );
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 0
// Checksum 0x0, Offset: 0x43f
// Size: 0x3d
function jugg_getminigunweapon()
{
    assertex( scripts\cp\utility::isjuggernaut(), "jugg_getMiniGunWeapon: Trying to get the player's ( jugg ) minigun weapon when not a jugg" );
    return self.juggcontext.juggconfig.classstruct.loadoutprimary;
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 0
// Checksum 0x0, Offset: 0x485
// Size: 0x4f
function function_a869748b27159997()
{
    assertex( scripts\cp\utility::isjuggernaut(), "jugg_getMiniGunWeaponUpdated: Trying to get the player's ( jugg ) minigun weapon when not a jugg" );
    minigunweaponobj = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845( self.juggcontext.juggconfig.classstruct.loadoutprimary );
    return minigunweaponobj;
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 1
// Checksum 0x0, Offset: 0x4dd
// Size: 0xb
function jugg_registeronplayerspawncallback( function )
{
    
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 7
// Checksum 0x0, Offset: 0x4f0
// Size: 0x49
function jugg_dropcratefromscriptedheli( owner, team, cratetype, position, angles, destination, data )
{
    return scripts\cp_mp\killstreaks\airdrop::dropcratefromscriptedheli( owner, team, cratetype, position, angles, destination, data );
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 2
// Checksum 0x0, Offset: 0x542
// Size: 0x1b
function jugg_makejuggernautcallback( config, streakinfo )
{
    return scripts\cp\cp_juggernaut::jugg_makejuggernaut( config, streakinfo );
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 1
// Checksum 0x0, Offset: 0x566
// Size: 0x12
function jugg_initconfig( config )
{
    return scripts\cp\cp_juggernaut::jugg_createconfig( config );
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 1
// Checksum 0x0, Offset: 0x581
// Size: 0x12
function jugg_leveldata( ref )
{
    return scripts\cp_mp\killstreaks\airdrop::getleveldata( ref );
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 1
// Checksum 0x0, Offset: 0x59c
// Size: 0x14
function jugg_watchpickup( droppingplayer )
{
    thread scripts\cp\weapon::watchweaponpickup( droppingplayer );
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 0
// Checksum 0x0, Offset: 0x5b8
// Size: 0x2a
function jugg_registeractionset()
{
    val::group_register( "fakeJugg", [ "slide", "prone", "reload" ] );
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 2
// Checksum 0x0, Offset: 0x5ea
// Size: 0x108
function juggernautweaponpickedup( juggernautweaponobject, prevweaponobject )
{
    if ( istrue( self.isjuggernaut ) )
    {
        return;
    }
    
    if ( isdefined( prevweaponobject ) && isdefined( prevweaponobject.basename ) && prevweaponobject.basename == "iw9_lm_dblmg2_cp" && !isdefined( level.var_7e81a64330ece925 ) )
    {
        maxclipammo = weaponclipsize( prevweaponobject );
        self setweaponammoclip( prevweaponobject, maxclipammo );
        return;
    }
    
    if ( isdefined( level.var_7e81a64330ece925 ) )
    {
        self [[ level.var_7e81a64330ece925 ]]( juggernautweaponobject, prevweaponobject );
    }
    
    self.minigunprevweaponobject = prevweaponobject;
    self.playerstreakspeedscale = scripts\cp\cp_juggernaut::jugg_getmovespeedscalar();
    scripts\cp\cp_loadout::updatemovespeedscale();
    val::group_set( "fakeJugg", 0 );
    
    if ( !istrue( level.disablemount ) )
    {
        val::set( "fakeJugg", "mount_top", 0 );
        val::set( "fakeJugg", "mount_side", 0 );
    }
    
    self notifyonplayercommand( "manual_switch_from_minigun", "+weapprev" );
    scripts\cp_mp\killstreaks\juggernaut::watchjuggernautweaponenduse( juggernautweaponobject, prevweaponobject );
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 0
// Checksum 0x0, Offset: 0x6fa
// Size: 0x8
function jugg_getmovespeedscalar()
{
    return scripts\cp\cp_juggernaut::jugg_getmovespeedscalar();
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 0
// Checksum 0x0, Offset: 0x70b
// Size: 0x9
function jugg_updatemovespeedscale()
{
    scripts\cp\loadout::updatemovespeedscale();
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 2
// Checksum 0x0, Offset: 0x71c
// Size: 0x1c
function jugg_allowactionset( name, allow )
{
    val::group_set( name, allow );
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 0
// Checksum 0x0, Offset: 0x740
// Size: 0x2
function jugg_decrementfauxvehiclecount()
{
    
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 0
// Checksum 0x0, Offset: 0x74a
// Size: 0x2
function jugg_incrementfauxvehiclecount()
{
    
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 1
// Checksum 0x0, Offset: 0x754
// Size: 0xd, Type: bool
function jugg_cantriggerjuggernaut( streakinfo )
{
    return true;
}

// Namespace juggernaut_cp / scripts\cp\killstreaks\juggernaut_cp
// Params 1
// Checksum 0x0, Offset: 0x76a
// Size: 0x1e
function jugg_playoperatoruseline( player )
{
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound( player, #"bc_killstreak_action_juggernaut" );
}

