#using scripts\common\utility;
#using scripts\engine\utility;

#namespace vehicle_tracking;

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 2
// Checksum 0x0, Offset: 0x1a8
// Size: 0x1bc
function _spawnvehicle( spawndata, faildata )
{
    /#
        function_3a040ff591c32b5c( spawndata );
    #/
    
    if ( !istrue( spawndata.startsuspended ) )
    {
        if ( !canspawnvehicle() )
        {
            if ( isdefined( faildata ) )
            {
                faildata.fail = "total_limit_exceeded";
            }
            
            /#
                if ( istrue( level.debugvehiclespawns ) )
                {
                    println( "<dev string:x1c>" + spawndata.modelname + "<dev string:x49>" + level.vehiclecount + "<dev string:x63>" + level.maxvehiclecount );
                }
            #/
            
            if ( level.var_6fc6b49b8704877f )
            {
                logprint( "[VEHICLE_TRACKING] Failed to spawn the vehicle [" + spawndata.targetname + "] because the spawn limit [" + level.maxvehiclecount + "] has been reached." );
            }
            
            return undefined;
        }
    }
    
    vehicle = spawnvehicle( spawndata.modelname, spawndata.targetname, spawndata.vehicletype, spawndata.origin, spawndata.angles, spawndata.owner, spawndata.initialvelocity, spawndata.dospawnedcallback );
    
    if ( !isdefined( vehicle ) )
    {
        if ( isdefined( faildata ) )
        {
            faildata.fail = "code";
        }
        
        /#
            if ( istrue( level.debugvehiclespawns ) )
            {
                println( "<dev string:x80>" + spawndata.modelname );
            }
        #/
        
        if ( level.var_6fc6b49b8704877f )
        {
            logprint( "[VEHICLE_TRACKING] Failed to spawn the vehicle [" + spawndata.targetname + "] because of a code error." );
        }
        
        return undefined;
    }
    
    vehicle.spawndata = spawndata;
    level.vehiclecount++;
    return vehicle;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 5
// Checksum 0x0, Offset: 0x36d
// Size: 0x11d
function _spawnhelicopter( owner, origin, angles, type, modelname )
{
    faildata = spawnstruct();
    spawndata = spawnstruct();
    spawndata.modelname = modelname;
    spawndata.vehicletype = type;
    spawndata.origin = origin;
    spawndata.angles = angles;
    spawndata.owner = owner;
    
    if ( !canspawnvehicle() )
    {
        if ( isdefined( faildata ) )
        {
            faildata.fail = "total_limit_exceeded";
        }
        
        return undefined;
    }
    
    vehicle = spawnhelicopter( spawndata.owner, spawndata.origin, spawndata.angles, spawndata.vehicletype, spawndata.modelname );
    
    if ( !isdefined( vehicle ) )
    {
        if ( isdefined( faildata ) )
        {
            faildata.fail = "code";
        }
        
        return undefined;
    }
    
    level.vehiclecount++;
    return vehicle;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 1
// Checksum 0x0, Offset: 0x493
// Size: 0xa2
function _deletevehicle( vehicle )
{
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle notify( "vehicle_deleted" );
    level.vehiclecount--;
    
    if ( isdefined( level.vehicle.instances ) && isdefined( level.vehicle.instances[ vehicle.vehiclename ] ) && isdefined( level.vehicle.instances[ vehicle.vehiclename ][ vehicle getentitynumber() ] ) )
    {
        vehicle_tracking_deregisterinstance( vehicle );
    }
    
    function_d21abb198361e610( vehicle );
    vehicle delete();
    return 1;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 1
// Checksum 0x0, Offset: 0x53e
// Size: 0x10e
function function_d21abb198361e610( vehicle )
{
    if ( !isdefined( vehicle.linkedchildren ) )
    {
        return;
    }
    
    foreach ( scriptable in vehicle.linkedchildren )
    {
        if ( !isdefined( scriptable ) )
        {
            continue;
        }
        
        if ( isdefined( scriptable.type ) && scripts\engine\utility::issharedfuncdefined( scriptable.type, "delete" ) && scriptable [[ scripts\engine\utility::getsharedfunc( scriptable.type, "delete" ) ]]() )
        {
            continue;
        }
        
        scriptable notify( "death" );
        scriptable script_func( "deregisterScriptable" );
        
        if ( scriptable getscriptableisreserved() )
        {
            scriptable freescriptable();
            continue;
        }
        
        part = scriptable function_ec5f4851431f3382();
        
        if ( scriptable getscriptableparthasstate( part, "hidden" ) )
        {
            scriptable setscriptablepartstate( part, "hidden" );
        }
    }
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 0
// Checksum 0x0, Offset: 0x654
// Size: 0x15, Type: bool
function canspawnvehicle()
{
    return level.vehiclecount < level.maxvehiclecount;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 0
// Checksum 0x0, Offset: 0x672
// Size: 0xb
function getvehiclecount()
{
    return level.vehiclecount;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 1
// Checksum 0x0, Offset: 0x686
// Size: 0x63, Type: bool
function reservevehicle( count )
{
    if ( canspawnvehicle() )
    {
        if ( !isdefined( count ) )
        {
            level.vehiclecount++;
            return true;
        }
        
        availablevehicles = level.maxvehiclecount - level.vehiclecount;
        
        if ( count <= availablevehicles )
        {
            level.vehiclecount += count;
            return true;
        }
    }
    
    return false;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 1
// Checksum 0x0, Offset: 0x6f2
// Size: 0x62
function clearvehiclereservation( count )
{
    if ( !isdefined( count ) )
    {
        count = 1;
    }
    
    level.vehiclecount -= count;
    
    /#
        if ( level.vehiclecount < 0 )
        {
            scripts\engine\utility::error( "<dev string:xba>" );
        }
    #/
    
    level.vehiclecount = int( max( 0, level.vehiclecount ) );
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 1
// Checksum 0x0, Offset: 0x75c
// Size: 0x16
function getvehiclespawndata( vehicle )
{
    return vehicle.spawndata;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 2
// Checksum 0x0, Offset: 0x77b
// Size: 0x16c
function copyvehiclespawndata( from, to )
{
    to.modelname = from.modelname;
    to.skinoverride = from.skinoverride;
    to.targetname = from.targetname;
    to.vehicletype = from.vehicletype;
    to.origin = from.origin;
    to.angles = from.angles;
    to.originalorigin = from.originalorigin;
    to.originalangles = from.originalangles;
    to.owner = from.owner;
    to.initialvelocity = from.initialvelocity;
    to.cannotbesuspended = from.cannotbesuspended;
    to.startsuspended = from.startsuspended;
    to.spawntype = from.spawntype;
    to.team = from.team;
    to.ref = from.ref;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 4
// Checksum 0x0, Offset: 0x8ef
// Size: 0xef
function vehicle_tracking_registerinstance( vehicle, owner, team, var_699ac4a9c9e9f0ec )
{
    assertex( isdefined( level.vehicle ), "<dev string:x100>" );
    assertex( isdefined( level.vehicle.instances ), "<dev string:x145>" );
    assertex( isdefined( vehicle.vehiclename ), "<dev string:x193>" );
    vehicle_tracking_deregisterinstance( vehicle );
    level.vehicle.instances[ vehicle.vehiclename ][ vehicle getentitynumber() ] = vehicle;
    vehicle.vehicleowner = owner;
    vehicle.vehicleteam = team;
    vehicle.var_699ac4a9c9e9f0ec = var_699ac4a9c9e9f0ec;
    
    if ( !istrue( var_699ac4a9c9e9f0ec ) )
    {
        level.vehicle.var_3af6263662b92655[ vehicle getentitynumber() ] = vehicle;
    }
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 1
// Checksum 0x0, Offset: 0x9e6
// Size: 0x114
function vehicle_tracking_deregisterinstance( vehicle )
{
    assertex( isdefined( vehicle.vehiclename ), "<dev string:x1da>" );
    
    if ( !isdefined( level.vehicle ) )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle.instances ) )
    {
        return;
    }
    
    if ( !isdefined( level.vehicle.instances[ vehicle.vehiclename ] ) )
    {
        return;
    }
    
    level.vehicle.instances[ vehicle.vehiclename ][ vehicle getentitynumber() ] = undefined;
    level.vehicle.var_3af6263662b92655[ vehicle getentitynumber() ] = undefined;
    
    if ( level.vehicle.instances[ vehicle.vehiclename ].size <= 0 )
    {
        level.vehicle.instances[ vehicle.vehiclename ] = undefined;
    }
    
    vehicle.vehicleowner = undefined;
    vehicle.vehicleteam = undefined;
    vehicle.var_699ac4a9c9e9f0ec = undefined;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 3
// Checksum 0x0, Offset: 0xb02
// Size: 0x83
function vehicle_tracking_limitgameinstances( vehiclename, limit, message )
{
    assertex( isdefined( level.vehicle ), "<dev string:x223>" );
    assertex( isdefined( level.vehicle.instances ), "<dev string:x26a>" );
    level.vehicle.instancelimits[ vehiclename ] = limit;
    level.vehicle.instancelimitmessages[ vehiclename ] = message;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 3
// Checksum 0x0, Offset: 0xb8d
// Size: 0x9e
function function_5c8408cb68649308( vehiclename, spawntype, limit )
{
    assertex( isdefined( level.vehicle ), "<dev string:x223>" );
    assertex( isdefined( level.vehicle.instances ), "<dev string:x26a>" );
    
    if ( !isdefined( level.vehicle.spawntypeinstancelimits[ vehiclename ] ) )
    {
        level.vehicle.spawntypeinstancelimits[ vehiclename ] = [];
    }
    
    level.vehicle.spawntypeinstancelimits[ vehiclename ][ spawntype ] = limit;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 3
// Checksum 0x0, Offset: 0xc33
// Size: 0x83
function vehicle_tracking_limitownerinstances( vehiclename, limit, message )
{
    assertex( isdefined( level.vehicle ), "<dev string:x2ba>" );
    assertex( isdefined( level.vehicle.instances ), "<dev string:x302>" );
    level.vehicle.ownerinstancelimits[ vehiclename ] = limit;
    level.vehicle.ownerinstancelimitmessages[ vehiclename ] = message;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 3
// Checksum 0x0, Offset: 0xcbe
// Size: 0x83
function vehicle_tracking_limitteaminstances( vehiclename, limit, message )
{
    assertex( isdefined( level.vehicle ), "<dev string:x353>" );
    assertex( isdefined( level.vehicle.instances ), "<dev string:x39a>" );
    level.vehicle.teaminstancelimits[ vehiclename ] = limit;
    level.vehicle.teaminstancelimitmessages[ vehiclename ] = message;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 5
// Checksum 0x0, Offset: 0xd49
// Size: 0x30d, Type: bool
function vehicle_tracking_atinstancelimit( vehiclename, owner, team, spawntype, sendmessage )
{
    assertex( isdefined( level.vehicle ), "<dev string:x3ea>" );
    assertex( isdefined( level.vehicle.instances ), "<dev string:x42e>" );
    
    if ( !isdefined( level.vehicle.instances[ vehiclename ] ) )
    {
        return false;
    }
    
    gamelimit = level.vehicle.instancelimits[ vehiclename ];
    
    if ( isdefined( gamelimit ) )
    {
        if ( isdefined( level.vehicle.instances[ vehiclename ] ) && level.vehicle.instances[ vehiclename ].size >= gamelimit )
        {
            return true;
        }
    }
    
    spawntypelimit = undefined;
    spawntypecount = undefined;
    
    if ( isdefined( spawntype ) && isdefined( level.vehicle.spawntypeinstancelimits ) && isdefined( level.vehicle.spawntypeinstancelimits[ vehiclename ] ) && isdefined( level.vehicle.spawntypeinstancelimits[ vehiclename ][ spawntype ] ) )
    {
        spawntypelimit = level.vehicle.spawntypeinstancelimits[ vehiclename ][ spawntype ];
        spawntypecount = 0;
    }
    
    ownerlimit = undefined;
    ownercount = undefined;
    
    if ( isdefined( owner ) )
    {
        ownerlimit = level.vehicle.ownerinstancelimits[ vehiclename ];
        ownercount = 0;
    }
    
    teamlimit = undefined;
    teamcount = undefined;
    
    if ( isdefined( team ) )
    {
        teamlimit = level.vehicle.teaminstancelimits[ vehiclename ];
        teamcount = 0;
    }
    
    if ( !isdefined( ownerlimit ) && !isdefined( teamlimit ) && !isdefined( spawntypelimit ) )
    {
        return false;
    }
    
    foreach ( instance in level.vehicle.instances[ vehiclename ] )
    {
        if ( isdefined( ownerlimit ) && isdefined( instance.vehicleowner ) && instance.vehicleowner == owner )
        {
            ownercount++;
            
            if ( ownercount >= ownerlimit )
            {
                return true;
            }
        }
        
        if ( isdefined( teamlimit ) && isdefined( instance.vehicleteam ) && instance.vehicleteam == team )
        {
            teamcount++;
            
            if ( teamcount >= teamlimit )
            {
                return true;
            }
        }
        
        if ( isdefined( spawntypelimit ) && isdefined( instance.spawndata ) && isdefined( instance.spawndata.spawntype ) && instance.spawndata.spawntype == spawntype )
        {
            spawntypecount++;
            
            if ( spawntypecount >= spawntypelimit )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 1
// Checksum 0x0, Offset: 0x105f
// Size: 0x75
function vehicle_tracking_getgameinstances( vehiclename )
{
    assertex( isdefined( level.vehicle ), "<dev string:x47b>" );
    assertex( isdefined( level.vehicle.instances ), "<dev string:x4c0>" );
    
    if ( !isdefined( level.vehicle.instances[ vehiclename ] ) )
    {
        return [];
    }
    
    return level.vehicle.instances[ vehiclename ];
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 2
// Checksum 0x0, Offset: 0x10dd
// Size: 0xf2
function vehicle_tracking_getownerinstances( vehiclename, owner )
{
    assertex( isdefined( level.vehicle ), "<dev string:x50e>" );
    assertex( isdefined( level.vehicle.instances ), "<dev string:x554>" );
    
    if ( !isdefined( level.vehicle.instances[ vehiclename ] ) )
    {
        return [];
    }
    
    instances = [];
    
    foreach ( instance in level.vehicle.instances[ vehiclename ] )
    {
        if ( isdefined( instance.vehicleowner ) && instance.vehicleowner == owner )
        {
            instances[ instances.size ] = instance;
        }
    }
    
    return instances;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 2
// Checksum 0x0, Offset: 0x11d8
// Size: 0xf2
function vehicle_tracking_getteaminstances( vehiclename, team )
{
    assertex( isdefined( level.vehicle ), "<dev string:x5a3>" );
    assertex( isdefined( level.vehicle.instances ), "<dev string:x5e8>" );
    
    if ( !isdefined( level.vehicle.instances[ vehiclename ] ) )
    {
        return [];
    }
    
    instances = [];
    
    foreach ( instance in level.vehicle.instances[ vehiclename ] )
    {
        if ( isdefined( instance.vehicleteam ) && instance.vehicleteam == team )
        {
            instances[ instances.size ] = instance;
        }
    }
    
    return instances;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 0
// Checksum 0x0, Offset: 0x12d3
// Size: 0xdf
function vehicle_tracking_getgameinstancesforall()
{
    assertex( isdefined( level.vehicle ), "<dev string:x636>" );
    
    if ( !isdefined( level.vehicle.instances ) )
    {
        return [];
    }
    
    instances = [];
    
    foreach ( instancearr in level.vehicle.instances )
    {
        foreach ( instance in instancearr )
        {
            instances[ instances.size ] = instance;
        }
    }
    
    return instances;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 1
// Checksum 0x0, Offset: 0x13bb
// Size: 0xb6, Type: bool
function vehicle_tracking_instancesarelimited( vehiclename )
{
    assertex( isdefined( level.vehicle ), "<dev string:x681>" );
    assertex( isdefined( level.vehicle.instances ), "<dev string:x6c9>" );
    
    if ( isdefined( level.vehicle.instancelimits[ vehiclename ] ) )
    {
        return true;
    }
    
    if ( isdefined( level.vehicle.ownerinstancelimits[ vehiclename ] ) )
    {
        return true;
    }
    
    if ( isdefined( level.vehicle.teaminstancelimits[ vehiclename ] ) )
    {
        return true;
    }
    
    if ( isdefined( level.vehicle.spawntypeinstancelimits[ vehiclename ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 0
// Checksum 0x0, Offset: 0x147a
// Size: 0x4f
function function_59e95ab1ae37120a()
{
    assertex( isdefined( level.vehicle ), "<dev string:x71a>" );
    assertex( isdefined( level.vehicle.var_3af6263662b92655 ), "<dev string:x755>" );
    return level.vehicle.var_3af6263662b92655;
}

// Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
// Params 0
// Checksum 0x0, Offset: 0x14d2
// Size: 0x142
function vehicle_tracking_init()
{
    assertex( isdefined( level.vehicle ), "<dev string:x799>" );
    assertex( !isdefined( level.vehicle.instances ), "<dev string:x7d2>" );
    level.vehicle.instances = [];
    level.vehicle.var_3af6263662b92655 = [];
    level.vehicle.instancelimits = [];
    level.vehicle.ownerinstancelimits = [];
    level.vehicle.teaminstancelimits = [];
    level.vehicle.spawntypeinstancelimits = [];
    level.vehicle.instancelimitmessages = [];
    level.vehicle.ownerinstancelimitmessages = [];
    level.vehicle.teaminstancelimitmessages = [];
    level.vehiclecount = 0;
    level.maxvehiclecount = getdvarint( @"scr_maxvehiclecount", 128 );
    level.var_6fc6b49b8704877f = getdvarint( @"hash_c9b6891700ca109", 0 );
    level utility::flag_set( "vehicle_tracking_initialized" );
}

/#

    // Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
    // Params 1
    // Checksum 0x0, Offset: 0x161c
    // Size: 0x61, Type: dev
    function validatespawndata( spawndata )
    {
        if ( !isdefined( spawndata ) )
        {
            thread error( "<dev string:x809>" );
            return 0;
        }
        
        if ( !isdefined( spawndata.origin ) )
        {
            thread error( "<dev string:x827>" );
            return 0;
        }
        
        if ( !isdefined( spawndata.angles ) )
        {
            thread error( "<dev string:x84c>" );
            return 0;
        }
        
        return 1;
    }

    // Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
    // Params 1
    // Checksum 0x0, Offset: 0x1685
    // Size: 0x59, Type: dev
    function function_3a040ff591c32b5c( spawndata )
    {
        if ( !validatespawndata( spawndata ) )
        {
            return 0;
        }
        
        if ( !isdefined( spawndata.vehicletype ) )
        {
            thread error( "<dev string:x871>" );
            return 0;
        }
        
        if ( !isdefined( spawndata.targetname ) )
        {
            thread error( "<dev string:x89b>" );
            return 0;
        }
        
        return 1;
    }

    // Namespace vehicle_tracking / scripts\cp_mp\vehicles\vehicle_tracking
    // Params 1
    // Checksum 0x0, Offset: 0x16e6
    // Size: 0x77, Type: dev
    function function_298430b99bada795( spawndata )
    {
        if ( !validatespawndata( spawndata ) )
        {
            return 0;
        }
        
        if ( !isdefined( spawndata.owner ) )
        {
            thread error( "<dev string:x8c4>" );
            return 0;
        }
        
        if ( !isdefined( spawndata.vehicletype ) )
        {
            thread error( "<dev string:x871>" );
            return 0;
        }
        
        if ( !isdefined( spawndata.modelname ) )
        {
            thread error( "<dev string:x8e8>" );
            return 0;
        }
        
        return 1;
    }

#/
