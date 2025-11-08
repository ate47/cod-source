#using script_7f36f22bad523244;
#using script_fdbc9069851786a;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\supers;

#namespace force_field;

// Namespace force_field / scripts\mp\gametypes\force_field
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x160
// Size: 0x2a
function autoexec callback_init()
{
    level waittill( "mp_equipment_init" );
    function_2fe1faaffe9ed832();
    level callback::add( "force_field_deploy", &force_field_deploy );
    namespace_70f55ec9ba5b3e64::function_f705d78f8780628d();
}

// Namespace force_field / scripts\mp\gametypes\force_field
// Params 0
// Checksum 0x0, Offset: 0x192
// Size: 0x3a
function function_2fe1faaffe9ed832()
{
    scripts\engine\scriptable::scriptable_adddamagedcallback( &namespace_70f55ec9ba5b3e64::function_774a2c15e69350e4 );
    level.equipment.callbacks[ "equip_mutation_shield" ][ "onFired" ] = &namespace_70f55ec9ba5b3e64::shield_onuse;
    namespace_70f55ec9ba5b3e64::function_308f48ed405d1347();
}

// Namespace force_field / scripts\mp\gametypes\force_field
// Params 1
// Checksum 0x0, Offset: 0x1d4
// Size: 0x19
function force_field_deploy( params )
{
    namespace_70f55ec9ba5b3e64::function_308f48ed405d1347();
    namespace_70f55ec9ba5b3e64::function_4b3a8e81d4a07ffc();
}

// Namespace force_field / scripts\mp\gametypes\force_field
// Params 5
// Checksum 0x0, Offset: 0x1f5
// Size: 0x83
function function_ebf9c5039dea6423( health, player, attacker, victim, damage )
{
    player setclientomnvar( "ui_arcade_forcefield_progress", health );
    
    if ( getdvarint( @"hash_4b664c074a868ac5", 0 ) && getdvarint( @"hash_8a8ff6ed00ccc7a", 0 ) )
    {
        waskilled = health <= 0 ? 1 : 0;
        damage::function_c54b2cc2e762c201( attacker, victim, damage, undefined, waskilled, 1 );
    }
}

