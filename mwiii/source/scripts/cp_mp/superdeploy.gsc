#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;

#namespace superdeploy;

#using_animtree( "script_model" );

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 10
// Checksum 0x0, Offset: 0x487
// Size: 0x205, Type: bool
function function_cfec51cac79ca4e6( superinfo, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_f6a32dcc4b19aad9, var_67a06b4ea269058e, waittime, skipfirstraise, isimmediate )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( self isonladder() )
    {
        return false;
    }
    
    if ( self ismantling() )
    {
        return false;
    }
    
    if ( isusingremote() )
    {
        return false;
    }
    
    weaponbasename = "super_remote_device_mp";
    
    if ( isdefined( var_f6a32dcc4b19aad9 ) )
    {
        weaponbasename = var_f6a32dcc4b19aad9;
    }
    
    weaponobj = makeweapon( weaponbasename );
    deployanim = %vm_ks_tablet_super_remote_raise;
    tabletanimlength = getanimlength( deployanim ) - getdvarfloat( @"hash_8416696fd33ebf85", 0.433 );
    
    if ( isdefined( waittime ) )
    {
        tabletanimlength = waittime;
    }
    
    function_4f203f286301b4ae( superinfo );
    val::set( "superDeploy", "allow_movement", 0 );
    val::set( "superDeploy", "allow_jump", 0 );
    val::set( "superDeploy", "usability", 0 );
    val::set( "superDeploy", "melee", 0 );
    val::set( "superDeploy", "offhand_weapons", 0 );
    val::set( "superDeploy", "supers", 0 );
    val::set( "superDeploy", "killstreaks", 0 );
    switchresult = function_323489241ce4764a( weaponobj, superinfo, &function_f3e423ce0923187e, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, skipfirstraise, isimmediate );
    
    if ( isdefined( self ) && _isalive() )
    {
        val::reset_all( "superDeploy" );
    }
    
    if ( !istrue( switchresult ) )
    {
        function_7cc79842967d7ae0( superinfo );
        
        if ( isdefined( self ) )
        {
            scripts\cp_mp\utility\killstreak_utility::stoptabletscreen( superinfo.staticdata.ref );
        }
        
        return false;
    }
    
    animresult = function_342f97880f848caa( superinfo, tabletanimlength, var_67a06b4ea269058e );
    function_7cc79842967d7ae0( superinfo );
    return istrue( animresult );
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 8
// Checksum 0x0, Offset: 0x695
// Size: 0x19a, Type: bool
function function_f3a5a94b1d50ed38( superinfo, weaponobj, firednotify, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    
    if ( !self isonground() && !self isswimming() )
    {
        return false;
    }
    
    if ( self isonladder() )
    {
        return false;
    }
    
    if ( istrue( self.super.isdeploying ) )
    {
        return false;
    }
    
    function_4f203f286301b4ae( superinfo );
    assertex( isdefined( weaponobj ) && weaponobj.basename != "<dev string:x1c>", "<dev string:x24>" + superinfo.staticdata.ref + "<dev string:x37>" );
    switchresult = function_323489241ce4764a( weaponobj, superinfo, &function_f3e423ce0923187e, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback );
    
    if ( !istrue( switchresult ) )
    {
        function_7cc79842967d7ae0( superinfo );
        return false;
    }
    
    if ( isdefined( superinfo ) && isdefined( superinfo.var_fb58a31c756db4cc ) )
    {
        scripts\common\values::group_set( superinfo.var_fb58a31c756db4cc, 0 );
        firedresult = function_e92aaca7f2fd7e8( superinfo, firednotify, weaponobj, weaponfiredcallback );
        scripts\common\values::group_reset( superinfo.var_fb58a31c756db4cc );
    }
    else
    {
        scripts\common\values::set( "firedDeploy", "offhand_weapons", 0 );
        firedresult = function_e92aaca7f2fd7e8( superinfo, firednotify, weaponobj, weaponfiredcallback );
        scripts\common\values::reset_all( "firedDeploy" );
    }
    
    function_7cc79842967d7ae0( superinfo );
    return istrue( firedresult );
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 7
// Checksum 0x0, Offset: 0x838
// Size: 0xd9
function function_8300ec48c43363d6( superinfo, weaponobj, keepweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback )
{
    assertex( isdefined( weaponobj ) && weaponobj.basename != "<dev string:x1c>", "<dev string:x24>" + superinfo.staticdata.ref + "<dev string:x37>" );
    function_4f203f286301b4ae( superinfo );
    cleanupwaitfunc = ter_op( istrue( keepweapon ), &function_f3e423ce0923187e, undefined );
    switchresult = function_323489241ce4764a( weaponobj, superinfo, cleanupwaitfunc, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback );
    
    if ( !istrue( switchresult ) )
    {
        function_7cc79842967d7ae0( superinfo );
        return 0;
    }
    
    function_7cc79842967d7ae0( superinfo );
    return 1;
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x919
// Size: 0x1dc, Type: bool
function private function_342f97880f848caa( superinfo, animlength, var_67a06b4ea269058e )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( !isdefined( var_67a06b4ea269058e ) )
    {
        var_67a06b4ea269058e = 1;
    }
    
    alias = "iw9_killstreak_tablet_gear";
    self playlocalsound( alias );
    setusingremote( superinfo.staticdata.ref );
    
    if ( issharedfuncdefined( "game", "objectiveUnPinPlayer" ) && isdefined( self.pinnedobjid ) )
    {
        [[ getsharedfunc( "game", "objectiveUnPinPlayer" ) ]]( self.pinnedobjid, self );
        self.remoteunpinned = 1;
    }
    
    _freezecontrols( 1, undefined, "superDeploy" );
    thread function_c46ce93718743bf6();
    
    if ( istrue( var_67a06b4ea269058e ) )
    {
        thread function_a74d2cee7557d7b1( animlength - 0.3 );
    }
    
    thread function_b351e53752cdb017( superinfo );
    thread function_1a0d50cc1357bdae();
    
    if ( animlength > 0 )
    {
        scripts\cp_mp\utility\killstreak_utility::starttabletscreen( superinfo.staticdata.ref, 0.05 );
    }
    
    result = waittill_any_timeout_3( animlength, "death", "weapon_change", "cancel_all_super_deployments" );
    self notify( "super_freeze_end" );
    _freezecontrols( 0, undefined, "superDeploy" );
    var_143705e9ee3a624a = !self isonground() && !function_d474b372046544b0() || self isonladder() || self isinfreefall() || self isparachuting();
    
    if ( !isdefined( result ) || result != "timeout" || var_143705e9ee3a624a )
    {
        self notify( "super_finished_with_deploy_weapon" );
        self stoplocalsound( "mp_killstreak_tablet_gear" );
        scripts\cp_mp\utility\killstreak_utility::stoptabletscreen( superinfo.staticdata.ref );
        self notify( "cancel_remote_sequence" );
        return false;
    }
    
    self notify( "deploy_weapon_anim_successful" );
    return true;
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xafe
// Size: 0x33
function private function_b351e53752cdb017( superinfo )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "super_finished_with_deploy_weapon" );
    
    if ( isusingremote() )
    {
        clearusingremote( 1 );
    }
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xb39
// Size: 0x46
function private function_1a0d50cc1357bdae()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "deploy_weapon_anim_successful" );
    self endon( "cancel_remote_sequence" );
    
    while ( true )
    {
        if ( !self isonground() && !function_d474b372046544b0() )
        {
            self notify( "cancel_all_super_deployments" );
            break;
        }
        
        waitframe();
    }
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb87
// Size: 0xa1
function private function_a74d2cee7557d7b1( timedelay )
{
    self endon( "disconnect" );
    result = waittill_any_timeout_1( timedelay, "cancel_remote_sequence" );
    
    if ( !isdefined( result ) || result == "cancel_remote_sequence" )
    {
        return;
    }
    
    if ( _isalive() )
    {
        self playlocalsound( "mp_killstreak_transition_whoosh" );
        level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer( self, 1, 0.3 );
        result = waittill_any_timeout_1( 0.7, "death" );
        
        if ( !isdefined( result ) || result == "death" )
        {
            self stoplocalsound( "mp_killstreak_transition_whoosh" );
        }
        
        level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer( self, 0, 0.3 );
    }
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xc30
// Size: 0x24
function private function_7cc79842967d7ae0( superinfo )
{
    superinfo.isdeploying = 0;
    val::reset_all( "deployStart" );
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xc5c
// Size: 0x26
function private function_c46ce93718743bf6()
{
    self endon( "disconnect" );
    self endon( "super_freeze_end" );
    level waittill( "round_switch" );
    _freezecontrols( 0, undefined, "superDeploy" );
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 9
// Checksum 0x0, Offset: 0xc8a
// Size: 0x14f
function function_323489241ce4764a( deployweaponobj, superinfo, cleanupwaitfunc, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, skipfirstraise, isimmediate )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    
    if ( self hasweapon( deployweaponobj ) )
    {
        return 0;
    }
    
    if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        if ( getcompleteweaponname( self getcurrentweapon() ) == "iw8_lm_dblmg_mp" )
        {
            self notify( "switched_from_minigun" );
            
            while ( getcompleteweaponname( self getcurrentweapon() ) == "iw8_lm_dblmg_mp" )
            {
                waitframe();
            }
        }
    }
    
    if ( !isdefined( skipfirstraise ) )
    {
        skipfirstraise = 1;
    }
    
    _giveweapon( deployweaponobj, 0, 0, skipfirstraise );
    givencallbackresult = function_dfc98a2de8e662a6( superinfo, weapongivencallback );
    
    if ( !istrue( givencallbackresult ) )
    {
        _takeweapon( deployweaponobj );
        return 0;
    }
    
    thread function_12bd106b0dd9b11d( superinfo, deployweaponobj );
    thread function_6ce6b67d4d0ff91b( superinfo, deployweaponobj );
    switchresult = domonitoredweaponswitch( deployweaponobj, istrue( isimmediate ) );
    superinfo notify( "deploy_weapon_switch_ended" );
    
    if ( isdefined( weaponswitchendedcallback ) )
    {
        self thread [[ weaponswitchendedcallback ]]( superinfo, switchresult );
    }
    
    waitframe();
    
    if ( !switchresult )
    {
        cleanupwaitfunc = undefined;
    }
    
    if ( !_isalive() )
    {
        return 0;
    }
    
    thread function_e65b31e6948c503( switchresult, superinfo, deployweaponobj, cleanupwaitfunc, weaponcleanupcallback, weapontakencallback );
    return switchresult;
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0xde2
// Size: 0x146
function private function_e65b31e6948c503( switchresult, superinfo, deployweaponobj, cleanupwaitfunc, weaponcleanupcallback, weapontakencallback )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    if ( isdefined( cleanupwaitfunc ) )
    {
        self [[ cleanupwaitfunc ]]( superinfo );
    }
    
    if ( self hasweapon( deployweaponobj ) )
    {
        remotetabletweapon = function_b04cbd5db8951229( deployweaponobj.basename );
        val::set( "cleanupDeployWeapon", "melee", 0 );
        val::set( "cleanupDeployWeapon", "offhand_weapons", 0 );
        
        if ( remotetabletweapon )
        {
            val::set( "cleanupDeployWeapon", "mantle", 0 );
            val::set( "cleanupDeployWeapon", "allow_movement", 0 );
            dofdelay = 0.5;
            
            if ( !isreallyalive( self ) )
            {
                dofdelay = 0;
            }
            
            scripts\cp_mp\utility\killstreak_utility::stoptabletscreen( superinfo.staticdata.ref, dofdelay, 1 );
            _freezelookcontrols( 1 );
        }
        
        if ( isdefined( weaponcleanupcallback ) )
        {
            self [[ weaponcleanupcallback ]]( superinfo, switchresult, deployweaponobj );
        }
        else
        {
            function_b22d2e6d02d50b21( deployweaponobj );
        }
        
        val::reset_all( "cleanupDeployWeapon" );
        
        if ( remotetabletweapon )
        {
            _freezelookcontrols( 0 );
        }
    }
    
    if ( isdefined( weapontakencallback ) )
    {
        self [[ weapontakencallback ]]( superinfo );
    }
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xf30
// Size: 0x54
function private function_b22d2e6d02d50b21( deployweaponobj )
{
    getridofweapon( deployweaponobj, istrue( self.var_4a2f2f50a9020e2e ) );
    self.var_4a2f2f50a9020e2e = undefined;
    currentweapon = self getcurrentweapon();
    
    if ( currentweapon.basename == "none" )
    {
        forcevalidweapon();
    }
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xf8c
// Size: 0x49
function private function_12bd106b0dd9b11d( superinfo, deployweaponobj )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    superinfo endon( "deploy_weapon_switch_ended" );
    self waittill( "cancel_all_super_deployments" );
    
    if ( isswitchingtoweaponwithmonitoring( deployweaponobj ) )
    {
        abortmonitoredweaponswitch( deployweaponobj );
    }
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 1
// Checksum 0x0, Offset: 0xfdd
// Size: 0x35
function function_b04cbd5db8951229( weaponname )
{
    remotetabletweapon = 0;
    
    switch ( weaponname )
    {
        case #"hash_288bc6291d670eaa":
            remotetabletweapon = 1;
            break;
    }
    
    return remotetabletweapon;
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x101b
// Size: 0x65
function private function_6ce6b67d4d0ff91b( superinfo, deployweaponobj )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    superinfo endon( "deploy_weapon_switch_ended" );
    self waittill( "melee_swipe_start" );
    
    if ( isswitchingtoweaponwithmonitoring( deployweaponobj ) )
    {
        abortmonitoredweaponswitch( deployweaponobj );
        return;
    }
    
    _takeweapon( deployweaponobj );
    thread domonitoredweaponswitch( self.lastdroppableweaponobj );
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1088
// Size: 0x74
function private function_4f203f286301b4ae( superinfo )
{
    assertex( !istrue( superinfo.isdeploying ), "<dev string:x7b>" + superinfo.staticdata.ref + "<dev string:x8f>" );
    superinfo.isdeploying = 1;
    val::set( "deployStart", "crate_use", 0 );
    val::set( "deployStart", "ascender_use", 0 );
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1104
// Size: 0x3c
function private function_dfc98a2de8e662a6( superinfo, weapongivencallback )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "cancel_all_super_deployments" );
    
    if ( isdefined( weapongivencallback ) )
    {
        return self [[ weapongivencallback ]]( superinfo );
    }
    
    return 1;
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1149
// Size: 0x7e
function private function_f3e423ce0923187e( superinfo )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    childthread function_afb1be43e272a00a( self, "super_finished_with_deploy_weapon" );
    childthread function_afb1be43e272a00a( self, "cancel_all_super_deployments" );
    childthread function_afb1be43e272a00a( self, "weapon_change" );
    
    while ( true )
    {
        self waittill( "super_finished_with_deploy_weapon", result );
        
        if ( isdefined( result ) && result == "weapon_change" )
        {
            if ( isusingremote() )
            {
                continue;
            }
        }
        
        break;
    }
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x11cf
// Size: 0x27
function private function_afb1be43e272a00a( ent, finishednotify )
{
    self endon( "super_finished_with_deploy_weapon" );
    ent waittill( finishednotify );
    self notify( "super_finished_with_deploy_weapon", finishednotify );
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 1
// Checksum 0x0, Offset: 0x11fe
// Size: 0x8e
function function_fceaa660b4da1c2b( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:xc1>" );
        return 0;
    }
    
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        weaponname = scripts\cp_mp\weapon::getweaponassetname( weapon );
        
        if ( !isdefined( weaponname ) )
        {
            weaponname = weapon;
        }
    }
    
    var_1880d2298e9e948a = 0;
    
    switch ( weaponname )
    {
        case #"hash_288bc6291d670eaa":
        case #"hash_c94fd51fe359fdfe":
            var_1880d2298e9e948a = 1;
            break;
    }
    
    return var_1880d2298e9e948a;
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 1
// Checksum 0x0, Offset: 0x1295
// Size: 0x28, Type: bool
function issuperweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:xf8>" );
        return false;
    }
    
    return isdefined( getsuperrefforsuperweapon( weapon ) );
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 1
// Checksum 0x0, Offset: 0x12c6
// Size: 0xa0
function getsuperrefforsuperweapon( weapon )
{
    if ( !isdefined( level.superglobals ) )
    {
        return undefined;
    }
    
    if ( !isstring( weapon ) )
    {
        weapon = weapon.basename;
    }
    
    superuseweapon = getsuperrefforsuperuseweapon( weapon );
    
    if ( isdefined( superuseweapon ) )
    {
        return superuseweapon;
    }
    
    superoffhand = getsuperrefforsuperoffhand( weapon );
    
    if ( isdefined( superoffhand ) )
    {
        return superoffhand;
    }
    
    superoffhand = getsuperrefforsuperextraweapon( weapon );
    
    if ( isdefined( superoffhand ) )
    {
        return superoffhand;
    }
    
    switch ( weapon )
    {
        case #"hash_1a30d3a1753a5b6":
            return "super_tac_insert";
        case #"hash_e2c74e289201361":
            return "super_loadout_drop";
    }
    
    return undefined;
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 1
// Checksum 0x0, Offset: 0x136f
// Size: 0x82
function getsuperrefforsuperuseweapon( weapon )
{
    if ( !isstring( weapon ) )
    {
        weapon = weapon.basename;
    }
    
    if ( !isdefined( level.superglobals ) || !isdefined( level.superglobals.superweapons ) || !isdefined( level.superglobals.superweapons[ weapon ] ) )
    {
        return undefined;
    }
    
    return level.superglobals.superweapons[ weapon ].ref;
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 1
// Checksum 0x0, Offset: 0x13fa
// Size: 0x5b
function getsuperrefforsuperoffhand( weapon )
{
    if ( !isstring( weapon ) )
    {
        weapon = weapon.basename;
    }
    
    if ( !isdefined( level.superglobals.supersbyoffhand[ weapon ] ) )
    {
        return undefined;
    }
    
    return level.superglobals.supersbyoffhand[ weapon ].ref;
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 1
// Checksum 0x0, Offset: 0x145e
// Size: 0x74
function getsuperrefforsuperextraweapon( weapon )
{
    if ( !isstring( weapon ) )
    {
        weapon = weapon.basename;
    }
    
    if ( !isdefined( level.superglobals.supersbyextraweapon ) || !isdefined( level.superglobals.supersbyextraweapon[ weapon ] ) )
    {
        return undefined;
    }
    
    return level.superglobals.supersbyextraweapon[ weapon ].ref;
}

// Namespace superdeploy / scripts\cp_mp\superdeploy
// Params 4
// Checksum 0x0, Offset: 0x14db
// Size: 0x13c, Type: bool
function function_e92aaca7f2fd7e8( superinfo, firednotify, var_4ef1099365450bae, weaponfiredcallback )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "weapon_change" );
    self endon( "cancel_all_super_deployments" );
    
    while ( true )
    {
        firedweaponobj = undefined;
        firedprojectile = undefined;
        
        switch ( firednotify )
        {
            case #"hash_21a23ad4b32e4f8e":
                self waittill( firednotify, firedweaponobj );
                break;
            case #"hash_77f5cb8818a754f0":
                self waittill( firednotify, firedweaponobj );
                break;
            case #"hash_3989359e2b52d1ba":
                self waittill( firednotify, firedprojectile, firedweaponobj );
                break;
            default:
                self waittill( firednotify );
                break;
        }
        
        if ( firedweaponobj == var_4ef1099365450bae )
        {
            if ( isdefined( weaponfiredcallback ) )
            {
                firedresult = [[ weaponfiredcallback ]]( superinfo, firedweaponobj, firedprojectile );
                
                if ( !isdefined( firedresult ) )
                {
                    assertex( isdefined( firedresult ), "<dev string:x130>" );
                    return false;
                }
                else if ( firedresult == "failure" )
                {
                    return false;
                }
                else if ( firedresult == "continue" )
                {
                    continue;
                }
                else if ( firedresult == "success" )
                {
                    return true;
                }
                else
                {
                    assertmsg( "<dev string:x196>" );
                    return false;
                }
            }
            
            return true;
        }
    }
    
    return false;
}

