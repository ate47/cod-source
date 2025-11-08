#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_blackheart\gen\mp_jup_blackheart_art;
#using scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart_fx;
#using scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart_lighting;

#namespace mp_jup_blackheart;

// Namespace mp_jup_blackheart / scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart
// Params 0
// Checksum 0x0, Offset: 0x25a
// Size: 0xb6
function main()
{
    scripts\mp\maps\mp_jup_blackheart\gen\mp_jup_blackheart_art::main();
    scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart_fx::main();
    scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart_lighting::main();
    scripts\mp\load::main();
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    level.kill_border_triggers = getentarray( "kill_border_trigger", "targetname" );
    scripts\mp\compass::setupminimap( "compass_map_mp_jup_blackheart" );
    setdvar( @"hash_7686fcb92ccc5edb", 8 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    scripts\cp_mp\utility\game_utility::registersmallmap();
    thread crusher();
    thread shredder();
}

// Namespace mp_jup_blackheart / scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart
// Params 0
// Checksum 0x0, Offset: 0x318
// Size: 0x86
function crusher()
{
    level endon( "game_ended" );
    button = getent( "crusher_button", "targetname" );
    var_303a18afe9c2c7b = getent( "crusher_kill", "targetname" );
    
    if ( !isdefined( var_303a18afe9c2c7b ) )
    {
        return;
    }
    
    var_303a18afe9c2c7b trigger_off();
    msg = "crusher";
    thread show_label( button, msg );
    
    while ( true )
    {
        button waittill( "trigger", player );
        crush( var_303a18afe9c2c7b );
    }
}

// Namespace mp_jup_blackheart / scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart
// Params 0
// Checksum 0x0, Offset: 0x3a6
// Size: 0x86
function shredder()
{
    level endon( "game_ended" );
    button = getent( "shredder_button", "targetname" );
    var_303a18afe9c2c7b = getent( "shredder_kill", "targetname" );
    
    if ( !isdefined( var_303a18afe9c2c7b ) )
    {
        return;
    }
    
    var_303a18afe9c2c7b trigger_off();
    msg = "shredder";
    thread show_label( button, msg );
    
    while ( true )
    {
        button waittill( "trigger", player );
        Shred( var_303a18afe9c2c7b );
    }
}

// Namespace mp_jup_blackheart / scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart
// Params 2
// Checksum 0x0, Offset: 0x434
// Size: 0x7c
function show_label( trig, machine )
{
    level endon( "game_ended" );
    
    while ( true )
    {
        pos = trig.origin + ( 0, 0, 4 );
        msg = "Press F to activate " + machine;
        
        /#
            print3d( pos, msg, ( 0.9, 0.9, 0.9 ), 1, 0.2, 1, 1 );
        #/
        
        waitframe();
    }
}

// Namespace mp_jup_blackheart / scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart
// Params 1
// Checksum 0x0, Offset: 0x4b8
// Size: 0x5f
function crush( trig )
{
    crusher = getent( "crusher", "targetname" );
    crusher movez( -128, 8, 1, 1 );
    wait 8;
    time = 6;
    function_8b45da99e2a6da1c( trig, time );
    crusher movez( 128, 7, 1, 1 );
    wait 7;
}

// Namespace mp_jup_blackheart / scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart
// Params 1
// Checksum 0x0, Offset: 0x51f
// Size: 0xed
function Shred( trig )
{
    var_7105bdb05a2247b0 = getent( "shredder_one", "targetname" );
    var_a45b04b13c657546 = getent( "shredder_two", "targetname" );
    var_d1030d895bd655a = getent( "shredder_one_col", "targetname" );
    var_59b0e90096e2b534 = getent( "shredder_two_col", "targetname" );
    time = 6;
    thread function_8b45da99e2a6da1c( trig, time );
    var_7105bdb05a2247b0 rotateby( ( 0, 0, -360 ), time, 1, 1 );
    var_a45b04b13c657546 rotateby( ( 0, 0, -360 ), time, 1, 1 );
    var_d1030d895bd655a rotateby( ( 0, 0, 360 ), time, 1, 1 );
    var_59b0e90096e2b534 rotateby( ( 0, 0, -360 ), time, 1, 1 );
    wait time;
}

// Namespace mp_jup_blackheart / scripts\mp\maps\mp_jup_blackheart\mp_jup_blackheart
// Params 2
// Checksum 0x0, Offset: 0x614
// Size: 0x25
function function_8b45da99e2a6da1c( trig, time )
{
    trig trigger_on();
    wait time;
    trig trigger_off();
}

