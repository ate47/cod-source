#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\gwtdm;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;

#namespace spawnfactor;

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 0
// Checksum 0x0, Offset: 0x7ba
// Size: 0x38c
function init_spawn_factors()
{
    if ( !isdefined( level.spawn_closeenemydistsq ) )
    {
        level.spawn_closeenemydistsq = 250000;
    }
    
    if ( !isdefined( level.enemyspawninfluencedistsq ) )
    {
        level.enemyspawninfluencedistsq = 810000;
    }
    
    registerfactor( "preferOptimalTTLOS", undefined, 0, undefined );
    registerfactor( "avoidShortTimeToEnemySight", undefined, 0, undefined );
    registerfactor( "preferAlliesByDistance", undefined, 0, undefined );
    registerfactor( "preferCloseToAlly", undefined, 0, undefined );
    registerfactor( "avoidRecentlyUsedByEnemies", undefined, 0, undefined );
    registerfactor( "avoidEnemiesByDistance", undefined, 0, undefined );
    registerfactor( "avoidEnemyInfluence", undefined, 0, undefined );
    registerfactor( "avoidLastDeathLocation", undefined, 0, undefined );
    registerfactor( "avoidLastAttackerLocation", undefined, 0, undefined );
    registerfactor( "avoidShortTimeToJumpingEnemySight", undefined, 0, undefined );
    registerfactor( "avoidVeryShortTimeToJumpingEnemySight", undefined, 0, undefined );
    registerfactor( "avoidSameSpawn", undefined, 0, undefined );
    registerfactor( "avoidRecentlyUsedByAnyone", undefined, 0, undefined );
    registerfactor( "avoidUsedByAnyoneEver", undefined, 0, undefined );
    registerfactor( "randomSpawnScore", undefined, 0, undefined );
    registerfactor( "preferNearLastTeamSpawn", undefined, 0, undefined );
    registerfactor( "preferNearGroupsOfTeamMates", undefined, 0, undefined );
    registerfactor( "preferOccupiedLanes", undefined, 0, undefined );
    registerfactor( "preferToBalanceLanes", undefined, 0, undefined );
    registerfactor( "avoidClosestEnemy", undefined, 0, undefined );
    registerfactor( "scriptOnlyTest", &scriptonlytest, 1, [ "test" ] );
    registerfactor( "avoidClosestEnemyByDistance", &avoidclosestenemybydistance, 1, [ "closestEnemyInfluenceDistSq" ] );
    registerfactor( "preferNearSinglePoint", &prefernearsinglepoint, 1, [ "singlePointPos", "minDistToSinglePointSq", "maxDistToSinglePointSq", "distRangeToSinglePointSq" ] );
    registerfactor( "avoidCurrentSpawnTraps", &avoidcurrentspawntraps, 1, undefined );
    registerfactor( "preferDomPoints", &preferdompoints, 1, [ "preferredDomPoints", "secondaryDomPoints" ] );
    registerfactor( "preferShortestDistToZone", &prefershortestdisttozone, 1, [ #"hash_80b230f7f3b6e958", #"hash_ff12ea926c094dde" ] );
    registerfactor( "avoidCloseToZone", &avoidclosetozone, 1, [ #"hash_80b230f7f3b6e958", #"hash_ccf425b826e8654b" ] );
    registerfactor( "preferClosePoints", &preferclosepoints, 1, [ "closestPoints" ] );
    registerfactor( "avoidRugbyOffsides", &avoidrugbyoffsides, 1, [ "juggPos", "rugbyFieldDir2D" ] );
    registerfactor( "oneUseSpawns", &oneusespawns, 1, undefined );
    registerfactor( "avoidCloseToDefenderFlag", &avoidclosetodefenderflag, 1, [ "activeCarrierPosition", "defenderFlagPosition", "avoidDefenderFlagDeadZoneDistSq" ] );
    registerfactor( "avoidCloseToDefenderFlagSpawn", &avoidclosetodefenderflagspawn, 1, [ "avoidDefenderFlagDeadZoneDistSq" ] );
    registerfactor( "avoidFrontlineOffsides", &avoidfrontlineoffsides, 1, undefined );
    registerfactor( "preferOptimalFrontlineDist", &preferoptimalfrontlinedist, 1, undefined );
    registerfactor( "preferUnoccupiedLanes", &preferunoccupiedlanes, 1, undefined );
    initfrontline();
    function_553abfcde517c264();
    callback::add( "player_spawned", &on_player_spawned );
    callback::add( "player_damaged", &on_player_damaged );
    callback::add( "player_death", &on_player_death );
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 0
// Checksum 0x0, Offset: 0xb4e
// Size: 0x6e
function function_28565316737536aa()
{
    function_9c933a291dda6e8e( "avoidCloseEnemies" );
    function_9c933a291dda6e8e( "avoidCornerVisibleEnemies" );
    function_9c933a291dda6e8e( "avoidEnemySpawn" );
    function_9c933a291dda6e8e( "avoidFullVisibleEnemies" );
    function_9c933a291dda6e8e( "avoidTelefrag" );
    function_9c933a291dda6e8e( "considerInfluencePoints" );
    function_9c933a291dda6e8e( "respectFrontline" );
    function_9c933a291dda6e8e( "avoidSpawnTrap" );
    function_9c933a291dda6e8e( "scriptCriticalFactor" );
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 4
// Checksum 0x0, Offset: 0xbc4
// Size: 0xbc
function registerfactor( factorname, factorfunction, isscriptonly, paramreflist )
{
    if ( !isdefined( level.spawnglobals.factors ) )
    {
        level.spawnglobals.factors = [];
    }
    
    assertex( !isfactorregistered( factorname ), "<dev string:x1c>" + factorname + "<dev string:x4c>" );
    factorinfo = spawnstruct();
    level.spawnglobals.factors[ factorname ] = factorinfo;
    factorinfo.function = factorfunction;
    factorinfo.paramreflist = paramreflist;
    factorinfo.isscriptonly = isscriptonly;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0xc88
// Size: 0x6d
function function_9c933a291dda6e8e( factorname )
{
    if ( !isdefined( level.spawnglobals.criticalfactors ) )
    {
        level.spawnglobals.criticalfactors = [];
    }
    
    assertex( !function_c0ba4b08188a6d33( factorname ), "<dev string:x51>" + factorname + "<dev string:x4c>" );
    level.spawnglobals.criticalfactors[ factorname ] = 1;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0xcfd
// Size: 0x21, Type: bool
function isfactorregistered( factorname )
{
    return isdefined( level.spawnglobals.factors[ factorname ] );
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0xd27
// Size: 0x21, Type: bool
function function_c0ba4b08188a6d33( factorname )
{
    return isdefined( level.spawnglobals.criticalfactors[ factorname ] );
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0xd51
// Size: 0x47
function isfactorscriptonly( factorname )
{
    assertex( isfactorregistered( factorname ), "<dev string:x8a>" + factorname + "<dev string:x4c>" );
    return level.spawnglobals.factors[ factorname ].isscriptonly;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0xda1
// Size: 0x47
function getfactorfunction( factorname )
{
    assertex( isfactorregistered( factorname ), "<dev string:xc4>" + factorname + "<dev string:x4c>" );
    return level.spawnglobals.factors[ factorname ].function;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0xdf1
// Size: 0x47
function getfactorparamreflist( factorname )
{
    assertex( isfactorregistered( factorname ), "<dev string:xfd>" + factorname + "<dev string:x4c>" );
    return level.spawnglobals.factors[ factorname ].paramreflist;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 3
// Checksum 0x0, Offset: 0xe41
// Size: 0x215
function calculatefactorscore( spawnpoint, factorname, weight )
{
    if ( !isfactorregistered( factorname ) )
    {
        return 0;
    }
    
    factorfunction = getfactorfunction( factorname );
    factorparamreflist = getfactorparamreflist( factorname );
    spawncontext = level.spawnglobals.activespawncontext;
    
    if ( isdefined( factorparamreflist ) )
    {
        if ( !isdefined( spawncontext.factorparams ) )
        {
            assertmsg( "<dev string:x13a>" + factorname + "<dev string:x14c>" );
        }
        
        /#
            outputparams = [];
            
            foreach ( paramref in factorparamreflist )
            {
                foreach ( var_8437e2a35e8d84c9, var_19b8bfffd5a5cbad in spawncontext.factorparams )
                {
                    if ( var_8437e2a35e8d84c9 == paramref )
                    {
                        outputparams[ paramref ] = var_19b8bfffd5a5cbad;
                        break;
                    }
                }
                
                assertex( isdefined( outputparams[ paramref ] ), "<dev string:x13a>" + factorname + "<dev string:x196>" + paramref + "<dev string:x1b7>" );
            }
        #/
    }
    
    score = [[ factorfunction ]]( spawnpoint );
    score = clamp( score, 0, 100 );
    score *= weight;
    spawnpoint.totalpossiblescore += 100 * weight;
    spawnpoint.lastscore[ self.team ] += score;
    spawnpoint.totalscore += score;
    
    /#
        spawnpoint.debugscoredata[ factorname ] = score;
        spawnpoint.var_6531ac2ff1a37628[ factorname ] = 100 * weight;
    #/
    
    return score;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 2
// Checksum 0x0, Offset: 0x105f
// Size: 0x5b
function critical_factor( var_e2cadc5bf4175e47, spawnpoint )
{
    scorefactor = [[ var_e2cadc5bf4175e47 ]]( spawnpoint );
    scorefactor = clamp( scorefactor, 0, 100 );
    
    /#
        if ( isdefined( spawnpoint.var_b158a46400d7573d ) )
        {
            spawnpoint.var_b158a46400d7573d[ spawnpoint.var_b158a46400d7573d.size ] = scorefactor;
        }
    #/
    
    return scorefactor;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x10c3
// Size: 0x85
function avoidcarepackages( spawnpoint )
{
    foreach ( carepackage in level.carepackages )
    {
        if ( !isdefined( carepackage ) )
        {
            continue;
        }
        
        if ( distancesquared( spawnpoint.origin, carepackage.origin ) < 22500 )
        {
            return 0;
        }
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x1151
// Size: 0x110
function avoidbradleys( spawnpoint )
{
    if ( isdefined( level.bradley ) )
    {
        foreach ( bradley in level.bradley.activevehicles[ "total" ] )
        {
            if ( distancesquared( spawnpoint.origin, bradley.origin ) < 50625 )
            {
                return 0;
            }
        }
        
        foreach ( bradley in level.bradley.inactivevehicles[ "total" ] )
        {
            if ( distancesquared( spawnpoint.origin, bradley.origin ) < 50625 )
            {
                return 0;
            }
        }
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x126a
// Size: 0xa4
function function_5fdeed44e6029789( spawnpoint )
{
    foreach ( grenade in level.grenades )
    {
        if ( !isdefined( grenade ) || !grenade isexplosivedangeroustoplayer( self ) || istrue( grenade.shouldnotblockspawns ) )
        {
            continue;
        }
        
        if ( distancesquared( spawnpoint.origin, grenade.origin ) < 122500 )
        {
            return 0;
        }
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x1317
// Size: 0xde
function function_63d3482ba43b656c( spawnpoint )
{
    var_4e5da354865df1fd = level.mines;
    
    if ( isdefined( level.traps ) && level.traps.size > 0 )
    {
        var_4e5da354865df1fd = array_combine( var_4e5da354865df1fd, level.traps );
    }
    
    foreach ( explosive in var_4e5da354865df1fd )
    {
        if ( !isdefined( explosive ) || !explosive isexplosivedangeroustoplayer( self ) || istrue( explosive.shouldnotblockspawns ) )
        {
            continue;
        }
        
        if ( distancesquared( spawnpoint.origin, explosive.origin ) < 122500 )
        {
            return 0;
        }
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x13fe
// Size: 0x94
function isexplosivedangeroustoplayer( player )
{
    if ( !level.teambased || level.friendlyfire || !isdefined( player.team ) )
    {
        return 1;
    }
    
    explosiveteam = undefined;
    
    if ( isdefined( self.owner ) )
    {
        if ( player == self.owner )
        {
            return 1;
        }
        
        explosiveteam = self.owner.team;
    }
    
    if ( isdefined( explosiveteam ) )
    {
        return ( explosiveteam != player.team );
    }
    
    return 1;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x149a
// Size: 0x67
function function_5e47ef2aeed10cf1( spawnpoint )
{
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = getenemyteams( self.team )[ 0 ];
    }
    
    assert( spawnpoint.hassightdata[ enemyteam ] );
    
    if ( spawnpoint.cornersights[ enemyteam ] > 0 )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x150a
// Size: 0x67
function function_22b490a6df990a49( spawnpoint )
{
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = getenemyteams( self.team )[ 0 ];
    }
    
    assert( spawnpoint.hassightdata[ enemyteam ] );
    
    if ( spawnpoint.fullsights[ enemyteam ] > 0 )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x157a
// Size: 0x126
function function_4546108b3957a698( spawnpoint )
{
    enemyteams = [];
    var_ad5a67fe096d8b1 = [];
    assert( spawnpoint.hasdistdata );
    
    if ( level.teambased )
    {
        enemyteams[ 0 ] = getenemyteams( self.team )[ 0 ];
    }
    else
    {
        enemyteams[ enemyteams.size ] = "all";
    }
    
    foreach ( enemyteam in enemyteams )
    {
        if ( spawnpoint.totalplayers[ enemyteam ] == 0 )
        {
            continue;
        }
        
        var_ad5a67fe096d8b1[ var_ad5a67fe096d8b1.size ] = enemyteam;
    }
    
    if ( var_ad5a67fe096d8b1.size == 0 )
    {
        return 100;
    }
    
    foreach ( enemyteam in var_ad5a67fe096d8b1 )
    {
        if ( spawnpoint.mindistsquared[ enemyteam ] < level.spawn_closeenemydistsq )
        {
            return 0;
        }
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x16a9
// Size: 0xd
function avoidtelefrag( spawnpoint )
{
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x16bf
// Size: 0x2b
function avoidsamespawn_legacy( spawnpoint )
{
    if ( isdefined( self.lastspawnpoint ) && self.lastspawnpoint == spawnpoint )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x16f3
// Size: 0x78
function function_bcea4ae71a95bddd( spawnpoint )
{
    if ( isdefined( self.team ) && isdefined( spawnpoint.lastspawnteam ) && ( !level.teambased || spawnpoint.lastspawnteam != self.team ) )
    {
        allowspawntime = spawnpoint.lastspawntime + 500;
        
        if ( gettime() < allowspawntime )
        {
            return 0;
        }
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x1774
// Size: 0xaa
function function_442824d1095bc118( spawnpoint )
{
    var_973ae253acb25d0e = !level.teambased || isdefined( spawnpoint.lastspawnteam ) && self.team != spawnpoint.lastspawnteam;
    
    if ( var_973ae253acb25d0e && isdefined( spawnpoint.lastspawntime ) )
    {
        timepassed = gettime() - spawnpoint.lastspawntime;
        spawnpoint.analytics.spawnusedbyenemies = timepassed / 1000;
        
        if ( timepassed > 4000 )
        {
            return 100;
        }
        
        return ( timepassed / 4000 * 100 );
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x1827
// Size: 0x68
function function_45dd31709c43b20a( spawnpoint )
{
    if ( isdefined( spawnpoint.lastspawntime ) )
    {
        timepassed = gettime() - spawnpoint.lastspawntime;
        spawnpoint.analytics.timesincelastspawn = timepassed / 1000;
        
        if ( timepassed > 4000 )
        {
            return 100;
        }
        
        return ( timepassed / 4000 * 100 );
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 0
// Checksum 0x0, Offset: 0x1898
// Size: 0x4
function function_11609ea550ebe0fa()
{
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x18a5
// Size: 0x62
function function_97e260aa456c2f73( spawnpoint )
{
    if ( !isdefined( self.lastdeathpos ) )
    {
        return 100;
    }
    
    distsq = distancesquared( spawnpoint.origin, self.lastdeathpos );
    
    if ( distsq > 810000 )
    {
        return 100;
    }
    
    percentdist = distsq / 810000;
    return percentdist * 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x1910
// Size: 0x9a
function function_679bed421f1818e4( spawnpoint )
{
    if ( !isdefined( self.lastattacker ) || !isdefined( self.lastattacker.origin ) )
    {
        return 100;
    }
    
    if ( !isreallyalive( self.lastattacker ) )
    {
        return 100;
    }
    
    distsq = distancesquared( spawnpoint.origin, self.lastattacker.origin );
    
    if ( distsq > 810000 )
    {
        return 100;
    }
    
    percentdist = distsq / 810000;
    return percentdist * 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 0
// Checksum 0x0, Offset: 0x19b3
// Size: 0x3f0
function initfrontline()
{
    frontlineinfo = getglobalfrontlineinfo();
    
    if ( getdvarint( @"scr_ignore_frontline_anchor", 0 ) == 1 )
    {
        return;
    }
    
    if ( isdefined( level.var_69ce64f9d9c5dfb9 ) && level.var_69ce64f9d9c5dfb9 == 1 )
    {
        return;
    }
    
    anchorents = [];
    yaw = getdvarfloat( @"hash_f0fc1446b9ab706d", -1 );
    
    if ( yaw != -1 )
    {
        frontlineinfo.usinganchors = 1;
        frontlineinfo.anchordir = anglestoforward( ( 0, yaw, 0 ) );
        frontlineinfo.anchorrt = anglestoright( ( 0, yaw, 0 ) );
        
        if ( isdefined( level.mapcenter ) )
        {
            frontlineinfo.primaryanchorpos = ( level.mapcenter[ 0 ], level.mapcenter[ 1 ], 0 );
        }
        else
        {
            frontlineinfo.primaryanchorpos = ( 0, 0, 0 );
        }
        
        return;
    }
    
    if ( istrue( level.testtdmanywhere ) )
    {
        y = getdvarfloat( @"hash_aa7892bb1de8f27d", randomfloatrange( 0, 359 ) );
        frontlineinfo.usinganchors = 1;
        frontlineinfo.anchordir = anglestoforward( ( 0, y, 0 ) );
        frontlineinfo.anchorrt = anglestoright( ( 0, y, 0 ) );
        
        if ( isdefined( level.mapcenter ) )
        {
            frontlineinfo.primaryanchorpos = ( level.mapcenter[ 0 ], level.mapcenter[ 1 ], 0 );
        }
        
        level.tdmanywherefrontline = frontlineinfo;
        return;
    }
    
    if ( isdefined( level.var_651db79b41b7e7c9 ) && level.var_651db79b41b7e7c9 != -1 )
    {
        yaw = level.var_651db79b41b7e7c9;
        frontlineinfo.usinganchors = 1;
        frontlineinfo.anchordir = anglestoforward( ( 0, yaw, 0 ) );
        frontlineinfo.anchorrt = anglestoright( ( 0, yaw, 0 ) );
        
        if ( isdefined( level.mapcenter ) )
        {
            frontlineinfo.primaryanchorpos = ( level.mapcenter[ 0 ], level.mapcenter[ 1 ], 0 );
        }
        else
        {
            frontlineinfo.primaryanchorpos = ( 0, 0, 0 );
        }
        
        return;
    }
    
    anchorents = getentarray( "mp_frontline_anchor", "classname" );
    
    if ( isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) )
    {
        filteredents = [];
        
        foreach ( ent in anchorents )
        {
            if ( isdefined( ent.script_noteworthy ) && ent.script_noteworthy == level.localeid )
            {
                filteredents[ filteredents.size ] = ent;
                continue;
            }
            
            ent delete();
        }
        
        anchorents = filteredents;
    }
    else if ( anchorents.size != 1 )
    {
        var_2a427a24184b5b49 = [];
        
        foreach ( ent in anchorents )
        {
            if ( !isdefined( ent.script_noteworthy ) || !issubstr( ent.script_noteworthy, "locale" ) )
            {
                var_2a427a24184b5b49[ var_2a427a24184b5b49.size ] = ent;
                continue;
            }
            
            ent delete();
        }
        
        anchorents = var_2a427a24184b5b49;
    }
    
    if ( anchorents.size != 0 )
    {
        frontlineinfo.usinganchors = 1;
        frontlineinfo.anchordir = anglestoforward( anchorents[ 0 ].angles );
        frontlineinfo.primaryanchorpos = ( anchorents[ 0 ].origin[ 0 ], anchorents[ 0 ].origin[ 1 ], 0 );
    }
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x1dab
// Size: 0x24
function updatefrontline( team )
{
    if ( !updatefrontlineposition() )
    {
        return;
    }
    
    runfrontlinespawntrapchecks( team );
    updatefrontlinedebug();
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 0
// Checksum 0x0, Offset: 0x1dd7
// Size: 0x3e2, Type: bool
function updatefrontlineposition()
{
    if ( !currentspawnlogicsupportsfrontline() )
    {
        return false;
    }
    
    frontlineinfo = getglobalfrontlineinfo();
    curtime = gettime();
    
    if ( !isdefined( frontlineinfo.lastupdatetime ) )
    {
        frontlineinfo.lastupdatetime = curtime;
    }
    else if ( frontlineinfo.isactive[ "allies" ] && frontlineinfo.isactive[ "axis" ] )
    {
        frontlineinfo.uptime += frontlineinfo.lastupdatetimedelta;
    }
    else
    {
        frontlineinfo.downtime += frontlineinfo.lastupdatetimedelta;
    }
    
    updatetimedelta = ( curtime - frontlineinfo.lastupdatetime ) / 1000;
    frontlineinfo.lastupdatetime = curtime;
    frontlineinfo.lastupdatetimedelta = updatetimedelta;
    alliesaverage = getfrontlineteamcenter( "allies" );
    
    if ( !isdefined( alliesaverage ) )
    {
        return false;
    }
    
    alliesaverage = ( alliesaverage[ 0 ], alliesaverage[ 1 ], 0 );
    frontlineinfo.alliesaverage = alliesaverage;
    axisaverage = getfrontlineteamcenter( "axis" );
    
    if ( !isdefined( axisaverage ) )
    {
        return false;
    }
    
    axisaverage = ( axisaverage[ 0 ], axisaverage[ 1 ], 0 );
    frontlineinfo.axisaverage = axisaverage;
    
    if ( frontlineinfo.usinganchors )
    {
        var_e14eabe1e070c9c8 = alliesaverage - frontlineinfo.primaryanchorpos;
        var_5a95892af4420023 = vectordot( frontlineinfo.anchordir, var_e14eabe1e070c9c8 );
        projectedalliescenter = frontlineinfo.anchordir * var_5a95892af4420023 + frontlineinfo.primaryanchorpos;
        frontlineinfo.projectedalliescenter = projectedalliescenter;
        var_e14eabe1e070c9c8 = axisaverage - frontlineinfo.primaryanchorpos;
        var_26047c9c4b84b7c4 = vectordot( frontlineinfo.anchordir, var_e14eabe1e070c9c8 );
        projectedaxiscenter = frontlineinfo.anchordir * var_26047c9c4b84b7c4 + frontlineinfo.primaryanchorpos;
        frontlineinfo.projectedaxiscenter = projectedaxiscenter;
        var_f257a6c6cafa27d4 = abs( var_5a95892af4420023 - var_26047c9c4b84b7c4 );
        
        if ( var_f257a6c6cafa27d4 < 600 && isdefined( frontlineinfo.teamdiffyaw ) )
        {
            frontlineinfo.contested = 1;
        }
        else
        {
            frontlineinfo.contested = 0;
            frontlineinfo.midpoint = projectedalliescenter + ( projectedaxiscenter - projectedalliescenter ) * 0.5;
            frontlinedir = projectedaxiscenter - projectedalliescenter;
            frontlineinfo.teamdiffyaw = vectortoyaw( frontlinedir );
        }
    }
    else
    {
        var_3c847766177e2a2c = axisaverage - alliesaverage;
        var_dd247cc43dd18627 = vectortoyaw( var_3c847766177e2a2c );
        frontlineinfo.teamdiffyaw = var_dd247cc43dd18627;
        idealmidpoint = alliesaverage + var_3c847766177e2a2c * 0.5;
        frontlineinfo.midpoint = idealmidpoint;
    }
    
    var_f237c6bc0ca5c62c = anglestoforward( ( 0, frontlineinfo.teamdiffyaw, 0 ) );
    spawnpoints = level.spawnpoints;
    spawnpoints = scripts\mp\spawnscoring::checkdynamicspawns( spawnpoints );
    
    foreach ( spawnpoint in spawnpoints )
    {
        var_7e2df766bce34b1 = frontlineinfo.midpoint - spawnpoint.origin;
        dotvalue = vectordot( var_7e2df766bce34b1, var_f237c6bc0ca5c62c );
        spawnpoint.frontlineteam = ter_op( dotvalue > 0, "allies", "axis" );
    }
    
    return true;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 0
// Checksum 0x0, Offset: 0x21c2
// Size: 0x241
function updatefrontlinedebug()
{
    var_d8cce60415de6332 = isdefined( level.matchrecording_logevent ) && isdefined( level.matchrecording_generateid );
    analyticslogenabled = scripts\mp\analyticslog::analyticslogenabled();
    
    if ( !var_d8cce60415de6332 && !analyticslogenabled )
    {
        return;
    }
    
    frontlineinfo = getglobalfrontlineinfo();
    
    if ( !isdefined( frontlineinfo.logids ) && isdefined( level.matchrecording_generateid ) )
    {
        frontlineinfo.logids = [];
        frontlineinfo.logids[ "alliesCenter" ] = [[ level.matchrecording_generateid ]]();
        frontlineinfo.logids[ "axisCenter" ] = [[ level.matchrecording_generateid ]]();
    }
    
    if ( !frontlineinfo.isactive[ "allies" ] && !frontlineinfo.isactive[ "axis" ] )
    {
        return;
    }
    
    drawmidpoint = ( frontlineinfo.midpoint[ 0 ], frontlineinfo.midpoint[ 1 ], level.mapcenter[ 2 ] );
    var_4e8e12d3c7a4d029 = anglestoright( ( 0, frontlineinfo.teamdiffyaw, 0 ) );
    logfrontlinetomatchrecording( drawmidpoint, var_4e8e12d3c7a4d029, frontlineinfo.isactive[ "allies" ], frontlineinfo.isactive[ "axis" ] );
    
    if ( isdefined( level.matchrecording_logevent ) )
    {
        axisaverage = ter_op( frontlineinfo.isactive[ "axis" ], frontlineinfo.axisaverage, ( 10000, 10000, 10000 ) );
        [[ level.matchrecording_logevent ]]( frontlineinfo.logids[ "axisCenter" ], "axis", "ANCHOR", axisaverage[ 0 ], axisaverage[ 1 ], gettime() );
        alliesaverage = ter_op( frontlineinfo.isactive[ "allies" ], frontlineinfo.alliesaverage, ( 10000, 10000, 10000 ) );
        [[ level.matchrecording_logevent ]]( frontlineinfo.logids[ "alliesCenter" ], "allies", "ANCHOR", alliesaverage[ 0 ], alliesaverage[ 1 ], gettime() );
    }
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 4
// Checksum 0x0, Offset: 0x240b
// Size: 0xd7
function logfrontlinetomatchrecording( midpoint, direction, var_f3c3c5c8db76b4f0, var_dbbd5b5e90b7c2eb )
{
    if ( isdefined( level.matchrecording_logevent ) )
    {
        var_26eef3c170b9e66 = midpoint + direction * 5000;
        var_26eee3c170b9c33 = midpoint - direction * 5000;
        
        if ( !isdefined( level.matchrecording_frontlinelogid ) )
        {
            level.matchrecording_frontlinelogid = [[ level.matchrecording_generateid ]]();
        }
        
        frontlinetag = undefined;
        
        if ( var_f3c3c5c8db76b4f0 && var_dbbd5b5e90b7c2eb )
        {
            frontlinetag = "FRONT_LINE";
        }
        else
        {
            frontlinetag = ter_op( var_f3c3c5c8db76b4f0, "FRONT_LINE_ALLIES", "FRONT_LINE_AXIS" );
        }
        
        [[ level.matchrecording_logevent ]]( level.matchrecording_frontlinelogid, "allies", frontlinetag, var_26eef3c170b9e66[ 0 ], var_26eef3c170b9e66[ 1 ], gettime(), undefined, var_26eee3c170b9c33[ 0 ], var_26eee3c170b9c33[ 1 ] );
    }
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x24ea
// Size: 0xba
function getfrontlineteamcenter( team )
{
    players = [];
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        if ( !player val::get( "player_for_spawn_logic" ) )
        {
            continue;
        }
        
        if ( player.team == team )
        {
            players[ players.size ] = player;
        }
    }
    
    if ( players.size == 0 )
    {
        return undefined;
    }
    
    playersorigin = getaverageorigin( players );
    return playersorigin;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x25ad
// Size: 0x1be
function runfrontlinespawntrapchecks( team )
{
    if ( !currentspawnlogicsupportsfrontline() )
    {
        return;
    }
    
    frontlineinfo = getglobalfrontlineinfo();
    frontlineinfo.isactive[ team ] = 1;
    
    if ( getdvarint( @"hash_db79f8163bfa1586" ) == 0 )
    {
        return;
    }
    
    var_a0417b1dddc7acd3 = getdvarint( @"hash_30fb9fe7456a83a4", 0 );
    
    if ( var_a0417b1dddc7acd3 == 0 )
    {
        var_a0417b1dddc7acd3 = 4;
    }
    
    enemyteam = getotherteam( team )[ 0 ];
    var_7efd0c35c23e92b4 = 0;
    spawnpoints = level.spawnpoints;
    spawnpoints = scripts\mp\spawnscoring::checkdynamicspawns( spawnpoints );
    
    foreach ( spawnpoint in spawnpoints )
    {
        if ( !isdefined( spawnpoint.frontlineteam ) || spawnpoint.frontlineteam != team )
        {
            continue;
        }
        
        assert( spawnpoint.hassightdata[ enemyteam ] );
        
        if ( !isdefined( spawnpoint.fullsights ) || !isdefined( spawnpoint.fullsights[ enemyteam ] ) || spawnpoint.fullsights[ enemyteam ] <= 0 )
        {
            var_7efd0c35c23e92b4++;
        }
    }
    
    var_4a40d7aea77d0271 = var_7efd0c35c23e92b4 / spawnpoints.size;
    
    if ( var_7efd0c35c23e92b4 < var_a0417b1dddc7acd3 || var_4a40d7aea77d0271 < 0 )
    {
        if ( var_7efd0c35c23e92b4 < var_a0417b1dddc7acd3 )
        {
            frontlineinfo.disabledreason[ team ] = 0;
        }
        else
        {
            frontlineinfo.disabledreason[ team ] = 1;
        }
        
        frontlineinfo.isactive[ team ] = 0;
    }
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 0
// Checksum 0x0, Offset: 0x2773
// Size: 0x2a, Type: bool
function currentspawnlogicsupportsfrontline()
{
    return istrue( level.spawnglobals.frontlinelogictypes[ level.spawnglobals.activespawnlogic ] );
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 0
// Checksum 0x0, Offset: 0x27a6
// Size: 0xcd
function getglobalfrontlineinfo()
{
    if ( !isdefined( level.frontlineinfo ) )
    {
        level.frontlineinfo = spawnstruct();
        level.frontlineinfo.isactive = [];
        level.frontlineinfo.isactive[ "allies" ] = 0;
        level.frontlineinfo.isactive[ "axis" ] = 0;
        level.frontlineinfo.uptime = 0;
        level.frontlineinfo.downtime = 0;
        level.frontlineinfo.contested = 0;
        level.frontlineinfo.usinganchors = 0;
    }
    
    return level.frontlineinfo;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 0
// Checksum 0x0, Offset: 0x287c
// Size: 0x14
function function_553abfcde517c264()
{
    level.var_60744cb47838daf6 = [];
    thread function_6328cd243fe96f6c();
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 3
// Checksum 0x0, Offset: 0x2898
// Size: 0x108
function function_967517826971b87f( position, radius, type )
{
    if ( !isdefined( level.var_60744cb47838daf6 ) )
    {
        level.var_60744cb47838daf6 = [];
    }
    
    var_2396da311448b548 = spawnstruct();
    var_2396da311448b548.pos = position;
    var_2396da311448b548.radius = radius;
    var_2396da311448b548.type = type;
    var_2396da311448b548.team = "neutral";
    var_2396da311448b548.handle = function_2dcf06bab77a9b87( var_2396da311448b548.pos, var_2396da311448b548.radius, var_2396da311448b548.team, var_2396da311448b548.type );
    
    if ( var_2396da311448b548.handle >= 0 )
    {
        level.var_60744cb47838daf6 = array_add( level.var_60744cb47838daf6, var_2396da311448b548 );
        
        if ( isdefined( level.var_62fd57cfce2e0cb8 ) )
        {
            var_2396da311448b548 [[ level.var_62fd57cfce2e0cb8 ]]();
        }
        
        return var_2396da311448b548.handle;
    }
    
    return undefined;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 0
// Checksum 0x0, Offset: 0x29a9
// Size: 0x69
function function_6328cd243fe96f6c()
{
    /#
        level endon( "<dev string:x1e7>" );
        
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_82f29ce44e7e2de6", 0 ) > 0 )
            {
                function_967517826971b87f( level.players[ 0 ].origin, 100, getdvarint( @"hash_82f29ce44e7e2de6", 0 ) - 1 );
                setdvar( @"hash_82f29ce44e7e2de6", 0 );
            }
        }
    #/
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x2a1a
// Size: 0xae
function function_847f7e218feb35bb( spawnpoint )
{
    assert( spawnpoint.hasdistdata );
    
    if ( spawnpoint.totalplayers[ self.team ] == 0 )
    {
        return 0;
    }
    
    allyaveragedist = spawnpoint.distsumsquared[ self.team ] / spawnpoint.totalplayers[ self.team ];
    allyaveragedist = min( allyaveragedist, 3240000 );
    spawnpoint.analytics.allyaveragedist = allyaveragedist;
    scoringpercentage = 1 - allyaveragedist / 3240000;
    return scoringpercentage * 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x2ad1
// Size: 0x62
function function_e308442afd51b334( spawnpoint )
{
    assert( spawnpoint.hasdistdata );
    allydist = min( spawnpoint.mindistsquared[ self.team ], 3240000 );
    scoringpercentage = 1 - allydist / 3240000;
    return scoringpercentage * 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x2b3c
// Size: 0x1e1
function function_e495981bf91ab716( spawnpoint )
{
    enemyteams = [];
    var_ad5a67fe096d8b1 = [];
    assert( spawnpoint.hasdistdata );
    
    if ( level.teambased )
    {
        enemyteams[ 0 ] = getenemyteams( self.team )[ 0 ];
    }
    else
    {
        enemyteams[ enemyteams.size ] = "all";
    }
    
    foreach ( enemyteam in enemyteams )
    {
        if ( spawnpoint.totalplayers[ enemyteam ] == 0 )
        {
            continue;
        }
        
        var_ad5a67fe096d8b1[ var_ad5a67fe096d8b1.size ] = enemyteam;
    }
    
    if ( var_ad5a67fe096d8b1.size == 0 )
    {
        return 100;
    }
    
    foreach ( enemyteam in var_ad5a67fe096d8b1 )
    {
        if ( spawnpoint.mindistsquared[ enemyteam ] < 250000 )
        {
            return 0;
        }
    }
    
    totaldistance = 0;
    totalenemies = 0;
    
    foreach ( enemyteam in var_ad5a67fe096d8b1 )
    {
        totaldistance += spawnpoint.distsumsquaredcapped[ enemyteam ];
        totalenemies += spawnpoint.totalplayers[ enemyteam ];
    }
    
    var_42e18c11c58f15f1 = totaldistance / totalenemies;
    var_42e18c11c58f15f1 = min( var_42e18c11c58f15f1, 7290000 );
    scoringpercentage = var_42e18c11c58f15f1 / 7290000;
    spawnpoint.analytics.enemyaveragedist = var_42e18c11c58f15f1;
    return scoringpercentage * 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x2d26
// Size: 0x73
function function_255be0a9b59dfc89( spawnpoint )
{
    assert( spawnpoint.hasdistdata );
    enemyteam = undefined;
    
    if ( level.teambased )
    {
        enemyteam = getenemyteams( self.team )[ 0 ];
    }
    else
    {
        enemyteam = "all";
    }
    
    if ( spawnpoint.mindistsquared[ enemyteam ] < level.enemyspawninfluencedistsq )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x2da2
// Size: 0x171
function function_2d8badc9970dc4bf( spawnpoint )
{
    assert( spawnpoint.hasdistdata );
    enemyteams = [];
    var_ad5a67fe096d8b1 = [];
    
    if ( level.teambased )
    {
        enemyteams[ 0 ] = getenemyteams( self.team )[ 0 ];
    }
    else
    {
        enemyteams[ enemyteams.size ] = "all";
    }
    
    foreach ( enemyteam in enemyteams )
    {
        if ( spawnpoint.totalplayers[ enemyteam ] == 0 )
        {
            continue;
        }
        
        var_ad5a67fe096d8b1[ var_ad5a67fe096d8b1.size ] = enemyteam;
    }
    
    if ( var_ad5a67fe096d8b1.size == 0 )
    {
        return 100;
    }
    
    scoretotal = 0;
    
    foreach ( enemyteam in var_ad5a67fe096d8b1 )
    {
        if ( spawnpoint.mindistsquared[ enemyteam ] < 250000 )
        {
            return 0;
        }
        
        minenemydistsquared = min( spawnpoint.mindistsquared[ enemyteam ], 3240000 );
        scoringpercentage = minenemydistsquared / 3240000;
        scoretotal += scoringpercentage * 100;
    }
    
    return scoretotal / var_ad5a67fe096d8b1.size;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x2f1c
// Size: 0x12b
function avoidclosestenemybydistance( spawnpoint )
{
    enemyinfluencedistsq = level.spawnglobals.activespawncontext.factorparams[ #"closestenemyinfluencedistsq" ];
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = getenemyteams( self.team )[ 0 ];
    }
    
    closestdist = 0;
    
    foreach ( enemy in level.teamdata[ enemyteam ][ "players" ] )
    {
        distsq = distancesquared( spawnpoint.origin, enemy.origin );
        
        if ( distsq < closestdist )
        {
            closestdist = distsq;
        }
    }
    
    if ( closestdist < 250000 )
    {
        return 0;
    }
    
    minenemydistsquared = min( closestdist, enemyinfluencedistsq );
    scoringpercentage = minenemydistsquared / enemyinfluencedistsq;
    return scoringpercentage * 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 2
// Checksum 0x0, Offset: 0x3050
// Size: 0x33
function function_5647d0dca50a2d4d( var_a72a53d107c0b04c, var_1e5e6e5f60f12427 )
{
    var_ba0a9fd614a3f6ee = [];
    var_ba0a9fd614a3f6ee[ "preferredDomPoints" ] = var_a72a53d107c0b04c;
    var_ba0a9fd614a3f6ee[ "secondaryDomPoints" ] = var_1e5e6e5f60f12427;
    return var_ba0a9fd614a3f6ee;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x308c
// Size: 0xb8
function preferdompoints( spawnpoint )
{
    preferreddompoints = level.spawnglobals.activespawncontext.factorparams[ "preferredDomPoints" ];
    secondarydompoints = level.spawnglobals.activespawncontext.factorparams[ "secondaryDomPoints" ];
    scriptdata = spawnpoint.scriptdata;
    
    if ( isdefined( scriptdata.domflagassignments ) )
    {
        if ( scriptdata.domflagassignments & preferreddompoints )
        {
            return 100;
        }
        else if ( scriptdata.domflagassignments & secondarydompoints )
        {
            return 50;
        }
    }
    
    return 0;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x314d
// Size: 0x86
function preferclosepoints( spawnpoint )
{
    closestpoints = level.spawnglobals.activespawncontext.factorparams[ "closestPoints" ];
    
    foreach ( point in closestpoints )
    {
        if ( spawnpoint == point )
        {
            return 100;
        }
    }
    
    return 0;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 2
// Checksum 0x0, Offset: 0x31dc
// Size: 0x37
function function_c7a9633168e5110( spawnpoint, team )
{
    if ( isdefined( spawnpoint.teambase ) && spawnpoint.teambase == team )
    {
        return 100;
    }
    
    return 0;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x321c
// Size: 0xba
function function_dc410c59b390813b( spawnpoint )
{
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = getenemyteams( self.team )[ 0 ];
    }
    
    assert( spawnpoint.hassightdata[ enemyteam ] );
    sightfraction = 1 - spawnpoint.maxsightvalue[ enemyteam ];
    var_cd9f4a27303d749e = scripts\mp\spawnlogic::getmaxdistancetolos();
    distancetolos = sightfraction * var_cd9f4a27303d749e;
    
    if ( distancetolos > 1200 )
    {
        scorepercent = ( var_cd9f4a27303d749e - distancetolos ) / ( var_cd9f4a27303d749e - 1200 );
        return ( 100 * scorepercent );
    }
    
    scorepercent = distancetolos / 1200;
    return 100 * scorepercent;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x32de
// Size: 0x93
function function_ce101e91e4df4ca9( spawnpoint )
{
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = getenemyteams( self.team )[ 0 ];
    }
    
    assert( spawnpoint.hassightdata[ enemyteam ] );
    sightfraction = 1 - spawnpoint.maxsightvalue[ enemyteam ];
    spawnpoint.analytics.maxenemysightfraction = sightfraction;
    return ( 1 - sightfraction ) * 0 + sightfraction * 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x337a
// Size: 0x93
function function_52c5a5db586622c5( spawnpoint )
{
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = getenemyteams( self.team )[ 0 ];
    }
    
    assert( spawnpoint.hassightdata[ enemyteam ] );
    sightfraction = 1 - spawnpoint.maxjumpsightvalue[ enemyteam ];
    spawnpoint.analytics.maxjumpingenemysightfraction = sightfraction;
    return ( 1 - sightfraction ) * 0 + sightfraction * 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x3416
// Size: 0x90
function function_1bd88f01ef678809( spawnpoint )
{
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = getenemyteams( self.team )[ 0 ];
    }
    
    assert( spawnpoint.hassightdata[ enemyteam ] );
    sightfraction = 1 - spawnpoint.maxjumpsightvalue[ enemyteam ];
    var_6d87052f9222032e = sightfraction * scripts\mp\spawnlogic::getmaxdistancetolos();
    
    if ( var_6d87052f9222032e < 300 )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x34ae
// Size: 0x3e
function randomspawnscore( spawnpoint )
{
    spawnpoint.analytics.randomscore = randomintrange( 0, 99 );
    return spawnpoint.analytics.randomscore;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x34f5
// Size: 0x10
function maxplayerspawninfluencedistsquared( spawnpoint )
{
    return 3240000;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 4
// Checksum 0x0, Offset: 0x350e
// Size: 0x65
function function_75c03ed937b75b22( entitynum, var_38331ab92460d731, deadzonedistsq, closestenemyinfluencedistsq )
{
    var_ba0a9fd614a3f6ee = [];
    var_ba0a9fd614a3f6ee[ #"hash_80b230f7f3b6e958" ] = entitynum;
    var_ba0a9fd614a3f6ee[ #"hash_ff12ea926c094dde" ] = var_38331ab92460d731;
    var_ba0a9fd614a3f6ee[ #"hash_ccf425b826e8654b" ] = deadzonedistsq;
    var_ba0a9fd614a3f6ee[ #"closestenemyinfluencedistsq" ] = closestenemyinfluencedistsq;
    return var_ba0a9fd614a3f6ee;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x357c
// Size: 0xa2
function prefershortestdisttozone( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    var_653a7e504d42846a = spawncontext.factorparams[ #"hash_80b230f7f3b6e958" ];
    distsq = spawnpoint.scriptdata.var_c7e3d9e2f0dd4e7[ var_653a7e504d42846a ];
    maxdistancesquared = spawncontext.factorparams[ #"hash_ff12ea926c094dde" ];
    percent = 1 - distsq / maxdistancesquared;
    return 100 * percent + 0;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x3627
// Size: 0x95
function avoidclosetozone( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    var_653a7e504d42846a = spawncontext.factorparams[ #"hash_80b230f7f3b6e958" ];
    distsq = spawnpoint.scriptdata.var_c7e3d9e2f0dd4e7[ var_653a7e504d42846a ];
    deadzonedistsq = spawncontext.factorparams[ #"hash_ccf425b826e8654b" ];
    return ter_op( distsq < deadzonedistsq, 0, 100 );
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x36c5
// Size: 0x8f
function function_82fb03c7e6eddf4f( spawnpoint )
{
    lastteamspawnpoint = level.spawnglobals.lastteamspawnpoints[ self.team ];
    
    if ( !isdefined( lastteamspawnpoint ) )
    {
        return 0;
    }
    
    distsq = distancesquared( lastteamspawnpoint.origin, spawnpoint.origin );
    distsq = int( min( distsq, 9000000 ) );
    percent = 1 - distsq / 9000000;
    return 100 * percent + 0;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x375d
// Size: 0x164
function function_1c2a13eb67207b15( spawnpoint )
{
    spawnglobals = level.spawnglobals;
    assert( isdefined( spawnglobals.hasclusterdata ) );
    assert( isdefined( spawnglobals.teamclusters ) && isdefined( spawnglobals.teamclusters[ self.team ] ) );
    var_8471c2246452276d = -1;
    
    foreach ( cluster in spawnglobals.teamclusters[ self.team ].clusterlist )
    {
        if ( cluster.players.size <= 1 )
        {
            continue;
        }
        
        distsq = distance2dsquared( cluster.center, spawnpoint.origin );
        
        if ( var_8471c2246452276d < 0 || distsq < var_8471c2246452276d )
        {
            var_8471c2246452276d = distsq;
        }
    }
    
    if ( var_8471c2246452276d < 0 )
    {
        return 0;
    }
    
    if ( var_8471c2246452276d < 10000 )
    {
        return 100;
    }
    
    var_8471c2246452276d = int( min( var_8471c2246452276d, 9000000 ) );
    percent = 1 - ( var_8471c2246452276d - 10000 ) / ( 9000000 - 10000 );
    return 100 * percent + 0;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x38ca
// Size: 0xc6
function function_f450413956d6d6c4( spawnpoint )
{
    spawnglobals = level.spawnglobals;
    assert( isdefined( spawnglobals.haslanedata ) );
    assert( isdefined( spawnglobals.occupiedlanemasks ) );
    assert( isdefined( spawnpoint.lanemask ) );
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = getenemyteams( self.team )[ 0 ];
    }
    
    if ( !isdefined( spawnglobals.occupiedlanemasks[ enemyteam ] ) )
    {
        return 0;
    }
    
    if ( ( spawnpoint.lanemask & spawnglobals.occupiedlanemasks[ enemyteam ] ) != 0 )
    {
        return 100;
    }
    
    return 0;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x3998
// Size: 0x112
function function_d20f88ca67f03009( spawnpoint )
{
    spawnglobals = level.spawnglobals;
    assert( isdefined( spawnglobals.haslanedata ) );
    assert( isdefined( spawnglobals.occupiedlanemasks ) );
    assert( isdefined( spawnpoint.lanemask ) );
    friendlyteam = scripts\mp\spawnlogic::getspawnteam( self );
    enemyteam = "all";
    
    if ( level.teambased )
    {
        enemyteam = getenemyteams( friendlyteam )[ 0 ];
    }
    
    if ( !isdefined( spawnglobals.occupiedlanemasks[ enemyteam ] ) )
    {
        return 0;
    }
    
    var_e5c11a1b96be1d3c = spawnpoint.lanemask & spawnglobals.occupiedlanemasks[ enemyteam ];
    var_5e132bcebfcc07b2 = isdefined( spawnglobals.occupiedlanemasks[ friendlyteam ] ) && spawnpoint.lanemask & spawnglobals.occupiedlanemasks[ friendlyteam ];
    
    if ( var_e5c11a1b96be1d3c && !var_5e132bcebfcc07b2 )
    {
        return 100;
    }
    
    return 0;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x3ab2
// Size: 0xc, Type: bool
function scriptonlytest( spawnpoint )
{
    return false;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x3ac7
// Size: 0xfe
function prefernearsinglepoint( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    pointpos = spawncontext.factorparams[ "singlePointPos" ];
    mindistsq = spawncontext.factorparams[ "minDistToSinglePointSq" ];
    maxdistsq = spawncontext.factorparams[ "maxDistToSinglePointSq" ];
    var_9e3a315d4f55afc6 = spawncontext.factorparams[ "distRangeToSinglePointSq" ];
    assert( var_9e3a315d4f55afc6 + 0.1 <= maxdistsq - mindistsq && var_9e3a315d4f55afc6 - 0.1 >= maxdistsq - mindistsq );
    distsq = distance2dsquared( pointpos, spawnpoint.origin );
    
    if ( distsq >= maxdistsq )
    {
        return 0;
    }
    
    if ( distsq <= mindistsq )
    {
        return 100;
    }
    
    scorepercent = 1 - ( distsq - mindistsq ) / var_9e3a315d4f55afc6;
    return 100 * scorepercent;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x3bce
// Size: 0x5f
function avoidcurrentspawntraps( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    combo = function_b9e20b2afd68e3c1( spawnpoint, spawncontext.team );
    pointratio = pow( 0.25, combo );
    return 100 * pointratio;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x3c36
// Size: 0x22
function function_32368b70c6aa5729( spawnpoint )
{
    spawnpoint.scriptdata.var_1a11950b5795681f = [];
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 3
// Checksum 0x0, Offset: 0x3c60
// Size: 0xa6
function function_158cc75a8c974987( player, callbackparams, attacker )
{
    if ( isdefined( player.var_edfdb2994e4d6040 ) )
    {
        return;
    }
    
    if ( isdefined( attacker ) && issentient( attacker ) && !player player_utility::isenemy( attacker ) )
    {
        return;
    }
    
    if ( gettime() - player.lastspawntime > function_a0a31e5b8e6a394d() )
    {
        return;
    }
    
    if ( isdefined( player.lastspawnpoint ) )
    {
        player.var_edfdb2994e4d6040 = player.lastspawnpoint;
        function_fac896d21fc67e84( player.lastspawnpoint, player.team );
    }
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 2
// Checksum 0x0, Offset: 0x3d0e
// Size: 0x121
function function_fac896d21fc67e84( spawnpoint, team )
{
    currenttimems = gettime();
    
    if ( !istrue( level.teambased ) )
    {
        team = "none";
    }
    
    if ( istrue( level.var_393b1c3af005496e ) )
    {
        return;
    }
    
    scriptdata = level.spawnglobals.spawnpointscriptdata[ spawnpoint.index ];
    combostruct = default_to( scriptdata.var_1a11950b5795681f[ team ], undefined );
    
    if ( !isdefined( combostruct ) )
    {
        combostruct = spawnstruct();
        combostruct.starttimems = currenttimems;
        combostruct.var_3b5af4bbbc57de2b = currenttimems;
        combostruct.trapcount = 1;
        scriptdata.var_1a11950b5795681f[ team ] = combostruct;
        return;
    }
    
    if ( currenttimems - combostruct.var_3b5af4bbbc57de2b > function_513d4a1188d51465() )
    {
        combostruct.starttimems = currenttimems;
        combostruct.trapcount = 1;
    }
    else
    {
        combostruct.trapcount++;
    }
    
    combostruct.var_3b5af4bbbc57de2b = currenttimems;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 2
// Checksum 0x0, Offset: 0x3e37
// Size: 0xa8
function function_b9e20b2afd68e3c1( spawnpoint, team )
{
    currenttimems = gettime();
    
    if ( !istrue( level.teambased ) )
    {
        team = "none";
    }
    
    scriptdata = level.spawnglobals.spawnpointscriptdata[ spawnpoint.index ];
    combostruct = default_to( scriptdata.var_1a11950b5795681f[ team ], undefined );
    
    if ( isdefined( combostruct ) )
    {
        if ( currenttimems - combostruct.var_3b5af4bbbc57de2b < function_513d4a1188d51465() )
        {
            return combostruct.trapcount;
        }
    }
    
    return 0;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 0
// Checksum 0x0, Offset: 0x3ee8
// Size: 0x3c
function function_a0a31e5b8e6a394d()
{
    timems = 2000;
    dvaroverride = getdvarfloat( @"hash_851a3f508adcd1dd", -1 );
    
    if ( dvaroverride > 0 )
    {
        timems = dvaroverride * 1000;
    }
    
    return timems;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 0
// Checksum 0x0, Offset: 0x3f2d
// Size: 0x3c
function function_513d4a1188d51465()
{
    timems = 6000;
    dvaroverride = getdvarfloat( @"hash_3b2062ace30035", -1 );
    
    if ( dvaroverride > 0 )
    {
        timems = dvaroverride * 1000;
    }
    
    return timems;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x3f72
// Size: 0xa0
function avoidrugbyoffsides( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    juggpos = spawncontext.factorparams[ "juggPos" ];
    fielddir2d = spawncontext.factorparams[ "rugbyFieldDir2D" ];
    var_9c6453d1f660c3dc = ( spawnpoint.origin - juggpos ) * ( 1, 1, 0 );
    dot = vectordot( var_9c6453d1f660c3dc, fielddir2d );
    
    if ( dot >= 0 )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x401b
// Size: 0x39
function oneusespawns( spawnpoint )
{
    scriptdata = spawnpoint.scriptdata;
    
    if ( istrue( scriptdata.used ) )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 2
// Checksum 0x0, Offset: 0x405c
// Size: 0x99
function avoidclosetodefenderflag( spawnpoint, paramlist )
{
    var_cc1acf45d269a8ac = undefined;
    var_eb28d9f8d5a7784d = paramlist[ "activeCarrierPosition" ];
    var_c48319e73068aa11 = paramlist[ "defenderFlagPosition" ];
    deadzonedistsq = paramlist[ "avoidDefenderFlagDeadZoneDistSq" ];
    
    if ( isdefined( var_eb28d9f8d5a7784d ) )
    {
        var_cc1acf45d269a8ac = var_eb28d9f8d5a7784d;
    }
    else if ( isdefined( var_c48319e73068aa11 ) )
    {
        var_cc1acf45d269a8ac = var_c48319e73068aa11;
    }
    
    if ( isdefined( var_cc1acf45d269a8ac ) )
    {
        distsquared = distancesquared( var_cc1acf45d269a8ac, spawnpoint.origin );
        return ter_op( distsquared < deadzonedistsq, 0, 100 );
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 2
// Checksum 0x0, Offset: 0x40fd
// Size: 0x51
function avoidclosetodefenderflagspawn( spawnpoint, paramlist )
{
    distsq = spawnpoint.scriptdata.distsqtodefenderfalgstart;
    deadzonedistsq = paramlist[ "avoidDefenderFlagDeadZoneDistSq" ];
    return ter_op( distsq < deadzonedistsq, 0, 100 );
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x4157
// Size: 0xb8
function avoidfrontlineoffsides( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    
    if ( !isdefined( spawncontext.factorparams ) || !isdefined( level.frontlinedata ) )
    {
        return 100;
    }
    
    teamforward = spawncontext.factorparams[ "teamForward" ];
    frontlinepoint = scripts\mp\gametypes\gwtdm::function_8964b48e4eba5797( spawnpoint.origin );
    tospawn = vectornormalize( spawnpoint.origin - frontlinepoint );
    dot = vectordot( tospawn, teamforward );
    
    if ( dot >= 0 )
    {
        return 0;
    }
    
    return 100;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x4218
// Size: 0xb0
function preferoptimalfrontlinedist( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    
    if ( !isdefined( spawncontext.factorparams ) || !isdefined( level.frontlinedata ) )
    {
        return 100;
    }
    
    idealdistsq = spawncontext.factorparams[ "idealDistSq" ];
    var_f6f8270f02b2b9bf = scripts\mp\gametypes\gwtdm::function_99146672ec896efa( spawnpoint.origin );
    percent = clamp( 1 - abs( var_f6f8270f02b2b9bf - idealdistsq ) / idealdistsq, 0, 1 );
    return 100 * percent + 0;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1
// Checksum 0x0, Offset: 0x42d1
// Size: 0x85
function preferunoccupiedlanes( spawnpoint )
{
    spawncontext = level.spawnglobals.activespawncontext;
    maxdistancesquared = 67108864;
    var_f6f8270f02b2b9bf = scripts\mp\gametypes\gwtdm::function_7855eb28c2d21061( spawnpoint.origin, self.team );
    percent = clamp( 1 - var_f6f8270f02b2b9bf / maxdistancesquared, 0, 1 );
    return 100 * percent + 0;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x435f
// Size: 0x15
function private on_player_spawned( params )
{
    self.var_edfdb2994e4d6040 = undefined;
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x437c
// Size: 0x1f
function private on_player_death( params )
{
    function_158cc75a8c974987( self, params, params.attacker );
}

// Namespace spawnfactor / scripts\mp\spawnfactor
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x43a3
// Size: 0x1f
function private on_player_damaged( params )
{
    function_158cc75a8c974987( self, params, params.eattacker );
}

