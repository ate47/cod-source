#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\pack_a_punch;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;

#namespace weaponmetadata;

// Namespace weaponmetadata / scripts\cp_mp\weaponmetadata
// Params 0
// Checksum 0x0, Offset: 0x1bd
// Size: 0x4d4
function function_5108bb8dbe090131()
{
    var_24a27db3db646d0f = level.gamemodebundle.var_c38f402fed776720;
    
    if ( !isdefined( var_24a27db3db646d0f ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    s_bundle = getscriptbundle( "weaponmetadata:" + var_24a27db3db646d0f );
    level.weaponmetadata = [];
    level.weaponmetadata[ "rarity_settings" ] = spawnstruct();
    level.weaponmetadata[ "pap_settings" ] = spawnstruct();
    level.weaponmetadata[ "magicbox_settings" ] = spawnstruct();
    level.weaponmetadata[ "wallbuy_settings" ] = spawnstruct();
    level.weaponmetadata[ "rarity_settings" ].var_64962e0b6ed91567 = s_bundle.var_64962e0b6ed91567;
    level.weaponmetadata[ "rarity_settings" ].var_3fc24ec0bc2de11d = s_bundle.var_3fc24ec0bc2de11d;
    level.weaponmetadata[ "rarity_settings" ].var_52dff081b694390 = s_bundle.var_52dff081b694390;
    level.weaponmetadata[ "rarity_settings" ].var_2f4f5451344c144a = s_bundle.var_2f4f5451344c144a;
    level.weaponmetadata[ "rarity_settings" ].var_827b0c41035f0386 = s_bundle.var_827b0c41035f0386;
    level.weaponmetadata[ "rarity_settings" ].var_827b0c41035f0386 = s_bundle.var_827b0c41035f0386;
    level.weaponmetadata[ "pap_settings" ].var_e007ac5715f424ab = s_bundle.var_e007ac5715f424ab;
    level.weaponmetadata[ "pap_settings" ].var_ac1ba74bafe62262 = s_bundle.var_ac1ba74bafe62262;
    level.weaponmetadata[ "pap_settings" ].var_a887a8da61532b15 = s_bundle.var_a887a8da61532b15;
    level.weaponmetadata[ "magicbox_settings" ].weaponitemspawnlist = s_bundle.var_9230e85c0b586bc1;
    level.weaponmetadata[ "magicbox_settings" ].scorestreakitemspawnlist = s_bundle.var_92e3f80b8009f89f;
    level.weaponmetadata[ "magicbox_settings" ].wonderweaponitemspawnlist = s_bundle.var_3b8ef64a96947290;
    level.weaponmetadata[ "wallbuy_settings" ].var_2e57b9b53a463b3b = s_bundle.var_2e57b9b53a463b3b;
    
    if ( isdefined( s_bundle.var_13d48225bc483f59 ) )
    {
        var_2de54af70b9cbe75 = getscriptbundle( "currency:" + s_bundle.var_13d48225bc483f59 );
        level.weaponmetadata[ "wallbuy_settings" ].var_13d48225bc483f59 = var_2de54af70b9cbe75.currencyname;
    }
    
    foreach ( s_weapon in s_bundle.weaponslist )
    {
        assertex( isdefined( s_weapon.weapon ), "<dev string:x45>" + var_24a27db3db646d0f );
        weapon = makeweapon( s_weapon.weapon );
        str_weapon_name = weapon.var_9d7facbe889e667c;
        
        if ( !isdefined( str_weapon_name ) || str_weapon_name == "" || str_weapon_name == %"none" )
        {
            str_weapon_name = s_weapon.weapon;
        }
        
        level.weaponmetadata[ str_weapon_name ] = s_weapon;
    }
    
    level.var_7843c346baff928f[ "none" ] = 0;
    level.var_7843c346baff928f[ "fire" ] = 1;
    level.var_7843c346baff928f[ "cold" ] = 2;
    level.var_7843c346baff928f[ "toxic" ] = 3;
    level.var_7843c346baff928f[ "electrical" ] = 4;
    level.var_7843c346baff928f[ "dark" ] = 5;
    level.var_7843c346baff928f[ "light" ] = 6;
    level.var_294d0b1503a8ccb9[ "fire" ] = "hitelementfire";
    level.var_294d0b1503a8ccb9[ "cold" ] = "hitelementcold";
    level.var_294d0b1503a8ccb9[ "toxic" ] = "hitelementtoxic";
    level.var_294d0b1503a8ccb9[ "electrical" ] = "hitelementelectrical";
    level.var_294d0b1503a8ccb9[ "dark" ] = "hitelementfire";
    level.var_294d0b1503a8ccb9[ "light" ] = "hitelementfire";
    level.var_fa6563c6f00a1ef1 = &function_4c8abc7b4eff6212;
    
    if ( isdefined( level.var_9ce53104c2f3221b ) )
    {
        [[ level.var_9ce53104c2f3221b ]]();
    }
}

// Namespace weaponmetadata / scripts\cp_mp\weaponmetadata
// Params 1
// Checksum 0x0, Offset: 0x699
// Size: 0x12b
function function_e52c71c96d93174b( n_level )
{
    currentweapon = self getcurrentweapon();
    camo = getweaponcamoname( currentweapon );
    reticle = getweaponreticlename( currentweapon );
    variantid = getweaponvariantindex( currentweapon );
    w_take = currentweapon;
    stickers = [ currentweapon.stickerslot0, currentweapon.stickerslot1, currentweapon.stickerslot2, currentweapon.stickerslot3, currentweapon.var_b39ac546cc8621f8 ];
    currentattachments = currentweapon.attachments;
    currentattachmentids = currentweapon.attachmentvarindices;
    w_new = scripts\cp_mp\weapon::buildweapon( currentweapon.basename, currentattachments, camo, reticle, variantid, currentattachmentids, undefined, stickers );
    self takeweapon( w_take );
    self giveweapon( w_new );
    self switchtoweapon( w_new );
    self givemaxammo( w_new );
    scripts\cp_mp\pack_a_punch::set_pap_level( currentweapon, n_level );
}

// Namespace weaponmetadata / scripts\cp_mp\weaponmetadata
// Params 1
// Checksum 0x0, Offset: 0x7cc
// Size: 0x4e, Type: bool
function function_4c8abc7b4eff6212( weapon )
{
    var_88260bb1ed608124 = weapon.var_9d7facbe889e667c;
    
    if ( isdefined( level.weaponmetadata[ var_88260bb1ed608124 ] ) )
    {
        if ( istrue( level.weaponmetadata[ var_88260bb1ed608124 ].var_2ae3eb7748601877 ) )
        {
            return true;
        }
    }
    
    return false;
}

