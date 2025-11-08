#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\playerstats_interface;
#using scripts\mp\utility\game;

#namespace playerstats;

// Namespace playerstats / scripts\mp\playerstats
// Params 0
// Checksum 0x0, Offset: 0x1b4
// Size: 0x214
function init()
{
    if ( !level.onlinestatsenabled )
    {
        return;
    }
    
    level.playerstats = spawnstruct();
    globals = level.playerstats;
    globals.statgroups = [];
    globals.disabledstats = [];
    globals.enabled = 1;
    globals.readonly = 0;
    globals.ratios = [];
    globals.ratiochildren = [];
    globals.disabledpaths = [];
    registerplayerstatratio( [ "combatStats", "kdRatio" ], [ "combatStats", "kills" ], [ "combatStats", "deaths" ] );
    registerplayerstatratio( [ "combatStats", "accuracy" ], [ "combatStats", "hits" ], [ "combatStats", "totalShots" ] );
    registerplayerstatratio( [ "matchStats", "winLossRatio" ], [ "matchStats", "wins" ], [ "matchStats", "losses" ] );
    addtostatgroup( "kdr", "combatStats", "kills" );
    addtostatgroup( "kdr", "combatStats", "deaths" );
    addtostatgroup( "kdr", "combatStats", "kdRatio" );
    addtostatgroup( "winLoss", "matchStats", "wins" );
    addtostatgroup( "winLoss", "matchStats", "losses" );
    addtostatgroup( "winLoss", "matchStats", "winLossRatio" );
    addtostatgroup( "winLoss", "matchStats", "winStreak" );
    addtostatgroup( "winLoss", "matchStats", "ties" );
    addtostatgroup( "losses", "matchStats", "losses" );
}

// Namespace playerstats / scripts\mp\playerstats
// Params 0
// Checksum 0x0, Offset: 0x3d0
// Size: 0xb0
function initplayer()
{
    if ( !level.onlinestatsenabled )
    {
        return;
    }
    
    if ( isdefined( self.pers[ "playerstats" ] ) )
    {
        self.playerstats = self.pers[ "playerstats" ];
    }
    else
    {
        self.playerstats = spawnstruct();
        playerplayerstats = self.playerstats;
        self.playerstats.values = [];
        self.playerstats.paths = [];
        self.playerstats.bufferedstats = [];
    }
    
    if ( !scripts\mp\utility\game::runleanthreadmode() )
    {
        thread bufferedstatwritethink();
    }
}

// Namespace playerstats / scripts\mp\playerstats
// Params 0
// Checksum 0x0, Offset: 0x488
// Size: 0x2e
function bufferedstatwritethink()
{
    self endon( "disconnect" );
    
    while ( !scripts\mp\flags::levelflag( "game_over" ) )
    {
        writebufferedstats();
        wait 2;
    }
    
    writebufferedstats();
}

// Namespace playerstats / scripts\mp\playerstats
// Params 0
// Checksum 0x0, Offset: 0x4be
// Size: 0xd0
function writebufferedstats()
{
    if ( isai( self ) )
    {
        return;
    }
    
    foreach ( pathkey, unused in self.playerstats.bufferedstats )
    {
        patharray = self.playerstats.paths[ pathkey ];
        value = self.playerstats.values[ pathkey ];
        writeplayerstat( value, patharray[ 0 ], patharray[ 1 ], patharray[ 2 ], patharray[ 3 ], patharray[ 4 ] );
    }
    
    self.playerstats.bufferedstats = [];
}

// Namespace playerstats / scripts\mp\playerstats
// Params 5
// Checksum 0x0, Offset: 0x596
// Size: 0xc1
function getplayerstatpathkey( path1, path2, path3, path4, path5 )
{
    pathstring = "";
    
    if ( isdefined( path5 ) )
    {
        pathstring = path1 + "." + path2 + "." + path3 + "." + path4 + "." + path5;
    }
    else if ( isdefined( path4 ) )
    {
        pathstring = path1 + "." + path2 + "." + path3 + "." + path4;
    }
    else if ( isdefined( path3 ) )
    {
        pathstring = path1 + "." + path2 + "." + path3;
    }
    else if ( isdefined( path2 ) )
    {
        pathstring = path1 + "." + path2;
    }
    else if ( isdefined( path1 ) )
    {
        pathstring = path1;
    }
    
    return pathstring;
}

// Namespace playerstats / scripts\mp\playerstats
// Params 6
// Checksum 0x0, Offset: 0x660
// Size: 0xd5
function writeplayerstat( value, path1, path2, path3, path4, path5 )
{
    if ( isdefined( path5 ) )
    {
        self setplayerdata( level.progressiongroup, "playerStats", path1, path2, path3, path4, path5, value );
        return;
    }
    
    if ( isdefined( path4 ) )
    {
        self setplayerdata( level.progressiongroup, "playerStats", path1, path2, path3, path4, value );
        return;
    }
    
    if ( isdefined( path3 ) )
    {
        self setplayerdata( level.progressiongroup, "playerStats", path1, path2, path3, value );
        return;
    }
    
    if ( isdefined( path2 ) )
    {
        self setplayerdata( level.progressiongroup, "playerStats", path1, path2, value );
        return;
    }
    
    if ( isdefined( path1 ) )
    {
        self setplayerdata( level.progressiongroup, "playerStats", path1, value );
    }
}

// Namespace playerstats / scripts\mp\playerstats
// Params 5
// Checksum 0x0, Offset: 0x73d
// Size: 0xc8
function readplayerstat( path1, path2, path3, path4, path5 )
{
    if ( isdefined( path5 ) )
    {
        return self getplayerdata( level.progressiongroup, "playerStats", path1, path2, path3, path4, path5 );
    }
    
    if ( isdefined( path4 ) )
    {
        return self getplayerdata( level.progressiongroup, "playerStats", path1, path2, path3, path4 );
    }
    
    if ( isdefined( path3 ) )
    {
        return self getplayerdata( level.progressiongroup, "playerStats", path1, path2, path3 );
    }
    
    if ( isdefined( path2 ) )
    {
        return self getplayerdata( level.progressiongroup, "playerStats", path1, path2 );
    }
    
    if ( isdefined( path1 ) )
    {
        return self getplayerdata( level.progressiongroup, "playerStats", path1 );
    }
}

// Namespace playerstats / scripts\mp\playerstats
// Params 1
// Checksum 0x0, Offset: 0x80d
// Size: 0xa0
function flagstatforbufferedwrite( pathkey )
{
    globals = level.playerstats;
    
    if ( scripts\mp\flags::levelflag( "game_over" ) )
    {
        patharray = self.playerstats.paths[ pathkey ];
        value = self.playerstats.values[ pathkey ];
        writeplayerstat( value, patharray[ 0 ], patharray[ 1 ], patharray[ 2 ], patharray[ 3 ], patharray[ 4 ] );
        return;
    }
    
    self.playerstats.bufferedstats[ pathkey ] = 1;
}

// Namespace playerstats / scripts\mp\playerstats
// Params 7
// Checksum 0x0, Offset: 0x8b5
// Size: 0x96
function setplayerstat_internal( value, pathkey, path1, path2, path3, path4, path5 )
{
    patharray = [ path1 ];
    patharray[ patharray.size ] = path2;
    patharray[ patharray.size ] = path3;
    patharray[ patharray.size ] = path4;
    patharray[ patharray.size ] = path5;
    self.playerstats.values[ pathkey ] = value;
    self.playerstats.paths[ pathkey ] = patharray;
}

// Namespace playerstats / scripts\mp\playerstats
// Params 7
// Checksum 0x0, Offset: 0x953
// Size: 0xfc
function addtoplayerstat_internal( var_930290d7f474a0ae, pathkey, path1, path2, path3, path4, path5 )
{
    patharray = [ path1 ];
    patharray[ patharray.size ] = path2;
    patharray[ patharray.size ] = path3;
    patharray[ patharray.size ] = path4;
    patharray[ patharray.size ] = path5;
    
    if ( !isdefined( self.playerstats.paths[ pathkey ] ) )
    {
        playerdatavalue = readplayerstat( path1, path2, path3, path4, path5 );
        self.playerstats.values[ pathkey ] = playerdatavalue + var_930290d7f474a0ae;
        self.playerstats.paths[ pathkey ] = patharray;
        return;
    }
    
    self.playerstats.values[ pathkey ] += var_930290d7f474a0ae;
}

// Namespace playerstats / scripts\mp\playerstats
// Params 2
// Checksum 0x0, Offset: 0xa57
// Size: 0xbd
function modifystatwritability( pathkey, writable )
{
    globals = level.playerstats;
    
    if ( writable )
    {
        assertex( isdefined( globals.disabledstats[ pathkey ] ) && globals.disabledstats[ pathkey ] > 0, "<dev string:x1c>" );
        globals.disabledstats[ pathkey ]--;
        
        if ( globals.disabledstats[ pathkey ] <= 0 )
        {
            globals.disabledstats[ pathkey ] = undefined;
        }
        
        return;
    }
    
    if ( !isdefined( globals.disabledstats[ pathkey ] ) )
    {
        globals.disabledstats[ pathkey ] = 1;
        return;
    }
    
    globals.disabledstats[ pathkey ]++;
}

// Namespace playerstats / scripts\mp\playerstats
// Params 1
// Checksum 0x0, Offset: 0xb1c
// Size: 0x2c, Type: bool
function isstatwritable_internal( pathkey )
{
    return !areplayerstatsreadonly() && !isdefined( level.playerstats.disabledstats[ pathkey ] );
}

// Namespace playerstats / scripts\mp\playerstats
// Params 6
// Checksum 0x0, Offset: 0xb51
// Size: 0xa0
function addtostatgroup( statgroup, path1, path2, path3, path4, path5 )
{
    globals = level.playerstats;
    pathkey = getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !isdefined( globals.statgroups[ statgroup ] ) )
    {
        globals.statgroups[ statgroup ] = [];
    }
    
    globals.statgroups[ statgroup ][ globals.statgroups[ statgroup ].size ] = pathkey;
}

// Namespace playerstats / scripts\mp\playerstats
// Params 2
// Checksum 0x0, Offset: 0xbf9
// Size: 0x7f
function modifystatgroupwritability( statgroup, writable )
{
    globals = level.playerstats;
    
    foreach ( pathkey in globals.statgroups[ statgroup ] )
    {
        modifystatwritability( pathkey, writable );
    }
}

// Namespace playerstats / scripts\mp\playerstats
// Params 5
// Checksum 0x0, Offset: 0xc80
// Size: 0x124
function calculateplayerstatratio( path1, path2, path3, path4, path5 )
{
    if ( !areplayerstatsenabled() )
    {
        return undefined;
    }
    
    globals = level.playerstats;
    pathkey = getplayerstatpathkey( path1, path2, path3, path4, path5 );
    
    if ( !isdefined( globals.ratios[ pathkey ] ) )
    {
        assertmsg( "<dev string:x6d>" + pathkey + "<dev string:xa0>" );
    }
    
    if ( !isstatwritable_internal( pathkey ) )
    {
        return;
    }
    
    var_998d185046c07e5c = globals.ratios[ pathkey ][ "numerator" ];
    var_85468554d750c31d = globals.ratios[ pathkey ][ "denominator" ];
    numerator = getplayerstat( var_998d185046c07e5c[ 0 ], var_998d185046c07e5c[ 1 ], var_998d185046c07e5c[ 2 ], var_998d185046c07e5c[ 3 ], var_998d185046c07e5c[ 4 ] );
    denominator = getplayerstat( var_85468554d750c31d[ 0 ], var_85468554d750c31d[ 1 ], var_85468554d750c31d[ 2 ], var_85468554d750c31d[ 3 ], var_85468554d750c31d[ 4 ] );
    
    if ( denominator == 0 )
    {
        denominator = 1;
    }
    
    return numerator / denominator;
}

// Namespace playerstats / scripts\mp\playerstats
// Params 5
// Checksum 0x0, Offset: 0xdad
// Size: 0x4f
function updateplayerstatratio( path1, path2, path3, path4, path5 )
{
    value = calculateplayerstatratio( path1, path2, path3, path4, path5 );
    setplayerstat( value, path1, path2, path3, path4, path5 );
}

// Namespace playerstats / scripts\mp\playerstats
// Params 5
// Checksum 0x0, Offset: 0xe04
// Size: 0x4f
function updateplayerstatratiobuffered( path1, path2, path3, path4, path5 )
{
    value = calculateplayerstatratio( path1, path2, path3, path4, path5 );
    setplayerstatbuffered( value, path1, path2, path3, path4, path5 );
}

// Namespace playerstats / scripts\mp\playerstats
// Params 1
// Checksum 0x0, Offset: 0xe5b
// Size: 0x9a
function updateparentratios( var_795f8fa71513ebce )
{
    globals = level.playerstats;
    
    if ( !isdefined( globals.ratiochildren[ var_795f8fa71513ebce ] ) )
    {
        return;
    }
    
    foreach ( var_558824b1025d74ab in globals.ratiochildren[ var_795f8fa71513ebce ] )
    {
        updateplayerstatratio( var_558824b1025d74ab[ 0 ], var_558824b1025d74ab[ 1 ], var_558824b1025d74ab[ 2 ], var_558824b1025d74ab[ 3 ], var_558824b1025d74ab[ 4 ] );
    }
}

// Namespace playerstats / scripts\mp\playerstats
// Params 1
// Checksum 0x0, Offset: 0xefd
// Size: 0x9a
function updateparentratiosbuffered( var_795f8fa71513ebce )
{
    globals = level.playerstats;
    
    if ( !isdefined( globals.ratiochildren[ var_795f8fa71513ebce ] ) )
    {
        return;
    }
    
    foreach ( var_558824b1025d74ab in globals.ratiochildren[ var_795f8fa71513ebce ] )
    {
        updateplayerstatratiobuffered( var_558824b1025d74ab[ 0 ], var_558824b1025d74ab[ 1 ], var_558824b1025d74ab[ 2 ], var_558824b1025d74ab[ 3 ], var_558824b1025d74ab[ 4 ] );
    }
}

