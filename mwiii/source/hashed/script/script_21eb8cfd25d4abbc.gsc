#using script_48554021bb847168;
#using scripts\common\devgui;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace namespace_13b520ef0ef94d22;

/#

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 1
    // Checksum 0x0, Offset: 0xb0
    // Size: 0x11e, Type: dev
    function function_8e1e2ede444b27c7( player )
    {
        if ( !isdefined( player ) )
        {
            player = undefined;
        }
        
        if ( function_58859351a0e20672() )
        {
            iprintlnbold( "<dev string:x1c>" );
            return 0;
        }
        
        if ( !isdefined( player ) )
        {
            if ( isdefined( level.player ) )
            {
                player = level.player;
            }
            else
            {
                assertmsg( "<dev string:x4d>" );
                return 0;
            }
        }
        
        level.var_30b4e93471216b98 = 1;
        function_af5563b5a361f220();
        
        if ( level.var_3d2b55060c917ac6.size > 0 )
        {
            function_ad87353fd3346904( 1 );
        }
        else
        {
            function_ad87353fd3346904( 0 );
        }
        
        adddebugcommand( "<dev string:x8f>" );
        adddebugcommand( "<dev string:x9d>" );
        adddebugcommand( "<dev string:xb3>" );
        level.var_cb6d4f9bbf530582 = 0;
        
        if ( getdvarint( @"hash_90dfd1b7dc84670e", 0 ) == 0 )
        {
            setdvar( @"hash_90dfd1b7dc84670e", 1 );
            level.var_cb6d4f9bbf530582 = 1;
        }
        
        iprintlnbold( "<dev string:xbd>" );
        thread function_8f449a386b3f7252( player );
        thread function_dc51e459a8decdf3();
        thread function_2a9774c5ef7ef38( player );
        thread function_b591f01924cc04aa( player );
        return 1;
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 0
    // Checksum 0x0, Offset: 0x1d6
    // Size: 0x5e, Type: dev
    function function_86e14dde4a93558d()
    {
        if ( !function_58859351a0e20672() )
        {
            iprintlnbold( "<dev string:xdf>" );
            return;
        }
        
        level notify( "<dev string:x11b>" );
        level.var_30b4e93471216b98 = 0;
        adddebugcommand( "<dev string:xb3>" );
        
        if ( istrue( level.var_cb6d4f9bbf530582 ) )
        {
            setdvar( @"hash_90dfd1b7dc84670e", 0 );
            level.var_cb6d4f9bbf530582 = 0;
        }
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 3
    // Checksum 0x0, Offset: 0x23c
    // Size: 0x120, Type: dev
    function function_fe10197ad5c2b028( var_b6f7d1562dddbda1, callbackfunction, var_d0b92e2643d628e8 )
    {
        if ( !isdefined( var_d0b92e2643d628e8 ) )
        {
            var_d0b92e2643d628e8 = undefined;
        }
        
        function_af5563b5a361f220();
        
        if ( isdefined( level.var_c1b72a4a62f8afb1[ var_b6f7d1562dddbda1 ] ) )
        {
            assertmsg( "<dev string:x130>" + var_b6f7d1562dddbda1 + "<dev string:x154>" );
            return;
        }
        
        var_42487180feed4fe4 = spawnstruct();
        var_42487180feed4fe4.name_id = var_b6f7d1562dddbda1;
        var_42487180feed4fe4.var_d0b92e2643d628e8 = var_d0b92e2643d628e8;
        
        if ( isdefined( callbackfunction ) )
        {
            var_42487180feed4fe4.callbackfunction = callbackfunction;
        }
        else
        {
            var_42487180feed4fe4.callbackfunction = &function_48a0132d8409d09a;
        }
        
        if ( level.var_be06ed7ebf2389a5 == -1 )
        {
            var_42487180feed4fe4.isselected = 1;
            level.var_be06ed7ebf2389a5 = 0;
        }
        else
        {
            var_42487180feed4fe4.isselected = 0;
        }
        
        level.var_3d2b55060c917ac6[ level.var_3d2b55060c917ac6.size ] = var_42487180feed4fe4;
        level.var_c1b72a4a62f8afb1[ var_b6f7d1562dddbda1 ] = var_42487180feed4fe4;
        
        if ( function_a5197e589420f4ab() == 0 && function_a5197e589420f4ab() != 2 )
        {
            function_ad87353fd3346904( 1 );
        }
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 0
    // Checksum 0x0, Offset: 0x364
    // Size: 0x35, Type: dev
    function function_d6f7b6f9e9bc119()
    {
        level.var_3d2b55060c917ac6 = [];
        level.var_c1b72a4a62f8afb1 = [];
        level.var_be06ed7ebf2389a5 = -1;
        
        if ( function_58859351a0e20672() )
        {
            function_ad87353fd3346904( 0 );
        }
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 0
    // Checksum 0x0, Offset: 0x3a1
    // Size: 0x9c, Type: dev
    function function_e5ca1b100ee7f420()
    {
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x182>" );
        scripts\common\devgui::function_a9a864379a098ad6( "<dev string:x1a2>", "<dev string:x1a2>", &function_8b314359ff8d79f3 );
        scripts\common\devgui::function_a9a864379a098ad6( "<dev string:x1b6>", "<dev string:x1b6>", &function_dc0e0ebca84023c0 );
        scripts\common\devgui::function_a9a864379a098ad6( "<dev string:x1cd>", "<dev string:x1cd>", &function_8e1e2ede444b27c7 );
        scripts\common\devgui::function_a9a864379a098ad6( "<dev string:x1d6>", "<dev string:x1d6>", &function_86e14dde4a93558d );
        scripts\common\devgui::function_a9a864379a098ad6( "<dev string:x1de>", "<dev string:x1de>", &function_285630d626038d0a );
        scripts\common\devgui::function_a9a864379a098ad6( "<dev string:x1e6>", "<dev string:x1e6>", &function_3769d0ae67ca1ee8 );
        scripts\common\devgui::function_fe953f000498048f();
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 0
    // Checksum 0x0, Offset: 0x445
    // Size: 0x10, Type: dev
    function function_8b314359ff8d79f3()
    {
        openplayerdirectoryonpc( "<dev string:x1ee>" );
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 0
    // Checksum 0x0, Offset: 0x45d
    // Size: 0x6c, Type: dev
    function function_dc0e0ebca84023c0()
    {
        foreach ( trigger_struct in level.var_5f82a2a48defe497 )
        {
            trigger_struct.trigger delete();
        }
        
        level.var_5f82a2a48defe497 = [];
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x4d1
    // Size: 0x10, Type: dev
    function private function_58859351a0e20672()
    {
        return istrue( level.var_30b4e93471216b98 );
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x4e9
    // Size: 0x46, Type: dev
    function private function_f88ab94035d645bf()
    {
        if ( isdefined( level.var_be06ed7ebf2389a5 ) && isdefined( level.var_3d2b55060c917ac6 ) && level.var_3d2b55060c917ac6.size > 0 )
        {
            return level.var_3d2b55060c917ac6[ level.var_be06ed7ebf2389a5 ];
        }
        
        return undefined;
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x537
    // Size: 0x19, Type: dev
    function private function_48a0132d8409d09a( player )
    {
        iprintlnbold( "<dev string:x205>" );
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x558
    // Size: 0x62, Type: dev
    function private function_af5563b5a361f220()
    {
        if ( !isdefined( level.var_5f82a2a48defe497 ) )
        {
            level.var_5f82a2a48defe497 = [];
        }
        
        if ( !isdefined( level.var_3d2b55060c917ac6 ) )
        {
            level.var_3d2b55060c917ac6 = [];
        }
        
        if ( !isdefined( level.var_c1b72a4a62f8afb1 ) )
        {
            level.var_c1b72a4a62f8afb1 = [];
        }
        
        if ( !isdefined( level.var_be06ed7ebf2389a5 ) )
        {
            level.var_be06ed7ebf2389a5 = -1;
        }
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x5c2
    // Size: 0x1a, Type: dev
    function private function_59ac18b7ff7350cf( key_name )
    {
        return level.var_c1b72a4a62f8afb1[ key_name ];
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x5e4
    // Size: 0x10c, Type: dev
    function private function_8de9f2582b68c9d8( direction )
    {
        if ( level.var_3d2b55060c917ac6.size == 0 )
        {
            return;
        }
        
        if ( direction == "<dev string:x224>" )
        {
            var_ef53b49ccc07ccb3 = function_f88ab94035d645bf();
            var_ef53b49ccc07ccb3.isselected = 0;
            level.var_be06ed7ebf2389a5 += 1;
            
            if ( level.var_be06ed7ebf2389a5 >= level.var_3d2b55060c917ac6.size )
            {
                level.var_be06ed7ebf2389a5 = 0;
            }
            
            var_7e52fc725cb45e88 = function_f88ab94035d645bf();
            var_7e52fc725cb45e88.isselected = 1;
            return;
        }
        
        if ( direction == "<dev string:x22c>" )
        {
            var_ef53b49ccc07ccb3 = function_f88ab94035d645bf();
            var_ef53b49ccc07ccb3.isselected = 0;
            level.var_be06ed7ebf2389a5 -= 1;
            
            if ( level.var_be06ed7ebf2389a5 < 0 )
            {
                level.var_be06ed7ebf2389a5 = level.var_3d2b55060c917ac6.size - 1;
            }
            
            var_7e52fc725cb45e88 = function_f88ab94035d645bf();
            var_7e52fc725cb45e88.isselected = 1;
        }
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x6f8
    // Size: 0x23, Type: dev
    function private function_ad87353fd3346904( newstate )
    {
        level.var_2a1e970542d164df = newstate;
        iprintlnbold( "<dev string:x232>" );
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x723
    // Size: 0x26, Type: dev
    function private function_a5197e589420f4ab()
    {
        if ( !isdefined( level.var_2a1e970542d164df ) )
        {
            level.var_2a1e970542d164df = 0;
        }
        
        return level.var_2a1e970542d164df;
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x751
    // Size: 0x26b, Type: dev
    function private function_8f449a386b3f7252( player )
    {
        player endon( "<dev string:x248>" );
        level endon( "<dev string:x266>" );
        level endon( "<dev string:x11b>" );
        var_fd2b2ae9163cb7b = 0;
        
        for ( ;; )
        {
            var_d35f184a4d9ff50b = function_a5197e589420f4ab();
            
            if ( var_d35f184a4d9ff50b == 0 )
            {
                wait 1.5;
                continue;
            }
            
            start = player geteye() + ( 7, 7, 7 );
            end = start + vectornormalize( anglestoforward( player getplayerangles() ) ) * 2000;
            [ hit_position, hit_trigger ] = function_5da366fcac7d7d88( player, start, end );
            var_201afd0c5cad966b = isdefined( hit_position );
            var_ebc2c935184de38e = ( 1, 0, 0 );
            var_d3c24fca4dd0d745 = 0;
            
            if ( var_201afd0c5cad966b )
            {
                if ( var_d35f184a4d9ff50b == 1 )
                {
                    var_d3c24fca4dd0d745 = !isdefined( hit_trigger );
                }
                else if ( var_d35f184a4d9ff50b == 2 )
                {
                    var_d3c24fca4dd0d745 = isdefined( hit_trigger );
                }
                
                if ( var_d3c24fca4dd0d745 )
                {
                    var_ebc2c935184de38e = ( 0, 1, 0 );
                    
                    if ( var_d35f184a4d9ff50b == 1 )
                    {
                        var_5b8ed5760761b806 = function_f88ab94035d645bf();
                        
                        if ( isdefined( var_5b8ed5760761b806 ) )
                        {
                            print3d( hit_position, "<dev string:x274>" + var_5b8ed5760761b806.name_id, ( 0, 0, 1 ), 1, 1, 1, 1 );
                        }
                    }
                    else if ( var_d35f184a4d9ff50b == 2 )
                    {
                        var_ebc2c935184de38e = ( 0, 1, 0 );
                        print3d( hit_position, "<dev string:x27e>", ( 0, 0, 1 ), 1, 1, 1, 1 );
                    }
                }
                
                if ( var_d35f184a4d9ff50b == 2 )
                {
                    sphere( hit_position, 25, var_ebc2c935184de38e, 0, 1 );
                }
                else if ( var_d35f184a4d9ff50b == 1 )
                {
                    sphere( hit_position, 50, var_ebc2c935184de38e, 0, 1 );
                }
            }
            
            line( start, end, var_ebc2c935184de38e, 1, 0, 1 );
            
            if ( var_d3c24fca4dd0d745 && player buttonpressed( "<dev string:x288>" ) )
            {
                if ( !var_fd2b2ae9163cb7b )
                {
                    if ( var_d35f184a4d9ff50b == 1 )
                    {
                        var_5b8ed5760761b806 = function_f88ab94035d645bf();
                        
                        if ( isdefined( var_5b8ed5760761b806 ) )
                        {
                            thread spawntrigger( player, hit_position, var_5b8ed5760761b806.callbackfunction, var_5b8ed5760761b806.name_id, var_5b8ed5760761b806.var_d0b92e2643d628e8 );
                        }
                    }
                    else if ( var_d35f184a4d9ff50b == 2 )
                    {
                        removetrigger( hit_trigger );
                    }
                }
                
                var_fd2b2ae9163cb7b = 1;
            }
            else
            {
                var_fd2b2ae9163cb7b = 0;
            }
            
            waitframe();
        }
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 3, eflags: 0x4
    // Checksum 0x0, Offset: 0x9c4
    // Size: 0x12e, Type: dev
    function private function_5da366fcac7d7d88( player, start, end )
    {
        hit_trigger = undefined;
        hit_position = undefined;
        var_201afd0c5cad966b = undefined;
        var_ebc2c935184de38e = ( 1, 0, 0 );
        var_69c9a5aa445052d1 = physics_raycast( start, end, scripts\engine\trace::create_default_contents(), player, 0, "<dev string:x292>" );
        var_201afd0c5cad966b = isdefined( var_69c9a5aa445052d1 ) && var_69c9a5aa445052d1.size > 0 && isdefined( var_69c9a5aa445052d1[ 0 ][ "<dev string:x2aa>" ] );
        
        if ( var_201afd0c5cad966b )
        {
            hit_position = var_69c9a5aa445052d1[ 0 ][ "<dev string:x2aa>" ];
        }
        
        foreach ( trigger_struct in level.var_5f82a2a48defe497 )
        {
            if ( scripts\engine\math::segmentvssphere( start, end, trigger_struct.trigger.origin, 50 ) )
            {
                hit_trigger = trigger_struct.trigger;
                break;
            }
        }
        
        return [ hit_position, hit_trigger ];
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 5, eflags: 0x4
    // Checksum 0x0, Offset: 0xafa
    // Size: 0xc2, Type: dev
    function private spawntrigger( player, origin, callbackfunction, name_id, var_d0b92e2643d628e8 )
    {
        if ( !isdefined( var_d0b92e2643d628e8 ) )
        {
            var_d0b92e2643d628e8 = undefined;
        }
        
        if ( !isdefined( callbackfunction ) )
        {
            assertmsg( "<dev string:x2b6>" );
            return;
        }
        
        iprintlnbold( "<dev string:x2ef>" );
        var_feecfa3f8f863590 = spawnstruct();
        thread namespace_5d1a752b8be8c9e4::function_c1903e1f99c29097( player, name_id, origin, 50, callbackfunction, var_feecfa3f8f863590, 0, var_d0b92e2643d628e8 );
        var_756880424ad892ac = spawnstruct();
        var_756880424ad892ac.callback_key = name_id;
        var_756880424ad892ac.trigger = var_feecfa3f8f863590.trigger;
        level.var_5f82a2a48defe497[ level.var_5f82a2a48defe497.size ] = var_756880424ad892ac;
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0xbc4
    // Size: 0xa8, Type: dev
    function private removetrigger( var_27202a3598424866 )
    {
        if ( !isdefined( var_27202a3598424866 ) )
        {
            return;
        }
        
        foreach ( index, trigger_struct in level.var_5f82a2a48defe497 )
        {
            if ( trigger_struct.trigger == var_27202a3598424866 )
            {
                trigger_struct.trigger delete();
                level.var_5f82a2a48defe497 = scripts\engine\utility::array_remove_index( level.var_5f82a2a48defe497, index );
                iprintlnbold( "<dev string:x301>" );
                break;
            }
        }
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0xc74
    // Size: 0x136, Type: dev
    function private function_dc51e459a8decdf3()
    {
        level endon( "<dev string:x266>" );
        level endon( "<dev string:x11b>" );
        
        for ( ;; )
        {
            current_state = function_a5197e589420f4ab();
            state_text = "<dev string:x314>";
            
            switch ( current_state )
            {
                case 1:
                    state_text = "<dev string:x318>";
                    break;
                case 2:
                    state_text = "<dev string:x328>";
                    break;
                case 0:
                    state_text = "<dev string:x33b>";
                    break;
            }
            
            printtoscreen2d( 600, 50, "<dev string:x358>" + state_text, ( 0.39, 0.58, 0.93 ), 1.7 );
            printtoscreen2d( 600, 80, "<dev string:x36b>" + "<dev string:x375>" + "<dev string:x37e>", ( 0.39, 0.58, 0.93 ), 1.2 );
            printtoscreen2d( 600, 110, "<dev string:x393>" + "<dev string:x288>" + "<dev string:x39b>", ( 0.39, 0.58, 0.93 ), 1.2 );
            printtoscreen2d( 600, 140, "<dev string:x3b6>" + string( level.var_5f82a2a48defe497.size ), ( 0.39, 0.58, 0.93 ), 1.2 );
            waitframe();
        }
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0xdb2
    // Size: 0x181, Type: dev
    function private function_2a9774c5ef7ef38( player )
    {
        player endon( "<dev string:x248>" );
        level endon( "<dev string:x266>" );
        level endon( "<dev string:x11b>" );
        var_af05d149771b822 = 1300;
        var_710aac06e3f6ca16 = 30;
        
        for ( ;; )
        {
            if ( function_a5197e589420f4ab() != 1 )
            {
                waitframe();
                continue;
            }
            
            var_92f077146228dc07 = 100;
            printtoscreen2d( var_af05d149771b822 - 100, var_92f077146228dc07 - var_710aac06e3f6ca16 - 10, "<dev string:x3d2>", ( 0.39, 0.58, 0.93 ), 1.8 );
            printtoscreen2d( var_af05d149771b822 - 120, var_92f077146228dc07 + 10, "<dev string:x3eb>" + "<dev string:x3f3>", ( 0, 1, 0 ), 1.3 );
            printtoscreen2d( var_af05d149771b822 - 120, var_92f077146228dc07 + 30, "<dev string:x3fb>" + "<dev string:x405>", ( 0, 1, 0 ), 1.3 );
            
            for ( i = 0; i < level.var_3d2b55060c917ac6.size ; i++ )
            {
                var_42487180feed4fe4 = level.var_3d2b55060c917ac6[ i ];
                var_9013fb8d6c6bf07 = ( 0.39, 0.58, 0.93 );
                text_scale = 1.2;
                
                if ( var_42487180feed4fe4.isselected )
                {
                    var_9013fb8d6c6bf07 = ( 0, 1, 0 );
                    text_scale = 1.6;
                }
                
                printtoscreen2d( var_af05d149771b822, var_92f077146228dc07, i + "<dev string:x40c>" + var_42487180feed4fe4.name_id, var_9013fb8d6c6bf07, text_scale );
                var_92f077146228dc07 += var_710aac06e3f6ca16;
            }
            
            waitframe();
        }
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0xf3b
    // Size: 0xcf, Type: dev
    function private function_b591f01924cc04aa( player )
    {
        player endon( "<dev string:x248>" );
        level endon( "<dev string:x266>" );
        level endon( "<dev string:x11b>" );
        button_down = 0;
        
        for ( ;; )
        {
            var_d35f184a4d9ff50b = function_a5197e589420f4ab();
            
            if ( var_d35f184a4d9ff50b == 1 && player buttonpressed( "<dev string:x405>" ) )
            {
                if ( !button_down )
                {
                    function_8de9f2582b68c9d8( "<dev string:x224>" );
                }
                
                button_down = 1;
            }
            else if ( var_d35f184a4d9ff50b == 1 && player buttonpressed( "<dev string:x3f3>" ) )
            {
                if ( !button_down )
                {
                    function_8de9f2582b68c9d8( "<dev string:x22c>" );
                }
                
                button_down = 1;
            }
            else if ( player buttonpressed( "<dev string:x375>" ) )
            {
                if ( !button_down )
                {
                    function_ad87353fd3346904( scripts\engine\utility::ter_op( var_d35f184a4d9ff50b == 1, 2, 1 ) );
                }
                
                button_down = 1;
            }
            else
            {
                button_down = 0;
            }
            
            waitframe();
        }
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 0
    // Checksum 0x0, Offset: 0x1012
    // Size: 0x121, Type: dev
    function function_285630d626038d0a()
    {
        function_af5563b5a361f220();
        
        if ( level.var_5f82a2a48defe497.size == 0 )
        {
            iprintlnbold( "<dev string:x412>" );
            return;
        }
        
        fileid = openfileinplayerdirectory( "<dev string:x439>", "<dev string:x457>", "<dev string:x1ee>" );
        
        if ( fileid == -1 )
        {
            return;
        }
        
        foreach ( trigger_struct in level.var_5f82a2a48defe497 )
        {
            origin = trigger_struct.trigger.origin;
            callback_key = trigger_struct.callback_key;
            var_a55a77cf9c58c0ba = "<dev string:x460>" + origin[ 0 ] + "<dev string:x46c>" + origin[ 1 ] + "<dev string:x46c>" + origin[ 2 ] + "<dev string:x472>" + callback_key + "<dev string:x483>";
            writelinetofileinplayerdirectory( fileid, var_a55a77cf9c58c0ba );
        }
        
        closefileinplayerdirectory( fileid );
        iprintlnbold( "<dev string:x488>" );
    }

    // Namespace namespace_13b520ef0ef94d22 / namespace_4121a3de9a9601c8
    // Params 1
    // Checksum 0x0, Offset: 0x113b
    // Size: 0x2ac, Type: dev
    function function_3769d0ae67ca1ee8( player )
    {
        if ( !isdefined( player ) )
        {
            player = undefined;
        }
        
        function_af5563b5a361f220();
        
        if ( !isdefined( player ) )
        {
            player = level.player;
        }
        
        if ( !isdefined( player ) )
        {
            assertmsg( "<dev string:x4c0>" );
            return;
        }
        
        fileid = openfileinplayerdirectory( "<dev string:x439>", "<dev string:x4d8>", "<dev string:x1ee>" );
        
        if ( fileid == -1 )
        {
            return;
        }
        
        filecontent = readfileinplayerdirectory( fileid );
        closefileinplayerdirectory( fileid );
        
        if ( filecontent == "<dev string:x314>" || filecontent == "<dev string:x4e0>" )
        {
            return;
        }
        
        function_dc0e0ebca84023c0();
        currentline = "<dev string:x314>";
        var_83dbc5b05ae7eaf9 = [];
        
        for ( i = 0; i < filecontent.size ; i++ )
        {
            if ( ( filecontent[ i ] == "<dev string:x4e5>" || i == filecontent.size - 1 ) && currentline != "<dev string:x314>" )
            {
                var_83dbc5b05ae7eaf9[ var_83dbc5b05ae7eaf9.size ] = currentline;
                currentline = "<dev string:x314>";
                continue;
            }
            
            currentline += filecontent[ i ];
        }
        
        foreach ( line in var_83dbc5b05ae7eaf9 )
        {
            origin = [];
            callback_key = "<dev string:x314>";
            var_4332c38ecd8e8ff6 = 0;
            var_2b629acca6af7bc6 = "<dev string:x314>";
            
            for ( i = 0; i < line.size ; i++ )
            {
                char = line[ i ];
                
                if ( char != "<dev string:x4ea>" && var_4332c38ecd8e8ff6 == 0 )
                {
                    continue;
                }
                else if ( var_4332c38ecd8e8ff6 == 0 )
                {
                    var_4332c38ecd8e8ff6 = 1;
                    continue;
                }
                
                if ( origin.size < 3 )
                {
                    if ( char != "<dev string:x4ef>" && char != "<dev string:x483>" )
                    {
                        var_2b629acca6af7bc6 += char;
                    }
                    else
                    {
                        origin[ origin.size ] = var_2b629acca6af7bc6;
                        var_2b629acca6af7bc6 = "<dev string:x314>";
                    }
                    
                    if ( origin.size == 3 )
                    {
                        var_4332c38ecd8e8ff6 = 0;
                    }
                    
                    continue;
                }
                
                if ( callback_key == "<dev string:x314>" )
                {
                    if ( char != "<dev string:x483>" )
                    {
                        var_2b629acca6af7bc6 += char;
                        continue;
                    }
                    
                    callback_key = var_2b629acca6af7bc6;
                    var_2b629acca6af7bc6 = "<dev string:x314>";
                    var_4332c38ecd8e8ff6 = 0;
                    break;
                }
            }
            
            origin_vector = ( float( origin[ 0 ] ), float( origin[ 1 ] ), float( origin[ 2 ] ) );
            var_1420a49e8ef59c78 = function_59ac18b7ff7350cf( callback_key );
            
            if ( isdefined( var_1420a49e8ef59c78 ) )
            {
                thread spawntrigger( player, origin_vector, var_1420a49e8ef59c78.callbackfunction, callback_key, var_1420a49e8ef59c78.var_d0b92e2643d628e8 );
            }
        }
        
        iprintlnbold( "<dev string:x4f4>" );
    }

#/
