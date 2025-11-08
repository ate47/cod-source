#using scripts\engine\scriptable;

#namespace scriptable;

// Namespace scriptable / scripts\common\scriptable
// Params 0
// Checksum 0x0, Offset: 0x70
// Size: 0x9
function scriptable_initialize()
{
    scripts\engine\scriptable::scriptable_engineinitialize();
}

// Namespace scriptable / scripts\common\scriptable
// Params 0
// Checksum 0x0, Offset: 0x81
// Size: 0x9
function scriptable_post_initialize()
{
    scripts\engine\scriptable::scriptable_enginepostinitialize();
}

// Namespace scriptable / scripts\common\scriptable
// Params 6
// Checksum 0x0, Offset: 0x92
// Size: 0x40
function scriptable_used( instance, part, state, player, bautouse, usestring )
{
    scripts\engine\scriptable::scriptable_engineused( instance, part, state, player, bautouse, usestring );
}

// Namespace scriptable / scripts\common\scriptable
// Params 5
// Checksum 0x0, Offset: 0xda
// Size: 0x37
function function_9ea56c6edd53918( instance, part, state, player, useduration )
{
    scripts\engine\scriptable::function_2cdeacfad7141a8d( instance, part, state, player, useduration );
}

// Namespace scriptable / scripts\common\scriptable
// Params 2
// Checksum 0x0, Offset: 0x119
// Size: 0x1b
function function_944d769de0e6d4cb( instance, player )
{
    return scripts\engine\scriptable::function_43f2de646836802d( instance, player );
}

// Namespace scriptable / scripts\common\scriptable
// Params 13
// Checksum 0x0, Offset: 0x13d
// Size: 0x82
function function_4a7afd1c05864574( note, param, einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    scripts\engine\scriptable::scriptable_enginedamaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname );
}

// Namespace scriptable / scripts\common\scriptable
// Params 13
// Checksum 0x0, Offset: 0x1c7
// Size: 0x82
function riotshield_damaged( note, param, einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    scripts\engine\scriptable::scriptable_enginedamaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname );
}

// Namespace scriptable / scripts\common\scriptable
// Params 4
// Checksum 0x0, Offset: 0x251
// Size: 0x2e
function scriptable_touched( instance, part, state, player )
{
    scripts\engine\scriptable::scriptable_enginetouched( instance, part, state, player );
}

// Namespace scriptable / scripts\common\scriptable
// Params 5
// Checksum 0x0, Offset: 0x287
// Size: 0x37
function scriptable_notify_callback( instance, note, param, ent, var_535d9c3fdddab5a9 )
{
    scripts\engine\scriptable::scriptable_enginenotifycallback( instance, note, param, ent, var_535d9c3fdddab5a9 );
}

