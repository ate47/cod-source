#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace namespace_ea330d0bf6ebd3d9;

// Namespace namespace_ea330d0bf6ebd3d9 / namespace_e19027ce6d65052c
// Params 0
// Checksum 0x0, Offset: 0xba
// Size: 0xb
function recondrone_init()
{
    level thread function_344254816bb001eb();
}

// Namespace namespace_ea330d0bf6ebd3d9 / namespace_e19027ce6d65052c
// Params 0
// Checksum 0x0, Offset: 0xcd
// Size: 0x75
function function_344254816bb001eb()
{
    waitframe();
    level.helperdronesettings[ "radar_drone_recon" ].maxhealth = 150;
    level.helperdronesettings[ "radar_drone_recon" ].repeatuse = 1;
    level.helperdronesettings[ "radar_drone_recon" ].var_cb2c3fe0819193eb = 36000000;
    level.helperdronesettings[ "radar_drone_recon" ].var_1947a47c2174d02c = 0;
}

