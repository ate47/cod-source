#using scripts\common\devgui;
#using scripts\engine\utility;
#using scripts\mp\flags;

#namespace structspawnconfig;

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0
// Checksum 0x0, Offset: 0x860
// Size: 0x9e, Type: bool
function init()
{
    if ( !getdvarint( @"scr_ssc_enabled", 0 ) )
    {
        return false;
    }
    
    scripts\mp\flags::gameflaginit( "ssc_initialized", 0 );
    debug_print( "System enabled" );
    
    /#
        init_debug();
        thread debug_thread();
    #/
    
    listref = getdvar( @"hash_8e30f7eeea837de6", "" );
    
    if ( listref == "" )
    {
        debug_print( "No Config List given, exiting" );
        return false;
    }
    
    init_data();
    scripts\mp\flags::gameflagset( "ssc_initialized" );
    level notify( "ssc_initialized" );
    thread init_thread( listref );
    return true;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x907
// Size: 0x48
function private init_thread( listref )
{
    function_8de891d666db43b1( "init_thread entered" );
    level waittill( "POIs_spawned" );
    function_8de891d666db43b1( "init_thread level waittill set" );
    wait 1;
    ssc_config( listref );
    level notify( "ssc_config_spawned" );
    function_4993c0868a42f933();
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x957
// Size: 0xad
function private init_data()
{
    level.ssc = spawnstruct();
    level.ssc.spawns = [];
    
    /#
        level.ssc.colors = [];
        level.ssc.drawcount = 0;
    #/
    
    level.ssc.funcgetlocations = [];
    level.ssc.var_6639b9dad892b886 = [];
    level.ssc.var_69d443a2d34d967a = [];
    level.ssc.var_2ce6fab92810875 = [];
    function_6f53937fb7417b67();
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xa0c
// Size: 0x56
function private function_6f53937fb7417b67()
{
    level.ssc.structs = [];
    level.ssc.indexes = [];
    level.ssc.exclude = [];
    level.ssc.weights = [];
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xa6a
// Size: 0x4e
function private function_4993c0868a42f933()
{
    level.ssc.structs = undefined;
    level.ssc.indexes = undefined;
    level.ssc.exclude = undefined;
    level.ssc.weights = undefined;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2
// Checksum 0x0, Offset: 0xac0
// Size: 0x51
function function_4f7660cfd85cd517( structname, var_7f5fc69251d6a8da )
{
    if ( !isdefined( level.ssc ) || !isdefined( level.ssc.funcgetlocations ) )
    {
        return;
    }
    
    level.ssc.funcgetlocations[ structname ] = var_7f5fc69251d6a8da;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2
// Checksum 0x0, Offset: 0xb19
// Size: 0x51
function function_412f527ef0863f0e( structname, var_efc8ac1d0c1c9aec )
{
    if ( !isdefined( level.ssc ) || !isdefined( level.ssc.var_6639b9dad892b886 ) )
    {
        return;
    }
    
    level.ssc.var_6639b9dad892b886[ structname ] = var_efc8ac1d0c1c9aec;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2
// Checksum 0x0, Offset: 0xb72
// Size: 0x51
function function_f0492c3bdbb3fd52( structname, var_7661235a91a2811 )
{
    if ( !isdefined( level.ssc ) || !isdefined( level.ssc.var_69d443a2d34d967a ) )
    {
        return;
    }
    
    level.ssc.var_69d443a2d34d967a[ structname ] = var_7661235a91a2811;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2
// Checksum 0x0, Offset: 0xbcb
// Size: 0x51
function function_eded5b87f8f7bdfd( structname, var_f7a132d39a92cd3c )
{
    if ( !isdefined( level.ssc ) || !isdefined( level.ssc.var_2ce6fab92810875 ) )
    {
        return;
    }
    
    level.ssc.var_2ce6fab92810875[ structname ] = var_f7a132d39a92cd3c;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2
// Checksum 0x0, Offset: 0xc24
// Size: 0x7d
function ssc_config( listref, spawntype )
{
    configlist = function_f8c6adde7a4c2116( listref );
    
    if ( !isdefined( configlist ) )
    {
        function_8de891d666db43b1( "ssc_config could not init list" );
        return;
    }
    
    results = configlist function_975552b793ff8e27( spawntype );
    debug_print( "Spawning complete for config list " + listref );
    
    /#
        if ( isdefined( spawntype ) && spawntype == 2 )
        {
            level.ssc.drawcount++;
        }
    #/
    
    return results;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2
// Checksum 0x0, Offset: 0xcaa
// Size: 0x82
function function_be39ee9f759d6210( var_ca2c833762e5466c, spawntype )
{
    spawnconfig = function_9a62bf0437306755( var_ca2c833762e5466c, "structspawnconfig:" );
    
    if ( !isdefined( spawnconfig ) )
    {
        function_8de891d666db43b1( "ssc_config_single could not init config" );
        return;
    }
    
    results = spawnconfig function_b4f718bb8f4f3f6e( spawntype );
    debug_print( "Spawning complete for config " + var_ca2c833762e5466c );
    
    /#
        if ( isdefined( spawntype ) && spawntype == 2 )
        {
            level.ssc.drawcount++;
        }
    #/
    
    return results;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xd35
// Size: 0x63
function private function_f8c6adde7a4c2116( listref )
{
    var_c7803e864d499dc0 = function_b7913c455f72d892( listref, "structspawnconfiglist:" );
    
    if ( !isdefined( var_c7803e864d499dc0 ) || var_c7803e864d499dc0.size == 0 )
    {
        return;
    }
    
    configlist = function_d72b66a120f30bba( var_c7803e864d499dc0 );
    
    if ( !isdefined( configlist ) )
    {
        return;
    }
    
    configlist = configlist function_9b826ec5596b4b1d();
    configlist function_7f0c7ed9520a18f0();
    configlist function_705ab1040a64a8fa();
    return configlist;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xda1
// Size: 0xb1
function private function_9b826ec5596b4b1d()
{
    configlist = self;
    var_852ab1ce7e39362d = strtok( getdvar( @"scr_ssc_config_overrides", "" ), " " );
    
    if ( var_852ab1ce7e39362d.size == 0 )
    {
        return configlist;
    }
    
    foreach ( var_ca2c833762e5466c in var_852ab1ce7e39362d )
    {
        configlist = function_7dbb2f79e1942e4d( configlist, var_ca2c833762e5466c, "structspawnconfig:" );
    }
    
    debug_print( "Config overrides loaded: " + getdvar( @"scr_ssc_config_overrides", "" ) );
    return configlist;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xe5b
// Size: 0x1d
function private function_7f0c7ed9520a18f0()
{
    configlist = self;
    configlist = array_sort_with_func( configlist, &function_8bdb3e2a8e7218da );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2
// Checksum 0x0, Offset: 0xe80
// Size: 0x3f, Type: bool
function function_8bdb3e2a8e7218da( left, right )
{
    var_93ef778faa2e5e54 = left function_7f0bb84945d7d821();
    
    if ( array_contains( var_93ef778faa2e5e54, right.script_struct ) )
    {
        return true;
    }
    
    return false;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xec8
// Size: 0x65
function private function_7f0bb84945d7d821()
{
    spawnconfig = self;
    var_648d70383177eca2 = [];
    var_648d70383177eca2 = array_combine( var_648d70383177eca2, function_40ca2001079995dd( spawnconfig.var_6aa0b809ce5a31f8, spawnconfig.var_a8b01cf8030d00c5 ) );
    var_648d70383177eca2 = array_combine( var_648d70383177eca2, function_40ca2001079995dd( spawnconfig.var_f9bfec3775efb6da, spawnconfig.var_b21135f7c628c393 ) );
    return var_648d70383177eca2;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xf36
// Size: 0x7f
function private function_40ca2001079995dd( rule, var_2f5adfa86b4854a6 )
{
    structnames = [];
    
    if ( !function_8d5f739c58f8362f( rule ) )
    {
        return structnames;
    }
    
    foreach ( entry in var_2f5adfa86b4854a6 )
    {
        structnames[ structnames.size ] = entry.script_struct;
    }
    
    return structnames;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xfbe
// Size: 0x5b
function private function_705ab1040a64a8fa()
{
    configlist = self;
    var_45ffc2a32427f2a9 = "";
    
    for ( i = 0; i < configlist.size ; i++ )
    {
        var_45ffc2a32427f2a9 += configlist[ i ].script_struct + " ";
    }
    
    debug_print( "Final config list: " + var_45ffc2a32427f2a9 );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1021
// Size: 0x61
function private function_975552b793ff8e27( spawntype )
{
    configlist = self;
    results = [];
    
    for ( i = 0; i < configlist.size ; i++ )
    {
        index = configlist[ i ].script_struct;
        results[ index ] = configlist[ i ] function_b4f718bb8f4f3f6e( spawntype );
    }
    
    return results;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x108b
// Size: 0x6b
function private function_b4f718bb8f4f3f6e( spawntype )
{
    spawnconfig = self;
    
    if ( !isdefined( spawntype ) )
    {
        spawntype = 0;
    }
    
    function_8d6027e6daa80c1d( spawnconfig, spawntype );
    spawnlist = spawnconfig function_ea108fced89d8d8a();
    spawnresult = spawnlist function_8c1a4fdea2e25ac6( spawnconfig, spawntype );
    spawnlist function_a287b4f36804bbdd( spawnconfig, spawntype );
    spawnlist function_b55121bc7c3e2825( spawnconfig, spawntype );
    
    if ( spawntype == 3 )
    {
        return spawnlist;
    }
    
    return spawnresult;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x10ff
// Size: 0x190
function private function_8d6027e6daa80c1d( spawnconfig, spawntype )
{
    function_6f53937fb7417b67();
    
    if ( !isdefined( level.ssc.spawns[ spawnconfig.script_struct ] ) && spawntype != 2 )
    {
        level.ssc.spawns[ spawnconfig.script_struct ] = [];
    }
    
    /#
        if ( isdefined( spawnconfig.debug_color ) )
        {
            colorvec = strtok( spawnconfig.debug_color, "<dev string:x1c>" );
            level.ssc.colors[ spawnconfig.script_struct ] = ( float( colorvec[ 0 ] ), float( colorvec[ 1 ] ), float( colorvec[ 2 ] ) );
        }
    #/
    
    structlocations = function_4784966d3ce7dba9( spawnconfig.script_struct );
    function_8de891d666db43b1( "Struct " + spawnconfig.script_struct + " found " + structlocations.size + " locations to select from" );
    
    for ( i = 0; i < structlocations.size ; i++ )
    {
        struct = structlocations[ i ];
        thisindex = function_400ac4c375b471a1( struct.script_index );
        level.ssc.indexes[ thisindex ] = thisindex;
        level.ssc.structs[ thisindex ] = struct;
        function_270b1bb4d46b9f5a( spawnconfig, struct, thisindex );
    }
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1297
// Size: 0x77
function private function_270b1bb4d46b9f5a( spawnconfig, struct, thisindex )
{
    structpoi = function_3bde2c46d3361035( struct );
    
    if ( !isdefined( level.ssc.structs[ structpoi ] ) )
    {
        level.ssc.structs[ structpoi ] = [];
    }
    
    level.ssc.structs[ structpoi ][ thisindex ] = struct;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1316
// Size: 0xfb
function private function_ea108fced89d8d8a()
{
    spawnconfig = self;
    spawns = [];
    function_8de891d666db43b1( "Struct " + spawnconfig.script_struct + " is beginning config processing" );
    
    if ( istrue( spawnconfig.spawn_all ) || istrue( spawnconfig.var_8cd1c028ce4287b8 ) )
    {
        spawns = level.ssc.indexes;
        
        if ( istrue( spawnconfig.spawn_all ) )
        {
            function_8de891d666db43b1( "Spawn All was selected, exiting" );
            return spawns;
        }
    }
    
    spawnconfig = spawnconfig function_6f80cf558a58324d();
    spawns = spawns function_5b7885d608f6b17e( spawnconfig );
    spawns = spawns function_9657eb0ab7380011( spawnconfig );
    spawns = spawns function_4ee587b4504098a8( spawnconfig );
    spawns = spawns function_66099a164cfbc123( spawnconfig );
    spawns = spawns function_415a97db2da6dd7e( spawnconfig );
    spawns = spawns function_4ee587b4504098a8( spawnconfig );
    spawns = spawns function_9657eb0ab7380011( spawnconfig );
    spawns = spawns function_415a97db2da6dd7e( spawnconfig, 1 );
    spawns = spawns function_66099a164cfbc123( spawnconfig, 1 );
    spawns = spawns function_5b7885d608f6b17e( spawnconfig );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x141a
// Size: 0x85
function private function_8c1a4fdea2e25ac6( spawnconfig, spawntype )
{
    spawnlist = self;
    spawnarray = [];
    
    foreach ( entry in spawnlist )
    {
        spawnarray[ spawnarray.size ] = function_d501d9da90bcfb86( entry, spawnconfig, spawntype );
    }
    
    if ( spawntype == 1 )
    {
        return spawnarray;
    }
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x14a7
// Size: 0xf6
function private function_a287b4f36804bbdd( spawnconfig, spawntype )
{
    spawnlist = self;
    
    /#
        if ( getdvarint( @"hash_74281019987bc070", 0 ) == 1 )
        {
            return;
        }
    #/
    
    var_383b3dc47d422fce = level.ssc.var_69d443a2d34d967a[ spawnconfig.script_struct ];
    
    if ( !isdefined( var_383b3dc47d422fce ) )
    {
        return;
    }
    
    foreach ( structindex in level.ssc.indexes )
    {
        if ( !array_contains( spawnlist, structindex ) )
        {
            struct = level.ssc.structs[ structindex ];
            [[ var_383b3dc47d422fce ]]( spawnconfig.script_struct, struct );
        }
    }
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x15a5
// Size: 0x9d
function private function_d501d9da90bcfb86( entry, spawnconfig, spawntype )
{
    switch ( spawntype )
    {
        case 3:
            break;
        case 2:
            /#
                function_dd01b38da430e244( spawnconfig.script_struct, entry );
            #/
            
            break;
        case 1:
            return function_7a0a1c8e4051f836( entry );
        case 0:
        default:
            ssc_spawn( spawnconfig.script_struct, entry );
            break;
    }
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x164a
// Size: 0x7b
function private function_b55121bc7c3e2825( spawnconfig, spawntype )
{
    spawnlist = self;
    spawnlist function_16deec76c9aec1c2( spawnconfig, spawntype );
    
    if ( isdefined( level.ssc.var_2ce6fab92810875[ spawnconfig.script_struct ] ) )
    {
        thread [[ level.ssc.var_2ce6fab92810875[ spawnconfig.script_struct ] ]]( spawnconfig.script_struct );
    }
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x16cd
// Size: 0x5c
function private function_16deec76c9aec1c2( spawnconfig, spawntype )
{
    spawnlist = self;
    debug_print( "Struct " + spawnconfig.script_struct + " spawned " + spawnlist.size + " times" + ter_op( spawntype == 2, " in Debug mode", "" ) );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1731
// Size: 0x3a
function private function_5b7885d608f6b17e( spawnconfig )
{
    spawns = self;
    spawns = spawns function_b632c72bbf401a8b( spawnconfig );
    spawns = spawns function_7f381a0dc49788c9( spawnconfig );
    spawns function_ae3769c411d239f2( "Force" );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1774
// Size: 0x129
function private function_9657eb0ab7380011( spawnconfig )
{
    spawns = self;
    
    if ( isdefined( spawnconfig.var_80007572cdd4150f ) )
    {
        foreach ( poirule in spawnconfig.var_80007572cdd4150f )
        {
            if ( !isdefined( poirule.var_dfe282400b2e9ad7 ) )
            {
                group_name = "";
                
                foreach ( poi in poirule.poi_group )
                {
                    group_name += poi.poi_name + "_";
                }
                
                poirule.var_dfe282400b2e9ad7 = group_name;
            }
            
            spawns = spawns function_576bc6dcb198807d( poirule, spawnconfig );
        }
    }
    
    spawns = spawns function_eec8d5bb79fb6ed5( spawnconfig );
    spawns function_ae3769c411d239f2( "POI" );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x18a6
// Size: 0xe6
function private function_be1e8d04a1c66652( poirule, spawnconfig, groupindex )
{
    spawns = self;
    [ spawns, var_c41693c82143133e ] = spawns function_7d53ab524b68f69b( function_3e38027e10bb939c( poirule.poi_group[ groupindex ] ), 1 );
    
    if ( var_c41693c82143133e.size == 0 )
    {
        function_8de891d666db43b1( "Struct " + spawnconfig.script_struct + " has 0 spawns in " + poirule.poi_group[ groupindex ] );
        return spawns;
    }
    
    var_e7fee629fee1b87f = var_c41693c82143133e function_5b1350ccb1325b2e( poirule, groupindex );
    var_e7fee629fee1b87f = var_e7fee629fee1b87f function_e5dcf502bd8f8434( poirule );
    var_e7fee629fee1b87f = var_e7fee629fee1b87f function_ea64cf87f2cfcc5e( poirule );
    spawns = function_d1e45146e40968b9( spawns, var_e7fee629fee1b87f );
    function_ae3769c411d239f2( "POI Single - " + poirule.poi_group[ groupindex ] );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1995
// Size: 0xf4
function private function_576bc6dcb198807d( poirule, spawnconfig )
{
    spawns = self;
    [ spawns, var_c41693c82143133e ] = spawns function_7d53ab524b68f69b( function_a9515f5c0ddfbeee( poirule.poi_group ), 1 );
    
    if ( var_c41693c82143133e.size == 0 )
    {
        var_c41693c82143133e = function_a9515f5c0ddfbeee( poirule.poi_group );
        
        if ( var_c41693c82143133e.size == 0 )
        {
            function_8de891d666db43b1( "Struct " + spawnconfig.script_struct + " has 0 spawns in " + poirule.var_dfe282400b2e9ad7 + "poi group" );
            return spawns;
        }
    }
    
    var_e7fee629fee1b87f = var_c41693c82143133e function_d2ba18bc752fe8fa( poirule );
    var_e7fee629fee1b87f = var_e7fee629fee1b87f function_e5dcf502bd8f8434( poirule );
    var_e7fee629fee1b87f = var_e7fee629fee1b87f function_ea64cf87f2cfcc5e( poirule );
    spawns = function_d1e45146e40968b9( spawns, var_e7fee629fee1b87f );
    function_ae3769c411d239f2( "POI Group - " + poirule.var_dfe282400b2e9ad7 );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1a92
// Size: 0xc3
function private function_eec8d5bb79fb6ed5( spawnconfig )
{
    spawns = self;
    
    if ( !issharedfuncdefined( "poi", "isSystemActive" ) || ![[ getsharedfunc( "poi", "isSystemActive" ) ]]() )
    {
        function_8de891d666db43b1( "Global POI rules are being skipped as POI system is disabled" );
        return spawns;
    }
    
    foreach ( poiname in level.poi_names )
    {
        var_6ee9e5b5db0d84d3 = [[ getsharedfunc( "poi", "try_TranslatePOI" ) ]]( poiname );
        spawns = spawns function_25e8de075f034dd6( spawnconfig, var_6ee9e5b5db0d84d3 );
    }
    
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1b5e
// Size: 0xe1
function private function_25e8de075f034dd6( spawnconfig, poiname )
{
    spawns = self;
    possiblespawns = function_3e38027e10bb939c( poiname );
    
    if ( !isdefined( possiblespawns ) || possiblespawns.size == 0 )
    {
        return spawns;
    }
    
    [ spawns, var_e7fee629fee1b87f ] = spawns function_7d53ab524b68f69b( possiblespawns, 1 );
    
    if ( isdefined( spawnconfig.var_48b973d2a7eb9e64 ) )
    {
        var_e7fee629fee1b87f = var_e7fee629fee1b87f function_c54881e0e112bd31( possiblespawns, poiname, spawnconfig.var_48b973d2a7eb9e64 );
    }
    
    var_e7fee629fee1b87f = var_e7fee629fee1b87f function_569aa5d713ef47b4( possiblespawns, default_to( spawnconfig.var_48d9abd529d9d920, -1 ) );
    var_e7fee629fee1b87f = var_e7fee629fee1b87f function_b9019dc0e88433a6( default_to( spawnconfig.var_295277097b7b81ea, -1 ) );
    spawns = function_d1e45146e40968b9( spawns, var_e7fee629fee1b87f );
    spawns function_ae3769c411d239f2( "POI Global Single - " + poiname );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1c48
// Size: 0xc8
function private function_4ee587b4504098a8( spawnconfig )
{
    spawns = self;
    spawns = spawns function_9f97ff4837895235( spawnconfig );
    possiblespawns = level.ssc.indexes;
    spawns = spawns function_569aa5d713ef47b4( possiblespawns, default_to( spawnconfig.var_473fbf10b632a192, -1 ) );
    spawns = spawns function_b9019dc0e88433a6( default_to( spawnconfig.var_e79b6f0d46e45758, -1 ) );
    spawns = spawns function_71170b2ee942ae97( possiblespawns, spawnconfig.var_d63bff823de6d46a, undefined, spawnconfig.var_473fbf10b632a192 );
    spawns = spawns function_b9bbe4f989c19e1( possiblespawns, spawnconfig.var_ef46c86624a75b00, undefined, spawnconfig.var_473fbf10b632a192 );
    spawns function_ae3769c411d239f2( "Global" );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1d19
// Size: 0xd4
function private function_66099a164cfbc123( spawnconfig, hardonly )
{
    spawns = self;
    
    if ( function_8d5f739c58f8362f( spawnconfig.var_7e0d944014604011, hardonly ) && isdefined( spawnconfig.circle_final ) )
    {
        spawns = spawns function_8636d08653c34ceb( spawnconfig.var_12e867c36e7e466a, spawnconfig.circle_final );
    }
    
    if ( function_8d5f739c58f8362f( spawnconfig.var_22f17815c011174b, hardonly ) && isdefined( spawnconfig.circle_final ) )
    {
        spawns = spawns function_e4da4917382e57c5( spawnconfig.var_2bf330a7553ecd00, spawnconfig.circle_final );
    }
    
    hardstring = ter_op( istrue( hardonly ), " - Hard Only", "" );
    spawns function_ae3769c411d239f2( "BR" + hardstring );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1df6
// Size: 0x3c0
function private function_415a97db2da6dd7e( spawnconfig, hardonly )
{
    spawns = self;
    
    if ( function_8d5f739c58f8362f( spawnconfig.var_22002ed9c7d33de7, hardonly ) && isdefined( spawnconfig.var_8d58c4766a693034 ) )
    {
        foreach ( entry in spawnconfig.var_8d58c4766a693034 )
        {
            spawns = spawns function_e731bc132fb88fa7( default_to( entry.spawn_count, 0 ), entry.spawn_tag );
        }
    }
    
    if ( function_8d5f739c58f8362f( spawnconfig.var_817374b52a0f5265, hardonly ) && isdefined( spawnconfig.var_efbfbc603efe1c26 ) )
    {
        foreach ( entry in spawnconfig.var_efbfbc603efe1c26 )
        {
            spawns = spawns function_7cca096598bbed89( default_to( entry.spawn_count, 0 ), entry.spawn_tag );
        }
    }
    
    if ( function_8d5f739c58f8362f( spawnconfig.var_cc9ebd1c994451db, hardonly ) && isdefined( spawnconfig.var_3b460152154e4790 ) )
    {
        foreach ( entry in spawnconfig.var_3b460152154e4790 )
        {
            spawns = spawns function_21089f02e9597328( entry.spawn_distance, entry.script_struct );
        }
    }
    
    if ( function_8d5f739c58f8362f( spawnconfig.var_de56c3e0f9079e1, hardonly ) && isdefined( spawnconfig.var_318e2109bdf8fcfa ) )
    {
        foreach ( entry in spawnconfig.var_318e2109bdf8fcfa )
        {
            spawns = spawns function_25c58d881ed46c62( entry.spawn_distance, entry.script_struct );
        }
    }
    
    possiblespawns = level.ssc.indexes;
    
    if ( function_8d5f739c58f8362f( spawnconfig.var_6aa0b809ce5a31f8, hardonly ) && isdefined( spawnconfig.var_a8b01cf8030d00c5 ) )
    {
        foreach ( entry in spawnconfig.var_a8b01cf8030d00c5 )
        {
            spawns = spawns function_71170b2ee942ae97( possiblespawns, entry.spawn_distance, entry.script_struct );
        }
    }
    
    if ( function_8d5f739c58f8362f( spawnconfig.var_f9bfec3775efb6da, hardonly ) && isdefined( spawnconfig.var_b21135f7c628c393 ) )
    {
        foreach ( entry in spawnconfig.var_b21135f7c628c393 )
        {
            spawns = spawns function_b9bbe4f989c19e1( possiblespawns, entry.spawn_distance, entry.script_struct );
        }
    }
    
    hardstring = ter_op( istrue( hardonly ), " - Hard Only", "" );
    spawns function_ae3769c411d239f2( "Base" + hardstring );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x21bf
// Size: 0x3d
function private function_ae3769c411d239f2( rule )
{
    spawns = self;
    function_49dec75a702536c8( "After " + rule + ", spawns has " + spawns.size + " entries" );
    function_56b91bfbefdc7456( spawns );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2204
// Size: 0xee
function private function_b632c72bbf401a8b( spawnconfig )
{
    spawns = self;
    
    if ( !isdefined( spawnconfig.var_ac34ab4f5f1df619 ) || spawnconfig.var_ac34ab4f5f1df619.size == 0 )
    {
        return spawns;
    }
    
    spawnlist = [];
    
    foreach ( entry in spawnconfig.var_ac34ab4f5f1df619 )
    {
        spawnlist[ entry.spawn_number ] = entry.spawn_number;
    }
    
    notfound = function_288718db33265376( spawnlist, level.ssc.indexes );
    spawnlist = function_288718db33265376( spawnlist, notfound );
    function_9a9be496c58cfe3b( spawnlist, notfound );
    spawns = function_d1e45146e40968b9( spawns, spawnlist );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x22fb
// Size: 0x73
function private function_9a9be496c58cfe3b( spawnlist, notfound )
{
    spawns = self;
    newentries = function_288718db33265376( spawnlist, spawns );
    function_49dec75a702536c8( "Rule Force - Added " + newentries.size + " new spawns" );
    function_56b91bfbefdc7456( newentries );
    
    if ( notfound.size != 0 )
    {
        function_49dec75a702536c8( "Rule Force - Not Found contained " + newentries.size + " spawns" );
        function_56b91bfbefdc7456( notfound );
    }
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2376
// Size: 0xbf
function private function_7f381a0dc49788c9( spawnconfig )
{
    spawns = self;
    
    if ( !isdefined( spawnconfig.var_272018d23eeea527 ) || spawnconfig.var_272018d23eeea527.size == 0 )
    {
        return spawns;
    }
    
    blocklist = [];
    
    foreach ( entry in spawnconfig.var_272018d23eeea527 )
    {
        blocklist[ entry.spawn_number ] = entry.spawn_number;
    }
    
    blocklist function_165c62ea04e5f295();
    spawns = spawns function_d87d90deb439f354( blocklist );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x243e
// Size: 0x50
function private function_165c62ea04e5f295()
{
    blocklist = self;
    newentries = function_288718db33265376( blocklist, level.ssc.exclude );
    function_49dec75a702536c8( "Rule Block - Blocked " + newentries.size + " new spawns" );
    function_56b91bfbefdc7456( newentries );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2496
// Size: 0x8a
function private function_6f80cf558a58324d()
{
    spawnconfig = self;
    
    if ( !isdefined( spawnconfig.var_ef484827f08f9da4 ) || spawnconfig.var_ef484827f08f9da4.size == 0 )
    {
        return spawnconfig;
    }
    
    foreach ( pool in spawnconfig.var_ef484827f08f9da4 )
    {
        spawnconfig = spawnconfig function_99c92fc0c8a5de7e( pool );
    }
    
    return spawnconfig;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2529
// Size: 0x125
function private function_99c92fc0c8a5de7e( pool )
{
    spawnconfig = self;
    
    if ( pool.spawn_list.size == 0 )
    {
        return spawnconfig;
    }
    
    selectedcount = pool.spawn_count;
    spawnpool = array_randomize( pool.spawn_list );
    selectedspawns = array_slice( spawnpool, 0, selectedcount );
    unselectedspawns = array_slice( spawnpool, selectedcount, spawnpool.size );
    
    if ( istrue( pool.force_spawn ) )
    {
        if ( !isdefined( spawnconfig.var_ac34ab4f5f1df619 ) )
        {
            spawnconfig.var_ac34ab4f5f1df619 = selectedspawns;
        }
        else
        {
            spawnconfig.var_ac34ab4f5f1df619 = array_combine_unique( spawnconfig.var_ac34ab4f5f1df619, selectedspawns );
        }
    }
    
    if ( istrue( pool.force_block ) )
    {
        if ( !isdefined( spawnconfig.var_272018d23eeea527 ) )
        {
            spawnconfig.var_272018d23eeea527 = selectedspawns;
        }
        else
        {
            spawnconfig.var_272018d23eeea527 = array_combine_unique( spawnconfig.var_272018d23eeea527, unselectedspawns );
        }
    }
    
    pool function_998775833c1f6b91( selectedspawns, unselectedspawns );
    return spawnconfig;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2657
// Size: 0x144
function private function_998775833c1f6b91( spawnlist, blocklist )
{
    pool = self;
    function_49dec75a702536c8( "Spawn Pool" );
    
    if ( istrue( pool.force_spawn ) )
    {
        function_49dec75a702536c8( "Added " + spawnlist.size + " to Force Spawn List" );
        indexes = [];
        
        foreach ( entry in spawnlist )
        {
            indexes[ entry.spawn_number ] = entry.spawn_number;
        }
        
        function_56b91bfbefdc7456( indexes );
    }
    
    if ( istrue( pool.force_block ) )
    {
        function_49dec75a702536c8( "Added " + blocklist.size + " to Force Block List" );
        indexes = [];
        
        foreach ( entry in blocklist )
        {
            indexes[ entry.spawn_number ] = entry.spawn_number;
        }
        
        function_56b91bfbefdc7456( indexes );
    }
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x27a3
// Size: 0x16c
function private function_747ff5f8c0e96da5( weights, spawncount )
{
    if ( isdefined( spawncount ) )
    {
        foreach ( entry in weights )
        {
            if ( entry.spawn_count == spawncount )
            {
                return spawncount;
            }
        }
    }
    
    totalweight = 0;
    
    foreach ( entry in weights )
    {
        if ( isdefined( entry.spawn_weight ) )
        {
            totalweight += entry.spawn_weight;
        }
    }
    
    randomweight = 0;
    
    if ( totalweight > 0 )
    {
        randomweight = randomint( totalweight );
    }
    
    foreach ( entry in weights )
    {
        if ( isdefined( entry.spawn_weight ) )
        {
            randomweight -= entry.spawn_weight;
            
            if ( randomweight <= 0 )
            {
                return entry.spawn_count;
            }
        }
    }
    
    return weights[ weights.size - 1 ].spawn_count;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2918
// Size: 0x15e
function private function_c54881e0e112bd31( possiblespawns, poigroupname, weights )
{
    spawns = self;
    
    if ( !isdefined( weights ) || weights.size == 0 )
    {
        function_8de891d666db43b1( "POI Group" + poigroupname + " has no weights set" );
        return spawns;
    }
    
    spawncount = level.ssc.weights[ poigroupname ];
    level.ssc.weights[ poigroupname ] = function_747ff5f8c0e96da5( weights, spawncount );
    
    if ( level.ssc.weights[ poigroupname ] < 0 )
    {
        function_49dec75a702536c8( "Rule Weights - The chosen count weight for POI " + poigroupname + " was below 0. Setting to 0" );
        level.ssc.weights[ poigroupname ] = 0;
    }
    
    spawndifference = level.ssc.weights[ poigroupname ] - spawns.size;
    
    if ( spawndifference < 0 )
    {
        spawns = function_16059c8d75a938c4( spawns, abs( spawndifference ) );
    }
    else if ( spawndifference > 0 )
    {
        newspawns = function_3267104534037a6f( possiblespawns, spawndifference );
        spawns = function_d1e45146e40968b9( spawns, newspawns );
    }
    
    function_49dec75a702536c8( "Rule Weights - Weight rolled for POI " + poigroupname + " is " + level.ssc.weights[ poigroupname ] + " and spawn count was changed by " + spawndifference );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2a7f
// Size: 0x98
function private function_d2ba18bc752fe8fa( poirule )
{
    poispawns = self;
    
    if ( !isdefined( poirule.poi_group ) || !isdefined( poirule.var_dfe282400b2e9ad7 ) || !isdefined( poirule.var_c49eb61fdcdb5a08 ) || poirule.var_c49eb61fdcdb5a08.size == 0 )
    {
        return poispawns;
    }
    
    possiblespawns = function_a9515f5c0ddfbeee( poirule.poi_group );
    poispawns = poispawns function_c54881e0e112bd31( possiblespawns, poirule.var_dfe282400b2e9ad7, poirule.var_c49eb61fdcdb5a08 );
    return poispawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2b20
// Size: 0xa6
function private function_5b1350ccb1325b2e( poirule, groupindex )
{
    poispawns = self;
    
    if ( !isdefined( poirule.poi_group ) || !isdefined( poirule.poi_group[ groupindex ] ) || !isdefined( poirule.var_c49eb61fdcdb5a08 ) || poirule.var_c49eb61fdcdb5a08.size == 0 )
    {
        return poispawns;
    }
    
    possiblespawns = function_3e38027e10bb939c( poirule.poi_group[ groupindex ] );
    poispawns = poispawns function_c54881e0e112bd31( possiblespawns, poirule.poi_group[ groupindex ], poirule.var_c49eb61fdcdb5a08 );
    return poispawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2bcf
// Size: 0x74
function private function_9f97ff4837895235( spawnconfig )
{
    spawns = self;
    
    if ( !isdefined( spawnconfig.var_d0e74a43bfc6fd16 ) || spawnconfig.var_d0e74a43bfc6fd16.size == 0 )
    {
        return spawns;
    }
    
    possiblespawns = level.ssc.indexes;
    spawns = spawns function_c54881e0e112bd31( possiblespawns, "all", spawnconfig.var_d0e74a43bfc6fd16 );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x2c4c
// Size: 0x214
function private function_47d1ae54743cde58( possiblespawns, dist, var_6336c4046527f0d0, otherstruct, mincount )
{
    spawns = self;
    
    if ( !isdefined( dist ) || dist == 0 )
    {
        return spawns;
    }
    
    possiblespawns = function_288718db33265376( possiblespawns, level.ssc.exclude );
    possiblespawns = function_288718db33265376( possiblespawns, spawns );
    ruledistsq = dist * dist;
    spawntotal = spawns.size + possiblespawns.size;
    iterations = 0;
    removedspawns = [];
    goodspawns = [];
    
    while ( goodspawns.size != spawns.size )
    {
        removecandidates = [];
        testspawns = spawns function_e937d3b8b0cfa746( otherstruct );
        var_b09ce8a320e00634 = function_288718db33265376( spawns, goodspawns );
        
        if ( testspawns.size == 0 )
        {
            break;
        }
        
        [ removecandidates, goodspawns, iterations ] = testspawns function_2afe2b8c50eb1948( var_b09ce8a320e00634, goodspawns, ruledistsq, var_6336c4046527f0d0, iterations );
        [ goodspawns, removecandidates ] = spawns function_23e7aca8646231f4( removecandidates, goodspawns, mincount );
        [ spawns, possiblespawns, removedspawns ] = spawns function_d39bee1cd41ccecc( removecandidates, possiblespawns, removedspawns );
    }
    
    while ( removedspawns.size + goodspawns.size < spawntotal )
    {
        removecandidates = [];
        testspawns = spawns function_e937d3b8b0cfa746( otherstruct );
        
        if ( testspawns.size == 0 )
        {
            break;
        }
        
        [ removecandidates, goodspawns, iterations ] = testspawns function_2afe2b8c50eb1948( possiblespawns, goodspawns, ruledistsq, var_6336c4046527f0d0, iterations );
        [ var_f103d71371007a3c, possiblespawns, removedspawns ] = possiblespawns function_d39bee1cd41ccecc( removecandidates, possiblespawns, removedspawns );
    }
    
    function_8f9075696d29fca8( removedspawns, iterations, otherstruct );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2e69
// Size: 0x79
function private function_e937d3b8b0cfa746( otherstruct )
{
    spawns = self;
    
    if ( isdefined( otherstruct ) )
    {
        assert( isdefined( level.ssc.spawns[ otherstruct ] ), "<dev string:x21>" + otherstruct + "<dev string:x2d>" );
        return level.ssc.spawns[ otherstruct ];
    }
    
    return function_288718db33265376( spawns, level.ssc.exclude );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2eeb
// Size: 0x41
function private function_e56f32755a367eba( struct, testindex )
{
    if ( isint( struct ) )
    {
        if ( struct == testindex )
        {
            return undefined;
        }
        
        return function_7a0a1c8e4051f836( struct ).origin;
    }
    
    return struct.origin;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x2f35
// Size: 0x152
function private function_2afe2b8c50eb1948( var_b09ce8a320e00634, goodspawns, ruledistsq, var_6336c4046527f0d0, iterations )
{
    spawns = self;
    highestscore = 0;
    removecandidates = [];
    
    foreach ( entry in var_b09ce8a320e00634 )
    {
        [ removeindexes, iterations ] = spawns [[ var_6336c4046527f0d0 ]]( entry, ruledistsq, iterations );
        
        if ( isdefined( removeindexes ) )
        {
            removecandidates[ entry ] = [];
            removecandidates[ entry ] = removeindexes;
            
            if ( removeindexes.size > highestscore )
            {
                highestscore = removeindexes.size;
            }
            
            continue;
        }
        
        if ( isdefined( goodspawns ) )
        {
            goodspawns[ entry ] = entry;
        }
    }
    
    foreach ( key, value in removecandidates )
    {
        if ( value.size == highestscore )
        {
            removecandidates[ key ] = key;
            continue;
        }
        
        removecandidates[ key ] = undefined;
    }
    
    return [ removecandidates, goodspawns, iterations ];
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x3090
// Size: 0xe2
function private function_8ee15acd9ec71bc7( index, minimumsq, iterations )
{
    spawns = self;
    origin = function_7a0a1c8e4051f836( index ).origin;
    removelist = undefined;
    
    foreach ( entry in spawns )
    {
        iterations++;
        testorigin = function_e56f32755a367eba( entry, index );
        
        if ( !isdefined( testorigin ) )
        {
            continue;
        }
        
        testdistsq = distancesquared( origin, testorigin );
        
        if ( testdistsq < minimumsq )
        {
            if ( !isdefined( removelist ) )
            {
                removelist = [];
            }
            
            removelist[ entry ] = entry;
        }
    }
    
    return [ removelist, iterations ];
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x317b
// Size: 0xec
function private function_8f65abc44b0ed8f1( index, maximumsq, iterations )
{
    spawns = self;
    origin = function_7a0a1c8e4051f836( index ).origin;
    
    foreach ( entry in spawns )
    {
        iterations++;
        testorigin = function_e56f32755a367eba( entry, index );
        
        if ( !isdefined( testorigin ) )
        {
            continue;
        }
        
        testdistsq = distancesquared( origin, testorigin );
        
        if ( testdistsq > maximumsq )
        {
            continue;
        }
        
        return [ undefined, iterations ];
    }
    
    removelist = [];
    removelist[ index ] = index;
    return [ removelist, iterations ];
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x3270
// Size: 0x8b
function private function_d39bee1cd41ccecc( removearray, possiblespawns, removedspawns )
{
    spawns = self;
    
    if ( removearray.size == 0 )
    {
        return [ spawns, possiblespawns, removedspawns ];
    }
    
    spawns = spawns function_d87d90deb439f354( removearray );
    possiblespawns = function_288718db33265376( possiblespawns, removearray );
    newspawns = function_3267104534037a6f( possiblespawns, removearray.size );
    spawns = function_d1e45146e40968b9( spawns, newspawns );
    removedspawns = function_d1e45146e40968b9( removedspawns, removearray );
    return [ spawns, possiblespawns, removedspawns ];
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x3304
// Size: 0x53
function private function_8f9075696d29fca8( removedspawns, iterations, otherstruct )
{
    function_49dec75a702536c8( "Rule Dist - There were " + removedspawns.size + " spawns removed over " + iterations + " iterations" );
    
    if ( isdefined( otherstruct ) )
    {
        function_49dec75a702536c8( "Rule Dist - The other struct is " + otherstruct );
    }
    
    function_56b91bfbefdc7456( removedspawns );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x335f
// Size: 0xd8
function private function_23e7aca8646231f4( removearray, goodspawns, mincount )
{
    spawns = self;
    
    if ( isdefined( mincount ) )
    {
        var_b706f618361c154a = spawns.size - removearray.size;
        
        if ( var_b706f618361c154a < mincount && removearray.size > 0 )
        {
            var_dc25bf936986be4d = [];
            
            for ( i = 0; i < mincount - var_b706f618361c154a ; i++ )
            {
                randomspawn = function_b2cd26ac28946ea7( removearray );
                
                if ( isdefined( randomspawn ) )
                {
                    removearray = removearray function_32f74a46f0bb2dd9( removearray, randomspawn );
                    var_dc25bf936986be4d[ randomspawn ] = randomspawn;
                }
            }
            
            debug_print( "Rule Dist - There are " + var_dc25bf936986be4d.size + " spawns that break the distance rule being spawned. These were chosen to spawn anyways to ensure that the min spawn amount rule is followed." );
            function_56b91bfbefdc7456( var_dc25bf936986be4d );
        }
    }
    
    var_9dbad6e6ad4bc864 = function_d1e45146e40968b9( goodspawns, var_dc25bf936986be4d );
    return [ var_9dbad6e6ad4bc864, removearray ];
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x3440
// Size: 0x43
function private function_71170b2ee942ae97( possiblespawns, dist, otherstruct, mincount )
{
    spawns = self;
    spawns = spawns function_47d1ae54743cde58( possiblespawns, dist, &function_8ee15acd9ec71bc7, otherstruct, mincount );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x348c
// Size: 0xa3
function private function_3b3747a18eeec63b( possiblespawns, dist, groupstring, mincount )
{
    if ( !isdefined( groupstring ) )
    {
        groupstring = "Group";
    }
    
    spawns = self;
    [ spawns, currentspawns ] = spawns function_7d53ab524b68f69b( possiblespawns );
    newspawns = currentspawns function_71170b2ee942ae97( possiblespawns, dist, undefined, mincount );
    spawns = function_d1e45146e40968b9( spawns, newspawns );
    function_49dec75a702536c8( "Rule Dist Group Min - " + groupstring + " has ended with " + newspawns.size + " spawns" );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3538
// Size: 0xa3
function private function_e5dcf502bd8f8434( poirule )
{
    spawns = self;
    
    if ( !isdefined( poirule.var_dfe282400b2e9ad7 ) || !isdefined( poirule.poi_group ) || !isdefined( poirule.var_4a8d43d74b119570 ) )
    {
        return spawns;
    }
    
    possiblespawns = function_a9515f5c0ddfbeee( poirule.poi_group );
    spawns = spawns function_3b3747a18eeec63b( possiblespawns, poirule.var_4a8d43d74b119570, "POI Group" + poirule.var_dfe282400b2e9ad7, poirule.var_c49eb61fdcdb5a08[ 0 ].spawn_count );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x35e4
// Size: 0x57
function private function_21089f02e9597328( dist, tag )
{
    spawns = self;
    possiblespawns = function_f1111e4fc4599bac( level.ssc.indexes, tag );
    spawns = spawns function_3b3747a18eeec63b( possiblespawns, dist, "Tag " + tag );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x3644
// Size: 0x43
function private function_b9bbe4f989c19e1( possiblespawns, dist, otherstruct, mincount )
{
    spawns = self;
    spawns = spawns function_47d1ae54743cde58( possiblespawns, dist, &function_8f65abc44b0ed8f1, otherstruct, mincount );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x3690
// Size: 0xa5
function private function_b1c829bfd0ebbc8d( possiblespawns, dist, groupstring, mincount )
{
    if ( !isdefined( groupstring ) )
    {
        groupstring = "Group";
    }
    
    spawns = self;
    [ spawns, currentspawns ] = spawns function_7d53ab524b68f69b( possiblespawns, 1 );
    newspawns = currentspawns function_b9bbe4f989c19e1( possiblespawns, dist, undefined, mincount );
    spawns = function_d1e45146e40968b9( spawns, newspawns );
    function_49dec75a702536c8( "Rule Dist Group Max - " + groupstring + " has ended with " + newspawns.size + " spawns" );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x373e
// Size: 0xb4
function private function_ea64cf87f2cfcc5e( poirule )
{
    spawns = self;
    
    if ( !isdefined( poirule.var_dfe282400b2e9ad7 ) || !isdefined( poirule.poi_group ) || !isdefined( poirule.var_af067ae8c152b0da ) || poirule.var_af067ae8c152b0da == 0 )
    {
        return spawns;
    }
    
    possiblespawns = function_a9515f5c0ddfbeee( poirule.poi_group );
    spawns = spawns function_b1c829bfd0ebbc8d( possiblespawns, poirule.var_af067ae8c152b0da, "POI " + poirule.var_dfe282400b2e9ad7, poirule.var_c49eb61fdcdb5a08[ 0 ].spawn_count );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x37fb
// Size: 0x57
function private function_25c58d881ed46c62( dist, tag )
{
    spawns = self;
    possiblespawns = function_f1111e4fc4599bac( level.ssc.indexes, tag );
    spawns = spawns function_b1c829bfd0ebbc8d( possiblespawns, dist, "Tag " + tag );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x385b
// Size: 0x8a
function private function_569aa5d713ef47b4( possiblespawns, minimum )
{
    spawns = self;
    
    if ( !isdefined( minimum ) || minimum == -1 || spawns.size >= minimum )
    {
        return spawns;
    }
    
    possiblespawns = function_288718db33265376( possiblespawns, spawns );
    addcount = minimum - spawns.size;
    newspawns = function_3267104534037a6f( possiblespawns, addcount );
    spawns = function_d1e45146e40968b9( spawns, newspawns );
    function_49dec75a702536c8( "Rule Count Min - " + newspawns.size + " spawns were added" );
    function_56b91bfbefdc7456( newspawns );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x38ee
// Size: 0x8d
function private function_d51b2ccdfb4d9508( possiblespawns, minimum, groupstring )
{
    spawns = self;
    [ spawns, currentspawns ] = spawns function_7d53ab524b68f69b( possiblespawns, 1 );
    newspawns = currentspawns function_569aa5d713ef47b4( possiblespawns, minimum );
    spawns = function_d1e45146e40968b9( spawns, newspawns );
    function_49dec75a702536c8( "Rule Count Group Min - " + groupstring + " has ended with " + newspawns.size + " spawns" );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3984
// Size: 0x57
function private function_e731bc132fb88fa7( minimum, tag )
{
    spawns = self;
    possiblespawns = function_f1111e4fc4599bac( level.ssc.indexes, tag );
    spawns = spawns function_d51b2ccdfb4d9508( possiblespawns, minimum, "Tag " + tag );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x39e4
// Size: 0x57
function private function_8636d08653c34ceb( minimum, circlefinal )
{
    spawns = self;
    possiblespawns = function_8a35cd250e4360b8( level.ssc.indexes, circlefinal );
    spawns = spawns function_d51b2ccdfb4d9508( possiblespawns, minimum, "Circle " + circlefinal );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3a44
// Size: 0x5d
function private function_b9019dc0e88433a6( maximum )
{
    spawns = self;
    
    if ( !isdefined( maximum ) || maximum == -1 || spawns.size <= maximum )
    {
        return spawns;
    }
    
    removecount = spawns.size - maximum;
    spawns = function_16059c8d75a938c4( spawns, removecount );
    function_49dec75a702536c8( "Rule Count Max - " + removecount + " spawns were removed" );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x3aaa
// Size: 0x8b
function private function_86ee889ccb1effb2( possiblespawns, maximum, groupstring )
{
    spawns = self;
    [ spawns, currentspawns ] = spawns function_7d53ab524b68f69b( possiblespawns, 1 );
    newspawns = currentspawns function_b9019dc0e88433a6( maximum );
    spawns = function_d1e45146e40968b9( spawns, newspawns );
    function_49dec75a702536c8( "Rule Count Group Max - " + groupstring + " has ended with " + newspawns.size + " spawns" );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3b3e
// Size: 0x57
function private function_7cca096598bbed89( maximum, tag )
{
    spawns = self;
    possiblespawns = function_f1111e4fc4599bac( level.ssc.indexes, tag );
    spawns = spawns function_86ee889ccb1effb2( possiblespawns, maximum, "Tag " + tag );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3b9e
// Size: 0x57
function private function_e4da4917382e57c5( maximum, circlefinal )
{
    spawns = self;
    possiblespawns = function_8a35cd250e4360b8( level.ssc.indexes, circlefinal );
    spawns = spawns function_86ee889ccb1effb2( possiblespawns, maximum, "Circle " + circlefinal );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3bfe
// Size: 0xc2
function private ssc_spawn( scriptstruct, index )
{
    if ( !isdefined( level.ssc.var_6639b9dad892b886 ) || !isdefined( level.ssc.var_6639b9dad892b886[ scriptstruct ] ) )
    {
        return;
    }
    
    mapstruct = function_7a0a1c8e4051f836( index );
    newspawn = [[ level.ssc.var_6639b9dad892b886[ scriptstruct ] ]]( scriptstruct, mapstruct );
    newspawn.var_2c754a023b081c20 = index;
    size = level.ssc.spawns[ scriptstruct ].size;
    level.ssc.spawns[ scriptstruct ][ size ] = newspawn;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3cc8
// Size: 0x20
function private function_7a0a1c8e4051f836( key )
{
    return level.ssc.structs[ key ];
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3cf1
// Size: 0x78
function private function_3e38027e10bb939c( poiname )
{
    poispawns = [];
    poistructs = function_7a0a1c8e4051f836( poiname );
    
    if ( !isdefined( poistructs ) )
    {
        return poispawns;
    }
    
    foreach ( key, value in poistructs )
    {
        poispawns[ key ] = key;
    }
    
    return poispawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3d72
// Size: 0xac
function private function_a9515f5c0ddfbeee( poi_group )
{
    var_10d77e0383000d33 = [];
    
    foreach ( key in poi_group )
    {
        poispawns = function_3e38027e10bb939c( key.poi_name );
        [ var_10d77e0383000d33, var_af7a88cb662b0b40 ] = var_10d77e0383000d33 function_7d53ab524b68f69b( poispawns, 1 );
        var_10d77e0383000d33 = array_combine_unique_keys( var_10d77e0383000d33, poispawns );
    }
    
    return var_10d77e0383000d33;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3e27
// Size: 0x9a
function private function_f1111e4fc4599bac( spawns, tag )
{
    tagspawns = [];
    
    foreach ( entry in spawns )
    {
        struct = function_7a0a1c8e4051f836( entry );
        
        if ( isdefined( struct.script_noteworthy ) && struct.script_noteworthy == tag )
        {
            tagspawns[ entry ] = entry;
        }
    }
    
    return tagspawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3eca
// Size: 0x12c
function private function_8a35cd250e4360b8( spawns, circleindex )
{
    circlespawns = [];
    
    if ( !isdefined( circleindex ) )
    {
        return circlespawns;
    }
    
    if ( !issharedfuncdefined( "game", "isFeatureEnabled" ) || ![[ getsharedfunc( "game", "isFeatureEnabled" ) ]]( "circle" ) )
    {
        return circlespawns;
    }
    
    if ( !issharedfuncdefined( "game", "getTimeTillCircleClosing" ) || !issharedfuncdefined( "game", "getTimeTillDangerForPoint" ) )
    {
        return circlespawns;
    }
    
    foreach ( entry in spawns )
    {
        struct = function_7a0a1c8e4051f836( entry );
        dangertime = [[ getsharedfunc( "game", "getTimeTillDangerForPoint" ) ]]( struct.origin );
        circleend = [[ getsharedfunc( "game", "getTimeTillCircleClosing" ) ]]( circleindex );
        
        if ( dangertime > circleend )
        {
            circlespawns[ entry ] = entry;
        }
    }
    
    return circlespawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3fff
// Size: 0x51
function private function_4784966d3ce7dba9( structname )
{
    if ( !isdefined( level.ssc.funcgetlocations[ structname ] ) )
    {
        return [];
    }
    
    structlocations = [[ level.ssc.funcgetlocations[ structname ] ]]( structname );
    return array_sort_by_script_index( structlocations );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4059
// Size: 0xbd
function private function_3bde2c46d3361035( struct )
{
    var_99115d832ea03fdf = issharedfuncdefined( "poi", "isSystemActive" ) && issharedfuncdefined( "poi", "findPOIOriginIsIn" );
    structpoi = struct.poi;
    
    if ( !isdefined( structpoi ) && istrue( var_99115d832ea03fdf ) && [[ getsharedfunc( "poi", "isSystemActive" ) ]]() )
    {
        structpoi = [[ getsharedfunc( "poi", "findPOIOriginIsIn" ) ]]( struct.origin );
        structpoi = [[ getsharedfunc( "poi", "try_TranslatePOI" ) ]]( structpoi );
    }
    else
    {
        structpoi = "none";
    }
    
    if ( !isdefined( structpoi ) )
    {
        structpoi = "none";
    }
    
    return structpoi;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x411f
// Size: 0x55
function private function_400ac4c375b471a1( scriptindex )
{
    indexes = level.ssc.indexes;
    
    if ( isdefined( scriptindex ) )
    {
        if ( !isdefined( indexes[ scriptindex ] ) )
        {
            return scriptindex;
        }
        
        assertmsg( "<dev string:x4d>" + scriptindex + "<dev string:x8e>" );
    }
    
    return function_4e39e2d66e2d1948( indexes );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x417d
// Size: 0x27
function private function_4e39e2d66e2d1948( var_d57a27cd0f4ec676 )
{
    for ( i = 1; isdefined( var_d57a27cd0f4ec676[ i ] ) ; i++ )
    {
    }
    
    return i;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x41ad
// Size: 0x5a
function private util_exclude( spawns )
{
    if ( !isarray( spawns ) )
    {
        level.ssc.exclude[ spawns ] = spawns;
        return;
    }
    
    level.ssc.exclude = function_d1e45146e40968b9( level.ssc.exclude, spawns );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x420f
// Size: 0x35, Type: bool
function private function_8d5f739c58f8362f( rulesetting, hardonly )
{
    if ( !isdefined( rulesetting ) || rulesetting == "none" )
    {
        return false;
    }
    
    if ( istrue( hardonly ) )
    {
        return ( rulesetting == "hard" );
    }
    
    return true;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x424d
// Size: 0x32
function private util_remove( index )
{
    spawns = self;
    
    if ( !isdefined( index ) )
    {
        return spawns;
    }
    
    util_exclude( index );
    spawns = function_32f74a46f0bb2dd9( spawns, index );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4288
// Size: 0x6c
function private function_d87d90deb439f354( array )
{
    spawns = self;
    
    if ( !isdefined( array ) )
    {
        return spawns;
    }
    
    foreach ( entry in array )
    {
        spawns = spawns util_remove( entry );
    }
    
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x42fd
// Size: 0x86
function private function_b7913c455f72d892( listref, type )
{
    liststrings = strtok( listref, " " );
    var_c7803e864d499dc0 = [];
    
    foreach ( list in liststrings )
    {
        var_c7803e864d499dc0[ var_c7803e864d499dc0.size ] = function_9a62bf0437306755( list, type );
    }
    
    return var_c7803e864d499dc0;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x438c
// Size: 0x66
function private function_9a62bf0437306755( listref, type )
{
    bundlename = listref;
    
    if ( !isxhashasset( listref ) )
    {
        bundlename = getxhashasset( default_to( type, "" ) + listref );
    }
    
    configbundle = getscriptbundle( bundlename );
    assertex( isdefined( configbundle ), "<dev string:xbe>" + getxhashsourcename( bundlename ) );
    return configbundle;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x43fb
// Size: 0x7b
function private function_d72b66a120f30bba( var_c7803e864d499dc0 )
{
    if ( !isdefined( var_c7803e864d499dc0 ) )
    {
        assertex( isdefined( var_c7803e864d499dc0 ), "<dev string:xf3>" );
        return;
    }
    
    configlist = [];
    
    foreach ( configbundle in var_c7803e864d499dc0 )
    {
        configlist = function_219da70f303de5b( configbundle, configlist );
    }
    
    return configlist;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x447f
// Size: 0x9e
function private function_219da70f303de5b( configbundle, configlist )
{
    if ( !isdefined( configbundle ) )
    {
        assertex( isdefined( configbundle ), "<dev string:xf3>" );
        return;
    }
    
    var_7913786b1f47a997 = default_to( configlist, [] );
    
    foreach ( entry in configbundle.config_list )
    {
        var_7913786b1f47a997 = function_7dbb2f79e1942e4d( var_7913786b1f47a997, entry.config );
    }
    
    return var_7913786b1f47a997;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x4526
// Size: 0x61
function private function_7dbb2f79e1942e4d( configlist, var_ca2c833762e5466c, type )
{
    config = function_9a62bf0437306755( var_ca2c833762e5466c, type );
    
    if ( !isdefined( config ) )
    {
        assertex( isdefined( config ), "<dev string:x119>" );
        return configlist;
    }
    
    configlist = configlist function_32bde5f3b80bb14a( config.script_struct );
    configlist[ configlist.size ] = config;
    return configlist;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4590
// Size: 0x75
function private function_32bde5f3b80bb14a( var_48380029fbb1007a )
{
    configlist = self;
    
    foreach ( config in configlist )
    {
        if ( config.script_struct == var_48380029fbb1007a )
        {
            configlist = array_remove( configlist, config );
        }
    }
    
    return configlist;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x460e
// Size: 0x86
function private function_3267104534037a6f( possiblespawns, count )
{
    possiblespawns = function_288718db33265376( possiblespawns, level.ssc.exclude );
    newspawns = [];
    
    for ( i = 0; i < count ; i++ )
    {
        if ( possiblespawns.size == 0 )
        {
            break;
        }
        
        randomspawn = function_b2cd26ac28946ea7( possiblespawns );
        possiblespawns = function_32f74a46f0bb2dd9( possiblespawns, randomspawn );
        newspawns[ randomspawn ] = randomspawn;
    }
    
    newspawns function_b301207ce4ffa1d7();
    return newspawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x469d
// Size: 0x2c
function private function_b301207ce4ffa1d7()
{
    newspawns = self;
    function_49dec75a702536c8( "Struct Add - Adding " + newspawns.size + " new spawns" );
    function_56b91bfbefdc7456( newspawns );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x46d1
// Size: 0x6a
function private function_16059c8d75a938c4( spawns, count )
{
    removedspawns = [];
    
    for ( i = 0; i < count ; i++ )
    {
        if ( spawns.size == 0 )
        {
            return spawns;
        }
        
        randomspawn = function_b2cd26ac28946ea7( spawns );
        spawns = spawns util_remove( randomspawn );
        removedspawns[ removedspawns.size ] = randomspawn;
    }
    
    removedspawns function_89feae59bdc8918c();
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x4744
// Size: 0x2c
function private function_89feae59bdc8918c()
{
    removedspawns = self;
    function_49dec75a702536c8( "Struct Remove - Removing " + removedspawns.size + " spawns" );
    function_56b91bfbefdc7456( removedspawns );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4778
// Size: 0x63
function private function_288718db33265376( array1, array2 )
{
    if ( !isdefined( array2 ) )
    {
        return array1;
    }
    
    foreach ( entry in array2 )
    {
        array1[ entry ] = undefined;
    }
    
    return array1;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x47e4
// Size: 0x1f
function private function_32f74a46f0bb2dd9( array, index )
{
    if ( !isdefined( index ) )
    {
        return array;
    }
    
    array[ index ] = undefined;
    return array;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x480c
// Size: 0x64
function private function_d1e45146e40968b9( array1, array2 )
{
    if ( !isdefined( array2 ) )
    {
        return array1;
    }
    
    foreach ( entry in array2 )
    {
        array1[ entry ] = entry;
    }
    
    return array1;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4879
// Size: 0xa5
function private function_7d53ab524b68f69b( var_dcdc767aeea40c3a, remove )
{
    spawns = self;
    
    if ( !isdefined( var_dcdc767aeea40c3a ) )
    {
        return [ spawns, [] ];
    }
    
    overlap = [];
    
    foreach ( entry in spawns )
    {
        if ( isdefined( var_dcdc767aeea40c3a[ entry ] ) )
        {
            overlap[ entry ] = entry;
        }
    }
    
    if ( istrue( remove ) )
    {
        spawns = function_288718db33265376( spawns, overlap );
    }
    
    return [ spawns, overlap ];
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4927
// Size: 0x8b
function private function_b2cd26ac28946ea7( array )
{
    if ( !isdefined( array ) || array.size == 0 )
    {
        return undefined;
    }
    
    randomcount = randomint( array.size );
    randomentry = undefined;
    
    foreach ( entry in array )
    {
        randomentry = entry;
        randomcount--;
        
        if ( randomcount < 0 )
        {
            break;
        }
    }
    
    return randomentry;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x49bb
// Size: 0x32
function private debug_print( text )
{
    /#
        if ( getdvarint( @"hash_8b6143a0fa7f37a6", 1 ) < 1 )
        {
            return;
        }
        
        println( "<dev string:x14e>" + text );
    #/
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x49f5
// Size: 0x32
function private function_8de891d666db43b1( text )
{
    /#
        if ( getdvarint( @"hash_8b6143a0fa7f37a6", 1 ) < 2 )
        {
            return;
        }
        
        println( "<dev string:x158>" + text );
    #/
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4a2f
// Size: 0x32
function private function_49dec75a702536c8( text )
{
    /#
        if ( getdvarint( @"hash_8b6143a0fa7f37a6", 1 ) < 3 )
        {
            return;
        }
        
        println( "<dev string:x16c>" + text );
    #/
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4a69
// Size: 0x88
function private function_56b91bfbefdc7456( array )
{
    /#
        if ( getdvarint( @"hash_8b6143a0fa7f37a6", 1 ) < 3 )
        {
            return;
        }
        
        if ( !isdefined( array ) || array.size == 0 )
        {
            return;
        }
        
        var_6c46abea90157067 = function_5f4abcf527639ec2( array );
        arraystring = "<dev string:x17c>";
        
        for ( i = 0; i < var_6c46abea90157067.size ; i++ )
        {
            arraystring += var_6c46abea90157067[ i ] + "<dev string:x1c>";
        }
        
        println( "<dev string:x180>" + arraystring );
    #/
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4af9
// Size: 0x6f
function private function_5f4abcf527639ec2( var_e9df1a60f3b537c2 )
{
    var_6c46abea90157067 = [];
    
    foreach ( entry in var_e9df1a60f3b537c2 )
    {
        var_6c46abea90157067[ var_6c46abea90157067.size ] = entry;
    }
    
    var_6c46abea90157067 = array_sort_with_func( var_6c46abea90157067, &function_c0b52f72ada4834c );
    return var_6c46abea90157067;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2
// Checksum 0x0, Offset: 0x4b71
// Size: 0x16, Type: bool
function function_c0b52f72ada4834c( left, right )
{
    return left < right;
}

/#

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x4b90
    // Size: 0x119, Type: dev
    function private init_debug()
    {
        function_6e7290c8ee4f558b( "<dev string:x192>" );
        add_devgui_command( "<dev string:x1b4>", "<dev string:x1c8>" );
        add_devgui_command( "<dev string:x1e6>", "<dev string:x1f6>" );
        add_devgui_command( "<dev string:x217>", "<dev string:x22b>" );
        function_fe953f000498048f();
        function_6e7290c8ee4f558b( "<dev string:x24a>" );
        add_devgui_command( "<dev string:x279>", "<dev string:x289>" );
        add_devgui_command( "<dev string:x2b6>", "<dev string:x2c5>" );
        add_devgui_command( "<dev string:x2f1>", "<dev string:x301>" );
        add_devgui_command( "<dev string:x32e>", "<dev string:x342>" );
        add_devgui_command( "<dev string:x373>", "<dev string:x385>" );
        add_devgui_command( "<dev string:x3b5>", "<dev string:x3c2>" );
        add_devgui_command( "<dev string:x3ed>", "<dev string:x3fd>" );
        add_devgui_command( "<dev string:x42a>", "<dev string:x43f>" );
        add_devgui_command( "<dev string:x474>", "<dev string:x48b>" );
        add_devgui_command( "<dev string:x4bf>", "<dev string:x4d0>" );
        add_devgui_command( "<dev string:x4fe>", "<dev string:x517>" );
        function_fe953f000498048f();
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x4cb1
    // Size: 0x89, Type: dev
    function private debug_thread()
    {
        thread debug_watch( @"hash_e4a633370d1ef223", &debug_draw );
        thread debug_watch( @"hash_e131fa7eb854022b", &function_f01b154aa1fe41cb );
        thread debug_watch( @"hash_dabca9d7fe9cee2a", &function_39432dc2e39e328a );
        thread debug_watch( @"hash_f9cebbc2fc0ec02f", &function_cb22b100665fa1b4 );
        thread debug_watch( @"hash_c58cb33610933aa4", &function_34ae4f6043bcb29a );
        thread debug_watch( @"hash_988831f42004ed6b", &function_1c9f19f5e86da1ab );
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x4d42
    // Size: 0x77, Type: dev
    function private debug_watch( dvarstring, funcdebug )
    {
        level endon( "<dev string:x546>" );
        
        while ( true )
        {
            debugstate = getdvar( dvarstring, "<dev string:x17c>" );
            
            if ( debugstate == "<dev string:x17c>" )
            {
                waitframe();
                continue;
            }
            
            setdvar( dvarstring, "<dev string:x17c>" );
            debug_print( "<dev string:x554>" + getxhashsourcename( dvarstring ) + "<dev string:x560>" + debugstate );
            [[ funcdebug ]]( debugstate );
            waitframe();
        }
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x4dc1
    // Size: 0xd2, Type: dev
    function private debug_draw( scriptstruct, spawns )
    {
        spawnconfig = spawnstruct();
        spawnconfig.script_struct = scriptstruct;
        function_8d6027e6daa80c1d( spawnconfig, 2 );
        debug_cleanup();
        iprintlnbold( "<dev string:x56a>" + scriptstruct + "<dev string:x587>" );
        
        if ( spawns == undefined )
        {
            spawns = level.ssc.indexes;
        }
        
        foreach ( entry in spawns )
        {
            function_dd01b38da430e244( scriptstruct, entry );
        }
        
        level.ssc.drawcount++;
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x4e9b
    // Size: 0x42, Type: dev
    function private function_f60985255e4b2819()
    {
        offset = getdvarint( @"hash_5ec6f63fa858b195", 1 );
        drawindex = level.ssc.drawcount - offset;
        return drawindex;
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x4ee5
    // Size: 0xb1, Type: dev
    function private function_dd01b38da430e244( scriptstruct, index )
    {
        origin = default_to( function_7a0a1c8e4051f836( index ).origin, ( 0, 0, 0 ) );
        angles = default_to( function_7a0a1c8e4051f836( index ).angles, ( 0, 0, 0 ) );
        color = default_to( level.ssc.colors[ scriptstruct ], ( 1, 1, 1 ) );
        function_fd78bc2f959fe5cc( index, origin, angles, color );
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 4, eflags: 0x4
    // Checksum 0x0, Offset: 0x4f9e
    // Size: 0xfc, Type: dev
    function private function_fd78bc2f959fe5cc( text, origin, angles, color )
    {
        forward = anglestoforward( angles );
        timesec = getdvarint( @"hash_1e06d12003d4c5bf", 15 );
        timeframes = int( timesec / level.framedurationseconds );
        thread function_51c00e624bf397fd( text, origin, color, timeframes );
        ray = origin + ( 0, 0, 20000 );
        forwardpos = origin + forward * 75;
        thread draw_line_for_time( origin, ray, color[ 0 ], color[ 1 ], color[ 2 ], timesec, "<dev string:x594>" + level.ssc.drawcount );
        thread draw_arrow_time( origin, forwardpos, color, timesec, "<dev string:x594>" + level.ssc.drawcount );
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 4, eflags: 0x4
    // Checksum 0x0, Offset: 0x50a2
    // Size: 0x79, Type: dev
    function private function_51c00e624bf397fd( text, origin, color, timeframes )
    {
        level endon( "<dev string:x594>" + level.ssc.drawcount );
        
        while ( timeframes > 0 )
        {
            print3d( origin, text, color, 1, 60, 10 );
            timeframes -= 10;
            timesec = 10 * level.framedurationseconds;
            wait timesec;
        }
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x5123
    // Size: 0x25, Type: dev
    function private debug_cleanup( drawindex )
    {
        if ( !isdefined( drawindex ) )
        {
            drawindex = function_f60985255e4b2819();
        }
        
        level notify( "<dev string:x594>" + drawindex );
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x5150
    // Size: 0x3e, Type: dev
    function private function_f01b154aa1fe41cb( listref )
    {
        if ( listref == "<dev string:x5a5>" )
        {
            listref = getdvar( @"hash_8e30f7eeea837de6", "<dev string:x17c>" );
        }
        
        debug_cleanup();
        ssc_config( listref, 2 );
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x5196
    // Size: 0x3d, Type: dev
    function private function_39432dc2e39e328a( var_ca2c833762e5466c, spawntype )
    {
        if ( !isdefined( spawntype ) )
        {
            spawntype = 2;
        }
        
        debug_cleanup();
        results = function_be39ee9f759d6210( var_ca2c833762e5466c, spawntype );
        return results;
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x51db
    // Size: 0x15a, Type: dev
    function private function_cb22b100665fa1b4( debugstate )
    {
        debug_cleanup();
        
        foreach ( structname, spawnarray in level.ssc.spawns )
        {
            color = default_to( level.ssc.colors[ structname ], ( 1, 1, 1 ) );
            
            foreach ( scriptstruct in spawnarray )
            {
                origin = default_to( scriptstruct.origin, ( 0, 0, 0 ) );
                angles = default_to( scriptstruct.angles, ( 0, 0, 0 ) );
                function_fd78bc2f959fe5cc( scriptstruct.var_2c754a023b081c20, origin, angles, color );
            }
        }
        
        level.ssc.drawcount++;
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x533d
    // Size: 0x46, Type: dev
    function private function_34ae4f6043bcb29a( debugstate )
    {
        for ( i = function_f60985255e4b2819(); i <= level.ssc.drawcount ; i++ )
        {
            debug_cleanup( i );
        }
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x538b
    // Size: 0xb1, Type: dev
    function private function_1c9f19f5e86da1ab( var_ca2c833762e5466c )
    {
        spawns = [];
        numtimes = getdvarint( @"hash_a7edcbf40456f8b5", 10 );
        debug_print( "<dev string:x5aa>" + var_ca2c833762e5466c + "<dev string:x1c>" + numtimes + "<dev string:x5c5>" );
        
        for ( i = 0; i < numtimes ; i++ )
        {
            debug_print( "<dev string:x5d0>" + i + 1 + "<dev string:x5e9>" + var_ca2c833762e5466c );
            results = function_39432dc2e39e328a( var_ca2c833762e5466c, 3 );
            println( results.size );
            spawns = array_combine( spawns, results );
            waitframe();
        }
        
        function_4af2c94919958f2e( var_ca2c833762e5466c, spawns, numtimes );
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 3, eflags: 0x4
    // Checksum 0x0, Offset: 0x5444
    // Size: 0x31f, Type: dev
    function private function_4af2c94919958f2e( var_ca2c833762e5466c, spawns, var_9c15d8194b83aac )
    {
        spawncounts = [];
        maxcount = 0;
        
        foreach ( spawn in spawns )
        {
            if ( array_contains_key( spawncounts, spawn ) )
            {
                count = spawncounts[ spawn ] + 1;
                spawncounts[ spawn ] = count;
                
                if ( count > maxcount )
                {
                    maxcount = count;
                }
                
                continue;
            }
            
            spawncounts[ spawn ] = 1;
        }
        
        mincount = maxcount;
        
        foreach ( count in spawncounts )
        {
            if ( count < mincount )
            {
                mincount = count;
            }
        }
        
        deltacount = maxcount - mincount;
        
        foreach ( index in level.ssc.indexes )
        {
            origin = default_to( level.ssc.structs[ index ].origin, ( 0, 0, 0 ) );
            angles = default_to( level.ssc.structs[ index ].angles, ( 0, 0, 0 ) );
            
            if ( array_contains_key( spawncounts, index ) && spawncounts[ index ] > 0 )
            {
                count = spawncounts[ index ];
                
                if ( deltacount )
                {
                    colorfrac = ( count - mincount ) / deltacount;
                }
                else
                {
                    colorfrac = 1;
                }
                
                if ( colorfrac < 0.25 )
                {
                    color = ( 0, colorfrac / 0.25, 1 );
                }
                else if ( colorfrac < 0.5 )
                {
                    colorfrac -= 0.25;
                    color = ( 0, 1, 1 - colorfrac / 0.25 );
                }
                else if ( colorfrac < 0.75 )
                {
                    colorfrac -= 0.5;
                    color = ( colorfrac / 0.25, 1, 0 );
                }
                else
                {
                    colorfrac -= 0.75;
                    color = ( 1, 1 - colorfrac / 0.25, 0 );
                }
                
                function_fd78bc2f959fe5cc( index + "<dev string:x5f1>" + spawncounts[ index ] + "<dev string:x5f6>", origin, angles, color );
                continue;
            }
            
            debug_print( "<dev string:x5fb>" + index + "<dev string:x605>" + var_9c15d8194b83aac + "<dev string:x627>" + var_ca2c833762e5466c );
            function_fd78bc2f959fe5cc( index + "<dev string:x640>", origin, angles, ( 1, 1, 1 ) );
        }
        
        level.ssc.drawcount++;
    }

#/
