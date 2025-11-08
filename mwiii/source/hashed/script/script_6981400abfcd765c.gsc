#using scripts\engine\utility;

#namespace namespace_493bf119b3b0c251;

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 0
// Checksum 0x0, Offset: 0x148
// Size: 0x43, Type: bool
function function_94b952789d039abb()
{
    /#
        if ( getdvarint( @"hash_c68acbd0f58df6b0", 0 ) != 0 )
        {
            return true;
        }
        
        if ( getdvarint( @"hash_6f29400118ddd39b", 0 ) != 0 )
        {
            return false;
        }
    #/
    
    return getdvarint( @"ftue_ingame_enabled", 0 ) != 0;
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 0
// Checksum 0x0, Offset: 0x194
// Size: 0x44
function function_2195503b0dcc12c0()
{
    if ( function_a226c96f1ba59cd0() )
    {
        level.var_98bbc6461bb67f0b = spawnstruct();
        level.var_98bbc6461bb67f0b.var_f8f7108d5f8686c9 = [];
        level.var_98bbc6461bb67f0b.var_4faacf7795179c8f = 1;
    }
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1e0
// Size: 0x12, Type: bool
function private function_a226c96f1ba59cd0()
{
    return istrue( getdvarint( @"hash_9615d7fb7cf74e4c", 0 ) );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 1
// Checksum 0x0, Offset: 0x1fb
// Size: 0x4a, Type: bool
function function_83fc92d8ce12ec9e( progressid )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    savedprogress = function_8e931d2f54036d6d( "ftueProgress", progressid, "completed" );
    return savedprogress > 0;
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x24e
// Size: 0x2c, Type: bool
function private function_8951a5e5929491bb( progressid )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    return true;
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 2
// Checksum 0x0, Offset: 0x283
// Size: 0x6b
function function_e05669c955312c22( progressid, value )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    progressversion = function_8951a5e5929491bb( progressid );
    function_ef834a530f602e31( "ftueProgress", progressid, "completed", value );
    function_ef834a530f602e31( "ftueProgress", progressid, "completedVersion", progressversion );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 1
// Checksum 0x0, Offset: 0x2f6
// Size: 0x48
function function_f3c2d9fe39c96c53( progressid )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    version = function_8e931d2f54036d6d( "ftueProgress", progressid, "completedVersion" );
    return version;
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 0
// Checksum 0x0, Offset: 0x347
// Size: 0x2c
function function_a220dac697d2ea35()
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    return function_70e4a8c54777f552( "brMatchPlayTime" );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 1
// Checksum 0x0, Offset: 0x37c
// Size: 0x4b
function function_2f80e3ca1b2374a( playtime )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    savedtime = function_a220dac697d2ea35() + playtime;
    function_9c70c77ccecb444e( "brMatchPlayTime", savedtime );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 0
// Checksum 0x0, Offset: 0x3cf
// Size: 0x2c
function function_da8cf8dbdb763ae()
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    return function_70e4a8c54777f552( "matchesCompleted" );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 0
// Checksum 0x0, Offset: 0x404
// Size: 0x44
function function_312e1babffbdf863()
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    savedmatches = function_da8cf8dbdb763ae() + 1;
    function_9c70c77ccecb444e( "matchesCompleted", savedmatches );
    return savedmatches;
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 1
// Checksum 0x0, Offset: 0x451
// Size: 0x51, Type: bool
function function_663fcc46a62ebe2b( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_31c4c1d952b9e73d ) );
    currentmatches = function_da8cf8dbdb763ae();
    
    if ( currentmatches >= params.var_31c4c1d952b9e73d )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 1
// Checksum 0x0, Offset: 0x4ab
// Size: 0x72
function function_a25d14ecf8dcb49e( index )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    var_1abb1cf7d64b28f4 = floor( index / 32 );
    index %= 32;
    tooltipscompleted = function_1e6d534caef3039f( var_1abb1cf7d64b28f4 );
    mask = 1 << index;
    tooltipscompleted |= mask;
    function_e35c082c18ff343b( tooltipscompleted, var_1abb1cf7d64b28f4 );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 1
// Checksum 0x0, Offset: 0x525
// Size: 0x68, Type: bool
function function_5f50ae7bff599e0a( index )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    var_1abb1cf7d64b28f4 = floor( index / 32 );
    index %= 32;
    tooltipscompleted = function_1e6d534caef3039f( var_1abb1cf7d64b28f4 );
    mask = 1 << index;
    return istrue( tooltipscompleted & mask );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 0
// Checksum 0x0, Offset: 0x596
// Size: 0x4d
function function_7fbc76f1aefc8fc5()
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    
    if ( function_a226c96f1ba59cd0() )
    {
        return level.var_98bbc6461bb67f0b.var_4faacf7795179c8f;
    }
    
    return function_70e4a8c54777f552( "playerExpertiseOption" );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 0
// Checksum 0x0, Offset: 0x5eb
// Size: 0x3a, Type: bool
function function_3fa91b90ba5753e7()
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    disabled = function_70e4a8c54777f552( "tooltipsDisabled" );
    return !disabled;
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x62e
// Size: 0x1b
function private function_70e4a8c54777f552( data )
{
    return function_1e8137aca9687477( level.var_114256fded8103cd, data );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x652
// Size: 0x25
function private function_9c70c77ccecb444e( data, value )
{
    function_7a70551396a38f2b( level.var_114256fded8103cd, data, value );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x67f
// Size: 0x2d
function private function_8e931d2f54036d6d( arrayname, index, data )
{
    return function_2fb0985cf3162e78( level.var_114256fded8103cd, arrayname, index, data );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x6b5
// Size: 0x37
function private function_ef834a530f602e31( arrayname, index, data, value )
{
    function_24615288bde909b4( level.var_114256fded8103cd, arrayname, index, data, value );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x6f4
// Size: 0x4c
function private function_1e8137aca9687477( key, data )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    playerdata = self getplayerdata( "mp", key, data );
    return playerdata;
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x749
// Size: 0x5e
function private function_2fb0985cf3162e78( key, arrayname, index, data )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    playerdata = self getplayerdata( "mp", key, arrayname, index, data );
    return playerdata;
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x7b0
// Size: 0x49
function private function_7a70551396a38f2b( key, data, value )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    self setplayerdata( "mp", key, data, value );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x801
// Size: 0x5b
function private function_24615288bde909b4( key, arrayname, index, data, value )
{
    assert( isplayer( self ) );
    assert( !isbot( self ) );
    self setplayerdata( "mp", key, arrayname, index, data, value );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x864
// Size: 0x48
function private function_1e6d534caef3039f( var_1abb1cf7d64b28f4 )
{
    var_a35f31a4e9dc0da9 = function_de90bd48a2a5276( var_1abb1cf7d64b28f4 );
    tooltipscompleted = 0;
    
    if ( function_a226c96f1ba59cd0() )
    {
        tooltipscompleted = function_892873a4b3c135ef( self );
    }
    else
    {
        tooltipscompleted = function_70e4a8c54777f552( var_a35f31a4e9dc0da9 );
    }
    
    return tooltipscompleted;
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x8b5
// Size: 0x44
function private function_e35c082c18ff343b( tooltipscompleted, var_1abb1cf7d64b28f4 )
{
    var_a35f31a4e9dc0da9 = function_de90bd48a2a5276( var_1abb1cf7d64b28f4 );
    
    if ( function_a226c96f1ba59cd0() )
    {
        function_c79da86a5696572b( self, tooltipscompleted );
        return;
    }
    
    function_9c70c77ccecb444e( var_a35f31a4e9dc0da9, tooltipscompleted );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x901
// Size: 0x8b
function private function_892873a4b3c135ef( player )
{
    function_aa20cca13a2cc9cd( player );
    
    foreach ( entry in level.var_98bbc6461bb67f0b.var_f8f7108d5f8686c9 )
    {
        if ( isdefined( entry ) && entry.player == player )
        {
            return entry.var_efc2b352015e6b82;
        }
    }
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x994
// Size: 0x97
function private function_c79da86a5696572b( player, value )
{
    function_aa20cca13a2cc9cd( player );
    
    foreach ( entry in level.var_98bbc6461bb67f0b.var_f8f7108d5f8686c9 )
    {
        if ( isdefined( entry ) && entry.player == player )
        {
            entry.var_efc2b352015e6b82 = value;
            break;
        }
    }
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xa33
// Size: 0xd5
function private function_aa20cca13a2cc9cd( player )
{
    foreach ( entry in level.var_98bbc6461bb67f0b.var_f8f7108d5f8686c9 )
    {
        if ( isdefined( entry ) && entry.player == player )
        {
            return;
        }
    }
    
    entry = spawnstruct();
    entry.player = player;
    entry.var_efc2b352015e6b82 = getdvarint( @"hash_92e4360591ae4baf", 0 );
    level.var_98bbc6461bb67f0b.var_f8f7108d5f8686c9 = array_add_safe( level.var_98bbc6461bb67f0b.var_f8f7108d5f8686c9, entry );
}

// Namespace namespace_493bf119b3b0c251 / namespace_b97271dc63a81cc0
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xb10
// Size: 0x2b
function private function_de90bd48a2a5276( var_1abb1cf7d64b28f4 )
{
    var_a35f31a4e9dc0da9 = "tooltipsCompleted_01";
    
    if ( var_1abb1cf7d64b28f4 == 1 )
    {
        var_a35f31a4e9dc0da9 = "tooltipsCompleted_02";
    }
    
    return var_a35f31a4e9dc0da9;
}

