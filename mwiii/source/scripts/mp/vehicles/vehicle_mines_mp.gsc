#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\engine\utility;

#namespace vehicle_mines_mp;

// Namespace vehicle_mines_mp / scripts\mp\vehicles\vehicle_mines_mp
// Params 0
// Checksum 0x0, Offset: 0xbb
// Size: 0x18
function vehicle_mines_mp_init()
{
    registersharedfunc( "vehicle_mines", "trigger", &vehicle_mines_mp_minetrigger );
}

// Namespace vehicle_mines_mp / scripts\mp\vehicles\vehicle_mines_mp
// Params 2
// Checksum 0x0, Offset: 0xdb
// Size: 0x13
function vehicle_mines_mp_minetrigger( vehicle, mine )
{
    
}

