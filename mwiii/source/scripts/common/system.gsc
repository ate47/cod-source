#using scripts\engine\utility;

#namespace system;

// Namespace system / scripts\common\system
// Params 4
// Checksum 0x0, Offset: 0xac
// Size: 0x13a
function register( str_name, reqs, func_preinit, func_postinit )
{
    /#
        print( "<dev string:x1c>" + ( isxhash( str_name ) ? getxhashsourcename( str_name ) : str_name ) );
    #/
    
    level.system_funcs = default_to( level.system_funcs, [] );
    
    if ( isdefined( level.system_funcs[ str_name ] ) )
    {
        /#
            if ( !( level.system_funcs[ str_name ].flags & 1 ) )
            {
                system_error( "<dev string:x32>" + ( isxhash( str_name ) ? getxhashsourcename( str_name ) : str_name ) + "<dev string:x3e>" );
            }
        #/
        
        return;
    }
    
    system = { #flags:0, #reqs:reqs, #postfunc:func_postinit, #prefunc:func_preinit };
    system.flags |= isdefined( func_preinit ) ? 0 : 2;
    system.flags |= isdefined( func_postinit ) ? 0 : 4;
    level.system_funcs[ str_name ] = system;
}

// Namespace system / scripts\common\system
// Params 1
// Checksum 0x0, Offset: 0x1ee
// Size: 0x6d
function ignore( str_name )
{
    /#
        if ( isdefined( level.gametype ) )
        {
            system_error( "<dev string:x89>" );
            return;
        }
    #/
    
    if ( !isdefined( level.system_funcs[ str_name ] ) )
    {
        register( str_name );
    }
    
    level.system_funcs[ str_name ].flags |= 1;
}

// Namespace system / scripts\common\system
// Params 0
// Checksum 0x0, Offset: 0x263
// Size: 0x7e
function function_9c9c8162e507420()
{
    if ( !isdefined( level.system_funcs ) )
    {
        return;
    }
    
    foreach ( func in level.system_funcs )
    {
        function_5d3461c8ae875db7( func );
        
        if ( !( func.flags & 8 ) )
        {
            thread exec_pre_system( func );
        }
    }
}

// Namespace system / scripts\common\system
// Params 0
// Checksum 0x0, Offset: 0x2e9
// Size: 0x95
function function_d9624eb09b844ca1()
{
    if ( !isdefined( level.system_funcs ) )
    {
        return;
    }
    
    foreach ( func in level.system_funcs )
    {
        function_59d1eeac261314c4( func );
        
        if ( !( func.flags & 8 ) )
        {
            thread exec_post_system( func );
        }
    }
    
    level.system_funcs = undefined;
    level flag_set( "system_postinit_complete" );
}

// Namespace system / scripts\common\system
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x386
// Size: 0x74
function private exec_post_system( func )
{
    if ( !isdefined( func ) || func.flags & 1 )
    {
        return;
    }
    
    if ( !( func.flags & 4 ) )
    {
        if ( isdefined( func.reqs ) )
        {
            function_59d1eeac261314c4( func );
        }
        
        func.flags |= 4;
        [[ func.postfunc ]]();
    }
}

// Namespace system / scripts\common\system
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x402
// Size: 0x1af
function private function_59d1eeac261314c4( func )
{
    /#
        if ( !( func.flags & 2 || func.flags & 1 ) )
        {
            system_error( "<dev string:xc6>" );
            func.flags |= 8;
            return;
        }
    #/
    
    if ( isdefined( func.reqs ) )
    {
        if ( isarray( func.reqs ) )
        {
            foreach ( req in func.reqs )
            {
                /#
                    if ( !isdefined( req ) )
                    {
                        system_error( "<dev string:x132>" + req + "<dev string:x15b>" );
                        func.flags |= 8;
                        continue;
                    }
                #/
                
                thread exec_post_system( level.system_funcs[ req ] );
            }
            
            return;
        }
        
        /#
            if ( !isdefined( level.system_funcs[ func.reqs ] ) )
            {
                system_error( "<dev string:x132>" + ( isxhash( func.reqs ) ? getxhashsourcename( func.reqs ) : func.reqs ) + "<dev string:x15b>" );
                func.flags |= 8;
                return;
            }
        #/
        
        thread exec_post_system( level.system_funcs[ func.reqs ] );
    }
}

// Namespace system / scripts\common\system
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5b9
// Size: 0x74
function private exec_pre_system( func )
{
    if ( !isdefined( func ) || func.flags & 1 )
    {
        return;
    }
    
    if ( !( func.flags & 2 ) )
    {
        if ( isdefined( func.reqs ) )
        {
            function_5d3461c8ae875db7( func );
        }
        
        [[ func.prefunc ]]();
        func.flags |= 2;
    }
}

// Namespace system / scripts\common\system
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x635
// Size: 0x162
function private function_5d3461c8ae875db7( func )
{
    if ( isdefined( func.reqs ) )
    {
        if ( isarray( func.reqs ) )
        {
            foreach ( req in func.reqs )
            {
                /#
                    if ( !isdefined( req ) )
                    {
                        system_error( "<dev string:x132>" + req + "<dev string:x15b>" );
                        func.flags |= 8;
                        continue;
                    }
                #/
                
                thread exec_pre_system( level.system_funcs[ req ] );
            }
            
            return;
        }
        
        /#
            if ( !isdefined( level.system_funcs[ func.reqs ] ) )
            {
                system_error( "<dev string:x132>" + ( isxhash( func.reqs ) ? getxhashsourcename( func.reqs ) : func.reqs ) + "<dev string:x15b>" );
                func.flags |= 8;
                return;
            }
        #/
        
        thread exec_pre_system( level.system_funcs[ func.reqs ] );
    }
}

// Namespace system / scripts\common\system
// Params 0
// Checksum 0x0, Offset: 0x79f
// Size: 0xf
function function_3f680182ad0b9ef7()
{
    level flag_wait( "system_postinit_complete" );
}

// Namespace system / scripts\common\system
// Params 1
// Checksum 0x0, Offset: 0x7b6
// Size: 0x4d
function system_error( msg )
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) != 0 || getdvarint( @"g_connectpaths" ) != 0 )
        {
            print( "<dev string:x160>" + msg );
            return;
        }
    #/
    
    assertmsg( msg );
}

