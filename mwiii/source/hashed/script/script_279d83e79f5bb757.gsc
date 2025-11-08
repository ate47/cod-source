#using scripts\cp_mp\vehicles\vehicle_interact;

#namespace namespace_7f5956e577370452;

// Namespace namespace_7f5956e577370452 / namespace_e9b191b702a11f6b
// Params 2
// Checksum 0x0, Offset: 0xa9
// Size: 0x25
function function_82b422f2ec92a2b7( vehiclename, vehicle )
{
    if ( function_4b8893bb155fc08b( vehiclename ) )
    {
        function_cf493e05d95647( vehicle );
    }
}

// Namespace namespace_7f5956e577370452 / namespace_e9b191b702a11f6b
// Params 1
// Checksum 0x0, Offset: 0xd6
// Size: 0x72
function function_4b8893bb155fc08b( vehname )
{
    dvarstring = hashcat( @"scr_", vehname );
    
    if ( getdvar( dvarstring, "" ) == "" )
    {
        setdvar( dvarstring, "enable" );
    }
    
    println( "<dev string:x1c>" + vehname );
    dvarstatus = getdvar( dvarstring, "enable" ) == "disable";
    return dvarstatus;
}

// Namespace namespace_7f5956e577370452 / namespace_e9b191b702a11f6b
// Params 1
// Checksum 0x0, Offset: 0x151
// Size: 0x22
function function_cf493e05d95647( vehicle )
{
    println( "<dev string:x30>" );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse( vehicle, 0 );
}

