#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace cp_visionsets;

// Namespace cp_visionsets / scripts\cp\cp_visionsets
// Params 0
// Checksum 0x0, Offset: 0x1b1
// Size: 0x211
function vision_set_management()
{
    var_c77ce6671d293276 = undefined;
    player = undefined;
    
    while ( true )
    {
        level waittill( "vision_set_change_request", var_c77ce6671d293276, player, transition_time, var_ce7cd55e867a0f21 );
        
        if ( !isdefined( var_c77ce6671d293276 ) && isdefined( var_ce7cd55e867a0f21 ) )
        {
            assertex( isstring( var_ce7cd55e867a0f21 ), "the Vision set string param should always be of string datatype" );
            
            if ( !isstring( var_ce7cd55e867a0f21 ) )
            {
                continue;
            }
            
            assertex( var_ce7cd55e867a0f21 != "", "the Vision set string to be removed should be a specific value and not closed quotes (Basic Vision Set)" );
            
            if ( var_ce7cd55e867a0f21 == "" )
            {
                continue;
            }
            
            if ( isdefined( player ) )
            {
                assertex( isplayer( player ), "the Player param should always be of Player datatype" );
                
                if ( !isplayer( player ) )
                {
                    continue;
                }
                
                remove_visionset_specific_from_stack( player, var_ce7cd55e867a0f21, transition_time );
            }
            else
            {
                foreach ( guy in level.players )
                {
                    remove_visionset_specific_from_stack( guy, var_ce7cd55e867a0f21, transition_time );
                }
            }
            
            continue;
        }
        
        assertex( isdefined( var_c77ce6671d293276 ), "Please pass a Vision set string with your notify" );
        assertex( isstring( var_c77ce6671d293276 ), "the Vision set string param should always be of string datatype" );
        
        if ( !isdefined( var_c77ce6671d293276 ) || !isstring( var_c77ce6671d293276 ) )
        {
            continue;
        }
        
        if ( isdefined( player ) )
        {
            assertex( isplayer( player ), "the Player param should always be of Player datatype" );
            
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            if ( var_c77ce6671d293276 == "" )
            {
                remove_visionset_from_stack( player, transition_time );
            }
            else
            {
                add_visionset_to_stack( player, var_c77ce6671d293276, transition_time );
            }
            
            continue;
        }
        
        foreach ( guy in level.players )
        {
            if ( var_c77ce6671d293276 == "" )
            {
                remove_visionset_from_stack( guy, transition_time );
                continue;
            }
            
            add_visionset_to_stack( guy, var_c77ce6671d293276, transition_time );
        }
    }
}

// Namespace cp_visionsets / scripts\cp\cp_visionsets
// Params 1
// Checksum 0x0, Offset: 0x3ca
// Size: 0x72
function create_visionset_stack( player )
{
    player.visionset_stack = [ "" ];
    player.visionset_pointer = player.visionset_stack.size - 1;
    player.current_visionset = player.visionset_stack[ player.visionset_pointer ];
    player visionsetnakedforplayer( player.current_visionset, 0 );
}

// Namespace cp_visionsets / scripts\cp\cp_visionsets
// Params 3
// Checksum 0x0, Offset: 0x444
// Size: 0xc7
function add_visionset_to_stack( player, visionset, transition_time )
{
    player.old_visionset = player.visionset_stack[ player.visionset_pointer ];
    player.visionset_stack = array_add( player.visionset_stack, visionset );
    player.visionset_pointer = player.visionset_stack.size - 1;
    player.current_visionset = player.visionset_stack[ player.visionset_pointer ];
    
    if ( isdefined( transition_time ) )
    {
        player visionsetnakedforplayer( player.current_visionset, transition_time );
        return;
    }
    
    player visionsetnakedforplayer( player.current_visionset );
}

// Namespace cp_visionsets / scripts\cp\cp_visionsets
// Params 2
// Checksum 0x0, Offset: 0x513
// Size: 0xcd
function remove_visionset_from_stack( player, transition_time )
{
    if ( player.visionset_pointer <= 0 )
    {
    }
    else
    {
        player.old_visionset = player.visionset_stack[ player.visionset_pointer ];
        player.visionset_stack = array_remove_index( player.visionset_stack, player.visionset_pointer );
        player.visionset_pointer--;
        player.current_visionset = player.visionset_stack[ player.visionset_pointer ];
    }
    
    if ( isdefined( transition_time ) )
    {
        player visionsetnakedforplayer( player.current_visionset, transition_time );
        return;
    }
    
    player visionsetnakedforplayer( player.current_visionset );
}

// Namespace cp_visionsets / scripts\cp\cp_visionsets
// Params 3
// Checksum 0x0, Offset: 0x5e8
// Size: 0xb4
function remove_visionset_specific_from_stack( player, visionset, transition_time )
{
    if ( player.visionset_pointer > 0 )
    {
        player.visionset_stack = array_remove( player.visionset_stack, visionset );
        player.visionset_pointer--;
        player.current_visionset = player.visionset_stack[ player.visionset_pointer ];
    }
    
    if ( isdefined( player.current_visionset ) )
    {
        if ( isdefined( transition_time ) )
        {
            player visionsetnakedforplayer( player.current_visionset, transition_time );
            return;
        }
        
        player visionsetnakedforplayer( player.current_visionset );
    }
}

