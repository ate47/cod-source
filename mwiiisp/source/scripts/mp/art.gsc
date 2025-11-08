#using scripts\common\utility;
#using scripts\engine\utility;

#namespace art;

/#

    // Namespace art / scripts\mp\art
    // Params 0
    // Checksum 0x0, Offset: 0x78
    // Size: 0x4d, Type: dev
    function main()
    {
        setdevdvarifuninitialized( @"scr_art_tweak", 0 );
        thread tweakart();
        tess_init();
        
        if ( !isdefined( level.script ) )
        {
            level.script = tolower( getdvar( @"g_mapname" ) );
        }
    }

    // Namespace art / scripts\mp\art
    // Params 0
    // Checksum 0x0, Offset: 0xcd
    // Size: 0x49, Type: dev
    function inittweaks()
    {
        setdevdvar( @"hash_4296464306ab31a8", 1 );
        
        if ( !isdefined( level.buttons ) )
        {
            level.buttons = [];
        }
        
        level._clearalltextafterhudelem = 0;
        iprintlnbold( "<dev string:x1c>" );
        hud_init();
    }

    // Namespace art / scripts\mp\art
    // Params 0
    // Checksum 0x0, Offset: 0x11e
    // Size: 0x8c, Type: dev
    function tweakart()
    {
        if ( !isdefined( level.tweakfile ) )
        {
            level.tweakfile = 0;
        }
        
        setdevdvar( @"scr_fog_fraction", "<dev string:x2e>" );
        setdevdvar( @"scr_art_dump", "<dev string:x32>" );
        printed = 0;
        
        for ( ;; )
        {
            while ( getdvarint( @"scr_art_tweak", 0 ) == 0 )
            {
                wait 0.05;
            }
            
            if ( !printed )
            {
                printed = 1;
                inittweaks();
            }
            
            dumpsettings();
            wait 0.05;
        }
    }

    // Namespace art / scripts\mp\art
    // Params 0
    // Checksum 0x0, Offset: 0x1b2
    // Size: 0x11c, Type: dev
    function tess_init()
    {
        using_tessellation = getdvar( @"r_tessellation" );
        
        if ( using_tessellation == "<dev string:x34>" )
        {
            return;
        }
        
        level.tess = spawnstruct();
        level.tess.cutoff_distance_current = 635;
        level.tess.cutoff_distance_goal = level.tess.cutoff_distance_current;
        level.tess.cutoff_falloff_current = 587;
        level.tess.cutoff_falloff_goal = level.tess.cutoff_falloff_current;
        level.tess.time_remaining = 0;
        setdvar( @"hash_24a1cc28fae4c8e2", level.tess.cutoff_distance_current );
        setdvar( @"hash_d786b6ac5e30f145", level.tess.cutoff_falloff_current );
        thread tess_update();
    }

    // Namespace art / scripts\mp\art
    // Params 3
    // Checksum 0x0, Offset: 0x2d6
    // Size: 0x5d, Type: dev
    function tess_set_goal( cutoff_distance, cutoff_falloff, blend_time )
    {
        level.tess.cutoff_distance_goal = cutoff_distance;
        level.tess.cutoff_falloff_goal = cutoff_falloff;
        level.tess.time_remaining = blend_time;
    }

    // Namespace art / scripts\mp\art
    // Params 0
    // Checksum 0x0, Offset: 0x33b
    // Size: 0x237, Type: dev
    function tess_update()
    {
        while ( true )
        {
            var_8e82e2ee78f6c824 = level.tess.cutoff_distance_current;
            var_7d417327139f9f5f = level.tess.cutoff_falloff_current;
            waitframe();
            
            if ( level.tess.time_remaining > 0 )
            {
                frames = level.tess.time_remaining * 20;
                distance_increment = ( level.tess.cutoff_distance_goal - level.tess.cutoff_distance_current ) / frames;
                falloff_increment = ( level.tess.cutoff_falloff_goal - level.tess.cutoff_falloff_current ) / frames;
                level.tess.cutoff_distance_current += distance_increment;
                level.tess.cutoff_falloff_current += falloff_increment;
                level.tess.time_remaining -= level.framedurationseconds;
            }
            else
            {
                level.tess.cutoff_distance_current = level.tess.cutoff_distance_goal;
                level.tess.cutoff_falloff_current = level.tess.cutoff_falloff_goal;
            }
            
            if ( var_8e82e2ee78f6c824 != level.tess.cutoff_distance_current )
            {
                setdvar( @"hash_24a1cc28fae4c8e2", level.tess.cutoff_distance_current );
            }
            
            if ( var_7d417327139f9f5f != level.tess.cutoff_falloff_current )
            {
                setdvar( @"hash_d786b6ac5e30f145", level.tess.cutoff_falloff_current );
            }
        }
    }

    // Namespace art / scripts\mp\art
    // Params 0
    // Checksum 0x0, Offset: 0x57a
    // Size: 0xa8, Type: dev
    function dumpsettings()
    {
        if ( getdvarint( @"scr_art_dump" ) == 0 )
        {
            return 0;
        }
        
        setdevdvar( @"scr_art_dump", "<dev string:x32>" );
        fileprint_launcher_start_file();
        fileprint_launcher( "<dev string:x35>" );
        fileprint_launcher( "<dev string:x88>" );
        fileprint_launcher( "<dev string:x8f>" );
        fileprint_launcher( "<dev string:x91>" );
        fileprint_launcher( "<dev string:xaa>" );
        
        if ( !fileprint_launcher_end_file( "<dev string:xac>" + level.script + "<dev string:xcc>", 1 ) )
        {
            return;
        }
        
        iprintlnbold( "<dev string:xd5>" );
        println( "<dev string:xe6>" );
    }

    // Namespace art / scripts\mp\art
    // Params 2
    // Checksum 0x0, Offset: 0x62a
    // Size: 0x92, Type: dev
    function button_down( btn, btn2 )
    {
        pressed = level.players[ 0 ] buttonpressed( btn );
        
        if ( !pressed )
        {
            pressed = level.players[ 0 ] buttonpressed( btn2 );
        }
        
        if ( !isdefined( level.buttons[ btn ] ) )
        {
            level.buttons[ btn ] = 0;
        }
        
        if ( gettime() < level.buttons[ btn ] )
        {
            return 0;
        }
        
        level.buttons[ btn ] = gettime() + 400;
        return pressed;
    }

    // Namespace art / scripts\mp\art
    // Params 0
    // Checksum 0x0, Offset: 0x6c4
    // Size: 0x16e, Type: dev
    function hud_init()
    {
        listsize = 7;
        hudelems = [];
        spacer = 15;
        div = int( listsize / 2 );
        org = 240 - div * spacer;
        alphainc = 0.5 / div;
        alpha = alphainc;
        
        for ( i = 0; i < listsize ; i++ )
        {
            hudelems[ i ] = _newhudelem();
            hudelems[ i ].location = 0;
            hudelems[ i ].alignx = "<dev string:x103>";
            hudelems[ i ].aligny = "<dev string:x108>";
            hudelems[ i ].foreground = 1;
            hudelems[ i ].fontscale = 2;
            hudelems[ i ].sort = 20;
            
            if ( i == div )
            {
                hudelems[ i ].alpha = 1;
            }
            else
            {
                hudelems[ i ].alpha = alpha;
            }
            
            hudelems[ i ].x = 20;
            hudelems[ i ].y = org;
            hudelems[ i ] _settext( "<dev string:x10f>" );
            
            if ( i == div )
            {
                alphainc *= -1;
            }
            
            alpha += alphainc;
            org += spacer;
        }
        
        level.spam_group_hudelems = hudelems;
    }

    // Namespace art / scripts\mp\art
    // Params 0
    // Checksum 0x0, Offset: 0x83a
    // Size: 0x44, Type: dev
    function _newhudelem()
    {
        if ( !isdefined( level.scripted_elems ) )
        {
            level.scripted_elems = [];
        }
        
        elem = newhudelem();
        level.scripted_elems[ level.scripted_elems.size ] = elem;
        return elem;
    }

    // Namespace art / scripts\mp\art
    // Params 1
    // Checksum 0x0, Offset: 0x886
    // Size: 0xbf, Type: dev
    function _settext( text )
    {
        self.realtext = text;
        self setdevtext( "<dev string:x111>" );
        thread _clearalltextafterhudelem();
        var_bff8d89bfd98e29f = 0;
        
        foreach ( elem in level.scripted_elems )
        {
            if ( isdefined( elem.realtext ) )
            {
                var_bff8d89bfd98e29f += elem.realtext.size;
                elem setdevtext( elem.realtext );
            }
        }
        
        println( "<dev string:x113>" + var_bff8d89bfd98e29f );
    }

    // Namespace art / scripts\mp\art
    // Params 0
    // Checksum 0x0, Offset: 0x94d
    // Size: 0x34, Type: dev
    function _clearalltextafterhudelem()
    {
        if ( level._clearalltextafterhudelem )
        {
            return;
        }
        
        level._clearalltextafterhudelem = 1;
        self clearalltextafterhudelem();
        wait 0.05;
        level._clearalltextafterhudelem = 0;
    }

    // Namespace art / scripts\mp\art
    // Params 0
    // Checksum 0x0, Offset: 0x989
    // Size: 0x25, Type: dev
    function reset_cmds()
    {
        setdevdvar( @"hash_de86d29dde73df", 0 );
        setdevdvar( @"hash_cc21f65bade3fb07", 0 );
    }

#/
