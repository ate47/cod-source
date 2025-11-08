#using script_35ee5e2cef30eea2;
#using script_5693b37bfb748170;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;

#namespace namespace_ffc66489af4e13ac;

// Namespace namespace_ffc66489af4e13ac / namespace_31c289156a6de223
// Params 0
// Checksum 0x0, Offset: 0xf3
// Size: 0x20
function function_d5724a0f0cd63d12()
{
    function_a3db364a0ccc4fd8();
    function_a44b57cf475cf6c1( 1 );
    level.var_80c1e8e18146024f = &function_bc9bc92f91fb076d;
}

// Namespace namespace_ffc66489af4e13ac / namespace_31c289156a6de223
// Params 0
// Checksum 0x0, Offset: 0x11b
// Size: 0x33
function function_422c480d1e41bff2()
{
    assertex( isdefined( level.endgame ), "<dev string:x1c>" );
    level.forcedend = 1;
    level thread [[ level.endgame ]]();
}

// Namespace namespace_ffc66489af4e13ac / namespace_31c289156a6de223
// Params 1
// Checksum 0x0, Offset: 0x156
// Size: 0x2ad
function function_bc9bc92f91fb076d( var_7b6d5db8cb3c5782 )
{
    pausecircle( 1 );
    level.br_circle.safecircleent = spawn( "script_model", ( level.br_level.br_circlecenters[ 1 ][ 0 ], level.br_level.br_circlecenters[ 1 ][ 1 ], level.br_level.br_circleradii[ 1 ] ) );
    level.br_circle.safecircleent.hidden = 0;
    level.br_circle.safecircleui = spawn( "script_model", level.br_circle.safecircleent.origin );
    level.br_circle.safecircleui.hidden = 0;
    level.br_circle.dangercircleent = spawnbrcircle( level.br_level.br_circlecenters[ 0 ][ 0 ], level.br_level.br_circlecenters[ 0 ][ 1 ], level.br_level.br_circleradii[ 0 ] );
    level.br_circle.dangercircleent.hidden = 0;
    level.br_circle.dangercircleent thread dangercircleenthidefromplayers();
    level.br_circle.dangercircleui = spawn( "script_model", level.br_circle.dangercircleent.origin );
    level.br_circle.dangercircleui.hidden = 0;
    function_2f4fb0777ebb4cc0();
    waitframe();
    hidedangercircle();
    setpreviewuicircle( level.br_circle.safecircleent );
    
    if ( istrue( level.usegulag ) )
    {
        scripts\mp\gametypes\br_gulag::setupgulagtimer();
    }
    
    showdangercircle();
    level.br_circle thread circledamagetick();
    level thread stopcirclesatgameend();
    level.br_circle.circleinittime = gettime();
    
    if ( isdefined( level.br_level.br_circledelaytimes ) )
    {
        for ( i = 0; i < level.br_level.br_circledelaytimes.size ; i++ )
        {
            circletimer( i );
        }
    }
    
    scripts\mp\gametypes\br_armory_kiosk::disableallarmorykiosks();
}

// Namespace namespace_ffc66489af4e13ac / namespace_31c289156a6de223
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x40b
// Size: 0xa0
function private function_a3db364a0ccc4fd8()
{
    level.isbrpracticemode = 1;
    level.disableannouncer = 1;
    level.br_infils_disabled = 0;
    setdvar( @"hash_47d8674c992e098", 1 );
    setdvar( @"hash_192990fc79b06600", 1 );
    setdvar( @"hash_90a3dfd557408611", 0 );
    setdvar( @"hash_18afe7a288a4b1e4", 1 );
    setdvar( @"hash_eb038ca43332e718", 1 );
    scripts\mp\gametypes\br_gametypes::disablefeature( "gulag" );
    scripts\mp\gametypes\br_gametypes::disablefeature( "teamSpectate" );
    scripts\mp\gametypes\br_gametypes::disablefeature( "drogBagLoadout" );
    clearmusicstate();
}

