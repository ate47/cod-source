#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\equipment\support_box;
#using scripts\mp\weapons;

#namespace armor_box_mp;

// Namespace armor_box_mp / scripts\mp\equipment\armor_box_mp
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x108
// Size: 0x18
function autoexec main()
{
    registersharedfunc( "armor_drop", "init", &init );
}

// Namespace armor_box_mp / scripts\mp\equipment\armor_box_mp
// Params 0
// Checksum 0x0, Offset: 0x128
// Size: 0x10
function init()
{
    level.onarmorboxusedbyplayer = &onarmorboxusedbyplayer;
}

// Namespace armor_box_mp / scripts\mp\equipment\armor_box_mp
// Params 1
// Checksum 0x0, Offset: 0x140
// Size: 0x90, Type: bool
function onarmorboxusedbyplayer( player )
{
    armoramount = getdvarint( @"hash_796878180a8e250", 4 );
    
    if ( isdefined( player.equipment ) && !isdefined( player.equipment[ "health" ] ) )
    {
        player.equipment[ "health" ] = "equip_armorplate";
    }
    
    player scripts\mp\equipment::incrementequipmentslotammo( "health", armoramount );
    player hudicontype( "br_armor" );
    scripts\mp\equipment\support_box::supportbox_playusesound( player );
    thread scripts\mp\equipment\support_box::supportbox_onplayeruseanim();
    return true;
}

