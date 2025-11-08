#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;

#namespace hb_sensor;

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x2b5
// Size: 0x9c
function autoexec main()
{
    registersharedfunc( "super_hb_sensor", "init", &hb_sensor_init );
    registersharedfunc( "super_hb_sensor", "hb_sensor_used", &hb_sensor_used );
    registersharedfunc( "super_hb_sensor", "onSuperButtonHold", &function_6e9e734982349368 );
    registersharedfunc( "super_hb_sensor", "given", &hb_sensor_given );
    registersharedfunc( "super_hb_sensor", "getPurchasedCount", &function_e95421aa59998a04 );
    registersharedfunc( "super_hb_sensor", "getAmmo", &function_29dadceefda852ce );
    registersharedfunc( "super_hb_sensor", "setAmmo", &function_cb98101eefdedaa );
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 0
// Checksum 0x0, Offset: 0x359
// Size: 0x2
function hb_sensor_init()
{
    
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 1
// Checksum 0x0, Offset: 0x363
// Size: 0x11d
function hb_sensor_used( grenade )
{
    flag_init( "equipment_interact" );
    self.var_d07d8acb673cb5c7 = undefined;
    batteryduration = function_c34b7f440bc57526();
    
    if ( isdefined( self.var_7653bd4be7dd5fdb ) && self.var_7653bd4be7dd5fdb < batteryduration )
    {
        self.var_7653bd4be7dd5fdb -= 0.1;
        
        if ( self.var_7653bd4be7dd5fdb <= 0 )
        {
            self.var_7653bd4be7dd5fdb = 0;
        }
        
        percentageremaining = int( ceil( ( batteryduration - self.var_7653bd4be7dd5fdb ) * 100 / batteryduration ) );
        self setclientomnvar( "ui_hb_sensor_battery_percentage", percentageremaining );
    }
    
    waitframe();
    self function_3ac2d6250a4c3f42( 0 );
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
    
    if ( issharedfuncdefined( "supers", "setSuperIsInUse" ) )
    {
        self [[ getsharedfunc( "supers", "setSuperIsInUse" ) ]]( 0 );
    }
    
    if ( issharedfuncdefined( "supers", "setSuperIsActive" ) )
    {
        self [[ getsharedfunc( "supers", "setSuperIsActive" ) ]]( 0 );
    }
    
    self notify( "hb_sensor_put_away" );
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 1
// Checksum 0x0, Offset: 0x488
// Size: 0x30
function hb_sensor_given( objweapon )
{
    if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        function_1581e97f79a91d04();
    }
    
    if ( !istrue( self.var_6f91e923fd82a0a8 ) )
    {
        thread function_323286bf3aa11fbb();
    }
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 1
// Checksum 0x0, Offset: 0x4c0
// Size: 0x12c
function function_6e9e734982349368( objweapon )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "hb_sensor_take" );
    self notify( "hb_sensor_end_recharge" );
    flag_set( "equipment_interact" );
    
    if ( !issubstr( objweapon.basename, "hb_sensor" ) || !self superbuttonpressed() )
    {
        return;
    }
    
    percentageremaining = 100;
    
    if ( isdefined( self.var_7653bd4be7dd5fdb ) )
    {
        batteryduration = function_c34b7f440bc57526();
        percentageremaining = int( ceil( ( batteryduration - self.var_7653bd4be7dd5fdb ) * 100 / batteryduration ) );
    }
    
    if ( percentageremaining <= 0 )
    {
        return;
    }
    
    if ( issharedfuncdefined( "supers", "setSuperIsInUse" ) )
    {
        self [[ getsharedfunc( "supers", "setSuperIsInUse" ) ]]( 1 );
    }
    
    if ( issharedfuncdefined( "supers", "setSuperIsActive" ) )
    {
        self [[ getsharedfunc( "supers", "setSuperIsActive" ) ]]( 1 );
    }
    
    thread function_7be962f484c73a3();
    self function_95f24fbb015ee513( 0 );
    self setclientomnvar( "ui_hb_sensor_battery_percentage", percentageremaining );
    wait 0.533;
    
    if ( !scripts\cp_mp\utility\game_utility::IsMagellanMode() )
    {
        thread function_fc7e5d7d7f99703a();
    }
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 0
// Checksum 0x0, Offset: 0x5f4
// Size: 0x57
function function_7be962f484c73a3()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    while ( true )
    {
        msg = waittill_any_return_3( "emp_started", "emp_applied", "emp_cleared" );
        
        if ( msg == "emp_cleared" )
        {
            function_6a05d3f5b90ab3b2( 0 );
            continue;
        }
        
        function_6a05d3f5b90ab3b2( 1 );
    }
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 1
// Checksum 0x0, Offset: 0x653
// Size: 0x13
function function_6a05d3f5b90ab3b2( isjammed )
{
    self function_9b28bd480aaad85f( isjammed );
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 2
// Checksum 0x0, Offset: 0x66e
// Size: 0x23
function function_7f948b7f43448ea9( equipmentref, slot )
{
    self notify( "hb_sensor_take" );
    thread function_3f703abc99c1bb80();
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 0
// Checksum 0x0, Offset: 0x699
// Size: 0x35
function function_323286bf3aa11fbb()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self.var_6f91e923fd82a0a8 = 1;
    self waittill( "death" );
    self.var_6f91e923fd82a0a8 = undefined;
    thread function_3f703abc99c1bb80();
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 0
// Checksum 0x0, Offset: 0x6d6
// Size: 0x38
function function_3f703abc99c1bb80()
{
    self.var_d07d8acb673cb5c7 = undefined;
    self.var_7653bd4be7dd5fdb = undefined;
    flag_clear( "equipment_interact" );
    self setclientomnvar( "ui_hb_sensor_battery_percentage", 100 );
    self function_3ac2d6250a4c3f42( 0 );
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 0
// Checksum 0x0, Offset: 0x716
// Size: 0x20
function function_1581e97f79a91d04()
{
    self.var_d07d8acb673cb5c7 = undefined;
    flag_clear( "equipment_interact" );
    self function_3ac2d6250a4c3f42( 0 );
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 0
// Checksum 0x0, Offset: 0x73e
// Size: 0x5d
function function_c34b7f440bc57526()
{
    if ( utility::iscp() )
    {
        batteryduration = getdvarint( @"hash_952c250389735fd7", 1200 );
    }
    else if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        batteryduration = getdvarint( @"hash_9566359f0d260f0b", 60 );
    }
    else
    {
        batteryduration = getdvarint( @"hash_3d0928eec520c586", 600 );
    }
    
    return batteryduration;
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 0
// Checksum 0x0, Offset: 0x7a4
// Size: 0x41
function function_29dadceefda852ce()
{
    batteryduration = function_c34b7f440bc57526();
    secondsused = self.var_7653bd4be7dd5fdb;
    
    if ( !isdefined( secondsused ) )
    {
        secondsused = 0;
    }
    
    return int( ceil( ( batteryduration - secondsused ) * 100 / batteryduration ) );
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 1
// Checksum 0x0, Offset: 0x7ee
// Size: 0x3d, Type: bool
function function_cb98101eefdedaa( percentage )
{
    self.var_3dd6d94c7b926688 = percentage;
    batteryduration = function_c34b7f440bc57526();
    self.var_7653bd4be7dd5fdb = percentage * -1 * batteryduration / 100 + batteryduration;
    return true;
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 0
// Checksum 0x0, Offset: 0x834
// Size: 0x130
function function_fc7e5d7d7f99703a()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "player_isHaywire" );
    self notify( "hb_sensor_decay" );
    self endon( "hb_sensor_decay" );
    self.var_d07d8acb673cb5c7 = 1;
    
    if ( !isdefined( self.var_7653bd4be7dd5fdb ) )
    {
        self.var_7653bd4be7dd5fdb = 0;
    }
    
    if ( self.var_7653bd4be7dd5fdb == 0 )
    {
        scripts\cp_mp\challenges::function_d997435895422ecc( "super_hb_sensor", function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"use" ) );
    }
    
    counter = 0;
    batteryduration = function_c34b7f440bc57526();
    var_3c41d0b684e437f5 = batteryduration / 100;
    
    while ( istrue( self.var_d07d8acb673cb5c7 ) )
    {
        percentageremaining = int( ceil( ( batteryduration - self.var_7653bd4be7dd5fdb ) * 100 / batteryduration ) );
        
        if ( percentageremaining < 0 )
        {
            percentageremaining = 0;
        }
        
        self setclientomnvar( "ui_hb_sensor_battery_percentage", percentageremaining );
        
        if ( counter >= var_3c41d0b684e437f5 )
        {
            self.var_7653bd4be7dd5fdb += counter;
            counter = 0;
        }
        
        if ( percentageremaining <= 0 )
        {
            thread function_83ef0926b5392999();
            break;
        }
        
        counter += 0.05;
        wait 0.05;
    }
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 0
// Checksum 0x0, Offset: 0x96c
// Size: 0x4
function function_e95421aa59998a04()
{
    return 100;
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 0
// Checksum 0x0, Offset: 0x979
// Size: 0x7b
function function_83ef0926b5392999()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    flag_clear( "equipment_interact" );
    var_4b39e4e78b233f51 = scripts\cp_mp\weapon::getgrenadeinpullback();
    
    if ( isdefined( var_4b39e4e78b233f51 ) )
    {
        result = scripts\engine\utility::waittill_notify_or_timeout_return( "hb_sensor_put_away", 1 );
        
        if ( result == "timeout" )
        {
            self releaseoffhand();
        }
    }
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        self [[ utility::getsharedfunc( "player", "resetSuper" ) ]]();
    }
}

// Namespace hb_sensor / scripts\cp_mp\supers\hb_sensor
// Params 1
// Checksum 0x0, Offset: 0x9fc
// Size: 0x34
function checkperk( perk )
{
    if ( issharedfuncdefined( "perk", "hasPerk" ) )
    {
        return self [[ getsharedfunc( "perk", "hasPerk" ) ]]( perk );
    }
    
    return undefined;
}

