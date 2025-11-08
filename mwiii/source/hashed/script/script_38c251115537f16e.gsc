#using script_1243911b5893214a;
#using script_7edf952f8921aa6b;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;

#namespace zombie_melee;

// Namespace zombie_melee / namespace_f025828c76741718
// Params 0
// Checksum 0x0, Offset: 0x1af
// Size: 0x22
function function_8e401d26d58bc32d()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &function_2423853525ee87d7 );
}

// Namespace zombie_melee / namespace_f025828c76741718
// Params 0
// Checksum 0x0, Offset: 0x1d9
// Size: 0x18
function function_265e0e58c950559()
{
    thread function_e87d981fe3e432d6();
    self.var_b32061fbf4f14999 = &function_b32061fbf4f14999;
}

// Namespace zombie_melee / namespace_f025828c76741718
// Params 7
// Checksum 0x0, Offset: 0x1f9
// Size: 0x115
function function_e700d8944532443d( damage_amount, range, var_6a3d37541ccb42e7, var_2c1d789f7a25cad1, always_knockback, knockback_strength, var_7921c0704abad1a3 )
{
    assert( isdefined( range ) );
    self.melee_damage = default_to( damage_amount, 30 );
    self.var_8b184e6eade0bc4f = self.melee_damage;
    self.melee_range = range;
    self.var_4c9b344b1a95200 = default_to( var_6a3d37541ccb42e7, 1 );
    self.var_2c1d789f7a25cad1 = var_2c1d789f7a25cad1;
    self.always_knockback = always_knockback;
    self.knockback_strength = knockback_strength;
    self.var_7921c0704abad1a3 = var_7921c0704abad1a3;
    self._blackboard.zombiemeleerange = int( self.melee_range );
    self._blackboard.var_94f78603f930cce6 = 90;
    self._blackboard.var_5b09efabac175a4c = 64;
    function_2576f3b996c15ad( "melee_range", self.melee_range );
}

// Namespace zombie_melee / namespace_f025828c76741718
// Params 2
// Checksum 0x0, Offset: 0x316
// Size: 0x39
function function_1fc0eb1eb90c8dd0( movetype, range_override )
{
    self.var_5b7cb9371ba53dc8 = default_to( self.var_5b7cb9371ba53dc8, [] );
    self.var_5b7cb9371ba53dc8[ movetype ] = range_override;
}

// Namespace zombie_melee / namespace_f025828c76741718
// Params 1
// Checksum 0x0, Offset: 0x357
// Size: 0x83
function function_2423853525ee87d7( params )
{
    if ( isdefined( self._blackboard.movetype ) && isdefined( self.var_5b7cb9371ba53dc8 ) && isdefined( self.var_5b7cb9371ba53dc8[ self._blackboard.movetype ] ) )
    {
        self._blackboard.var_94f78603f930cce6 = self.var_5b7cb9371ba53dc8[ self._blackboard.movetype ];
    }
}

// Namespace zombie_melee / namespace_f025828c76741718
// Params 2
// Checksum 0x0, Offset: 0x3e2
// Size: 0x70
function request_melee( var_eb9973984c6db0df, var_f261c2f31d7de033 )
{
    self.var_a7e7a5cbca185094 = var_eb9973984c6db0df;
    
    if ( !isdefined( var_f261c2f31d7de033 ) )
    {
        var_f261c2f31d7de033 = function_3529beadf9e07df8();
    }
    
    if ( !isdefined( self.var_f261c2f31d7de033 ) || self.var_f261c2f31d7de033 != var_f261c2f31d7de033 )
    {
        self.var_f261c2f31d7de033 = var_f261c2f31d7de033;
        callback::callback( "on_is_moving_melee_changed" );
    }
    
    callback::callback( "on_is_melee_started" );
    function_e725cd043cf58ebb();
}

// Namespace zombie_melee / namespace_f025828c76741718
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x45a
// Size: 0x227
function private function_b32061fbf4f14999( msg )
{
    assert( isdefined( self.melee_range ) && isdefined( self.melee_damage ) );
    var_eb9973984c6db0df = self.var_a7e7a5cbca185094;
    melee_damage = self.melee_damage;
    
    if ( isai( var_eb9973984c6db0df ) )
    {
        melee_damage = int( melee_damage * self.var_4c9b344b1a95200 );
    }
    
    params = spawnstruct();
    params.meleetarget = var_eb9973984c6db0df;
    params.meleedamage = melee_damage;
    callback::callback( "zombie_melee_pre", params );
    hit_ent = self melee( undefined, melee_damage, self.melee_range, 16, 16 );
    self._blackboard.var_648f4849d921b37c = !isdefined( hit_ent );
    params = spawnstruct();
    params.damage = melee_damage;
    params.origin = self.origin + anglestoforward( self.angles ) * self.melee_range * 0.5 + ( 0, 0, 1 ) * self.height * 0.5;
    params.radius = self.melee_range * 0.5;
    params.meansofdeath = "MOD_MELEE";
    
    if ( isdefined( hit_ent ) && self.var_2c1d789f7a25cad1 && ( isai( hit_ent ) || isplayer( hit_ent ) ) )
    {
        if ( self.always_knockback || isdefined( msg ) && msg == "knockback" )
        {
            hit_ent knockback_flat( hit_ent.origin - self.origin, self.knockback_strength );
        }
    }
    
    /#
        recordsphere( params.origin, 5, ( 1, 0, 0 ) );
    #/
    
    callback::callback( "damage_point", params );
    params = spawnstruct();
    params.meleehitent = hit_ent;
    callback::callback( "zombie_melee", params );
}

// Namespace zombie_melee / namespace_f025828c76741718
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x689
// Size: 0x108
function private function_e87d981fe3e432d6()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "bmeleestarted" );
        
        if ( self.var_7921c0704abad1a3 )
        {
            set( "melee_pain", "pain", 0 );
        }
        
        if ( isdefined( self._blackboard.meleerequestedtarget ) )
        {
            var_eb9973984c6db0df = self._blackboard.meleerequestedtarget;
        }
        else if ( isdefined( self._blackboard.zombieattackpoint ) )
        {
            var_eb9973984c6db0df = self._blackboard.zombieattackpoint;
        }
        else
        {
            var_eb9973984c6db0df = self.enemy;
        }
        
        request_melee( var_eb9973984c6db0df, self._blackboard.zombiemeleeismoving );
        thread function_b10cf3d9f8a0a94();
        self waittill( "bmeleeended" );
        
        if ( self.var_7921c0704abad1a3 )
        {
            set( "melee_pain", "pain", 1 );
        }
        
        self.var_a7a6441b0e218a8a = 0;
        self.in_melee = 0;
    }
}

// Namespace zombie_melee / namespace_f025828c76741718
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x799
// Size: 0x46
function private function_b10cf3d9f8a0a94()
{
    self endon( "death" );
    self endon( "bmeleeended" );
    
    while ( true )
    {
        self waittill( "hit_melee", msg );
        
        if ( isdefined( self.var_b32061fbf4f14999 ) )
        {
            [[ self.var_b32061fbf4f14999 ]]( msg );
        }
    }
}

// Namespace zombie_melee / namespace_f025828c76741718
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x7e7
// Size: 0x26, Type: bool
function private function_3529beadf9e07df8()
{
    return lengthsquared( self.velocity ) > squared( getdvarint( @"hash_b17a9432a377356d", 65 ) );
}

