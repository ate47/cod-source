#using script_261f1b574c15eab1;
#using script_3a535b44f9ecc6df;
#using script_7abaa04d5f9fc22e;
#using scripts\common\create_script_utility;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_jup_st_c_gw\gen\mp_jup_st_c_gw_art;
#using scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_create_script;
#using scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_fx;
#using scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_lighting;
#using scripts\quaked\script_struct_mp_iw9_atv;
#using scripts\quaked\script_struct_mp_iw9_cargo_truck;
#using scripts\quaked\script_struct_mp_iw9_jltv;
#using scripts\quaked\script_struct_mp_iw9_jltv_mg;
#using scripts\quaked\script_struct_mp_iw9_suv_1996;
#using scripts\quaked\script_struct_mp_iw9_techo_rebel_armor;
#using scripts\quaked\script_struct_mp_iw9_utv;
#using scripts\quaked\script_struct_mp_littlebird;

#namespace mp_jup_st_c_gw;

// Namespace mp_jup_st_c_gw / scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw
// Params 0
// Checksum 0x0, Offset: 0x1d4
// Size: 0xf1
function main()
{
    scripts\mp\maps\mp_jup_st_c_gw\gen\mp_jup_st_c_gw_art::main();
    scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_fx::main();
    scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_lighting::main();
    initvehicles();
    scripts\mp\load::main();
    scripts\cp_mp\utility\game_utility::registerlargemap();
    scripts\cp_mp\utility\game_utility::function_3673befc7dcade8b();
    
    if ( !isdefined( level.outofboundstriggers ) )
    {
        level.outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    }
    
    setdvar( @"hash_6beec004cdf37c0", 141 );
    scripts\mp\compass::setupminimap( "compass_map_mp_jup_st_c_gw" );
    setdvar( @"hash_7686fcb92ccc5edb", 8 );
    setdvar( @"hash_9365c7a237edaa2f", 1 );
    scripts\common\create_script_utility::initialize_create_script();
    level thread scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw_create_script::main();
    level.parachutecancutautodeploy = 1;
    level.parachutecancutparachute = 1;
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
}

// Namespace mp_jup_st_c_gw / scripts\mp\maps\mp_jup_st_c_gw\mp_jup_st_c_gw
// Params 0
// Checksum 0x0, Offset: 0x2cd
// Size: 0x5a
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
}

