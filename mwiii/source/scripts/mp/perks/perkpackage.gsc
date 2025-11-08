#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;
#using scripts\mp\perks\perkfunctions;
#using scripts\mp\supers;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;

#namespace perkpackage;

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x4ce
// Size: 0x19
function perkpackage_initperkpackages()
{
    perkpackage_initpersdata();
    thread perkpackage_updateifchanged();
    thread perkpackage_checkifready();
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x4ef
// Size: 0xdf
function perkpackage_checkifready()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "giveLoadout_start" );
    wasearned = 0;
    var_bfce2b88ef4bc0fd = 0;
    
    while ( true )
    {
        if ( !self.perkpackagedata.isusing && issuperready() )
        {
            if ( self.perkpackagedata.istwomode )
            {
                perkpackage_setstate( 1 );
                
                if ( true )
                {
                    function_fbff879439b14d48();
                    
                    if ( isdefined( level.perkpackage_checkifready_callback ) )
                    {
                        [[ level.perkpackage_checkifready_callback ]]();
                    }
                }
            }
            
            if ( level.superglobals.var_a33f6855d9867dbf )
            {
                return;
            }
            
            if ( wasearned )
            {
                thread showsuperremindersplash();
            }
        }
        
        self waittill( "super_ready", wasearned, var_bfce2b88ef4bc0fd );
        
        if ( isdefined( var_bfce2b88ef4bc0fd ) && var_bfce2b88ef4bc0fd )
        {
            self waittill( "super_ready", wasearned );
        }
    }
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x5d6
// Size: 0x431
function perkpackage_updateifchanged()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "giveLoadout_start" );
    firstupgrade = perkpackage_getfirstfieldupgrade();
    secondupgrade = perkpackage_getsecondfieldupgrade();
    var_75b88cc66efa33e6 = function_3e6359bc16258b7f();
    var_ccbf3ef1e3da6712 = function_fc8f75af9004a319();
    hassuper = isdefined( self.super );
    newfirst = !isdefined( self.perkpackagedata.firstupgrade ) || self.perkpackagedata.firstupgrade != firstupgrade;
    newsecond = !isdefined( self.perkpackagedata.secondupgrade ) || self.perkpackagedata.secondupgrade != secondupgrade;
    
    if ( !hassuper || newfirst || newsecond || self.perkpackagedata.forcereset )
    {
        var_1073d2b465f8a419 = getsuperid( firstupgrade );
        self setclientomnvar( "ui_perk_package_super1", var_1073d2b465f8a419 );
        var_41297be0f018b86d = getsuperid( secondupgrade );
        self setclientomnvar( "ui_perk_package_super2", var_41297be0f018b86d );
        
        if ( isdefined( getcurrentsuper() ) )
        {
            if ( self.perkpackagedata.forcereset )
            {
                setsuperbasepoints( 0 );
            }
            else
            {
                currentpoints = getcurrentsuperpoints();
                newpoints = currentpoints - 0;
                newpoints = max( newpoints, 0 );
                
                if ( !issuperinuse() && getcurrentsuperpoints() < getsuperpointsneeded() )
                {
                    setsuperbasepoints( newpoints, 1 );
                }
            }
        }
        
        if ( firstupgrade == "none" && secondupgrade == "none" )
        {
            self.perkpackagedata.istwomode = 0;
            scripts\mp\supers::function_e78f07efbcdb9e97();
            perkpackage_setstate( 0 );
            self.perkpackagedata.super = undefined;
            clearsuper();
        }
        else if ( secondupgrade == "none" )
        {
            self.perkpackagedata.istwomode = 0;
            scripts\mp\supers::function_e78f07efbcdb9e97();
            perkpackage_setstate( 3 );
            self.perkpackagedata.super = firstupgrade;
            
            if ( isdefined( self.var_678855513f5076ca ) && scripts\mp\perks\perkfunctions::function_66f0cbd5ff8458fe() )
            {
                givesuper( self.perkpackagedata.super, 0, 0, var_75b88cc66efa33e6 );
            }
            else
            {
                givesuper( self.perkpackagedata.super, 1, 0, var_75b88cc66efa33e6 );
            }
        }
        else if ( firstupgrade == "none" )
        {
            self.perkpackagedata.istwomode = 0;
            scripts\mp\supers::function_e78f07efbcdb9e97();
            perkpackage_setstate( 4 );
            self.perkpackagedata.super = secondupgrade;
            
            if ( isdefined( self.var_678855513f5076ca ) && scripts\mp\perks\perkfunctions::function_66f0cbd5ff8458fe() )
            {
                givesuper( self.perkpackagedata.super, 0, 0, var_ccbf3ef1e3da6712 );
            }
            else
            {
                givesuper( self.perkpackagedata.super, 1, 0, var_ccbf3ef1e3da6712 );
            }
        }
        else
        {
            self.perkpackagedata.istwomode = 1;
            function_c9491df86b072612();
            perkpackage_setstate( 0 );
            function_fbff879439b14d48();
        }
        
        var_35b042c5224a1646 = function_d8f9e4158e12de6b();
        
        if ( newfirst || newsecond )
        {
            if ( isdefined( var_35b042c5224a1646 ) )
            {
                if ( var_35b042c5224a1646 != firstupgrade && var_35b042c5224a1646 != secondupgrade )
                {
                    function_26f98b45fb791c0e();
                }
            }
        }
        
        if ( !istrue( self.perkpackagedata.istwomode ) )
        {
            if ( isdefined( var_35b042c5224a1646 ) && var_35b042c5224a1646 != firstupgrade )
            {
                function_26f98b45fb791c0e();
            }
        }
        
        if ( issuperready() )
        {
            thread showsuperremindersplash();
        }
        
        self.perkpackagedata.forcereset = 0;
        self.perkpackagedata.firstupgrade = firstupgrade;
        self.perkpackagedata.secondupgrade = secondupgrade;
    }
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0xa0f
// Size: 0xff
function function_fbff879439b14d48()
{
    if ( isdefined( self.perkpackagedata.super ) && self.perkpackagedata.super != "super_select" )
    {
        self.perkpackagedata.lastsuper = self.perkpackagedata.super;
        
        if ( function_4b10d71720fc4a4( self.perkpackagedata.lastsuper ) )
        {
            function_7abbee267d3aad2f( self.perkpackagedata.lastsuper );
        }
    }
    
    self.perkpackagedata.super = "super_select";
    
    if ( isdefined( self.var_678855513f5076ca ) && scripts\mp\perks\perkfunctions::function_66f0cbd5ff8458fe() )
    {
        givesuper( self.perkpackagedata.super, 0, 0 );
        return;
    }
    
    givesuper( self.perkpackagedata.super, 1, 0 );
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0xb16
// Size: 0x2e, Type: bool
function perkpackage_isreadytoupgrade()
{
    if ( !isdefined( self.perkpackagedata ) )
    {
        return false;
    }
    
    if ( self.perkpackagedata.state != 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 1
// Checksum 0x0, Offset: 0xb4d
// Size: 0x2d
function perkpackage_setstate( newstate )
{
    self setclientomnvar( "ui_perk_package_state", newstate );
    self.perkpackagedata.state = newstate;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0xb82
// Size: 0x30
function perkpackage_getfirstfieldupgrade()
{
    fieldupgrade = self.loadoutfieldupgrade1;
    
    if ( isdefined( self.overridefieldupgrade1 ) )
    {
        fieldupgrade = self.overridefieldupgrade1;
    }
    
    return fieldupgrade;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0xbbb
// Size: 0xb
function function_3e6359bc16258b7f()
{
    return self.var_4c4f03fa00925daf;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0xbcf
// Size: 0x30
function perkpackage_getsecondfieldupgrade()
{
    fieldupgrade = self.loadoutfieldupgrade2;
    
    if ( isdefined( self.overridefieldupgrade2 ) )
    {
        fieldupgrade = self.overridefieldupgrade2;
    }
    
    return fieldupgrade;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0xc08
// Size: 0xb
function function_fc8f75af9004a319()
{
    return self.var_2907f1614fe4e5f2;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0xc1c
// Size: 0x13a
function perkpackage_initpersdata()
{
    self.perkpackagedata = self.pers[ "perkPackageData" ];
    
    if ( !isdefined( self.perkpackagedata ) )
    {
        self.perkpackagedata = spawnstruct();
        self.perkpackagedata.state = 0;
        self.perkpackagedata.forcereset = 0;
        self.perkpackagedata.isusing = 0;
        self.perkpackagedata.firstupgrade = undefined;
        self.perkpackagedata.secondupgrade = undefined;
        self.perkpackagedata.super = "super_select";
        self.perkpackagedata.istwomode = 0;
        self.perkpackagedata.lastsuper = undefined;
        self.pers[ "perkPackageData" ] = self.perkpackagedata;
        
        if ( !isagent( self ) )
        {
            self setclientomnvar( "ui_perk_package_state", self.perkpackagedata.state );
        }
        
        if ( isdefined( self.perkpackagedata.overridepointsneeded ) )
        {
            scripts\mp\supers::function_e78f07efbcdb9e97();
        }
    }
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0xd5e
// Size: 0x7
function perkpackage_getperkicon()
{
    return "hud_icon_perk_blast_shield";
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0xd6e
// Size: 0x51
function perkpackage_openselect()
{
    canopenmenu = perkpackagemenu_canactivatesuper();
    isready = perkpackage_isreadytoupgrade();
    
    if ( !canopenmenu )
    {
        return 0;
    }
    
    if ( !isready )
    {
        return 0;
    }
    
    thread perkpackagemenu_openmenu();
    self notify( "perkPackage_endThink" );
    thread function_a33bba529da2a532();
    return 1;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0xdc7
// Size: 0x19
function function_a33bba529da2a532()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    waitframe();
    self notify( "superWeaponForceHoldSucceed" );
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0xde8
// Size: 0x103
function perkpackagemenu_openmenu()
{
    val::set( "ppmenu", "killstreaks", 0 );
    val::set( "ppmenu", "offhand_weapons", 0 );
    self notifyonplayercommand( "perkPackageMenu_option1", "+smoke" );
    self notifyonplayercommand( "perkPackageMenu_option2", "+frag" );
    thread perkpackagemenu_closeinputthink();
    success = perkpackagemenu_menuthink();
    success = istrue( success );
    
    if ( isdefined( self ) )
    {
        self notify( "perkPackage_endMenuThink" );
        var_3179afaa208defa2 = !success;
        
        if ( isreallyalive( self ) )
        {
            self notifyonplayercommandremove( "perkPackageMenu_option1", "+smoke" );
            self notifyonplayercommandremove( "perkPackageMenu_option2", "+frag" );
            superusefinished( var_3179afaa208defa2, 1 );
            val::reset_all( "ppmenu" );
        }
        else if ( !isreallyalive( self ) && var_3179afaa208defa2 )
        {
            thread function_a7fbaf375d6d6bfa();
        }
        
        if ( success )
        {
            perkpackage_awardperkpackageupgrade();
            return;
        }
        
        self.perkpackagedata.super = "super_select";
    }
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0xef3
// Size: 0xd9
function perkpackagemenu_menuthink()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "giveLoadout_start" );
    perkpackage_setstate( 2 );
    function_8daf361258c0dc41( 1 );
    var_1fa6614c0c6f0fcf = getdvarfloat( @"hash_6baabdf45e17acc1", 0 );
    wait var_1fa6614c0c6f0fcf;
    result = waittill_any_return_5( "perkPackageMenu_option1", "perkPackageMenu_option2", "perkPackageMenu_close", "death", "super_disable_start" );
    var_74fa01bd3626f0b7 = 0;
    function_8daf361258c0dc41( 0 );
    
    if ( result == "perkPackageMenu_option1" )
    {
        perkpackage_setstate( 3 );
        var_74fa01bd3626f0b7 = 1;
    }
    else if ( result == "perkPackageMenu_option2" )
    {
        perkpackage_setstate( 4 );
        var_74fa01bd3626f0b7 = 1;
    }
    else
    {
        perkpackage_setstate( 1 );
        var_74fa01bd3626f0b7 = 0;
        wait 0.3;
    }
    
    if ( !perkpackagemenu_canactivatesuper() )
    {
        var_74fa01bd3626f0b7 = 0;
    }
    
    return var_74fa01bd3626f0b7;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 1
// Checksum 0x0, Offset: 0xfd5
// Size: 0x54
function function_8daf361258c0dc41( isdisabled )
{
    if ( isdisabled )
    {
        val::set( "perkpackage_menu", "usability", 0 );
        val::set( "perkpackage_menu", "ascender_use", 0 );
        val::set( "perkpackage_menu", "vehicle_use", 0 );
        return;
    }
    
    val::reset_all( "perkpackage_menu" );
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x1031
// Size: 0x69
function function_a7fbaf375d6d6bfa()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "perkPackage_endMenuThink" );
    waittill_any_2( "spawned_player", "laststand_revived" );
    
    if ( !isdefined( self ) )
    {
        return 0;
    }
    
    superinfo = getcurrentsuper();
    
    if ( isdefined( superinfo ) )
    {
        setsuperexpended( 0 );
        superinfo.wasrefunded = 1;
        setsuperbasepoints( getsuperpointsneeded() );
    }
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x10a2
// Size: 0x3d
function perkpackagemenu_closeinputthink()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "giveLoadout_start" );
    self endon( "perkPackage_endMenuThink" );
    
    while ( true )
    {
        if ( !perkpackagemenu_canactivatesuper() )
        {
            self notify( "perkPackageMenu_close" );
        }
        
        wait 0.05;
    }
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x10e7
// Size: 0x48, Type: bool
function perkpackagemenu_canactivatesuper()
{
    if ( self usebuttonpressed() || self attackbuttonpressed() || self adsbuttonpressed() || self meleebuttonpressed() )
    {
        return false;
    }
    
    if ( !val::get( "supers" ) )
    {
        return false;
    }
    
    if ( self isonladder() )
    {
        return false;
    }
    
    return true;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x1138
// Size: 0x17c
function perkpackage_awardperkpackageupgrade()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "giveLoadout_start" );
    superref = undefined;
    
    if ( self.perkpackagedata.state == 3 )
    {
        superref = perkpackage_getfirstfieldupgrade();
    }
    else if ( self.perkpackagedata.state == 4 )
    {
        superref = perkpackage_getsecondfieldupgrade();
    }
    
    if ( isdefined( superref ) )
    {
        superinfo = getcurrentsuper();
        self.perkpackagedata.super = superref;
        
        if ( !function_f7da7a17e16c797b( superref ) )
        {
            givesuper( self.perkpackagedata.super, 0, 1 );
        }
        
        self.perkpackagedata.lastsuper = superref;
        
        if ( function_4b10d71720fc4a4( self.perkpackagedata.lastsuper ) )
        {
            function_7abbee267d3aad2f( self.perkpackagedata.lastsuper );
        }
        
        if ( true )
        {
            if ( !function_f7da7a17e16c797b( superref ) )
            {
                result = perkpackage_forceusesuper();
                
                if ( !istrue( result ) )
                {
                    self notify( "perkPackage_failed_super" );
                }
                else if ( isdefined( level.gamemodebundle ) && istrue( level.gamemodebundle.var_e12ed09bf2e43167 ) )
                {
                    thread function_6f2fc81c6517f7f0();
                }
            }
            else
            {
                function_baaf3c3b7be8ce8d( superref );
            }
            
            return;
        }
        
        thread perkpackagemenu_disableoffhanduse( 0.3 );
    }
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 1
// Checksum 0x0, Offset: 0x12bc
// Size: 0x96, Type: bool
function function_f7da7a17e16c797b( superref )
{
    if ( !isdefined( level.gamemodebundle ) || !istrue( level.gamemodebundle.var_e12ed09bf2e43167 ) )
    {
        return false;
    }
    
    if ( function_1b9785c7d0d6fbf6( superref ) || function_186c487ecca6691e( superref ) )
    {
        if ( !isdefined( self.perkpackagedata.var_cd8b7b499020de46 ) )
        {
            self.perkpackagedata.var_cd8b7b499020de46 = [];
        }
        
        if ( istrue( self.perkpackagedata.var_cd8b7b499020de46[ superref ] ) )
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    return false;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 1
// Checksum 0x0, Offset: 0x135b
// Size: 0xc3
function function_baaf3c3b7be8ce8d( superref )
{
    msg = function_7d4c7bff8926c0fd( superref );
    
    switch ( superref )
    {
        case #"hash_caf53e8cfa3f875d":
            self.var_972e08bb6f0816f1 = 1;
            break;
        case #"hash_2a2d382fc09b9c1b":
            self.var_75b981560f8453f4 = 1;
            break;
    }
    
    self notify( msg, "success" );
    
    if ( function_1b9785c7d0d6fbf6( superref ) )
    {
        self.var_3a4fe3013eb35ea0 = 1;
        thread function_6f2fc81c6517f7f0( superref, 1 );
        
        if ( function_1b9785c7d0d6fbf6( superref ) )
        {
            self.perkpackagedata.var_cd8b7b499020de46[ superref ] = undefined;
        }
        
        return;
    }
    
    function_fbff879439b14d48();
    perkpackage_setstate( 1 );
    setsuperbasepoints( 500 );
    return 1;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 2
// Checksum 0x0, Offset: 0x1426
// Size: 0x465
function function_6f2fc81c6517f7f0( var_e97e441ec7933198, skipwait )
{
    self notify( "give_other_super" );
    self endon( "death_or_disconnect" );
    self endon( "give_other_super" );
    level endon( "game_ended" );
    firstupgrade = perkpackage_getfirstfieldupgrade();
    secondupgrade = perkpackage_getsecondfieldupgrade();
    superref = undefined;
    shouldclear = istrue( level.var_8683bc01bfd2ecab );
    
    if ( istrue( self.super.staticdata.isweapon ) )
    {
        result = waittill_any_return_2( "super_use_finish", "weapon_change" );
        
        if ( result == "weapon_change" )
        {
            result = waittill_any_return_2( "super_use_finish", "weapon_change" );
            
            if ( result == "weapon_change" )
            {
                superref = self.super.staticdata.ref;
                clipammo = self.super.var_3d2b63c4e181029d;
                stockammo = self.super.var_b9ef26fa33686273;
                
                if ( isdefined( clipammo ) && isdefined( stockammo ) && ( clipammo >= 0 || stockammo >= 0 ) )
                {
                    var_1073d2b465f8a419 = getsuperid( firstupgrade );
                    self setclientomnvar( "ui_perk_package_super1", var_1073d2b465f8a419 );
                    var_41297be0f018b86d = getsuperid( secondupgrade );
                    self setclientomnvar( "ui_perk_package_super2", var_41297be0f018b86d );
                    
                    if ( !isdefined( self.perkpackagedata.weaponclipammo ) )
                    {
                        self.perkpackagedata.weaponclipammo = [];
                    }
                    
                    if ( !isdefined( self.perkpackagedata.weaponstockammo ) )
                    {
                        self.perkpackagedata.weaponstockammo = [];
                    }
                    
                    self.perkpackagedata.weaponclipammo[ superref ] = clipammo;
                    self.perkpackagedata.weaponstockammo[ superref ] = stockammo;
                    thread function_11ce7a07b4915a2c();
                    function_fbff879439b14d48();
                    perkpackage_setstate( 1 );
                    setsuperbasepoints( 500 );
                    return;
                }
                else if ( superref == firstupgrade )
                {
                    superref = secondupgrade;
                }
                else
                {
                    superref = firstupgrade;
                }
            }
        }
    }
    else if ( !istrue( skipwait ) )
    {
        self waittill( "super_use_finished" );
    }
    
    if ( !isdefined( var_e97e441ec7933198 ) )
    {
        var_e97e441ec7933198 = self.super.staticdata.ref;
    }
    
    if ( function_1b9785c7d0d6fbf6( var_e97e441ec7933198 ) || function_186c487ecca6691e( var_e97e441ec7933198 ) )
    {
        if ( !istrue( self.perkpackagedata.var_cd8b7b499020de46[ var_e97e441ec7933198 ] ) )
        {
            self.perkpackagedata.var_cd8b7b499020de46[ var_e97e441ec7933198 ] = 1;
            thread function_24ed4a94cf4e2c41();
            thread function_1549f72dc5076065( var_e97e441ec7933198 );
            wait 1;
            function_fbff879439b14d48();
            perkpackage_setstate( 1 );
            setsuperbasepoints( 500 );
            return;
        }
    }
    
    if ( !isdefined( superref ) && self.perkpackagedata.state == 3 )
    {
        superref = secondupgrade;
    }
    else if ( !isdefined( superref ) && self.perkpackagedata.state == 4 )
    {
        superref = firstupgrade;
    }
    
    if ( isdefined( self.perkpackagedata ) )
    {
        self.perkpackagedata.istwomode = 0;
        
        if ( isdefined( self.perkpackagedata.weaponclipammo ) && isdefined( self.perkpackagedata.weaponclipammo[ superref ] ) && isdefined( self.perkpackagedata.weaponstockammo ) && isdefined( self.perkpackagedata.weaponstockammo[ superref ] ) )
        {
            self.perkpackagedata.var_81448b01a79ab31f = 1;
            thread function_24ed4a94cf4e2c41();
        }
    }
    
    if ( function_1b9785c7d0d6fbf6( superref ) || function_186c487ecca6691e( superref ) )
    {
        if ( isdefined( self.perkpackagedata.var_cd8b7b499020de46 ) && istrue( self.perkpackagedata.var_cd8b7b499020de46[ superref ] ) )
        {
            shouldclear = 1;
        }
    }
    
    if ( isdefined( superref ) )
    {
        if ( shouldclear )
        {
            function_fbff879439b14d48();
            perkpackage_setstate( 1 );
            return;
        }
        
        perkpackage_giveimmediate( superref );
        self.var_3a4fe3013eb35ea0 = 0;
    }
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x1893
// Size: 0xf3
function function_11ce7a07b4915a2c()
{
    self notify( "reset_super_ammo_tracking" );
    level endon( "game_ended" );
    self endon( "reset_super_ammo_tracking" );
    result = waittill_any_return_2( "super_use_finish", "death" );
    
    if ( result == "death" )
    {
        self.perkpackagedata.weaponclipammo = undefined;
        self.perkpackagedata.weaponstockammo = undefined;
        return;
    }
    
    superref = self.super.staticdata.ref;
    self.perkpackagedata.weaponclipammo[ superref ] = undefined;
    self.perkpackagedata.weaponstockammo[ superref ] = undefined;
    
    if ( self.perkpackagedata.weaponclipammo.size > 0 || self.perkpackagedata.weaponstockammo.size > 0 )
    {
        thread function_11ce7a07b4915a2c();
    }
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x198e
// Size: 0x46
function function_24ed4a94cf4e2c41()
{
    self notify( "perkPackage_monitorDeath" );
    level endon( "game_ended" );
    self endon( "perkPackage_monitorDeath" );
    self waittill( "death" );
    self.perkpackagedata.var_cd8b7b499020de46 = undefined;
    self.perkpackagedata.var_81448b01a79ab31f = undefined;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 1
// Checksum 0x0, Offset: 0x19dc
// Size: 0x108
function function_1549f72dc5076065( superref )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "super_use_finished" );
    
    if ( superref == "super_deployed_decoy" )
    {
        ent = undefined;
        
        foreach ( decoy in self.var_7f0ad61b396c9477 )
        {
            ent = decoy;
        }
        
        ent waittill( "detonateExplosive" );
    }
    else if ( superref == "super_tac_camera" )
    {
        self waittill( "camera_destroyed" );
    }
    else
    {
        return;
    }
    
    firstupgrade = perkpackage_getfirstfieldupgrade();
    secondupgrade = perkpackage_getsecondfieldupgrade();
    
    if ( superref == firstupgrade )
    {
        self.perkpackagedata.state = 3;
    }
    else
    {
        self.perkpackagedata.state = 4;
    }
    
    function_6f2fc81c6517f7f0( superref, 1 );
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x1aec
// Size: 0x152, Type: bool
function function_3f7b66d60199a6a6()
{
    if ( istrue( self.perkpackagedata.istwomode ) || istrue( self.perkpackagedata.var_81448b01a79ab31f ) )
    {
        superinfo = getcurrentsuper();
        
        if ( isdefined( level.gamemodebundle ) && istrue( level.gamemodebundle.var_e12ed09bf2e43167 ) && isdefined( superinfo ) && isdefined( superinfo.staticdata ) && isdefined( superinfo.staticdata.ref ) && isdefined( self.perkpackagedata.weaponclipammo ) && isdefined( self.perkpackagedata.weaponclipammo[ superinfo.staticdata.ref ] ) && isdefined( self.perkpackagedata.weaponstockammo ) && isdefined( self.perkpackagedata.weaponstockammo[ superinfo.staticdata.ref ] ) )
        {
            if ( istrue( self.perkpackagedata.var_81448b01a79ab31f ) )
            {
                self.perkpackagedata.var_81448b01a79ab31f = undefined;
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 1
// Checksum 0x0, Offset: 0x1c47
// Size: 0x32, Type: bool
function function_1b9785c7d0d6fbf6( superref )
{
    switch ( superref )
    {
        case #"hash_d2e07f72a95c89d0":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 1
// Checksum 0x0, Offset: 0x1c82
// Size: 0x32, Type: bool
function function_186c487ecca6691e( superref )
{
    switch ( superref )
    {
        case #"hash_2a2d382fc09b9c1b":
            return true;
        default:
            return false;
    }
    
    return false;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 1
// Checksum 0x0, Offset: 0x1cbd
// Size: 0x4e
function function_7d4c7bff8926c0fd( superref )
{
    msg = undefined;
    
    switch ( superref )
    {
        case #"hash_d2e07f72a95c89d0":
            msg = "activateDecoy";
            break;
        case #"hash_2a2d382fc09b9c1b":
            msg = "activateCamera";
            break;
    }
    
    return msg;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x1d14
// Size: 0xf0
function perkpackage_forceusesuper()
{
    thread perkpackage_waitforsuperfinish();
    superref = getcurrentsuperref();
    
    if ( !isdefined( superref ) )
    {
        return 0;
    }
    
    superweapon = level.superglobals.staticsuperdata[ superref ].weapon;
    
    if ( !isdefined( superweapon ) )
    {
        return 0;
    }
    
    var_354f8655b711b4b1 = makeweapon( superweapon );
    thread perkpackagemenu_disableoffhanduse( 0.3 );
    iscanceled = 0;
    
    if ( "super_default_mp" != superweapon )
    {
        iscanceled = !istrue( scripts\mp\supers::function_c1c41a5273f29351( var_354f8655b711b4b1 ) );
    }
    
    if ( iscanceled )
    {
        result = 0;
    }
    else
    {
        result = trysuperusebegin( var_354f8655b711b4b1 );
    }
    
    if ( !istrue( result ) )
    {
        perkpackage_setstate( 1 );
        self.perkpackagedata.super = "super_select";
        givesuper( self.perkpackagedata.super, 0, 1 );
    }
    
    return result;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x1e0d
// Size: 0x46
function perkpackage_waitforsuperfinish()
{
    self endon( "disconnect" );
    self.perkpackagedata.isusing = 1;
    msg = perkpackage_waitforsuperfinishinternal();
    self.perkpackagedata.isusing = 0;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x1e5b
// Size: 0x22
function perkpackage_waitforsuperfinishinternal()
{
    level endon( "game_ended" );
    self endon( "giveLoadout_start" );
    self endon( "perkPackage_failed_super" );
    return waittill_any_return_1( "super_use_finished" );
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 1
// Checksum 0x0, Offset: 0x1e86
// Size: 0xa2
function perkpackage_waitforsupercanceled( superweapon )
{
    self endon( "offhand_fired" );
    superoffhand = undefined;
    starttime = gettime();
    
    while ( true )
    {
        offhand = self getheldoffhand();
        
        if ( isdefined( offhand ) && offhand == superweapon )
        {
            superoffhand = offhand;
            break;
        }
        
        endtime = gettime();
        
        if ( endtime - starttime > 400 )
        {
            return 1;
        }
        
        wait 0.05;
    }
    
    while ( true )
    {
        offhand = self getheldoffhand();
        
        if ( !isdefined( offhand ) || offhand != superoffhand )
        {
            return 1;
        }
        
        wait 0.05;
    }
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 1
// Checksum 0x0, Offset: 0x1f30
// Size: 0x52
function perkpackagemenu_disableoffhanduse( duration )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "giveLoadout_start" );
    val::set( "field_upgrade_pro", "offhand_primary_weapons", 0 );
    val::set( "field_upgrade_pro", "offhand_secondary_weapons", 0 );
    wait duration;
    val::reset_all( "field_upgrade_pro" );
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 2
// Checksum 0x0, Offset: 0x1f8a
// Size: 0x1e
function perkpackage_givedebug( superref, blueprintindex )
{
    perkpackage_giveimmediate( superref, undefined, undefined, blueprintindex );
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 5
// Checksum 0x0, Offset: 0x1fb0
// Size: 0xdd
function perkpackage_giveimmediate( superref, var_804a4a862146eb04, var_deb9b17bae00526e, blueprintindex, immediate )
{
    if ( !isdefined( immediate ) )
    {
        immediate = 1;
    }
    
    perkpackage_initpersdata();
    self.perkpackagedata.istwomode = 0;
    scripts\mp\supers::function_e78f07efbcdb9e97();
    self.perkpackagedata.super = superref;
    
    if ( superref == "super_select" )
    {
        if ( !isdefined( var_804a4a862146eb04 ) )
        {
            var_804a4a862146eb04 = "super_deployed_decoy";
        }
        
        if ( !isdefined( var_deb9b17bae00526e ) )
        {
            var_deb9b17bae00526e = "super_tac_camera";
        }
        
        self.perkpackagedata.istwomode = 1;
        function_c9491df86b072612();
        perkpackage_giveoverridefieldupgrades( var_804a4a862146eb04, var_deb9b17bae00526e );
        return;
    }
    
    perkpackage_giveoverridefieldupgrades( superref );
    givesuper( self.perkpackagedata.super, 0, immediate, blueprintindex );
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 2
// Checksum 0x0, Offset: 0x2095
// Size: 0x46
function perkpackage_giveoverridefieldupgrades( fieldupgrade1, fieldupgrade2 )
{
    if ( !isdefined( fieldupgrade1 ) )
    {
        fieldupgrade1 = "none";
    }
    
    if ( !isdefined( fieldupgrade2 ) )
    {
        fieldupgrade2 = "none";
    }
    
    self.overridefieldupgrade1 = fieldupgrade1;
    self.overridefieldupgrade2 = fieldupgrade2;
    perkpackage_updateifchanged();
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x20e3
// Size: 0x16
function perkpackage_resetoverridefieldupgrades()
{
    self.overridefieldupgrade1 = undefined;
    self.overridefieldupgrade2 = undefined;
}

// Namespace perkpackage / scripts\mp\perks\perkpackage
// Params 0
// Checksum 0x0, Offset: 0x2101
// Size: 0x1f
function perkpackage_reset()
{
    self.perkpackagedata.forcereset = 1;
    perkpackage_updateifchanged();
}

