#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\utility;
#using scripts\mp\utility\dvars;

#namespace perk_deadshot;

// Namespace perk_deadshot / namespace_5a0b98fe4ff33cb6
// Params 2
// Checksum 0x0, Offset: 0xd6
// Size: 0x45
function function_d87a1d30e15f1c8b( str_currency, var_fe59c44529c721a0 )
{
    n_perk_cost = default_to( var_fe59c44529c721a0, 2000 );
    level thread function_f3a23df892bf82f6( "specialty_deadshot", str_currency, n_perk_cost, &give_deadshot_perk, &take_deadshot_perk, 1 );
}

// Namespace perk_deadshot / namespace_5a0b98fe4ff33cb6
// Params 0
// Checksum 0x0, Offset: 0x123
// Size: 0x42
function give_deadshot_perk()
{
    function_ab7a3ff9f75e4867( "specialty_deadshot" );
    var_985ea103b97c8abb = level.perkbundles[ "specialty_deadshot" ].var_fee1a408c2a3d2d7;
    
    if ( isdefined( var_985ea103b97c8abb ) )
    {
        self.var_ae9b30f13abd35fc = var_985ea103b97c8abb;
    }
}

// Namespace perk_deadshot / namespace_5a0b98fe4ff33cb6
// Params 4
// Checksum 0x0, Offset: 0x16d
// Size: 0x34
function take_deadshot_perk( b_pause, str_perk, str_result, n_slot )
{
    function_888a7004c6bd50e9();
    self.var_ae9b30f13abd35fc = undefined;
}

// Namespace perk_deadshot / namespace_5a0b98fe4ff33cb6
// Params 0
// Checksum 0x0, Offset: 0x1a9
// Size: 0xe
function function_888a7004c6bd50e9()
{
    function_fe0d28e6f0008329( "specialty_deadshot" );
}

