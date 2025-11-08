#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\supers;
#using scripts\mp\supers\super_stoppingpower;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace super_stoppingpower;

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 0
// Checksum 0x0, Offset: 0x314
// Size: 0x2e
function stoppingpower_init()
{
    level.onweapondropcreated callback_subscribe( &stoppingpower_onweaponcreated, level );
    level.onweapondroppickedup callback_subscribe( &stoppingpower_onweaponpickedup, level );
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 0
// Checksum 0x0, Offset: 0x34a
// Size: 0x33d, Type: bool
function stoppingpower_beginuse()
{
    playerweaponobj = self.lastnormalweaponobj;
    var_8de014639f689574 = nullweapon();
    
    if ( scripts\mp\utility\weapon::ismeleeonly( playerweaponobj ) || scripts\mp\utility\weapon::issuperweapon( playerweaponobj ) || scripts\cp_mp\weapon::iskillstreakweapon( playerweaponobj ) || scripts\mp\utility\weapon::isgamemodeweapon( playerweaponobj ) || scripts\mp\utility\weapon::issinglehitweapon( playerweaponobj.basename ) || !stoppingpower_isvalidprimaryoralt( playerweaponobj ) || playerweaponobj.basename == "iw8_lm_dblmg_mp" || playerweaponobj.basename == "iw9_me_fists_mp" )
    {
        if ( scripts\engine\utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
        {
            self [[ scripts\engine\utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "MP/SUPPORT_BOX_INCOMPAT" );
        }
        
        return false;
    }
    
    result = stoppingpower_cancelreload();
    
    if ( !istrue( result ) )
    {
        return false;
    }
    
    if ( self isalternatemode( playerweaponobj ) )
    {
        var_8de014639f689574 = playerweaponobj;
        playerweaponobj = playerweaponobj getnoaltweapon();
    }
    else
    {
        var_8de014639f689574 = playerweaponobj getaltweapon();
    }
    
    var_12a372e8caa042bb = [];
    stockammo = 0;
    var_c88113bfedd68cf0 = 0;
    
    if ( !isnullweapon( var_8de014639f689574 ) )
    {
        var_12a372e8caa042bb[ var_12a372e8caa042bb.size ] = var_8de014639f689574;
    }
    
    var_12a372e8caa042bb[ var_12a372e8caa042bb.size ] = playerweaponobj;
    
    foreach ( weaponobj in var_12a372e8caa042bb )
    {
        isakimbo = 0;
        
        if ( weaponobj.isdualwield )
        {
            isakimbo = 1;
        }
        
        if ( issameweapon( weaponobj, playerweaponobj, 0 ) )
        {
            clipammo = scripts\mp\weapons::getammooverride( weaponobj );
            var_971f8e0abbcafab8 = clipammo * 1;
            
            if ( isakimbo )
            {
                var_971f8e0abbcafab8 *= 2;
            }
            
            thread stoppingpower_givehcr( self, weaponobj, var_971f8e0abbcafab8 );
            
            if ( true )
            {
                if ( isakimbo )
                {
                    clipammo = self getweaponammoclip( weaponobj, "left" ) + self getweaponammoclip( weaponobj, "right" );
                    stockammo = self getweaponammostock( weaponobj );
                    oldammo = clipammo + stockammo;
                    newammo = int( min( weaponmaxammo( weaponobj ), oldammo + var_971f8e0abbcafab8 ) );
                    self setweaponammostock( weaponobj, newammo );
                    self setweaponammoclip( weaponobj, 0, "left" );
                    self setweaponammoclip( weaponobj, 0, "right" );
                    continue;
                }
                
                clipammo = self getweaponammoclip( weaponobj );
                stockammo = self getweaponammostock( weaponobj );
                oldammo = clipammo + stockammo;
                maxammo = weaponmaxammo( weaponobj );
                totalammo = oldammo + var_971f8e0abbcafab8;
                var_c88113bfedd68cf0 = int( totalammo - maxammo );
                newstockammo = int( min( maxammo, totalammo ) );
                
                if ( weaponobj.basename == "iw8_lm_dblmg_mp" )
                {
                    self setweaponammoclip( weaponobj, clipammo + var_971f8e0abbcafab8 );
                    continue;
                }
                
                self setweaponammoclip( weaponobj, 0 );
                
                if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
                {
                    stockdifference = newstockammo - stockammo;
                    scripts\mp\gametypes\br_weapons::br_give_weapon_ammo( weaponobj, stockdifference );
                    continue;
                }
                
                self setweaponammostock( weaponobj, newstockammo );
            }
        }
    }
    
    thread stoppingpower_waitforreload( playerweaponobj, stockammo, var_c88113bfedd68cf0 );
    return true;
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 1
// Checksum 0x0, Offset: 0x690
// Size: 0x37
function stoppingpower_isvalidprimaryoralt( objweapon )
{
    if ( !self isalternatemode( objweapon ) )
    {
        return 1;
    }
    
    underbarrel = objweapon.underbarrel;
    return scripts\mp\weapons::isattachmentselectfire( objweapon, underbarrel );
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 3
// Checksum 0x0, Offset: 0x6d0
// Size: 0xa0
function stoppingpower_waitforreload( weaponobj, stockammo, var_c88113bfedd68cf0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    while ( true )
    {
        if ( self getcurrentprimaryweapon() != weaponobj )
        {
            break;
        }
        
        currentammo = self getweaponammoclip( weaponobj );
        
        if ( currentammo > 0 )
        {
            thread scripts\mp\hud_message::showsplash( "stopping_power_loaded" );
            
            if ( var_c88113bfedd68cf0 > 0 )
            {
                self setweaponammostock( weaponobj, stockammo + var_c88113bfedd68cf0 );
            }
            
            break;
        }
        
        waitframe();
    }
    
    if ( scripts\engine\utility::issharedfuncdefined( "supers", "superUseFinished" ) )
    {
        [[ scripts\engine\utility::getsharedfunc( "supers", "superUseFinished" ) ]]();
    }
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 3
// Checksum 0x0, Offset: 0x778
// Size: 0x76
function stoppingpower_givehcr( player, objweapon, numrounds )
{
    hcrdata = spawnstruct();
    hcrdata.player = player;
    hcrdata.objweapon = objweapon;
    hcrdata.rounds = numrounds;
    hcrdata.gavehcr = 0;
    hcrdata.kills = 0;
    stoppingpower_givehcrdata( player, hcrdata );
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 2
// Checksum 0x0, Offset: 0x7f6
// Size: 0xbf
function stoppingpower_givehcrdata( player, hcrdata )
{
    if ( !isdefined( player.hcrdata ) )
    {
        player.hcrdata = [];
    }
    
    id = getcompleteweaponnamenoalt( hcrdata.objweapon );
    var_500df980161b0d67 = player.hcrdata[ id ];
    
    if ( isdefined( var_500df980161b0d67 ) )
    {
        var_500df980161b0d67 thread stoppingpower_removehcr();
    }
    
    player.hcrdata[ id ] = hcrdata;
    hcrdata thread stoppingpower_clearhcrondeath();
    hcrdata thread stoppingpower_clearhcrongameended();
    hcrdata thread stoppingpower_clearhcronperkscleared();
    hcrdata thread stoppingpower_givefastreload();
    player thread stoppingpower_breaksprint();
    hcrdata thread stoppingpower_watchhcrweaponchange();
    hcrdata thread stoppingpower_watchhcrweaponfire();
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 3
// Checksum 0x0, Offset: 0x8bd
// Size: 0x49
function stoppingpower_onweaponcreated( weaponentity, droppingplayer, weaponobj )
{
    if ( !isdefined( weaponentity ) || !isdefined( droppingplayer ) )
    {
        return;
    }
    
    hcrdata = droppingplayer scripts\mp\supers\super_stoppingpower::stoppingpower_getweaponhcrdata( weaponobj );
    weaponentity.hcrdata = hcrdata;
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 3
// Checksum 0x0, Offset: 0x90e
// Size: 0x72
function stoppingpower_onweaponpickedup( weaponentity, var_480f8576be141bb4, weaponobj )
{
    if ( !isdefined( weaponentity.hcrdata ) )
    {
        return;
    }
    
    hcrdata = weaponentity.hcrdata;
    hcrdata.player = var_480f8576be141bb4;
    hcrdata.gavehcr = 0;
    hcrdata.kills = 0;
    stoppingpower_givehcrdata( var_480f8576be141bb4, hcrdata );
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 1
// Checksum 0x0, Offset: 0x988
// Size: 0x3f
function stoppingpower_getweaponhcrdata( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        return undefined;
    }
    
    if ( !isdefined( self.hcrdata ) )
    {
        return undefined;
    }
    
    id = getcompleteweaponnamenoalt( objweapon );
    return self.hcrdata[ id ];
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 0
// Checksum 0x0, Offset: 0x9d0
// Size: 0x18, Type: bool
function stoppingpower_cancelreload()
{
    self endon( "death_or_disconnect" );
    self cancelreload();
    wait 0.05;
    return true;
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 0
// Checksum 0x0, Offset: 0x9f1
// Size: 0xbe
function stoppingpower_watchhcrweaponchange()
{
    self endon( "stoppingPower_removeHCR" );
    self.player endon( "disconnect" );
    
    while ( self.player hasweapon( self.objweapon ) )
    {
        if ( stoppingpower_ishcrweapon( self.player getcurrentweapon() ) )
        {
            if ( !self.gavehcr )
            {
                self.player scripts\mp\utility\perk::giveperk( "specialty_bulletdamage" );
                self.gavehcr = 1;
            }
        }
        else if ( self.gavehcr )
        {
            self.player scripts\mp\utility\perk::removeperk( "specialty_bulletdamage" );
            self.gavehcr = 0;
        }
        
        self.player waittill( "weapon_change" );
    }
    
    thread stoppingpower_removehcr();
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 0
// Checksum 0x0, Offset: 0xab7
// Size: 0x98
function stoppingpower_watchhcrweaponfire()
{
    self endon( "stoppingPower_removeHCR" );
    self.player endon( "disconnect" );
    
    while ( self.player hasweapon( self.objweapon ) )
    {
        self.player waittill( "weapon_fired", objweapon );
        
        if ( stoppingpower_ishcrweapon( objweapon ) )
        {
            self.rounds--;
            
            if ( self.rounds <= 0 )
            {
                break;
            }
        }
    }
    
    self.player thread stoppingpower_tracklastcrossbowshot( self.objweapon );
    thread stoppingpower_removehcr();
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 1
// Checksum 0x0, Offset: 0xb57
// Size: 0x5e
function stoppingpower_tracklastcrossbowshot( objweapon )
{
    self endon( "disconnect" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    rootname = getweaponrootname( objweapon );
    
    if ( rootname != "iw9_dm_crossbow" )
    {
        return;
    }
    
    self.lastcrossbowhadstoppingpower = 1;
    waittill_any_timeout_no_endon_death_2( 2, "weapon_fired", "weapon_change" );
    self.lastcrossbowhadstoppingpower = undefined;
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 0
// Checksum 0x0, Offset: 0xbbd
// Size: 0x3f
function stoppingpower_removehcr()
{
    self notify( "stoppingPower_removeHCR" );
    
    if ( isdefined( self.player ) )
    {
        if ( self.gavehcr )
        {
            self.player scripts\mp\utility\perk::removeperk( "specialty_bulletdamage" );
        }
        
        stoppingpower_clearhcrdata();
    }
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 0
// Checksum 0x0, Offset: 0xc04
// Size: 0x1e
function stoppingpower_loadoutchangeremovehcr()
{
    self notify( "stoppingPower_removeHCR" );
    
    if ( isdefined( self.player ) )
    {
        stoppingpower_clearhcrdata();
    }
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 0
// Checksum 0x0, Offset: 0xc2a
// Size: 0xab
function stoppingpower_clearhcrdata()
{
    if ( isdefined( self.player.hcrdata ) )
    {
        id = getcompleteweaponnamenoalt( self.objweapon );
        hcrdata = self.player.hcrdata[ id ];
        
        if ( hcrdata == self )
        {
            self.player.hcrdata[ id ] = undefined;
        }
        
        scripts\mp\analyticslog::logevent_fieldupgradeexpired( self.player, level.superglobals.staticsuperdata[ "super_support_box" ].id, self.kills, 0 );
    }
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 1
// Checksum 0x0, Offset: 0xcdd
// Size: 0x63
function stoppingpower_onkill( weaponobj )
{
    if ( isdefined( weaponobj ) )
    {
        id = getcompleteweaponnamenoalt( weaponobj );
        hcrdata = self.hcrdata[ id ];
        
        if ( isdefined( hcrdata ) )
        {
            scripts\mp\utility\stats::incpersstat( "stoppingPowerKills", 1 );
            scripts\mp\supers::combatrecordsuperkill( "super_support_box" );
            hcrdata.kills++;
        }
    }
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 1
// Checksum 0x0, Offset: 0xd48
// Size: 0x6a, Type: bool
function stoppingpower_ishcrweapon( objweapon )
{
    var_4de6bc49eaa87870 = self.player getammotype( self.objweapon );
    currentammotype = self.player getammotype( objweapon );
    var_9438d6b1d63250f7 = var_4de6bc49eaa87870 == currentammotype;
    return issameweapon( objweapon, self.objweapon, 1 ) && var_9438d6b1d63250f7;
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 0
// Checksum 0x0, Offset: 0xdbb
// Size: 0x30
function stoppingpower_clearhcrondeath()
{
    self.player endon( "disconnect" );
    self endon( "stoppingPower_removeHCR" );
    self.player waittill( "death" );
    thread stoppingpower_removehcr();
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 0
// Checksum 0x0, Offset: 0xdf3
// Size: 0x28
function stoppingpower_clearhcrongameended()
{
    self.player endon( "disconnect" );
    self endon( "stoppingPower_removeHCR" );
    level waittill( "game_ended" );
    thread stoppingpower_removehcr();
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 0
// Checksum 0x0, Offset: 0xe23
// Size: 0x30
function stoppingpower_clearhcronperkscleared()
{
    self.player endon( "disconnect" );
    self endon( "stoppingPower_removeHCR" );
    self.player waittill( "all_perks_cleared" );
    thread stoppingpower_loadoutchangeremovehcr();
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 0
// Checksum 0x0, Offset: 0xe5b
// Size: 0x5a
function stoppingpower_givefastreload()
{
    self.player endon( "death_or_disconnect" );
    self.player scripts\mp\utility\perk::giveperk( "specialty_fastreload" );
    self.player waittill_any_3( "weapon_fired", "weapon_change", "stoppingPower_removeHCR" );
    self.player scripts\mp\utility\perk::removeperk( "specialty_fastreload" );
}

// Namespace super_stoppingpower / scripts\mp\supers\super_stoppingpower
// Params 0
// Checksum 0x0, Offset: 0xebd
// Size: 0x2d
function stoppingpower_breaksprint()
{
    self endon( "death_or_disconnect" );
    val::set( "stoppingPower", "sprint", 0 );
    wait 0.4;
    val::reset_all( "stoppingPower" );
}

