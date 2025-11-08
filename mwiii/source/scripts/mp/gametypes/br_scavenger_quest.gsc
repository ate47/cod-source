#using script_4948cdf739393d2d;
#using script_64acb6ce534155b7;
#using script_744cad313ed0a87e;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_bunker_utility;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\locksandkeys;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;

#namespace br_scavenger_quest;

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0x699
// Size: 0x3a2
function getcontractdata( data )
{
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "body", &scavengerlootcacheused );
    level.var_cf05afb32024800a = spawnstruct();
    var_ad60abb5340e959d = getdvarint( @"hash_5802e08d3a73518f", 0 );
    level.var_cf05afb32024800a.time = var_ad60abb5340e959d != 0 ? var_ad60abb5340e959d : function_ea591c2a379e3424( "scavenger" );
    level.var_cf05afb32024800a.timebonus = getdvarint( @"hash_428ad704764ff3e7", 45 );
    level.var_cf05afb32024800a.var_597c27bd871980d = getdvarint( @"hash_597f3d01d7ba858d", 1 );
    level.var_cf05afb32024800a.cachespawncount = getdvarint( @"hash_1eaf2ef86c1344e8", 3 );
    level.var_cf05afb32024800a.var_76fbb523b032ed22 = getdvarint( @"hash_40502e1ccc8afee2", 11811 );
    level.var_cf05afb32024800a.var_5e8448f4b9e71cb4 = getdvarint( @"hash_6cf95a3cc8a2c6bc", 3500 );
    level.var_cf05afb32024800a.var_b90dc65a569f4825 = getdvarint( @"hash_a438440ce7ce72c", 7300 );
    level.var_cf05afb32024800a.var_7f34783fc18f8a33 = getdvarint( @"hash_8ce4daaf96793442", 4500 );
    level.var_cf05afb32024800a.var_37143a4776fd671a = getdvarint( @"hash_dab0e9a1525b9075", 10 );
    level.var_cf05afb32024800a.var_22ad655f7a3f053 = getdvarint( @"hash_2b9d8f4be5437b84", 0 );
    level.var_cf05afb32024800a.var_cac1fbf08ec5989b = getdvarint( @"hash_849cc562887e6a7b", 15 );
    level.var_cf05afb32024800a.var_e996476e5ec51e64 = getdvarint( @"hash_225f4b8e2dcb0e36", 0 );
    level.var_cf05afb32024800a.var_5002f454a54ce59b = 21;
    level.var_cf05afb32024800a.var_fb4d6eb8dfba5101 = 0;
    level.var_cf05afb32024800a.var_d2a5b681ce9a712f = 0;
    level.var_cf05afb32024800a.var_f0f6abdb0f9df01 = 0;
    data.funcs[ "onInit" ] = &function_591e6ab6447b07be;
    data.funcs[ "onTeamAssigned" ] = &function_f6f80c11d5d8eaf5;
    data.funcs[ "onCancel" ] = &function_942d13e23c7f1d0e;
    data.funcs[ "circleTick" ] = &function_a33bd2c069408596;
    data.funcs[ "onPlayerKilled" ] = &quest_onplayerkilled;
    data.funcs[ "onMarkPlayerAsEliminated" ] = &function_4f702ea532a7ca6e;
    data.funcs[ "onPlayerDisconnect" ] = &quest_onplayerdisconnect;
    data.funcs[ "onEnterGulag" ] = &function_ca07a6ca5c3c8af5;
    data.funcs[ "onPlayerRespawn" ] = &function_f6755bd234f8e261;
    data.funcs[ "onPlayerTearDown" ] = &function_f9ca547e3935949d;
    data.funcs[ "onPlayerAssimilated" ] = &function_24684569878c3021;
    data.funcs[ "onTimerExpired" ] = &function_899aaa6ac2489b43;
    data.funcs[ "onFinishContract" ] = &function_a93228cdda5c958c;
    data.basetime = level.var_cf05afb32024800a.time;
    function_876794c543d6e89d();
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 0
// Checksum 0x0, Offset: 0xa43
// Size: 0x18
function function_591e6ab6447b07be()
{
    if ( !isdefined( self.cachedata ) )
    {
        return function_549ab791fa91c7ac();
    }
    
    return 1;
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 0
// Checksum 0x0, Offset: 0xa64
// Size: 0x74
function function_876794c543d6e89d()
{
    game[ "dialog" ][ "scavenger_missionstart" ] = "scvn_grav_msns";
    game[ "dialog" ][ "scavenger_onesecured" ] = "scvn_grav_nscr";
    game[ "dialog" ][ "scavenger_twosecured" ] = "scvn_grav_twsc";
    game[ "dialog" ][ "scavenger_missioncomplete" ] = "scvn_grav_msnc";
    game[ "dialog" ][ "scavenger_almosttimeout" ] = "gnrc_grav_mstw";
    game[ "dialog" ][ "scavenger_timeout" ] = "scvn_grav_tmlr";
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 0
// Checksum 0x0, Offset: 0xae0
// Size: 0x107, Type: bool
function function_549ab791fa91c7ac()
{
    if ( !isdefined( self.cachedata ) )
    {
        self.cachedata = [];
    }
    
    if ( !isdefined( self.cachescollected ) )
    {
        self.cachescollected = 0;
    }
    
    bestcaches = function_9f225e14bff0629f();
    
    if ( !isdefined( bestcaches ) )
    {
        return false;
    }
    
    for ( i = 0; i < level.var_cf05afb32024800a.cachespawncount ; i++ )
    {
        self.cachedata[ i ] = spawnstruct();
        self.cachedata[ i ].cachenode = bestcaches[ i ];
        self.cachedata[ i ].collected = 0;
        
        if ( !isdefined( self.cachedata[ i ].cachenode ) )
        {
            self.cachedata = undefined;
            return false;
        }
        
        disablelootspawnpoint( self.cachedata[ i ].cachenode.index );
    }
    
    thread function_411e5816b27e0099();
    return true;
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 0
// Checksum 0x0, Offset: 0xbf0
// Size: 0x189
function function_f6f80c11d5d8eaf5()
{
    self.category = "scavenger";
    uiobjectiveshowtoteam( "scavenger", self.teams[ 0 ] );
    
    foreach ( player in getteamdata( self.teams[ 0 ], "players" ) )
    {
        player uiobjectivesetparameter( 0 );
    }
    
    time = level.var_cf05afb32024800a.time;
    time = function_9b6275085fbcb8f4( time );
    function_5a15174d34f0670c( time, 0 );
    
    if ( !isdefined( self.cachedata ) )
    {
        if ( !function_549ab791fa91c7ac() )
        {
            return 0;
        }
    }
    
    if ( !level.var_cf05afb32024800a.var_22ad655f7a3f053 )
    {
        function_41c2372f16c0e03d( 0 );
    }
    else
    {
        for ( i = 0; i < level.var_cf05afb32024800a.cachespawncount ; i++ )
        {
            function_41c2372f16c0e03d( i );
        }
    }
    
    splashref = function_4bcd7c36b22b9bec( "br_scavenger_quest_start_team" );
    displayteamsplash( self.teams[ 0 ], splashref );
    function_e9cfab9c8a63533c( "scavenger_missionstart", self.teams[ 0 ] );
    displaysquadmessagetoteam( self.teams[ 0 ], self.var_d154ac2657c5f44, 6, getquestindex( "scavenger" ) );
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 2
// Checksum 0x0, Offset: 0xd81
// Size: 0x17d
function function_a33bd2c069408596( dangercircleorigin, var_52d59c928eb97c81 )
{
    if ( istrue( self.var_df2a5e89c3bba966 ) )
    {
        return;
    }
    
    foreach ( cache in self.cachedata )
    {
        if ( !istrue( cache.collected ) && isdefined( cache.cacheentity ) )
        {
            if ( !scripts\mp\gametypes\br_circle_util::ispointindangercircle( cache.cacheentity.origin ) )
            {
                if ( !isdefined( cache.cacheentity.var_ecab0c87adbf2d21 ) )
                {
                    cache.cacheentity.var_ecab0c87adbf2d21 = gettime() + function_a5b14435e3229bed( level.var_cf05afb32024800a.var_37143a4776fd671a );
                }
                
                if ( gettime() >= cache.cacheentity.var_ecab0c87adbf2d21 )
                {
                    self.var_df2a5e89c3bba966 = 1;
                    params = spawnstruct();
                    params.intvar = 0;
                    displayteamsplash( self.teams[ 0 ], "br_scavenger_quest_timer_expired", params );
                    function_e9cfab9c8a63533c( "mission_obj_circle_fail", self.teams[ 0 ] );
                    thread function_810bbeded8d1a801( 0, undefined, "Circle" );
                    return;
                }
            }
        }
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 0
// Checksum 0x0, Offset: 0xf06
// Size: 0x82
function function_411e5816b27e0099()
{
    if ( namespace_bd614c3c2275579a::function_a9b26d3ed078e149() )
    {
        level waittill( "spawn_brStrongholdDelayedSpawn" );
    }
    else
    {
        level waittill( "spawn_brStrongholdSpawn" );
    }
    
    for ( i = 0; i < level.var_cf05afb32024800a.cachespawncount ; i++ )
    {
        if ( namespace_bd614c3c2275579a::function_20a22133815385f8( self.cachedata[ i ].cachenode.origin ) )
        {
            self.cachedata = undefined;
            function_549ab791fa91c7ac();
        }
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 2
// Checksum 0x0, Offset: 0xf90
// Size: 0x1b
function quest_onplayerkilled( attacker, victim )
{
    function_32caac4295e6cf28( victim );
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0xfb3
// Size: 0x13
function function_4f702ea532a7ca6e( victim )
{
    function_32caac4295e6cf28( victim );
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0xfce
// Size: 0x13
function quest_onplayerdisconnect( player )
{
    function_32caac4295e6cf28( player );
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0xfe9
// Size: 0x1d
function function_ca07a6ca5c3c8af5( player )
{
    if ( function_42a0806457ea8039( player ) )
    {
        hidescavengerhudfromplayer( player );
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0x100e
// Size: 0x1d
function function_f6755bd234f8e261( player )
{
    if ( function_42a0806457ea8039( player ) )
    {
        function_17e600057c2cf45( player );
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0x1033
// Size: 0x6e
function function_32caac4295e6cf28( player )
{
    if ( player.team == self.teams[ 0 ] )
    {
        filter = namespace_1eb3c4e0e28fac71::function_94a8dc26f5353759( player, level.contractmanager.defaultfilter );
        
        if ( !scripts\mp\gametypes\br_quest_util::isteamvalid( self.teams[ 0 ], filter ) )
        {
            function_810bbeded8d1a801( 0, undefined, "Killed" );
        }
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 3
// Checksum 0x0, Offset: 0x10a9
// Size: 0xba
function function_f9ca547e3935949d( player, oldteam, newteam )
{
    if ( oldteam == self.teams[ 0 ] )
    {
        if ( !scripts\mp\gametypes\br_quest_util::isteamvalid( oldteam, level.contractmanager.defaultfilter ) )
        {
            thread function_942d13e23c7f1d0e( oldteam );
            return;
        }
        
        hidescavengerhudfromplayer( player );
        
        foreach ( cache in self.cachedata )
        {
            cache.cacheentity disablescriptableplayeruse( player );
        }
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 3
// Checksum 0x0, Offset: 0x116b
// Size: 0xc5
function function_24684569878c3021( player, oldteam, newteam )
{
    if ( !isdefined( self.cachedata ) )
    {
        return;
    }
    
    if ( newteam == self.teams[ 0 ] )
    {
        function_17e600057c2cf45( player );
        player setclientomnvar( "ui_br_objective_countdown_timer", self.missiontime );
        player uiobjectivesetparameter( self.cachescollected );
        
        foreach ( cache in self.cachedata )
        {
            cache.cacheentity enablescriptableplayeruse( player );
        }
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0x1238
// Size: 0x37
function function_942d13e23c7f1d0e( team )
{
    if ( istrue( self.teams[ 0 ] == team ) )
    {
        function_810bbeded8d1a801( 0, undefined, "Cancel" );
        function_e9cfab9c8a63533c( "mission_gen_fail", team );
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 3
// Checksum 0x0, Offset: 0x1277
// Size: 0x60
function function_810bbeded8d1a801( success, results, endstate )
{
    self notify( "task_ended" );
    self.ended = 1;
    deletescavengerhud();
    wait 1;
    function_8ed931d61f597107();
    endcontract( ter_op( istrue( success ), self.teams[ 0 ], undefined ), results, undefined, endstate );
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 0
// Checksum 0x0, Offset: 0x12df
// Size: 0x131
function function_8ed931d61f597107()
{
    foreach ( cache in self.cachedata )
    {
        if ( !istrue( cache.collected ) && isdefined( cache.cacheentity ) )
        {
            if ( istrue( level.var_cf05afb32024800a.var_cac1fbf08ec5989b > 0 ) )
            {
                foreach ( player in getteamdata( self.teams[ 0 ], "players" ) )
                {
                    cache.cacheentity disablescriptableplayeruse( player );
                }
                
                cache.cacheentity scripts\engine\utility::delaycallendon( level.var_cf05afb32024800a.var_cac1fbf08ec5989b, "death", &delete );
                continue;
            }
            
            cache.cacheentity delete();
        }
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 0
// Checksum 0x0, Offset: 0x1418
// Size: 0x90
function function_2eba816489c231f4()
{
    self endon( "task_ended" );
    level endon( "game_ended" );
    currtime = gettime();
    
    while ( currtime < self.missiontime )
    {
        wait ( self.missiontime - currtime ) / 1000;
        currtime = gettime();
        
        if ( !istrue( self.var_1adec8cf65449059 ) && currtime >= self.missiontime * 0.67 )
        {
            function_e9cfab9c8a63533c( "scavenger_almosttimeout", self.teams[ 0 ] );
            self.var_1adec8cf65449059 = 1;
        }
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 0
// Checksum 0x0, Offset: 0x14b0
// Size: 0x7e
function function_899aaa6ac2489b43()
{
    params = spawnstruct();
    params.intvar = 0;
    displayteamsplash( self.teams[ 0 ], "br_scavenger_quest_timer_expired", params );
    function_e9cfab9c8a63533c( "scavenger_timeout", self.teams[ 0 ], "dx_br_jpbm_" );
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam( "mission_gen_fail", self.teams[ 0 ], 1 );
    thread function_810bbeded8d1a801( 0, undefined, "Time" );
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0x1536
// Size: 0xd9
function function_41c2372f16c0e03d( cacheindex )
{
    cache = self.cachedata[ cacheindex ].cachenode;
    self.cachedata[ cacheindex ].cacheentity = spawnscavengerlootcache( cache.origin, cache.angles );
    self.cachedata[ cacheindex ] createquestobjicon( "ui_mp_br_mapmenu_icon_scavengerhunt_objective", "current" );
    objectiveid = self.cachedata[ cacheindex ].objectiveiconid;
    objective_removeallfrommask( objectiveid );
    objective_onentity( objectiveid, self.cachedata[ cacheindex ].cacheentity );
    objective_setzoffset( objectiveid, 65 );
    thread function_425f0abdafad5a76( objectiveid, self.teams[ 0 ] );
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 7
// Checksum 0x0, Offset: 0x1617
// Size: 0x3cc
function function_4c7a7dd83180de41( nodearr, numnodes, searchorigin, minrange, maxrange, idealminrange, idealmaxrange )
{
    assert( isdefined( nodearr ) && nodearr.size > 0 );
    assert( isdefined( numnodes ) && numnodes > 0 );
    nodes = nodearr;
    bestnodes = [];
    var_72c980f7c0f679d7 = randomfloatrange( idealminrange, idealmaxrange );
    var_fdc6ee1b91ebb7bf = undefined;
    
    if ( !level.br_circle_disabled )
    {
        var_527a7b84d978e792 = scripts\mp\gametypes\br_circle_util::function_60951b84c58915ab( searchorigin );
        var_fdc6ee1b91ebb7bf = scripts\mp\gametypes\br_circle_util::function_7d8550b9a2c52852( var_527a7b84d978e792 );
    }
    
    bestdist = undefined;
    bestnode = undefined;
    bestidx = undefined;
    
    foreach ( idx, node in nodearr )
    {
        dist = abs( distance2d( searchorigin, node.origin ) - var_72c980f7c0f679d7 );
        
        if ( !function_a067541e078900a5( node, searchorigin, dist, minrange, maxrange, var_fdc6ee1b91ebb7bf ) )
        {
            continue;
        }
        
        if ( !isdefined( bestdist ) || dist < bestdist )
        {
            bestdist = dist;
            bestnode = node;
            bestidx = idx;
        }
    }
    
    if ( !isdefined( bestnode ) )
    {
        return undefined;
    }
    
    bestnodes[ 0 ] = bestnode;
    bestnode.inuse = 1;
    disablelootspawnpoint( bestidx );
    
    if ( numnodes == 1 )
    {
        return bestnodes;
    }
    
    var_dd557c73e4c85bc3 = function_f469a8dcf7ffd6a8( searchorigin, bestnode.origin, numnodes );
    var_5d384c5f9eb5fc55 = [];
    
    for ( i = 0; i < numnodes - 1 ; i++ )
    {
        index = i + 1;
        var_5d384c5f9eb5fc55[ i ] = spawnstruct();
        var_5d384c5f9eb5fc55[ i ].index = index;
        var_5d384c5f9eb5fc55[ i ].point = var_dd557c73e4c85bc3[ index ];
        var_5d384c5f9eb5fc55[ i ].bestdist = undefined;
        var_5d384c5f9eb5fc55[ i ].bestnode = undefined;
        var_5d384c5f9eb5fc55[ i ].nodeindex = undefined;
    }
    
    idealdisttolerance = 100;
    
    foreach ( var_ae22245685c483ae in var_5d384c5f9eb5fc55 )
    {
        foreach ( idx, node in nodearr )
        {
            dist = distance2d( var_ae22245685c483ae.point, node.origin );
            
            if ( !function_a067541e078900a5( node, searchorigin, dist, minrange, maxrange, var_fdc6ee1b91ebb7bf ) )
            {
                continue;
            }
            
            if ( !isdefined( var_ae22245685c483ae.bestdist ) || dist < var_ae22245685c483ae.bestdist )
            {
                var_ae22245685c483ae.bestdist = dist;
                var_ae22245685c483ae.bestnode = node;
                var_ae22245685c483ae.nodeindex = idx;
                
                if ( dist <= idealdisttolerance )
                {
                    break;
                }
            }
        }
        
        if ( !isdefined( var_ae22245685c483ae.index ) || !isdefined( var_ae22245685c483ae.bestnode ) )
        {
            return undefined;
        }
        
        bestnodes[ var_ae22245685c483ae.index ] = var_ae22245685c483ae.bestnode;
        var_ae22245685c483ae.bestnode.inuse = 1;
        disablelootspawnpoint( var_ae22245685c483ae.nodeindex );
    }
    
    return bestnodes;
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0x19ec
// Size: 0x334
function function_352ccdc4f9c2b9d1( var_e7577bf01fc2c5c4 )
{
    cachelocations = [];
    nodes = var_e7577bf01fc2c5c4;
    searchorigin = self.tablet.origin;
    var_fdc6ee1b91ebb7bf = undefined;
    
    if ( !isdefined( nodes ) || nodes.size < level.var_cf05afb32024800a.cachespawncount )
    {
        return undefined;
    }
    
    if ( !level.br_circle_disabled )
    {
        var_527a7b84d978e792 = scripts\mp\gametypes\br_circle_util::function_60951b84c58915ab( self.tablet.origin );
        var_fdc6ee1b91ebb7bf = scripts\mp\gametypes\br_circle_util::function_7d8550b9a2c52852( var_527a7b84d978e792 );
    }
    
    for ( i = 0; i < level.var_cf05afb32024800a.cachespawncount ; i++ )
    {
        bestcache = undefined;
        var_33164bb5dd838f17 = level.var_cf05afb32024800a.var_76fbb523b032ed22;
        
        if ( i > 0 && isdefined( var_fdc6ee1b91ebb7bf ) && !istrue( level.var_cf05afb32024800a.var_22ad655f7a3f053 ) )
        {
            var_fdc6ee1b91ebb7bf = scripts\mp\gametypes\br_circle_util::function_7d8550b9a2c52852( cachelocations[ i - 1 ].circletimeline );
        }
        
        foreach ( cache in nodes )
        {
            if ( istrue( cache.inuse ) )
            {
                continue;
            }
            
            dist = distance2d( cache.origin, searchorigin );
            
            if ( function_c096a9a3d859cfce( cache.origin ) )
            {
                continue;
            }
            
            if ( scripts\mp\gametypes\br_bunker_utility::function_5581450b830e0245( cache.origin ) )
            {
                continue;
            }
            
            if ( scripts\mp\locksandkeys::function_64332f29e2409e55( cache.origin ) )
            {
                continue;
            }
            
            if ( namespace_bd614c3c2275579a::function_20a22133815385f8( cache.origin ) )
            {
                continue;
            }
            
            if ( !level.br_circle_disabled )
            {
                if ( !isdefined( cache.circletimeline ) )
                {
                    cache.circletimeline = scripts\mp\gametypes\br_circle_util::function_60951b84c58915ab( cache.origin );
                }
                
                var_28deb7ff62e281d3 = scripts\mp\gametypes\br_circle_util::function_7d8550b9a2c52852( cache.circletimeline );
                
                if ( var_28deb7ff62e281d3 < var_fdc6ee1b91ebb7bf )
                {
                    continue;
                }
                
                if ( var_28deb7ff62e281d3 < var_fdc6ee1b91ebb7bf )
                {
                    continue;
                }
            }
            
            var_5435995e95681b89 = 0;
            
            if ( dist < level.var_cf05afb32024800a.var_b90dc65a569f4825 )
            {
                if ( dist < level.var_cf05afb32024800a.var_7f34783fc18f8a33 )
                {
                    var_5435995e95681b89 = level.var_cf05afb32024800a.var_7f34783fc18f8a33 - dist;
                }
            }
            else
            {
                var_5435995e95681b89 = dist - level.var_cf05afb32024800a.var_b90dc65a569f4825;
            }
            
            if ( var_5435995e95681b89 < var_33164bb5dd838f17 )
            {
                if ( namespace_9823ee6035594d67::function_ae011f52b2b15baf( cache.origin, 0 ) )
                {
                    continue;
                }
                
                var_33164bb5dd838f17 = var_5435995e95681b89;
                bestcache = cache;
                
                if ( var_5435995e95681b89 <= 0 )
                {
                    break;
                }
            }
        }
        
        if ( !isdefined( bestcache ) )
        {
            return undefined;
        }
        
        bestcache.inuse = 1;
        cachelocations[ i ] = bestcache;
        searchorigin = bestcache.origin;
    }
    
    return cachelocations;
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 6
// Checksum 0x0, Offset: 0x1d29
// Size: 0x120, Type: bool
function function_a067541e078900a5( node, origin, dist, minrange, maxrange, var_fdc6ee1b91ebb7bf )
{
    if ( istrue( node.inuse ) )
    {
        return false;
    }
    
    if ( dist < minrange || dist > maxrange )
    {
        return false;
    }
    
    if ( namespace_9823ee6035594d67::function_f0201365c368cf88( node.origin ) )
    {
        return false;
    }
    
    if ( function_c096a9a3d859cfce( node.origin ) )
    {
        return false;
    }
    
    if ( scripts\mp\gametypes\br_bunker_utility::function_5581450b830e0245( node.origin ) )
    {
        return false;
    }
    
    if ( scripts\mp\locksandkeys::function_64332f29e2409e55( node.origin ) )
    {
        return false;
    }
    
    if ( namespace_bd614c3c2275579a::function_20a22133815385f8( node.origin ) )
    {
        return false;
    }
    
    if ( !level.br_circle_disabled )
    {
        circletimeline = scripts\mp\gametypes\br_circle_util::function_60951b84c58915ab( node.origin );
        var_28deb7ff62e281d3 = scripts\mp\gametypes\br_circle_util::function_7d8550b9a2c52852( circletimeline );
        
        if ( var_28deb7ff62e281d3 < var_fdc6ee1b91ebb7bf )
        {
            return false;
        }
        
        traveltime = dist / 190;
        
        if ( var_28deb7ff62e281d3 < var_fdc6ee1b91ebb7bf + traveltime )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0x1e52
// Size: 0x82, Type: bool
function function_c096a9a3d859cfce( v_origin )
{
    if ( isdefined( level.var_5beadbb1ee3ac8c ) && level.var_5beadbb1ee3ac8c.size > 0 )
    {
        foreach ( exclusionvolume in level.var_5beadbb1ee3ac8c )
        {
            if ( ispointinvolume( v_origin, exclusionvolume ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 3
// Checksum 0x0, Offset: 0x1edd
// Size: 0x11e
function function_f469a8dcf7ffd6a8( originpoint, point1, numpoints )
{
    points = [];
    points[ 0 ] = point1;
    radius = distance2d( originpoint, point1 );
    rotangle = 360 / numpoints;
    var_423b19ada56f4ad = [];
    var_423b19ada56f4ad[ 0 ] = ( point1[ 0 ] - originpoint[ 0 ], point1[ 1 ] - originpoint[ 1 ], 0 );
    
    for ( i = 1; i < numpoints ; i++ )
    {
        cpoint = points[ i - 1 ];
        xtemp = cpoint[ 0 ] - originpoint[ 0 ];
        ytemp = cpoint[ 1 ] - originpoint[ 1 ];
        x = xtemp * cos( rotangle ) - ytemp * sin( rotangle );
        y = ytemp * cos( rotangle ) + xtemp * sin( rotangle );
        var_423b19ada56f4ad[ var_423b19ada56f4ad.size ] = ( x, y, 0 );
        x += originpoint[ 0 ];
        y += originpoint[ 1 ];
        points[ points.size ] = ( x, y, 0 );
    }
    
    return points;
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 0
// Checksum 0x0, Offset: 0x2004
// Size: 0x105
function function_9f225e14bff0629f()
{
    locations = getunusedlootcachepoints( self.tablet.origin, level.var_cf05afb32024800a.var_76fbb523b032ed22, level.var_cf05afb32024800a.var_5e8448f4b9e71cb4, 1 );
    
    if ( locations.size <= level.var_cf05afb32024800a.cachespawncount )
    {
        return undefined;
    }
    
    if ( istrue( level.var_cf05afb32024800a.var_e996476e5ec51e64 ) )
    {
        return function_4c7a7dd83180de41( locations, level.var_cf05afb32024800a.cachespawncount, self.tablet.origin, level.var_cf05afb32024800a.var_5e8448f4b9e71cb4, level.var_cf05afb32024800a.var_76fbb523b032ed22, level.var_cf05afb32024800a.var_7f34783fc18f8a33, level.var_cf05afb32024800a.var_b90dc65a569f4825 );
    }
    
    return function_352ccdc4f9c2b9d1( locations );
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0x2111
// Size: 0x7c
function function_17e600057c2cf45( player )
{
    foreach ( cacheobj in self.cachedata )
    {
        if ( isdefined( cacheobj.objectiveiconid ) )
        {
            cacheobj showquestobjicontoplayer( player );
        }
    }
    
    player uiobjectiveshow( "scavenger" );
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0x2195
// Size: 0x77
function hidescavengerhudfromplayer( player )
{
    foreach ( cacheobj in self.cachedata )
    {
        if ( isdefined( cacheobj.objectiveiconid ) )
        {
            cacheobj hidequestobjiconfromplayer( player );
        }
    }
    
    player uiobjectivehide();
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 0
// Checksum 0x0, Offset: 0x2214
// Size: 0xc4
function deletescavengerhud()
{
    foreach ( player in getteamdata( self.teams[ 0 ], "players" ) )
    {
        hidescavengerhudfromplayer( player );
    }
    
    foreach ( cacheobj in self.cachedata )
    {
        if ( isdefined( cacheobj.objectiveiconid ) )
        {
            cacheobj deletequestobjicon();
        }
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0x22e0
// Size: 0x40
function function_f46a4deefd8ceaf4( volume )
{
    if ( !isdefined( level.var_5beadbb1ee3ac8c ) )
    {
        level.var_5beadbb1ee3ac8c = [];
    }
    
    if ( isdefined( volume ) )
    {
        level.var_5beadbb1ee3ac8c = array_add( level.var_5beadbb1ee3ac8c, volume );
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0x2328
// Size: 0x42
function function_12b3eb979ce7c6e5( volumes )
{
    if ( !isdefined( level.var_5beadbb1ee3ac8c ) )
    {
        level.var_5beadbb1ee3ac8c = [];
    }
    
    if ( volumes.size > 0 )
    {
        level.var_5beadbb1ee3ac8c = array_combine( level.var_5beadbb1ee3ac8c, volumes );
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 2
// Checksum 0x0, Offset: 0x2372
// Size: 0x6b
function spawnscavengerlootcache( inorigin, var_5b9c864b21207ff6 )
{
    cacheentity = spawn( "script_model", inorigin );
    cacheentity.angles = var_5b9c864b21207ff6;
    cacheentity setmodel( "military_loot_crate_01_br_scavenger_01" );
    cacheentity setscriptablepartstate( "body", "scavenger_closed" );
    cacheentity.task = self;
    thread function_94a078c4cae0d6a4( cacheentity );
    return cacheentity;
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 1
// Checksum 0x0, Offset: 0x23e6
// Size: 0x13b
function function_94a078c4cae0d6a4( cacheentity )
{
    self endon( "task_ended" );
    level endon( "game_ended" );
    cacheentity endon( "death" );
    
    while ( true )
    {
        var_2d2ec9d4e2f20c1d = getteamdata( self.teams[ 0 ], "players" );
        var_7f599accb72658d1 = undefined;
        
        foreach ( player in var_2d2ec9d4e2f20c1d )
        {
            if ( isdefined( player ) )
            {
                var_7f599accb72658d1 = player;
                break;
            }
        }
        
        cacheentity setotherent( var_7f599accb72658d1 );
        
        foreach ( player in level.players )
        {
            if ( var_7f599accb72658d1.team == "none" || player.team != var_7f599accb72658d1.team )
            {
                cacheentity disablescriptableplayeruse( player );
                continue;
            }
            
            cacheentity enablescriptableplayeruse( player );
        }
        
        var_7f599accb72658d1 waittill( "disconnect" );
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 6
// Checksum 0x0, Offset: 0x2529
// Size: 0x774
function scavengerlootcacheused( instance, part, state, player, bautouse, usestring )
{
    if ( istrue( player scripts\mp\gametypes\br_gametypes::runbrgametypefunc( "playerSkipLootPickup", instance ) ) )
    {
        return;
    }
    
    assert( part == "<dev string:x1c>" );
    
    if ( state == "scavenger_closed" && isdefined( instance.entity ) )
    {
        task = instance.entity.task;
        player scripts\cp_mp\challenges::function_da9003df08944b01( instance );
        
        if ( player.team != task.teams[ 0 ] )
        {
            player iprintlnbold( "Chest Requires a Scavenger Mission" );
            return;
        }
        
        instance setscriptablepartstate( "body", "scavenger_opening" );
        var_c0858aceea4bb7d9 = getdvarint( @"hash_28b9017071772839", 30 );
        instance.entity scripts\engine\utility::delaycallendon( var_c0858aceea4bb7d9, "death_or_disconnect", &delete );
        
        if ( !isdefined( task.cachescollected ) || task.cachescollected == 0 )
        {
            items = getscriptcachecontents( "br_quest_scav_one", level.var_cf05afb32024800a.var_fb4d6eb8dfba5101 );
            level.var_cf05afb32024800a.var_fb4d6eb8dfba5101 += 1;
            
            if ( level.var_cf05afb32024800a.var_fb4d6eb8dfba5101 >= level.var_cf05afb32024800a.var_5002f454a54ce59b )
            {
                level.var_cf05afb32024800a.var_fb4d6eb8dfba5101 = 0;
            }
        }
        else if ( task.cachescollected == 1 )
        {
            items = getscriptcachecontents( "br_quest_scav_two", level.var_cf05afb32024800a.var_d2a5b681ce9a712f );
            level.var_cf05afb32024800a.var_d2a5b681ce9a712f += 1;
            
            if ( level.var_cf05afb32024800a.var_d2a5b681ce9a712f >= level.var_cf05afb32024800a.var_5002f454a54ce59b )
            {
                level.var_cf05afb32024800a.var_d2a5b681ce9a712f = 0;
            }
        }
        else
        {
            items = getscriptcachecontents( "br_quest_scav_three", level.var_cf05afb32024800a.var_f0f6abdb0f9df01 );
            level.var_cf05afb32024800a.var_f0f6abdb0f9df01 += 1;
            
            if ( level.var_cf05afb32024800a.var_f0f6abdb0f9df01 >= level.var_cf05afb32024800a.var_5002f454a54ce59b )
            {
                level.var_cf05afb32024800a.var_f0f6abdb0f9df01 = 0;
            }
        }
        
        assertex( isdefined( items ) && items.size > 0, "<dev string:x24>" + "<dev string:x88>" + "<dev string:x9d>" + "<dev string:xa2>" + "<dev string:x9d>" + "<dev string:xb7>" );
        
        if ( isdefined( items ) )
        {
            dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
            dropinfo = spawnstruct();
            dropinfo.origin = instance.origin;
            dropinfo.angles = instance.angles;
            dropinfo.itemsdropped = 0;
            var_605079299d001231 = dropinfo scripts\mp\gametypes\br_lootcache::lootspawnitemlist( dropstruct, items, 1 );
            
            foreach ( item in var_605079299d001231 )
            {
                item.team = player.team;
            }
        }
        
        if ( !isdefined( task ) || istrue( task.ended ) )
        {
            return;
        }
        
        players = getteamdata( task.teams[ 0 ], "players" );
        task.cachescollected++;
        
        if ( task.cachescollected < level.var_cf05afb32024800a.cachespawncount )
        {
            displaysquadmessagetoteam( task.teams[ 0 ], player, 7, getquestindex( "scavenger" ) );
            
            if ( level.var_cf05afb32024800a.var_597c27bd871980d )
            {
                time = task function_f69c3e487b364f2f( level.var_cf05afb32024800a.timebonus );
                task function_5606274c76b4a2df( time );
            }
            
            var_8ff7906ac676e086 = undefined;
            
            if ( task.cachescollected == 1 )
            {
                function_e9cfab9c8a63533c( "scavenger_onesecured", task.teams[ 0 ] );
            }
            else if ( task.cachescollected == 2 )
            {
                function_e9cfab9c8a63533c( "scavenger_twosecured", task.teams[ 0 ] );
            }
            
            foreach ( cacheobj in task.cachedata )
            {
                if ( isdefined( cacheobj.cacheentity ) && cacheobj.cacheentity == instance.entity )
                {
                    var_8ff7906ac676e086 = cacheobj;
                }
            }
            
            assert( isdefined( var_8ff7906ac676e086 ) );
            var_8ff7906ac676e086.collected = 1;
            var_8ff7906ac676e086 deletequestobjicon();
            var_8ff7906ac676e086.objectiveiconid = undefined;
            
            if ( !level.var_cf05afb32024800a.var_22ad655f7a3f053 )
            {
                task function_41c2372f16c0e03d( task.cachescollected );
            }
        }
        else
        {
            displaysquadmessagetoteam( task.teams[ 0 ], player, 8, getquestindex( "scavenger" ) );
            function_e9cfab9c8a63533c( "scavenger_missioncomplete", task.teams[ 0 ] );
            finishcontract( task, instance );
        }
        
        foreach ( player in players )
        {
            player uiobjectivesetparameter( task.cachescollected );
        }
        
        task function_e2aa45e2c6b5dec1( task.cachescollected );
        
        if ( !isdefined( instance.origin ) )
        {
            scripts\mp\utility\script::demoforcesre( "IW9-638849: player.origin = " + player.origin + ", cacheState = " + state );
        }
        
        level notify( "lootcache_opened_kill_callout" + instance.origin );
        assert( issharedfuncdefined( "<dev string:xce>", "<dev string:xd6>" ) );
        playersquad = [[ getsharedfunc( "game", "getFriendlyPlayers" ) ]]( player.team, 0 );
        
        foreach ( teammate in playersquad )
        {
            teammate notify( "calloutmarkerping_warzoneKillQuestIcon" );
        }
    }
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 3
// Checksum 0x0, Offset: 0x2ca5
// Size: 0xa9
function function_a93228cdda5c958c( contract, instance, team )
{
    rewards = function_d212a5e7a40d7c8d( "scavenger", contract.teams[ 0 ], instance, contract );
    
    if ( !scripts\mp\gametypes\br_public::istutorial() )
    {
        if ( isdefined( rewards ) && isdefined( rewards[ "plunder" ] ) )
        {
            splashref = contract function_4bcd7c36b22b9bec( "br_scavenger_quest_complete" );
            function_878ebcc241b54505( splashref, function_3d262d56274bd22e( "scavenger" ), rewards[ "plunder" ], contract.teams[ 0 ] );
        }
    }
    
    contract thread function_810bbeded8d1a801( 1, rewards, "Win" );
}

// Namespace br_scavenger_quest / scripts\mp\gametypes\br_scavenger_quest
// Params 3
// Checksum 0x0, Offset: 0x2d56
// Size: 0x51
function function_e9cfab9c8a63533c( dialog, team, prefixoverride )
{
    sound_name = game[ "dialog" ][ dialog ];
    assertex( isdefined( sound_name ), "<dev string:xec>" + dialog );
    scripts\mp\gametypes\br_public::brleaderdialogteam( dialog, team, 1, 2, undefined, prefixoverride );
}

