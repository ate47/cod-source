#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\juggernaut;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\hud_util;
#using scripts\mp\juggernaut;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\weapons;

#namespace juggernaut_mp;

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 0
// Checksum 0x0, Offset: 0x326
// Size: 0x1c6
function init()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "juggernaut", &scripts\cp_mp\killstreaks\juggernaut::tryusejuggernautfromstruct );
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "juggernaut_mutant", &scripts\cp_mp\killstreaks\juggernaut::function_18cae431aa555ba3 );
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
    scripts\engine\utility::registersharedfunc( "juggernaut", "decrementFauxVehicleCount", &jugg_decrementfauxvehiclecount );
    scripts\engine\utility::registersharedfunc( "juggernaut", "incrementFauxVehicleCount", &jugg_incrementfauxvehiclecount );
    scripts\engine\utility::registersharedfunc( "juggernaut", "canTriggerJuggernaut", &jugg_cantriggerjuggernaut );
    scripts\engine\utility::registersharedfunc( "juggernaut", "playOperatorUseLine", &jugg_playoperatoruseline );
    scripts\engine\utility::registersharedfunc( "juggernaut", "playOperatorUseLine", &jugg_playoperatoruseline );
    scripts\engine\utility::registersharedfunc( "juggernaut", "juggernautWeaponPickedUp", &juggernautweaponpickedup );
    scripts\engine\utility::registersharedfunc( "juggernaut", "canReload", &scripts\mp\juggernaut::jugg_canreload );
    scripts\engine\utility::registersharedfunc( "juggernaut", "canUseWeaponPickups", &scripts\mp\juggernaut::jugg_canuseweaponpickups );
    scripts\engine\utility::registersharedfunc( "juggernaut", "getMinigunWeapon", &scripts\mp\juggernaut::jugg_getminigunweapon );
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 0
// Checksum 0x0, Offset: 0x4f4
// Size: 0x21
function jugg_registeractionset()
{
    val::group_register( "fakeJugg", [ "slide", "prone" ] );
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 1
// Checksum 0x0, Offset: 0x51d
// Size: 0xb
function jugg_registeronplayerspawncallback( function )
{
    
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 8
// Checksum 0x0, Offset: 0x530
// Size: 0x53
function jugg_dropcratefromscriptedheli( owner, team, cratetype, position, angles, destination, data, streakinfo )
{
    return scripts\cp_mp\killstreaks\airdrop::dropcratefromscriptedheli( owner, team, cratetype, position, angles, destination, data, streakinfo );
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 2
// Checksum 0x0, Offset: 0x58c
// Size: 0x1b
function jugg_makejuggernautcallback( config, streakinfo )
{
    return scripts\mp\juggernaut::jugg_makejuggernaut( config, streakinfo );
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 1
// Checksum 0x0, Offset: 0x5b0
// Size: 0x12
function jugg_initconfig( config )
{
    return scripts\mp\juggernaut::jugg_createconfig( config );
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 1
// Checksum 0x0, Offset: 0x5cb
// Size: 0x12
function jugg_leveldata( ref )
{
    return scripts\cp_mp\killstreaks\airdrop::getleveldata( ref );
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 1
// Checksum 0x0, Offset: 0x5e6
// Size: 0x14
function jugg_watchpickup( droppingplayer )
{
    thread scripts\mp\weapons::watchpickup( droppingplayer );
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 0
// Checksum 0x0, Offset: 0x602
// Size: 0x8
function jugg_getmovespeedscalar()
{
    return scripts\mp\juggernaut::jugg_getmovespeedscalar();
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 0
// Checksum 0x0, Offset: 0x613
// Size: 0x9
function jugg_updatemovespeedscale()
{
    scripts\mp\weapons::updatemovespeedscale();
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 2
// Checksum 0x0, Offset: 0x624
// Size: 0x1c
function jugg_allowactionset( name, allow )
{
    val::group_set( name, allow );
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 0
// Checksum 0x0, Offset: 0x648
// Size: 0x9
function jugg_decrementfauxvehiclecount()
{
    decrementfauxvehiclecount();
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 0
// Checksum 0x0, Offset: 0x659
// Size: 0x9
function jugg_incrementfauxvehiclecount()
{
    incrementfauxvehiclecount();
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 1
// Checksum 0x0, Offset: 0x66a
// Size: 0x77, Type: bool
function jugg_cantriggerjuggernaut( streakinfo )
{
    if ( getdvarint( @"hash_e33f3513a88f530c", 0 ) )
    {
        return true;
    }
    
    if ( currentactivevehiclecount() >= maxvehiclesallowed() || level.fauxvehiclecount + 1 >= maxvehiclesallowed() )
    {
        if ( issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/TOO_MANY_VEHICLES" );
        }
        
        return false;
    }
    
    return true;
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 2
// Checksum 0x0, Offset: 0x6ea
// Size: 0xd9
function juggernautweaponpickedup( juggernautweaponobject, prevweaponobject )
{
    if ( istrue( self.isjuggernaut ) )
    {
        return;
    }
    
    if ( isdefined( prevweaponobject ) && isdefined( prevweaponobject.basename ) && prevweaponobject.basename == "iw8_lm_dblmg_mp" )
    {
        maxclipammo = weaponclipsize( prevweaponobject );
        self setweaponammoclip( prevweaponobject, maxclipammo );
        return;
    }
    
    self.pickedupcoreminigun = 1;
    self.minigunprevweaponobject = prevweaponobject;
    self.playerstreakspeedscale = scripts\mp\juggernaut::jugg_getmovespeedscalar();
    scripts\mp\weapons::updatemovespeedscale();
    val::group_set( "fakeJugg", 0 );
    
    if ( !istrue( level.disablemount ) )
    {
        val::set( "fakeJugg", "mount_top", 0 );
        val::set( "fakeJugg", "mount_side", 0 );
    }
    
    scripts\cp_mp\killstreaks\juggernaut::watchjuggernautweaponenduse( juggernautweaponobject, prevweaponobject );
}

// Namespace juggernaut_mp / scripts\mp\killstreaks\juggernaut_mp
// Params 1
// Checksum 0x0, Offset: 0x7cb
// Size: 0x1e
function jugg_playoperatoruseline( player )
{
    level thread scripts\mp\battlechatter_mp::trysaylocalsound( player, #"bc_killstreak_action_juggernaut" );
}

