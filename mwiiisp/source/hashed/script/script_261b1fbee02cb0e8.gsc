#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;

#namespace namespace_243a54064fe38311;

// Namespace namespace_243a54064fe38311 / namespace_f81a63d689a24e74
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0xa0
// Size: 0x1e
function autoexec main()
{
    level.shouldinitvehicles = 1;
    function_c0b3ddc9a6bdcc46( "veh_jup_mil_cargo_truck", &function_c9c6d4d13a396d8d );
}

// Namespace namespace_243a54064fe38311 / namespace_f81a63d689a24e74
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xc6
// Size: 0x1d
function private function_c9c6d4d13a396d8d()
{
    if ( !function_9697379150687859( "veh_jup_mil_cargo_truck" ) )
    {
        return;
    }
    
    function_8497e7e46b5e397( "veh_jup_mil_cargo_truck" );
}

