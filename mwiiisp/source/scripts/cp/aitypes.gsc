#using scripts\common\utility;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\powers\coop_molotov;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp_mp\agents\agent_juggernaut;
#using scripts\engine\utility;

#namespace aitypes;

// Namespace aitypes / scripts\cp\aitypes
// Params 0
// Checksum 0x0, Offset: 0xbb7
// Size: 0x3f
function aitypes_init()
{
    level.aitypes = [];
    level.random_aitype_list = [ "ar", "smg", "shotgun" ];
    function_61c1b1e85a54c62b();
    function_2585b1944b7884c0();
}

// Namespace aitypes / scripts\cp\aitypes
// Params 0
// Checksum 0x0, Offset: 0xbfe
// Size: 0x3b5
function function_61c1b1e85a54c62b()
{
    register_aitype_setup( "ar_t1_rus_kas", "jup_enemy_cp_ar_tier1_rus_kas" );
    register_aitype_setup( "ar_t3_rus_kas", "jup_enemy_cp_ar_tier3_rus_kas" );
    register_aitype_setup( "ar_t1_rus_pmc", "jup_enemy_cp_ar_tier1_rus_pmc" );
    register_aitype_setup( "ar_t3_rus_pmc", "jup_enemy_cp_ar_tier3_rus_pmc" );
    register_aitype_setup( "ar_t3_rus_pmc_konni_elite", "jup_enemy_cp_ar_tier3_rus_pmc_konni_elite" );
    register_aitype_setup( "smg_t1_rus_kas", "jup_enemy_cp_smg_tier1_rus_kas" );
    register_aitype_setup( "smg_t3_rus_kas", "jup_enemy_cp_smg_tier3_rus_kas" );
    register_aitype_setup( "smg_t1_rus_pmc", "jup_enemy_cp_smg_tier1_rus_pmc" );
    register_aitype_setup( "smg_t3_rus_pmc", "jup_enemy_cp_smg_tier3_rus_pmc" );
    register_aitype_setup( "smg_t3_rus_pmc_konni_elite", "jup_enemy_cp_smg_tier3_rus_pmc_konni_elite" );
    register_aitype_setup( "lmg_t1_rus_pmc", "jup_enemy_cp_lmg_tier1_rus_pmc" );
    register_aitype_setup( "lmg_t3_rus_pmc", "jup_enemy_cp_lmg_tier3_rus_pmc" );
    register_aitype_setup( "shotgun_t1_rus_kas", "jup_enemy_cp_shotgun_tier1_rus_kas" );
    register_aitype_setup( "shotgun_t3_rus_kas", "jup_enemy_cp_shotgun_tier3_rus_kas" );
    register_aitype_setup( "shotgun_t1_rus_pmc", "jup_enemy_cp_shotgun_tier1_rus_pmc" );
    register_aitype_setup( "shotgun_t3_rus_pmc", "jup_enemy_cp_shotgun_tier3_rus_pmc" );
    register_aitype_setup( "shotgun_t3_rus_pmc_konni_elite", "jup_enemy_cp_shotgun_tier3_rus_pmc_konni_elite" );
    register_aitype_setup( "sniper_t1_rus_pmc", "jup_enemy_cp_sniper_tier1_rus_pmc" );
    register_aitype_setup( "sniper_t3_rus_pmc", "jup_enemy_cp_sniper_tier3_rus_pmc" );
    register_aitype_setup( "riotshield_t1_rus_pmc", "jup_enemy_cp_riotshield_tier1_rus_pmc" );
    register_aitype_setup( "riotshield_t3_rus_pmc", "jup_enemy_cp_riotshield_tier3_rus_pmc" );
    register_aitype_setup( "rpg_t1_rus_pmc", "jup_enemy_cp_rpg_tier1_rus_pmc" );
    register_aitype_setup( "rpg_t3_rus_pmc", "jup_enemy_cp_rpg_tier3_rus_pmc" );
    register_aitype_setup( "pistol_t1_rus_kas", "jup_enemy_cp_pistol_tier1_rus_kas" );
    register_aitype_setup( "pistol_t3_rus_kas", "jup_enemy_cp_pistol_tier3_rus_kas" );
    register_aitype_setup( "pistol_t1_rus_pmc", "jup_enemy_cp_pistol_tier1_rus_pmc" );
    register_aitype_setup( "pistol_t3_rus_pmc", "jup_enemy_cp_pistol_tier3_rus_pmc" );
    register_aitype_setup( "ar_t1_security", "jup_enemy_cp_ar_tier1_security" );
    register_aitype_setup( "smg_t1_security", "jup_enemy_cp_smg_tier1_security" );
    register_aitype_setup( "shotgun_t1_security", "jup_enemy_cp_shotgun_tier1_security" );
    register_aitype_setup( "pistol_t1_security", "jup_enemy_cp_pistol_tier1_security" );
    register_aitype_setup( "jugg_rus", "jup_enemy_cp_jugg_rus", undefined, &function_9face5260d8be7ea );
    register_aitype_setup( "jugg_rus_pmc", "jup_enemy_cp_jugg_rus_pmc", undefined, &function_9face5260d8be7ea );
    register_aitype_setup( "unq_t2_kas_officer", "jup_enemy_cp_unique_kas_officer" );
    register_aitype_setup( "unq_t3_rus_pmc_comm", "jup_enemy_cp_unique_rus_pmc_commander_resort" );
    register_aitype_setup( "unq_t1_rus_pmc_hvt", "jup_enemy_cp_unique_rus_pmc_hvt_resort" );
    register_aitype_setup( "unq_t1_rus_pmc_pilot", "jup_enemy_cp_unique_rus_pmc_pilot" );
    register_aitype_setup( "civilian_male", "jup_civilian_cp_male" );
    register_aitype_setup( "civilian_worker", "jup_civilian_cp_worker" );
    register_aitype_setup( "civilian_female", "jup_civilian_cp_female" );
    register_aitype_setup( "civilian_hostage", "jup_civilian_cp_hostage" );
    register_aitype_setup( "civilian_rusdelegate", "jup_civilian_cp_rus_kas_delegate" );
    register_aitype_setup( "civilian_rusgeneral", "jup_civilian_cp_rus_kas_general" );
    register_aitype_setup( "hero_farah", "jup_ally_hero_farah_cp" );
    register_aitype_setup( "hero_price", "jup_ally_hero_price_cp" );
    register_aitype_setup( "hero_soap", "jup_ally_hero_soap_cp" );
    register_aitype_setup( "hero_soap_diver", "jup_ally_hero_soap_diver_cp" );
    register_aitype_setup( "hero_soap_diver_land", "jup_ally_hero_soap_diver_land_cp" );
    register_aitype_setup( "hero_ghost", "jup_ally_hero_ghost_cp" );
    register_aitype_setup( "hero_kyle", "jup_ally_hero_kyle_cp" );
    register_aitype_setup( "hero_alex", "jup_ally_hero_alex_cp" );
    register_aitype_setup( "villain_makarov", "jup_enemy_villain_makarov_cp" );
    register_aitype_setup( "villain_yuri", "jup_enemy_villain_yuri_cp" );
    register_aitype_setup( "villain_nolan", "jup_enemy_villain_nolan_cp" );
    register_aitype_setup( "villain_resort", "jup_enemy_villain_resort_cp" );
}

// Namespace aitypes / scripts\cp\aitypes
// Params 6
// Checksum 0x0, Offset: 0xfbb
// Size: 0xd3
function register_aitype_setup( aitype, agent_type, combat_func, spawn_func, info_func, spawn_vo_lines )
{
    struct = spawnstruct();
    struct.agent_type = agent_type;
    struct.combat_func = combat_func;
    struct.spawn_func = spawn_func;
    struct.info_func = info_func;
    struct.spawn_vo_lines = spawn_vo_lines;
    level.lastspawnvocallouttimes[ aitype ] = -99999;
    level.aitypes[ aitype ] = struct;
    scripts\cp\spawning::registerambientgroup( "AITYPE:0/ " + aitype, 0, 1, 1, 0.1, undefined, "cap_test", [ &function_cb88733d2f7dbebd, aitype ] );
}

// Namespace aitypes / scripts\cp\aitypes
// Params 2
// Checksum 0x0, Offset: 0x1096
// Size: 0x38
function function_cb88733d2f7dbebd( module_struct, aitype )
{
    module_struct.aitype_override = [ aitype ];
    module_struct.aitype_override_weights = [ 1 ];
}

// Namespace aitypes / scripts\cp\aitypes
// Params 1
// Checksum 0x0, Offset: 0x10d6
// Size: 0x214
function set_juggernaut_flags( disable_music )
{
    self.disablegrenaderesponse = 1;
    self.meleechargedistvsplayer = getdvarint( @"hash_c4623ff30dde6ae9", self.meleechargedistvsplayer );
    self.meleechargedist = getdvarint( @"hash_f3b2daa7c30b46e3", self.meleechargedist );
    self.meleestopattackdistsq = squared( getdvarint( @"hash_6b6862dc32c4ad93", sqrt( self.meleestopattackdistsq ) ) );
    self.meleedamageoverride = getdvarint( @"hash_c36464367b65902a", self.meleedamageoverride );
    self.attackeraccuracy = getdvarint( @"hash_27c356dd262c53eb", self.attackeraccuracy );
    self.var_7d606bec79308eb5 = getdvarint( @"hash_6f5088cc345089b0", self.var_7d606bec79308eb5 );
    self.minpaindamage = getdvarint( @"hash_5212419a69489b1a", self.minpaindamage );
    self.maxhealth = getdvarint( @"hash_93c7973e428c20d3", self.maxhealth );
    self.health = self.maxhealth;
    scripts\cp_mp\agents\agent_juggernaut::function_a414fbf48ae645f4();
    self.immune_to_melee_damage = 1;
    self.recent_player_attackers = [];
    self allowedstances( "stand" );
    
    if ( !istrue( disable_music ) )
    {
        self setscriptablepartstate( "loop_sounds", "music", 1 );
    }
    
    self sethitlocdamagetable( %"hash_1521c47f88cbd2b8" );
    
    if ( getdvarint( @"hash_749f54ce1eb4ae4", 1 ) )
    {
        disable_pain();
    }
    
    scripts\cp_mp\agents\agent_juggernaut::function_1cbb19fc0caeab00();
    
    if ( isdefined( level.var_bf8aa3f39f981625 ) )
    {
        foreach ( func in level.var_bf8aa3f39f981625 )
        {
            self thread [[ func ]]();
        }
    }
    
    thread pain_threshold_watcher();
    
    if ( !istrue( disable_music ) )
    {
        thread jugg_music();
    }
}

// Namespace aitypes / scripts\cp\aitypes
// Params 0
// Checksum 0x0, Offset: 0x12f2
// Size: 0xb
function function_9face5260d8be7ea()
{
    set_juggernaut_flags( 1 );
}

// Namespace aitypes / scripts\cp\aitypes
// Params 0
// Checksum 0x0, Offset: 0x1305
// Size: 0xf2
function pain_threshold_watcher()
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        var_7f4b5ac6b201321a = get_jugg_minpaindamage();
        self waittill( "damage", damage, player );
        players = level.players.size;
        
        if ( isdefined( player ) && player is_valid_player() && players > 0 )
        {
            self.recent_player_attackers[ player.name ] = 1;
            thread remove_player_from_attacker_list( player );
            attacker_mod = getdvarint( @"hash_2df212783e0bf84f", 75 );
            var_1271e4a73de480b6 = self.recent_player_attackers.size;
            new_value = int( max( 1, var_7f4b5ac6b201321a * players / var_1271e4a73de480b6 - ( var_1271e4a73de480b6 - 1 ) * attacker_mod ) );
            self.minpaindamage = new_value;
        }
    }
}

// Namespace aitypes / scripts\cp\aitypes
// Params 1
// Checksum 0x0, Offset: 0x13ff
// Size: 0x88
function remove_player_from_attacker_list( player )
{
    player notify( "remove_player_from_attacker_list" );
    player endon( "remove_player_from_attacker_list" );
    player endon( "disconnect" );
    self endon( "death" );
    self.recent_player_attackers[ player.name ] = 1;
    wait getdvarfloat( @"hash_150e3b3c1b10762a", 0.5 );
    self.recent_player_attackers[ player.name ] = undefined;
    
    if ( self.recent_player_attackers.size < 1 )
    {
        self.minpaindamage = get_jugg_minpaindamage();
    }
}

// Namespace aitypes / scripts\cp\aitypes
// Params 0
// Checksum 0x0, Offset: 0x148f
// Size: 0x12
function get_jugg_minpaindamage()
{
    return getdvarint( @"hash_5212419a69489b1a", 200 );
}

// Namespace aitypes / scripts\cp\aitypes
// Params 0
// Checksum 0x0, Offset: 0x14aa
// Size: 0x57
function jugg_music()
{
    soundorg = spawn( "script_origin", self.origin );
    soundorg linkto( self );
    wait 0.1;
    soundorg setmodel( "juggernaut_scriptable" );
    waittill_any_3( "juggernaut_end", "disconnect", "death" );
    soundorg delete();
}

// Namespace aitypes / scripts\cp\aitypes
// Params 2
// Checksum 0x0, Offset: 0x1509
// Size: 0x23
function function_38084f83d390a611( group_name, func )
{
    thread function_43678d7bec207335();
    set_battlechatter( 0 );
}

// Namespace aitypes / scripts\cp\aitypes
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x1534
// Size: 0x12b
function private function_43678d7bec207335()
{
    level endon( "game_ended" );
    self endon( "death" );
    scripts\cp\spawning::set_goal_radius( 1300 );
    
    if ( !istrue( level.var_c1081d7c7e56bdf7 ) )
    {
        self enabletraversals( 0, "soldier" );
    }
    
    foreach ( player in level.players )
    {
        self getenemyinfo( player );
    }
    
    mindist = 1048576;
    
    while ( true )
    {
        wait 5;
        
        if ( !any_player_nearby( self.origin, mindist ) )
        {
            nearbyplayer = get_closest_living_player();
            
            if ( isdefined( nearbyplayer ) )
            {
                scripts\cp\spawning::set_goal_pos( self getclosestreachablepointonnavmesh( nearbyplayer.origin ) );
            }
        }
        
        foreach ( player in level.players )
        {
            self getenemyinfo( player );
        }
    }
}

// Namespace aitypes / scripts\cp\aitypes
// Params 0
// Checksum 0x0, Offset: 0x1667
// Size: 0x18
function function_2585b1944b7884c0()
{
    scripts\engine\utility::registersharedfunc( "pyro", "molotov_used", &scripts\cp\powers\coop_molotov::molotov_used );
}

