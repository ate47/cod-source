#using scripts\common\rat;
#using scripts\common\utility;
#using scripts\cp_mp\equipment;
#using scripts\engine\utility;
#using scripts\mp\utility\teams;

#namespace rat_mp;

// Namespace rat_mp / scripts\mp\rat_mp
// Params 0
// Checksum 0x0, Offset: 0x140
// Size: 0x5f
function init()
{
    level.var_6392befa93ae3cc6 = undefined;
    level.var_91ca776f27d516c0 = undefined;
    scripts\common\rat::init();
    scripts\common\rat::ratregisterfunction( "RatGetPlayerTeam", &ratgetplayerteam, "string" );
    scripts\common\rat::ratregisterfunction( "RatGetTeamCount", &ratgetteamcount, "int64_t" );
    scripts\common\rat::ratregisterfunction( "RatGetPlayerEquipment", &ratgetplayerequipment, "string" );
}

// Namespace rat_mp / scripts\mp\rat_mp
// Params 1
// Checksum 0x0, Offset: 0x1a7
// Size: 0x29
function ratgetplayerteam( params )
{
    player = scripts\common\rat::getplayer( params );
    return player.team;
}

// Namespace rat_mp / scripts\mp\rat_mp
// Params 1
// Checksum 0x0, Offset: 0x1d9
// Size: 0x7d
function ratgetteamcount( params )
{
    target_team = default_to( params.team, "player" );
    player_team = ratgetplayerteam( params );
    
    if ( target_team == "player" )
    {
        target_team = player_team;
    }
    
    if ( target_team == "enemy" )
    {
        if ( player_team == "axis" )
        {
            target_team = "allies";
        }
        else
        {
            target_team = "axis";
        }
    }
    
    return getteamdata( target_team, "players" ).size;
}

// Namespace rat_mp / scripts\mp\rat_mp
// Params 1
// Checksum 0x0, Offset: 0x25f
// Size: 0x51
function ratgetplayerequipment( params )
{
    target_slot = default_to( params.slot, "primary" );
    player = scripts\common\rat::getplayer( params );
    equip = player scripts\cp_mp\equipment::getcurrentequipment( target_slot );
    return equip;
}

