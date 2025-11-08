#using scripts\cp_mp\weapon;
#using scripts\mp\class;
#using scripts\mp\utility\game;

#namespace namespace_cbc0dc8b9328d67d;

// Namespace namespace_cbc0dc8b9328d67d / namespace_89e4915e27d8b4fc
// Params 1
// Checksum 0x0, Offset: 0x112
// Size: 0x170
function overrideweapons( loadout )
{
    if ( getdvarint( @"hash_bfeff1537a1a0edc", 0 ) )
    {
        var_58bf9fc74049f30 = "weapon_sniper";
    }
    
    primaryweaponclass = function_b8811a0fc04e4b9d( loadout.loadoutprimary, #"menuclass" );
    
    if ( isdefined( var_58bf9fc74049f30 ) && primaryweaponclass != var_58bf9fc74049f30 || weaponisrestricted( loadout.loadoutprimary ) || isdefined( primaryweaponclass ) && weaponclassisrestricted( primaryweaponclass ) )
    {
        fallbackprimary = scripts\mp\class::table_getweapon( level.classtablename, 0, 0 );
        loadout.loadoutprimary = fallbackprimary;
        loadout.loadoutprimaryattachments = [];
        
        if ( scripts\mp\utility\game::function_f24e99a2f548d0b8() )
        {
            loadout.loadoutprimaryvariantid = -1;
        }
    }
    
    secondaryweaponclass = function_b8811a0fc04e4b9d( loadout.loadoutsecondary, #"menuclass" );
    
    if ( isdefined( var_58bf9fc74049f30 ) && secondaryweaponclass != var_58bf9fc74049f30 || weaponisrestricted( loadout.loadoutsecondary ) || isdefined( secondaryweaponclass ) && weaponclassisrestricted( secondaryweaponclass ) )
    {
        fallbacksecondary = scripts\mp\class::table_getweapon( level.classtablename, 0, 1 );
        loadout.loadoutsecondary = fallbacksecondary;
        loadout.loadoutsecondaryattachments = [];
        
        if ( scripts\mp\utility\game::function_f24e99a2f548d0b8() )
        {
            loadout.loadoutsecondaryvariantid = -1;
        }
    }
    
    return loadout;
}

// Namespace namespace_cbc0dc8b9328d67d / namespace_89e4915e27d8b4fc
// Params 1
// Checksum 0x0, Offset: 0x28b
// Size: 0x43
function overrideprimaryweapon( loadout )
{
    fallbackprimary = scripts\mp\class::table_getweapon( level.classtablename, 0, 0 );
    loadout.loadoutprimary = fallbackprimary;
    loadout.loadoutprimaryattachments = [];
    return loadout;
}

// Namespace namespace_cbc0dc8b9328d67d / namespace_89e4915e27d8b4fc
// Params 1
// Checksum 0x0, Offset: 0x2d7
// Size: 0x44
function overridesecondaryweapon( loadout )
{
    fallbacksecondary = scripts\mp\class::table_getweapon( level.classtablename, 0, 1 );
    loadout.loadoutsecondary = fallbacksecondary;
    loadout.loadoutsecondaryattachments = [];
    return loadout;
}

// Namespace namespace_cbc0dc8b9328d67d / namespace_89e4915e27d8b4fc
// Params 1
// Checksum 0x0, Offset: 0x324
// Size: 0xac
function function_754c5fbcd73cf12d( loadout )
{
    msg = "Overriding FLC Perks. ";
    
    for ( i = 0; i < loadout.loadoutperks.size ; i++ )
    {
        msg += "Perk " + i + ": " + loadout.loadoutperks[ i ];
    }
    
    /#
        assertmsg( msg );
        
        for ( perkindex = 0; perkindex < loadout.loadoutperks.size ; perkindex++ )
        {
            loadout.loadoutperks[ perkindex ] = scripts\mp\class::function_f8e92e6cd8007d6b( level.classtablename, 0, perkindex );
        }
    #/
    
    return loadout;
}

// Namespace namespace_cbc0dc8b9328d67d / namespace_89e4915e27d8b4fc
// Params 1
// Checksum 0x0, Offset: 0x3d9
// Size: 0x44
function function_625a1bdd25647c6b( loadout )
{
    loadout.loadoutequipmentprimary = scripts\mp\class::table_getequipmentprimary( level.classtablename, 0 );
    loadout.loadoutextraequipmentprimary = scripts\mp\class::table_getflcextraequipmentprimary( level.classtablename, 0 );
    return loadout;
}

// Namespace namespace_cbc0dc8b9328d67d / namespace_89e4915e27d8b4fc
// Params 1
// Checksum 0x0, Offset: 0x426
// Size: 0x44
function function_1ccfa7dccda7da0f( loadout )
{
    loadout.loadoutequipmentsecondary = scripts\mp\class::table_getequipmentsecondary( level.classtablename, 0 );
    loadout.loadoutextraequipmentsecondary = scripts\mp\class::table_getflcextraequipmentsecondary( level.classtablename, 0 );
    return loadout;
}

// Namespace namespace_cbc0dc8b9328d67d / namespace_89e4915e27d8b4fc
// Params 1
// Checksum 0x0, Offset: 0x473
// Size: 0x29
function overridesuper( loadout )
{
    loadout.loadoutfieldupgrade1 = scripts\mp\class::table_getsuper( level.classtablename, 0, 0 );
    return loadout;
}

// Namespace namespace_cbc0dc8b9328d67d / namespace_89e4915e27d8b4fc
// Params 1
// Checksum 0x0, Offset: 0x4a5
// Size: 0x42
function function_2981e0130f5d0598( loadout )
{
    loadout = overrideprimaryweapon( loadout );
    loadout = overridesecondaryweapon( loadout );
    loadout = function_754c5fbcd73cf12d( loadout );
    loadout = function_625a1bdd25647c6b( loadout );
    loadout = function_1ccfa7dccda7da0f( loadout );
    loadout = overridesuper( loadout );
    return loadout;
}

// Namespace namespace_cbc0dc8b9328d67d / namespace_89e4915e27d8b4fc
// Params 1
// Checksum 0x0, Offset: 0x4f0
// Size: 0x9f
function function_ec995ec88ab7fb6c( loadout )
{
    vestperk = "specialty_null";
    
    foreach ( perk in loadout.loadoutperks )
    {
        if ( isdefined( perk ) && isdefined( level.perkbundles[ perk ] ) )
        {
            if ( level.perkbundles[ perk ].var_70774aeb81261100 == "vest" )
            {
                vestperk = perk;
            }
        }
    }
    
    return vestperk;
}

// Namespace namespace_cbc0dc8b9328d67d / namespace_89e4915e27d8b4fc
// Params 2
// Checksum 0x0, Offset: 0x598
// Size: 0x165
function function_8cdbad2a3681247e( perk, vestperk )
{
    returnvalue = 0;
    
    if ( isdefined( perk ) && isdefined( level.perkbundles[ perk ] ) )
    {
        switch ( level.perkbundles[ perk ].var_70774aeb81261100 )
        {
            case #"hash_8cbf71797441f513":
                returnvalue = 1;
                break;
            case #"hash_6fb5d66c124bebf7":
                if ( level.perkbundles[ vestperk ].var_885724e5007453be.gloves == 0 )
                {
                    returnvalue = 0;
                }
                else
                {
                    returnvalue = 1;
                }
                
                break;
            case #"hash_998e90e64af76252":
                if ( level.perkbundles[ vestperk ].var_885724e5007453be.footwear == 0 )
                {
                    returnvalue = 0;
                }
                else
                {
                    returnvalue = 1;
                }
                
                break;
            case #"hash_60a8910f025fc58e":
                if ( level.perkbundles[ vestperk ].var_885724e5007453be.gearone == 0 && level.perkbundles[ vestperk ].var_885724e5007453be.geartwo == 0 )
                {
                    returnvalue = 0;
                }
                else
                {
                    returnvalue = 1;
                }
                
                break;
            default:
                returnvalue = 0;
                break;
        }
    }
    
    assert( returnvalue, "<dev string:x1c>" + perk );
    return returnvalue;
}

