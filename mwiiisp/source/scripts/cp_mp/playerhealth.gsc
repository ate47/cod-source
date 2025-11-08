#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\supers\med_box;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace playerhealth;

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0
// Checksum 0x0, Offset: 0x270
// Size: 0x2d
function init_playerhealth()
{
    if ( !isdefined( level.var_be39d6b46044f344 ) )
    {
        level.var_be39d6b46044f344 = 40;
    }
    
    /#
        setdevdvarifuninitialized( @"hash_9e41eb34980a2301", 0 );
    #/
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0
// Checksum 0x0, Offset: 0x2a5
// Size: 0x73
function manageplayerregen()
{
    self.deathsdoor = 0;
    self.deathsdoorsfx = 0;
    self.var_632fcfdf269b9dc8 = -99999;
    self.hasdonepainbreathloopthislife = 0;
    self.healing = 0;
    self stoplocalsound( "deaths_door_out" );
    self stoplocalsound( "deaths_door_in" );
    thread scripts\common\damage_effects::function_a2b4e6088394bade();
    thread function_c12e5fda7dc648ce();
    thread function_fb3404dca14b5916();
    
    /#
        thread function_31a13be1530a809b();
    #/
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x320
// Size: 0xb6
function private function_c12e5fda7dc648ce()
{
    self endon( "death_or_disconnect" );
    self endon( "enter_live_ragdoll" );
    
    while ( true )
    {
        self waittill( "damage", idamage, eattacker, vhitdir, vpoint, smeansofdeath );
        
        /#
            var_4552ad49778498ee = getdvarint( @"hash_9e41eb34980a2301", 0 );
            
            if ( var_4552ad49778498ee )
            {
                if ( isdefined( idamage ) )
                {
                    print( gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x1e>" + idamage );
                }
            }
        #/
        
        thread naturalhealthregen( smeansofdeath );
    }
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3de
// Size: 0xe5
function private naturalhealthregen( smeansofdeath )
{
    /#
        var_4552ad49778498ee = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_4552ad49778498ee )
        {
            print( gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x40>" );
        }
    #/
    
    if ( !isreallyalive( self ) )
    {
        return;
    }
    
    if ( istrue( level.healthregendisabled ) )
    {
        return;
    }
    
    self.var_73b0186b9643675a = undefined;
    self.currentregendelay = undefined;
    self notify( "naturalHealthRegen" );
    self endon( "naturalHealthRegen" );
    self endon( "death_or_disconnect" );
    self endon( "enter_live_ragdoll" );
    level endon( "game_ended" );
    self.healing = 0;
    
    while ( istrue( level.healthregendisabled ) && isusingremote() )
    {
        waitframe();
    }
    
    function_19b9bb9cef6a2d3();
    waitforhealthregendelay();
    healovertime();
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4cb
// Size: 0x82
function private function_fb3404dca14b5916()
{
    self endon( "death_or_disconnect" );
    self endon( "enter_live_ragdoll" );
    
    while ( true )
    {
        self waittill( "force_regeneration" );
        self.forcedregeneration = 1;
        
        /#
            var_4552ad49778498ee = getdvarint( @"hash_9e41eb34980a2301", 0 );
            
            if ( var_4552ad49778498ee )
            {
                print( gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x63>" );
            }
        #/
        
        thread healovertime();
    }
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x555
// Size: 0x196
function private waitforhealthregendelay()
{
    if ( isdefined( self.var_908c151f034b37e8 ) )
    {
        if ( !istrue( self.var_7d5dc55c0e7c065b ) )
        {
            thread scripts\cp_mp\supers\med_box::function_44ec1c3e385bd14b();
        }
    }
    
    /#
        var_4552ad49778498ee = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_4552ad49778498ee )
        {
            print( gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x84>" );
        }
    #/
    
    while ( istrue( self.healthregendisabled ) || !val::get( "health_regen" ) || istrue( self.var_35116e057346139e ) )
    {
        waitframe();
    }
    
    var_399288f08aaf56e5 = gettime();
    self.var_73b0186b9643675a = var_399288f08aaf56e5;
    self.currentregendelay = function_5c0987ada94437df();
    
    while ( self.currentregendelay > 0 )
    {
        self.currentregendelay = function_5c0987ada94437df( self.var_73b0186b9643675a );
        assert( self.var_73b0186b9643675a == var_399288f08aaf56e5 );
        wait 0.05;
    }
    
    if ( isdefined( level.gametype ) && level.gametype == "dungeons" )
    {
        while ( utility::damageflag( 2 ) )
        {
            waitframe();
        }
    }
    
    /#
        var_4552ad49778498ee = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_4552ad49778498ee )
        {
            print( gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:xac>" );
        }
    #/
    
    self.currentregendelay = undefined;
    self.var_73b0186b9643675a = undefined;
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x6f3
// Size: 0x222
function private healovertime()
{
    naturalheal = !istrue( self.adrenalinepoweractive ) && !istrue( self.var_808d06ddfc93a4e4 ) && !istrue( self.bandageactive ) && !istrue( self.laststandhealisactive );
    
    if ( naturalheal && istrue( self.healing ) )
    {
        return;
    }
    
    if ( !_isalive() )
    {
        return;
    }
    
    /#
        var_4552ad49778498ee = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_4552ad49778498ee )
        {
            print( gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:xd2>" );
        }
    #/
    
    self notify( "healOverTimeThink" );
    self endon( "healOverTimeThink" );
    self endon( "death_or_disconnect" );
    self endon( "enter_live_ragdoll" );
    self endon( "damage" );
    level endon( "game_ended" );
    var_7f86cf029bef696d = istrue( self.adrenalinepoweractive );
    starthealth = self.health;
    var_9cab7fb3eaa1ac48 = 0;
    var_2a0c127782c20593 = function_ffa24fdcb2f2f661( naturalheal );
    
    while ( self.health / self.maxhealth < var_2a0c127782c20593 )
    {
        if ( !val::get( "health_regen" ) || istrue( self.healthregendisabled ) && naturalheal )
        {
            self.healing = 0;
            return;
        }
        
        self.healing = 1;
        function_326da60065b28039();
        var_9cab7fb3eaa1ac48 += gethealthperframe();
        self.health = int( min( self.maxhealth, var_9cab7fb3eaa1ac48 + self.health ) );
        function_25bcb1f5ecb2c04e();
        var_9cab7fb3eaa1ac48 %= 1;
        function_19b9bb9cef6a2d3();
        wait 0.05;
    }
    
    self.healing = 0;
    
    if ( isdefined( self.var_908c151f034b37e8 ) )
    {
        thread scripts\cp_mp\supers\med_box::function_6ed51e2f80c93fa6();
    }
    
    if ( isdefined( self.forcedregeneration ) )
    {
        self.forcedregeneration = undefined;
    }
    
    if ( self.health >= self.maxhealth )
    {
        onfullhealth( starthealth, naturalheal, var_7f86cf029bef696d );
        function_19b9bb9cef6a2d3();
    }
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x91d
// Size: 0xd9, Type: bool
function private function_79429693a2f7755d( var_22b5b902570c2d6, var_33a536d1dbc55784 )
{
    assert( isdefined( var_22b5b902570c2d6 ) );
    assert( isdefined( var_33a536d1dbc55784 ) && isfloat( var_33a536d1dbc55784 ) );
    assert( isdefined( self ) && isplayer( self ) );
    
    if ( !isdefined( self.var_278adeade4a9e3a5 ) )
    {
        self.var_278adeade4a9e3a5 = [];
    }
    
    if ( array_contains_key( self.var_278adeade4a9e3a5, var_22b5b902570c2d6 ) )
    {
        return false;
    }
    else
    {
        self.var_278adeade4a9e3a5[ var_22b5b902570c2d6 ] = var_33a536d1dbc55784;
        
        /#
            var_4552ad49778498ee = getdvarint( @"hash_9e41eb34980a2301", 0 );
            
            if ( var_4552ad49778498ee )
            {
                print( gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:xef>" + var_22b5b902570c2d6 );
            }
        #/
        
        return true;
    }
    
    return false;
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 3
// Checksum 0x0, Offset: 0x9ff
// Size: 0x33
function function_5457f0107a845374( var_22b5b902570c2d6, var_33a536d1dbc55784, var_5b1d349f3d7879ee )
{
    function_79429693a2f7755d( var_22b5b902570c2d6, var_33a536d1dbc55784 );
    
    if ( isdefined( var_5b1d349f3d7879ee ) )
    {
        thread regenmodifiertimeoutthread( var_22b5b902570c2d6, var_5b1d349f3d7879ee );
    }
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xa3a
// Size: 0x46
function private regenmodifiertimeoutthread( var_22b5b902570c2d6, var_3669ac207c224e12 )
{
    level endon( "game_ended" );
    self notify( "regenModifierTimeoutThread_" + var_22b5b902570c2d6 );
    self endon( "regenModifierTimeoutThread_" + var_22b5b902570c2d6 );
    waittill_any_timeout_1( var_3669ac207c224e12 / 1000, "death_or_disconnect" );
    function_4f8b5efd1816f6c3( var_22b5b902570c2d6 );
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 1
// Checksum 0x0, Offset: 0xa88
// Size: 0xc2, Type: bool
function function_4f8b5efd1816f6c3( var_22b5b902570c2d6 )
{
    assert( isdefined( var_22b5b902570c2d6 ) );
    assert( isdefined( self ) && isplayer( self ) );
    
    if ( !isdefined( self ) || !isdefined( self.var_278adeade4a9e3a5 ) )
    {
        return false;
    }
    
    if ( array_contains_key( self.var_278adeade4a9e3a5, var_22b5b902570c2d6 ) )
    {
        self.var_278adeade4a9e3a5 = array_remove_key( self.var_278adeade4a9e3a5, var_22b5b902570c2d6 );
        
        /#
            var_4552ad49778498ee = getdvarint( @"hash_9e41eb34980a2301", 0 );
            
            if ( var_4552ad49778498ee )
            {
                print( gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x11a>" + var_22b5b902570c2d6 );
            }
        #/
        
        return true;
    }
    
    return false;
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0
// Checksum 0x0, Offset: 0xb53
// Size: 0x24
function function_7e8e4a9f891d5806()
{
    if ( isdefined( self.var_73b0186b9643675a ) )
    {
        return function_5c0987ada94437df( self.var_73b0186b9643675a );
    }
    
    return undefined;
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 1
// Checksum 0x0, Offset: 0xb7f
// Size: 0x264
function function_5c0987ada94437df( var_136d4cb8aa835cfb )
{
    var_3d45dcb5c34b2867 = 5000;
    var_f17191554cd9309e = var_3d45dcb5c34b2867;
    
    if ( !isdefined( self.regendelayspeed ) )
    {
        self.regendelayspeed = 1;
    }
    
    if ( isdefined( level.regendelayspeedfunc ) )
    {
        self.regendelayspeed = [[ level.regendelayspeedfunc ]]( self.regendelayspeed );
        
        /#
            var_4552ad49778498ee = getdvarint( @"hash_9e41eb34980a2301", 0 );
            
            if ( var_4552ad49778498ee )
            {
                print( gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x140>" + self.regendelayspeed );
            }
        #/
    }
    
    if ( player_hasperk( "specialty_pc_medic" ) )
    {
        self.regendelayspeed = 1;
        var_f17191554cd9309e = getdvarint( @"hash_99ec17fd211be305", 4 ) * 1000;
    }
    
    if ( isdefined( self.var_908c151f034b37e8 ) )
    {
        var_3d45dcb5c34b2867 = ceil( var_f17191554cd9309e * self.var_908c151f034b37e8 );
    }
    else
    {
        regenscalar = max( 2 - function_71005b327450d873() - self.regendelayspeed, 0 );
        
        if ( isdefined( level.var_ddc10ba2983b0b0c ) && player_hasperk( "specialty_elasomer_pads" ) )
        {
            regenscalar *= level.var_ddc10ba2983b0b0c;
        }
        
        if ( istrue( self.var_d3bfe8baae5df8e0 ) )
        {
            var_3d45dcb5c34b2867 = ceil( getdvarint( @"hash_5c5a8be08ee38b20", 4 ) * 1000 * regenscalar );
        }
        else if ( isdefined( level.healthregendelay ) )
        {
            var_3d45dcb5c34b2867 = ceil( level.healthregendelay * 1000 * regenscalar );
        }
        else if ( isdefined( self.gs.healthregendelay ) )
        {
            var_3d45dcb5c34b2867 = self.gs.healthregendelay * 1000;
        }
        else
        {
            var_3d45dcb5c34b2867 = ceil( 5000 * regenscalar );
        }
    }
    
    if ( isdefined( var_136d4cb8aa835cfb ) )
    {
        timeoffset = gettime();
        timeoffset -= var_136d4cb8aa835cfb;
        var_3d45dcb5c34b2867 -= timeoffset;
    }
    
    /#
        var_4552ad49778498ee = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_4552ad49778498ee )
        {
            print( gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x180>" + var_3d45dcb5c34b2867 );
        }
    #/
    
    return max( var_3d45dcb5c34b2867, 0 );
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xdec
// Size: 0xd0
function private function_71005b327450d873()
{
    assert( isdefined( self ) && isplayer( self ) );
    var_e9e9e13b20a550ab = 0;
    
    if ( isdefined( self.var_278adeade4a9e3a5 ) )
    {
        foreach ( mod in self.var_278adeade4a9e3a5 )
        {
            var_e9e9e13b20a550ab += mod;
        }
        
        /#
            var_4552ad49778498ee = getdvarint( @"hash_9e41eb34980a2301", 0 );
            
            if ( var_4552ad49778498ee )
            {
                print( gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x19d>" + var_e9e9e13b20a550ab );
            }
        #/
    }
    
    return var_e9e9e13b20a550ab;
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 1
// Checksum 0x0, Offset: 0xec5
// Size: 0x30
function function_ffa24fdcb2f2f661( naturalheal )
{
    if ( naturalheal && isdefined( level.var_e148f7d0b42fe6da ) )
    {
        return level.var_e148f7d0b42fe6da;
    }
    
    return 1;
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xefd
// Size: 0x5b
function private function_326da60065b28039()
{
    if ( isdefined( self.var_eaa417c82fc6f913 ) )
    {
        self [[ self.var_eaa417c82fc6f913 ]]();
    }
    
    if ( isdefined( self.var_4aec8a632dc40e2c ) && !isdefined( self.forcedregeneration ) && self.health != self.maxhealth )
    {
        self [[ self.var_4aec8a632dc40e2c ]]();
    }
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0
// Checksum 0x0, Offset: 0xf60
// Size: 0x1b8
function gethealthperframe()
{
    if ( function_244067e915c0eabe() )
    {
        var_881fb15f4d296741 = level.playermaxhealth / 150;
    }
    else
    {
        var_881fb15f4d296741 = 1;
    }
    
    healthperframe = level.var_be39d6b46044f344 * 0.05 * var_881fb15f4d296741;
    
    if ( issharedfuncdefined( "player", "getGametypeHealthPerFrame" ) )
    {
        healthperframe = self [[ getsharedfunc( "player", "getGametypeHealthPerFrame" ) ]]();
    }
    else if ( player_hasperk( "specialty_regenfaster" ) && isdefined( level.regenfasterhealthmod ) )
    {
        healthperframe *= level.regenfasterhealthmod;
    }
    
    if ( isdefined( level.regenhealthaddfunc ) )
    {
        healthperframe = [[ level.regenhealthaddfunc ]]( healthperframe );
    }
    
    callbackparams = { #var_7f2add2da3f0d3bf:1 };
    callback::callback( #"hash_6a8a551945faab9", callbackparams );
    healthperframe *= callbackparams.var_7f2add2da3f0d3bf;
    
    if ( isdefined( level.var_57bb11871e940991 ) )
    {
        foreach ( func in level.var_57bb11871e940991 )
        {
            var_84ea1c2720d87124 = self [[ func ]]( healthperframe );
            
            if ( isdefined( var_84ea1c2720d87124 ) )
            {
                healthperframe *= var_84ea1c2720d87124;
            }
        }
    }
    
    /#
        var_4552ad49778498ee = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_4552ad49778498ee )
        {
            print( gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x1cb>" + healthperframe );
        }
    #/
    
    return healthperframe;
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1121
// Size: 0x1c
function private function_25bcb1f5ecb2c04e()
{
    if ( isdefined( self.var_50fbc0f48ccfe94e ) )
    {
        self [[ self.var_50fbc0f48ccfe94e ]]();
    }
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1145
// Size: 0x13a
function private onfullhealth( starthealth, var_823ca369fafd4a36, var_7f86cf029bef696d )
{
    amounthealed = self.health - starthealth;
    
    if ( issharedfuncdefined( "player", "onFullHealth" ) )
    {
        self [[ getsharedfunc( "player", "onFullHealth" ) ]]( starthealth, var_823ca369fafd4a36, var_7f86cf029bef696d );
    }
    
    if ( var_7f86cf029bef696d )
    {
        scripts\cp_mp\challenges::onstim( amounthealed );
    }
    
    function_9ef4f53d298067a2();
    self notify( "healed" );
    level notify( "healed", self );
    
    if ( istrue( level.gamemodebundle.var_198508771f0592a9 ) )
    {
        if ( !istrue( self.inlaststand ) )
        {
            scripts\common\damage_effects::function_446043a04ae1bfe();
        }
    }
    else
    {
        thread scripts\common\damage_effects::removeoldattackersovertime();
    }
    
    if ( !level.gameended && !isusingremote() )
    {
        self playlocalsound( ter_op( isfemale(), "Fem_breathing_better", "breathing_better" ) );
    }
    
    /#
        var_4552ad49778498ee = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_4552ad49778498ee )
        {
            print( gettime() + "<dev string:x1c>" + self getentitynumber() + "<dev string:x1c>" + self.name + "<dev string:x201>" + amounthealed );
        }
    #/
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1287
// Size: 0x1c
function private function_9ef4f53d298067a2()
{
    if ( isdefined( self.var_71c054a8df6f6e2b ) )
    {
        self [[ self.var_71c054a8df6f6e2b ]]();
    }
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0
// Checksum 0x0, Offset: 0x12ab
// Size: 0x81
function function_19b9bb9cef6a2d3()
{
    healthratio = self.health / self.maxhealth;
    
    if ( healthratio > level.var_fdd1af3c4c6cbe86 && !istrue( self.inlaststand ) )
    {
        scripts\common\damage_effects::onexitdeathsdoor( 1 );
    }
    
    if ( ( healthratio <= level.var_562530bdb8e83b66 || istrue( self.inlaststand ) ) && !scripts\common\utility::isusingremote() && !istrue( self.ignoredeathsdoor ) )
    {
        scripts\common\damage_effects::onenterdeathsdoor( undefined );
    }
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 1
// Checksum 0x0, Offset: 0x1334
// Size: 0x4d
function function_93cd34979e0adbdd( var_c79a45c6dcb67386 )
{
    assert( isdefined( var_c79a45c6dcb67386 ), "func_healthperframe_modifier is a required argument for register_healthperframe_modifier!" );
    level.var_57bb11871e940991 = default_to( level.var_57bb11871e940991, [] );
    level.var_57bb11871e940991 = array_add( level.var_57bb11871e940991, var_c79a45c6dcb67386 );
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 1
// Checksum 0x0, Offset: 0x1389
// Size: 0x9c
function function_5f963b9b662284bc( var_c79a45c6dcb67386 )
{
    assert( isdefined( var_c79a45c6dcb67386 ), "func_healthperframe_modifier is a required argument for register_healthperframe_modifier!" );
    level.var_57bb11871e940991 = default_to( level.var_57bb11871e940991, [] );
    
    foreach ( func in level.var_57bb11871e940991 )
    {
        if ( func == var_c79a45c6dcb67386 )
        {
            level.var_57bb11871e940991 = array_remove( level.var_57bb11871e940991, var_c79a45c6dcb67386 );
        }
    }
}

/#

    // Namespace playerhealth / scripts\cp_mp\playerhealth
    // Params 0
    // Checksum 0x0, Offset: 0x142d
    // Size: 0x161, Type: dev
    function function_31a13be1530a809b()
    {
        self endon( "<dev string:x230>" );
        self.debughealthhud = spawnstruct();
        self.debughealthhud.var_946b001669de27fb = [];
        self.debughealthhud.active = 0;
        
        while ( isdefined( self ) )
        {
            if ( getdvarint( @"player_debughealth" ) && !self.debughealthhud.active )
            {
                thread function_cdac508141881a7c();
                self.debughealthhud.active = 1;
            }
            
            if ( !getdvarint( @"player_debughealth" ) && self.debughealthhud.active )
            {
                self notify( "<dev string:x23b>" );
                
                foreach ( hudelm in self.debughealthhud.var_946b001669de27fb )
                {
                    self.debughealthhud.var_946b001669de27fb = array_remove( self.debughealthhud.var_946b001669de27fb, hudelm );
                    hudelm destroy();
                }
                
                self.debughealthhud.active = 0;
            }
            
            waitframe();
        }
    }

    // Namespace playerhealth / scripts\cp_mp\playerhealth
    // Params 0
    // Checksum 0x0, Offset: 0x1596
    // Size: 0x208, Type: dev
    function function_cdac508141881a7c()
    {
        self endon( "<dev string:x23b>" );
        function_6840973f983f0bae( "<dev string:x253>" );
        function_6840973f983f0bae( "<dev string:x25a>" );
        
        while ( true )
        {
            waittillframeend();
            
            if ( utility::damageflag( 2 ) )
            {
                color = ( 1, 0, 0 );
            }
            else
            {
                color = ( 0, 1, 0 );
            }
            
            self.debughealthhud.var_946b001669de27fb[ "<dev string:x253>" ] setvalue( self.health );
            self.debughealthhud.var_946b001669de27fb[ "<dev string:x253>" ].color = color;
            
            if ( isalive( self ) )
            {
                if ( utility::damageflag( 2 ) )
                {
                    if ( utility::damageflag( 1 ) )
                    {
                        deathshieldtime = getdeathsshieldduration();
                        self.debughealthhud.var_946b001669de27fb[ "<dev string:x25a>" ] setdevtext( "<dev string:x265>" + string( deathshieldtime ) + "<dev string:x286>" );
                        self.debughealthhud.var_946b001669de27fb[ "<dev string:x25a>" ].color = ( 0, 1, 0 );
                    }
                    else
                    {
                        deathsdoortime = getdeathsdoorduration();
                        self.debughealthhud.var_946b001669de27fb[ "<dev string:x25a>" ] setdevtext( "<dev string:x28f>" + string( deathsdoortime ) + "<dev string:x286>" );
                        self.debughealthhud.var_946b001669de27fb[ "<dev string:x25a>" ].color = ( 1, 0, 0 );
                    }
                }
                else
                {
                    self.debughealthhud.var_946b001669de27fb[ "<dev string:x25a>" ] setdevtext( "<dev string:x2ac>" );
                }
            }
            else
            {
                self.debughealthhud.var_946b001669de27fb[ "<dev string:x25a>" ] setdevtext( "<dev string:x2ac>" );
            }
            
            waitframe();
        }
    }

    // Namespace playerhealth / scripts\cp_mp\playerhealth
    // Params 1
    // Checksum 0x0, Offset: 0x17a6
    // Size: 0xfc, Type: dev
    function function_6840973f983f0bae( id )
    {
        ybase = 10;
        rowspacing = 15;
        yoffset = self.debughealthhud.var_946b001669de27fb.size * rowspacing;
        hudelm = newclienthudelem( self );
        hudelm.sort = 10;
        hudelm.x = 85;
        hudelm.y = ybase + yoffset;
        hudelm.fontscale = 1;
        hudelm.alignx = "<dev string:x2ad>";
        hudelm.aligny = "<dev string:x2b2>";
        hudelm.horzalign = "<dev string:x2b6>";
        hudelm.vertalign = "<dev string:x2b6>";
        hudelm.sort = 1;
        self.debughealthhud.var_946b001669de27fb[ id ] = hudelm;
    }

#/

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0
// Checksum 0x0, Offset: 0x18aa
// Size: 0x15
function getdeathsdoorduration()
{
    return self.gs.deathsdoorduration;
}

// Namespace playerhealth / scripts\cp_mp\playerhealth
// Params 0
// Checksum 0x0, Offset: 0x18c8
// Size: 0x29
function getdeathsshieldduration()
{
    return self.gs.invultime_deathshieldduration * self.gs.scripteddeathshielddurationscale;
}

