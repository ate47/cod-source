#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_util;
#using scripts\mp\loot;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace br_supply_drops_common;

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 0
// Checksum 0x0, Offset: 0x3df
// Size: 0xa7
function init()
{
    level notify( "br_supply_drops_init" );
    level.var_5d2af95280a3cf58 = getdvarint( @"hash_b2f1a70335c6a20b", 17250 );
    level.var_f13b219a6cb9496 = [ "onFirstDrop", "generateFlightPath", "supplyDropFall", "planeDropRun", "spawnDropCrate", "onDropSpawned", "onPlayerEnterGulag", "onPlayerRespawn" ];
    cratedata = scripts\cp_mp\killstreaks\airdrop::getleveldata( "br_supply_drops_common" );
    cratedata.hasnointeraction = 1;
    
    /#
        level thread function_5691429fc16cddc2();
    #/
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 4
// Checksum 0x0, Offset: 0x48e
// Size: 0x238
function function_69b2e5235bfb7998( name, cratemodel, var_b55272982c57a2ce, onopenfunc )
{
    if ( !isdefined( level.supplydroptypes ) )
    {
        level.supplydroptypes = [];
    }
    
    assertex( !isdefined( level.supplydroptypes[ name ] ), "<dev string:x1c>" );
    level.supplydroptypes[ name ] = spawnstruct();
    level.supplydroptypes[ name ].cratemodel = cratemodel;
    level.supplydroptypes[ name ].funcs = [];
    level.supplydroptypes[ name ].planemodel = "veh9_mil_air_cargo_plane_wm";
    level.supplydroptypes[ name ].bufferpercent = getdvarint( @"hash_c5003af4e1ec5349", 0.3 );
    level.supplydroptypes[ name ].checktimer = getdvarint( @"hash_b35f53a26ed16372", 5 );
    level.supplydroptypes[ name ].var_2e0d8ba0a46ce1b1 = getdvarint( @"hash_9604835948da8a54", 3 );
    level.supplydroptypes[ name ].userate = getdvarint( @"hash_b995fd166e3ec5b0", 1 );
    level.supplydroptypes[ name ].usetime = getdvarint( @"hash_b663c9a86f4ca8e3", 4 );
    level.supplydroptypes[ name ].name = name;
    
    if ( !istrue( var_b55272982c57a2ce ) )
    {
        level.supplydroptypes[ name ].funcs[ "generateFlightPath" ] = &function_4a7c28606a956f8d;
        level.supplydroptypes[ name ].funcs[ "supplyDropFall" ] = &function_7dec3b199d2e73b8;
        level.supplydroptypes[ name ].funcs[ "planeDropRun" ] = &function_8862805d448b58d4;
        level.supplydroptypes[ name ].funcs[ "spawnDropCrate" ] = &function_52f17e5fbec318a6;
        level.supplydroptypes[ name ].funcs[ "onOpenFunc" ] = onopenfunc;
    }
    
    return level.supplydroptypes[ name ];
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 3
// Checksum 0x0, Offset: 0x6cf
// Size: 0x6c
function function_80e49e34fc8d70b8( name, funcname, func )
{
    assertex( isdefined( level.supplydroptypes[ name ] ), "<dev string:x57>" );
    assertex( array_contains( level.var_f13b219a6cb9496, funcname ), "<dev string:x9c>" );
    level.supplydroptypes[ name ].funcs[ funcname ] = func;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 2
// Checksum 0x0, Offset: 0x743
// Size: 0x5f
function function_4b941a30db41d07e( container, opener )
{
    if ( isdefined( container.entity.smokesignal ) && scripts\mp\loot::iscontainerempty( container, opener ) )
    {
        container.entity.smokesignal setscriptablepartstate( "smoke_signal", "off", 1 );
    }
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 0
// Checksum 0x0, Offset: 0x7aa
// Size: 0x193
function function_5691429fc16cddc2()
{
    /#
        level thread function_d1044a7030f099f9();
    #/
    
    while ( true )
    {
        wait 2;
        
        if ( getdvar( @"hash_26efc86d59cbd50e", "" ) != "" )
        {
            function_1241afbfb2cfed35( level.players[ 0 ].origin, getdvar( @"hash_26efc86d59cbd50e", "" ) );
            setdvar( @"hash_26efc86d59cbd50e", "" );
        }
        
        if ( getdvar( @"hash_c3236a6c15b391d3", "" ) != "" )
        {
            function_1a01863a6ec2ad05( level.players[ 0 ].origin, getdvar( @"hash_c3236a6c15b391d3", "" ) );
            setdvar( @"hash_c3236a6c15b391d3", "" );
        }
        
        if ( getdvar( @"hash_67245232e538d11d", "" ) != "" )
        {
            droptype = getdvar( @"hash_67245232e538d11d", "" );
            dropstruct = level.supplydroptypes[ droptype ];
            
            if ( isdefined( dropstruct ) )
            {
                dropend = level.players[ 0 ].origin;
                dropstart = ( dropend[ 0 ], dropend[ 1 ], 500 );
                crate = [[ dropstruct.funcs[ "spawnDropCrate" ] ]]( dropend, dropstruct );
            }
            
            setdvar( @"hash_67245232e538d11d", "" );
        }
    }
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 0
// Checksum 0x0, Offset: 0x945
// Size: 0x5
function function_1422ffcd34611fd1()
{
    return 3044;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 2
// Checksum 0x0, Offset: 0x953
// Size: 0x129
function function_1a01863a6ec2ad05( pos, droptype )
{
    var_a82277e7547cf269 = level.supplydroptypes[ droptype ];
    planemodel = var_a82277e7547cf269.planemodel;
    pathstruct = [[ var_a82277e7547cf269.funcs[ "generateFlightPath" ] ]]( pos, var_a82277e7547cf269 );
    dist = distance( pathstruct.startpt, pathstruct.endpt );
    travelspeed = function_1422ffcd34611fd1();
    time = dist / travelspeed;
    plane = function_2496cdd7babaed39( pathstruct, dist, travelspeed, time, planemodel );
    println( "<dev string:xd9>" );
    plane setscriptablepartstate( "audio_loop", "on", 0 );
    plane setscriptablepartstate( "objective", "active_yellow", 0 );
    plane moveto( plane.endpt, plane.lifetime );
    plane thread [[ var_a82277e7547cf269.funcs[ "planeDropRun" ] ]]( var_a82277e7547cf269 );
    plane thread function_6cc331348e2faa9a();
    return plane;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 2
// Checksum 0x0, Offset: 0xa85
// Size: 0x47
function function_1241afbfb2cfed35( pos, droptype )
{
    dropstruct = level.supplydroptypes[ droptype ];
    crate = function_98e40becf6aae51f( pos, dropstruct );
    level.recentsupplydrop = crate;
    return crate;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 1
// Checksum 0x0, Offset: 0xad5
// Size: 0x113
function function_8862805d448b58d4( dropstruct )
{
    self endon( "death" );
    var_bd693dcf6bece704 = self.lifetime;
    var_11f20c6978f7d6a6 = var_bd693dcf6bece704 * dropstruct.bufferpercent;
    numcrates = 0;
    wait var_11f20c6978f7d6a6;
    
    while ( numcrates < dropstruct.var_2e0d8ba0a46ce1b1 )
    {
        if ( dropstruct.checktimer < var_bd693dcf6bece704 - var_11f20c6978f7d6a6 )
        {
            wait dropstruct.checktimer;
        }
        else
        {
            waitframe();
        }
        
        droplocation = function_95a507dc67864770( self.origin + anglestoforward( self.angles ) * 500 );
        
        if ( !isdefined( droplocation ) )
        {
            if ( istrue( dropstruct.var_5214bb02998ff284 ) )
            {
                numcrates++;
            }
            
            continue;
        }
        
        crate = function_98e40becf6aae51f( droplocation, dropstruct );
        
        if ( !isdefined( crate ) )
        {
            continue;
        }
        
        if ( numcrates == 0 && isdefined( dropstruct.funcs[ "onFirstDrop" ] ) )
        {
            [[ dropstruct.funcs[ "onFirstDrop" ] ]]();
        }
        
        numcrates++;
    }
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 1
// Checksum 0x0, Offset: 0xbf0
// Size: 0x141
function function_c28362a9638e7931( dropstruct )
{
    level endon( "game_ended" );
    self endon( "death" );
    var_bd693dcf6bece704 = self.lifetime;
    var_11f20c6978f7d6a6 = var_bd693dcf6bece704 * dropstruct.bufferpercent;
    assertex( dropstruct.var_2e0d8ba0a46ce1b1 == 1, "<dev string:x116>" );
    var_d4dae76eac378b = ( self.centerpt[ 0 ], self.centerpt[ 1 ], level.var_5d2af95280a3cf58 );
    var_f8aae4b48dfccace = function_95a507dc67864770( var_d4dae76eac378b );
    dropstartlocation = ( var_f8aae4b48dfccace[ 0 ], var_f8aae4b48dfccace[ 1 ], level.var_5d2af95280a3cf58 );
    var_cff400c8a67610f7 = distance( self.origin, dropstartlocation );
    
    while ( true )
    {
        var_b0732ce0dde34a1f = distance( self.origin, self.startpt );
        
        if ( var_b0732ce0dde34a1f >= var_cff400c8a67610f7 )
        {
            break;
        }
        
        waitframe();
    }
    
    crate = function_98e40becf6aae51f( var_f8aae4b48dfccace, dropstruct );
    
    if ( isdefined( dropstruct.funcs[ "onFirstDrop" ] ) )
    {
        [[ dropstruct.funcs[ "onFirstDrop" ] ]]();
    }
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 2
// Checksum 0x0, Offset: 0xd39
// Size: 0x13a
function function_95a507dc67864770( starttrace, var_5ce47de2b275eec8 )
{
    droplocation = undefined;
    endtrace = starttrace - ( 0, 0, 30000 );
    ignorelist = [ self ];
    contents = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 1 );
    trace = scripts\engine\trace::ray_trace( starttrace, endtrace, ignorelist, contents );
    
    if ( isdefined( trace ) && trace[ "hittype" ] != "hittype_none" )
    {
        pos = trace[ "position" ];
        droplocation = getclosestpointonnavmesh( pos );
        var_8391900d9d61fe30 = droplocation - pos;
        var_8391900d9d61fe30 = ( var_8391900d9d61fe30[ 0 ], var_8391900d9d61fe30[ 1 ], 0 );
        maxoffset = 100;
        
        if ( length2dsquared( var_8391900d9d61fe30 ) > maxoffset * maxoffset )
        {
            var_8391900d9d61fe30 += vectornormalize( var_8391900d9d61fe30 ) * getdvarint( @"hash_ada223fd974a9d0b", maxoffset );
        }
        
        droplocation = getclosestpointonnavmesh( scripts\mp\gametypes\br_public::droptogroundmultitrace( droplocation + var_8391900d9d61fe30, 10500 ) );
    }
    
    if ( isdefined( droplocation ) && !istrue( var_5ce47de2b275eec8 ) )
    {
        validpoint = scripts\mp\gametypes\br_circle::isvalidpointinbounds( droplocation, 1 );
        
        if ( !istrue( validpoint ) )
        {
            droplocation = undefined;
        }
    }
    
    return droplocation;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 2
// Checksum 0x0, Offset: 0xe7c
// Size: 0x154
function function_4a7c28606a956f8d( centerpos, dropstruct )
{
    r = level.br_level.br_circleradii[ 0 ];
    var_821b13082f214589 = default_to( dropstruct.var_821b13082f214589, randomfloatrange( 0, 360 ) );
    planeheight = default_to( dropstruct.planeheight, level.var_5d2af95280a3cf58 );
    zheight = planeheight;
    
    if ( isdefined( dropstruct.zoffset ) )
    {
        zheight += dropstruct.zoffset;
    }
    
    toedge = ( r * cos( var_821b13082f214589 ), r * sin( var_821b13082f214589 ), zheight );
    startpt = toedge + centerpos;
    startpt = ( startpt[ 0 ], startpt[ 1 ], zheight );
    endpt = centerpos - toedge;
    endpt = ( endpt[ 0 ], endpt[ 1 ], zheight );
    pathdir = vectornormalize( endpt - startpt );
    pathstruct = spawnstruct();
    pathstruct.startpt = startpt;
    pathstruct.endpt = endpt;
    pathstruct.angle = vectortoangles( pathdir );
    pathstruct.centerpt = centerpos;
    return pathstruct;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 0
// Checksum 0x0, Offset: 0xfd9
// Size: 0xa1
function function_6cc331348e2faa9a()
{
    self endon( "death" );
    level endon( "game_ended" );
    wait max( self.lifetime - 1, 0.05 );
    self setscriptablepartstate( "audio_exit", "on", 0 );
    wait 1;
    self setscriptablepartstate( "audio_loop", "off", 0 );
    
    if ( isdefined( self.minimapid ) )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( self.minimapid );
    }
    
    if ( isdefined( self.chassis ) )
    {
        self.chassis delete();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
    
    println( "<dev string:x185>" );
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 5
// Checksum 0x0, Offset: 0x1082
// Size: 0x141
function function_2496cdd7babaed39( pathinfo, pathdist, pathspeed, pathtime, model )
{
    if ( !isdefined( model ) )
    {
        model = "veh9_mil_air_cargo_plane_wm";
    }
    
    plane = spawn( "script_model", pathinfo.startpt );
    plane setmodel( model );
    plane setcandamage( 0 );
    plane.maxhealth = 100000;
    plane.health = plane.maxhealth;
    plane.startpt = pathinfo.startpt;
    plane.endpt = pathinfo.endpt;
    plane.centerpt = pathinfo.centerpt;
    plane.dir = vectornormalize( plane.endpt - plane.startpt );
    plane.angles = vectortoangles( plane.dir );
    plane.pathdist = pathdist;
    plane.speed = pathspeed;
    plane.lifetime = pathtime;
    return plane;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 3
// Checksum 0x0, Offset: 0x11cc
// Size: 0x103
function function_52f17e5fbec318a6( dropend, dropstruct, dropstart )
{
    c130height = level.var_5d2af95280a3cf58;
    
    if ( !isdefined( dropstart ) )
    {
        dropstart = ( dropend[ 0 ], dropend[ 1 ], c130height );
    }
    
    crate = spawn( "script_model", dropstart );
    crate setmodel( dropstruct.cratemodel );
    crate.physicsactivated = 0;
    crate.isdestroyed = 0;
    crate.id = "care_package";
    crate.userate = dropstruct.userate;
    crate.curprogress = 0;
    crate.usetime = dropstruct.usetime;
    crate.onopenfunc = dropstruct.onopenfunc;
    crate.supportsreroll = 0;
    crate.cratetype = "br_supply_drops_common";
    return crate;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 2
// Checksum 0x0, Offset: 0x12d8
// Size: 0x12d
function function_98e40becf6aae51f( dropend, dropstruct )
{
    crate = undefined;
    
    if ( isdefined( dropstruct.funcs[ "spawnDropCrate" ] ) )
    {
        crate = [[ dropstruct.funcs[ "spawnDropCrate" ] ]]( dropend, dropstruct );
    }
    
    if ( isdefined( crate ) )
    {
        crate.skipminimapicon = 1;
        
        if ( !istrue( crate.nochute ) )
        {
            chute = spawn( "script_model", crate.origin );
            chute.angles = crate.angles;
            chute setmodel( "veh9_mil_lnd_parachute_carepackage_br" );
            crate.chute = chute;
            crate.var_c23ca3472233553d = 1;
            chute linkto( crate );
        }
        
        if ( isdefined( dropstruct.funcs[ "onDropSpawned" ] ) )
        {
            crate thread [[ dropstruct.funcs[ "onDropSpawned" ] ]]( dropend );
        }
        
        if ( isdefined( dropstruct.funcs[ "supplyDropFall" ] ) )
        {
            crate thread [[ dropstruct.funcs[ "supplyDropFall" ] ]]( dropend, dropstruct );
        }
    }
    
    return crate;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 2
// Checksum 0x0, Offset: 0x140e
// Size: 0x33c
function function_7dec3b199d2e73b8( point, dropstruct )
{
    self endon( "death" );
    var_81986b2d8e843970 = ter_op( isdefined( dropstruct.var_81986b2d8e843970 ), dropstruct.var_81986b2d8e843970, 10000000 );
    initialmove = ter_op( isdefined( dropstruct.initialmove ), dropstruct.initialmove, 1000 );
    spawnsmoke = ter_op( isdefined( dropstruct.spawnsmoke ), dropstruct.spawnsmoke, 1 );
    
    if ( initialmove > 0 )
    {
        pointoffset = randomvector( 1 ) * initialmove;
        point = scripts\mp\gametypes\br_public::droptogroundmultitrace( point + pointoffset );
    }
    
    if ( istrue( dropstruct.var_f453aecd14b7f921 ) )
    {
        thread function_d982cb8f96ba4d30();
    }
    
    for ( heightsq = distancesquared( scripts\mp\gametypes\br_public::droptogroundmultitrace( self.origin, -100 ), self.origin ); heightsq > var_81986b2d8e843970 && !istrue( self.var_69c5e9413f4bdb05 ) ; heightsq = distancesquared( scripts\mp\gametypes\br_public::droptogroundmultitrace( self.origin, -100 ), self.origin ) )
    {
        thread function_3a64ec0c7632f6cc( point, dropstruct );
        waitframe();
    }
    
    self notify( "crate_drift_end" );
    self.var_661d71d55253757d = undefined;
    self.var_69c5e9413f4bdb05 = undefined;
    
    if ( isdefined( self.chute ) )
    {
        self.chute delete();
    }
    
    if ( !istrue( self.physicsactivated ) )
    {
        self unlink();
        self physicslaunchserver( ( 0, 0, 0 ), ( 0, 0, 0 ) );
        bodyid = self physics_getbodyid( 0 );
        physics_setbodycenterofmassnormal( bodyid, ( 0, 0, -0.75 ) );
        self.physicsactivated = 1;
    }
    
    endpos = scripts\mp\gametypes\br_public::droptogroundmultitrace( self.origin, 25, -20000 );
    self physics_registerforcollisioncallback();
    thread scripts\cp_mp\killstreaks\airdrop::monitorimpactinternal( 0.1 );
    
    if ( istrue( spawnsmoke ) )
    {
        scriptable = ter_op( isdefined( self.var_13ba232eee7e6069 ), self.var_13ba232eee7e6069, "ks_airdrop_crate_dmz" );
        self.smokesignal = spawn( "script_model", endpos );
        self.smokesignal setmodel( scriptable );
        self.smokesignal setscriptablepartstate( "smoke_signal", "on", 0 );
    }
    
    wait 3;
    
    if ( !istrue( dropstruct.var_30daf66a65a215e7 ) )
    {
        self setscriptablepartstate( "dmz_supply_drop", "usable" );
    }
    
    childthread scripts\cp_mp\killstreaks\airdrop::monitoraveragevelocities( 0.1, 8 );
    settlecount = 0;
    
    while ( true )
    {
        wait 0.1;
        avlinvel = scripts\cp_mp\killstreaks\airdrop::getaveragelinearvelocity();
        avangvel = scripts\cp_mp\killstreaks\airdrop::getaverageangularvelocity();
        
        if ( !isdefined( avlinvel ) || !isdefined( avangvel ) )
        {
            continue;
        }
        
        if ( avlinvel > scripts\cp_mp\killstreaks\airdrop::function_3c4492046080faa9() || avangvel > scripts\cp_mp\killstreaks\airdrop::function_f7e3f128296ac3b6() )
        {
            settlecount = 0;
            continue;
        }
        
        settlecount++;
        
        if ( settlecount != scripts\cp_mp\killstreaks\airdrop::function_d4833b6c916db9c6() )
        {
            continue;
        }
        
        self.physicssettled = 1;
        break;
    }
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 0
// Checksum 0x0, Offset: 0x1752
// Size: 0x29
function function_d982cb8f96ba4d30()
{
    self endon( "death" );
    self endon( "crate_drift_end" );
    wait 3;
    self waittill( "collision" );
    self.var_69c5e9413f4bdb05 = 1;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 2
// Checksum 0x0, Offset: 0x1783
// Size: 0x24d
function function_3a64ec0c7632f6cc( point, dropstruct )
{
    self endon( "death" );
    self endon( "crate_drift_end" );
    
    if ( isdefined( self.var_661d71d55253757d ) )
    {
        return;
    }
    
    self.var_661d71d55253757d = 1;
    timestep = ter_op( isdefined( dropstruct.timestep ), dropstruct.timestep, 3 );
    var_3077f6d3d97bb34b = ter_op( isdefined( dropstruct.var_3077f6d3d97bb34b ), dropstruct.var_3077f6d3d97bb34b, 400 );
    var_3c3ed534c61a56e4 = ter_op( isdefined( dropstruct.var_3c3ed534c61a56e4 ), dropstruct.var_3c3ed534c61a56e4, 100 );
    var_94ae57fe158c3c29 = ter_op( isdefined( dropstruct.var_94ae57fe158c3c29 ), dropstruct.var_94ae57fe158c3c29, 100 );
    var_9612b650d147f458 = ter_op( isdefined( dropstruct.var_9612b650d147f458 ), dropstruct.var_9612b650d147f458, 500 );
    downdist = randomfloat( var_94ae57fe158c3c29 ) + var_3077f6d3d97bb34b;
    horizdist = randomfloat( var_9612b650d147f458 ) + var_3c3ed534c61a56e4;
    dir = point - self.origin;
    dir2d = vectornormalize( ( dir[ 0 ], dir[ 1 ], 0 ) );
    topoint = ( dir2d[ 0 ] * horizdist, dir2d[ 1 ] * horizdist, 0 - downdist );
    startpoint = self.origin;
    timer = 0;
    
    while ( true )
    {
        dt = level.framedurationseconds;
        t = timer / timestep;
        var_531e349ad5675163 = t * t * ( 3 - 2 * t );
        udscalar = t * t * 0.5 + 0.5 * t;
        
        if ( !isdefined( topoint ) || !isdefined( var_531e349ad5675163 ) || !isdefined( udscalar ) )
        {
            break;
        }
        
        scaledvec = ( topoint[ 0 ] * var_531e349ad5675163, topoint[ 1 ] * var_531e349ad5675163, topoint[ 2 ] * udscalar );
        self.origin = startpoint + scaledvec;
        timer += dt;
        
        if ( timer >= timestep )
        {
            break;
        }
        
        waitframe();
    }
    
    self.var_661d71d55253757d = undefined;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 6
// Checksum 0x0, Offset: 0x19d8
// Size: 0x1fb
function function_94ff06d2db58e807( instance, part, state, player, bautouse, usestring )
{
    if ( !istrue( instance.entity.open ) )
    {
        if ( istrue( instance.entity function_6b3bfd072d1faafb( player ) ) )
        {
            instance.entity.open = 1;
            instance.entity.playerusing = undefined;
            instance.entity notify( "crate_opened" );
        }
        else
        {
            return;
        }
    }
    
    if ( isdefined( instance.entity.smokesignal ) && !isdefined( instance.var_ceb543956c7203e7 ) )
    {
        instance.var_ceb543956c7203e7 = &function_4b941a30db41d07e;
    }
    
    instance setscriptablepartstate( "dmz_supply_drop", "partially_open_in_use_unusable" );
    
    if ( isdefined( instance.entity.onopenfunc ) )
    {
        [[ instance.entity.onopenfunc ]]( instance, player );
    }
    
    if ( isdefined( level.var_2ff67632074bc957 ) )
    {
        instance [[ level.var_2ff67632074bc957 ]]( player );
    }
    
    items = getscriptablelootcachecontents( instance );
    
    if ( issharedfuncdefined( "pmc_missions", "onOpenSupplyDrop" ) )
    {
        items = [[ getsharedfunc( "pmc_missions", "onOpenSupplyDrop" ) ]]( player, instance, items );
    }
    
    if ( !isdefined( instance.contents ) )
    {
        instance.containertype = 3;
        instance scripts\mp\gametypes\br_lootcache::lootcachespawncontents( items, 1, player, instance.contents );
    }
    else
    {
        instance scripts\mp\gametypes\br_lootcache::lootcachespawncontents( undefined, 1, player, instance.contents );
    }
    
    if ( !isdefined( player.lootcachesopened ) )
    {
        player.lootcachesopened = 1;
        return;
    }
    
    player.lootcachesopened++;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 1
// Checksum 0x0, Offset: 0x1bdb
// Size: 0x127, Type: bool
function function_6b3bfd072d1faafb( player )
{
    player endon( "disconnect" );
    player endon( "joined_team" );
    player endon( "joined_spectators" );
    self endon( "crate_opened" );
    level endon( "game_ended" );
    
    if ( istrue( self.playerusing ) )
    {
        return false;
    }
    
    thread function_b8bfc63550a2b619( player );
    
    while ( isdefined( player ) && player scripts\cp_mp\utility\player_utility::_isalive() && cankeepusingcrate( player ) && player usebuttonpressed() )
    {
        if ( !isdefined( self.playerusing ) )
        {
            self.playerusing = 1;
        }
        
        self.curprogress += level.framedurationseconds * self.userate;
        
        if ( self.curprogress >= self.usetime )
        {
            self.curprogress = 0;
            stopusingcrate( player );
            return true;
        }
        
        if ( issharedfuncdefined( "airdrop", "updateUIProgress" ) )
        {
            player [[ getsharedfunc( "airdrop", "updateUIProgress" ) ]]( self, 1 );
        }
        
        waitframe();
    }
    
    self.playerusing = undefined;
    stopusingcrate( player );
    self.curprogress = 0;
    return false;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 1
// Checksum 0x0, Offset: 0x1d0b
// Size: 0x3a
function function_b8bfc63550a2b619( player )
{
    level endon( "game_ended" );
    self endon( "crate_opened" );
    player waittill_any_3( "disconnect", "joined_team", "joined_spectators" );
    self.playerusing = undefined;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 1
// Checksum 0x0, Offset: 0x1d4d
// Size: 0x34
function stopusingcrate( player )
{
    if ( issharedfuncdefined( "airdrop", "updateUIProgress" ) )
    {
        player [[ getsharedfunc( "airdrop", "updateUIProgress" ) ]]( self, 0 );
    }
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 1
// Checksum 0x0, Offset: 0x1d89
// Size: 0x62, Type: bool
function cankeepusingcrate( player )
{
    if ( !player scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return false;
    }
    
    if ( player meleebuttonpressed() )
    {
        return false;
    }
    
    if ( player isinexecutionvictim() )
    {
        return false;
    }
    
    if ( istrue( player.inlaststand ) )
    {
        return false;
    }
    
    if ( distancesquared( player.origin, self.origin ) >= 10000 )
    {
        return false;
    }
    
    return true;
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 0
// Checksum 0x0, Offset: 0x1df4
// Size: 0x86
function function_d545b198b75385f6()
{
    if ( !isdefined( level.supplydroptypes ) )
    {
        return;
    }
    
    foreach ( dropstruct in level.supplydroptypes )
    {
        if ( isdefined( dropstruct.funcs[ "onPlayerEnterGulag" ] ) )
        {
            self [[ dropstruct.funcs[ "onPlayerEnterGulag" ] ]]();
        }
    }
}

// Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
// Params 0
// Checksum 0x0, Offset: 0x1e82
// Size: 0x87
function function_f5d7f1682f6fc578()
{
    if ( !isdefined( level.supplydroptypes ) )
    {
        return;
    }
    
    foreach ( dropstruct in level.supplydroptypes )
    {
        if ( isdefined( dropstruct.funcs[ "onPlayerRespawn" ] ) )
        {
            self thread [[ dropstruct.funcs[ "onPlayerRespawn" ] ]]();
        }
    }
}

/#

    // Namespace br_supply_drops_common / scripts\mp\gametypes\br_supply_drops_common
    // Params 0
    // Checksum 0x0, Offset: 0x1f11
    // Size: 0x14e, Type: dev
    function function_d1044a7030f099f9()
    {
        level endon( "<dev string:x1d7>" );
        
        while ( true )
        {
            val = getdvarint( @"hash_d3c611ad65845e41", 0 );
            
            if ( val )
            {
                setdvar( @"hash_d3c611ad65845e41", 0 );
                
                if ( !isdefined( level.recentsupplydrop ) )
                {
                    continue;
                }
                
                selectedplayer = undefined;
                
                foreach ( player in level.players )
                {
                    if ( isbot( player ) )
                    {
                        selectedplayer = player;
                        break;
                    }
                }
                
                if ( !isdefined( selectedplayer ) )
                {
                    continue;
                }
                
                forward = anglestoforward( level.recentsupplydrop.angles );
                pos = level.recentsupplydrop.origin + forward * 35;
                groundpos = scripts\mp\gametypes\br_public::droptogroundmultitrace( pos );
                selectedplayer setorigin( groundpos );
                waitframe();
                selectedplayer botlookatpoint( level.recentsupplydrop.origin, 11 );
                waitframe();
                selectedplayer botpressbutton( "<dev string:x1e5>", 20 );
            }
            
            waitframe();
        }
    }

#/
