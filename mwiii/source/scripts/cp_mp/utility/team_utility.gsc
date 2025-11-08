#using scripts\common\utility;
#using scripts\engine\utility;

#namespace team_utility;

// Namespace team_utility / scripts\cp_mp\utility\team_utility
// Params 0
// Checksum 0x0, Offset: 0xd8
// Size: 0x28
function function_a92ed2f4c44e5ffa()
{
    if ( issharedfuncdefined( "team_utility", "init" ) )
    {
        [[ getsharedfunc( "team_utility", "init" ) ]]();
    }
}

// Namespace team_utility / scripts\cp_mp\utility\team_utility
// Params 2
// Checksum 0x0, Offset: 0x108
// Size: 0x3c
function getfriendlyplayers( testteam, aliveonly )
{
    if ( issharedfuncdefined( "team_utility", "getFriendlyPlayers" ) )
    {
        return [[ getsharedfunc( "team_utility", "getFriendlyPlayers" ) ]]( testteam, aliveonly );
    }
    
    return [];
}

// Namespace team_utility / scripts\cp_mp\utility\team_utility
// Params 2
// Checksum 0x0, Offset: 0x14d
// Size: 0x3c
function getenemyplayers( testteam, aliveonly )
{
    if ( issharedfuncdefined( "team_utility", "getEnemyPlayers" ) )
    {
        return [[ getsharedfunc( "team_utility", "getEnemyPlayers" ) ]]( testteam, aliveonly );
    }
    
    return [];
}

