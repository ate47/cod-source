#using scripts\mp\utility\stats;

#namespace team_gun;

// Namespace team_gun / scripts\mp\gametypes\team_gun
// Params 0
// Checksum 0x0, Offset: 0xab
// Size: 0x1b, Type: bool
function function_c1cddd7ae3bc2698()
{
    return getdvar( @"ui_gametype", "gun" ) == "team_gun";
}

// Namespace team_gun / scripts\mp\gametypes\team_gun
// Params 0
// Checksum 0x0, Offset: 0xcf
// Size: 0x90
function function_aa7d3b7589a7323e()
{
    player = self;
    
    if ( isbot( player ) )
    {
        team = player.bot_team;
    }
    else
    {
        team = player.pers[ "team" ];
    }
    
    player.gungamegunindex = function_1b6cc03649ea5017( team );
    
    if ( player.gungamegunindex == 0 )
    {
        player.gungameprevgunindex = 0;
        return;
    }
    
    player.gungameprevgunindex = player.gungamegunindex - 1;
}

// Namespace team_gun / scripts\mp\gametypes\team_gun
// Params 1
// Checksum 0x0, Offset: 0x167
// Size: 0x36
function function_1b6cc03649ea5017( team )
{
    if ( !isdefined( level.var_b0ad9e7ef6c53ce7 ) || !isdefined( level.var_b0ad9e7ef6c53ce7[ team ] ) )
    {
        return 0;
    }
    
    return level.var_b0ad9e7ef6c53ce7[ team ];
}

