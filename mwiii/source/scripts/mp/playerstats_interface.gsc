#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\playerstats;

#namespace playerstats_interface;

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 6
// Checksum 0x0, Offset: 0xcd
// Size: 0x8e
function setplayerstat( value, path1, path2, path3, path4, path5 )
{
    if ( !areplayerstatsenabled() )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    pathkey = getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !isstatwritable_internal( pathkey ) )
    {
        return;
    }
    
    setplayerstat_internal( value, pathkey, path1, path2, path3, path4, path5 );
    writeplayerstat( value, path1, path2, path3, path4, path5 );
    updateparentratiosbuffered( pathkey );
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 6
// Checksum 0x0, Offset: 0x163
// Size: 0xb3
function setplayerstatbuffered( value, path1, path2, path3, path4, path5 )
{
    if ( !areplayerstatsenabled() )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    patharray = [ path1 ];
    patharray[ patharray.size ] = path2;
    patharray[ patharray.size ] = path3;
    patharray[ patharray.size ] = path4;
    patharray[ patharray.size ] = path5;
    pathkey = getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !isstatwritable_internal( pathkey ) )
    {
        return;
    }
    
    setplayerstat_internal( value, pathkey, path1, path2, path3, path4, path5 );
    flagstatforbufferedwrite( pathkey );
    updateparentratiosbuffered( pathkey );
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 6
// Checksum 0x0, Offset: 0x21e
// Size: 0xb7
function addtoplayerstat( var_930290d7f474a0ae, path1, path2, path3, path4, path5 )
{
    if ( !areplayerstatsenabled() )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( istrue( game[ "practiceRound" ] ) )
    {
        return;
    }
    
    if ( !isdefined( var_930290d7f474a0ae ) )
    {
        var_930290d7f474a0ae = 1;
    }
    
    pathkey = getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !isstatwritable_internal( pathkey ) )
    {
        return;
    }
    
    addtoplayerstat_internal( var_930290d7f474a0ae, pathkey, path1, path2, path3, path4, path5 );
    writeplayerstat( self.playerstats.values[ pathkey ], path1, path2, path3, path4, path5 );
    updateparentratios( pathkey );
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 6
// Checksum 0x0, Offset: 0x2dd
// Size: 0x92
function addtoplayerstatbuffered( var_930290d7f474a0ae, path1, path2, path3, path4, path5 )
{
    if ( !areplayerstatsenabled() )
    {
        return;
    }
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( !isdefined( var_930290d7f474a0ae ) )
    {
        var_930290d7f474a0ae = 1;
    }
    
    pathkey = getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !isstatwritable_internal( pathkey ) )
    {
        return;
    }
    
    addtoplayerstat_internal( var_930290d7f474a0ae, pathkey, path1, path2, path3, path4, path5 );
    flagstatforbufferedwrite( pathkey );
    updateparentratiosbuffered( pathkey );
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 5
// Checksum 0x0, Offset: 0x377
// Size: 0xcd
function getplayerstat( path1, path2, path3, path4, path5 )
{
    if ( !areplayerstatsenabled() )
    {
        return undefined;
    }
    
    if ( isai( self ) )
    {
        return 0;
    }
    
    if ( !isdefined( self.playerstats ) )
    {
        return;
    }
    
    if ( !isdefined( self.playerstats.values ) )
    {
        return;
    }
    
    pathkey = getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !isdefined( self.playerstats.values[ pathkey ] ) )
    {
        self.playerstats.values[ pathkey ] = readplayerstat( path1, path2, path3, path4, path5 );
    }
    
    return self.playerstats.values[ pathkey ];
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 0
// Checksum 0x0, Offset: 0x44d
// Size: 0x24, Type: bool
function areplayerstatsenabled()
{
    return isdefined( level.playerstats ) && istrue( level.playerstats.enabled );
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 0
// Checksum 0x0, Offset: 0x47a
// Size: 0x17, Type: bool
function areplayerstatsreadonly()
{
    return level.playerstats.readonly > 0;
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 0
// Checksum 0x0, Offset: 0x49a
// Size: 0x16
function makeallplayerstatsreadonly()
{
    level.playerstats.readonly++;
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 0
// Checksum 0x0, Offset: 0x4b8
// Size: 0x39
function makeallplayerstatswritable()
{
    assertex( level.playerstats.readonly > 0, "<dev string:x1c>" );
    level.playerstats.readonly--;
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 5
// Checksum 0x0, Offset: 0x4f9
// Size: 0x4a
function makeplayerstatreadonly( path1, path2, path3, path4, path5 )
{
    pathkey = getplayerstatpathkey( path1, path2, path3, path4, path5 );
    return modifystatwritability( pathkey, 0 );
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 5
// Checksum 0x0, Offset: 0x54c
// Size: 0x4b
function makeplayerstatwritable( path1, path2, path3, path4, path5 )
{
    pathkey = getplayerstatpathkey( path1, path2, path3, path4, path5 );
    return modifystatwritability( pathkey, 1 );
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 5
// Checksum 0x0, Offset: 0x5a0
// Size: 0x49
function isplayerstatwritable( path1, path2, path3, path4, path5 )
{
    pathkey = getplayerstatpathkey( path1, path2, path3, path4, path5 );
    return isstatwritable_internal( pathkey );
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 1
// Checksum 0x0, Offset: 0x5f2
// Size: 0x40
function makeplayerstatgroupreadonly( statgroup )
{
    assertex( isdefined( level.playerstats.statgroups[ statgroup ] ), "<dev string:x78>" + statgroup + "<dev string:xb6>" );
    modifystatgroupwritability( statgroup, 0 );
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 1
// Checksum 0x0, Offset: 0x63a
// Size: 0x41
function makeplayerstatgroupwritable( statgroup )
{
    assertex( isdefined( level.playerstats.statgroups[ statgroup ] ), "<dev string:xbb>" + statgroup + "<dev string:xb6>" );
    modifystatgroupwritability( statgroup, 1 );
}

// Namespace playerstats_interface / scripts\mp\playerstats_interface
// Params 3
// Checksum 0x0, Offset: 0x683
// Size: 0x162
function registerplayerstatratio( var_8c83072b0421282c, var_59381b551181653c, var_de2ad9f399ec5304 )
{
    globals = level.playerstats;
    var_75af64168ade09b6 = getplayerstatpathkey( var_8c83072b0421282c[ 0 ], var_8c83072b0421282c[ 1 ], var_8c83072b0421282c[ 2 ], var_8c83072b0421282c[ 3 ], var_8c83072b0421282c[ 4 ] );
    globals.ratios[ var_75af64168ade09b6 ] = [];
    globals.ratios[ var_75af64168ade09b6 ][ "numerator" ] = var_59381b551181653c;
    globals.ratios[ var_75af64168ade09b6 ][ "denominator" ] = var_de2ad9f399ec5304;
    var_9239b0ae7e345446 = getplayerstatpathkey( var_59381b551181653c[ 0 ], var_59381b551181653c[ 1 ], var_59381b551181653c[ 2 ], var_59381b551181653c[ 3 ], var_59381b551181653c[ 4 ] );
    var_c265966ffd9818be = getplayerstatpathkey( var_de2ad9f399ec5304[ 0 ], var_de2ad9f399ec5304[ 1 ], var_de2ad9f399ec5304[ 2 ], var_de2ad9f399ec5304[ 3 ], var_de2ad9f399ec5304[ 4 ] );
    
    if ( !isdefined( globals.ratiochildren[ var_9239b0ae7e345446 ] ) )
    {
        globals.ratiochildren[ var_9239b0ae7e345446 ] = [ var_8c83072b0421282c ];
    }
    else
    {
        globals.ratiochildren[ var_9239b0ae7e345446 ][ globals.ratiochildren[ var_9239b0ae7e345446 ].size ] = var_8c83072b0421282c;
    }
    
    if ( !isdefined( globals.ratiochildren[ var_c265966ffd9818be ] ) )
    {
        globals.ratiochildren[ var_c265966ffd9818be ] = [ var_8c83072b0421282c ];
        return;
    }
    
    globals.ratiochildren[ var_c265966ffd9818be ][ globals.ratiochildren[ var_c265966ffd9818be ].size ] = var_8c83072b0421282c;
}

