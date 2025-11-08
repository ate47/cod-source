#using script_41ba451876d0900c;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\pmc_missions;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\game;

#namespace poi;

// Namespace poi / scripts\mp\poi
// Params 0
// Checksum 0x0, Offset: 0x50a
// Size: 0x2e1
function poi_init()
{
    flag_init( "poi_initialized" );
    
    if ( getdvarint( @"hash_2cc531e644d4fdb3", 1 ) == 0 )
    {
        return;
    }
    
    level.var_b0eae20487331106 = getdvarint( @"scr_poi_disable_all", 0 );
    level.var_d35175ec20b444c = getdvarint( @"hash_ad89f1c2b195eda2", 120 ) * 1000;
    level.poi = [];
    level.var_ab20b3a256911579 = [];
    level.var_a09459a429deb934 = [];
    
    if ( !isdefined( level.poi_names ) )
    {
        level.poi_names = [];
    }
    
    var_36d912f3404efa8e = getdvarint( @"hash_7e7742c1722382ad", 1 );
    
    if ( var_36d912f3404efa8e )
    {
        var_d27e5efe115c3af6 = function_af945a8525e5b3bb();
        var_3683bdd8902109b0 = "mp/compass_regions/" + "compassregions_poi_regions_" + level.mapname + ".csv";
        var_d8c79ee51c9021b6 = "mp/compass_regions/" + "compassregions_poi_regions_" + level.mapname + "_" + var_d27e5efe115c3af6 + ".csv";
        compassregions_loadconfig( var_d8c79ee51c9021b6, var_3683bdd8902109b0, 1 );
    }
    
    function_c916e503ca7fd810();
    function_86cc972493600938();
    script_func( "pois_found" );
    
    if ( istrue( level.var_6df475909ffb403d ) && isdefined( level.var_bedc3454dfa5e84f ) )
    {
        [[ level.var_bedc3454dfa5e84f ]]();
    }
    
    level.var_9f0a2752e6e5371a = var_36d912f3404efa8e && compassregions_configloaded( 1 );
    
    if ( level.var_9f0a2752e6e5371a )
    {
        function_6e049f322172e1d5();
    }
    else
    {
        function_c916e503ca7fd810();
        function_86cc972493600938();
    }
    
    if ( !isdefined( level.poi_names ) )
    {
        return;
    }
    
    poidefaultstate = 1;
    
    if ( istrue( level.var_b0eae20487331106 ) )
    {
        poidefaultstate = 0;
    }
    
    foreach ( poiname in level.poi_names )
    {
        dvarhash = hashcat( @"poi_", poiname );
        
        if ( getdvarint( dvarhash, poidefaultstate ) == 0 )
        {
            level.var_ab20b3a256911579[ level.var_ab20b3a256911579.size ] = poiname;
        }
        
        function_3d397c9451f80077( poiname );
    }
    
    if ( level.var_9f0a2752e6e5371a )
    {
        function_b5c7469e80b1e8bd();
        function_9a051b4df049e90b();
    }
    else
    {
        function_1698577d68385123();
        function_f1894e1c6faff01();
    }
    
    level thread function_52cb931e1834f98b();
    scripts\engine\utility::registersharedfunc( "poi", "poi_isPOIActive", &poi_ispoiactive );
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback( &function_fc5d5824570e8c21 );
    function_68f5d2342ad95772();
    function_683e582efd2a8233();
    script_func( "pois_init" );
    flag_set( "poi_initialized" );
    registersharedfunc( "poi", "get_poi_name_from_origin", &poi_findPOIOriginIsIn );
}

// Namespace poi / scripts\mp\poi
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x7f3
// Size: 0x28e
function private function_c916e503ca7fd810()
{
    level.poi_volumes = [];
    poivolumes = [];
    
    foreach ( volume in getentarray( "trigger_multiple", "code_classname" ) )
    {
        if ( isdefined( volume.targetname ) && issubstr( volume.targetname, "poi_trigger_" ) )
        {
            poivolumes[ poivolumes.size ] = volume;
        }
    }
    
    foreach ( volume in getnoentvolumearray( "noent_volume_trigger", "classname" ) )
    {
        if ( isdefined( volume.targetname ) && issubstr( volume.targetname, "poi_trigger_" ) )
        {
            poivolumes[ poivolumes.size ] = volume;
        }
    }
    
    foreach ( volume in getnoentvolumearray( "noent_volume_info", "classname" ) )
    {
        if ( isdefined( volume.targetname ) && issubstr( volume.targetname, "poi_trigger_" ) )
        {
            poivolumes[ poivolumes.size ] = volume;
        }
    }
    
    if ( isdefined( poivolumes ) && poivolumes.size > 0 )
    {
        foreach ( volume in poivolumes )
        {
            poiname = tolower( getsubstr( volume.targetname, 12 ) );
            
            if ( !isdefined( level.poi_names ) )
            {
                level.poi_names = [];
            }
            
            volume.poi = poiname;
            
            if ( !array_contains( level.poi_names, poiname ) )
            {
                level.poi_names[ level.poi_names.size ] = poiname;
                level.poi_volumes[ poiname ] = volume;
                continue;
            }
            
            if ( !isdefined( level.var_ff89a1714af44c4e ) )
            {
                level.var_ff89a1714af44c4e = [];
            }
            
            level.var_ff89a1714af44c4e[ poiname ] = level.poi_volumes[ poiname ];
            level.poi_volumes[ poiname ] = volume;
        }
    }
}

// Namespace poi / scripts\mp\poi
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xa89
// Size: 0x146
function private function_86cc972493600938()
{
    level.poi_origins = [];
    
    if ( isdefined( level.poi_volumes ) && level.poi_volumes.size > 0 )
    {
        foreach ( poiname, volume in level.poi_volumes )
        {
            level.poi_origins[ poiname ] = volume.origin;
        }
        
        return;
    }
    
    poiorigins = [];
    poiorigins[ "saba_hydro" ] = ( -8968, 8225, 772 );
    poiorigins[ "saba_oilfield" ] = ( -23684, 21737, 436 );
    poiorigins[ "saba_fort" ] = ( 18357, -54628, 2270 );
    poiorigins[ "saba_exhume" ] = ( -49193, 14284, 1674 );
    
    foreach ( poiname in level.poi_names )
    {
        if ( isdefined( poiorigins[ poiname ] ) )
        {
            level.poi_origins[ poiname ] = poiorigins[ poiname ];
        }
    }
}

// Namespace poi / scripts\mp\poi
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xbd7
// Size: 0x94
function private function_84291fc4abf2c2d()
{
    foreach ( poiname, poi in level.poi )
    {
        var_29260d0089df816 = spawnstruct();
        var_29260d0089df816.poiname = poiname;
        var_29260d0089df816.var_71ad22c5d093d90b = "orphan";
        function_d0e7647e5538eb9d( poiname, "subAreas", var_29260d0089df816, var_29260d0089df816.var_71ad22c5d093d90b );
    }
}

// Namespace poi / scripts\mp\poi
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xc73
// Size: 0xd8
function private function_28bfdfbf2b7b36c2()
{
    foreach ( poi in level.poi )
    {
        if ( !isdefined( poi[ "subAreas" ] ) )
        {
            continue;
        }
        
        foreach ( subarea in poi[ "subAreas" ] )
        {
            subarea.var_3ebb6024e3f220ca = [];
            subarea.agentdeaths = 0;
            subarea.var_d276b08c96430bfc = [];
            subarea.var_24a2cd19eed8f75d = [];
        }
    }
}

// Namespace poi / scripts\mp\poi
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xd53
// Size: 0x259
function private function_1698577d68385123()
{
    ents = array_combine( getentarray( "trigger_multiple", "classname" ), getnoentvolumearray( "noent_volume_trigger", "classname" ), getnoentvolumearray( "noent_volume_info", "classname" ) );
    temptriggers = [];
    function_44739fe1cf82e29a( "subAreas" );
    
    foreach ( ent in ents )
    {
        if ( isdefined( ent.script_noteworthy ) && issubstr( ent.script_noteworthy, "subarea_" ) )
        {
            struct = spawnstruct();
            struct.trigger = ent;
            var_84a8c10c861d7ce0 = "saba_";
            
            if ( isdefined( level.var_4d8386eca283e9c4 ) )
            {
                var_84a8c10c861d7ce0 = level.var_4d8386eca283e9c4;
            }
            
            tokens = strtok( ent.script_noteworthy, "_" );
            poiname = var_84a8c10c861d7ce0 + tolower( string_join( array_slice( tokens, 1, tokens.size - 1 ), "_" ) );
            startindexoffset = tokens[ 0 ].size + tokens[ 1 ].size + 2;
            
            if ( issubstr( ent.script_noteworthy, "suburb_" ) || issubstr( ent.script_noteworthy, "suburbs_" ) )
            {
                startindexoffset = tokens[ 0 ].size + tokens[ 1 ].size + tokens[ 2 ].size + 3;
            }
            
            struct.var_71ad22c5d093d90b = tolower( getsubstr( ent.script_noteworthy, startindexoffset ) );
            struct.poi = poiname;
            
            foreach ( poinamekey, poi in level.poi )
            {
                if ( issubstr( poinamekey, poiname ) )
                {
                    function_d0e7647e5538eb9d( poinamekey, "subAreas", struct, struct.var_71ad22c5d093d90b );
                }
            }
        }
    }
    
    function_84291fc4abf2c2d();
    function_28bfdfbf2b7b36c2();
}

// Namespace poi / scripts\mp\poi
// Params 1
// Checksum 0x0, Offset: 0xfb4
// Size: 0x82
function function_985798a13250c99a( poiname )
{
    poiindex = undefined;
    
    if ( level.var_9f0a2752e6e5371a )
    {
        poiindex = level.poi_regions[ poiname ];
    }
    else
    {
        poiindex = tablelookup( "mp/map_callouts/" + level.mapname + "_callouts.csv", 1, poiname, 0 );
        
        if ( isdefined( poiindex ) && poiindex != "" )
        {
            poiindex = int( poiindex );
        }
        else
        {
            poiindex = array_find( level.poi_names, poiname );
        }
    }
    
    return poiindex;
}

// Namespace poi / scripts\mp\poi
// Params 1
// Checksum 0x0, Offset: 0x103f
// Size: 0x15
function function_f9340f4b7f231bc1( poiindexes )
{
    level.poiindexes = poiindexes;
}

// Namespace poi / scripts\mp\poi
// Params 1
// Checksum 0x0, Offset: 0x105c
// Size: 0x37
function function_80cdaea4bd3ecf70( poiname )
{
    var_d455648308e34f3f = 0;
    
    if ( isdefined( poiname ) )
    {
        potentialindex = function_985798a13250c99a( poiname );
        
        if ( isdefined( potentialindex ) )
        {
            var_d455648308e34f3f = potentialindex;
        }
    }
    
    return var_d455648308e34f3f;
}

// Namespace poi / scripts\mp\poi
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x109c
// Size: 0x151
function private function_f1894e1c6faff01()
{
    if ( !isdefined( level.poi_volumes ) )
    {
        return;
    }
    
    if ( istrue( level.var_f257b1e13dcc1bad ) )
    {
        return;
    }
    
    foreach ( pname in level.poi_names )
    {
        if ( !isdefined( level.poi[ pname ] ) )
        {
            continue;
        }
        
        level.poi[ pname ][ "otherPoiByDist" ] = [];
        curorigin = level.poi_origins[ pname ];
        var_b75d6c3b38c167d9 = sortbydistance( level.poi_volumes, curorigin );
        
        foreach ( volume in var_b75d6c3b38c167d9 )
        {
            if ( array_contains_key( level.poi, volume.poi ) )
            {
                level.poi[ pname ][ "otherPoiByDist" ][ level.poi[ pname ][ "otherPoiByDist" ].size ] = volume.poi;
            }
        }
    }
}

// Namespace poi / scripts\mp\poi
// Params 1
// Checksum 0x0, Offset: 0x11f5
// Size: 0x84
function function_3d397c9451f80077( poiname )
{
    if ( !poi_isSystemActive() )
    {
        return;
    }
    
    if ( isdefined( level.poi[ poiname ] ) )
    {
        return level.poi[ poiname ];
    }
    
    if ( !poi_ispoiactive( poiname ) )
    {
        return;
    }
    
    level.poi[ poiname ] = function_183a2f183e4a605b();
    level.poi[ poiname ][ "name" ] = poiname;
    level.poi[ poiname ][ "calloutIndex" ] = function_985798a13250c99a( poiname );
    return level.poi[ poiname ];
}

// Namespace poi / scripts\mp\poi
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1282
// Size: 0x6c
function private function_183a2f183e4a605b( poi )
{
    if ( !isdefined( poi ) )
    {
        poi = [];
    }
    
    foreach ( featurename in level.var_a09459a429deb934 )
    {
        if ( !isdefined( poi[ featurename ] ) )
        {
            poi[ featurename ] = [];
        }
    }
    
    return poi;
}

// Namespace poi / scripts\mp\poi
// Params 1
// Checksum 0x0, Offset: 0x12f7
// Size: 0x9d
function function_44739fe1cf82e29a( featurename )
{
    if ( !poi_isSystemActive() )
    {
        return;
    }
    
    if ( !array_contains( level.var_a09459a429deb934, featurename ) )
    {
        level.var_a09459a429deb934[ level.var_a09459a429deb934.size ] = featurename;
    }
    
    foreach ( index, poi in level.poi )
    {
        level.poi[ index ] = function_183a2f183e4a605b( poi );
    }
}

// Namespace poi / scripts\mp\poi
// Params 2
// Checksum 0x0, Offset: 0x139c
// Size: 0x4b
function function_1af8a41e4c1252c7( poiname, featurename )
{
    if ( !poi_isSystemActive() )
    {
        return;
    }
    
    if ( !isdefined( poiname ) || !isdefined( featurename ) )
    {
        return;
    }
    
    if ( !array_contains( level.var_a09459a429deb934, featurename ) )
    {
        return;
    }
    
    return level.poi[ poiname ][ featurename ];
}

// Namespace poi / scripts\mp\poi
// Params 4
// Checksum 0x0, Offset: 0x13f0
// Size: 0xde
function function_d0e7647e5538eb9d( poiname, featurename, arrayelement, customkey )
{
    if ( !poi_isSystemActive() )
    {
        return;
    }
    
    if ( !isdefined( poiname ) )
    {
        return;
    }
    
    if ( !poi_ispoiactive( poiname ) )
    {
        return;
    }
    
    if ( !isdefined( level.poi[ poiname ] ) )
    {
        return;
    }
    
    if ( isdefined( customkey ) )
    {
        level.poi[ poiname ][ featurename ][ customkey ] = arrayelement;
    }
    else
    {
        level.poi[ poiname ][ featurename ][ level.poi[ poiname ][ featurename ].size ] = arrayelement;
    }
    
    if ( isdefined( arrayelement.origin ) )
    {
        subarea = subArea_findFromOrigin( arrayelement.origin, poiname );
        
        if ( isdefined( subarea ) && isdefined( subarea.var_71ad22c5d093d90b ) )
        {
            arrayelement.var_71ad22c5d093d90b = subarea.var_71ad22c5d093d90b;
        }
    }
}

// Namespace poi / scripts\mp\poi
// Params 1
// Checksum 0x0, Offset: 0x14d6
// Size: 0x2b
function poi_getorigin( poiname )
{
    if ( isdefined( poiname ) && isdefined( level.poi_origins ) )
    {
        return level.poi_origins[ poiname ];
    }
    
    return undefined;
}

// Namespace poi / scripts\mp\poi
// Params 1
// Checksum 0x0, Offset: 0x150a
// Size: 0x6f
function function_ab3b7f9663bc2e89( subarea )
{
    origin = undefined;
    
    if ( isdefined( subarea ) )
    {
        if ( level.var_9f0a2752e6e5371a )
        {
            if ( isdefined( subarea.origin ) )
            {
                origin = subarea.origin;
            }
        }
        else if ( isdefined( subarea.trigger ) )
        {
            origin = subarea.trigger.origin;
        }
    }
    
    return origin;
}

// Namespace poi / scripts\mp\poi
// Params 1
// Checksum 0x0, Offset: 0x1582
// Size: 0x45, Type: bool
function function_9c93e67f90980177( origin )
{
    poi = poi_findPOIOriginIsIn( origin, 1 );
    return isdefined( poi ) && ( !isdefined( level.var_ab20b3a256911579 ) || !array_contains( level.var_ab20b3a256911579, poi ) );
}

// Namespace poi / scripts\mp\poi
// Params 4
// Checksum 0x0, Offset: 0x15d0
// Size: 0x8b
function poi_findPOIOriginIsIn( origin, var_b0068b35c79ea7fa, var_9d9d80abb79138bb, var_db259b7e9331b0a0 )
{
    poiname = undefined;
    
    if ( !poi_isSystemActive() )
    {
        return poiname;
    }
    
    if ( level.var_9f0a2752e6e5371a )
    {
        siteidx = compassregions_getsiteforworldorigin( 1, origin );
        
        if ( isdefined( siteidx ) )
        {
            poiname = level.poi_sites[ siteidx ];
        }
    }
    else
    {
        poiname = function_1cbc1b619b924e7a( origin, var_b0068b35c79ea7fa, var_db259b7e9331b0a0 );
    }
    
    if ( !isdefined( poiname ) )
    {
        poiname = function_55cf921efa4cbd09( origin, var_b0068b35c79ea7fa, var_9d9d80abb79138bb, var_db259b7e9331b0a0 );
    }
    
    return poiname;
}

// Namespace poi / scripts\mp\poi
// Params 2
// Checksum 0x0, Offset: 0x1664
// Size: 0x125
function function_d795b532bedd6431( poiname, origin )
{
    if ( level.var_9f0a2752e6e5371a )
    {
        var_9dc07c2ea03a5012 = compassregions_getsiteforworldorigin( 2, origin );
        
        foreach ( subarea in level.poi[ poiname ][ "subAreas" ] )
        {
            if ( isdefined( subarea.site ) && isdefined( var_9dc07c2ea03a5012 ) && var_9dc07c2ea03a5012 == subarea.site )
            {
                return subarea;
            }
        }
    }
    else
    {
        foreach ( subarea in level.poi[ poiname ][ "subAreas" ] )
        {
            if ( isdefined( subarea.trigger ) && ispointinvolume( origin, subarea.trigger ) )
            {
                return subarea;
            }
        }
    }
    
    return undefined;
}

// Namespace poi / scripts\mp\poi
// Params 1
// Checksum 0x0, Offset: 0x1792
// Size: 0x65
function function_150af7f3a2874667( poiname )
{
    if ( level.var_9f0a2752e6e5371a )
    {
        assert( isdefined( level.poi_regions ) );
        var_9690281e1623b6ae = level.poi_regions[ poiname ];
        
        if ( isdefined( var_9690281e1623b6ae ) )
        {
            poiregion = compassregions_getregion( 1, var_9690281e1623b6ae );
            return poiregion.name;
        }
    }
    
    return poiname;
}

// Namespace poi / scripts\mp\poi
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x1800
// Size: 0x106
function private function_1cbc1b619b924e7a( origin, var_b0068b35c79ea7fa, var_9d9d80abb79138bb, var_db259b7e9331b0a0 )
{
    if ( !poi_isSystemActive() )
    {
        return undefined;
    }
    
    if ( !isdefined( var_b0068b35c79ea7fa ) )
    {
        var_b0068b35c79ea7fa = 0;
    }
    
    if ( !isdefined( var_9d9d80abb79138bb ) )
    {
        var_9d9d80abb79138bb = 1;
    }
    
    if ( !isdefined( var_db259b7e9331b0a0 ) )
    {
        var_db259b7e9331b0a0 = 0;
    }
    
    pois = ter_op( var_b0068b35c79ea7fa, level.poi_names, getarraykeys( level.poi ) );
    
    foreach ( poiname in pois )
    {
        if ( !var_9d9d80abb79138bb && issubstr( poiname, "suburb" ) )
        {
            continue;
        }
        
        if ( var_db259b7e9331b0a0 && !isdefined( level.poi[ poiname ][ "calloutIndex" ] ) )
        {
            continue;
        }
        
        if ( isdefined( level.poi_volumes[ poiname ] ) )
        {
            if ( function_7e8fc13f3d0d5c87( origin, poiname ) )
            {
                return poiname;
            }
        }
    }
}

// Namespace poi / scripts\mp\poi
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x190e
// Size: 0x8a
function private function_7e8fc13f3d0d5c87( origin, poiname )
{
    if ( poi_isSystemActive() )
    {
        var_6e80031ce7163196 = isdefined( level.poi_volumes[ poiname ] ) && ispointinvolume( origin, level.poi_volumes[ poiname ] );
        var_dd4dff0b187cb059 = isdefined( level.var_ff89a1714af44c4e ) && isdefined( level.var_ff89a1714af44c4e[ poiname ] ) && ispointinvolume( origin, level.var_ff89a1714af44c4e[ poiname ] );
        return ( var_6e80031ce7163196 || var_dd4dff0b187cb059 );
    }
    
    return undefined;
}

// Namespace poi / scripts\mp\poi
// Params 4
// Checksum 0x0, Offset: 0x19a1
// Size: 0x14c
function function_55cf921efa4cbd09( origin, var_b0068b35c79ea7fa, var_9d9d80abb79138bb, var_db259b7e9331b0a0 )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    if ( poi_isSystemActive() )
    {
        var_574b367a589e1f37 = undefined;
        var_ea5672010d764ebc = undefined;
        
        if ( !isdefined( var_b0068b35c79ea7fa ) )
        {
            var_b0068b35c79ea7fa = 0;
        }
        
        if ( !isdefined( var_9d9d80abb79138bb ) )
        {
            var_9d9d80abb79138bb = 1;
        }
        
        if ( !isdefined( var_db259b7e9331b0a0 ) )
        {
            var_db259b7e9331b0a0 = 0;
        }
        
        pois = ter_op( var_b0068b35c79ea7fa, level.poi_names, getarraykeys( level.poi ) );
        
        foreach ( poiname in pois )
        {
            if ( !var_9d9d80abb79138bb && issubstr( poiname, "suburb" ) )
            {
                continue;
            }
            
            if ( !isdefined( level.poi_origins[ poiname ] ) )
            {
                continue;
            }
            
            if ( var_db259b7e9331b0a0 && !isdefined( level.poi[ poiname ][ "calloutIndex" ] ) )
            {
                continue;
            }
            
            dist = distance2dsquared( level.poi_origins[ poiname ], origin );
            
            if ( !isdefined( var_ea5672010d764ebc ) || dist < var_ea5672010d764ebc )
            {
                var_574b367a589e1f37 = poiname;
                var_ea5672010d764ebc = dist;
            }
        }
        
        return var_574b367a589e1f37;
    }
}

// Namespace poi / scripts\mp\poi
// Params 3
// Checksum 0x0, Offset: 0x1af5
// Size: 0x6d
function function_80dd9d6a6bf6bbc1( agent, poiname, origin )
{
    if ( !isdefined( poiname ) )
    {
        poiname = undefined;
        var_3a6b42ab825a103e = agent.origin;
        
        if ( isdefined( origin ) )
        {
            var_3a6b42ab825a103e = origin;
        }
        
        poiname = poi_findPOIOriginIsIn( var_3a6b42ab825a103e );
    }
    
    agent.poi = poiname;
    
    if ( isdefined( poiname ) )
    {
        agent scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata( agent, "poiName", poiname );
    }
    
    return poiname;
}

// Namespace poi / scripts\mp\poi
// Params 2
// Checksum 0x0, Offset: 0x1b6b
// Size: 0x89
function function_9656b61cc8a37cba( array, poiname )
{
    temparray = [];
    
    foreach ( item in array )
    {
        if ( isdefined( item.poi ) && item.poi == poiname )
        {
            temparray[ temparray.size ] = item;
        }
    }
    
    return temparray;
}

// Namespace poi / scripts\mp\poi
// Params 0
// Checksum 0x0, Offset: 0x1bfd
// Size: 0xc, Type: bool
function poi_isSystemActive()
{
    return isdefined( level.poi );
}

// Namespace poi / scripts\mp\poi
// Params 1
// Checksum 0x0, Offset: 0x1c12
// Size: 0x15
function function_53c14fe145417e51( array )
{
    level.poi_names = array;
}

// Namespace poi / scripts\mp\poi
// Params 1
// Checksum 0x0, Offset: 0x1c2f
// Size: 0x3f, Type: bool
function poi_ispoiactive( poiname )
{
    return isdefined( poiname ) && poi_isSystemActive() && array_contains( level.poi_names, poiname ) && !array_contains( level.var_ab20b3a256911579, poiname );
}

// Namespace poi / scripts\mp\poi
// Params 0
// Checksum 0x0, Offset: 0x1c77
// Size: 0x21, Type: bool
function function_7e9cbc0f32de6578()
{
    return poi_isSystemActive() && level.var_ab20b3a256911579.size < level.poi_names.size;
}

// Namespace poi / scripts\mp\poi
// Params 1
// Checksum 0x0, Offset: 0x1ca1
// Size: 0xd4
function function_f7c64a373265eb43( poiname )
{
    self notify( "updateVisitedPOI" );
    level endon( "match_end" );
    self endon( "updateVisitedPOI" );
    self endon( "death_or_disconnect" );
    
    if ( !isdefined( level.poi[ poiname ][ "calloutIndex" ] ) )
    {
        return;
    }
    
    while ( !self isonground() && !self isswimming() && !self ishanging() && !self isonladder() && !self isvehicleactive() )
    {
        waitframe();
    }
    
    if ( !isdefined( self.var_c9a673c7c187991b ) )
    {
        self.var_c9a673c7c187991b = [];
    }
    
    calloutindex = level.poi[ poiname ][ "calloutIndex" ];
    
    if ( !isdefined( self.var_c9a673c7c187991b[ calloutindex ] ) )
    {
        scripts\cp_mp\challenges::function_8359cadd253f9604( self, "visite_poi", 1 );
        self.var_c9a673c7c187991b[ calloutindex ] = 1;
    }
}

// Namespace poi / scripts\mp\poi
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1d7d
// Size: 0x3d9
function private function_52cb931e1834f98b()
{
    level waittill_either( "matchStartTimer_done", "br_ready_to_jump" );
    
    while ( !isdefined( level.players ) || level.poi.size == 0 )
    {
        waitframe();
    }
    
    var_3a1b9192a1f0b3c4 = istrue( level.var_2690bfebdead0396 );
    var_6370de220eb9ec35 = getdvarint( @"hash_a9f6d0e41ea4bc32", 0 );
    var_a45bd8f911724ada = getdvarint( @"hash_57b012f2c429bcb9", 1 );
    var_a015167b01a60f17 = getdvarint( @"hash_88e87d9d935136d0", 5000 );
    frameduration = level.frameduration;
    var_ff85928e34f7eb79 = floor( var_a015167b01a60f17 / frameduration );
    
    if ( var_3a1b9192a1f0b3c4 && var_a45bd8f911724ada )
    {
        foreach ( player in level.players )
        {
            poiname = function_1cbc1b619b924e7a( player.origin );
            
            if ( isdefined( poiname ) )
            {
                difficulty = function_6c8458742f557952( poiname );
                
                if ( scripts\mp\gametypes\br_gametype_dmz::function_7a7aa3b5455f0412( poiname ) )
                {
                    difficulty = 4;
                }
                
                player setclientomnvar( "ui_dmz_poi_difficulty_rating", difficulty );
            }
        }
    }
    
    foreach ( poiname, poi in level.poi )
    {
        level.poi[ poiname ][ "players" ] = [];
    }
    
    while ( true )
    {
        players = level.players;
        var_e0e025c067d6a3aa = ceil( players.size / var_ff85928e34f7eb79 );
        playersupdated = 0;
        framesprocessed = 0;
        
        for ( playeridx = 0; playeridx < players.size ; playeridx++ )
        {
            player = players[ playeridx ];
            
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player.sublocation = undefined;
            
            if ( var_3a1b9192a1f0b3c4 && isdefined( level.var_a524a11dadc4d9fb ) )
            {
                foreach ( name, trigger in level.var_a524a11dadc4d9fb )
                {
                    if ( ispointinvolume( player.origin, trigger ) )
                    {
                        player.sublocation = name;
                        break;
                    }
                }
            }
            
            previouspoi = player.closestpoi;
            
            if ( isdefined( previouspoi ) )
            {
                player.lastvalidpoi = previouspoi;
                level.poi[ previouspoi ][ "players" ] = array_remove( level.poi[ previouspoi ][ "players" ], player );
            }
            
            poiname = poi_findPOIOriginIsIn( player.origin );
            player.closestpoi = poiname;
            
            if ( !isdefined( poiname ) )
            {
                continue;
            }
            
            level.poi[ poiname ][ "players" ][ level.poi[ poiname ][ "players" ].size ] = player;
            var_1e8a1d9f5d0a3c9e = poiname;
            
            if ( var_6370de220eb9ec35 )
            {
                var_1e8a1d9f5d0a3c9e = function_150af7f3a2874667( poiname );
            }
            
            var_132c9f8d05cfd = !isdefined( previouspoi ) || previouspoi != player.closestpoi;
            player thread function_db35c17120dbfb4a( poiname, var_1e8a1d9f5d0a3c9e, var_132c9f8d05cfd, var_3a1b9192a1f0b3c4, var_a45bd8f911724ada );
            playersupdated++;
            
            if ( playersupdated >= var_e0e025c067d6a3aa )
            {
                playersupdated = 0;
                framesprocessed++;
                waitframe();
            }
        }
        
        waittime = max( 0, var_a015167b01a60f17 - framesprocessed * frameduration ) / 1000;
        wait waittime;
    }
}

// Namespace poi / scripts\mp\poi
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x215e
// Size: 0x2b4
function private function_db35c17120dbfb4a( poiname, var_1e8a1d9f5d0a3c9e, var_132c9f8d05cfd, var_3a1b9192a1f0b3c4, var_a45bd8f911724ada )
{
    player = self;
    
    if ( var_132c9f8d05cfd )
    {
        player thread function_f7c64a373265eb43( poiname );
        vehicle = player scripts\cp_mp\utility\player_utility::getvehicle();
        
        if ( isdefined( vehicle ) && isdefined( player.team ) )
        {
            if ( !isdefined( level.var_7352a1221b306395 ) )
            {
                level.var_7352a1221b306395 = [];
            }
            
            if ( !isdefined( level.var_7352a1221b306395[ var_1e8a1d9f5d0a3c9e ] ) )
            {
                level.var_7352a1221b306395[ var_1e8a1d9f5d0a3c9e ] = [];
            }
            
            if ( !isdefined( level.var_7352a1221b306395[ var_1e8a1d9f5d0a3c9e ][ player.team ] ) )
            {
                level.var_7352a1221b306395[ var_1e8a1d9f5d0a3c9e ][ player.team ] = 1;
                player scripts\cp_mp\challenges::reportVehicleEvent( vehicle, "poi_travel" );
            }
        }
        
        var_d455648308e34f3f = -1;
        potentialindex = level.poi[ poiname ][ "calloutIndex" ];
        
        if ( isdefined( potentialindex ) )
        {
            var_d455648308e34f3f = potentialindex;
        }
        
        player setclientomnvar( "ui_callout_area_id", var_d455648308e34f3f );
    }
    
    if ( var_3a1b9192a1f0b3c4 )
    {
        if ( !isdefined( player.var_df1204f47f6f0067 ) )
        {
            player.var_df1204f47f6f0067 = [];
        }
        
        if ( !isdefined( player.var_df1204f47f6f0067[ var_1e8a1d9f5d0a3c9e ] ) )
        {
            player.var_df1204f47f6f0067[ var_1e8a1d9f5d0a3c9e ] = { #exittime:-99999999 };
        }
        
        if ( isdefined( player.lastvalidpoi ) && player.lastvalidpoi != player.closestpoi )
        {
            timesinceexit = gettime() - player.var_df1204f47f6f0067[ var_1e8a1d9f5d0a3c9e ].exittime;
            
            if ( timesinceexit > level.var_d35175ec20b444c )
            {
                splash = "br_poi_entry_" + var_1e8a1d9f5d0a3c9e;
                
                if ( issharedfuncdefined( "hud", "showDMZSplash" ) )
                {
                    [[ getsharedfunc( "hud", "showDMZSplash" ) ]]( splash, [ player ] );
                }
            }
        }
        
        if ( var_132c9f8d05cfd )
        {
            if ( var_a45bd8f911724ada )
            {
                difficulty = function_6c8458742f557952( poiname );
                
                if ( scripts\mp\gametypes\br_gametype_dmz::function_7a7aa3b5455f0412( poiname ) )
                {
                    difficulty = 4;
                }
                
                player setclientomnvar( "ui_dmz_poi_difficulty_rating", difficulty );
                player function_2c353ba60e43ecda( poiname );
            }
            
            scripts\mp\pmc_missions::function_d10645afed0f00fe( player, var_1e8a1d9f5d0a3c9e );
            waitframe();
        }
        
        if ( isalive( player ) && isdefined( player.var_df1204f47f6f0067 ) && isdefined( player.var_df1204f47f6f0067[ var_1e8a1d9f5d0a3c9e ] ) )
        {
            player.var_df1204f47f6f0067[ var_1e8a1d9f5d0a3c9e ].exittime = gettime();
        }
    }
}

// Namespace poi / scripts\mp\poi
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x241a
// Size: 0x7b
function private function_6c8458742f557952( poiname )
{
    starlevel = namespace_6a3f8c14894f44be::function_5cc0c507e92f7b47( poiname );
    relativedifficulty = 0;
    
    if ( isdefined( level.poi[ poiname ][ "relativeDifficulty" ] ) )
    {
        relativedifficulty = level.poi[ poiname ][ "relativeDifficulty" ];
    }
    
    if ( relativedifficulty == 3 )
    {
        return 3;
    }
    
    if ( starlevel > 3 )
    {
        return 3;
    }
    
    if ( relativedifficulty == 2 )
    {
        return 2;
    }
    
    if ( starlevel >= 2 )
    {
        return 2;
    }
    
    return 1;
}

// Namespace poi / scripts\mp\poi
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x249e
// Size: 0x58
function private function_fc5d5824570e8c21( player )
{
    if ( isdefined( player.closestpoi ) )
    {
        level.poi[ player.closestpoi ][ "players" ] = array_remove( level.poi[ player.closestpoi ][ "players" ], player );
    }
}

// Namespace poi / scripts\mp\poi
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x24fe
// Size: 0xc2
function private function_2c353ba60e43ecda( poiname )
{
    if ( !isdefined( poiname ) )
    {
        poiname = self.closestpoi;
    }
    
    if ( istrue( level.var_b76e1acdf15010d2 ) )
    {
        return;
    }
    
    difficulty = function_6c8458742f557952( poiname );
    
    if ( scripts\mp\gametypes\br_gametype_dmz::function_7a7aa3b5455f0412( poiname ) )
    {
        difficulty = 4;
    }
    
    switch ( difficulty )
    {
        case 1:
            scripts\cp_mp\overlord::playevent( "ai_density_low", [ self ] );
            break;
        case 2:
            scripts\cp_mp\overlord::playevent( "ai_density_med", [ self ] );
            break;
        case 3:
        case 4:
            scripts\cp_mp\overlord::playevent( "ai_density_high", [ self ] );
            break;
    }
}

// Namespace poi / scripts\mp\poi
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x25c8
// Size: 0x1be
function private function_6e049f322172e1d5()
{
    level.poi_sites = [];
    sitecount = compassregions_getsitecount( 1 );
    
    for ( siteidx = 0; siteidx < sitecount ; siteidx++ )
    {
        site = compassregions_getsite( 1, siteidx );
        region = compassregions_getregion( 1, site.region );
        poiname = region.name + " site_" + siteidx;
        var_c720431da1c3945e = removesubstr( tolower( region.name ), " " );
        
        if ( !isdefined( level.poi_names ) )
        {
            level.poi_names = [];
        }
        
        assert( !array_contains( level.poi_names, poiname ) );
        level.poi_names[ level.poi_names.size ] = poiname;
        level.poi_origins[ poiname ] = site.origin;
        affix = "";
        
        if ( isdefined( level.mapname ) )
        {
            switch ( level.mapname )
            {
                case #"hash_aeddd44c5b27b2d":
                case #"hash_bce1a7274538a78":
                case #"hash_73e90c896fdaebc3":
                case #"hash_9ae3f9a4f2372775":
                    affix = "jup_bigmap_";
                    break;
                default:
                    affix = level.mapname + "_";
                    break;
            }
        }
        
        level.var_93d766d265995ec6[ poiname ] = affix + var_c720431da1c3945e;
        level.poi_sites[ siteidx ] = poiname;
        level.poi_regions[ poiname ] = site.region;
    }
}

// Namespace poi / scripts\mp\poi
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x278e
// Size: 0x14a
function private function_9a051b4df049e90b()
{
    if ( !isdefined( level.poi_sites ) )
    {
        return;
    }
    
    if ( istrue( level.var_f257b1e13dcc1bad ) )
    {
        return;
    }
    
    foreach ( poiname in level.poi_names )
    {
        if ( !isdefined( level.poi[ poiname ] ) )
        {
            continue;
        }
        
        level.poi[ poiname ][ "otherPoiByDist" ] = [];
        curorigin = level.poi_origins[ poiname ];
        var_b08c6727f8fd4cfa = compassregions_getsitessorted( 1, curorigin );
        
        foreach ( site in var_b08c6727f8fd4cfa )
        {
            if ( array_contains_key( level.poi, level.poi_sites[ site ] ) )
            {
                level.poi[ poiname ][ "otherPoiByDist" ][ level.poi[ poiname ][ "otherPoiByDist" ].size ] = level.poi_sites[ site ];
            }
        }
    }
}

// Namespace poi / scripts\mp\poi
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x28e0
// Size: 0x17f
function private function_b5c7469e80b1e8bd()
{
    function_44739fe1cf82e29a( "subAreas" );
    gametype = scripts\mp\utility\game::getsubgametype() + "_";
    var_d8c79ee51c9021b6 = "mp/compass_regions/" + "compassregions_poi_sub_regions_" + gametype + level.mapname + ".csv";
    compassregions_loadconfig( var_d8c79ee51c9021b6, 2 );
    
    if ( compassregions_configloaded( 2 ) )
    {
        sitecount = compassregions_getsitecount( 2 );
        
        for ( siteidx = 0; siteidx < sitecount ; siteidx++ )
        {
            var_849898b69efd7593 = compassregions_getsite( 2, siteidx );
            var_3851e646d941dcbb = compassregions_getsiteforworldorigin( 1, var_849898b69efd7593.origin );
            
            if ( isdefined( var_3851e646d941dcbb ) )
            {
                var_bcf8a8aaf3e931fc = compassregions_getregion( 2, var_849898b69efd7593.region );
                subarea = spawnstruct();
                subarea.site = siteidx;
                subarea.origin = var_849898b69efd7593.origin;
                subarea.var_71ad22c5d093d90b = var_bcf8a8aaf3e931fc.name + " site_" + siteidx;
                subarea.poiname = var_bcf8a8aaf3e931fc.name;
                poiname = level.poi_sites[ var_3851e646d941dcbb ];
                function_d0e7647e5538eb9d( poiname, "subAreas", subarea, subarea.var_71ad22c5d093d90b );
            }
        }
    }
    
    function_84291fc4abf2c2d();
    function_28bfdfbf2b7b36c2();
}

// Namespace poi / scripts\mp\poi
// Params 0
// Checksum 0x0, Offset: 0x2a67
// Size: 0xf0
function function_68f5d2342ad95772()
{
    if ( !isdefined( level.var_9fab40ed3326f8b ) )
    {
        return;
    }
    
    table = level.var_9fab40ed3326f8b;
    numrows = tablelookupgetnumrows( table );
    var_bfd57d442dee737f = undefined;
    
    for ( i = 0; i < numrows ; i++ )
    {
        poiname = tablelookupbyrow( table, i, 0 );
        
        if ( !array_contains( level.poi_names, poiname ) )
        {
            continue;
        }
        
        if ( isdefined( var_bfd57d442dee737f ) && isdefined( level.poi[ poiname ] ) && isdefined( level.poi[ poiname ][ "relativeDifficulty" ] ) && poiname == var_bfd57d442dee737f )
        {
            continue;
        }
        
        relativedifficulty = int( tablelookupbyrow( table, i, 10 ) );
        
        if ( relativedifficulty > 0 && relativedifficulty <= 3 )
        {
            level.poi[ poiname ][ "relativeDifficulty" ] = relativedifficulty;
            var_bfd57d442dee737f = poiname;
        }
    }
}

// Namespace poi / scripts\mp\poi
// Params 0
// Checksum 0x0, Offset: 0x2b5f
// Size: 0x1a6
function function_683e582efd2a8233()
{
    if ( !isdefined( level.var_9fab40ed3326f8b ) )
    {
        return;
    }
    
    table = level.var_9fab40ed3326f8b;
    numrows = tablelookupgetnumrows( table );
    var_bfd57d442dee737f = undefined;
    
    for ( i = 0; i < numrows ; i++ )
    {
        poiname = tablelookupbyrow( table, i, 0 );
        
        if ( !array_contains( level.poi_names, poiname ) )
        {
            continue;
        }
        
        if ( isdefined( var_bfd57d442dee737f ) && isdefined( level.poi[ poiname ] ) && isdefined( level.poi[ poiname ][ "minExtraBuyStations" ] ) && poiname == var_bfd57d442dee737f )
        {
            continue;
        }
        
        tempnum = tablelookupbyrow( table, i, 11 );
        
        if ( tempnum == "" )
        {
            continue;
        }
        
        minextrabuystations = int( tempnum );
        level.poi[ poiname ][ "minExtraBuyStations" ] = minextrabuystations;
        var_bfd57d442dee737f = poiname;
    }
    
    var_bfd57d442dee737f = undefined;
    
    for ( i = 0; i < numrows ; i++ )
    {
        poiname = tablelookupbyrow( table, i, 0 );
        
        if ( !array_contains( level.poi_names, poiname ) )
        {
            continue;
        }
        
        if ( isdefined( var_bfd57d442dee737f ) && isdefined( level.poi[ poiname ] ) && isdefined( level.poi[ poiname ][ "maxExtraBuyStations" ] ) && poiname == var_bfd57d442dee737f )
        {
            continue;
        }
        
        tempnum = tablelookupbyrow( table, i, 12 );
        
        if ( tempnum == "" )
        {
            continue;
        }
        
        maxextrabuystations = int( tempnum );
        level.poi[ poiname ][ "maxExtraBuyStations" ] = maxextrabuystations;
        var_bfd57d442dee737f = poiname;
    }
}

// Namespace poi / scripts\mp\poi
// Params 0
// Checksum 0x0, Offset: 0x2d0d
// Size: 0x12c
function function_fab5ad80fd5ad70e()
{
    if ( !isdefined( level.misc_regions ) )
    {
        level.misc_regions = [];
    }
    
    var_d8c79ee51c9021b6 = "mp/compass_regions/" + "compassregions_misc_regions_" + level.mapname + ".csv";
    compassregions_loadconfig( var_d8c79ee51c9021b6, 4 );
    
    if ( compassregions_configloaded( 4 ) )
    {
        sitecount = compassregions_getsitecount( 4 );
        
        for ( siteidx = 0; siteidx < sitecount ; siteidx++ )
        {
            var_7d2faedfb4e72797 = compassregions_getsite( 4, siteidx );
            var_195a4d0ab2c13079 = compassregions_getsiteforworldorigin( 4, var_7d2faedfb4e72797.origin );
            
            if ( isdefined( var_195a4d0ab2c13079 ) )
            {
                var_aafaf947d31a3ba0 = compassregions_getregion( 4, var_7d2faedfb4e72797.region );
                miscarea = spawnstruct();
                miscarea.site = siteidx;
                miscarea.origin = var_7d2faedfb4e72797.origin;
                miscarea.name = var_aafaf947d31a3ba0.name;
                level.misc_regions[ var_aafaf947d31a3ba0.name ] = miscarea;
            }
        }
    }
}

// Namespace poi / scripts\mp\poi
// Params 1
// Checksum 0x0, Offset: 0x2e41
// Size: 0x9f
function function_bfb73de4decfe852( origin )
{
    if ( isdefined( level.misc_regions ) )
    {
        var_1e0f91acb54fe361 = compassregions_getsiteforworldorigin( 4, origin );
        
        foreach ( region in level.misc_regions )
        {
            if ( isdefined( region.site ) && isdefined( var_1e0f91acb54fe361 ) && var_1e0f91acb54fe361 == region.site )
            {
                return region;
            }
        }
    }
    
    return undefined;
}

