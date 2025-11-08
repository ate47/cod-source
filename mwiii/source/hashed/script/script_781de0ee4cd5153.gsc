#using scripts\cp_mp\weapon;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\utility\inventory;

#namespace namespace_357503b62afdbcce;

// Namespace namespace_357503b62afdbcce / namespace_29d0f7f595f86b3f
// Params 4
// Checksum 0x0, Offset: 0xf3
// Size: 0x87
function function_e6019a2d874f8c36( weaponname, attachmentsstring, position, angles )
{
    weapattachments = strtok( attachmentsstring, "+" );
    weaponobj = buildweapon( weaponname, weapattachments, undefined, undefined, -1, undefined, undefined, undefined, 0 );
    dropinfo = getitemdropinfo( position, angles );
    weaponpickup = spawnpickup( "brloot_weapon_generic_ar", dropinfo, 30, 1, weaponobj, 0, 0, 0 );
    return weaponpickup;
}

// Namespace namespace_357503b62afdbcce / namespace_29d0f7f595f86b3f
// Params 1
// Checksum 0x0, Offset: 0x183
// Size: 0x48
function function_40f588e8c075f3a1( ammoposition )
{
    objweapon = level.player getcurrentweapon();
    weaponammotype = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon( objweapon );
    var_9c6a94f2fb790c57 = spawnscriptable( weaponammotype, ammoposition );
    return var_9c6a94f2fb790c57;
}

// Namespace namespace_357503b62afdbcce / namespace_29d0f7f595f86b3f
// Params 1
// Checksum 0x0, Offset: 0x1d4
// Size: 0x2b
function function_198b77714911ae07( var_2ab69f8accb95d4a )
{
    self endon( "death" );
    self endon( "disconnect" );
    
    while ( !self isreloading() )
    {
        waitframe();
    }
    
    self [[ var_2ab69f8accb95d4a ]]();
}

// Namespace namespace_357503b62afdbcce / namespace_29d0f7f595f86b3f
// Params 0
// Checksum 0x0, Offset: 0x207
// Size: 0x32, Type: bool
function function_d88d4f1f9cbb8512()
{
    firstweapon = getfirstprimaryweapon();
    
    if ( isdefined( firstweapon ) && firstweapon.basename != "iw9_me_fists_mp" )
    {
        return true;
    }
    
    return false;
}

