#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\weapon;

#namespace cp_weapon;

// Namespace cp_weapon / scripts\cp\cp_weapon
// Params 9
// Checksum 0x0, Offset: 0x85
// Size: 0x69
function function_e83615f8a92e4378( rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg )
{
    if ( function_2b7981cbc7ca24b4( rootname ) )
    {
        return;
    }
    
    return buildweapon( rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg );
}

// Namespace cp_weapon / scripts\cp\cp_weapon
// Params 1
// Checksum 0x0, Offset: 0xf7
// Size: 0x4b, Type: bool
function function_2b7981cbc7ca24b4( weapon_str )
{
    if ( getdvarint( @"hash_216da3534a88c00", 0 ) )
    {
        return false;
    }
    
    if ( getsubstr( weapon_str, 0, 4 ) == "iw8_" )
    {
        println( "<dev string:x1c>" + weapon_str + "<dev string:x9c>" );
        return true;
    }
    
    return false;
}

// Namespace cp_weapon / scripts\cp\cp_weapon
// Params 1
// Checksum 0x0, Offset: 0x14b
// Size: 0x12
function get_weapon_level( weapon )
{
    return scripts\cp\weapon::get_weapon_level( weapon );
}

// Namespace cp_weapon / scripts\cp\cp_weapon
// Params 1
// Checksum 0x0, Offset: 0x166
// Size: 0x12
function has_weapon_variation( weapon )
{
    return scripts\cp\weapon::has_weapon_variation( weapon );
}

