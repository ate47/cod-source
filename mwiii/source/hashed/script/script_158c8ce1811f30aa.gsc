#using scripts\engine\utility;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\utility\script;

#namespace namespace_dc3509b15456adcd;

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 0
// Checksum 0x0, Offset: 0x1e5
// Size: 0x233
function init()
{
    level.gulag.var_72898299e18201ca = getdvarint( @"hash_9f370893a02d7f7e", 1 );
    
    if ( !level.gulag.var_72898299e18201ca )
    {
        return;
    }
    
    scripts\mp\gametypes\br_gulag::function_c797c1f0977d41d1( "overrideArenas", &function_2197e8b96724beae );
    scripts\mp\gametypes\br_gulag::function_c797c1f0977d41d1( "getNamedArenaSettings", &getnamedarenasettings );
    scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2( "addArenas", &function_fd7fbc8d2bcebbd3 );
    scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2( "isArenaEnabled", &function_89644aef61fda016 );
    scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2( "beginNewFight", &function_6cf3afc244dd4077 );
    scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2( "handleEndArena", &function_3d69c38700b870f0 );
    scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2( "jailEnter", &function_ae3c6ef7d251fd7d );
    scripts\mp\gametypes\br_gulag::function_ed608478232fdeb2( "respawnCleanup", &function_4d792792272fd894 );
    var_85cef4fa0d712afe = getmatchrulesdata( "brData", "gulagNamedArenaList" );
    
    if ( var_85cef4fa0d712afe == "" )
    {
        return;
    }
    
    var_e38d6bfcdaa395bd = getscriptbundle( "gulagnamedarenalist:" + var_85cef4fa0d712afe );
    
    if ( !isdefined( var_e38d6bfcdaa395bd ) )
    {
        scripts\mp\utility\script::demoforcesre( "Could not find scriptbundle gulagnamedarenalist:" + var_85cef4fa0d712afe );
        return;
    }
    
    level.gulag.var_f47125b3d5474f8d = spawnstruct();
    level.gulag.var_f47125b3d5474f8d.chance = getdvarfloat( @"hash_cbb5097fc1a36d1c", var_e38d6bfcdaa395bd.chance );
    level.gulag.var_f47125b3d5474f8d.var_a8e3c44cc7054759 = getdvarint( @"hash_f86bbf62d7600d2e", var_e38d6bfcdaa395bd.var_a8e3c44cc7054759 );
    level.gulag.var_f47125b3d5474f8d.arenas = [];
    level.gulag.var_d22768d920d6fd85 = getdvarint( @"hash_4103c635701b02ab", 0 );
    
    foreach ( index, arenabundle in var_e38d6bfcdaa395bd.var_702ba38621dc2810 )
    {
        function_5e14b1b91fc333d7( index, arenabundle );
    }
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 2
// Checksum 0x0, Offset: 0x420
// Size: 0x16d
function function_5e14b1b91fc333d7( index, bundle )
{
    arenasettings = getscriptbundle( "gulagnamedarena:" + bundle.gulagnamedarena );
    prefix = hashcat( @"hash_9f372493a02dbd12", arenasettings.ref, "_" );
    info = spawnstruct();
    info.index = index;
    info.weight = getdvarfloat( hashcat( prefix, "weight" ), bundle.weight );
    info.settings = arenasettings;
    arenastructs = scripts\engine\utility::getstructarray( arenasettings.targetname, "targetname" );
    
    foreach ( arenastruct in arenastructs )
    {
        arenastruct.var_638e3fc0c10a60ed = 1;
        arenastruct.var_17dc3ae4805542d3 = index;
        arenastruct.sortvalue = -1;
    }
    
    info.arenastructs = arenastructs;
    level.gulag.var_f47125b3d5474f8d.arenas[ index ] = info;
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 0
// Checksum 0x0, Offset: 0x595
// Size: 0xe2
function function_fd7fbc8d2bcebbd3()
{
    arenas = [];
    
    foreach ( info in level.gulag.var_f47125b3d5474f8d.arenas )
    {
        var_72898299e18201ca = scripts\engine\utility::getstructarray( info.settings.targetname, "targetname" );
        
        foreach ( arena in var_72898299e18201ca )
        {
            arenas[ arenas.size ] = arena;
        }
    }
    
    return arenas;
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 1
// Checksum 0x0, Offset: 0x680
// Size: 0x40
function getnamedarenasettings( arena )
{
    if ( !function_638e3fc0c10a60ed( arena ) )
    {
        return undefined;
    }
    
    return level.gulag.var_f47125b3d5474f8d.arenas[ arena.var_17dc3ae4805542d3 ];
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 0
// Checksum 0x0, Offset: 0x6c9
// Size: 0x1bc
function function_2197e8b96724beae()
{
    var_a15a6f013d6326e3 = function_5eba1288a2444fd9( self );
    
    if ( isdefined( var_a15a6f013d6326e3 ) )
    {
        self.var_f065df9906eca7eb = 1;
        return [ [ var_a15a6f013d6326e3 ], 1 ];
    }
    
    if ( randomfloat( 1 ) >= level.gulag.var_f47125b3d5474f8d.chance )
    {
        return undefined;
    }
    
    var_6e4fee5e86fe52a9 = [];
    var_a67beaf986e513d7 = 0;
    
    foreach ( arena in level.gulag.var_f47125b3d5474f8d.arenas )
    {
        if ( arena.weight <= 0 )
        {
            continue;
        }
        
        if ( !function_c22fd025365f66e( arena ) )
        {
            continue;
        }
        
        var_a67beaf986e513d7 += arena.weight;
        var_6e4fee5e86fe52a9[ var_6e4fee5e86fe52a9.size ] = arena;
    }
    
    if ( !var_6e4fee5e86fe52a9.size )
    {
        return undefined;
    }
    
    randchoice = randomfloat( var_a67beaf986e513d7 );
    sum = 0;
    
    foreach ( arenainfo in var_6e4fee5e86fe52a9 )
    {
        sum += arenainfo.weight;
        
        if ( randchoice < sum )
        {
            self.var_f065df9906eca7eb = 1;
            return [ arenainfo.arenastructs, 0 ];
        }
    }
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 1
// Checksum 0x0, Offset: 0x88d
// Size: 0xbc, Type: bool
function function_c22fd025365f66e( arenainfo )
{
    foreach ( arena in level.gulag.arenas )
    {
        if ( !function_638e3fc0c10a60ed( arena ) )
        {
            continue;
        }
        
        if ( arena.var_17dc3ae4805542d3 != arenainfo.index )
        {
            continue;
        }
        
        if ( arena.matches.size < level.gulag.var_f47125b3d5474f8d.var_a8e3c44cc7054759 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 2
// Checksum 0x0, Offset: 0x952
// Size: 0x7e, Type: bool
function function_89644aef61fda016( arena, player )
{
    if ( !function_638e3fc0c10a60ed( arena ) )
    {
        return true;
    }
    
    if ( function_638e3fc0c10a60ed( arena ) && !istrue( player.var_f065df9906eca7eb ) )
    {
        return false;
    }
    
    info = level.gulag.var_f47125b3d5474f8d.arenas[ arena.var_17dc3ae4805542d3 ];
    return info.weight > 0;
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 1
// Checksum 0x0, Offset: 0x9d9
// Size: 0x17, Type: bool
function function_638e3fc0c10a60ed( arena )
{
    return istrue( arena.var_638e3fc0c10a60ed );
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 1
// Checksum 0x0, Offset: 0x9f9
// Size: 0x8b
function function_ae3c6ef7d251fd7d( arena )
{
    if ( !function_638e3fc0c10a60ed( arena ) )
    {
        return;
    }
    
    info = level.gulag.var_f47125b3d5474f8d.arenas[ arena.var_17dc3ae4805542d3 ];
    
    if ( istrue( info.settings.var_a92a286f14b01cf4 ) && istrue( level.gulag.var_d22768d920d6fd85 ) )
    {
        self nightvisionviewon();
        thread function_eef7b748cc7aca1f();
    }
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 1
// Checksum 0x0, Offset: 0xa8c
// Size: 0xd6
function function_6cf3afc244dd4077( arena )
{
    if ( !function_638e3fc0c10a60ed( arena ) )
    {
        return;
    }
    
    info = level.gulag.var_f47125b3d5474f8d.arenas[ arena.var_17dc3ae4805542d3 ];
    
    foreach ( player in arena.arenaplayers )
    {
        if ( istrue( info.settings.var_a92a286f14b01cf4 ) && !istrue( level.gulag.var_d22768d920d6fd85 ) )
        {
            player thread function_d03e0dc9dc0d509c( 1.5 );
        }
    }
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 1
// Checksum 0x0, Offset: 0xb6a
// Size: 0x11b
function function_3d69c38700b870f0( arena )
{
    foreach ( player in arena.arenaplayers )
    {
        player.var_f065df9906eca7eb = undefined;
    }
    
    if ( !function_638e3fc0c10a60ed( arena ) )
    {
        return;
    }
    
    wait scripts\mp\gametypes\br_gulag::function_86ee3121d91c59c3() + 1;
    info = level.gulag.var_f47125b3d5474f8d.arenas[ arena.var_17dc3ae4805542d3 ];
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( istrue( info.settings.var_a92a286f14b01cf4 ) )
        {
            player nightvisionviewoff( 1 );
        }
    }
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 1
// Checksum 0x0, Offset: 0xc8d
// Size: 0x93
function function_4d792792272fd894( player )
{
    arena = player.arena;
    player.var_f065df9906eca7eb = undefined;
    
    if ( !isdefined( arena ) )
    {
        return;
    }
    
    if ( !function_638e3fc0c10a60ed( arena ) )
    {
        return;
    }
    
    info = level.gulag.var_f47125b3d5474f8d.arenas[ arena.var_17dc3ae4805542d3 ];
    
    if ( istrue( info.settings.var_a92a286f14b01cf4 ) )
    {
        player nightvisionviewoff( 1 );
    }
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 1
// Checksum 0x0, Offset: 0xd28
// Size: 0xe4
function function_5eba1288a2444fd9( player )
{
    foreach ( arena in level.gulag.arenas )
    {
        if ( !function_638e3fc0c10a60ed( arena ) )
        {
            continue;
        }
        
        foreach ( match in arena.matches )
        {
            if ( match.size == 1 )
            {
                if ( player.team == match[ 0 ].team )
                {
                    continue;
                }
                
                return arena;
            }
        }
    }
    
    return undefined;
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 1
// Checksum 0x0, Offset: 0xe15
// Size: 0x23
function function_d03e0dc9dc0d509c( delay )
{
    self endon( "death_or_disconnect" );
    wait delay;
    self nightvisionviewon();
    thread function_eef7b748cc7aca1f();
}

// Namespace namespace_dc3509b15456adcd / namespace_f8d983d04dd7f098
// Params 0
// Checksum 0x0, Offset: 0xe40
// Size: 0x2c
function function_eef7b748cc7aca1f()
{
    self endon( "death_or_disconnect" );
    wait 2;
    
    if ( istrue( self.gulag ) && !self isnightvisionon() )
    {
        self nightvisionviewon( 1 );
    }
}

