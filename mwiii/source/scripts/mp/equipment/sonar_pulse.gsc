#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\killstreaks\uav_bigmap;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\damage;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;

#namespace sonar_pulse;

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 0
// Checksum 0x0, Offset: 0x429
// Size: 0x2
function function_a09bd8d12b478568()
{
    
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0x433
// Size: 0x355
function function_2d117eeb564f6ea3( grenade )
{
    grenade endon( "death" );
    self endon( "disconnect" );
    
    /#
        printgameaction( "<dev string:x1c>", self );
    #/
    
    grenade scripts\cp_mp\ent_manager::registerspawn( 1, &function_2564841f84f5470c );
    thread scripts\mp\weapons::monitordisownedgrenade( self, grenade );
    grenade setscriptablepartstate( "visibility", "show", 0 );
    grenade waittill( "missile_stuck", stuckto );
    
    if ( isdefined( level.var_ca4e08767cbdae12 ) )
    {
        canplant = grenade [[ level.var_ca4e08767cbdae12 ]]();
        
        if ( !canplant )
        {
            scripts\mp\supers::refundsuper();
            scripts\mp\hud_message::showerrormessage( "EQUIPMENT/PLANT_FAILED" );
            grenade delete();
            return;
        }
    }
    
    grenade setscriptablepartstate( "plant", "active", 0 );
    grenade setotherent( self );
    grenade setnodeploy( 1 );
    grenade.issuper = 1;
    grenade.superid = level.superglobals.staticsuperdata[ "super_sonar_pulse" ].id;
    grenade.usedcount = 0;
    grenade.deployingplayer = self;
    grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, 5, undefined, undefined, undefined, undefined, 1 );
    var_307667d0142f2035 = _hasperk( "specialty_rugged_eqp" );
    onequipmentplanted( grenade, "sonar_pulse_mp", &function_2564841f84f5470c );
    level thread monitordisownedequipment( self, grenade );
    grenade scripts\mp\sentientpoolmanager::registersentient( "Tactical_Static", self );
    maxhealth = ter_op( var_307667d0142f2035, 150, 75 );
    grenade thread scripts\mp\damage::monitordamage( maxhealth, "hitequip", &function_ce4c686b86693133, &function_87b9594a020ed3fd, 0 );
    grenade set_apply_emp_callback( &function_93fd2cdcd109695b );
    grenade scripts\cp_mp\equipment\haywire::function_172d848d58051fdf( &function_e0ee7e3f8e4f526 );
    grenade scripts\cp_mp\equipment\haywire::function_aa823a31304ed981( &function_d36279f6d9e8ede7 );
    
    if ( issharedfuncdefined( "emp", "setEMP_Applied_Callback" ) )
    {
        grenade [[ getsharedfunc( "emp", "setEMP_Applied_Callback" ) ]]( &function_2d4af97585682afd );
    }
    
    if ( issharedfuncdefined( "emp", "setEMP_Cleared_Callback" ) )
    {
        grenade [[ getsharedfunc( "emp", "setEMP_Cleared_Callback" ) ]]( &function_8cf01d18d90d2c4c );
    }
    
    grenade function_49197cd063a740ea( &function_2564841f84f5470c );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread scripts\common\elevators::isentitytouchingdoortrigger( grenade );
        }
    }
    
    if ( isdefined( stuckto ) && isplayer( stuckto ) )
    {
        grenade.owner thread scripts\mp\weapons::grenadestuckto( grenade, stuckto );
        grenade thread function_4ae3bcdc7576ebe4( stuckto );
    }
    
    var_b608af6e8d86fe42 = 0;
    
    if ( namespace_53fc9ddbb516e6e1::hasperksharedfunc( "specialty_uav_buff" ) )
    {
        var_b608af6e8d86fe42 = 1;
    }
    
    grenade thread function_60d095cd40221aea( var_b608af6e8d86fe42 );
    grenade thread function_b562d405020e0724( var_b608af6e8d86fe42 );
    grenade function_4b1fcc56668622d1();
    grenade scripts\mp\supers::function_235470b268f029ca( &function_2564841f84f5470c );
    scripts\cp_mp\challenges::function_d997435895422ecc( "super_sonar_pulse", function_e2ff8f4b4e94f723( #"hash_83a2d67994d7e295", #"use" ) );
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0x790
// Size: 0x2f
function function_4ae3bcdc7576ebe4( playerstuckto )
{
    self endon( "death" );
    self endon( "destroyed" );
    level endon( "game_ended" );
    playerstuckto waittill( "death_or_disconnect" );
    self unlink();
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0x7c7
// Size: 0x39
function function_60d095cd40221aea( var_b608af6e8d86fe42 )
{
    self endon( "death" );
    self endon( "destroyed" );
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "enable_sonar" );
        thread function_6f9be6b35f3dd478( var_b608af6e8d86fe42 );
    }
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0x808
// Size: 0x171
function function_6f9be6b35f3dd478( var_b608af6e8d86fe42 )
{
    self endon( "death" );
    self endon( "destroyed" );
    self endon( "disable_sonar" );
    level endon( "game_ended" );
    wait 0.5;
    
    while ( true )
    {
        radarradius = 650;
        var_2ff0b7294cde30f8 = 1;
        
        if ( islargemap() )
        {
            radarradius = 3000;
        }
        
        radarradius = int( radarradius * ter_op( isdefined( level.var_c0fe6cb6face684e ) && istrue( var_b608af6e8d86fe42 ), level.var_c0fe6cb6face684e, 1 ) );
        thread function_10ec22d7a74ce832( var_2ff0b7294cde30f8 );
        thread function_e6f69ea82cb18d6();
        
        if ( isbrstylegametype() )
        {
            scripts\cp_mp\killstreaks\uav_bigmap::function_e457560e955be5f5( self.owner.team, self.origin, radarradius, 2.05 );
        }
        
        var_cfe9a57ce86b8d4 = int( var_2ff0b7294cde30f8 * 1000 );
        
        if ( level.teambased )
        {
            triggerportableradarpingteam( self.origin, self.owner.team, radarradius, var_cfe9a57ce86b8d4 );
            level notify( "portable_radar_ping_team", self.origin, self.owner.team, radarradius, var_cfe9a57ce86b8d4 );
        }
        else
        {
            triggerportableradarping( self.origin, self.owner, radarradius, var_cfe9a57ce86b8d4 );
            level notify( "portable_radar_ping", self.origin, self.owner, radarradius, var_cfe9a57ce86b8d4 );
        }
        
        wait 2;
    }
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0x981
// Size: 0x56
function function_10ec22d7a74ce832( var_2ff0b7294cde30f8 )
{
    self endon( "death" );
    self endon( "destroyed" );
    level endon( "game_ended" );
    self setscriptablepartstate( "pulse", "active", 0 );
    wait min( 0.1, var_2ff0b7294cde30f8 - 0.5 );
    self setscriptablepartstate( "pulse", "neutral", 0 );
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 0
// Checksum 0x0, Offset: 0x9df
// Size: 0x42
function function_e6f69ea82cb18d6()
{
    self endon( "death" );
    self endon( "destroyed" );
    level endon( "game_ended" );
    self setscriptablepartstate( "anims", "open", 0 );
    wait function_e2ad1107cffcf46();
    self setscriptablepartstate( "anims", "close", 0 );
}

#using_animtree( "scriptables" );

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 0
// Checksum 0x0, Offset: 0xa29
// Size: 0x10
function function_e2ad1107cffcf46()
{
    return getanimlength( %wm_sonar_pulse_ground_open );
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0xa42
// Size: 0x5c
function function_b562d405020e0724( var_b608af6e8d86fe42 )
{
    self endon( "death" );
    self endon( "destroyed" );
    level endon( "game_ended" );
    waittime = 20;
    
    if ( istrue( var_b608af6e8d86fe42 ) )
    {
        waittime = 20 * ter_op( isdefined( level.var_1408c77a4f773854 ), level.var_1408c77a4f773854, 1 );
    }
    
    wait waittime;
    function_2564841f84f5470c();
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0xaa6
// Size: 0x134
function function_16c572662acaaf67( player )
{
    self endon( "death" );
    self endon( "destroyed" );
    self endon( "missile_stuck" );
    player endon( "disconnect" );
    msg = waittill_any_timeout_1( 2, "touching_platform" );
    
    if ( msg == "timeout" )
    {
        return;
    }
    
    groundentity = undefined;
    ignoreents = vehicle_getarrayinradius( self.origin, 500, 500 );
    ignoreents[ ignoreents.size ] = self;
    tracecontents = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 1, 1, 0, 1 );
    tracestart = self.origin;
    var_3a7f0173b03f5767 = -2000;
    traceend = self.origin + ( 0, 0, var_3a7f0173b03f5767 );
    traceresults = scripts\engine\trace::ray_trace( tracestart, traceend, ignoreents, tracecontents );
    groundentity = traceresults[ "entity" ];
    
    if ( isdefined( groundentity ) )
    {
        if ( is_train_ent( groundentity ) )
        {
            self.origin += ( 0, 0, 1.6 );
            self linkto( groundentity );
        }
    }
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0xbe2
// Size: 0x97
function function_87b9594a020ed3fd( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    modifieddamage = utility::handlemeleedamage( objweapon, type, modifieddamage );
    modifieddamage = scripts\mp\damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    scripts\mp\weapons::equipmenthit( self.owner, attacker, objweapon, type );
    return modifieddamage;
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0xc82
// Size: 0x62
function function_ce4c686b86693133( data )
{
    attacker = data.attacker;
    
    if ( istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker notify( "destroyed_equipment" );
        attacker thread doscoreevent( #"destroyed_equipment" );
        attacker thread scripts\mp\battlechatter_mp::equipmentdestroyed( self );
    }
    
    function_2564841f84f5470c( data );
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0xcec
// Size: 0x83
function function_2564841f84f5470c( data )
{
    hasattacker = 0;
    
    if ( isdefined( data ) && isdefined( data.attacker ) )
    {
        hasattacker = 1;
        function_248b0fbbc5de7e43( data.attacker );
    }
    
    if ( isdefined( self.headiconid ) )
    {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon( self.headiconid );
    }
    
    thread function_9c91a67e3f179afd( hasattacker );
    self setscriptablepartstate( "destroy", "active", 0 );
    self notify( "destroyed" );
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0xd77
// Size: 0x8f
function function_9c91a67e3f179afd( wasdestroyed )
{
    self endon( "death" );
    
    if ( !isdefined( self ) )
    {
        /#
            iprintln( "<dev string:x33>" );
        #/
    }
    
    self.exploding = 1;
    function_a8d0b1afb1554b5a();
    
    if ( isdefined( self.owner ) )
    {
        scripts\mp\analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
        self.owner removeequip( self );
    }
    
    wait 2;
    scripts\cp_mp\ent_manager::deregisterspawn();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0xe0e
// Size: 0x43
function function_248b0fbbc5de7e43( attacker )
{
    if ( istrue( scripts\cp_mp\utility\player_utility::playersareenemies( self.owner, attacker ) ) )
    {
        attacker notify( "destroyed_equipment" );
        attacker thread doscoreevent( #"destroyed_equipment" );
        attacker thread scripts\mp\battlechatter_mp::equipmentdestroyed( self );
    }
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0xe59
// Size: 0x7b
function function_93fd2cdcd109695b( data )
{
    data.victim endon( "destroyed" );
    data.victim setscriptablepartstate( "empd", "active", 0 );
    data.victim function_a8d0b1afb1554b5a();
    wait 6;
    data.victim setscriptablepartstate( "empd", "neutral", 0 );
    data.victim function_4b1fcc56668622d1();
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0xedc
// Size: 0x7b
function function_e0ee7e3f8e4f526( data )
{
    data.victim endon( "destroyed" );
    data.victim setscriptablepartstate( "empd", "active", 0 );
    data.victim function_a8d0b1afb1554b5a();
    
    if ( !istrue( data.victim.ishaywire ) )
    {
        data.victim.ishaywire = 1;
    }
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0xf5f
// Size: 0x39
function function_d36279f6d9e8ede7( data )
{
    data.victim setscriptablepartstate( "empd", "neutral", 0 );
    data.victim function_4b1fcc56668622d1();
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0xfa0
// Size: 0x4a
function function_2d4af97585682afd( data )
{
    data.victim endon( "destroyed" );
    data.victim setscriptablepartstate( "empd", "active", 0 );
    data.victim function_a8d0b1afb1554b5a();
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0xff2
// Size: 0x39
function function_8cf01d18d90d2c4c( data )
{
    data.victim setscriptablepartstate( "empd", "neutral", 0 );
    data.victim function_4b1fcc56668622d1();
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 0
// Checksum 0x0, Offset: 0x1033
// Size: 0x50
function function_4b1fcc56668622d1()
{
    if ( isdefined( self.owner ) && function_21322da268e71c19() )
    {
        if ( issharedfuncdefined( "player", "showMiniMap" ) )
        {
            self.owner [[ getsharedfunc( "player", "showMiniMap" ) ]]();
        }
    }
    
    self notify( "enable_sonar" );
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 0
// Checksum 0x0, Offset: 0x108b
// Size: 0x62
function function_a8d0b1afb1554b5a()
{
    if ( isdefined( self.owner ) && function_21322da268e71c19() )
    {
        if ( issharedfuncdefined( "player", "hideMiniMap" ) )
        {
            self.owner [[ getsharedfunc( "player", "hideMiniMap" ) ]]();
        }
    }
    
    self setscriptablepartstate( "pulse", "neutral", 0 );
    self notify( "disable_sonar" );
}

// Namespace sonar_pulse / scripts\mp\equipment\sonar_pulse
// Params 1
// Checksum 0x0, Offset: 0x10f5
// Size: 0x15
function function_49197cd063a740ea( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

