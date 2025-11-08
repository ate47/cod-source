#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;

#namespace namespace_25855beb6219459;

// Namespace namespace_25855beb6219459 / namespace_6258b6d1cdc40598
// Params 0
// Checksum 0x0, Offset: 0xd0
// Size: 0x13
function main()
{
    function_c0b3ddc9a6bdcc46( "veh9_civ_lnd_motorcycle_cruiser_2008", &function_b103169a6a0515ba );
}

// Namespace namespace_25855beb6219459 / namespace_6258b6d1cdc40598
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xeb
// Size: 0x27
function private function_b103169a6a0515ba()
{
    if ( !function_9697379150687859( "veh9_civ_lnd_motorcycle_cruiser_2008" ) )
    {
        return;
    }
    
    if ( iscp() )
    {
        return;
    }
    
    function_8497e7e46b5e397( "veh9_civ_lnd_motorcycle_cruiser_2008" );
}

