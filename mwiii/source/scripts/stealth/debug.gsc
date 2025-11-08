#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;
#using scripts\stealth\utility;

#namespace debug;

/#

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0xa8
    // Size: 0x148, Type: dev
    function debug_manager()
    {
        setdvarifuninitialized( @"debug_stealth", "<dev string:x1c>" );
        setdvarifuninitialized( @"hash_a3c8097b0584ad3c", "<dev string:x1c>" );
        setdvarifuninitialized( @"hash_29199fda70b29985", "<dev string:x1c>" );
        setdvarifuninitialized( @"hash_e24fb561372dfef1", -1 );
        setdvarifuninitialized( @"hash_d036770ff7a14497", "<dev string:x1c>" );
        setdvarifuninitialized( @"hash_f30debd28e3f37e1", "<dev string:x1c>" );
        setdvarifuninitialized( @"hash_99b5f3d24be9d6ca", "<dev string:x21>" );
        setdvarifuninitialized( @"hash_936a3d04dd90f9b7", "<dev string:x1c>" );
        thread function_459a4d528437596();
        registersharedfunc( "<dev string:x25>", "<dev string:x36>", &function_55f9cd7d60a115bb );
        
        while ( true )
        {
            waitframe();
            
            if ( !debug_enabled() )
            {
                continue;
            }
            
            draw_corpses();
            function_dd7ad6e8da294b01( "<dev string:x4c>", "<dev string:x57>" );
            function_dd7ad6e8da294b01( "<dev string:x4c>", "<dev string:x6c>" + flag( "<dev string:x81>" ) );
            function_dd7ad6e8da294b01( "<dev string:x4c>", "<dev string:x94>" + flag( "<dev string:xa9>" ) );
            function_20367cc98c4d2265( "<dev string:x4c>" );
            function_df6b11367f42a8e1();
            function_47439b5d33f2695a();
            function_477aac1963f8269e();
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x1f8
    // Size: 0x188, Type: dev
    function debug_player()
    {
        self endon( "<dev string:xbc>" );
        hudelem = newclienthudelem( self );
        hudelem.x = -50;
        hudelem.y = 450;
        hudelem.color = ( 0.5, 1, 0.5 );
        hudelem.archived = 0;
        hudelem setdevtext( "<dev string:xc5>" );
        z = 0;
        space = 10;
        tab = "<dev string:xdf>";
        
        while ( true )
        {
            if ( debug_enabled() )
            {
                if ( !isdefined( level.player.stealth ) || !level.player flag( "<dev string:x81>" ) )
                {
                    hudelem.alpha = 0;
                }
                else
                {
                    hudelem.alpha = 1;
                }
                
                function_dd7ad6e8da294b01( "<dev string:xe5>", "<dev string:xef>" );
                function_dd7ad6e8da294b01( "<dev string:xe5>", "<dev string:xfb>" + self.script_stealthgroup );
                function_dd7ad6e8da294b01( "<dev string:xe5>", "<dev string:x10e>" + level.player.maxvisibledist );
                
                if ( level.player ent_flag( "<dev string:x122>" ) )
                {
                    function_dd7ad6e8da294b01( "<dev string:xe5>", "<dev string:x137>" );
                }
            }
            else
            {
                hudelem.alpha = 0;
            }
            
            function_20367cc98c4d2265( "<dev string:xe5>" );
            waitframe();
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x388
    // Size: 0xa0, Type: dev
    function debug_friendly()
    {
        self endon( "<dev string:xbc>" );
        setdvarifuninitialized( @"hash_67d1d2d65d5da2ab", "<dev string:x144>" );
        
        while ( true )
        {
            if ( debug_enabled() )
            {
                space = 10;
                count = 0;
                
                if ( ent_flag( "<dev string:x122>" ) )
                {
                    print3d( self.origin + ( 0, 0, count * space * -1 ), "<dev string:x14a>", ( 0.2, 1, 0.2 ), 1, 0.5 );
                }
                
                count++;
                draw_enemies( "<dev string:x157>" );
                waitframe();
                continue;
            }
            
            wait 1;
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x430
    // Size: 0xb2, Type: dev
    function debug_enemy()
    {
        self endon( "<dev string:xbc>" );
        setdvarifuninitialized( @"hash_9e5e998ddfcc8447", "<dev string:x144>" );
        setdvarifuninitialized( @"hash_a1d5d00556c4bddd", "<dev string:x1c>" );
        setdevdvarifuninitialized( @"hash_f9e17cb98b253864", 0 );
        
        while ( true )
        {
            if ( istrue( self.in_melee_death ) )
            {
                return;
            }
            
            if ( debug_enabled() )
            {
                if ( debug_entindex() == -1 || debug_entindex() == self getentitynumber() )
                {
                    function_499e30b2511f6c94();
                }
                
                num = function_c1b2391e0af178d();
                
                if ( num == self getentitynumber() )
                {
                    function_a02eac45a40e4217();
                }
                
                waitframe();
                continue;
            }
            
            wait 1;
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x4ea
    // Size: 0x2b, Type: dev
    function debug_enabled()
    {
        dvar = getunarchiveddebugdvar( @"debug_stealth", "<dev string:x1c>" );
        return int( dvar );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x51d
    // Size: 0x14, Type: dev
    function debug_entindex()
    {
        return getdvarint( @"ai_debugentindex" );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x539
    // Size: 0x2b, Type: dev
    function function_c1b2391e0af178d()
    {
        dvar = getunarchiveddebugdvar( @"hash_9e5e998ddfcc8447", "<dev string:x144>" );
        return int( dvar );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x56c
    // Size: 0x2b, Type: dev
    function function_d9143f39f30fecf1()
    {
        dvar = getunarchiveddebugdvar( @"hash_67d1d2d65d5da2ab", "<dev string:x144>" );
        return int( dvar );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x59f
    // Size: 0x2b, Type: dev
    function function_ca7435750eb63fe6()
    {
        dvar = getunarchiveddebugdvar( @"hash_a1d5d00556c4bddd", "<dev string:x1c>" );
        return int( dvar );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x5d2
    // Size: 0x2b, Type: dev
    function function_a8005409dfbcbb79()
    {
        dvar = getunarchiveddebugdvar( @"hash_a3c8097b0584ad3c", "<dev string:x1c>" );
        return int( dvar );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x605
    // Size: 0x2b, Type: dev
    function function_68a6af3bcbe8d474()
    {
        dvar = getunarchiveddebugdvar( @"hash_29199fda70b29985", "<dev string:x1c>" );
        return int( dvar );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x638
    // Size: 0x2b, Type: dev
    function function_4f071e84ae5ccf30()
    {
        dvar = getunarchiveddebugdvar( @"hash_d036770ff7a14497", "<dev string:x1c>" );
        return int( dvar );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x66b
    // Size: 0x2b, Type: dev
    function function_79c554909de26a4c()
    {
        dvar = getunarchiveddebugdvar( @"hash_f30debd28e3f37e1", "<dev string:x1c>" );
        return int( dvar );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x69e
    // Size: 0x2b, Type: dev
    function function_ff38e8c9a6564c50()
    {
        dvar = getunarchiveddebugdvar( @"hash_350b154807f4d745", "<dev string:x1c>" );
        return int( dvar );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x6d1
    // Size: 0x19, Type: dev
    function function_6a4e0953fbd5e6bc()
    {
        return getunarchiveddebugdvar( @"hash_99b5f3d24be9d6ca", "<dev string:x1c>" );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 3
    // Checksum 0x0, Offset: 0x6f2
    // Size: 0x68, Type: dev
    function thick_line( start, end, color )
    {
        num = 3;
        
        for ( i = 0; i < num ; i++ )
        {
            start += ( 0, 0, num * 0.05 );
            end += ( 0, 0, num * 0.05 );
            line( start, end, color );
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 4
    // Checksum 0x0, Offset: 0x762
    // Size: 0x71, Type: dev
    function thick_cylinder( start, end, radius, color )
    {
        num = 3;
        
        for ( i = 0; i < num ; i++ )
        {
            start += ( 0, 0, num * 0.05 );
            end += ( 0, 0, num * 0.05 );
            cylinder( start, end, radius, color );
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 1
    // Checksum 0x0, Offset: 0x7db
    // Size: 0x101, Type: dev
    function function_804ccafa69edd640( msg )
    {
        if ( !flag( "<dev string:x81>" ) )
        {
            return;
        }
        
        type = undefined;
        name = undefined;
        
        if ( isdefined( self.script_noteworthy ) )
        {
            type = "<dev string:x161>";
            name = self.script_noteworthy;
        }
        else if ( isdefined( self.targetname ) )
        {
            type = "<dev string:x176>";
            name = self.targetname;
        }
        
        actor = "<dev string:x184>" + self getentitynumber() + "<dev string:x198>" + self.unique_id + "<dev string:x1a1>" + self.export;
        
        if ( isdefined( type ) )
        {
            actor += "<dev string:x1ae>" + type + "<dev string:x1b3>" + name;
        }
        
        txt = "<dev string:x1b9>" + actor + "<dev string:x1cb>" + msg;
        println( txt );
        
        if ( getdvarint( @"hash_60656e331eb4e226" ) == 1 )
        {
            thread function_24051a9bda001947( msg );
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 2
    // Checksum 0x0, Offset: 0x8e4
    // Size: 0x109, Type: dev
    function function_dd7ad6e8da294b01( type, msg )
    {
        if ( !isdefined( level.stealth.debug.screen[ type ] ) )
        {
            level.stealth.debug.screen[ type ] = 0;
        }
        
        x = 10;
        
        if ( type == "<dev string:x4c>" )
        {
            y = 50;
        }
        else if ( type == "<dev string:xe5>" )
        {
            y = 150;
        }
        else if ( type == "<dev string:x1d5>" )
        {
            y = 250;
        }
        else
        {
            y = 350;
        }
        
        y += level.stealth.debug.screen[ type ] * 15;
        printtoscreen2d( x, y, msg, ( 1, 1, 1 ), 1.25 );
        level.stealth.debug.screen[ type ]++;
    }

    // Namespace debug / scripts\stealth\debug
    // Params 1
    // Checksum 0x0, Offset: 0x9f5
    // Size: 0x2f, Type: dev
    function function_20367cc98c4d2265( type )
    {
        level.stealth.debug.screen[ type ] = 0;
    }

    // Namespace debug / scripts\stealth\debug
    // Params 2
    // Checksum 0x0, Offset: 0xa2c
    // Size: 0xc2, Type: dev
    function debug_points( points, endonevent )
    {
        if ( !debug_enabled() )
        {
            return;
        }
        
        self endon( "<dev string:xbc>" );
        self endon( endonevent );
        
        while ( true )
        {
            foreach ( point in points )
            {
                if ( isdefined( point.used_time ) )
                {
                    print3d( point.origin, "<dev string:x21>" + point.used_time );
                    line( point.origin, self.origin );
                }
            }
            
            waitframe();
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 1
    // Checksum 0x0, Offset: 0xaf6
    // Size: 0x123, Type: dev
    function debug_alert( type )
    {
        if ( !debug_enabled() )
        {
            return;
        }
        
        self endon( "<dev string:xbc>" );
        self notify( "<dev string:x1dd>" );
        self endon( "<dev string:x1dd>" );
        color = ( 0.2, 1, 0.2 );
        msg = "<dev string:x1f1>";
        
        if ( type == "<dev string:x1fb>" )
        {
            color = ( 1, 1, 0 );
            msg = "<dev string:x207>";
        }
        else if ( type == "<dev string:x20c>" )
        {
            color = ( 1, 0.5, 0.25 );
            msg = "<dev string:x207>";
        }
        else if ( type == "<dev string:x218>" )
        {
            color = ( 1, 0, 0 );
            msg = "<dev string:x222>";
        }
        else if ( type == "<dev string:x227>" )
        {
            color = ( 1, 0, 0 );
            msg = "<dev string:x236>";
        }
        
        timer = gettime() + 5000;
        
        while ( gettime() < timer )
        {
            waitframe();
            print3d( self.origin + ( 0, 0, 72 ), msg, color, 1, 3 );
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 4
    // Checksum 0x0, Offset: 0xc21
    // Size: 0x47, Type: dev
    function function_48c141571ea55421( msg, offset, scale, color )
    {
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        function_55f9cd7d60a115bb( msg, color, 1, scale, offset );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 6
    // Checksum 0x0, Offset: 0xc70
    // Size: 0x3f9, Type: dev
    function function_55f9cd7d60a115bb( text, color, alpha, scale, offset, life )
    {
        if ( !debug_enabled() && !function_ff38e8c9a6564c50() )
        {
            return;
        }
        
        if ( !isdefined( text ) || !isdefined( self.stealth ) )
        {
            return;
        }
        
        if ( !isdefined( offset ) )
        {
            offset = ( 0, 0, 92 );
        }
        
        if ( !isdefined( scale ) )
        {
            scale = 0.5;
        }
        
        if ( !isdefined( life ) )
        {
            life = 3;
        }
        
        spacing = 10 * scale;
        riserate = 0;
        start = gettime();
        
        if ( !isdefined( self.stealth.debug_rising ) )
        {
            self.stealth.debug_rising = [];
            self.stealth.var_75968050cd6ebe9f = -1;
        }
        
        self.stealth.var_75968050cd6ebe9f++;
        myid = self.stealth.var_75968050cd6ebe9f;
        self.stealth.debug_rising[ myid ] = offset;
        previd = myid - 1;
        
        while ( isdefined( self.stealth.debug_rising[ previd ] ) )
        {
            delta = self.stealth.debug_rising[ previd ][ 2 ] - self.stealth.debug_rising[ previd + 1 ][ 2 ];
            
            if ( delta >= spacing )
            {
                break;
            }
            
            self.stealth.debug_rising[ previd ] = ( self.stealth.debug_rising[ previd ][ 0 ], self.stealth.debug_rising[ previd ][ 1 ], self.stealth.debug_rising[ previd + 1 ][ 2 ] + spacing + delta );
            previd -= 1;
        }
        
        draworigin = self.stealth.debug_rising[ myid ];
        
        while ( gettime() - start < life * 1000 )
        {
            waitframe();
            
            if ( isdefined( self ) && isalive( self ) && isdefined( self.stealth ) && isdefined( self.stealth.debug_rising ) && isdefined( self.stealth.debug_rising[ myid ] ) )
            {
                draworigin = self.origin + self.stealth.debug_rising[ myid ];
            }
            
            print3d( draworigin, text, color, alpha, scale, 1 );
            draworigin = ( draworigin[ 0 ], draworigin[ 1 ], draworigin[ 2 ] + riserate );
            
            if ( isdefined( self ) && isalive( self ) && isdefined( self.stealth ) && isdefined( self.stealth.debug_rising ) && isdefined( self.stealth.debug_rising[ myid ] ) )
            {
                self.stealth.debug_rising[ myid ] = ( self.stealth.debug_rising[ myid ][ 0 ], self.stealth.debug_rising[ myid ][ 1 ], self.stealth.debug_rising[ myid ][ 2 ] + riserate );
            }
        }
        
        if ( isdefined( self ) && isalive( self ) && isdefined( self.stealth ) && isdefined( self.stealth.debug_rising ) && isdefined( self.stealth.debug_rising[ myid ] ) )
        {
            self.stealth.debug_rising[ myid ] = undefined;
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 2
    // Checksum 0x0, Offset: 0x1071
    // Size: 0x166, Type: dev
    function draw_enemies( team, offset )
    {
        enemies = getaiarray( team );
        
        if ( team == "<dev string:x157>" )
        {
            enemies[ enemies.size ] = level.player;
        }
        
        yellow = ( 1, 1, 0 );
        green = ( 0, 1, 0 );
        red = ( 1, 0, 0 );
        
        foreach ( enemy in enemies )
        {
            yellow_dist = squared( enemy.maxvisibledist + 200 );
            vis_dist = squared( enemy.maxvisibledist );
            distsqrd = distancesquared( enemy.origin, self.origin );
            
            if ( distsqrd < vis_dist )
            {
                color = red;
            }
            else if ( distsqrd < yellow_dist )
            {
                color = yellow;
            }
            else
            {
                color = green;
            }
            
            line( self.origin, enemy.origin, color );
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 1
    // Checksum 0x0, Offset: 0x11df
    // Size: 0xa4, Type: dev
    function function_159af129de631d3e( agent )
    {
        dvar = getunarchiveddebugdvar( @"hash_f9e17cb98b253864", "<dev string:x1c>" );
        
        if ( isdefined( agent ) )
        {
            switch ( dvar )
            {
                case #"hash_31100fbc01bd387c":
                    return 1;
                case #"hash_311012bc01bd3d35":
                    if ( agent.type != "<dev string:x246>" )
                    {
                        return 1;
                    }
                    
                    return 0;
                case #"hash_311011bc01bd3ba2":
                    if ( agent.type == "<dev string:x246>" )
                    {
                        return 1;
                    }
                    
                    return 0;
                default:
                    return 0;
            }
        }
        
        return 0;
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x128b
    // Size: 0x5cc, Type: dev
    function function_6ed101071f87cd39()
    {
        count = 0;
        var_39670b09f106e922 = function_159af129de631d3e( self );
        
        if ( var_39670b09f106e922 )
        {
            space = 20;
            white = ( 1, 1, 1 );
            red = ( 1, 0, 0 );
            yellow = ( 1, 1, 0 );
            green = ( 0, 1, 0 );
            size = 1;
            agenttype = "<dev string:x21>";
            viewpos = level.players[ 0 ] getvieworigin();
            scale = utility::function_5a18f19c457e5d1a( self.origin, viewpos, 1200 );
            
            if ( scale < 2 )
            {
                size *= scale;
                space *= scale;
            }
            
            if ( isdefined( self.agent_type ) )
            {
                agenttype += "<dev string:x255>" + self.agent_type;
            }
            
            if ( agenttype.size > 0 )
            {
                print3d( self.origin - ( 0, 0, count * space ), agenttype, white, 1, size );
                count++;
            }
            
            str_spawnfilter = "<dev string:x21>";
            
            if ( isdefined( self.ob ) && isdefined( self.ob.spawnfilter ) )
            {
                str_spawnfilter += "<dev string:x25f>" + self.ob.spawnfilter;
            }
            
            if ( str_spawnfilter.size > 0 )
            {
                print3d( self.origin - ( 0, 0, count * space ), str_spawnfilter, white, 1, size );
                count++;
            }
            
            agentstats = "<dev string:x21>";
            healthcolor = green;
            
            if ( isdefined( self.health ) )
            {
                agentstats += "<dev string:x270>" + self.health + "<dev string:x27d>" + self.maxhealth + "<dev string:x282>";
                healthpct = self.health / self.maxhealth;
                
                if ( healthpct < 0.33 )
                {
                    healthcolor = red;
                }
                else if ( healthpct < 0.66 )
                {
                    healthcolor = yellow;
                }
                
                if ( isdefined( self.armorhealth ) )
                {
                    agentstats += "<dev string:x287>" + self.armorhealth + "<dev string:x294>";
                }
            }
            
            if ( agentstats.size > 0 )
            {
                print3d( self.origin - ( 0, 0, count * space ), agentstats, healthcolor, 1, size );
                count++;
            }
            
            loadout = "<dev string:x21>";
            
            if ( isdefined( self.primaryweapon ) )
            {
                loadout += "<dev string:x29b>" + getweaponbasename( self.primaryweapon );
                
                if ( isdefined( self.secondaryweapon ) )
                {
                    loadout += "<dev string:x2a2>" + getweaponnamewithdefaultattachments( self.secondaryweapon );
                }
            }
            
            if ( loadout.size > 0 )
            {
                print3d( self.origin - ( 0, 0, count * space ), loadout, white, 1, size );
                count++;
            }
            
            str_accuracy = "<dev string:x21>";
            
            if ( isdefined( self.accuracy ) )
            {
                str_accuracy += "<dev string:x2aa>" + self.accuracy + "<dev string:x2b8>" + self.baseaccuracy;
            }
            
            if ( str_accuracy.size > 0 )
            {
                print3d( self.origin - ( 0, 0, count * space ), str_accuracy, white, 1, size );
                count++;
            }
            
            var_47a2f514cd9c0063 = "<dev string:x21>";
            var_ce72f9835ebc188e = "<dev string:x21>";
            
            if ( isdefined( self.var_4268b42fc89d0be9 ) )
            {
                var_47a2f514cd9c0063 += "<dev string:x2c5>" + self.var_4268b42fc89d0be9 + "<dev string:x2d4>" + round( self.gameskillmisstimedistancefactoroverride * 1000, 0.01 );
                playerdistance = distance( self.origin, viewpos );
                var_ce72f9835ebc188e += "<dev string:x2e6>" + round( playerdistance ) + "<dev string:x2f2>" + round( playerdistance * self.gameskillmisstimedistancefactoroverride + self.var_4268b42fc89d0be9, 0.01 );
            }
            
            if ( var_47a2f514cd9c0063.size > 0 )
            {
                print3d( self.origin - ( 0, 0, count * space ), var_47a2f514cd9c0063, white, 1, size );
                count++;
                print3d( self.origin - ( 0, 0, count * space ), var_ce72f9835ebc188e, white, 1, size );
                count++;
            }
            
            if ( utility::iscp() )
            {
                goalvolume = self getgoalvolume();
                str_info = "<dev string:x21>";
                
                if ( isdefined( goalvolume ) && isdefined( goalvolume.targetname ) )
                {
                    str_info += "<dev string:x302>" + goalvolume.targetname + "<dev string:x1ae>";
                }
                
                ai_group = self.script_aigroup;
                
                if ( isdefined( ai_group ) )
                {
                    str_info += "<dev string:x312>" + ai_group + "<dev string:x1ae>";
                }
                
                if ( isdefined( self.goalradius ) )
                {
                    str_info += "<dev string:x320>" + self.goalradius + "<dev string:x1ae>";
                }
                
                if ( isdefined( self.fixednode ) )
                {
                    str_info += "<dev string:x32c>" + self.fixednode + "<dev string:x1ae>";
                }
                
                if ( istrue( self.ignoreall ) )
                {
                    str_info += "<dev string:x33b>";
                }
                else
                {
                    str_info += "<dev string:x34f>";
                }
                
                if ( istrue( self.ignoreme ) )
                {
                    str_info += "<dev string:x364>";
                }
                else
                {
                    str_info += "<dev string:x377>";
                }
                
                if ( str_info.size > 0 )
                {
                    print3d( self.origin - ( 0, 0, count * space ), str_info, white, 1, size );
                    count++;
                }
            }
        }
        
        return count;
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x185f
    // Size: 0x50a, Type: dev
    function function_499e30b2511f6c94()
    {
        space = 20;
        count = 0;
        size = 2;
        white = ( 1, 1, 1 );
        red = ( 1, 0, 0 );
        yellow = ( 1, 1, 0 );
        green = ( 0, 1, 0 );
        
        if ( function_ca7435750eb63fe6() )
        {
            draw_fov();
        }
        
        if ( utility::ismp() || utility::iscp() )
        {
            count = function_6ed101071f87cd39();
            
            if ( count > 0 )
            {
                size = 1;
                viewpos = level.players[ 0 ] getvieworigin();
                scale = utility::function_5a18f19c457e5d1a( self.origin, viewpos, 1200 );
                
                if ( scale < 2 )
                {
                    size *= scale;
                    space *= scale;
                }
            }
        }
        
        animstr = "<dev string:x38b>";
        patrolstyle = scripts\stealth\utility::get_patrol_style();
        
        if ( isdefined( patrolstyle ) )
        {
            animstr = patrolstyle;
        }
        
        szstate = "<dev string:x395>";
        szsubstate = "<dev string:x21>";
        bounded = 0;
        pod = function_bc5df124338cefea( self );
        
        if ( isdefined( self.stealth_bsmstate ) )
        {
            switch ( self.stealth_bsmstate )
            {
                case 0:
                    szstate = "<dev string:x3a0>";
                    break;
                case 1:
                    szstate = "<dev string:x3a8>";
                    
                    if ( isdefined( level.stealth.investigate_volumes[ self.script_stealthgroup ] ) )
                    {
                        bounded = 1;
                    }
                    
                    break;
                case 2:
                    szstate = "<dev string:x3af>";
                    
                    if ( isdefined( level.stealth.hunt_volumes[ self.script_stealthgroup ] ) )
                    {
                        bounded = 1;
                    }
                    
                    szsubstate = "<dev string:x3b7>";
                    break;
                case 3:
                    szstate = "<dev string:x3c4>";
                    
                    if ( isdefined( level.stealth.combat_volumes[ self.script_stealthgroup ] ) )
                    {
                        bounded = 1;
                    }
                    
                    break;
            }
        }
        
        print3d( self.origin - ( 0, 0, count * space ), self getentitynumber() + "<dev string:x3ce>" + szstate + szsubstate, white, 1, size );
        count++;
        print3d( self.origin - ( 0, 0, count * space ), "<dev string:x3d9>" + animstr, white, 1, size );
        count++;
        nextline = "<dev string:x21>";
        
        if ( isdefined( self.enemy ) )
        {
            nextline += "<dev string:x3e3>" + self.enemy getentitynumber() + "<dev string:x1ae>";
        }
        
        if ( bounded )
        {
            nextline += "<dev string:x3ee>";
        }
        
        if ( nextline.size > 0 )
        {
            print3d( self.origin - ( 0, 0, count * space ), nextline, yellow, 1, size );
            count++;
        }
        
        if ( isdefined( self.lightmeter ) )
        {
            print3d( self.origin - ( 0, 0, count * space ), "<dev string:x3f9>" + self.lightmeter, red, 1, size );
            count++;
        }
        
        group = "<dev string:x21>";
        
        if ( isdefined( self.script_stealthgroup ) )
        {
            group = "<dev string:x409>" + self.script_stealthgroup + "<dev string:x1ae>";
        }
        
        if ( group.size > 0 )
        {
            print3d( self.origin - ( 0, 0, count * space ), group, white, 1, size );
            count++;
        }
        
        if ( !self [[ self.fnisinstealthcombat ]]() )
        {
            for ( iplayer = 0; iplayer < level.players.size ; iplayer++ )
            {
                ts = self getthreatsight( level.players[ iplayer ] );
                
                if ( ts > 0 )
                {
                    txt = iplayer + "<dev string:x1b3>" + ts;
                    
                    if ( self cansee( level.players[ iplayer ] ) )
                    {
                        color = red;
                    }
                    else
                    {
                        color = green;
                    }
                    
                    print3d( self.origin - ( 0, 0, count * space ), txt, color, 1, size );
                    count++;
                }
            }
        }
        
        if ( isdefined( self.shootposoverride ) )
        {
            line( self geteye(), self.shootposoverride, ( 1, 1, 0 ) );
        }
        
        facingstart = self.origin + ( 0, 0, 8 );
        facingend = self.origin + ( 0, 0, 8 ) + anglestoforward( self.angles ) * 36;
        line( facingstart, facingend, ( 0, 0, 1 ) );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 3
    // Checksum 0x0, Offset: 0x1d71
    // Size: 0x5c, Type: dev
    function function_886940100cc17179( baseangles, angle, angleidx )
    {
        if ( angleidx == 0 )
        {
            return anglestoforward( baseangles + ( angle, 0, 0 ) );
        }
        
        if ( angleidx == 1 )
        {
            return anglestoforward( baseangles + ( 0, angle, 0 ) );
        }
        
        if ( angleidx == 2 )
        {
            return anglestoforward( baseangles + ( 0, 0, angle ) );
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 8
    // Checksum 0x0, Offset: 0x1dd5
    // Size: 0xee, Type: dev
    function draw_arc( origin, startangle, endangle, baseangles, len, angleidx, numarcs, color )
    {
        assert( startangle < endangle );
        prevpt = origin + len * function_886940100cc17179( baseangles, startangle, angleidx );
        nextpt = prevpt;
        line( origin, prevpt, color );
        angledelta = ( endangle - startangle ) / numarcs;
        
        for ( i = 1; i < numarcs + 1 ; i++ )
        {
            angle = startangle + angledelta * i;
            nextpt = origin + len * function_886940100cc17179( baseangles, angle, angleidx );
            line( prevpt, nextpt, color );
            prevpt = nextpt;
        }
        
        line( origin, nextpt, color );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x1ecb
    // Size: 0x150, Type: dev
    function draw_fov()
    {
        dot = self.fovcosine;
        
        if ( isdefined( self.enemy ) )
        {
            dot = self.fovcosinebusy;
        }
        
        color = ( 1, 0, 0 );
        fov_yaw = acos( dot );
        
        if ( isai( self ) )
        {
            eye_yaw = self gettagangles( "<dev string:x41b>" )[ 1 ];
        }
        else
        {
            eye_yaw = self gettagangles( "<dev string:x426>" )[ 1 ];
        }
        
        viewdist = level.player.maxvisibledist;
        
        if ( isai( self ) )
        {
            start = self gettagorigin( "<dev string:x41b>" );
        }
        else
        {
            start = self gettagorigin( "<dev string:x426>" );
        }
        
        arc_segs = 10;
        draw_arc( start, -1 * fov_yaw, fov_yaw, ( 0, eye_yaw, 0 ), viewdist, 1, arc_segs, color );
        
        if ( self.fovcosinez > dot )
        {
            color *= 0.5;
            fov_pitch = acos( self.fovcosinez );
            eye_pitch = 0;
            draw_arc( start, -1 * fov_pitch, fov_pitch, ( eye_pitch, eye_yaw, 0 ), viewdist, 0, arc_segs, color );
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x2023
    // Size: 0x130, Type: dev
    function function_a02eac45a40e4217()
    {
        tab = "<dev string:xdf>";
        function_dd7ad6e8da294b01( "<dev string:x434>", "<dev string:x43d>" + self getentitynumber() + "<dev string:x282>" );
        function_dd7ad6e8da294b01( "<dev string:x434>", "<dev string:xfb>" + self.script_stealthgroup );
        function_dd7ad6e8da294b01( "<dev string:x434>", "<dev string:x454>" + self.alertlevel );
        
        if ( isdefined( self.enemy ) )
        {
            enemy = self.enemy getentitynumber();
        }
        else
        {
            enemy = "<dev string:x464>";
        }
        
        function_dd7ad6e8da294b01( "<dev string:x434>", "<dev string:x3e3>" + enemy );
        function_dd7ad6e8da294b01( "<dev string:x434>", "<dev string:x471>" + self.stealth.ai_event );
        
        if ( self.team == "<dev string:x157>" )
        {
            team = "<dev string:x484>";
        }
        else
        {
            team = "<dev string:x157>";
        }
        
        enemies = getaiarray( team );
        
        if ( team == "<dev string:x157>" )
        {
            enemies[ enemies.size ] = level.player;
        }
        
        function_20367cc98c4d2265( "<dev string:x434>" );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x215b
    // Size: 0x262, Type: dev
    function function_459a4d528437596()
    {
        cmaxlines = 16;
        cmaxtime = 30000;
        level.stealth.chatbox = [];
        level.stealth.var_78f9cb3724128a61 = 0;
        level.stealth.var_cfee0ec929c863b8 = 0;
        cstartx = 50;
        cstarty = 340;
        clinespacing = 20;
        cscale = 1.5;
        textcolor = ( 1, 1, 1 );
        levelstealth = level.stealth;
        
        while ( true )
        {
            if ( function_a8005409dfbcbb79() )
            {
                var_3b40392d00a51017 = gettime() - cmaxtime;
                
                if ( levelstealth.var_cfee0ec929c863b8 > 0 )
                {
                    cury = cstarty;
                    curline = levelstealth.var_78f9cb3724128a61;
                    
                    for ( iline = 0; iline < levelstealth.var_cfee0ec929c863b8 ; iline++ )
                    {
                        if ( levelstealth.chatbox[ curline ].time > var_3b40392d00a51017 )
                        {
                            text = "<dev string:x21>";
                            
                            if ( isstring( levelstealth.chatbox[ curline ].speaker ) )
                            {
                                text += levelstealth.chatbox[ curline ].speaker;
                            }
                            else
                            {
                                foreach ( speaker in levelstealth.chatbox[ curline ].speaker )
                                {
                                    if ( isdefined( speaker ) )
                                    {
                                        text += "<dev string:x1ae>" + speaker getentitynumber();
                                    }
                                }
                                
                                levelstealth.chatbox[ curline ].speaker = text;
                            }
                            
                            text += "<dev string:x1b3>" + levelstealth.chatbox[ curline ].text;
                            printtoscreen2d( cstartx, cury, text, textcolor, cscale );
                            cury += clinespacing;
                        }
                        
                        curline = ( curline + 1 ) % cmaxlines;
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 2
    // Checksum 0x0, Offset: 0x23c5
    // Size: 0x1b1, Type: dev
    function function_ec780a18fdfb4982( speaker, line )
    {
        cmaxlines = 16;
        stealth = level.stealth;
        var_91fb44e58e12150c = ( stealth.var_78f9cb3724128a61 + stealth.var_cfee0ec929c863b8 ) % cmaxlines;
        curtime = gettime();
        var_82fe7e64cacf7088 = var_91fb44e58e12150c - 1;
        
        if ( var_82fe7e64cacf7088 < 0 )
        {
            var_82fe7e64cacf7088 = cmaxlines - 1;
        }
        
        if ( isdefined( stealth.chatbox[ var_82fe7e64cacf7088 ] ) && stealth.chatbox[ var_82fe7e64cacf7088 ].time == curtime && stealth.chatbox[ var_82fe7e64cacf7088 ].text == line )
        {
            stealth.chatbox[ var_82fe7e64cacf7088 ].speaker[ stealth.chatbox[ var_82fe7e64cacf7088 ].speaker.size ] = speaker;
            return;
        }
        
        s = spawnstruct();
        s.speaker = [ speaker ];
        s.text = line;
        s.time = curtime;
        stealth.chatbox[ var_91fb44e58e12150c ] = s;
        
        if ( var_91fb44e58e12150c == stealth.var_78f9cb3724128a61 && stealth.var_cfee0ec929c863b8 > 0 )
        {
            stealth.var_78f9cb3724128a61 = ( stealth.var_78f9cb3724128a61 + 1 ) % cmaxlines;
        }
        else
        {
            stealth.var_cfee0ec929c863b8++;
        }
        
        assert( stealth.var_cfee0ec929c863b8 <= cmaxlines );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x257e
    // Size: 0x219, Type: dev
    function draw_corpses()
    {
        if ( !debug_enabled() || !isdefined( level.stealth ) || !isdefined( level.stealth.corpse ) )
        {
            return;
        }
        
        if ( !isdefined( level.fngetcorpsearrayfunc ) )
        {
            return;
        }
        
        color = ( 1, 1, 0 );
        found_color = ( 0.9, 0, 0 );
        corpses = [[ level.fngetcorpsearrayfunc ]]();
        guys = getaiarray( "<dev string:x484>" );
        
        foreach ( corpse in corpses )
        {
            corpseorigin = getcorpseorigin( corpse );
            
            if ( getcorpseignored( corpse ) )
            {
                continue;
            }
            else if ( getcorpsefound( corpse ) )
            {
                print3d( corpseorigin, "<dev string:x48c>" );
                continue;
            }
            else
            {
                print3d( corpseorigin, "<dev string:x49c>" );
            }
            
            line( corpse.origin, corpseorigin );
            corpsedistances = getstealthcorpsedistances();
            
            foreach ( guy in guys )
            {
                if ( !isdefined( guy.stealth ) )
                {
                    continue;
                }
                
                if ( guy [[ guy.fnisinstealthcombat ]]() )
                {
                    continue;
                }
                
                dist = distancesquared( corpseorigin, guy.origin );
                
                if ( dist < corpsedistances.detect_distsqrd )
                {
                    line( guy.origin, corpseorigin, found_color );
                    continue;
                }
                
                if ( dist < corpsedistances.sight_distsqrd )
                {
                    line( guy.origin, corpseorigin, color );
                }
            }
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 2
    // Checksum 0x0, Offset: 0x279f
    // Size: 0x82, Type: dev
    function function_24051a9bda001947( message, duration )
    {
        self notify( "<dev string:x4a6>" );
        self endon( "<dev string:x4a6>" );
        self endon( "<dev string:xbc>" );
        
        if ( !isdefined( duration ) )
        {
            duration = 5;
        }
        
        for ( time = 0; time < duration * 20 ; time++ )
        {
            print3d( self.origin + ( 0, 0, 45 ), message, ( 0.48, 9.4, 0.76 ), 0.85 );
            waitframe();
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 3
    // Checksum 0x0, Offset: 0x2829
    // Size: 0xc0, Type: dev
    function draw_axis( origin, angles, length )
    {
        axes = anglestoaxis( angles );
        forward = axes[ "<dev string:x4ba>" ] * length;
        right = axes[ "<dev string:x4c5>" ] * length;
        up = axes[ "<dev string:x4ce>" ] * length;
        line( origin - forward, origin + forward, ( 1, 0, 0 ), 1 );
        line( origin - up, origin + up, ( 0, 1, 0 ), 1 );
        line( origin - right, origin + right, ( 0, 0, 1 ), 1 );
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x28f1
    // Size: 0x1f0, Type: dev
    function function_df6b11367f42a8e1()
    {
        if ( !isdefined( anim.smartobjectpoints ) )
        {
            return;
        }
        
        debughunt = function_68a6af3bcbe8d474();
        
        if ( debughunt == 0 )
        {
            return;
        }
        
        colorgray = ( 0.7, 0.7, 0.7 );
        
        foreach ( obj in anim.smartobjectpoints )
        {
            angles = ( 0, 0, 0 );
            
            if ( isdefined( obj.angles ) )
            {
                angles = obj.angles;
            }
            
            draw_axis( obj.origin, angles, 12 );
            
            if ( debughunt == 2 )
            {
                print3d( obj.origin - ( 0, 0, 12 ), obj.script_smartobject, colorgray, 1, 0.3, 1 );
                objtype = scripts\smartobjects\utility::getsmartobjecttype( obj.script_smartobject );
                
                if ( isdefined( objtype ) && isdefined( objtype.fngetinfo ) )
                {
                    info = [[ objtype.fngetinfo ]]();
                    
                    if ( isdefined( info.radiussqrd ) )
                    {
                        r = sqrt( info.radiussqrd );
                        draw_arc( obj.origin, 0, 360, angles, r, 1, 8, colorgray );
                    }
                    
                    if ( isdefined( obj.claimer ) )
                    {
                        print3d( obj.origin - ( 0, 0, 18 ), "<dev string:x4d4>" + obj.claimer getentitynumber(), colorgray, 1, 0.3, 1 );
                    }
                }
            }
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x2ae9
    // Size: 0x2b8, Type: dev
    function function_47439b5d33f2695a()
    {
        var_60d789eee36da978 = function_4f071e84ae5ccf30();
        
        if ( var_60d789eee36da978 == 0 )
        {
            return;
        }
        
        if ( !isdefined( level.stealth.hunt_stealth_group_region_sets ) )
        {
            return;
        }
        
        debuggroup = function_6a4e0953fbd5e6bc();
        
        foreach ( group, group_data in level.stealth.hunt_stealth_group_region_sets )
        {
            if ( debuggroup != group && debuggroup != "<dev string:x21>" )
            {
                continue;
            }
            
            foreach ( region in group_data.hunt_regions )
            {
                for ( i = 1; i < region.route_points.size ; i++ )
                {
                    p0 = region.route_points[ i - 1 ];
                    p1 = region.route_points[ i ];
                    line( p0.origin, p1.origin, ( 0, 0.7, 0 ), 1, 0, 1 );
                }
                
                if ( isdefined( region.smart_objects ) )
                {
                    foreach ( smart_object in region.smart_objects )
                    {
                        draw_arc( smart_object.origin, 0, 360, smart_object.angles, 10, 1, 3, ( 0.7, 0, 0 ) );
                    }
                }
                
                if ( isdefined( region.region_links ) )
                {
                    foreach ( link in region.region_links )
                    {
                        line( link.transition_point.origin, link.transition_to_point.origin, ( 0.7, 0.7, 0 ), 1, 0, 1 );
                    }
                }
            }
        }
    }

    // Namespace debug / scripts\stealth\debug
    // Params 0
    // Checksum 0x0, Offset: 0x2da9
    // Size: 0x39d, Type: dev
    function function_477aac1963f8269e()
    {
        var_4dea17d260740969 = function_79c554909de26a4c();
        
        if ( var_4dea17d260740969 == 0 )
        {
            return;
        }
        
        if ( !isdefined( level.stealth.hunt_stealth_group_region_sets ) )
        {
            return;
        }
        
        debuggroup = function_6a4e0953fbd5e6bc();
        
        foreach ( group, group_data in level.stealth.hunt_stealth_group_region_sets )
        {
            if ( debuggroup != group && debuggroup != "<dev string:x21>" )
            {
                continue;
            }
            
            regionlocationlist = [];
            
            foreach ( region in group_data.hunt_regions )
            {
                assert( isdefined( region.approx_location ) );
                space = 10;
                count = 0;
                size = 0.5;
                white = ( 1, 1, 1 );
                print3d( region.approx_location - ( 0, 0, count * space ), "<dev string:x4dc>" + region.index, white, 1, size );
                count++;
                print3d( region.approx_location - ( 0, 0, count * space ), "<dev string:x4e7>" + region.bfs_score, white, 1, size );
                count++;
                print3d( region.approx_location - ( 0, 0, count * space ), "<dev string:x4f6>" + region.shared_data.bfs_assigned, white, 1, size );
                count++;
                print3d( region.approx_location - ( 0, 0, count * space ), "<dev string:x504>" + region.shared_data.in_region, white, 1, size );
                count++;
                print3d( region.approx_location - ( 0, 0, count * space ), "<dev string:x513>" + region.stealth_group, white, 1, size );
                cooldowndiff = region.shared_data.bfs_cooldown - gettime();
                
                if ( cooldowndiff > 0 )
                {
                    count++;
                    print3d( region.approx_location - ( 0, 0, count * space ), "<dev string:x51e>" + cooldowndiff, white, 1, size );
                }
            }
            
            foreach ( region in group_data.hunt_regions )
            {
                foreach ( link in region.region_links )
                {
                    toregion = link.region;
                    line( region.approx_location, toregion.approx_location, ( 0, 0, 0.7 ), 1, 0, 1 );
                }
            }
        }
    }

#/
