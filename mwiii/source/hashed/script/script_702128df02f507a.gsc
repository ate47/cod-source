#using script_702128df02f507a;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_public;

#namespace namespace_cf51e0de98ebcb9e;

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x17f
// Size: 0x2b
function autoexec main()
{
    if ( getdvarint( @"hash_a9df41b469b5dbe2", 1 ) <= 0 )
    {
        return;
    }
    
    init();
    
    /#
        level thread debug_init();
    #/
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 0
// Checksum 0x0, Offset: 0x1b2
// Size: 0x66
function init()
{
    scenarios = function_7e930b64aa35ffee();
    
    if ( isdefined( scenarios ) && scenarios.size > 0 )
    {
        level.br_destruction_scenario = spawnstruct();
        var_6a5dccee5fd220aa = function_bc90551fbdb43ef6( scenarios );
        level.br_destruction_scenario.var_6a5dccee5fd220aa = var_6a5dccee5fd220aa;
        thread function_bf0a1510baea47c5( var_6a5dccee5fd220aa );
        function_e9fe6584103182cb( var_6a5dccee5fd220aa );
    }
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 0
// Checksum 0x0, Offset: 0x220
// Size: 0x91
function function_7e930b64aa35ffee()
{
    mapinfo = getmapscriptbundle();
    
    if ( !isdefined( mapinfo ) )
    {
        return undefined;
    }
    
    if ( !isdefined( mapinfo.var_56d371dd4dd18dda ) || mapinfo.var_56d371dd4dd18dda == %"" )
    {
        return undefined;
    }
    
    var_6b937c81802e4bfb = getscriptbundle( mapinfo.var_56d371dd4dd18dda );
    
    if ( !isdefined( var_6b937c81802e4bfb ) )
    {
        assertmsg( "<dev string:x1c>" + mapinfo.var_56d371dd4dd18dda + "<dev string:x38>" );
        return undefined;
    }
    
    return var_6b937c81802e4bfb.scenarios;
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 3
// Checksum 0x0, Offset: 0x2ba
// Size: 0xfd
function function_667d4e416d37d616( origin, var_7c8953aa388fb2f0, var_f795b12e5a594b2c )
{
    if ( !isdefined( level.br_destruction_scenario ) || !isdefined( level.br_destruction_scenario.var_6a5dccee5fd220aa ) )
    {
        return undefined;
    }
    
    if ( !is_equal( level.br_destruction_scenario.var_6a5dccee5fd220aa.name, var_7c8953aa388fb2f0 ) )
    {
        return undefined;
    }
    
    if ( isdefined( var_f795b12e5a594b2c ) && isdefined( level.br_destruction_scenario.var_6a5dccee5fd220aa.destructionstate.state ) && var_f795b12e5a594b2c != level.br_destruction_scenario.var_6a5dccee5fd220aa.destructionstate.state )
    {
        return 0;
    }
    
    var_82a1b9668c3e9620 = function_335e62799b1a356a( origin, var_7c8953aa388fb2f0, level.br_destruction_scenario.var_6a5dccee5fd220aa.defaultstate );
    return var_82a1b9668c3e9620;
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 1
// Checksum 0x0, Offset: 0x3c0
// Size: 0x15c
function function_bc90551fbdb43ef6( scenarios )
{
    weightoverrides = getdvar( @"hash_d8db6ac022cc3906", "" );
    var_e3ecf1db05fcac6b = strtok( weightoverrides, "," );
    validoverrides = function_3c118c933f1f96b4( var_e3ecf1db05fcac6b );
    
    if ( validoverrides.size > 0 )
    {
        var_7b172f966919ffd3 = [];
        
        foreach ( index, scenario in scenarios )
        {
            scenario.name = tolower( scenario.name );
            scenario.weight = 0;
            var_7b172f966919ffd3[ scenario.name ] = index;
        }
        
        foreach ( validoverride in validoverrides )
        {
            var_e2417a1fab5e2e29 = var_7b172f966919ffd3[ validoverride.name ];
            scenarios[ var_e2417a1fab5e2e29 ].weight = validoverride.weight;
        }
    }
    
    return function_fd2c2c40201aed7e( scenarios );
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 1
// Checksum 0x0, Offset: 0x525
// Size: 0xf1
function function_3c118c933f1f96b4( var_e3ecf1db05fcac6b )
{
    validoverrides = [];
    
    foreach ( pair in var_e3ecf1db05fcac6b )
    {
        pairarray = strtok( pair, " " );
        
        if ( pairarray.size > 1 && isstring( pairarray[ 0 ] ) )
        {
            validoverride = spawnstruct();
            validoverride.name = tolower( pairarray[ 0 ] );
            validoverride.weight = int( pairarray[ 1 ] );
            validoverrides[ validoverrides.size ] = validoverride;
            continue;
        }
        
        assertmsg( "<dev string:x49>" + getxhashsourcename( @"hash_d8db6ac022cc3906" ) + "<dev string:x55>" + pair + "<dev string:x67>" );
    }
    
    return validoverrides;
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 1
// Checksum 0x0, Offset: 0x61f
// Size: 0xea
function function_fd2c2c40201aed7e( scenarios )
{
    totalweight = 0;
    
    foreach ( scenario in scenarios )
    {
        totalweight += scenario.weight;
    }
    
    choosenweight = randomfloat( totalweight );
    cumulativeweight = 0;
    var_6a5dccee5fd220aa = undefined;
    
    foreach ( scenario in scenarios )
    {
        cumulativeweight += scenario.weight;
        
        if ( cumulativeweight > choosenweight )
        {
            var_6a5dccee5fd220aa = scenario;
            break;
        }
    }
    
    return var_6a5dccee5fd220aa;
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 1
// Checksum 0x0, Offset: 0x712
// Size: 0x9f
function function_bf0a1510baea47c5( scenario )
{
    level endon( "game_ended" );
    
    if ( !isdefined( scenario ) )
    {
        return;
    }
    
    if ( isdefined( scenario.scenename ) )
    {
        scenario.scene = initscene( scenario.scenename );
    }
    
    if ( isdefined( scenario.var_beb3ce9cb5705897 ) && scenario.var_beb3ce9cb5705897 != "" )
    {
        game[ "dialog" ][ scenario.var_beb3ce9cb5705897 ] = scenario.var_beb3ce9cb5705897;
    }
    
    function_1109bf32b4f881b8( scenario );
    function_2d2875f903aa2a92( scenario );
    function_8aa7eefcc94fcf5d( scenario );
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 1
// Checksum 0x0, Offset: 0x7b9
// Size: 0x30
function initscene( scenename )
{
    scene = spawnstruct();
    scene scene::set_scriptbundle( scenename );
    scene scene::function_bc521bee52fde214( 1 );
    return scene;
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 1
// Checksum 0x0, Offset: 0x7f2
// Size: 0x172
function function_1109bf32b4f881b8( scenario )
{
    var_7837d7a932253c21 = !istrue( scenario.debugplay );
    
    if ( var_7837d7a932253c21 )
    {
        scripts\mp\flags::function_1240434f4201ac9d( "prematch_done" );
    }
    
    if ( isdefined( scenario.flyinstate ) )
    {
        setareaswaphint( scenario.name, scenario.flyinstate );
    }
    
    if ( isdefined( scenario.var_56e04d3d0e7663ca ) )
    {
        scripts\mp\compass::setupminimap( scenario.var_56e04d3d0e7663ca );
    }
    
    if ( var_7837d7a932253c21 )
    {
        scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    }
    else
    {
        waitframe();
    }
    
    if ( isdefined( scenario.defaultstate ) )
    {
        scripts\common\utility::function_39698f30fd7e8a1e( scenario.name, scenario.defaultstate );
    }
    
    if ( isdefined( scenario.flyinstate ) )
    {
        function_1c1e3d250d7d89e( scenario.name, scenario.flyinstate );
    }
    
    waitframe();
    
    if ( isdefined( scenario.scene ) )
    {
        scenario.scene scripts\common\scene::pre_stream();
        scenario.scene scripts\common\scene::init();
        scenario.scene scene::function_b0b8f796886a9c81( 1 );
    }
    
    if ( isdefined( scenario.destructionstate.state ) )
    {
        setareaswaphint( scenario.name, scenario.destructionstate.state );
    }
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 1
// Checksum 0x0, Offset: 0x96c
// Size: 0x99
function function_2d2875f903aa2a92( scenario )
{
    if ( !isdefined( scenario.scene ) )
    {
        return;
    }
    
    var_7837d7a932253c21 = !istrue( scenario.debugplay );
    
    if ( !var_7837d7a932253c21 )
    {
        waitframe();
    }
    else if ( isdefined( level.br_ac130 ) )
    {
        level.br_ac130 waittill( "start_moving" );
    }
    else
    {
        scripts\mp\flags::gameflagwait( "infil_animatic_complete" );
    }
    
    waittime = scripts\mp\gametypes\br_c130::function_130df32ea7502b9e() - scenario.var_3c98c782dfda4138;
    
    if ( waittime > 0 && var_7837d7a932253c21 )
    {
        wait waittime;
    }
    
    function_4d9e4eccd09dec28( scenario );
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 1
// Checksum 0x0, Offset: 0xa0d
// Size: 0x31
function function_4d9e4eccd09dec28( scenario )
{
    scenario.scene thread scripts\common\scene::play();
    level thread function_9977d85412dfb260( scenario );
    thread function_ad4330182461d797( scenario );
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 1
// Checksum 0x0, Offset: 0xa46
// Size: 0xa5
function function_8aa7eefcc94fcf5d( scenario )
{
    wait scenario.destructionstate.delay;
    
    if ( isdefined( scenario.destructionstate.state ) )
    {
        function_1c1e3d250d7d89e( scenario.name, scenario.destructionstate.state );
    }
    
    waittime = getdvarint( @"hash_c83d487ec3dec085", 2 );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    if ( isdefined( scenario.scene ) )
    {
        scenario.scene scripts\common\scene::cleanup();
    }
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 1
// Checksum 0x0, Offset: 0xaf3
// Size: 0x10e
function function_9977d85412dfb260( scenario )
{
    if ( isdefined( scenario.exploders ) && scenario.exploders.size > 0 )
    {
        foreach ( exploder in scenario.exploders )
        {
            if ( isdefined( exploder ) && isdefined( exploder.name ) )
            {
                if ( isdefined( exploder.delay ) && exploder.delay >= 0 )
                {
                    if ( exploder.delay == 0 )
                    {
                        thread scripts\engine\utility::exploder( exploder.name, level.players );
                        continue;
                    }
                    
                    scripts\engine\utility::delaythreadendon( exploder.delay, "game_ended", &scripts\engine\utility::exploder, exploder.name, level.players );
                }
            }
        }
    }
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 1
// Checksum 0x0, Offset: 0xc09
// Size: 0x5c
function function_ad4330182461d797( scenario )
{
    if ( isdefined( scenario.var_beb3ce9cb5705897 ) && scenario.var_beb3ce9cb5705897 != "" )
    {
        if ( isdefined( scenario.var_c335b73c96a684ee ) )
        {
            wait scenario.var_c335b73c96a684ee;
        }
        
        scripts\mp\gametypes\br_public::brleaderdialog( scenario.var_beb3ce9cb5705897 );
    }
}

// Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0xc6d
// Size: 0x3c
function private function_e9fe6584103182cb( scenario )
{
    eventparams = [ "scenario_name", scenario.name ];
    dlog_recordevent( "dlog_event_br_destruction_scenario", eventparams );
}

/#

    // Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
    // Params 0
    // Checksum 0x0, Offset: 0xcb1
    // Size: 0xc, Type: dev
    function debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
    // Params 0
    // Checksum 0x0, Offset: 0xcc5
    // Size: 0x41, Type: dev
    function devgui_init()
    {
        scenarios = namespace_c9be15e212bc70fe::function_7e930b64aa35ffee();
        
        if ( !isdefined( scenarios ) )
        {
            return;
        }
        
        function_e243334881a8b809( "<dev string:x6c>", &function_28157cbc9158d55f, scenarios );
        function_e243334881a8b809( "<dev string:x7c>", &function_dea73eea830e5dfd, scenarios );
    }

    // Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
    // Params 3
    // Checksum 0x0, Offset: 0xd0e
    // Size: 0x7c, Type: dev
    function function_e243334881a8b809( blockid, callback, scenarios )
    {
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x8c>" + blockid + "<dev string:xab>" );
        
        for ( i = 0; i < scenarios.size ; i++ )
        {
            scenario = scenarios[ i ];
            scripts\common\devgui::function_b23a59dfb4ca49a1( scenario.name, blockid + "<dev string:xb0>" + i, callback );
        }
        
        scripts\common\devgui::function_fe953f000498048f();
    }

    // Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
    // Params 1
    // Checksum 0x0, Offset: 0xd92
    // Size: 0xab, Type: dev
    function function_28157cbc9158d55f( params )
    {
        scenarios = namespace_c9be15e212bc70fe::function_7e930b64aa35ffee();
        scenario = scenarios[ int( params[ 0 ] ) ];
        scenario.debugplay = 1;
        
        if ( isdefined( scenario.scenename ) )
        {
            scenario.scene = initscene( scenario.scenename );
        }
        
        if ( isdefined( scenario.scene ) )
        {
            scenario.scene scripts\common\scene::pre_stream();
            scenario.scene scene::function_b0b8f796886a9c81( 1 );
        }
        
        function_4d9e4eccd09dec28( scenario );
    }

    // Namespace namespace_cf51e0de98ebcb9e / namespace_c9be15e212bc70fe
    // Params 1
    // Checksum 0x0, Offset: 0xe45
    // Size: 0x80, Type: dev
    function function_dea73eea830e5dfd( params )
    {
        scenarios = namespace_c9be15e212bc70fe::function_7e930b64aa35ffee();
        scenario = scenarios[ int( params[ 0 ] ) ];
        scenario.debugplay = 1;
        
        if ( isdefined( scenario.destructionstate.state ) )
        {
            function_1c1e3d250d7d89e( scenario.name, scenario.defaultstate );
        }
        
        waitframe();
        function_bf0a1510baea47c5( scenario );
    }

#/
