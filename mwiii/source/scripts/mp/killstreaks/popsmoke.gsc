#using scripts\common\utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;

#namespace popsmoke;

// Namespace popsmoke / scripts\mp\killstreaks\popsmoke
// Params 1
// Checksum 0x0, Offset: 0xd1
// Size: 0xcf
function function_933806fb8408353d( smoketags )
{
    if ( !isdefined( smoketags ) )
    {
        smoketags = [ "tag_origin" ];
    }
    
    if ( !isarray( smoketags ) )
    {
        smoketags = [ smoketags ];
    }
    
    owner = self.owner;
    
    foreach ( tag in smoketags )
    {
        function_3677f2be30fdd581( tag, "popsmoke" );
        grenade = magicgrenademanual( "popsmoke_grenade_mp", self gettagorigin( tag ), anglestoup( self gettagangles( tag ) ) * 300 );
        grenade.owner = owner;
        wait 0.25;
    }
}

