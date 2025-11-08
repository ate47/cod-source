#using script_2d9d24f7c63ac143;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\weapon;

#namespace throwstar_mp;

// Namespace throwstar_mp / scripts\mp\equipment\throwstar_mp
// Params 0
// Checksum 0x0, Offset: 0x11a
// Size: 0x44
function function_12d7ca3ff609caba()
{
    registersharedfunc( "throwStar", "onGive", &function_e7715ffb329c1b40 );
    registersharedfunc( "throwStar", "onTake", &function_92e126d1a5d3fb2 );
    registersharedfunc( "throwstar", "tryToPickup", &function_94dcdd399513b2ce );
}

// Namespace throwstar_mp / scripts\mp\equipment\throwstar_mp
// Params 3
// Checksum 0x0, Offset: 0x166
// Size: 0x1b
function function_e7715ffb329c1b40( equipmentref, equipmentslot, variantid )
{
    
}

// Namespace throwstar_mp / scripts\mp\equipment\throwstar_mp
// Params 2
// Checksum 0x0, Offset: 0x189
// Size: 0x13
function function_92e126d1a5d3fb2( equipmentref, equipmentslot )
{
    
}

// Namespace throwstar_mp / scripts\mp\equipment\throwstar_mp
// Params 1
// Checksum 0x0, Offset: 0x1a4
// Size: 0x8d, Type: bool
function function_94dcdd399513b2ce( equipmentref )
{
    if ( !isdefined( equipmentref ) )
    {
        /#
            self iprintlnbold( "<dev string:x1c>" );
        #/
        
        return false;
    }
    
    if ( scripts\mp\equipment::hasequipment( equipmentref ) && scripts\mp\equipment::getequipmentammo( equipmentref ) < scripts\mp\equipment::getequipmentmaxammo( equipmentref ) )
    {
        scripts\mp\equipment::incrementequipmentammo( equipmentref );
    }
    else if ( namespace_aead94004cf4c147::function_7e103028c464ab9a( scripts\cp_mp\utility\loot::function_b88cfb4893ceedac( equipmentref ) ) && namespace_aead94004cf4c147::function_8a160d9935d47f5e( equipmentref, "equipment", 1 ) )
    {
        namespace_aead94004cf4c147::additemtobackpackbyref( equipmentref, "equipment", 1 );
    }
    else
    {
        return false;
    }
    
    hudicontype( "throwstar" );
    return true;
}

