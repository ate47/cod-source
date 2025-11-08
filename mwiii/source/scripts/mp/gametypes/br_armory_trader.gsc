#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\structspawnconfig;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\emp;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\trigger;
#using scripts\mp\utility\weapon;

#namespace br_armory_trader;

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x8b7
// Size: 0x14
function autoexec main()
{
    level scripts\common\callbacks::add( "br_functional_poi_init", &init );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1
// Checksum 0x0, Offset: 0x8d3
// Size: 0x2fd
function init( params )
{
    level.br_armory_trader = spawnstruct();
    level.br_armory_trader.scriptables = [];
    level.var_6254899bb2142d87 = getdvarint( @"scr_br_armory_trader", 0 ) != 0;
    
    if ( scripts\mp\gametypes\br_gametypes::isfeaturedisabled( "trader" ) || !function_8e0659b7f9568144() )
    {
        level.var_6254899bb2142d87 = 0;
    }
    
    if ( !level.var_6254899bb2142d87 )
    {
        return;
    }
    
    scripts\mp\flags::function_1240434f4201ac9d( "ssc_initialized" );
    scripts\cp_mp\structspawnconfig::function_4f7660cfd85cd517( "armory_trader", &function_e6c1c35181a2870f );
    scripts\cp_mp\structspawnconfig::function_412f527ef0863f0e( "armory_trader", &function_1b62e2e65b9db442 );
    scripts\cp_mp\structspawnconfig::function_eded5b87f8f7bdfd( "armory_trader", &function_11554a45a6bd9bb6 );
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "br_armory_trader", &function_c0972a3a09a99ab6 );
    val::group_register( "TraderUse", [ "offhand_weapons", "fire", "melee", "weapon_switch", "killstreaks", "supers" ] );
    level.br_armory_trader.var_d8dd94861da28afe = strtok( getdvar( @"hash_a077a83ead32f0c2", "" ), "|" );
    level.br_armory_trader.loadoutsdata = spawnstruct();
    level.br_armory_trader.loadoutsdata.var_86cf42936c944bc3 = getdvarint( @"hash_292c8fcc9a35b611", 32 );
    level.br_armory_trader.loadoutsdata.var_313f4e143d833b53 = 0;
    level.br_armory_trader.loadoutsdata.var_640f6b2398c23377 = getdvarfloat( @"hash_3f2463516c3c4dde", 0.1 );
    level.br_armory_trader.var_6bc61e1f4afa3ff3 = getdvarint( @"hash_2daf2c6312e91b06", 0 );
    level.br_armory_trader.var_da1e0a23728ec36 = getdvarint( @"hash_aea858d7e28d6927", 138 );
    level.br_armory_trader.var_ee776d8d5e3b9e73 = getdvarint( @"hash_ca9c6ca232a34f7e", 0 ) > 0;
    level.br_armory_trader.pickupgrid = spawnstruct();
    level.br_armory_trader.pickupgrid.diameter = getdvarfloat( @"hash_dc652c49d7d25622", 55 );
    level.br_armory_trader.var_bd3e92971cb005fa = getdvarint( @"hash_26a339f3c38f1c1b", 1 );
    level scripts\common\callbacks::add( "br_functional_poi_on_prematch_done", &onprematchdone );
    function_d09a84cdbf4fcdab();
    initscriptbundle();
    thread watchgameended();
    scripts\mp\gametypes\br_circle::registercirclecallbacks( 5, &dangercircletick, &function_1a1709943670772a, &function_83c65466cc2272dd, &function_f58f16a632b7409d );
    
    /#
        scripts\mp\gametypes\br_dev::registerhandlecommand( &function_e67e79bba620a62e );
    #/
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xbd8
// Size: 0xa9
function private function_d09a84cdbf4fcdab()
{
    dvarvalue = getdvar( @"hash_a077a83ead32f0c2", "undefined_default" );
    logstring( "br_armory_trader scr_br_armory_trader_filter value is: " + dvarvalue );
    var_297d6cbb50675600 = "";
    
    foreach ( item in level.br_armory_trader.var_d8dd94861da28afe )
    {
        var_297d6cbb50675600 += item + " ";
    }
    
    logstring( "br_armory_trader level.br_armory_trader.filteredItems value is: " + var_297d6cbb50675600 );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xc89
// Size: 0x6d
function private initscriptbundle()
{
    var_df433e8b91d06e83 = getdvar( @"hash_f2e5f0af7e8689f3", "armory_trader_default" );
    level.br_armory_trader.scriptbundle = getscriptbundle( hashcat( %"hash_7a7811456f8710f2", var_df433e8b91d06e83 ) );
    assertex( isdefined( level.br_armory_trader.scriptbundle ), "<dev string:x1c>" + var_df433e8b91d06e83 );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xcfe
// Size: 0x3f
function private function_3953d88977707504()
{
    /#
        debugrandom = getdvarint( @"hash_7e0bd596e5457588", -1 );
        
        if ( debugrandom >= 0 )
        {
            return debugrandom;
        }
    #/
    
    return randomint( getdvarint( @"hash_4d0b67aba31efb57", 32767 ) );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xd46
// Size: 0xa7
function private function_707d6cfaa04dbe98( position )
{
    mindistancesquared = undefined;
    closestinstance = undefined;
    
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        distancesquared = distance2dsquared( armorytrader.origin, position );
        
        if ( !isdefined( mindistancesquared ) || distancesquared < mindistancesquared )
        {
            mindistancesquared = distancesquared;
            closestinstance = armorytrader;
        }
    }
    
    return closestinstance;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1
// Checksum 0x0, Offset: 0xdf6
// Size: 0x6e
function onprematchdone( params )
{
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        if ( isdefined( armorytrader ) )
        {
            function_83c65466cc2272dd( armorytrader );
        }
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xe6c
// Size: 0x77
function private watchgameended()
{
    level waittill( "game_ended" );
    
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        if ( isdefined( armorytrader.visible ) )
        {
            function_807bb1d3855dea79( armorytrader );
        }
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xeeb
// Size: 0x53
function private function_7f17056284fe39db()
{
    trigger = spawn( "noent_volume_trigger_radius", self.origin, 0, 500, 500 );
    trigger.playersintrigger = [];
    trigger thread watchtriggerenter( self );
    trigger thread watchtriggerexit( self );
    self.proximitytrigger = trigger;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xf46
// Size: 0x1f
function private function_48607351aa7c7174()
{
    if ( isdefined( self.proximitytrigger ) )
    {
        self.proximitytrigger destroytrigger();
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xf6d
// Size: 0x88
function private watchtriggerenter( weapontrader )
{
    self endon( "death" );
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !player scripts\cp_mp\utility\player_utility::_isalive() )
        {
            continue;
        }
        
        playerentitynumber = player getentitynumber();
        
        if ( isdefined( self.playersintrigger[ playerentitynumber ] ) )
        {
            continue;
        }
        
        self.playersintrigger[ playerentitynumber ] = player;
        player thread onentertrigger( self, weapontrader );
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xffd
// Size: 0xa0
function private watchtriggerexit( weapontrader )
{
    self endon( "death" );
    level endon( "game_ended" );
    
    while ( true )
    {
        foreach ( playerentitynumber, player in self.playersintrigger )
        {
            if ( isdefined( player ) && player scripts\cp_mp\utility\player_utility::_isalive() && player istouching( self ) )
            {
                continue;
            }
            
            self.playersintrigger[ playerentitynumber ] = undefined;
            onexittrigger( player, weapontrader );
        }
        
        waitframe();
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x10a5
// Size: 0x9
function private destroytrigger()
{
    self delete();
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x10b6
// Size: 0x1c
function private onentertrigger( trigger, weapontrader )
{
    thread monitorweaponchange( weapontrader );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x10da
// Size: 0x2d
function private onexittrigger( player, weapontrader )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player notify( "weapon_trader_trigger_exited_" + weapontrader.index );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x110f
// Size: 0x8b
function private monitorweaponchange( weapontrader )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "weapon_trader_trigger_exited_" + weapontrader.index );
    newweapon = scripts\mp\gametypes\br_weapons::function_27ef2c36eb95d796();
    
    while ( true )
    {
        if ( !isdefined( newweapon ) || newweapon.basename != "ks_use_crate_mp" && newweapon.basename != "none" )
        {
            weapontrader function_56309723c94ec45( self, newweapon );
        }
        
        self waittill( "weapon_change", newweapon );
        waitframe();
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x11a2
// Size: 0x3e
function private function_c9064aca910696fa()
{
    self endon( "disabled" );
    self.var_6e365789695d215 = [];
    
    while ( true )
    {
        level waittill_any_2( "public_event_firesale_start", "public_event_firesale_end" );
        self.var_6e365789695d215 = [];
        function_d78e7b34b99b0458();
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x11e8
// Size: 0x6f
function private function_d78e7b34b99b0458()
{
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        if ( isdefined( armorytrader.visible ) )
        {
            armorytrader function_74a3f02a496877c6();
        }
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0
// Checksum 0x0, Offset: 0x125f
// Size: 0xcd
function function_74a3f02a496877c6()
{
    if ( !isdefined( self.proximitytrigger ) || !isdefined( self.proximitytrigger.playersintrigger ) )
    {
        return;
    }
    
    foreach ( player in self.proximitytrigger.playersintrigger )
    {
        currentweapon = player.lastdroppableweaponobj;
        
        if ( !isdefined( currentweapon ) || currentweapon.basename != "ks_use_crate_mp" && currentweapon.basename != "none" )
        {
            function_56309723c94ec45( player, currentweapon );
        }
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 3
// Checksum 0x0, Offset: 0x1334
// Size: 0xfd
function dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( !istrue( level.var_6254899bb2142d87 ) || getdvarint( @"hash_c43c6d7961e72d40", 0 ) == 1 )
    {
        return;
    }
    
    assert( !scripts\mp\gametypes\br_gametypes::isfeaturedisabled( "<dev string:x4c>" ) );
    maxdistance = dangercircleradius + level.var_53c0fa66001cff52;
    maxdistancesquared = maxdistance * maxdistance;
    
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        if ( isdefined( armorytrader.visible ) && distance2dsquared( armorytrader.origin, dangercircleorigin ) > maxdistancesquared )
        {
            function_807bb1d3855dea79( armorytrader );
        }
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0
// Checksum 0x0, Offset: 0x1439
// Size: 0xd9
function function_1a1709943670772a()
{
    if ( !istrue( level.var_6254899bb2142d87 ) || getdvarint( @"hash_c43c6d7961e72d40", 0 ) == 1 )
    {
        return;
    }
    
    assert( !scripts\mp\gametypes\br_gametypes::isfeaturedisabled( "<dev string:x4c>" ) );
    var_b38fad8ed86d1666 = [];
    
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        if ( isdefined( armorytrader.visible ) && !scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger( armorytrader.origin, level.var_53c0fa66001cff52 ) )
        {
            var_b38fad8ed86d1666[ var_b38fad8ed86d1666.size ] = armorytrader;
            function_807bb1d3855dea79( armorytrader );
        }
    }
    
    return var_b38fad8ed86d1666;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0
// Checksum 0x0, Offset: 0x151b
// Size: 0x7e
function function_f58f16a632b7409d()
{
    if ( scripts\mp\gametypes\br_gametypes::isfeaturedisabled( "trader" ) )
    {
        return;
    }
    
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        if ( isdefined( armorytrader.visible ) )
        {
            function_807bb1d3855dea79( armorytrader );
        }
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x15a1
// Size: 0x92
function private function_d41e030d04bf2b79( armorytrader )
{
    armorytrader.var_e74f678be2fd0a6f = 1;
    armorytrader.var_a7d0a168e6c19c1f = function_3953d88977707504();
    armorytrader.var_3a05365f8278dff = int( pow( 2, 4 ) ) - 1;
    armorytrader.playerseeds = [];
    armorytrader function_144ca1193f36516e();
    
    /#
        armorytrader thread function_c77a8790be51187();
    #/
    
    if ( isdefined( level.br_armory_trader.var_6bc61e1f4afa3ff3 ) )
    {
        scripts\killstreaks\emp::function_43755e1816ee895b( armorytrader, &traderemp, &function_83c65466cc2272dd );
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1
// Checksum 0x0, Offset: 0x163b
// Size: 0x81
function function_83c65466cc2272dd( armorytrader )
{
    armorytrader setscriptablepartstate( "br_armory_trader", "visible" );
    
    if ( level.br_armory_trader.var_bd3e92971cb005fa )
    {
        armorytrader setscriptablepartstate( "objective", "active" );
    }
    else
    {
        armorytrader setscriptablepartstate( "objective", "inactive" );
    }
    
    armorytrader.visible = 1;
    armorytrader.disabled = undefined;
    armorytrader function_7f17056284fe39db();
    armorytrader thread function_c9064aca910696fa();
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x16c4
// Size: 0x45
function private function_807bb1d3855dea79( armorytrader )
{
    armorytrader setscriptablepartstate( "br_armory_trader", "disabled" );
    armorytrader.visible = undefined;
    armorytrader.disabled = 1;
    armorytrader function_48607351aa7c7174();
    armorytrader notify( "disabled" );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1711
// Size: 0x30, Type: bool
function private function_4a8cc2be66f163e3( player )
{
    if ( !scripts\mp\gametypes\br_publicevents::ispubliceventoftypeactive( %"firesale" ) )
    {
        return false;
    }
    
    return !array_contains( self.var_6e365789695d215, player );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x174a
// Size: 0x51
function private function_d09f8444b6d5545d( item )
{
    if ( isdefined( item ) && isdefined( level.br_lootiteminfo[ item ] ) && isdefined( level.br_lootiteminfo[ item ].fullweaponname ) )
    {
        return level.br_lootiteminfo[ item ].fullweaponname;
    }
    
    return undefined;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x17a4
// Size: 0xb6, Type: bool
function private function_7a52c9a581d2f2eb( instance, player, var_bd2cee13db54664a )
{
    if ( !isdefined( var_bd2cee13db54664a ) )
    {
        return false;
    }
    
    if ( istrue( level.gameended ) )
    {
        return false;
    }
    
    if ( !player scripts\cp_mp\utility\player_utility::_isalive() || istrue( player.inlaststand ) )
    {
        return false;
    }
    
    if ( player scripts\common\utility::isusingremote() )
    {
        return false;
    }
    
    if ( player scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        return false;
    }
    
    if ( istrue( player scripts\mp\gametypes\br_gametypes::runbrgametypefunc( "playerSkipKioskUse", instance ) ) )
    {
        return false;
    }
    
    if ( istrue( player.iscarrying ) && !isdefined( player.carriable ) )
    {
        player scripts\mp\hud_message::showerrormessage( "MP/CANNOT_USE_GENERIC" );
        return false;
    }
    
    if ( !player function_f70cffac5c2b680d( var_bd2cee13db54664a ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1863
// Size: 0xbc, Type: bool
function private function_f70cffac5c2b680d( var_bd2cee13db54664a )
{
    if ( !isdefined( var_bd2cee13db54664a ) || !isdefined( var_bd2cee13db54664a.inventorytype ) || var_bd2cee13db54664a != self getcurrentweapon() && var_bd2cee13db54664a != self getcurrentprimaryweapon() )
    {
        return false;
    }
    
    if ( var_bd2cee13db54664a.inventorytype != "primary" && var_bd2cee13db54664a.inventorytype != "altmode" )
    {
        return false;
    }
    
    weaponname = getcompleteweaponname( var_bd2cee13db54664a getnoaltweapon() );
    islootweapon = isdefined( level.br_pickups.br_weapontoscriptable[ weaponname ] );
    isvalidcustomweapon = scripts\mp\gametypes\br_weapons::isvalidcustomweapon( var_bd2cee13db54664a );
    
    if ( !islootweapon && !isvalidcustomweapon )
    {
        return false;
    }
    
    return true;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x1928
// Size: 0x5e
function private function_c0972a3a09a99ab6( instance, part, state, player, bautouse, usestring )
{
    var_754f5690a852cfeb = isdefined( player.var_fa227cd07e38f2dc );
    
    if ( !var_754f5690a852cfeb )
    {
        thread function_afafcb5597ac7f8b( instance, part, state, player, bautouse, usestring );
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x198e
// Size: 0x280
function private function_afafcb5597ac7f8b( instance, part, state, player, bautouse, usestring )
{
    assert( part == "<dev string:x56>" );
    var_bd2cee13db54664a = player scripts\mp\gametypes\br_weapons::function_27ef2c36eb95d796();
    
    if ( !function_7a52c9a581d2f2eb( instance, player, var_bd2cee13db54664a ) )
    {
        return;
    }
    
    var_423e7c9070306589 = instance function_1062e631e88cc4df( var_bd2cee13db54664a, player );
    
    if ( !isdefined( var_423e7c9070306589 ) )
    {
        return;
    }
    
    assert( isdefined( level.br_armory_trader.scriptbundle ) );
    assert( isdefined( level.br_armory_trader.scriptbundle.tradeoptions ) );
    var_df1921b36d4787c = function_e6890f166a5e1ec6( var_423e7c9070306589, level.br_armory_trader.scriptbundle.tradeoptions );
    
    if ( !isdefined( var_df1921b36d4787c ) )
    {
        return;
    }
    
    tradeoption = level.br_armory_trader.scriptbundle.tradeoptions[ var_df1921b36d4787c ];
    player.var_fa227cd07e38f2dc = spawnstruct();
    player.var_fa227cd07e38f2dc.curprogress = 0;
    player.var_fa227cd07e38f2dc.usetime = default_to( tradeoption.usetime, 0 );
    player.var_fa227cd07e38f2dc.usesound = default_to( tradeoption.usesound, "" );
    player.var_fa227cd07e38f2dc.var_2e2845fb5118e744 = default_to( tradeoption.var_2e2845fb5118e744, "" );
    player.var_fa227cd07e38f2dc.var_bd2cee13db54664a = var_bd2cee13db54664a;
    instance notify( "trader_use_start" );
    instance thread function_4c930f9f8b0a20a6();
    
    if ( state == "visible" )
    {
        instance setscriptablepartstate( "br_armory_trader", "opening" );
    }
    
    if ( istrue( player.insertingarmorplate ) )
    {
        player notify( "br_try_armor_cancel" );
    }
    
    function_5aa96ca0f982567b( player, instance, var_bd2cee13db54664a );
    result = function_4508ab88cd83ce00( player, instance );
    
    if ( isdefined( player ) )
    {
        thread function_5177159216b39dc5( player, instance, result );
    }
    
    if ( istrue( result ) )
    {
        player thread function_83addb0faf58b833( instance, var_bd2cee13db54664a, var_423e7c9070306589, tradeoption );
    }
    
    player.var_fa227cd07e38f2dc = undefined;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1c16
// Size: 0x94
function private function_4c930f9f8b0a20a6()
{
    self endon( "trader_use_start" );
    self endon( "disabled" );
    
    for ( totalwait = 0; totalwait < 30 ; totalwait = 0 )
    {
        wait 1.5;
        totalwait += 1.5;
        playersnearby = scripts\mp\utility\player::getplayersinradius( self.origin, 175 );
        
        if ( playersnearby.size > 0 )
        {
        }
    }
    
    self setscriptablepartstate( "br_armory_trader", "closing" );
    self.var_a7d0a168e6c19c1f = function_3953d88977707504();
    self.playerseeds = [];
    function_74a3f02a496877c6();
    thread function_2cb33b237d4fde89();
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1cb2
// Size: 0x51
function private function_2cb33b237d4fde89()
{
    self endon( "trader_use_start" );
    self endon( "disabled" );
    
    for ( var_9ab9272aaf73e6ae = 1; var_9ab9272aaf73e6ae ; var_9ab9272aaf73e6ae = playersnearby.size > 0 )
    {
        wait 2;
        playersnearby = scripts\mp\utility\player::getplayersinradius( self.origin, 1000 );
    }
    
    function_247ea20a2cf9823b();
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1d0b
// Size: 0xda
function private function_247ea20a2cf9823b()
{
    wait 2;
    var_70364f7387a6a722 = getdvarfloat( @"hash_9494b56a31216d4c", 128 ) + 16;
    lootarray = getlootscriptablearrayinradius( undefined, undefined, self.origin, var_70364f7387a6a722 );
    
    if ( getdvarint( @"hash_a57429b2602e1687", 1 ) )
    {
        lootarray = array_combine_unique( lootarray, function_f0588926f68d998b() );
    }
    
    if ( isdefined( lootarray ) )
    {
        foreach ( loot in lootarray )
        {
            if ( !scripts\mp\gametypes\br_pickups::function_2ae5e94bd6518ab5( loot, 0 ) )
            {
                continue;
            }
            
            if ( loot getscriptableisreserved() && !isdefined( loot.brpickupscriptableid ) )
            {
                continue;
            }
            
            scripts\mp\gametypes\br_pickups::loothide( loot );
        }
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1ded
// Size: 0x175, Type: bool
function private function_4508ab88cd83ce00( player, instance )
{
    player endon( "disconnect" );
    level endon( "game_ended" );
    instance.id = "weapon_trade";
    instance.userate = ter_op( isdefined( player.objectivescaler ), player.objectivescaler, 1 );
    
    while ( isdefined( player ) && player scripts\cp_mp\utility\player_utility::_isalive() && function_97b25951938c27e6( player, instance ) && player usebuttonpressed() )
    {
        player.var_fa227cd07e38f2dc.curprogress += level.framedurationseconds * instance.userate;
        
        if ( player.var_fa227cd07e38f2dc.curprogress >= player.var_fa227cd07e38f2dc.usetime )
        {
            player.var_fa227cd07e38f2dc.curprogress = 0;
            return true;
        }
        
        player scripts\mp\gameobjects::updateuiprogress( instance, 1, player.var_fa227cd07e38f2dc );
        waitframe();
    }
    
    if ( isdefined( player ) && isdefined( player.var_fa227cd07e38f2dc ) && isdefined( player.var_fa227cd07e38f2dc.curprogress ) )
    {
        player.var_fa227cd07e38f2dc.curprogress = 0;
    }
    
    return false;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1f6b
// Size: 0x178, Type: bool
function private function_97b25951938c27e6( player, instance )
{
    if ( !isdefined( instance ) || !istrue( instance.visible ) )
    {
        return false;
    }
    
    var_a58da72618976a9 = player val::get( "crate_use" );
    
    if ( !var_a58da72618976a9 )
    {
        return false;
    }
    
    if ( !player scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return false;
    }
    
    if ( player meleebuttonpressed() )
    {
        return false;
    }
    
    if ( player superbuttonpressed() )
    {
        player scripts\mp\hud_message::showerrormessage( "SUPER_MP/SUPER_CANNOT_USE" );
        return false;
    }
    
    if ( player isinexecutionvictim() )
    {
        return false;
    }
    
    if ( istrue( player.inlaststand ) )
    {
        return false;
    }
    
    if ( !isdefined( player.var_fa227cd07e38f2dc ) || !player hasweapon( player.var_fa227cd07e38f2dc.var_bd2cee13db54664a ) )
    {
        return false;
    }
    
    var_453cf51bed99d423 = level.br_armory_trader.loadoutsdata.var_313f4e143d833b53 >= level.br_armory_trader.loadoutsdata.var_86cf42936c944bc3;
    
    if ( var_453cf51bed99d423 && player function_47a3c10b62f047d() > 0 )
    {
        player scripts\mp\hud_message::showerrormessage( "MP_BR_INGAME/ARMORY_TRADER_EXPIRED" );
        return false;
    }
    
    var_ac24e698c84063c5 = getdvarfloat( @"hash_9494b56a31216d4c", 128 ) + 16;
    maxdistsquared = var_ac24e698c84063c5 * var_ac24e698c84063c5;
    
    if ( distancesquared( player.origin, instance.origin ) > maxdistsquared )
    {
        return false;
    }
    
    return true;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x20ec
// Size: 0x8e
function private function_5aa96ca0f982567b( player, instance, var_bd2cee13db54664a )
{
    player thread function_16ce7d3e6d041977( var_bd2cee13db54664a );
    player val::group_set( "TraderUse", 0 );
    player function_515a97e3b0d91ddb( 1 );
    instance.id = "weapon_trade";
    player scripts\mp\gameobjects::updateuiprogress( instance, 0, player.var_fa227cd07e38f2dc );
    playusesound( player, player.var_fa227cd07e38f2dc.usesound );
    player.var_71b9e25d863ab555 = 1;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2182
// Size: 0xb5
function private function_5177159216b39dc5( player, instance, result )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    player val::group_reset( "TraderUse" );
    assert( isdefined( player.var_fa227cd07e38f2dc ) );
    
    if ( isdefined( instance ) )
    {
        player scripts\mp\gameobjects::updateuiprogress( instance, 0, player.var_fa227cd07e38f2dc );
        stopusesound( player, player.var_fa227cd07e38f2dc.usesound, player.var_fa227cd07e38f2dc.var_2e2845fb5118e744 );
    }
    
    player notify( "trader_use_end", result );
    player.var_71b9e25d863ab555 = undefined;
    waitframe();
    player function_515a97e3b0d91ddb( 0 );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x223f
// Size: 0x25
function private playusesound( player, usesound )
{
    if ( usesound != "" )
    {
        player playlocalsound( usesound );
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x226c
// Size: 0x4a
function private stopusesound( player, usesound, var_2e2845fb5118e744 )
{
    if ( usesound != "" )
    {
        player stoplocalsound( usesound );
    }
    
    if ( var_2e2845fb5118e744 != "" && player scripts\cp_mp\utility\player_utility::_isalive() )
    {
        player playsoundonmovingent( var_2e2845fb5118e744 );
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x22be
// Size: 0x50
function private function_16ce7d3e6d041977( var_bd2cee13db54664a )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    scripts\cp_mp\utility\weapon_utility::saveweaponstates();
    crateweaponobj = makeweapon( "ks_use_crate_mp" );
    scripts\cp_mp\utility\inventory_utility::_giveweapon( crateweaponobj );
    thread function_dbdf115b85a17cd1( crateweaponobj, var_bd2cee13db54664a );
    self switchtoweapon( crateweaponobj );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2316
// Size: 0x82
function private function_dbdf115b85a17cd1( crateweaponobj, var_bd2cee13db54664a )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "trader_use_end", result );
    
    if ( scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring( crateweaponobj ) )
    {
        scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch( crateweaponobj );
        return;
    }
    
    scripts\cp_mp\utility\inventory_utility::_takeweapon( crateweaponobj );
    
    if ( !istrue( result ) && isdefined( var_bd2cee13db54664a ) )
    {
        lastweaponobj = scripts\cp_mp\utility\weapon_utility::restoreweaponstates( var_bd2cee13db54664a, 1 );
        self switchtoweapon( lastweaponobj );
        thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon( lastweaponobj );
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x23a0
// Size: 0x144
function private function_83addb0faf58b833( trader, var_bd2cee13db54664a, var_423e7c9070306589, tradeoption )
{
    assert( isdefined( var_423e7c9070306589 ) );
    assert( isdefined( tradeoption ) );
    
    if ( var_423e7c9070306589 == "FireSaleSpecialDeal" )
    {
        trader.var_6e365789695d215 = array_add( trader.var_6e365789695d215, self );
    }
    
    weapondata = function_8d96c19224d2fe78( trader, var_423e7c9070306589, tradeoption );
    var_e6afb9db5057e953 = undefined;
    
    if ( istrue( level.br_armory_trader.var_ee776d8d5e3b9e73 ) )
    {
        self takeweapon( var_bd2cee13db54664a );
        
        if ( !self hasweapon( "iw9_me_fists_mp" ) )
        {
            self giveweapon( "iw9_me_fists_mp" );
        }
        
        self switchtoweapon( "iw9_me_fists_mp" );
        var_e6afb9db5057e953 = weapondata.weapon;
    }
    else
    {
        var_e6afb9db5057e953 = tradeweapons( var_bd2cee13db54664a, weapondata.weapon );
    }
    
    weaponammotype = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon( weapondata.weapon );
    var_39df2e8641d0c69f = trader function_384f61e478b75347( self, var_423e7c9070306589, tradeoption, var_e6afb9db5057e953, weaponammotype );
    function_e7abd278b1948a3( tradeoption );
    function_4de898685adc6c34( var_423e7c9070306589, var_39df2e8641d0c69f, weapondata.weaponname );
    scripts\cp_mp\challenges::function_4a14be27c7c571c4( var_bd2cee13db54664a );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x24ec
// Size: 0x6e
function private function_e7abd278b1948a3( tradeoption )
{
    if ( scripts\mp\gametypes\br_public::isanytutorialorbotpracticematch() )
    {
        return;
    }
    
    xp = default_to( tradeoption.xp, 0 );
    
    if ( istrue( tradeoption.hasscoreevent ) )
    {
        assert( isstring( tradeoption.scoreeventref ) );
        thread scripts\mp\utility\points::giveunifiedpoints( tradeoption.scoreeventref );
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2562
// Size: 0xa7
function private function_4de898685adc6c34( var_423e7c9070306589, var_39df2e8641d0c69f, receivedweaponname )
{
    if ( !isdefined( var_39df2e8641d0c69f ) )
    {
        var_39df2e8641d0c69f = [];
    }
    
    var_39df2e8641d0c69f[ var_39df2e8641d0c69f.size ] = receivedweaponname;
    circleindex = 0;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    self dlog_recordplayerevent( "dlog_event_armory_trader", [ "receiving_weapon_category", var_423e7c9070306589, "circle_index", circleindex, "received_items", var_39df2e8641d0c69f ] );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2611
// Size: 0x1de
function private function_1062e631e88cc4df( currentweapon, player, var_af99741c855ed20 )
{
    assert( player function_f70cffac5c2b680d( currentweapon ) );
    var_423e7c9070306589 = undefined;
    class = weaponclass( currentweapon.basename );
    ismeleeweapon = currentweapon.ismelee;
    islauncherweapon = class == "rocketlauncher" || class == "grenade";
    
    if ( !istrue( var_af99741c855ed20 ) && function_4a8cc2be66f163e3( player ) )
    {
        var_423e7c9070306589 = "FireSaleSpecialDeal";
    }
    else if ( ismeleeweapon )
    {
        var_423e7c9070306589 = "Melee";
    }
    else if ( islauncherweapon )
    {
        var_423e7c9070306589 = "Launcher";
    }
    else
    {
        weaponname = getcompleteweaponname( currentweapon getnoaltweapon() );
        var_a61b8ef0e4d4e764 = function_2b8010c382f13eae( currentweapon );
        
        switch ( var_a61b8ef0e4d4e764 )
        {
            case 0:
                var_423e7c9070306589 = "0_Attachments";
                break;
            case 1:
                var_423e7c9070306589 = "1_Attachment";
                break;
            case 2:
                var_423e7c9070306589 = "2_Attachments";
                break;
            case 3:
                var_423e7c9070306589 = "3_Attachments";
                break;
            case 4:
                var_423e7c9070306589 = "4_Attachments";
                break;
            case 5:
                var_423e7c9070306589 = "5_Attachments";
                break;
            case 6:
                var_423e7c9070306589 = "6_Attachments";
                break;
            case 7:
                var_423e7c9070306589 = "7_Attachments";
                break;
            case 8:
                var_423e7c9070306589 = "8_Attachments";
                break;
            default:
                assertex( 0, "<dev string:x6a>" + weaponname );
                var_423e7c9070306589 = "8_Attachments";
                break;
        }
    }
    
    return var_423e7c9070306589;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x27f8
// Size: 0xfb
function private function_3dab597c4e979e34( var_423e7c9070306589 )
{
    switch ( var_423e7c9070306589 )
    {
        case #"hash_bff90402c303ddb":
            return 6;
        case #"hash_8ffdbddf38cbdbd1":
            return 2;
        case #"hash_8bda341f1df69bb":
            return 2;
        case #"hash_5c3bf3c10b49a17a":
            return 0;
        case #"hash_d76fc598cbc9929c":
            return 0;
        case #"hash_89d12d9f7a5cd408":
            return 1;
        case #"hash_468604058250a593":
            return 2;
        case #"hash_6e589070278fd636":
            return 3;
        case #"hash_a1e6d4b26f676e4":
        case #"hash_69d2c13c53dfea39":
        case #"hash_914a76737f96d7af":
            return 4;
        case #"hash_e3f465314d789952":
            return 5;
        default:
            assertex( 0, "<dev string:x98>" );
            return undefined;
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x28fb
// Size: 0xed
function private function_8da3ebef342dc92d( var_423e7c9070306589 )
{
    switch ( var_423e7c9070306589 )
    {
        case #"hash_8bda341f1df69bb":
        case #"hash_5c3bf3c10b49a17a":
        case #"hash_8ffdbddf38cbdbd1":
            return 0;
        case #"hash_d76fc598cbc9929c":
            return 1;
        case #"hash_89d12d9f7a5cd408":
            return 2;
        case #"hash_468604058250a593":
            return 3;
        case #"hash_6e589070278fd636":
            return 4;
        case #"hash_69d2c13c53dfea39":
            return 5;
        case #"hash_a1e6d4b26f676e4":
            return 6;
        case #"hash_914a76737f96d7af":
            return 7;
        case #"hash_e3f465314d789952":
            return 8;
        default:
            assertex( 0, "<dev string:x98>" );
            return undefined;
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x29f0
// Size: 0x75
function private function_2b8010c382f13eae( objweapon )
{
    attachmentarray = scripts\cp_mp\challenges::findgunsmithattachments( objweapon );
    attachmentcount = 0;
    
    foreach ( attachment in attachmentarray )
    {
        if ( attachment != 0 )
        {
            attachmentcount++;
        }
    }
    
    return attachmentcount;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2a6e
// Size: 0x4a
function private function_a54a080edce0a822( max, sampler )
{
    var_25db57876379661a = self.var_a7d0a168e6c19c1f;
    
    if ( sampler != 0 )
    {
        var_25db57876379661a = ter_op( var_25db57876379661a > self.var_3a05365f8278dff, var_25db57876379661a >> sampler, var_25db57876379661a << sampler );
    }
    
    return var_25db57876379661a % max;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2ac1
// Size: 0x87
function private function_64002576f1b028ee( trader, player, max )
{
    if ( !isdefined( trader.playerseeds[ player.guid ] ) )
    {
        trader.playerseeds[ player.guid ] = randomint( 65535 );
    }
    
    seed = trader.playerseeds[ player.guid ];
    randval = seed % max;
    return randval;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2b51
// Size: 0xef
function private function_13044e8bffe2be86( entrylist, sampler )
{
    var_5e5eb7a3cfe768dc = 0;
    
    foreach ( entry in entrylist )
    {
        var_5e5eb7a3cfe768dc += entry.weight;
    }
    
    if ( var_5e5eb7a3cfe768dc == 0 )
    {
        return undefined;
    }
    
    targetweight = function_a54a080edce0a822( var_5e5eb7a3cfe768dc, sampler );
    currentweight = 0;
    
    foreach ( entry in entrylist )
    {
        currentweight += entry.weight;
        
        if ( currentweight >= targetweight )
        {
            return entry;
        }
    }
    
    return undefined;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2c49
// Size: 0x9d
function private function_6c40ceeb0fb0b8e9( var_423e7c9070306589, tradeoption, player )
{
    assert( isdefined( var_423e7c9070306589 ) );
    assert( isdefined( tradeoption ) );
    var_7d239a878df603e4 = function_13044e8bffe2be86( tradeoption.entries, 0 );
    tradeitems = function_fd6545e977b212ec( var_7d239a878df603e4, 0 );
    
    if ( function_6a752991ff22b8ec( self, player, var_423e7c9070306589 ) )
    {
        loadoutweapon = function_f4a90522e9d55cce( player, var_423e7c9070306589 );
        
        if ( isdefined( loadoutweapon ) )
        {
            tradeitems.var_b8a25679dc388d7 = loadoutweapon;
            tradeitems.weaponreward = undefined;
        }
    }
    
    return tradeitems;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2cef
// Size: 0xaf, Type: bool
function private function_6a752991ff22b8ec( trader, player, var_423e7c9070306589 )
{
    if ( level.br_armory_trader.loadoutsdata.var_313f4e143d833b53 >= level.br_armory_trader.loadoutsdata.var_86cf42936c944bc3 )
    {
        return false;
    }
    
    if ( var_423e7c9070306589 == "FireSaleSpecialDeal" )
    {
        return false;
    }
    
    var_a5825259a1cf138c = int( level.br_armory_trader.loadoutsdata.var_640f6b2398c23377 * 100 );
    roll = function_64002576f1b028ee( self, player, 100 );
    return roll < var_a5825259a1cf138c;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2da7
// Size: 0x66
function private function_f4a90522e9d55cce( player, var_423e7c9070306589 )
{
    attachmentcount = function_8da3ebef342dc92d( var_423e7c9070306589 );
    loadoutstable = function_85e81adbb2c75cf7( player );
    
    if ( !isdefined( loadoutstable[ attachmentcount ] ) )
    {
        return undefined;
    }
    
    randomloadoutindex = function_64002576f1b028ee( self, player, loadoutstable[ attachmentcount ].size );
    randomloadout = loadoutstable[ attachmentcount ][ randomloadoutindex ];
    return randomloadout;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2e16
// Size: 0x25
function private function_2987aa72031c4e08( weaponbasename )
{
    weapclass = scripts\mp\utility\weapon::getweapongroup( weaponbasename );
    return scripts\mp\gametypes\br_weapons::function_a2fa56c4e1c77ba9( weapclass );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2e44
// Size: 0x99
function private addextraammo( itemlist )
{
    foreach ( item in itemlist )
    {
        if ( isdefined( level.br_lootiteminfo[ item ] ) && isdefined( level.br_lootiteminfo[ item ].baseweapon ) )
        {
            itemlist[ itemlist.size ] = function_2987aa72031c4e08( level.br_lootiteminfo[ item ].baseweapon );
        }
    }
    
    return itemlist;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2ee6
// Size: 0x3f
function private function_5404608e3042633a( itemname, dropcount )
{
    if ( scripts\mp\gametypes\br_weapons::function_9e44f8d2e11ef1a( itemname ) )
    {
        var_157b4641ef6fe484 = getdvarint( @"hash_2bc596f53d1a3869", 2 );
        dropcount *= var_157b4641ef6fe484;
    }
    
    return dropcount;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x2f2e
// Size: 0x19a
function private function_384f61e478b75347( player, var_423e7c9070306589, tradeoption, var_e6afb9db5057e953, weaponammotype )
{
    tradeitems = function_6c40ceeb0fb0b8e9( var_423e7c9070306589, tradeoption, player );
    var_c4cd691657517bb9 = tradeitems.lootitems;
    
    if ( istrue( tradeoption.addextraammo ) )
    {
        var_c4cd691657517bb9[ var_c4cd691657517bb9.size ] = weaponammotype;
        var_c4cd691657517bb9[ var_c4cd691657517bb9.size ] = weaponammotype;
    }
    
    if ( isdefined( var_e6afb9db5057e953 ) )
    {
        var_c4cd691657517bb9[ var_c4cd691657517bb9.size ] = var_e6afb9db5057e953;
    }
    
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    var_60821baf8be402d9 = spawnstruct();
    fwd = anglestoforward( ( 0, self.angles[ 1 ], 0 ) );
    var_60821baf8be402d9.origin = self.origin + fwd * 25 + ( 0, 0, 55 );
    var_60821baf8be402d9.angles = ( 0, self.angles[ 1 ], 0 );
    var_60821baf8be402d9.itemsdropped = 0;
    var_60821baf8be402d9.var_d02a80abbdd18fe = &function_c81898198dcc148b;
    var_60821baf8be402d9.var_50da9e9c166e5ce9 = &function_5404608e3042633a;
    var_60821baf8be402d9.var_fce3ca815a6c5c67 = var_c4cd691657517bb9.size;
    var_60821baf8be402d9.targetentity = player;
    var_60821baf8be402d9.var_270e3d712e193e4f = 60;
    var_60821baf8be402d9.trader = self;
    var_60821baf8be402d9.var_1e493f592119321e = 1;
    pickupents = var_60821baf8be402d9 scripts\mp\gametypes\br_lootcache::lootspawnitemlist( dropstruct, var_c4cd691657517bb9, 0, undefined );
    
    if ( isdefined( var_e6afb9db5057e953 ) )
    {
        var_c4cd691657517bb9[ var_c4cd691657517bb9.size - 1 ] = undefined;
    }
    
    return var_c4cd691657517bb9;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x30d1
// Size: 0x86
function private function_a5b3547a5b8ee4ed()
{
    level.br_armory_trader.loadoutsdata.var_313f4e143d833b53 += 1;
    
    if ( level.br_armory_trader.loadoutsdata.var_313f4e143d833b53 >= level.br_armory_trader.loadoutsdata.var_86cf42936c944bc3 )
    {
        thread function_d78e7b34b99b0458();
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x315f
// Size: 0x161
function private function_8d96c19224d2fe78( trader, var_423e7c9070306589, tradeoption )
{
    tradeitems = trader function_6c40ceeb0fb0b8e9( var_423e7c9070306589, tradeoption, self );
    assert( isdefined( tradeitems.weaponreward ) || isdefined( tradeitems.var_b8a25679dc388d7 ) );
    weapondata = spawnstruct();
    weapon = undefined;
    
    if ( isdefined( tradeitems.weaponreward ) )
    {
        weapondata.weapon = level.br_lootiteminfo[ tradeitems.weaponreward ].fullweaponobj;
        weapondata.weaponname = tradeitems.weaponreward;
    }
    else if ( isdefined( tradeitems.var_b8a25679dc388d7 ) )
    {
        function_a5b3547a5b8ee4ed();
        loadoutweapon = tradeitems.var_b8a25679dc388d7;
        weapondata.weapon = scripts\mp\class::function_f94ec5ad05cc1001( loadoutweapon.classindex, loadoutweapon.isprimary );
        weapondata.weaponname = loadoutweapon.weaponbasename;
    }
    
    if ( isdefined( tradeitems.var_b8a25679dc388d7 ) || function_3dab597c4e979e34( var_423e7c9070306589 ) != 0 )
    {
        trader.playerseeds[ self.guid ] = undefined;
    }
    
    return weapondata;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x32c9
// Size: 0xc7
function private tradeweapons( var_bd2cee13db54664a, var_95c7a2ccddc36cb1 )
{
    var_e6afb9db5057e953 = undefined;
    ammotype = function_2987aa72031c4e08( var_95c7a2ccddc36cb1.basename );
    
    if ( !self hasweapon( var_95c7a2ccddc36cb1 ) )
    {
        self takeweapon( var_bd2cee13db54664a );
        scripts\cp_mp\utility\inventory_utility::_giveweapon( var_95c7a2ccddc36cb1, undefined, undefined, 0 );
        scripts\cp_mp\utility\inventory_utility::_switchtoweapon( var_95c7a2ccddc36cb1 );
    }
    else
    {
        var_5635d8e3736b1f76 = issameweapon( var_bd2cee13db54664a, var_95c7a2ccddc36cb1, 1 );
        
        if ( var_5635d8e3736b1f76 )
        {
            scripts\cp_mp\utility\inventory_utility::_switchtoweapon( var_95c7a2ccddc36cb1 );
        }
        else
        {
            self takeweapon( var_bd2cee13db54664a );
            
            if ( !self hasweapon( "iw9_me_fists_mp" ) )
            {
                self giveweapon( "iw9_me_fists_mp" );
            }
            
            scripts\cp_mp\utility\inventory_utility::_switchtoweapon( var_95c7a2ccddc36cb1 );
            var_e6afb9db5057e953 = var_95c7a2ccddc36cb1;
        }
    }
    
    scripts\mp\gametypes\br_weapons::br_ammo_update_ammotype_weapons( self, ammotype, self.br_ammo[ ammotype ] );
    return var_e6afb9db5057e953;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3399
// Size: 0xfd
function private function_d72cb5bcd04d925b( origin, dropstruct )
{
    var_55d0fae510b3813 = [ 0, 50, -50, 25, -25, 80, -80 ];
    diff = self.targetentity.origin - origin;
    dist = max( length2d( diff ) - 15, 30 );
    right = vectorcross( diff, ( 0, 0, 1 ) );
    right = vectornormalize( right );
    randomoffset = randomfloatrange( -5, 5 );
    rightoffset = var_55d0fae510b3813[ dropstruct.dropidx % var_55d0fae510b3813.size ] + randomoffset;
    offset = right * rightoffset;
    offset = origin + diff + offset;
    return [ offset, randomoffset, dist ];
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x349f
// Size: 0x205
function private function_d08eba54c53b4faf( origin, dropstruct )
{
    var_c17de51a9422c40a = function_aa091fe75a0e51fc();
    gridradius = level.br_armory_trader.pickupgrid.diameter * 0.5;
    var_aaebbe102a24c0ff = 360 / self.var_fce3ca815a6c5c67 * dropstruct.dropidx;
    targetpos = vectornormalize( self.targetentity.origin - origin );
    targetpos *= gridradius;
    targetpos += origin;
    self.dropgrid = function_f97e96617321a00( self.trader.dropgrid, targetpos );
    droppos = undefined;
    
    foreach ( point in self.dropgrid )
    {
        lootarray = getlootscriptablearrayinradius( undefined, undefined, point, gridradius );
        
        if ( isdefined( lootarray ) && lootarray.size == 0 )
        {
            playersinradius = scripts\mp\utility\player::getplayersinradius( point, gridradius );
            
            if ( playersinradius.size == 0 || playersinradius.size == 1 && playersinradius[ 0 ] == self.targetentity )
            {
                droppos = point;
                break;
            }
        }
    }
    
    if ( !isdefined( droppos ) )
    {
        droppos = self.dropgrid[ 0 ];
    }
    
    if ( self.var_fce3ca815a6c5c67 > 1 )
    {
        randomoffset = randomfloatrange( -15, 15 );
        droppos += rotatevector( ( 0 - var_c17de51a9422c40a, 0, 0 ), ( 0, var_aaebbe102a24c0ff + randomoffset, 0 ) );
    }
    
    diff = droppos - origin;
    dist = max( length2d( diff ), 30 );
    return [ droppos, 0, dist ];
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x36ad
// Size: 0x119
function private function_c81898198dcc148b( itemname, dropstruct, origin, angles, var_4eddedc3311ede0d, islegendary )
{
    if ( getdvarint( @"hash_a57429b2602e1687", 1 ) )
    {
        [ droppos, randomoffset, dist ] = function_d08eba54c53b4faf( origin, dropstruct );
    }
    else
    {
        [ droppos, randomoffset, dist ] = function_d72cb5bcd04d925b( origin, dropstruct );
    }
    
    anglesoffset = vectortoangles( droppos - origin );
    yaw = anglesoffset[ 1 ] - angles[ 1 ];
    yaw = ter_op( yaw > 180, yaw - 360, yaw );
    yaw = ter_op( yaw < -180, yaw + 360, yaw );
    yaw = clamp( yaw, randomoffset - 90, 90 + randomoffset );
    return scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( dropstruct, origin, angles, undefined, yaw, dist );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x37cf
// Size: 0x10a
function private function_f97e96617321a00( pointarray, origin )
{
    var_268b07c5c2de1398 = [];
    
    foreach ( point in pointarray )
    {
        entry = spawnstruct();
        entry.point = point;
        entry.distance = distancesquared( point, origin );
        var_268b07c5c2de1398[ var_268b07c5c2de1398.size ] = entry;
    }
    
    var_268b07c5c2de1398 = scripts\mp\utility\script::quicksort( var_268b07c5c2de1398, &function_175e7c4033244afd );
    sortedarray = [];
    
    foreach ( pointdistance in var_268b07c5c2de1398 )
    {
        sortedarray[ sortedarray.size ] = pointdistance.point;
    }
    
    return sortedarray;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x38e2
// Size: 0x2a, Type: bool
function private function_175e7c4033244afd( left, right )
{
    return left.distance <= right.distance;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3915
// Size: 0x43
function private function_aa091fe75a0e51fc()
{
    gridradius = level.br_armory_trader.pickupgrid.diameter * 0.5;
    var_c17de51a9422c40a = gridradius * 0.62;
    return var_c17de51a9422c40a;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3961
// Size: 0x164
function private function_144ca1193f36516e()
{
    var_f370fe6773cc902 = level.br_armory_trader.pickupgrid.diameter;
    gridradius = var_f370fe6773cc902 * 0.5;
    dropgrid = [];
    forward = anglestoforward( self.angles );
    right = anglestoright( self.angles );
    
    for ( i = -3; i < 3 ; i++ )
    {
        for ( y = 0; y < 3 ; y++ )
        {
            forwarddist = y * var_f370fe6773cc902 + gridradius + 30;
            rightdist = i * var_f370fe6773cc902 + gridradius;
            cellcenter = self.origin + forwarddist * forward + rightdist * right;
            
            if ( scripts\engine\trace::ray_trace_passed( self.origin + ( 0, 0, 20 ), cellcenter + ( 0, 0, 20 ) ) )
            {
                dropgrid[ dropgrid.size ] = cellcenter;
                
                /#
                    thread function_25ceddfc8737c26e( cellcenter, gridradius, ( 0, 1, 0 ) );
                #/
                
                continue;
            }
            
            /#
                thread function_25ceddfc8737c26e( cellcenter, gridradius, ( 1, 0, 0 ) );
            #/
        }
    }
    
    self.dropgrid = dropgrid;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3acd
// Size: 0x164
function private function_4bb5acc222d109bf()
{
    var_f370fe6773cc902 = level.br_armory_trader.pickupgrid.diameter;
    forward = anglestoforward( self.angles );
    right = anglestoright( self.angles );
    offsety = forward * ( 3 * var_f370fe6773cc902 + 30 );
    offsetx = right * 3 * var_f370fe6773cc902;
    corner1 = self.origin - offsetx;
    corner2 = corner1 + offsety;
    corner4 = self.origin + offsetx;
    corner3 = corner4 + offsety;
    
    /#
        if ( getdvarint( @"hash_bc995f12b4b8569c", 0 ) )
        {
            line( corner1, corner2, ( 0, 0, 1 ), 1, 0, 999999999 );
            line( corner2, corner3, ( 0, 0, 1 ), 1, 0, 999999999 );
            line( corner3, corner4, ( 0, 0, 1 ), 1, 0, 999999999 );
            line( corner4, corner1, ( 0, 0, 1 ), 1, 0, 999999999 );
        }
    #/
    
    return [ corner1, corner2, corner3, corner4 ];
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3c3a
// Size: 0x52, Type: bool
function private function_d791856a2f7a58ed( point, shape )
{
    for ( i = 0; i < shape.size ; i++ )
    {
        next = ( i + 1 ) % shape.size;
        
        if ( !isright( point, shape[ i ], shape[ next ] ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x3c95
// Size: 0x40, Type: bool
function private isright( point, start, end )
{
    return ( end[ 0 ] - start[ 0 ] ) * ( point[ 1 ] - start[ 1 ] ) - ( point[ 0 ] - start[ 0 ] ) * ( end[ 1 ] - start[ 1 ] ) < 0;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x3cde
// Size: 0xe8
function private function_f0588926f68d998b()
{
    var_70b103aff325a86d = function_4bb5acc222d109bf();
    var_5cfdea376bd6406b = var_70b103aff325a86d[ 1 ];
    var_f9d5fb13c2cb8857 = distance( var_5cfdea376bd6406b, self.origin );
    var_8d6da071c49cb986 = getlootscriptablearrayinradius( undefined, undefined, self.origin, var_f9d5fb13c2cb8857 );
    var_ad4e9ef67cf48b35 = [];
    
    foreach ( loot in var_8d6da071c49cb986 )
    {
        if ( abs( loot.origin[ 2 ] - self.origin[ 2 ] ) < 35 && function_d791856a2f7a58ed( loot.origin, var_70b103aff325a86d ) )
        {
            var_ad4e9ef67cf48b35[ var_ad4e9ef67cf48b35.size ] = loot;
        }
    }
    
    return var_ad4e9ef67cf48b35;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3dcf
// Size: 0xde
function private function_e6890f166a5e1ec6( var_423e7c9070306589, tradeoptions )
{
    foreach ( index, option in tradeoptions )
    {
        foreach ( var_46594395ef9ff348 in option.var_5642ddbdfcc3eac1 )
        {
            var_a6efcd61dd8c4e20 = var_46594395ef9ff348.var_7580dff7e9d8d111;
            assert( isdefined( var_a6efcd61dd8c4e20 ) );
            assert( isstring( var_a6efcd61dd8c4e20 ) );
            
            if ( var_a6efcd61dd8c4e20 == var_423e7c9070306589 )
            {
                return index;
            }
        }
    }
    
    return undefined;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3eb6
// Size: 0x40
function private getrarity( itemname )
{
    rarity = undefined;
    splitname = strtok( itemname, "_" );
    
    if ( splitname.size == 2 )
    {
        rarity = int( splitname[ 0 ] );
    }
    
    return rarity;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3eff
// Size: 0x87, Type: bool
function private function_732c56263da70f33( item )
{
    if ( istrue( level.br_pickups.var_c4b4b56c76765330[ item ] ) || istrue( level.br_pickups.var_48c246b527477ef8[ item ] ) )
    {
        return false;
    }
    
    if ( scripts\cp_mp\utility\loot::isitemfiltered( item ) || array_contains( level.br_armory_trader.var_d8dd94861da28afe, item ) )
    {
        return false;
    }
    
    if ( !isdefined( level.br_pickups.var_7b2bff2d04ee1017[ item ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3f8f
// Size: 0xc4
function private function_a38fe5fc1faf7983( array )
{
    newarray = [];
    
    foreach ( item in array )
    {
        isvalidtype = 1;
        
        if ( isdefined( level.br_lootiteminfo[ item ] ) )
        {
            weapontype = weaponclass( level.br_lootiteminfo[ item ].fullweaponobj );
            isvalidtype = !isdefined( weapontype ) || weapontype != "pistol";
        }
        
        if ( isvalidtype && function_732c56263da70f33( item ) )
        {
            newarray = array_add( newarray, item );
        }
    }
    
    return newarray;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x405c
// Size: 0x6a
function private function_3a3092e47d045e2d( array )
{
    newarray = [];
    
    foreach ( name, item in array )
    {
        if ( function_732c56263da70f33( name ) )
        {
            newarray[ name ] = item;
        }
    }
    
    return newarray;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x40cf
// Size: 0x82
function private function_b3f97a87dd92bb57( array, value )
{
    newarray = [];
    
    foreach ( name, item in array )
    {
        if ( level.br_pickups.br_itemrarity[ name ] == value )
        {
            newarray[ name ] = item;
        }
    }
    
    return newarray;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x415a
// Size: 0x83
function private function_139818c4a8162b51( array, value )
{
    newarray = [];
    
    foreach ( item in array )
    {
        if ( level.br_pickups.br_itemrarity[ item ] == value )
        {
            newarray[ newarray.size ] = item;
        }
    }
    
    return newarray;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x41e6
// Size: 0x2db
function private function_fd6545e977b212ec( var_194e8adf52ab0b06, sampler )
{
    tradeitems = spawnstruct();
    var_d4b5e075ad51a668 = [];
    
    if ( !isdefined( var_194e8adf52ab0b06 ) )
    {
        return var_d4b5e075ad51a668;
    }
    
    foreach ( item in var_194e8adf52ab0b06.lootitems )
    {
        var_5d8dcbf3cc5d17a4 = isdefined( item.var_6180da62ad446599 ) && isdefined( level.br_pickups.br_itemtype[ item.var_6180da62ad446599 ] );
        
        if ( var_5d8dcbf3cc5d17a4 )
        {
            if ( getdvarint( @"hash_432b2e0461e83498", 1 ) == 0 && isstartstr( item.var_6180da62ad446599, "brloot_plunder_cash_" ) )
            {
                continue;
            }
            
            if ( function_732c56263da70f33( item.var_6180da62ad446599 ) )
            {
                var_d4b5e075ad51a668[ var_d4b5e075ad51a668.size ] = item.var_6180da62ad446599;
            }
        }
    }
    
    weaponrarity = getrarity( var_194e8adf52ab0b06.weaponrarity );
    
    if ( isdefined( weaponrarity ) )
    {
        var_6fa9dd7368fe4d0f = function_a38fe5fc1faf7983( level.br_pickups.var_692e058f97bcc055[ weaponrarity ] );
        tradeitems.weaponreward = function_65dde5b8d2a168db( var_6fa9dd7368fe4d0f, sampler );
    }
    
    var_724449e842cf383 = getrarity( var_194e8adf52ab0b06.var_724449e842cf383 );
    
    if ( isdefined( var_724449e842cf383 ) )
    {
        var_6fa9dd7368fe4d0f = function_3a3092e47d045e2d( level.br_pickups.br_superreference );
        var_6fa9dd7368fe4d0f = function_b3f97a87dd92bb57( var_6fa9dd7368fe4d0f, var_724449e842cf383 );
        var_d4b5e075ad51a668[ var_d4b5e075ad51a668.size ] = function_6fa158340bb503c5( var_6fa9dd7368fe4d0f, sampler );
        
        if ( !istrue( level.br_armory_trader.var_b9e3706b578b5e65 ) && getdvarint( @"hash_d6cca37494336c45", 1 ) )
        {
            function_ef2b9986da96d56( var_6fa9dd7368fe4d0f, var_d4b5e075ad51a668 );
        }
    }
    
    killstreakrarity = getrarity( var_194e8adf52ab0b06.killstreakrarity );
    
    if ( isdefined( killstreakrarity ) )
    {
        var_6fa9dd7368fe4d0f = function_3a3092e47d045e2d( level.br_pickups.br_killstreakreference );
        var_6fa9dd7368fe4d0f = function_e78c57a96c3e5c8a( var_6fa9dd7368fe4d0f );
        var_6fa9dd7368fe4d0f = function_b3f97a87dd92bb57( var_6fa9dd7368fe4d0f, killstreakrarity );
        var_d4b5e075ad51a668[ var_d4b5e075ad51a668.size ] = function_6fa158340bb503c5( var_6fa9dd7368fe4d0f, sampler );
    }
    
    if ( istrue( var_194e8adf52ab0b06.var_8e27d0e923e9f41d ) )
    {
        var_6fa9dd7368fe4d0f = function_a38fe5fc1faf7983( level.br_pickups.var_1e6c5e03170cf425 );
        var_d4b5e075ad51a668[ var_d4b5e075ad51a668.size ] = function_65dde5b8d2a168db( var_6fa9dd7368fe4d0f, sampler );
    }
    
    if ( istrue( var_194e8adf52ab0b06.var_a89b7ddf6a1dfcfe ) )
    {
        var_6fa9dd7368fe4d0f = function_a38fe5fc1faf7983( level.br_pickups.var_eb7725a8a6f2c64c );
        var_d4b5e075ad51a668[ var_d4b5e075ad51a668.size ] = function_65dde5b8d2a168db( var_6fa9dd7368fe4d0f, sampler );
    }
    
    tradeitems.lootitems = var_d4b5e075ad51a668;
    return tradeitems;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x44ca
// Size: 0x10c
function private function_ef2b9986da96d56( var_6fa9dd7368fe4d0f, var_d4b5e075ad51a668 )
{
    error = undefined;
    
    foreach ( item in var_6fa9dd7368fe4d0f )
    {
        if ( item == "super_supply_drop" || item == "brloot_offhand_advancedsupplydrop" )
        {
            error = "br_armory_trader can give a super_supply_drop which shouldn't. FilterItem size : " + level.br_armory_trader.var_d8dd94861da28afe.size + "   item: " + item;
            break;
        }
    }
    
    lastitem = var_d4b5e075ad51a668[ var_d4b5e075ad51a668.size - 1 ];
    
    if ( lastitem == "super_supply_drop" || lastitem == "brloot_offhand_advancedsupplydrop" )
    {
        if ( !isdefined( error ) )
        {
            error = "";
        }
        
        error += " br_armory_trader is giving " + lastitem + " which shouldn't.";
    }
    
    if ( isdefined( error ) )
    {
        level.br_armory_trader.var_b9e3706b578b5e65 = 1;
        function_d09a84cdbf4fcdab();
        scripts\mp\utility\script::demoforcesre( error );
    }
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x45de
// Size: 0x6a
function private function_e78c57a96c3e5c8a( array )
{
    newarray = [];
    
    foreach ( name, item in array )
    {
        if ( name != "brloot_specialist_bonus" )
        {
            newarray[ name ] = item;
        }
    }
    
    return newarray;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4651
// Size: 0x46
function private function_65dde5b8d2a168db( list, sampler )
{
    var_c0840ebb01f8ff6d = undefined;
    
    if ( isdefined( list ) && list.size > 0 )
    {
        selectedindex = function_a54a080edce0a822( list.size, sampler );
        var_c0840ebb01f8ff6d = list[ selectedindex ];
    }
    
    return var_c0840ebb01f8ff6d;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x46a0
// Size: 0xa2
function private function_6fa158340bb503c5( list, sampler )
{
    var_c0840ebb01f8ff6d = undefined;
    
    if ( isdefined( list ) && list.size > 0 )
    {
        selectedindex = function_a54a080edce0a822( list.size, sampler );
        var_e1a48b5d64cc4acb = 0;
        
        foreach ( index, element in list )
        {
            if ( var_e1a48b5d64cc4acb == selectedindex )
            {
                var_c0840ebb01f8ff6d = index;
                break;
            }
            
            var_e1a48b5d64cc4acb++;
        }
    }
    
    return var_c0840ebb01f8ff6d;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x474b
// Size: 0xba
function private function_85e81adbb2c75cf7( player )
{
    if ( !isdefined( level.br_armory_trader.loadoutsdata.loadoutstables ) )
    {
        level.br_armory_trader.loadoutsdata.loadoutstables = [];
    }
    
    var_ad1caf34a660e342 = level.br_armory_trader.loadoutsdata.loadoutstables[ player.guid ];
    
    if ( !isdefined( var_ad1caf34a660e342 ) )
    {
        var_ad1caf34a660e342 = function_fd903fd1e352532f( player );
        level.br_armory_trader.loadoutsdata.loadoutstables[ player.guid ] = var_ad1caf34a660e342;
    }
    
    return var_ad1caf34a660e342;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x480e
// Size: 0x81
function private function_fd903fd1e352532f( player )
{
    loadoutstable = [];
    maxloadouts = 12;
    
    for ( classindex = 0; classindex < maxloadouts ; classindex++ )
    {
        primaryweaponstruct = player function_da6e32d894f578af( classindex, 0 );
        secondaryweaponstruct = player function_da6e32d894f578af( classindex, 1 );
        
        if ( isdefined( primaryweaponstruct ) )
        {
            loadoutstable = function_e740491f952eb4c0( loadoutstable, primaryweaponstruct );
        }
        
        if ( isdefined( secondaryweaponstruct ) )
        {
            loadoutstable = function_e740491f952eb4c0( loadoutstable, secondaryweaponstruct );
        }
    }
    
    return loadoutstable;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4898
// Size: 0x4c
function private function_e740491f952eb4c0( loadoutstable, loadoutstruct )
{
    attachmentcount = loadoutstruct.attachmentcount;
    
    if ( !isdefined( loadoutstable[ attachmentcount ] ) )
    {
        loadoutstable[ attachmentcount ] = [];
    }
    
    size = loadoutstable[ attachmentcount ].size;
    loadoutstable[ attachmentcount ][ size ] = loadoutstruct;
    return loadoutstable;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x48ed
// Size: 0x134
function private function_da6e32d894f578af( classindex, weaponindex )
{
    weaponbasename = cac_getweapon( classindex, weaponindex );
    
    if ( weaponbasename == "none" )
    {
        return undefined;
    }
    
    loadoutstruct = spawnstruct();
    weapongroup = scripts\mp\utility\weapon::getweapongroup( weaponbasename );
    attachmentcount = 0;
    
    for ( attachmentindex = 0; attachmentindex < 7 ; attachmentindex++ )
    {
        attachmentname = cac_getweaponattachment( classindex, weaponindex, attachmentindex );
        
        if ( attachmentname != "none" )
        {
            attachmentcount += 1;
        }
        
        loadoutstruct.loadoutattachments[ attachmentindex ] = attachmentname;
    }
    
    favoriteloadoutindex = self getplayerdata( level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex" );
    
    if ( attachmentcount > 0 )
    {
        attachmentcount -= 1;
    }
    
    loadoutstruct.attachmentcount = attachmentcount;
    loadoutstruct.weaponbasename = weaponbasename;
    loadoutstruct.weapongroup = weapongroup;
    loadoutstruct.isprimary = weaponindex == 0;
    loadoutstruct.classindex = classindex;
    loadoutstruct.var_f4cc8ad3934bd76d = favoriteloadoutindex == classindex;
    return loadoutstruct;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4a2a
// Size: 0x2e1
function private function_56309723c94ec45( player, currentweapon )
{
    var_f70cffac5c2b680d = player function_f70cffac5c2b680d( currentweapon );
    
    if ( !var_f70cffac5c2b680d )
    {
        player function_72e6371bef9c1b9a( 0, 0 );
        return;
    }
    
    var_423e7c9070306589 = function_1062e631e88cc4df( currentweapon, player );
    var_df1921b36d4787c = function_e6890f166a5e1ec6( var_423e7c9070306589, level.br_armory_trader.scriptbundle.tradeoptions );
    
    if ( !isdefined( var_df1921b36d4787c ) )
    {
        return;
    }
    
    var_7d0eb2e00dcbd88e = function_1062e631e88cc4df( currentweapon, player, 1 );
    traderarity = function_3dab597c4e979e34( var_7d0eb2e00dcbd88e );
    player function_8fa7ab04958e6406( traderarity );
    player function_5fdb08611b6fffe0( var_423e7c9070306589 == "FireSaleSpecialDeal" );
    tradeoption = level.br_armory_trader.scriptbundle.tradeoptions[ var_df1921b36d4787c ];
    tradeitems = function_6c40ceeb0fb0b8e9( var_423e7c9070306589, tradeoption, player );
    var_c4cd691657517bb9 = default_to( tradeitems.lootitems, [] );
    assert( isdefined( tradeitems.weaponreward ) || isdefined( tradeitems.var_b8a25679dc388d7 ) );
    
    if ( isdefined( tradeitems.weaponreward ) )
    {
        var_c4cd691657517bb9 = array_add( var_c4cd691657517bb9, tradeitems.weaponreward );
        player function_75f9109cdebef649( -1 );
    }
    else if ( isdefined( tradeitems.var_b8a25679dc388d7 ) )
    {
        loadoutweapon = tradeitems.var_b8a25679dc388d7;
        player function_75f9109cdebef649( loadoutweapon.classindex );
        player function_8db0ca04a85b7487( loadoutweapon.isprimary );
    }
    
    for ( i = 0; i < 5 ; i++ )
    {
        scriptableid = undefined;
        
        if ( var_c4cd691657517bb9.size > i )
        {
            item = var_c4cd691657517bb9[ i ];
            scriptableid = level.br_pickups.var_7b2bff2d04ee1017[ item ];
        }
        
        if ( isdefined( scriptableid ) )
        {
            player function_72e6371bef9c1b9a( scriptableid, i );
        }
        else
        {
            player function_72e6371bef9c1b9a( 0, i );
            continue;
        }
        
        if ( scripts\mp\gametypes\br_pickups::isplunder( item ) )
        {
            var_9714ddda6a6df159 = int( level.br_pickups.counts[ item ] / 10 );
            player function_55edeeaf26002e05( var_9714ddda6a6df159 );
            continue;
        }
        
        if ( scripts\mp\gametypes\br_pickups::isweaponpickup( item ) )
        {
            attachmentcount = default_to( level.br_lootiteminfo[ item ].attachmentcount, 0 );
            raritynum = default_to( level.br_pickups.br_itemrarity[ item ], 0 );
            player function_27b7949517384cd7( attachmentcount );
            player function_d2e47566806332e9( raritynum );
        }
    }
    
    return 1;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4d14
// Size: 0x3c
function private function_72e6371bef9c1b9a( itemid, i )
{
    assert( i < 5 );
    var_98d36ac3afc3d774 = "ui_br_weapon_trader_loot_id_" + i;
    self setclientomnvar( var_98d36ac3afc3d774, itemid );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4d58
// Size: 0x1b
function private function_8fa7ab04958e6406( traderarity )
{
    scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc( "ui_br_weapon_trader_data", 0, 3, traderarity );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4d7b
// Size: 0x1c
function private function_515a97e3b0d91ddb( var_41c3a0a37c6b790f )
{
    scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc( "ui_br_weapon_trader_data", 3, 1, var_41c3a0a37c6b790f );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4d9f
// Size: 0x29
function private function_55edeeaf26002e05( var_9714ddda6a6df159 )
{
    assert( var_9714ddda6a6df159 < 32 );
    scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc( "ui_br_weapon_trader_data", 4, 4, var_9714ddda6a6df159 );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4dd0
// Size: 0x1c
function private function_27b7949517384cd7( attachmentcount )
{
    scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc( "ui_br_weapon_trader_data", 8, 3, attachmentcount );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4df4
// Size: 0x2c
function private function_75f9109cdebef649( classindex )
{
    var_9deb7405742f855 = classindex + 1;
    scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc( "ui_br_weapon_trader_data", 11, 4, var_9deb7405742f855 );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4e28
// Size: 0x32
function private function_8db0ca04a85b7487( isprimaryweapon )
{
    value = isprimaryweapon ? 1 : 0;
    scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc( "ui_br_weapon_trader_data", 15, 1, value );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4e62
// Size: 0x1c
function private function_d2e47566806332e9( weaponrarity )
{
    scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc( "ui_br_weapon_trader_data", 16, 4, weaponrarity );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4e86
// Size: 0x32
function private function_5fdb08611b6fffe0( isfiresaletrade )
{
    value = isfiresaletrade ? 1 : 0;
    scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc( "ui_br_weapon_trader_data", 20, 1, value );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4ec0
// Size: 0x1e
function private function_47a3c10b62f047d()
{
    loadoutindex = scripts\cp_mp\utility\omnvar_utility::function_40f3e4aeda0e3f00( "ui_br_weapon_trader_data", 11, 4 );
    return loadoutindex;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 0
// Checksum 0x0, Offset: 0x4ee7
// Size: 0x24, Type: bool
function function_8e0659b7f9568144()
{
    return getdvarint( @"scr_ssc_use_armory_trader", 0 ) && getdvarint( @"scr_ssc_enabled", 0 );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4f14
// Size: 0x50
function private function_e6c1c35181a2870f( structname )
{
    var_e6490f9469cb3031 = getstructarray( structname, "targetname" );
    
    if ( !isdefined( var_e6490f9469cb3031 ) || var_e6490f9469cb3031.size < 1 )
    {
        var_e6490f9469cb3031 = [];
    }
    
    if ( isdefined( level.var_9fda373d69f49b57 ) )
    {
        var_e6490f9469cb3031 = [[ level.var_9fda373d69f49b57 ]]();
    }
    
    return var_e6490f9469cb3031;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4f6d
// Size: 0x41
function private function_1b62e2e65b9db442( structname, var_7ae0b394fb09f37e )
{
    if ( !isdefined( level.var_17df9a0fcf596eb0 ) )
    {
        level.var_17df9a0fcf596eb0 = [];
    }
    
    level.var_17df9a0fcf596eb0[ level.var_17df9a0fcf596eb0.size ] = var_7ae0b394fb09f37e;
    return var_7ae0b394fb09f37e;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4fb7
// Size: 0x138
function private function_11554a45a6bd9bb6( structname )
{
    level endon( "game_ended" );
    scripts\mp\flags::function_1240434f4201ac9d( "prematch_done" );
    scripts\mp\flags::function_1240434f4201ac9d( "POIs_initialized" );
    waitframe();
    
    if ( !isdefined( level.var_17df9a0fcf596eb0 ) || level.var_17df9a0fcf596eb0.size == 0 )
    {
        level.var_6254899bb2142d87 = 0;
        return;
    }
    
    level.br_armory_trader.scriptables = [];
    
    foreach ( loc in level.var_17df9a0fcf596eb0 )
    {
        armorytrader = spawnscriptable( "br_armory_trader", loc.origin, loc.angles );
        function_d41e030d04bf2b79( armorytrader );
        level.br_armory_trader.scriptables[ level.br_armory_trader.scriptables.size ] = armorytrader;
        
        /#
            if ( level.mapname == "<dev string:xba>" )
            {
                function_83c65466cc2272dd( armorytrader );
            }
        #/
    }
    
    level.var_17df9a0fcf596eb0 = undefined;
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1
// Checksum 0x0, Offset: 0x50f7
// Size: 0x1c
function traderemp( data )
{
    function_807bb1d3855dea79( self );
    thread traderdisablefortime( data );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 1
// Checksum 0x0, Offset: 0x511b
// Size: 0x1af
function traderdisablefortime( data )
{
    self notify( "armoryTraderDisableForTime" );
    self endon( "armoryTraderDisableForTime" );
    level endon( "game_ended" );
    self endon( "death" );
    self.isemped = 1;
    
    if ( !isdefined( self.temptrigger ) )
    {
        self.temptrigger = spawn( "trigger_radius", self.origin, 0, level.br_armory_trader.var_da1e0a23728ec36, 62 );
        scripts\mp\utility\trigger::makeenterexittrigger( self.temptrigger, &function_c10b28e865a8a4e6, &function_4b152e3cac01e780 );
        self.temptrigger.endtime = int( gettime() + function_a5b14435e3229bed( data.time ) );
    }
    else if ( isdefined( self.temptrigger.triggerenterents ) )
    {
        self.temptrigger.endtime = int( gettime() + function_a5b14435e3229bed( data.time ) );
        
        foreach ( player in self.temptrigger.triggerenterents )
        {
            player scripts\mp\utility\lower_message::setlowermessageomnvar( "weapon_trade_station_offline", self.temptrigger.endtime );
        }
    }
    
    wait data.time;
    self [[ self.reactivatefunc ]]( self );
    self.isemped = 0;
    self.temptrigger delete();
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2
// Checksum 0x0, Offset: 0x52d2
// Size: 0x89
function function_c10b28e865a8a4e6( player, trigger )
{
    self endon( "armoryTraderDisableForTime" );
    scripts\mp\utility\lower_message::setlowermessageomnvar( "weapon_trade_station_offline", trigger.endtime );
    
    for ( timeleft = function_c89ed1840c8d0f0f( trigger.endtime - gettime() ); isdefined( trigger ) && timeleft > 0 ; timeleft = function_c89ed1840c8d0f0f( trigger.endtime - gettime() ) )
    {
        wait timeleft;
    }
    
    waitframe();
    thread function_4b152e3cac01e780( player, trigger );
}

// Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
// Params 2
// Checksum 0x0, Offset: 0x5363
// Size: 0x27
function function_4b152e3cac01e780( player, trigger )
{
    scripts\mp\utility\lower_message::setlowermessageomnvar( "clear_lower_msg" );
    self notify( "armoryTraderDisableForTime" );
}

/#

    // Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x5392
    // Size: 0x6b, Type: dev
    function private function_c77a8790be51187()
    {
        level endon( "<dev string:xd1>" );
        
        if ( !getdvarint( @"hash_bc995f12b4b8569c", 0 ) )
        {
            return;
        }
        
        wait 30;
        
        while ( true )
        {
            level.br_armory_trader.pickupgrid.diameter = getdvarfloat( @"hash_dc652c49d7d25622", 55 );
            self notify( "<dev string:xdf>" );
            waitframe();
            function_144ca1193f36516e();
            wait 5;
        }
    }

    // Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
    // Params 3, eflags: 0x4
    // Checksum 0x0, Offset: 0x5405
    // Size: 0x5c, Type: dev
    function private function_25ceddfc8737c26e( origin, radius, color )
    {
        level endon( "<dev string:xd1>" );
        self endon( "<dev string:xdf>" );
        
        if ( !getdvarint( @"hash_bc995f12b4b8569c", 0 ) )
        {
            return;
        }
        
        while ( true )
        {
            level thread scripts\engine\utility::draw_circle( origin, radius, color, 1, 0, 10 );
            waitframe();
        }
    }

    // Namespace br_armory_trader / scripts\mp\gametypes\br_armory_trader
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x5469
    // Size: 0x383, Type: dev
    function private function_e67e79bba620a62e( command, args )
    {
        if ( args.size == 0 )
        {
            return;
        }
        
        if ( command != "<dev string:x4c>" )
        {
            return;
        }
        
        command = args[ 0 ];
        
        if ( !isdefined( level.player ) )
        {
            return;
        }
        
        switch ( command )
        {
            case #"hash_a77b6fb5f22c9db8":
                closesttrader = function_707d6cfaa04dbe98( level.player.origin );
                
                if ( isdefined( closesttrader ) && istrue( closesttrader.visible ) )
                {
                    function_807bb1d3855dea79( closesttrader );
                }
                
                break;
            case #"hash_b37256f1c926a2e3":
                closesttrader = function_707d6cfaa04dbe98( level.player.origin );
                
                if ( isdefined( closesttrader ) && istrue( closesttrader.disabled ) )
                {
                    function_83c65466cc2272dd( closesttrader );
                }
                
                break;
            case #"hash_6c4c3516ab5ce943":
                attachmentcount = 0;
                
                if ( isdefined( args[ 1 ] ) )
                {
                    attachmentcount = int( args[ 1 ] );
                }
                
                loadoutstable = function_fd903fd1e352532f( level.player );
                
                if ( !isdefined( loadoutstable[ attachmentcount ] ) )
                {
                    return undefined;
                }
                
                randomloadoutindex = randomint( loadoutstable[ attachmentcount ].size );
                loadoutweapon = loadoutstable[ attachmentcount ][ randomloadoutindex ];
                
                if ( !isdefined( loadoutweapon ) )
                {
                    return;
                }
                
                weaponobject = level.player scripts\mp\class::function_f94ec5ad05cc1001( loadoutweapon.classindex, loadoutweapon.isprimary );
                
                if ( isdefined( weaponobject ) )
                {
                    maxammo = weaponmaxammo( weaponobject );
                    dropstruct = function_7b9f3966a7a42003();
                    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( dropstruct, level.player.origin, level.player.angles, level.player );
                    scripts\mp\gametypes\br_pickups::spawnpickup( loadoutweapon.weaponbasename, dropinfo, maxammo, 1, weaponobject, 0, 0 );
                }
                
                break;
            case #"hash_82dd7c3e206217c2":
                iteration = 50000;
                rollchance = 2;
                min = 0;
                max = 3;
                range = max - min;
                minvalue = undefined;
                maxvalue = undefined;
                successcount = 0;
                
                for ( i = 0; i < iteration ; i++ )
                {
                    seed = i;
                    randval = min + seed % range;
                    
                    if ( !isdefined( minvalue ) || randval < minvalue )
                    {
                        minvalue = randval;
                    }
                    
                    if ( !isdefined( maxvalue ) || randval > maxvalue )
                    {
                        maxvalue = randval;
                    }
                    
                    if ( randval < rollchance )
                    {
                        successcount += 1;
                    }
                }
                
                var_abe1ccffe0b8572c = successcount / iteration;
                break;
            case #"hash_6176b08b00c3850b":
                foreach ( armorytrader in level.br_armory_trader.scriptables )
                {
                    armorytrader.var_a7d0a168e6c19c1f = function_3953d88977707504();
                    armorytrader.playerseeds = [];
                    armorytrader function_74a3f02a496877c6();
                }
                
                break;
        }
    }

#/
