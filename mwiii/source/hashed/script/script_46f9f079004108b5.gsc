#using script_108e35fd46ede103;
#using script_1101132279a92fc5;
#using script_13fcdbb52df67dc9;
#using script_16d96f45972c44a3;
#using script_19d144ebb4653c55;
#using script_1d080d419caa9de1;
#using script_1ef6a0a6e5f0d02b;
#using script_206495bf5a980fc9;
#using script_221e4f7ccdd70004;
#using script_25d6d897a557462f;
#using script_26adf2bb8048abf;
#using script_2afa9ba5690e2eef;
#using script_2b8f95e339bbcd38;
#using script_31feb0f9cf0bcb39;
#using script_326fcd567e42c4c5;
#using script_38882beefdfcb7c;
#using script_3978d81efc5244ab;
#using script_3c8aa9c9cbd2fb69;
#using script_3cdccd29f1ac4b45;
#using script_3da7a34096422118;
#using script_3e7a9c3df06964bf;
#using script_422031f0c142943c;
#using script_43ec9e90e7cc419d;
#using script_4c1b5c23b42630d0;
#using script_52aee4f1767a29b9;
#using script_5861420373326790;
#using script_614e5dfbd86f263d;
#using script_62d84ec748716cfc;
#using script_65d7b43d6898e5ac;
#using script_689b6f82b549b379;
#using script_6b6dc597273d9061;
#using script_6ba880f56b997210;
#using script_6c5c2c3e6716166f;
#using script_6ccb901b5b948f50;
#using script_703357e28ba98a55;
#using script_723f6e47953a77ac;
#using script_79de7a2a654a305;
#using script_7cb35f89ed0ca240;
#using script_7db9d43081422545;
#using script_abd0cc9d6ee3909;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace namespace_f4e08410f596cdcf;

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x507
// Size: 0x13
function private autoexec init()
{
    callback::add( "ob_content_process_create_script", &function_5da38d531a6faee7 );
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x522
// Size: 0x12
function private function_5da38d531a6faee7( params )
{
    function_184b79b8c86bb1bb();
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x53c
// Size: 0x27, Type: bool
function private function_b4aab17620ddfba8( var_164d9f47cd7fa3ba )
{
    return !getdvarint( hashcat( @"hash_479a5af6053041cf", "#" + var_164d9f47cd7fa3ba ), 0 );
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x56c
// Size: 0x18
function private function_ce005f5138306e73( targetname )
{
    function_57345744ffb049e9( "targetname", targetname );
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x58c
// Size: 0x18
function private function_bdfd54755d053330( target )
{
    function_57345744ffb049e9( "target", target );
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5ac
// Size: 0x18
function private function_59ee05724948480( script_noteworthy )
{
    function_57345744ffb049e9( "script_noteworthy", script_noteworthy );
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x5cc
// Size: 0x18
function private function_4109d9dd8ad4415d( variantname )
{
    function_57345744ffb049e9( "variantname", variantname );
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x5ec
// Size: 0x15c
function private function_57345744ffb049e9( type, typevalue )
{
    waitframe();
    structs = level.struct_class_names[ type ][ typevalue ];
    
    if ( !isdefined( structs ) || !isarray( structs ) )
    {
        return;
    }
    
    foreach ( struct in structs )
    {
        if ( isdefined( struct.targetname ) )
        {
            level.struct_class_names[ "targetname" ][ struct.targetname ] = [];
        }
        
        if ( isdefined( struct.target ) )
        {
            level.struct_class_names[ "target" ][ struct.target ] = [];
        }
        
        if ( isdefined( struct.script_noteworthy ) )
        {
            level.struct_class_names[ "script_noteworthy" ][ struct.script_noteworthy ] = [];
        }
        
        if ( isdefined( struct.script_linkname ) )
        {
            level.struct_class_names[ "script_linkname" ][ struct.script_linkname ] = [];
        }
        
        if ( isdefined( struct.variantname ) )
        {
            level.struct_class_names[ "variantname" ][ struct.variantname ] = [];
        }
    }
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x750
// Size: 0x1bb
function private function_184b79b8c86bb1bb()
{
    function_59ee05724948480( "captivityRespawn_door" );
    function_59ee05724948480( "captivitySpawnPoint" );
    function_59ee05724948480( "cell_spawn" );
    function_59ee05724948480( "prison_spawn" );
    function_59ee05724948480( "smallHouse" );
    function_59ee05724948480( "fight_spawn" );
    function_ce005f5138306e73( "front_side" );
    function_ce005f5138306e73( "gulag" );
    level.struct_class_names[ "script_noteworthy" ][ "1280" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "2" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "3" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "400" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "450" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "450.00" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "500" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "800" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "1280" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "Cover Crouch" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "Cover Left" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "Cover Right" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "Cover Stand" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "dense" ] = [];
    level.struct_class_names[ "script_noteworthy" ][ "Exposed" ] = [];
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x913
// Size: 0xd9
function private function_1012f56c4703fbbe( params )
{
    if ( function_b4aab17620ddfba8( "a" ) )
    {
        namespace_b6e91560a1dad5ae::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "b" ) )
    {
        namespace_5e17518aa5e7d37e::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "c" ) )
    {
        namespace_6f676efd6b5d19ea::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "d" ) )
    {
        namespace_60784ca744394e0a::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "e" ) )
    {
        namespace_edb450e4d095d2e::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "f" ) )
    {
        namespace_3fa31e4e9d89bd3e::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "g" ) )
    {
        namespace_b18d0b6d51580362::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "h" ) )
    {
        namespace_a8fe2a785e59b742::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "i" ) )
    {
        namespace_514bb433a608217e::cleanup();
    }
    
    callback::remove( "ob_wallbuys_create_script_done", &function_1012f56c4703fbbe );
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x9f4
// Size: 0xd9
function private function_5695bb6ecb11e560( params )
{
    if ( function_b4aab17620ddfba8( "a" ) )
    {
        namespace_76a8704be68c429f::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "b" ) )
    {
        namespace_a91075b4ed17580f::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "c" ) )
    {
        namespace_a8b13450d6af6733::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "d" ) )
    {
        namespace_dfc7245f67d19553::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "e" ) )
    {
        namespace_ce9a9ff991baca1f::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "f" ) )
    {
        namespace_b4423be1b735edcf::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "g" ) )
    {
        namespace_d3cdad60be79885b::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "h" ) )
    {
        namespace_bbeae3d03c0dcd3b::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "i" ) )
    {
        namespace_9c44d85ded37a60f::cleanup();
    }
    
    callback::remove( "ob_perks_create_script_done", &function_5695bb6ecb11e560 );
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xad5
// Size: 0xd9
function private function_c02a07d505caa6fb( params )
{
    if ( function_b4aab17620ddfba8( "a" ) )
    {
        namespace_d33caaf55c2af997::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "b" ) )
    {
        namespace_af78be0a6a3ae287::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "c" ) )
    {
        namespace_68bfd047f596141b::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "d" ) )
    {
        namespace_ffbeef5a9056e1bb::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "e" ) )
    {
        namespace_b9b61ddb4ba5d417::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "f" ) )
    {
        namespace_21b8a06f41fd5c47::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "g" ) )
    {
        namespace_ca0a30d6d22ab6c3::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "h" ) )
    {
        namespace_a079c579312b4f23::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "i" ) )
    {
        namespace_9c12c3ac22d75c87::cleanup();
    }
    
    callback::remove( "ob_essence_create_script_done", &function_c02a07d505caa6fb );
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xbb6
// Size: 0xb
function private function_6e60be064c27ffcc( params )
{
    
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xbc9
// Size: 0xd9
function private function_7824994897175d41( params )
{
    if ( function_b4aab17620ddfba8( "a" ) )
    {
        namespace_f6b516533871a807::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "b" ) )
    {
        namespace_d32f15550c372af7::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "c" ) )
    {
        namespace_8b45a101f607d5bb::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "d" ) )
    {
        namespace_e78b93f2437dd85b::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "e" ) )
    {
        namespace_c524611aff136787::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "f" ) )
    {
        namespace_cb31926db07436b7::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "g" ) )
    {
        namespace_e3133db2e25257f3::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "h" ) )
    {
        namespace_7364490eabcde8d3::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "i" ) )
    {
        namespace_796b07baaaff58f7::cleanup();
    }
    
    callback::remove( "ob_mysteryboxes_create_script_done", &function_7824994897175d41 );
}

// Namespace namespace_f4e08410f596cdcf / namespace_d8694346480ea94f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xcaa
// Size: 0xe8
function private function_8afac935017be8c2( params )
{
    if ( function_b4aab17620ddfba8( "b" ) )
    {
        namespace_7535ac2674e02eca::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "c" ) )
    {
        namespace_1aa66c587558caa6::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "e" ) )
    {
        namespace_eaf2d79326b082fa::cleanup();
    }
    
    if ( function_b4aab17620ddfba8( "f" ) )
    {
        namespace_a8cf1dfd1cca638a::cleanup();
    }
    
    function_ce005f5138306e73( "atv_spawn" );
    function_ce005f5138306e73( "jltv_mg_spawn" );
    function_ce005f5138306e73( "jup_pickup_2014_spawn" );
    function_ce005f5138306e73( "mil_cargo_truck_spawn" );
    function_ce005f5138306e73( "overland_2016_spawn" );
    function_ce005f5138306e73( "pickup_2014_spawn" );
    function_ce005f5138306e73( "rhib_spawn" );
    function_ce005f5138306e73( "sedan_hatchback_1985_spawn" );
    function_ce005f5138306e73( "suv_1996_spawn" );
    function_ce005f5138306e73( "techo_rebel_spawn" );
    callback::remove( "ob_vehicles_create_script_done", &function_8afac935017be8c2 );
}

