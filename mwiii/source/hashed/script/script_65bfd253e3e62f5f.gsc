#using scripts\asm\asm;
#using scripts\asm\cap;
#using scripts\asm\shared\utility;
#using scripts\engine\utility;

#namespace cap_hostage;

// Namespace cap_hostage / namespace_802d7efa63123271
// Params 3
// Checksum 0x0, Offset: 0xfd
// Size: 0x5b
function initcap( asmname, statename, params )
{
    self animmode( "noclip" );
    self orientmode( "face current" );
    origin = self.origin;
    angles = self.angles;
}

// Namespace cap_hostage / namespace_802d7efa63123271
// Params 3
// Checksum 0x0, Offset: 0x160
// Size: 0x93
function function_f3967267145e123( asmname, statename, params )
{
    archetype = self.animsetname;
    aliases = archetypegetaliases( archetype, statename );
    alias = undefined;
    
    if ( statename == "hostage_pickup" )
    {
        alias = "hostage_pickup_" + self.animdir + "_" + self.animstance;
    }
    else
    {
        alias = "hostage_drop_" + self.animstance;
    }
    
    return scripts\asm\cap::function_658df657ca37f542( statename, alias );
}

