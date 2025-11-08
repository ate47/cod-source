#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_hostmigration;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_hud_util;
#using scripts\cp\cp_outline;
#using scripts\cp\events;
#using scripts\cp\perks;
#using scripts\cp\points;
#using scripts\cp\utility;
#using scripts\cp\utility\entity;
#using scripts\cp\utility\game_utility_cp;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace super_suppression_rounds;

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x2fb
// Size: 0x18
function autoexec main()
{
    registersharedfunc( "super_suppression_rounds", "init", &function_d0930f871341093c );
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0x31b
// Size: 0x172
function function_d0930f871341093c()
{
    var_aee839913f5ebb26 = 0;
    var_1a9e0bb5dfd8fcdd = 0;
    
    foreach ( sub in level.onweapondropcreated.subscriptions )
    {
        if ( sub.callback == &function_7286321e2d43ff09 )
        {
            if ( isdefined( sub.target ) && sub.target == level )
            {
                var_aee839913f5ebb26 = 1;
            }
        }
    }
    
    foreach ( sub in level.onweapondroppickedup.subscriptions )
    {
        if ( sub.callback == &function_1eac70807c2aa8f8 )
        {
            if ( isdefined( sub.target ) && sub.target == level )
            {
                var_1a9e0bb5dfd8fcdd = 1;
            }
        }
    }
    
    if ( !var_aee839913f5ebb26 )
    {
        level.onweapondropcreated callback_subscribe( &function_7286321e2d43ff09, level );
    }
    
    if ( !var_1a9e0bb5dfd8fcdd )
    {
        level.onweapondroppickedup callback_subscribe( &function_1eac70807c2aa8f8, level );
    }
    
    registersharedfunc( "super_suppression_rounds", "suppressionRounds_beginUse", &suppressionrounds_beginuse );
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0x495
// Size: 0x13f, Type: bool
function suppressionrounds_beginuse()
{
    playerweaponobj = self.lastnormalweaponobj;
    var_8de014639f689574 = nullweapon();
    
    if ( scripts\cp\weapon::ismeleeonly( playerweaponobj ) || scripts\cp\utility::issuperweapon( playerweaponobj ) || scripts\cp_mp\weapon::iskillstreakweapon( playerweaponobj ) || scripts\cp\weapon::issinglehitweapon( playerweaponobj.basename ) || !function_a364b6e4dc3cc30a( playerweaponobj ) || playerweaponobj.basename == "iw8_lm_dblmg_mp" || playerweaponobj.basename == "iw9_me_fists_mp" )
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
    
    function_ed3c1a651b014773( playerweaponobj );
    
    /#
        setdevdvarifuninitialized( @"hash_cf7e828b80157a7e", 0 );
        setdevdvarifuninitialized( @"hash_e99f272dcc64b03c", "<dev string:x1c>" );
        setdevdvarifuninitialized( @"hash_c3573be192cb700f", 0.7 );
    #/
    
    scripts\cp_mp\challenges::function_d997435895422ecc( "super_suppression_rounds", function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"use" ) );
    return true;
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0x5dd
// Size: 0x18, Type: bool
function stoppingpower_cancelreload()
{
    self endon( "death_or_disconnect" );
    self cancelreload();
    wait 0.05;
    return true;
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0x5fe
// Size: 0x2
function function_b2d2056ee8b00689()
{
    
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 1
// Checksum 0x0, Offset: 0x608
// Size: 0x36
function function_a364b6e4dc3cc30a( objweapon )
{
    if ( !self isalternatemode( objweapon ) )
    {
        return 1;
    }
    
    underbarrel = objweapon.underbarrel;
    return scripts\cp\weapon::isattachmentselectfire( objweapon, underbarrel );
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 1
// Checksum 0x0, Offset: 0x647
// Size: 0x294, Type: bool
function function_ed3c1a651b014773( playerweaponobj )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
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
    
    if ( !isdefined( self.var_96a36c88eb0e59b ) )
    {
        self.var_96a36c88eb0e59b = [ "specialty_bulletsuppress", "specialty_bulletpenetration", "specialty_armorpiercingks", "specialty_fastreload" ];
    }
    
    foreach ( weaponobj in var_12a372e8caa042bb )
    {
        isakimbo = 0;
        
        if ( weaponobj.isdualwield )
        {
            isakimbo = 1;
        }
        
        if ( issameweapon( weaponobj, playerweaponobj, 0 ) )
        {
            clipammo = scripts\cp\weapon::getammooverride( weaponobj );
            var_fb3893b4cbddc190 = clipammo * 2;
            
            if ( isakimbo )
            {
                var_fb3893b4cbddc190 *= 2;
            }
            
            function_588eaa2556c4172c( self, weaponobj, var_fb3893b4cbddc190 );
            
            if ( true )
            {
                if ( isakimbo )
                {
                    clipammo = self getweaponammoclip( weaponobj, "left" ) + self getweaponammoclip( weaponobj, "right" );
                    stockammo = self getweaponammostock( weaponobj );
                    oldammo = clipammo + stockammo;
                    newammo = int( min( weaponmaxammo( weaponobj ), oldammo + var_fb3893b4cbddc190 ) );
                    self setweaponammostock( weaponobj, newammo );
                    self setweaponammoclip( weaponobj, 0, "left" );
                    self setweaponammoclip( weaponobj, 0, "right" );
                    continue;
                }
                
                clipammo = self getweaponammoclip( weaponobj );
                stockammo = self getweaponammostock( weaponobj );
                oldammo = clipammo + stockammo;
                maxammo = weaponmaxammo( weaponobj );
                totalammo = oldammo + var_fb3893b4cbddc190;
                var_c88113bfedd68cf0 = int( totalammo - maxammo );
                newstockammo = int( min( maxammo, totalammo ) );
                
                if ( weaponobj.basename == "iw8_lm_dblmg_mp" )
                {
                    self setweaponammoclip( weaponobj, clipammo + var_fb3893b4cbddc190 );
                    continue;
                }
                
                self setweaponammoclip( weaponobj, 0 );
                self setweaponammostock( weaponobj, newstockammo );
            }
        }
    }
    
    thread function_3c8a31ca9d26e8a3( playerweaponobj, stockammo, var_c88113bfedd68cf0 );
    return true;
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 3
// Checksum 0x0, Offset: 0x8e4
// Size: 0xa1
function function_3c8a31ca9d26e8a3( weaponobj, stockammo, var_c88113bfedd68cf0 )
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
            thread scripts\cp\cp_hud_message::showsplash( "suppression_rounds_activated", undefined, self );
            
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

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 3
// Checksum 0x0, Offset: 0x98d
// Size: 0x75
function function_588eaa2556c4172c( player, objweapon, numrounds )
{
    var_2468893fc27de6f6 = spawnstruct();
    var_2468893fc27de6f6.player = player;
    var_2468893fc27de6f6.objweapon = objweapon;
    var_2468893fc27de6f6.rounds = numrounds;
    var_2468893fc27de6f6.var_6d8006af92216f09 = 0;
    var_2468893fc27de6f6.kills = 0;
    function_404622faff469ef4( player, var_2468893fc27de6f6 );
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0xa0a
// Size: 0x5f
function function_2ab57ffd17e456dc()
{
    perkarray = self.var_96a36c88eb0e59b;
    
    foreach ( perk in perkarray )
    {
        giveperk( perk );
    }
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0xa71
// Size: 0x69
function function_d086a58c4a276ab7()
{
    perkarray = self.var_96a36c88eb0e59b;
    
    foreach ( perk in perkarray )
    {
        if ( _hasperk( perk ) )
        {
            removeperk( perk );
        }
    }
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0xae2
// Size: 0x7c
function function_78a297c602bcf14b()
{
    perkarray = self.var_96a36c88eb0e59b;
    
    if ( !isdefined( perkarray ) )
    {
        return 0;
    }
    
    var_c81d87c234523f81 = 1;
    
    foreach ( perk in perkarray )
    {
        if ( !_hasperk( perk ) )
        {
            var_c81d87c234523f81 = 0;
            break;
        }
    }
    
    return var_c81d87c234523f81;
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 2
// Checksum 0x0, Offset: 0xb67
// Size: 0xb6
function function_404622faff469ef4( player, var_2468893fc27de6f6 )
{
    if ( !isdefined( player.var_2468893fc27de6f6 ) )
    {
        player.var_2468893fc27de6f6 = [];
    }
    
    id = getcompleteweaponnamenoalt( var_2468893fc27de6f6.objweapon );
    var_42d837d1bf3797d3 = player.var_2468893fc27de6f6[ id ];
    
    if ( isdefined( var_42d837d1bf3797d3 ) )
    {
        var_42d837d1bf3797d3 thread suppressionrounds_removeapr();
    }
    
    player.var_2468893fc27de6f6[ id ] = var_2468893fc27de6f6;
    var_2468893fc27de6f6 thread function_ff064ef6be86cafd();
    var_2468893fc27de6f6 thread function_b62388feecc84e15();
    var_2468893fc27de6f6 thread function_3228d2697dab3222();
    var_2468893fc27de6f6 thread function_6831e37d3d71c426();
    var_2468893fc27de6f6 thread function_f12640f75796066();
    player thread function_1a941c69ee952e0d();
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0xc25
// Size: 0x2b, Type: bool
function function_1da49fb6441f8ab2()
{
    var_2468893fc27de6f6 = function_8343403d68c45f63( self getcurrentweapon() );
    return isdefined( var_2468893fc27de6f6 ) && istrue( var_2468893fc27de6f6.var_6d8006af92216f09 );
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 3
// Checksum 0x0, Offset: 0xc59
// Size: 0x48
function function_7286321e2d43ff09( weaponentity, droppingplayer, weaponobj )
{
    if ( !isdefined( weaponentity ) || !isdefined( droppingplayer ) )
    {
        return;
    }
    
    var_2468893fc27de6f6 = droppingplayer function_8343403d68c45f63( weaponobj );
    weaponentity.var_2468893fc27de6f6 = var_2468893fc27de6f6;
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 3
// Checksum 0x0, Offset: 0xca9
// Size: 0x71
function function_1eac70807c2aa8f8( weaponentity, var_480f8576be141bb4, weaponobj )
{
    if ( !isdefined( weaponentity.var_2468893fc27de6f6 ) )
    {
        return;
    }
    
    var_2468893fc27de6f6 = weaponentity.var_2468893fc27de6f6;
    var_2468893fc27de6f6.player = var_480f8576be141bb4;
    var_2468893fc27de6f6.var_6d8006af92216f09 = 0;
    var_2468893fc27de6f6.kills = 0;
    function_404622faff469ef4( var_480f8576be141bb4, var_2468893fc27de6f6 );
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 1
// Checksum 0x0, Offset: 0xd22
// Size: 0x3e
function function_8343403d68c45f63( objweapon )
{
    if ( !isdefined( objweapon ) )
    {
        return undefined;
    }
    
    if ( !isdefined( self.var_2468893fc27de6f6 ) )
    {
        return undefined;
    }
    
    id = getcompleteweaponnamenoalt( objweapon );
    return self.var_2468893fc27de6f6[ id ];
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0xd69
// Size: 0xb4
function function_6831e37d3d71c426()
{
    self endon( "suppressionRounds_removeAPR" );
    self.player endon( "disconnect" );
    
    while ( self.player hasweapon( self.objweapon ) )
    {
        if ( function_8e06333f166199e3( self.player getcurrentweapon() ) )
        {
            if ( !self.var_6d8006af92216f09 )
            {
                self.player function_2ab57ffd17e456dc();
                self.var_6d8006af92216f09 = 1;
            }
        }
        else if ( self.var_6d8006af92216f09 )
        {
            self.player function_d086a58c4a276ab7();
            self.var_6d8006af92216f09 = 0;
        }
        
        self.player waittill( "weapon_change" );
    }
    
    thread suppressionrounds_removeapr();
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0xe25
// Size: 0x97
function function_f12640f75796066()
{
    self endon( "suppressionRounds_removeAPR" );
    self.player endon( "disconnect" );
    
    while ( self.player hasweapon( self.objweapon ) )
    {
        self.player waittill( "weapon_fired", objweapon );
        
        if ( function_8e06333f166199e3( objweapon ) )
        {
            self.rounds--;
            
            if ( self.rounds <= 0 )
            {
                break;
            }
        }
    }
    
    self.player thread function_15338821a605345d( self.objweapon );
    thread suppressionrounds_removeapr();
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 1
// Checksum 0x0, Offset: 0xec4
// Size: 0x5d
function function_15338821a605345d( objweapon )
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

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0xf29
// Size: 0x3a
function suppressionrounds_removeapr()
{
    self notify( "suppressionRounds_removeAPR" );
    
    if ( isdefined( self.player ) )
    {
        if ( self.var_6d8006af92216f09 )
        {
            self.player function_d086a58c4a276ab7();
        }
        
        function_14ff80858876e74();
    }
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0xf6b
// Size: 0x1e
function function_860d63c693c454f5()
{
    self notify( "suppressionRounds_removeAPR" );
    
    if ( isdefined( self.player ) )
    {
        function_14ff80858876e74();
    }
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0xf91
// Size: 0x114
function function_14ff80858876e74()
{
    if ( isdefined( self.player.var_2468893fc27de6f6 ) )
    {
        id = getcompleteweaponnamenoalt( self.objweapon );
        var_2468893fc27de6f6 = self.player.var_2468893fc27de6f6[ id ];
        
        if ( isdefined( var_2468893fc27de6f6 ) && var_2468893fc27de6f6 == self )
        {
            self.player.var_2468893fc27de6f6[ id ] = undefined;
        }
        
        if ( isdefined( self.player.super ) && isdefined( self.player.super.vehiclehitcount ) )
        {
            self.player scripts\cp_mp\challenges::function_d997435895422ecc( "super_suppression_rounds", function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"end" ), self.player.super.vehiclehitcount );
            self.player.super.vehiclehitcount = undefined;
        }
    }
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 1
// Checksum 0x0, Offset: 0x10ad
// Size: 0x57
function function_8f9a9c04e9e4b5af( weaponobj )
{
    if ( isdefined( weaponobj ) )
    {
        id = getcompleteweaponnamenoalt( weaponobj );
        var_2468893fc27de6f6 = self.var_2468893fc27de6f6[ id ];
        
        if ( isdefined( var_2468893fc27de6f6 ) )
        {
            scripts\cp\events::incpersstat( "suppressionRoundsKills", 1 );
            var_2468893fc27de6f6.kills++;
        }
    }
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 1
// Checksum 0x0, Offset: 0x110c
// Size: 0x6b, Type: bool
function function_8e06333f166199e3( objweapon )
{
    var_c1711fe638727118 = self.player getammotype( self.objweapon );
    currentammotype = self.player getammotype( objweapon );
    var_9438d6b1d63250f7 = var_c1711fe638727118 == currentammotype;
    return issameweapon( objweapon, self.objweapon, 1 ) && var_9438d6b1d63250f7;
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0x1180
// Size: 0x30
function function_ff064ef6be86cafd()
{
    self.player endon( "disconnect" );
    self endon( "suppressionRounds_removeAPR" );
    self.player waittill( "death" );
    thread suppressionrounds_removeapr();
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0x11b8
// Size: 0x28
function function_b62388feecc84e15()
{
    self.player endon( "disconnect" );
    self endon( "suppressionRounds_removeAPR" );
    level waittill( "game_ended" );
    thread suppressionrounds_removeapr();
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0x11e8
// Size: 0x30
function function_3228d2697dab3222()
{
    self.player endon( "disconnect" );
    self endon( "suppressionRounds_removeAPR" );
    self.player waittill( "all_perks_cleared" );
    thread function_860d63c693c454f5();
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0x1220
// Size: 0x5a
function function_8f57fb80f166c568()
{
    self.player endon( "death_or_disconnect" );
    self.player scripts\cp\utility::giveperk( "specialty_fastreload" );
    self.player waittill_any_3( "weapon_fired", "weapon_change", "suppressionRounds_removeAPR" );
    self.player scripts\cp\utility::takeperk( "specialty_fastreload" );
}

// Namespace super_suppression_rounds / scripts\cp\super_suppression_rounds
// Params 0
// Checksum 0x0, Offset: 0x1282
// Size: 0x2d
function function_1a941c69ee952e0d()
{
    self endon( "death_or_disconnect" );
    val::set( "suppressionRounds", "sprint", 0 );
    wait 0.4;
    val::reset_all( "suppressionRounds" );
}

