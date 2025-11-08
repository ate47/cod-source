#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;

#namespace namespace_9e66f70aad951124;

// Namespace namespace_9e66f70aad951124 / namespace_a8c01726524388f5
// Params 0
// Checksum 0x0, Offset: 0xaf
// Size: 0x13
function main()
{
    function_c0b3ddc9a6bdcc46( "atv", &atv_init );
}

// Namespace namespace_9e66f70aad951124 / namespace_a8c01726524388f5
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xca
// Size: 0x1d
function private atv_init()
{
    if ( !function_9697379150687859( "atv" ) )
    {
        return;
    }
    
    function_8497e7e46b5e397( "atv" );
}

