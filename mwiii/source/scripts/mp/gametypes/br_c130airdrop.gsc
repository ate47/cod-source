#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\parachute;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\flags;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;

#namespace br_c130airdrop;

// Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
// Params 0
// Checksum 0x0, Offset: 0x37b
// Size: 0x105
function init()
{
    registersharedfunc( "br_c130Airdrop", "c130Airdrop_onCrateUse", &c130airdrop_oncrateuse );
    level.c130deliveriesinprogress = [];
    level.c130successfulairdrops = [];
    level.c130airdrop_heightoverride = getdvarint( @"scr_plunder_airdropcrateheightoverride", 12000 );
    
    /#
        setdevdvarifuninitialized( @"hash_bb26d1091b0f057d", 0 );
        setdevdvarifuninitialized( @"hash_5d70eab0efbc5895", 0 );
        setdevdvarifuninitialized( @"hash_301a0076aa763558", 1 );
        setdevdvarifuninitialized( @"hash_7b5f99d862e0fd13", 3 );
        setdevdvarifuninitialized( @"hash_42f7332f1e9035b3", 3 );
        setdevdvarifuninitialized( @"hash_a811b4c67a77ce31", 12 );
        setdevdvarifuninitialized( @"hash_d313f3ed75dbff0f", 10000 );
        setdevdvarifuninitialized( @"hash_61cd7f929e3a8d6c", 240 );
        setdevdvarifuninitialized( @"hash_61a98d929e12317e", 360 );
        setdevdvarifuninitialized( @"hash_f21f22782971c2ac", 750 );
        setdevdvarifuninitialized( @"hash_ff7bb52f31b387e1", 1 );
    #/
}

// Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
// Params 0
// Checksum 0x0, Offset: 0x488
// Size: 0x263
function c130airdrop_managedrop()
{
    level endon( "game_ended" );
    var_f49a0a20d47e1dc0 = 1;
    
    /#
        level thread function_34b411986509f682();
        level thread function_73d8265b112f259d();
    #/
    
    level waittill( "br_prematchEnded" );
    
    while ( true )
    {
        var_f798734f97421714 = getdvarint( @"hash_301a0076aa763558", 1 );
        
        if ( !var_f798734f97421714 )
        {
            waitframe();
            continue;
        }
        
        var_b63480e487f34e3a = getdvarint( @"hash_7b5f99d862e0fd13", 3 );
        var_2b458b39bbf6bb8b = getdvarint( @"hash_a811b4c67a77ce31", 12 );
        mincooldowntime = getdvarint( @"hash_61cd7f929e3a8d6c", 240 );
        maxcooldowntime = getdvarint( @"hash_61a98d929e12317e", 360 );
        spawninterval = randomintrange( mincooldowntime, maxcooldowntime );
        
        if ( istrue( var_f49a0a20d47e1dc0 ) )
        {
            scripts\mp\flags::gameflagwait( "activate_cash_drops" );
        }
        else
        {
            wait spawninterval;
        }
        
        if ( isdefined( level.br_level ) )
        {
            level.br_level.c130_speedoverride = 3044;
        }
        
        var_334267db87355776 = level.c130successfulairdrops.size;
        
        if ( var_334267db87355776 < var_2b458b39bbf6bb8b )
        {
            var_a027d7566fc885a9 = getdvarint( @"hash_42f7332f1e9035b3", 3 );
            cratedifference = var_2b458b39bbf6bb8b - var_334267db87355776;
            
            if ( !istrue( var_f49a0a20d47e1dc0 ) )
            {
                var_b63480e487f34e3a = 1;
            }
            
            var_4528266cd203c948 = min( var_b63480e487f34e3a, ceil( cratedifference / var_a027d7566fc885a9 ) );
            var_734798c9f67545df = cratedifference;
            
            for ( i = 0; i < var_4528266cd203c948 ; i++ )
            {
                var_5ee94ae126526f2f = min( var_a027d7566fc885a9, var_734798c9f67545df );
                var_734798c9f67545df -= var_5ee94ae126526f2f;
                pathstruct = c130airdrop_createpath( i );
                dist = distance( pathstruct.startpt, pathstruct.endpt );
                travelspeed = scripts\mp\gametypes\br_c130::getc130speed();
                time = dist / travelspeed;
                c130airdrop = c130airdrop_spawn( pathstruct, dist, travelspeed, time );
                
                if ( i == 0 )
                {
                    showsplashtoall( "br_c130airdrop_incoming" );
                }
                
                c130airdrop c130airdrop_startdelivery( var_5ee94ae126526f2f );
                
                if ( istrue( level.usemilestonephases ) )
                {
                    wait randomintrange( 4, 8 );
                }
            }
            
            if ( istrue( var_f49a0a20d47e1dc0 ) )
            {
                var_f49a0a20d47e1dc0 = 0;
            }
        }
    }
}

/#

    // Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
    // Params 0
    // Checksum 0x0, Offset: 0x6f3
    // Size: 0x11d, Type: dev
    function function_34b411986509f682()
    {
        level endon( "<dev string:x1c>" );
        startingindex = 0;
        
        while ( true )
        {
            testspawn = getdvarint( @"hash_bb26d1091b0f057d", 0 );
            
            if ( !testspawn )
            {
                waitframe();
                continue;
            }
            
            if ( isdefined( level.br_level ) )
            {
                level.br_level.c130_speedoverride = 3044;
            }
            
            pathstruct = c130airdrop_createpath( startingindex );
            dist = distance( pathstruct.startpt, pathstruct.endpt );
            travelspeed = scripts\mp\gametypes\br_c130::getc130speed();
            time = dist / travelspeed;
            c130airdrop = c130airdrop_spawn( pathstruct, dist, travelspeed, time );
            var_5ee94ae126526f2f = getdvarint( @"hash_42f7332f1e9035b3", 3 );
            showsplashtoall( "<dev string:x2a>" );
            c130airdrop c130airdrop_startdelivery( var_5ee94ae126526f2f );
            setdvar( @"hash_bb26d1091b0f057d", 0 );
            startingindex++;
            
            if ( startingindex > 2 )
            {
                startingindex = 0;
            }
            
            waitframe();
        }
    }

    // Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
    // Params 0
    // Checksum 0x0, Offset: 0x818
    // Size: 0x18e, Type: dev
    function function_73d8265b112f259d()
    {
        level endon( "<dev string:x1c>" );
        
        while ( true )
        {
            testspawn = getdvarint( @"hash_5d70eab0efbc5895", 0 );
            
            if ( !testspawn )
            {
                waitframe();
                continue;
            }
            
            firstplayer = undefined;
            
            foreach ( player in level.players )
            {
                if ( isreallyalive( player ) )
                {
                    firstplayer = player;
                    break;
                }
            }
            
            droplocation = undefined;
            starttrace = firstplayer.origin + ( 0, 0, 10000 );
            endtrace = firstplayer.origin - ( 0, 0, 20000 );
            trace = scripts\engine\trace::ray_trace( starttrace, endtrace, firstplayer );
            
            if ( isdefined( trace ) && trace[ "<dev string:x45>" ] != "<dev string:x50>" )
            {
                droplocation = trace[ "<dev string:x60>" ];
            }
            
            if ( isdefined( droplocation ) )
            {
                crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate( droplocation + ( 0, 0, 5000 ), droplocation, ( 0, 0, 0 ) );
                
                if ( isdefined( crate ) )
                {
                    level.c130successfulairdrops[ level.c130successfulairdrops.size ] = crate;
                }
            }
            else
            {
                iprintlnbold( "<dev string:x6c>" );
            }
            
            setdvar( @"hash_5d70eab0efbc5895", 0 );
        }
    }

#/

// Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
// Params 3
// Checksum 0x0, Offset: 0x9ae
// Size: 0x6c
function c130airdrop_createpath( pathindex, centerpointoverride, var_60e425cb62ae9e62 )
{
    if ( isdefined( level.br_level.br_mapcenter ) && isdefined( level.br_level.br_mapsize ) )
    {
        pathstruct = c130airdrop_createpathstruct( pathindex, centerpointoverride, var_60e425cb62ae9e62 );
    }
    else
    {
        pathstruct = scripts\mp\gametypes\br_c130::spawnc130pathstruct( centerpointoverride );
    }
    
    return pathstruct;
}

// Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
// Params 3
// Checksum 0x0, Offset: 0xa23
// Size: 0x1a9
function c130airdrop_createpathstruct( pathindex, centerpointoverride, var_60e425cb62ae9e62 )
{
    pathstruct = undefined;
    centerpt = level.br_level.br_mapcenter;
    
    if ( isdefined( centerpointoverride ) )
    {
        centerpt = centerpointoverride;
    }
    
    saferadius = scripts\mp\gametypes\br_c130::getplanepathsaferadiusfromcenter();
    flightangles = ( 0, randomfloat( 360 ), 0 );
    
    if ( !isdefined( pathindex ) || pathindex == 0 )
    {
        if ( !istrue( var_60e425cb62ae9e62 ) )
        {
            var_b36772ca73e9a3d = c130airdrop_getvalidteaminlastplace();
            getteamaveragepos = c130airdrop_getteamaveragepos( var_b36772ca73e9a3d );
            flightangles = vectortoangles( centerpt - getteamaveragepos * ( 1, 1, 0 ) );
            level.c130deliverydirection = flightangles;
        }
    }
    else
    {
        if ( isdefined( level.c130deliverydirection ) )
        {
            flightangles = level.c130deliverydirection;
            sidemod = 1;
            
            if ( pathindex == 2 )
            {
                sidemod = -1;
            }
            
            offsetvec = anglestoright( flightangles ) * saferadius * sidemod;
            randomdirection = randomint( 2 );
            randomyaw = randomfloat( 360 );
            flightangles = ( 0, randomyaw, 0 );
            flightangles = ter_op( randomdirection, flightangles, flightangles + ( 0, 180, 0 ) );
        }
        else
        {
            randomyaw = randomfloat( 360 );
            offsetvec = anglestoforward( ( 0, randomyaw, 0 ) );
            offsetvec *= saferadius * randomfloatrange( -1, 1 );
        }
        
        centerpt += offsetvec;
    }
    
    c130height = scripts\cp_mp\parachute::getc130airdropheight();
    pathstruct = scripts\mp\gametypes\br_c130::spawnc130pathstructnewinternal( centerpt, flightangles, c130height );
    return pathstruct;
}

// Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
// Params 0
// Checksum 0x0, Offset: 0xbd5
// Size: 0x17a
function c130airdrop_getvalidteaminlastplace()
{
    var_cf4bbe562ea35eaa = undefined;
    teamplacements = scripts\mp\gamescore::getteamscoreplacements();
    var_176a993b8d63593a = [];
    
    foreach ( potentialteam in level.teamnamelist )
    {
        teamplayers = getteamdata( potentialteam, "players" );
        
        if ( teamplayers.size > 0 )
        {
            teamisalive = 0;
            
            foreach ( player in teamplayers )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( isreallyalive( player ) )
                {
                    teamisalive = 1;
                    break;
                }
            }
            
            if ( !istrue( teamisalive ) )
            {
                continue;
            }
            
            currentteamplace = teamplacements[ potentialteam ];
            
            if ( !isdefined( var_cf4bbe562ea35eaa ) || currentteamplace >= var_cf4bbe562ea35eaa )
            {
                var_cf4bbe562ea35eaa = currentteamplace;
                teamindex = var_176a993b8d63593a.size;
                var_176a993b8d63593a[ teamindex ] = spawnstruct();
                var_176a993b8d63593a[ teamindex ].team = potentialteam;
                var_176a993b8d63593a[ teamindex ].players = teamplayers;
            }
        }
    }
    
    if ( var_176a993b8d63593a.size > 0 )
    {
        teamindex = 0;
        
        if ( var_176a993b8d63593a.size > 1 )
        {
            teamindex = randomint( var_176a993b8d63593a.size );
        }
        
        return var_176a993b8d63593a[ teamindex ];
    }
}

// Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
// Params 1
// Checksum 0x0, Offset: 0xd58
// Size: 0x188
function c130airdrop_getteamaveragepos( var_b36772ca73e9a3d )
{
    if ( !isdefined( var_b36772ca73e9a3d.players ) )
    {
        /#
            iprintlnbold( "<dev string:xd0>" );
        #/
        
        return ( randomfloatrange( -1000, 1000 ), 0, 0 );
    }
    
    sumvectors = ( 0, 0, 0 );
    var_82316dc9ed0020f7 = 3000;
    var_b5b5e50f6ef69aae = 1;
    
    foreach ( player in var_b36772ca73e9a3d.players )
    {
        if ( !isreallyalive( player ) )
        {
            continue;
        }
        
        sumvectors = player.origin;
        
        foreach ( otherplayer in var_b36772ca73e9a3d.players )
        {
            if ( otherplayer == player )
            {
                continue;
            }
            
            if ( !isreallyalive( otherplayer ) )
            {
                continue;
            }
            
            if ( distance2dsquared( player.origin, otherplayer.origin ) <= var_82316dc9ed0020f7 * var_82316dc9ed0020f7 )
            {
                var_b5b5e50f6ef69aae++;
                sumvectors += otherplayer.origin;
                break;
            }
        }
        
        if ( var_b5b5e50f6ef69aae >= 2 )
        {
            break;
        }
    }
    
    averagepos = sumvectors / var_b5b5e50f6ef69aae;
    return averagepos;
}

// Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
// Params 4
// Checksum 0x0, Offset: 0xee9
// Size: 0x1f7
function c130airdrop_spawn( pathinfo, pathdist, pathspeed, pathtime )
{
    airdrop = spawn( "script_model", pathinfo.startpt );
    airdrop setmodel( "veh8_mil_air_acharlie130_magma_animated" );
    airdrop setcandamage( 0 );
    airdrop.maxhealth = 100000;
    airdrop.health = airdrop.maxhealth;
    airdrop.startpt = pathinfo.startpt;
    airdrop.endpt = pathinfo.endpt;
    airdrop.centerpt = pathinfo.centerpt;
    airdrop.dir = vectornormalize( airdrop.endpt - airdrop.startpt );
    airdrop.angles = vectortoangles( airdrop.dir );
    airdrop.pathdist = pathdist;
    airdrop.speed = pathspeed;
    airdrop.lifetime = pathtime;
    airdrop.chassis = spawn( "script_model", airdrop.startpt );
    airdrop.chassis setmodel( "veh8_mil_air_acharlie130_magma_rigid" );
    airdrop.chassis linkto( airdrop, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( issharedfuncdefined( "game", "createObjective" ) )
    {
        minimapid = airdrop [[ getsharedfunc( "game", "createObjective" ) ]]( "icon_minimap_dropship", undefined, undefined, 1, 1 );
        airdrop.minimapid = minimapid;
    }
    
    level.c130deliveriesinprogress[ level.c130deliveriesinprogress.size ] = airdrop;
    return airdrop;
}

// Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
// Params 4
// Checksum 0x0, Offset: 0x10e9
// Size: 0x62
function c130airdrop_startdelivery( var_5ee94ae126526f2f, var_958bbdfed6f2e9ef, var_fe41be11a71dc1b4, dropcircle )
{
    self setscriptablepartstate( "audio_lp_dmz", "on", 0 );
    self moveto( self.endpt, self.lifetime );
    thread c130airdrop_deleteatlifetime();
    thread c130airdrop_dropcrates( var_5ee94ae126526f2f, var_958bbdfed6f2e9ef, var_fe41be11a71dc1b4, dropcircle );
}

// Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
// Params 0
// Checksum 0x0, Offset: 0x1153
// Size: 0xd8
function c130airdrop_deleteatlifetime()
{
    self endon( "death" );
    level endon( "game_ended" );
    wait self.lifetime - 1;
    exitsoundent = spawn( "script_model", self.origin );
    exitsoundent setmodel( "veh8_mil_air_acharlie130_magma_scriptable" );
    exitsoundent setscriptablepartstate( "audio_exit_dmz", "on", 0 );
    exitsoundent thread scripts\mp\utility\script::delayentdelete( 10 );
    wait 1;
    level.c130deliveriesinprogress = array_remove( level.c130deliveriesinprogress, self );
    self setscriptablepartstate( "audio_lp_dmz", "off", 0 );
    
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
}

// Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
// Params 4
// Checksum 0x0, Offset: 0x1233
// Size: 0x1b4
function c130airdrop_dropcrates( var_5ee94ae126526f2f, var_958bbdfed6f2e9ef, var_fe41be11a71dc1b4, dropcircle )
{
    self endon( "death" );
    
    if ( isdefined( self.dropfunc ) )
    {
        self [[ self.dropfunc ]]( var_5ee94ae126526f2f, var_958bbdfed6f2e9ef, var_fe41be11a71dc1b4, dropcircle );
        return;
    }
    
    var_bd693dcf6bece704 = self.lifetime;
    var_11f20c6978f7d6a6 = var_bd693dcf6bece704 * 0.4;
    totaldroptime = var_bd693dcf6bece704 - var_11f20c6978f7d6a6;
    buffertime = var_11f20c6978f7d6a6 / 2;
    cratedroptime = totaldroptime / max( 1, var_5ee94ae126526f2f - 1 );
    bufferwait = 1;
    var_71cac1d48ab1c488 = 0;
    dropwaittime = buffertime;
    numcrates = 0;
    
    while ( numcrates < var_5ee94ae126526f2f )
    {
        if ( !istrue( bufferwait ) )
        {
            dropwaittime = cratedroptime;
        }
        
        if ( istrue( var_71cac1d48ab1c488 ) )
        {
            dropwaittime = cratedroptime / 3;
            var_71cac1d48ab1c488 = 0;
        }
        
        wait dropwaittime;
        
        if ( istrue( bufferwait ) )
        {
            bufferwait = 0;
        }
        
        droplocation = c130airdrop_findvaliddroplocation( self.origin + anglestoforward( self.angles ) * 500 );
        
        if ( !isdefined( droplocation ) )
        {
            var_71cac1d48ab1c488 = 1;
            continue;
        }
        
        crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate( droplocation + ( 0, 0, level.c130airdrop_heightoverride - 100 ), droplocation, self.angles, var_958bbdfed6f2e9ef, var_fe41be11a71dc1b4 );
        
        if ( !isdefined( crate ) )
        {
            var_71cac1d48ab1c488 = 1;
            continue;
        }
        
        numcrates++;
        triggerobject = scripts\cp_mp\killstreaks\airdrop::gettriggerobject( crate );
        triggerobject.usetimeoverride = 5;
        level.c130successfulairdrops[ level.c130successfulairdrops.size ] = crate;
    }
}

// Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
// Params 3
// Checksum 0x0, Offset: 0x13ef
// Size: 0xea
function c130airdrop_findvaliddroplocation( starttrace, var_5ce47de2b275eec8, var_d637e30565be7341 )
{
    droplocation = undefined;
    endtrace = starttrace - ( 0, 0, 20000 );
    ignorelist = [ self, self.chassis ];
    contents = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 1 );
    trace = scripts\engine\trace::ray_trace( starttrace, endtrace, ignorelist, contents );
    
    if ( isdefined( trace ) && trace[ "hittype" ] != "hittype_none" )
    {
        droplocation = trace[ "position" ];
    }
    
    if ( isdefined( droplocation ) && !istrue( var_5ce47de2b275eec8 ) )
    {
        validpoint = scripts\mp\gametypes\br_c130::ispointinbounds( droplocation ) && ( istrue( var_d637e30565be7341 ) || !c130airdrop_isnearotherdrop( droplocation ) );
        
        if ( !istrue( validpoint ) )
        {
            droplocation = undefined;
        }
    }
    
    return droplocation;
}

// Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
// Params 1
// Checksum 0x0, Offset: 0x14e2
// Size: 0xb5
function c130airdrop_isnearotherdrop( droplocation )
{
    neardroplocation = 0;
    activedrops = level.c130successfulairdrops;
    mindropdist = getdvarint( @"hash_d313f3ed75dbff0f", 10000 );
    var_16fac8f9233a1aca = mindropdist * mindropdist;
    
    foreach ( drop in activedrops )
    {
        if ( distance2dsquared( droplocation, drop.origin ) < var_16fac8f9233a1aca )
        {
            neardroplocation = 1;
            break;
        }
    }
    
    return neardroplocation;
}

// Namespace br_c130airdrop / scripts\mp\gametypes\br_c130airdrop
// Params 1
// Checksum 0x0, Offset: 0x15a0
// Size: 0x278
function c130airdrop_oncrateuse( player )
{
    var_6b5e1783915835c1 = getdvar( @"hash_c6f562bbcb26f231", "mp/loot_set_airdrop_contents_dmz.csv" );
    self.itemsdropped = 0;
    pickupents = [];
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    
    if ( !scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf() )
    {
        pickups = scripts\mp\gametypes\br_lootcache::chooseandspawnitems( dropstruct, 0, 1, "killstreak", var_6b5e1783915835c1 );
        pickupents = array_combine( pickupents, pickups );
    }
    
    pickups = scripts\mp\gametypes\br_lootcache::chooseandspawnitems( dropstruct, 4, 1, "weapon", var_6b5e1783915835c1 );
    pickupents = array_combine( pickupents, pickups );
    pickups = scripts\mp\gametypes\br_lootcache::chooseandspawnitems( dropstruct, 0, 2, "health", var_6b5e1783915835c1 );
    pickupents = array_combine( pickupents, pickups );
    pickups = scripts\mp\gametypes\br_lootcache::chooseandspawnitems( dropstruct, 0, 2, "ammo", var_6b5e1783915835c1 );
    pickupents = array_combine( pickupents, pickups );
    
    if ( !scripts\mp\gametypes\br_public::function_d6ae35e0ce14bbaf() && getdvarint( @"hash_506a78bc5717f8f4", 0 ) == 1 )
    {
        pickups = scripts\mp\gametypes\br_lootcache::chooseandspawnitems( dropstruct, 0, 1, "tablet", var_6b5e1783915835c1 );
        pickupents = array_combine( pickupents, pickups );
    }
    
    var_3ebbdc9f30b63842 = randomint( 3 );
    
    if ( var_3ebbdc9f30b63842 == 2 )
    {
        pickups = scripts\mp\gametypes\br_lootcache::chooseandspawnitems( dropstruct, 0, 1, "revive", var_6b5e1783915835c1 );
        pickupents = array_combine( pickupents, pickups );
    }
    
    basecashamount = 750;
    
    if ( isdefined( level.airdropbasecashamount ) )
    {
        basecashamount = level.airdropbasecashamount;
    }
    
    if ( istrue( level.bmoovertime ) )
    {
        basecashamount = int( basecashamount * level.overtimecashmultiplier );
    }
    
    pickups = scripts\mp\gametypes\br_plunder::dropplunderbyrarity( basecashamount, dropstruct );
    pickupents = array_combine( pickupents, pickups );
    
    foreach ( ent in pickupents )
    {
        ent.lootsource = "c130_box";
    }
    
    if ( !isdefined( player.lootcachesopened ) )
    {
        player.lootcachesopened = 1;
    }
    else
    {
        player.lootcachesopened++;
    }
    
    if ( scripts\mp\utility\game::getsubgametype() == "risk" || scripts\mp\utility\game::getsubgametype() == "plunder" )
    {
        player scripts\mp\gametypes\br_public::updatebrscoreboardstat( "lootCachesOpened", player.lootcachesopened );
    }
    
    player thread scripts\mp\utility\points::doscoreevent( #"hash_d9180ca5c5dc7b88" );
}

