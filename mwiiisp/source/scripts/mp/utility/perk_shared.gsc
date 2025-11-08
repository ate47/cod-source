#namespace perk_shared;

// Namespace perk_shared / scripts\mp\utility\perk_shared
// Params 1
// Checksum 0x0, Offset: 0x68
// Size: 0x2b, Type: bool
function function_56ad1b98a0613f8a( perkname )
{
    return isdefined( perkname ) && isdefined( self.perks ) && isdefined( self.perks[ perkname ] );
}

