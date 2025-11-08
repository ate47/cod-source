#using scripts\common\utility;
#using scripts\engine\utility;

#namespace debug_reflection;

/#

    // Namespace debug_reflection / scripts\common\debug_reflection
    // Params 1
    // Checksum 0x0, Offset: 0x78
    // Size: 0x19, Type: dev
    function init_reflection_probe( handleplayerconnect )
    {
        precachemodel( "<dev string:x1c>" );
    }

    // Namespace debug_reflection / scripts\common\debug_reflection
    // Params 0
    // Checksum 0x0, Offset: 0x99
    // Size: 0x2b, Type: dev
    function spplayerconnect()
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        level.player add_frame_event( &debug_reflection_probes );
    }

#/

// Namespace debug_reflection / scripts\common\debug_reflection
// Params 0
// Checksum 0x0, Offset: 0xcc
// Size: 0x45
function onplayerconnect()
{
    if ( isdefined( level.func_run_lean_threads ) && [[ level.func_run_lean_threads ]]() )
    {
        return;
    }
    
    /#
        for ( ;; )
        {
            level waittill( "<dev string:x2f>", player );
            player scripts\engine\utility::add_frame_event( &debug_reflection_probes );
        }
    #/
}

/#

    // Namespace debug_reflection / scripts\common\debug_reflection
    // Params 0
    // Checksum 0x0, Offset: 0x119
    // Size: 0x16a, Type: dev
    function debug_reflection_probes()
    {
        if ( getdvar( @"hash_925f7645ee214f2a" ) == "<dev string:x39>" && level.debug.reflection != 2 || getdvar( @"hash_925f7645ee214f2a" ) == "<dev string:x3b>" && level.debug.reflection != 3 )
        {
            function_da5718b2a8be7b0b();
            
            if ( getdvar( @"hash_925f7645ee214f2a" ) == "<dev string:x39>" )
            {
                level.debug.reflection = 2;
            }
            else
            {
                create_reflection_object();
                level.debug.reflection = 3;
            }
        }
        else if ( getdvar( @"hash_925f7645ee214f2a" ) == "<dev string:x3d>" && level.debug.reflection != 1 )
        {
            function_da5718b2a8be7b0b();
            create_reflection_object();
            level.debug.reflection = 1;
        }
        else if ( getdvar( @"hash_925f7645ee214f2a" ) == "<dev string:x3f>" && level.debug.reflection != 0 )
        {
            function_da5718b2a8be7b0b();
            level.debug.reflection = 0;
        }
        
        debug_reflection_buttons();
    }

    // Namespace debug_reflection / scripts\common\debug_reflection
    // Params 0
    // Checksum 0x0, Offset: 0x28b
    // Size: 0xa6, Type: dev
    function create_reflection_object()
    {
        self.var_93a1cb702f026ba7 = spawn( "<dev string:x41>", self geteye() + anglestoforward( self.angles ) * 100 );
        self.var_93a1cb702f026ba7 setmodel( "<dev string:x1c>" );
        self.var_93a1cb702f026ba7.origin = self geteye() + anglestoforward( self getplayerangles() ) * 100;
        object = self.var_93a1cb702f026ba7;
        object.offset = 100;
        object.lastoffset = object.offset;
    }

    // Namespace debug_reflection / scripts\common\debug_reflection
    // Params 0
    // Checksum 0x0, Offset: 0x339
    // Size: 0x47, Type: dev
    function function_da5718b2a8be7b0b()
    {
        if ( level.debug.reflection == 1 || level.debug.reflection == 3 )
        {
            self.var_93a1cb702f026ba7 delete();
        }
    }

    // Namespace debug_reflection / scripts\common\debug_reflection
    // Params 0
    // Checksum 0x0, Offset: 0x388
    // Size: 0xd9, Type: dev
    function debug_reflection_buttons()
    {
        if ( !isdefined( self.var_93a1cb702f026ba7 ) )
        {
            return;
        }
        
        object = self.var_93a1cb702f026ba7;
        
        if ( self buttonpressed( "<dev string:x4e>" ) )
        {
            object.offset += 50;
        }
        
        if ( self buttonpressed( "<dev string:x57>" ) )
        {
            object.offset -= 50;
        }
        
        object.offset = clamp( object.offset, 64, 1000 );
        object.origin = self geteye() + anglestoforward( self getplayerangles() ) * object.offset;
        object.lastoffset = object.offset;
    }

#/
