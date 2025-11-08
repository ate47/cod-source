#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;

#namespace script_struct_mp_jup_jltv;

// Namespace script_struct_mp_jup_jltv / scripts\quaked\script_struct_mp_jup_jltv
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x112
// Size: 0x1e
function autoexec main()
{
    level.shouldinitvehicles = 1;
    function_c0b3ddc9a6bdcc46( "veh_jup_jltv", &function_d3890e30943d672c );
}

// Namespace script_struct_mp_jup_jltv / scripts\quaked\script_struct_mp_jup_jltv
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x138
// Size: 0x3c
function private function_d3890e30943d672c()
{
    if ( !function_9697379150687859( "veh_jup_jltv" ) )
    {
        return;
    }
    
    if ( utility::iscp() )
    {
        registersharedfunc( "veh_jup_jltv", "create", &function_770292fe92b71912 );
    }
    
    function_8497e7e46b5e397( "veh_jup_jltv" );
}

// Namespace script_struct_mp_jup_jltv / scripts\quaked\script_struct_mp_jup_jltv
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x17c
// Size: 0x2d
function private function_770292fe92b71912( vehicle )
{
    vehicle.vehicle_specific_onentervehicle = &function_f131c851f1c4e709;
    vehicle.vehicle_specific_onexitvehicle = &function_7b4a4367ee409795;
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace script_struct_mp_jup_jltv / scripts\quaked\script_struct_mp_jup_jltv
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x1b1
// Size: 0x91
function private function_f131c851f1c4e709( vehicle, newseatid, player, data )
{
    if ( istrue( vehicle.door_open ) )
    {
        vehicle vehicleplayanim( %reb_com_veh8_techo_fl_door_close );
        vehicle.door_open = undefined;
    }
    
    if ( istrue( level.var_d39df167f3a996b0 ) )
    {
        vehicle setscriptablepartstate( "lights", "on" );
    }
    
    if ( isdefined( vehicle.var_f24cc3beef01650c ) )
    {
        vehicle.var_1ab6b61153087915 = vehicle.var_f24cc3beef01650c;
    }
}

// Namespace script_struct_mp_jup_jltv / scripts\quaked\script_struct_mp_jup_jltv
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x24a
// Size: 0x48
function private function_7b4a4367ee409795( vehicle, newseatid, player, data )
{
    if ( !istrue( data.playerdisconnect ) )
    {
        player.isdrivingvehicle = undefined;
    }
    
    vehicle.var_1ab6b61153087915 = undefined;
}

