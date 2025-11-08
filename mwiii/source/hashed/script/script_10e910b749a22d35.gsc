#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\utility;
#using scripts\mp\perks\perks;
#using scripts\mp\utility\dvars;
#using scripts\mp\weapons;

#namespace perk_staminup;

// Namespace perk_staminup / namespace_5efced722c5f35cb
// Params 2
// Checksum 0x0, Offset: 0x106
// Size: 0x36
function function_e7866458a76d3194( str_currency, var_fe59c44529c721a0 )
{
    level thread function_f3a23df892bf82f6( "specialty_staminup", str_currency, var_fe59c44529c721a0, &function_bb6c42516338413b, &function_bd187786deecd41d );
    level thread function_44f47de92eab835d();
}

// Namespace perk_staminup / namespace_5efced722c5f35cb
// Params 0
// Checksum 0x0, Offset: 0x144
// Size: 0x19
function function_44f47de92eab835d()
{
    waitframe();
    registerscriptperk( "specialty_zombies_lightweight", &function_511c457470bcb996, &function_f48647121583369b );
}

// Namespace perk_staminup / namespace_5efced722c5f35cb
// Params 0
// Checksum 0x0, Offset: 0x165
// Size: 0x9
function function_bb6c42516338413b()
{
    function_7153488861bda17e();
}

// Namespace perk_staminup / namespace_5efced722c5f35cb
// Params 4
// Checksum 0x0, Offset: 0x176
// Size: 0x2a
function function_bd187786deecd41d( b_pause, str_perk, str_result, n_slot )
{
    function_a0af73943eed3890();
}

// Namespace perk_staminup / namespace_5efced722c5f35cb
// Params 0
// Checksum 0x0, Offset: 0x1a8
// Size: 0xe
function function_7153488861bda17e()
{
    function_ab7a3ff9f75e4867( "specialty_staminup" );
}

// Namespace perk_staminup / namespace_5efced722c5f35cb
// Params 0
// Checksum 0x0, Offset: 0x1be
// Size: 0xe
function function_a0af73943eed3890()
{
    function_fe0d28e6f0008329( "specialty_staminup" );
}

// Namespace perk_staminup / namespace_5efced722c5f35cb
// Params 0
// Checksum 0x0, Offset: 0x1d4
// Size: 0x51
function function_511c457470bcb996()
{
    perkbundle = level.perkbundles[ "specialty_staminup" ];
    speedincrease = default_to( perkbundle.var_926b825efb2d70d2, 0.05 );
    scripts\mp\weapons::addextramovespeed( "specialty_staminup", speedincrease );
    scripts\mp\weapons::updatemovespeedscale();
}

// Namespace perk_staminup / namespace_5efced722c5f35cb
// Params 0
// Checksum 0x0, Offset: 0x22d
// Size: 0x15
function function_f48647121583369b()
{
    scripts\mp\weapons::removeextramovespeed( "specialty_staminup" );
    scripts\mp\weapons::updatemovespeedscale();
}

