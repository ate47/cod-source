#using scripts\common\callbacks;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\utility\game;

#namespace warrior_tdm;

// Namespace warrior_tdm / namespace_ae6eef0c3cb85cbc
// Params 0
// Checksum 0x0, Offset: 0xde
// Size: 0x35
function function_a200bcd0732bbd1c()
{
    callback::add( "player_death", &onplayerdeath );
    level.var_6298f362ec23d83.kills = [];
    thread function_492b4dec632917ec( "warrior_tdm" );
}

// Namespace warrior_tdm / namespace_ae6eef0c3cb85cbc
// Params 0
// Checksum 0x0, Offset: 0x11b
// Size: 0x13
function function_9835e0c3bb7a97ab()
{
    callback::remove( "player_death", &onplayerdeath );
}

// Namespace warrior_tdm / namespace_ae6eef0c3cb85cbc
// Params 3
// Checksum 0x0, Offset: 0x136
// Size: 0x176
function function_baf203025bafcf34( winner, endreasontext, nukedetonated )
{
    maxkills = -1;
    winner = "tie";
    var_45f3630e0bc84a4b = [];
    
    foreach ( team in level.teamnamelist )
    {
        kills = level.var_6298f362ec23d83.kills[ team ];
        
        if ( isdefined( kills ) )
        {
            if ( kills > maxkills && kills != 0 )
            {
                maxkills = kills;
                winner = team;
                var_45f3630e0bc84a4b = [];
                var_45f3630e0bc84a4b = array_add( var_45f3630e0bc84a4b, team );
                continue;
            }
            
            if ( kills == maxkills )
            {
                winner = "tie";
                var_45f3630e0bc84a4b = array_add( var_45f3630e0bc84a4b, team );
            }
        }
    }
    
    setscore = 0;
    
    if ( winner == "tie" && var_45f3630e0bc84a4b.size > 0 )
    {
        foreach ( team in var_45f3630e0bc84a4b )
        {
            scripts\mp\gamescore::giveteamscoreforobjective( team, 1, 1 );
            setscore = 1;
        }
    }
    else if ( winner != "tie" )
    {
        scripts\mp\gamescore::giveteamscoreforobjective( winner, 1, 1 );
        setscore = 1;
    }
    
    return setscore;
}

// Namespace warrior_tdm / namespace_ae6eef0c3cb85cbc
// Params 1
// Checksum 0x0, Offset: 0x2b5
// Size: 0x91
function onplayerdeath( params )
{
    if ( !isdefined( level.var_6298f362ec23d83.kills[ params.attacker.team ] ) )
    {
        level.var_6298f362ec23d83.kills[ params.attacker.team ] = 1;
        return;
    }
    
    level.var_6298f362ec23d83.kills[ params.attacker.team ]++;
}

