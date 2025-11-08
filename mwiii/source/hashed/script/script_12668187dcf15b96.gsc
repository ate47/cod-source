#using scripts\cp_mp\utility\debug_utility;
#using scripts\engine\utility;

#namespace namespace_98c7b65bbafed54d;

/#

    // Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
    // Params 0
    // Checksum 0x0, Offset: 0x130
    // Size: 0xc, Type: dev
    function init()
    {
        function_225667c119b5512d();
    }

#/

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 2
// Checksum 0x0, Offset: 0x144
// Size: 0x37
function asserteq( a, b )
{
    if ( a != b )
    {
        assertmsg( "<dev string:x1c>" + a + "<dev string:x32>" + b + "<dev string:x3c>" );
    }
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 3
// Checksum 0x0, Offset: 0x183
// Size: 0x46
function function_e628167199cd25d1( a, b, epsilon )
{
    if ( abs( a - b ) >= epsilon )
    {
        assertmsg( "<dev string:x41>" + a + "<dev string:x32>" + b + "<dev string:x3c>" );
    }
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 3
// Checksum 0x0, Offset: 0x1d1
// Size: 0x49
function function_47c544bb1ff442c1( a, b, epsilon )
{
    function_e628167199cd25d1( a[ 0 ], b[ 0 ], epsilon );
    function_e628167199cd25d1( a[ 1 ], b[ 1 ], epsilon );
    function_e628167199cd25d1( a[ 2 ], b[ 2 ], epsilon );
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 9
// Checksum 0x0, Offset: 0x222
// Size: 0x165
function formatstring( formatstring, a1, a2, a3, a4, a5, a6, a7, a8 )
{
    outstring = "";
    arguments = [ a1, a2, a3, a4, a5, a6, a7, a8 ];
    var_5bb9f1c8a1b75859 = 0;
    
    for ( var_8a24990107fab8c5 = 0; var_8a24990107fab8c5 < formatstring.size ; var_8a24990107fab8c5++ )
    {
        curchar = formatstring[ var_8a24990107fab8c5 ];
        
        if ( curchar != "%" )
        {
            outstring += curchar;
            continue;
        }
        
        var_b0f801f1cbcf354a = var_8a24990107fab8c5 + 1 < formatstring.size;
        
        if ( !var_b0f801f1cbcf354a )
        {
            outstring += curchar;
            continue;
        }
        
        nextchar = formatstring[ var_8a24990107fab8c5 + 1 ];
        
        if ( nextchar != "s" )
        {
            outstring += curchar;
            continue;
        }
        
        if ( var_5bb9f1c8a1b75859 < arguments.size )
        {
            argument = arguments[ var_5bb9f1c8a1b75859 ];
            
            if ( isdefined( argument ) )
            {
                outstring += argument;
            }
            else
            {
                outstring += "<UNDEFINED>";
            }
            
            var_5bb9f1c8a1b75859 += 1;
        }
        else
        {
            outstring += "<NOT ENOUGH PARAMS>";
        }
        
        var_8a24990107fab8c5 += 1;
    }
    
    return outstring;
}

/#

    // Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
    // Params 9
    // Checksum 0x0, Offset: 0x390
    // Size: 0x74, Type: dev
    function function_e1b1d2af636da618( formatstring, a1, a2, a3, a4, a5, a6, a7, a8 )
    {
        var_e6a1b876521be55a = formatstring( formatstring, a1, a2, a3, a4, a5, a6, a7, a8 );
        println( var_e6a1b876521be55a );
    }

#/

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 1
// Checksum 0x0, Offset: 0x40c
// Size: 0x99
function function_bf040858853b69df( zoneindex )
{
    debugstring = "";
    
    if ( isdefined( zoneindex ) )
    {
        debugstring += "[ZoneIndex:" + zoneindex + "]";
    }
    
    zonename = getlootzonename( zoneindex );
    
    if ( isdefined( zonename ) )
    {
        debugstring += "[ZoneName:" + zonename + "]";
    }
    
    mainbounds = getlootzonebounds( zoneindex );
    
    if ( isdefined( mainbounds ) && isdefined( mainbounds.midpoint ) )
    {
        debugstring += "[MainBoundsMidpoint:" + mainbounds.midpoint + "]";
    }
    
    return debugstring;
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4ae
// Size: 0xa8
function private function_d5d53f51c4662986( inputarray, var_c36279dae4b5f671 )
{
    var_330c401bd2801f95 = [];
    
    foreach ( entry in inputarray )
    {
        if ( var_330c401bd2801f95.size >= var_c36279dae4b5f671 )
        {
            break;
        }
        
        if ( isdefined( entry ) )
        {
            entrystring = "" + entry;
        }
        else
        {
            entrystring = "<UNDEFINED>";
        }
        
        var_330c401bd2801f95[ var_330c401bd2801f95.size ] = entrystring;
    }
    
    while ( var_330c401bd2801f95.size < var_c36279dae4b5f671 )
    {
        var_330c401bd2801f95[ var_330c401bd2801f95.size ] = "<MISSING ENTRY>";
    }
    
    return var_330c401bd2801f95;
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x55f
// Size: 0x167
function private function_83c890a0c71ae6b8( tabletitle, var_cd8110645a9a2632, var_871bdbc7e5abb341 )
{
    var_7609bd31a83cbe86 = var_cd8110645a9a2632.size;
    var_c8aa3700cdf30ff5 = [];
    var_c8aa3700cdf30ff5[ var_c8aa3700cdf30ff5.size ] = function_d5d53f51c4662986( var_cd8110645a9a2632, var_7609bd31a83cbe86 );
    
    foreach ( row in var_871bdbc7e5abb341 )
    {
        var_c8aa3700cdf30ff5[ var_c8aa3700cdf30ff5.size ] = function_d5d53f51c4662986( row, var_7609bd31a83cbe86 );
    }
    
    var_f6d49118d999070b = [];
    
    for ( column = 0; column < var_7609bd31a83cbe86 ; column++ )
    {
        var_b6d08687b3f9eb89 = 0;
        
        for ( row = 0; row < var_c8aa3700cdf30ff5.size ; row++ )
        {
            tablecell = var_c8aa3700cdf30ff5[ row ][ column ];
            var_b6d08687b3f9eb89 = max( var_b6d08687b3f9eb89, tablecell.size );
        }
        
        for ( row = 0; row < var_c8aa3700cdf30ff5.size ; row++ )
        {
            tablecell = var_c8aa3700cdf30ff5[ row ][ column ];
            var_9b1ecef0e69807cf = var_b6d08687b3f9eb89 - tablecell.size;
            padding = "";
            
            for ( i = 0; i < var_9b1ecef0e69807cf ; i++ )
            {
                padding += " ";
            }
            
            var_f6d49118d999070b[ row ][ column ] = tablecell + padding;
        }
    }
    
    var_f6d49118d999070b = array_insert( var_f6d49118d999070b, [ tabletitle ], 0 );
    return var_f6d49118d999070b;
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 8
// Checksum 0x0, Offset: 0x6cf
// Size: 0x178
function function_b1ea22d278623807( var_2b465f51da1e8fcf, var_2b465e51da1e8d9c, tabletitle, var_cd8110645a9a2632, var_871bdbc7e5abb341, textcolor, textscale, var_594f5bfc88a91bd3 )
{
    tabledata = function_83c890a0c71ae6b8( tabletitle, var_cd8110645a9a2632, var_871bdbc7e5abb341 );
    
    if ( !isdefined( textscale ) )
    {
        textscale = 1;
    }
    
    if ( !isdefined( var_594f5bfc88a91bd3 ) )
    {
        var_594f5bfc88a91bd3 = 1;
    }
    
    var_be90131b8f3ba968 = textscale * 16;
    var_1d5dc6edc3ab5ad7 = textscale * 8;
    tableheight = 0;
    tablewidth = 0;
    columnspacing = 2;
    
    foreach ( row in tabledata )
    {
        var_d14d9c622b832290 = 0;
        
        foreach ( column in row )
        {
            /#
                printtoscreen2d( var_2b465f51da1e8fcf + var_d14d9c622b832290, var_2b465e51da1e8d9c + tableheight, column, textcolor, textscale, var_594f5bfc88a91bd3 );
            #/
            
            var_d14d9c622b832290 += ( column.size + columnspacing ) * var_1d5dc6edc3ab5ad7;
        }
        
        tablewidth = var_d14d9c622b832290;
        tableheight += var_be90131b8f3ba968;
    }
    
    return ( tablewidth, tableheight, 0 );
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 1
// Checksum 0x0, Offset: 0x850
// Size: 0x2d, Type: bool
function function_a979150c62ac773f( aabb )
{
    return isdefined( aabb ) && isdefined( aabb.midpoint ) && isdefined( aabb.halfsize );
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 1
// Checksum 0x0, Offset: 0x886
// Size: 0x2d, Type: bool
function function_c5afd219db7bf9ab( zoneinfo )
{
    return isdefined( zoneinfo ) && isdefined( zoneinfo.zoneindex ) && isdefined( zoneinfo.var_5c70e52b4313bfbb );
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 2
// Checksum 0x0, Offset: 0x8bc
// Size: 0x96
function function_eef1c9b05cde1be9( point, gridsize )
{
    assert( isdefined( point ) );
    assert( isdefined( gridsize ) && gridsize[ 0 ] > 0 && gridsize[ 1 ] > 0 && gridsize[ 2 ] > 0 );
    return [ int( floor( point[ 0 ] / gridsize[ 0 ] ) ), int( floor( point[ 1 ] / gridsize[ 1 ] ) ), int( floor( point[ 2 ] / gridsize[ 2 ] ) ) ];
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 2
// Checksum 0x0, Offset: 0x95b
// Size: 0xd3
function function_be6410fcaddbfd68( aabb, gridsize )
{
    assert( function_a979150c62ac773f( aabb ) );
    assert( isdefined( gridsize ) && gridsize[ 0 ] > 0 && gridsize[ 1 ] > 0 && gridsize[ 2 ] > 0 );
    aabbmins = aabb.midpoint - aabb.halfsize;
    aabbmaxs = aabb.midpoint + aabb.halfsize;
    gridbounds = spawnstruct();
    gridbounds.mins = function_eef1c9b05cde1be9( aabbmins, gridsize );
    gridbounds.maxs = function_eef1c9b05cde1be9( aabbmaxs, gridsize );
    return gridbounds;
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 3
// Checksum 0x0, Offset: 0xa37
// Size: 0x62
function function_ead0cae04e11c5b4( zoneindex, var_40831e7ff4f9f3af, gridsize )
{
    assert( isdefined( zoneindex ) );
    assert( isdefined( var_40831e7ff4f9f3af ) );
    assert( isdefined( gridsize ) );
    aabb = getaabbforlootzone( zoneindex, var_40831e7ff4f9f3af );
    assert( isdefined( aabb ) );
    return function_be6410fcaddbfd68( aabb, gridsize );
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 3
// Checksum 0x0, Offset: 0xaa2
// Size: 0x41
function function_8c7a47a2aaa5555f( gridx, gridy, gridz )
{
    return "x:" + int( gridx ) + "y:" + int( gridy ) + "z:" + int( gridz );
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 2
// Checksum 0x0, Offset: 0xaec
// Size: 0x55
function function_84be7f6972492286( zoneindex, var_5c70e52b4313bfbb )
{
    assert( isdefined( zoneindex ) );
    zoneinfo = spawnstruct();
    zoneinfo.zoneindex = zoneindex;
    zoneinfo.var_5c70e52b4313bfbb = default_to( var_5c70e52b4313bfbb, 0.1 );
    return zoneinfo;
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 1
// Checksum 0x0, Offset: 0xb4a
// Size: 0x35
function function_7c9a0e119163a6b0( gridsize )
{
    assert( isdefined( gridsize ) );
    var_21e742c4e7cb787c = spawnstruct();
    var_21e742c4e7cb787c.gridsize = gridsize;
    return var_21e742c4e7cb787c;
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 2
// Checksum 0x0, Offset: 0xb88
// Size: 0x184
function function_3a7f59bb4e72a37( var_21e742c4e7cb787c, zoneinfo )
{
    assert( isdefined( var_21e742c4e7cb787c ) );
    assert( function_c5afd219db7bf9ab( zoneinfo ) );
    var_40831e7ff4f9f3af = ( zoneinfo.var_5c70e52b4313bfbb, zoneinfo.var_5c70e52b4313bfbb, zoneinfo.var_5c70e52b4313bfbb );
    gridbounds = function_ead0cae04e11c5b4( zoneinfo.zoneindex, var_40831e7ff4f9f3af, var_21e742c4e7cb787c.gridsize );
    
    if ( !isdefined( var_21e742c4e7cb787c.gridmap ) )
    {
        var_21e742c4e7cb787c.gridmap = [];
    }
    
    for ( gridx = gridbounds.mins[ 0 ]; gridx <= gridbounds.maxs[ 0 ] ; gridx++ )
    {
        for ( gridy = gridbounds.mins[ 1 ]; gridy <= gridbounds.maxs[ 1 ] ; gridy++ )
        {
            for ( gridz = gridbounds.mins[ 2 ]; gridz <= gridbounds.maxs[ 2 ] ; gridz++ )
            {
                var_e60651194b75b010 = function_8c7a47a2aaa5555f( gridx, gridy, gridz );
                
                if ( !isdefined( var_21e742c4e7cb787c.gridmap[ var_e60651194b75b010 ] ) )
                {
                    var_21e742c4e7cb787c.gridmap[ var_e60651194b75b010 ] = [];
                }
                
                var_21e742c4e7cb787c.gridmap[ var_e60651194b75b010 ][ var_21e742c4e7cb787c.gridmap[ var_e60651194b75b010 ].size ] = zoneinfo;
            }
        }
    }
}

// Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
// Params 2
// Checksum 0x0, Offset: 0xd14
// Size: 0x13d
function function_38e17064167fd68( var_21e742c4e7cb787c, point )
{
    assert( isdefined( var_21e742c4e7cb787c ) && isdefined( var_21e742c4e7cb787c.gridsize ) );
    assert( isdefined( point ) );
    var_b322b4fce7d30aaf = function_eef1c9b05cde1be9( point, var_21e742c4e7cb787c.gridsize );
    var_e60651194b75b010 = function_8c7a47a2aaa5555f( var_b322b4fce7d30aaf[ 0 ], var_b322b4fce7d30aaf[ 1 ], var_b322b4fce7d30aaf[ 2 ] );
    var_f85646b72485b227 = [];
    
    if ( isdefined( var_21e742c4e7cb787c.gridmap ) && isdefined( var_21e742c4e7cb787c.gridmap[ var_e60651194b75b010 ] ) )
    {
        foreach ( zoneinfo in var_21e742c4e7cb787c.gridmap[ var_e60651194b75b010 ] )
        {
            assert( function_c5afd219db7bf9ab( zoneinfo ) );
            distsq = getpointtozoneboundsdistsq( zoneinfo.zoneindex, point );
            
            if ( isdefined( distsq ) && distsq <= squared( zoneinfo.var_5c70e52b4313bfbb ) )
            {
                var_f85646b72485b227[ var_f85646b72485b227.size ] = zoneinfo;
            }
        }
    }
    
    return var_f85646b72485b227;
}

/#

    // Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
    // Params 3
    // Checksum 0x0, Offset: 0xe5a
    // Size: 0x15b, Type: dev
    function function_b99cf97184d37880( var_21e742c4e7cb787c, drawtimeseconds, color )
    {
        assert( isdefined( var_21e742c4e7cb787c ) && isdefined( var_21e742c4e7cb787c.gridsize ) );
        
        if ( isdefined( var_21e742c4e7cb787c.gridmap ) )
        {
            var_ca50c2942e5002b6 = [];
            
            foreach ( var_f85646b72485b227 in var_21e742c4e7cb787c.gridmap )
            {
                foreach ( zoneinfo in var_f85646b72485b227 )
                {
                    if ( !function_c5afd219db7bf9ab( zoneinfo ) || istrue( var_ca50c2942e5002b6[ zoneinfo.zoneindex ] ) )
                    {
                        continue;
                    }
                    
                    zoneindex = zoneinfo.zoneindex;
                    padding = ( zoneinfo.var_5c70e52b4313bfbb, zoneinfo.var_5c70e52b4313bfbb, zoneinfo.var_5c70e52b4313bfbb );
                    level thread function_604f2ab87704e620( zoneindex, padding, drawtimeseconds, color );
                    var_ca50c2942e5002b6[ zoneindex ] = 1;
                }
            }
        }
    }

    // Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
    // Params 4
    // Checksum 0x0, Offset: 0xfbd
    // Size: 0x7a, Type: dev
    function function_604f2ab87704e620( zoneindex, padding, drawtimeseconds, color )
    {
        assert( isdefined( zoneindex ) && isdefined( padding ) );
        aabb = getaabbforlootzone( zoneindex, padding );
        assert( function_a979150c62ac773f( aabb ) );
        thread scripts\cp_mp\utility\debug_utility::function_7111207db5db2175( aabb.midpoint, aabb.halfsize, drawtimeseconds, color );
    }

    // Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x103f
    // Size: 0x1a, Type: dev
    function private function_225667c119b5512d()
    {
        function_fb61b372bc6cca0f();
        function_4641ac23689d9d78();
        function_d8713152a1bd24b();
    }

    // Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1061
    // Size: 0x1da, Type: dev
    function private function_fb61b372bc6cca0f()
    {
        title = "<dev string:x67>";
        header = [ "<dev string:xab>", "<dev string:xb0>", "<dev string:xb4>", "<dev string:xca>" ];
        tabledata = [ [], [ "<dev string:xd3>", 2, 3.5, undefined ], [ 1, 2, 3, 4, 5 ] ];
        actualoutput = function_83c890a0c71ae6b8( title, header, tabledata );
        var_567a66b58f939a3c = [ [ "<dev string:x67>" ], [ "<dev string:xe3>", "<dev string:xf6>", "<dev string:xb4>", "<dev string:x109>" ], [ "<dev string:x11c>", "<dev string:x11c>", "<dev string:x12f>", "<dev string:x11c>" ], [ "<dev string:x145>", "<dev string:x158>", "<dev string:x16b>", "<dev string:x181>" ], [ "<dev string:x194>", "<dev string:x158>", "<dev string:x1a7>", "<dev string:x1bd>" ] ];
        asserteq( var_567a66b58f939a3c.size, actualoutput.size );
        
        for ( r = 0; r < var_567a66b58f939a3c.size ; r++ )
        {
            var_581b9588b345f4e3 = var_567a66b58f939a3c[ r ];
            actualrow = actualoutput[ r ];
            asserteq( var_581b9588b345f4e3.size, actualrow.size );
            
            for ( c = 0; c < var_581b9588b345f4e3.size ; c++ )
            {
                asserteq( var_581b9588b345f4e3[ c ], actualrow[ c ] );
            }
        }
    }

    // Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x1243
    // Size: 0x231, Type: dev
    function private function_4641ac23689d9d78()
    {
        asserteq( formatstring( "<dev string:xb0>" ), "<dev string:xb0>" );
        asserteq( formatstring( "<dev string:x1d0>" ), "<dev string:x1d0>" );
        asserteq( formatstring( "<dev string:x1d7>" ), "<dev string:x1d7>" );
        asserteq( formatstring( "<dev string:x1df>" ), "<dev string:x1df>" );
        asserteq( formatstring( "<dev string:x1e8>", 1 ), "<dev string:x1ee>" );
        asserteq( formatstring( "<dev string:x1e8>", 1.5 ), "<dev string:x1f3>" );
        asserteq( formatstring( "<dev string:x1e8>", "<dev string:x1fa>" ), "<dev string:x1fa>" );
        asserteq( formatstring( "<dev string:x1e8>", undefined ), "<dev string:x201>" );
        asserteq( formatstring( "<dev string:x210>", 1 ), "<dev string:x217>" );
        asserteq( formatstring( "<dev string:x21d>", 1 ), "<dev string:x224>" );
        asserteq( formatstring( "<dev string:x22a>", 1 ), "<dev string:x232>" );
        asserteq( formatstring( "<dev string:x1e8>", 1, 2 ), "<dev string:x1ee>" );
        asserteq( formatstring( "<dev string:x239>", 1 ), "<dev string:x242>" );
        asserteq( formatstring( "<dev string:x24a>", 1, 2 ), "<dev string:x252>" );
        asserteq( formatstring( "<dev string:x258>", 1, 2 ), "<dev string:x261>" );
        asserteq( formatstring( "<dev string:x268>", 1, 2 ), "<dev string:x272>" );
        asserteq( formatstring( "<dev string:x27a>", 1, 2 ), "<dev string:x285>" );
        asserteq( formatstring( "<dev string:x28e>", 1, 2, 3, 4, 5, 6, 7, 8 ), "<dev string:x2a2>" );
        asserteq( formatstring( "<dev string:x1e8>" ), "<dev string:x201>" );
        asserteq( formatstring( "<dev string:x2ae>", 1, 2 ), "<dev string:x2bb>" );
        asserteq( formatstring( "<dev string:x2cf>", 1, 2, 3, 4, 5, 6 ), "<dev string:x2e5>" );
    }

    // Namespace namespace_98c7b65bbafed54d / namespace_36be7f9eab6ca7bc
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x147c
    // Size: 0xc3, Type: dev
    function private function_d8713152a1bd24b()
    {
        coords = function_eef1c9b05cde1be9( ( 0, 0, 0 ), ( 1, 1, 1 ) );
        function_47c544bb1ff442c1( coords, ( 0, 0, 0 ), 0.1 );
        coords = function_eef1c9b05cde1be9( ( 123, 456, 789 ), ( 1, 1, 1 ) );
        function_47c544bb1ff442c1( coords, ( 123, 456, 789 ), 0.1 );
        coords = function_eef1c9b05cde1be9( ( -10, -2, 5 ), ( 4, 2, 5 ) );
        function_47c544bb1ff442c1( coords, ( -3, -1, 1 ), 0.1 );
    }

#/
