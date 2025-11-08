#using script_595089f78ef8e11b;
#using script_686729055b66c6e4;
#using scripts\aitypes\bt_util;
#using scripts\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace zombie_base_abom_crawler;

// Namespace zombie_base_abom_crawler / namespace_757f0fc2fc31608f
// Params 0
// Checksum 0x0, Offset: 0x3bc
// Size: 0x84
function init_zombie_base_abom_crawler()
{
    if ( flag( "init_zombie_base_abom_crawler" ) )
    {
        return;
    }
    
    flag_set( "init_zombie_base_abom_crawler" );
    callback::add( "on_zombie_base_abom_crawler_spawned", &on_zombie_base_abom_crawler_spawned );
    callback::add( "on_zombie_base_abom_crawler_hvt_spawned", &on_zombie_base_abom_crawler_spawned );
    callback::add( "on_zombie_base_abom_crawler_nest_spawned", &on_zombie_base_abom_crawler_spawned );
    level._effect[ "zombie_base_abom_crawler_explode" ] = loadfx( "vfx/jup/ob/gameplay/zm_ai/vfx_megabomb_crawler_exp.vfx" );
    level._effect[ "zombie_base_abom_crawler_aoe" ] = loadfx( "vfx/jup/ob/gameplay/zm_ai/vfx_megabomb_crawler_aoe.vfx" );
}

// Namespace zombie_base_abom_crawler / namespace_757f0fc2fc31608f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x448
// Size: 0x5a
function private on_zombie_base_abom_crawler_spawned( params )
{
    thread_on_notify( "bmeleestarted", &function_322d8cb834021eb0 );
    thread_on_notify( "explode_death", &function_ec481db6f0a4e653 );
    callback::add( "on_zombie_ai_damaged", &function_13da6f593406ec4d );
    self.var_fe9174386ff8b1f = 1;
    scripts\aitypes\zombie_base\zombie_base_dismemberment::set_crawling( 1 );
    thread wander_listener();
}

// Namespace zombie_base_abom_crawler / namespace_757f0fc2fc31608f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4aa
// Size: 0x75
function private function_13da6f593406ec4d( dmg_struct )
{
    if ( isdefined( dmg_struct.smeansofdeath ) && dmg_struct.smeansofdeath == "MOD_EXPLOSIVE" || dmg_struct.smeansofdeath == "MOD_EXPLOSIVE_BULLET" || dmg_struct.smeansofdeath == "MOD_GRENADE_SPLASH" || dmg_struct.smeansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        function_ec481db6f0a4e653();
    }
}

// Namespace zombie_base_abom_crawler / namespace_757f0fc2fc31608f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x527
// Size: 0x2c
function private function_322d8cb834021eb0()
{
    self notify( "ambientvoxshutdown" );
    utility::function_3ab9164ef76940fd( "explode", "charge" );
    utility::function_3ab9164ef76940fd( "audio_explode", "rise" );
}

// Namespace zombie_base_abom_crawler / namespace_757f0fc2fc31608f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x55b
// Size: 0x89
function private function_ec481db6f0a4e653()
{
    self notify( "ambientvoxshutdown" );
    playfx( level._effect[ "zombie_base_abom_crawler_explode" ], self.origin );
    playfx( level._effect[ "zombie_base_abom_crawler_aoe" ], self.origin );
    utility::function_3ab9164ef76940fd( "audio_explode", "explode" );
    thread function_5b62af1eb5b04cc9( self.origin, self.team );
    wait 0.2;
    self.nocorpse = 1;
    self kill();
}

// Namespace zombie_base_abom_crawler / namespace_757f0fc2fc31608f
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5ec
// Size: 0x1ed
function private function_5b62af1eb5b04cc9( position, friendly_team )
{
    damage_source = spawn_script_origin();
    time_interval = 0.5;
    var_4806892e9b0b79ef = 3.5;
    aoe_radius = self.zombieaisettings.var_e58a65b7a8f5973c.explosionradius;
    damage_tick = self.zombieaisettings.var_e58a65b7a8f5973c.damagetick;
    initial_damage = self.zombieaisettings.var_e58a65b7a8f5973c.var_7513f0bfecf33e43;
    time_counter = 0;
    
    while ( time_counter <= var_4806892e9b0b79ef )
    {
        /#
            if ( function_8320c7d13584d021() )
            {
                sphere( position, aoe_radius, ( 1, 0, 0 ) );
            }
        #/
        
        target_query = physics_querypoint( position, aoe_radius, physics_createcontents( [ "physicscontents_characterproxy" ] ), [ self ], "physicsquery_all" );
        
        foreach ( potential_target in target_query )
        {
            target_ent = potential_target[ "entity" ];
            
            if ( !isalive( target_ent ) || target_ent.team == friendly_team )
            {
                continue;
            }
            
            if ( isai( potential_target ) )
            {
                if ( potential_target.type == "zombie" )
                {
                    potential_target namespace_ed7c38f3847343dc::stun_ai( time_interval );
                }
            }
            
            damage = ter_op( time_counter == 0, initial_damage, damage_tick );
            target_ent dodamage( damage, position, damage_source );
        }
        
        wait time_interval;
        time_counter += time_interval;
    }
    
    damage_source delete();
}

// Namespace zombie_base_abom_crawler / namespace_757f0fc2fc31608f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x7e1
// Size: 0x46
function private wander_listener()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "wander_start" );
        self._blackboard.zombiewanderorigin = self.origin;
        thread function_3ef8c54a29b98522();
        self waittill( "wander_end" );
    }
}

// Namespace zombie_base_abom_crawler / namespace_757f0fc2fc31608f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x82f
// Size: 0x9b
function private function_3ef8c54a29b98522()
{
    self endon( "death" );
    self endon( "wander_end" );
    search_time = 10;
    wait search_time;
    
    if ( isdefined( self.abom_parent ) )
    {
        var_15ac5500f542090d = distance2dsquared( self.abom_parent.origin, self.origin );
        var_62733f9f4971379d = 1500;
        
        if ( var_15ac5500f542090d > var_62733f9f4971379d * var_62733f9f4971379d )
        {
            self kill();
        }
        
        self._blackboard.zombiewanderorigin = self.abom_parent.origin;
    }
}

// Namespace zombie_base_abom_crawler / namespace_757f0fc2fc31608f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x8d2
// Size: 0xc0
function private function_6e789d7df8701ad3()
{
    ambient_cap = 3;
    self endon( "death" );
    self endon( "ambientvoxshutdown" );
    wait randomfloatrange( 1, 3 );
    played_vox = 0;
    
    while ( true )
    {
        if ( isdefined( self.movemode ) && self.movemode == "stop" )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( level.zombie_ambient_count ) )
        {
            level.zombie_ambient_count++;
            
            if ( level.zombie_ambient_count < ambient_cap )
            {
                played_vox = 1;
                level thread play_vox( self, "ambient_normal", "vox_ai_abom_crawl_ambient", 1 );
            }
        }
        
        if ( played_vox )
        {
            played_vox = 0;
            wait randomfloatrange( 0.1, 0.3 );
            continue;
        }
        
        wait 0.1;
    }
}

/#

    // Namespace zombie_base_abom_crawler / namespace_757f0fc2fc31608f
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x99a
    // Size: 0x17, Type: dev
    function private function_8320c7d13584d021()
    {
        return getdvarint( @"hash_1b61c9ce76ad3a4e", 0 ) > 0;
    }

#/
