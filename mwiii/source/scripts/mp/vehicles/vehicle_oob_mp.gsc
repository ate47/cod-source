#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#using scripts\mp\outofbounds;

#namespace vehicle_oob_mp;

// Namespace vehicle_oob_mp / scripts\mp\vehicles\vehicle_oob_mp
// Params 2
// Checksum 0x0, Offset: 0xd9
// Size: 0x34
function vehicle_oob_mp_registeroutoftimecallback( vehiclename, callback )
{
    leveldata = vehicle_oob_mp_getleveldata();
    leveldata.outoftimecallbacks[ vehiclename ] = callback;
}

// Namespace vehicle_oob_mp / scripts\mp\vehicles\vehicle_oob_mp
// Params 0
// Checksum 0x0, Offset: 0x115
// Size: 0x92
function vehicle_oob_mp_init()
{
    assertex( isdefined( level.vehicle ), "<dev string:x1c>" );
    assertex( !isdefined( level.vehicle.oob ), "<dev string:x53>" );
    leveldata = spawnstruct();
    leveldata.outoftimecallbacks = [];
    level.vehicle.oob = leveldata;
    registerooboutoftimecallback( "vehicle", &vehicle_oob_mp_outoftimecallback );
    registeroobclearcallback( "vehicle", &vehicle_oob_mp_clearcallback );
}

// Namespace vehicle_oob_mp / scripts\mp\vehicles\vehicle_oob_mp
// Params 0
// Checksum 0x0, Offset: 0x1af
// Size: 0x4f
function vehicle_oob_mp_getleveldata()
{
    assertex( isdefined( level.vehicle ), "<dev string:x88>" );
    assertex( isdefined( level.vehicle.oob ), "<dev string:xc7>" );
    return level.vehicle.oob;
}

// Namespace vehicle_oob_mp / scripts\mp\vehicles\vehicle_oob_mp
// Params 2
// Checksum 0x0, Offset: 0x207
// Size: 0x64
function vehicle_oob_mp_outoftimecallback( timeoutendnotify, clearnotify )
{
    leveldata = vehicle_oob_mp_getleveldata();
    callback = leveldata.outoftimecallbacks[ self.vehiclename ];
    assertex( isdefined( callback ), "<dev string:x10d>" );
    self.dontspawnhusk = 1;
    self [[ callback ]]();
}

// Namespace vehicle_oob_mp / scripts\mp\vehicles\vehicle_oob_mp
// Params 0
// Checksum 0x0, Offset: 0x273
// Size: 0x64
function vehicle_oob_mp_clearcallback()
{
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( self );
    
    foreach ( occupant in occupants )
    {
        occupant setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    }
}

