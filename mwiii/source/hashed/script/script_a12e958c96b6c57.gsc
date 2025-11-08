#using script_16ea1b94f0f381b3;
#using scripts\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace zombie_emergence_spawning;

// Namespace zombie_emergence_spawning / namespace_d30035ccbf6888e3
// Params 2
// Checksum 0x0, Offset: 0x104
// Size: 0xa0
function register_emergence_spawning_settings( var_6e0fb0c557889b56, var_2411f6b1a46295a6 )
{
    function_8abb92a7be2335d4( var_6e0fb0c557889b56 );
    self.var_57f34b07b40854e8 = [];
    self._blackboard.var_955e413d1be8201a = 1;
    self._blackboard.var_c6d286a55d32d53 = 0;
    self._blackboard.var_931d1d458f955826 = 0;
    self._blackboard.var_7ed3358141280e35 = 0;
    self._blackboard.var_c5cb03878d899c0d = var_2411f6b1a46295a6;
    callback::add( "killed_body_cloned", &function_8e6ae0f9fd3a8de2 );
}

// Namespace zombie_emergence_spawning / namespace_d30035ccbf6888e3
// Params 1
// Checksum 0x0, Offset: 0x1ac
// Size: 0x21
function function_e8880a314e127af9( var_e3ff174a3bff8b41 )
{
    self.var_57f34b07b40854e8[ self.var_57f34b07b40854e8.size ] = var_e3ff174a3bff8b41;
}

// Namespace zombie_emergence_spawning / namespace_d30035ccbf6888e3
// Params 1
// Checksum 0x0, Offset: 0x1d5
// Size: 0x37
function function_3cebd1a2fee6b2c3( value )
{
    if ( isdefined( self._blackboard.var_955e413d1be8201a ) )
    {
        self._blackboard.var_931d1d458f955826 = value;
    }
}

// Namespace zombie_emergence_spawning / namespace_d30035ccbf6888e3
// Params 1
// Checksum 0x0, Offset: 0x214
// Size: 0x4f
function function_abed6225e0fce55c( params )
{
    if ( isdefined( self._blackboard.var_c6d286a55d32d53 ) && !self._blackboard.var_c6d286a55d32d53 )
    {
        self._blackboard.var_c6d286a55d32d53 = 1;
    }
}

// Namespace zombie_emergence_spawning / namespace_d30035ccbf6888e3
// Params 1
// Checksum 0x0, Offset: 0x26b
// Size: 0x4f
function disable_emergence_spawning( params )
{
    if ( isdefined( self._blackboard.var_c6d286a55d32d53 ) && istrue( self._blackboard.var_c6d286a55d32d53 ) )
    {
        self._blackboard.var_c6d286a55d32d53 = 0;
    }
}

// Namespace zombie_emergence_spawning / namespace_d30035ccbf6888e3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2c2
// Size: 0x61
function private function_8abb92a7be2335d4( var_6e0fb0c557889b56 )
{
    foreach ( var_8e5735736895a5ec in var_6e0fb0c557889b56 )
    {
        self function_c6007f7404057c67( var_8e5735736895a5ec.aisubclass );
    }
}

// Namespace zombie_emergence_spawning / namespace_d30035ccbf6888e3
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x32b
// Size: 0x1af
function private function_8e6ae0f9fd3a8de2( params )
{
    if ( self.var_57f34b07b40854e8.size > 0 )
    {
        var_4649381dc3b0c600 = [];
        
        foreach ( var_e1f6564425e3da6d in self.var_57f34b07b40854e8 )
        {
            var_4649381dc3b0c600[ var_4649381dc3b0c600.size ] = var_e1f6564425e3da6d;
        }
    }
    
    params.body waittill( "emergence_spawn", var_12f08b5cb2718d76, tag, alias );
    
    if ( isdefined( var_4649381dc3b0c600 ) )
    {
        foreach ( var_e1f6564425e3da6d in var_4649381dc3b0c600 )
        {
            [[ var_e1f6564425e3da6d ]]( params.body, var_12f08b5cb2718d76 );
        }
    }
    
    aitypes = get_aitype_by_subclass_sharedfunc( var_12f08b5cb2718d76 );
    spawnangles = params.body gettagangles( tag );
    zombie = spawnnewaitype_sharedfunc( aitypes[ 0 ], params.body.origin, spawnangles, params.body.team );
    zombie thread animscripted_sharedfunc( alias, alias, params.body.origin, spawnangles );
    zombie linkto( params.body, "tag_origin" );
    zombie waittill( "unlink_spawned_ai" );
    zombie unlink();
}

/#

    // Namespace zombie_emergence_spawning / namespace_d30035ccbf6888e3
    // Params 0
    // Checksum 0x0, Offset: 0x4e2
    // Size: 0x30, Type: dev
    function function_71fb46ec2e0bf63()
    {
        function_6e7290c8ee4f558b( "<dev string:x1c>" );
        function_a9a864379a098ad6( "<dev string:x43>", "<dev string:x66>", &function_572d7a042e2d9309, 1 );
        function_fe953f000498048f();
    }

    // Namespace zombie_emergence_spawning / namespace_d30035ccbf6888e3
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x51a
    // Size: 0x97, Type: dev
    function private function_572d7a042e2d9309()
    {
        zombies = getaispeciesarray( "<dev string:x83>", "<dev string:x8a>" );
        closest_zombie = scripts\engine\utility::get_array_of_closest( level.players[ 0 ].origin, zombies )[ 0 ];
        
        if ( !isdefined( closest_zombie ) || !isalive( closest_zombie ) || isdefined( closest_zombie ) && !isdefined( closest_zombie._blackboard.var_955e413d1be8201a ) )
        {
            return;
        }
        
        closest_zombie function_3cebd1a2fee6b2c3( !closest_zombie._blackboard.var_931d1d458f955826 );
    }

#/
