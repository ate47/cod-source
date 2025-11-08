#using scripts\common\utility;
#using scripts\cp\vehicles\damage_cp;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\engine\utility;

#namespace vehicle_damage_cp;

// Namespace vehicle_damage_cp / scripts\cp\vehicles\vehicle_damage_cp
// Params 0
// Checksum 0x0, Offset: 0x17d
// Size: 0xc8
function vehicle_damage_cp_init()
{
    registersharedfunc( "vehicle_damage", "setWeaponClassModDamageForVehicle", &set_weapon_class_mod_damage_data_for_vehicle );
    registersharedfunc( "vehicle_damage", "setPerkModDamage", &set_perk_mod_damage_data );
    registersharedfunc( "vehicle_damage", "setWeaponHitDamageData", &set_weapon_hit_damage_data );
    registersharedfunc( "vehicle_damage", "setWeaponHitDamageDataForVehicle", &set_weapon_hit_damage_data_for_vehicle );
    registersharedfunc( "vehicle_damage", "setVehicleHitDamageData", &set_vehicle_hit_damage_data );
    registersharedfunc( "vehicle_damage", "setVehicleHitDamageDataForWeapon", &set_vehicle_hit_damage_data_for_weapon );
    registersharedfunc( "vehicle_damage", "setPreModDamageCallback", &set_pre_mod_damage_callback );
    registersharedfunc( "vehicle_damage", "setPostModDamageCallback", &set_post_mod_damage_callback );
    registersharedfunc( "vehicle_damage", "setDeathCallback", &set_death_callback );
}

