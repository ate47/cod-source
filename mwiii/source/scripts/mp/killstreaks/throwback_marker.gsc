#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;

#namespace throwback_marker;

// Namespace throwback_marker / scripts\mp\killstreaks\throwback_marker
// Params 0
// Checksum 0x0, Offset: 0x1e5
// Size: 0x21
function init()
{
    val::group_register( "throwback_marker", [ "usability", "gesture" ] );
}

// Namespace throwback_marker / scripts\mp\killstreaks\throwback_marker
// Params 8
// Checksum 0x0, Offset: 0x20e
// Size: 0xe9, Type: bool
function throwbackmarker_trythrowbackmarker( streakinfo, weapondetonatefunc, weaponoverride, weapongivenfunc, weaponswitchendedfunc, weaponfiredfunc, weaponcleanupcallback, weapontakenfunc )
{
    weapongivencallback = &throwbackmarker_weapongiven;
    weaponswitchendedcallback = &throwbackmarker_weaponswitchended;
    weaponfiredcallback = &throwbackmarker_weaponfired;
    weapontakencallback = &throwbackmarker_weapontaken;
    streakinfo.throwbackmarker_weapondetonatefunc = weapondetonatefunc;
    streakinfo.throwbackmarker_weapongivenfunc = weapongivenfunc;
    streakinfo.throwbackmarker_weaponswitchendedfunc = weaponswitchendedfunc;
    streakinfo.throwbackmarker_weaponfiredfunc = weaponfiredfunc;
    streakinfo.throwbackmarker_weapontakenfunc = weapontakenfunc;
    deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dothrowbackmarkerdeploy( streakinfo, weaponoverride, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback );
    
    if ( !istrue( deployresult ) )
    {
        return false;
    }
    
    return true;
}

// Namespace throwback_marker / scripts\mp\killstreaks\throwback_marker
// Params 1
// Checksum 0x0, Offset: 0x300
// Size: 0x3a
function throwbackmarker_weapongiven( streakinfo )
{
    var_e9053b0829a68d67 = 1;
    
    if ( isdefined( streakinfo.throwbackmarker_weapongivenfunc ) )
    {
        var_e9053b0829a68d67 = level [[ streakinfo.throwbackmarker_weapongivenfunc ]]( streakinfo );
    }
    
    return var_e9053b0829a68d67;
}

// Namespace throwback_marker / scripts\mp\killstreaks\throwback_marker
// Params 2
// Checksum 0x0, Offset: 0x343
// Size: 0x42
function throwbackmarker_weaponswitchended( streakinfo, switchresult )
{
    if ( istrue( switchresult ) )
    {
        thread throwbackmarker_watchplayerweapon( streakinfo );
    }
    
    if ( isdefined( streakinfo.throwbackmarker_weaponswitchendedfunc ) )
    {
        level thread [[ streakinfo.throwbackmarker_weaponswitchendedfunc ]]( streakinfo, switchresult );
    }
}

// Namespace throwback_marker / scripts\mp\killstreaks\throwback_marker
// Params 1
// Checksum 0x0, Offset: 0x38d
// Size: 0x80
function throwbackmarker_watchplayerweapon( streakinfo )
{
    self endon( "disconnect" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 3" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 4" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 5" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 6" );
    result = waittill_any_return_2( "cancel_deploy", "weapon_switch_started" );
    
    if ( !isdefined( result ) )
    {
        return;
    }
    
    streakinfo notify( "killstreak_finished_with_deploy_weapon" );
}

// Namespace throwback_marker / scripts\mp\killstreaks\throwback_marker
// Params 3
// Checksum 0x0, Offset: 0x415
// Size: 0x65
function throwbackmarker_weaponfired( streakinfo, firedweaponobj, firedprojectile )
{
    firedresult = "success";
    level thread throwbackmarker_watchdetonate( streakinfo, firedprojectile, self );
    level thread throwbackmarker_watchthrowback( streakinfo, firedprojectile );
    
    if ( isdefined( streakinfo.throwbackmarker_weaponfiredfunc ) )
    {
        firedresult = [[ streakinfo.throwbackmarker_weaponfiredfunc ]]( streakinfo, firedweaponobj, firedprojectile );
    }
    
    return firedresult;
}

// Namespace throwback_marker / scripts\mp\killstreaks\throwback_marker
// Params 3
// Checksum 0x0, Offset: 0x483
// Size: 0x5d
function throwbackmarker_watchdetonate( streakinfo, projectile, owner )
{
    level endon( "game_ended" );
    projectile endon( "trigger" );
    projectile waittill( "explode", explodepos );
    
    if ( isdefined( streakinfo.throwbackmarker_weapondetonatefunc ) )
    {
        [[ streakinfo.throwbackmarker_weapondetonatefunc ]]( streakinfo, explodepos, owner );
    }
}

// Namespace throwback_marker / scripts\mp\killstreaks\throwback_marker
// Params 2
// Checksum 0x0, Offset: 0x4e8
// Size: 0x72
function throwbackmarker_watchthrowback( streakinfo, projectile )
{
    projectile endon( "fired_off" );
    projectile waittill( "trigger", player );
    player endon( "death_or_disconnect" );
    player waittill( "grenade_fire", grenade, weapon );
    level thread throwbackmarker_watchdetonate( streakinfo, grenade, player );
    level thread throwbackmarker_watchthrowback( streakinfo, grenade );
    player thread throwbackmarker_takeweapon( weapon );
}

// Namespace throwback_marker / scripts\mp\killstreaks\throwback_marker
// Params 1
// Checksum 0x0, Offset: 0x562
// Size: 0x51
function throwbackmarker_takeweapon( weapon )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    counter = 0;
    
    while ( counter < 5 )
    {
        if ( self hasweapon( weapon ) )
        {
            _takeweapon( weapon );
        }
        else
        {
            counter += 1;
        }
        
        wait 0.05;
    }
}

// Namespace throwback_marker / scripts\mp\killstreaks\throwback_marker
// Params 1
// Checksum 0x0, Offset: 0x5bb
// Size: 0x29
function throwbackmarker_weapontaken( streakinfo )
{
    if ( isdefined( streakinfo.throwbackmarker_weapontakenfunc ) )
    {
        [[ streakinfo.throwbackmarker_weapontakenfunc ]]( streakinfo );
    }
}

