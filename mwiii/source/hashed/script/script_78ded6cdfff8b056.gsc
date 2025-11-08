#using script_3b78d23dad7ec5be;
#using scripts\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\values;
#using scripts\engine\utility;

#namespace namespace_23065dd8923d8d1e;

// Namespace namespace_23065dd8923d8d1e / namespace_9bdb6600db5e24a4
// Params 0
// Checksum 0x0, Offset: 0x1ca
// Size: 0x42
function function_7dcdb0119cb801c6()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &on_damaged );
    callback::get_template( self.animsetname ) callback::add( "on_is_crawling_changed", &function_16dad04a21a0f9cf );
}

// Namespace namespace_23065dd8923d8d1e / namespace_9bdb6600db5e24a4
// Params 0
// Checksum 0x0, Offset: 0x214
// Size: 0x7c
function init_pain()
{
    function_16dad04a21a0f9cf();
    self.var_2379db736392918f = 0;
    self.var_bb4ae283eb0dc296 = gettime();
    self.var_87ece69176942e3c = self.health * 0.15;
    self.var_8f2185fcccf61bdb = self.health * 0.075;
    self.var_38f29f59521de99a = gettime();
    level.var_53e3d9850cd60ff8 = default_to( level.var_53e3d9850cd60ff8, gettime() );
}

// Namespace namespace_23065dd8923d8d1e / namespace_9bdb6600db5e24a4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x298
// Size: 0x155
function private on_damaged( params )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( function_adb7b3f940cde3b5( params.metabonename ) )
    {
        self function_3e89eb3d8e3f1811( "last_damage_hit_armor", 1 );
    }
    else
    {
        self clearaiblackboarddynamic( "last_damage_hit_armor" );
    }
    
    if ( isexplosivedamagemod( params.smeansofdeath ) )
    {
        return;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" )
    {
        return;
    }
    
    if ( istrue( self._blackboard.zombieinstagger ) )
    {
        return;
    }
    
    if ( gettime() > self.var_bb4ae283eb0dc296 )
    {
        self.var_2379db736392918f = 0;
        self.var_bb4ae283eb0dc296 = gettime() + 5000;
    }
    
    self.var_2379db736392918f += params.idamage;
    
    if ( is_head( params.shitloc ) )
    {
        stagger();
        return;
    }
    
    if ( gettime() > self.var_38f29f59521de99a )
    {
        if ( function_8153209a5ebfc684( params.shitloc ) && self.var_2379db736392918f > self.var_8f2185fcccf61bdb )
        {
            stagger();
            return;
        }
        
        if ( self.var_2379db736392918f > self.var_87ece69176942e3c )
        {
            stagger();
        }
    }
}

// Namespace namespace_23065dd8923d8d1e / namespace_9bdb6600db5e24a4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3f5
// Size: 0x3a
function private function_16dad04a21a0f9cf( params )
{
    if ( scripts\aitypes\zombie_base\zombie_base_dismemberment::is_crawling() )
    {
        set( "pain", "pain", 0 );
        return;
    }
    
    val::reset( "pain", "pain" );
}

// Namespace namespace_23065dd8923d8d1e / namespace_9bdb6600db5e24a4
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x437
// Size: 0xa7
function private stagger()
{
    self notify( "stagger" );
    self endon( "stagger" );
    self endon( "death" );
    self._blackboard.zombieinstagger = 1;
    self.var_38f29f59521de99a = gettime() + 10000;
    self.var_2379db736392918f = 0;
    self.var_bb4ae283eb0dc296 = gettime() + 5000;
    self waittill( "stagger_end" );
    self.var_38f29f59521de99a = gettime() + 10000;
    self.var_2379db736392918f = 0;
    self.var_bb4ae283eb0dc296 = gettime() + 5000;
    self._blackboard.zombieinstagger = 0;
}

// Namespace namespace_23065dd8923d8d1e / namespace_9bdb6600db5e24a4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4e6
// Size: 0x6d
function private function_8153209a5ebfc684( location )
{
    switch ( location )
    {
        case #"hash_168c74e879f0ba11":
        case #"hash_1cbc508a2fe01b79":
        case #"hash_7b36142458a6c2d5":
        case #"hash_810a7426c8bac3ac":
        case #"hash_9536712388e65bce":
        case #"hash_a638fec9040cfcf4":
            return 1;
        default:
            return 0;
    }
}

// Namespace namespace_23065dd8923d8d1e / namespace_9bdb6600db5e24a4
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x55b
// Size: 0x49
function private is_head( location )
{
    switch ( location )
    {
        case #"hash_8a1772f5f912c880":
        case #"hash_92bbfe494d03d772":
        case #"hash_b107b5547c755d23":
            return 1;
        default:
            return 0;
    }
}

