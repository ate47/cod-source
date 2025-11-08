#using script_102d83a437e2b29f;
#using script_3a8f9ace195c9da9;
#using script_78ee1f1787a2e6a4;
#using scripts\anim\squadmanager;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_weapon;
#using scripts\cp\spawning;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;

#namespace namespace_d273e883d01a4b27;

// Namespace namespace_d273e883d01a4b27 / namespace_b074a5fd49b3fe05
// Params 3
// Checksum 0x0, Offset: 0x1bc
// Size: 0xca
function function_6c94dd363a86d105( var_1792ca970eb0f4e5, helient, var_81278c011ef98d00 )
{
    var_a8f8fe6b253e8a30 = getstruct( var_1792ca970eb0f4e5, "targetname" );
    tag_origin = helient gettagorigin( "tag_flare" );
    var_538f57ec682de299 = var_a8f8fe6b253e8a30.origin - tag_origin;
    var_e502f62c88d032a0 = ( var_538f57ec682de299[ 0 ], var_538f57ec682de299[ 1 ] * -1, var_538f57ec682de299[ 2 ] );
    var_81278c011ef98d00 linktomoveoffset( helient, "tag_flare", var_e502f62c88d032a0, ( 0, 180, 0 ) );
    var_81278c011ef98d00 playerlinkedoffsetenable();
    var_81278c011ef98d00 fixlinktointerpolationbug( 1 );
    var_81278c011ef98d00._blackboard.linkedtovehicle = 1;
    var_81278c011ef98d00 animmode( "angle deltas" );
}

// Namespace namespace_d273e883d01a4b27 / namespace_b074a5fd49b3fe05
// Params 1
// Checksum 0x0, Offset: 0x28e
// Size: 0x1b9
function function_b93dc4966b6ac70d( var_1792ca970eb0f4e5 )
{
    flag_wait( "player_spawned_with_loadout" );
    teleport_struct = getstruct( var_1792ca970eb0f4e5, "targetname" );
    ally = teleport_struct function_9e1d2e1df08f11ad();
    
    if ( !isdefined( ally ) )
    {
        return;
    }
    
    ally setcandamage( 1 );
    ally.name = "Soap";
    ally.animname = "overwatch_ally";
    ally.team = "allies";
    ally.ignoreme = 1;
    ally.goalradius = 1;
    ally set_movement_speed( 0 );
    ally.agentname = &"CP_JUP_DAM/SOAP";
    ally.health = 999999999;
    ally.maxhealth = 999999999;
    ally.var_e0143f4f183d8a12 = 1;
    ally function_9215ce6fc83759b9( 7000 );
    primaryweaponhash = "iw9_ar_mike4_mp, [ laserir_box ], none, none";
    
    if ( !isdefined( level.var_67b54180a55f70e1[ primaryweaponhash ] ) )
    {
        level.var_67b54180a55f70e1[ primaryweaponhash ] = scripts\cp\cp_weapon::function_e83615f8a92e4378( "iw9_ar_mike4_mp", [ "laserir_box" ], "none", "none" );
    }
    
    ally.weapon = level.var_67b54180a55f70e1[ primaryweaponhash ];
    ally giveweapon( ally.weapon );
    ally setspawnweapon( ally.weapon );
    ally.bulletsinclip = weaponclipsize( ally.weapon );
    ally.primaryweapon = ally.weapon;
    ally allowedstances( "stand" );
    return ally;
}

// Namespace namespace_d273e883d01a4b27 / namespace_b074a5fd49b3fe05
// Params 1
// Checksum 0x0, Offset: 0x450
// Size: 0x18
function function_9e1d2e1df08f11ad( forcespawn )
{
    function_633165d9faaae73b();
    return function_bf9eb3e39aa854d();
}

// Namespace namespace_d273e883d01a4b27 / namespace_b074a5fd49b3fe05
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x471
// Size: 0x10f
function private function_bf9eb3e39aa854d( forcespawn )
{
    aitype = level.aitypes[ "hero_soap" ].agent_type;
    var_44c998e27e126507 = scripts\mp\mp_agent::spawnnewagentaitype( aitype, self.origin, self.angles );
    
    if ( !isdefined( var_44c998e27e126507 ) )
    {
        return undefined;
    }
    
    thread namespace_1170726b2799ea65::function_4576aecf9d0c4082( var_44c998e27e126507 );
    var_44c998e27e126507 ai::spawner_fields( self );
    var_44c998e27e126507 scripts\cp\spawning::function_bcd664c7997b7469( self );
    
    if ( !var_44c998e27e126507 is_specified_unittype( "civilian" ) )
    {
        var_44c998e27e126507 thread scripts\anim\squadmanager::addtosquad();
    }
    
    self.aitype = aitype;
    var_44c998e27e126507 scripts\cp\spawning::function_1329b355d73712f( undefined, self );
    var_44c998e27e126507 scripts\cp\spawning::function_389fff85c076f49e();
    
    if ( isdefined( var_44c998e27e126507.target ) && !isdefined( var_44c998e27e126507.script_moveoverride ) )
    {
        node = scripts\cp\spawning::get_next_node_array();
        var_44c998e27e126507 thread scripts\cp\spawning::go_to_node( node );
    }
    
    if ( isdefined( self.spawn_funcs ) )
    {
        var_44c998e27e126507.spawn_funcs = self.spawn_funcs;
    }
    
    var_44c998e27e126507 thread function_b742d2da5a20db26();
    return var_44c998e27e126507;
}

// Namespace namespace_d273e883d01a4b27 / namespace_b074a5fd49b3fe05
// Params 0
// Checksum 0x0, Offset: 0x589
// Size: 0x16
function function_633165d9faaae73b()
{
    if ( !istrue( level.var_61198536443ad7ec ) )
    {
        function_f982e82bbd03d707();
    }
}

// Namespace namespace_d273e883d01a4b27 / namespace_b074a5fd49b3fe05
// Params 0
// Checksum 0x0, Offset: 0x5a7
// Size: 0x30a
function function_b742d2da5a20db26()
{
    team = self.team;
    
    if ( isdefined( team ) )
    {
        if ( !isdefined( level.spawn_funcs ) )
        {
            level.spawn_funcs = [];
        }
        
        if ( !isdefined( level.spawn_funcs[ team ] ) )
        {
            level.spawn_funcs[ team ] = [];
        }
        
        for ( i = 0; i < level.spawn_funcs[ team ].size ; i++ )
        {
            func = level.spawn_funcs[ team ][ i ];
            
            if ( isdefined( func[ "param5" ] ) )
            {
                thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ], func[ "param3" ], func[ "param4" ], func[ "param5" ] );
                continue;
            }
            
            if ( isdefined( func[ "param4" ] ) )
            {
                thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ], func[ "param3" ], func[ "param4" ] );
                continue;
            }
            
            if ( isdefined( func[ "param3" ] ) )
            {
                thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ], func[ "param3" ] );
                continue;
            }
            
            if ( isdefined( func[ "param2" ] ) )
            {
                thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ] );
                continue;
            }
            
            if ( isdefined( func[ "param1" ] ) )
            {
                thread [[ func[ "function" ] ]]( func[ "param1" ] );
                continue;
            }
            
            thread [[ func[ "function" ] ]]();
        }
    }
    
    if ( !isdefined( self.spawn_funcs ) )
    {
        if ( !isdefined( self.script_suspend ) )
        {
            self.spawner = undefined;
        }
        
        return;
    }
    
    for ( i = 0; i < self.spawn_funcs.size ; i++ )
    {
        func = self.spawn_funcs[ i ];
        
        if ( isdefined( func[ "param5" ] ) )
        {
            thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ], func[ "param3" ], func[ "param4" ], func[ "param5" ] );
            continue;
        }
        
        if ( isdefined( func[ "param4" ] ) )
        {
            thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ], func[ "param3" ], func[ "param4" ] );
            continue;
        }
        
        if ( isdefined( func[ "param3" ] ) )
        {
            thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ], func[ "param3" ] );
            continue;
        }
        
        if ( isdefined( func[ "param2" ] ) )
        {
            thread [[ func[ "function" ] ]]( func[ "param1" ], func[ "param2" ] );
            continue;
        }
        
        if ( isdefined( func[ "param1" ] ) )
        {
            thread [[ func[ "function" ] ]]( func[ "param1" ] );
            continue;
        }
        
        thread [[ func[ "function" ] ]]();
    }
    
    /#
        self.var_5295f7f174b863a6 = self.spawn_funcs;
    #/
    
    self.spawn_funcs = undefined;
    
    /#
        self.spawn_funcs = self.var_5295f7f174b863a6;
        self.var_5295f7f174b863a6 = undefined;
    #/
    
    if ( !isdefined( self.script_suspend ) )
    {
        self.spawner = undefined;
    }
}

