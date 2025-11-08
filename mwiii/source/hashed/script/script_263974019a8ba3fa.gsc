#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;

#namespace exclusion_zones;

// Namespace exclusion_zones / namespace_1ebea70fc689e6c
// Params 5
// Checksum 0x0, Offset: 0x98
// Size: 0xe7
function function_39e1cd8a0fce827a( position, dimensions, rot, shape, inverted )
{
    if ( isdefined( level.br_multi_circle ) && level.br_multi_circle.circlecount > 1 )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    if ( !isdefined( shape ) )
    {
        shape = 2;
    }
    
    if ( !isdefined( rot ) )
    {
        rot = ( 0, 0, 0 );
    }
    
    if ( !isdefined( inverted ) )
    {
        inverted = 0;
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( !isdefined( level.exclusionzones ) || !isdefined( level.exclusionzones[ i ] ) )
        {
            level.exclusionzones[ i ] = function_7d635301465bbed1( position, dimensions, rot, shape, inverted );
            return i;
        }
    }
    
    assertmsg( "<dev string:x59>" + 3 );
}

// Namespace exclusion_zones / namespace_1ebea70fc689e6c
// Params 3
// Checksum 0x0, Offset: 0x187
// Size: 0xa6
function function_de57b9616f575a63( position, var_72759fb8bd38aa1e, var_584ecd81b5529ed2 )
{
    if ( !isvector( position ) )
    {
        assertmsg( "<dev string:x8d>" + position );
    }
    
    if ( !isdefined( level.exclusionzones ) )
    {
        return -1;
    }
    
    if ( !isdefined( var_584ecd81b5529ed2 ) )
    {
        var_584ecd81b5529ed2 = 0;
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        if ( isdefined( level.exclusionzones[ i ] ) && var_584ecd81b5529ed2 == function_704a7fe0058bba45( level.exclusionzones[ i ] ) )
        {
            if ( level.exclusionzones[ i ] function_91bf6ad362e62084( position, var_72759fb8bd38aa1e, var_584ecd81b5529ed2 ) )
            {
                return i;
            }
        }
    }
    
    return -1;
}

// Namespace exclusion_zones / namespace_1ebea70fc689e6c
// Params 3
// Checksum 0x0, Offset: 0x236
// Size: 0x5c
function function_91bf6ad362e62084( position, var_72759fb8bd38aa1e, var_584ecd81b5529ed2 )
{
    if ( !isvector( position ) )
    {
        assertmsg( "<dev string:x8d>" + position );
    }
    
    var_d315d8a84c73470 = function_92b7f40b735f689f( self, position );
    return istrue( var_72759fb8bd38aa1e ) ? var_d315d8a84c73470 && function_24c5a8d31ae262f( position ) : var_d315d8a84c73470;
}

// Namespace exclusion_zones / namespace_1ebea70fc689e6c
// Params 1
// Checksum 0x0, Offset: 0x29b
// Size: 0x49
function function_781b540fbee7109a( zone )
{
    assert( isdefined( level.exclusionzones ) );
    assert( isdefined( zone ) );
    level.exclusionzones = utility::array_remove( level.exclusionzones, zone );
    zone delete();
}

// Namespace exclusion_zones / namespace_1ebea70fc689e6c
// Params 2
// Checksum 0x0, Offset: 0x2ec
// Size: 0x5a
function function_7f267ef8e2210d1d( var_de595808b3e6a948, duration )
{
    assert( isdefined( self ) );
    
    if ( duration == 0 )
    {
        self function_7b19792f59d0889d( self.origin, var_de595808b3e6a948, self.angles );
        return;
    }
    
    assertex( duration >= 0, "<dev string:xab>" );
    thread function_a4b442ebe4020bb( var_de595808b3e6a948, duration );
}

// Namespace exclusion_zones / namespace_1ebea70fc689e6c
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x34e
// Size: 0x7c
function private function_a4b442ebe4020bb( var_5f6228d3e1d47c7f, duration )
{
    starttime = gettime();
    duration *= 1000;
    var_8007d36a029de440 = self getgasexclusionzonedimensions();
    
    while ( isdefined( self ) && gettime() < starttime + duration )
    {
        var_de595808b3e6a948 = vectorlerp( var_8007d36a029de440, var_5f6228d3e1d47c7f, ( gettime() - starttime ) / duration );
        self function_7b19792f59d0889d( self.origin, var_de595808b3e6a948 );
        waitframe();
    }
}

// Namespace exclusion_zones / namespace_1ebea70fc689e6c
// Params 3
// Checksum 0x0, Offset: 0x3d2
// Size: 0x59
function function_ca194605b904c777( var_de595808b3e6a948, rate, linear )
{
    assert( isdefined( self ) );
    assertex( isdefined( rate ), "<dev string:xf0>" );
    
    if ( rate == 0 )
    {
        self function_7b19792f59d0889d( self.origin, var_de595808b3e6a948 );
        return;
    }
    
    thread function_a4547a6f54ebab99( var_de595808b3e6a948, rate, linear );
}

// Namespace exclusion_zones / namespace_1ebea70fc689e6c
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x433
// Size: 0x144
function private function_a4547a6f54ebab99( var_5f6228d3e1d47c7f, rate, linear )
{
    var_8007d36a029de440 = self getgasexclusionzonedimensions();
    var_de595808b3e6a948 = var_8007d36a029de440;
    var_e046a46d224708ed = ( var_5f6228d3e1d47c7f - var_de595808b3e6a948 ) * rate;
    initialsign = vectorsign( var_5f6228d3e1d47c7f - var_de595808b3e6a948 );
    
    while ( isdefined( self ) && !is_equal( var_8007d36a029de440, var_5f6228d3e1d47c7f ) )
    {
        if ( !linear )
        {
            var_de595808b3e6a948 += ( var_5f6228d3e1d47c7f - var_de595808b3e6a948 ) * rate;
            
            for ( i = 0; i < 3 ; i++ )
            {
                if ( abs( var_5f6228d3e1d47c7f[ i ] - var_de595808b3e6a948[ i ] ) < abs( var_e046a46d224708ed[ i ] ) )
                {
                    var_de595808b3e6a948 = var_5f6228d3e1d47c7f;
                }
            }
        }
        else
        {
            var_de595808b3e6a948 += rate;
        }
        
        for ( i = 0; i < 3 ; i++ )
        {
            if ( sign( var_5f6228d3e1d47c7f[ i ] - var_de595808b3e6a948[ i ] ) != initialsign[ i ] )
            {
                self function_7b19792f59d0889d( self.origin, var_5f6228d3e1d47c7f, self.angles, level.framedurationseconds );
                return;
            }
        }
        
        self function_7b19792f59d0889d( self.origin, var_de595808b3e6a948, self.angles, level.framedurationseconds );
        wait level.framedurationseconds;
        
        if ( isdefined( self ) )
        {
            var_8007d36a029de440 = self getgasexclusionzonedimensions();
        }
    }
}

/#

    // Namespace exclusion_zones / namespace_1ebea70fc689e6c
    // Params 0
    // Checksum 0x0, Offset: 0x57f
    // Size: 0x5, Type: dev
    function function_b1eab7c7fda1fb57()
    {
        
    }

    // Namespace exclusion_zones / namespace_1ebea70fc689e6c
    // Params 0
    // Checksum 0x0, Offset: 0x58c
    // Size: 0x5a, Type: dev
    function function_14767b88f55e26e0()
    {
        foreach ( zone in level.exclusionzones )
        {
            function_781b540fbee7109a( zone );
            return;
        }
    }

    // Namespace exclusion_zones / namespace_1ebea70fc689e6c
    // Params 1
    // Checksum 0x0, Offset: 0x5ee
    // Size: 0x16, Type: dev
    function function_7176642fe2ed10cd( var_72759fb8bd38aa1e )
    {
        in_exclusion_zone( var_72759fb8bd38aa1e );
    }

    // Namespace exclusion_zones / namespace_1ebea70fc689e6c
    // Params 0
    // Checksum 0x0, Offset: 0x60c
    // Size: 0xc6, Type: dev
    function function_afa41ee45eb3172f()
    {
        position = ( 4000, 0, 0 );
        dimensions = ( 50000, 5000, 10000 );
        rot = ( 0, 45, 0 );
        shape = 1;
        function_39e1cd8a0fce827a( position, dimensions, rot, 2, 1 );
        dimensions = ( 3000, 3000, 2000 );
        position = ( 700, -5500, 0 );
        function_39e1cd8a0fce827a( position, dimensions, rot, 2, 1 );
        position = ( 10000, -7000, 0 );
        dimensions = ( 5000, 5000, 1500 );
        function_39e1cd8a0fce827a( position, dimensions, rot, shape );
        level.var_ec780726787e2557 = 1;
    }

    // Namespace exclusion_zones / namespace_1ebea70fc689e6c
    // Params 1
    // Checksum 0x0, Offset: 0x6da
    // Size: 0xda, Type: dev
    function in_exclusion_zone( var_72759fb8bd38aa1e )
    {
        if ( !isdefined( level.exclusionzones ) )
        {
            iprintlnbold( "<dev string:x12e>" );
            return;
        }
        
        position = level.players[ 0 ].origin;
        string = "<dev string:x144>";
        
        for ( i = 0; i < 3 ; i++ )
        {
            if ( isdefined( level.exclusionzones[ i ] ) )
            {
                string = string + i + "<dev string:x15d>" + ( level.exclusionzones[ i ] function_91bf6ad362e62084( position, var_72759fb8bd38aa1e ) ? "<dev string:x163>" : "<dev string:x16e>" );
            }
        }
        
        string = string + "<dev string:x17a>" + function_de57b9616f575a63( position, var_72759fb8bd38aa1e );
        string = string + "<dev string:x18a>" + function_de57b9616f575a63( position, var_72759fb8bd38aa1e, 1 );
        iprintlnbold( string );
    }

    // Namespace exclusion_zones / namespace_1ebea70fc689e6c
    // Params 0
    // Checksum 0x0, Offset: 0x7bc
    // Size: 0x19a, Type: dev
    function lerp_exclusion_zone()
    {
        if ( istrue( level.var_ec780726787e2557 ) )
        {
            position = ( 4000, 0, 3000 );
            dimensions = ( 10000, 10000, 4000 );
            rot = ( 0, 0, 0 );
            level.exclusionzones[ 0 ] function_7b19792f59d0889d( position, dimensions, rot, 30 );
            position = ( 5000, 0, 2500 );
            dimensions = ( 4000, 50000, 1000 );
            level.exclusionzones[ 1 ] function_7b19792f59d0889d( position, dimensions, rot, 10 );
            position = ( -5000, 0, 1500 );
            dimensions = ( 1500, 50000, 1000 );
            level.exclusionzones[ 2 ] function_7b19792f59d0889d( position );
            level.var_ec780726787e2557 = 0;
            return;
        }
        
        position = ( 4000, 0, 3000 );
        dimensions = ( 10000, 10000, 4000 );
        rot = ( 0, 0, 0 );
        level.exclusionzones[ 0 ] function_7b19792f59d0889d( position, dimensions, rot, 30 );
        dimensions = ( 1000, 6000, 4000 );
        position = ( 5000, 0, 1500 );
        level.exclusionzones[ 1 ] function_7b19792f59d0889d( position, dimensions, rot, 10 );
        position = ( -2667, -5561, 1500 );
        dimensions = ( 4000, 4000, 4000 );
        level.exclusionzones[ 2 ] function_7b19792f59d0889d( position, dimensions, rot, 15 );
        level.var_ec780726787e2557 = 1;
    }

#/
