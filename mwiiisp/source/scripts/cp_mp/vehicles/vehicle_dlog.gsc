#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;

#namespace vehicle_dlog;

// Namespace vehicle_dlog / scripts\cp_mp\vehicles\vehicle_dlog
// Params 3
// Checksum 0x0, Offset: 0x25b
// Size: 0xf6
function vehicle_dlog_spawnevent( vehicle, spawntype, vehicletype )
{
    instancedata = vehicle_dlog_getinstancedata( vehicle, 1 );
    
    if ( !isdefined( instancedata ) )
    {
        return;
    }
    
    if ( !isdefined( vehicletype ) )
    {
        vehicletype = vehicle.vehiclename;
    }
    
    if ( !isdefined( spawntype ) )
    {
        return;
    }
    
    if ( !isdefined( vehicletype ) )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_vehicle_spawn", [ "vehicle_spawn_id", instancedata.id, "pos_x", vehicle.origin[ 0 ], "pos_y", vehicle.origin[ 1 ], "pos_z", vehicle.origin[ 2 ], "matchtime_ms", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "spawn_type", spawntype, "vehicle_type", vehicletype ] );
}

// Namespace vehicle_dlog / scripts\cp_mp\vehicles\vehicle_dlog
// Params 4
// Checksum 0x0, Offset: 0x359
// Size: 0xf5
function vehicle_dlog_exitevent( vehicle, player, seatid, exittype )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    instancedata = vehicle_dlog_getinstancedata( vehicle );
    
    if ( !isdefined( instancedata ) )
    {
        return;
    }
    
    if ( !isdefined( seatid ) )
    {
        return;
    }
    
    if ( !isdefined( exittype ) )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_player_vehicle_exit", [ "vehicle_spawn_id", instancedata.id, "exit_pos_x", vehicle.origin[ 0 ], "exit_pos_y", vehicle.origin[ 1 ], "exit_pos_z", vehicle.origin[ 2 ], "exit_seat_id", seatid, "exit_matchtime_ms", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "exit_type", exittype ] );
}

// Namespace vehicle_dlog / scripts\cp_mp\vehicles\vehicle_dlog
// Params 4
// Checksum 0x0, Offset: 0x456
// Size: 0xf5
function vehicle_dlog_enterevent( vehicle, player, seatid, entertype )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    instancedata = vehicle_dlog_getinstancedata( vehicle );
    
    if ( !isdefined( instancedata ) )
    {
        return;
    }
    
    if ( !isdefined( seatid ) )
    {
        return;
    }
    
    if ( !isdefined( entertype ) )
    {
        return;
    }
    
    player dlog_recordplayerevent( "dlog_event_player_vehicle_enter", [ "vehicle_spawn_id", instancedata.id, "enter_pos_x", vehicle.origin[ 0 ], "enter_pos_y", vehicle.origin[ 1 ], "enter_pos_z", vehicle.origin[ 2 ], "enter_seat_id", seatid, "enter_matchtime_ms", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "enter_type", entertype ] );
}

// Namespace vehicle_dlog / scripts\cp_mp\vehicles\vehicle_dlog
// Params 0
// Checksum 0x0, Offset: 0x553
// Size: 0x6f
function vehicle_dlog_init()
{
    assertex( isdefined( level.vehicle ), "vehicle_dlog_init() called before vehicle_init()." );
    assertex( !isdefined( level.vehicle.dlogdata ), "vehicle_dlog_init() should only be called once." );
    leveldata = spawnstruct();
    leveldata.uniqueid = 0;
    level.vehicle.dlogdata = leveldata;
}

// Namespace vehicle_dlog / scripts\cp_mp\vehicles\vehicle_dlog
// Params 0
// Checksum 0x0, Offset: 0x5ca
// Size: 0x37
function vehicle_dlog_getleveldata()
{
    assertex( isdefined( level.vehicle.dlogdata ), "vehicle_dlog_getLevelData() called before vehicle_dlog_init()." );
    return level.vehicle.dlogdata;
}

// Namespace vehicle_dlog / scripts\cp_mp\vehicles\vehicle_dlog
// Params 2
// Checksum 0x0, Offset: 0x60a
// Size: 0x7e
function vehicle_dlog_getinstancedata( vehicle, create )
{
    leveldata = vehicle_dlog_getleveldata();
    instancedata = vehicle.dlogdata;
    
    if ( !isdefined( instancedata ) && istrue( create ) )
    {
        instancedata = spawnstruct();
        vehicle.dlogdata = instancedata;
        instancedata.id = leveldata.uniqueid;
        leveldata.uniqueid++;
    }
    
    return instancedata;
}

// Namespace vehicle_dlog / scripts\cp_mp\vehicles\vehicle_dlog
// Params 1
// Checksum 0x0, Offset: 0x691
// Size: 0x16
function vehicle_dlog_getuniqueid( vehicle )
{
    return vehicle.dlogid;
}

