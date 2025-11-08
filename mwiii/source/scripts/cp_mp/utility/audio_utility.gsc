#using scripts\engine\utility;

#namespace audio_utility;

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 0
// Checksum 0x0, Offset: 0x133
// Size: 0x5e
function snd_init()
{
    if ( !isdefined( level.snd ) )
    {
        level.snd = spawnstruct();
        level.snd.objects = [];
        level.snd.unlinkedobjects = [];
        level.snd.fnplaysoundonmovingent = &playsoundonmovingent;
    }
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 1
// Checksum 0x0, Offset: 0x199
// Size: 0x6d
function function_b3e5599c9f6a8895( obj )
{
    assert( obj == level || isstruct( obj ) || isent( obj ) );
    
    if ( !isstruct( obj.snd ) )
    {
        obj.snd = spawnstruct();
    }
    
    assertex( isstruct( obj.snd ), "<dev string:x1c>" );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 0
// Checksum 0x0, Offset: 0x20e
// Size: 0x17, Type: bool
function function_f0b5522ee5ce0cb1()
{
    if ( isstruct( level.snd ) )
    {
        return true;
    }
    
    return false;
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 0
// Checksum 0x0, Offset: 0x22e
// Size: 0x11
function function_40a17693396019a7()
{
    while ( function_f0b5522ee5ce0cb1() == 0 )
    {
        waitframe();
    }
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x247
// Size: 0x6b
function private function_55f5473e977f265f( team_name )
{
    players = [];
    
    if ( isarray( level.teamdata ) && isarray( level.teamdata[ team_name ] ) && isarray( level.teamdata[ team_name ][ "players" ] ) )
    {
        players = level.teamdata[ team_name ][ "players" ];
    }
    
    return players;
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 3
// Checksum 0x0, Offset: 0x2bb
// Size: 0x13b
function function_d6fe092bc83da45b( var_6e077719c0efcb61, radius, team_name )
{
    origin = undefined;
    radius = default_to( radius, 240 );
    team_name = default_to( team_name, "" );
    players = [];
    
    if ( isvector( var_6e077719c0efcb61 ) )
    {
        origin = var_6e077719c0efcb61;
    }
    else if ( isent( var_6e077719c0efcb61 ) )
    {
        origin = var_6e077719c0efcb61.origin;
    }
    
    if ( isvector( origin ) )
    {
        regional_players = getentarrayinradius( "player", "classname", origin, radius );
        
        foreach ( player in regional_players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                if ( team_name == "" || isstring( player.team ) && player.team == team_name )
                {
                    players[ players.size ] = player;
                }
            }
        }
        
        return players;
    }
    else
    {
        assertmsg( "<dev string:x44>" );
    }
    
    return players;
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 3
// Checksum 0x0, Offset: 0x3ff
// Size: 0x4a
function function_ad9f5152bfdebcfe( gamekey, statekey, value )
{
    assertex( isstring( gamekey ), "<dev string:x82>" );
    assertex( isstring( statekey ), "<dev string:xae>" );
    game[ gamekey ][ statekey ] = value;
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 2
// Checksum 0x0, Offset: 0x451
// Size: 0x1d
function function_d05e164d112ab01( gamekey, statekey )
{
    function_ad9f5152bfdebcfe( gamekey, statekey, undefined );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 2
// Checksum 0x0, Offset: 0x476
// Size: 0x4d
function function_9a0f23d8adcd6392( gamekey, statekey )
{
    assertex( isstring( gamekey ), "<dev string:xdb>" );
    assertex( isstring( statekey ), "<dev string:x107>" );
    data = game[ gamekey ][ statekey ];
    return data;
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 2
// Checksum 0x0, Offset: 0x4cc
// Size: 0x6e
function function_5cb73579174212fd( gamekey, statekey )
{
    value = function_9a0f23d8adcd6392( gamekey, statekey );
    
    if ( isarray( value ) )
    {
        index = 0;
        
        if ( value.size > 1 )
        {
            index = randomintrange( 0, value.size );
            assertex( index >= 0 && index < value.size, "<dev string:x134>" + index );
        }
        
        value = value[ index ];
    }
    
    return value;
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 2
// Checksum 0x0, Offset: 0x543
// Size: 0xa4
function function_7acde5feb50c98f2( players, soundalias )
{
    players = default_to( players, [] );
    soundalias = default_to( soundalias, "" );
    
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                player playlocalsound( soundalias );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x165>" );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 2
// Checksum 0x0, Offset: 0x5ef
// Size: 0xa4
function function_66f41f0823bd279c( players, soundalias )
{
    players = default_to( players, [] );
    soundalias = default_to( soundalias, "" );
    
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                player stoplocalsound( soundalias );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x19a>" );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 3
// Checksum 0x0, Offset: 0x69b
// Size: 0xe3
function function_a408e30ca85e03a9( players, zonename, fadetime )
{
    players = default_to( players, [] );
    zonename = default_to( zonename, "" );
    fadetime = default_to( fadetime, 1 );
    
    if ( isarray( players ) )
    {
        assertex( isstring( zonename ), "<dev string:x1cf>" );
        assertex( isnumber( fadetime ), "<dev string:x20c>" );
        
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                player setclienttriggeraudiozone( zonename, fadetime );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x249>" );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 2
// Checksum 0x0, Offset: 0x786
// Size: 0xb8
function function_326e5ed05234a4f0( players, fadetime )
{
    players = default_to( players, [] );
    fadetime = default_to( fadetime, 1 );
    
    if ( isarray( players ) )
    {
        assertex( isnumber( fadetime ), "<dev string:x286>" );
        
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                player clearclienttriggeraudiozone( fadetime );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x2c5>" );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 2
// Checksum 0x0, Offset: 0x846
// Size: 0x21
function setmusicset( musicset, value )
{
    function_ad9f5152bfdebcfe( "music", musicset, value );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 1
// Checksum 0x0, Offset: 0x86f
// Size: 0x59
function getmusicset( musicset )
{
    state = function_9a0f23d8adcd6392( "music", musicset );
    
    if ( isarray( state ) )
    {
        if ( state.size == 0 )
        {
            state = undefined;
        }
        else
        {
            state = state[ 0 ];
        }
    }
    else if ( !isstring( state ) )
    {
        state = undefined;
    }
    
    if ( !isdefined( state ) )
    {
        return "";
    }
    
    return state;
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 1
// Checksum 0x0, Offset: 0x8d1
// Size: 0x3a
function function_17ee301cf0b5ba85( musicset )
{
    state = function_5cb73579174212fd( "music", musicset );
    
    if ( !isdefined( state ) || !isstring( state ) )
    {
        return "";
    }
    
    return state;
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 1
// Checksum 0x0, Offset: 0x914
// Size: 0x47, Type: bool
function function_5df2f278f44a6ffd( style )
{
    if ( isstring( style ) && isdefined( level.music_style ) && isstring( level.music_style ) && level.music_style == style )
    {
        return true;
    }
    
    return false;
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 5
// Checksum 0x0, Offset: 0x964
// Size: 0x14e
function function_fe75a89529dd0fd0( players, var_9adc1bcdce9cf8b0, var_c342527a25f10cc5, except, var_206c8dfdb8c43d68 )
{
    players = default_to( players, [] );
    var_9adc1bcdce9cf8b0 = default_to( var_9adc1bcdce9cf8b0, "" );
    var_206c8dfdb8c43d68 = default_to( var_206c8dfdb8c43d68, "" );
    
    if ( isdefined( level.var_973185176be76120 ) )
    {
        level thread [[ level.var_973185176be76120 ]]( players, var_9adc1bcdce9cf8b0, var_c342527a25f10cc5 );
        return;
    }
    
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                if ( var_9adc1bcdce9cf8b0 == "" && isdefined( except ) )
                {
                    player function_9bb444fe81766f7e( except );
                    continue;
                }
                
                if ( isarray( var_c342527a25f10cc5 ) )
                {
                    player setplayermusicstate( var_9adc1bcdce9cf8b0, var_c342527a25f10cc5 );
                    continue;
                }
                
                if ( isdefined( player.musicpack ) && player.musicpack == 1 )
                {
                    player setplayermusicstate( var_206c8dfdb8c43d68 );
                    continue;
                }
                
                player setplayermusicstate( var_9adc1bcdce9cf8b0 );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x304>" );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 4
// Checksum 0x0, Offset: 0xaba
// Size: 0x6c
function function_46979d2fd81a6d4b( team_name, var_9adc1bcdce9cf8b0, var_c342527a25f10cc5, var_206c8dfdb8c43d68 )
{
    team_name = default_to( team_name, "" );
    var_9adc1bcdce9cf8b0 = default_to( var_9adc1bcdce9cf8b0, "" );
    var_206c8dfdb8c43d68 = default_to( var_206c8dfdb8c43d68, "" );
    players = function_55f5473e977f265f( team_name );
    function_fe75a89529dd0fd0( players, var_9adc1bcdce9cf8b0, var_c342527a25f10cc5, undefined, var_206c8dfdb8c43d68 );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 6
// Checksum 0x0, Offset: 0xb2e
// Size: 0x71
function function_fdd0934f1a32f70d( var_6e077719c0efcb61, radius, var_9adc1bcdce9cf8b0, team_name, var_c342527a25f10cc5, var_206c8dfdb8c43d68 )
{
    var_9adc1bcdce9cf8b0 = default_to( var_9adc1bcdce9cf8b0, "" );
    var_206c8dfdb8c43d68 = default_to( var_206c8dfdb8c43d68, "" );
    players = function_d6fe092bc83da45b( var_6e077719c0efcb61, radius, team_name );
    function_fe75a89529dd0fd0( players, var_9adc1bcdce9cf8b0, var_c342527a25f10cc5, undefined, var_206c8dfdb8c43d68 );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 4
// Checksum 0x0, Offset: 0xba7
// Size: 0xd2
function function_4e8ba327eb12540c( players, submix_name, fadetime, scale )
{
    players = default_to( players, [] );
    submix_name = default_to( submix_name, "" );
    fadetime = default_to( fadetime, -1 );
    scale = default_to( scale, 1 );
    
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                player setsoundsubmix( submix_name, fadetime, scale );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x339>" );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 4
// Checksum 0x0, Offset: 0xc81
// Size: 0x5d
function function_c7f38d0611aa82e7( team_name, submix_name, fadetime, scale )
{
    submix_name = default_to( submix_name, "" );
    team_name = default_to( team_name, "" );
    players = function_55f5473e977f265f( team_name );
    function_4e8ba327eb12540c( players, submix_name, fadetime, scale );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 3
// Checksum 0x0, Offset: 0xce6
// Size: 0xa5
function function_c79f9300ee85f805( players, submix_name, fadetime )
{
    players = default_to( players, [] );
    submix_name = default_to( submix_name, "" );
    fadetime = default_to( fadetime, -1 );
    
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            player clearsoundsubmix( submix_name, fadetime );
        }
        
        return;
    }
    
    assertmsg( "<dev string:x339>" );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 4
// Checksum 0x0, Offset: 0xd93
// Size: 0x5c
function function_e3a3a924d8604018( team_name, submix_name, fadetime, scale )
{
    submix_name = default_to( submix_name, "" );
    team_name = default_to( team_name, "" );
    players = function_55f5473e977f265f( team_name );
    function_c79f9300ee85f805( players, submix_name, fadetime );
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 2
// Checksum 0x0, Offset: 0xdf7
// Size: 0x23
function function_110d3ab280057f5b( condition, alerttext )
{
    /#
        if ( istrue( condition ) )
        {
            println( alerttext );
        }
    #/
    
    return condition;
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xe23
// Size: 0x7f
function private function_5b159f140bd186df()
{
    function_40a17693396019a7();
    
    if ( !isarray( level.snd.transient_banks ) )
    {
        level.snd.transient_banks = [];
    }
    
    if ( !isent( level.snd.var_4388174fd6467686 ) )
    {
        level.snd.var_4388174fd6467686 = spawn( "sound_transient_soundbanks", ( 0, 0, 0 ) );
    }
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 1
// Checksum 0x0, Offset: 0xeaa
// Size: 0x52, Type: bool
function function_1186ca4e2e51afea( name )
{
    if ( isstruct( level.snd ) && isdefined( level.snd.transient_banks ) && isdefined( level.snd.transient_banks[ name ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 1
// Checksum 0x0, Offset: 0xf05
// Size: 0x119
function function_f1aed36ab4598ea( name )
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) != 0 || getdvarint( @"g_connectpaths" ) != 0 )
    {
        return;
    }
    
    function_5b159f140bd186df();
    assert( function_f0b5522ee5ce0cb1() );
    assert( isent( level.snd.var_4388174fd6467686 ) );
    assert( isarray( level.snd.transient_banks ) );
    assertex( isstring( name ), "<dev string:x36a>" );
    isloaded = function_1186ca4e2e51afea( name );
    
    if ( function_110d3ab280057f5b( isloaded, "snd_transient_load loaded '" + name + "'" ) )
    {
        return;
    }
    
    level.snd.var_4388174fd6467686 settransientsoundbank( name + ".all", 1 );
    level.snd.transient_banks[ name ] = level.snd.transient_banks.size;
}

// Namespace audio_utility / scripts\cp_mp\utility\audio_utility
// Params 1
// Checksum 0x0, Offset: 0x1026
// Size: 0x101
function function_f4e0ff5cb899686d( name )
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) != 0 || getdvarint( @"g_connectpaths" ) != 0 )
    {
        return;
    }
    
    function_5b159f140bd186df();
    assert( function_f0b5522ee5ce0cb1() );
    assert( isent( level.snd.var_4388174fd6467686 ) );
    assert( isarray( level.snd.transient_banks ) );
    assertex( isstring( name ), "<dev string:x399>" );
    isloaded = function_1186ca4e2e51afea( name );
    
    if ( function_110d3ab280057f5b( !isloaded, "snd_transient_unload '" + name + "' not loaded" ) )
    {
        return;
    }
    
    level.snd.var_4388174fd6467686 settransientsoundbank( name + ".all", 0 );
    level.snd.transient_banks[ name ] = undefined;
}

