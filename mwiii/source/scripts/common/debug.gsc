#using scripts\engine\utility;

#namespace debug;

/#

    // Namespace debug / scripts\common\debug
    // Params 1
    // Checksum 0x0, Offset: 0xaa
    // Size: 0x96, Type: dev
    function function_a2eaafb222316a2( ent )
    {
        if ( !isdefined( ent ) )
        {
            return "<dev string:x1c>";
        }
        
        text = "<dev string:x20>" + "<dev string:x25>" + ent getentitynumber();
        
        if ( isdefined( ent.classname ) )
        {
            text = text + "<dev string:x2b>" + ent.classname + "<dev string:x3a>";
        }
        
        if ( isdefined( ent.model ) )
        {
            text = text + "<dev string:x3f>" + ent.model + "<dev string:x3a>";
        }
        
        text += "<dev string:x4a>";
        return text;
    }

    // Namespace debug / scripts\common\debug
    // Params 1
    // Checksum 0x0, Offset: 0x148
    // Size: 0x9c, Type: dev
    function function_57f3a2089db4a571( corpse )
    {
        if ( getdvarint( @"hash_f806a3434286263f", 0 ) != 0 )
        {
            level.var_57f3a2089db4a571 = 1;
            
            if ( isdefined( corpse ) )
            {
                entnum = corpse getentitynumber();
                cmd = "<dev string:x4f>" + entnum + "<dev string:x6c>" + entnum;
                adddebugcommand( cmd + "<dev string:x87>" );
            }
            
            return;
        }
        
        if ( isdefined( level.var_57f3a2089db4a571 ) && level.var_57f3a2089db4a571 )
        {
            adddebugcommand( "<dev string:x8c>" );
            level.var_57f3a2089db4a571 = undefined;
        }
    }

    // Namespace debug / scripts\common\debug
    // Params 1
    // Checksum 0x0, Offset: 0x1ec
    // Size: 0x2f, Type: dev
    function function_600b37e8cf3f2de9( ent )
    {
        if ( !isdefined( ent ) )
        {
            return "<dev string:x1c>";
        }
        
        if ( isent( ent ) )
        {
            return ( "<dev string:x25>" + ent getentitynumber() );
        }
    }

#/

// Namespace debug / scripts\common\debug
// Params 2
// Checksum 0x0, Offset: 0x223
// Size: 0x2c
function function_e8ee861a699bea81( variable, undefined_return )
{
    if ( isdefined( variable ) )
    {
        return ( variable + "" );
    }
    
    if ( isdefined( undefined_return ) )
    {
        return undefined_return;
    }
    
    return "";
}

// Namespace debug / scripts\common\debug
// Params 3
// Checksum 0x0, Offset: 0x258
// Size: 0x9f
function function_f9304b74bdeafdb0( button, before_text, after_text )
{
    self endon( "death" );
    
    while ( true )
    {
        if ( !self buttonpressed( button ) )
        {
            break;
        }
        
        waitframe();
    }
    
    while ( true )
    {
        if ( isdefined( before_text ) )
        {
            /#
                printtoscreen2d( 10, 100, "<dev string:xc5>" + button + "<dev string:xcf>" + before_text, ( 1, 1, 1 ), 2 );
            #/
        }
        
        if ( self buttonpressed( button ) )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isdefined( after_text ) )
    {
        iprintlnbold( after_text );
        return;
    }
    
    if ( isdefined( before_text ) )
    {
        iprintlnbold( "Performed:" + before_text );
    }
}

/#

    // Namespace debug / scripts\common\debug
    // Params 6
    // Checksum 0x0, Offset: 0x2ff
    // Size: 0x107, Type: dev
    function function_7320cd1e4f724899( text, color, duration, x, y, scale )
    {
        if ( !isdefined( level.var_252b0cb021ff0964 ) )
        {
            level.var_e28e2fe7eef54cc2 = [];
            level.var_44bacfb643ca44f = [];
            level.var_1ed355bf4419acb4 = [];
            level.var_252b0cb021ff0964 = 0;
            level thread function_64f6fe11a0db2eef( x, y, scale );
        }
        
        if ( !isdefined( text ) )
        {
            text = "<dev string:xd8>";
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( !isdefined( duration ) )
        {
            duration = getdvarfloat( @"hash_e7c6b5ac109cff25", 2 );
        }
        
        level.var_e28e2fe7eef54cc2[ level.var_252b0cb021ff0964 ] = text;
        level.var_44bacfb643ca44f[ level.var_252b0cb021ff0964 ] = gettime() + duration * 1000;
        level.var_1ed355bf4419acb4[ level.var_252b0cb021ff0964 ] = color;
        level.var_252b0cb021ff0964++;
    }

    // Namespace debug / scripts\common\debug
    // Params 3
    // Checksum 0x0, Offset: 0x40e
    // Size: 0x206, Type: dev
    function function_64f6fe11a0db2eef( x, y, scale )
    {
        level notify( "<dev string:x10e>" );
        level endon( "<dev string:x10e>" );
        
        if ( !isdefined( x ) )
        {
            x = getdvarint( @"scr_debug_print_x", 850 );
        }
        
        if ( !isdefined( y ) )
        {
            y = getdvarint( @"scr_debug_print_y", 100 );
        }
        
        if ( !isdefined( scale ) )
        {
            scale = getdvarfloat( @"scr_debug_print_scale", 2 );
        }
        
        while ( true )
        {
            waittillframeend();
            
            if ( getdvarint( @"hash_e4ceb718c4811e97", 1 ) )
            {
                keys = getarraykeys( level.var_44bacfb643ca44f );
                
                if ( keys.size > 0 )
                {
                    vid_width = getdvarint( @"vid_width" );
                    vid_height = getdvarint( @"vid_height" );
                    var_39c991ead8822d9b = getdvarint( @"vid_width" ) / 1920;
                    var_3f109f5aaf427a = getdvarint( @"vid_height" ) / 1080;
                    base_x = x * var_39c991ead8822d9b;
                    base_y = y * var_3f109f5aaf427a;
                    base_scale = scale * var_3f109f5aaf427a;
                }
                
                time = gettime();
                linecount = 0;
                
                foreach ( i in keys )
                {
                    if ( time > level.var_44bacfb643ca44f[ i ] )
                    {
                        level.var_44bacfb643ca44f[ i ] = undefined;
                        level.var_e28e2fe7eef54cc2[ i ] = undefined;
                        level.var_1ed355bf4419acb4[ i ] = undefined;
                        continue;
                    }
                    
                    linecount++;
                    printtoscreen2d( base_x, base_y + base_scale * 12 * linecount, level.var_e28e2fe7eef54cc2[ i ], level.var_1ed355bf4419acb4[ i ], base_scale );
                }
            }
            
            waitframe();
        }
    }

    // Namespace debug / scripts\common\debug
    // Params 6
    // Checksum 0x0, Offset: 0x61c
    // Size: 0x45, Type: dev
    function debug_sphere( target, radius, color, seconds, level_endon, target_endon )
    {
        level thread function_2061efdf2b62dcdc( target, radius, color, seconds, level_endon, target_endon );
    }

    // Namespace debug / scripts\common\debug
    // Params 6
    // Checksum 0x0, Offset: 0x669
    // Size: 0x10a, Type: dev
    function function_2061efdf2b62dcdc( target, radius, color, seconds, level_endon, target_endon )
    {
        if ( !isdefined( radius ) )
        {
            radius = 10;
        }
        
        target_vector = undefined;
        
        if ( isvector( target ) )
        {
            target_vector = target;
        }
        
        if ( isdefined( color ) && isstring( color ) )
        {
            color = get_color( color );
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        end_time = undefined;
        
        if ( isdefined( seconds ) )
        {
            end_time = gettime() + seconds * 1000;
        }
        
        if ( isdefined( level_endon ) )
        {
            level endon( level_endon );
        }
        
        if ( isdefined( target_endon ) )
        {
            assertex( !isvector( target ), "<dev string:x12c>" );
            target endon( target_endon );
        }
        
        while ( isdefined( target ) )
        {
            if ( isdefined( end_time ) && end_time < gettime() )
            {
                return;
            }
            
            if ( !isvector( target ) )
            {
                target_vector = target.origin;
            }
            
            sphere( target_vector, radius, color, 0, 1 );
            waitframe();
        }
    }

    // Namespace debug / scripts\common\debug
    // Params 7
    // Checksum 0x0, Offset: 0x77b
    // Size: 0x4f, Type: dev
    function debug_line( target, target2, color, seconds, level_endon, target_endon, target2_endon )
    {
        level thread function_43a9c3a623a796bd( target, target2, color, seconds, level_endon, target_endon, target2_endon );
    }

    // Namespace debug / scripts\common\debug
    // Params 7
    // Checksum 0x0, Offset: 0x7d2
    // Size: 0x166, Type: dev
    function function_43a9c3a623a796bd( target, target2, color, seconds, level_endon, target_endon, target2_endon )
    {
        target_vector = undefined;
        
        if ( isvector( target ) )
        {
            target_vector = target;
        }
        
        target2_vector = undefined;
        
        if ( isvector( target2 ) )
        {
            target2_vector = target2;
        }
        
        if ( isdefined( color ) && isstring( color ) )
        {
            color = get_color( color );
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        end_time = undefined;
        
        if ( isdefined( seconds ) )
        {
            end_time = gettime() + seconds * 1000;
        }
        
        if ( isdefined( level_endon ) )
        {
            level endon( level_endon );
        }
        
        if ( isdefined( target_endon ) )
        {
            assertex( !isvector( target ), "<dev string:x12c>" );
            target endon( target_endon );
        }
        
        if ( isdefined( target2_endon ) )
        {
            assertex( !isvector( target2 ), "<dev string:x12c>" );
            target2 endon( target2_endon );
        }
        
        while ( isdefined( target ) && isdefined( target2 ) )
        {
            if ( isdefined( end_time ) && end_time < gettime() )
            {
                return;
            }
            
            if ( !isvector( target ) )
            {
                target_vector = target.origin;
            }
            
            if ( !isvector( target2 ) )
            {
                target2_vector = target2.origin;
            }
            
            line( target_vector, target2_vector, color, 1, 0, 1 );
            waitframe();
        }
    }

    // Namespace debug / scripts\common\debug
    // Params 6
    // Checksum 0x0, Offset: 0x940
    // Size: 0x45, Type: dev
    function draw_angles( target, angles, radius, seconds, level_endon, target_endon )
    {
        level thread function_3a97db5a17888208( target, angles, radius, seconds, level_endon, target_endon );
    }

    // Namespace debug / scripts\common\debug
    // Params 6
    // Checksum 0x0, Offset: 0x98d
    // Size: 0x172, Type: dev
    function function_3a97db5a17888208( target, angles, radius, seconds, level_endon, target_endon )
    {
        if ( !isdefined( radius ) )
        {
            radius = 100;
        }
        
        target_vector = undefined;
        
        if ( isvector( target ) )
        {
            target_vector = target;
        }
        
        end_time = undefined;
        
        if ( isdefined( seconds ) )
        {
            end_time = gettime() + seconds * 1000;
        }
        
        if ( isdefined( level_endon ) )
        {
            level endon( level_endon );
        }
        
        if ( isdefined( target_endon ) )
        {
            assertex( !isvector( target ), "<dev string:x12c>" );
            target endon( target_endon );
        }
        
        while ( isdefined( target ) )
        {
            if ( isdefined( end_time ) && end_time < gettime() )
            {
                return;
            }
            
            if ( !isvector( target ) )
            {
                target_vector = target.origin;
                angles = target.angles;
            }
            
            forward = anglestoforward( angles );
            right = anglestoright( angles );
            up = anglestoup( angles );
            line( target_vector, target_vector + forward * radius, ( 1, 0, 0 ), 1, 0, 1 );
            line( target_vector, target_vector + right * radius, ( 0, 1, 0 ), 1, 0, 1 );
            line( target_vector, target_vector + up * radius, ( 0, 0, 1 ), 1, 0, 1 );
            waitframe();
        }
    }

    // Namespace debug / scripts\common\debug
    // Params 11
    // Checksum 0x0, Offset: 0xb07
    // Size: 0x77, Type: dev
    function interact( target, text, on_use_func, var_38669543a34ecd14, end_on_use, level_endon, target_endon, color, z_offset, alpha, scale )
    {
        level thread interact_internal( target, text, on_use_func, var_38669543a34ecd14, end_on_use, level_endon, target_endon, color, z_offset, alpha, scale );
    }

    // Namespace debug / scripts\common\debug
    // Params 11
    // Checksum 0x0, Offset: 0xb86
    // Size: 0x233, Type: dev
    function interact_internal( target, text, on_use_func, var_38669543a34ecd14, end_on_use, level_endon, target_endon, color, z_offset, alpha, scale )
    {
        if ( !isdefined( end_on_use ) )
        {
            end_on_use = 0;
        }
        
        if ( !isdefined( z_offset ) )
        {
            z_offset = 10;
        }
        
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        v_target = undefined;
        
        if ( isvector( target ) )
        {
            v_target = target;
        }
        else
        {
            v_target = target.origin;
        }
        
        interact = undefined;
        
        if ( issharedfuncdefined( "<dev string:x15b>", "<dev string:x163>" ) )
        {
            interact = [[ getsharedfunc( "<dev string:x15b>", "<dev string:x163>" ) ]]( v_target, "<dev string:x177>", undefined, undefined, 5, "<dev string:x186>", "<dev string:x198>", 100, 90, 100, 90 );
        }
        else
        {
            assertmsg( "<dev string:x1a0>" );
        }
        
        if ( isent( target ) )
        {
            interact linkto( target );
            interact thread utility::function_fe32d769b4bbd6a1( target, "<dev string:x1f2>" );
            target endon( "<dev string:x1f2>" );
        }
        
        if ( isdefined( level_endon ) )
        {
            level endon( level_endon );
            interact thread utility::function_fe32d769b4bbd6a1( level, level_endon );
        }
        
        if ( isdefined( target_endon ) )
        {
            assertex( !isvector( target ), "<dev string:x12c>" );
            target endon( target_endon );
            interact thread utility::function_fe32d769b4bbd6a1( target, target_endon );
        }
        
        if ( isdefined( color ) && isstring( color ) )
        {
            color = get_color( color );
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        if ( isdefined( text ) )
        {
            childthread function_bbc7faeb2e19df2d( interact, text, color, undefined, undefined, undefined, alpha, scale, z_offset );
        }
        
        childthread function_2061efdf2b62dcdc( interact, 2, color );
        
        while ( isdefined( target ) )
        {
            interact waittill( "<dev string:x203>", player );
            
            if ( isdefined( on_use_func ) )
            {
                if ( isdefined( var_38669543a34ecd14 ) )
                {
                    if ( !isarray( var_38669543a34ecd14 ) )
                    {
                        var_38669543a34ecd14 = [ var_38669543a34ecd14 ];
                    }
                    
                    level thread utility::single_func_argarray( player, on_use_func, var_38669543a34ecd14 );
                }
                else
                {
                    player thread [[ on_use_func ]]();
                }
            }
            
            if ( end_on_use )
            {
                interact delete();
                return;
            }
        }
    }

    // Namespace debug / scripts\common\debug
    // Params 9
    // Checksum 0x0, Offset: 0xdc1
    // Size: 0x63, Type: dev
    function debug_print3d( target, text, color, seconds, level_endon, target_endon, alpha, scale, z_offset )
    {
        level thread function_bbc7faeb2e19df2d( target, text, color, seconds, level_endon, target_endon, alpha, scale, z_offset );
    }

    // Namespace debug / scripts\common\debug
    // Params 9
    // Checksum 0x0, Offset: 0xe2c
    // Size: 0x146, Type: dev
    function function_bbc7faeb2e19df2d( target, text, color, seconds, level_endon, target_endon, alpha, scale, z_offset )
    {
        if ( !isdefined( alpha ) )
        {
            alpha = 1;
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 1;
        }
        
        if ( !isdefined( z_offset ) )
        {
            z_offset = 0;
        }
        
        v_target = undefined;
        
        if ( isvector( target ) )
        {
            v_target = target;
        }
        
        if ( isdefined( color ) && isstring( color ) )
        {
            color = get_color( color );
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        end_time = undefined;
        
        if ( isdefined( seconds ) )
        {
            end_time = gettime() + seconds * 1000;
        }
        
        if ( isdefined( level_endon ) )
        {
            level endon( level_endon );
        }
        
        if ( isdefined( target_endon ) )
        {
            assertex( !isvector( target ), "<dev string:x12c>" );
            target endon( target_endon );
        }
        
        while ( isdefined( target ) )
        {
            if ( isdefined( end_time ) && end_time < gettime() )
            {
                return;
            }
            
            if ( !isvector( target ) )
            {
                v_target = target.origin;
            }
            
            print3d( v_target + ( 0, 0, z_offset ), text, color, alpha, scale, 1, 1 );
            waitframe();
        }
    }

    // Namespace debug / scripts\common\debug
    // Params 1
    // Checksum 0x0, Offset: 0xf7a
    // Size: 0x2e7, Type: dev
    function get_color( color )
    {
        switch ( color )
        {
            case #"hash_97430f6c58e61cbc":
                return ( 1, 0, 0 );
            case #"hash_35bb3bd014c77f4b":
                return ( 1, 0.5, 0 );
            case #"hash_2ac407c1cd5943a9":
                return ( 1, 1, 0 );
            case #"hash_883ff07272b4f9c":
                return ( 0, 1, 0 );
            case #"hash_6686d129776d649a":
                return ( 0, 1, 1 );
            case #"hash_778bb52ecd08072d":
                return ( 0, 0, 1 );
            case #"hash_40fc63173753ec52":
                return ( 1, 0.5, 1 );
            case #"hash_598a30e44f53045f":
                return ( 0.5, 0, 1 );
            case #"hash_6eb69eb2e91f9fc8":
                return ( 1, 0, 1 );
            case #"hash_8c6e8e84936881cd":
                return ( 1, 0.75, 0.75 );
            case #"hash_1393412d7401c646":
                return ( 1, 1, 1 );
            case #"hash_a4324aac758f0a84":
                return ( 0, 0, 0 );
            case #"hash_dd71850f436e7706":
            case #"hash_dd7e8d0f437910fa":
                return ( 0.75, 0.75, 0.75 );
            case #"hash_2748da0737956f91":
            case #"hash_82bae0726e5ab95":
                return ( 0.1, 0.1, 0.1 );
            case #"hash_82bab0726e5a6dc":
            case #"hash_2748d70737956ad8":
                return ( 0.2, 0.2, 0.2 );
            case #"hash_82bac0726e5a86f":
            case #"hash_2748d80737956c6b":
                return ( 0.3, 0.3, 0.3 );
            case #"hash_82ba90726e5a3b6":
            case #"hash_2748dd073795744a":
                return ( 0.4, 0.4, 0.4 );
            case #"hash_82baa0726e5a549":
            case #"hash_2748de07379575dd":
                return ( 0.5, 0.5, 0.5 );
            case #"hash_2748db0737957124":
            case #"hash_82ba70726e5a090":
                return ( 0.6, 0.6, 0.6 );
            case #"hash_82ba80726e5a223":
            case #"hash_2748dc07379572b7":
                return ( 0.7, 0.7, 0.7 );
            case #"hash_82bb50726e5b69a":
            case #"hash_2748d10737956166":
                return ( 0.8, 0.8, 0.8 );
            case #"hash_82bb60726e5b82d":
            case #"hash_2748d207379562f9":
                return ( 0.9, 0.9, 0.9 );
            default:
                assertmsg( "<dev string:x32d>" );
                return undefined;
        }
    }

    // Namespace debug / scripts\common\debug
    // Params 6
    // Checksum 0x0, Offset: 0x1269
    // Size: 0x521, Type: dev
    function function_8245dce28f1f395c( dmg_data, original_damage, pre_final, display_time, display_scale, var_3b3652114fdefa9f )
    {
        if ( !isdefined( display_time ) )
        {
            display_time = 5;
        }
        
        if ( !isdefined( display_scale ) )
        {
            display_scale = 0.25;
        }
        
        if ( !isdefined( var_3b3652114fdefa9f ) )
        {
            var_3b3652114fdefa9f = 1;
        }
        
        if ( !isdefined( dmg_data ) || isdefined( dmg_data ) && !isarray( dmg_data ) )
        {
            return;
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        einflictor = isdefined( dmg_data[ "<dev string:x39b>" ] ) ? dmg_data[ "<dev string:x39b>" ] : undefined;
        eattacker = isdefined( dmg_data[ "<dev string:x3a9>" ] ) ? dmg_data[ "<dev string:x3a9>" ] : undefined;
        idamage = isdefined( dmg_data[ "<dev string:x3b6>" ] ) ? dmg_data[ "<dev string:x3b6>" ] : 0;
        smod = isdefined( dmg_data[ "<dev string:x3c1>" ] ) ? dmg_data[ "<dev string:x3c1>" ] : undefined;
        sweapon = isdefined( dmg_data[ "<dev string:x3d2>" ] ) ? dmg_data[ "<dev string:x3d2>" ] : undefined;
        vpoint = isdefined( dmg_data[ "<dev string:x3dd>" ] ) ? dmg_data[ "<dev string:x3dd>" ] : undefined;
        vdir = isdefined( dmg_data[ "<dev string:x3e7>" ] ) ? dmg_data[ "<dev string:x3e7>" ] : undefined;
        shitloc = isdefined( dmg_data[ "<dev string:x3ef>" ] ) ? dmg_data[ "<dev string:x3ef>" ] : undefined;
        objweapon = isdefined( dmg_data[ "<dev string:x3fa>" ] ) ? dmg_data[ "<dev string:x3fa>" ] : undefined;
        partname = isdefined( dmg_data[ "<dev string:x407>" ] ) ? dmg_data[ "<dev string:x407>" ] : undefined;
        tagname = isdefined( dmg_data[ "<dev string:x413>" ] ) ? dmg_data[ "<dev string:x413>" ] : undefined;
        
        if ( istrue( var_3b3652114fdefa9f ) )
        {
            if ( !isdefined( eattacker ) || isdefined( eattacker ) && !isplayer( eattacker ) && ( !isdefined( einflictor ) || isdefined( einflictor ) && !isplayer( einflictor ) ) )
            {
                return;
            }
        }
        
        if ( is_equal( display_time, -1 ) )
        {
            display_time = undefined;
        }
        
        s = "<dev string:x41e>" + self getentitynumber();
        
        if ( isdefined( einflictor ) )
        {
            s += "<dev string:x42d>" + einflictor getentitynumber();
        }
        
        if ( isdefined( eattacker ) )
        {
            s += "<dev string:x439>" + eattacker getentitynumber();
        }
        
        if ( isdefined( shitloc ) )
        {
            s += "<dev string:x445>" + shitloc;
        }
        
        s2 = "<dev string:x1c>";
        s2 += "<dev string:x44f>" + idamage;
        
        if ( isdefined( original_damage ) && original_damage != idamage )
        {
            s2 += "<dev string:x458>" + original_damage;
        }
        
        if ( isdefined( smod ) )
        {
            s2 += "<dev string:x467>" + smod;
        }
        
        s3 = "<dev string:x1c>";
        
        if ( isdefined( self ) && isdefined( self.health ) && isdefined( self.maxhealth ) )
        {
            if ( istrue( pre_final ) )
            {
                s3 = "<dev string:x470>" + self.health - idamage + "<dev string:x47c>" + self.maxhealth;
            }
            else
            {
                s3 = "<dev string:x470>" + self.health + "<dev string:x47c>" + self.maxhealth;
            }
        }
        
        s4 = "<dev string:x1c>";
        
        if ( isdefined( sweapon ) )
        {
            if ( isstring( sweapon ) )
            {
                s4 = "<dev string:x483>" + sweapon;
            }
            else if ( isdefined( sweapon.basename ) )
            {
                s4 = "<dev string:x483>" + sweapon.basename;
            }
        }
        else if ( isdefined( objweapon ) )
        {
            if ( isdefined( objweapon.basename ) )
            {
                s4 = "<dev string:x483>" + objweapon.basename;
            }
        }
        
        if ( isdefined( einflictor ) && isdefined( einflictor.weapon_name ) )
        {
            s4 += "<dev string:x48f>" + einflictor.weapon_name;
            weap_name = einflictor.weapon_name;
        }
        
        s5 = "<dev string:x4ab>";
        printloc = undefined;
        
        if ( isdefined( vpoint ) )
        {
            printloc = vpoint;
        }
        else if ( isdefined( self.origin ) )
        {
            printloc = self.origin;
        }
        
        if ( getdvarint( @"hash_81d89e4abec64203", 0 ) == 1 && isdefined( printloc ) )
        {
            debug_print3d( printloc, s, undefined, display_time, undefined, undefined, undefined, display_scale );
            debug_print3d( printloc, s2, undefined, display_time, undefined, undefined, undefined, display_scale, -5 );
            debug_print3d( printloc, s3, undefined, display_time, undefined, undefined, undefined, display_scale, -10 );
            debug_print3d( printloc, s4, undefined, display_time, undefined, undefined, undefined, display_scale, -15 );
            return;
        }
        
        if ( isdefined( display_time ) )
        {
            function_7320cd1e4f724899( s5, undefined, display_time );
            function_7320cd1e4f724899( s4, undefined, display_time );
            function_7320cd1e4f724899( s3, undefined, display_time );
            function_7320cd1e4f724899( s2, undefined, display_time );
            function_7320cd1e4f724899( s, undefined, display_time );
            return;
        }
        
        function_7320cd1e4f724899( s5, undefined, 300 );
        function_7320cd1e4f724899( s4, undefined, 300 );
        function_7320cd1e4f724899( s3, undefined, 300 );
        function_7320cd1e4f724899( s2, undefined, 300 );
        function_7320cd1e4f724899( s, undefined, 300 );
    }

#/
