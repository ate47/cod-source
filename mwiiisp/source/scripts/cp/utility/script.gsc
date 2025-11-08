#using scripts\common\utility;
#using scripts\engine\utility;

#namespace script;

// Namespace script / scripts\cp\utility\script
// Params 1
// Checksum 0x0, Offset: 0x14c
// Size: 0xa1
function waittillslowprocessallowed( allowloop )
{
    if ( level.lastslowprocessframe == gettime() )
    {
        if ( isdefined( allowloop ) && allowloop )
        {
            while ( level.lastslowprocessframe == gettime() )
            {
                wait 0.05;
            }
        }
        else
        {
            wait 0.05;
            
            if ( level.lastslowprocessframe == gettime() )
            {
                wait 0.05;
                
                if ( level.lastslowprocessframe == gettime() )
                {
                    wait 0.05;
                    
                    if ( level.lastslowprocessframe == gettime() )
                    {
                        wait 0.05;
                    }
                }
            }
        }
    }
    
    level.lastslowprocessframe = gettime();
}

// Namespace script / scripts\cp\utility\script
// Params 1
// Checksum 0x0, Offset: 0x1f5
// Size: 0x45
function queuecreate( queuename )
{
    if ( !isdefined( level.queues ) )
    {
        level.queues = [];
    }
    
    assert( !isdefined( level.queues[ queuename ] ) );
    level.queues[ queuename ] = [];
}

// Namespace script / scripts\cp\utility\script
// Params 2
// Checksum 0x0, Offset: 0x242
// Size: 0x42
function queueadd( queuename, entity )
{
    assert( isdefined( level.queues[ queuename ] ) );
    level.queues[ queuename ][ level.queues[ queuename ].size ] = entity;
}

// Namespace script / scripts\cp\utility\script
// Params 1
// Checksum 0x0, Offset: 0x28c
// Size: 0xaa
function queueremovefirst( queuename )
{
    assert( isdefined( level.queues[ queuename ] ) );
    first = undefined;
    newqueue = [];
    
    foreach ( element in level.queues[ queuename ] )
    {
        if ( !isdefined( element ) )
        {
            continue;
        }
        
        if ( !isdefined( first ) )
        {
            first = element;
            continue;
        }
        
        newqueue[ newqueue.size ] = element;
    }
    
    level.queues[ queuename ] = newqueue;
    return first;
}

// Namespace script / scripts\cp\utility\script
// Params 2
// Checksum 0x0, Offset: 0x33f
// Size: 0x21
function quicksort( array, compare_func )
{
    return quicksortmid( array, 0, array.size - 1, compare_func );
}

// Namespace script / scripts\cp\utility\script
// Params 4
// Checksum 0x0, Offset: 0x369
// Size: 0xea
function quicksortmid( array, start, end, compare_func )
{
    i = start;
    k = end;
    
    if ( !isdefined( compare_func ) )
    {
        compare_func = &quicksort_compare;
    }
    
    if ( end - start >= 1 )
    {
        pivot = array[ start ];
        
        while ( k > i )
        {
            while ( [[ compare_func ]]( array[ i ], pivot ) && i <= end && k > i )
            {
                i++;
            }
            
            while ( ![[ compare_func ]]( array[ k ], pivot ) && k >= start && k >= i )
            {
                k--;
            }
            
            if ( k > i )
            {
                array = swap( array, i, k );
            }
        }
        
        array = swap( array, start, k );
        array = quicksortmid( array, start, k - 1, compare_func );
        array = quicksortmid( array, k + 1, end, compare_func );
    }
    else
    {
        return array;
    }
    
    return array;
}

// Namespace script / scripts\cp\utility\script
// Params 2
// Checksum 0x0, Offset: 0x45c
// Size: 0x16, Type: bool
function quicksort_compare( left, right )
{
    return left <= right;
}

// Namespace script / scripts\cp\utility\script
// Params 3
// Checksum 0x0, Offset: 0x47b
// Size: 0x36
function swap( array, index1, index2 )
{
    temp = array[ index1 ];
    array[ index1 ] = array[ index2 ];
    array[ index2 ] = temp;
    return array;
}

// Namespace script / scripts\cp\utility\script
// Params 2
// Checksum 0x0, Offset: 0x4ba
// Size: 0x5a
function limitdecimalplaces( value, places )
{
    modifier = 1;
    
    for ( i = 0; i < places ; i++ )
    {
        modifier *= 10;
    }
    
    newvalue = value * modifier;
    newvalue = int( newvalue );
    newvalue /= modifier;
    return newvalue;
}

// Namespace script / scripts\cp\utility\script
// Params 3
// Checksum 0x0, Offset: 0x51d
// Size: 0xab
function rounddecimalplaces( value, places, style )
{
    if ( !isdefined( style ) )
    {
        style = "nearest";
    }
    
    modifier = 1;
    
    for ( i = 0; i < places ; i++ )
    {
        modifier *= 10;
    }
    
    newvalue = value * modifier;
    
    if ( style == "up" )
    {
        var_ce526f59e2a5ad3f = ceil( newvalue );
    }
    else if ( style == "down" )
    {
        var_ce526f59e2a5ad3f = floor( newvalue );
    }
    else
    {
        var_ce526f59e2a5ad3f = newvalue + 0.5;
    }
    
    newvalue = int( var_ce526f59e2a5ad3f );
    newvalue /= modifier;
    return newvalue;
}

// Namespace script / scripts\cp\utility\script
// Params 1
// Checksum 0x0, Offset: 0x5d1
// Size: 0x7e
function stringtofloat( stringval )
{
    floatelements = strtok( stringval, "." );
    floatval = int( floatelements[ 0 ] );
    
    if ( isdefined( floatelements[ 1 ] ) )
    {
        modifier = 1;
        
        for ( i = 0; i < floatelements[ 1 ].size ; i++ )
        {
            modifier *= 0.1;
        }
        
        floatval += int( floatelements[ 1 ] ) * modifier;
    }
    
    return floatval;
}

// Namespace script / scripts\cp\utility\script
// Params 2
// Checksum 0x0, Offset: 0x658
// Size: 0x1e, Type: bool
function isstrstart( string, substr )
{
    return getsubstr( string, 0, substr.size ) == substr;
}

// Namespace script / scripts\cp\utility\script
// Params 2
// Checksum 0x0, Offset: 0x67f
// Size: 0x6c
function array_remove_keep_index( ents, remover )
{
    newents = [];
    
    foreach ( ent in ents )
    {
        if ( ent != remover )
        {
            newents[ index ] = ent;
        }
    }
    
    return newents;
}

// Namespace script / scripts\cp\utility\script
// Params 1
// Checksum 0x0, Offset: 0x6f4
// Size: 0x20
function delayentdelete( time )
{
    self endon( "death" );
    wait time;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace script / scripts\cp\utility\script
// Params 1
// Checksum 0x0, Offset: 0x71c
// Size: 0x30
function roundup( floatvalue )
{
    if ( floatvalue - int( floatvalue ) >= 0.5 )
    {
        return int( floatvalue + 1 );
    }
    
    return int( floatvalue );
}

// Namespace script / scripts\cp\utility\script
// Params 9
// Checksum 0x0, Offset: 0x754
// Size: 0x5f
function bufferednotify( notification, param1, param2, param3, param4, param5, param6, param7, param8 )
{
    thread bufferednotify_internal( notification, param1, param2, param3, param4, param5, param6, param7, param8 );
}

// Namespace script / scripts\cp\utility\script
// Params 9
// Checksum 0x0, Offset: 0x7bb
// Size: 0x1e4
function bufferednotify_internal( notification, param1, param2, param3, param4, param5, param6, param7, param8 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    uniqueendonnotify = "bufferedNotify_" + notification;
    self notify( uniqueendonnotify );
    self endon( uniqueendonnotify );
    
    if ( !isdefined( self.bufferednotifications ) )
    {
        self.bufferednotifications = [];
    }
    
    if ( !isdefined( self.bufferednotifications[ notification ] ) )
    {
        self.bufferednotifications[ notification ] = [];
    }
    
    parameters = spawnstruct();
    parameters.param1 = param1;
    parameters.param2 = param2;
    parameters.param3 = param3;
    parameters.param4 = param4;
    parameters.param5 = param5;
    parameters.param6 = param6;
    parameters.param7 = param7;
    parameters.param8 = param8;
    self.bufferednotifications[ notification ][ self.bufferednotifications[ notification ].size ] = parameters;
    waittillframeend();
    
    while ( self.bufferednotifications[ notification ].size > 0 )
    {
        parameters = self.bufferednotifications[ notification ][ 0 ];
        self notify( notification, parameters.param1, parameters.param2, parameters.param3, parameters.param4, parameters.param5, parameters.param6, parameters.param7, parameters.param8 );
        self.bufferednotifications[ notification ] = array_remove_index( self.bufferednotifications[ notification ], 0 );
        waitframe();
    }
}

// Namespace script / scripts\cp\utility\script
// Params 2
// Checksum 0x0, Offset: 0x9a7
// Size: 0x3c
function notifyafterframeend( waittillmsg, var_7239f8830ef22b43 )
{
    assertex( isdefined( waittillmsg ), "notifyAfterFrameEnd() was not given a notify to wait on" );
    assertex( isdefined( var_7239f8830ef22b43 ), "notifyAfterFrameEnd() was not given a notify to send" );
    self waittill( waittillmsg );
    waittillframeend();
    self notify( var_7239f8830ef22b43 );
}

// Namespace script / scripts\cp\utility\script
// Params 3
// Checksum 0x0, Offset: 0x9eb
// Size: 0x2d
function delaysetclientomnvar( delaytime, omnvar, value )
{
    self endon( "disconnect" );
    wait delaytime;
    self setclientomnvar( omnvar, value );
}

// Namespace script / scripts\cp\utility\script
// Params 2
// Checksum 0x0, Offset: 0xa20
// Size: 0x3d
function strip_suffix( lookupstring, stripstring )
{
    if ( lookupstring.size <= stripstring.size )
    {
        return lookupstring;
    }
    
    if ( getsubstr( lookupstring, lookupstring.size - stripstring.size, lookupstring.size ) == stripstring )
    {
        return getsubstr( lookupstring, 0, lookupstring.size - stripstring.size );
    }
    
    return lookupstring;
}

// Namespace script / scripts\cp\utility\script
// Params 2
// Checksum 0x0, Offset: 0xa66
// Size: 0x42
function vectortoanglessafe( forward, up )
{
    right = vectorcross( forward, up );
    up = vectorcross( right, forward );
    angles = axistoangles( forward, right, up );
    return angles;
}

// Namespace script / scripts\cp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xab1
// Size: 0x8f
function heap( type )
{
    assertex( type == "max" || type == "min", "Heap type must be 'max' or 'min'" );
    h = spawnstruct();
    h.nvals = 0;
    h.vals = [];
    
    if ( type == "max" )
    {
        h.swap = &_heaplessthan;
    }
    else if ( type == "min" )
    {
        h.swap = &_heapgreaterthan;
    }
    
    return h;
}

// Namespace script / scripts\cp\utility\script
// Params 0
// Checksum 0x0, Offset: 0xb49
// Size: 0xb
function heapsize()
{
    return self.nvals;
}

// Namespace script / scripts\cp\utility\script
// Params 0
// Checksum 0x0, Offset: 0xb5d
// Size: 0xe
function heappeek()
{
    return self.vals[ 1 ];
}

// Namespace script / scripts\cp\utility\script
// Params 0
// Checksum 0x0, Offset: 0xb74
// Size: 0xb7
function heappop()
{
    if ( self.nvals == 0 )
    {
        return undefined;
    }
    
    if ( self.nvals == 1 )
    {
        val = self.vals[ 1 ];
        self.vals[ 1 ] = undefined;
        self.nvals = 0;
        return val;
    }
    
    val = self.vals[ 1 ];
    self.vals[ 1 ] = self.vals[ self.nvals ];
    self.vals[ self.nvals ] = undefined;
    _heapify( 1 );
    self.nvals -= 1;
    return val;
}

// Namespace script / scripts\cp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xc33
// Size: 0xc5
function heapinsert( val )
{
    self.vals[ self.nvals + 1 ] = val;
    i = self.nvals + 1;
    parent = _heapparent( i );
    
    while ( isdefined( parent ) )
    {
        if ( [[ self.swap ]]( parent, i ) )
        {
            temp = self.vals[ parent ];
            self.vals[ parent ] = self.vals[ i ];
            self.vals[ i ] = temp;
            i = parent;
            parent = _heapparent( i );
            continue;
        }
        
        break;
    }
    
    self.nvals += 1;
}

/#

    // Namespace script / scripts\cp\utility\script
    // Params 0
    // Checksum 0x0, Offset: 0xd00
    // Size: 0x96, Type: dev
    function printheap()
    {
        print( "<dev string:x1c>" );
        vals = [];
        size = self.nvals;
        
        for ( i = 0; i < size ; i++ )
        {
            vals[ i ] = heappop();
        }
        
        for ( i = 0; i < vals.size ; i++ )
        {
            heapinsert( vals[ i ] );
        }
        
        for ( i = 0; i < vals.size ; i++ )
        {
            print( vals[ i ] + "<dev string:x20>" );
        }
        
        print( "<dev string:x1c>" );
    }

#/

// Namespace script / scripts\cp\utility\script
// Params 2
// Checksum 0x0, Offset: 0xd9e
// Size: 0x2a, Type: bool
function _heapgreaterthan( i, j )
{
    return self.vals[ i ] > self.vals[ j ];
}

// Namespace script / scripts\cp\utility\script
// Params 2
// Checksum 0x0, Offset: 0xdd1
// Size: 0x2a, Type: bool
function _heaplessthan( i, j )
{
    return self.vals[ i ] < self.vals[ j ];
}

// Namespace script / scripts\cp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xe04
// Size: 0x10c
function _heapify( i )
{
    lc = _heapleftchild( i );
    rc = _heaprightchild( i );
    newidx = undefined;
    swapleft = 0;
    
    if ( isdefined( lc ) )
    {
        swapleft = self [[ self.swap ]]( i, lc );
    }
    
    swapright = 0;
    
    if ( isdefined( rc ) )
    {
        swapright = self [[ self.swap ]]( i, rc );
    }
    
    if ( !swapleft && !swapright )
    {
        return;
    }
    else if ( swapleft && !swapright )
    {
        newidx = lc;
    }
    else if ( !swapleft && swapright )
    {
        newidx = rc;
    }
    else if ( self [[ self.swap ]]( lc, rc ) )
    {
        newidx = rc;
    }
    else
    {
        newidx = lc;
    }
    
    temp = self.vals[ i ];
    self.vals[ i ] = self.vals[ newidx ];
    self.vals[ newidx ] = temp;
    _heapify( newidx );
}

// Namespace script / scripts\cp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xf18
// Size: 0x23
function _heapleftchild( i )
{
    if ( !isdefined( self.vals[ 2 * i ] ) )
    {
        return undefined;
    }
    
    return 2 * i;
}

// Namespace script / scripts\cp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xf44
// Size: 0x29
function _heaprightchild( i )
{
    if ( !isdefined( self.vals[ 2 * i + 1 ] ) )
    {
        return undefined;
    }
    
    return 2 * i + 1;
}

// Namespace script / scripts\cp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xf76
// Size: 0x22
function _heapparent( i )
{
    if ( i == 1 )
    {
        return undefined;
    }
    
    return int( floor( i / 2 ) );
}

// Namespace script / scripts\cp\utility\script
// Params 2
// Checksum 0x0, Offset: 0xfa1
// Size: 0x1f, Type: bool
function isnumbermultipleof( number, factor )
{
    return number > 0 && number % factor == 0;
}

