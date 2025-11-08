#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace weapons_dev;

// Namespace weapons_dev / scripts\cp_mp\weapons_dev
// Params 0
// Checksum 0x0, Offset: 0xed
// Size: 0xac
function function_b8a2a2faf79dc08e()
{
    if ( getbuildversion() != "SHIP" )
    {
        thread function_480ec2fed0d414f7();
        setdvar( @"hash_588557f97f081a7e", "" );
    }
    
    /#
        if ( !isdefined( level.weapdev ) )
        {
            level.weapdev = spawnstruct();
        }
        
        thread function_355de3fc37e0bd45();
        thread function_4770632c00748149();
        thread function_17cdeb7626afb432();
        level callback::add( "<dev string:x1c>", &function_c7979dea29932f4e );
        level callback::add( "<dev string:x2e>", &function_7973fcc15a7b9d52 );
        level callback::add( "<dev string:x43>", &function_51eab65eec69 );
        setdevdvarifuninitialized( @"hash_94cfa401914bb582", "<dev string:x5b>" );
    #/
}

// Namespace weapons_dev / scripts\cp_mp\weapons_dev
// Params 0
// Checksum 0x0, Offset: 0x1a1
// Size: 0x33
function function_480ec2fed0d414f7()
{
    if ( getbuildversion() != "SHIP" )
    {
        for ( ;; )
        {
            if ( getdvar( @"hash_588557f97f081a7e" ) != "" )
            {
                thread function_416220a2493c9ec();
            }
            
            waitframe();
        }
    }
}

// Namespace weapons_dev / scripts\cp_mp\weapons_dev
// Params 0
// Checksum 0x0, Offset: 0x1dc
// Size: 0x23e
function function_416220a2493c9ec()
{
    if ( getbuildversion() != "SHIP" )
    {
        variantid = 0;
        blueprintname = getdvar( @"hash_588557f97f081a7e" );
        weapon = getweaponrootname( blueprintname );
        weaponasset = undefined;
        
        if ( isdefined( level.weaponmapdata[ weapon ] ) )
        {
            weaponasset = level.weaponmapdata[ weapon ].assetname;
        }
        
        weaponblueprint = getxhashasset( blueprintname );
        
        if ( isdefined( weaponasset ) )
        {
            weaponvariants = getweaponblueprintnames( weaponasset );
            
            foreach ( variant, id in weaponvariants )
            {
                if ( weaponblueprint == variant )
                {
                    foreach ( player in level.players )
                    {
                        variantid = id;
                        hasnvg = istrue( level.nightmap );
                        var_c88b10f789adf8eb = scripts\cp_mp\weapon::buildweapon_blueprint( weapon, undefined, undefined, variantid, undefined, undefined, hasnvg );
                        currentweapon = player.currentweapon;
                        player.droppeddeathweapon = undefined;
                        
                        if ( issharedfuncdefined( "weapons", "dropWeaponForDeath" ) )
                        {
                            player thread [[ getsharedfunc( "weapons", "dropWeaponForDeath" ) ]]( undefined, "" );
                        }
                        
                        player.droppeddeathweapon = undefined;
                        
                        if ( player hasweapon( var_c88b10f789adf8eb ) )
                        {
                            player _takeweapon( var_c88b10f789adf8eb );
                        }
                        
                        if ( scripts\common\utility::iscp() )
                        {
                            player scripts\cp_mp\utility\inventory_utility::_takeweapon( currentweapon );
                        }
                        
                        var_c88b10f789adf8eb = var_c88b10f789adf8eb function_7e483d6e6b4b5688( id );
                        player giveweapon( var_c88b10f789adf8eb );
                        player setweaponammoclip( var_c88b10f789adf8eb, weaponclipsize( var_c88b10f789adf8eb ) );
                        player setweaponammostock( var_c88b10f789adf8eb, weaponmaxammo( var_c88b10f789adf8eb ) );
                        player _switchtoweaponimmediate( var_c88b10f789adf8eb );
                        scripts\cp_mp\weapon::fixupplayerweapons( player, weapon );
                    }
                    
                    break;
                }
            }
        }
        
        setdvar( @"hash_588557f97f081a7e", "" );
    }
}

/#

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 1
    // Checksum 0x0, Offset: 0x422
    // Size: 0x130, Type: dev
    function function_71d0871062111cb8( group )
    {
        class = undefined;
        
        if ( isdefined( group ) )
        {
            class = "<dev string:x5f>";
            
            switch ( group )
            {
                case #"hash_8af0086b038622b5":
                    class = "<dev string:x79>";
                    break;
                case #"hash_dd616da0b395a0b0":
                    class = "<dev string:x9b>";
                    break;
                case #"hash_47368bc0d2ef1565":
                    class = "<dev string:xb9>";
                    break;
                case #"hash_bef5ec0b3e197ae":
                    class = "<dev string:xce>";
                    break;
                case #"hash_86b11ac21f992552":
                case #"hash_a1f27f97be15d620":
                    class = "<dev string:xf6>";
                    break;
                case #"hash_34340d457a63e7f1":
                    class = "<dev string:x110>";
                    break;
                case #"hash_9d18adab1b65a661":
                    class = "<dev string:x12f>";
                    break;
                case #"hash_16cf6289ab06bd30":
                    class = "<dev string:x14d>";
                    break;
                case #"hash_ab10f9c080fe4faf":
                    class = "<dev string:x166>";
                    break;
                case #"hash_c095d67337b1f5a1":
                    class = "<dev string:x17e>";
                    break;
                case #"hash_2535634d8bb5c955":
                    class = "<dev string:x199>";
                    break;
            }
        }
        
        return class;
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 0
    // Checksum 0x0, Offset: 0x55a
    // Size: 0x103, Type: dev
    function function_355de3fc37e0bd45()
    {
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x1a3>" + "<dev string:x1ba>" );
        key_weapons = getarraykeys( level.weaponmapdata );
        sorted_weapons = scripts\engine\utility::array_sort_with_func( key_weapons, &function_86b38dd39a0aea86 );
        
        for ( i = 0; i < sorted_weapons.size ; i++ )
        {
            data = level.weaponmapdata[ sorted_weapons[ i ] ];
            weaponclass = function_71d0871062111cb8( data.group );
            
            if ( isdefined( weaponclass ) )
            {
                scripts\common\devgui::add_devgui_command( weaponclass + "<dev string:x1c8>" + data.assetname, "<dev string:x1cd>" + data.assetname );
            }
        }
        
        scripts\common\devgui::function_fe953f000498048f();
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x1a3>" + "<dev string:x201>" );
        scripts\common\devgui::add_devgui_command( "<dev string:x215>", "<dev string:x22c>" );
        scripts\common\devgui::add_devgui_command( "<dev string:x251>", "<dev string:x26f>" );
        scripts\common\devgui::function_fe953f000498048f();
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 2
    // Checksum 0x0, Offset: 0x665
    // Size: 0x2f, Type: dev
    function function_86b38dd39a0aea86( a, b )
    {
        if ( !isdefined( a ) )
        {
            return 0;
        }
        
        if ( !isdefined( b ) )
        {
            return 1;
        }
        
        return stricmp( a, b ) < 0;
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 5
    // Checksum 0x0, Offset: 0x69c
    // Size: 0xd5, Type: dev
    function function_7aa60ff4574743( dvar, defaultvalue, func, isthreaded, unarchived )
    {
        if ( !isdefined( level.weapdev.dvars ) )
        {
            level.weapdev.dvars = [];
        }
        
        setdvarifuninitialized( dvar, defaultvalue );
        struct = spawnstruct();
        struct.func = func;
        struct.dvar = dvar;
        struct.defaultvalue = defaultvalue;
        
        if ( isdefined( isthreaded ) )
        {
            struct.threaded = isthreaded;
        }
        
        if ( isdefined( unarchived ) )
        {
            struct.unarchived = unarchived;
        }
        
        level.weapdev.dvars[ dvar ] = struct;
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 0
    // Checksum 0x0, Offset: 0x779
    // Size: 0x107, Type: dev
    function function_56f3108c7ef4ae1d()
    {
        if ( !isdefined( level.weapdev.dvars ) )
        {
            return;
        }
        
        for ( ;; )
        {
            foreach ( dvarstr, data in level.weapdev.dvars )
            {
                dvarval = undefined;
                
                if ( isdefined( data.unarchived ) )
                {
                    dvarval = getunarchiveddebugdvar( dvarstr );
                }
                else
                {
                    dvarval = getdvar( dvarstr );
                }
                
                if ( !isdefined( dvarval ) )
                {
                    continue;
                }
                
                if ( dvarval == data.defaultvalue )
                {
                    continue;
                }
                
                if ( isdefined( data.threaded ) )
                {
                    thread [[ data.func ]]( dvarval );
                }
                else
                {
                    [[ data.func ]]( dvarval );
                }
                
                setdvar( dvarstr, data.defaultvalue );
            }
            
            wait 0.2;
        }
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 0
    // Checksum 0x0, Offset: 0x888
    // Size: 0xb5, Type: dev
    function function_4770632c00748149()
    {
        function_7aa60ff4574743( @"hash_5a6ac095cce29d6a", "<dev string:x29a>", &function_c8daabfa780ac4c6, 0, 0 );
        function_7aa60ff4574743( @"hash_b8fb8e495524a25c", "<dev string:x29f>", &function_fbfe774dd8a2b0a6, 0, 0 );
        function_7aa60ff4574743( @"hash_5d287f84a6f89b43", "<dev string:x29f>", &function_333a596bee56937d, 0, 0 );
        function_7aa60ff4574743( @"hash_61d2d8e5a629ef89", "<dev string:x29a>", &function_d214bc8897a77197, 0, 0 );
        function_7aa60ff4574743( @"hash_5e29683a6750ed67", "<dev string:x5b>", &function_9a2bcf3ce7449979, 0, 0 );
        function_7aa60ff4574743( @"hash_c2957735560e95b2", "<dev string:x5b>", &function_dd9d05980fc62610, 0, 0 );
        thread function_56f3108c7ef4ae1d();
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 1
    // Checksum 0x0, Offset: 0x945
    // Size: 0x10f, Type: dev
    function function_9a2bcf3ce7449979( weaponname )
    {
        weapnew = weaponname;
        variant = -1;
        toks = strtok( weaponname, "<dev string:x2a5>" );
        
        if ( toks.size > 1 )
        {
            weapnew = toks[ 0 ];
            variant = int( toks[ 1 ] );
        }
        
        if ( isdefined( weapnew ) )
        {
            var_8c78fd98c6c91e0f = scripts\cp_mp\weapon::getweaponrootname( weapnew );
            playerarray = function_2d7fd129a52dd44b();
            
            foreach ( player in playerarray )
            {
                hasnvg = istrue( level.nightmap );
                var_c88b10f789adf8eb = scripts\cp_mp\weapon::buildweapon_blueprint( var_8c78fd98c6c91e0f, undefined, undefined, variant, undefined, undefined, hasnvg );
                currentweapon = player.currentweapon;
                player function_71bd21b34346c599( currentweapon, var_c88b10f789adf8eb, 0 );
            }
        }
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 1
    // Checksum 0x0, Offset: 0xa5c
    // Size: 0x160, Type: dev
    function function_dd9d05980fc62610( val )
    {
        if ( isdefined( val ) )
        {
            params = strtok( val, "<dev string:x2aa>" );
            weaponobj = undefined;
            attachmentname = undefined;
            
            if ( params.size > 1 )
            {
                var_8c78fd98c6c91e0f = scripts\cp_mp\weapon::getweaponrootname( params[ 0 ] );
                hasnvg = istrue( level.nightmap );
                weaponobj = scripts\cp_mp\weapon::buildweapon_blueprint( var_8c78fd98c6c91e0f, undefined, undefined, -1, undefined, undefined, hasnvg );
                attachmentname = params[ 1 ];
            }
            else
            {
                attachmentname = params[ 0 ];
            }
            
            if ( isdefined( attachmentname ) )
            {
                playerarray = function_2d7fd129a52dd44b();
                
                foreach ( player in playerarray )
                {
                    currentweapon = player.currentweapon;
                    
                    if ( !isdefined( weaponobj ) )
                    {
                        weaponobj = currentweapon;
                    }
                    
                    var_c88b10f789adf8eb = function_f3cafbcac7b5f838( weaponobj, attachmentname );
                    
                    if ( !isdefined( var_c88b10f789adf8eb ) )
                    {
                        if ( !isbot( player ) )
                        {
                            player iprintlnbold( "<dev string:x2af>" + attachmentname + "<dev string:x2c7>" + weaponobj.basename + "<dev string:x2d9>" );
                        }
                        
                        continue;
                    }
                    
                    player function_71bd21b34346c599( currentweapon, var_c88b10f789adf8eb, 1 );
                }
            }
        }
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 2
    // Checksum 0x0, Offset: 0xbc4
    // Size: 0x2b7, Type: dev
    function function_f3cafbcac7b5f838( weaponobj, attachmentname )
    {
        var_b8ca516f1a797a1f = weaponobj getnoaltweapon();
        attachmenttoidmap = var_b8ca516f1a797a1f.attachmentvarindices;
        attachments = [];
        
        foreach ( attachment, id in attachmenttoidmap )
        {
            attachments[ attachments.size ] = attachment;
        }
        
        failed = !var_b8ca516f1a797a1f canuseattachment( attachmentname );
        
        if ( failed )
        {
            return undefined;
        }
        
        attachments = scripts\cp_mp\weapon::weaponattachremoveextraattachments( attachments );
        var_7809ad191e44fe6a = [];
        
        foreach ( idx, attachment in attachments )
        {
            var_7809ad191e44fe6a[ idx ] = attachmenttoidmap[ attachment ];
        }
        
        camo = var_b8ca516f1a797a1f.camo;
        stickers = [];
        
        if ( isdefined( var_b8ca516f1a797a1f.stickerslot0 ) )
        {
            stickers[ stickers.size ] = var_b8ca516f1a797a1f.stickerslot0;
        }
        
        if ( isdefined( var_b8ca516f1a797a1f.stickerslot1 ) )
        {
            stickers[ stickers.size ] = var_b8ca516f1a797a1f.stickerslot1;
        }
        
        if ( isdefined( var_b8ca516f1a797a1f.stickerslot2 ) )
        {
            stickers[ stickers.size ] = var_b8ca516f1a797a1f.stickerslot2;
        }
        
        if ( isdefined( var_b8ca516f1a797a1f.stickerslot3 ) )
        {
            stickers[ stickers.size ] = var_b8ca516f1a797a1f.stickerslot3;
        }
        
        if ( isdefined( var_b8ca516f1a797a1f.var_b39ac546cc8621f8 ) )
        {
            stickers[ stickers.size ] = var_b8ca516f1a797a1f.var_b39ac546cc8621f8;
        }
        
        hasnvg = istrue( level.nightmap );
        attachment1slot = getattachmentslot( var_b8ca516f1a797a1f, attachmentname );
        replaced = 0;
        
        foreach ( idx, a in attachments )
        {
            attachment2slot = getattachmentslot( var_b8ca516f1a797a1f, attachments[ idx ] );
            
            if ( attachment1slot == attachment2slot && attachment1slot != "<dev string:x2df>" )
            {
                attachments[ idx ] = attachmentname;
                replaced = 1;
            }
        }
        
        if ( !replaced )
        {
            attachments[ attachments.size ] = attachmentname;
            var_7809ad191e44fe6a[ var_7809ad191e44fe6a.size ] = 0;
        }
        
        variantid = getweaponvariantindex( weaponobj );
        var_1558cf422ec0ea75 = scripts\cp_mp\weapon::buildweapon( scripts\cp_mp\weapon::getweaponrootname( weaponobj ), attachments, camo, "<dev string:x2e8>", variantid, var_7809ad191e44fe6a, undefined, stickers, hasnvg );
        return var_1558cf422ec0ea75;
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 3
    // Checksum 0x0, Offset: 0xe83
    // Size: 0x7f, Type: dev
    function function_71bd21b34346c599( currentweapon, var_c88b10f789adf8eb, giveammo )
    {
        player = self;
        player dropitem( currentweapon );
        
        if ( player hasweapon( var_c88b10f789adf8eb ) )
        {
            player dropitem( var_c88b10f789adf8eb );
        }
        
        player giveweapon( var_c88b10f789adf8eb );
        
        if ( giveammo )
        {
            player setweaponammoclip( var_c88b10f789adf8eb, weaponclipsize( var_c88b10f789adf8eb ) );
            player setweaponammostock( var_c88b10f789adf8eb, weaponmaxammo( var_c88b10f789adf8eb ) );
        }
        
        player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate( var_c88b10f789adf8eb );
        scripts\cp_mp\weapon::fixupplayerweapons( player, var_c88b10f789adf8eb );
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 1
    // Checksum 0x0, Offset: 0xf0a
    // Size: 0x44, Type: dev
    function function_c8daabfa780ac4c6( entnum )
    {
        host = function_3b6bb4498000be82();
        target = host function_ba794adeb36ca952();
        
        if ( !isdefined( target ) )
        {
            return;
        }
        
        function_fbfe774dd8a2b0a6( target getentitynumber() );
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 1
    // Checksum 0x0, Offset: 0xf56
    // Size: 0xc5, Type: dev
    function function_fbfe774dd8a2b0a6( entnum )
    {
        entnum = int( entnum );
        
        if ( !isdefined( level.players[ entnum ] ) )
        {
            iprintln( "<dev string:x2f0>" );
            return;
        }
        
        level.weapdev.var_3b3b12cc96932083 = spawnstruct();
        level.weapdev.var_3b3b12cc96932083.entnum = entnum;
        level.weapdev.var_3b3b12cc96932083.ent = level.players[ entnum ];
        iprintln( "<dev string:x30a>" + level.weapdev.var_3b3b12cc96932083.ent.name );
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 1
    // Checksum 0x0, Offset: 0x1023
    // Size: 0x77, Type: dev
    function function_333a596bee56937d( entnum )
    {
        entnum = int( entnum );
        level.weapdev.var_4dc56e3237d18ff5 = spawnstruct();
        level.weapdev.var_4dc56e3237d18ff5.entnum = entnum;
        level.weapdev.var_4dc56e3237d18ff5.ent = level.players[ entnum ];
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 1
    // Checksum 0x0, Offset: 0x10a2
    // Size: 0x2c, Type: dev
    function function_d214bc8897a77197( dummy )
    {
        level.weapdev.var_3b3b12cc96932083 = undefined;
        iprintln( "<dev string:x31d>" );
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 0
    // Checksum 0x0, Offset: 0x10d6
    // Size: 0x14e, Type: dev
    function function_2d7fd129a52dd44b()
    {
        if ( isdefined( level.weapdev.var_4dc56e3237d18ff5 ) && isdefined( level.weapdev.var_4dc56e3237d18ff5.ent ) )
        {
            players = [ level.weapdev.var_4dc56e3237d18ff5.ent ];
            level.weapdev.var_4dc56e3237d18ff5 = undefined;
            return players;
        }
        
        if ( getdvar( @"hash_13d8008e8edc58d5", "<dev string:x29f>" ) != "<dev string:x29f>" )
        {
            entnum = int( getdvar( @"hash_13d8008e8edc58d5" ) );
            setdvar( @"hash_13d8008e8edc58d5", "<dev string:x29f>" );
            return [ level.players[ entnum ] ];
        }
        
        if ( isdefined( level.weapdev.var_3b3b12cc96932083 ) && isdefined( level.weapdev.var_3b3b12cc96932083.ent ) )
        {
            return [ level.weapdev.var_3b3b12cc96932083.ent ];
        }
        
        return level.players;
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 0
    // Checksum 0x0, Offset: 0x122c
    // Size: 0x77, Type: dev
    function function_3b6bb4498000be82()
    {
        hostplayer = level.players[ 0 ];
        
        foreach ( player in level.players )
        {
            if ( player ishost() )
            {
                hostplayer = player;
                break;
            }
        }
        
        return hostplayer;
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 0
    // Checksum 0x0, Offset: 0x12ab
    // Size: 0xb0, Type: dev
    function function_ba794adeb36ca952()
    {
        startpos = self geteye();
        viewangles = self getplayerangles();
        fwd = anglestoforward( viewangles );
        endpos = startpos + fwd * 10000;
        playercontent = [ "<dev string:x337>" ];
        var_30d537ea3164e799 = physics_createcontents( playercontent );
        playertrace = scripts\engine\trace::sphere_trace( startpos, endpos, 5, self, var_30d537ea3164e799, 0 );
        traceent = playertrace[ "<dev string:x359>" ];
        
        if ( isdefined( traceent ) && isplayer( traceent ) )
        {
            return traceent;
        }
        
        return undefined;
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 1
    // Checksum 0x0, Offset: 0x1363
    // Size: 0xe, Type: dev
    function function_c7979dea29932f4e( params )
    {
        
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 1
    // Checksum 0x0, Offset: 0x1379
    // Size: 0x28, Type: dev
    function function_7973fcc15a7b9d52( params )
    {
        entnum = self getentitynumber();
        function_61f7f6b3f6c5c082( entnum );
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 1
    // Checksum 0x0, Offset: 0x13a9
    // Size: 0x28, Type: dev
    function function_51eab65eec69( params )
    {
        entnum = self getentitynumber();
        function_61f7f6b3f6c5c082( entnum );
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 0
    // Checksum 0x0, Offset: 0x13d9
    // Size: 0x31, Type: dev
    function function_68e5f0be62d590ef()
    {
        if ( !isdefined( level.weapdev.players ) )
        {
            level.weapdev.players = [];
        }
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 1
    // Checksum 0x0, Offset: 0x1412
    // Size: 0x3ba, Type: dev
    function function_61f7f6b3f6c5c082( entnum )
    {
        player = self;
        
        if ( isbot( player ) )
        {
            return;
        }
        
        if ( !isdefined( level.weapdev.players ) )
        {
            level.weapdev.players = [];
        }
        
        var_9c51960a22deee7f = undefined;
        
        if ( isdefined( level.weapdev.players[ entnum ] ) && isdefined( level.weapdev.players[ entnum ].var_3fe49be7e53a9302 ) )
        {
            var_9c51960a22deee7f = level.weapdev.players[ entnum ].var_3fe49be7e53a9302;
        }
        
        level.weapdev.players[ entnum ] = undefined;
        
        if ( !isdefined( player ) || istrue( player.isdisconnecting ) )
        {
            if ( isdefined( var_9c51960a22deee7f ) )
            {
                pathtoremove = "<dev string:x1a3>" + "<dev string:x363>" + var_9c51960a22deee7f;
                cmd = "<dev string:x375>" + pathtoremove + "<dev string:x388>";
                adddebugcommand( cmd + "<dev string:x38d>" );
            }
            
            return;
        }
        
        var_3fe49be7e53a9302 = player.name;
        
        if ( isdefined( var_9c51960a22deee7f ) && var_3fe49be7e53a9302 != var_9c51960a22deee7f )
        {
            pathtoremove = "<dev string:x1a3>" + "<dev string:x363>" + var_9c51960a22deee7f;
            cmd = "<dev string:x375>" + pathtoremove + "<dev string:x388>";
            adddebugcommand( cmd + "<dev string:x38d>" );
        }
        
        level.weapdev.players[ entnum ] = spawnstruct();
        level.weapdev.players[ entnum ].var_3fe49be7e53a9302 = var_3fe49be7e53a9302;
        var_84850b87803d306 = "<dev string:x1a3>" + "<dev string:x363>" + var_3fe49be7e53a9302 + "<dev string:x392>" + entnum + "<dev string:x1c8>";
        scripts\common\devgui::function_6e7290c8ee4f558b( var_84850b87803d306 );
        
        if ( !isnullweapon( player.currentweapon ) )
        {
            noaltweapon = player.currentweapon getnoaltweapon();
            weaponpath = noaltweapon.basename + "<dev string:x397>";
            path = weaponpath + "<dev string:x39e>";
            scripts\common\devgui::add_devgui_command( path, "<dev string:x3ad>" + entnum + "<dev string:x3ec>" + noaltweapon.basename );
            
            foreach ( slot in level.attachmentslotarray )
            {
                if ( slot == "<dev string:x40a>" )
                {
                    continue;
                }
                
                attachments = function_75b035199842693d( noaltweapon, slot );
                
                foreach ( attachmentname in attachments )
                {
                    attachmentdataname = hashcat( %"hash_3c2c9813bb16552f", attachmentname );
                    category = getscriptbundlefieldvalue( attachmentdataname, #"category" );
                    
                    if ( isdefined( category ) )
                    {
                        path = weaponpath + category + "<dev string:x1c8>" + attachmentname;
                    }
                    else
                    {
                        path = weaponpath + slot + "<dev string:x1c8>" + attachmentname;
                    }
                    
                    scripts\common\devgui::add_devgui_command( path, "<dev string:x3ad>" + entnum + "<dev string:x414>" + noaltweapon.basename + "<dev string:x2aa>" + attachmentname );
                }
            }
        }
        
        scripts\common\devgui::add_devgui_command( "<dev string:x436>", "<dev string:x44b>" + entnum, 100 );
        scripts\common\devgui::function_fe953f000498048f();
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 2
    // Checksum 0x0, Offset: 0x17d4
    // Size: 0xae, Type: dev
    function function_92cc0e279ea9f719( weaponobj, attachmentname )
    {
        var_b8ca516f1a797a1f = weaponobj getnoaltweapon();
        attachmenttoidmap = var_b8ca516f1a797a1f.attachmentvarindices;
        attachments = [];
        
        foreach ( attachment, id in attachmenttoidmap )
        {
            attachments[ attachments.size ] = attachment;
        }
        
        hasattachment = 0;
        
        if ( scripts\engine\utility::array_contains( attachments, attachmentname ) )
        {
            hasattachment = 1;
        }
        
        return hasattachment;
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 1
    // Checksum 0x0, Offset: 0x188a
    // Size: 0x6a, Type: dev
    function function_b263d5c9745dc016( entnum )
    {
        if ( !isdefined( level.weapdev.var_3b3b12cc96932083 ) )
        {
            return 0;
        }
        
        if ( !isdefined( level.weapdev.var_3b3b12cc96932083.entnum ) )
        {
            return 0;
        }
        
        return entnum == level.weapdev.var_3b3b12cc96932083.entnum;
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 0
    // Checksum 0x0, Offset: 0x18fc
    // Size: 0x28, Type: dev
    function function_17cdeb7626afb432()
    {
        for ( ;; )
        {
            if ( getdvar( @"hash_94cfa401914bb582" ) != "<dev string:x5b>" )
            {
                thread function_72bdcbf68a00d590();
            }
            
            waitframe();
        }
    }

    // Namespace weapons_dev / scripts\cp_mp\weapons_dev
    // Params 0
    // Checksum 0x0, Offset: 0x192c
    // Size: 0x180, Type: dev
    function function_72bdcbf68a00d590()
    {
        camo = getdvar( @"hash_94cfa401914bb582" );
        
        if ( isdefined( camo ) && camo != "<dev string:x5b>" )
        {
            camolist = [];
            camoref = "<dev string:x5b>";
            camoindex = int( camo );
            
            if ( camoindex != 0 )
            {
                for ( rowindex = 0; tablelookupbyrow( "<dev string:x46d>", rowindex, 1 ) != "<dev string:x5b>" ; rowindex++ )
                {
                    camolist[ camolist.size ] = tablelookupbyrow( "<dev string:x46d>", rowindex, 1 );
                }
                
                if ( camoindex < camolist.size )
                {
                    camoref = camolist[ camoindex ];
                }
            }
            else
            {
                camoref = camo;
            }
            
            foreach ( player in level.players )
            {
                weapon = player.currentweapon;
                player dropitem( weapon );
                weapon = weapon getnoaltweapon();
                
                if ( camoref != "<dev string:x5b>" )
                {
                    weapon = weapon withcamo( camoref );
                }
                else
                {
                    weapon = weapon withoutcamo();
                }
                
                player giveweapon( weapon );
                player setweaponammoclip( weapon, weaponclipsize( weapon ) );
                player setweaponammostock( weapon, weaponmaxammo( weapon ) );
                player _switchtoweaponimmediate( weapon );
            }
        }
        
        setdevdvar( @"hash_94cfa401914bb582", "<dev string:x5b>" );
    }

#/
