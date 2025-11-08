#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace movement;

// Namespace movement / scripts\cp\movement
// Params 2
// Checksum 0x0, Offset: 0x174
// Size: 0xf2
function function_36d589dc5c4191f6( override, delay )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( isdefined( level.var_b11db2283dbd7ed3 ) )
    {
        if ( isdefined( override ) && isstring( override ) )
        {
            self [[ level.var_b11db2283dbd7ed3 ]]( override );
        }
        else
        {
            movement_dvar = getdvarint( @"hash_a6dc81e1fdde75ff", 0 );
            
            switch ( movement_dvar )
            {
                case 1:
                    self [[ level.var_b11db2283dbd7ed3 ]]( "cqb" );
                    break;
                case 2:
                    self [[ level.var_b11db2283dbd7ed3 ]]( "creep" );
                    break;
                default:
                    self [[ level.var_b11db2283dbd7ed3 ]]( "default" );
                    break;
            }
        }
        
        return;
    }
    
    /#
        if ( getdvarint( @"hash_a6dc81e1fdde75ff", 0 ) != 0 )
        {
            iprintln( "<dev string:x1c>" );
        }
    #/
}

// Namespace movement / scripts\cp\movement
// Params 1
// Checksum 0x0, Offset: 0x26e
// Size: 0x10b
function player_movement_state( state )
{
    assertex( isplayer( self ), " self is not a player. Please call this function only on a Player entity. " );
    
    if ( !isdefined( state ) )
    {
        state = "default";
    }
    
    movespeedscaler = 1;
    
    switch ( state )
    {
        case #"hash_a25aba0197cd06fa":
            movespeedscaler = 0.6;
            movespeed = 90;
            break;
        case #"hash_1a53266c17b7d481":
            suit = "iw9_cqb_cp";
            movespeedscaler = 0.8;
            movespeed = 120;
            break;
        case #"hash_7038dec66d8275be":
            suit = "iw9_defaultsuit_cp";
            movespeedscaler = 1;
            movespeed = 150;
            break;
        default:
            assertmsg( "movement state <" + state + "> is not a valid type.  please use <creep> <cqb> or <default>" );
            suit = "iw9_defaultsuit_cp";
            movespeedscaler = 1;
            movespeed = 150;
            break;
    }
    
    self.movementstate = state;
    self.movespeedscaler = movespeedscaler;
    self [[ level.move_speed_scale ]]();
    player_speed_set( movespeed, 0.5 );
}

// Namespace movement / scripts\cp\movement
// Params 2
// Checksum 0x0, Offset: 0x381
// Size: 0x72
function player_speed_percent( percent, time )
{
    currspeed = int( getdvar( @"g_speed" ) );
    
    if ( !isdefined( self.g_speed ) )
    {
        self.g_speed = currspeed;
    }
    
    goalspeed = int( self.g_speed * percent * 0.01 );
    player_speed_set( goalspeed, time );
}

// Namespace movement / scripts\cp\movement
// Params 2
// Checksum 0x0, Offset: 0x3fb
// Size: 0x92
function player_speed_set( speed, time )
{
    currspeed = int( getdvar( @"g_speed" ) );
    
    if ( !isdefined( self.g_speed ) )
    {
        self.g_speed = currspeed;
    }
    
    get_func = &movespeed_get_func;
    set_func = &movespeed_set_func;
    
    if ( !isdefined( speed ) )
    {
        speed = 150;
    }
    
    scale = speed / 190;
    thread player_speed_proc( scale, time, get_func, set_func, "blend_movespeedscale", undefined );
}

// Namespace movement / scripts\cp\movement
// Params 2
// Checksum 0x0, Offset: 0x495
// Size: 0x44
function player_bob_scale_set( scale, time )
{
    get_func = &g_bob_scale_get_func;
    set_func = &g_bob_scale_set_func;
    thread player_speed_proc( scale, time, get_func, set_func, "player_bob_scale_set" );
}

// Namespace movement / scripts\cp\movement
// Params 3
// Checksum 0x0, Offset: 0x4e1
// Size: 0x86
function blend_movespeedscale( scale, time, channel )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        player = self;
    }
    
    if ( !isdefined( player.movespeedscale ) )
    {
        player.movespeedscale = 1;
    }
    
    get_func = &movespeed_get_func;
    set_func = &movespeed_set_func;
    player thread player_speed_proc( scale, time, get_func, set_func, "blend_movespeedscale", channel );
}

// Namespace movement / scripts\cp\movement
// Params 3
// Checksum 0x0, Offset: 0x56f
// Size: 0x70
function blend_movespeedscale_percent( percent, time, channel )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        player = self;
    }
    
    if ( !isdefined( player.movespeedscale ) )
    {
        player.movespeedscale = 1;
    }
    
    goalscale = percent * 0.01;
    player blend_movespeedscale( goalscale, time, channel );
}

// Namespace movement / scripts\cp\movement
// Params 6
// Checksum 0x0, Offset: 0x5e7
// Size: 0xd5
function player_speed_proc( speed, time, get_func, set_func, ender, channel )
{
    self notify( ender );
    self endon( ender );
    currspeed = [[ get_func ]]( channel );
    goalspeed = speed;
    
    if ( isdefined( time ) && time > 0 )
    {
        range = goalspeed - currspeed;
        interval = 0.05;
        numcycles = time / interval;
        fraction = range / numcycles;
        
        while ( abs( goalspeed - currspeed ) > abs( fraction * 1.1 ) )
        {
            currspeed += fraction;
            [[ set_func ]]( currspeed, channel );
            wait interval;
        }
    }
    
    [[ set_func ]]( goalspeed, channel );
}

// Namespace movement / scripts\cp\movement
// Params 1
// Checksum 0x0, Offset: 0x6c4
// Size: 0x35
function player_speed_default( time )
{
    if ( !isdefined( self.g_speed ) )
    {
        return;
    }
    
    player_speed_set( self.g_speed, time );
    waittillframeend();
    self.g_speed = undefined;
}

// Namespace movement / scripts\cp\movement
// Params 2
// Checksum 0x0, Offset: 0x701
// Size: 0x55
function blend_movespeedscale_default( time, channel )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        player = self;
    }
    
    if ( !isdefined( player.movespeedscale ) )
    {
        return;
    }
    
    player blend_movespeedscale( 1, time, channel );
    player.movespeedscale = undefined;
}

// Namespace movement / scripts\cp\movement
// Params 1
// Checksum 0x0, Offset: 0x75e
// Size: 0x1e
function g_speed_get_func( null )
{
    return int( getdvar( @"g_speed" ) );
}

// Namespace movement / scripts\cp\movement
// Params 2
// Checksum 0x0, Offset: 0x785
// Size: 0x28
function g_speed_set_func( goalspeed, null )
{
    setdvar( @"g_speed", int( goalspeed ) );
}

// Namespace movement / scripts\cp\movement
// Params 1
// Checksum 0x0, Offset: 0x7b5
// Size: 0xb
function g_bob_scale_get_func( null )
{
    
}

// Namespace movement / scripts\cp\movement
// Params 2
// Checksum 0x0, Offset: 0x7c8
// Size: 0x13
function g_bob_scale_set_func( goalscale, null )
{
    
}

// Namespace movement / scripts\cp\movement
// Params 1
// Checksum 0x0, Offset: 0x7e3
// Size: 0x43
function movespeed_get_func( channel )
{
    if ( !isdefined( channel ) )
    {
        channel = "default";
    }
    
    if ( !isdefined( self.movespeedscales ) || !isdefined( self.movespeedscales[ channel ] ) )
    {
        return 1;
    }
    
    return self.movespeedscales[ channel ];
}

// Namespace movement / scripts\cp\movement
// Params 2
// Checksum 0x0, Offset: 0x82f
// Size: 0xbb
function movespeed_set_func( scale, channel )
{
    finalscale = 1;
    
    if ( !isdefined( channel ) )
    {
        channel = "default";
    }
    
    self.movespeedscales[ channel ] = scale;
    
    foreach ( scale in self.movespeedscales )
    {
        if ( scale == 1 )
        {
            self.movespeedscales = array_remove_key( self.movespeedscales, key );
        }
        
        finalscale *= scale;
    }
    
    self.movespeedscale = finalscale;
    self setmovespeedscale( self.movespeedscale );
}

