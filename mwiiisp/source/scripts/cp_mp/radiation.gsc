#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\gasmask;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vision_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace radiation;

// Namespace radiation / scripts\cp_mp\radiation
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x339
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"radiation", undefined, &function_af7dbb927513bb60, &function_13dad5c9339829d7 );
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x35e
// Size: 0xf2
function private function_af7dbb927513bb60()
{
    level.radiation = spawnstruct();
    level.radiation.instances = [];
    level.radiation.damageweapon = getdvar( @"hash_f08ac6061fce744a", "danger_circle_br" );
    level.radiation.var_3c96ed7246169c1 = getdvarint( @"hash_229c4da4191ab249", 1 ) != 0;
    level.radiation.coughchance = getdvarint( @"hash_1e0f719f2b363047", 20 );
    level.radiation.coughcooldown = getdvarint( @"hash_7f28cb77cb8b8417", 5 );
    utility::registersharedfunc( "radiation", "radiation_isInit", &function_1b42b4ffc7748d8d );
    utility::registersharedfunc( "radiation", "radiation_signedDistanceFromRadiationCircle", &function_a611746a5dbb32ac );
    flag_set( "radiation_initialized" );
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x458
// Size: 0x20
function private function_13dad5c9339829d7()
{
    /#
        level.radiation.debug_selected = undefined;
        thread function_8748260c33092d78();
    #/
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 5
// Checksum 0x0, Offset: 0x480
// Size: 0x147
function create( origin, radius, var_29e95cf0babf9c87, var_9ebad3637bcb64d, var_29de4b245273b366 )
{
    radius = float( radius );
    instance = spawnstruct();
    instance.origin = origin;
    instance.angles = ( 0, 0, 0 );
    instance.active = 1;
    instance.radius = radius;
    instance.radiussq = squared( radius );
    instance.tickrate = var_29e95cf0babf9c87;
    instance.damagebase = 0;
    
    if ( istrue( var_29de4b245273b366 ) )
    {
        instance.brcircle = spawnbrcircle( origin[ 0 ], origin[ 1 ], radius );
    }
    
    if ( isdefined( var_9ebad3637bcb64d ) )
    {
        instance game_utility::function_6b6b6273f8180522( var_9ebad3637bcb64d, origin, radius );
        instance game_utility::function_6988310081de7b45();
    }
    
    instance thread function_3b5ce53109b60075();
    instance thread function_242555e5ab28a44c();
    instance callback::add( "player_entered_radiation", &function_dfd00c666da7f557 );
    instance callback::add( "player_exited_radiation", &function_e6d761d1927e2ed1 );
    level.radiation.instances[ level.radiation.instances.size ] = instance;
    return instance;
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 3
// Checksum 0x0, Offset: 0x5d0
// Size: 0xd1
function transform( new_origin, new_radius, duration )
{
    if ( new_origin == self.origin && new_radius == self.radius )
    {
        return;
    }
    
    new_radius = float( new_radius );
    callback::callback( "radiation_transform_started" );
    self notify( "radiation_transform_started" );
    self.transforming = 1;
    self.var_b6b423f4ed3f7a2d = 0;
    self.var_b70884a49ee01c84 = self.origin;
    self.var_c939535a8d2d4870 = self.radius;
    self.var_7bf9ce32347ac445 = duration;
    self.var_828323b769725dbf = new_origin;
    self.var_89748805c0fc52e3 = new_radius;
    
    if ( isdefined( self.brcircle ) )
    {
        self.brcircle brcirclemoveto( new_origin[ 0 ], new_origin[ 1 ], new_radius, duration );
    }
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 0
// Checksum 0x0, Offset: 0x6a9
// Size: 0xd7
function destroy()
{
    assertex( self.active, "radiation::destroy() called on a radiation that has already been destroyed." );
    self.active = 0;
    callback::callback( "radiation_destroyed" );
    self notify( "radiation_destroyed" );
    
    if ( game_utility::function_acaa75ca8754452e() )
    {
        game_utility::function_af5604ce591768e1();
    }
    
    if ( isdefined( self.brcircle ) )
    {
        self.brcircle delete();
    }
    
    level.radiation.instances = array_remove( level.radiation.instances, self );
    
    /#
        if ( isdefined( level.radiation.debug_selected ) && self == level.radiation.debug_selected )
        {
            level.radiation.debug_selected = undefined;
        }
    #/
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 3
// Checksum 0x0, Offset: 0x788
// Size: 0x43
function set_vision_set( vision_set, transition_time, inside )
{
    self.visionset = vision_set;
    self.visionsetinside = isdefined( inside ) ? inside : 1;
    self.var_50ba7325c62c2025 = transition_time;
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 4
// Checksum 0x0, Offset: 0x7d3
// Size: 0x5e
function function_58016c61f549ad52( var_4341066c8e46637c, var_5e09e1c88a4d2697, is_jammer, inside )
{
    self.var_75186cfe05cecd50 = var_4341066c8e46637c;
    self.var_a292f5812d40eb56 = var_5e09e1c88a4d2697;
    self.var_208cf23d5ed8f1f4 = isdefined( is_jammer ) ? is_jammer : 0;
    self.var_a2aa25ea43b31d54 = isdefined( inside ) ? inside : 1;
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 1
// Checksum 0x0, Offset: 0x839
// Size: 0x21
function function_c7d1bf4975ea9e7c( tick_rate )
{
    assert( tick_rate > 0 );
    self.tickrate = tick_rate;
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 5
// Checksum 0x0, Offset: 0x862
// Size: 0xb1
function set_damage( base_damage, damage_increase, var_e97e39807ca43a40, var_60fa6d142c5b7434, var_b72b14124763db6c )
{
    assert( base_damage > 0 );
    self.damagebase = float( base_damage );
    
    if ( isdefined( self.damageincrease ) )
    {
        assertex( damage_increase != 0 && isdefined( var_e97e39807ca43a40 ) && var_e97e39807ca43a40 > 0, "RadiationERROR: damage_increase and damage_increase_rate must both be defined and nonzero or must both be undefined." );
        self.damageincrease = float( damage_increase );
        self.var_725a385a83f94afe = float( var_e97e39807ca43a40 );
        self.var_39ee092269d3f4ea = isdefined( var_60fa6d142c5b7434 ) ? float( var_60fa6d142c5b7434 ) : undefined;
        self.var_359d6c40a8b0c1ca = var_b72b14124763db6c;
    }
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 0
// Checksum 0x0, Offset: 0x91b
// Size: 0x32
function function_8d2c769c2869e6b1()
{
    if ( !istrue( self.transforming ) )
    {
        return undefined;
    }
    
    return distance2d( self.var_828323b769725dbf, self.var_b70884a49ee01c84 ) / self.var_7bf9ce32347ac445;
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 0
// Checksum 0x0, Offset: 0x956
// Size: 0x2e
function function_843f66591b4abb4d()
{
    if ( !istrue( self.transforming ) )
    {
        return undefined;
    }
    
    return ( self.var_89748805c0fc52e3 - self.var_c939535a8d2d4870 ) / self.var_7bf9ce32347ac445;
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 1
// Checksum 0x0, Offset: 0x98d
// Size: 0x24, Type: bool
function function_1b4f63fa623de69a( pos )
{
    return distance2dsquared( pos, self.origin ) < self.radiussq;
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 1
// Checksum 0x0, Offset: 0x9ba
// Size: 0x24
function function_b9aa944decd263a3( pos )
{
    return distance2d( pos, self.origin ) - self.radius;
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 1
// Checksum 0x0, Offset: 0x9e7
// Size: 0x52
function function_fde05749af14d99c( pos )
{
    if ( !istrue( self.transforming ) )
    {
        return undefined;
    }
    
    target_radius = distance2d( pos, self.var_b70884a49ee01c84 );
    radius_speed = function_843f66591b4abb4d();
    return ( target_radius - self.radius ) / radius_speed;
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 0
// Checksum 0x0, Offset: 0xa42
// Size: 0x179
function function_f66420bd66f3075f()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    if ( !player_utility::_isalive() )
    {
        return;
    }
    
    if ( istrue( self.isjuggernaut ) )
    {
        return;
    }
    
    if ( isdefined( self.var_e1ae76f612117580 ) && gettime() < self.var_e1ae76f612117580 )
    {
        return;
    }
    
    self.var_e1ae76f612117580 = gettime() + level.radiation.coughcooldown;
    
    if ( !isai( self ) )
    {
        self playsoundtoplayer( "gas_player_cough", self, self );
    }
    
    var_4de0f8859b1a8d67 = "allies_male_cough";
    
    if ( isdefined( self.defaultoperatorteam ) && self.defaultoperatorteam == "axis" )
    {
        if ( isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female" )
        {
            var_4de0f8859b1a8d67 = "axis_female_cough";
        }
        else
        {
            var_4de0f8859b1a8d67 = "axis_male_cough";
        }
    }
    else if ( isdefined( self.operatorcustomization.gender ) && self.operatorcustomization.gender == "female" )
    {
        var_4de0f8859b1a8d67 = "allies_female_cough";
    }
    else
    {
        var_4de0f8859b1a8d67 = "allies_male_cough";
    }
    
    var_d4eb9b956e707234 = randomint( game[ "dialogue" ][ var_4de0f8859b1a8d67 ].size );
    coughsoundalias = game[ "dialogue" ][ var_4de0f8859b1a8d67 ][ var_d4eb9b956e707234 ];
    self playsound( coughsoundalias, self, self );
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 0
// Checksum 0x0, Offset: 0xbc3
// Size: 0xc, Type: bool
function function_1b42b4ffc7748d8d()
{
    return isdefined( level.radiation );
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 1
// Checksum 0x0, Offset: 0xbd8
// Size: 0x69
function function_a611746a5dbb32ac( pos )
{
    closest_distance = 999999;
    sorted_instances = sortbydistance( level.radiation.instances, pos );
    
    if ( sorted_instances.size > 0 )
    {
        return ( distance2d( pos, sorted_instances[ 0 ].origin ) - sorted_instances[ 0 ].radius );
    }
    
    return closest_distance;
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xc4a
// Size: 0x12c
function private function_3b5ce53109b60075()
{
    level endon( "game_ended" );
    self endon( "radiation_destroyed" );
    
    while ( self.active )
    {
        waitframe();
        
        if ( istrue( self.transforming ) )
        {
            progress = self.var_b6b423f4ed3f7a2d / self.var_7bf9ce32347ac445;
            
            if ( progress >= 1 )
            {
                progress = 1;
            }
            
            self.origin = vectorlerp( self.var_b70884a49ee01c84, self.var_828323b769725dbf, progress );
            self.radius = math::lerp( self.var_c939535a8d2d4870, self.var_89748805c0fc52e3, progress );
            self.radiussq = self.radius * self.radius;
            
            if ( game_utility::function_acaa75ca8754452e() )
            {
                game_utility::function_6e148c8da2e4db13( self.origin );
                game_utility::function_4584ad1c0e2c58ec( self.radius );
            }
            
            callback::callback( "radiation_transform_update" );
            self.var_b6b423f4ed3f7a2d += level.framedurationseconds;
            
            if ( progress >= 1 )
            {
                self.transforming = undefined;
                callback::callback( "radiation_transform_completed" );
            }
        }
    }
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xd7e
// Size: 0x38e
function private function_242555e5ab28a44c()
{
    level endon( "game_ended" );
    self endon( "radiation_destroyed" );
    self.var_16b2e5a6752ec4e0 = [];
    self.var_8b468934c883d916 = [];
    
    while ( self.active )
    {
        wait self.tickrate;
        
        foreach ( player in level.players )
        {
            var_223ed137a7efba62 = player getentitynumber();
            var_c5fff5b131a6ec21 = function_1b4f63fa623de69a( player.origin );
            
            if ( var_c5fff5b131a6ec21 )
            {
                if ( !isdefined( self.var_16b2e5a6752ec4e0[ var_223ed137a7efba62 ] ) )
                {
                    self.var_16b2e5a6752ec4e0[ var_223ed137a7efba62 ] = gettime();
                    self.var_8b468934c883d916[ var_223ed137a7efba62 ] = 0;
                    callback::callback( "player_entered_radiation", { #player:player } );
                }
            }
            else if ( isdefined( self.var_16b2e5a6752ec4e0[ var_223ed137a7efba62 ] ) )
            {
                self.var_16b2e5a6752ec4e0[ var_223ed137a7efba62 ] = undefined;
                self.var_8b468934c883d916[ var_223ed137a7efba62 ] = undefined;
                callback::callback( "player_exited_radiation", { #player:player } );
            }
            
            if ( !isalive( player ) )
            {
                continue;
            }
            
            damage = 0;
            
            if ( !var_c5fff5b131a6ec21 || istrue( player.plotarmor ) )
            {
                damage = 0;
            }
            else if ( !istrue( self.var_359d6c40a8b0c1ca ) && isdefined( self.damageincrease ) && isdefined( self.var_725a385a83f94afe ) )
            {
                damage = self.damagebase + function_52336389b0bbc8( var_223ed137a7efba62 );
            }
            else
            {
                damage = self.damagebase;
            }
            
            if ( gasmask::hasgasmask( player ) && !istrue( player.gasmaskswapinprogress ) )
            {
                if ( var_c5fff5b131a6ec21 )
                {
                    if ( isdefined( level.var_f26b4e7eb9af8155 ) )
                    {
                        player [[ level.var_f26b4e7eb9af8155 ]]( "radiation" );
                    }
                    
                    if ( damage > 0 )
                    {
                        player gasmask::processdamage( damage );
                        damage = 0;
                    }
                }
                else if ( isdefined( level.var_c57ee1e174e42601 ) )
                {
                    player [[ level.var_c57ee1e174e42601 ]]( "radiation" );
                }
            }
            
            if ( var_c5fff5b131a6ec21 && !istrue( player.plotarmor ) && istrue( self.var_359d6c40a8b0c1ca ) && isdefined( self.damageincrease ) && isdefined( self.var_725a385a83f94afe ) )
            {
                damage = self.damagebase + function_52336389b0bbc8( var_223ed137a7efba62 );
            }
            
            if ( damage > 0 )
            {
                if ( self.var_8b468934c883d916[ var_223ed137a7efba62 ] > 0 )
                {
                    damage += self.var_8b468934c883d916[ var_223ed137a7efba62 ];
                    self.var_8b468934c883d916[ var_223ed137a7efba62 ] = 0;
                }
                
                damage_int = int( damage );
                damage_diff = damage - float( damage_int );
                
                if ( damage_diff > 0.01 )
                {
                    self.var_8b468934c883d916[ var_223ed137a7efba62 ] = damage_diff;
                }
                
                player dodamage( damage_int, player.origin, player, undefined, "MOD_TRIGGER_HURT", level.radiation.damageweapon );
                player armor::damagearmor( damage_int, undefined, player, "MOD_TRIGGER_HURT" );
                
                if ( randomint( 100 ) < level.radiation.coughchance )
                {
                    player function_f66420bd66f3075f();
                }
                
                player callback::callback( "radiation_damage_player", { #damage:damage_int, #radiation:self } );
            }
        }
    }
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1114
// Size: 0xb0
function private function_52336389b0bbc8( var_223ed137a7efba62 )
{
    assert( isdefined( self.var_16b2e5a6752ec4e0[ var_223ed137a7efba62 ] ) );
    assert( isdefined( self.damageincrease ) && isdefined( self.var_725a385a83f94afe ) );
    secondsinside = ( gettime() - self.var_16b2e5a6752ec4e0[ var_223ed137a7efba62 ] ) / 1000;
    IncreaseAmount = self.damageincrease * int( secondsinside / self.var_725a385a83f94afe );
    
    if ( isdefined( self.var_39ee092269d3f4ea ) && IncreaseAmount > self.var_39ee092269d3f4ea )
    {
        IncreaseAmount = self.var_39ee092269d3f4ea;
    }
    
    return IncreaseAmount;
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 1
// Checksum 0x0, Offset: 0x11cd
// Size: 0xc3
function function_dfd00c666da7f557( params )
{
    player = params.player;
    
    if ( isdefined( self.visionset ) )
    {
        if ( istrue( self.visionsetinside ) )
        {
            player vision_utility::function_27a921508cb04613( self.visionset, self.var_50ba7325c62c2025 );
        }
        else
        {
            player vision_utility::function_9a92ae402e209ecc( self.visionset, self.var_50ba7325c62c2025 );
        }
    }
    
    if ( istrue( self.var_75186cfe05cecd50 ) )
    {
        if ( istrue( self.var_a2aa25ea43b31d54 ) )
        {
            player emp_debuff::play_scramble( self.var_a292f5812d40eb56, self.var_208cf23d5ed8f1f4 );
            return;
        }
        
        player emp_debuff::stop_scramble( self.var_a292f5812d40eb56, self.var_208cf23d5ed8f1f4 );
    }
}

// Namespace radiation / scripts\cp_mp\radiation
// Params 1
// Checksum 0x0, Offset: 0x1298
// Size: 0xc3
function function_e6d761d1927e2ed1( params )
{
    player = params.player;
    
    if ( isdefined( self.visionset ) )
    {
        if ( istrue( self.visionsetinside ) )
        {
            player vision_utility::function_9a92ae402e209ecc( self.visionset, self.var_50ba7325c62c2025 );
        }
        else
        {
            player vision_utility::function_27a921508cb04613( self.visionset, self.var_50ba7325c62c2025 );
        }
    }
    
    if ( istrue( self.var_75186cfe05cecd50 ) )
    {
        if ( istrue( self.var_a2aa25ea43b31d54 ) )
        {
            player emp_debuff::stop_scramble( self.var_a292f5812d40eb56, self.var_208cf23d5ed8f1f4 );
            return;
        }
        
        player emp_debuff::play_scramble( self.var_a292f5812d40eb56, self.var_208cf23d5ed8f1f4 );
    }
}

/#

    // Namespace radiation / scripts\cp_mp\radiation
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1363
    // Size: 0x1ef, Type: dev
    function private function_8748260c33092d78()
    {
        devgui::function_6e7290c8ee4f558b( "<dev string:x1c>" );
        devgui::function_a9a864379a098ad6( "<dev string:x2d>", "<dev string:x3e>", &function_4be3bac3c965bcba );
        devgui::function_a9a864379a098ad6( "<dev string:x59>", "<dev string:x6a>", &function_ac6bb9d851bcc44e );
        devgui::function_a9a864379a098ad6( "<dev string:x85>", "<dev string:x93>", &debug_select );
        devgui::function_a9a864379a098ad6( "<dev string:xa4>", "<dev string:xb6>", &function_8203c9bd3f33309e );
        devgui::function_a9a864379a098ad6( "<dev string:xc9>", "<dev string:xd9>", &function_ff46c564f2ccba22 );
        devgui::function_b23a59dfb4ca49a1( "<dev string:xf3>", "<dev string:x10f>", &function_78a309e6d9473c1a );
        devgui::function_b23a59dfb4ca49a1( "<dev string:x130>", "<dev string:x14c>", &function_78a309e6d9473c1a );
        devgui::function_b23a59dfb4ca49a1( "<dev string:x16c>", "<dev string:x18b>", &function_78a309e6d9473c1a );
        devgui::function_b23a59dfb4ca49a1( "<dev string:x1af>", "<dev string:x1d2>", &function_dcd293b3ab646634 );
        devgui::function_b23a59dfb4ca49a1( "<dev string:x1f5>", "<dev string:x218>", &function_dcd293b3ab646634 );
        devgui::function_b23a59dfb4ca49a1( "<dev string:x23b>", "<dev string:x25e>", &function_dcd293b3ab646634 );
        devgui::function_b23a59dfb4ca49a1( "<dev string:x281>", "<dev string:x2a4>", &function_dcd293b3ab646634 );
        devgui::function_a9a864379a098ad6( "<dev string:x2c7>", "<dev string:x2ee>", &function_329a7f5688224786 );
        devgui::function_a9a864379a098ad6( "<dev string:x315>", "<dev string:x33b>", &function_3b86c53c8320156b );
        devgui::function_a9a864379a098ad6( "<dev string:x361>", "<dev string:x387>", &function_37df17632b76cff3 );
        devgui::function_b23a59dfb4ca49a1( "<dev string:x3ad>", "<dev string:x3d1>", &function_f1ce2bcb6075f617 );
        devgui::function_b23a59dfb4ca49a1( "<dev string:x3f5>", "<dev string:x419>", &function_f1ce2bcb6075f617 );
        devgui::function_b23a59dfb4ca49a1( "<dev string:x43d>", "<dev string:x461>", &function_f1ce2bcb6075f617 );
        devgui::function_b23a59dfb4ca49a1( "<dev string:x485>", "<dev string:x4a9>", &function_f1ce2bcb6075f617 );
        devgui::function_b23a59dfb4ca49a1( "<dev string:x4cd>", "<dev string:x4f1>", &function_f1ce2bcb6075f617 );
        devgui::function_b23a59dfb4ca49a1( "<dev string:x515>", "<dev string:x539>", &function_f1ce2bcb6075f617 );
        devgui::function_fe953f000498048f();
        level thread function_8c073da924b036f8();
    }

    // Namespace radiation / scripts\cp_mp\radiation
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x155a
    // Size: 0x1ee, Type: dev
    function private function_8c073da924b036f8()
    {
        level endon( "<dev string:x55d>" );
        ACCUMULATOR = 0;
        
        while ( true )
        {
            if ( ACCUMULATOR != 5 )
            {
                ACCUMULATOR += 1;
                waitframe();
                continue;
            }
            
            ACCUMULATOR = 0;
            
            if ( isdefined( level.radiation.debug_selected ) )
            {
                cylinder( level.radiation.debug_selected.origin, level.radiation.debug_selected.origin + ( 0, 0, 10000 ), level.radiation.debug_selected.radius, ( 1, 0, 0 ), 0, 5 );
                line( level.radiation.debug_selected.origin - ( level.radiation.debug_selected.radius, 0, 0 ), level.radiation.debug_selected.origin + ( level.radiation.debug_selected.radius, 0, 0 ), ( 1, 0, 0 ), 1, 0, 5 );
                line( level.radiation.debug_selected.origin - ( 0, level.radiation.debug_selected.radius, 0 ), level.radiation.debug_selected.origin + ( 0, level.radiation.debug_selected.radius, 0 ), ( 1, 0, 0 ), 1, 0, 5 );
            }
        }
    }

    // Namespace radiation / scripts\cp_mp\radiation
    // Params 0
    // Checksum 0x0, Offset: 0x1750
    // Size: 0x28, Type: dev
    function function_4be3bac3c965bcba()
    {
        return create( ( 0, 0, 0 ), 2048, 1.5, "<dev string:x568>", 1 );
    }

    // Namespace radiation / scripts\cp_mp\radiation
    // Params 0
    // Checksum 0x0, Offset: 0x1780
    // Size: 0x9a, Type: dev
    function function_ac6bb9d851bcc44e()
    {
        player = level.players[ 0 ];
        forward = anglestoforward( player getplayerangles() );
        trace = trace::ray_trace( player geteye(), player geteye() + forward * 150000 );
        
        if ( isdefined( trace[ "<dev string:x576>" ] ) && isdefined( trace[ "<dev string:x57f>" ] ) && trace[ "<dev string:x57f>" ] < 1 )
        {
            return create( trace[ "<dev string:x576>" ], 2048, 1.5, "<dev string:x568>", 1 );
        }
        
        return undefined;
    }

    // Namespace radiation / scripts\cp_mp\radiation
    // Params 0
    // Checksum 0x0, Offset: 0x1822
    // Size: 0x107, Type: dev
    function debug_select()
    {
        if ( level.radiation.instances.size == 0 )
        {
            return;
        }
        
        player = level.players[ 0 ];
        forward = anglestoforward( player getplayerangles() );
        trace = trace::ray_trace( player geteye(), player geteye() + forward * 150000 );
        
        if ( isdefined( trace[ "<dev string:x576>" ] ) && isdefined( trace[ "<dev string:x57f>" ] ) && trace[ "<dev string:x57f>" ] < 1 )
        {
            level.radiation.instances = sortbydistance( level.radiation.instances, trace[ "<dev string:x576>" ] );
            level.radiation.debug_selected = level.radiation.instances[ 0 ];
            return;
        }
        
        level.radiation.debug_selected = undefined;
    }

    // Namespace radiation / scripts\cp_mp\radiation
    // Params 0
    // Checksum 0x0, Offset: 0x1931
    // Size: 0x18, Type: dev
    function function_8203c9bd3f33309e()
    {
        level.radiation.debug_selected = undefined;
    }

    // Namespace radiation / scripts\cp_mp\radiation
    // Params 0
    // Checksum 0x0, Offset: 0x1951
    // Size: 0x42, Type: dev
    function function_ff46c564f2ccba22()
    {
        if ( !isdefined( level.radiation.debug_selected ) )
        {
            iprintlnbold( "<dev string:x588>" );
            return;
        }
        
        level.radiation.debug_selected destroy();
    }

    // Namespace radiation / scripts\cp_mp\radiation
    // Params 1
    // Checksum 0x0, Offset: 0x199b
    // Size: 0x139, Type: dev
    function function_dcd293b3ab646634( params )
    {
        if ( !isdefined( level.radiation.debug_selected ) )
        {
            iprintlnbold( "<dev string:x5b2>" );
            return;
        }
        
        direction = params[ 0 ];
        dist = int( params[ 1 ] );
        time = int( params[ 2 ] );
        offset = ( 0, 0, 0 );
        
        switch ( direction )
        {
            case #"hash_f96ec5f6bcd1b209":
                offset = ( 0, dist, 0 );
                break;
            case #"hash_f96ec4f6bcd1b076":
                offset = ( dist, 0, 0 );
                break;
            case #"hash_f95bc1f6bcc2a133":
                offset = ( 0, dist * -1, 0 );
                break;
            case #"hash_f95bc0f6bcc29fa0":
                offset = ( dist * -1, 0, 0 );
                break;
        }
        
        level.radiation.debug_selected transform( level.radiation.debug_selected.origin + offset, level.radiation.debug_selected.radius, time );
    }

    // Namespace radiation / scripts\cp_mp\radiation
    // Params 1
    // Checksum 0x0, Offset: 0x1adc
    // Size: 0xaf, Type: dev
    function function_78a309e6d9473c1a( params )
    {
        if ( !isdefined( level.radiation.debug_selected ) )
        {
            iprintlnbold( "<dev string:x5e6>" );
            return;
        }
        
        increase = int( params[ 0 ] );
        time = int( params[ 1 ] );
        level.radiation.debug_selected transform( level.radiation.debug_selected.origin, level.radiation.debug_selected.radius + increase, time );
    }

    // Namespace radiation / scripts\cp_mp\radiation
    // Params 0
    // Checksum 0x0, Offset: 0x1b93
    // Size: 0x65, Type: dev
    function function_329a7f5688224786()
    {
        if ( !isdefined( level.radiation.debug_selected ) )
        {
            iprintlnbold( "<dev string:x60e>" );
            return;
        }
        
        level.radiation.debug_selected.var_75186cfe05cecd50 = !istrue( level.radiation.debug_selected.var_75186cfe05cecd50 );
    }

    // Namespace radiation / scripts\cp_mp\radiation
    // Params 0
    // Checksum 0x0, Offset: 0x1c00
    // Size: 0x65, Type: dev
    function function_3b86c53c8320156b()
    {
        if ( !isdefined( level.radiation.debug_selected ) )
        {
            iprintlnbold( "<dev string:x668>" );
            return;
        }
        
        level.radiation.debug_selected.var_a2aa25ea43b31d54 = !istrue( level.radiation.debug_selected.var_a2aa25ea43b31d54 );
    }

    // Namespace radiation / scripts\cp_mp\radiation
    // Params 0
    // Checksum 0x0, Offset: 0x1c6d
    // Size: 0x65, Type: dev
    function function_37df17632b76cff3()
    {
        if ( !isdefined( level.radiation.debug_selected ) )
        {
            iprintlnbold( "<dev string:x6e5>" );
            return;
        }
        
        level.radiation.debug_selected.var_208cf23d5ed8f1f4 = !istrue( level.radiation.debug_selected.var_208cf23d5ed8f1f4 );
    }

    // Namespace radiation / scripts\cp_mp\radiation
    // Params 1
    // Checksum 0x0, Offset: 0x1cda
    // Size: 0x57, Type: dev
    function function_f1ce2bcb6075f617( params )
    {
        if ( !isdefined( level.radiation.debug_selected ) )
        {
            iprintlnbold( "<dev string:x752>" );
            return;
        }
        
        level.radiation.debug_selected.var_a292f5812d40eb56 = int( params[ 0 ] );
    }

#/
