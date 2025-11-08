#using scripts\common\devgui;
#using scripts\engine\utility;
#using scripts\mp\flags;

#namespace structspawnconfig;

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 0
// Checksum 0x0, Offset: 0x738
// Size: 0x9d, Type: bool
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
// Checksum 0x0, Offset: 0x7de
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
// Checksum 0x0, Offset: 0x82e
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
// Checksum 0x0, Offset: 0x8e3
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
// Checksum 0x0, Offset: 0x941
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
// Checksum 0x0, Offset: 0x997
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
// Checksum 0x0, Offset: 0x9f0
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
// Checksum 0x0, Offset: 0xa49
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
// Checksum 0x0, Offset: 0xaa2
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
// Checksum 0x0, Offset: 0xafb
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
// Checksum 0x0, Offset: 0xb81
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
// Checksum 0x0, Offset: 0xc0c
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
// Checksum 0x0, Offset: 0xc78
// Size: 0xb0
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
// Checksum 0x0, Offset: 0xd31
// Size: 0x1c
function private function_7f0c7ed9520a18f0()
{
    configlist = self;
    configlist = array_sort_with_func( configlist, &function_8bdb3e2a8e7218da );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2
// Checksum 0x0, Offset: 0xd55
// Size: 0x3e, Type: bool
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
// Checksum 0x0, Offset: 0xd9c
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
// Checksum 0x0, Offset: 0xe0a
// Size: 0x7d
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
// Checksum 0x0, Offset: 0xe90
// Size: 0x5c
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
// Checksum 0x0, Offset: 0xef4
// Size: 0x63
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
// Checksum 0x0, Offset: 0xf60
// Size: 0x63
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
    return spawnresult;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xfcc
// Size: 0x193
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
// Checksum 0x0, Offset: 0x1167
// Size: 0x76
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
// Checksum 0x0, Offset: 0x11e5
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
// Checksum 0x0, Offset: 0x12e9
// Size: 0x84
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
// Checksum 0x0, Offset: 0x1375
// Size: 0xdd
function private function_a287b4f36804bbdd( spawnconfig, spawntype )
{
    spawnlist = self;
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
// Checksum 0x0, Offset: 0x145a
// Size: 0x8e
function private function_d501d9da90bcfb86( entry, spawnconfig, spawntype )
{
    switch ( spawntype )
    {
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
// Checksum 0x0, Offset: 0x14f0
// Size: 0x7a
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
// Checksum 0x0, Offset: 0x1572
// Size: 0x5b
function private function_16deec76c9aec1c2( spawnconfig, spawntype )
{
    spawnlist = self;
    debug_print( "Struct " + spawnconfig.script_struct + " spawned " + spawnlist.size + " times" + ter_op( spawntype == 2, " in Debug mode", "" ) );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x15d5
// Size: 0x39
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
// Checksum 0x0, Offset: 0x1617
// Size: 0x94
function private function_9657eb0ab7380011( spawnconfig )
{
    spawns = self;
    
    if ( isdefined( spawnconfig.var_80007572cdd4150f ) )
    {
        foreach ( poirule in spawnconfig.var_80007572cdd4150f )
        {
            spawns = spawns function_be1e8d04a1c66652( poirule, spawnconfig );
        }
    }
    
    spawns = spawns function_eec8d5bb79fb6ed5( spawnconfig );
    spawns function_ae3769c411d239f2( "POI" );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x16b4
// Size: 0xd6
function private function_be1e8d04a1c66652( poirule, spawnconfig )
{
    spawns = self;
    [ spawns, var_c41693c82143133e ] = spawns function_7d53ab524b68f69b( function_3e38027e10bb939c( poirule.poi_name ), 1 );
    
    if ( var_c41693c82143133e.size == 0 )
    {
        function_8de891d666db43b1( "Struct " + spawnconfig.script_struct + " has 0 spawns in " + poirule.poi_name );
        return spawns;
    }
    
    var_e7fee629fee1b87f = var_c41693c82143133e function_5b1350ccb1325b2e( poirule );
    var_e7fee629fee1b87f = var_e7fee629fee1b87f function_e5dcf502bd8f8434( poirule );
    var_e7fee629fee1b87f = var_e7fee629fee1b87f function_ea64cf87f2cfcc5e( poirule );
    spawns = function_d1e45146e40968b9( spawns, var_e7fee629fee1b87f );
    function_ae3769c411d239f2( "POI Single - " + poirule.poi_name );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1793
// Size: 0xa4
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
        spawns = spawns function_25e8de075f034dd6( spawnconfig, poiname );
    }
    
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1840
// Size: 0xe3
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
// Checksum 0x0, Offset: 0x192c
// Size: 0xb0
function private function_4ee587b4504098a8( spawnconfig )
{
    spawns = self;
    spawns = spawns function_9f97ff4837895235( spawnconfig );
    possiblespawns = level.ssc.indexes;
    spawns = spawns function_569aa5d713ef47b4( possiblespawns, default_to( spawnconfig.var_473fbf10b632a192, -1 ) );
    spawns = spawns function_b9019dc0e88433a6( default_to( spawnconfig.var_e79b6f0d46e45758, -1 ) );
    spawns = spawns function_71170b2ee942ae97( possiblespawns, spawnconfig.var_d63bff823de6d46a );
    spawns = spawns function_b9bbe4f989c19e1( possiblespawns, spawnconfig.var_ef46c86624a75b00 );
    spawns function_ae3769c411d239f2( "Global" );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x19e5
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
// Checksum 0x0, Offset: 0x1ac2
// Size: 0x3b6
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
// Checksum 0x0, Offset: 0x1e81
// Size: 0x3c
function private function_ae3769c411d239f2( rule )
{
    spawns = self;
    function_49dec75a702536c8( "After " + rule + ", spawns has " + spawns.size + " entries" );
    function_56b91bfbefdc7456( spawns );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1ec5
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
// Checksum 0x0, Offset: 0x1fbc
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
// Checksum 0x0, Offset: 0x2037
// Size: 0xbe
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
// Checksum 0x0, Offset: 0x20fe
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
// Checksum 0x0, Offset: 0x2156
// Size: 0x88
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
// Checksum 0x0, Offset: 0x21e7
// Size: 0x128
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
// Checksum 0x0, Offset: 0x2318
// Size: 0x141
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
// Checksum 0x0, Offset: 0x2461
// Size: 0x13d
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
        totalweight += entry.spawn_weight;
    }
    
    randomweight = randomint( totalweight );
    
    foreach ( entry in weights )
    {
        randomweight -= entry.spawn_weight;
        
        if ( randomweight <= 0 )
        {
            return entry.spawn_count;
        }
    }
    
    return weights[ weights.size ].spawn_count;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x25a7
// Size: 0x11b
function private function_c54881e0e112bd31( possiblespawns, poiname, weights )
{
    spawns = self;
    
    if ( !isdefined( weights ) || weights.size == 0 )
    {
        function_8de891d666db43b1( "POI " + poiname + " has no weights set" );
        return spawns;
    }
    
    spawncount = level.ssc.weights[ poiname ];
    level.ssc.weights[ poiname ] = function_747ff5f8c0e96da5( weights, spawncount );
    spawndifference = level.ssc.weights[ poiname ] - spawns.size;
    
    if ( spawndifference < 0 )
    {
        spawns = function_16059c8d75a938c4( spawns, abs( spawndifference ) );
    }
    else if ( spawndifference > 0 )
    {
        newspawns = function_3267104534037a6f( possiblespawns, spawndifference );
        spawns = function_d1e45146e40968b9( spawns, newspawns );
    }
    
    function_49dec75a702536c8( "Rule Weights - Weight rolled for POI " + poiname + " is " + level.ssc.weights[ poiname ] + " and spawn count was changed by " + spawndifference );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x26cb
// Size: 0x88
function private function_5b1350ccb1325b2e( poirule )
{
    poispawns = self;
    
    if ( !isdefined( poirule.poi_name ) || !isdefined( poirule.var_c49eb61fdcdb5a08 ) || poirule.var_c49eb61fdcdb5a08.size == 0 )
    {
        return poispawns;
    }
    
    possiblespawns = function_3e38027e10bb939c( poirule.poi_name );
    poispawns = poispawns function_c54881e0e112bd31( possiblespawns, poirule.poi_name, poirule.var_c49eb61fdcdb5a08 );
    return poispawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x275c
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
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x27d9
// Size: 0x1f3
function private function_47d1ae54743cde58( possiblespawns, dist, var_6336c4046527f0d0, otherstruct )
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
// Checksum 0x0, Offset: 0x29d5
// Size: 0x78
function private function_e937d3b8b0cfa746( otherstruct )
{
    spawns = self;
    
    if ( isdefined( otherstruct ) )
    {
        assert( isdefined( level.ssc.spawns[ otherstruct ] ), "Struct: " + otherstruct + " has not been processed yet!" );
        return level.ssc.spawns[ otherstruct ];
    }
    
    return function_288718db33265376( spawns, level.ssc.exclude );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x2a56
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
// Checksum 0x0, Offset: 0x2aa0
// Size: 0x153
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
// Checksum 0x0, Offset: 0x2bfc
// Size: 0xe4
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
// Checksum 0x0, Offset: 0x2ce9
// Size: 0xee
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
// Checksum 0x0, Offset: 0x2de0
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
// Checksum 0x0, Offset: 0x2e74
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
// Checksum 0x0, Offset: 0x2ecf
// Size: 0x39
function private function_71170b2ee942ae97( possiblespawns, dist, otherstruct )
{
    spawns = self;
    spawns = spawns function_47d1ae54743cde58( possiblespawns, dist, &function_8ee15acd9ec71bc7, otherstruct );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x2f11
// Size: 0x9a
function private function_3b3747a18eeec63b( possiblespawns, dist, groupstring )
{
    if ( !isdefined( groupstring ) )
    {
        groupstring = "Group";
    }
    
    spawns = self;
    [ spawns, currentspawns ] = spawns function_7d53ab524b68f69b( possiblespawns );
    newspawns = currentspawns function_71170b2ee942ae97( possiblespawns, dist );
    spawns = function_d1e45146e40968b9( spawns, newspawns );
    function_49dec75a702536c8( "Rule Dist Group Min - " + groupstring + " has ended with " + newspawns.size + " spawns" );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2fb4
// Size: 0x7c
function private function_e5dcf502bd8f8434( poirule )
{
    spawns = self;
    
    if ( !isdefined( poirule.poi_name ) || !isdefined( poirule.var_4a8d43d74b119570 ) )
    {
        return spawns;
    }
    
    possiblespawns = function_3e38027e10bb939c( poirule.poi_name );
    spawns = spawns function_3b3747a18eeec63b( possiblespawns, poirule.var_4a8d43d74b119570, "POI " + poirule.poi_name );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3039
// Size: 0x57
function private function_21089f02e9597328( dist, tag )
{
    spawns = self;
    possiblespawns = function_f1111e4fc4599bac( level.ssc.indexes, tag );
    spawns = spawns function_3b3747a18eeec63b( possiblespawns, dist, "Tag " + tag );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x3099
// Size: 0x39
function private function_b9bbe4f989c19e1( possiblespawns, dist, otherstruct )
{
    spawns = self;
    spawns = spawns function_47d1ae54743cde58( possiblespawns, dist, &function_8f65abc44b0ed8f1, otherstruct );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x30db
// Size: 0x9c
function private function_b1c829bfd0ebbc8d( possiblespawns, dist, groupstring )
{
    if ( !isdefined( groupstring ) )
    {
        groupstring = "Group";
    }
    
    spawns = self;
    [ spawns, currentspawns ] = spawns function_7d53ab524b68f69b( possiblespawns, 1 );
    newspawns = currentspawns function_b9bbe4f989c19e1( possiblespawns, dist );
    spawns = function_d1e45146e40968b9( spawns, newspawns );
    function_49dec75a702536c8( "Rule Dist Group Max - " + groupstring + " has ended with " + newspawns.size + " spawns" );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3180
// Size: 0x8d
function private function_ea64cf87f2cfcc5e( poirule )
{
    spawns = self;
    
    if ( !isdefined( poirule.poi_name ) || !isdefined( poirule.var_5400baaac3ddd48d ) || poirule.var_5400baaac3ddd48d == 0 )
    {
        return spawns;
    }
    
    possiblespawns = function_3e38027e10bb939c( poirule.poi_name );
    spawns = spawns function_b1c829bfd0ebbc8d( possiblespawns, poirule.var_af067ae8c152b0da, "POI " + poirule.poi_name );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3216
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
// Checksum 0x0, Offset: 0x3276
// Size: 0x81
function private function_569aa5d713ef47b4( possiblespawns, minimum )
{
    spawns = self;
    
    if ( !isdefined( minimum ) || minimum == -1 || spawns.size >= minimum )
    {
        return spawns;
    }
    
    addcount = minimum - spawns.size;
    newspawns = function_3267104534037a6f( possiblespawns, addcount );
    spawns = function_d1e45146e40968b9( spawns, newspawns );
    function_49dec75a702536c8( "Rule Count Min - " + newspawns.size + " spawns were added" );
    function_56b91bfbefdc7456( newspawns );
    return spawns;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x3300
// Size: 0x8f
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
// Checksum 0x0, Offset: 0x3398
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
// Checksum 0x0, Offset: 0x33f8
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
// Checksum 0x0, Offset: 0x3458
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
// Checksum 0x0, Offset: 0x34be
// Size: 0x8d
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
// Checksum 0x0, Offset: 0x3554
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
// Checksum 0x0, Offset: 0x35b4
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
// Checksum 0x0, Offset: 0x3614
// Size: 0xc3
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
// Checksum 0x0, Offset: 0x36df
// Size: 0x20
function private function_7a0a1c8e4051f836( key )
{
    return level.ssc.structs[ key ];
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3708
// Size: 0x77
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
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x3788
// Size: 0x99
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
// Checksum 0x0, Offset: 0x382a
// Size: 0x12d
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
// Checksum 0x0, Offset: 0x3960
// Size: 0x50
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
// Checksum 0x0, Offset: 0x39b9
// Size: 0xb1
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
    
    return structpoi;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3a73
// Size: 0x54
function private function_400ac4c375b471a1( scriptindex )
{
    indexes = level.ssc.indexes;
    
    if ( isdefined( scriptindex ) )
    {
        if ( isdefined( indexes[ scriptindex ] ) )
        {
            return scriptindex;
        }
        
        assertmsg( "There are 2 structs that have matching script_index values: [" + scriptindex + "]! All script_index values should be unique." );
    }
    
    return function_4e39e2d66e2d1948( indexes );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3ad0
// Size: 0x26
function private function_4e39e2d66e2d1948( var_d57a27cd0f4ec676 )
{
    for ( i = 1; isdefined( var_d57a27cd0f4ec676[ i ] ) ; i++ )
    {
    }
    
    return i;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3aff
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
// Checksum 0x0, Offset: 0x3b61
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
// Checksum 0x0, Offset: 0x3b9f
// Size: 0x31
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
// Checksum 0x0, Offset: 0x3bd9
// Size: 0x6a
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
// Checksum 0x0, Offset: 0x3c4c
// Size: 0x85
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
// Checksum 0x0, Offset: 0x3cda
// Size: 0x66
function private function_9a62bf0437306755( listref, type )
{
    bundlename = listref;
    
    if ( !isxhashasset( listref ) )
    {
        bundlename = getxhashasset( default_to( type, "" ) + listref );
    }
    
    configbundle = getscriptbundle( bundlename );
    assertex( isdefined( configbundle ), "Could not load struct spawn config script bundle:" + getxhashsourcename( bundlename ) );
    return configbundle;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3d49
// Size: 0x79
function private function_d72b66a120f30bba( var_c7803e864d499dc0 )
{
    if ( !isdefined( var_c7803e864d499dc0 ) )
    {
        assertex( isdefined( var_c7803e864d499dc0 ), "Can not validate empty spawn list!" );
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
// Checksum 0x0, Offset: 0x3dcb
// Size: 0x9c
function private function_219da70f303de5b( configbundle, configlist )
{
    if ( !isdefined( configbundle ) )
    {
        assertex( isdefined( configbundle ), "Can not validate empty spawn list!" );
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
// Checksum 0x0, Offset: 0x3e70
// Size: 0x60
function private function_7dbb2f79e1942e4d( configlist, var_ca2c833762e5466c, type )
{
    config = function_9a62bf0437306755( var_ca2c833762e5466c, type );
    
    if ( !isdefined( config ) )
    {
        assertex( isdefined( config ), "Could not load struct spawn config script bundle!" );
        return configlist;
    }
    
    configlist = configlist function_32bde5f3b80bb14a( config.script_struct );
    configlist[ configlist.size ] = config;
    return configlist;
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x3ed9
// Size: 0x73
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
// Checksum 0x0, Offset: 0x3f55
// Size: 0x87
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
// Checksum 0x0, Offset: 0x3fe5
// Size: 0x2b
function private function_b301207ce4ffa1d7()
{
    newspawns = self;
    function_49dec75a702536c8( "Struct Add - Adding " + newspawns.size + " new spawns" );
    function_56b91bfbefdc7456( newspawns );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x4018
// Size: 0x6b
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
// Checksum 0x0, Offset: 0x408c
// Size: 0x2b
function private function_89feae59bdc8918c()
{
    removedspawns = self;
    function_49dec75a702536c8( "Struct Remove - Removing " + removedspawns.size + " spawns" );
    function_56b91bfbefdc7456( removedspawns );
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x40bf
// Size: 0x60
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
// Checksum 0x0, Offset: 0x4128
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
// Checksum 0x0, Offset: 0x4150
// Size: 0x61
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
// Checksum 0x0, Offset: 0x41ba
// Size: 0xa4
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
// Checksum 0x0, Offset: 0x4267
// Size: 0x8a
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
// Checksum 0x0, Offset: 0x42fa
// Size: 0x32
function private debug_print( text )
{
    /#
        if ( getdvarint( @"hash_8b6143a0fa7f37a6", 1 ) < 1 )
        {
            return;
        }
        
        println( "<dev string:x1e>" + text );
    #/
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4334
// Size: 0x32
function private function_8de891d666db43b1( text )
{
    /#
        if ( getdvarint( @"hash_8b6143a0fa7f37a6", 1 ) < 2 )
        {
            return;
        }
        
        println( "<dev string:x25>" + text );
    #/
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x436e
// Size: 0x32
function private function_49dec75a702536c8( text )
{
    /#
        if ( getdvarint( @"hash_8b6143a0fa7f37a6", 1 ) < 3 )
        {
            return;
        }
        
        println( "<dev string:x36>" + text );
    #/
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x43a8
// Size: 0x89
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
        arraystring = "<dev string:x43>";
        
        for ( i = 0; i < var_6c46abea90157067.size ; i++ )
        {
            arraystring += var_6c46abea90157067[ i ] + "<dev string:x1c>";
        }
        
        println( "<dev string:x44>" + arraystring );
    #/
}

// Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x4439
// Size: 0x6d
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
// Checksum 0x0, Offset: 0x44af
// Size: 0x16, Type: bool
function function_c0b52f72ada4834c( left, right )
{
    return left < right;
}

/#

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x44ce
    // Size: 0x108, Type: dev
    function private init_debug()
    {
        function_6e7290c8ee4f558b( "<dev string:x53>" );
        add_devgui_command( "<dev string:x72>", "<dev string:x83>" );
        add_devgui_command( "<dev string:x9e>", "<dev string:xab>" );
        add_devgui_command( "<dev string:xc9>", "<dev string:xda>" );
        function_fe953f000498048f();
        function_6e7290c8ee4f558b( "<dev string:xf6>" );
        add_devgui_command( "<dev string:x122>", "<dev string:x12f>" );
        add_devgui_command( "<dev string:x15a>", "<dev string:x166>" );
        add_devgui_command( "<dev string:x18f>", "<dev string:x19c>" );
        add_devgui_command( "<dev string:x1c6>", "<dev string:x1d7>" );
        add_devgui_command( "<dev string:x205>", "<dev string:x214>" );
        add_devgui_command( "<dev string:x241>", "<dev string:x24b>" );
        add_devgui_command( "<dev string:x273>", "<dev string:x280>" );
        add_devgui_command( "<dev string:x2aa>", "<dev string:x2bc>" );
        add_devgui_command( "<dev string:x2ee>", "<dev string:x302>" );
        add_devgui_command( "<dev string:x333>", "<dev string:x341>" );
        function_fe953f000498048f();
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x45de
    // Size: 0x73, Type: dev
    function private debug_thread()
    {
        thread debug_watch( @"hash_e4a633370d1ef223", &debug_draw );
        thread debug_watch( @"hash_e131fa7eb854022b", &function_f01b154aa1fe41cb );
        thread debug_watch( @"hash_dabca9d7fe9cee2a", &function_39432dc2e39e328a );
        thread debug_watch( @"hash_f9cebbc2fc0ec02f", &function_cb22b100665fa1b4 );
        thread debug_watch( @"hash_c58cb33610933aa4", &function_34ae4f6043bcb29a );
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x4659
    // Size: 0x76, Type: dev
    function private debug_watch( dvarstring, funcdebug )
    {
        level endon( "<dev string:x36c>" );
        
        while ( true )
        {
            debugstate = getdvar( dvarstring, "<dev string:x43>" );
            
            if ( debugstate == "<dev string:x43>" )
            {
                waitframe();
                continue;
            }
            
            setdvar( dvarstring, "<dev string:x43>" );
            debug_print( "<dev string:x377>" + getxhashsourcename( dvarstring ) + "<dev string:x380>" + debugstate );
            [[ funcdebug ]]( debugstate );
            waitframe();
        }
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x46d7
    // Size: 0xd0, Type: dev
    function private debug_draw( scriptstruct, spawns )
    {
        spawnconfig = spawnstruct();
        spawnconfig.script_struct = scriptstruct;
        function_8d6027e6daa80c1d( spawnconfig, 2 );
        debug_cleanup();
        iprintlnbold( "<dev string:x387>" + scriptstruct + "<dev string:x3a1>" );
        
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
    // Checksum 0x0, Offset: 0x47af
    // Size: 0x42, Type: dev
    function private function_f60985255e4b2819()
    {
        offset = getdvarint( @"hash_5ec6f63fa858b195", 1 );
        drawindex = level.ssc.drawcount - offset;
        return drawindex;
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x47f9
    // Size: 0xb2, Type: dev
    function private function_dd01b38da430e244( scriptstruct, index )
    {
        origin = default_to( function_7a0a1c8e4051f836( index ).origin, ( 0, 0, 0 ) );
        angles = default_to( function_7a0a1c8e4051f836( index ).angles, ( 0, 0, 0 ) );
        color = default_to( level.ssc.colors[ scriptstruct ], ( 1, 1, 1 ) );
        function_fd78bc2f959fe5cc( index, origin, angles, color );
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 4, eflags: 0x4
    // Checksum 0x0, Offset: 0x48b3
    // Size: 0xff, Type: dev
    function private function_fd78bc2f959fe5cc( text, origin, angles, color )
    {
        forward = anglestoforward( angles );
        timesec = getdvarint( @"hash_1e06d12003d4c5bf", 15 );
        timeframes = int( timesec / level.framedurationseconds );
        thread function_51c00e624bf397fd( text, origin, color, timeframes );
        ray = origin + ( 0, 0, 20000 );
        forwardpos = origin + forward * 75;
        thread draw_line_for_time( origin, ray, color[ 0 ], color[ 1 ], color[ 2 ], timesec, "<dev string:x3ab>" + level.ssc.drawcount );
        thread draw_arrow_time( origin, forwardpos, color, timesec, "<dev string:x3ab>" + level.ssc.drawcount );
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 4, eflags: 0x4
    // Checksum 0x0, Offset: 0x49ba
    // Size: 0x78, Type: dev
    function private function_51c00e624bf397fd( text, origin, color, timeframes )
    {
        level endon( "<dev string:x3ab>" + level.ssc.drawcount );
        
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
    // Checksum 0x0, Offset: 0x4a3a
    // Size: 0x25, Type: dev
    function private debug_cleanup( drawindex )
    {
        if ( !isdefined( drawindex ) )
        {
            drawindex = function_f60985255e4b2819();
        }
        
        level notify( "<dev string:x3ab>" + drawindex );
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x4a67
    // Size: 0x3e, Type: dev
    function private function_f01b154aa1fe41cb( listref )
    {
        if ( listref == "<dev string:x3b9>" )
        {
            listref = getdvar( @"hash_8e30f7eeea837de6", "<dev string:x43>" );
        }
        
        debug_cleanup();
        ssc_config( listref, 2 );
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x4aad
    // Size: 0x1f, Type: dev
    function private function_39432dc2e39e328a( var_ca2c833762e5466c )
    {
        debug_cleanup();
        function_be39ee9f759d6210( var_ca2c833762e5466c, 2 );
    }

    // Namespace structspawnconfig / scripts\cp_mp\structspawnconfig
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x4ad4
    // Size: 0x159, Type: dev
    function private function_cb22b100665fa1b4( debugstate )
    {
        debug_cleanup();
        
        foreach ( spawnarray in level.ssc.spawns )
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
    // Checksum 0x0, Offset: 0x4c35
    // Size: 0x45, Type: dev
    function private function_34ae4f6043bcb29a( debugstate )
    {
        for ( i = function_f60985255e4b2819(); i <= level.ssc.drawcount ; i++ )
        {
            debug_cleanup( i );
        }
    }

#/
