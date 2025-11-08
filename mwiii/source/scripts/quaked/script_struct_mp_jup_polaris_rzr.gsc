#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;

#namespace namespace_de92d13bf94092d8;

// Namespace namespace_de92d13bf94092d8 / scripts\quaked\script_struct_mp_jup_polaris_rzr
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0xe8
// Size: 0x1e
function autoexec main()
{
    level.shouldinitvehicles = 1;
    function_c0b3ddc9a6bdcc46( "veh_jup_polaris_utv", &function_9df60b8a7fd8c292 );
}

// Namespace namespace_de92d13bf94092d8 / scripts\quaked\script_struct_mp_jup_polaris_rzr
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x10e
// Size: 0x38
function private function_9df60b8a7fd8c292()
{
    if ( !function_9697379150687859( "veh_jup_polaris_utv" ) )
    {
        return;
    }
    
    callbacks = [];
    callbacks[ "spawn" ] = &function_9cfc57059604bb3f;
    function_8497e7e46b5e397( "veh_jup_polaris_utv", callbacks );
}

// Namespace namespace_de92d13bf94092d8 / scripts\quaked\script_struct_mp_jup_polaris_rzr
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x14e
// Size: 0x35
function private function_9cfc57059604bb3f( spawndata, faildata )
{
    function_6991f5ef2ba63535( spawndata );
    vehicle = function_bba34cf920370ff4( "veh_jup_polaris_utv", spawndata, faildata );
    return vehicle;
}

// Namespace namespace_de92d13bf94092d8 / scripts\quaked\script_struct_mp_jup_polaris_rzr
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x18c
// Size: 0x6d
function private function_6991f5ef2ba63535( spawndata )
{
    if ( isdefined( spawndata.skinoverride ) )
    {
        switch ( spawndata.skinoverride )
        {
            case #"hash_22ce3b03c1e51a9c":
                spawndata.skinoverride = "tan";
                break;
            case #"hash_a1e9b77432f55b0e":
                spawndata.skinoverride = "green";
                break;
        }
    }
}

