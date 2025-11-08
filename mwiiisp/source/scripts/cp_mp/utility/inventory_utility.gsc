#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;

#namespace inventory_utility;

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 4
// Checksum 0x0, Offset: 0x38f
// Size: 0x42
function _giveweapon( weapon, variant, dualwieldoverride, usedbefore )
{
    if ( !isdefined( variant ) )
    {
        variant = -1;
    }
    
    if ( !isdefined( usedbefore ) )
    {
        usedbefore = 0;
    }
    
    self giveweapon( weapon, variant, istrue( dualwieldoverride ), -1, usedbefore );
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 1
// Checksum 0x0, Offset: 0x3d9
// Size: 0x23
function _switchtoweapon( weapon )
{
    /#
        debugweaponchangeprint( "<dev string:x1c>", weapon );
    #/
    
    self switchtoweapon( weapon );
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 1
// Checksum 0x0, Offset: 0x404
// Size: 0x23
function _switchtoweaponimmediate( weapon )
{
    /#
        debugweaponchangeprint( "<dev string:x31>", weapon );
    #/
    
    self switchtoweaponimmediate( weapon );
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 1
// Checksum 0x0, Offset: 0x42f
// Size: 0xd6
function _takeweapon( weapon )
{
    /#
        if ( getdvarint( @"hash_e6a5211d6811a3e", 0 ) != 0 )
        {
            debugweaponchangeprint( "<dev string:x4f>", weapon );
            
            if ( iscurrentweapon( weapon ) )
            {
                println( "<dev string:x60>" );
            }
        }
    #/
    
    var_fa1a9e12f5788a39 = 0;
    
    if ( isweapon( weapon ) )
    {
        var_fa1a9e12f5788a39 = self gethighpriorityweapon() == weapon;
    }
    else
    {
        assert( isstring( weapon ) );
        var_fa1a9e12f5788a39 = getcompleteweaponname( self gethighpriorityweapon() ) == weapon;
    }
    
    if ( var_fa1a9e12f5788a39 )
    {
        weaponstring = weapon;
        
        if ( !isstring( weaponstring ) && isweapon( weapon ) )
        {
            weaponstring = getcompleteweaponname( weapon );
        }
        
        assertmsg( "_takeWeapon called on the weapon that is the High Priority Weapon (" + weaponstring + "). Script should not do this." );
        self clearhighpriorityweapon( weapon );
    }
    
    self takeweapon( weapon );
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 1
// Checksum 0x0, Offset: 0x50d
// Size: 0x7b
function takeweaponwhensafe( weapon )
{
    self endon( "death" );
    self endon( "disconnect" );
    
    while ( true )
    {
        var_8dcc03beca90a5de = 0;
        
        if ( !iscurrentweapon( weapon ) )
        {
            meleeoverrideweapon = self getweaponmeleeslot();
            
            if ( !isnullweapon( meleeoverrideweapon ) && self.currentweapon == meleeoverrideweapon )
            {
                var_8dcc03beca90a5de = 0;
            }
            else
            {
                var_8dcc03beca90a5de = 1;
            }
        }
        
        if ( var_8dcc03beca90a5de )
        {
            break;
        }
        
        waitframe();
    }
    
    _takeweapon( weapon );
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 0
// Checksum 0x0, Offset: 0x590
// Size: 0x26
function getcurrentmonitoredweaponswitchweapon()
{
    validatehighpriorityflag();
    currenthighpriorityweapon = self gethighpriorityweapon();
    
    if ( isnullweapon( currenthighpriorityweapon ) )
    {
        return undefined;
    }
    
    return currenthighpriorityweapon;
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 0
// Checksum 0x0, Offset: 0x5bf
// Size: 0x9, Type: bool
function isanymonitoredweaponswitchinprogress()
{
    return isdefined( getcurrentmonitoredweaponswitchweapon() );
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 1
// Checksum 0x0, Offset: 0x5d1
// Size: 0x41, Type: bool
function isswitchingtoweaponwithmonitoring( weapon )
{
    if ( isstring( weapon ) )
    {
        weapon = makeweaponfromstring( weapon );
    }
    
    currentswitchweapon = getcurrentmonitoredweaponswitchweapon();
    return isdefined( currentswitchweapon ) && currentswitchweapon == weapon && !iscurrentweapon( weapon );
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 2
// Checksum 0x0, Offset: 0x61b
// Size: 0xec, Type: bool
function candomonitoredswitchtoweapon( weapon, var_26ca36763fa5b82 )
{
    if ( !self hasweapon( weapon ) )
    {
        return false;
    }
    
    if ( !val::get( "weapon" ) )
    {
        return false;
    }
    
    if ( !istrue( var_26ca36763fa5b82 ) && !val::get( "weapon_switch" ) && !val::get( "script_weapon_switch" ) )
    {
        return false;
    }
    
    currenthighpriorityweapon = getcurrentmonitoredweaponswitchweapon();
    
    if ( isdefined( currenthighpriorityweapon ) )
    {
        weaponbasename = getweaponbasename( weapon );
        newweaponhaspriority = 0;
        
        if ( weaponbasename == "briefcase_bomb_mp" || weaponbasename == "briefcase_bomb_mp_nuke" || weaponbasename == "briefcase_bomb_defuse_mp" || weaponbasename == "iw9_cyberemp_mp" || weaponbasename == "iw7_tdefball_mp" )
        {
            newweaponhaspriority = 1;
        }
        else if ( weaponinventorytype( currenthighpriorityweapon ) == "primary" )
        {
            newweaponhaspriority = 1;
        }
        
        if ( !newweaponhaspriority )
        {
            return false;
        }
    }
    
    if ( iscurrentweapon( weapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 1
// Checksum 0x0, Offset: 0x710
// Size: 0x4c
function abortmonitoredweaponswitch( weapon )
{
    /#
        debugweaponchangeprint( "<dev string:x7c>", weapon );
    #/
    
    assertex( !iscurrentweapon( weapon ), "abortMonitoredWeaponSwitch() called when the switch has already completed" );
    
    if ( self gethighpriorityweapon() == weapon )
    {
        self clearhighpriorityweapon( weapon );
    }
    
    _takeweapon( weapon );
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 3
// Checksum 0x0, Offset: 0x765
// Size: 0x12b
function domonitoredweaponswitch( weapon, switchimmediate, var_26ca36763fa5b82 )
{
    self endon( "disconnect" );
    self endon( "death" );
    
    if ( !isdefined( weapon ) )
    {
        return 0;
    }
    
    /#
        debugweaponchangeprint( "<dev string:x86>", weapon );
    #/
    
    if ( !candomonitoredswitchtoweapon( weapon, var_26ca36763fa5b82 ) )
    {
        /#
            debugweaponchangeprint( "<dev string:xaa>", weapon );
        #/
        
        return 0;
    }
    
    if ( isanymonitoredweaponswitchinprogress() )
    {
        self clearhighpriorityweapon( getcurrentmonitoredweaponswitchweapon() );
    }
    
    self sethighpriorityweapon( weapon );
    
    if ( istrue( switchimmediate ) )
    {
        _switchtoweaponimmediate( weapon );
    }
    
    while ( true )
    {
        if ( iscurrentweapon( weapon ) )
        {
            validatehighpriorityflag();
            
            /#
                debugweaponchangeprint( "<dev string:xd5>", weapon );
            #/
            
            return 1;
        }
        
        if ( !self ishighpriorityweapon( weapon ) || !self hasweapon( weapon ) )
        {
            /#
                debugweaponchangeprint( "<dev string:xfb>", weapon );
            #/
            
            return 0;
        }
        
        if ( !val::get( "weapon" ) || !istrue( var_26ca36763fa5b82 ) && !val::get( "weapon_switch" ) && !val::get( "script_weapon_switch" ) )
        {
            /#
                debugweaponchangeprint( "<dev string:x13d>", weapon );
            #/
            
            self clearhighpriorityweapon( weapon );
            return 0;
        }
        
        waitframe();
    }
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 0
// Checksum 0x0, Offset: 0x898
// Size: 0x7
function function_ed0dd95e839cd2a9()
{
    return "iw9_gunless_mp";
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 0
// Checksum 0x0, Offset: 0x8a8
// Size: 0x7
function function_3d5c51904fd25773()
{
    return "iw9_gunless_quickdrop_mp";
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 1
// Checksum 0x0, Offset: 0x8b8
// Size: 0x18
function givegunlessweapon( switchimmediate )
{
    return function_6d53276bd8e3c46d( switchimmediate, function_ed0dd95e839cd2a9() );
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 1
// Checksum 0x0, Offset: 0x8d9
// Size: 0x18
function function_f1e9d0c09f38006b( switchimmediate )
{
    return function_6d53276bd8e3c46d( switchimmediate, function_3d5c51904fd25773() );
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 2
// Checksum 0x0, Offset: 0x8fa
// Size: 0xe8
function function_6d53276bd8e3c46d( switchimmediate, weaponname )
{
    self endon( "death_or_disconnect" );
    
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    if ( isdefined( self.gunnlessweapon ) )
    {
        return;
    }
    
    gunless = makeweapon( weaponname );
    scripts\cp_mp\utility\inventory_utility::_giveweapon( gunless, undefined, undefined, 1 );
    val::reset_all( "gunless" );
    val::set( "gunless", "script_weapon_switch", 1 );
    println( self.name + "<dev string:x172>" );
    
    if ( !isdefined( switchimmediate ) )
    {
        switchimmediate = 0;
    }
    
    success = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( gunless, switchimmediate );
    
    if ( success )
    {
        self.gunnlessweapon = gunless;
    }
    else
    {
        scripts\cp_mp\utility\inventory_utility::_takeweapon( gunless );
        scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
    }
    
    val::set( "gunless", "script_weapon_switch", 0 );
    println( self.name + "<dev string:x19a>" );
    return success;
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 0
// Checksum 0x0, Offset: 0x9eb
// Size: 0x111
function takegunlessweapon()
{
    self endon( "death_or_disconnect" );
    
    if ( !isdefined( self.gunnlessweapon ) || !self hasweapon( self.gunnlessweapon ) )
    {
        return;
    }
    
    if ( ent_flag_exist( "swapLoadout_pending" ) && ent_flag( "swapLoadout_pending" ) )
    {
        ent_flag_wait( "swapLoadout_complete" );
    }
    
    val::reset_all( "gunless" );
    val::set( "gunless", "script_weapon_switch", 1 );
    println( self.name + "<dev string:x1c2>" );
    
    while ( self hasweapon( self.gunnlessweapon ) )
    {
        if ( !scripts\cp_mp\utility\inventory_utility::iscurrentweapon( self.gunnlessweapon ) )
        {
            scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch( self.gunnlessweapon );
        }
        else
        {
            scripts\cp_mp\utility\inventory_utility::_takeweapon( self.gunnlessweapon );
            scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
        }
        
        waitframe();
    }
    
    self.gunnlessweapon = undefined;
    val::set( "gunless", "script_weapon_switch", 0 );
    println( self.name + "<dev string:x1ea>" );
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 0
// Checksum 0x0, Offset: 0xb04
// Size: 0x25
function validatehighpriorityflag()
{
    currentweapon = self getcurrentweapon();
    
    if ( self ishighpriorityweapon( currentweapon ) )
    {
        self clearhighpriorityweapon( currentweapon );
    }
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 2
// Checksum 0x0, Offset: 0xb31
// Size: 0xb5, Type: bool
function getridofweapon( weapon, switchimmediate )
{
    self endon( "death" );
    self endon( "disconnect" );
    
    if ( !self hasweapon( weapon ) )
    {
        return false;
    }
    
    if ( !iscurrentweapon( weapon ) )
    {
        _takeweapon( weapon );
        return true;
    }
    
    while ( isanymonitoredweaponswitchinprogress() )
    {
        waitframe();
    }
    
    if ( !iscurrentweapon( weapon ) )
    {
        _takeweapon( weapon );
        return true;
    }
    
    switchresult = domonitoredweaponswitch( self.lastdroppableweaponobj, switchimmediate );
    
    if ( isbot( self ) )
    {
        self switchtoweaponimmediate( nullweapon() );
        switchresult = 1;
    }
    
    _takeweapon( weapon );
    self notify( "bomb_allow_offhands" );
    
    if ( !switchresult )
    {
        forcevalidweapon();
    }
    
    return true;
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 1
// Checksum 0x0, Offset: 0xbef
// Size: 0x292
function forcevalidweapon( bestweaponobj )
{
    self endon( "death" );
    self endon( "disconnect" );
    
    while ( isnullweapon( self getcurrentweapon() ) )
    {
        if ( self isswitchingweapon() || isanymonitoredweaponswitchinprogress() )
        {
            waitframe();
            continue;
        }
        
        var_78660c26e2d18376 = bestweaponobj;
        
        if ( istrue( self.isjuggernaut ) )
        {
            var_d5a7e66722df9836 = undefined;
            
            if ( utility::iscp() )
            {
                var_d5a7e66722df9836 = "iw9_lm_dblmg2_cp";
            }
            else
            {
                var_d5a7e66722df9836 = "iw9_minigunksjugg_mp";
            }
            
            if ( issharedfuncdefined( "juggernaut", "getMinigunWeapon" ) )
            {
                var_d5a7e66722df9836 = self [[ getsharedfunc( "juggernaut", "getMinigunWeapon" ) ]]();
            }
            
            if ( issharedfuncdefined( "juggernaut", "canUseWeaponPickups" ) )
            {
                canuseweaponpickups = self [[ getsharedfunc( "juggernaut", "canUseWeaponPickups" ) ]]();
                
                if ( istrue( canuseweaponpickups ) )
                {
                    if ( isdefined( self.lastdroppableweaponobj ) && self hasweapon( self.lastdroppableweaponobj ) )
                    {
                        var_d5a7e66722df9836 = self.lastdroppableweaponobj;
                    }
                    else
                    {
                        currentprimaries = getcurrentprimaryweaponsminusalt();
                        
                        if ( currentprimaries.size > 0 )
                        {
                            var_d5a7e66722df9836 = currentprimaries[ 0 ];
                        }
                    }
                }
            }
            
            if ( isstring( var_d5a7e66722df9836 ) )
            {
                var_78660c26e2d18376 = makeweapon( var_d5a7e66722df9836 );
            }
            else
            {
                var_78660c26e2d18376 = var_d5a7e66722df9836;
            }
        }
        else
        {
            currentprimaries = getcurrentprimaryweaponsminusalt();
            
            if ( !isdefined( var_78660c26e2d18376 ) || !self hasweapon( var_78660c26e2d18376 ) )
            {
                if ( ( !isdefined( self.lastdroppableweaponobj ) || self.lastdroppableweaponobj.basename == "none" ) && !self hasweapon( "iw9_me_fists_mp" ) )
                {
                    assertmsg( "switchPlayerToAnyWeapon() assumes self.lastDroppableWeaponObj is always defined and is not \"none\"" );
                    break;
                }
                
                if ( self hasweapon( self.lastdroppableweaponobj ) )
                {
                    var_78660c26e2d18376 = self.lastdroppableweaponobj;
                }
                else if ( currentprimaries.size > 0 )
                {
                    var_78660c26e2d18376 = currentprimaries[ 0 ];
                }
            }
            
            if ( isdefined( var_78660c26e2d18376 ) && getweaponbasename( var_78660c26e2d18376 ) == "iw7_axe_mp" && self getweaponammoclip( var_78660c26e2d18376 ) == 0 && currentprimaries.size == 1 )
            {
                var_78660c26e2d18376.basename = "iw9_me_fists_mp";
            }
            else if ( self hasweapon( "iw9_me_fists_mp" ) )
            {
                if ( currentprimaries.size == 1 )
                {
                    var_78660c26e2d18376 = currentprimaries[ 0 ];
                }
                else if ( currentprimaries.size == 2 && ( self hasweapon( "iw9_knifestab_mp" ) || self hasweapon( "iw8_throwingknife_fire_melee_mp" ) || self hasweapon( "iw8_throwingknife_electric_melee_mp" ) ) )
                {
                    if ( currentprimaries[ 0 ].basename == "iw9_me_fists_mp" )
                    {
                        var_78660c26e2d18376 = currentprimaries[ 0 ];
                    }
                    else
                    {
                        var_78660c26e2d18376 = currentprimaries[ 1 ];
                    }
                }
            }
        }
        
        domonitoredweaponswitch( var_78660c26e2d18376 );
        waitframe();
    }
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 1
// Checksum 0x0, Offset: 0xe89
// Size: 0x2a
function iscurrentweapon( weapon )
{
    if ( isstring( weapon ) )
    {
        weapon = makeweaponfromstring( weapon );
    }
    
    return issameweapon( self getcurrentweapon(), weapon, 1 );
}

// Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
// Params 0
// Checksum 0x0, Offset: 0xebc
// Size: 0x75
function getcurrentprimaryweaponsminusalt()
{
    primaryweapons = [];
    currentweapons = self getweaponslistprimaries();
    
    foreach ( weapon in currentweapons )
    {
        if ( !weapon.isalternate )
        {
            primaryweapons[ primaryweapons.size ] = weapon;
        }
    }
    
    return primaryweapons;
}

/#

    // Namespace inventory_utility / scripts\cp_mp\utility\inventory_utility
    // Params 2
    // Checksum 0x0, Offset: 0xf3a
    // Size: 0x5c, Type: dev
    function debugweaponchangeprint( message, weapon )
    {
        weaponstring = undefined;
        
        if ( isstring( weapon ) )
        {
            weaponstring = weapon;
        }
        else
        {
            weaponstring = getcompleteweaponname( weapon );
        }
        
        if ( getdvarint( @"hash_e6a5211d6811a3e", 0 ) != 0 )
        {
            println( message + "<dev string:x212>" + weaponstring );
        }
    }

#/
