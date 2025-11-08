#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br;
#using scripts\mp\rank;
#using scripts\mp\utility\teams;

#namespace namespace_5098b67bae4b5f57;

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x19f
// Size: 0x4a
function autoexec main()
{
    if ( getdvarint( @"hash_e5454296d7678bbd", 0 ) == 0 )
    {
        return;
    }
    
    initleveldata();
    level callback::add( "player_connect", &onplayerconnect );
    level callback::add( "on_squad_eliminated", &onteameliminated );
    thread watchgameended();
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 0
// Checksum 0x0, Offset: 0x1f1
// Size: 0x8f
function initleveldata()
{
    level.var_5098b67bae4b5f57 = spawnstruct();
    level.var_5098b67bae4b5f57.var_38430af38d6a4b5e = getdvarint( @"hash_5fa1f70ad893922e", 1200 );
    level.var_5098b67bae4b5f57.var_9c8718d3b8fcb912 = function_2c0e6f67c79cd53f( getdvar( @"hash_919aa9a7fbc43253", "500,1000,1500,2000" ) );
    level.var_5098b67bae4b5f57.var_a0bb221e519273fb = function_2c0e6f67c79cd53f( getdvar( @"hash_8f4cf54e6191b9db", "500,1000,1500,2000" ) );
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 1
// Checksum 0x0, Offset: 0x288
// Size: 0x70
function function_2c0e6f67c79cd53f( var_cf53697e54f5afb2 )
{
    var_9c8718d3b8fcb912 = [];
    
    foreach ( xpreward in strtok( var_cf53697e54f5afb2, "," ) )
    {
        var_9c8718d3b8fcb912[ var_9c8718d3b8fcb912.size ] = int( xpreward );
    }
    
    return var_9c8718d3b8fcb912;
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 1
// Checksum 0x0, Offset: 0x301
// Size: 0x8b
function onplayerconnect( params )
{
    thread watchplayerdisconnect();
    teamplayers = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    
    if ( teamplayers.size > 1 )
    {
        foreach ( player in teamplayers )
        {
            player.var_1021c943edb6b85b = 1;
        }
    }
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 1
// Checksum 0x0, Offset: 0x394
// Size: 0x1d
function onteameliminated( params )
{
    function_70c9aea03725e356( params.team );
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 0
// Checksum 0x0, Offset: 0x3b9
// Size: 0x6b
function watchgameended()
{
    level waittill( "start_game_ended" );
    
    foreach ( teamname in level.teamnamelist )
    {
        if ( br::isbrteameliminated( teamname ) )
        {
            continue;
        }
        
        function_70c9aea03725e356( teamname );
    }
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 0
// Checksum 0x0, Offset: 0x42c
// Size: 0x33
function watchplayerdisconnect()
{
    player = self;
    level endon( "start_game_ended" );
    player endon( "br_team_fully_eliminated" );
    player waittill( "disconnect" );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player function_d9a24e5da5893c4f();
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 1
// Checksum 0x0, Offset: 0x467
// Size: 0xcc
function function_70c9aea03725e356( team )
{
    teamplayers = scripts\mp\utility\teams::getteamdata( team, "players" );
    
    foreach ( player in teamplayers )
    {
        if ( !isdefined( player ) || isbot( player ) )
        {
            continue;
        }
        
        if ( player function_ca5f38f2317a551() )
        {
            player function_8282007bfce6f654();
        }
        else
        {
            player function_d9a24e5da5893c4f();
        }
        
        var_57cbfbbf896531d3 = function_9542f1c554b69ccd( level.var_5098b67bae4b5f57.var_9c8718d3b8fcb912, player function_bbc11dae1ae97f4d() );
        player setclientomnvar( "ui_squad_play_bonus_player_xp_streak", var_57cbfbbf896531d3 );
    }
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 0
// Checksum 0x0, Offset: 0x53b
// Size: 0x3d, Type: bool
function function_ca5f38f2317a551()
{
    player = self;
    
    if ( level.maxteamsize < 2 )
    {
        return false;
    }
    
    if ( istrue( player.var_1021c943edb6b85b ) || player issquadfillenabled() )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 0
// Checksum 0x0, Offset: 0x581
// Size: 0x18
function function_d9a24e5da5893c4f()
{
    player = self;
    player setplayercurrentstreak( 0 );
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 0
// Checksum 0x0, Offset: 0x5a1
// Size: 0x4f
function function_8282007bfce6f654()
{
    player = self;
    
    if ( player function_fa15b36fd28cd13f() )
    {
        player function_d9a24e5da5893c4f();
    }
    
    currentstreak = player function_bbc11dae1ae97f4d();
    player function_ea2cc582e4cbf3f6( currentstreak );
    player setplayercurrentstreak( currentstreak + 1 );
    player function_621d9fe4d9c20992();
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 0
// Checksum 0x0, Offset: 0x5f8
// Size: 0x3f, Type: bool
function function_fa15b36fd28cd13f()
{
    player = self;
    var_efb8b54fb427f119 = level.starttimeutcseconds - player function_8d7209d88535ae16();
    return var_efb8b54fb427f119 > level.var_5098b67bae4b5f57.var_38430af38d6a4b5e;
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x640
// Size: 0x8b
function private function_ea2cc582e4cbf3f6( currentstreak )
{
    player = self;
    xpreward = function_9542f1c554b69ccd( level.var_5098b67bae4b5f57.var_9c8718d3b8fcb912, currentstreak );
    eventinfo = spawnstruct();
    eventinfo.var_158745de00c72d3e = function_9542f1c554b69ccd( level.var_5098b67bae4b5f57.var_a0bb221e519273fb, currentstreak );
    player scripts\mp\rank::giverankxp( #"hash_d50fc159ab68b13b", xpreward, undefined, 1, 1, 0, undefined, eventinfo );
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x6d3
// Size: 0x32
function private function_9542f1c554b69ccd( var_11b102a1d8f20eb3, var_4c4f4e4784876d57 )
{
    var_6bce2340e9c5908b = int( min( var_4c4f4e4784876d57, var_11b102a1d8f20eb3.size - 1 ) );
    return var_11b102a1d8f20eb3[ var_6bce2340e9c5908b ];
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x70e
// Size: 0x26
function private setplayercurrentstreak( newstreak )
{
    self setplayerdata( level.progressiongroup, "brSquadPlayBonus", "streak", newstreak );
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x73c
// Size: 0x21
function private function_621d9fe4d9c20992()
{
    self setplayerdata( level.progressiongroup, "brSquadPlayBonus", "lastSeen", getsystemtime() );
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x765
// Size: 0x22
function private function_bbc11dae1ae97f4d()
{
    return default_to( self getplayerdata( level.progressiongroup, "brSquadPlayBonus", "streak" ), 0 );
}

// Namespace namespace_5098b67bae4b5f57 / namespace_dee0cff525a1b877
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x790
// Size: 0x22
function private function_8d7209d88535ae16()
{
    return default_to( self getplayerdata( level.progressiongroup, "brSquadPlayBonus", "lastSeen" ), 0 );
}

