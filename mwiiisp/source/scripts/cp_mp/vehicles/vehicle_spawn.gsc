#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;

#namespace vehicle_spawn;

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 2
// Checksum 0x0, Offset: 0x4fd
// Size: 0xcc
function vehicle_spawn_getleveldataforvehicle( vehicleref, create )
{
    if ( istrue( create ) && ( !function_89dc39dc11f3988c( vehicleref ) || !isdefined( function_29b4292c92443328( vehicleref ).spawn ) ) )
    {
        data = undefined;
        
        if ( !function_89dc39dc11f3988c( vehicleref ) )
        {
            data = spawnstruct();
        }
        else
        {
            data = function_29b4292c92443328( vehicleref );
        }
        
        data.spawn = spawnstruct();
        data.spawn.maxinstancecount = 0;
        data.spawn.priority = 50;
        level.var_a0b2c978ca57ffc5[ vehicleref ] = data;
    }
    
    if ( function_89dc39dc11f3988c( vehicleref ) )
    {
        return function_29b4292c92443328( vehicleref ).spawn;
    }
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 2
// Checksum 0x0, Offset: 0x5d1
// Size: 0x1b2
function function_37480e9c9c701cf2( vehicleref, spawndata )
{
    if ( !isdefined( spawndata.angles ) )
    {
        spawndata.angles = ( 0, 0, 0 );
    }
    
    /#
        validatespawndata( spawndata );
    #/
    
    leveldataforvehicle = vehicle_getleveldataforvehicle( vehicleref );
    spawndata.targetname = vehicleref;
    
    if ( isdefined( leveldataforvehicle.vehicle ) )
    {
        spawndata.vehicletype = leveldataforvehicle.vehicle;
    }
    
    if ( isdefined( spawndata.vehicleoverride ) )
    {
        spawndata.vehicletype = spawndata.vehicleoverride;
    }
    
    model = leveldataforvehicle.model;
    
    if ( istrue( spawndata.initai ) && isdefined( leveldataforvehicle.ai.model ) )
    {
        model = leveldataforvehicle.ai.model;
    }
    
    if ( isdefined( spawndata.skinoverride ) )
    {
        spawndata.modelname = spawndata.skinoverride + "::" + model;
    }
    else if ( isdefined( leveldataforvehicle.skinoverride ) && leveldataforvehicle.skinoverride != "" )
    {
        spawndata.modelname = leveldataforvehicle.skinoverride + "::" + model;
    }
    else
    {
        spawndata.modelname = model;
    }
    
    if ( isdefined( spawndata.modeloverride ) )
    {
        spawndata.modelname = spawndata.modeloverride;
    }
    
    return spawndata;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 3
// Checksum 0x0, Offset: 0x78c
// Size: 0x1c0
function function_1cc780d5cac1e7cd( vehicleref, spawndata, fallbackvehicletype )
{
    if ( !isdefined( spawndata.angles ) )
    {
        spawndata.angles = ( 0, 0, 0 );
    }
    
    /#
        validatespawndata( spawndata );
    #/
    
    leveldataforvehicle = vehicle_getleveldataforvehicle( vehicleref );
    spawndata.targetname = leveldataforvehicle.husk.ref;
    spawndata.vehicletype = ter_op( isdefined( leveldataforvehicle.husk.vehicle ), leveldataforvehicle.husk.vehicle, leveldataforvehicle.vehicle );
    huskmodelname = leveldataforvehicle.husk.model;
    
    if ( istrue( leveldataforvehicle.husk.var_45c781fb466d2281 ) )
    {
        if ( isdefined( spawndata.skinoverride ) )
        {
            spawndata.modelname = spawndata.skinoverride + "::" + huskmodelname;
        }
        else if ( isdefined( leveldataforvehicle.skinoverride ) && leveldataforvehicle.skinoverride != "" )
        {
            spawndata.modelname = leveldataforvehicle.skinoverride + "::" + huskmodelname;
        }
        else
        {
            spawndata.modelname = huskmodelname;
        }
    }
    else
    {
        spawndata.modelname = huskmodelname;
    }
    
    if ( !isdefined( spawndata.vehicletype ) )
    {
        spawndata.vehicletype = fallbackvehicletype;
    }
    
    spawndata.dospawnedcallback = 0;
    return spawndata;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 2
// Checksum 0x0, Offset: 0x955
// Size: 0x183
function function_75ce57f81b582b38( vehicle, vehicleref )
{
    leveldataforvehicle = vehicle_getleveldataforvehicle( vehicleref );
    spawndata = spawnstruct();
    spawndata.origin = vehicle.origin;
    spawndata.angles = vehicle.angles;
    spawndata.initialvelocity = anglestoup( vehicle.angles ) * leveldataforvehicle.husk.belowvelocityscale;
    spawndata.var_ec2df2acaf230179 = vehicleref;
    spawndata.huskref = leveldataforvehicle.husk.huskref;
    spawndata.damageableparts = scripts\cp_mp\vehicles\vehicle_damage::function_7a5070220fc8ce9e( vehicleref, vehicle.damageableparts );
    spawndata.basevehiclespawndata = getvehiclespawndata( vehicle );
    spawndata.preventrespawn = vehicle.preventrespawn;
    
    if ( isdefined( spawndata.basevehiclespawndata ) )
    {
        spawndata.skinoverride = spawndata.basevehiclespawndata.skinoverride;
    }
    
    if ( vehicle vehicle_getspeed() > leveldataforvehicle.husk.momentumthreshold )
    {
        spawndata.initialvelocity = vehicle vehicle_getvelocity() * leveldataforvehicle.husk.abovevelocityscale;
    }
    
    return spawndata;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 4
// Checksum 0x0, Offset: 0xae1
// Size: 0x1e0
function vehicle_spawn_canspawnvehicle( vehicleref, owner, team, spawntype )
{
    /#
        if ( istrue( level.debugvehiclespawns ) )
        {
            println( "<dev string:x1c>" + vehicleref );
        }
    #/
    
    if ( canspawnvehicle() )
    {
        /#
            issharedfuncdefined( "<dev string:x4c>", "<dev string:x5a>", 1 );
        #/
        
        if ( [[ getsharedfunc( "vehicle_spawn", "canSpawnVehicle" ) ]]( vehicleref ) )
        {
            if ( isdefined( vehicleref ) )
            {
                if ( !vehicle_tracking_instancesarelimited( vehicleref ) || !vehicle_tracking_atinstancelimit( vehicleref, owner, team, spawntype ) )
                {
                    leveldataforvehicle = vehicle_spawn_getleveldataforvehicle( vehicleref );
                    
                    if ( isdefined( leveldataforvehicle ) )
                    {
                        if ( istrue( level.ignorevehicletypeinstancelimit ) || !isdefined( leveldataforvehicle.maxinstancecount ) || vehicle_tracking_getgameinstances( vehicleref ).size < leveldataforvehicle.maxinstancecount )
                        {
                            if ( isdefined( leveldataforvehicle.canspawncallback ) )
                            {
                                return [[ leveldataforvehicle.canspawncallback ]]( owner, team );
                            }
                            else
                            {
                                return 1;
                            }
                        }
                        else
                        {
                            /#
                                if ( istrue( level.debugvehiclespawns ) )
                                {
                                    println( "<dev string:x6a>" + vehicleref );
                                }
                            #/
                        }
                    }
                    else
                    {
                        /#
                            if ( istrue( level.debugvehiclespawns ) )
                            {
                                println( "<dev string:xa1>" + vehicleref );
                            }
                        #/
                    }
                }
                else
                {
                    /#
                        if ( istrue( level.debugvehiclespawns ) )
                        {
                            println( "<dev string:xd3>" + vehicleref );
                        }
                    #/
                }
            }
            else
            {
                /#
                    if ( istrue( level.debugvehiclespawns ) )
                    {
                        println( "<dev string:x10b>" );
                    }
                #/
            }
        }
        else
        {
            /#
                if ( istrue( level.debugvehiclespawns ) )
                {
                    println( "<dev string:x13a>" + vehicleref );
                }
            #/
        }
    }
    else
    {
        /#
            if ( istrue( level.debugvehiclespawns ) )
            {
                println( "<dev string:x18a>" + vehicleref + "<dev string:x1c7>" + getvehiclecount() + "<dev string:x1c9>" + level.maxvehiclecount );
            }
        #/
    }
    
    return 0;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0xcca
// Size: 0x245
function function_25d4b673539659a1()
{
    while ( !level.var_54c8acfd634a416c )
    {
        waitframe();
    }
    
    var_c9ed6663f76bec8a = [];
    
    foreach ( data in level.var_a0b2c978ca57ffc5 )
    {
        if ( !isdefined( data.spawn ) || !isdefined( data.spawn.var_32b659cdf8f93ae2 ) )
        {
            continue;
        }
        
        var_c9ed6663f76bec8a[ data.spawn.var_32b659cdf8f93ae2 ] = data;
    }
    
    points = [];
    structs = [];
    
    foreach ( data in var_c9ed6663f76bec8a )
    {
        structs = array_combine( structs, getstructarray( targetname, "targetname" ) );
    }
    
    foreach ( struct in structs )
    {
        if ( !isdefined( struct.script_noteworthy ) )
        {
            continue;
        }
        
        num = -1;
        
        switch ( tolower( struct.script_noteworthy ) )
        {
            case #"hash_31103fbc01bd840c":
                num = 0;
                break;
            case #"hash_311042bc01bd88c5":
                num = 1;
                break;
            case #"hash_311041bc01bd8732":
                num = 2;
                break;
            case #"hash_31103cbc01bd7f53":
                num = 3;
                break;
            case #"hash_31103bbc01bd7dc0":
                num = 4;
                break;
        }
        
        if ( num == -1 )
        {
            continue;
        }
        
        points[ num ] = [ var_c9ed6663f76bec8a[ struct.targetname ].ref, struct.origin, struct.angles, struct.script_team ];
    }
    
    return points;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 6
// Checksum 0x0, Offset: 0xf18
// Size: 0xea
function function_9f3ee4972dec5b57( vehicleref, origin, angles, targetname, vehicletype, script_noteworthy )
{
    if ( !isdefined( vehicleref ) || !isdefined( origin ) )
    {
        assertmsg( "Attempted to create a vehicle spawn struct with an undefined vehicle ref or origin" );
        return;
    }
    
    if ( !isdefined( targetname ) )
    {
        targetname = function_348b69ec4082ceba( vehicleref );
    }
    
    if ( !isdefined( vehicletype ) )
    {
        vehicletype = function_8fb5b3da3ad4d628( vehicleref );
    }
    
    if ( !isdefined( targetname ) || !isdefined( vehicletype ) )
    {
        assertmsg( "Attempted to create a vehicle spawn struct for " + vehicleref + " but we didn't find a targetname / vehicle type. It's probably not loaded" );
        return;
    }
    
    struct = spawnstruct();
    struct.origin = origin;
    struct.angles = angles;
    struct.targetname = targetname;
    struct.vehicletype = vehicletype;
    struct.script_noteworthy = script_noteworthy;
    addstruct( struct );
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 1
// Checksum 0x0, Offset: 0x100a
// Size: 0x5d
function function_b08e7e3a0b14f76f( vehicleref )
{
    targetname = function_348b69ec4082ceba( vehicleref );
    
    if ( !isdefined( targetname ) )
    {
        return [];
    }
    
    structs = getstructarray( targetname, "targetname" );
    
    if ( structs.size > 0 )
    {
        structs = vehicle_spawn_removespawnstructswithflag( structs );
        
        if ( structs.size > 1 )
        {
            structs = array_randomize( structs );
        }
    }
    
    return structs;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 1
// Checksum 0x0, Offset: 0x1070
// Size: 0x75
function function_348b69ec4082ceba( vehicleref )
{
    if ( !function_38f50decb5603d7( vehicleref ) )
    {
        return undefined;
    }
    
    if ( !function_89dc39dc11f3988c( vehicleref ) )
    {
        return getscriptbundlefieldvalue( "vehiclebundle:" + vehicleref + ter_op( !iscp(), "_mp", "_cp" ), #"targetname" );
    }
    
    data = function_29b4292c92443328( vehicleref );
    
    if ( isdefined( data ) )
    {
        return data.targetname;
    }
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 1
// Checksum 0x0, Offset: 0x10ed
// Size: 0x75
function function_8fb5b3da3ad4d628( vehicleref )
{
    if ( !function_38f50decb5603d7( vehicleref ) )
    {
        return undefined;
    }
    
    if ( !function_89dc39dc11f3988c( vehicleref ) )
    {
        return getscriptbundlefieldvalue( "vehiclebundle:" + vehicleref + ter_op( !iscp(), "_mp", "_cp" ), #"vehicle" );
    }
    
    data = function_29b4292c92443328( vehicleref );
    
    if ( isdefined( data ) )
    {
        return data.vehicle;
    }
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 1
// Checksum 0x0, Offset: 0x116a
// Size: 0xa8
function vehicle_spawn_removespawnstructswithflag( spawnstructs )
{
    if ( getdvarint( @"hash_d451d5012c6af909", 0 ) == 1 )
    {
        return spawnstructs;
    }
    
    spawnflagmask = 1 >> 0;
    filteredstructs = [];
    
    foreach ( struct in spawnstructs )
    {
        if ( isdefined( struct.spawnflags ) && struct.spawnflags & spawnflagmask )
        {
            continue;
        }
        
        filteredstructs[ filteredstructs.size ] = struct;
    }
    
    return filteredstructs;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x121b
// Size: 0x73
function vehicle_spawn_gamemodesupportsrespawn()
{
    if ( utility::iscp() )
    {
        defaultvalue = 0;
    }
    else
    {
        defaultvalue = 1;
        
        if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
        {
            var_b55edc994348913 = getdvar( @"scr_br_gametype", "" );
            
            if ( var_b55edc994348913 == "plunder" || var_b55edc994348913 == "risk" )
            {
                defaultvalue = 1;
            }
            else
            {
                defaultvalue = 0;
            }
        }
    }
    
    return getdvarint( @"hash_bd25469fa7e9f44f", defaultvalue );
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x1297
// Size: 0x1c2
function vehicle_spawn_init()
{
    assertex( isdefined( level.vehicle ), "vehicle_spawn_init() called before vehicle_init()." );
    assertex( !isdefined( level.vehicle.spawn ), "vehicle_spawn_init() should only be called once." );
    leveldata = spawnstruct();
    level.vehicle.spawn = leveldata;
    leveldata.databyref = [];
    leveldata.spawnfromstructsdelayornotify = 5;
    
    if ( isusingmatchrulesdata() )
    {
        leveldata.respawndelaymatchrules = default_to( getmatchrulesdata( "commonOption", "vehicleRespawnDelay" ), 0 );
        leveldata.abandonedtimeoutmatchrules = default_to( getmatchrulesdata( "commonOption", "vehicleAbandonedTimeout" ), 0 );
    }
    else
    {
        leveldata.respawndelaymatchrules = 0;
        leveldata.abandonedtimeoutmatchrules = 0;
    }
    
    leveldata.respawndelayoverride = getdvarint( @"hash_1f347fd0c3d771a2", 0 );
    leveldata.abandonedtimeoutoverride = getdvarint( @"hash_e547fe8dfe1679f6", 0 );
    leveldata.respawndelay = getdvarint( @"hash_8fdbbb498db9480a", 60 );
    leveldata.abandonedtimeoutdelay = getdvarint( @"hash_36374c04e23480b6", 30 );
    
    /#
        level.debugvehiclespawns = getdvarint( @"hash_528ed37a0fec0b6d", 0 ) == 1;
    #/
    
    vehicle_spawn_initspawnclearance();
    
    /#
        issharedfuncdefined( "<dev string:x4c>", "<dev string:x1cd>", 1 );
    #/
    
    [[ getsharedfunc( "vehicle_spawn", "init" ) ]]();
    vehicle_spawn_initlate();
    level.ignorevehicletypeinstancelimit = getdvarint( @"hash_37f76437c65cd04e", 1 );
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x1461
// Size: 0x28
function vehicle_spawn_initlate()
{
    if ( issharedfuncdefined( "vehicle_spawn", "initLate" ) )
    {
        [[ getsharedfunc( "vehicle_spawn", "initLate" ) ]]();
    }
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 2
// Checksum 0x0, Offset: 0x1491
// Size: 0x2a, Type: bool
function vehicle_spawn_spawnfromstructscomparefunc( vehicledataa, vehicledatab )
{
    return vehicledataa.priority >= vehicledatab.priority;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x14c4
// Size: 0x4f
function vehicle_spawn_getleveldata()
{
    assertex( isdefined( level.vehicle ), "vehicle_spawn_getLevelData() called before vehicle_init()." );
    assertex( isdefined( level.vehicle.spawn ), "vehicle_spawn_getLevelData() called before vehicle_spawn_init()." );
    return level.vehicle.spawn;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x151c
// Size: 0xea, Type: bool
function vehicle_spawn_isvehiclespawnstruct()
{
    targetname = self.targetname;
    
    if ( isdefined( targetname ) )
    {
        switch ( targetname )
        {
            case #"hash_6814f5e14262cd1":
            case #"hash_1479e2073c83cda2":
            case #"hash_1be85ecd6eb9915e":
            case #"hash_257440848fa1e781":
            case #"hash_297027751cd2c948":
            case #"hash_5976269dab51a932":
            case #"hash_5b97d59c5aa200ba":
            case #"hash_5c5417975c844e03":
            case #"hash_8d97f13aa572972d":
            case #"hash_9fae9f2b4d8960b5":
            case #"hash_b970b9f69d11cd68":
            case #"hash_c30f8ac20d6114ae":
            case #"hash_ce76a6942e01af7b":
            case #"hash_e0700813f3933328":
            case #"hash_f248c9f68e2ba5bb":
                return true;
            default:
                return false;
        }
    }
    
    return false;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x160f
// Size: 0x20
function vehicle_spawn_initspawnclearance()
{
    leveldata = vehicle_spawn_getleveldata();
    leveldata.clearancecheckminradii = [];
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 5
// Checksum 0x0, Offset: 0x1637
// Size: 0x2ce, Type: bool
function vehicle_spawn_checkspawnclearance( position, vehicleref, contentsoverride, ignorelistoverride, positionoffsetz )
{
    leveldata = vehicle_spawn_getleveldata();
    checkradius = 200;
    checkheight = 200;
    leveldataforvehicle = vehicle_spawn_getleveldataforvehicle( vehicleref );
    assertex( isdefined( leveldataforvehicle ), "vehicle_spawn_checkSpawnClearance called with an invalid vehicle ref." );
    minradius = leveldataforvehicle.clearancecheckradius;
    
    if ( !isdefined( minradius ) )
    {
        minradius = leveldata.clearancecheckminradii[ vehicleref ];
    }
    
    assertex( isdefined( minradius ), "Could not find a clearanceCheckMinRadius for " + vehicleref + "." );
    
    if ( isdefined( leveldataforvehicle.clearancecheckradius ) )
    {
        checkradius = leveldataforvehicle.clearancecheckradius;
    }
    
    if ( isdefined( leveldataforvehicle.clearancecheckheight ) )
    {
        checkheight = leveldataforvehicle.clearancecheckheight;
    }
    
    if ( isdefined( positionoffsetz ) )
    {
        position += ( 0, 0, positionoffsetz );
    }
    
    radiusvector = ( checkradius, checkradius, checkheight );
    aabbmin = position - radiusvector;
    aabbmax = position + radiusvector;
    contents = contentsoverride;
    
    if ( !isdefined( contents ) )
    {
        contents = physics_createcontents( [ "physicscontents_vehicle" ] );
    }
    
    ignorelist = ignorelistoverride;
    
    if ( !isdefined( ignorelist ) )
    {
        ignorelist = [];
        ignorelist[ ignorelist.size ] = vehicle_tracking_getgameinstances( "emp_drone" );
        ignorelist[ ignorelist.size ] = vehicle_tracking_getgameinstances( "cruise_predator" );
        
        if ( isdefined( level.supportdrones ) )
        {
            ignorelist[ ignorelist.size ] = level.supportdrones;
        }
        
        ignorelist = scripts\engine\utility::array_combine_multiple( ignorelist );
    }
    
    vehicles = physics_aabbbroadphasequery( aabbmin, aabbmax, contents, ignorelist );
    
    if ( isdefined( vehicles ) && vehicles.size > 0 )
    {
        foreach ( vehicle in vehicles )
        {
            if ( isdefined( vehicle.vehiclename ) )
            {
                var_deca1b39a5edfa25 = vehicle_spawn_getleveldataforvehicle( vehicle.vehiclename );
                _minradius = undefined;
                
                if ( isdefined( var_deca1b39a5edfa25 ) )
                {
                    _minradius = var_deca1b39a5edfa25.clearancecheckradius;
                }
                
                if ( !isdefined( _minradius ) )
                {
                    _minradius = leveldata.clearancecheckminradii[ vehicle.vehiclename ];
                }
                
                if ( !isdefined( _minradius ) )
                {
                    continue;
                }
                
                mindist2dsqr = pow( minradius + _minradius, 2 );
                
                if ( isdefined( mindist2dsqr ) && mindist2dsqr < distance2dsquared( vehicle.origin, position ) )
                {
                    continue;
                }
                
                return false;
            }
        }
    }
    
    return true;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 2
// Checksum 0x0, Offset: 0x190e
// Size: 0x58
function vehicle_spawn_setclearancecheckminradius( ref, minradius )
{
    leveldata = vehicle_spawn_getleveldata();
    leveldataforvehicle = vehicle_spawn_getleveldataforvehicle( ref );
    
    if ( isdefined( leveldataforvehicle ) )
    {
        leveldataforvehicle.clearancecheckradius = minradius;
        return;
    }
    
    leveldata.clearancecheckminradii[ ref ] = minradius;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 2
// Checksum 0x0, Offset: 0x196e
// Size: 0x13
function function_b09e91c2e808dbcd( spawndata, faildata )
{
    
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x198a
// Size: 0xa
function function_fa044e2304e9e1a4()
{
    thread function_fc6ead687e73f25f();
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x199c
// Size: 0x51
function function_fc6ead687e73f25f()
{
    spawndata = spawnstruct();
    copyvehiclespawndata( self.basevehiclespawndata, spawndata );
    faildata = spawnstruct();
    vehicle = vehicle_spawn_waitandrespawn( spawndata.targetname, spawndata, faildata );
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x19f5
// Size: 0xa
function function_284795e4a9e3762c()
{
    thread function_9a5d0431afaf5b80();
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x1a07
// Size: 0x75
function function_9a5d0431afaf5b80()
{
    oldspawndata = getvehiclespawndata( self );
    
    if ( isdefined( oldspawndata.basevehiclespawndata ) )
    {
        oldspawndata = oldspawndata.basevehiclespawndata;
    }
    
    spawndata = spawnstruct();
    copyvehiclespawndata( oldspawndata, spawndata );
    faildata = spawnstruct();
    vehicle = vehicle_spawn_waitandrespawn( self.vehiclename, spawndata, faildata );
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 3
// Checksum 0x0, Offset: 0x1a84
// Size: 0x168
function vehicle_spawn_waitandrespawn( ref, spawndata, faildata )
{
    level endon( "game_ended" );
    level endon( "cancel_pending_vehicle_respawns" );
    leveldataforvehicle = vehicle_spawn_getleveldataforvehicle( ref );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    leveldata = vehicle_spawn_getleveldata();
    delay = undefined;
    
    if ( leveldata.respawndelayoverride != 0 )
    {
        delay = leveldata.respawndelayoverride;
    }
    else if ( leveldata.respawndelaymatchrules != 0 )
    {
        delay = leveldata.respawndelaymatchrules;
    }
    else if ( isdefined( leveldataforvehicle.respawndelay ) )
    {
        delay = leveldataforvehicle.respawndelay;
    }
    else
    {
        delay = leveldata.respawndelay;
    }
    
    if ( delay >= 1 )
    {
        if ( delay >= 9999 )
        {
            return undefined;
        }
    }
    else
    {
    }
    
    for ( delay = 1; true ; delay = 5 )
    {
        wait delay;
        
        if ( vehicle_spawn_canspawnvehicle( ref ) )
        {
            if ( issharedfuncdefined( ref, "alterRespawnData" ) )
            {
                spawndata = [[ getsharedfunc( ref, "alterRespawnData" ) ]]( spawndata );
            }
            
            var_c65c40f752ce7d39 = 1;
            
            if ( !var_c65c40f752ce7d39 || vehicle_spawn_checkspawnclearance( spawndata.origin, ref ) )
            {
                vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn( ref, spawndata, faildata );
                
                if ( !isdefined( vehicle ) )
                {
                    continue;
                }
                
                return vehicle;
            }
        }
    }
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 1
// Checksum 0x0, Offset: 0x1bf4
// Size: 0x19
function vehicle_spawn_preventrespawn( vehicle )
{
    vehicle.preventrespawn = 1;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x1c15
// Size: 0xa
function vehicle_spawn_cancelpendingrespawns()
{
    level notify( "cancel_pending_vehicle_respawns" );
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x1c27
// Size: 0x82
function function_6c65df1f40e10037()
{
    if ( istrue( self.donotwatchabandoned ) )
    {
        return;
    }
    
    if ( istrue( self.isdestroyed ) )
    {
        return;
    }
    
    if ( self.occupants.size > 0 )
    {
        return;
    }
    
    if ( isdefined( self.turretoccupants ) && self.turretoccupants.size > 0 )
    {
        return;
    }
    
    if ( isdefined( self.ridingplayers ) && self.ridingplayers.size > 0 )
    {
        return;
    }
    
    self endon( "death" );
    self endon( "stop_watching_abandoned" );
    wait 60;
    scripts\cp_mp\vehicles\vehicle_occupancy::function_887b4e2cbe3ab92c();
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 1
// Checksum 0x0, Offset: 0x1cb1
// Size: 0x8e
function vehicle_spawn_gamemodesupportsabandonedtimeout( ishusk )
{
    defaultvalue = 1;
    
    if ( utility::ismp() && scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        defaultvalue = 0;
    }
    
    if ( utility::iscp() && level.gametype != "cp_survival" )
    {
        defaultvalue = 0;
    }
    
    if ( ishusk && istrue( level.var_45496c9df00f2bd4 ) )
    {
        defaultvalue = 1;
    }
    
    dvar = ter_op( ishusk, @"hash_1d79ef11c80ba28f", @"hash_aa11765fde7e66f6" );
    return getdvarint( dvar, defaultvalue );
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x1d48
// Size: 0x1af
function vehicle_spawn_watchabandoned()
{
    ishusk = isvehiclehusk();
    
    if ( !scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsabandonedtimeout( ishusk ) )
    {
        return;
    }
    
    if ( istrue( self.watchingabandoned ) )
    {
        return;
    }
    
    if ( self.occupants.size > 0 )
    {
        return;
    }
    
    if ( isdefined( self.turretoccupants ) && self.turretoccupants.size > 0 )
    {
        return;
    }
    
    if ( isdefined( self.ridingplayers ) && self.ridingplayers.size > 0 )
    {
        return;
    }
    
    if ( istrue( self.isdestroyed ) )
    {
        return;
    }
    
    if ( istrue( self.donotwatchabandoned ) )
    {
        return;
    }
    
    leveldataforvehicle = vehicle_spawn_getleveldataforvehicle( function_d93ec4635290febd() );
    
    if ( !isdefined( leveldataforvehicle ) )
    {
        return;
    }
    
    if ( !isdefined( leveldataforvehicle.abandonedtimeoutcallback ) )
    {
        return;
    }
    
    self.watchingabandoned = 1;
    self endon( "death" );
    self endon( "stop_watching_abandoned" );
    leveldata = vehicle_spawn_getleveldata();
    delay = undefined;
    
    if ( leveldata.abandonedtimeoutoverride != 0 && !ishusk )
    {
        delay = leveldata.abandonedtimeoutoverride;
    }
    else if ( leveldata.abandonedtimeoutmatchrules != 0 && !ishusk )
    {
        delay = leveldata.abandonedtimeoutmatchrules;
    }
    else if ( isdefined( leveldataforvehicle.abandonedtimeoutdelay ) && !ishusk )
    {
        delay = leveldataforvehicle.abandonedtimeoutdelay;
    }
    else
    {
        delay = leveldata.abandonedtimeoutdelay;
    }
    
    if ( scripts\cp_mp\vehicles\vehicle::isvehicleboat() && self vehicle_isonground() )
    {
        delay *= 0.3;
    }
    
    if ( delay >= 1 )
    {
        if ( delay >= 9999 )
        {
            return;
        }
    }
    else
    {
        delay = 1;
    }
    
    wait delay;
    thread vehicle_spawn_abandonedtimeout();
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x1eff
// Size: 0x14
function vehicle_spawn_stopwatchingabandoned()
{
    self notify( "stop_watching_abandoned" );
    self.watchingabandoned = undefined;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x1f1b
// Size: 0x3b
function vehicle_spawn_abandonedtimeout()
{
    vehicle_spawn_stopwatchingabandoned();
    self.donotwatchabandoned = 1;
    leveldataforvehicle = vehicle_spawn_getleveldataforvehicle( function_d93ec4635290febd() );
    self thread [[ leveldataforvehicle.abandonedtimeoutcallback ]]();
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x1f5e
// Size: 0x1c
function function_357783d7c1d96273()
{
    vehicle_spawn_stopwatchingabandoned();
    self.donotwatchabandoned = 1;
    thread vehicle_spawn_abandonedtimeoutcallback();
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 0
// Checksum 0x0, Offset: 0x1f82
// Size: 0x66
function vehicle_spawn_abandonedtimeoutcallback()
{
    damagestate = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getstate();
    
    if ( damagestate != "heavy" )
    {
        heavystatemaxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getheavystatemaxhealth( self );
        
        if ( isdefined( heavystatemaxhealth ) )
        {
            self.health = int( min( heavystatemaxhealth, self.health ) );
            scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage( self );
        }
        
        scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setstate( "heavy", damagestate );
    }
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 1
// Checksum 0x0, Offset: 0x1ff0
// Size: 0x1c
function function_17bb29fece7da497( vehicleref )
{
    return vehicle_spawn_getleveldataforvehicle( vehicleref ).timeoutonabandoneddelay;
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 1
// Checksum 0x0, Offset: 0x2015
// Size: 0x62
function function_aade62c6cf163888( vehicleref )
{
    data = function_29b4292c92443328( vehicleref );
    
    if ( isdefined( data.husk ) && istrue( data.husk.hashusk ) )
    {
        return function_29b4292c92443328( vehicleref ).husk.vdef;
    }
}

// Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
// Params 1
// Checksum 0x0, Offset: 0x207f
// Size: 0x1c
function function_89cda5ba9bfc8d56( vehicleref )
{
    return function_29b4292c92443328( vehicleref ).transitionparts;
}

/#

    // Namespace vehicle_spawn / scripts\cp_mp\vehicles\vehicle_spawn
    // Params 0
    // Checksum 0x0, Offset: 0x20a4
    // Size: 0xa7, Type: dev
    function vehicle_spawn_initdev()
    {
        setdevdvarifuninitialized( @"hash_d451d5012c6af909", 0 );
        setdevdvarifuninitialized( @"scr_spawnvehicle", "<dev string:x1d2>" );
        setdevdvarifuninitialized( @"hash_37b6962333b896f9", "<dev string:x1d2>" );
        setdevdvarifuninitialized( @"hash_c6bdc7ccd09be1d9", "<dev string:x1d2>" );
        setdevdvarifuninitialized( @"hash_9ec4150c7e03e3ee", "<dev string:x1d2>" );
        setdevdvarifuninitialized( @"hash_1f347fd0c3d771a2", 0 );
        setdevdvarifuninitialized( @"hash_8fdbbb498db9480a", 60 );
        setdevdvarifuninitialized( @"hash_e547fe8dfe1679f6", 0 );
        setdevdvarifuninitialized( @"hash_36374c04e23480b6", 30 );
    }

#/
