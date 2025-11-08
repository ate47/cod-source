#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\utility;
#using scripts\mp\tweakables;
#using scripts\mp\utility\dvars;

#namespace perk_juggernaut;

// Namespace perk_juggernaut / namespace_7177e11e3871c8f4
// Params 2
// Checksum 0x0, Offset: 0x13f
// Size: 0x49
function function_1ddcb2ee8addbf81( str_currency, var_fe59c44529c721a0 )
{
    level thread function_f3a23df892bf82f6( "specialty_juggernog", str_currency, var_fe59c44529c721a0, &function_7e973f95d6043eb2, &function_1b6b6e760a1bdd78 );
    registerwatchdvarint( "zombie_perk_juggernaut_health", 100 );
    registerwatchdvarint( "zombie_perk_juggernaut_health_upgrade", 150 );
}

// Namespace perk_juggernaut / namespace_7177e11e3871c8f4
// Params 0
// Checksum 0x0, Offset: 0x190
// Size: 0x2
function init_juggernaut()
{
    
}

// Namespace perk_juggernaut / namespace_7177e11e3871c8f4
// Params 0
// Checksum 0x0, Offset: 0x19a
// Size: 0x2
function function_ab290f15db86a2ed()
{
    
}

// Namespace perk_juggernaut / namespace_7177e11e3871c8f4
// Params 1
// Checksum 0x0, Offset: 0x1a4
// Size: 0xb
function function_fab58c7ac85ad7ac( state )
{
    
}

// Namespace perk_juggernaut / namespace_7177e11e3871c8f4
// Params 0
// Checksum 0x0, Offset: 0x1b7
// Size: 0x9
function function_7e973f95d6043eb2()
{
    function_c01376485eb8f25();
}

// Namespace perk_juggernaut / namespace_7177e11e3871c8f4
// Params 4
// Checksum 0x0, Offset: 0x1c8
// Size: 0x2a
function function_1b6b6e760a1bdd78( b_pause, str_perk, str_result, n_slot )
{
    function_74553dbfe828d843();
}

// Namespace perk_juggernaut / namespace_7177e11e3871c8f4
// Params 0
// Checksum 0x0, Offset: 0x1fa
// Size: 0x58
function function_c01376485eb8f25()
{
    bundle = level.perkbundles[ "specialty_juggernog" ];
    var_f90e40839311224 = self.maxhealth + bundle.var_e60d66d03350bc81;
    self.maxhealth = var_f90e40839311224;
    self.health = self.maxhealth;
}

// Namespace perk_juggernaut / namespace_7177e11e3871c8f4
// Params 0
// Checksum 0x0, Offset: 0x25a
// Size: 0x32
function function_74553dbfe828d843()
{
    var_f90e40839311224 = scripts\mp\tweakables::gettweakablevalue( "player", "maxhealth" );
    self.maxhealth = var_f90e40839311224;
    self.health = var_f90e40839311224;
}

