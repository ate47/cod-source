#using scripts\cp_mp\vehicles\vehicle;

#namespace namespace_5416028698cc19b4;

// Namespace namespace_5416028698cc19b4 / namespace_f46292fde1291df3
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x7f
// Size: 0x1e
function autoexec main()
{
    level.shouldinitvehicles = 1;
    function_c0b3ddc9a6bdcc46( "veh_jup_ahotel", &function_14b8fe3cf0847a29 );
}

// Namespace namespace_5416028698cc19b4 / namespace_f46292fde1291df3
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xa5
// Size: 0x1d
function private function_14b8fe3cf0847a29()
{
    if ( !function_9697379150687859( "veh_jup_ahotel" ) )
    {
        return;
    }
    
    function_8497e7e46b5e397( "veh_jup_ahotel" );
}

