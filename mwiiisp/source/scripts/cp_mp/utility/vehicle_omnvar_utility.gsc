#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;

#namespace vehicle_omnvar_utility;

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 0
// Checksum 0x0, Offset: 0x6df
// Size: 0x6f
function vehomn_init()
{
    assertex( isdefined( level.vehicle ), "vehOmn_init() called before vehicle_init()." );
    assertex( !isdefined( level.vehicle.omnvars ), "vehOmn_init() should only be called once." );
    leveldata = spawnstruct();
    level.vehicle.omnvars = leveldata;
    leveldata.vehicledata = [];
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0x756
// Size: 0xd9
function vehomn_setvehicle( vehicleref, clients )
{
    leveldataforvehicle = vehomn_getleveldataforvehicle( vehicleref );
    id = leveldataforvehicle.id;
    assertex( isdefined( id ), "levelDataForVehicle for " + vehicleref + " failed to define an ID." );
    
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvar( "ui_veh_vehicle", id );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( "ui_veh_vehicle", id );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0x837
// Size: 0xdd
function vehomn_setcurrentseat( vehicle, seatref, client )
{
    if ( !isdefined( client ) )
    {
        return;
    }
    
    vehicleref = vehicle function_d93ec4635290febd();
    id = -1;
    
    if ( isdefined( vehicleref ) )
    {
        leveldataforvehicle = vehomn_getleveldataforvehicle( vehicleref );
        
        if ( isdefined( seatref ) )
        {
            id = leveldataforvehicle.seatids[ seatref ];
            var_ce438350733fad27 = vehicleref == "veh_jup_orav";
            
            if ( ( var_ce438350733fad27 || istrue( leveldataforvehicle.hasdoors ) && vehicle scripts\cp_mp\vehicles\vehicle_damage::function_b9d5a379eb1aefc7( seatref ) ) && seatref != "gunner" )
            {
                id |= 16;
            }
            
            assertex( isdefined( id ), "levelDataForVehicle for " + vehicleref + " failed to define an ID for seat " + seatref + "." );
        }
    }
    
    client setclientomnvar( "ui_veh_current_seat", id );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0x91c
// Size: 0x81
function vehomn_setnextseat( vehicleref, seatref, client )
{
    if ( !isdefined( client ) )
    {
        return;
    }
    
    id = -1;
    
    if ( isdefined( seatref ) )
    {
        leveldataforvehicle = vehomn_getleveldataforvehicle( vehicleref );
        id = leveldataforvehicle.seatids[ seatref ];
        assertex( isdefined( id ), "levelDataForVehicle for " + vehicleref + " failed to define an ID for seat " + seatref + "." );
    }
    
    client setclientomnvar( "ui_veh_next_seat", id );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 4
// Checksum 0x0, Offset: 0x9a5
// Size: 0x1df
function vehomn_setseatentity( vehicleref, seatref, seatentity, clients )
{
    id = -1;
    
    if ( isdefined( vehicleref ) )
    {
        leveldataforvehicle = vehomn_getleveldataforvehicle( vehicleref );
        
        if ( isdefined( seatref ) )
        {
            id = leveldataforvehicle.seatids[ seatref ];
            assertex( isdefined( id ), "levelDataForVehicle for " + vehicleref + " failed to define an ID for seat " + seatref + "." );
        }
    }
    
    omnvar = undefined;
    
    switch ( id )
    {
        case 0:
            omnvar = "ui_veh_occupant_0";
            break;
        case 1:
            omnvar = "ui_veh_occupant_1";
            break;
        case 2:
            omnvar = "ui_veh_occupant_2";
            break;
        case 3:
            omnvar = "ui_veh_occupant_3";
            break;
        case 4:
            omnvar = "ui_veh_occupant_4";
            break;
        case 5:
            omnvar = "ui_veh_occupant_5";
            break;
        case 6:
            omnvar = "ui_veh_occupant_6";
            break;
    }
    
    assertex( isdefined( omnvar ), "seatRef does not map to an omnvar." );
    seatentityid = -1;
    
    if ( isdefined( seatentity ) )
    {
        seatentityid = seatentity getentitynumber();
    }
    
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvar( omnvar, seatentityid );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( omnvar, seatentityid );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0xb8c
// Size: 0x26
function vehomn_clearseatentity( vehicleref, seatref, clients )
{
    vehomn_setseatentity( vehicleref, seatref, undefined, clients );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0xbba
// Size: 0xa9
function vehomn_sethealthpercent( healthpercentvalue, clients )
{
    if ( !isdefined( healthpercentvalue ) )
    {
        healthpercentvalue = 0;
    }
    
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvar( "ui_veh_health_percent", int( healthpercentvalue ) );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( "ui_veh_health_percent", int( healthpercentvalue ) );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0xc6b
// Size: 0x14
function vehomn_clearhealthpercent( clients )
{
    vehomn_sethealthpercent( undefined, clients );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0xc87
// Size: 0x91
function vehomn_showhealth( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvar( "ui_veh_show_health", 1 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( "ui_veh_show_health", 1 );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0xd20
// Size: 0x8f
function vehomn_hidehealth( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvar( "ui_veh_show_health", 0 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( "ui_veh_show_health", 0 );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0xdb7
// Size: 0x22
function vehomn_clearshowhealth( clients )
{
    if ( false )
    {
        vehomn_showhealth( clients );
        return;
    }
    
    vehomn_hidehealth( clients );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0xde1
// Size: 0xa9
function vehomn_settimepercent( timepercentvalue, clients )
{
    if ( !isdefined( timepercentvalue ) )
    {
        timepercentvalue = 0;
    }
    
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvar( "ui_veh_time_percent", int( timepercentvalue ) );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( "ui_veh_time_percent", int( timepercentvalue ) );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0xe92
// Size: 0x14
function vehomn_cleartimepercent( clients )
{
    vehomn_settimepercent( undefined, clients );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0xeae
// Size: 0x91
function vehomn_showtime( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvar( "ui_veh_show_time", 1 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( "ui_veh_show_time", 1 );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0xf47
// Size: 0x8f
function vehomn_hidetime( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvar( "ui_veh_show_time", 0 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( "ui_veh_show_time", 0 );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0xfde
// Size: 0x22
function vehomn_clearshowtime( clients )
{
    if ( false )
    {
        vehomn_showtime( clients );
        return;
    }
    
    vehomn_hidetime( clients );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0x1008
// Size: 0x41
function function_9da76b0be4b2a2d4( currentfuel, maxfuel )
{
    fuelpercentage = function_f1c6c7fa7cc97826( currentfuel, maxfuel );
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( self );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setfuelpercent( fuelpercentage, occupants );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0x1051
// Size: 0x37
function function_272f4112182763bd( player, currentfuel, maxfuel )
{
    fuelpercentage = function_f1c6c7fa7cc97826( currentfuel, maxfuel );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setfuelpercent( fuelpercentage, player );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1090
// Size: 0x69
function private function_f1c6c7fa7cc97826( currentfuel, maxfuel )
{
    if ( !isdefined( currentfuel ) )
    {
        currentfuel = self.fuel;
    }
    
    if ( !isdefined( maxfuel ) )
    {
        maxfuel = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle( self.vehiclename ).maxfuel;
    }
    
    if ( maxfuel == -1 )
    {
        return 100;
    }
    
    assertex( isdefined( currentfuel ) && isdefined( maxfuel ), "vehOmn_getFuelPercent: Called while self.fuel or (vehicle interact level data).maxFuel is undefined" );
    return currentfuel / maxfuel * 100;
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0x1102
// Size: 0xaa
function vehomn_setfuelpercent( var_15174a10eca23d37, clients )
{
    if ( !isdefined( var_15174a10eca23d37 ) )
    {
        var_15174a10eca23d37 = 100;
    }
    
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvar( "ui_veh_fuel_percent", int( var_15174a10eca23d37 ) );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( "ui_veh_fuel_percent", int( var_15174a10eca23d37 ) );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0x11b4
// Size: 0xb
function vehomn_clearfuelpercent( clients )
{
    
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0x11c7
// Size: 0x91
function vehomn_showfuel( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvar( "ui_veh_show_fuel", 1 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( "ui_veh_show_fuel", 1 );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0x1260
// Size: 0xb
function vehomn_hidefuel( clients )
{
    
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0x1273
// Size: 0xb
function vehomn_clearshowfuel( clients )
{
    
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 4
// Checksum 0x0, Offset: 0x1286
// Size: 0x182
function vehomn_setammo( vehicleref, ammoref, ammovalue, clients )
{
    leveldataforvehicle = vehomn_getleveldataforvehicle( vehicleref );
    id = leveldataforvehicle.ammoids[ ammoref ];
    assertex( isdefined( id ), "levelDataForVehicle for " + vehicleref + " failed to define an ID for ammoRef " + ammoref + "." );
    omnvar = undefined;
    
    switch ( id )
    {
        case 0:
            omnvar = "ui_veh_ammo_0";
            break;
        case 1:
            omnvar = "ui_veh_ammo_1";
            break;
        case 2:
            omnvar = "ui_veh_ammo_2";
            break;
    }
    
    assertex( isdefined( omnvar ), "ammoRef does not map to an omnvar." );
    
    if ( !isdefined( ammovalue ) )
    {
        ammovalue = -1;
    }
    else if ( isstring( ammovalue ) && ammovalue == "infinite" )
    {
        ammovalue = -2;
    }
    
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvar( omnvar, ammovalue );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( omnvar, ammovalue );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0x1410
// Size: 0x26
function vehomn_clearammo( vehicleref, ammoref, clients )
{
    vehomn_setammo( vehicleref, ammoref, undefined, clients );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 4
// Checksum 0x0, Offset: 0x143e
// Size: 0x53
function vehomn_showammo( vehicleref, ammoref, ammovalue, clients )
{
    assertex( isstring( ammovalue ) || ammovalue != -1, "vehOmn_showAmmo cannot be called with a value of " + -1 + "." );
    vehomn_setammo( vehicleref, ammoref, ammovalue, clients );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0x1499
// Size: 0x27
function vehomn_hideammo( vehicleref, ammoref, clients )
{
    vehomn_setammo( vehicleref, ammoref, -1, clients );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0x14c8
// Size: 0x13f
function vehomn_showwarning( warningref, clients, vehicleref )
{
    leveldataforvehicle = vehomn_getleveldataforvehicle( vehicleref, 1 );
    id = leveldataforvehicle.warningbits[ warningref ];
    assertex( id < 11, "vehOmn_showWarning called with warningRef index " + id + ". Should be below " + 11 + "." );
    
    if ( isdefined( clients ) )
    {
        warningstartcallback = leveldataforvehicle.warningstartcallbacks[ warningref ];
        
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvarbit( "ui_veh_warning", id, 1 );
                    
                    if ( isdefined( warningstartcallback ) )
                    {
                        thread [[ warningstartcallback ]]( client, "ui_veh_warning" + "_omnvar_modified" );
                    }
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvarbit( "ui_veh_warning", id, 1 );
            
            if ( isdefined( warningstartcallback ) )
            {
                thread [[ warningstartcallback ]]( clients, "ui_veh_warning" + "_omnvar_modified" );
            }
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0x160f
// Size: 0x13d
function vehomn_hidewarning( warningref, clients, vehicleref )
{
    leveldataforvehicle = vehomn_getleveldataforvehicle( vehicleref, 1 );
    id = leveldataforvehicle.warningbits[ warningref ];
    assertex( id < 11, "vehOmn_showWarning called with warningRef index " + id + ". Should be below " + 11 + "." );
    
    if ( isdefined( clients ) )
    {
        warningendcallback = leveldataforvehicle.warningendcallbacks[ warningref ];
        
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvarbit( "ui_veh_warning", id, 0 );
                    
                    if ( isdefined( warningendcallback ) )
                    {
                        thread [[ warningendcallback ]]( client, "ui_veh_warning" + "_omnvar_modified" );
                    }
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvarbit( "ui_veh_warning", id, 0 );
            
            if ( isdefined( warningendcallback ) )
            {
                thread [[ warningendcallback ]]( clients, "ui_veh_warning" + "_omnvar_modified" );
            }
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0x1754
// Size: 0x181
function vehomn_clearwarnings( clients, vehicleref )
{
    if ( isdefined( clients ) )
    {
        leveldataforvehicle = undefined;
        
        if ( isdefined( vehicleref ) )
        {
            leveldataforvehicle = vehomn_getleveldataforvehicle( vehicleref, undefined, 1 );
        }
        
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvar( "ui_veh_warning", 0 );
                    function_6f848816a946e419( client );
                    
                    if ( isdefined( leveldataforvehicle ) )
                    {
                        foreach ( warningclearcallback in leveldataforvehicle.warningclearcallbacks )
                        {
                            if ( isdefined( warningclearcallback ) )
                            {
                                thread [[ warningclearcallback ]]( client );
                            }
                        }
                    }
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( "ui_veh_warning", 0 );
            function_6f848816a946e419( clients );
            
            if ( isdefined( leveldataforvehicle ) )
            {
                foreach ( warningclearcallback in leveldataforvehicle.warningclearcallbacks )
                {
                    if ( isdefined( warningclearcallback ) )
                    {
                        thread [[ warningclearcallback ]]( clients );
                    }
                }
            }
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0x18dd
// Size: 0xa1
function function_6f848816a946e419( client )
{
    if ( soundexists( "uin_veh_warning_low_fuel" ) )
    {
        client stoplocalsound( "uin_veh_warning_low_fuel" );
    }
    
    if ( soundexists( "uin_veh_warning_low_fuel_heli" ) )
    {
        client stoplocalsound( "uin_veh_warning_low_fuel_heli" );
    }
    
    if ( soundexists( "uin_veh_warning_out_of_fuel" ) )
    {
        client stoplocalsound( "uin_veh_warning_out_of_fuel" );
    }
    
    if ( soundexists( "uin_veh_warning_out_of_fuel_heli" ) )
    {
        client stoplocalsound( "uin_veh_warning_out_of_fuel_heli" );
    }
    
    if ( soundexists( "veh_warning_missile_locking" ) )
    {
        client stoplocalsound( "veh_warning_missile_locking" );
    }
    
    if ( soundexists( "veh_warning_missile_incoming" ) )
    {
        client stoplocalsound( "veh_warning_missile_incoming" );
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 4
// Checksum 0x0, Offset: 0x1986
// Size: 0x182
function vehomn_setrotation( vehicleref, rotationref, rotationvalue, clients )
{
    leveldataforvehicle = vehomn_getleveldataforvehicle( vehicleref );
    id = leveldataforvehicle.rotationids[ rotationref ];
    assertex( isdefined( id ), "levelDataForVehicle for " + vehicleref + " failed to define an ID for rotationRef " + rotationref + "." );
    omnvar = undefined;
    
    switch ( id )
    {
        case 0:
            omnvar = "ui_veh_degrees_0";
            break;
        case 1:
            omnvar = "ui_veh_degrees_1";
            break;
    }
    
    assertex( isdefined( omnvar ), "rotationRef does not map to an omnvar." );
    
    if ( !isdefined( rotationvalue ) )
    {
        rotationvalue = 0;
    }
    
    if ( isdefined( clients ) )
    {
        remainder = rotationvalue - floor( rotationvalue );
        
        if ( remainder >= 0.5 )
        {
            rotationvalue = ceil( rotationvalue );
        }
        else
        {
            rotationvalue = floor( rotationvalue );
        }
        
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client setclientomnvar( omnvar, rotationvalue );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( omnvar, rotationvalue );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0x1b10
// Size: 0x26
function vehomn_clearrotation( vehicleref, rotationref, clients )
{
    vehomn_setrotation( vehicleref, rotationref, undefined, clients );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0x1b3e
// Size: 0xc3
function vehomn_showcontrols( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client notify( "vehOmn_modified_controls" );
                    client.vehomncontrols = "show";
                    client setclientomnvar( "ui_veh_controls", 1 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients notify( "vehOmn_modified_controls" );
            clients.vehomncontrols = "show";
            clients setclientomnvar( "ui_veh_controls", 1 );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0x1c09
// Size: 0xc1
function vehomn_hidecontrols( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client notify( "vehOmn_modified_controls" );
                    client.vehomncontrols = "hide";
                    client setclientomnvar( "ui_veh_controls", 0 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients notify( "vehOmn_modified_controls" );
            clients.vehomncontrols = "hide";
            clients setclientomnvar( "ui_veh_controls", 0 );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0x1cd2
// Size: 0x87
function vehomn_fadeoutcontrols( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    thread vehomn_fadeoutcontrolsforclient( client );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            thread vehomn_fadeoutcontrolsforclient( clients );
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0x1d61
// Size: 0x7e
function vehomn_fadeoutcontrolsforclient( client )
{
    client endon( "death_or_disconnect" );
    client endon( "vehOmn_modified_controls" );
    
    if ( !isdefined( client.vehomncontrols ) || client.vehomncontrols != "hide" && client.vehomncontrols != "fadeOut" )
    {
        client.vehomncontrols = "fadeOut";
        client setclientomnvar( "ui_veh_controls", 2 );
        wait 3;
        thread vehomn_hidecontrols( client );
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0x1de7
// Size: 0xa5
function vehomn_clearcontrols( clients )
{
    if ( isdefined( clients ) )
    {
        if ( isarray( clients ) )
        {
            foreach ( client in clients )
            {
                if ( isdefined( client ) && isplayer( client ) )
                {
                    client.vehomncontrols = undefined;
                    client setclientomnvar( "ui_veh_controls", 0 );
                }
            }
            
            return;
        }
        
        if ( isplayer( clients ) )
        {
            clients setclientomnvar( "ui_veh_controls", 0 );
            clients.vehomncontrols = undefined;
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0x1e94
// Size: 0x42, Type: bool
function vehomn_controlsarefadedoutorhidden( client )
{
    return !isdefined( client.vehomncontrols ) || client.vehomncontrols == "fadeOut" || client.vehomncontrols == "hide";
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 0
// Checksum 0x0, Offset: 0x1edf
// Size: 0x4f
function vehomn_getleveldata()
{
    assertex( isdefined( level.vehicle ), "vehOmn_getLevelData() called before vehicle_init()." );
    assertex( isdefined( level.vehicle.omnvars ), "vehOmn_getLevelData() called before vehOmn_init()." );
    return level.vehicle.omnvars;
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0x1f37
// Size: 0x2b8
function vehomn_getleveldataforvehicle( vehicleref, create, var_6ecb77fd1f27c667 )
{
    if ( istrue( create ) && ( !function_89dc39dc11f3988c( vehicleref ) || !isdefined( function_29b4292c92443328( vehicleref ).occupancy ) || !isdefined( function_29b4292c92443328( vehicleref ).occupancy.seatids ) ) )
    {
        data = undefined;
        
        if ( function_89dc39dc11f3988c( vehicleref ) )
        {
            data = function_29b4292c92443328( vehicleref );
        }
        else
        {
            data = spawnstruct();
        }
        
        if ( !isdefined( data.occupancy ) )
        {
            data.occupancy = spawnstruct();
        }
        
        data.occupancy.seatids = [];
        data.occupancy.ammoids = [];
        data.occupancy.rotationids = [];
        data.occupancy.warningbits = [];
        data.occupancy.warningstartcallbacks = [];
        data.occupancy.warningendcallbacks = [];
        data.occupancy.warningclearcallbacks = [];
        data.occupancy.rotationrefsbyseatandweapon = [];
        data.occupancy.warningbits[ "burningDown" ] = 1;
        data.occupancy.warningbits[ "missileLocking" ] = 2;
        data.occupancy.warningbits[ "missileIncoming" ] = 4;
        data.occupancy.warningbits[ "movementDisabled" ] = 3;
        data.occupancy.warningbits[ "outOfFuel" ] = 6;
        data.occupancy.warningbits[ "lowFuel" ] = 5;
        data.occupancy.warningbits[ "BunkerBusterAttached" ] = 7;
        data.occupancy.warningbits[ "shockStickAttached" ] = 8;
        data.occupancy.warningbits[ "DDoSed" ] = 9;
        data.occupancy.warningbits[ "locked" ] = 10;
        level.var_a0b2c978ca57ffc5[ vehicleref ] = data;
    }
    
    if ( function_89dc39dc11f3988c( vehicleref ) )
    {
        return function_29b4292c92443328( vehicleref ).occupancy;
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 3
// Checksum 0x0, Offset: 0x21f7
// Size: 0x9b
function vehomn_clearleveldataforvehicle( vehicleref, create, var_6ecb77fd1f27c667 )
{
    leveldataforvehicle = vehomn_getleveldataforvehicle( vehicleref, create, var_6ecb77fd1f27c667 );
    
    if ( isdefined( leveldataforvehicle ) )
    {
        leveldataforvehicle.seatids = [];
        leveldataforvehicle.ammoids = [];
        leveldataforvehicle.rotationids = [];
        leveldataforvehicle.warningbits = [];
        leveldataforvehicle.warningstartcallbacks = [];
        leveldataforvehicle.warningendcallbacks = [];
        leveldataforvehicle.warningclearcallbacks = [];
        leveldataforvehicle.id = undefined;
    }
    
    return leveldataforvehicle;
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0x229b
// Size: 0x72
function vehomn_clearall( clients, vehicleref )
{
    if ( isarray( clients ) )
    {
        foreach ( client in clients )
        {
            vehomn_clearallinternal( client, vehicleref );
        }
        
        return;
    }
    
    vehomn_clearallinternal( clients, vehicleref );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2315
// Size: 0x144
function private vehomn_clearallinternal( client, vehicleref )
{
    if ( isdefined( client ) && isplayer( client ) )
    {
        client setclientomnvar( "ui_veh_vehicle", -1 );
        client setclientomnvar( "ui_veh_current_seat", -1 );
        client setclientomnvar( "ui_veh_next_seat", -1 );
        client setclientomnvar( "ui_veh_occupant_0", -1 );
        client setclientomnvar( "ui_veh_occupant_1", -1 );
        client setclientomnvar( "ui_veh_occupant_2", -1 );
        client setclientomnvar( "ui_veh_occupant_3", -1 );
        client setclientomnvar( "ui_veh_occupant_4", -1 );
        client setclientomnvar( "ui_veh_occupant_5", -1 );
        client setclientomnvar( "ui_veh_occupant_6", -1 );
        client setclientomnvar( "ui_veh_health_percent", 0 );
        client setclientomnvar( "ui_veh_show_health", 0 );
        client setclientomnvar( "ui_veh_time_percent", 0 );
        client setclientomnvar( "ui_veh_show_time", 0 );
        client setclientomnvar( "ui_veh_fuel_percent", 100 );
        client setclientomnvar( "ui_veh_show_fuel", 0 );
        client setclientomnvar( "ui_veh_ammo_0", -1 );
        client setclientomnvar( "ui_veh_ammo_1", -1 );
        vehomn_clearwarnings( client, vehicleref );
        client setclientomnvar( "ui_veh_degrees_0", 0 );
        client setclientomnvar( "ui_veh_degrees_1", 0 );
        vehomn_clearcontrols( client );
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 4
// Checksum 0x0, Offset: 0x2461
// Size: 0x417
function vehomn_updateomnvarsonseatenter( vehicle, oldseatid, newseatid, player )
{
    vehomn_setvehicle( vehicle.vehiclename, player );
    vehomn_setcurrentseat( vehicle, newseatid, player );
    lowfuelsound = "uin_veh_warning_low_fuel";
    outoffuelsound = "uin_veh_warning_out_of_fuel";
    
    if ( istrue( vehicle scripts\common\vehicle::ishelicopter() ) )
    {
        lowfuelsound = "uin_veh_warning_low_fuel_heli";
        outoffuelsound = "uin_veh_warning_out_of_fuel_heli";
    }
    
    everyone = function_efa75aa7f0a1289( vehicle );
    
    if ( isdefined( oldseatid ) )
    {
        vehomn_clearseatentity( vehicle.vehiclename, oldseatid, everyone );
    }
    else
    {
        foreach ( occupant in vehicle_occupancy_getalloccupants( vehicle ) )
        {
            if ( isdefined( occupant ) && occupant != player )
            {
                vehomn_setseatentity( vehicle.vehiclename, seatid, occupant, player );
            }
        }
    }
    
    vehomn_setseatentity( vehicle.vehiclename, newseatid, player, everyone );
    vehomn_updatenextseatomnvars( vehicle );
    
    if ( vehicle.health < vehicle.maxhealth )
    {
        vehomn_updateomnvarsondamage( vehicle );
    }
    
    if ( scripts\cp_mp\vehicles\vehicle_interact::function_a717a31ae35ba01c() && isdefined( vehicle.fuel ) )
    {
        vehicle vehomn_showfuel( player );
        vehicle function_272f4112182763bd( player );
    }
    
    vehomn_showcontrols( player );
    veh_updateomnvarsperframeforclient( vehicle, player, newseatid );
    leveldataforvehicle = vehomn_getleveldataforvehicle( vehicle.vehiclename );
    
    if ( istrue( vehicle.var_15c05fe1c0f6de03 ) )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "BunkerBusterAttached" ] ) )
        {
            vehomn_showwarning( "BunkerBusterAttached", player, vehicle.vehiclename );
        }
    }
    
    if ( scripts\cp_mp\utility\weapon_utility::islockedonto( vehicle ) )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "missileLocking" ] ) )
        {
            vehomn_showwarning( "missileLocking", player, vehicle.vehiclename );
        }
    }
    
    if ( scripts\cp_mp\utility\weapon_utility::hasincoming( vehicle ) )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "missileIncoming" ] ) )
        {
            vehomn_showwarning( "missileIncoming", player, vehicle.vehiclename );
        }
    }
    
    if ( !scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_movementisallowed( vehicle ) )
    {
        if ( istrue( vehicle.islocked ) )
        {
            if ( isdefined( leveldataforvehicle.warningbits[ "locked" ] ) )
            {
                vehomn_showwarning( "locked", player, vehicle.vehiclename );
            }
        }
        else if ( isdefined( vehicle.fuel ) && vehicle.fuel <= 0 && isdefined( leveldataforvehicle.warningbits[ "outOfFuel" ] ) )
        {
            vehomn_showwarning( "outOfFuel", player, vehicle.vehiclename );
        }
        else if ( isdefined( leveldataforvehicle.warningbits[ "movementDisabled" ] ) )
        {
            vehomn_showwarning( "movementDisabled", player, vehicle.vehiclename );
        }
        
        if ( soundexists( outoffuelsound ) && !isdefined( oldseatid ) )
        {
            player stoplocalsound( outoffuelsound );
            player playlocalsound( outoffuelsound );
        }
    }
    
    if ( vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown() )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "burningDown" ] ) )
        {
            vehomn_showwarning( "burningDown", player, vehicle.vehiclename );
        }
    }
    
    if ( isdefined( vehicle.fuel ) && vehicle.fuel <= 25 && vehicle.fuel > 0 )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "lowFuel" ] ) )
        {
            vehomn_showwarning( "lowFuel", player, vehicle.vehiclename );
            
            if ( soundexists( outoffuelsound ) && !isdefined( oldseatid ) )
            {
                player stoplocalsound( lowfuelsound );
                player playlocalsound( lowfuelsound );
            }
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0x2880
// Size: 0x37e
function function_d2d9c09551d91164( vehicle, player )
{
    if ( getdvarint( @"mgl", 0 ) )
    {
        return;
    }
    
    vehomn_setvehicle( vehicle.vehiclename, player );
    lowfuelsound = "uin_veh_warning_low_fuel";
    outoffuelsound = "uin_veh_warning_out_of_fuel";
    
    foreach ( occupant in vehicle_occupancy_getalloccupants( vehicle ) )
    {
        if ( isdefined( occupant ) && occupant != player )
        {
            vehomn_setseatentity( vehicle.vehiclename, seatid, occupant, player );
        }
    }
    
    if ( istrue( scripts\common\vehicle::ishelicopter() ) )
    {
        lowfuelsound = "uin_veh_warning_low_fuel_heli";
        outoffuelsound = "uin_veh_warning_out_of_fuel_heli";
    }
    
    if ( vehicle.health < vehicle.maxhealth )
    {
        vehomn_updateomnvarsondamage( vehicle );
    }
    
    if ( scripts\cp_mp\vehicles\vehicle_interact::function_a717a31ae35ba01c() && isdefined( vehicle.fuel ) )
    {
        vehicle vehomn_showfuel( player );
        vehicle function_272f4112182763bd( player );
    }
    
    leveldataforvehicle = vehomn_getleveldataforvehicle( vehicle.vehiclename );
    
    if ( scripts\cp_mp\utility\weapon_utility::hasBunkerBustersAttached( vehicle ) )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "missileLocking" ] ) )
        {
            vehomn_showwarning( "missileLocking", player, vehicle.vehiclename );
        }
    }
    
    if ( scripts\cp_mp\utility\weapon_utility::islockedonto( vehicle ) )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "missileLocking" ] ) )
        {
            vehomn_showwarning( "missileLocking", player, vehicle.vehiclename );
        }
    }
    
    if ( scripts\cp_mp\utility\weapon_utility::hasincoming( vehicle ) )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "missileIncoming" ] ) )
        {
            vehomn_showwarning( "missileIncoming", player, vehicle.vehiclename );
        }
    }
    
    if ( !scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_movementisallowed( vehicle ) )
    {
        if ( istrue( vehicle.islocked ) )
        {
            if ( isdefined( leveldataforvehicle.warningbits[ "locked" ] ) )
            {
                vehomn_showwarning( "locked", player, vehicle.vehiclename );
            }
        }
        else if ( isdefined( vehicle.fuel ) && vehicle.fuel <= 0 && isdefined( leveldataforvehicle.warningbits[ "outOfFuel" ] ) )
        {
            vehomn_showwarning( "outOfFuel", player, vehicle.vehiclename );
            
            if ( soundexists( outoffuelsound ) )
            {
                player playlocalsound( outoffuelsound );
            }
        }
        else if ( isdefined( leveldataforvehicle.warningbits[ "movementDisabled" ] ) )
        {
            vehomn_showwarning( "movementDisabled", player, vehicle.vehiclename );
        }
    }
    
    if ( vehicle scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isburningdown() )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "burningDown" ] ) )
        {
            vehomn_showwarning( "burningDown", player, vehicle.vehiclename );
        }
    }
    
    if ( isdefined( vehicle.fuel ) && vehicle.fuel <= 25 && vehicle.fuel > 0 )
    {
        if ( isdefined( leveldataforvehicle.warningbits[ "lowFuel" ] ) )
        {
            vehomn_showwarning( "lowFuel", player, vehicle.vehiclename );
            
            if ( soundexists( lowfuelsound ) )
            {
                player playlocalsound( lowfuelsound );
            }
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 4
// Checksum 0x0, Offset: 0x2c06
// Size: 0x73
function vehomn_updateomnvarsonseatexit( vehicle, oldseatid, newseatid, player )
{
    if ( !isdefined( newseatid ) )
    {
        if ( isdefined( oldseatid ) )
        {
            vehomn_clearall( player, vehicle.vehiclename );
            
            if ( isdefined( vehicle ) )
            {
                occupants = function_efa75aa7f0a1289( vehicle );
                vehomn_clearseatentity( vehicle.vehiclename, oldseatid, occupants );
                vehomn_updatenextseatomnvars( vehicle );
            }
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0x2c81
// Size: 0x26
function function_5211953231a09ed5( vehicle, player )
{
    vehomn_clearall( player, vehicle.vehiclename );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0x2caf
// Size: 0xa6
function vehomn_updateomnvarsondamage( vehicle, data )
{
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( vehicle, 0 );
    
    if ( !isdefined( data ) )
    {
        healthpercent = int( clamp( vehicle.health / vehicle.maxhealth * 100, 0, 100 ) );
    }
    else
    {
        healthpercent = int( clamp( ( vehicle.health - data.damage ) / vehicle.maxhealth * 100, 0, 100 ) );
    }
    
    vehomn_showhealth( occupants );
    vehomn_sethealthpercent( healthpercent, occupants );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0x2d5d
// Size: 0xd0
function vehomn_updateomnvarsperframe( vehicle, data )
{
    if ( !isdefined( data ) )
    {
        data = spawnstruct();
    }
    
    leveldataforvehicle = vehomn_getleveldataforvehicle( vehicle.vehiclename, undefined, 1 );
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::function_efa75aa7f0a1289( vehicle );
    
    if ( isdefined( occupants ) && isdefined( leveldataforvehicle ) )
    {
        if ( isdefined( occupants ) && occupants.size > 0 )
        {
            foreach ( occupant in occupants )
            {
                if ( isdefined( occupant ) && isplayer( occupant ) && occupant scripts\cp_mp\utility\player_utility::_isalive() )
                {
                    veh_updateomnvarsperframeforclient( vehicle, occupant, seatid, data );
                }
            }
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 4
// Checksum 0x0, Offset: 0x2e35
// Size: 0x5a
function veh_updateomnvarsperframeforclient( vehicle, client, seatid, data )
{
    if ( !isdefined( seatid ) )
    {
        seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat( vehicle, client );
    }
    
    assertex( isdefined( seatid ), "veh_updateOmnvarsPerFrameForClient could not find a seatID for client " + client getentitynumber() + "." );
    vehomn_updaterotationomnvarsperframeforclient( vehicle, client, seatid, data );
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 1
// Checksum 0x0, Offset: 0x2e97
// Size: 0x86
function vehomn_updatenextseatomnvars( vehicle )
{
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( vehicle );
    
    foreach ( occupant in occupants )
    {
        nextseatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getnextavailableseat( vehicle, occupant, seatid );
        vehomn_setnextseat( vehicle.vehiclename, nextseatid, occupant );
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 4
// Checksum 0x0, Offset: 0x2f25
// Size: 0x1d8
function vehomn_updaterotationomnvarsperframeforclient( vehicle, client, seatid, data )
{
    leveldataforvehicle = vehomn_getleveldataforvehicle( vehicle.vehiclename );
    
    if ( leveldataforvehicle.rotationrefsbyseatandweapon.size > 0 && isdefined( leveldataforvehicle.rotationrefsbyseatandweapon[ seatid ] ) )
    {
        usingcamera = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat( vehicle, seatid );
        leveldataforseat = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( vehicle.vehiclename, seatid );
        
        if ( usingcamera )
        {
            if ( isdefined( vehicle.objweapon ) )
            {
                rotationref = leveldataforvehicle.rotationrefsbyseatandweapon[ seatid ][ vehicle.objweapon.basename ];
                
                if ( isdefined( rotationref ) )
                {
                    invertedangles = invertangles( client getplayerangles() );
                    angles = vehicle.angles;
                    entangles = combineangles( invertedangles, angles );
                    entrotation = angleclamp( entangles[ 1 ] );
                    vehomn_setrotation( vehicle.vehiclename, rotationref, entrotation, client );
                }
            }
        }
        
        anglesarr = vehomn_getrotationentangles( vehicle, data );
        
        if ( isdefined( anglesarr ) )
        {
            foreach ( rotationref in leveldataforvehicle.rotationrefsbyseatandweapon[ seatid ] )
            {
                entangles = anglesarr[ weaponname ];
                
                if ( isdefined( entangles ) )
                {
                    entrotation = angleclamp( entangles[ 1 ] );
                    vehomn_setrotation( vehicle.vehiclename, rotationref, entrotation, client );
                }
            }
        }
    }
}

// Namespace vehicle_omnvar_utility / scripts\cp_mp\utility\vehicle_omnvar_utility
// Params 2
// Checksum 0x0, Offset: 0x3105
// Size: 0x133
function vehomn_getrotationentangles( vehicle, data )
{
    if ( isdefined( data ) && isdefined( data.localangles ) )
    {
        return data.rotationentangles;
    }
    
    leveldataforvehicle = vehomn_getleveldataforvehicle( vehicle function_d93ec4635290febd(), 1 );
    ents = scripts\cp_mp\vehicles\vehicle::vehicle_getturrets( vehicle );
    
    if ( isdefined( leveldataforvehicle.mainturretweapon ) && isdefined( vehicle gettagorigin( "tag_flash" ) ) )
    {
        ents[ leveldataforvehicle.mainturretweapon ] = vehicle;
    }
    
    if ( isdefined( ents ) && ents.size > 0 )
    {
        entangles = [];
        vehicleanglesinverted = invertangles( vehicle.angles );
        
        foreach ( ent in ents )
        {
            entangles[ weaponname ] = combineangles( vehicleanglesinverted, ent gettagangles( "tag_flash" ) );
        }
        
        if ( isdefined( data ) )
        {
            data.rotationentangles = entangles;
        }
        
        return entangles;
    }
    
    return undefined;
}

