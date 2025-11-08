#using scripts\engine\utility;

#namespace progression_utility;

// Namespace progression_utility / scripts\common\progression_utility
// Params 0
// Checksum 0x0, Offset: 0xba
// Size: 0x67
function getranktablebundle()
{
    assert( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.ranktable ), "<dev string:x1c>" );
    ranktablebundle = getscriptbundle( level.gamemodebundle.ranktable );
    assert( isdefined( ranktablebundle ), "<dev string:x48>" );
    return ranktablebundle;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x12a
// Size: 0x2e
function getrankbundle( rankbundlename )
{
    rankbundle = getscriptbundle( rankbundlename );
    assert( isdefined( rankbundle ), "<dev string:x62>" );
    return rankbundle;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x161
// Size: 0x55
function getrankinfostruct( rankid )
{
    ranktablebundle = getranktablebundle();
    assert( length( ranktablebundle.ranklist ) > rankid );
    return getrankbundle( ranktablebundle.ranklist[ rankid ].rank );
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x1bf
// Size: 0x1c
function function_cd47cbfaa2de3623( rankid )
{
    return getrankinfostruct( rankid ).ingamerankname;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 2
// Checksum 0x0, Offset: 0x1e4
// Size: 0x6d
function getrankinfoicon( rankid, prestigeid )
{
    ranktablebundle = getranktablebundle();
    
    if ( isdefined( ranktablebundle.prestigeiconlist ) && length( ranktablebundle.prestigeiconlist ) > prestigeid )
    {
        return ranktablebundle.prestigeiconlist[ prestigeid ];
    }
    
    return getrankinfostruct( rankid ).icon;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x259
// Size: 0x1c
function getrankinfolevel( rankid )
{
    return getrankinfostruct( rankid ).ingamerank;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x27e
// Size: 0x1d
function getrankinfominxp( rankid )
{
    return int( level.ranktable[ rankid ][ 0 ] );
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x2a4
// Size: 0x1e
function getrankinfoxpamt( rankid )
{
    return int( level.ranktable[ rankid ][ 1 ] );
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x2cb
// Size: 0x1e
function getrankinfomaxxp( rankid )
{
    return int( level.ranktable[ rankid ][ 2 ] );
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x2f2
// Size: 0x1c
function getrankinfofullname( rankid )
{
    return getrankinfostruct( rankid ).ingamerankname;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 0
// Checksum 0x0, Offset: 0x317
// Size: 0x63
function getrank()
{
    rankxp = callsharedfunc( "stats", "getPersStat", "rankxp" );
    rankid = callsharedfunc( "stats", "getPersStat", "rank" );
    
    if ( rankxp < getrankinfominxp( rankid ) + getrankinfoxpamt( rankid ) )
    {
        return rankid;
    }
    
    return getrankforxp( rankxp );
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x382
// Size: 0xc8
function getrankforxp( xpval )
{
    rankid = level.maxrank;
    
    if ( xpval >= getrankinfominxp( rankid ) )
    {
        return rankid;
    }
    else
    {
        rankid--;
    }
    
    lowerbound = 0;
    upperbound = rankid;
    
    while ( lowerbound <= upperbound )
    {
        rankid = int( floor( ( lowerbound + upperbound ) / 2 ) );
        minxp = getrankinfominxp( rankid );
        maxxp = getrankinfomaxxp( rankid );
        
        if ( xpval >= minxp && xpval < maxxp )
        {
            return rankid;
        }
        
        if ( xpval >= maxxp )
        {
            lowerbound = rankid + 1;
            continue;
        }
        
        if ( xpval < minxp )
        {
            upperbound = rankid - 1;
            continue;
        }
        
        assertmsg( "<dev string:x7b>" );
        return 0;
    }
    
    return rankid;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 0
// Checksum 0x0, Offset: 0x453
// Size: 0x67
function getweaponranktablebundle()
{
    assert( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.weaponranktable ), "<dev string:xe1>" );
    weaponranktablebundle = getscriptbundle( level.gamemodebundle.weaponranktable );
    assert( isdefined( weaponranktablebundle ), "<dev string:x113>" );
    return weaponranktablebundle;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x4c3
// Size: 0x2e
function function_91ce54da71d1008d( rankbundlename )
{
    weaponrankbundle = getscriptbundle( rankbundlename );
    assert( isdefined( weaponrankbundle ), "<dev string:x137>" );
    return weaponrankbundle;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x4fa
// Size: 0x55
function getweaponranktableentry( rankid )
{
    ranktablebundle = getweaponranktablebundle();
    assert( length( ranktablebundle.weaponranklist ) > rankid );
    return getrankbundle( ranktablebundle.weaponranklist[ rankid ].rank );
}

