#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\anim;

#namespace namespace_a570a67947f18a4d;

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 1
// Checksum 0x0, Offset: 0x4c8
// Size: 0x974
function initelevators( prioritytable )
{
    level.elevators = [];
    level.elevatorsfuncs = [];
    level.elevatorstops = [];
    level.var_52b8e16bc0cd79d6 = 0;
    scriptmodelanims();
    elevatorstops = getentitylessscriptablearray( "elevator_stop", "script_noteworthy" );
    var_ab337e7f8a1fa44a = [];
    
    foreach ( Stop in elevatorstops )
    {
        posstring = Stop.origin[ 0 ] + "," + Stop.origin[ 1 ];
        
        if ( !isdefined( var_ab337e7f8a1fa44a[ posstring ] ) )
        {
            var_ab337e7f8a1fa44a[ posstring ] = [];
        }
        
        var_ab337e7f8a1fa44a[ posstring ][ var_ab337e7f8a1fa44a[ posstring ].size ] = Stop;
        Stop.open = 0;
        [ Stop.indicator ] = getentitylessscriptablearray( Stop.target, "targetname" );
        frontposition = getstruct( Stop.indicator.target, "targetname" );
        Stop.frontposition = frontposition.origin;
        Stop.doors = getentitylessscriptablearray( Stop.indicator.target, "targetname" );
        Stop.var_90dabe3606074803 = getent( Stop.target, "targetname" );
        
        if ( level.mapname == "mp_biobunker" && isdefined( Stop.script_linkname ) && isendstr( Stop.script_linkname, "elevator_50" ) )
        {
            Stop.frontposition = ( -15049, 7096, 1660 );
        }
        
        var_6073fe6ff110d6a8 = getentarray( Stop.indicator.target, "targetname" );
        
        foreach ( targetent in var_6073fe6ff110d6a8 )
        {
            if ( targetent.classname == "script_brushmodel" )
            {
                Stop.aiclip = targetent;
                continue;
            }
            
            if ( targetent.classname == "info_volume" )
            {
                Stop.var_907e66d3bf42c5a = targetent;
            }
        }
        
        foreach ( door in Stop.doors )
        {
            door.open = 0;
            door.clip = getent( door.target, "targetname" );
            door.clip.initialorigin = door.clip.origin;
            openstruct = getstruct( door.clip.target, "targetname" );
            door.clip.openposition = openstruct.origin;
            
            if ( isdefined( openstruct.target ) && openstruct.target != "" )
            {
                bulletclip = getent( openstruct.target, "targetname" );
                door.bulletclip = bulletclip;
            }
        }
        
        Stop.waypointposition = getstruct( Stop.target, "targetname" );
    }
    
    elevatorcars = getstructarray( "elevator_car", "script_noteworthy" );
    
    foreach ( elevatorset in var_ab337e7f8a1fa44a )
    {
        elevator = spawnstruct();
        elevator.parts = [];
        elevator.floors = [];
        group = "elevator_group_free";
        elevator.group = group;
        groundfloorindex = 0;
        
        foreach ( Stop in elevatorset )
        {
            Stop.elevator = elevator;
        }
        
        checkorigin = elevatorset[ groundfloorindex ].origin;
        mindist = undefined;
        targetcar = undefined;
        
        foreach ( car in elevatorcars )
        {
            dist = distancesquared( car.origin, checkorigin );
            
            if ( !isdefined( mindist ) || mindist > dist )
            {
                mindist = dist;
                targetcar = car;
            }
        }
        
        car = spawn( "script_model", targetcar.origin );
        car.angles = targetcar.angles;
        
        switch ( level.mapname )
        {
            case #"hash_721bd15904e6ff51":
                car setmodel( "building_biolabs_elevator_set_int" );
                break;
            case #"hash_5d52d1f62d321d14":
                car setmodel( "building_biobunker_elevator_car_frame_one_way" );
                break;
            default:
                car setmodel( "building_biolabs_elevator_set_int" );
                break;
        }
        
        car.animname = "elevator";
        car setanimtree();
        car.elevator = elevator;
        car.moverdoesnotkill = 1;
        elevator.car = car;
        var_3b8c6779206fb1de = array_sort_with_func( elevatorset, &heightcompare );
        
        for ( i = 0; i < var_3b8c6779206fb1de.size ; i++ )
        {
            elevator.floors[ i ] = var_3b8c6779206fb1de[ i ];
            elevator.floors[ i ].floornum = i;
            
            if ( i > 0 )
            {
                elevator.floors[ i ].targetheight = elevator.floors[ i ].origin[ 2 ] - elevator.floors[ i - 1 ].origin[ 2 ] + elevator.floors[ i - 1 ].targetheight;
            }
            else
            {
                elevator.floors[ i ].targetheight = elevator.car.origin[ 2 ];
            }
            
            elevator.floors[ i ].elevator = elevator;
            elevator.floors[ i ].floor = i;
            floororigin = ( elevator.car.origin[ 0 ], elevator.car.origin[ 1 ], elevator.floors[ i ].targetheight );
            worldfloor = function_135de56d99fc05b8( floororigin );
            elevator.floors[ i ].worldfloor = ter_op( isdefined( worldfloor ), worldfloor, i );
            stopid = function_c10ff09314e3f687( elevatorset[ i ] );
            
            if ( !isdefined( stopid ) )
            {
                level.var_52b8e16bc0cd79d6++;
                stopid = "unAuthorized_stop_" + level.var_52b8e16bc0cd79d6;
            }
            
            elevator.floors[ i ].stopid = stopid;
            level.elevatorstops[ stopid ] = elevator.floors[ i ];
        }
        
        elevator.id = elevator.floors[ 0 ].stopid;
        elevator.currentfloor = 0;
        elevator.targetfloor = 0;
        
        if ( !isdefined( level.elevators[ group ] ) )
        {
            level.elevators[ group ] = [];
        }
        
        level.elevators[ group ][ level.elevators[ group ].size ] = elevator;
    }
    
    level.var_dd26b041c74afbd0 = [];
    level.var_a6c231ab0b186cd7 = [];
    level.var_d4f835afc5b8309b = [];
    level thread function_963fc4c3b794e7f0();
    level thread function_9003bd09b085a887();
    level.var_b212a36bec6cf8da = 1;
    
    if ( isdefined( prioritytable ) )
    {
        function_67e7f45e112e77f2( prioritytable );
    }
    
    /#
        level thread function_cb2806ac4b115c70();
    #/
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 2
// Checksum 0x0, Offset: 0xe44
// Size: 0x30, Type: bool
function heightcompare( target1, target2 )
{
    return target1.origin[ 2 ] < target2.origin[ 2 ];
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 2
// Checksum 0x0, Offset: 0xe7d
// Size: 0x46, Type: bool
function function_298651e30e37ad6a( node1, node2 )
{
    return distancesquared( node1.origin, self.origin ) < distancesquared( node2.origin, self.origin );
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 3
// Checksum 0x0, Offset: 0xecc
// Size: 0x46
function function_ba13d98dab57ca7e( group, state, func )
{
    if ( !isdefined( level.elevatorsfuncs[ group ] ) )
    {
        level.elevatorsfuncs[ group ] = [];
    }
    
    level.elevatorsfuncs[ group ][ state ] = func;
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 8
// Checksum 0x0, Offset: 0xf1a
// Size: 0xd5
function callelevator( owner, group, state, callorigin, pickrule, floors, assignedcallback, var_fd5c5e2ffb3b1d08 )
{
    var_4087e8c204288c38 = spawnstruct();
    var_4087e8c204288c38.owner = owner;
    var_4087e8c204288c38.group = group;
    var_4087e8c204288c38.state = state;
    var_4087e8c204288c38.callorigin = callorigin;
    var_4087e8c204288c38.pickrule = pickrule;
    var_4087e8c204288c38.idealfloors = floors;
    var_4087e8c204288c38.assignedcallback = assignedcallback;
    var_4087e8c204288c38.var_fd5c5e2ffb3b1d08 = var_fd5c5e2ffb3b1d08;
    level.var_a6c231ab0b186cd7[ level.var_a6c231ab0b186cd7.size ] = var_4087e8c204288c38;
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 6
// Checksum 0x0, Offset: 0xff7
// Size: 0xba
function function_20e0f2f56a5ba71f( owner, group, state, id, assignedcallback, var_fd5c5e2ffb3b1d08 )
{
    var_4087e8c204288c38 = spawnstruct();
    var_4087e8c204288c38.owner = owner;
    var_4087e8c204288c38.group = group;
    var_4087e8c204288c38.state = state;
    var_4087e8c204288c38.pickrule = "elevator_pick_rule_id";
    var_4087e8c204288c38.id = id;
    var_4087e8c204288c38.assignedcallback = assignedcallback;
    var_4087e8c204288c38.var_fd5c5e2ffb3b1d08 = var_fd5c5e2ffb3b1d08;
    level.var_a6c231ab0b186cd7[ level.var_a6c231ab0b186cd7.size ] = var_4087e8c204288c38;
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 5
// Checksum 0x0, Offset: 0x10b9
// Size: 0x69
function function_92beb6591366ab26( owner, group, state, callorigin, pickrule )
{
    elevator = undefined;
    
    switch ( pickrule )
    {
        case #"hash_a30cdbeb79218fc6":
            elevator = function_7bee30545564f6d2( callorigin );
            break;
    }
    
    if ( isdefined( elevator ) )
    {
        elevator startelevator( group, state );
    }
    
    return elevator;
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 1
// Checksum 0x0, Offset: 0x112b
// Size: 0x34
function activatefloor( floornum )
{
    if ( !array_contains( level.var_d4f835afc5b8309b, floornum ) )
    {
        level.var_d4f835afc5b8309b[ level.var_d4f835afc5b8309b.size ] = floornum;
    }
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 1
// Checksum 0x0, Offset: 0x1167
// Size: 0x22
function function_e81853b8e49151ba( floornum )
{
    if ( !isdefined( floornum ) )
    {
        return 0;
    }
    
    return array_contains( level.var_d4f835afc5b8309b, floornum );
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 1
// Checksum 0x0, Offset: 0x1192
// Size: 0x25
function function_135de56d99fc05b8( origin )
{
    if ( isdefined( level.var_172e4b629498723c ) )
    {
        return [[ level.var_172e4b629498723c ]]( origin );
    }
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 1
// Checksum 0x0, Offset: 0x11bf
// Size: 0x7f
function function_c10ff09314e3f687( var_d54026d89e48a921 )
{
    if ( isdefined( var_d54026d89e48a921.script_linkname ) )
    {
        groupstr = strtok( var_d54026d89e48a921.script_linkname, "_" );
        
        if ( isdefined( groupstr ) && groupstr.size > 0 )
        {
            stopid = groupstr[ 1 ];
            
            for ( i = 2; i < groupstr.size ; i++ )
            {
                stopid = stopid + "_" + groupstr[ i ];
            }
            
            return stopid;
        }
    }
    
    return undefined;
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 0
// Checksum 0x0, Offset: 0x1247
// Size: 0x95
function function_9003bd09b085a887()
{
    level endon( "game_ended" );
    level waittill( "matchStartTimer_done" );
    
    foreach ( elevator in level.elevators[ "elevator_group_free" ] )
    {
        elevatorextbutton = elevator.floors[ elevator.currentfloor ];
        elevatorextbutton.aiclip disconnectpaths();
    }
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 0
// Checksum 0x0, Offset: 0x12e4
// Size: 0x242
function function_963fc4c3b794e7f0()
{
    level endon( "game_ended" );
    var_34901859711436c9 = 0;
    
    while ( true )
    {
        for ( i = 0; i < level.var_a6c231ab0b186cd7.size ; i++ )
        {
            if ( level.elevators[ "elevator_group_free" ].size > 0 )
            {
                elevator = undefined;
                request = level.var_a6c231ab0b186cd7[ i ];
                
                switch ( request.pickrule )
                {
                    case #"hash_fba835080c4a6b66":
                        elevator = function_7ea9434601358283();
                        break;
                    case #"hash_597ee058566f8b00":
                        assert( isdefined( request.owner ), "<dev string:x1c>" + "<dev string:x48>" );
                        elevator = function_2ddb2d81ee6055ce( request.owner );
                        break;
                    case #"hash_a510ae28921a5f2":
                        assert( isdefined( request.owner ) && isarray( request.idealfloors ), "<dev string:x6f>" + "<dev string:xad>" );
                        elevator = function_2ddb2d81ee6055ce( request.owner, request.idealfloors );
                        break;
                    case #"hash_a30cdbeb79218fc6":
                        assert( isdefined( request.callorigin ), "<dev string:xe4>" + "<dev string:x100>" );
                        elevator = function_7bee30545564f6d2( request.callorigin );
                        break;
                    case #"hash_db4c90c3bb8c6cbc":
                        assert( isdefined( request.id ), "<dev string:x129>" + "<dev string:x142>" );
                        elevator = function_ac05b2a25b870e68( request.id );
                        break;
                }
                
                if ( isdefined( elevator ) )
                {
                    if ( isdefined( request.assignedcallback ) )
                    {
                        level thread [[ request.assignedcallback ]]( elevator, request.var_fd5c5e2ffb3b1d08 );
                    }
                    
                    elevator startelevator( request.group, request.state );
                    level.var_a6c231ab0b186cd7[ i ] = undefined;
                    var_34901859711436c9 = 1;
                }
            }
        }
        
        if ( istrue( var_34901859711436c9 ) )
        {
            level.var_a6c231ab0b186cd7 = array_removeundefined( level.var_a6c231ab0b186cd7 );
            var_34901859711436c9 = 0;
        }
        
        waitframe();
    }
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 1
// Checksum 0x0, Offset: 0x152e
// Size: 0x138
function function_67e7f45e112e77f2( table )
{
    var_8f117d9581995c82 = 0;
    var_bbe34f2ccae3241c = 1;
    numrows = 0;
    
    if ( tableexists( table ) )
    {
        numrows = tablelookupgetnumrows( table );
    }
    else
    {
        assertmsg( table + "<dev string:x163>" );
        return;
    }
    
    level.var_6fdfdc44a9268868 = [];
    
    for ( i = 0; i < numrows ; i++ )
    {
        prioritynode = spawnstruct();
        csvorigin = tablelookupbyrow( table, i, var_8f117d9581995c82 );
        tmporigin = strtok( csvorigin, ", " );
        checkorigin = ( float( tmporigin[ 0 ] ), float( tmporigin[ 1 ] ), float( tmporigin[ 2 ] ) );
        prioritynode.origin = checkorigin;
        prioritynode.enable = 1;
        var_474cb0ec00d51c72 = tablelookupbyrow( table, i, var_bbe34f2ccae3241c );
        var_975cc022038f8367 = strtok( var_474cb0ec00d51c72, ", " );
        prioritynode.elevatorids = var_975cc022038f8367;
        level.var_6fdfdc44a9268868[ i ] = prioritynode;
    }
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 0
// Checksum 0x0, Offset: 0x166e
// Size: 0x5a
function function_7ea9434601358283()
{
    elevator = array_random( level.elevators[ "elevator_group_free" ] );
    
    if ( isdefined( elevator ) )
    {
        if ( elevator.floors.size > 1 )
        {
            elevator.targetfloor = array_random( elevator.floors );
        }
        
        return elevator;
    }
    
    return undefined;
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 1
// Checksum 0x0, Offset: 0x16d1
// Size: 0x183
function function_7bee30545564f6d2( callorigin )
{
    if ( !isdefined( level.var_6fdfdc44a9268868 ) || level.var_6fdfdc44a9268868.size == 0 )
    {
        assertmsg( "<dev string:x175>" );
        return undefined;
    }
    
    originstruct = spawnstruct();
    originstruct.origin = callorigin;
    var_2621d6d616a10f79 = originstruct array_sort_with_func( level.var_6fdfdc44a9268868, &function_298651e30e37ad6a );
    var_57cda711a1d5019b = [];
    
    foreach ( node in var_2621d6d616a10f79 )
    {
        if ( istrue( node.enable ) )
        {
            var_57cda711a1d5019b = node.elevatorids;
            break;
        }
    }
    
    foreach ( stopid in var_57cda711a1d5019b )
    {
        Stop = level.elevatorstops[ stopid ];
        elevator = function_ac05b2a25b870e68( stopid );
        
        if ( isdefined( elevator ) )
        {
            reachable = 1;
            
            if ( isdefined( level.var_6d879681512cd627 ) )
            {
                reachable = [[ level.var_6d879681512cd627 ]]( Stop, callorigin );
            }
            
            if ( reachable )
            {
                return elevator;
            }
        }
    }
    
    return undefined;
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 1
// Checksum 0x0, Offset: 0x185d
// Size: 0x6e
function function_ac05b2a25b870e68( stopid )
{
    Stop = level.elevatorstops[ stopid ];
    
    if ( Stop.elevator.group == "elevator_group_free" )
    {
        Stop.elevator.targetfloor = Stop.floor;
        return Stop.elevator;
    }
    
    return undefined;
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 1
// Checksum 0x0, Offset: 0x18d4
// Size: 0x20
function function_b7ee067fa2ed527d( stopid )
{
    return level.elevatorstops[ stopid ].elevator;
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 1
// Checksum 0x0, Offset: 0x18fd
// Size: 0x16
function function_ea03313f519b9e06( group )
{
    return level.elevators[ group ];
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 1
// Checksum 0x0, Offset: 0x191c
// Size: 0x16
function function_e8f746dfa279cefd( stopid )
{
    return level.elevatorstops[ stopid ];
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 2
// Checksum 0x0, Offset: 0x193b
// Size: 0x114, Type: bool
function function_e273ac02f95d54e5( owner, worldfloors )
{
    foreach ( worldfloor in worldfloors )
    {
        foreach ( Stop in level.elevatorstops )
        {
            if ( worldfloor == Stop.worldfloor )
            {
                var_e3baffc8f1c9431b = Stop.elevator;
                pickedinfo = level.var_dd26b041c74afbd0[ owner ][ var_e3baffc8f1c9431b.id ];
                
                if ( !isdefined( pickedinfo ) || array_contains( pickedinfo.availablefloors, Stop.floor ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 2
// Checksum 0x0, Offset: 0x1a58
// Size: 0x3a4
function function_2ddb2d81ee6055ce( owner, worldfloors )
{
    assertex( isdefined( owner ), "<dev string:x1d4>" );
    
    if ( !isdefined( level.var_dd26b041c74afbd0[ owner ] ) )
    {
        level.var_dd26b041c74afbd0[ owner ] = [];
    }
    
    var_133738871e398cf3 = [];
    
    if ( !isdefined( worldfloors ) )
    {
        var_133738871e398cf3 = level.var_d4f835afc5b8309b;
    }
    else if ( isarray( worldfloors ) )
    {
        foreach ( worldfloor in worldfloors )
        {
            if ( function_e81853b8e49151ba( worldfloor ) )
            {
                var_133738871e398cf3[ var_133738871e398cf3.size ] = worldfloor;
            }
        }
    }
    else
    {
        assert( "<dev string:x206>" );
        return undefined;
    }
    
    if ( var_133738871e398cf3.size == 0 )
    {
        return undefined;
    }
    
    availableelevators = [];
    
    foreach ( elevator in level.elevators[ "elevator_group_free" ] )
    {
        availableelevator = undefined;
        pickedinfo = level.var_dd26b041c74afbd0[ owner ][ elevator.id ];
        
        if ( !isdefined( pickedinfo ) )
        {
            for ( i = 0; i < elevator.floors.size ; i++ )
            {
                worldfloor = elevator.floors[ i ].worldfloor;
                
                if ( array_contains( var_133738871e398cf3, worldfloor ) )
                {
                    if ( !isdefined( availableelevator ) )
                    {
                        availableelevator = spawnstruct();
                        availableelevator.var_96d5ebb0b818388c = [];
                        availableelevator.elevator = elevator;
                        availableelevators[ availableelevators.size ] = availableelevator;
                    }
                    
                    availableelevator.var_96d5ebb0b818388c[ availableelevator.var_96d5ebb0b818388c.size ] = i;
                }
            }
            
            continue;
        }
        
        if ( pickedinfo.availablefloors.size > 0 )
        {
            for ( i = 0; i < pickedinfo.availablefloors.size ; i++ )
            {
                worldfloor = elevator.floors[ pickedinfo.availablefloors[ i ] ].worldfloor;
                
                if ( array_contains( var_133738871e398cf3, worldfloor ) )
                {
                    if ( !isdefined( availableelevator ) )
                    {
                        availableelevator = spawnstruct();
                        availableelevator.var_96d5ebb0b818388c = [];
                        availableelevator.elevator = elevator;
                        availableelevators[ availableelevators.size ] = availableelevator;
                    }
                    
                    availableelevator.var_96d5ebb0b818388c[ availableelevator.var_96d5ebb0b818388c.size ] = pickedinfo.availablefloors[ i ];
                }
            }
        }
    }
    
    if ( availableelevators.size == 0 )
    {
        return undefined;
    }
    
    var_c814db13c0abc6ab = availableelevators[ randomint( availableelevators.size ) ];
    elevator = var_c814db13c0abc6ab.elevator;
    var_96d5ebb0b818388c = var_c814db13c0abc6ab.var_96d5ebb0b818388c;
    pickedinfo = level.var_dd26b041c74afbd0[ owner ][ elevator.id ];
    
    if ( !isdefined( pickedinfo ) )
    {
        pickedinfo = spawnstruct();
        pickedinfo.availablefloors = [];
        
        for ( i = 0; i < elevator.floors.size ; i++ )
        {
            pickedinfo.availablefloors[ i ] = i;
        }
    }
    
    elevator.targetfloor = array_random( var_96d5ebb0b818388c );
    pickedinfo.availablefloors = array_remove( pickedinfo.availablefloors, elevator.targetfloor );
    level.var_dd26b041c74afbd0[ owner ][ elevator.id ] = pickedinfo;
    return elevator;
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 2
// Checksum 0x0, Offset: 0x1e05
// Size: 0xb8
function startelevator( group, state )
{
    assert( group != "<dev string:x224>" && group != self.group, "<dev string:x23b>" );
    level.elevators[ self.group ] = array_remove( level.elevators[ self.group ], self );
    self.group = group;
    self.state = state;
    
    if ( !isdefined( level.elevators[ group ] ) )
    {
        level.elevators[ group ] = [];
    }
    
    level.elevators[ group ][ level.elevators[ group ].size ] = self;
    waitframe();
    thread function_580e82173ae3940c();
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 0
// Checksum 0x0, Offset: 0x1ec5
// Size: 0x76
function releaseelevator()
{
    level.elevators[ self.group ] = array_remove( level.elevators[ self.group ], self );
    self.group = "elevator_group_free";
    self.state = "";
    level.elevators[ "elevator_group_free" ][ level.elevators[ "elevator_group_free" ].size ] = self;
    self notify( "elevator_release" );
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 0
// Checksum 0x0, Offset: 0x1f43
// Size: 0x195
function function_580e82173ae3940c()
{
    level endon( "game_ended" );
    self endon( "elevator_release" );
    
    while ( true )
    {
        keepprint = 1;
        
        if ( !isdefined( self.group ) )
        {
            keepprint = 0;
            logstring( self.id + " Group is undefined for this elevator" );
        }
        
        if ( keepprint && !isdefined( level.elevatorsfuncs[ self.group ] ) )
        {
            keepprint = 0;
            logstring( self.id + " Group " + self.group + " has not registered FSM yet" );
        }
        
        if ( keepprint && !isdefined( self.state ) )
        {
            keepprint = 0;
            logstring( self.id + " State is undefined for this elevator in Group: " + self.group );
        }
        
        if ( keepprint && !isdefined( level.elevatorsfuncs[ self.group ][ self.state ] ) )
        {
            keepprint = 0;
            logstring( self.id + " State " + self.state + " has not been registered FSM to Group: " + self.group );
        }
        
        if ( keepprint )
        {
            logstring( "===============  Elevator FSM Log  ===============" );
            logstring( "Elevator Id: " + self.id );
            logstring( "Group: " + self.group );
            logstring( "State: " + self.state );
            logstring( "===============  Elevator FSM Log End  ===============" );
        }
        
        self [[ level.elevatorsfuncs[ self.group ][ self.state ] ]]();
    }
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 0
// Checksum 0x0, Offset: 0x20e0
// Size: 0xc0
function elevatormove()
{
    duration = self.targetfloor - self.currentfloor;
    duration = ter_op( duration >= 0, duration, self.currentfloor - self.targetfloor );
    
    if ( duration != 0 )
    {
        function_26adb9abdd954d53( "reinforcement_closed" );
        self.car moveto( ( self.car.origin[ 0 ], self.car.origin[ 1 ], self.floors[ self.targetfloor ].targetheight ), duration );
        wait duration;
        waitframe();
    }
    
    self.currentfloor = self.targetfloor;
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 0
// Checksum 0x0, Offset: 0x21a8
// Size: 0x14b
function elevatordooropen()
{
    foreach ( door in self.doors )
    {
        door setscriptablepartstate( "door", "open", 0 );
    }
    
    wait 2;
    
    foreach ( door in self.doors )
    {
        door.state = door getscriptablepartstate( "door" );
    }
    
    println( "<dev string:x25e>" + self.elevator.id + "<dev string:x279>" + self.elevator.currentfloor + "<dev string:x28c>" + self.elevator.targetfloor + "<dev string:x29e>" + self.doors[ 0 ].state + "<dev string:x2aa>" + self.doors[ 1 ].state );
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 0
// Checksum 0x0, Offset: 0x22fb
// Size: 0x14b
function elevatordoorclose()
{
    foreach ( door in self.doors )
    {
        door setscriptablepartstate( "door", "closed", 0 );
    }
    
    wait 2;
    
    foreach ( door in self.doors )
    {
        door.state = door getscriptablepartstate( "door" );
    }
    
    println( "<dev string:x2af>" + self.elevator.id + "<dev string:x279>" + self.elevator.currentfloor + "<dev string:x28c>" + self.elevator.targetfloor + "<dev string:x29e>" + self.doors[ 0 ].state + "<dev string:x2aa>" + self.doors[ 1 ].state );
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 0
// Checksum 0x0, Offset: 0x244e
// Size: 0x14b
function function_88c392696fd02dc4()
{
    foreach ( door in self.doors )
    {
        door setscriptablepartstate( "door", "reinforcement_open", 0 );
    }
    
    wait 2;
    
    foreach ( door in self.doors )
    {
        door.state = door getscriptablepartstate( "door" );
    }
    
    println( "<dev string:x2cb>" + self.elevator.id + "<dev string:x279>" + self.elevator.currentfloor + "<dev string:x28c>" + self.elevator.targetfloor + "<dev string:x29e>" + self.doors[ 0 ].state + "<dev string:x2aa>" + self.doors[ 1 ].state );
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 0
// Checksum 0x0, Offset: 0x25a1
// Size: 0x14b
function function_d32c693d3a04f8f8()
{
    foreach ( door in self.doors )
    {
        door setscriptablepartstate( "door", "reinforcement_closed", 0 );
    }
    
    wait 2;
    
    foreach ( door in self.doors )
    {
        door.state = door getscriptablepartstate( "door" );
    }
    
    println( "<dev string:x2f0>" + self.elevator.id + "<dev string:x279>" + self.elevator.currentfloor + "<dev string:x28c>" + self.elevator.targetfloor + "<dev string:x29e>" + self.doors[ 0 ].state + "<dev string:x2aa>" + self.doors[ 1 ].state );
}

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 1
// Checksum 0x0, Offset: 0x26f4
// Size: 0xb2
function function_26adb9abdd954d53( closestate )
{
    foreach ( floor in self.floors )
    {
        foreach ( door in floor.doors )
        {
            door setscriptablepartstate( "door", closestate, 0 );
        }
    }
}

#using_animtree( "script_model" );

// Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
// Params 0
// Checksum 0x0, Offset: 0x27ae
// Size: 0xa2
function scriptmodelanims()
{
    level.scr_animtree[ "elevator" ] = #animtree;
    level.scr_anim[ "elevator" ][ "close" ] = %iw9_elevator_int_door_close;
    level.scr_eventanim[ "elevator" ][ "close" ] = %"iw9_elevator_int_door_close";
    level.scr_animtree[ "elevator" ] = #animtree;
    level.scr_anim[ "elevator" ][ "open" ] = %iw9_elevator_int_door_open;
    level.scr_eventanim[ "elevator" ][ "open" ] = %"iw9_elevator_int_door_open";
}

/#

    // Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
    // Params 0
    // Checksum 0x0, Offset: 0x2858
    // Size: 0x31, Type: dev
    function function_cb2806ac4b115c70()
    {
        level waittill( "<dev string:x316>" );
        level thread function_af5ba99924c0d3d6( @"hash_b4957f27fef0ad51" );
        level thread function_84d0ae2111fcc4be( @"hash_7f3c55bc1b0ba1dd" );
    }

    // Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
    // Params 1
    // Checksum 0x0, Offset: 0x2891
    // Size: 0x243, Type: dev
    function function_af5ba99924c0d3d6( dvarname )
    {
        level endon( "<dev string:x328>" );
        setdevdvarifuninitialized( dvarname, 0 );
        var_2193ee1cb4487092 = [ "<dev string:x224>", "<dev string:x336>", "<dev string:x356>", "<dev string:x37a>" ];
        var_26af4f7e687bacaf = [];
        var_26af4f7e687bacaf[ "<dev string:x224>" ] = ( 0, 1, 0 );
        var_26af4f7e687bacaf[ "<dev string:x336>" ] = ( 1, 0, 0 );
        var_26af4f7e687bacaf[ "<dev string:x356>" ] = ( 1, 1, 0 );
        var_26af4f7e687bacaf[ "<dev string:x37a>" ] = ( 0, 0, 1 );
        var_58e7b7390381f53b = 64;
        
        while ( true )
        {
            shoulddraw = getdvarint( dvarname );
            
            if ( shoulddraw == 1 )
            {
                foreach ( group in var_2193ee1cb4487092 )
                {
                    if ( isdefined( level.elevators[ group ] ) )
                    {
                        foreach ( elevator in level.elevators[ group ] )
                        {
                            foreach ( floor in elevator.floors )
                            {
                                sphere( floor.origin, var_58e7b7390381f53b, var_26af4f7e687bacaf[ group ] );
                            }
                            
                            sphere( elevator.car.origin, 16, ( 1, 0, 1 ) );
                            debugstar( elevator.car.origin, ( 1, 0, 1 ), 1, elevator.id, 0.8 );
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_a570a67947f18a4d / namespace_2067e9d40332bfec
    // Params 1
    // Checksum 0x0, Offset: 0x2adc
    // Size: 0xc1, Type: dev
    function function_84d0ae2111fcc4be( dvarname )
    {
        level endon( "<dev string:x328>" );
        setdevdvarifuninitialized( dvarname, 0 );
        var_58e7b7390381f53b = 32;
        var_a573ceab7ce7a507 = ( 1, 1, 1 );
        
        while ( true )
        {
            shoulddraw = getdvarint( dvarname );
            
            if ( shoulddraw == 1 )
            {
                foreach ( list in level.var_6fdfdc44a9268868 )
                {
                    sphere( list.origin, var_58e7b7390381f53b, var_a573ceab7ce7a507 );
                }
            }
            
            waitframe();
        }
    }

#/
