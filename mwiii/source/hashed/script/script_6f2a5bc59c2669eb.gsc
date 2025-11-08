#using script_2ece06910a5c572;
#using script_38c251115537f16e;
#using script_3b78d23dad7ec5be;
#using script_433375b6cbabfc47;
#using script_686729055b66c6e4;
#using script_7edf952f8921aa6b;
#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;

#namespace namespace_e5049f73842ac360;

/#

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 0
    // Checksum 0x0, Offset: 0xf8
    // Size: 0x31d, Type: dev
    function function_1f7bc5dd1e86ee1f()
    {
        waitframe();
        function_6e7290c8ee4f558b( "<dev string:x1c>" );
        priority = 20;
        function_b23a59dfb4ca49a1( "<dev string:x30>", "<dev string:x58>" + priority, &function_6aca4fbb47b31a61 );
        function_b23a59dfb4ca49a1( "<dev string:x80>", "<dev string:xa6>" + priority, &function_6aca4fbb47b31a61 );
        function_b23a59dfb4ca49a1( "<dev string:xcc>", "<dev string:xf1>" + priority, &function_6aca4fbb47b31a61 );
        function_b23a59dfb4ca49a1( "<dev string:x116>", "<dev string:x13e>" + priority, &function_6aca4fbb47b31a61 );
        function_b23a59dfb4ca49a1( "<dev string:x166>", "<dev string:x194>" + priority, &function_6aca4fbb47b31a61 );
        function_a9a864379a098ad6( "<dev string:x1c2>", "<dev string:x1ed>", &function_79e6bc2cbae5a949 );
        function_a9a864379a098ad6( "<dev string:x207>", "<dev string:x22a>", &function_1aaf94b6b4be4ec4 );
        level.var_f6c271f9f2c0fd8 = scripts\cp_mp\agents\agent_utils::function_8ca4e221673e423c();
        var_a559014c9ce72754 = function_83dcd153ba762bfa();
        function_a9a864379a098ad6( "<dev string:x245>", "<dev string:x265>", &function_233d42b214d5a6cd );
        
        foreach ( subclass, aitypes in level.var_f6c271f9f2c0fd8 )
        {
            spawn_name = default_to( var_a559014c9ce72754[ subclass ], subclass );
            
            if ( issubstr( subclass, "<dev string:x286>" ) )
            {
                function_b23a59dfb4ca49a1( "<dev string:x290>" + spawn_name, "<dev string:x29a>" + aitypes[ 0 ], &function_a252e2eb60d04623 );
                continue;
            }
            
            function_b23a59dfb4ca49a1( "<dev string:x2a7>" + spawn_name, "<dev string:x29a>" + aitypes[ 0 ], &function_a252e2eb60d04623 );
        }
        
        function_b23a59dfb4ca49a1( "<dev string:x2ba>", "<dev string:x2d2>", &function_958e5c5cb15de054 );
        function_b23a59dfb4ca49a1( "<dev string:x2df>", "<dev string:x2f8>", &function_958e5c5cb15de054 );
        function_a9a864379a098ad6( "<dev string:x305>", "<dev string:x329>", &function_cacc6088d6b42b34 );
        function_a9a864379a098ad6( "<dev string:x34a>", "<dev string:x364>", &function_e4acd0ee95b2b171 );
        function_a9a864379a098ad6( "<dev string:x37b>", "<dev string:x39b>", &function_bb2c7a7d908691b3 );
        function_a9a864379a098ad6( "<dev string:x3b3>", "<dev string:x3ca>", &ragdoll_all );
        function_b23a59dfb4ca49a1( "<dev string:x3d9>", "<dev string:x3f8>", &function_168f04942cd64395 );
        function_b23a59dfb4ca49a1( "<dev string:x41b>", "<dev string:x43b>", &function_168f04942cd64395 );
        function_b23a59dfb4ca49a1( "<dev string:x46b>", "<dev string:x489>", &function_168f04942cd64395 );
        function_b23a59dfb4ca49a1( "<dev string:x4bb>", "<dev string:x4d9>", &function_168f04942cd64395 );
        function_a9a864379a098ad6( "<dev string:x50a>", "<dev string:x52f>", &function_7d5de5e77bc3e95d );
        function_b23a59dfb4ca49a1( "<dev string:x545>", "<dev string:x564>", &function_b4ecf2809c2b8328 );
        function_b23a59dfb4ca49a1( "<dev string:x576>", "<dev string:x595>", &function_b4ecf2809c2b8328 );
        function_a9a864379a098ad6( "<dev string:x5a7>", "<dev string:x5c0>", &function_789810fa398850aa );
        function_a9a864379a098ad6( "<dev string:x5e0>", "<dev string:x5f7>", &function_db4932603c9f24eb );
        function_a9a864379a098ad6( "<dev string:x615>", "<dev string:x621>", &kill_all_zombies );
        function_b23a59dfb4ca49a1( "<dev string:x635>", "<dev string:x654>", &function_5e521f045efe7ec2 );
        function_fe953f000498048f();
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 0
    // Checksum 0x0, Offset: 0x41d
    // Size: 0xb0, Type: dev
    function function_83dcd153ba762bfa()
    {
        arr = [];
        arr[ "<dev string:x668>" ] = "<dev string:x677>";
        arr[ "<dev string:x681>" ] = "<dev string:x68c>";
        arr[ "<dev string:x697>" ] = "<dev string:x6a3>";
        arr[ "<dev string:x6af>" ] = "<dev string:x6cc>";
        arr[ "<dev string:x6e2>" ] = "<dev string:x6ff>";
        arr[ "<dev string:x715>" ] = "<dev string:x729>";
        arr[ "<dev string:x736>" ] = "<dev string:x745>";
        arr[ "<dev string:x754>" ] = "<dev string:x766>";
        arr[ "<dev string:x771>" ] = "<dev string:x781>";
        arr[ "<dev string:x78a>" ] = "<dev string:x79d>";
        arr[ "<dev string:x7a9>" ] = "<dev string:x7ba>";
        arr[ "<dev string:x7c4>" ] = "<dev string:x7d8>";
        return arr;
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 1
    // Checksum 0x0, Offset: 0x4d5
    // Size: 0xe9, Type: dev
    function function_5e521f045efe7ec2( params )
    {
        if ( !isdefined( params ) || !isdefined( params[ 0 ] ) )
        {
            iprintlnbold( "<dev string:x7e6>" );
            return;
        }
        
        bb_variable = params[ 0 ];
        value = default_to( params[ 1 ], 1 );
        value_type = default_to( params[ 2 ], "<dev string:x80b>" );
        
        switch ( value_type )
        {
            case #"hash_4730906c2f53f03e":
                value = int( value );
                break;
            case #"hash_3e4a6f464c850b65":
                value = float( value );
                break;
            case #"hash_2ac140ce3b5ea398":
                value = string( value );
                break;
        }
        
        closest_ai = function_6d1fbda4b8524ef2( level.players[ 0 ].origin );
        
        if ( !isdefined( closest_ai ) )
        {
            return;
        }
        
        closest_ai function_3e89eb3d8e3f1811( bb_variable, value );
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x5c6
    // Size: 0xa5, Type: dev
    function private function_6aca4fbb47b31a61( params )
    {
        new_speed = params[ 0 ];
        id_name = params[ 1 ];
        priority = int( params[ 2 ] );
        zombies = getaispeciesarray( "<dev string:x825>", "<dev string:x82d>" );
        
        foreach ( zombie in zombies )
        {
            zombie function_f1e5805da192a1ef( new_speed, id_name, priority );
        }
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x673
    // Size: 0x77, Type: dev
    function private function_79e6bc2cbae5a949()
    {
        player = level.players[ 0 ];
        zombies = getaispeciesarray( "<dev string:x825>", "<dev string:x82d>" );
        closest_zombie = get_array_of_closest( player.origin, zombies )[ 0 ];
        var_fdec05e6675e0c8a = closest_zombie getclosestreachablepointonnavmesh( player.origin );
        closest_zombie setbtgoalpos( 0, var_fdec05e6675e0c8a );
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x6f2
    // Size: 0x8f, Type: dev
    function private function_1aaf94b6b4be4ec4( params )
    {
        player = level.players[ 0 ];
        zombies = getaispeciesarray( "<dev string:x825>", "<dev string:x82d>" );
        closest_zombie = get_array_of_closest( player.origin, zombies )[ 0 ];
        
        if ( istrue( closest_zombie.enablebite ) )
        {
            closest_zombie request_bite( player );
            return;
        }
        
        if ( istrue( closest_zombie.enablemelee ) )
        {
            closest_zombie request_melee( player );
        }
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x789
    // Size: 0x15f, Type: dev
    function private function_a252e2eb60d04623( params )
    {
        aitype = params[ 0 ];
        subclass = params[ 0 ];
        team = params[ 1 ];
        
        if ( isdefined( level.var_f6c271f9f2c0fd8[ subclass ] ) )
        {
            aitype = level.var_f6c271f9f2c0fd8[ subclass ][ 0 ];
        }
        
        if ( !string_starts_with( aitype, "<dev string:x834>" ) )
        {
            aitype = "<dev string:x834>" + aitype;
        }
        
        if ( !isdefined( level.agent_definition[ aitype ] ) )
        {
            println( "<dev string:x83e>" + aitype + "<dev string:x858>" );
            return;
        }
        
        origin = function_9b4c82dba041b23d();
        
        if ( isdefined( origin ) )
        {
            player = level.players[ 0 ];
            team = default_to( team, "<dev string:x88c>" );
            ai = scripts\mp\mp_agent::spawnnewagentaitype( aitype, origin, ( 0, 0, 0 ), team );
            
            if ( isdefined( ai ) && getdvarint( @"hash_6c38ce1320bfb98f", 0 ) )
            {
                spawn_anim_alias = getdvar( @"hash_ad84b507251e9ec8", "<dev string:x8a0>" );
                
                if ( ai function_8fa69650e33c84ef( spawn_anim_alias ) )
                {
                    origin = getgroundposition( origin, 32, 720, 100 );
                    ai thread animscriptedagent( spawn_anim_alias, "<dev string:x8a9>", origin, ( 0, 0, 0 ), "<dev string:x8b6>" );
                }
            }
        }
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x8f0
    // Size: 0x25, Type: dev
    function private function_233d42b214d5a6cd()
    {
        iprintln( "<dev string:x8c9>" );
        function_2fb888667001fc39( "<dev string:x90a>", @"hash_6c38ce1320bfb98f" );
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x91d
    // Size: 0x86, Type: dev
    function private function_958e5c5cb15de054( params )
    {
        duration = float( params[ 0 ] );
        zombies = getaispeciesarray( "<dev string:x82d>", "<dev string:x286>" );
        
        foreach ( zombie in zombies )
        {
            zombie stun_ai( duration );
        }
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x9ab
    // Size: 0x66, Type: dev
    function private function_cacc6088d6b42b34()
    {
        player = level.players[ 0 ];
        zombies = getaispeciesarray( "<dev string:x82d>", "<dev string:x286>" );
        closest_zombie = get_array_of_closest( player.origin, zombies )[ 0 ];
        closest_zombie knockdown_ai( player.origin );
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xa19
    // Size: 0xac, Type: dev
    function private function_e4acd0ee95b2b171()
    {
        player = level.players[ 0 ];
        zombies = getaispeciesarray( "<dev string:x82d>", "<dev string:x286>" );
        zombies_sorted = get_array_of_closest( player.origin, zombies );
        
        foreach ( zombie in zombies_sorted )
        {
            if ( !zombie ent_flag( "<dev string:x92b>" ) )
            {
                zombie function_ca27630def7b7aad( player );
                return;
            }
        }
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xacd
    // Size: 0x108, Type: dev
    function private function_bb2c7a7d908691b3()
    {
        player = level.players[ 0 ];
        all_ai = getaiarray();
        ai_sorted = get_array_of_closest( player.origin, all_ai );
        
        foreach ( ai in ai_sorted )
        {
            if ( isdefined( ai ) )
            {
                asm_state = "<dev string:x935>";
                
                if ( ai asmhasstate( ai.asmname, asm_state ) )
                {
                    if ( istrue( ai liveragdoll_ai( player.origin, getdvarfloat( @"liveragdoll_intensity", 30000 ) ) ) )
                    {
                        return;
                    }
                    
                    return;
                }
                
                asm_state = "<dev string:x947>";
                
                if ( ai asmhasstate( ai.asmname, asm_state ) )
                {
                    ai startliveragdoll();
                    ai function_ac90fa5cc0a80298( asm_state );
                    return;
                }
            }
        }
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0xbdd
    // Size: 0xc7, Type: dev
    function private ragdoll_all( params )
    {
        player = level.players[ 0 ];
        all_ai = getaiarray();
        ai_sorted = get_array_of_closest( player.origin, all_ai );
        
        foreach ( ai in ai_sorted )
        {
            if ( isdefined( ai ) )
            {
                ai kill();
                corpse = ai getcorpseentity();
                corpse startragdollfromimpact( "<dev string:x95c>", ( 0, 0, 100 ) );
            }
        }
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0xcac
    // Size: 0xf3, Type: dev
    function private function_168f04942cd64395( params )
    {
        player = level.players[ 0 ];
        all_ai = getaiarray();
        ai_sorted = get_array_of_closest( player.origin, all_ai );
        hitloc = params[ 0 ];
        bone = params[ 1 ];
        
        if ( !isdefined( hitloc ) || !isdefined( bone ) )
        {
            return;
        }
        
        foreach ( ai in ai_sorted )
        {
            if ( isdefined( ai ) && isalive( ai ) )
            {
                ai kill();
                body = ai getcorpseentity();
                
                if ( isdefined( body ) )
                {
                    body thread function_bf2edfaccb048554( hitloc, bone );
                    return;
                }
            }
        }
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0xda7
    // Size: 0x129, Type: dev
    function private function_bf2edfaccb048554( hitloc, bone )
    {
        self endon( "<dev string:x96b>" );
        self startragdoll();
        waitframe();
        
        if ( !isdefined( level.pin_constraints ) )
        {
            level.pin_constraints = [];
        }
        
        if ( !isdefined( level.var_dd0a1e7ffd4586d5 ) )
        {
            level.var_dd0a1e7ffd4586d5 = [];
        }
        
        mover = spawn_tag_origin( self.origin + ( 0, 0, 64 ), self.angles );
        constraint = spawnragdollconstraint( self, hitloc, bone, ( 0, 0, 0 ), 0 );
        constraint.origin = mover.origin;
        constraint.angles = mover.angles;
        constraint linkto( mover );
        level.pin_constraints[ level.pin_constraints.size ] = constraint;
        level.var_dd0a1e7ffd4586d5[ level.var_dd0a1e7ffd4586d5.size ] = mover;
        mover moveto( mover.origin + ( 0, 0, 16 ), 3 );
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xed8
    // Size: 0xcd, Type: dev
    function private function_7d5de5e77bc3e95d()
    {
        if ( isdefined( level.var_dd0a1e7ffd4586d5 ) )
        {
            foreach ( mover in level.var_dd0a1e7ffd4586d5 )
            {
                if ( isdefined( mover ) )
                {
                    mover delete();
                }
            }
        }
        
        if ( isdefined( level.pin_constraints ) )
        {
            foreach ( constraint in level.pin_constraints )
            {
                if ( isdefined( constraint ) )
                {
                    constraint delete();
                }
            }
        }
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0xfad
    // Size: 0x97, Type: dev
    function private function_b4ecf2809c2b8328( params )
    {
        player_index = int( params[ 0 ] );
        zombies = getaispeciesarray( "<dev string:x82d>", "<dev string:x82d>" );
        
        foreach ( zombie in zombies )
        {
            zombie function_a047f71d0256058b( level.players[ player_index ], "<dev string:x974>", 1 );
        }
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x104c
    // Size: 0x7c, Type: dev
    function private kill_all_zombies()
    {
        zombies = getaispeciesarray( "<dev string:x82d>", "<dev string:x286>" );
        
        foreach ( zombie in zombies )
        {
            if ( !isdefined( zombie ) || !isalive( zombie ) )
            {
                continue;
            }
            
            zombie kill();
        }
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x10d0
    // Size: 0x10c, Type: dev
    function private function_789810fa398850aa()
    {
        function_2fb888667001fc39( "<dev string:x983>", @"zombie_wander_enabled" );
        zombies = getaispeciesarray( "<dev string:x82d>", "<dev string:x286>" );
        
        foreach ( zombie in zombies )
        {
            if ( isalive( zombie ) && getdvarint( @"zombie_wander_enabled", 0 ) <= 0 )
            {
                zombie._blackboard.var_2ad5368672cc47ba = 0;
                zombie setbtgoalpos( 0, zombie.origin );
                continue;
            }
            
            if ( isalive( zombie ) && getdvarint( @"zombie_wander_enabled", 0 ) <= 1 )
            {
                zombie._blackboard.var_2ad5368672cc47ba = zombie.zombieaisettings.maxwanderradius;
            }
        }
    }

    // Namespace namespace_e5049f73842ac360 / namespace_85d29b89b454cb3b
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x11e4
    // Size: 0xbd, Type: dev
    function private function_db4932603c9f24eb()
    {
        function_2fb888667001fc39( "<dev string:x99c>", @"zombie_pain_enabled" );
        zombies = getaispeciesarray( "<dev string:x82d>", "<dev string:x286>" );
        
        foreach ( zombie in zombies )
        {
            if ( isalive( zombie ) && getdvarint( @"zombie_pain_enabled", 0 ) <= 0 )
            {
                zombie val::set( "<dev string:x9b3>", "<dev string:x9c8>", 0 );
                continue;
            }
            
            zombie val::reset( "<dev string:x9b3>", "<dev string:x9c8>" );
        }
    }

#/
