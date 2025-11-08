#using scripts\cp_mp\vehicles\vehicle;

#namespace namespace_a8bb5c49b9f32539;

// Namespace namespace_a8bb5c49b9f32539 / namespace_93c4ea1b467bfe9c
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0xb6
// Size: 0x1e
function autoexec main()
{
    level.shouldinitvehicles = 1;
    function_c0b3ddc9a6bdcc46( "veh_jup_ru_heli_transport", &function_1836611c4ec791a2 );
}

// Namespace namespace_a8bb5c49b9f32539 / namespace_93c4ea1b467bfe9c
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xdc
// Size: 0x29
function private function_1836611c4ec791a2()
{
    callbacks = [];
    callbacks[ "spawn" ] = &function_7c332db718c995af;
    function_8497e7e46b5e397( "veh_jup_ru_heli_transport", callbacks );
}

// Namespace namespace_a8bb5c49b9f32539 / namespace_93c4ea1b467bfe9c
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x10d
// Size: 0x7d
function private function_7c332db718c995af( spawndata, faildata )
{
    vehicle = function_bba34cf920370ff4( "veh_jup_ru_heli_transport", spawndata, faildata );
    
    if ( !isdefined( vehicle ) )
    {
        return undefined;
    }
    
    if ( istrue( spawndata.initai ) )
    {
        vehicle vehicle_setspeed( 60, 20, 10 );
        vehicle.preventrespawn = 1;
        vehicle.dontspawnhusk = 1;
        vehicle.deathfunc = &vehicle_death;
    }
    
    return vehicle;
}

