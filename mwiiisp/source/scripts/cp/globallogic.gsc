#using script_122c94e0d5135583;
#using script_157445dae3af0f9f;
#using script_15de7dc4d21f1da3;
#using script_17ca3af80f14ce7e;
#using script_251f071833394c68;
#using script_2d4725bf070ac3b;
#using script_3a8f9ace195c9da9;
#using script_3adfc798ed499f31;
#using script_41a5f0bf29408720;
#using script_448ef4d9e70ce5e;
#using script_4bac13d511590220;
#using script_4cdabcd91a92977;
#using script_5513783c21494d08;
#using script_61eb50466a589dec;
#using script_6dee2410821c6c07;
#using script_75a86c2332c8e92c;
#using script_cbb0697de4c5728;
#using scripts\anim\battlechatter;
#using scripts\code\ai;
#using scripts\common\ae_utility;
#using scripts\common\create_cover_nodes;
#using scripts\common\create_script_utility;
#using scripts\common\damage_effects;
#using scripts\common\debug_reflection;
#using scripts\common\devgui;
#using scripts\common\dof;
#using scripts\common\exploder;
#using scripts\common\fx;
#using scripts\common\shellshock_utility;
#using scripts\common\telemetry;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\cp\agent_damage;
#using scripts\cp\agent_drops;
#using scripts\cp\armory_kiosk;
#using scripts\cp\challenges_cp;
#using scripts\cp\coop_createfx;
#using scripts\cp\coop_fx;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\cp_aiparachute;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_anim;
#using scripts\cp\cp_awards;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_debug;
#using scripts\cp\cp_deployablebox;
#using scripts\cp\cp_dialogue;
#using scripts\cp\cp_gameskill;
#using scripts\cp\cp_hostmigration;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_mapselect;
#using scripts\cp\cp_merits;
#using scripts\cp\cp_movers;
#using scripts\cp\cp_music_and_dialog;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_outline;
#using scripts\cp\cp_outline_utility;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\cp_relics;
#using scripts\cp\cp_snakecam;
#using scripts\cp\cp_visionsets;
#using scripts\cp\cp_weaponrank;
#using scripts\cp\cp_weapons;
#using scripts\cp\damage;
#using scripts\cp\damagefeedback;
#using scripts\cp\drone\scout_drone;
#using scripts\cp\endgame;
#using scripts\cp\equipment;
#using scripts\cp\events;
#using scripts\cp\execution;
#using scripts\cp\gameobjects;
#using scripts\cp\gestures_cp;
#using scripts\cp\globallogic;
#using scripts\cp\intel\cp_intel;
#using scripts\cp\kits;
#using scripts\cp\laststand;
#using scripts\cp\loadout;
#using scripts\cp\loot_system;
#using scripts\cp\movement;
#using scripts\cp\movement_trigger;
#using scripts\cp\munitions;
#using scripts\cp\objective_trigger;
#using scripts\cp\perks;
#using scripts\cp\perks\cp_prestige;
#using scripts\cp\persistence;
#using scripts\cp\pickups;
#using scripts\cp\points;
#using scripts\cp\progression;
#using scripts\cp\radar_scrambler;
#using scripts\cp\rank;
#using scripts\cp\rewards_cp;
#using scripts\cp\scriptable;
#using scripts\cp\spawning;
#using scripts\cp\star_rewards;
#using scripts\cp\starts;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\utility\connect_event_aggregator;
#using scripts\cp\utility\cp_controlled_callbacks;
#using scripts\cp\utility\disconnect_event_aggregator;
#using scripts\cp\utility\lui_game_event_aggregator;
#using scripts\cp\utility\player;
#using scripts\cp\utility\player_frame_update_aggregator;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp\vehicles;
#using scripts\cp\vo;
#using scripts\cp\weapon;
#using scripts\cp\whizby;
#using scripts\cp_mp\agents\agent_init;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\execution;
#using scripts\cp_mp\gestures;
#using scripts\cp_mp\killstreaks\init;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\oxygenmask;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\pickups;
#using scripts\cp_mp\playerachievements;
#using scripts\cp_mp\playerhealth;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\stealth\manager;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\spawn_event_aggregator;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\engine\scriptable_door;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\art;
#using scripts\mp\flags;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\tweakables;
#using scripts\mp\utility\lower_message;
#using scripts\stealth\player;

#namespace globallogic;

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x1d01
// Size: 0x8f
function init()
{
    level.projectbundle = getprojectscriptbundle();
    level.gamemodebundle = getgamemodescriptbundle();
    level.gametypebundle = getgametypescriptbundle();
    level.mapbundle = getmapscriptbundle();
    function_b62653f2045e7215();
    thread scripts\cp\starts::init_starts();
    scripts\cp\cp_anim::init();
    function_3233dde235c8d2f7();
    function_ac74c1458f21b244();
    function_6adc128d1309d048();
    function_303f9875f954e1c4();
    function_b204b08f674548ab();
    function_2ef33231cd1fa43();
    function_f6a78bbe53021bf8();
    function_4361a652d4e6cc62();
    scripts\code\ai::function_87dc2db63d1cfe13();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x1d98
// Size: 0x1f
function function_b62653f2045e7215()
{
    level.createfx_enabled = getdvar( @"createfx" ) != "";
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x1dbf
// Size: 0x64
function function_3233dde235c8d2f7()
{
    initgameflags();
    initlevelflags();
    function_5588f0c4ff7058f1();
    init_global_cp_flags();
    function_1284bfde6c25b9ca();
    init_global_cp_script_funcs();
    level.struct_filter = &cp_struct_filter;
    init_struct_class();
    flag_set( "bsp_structs_initialized" );
    delete_on_load();
    namespace_bf9ffd2b22c7d819::main();
    level thread function_7280babc254585b2();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x1e2b
// Size: 0x9
function function_5588f0c4ff7058f1()
{
    function_a59d6b296a8381f6();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x1e3c
// Size: 0x35
function function_a59d6b296a8381f6()
{
    setdvar( @"hash_9f60e77c0e91da76", 180 );
    setdvar( @"hash_9f60e67c0e91d843", 180 );
    setdvar( @"hash_9f60e57c0e91d610", 180 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x1e79
// Size: 0x15
function function_ca96261e273d33c0( bool )
{
    level.var_3480abea6656fce6 = bool;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x1e96
// Size: 0x15
function function_8619b71f2573363b( bool )
{
    level.var_cee48b761f8ca747 = bool;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x1eb3
// Size: 0x72
function function_b204b08f674548ab()
{
    setomnvar( "ui_hide_nameplates_for_zero_health", 0 );
    function_1e81309dcf11faa();
    init_destructables();
    shellshock_init();
    init_hud();
    adjust_heartbeat_sensor_settings();
    function_56585b89be143a09();
    function_e2fc4dea9278cbd8();
    setup_callbacks();
    function_248519cfcaf04c4a();
    function_a75f0074296ba485();
    function_bf4f95ec0dff09ae();
    function_44daa9c20a1fd399();
    function_1c2b32222a73294b();
    function_ca96261e273d33c0( 1 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x1f2d
// Size: 0x1f
function function_2ef33231cd1fa43()
{
    thread scripts\mp\tweakables::settweakablevalue( "player", "maxhealth", [[ level.playermaxhealth ]]() );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x1f54
// Size: 0x67
function function_6adc128d1309d048()
{
    scripts\common\fx::initfx();
    scripts\common\exploder::setupexploders();
    scripts\common\create_script_utility::initialize_create_script();
    level thread scripts\engine\scriptable_door::system_init();
    utility::spawncorpsehider();
    level thread namespace_bed52b18307bf1e0::main();
    level thread namespace_46454e0fdfc84088::main();
    thread snd_init();
    scripts\common\visibility_mode::main( &namespace_9e238f5e6fc1f074::function_764239e6a246c46a );
    utility::fixplacedweapons();
    
    /#
        scripts\common\debug_reflection::init_reflection_probe( 1 );
        scripts\common\devgui::init_devgui();
    #/
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x1fc3
// Size: 0xb
function function_ac74c1458f21b244()
{
    level thread scripts\cp\munitions::init_munitions();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x1fd6
// Size: 0x24e
function function_4361a652d4e6cc62()
{
    create_player_threatbias_groups();
    scripts\cp\cp_gameskill::init_gameskill();
    scripts\cp\gameobjects::init_gameobjects();
    level thread scripts\cp\cp_movers::main();
    level thread namespace_88f49e01608e39bf::function_9a3c64059e71fa7b();
    level thread function_167432a034a768dc();
    function_5401225e56f7fa1b();
    function_7e9d9ac29d0ac7a3();
    scripts\cp\scriptable::scriptable_cpglobalcallback();
    scripts\cp\endgame::init();
    scripts\cp\damagefeedback::init();
    scripts\cp\coop_fx::main();
    scripts\cp\cp_merits::buildmeritinfo();
    thread scripts\cp_mp\equipment::init();
    thread scripts\cp\star_rewards::init();
    thread namespace_9246f10206f50768::function_7dcad89b9c0264a6();
    scripts\cp\whizby::init();
    scripts\cp\cp_dialogue::main();
    level thread scripts\anim\battlechatter::init_battlechatter();
    level thread scripts\cp\cp_checkpoint::checkpoints_init();
    level thread scripts\cp\spawning::spawning_init();
    level thread scripts\cp\laststand::laststand_init();
    level thread scripts\cp\rank::init();
    level thread scripts\cp\events::init();
    level thread scripts\cp\cp_deployablebox::init();
    level thread scripts\cp\drone\scout_drone::init();
    level thread scripts\cp_mp\oxygenmask::function_234851f94416f178();
    level thread scripts\cp\cp_visionsets::vision_set_management();
    level thread scripts\cp\cp_outline_utility::init();
    level thread function_f79a0775f27a26d7();
    thread scripts\cp\challenges_cp::init();
    thread scripts\cp\rewards_cp::init();
    level thread scripts\cp\cp_analytics::initsegmentstats();
    level thread scripts\cp\cp_analytics::dlog_analytics_init();
    thread scripts\common\telemetry::init();
    thread namespace_a7430cfb7d293cf::init();
    level thread scripts\cp\cp_awards::init();
    level thread scripts\cp\points::initpoints();
    level thread scripts\cp\cp_player_battlechatter::init();
    scripts\cp\weapon::weaponsinit();
    scripts\cp\cp_outline::outline_init();
    scripts\cp\cp_music_and_dialog::function_21168b5cd3f92925();
    level scripts\cp\cp_hud_message::init_cp_hud_message();
    level thread scripts\cp\loot_system::init_loot();
    scripts\cp\loadout::init();
    thread scripts\cp\cp_relics::init();
    level thread [[ level.var_59c3f456a9e5d4f0 ]]();
    level thread global_physics_sound_monitor();
    level thread namespace_1189bdf1260c0376::init();
    level thread scripts\cp\agent_drops::function_6620b2d387064d74();
    scripts\cp_mp\agents\agent_utils::function_a09756b37f2e0681();
    
    if ( !function_f620e996a1d7d81a() && !is_operations_gametype() )
    {
        level thread scripts\cp\pickups::init();
        level thread scripts\cp\armory_kiosk::init();
    }
    
    scripts\cp\radar_scrambler::function_d86f905b2efc08b9();
    
    if ( scripts\cp\objective_trigger::function_ab29f5844aa437fb() )
    {
        scripts\cp\objective_trigger::function_ae2bc8e7d8d4fc9b();
    }
    
    if ( scripts\cp\movement_trigger::function_777c44bdfc80c0bb() )
    {
        thread scripts\cp\movement_trigger::function_fbbb9e404ce48427();
    }
    
    namespace_1fdb557af4bcd29e::function_4becaa200ddc0956();
    function_3bc2a3f24dcd4061();
    function_3069b525e1c98faf( "START" );
    level thread scripts\cp\cp_debug::debuginit_demo();
    level thread function_c15a7ce9004a44b4();
    
    /#
        if ( !scripts\cp\cp_debug::function_91979fbf5dbf3bea() )
        {
            level thread scripts\cp\cp_debug::debuginit();
        }
        
        level thread function_182fa47a3be3b00c();
        function_8a1222e55fe609a6();
        thread function_872f994e74eaf646();
    #/
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x222c
// Size: 0x10
function function_3bc2a3f24dcd4061()
{
    scripts\cp\progression::init();
    scripts\cp\kits::init();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x2244
// Size: 0x1b0
function function_c15a7ce9004a44b4()
{
    level endon( "game_ended" );
    wait 5;
    function_ef4970d8905d4c5b( "br_loot_cache" );
    function_ef4970d8905d4c5b( "br_loot_cache_lege" );
    function_ef4970d8905d4c5b( "br_loot_cache_gulag" );
    function_ef4970d8905d4c5b( "br_scavenger_quest_cache" );
    function_ef4970d8905d4c5b( "br_quest_safe" );
    function_ef4970d8905d4c5b( "dmz_supply_drop" );
    function_ef4970d8905d4c5b( "dmz_boss_supply_drop" );
    function_ef4970d8905d4c5b( "dmz_supply_drop_samsite" );
    function_ef4970d8905d4c5b( "dmz_safe" );
    function_ef4970d8905d4c5b( "dmz_hidden_container" );
    function_ef4970d8905d4c5b( "dmz_secret_stash" );
    function_ef4970d8905d4c5b( "dmz_geiger_counter_cache" );
    function_ef4970d8905d4c5b( "cache_medicine_cabinet" );
    function_ef4970d8905d4c5b( "cache_bar_cabinet" );
    function_ef4970d8905d4c5b( "cache_school_locker_a" );
    function_ef4970d8905d4c5b( "cache_school_locker_b" );
    function_ef4970d8905d4c5b( "cache_computer_tower" );
    function_ef4970d8905d4c5b( "cache_dresser" );
    function_ef4970d8905d4c5b( "cache_fridge_a" );
    function_ef4970d8905d4c5b( "cache_fridge_b" );
    function_ef4970d8905d4c5b( "cache_fridge_mini" );
    function_ef4970d8905d4c5b( "cache_fridge_old" );
    function_ef4970d8905d4c5b( "cache_comm_fridge_01" );
    function_ef4970d8905d4c5b( "cache_comm_fridge_02" );
    function_ef4970d8905d4c5b( "cache_toolbox" );
    function_ef4970d8905d4c5b( "cache_cash_register" );
    function_ef4970d8905d4c5b( "dmz_crate_wood" );
    function_ef4970d8905d4c5b( "cache_medical_box_wall" );
    function_ef4970d8905d4c5b( "cache_office_cabinet" );
    function_ef4970d8905d4c5b( "dmz_hidden_container_common" );
    function_ef4970d8905d4c5b( "cache_duffel_bag_01" );
    function_ef4970d8905d4c5b( "cache_duffel_bag_02" );
    function_ef4970d8905d4c5b( "cache_hanging_clothes" );
    function_ef4970d8905d4c5b( "cache_mail_kiosk" );
    function_ef4970d8905d4c5b( "cache_weapon_locker" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x23fc
// Size: 0xb
function function_ef4970d8905d4c5b( var_14004b68ddacb781 )
{
    
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x240f
// Size: 0xa6
function create_player_threatbias_groups()
{
    createthreatbiasgroup( "player1" );
    createthreatbiasgroup( "player2" );
    createthreatbiasgroup( "player3" );
    createthreatbiasgroup( "player4" );
    createthreatbiasgroup( "player1_enemy" );
    createthreatbiasgroup( "player2_enemy" );
    createthreatbiasgroup( "player3_enemy" );
    createthreatbiasgroup( "player4_enemy" );
    setthreatbias( "player1", "player1_enemy", 10000 );
    setthreatbias( "player2", "player2_enemy", 10000 );
    setthreatbias( "player3", "player3_enemy", 10000 );
    setthreatbias( "player4", "player4_enemy", 10000 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x24bd
// Size: 0x1be
function function_7280babc254585b2()
{
    level thread scripts\cp\utility\connect_event_aggregator::init();
    level thread scripts\cp\utility\spawn_event_aggregator::init();
    level thread scripts\cp\utility\lui_game_event_aggregator::init();
    level thread scripts\cp\utility\disconnect_event_aggregator::init();
    level thread scripts\cp\utility\player_frame_update_aggregator::init();
    level thread namespace_510f48b89ec0a7d::init();
    level thread namespace_da1f3c0af8e51b0f::init();
    level thread namespace_1bc2e7966ef15029::init();
    level scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback( &check_for_execution_allows );
    level scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback( &scripts\cp_mp\utility\player_utility::updateinputtypewatcher );
    level namespace_510f48b89ec0a7d::function_3ae366ec2732af83( &function_d1a06b15d459dbda );
    level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback( &scripts\cp\munitions::function_b64f3836c1d7a06 );
    level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback( &scripts\cp_mp\pickups::function_db908ecaccbe933c );
    level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback( &scripts\cp\loot_system::function_e146f016a8a7244f );
    level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback( &function_4a39c5c1f9ea026f );
    level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback( &inventory_watcher );
    level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback( &scripts\cp_mp\armor::function_13caa305c839a278 );
    level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback( &function_9a82f8a066c216e0 );
    
    if ( getdvar( @"ui_gametype" ) == "missions" || getdvar( @"ui_gametype" ) == "dungeons" )
    {
        level scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback( &scripts\cp\cp_objectives::function_4060f86cf056cf74 );
    }
    
    level scripts\cp\utility\connect_event_aggregator::registeronconnectcallback( &function_5c8bea04d4909519 );
    level scripts\cp\utility\connect_event_aggregator::registeronconnectcallback( &function_64908cf46d806427 );
    level scripts\cp\utility\connect_event_aggregator::registeronconnectcallback( &function_e14e30e8c9c40402 );
    level scripts\cp\utility\connect_event_aggregator::registeronconnectcallback( &function_174cbb4c8632933f );
    level scripts\cp\utility\connect_event_aggregator::registeronconnectcallback( &namespace_bf9ffd2b22c7d819::function_342af7ea8a120b16 );
    level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &scripts\cp_mp\armor::initarmor );
    level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &scripts\cp_mp\armor::givestartingarmor );
    level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &scripts\cp\movement::function_36d589dc5c4191f6 );
    level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &scripts\cp\super::function_50eb338949884fca );
    level scripts\cp\utility\disconnect_event_aggregator::registerondisconnecteventcallback( &function_7fdeb6dccfd886ab );
    level scripts\cp\utility\connect_event_aggregator::registeronconnectcallback( &scripts\cp\intel\cp_intel::intel_onplayerconnect );
    level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &scripts\cp\intel\cp_intel::function_383bbac10494b5ff );
    level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &function_288e19381da612c4 );
    level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &scripts\cp\vehicles::function_3458e37bbac2ff9a );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x2683
// Size: 0x3b
function function_288e19381da612c4()
{
    var_aa1caebf050b34cc = self getplayerdata( "cp", "progression", "thirdPerson" );
    
    if ( istrue( var_aa1caebf050b34cc ) )
    {
        function_5e658169357048f0( 1 );
        return;
    }
    
    function_5e658169357048f0( 0 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x26c6
// Size: 0xb0
function function_4a39c5c1f9ea026f( channel, value )
{
    if ( channel == "toggle_camera_view" )
    {
        player = undefined;
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            ent_num = level.players[ i ] getentitynumber();
            
            if ( ent_num == value )
            {
                player = level.players[ i ];
                
                if ( istrue( player.var_512f0d6731086f73 ) )
                {
                    return;
                }
                
                if ( istrue( player.var_911b640702fec71a ) )
                {
                    player function_5e658169357048f0( 0 );
                }
                else
                {
                    player function_5e658169357048f0( 1 );
                }
                
                break;
            }
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x277e
// Size: 0x99
function private function_5e658169357048f0( bool )
{
    if ( istrue( bool ) )
    {
        self setclientomnvar( "ui_toggle_third_person", 1 );
        self setplayerdata( "cp", "progression", "thirdPerson", 1 );
        self.var_911b640702fec71a = 1;
        
        if ( !istrue( self.var_57910e77921f4061 ) )
        {
            function_532e7b905134a981( 1 );
        }
    }
    else
    {
        self setclientomnvar( "ui_toggle_third_person", 0 );
        self setplayerdata( "cp", "progression", "thirdPerson", 0 );
        self.var_911b640702fec71a = undefined;
        function_532e7b905134a981( 0 );
    }
    
    self notify( "toggled_third_person_camera", bool );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x281f
// Size: 0x30
function private function_532e7b905134a981( bool )
{
    if ( istrue( bool ) )
    {
        self setcamerathirdperson( 1 );
        return;
    }
    
    self setcamerathirdperson( 0 );
    self setthirdpersonadsoverride( "none" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x2857
// Size: 0x53
function function_db31ae430d191461( bool )
{
    if ( istrue( bool ) )
    {
        self.var_57910e77921f4061 = 1;
        
        if ( istrue( self.var_911b640702fec71a ) )
        {
            function_532e7b905134a981( 0 );
        }
        
        return;
    }
    
    self.var_57910e77921f4061 = undefined;
    
    if ( istrue( self.var_911b640702fec71a ) )
    {
        function_532e7b905134a981( 1 );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x28b2
// Size: 0xb2
function function_9a82f8a066c216e0( channel, value )
{
    if ( channel == "jump_to_start" )
    {
        potential_starts = getdvar( @"hash_c4b5f7005920fc31" );
        tokens = strtok( potential_starts, "," );
        
        if ( isdefined( tokens[ value - 1 ] ) )
        {
            if ( isdefined( level.start_arrays ) && isdefined( level.start_arrays[ tokens[ value - 1 ] ] ) )
            {
                setdvar( @"start", tokens[ value - 1 ] );
                scripts\cp\cp_checkpoint::checkpoint_set( "" );
            }
            
            scripts\cp\endgame::function_180b06d3d67d483c( "Jump To Start Used" );
            scripts\cp\endgame::restart_map( 0, "map_restart" );
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x296c
// Size: 0x2
function function_535f161986dc4245()
{
    
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x2976
// Size: 0x33
function function_303f9875f954e1c4()
{
    level thread scripts\mp\objidpoolmanager::init();
    level thread scripts\mp\sentientpoolmanager::init();
    
    if ( !isdefined( level.tweakablesinitialized ) )
    {
        thread scripts\mp\tweakables::init();
    }
    
    /#
        scripts\mp\art::main();
    #/
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x29b1
// Size: 0xfe
function function_f6a78bbe53021bf8()
{
    function_51337dedfd496b9c();
    level thread namespace_c4892e65895918e2::init();
    scripts\cp_mp\agents\agent_init::agent_init();
    level thread scripts\cp_mp\utility\game_utility::game_utility_init();
    thread scripts\common\shellshock_utility::init();
    level thread scripts\cp_mp\targetmarkergroups::init();
    scripts\cp_mp\utility\player_utility::initdismembermentlist();
    scripts\cp_mp\entityheadicons::init();
    level thread scripts\cp_mp\emp_debuff::emp_debuff_init();
    level thread scripts\cp_mp\gestures::init();
    level thread scripts\cp\gestures_cp::init_cp();
    level thread scripts\cp_mp\execution::execution_init();
    level thread scripts\cp\execution::init_cp_execution();
    namespace_a2c409363d7f24e7::init();
    level scripts\cp_mp\squads::init();
    level scripts\cp_mp\armor::init();
    level scripts\cp_mp\overlord::init();
    level namespace_46e942396566f2da::function_3b59b4d385a202e6();
    level thread function_c4ada2395f072b1f();
    
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) )
        {
            level.disablevehiclescripts = 1;
        }
    #/
    
    level thread scripts\cp\vehicles::vehicles_init();
    level thread scripts\cp_mp\killstreaks\init::init();
    level thread scripts\cp_mp\challenges::init();
    
    if ( issharedfuncdefined( "seasonalevents", "init" ) )
    {
        level callsharedfunc( "seasonalevents", "init" );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x2ab7
// Size: 0x9
function function_51337dedfd496b9c()
{
    scripts\cp_mp\utility\spawn_event_aggregator::init();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x2ac8
// Size: 0x34
function function_c4ada2395f072b1f()
{
    level.healthregendisabled = 0;
    level scripts\cp_mp\playerhealth::init_playerhealth();
    level scripts\common\damage_effects::init();
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &scripts\common\damage_effects::function_9bc46d4b8891a740 );
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback( &scripts\cp_mp\playerhealth::manageplayerregen );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x2b04
// Size: 0x9d
function function_d1a06b15d459dbda()
{
    if ( isdefined( self.timeplayed ) )
    {
        team = self.sessionteam;
        
        if ( !isdefined( self.timeplayed[ team ] ) )
        {
            self.timeplayed[ team ] = 0;
        }
        else
        {
            self.timeplayed[ team ]++;
        }
        
        if ( team != "spectator" && team != "codcaster" )
        {
            self.timeplayed[ "total" ]++;
            self.timeplayed[ "missionTeam" ]++;
            
            if ( !scripts\cp\utility\player::isreallyalive( self ) )
            {
                self.timeplayed[ "timeDead" ]++;
            }
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x2ba9
// Size: 0x151, Type: bool
function cp_struct_filter( struct )
{
    if ( isdefined( struct.targetname ) )
    {
        switch ( struct.targetname )
        {
            case #"hash_9b2bc10b45523d3e":
            case #"hash_e422764f669256eb":
                return false;
        }
    }
    
    if ( isdefined( struct.script_noteworthy ) )
    {
        switch ( struct.script_noteworthy )
        {
            case #"hash_19a53eb1370a2b5":
            case #"hash_c2f2b523efe604f":
            case #"hash_d35ffa282189588":
            case #"hash_15315e9e009ef512":
            case #"hash_1f75ac0b9750399c":
            case #"hash_2e69e6252b59fe0b":
            case #"hash_2efdcc6e130bdf2c":
            case #"hash_3375e4d4517a5346":
            case #"hash_346c163f63e350f5":
            case #"hash_3e895f3f69e5c6e0":
            case #"hash_447b0ef146230900":
            case #"hash_521f09d0a197ede4":
            case #"hash_67ba230fb131ff98":
            case #"hash_6f009b2dd6c738c0":
            case #"hash_7df245010bdec44e":
            case #"hash_a4dc58ed10bbbe80":
            case #"hash_a5cd241fca7777ef":
            case #"hash_f54ac943e5d38b77":
            case #"hash_fd1d64ac6c8a46ae":
                return false;
        }
    }
    
    return true;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x2d03
// Size: 0x3f
function waypoint_init()
{
    if ( level.splitscreen )
    {
        level.waypoint_size = 15;
    }
    else
    {
        level.waypoint_size = 8;
    }
    
    level.waypoint_alpha = 0.75;
    level.waypoint_index = 0;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x2d4a
// Size: 0x4a
function findboxcenter( mins, maxs )
{
    center = ( 0, 0, 0 );
    center = maxs - mins;
    center = ( center[ 0 ] / 2, center[ 1 ] / 2, center[ 2 ] / 2 ) + mins;
    return center;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x2d9d
// Size: 0xb3
function init_global_cp_flags()
{
    flag_init( "strike_init_done" );
    flag_init( "infil_complete" );
    flag_init( "introscreen_over" );
    flag_init( "interactions_initialized" );
    flag_init( "level_ready_for_script" );
    flag_init( "player_spawned_with_loadout" );
    flag_init( "ready_for_devgui" );
    flag_init( "gameskill_initialized" );
    flag_init( "bsp_structs_initialized" );
    flag_init( "scriptables_ready" );
    flag_init( "player_spawned_with_loadout" );
    flag_init( "level_stealth_initialized" );
    flag_init( "stealth_enabled" );
    flag_init( "stealth_spotted" );
    level thread set_systems_init_flag();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x2e58
// Size: 0x36
function function_1284bfde6c25b9ca()
{
    gameflaginit( "prematch_done", 0 );
    gameflaginit( "infil_setup_complete", 0 );
    gameflaginit( "infil_will_run", 0 );
    gameflaginit( "infil_started", 0 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x2e96
// Size: 0xb
function init_global_cp_script_funcs()
{
    level thread create_script_wait_for_flags();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x2ea9
// Size: 0x30
function set_systems_init_flag()
{
    level endon( "game_ended" );
    flag_wait_all( "strike_init_done", "infil_complete", "introscreen_over", "interactions_initialized" );
    flag_set( "level_ready_for_script" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x2ee1
// Size: 0x521
function function_56585b89be143a09()
{
    level.splitscreen = issplitscreen();
    level.current_attempts = function_791e463b9df434fc();
    level.var_2cb04ca6155de37f = getdvarint( @"hash_cc4ee5aa21aa68d3", 1 );
    level.onlinegame = getdvarint( @"onlinegame" );
    level.rankedmatch = level.onlinegame && !getdvarint( @"xblive_privatematch" ) || getdvarint( @"hash_9c2d59c1962cac50" );
    level.script = tolower( getdvar( @"g_mapname" ) );
    level.mapname = scripts\cp_mp\utility\game_utility::getmapname();
    level.gametype = tolower( getdvar( @"ui_gametype" ) );
    level.otherteam[ "allies" ] = "axis";
    level.otherteam[ "axis" ] = "allies";
    level.multiteambased = 0;
    level.teambased = 1;
    level.func = [];
    level.coop_mode_feature = [];
    level.var_8c70b00c48e8bd20 = [];
    level.spawnmins = ( 2.14748e+09, 2.14748e+09, 2.14748e+09 );
    level.spawnmaxs = ( -2147483647, -2147483647, -2147483647 );
    level.tier1modeenabled = 0;
    level.numgametypereservedobjectives = 0;
    level.numkills = 0;
    level.lethaldelay = 0;
    level.backpack_disabled = 0;
    level.reclaimedreservedobjectives = [];
    level.var_646444267bcf2e45 = [];
    level.date = get_actual_time_from_civil( 8 );
    level.default_goalradius = 2048;
    level.path_node_table = "cp/cp_path_node_table.csv";
    level.leanthread = getdvarint( @"scr_runlean_playerthread_count", 0 ) == 1;
    level.gametype = tolower( getdvar( @"g_gametype" ) );
    level.codcasterenabled = 0;
    level.systemlink = getdvarint( @"systemlink", 0 ) == 1;
    level.var_3904de63dbc4b0af = getdvarint( @"hash_401232859bce6c37", 0 );
    level.useperbullethitmarkers = getdvarint( @"hash_7c131ece8edf8fa", 0 ) == 1;
    level.splitscreen = issplitscreen();
    level.onlinegame = getdvarint( @"onlinegame" );
    level.rankedmatch = level.onlinegame || getdvarint( @"hash_9c2d59c1962cac50" );
    level.matchmakingmatch = level.onlinegame && !getdvarint( @"xblive_privatematch" );
    level.playerxpenabled = 1;
    level.weaponxpenabled = level.playerxpenabled;
    level.challengesallowed = level.matchmakingmatch || getdvarint( @"force_challenges" );
    level.enforceantiboosting = level.playerxpenabled || level.weaponxpenabled || level.challengesallowed;
    level.onlinestatsenabled = level.rankedmatch;
    level.starttimeutcseconds = getsystemtime();
    level.pingsystemactive = getdvarint( @"hash_e8512e1508afefe8", 1 );
    level.current_personal_interaction_structs = [];
    level.active_cs_files = [];
    level.active_objectives = [];
    level.weapon_drop_cooldown = [];
    level.grenade_drop_cooldown = [];
    level.teamnamelist = [ "axis", "allies" ];
    level.func[ "scriptmodelplayanim" ] = &scriptmodelplayanim;
    level.func[ "scriptModelPlayAnim" ] = &scriptmodelplayanim;
    level.func[ "precachempanim" ] = &precachempanim;
    level.func[ "scriptmodelclearanim" ] = &scriptmodelclearanim;
    level.func[ "scriptModelClearAnim" ] = &scriptmodelclearanim;
    level.fnoffhandfire = &scripts\cp\weapon::ai_offhandfiremanager;
    level.vehiclefriendlydamage = getdvarint( @"scr_vehiclefriendlydamage", 0 ) > 0;
    level.framedurationseconds = level.frameduration / 1000;
    level.lastslowprocessframe = 0;
    level.mapcenter = findboxcenter( level.spawnmins, level.spawnmaxs );
    level.maxteamsize = 4;
    level.maxsquadsize = getdvarint( @"party_maxsquadsize", 4 );
    level.var_da6cb768c7ca7b39 = &function_cc7bfeb1d9ec91cb;
    level.var_c4e3d516b4ea7be7 = 8;
    level.var_37190777eeb4333f = 1;
    
    /#
        level thread function_1312ace74efdf578();
    #/
    
    scripts\cp\pickups::function_7a302a314424968f( 1 );
    setmapcenter( level.mapcenter );
    waypoint_init();
    
    if ( getdvarint( @"hash_2082bd2f4a48916f", 0 ) != 0 )
    {
        level.dogtag_revive = 1;
    }
    
    /#
        level.dev_build = 1;
    #/
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x340a
// Size: 0xd
function function_cc7bfeb1d9ec91cb()
{
    self.var_230a3287f9ad2965 = 1;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x341f
// Size: 0x3d
function function_791e463b9df434fc()
{
    value = getdvarint( @"hash_9138afe32459ddb3", 0 );
    new_value = value + 1;
    value = setdvar( @"hash_9138afe32459ddb3", new_value );
    return new_value;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x3465
// Size: 0x22d
function function_e2fc4dea9278cbd8()
{
    setdvar( @"hash_855e5f66c3d7cec5", 1 );
    setdvar( @"hash_ab695f7f6c849bd1", 1 );
    setdvar( @"hash_a8ee1540ced18a88", 0 );
    setdvar( @"camera_thirdperson", getdvarint( @"scr_thirdperson" ) );
    setdvar( @"hash_8ed4dff39f3251f5", getdvar( @"scr_game_forceuav" ) );
    setdvar( @"hash_ccf9753c4ee466cc", matchmakinggame() );
    setdvar( @"ui_overtime", 0 );
    setdvar( @"ui_allow_teamchange", 1 );
    setdvar( @"g_deadchat", 1 );
    setdvar( @"hash_4e2f47a7b2856857", 5 );
    setdvar( @"ui_friendlyfire", 0 );
    setdvar( @"hash_11420719fff4b2a2", 0 );
    setdvar( @"cg_drawcrosshair", ter_op( scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924(), 0, 1 ) );
    setdvar( @"cg_drawcrosshairnames", 1 );
    setdvar( @"hash_721a6fa1822b17d9", 0 );
    setdvar( @"hash_67846a0d7aa3030a", 0 );
    setdvar( @"hash_db88b998734440cc", "" );
    setdvar( @"hash_da72de981085e768", defaultplayermaxhealth() );
    setdvarifuninitialized( @"hash_cce2d04880fe5113", 1 );
    setdvarifuninitialized( @"hash_a18e65eb2a8dfec6", "" );
    setdvar( @"hash_a3a1cab75dca6cc6", 0 );
    setdvar( @"scr_nohitmarker", 0 );
    setdvar( @"hash_687f6fe472201df1", 1 );
    setdvar( @"hash_4e5b353bf84974a9", 1 );
    setdvar( @"online_matchdata_enabled", 0 );
    setdvar( @"hash_bd445b33649ddb33", 1 );
    setdvarifuninitialized( @"hash_697b2deb810da53b", 50 );
    setdvarifuninitialized( @"hash_3b3635b854bc49ac", 0 );
    
    if ( getbuildversion() == "SHIP" )
    {
        setdvar( @"hash_3b3635b854bc49ac", 1 );
    }
    
    registerfalldamagedvars();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x369a
// Size: 0x25
function registerfalldamagedvars()
{
    setdvar( @"bg_falldamageminheight", 225 );
    setdvar( @"bg_falldamagemaxheight", 590 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x36c7
// Size: 0x236
function setup_callbacks()
{
    level.callbackstartgametype = &startgametype;
    level.callbackplayeractive = &blank;
    level.callbackplayerconnect = &defaultplayerconnect;
    level.callbackplayerdisconnect = &defaultplayerdisconnect;
    level.callbackplayerdamage = &defaultplayerdamage;
    level.callbackplayerimpaled = &callback_agent_impaled;
    level.callbackplayerkilled = &defaultplayerkilled;
    level.callbackplayermigrated = &defaultplayermigrated;
    level.callbackhostmigration = &defaulthostmigration;
    level.var_42d9b617bbca6a42 = &blank;
    level.var_935c97aa3757676f = &function_5c9544ef10cb9e0c;
    level.getspawnpoint = &defaultgetspawnpoint;
    level.onspawnplayer = &blank;
    level.onprecachegametype = &blank;
    level.onstartgametype = &blank;
    level.playermaxhealth = &defaultplayermaxhealth;
    level.playerinitinvulnerability = &player_init_invulnerability;
    level.spawnplayerfunc = &spawnplayer;
    level.enterspectatorfunc = &function_382ab3472a4da4e6;
    level.intermissionfunc = &spawnintermission;
    level.getkilltriggerspawnloc = &getkilltriggerspawnloc;
    level.initagentscriptvariables = &scripts\cp\cp_agent_utils::initagentscriptvariables;
    level.setagentteam = &scripts\cp\cp_agent_utils::set_agent_team;
    level.agentvalidateattacker = &scripts\cp\cp_agent_utils::validateattacker;
    level.agentfunc = &scripts\cp\cp_agent_utils::agentfunc;
    level.getfreeagent = &scripts\cp\cp_agent_utils::getfreeagent;
    level.addtocharactersarray = &scripts\cp_mp\utility\game_utility::addtocharactersarray;
    level.callbackplayerlaststand = &scripts\cp\laststand::callback_playerlaststand;
    level.endgame = &scripts\cp\endgame::endgame;
    level.forceendgame = &scripts\cp\endgame::forceendgame;
    level.var_b11db2283dbd7ed3 = &scripts\cp\movement::player_movement_state;
    level.var_3c8e175d92be01ea = &function_297bf30b6352b598;
    level.var_4941fc1ee570d4cb = &function_47320a25b8ee003;
    level.var_cda3af1f73639c7c = &function_2a643088582c8be3;
    scripts\cp\utility\cp_controlled_callbacks::registercontrolledcallback( "Earthquake", &earthquake, 5, &function_97196d9c69a91e2b, 0, 0, 0, 1, 1 );
    scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback( &scripts\cp\endgame::function_51a7fd1c0c6690f9 );
    scripts\cp\utility\lui_game_event_aggregator::registeronluieventcallback( &scripts\cp\endgame::function_899bd4add25ddd3 );
    
    if ( level.gametype == "dungeons" )
    {
        level.intermissionfunc = undefined;
    }
    
    namespace_8b5a0cf52cbe3e30::function_2fce2f81588a2462();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x3905
// Size: 0x4b
function function_47320a25b8ee003()
{
    kit = scripts\cp\kits::function_cab56589fd214c7e();
    
    if ( isdefined( kit ) && kit == "assault" )
    {
        if ( istrue( self.hasplatepouch ) )
        {
            return 6;
        }
        else
        {
            return 4;
        }
    }
    
    if ( istrue( self.hasplatepouch ) )
    {
        return 5;
    }
    
    return 3;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x3959
// Size: 0x1c
function function_1e81309dcf11faa()
{
    level._effect[ "slide_dust" ] = loadfx( "vfx/core/screen/vfx_scrnfx_tocam_slidedust_m" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 12
// Checksum 0x0, Offset: 0x397d
// Size: 0x63
function defaultplayerdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname )
{
    
}

// Namespace globallogic / scripts\cp\globallogic
// Params 10
// Checksum 0x0, Offset: 0x39e8
// Size: 0x53
function defaultplayerkilled( einflictor, attacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x3a43
// Size: 0x81
function function_167432a034a768dc()
{
    level endon( "game_ended" );
    default_var = "";
    
    while ( true )
    {
        if ( getdvar( @"hash_a18e65eb2a8dfec6", default_var ) != default_var )
        {
            break;
        }
        
        wait 1;
    }
    
    time = getdvarfloat( @"hash_a18e65eb2a8dfec6" );
    setslowmotion( time, time, 0 );
    
    /#
        setdevdvar( @"hash_a18e65eb2a8dfec6", "<dev string:x1c>" );
    #/
    
    level thread function_167432a034a768dc();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 8
// Checksum 0x0, Offset: 0x3acc
// Size: 0x56
function callback_agent_impaled( eattacker, sweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34 )
{
    thread impale( eattacker, self, sweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 9
// Checksum 0x0, Offset: 0x3b2a
// Size: 0x1f6
function impale( eattacker, var_5b033344a44bb910, sweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34 )
{
    if ( isdefined( level.harpoon_impale_additional_func ) )
    {
        [[ level.harpoon_impale_additional_func ]]( sweapon, eattacker, var_5b033344a44bb910, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34 );
        return;
    }
    
    var_5b033344a44bb910 startragdoll();
    contents = physics_createcontents( [ "physicscontents_solid", "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item" ] );
    endpoint = vpoint + vdir * 4096;
    trace = scripts\engine\trace::ray_trace_detail( vpoint, endpoint, undefined, contents, undefined, 1 );
    endpoint = trace[ "position" ] - vdir * 12;
    flightdist = length( endpoint - vpoint );
    flighttime = flightdist / 1250;
    flighttime = clamp( flighttime, 0.05, 1 );
    wait 0.05;
    var_a0480a10ee4e345f = vdir;
    var_c323f0cb880a051f = anglestoup( eattacker.angles );
    var_c1148ff802be2880 = vectorcross( var_a0480a10ee4e345f, var_c323f0cb880a051f );
    railent = spawn_tag_origin( vpoint, axistoangles( var_a0480a10ee4e345f, var_c1148ff802be2880, var_c323f0cb880a051f ) );
    railent moveto( endpoint, flighttime );
    constraint = spawnragdollconstraint( var_5b033344a44bb910, shitloc, spartname, var_19f6f25777706f34 );
    constraint.origin = railent.origin;
    constraint.angles = railent.angles;
    constraint linkto( railent );
    thread impale_cleanup( var_5b033344a44bb910, railent, flighttime + 0.05, constraint );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 4
// Checksum 0x0, Offset: 0x3d28
// Size: 0x44
function impale_cleanup( evictim, railent, time, constraint )
{
    evictim waittill_any_timeout_2( time, "death", "disconnect" );
    constraint delete();
    railent delete();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x3d74
// Size: 0xfd
function function_248519cfcaf04c4a()
{
    var_66c10bbc36ee3a2c = [ "trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_damage" ];
    
    foreach ( triggertype in var_66c10bbc36ee3a2c )
    {
        triggers = getentarray( triggertype, "classname" );
        
        for ( i = 0; i < triggers.size ; i++ )
        {
            if ( isdefined( triggers[ i ].script_prefab_exploder ) )
            {
                triggers[ i ].script_exploder = triggers[ i ].script_prefab_exploder;
            }
            
            if ( isdefined( triggers[ i ].script_exploder ) )
            {
                level thread exploder_load( triggers[ i ] );
            }
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x3e79
// Size: 0x1d
function function_5401225e56f7fa1b()
{
    level thread trackgrenades();
    level thread trackmissiles();
    level thread trackcarepackages();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x3e9e
// Size: 0x28
function trackgrenades()
{
    while ( true )
    {
        level.grenades = getentarray( "grenade", "classname" );
        wait 0.05;
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x3ece
// Size: 0x28
function trackmissiles()
{
    while ( true )
    {
        level.missiles = getentarray( "rocket", "classname" );
        wait 0.05;
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x3efe
// Size: 0x28
function trackcarepackages()
{
    while ( true )
    {
        level.carepackages = getentarray( "care_package", "targetname" );
        wait 0.05;
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x3f2e
// Size: 0x6c
function defaultplayermaxhealth()
{
    if ( function_240f7f4e57340e8f() && isdefined( level.var_77b28b68031c94c1 ) )
    {
        return level.var_77b28b68031c94c1;
    }
    
    if ( istrue( self.keep_perks ) )
    {
        if ( has_zombie_perk( "perk_machine_tough" ) )
        {
            return 200;
        }
        else
        {
            return getdvarint( @"scr_player_maxhealth", 100 );
        }
        
        return;
    }
    
    return getdvarint( @"scr_player_maxhealth", 100 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x3fa2
// Size: 0x4c
function function_a75f0074296ba485()
{
    game[ "thermal_vision" ] = "thermal_mp";
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "clientid" ] = 0;
    game[ "state" ] = "playing";
    game[ "status" ] = "normal";
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x3ff6
// Size: 0x106
function function_bf4f95ec0dff09ae()
{
    bundle = isdefined( level.gamemodebundle ) ? level.gamemodebundle : spawnstruct();
    visionsetnaked( "", 0 );
    visionsetnight( "default_night_mp" );
    visionsetmissilecam( "missilecam" );
    visionsetthermal( game[ "thermal_vision" ] );
    visionsetpain( isdefined( bundle.visionset_pain ) ? bundle.visionset_pain : "damage_deathsdoor", 0 );
    visionsetdeath( isdefined( bundle.visionset_death ) ? bundle.visionset_death : "death" );
    visionsetdamagedistortion( isdefined( bundle.var_813a06af0c271672 ) ? bundle.var_813a06af0c271672 : "damage_radial" );
    visionsetdamagecolor( isdefined( bundle.var_96467afb3300bf50 ) ? bundle.var_96467afb3300bf50 : "damage_severe" );
    visionsetwhizby( "whizby" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x4104
// Size: 0x16
function function_44daa9c20a1fd399()
{
    setnojipscore( 1, 1 );
    setnojiptime( 1, 1 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x4122
// Size: 0x43
function function_1c2b32222a73294b()
{
    if ( getdvarint( @"hash_22eddf44003baf9", 0 ) != 0 && doescurrentplaylistsupportrejoin() )
    {
        setdvar( @"hash_925f7dceb8e6205e", 1 );
        return;
    }
    
    setdvar( @"hash_925f7dceb8e6205e", 0 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x416d
// Size: 0x18
function defaultgetspawnpoint()
{
    return getassignedspawnpoint( getstructarray( "default_player_start", "targetname" ) );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x418e
// Size: 0x45
function getassignedspawnpoint( spawnpoints )
{
    assertex( spawnpoints.size > 0, "no spawn points found" );
    player_entity_num = self getentitynumber();
    assertex( isdefined( spawnpoints[ player_entity_num ] ), "no spawn point for player id: " + player_entity_num );
    return spawnpoints[ player_entity_num ];
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x41dc
// Size: 0x263
function startgametype()
{
    [[ level.onprecachegametype ]]();
    level thread monitor_num_players();
    
    /#
        level thread function_3543eaafa6b72b85();
    #/
    
    level thread function_23eb2e4122646287();
    
    if ( !scripts\cp\utility::function_240f7f4e57340e8f() )
    {
        level thread function_cc38ddc890d2bb22();
        level thread function_2933e78a1455a35f();
    }
    else
    {
        level.timerstarttime = gettime();
        function_7a294a03559cf85e();
    }
    
    resetlevelflags();
    resetlevelarrays();
    scripts\common\create_script_utility::initialize_registered_create_script_files();
    scripts\cp\perks::initperks();
    
    if ( !function_ccf98e6391dd38b9() )
    {
        scripts\cp\cp_weaponrank::init();
    }
    
    function_c0d2c91f2688ece4( 1 );
    level thread runprematch();
    level thread graceperiodmonitor();
    scripts\cp\cp_aiparachute::init_cp_aiparachute();
    sysprint( "Ready for Compass" );
    scripts\mp\flags::levelflaginit( "game_over", 0 );
    level thread startgame();
    level thread scripts\cp\cp_mapselect::init();
    
    if ( !istrue( level.dev_build ) )
    {
        add_demo_button_combo( [ "touchpad", "swap_weapon_release" ], &demo_toggle_infiniteammo, undefined, 1 );
        add_demo_button_combo( [ "touchpad", "swap_weapon", "swap_weapon_release" ], &demo_toggle_infiniteammo, undefined, 1 );
        add_demo_button_combo( [ "touchpad", "stance_release" ], &demo_toggle_ufo, undefined, 1 );
        add_demo_button_combo( [ "touchpad", "stance", "stance_release" ], &demo_toggle_ufo, undefined, 1 );
        add_demo_button_combo( [ "touchpad", "use_release" ], &demo_toggle_godmode, undefined, 1 );
        add_demo_button_combo( [ "touchpad", "use", "use_release" ], &demo_toggle_godmode, undefined, 1 );
    }
    else
    {
        add_demo_button_combo( [ "ads", "use", "a", "use_release", "a_release" ], &scripts\cp\spawning::print_active_modules_to_screen, "show active modules", 2 );
    }
    
    level scripts\mp\utility\lower_message::function_5a98c45a6252b4a();
    scripts\cp_mp\utility\loot::init();
    game[ "gamestarted" ] = 1;
    game[ "life_count" ] = 0;
    level thread wait_for_strike_init_complete();
    scripts\cp\agent_damage::register_ai_damage_callbacks();
    scripts\cp\agent_damage::register_ai_drop_funcs();
    level thread scripts\common\dof::function_9030ff462f3daa1a();
    
    if ( scripts\cp\utility::function_240f7f4e57340e8f() )
    {
        level thread scripts\cp\cp_analytics::recordbreadcrumbdata();
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x4447
// Size: 0x2c8
function function_2933e78a1455a35f()
{
    level endon( "game_ended" );
    flag_wait( "level_ready_for_script" );
    flag_wait( "player_spawned_with_loadout" );
    wait 5;
    [ var_985d5155902ab692, time_remaining ] = function_be99aa6c661d4a( @"hash_eb91d378c179ba9f", 480 - 60 );
    function_c77bc7bf12f9b7e2( var_985d5155902ab692, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_MINUTES", int( time_remaining ) );
    var_45dd7a4f2de86ab2 = var_985d5155902ab692;
    [ var_985d5155902ab692, time_remaining ] = function_be99aa6c661d4a( @"hash_ed70323c9a6e966b", 480 - 30 );
    function_c77bc7bf12f9b7e2( var_985d5155902ab692 - var_45dd7a4f2de86ab2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_MINUTES", int( time_remaining ) );
    var_45dd7a4f2de86ab2 = var_985d5155902ab692;
    [ var_985d5155902ab692, time_remaining ] = function_be99aa6c661d4a( @"hash_dee32f538dba0794", 480 - 15 );
    function_c77bc7bf12f9b7e2( var_985d5155902ab692 - var_45dd7a4f2de86ab2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_MINUTES", int( time_remaining ) );
    var_45dd7a4f2de86ab2 = var_985d5155902ab692;
    [ var_985d5155902ab692, time_remaining ] = function_be99aa6c661d4a( @"hash_3c8fb3b02192f953", 480 - 5 );
    function_c77bc7bf12f9b7e2( var_985d5155902ab692 - var_45dd7a4f2de86ab2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_MINUTES", int( time_remaining ) );
    var_45dd7a4f2de86ab2 = var_985d5155902ab692;
    [ var_985d5155902ab692, time_remaining ] = function_be99aa6c661d4a( @"hash_4182434f66636da8", 480 - 2 );
    function_c77bc7bf12f9b7e2( var_985d5155902ab692 - var_45dd7a4f2de86ab2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_MINUTES", int( time_remaining ) );
    var_45dd7a4f2de86ab2 = var_985d5155902ab692;
    [ var_985d5155902ab692, time_remaining ] = function_be99aa6c661d4a( @"hash_a233b185b88f1a75", 480 - 1 );
    function_c77bc7bf12f9b7e2( var_985d5155902ab692 - var_45dd7a4f2de86ab2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_MINUTES", int( time_remaining ) );
    var_45dd7a4f2de86ab2 = var_985d5155902ab692;
    [ var_985d5155902ab692, time_remaining ] = function_be99aa6c661d4a( @"hash_3902a722e6cc08f8", 480 - 0.5 );
    function_c77bc7bf12f9b7e2( var_985d5155902ab692 - var_45dd7a4f2de86ab2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_SECONDS", int( time_remaining * 60 ) );
    var_45dd7a4f2de86ab2 = var_985d5155902ab692;
    [ var_985d5155902ab692, time_remaining ] = function_be99aa6c661d4a( @"hash_b5e11430896dccca", 480 - 0.25 );
    function_c77bc7bf12f9b7e2( var_985d5155902ab692 - var_45dd7a4f2de86ab2, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_SECONDS", int( time_remaining * 60 ) );
    wait 1;
    time_left = int( time_remaining * 60 ) - 1;
    
    for ( i = 0; i < time_left ; i++ )
    {
        function_c77bc7bf12f9b7e2( 1, "COOP_GAME_PLAY/SERVER_SHUT_DOWN_WARNING_SECONDS", time_left - i );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x4717
// Size: 0x40
function function_be99aa6c661d4a( dvar, var_72f66ada661ac94 )
{
    var_985d5155902ab692 = getdvarfloat( dvar, var_72f66ada661ac94 );
    time_remaining = 480 - var_985d5155902ab692;
    return [ var_985d5155902ab692, time_remaining ];
}

// Namespace globallogic / scripts\cp\globallogic
// Params 3
// Checksum 0x0, Offset: 0x4760
// Size: 0x32
function function_c77bc7bf12f9b7e2( wait_for_time, error_message, time_remaining )
{
    level endon( "game_ended" );
    wait wait_for_time * 60;
    level thread scripts\cp\cp_hud_message::showerrormessagetoallplayers( error_message, time_remaining );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x479a
// Size: 0x1e
function create_script_wait_for_flags()
{
    level endon( "game_ended" );
    flag_wait( "level_ready_for_script" );
    level thread scripts\cp\cp_snakecam::init_camera_interaction();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x47c0
// Size: 0x52
function wait_for_strike_init_complete()
{
    if ( flag_exist( "strike_init_done" ) )
    {
        level endon( "game_ended" );
        flag_wait( "strike_init_done" );
    }
    
    if ( scripts\cp\coop_stealth::level_should_run_sp_stealth() )
    {
        scripts\cp_mp\stealth\manager::main();
        flag_set( "level_stealth_initialized" );
    }
    
    scripts\cp_mp\parachute::initparachutedvars();
    
    /#
        level thread scripts\common\create_cover_nodes::create_cover_node_init();
    #/
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x481a
// Size: 0x63
function resetlevelflags()
{
    level.fauxvehiclecount = 0;
    level.gameended = 0;
    level.graceperiod = 10;
    level.ingraceperiod = level.graceperiod;
    level.noragdollents = getentarray( "noragdoll", "targetname" );
    level.friendlyfire = 0;
    level.starttime = gettime();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x4885
// Size: 0x6d
function resetlevelarrays()
{
    level.players = [];
    level.participants = [];
    level.characters = [];
    level.helis = [];
    level.turrets = [];
    level.ims = [];
    level.ugvs = [];
    level.balldrones = [];
    level.fake_players = [];
    level.demo_button_combos = [];
    scripts\cp_mp\utility\game_utility::values_init();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x48fa
// Size: 0x56
function runprematch()
{
    level notify( "coop_pre_match" );
    level endon( "coop_pre_match" );
    level endon( "game_ended" );
    setomnvar( "ui_prematch_period", 1 );
    
    if ( isdefined( level.prematchfunc ) )
    {
        [[ level.prematchfunc ]]();
    }
    
    gameflagset( "prematch_done" );
    setomnvar( "ui_prematch_period", 0 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x4958
// Size: 0x56
function graceperiodmonitor()
{
    level notify( "coop_grace_period" );
    level endon( "game_ended" );
    level endon( "coop_grace_period" );
    
    while ( getactiveclientcount() == 0 )
    {
        wait 0.05;
    }
    
    while ( level.ingraceperiod > 0 )
    {
        wait 1;
        level.ingraceperiod--;
    }
    
    level.ingraceperiod = 0;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x49b6
// Size: 0x2d
function startgame()
{
    /#
        function_c77248252473a2b8();
    #/
    
    [[ level.onstartgametype ]]();
    level scripts\engine\utility::flag_set( "onStartGameTypeFinished" );
    thread gametimer();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x49eb
// Size: 0x56
function gametimer()
{
    level endon( "game_ended" );
    
    if ( isdefined( game[ "startTimeFromMatchStart" ] ) )
    {
        level.starttimefrommatchstart = game[ "startTimeFromMatchStart" ];
    }
    
    if ( !isdefined( game[ "startTimeFromMatchStart" ] ) )
    {
        game[ "startTimeFromMatchStart" ] = gettime();
        level.starttimefrommatchstart = gettime();
        scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_match_start" );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x4a49
// Size: 0x2e, Type: bool
function function_62e5612ad414abf()
{
    return getdvar( @"dedicated" ) == "dedicated lan server" || getdvar( @"dedicated" ) == "dedicated internet server";
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x4a80
// Size: 0x73
function function_f79a0775f27a26d7()
{
    if ( !function_62e5612ad414abf() )
    {
        return;
    }
    
    for ( ;; )
    {
        if ( level.rankedmatch )
        {
            exitlevel( 0 );
        }
        
        if ( !getdvarint( @"xblive_privatematch" ) )
        {
            exitlevel( 0 );
        }
        
        if ( getdvar( @"dedicated" ) != "dedicated lan server" && getdvar( @"dedicated" ) != "dedicated internet server" )
        {
            exitlevel( 0 );
        }
        
        wait 5;
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x4afb
// Size: 0x78
function refreshuimatchinprogressomnvarvalue()
{
    var_2b8bdd3ebc30486a = 0;
    
    if ( level.players.size > 1 )
    {
        var_2b8bdd3ebc30486a = 1;
    }
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_match_in_progress", var_2b8bdd3ebc30486a );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x4b7b
// Size: 0x2fa
function defaultplayerconnect()
{
    self endon( "disconnect" );
    self.statusicon = "hud_status_connecting";
    self waittill( "begin" );
    
    if ( getdvarint( @"hash_390753f43ca68388", 0 ) )
    {
        level.backpack_disabled = 1;
        disable_backpack_inventory( 1 );
    }
    
    self.statusicon = "";
    
    /#
        function_294ee37e0dec5270();
    #/
    
    connect_time = gettime();
    level notify( "connected", self );
    function_5ce6e63df1d04eca();
    function_3999591663b82c6a();
    function_8259ed9008f45c23();
    function_ccc85fdb936857b3();
    init_laststand();
    function_6361f223bf803c8e();
    scripts\cp\perks\cp_prestige::initplayerprestige();
    scripts\cp\perks::init_each_perk();
    scripts\cp\damage::initplayerdamagefunctions();
    thread setup_player_stealth();
    
    if ( coop_mode_has( "outline" ) )
    {
        thread scripts\cp\cp_outline::playeroutlinemonitor();
    }
    
    thread demo_allowed_debug_outline();
    thread scripts\cp\vo::function_36bcbfd3365dc368();
    thread scripts\cp\cp_merits::updatemerits();
    thread track_forward_velocity();
    self.pers[ "matchdataWeaponStats" ] = [];
    self.pers[ "weaponStats" ] = [];
    self setclientomnvar( "ui_scoreboard_freeze", 0 );
    
    if ( self ishost() )
    {
        level.player = self;
    }
    else if ( isdedicatedserver() )
    {
        if ( !isdefined( level.player ) )
        {
            level.player = level.players[ 0 ];
        }
    }
    
    waittillframeend();
    addplayertolevelarrays( self );
    
    if ( game[ "state" ] == "postgame" )
    {
        self.connectedpostgame = 1;
        self setclientdvars( @"cg_drawspectatormessages", 0 );
        spawnintermission();
        return;
    }
    
    if ( isai( self ) && isdefined( level.bot_funcs ) && isdefined( level.bot_funcs[ "think" ] ) )
    {
        self thread [[ level.bot_funcs[ "think" ] ]]();
    }
    
    level endon( "game_ended" );
    
    if ( isdefined( level.hostmigrationtimer ) )
    {
        thread scripts\cp\cp_hostmigration::hostmigrationtimerthink();
    }
    
    function_f1b6f6cfed27eb0();
    
    if ( isdefined( level.onplayerconnectaudioinit ) )
    {
        [[ level.onplayerconnectaudioinit ]]();
    }
    
    if ( !isai( self ) )
    {
        playermonitor();
    }
    
    if ( getdvarint( @"hash_35749e6d180b4d00", 0 ) )
    {
    }
    
    scripts\cp_mp\utility\game_utility::startkeyearning();
    spawnplayer();
    assertex( connect_time == gettime(), "player spawn took too long - there should be no waits in player connect logic" );
    
    if ( getprojectname() == "JUP" )
    {
        foreach ( player in level.players )
        {
            player setsoundsubmix( "jup_global_ingame", 0.05 );
            player setsoundsubmix( "jup_global_sp", 0.05 );
            player thread function_b1b93d51d4e1fde8();
            player clearsoundsubmix( "jup_global_igc_skip" );
            player clearsoundsubmix( "jup_global_death", 10 );
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x4e7d
// Size: 0x25
function function_6361f223bf803c8e()
{
    self.telemetrydata = spawnstruct();
    self.telemetrydata.player = self;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x4eaa
// Size: 0xb
function function_b9953eb97ad6c0d2()
{
    return self.telemetrydata;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x4ebe
// Size: 0x6d
function function_ea9fc8f6656867d7()
{
    if ( isdefined( level.session_dvars ) )
    {
        keys = getarraykeys( level.session_dvars );
        
        for ( i = 0; i < keys.size ; i++ )
        {
            dvar = keys[ i ];
            value = level.session_dvars[ dvar ];
            setdvar( dvar, value );
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x4f33
// Size: 0x173
function check_for_execution_allows()
{
    if ( !isalive( self ) )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( istrue( self.inlaststand ) )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( istrue( self.being_revived ) )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( istrue( self.isreviving ) )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( self isreloading() )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( istrue( self.binvehicle ) )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( self isonladder() )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( self issprintsliding() )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( self issupersprinting() )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( self isjumping() )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( self isgestureplaying() )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( self isviewmodelanimplaying() )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( self isthrowinggrenade() )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( self isparachuting() )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( self isinfreefall() )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( istrue( self.isjuggernaut ) )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( self islinked() )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    if ( !self isonground() )
    {
        scripts\cp_mp\execution::disableexecutionattackwrapper();
        return;
    }
    
    scripts\cp_mp\execution::enableexecutionattackwrapper();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x50ae
// Size: 0xdb
function demo_allowed_debug_outline()
{
    self endon( "disconnect" );
    thread demo_debug_outline_button_watcher();
    
    while ( true )
    {
        self waittill( "demo_debug_outline" );
        
        if ( getdvarint( @"hash_c021e81d04f69f38", 0 ) )
        {
            if ( isdefined( level.debug_outline ) )
            {
                setdvar( @"hash_9e9513e7705385bd", 0 );
                level.debug_outline = undefined;
                scripts\cp\cp_outline::unset_outline();
                scripts\cp\cp_outline::restore_outline_settings();
                announcement( "debug - outline turned off!" );
                iprintln( "debug - outline turned off!" );
            }
            else
            {
                setdvar( @"hash_9e9513e7705385bd", 1 );
                level.debug_outline = 1;
                scripts\cp\cp_outline::save_outline_settings();
                demo_debug_outline_settings();
                level thread scripts\cp\cp_outline::set_outline( "outline_nodepth_red" );
                announcement( "debug - outline turned on!" );
                iprintln( "debug - outline turned on!" );
            }
            
            wait 0.1;
            continue;
        }
        
        wait 1;
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x5191
// Size: 0x10
function demo_toggle_godmode()
{
    /#
        adddebugcommand( "<dev string:x1d>" );
    #/
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x51a9
// Size: 0x10
function demo_toggle_ufo()
{
    /#
        adddebugcommand( "<dev string:x21>" );
    #/
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x51c1
// Size: 0x52
function demo_toggle_infiniteammo()
{
    value = getdvarint( @"player_sustainammo", 0 );
    
    if ( value == 0 )
    {
        announcement( "infinite ammo - on" );
        value = 1;
    }
    else
    {
        announcement( "infinite ammo - off" );
        value = 0;
    }
    
    setdvar( @"player_sustainammo", value );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x521b
// Size: 0xe2
function demo_debug_outline_button_watcher()
{
    self endon( "disconnect" );
    self notifyonplayercommand( "first", "-actionslot 1" );
    self notifyonplayercommand( "second", "-actionslot 2" );
    self notifyonplayercommand( "third", "+usereload" );
    
    while ( true )
    {
        msg = waittill_any_timeout_no_endon_death_1( 2, "first" );
        
        if ( msg == "timeout" )
        {
            continue;
        }
        
        msg = waittill_any_timeout_no_endon_death_1( 2, "second" );
        
        if ( msg == "timeout" )
        {
            continue;
        }
        
        msg = waittill_any_timeout_no_endon_death_1( 2, "first" );
        
        if ( msg == "timeout" )
        {
            continue;
        }
        
        msg = waittill_any_timeout_no_endon_death_1( 2, "second" );
        
        if ( msg == "timeout" )
        {
            continue;
        }
        
        msg = waittill_any_timeout_no_endon_death_1( 2, "third" );
        
        if ( msg == "timeout" )
        {
            continue;
        }
        
        self notify( "demo_debug_outline" );
        waitframe();
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x5305
// Size: 0x77
function demo_debug_outline_settings()
{
    setdvar( @"r_hudoutlinefillcolor0", ".5 .5 .5 1" );
    setdvar( @"r_hudoutlinefillcolor1", "1 1 1 .2" );
    setdvar( @"r_hudoutlineoccludedoutlinecolor", "1 .25 .25 1" );
    setdvar( @"r_hudoutlineoccludedinlinecolor", ".7 .7 .7 1" );
    setdvar( @"r_hudoutlineoccludedinteriorcolor", "1 0 0 1" );
    setdvar( @"r_hudoutlineoccludedcolorfromfill", 1 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x5384
// Size: 0x4b
function setup_player_stealth()
{
    self notify( "setup_player_stealth" );
    self endon( "setup_player_stealth" );
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    
    if ( scripts\cp\coop_stealth::level_should_run_sp_stealth() )
    {
        flag_wait( "level_stealth_initialized" );
        scripts\stealth\player::main();
        stealthsetusereallightingmodifierforvisibility( 0 );
        thread scripts\cp\coop_stealth::suspicious_door_monitor();
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x53d7
// Size: 0x347
function track_forward_velocity()
{
    self notify( "track_forward_velocity" );
    self endon( "track_forward_velocity" );
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    self.velo_array = [];
    self.average_velo = ( 0, 0, 0 );
    self.mag_array = [];
    self.average_mag = 0;
    self.velo_forward = self.origin;
    self.velo_forward_memory = [];
    var_c690971453d240f = 0;
    var_ad8c91b69d4e6868 = 0;
    var_14cc1f4d241c2506 = 0;
    var_a345e8165850a107 = 0;
    var_b98e1cc2e2bf1f8c = undefined;
    
    while ( true )
    {
        velocity = self getvelocity();
        temp_array = [];
        var_685edebde05db999 = [ 1024 * min( length( velocity ) / 240, 1 ) ];
        var_9bccabb90a92aa8c = [];
        
        if ( velocity != ( 0, 0, 0 ) )
        {
            if ( !isdefined( var_b98e1cc2e2bf1f8c ) || distance2dsquared( self.origin, var_b98e1cc2e2bf1f8c ) >= 62500 )
            {
                var_c690971453d240f = 1;
                var_ad8c91b69d4e6868 = 1;
                var_14cc1f4d241c2506 = 0;
                var_a345e8165850a107 = 0;
                var_9bccabb90a92aa8c[ var_9bccabb90a92aa8c.size ] = self.origin;
                temp_array[ temp_array.size ] = velocity;
                var_b98e1cc2e2bf1f8c = self.origin;
            }
            else
            {
                var_14cc1f4d241c2506++;
                var_a345e8165850a107++;
                
                if ( var_14cc1f4d241c2506 >= 12 )
                {
                    var_14cc1f4d241c2506 = 0;
                    var_c690971453d240f = 0;
                }
                
                if ( var_a345e8165850a107 >= 5 )
                {
                    var_a345e8165850a107 = 0;
                    var_ad8c91b69d4e6868 = 0;
                }
            }
        }
        else
        {
            var_14cc1f4d241c2506++;
            var_a345e8165850a107++;
            
            if ( var_14cc1f4d241c2506 >= 12 )
            {
                var_14cc1f4d241c2506 = 0;
                var_c690971453d240f = 0;
            }
            
            if ( var_a345e8165850a107 >= 5 )
            {
                var_a345e8165850a107 = 0;
                var_ad8c91b69d4e6868 = 0;
            }
        }
        
        var_d12f2c604eeffb33 = var_685edebde05db999[ 0 ];
        cap = int( min( 20, self.velo_array.size ) );
        
        for ( i = 0; i < cap ; i++ )
        {
            if ( !var_c690971453d240f && i + 1 >= cap )
            {
                var_c690971453d240f = 1;
                break;
            }
            
            temp_array[ temp_array.size ] = self.velo_array[ i ];
            var_685edebde05db999[ var_685edebde05db999.size ] = self.mag_array[ i ];
            var_d12f2c604eeffb33 += self.mag_array[ i ];
        }
        
        mem_size = 5;
        
        if ( isdefined( level.disable_recent_area_memory ) )
        {
            mem_size = level.disable_recent_area_memory;
        }
        
        cap = int( min( mem_size, self.velo_forward_memory.size ) );
        
        for ( i = 0; i < cap ; i++ )
        {
            if ( !var_ad8c91b69d4e6868 && i + 1 >= cap )
            {
                var_ad8c91b69d4e6868 = 1;
                break;
            }
            
            index = var_9bccabb90a92aa8c.size;
            var_9bccabb90a92aa8c[ index ] = self.velo_forward_memory[ i ];
        }
        
        self.velo_forward_memory = var_9bccabb90a92aa8c;
        self.velo_array = temp_array;
        
        if ( self.velo_array.size > 0 )
        {
            self.average_velo = calculate_average_velocity( self.velo_array );
        }
        
        self.mag_array = var_685edebde05db999;
        self.average_mag = var_d12f2c604eeffb33 / self.mag_array.size;
        self.velo_forward = self.origin + vectornormalize( self.average_velo ) * self.average_mag;
        wait 0.5;
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x5726
// Size: 0x4a
function calculate_average_velocity( array )
{
    if ( array.size == 1 )
    {
        return array[ 0 ];
    }
    
    average_velo = array[ 0 ];
    
    for ( i = 1; i < array.size ; i++ )
    {
        average_velo += array[ i ];
    }
    
    return average_velo / array.size;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x5779
// Size: 0xab
function give_playtest_munitions()
{
    self endon( "disconnect" );
    self waittill( "spawned_player" );
    scripts\engine\utility::ent_flag_wait( "intro_binks_complete" );
    wait 2;
    self.munition_splash_supress = 1;
    
    if ( allow_munitions( self ) )
    {
        if ( function_240f7f4e57340e8f() )
        {
            scripts\cp\kits::kit_givekillstreak( "ammo_crate", 1, 0, 0, 1 );
            scripts\cp\kits::kit_givekillstreak( "armor", 1, 0, 0, 1 );
            scripts\cp\kits::kit_givekillstreak( "grenade_crate", 1, 0, 0, 1 );
        }
        else
        {
            scripts\cp\munitions::give_munition_to_slot( "ammo_crate", 1 );
            scripts\cp\munitions::give_munition_to_slot( "armor", 2 );
            scripts\cp\munitions::give_munition_to_slot( "grenade_crate", 3 );
        }
    }
    
    self.munition_splash_supress = undefined;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x582c
// Size: 0x27
function allow_munitions( player )
{
    if ( isdefined( level.allow_munitions ) )
    {
        return [[ level.allow_munitions ]]( player );
    }
    
    return 1;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x585c
// Size: 0x31
function playermonitor()
{
    thread slidemonitor();
    thread forceendmonitor();
    setup_button_notifys();
    scripts\cp\munitions::function_77084f05581a035();
    thread player_broadcast();
    thread scripts\cp\loadout::change_loadout_watcher( self );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x5895
// Size: 0x56
function function_5c8bea04d4909519()
{
    last_checkpoint = namespace_1170726b2799ea65::function_50f02a42c72031cb( level.script );
    
    if ( isdefined( last_checkpoint ) && last_checkpoint != "" )
    {
        if ( !getdvarint( @"hash_f94e2fa79e0fa73c", 0 ) )
        {
            scripts\cp\cp_checkpoint::function_24490b05670afa23( last_checkpoint );
            game[ "restart_checkpoint" ] = last_checkpoint;
        }
    }
    
    scripts\cp\cp_checkpoint::function_705d572f010fb61c();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x58f3
// Size: 0xb4
function function_64908cf46d806427()
{
    if ( !isdefined( level.teamdata[ "allies" ] ) )
    {
        level.teamdata[ "allies" ] = [];
    }
    
    if ( !isdefined( level.teamdata[ "allies" ][ "players" ] ) )
    {
        level.teamdata[ "allies" ][ "players" ] = [];
    }
    
    if ( !isdefined( level.teamdata[ "axis" ][ "players" ] ) )
    {
        level.teamdata[ "axis" ][ "players" ] = [];
    }
    
    level.teamdata[ "allies" ][ "players" ][ level.teamdata[ "allies" ][ "players" ].size ] = self;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x59af
// Size: 0xc1
function function_7fdeb6dccfd886ab( player )
{
    if ( !isdefined( level.teamdata[ "allies" ] ) )
    {
        level.teamdata[ "allies" ] = [];
    }
    
    if ( !isdefined( level.teamdata[ "allies" ][ "players" ] ) )
    {
        level.teamdata[ "allies" ][ "players" ] = [];
    }
    
    if ( !isdefined( level.teamdata[ "axis" ][ "players" ] ) )
    {
        level.teamdata[ "axis" ][ "players" ] = [];
    }
    
    level.teamdata[ "allies" ][ "players" ] = array_remove( level.teamdata[ "allies" ][ "players" ], player );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x5a78
// Size: 0x58
function function_5c9544ef10cb9e0c( reason )
{
    println( "<dev string:x25>" + self.guid + "<dev string:x5a>" + self getentitynumber() + "<dev string:x5a>" + self.name + "<dev string:x5a>" + reason + "<dev string:x5c>" );
    namespace_bf9ffd2b22c7d819::function_8cf8ff669ac52156( reason, 1 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x5ad8
// Size: 0x1c
function function_2a643088582c8be3( achievementid, progressdata )
{
    namespace_bf9ffd2b22c7d819::function_a1b2dc3090437789( achievementid, progressdata );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x5afc
// Size: 0xa
function function_e14e30e8c9c40402()
{
    thread function_bfc702532eead581();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x5b0e
// Size: 0x74
function function_bfc702532eead581()
{
    self endon( "disconnect" );
    flag_wait( "level_ready_for_script" );
    
    foreach ( player in level.players )
    {
        player scripts\cp_mp\armor::function_1b593d5e688a409c();
    }
    
    level thread scripts\cp\weapon::function_f2525bf18abad733( "iw9_armor_plate_deploy_mp" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x5b8a
// Size: 0x58d
function function_41f5e1b0d3379c5c( notification, slotindex )
{
    if ( isdefined( notification ) )
    {
        switch ( notification )
        {
            case #"hash_2492121b9170f54f":
                drop_successful = 1;
                drop_type = undefined;
                count = undefined;
                
                switch ( slotindex )
                {
                    case 0:
                        current_amount = scripts\cp\persistence::get_player_currency();
                        
                        if ( thread scripts\cp\persistence::try_take_player_currency( current_amount ) )
                        {
                            drop_successful = 1;
                            count = current_amount;
                            drop_type = "brloot_plunder_cash_common_1";
                            
                            if ( current_amount >= 5000 )
                            {
                                drop_type = "brloot_plunder_cash_epic_1";
                            }
                            else if ( current_amount >= 2500 )
                            {
                                drop_type = "brloot_plunder_cash_rare_1";
                            }
                            else if ( current_amount >= 1000 )
                            {
                                drop_type = "brloot_plunder_cash_uncommon_1";
                            }
                        }
                        
                        break;
                    case 2:
                        if ( isdefined( self.armorqueued ) && self.armorqueued >= 1 )
                        {
                            drop_type = "brloot_armor_plate";
                            count = self.armorqueued;
                            drop_successful = 1;
                            function_4d61729c67e951b3();
                        }
                        
                        break;
                    case 3:
                        drop_type = "brloot_ammo_762";
                        
                        if ( function_c5251179824f0deb( drop_type ) )
                        {
                            count = function_f9c71b46b5e50150( drop_type, function_93f256198133479f( drop_type ) );
                            drop_successful = 1;
                        }
                        
                        break;
                    case 5:
                        drop_type = "brloot_ammo_919";
                        
                        if ( function_c5251179824f0deb( drop_type ) )
                        {
                            count = function_f9c71b46b5e50150( drop_type, function_93f256198133479f( drop_type ) );
                            drop_successful = 1;
                        }
                        
                        break;
                    case 4:
                        drop_type = "brloot_ammo_12g";
                        
                        if ( function_c5251179824f0deb( drop_type ) )
                        {
                            count = function_f9c71b46b5e50150( drop_type, function_93f256198133479f( drop_type ) );
                            drop_successful = 1;
                        }
                        
                        break;
                    case 7:
                        drop_type = "brloot_ammo_50cal";
                        
                        if ( function_c5251179824f0deb( drop_type ) )
                        {
                            count = function_f9c71b46b5e50150( drop_type, function_93f256198133479f( drop_type ) );
                            drop_successful = 1;
                        }
                        
                        break;
                    case 6:
                        drop_type = "brloot_ammo_rocket";
                        
                        if ( function_c5251179824f0deb( drop_type ) )
                        {
                            count = function_f9c71b46b5e50150( drop_type, function_93f256198133479f( drop_type ) );
                            drop_successful = 1;
                        }
                        
                        break;
                    case 9:
                        item = scripts\cp\cp_weapons::drop_weapon_scripted( 1, 180 );
                        
                        if ( isdefined( item ) )
                        {
                            currentprimaries = scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();
                            
                            foreach ( weapon in currentprimaries )
                            {
                                if ( weapon.basename != "none" && weapon.basename != item.objweapon.basename )
                                {
                                    scripts\cp\cp_weapons::switchtoweaponreliable( weapon );
                                    
                                    if ( currentprimaries.size == 1 && weapon.basename != "iw9_me_fists_mp" )
                                    {
                                        self giveweapon( "iw9_me_fists_mp" );
                                    }
                                    
                                    break;
                                }
                            }
                            
                            if ( currentprimaries.size == 0 )
                            {
                                self giveweapon( "iw9_me_fists_mp" );
                            }
                            
                            drop_successful = 1;
                        }
                        
                        break;
                }
                
                if ( drop_successful && isdefined( drop_type ) && isdefined( count ) )
                {
                    dropinfo = scripts\cp\pickups::getitemdroporiginandangles( 0, self.origin, self.angles, self );
                    item = scripts\cp\pickups::spawnpickup( drop_type, dropinfo, count, 1, undefined, 0 );
                }
                
                break;
            case #"hash_25c924f29082a36":
                drop_successful = 1;
                drop_type = undefined;
                count = undefined;
                
                switch ( slotindex )
                {
                    case 0:
                        var_a1708bf4c9f30fd8 = 500;
                        current_amount = scripts\cp\persistence::get_player_currency();
                        
                        if ( current_amount > 0 )
                        {
                            drop_amount = int( min( var_a1708bf4c9f30fd8, current_amount ) );
                            
                            if ( thread scripts\cp\persistence::try_take_player_currency( drop_amount ) )
                            {
                                drop_type = "brloot_plunder_cash_common_1";
                                count = drop_amount;
                                drop_successful = 1;
                            }
                        }
                        
                        break;
                    case 2:
                        drop_type = "brloot_armor_plate";
                        count = 1;
                        drop_successful = 1;
                        function_974fb5e98d373e0();
                        break;
                    case 3:
                        drop_type = "brloot_ammo_762";
                        
                        if ( function_c5251179824f0deb( drop_type ) )
                        {
                            count = function_f9c71b46b5e50150( drop_type, 30 );
                            drop_successful = 1;
                        }
                        
                        break;
                    case 5:
                        drop_type = "brloot_ammo_919";
                        
                        if ( function_c5251179824f0deb( drop_type ) )
                        {
                            count = function_f9c71b46b5e50150( drop_type, 13 );
                            drop_successful = 1;
                        }
                        
                        break;
                    case 4:
                        drop_type = "brloot_ammo_12g";
                        
                        if ( function_c5251179824f0deb( drop_type ) )
                        {
                            count = function_f9c71b46b5e50150( drop_type, 10 );
                            drop_successful = 1;
                        }
                        
                        break;
                    case 7:
                        drop_type = "brloot_ammo_50cal";
                        
                        if ( function_c5251179824f0deb( drop_type ) )
                        {
                            count = function_f9c71b46b5e50150( drop_type, 10 );
                            drop_successful = 1;
                        }
                        
                        break;
                    case 6:
                        drop_type = "brloot_ammo_rocket";
                        
                        if ( function_c5251179824f0deb( drop_type ) )
                        {
                            count = function_f9c71b46b5e50150( drop_type, 1 );
                            drop_successful = 1;
                        }
                        
                        break;
                }
                
                if ( drop_successful && isdefined( drop_type ) && isdefined( count ) )
                {
                    dropinfo = scripts\cp\pickups::getitemdroporiginandangles( 0, self.origin, self.angles, self );
                    item = scripts\cp\pickups::spawnpickup( drop_type, dropinfo, count, 1, undefined, 0 );
                }
                
                break;
            case #"hash_c03e02fd892deaa3":
                break;
            case #"hash_c4423c8df029f1ca":
                break;
            case #"hash_f9442c17e42ea782":
            default:
                break;
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x611f
// Size: 0x4b
function function_4d61729c67e951b3()
{
    if ( isdefined( self.armorqueued ) && self.armorqueued > 0 )
    {
        self.armorqueued = 0;
        self setclientomnvar( "ui_equipment_id_health", 27 );
        self setclientomnvar( "ui_equipment_id_health_numCharges", self.armorqueued );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x6172
// Size: 0x4b
function function_974fb5e98d373e0()
{
    if ( isdefined( self.armorqueued ) && self.armorqueued > 0 )
    {
        self.armorqueued--;
        self setclientomnvar( "ui_equipment_id_health", 27 );
        self setclientomnvar( "ui_equipment_id_health_numCharges", self.armorqueued );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x61c5
// Size: 0x18, Type: bool
function function_c5251179824f0deb( drop_type )
{
    return self.br_ammo[ drop_type ] > 0;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x61e6
// Size: 0x16
function function_93f256198133479f( drop_type )
{
    return self.br_ammo[ drop_type ];
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x6205
// Size: 0x76
function function_f9c71b46b5e50150( drop_type, stack_size )
{
    if ( self.br_ammo[ drop_type ] > 0 )
    {
        if ( self.br_ammo[ drop_type ] >= stack_size )
        {
            count = stack_size;
        }
        else
        {
            count = self.br_ammo[ drop_type ];
        }
        
        self.br_ammo[ drop_type ] -= count;
        scripts\cp\pickups::br_ammo_update_weapons();
        return count;
    }
    
    return undefined;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x6283
// Size: 0xa2
function function_5ce6e63df1d04eca()
{
    self.guid = getuniqueid();
    self.clientid = game[ "clientid" ];
    game[ "clientid" ]++;
    self.usingonlinedataoffline = self isusingonlinedataoffline();
    self.connected = 1;
    self.waitingtospawn = 0;
    self.movespeedscaler = 1;
    self.objectivescaler = 1;
    self.inlaststand = 0;
    self.no_team_outlines = 0;
    self.no_outline = 0;
    self.enemy_list = [];
    self.assigned_ai = 0;
    thread scripts\cp_mp\squads::setsquad( "allies" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x632d
// Size: 0x2d
function function_6c3efb0e9da75c0c()
{
    if ( !isdefined( level.var_efd26b348839344 ) )
    {
        level.var_efd26b348839344 = -1;
    }
    
    level.var_efd26b348839344++;
    return level.var_efd26b348839344;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x6363
// Size: 0x57
function function_3999591663b82c6a()
{
    initclientdvarssplitscreenspecific();
    self setclientdvars( @"cg_deadchatwithdead", 0, @"cg_deadchatwithteam", 1, @"cg_deadhearteamliving", 1, @"cg_deadhearallliving", 0 );
    
    if ( level.teambased )
    {
        self setclientdvar( @"cg_everyonehearseveryone", 0 );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x63c2
// Size: 0x55
function initclientdvarssplitscreenspecific()
{
    if ( level.splitscreen || self issplitscreenplayer() )
    {
        self setclientdvars( @"hash_682a9bc40f96ca4a", "0.75" );
        setdvar( @"hash_d18838f3e4b65d16", 0 );
        return;
    }
    
    self setclientdvars( @"hash_682a9bc40f96ca4a", "1" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x641f
// Size: 0xc2
function function_8259ed9008f45c23()
{
    self.saved_actionslotdata = [];
    
    for ( slotid = 1; slotid <= 4 ; slotid++ )
    {
        self.saved_actionslotdata[ slotid ] = spawnstruct();
        self.saved_actionslotdata[ slotid ].type = "";
        self.saved_actionslotdata[ slotid ].item = undefined;
    }
    
    if ( !self isconsoleplayer() )
    {
        for ( slotid = 5; slotid <= 8 ; slotid++ )
        {
            self.saved_actionslotdata[ slotid ] = spawnstruct();
            self.saved_actionslotdata[ slotid ].type = "";
            self.saved_actionslotdata[ slotid ].item = undefined;
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x64e9
// Size: 0x16
function function_ccc85fdb936857b3()
{
    self.perks = [];
    self.perksperkname = [];
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x6507
// Size: 0x35
function slidemonitor()
{
    self endon( "disconnect" );
    
    while ( true )
    {
        self waittill( "sprint_slide_begin" );
        self playfx( level._effect[ "slide_dust" ], self geteye() );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x6544
// Size: 0x7f
function forceendmonitor()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "luinotifyserver", channel, val );
        
        if ( channel == "arcade_off" )
        {
            self notify( "adjustedstance" );
        }
        
        if ( channel == "end_game" )
        {
            level thread [[ level.forceendgame ]]();
            self notify( "disconnect" );
        }
        
        if ( channel == "scoreboard_open" )
        {
            scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_open_tacmap", self );
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x65cb
// Size: 0xaa
function setup_button_notifys()
{
    self setactionslot( 1, "" );
    
    if ( istrue( level.disable_nvg ) )
    {
        self setactionslot( 2, "" );
    }
    
    self setactionslot( 2, "" );
    self setactionslot( 3, "" );
    self setactionslot( 4, "" );
    self notifyonplayercommand( "d_pad_up", "+actionslot 1" );
    self notifyonplayercommand( "d_pad_down", "+actionslot 2" );
    self notifyonplayercommand( "d_pad_left", "+actionslot 3" );
    self notifyonplayercommand( "d_pad_right", "+actionslot 4" );
    self notifyonplayercommand( "kbm_armor", "killstreak2" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x667d
// Size: 0x34
function inventory_watcher( channel, value )
{
    if ( channel == "backpack_toggled" )
    {
        if ( value == 0 )
        {
            scripts\cp\pickups::inventory_close();
            return;
        }
        
        scripts\cp\pickups::inventory_open();
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x66b9
// Size: 0xba
function spawnintermission( endreasontextindex )
{
    level endon( "exitLevel_called" );
    self endon( "disconnect" );
    setglobalintermissionspawninfo();
    camera_angles = self.forcespawnangles;
    self predictstreamposuntilcleared( self.forcespawnorigin );
    wait 2;
    
    while ( !self ispredictedstreamposready() )
    {
        wait 0.5;
    }
    
    spawnplayer();
    self setclientdvar( @"cg_everyonehearseveryone", 1 );
    self setdepthoffield( 0, 128, 512, 4000, 6, 1.8 );
    
    if ( self isconsoleplayer() )
    {
        self setclientdvar( @"cg_fov", "90" );
    }
    
    updatesessionstate( "intermission" );
    self clearpredictedstreampos();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x677b
// Size: 0x30
function setglobalintermissionspawninfo()
{
    var_f0e8bfbc0e6f690a = getglobalintermissionpoint();
    setforcespawninfo( var_f0e8bfbc0e6f690a.origin, var_f0e8bfbc0e6f690a.angles );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x67b3
// Size: 0x27
function setforcespawninfo( origin, angles )
{
    self.forcespawnorigin = origin;
    self.forcespawnangles = angles;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x67e2
// Size: 0x2f
function getglobalintermissionpoint()
{
    spawnpoints = getentarray( "mp_global_intermission", "classname" );
    assertex( spawnpoints.size, "no mp_global_intermission spawnpoints in map" );
    return spawnpoints[ 0 ];
}

// Namespace globallogic / scripts\cp\globallogic
// Params 3
// Checksum 0x0, Offset: 0x681a
// Size: 0x33
function spawnplayer( fauxspawn, spawn_delay, var_ef83a4d91df14784 )
{
    if ( isdefined( spawn_delay ) && spawn_delay > 0 )
    {
        wait spawn_delay;
    }
    
    thread spawnplayer_internal( fauxspawn, var_ef83a4d91df14784 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x6855
// Size: 0x54
function spawnplayer_internal( fauxspawn, var_ef83a4d91df14784 )
{
    level endon( "game_ended" );
    self notify( "spawnplayer_internal" );
    self endon( "spawnplayer_internal" );
    self endon( "disconnect" );
    self endon( "joined_spectators" );
    
    if ( self.waitingtospawn )
    {
        return;
    }
    
    waitforspawn();
    spawnplayer_actual( fauxspawn, var_ef83a4d91df14784 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x68b1
// Size: 0x28
function waitforspawn()
{
    self.waitingtospawn = 1;
    
    if ( isusingremote() )
    {
        self waittill( "stopped_using_remote" );
    }
    
    self.waitingtospawn = 0;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x68e1
// Size: 0x14
function function_d98e304dd9d5d8cd()
{
    game[ "numPlayersConsideredPlaying" ] = 0;
    game[ "matchHasMoreThan1Player" ] = 0;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x68fd
// Size: 0xa7
function function_dcad74d2a0609f85()
{
    if ( !isdefined( game[ "numPlayersConsideredPlaying" ] ) )
    {
        function_d98e304dd9d5d8cd();
    }
    
    var_2d9482a14615cc39 = game[ "matchHasMoreThan1Player" ];
    game[ "numPlayersConsideredPlaying" ]++;
    
    if ( !game[ "matchHasMoreThan1Player" ] )
    {
        if ( game[ "numPlayersConsideredPlaying" ] > 1 )
        {
            game[ "matchHasMoreThan1Player" ] = 1;
        }
    }
    
    if ( game[ "matchHasMoreThan1Player" ] )
    {
        if ( !var_2d9482a14615cc39 )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                level.players[ i ] setclientomnvar( "match_has_more_than_1_player", 1 );
            }
            
            return;
        }
        
        self setclientomnvar( "match_has_more_than_1_player", 1 );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x69ac
// Size: 0x82
function updatematchhasmorethan1playeromnvaronplayerdisconnect()
{
    var_2d9482a14615cc39 = game[ "matchHasMoreThan1Player" ];
    game[ "numPlayersConsideredPlaying" ]--;
    
    if ( game[ "matchHasMoreThan1Player" ] )
    {
        if ( game[ "numPlayersConsideredPlaying" ] <= 1 )
        {
            game[ "matchHasMoreThan1Player" ] = 0;
        }
    }
    
    if ( !game[ "matchHasMoreThan1Player" ] )
    {
        if ( var_2d9482a14615cc39 )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                level.players[ i ] setclientomnvar( "match_has_more_than_1_player", 0 );
            }
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x6a36
// Size: 0x4, Type: bool
function function_c2e445d76a446aa0()
{
    return true;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x6a43
// Size: 0x55
function function_297bf30b6352b598( player )
{
    armorvalue = undefined;
    numplates = undefined;
    
    if ( isdefined( player.var_bfebcd1c49c31e8 ) )
    {
        numplates = player.var_bfebcd1c49c31e8;
        player.var_bfebcd1c49c31e8 = undefined;
    }
    
    return [ armorvalue, numplates ];
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x6aa1
// Size: 0x31a
function spawnplayer_actual( fauxspawn, var_ef83a4d91df14784 )
{
    self notify( "spawned" );
    self notify( "started_spawnplayer" );
    function_38b1b50f4ea21c32( fauxspawn, var_ef83a4d91df14784 );
    
    if ( level.gameended )
    {
        spawn_origin = function_95b85b8e7cce3028( self, 1 );
    }
    else
    {
        spawn_origin = function_95b85b8e7cce3028( self );
    }
    
    spawn_angles = function_14850251d755f82( self );
    
    if ( istrue( fauxspawn ) )
    {
        self spawn( spawn_origin, spawn_angles );
    }
    else
    {
        self spawn( spawn_origin, spawn_angles );
    }
    
    broadcast_status( self, 0 );
    function_9f5574f906e43a39();
    function_cfcfa5e7a3e83553();
    function_8631490f6f8345ad();
    self setclientomnvar( "ui_stop_armor_hint", 0 );
    
    if ( isdefined( self.body ) )
    {
        self.body delete();
        self.body = undefined;
    }
    
    fauxspawn = ter_op( isdefined( fauxspawn ), fauxspawn, 0 );
    
    if ( !fauxspawn )
    {
        function_4cf2bfbd74938a5b();
    }
    
    if ( isai( self ) )
    {
        function_a4d80ff0b2718938( fauxspawn );
    }
    
    [[ level.onspawnplayer ]]( fauxspawn );
    
    if ( !fauxspawn )
    {
        scripts\cp\cp_visionsets::create_visionset_stack( self );
    }
    
    self [[ level.custom_giveloadout ]]( fauxspawn, undefined, self.defaultclassindex );
    
    if ( getdvarint( @"camera_thirdperson" ) )
    {
        setthirdpersondof( 1 );
    }
    
    giveperk( "specialty_pistoldeath" );
    self painvisionon();
    
    if ( istrue( level.disable_nvg ) )
    {
        self setactionslot( 2, "" );
    }
    
    self setactionslot( 3, "altmode" );
    self setclientomnvar( "ui_hide_objectives", 0 );
    waittillframeend();
    
    if ( fauxspawn )
    {
        scripts\cp_mp\utility\player_utility::function_a593971d75d82113();
        allow_player_ignore_me( 1 );
    }
    
    self notify( "spawned_player" );
    level notify( "player_spawned", self );
    self.var_eaa61b501c84602e = 1;
    thread hudbooted();
    thread allow_dvar_infammo();
    thread scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_monitorplayerusability( self );
    thread scripts\cp\perks::markedentities_think();
    telemetrydata = scripts\cp\globallogic::function_b9953eb97ad6c0d2();
    scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_on_player_spawned", telemetrydata.player );
    self.matchdatalifeindex = -1;
    
    if ( scripts\common\telemetry_utils::is_valid_client( self ) )
    {
        self.matchdatalifeindex = game[ "life_count" ];
        game[ "life_count" ]++;
    }
    
    self.no_outline = 0;
    self.no_team_outlines = 0;
    self.var_7c968c5609aded2 = 0;
    _unsetperk( "specialty_spygame" );
    _unsetperk( "specialty_coldblooded" );
    _unsetperk( "specialty_noscopeoutline" );
    _unsetperk( "specialty_heartbreaker" );
    self notify( "force_regeneration" );
    
    if ( istrue( level.var_2dce4d6dcb6c3fb9 ) )
    {
        scripts\cp\utility::restore_weapons_status( [] );
        scripts\cp\equipment::restore_equipment();
    }
    
    if ( istrue( self.bspawningviaac130 ) )
    {
        scripts\cp\laststand::give_fists_if_no_real_weapon( self );
        return;
    }
    
    if ( !istrue( fauxspawn ) && !scripts\cp\endgame::gamealreadyended() )
    {
        if ( !istrue( self.ishotjoiningplayer ) )
        {
            thread open_loadout_menu();
            waittill_any_2( "loadout_given", "start_hotjoining_via_c130" );
            function_dcad74d2a0609f85();
            
            if ( isdefined( level.post_loadout_spawn_func ) )
            {
                self thread [[ level.post_loadout_spawn_func ]]();
            }
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x6dc3
// Size: 0x9c
function function_38b1b50f4ea21c32( fauxspawn, var_ef83a4d91df14784 )
{
    checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();
    
    if ( checkpoint != "" )
    {
        spawnpoint = scripts\cp\cp_checkpoint::checkpoint_getspawnpoint( checkpoint );
        
        if ( !isdefined( spawnpoint ) )
        {
            spawnpoint = scripts\cp\cp_checkpoint::checkpoint_get_item( checkpoint, "player_spawn" );
        }
        
        if ( isdefined( spawnpoint ) )
        {
            self.forcespawnorigin = spawnpoint.origin;
            self.checkpointstruct = spawnpoint;
            spawnpoint function_9ec4754a395bcc2d();
            self.forcespawnangles = spawnpoint.angles;
            spawnpoint thread scripts\cp\cp_checkpoint::checkpoint_release_spawnpoint( self );
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x6e67
// Size: 0x10
function hudbooted()
{
    self endon( "disconnect" );
    resetplayerspawnomnvar();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x6e7f
// Size: 0x71
function resetplayerspawnomnvar()
{
    self setclientomnvar( "ui_hud_shake", 0 );
    self setclientomnvar( "cp_super_fired", 0 );
    clientnum = self getentitynumber();
    setomnvar( "cp_team_oriented_super_ended", clientnum );
    
    if ( function_c2906d44795d8f40() || function_93d685ac42f15c61() )
    {
        self setclientomnvar( "ui_hide_minimap", 0 );
    }
    else
    {
        self setclientomnvar( "ui_hide_minimap", 1 );
    }
    
    init_vehicle_omnvars();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x6ef8
// Size: 0xc, Type: bool
function function_c2906d44795d8f40()
{
    return istrue( level.minimaponbydefault );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x6f0d
// Size: 0x40
function open_loadout_menu()
{
    if ( !is_wave_gametype() && !function_a3577e8e6c88a56b() && !function_f620e996a1d7d81a() && !function_240f7f4e57340e8f() )
    {
        self waittill( "open_loadout_menu" );
        self setclientomnvar( "ui_options_menu", 2 );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x6f55
// Size: 0x45
function function_9f5574f906e43a39()
{
    self stopshellshock();
    self stoprumble( "damage_heavy" );
    self setdepthoffield( 0, 0, 512, 512, 4, 0 );
    
    if ( self isconsoleplayer() )
    {
        self setclientdvar( @"cg_fov", "65" );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x6fa2
// Size: 0xd1
function function_8631490f6f8345ad()
{
    if ( isdefined( self.additivedamagemodifiers ) )
    {
        var_93aa207eb1b3c1d2 = getarraykeys( self.additivedamagemodifiers );
        
        foreach ( key in var_93aa207eb1b3c1d2 )
        {
            removedamagemodifier( key, 1 );
        }
    }
    
    if ( isdefined( self.multiplicativedamagemodifiers ) )
    {
        var_93aa207eb1b3c1d2 = getarraykeys( self.multiplicativedamagemodifiers );
        
        foreach ( key in var_93aa207eb1b3c1d2 )
        {
            removedamagemodifier( key, 0 );
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x707b
// Size: 0x93
function function_cfcfa5e7a3e83553()
{
    team = getspawnteamassignment();
    self.team = team;
    self.sessionteam = getspawnsessionteamassignment( team );
    self.pers[ "team" ] = team;
    self.fauxdead = undefined;
    self.movespeedscaler = 1;
    val::nuke( "weapon" );
    val::nuke( "offhand_weapons" );
    self.hasriotshieldequipped = 0;
    self.hasriotshield = 0;
    self.var_198b774c93c48891 = undefined;
    self.var_9691e7d8cde294f2 = undefined;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x7116
// Size: 0x21
function getspawnteamassignment()
{
    if ( isdefined( level.playerspawnteamassignmentfunc ) )
    {
        return [[ level.playerspawnteamassignmentfunc ]]( self );
    }
    
    return "allies";
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x7140
// Size: 0x27
function getspawnsessionteamassignment( team )
{
    if ( isdefined( level.playerspawnsessionteamassignmentfunc ) )
    {
        return [[ level.playerspawnsessionteamassignmentfunc ]]( self, team );
    }
    
    return team;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x7170
// Size: 0x15
function function_4cf2bfbd74938a5b()
{
    resetnonfauxspawnscriptfields();
    updatesessionstate( "playing" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x718d
// Size: 0x65
function resetnonfauxspawnscriptfields()
{
    self.maxhealth = self [[ level.playermaxhealth ]]();
    self.health = self.maxhealth;
    self.avoidkillstreakonspawntimer = 5;
    self.friendlydamage = undefined;
    self.hasspawned = 1;
    self.spawntime = gettime();
    self.objectivescaler = 1;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x71fa
// Size: 0x43
function function_a4d80ff0b2718938( fauxspawn )
{
    if ( !fauxspawn )
    {
        if ( isdefined( level.bot_funcs ) && isdefined( level.bot_funcs[ "player_spawned" ] ) )
        {
            self [[ level.bot_funcs[ "player_spawned" ] ]]();
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x7245
// Size: 0x142
function function_95b85b8e7cce3028( player, var_a889d598403b4de6 )
{
    spawnorigin = undefined;
    var_9fba0d30d2b918db = istrue( level.skip_nav_check_on_spectate_respawn );
    
    if ( istrue( self.var_d88f609db87e5503 ) )
    {
        var_9fba0d30d2b918db = 1;
        self.var_d88f609db87e5503 = undefined;
    }
    
    if ( isdefined( player.forcespawnorigin ) )
    {
        spawnorigin = player.forcespawnorigin;
        
        if ( !var_9fba0d30d2b918db )
        {
            spawnorigin = getclosestpointonnavmesh( spawnorigin );
        }
        
        if ( isdefined( var_a889d598403b4de6 ) )
        {
            spawnorigin = player.forcespawnorigin;
        }
        
        player.forcespawnorigin = undefined;
    }
    else
    {
        spawnpoint = player [[ level.getspawnpoint ]]();
        assert( isdefined( spawnpoint.origin ) );
        spawnorigin = ter_op( istrue( level.disable_start_spawn_on_navmesh ), drop_to_ground( spawnpoint.origin, 32, -100 ), getclosestpointonnavmesh( spawnpoint.origin ) );
        
        if ( getdvarint( @"hash_b80f97b9c08f17f5", 0 ) )
        {
            spawnorigin = ter_op( istrue( level.disable_start_spawn_on_navmesh ), spawnpoint.origin, getclosestpointonnavmesh( spawnpoint.origin ) );
        }
        
        if ( isdefined( var_a889d598403b4de6 ) )
        {
            spawnorigin = spawnpoint;
        }
    }
    
    return spawnorigin;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x7390
// Size: 0x85
function function_14850251d755f82( player )
{
    spawnangles = undefined;
    
    if ( isdefined( player.forcespawnangles ) )
    {
        spawnangles = player.forcespawnangles;
        player.forcespawnangles = undefined;
    }
    else
    {
        spawnpoint = player [[ level.getspawnpoint ]]();
        spawnangles = ter_op( isdefined( spawnpoint.angles ), spawnpoint.angles, ( 0, 0, 0 ) );
    }
    
    return spawnangles;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x741e
// Size: 0x68
function function_382ab3472a4da4e6()
{
    var_f0e8bfbc0e6f690a = getglobalintermissionpoint();
    self setspectatedefaults( var_f0e8bfbc0e6f690a.origin, var_f0e8bfbc0e6f690a.angles );
    setforcespawninfo( var_f0e8bfbc0e6f690a.origin, var_f0e8bfbc0e6f690a.angles );
    setspectaterules();
    updatesessionstate( "spectator" );
    thread function_3141ea1d420f1715();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x748e
// Size: 0x95
function function_3141ea1d420f1715()
{
    self endon( "disconnect" );
    self endon( "last_stand_finished" );
    self endon( "laststand_revived" );
    self endon( "spawned" );
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "player_disconnect" );
        
        if ( level.players.size == 1 )
        {
            level thread [[ level.endgame ]]( "axis", level.end_game_string_index[ "kia" ] );
            continue;
        }
        
        if ( scripts\cp\laststand::everyone_else_all_in_laststand() )
        {
            level thread [[ level.endgame ]]( "axis", level.end_game_string_index[ "kia" ] );
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x752b
// Size: 0x27
function setspectaterules()
{
    if ( isdefined( level.spectaterulesfunc ) )
    {
        [[ level.spectaterulesfunc ]]( self );
        return;
    }
    
    defaultspectaterules( self );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x755a
// Size: 0x42
function defaultspectaterules( player )
{
    player allowspectateteam( "allies", 1 );
    player allowspectateteam( "axis", 1 );
    player allowspectateteam( "freelook", 0 );
    player allowspectateteam( "none", 1 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x75a4
// Size: 0x110
function defaultplayerdisconnect( reason )
{
    if ( !isdefined( self.connected ) )
    {
        return;
    }
    
    scripts\cp\cp_analytics::on_player_disconnect( reason );
    telemetrydata = spawnstruct();
    telemetrydata.player = self;
    telemetrydata.disconnectreason = reason;
    scripts\common\telemetry_utils::function_80820d6d364c1836( "callback_on_player_disconnect", telemetrydata );
    
    if ( isdefined( self.team ) )
    {
        scripts\cp_mp\squads::leavesquad( self.team, self.sessionsquadid );
    }
    
    removeplayerfromlevelarrays( self );
    
    if ( disconnectshouldforceend() )
    {
        reset_map_dvars();
        
        if ( level.players.size == 0 )
        {
            level thread scripts\cp\endgame::endgame( "axis", scripts\cp\endgame::get_end_game_string_index( "host_end" ) );
        }
        else
        {
            level thread scripts\cp\endgame::endgame( "axis", scripts\cp\endgame::get_end_game_string_index( "kia" ) );
        }
    }
    
    if ( isdefined( level.onplayerdisconnect ) )
    {
        level thread [[ level.onplayerdisconnect ]]( self, reason );
    }
    
    level thread scripts\cp\utility\disconnect_event_aggregator::rundisconnectcallbacks( self );
    updatematchhasmorethan1playeromnvaronplayerdisconnect();
    level notify( "player_disconnect" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x76bc
// Size: 0x84
function disconnectshouldforceend()
{
    if ( level.splitscreen )
    {
        return ( level.players.size <= 1 );
    }
    
    if ( level.players.size < 1 )
    {
        return 1;
    }
    
    gameshouldend = 0;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( scripts\cp\laststand::player_in_laststand( level.players[ i ] ) )
        {
            gameshouldend = scripts\cp\laststand::function_5de995015a65e87d( level.players[ i ] );
        }
    }
    
    return gameshouldend;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x7749
// Size: 0x4d
function addplayertolevelarrays( player )
{
    level.players[ level.players.size ] = player;
    level.participants[ level.participants.size ] = player;
    level.characters[ level.characters.size ] = player;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x779e
// Size: 0x56
function removeplayerfromlevelarrays( player )
{
    level.players = array_remove( level.players, player );
    level.participants = array_remove( level.participants, player );
    level.characters = array_remove( level.characters, player );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x77fc
// Size: 0xa4
function defaultplayermigrated()
{
    if ( self ishost() )
    {
        initclientdvarssplitscreenspecific();
    }
    
    if ( ishumanplayer( self ) )
    {
        humanplayercount = 0;
        
        foreach ( player in level.players )
        {
            if ( ishumanplayer( player ) )
            {
                humanplayercount++;
            }
        }
        
        level.hostmigrationreturnedplayercount++;
        
        if ( level.hostmigrationreturnedplayercount >= humanplayercount * 2 / 3 )
        {
            level notify( "hostmigration_enoughplayers" );
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x78a8
// Size: 0x1c, Type: bool
function ishumanplayer( player )
{
    return !isbot( player ) && !istestclient( player );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x78cd
// Size: 0x162
function defaulthostmigration()
{
    if ( level.gameended )
    {
        return;
    }
    
    level.hostmigrationreturnedplayercount = 0;
    
    foreach ( character in level.characters )
    {
        character.hostmigrationcontrolsfrozen = 0;
    }
    
    level.hostmigrationtimer = 1;
    setdvar( @"hash_a8ee1540ced18a88", 1 );
    level notify( "host_migration_begin" );
    
    foreach ( character in level.characters )
    {
        if ( isdefined( character ) )
        {
            character thread scripts\cp\cp_hostmigration::hostmigrationtimerthink();
        }
        
        if ( isplayer( character ) )
        {
            character setclientomnvar( "ui_session_state", character.sessionstate );
        }
    }
    
    setdvar( @"hash_10e5d3d90a010e19", game[ "state" ] );
    level endon( "host_migration_begin" );
    scripts\cp\cp_hostmigration::hostmigrationwait();
    level.hostmigrationtimer = undefined;
    setdvar( @"hash_a8ee1540ced18a88", 0 );
    
    if ( isdefined( level.hostmigrationend ) )
    {
        level thread [[ level.hostmigrationend ]]();
    }
    
    level notify( "host_migration_end" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x7a37
// Size: 0x73
function init_destructables()
{
    ents = getentarray( "destructable", "targetname" );
    
    if ( getdvar( @"scr_destructables" ) == "0" )
    {
        for ( i = 0; i < ents.size ; i++ )
        {
            ents[ i ] delete();
        }
        
        return;
    }
    
    for ( i = 0; i < ents.size ; i++ )
    {
        ents[ i ] thread destructable_think();
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x7ab2
// Size: 0xc4
function destructable_think()
{
    accumulate = 40;
    threshold = 0;
    
    if ( isdefined( self.script_accumulate ) )
    {
        accumulate = self.script_accumulate;
    }
    
    if ( isdefined( self.script_threshold ) )
    {
        threshold = self.script_threshold;
    }
    
    if ( isdefined( self.script_fxid ) )
    {
        self.fx = loadfx( self.script_fxid );
    }
    
    dmg = 0;
    self setcandamage( 1 );
    
    while ( true )
    {
        self waittill( "damage", amount, other );
        
        if ( amount >= threshold )
        {
            dmg += amount;
            
            if ( dmg >= accumulate )
            {
                thread destructable_destruct();
                return;
            }
        }
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x7b7e
// Size: 0x4e
function destructable_destruct()
{
    ent = self;
    
    if ( isdefined( ent.fx ) )
    {
        playfx( ent.fx, ent.origin + ( 0, 0, 6 ) );
    }
    
    ent delete();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x7bd4
// Size: 0x1ee
function init_hud()
{
    level.uiparent = spawnstruct();
    level.uiparent.horzalign = "left";
    level.uiparent.vertalign = "top";
    level.uiparent.alignx = "left";
    level.uiparent.aligny = "top";
    level.uiparent.x = 0;
    level.uiparent.y = 0;
    level.uiparent.width = 0;
    level.uiparent.height = 0;
    level.uiparent.children = [];
    level.fontheight = 12;
    level.hud[ "allies" ] = spawnstruct();
    level.hud[ "axis" ] = spawnstruct();
    level.primaryprogressbary = -61;
    level.primaryprogressbarx = 0;
    level.primaryprogressbarheight = 9;
    level.primaryprogressbarwidth = 120;
    level.primaryprogressbartexty = -75;
    level.primaryprogressbartextx = 0;
    level.primaryprogressbarfontsize = 1.2;
    level.teamprogressbary = 32;
    level.teamprogressbarheight = 14;
    level.teamprogressbarwidth = 192;
    level.teamprogressbartexty = 8;
    level.teamprogressbarfontsize = 1.65;
    level.lowertextyalign = "bottom";
    level.lowertexty = -140;
    level.lowertextfontsize = 1.2;
    level.minimaponbydefault = getdvarint( @"scr_game_enableminimap" ) != 0 || getdvarint( @"hash_bc802deb1ff2a842" ) != 0;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x7dca
// Size: 0x9e
function exploder_load( trigger )
{
    level endon( "killexplodertridgers" + trigger.script_exploder );
    trigger waittill( "trigger" );
    
    if ( isdefined( trigger.script_chance ) && randomfloat( 1 ) > trigger.script_chance )
    {
        if ( isdefined( trigger.script_delay ) )
        {
            wait trigger.script_delay;
        }
        else
        {
            wait 4;
        }
        
        level thread exploder_load( trigger );
        return;
    }
    
    exploder( trigger.script_exploder );
    level notify( "killexplodertridgers" + trigger.script_exploder );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x7e70
// Size: 0xd
function player_init_health_regen()
{
    self.regenduration = 1;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x7e85
// Size: 0xd
function player_init_invulnerability()
{
    self.haveinvulnerabilityavailable = 1;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x7e9a
// Size: 0x10
function player_init_damageshield()
{
    self.damageshieldexpiretime = gettime();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 10
// Checksum 0x0, Offset: 0x7eb2
// Size: 0x53
function blank( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 )
{
    
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x7f0d
// Size: 0x25
function init_laststand()
{
    if ( isdefined( level.player_init_laststand_func ) )
    {
        [[ level.player_init_laststand_func ]]();
        return;
    }
    
    scripts\cp\laststand::default_player_init_laststand();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x7f3a
// Size: 0x1b
function function_7e9d9ac29d0ac7a3()
{
    level.killtriggerspawnlocs = getstructarray( "respawn_edge", "targetname" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x7f5d
// Size: 0x40
function getkilltriggerspawnloc()
{
    assertex( level.killtriggerspawnlocs.size > 0, "need to put script struct around kill triggers with kvp: 'targetname', '" + "respawn_edge" + "'" );
    return getclosest( self.origin, level.killtriggerspawnlocs );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x7fa6
// Size: 0x3f
function player_broadcast()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    wait 1;
    broadcast_status( self, 0 );
    
    while ( true )
    {
        broadcast_currency( self );
        broadcast_carry_items( self );
        broadcast_kit( self );
        wait 5;
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x7fed
// Size: 0x4f
function broadcast_currency( player )
{
    entity_num = player getentitynumber();
    currency = player getplayerdata( "cp", "alienSession", "currency" );
    scripts\cp\persistence::setcoopplayerdata_for_everyone( "EoGPlayer", entity_num, "currency", currency );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x8044
// Size: 0x66
function broadcast_kit( player )
{
    entity_num = player getentitynumber();
    kit = player scripts\cp\kits::function_cc1ccc9e93b22c24();
    kittier = player scripts\cp\kits::kit_getrank();
    scripts\cp\persistence::setcoopplayerdata_for_everyone( "EoGPlayer", entity_num, "playerRole", kit );
    scripts\cp\persistence::setcoopplayerdata_for_everyone( "EoGPlayer", entity_num, "playerKitTier", kittier );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x80b2
// Size: 0xc7
function broadcast_carry_items( player )
{
    entity_num = player getentitynumber();
    
    if ( !isdefined( player.carryitemomnvar ) )
    {
        player.carryitemomnvar = 0;
    }
    
    if ( !isdefined( player.carryitem2omnvar ) )
    {
        player.carryitem2omnvar = 0;
    }
    
    if ( !isdefined( player.var_70e7c265a77e6dbf ) )
    {
        player.var_70e7c265a77e6dbf = 0;
    }
    
    scripts\cp\persistence::setcoopplayerdata_for_everyone( "EoGPlayer", entity_num, "carryItem2", player.carryitem2omnvar );
    scripts\cp\persistence::setcoopplayerdata_for_everyone( "EoGPlayer", entity_num, "carryItem", player.carryitemomnvar );
    scripts\cp\persistence::setcoopplayerdata_for_everyone( "EoGPlayer", entity_num, "carryItem3", player.var_70e7c265a77e6dbf );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x8181
// Size: 0x37
function broadcast_status( player, status )
{
    entity_num = player getentitynumber();
    scripts\cp\persistence::setcoopplayerdata_for_everyone( "EoGPlayer", entity_num, "playerStatus", status );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x81c0
// Size: 0x171
function watch_target_health()
{
    self endon( "death" );
    self endon( "disconnect" );
    self.targethealthinfo = [];
    
    while ( true )
    {
        var_ee6f2d844d4428e4 = getdvarint( @"hash_498c16fcd4cdad6a", 0 );
        
        if ( var_ee6f2d844d4428e4 == 1 )
        {
            if ( self adsbuttonpressed() )
            {
                tracestart = self geteye();
                playerangles = self getplayerangles();
                playerlookdir = anglestoforward( playerangles );
                traceend = tracestart + playerlookdir * 10000;
                results = scripts\engine\trace::_bullet_trace( tracestart, traceend, 1, self, 0, 0, 0, 0, 0 );
                hitentity = results[ "entity" ];
                
                if ( isdefined( hitentity ) && issentient( hitentity ) && !isplayer( hitentity ) )
                {
                    if ( isdefined( hitentity.team ) && hitentity.team == self.team )
                    {
                        wait 0.1;
                        continue;
                    }
                    
                    update_target_health_variable( "ui_target_health", hitentity.health );
                    update_target_health_variable( "ui_target_max_health", hitentity.maxhealth );
                    update_target_health_variable( "ui_target_entity_num", hitentity getentitynumber() );
                }
                else
                {
                    update_target_health_variable( "ui_target_entity_num", -1 );
                }
            }
            else
            {
                update_target_health_variable( "ui_target_entity_num", -1 );
            }
        }
        
        wait 0.1;
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x8339
// Size: 0x56
function update_target_health_variable( omnvarname, value )
{
    wait 0.05;
    
    if ( !isdefined( value ) )
    {
        return;
    }
    
    if ( !isdefined( self.targethealthinfo[ omnvarname ] ) || value != self.targethealthinfo[ omnvarname ] )
    {
        self setclientomnvar( omnvarname, value );
        self.targethealthinfo[ omnvarname ] = value;
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8397
// Size: 0x4d
function allow_dvar_infammo()
{
    wait 5;
    
    if ( getdvarint( @"hash_f994e29f457acc28", 0 ) == 0 )
    {
        return;
    }
    
    tries = 0;
    
    while ( tries < 30 )
    {
        tries++;
        
        if ( !isdefined( level.infil_in_progress_buffer ) )
        {
            break;
        }
        
        wait 2;
    }
    
    scripts\cp\super::team_unlimited_ammo();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x83ec
// Size: 0xce
function monitor_num_players()
{
    flag_init( "player_count_determined" );
    initial_players = getdvar( @"hash_6317f96738d7a501" );
    
    if ( initial_players != "1" )
    {
        level.only_one_player = 0;
        println( "<dev string:x5e>" );
        flag_set( "player_count_determined" );
        return;
    }
    
    level.only_one_player = 1;
    flag_set( "player_count_determined" );
    
    while ( !isdefined( level.players ) )
    {
        wait 0.1;
    }
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_fd79ccd2feba375f", 0 ) == 1 )
            {
                break;
            }
        #/
        
        if ( level.players.size > 1 )
        {
            break;
        }
        
        wait 1;
    }
    
    level.only_one_player = 0;
    level notify( "multiple_players" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x84c2
// Size: 0x18
function shellshock_init()
{
    scripts\engine\utility::registersharedfunc( "shellshock", "gasInterruptDelayFunc", &gas_getblurinterruptdelayms );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x84e2
// Size: 0x10
function gas_getblurinterruptdelayms( duration )
{
    return 200;
}

/#

    // Namespace globallogic / scripts\cp\globallogic
    // Params 0
    // Checksum 0x0, Offset: 0x84fb
    // Size: 0x5b, Type: dev
    function function_c77248252473a2b8()
    {
        println( "<dev string:x90>" );
        println( "<dev string:xb8>" );
        println( "<dev string:xe0>" );
        println( "<dev string:x108>" + level.script );
        println( "<dev string:x119>" + level.gametype );
        println( "<dev string:x90>" );
    }

    // Namespace globallogic / scripts\cp\globallogic
    // Params 0
    // Checksum 0x0, Offset: 0x855e
    // Size: 0x45, Type: dev
    function function_8a1222e55fe609a6()
    {
        if ( level.createfx_enabled )
        {
            setmapcenterfordev();
            scripts\cp\coop_createfx::createfx();
        }
        
        if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "<dev string:x12a>" )
        {
            setmapcenterfordev();
            level waittill( "<dev string:x12c>" );
        }
    }

    // Namespace globallogic / scripts\cp\globallogic
    // Params 0
    // Checksum 0x0, Offset: 0x85ab
    // Size: 0x24, Type: dev
    function function_294ee37e0dec5270()
    {
        if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "<dev string:x12a>" )
        {
            level waittill( "<dev string:x12c>" );
        }
    }

    // Namespace globallogic / scripts\cp\globallogic
    // Params 0
    // Checksum 0x0, Offset: 0x85d7
    // Size: 0x2a, Type: dev
    function setmapcenterfordev()
    {
        level.mapcenter = ( 0, 0, 0 );
        setmapcenter( level.mapcenter );
    }

    // Namespace globallogic / scripts\cp\globallogic
    // Params 0
    // Checksum 0x0, Offset: 0x8609
    // Size: 0x3f, Type: dev
    function function_872f994e74eaf646()
    {
        level.var_b92fcc7a003d6ea = -1;
        level thread debug_activation( @"hash_90e1341238d237ef", &function_6bd125a80b48cd00 );
        cmd = "<dev string:x135>";
        addentrytodevgui( cmd );
    }

    // Namespace globallogic / scripts\cp\globallogic
    // Params 1
    // Checksum 0x0, Offset: 0x8650
    // Size: 0xae, Type: dev
    function function_6bd125a80b48cd00( dvar_value )
    {
        if ( level.var_b92fcc7a003d6ea == -1 )
        {
            level.var_b92fcc7a003d6ea = 0;
            iprintlnbold( "<dev string:x197>" );
        }
        else if ( level.var_b92fcc7a003d6ea == 0 )
        {
            level.var_b92fcc7a003d6ea = 1;
            iprintlnbold( "<dev string:x1be>" );
        }
        else
        {
            level.var_b92fcc7a003d6ea = -1;
            iprintlnbold( "<dev string:x1e1>" );
        }
        
        for ( i = 0; i < level.players.size ; i++ )
        {
            level.players[ i ] function_1c677521ca122dbf( level.var_b92fcc7a003d6ea );
        }
    }

#/

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x8706
// Size: 0x18
function function_1c677521ca122dbf( value )
{
    self setclientomnvar( "ui_parachute_acquired", value );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8726
// Size: 0x38
function delete_on_load()
{
    array_delete( getentarray( "delete_on_load", "targetname" ) );
    delaythread( 0.05, &array_delete, getentarray( "delete_on_firstframeend", "targetname" ) );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8766
// Size: 0x36
function reset_map_dvars()
{
    scripts\cp\cp_checkpoint::checkpoint_set( "" );
    setdvar( @"intro_vo", "" );
    setdvar( @"hash_f2a4b47c16a549b3", "" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x87a4
// Size: 0x2
function adjust_heartbeat_sensor_settings()
{
    
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x87ae
// Size: 0x58
function function_23eb2e4122646287()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_742caa13b3c2e685", 0 ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_7c87cbda06b9834a" ) || getdvarint( @"hash_3b3635b854bc49ac" ) )
    {
        return;
    }
    
    flag_set( "debug_attempts_initialized" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x880e
// Size: 0x86
function function_3543eaafa6b72b85()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_742caa13b3c2e685", 0 ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_7c87cbda06b9834a" ) || getdvarint( @"hash_3b3635b854bc49ac" ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_84e3a11b470d0db0 ) )
    {
        level.var_84e3a11b470d0db0 = function_6d0dc66da1dbe933( 308, 10 );
    }
    
    function_e41a5e1dee804551( level.var_84e3a11b470d0db0, level.current_attempts );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 5
// Checksum 0x0, Offset: 0x889c
// Size: 0x111
function function_6d0dc66da1dbe933( x, y, scale, alpha, sort )
{
    if ( !isdefined( alpha ) )
    {
        alpha = 1;
    }
    
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    if ( !isdefined( sort ) )
    {
        sort = 20;
    }
    
    hud = newhudelem();
    hud.location = 0;
    hud.alignx = "left";
    hud.aligny = "bottom";
    hud.vertalign = "fullscreen";
    hud.horzalign = "fullscreen";
    hud.foreground = 1;
    hud.fontscale = scale;
    hud.sort = sort;
    hud.alpha = alpha;
    hud.x = x;
    hud.y = y;
    hud.og_scale = scale;
    hud.archived = 0;
    return hud;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x89b6
// Size: 0x4c
function function_e41a5e1dee804551( hud, text )
{
    if ( isdefined( text ) )
    {
        hud.text = text;
        
        if ( isnumber( text ) )
        {
            hud setvalue( text );
        }
        else
        {
            /#
                hud setdevtext( text );
            #/
            
            hud clearalltextafterhudelem();
        }
    }
    
    return hud;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8a0b
// Size: 0xa0
function function_1312ace74efdf578()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_742caa13b3c2e685", 0 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_21db8f81ccbcc579 ) )
    {
        level.var_21db8f81ccbcc579 = function_6d0dc66da1dbe933( 328, 10 );
    }
    
    for ( count = 0; true ; count++ )
    {
        if ( getdvarint( @"hash_72b7197cc79c01db" ) || getdvarint( @"hash_3b3635b854bc49ac" ) )
        {
            wait 60;
            count++;
            continue;
        }
        
        function_e41a5e1dee804551( level.var_21db8f81ccbcc579, count );
        wait 60;
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8ab3
// Size: 0xb
function function_cc928c881b761377()
{
    return level.var_2cb04ca6155de37f;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x8ac7
// Size: 0x83
function function_51623708072c759d( var_e1cab194b557363d )
{
    missionname = scripts\cp\challenges_cp::function_862a7d40f77a77d6( level.script );
    missionid = function_7042dad035dc176c( missionname );
    
    if ( missionid >= 211 && missionid <= 215 )
    {
        var_36b7946483e1de83 = 211 - missionid;
        var_f029f8962c196100 = 1 << var_36b7946483e1de83;
        return ( var_e1cab194b557363d & var_f029f8962c196100 );
    }
    
    println( "<dev string:x1fb>" + missionid + "<dev string:x207>" );
    return 0;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8b52
// Size: 0x151
function function_afb6191a17745644()
{
    self endon( "disconnect" );
    achievementid = 10277;
    self waittillmatch( "challengeProgress", achievementid );
    progress = scripts\cp_mp\playerachievements::function_ec4c795c2898be52( self, achievementid, "progress", 0 );
    subprogress = scripts\cp_mp\playerachievements::function_ec4c795c2898be52( self, achievementid, "sub_progress", 0 );
    self.var_15076ebe90844cff = subprogress > getsystemtime();
    println( "<dev string:x21e>" + self.name + "<dev string:x235>" + achievementid + "<dev string:x23f>" + progress + "<dev string:x252>" + subprogress + "<dev string:x25f>" + self.var_15076ebe90844cff );
    
    if ( !level.var_1154d5fccce1dce3 && scripts\cp\cp_gameskill::function_f8448fd91abb54c8() )
    {
        println( "<dev string:x26b>" );
        achievementid = 10443;
        scripts\cp_mp\playerachievements::getstate( self, achievementid );
        self waittillmatch( "challengeProgress", achievementid );
        progress = scripts\cp_mp\playerachievements::function_ec4c795c2898be52( self, achievementid, "progress", 0 );
        self.var_66cda89d1b89a4b = function_51623708072c759d( progress );
        println( "<dev string:x285>" + self.name + "<dev string:x235>" + achievementid + "<dev string:x23f>" + progress + "<dev string:x29f>" + self.var_66cda89d1b89a4b );
    }
    
    if ( self.var_66cda89d1b89a4b )
    {
        level.var_1154d5fccce1dce3 = 1;
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8cab
// Size: 0x2c
function function_174cbb4c8632933f()
{
    if ( function_138028ca2b958511() )
    {
        return;
    }
    
    self.skipuavupdate = 1;
    self setclientomnvar( "ui_radar_blocked", 0 );
    thread function_299051ca66e5f48c();
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8cdf
// Size: 0x4a
function function_299051ca66e5f48c()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        level waittill( "uav_started" );
        self.skipuavupdate = 0;
        self waittill( "uav_finished" );
        self.skipuavupdate = 1;
        self setclientomnvar( "ui_radar_blocked", 0 );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8d31
// Size: 0x82
function function_862c0d6f4c473c6()
{
    if ( !scripts\cp\utility::is_raid_gamemode() || level.var_1154d5fccce1dce3 )
    {
        return;
    }
    
    var_1c2aec52a6cbb0dd = getdvarint( @"hash_c3bc31466df7f74f", 0 );
    
    if ( !var_1c2aec52a6cbb0dd )
    {
        println( "<dev string:x2b1>" );
        return;
    }
    
    println( "<dev string:x30c>" );
    self.var_15076ebe90844cff = 0;
    self.var_66cda89d1b89a4b = !scripts\cp\cp_gameskill::function_f8448fd91abb54c8();
    thread function_afb6191a17745644();
    scripts\cp_mp\playerachievements::getstate( self, 10277 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8dbb
// Size: 0x94
function function_5ce526b1df5f03c8()
{
    if ( !scripts\cp\utility::is_raid_gamemode() )
    {
        return;
    }
    
    var_1c2aec52a6cbb0dd = getdvarint( @"hash_c3bc31466df7f74f", 0 );
    
    if ( !var_1c2aec52a6cbb0dd )
    {
        level.var_1154d5fccce1dce3 = 1;
        println( "<dev string:x2b1>" );
        return;
    }
    
    level endon( "game_ended" );
    level.var_1154d5fccce1dce3 = 0;
    timetowait = getdvarint( @"hash_dea3dfc89131d9cc", 300 );
    wait timetowait;
    
    if ( !istrue( level.var_1154d5fccce1dce3 ) )
    {
        println( "<dev string:x32c>" );
        shutdownserverforinvalidraidstate();
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8e57
// Size: 0x2
function function_f1b6f6cfed27eb0()
{
    
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8e61
// Size: 0xbb
function function_b1b93d51d4e1fde8()
{
    self endon( "disconnect" );
    
    if ( soundsubmixexists( scripts\cp_mp\utility\game_utility::getmapname() + "_igc_infil" ) )
    {
        flag_wait_either( "dungeon_load_finished", "intro_anim_started" );
        self setsoundsubmix( scripts\cp_mp\utility\game_utility::getmapname() + "_igc_infil" );
        flag_wait( "flag_dungeon_intro_complete" );
        self clearsoundsubmix( scripts\cp_mp\utility\game_utility::getmapname() + "_igc_infil", 1 );
    }
    
    if ( soundsubmixexists( scripts\cp_mp\utility\game_utility::getmapname() + "_igc_exfil" ) )
    {
        flag_wait_either( "flag_dungeon_outro_start", "outro_bink_started" );
        self setsoundsubmix( scripts\cp_mp\utility\game_utility::getmapname() + "_igc_exfil" );
        flag_wait( "flag_dungeon_outro_complete" );
        self clearsoundsubmix( scripts\cp_mp\utility\game_utility::getmapname() + "_igc_exfil", 1 );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8f24
// Size: 0x50
function function_b94781adf9f9ff2d()
{
    self endon( "disconnect" );
    scripts\engine\utility::ent_flag_wait( "userskipped" );
    clearmusicstate();
    self waittill( "stop_userskip_input_thread" );
    self setsoundsubmix( "jup_global_igc_skip", 1 );
    function_adfd4002c83fe6b2( "voiceover", 0, 2 );
    wait 60;
    self clearsoundsubmix( "jup_global_igc_skip", 1 );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x8f7c
// Size: 0x132
function userskip_wait()
{
    self endon( "disconnect" );
    skipflag = "userskipped";
    stopflag = "stop_userskip";
    flags = [ skipflag, stopflag ];
    
    foreach ( flag in flags )
    {
        ent_flag_clear( flag );
    }
    
    self setclientomnvar( "ui_is_bink_skippable", 1 );
    thread function_b94781adf9f9ff2d();
    
    while ( !ent_flag( stopflag ) && !ent_flag( skipflag ) )
    {
        waitframe();
    }
    
    self setclientomnvar( "ui_is_bink_skippable", 0 );
    self notify( "stop_userskip_input_thread" );
    
    if ( soundsubmixexists( scripts\cp_mp\utility\game_utility::getmapname() + "_igc_infil" ) )
    {
        level.player clearsoundsubmix( scripts\cp_mp\utility\game_utility::getmapname() + "_igc_infil" );
    }
    
    if ( soundsubmixexists( scripts\cp_mp\utility\game_utility::getmapname() + "_igc_exfil" ) )
    {
        level.player clearsoundsubmix( scripts\cp_mp\utility\game_utility::getmapname() + "_igc_exfil" );
    }
    
    return ent_flag( skipflag );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x90b7
// Size: 0xe
function userskip_stop()
{
    ent_flag_set( "stop_userskip" );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x90cd
// Size: 0x19
function vote_player_init()
{
    if ( !isdefined( self.votes ) )
    {
        self.votes = [];
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x90ee
// Size: 0x1d
function vote_player_reset( type )
{
    vote_player_init();
    self.votes[ type ] = undefined;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x9113
// Size: 0x30
function vote_player_set( type, val )
{
    if ( isdefined( self.votes[ type ] ) )
    {
        return;
    }
    
    self.votes[ type ] = val;
}

// Namespace globallogic / scripts\cp\globallogic
// Params 0
// Checksum 0x0, Offset: 0x914b
// Size: 0xc
function votesys_init()
{
    level.voting = [];
}

// Namespace globallogic / scripts\cp\globallogic
// Params 3
// Checksum 0x0, Offset: 0x915f
// Size: 0x97
function votesys_new( type, duration, var_756e935dddef03cf )
{
    if ( isdefined( level.voting[ type ] ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player vote_player_reset( type );
    }
    
    level.voting[ type ] = 1;
    level thread votesys_think( type, duration, var_756e935dddef03cf );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 3
// Checksum 0x0, Offset: 0x91fe
// Size: 0x311
function votesys_think( type, duration, var_756e935dddef03cf )
{
    success = 0;
    endtime = gettime() + duration * 1000;
    var_b42a658af40e53be = -1;
    prevtime = -1;
    playercount = -1;
    waitframe();
    
    while ( gettime() < endtime )
    {
        if ( level.gameended )
        {
            success = 0;
            break;
        }
        
        currtime = int( ( endtime - gettime() ) * 0.001 );
        
        if ( currtime != prevtime )
        {
            prevtime = currtime;
            votesys_update_time( currtime );
        }
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.votes ) )
            {
                player vote_player_reset( type );
            }
        }
        
        count = 0;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player.votes ) )
            {
                player vote_player_reset( type );
            }
            
            if ( istrue( player.votes[ type ] ) )
            {
                count++;
            }
        }
        
        if ( count != var_b42a658af40e53be || playercount != level.players.size + 1 )
        {
            var_b42a658af40e53be = count;
            playercount = level.players.size;
            votesys_update_playercount( count, playercount );
        }
        
        if ( count == level.players.size || level.var_f897d54e1c59990c.size == 0 )
        {
            success = 1;
            break;
        }
        
        waitframe();
    }
    
    if ( level.gameended )
    {
        success = 0;
    }
    
    level.voting[ type ] = undefined;
    votesys_update_time( 0 );
    votesys_update_playercount( 0, 0 );
    
    foreach ( player in level.players )
    {
        player vote_player_reset( type );
    }
    
    if ( success )
    {
        foreach ( player in level.players )
        {
            player ent_flag_set( "voted_skip_bink" );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player ent_flag_set( "bink_skip_failed" );
    }
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x9517
// Size: 0x17
function votesys_update_time( time )
{
    setomnvar( "ui_votesys_time", time );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 2
// Checksum 0x0, Offset: 0x9536
// Size: 0x2b
function votesys_update_playercount( votecount, playercount )
{
    setomnvar( "ui_votesys_playervotes", votecount );
    setomnvar( "ui_votesys_playercount", playercount );
}

// Namespace globallogic / scripts\cp\globallogic
// Params 1
// Checksum 0x0, Offset: 0x9569
// Size: 0x8d
function function_265a57bcd485237( type )
{
    count = 0;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player.votes ) )
        {
            player vote_player_reset( type );
        }
        
        if ( istrue( player.votes[ type ] ) )
        {
            count++;
        }
    }
    
    return count;
}

