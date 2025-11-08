#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\flags;

#namespace matchstats;

// Namespace matchstats / scripts\mp\matchstats
// Params 0
// Checksum 0x0, Offset: 0x109
// Size: 0x5f
function init()
{
    if ( !level.rankedmatch )
    {
        return;
    }
    
    level.matchstats = spawnstruct();
    level.matchstats.datawritten = 0;
    loadgamemodestatmap();
    thread watchplayerconnect();
    thread watchgameend();
    level.matchstats.enabled = 1;
}

// Namespace matchstats / scripts\mp\matchstats
// Params 0
// Checksum 0x0, Offset: 0x170
// Size: 0xce
function loadgamemodestatmap()
{
    row = tablelookuprownum( "mp/gameModeMatchStats.csv", 0, level.gametype );
    var_fb34a58676a70b9c = level.matchstats;
    
    if ( !isdefined( row ) || row < 0 )
    {
        println( "<dev string:x1c>" );
        var_fb34a58676a70b9c.modestatsenabled = 0;
        return;
    }
    
    var_fb34a58676a70b9c.modestatsenabled = 1;
    var_fb34a58676a70b9c.modestatmap = [];
    
    for ( columnindex = 1; columnindex < 7 ; columnindex++ )
    {
        statname = tablelookupbyrow( "mp/gameModeMatchStats.csv", row, columnindex );
        
        if ( !isdefined( statname ) || statname == "" )
        {
            continue;
        }
        
        var_fb34a58676a70b9c.modestatmap[ statname ] = columnindex - 1;
    }
}

// Namespace matchstats / scripts\mp\matchstats
// Params 0
// Checksum 0x0, Offset: 0x246
// Size: 0x33
function watchplayerconnect()
{
    while ( true )
    {
        level waittill( "connected", player );
        
        if ( isai( player ) )
        {
            continue;
        }
        
        player thread initplayer();
    }
}

// Namespace matchstats / scripts\mp\matchstats
// Params 0
// Checksum 0x0, Offset: 0x281
// Size: 0x7d
function initplayer()
{
    if ( isdefined( self.pers[ "matchstats" ] ) )
    {
        self.matchstats = self.pers[ "matchstats" ];
        return;
    }
    
    self.matchstats = spawnstruct();
    var_e2f408cda8155ac = self.matchstats;
    self.matchstats.values = [];
    self.matchstats.paths = [];
}

// Namespace matchstats / scripts\mp\matchstats
// Params 0
// Checksum 0x0, Offset: 0x306
// Size: 0x8c
function watchgameend()
{
    scripts\mp\flags::levelflagwait( "game_over" );
    players = level.players;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player writeplayerinfo();
        waitframe();
    }
    
    level.matchstats.datawritten = 1;
}

// Namespace matchstats / scripts\mp\matchstats
// Params 0
// Checksum 0x0, Offset: 0x39a
// Size: 0x19c
function writeplayerinfo()
{
    var_e2f408cda8155ac = self.matchstats;
    
    if ( !isdefined( var_e2f408cda8155ac ) )
    {
        return;
    }
    
    assert( var_e2f408cda8155ac.paths.size == var_e2f408cda8155ac.values.size );
    
    foreach ( statkey, value in var_e2f408cda8155ac.values )
    {
        patharray = var_e2f408cda8155ac.paths[ statkey ];
        
        switch ( patharray.size )
        {
            case 1:
                self setplayerdata( level.progressiongroup, "matchStats", patharray[ 0 ], value );
                break;
            case 2:
                self setplayerdata( level.progressiongroup, "matchStats", patharray[ 0 ], patharray[ 1 ], value );
                break;
            case 3:
                self setplayerdata( level.progressiongroup, "matchStats", patharray[ 0 ], patharray[ 1 ], patharray[ 2 ], value );
                break;
            case 4:
                self setplayerdata( level.progressiongroup, "matchStats", patharray[ 0 ], patharray[ 1 ], patharray[ 2 ], patharray[ 3 ], value );
                break;
            case 5:
                self setplayerdata( level.progressiongroup, "matchStats", patharray[ 0 ], patharray[ 1 ], patharray[ 2 ], patharray[ 3 ], patharray[ 4 ], value );
                break;
        }
    }
}

// Namespace matchstats / scripts\mp\matchstats
// Params 1
// Checksum 0x0, Offset: 0x53e
// Size: 0x49
function getmatchstatpathkey( patharray )
{
    pathstring = "";
    
    for ( i = 0; i < patharray.size ; i++ )
    {
        if ( isdefined( patharray[ i ] ) )
        {
            pathstring += patharray[ i ] + ".";
        }
    }
    
    return pathstring;
}

// Namespace matchstats / scripts\mp\matchstats
// Params 6
// Checksum 0x0, Offset: 0x590
// Size: 0xde
function setmatchstat( value, path1, path2, path3, path4, path5 )
{
    if ( !arematchstatsenabled() )
    {
        return;
    }
    
    assertex( !level.matchstats.datawritten, "<dev string:x69>" );
    patharray = [ path1 ];
    
    if ( isdefined( path2 ) )
    {
        patharray[ patharray.size ] = path2;
    }
    
    if ( isdefined( path3 ) )
    {
        patharray[ patharray.size ] = path3;
    }
    
    if ( isdefined( path4 ) )
    {
        patharray[ patharray.size ] = path4;
    }
    
    if ( isdefined( path5 ) )
    {
        patharray[ patharray.size ] = path5;
    }
    
    pathkey = getmatchstatpathkey( patharray );
    self.matchstats.values[ pathkey ] = value;
    self.matchstats.paths[ pathkey ] = patharray;
}

// Namespace matchstats / scripts\mp\matchstats
// Params 6
// Checksum 0x0, Offset: 0x676
// Size: 0x132
function addtomatchstat( var_930290d7f474a0ae, path1, path2, path3, path4, path5 )
{
    if ( !arematchstatsenabled() )
    {
        return;
    }
    
    assertex( !level.matchstats.datawritten, "<dev string:x69>" );
    
    if ( !isdefined( var_930290d7f474a0ae ) )
    {
        var_930290d7f474a0ae = 1;
    }
    
    patharray = [ path1 ];
    
    if ( isdefined( path2 ) )
    {
        patharray[ patharray.size ] = path2;
    }
    
    if ( isdefined( path3 ) )
    {
        patharray[ patharray.size ] = path3;
    }
    
    if ( isdefined( path4 ) )
    {
        patharray[ patharray.size ] = path4;
    }
    
    if ( isdefined( path5 ) )
    {
        patharray[ patharray.size ] = path5;
    }
    
    pathkey = getmatchstatpathkey( patharray );
    
    if ( !isdefined( self.matchstats.paths[ pathkey ] ) )
    {
        self.matchstats.values[ pathkey ] = var_930290d7f474a0ae;
        self.matchstats.paths[ pathkey ] = patharray;
        return;
    }
    
    self.matchstats.values[ pathkey ] += var_930290d7f474a0ae;
}

// Namespace matchstats / scripts\mp\matchstats
// Params 5
// Checksum 0x0, Offset: 0x7b0
// Size: 0x9e
function getmatchstat( path1, path2, path3, path4, path5 )
{
    if ( !arematchstatsenabled() )
    {
        return undefined;
    }
    
    patharray = [ path1, path2, path3, path4, path5 ];
    pathkey = getmatchstatpathkey( patharray );
    
    if ( !isdefined( self.matchstats.values[ pathkey ] ) )
    {
        return 0;
    }
    
    return self.matchstats.values[ pathkey ];
}

// Namespace matchstats / scripts\mp\matchstats
// Params 1
// Checksum 0x0, Offset: 0x857
// Size: 0x3e
function getmodestatindex( statname )
{
    var_fb34a58676a70b9c = level.matchstats;
    
    if ( !isdefined( var_fb34a58676a70b9c.modestatsenabled ) )
    {
        return undefined;
    }
    
    return var_fb34a58676a70b9c.modestatmap[ statname ];
}

// Namespace matchstats / scripts\mp\matchstats
// Params 2
// Checksum 0x0, Offset: 0x89e
// Size: 0x5a
function setgamemodestat( statname, newvalue )
{
    if ( !arematchstatsenabled() )
    {
        return;
    }
    
    statindex = getmodestatindex( statname );
    
    if ( !isdefined( statindex ) )
    {
        assertmsg( "<dev string:xb5>" + statname + "<dev string:xd7>" );
        return;
    }
    
    setmatchstat( newvalue, "modeStats", statindex );
}

// Namespace matchstats / scripts\mp\matchstats
// Params 2
// Checksum 0x0, Offset: 0x900
// Size: 0x5a
function addtogamemodestat( statname, var_930290d7f474a0ae )
{
    if ( !arematchstatsenabled() )
    {
        return;
    }
    
    statindex = getmodestatindex( statname );
    
    if ( !isdefined( statindex ) )
    {
        assertmsg( "<dev string:x116>" + statname + "<dev string:xd7>" );
        return;
    }
    
    addtomatchstat( var_930290d7f474a0ae, "modeStats", statindex );
}

// Namespace matchstats / scripts\mp\matchstats
// Params 1
// Checksum 0x0, Offset: 0x962
// Size: 0x50
function getgamemodestat( statname )
{
    if ( !arematchstatsenabled() )
    {
        return;
    }
    
    statindex = getmodestatindex( statname );
    
    if ( !isdefined( statindex ) )
    {
        assertmsg( "<dev string:x116>" + statname + "<dev string:xd7>" );
        return;
    }
    
    return getmatchstat( "modeStats", statindex );
}

// Namespace matchstats / scripts\mp\matchstats
// Params 0
// Checksum 0x0, Offset: 0x9bb
// Size: 0x24, Type: bool
function arematchstatsenabled()
{
    return isdefined( level.matchstats ) && istrue( level.matchstats.enabled );
}

