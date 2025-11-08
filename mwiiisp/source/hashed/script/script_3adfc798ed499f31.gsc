#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace namespace_7614526e7b6becd8;

// Namespace namespace_7614526e7b6becd8 / namespace_88f49e01608e39bf
// Params 0
// Checksum 0x0, Offset: 0x138
// Size: 0x1a
function function_9a3c64059e71fa7b()
{
    cmd = "devgui_cmd \"CP Debug:2 / Covernode Screenshots\" \"set scr_start_debug screenshot\" \n";
    addentrytodevgui( cmd );
}

// Namespace namespace_7614526e7b6becd8 / namespace_88f49e01608e39bf
// Params 0
// Checksum 0x0, Offset: 0x15a
// Size: 0xa0
function function_bb0ca5b4f194444a()
{
    level endon( "game_ended" );
    
    if ( flag( "level_ready_for_script" ) )
    {
        wait 1;
        nodes = getallnodes();
        
        for ( i = 0; i < nodes.size ; i++ )
        {
            if ( isdefined( nodes[ i ].type ) && function_64aa73047772b50( nodes[ i ].type ) )
            {
                /#
                    print( i + "<dev string:x1c>" + nodes[ i ].origin + "<dev string:x1e>" );
                #/
                
                move_player_to_node( nodes[ i ] );
                take_screenshot_of_node();
            }
        }
    }
}

// Namespace namespace_7614526e7b6becd8 / namespace_88f49e01608e39bf
// Params 1
// Checksum 0x0, Offset: 0x202
// Size: 0x55
function function_64aa73047772b50( type )
{
    switch ( type )
    {
        case #"hash_cf178f370da8b13":
        case #"hash_10ddde5a9b4990be":
        case #"hash_dbfab46c7d6e4fea":
        case #"hash_fd7cd04a31eca976":
            return 0;
        default:
            return 1;
    }
}

// Namespace namespace_7614526e7b6becd8 / namespace_88f49e01608e39bf
// Params 1
// Checksum 0x0, Offset: 0x25f
// Size: 0xa3
function move_player_to_node( node )
{
    level endon( "game_ended" );
    level notify( "move_player_to_node" );
    level endon( "move_player_to_node" );
    backward = -1 * anglestoforward( node.angles ) * 64;
    level.players[ 0 ] dontinterpolate();
    level.players[ 0 ] setorigin( node.origin + backward, 1 );
    level.players[ 0 ] setplayerangles( node.angles );
    wait getdvarfloat( @"hash_f6b46e472c59d40c", 0.2 );
}

// Namespace namespace_7614526e7b6becd8 / namespace_88f49e01608e39bf
// Params 0
// Checksum 0x0, Offset: 0x30a
// Size: 0x26
function take_screenshot_of_node()
{
    level endon( "game_ended" );
    level notify( "take_screenshot_of_node" );
    level endon( "take_screenshot_of_node" );
    
    /#
        adddebugcommand( "<dev string:x20>" );
    #/
}

