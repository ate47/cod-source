#using scripts\cp\utility;

#namespace namespace_5d586b5c0318efbd;

// Namespace namespace_5d586b5c0318efbd / namespace_510f48b89ec0a7d
// Params 0
// Checksum 0x0, Offset: 0x89
// Size: 0x15
function init()
{
    level.var_b20ff0025288ef0b = [];
    level thread runupdates();
}

// Namespace namespace_5d586b5c0318efbd / namespace_510f48b89ec0a7d
// Params 0
// Checksum 0x0, Offset: 0xa6
// Size: 0x7b
function runupdates()
{
    level endon( "game_ended" );
    scripts\cp\utility::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            for ( j = 0; j < level.var_b20ff0025288ef0b.size ; j++ )
            {
                level.players[ i ] [[ level.var_b20ff0025288ef0b[ j ] ]]();
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_5d586b5c0318efbd / namespace_510f48b89ec0a7d
// Params 1
// Checksum 0x0, Offset: 0x129
// Size: 0x21
function function_3ae366ec2732af83( callback )
{
    level.var_b20ff0025288ef0b[ level.var_b20ff0025288ef0b.size ] = callback;
}

