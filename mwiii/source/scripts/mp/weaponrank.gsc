#using scripts\common\progression_utility;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\utility\game;
#using scripts\mp\utility\weapon;

#namespace weaponrank;

// Namespace weaponrank / scripts\mp\weaponrank
// Params 0
// Checksum 0x0, Offset: 0x236
// Size: 0x84
function init()
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) )
        {
            return;
        }
    #/
    
    loadweaponranktable();
    level.activearmoryenabled = getdvarint( @"hash_53b03e37a92e4ce8", 1 ) == 1;
    level.var_4ea3e75e13f80da0 = getdvarfloat( @"hash_ca4ce52ff089426", 0.2 );
    level.var_b726ca5fbb4df39f = scripts\cp_mp\utility\game_utility::function_7d04fc91bee2ccd1();
    addglobalweaponrankxpmultiplier( level.var_b726ca5fbb4df39f, "online_mp_weapon_xpscale" );
    level thread onplayerconnect();
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 0
// Checksum 0x0, Offset: 0x2c2
// Size: 0x6b
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( "connected", player );
        
        if ( !isai( player ) )
        {
            if ( level.weaponxpenabled )
            {
                var_69a07d6024aeb70b = getdvarint( @"online_mp_party_weapon_xpscale" );
                isinparty = player getprivatepartysize() > 1;
                
                if ( isinparty )
                {
                    player addweaponrankxpmultiplier( var_69a07d6024aeb70b, "online_mp_party_weapon_xpscale" );
                }
            }
        }
    }
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 0
// Checksum 0x0, Offset: 0x335
// Size: 0x2bc
function loadweaponranktable()
{
    level.weaponranktable = spawnstruct();
    level.weaponranktable.rankinfo = [];
    weaponranktablebundle = getweaponranktablebundle();
    level.weaponranktable.maxrank = weaponranktablebundle.maxrank;
    
    for ( rankid = 0; rankid <= level.weaponranktable.maxrank ; rankid++ )
    {
        weaponranktableentry = function_91ce54da71d1008d( weaponranktablebundle.weaponranklist[ rankid ].rank );
        rankinfo = spawnstruct();
        level.weaponranktable.rankinfo[ rankid ] = rankinfo;
        rankinfo.minxp = weaponranktableentry.minxp;
        rankinfo.xptonextrank = weaponranktableentry.xptonext;
        rankinfo.maxxp = weaponranktableentry.maxxp;
        assertex( rankinfo.minxp + rankinfo.xptonextrank == rankinfo.maxxp, "<dev string:x1c>" + rankid + "<dev string:x36>" );
    }
    
    level.weaponranktable.maxweaponranks = [];
    weaponsscriptbundle = scripts\cp_mp\weapon::function_a221d76594ef4e8b();
    
    if ( isdefined( weaponsscriptbundle ) )
    {
        foreach ( weaponname in weaponsscriptbundle )
        {
            weaponscriptbundle = scripts\cp_mp\weapon::function_8477d8595e0364a7( weaponname, [ #"ref", #"maxrank" ] );
            
            if ( isdefined( weaponscriptbundle ) )
            {
                rootname = weaponscriptbundle.ref;
                maxrank = weaponscriptbundle.maxrank;
                
                if ( !isdefined( rootname ) || rootname == "" || !isdefined( maxrank ) )
                {
                    continue;
                }
                
                maxrank = int( maxrank );
                assertex( maxrank <= level.weaponranktable.maxrank, "<dev string:x72>" + rootname + "<dev string:x8c>" + maxrank + "<dev string:xa4>" + level.weaponranktable.maxrank );
                level.weaponranktable.maxweaponranks[ rootname ] = maxrank;
            }
        }
    }
    
    assertex( level.weaponranktable.maxweaponranks.size > 0, "<dev string:xd4>" );
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0x5f9
// Size: 0x40
function getplayerweaponrank( rootweapon )
{
    assert( weaponhasranks( rootweapon ) );
    weaponxp = getplayerweaponrankxp( rootweapon );
    rank = getweaponrankforxp( weaponxp );
    return rank;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 2
// Checksum 0x0, Offset: 0x642
// Size: 0xef
function getplayerweaponrankxp( rootweapon, type )
{
    assertex( weaponshouldgetxp( rootweapon ), "<dev string:x12d>" );
    
    if ( !isdefined( type ) )
    {
        type = "all";
    }
    
    switch ( type )
    {
        case #"hash_fa24c8f6bd607cf8":
            mpxp = self getplayerdata( "common", "sharedProgression", "weaponLevel", rootweapon, "mpXP" );
            return mpxp;
        case #"hash_fa1ebcf6bd5bece6":
            cpxp = self getplayerdata( "common", "sharedProgression", "weaponLevel", rootweapon, "cpXP" );
            return cpxp;
        case #"hash_c482c6c109150a4":
            mpxp = self getplayerdata( "common", "sharedProgression", "weaponLevel", rootweapon, "mpXP" );
            cpxp = self getplayerdata( "common", "sharedProgression", "weaponLevel", rootweapon, "cpXP" );
            return ( mpxp + cpxp );
    }
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0x739
// Size: 0x42, Type: bool
function isplayerweaponatmaxxp( rootweapon )
{
    assert( weaponhasranks( rootweapon ) );
    currentxp = getplayerweaponrankxp( rootweapon );
    maxxp = getweaponmaxrankxp( rootweapon );
    return currentxp >= maxxp;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0x784
// Size: 0x71
function weaponshouldgetxp( weapon )
{
    var_f486e79b42c6cbec = getdvarint( @"hash_39c5e2e95ae3c2e6", 1 ) == 1;
    
    if ( !var_f486e79b42c6cbec && self.pers[ "rank" ] < 3 && !getdvarint( @"force_challenges" ) )
    {
        return 0;
    }
    
    rootname = getweaponrootname( weapon );
    return weaponhasranks( rootname );
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0x7fe
// Size: 0x76
function weaponhasranks( rootname )
{
    if ( !isdefined( level.weaponranktable.maxweaponranks[ rootname ] ) )
    {
        return 0;
    }
    
    hasranks = level.weaponranktable.maxweaponranks[ rootname ] > 0;
    assertex( !hasranks || isenumvaluevalid( "<dev string:x172>", "<dev string:x17c>", rootname ), "<dev string:x18d>" + rootname + "<dev string:x192>" );
    return hasranks;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0x87d
// Size: 0x35
function getweaponmaxrankxp( rootweapon )
{
    assert( weaponhasranks( rootweapon ) );
    maxrank = getmaxweaponrankforrootweapon( rootweapon );
    return getweaponrankinfomaxxp( maxrank );
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0x8bb
// Size: 0x43
function getweaponrankforxp( xpval )
{
    if ( xpval == 0 )
    {
        return 0;
    }
    
    for ( rankid = getmaxweaponrank() - 1; rankid >= 0 ; rankid-- )
    {
        if ( xpval >= getweaponrankinfominxp( rankid ) )
        {
            return rankid;
        }
    }
    
    return rankid;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0x907
// Size: 0x30
function getmaxweaponrankforrootweapon( rootweapon )
{
    assert( weaponhasranks( rootweapon ) );
    return level.weaponranktable.maxweaponranks[ rootweapon ];
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 0
// Checksum 0x0, Offset: 0x940
// Size: 0x15
function getmaxweaponrank()
{
    return level.weaponranktable.maxrank;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0x95e
// Size: 0x2a
function getweaponrankinfominxp( rankid )
{
    return level.weaponranktable.rankinfo[ rankid ].minxp;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0x991
// Size: 0x2a
function getweaponrankinfoxptonextrank( rankid )
{
    return level.weaponranktable.rankinfo[ rankid ].xptonextrank;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0x9c4
// Size: 0x2a
function getweaponrankinfomaxxp( rankid )
{
    return level.weaponranktable.rankinfo[ rankid ].maxxp;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 3
// Checksum 0x0, Offset: 0x9f7
// Size: 0x27d
function giveplayerweaponxp( objweapon, type, xp )
{
    if ( isai( self ) || !isplayer( self ) || !isdefined( xp ) || xp == 0 || !level.weaponxpenabled )
    {
        return;
    }
    
    rootweapon = getweaponrootname( objweapon.basename );
    
    if ( !self isitemunlocked( rootweapon, "weapon" ) )
    {
        return;
    }
    
    if ( !weaponhasranks( rootweapon ) )
    {
        return;
    }
    
    newtype = remapscoreeventforweapon( type );
    
    if ( newtype != type )
    {
        type = newtype;
        xp = scripts\mp\rank::getscoreinfoxp( type );
    }
    
    if ( xp < 0 )
    {
        assertmsg( "<dev string:x1fb>" );
        return;
    }
    
    basexp = xp;
    xp *= getweaponrankxpmultipliertotal();
    xp = int( xp );
    var_d6c1d2574e3947c7 = getplayerweaponrankxp( rootweapon, "mp" );
    var_6e5c89151ed6e249 = getplayerweaponrankxp( rootweapon, "cp" );
    var_d9e44a427ec4c8d9 = var_d6c1d2574e3947c7 + var_6e5c89151ed6e249;
    oldrank = getweaponrankforxp( var_d9e44a427ec4c8d9 );
    maxxp = getweaponmaxrankxp( rootweapon );
    var_bc811beec61533e0 = maxxp - var_6e5c89151ed6e249;
    var_ccc135d35f5bebc8 = var_d6c1d2574e3947c7 + xp;
    
    if ( var_ccc135d35f5bebc8 > var_bc811beec61533e0 )
    {
        var_ccc135d35f5bebc8 = var_bc811beec61533e0;
    }
    
    var_2993edf5241f55a = var_ccc135d35f5bebc8 + var_6e5c89151ed6e249;
    maxrank = getmaxweaponrankforrootweapon( rootweapon );
    current_prestige = self getplayerdata( "common", "sharedProgression", "weaponLevel", rootweapon, "prestige" );
    current_rank = int( min( getweaponrankforxp( var_2993edf5241f55a ), maxrank ) );
    scripts\mp\analyticslog::logevent_givempweaponxp( objweapon, current_prestige, current_rank, xp, type );
    
    if ( oldrank < current_rank )
    {
        var_9060bffe66826b8c = #"hash_e9aa6f742889a408";
        
        if ( current_rank >= 15 )
        {
            var_9060bffe66826b8c = #"hash_df87536a55018058";
        }
        else if ( current_rank >= 10 )
        {
            var_9060bffe66826b8c = #"hash_db8b62b195e166e8";
        }
        else if ( current_rank >= 5 )
        {
            var_9060bffe66826b8c = #"hash_2235f7435f85418";
        }
        
        var_12239dca1aef95cd = scripts\mp\rank::getscoreinfoxp( var_9060bffe66826b8c );
        scripts\mp\rank::giverankxp( var_9060bffe66826b8c, var_12239dca1aef95cd );
    }
    
    /#
        println( "<dev string:x225>" + rootweapon + "<dev string:x235>" + xp );
        println( "<dev string:x23c>" + xp - basexp );
    #/
    
    return xp;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0xc7d
// Size: 0x41
function remapscoreeventforweapon( event )
{
    switch ( event )
    {
        case #"hash_611825599f1b56f9":
            event = "kill_weapon";
            break;
        case #"hash_5b8ea26626b7f31e":
            event = "weapon_challenge";
            break;
    }
    
    return event;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 2
// Checksum 0x0, Offset: 0xcc7
// Size: 0x1d
function addglobalweaponrankxpmultiplier( multiplier, ref )
{
    level addweaponrankxpmultiplier( multiplier, ref );
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 0
// Checksum 0x0, Offset: 0xcec
// Size: 0x9
function getglobalweaponrankxpmultiplier()
{
    return level getweaponrankxpmultiplier();
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 0
// Checksum 0x0, Offset: 0xcfe
// Size: 0x7, Type: bool
function getplatformweaponrankxpmultiplier()
{
    return true;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0xd0e
// Size: 0x80
function function_9c989ce157528a7e( objweapon )
{
    if ( !istrue( level.activearmoryenabled ) )
    {
        return 1;
    }
    
    if ( !isdefined( objweapon ) )
    {
        return 1;
    }
    
    rootweapon = getweaponrootname( objweapon );
    
    if ( isdefined( rootweapon ) && isdefined( level.weaponmapdata[ rootweapon ] ) && istrue( level.weaponmapdata[ rootweapon ].activearmoryenabled ) )
    {
        return ( 1 + level.var_4ea3e75e13f80da0 );
    }
    
    return 1;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 2
// Checksum 0x0, Offset: 0xd97
// Size: 0x66
function addweaponrankxpmultiplier( multiplier, ref )
{
    if ( !isdefined( self.weaponrankxpmultipliers ) )
    {
        self.weaponrankxpmultipliers = [];
    }
    
    if ( isdefined( self.weaponrankxpmultipliers[ ref ] ) )
    {
        self.weaponrankxpmultipliers[ ref ] = max( self.weaponrankxpmultipliers[ ref ], multiplier );
        return;
    }
    
    self.weaponrankxpmultipliers[ ref ] = multiplier;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0xe05
// Size: 0x3a
function function_e45154ff0dfc8771( ref )
{
    if ( !isdefined( self.weaponrankxpmultipliers ) || !isdefined( self.weaponrankxpmultipliers[ ref ] ) )
    {
        return 1;
    }
    
    return self.weaponrankxpmultipliers[ ref ];
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 0
// Checksum 0x0, Offset: 0xe48
// Size: 0x7e
function getweaponrankxpmultiplier()
{
    if ( !isdefined( self.weaponrankxpmultipliers ) )
    {
        return 1;
    }
    
    modifiertotal = 1;
    
    foreach ( modifier in self.weaponrankxpmultipliers )
    {
        if ( !isdefined( modifier ) )
        {
            continue;
        }
        
        modifiertotal *= modifier;
    }
    
    return modifiertotal;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0xecf
// Size: 0x14
function removeglobalweaponrankxpmultiplier( ref )
{
    level removeweaponrankxpmultiplier( ref );
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0xeeb
// Size: 0x60
function removeweaponrankxpmultiplier( ref )
{
    if ( !isdefined( self.weaponrankxpmultipliers ) )
    {
        assertmsg( "<dev string:x253>" + ref + "<dev string:x282>" );
        return;
    }
    
    if ( !isdefined( self.weaponrankxpmultipliers[ ref ] ) )
    {
        assertmsg( "<dev string:x253>" + ref + "<dev string:x2ad>" );
        return;
    }
    
    self.rankxpmultipliers[ ref ] = undefined;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 0
// Checksum 0x0, Offset: 0xf53
// Size: 0x31
function function_4515ec6f4950ab23()
{
    var_48a136866e33614c = 1;
    
    if ( istrue( scripts\mp\playerlogic::function_1761d46d3de136b9() ) )
    {
        var_48a136866e33614c = scripts\mp\playerlogic::function_35b4c67f5f658332();
    }
    
    return max( var_48a136866e33614c, getglobalweaponrankxpmultiplier() );
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 1
// Checksum 0x0, Offset: 0xf8d
// Size: 0x67
function getweaponrankxpmultipliertotal( objweapon )
{
    playermodifier = getweaponrankxpmultiplier();
    globalmodifier = function_4515ec6f4950ab23();
    gametypemodifier = getgametypeweaponxpmultiplier();
    platformmodifier = getplatformweaponrankxpmultiplier();
    var_c4843c7f58599a44 = function_9c989ce157528a7e( objweapon );
    return playermodifier * globalmodifier * gametypemodifier * platformmodifier * var_c4843c7f58599a44;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 0
// Checksum 0x0, Offset: 0xffd
// Size: 0x9c
function getgametypeweaponxpmultiplier()
{
    dvarscalar = getdvarfloat( hashcat( @"scr_", getgametype(), "_weapon_xp_scalar_override" ), 0 );
    
    if ( dvarscalar > 0 )
    {
        return dvarscalar;
    }
    
    if ( getdvarint( @"hash_78653010d584aa6e", 0 ) == 0 )
    {
        if ( !isdefined( level.gametypeweaponxpmodifier ) )
        {
            level.gametypeweaponxpmodifier = float( tablelookup( "mp/gametypesTable.csv", 0, getgametype(), 19 ) );
        }
        
        return level.gametypeweaponxpmodifier;
    }
    
    return level.gametypebundle.var_3c836934a83182a5;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 0
// Checksum 0x0, Offset: 0x10a2
// Size: 0x61
function getgametypekillsperhouravg()
{
    if ( getdvarint( @"hash_78653010d584aa6e", 0 ) == 0 )
    {
        if ( !isdefined( level.gametypekillsperhouravg ) )
        {
            level.gametypekillsperhouravg = int( tablelookup( "mp/gametypesTable.csv", 0, getgametype(), 20 ) );
        }
        
        return level.gametypekillsperhouravg;
    }
    
    return level.gametypebundle.var_d98341b1a105c7af;
}

// Namespace weaponrank / scripts\mp\weaponrank
// Params 0
// Checksum 0x0, Offset: 0x110c
// Size: 0x9d
function getgametypekillspermatchmaximum()
{
    if ( !isdefined( level.gametypekillspermatchmax ) )
    {
        timelimit = getdvarint( hashcat( @"scr_", getgametype(), "_timelimit" ) );
        
        if ( timelimit == 0 )
        {
            timelimit = 900;
        }
        
        winlimit = getdvarint( hashcat( @"scr_", getgametype(), "_winlimit" ) );
        
        if ( winlimit > 0 )
        {
            timelimit *= winlimit * 2 - 1;
        }
        
        level.gametypekillspermatchmax = getgametypekillsperhouravg() / 60 * timelimit / 60;
    }
    
    return level.gametypekillspermatchmax;
}

