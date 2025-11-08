#using scripts\common\utility;
#using scripts\engine\utility;

#namespace script;

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0x11e
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

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0x1c7
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

// Namespace script / scripts\mp\utility\script
// Params 2
// Checksum 0x0, Offset: 0x214
// Size: 0x42
function queueadd( queuename, entity )
{
    assert( isdefined( level.queues[ queuename ] ) );
    level.queues[ queuename ][ level.queues[ queuename ].size ] = entity;
}

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0x25e
// Size: 0xab
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

// Namespace script / scripts\mp\utility\script
// Params 2
// Checksum 0x0, Offset: 0x312
// Size: 0x18a
function quicksort( array, compare_func )
{
    if ( !isdefined( compare_func ) )
    {
        compare_func = &default_compare;
    }
    
    l = 0;
    h = array.size - 1;
    stack = [ l, h ];
    top = 1;
    
    while ( top >= 0 )
    {
        h = stack[ top ];
        top--;
        l = stack[ top ];
        top--;
        
        if ( h - l <= 9 )
        {
            h++;
            
            while ( l < h )
            {
                x = array[ l ];
                j = l - 1;
                
                while ( j >= 0 && [[ compare_func ]]( x, array[ j ] ) )
                {
                    array[ j + 1 ] = array[ j ];
                    j -= 1;
                }
                
                array[ j + 1 ] = x;
                l += 1;
            }
            
            continue;
        }
        
        x = array[ h ];
        p = l - 1;
        
        for ( j = l; j <= h - 1 ; j++ )
        {
            if ( [[ compare_func ]]( array[ j ], x ) )
            {
                p++;
                temp = array[ p ];
                array[ p ] = array[ j ];
                array[ j ] = temp;
            }
        }
        
        p++;
        temp = array[ p ];
        array[ p ] = array[ h ];
        array[ h ] = temp;
        
        if ( p - 1 > l )
        {
            top++;
            stack[ top ] = l;
            top++;
            stack[ top ] = p - 1;
        }
        
        if ( p + 1 < h )
        {
            top++;
            stack[ top ] = p + 1;
            top++;
            stack[ top ] = h;
        }
    }
    
    return array;
}

// Namespace script / scripts\mp\utility\script
// Params 2
// Checksum 0x0, Offset: 0x4a5
// Size: 0x16, Type: bool
function default_compare( left, right )
{
    return left <= right;
}

// Namespace script / scripts\mp\utility\script
// Params 2
// Checksum 0x0, Offset: 0x4c4
// Size: 0x59
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

// Namespace script / scripts\mp\utility\script
// Params 3
// Checksum 0x0, Offset: 0x526
// Size: 0xa9
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

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0x5d8
// Size: 0x7c
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

// Namespace script / scripts\mp\utility\script
// Params 2
// Checksum 0x0, Offset: 0x65d
// Size: 0x6e
function array_remove_keep_index( ents, remover )
{
    newents = [];
    
    foreach ( index, ent in ents )
    {
        if ( ent != remover )
        {
            newents[ index ] = ent;
        }
    }
    
    return newents;
}

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0x6d4
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

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0x6fc
// Size: 0x30
function roundup( floatvalue )
{
    if ( floatvalue - int( floatvalue ) >= 0.5 )
    {
        return int( floatvalue + 1 );
    }
    
    return int( floatvalue );
}

// Namespace script / scripts\mp\utility\script
// Params 9
// Checksum 0x0, Offset: 0x734
// Size: 0x5f
function bufferednotify( notification, param1, param2, param3, param4, param5, param6, param7, param8 )
{
    thread bufferednotify_internal( notification, param1, param2, param3, param4, param5, param6, param7, param8 );
}

// Namespace script / scripts\mp\utility\script
// Params 9
// Checksum 0x0, Offset: 0x79b
// Size: 0x1ea
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
    
    while ( isdefined( self ) && self.bufferednotifications[ notification ].size > 0 )
    {
        parameters = self.bufferednotifications[ notification ][ 0 ];
        self notify( notification, parameters.param1, parameters.param2, parameters.param3, parameters.param4, parameters.param5, parameters.param6, parameters.param7, parameters.param8 );
        self.bufferednotifications[ notification ] = array_remove_index( self.bufferednotifications[ notification ], 0 );
        waitframe();
    }
}

// Namespace script / scripts\mp\utility\script
// Params 2
// Checksum 0x0, Offset: 0x98d
// Size: 0x3c
function notifyafterframeend( waittillmsg, var_7239f8830ef22b43 )
{
    assertex( isdefined( waittillmsg ), "<dev string:x1c>" );
    assertex( isdefined( var_7239f8830ef22b43 ), "<dev string:x57>" );
    self waittill( waittillmsg );
    waittillframeend();
    self notify( var_7239f8830ef22b43 );
}

// Namespace script / scripts\mp\utility\script
// Params 3
// Checksum 0x0, Offset: 0x9d1
// Size: 0x2d
function delaysetclientomnvar( delaytime, omnvar, value )
{
    self endon( "disconnect" );
    wait delaytime;
    self setclientomnvar( omnvar, value );
}

// Namespace script / scripts\mp\utility\script
// Params 2
// Checksum 0x0, Offset: 0xa06
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

// Namespace script / scripts\mp\utility\script
// Params 2
// Checksum 0x0, Offset: 0xa4c
// Size: 0x42
function vectortoanglessafe( forward, up )
{
    right = vectorcross( forward, up );
    up = vectorcross( right, forward );
    angles = axistoangles( forward, right, up );
    return angles;
}

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xa97
// Size: 0x90
function heap( type )
{
    assertex( type == "<dev string:x8f>" || type == "<dev string:x96>", "<dev string:x9d>" );
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

// Namespace script / scripts\mp\utility\script
// Params 0
// Checksum 0x0, Offset: 0xb30
// Size: 0xb
function heapsize()
{
    return self.nvals;
}

// Namespace script / scripts\mp\utility\script
// Params 0
// Checksum 0x0, Offset: 0xb44
// Size: 0xe
function heappeek()
{
    return self.vals[ 1 ];
}

// Namespace script / scripts\mp\utility\script
// Params 0
// Checksum 0x0, Offset: 0xb5b
// Size: 0xb8
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

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xc1b
// Size: 0xc4
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

    // Namespace script / scripts\mp\utility\script
    // Params 0
    // Checksum 0x0, Offset: 0xce7
    // Size: 0x95, Type: dev
    function printheap()
    {
        print( "<dev string:xc1>" );
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
            print( vals[ i ] + "<dev string:xc8>" );
        }
        
        print( "<dev string:xc1>" );
    }

#/

// Namespace script / scripts\mp\utility\script
// Params 2
// Checksum 0x0, Offset: 0xd84
// Size: 0x2a, Type: bool
function _heapgreaterthan( i, j )
{
    return self.vals[ i ] > self.vals[ j ];
}

// Namespace script / scripts\mp\utility\script
// Params 2
// Checksum 0x0, Offset: 0xdb7
// Size: 0x2a, Type: bool
function _heaplessthan( i, j )
{
    return self.vals[ i ] < self.vals[ j ];
}

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xdea
// Size: 0x108
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

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xefa
// Size: 0x23
function _heapleftchild( i )
{
    if ( !isdefined( self.vals[ 2 * i ] ) )
    {
        return undefined;
    }
    
    return 2 * i;
}

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xf26
// Size: 0x29
function _heaprightchild( i )
{
    if ( !isdefined( self.vals[ 2 * i + 1 ] ) )
    {
        return undefined;
    }
    
    return 2 * i + 1;
}

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xf58
// Size: 0x22
function _heapparent( i )
{
    if ( i == 1 )
    {
        return undefined;
    }
    
    return int( floor( i / 2 ) );
}

// Namespace script / scripts\mp\utility\script
// Params 2
// Checksum 0x0, Offset: 0xf83
// Size: 0x1f, Type: bool
function isnumbermultipleof( number, factor )
{
    return number > 0 && number % factor == 0;
}

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xfab
// Size: 0x1a
function demoforcesre( message )
{
    forcesre = message == undefined;
}

// Namespace script / scripts\mp\utility\script
// Params 1
// Checksum 0x0, Offset: 0xfcd
// Size: 0x1c
function function_7bd154ad046984e2( message )
{
    recordeventforsreparser( "sre_error_event", "SRE LOGGING", message );
}

