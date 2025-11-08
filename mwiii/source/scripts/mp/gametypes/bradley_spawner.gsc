#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\gametypes\dom;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;

#namespace bradley_spawner;

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 2
// Checksum 0x0, Offset: 0x2cf
// Size: 0x36
function monitoradd( tank, timeout )
{
    tank.script_timeout = timeout;
    level.tanktimeoutlist[ level.tanktimeoutlist.size ] = tank;
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 2
// Checksum 0x0, Offset: 0x30d
// Size: 0xff
function spawntanks( tankstructs, team )
{
    level endon( "game_ended" );
    wait 0.05;
    
    foreach ( tankspawn in tankstructs )
    {
        if ( !isdefined( tankspawn.angles ) )
        {
            tankspawn.angles = ( 0, 0, 0 );
        }
        
        refill = ter_op( isdefined( tankspawn.script_force_count ), tankspawn.script_force_count, 0 );
        timeout = ter_op( isdefined( tankspawn.script_timeout ), tankspawn.script_timeout, 0 );
        level thread spawntankandmonitor( tankspawn.origin, tankspawn.angles, team, refill, timeout );
    }
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 5
// Checksum 0x0, Offset: 0x414
// Size: 0x71
function spawntankandmonitor( origin, angles, team, refill, timeout )
{
    level endon( "game_ended" );
    tank = spawntank( origin, angles, team, timeout, 0 );
    
    if ( refill )
    {
        while ( true )
        {
            tank waittill( "death" );
            wait 3;
            tank = spawntank( origin, angles, team, timeout, 1 );
        }
    }
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 5
// Checksum 0x0, Offset: 0x48d
// Size: 0x102
function spawntank( origin, angles, team, timeout, infil )
{
    assert( issharedfuncdefined( "<dev string:x1c>", "<dev string:x2a>" ), "<dev string:x3b>" );
    
    if ( !issharedfuncdefined( "light_tank", "initSpawnData" ) )
    {
        return;
    }
    
    spawndata = spawnstruct();
    [[ getsharedfunc( "light_tank", "initSpawnData" ) ]]( spawndata );
    spawndata.cantimeout = 0;
    spawndata.spawnmethod = ter_op( istrue( infil ), "airdrop_at_position_unsafe", "place_at_position_unsafe" );
    spawndata.origin = origin;
    spawndata.angles = angles;
    spawndata.team = team;
    tank = [[ getsharedfunc( "light_tank", "tankSpawn" ) ]]( spawndata );
    
    if ( timeout > 0 )
    {
        monitoradd( tank, timeout );
    }
    
    return tank;
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 0
// Checksum 0x0, Offset: 0x598
// Size: 0x30b
function inittankspawns()
{
    level.tankstartspawnallies = getstructarray( "tdm_bradley_allies", "targetname" );
    level.tankstartspawnaxis = getstructarray( "tdm_bradley_axis", "targetname" );
    level.tankstartspawnneutral = getstructarray( "tdm_bradley_neutral", "targetname" );
    level.tankstartspawnalliesdom = getstructarray( "dom_bradley_allies", "targetname" );
    level.tankstartspawnaxisdom = getstructarray( "dom_bradley_axis", "targetname" );
    level.tankspawndom_a = getstructarray( "dom_bradley_a", "targetname" );
    level.tankspawndom_b = getstructarray( "dom_bradley_b", "targetname" );
    level.tankspawndom_c = getstructarray( "dom_bradley_c", "targetname" );
    level.tankstartspawnalliescmd = getstructarray( "cmd_bradley_allies", "targetname" );
    level.tankstartspawnaxiscmd = getstructarray( "cmd_bradley_axis", "targetname" );
    level.tankspawncmd_2 = getstructarray( "cmd_bradley_2", "targetname" );
    level.tankspawncmd_3 = getstructarray( "cmd_bradley_3", "targetname" );
    level.tankspawncmd_1 = getstructarray( "cmd_bradley_1", "targetname" );
    
    if ( getdvarint( @"hash_3bfe19e3234d5dff", 0 ) == 0 )
    {
        return;
    }
    
    gametypes = [ "cmd", "dom", "war", "arm", "conflict", "risk" ];
    gameindex = array_find( gametypes, getgametype() );
    
    if ( !isdefined( gameindex ) )
    {
        gameindex = gametypes.size;
    }
    
    for ( i = gameindex; i < gametypes.size ; i++ )
    {
        testgametype = gametypes[ i ];
        
        if ( testgametype == "war" )
        {
            if ( level.tankstartspawnallies.size != 0 || level.tankstartspawnaxis.size != 0 || level.tankstartspawnneutral.size != 0 )
            {
                spawnstartingbradleystdm();
                
                if ( level.tankstartspawnneutral.size != 0 )
                {
                    thread kickoffneutralbradleyspawnstdm();
                }
                
                break;
            }
            
            continue;
        }
        
        if ( testgametype == "dom" )
        {
            if ( level.tankstartspawnalliesdom.size != 0 || level.tankstartspawnaxisdom.size != 0 || level.tankspawndom_a.size != 0 || level.tankspawndom_b.size != 0 || level.tankspawndom_c.size != 0 )
            {
                thread kickoffneutralbradleyspawnsdom();
                break;
            }
            
            continue;
        }
        
        if ( testgametype == "cmd" )
        {
            if ( level.tankstartspawnalliescmd.size != 0 || level.tankstartspawnaxiscmd.size != 0 || level.tankspawncmd_1.size != 0 || level.tankspawncmd_2.size != 0 || level.tankspawncmd_3.size != 0 )
            {
                spawnstartingbradleyscmd();
                break;
            }
        }
    }
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 0
// Checksum 0x0, Offset: 0x8ab
// Size: 0x151
function spawnstartingbradleystdm()
{
    if ( level.tankstartspawnallies.size != 0 && level.tankstartspawnaxis.size != 0 )
    {
        angles = ( 0, 0, 0 );
        
        if ( isdefined( level.tankstartspawnallies[ 0 ].angles ) )
        {
            angles = level.tankstartspawnallies[ 0 ].angles;
        }
        
        /#
            println( "<dev string:xaa>" + level.tankstartspawnallies[ 0 ].origin );
            println( "<dev string:xdb>" + angles );
        #/
        
        thread spawnbradleynoduration( level.tankstartspawnallies[ 0 ].origin, angles, "allies" );
        angles = ( 0, 0, 0 );
        
        if ( isdefined( level.tankstartspawnaxis[ 0 ].angles ) )
        {
            angles = level.tankstartspawnaxis[ 0 ].angles;
        }
        
        /#
            println( "<dev string:x10c>" + level.tankstartspawnaxis[ 0 ].origin );
            println( "<dev string:x13b>" + angles );
        #/
        
        thread spawnbradleynoduration( level.tankstartspawnaxis[ 0 ].origin, angles, "axis" );
    }
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 0
// Checksum 0x0, Offset: 0xa04
// Size: 0x19e
function spawnstartingbradleysdom()
{
    if ( level.tankstartspawnalliesdom.size != 0 && level.tankstartspawnaxisdom.size != 0 )
    {
        var_7e4886c52a1bc723 = ( 0, 0, 0 );
        allyorigin = ( 0, 0, 0 );
        var_76fd430e3623fb30 = ( 0, 0, 0 );
        axisorigin = ( 0, 0, 0 );
        
        if ( isdefined( level.tankstartspawnalliesdom[ 0 ].angles ) )
        {
            var_7e4886c52a1bc723 = level.tankstartspawnalliesdom[ 0 ].angles;
        }
        
        allyorigin = level.tankstartspawnalliesdom[ 0 ].origin;
        println( "<dev string:x16a>" + level.tankstartspawnalliesdom[ 0 ].origin );
        
        if ( isdefined( level.tankstartspawnaxisdom[ 0 ].angles ) )
        {
            var_76fd430e3623fb30 = level.tankstartspawnaxisdom[ 0 ].angles;
        }
        
        axisorigin = level.tankstartspawnaxisdom[ 0 ].origin;
        println( "<dev string:x19e>" + level.tankstartspawnaxisdom[ 0 ].origin );
        
        if ( game[ "switchedsides" ] )
        {
            thread spawnbradleynoduration( axisorigin, var_76fd430e3623fb30, "allies" );
            thread spawnbradleynoduration( allyorigin, var_7e4886c52a1bc723, "axis" );
            return;
        }
        
        thread spawnbradleynoduration( axisorigin, var_76fd430e3623fb30, "axis" );
        thread spawnbradleynoduration( allyorigin, var_7e4886c52a1bc723, "allies" );
    }
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 0
// Checksum 0x0, Offset: 0xbaa
// Size: 0x151
function spawnstartingbradleyscmd()
{
    if ( level.tankstartspawnalliescmd.size != 0 && level.tankstartspawnaxiscmd.size != 0 )
    {
        angles = ( 0, 0, 0 );
        
        if ( isdefined( level.tankstartspawnalliescmd[ 0 ].angles ) )
        {
            angles = level.tankstartspawnalliescmd[ 0 ].angles;
        }
        
        /#
            println( "<dev string:x1d0>" + level.tankstartspawnalliescmd[ 0 ].origin );
            println( "<dev string:x204>" + angles );
        #/
        
        thread spawnbradleynoduration( level.tankstartspawnalliescmd[ 0 ].origin, angles, "allies" );
        angles = ( 0, 0, 0 );
        
        if ( isdefined( level.tankstartspawnaxiscmd[ 0 ].angles ) )
        {
            angles = level.tankstartspawnaxiscmd[ 0 ].angles;
        }
        
        /#
            println( "<dev string:x238>" + level.tankstartspawnaxiscmd[ 0 ].origin );
            println( "<dev string:x26a>" + angles );
        #/
        
        thread spawnbradleynoduration( level.tankstartspawnaxiscmd[ 0 ].origin, angles, "axis" );
    }
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 0
// Checksum 0x0, Offset: 0xd03
// Size: 0x111
function kickoffneutralbradleyspawnstdm()
{
    level endon( "game_ended" );
    wait 12;
    tankspawn = random( level.tankstartspawnneutral );
    angles = ( 0, 0, 0 );
    
    if ( isdefined( tankspawn.angles ) )
    {
        angles = tankspawn.angles;
    }
    
    /#
        println( "<dev string:x29c>" + tankspawn.origin );
        println( "<dev string:x2bb>" + angles );
    #/
    
    thread spawnbradleynoduration( tankspawn.origin, angles );
    timelimit = gettimelimit();
    timelimitmin = timelimit / 3;
    spawntime = max( timelimitmin, 180 );
    spawntime = min( spawntime, 240 );
    
    while ( true )
    {
        wait spawntime;
        
        if ( vehicle_tracking_getgameinstances( "light_tank" ).size < 2 )
        {
            tankspawn = selectneutralspawn();
            thread spawnbradleynoduration( tankspawn.origin, tankspawn.angles );
        }
    }
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 0
// Checksum 0x0, Offset: 0xe1c
// Size: 0x89
function kickoffneutralbradleyspawnsdom()
{
    level endon( "game_ended" );
    wait 60;
    timelimit = gettimelimit();
    timelimitmin = timelimit / 3;
    spawntime = max( timelimitmin, 180 );
    spawntime = min( spawntime, 240 );
    
    while ( true )
    {
        wait spawntime;
        
        if ( vehicle_tracking_getgameinstances( "light_tank" ).size < 2 )
        {
            dompt = selectdomspawn();
            
            if ( !isdefined( dompt ) )
            {
                dompt = delayspawnuntilpointcap();
            }
            
            spawndombradley( dompt );
        }
    }
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 1
// Checksum 0x0, Offset: 0xead
// Size: 0xc2
function spawndombradley( dompt )
{
    if ( dompt.objectivekey == "_a" )
    {
        tankspawn = random( level.tankspawndom_a );
    }
    else if ( dompt.objectivekey == "_b" )
    {
        tankspawn = random( level.tankspawndom_b );
    }
    else
    {
        tankspawn = random( level.tankspawndom_c );
    }
    
    if ( isdefined( tankspawn ) )
    {
        angles = ( 0, 0, 0 );
        
        if ( isdefined( tankspawn.angles ) )
        {
            angles = tankspawn.angles;
        }
        
        thread spawnbradleynoduration( tankspawn.origin, angles );
    }
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 1
// Checksum 0x0, Offset: 0xf77
// Size: 0x176
function tryspawnneutralbradleycmd( point )
{
    if ( vehicle_tracking_getgameinstances( "light_tank" ).size < 2 )
    {
        if ( point == 1 )
        {
            if ( level.tankspawncmd_1.size != 0 )
            {
                angles = ( 0, 0, 0 );
                tankspawn = random( level.tankspawncmd_1 );
                
                if ( isdefined( tankspawn.angles ) )
                {
                    angles = tankspawn.angles;
                }
                
                thread spawnbradleynoduration( tankspawn.origin, angles, "allies" );
            }
            
            return;
        }
        
        if ( point == 2 )
        {
            if ( level.tankspawncmd_2.size != 0 )
            {
                angles = ( 0, 0, 0 );
                tankspawn = random( level.tankspawncmd_2 );
                
                if ( isdefined( tankspawn.angles ) )
                {
                    angles = tankspawn.angles;
                }
                
                thread spawnbradleynoduration( tankspawn.origin, angles, "allies" );
            }
            
            return;
        }
        
        if ( point == 3 )
        {
            if ( level.tankspawncmd_3.size != 0 )
            {
                angles = ( 0, 0, 0 );
                tankspawn = random( level.tankspawncmd_3 );
                
                if ( isdefined( tankspawn.angles ) )
                {
                    angles = tankspawn.angles;
                }
                
                thread spawnbradleynoduration( tankspawn.origin, angles, "allies" );
            }
        }
    }
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 0
// Checksum 0x0, Offset: 0x10f5
// Size: 0x2d
function delayspawnuntilpointcap()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        wait 3;
        dompt = selectdomspawn();
        
        if ( isdefined( dompt ) )
        {
            return dompt;
        }
    }
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 0
// Checksum 0x0, Offset: 0x112a
// Size: 0x1e
function selectneutralspawn()
{
    tankspawn = random( level.tankstartspawnneutral );
    return tankspawn;
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 0
// Checksum 0x0, Offset: 0x1151
// Size: 0x8b
function selectdomspawn()
{
    allypoints = scripts\mp\gametypes\dom::getteamdompoints( "allies" );
    axispoints = scripts\mp\gametypes\dom::getteamdompoints( "axis" );
    neutralpoints = scripts\mp\gametypes\dom::getteamdompoints( "neutral" );
    
    if ( allypoints.size == 3 || axispoints.size == 3 )
    {
        return undefined;
    }
    else if ( allypoints.size < axispoints.size )
    {
        if ( allypoints.size == 0 )
        {
            return neutralpoints[ 0 ];
        }
        
        return allypoints[ 0 ];
    }
    else if ( allypoints.size > axispoints.size )
    {
        if ( axispoints.size == 0 )
        {
            return neutralpoints[ 0 ];
        }
        
        return axispoints[ 0 ];
    }
    
    return undefined;
}

// Namespace bradley_spawner / scripts\mp\gametypes\bradley_spawner
// Params 3
// Checksum 0x0, Offset: 0x11e5
// Size: 0xd4
function spawnbradleynoduration( position, angles, team )
{
    assert( issharedfuncdefined( "<dev string:x1c>", "<dev string:x2a>" ), "<dev string:x3b>" );
    
    if ( !issharedfuncdefined( "light_tank", "initSpawnData" ) )
    {
        return;
    }
    
    spawndata = spawnstruct();
    [[ getsharedfunc( "light_tank", "initSpawnData" ) ]]( spawndata );
    spawndata.cantimeout = 0;
    spawndata.spawnmethod = "airdrop_at_position";
    spawndata.origin = position;
    spawndata.angles = angles;
    spawndata.team = team;
    tank = [[ getsharedfunc( "light_tank", "tankSpawn" ) ]]( spawndata );
}

