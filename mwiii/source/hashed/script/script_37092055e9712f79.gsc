#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;

#namespace namespace_6740f5eaa6432488;

// Namespace namespace_6740f5eaa6432488 / namespace_b835d284f1d90ddd
// Params 0
// Checksum 0x0, Offset: 0xba
// Size: 0x13
function main()
{
    function_c0b3ddc9a6bdcc46( "veh9_atv_boost", &atv_init );
}

// Namespace namespace_6740f5eaa6432488 / namespace_b835d284f1d90ddd
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xd5
// Size: 0x1d
function private atv_init()
{
    if ( !function_9697379150687859( "veh9_atv_boost" ) )
    {
        return;
    }
    
    function_8497e7e46b5e397( "veh9_atv_boost" );
}

