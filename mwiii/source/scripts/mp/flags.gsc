#namespace flags;

// Namespace flags / scripts\mp\flags
// Params 0
// Checksum 0x0, Offset: 0x90
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
// Checksum 0x0, Offset: 0xae
// Size: 0x2f
function gameflaginit( flagname, isenabled )
{
    assert( isdefined( game[ "<dev string:x1c>" ] ) );
    game[ "flags" ][ flagname ] = isenabled;
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0xe5
// Size: 0x21, Type: bool
function gameflagexists( flagname )
{
    return isdefined( game[ "flags" ] ) && isdefined( game[ "flags" ][ flagname ] );
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x10f
// Size: 0x34
function gameflag( flagname )
{
    assertex( isdefined( game[ "<dev string:x1c>" ][ flagname ] ), "<dev string:x25>" + flagname + "<dev string:x32>" );
    return game[ "flags" ][ flagname ];
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x14c
// Size: 0x3b
function gameflagset( flagname )
{
    assertex( isdefined( game[ "<dev string:x1c>" ][ flagname ] ), "<dev string:x25>" + flagname + "<dev string:x32>" );
    game[ "flags" ][ flagname ] = 1;
    level notify( flagname );
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x18f
// Size: 0x36
function gameflagclear( flagname )
{
    assertex( isdefined( game[ "<dev string:x1c>" ][ flagname ] ), "<dev string:x25>" + flagname + "<dev string:x32>" );
    game[ "flags" ][ flagname ] = 0;
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x1cd
// Size: 0x3c
function gameflagwait( flagname )
{
    assertex( isdefined( game[ "<dev string:x1c>" ][ flagname ] ), "<dev string:x25>" + flagname + "<dev string:x32>" );
    
    while ( !gameflag( flagname ) )
    {
        level waittill( flagname );
    }
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x211
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
// Checksum 0x0, Offset: 0x23a
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
// Checksum 0x0, Offset: 0x25b
// Size: 0x33
function levelflaginit( flagname, isenabled )
{
    assert( isdefined( level.levelflags ) );
    level.levelflags[ flagname ] = isenabled;
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x296
// Size: 0x38
function levelflag( flagname )
{
    assertex( isdefined( level.levelflags[ flagname ] ), "<dev string:x87>" + flagname + "<dev string:x95>" );
    return level.levelflags[ flagname ];
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x2d7
// Size: 0x3f
function levelflagset( flagname )
{
    assertex( isdefined( level.levelflags[ flagname ] ), "<dev string:x87>" + flagname + "<dev string:x95>" );
    level.levelflags[ flagname ] = 1;
    level notify( flagname );
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x31e
// Size: 0x3e
function levelflagclear( flagname )
{
    assertex( isdefined( level.levelflags[ flagname ] ), "<dev string:x87>" + flagname + "<dev string:x95>" );
    level.levelflags[ flagname ] = 0;
    level notify( flagname );
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x364
// Size: 0x3e
function levelflagwait( flagname )
{
    assertex( isdefined( level.levelflags[ flagname ] ), "<dev string:x87>" + flagname + "<dev string:x95>" );
    
    while ( !levelflag( flagname ) )
    {
        level waittill( flagname );
    }
}

// Namespace flags / scripts\mp\flags
// Params 1
// Checksum 0x0, Offset: 0x3aa
// Size: 0x3e
function levelflagwaitopen( flagname )
{
    assertex( isdefined( level.levelflags[ flagname ] ), "<dev string:x87>" + flagname + "<dev string:x95>" );
    
    while ( levelflag( flagname ) )
    {
        level waittill( flagname );
    }
}

