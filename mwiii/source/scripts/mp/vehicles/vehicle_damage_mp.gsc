#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\engine\utility;
#using scripts\mp\events;
#using scripts\mp\rank;
#using scripts\mp\utility\points;
#using scripts\mp\vehicles\damage;

#namespace vehicle_damage_mp;

// Namespace vehicle_damage_mp / scripts\mp\vehicles\vehicle_damage_mp
// Params 0
// Checksum 0x0, Offset: 0x218
// Size: 0x10a
function vehicle_damage_mp_init()
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
    registersharedfunc( "vehicle_damage", "giveScore", &vehicle_damage_givescore );
    registersharedfunc( "vehicle_damage", "giveAward", &vehicle_damage_giveaward );
    registersharedfunc( "vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon", &vehicle_setuphitdamageoverrideforweapon );
}

// Namespace vehicle_damage_mp / scripts\mp\vehicles\vehicle_damage_mp
// Params 3
// Checksum 0x0, Offset: 0x32a
// Size: 0x34
function vehicle_damage_givescore( ref, objweapon, var_fc10bb0a0aa2990 )
{
    if ( istrue( var_fc10bb0a0aa2990 ) )
    {
        scripts\mp\rank::scoreeventpopup( ref );
        return;
    }
    
    scripts\mp\utility\points::doscoreevent( ref, objweapon );
}

// Namespace vehicle_damage_mp / scripts\mp\vehicles\vehicle_damage_mp
// Params 3
// Checksum 0x0, Offset: 0x366
// Size: 0x32
function vehicle_damage_giveaward( ref, objweapon, var_fc10bb0a0aa2990 )
{
    thread scripts\mp\events::killeventtextpopup( ref );
    
    if ( !istrue( var_fc10bb0a0aa2990 ) )
    {
        scripts\mp\utility\points::doscoreevent( ref, objweapon );
    }
}

// Namespace vehicle_damage_mp / scripts\mp\vehicles\vehicle_damage_mp
// Params 4
// Checksum 0x0, Offset: 0x3a0
// Size: 0x41
function vehicle_setuphitdamageoverrideforweapon( weaponname, weaponhitsperattack, weaponhitstokill, vehiclename )
{
    if ( isdefined( weaponhitsperattack ) )
    {
        set_weapon_hit_damage_data_for_vehicle( weaponname, weaponhitsperattack, vehiclename );
    }
    
    if ( isdefined( weaponhitstokill ) )
    {
        set_vehicle_hit_damage_data_for_weapon( vehiclename, weaponhitstokill, weaponname );
    }
}

