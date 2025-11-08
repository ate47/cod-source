#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace devgui;

/#

    // Namespace devgui / scripts\common\devgui
    // Params 0
    // Checksum 0x0, Offset: 0x80
    // Size: 0x6b, Type: dev
    function init_devgui()
    {
        if ( !isdefined( level.var_7eea2b6a60c0f768 ) )
        {
            level.var_7eea2b6a60c0f768 = [];
        }
        
        if ( !isdefined( level.var_a7a2b0c1756d86a3 ) )
        {
            level.var_a7a2b0c1756d86a3 = [];
        }
        
        if ( !isdefined( level.devgui_threads ) )
        {
            level.devgui_threads = [];
        }
        
        level notify( "<dev string:x1c>" );
        level thread monitor_devgui();
        setdevdvarifuninitialized( @"hash_81d89e4abec64203", 0 );
    }

    // Namespace devgui / scripts\common\devgui
    // Params 0
    // Checksum 0x0, Offset: 0xf3
    // Size: 0xb7, Type: dev
    function function_de5696a0706893d4()
    {
        if ( isdefined( level.var_3abeb9746c41d178 ) )
        {
            return;
        }
        
        if ( level.var_de5696a0706893d4.size == 0 )
        {
            return;
        }
        
        level.var_3abeb9746c41d178 = 1;
        
        if ( !utility::issp() )
        {
            level scripts\engine\utility::flag_wait( "<dev string:x31>" );
        }
        
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        for ( i = 0; i < level.var_de5696a0706893d4.size ; i++ )
        {
            cmd = level.var_de5696a0706893d4[ i ];
            adddebugcommand( cmd + "<dev string:x49>" );
            
            if ( i % 5 == 0 )
            {
                waitframe();
            }
        }
        
        level.var_3abeb9746c41d178 = undefined;
        level.var_de5696a0706893d4 = undefined;
    }

    // Namespace devgui / scripts\common\devgui
    // Params 1
    // Checksum 0x0, Offset: 0x1b2
    // Size: 0x43, Type: dev
    function add_debug_command( cmd )
    {
        if ( !isdefined( level.var_de5696a0706893d4 ) )
        {
            level.var_de5696a0706893d4 = [];
        }
        
        level.var_de5696a0706893d4[ level.var_de5696a0706893d4.size ] = cmd;
        thread function_de5696a0706893d4();
    }

    // Namespace devgui / scripts\common\devgui
    // Params 3
    // Checksum 0x0, Offset: 0x1fd
    // Size: 0xc0, Type: dev
    function add_devgui_command( path, cmd, index )
    {
        if ( !isdefined( index ) )
        {
            assert( isdefined( level.var_d8852dd07270dbac ) );
            index = level.var_d8852dd07270dbac.index;
            level.var_d8852dd07270dbac.index++;
        }
        
        if ( isdefined( level.var_d8852dd07270dbac ) && isdefined( level.var_d8852dd07270dbac.base_path ) )
        {
            path = level.var_d8852dd07270dbac.base_path + path;
        }
        
        thread add_debug_command( "<dev string:x4b>" + path + "<dev string:x58>" + index + "<dev string:x5a>" + cmd + "<dev string:x5e>" );
    }

    // Namespace devgui / scripts\common\devgui
    // Params 5
    // Checksum 0x0, Offset: 0x2c5
    // Size: 0xf0, Type: dev
    function function_a9a864379a098ad6( path, name, func, toggle, index )
    {
        if ( !isdefined( index ) )
        {
            assert( isdefined( level.var_d8852dd07270dbac ) );
            index = level.var_d8852dd07270dbac.index;
            level.var_d8852dd07270dbac.index++;
        }
        
        if ( isdefined( level.var_d8852dd07270dbac ) && isdefined( level.var_d8852dd07270dbac.base_path ) )
        {
            path = level.var_d8852dd07270dbac.base_path + path;
        }
        
        thread add_debug_command( "<dev string:x4b>" + path + "<dev string:x58>" + index + "<dev string:x61>" + "<dev string:x69>" + "<dev string:x78>" + name + "<dev string:x5e>" );
        level.var_7eea2b6a60c0f768[ name ] = create_cmd( func, toggle );
    }

    // Namespace devgui / scripts\common\devgui
    // Params 3
    // Checksum 0x0, Offset: 0x3bd
    // Size: 0xc0, Type: dev
    function function_df648211d66cd3dd( path, dvar, index )
    {
        if ( !isdefined( index ) )
        {
            assert( isdefined( level.var_d8852dd07270dbac ) );
            index = level.var_d8852dd07270dbac.index;
            level.var_d8852dd07270dbac.index++;
        }
        
        if ( isdefined( level.var_d8852dd07270dbac ) && isdefined( level.var_d8852dd07270dbac.base_path ) )
        {
            path = level.var_d8852dd07270dbac.base_path + path;
        }
        
        thread add_debug_command( "<dev string:x7a>" + path + "<dev string:x58>" + index + "<dev string:x88>" + dvar + "<dev string:x49>" );
    }

    // Namespace devgui / scripts\common\devgui
    // Params 3
    // Checksum 0x0, Offset: 0x485
    // Size: 0xcd, Type: dev
    function function_b2159fbbd7ac094e( path, dvar_xhash, index )
    {
        if ( !isdefined( index ) )
        {
            assert( isdefined( level.var_d8852dd07270dbac ) );
            index = level.var_d8852dd07270dbac.index;
            level.var_d8852dd07270dbac.index++;
        }
        
        if ( isdefined( level.var_d8852dd07270dbac ) && isdefined( level.var_d8852dd07270dbac.base_path ) )
        {
            path = level.var_d8852dd07270dbac.base_path + path;
        }
        
        setdevdvarifuninitialized( dvar_xhash, 0 );
        thread add_debug_command( "<dev string:x4b>" + path + "<dev string:x58>" + index + "<dev string:x8b>" + getxhashsourcename( dvar_xhash ) + "<dev string:x97>" );
    }

    // Namespace devgui / scripts\common\devgui
    // Params 5
    // Checksum 0x0, Offset: 0x55a
    // Size: 0x12c, Type: dev
    function function_b23a59dfb4ca49a1( path, var_9af94c1035c9530e, func, toggle, index )
    {
        tokens = strtok( var_9af94c1035c9530e, "<dev string:x9e>" );
        name = tokens[ 0 ];
        params = scripts\engine\utility::array_remove_index( tokens, 0, 0 );
        
        if ( !isdefined( index ) )
        {
            assert( isdefined( level.var_d8852dd07270dbac ) );
            index = level.var_d8852dd07270dbac.index;
            level.var_d8852dd07270dbac.index++;
        }
        
        if ( isdefined( level.var_d8852dd07270dbac ) && isdefined( level.var_d8852dd07270dbac.base_path ) )
        {
            path = level.var_d8852dd07270dbac.base_path + path;
        }
        
        thread add_debug_command( "<dev string:x4b>" + path + "<dev string:x58>" + index + "<dev string:x61>" + "<dev string:x69>" + "<dev string:x78>" + var_9af94c1035c9530e + "<dev string:x5e>" );
        level.var_a7a2b0c1756d86a3[ name ] = create_cmd( func, toggle );
    }

    // Namespace devgui / scripts\common\devgui
    // Params 1
    // Checksum 0x0, Offset: 0x68e
    // Size: 0x8e, Type: dev
    function function_6e7290c8ee4f558b( base_path )
    {
        assertex( !isdefined( level.var_d8852dd07270dbac ), "<dev string:xa0>" );
        
        if ( isdefined( level.var_d8852dd07270dbac ) )
        {
            assertmsg( "<dev string:xd7>" + level.var_d8852dd07270dbac.base_path );
        }
        
        level.var_d8852dd07270dbac = spawnstruct();
        level.var_d8852dd07270dbac.index = 0;
        level.var_d8852dd07270dbac.base_path = base_path;
    }

    // Namespace devgui / scripts\common\devgui
    // Params 0
    // Checksum 0x0, Offset: 0x724
    // Size: 0x22, Type: dev
    function function_fe953f000498048f()
    {
        assert( isdefined( level.var_d8852dd07270dbac ) );
        level.var_d8852dd07270dbac = undefined;
    }

    // Namespace devgui / scripts\common\devgui
    // Params 0
    // Checksum 0x0, Offset: 0x74e
    // Size: 0xb0, Type: dev
    function function_9b4c82dba041b23d()
    {
        player = level.players[ 0 ];
        player_forward = anglestoforward( player getplayerangles() );
        result = scripts\engine\trace::ray_trace( player geteye(), player geteye() + player_forward * 10000 );
        
        if ( isdefined( result[ "<dev string:xfd>" ] ) && isdefined( result[ "<dev string:x106>" ] ) && result[ "<dev string:x106>" ] < 1 )
        {
            new_pos = drop_to_ground( result[ "<dev string:xfd>" ] + -1 * player_forward * 32, 24, -300 ) + ( 0, 0, 16 );
            return new_pos;
        }
        
        return undefined;
    }

    // Namespace devgui / scripts\common\devgui
    // Params 1
    // Checksum 0x0, Offset: 0x806
    // Size: 0x6a, Type: dev
    function function_5ee398aaf3f11e0d( params )
    {
        model = params[ 0 ];
        spawn_location = function_9b4c82dba041b23d();
        var_3f04053a805fbbc5 = getdvarfloat( @"hash_2ae4e76b04454913", 0 );
        spawned_object = spawn( "<dev string:x10f>", spawn_location + ( 0, 0, var_3f04053a805fbbc5 ) );
        spawned_object setmodel( model );
    }

    // Namespace devgui / scripts\common\devgui
    // Params 2
    // Checksum 0x0, Offset: 0x878
    // Size: 0x41, Type: dev
    function function_2fb888667001fc39( dvar, dvar_hash )
    {
        iprintlnbold( "<dev string:x11c>" + dvar + "<dev string:x124>" + !getdvarint( dvar_hash, 0 ) );
        setdvar( dvar_hash, !getdvarint( dvar_hash, 0 ) );
    }

    // Namespace devgui / scripts\common\devgui
    // Params 1
    // Checksum 0x0, Offset: 0x8c1
    // Size: 0x2f, Type: dev
    function function_7ac3c4c1bce16dd2( name )
    {
        return isdefined( self ) && isdefined( self.devgui_threads ) && isdefined( self.devgui_threads[ name ] );
    }

    // Namespace devgui / scripts\common\devgui
    // Params 3
    // Checksum 0x0, Offset: 0x8f8
    // Size: 0xac, Type: dev
    function toggle_thread( name, func, params )
    {
        if ( !isdefined( self.devgui_threads ) )
        {
            self.devgui_threads = [];
        }
        
        if ( function_7ac3c4c1bce16dd2( name ) )
        {
            self.devgui_threads[ name ] notify( "<dev string:x127>" );
            self.devgui_threads[ name ] = undefined;
            return;
        }
        
        self.devgui_threads[ name ] = spawnstruct();
        self.devgui_threads[ name ] endon( "<dev string:x127>" );
        self.devgui_threads[ name ] endon( "<dev string:x13b>" );
        
        if ( isdefined( params ) )
        {
            [[ func ]]( params );
        }
        else
        {
            [[ func ]]();
        }
        
        self.devgui_threads[ name ] = undefined;
    }

    // Namespace devgui / scripts\common\devgui
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x9ac
    // Size: 0x14c, Type: dev
    function private monitor_devgui()
    {
        level endon( "<dev string:x141>" );
        level endon( "<dev string:x1c>" );
        
        while ( true )
        {
            waitframe();
            name = getdvar( @"hash_f8ef099ef036c45e" );
            
            if ( name == "<dev string:x14c>" )
            {
                continue;
            }
            
            setdvar( @"hash_f8ef099ef036c45e", "<dev string:x14c>" );
            
            if ( isdefined( level.var_7eea2b6a60c0f768[ name ] ) )
            {
                if ( level.var_7eea2b6a60c0f768[ name ].toggle )
                {
                    level thread toggle_thread( name, level.var_7eea2b6a60c0f768[ name ].func );
                }
                else
                {
                    [[ level.var_7eea2b6a60c0f768[ name ].func ]]();
                }
                
                continue;
            }
            
            tokens = strtok( name, "<dev string:x9e>" );
            name = tokens[ 0 ];
            params = scripts\engine\utility::array_remove_index( tokens, 0, 0 );
            
            if ( isdefined( level.var_a7a2b0c1756d86a3[ name ] ) )
            {
                if ( level.var_a7a2b0c1756d86a3[ name ].toggle )
                {
                    level thread toggle_thread( name, level.var_a7a2b0c1756d86a3[ name ].func, params );
                    continue;
                }
                
                [[ level.var_a7a2b0c1756d86a3[ name ].func ]]( params );
            }
        }
    }

    // Namespace devgui / scripts\common\devgui
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0xb00
    // Size: 0x43, Type: dev
    function private create_cmd( func, toggle )
    {
        cmd = spawnstruct();
        cmd.func = func;
        cmd.toggle = istrue( toggle );
        return cmd;
    }

#/
