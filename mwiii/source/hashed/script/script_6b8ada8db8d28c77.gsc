#using script_12668187dcf15b96;
#using script_3113b52a395cd586;
#using script_d09ad38bcf5794b;
#using scripts\common\utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\engine\scriptable_door;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\locksandkeys;

#namespace namespace_2b6fc7c256cafc0;

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 0
// Checksum 0x0, Offset: 0x1da
// Size: 0x79
function init()
{
    if ( !isdefined( level.exgm ) )
    {
        level.exgm = spawnstruct();
    }
    
    scripts\mp\locksandkeys::init();
    scripts\engine\scriptable_door::function_29ba88e5ce21f3fd( &function_6416fb9a24d278b4 );
    scripts\engine\scriptable_door::function_e37078f3d00ef312( &function_504f19b32802cb8d );
    
    while ( !isdefined( level.tool_use ) || !istrue( level.tool_use.init ) )
    {
        waitframe();
    }
    
    function_b2eb3fc6ccae115e();
    
    /#
        level thread debug_doors();
    #/
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x25b
// Size: 0x134
function private function_b2eb3fc6ccae115e()
{
    if ( isdefined( level.exgm ) && isdefined( level.exgm.lockedspaces ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    level.exgm.lockedspaces = [];
    var_4c7bfe49f37e4faf = getstructarray( "exgm_locked_space", "script_noteworthy" );
    assert( isdefined( var_4c7bfe49f37e4faf ) );
    
    if ( var_4c7bfe49f37e4faf.size <= 0 )
    {
        println( "<dev string:x5e>" );
        return;
    }
    
    /#
        function_656d643079457017( var_4c7bfe49f37e4faf );
    #/
    
    var_52e1498c41df1407 = function_39c8d8e7c1719ed4( var_4c7bfe49f37e4faf );
    
    if ( !isdefined( var_52e1498c41df1407 ) )
    {
        println( "<dev string:xb6>" );
        return;
    }
    
    foreach ( node in var_52e1498c41df1407 )
    {
        if ( !isdefined( node ) )
        {
            continue;
        }
        
        node function_4f241614c981db96();
        level.exgm.lockedspaces[ level.exgm.lockedspaces.size ] = node;
    }
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x397
// Size: 0x135
function private function_39c8d8e7c1719ed4( var_4c7bfe49f37e4faf )
{
    if ( getdvarint( @"hash_e87cee823579fbd8", 0 ) == 1 )
    {
        return var_4c7bfe49f37e4faf;
    }
    
    hotzones = getlootzoneshotwithtype();
    
    if ( !isdefined( hotzones ) )
    {
        return undefined;
    }
    
    var_7c28d6d15ff7e61e = [];
    
    foreach ( hotzone in hotzones )
    {
        if ( !isdefined( hotzone ) )
        {
            continue;
        }
        
        zoneindex = hotzone.zoneindex;
        zonetype = hotzone.zonetype;
        
        if ( !isdefined( zoneindex ) || !isdefined( zonetype ) || zonetype != 8 )
        {
            continue;
        }
        
        mainnode = function_f6ca723a91bb41bf( zoneindex, var_4c7bfe49f37e4faf, var_7c28d6d15ff7e61e );
        
        if ( !isdefined( mainnode ) )
        {
            println( "<dev string:xfe>" + namespace_36be7f9eab6ca7bc::function_bf040858853b69df( zoneindex ) );
            continue;
        }
        
        /#
            mainnode.zoneindex = zoneindex;
            mainnode.zonename = getlootzonename( zoneindex );
        #/
        
        var_7c28d6d15ff7e61e = array_add( var_7c28d6d15ff7e61e, mainnode );
    }
    
    return var_7c28d6d15ff7e61e;
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x4d5
// Size: 0xc2
function private function_f6ca723a91bb41bf( zoneindex, var_96ef5feafe62d6fa, excludenodes )
{
    if ( isdefined( zoneindex ) && isdefined( var_96ef5feafe62d6fa ) )
    {
        epsilon = 0.1;
        
        foreach ( mainnode in var_96ef5feafe62d6fa )
        {
            if ( !isdefined( mainnode ) || isdefined( excludenodes ) && array_contains( excludenodes, mainnode ) )
            {
                continue;
            }
            
            var_3cbdb56ae84724e6 = getpointtozoneboundsdistsq( zoneindex, mainnode.origin );
            
            if ( isdefined( var_3cbdb56ae84724e6 ) && var_3cbdb56ae84724e6 < epsilon )
            {
                return mainnode;
            }
        }
    }
    
    return undefined;
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x5a0
// Size: 0xc8
function private function_4f241614c981db96()
{
    subnodes = getstructarray( self.target, "targetname" );
    assert( isdefined( subnodes ) );
    
    foreach ( node in subnodes )
    {
        if ( !isdefined( node ) || !isdefined( node.script_noteworthy ) || !isdefined( node.origin ) )
        {
            continue;
        }
        
        if ( !isdefined( node.angles ) )
        {
            node.angles = ( 0, 0, 0 );
        }
        
        function_db053c578a9de360( node );
    }
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x670
// Size: 0x8a
function private function_db053c578a9de360( subnode )
{
    assert( isdefined( subnode ) );
    
    switch ( tolower( subnode.script_noteworthy ) )
    {
        case #"hash_8f30172a5213bf0a":
            function_7ed146ec8f255585( subnode );
            break;
        case #"hash_9c365061f1e6f507":
            function_d2d0c9d710b1d69d( subnode );
            break;
        case #"hash_f776ad1e72595fcb":
            setupcache( subnode );
            break;
        default:
            setupprop( subnode );
            break;
    }
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x702
// Size: 0x90
function private setupcache( subnode )
{
    assert( isdefined( subnode ) );
    
    if ( !isdefined( self.caches ) )
    {
        self.caches = [];
    }
    
    cache = spawnscriptable( "cache_exgm_cache_crowbar_door", subnode.origin, subnode.angles );
    
    if ( !isdefined( cache ) )
    {
        println( "<dev string:x13a>" );
        return;
    }
    
    cache.node = subnode;
    self.caches[ self.caches.size ] = cache;
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x79a
// Size: 0xd0
function private function_d2d0c9d710b1d69d( subnode )
{
    assert( isdefined( subnode ) );
    
    if ( !isdefined( self.var_6c0ed674eec9b897 ) )
    {
        self.var_6c0ed674eec9b897 = [];
    }
    
    doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius( subnode.origin, 100, 100 );
    
    if ( isdefined( doors ) && doors.size > 0 )
    {
        foreach ( door in doors )
        {
            if ( !isdefined( door ) )
            {
                continue;
            }
            
            door function_9af4c9b2cc1bf989();
            door.var_d9169fc096165e2b = 1;
            self.var_6c0ed674eec9b897[ self.var_6c0ed674eec9b897.size ] = door;
        }
    }
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x872
// Size: 0x77
function private setupprop( subnode )
{
    assert( isdefined( subnode ) );
    
    if ( !isdefined( self.props ) )
    {
        self.props = [];
    }
    
    prop = namespace_92675a37bd817c19::function_c682e2b1b49deb8f( subnode );
    
    if ( !isdefined( prop ) )
    {
        println( "<dev string:x16d>" );
        return;
    }
    
    prop.node = subnode;
    self.props[ self.props.size ] = prop;
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 2
// Checksum 0x0, Offset: 0x8f1
// Size: 0x12d
function function_95faa2e34b9a63a9( subnode, var_9b044ef6110bc60f )
{
    if ( !isdefined( subnode ) || !isdefined( subnode.origin ) || !isdefined( subnode.angles ) )
    {
        println( "<dev string:x19e>" );
        return;
    }
    
    if ( !isdefined( var_9b044ef6110bc60f ) )
    {
        println( "<dev string:x1d1>" );
        return;
    }
    
    doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius( subnode.origin, 100, 100 );
    
    if ( isdefined( doors ) && doors.size > 0 )
    {
        foreach ( door in doors )
        {
            if ( !isdefined( door ) || door scriptabledoorisdouble() )
            {
                continue;
            }
            
            door setscriptablepartstate( "door", "invisible" );
        }
    }
    
    spawneddoor = spawnscriptable( var_9b044ef6110bc60f, subnode.origin, subnode.angles );
    
    /#
        if ( !isdefined( spawneddoor ) )
        {
            println( "<dev string:x20a>" + var_9b044ef6110bc60f );
        }
    #/
    
    return spawneddoor;
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xa27
// Size: 0xad
function private function_7ed146ec8f255585( subnode )
{
    assert( isdefined( subnode ) );
    assert( isdefined( subnode.origin ) );
    assert( isdefined( subnode.angles ) );
    
    if ( !isdefined( self.tooldoors ) )
    {
        self.tooldoors = [];
    }
    
    newdoor = function_95faa2e34b9a63a9( subnode, "scriptable_door_exgm_tool_use" );
    
    if ( isdefined( newdoor ) )
    {
        newdoor.node = subnode;
        newdoor.var_12669c62db1142f2 = 1;
        newdoor function_88d3ebef9894c114();
        self.tooldoors[ self.tooldoors.size ] = newdoor;
    }
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xadc
// Size: 0xb
function private function_88d3ebef9894c114()
{
    thread namespace_8a301a9e06bc923e::function_9c3bc425fad907df( self );
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 3
// Checksum 0x0, Offset: 0xaef
// Size: 0x3b
function function_504f19b32802cb8d( scriptable, player, var_85e3240d30e184e7 )
{
    if ( function_d9169fc096165e2b( scriptable ) || function_12669c62db1142f2( scriptable ) )
    {
        return 0;
    }
    
    return scripts\mp\locksandkeys::function_504f19b32802cb8d( scriptable, player, var_85e3240d30e184e7 );
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 2
// Checksum 0x0, Offset: 0xb33
// Size: 0x36
function function_6416fb9a24d278b4( scriptable, player )
{
    if ( function_d9169fc096165e2b( scriptable ) || function_12669c62db1142f2( scriptable ) )
    {
        return &"MP_DMZ_LOCKS/LOCKED";
    }
    
    return scripts\mp\locksandkeys::function_6416fb9a24d278b4( scriptable, player );
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb72
// Size: 0x1d, Type: bool
function private function_12669c62db1142f2( scriptable )
{
    return isdefined( scriptable ) && istrue( scriptable.var_12669c62db1142f2 );
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb98
// Size: 0x1d, Type: bool
function private function_d9169fc096165e2b( scriptable )
{
    return isdefined( scriptable ) && istrue( scriptable.var_d9169fc096165e2b );
}

// Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xbbe
// Size: 0xa9
function private function_77b38d54acb385f2( door, player )
{
    assert( isdefined( door ) && isdefined( player ) );
    var_1551eedc8effb6b6 = player.origin - door.origin;
    doorforward = anglestoforward( door.angles );
    crossz = doorforward[ 0 ] * var_1551eedc8effb6b6[ 1 ] - doorforward[ 1 ] * var_1551eedc8effb6b6[ 0 ];
    
    if ( abs( crossz ) < 0.1 )
    {
        assertmsg( "<dev string:x23e>" );
        return 0;
    }
    
    if ( crossz > 0 )
    {
        return 1;
    }
    
    return 0;
}

/#

    // Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
    // Params 0
    // Checksum 0x0, Offset: 0xc6f
    // Size: 0xad, Type: dev
    function debug_doors()
    {
        level endon( "<dev string:x29d>" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_6d2af0dd80a139a8", 0 ) == 1 )
            {
                setdvar( @"hash_6d2af0dd80a139a8", 0 );
                level thread function_b314668b145fe144();
            }
            
            if ( getdvarint( @"hash_a1ffbba0cca4a8be", 0 ) == 1 )
            {
                setdvar( @"hash_a1ffbba0cca4a8be", 0 );
                level thread function_5808f7179c6a8a9d();
            }
            
            if ( getdvarint( @"hash_7314da8a381200a3", 0 ) == 1 )
            {
                level thread function_8e69a7b58eeff341();
            }
            
            if ( getdvarint( @"hash_18d9381f047d4e0f", 0 ) == 1 )
            {
                level thread function_bd85f751464c186d();
            }
            
            waitframe();
        }
    }

    // Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
    // Params 0
    // Checksum 0x0, Offset: 0xd24
    // Size: 0x166, Type: dev
    function function_b314668b145fe144()
    {
        var_34c03e07a8e8888 = [];
        
        foreach ( var_809fdff7726141bb in level.exgm.lockedspaces )
        {
            if ( !isdefined( var_809fdff7726141bb ) )
            {
                continue;
            }
            
            foreach ( door in var_809fdff7726141bb.tooldoors )
            {
                if ( isdefined( door ) && !isdefined( door.tool_user ) )
                {
                    var_34c03e07a8e8888[ var_34c03e07a8e8888.size ] = door;
                }
            }
        }
        
        foreach ( door in var_34c03e07a8e8888 )
        {
            door scriptabledoorclose();
        }
        
        wait 2;
        
        foreach ( door in var_34c03e07a8e8888 )
        {
            door function_88d3ebef9894c114();
        }
    }

    // Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
    // Params 0
    // Checksum 0x0, Offset: 0xe92
    // Size: 0x144, Type: dev
    function function_5808f7179c6a8a9d()
    {
        subnode = spawnstruct();
        subnode.angles = level.players[ 0 ].angles;
        subnode.origin = level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 50;
        subnode.origin = scripts\mp\gametypes\br_public::droptogroundmultitrace( subnode.origin, 100, -100 );
        mainnode = spawnstruct();
        mainnode.target = "<dev string:x2ab>";
        mainnode.origin = subnode.origin + ( 0, 0, 100 );
        mainnode.zonename = "<dev string:x2ab>";
        mainnode.var_d7204dbfcf3540cb = [];
        mainnode.var_d7204dbfcf3540cb[ 0 ] = subnode;
        function_7c1bf24c78f1b6db( mainnode );
        mainnode function_7ed146ec8f255585( subnode );
        level.exgm.lockedspaces[ level.exgm.lockedspaces.size ] = mainnode;
    }

    // Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
    // Params 1
    // Checksum 0x0, Offset: 0xfde
    // Size: 0x5a, Type: dev
    function function_656d643079457017( mainnodes )
    {
        foreach ( node in mainnodes )
        {
            function_7c1bf24c78f1b6db( node );
        }
    }

    // Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
    // Params 1
    // Checksum 0x0, Offset: 0x1040
    // Size: 0x9b, Type: dev
    function function_7c1bf24c78f1b6db( mainnode )
    {
        if ( !isdefined( mainnode ) )
        {
            return;
        }
        
        if ( !isdefined( level.exgm.var_1d27449e146df7c5 ) )
        {
            level.exgm.var_1d27449e146df7c5 = [];
        }
        
        if ( !isdefined( mainnode.var_d7204dbfcf3540cb ) )
        {
            mainnode.var_d7204dbfcf3540cb = getstructarray( mainnode.target, "<dev string:x2be>" );
        }
        
        level.exgm.var_1d27449e146df7c5[ level.exgm.var_1d27449e146df7c5.size ] = mainnode;
    }

    // Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
    // Params 0
    // Checksum 0x0, Offset: 0x10e3
    // Size: 0xce, Type: dev
    function function_8e69a7b58eeff341()
    {
        if ( !isdefined( level.exgm.var_1d27449e146df7c5 ) || level.exgm.var_1d27449e146df7c5.size == 0 )
        {
            return;
        }
        
        colorred = ( 1, 0, 0 );
        colorgreen = ( 0, 1, 0 );
        
        foreach ( node in level.exgm.var_1d27449e146df7c5 )
        {
            if ( !isdefined( node ) )
            {
                continue;
            }
            
            function_d4e7dd0e52999f80( node, colorred, colorgreen );
        }
    }

    // Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
    // Params 0
    // Checksum 0x0, Offset: 0x11b9
    // Size: 0xb7, Type: dev
    function function_bd85f751464c186d()
    {
        if ( !isdefined( level.exgm.lockedspaces ) || level.exgm.lockedspaces.size == 0 )
        {
            return;
        }
        
        coloryellow = ( 1, 1, 0 );
        
        foreach ( node in level.exgm.lockedspaces )
        {
            if ( !isdefined( node ) )
            {
                continue;
            }
            
            function_d4e7dd0e52999f80( node, coloryellow, coloryellow );
        }
    }

    // Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
    // Params 3
    // Checksum 0x0, Offset: 0x1278
    // Size: 0x190, Type: dev
    function function_d4e7dd0e52999f80( mainnode, var_d785d83def2cb406, var_17b0e0732d31c8fb )
    {
        if ( !isdefined( mainnode.target ) || !isdefined( mainnode.origin ) )
        {
            return;
        }
        
        debugtextoffset = ( 0, 0, -20 );
        debugcircleradius = 15;
        var_51a809d1653be858 = ( 0, 0, -10 );
        var_d785d83def2cb406 = ter_op( isdefined( var_d785d83def2cb406 ), var_d785d83def2cb406, ( 1, 0, 0 ) );
        var_17b0e0732d31c8fb = ter_op( isdefined( var_17b0e0732d31c8fb ), var_17b0e0732d31c8fb, ( 1, 0, 0 ) );
        var_f1faf36202ac327f = 1000;
        sphere( mainnode.origin, var_f1faf36202ac327f, var_d785d83def2cb406 );
        function_203964a4bdac9656( mainnode, "<dev string:x2cc>", undefined, var_d785d83def2cb406, mainnode.origin + debugtextoffset, var_51a809d1653be858 );
        subnodes = [];
        subnodes = mainnode.var_d7204dbfcf3540cb;
        
        if ( !isdefined( subnodes ) || !isarray( subnodes ) || subnodes.size == 0 )
        {
            return;
        }
        
        foreach ( node in subnodes )
        {
            if ( !isdefined( node ) )
            {
                continue;
            }
            
            function_203964a4bdac9656( node, "<dev string:x2d8>", mainnode, var_17b0e0732d31c8fb, node.origin + debugtextoffset, var_51a809d1653be858 );
        }
    }

    // Namespace namespace_2b6fc7c256cafc0 / namespace_74c5cf8e20fcae83
    // Params 6
    // Checksum 0x0, Offset: 0x1410
    // Size: 0x2dc, Type: dev
    function function_203964a4bdac9656( node, nodename, mainnode, debugcolor, var_5f7a6434de19ecb, var_51a809d1653be858 )
    {
        if ( !isdefined( node ) || !isdefined( node.origin ) )
        {
            return;
        }
        
        var_240b001b02e3191f = 15;
        sphere( node.origin, var_240b001b02e3191f, debugcolor );
        
        if ( isdefined( mainnode ) && isdefined( mainnode.origin ) && mainnode != node )
        {
            thread draw_line_for_time( node.origin, mainnode.origin, debugcolor[ 0 ], debugcolor[ 1 ], debugcolor[ 2 ], level.framedurationseconds );
        }
        
        if ( isdefined( nodename ) )
        {
            debugtext = nodename + "<dev string:x2e3>";
            print3d( var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1 );
            var_5f7a6434de19ecb += var_51a809d1653be858;
        }
        
        debugtext = "<dev string:x2e8>" + node.origin[ 0 ] + "<dev string:x2f5>" + node.origin[ 1 ] + "<dev string:x2f5>" + node.origin[ 2 ] + "<dev string:x2fb>";
        print3d( var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1 );
        var_5f7a6434de19ecb += var_51a809d1653be858;
        
        if ( isdefined( node.angles ) )
        {
            debugtext = "<dev string:x300>" + node.angles[ 0 ] + "<dev string:x2f5>" + node.angles[ 1 ] + "<dev string:x2f5>" + node.angles[ 2 ] + "<dev string:x2fb>";
            print3d( var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1 );
            var_5f7a6434de19ecb += var_51a809d1653be858;
        }
        
        if ( isdefined( node.zoneindex ) )
        {
            debugtext = "<dev string:x30d>" + node.zoneindex;
            print3d( var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1 );
            var_5f7a6434de19ecb += var_51a809d1653be858;
        }
        
        if ( isdefined( node.zonename ) )
        {
            debugtext = "<dev string:x31c>" + node.zonename;
            print3d( var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1 );
            var_5f7a6434de19ecb += var_51a809d1653be858;
        }
        
        if ( isdefined( node.target ) )
        {
            debugtext = "<dev string:x32a>" + node.target;
            print3d( var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1 );
            var_5f7a6434de19ecb += var_51a809d1653be858;
        }
        
        if ( isdefined( node.targetname ) )
        {
            debugtext = "<dev string:x336>" + node.targetname;
            print3d( var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1 );
            var_5f7a6434de19ecb += var_51a809d1653be858;
        }
        
        if ( isdefined( node.script_noteworthy ) )
        {
            debugtext = "<dev string:x346>" + node.script_noteworthy;
            print3d( var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1 );
            var_5f7a6434de19ecb += var_51a809d1653be858;
        }
    }

#/
