#using scripts\common\utility;
#using scripts\engine\utility;

#namespace player_utility_cp;

// Namespace player_utility_cp / scripts\cp\utility\player_utility_cp
// Params 0
// Checksum 0x0, Offset: 0x78
// Size: 0x17
function _isalive()
{
    if ( istrue( self.inlaststand ) )
    {
        return 0;
    }
    
    return isalive( self );
}

