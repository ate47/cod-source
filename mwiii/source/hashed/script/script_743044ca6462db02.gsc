#using script_5d813d45c6b1b1be;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\utility;

#namespace namespace_1ed614e30b49e2ed;

// Namespace namespace_1ed614e30b49e2ed / namespace_9b230bed5d2cbd7a
// Params 1
// Checksum 0x0, Offset: 0x24d
// Size: 0x119
function init( var_5179c48492d1d2c2 )
{
    function_efabc5ae0422de9e( var_5179c48492d1d2c2 );
    level._effect[ "vfx_mrp_bonfire" ] = loadfx( "vfx/jup/ob/gameplay/zm/vfx_zm_firepit_sm.vfx" );
    var_5179c48492d1d2c2.var_92ea5d02ebdbafaf = [];
    var_5179c48492d1d2c2.bonfire_struct = getstruct( var_5179c48492d1d2c2.target, "targetname" );
    var_5179c48492d1d2c2.bonfire_trigger = getstruct( var_5179c48492d1d2c2.bonfire_struct.target, "targetname" );
    hellhound_struct = getstruct( var_5179c48492d1d2c2.bonfire_trigger.target, "targetname" );
    var_5179c48492d1d2c2.reward_struct = getstruct( hellhound_struct.target, "targetname" );
    var_5179c48492d1d2c2.var_cfdd50d1363c2440 = namespace_8eedd8f6cf5d9f19::function_698513ab21b7913d( hellhound_struct );
    thread function_6bb52c1ccf10c874( var_5179c48492d1d2c2 );
    thread function_f7f26ad6ed8a5a9( var_5179c48492d1d2c2 );
    
    /#
        if ( getdvarint( @"hash_870b2b2720067cf9", 0 ) )
        {
            thread function_e7077708bf984b51( var_5179c48492d1d2c2 );
        }
    #/
}

// Namespace namespace_1ed614e30b49e2ed / namespace_9b230bed5d2cbd7a
// Params 1
// Checksum 0x0, Offset: 0x36e
// Size: 0x56
function function_f7f26ad6ed8a5a9( var_5179c48492d1d2c2 )
{
    var_5179c48492d1d2c2 endon( "MRP_BONFIRE_NOTIFY_SUCCESS" );
    
    while ( true )
    {
        var_5179c48492d1d2c2.var_cfdd50d1363c2440 waittill( "trigger", data );
        
        if ( data.classname == "actor_jup_spawner_zombie_hellhound" )
        {
            data thread function_f71c0dfb2a56fe9f( var_5179c48492d1d2c2 );
        }
    }
}

// Namespace namespace_1ed614e30b49e2ed / namespace_9b230bed5d2cbd7a
// Params 1
// Checksum 0x0, Offset: 0x3cc
// Size: 0x8d
function function_f71c0dfb2a56fe9f( var_5179c48492d1d2c2 )
{
    self notify( "MRP_BONFIRE_HELLHOUND_SINGLETON" );
    self endon( "MRP_BONFIRE_HELLHOUND_SINGLETON" );
    self waittill( "death", attacker );
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( distance( self.origin, var_5179c48492d1d2c2.bonfire_trigger.origin ) < 100 )
    {
        exploder( "mrpc_bonfire" );
        
        /#
            iprintlnbold( "<dev string:x1c>" );
        #/
        
        attacker thread function_5bc7e10e27f62a48( var_5179c48492d1d2c2 );
        var_5179c48492d1d2c2 notify( "MRP_BONFIRE_NOTIFY_SUCCESS" );
    }
}

// Namespace namespace_1ed614e30b49e2ed / namespace_9b230bed5d2cbd7a
// Params 1
// Checksum 0x0, Offset: 0x461
// Size: 0x1af
function function_6bb52c1ccf10c874( var_5179c48492d1d2c2 )
{
    var_5179c48492d1d2c2 endon( "MRP_BONFIRE_NOTIFY_SUCCESS" );
    
    while ( true )
    {
        scripts\cp_mp\utility\game_utility::createprojectilepartition();
        
        foreach ( projectile in level.projectilepartition function_99b7cb4906b8cb4f( var_5179c48492d1d2c2.origin ) )
        {
            if ( !isdefined( projectile ) )
            {
                waitframe();
                continue;
            }
            
            if ( !array_contains( [ "jup_thermite_ob", "jup_molotov_ob" ], projectile.weapon_name ) )
            {
                waitframe();
                continue;
            }
            
            if ( array_contains( var_5179c48492d1d2c2.var_92ea5d02ebdbafaf, projectile ) )
            {
                waitframe();
                continue;
            }
            
            if ( !isdefined( projectile.owner.origin ) )
            {
                waitframe();
                continue;
            }
            
            if ( distancesquared( projectile.owner.origin, var_5179c48492d1d2c2.bonfire_trigger.origin ) > 1000000 )
            {
                waitframe();
                continue;
            }
            
            if ( distancesquared( projectile.origin, var_5179c48492d1d2c2.bonfire_trigger.origin ) < var_5179c48492d1d2c2.bonfire_trigger.radius * var_5179c48492d1d2c2.bonfire_trigger.radius )
            {
                exploder( "mrpc_bonfire" );
                
                /#
                    iprintlnbold( "<dev string:x1c>" );
                #/
                
                projectile.owner thread function_5bc7e10e27f62a48( var_5179c48492d1d2c2 );
                var_5179c48492d1d2c2 notify( "MRP_BONFIRE_NOTIFY_SUCCESS" );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_1ed614e30b49e2ed / namespace_9b230bed5d2cbd7a
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x618
// Size: 0xd
function private function_cc3e13f38f81229()
{
    wait 15;
    self notify( "MRP_BONFIRE_NOTIFY_TIMEOUT" );
}

// Namespace namespace_1ed614e30b49e2ed / namespace_9b230bed5d2cbd7a
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x62d
// Size: 0x91
function private function_5fbea66198fd836a( projectile, owner )
{
    self endon( "MRP_BONFIRE_NOTIFY_TIMEOUT" );
    
    while ( true )
    {
        self.crouch_trigger waittill( "trigger", data );
        
        if ( isplayer( data ) && data == owner )
        {
            if ( istrue( data.watching_bonfire ) )
            {
                continue;
            }
            
            /#
                iprintlnbold( "<dev string:x2f>" );
            #/
            
            data.watching_bonfire = 1;
            data childthread function_3405018385bb58ed( self );
            data childthread function_8e4e6ef939444a94( self );
        }
        
        waitframe();
    }
}

// Namespace namespace_1ed614e30b49e2ed / namespace_9b230bed5d2cbd7a
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x6c6
// Size: 0x94
function private function_3405018385bb58ed( var_5179c48492d1d2c2 )
{
    self endon( "MRP_BONFIRE_NOTIFY_FAILURE" );
    start_time = gettime();
    
    while ( gettime() - start_time < 3000 )
    {
        var_5179c48492d1d2c2.crouch_trigger waittill( "trigger", data );
        
        if ( data == self )
        {
            self notify( "MRP_BONFIRE_NOTIFY_CONTINUE" );
        }
        
        wait 0.5;
    }
    
    /#
        iprintlnbold( "<dev string:x1c>" );
    #/
    
    thread function_5bc7e10e27f62a48( var_5179c48492d1d2c2 );
    var_5179c48492d1d2c2.crouch_trigger delete();
    var_5179c48492d1d2c2 notify( "MRP_BONFIRE_NOTIFY_SUCCESS" );
}

// Namespace namespace_1ed614e30b49e2ed / namespace_9b230bed5d2cbd7a
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x762
// Size: 0x43
function private function_5bc7e10e27f62a48( var_5179c48492d1d2c2 )
{
    var_5179c48492d1d2c2.var_cfdd50d1363c2440 delete();
    function_568b8a57e0fa955f( var_5179c48492d1d2c2, self );
    wait 2;
    namespace_8eedd8f6cf5d9f19::function_a4dfabe55dd4a652( self, var_5179c48492d1d2c2.reward_struct, "ob_jup_items_activity_mrp_bonfire" );
}

// Namespace namespace_1ed614e30b49e2ed / namespace_9b230bed5d2cbd7a
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x7ad
// Size: 0x5d
function private function_8e4e6ef939444a94( var_5179c48492d1d2c2 )
{
    self endon( "MRP_BONFIRE_NOTIFY_FAILURE" );
    
    while ( true )
    {
        result = waittill_any_timeout_1( 1, "MRP_BONFIRE_NOTIFY_CONTINUE" );
        
        if ( result == "timeout" )
        {
            /#
                iprintlnbold( "<dev string:x3e>" );
            #/
            
            self.watching_bonfire = undefined;
            self notify( "MRP_BONFIRE_NOTIFY_FAILURE" );
        }
    }
}

// Namespace namespace_1ed614e30b49e2ed / namespace_9b230bed5d2cbd7a
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x812
// Size: 0x4a
function private function_27c2d9e9caf7b6c5( var_5179c48492d1d2c2 )
{
    self endon( "MRP_BONFIRE_NOTIFY_FAILURE" );
    
    while ( true )
    {
        if ( self getstance() != "crouch" )
        {
            /#
                iprintlnbold( "<dev string:x3e>" );
            #/
            
            self.watching_bonfire = undefined;
            self notify( "MRP_BONFIRE_NOTIFY_FAILURE" );
        }
        
        waitframe();
    }
}

/#

    // Namespace namespace_1ed614e30b49e2ed / namespace_9b230bed5d2cbd7a
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x864
    // Size: 0x7f, Type: dev
    function private function_e7077708bf984b51( var_5179c48492d1d2c2 )
    {
        while ( true )
        {
            sphere( var_5179c48492d1d2c2.bonfire_trigger.origin, var_5179c48492d1d2c2.bonfire_trigger.radius, ( 0, 1, 0 ) );
            sphere( var_5179c48492d1d2c2.bonfire_trigger.origin, 1000, ( 1, 1, 0 ) );
            waitframe();
        }
    }

#/
