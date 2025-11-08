#using script_6df6604a74a7a9c7;
#using scripts\common\utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;

#namespace namespace_26050772d3578b37;

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 0
// Checksum 0x0, Offset: 0x312
// Size: 0x34
function function_a110e6203cd98cc9()
{
    if ( !istrue( level.var_700d76c630a8807c ) )
    {
        scripts\engine\scriptable::scriptable_adddamagedcallback( &function_e43f71d6d1c35383 );
        level.var_700d76c630a8807c = 1;
    }
    
    level.var_569c02e2320ca130 = 1.5;
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 2
// Checksum 0x0, Offset: 0x34e
// Size: 0x6a
function function_98264e8b6400bc85( callback_type, callbackfunc )
{
    if ( !isdefined( level.rune_callbacks ) || !isdefined( level.rune_callbacks[ callback_type ] ) )
    {
        level.rune_callbacks[ callback_type ] = 0;
    }
    
    utility::registersharedfunc( "zombie", callback_type + string( level.rune_callbacks[ callback_type ] ), callbackfunc );
    level.rune_callbacks[ callback_type ]++;
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 1
// Checksum 0x0, Offset: 0x3c0
// Size: 0x1e
function function_f35c102a1c5f2a6d( callbackfunc )
{
    utility::registersharedfunc( "zombie", "isAttackerValidForRune", callbackfunc, 0 );
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 3
// Checksum 0x0, Offset: 0x3e6
// Size: 0x7e
function function_a052c2969b025a94( callback_type, manager, eattacker )
{
    if ( !isdefined( level.rune_callbacks ) || !isdefined( level.rune_callbacks[ callback_type ] ) )
    {
        return;
    }
    
    for ( i = 0; i < level.rune_callbacks[ callback_type ] ; i++ )
    {
        utility::callsharedfunc( "zombie", callback_type + string( i ), manager.targetname, eattacker );
    }
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 4
// Checksum 0x0, Offset: 0x46c
// Size: 0x180
function function_857ac0179192120b( num_keys, sequence_name, var_24babb8dc6d1ef89, var_266a2e67ff9628e1 )
{
    manager = getstruct( sequence_name, "targetname" );
    keys = function_759722ee5b57fdd7( num_keys, 0, 8 );
    manager.keys = string_join( keys );
    manager.input_keys = "";
    manager.var_110cf8fc64d76958 = 1;
    function_4d535e852051c34b( manager );
    
    if ( isdefined( var_24babb8dc6d1ef89 ) && var_24babb8dc6d1ef89 > 0 )
    {
        manager.var_24babb8dc6d1ef89 = var_24babb8dc6d1ef89;
        thread function_650632f66cd313b7( manager );
    }
    
    var_a41733fa4b9eaac5 = getstructarray( manager.targetname, "script_noteworthy" );
    var_3733c278e504420c = [];
    
    if ( !isdefined( var_266a2e67ff9628e1 ) )
    {
        var_3733c278e504420c = var_a41733fa4b9eaac5;
    }
    else
    {
        foreach ( rune in var_a41733fa4b9eaac5 )
        {
            if ( rune.script_parameters == string( var_266a2e67ff9628e1 ) )
            {
                var_3733c278e504420c = array_add( var_3733c278e504420c, rune );
            }
        }
    }
    
    function_9cd5804e2fa21c69( manager, var_3733c278e504420c );
    function_2f1c7733804996dc( manager, 1 );
    
    /#
        if ( getdvarint( @"hash_dde36776227788a5", 0 ) )
        {
            manager thread function_3381abf9eeaee0f5();
        }
    #/
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 2
// Checksum 0x0, Offset: 0x5f4
// Size: 0x8e
function function_b7c2ddf5f84c1f61( var_5f8bb464b19d1f53, sequence_name )
{
    manager = getstruct( sequence_name, "targetname" );
    keys = [];
    
    for ( i = 0; i < var_5f8bb464b19d1f53.size ; i++ )
    {
        keys[ i ] = 0;
    }
    
    manager.keys = string_join( keys );
    manager.input_keys = "";
    manager.var_110cf8fc64d76958 = 0;
    function_9cd5804e2fa21c69( manager, var_5f8bb464b19d1f53 );
    return manager;
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 1
// Checksum 0x0, Offset: 0x68b
// Size: 0xf0
function function_4d535e852051c34b( manager )
{
    manager.var_b010dc081d6a5b9e = [];
    glyph_struct = manager;
    
    for ( i = 0; i < manager.keys.size ; i++ )
    {
        assert( isdefined( glyph_struct.target ), "<dev string:x1c>" );
        glyph_struct = getstruct( glyph_struct.target, "targetname" );
        var_cd753944acd74399 = function_5fbd85f165bb8819( glyph_struct, manager, manager.keys[ i ], 1 );
        var_cd753944acd74399 setscriptablepartstate( "health", "inactive" );
        forward = anglestoup( var_cd753944acd74399.angles );
        assert( !array_contains( manager.var_b010dc081d6a5b9e, var_cd753944acd74399 ) );
        manager.var_b010dc081d6a5b9e[ i ] = var_cd753944acd74399;
    }
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 1
// Checksum 0x0, Offset: 0x783
// Size: 0xa9
function function_650632f66cd313b7( manager )
{
    if ( isdefined( level ) )
    {
        level endon( "game_ended" );
    }
    
    manager endon( "rune_reset" );
    wait manager.var_24babb8dc6d1ef89;
    
    if ( isdefined( manager.var_b010dc081d6a5b9e ) )
    {
        foreach ( instance in manager.var_b010dc081d6a5b9e )
        {
            instance setscriptablepartstate( "model", "inactive" );
            instance setscriptablepartstate( "vfx", "off" );
        }
    }
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 2
// Checksum 0x0, Offset: 0x834
// Size: 0x1e2
function function_9cd5804e2fa21c69( manager, var_5f8bb464b19d1f53 )
{
    manager.var_1ea94f63b761803c = [];
    assertex( var_5f8bb464b19d1f53.size >= manager.keys.size, "<dev string:x4f>" );
    var_fcb014c591343ab2 = function_759722ee5b57fdd7( manager.keys.size, 0, var_5f8bb464b19d1f53.size );
    
    for ( i = 0; i < var_fcb014c591343ab2.size ; i++ )
    {
        input_struct = var_5f8bb464b19d1f53[ var_fcb014c591343ab2[ i ] ];
        
        if ( isdefined( input_struct.target ) )
        {
            var_d8264d57f6ea661c = [ input_struct ];
            next_struct = input_struct;
            
            while ( isdefined( next_struct.target ) )
            {
                next_struct = getstruct( next_struct.target, "targetname" );
                assert( !isdefined( next_struct.var_2229ba773caf2785 ) );
                assert( !isdefined( next_struct.script_parameters ) );
                var_d8264d57f6ea661c = array_add( var_d8264d57f6ea661c, next_struct );
            }
            
            var_5c563764e59bdadd = randomintrange( 0, var_d8264d57f6ea661c.size );
            input_struct = var_d8264d57f6ea661c[ var_5c563764e59bdadd ];
        }
        
        var_c582fb37a6bf9aa7 = function_5fbd85f165bb8819( input_struct, manager, manager.keys[ i ], 0 );
        var_c582fb37a6bf9aa7.var_6e1ffc1ce6ad69b7 = 1;
        forward = anglestoup( var_c582fb37a6bf9aa7.angles );
        var_c582fb37a6bf9aa7.stone_model = spawn_model( function_f9cf95976ac21710( manager.keys[ i ] ), var_c582fb37a6bf9aa7.origin - forward * 5, var_c582fb37a6bf9aa7.angles );
        assert( !array_contains( manager.var_1ea94f63b761803c, var_c582fb37a6bf9aa7 ) );
        manager.var_1ea94f63b761803c[ i ] = var_c582fb37a6bf9aa7;
    }
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 2
// Checksum 0x0, Offset: 0xa1e
// Size: 0x13d
function function_2f1c7733804996dc( manager, move_delay )
{
    if ( isdefined( level.crystals ) )
    {
        foreach ( crystal in level.crystals )
        {
            if ( crystal.script_parameters == manager.targetname )
            {
                foreach ( var_1fc4dc6317fafddf in manager.var_1ea94f63b761803c )
                {
                    trail = utility::spawn_model( "tag_origin", crystal.origin + ( 0, 0, 64 ) );
                    trail.goal_position = var_1fc4dc6317fafddf.origin;
                    playfxontag( getfx( "zombie_soul" ), trail, "tag_origin" );
                    trail thread function_c94394817834d4e5( move_delay, var_1fc4dc6317fafddf );
                }
                
                break;
            }
        }
    }
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 2
// Checksum 0x0, Offset: 0xb63
// Size: 0xb0
function function_c94394817834d4e5( move_delay, var_1fc4dc6317fafddf )
{
    level endon( "game_ended" );
    self endon( "death" );
    self playsound( "evt_ob_rr_crystal_break_rune_trail_spawn" );
    self playloopsound( "evt_ob_rr_crystal_break_rune_trail_travel_lp" );
    
    if ( move_delay > 0 )
    {
        wait move_delay;
    }
    
    movetime = distance( self.origin, self.goal_position ) / 256;
    self moveto( self.goal_position, movetime, 0.2 );
    self waittill( "movedone" );
    self playsound( "evt_ob_rr_crystal_break_rune_trail_impact" );
    killfxontag( getfx( "zombie_soul" ), self, "tag_origin" );
    self delete();
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 4
// Checksum 0x0, Offset: 0xc1b
// Size: 0xc6
function function_5fbd85f165bb8819( marker_struct, manager, key, var_b16c2b68e8380e39 )
{
    var_458342df61da4b6e = ter_op( var_b16c2b68e8380e39, "ob_combo_rune_sequence_display", "ob_combo_rune_sequence" );
    var_128a3d3fa7a8b8ea = anglestoaxis( marker_struct.angles );
    var_f89d0b187bab99f6 = axistoangles( var_128a3d3fa7a8b8ea[ "up" ] * -1, var_128a3d3fa7a8b8ea[ "right" ], var_128a3d3fa7a8b8ea[ "forward" ] );
    scriptable = spawnscriptable( var_458342df61da4b6e, marker_struct.origin, var_f89d0b187bab99f6 );
    scriptable.manager = manager;
    scriptable setscriptablepartstate( "model", key );
    scriptable.rune_key = key;
    return scriptable;
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 1
// Checksum 0x0, Offset: 0xcea
// Size: 0x5c
function function_f9cf95976ac21710( index )
{
    switch ( index )
    {
        case #"hash_31100dbc01bd3556":
        case #"hash_31100ebc01bd36e9":
        case #"hash_31100fbc01bd387c":
        case #"hash_311012bc01bd3d35":
            return "ee_rune_flagstone_02_scr";
        default:
            return "ee_rune_flagstone_scr";
    }
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 2
// Checksum 0x0, Offset: 0xd4e
// Size: 0x13b
function function_4575ce4d8f4bf822( manager, input_key )
{
    instance = self;
    instance setscriptablepartstate( "vfx", input_key + "_incorrect" );
    instance setscriptablepartstate( "model", "inactive" );
    
    if ( isdefined( manager.var_b010dc081d6a5b9e ) )
    {
        foreach ( display_rune in manager.var_b010dc081d6a5b9e )
        {
            display_rune setscriptablepartstate( "vfx", display_rune.rune_key + "_incorrect" );
            display_rune setscriptablepartstate( "model", "inactive" );
        }
    }
    
    foreach ( input_rune in manager.var_1ea94f63b761803c )
    {
        input_rune setscriptablepartstate( "health", "inactive" );
    }
    
    instance function_bbfa3e81df7313aa( manager, input_key, 0 );
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 3
// Checksum 0x0, Offset: 0xe91
// Size: 0x91
function function_bbfa3e81df7313aa( manager, input_key, is_correct )
{
    instance = self;
    state = ter_op( is_correct, "correct", "incorrect" );
    
    if ( isdefined( manager.var_b010dc081d6a5b9e ) )
    {
        display_glyph = manager.var_b010dc081d6a5b9e[ manager.input_keys.size - 1 ];
        display_glyph setscriptablepartstate( "sfx", state );
    }
    
    instance setscriptablepartstate( "sfx", state );
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 11
// Checksum 0x0, Offset: 0xf2a
// Size: 0x304
function function_e43f71d6d1c35383( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vhitloc, modelindex, partname )
{
    if ( !isdefined( instance ) || instance.type != "ob_combo_rune_sequence" || !istrue( instance.var_6e1ffc1ce6ad69b7 ) )
    {
        return;
    }
    
    if ( !isplayer( eattacker ) )
    {
        instance setscriptablepartstate( "health", "damageable" );
        return;
    }
    
    if ( einflictor.classname == "rocket" || einflictor.classname == "grenade" )
    {
        if ( distance( vhitloc, einflictor.origin ) > 2 )
        {
            instance setscriptablepartstate( "health", "damageable" );
            return;
        }
    }
    
    if ( issharedfuncdefined( "zombie", "isAttackerValidForRune" ) )
    {
        if ( !callsharedfunc( "zombie", "isAttackerValidForRune", eattacker ) )
        {
            instance setscriptablepartstate( "health", "damageable" );
            return;
        }
    }
    
    manager = instance.manager;
    input_key = instance getscriptablepartstate( "model", 0 );
    manager.input_keys += input_key;
    result = function_33c458e08626294f( manager.input_keys, manager.keys );
    
    switch ( result )
    {
        case #"hash_f43afb7b1b11f010":
            /#
                iprintlnbold( "<dev string:x84>" );
            #/
            
            instance function_4575ce4d8f4bf822( manager, input_key );
            function_a052c2969b025a94( "invalid", manager, eattacker );
            wait 1.5;
            manager function_a6f3de8969ab6191();
            break;
        case #"hash_46ae47a56ec251e2":
        case #"hash_e2450218207b1651":
            /#
                iprintlnbold( "<dev string:x93>" );
            #/
            
            instance setscriptablepartstate( "vfx", input_key );
            instance setscriptablepartstate( "model", "inactive" );
            instance setscriptablepartstate( "health", "inactive" );
            
            if ( isdefined( manager.var_b010dc081d6a5b9e ) )
            {
                display_glyph = manager.var_b010dc081d6a5b9e[ manager.input_keys.size - 1 ];
                display_glyph setscriptablepartstate( "vfx", input_key );
                display_glyph setscriptablepartstate( "model", "inactive" );
            }
            
            instance function_bbfa3e81df7313aa( manager, input_key, 1 );
            function_a052c2969b025a94( "valid", manager, eattacker );
            break;
    }
    
    if ( result == "complete" )
    {
        /#
            iprintlnbold( "<dev string:xaf>" );
        #/
        
        wait 1;
        function_a052c2969b025a94( "complete", manager, eattacker );
        
        if ( istrue( manager.var_110cf8fc64d76958 ) )
        {
            manager function_a6f3de8969ab6191();
            return;
        }
        
        manager function_a63a2112c7b585e5();
    }
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 0
// Checksum 0x0, Offset: 0x1236
// Size: 0x184
function function_24e03be2bc20e57b()
{
    manager = self;
    manager.input_keys = "";
    
    foreach ( instance in manager.var_1ea94f63b761803c )
    {
        instance setscriptablepartstate( "model", instance.rune_key );
        instance setscriptablepartstate( "vfx", "unlinked" );
        instance setscriptablepartstate( "health", "damageable" );
        instance setscriptablepartstate( "sfx", "off" );
        instance.stone_model show();
    }
    
    if ( isdefined( manager.var_b010dc081d6a5b9e ) )
    {
        foreach ( instance in manager.var_b010dc081d6a5b9e )
        {
            instance setscriptablepartstate( "model", instance.rune_key );
            instance setscriptablepartstate( "vfx", "unlinked" );
            instance setscriptablepartstate( "sfx", "off" );
        }
    }
    
    manager notify( "rune_reset" );
    
    if ( isdefined( manager.var_24babb8dc6d1ef89 ) && manager.var_24babb8dc6d1ef89 > 0 )
    {
        thread function_650632f66cd313b7( manager );
    }
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 0
// Checksum 0x0, Offset: 0x13c2
// Size: 0x13e
function function_a63a2112c7b585e5()
{
    manager = self;
    manager.input_keys = "";
    
    if ( isdefined( manager.var_b010dc081d6a5b9e ) )
    {
        foreach ( instance in manager.var_b010dc081d6a5b9e )
        {
            instance setscriptablepartstate( "model", "inactive" );
            instance setscriptablepartstate( "vfx", "off" );
            instance setscriptablepartstate( "sfx", "off" );
        }
    }
    
    foreach ( instance in manager.var_1ea94f63b761803c )
    {
        instance setscriptablepartstate( "model", "inactive" );
        instance setscriptablepartstate( "vfx", "off" );
        instance setscriptablepartstate( "sfx", "off" );
        instance.stone_model hide();
    }
    
    manager notify( "rune_reset" );
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 0
// Checksum 0x0, Offset: 0x1508
// Size: 0x167
function function_a6f3de8969ab6191()
{
    manager = self;
    manager.keys = undefined;
    manager.input_keys = undefined;
    
    if ( isdefined( manager.var_b010dc081d6a5b9e ) )
    {
        foreach ( instance in manager.var_b010dc081d6a5b9e )
        {
            instance setscriptablepartstate( "model", "inactive" );
            instance setscriptablepartstate( "vfx", "off" );
            instance setscriptablepartstate( "sfx", "off" );
            instance freescriptable();
        }
        
        manager.var_b010dc081d6a5b9e = undefined;
    }
    
    foreach ( instance in manager.var_1ea94f63b761803c )
    {
        instance setscriptablepartstate( "model", "inactive" );
        instance setscriptablepartstate( "vfx", "off" );
        instance setscriptablepartstate( "sfx", "off" );
        instance.stone_model delete();
        instance freescriptable();
    }
    
    manager.var_1ea94f63b761803c = undefined;
    manager notify( "rune_reset" );
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 3
// Checksum 0x0, Offset: 0x1677
// Size: 0x79
function function_759722ee5b57fdd7( num_keys, min, max )
{
    assert( num_keys <= max - min, "<dev string:xcb>" );
    keys = [];
    
    for ( i = 0; i < num_keys ; i++ )
    {
        key = randomintrange( min, max );
        
        if ( !arraycontains( keys, key ) )
        {
            keys[ i ] = key;
            continue;
        }
        
        i--;
    }
    
    return keys;
}

// Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
// Params 2
// Checksum 0x0, Offset: 0x16f9
// Size: 0x3a
function function_33c458e08626294f( input_keys, keys )
{
    if ( input_keys == getsubstr( keys, 0, input_keys.size ) )
    {
        if ( input_keys.size == keys.size )
        {
            return "complete";
        }
        
        return "valid";
    }
    
    return "invalid";
}

/#

    // Namespace namespace_26050772d3578b37 / namespace_324cb75236a72d33
    // Params 0
    // Checksum 0x0, Offset: 0x173c
    // Size: 0x90, Type: dev
    function function_3381abf9eeaee0f5()
    {
        level endon( "<dev string:xf8>" );
        self endon( "<dev string:x106>" );
        
        while ( true )
        {
            foreach ( var_1fc4dc6317fafddf in self.var_1ea94f63b761803c )
            {
                draw_arrow( self.origin, var_1fc4dc6317fafddf.origin, ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

#/
