#using scripts\common\utility;
#using scripts\cp\cp_outofbounds;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;

#namespace vehicle_oob_cp;

// Namespace vehicle_oob_cp / scripts\cp\vehicles\vehicle_oob_cp
// Params 2
// Checksum 0x0, Offset: 0x1f2
// Size: 0x33
function vehicle_oob_cp_registeroutoftimecallback( vehiclename, callback )
{
    leveldata = vehicle_oob_cp_getleveldata();
    leveldata.outoftimecallbacks[ vehiclename ] = callback;
}

// Namespace vehicle_oob_cp / scripts\cp\vehicles\vehicle_oob_cp
// Params 0
// Checksum 0x0, Offset: 0x22d
// Size: 0xb3
function vehicle_oob_cp_init()
{
    assertex( isdefined( level.vehicle ), "vehicle_oob_cp_init() called before vehicle_init()." );
    assertex( !isdefined( level.vehicle.oob ), "vehicle_oob_cp_init() should only be called once." );
    leveldata = spawnstruct();
    leveldata.outoftimecallbacks = [];
    level.vehicle.oob = leveldata;
    registeroobentercallback( "vehicle", &vehicle_oob_cp_entercallback );
    registeroobexitcallback( "vehicle", &vehicle_oob_cp_exitcallback );
    registerooboutoftimecallback( "vehicle", &vehicle_oob_cp_outoftimecallback );
    registeroobclearcallback( "vehicle", &vehicle_oob_cp_clearcallback );
}

// Namespace vehicle_oob_cp / scripts\cp\vehicles\vehicle_oob_cp
// Params 0
// Checksum 0x0, Offset: 0x2e8
// Size: 0x4f
function vehicle_oob_cp_getleveldata()
{
    assertex( isdefined( level.vehicle ), "vehicle_oob_cp_getLevelData() called before vehicle_init()." );
    assertex( isdefined( level.vehicle.oob ), "vehicle_oob_cp_getLevelData() called before vehicle_oob_cp_init()." );
    return level.vehicle.oob;
}

// Namespace vehicle_oob_cp / scripts\cp\vehicles\vehicle_oob_cp
// Params 2
// Checksum 0x0, Offset: 0x340
// Size: 0x6e
function vehicle_oob_cp_entercallback( exitnotify, clearnotify )
{
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( self );
    
    foreach ( occupant in occupants )
    {
        vehicle_oob_cp_entercallbackforplayer( occupant );
    }
}

// Namespace vehicle_oob_cp / scripts\cp\vehicles\vehicle_oob_cp
// Params 3
// Checksum 0x0, Offset: 0x3b6
// Size: 0x30
function vehicle_oob_cp_entercallbackforplayer( player, exitnotify, clearnotify )
{
    player setclientomnvar( "ui_out_of_bounds_countdown", self.oobendtime );
}

// Namespace vehicle_oob_cp / scripts\cp\vehicles\vehicle_oob_cp
// Params 3
// Checksum 0x0, Offset: 0x3ee
// Size: 0x76
function vehicle_oob_cp_exitcallback( fromdeath, fromclear, clearnotify )
{
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( self );
    
    foreach ( occupant in occupants )
    {
        vehicle_oob_cp_exitcallbackforplayer( occupant );
    }
}

// Namespace vehicle_oob_cp / scripts\cp\vehicles\vehicle_oob_cp
// Params 4
// Checksum 0x0, Offset: 0x46c
// Size: 0x30
function vehicle_oob_cp_exitcallbackforplayer( player, fromdeath, fromclear, clearnotify )
{
    player setclientomnvar( "ui_out_of_bounds_countdown", 0 );
}

// Namespace vehicle_oob_cp / scripts\cp\vehicles\vehicle_oob_cp
// Params 2
// Checksum 0x0, Offset: 0x4a4
// Size: 0xc3
function vehicle_oob_cp_outoftimecallback( timeoutendnotify, clearnotify )
{
    leveldata = vehicle_oob_cp_getleveldata();
    callback = leveldata.outoftimecallbacks[ self.vehiclename ];
    assertex( isdefined( callback ), "vehicle_oob_cp_outOfTimeCallback() called on a vehicle without a valid outOfTimeCallback." );
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( self );
    
    foreach ( occupant in occupants )
    {
        occupant.shouldskiplaststand = 1;
        occupant scripts\cp_mp\armor::setarmorhealth( 0 );
    }
    
    self [[ callback ]]();
}

// Namespace vehicle_oob_cp / scripts\cp\vehicles\vehicle_oob_cp
// Params 0
// Checksum 0x0, Offset: 0x56f
// Size: 0x62
function vehicle_oob_cp_clearcallback()
{
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( self );
    
    foreach ( occupant in occupants )
    {
        occupant setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    }
}

