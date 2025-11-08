#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;

#namespace namespace_1fce23c232dc778e;

// Namespace namespace_1fce23c232dc778e / scripts\quaked\script_struct_mp_iw9_dirt_bike
// Params 0
// Checksum 0x0, Offset: 0xc2
// Size: 0x13
function main()
{
    function_c0b3ddc9a6bdcc46( "veh9_civ_lnd_dirt_bike", &function_22e02886ba8d83bf );
}

// Namespace namespace_1fce23c232dc778e / scripts\quaked\script_struct_mp_iw9_dirt_bike
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xdd
// Size: 0xfe
function private function_22e02886ba8d83bf()
{
    if ( !function_9697379150687859( "veh9_civ_lnd_dirt_bike" ) )
    {
        return;
    }
    
    if ( iscp() )
    {
        return;
    }
    
    function_8497e7e46b5e397( "veh9_civ_lnd_dirt_bike" );
    
    if ( getdvarint( @"hash_12368a7f8188c51e", 1 ) == 1 )
    {
        data = function_29b4292c92443328( "veh9_civ_lnd_dirt_bike" );
        
        foreach ( tag, damagedata in data.damage.damageableparts )
        {
            if ( isdefined( damagedata.wheelref ) )
            {
                data.damage.damageableparts[ tag ] = undefined;
                data.damage.var_9d70f02394c136da[ tag ] = undefined;
                data.damage.var_ccfde1208ef2964b[ tag ] = undefined;
            }
        }
    }
}

