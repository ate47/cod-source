#using script_261f1b574c15eab1;
#using script_3a535b44f9ecc6df;
#using script_7abaa04d5f9fc22e;
#using scripts\common\create_script_utility;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\gametypes\arm;
#using scripts\mp\gametypes\wm_objectives;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_gw_fallout\gen\mp_jup_gw_fallout_art;
#using scripts\mp\maps\mp_jup_gw_fallout\mp_jup_gw_fallout_create_script;
#using scripts\mp\maps\mp_jup_gw_fallout\mp_jup_gw_fallout_fx;
#using scripts\mp\maps\mp_jup_gw_fallout\mp_jup_gw_fallout_lighting;
#using scripts\mp\maps\mp_jup_gw_fallout\mp_jup_gw_fallout_precache;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\game;
#using scripts\quaked\script_struct_mp_iw9_atv;
#using scripts\quaked\script_struct_mp_iw9_cargo_truck;
#using scripts\quaked\script_struct_mp_iw9_jltv;
#using scripts\quaked\script_struct_mp_iw9_jltv_mg;
#using scripts\quaked\script_struct_mp_iw9_palfa;
#using scripts\quaked\script_struct_mp_iw9_suv_1996;
#using scripts\quaked\script_struct_mp_iw9_techo_rebel_armor;
#using scripts\quaked\script_struct_mp_iw9_utv;
#using scripts\quaked\script_struct_mp_jup_truck_tech_hmg;
#using scripts\quaked\script_struct_mp_littlebird;

#namespace mp_jup_gw_fallout;

// Namespace mp_jup_gw_fallout / scripts\mp\maps\mp_jup_gw_fallout\mp_jup_gw_fallout
// Params 0
// Checksum 0x0, Offset: 0x2ba
// Size: 0x17c
function main()
{
    scripts\mp\maps\mp_jup_gw_fallout\mp_jup_gw_fallout_precache::main();
    scripts\mp\maps\mp_jup_gw_fallout\gen\mp_jup_gw_fallout_art::main();
    scripts\mp\maps\mp_jup_gw_fallout\mp_jup_gw_fallout_fx::main();
    scripts\mp\maps\mp_jup_gw_fallout\mp_jup_gw_fallout_lighting::main();
    initvehicles();
    scripts\mp\load::main();
    scripts\cp_mp\utility\game_utility::registerlargemap();
    scripts\common\create_script_utility::initialize_create_script();
    
    if ( getgametype() == "arm" || isgroundwarcoremode() )
    {
        if ( !isdefined( level.localeid ) )
        {
            setdvar( @"hash_6beec004cdf37c0", 999 );
        }
        
        scripts\mp\gametypes\arm::arm_initoutofbounds();
    }
    else
    {
        level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
        level.kill_border_triggers = getentarray( "kill_border_trigger", "targetname" );
    }
    
    level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    scripts\mp\compass::setupminimap( "compass_map_mp_jup_gw_fallout" );
    setdvar( @"hash_7686fcb92ccc5edb", 8 );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    scripts\common\create_script_utility::initialize_create_script();
    level thread scripts\mp\maps\mp_jup_gw_fallout\mp_jup_gw_fallout_create_script::main();
    
    if ( getgametype() == "wm" )
    {
        scripts\mp\gametypes\wm_objectives::function_333f4c66e6305891( 1, "_a", "zone_1", "jup_dam_wb_capture_zone_a" );
        scripts\mp\gametypes\wm_objectives::function_333f4c66e6305891( 1, "_b", "zone_2", "jup_dam_wb_capture_zone_b" );
        scripts\mp\gametypes\wm_objectives::function_333f4c66e6305891( 1, "_c", "zone_3", "jup_dam_wb_capture_zone_c" );
    }
}

// Namespace mp_jup_gw_fallout / scripts\mp\maps\mp_jup_gw_fallout\mp_jup_gw_fallout
// Params 0
// Checksum 0x0, Offset: 0x43e
// Size: 0x68
function initvehicles()
{
    level.var_1b4da6b781c9dfbd = 1;
    namespace_8db7d778efdc3d65::main();
    namespace_15896d40cab0d429::main();
    scripts\quaked\script_struct_mp_iw9_atv::main();
    scripts\quaked\script_struct_mp_littlebird::main();
    scripts\quaked\script_struct_mp_iw9_jltv::main();
    scripts\quaked\script_struct_mp_iw9_jltv_mg::main();
    scripts\quaked\script_struct_mp_iw9_suv_1996::main();
    namespace_a5c3c313b4f6886a::main();
    scripts\quaked\script_struct_mp_iw9_cargo_truck::main();
    scripts\quaked\script_struct_mp_iw9_techo_rebel_armor::main();
    scripts\quaked\script_struct_mp_iw9_utv::main();
    scripts\quaked\script_struct_mp_iw9_palfa::main();
    scripts\quaked\script_struct_mp_jup_truck_tech_hmg::main();
}

