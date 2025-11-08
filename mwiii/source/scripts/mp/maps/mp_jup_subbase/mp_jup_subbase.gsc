#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\anim;
#using scripts\mp\animation_suite;
#using scripts\mp\compass;
#using scripts\mp\flags;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_subbase\gen\mp_jup_subbase_art;
#using scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_fx;
#using scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_lighting;
#using scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_precache;
#using scripts\mp\utility\game;

#namespace mp_jup_subbase;

// Namespace mp_jup_subbase / scripts\mp\maps\mp_jup_subbase\mp_jup_subbase
// Params 0
// Checksum 0x0, Offset: 0x20a
// Size: 0x17c
function main()
{
    scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_fx::main();
    scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_lighting::main();
    scripts\mp\maps\mp_jup_subbase\mp_jup_subbase_precache::main();
    scripts\mp\maps\mp_jup_subbase\gen\mp_jup_subbase_art::main();
    scripts\mp\load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.kill_border_triggers = getentarray( "kill_border_trigger", "targetname" );
    scripts\mp\compass::setupminimap( "compass_map_mp_jup_subbase" );
    setdvar( @"hash_7686fcb92ccc5edb", 8 );
    setdvar( @"r_umbraaccurateocclusionthreshold", 1024 );
    setdvar( @"hash_71fe8b216d50a24c", 0.68 );
    setdvar( @"hash_402173c7dbee15d9", 3 );
    setdvar( @"hash_656131a98e0d2c9d", 100 );
    setdvar( @"hash_6a4705943fd574b8", 0.4 );
    setdvar( @"hash_d0658156fb7f2311", 2 );
    setdvar( @"hash_595f2292597ec0c7", ( 0.3, -1, 0 ) );
    setdvar( @"r_dof_tweak", 1 );
    setdvar( @"hash_a7d3d16432fa5feb", 1 );
    setdvar( @"hash_ed0c0ee0926e1d16", 1500 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread function_b1262e3cb659add1();
    thread function_79d4df95607e117();
    thread scripts\mp\animation_suite::animationsuite();
}

// Namespace mp_jup_subbase / scripts\mp\maps\mp_jup_subbase\mp_jup_subbase
// Params 0
// Checksum 0x0, Offset: 0x38e
// Size: 0x85
function function_b1262e3cb659add1()
{
    level waittill( "infil_setup_complete" );
    var_ee23f0b1f42da962 = getent( "static_infil_rhib", "targetname" );
    
    if ( gameflag( "infil_will_run" ) && isdefined( var_ee23f0b1f42da962 ) )
    {
        var_ee23f0b1f42da962 hide();
        level waittill( "prematch_over" );
        var_ee23f0b1f42da962 show();
        setdvar( @"r_dof_tweak", 1 );
        setdvar( @"hash_ed0c0ee0926e1d16", 29.31 );
        setdvar( @"hash_a7d3d16432fa5feb", 22 );
    }
}

// Namespace mp_jup_subbase / scripts\mp\maps\mp_jup_subbase\mp_jup_subbase
// Params 0
// Checksum 0x0, Offset: 0x41b
// Size: 0x75
function function_79d4df95607e117()
{
    trigger_1 = spawn( "trigger_box", ( 3980, -5556, -232 ), 0, ( 2048, 2048, 1024 ), ( 2048, 2048, 1024 ) + ( 1, 1, 1 ) );
    trigger_1.targetname = "OutOfBounds";
    level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger_1;
}

