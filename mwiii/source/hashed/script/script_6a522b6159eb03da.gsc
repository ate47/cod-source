#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\utility\teams;

#namespace namespace_8c8677d2a078818d;

// Namespace namespace_8c8677d2a078818d / namespace_f77f8b2f20f85e34
// Params 0
// Checksum 0x0, Offset: 0xe1
// Size: 0x23
function init()
{
    if ( !getdvarint( @"hash_58f1cc219ff0d6c0", 0 ) )
    {
        return;
    }
    
    level.endgame = &function_e8ab535c260b2949;
}

// Namespace namespace_8c8677d2a078818d / namespace_f77f8b2f20f85e34
// Params 3
// Checksum 0x0, Offset: 0x10c
// Size: 0xca
function function_e8ab535c260b2949( winner, endreasontext, nukedetonated )
{
    if ( isdefined( level.var_e8ab535c260b2949 ) )
    {
        return;
    }
    
    level.var_e8ab535c260b2949 = 1;
    
    if ( winner != "tie" )
    {
        if ( isgameplayteam( winner ) )
        {
            topplayers = array_sort_with_func( getteamdata( winner, "players" ), &compare_player_score );
        }
        else
        {
            topplayers = level.placement[ "all" ];
        }
        
        function_9049bca68f1f0984( topplayers );
    }
    
    /#
        if ( !level.onlinegame && winner == "<dev string:x1c>" )
        {
            topplayers = [ level.player ];
            function_9049bca68f1f0984( topplayers );
        }
    #/
    
    wait 5;
    level thread scripts\mp\gamelogic::endgame_regularmp( winner, endreasontext, undefined, nukedetonated );
}

// Namespace namespace_8c8677d2a078818d / namespace_f77f8b2f20f85e34
// Params 1
// Checksum 0x0, Offset: 0x1de
// Size: 0xc7
function function_9049bca68f1f0984( topplayers )
{
    foreach ( player in topplayers )
    {
        hud = newclienthudelem( player );
        hud.alignx = "center";
        hud.foreground = 1;
        hud.fontscale = 3;
        hud.alpha = 1;
        hud.x = 320;
        hud.y = 300;
        hud settext( &"JUP_MP/PLAYER_WAGER_WINNER" );
    }
}

