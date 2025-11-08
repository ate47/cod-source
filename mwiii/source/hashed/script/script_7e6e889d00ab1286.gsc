#using scripts\cp_mp\agents\agent_utils;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;

#namespace namespace_729ad542a73c44b6;

/#

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 4
    // Checksum 0x0, Offset: 0xa0
    // Size: 0x1f6, Type: dev
    function function_f178ffb3b7e8f054( player, var_feded019f08c32a5, var_d2ff858534fd3a20, var_250b0757cdf3763f )
    {
        if ( !isdefined( var_feded019f08c32a5 ) )
        {
            var_feded019f08c32a5 = 25;
        }
        
        if ( !isdefined( var_d2ff858534fd3a20 ) )
        {
            var_d2ff858534fd3a20 = 330;
        }
        
        if ( !isdefined( var_250b0757cdf3763f ) )
        {
            var_250b0757cdf3763f = 1.1;
        }
        
        if ( !isdefined( player ) )
        {
            assertmsg( "<dev string:x1c>" + "<dev string:x7c>" );
            return 0;
        }
        
        if ( istrue( level.var_549feb5cab354e2 ) )
        {
            assertmsg( "<dev string:xad>" );
            return 0;
        }
        
        iprintlnbold( "<dev string:x101>" );
        level.var_549feb5cab354e2 = 1;
        level.var_a1219ac875a3d621 = 0;
        level.var_a71afe8486fdb70 = [];
        level.var_514f3b1e3ab80d65 = undefined;
        level.var_388f77678ded6b04 = undefined;
        level.var_818b7d434b3f9bb1 = undefined;
        
        for ( i = 0; i < 3 ; i++ )
        {
            text = newhudelem();
            text.alignx = "<dev string:x119>";
            text.aligny = "<dev string:x121>";
            text.horzalign = "<dev string:x119>";
            text.vertalign = "<dev string:x12b>";
            text.x = var_feded019f08c32a5;
            text.alpha = 1;
            text.fontscale = var_250b0757cdf3763f;
            text.y = var_d2ff858534fd3a20 + 40 * i;
            
            if ( i == 0 )
            {
                text.alpha = 0;
                text.color = ( 1, 1, 0 );
                text setdevtext( "<dev string:x132>" );
                level.var_514f3b1e3ab80d65 = text;
                continue;
            }
            
            if ( i == 1 )
            {
                level.var_388f77678ded6b04 = text;
                continue;
            }
            
            if ( i == 2 )
            {
                level.var_818b7d434b3f9bb1 = text;
            }
        }
        
        thread function_d219cbf0d7077ea4( player );
        function_f4ee8a37147c341a( 0 );
        thread function_a2e67bd7c442e4f5( player );
        return 1;
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 1
    // Checksum 0x0, Offset: 0x29e
    // Size: 0x11c, Type: dev
    function function_106c2d7eba0aa9d0( var_a19ab69b16e26496 )
    {
        if ( !isdefined( var_a19ab69b16e26496 ) )
        {
            var_a19ab69b16e26496 = 0;
        }
        
        if ( istrue( level.var_549feb5cab354e2 ) )
        {
            level notify( "<dev string:x161>" );
            level.var_549feb5cab354e2 = 0;
            
            if ( isdefined( level.var_514f3b1e3ab80d65 ) )
            {
                level.var_514f3b1e3ab80d65 destroy();
            }
            
            if ( isdefined( level.var_388f77678ded6b04 ) )
            {
                level.var_388f77678ded6b04 destroy();
            }
            
            if ( isdefined( level.var_818b7d434b3f9bb1 ) )
            {
                level.var_818b7d434b3f9bb1 destroy();
            }
            
            if ( var_a19ab69b16e26496 )
            {
                foreach ( enemy_struct in level.var_a71afe8486fdb70 )
                {
                    enemy_struct.enemy scripts\cp_mp\agents\agent_utils::despawnagent();
                }
                
                level.var_a1219ac875a3d621 = 0;
            }
            
            level.var_a71afe8486fdb70 = [];
            iprintlnbold( "<dev string:x175>" );
            return;
        }
        
        assertmsg( "<dev string:x18c>" );
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 0
    // Checksum 0x0, Offset: 0x3c2
    // Size: 0x1b, Type: dev
    function function_ac8025446d4ac9d8()
    {
        return int( getdvarint( @"hash_87c94a85ffc74e32", 100 ) );
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 0
    // Checksum 0x0, Offset: 0x3e5
    // Size: 0x10, Type: dev
    function function_1e886a86efe8cab6()
    {
        openplayerdirectoryonpc( "<dev string:x1d6>" );
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x3fd
    // Size: 0x19, Type: dev
    function private function_1a9bc48bb2455538()
    {
        return getdvarint( @"hash_42de9d4c1c64a0b7", 1 ) == 1;
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x41e
    // Size: 0x17, Type: dev
    function private function_7ca830f2af0c0100()
    {
        return getdvarint( @"hash_14bc1f391434b0c2", 0 ) == 0;
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x43d
    // Size: 0x38, Type: dev
    function private function_52fd78fdbcec52a0( player )
    {
        button = scripts\engine\utility::ter_op( function_7ca830f2af0c0100(), "<dev string:x1ed>", "<dev string:x1f8>" );
        return player buttonpressed( button );
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x47d
    // Size: 0x38, Type: dev
    function private function_b7d8cf38739948a1( player )
    {
        button = scripts\engine\utility::ter_op( function_7ca830f2af0c0100(), "<dev string:x203>", "<dev string:x211>" );
        return player buttonpressed( button );
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x4bd
    // Size: 0x38, Type: dev
    function private function_7a841eac53d0427e( player )
    {
        button = scripts\engine\utility::ter_op( function_7ca830f2af0c0100(), "<dev string:x21f>", "<dev string:x22c>" );
        return player buttonpressed( button );
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x4fd
    // Size: 0x4d, Type: dev
    function private function_3c2ec2ddfe050648( player )
    {
        if ( function_7ca830f2af0c0100() )
        {
            return ( player buttonpressed( "<dev string:x239>" ) && player buttonpressed( "<dev string:x241>" ) );
        }
        
        return player buttonpressed( "<dev string:x249>" ) && player buttonpressed( "<dev string:x255>" );
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x552
    // Size: 0x4d, Type: dev
    function private function_1b40127751c2e153( player )
    {
        if ( function_7ca830f2af0c0100() )
        {
            return ( player buttonpressed( "<dev string:x261>" ) && player buttonpressed( "<dev string:x269>" ) );
        }
        
        return player buttonpressed( "<dev string:x271>" ) && player buttonpressed( "<dev string:x27d>" );
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x5a7
    // Size: 0x1b6, Type: dev
    function private function_a2e67bd7c442e4f5( player )
    {
        player endon( "<dev string:x289>" );
        level endon( "<dev string:x2a0>" );
        
        for ( ;; )
        {
            if ( !function_1a9bc48bb2455538() )
            {
                waitframe();
                continue;
            }
            
            foreach ( enemy_struct in level.var_a71afe8486fdb70 )
            {
                if ( !istrue( enemy_struct.is_dead ) && isdefined( enemy_struct.enemy ) )
                {
                    enemy = enemy_struct.enemy;
                    enemy_origin = enemy.origin;
                    capsule_data = enemy physics_getcharactercollisioncapsule();
                    
                    if ( isdefined( capsule_data ) )
                    {
                        height = 0;
                        
                        switch ( enemy_struct.stance )
                        {
                            case #"hash_c6775c88e38f7803":
                                height = capsule_data[ "<dev string:x2b7>" ] * 2;
                                break;
                            case #"hash_3fed0cbd303639eb":
                                height = capsule_data[ "<dev string:x2b7>" ] * 1.5;
                                break;
                            case #"hash_d91940431ed7c605":
                                height = capsule_data[ "<dev string:x2b7>" ] * 0.5;
                                break;
                        }
                        
                        scripts\engine\utility::draw_capsule( enemy_origin, capsule_data[ "<dev string:x2d9>" ], height, enemy.angles, ( 1, 0, 0 ), 0, 1 );
                        var_166e5196f2d1c91d = ( enemy_origin[ 0 ], enemy_origin[ 1 ], enemy_origin[ 2 ] + height * 0.5 );
                        print3d( var_166e5196f2d1c91d, "<dev string:x2e3>", ( 1, 0, 0 ), 1, 1, 1 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x765
    // Size: 0x50, Type: dev
    function private function_11620457f2ffe126( var_b79a69e8af1ef560, stance )
    {
        enemy_data = spawnstruct();
        enemy_data.enemy = var_b79a69e8af1ef560;
        enemy_data.stance = stance;
        enemy_data.is_dead = 0;
        return enemy_data;
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x7bd
    // Size: 0x50, Type: dev
    function private function_d38cee3caded2a28( var_e8293b7b49b38cee )
    {
        var_e8293b7b49b38cee.enemy waittill( "<dev string:x2ef>" );
        var_e8293b7b49b38cee.is_dead = 1;
        
        if ( !istrue( var_e8293b7b49b38cee.from_despawn ) )
        {
            function_de912783c00af35a( level.var_a1219ac875a3d621 - 1 );
        }
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 3, eflags: 0x4
    // Checksum 0x0, Offset: 0x815
    // Size: 0xb8, Type: dev
    function private function_3b9696c1711d8dee( origin, angles, stance )
    {
        if ( !isdefined( stance ) )
        {
            stance = "<dev string:x2ae>";
        }
        
        var_f82ef7d99e9ff31b = scripts\mp\mp_agent::spawnnewagentaitype( "<dev string:x2f8>", origin, angles );
        
        if ( !isdefined( var_f82ef7d99e9ff31b ) )
        {
            assertmsg( "<dev string:x309>" );
            return undefined;
        }
        
        function_dd12ed75d4820d7b( var_f82ef7d99e9ff31b, stance );
        var_f82ef7d99e9ff31b.health = function_ac8025446d4ac9d8();
        var_e8293b7b49b38cee = function_11620457f2ffe126( var_f82ef7d99e9ff31b, stance );
        level.var_a71afe8486fdb70[ level.var_a71afe8486fdb70.size ] = var_e8293b7b49b38cee;
        thread function_d38cee3caded2a28( var_e8293b7b49b38cee );
        function_de912783c00af35a( level.var_a1219ac875a3d621 + 1 );
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x8d5
    // Size: 0xf1, Type: dev
    function private function_dd12ed75d4820d7b( enemyentity, stance )
    {
        if ( !isdefined( enemyentity ) )
        {
            assertmsg( "<dev string:x338>" );
            return;
        }
        
        enemyentity enabletraversals( 0 );
        enemyentity.dontevershoot = 1;
        enemyentity.bt.cannotmelee = 1;
        enemyentity scripts\engine\utility::set_movement_speed( 0 );
        enemyentity enabletraversals( 0 );
        
        if ( isdefined( stance ) )
        {
            enemyentity allowedstances( stance );
        }
        
        enemyentity.aggressivemode = 0;
        enemyentity function_9215ce6fc83759b9( 600 );
        enemyentity agentsetfavoriteenemy( undefined );
        enemyentity.ignoreme = 1;
        enemyentity.ignoreall = 1;
        enemyentity.disablebulletwhizbyreaction = 1;
        enemyentity setcanusecover( 0 );
        enemyentity.disablerunngun = 1;
        enemyentity.disabledodge = 1;
        enemyentity.scripted_mode = 1;
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x9ce
    // Size: 0x301, Type: dev
    function private function_d219cbf0d7077ea4( player )
    {
        level endon( "<dev string:x161>" );
        level endon( "<dev string:x2a0>" );
        player endon( "<dev string:x289>" );
        buttondown = 0;
        
        for ( ;; )
        {
            if ( function_52fd78fdbcec52a0( player ) )
            {
                if ( !buttondown )
                {
                    function_3b9696c1711d8dee( player.origin, player.angles, "<dev string:x2ae>" );
                }
                
                buttondown = 1;
            }
            else if ( function_7a841eac53d0427e( player ) )
            {
                if ( !buttondown )
                {
                    function_3b9696c1711d8dee( player.origin, player.angles, "<dev string:x2d0>" );
                }
                
                buttondown = 1;
            }
            else if ( function_b7d8cf38739948a1( player ) )
            {
                if ( !buttondown )
                {
                    function_3b9696c1711d8dee( player.origin, player.angles, "<dev string:x2c6>" );
                }
                
                buttondown = 1;
            }
            else if ( function_3c2ec2ddfe050648( player ) )
            {
                if ( !buttondown )
                {
                    foreach ( enemy_struct in level.var_a71afe8486fdb70 )
                    {
                        if ( !isdefined( enemy_struct ) || !isdefined( enemy_struct.enemy ) || enemy_struct.is_dead == 1 )
                        {
                            level.var_a71afe8486fdb70 = scripts\engine\utility::array_remove( level.var_a71afe8486fdb70, enemy_struct );
                        }
                    }
                    
                    function_c59d2b7790bd42c9( level.var_a71afe8486fdb70 );
                    function_a852e81f642e2fe( 0 );
                }
                
                buttondown = 1;
            }
            else if ( function_1b40127751c2e153( player ) )
            {
                if ( !buttondown )
                {
                    var_9bf444b4a5cbdc59 = function_4ec485ad16ca921d();
                    
                    if ( var_9bf444b4a5cbdc59.size > 0 )
                    {
                        foreach ( enemy_struct in level.var_a71afe8486fdb70 )
                        {
                            enemy_struct.from_despawn = 1;
                            enemy_struct.enemy scripts\cp_mp\agents\agent_utils::despawnagent();
                        }
                        
                        level.var_a71afe8486fdb70 = [];
                        function_de912783c00af35a( 0 );
                    }
                    
                    foreach ( info in var_9bf444b4a5cbdc59 )
                    {
                        assertex( isdefined( info.origin ), "<dev string:x372>" );
                        assertex( isdefined( info.angles ), "<dev string:x398>" );
                        assertex( isdefined( info.stance ), "<dev string:x3be>" );
                        function_3b9696c1711d8dee( info.origin, info.angles, info.stance );
                    }
                    
                    function_a852e81f642e2fe( 0 );
                }
                
                buttondown = 1;
            }
            else
            {
                buttondown = 0;
            }
            
            waitframe();
        }
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0xcd7
    // Size: 0x20f, Type: dev
    function private function_c59d2b7790bd42c9( enemyarray )
    {
        if ( enemyarray.size == 0 )
        {
            assertmsg( "<dev string:x3e4>" );
            return 0;
        }
        
        fileid = openfileinplayerdirectory( "<dev string:x40e>", "<dev string:x427>", "<dev string:x1d6>" );
        
        if ( fileid == -1 )
        {
            assertmsg( "<dev string:x430>" );
            return 0;
        }
        
        fileid = closefileinplayerdirectory( fileid );
        fileid = openfileinplayerdirectory( "<dev string:x40e>", "<dev string:x471>", "<dev string:x1d6>" );
        
        if ( fileid == -1 )
        {
            return 0;
        }
        
        foreach ( enemy_struct in enemyarray )
        {
            assertex( isdefined( enemy_struct.enemy.origin ), "<dev string:x47b>" );
            assertex( isdefined( enemy_struct.enemy.angles ), "<dev string:x4ae>" );
            assertex( isdefined( enemy_struct.stance ), "<dev string:x4e1>" );
            position = enemy_struct.enemy.origin;
            angle = enemy_struct.enemy.angles;
            stance = enemy_struct.stance;
            position_string = "<dev string:x514>" + position[ 0 ] + "<dev string:x51f>" + position[ 1 ] + "<dev string:x51f>" + position[ 2 ] + "<dev string:x524>";
            angle_string = "<dev string:x529>" + angle[ 0 ] + "<dev string:x51f>" + angle[ 1 ] + "<dev string:x51f>" + angle[ 2 ] + "<dev string:x524>";
            writelinetofileinplayerdirectory( fileid, position_string + angle_string + "<dev string:x534>" + stance + "<dev string:x524>" );
        }
        
        assertmsg( "<dev string:x53f>" );
        closefileinplayerdirectory( fileid );
        return 1;
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xeee
    // Size: 0x2f1, Type: dev
    function private function_4ec485ad16ca921d()
    {
        fileid = openfileinplayerdirectory( "<dev string:x40e>", "<dev string:x568>", "<dev string:x1d6>" );
        
        if ( fileid == -1 )
        {
            assertmsg( "<dev string:x570>" + "<dev string:x1d6>" + "<dev string:x59e>" + "<dev string:x40e>" );
            return [];
        }
        
        filecontent = readfileinplayerdirectory( fileid );
        currentline = "<dev string:x5a3>";
        var_83dbc5b05ae7eaf9 = [];
        
        for ( i = 0; i < filecontent.size ; i++ )
        {
            if ( ( filecontent[ i ] == "<dev string:x5a7>" || i == filecontent.size - 1 ) && currentline != "<dev string:x5a3>" )
            {
                var_83dbc5b05ae7eaf9[ var_83dbc5b05ae7eaf9.size ] = currentline;
                currentline = "<dev string:x5a3>";
                continue;
            }
            
            currentline += filecontent[ i ];
        }
        
        var_ffe86c13a92e9bda = [];
        origin = [];
        angles = [];
        stance = "<dev string:x5a3>";
        tempstring = "<dev string:x5a3>";
        var_432a7c3e01871183 = 0;
        
        for ( i = 0; i < var_83dbc5b05ae7eaf9.size ; i++ )
        {
            for ( j = 0; j < var_83dbc5b05ae7eaf9[ i ].size ; j++ )
            {
                if ( var_83dbc5b05ae7eaf9[ i ][ j ] == "<dev string:x5ac>" )
                {
                    var_432a7c3e01871183 = 1;
                    continue;
                }
                
                if ( !var_432a7c3e01871183 )
                {
                    continue;
                }
                
                if ( origin.size != 3 )
                {
                    if ( var_83dbc5b05ae7eaf9[ i ][ j ] == "<dev string:x51f>" || var_83dbc5b05ae7eaf9[ i ][ j ] == "<dev string:x524>" )
                    {
                        origin[ origin.size ] = float( tempstring );
                        tempstring = "<dev string:x5a3>";
                    }
                    else
                    {
                        tempstring += var_83dbc5b05ae7eaf9[ i ][ j ];
                    }
                }
                else if ( angles.size != 3 )
                {
                    if ( var_83dbc5b05ae7eaf9[ i ][ j ] == "<dev string:x51f>" || var_83dbc5b05ae7eaf9[ i ][ j ] == "<dev string:x524>" )
                    {
                        angles[ angles.size ] = float( tempstring );
                        tempstring = "<dev string:x5a3>";
                    }
                    else
                    {
                        tempstring += var_83dbc5b05ae7eaf9[ i ][ j ];
                    }
                }
                else if ( var_83dbc5b05ae7eaf9[ i ][ j ] == "<dev string:x524>" )
                {
                    stance = tempstring;
                }
                else
                {
                    tempstring += var_83dbc5b05ae7eaf9[ i ][ j ];
                }
                
                if ( var_83dbc5b05ae7eaf9[ i ][ j ] == "<dev string:x524>" )
                {
                    var_432a7c3e01871183 = 0;
                }
                
                if ( angles.size == 3 && origin.size == 3 && stance != "<dev string:x5a3>" )
                {
                    ai_info = spawnstruct();
                    ai_info.origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] );
                    ai_info.angles = ( angles[ 0 ], angles[ 1 ], angles[ 2 ] );
                    ai_info.stance = stance;
                    var_ffe86c13a92e9bda[ var_ffe86c13a92e9bda.size ] = ai_info;
                    angles = [];
                    origin = [];
                    stance = "<dev string:x5a3>";
                    tempstring = "<dev string:x5a3>";
                }
            }
        }
        
        fileid = closefileinplayerdirectory( fileid );
        
        if ( var_ffe86c13a92e9bda.size > 0 )
        {
            assertmsg( "<dev string:x5b1>" );
        }
        else
        {
            assertmsg( "<dev string:x5dd>" + "<dev string:x60b>" + "<dev string:x665>" );
        }
        
        return var_ffe86c13a92e9bda;
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x11e7
    // Size: 0x3a, Type: dev
    function private function_de912783c00af35a( amount )
    {
        level.var_a1219ac875a3d621 = amount;
        function_a852e81f642e2fe( level.var_a1219ac875a3d621 > 0 );
        function_f4ee8a37147c341a( level.var_a1219ac875a3d621 );
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x1229
    // Size: 0x4e, Type: dev
    function private function_a852e81f642e2fe( value )
    {
        if ( !isdefined( level.var_514f3b1e3ab80d65 ) )
        {
            return;
        }
        
        if ( value )
        {
            level.var_514f3b1e3ab80d65.alpha = 1;
            return;
        }
        
        level.var_514f3b1e3ab80d65.alpha = 0;
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x127f
    // Size: 0x5b, Type: dev
    function private function_94a237ed0aafcdf5( var_a42ba55ac4aaeb35, player )
    {
        player endon( "<dev string:x289>" );
        level endon( "<dev string:x2a0>" );
        level endon( "<dev string:x161>" );
        
        if ( !isdefined( var_a42ba55ac4aaeb35 ) )
        {
            return;
        }
        
        while ( true )
        {
            var_a42ba55ac4aaeb35 setdevtext( "<dev string:x69b>" + function_ac8025446d4ac9d8() + "<dev string:x6ad>" + "<dev string:x6b8>" );
            wait 3;
        }
    }

    // Namespace namespace_729ad542a73c44b6 / namespace_6c0bcb025e487cb4
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x12e2
    // Size: 0x31, Type: dev
    function private function_f4ee8a37147c341a( newamount )
    {
        if ( isdefined( level.var_818b7d434b3f9bb1 ) )
        {
            level.var_818b7d434b3f9bb1 setdevtext( "<dev string:x6d4>" + newamount );
        }
    }

#/
