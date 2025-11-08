#using scripts\engine\utility;

#namespace progression_utility;

// Namespace progression_utility / scripts\common\progression_utility
// Params 0
// Checksum 0x0, Offset: 0x13f
// Size: 0x66
function getranktablebundle()
{
    assert( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.ranktable ), "ranktable in gamemodebundle is required." );
    ranktablebundle = getscriptbundle( level.gamemodebundle.ranktable );
    assert( isdefined( ranktablebundle ), "mp ranktable undefined" );
    return ranktablebundle;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x1ae
// Size: 0x2d
function getrankbundle( rankbundlename )
{
    rankbundle = getscriptbundle( rankbundlename );
    assert( isdefined( rankbundle ), "rank bundle undefined" );
    return rankbundle;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x1e4
// Size: 0x54
function getrankinfostruct( rankid )
{
    ranktablebundle = getranktablebundle();
    assert( length( ranktablebundle.ranklist ) > rankid );
    return getrankbundle( ranktablebundle.ranklist[ rankid ].rank );
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x241
// Size: 0x1c
function function_cd47cbfaa2de3623( rankid )
{
    return getrankinfostruct( rankid ).ingamerankname;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 2
// Checksum 0x0, Offset: 0x266
// Size: 0x6c
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
// Checksum 0x0, Offset: 0x2da
// Size: 0x1c
function getrankinfolevel( rankid )
{
    return getrankinfostruct( rankid ).ingamerank;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x2ff
// Size: 0x1d
function getrankinfominxp( rankid )
{
    return int( level.ranktable[ rankid ][ 0 ] );
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x325
// Size: 0x1e
function getrankinfoxpamt( rankid )
{
    return int( level.ranktable[ rankid ][ 1 ] );
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x34c
// Size: 0x1e
function getrankinfomaxxp( rankid )
{
    return int( level.ranktable[ rankid ][ 2 ] );
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x373
// Size: 0x1c
function getrankinfofullname( rankid )
{
    return getrankinfostruct( rankid ).ingamerankname;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 0
// Checksum 0x0, Offset: 0x398
// Size: 0x57
function getrank()
{
    rankxp = self.pers[ "rankxp" ];
    rankid = self.pers[ "rank" ];
    
    if ( rankxp < getrankinfominxp( rankid ) + getrankinfoxpamt( rankid ) )
    {
        return rankid;
    }
    
    return getrankforxp( rankxp );
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x3f7
// Size: 0x63
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
    
    while ( rankid > 0 )
    {
        if ( xpval >= getrankinfominxp( rankid ) && xpval < getrankinfominxp( rankid ) + getrankinfoxpamt( rankid ) )
        {
            return rankid;
        }
        
        rankid--;
    }
    
    return rankid;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 0
// Checksum 0x0, Offset: 0x463
// Size: 0x66
function getweaponranktablebundle()
{
    assert( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.weaponranktable ), "weaponranktable in gamemodebundle is required." );
    weaponranktablebundle = getscriptbundle( level.gamemodebundle.weaponranktable );
    assert( isdefined( weaponranktablebundle ), "weapon ranktable asset undefined" );
    return weaponranktablebundle;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x4d2
// Size: 0x2d
function function_91ce54da71d1008d( rankbundlename )
{
    weaponrankbundle = getscriptbundle( rankbundlename );
    assert( isdefined( weaponrankbundle ), "weapon rank bundle undefined" );
    return weaponrankbundle;
}

// Namespace progression_utility / scripts\common\progression_utility
// Params 1
// Checksum 0x0, Offset: 0x508
// Size: 0x54
function getweaponranktableentry( rankid )
{
    ranktablebundle = getweaponranktablebundle();
    assert( length( ranktablebundle.weaponranklist ) > rankid );
    return getrankbundle( ranktablebundle.weaponranklist[ rankid ].rank );
}

