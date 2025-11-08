#namespace flags;

// Namespace flags / scripts\mp\flags
// Params 0
// Checksum 0x0, Offset: 0x129
// Size: 0x16
function initgameflags()
{
    if ( !isdefined( game[ "flags" ] ) )
    {
        game[ "flags" ] = [];
    }
}

// Namespace flags / scripts\mp\flags
// Params 2
// Checksum 0x0, Offset: 0x147
// Size: 0x2f
function gameflaginit( flagname, isenabled )
{
    assert( isdefined( game[ "flags" ] ) );
    game[ "flags" ][ flagname ] = isenabled;
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x17e
// Size: 0x21, Type: bool
function gameflagexists( flagname )
{
    return isdefined( game[ "flags" ] ) && isdefined( game[ "flags" ][ flagname ] );
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x1a8
// Size: 0x34
function gameflag( flagname )
{
    assertex( isdefined( game[ "flags" ][ flagname ] ), "gameFlag " + flagname + " referenced without being initialized; usegameFlagInit( <flagName>, <isEnabled> )" );
    return game[ "flags" ][ flagname ];
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x1e5
// Size: 0x3b
function gameflagset( flagname )
{
    assertex( isdefined( game[ "flags" ][ flagname ] ), "gameFlag " + flagname + " referenced without being initialized; usegameFlagInit( <flagName>, <isEnabled> )" );
    game[ "flags" ][ flagname ] = 1;
    level notify( flagname );
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x228
// Size: 0x36
function gameflagclear( flagname )
{
    assertex( isdefined( game[ "flags" ][ flagname ] ), "gameFlag " + flagname + " referenced without being initialized; usegameFlagInit( <flagName>, <isEnabled> )" );
    game[ "flags" ][ flagname ] = 0;
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x266
// Size: 0x3c
function gameflagwait( flagname )
{
    assertex( isdefined( game[ "flags" ][ flagname ] ), "gameFlag " + flagname + " referenced without being initialized; usegameFlagInit( <flagName>, <isEnabled> )" );
    
    while ( !gameflag( flagname ) )
    {
        level waittill( flagname );
    }
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x2aa
// Size: 0x21
function function_1240434f4201ac9d( flagname )
{
    while ( !gameflagexists( flagname ) )
    {
        waitframe();
    }
    
    gameflagwait( flagname );
}

// Namespace flags / scripts\mp\flags
// Params 0
// Checksum 0x0, Offset: 0x2d3
// Size: 0x19
function initlevelflags()
{
    if ( !isdefined( level.levelflags ) )
    {
        level.levelflags = [];
    }
}

// Namespace flags / scripts\mp\flags
// Params 2
// Checksum 0x0, Offset: 0x2f4
// Size: 0x33
function levelflaginit( flagname, isenabled )
{
    assert( isdefined( level.levelflags ) );
    level.levelflags[ flagname ] = isenabled;
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x32f
// Size: 0x38
function levelflag( flagname )
{
    assertex( isdefined( level.levelflags[ flagname ] ), "levelFlag " + flagname + " referenced without being initialized; use levelFlagInit( <flagName>, <isEnabled> )" );
    return level.levelflags[ flagname ];
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x370
// Size: 0x3f
function levelflagset( flagname )
{
    assertex( isdefined( level.levelflags[ flagname ] ), "levelFlag " + flagname + " referenced without being initialized; use levelFlagInit( <flagName>, <isEnabled> )" );
    level.levelflags[ flagname ] = 1;
    level notify( flagname );
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x3b7
// Size: 0x3e
function levelflagclear( flagname )
{
    assertex( isdefined( level.levelflags[ flagname ] ), "levelFlag " + flagname + " referenced without being initialized; use levelFlagInit( <flagName>, <isEnabled> )" );
    level.levelflags[ flagname ] = 0;
    level notify( flagname );
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x3fd
// Size: 0x3e
function levelflagwait( flagname )
{
    assertex( isdefined( level.levelflags[ flagname ] ), "levelFlag " + flagname + " referenced without being initialized; use levelFlagInit( <flagName>, <isEnabled> )" );
    
    while ( !levelflag( flagname ) )
    {
        level waittill( flagname );
    }
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x443
// Size: 0x3e
function levelflagwaitopen( flagname )
{
    assertex( isdefined( level.levelflags[ flagname ] ), "levelFlag " + flagname + " referenced without being initialized; use levelFlagInit( <flagName>, <isEnabled> )" );
    
    while ( levelflag( flagname ) )
    {
        level waittill( flagname );
    }
}

