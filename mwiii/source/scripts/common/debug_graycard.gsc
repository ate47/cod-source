#using scripts\common\utility;
#using scripts\engine\utility;

#namespace debug_graycard;

/#

    // Namespace debug_graycard / scripts\common\debug_graycard
    // Params 1
    // Checksum 0x0, Offset: 0x96
    // Size: 0xe1, Type: dev
    function init_graycard( handleplayerconnect )
    {
        setdevdvarifuninitialized( @"hash_a6381f8c58314102", "<dev string:x1c>" );
        setdevdvarifuninitialized( @"hash_1dfb6641a37c41f1", "<dev string:x1c>" );
        precachemodel( "<dev string:x21>" );
        precachemodel( "<dev string:x34>" );
        precachemodel( "<dev string:x57>" );
        precachemodel( "<dev string:x7c>" );
        precachemodel( "<dev string:x9b>" );
        precachemodel( "<dev string:xb8>" );
        precachemodel( "<dev string:xcf>" );
        precachemodel( "<dev string:xe8>" );
        precachemodel( "<dev string:x105>" );
        
        if ( !isdefined( level.debug ) )
        {
            level.debug = spawnstruct();
        }
        
        level.debug.graycard = 0;
        
        if ( isdefined( handleplayerconnect ) )
        {
            thread onplayerconnect();
            return;
        }
        
        thread spplayerconnect();
    }

    // Namespace debug_graycard / scripts\common\debug_graycard
    // Params 0
    // Checksum 0x0, Offset: 0x17f
    // Size: 0x2b, Type: dev
    function spplayerconnect()
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        level.player add_frame_event( &debug_gray_card );
    }

#/

// Namespace debug_graycard / scripts\common\debug_graycard
// Params 0
// Checksum 0x0, Offset: 0x1b2
// Size: 0x46
function onplayerconnect()
{
    if ( isdefined( level.func_run_lean_threads ) && [[ level.func_run_lean_threads ]]() )
    {
        return;
    }
    
    /#
        for ( ;; )
        {
            level waittill( "<dev string:x120>", player );
            player scripts\engine\utility::add_frame_event( &debug_gray_card_mp );
        }
    #/
}

/#

    // Namespace debug_graycard / scripts\common\debug_graycard
    // Params 0
    // Checksum 0x0, Offset: 0x200
    // Size: 0xe, Type: dev
    function debug_gray_card_mp()
    {
        debug_gray_card( 1 );
    }

    // Namespace debug_graycard / scripts\common\debug_graycard
    // Params 1
    // Checksum 0x0, Offset: 0x216
    // Size: 0x1be, Type: dev
    function debug_gray_card( ismp )
    {
        if ( !isdefined( ismp ) )
        {
            ismp = 0;
        }
        
        if ( getdvar( @"hash_a6381f8c58314102" ) == "<dev string:x12d>" )
        {
            if ( level.debug.graycard != 1 )
            {
                remove_graycard_objects();
                create_graycard_object();
                level.debug.graycard = 1;
            }
            
            debug_graycard_buttons( ismp );
        }
        else if ( getdvar( @"hash_a6381f8c58314102" ) == "<dev string:x1c>" && level.debug.graycard != 0 )
        {
            remove_graycard_objects();
            level.debug.graycard = 0;
        }
        
        switch ( getdvar( @"hash_1dfb6641a37c41f1" ) )
        {
            case #"hash_311010bc01bd3a0f":
                set_debug_models( "<dev string:x34>" );
                break;
            case #"hash_31100fbc01bd387c":
                set_debug_models( "<dev string:x57>" );
                break;
            case #"hash_311012bc01bd3d35":
                set_debug_models( "<dev string:x7c>" );
                break;
            case #"hash_311011bc01bd3ba2":
                set_debug_models( "<dev string:xb8>" );
                break;
            case #"hash_31100cbc01bd33c3":
                set_debug_models( "<dev string:x9b>" );
                break;
            case #"hash_31100bbc01bd3230":
                set_debug_models( "<dev string:x105>" );
                break;
            case #"hash_31100ebc01bd36e9":
                set_debug_models( "<dev string:xe8>" );
                break;
            case #"hash_31100dbc01bd3556":
                set_debug_models( "<dev string:x21>" );
                break;
            default:
                break;
        }
    }

    // Namespace debug_graycard / scripts\common\debug_graycard
    // Params 1
    // Checksum 0x0, Offset: 0x3dc
    // Size: 0xa0, Type: dev
    function set_debug_models( model )
    {
        if ( isdefined( level.debug.graycard_objects ) )
        {
            foreach ( ent in level.debug.graycard_objects )
            {
                ent setmodel( model );
            }
        }
        
        if ( isdefined( self.var_56868152de824f45 ) )
        {
            self.var_56868152de824f45 setmodel( model );
        }
    }

    // Namespace debug_graycard / scripts\common\debug_graycard
    // Params 0
    // Checksum 0x0, Offset: 0x484
    // Size: 0xa8, Type: dev
    function remove_graycard_objects()
    {
        if ( isdefined( level.debug.graycard_objects ) )
        {
            foreach ( ent in level.debug.graycard_objects )
            {
                ent delete();
            }
            
            level.debug.graycard_objects = undefined;
        }
        
        if ( isdefined( self.var_56868152de824f45 ) )
        {
            self.var_56868152de824f45 delete();
        }
    }

    // Namespace debug_graycard / scripts\common\debug_graycard
    // Params 0
    // Checksum 0x0, Offset: 0x534
    // Size: 0x75, Type: dev
    function create_graycard_object()
    {
        self.var_56868152de824f45 = spawn_graycard();
        object = self.var_56868152de824f45;
        object.offset = 100;
        object.lastoffset = object.offset;
        object.copy_released = 1;
        object.offsetangles = ( 0, 0, 0 );
    }

    // Namespace debug_graycard / scripts\common\debug_graycard
    // Params 0
    // Checksum 0x0, Offset: 0x5b1
    // Size: 0x32, Type: dev
    function spawn_graycard()
    {
        model = spawn( "<dev string:x150>", self.origin );
        model setmodel( "<dev string:xb8>" );
        return model;
    }

    // Namespace debug_graycard / scripts\common\debug_graycard
    // Params 1
    // Checksum 0x0, Offset: 0x5eb
    // Size: 0x27e, Type: dev
    function debug_graycard_buttons( ismp )
    {
        if ( !isdefined( self.var_56868152de824f45 ) )
        {
            return;
        }
        
        object = self.var_56868152de824f45;
        
        if ( self buttonpressed( "<dev string:x160>" ) )
        {
            object.offset += 5;
        }
        
        if ( self buttonpressed( "<dev string:x16c>" ) )
        {
            object.offset -= 5;
        }
        
        if ( self buttonpressed( "<dev string:x178>" ) )
        {
            object.offsetangles += ( 0, 6, 0 );
        }
        
        if ( self buttonpressed( "<dev string:x184>" ) )
        {
            object.offsetangles += ( 0, -6, 0 );
        }
        
        if ( self buttonpressed( "<dev string:x190>" ) )
        {
            object.offsetangles += ( 6, 0, 0 );
        }
        
        if ( self buttonpressed( "<dev string:x1a1>" ) )
        {
            object.offsetangles += ( -6, 0, 0 );
        }
        
        if ( self buttonpressed( "<dev string:x1b2>" ) )
        {
            object.offsetangles = ( 0, 0, 0 );
        }
        
        if ( object.copy_released )
        {
            if ( self buttonpressed( "<dev string:x1c3>" ) )
            {
                create_copy( object );
                object.copy_released = 0;
            }
        }
        else if ( !self buttonpressed( "<dev string:x1c3>" ) )
        {
            object.copy_released = 1;
        }
        
        if ( object.offset > 1000 )
        {
            object.offset = 1000;
        }
        
        if ( object.offset < 16 )
        {
            object.offset = 16;
        }
        
        if ( !ismp )
        {
            object unlink();
        }
        
        object.origin = self geteye() + anglestoforward( self getplayerangles() ) * object.offset;
        object.angles = combineangles( self getplayerangles(), object.offsetangles );
        object.lastoffset = object.offset;
        
        if ( !ismp )
        {
            object linkto( self );
        }
    }

    // Namespace debug_graycard / scripts\common\debug_graycard
    // Params 1
    // Checksum 0x0, Offset: 0x871
    // Size: 0x10e, Type: dev
    function create_copy( object )
    {
        copyobject = spawn_graycard();
        copyobject.origin = object.origin;
        copyobject.angles = object.angles;
        
        if ( !isdefined( level.debug.graycard_objects ) )
        {
            level.debug.graycard_objects = [ copyobject ];
            return;
        }
        
        if ( level.debug.graycard_objects.size > 50 )
        {
            level.debug.graycard_objects[ 0 ] delete();
            level.debug.graycard_objects = array_removeundefined( level.debug.graycard_objects );
        }
        
        level.debug.graycard_objects[ level.debug.graycard_objects.size ] = copyobject;
    }

#/
