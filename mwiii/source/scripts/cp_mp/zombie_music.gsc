#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\music_and_dialog;

#namespace zombie_music;

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 0
// Checksum 0x0, Offset: 0x165
// Size: 0x2b
function function_4b77a1615a8dd64a()
{
    level thread scripts\mp\music_and_dialog::disablemusic();
    game[ "zombiemusic_bank" ] = undefined;
    game[ "zombiemusic_bank_default" ] = undefined;
    level callback::add( "player_connect", &on_playerconnect );
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0x198
// Size: 0x12
function on_playerconnect( sparams )
{
    function_5fd4ac422c2433ab();
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 0
// Checksum 0x0, Offset: 0x1b2
// Size: 0x98
function function_5fd4ac422c2433ab()
{
    if ( !isdefined( self.var_3fb2c165c0c044b8 ) )
    {
        self.var_3fb2c165c0c044b8 = spawnstruct();
        self.var_3fb2c165c0c044b8.var_4b6a0e0f9520fa47 = 1;
        self.var_3fb2c165c0c044b8.active_bank = undefined;
        self.var_3fb2c165c0c044b8.state_current = undefined;
        self.var_3fb2c165c0c044b8.state_prev = undefined;
        self.var_3fb2c165c0c044b8.priority_current = 1;
        self.var_3fb2c165c0c044b8.priority_prev = 1;
    }
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0x252
// Size: 0x61
function function_8888f70dbecaeda1( var_d7c75c93c4ca506 )
{
    foreach ( player in level.players )
    {
        player thread function_8ae818ed183a1753( var_d7c75c93c4ca506 );
    }
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0x2bb
// Size: 0x109
function function_8ae818ed183a1753( var_d7c75c93c4ca506 )
{
    function_8b1835eeb80e8efc( self );
    
    if ( function_17f2893c6d199180( self, var_d7c75c93c4ca506 ) )
    {
        return;
    }
    
    self notify( "zombieMusicStateUpdate" );
    var_8af73af26533d0ac = game[ "zombiemusic_bank" ][ self.var_3fb2c165c0c044b8.active_bank ][ var_d7c75c93c4ca506 ];
    
    if ( isdefined( self.var_3fb2c165c0c044b8.state_current ) )
    {
        self.var_3fb2c165c0c044b8.state_prev = self.var_3fb2c165c0c044b8.state_current;
    }
    
    self.var_3fb2c165c0c044b8.state_current = var_d7c75c93c4ca506;
    self.var_3fb2c165c0c044b8.priority_current = var_8af73af26533d0ac.n_priority;
    var_e13d86eabf5ff75d = var_8af73af26533d0ac.array_musicstates[ randomintrange( 0, var_8af73af26533d0ac.array_musicstates.size ) ];
    self setplayermusicstate( var_e13d86eabf5ff75d );
    
    if ( !var_8af73af26533d0ac.var_aaa744342068977a )
    {
        thread function_b88aec4b0b3b3614( var_e13d86eabf5ff75d );
    }
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 2
// Checksum 0x0, Offset: 0x3cc
// Size: 0x168, Type: bool
function function_17f2893c6d199180( player, var_d7c75c93c4ca506 )
{
    if ( !function_cda1c2ac4fa2e2da( player ) )
    {
        return true;
    }
    
    if ( !isdefined( game[ "zombiemusic_bank" ] ) || !isdefined( player.var_3fb2c165c0c044b8.active_bank ) )
    {
        return true;
    }
    
    if ( !isdefined( game[ "zombiemusic_bank" ][ player.var_3fb2c165c0c044b8.active_bank ] ) )
    {
        return true;
    }
    
    if ( !isdefined( game[ "zombiemusic_bank" ][ player.var_3fb2c165c0c044b8.active_bank ][ var_d7c75c93c4ca506 ] ) )
    {
        return true;
    }
    
    var_8af73af26533d0ac = game[ "zombiemusic_bank" ][ player.var_3fb2c165c0c044b8.active_bank ][ var_d7c75c93c4ca506 ];
    
    if ( var_8af73af26533d0ac.array_musicstates.size <= 0 )
    {
        return true;
    }
    
    if ( !isdefined( player.var_3fb2c165c0c044b8 ) )
    {
        return true;
    }
    
    var_225923bb7dfc33dd = player.var_3fb2c165c0c044b8;
    
    if ( isdefined( player.var_3fb2c165c0c044b8.state_current ) )
    {
        if ( player.var_3fb2c165c0c044b8.priority_current > var_8af73af26533d0ac.n_priority && var_8af73af26533d0ac.n_priority != 0 )
        {
            return true;
        }
        
        if ( player.var_3fb2c165c0c044b8.state_current == var_d7c75c93c4ca506 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0x53d
// Size: 0x48
function function_b88aec4b0b3b3614( var_e13d86eabf5ff75d )
{
    self endon( "zombieMusicStateUpdate" );
    self endon( "zombieMusicStateClear" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    n_wait_time = function_30429ea66e99f476( var_e13d86eabf5ff75d );
    wait n_wait_time;
    
    if ( isdefined( self ) )
    {
        function_9450c133a155c196();
    }
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0x58d
// Size: 0x61
function function_9e6da63353ea9512( var_d7c75c93c4ca506 )
{
    foreach ( player in level.players )
    {
        player thread function_9450c133a155c196( var_d7c75c93c4ca506 );
    }
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0x5f6
// Size: 0x16b
function function_9450c133a155c196( var_d7c75c93c4ca506 )
{
    if ( !function_cda1c2ac4fa2e2da( self ) )
    {
        return;
    }
    
    if ( isdefined( var_d7c75c93c4ca506 ) )
    {
        if ( isdefined( self.var_3fb2c165c0c044b8.state_current ) )
        {
            if ( self.var_3fb2c165c0c044b8.state_current == var_d7c75c93c4ca506 )
            {
                self notify( "zombieMusicStateClear" );
                self setplayermusicstate( "" );
                self.var_3fb2c165c0c044b8.state_prev = self.var_3fb2c165c0c044b8.state_current;
                self.var_3fb2c165c0c044b8.priority_prev = self.var_3fb2c165c0c044b8.priority_current;
                self.var_3fb2c165c0c044b8.state_current = undefined;
                self.var_3fb2c165c0c044b8.priority_current = 1;
            }
            else
            {
                return;
            }
        }
        else
        {
            return;
        }
        
        return;
    }
    
    self notify( "zombieMusicStateClear" );
    self setplayermusicstate( "" );
    self.var_3fb2c165c0c044b8.state_prev = self.var_3fb2c165c0c044b8.state_current;
    self.var_3fb2c165c0c044b8.priority_prev = self.var_3fb2c165c0c044b8.priority_current;
    self.var_3fb2c165c0c044b8.state_current = undefined;
    self.var_3fb2c165c0c044b8.priority_current = 1;
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0x769
// Size: 0x4b
function function_30429ea66e99f476( str_statename )
{
    str_alias = "mus_" + str_statename + "_intro";
    duration_ms = lookupsoundlength( str_alias );
    
    if ( !isdefined( duration_ms ) || duration_ms <= 0 )
    {
        duration_ms = 1000;
    }
    
    return duration_ms / 1000;
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 0
// Checksum 0x0, Offset: 0x7bd
// Size: 0x58
function function_43956cb0410eec0f()
{
    foreach ( player in level.players )
    {
        level thread function_f95cf184582d2009( player );
    }
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0x81d
// Size: 0x39
function function_f95cf184582d2009( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_3fb2c165c0c044b8 ) )
    {
        return;
    }
    
    player.var_3fb2c165c0c044b8.var_4b6a0e0f9520fa47 = 1;
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 0
// Checksum 0x0, Offset: 0x85e
// Size: 0x5f
function function_94636ebe77d7581a()
{
    function_9e6da63353ea9512();
    
    foreach ( player in level.players )
    {
        level thread function_665863ce16735aae( player );
    }
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0x8c5
// Size: 0x38
function function_665863ce16735aae( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_3fb2c165c0c044b8 ) )
    {
        return;
    }
    
    player.var_3fb2c165c0c044b8.var_4b6a0e0f9520fa47 = 0;
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0x905
// Size: 0x38
function function_cda1c2ac4fa2e2da( player )
{
    if ( !isdefined( player ) )
    {
        return 0;
    }
    
    if ( !isdefined( player.var_3fb2c165c0c044b8 ) )
    {
        return 0;
    }
    
    return player.var_3fb2c165c0c044b8.var_4b6a0e0f9520fa47;
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0x946
// Size: 0x2e
function function_d7f0cecf71088d68( var_60e81aa6c9b5d1cf )
{
    assertex( !isdefined( level.var_4beddfdc7466d52a ), "<dev string:x1c>" );
    level.var_4beddfdc7466d52a = var_60e81aa6c9b5d1cf;
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 0
// Checksum 0x0, Offset: 0x97c
// Size: 0x1f
function function_fba03eb610498694()
{
    assert( isdefined( level.var_4beddfdc7466d52a ) );
    level.var_4beddfdc7466d52a = undefined;
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 4
// Checksum 0x0, Offset: 0x9a3
// Size: 0x117
function function_956cfd575691a5d9( var_6e450c4f40b511ee, var_7a511a9369ed49e5, n_priority, var_aaa744342068977a )
{
    if ( !isdefined( game[ "zombiemusic_bank" ] ) )
    {
        game[ "zombiemusic_bank" ] = [];
    }
    
    var_9e2dc14ec772ce23 = undefined;
    tokens = strtok( var_6e450c4f40b511ee, "#" );
    
    if ( tokens.size > 1 )
    {
        var_9e2dc14ec772ce23 = tokens[ 0 ];
        var_6e450c4f40b511ee = tokens[ 1 ];
    }
    else if ( isdefined( level.var_4beddfdc7466d52a ) )
    {
        var_9e2dc14ec772ce23 = level.var_4beddfdc7466d52a;
    }
    
    if ( !isdefined( var_9e2dc14ec772ce23 ) )
    {
        return;
    }
    
    if ( !isdefined( game[ "zombiemusic_bank" ][ var_9e2dc14ec772ce23 ] ) )
    {
        game[ "zombiemusic_bank" ][ var_9e2dc14ec772ce23 ] = [];
    }
    
    game[ "zombiemusic_bank" ][ var_9e2dc14ec772ce23 ][ var_6e450c4f40b511ee ] = spawnstruct();
    game[ "zombiemusic_bank" ][ var_9e2dc14ec772ce23 ][ var_6e450c4f40b511ee ].n_priority = n_priority;
    game[ "zombiemusic_bank" ][ var_9e2dc14ec772ce23 ][ var_6e450c4f40b511ee ].array_musicstates = var_7a511a9369ed49e5;
    game[ "zombiemusic_bank" ][ var_9e2dc14ec772ce23 ][ var_6e450c4f40b511ee ].var_aaa744342068977a = 0;
    
    if ( isdefined( var_aaa744342068977a ) )
    {
        game[ "zombiemusic_bank" ][ var_9e2dc14ec772ce23 ][ var_6e450c4f40b511ee ].var_aaa744342068977a = var_aaa744342068977a;
    }
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0xac2
// Size: 0x60
function function_9326597e1696db30( var_60e81aa6c9b5d1cf )
{
    foreach ( player in level.players )
    {
        player function_bf7177d54915e7d4( var_60e81aa6c9b5d1cf );
    }
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0xb2a
// Size: 0x20
function function_bf7177d54915e7d4( var_60e81aa6c9b5d1cf )
{
    self.var_3fb2c165c0c044b8.active_bank = var_60e81aa6c9b5d1cf;
}

// Namespace zombie_music / scripts\cp_mp\zombie_music
// Params 1
// Checksum 0x0, Offset: 0xb52
// Size: 0x4e
function function_8b1835eeb80e8efc( player )
{
    if ( !isdefined( player.var_3fb2c165c0c044b8 ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_3fb2c165c0c044b8.active_bank ) )
    {
        if ( isdefined( game[ "zombiemusic_bank_default" ] ) )
        {
            player function_bf7177d54915e7d4( game[ "zombiemusic_bank_default" ] );
        }
    }
}

