#using script_699beeb185d284d2;
#using script_769dc3897af7ecc2;
#using scripts\common\callbacks;
#using scripts\common\string;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;

#namespace namespace_74ce5173b6df2af7;

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 0
// Checksum 0x0, Offset: 0x442
// Size: 0x1b
function main()
{
    level thread function_738844ba18b42814();
    function_ed6ea23199497229();
    level thread function_79e579ee76144f69();
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 0
// Checksum 0x0, Offset: 0x465
// Size: 0x15
function function_738844ba18b42814()
{
    flag_wait( "create_script_initialized" );
    function_75d7c08da0c49595();
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 0
// Checksum 0x0, Offset: 0x482
// Size: 0x1f
function function_ed6ea23199497229()
{
    registersharedfunc( "mystery_package", "initLevelData", &function_aa271e5ace4d811 );
    function_1ec3932a3feb00e7();
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 0
// Checksum 0x0, Offset: 0x4a9
// Size: 0x12c
function function_aa271e5ace4d811()
{
    leveldata = airdrop::getleveldata( "mystery_package" );
    leveldata.basemodel = "jup_limbo_care_package_01";
    leveldata.mountmantlemodel = undefined;
    leveldata.usepriority = -1;
    leveldata.minimapicon = "hud_icon_splash_limbo_scare_package";
    leveldata.headicon = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.timeout = 240;
    leveldata.ownerusetime = 1;
    leveldata.otherusetime = 1;
    leveldata.usefov = 180;
    leveldata.usetag = "tag_origin";
    leveldata.capturestring = &"JUP_MP/LIMBO_MYSTERY_PACKAGE_CAPTURE";
    leveldata.capturecallback = &function_d2ff53bb9e1e15a0;
    leveldata.destroyoncapture = 1;
    leveldata.var_c23ca3472233553d = 1;
    leveldata.destroycallback = &function_99653dc1210dbb28;
    leveldata.capturevisualscallback = &function_8114b402cf7d8b33;
    leveldata.capturevisualsdeletiondelay = 0;
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 0
// Checksum 0x0, Offset: 0x5dd
// Size: 0x1b
function function_75d7c08da0c49595()
{
    level.var_c84d9a51d1791ca6 = getstructarray( "mystery_package", "targetname" );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 0
// Checksum 0x0, Offset: 0x600
// Size: 0x9b
function function_1ec3932a3feb00e7()
{
    level.var_ab6e7a63e659e7d3 = [];
    level.var_671e3f6ee26a1323 = [];
    function_d5718a220cad2663( "five_stars", 10, &function_35e60f57e0a1dcc0 );
    function_d5718a220cad2663( "balls", 10, &function_3f51180e94590a93 );
    function_d5718a220cad2663( "killstreaks", 10, &function_c00de1461b997d3e );
    function_d5718a220cad2663( "generic", 10, &function_8150c7d9754b81b0 );
    function_d5718a220cad2663( "mutant", 10, &function_ad1f15a50c048740 );
    function_d5718a220cad2663( "arcade_melee", 10, &function_e951c2a0a35d25c8 );
    function_d5718a220cad2663( "arcade_guns", 10, &function_da0221f88893522f );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 3
// Checksum 0x0, Offset: 0x6a3
// Size: 0x96
function function_d5718a220cad2663( id, weight, callback )
{
    weight = getdvarint( hashcat( @"hash_779571f4a7546263", id ), weight );
    
    if ( weight == 0 )
    {
        return;
    }
    
    level.var_ab6e7a63e659e7d3 = array_add( level.var_ab6e7a63e659e7d3, weight );
    var_df1ea34710a9a603 = spawnstruct();
    var_df1ea34710a9a603.id = id;
    var_df1ea34710a9a603.callback = callback;
    level.var_671e3f6ee26a1323 = array_add( level.var_671e3f6ee26a1323, var_df1ea34710a9a603 );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 0
// Checksum 0x0, Offset: 0x741
// Size: 0x1d4
function function_79e579ee76144f69()
{
    level endon( "game_ended" );
    level waittill( "prematch_done" );
    var_345fdefcfb8a90a9 = [];
    
    for ( i = 0; i < level.var_c84d9a51d1791ca6.size ; i++ )
    {
        var_345fdefcfb8a90a9[ i ] = i;
    }
    
    var_e2a6a95a9a0529d5 = queue_create( 3 );
    level.var_aff18882161ff979 = [];
    
    while ( true )
    {
        skipwait = 0;
        
        /#
            if ( getdvarint( @"hash_85d5f5de49f23e66" ) == 1 )
            {
                skipwait = 1;
                
                while ( getdvarint( @"hash_4ba6e1a9d2b07d40", 0 ) == 0 )
                {
                    wait 0.25;
                }
                
                setdvar( @"hash_4ba6e1a9d2b07d40", 0 );
            }
        #/
        
        if ( !istrue( skipwait ) )
        {
            interval = randomfloatrange( getdvarfloat( @"hash_a63d65fc4e366eb8", 90 ), getdvarfloat( @"hash_8cbc263520f91806", 150 ) );
            wait interval;
        }
        
        maxamount = getdvarint( @"hash_9f7fa17ca71b0713", 3 );
        
        while ( level.var_aff18882161ff979.size >= maxamount )
        {
            level waittill( "mystery_package_removed" );
            wait 15;
        }
        
        var_52df47196b0c0062 = array_difference( var_345fdefcfb8a90a9, var_e2a6a95a9a0529d5.array );
        index = random( var_52df47196b0c0062 );
        randomspawn = level.var_c84d9a51d1791ca6[ index ];
        
        if ( queue_size( var_e2a6a95a9a0529d5 ) == 3 )
        {
            var_e2a6a95a9a0529d5 = function_93def91a50927481( var_e2a6a95a9a0529d5 );
        }
        
        var_e2a6a95a9a0529d5 = function_6cf786a6cf335cb9( var_e2a6a95a9a0529d5, index );
        childthread function_6c1055e3980772a( randomspawn );
        
        /#
            if ( getdvarint( @"hash_3a4cfe3355f3370f", 0 ) == 1 )
            {
                var_9a7085e48b4aa2c0 = scripts\mp\gametypes\br_dev::function_69dffe7a5cb1b4b9();
                var_9a7085e48b4aa2c0 setorigin( randomspawn.origin );
            }
        #/
    }
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 1
// Checksum 0x0, Offset: 0x91d
// Size: 0x108
function function_6c1055e3980772a( spawnstruct )
{
    spawnpos = spawnstruct.origin + ( 0, 0, getdvarfloat( @"hash_e78033264d3b9ccf", 2000 ) );
    crate = airdrop::dropcrate( undefined, undefined, "mystery_package", spawnpos, spawnstruct.angles, spawnstruct.origin );
    level.var_aff18882161ff979 = array_add( level.var_aff18882161ff979, crate );
    crate.spawnstruct = spawnstruct;
    
    foreach ( player in level.players )
    {
        level thread scripts\mp\gametypes\br_public::brleaderdialogplayer( "limbo_supplyIncoming", player, 1, 0 );
        player thread scripts\mp\hud_message::showsplash( "br_limbo_mystery_package_incoming", undefined, undefined, undefined, undefined, "splash_list_br_jup_limbo" );
        crate thread function_40d64936a75c67b2( player );
    }
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 1
// Checksum 0x0, Offset: 0xa2d
// Size: 0x16f
function function_d2ff53bb9e1e15a0( player )
{
    if ( isdefined( self.spawnstruct.var_3cf28e3a74e99a32 ) )
    {
        var_8d4147bcbf87078e = strtok( self.spawnstruct.var_3cf28e3a74e99a32, "," );
        weights = [];
        
        for ( i = 0; i < level.var_671e3f6ee26a1323.size ; i++ )
        {
            weights[ i ] = array_contains( var_8d4147bcbf87078e, level.var_671e3f6ee26a1323[ i ].id ) ? 0 : level.var_ab6e7a63e659e7d3[ i ];
        }
    }
    else
    {
        weights = level.var_ab6e7a63e659e7d3;
    }
    
    var_df1ea34710a9a603 = random_weighted( level.var_671e3f6ee26a1323, weights );
    
    /#
        var_77058738bad9dd86 = getdvar( @"hash_f1ab8230b2ba2ede", "<dev string:x1c>" );
        
        if ( !string::function_46b9c00bb0535aa3( var_77058738bad9dd86 ) )
        {
            for ( i = 0; i < level.var_671e3f6ee26a1323.size ; i++ )
            {
                var_47e47c22b01ac86e = level.var_671e3f6ee26a1323[ i ];
                
                if ( var_47e47c22b01ac86e.id == var_77058738bad9dd86 )
                {
                    var_df1ea34710a9a603 = var_47e47c22b01ac86e;
                    break;
                }
            }
        }
    #/
    
    self [[ var_df1ea34710a9a603.callback ]]( player );
    level.var_aff18882161ff979 = array_remove( level.var_aff18882161ff979, self );
    level notify( "mystery_package_removed" );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 1
// Checksum 0x0, Offset: 0xba4
// Size: 0x2c
function function_99653dc1210dbb28( immediate )
{
    level.var_aff18882161ff979 = array_remove( level.var_aff18882161ff979, self );
    level notify( "mystery_package_removed" );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 1
// Checksum 0x0, Offset: 0xbd8
// Size: 0x1c
function function_8114b402cf7d8b33( crate )
{
    self setscriptablepartstate( "main", "death" );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 2
// Checksum 0x0, Offset: 0xbfc
// Size: 0x9f
function function_439679eb6d21c2b8( scriptCache, var_b8854e22ca208109 )
{
    if ( var_b8854e22ca208109 == undefined )
    {
        var_b8854e22ca208109 = 20;
    }
    
    items = getscriptcachecontents( scriptCache, randomint( var_b8854e22ca208109 ) );
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    dropinfo = spawnstruct();
    dropinfo.origin = self.origin;
    dropinfo.angles = self.angles;
    dropinfo.itemsdropped = 0;
    var_605079299d001231 = dropinfo scripts\mp\gametypes\br_lootcache::lootspawnitemlist( dropstruct, items, 0 );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 1
// Checksum 0x0, Offset: 0xca3
// Size: 0x17
function function_c00de1461b997d3e( player )
{
    function_439679eb6d21c2b8( "br_limbo_mystery_package_killstreaks" );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 1
// Checksum 0x0, Offset: 0xcc2
// Size: 0x17
function function_8150c7d9754b81b0( player )
{
    function_439679eb6d21c2b8( "br_limbo_mystery_package_generic" );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 1
// Checksum 0x0, Offset: 0xce1
// Size: 0x17
function function_ad1f15a50c048740( player )
{
    function_439679eb6d21c2b8( "br_limbo_mystery_package_mutant" );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 1
// Checksum 0x0, Offset: 0xd00
// Size: 0x17
function function_e951c2a0a35d25c8( player )
{
    function_439679eb6d21c2b8( "br_limbo_mystery_package_arcade_melee" );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 1
// Checksum 0x0, Offset: 0xd1f
// Size: 0x17
function function_da0221f88893522f( player )
{
    function_439679eb6d21c2b8( "br_limbo_mystery_package_arcade_guns" );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 1
// Checksum 0x0, Offset: 0xd3e
// Size: 0x9c
function function_35e60f57e0a1dcc0( player )
{
    squadmembers = scripts\mp\utility\teams::getfriendlyplayers( player.team, 1 );
    
    foreach ( squadmember in squadmembers )
    {
        if ( !istrue( squadmember.var_fa9f4c933e6df36d ) )
        {
            squadmember namespace_83b142ab0b1210c0::function_bddecd56f4b2d8b0( 5 );
            squadmember thread scripts\mp\hud_message::showsplash( "br_limbo_mystery_package_five_stars", undefined, undefined, undefined, undefined, "splash_list_br_jup_limbo" );
        }
    }
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 1
// Checksum 0x0, Offset: 0xde2
// Size: 0x181
function function_3f51180e94590a93( player )
{
    var_17126c0a59480f9c = anglestoforward( self.angles );
    var_158655edcf957eb2 = vectornormalize( ( var_17126c0a59480f9c[ 0 ], var_17126c0a59480f9c[ 1 ], 0 ) );
    up = ( 0, 0, 1 );
    spawndirection = rotatepointaroundvector( up, var_158655edcf957eb2, randomfloat( 360 ) );
    var_498cb86b55dac26e = 60;
    var_1be128107a6754a5 = [];
    
    for ( i = 0; i < 6 ; i++ )
    {
        spawnposition = self.origin + spawndirection * randomfloatrange( 200, 400 ) + ( 0, 0, 500 );
        var_d5dcb432dd81691c = namespace_2a9cffd769289a8::function_273a2924623954df( spawnposition, player.team );
        var_1be128107a6754a5[ i ] = var_d5dcb432dd81691c;
        spawndirection = rotatepointaroundvector( up, spawndirection, var_498cb86b55dac26e );
    }
    
    squadmembers = scripts\mp\utility\teams::getfriendlyplayers( player.team, 1 );
    
    foreach ( squadmember in squadmembers )
    {
        squadmember thread scripts\mp\hud_message::showsplash( "br_limbo_mystery_package_balls", undefined, undefined, undefined, undefined, "splash_list_br_jup_limbo" );
    }
    
    level thread function_4d04eada28fb26af( var_1be128107a6754a5 );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 1
// Checksum 0x0, Offset: 0xf6b
// Size: 0xd2
function function_4d04eada28fb26af( balls )
{
    level endon( "game_ended" );
    wait 60;
    
    foreach ( ball in balls )
    {
        ball setscriptablepartstate( "death", "on" );
    }
    
    wait 0.5;
    level.var_c8936f922b7d32a1 = array_remove_array( level.var_c8936f922b7d32a1, balls );
    
    foreach ( ball in balls )
    {
        ball notify( "death" );
        ball delete();
    }
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 1
// Checksum 0x0, Offset: 0x1045
// Size: 0xab
function function_40d64936a75c67b2( player )
{
    level endon( "game_ended" );
    self waittill( "collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum );
    playsoundatpos( self.origin + ( 0, 0, 15 ), "jup_wz_purgatory_mystery_crate_appear" );
    level thread scripts\mp\gametypes\br_public::brleaderdialogplayer( "limbo_supplyLanded", player, 1, 0 );
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 0
// Checksum 0x0, Offset: 0x10f8
// Size: 0xc9
function function_c892b9e4ee801e4d()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            distancefromplayer = distancesquared( self.origin, player.origin );
            
            if ( distancefromplayer < 1000000 && !isdefined( player.var_5203028e03ab1e06 ) )
            {
                level thread scripts\mp\gametypes\br_public::brleaderdialogplayer( "limbo_supplyNear", player, 1, 0 );
                player.var_5203028e03ab1e06 = 1;
                player thread function_2a67445a01163a2f();
            }
        }
        
        wait 5;
    }
}

// Namespace namespace_74ce5173b6df2af7 / namespace_35aa905bbd8fdc12
// Params 0
// Checksum 0x0, Offset: 0x11c9
// Size: 0x20
function function_2a67445a01163a2f()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    wait 60;
    self.var_5203028e03ab1e06 = undefined;
}

