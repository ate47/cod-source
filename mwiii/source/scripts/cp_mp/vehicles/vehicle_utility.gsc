#using scripts\engine\utility;

#namespace vehicle_utility;

// Namespace vehicle_utility / scripts\cp_mp\vehicles\vehicle_utility
// Params 0
// Checksum 0x0, Offset: 0x90
// Size: 0x26, Type: bool
function function_bbdfa26a1db6eb7b()
{
    return isdefined( self ) && isdefined( level.escortvehicles ) && array_contains( level.escortvehicles, self );
}

