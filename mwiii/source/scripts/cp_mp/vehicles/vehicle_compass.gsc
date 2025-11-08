#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;

#namespace vehicle_compass;

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 1
// Checksum 0x0, Offset: 0x106
// Size: 0x39
function vehicle_compass_registerinstance( vehicle )
{
    leveldata = vehicle_compass_getleveldata();
    leveldata.instances[ vehicle getentitynumber() ] = vehicle;
    vehicle_compass_show( vehicle );
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 1
// Checksum 0x0, Offset: 0x147
// Size: 0x2f
function vehicle_compass_deregisterinstance( vehicle )
{
    leveldata = vehicle_compass_getleveldata();
    leveldata.instances[ vehicle getentitynumber() ] = undefined;
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 1
// Checksum 0x0, Offset: 0x17e
// Size: 0x48, Type: bool
function vehicle_compass_instanceisregistered( vehicle )
{
    leveldata = vehicle_compass_getleveldata();
    return isdefined( leveldata.instances[ vehicle getentitynumber() ] ) && leveldata.instances[ vehicle getentitynumber() ] == vehicle;
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 3
// Checksum 0x0, Offset: 0x1cf
// Size: 0x81
function vehicle_compass_updatevisibilityforplayer( vehicle, player, var_6ecb77fd1f27c667 )
{
    leveldata = vehicle_compass_getleveldata();
    
    if ( !leveldata.visibilityisscriptcontrolled )
    {
        return;
    }
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    if ( !vehicle_compass_instanceisregistered( vehicle ) )
    {
        if ( !istrue( var_6ecb77fd1f27c667 ) )
        {
            assertmsg( "<dev string:x1c>" );
        }
        
        return;
    }
    
    if ( !vehicle_compass_shouldbevisibletoplayer( vehicle, player ) )
    {
        vehicle vehicleshowonminimapforclient( player, 0 );
        return;
    }
    
    vehicle vehicleshowonminimapforclient( player, 1 );
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 2
// Checksum 0x0, Offset: 0x258
// Size: 0xa5
function vehicle_compass_updatevisibilityforallplayers( vehicle, var_6ecb77fd1f27c667 )
{
    leveldata = vehicle_compass_getleveldata();
    
    if ( !leveldata.visibilityisscriptcontrolled )
    {
        return;
    }
    
    if ( !vehicle_compass_instanceisregistered( vehicle ) )
    {
        if ( !istrue( var_6ecb77fd1f27c667 ) )
        {
            assertmsg( "<dev string:x6e>" );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        vehicle_compass_updatevisibilityforplayer( vehicle, player );
    }
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 1
// Checksum 0x0, Offset: 0x305
// Size: 0x82
function vehicle_compass_updateallvisibilityforplayer( player )
{
    leveldata = vehicle_compass_getleveldata();
    
    if ( !istrue( leveldata.visibilityisscriptcontrolled ) )
    {
        return;
    }
    
    foreach ( instance in leveldata.instances )
    {
        vehicle_compass_updatevisibilityforplayer( instance, player );
    }
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 2
// Checksum 0x0, Offset: 0x38f
// Size: 0x4f
function vehicle_compass_shouldbevisibletoplayer( vehicle, player )
{
    if ( issharedfuncdefined( "vehicle_compass", "shouldBeVisibleToPlayer" ) )
    {
        shouldbevisibletoplayer = [[ getsharedfunc( "vehicle_compass", "shouldBeVisibleToPlayer" ) ]]( vehicle, player );
        
        if ( isdefined( shouldbevisibletoplayer ) )
        {
            return shouldbevisibletoplayer;
        }
    }
    
    return 1;
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 1
// Checksum 0x0, Offset: 0x3e7
// Size: 0x81
function vehicle_compass_show( vehicle )
{
    leveldata = vehicle_compass_getleveldata();
    
    if ( leveldata.visibilityisscriptcontrolled )
    {
        vehicle vehicleshowonminimap( 1 );
    }
    
    if ( isdefined( leveldata.instances[ vehicle getentitynumber() ] ) )
    {
        if ( level.teambased )
        {
            vehicle_compass_setteamfriendlyto( vehicle, scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getteamfriendlyto( vehicle ) );
        }
        else
        {
            vehicle_compass_setplayerfriendlyto( vehicle, scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getplayerfriendlyto( vehicle ) );
        }
        
        vehicle_compass_updatevisibilityforallplayers( vehicle, 1 );
    }
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 1
// Checksum 0x0, Offset: 0x470
// Size: 0x45
function vehicle_compass_hide( vehicle )
{
    leveldata = vehicle_compass_getleveldata();
    leveldata.instances[ vehicle getentitynumber() ] = undefined;
    
    if ( leveldata.visibilityisscriptcontrolled )
    {
        vehicle vehicleshowonminimap( 0 );
    }
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 2
// Checksum 0x0, Offset: 0x4bd
// Size: 0xb8
function vehicle_compass_setteamfriendlyto( vehicle, team )
{
    if ( iscp() )
    {
        var_1e5f7ff00358bc18 = isdefined( vehicle.riders ) && vehicle.riders.size > 0 || isdefined( vehicle.runningtovehicle ) && vehicle.runningtovehicle.size > 0;
        
        if ( !isdefined( team ) || team == "neutral" || istrue( vehicle.isempty ) && !var_1e5f7ff00358bc18 )
        {
            team = "none";
        }
    }
    else if ( !isdefined( team ) || team == "neutral" )
    {
        team = "none";
    }
    
    vehicle setvehicleteam( team );
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 2
// Checksum 0x0, Offset: 0x57d
// Size: 0x1b
function vehicle_compass_setplayerfriendlyto( vehicle, player )
{
    vehicle setentityowner( undefined );
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 0
// Checksum 0x0, Offset: 0x5a0
// Size: 0xeb
function vehicle_compass_init()
{
    assertex( isdefined( level.vehicle ), "<dev string:xc4>" );
    assertex( !isdefined( level.vehicle.compass ), "<dev string:xfc>" );
    leveldata = spawnstruct();
    level.vehicle.compass = leveldata;
    leveldata.instances = [];
    runleanthreadmode = 0;
    
    if ( issharedfuncdefined( "game", "runLeanThreadMode" ) )
    {
        runleanthreadmode = [[ getsharedfunc( "game", "runLeanThreadMode" ) ]]();
    }
    
    leveldata.visibilityisscriptcontrolled = !runleanthreadmode || getdvarint( @"hash_61d6ab22f59b15a6", 0 ) > 0;
    
    if ( issharedfuncdefined( "vehicle_compass", "init" ) )
    {
        [[ getsharedfunc( "vehicle_compass", "init" ) ]]();
    }
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 0
// Checksum 0x0, Offset: 0x693
// Size: 0x37
function vehicle_compass_getleveldata()
{
    assertex( isdefined( level.vehicle.compass ), "<dev string:x132>" );
    return level.vehicle.compass;
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 3
// Checksum 0x0, Offset: 0x6d3
// Size: 0x90
function vehicle_compass_friendlystatuschangedcallback( vehicle, var_965ea26e6eb230b9, var_52312180ef1940be )
{
    leveldata = vehicle_compass_getleveldata();
    isregistered = isdefined( leveldata.instances[ vehicle getentitynumber() ] ) && leveldata.instances[ vehicle getentitynumber() ] == vehicle;
    
    if ( !isregistered )
    {
        return;
    }
    
    if ( level.teambased )
    {
        vehicle_compass_setteamfriendlyto( vehicle, var_52312180ef1940be );
    }
    else
    {
        vehicle_compass_setplayerfriendlyto( vehicle, var_52312180ef1940be );
    }
    
    vehicle_compass_updatevisibilityforallplayers( vehicle );
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 1
// Checksum 0x0, Offset: 0x76b
// Size: 0x20
function vehicle_compass_playerjoinedteamcallback( player )
{
    if ( !level.teambased )
    {
        return;
    }
    
    vehicle_compass_updateallvisibilityforplayer( player );
}

// Namespace vehicle_compass / scripts\cp_mp\vehicles\vehicle_compass
// Params 0
// Checksum 0x0, Offset: 0x793
// Size: 0xa
function vehicle_compass_playerspawnedcallback()
{
    vehicle_compass_updateallvisibilityforplayer( self );
}

