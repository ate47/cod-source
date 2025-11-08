#using script_185660037b9236c1;
#using script_39d11000e476a42a;
#using script_3d3d1ef33cecfb62;
#using script_41387eecc35b88bf;
#using script_482376d10f69832c;
#using script_5815a7cb4d944542;
#using script_5f71ed065b9cea1e;
#using script_638d701d263ee1ed;
#using script_64351208cb856df9;
#using script_686729055b66c6e4;
#using script_6b684505b9959a08;
#using script_7956d56c4922bd1;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\pmc_missions;
#using scripts\mp\utility\perk;
#using scripts\ob\points;

#namespace ob_objective_rewards;

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 0
// Checksum 0x0, Offset: 0xb04
// Size: 0x49
function init()
{
    /#
        thread function_de2062aa7eaf5617();
        callback::add( "<dev string:x1c>", &function_ac138c84c0432491 );
    #/
    
    function_8b5b2a3392fc7e2a( "ActivityEnd", &function_23b66008ea86e35c );
    level._effect[ "rift_marked_zombie" ] = loadfx( "vfx/jup/ob/gameplay/zm/vfx_reward_rift_zombie_death.vfx" );
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 5
// Checksum 0x0, Offset: 0xb55
// Size: 0x16b
function function_4318321c0172ec43( var_580db0023b1afd04, var_d7f5721cea7df9c5, var_16093b68c8441bb3, difficulty_region, region_name )
{
    reward_instance = spawnstruct();
    reward_instance.playerparticipants = var_16093b68c8441bb3;
    reward_instance.difficulty_region = difficulty_region;
    
    if ( istrue( var_d7f5721cea7df9c5 ) )
    {
        function_d7f5721cea7df9c5( reward_instance );
    }
    
    if ( istrue( var_580db0023b1afd04 ) )
    {
        var_db1036d6c298e796 = spawnstruct();
        spawn_contract_reward_rift( self, self.rewardstructoverride, var_db1036d6c298e796 );
        level thread function_f4ca5678b389bda1( var_db1036d6c298e796, self );
        placement_struct = namespace_3dd7203b843229f9::function_7af151bd42e8132d( self, "UseGameModeSetting" );
        reward_instance.placement_struct = placement_struct;
        reward_instance thread reward_explosion();
    }
    
    if ( isdefined( self.playerparticipants ) && isdefined( self.var_b90c26f642e9b96e ) )
    {
        scoreeventparams = spawnstruct();
        scoreeventparams.scoreevent = self.var_b90c26f642e9b96e;
        scoreeventparams.reason = #"activity_reward";
        
        foreach ( player in var_16093b68c8441bb3 )
        {
            player callback::callback( "zombie_score_event", scoreeventparams );
        }
    }
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 3
// Checksum 0x0, Offset: 0xcc8
// Size: 0xf5
function spawn_contract_reward_rift( activityinstance, rewardstructoverride, var_5edef452e5fc2cd7 )
{
    reward_cache::function_1c972fc13937297c( "ob_objective_rewards.gsc: Attempting to spawn a contract reward rift for activity instance with variant tag: " + namespace_4fda5d7358015a06::function_a4748b32a824c79c( activityinstance ) );
    
    /#
        var_88a08b25571f4a24 = activity_rewards::function_1edea59f189f9a02( activityinstance, "<dev string:x2e>", "<dev string:x40>" );
        
        if ( !var_88a08b25571f4a24 )
        {
            reward_cache::function_1c5f030d48fdff4c( "<dev string:x5e>" + namespace_4fda5d7358015a06::function_a4748b32a824c79c( activityinstance ) + "<dev string:xc9>" + "<dev string:x40>" + "<dev string:x100>" + "<dev string:x125>" + "<dev string:x191>" + "<dev string:x201>" );
        }
    #/
    
    relevantinfostruct = spawnstruct();
    
    if ( isdefined( rewardstructoverride ) )
    {
        relevantinfostruct.rewardstructoverride = rewardstructoverride;
    }
    
    if ( isdefined( var_5edef452e5fc2cd7 ) )
    {
        var_be39a270e44a0361 = spawnstruct();
        relevantinfostruct.var_44fadde66021a763 = var_be39a270e44a0361;
    }
    
    namespace_68dc261109a9503f::function_ce906635a152d2d0( self, "spawn_contract_reward_rift", relevantinfostruct );
    
    if ( isdefined( var_5edef452e5fc2cd7 ) )
    {
        thread function_a57eb235aa288f81( relevantinfostruct.var_44fadde66021a763, var_5edef452e5fc2cd7, activityinstance );
    }
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 5
// Checksum 0x0, Offset: 0xdc5
// Size: 0x79
function function_863be9e39e19fe2f( reward_groups, placement_struct, lootfunc, var_5812163a4b6704c8, var_3c99a2a84c4b850f )
{
    rewardcachesettings = reward_cache_settings::function_ec54b8019f59c0ef( "reward_rift_default" );
    rewardcachebehaviorsettings = namespace_81b7e1672a7e54da::function_4d6ae01e1e47320c( "reward_rift_default_behavior" );
    func_openlootablecontainer = &namespace_3dd7203b843229f9::function_885b8eee6652a555;
    managed_reward_cache::function_75e180b08f394748( rewardcachesettings, rewardcachebehaviorsettings, reward_groups, placement_struct, func_openlootablecontainer, lootfunc, var_5812163a4b6704c8, undefined, undefined, var_3c99a2a84c4b850f );
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xe46
// Size: 0xc8
function private function_a57eb235aa288f81( var_be39a270e44a0361, var_5edef452e5fc2cd7, activityinstance )
{
    if ( !isdefined( var_be39a270e44a0361 ) )
    {
        assertmsg( "<dev string:x226>" );
        return;
    }
    
    if ( !isdefined( var_5edef452e5fc2cd7 ) )
    {
        assertmsg( "<dev string:x291>" );
        return;
    }
    
    if ( !isdefined( activityinstance ) )
    {
        assertmsg( "<dev string:x2fa>" );
        return;
    }
    
    var_be39a270e44a0361 waittill( "activity_reward_caches_done_spawning", var_9c985bdb5d9108c );
    
    if ( var_9c985bdb5d9108c.size > 1 )
    {
        reward_cache::function_e02e37e34dec2042( "Attempted to return a contract reward rift with the activation name " + "spawn_contract_reward_rift" + " but more than one cache was spawned! Only a single cache is expected to spawn with that activation name. Please" + " check your activitydefinition settings for duplicate activity reward caches with that activation name and remove" + " the duplicate (activity variant: " + namespace_4fda5d7358015a06::function_a4748b32a824c79c( activityinstance ) + ")" );
    }
    
    if ( var_9c985bdb5d9108c.size > 0 )
    {
        var_26462efc3f103314 = var_9c985bdb5d9108c[ 0 ];
    }
    else
    {
        var_26462efc3f103314 = undefined;
    }
    
    var_5edef452e5fc2cd7 notify( "reward_rift_spawn_done", var_26462efc3f103314 );
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 1
// Checksum 0x0, Offset: 0xf16
// Size: 0xb1
function function_9d71b982e1eb2f81( difficulty_region )
{
    var_7b60c91792761e4f = #"hash_6b316738ef8d272";
    
    if ( isdefined( difficulty_region ) )
    {
        switch ( difficulty_region )
        {
            case #"hash_7bb2cd766703d463":
                var_7b60c91792761e4f = #"hash_6b316738ef8d272";
                break;
            case #"hash_af83e47edfa8900a":
                var_7b60c91792761e4f = #"hash_4db4235976d94fc7";
                break;
            case #"hash_5343b465e56ec9a4":
                var_7b60c91792761e4f = #"hash_876c51b14bc99659";
                break;
            case #"hash_651f76c0ad6741ec":
                var_7b60c91792761e4f = #"hash_73c4b7d4f0baf972";
                break;
            default:
                var_7b60c91792761e4f = #"hash_6b316738ef8d272";
                break;
        }
    }
    
    return var_7b60c91792761e4f;
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 1
// Checksum 0x0, Offset: 0xfd0
// Size: 0xcf
function function_d7f5721cea7df9c5( reward_instance )
{
    if ( !isdefined( reward_instance ) )
    {
        return;
    }
    
    var_7b60c91792761e4f = function_9d71b982e1eb2f81( reward_instance.difficulty_region );
    
    foreach ( player in reward_instance.playerparticipants )
    {
        player scripts\ob\points::function_ddee59d6b1a2b9e( var_7b60c91792761e4f, undefined, 1, #"activity_reward" );
        
        if ( player scripts\mp\utility\perk::_hasperk( "specialty_exfil_contract_percent_reward" ) )
        {
            var_527bff0c92d4a0aa = level.perkbundles[ "specialty_exfil_contract_percent_reward" ].var_16963ed996290c93;
            player scripts\ob\points::function_ddee59d6b1a2b9e( var_7b60c91792761e4f, undefined, 1, undefined, var_527bff0c92d4a0aa );
        }
    }
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 0
// Checksum 0x0, Offset: 0x10a7
// Size: 0x129
function reward_explosion()
{
    a_ai = getaiarrayinradius( self.placement_struct.origin, 575 );
    var_6bfbb345d937798e = [];
    
    foreach ( player in self.playerparticipants )
    {
        foreach ( ai in a_ai )
        {
            if ( ai.team == player.team || ai.team == "neutral" || array_contains( var_6bfbb345d937798e, ai ) )
            {
                continue;
            }
            
            var_6bfbb345d937798e = array_add( var_6bfbb345d937798e, ai );
        }
    }
    
    function_5a2c160d3a406b94( self.placement_struct.origin, var_6bfbb345d937798e, 1 );
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 3
// Checksum 0x0, Offset: 0x11d8
// Size: 0x38c
function function_5a2c160d3a406b94( v_location, a_ais, var_8d1aa1efbf8b3c6e )
{
    foreach ( ai in a_ais )
    {
        if ( isalive( ai ) )
        {
            ai function_5c38bc01727d2c5c( 1.5 );
        }
    }
    
    wait 0.5;
    var_473ff5b31f1ed342 = array_removedead( a_ais );
    var_473ff5b31f1ed342 = get_array_of_closest( v_location, var_473ff5b31f1ed342 );
    var_f00cdf3d3bfc5a54 = [];
    
    foreach ( ai in var_473ff5b31f1ed342 )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        b_skip = 0;
        
        if ( istrue( ai.magic_bullet_shield ) )
        {
            b_skip = 1;
        }
        
        if ( istrue( ai.marked_for_death ) )
        {
            b_skip = 1;
        }
        
        if ( b_skip )
        {
            ai function_e0d13e2a538e2947();
            continue;
        }
        
        ai.marked_for_death = 1;
        
        if ( !istrue( ai.var_9eb8bf12bddbe7f6 ) )
        {
            ai.var_9eb8bf12bddbe7f6 = 1;
            ai.no_powerups = 1;
            ai.var_7e4b076a06c6df27 = 1;
            ai.full_gib = 1;
            ai.var_745cd904c1ec804c = 1;
            var_f00cdf3d3bfc5a54 = array_add( var_f00cdf3d3bfc5a54, ai );
        }
    }
    
    var_60d4e0f1aeb32f84 = undefined;
    
    foreach ( ai_killed in var_f00cdf3d3bfc5a54 )
    {
        wait randomfloatrange( 0.05, 0.15 );
        
        if ( !isalive( ai_killed ) )
        {
            continue;
        }
        
        ai_killed function_e0d13e2a538e2947();
        
        if ( istrue( ai_killed.magic_bullet_shield ) )
        {
            continue;
        }
        
        var_bc8818c262ac2b04 = undefined;
        
        if ( isdefined( ai_killed.aicategory ) && !istrue( var_8d1aa1efbf8b3c6e ) )
        {
            if ( ai_killed.aicategory == "special" )
            {
                var_bc8818c262ac2b04 = ai_killed.maxhealth * function_519d44e54a9b8ae5( "nuke" ).var_74576b4dd247d7b1;
            }
            else if ( ai_killed.aicategory == "elite" || ai_killed.aicategory == "boss" )
            {
                var_bc8818c262ac2b04 = ai_killed.maxhealth * function_519d44e54a9b8ae5( "nuke" ).var_e896465ad8ccd911;
            }
        }
        
        if ( isdefined( var_bc8818c262ac2b04 ) && var_bc8818c262ac2b04 < ai_killed.health )
        {
            if ( !isdefined( var_60d4e0f1aeb32f84 ) )
            {
                var_60d4e0f1aeb32f84 = spawn( "script_model", v_location );
            }
            
            if ( var_bc8818c262ac2b04 > 0 )
            {
                ai_killed dodamage( int( var_bc8818c262ac2b04 ), ai_killed.origin, undefined, var_60d4e0f1aeb32f84, "MOD_UNKNOWN", "none", "none", undefined, 65536 );
            }
            
            ai_killed.marked_for_death = 0;
            ai_killed.var_9eb8bf12bddbe7f6 = 0;
            ai_killed.var_745cd904c1ec804c = 0;
            ai_killed.no_powerups = 0;
            ai_killed.var_7e4b076a06c6df27 = 0;
            ai_killed.full_gib = 0;
            continue;
        }
        
        ai_killed kill();
    }
    
    if ( isdefined( var_60d4e0f1aeb32f84 ) )
    {
        var_60d4e0f1aeb32f84 delete();
    }
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x156c
// Size: 0x57
function private function_5c38bc01727d2c5c( var_8c28aac0b76c1e2e )
{
    playfxontag( getfx( "rift_marked_zombie" ), self, "j_spine4" );
    namespace_ed7c38f3847343dc::stun_ai( var_8c28aac0b76c1e2e );
    params = spawnstruct();
    params.attacker = undefined;
    params.var_51357609845cf128 = gettime();
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x15cb
// Size: 0x4d
function private function_e0d13e2a538e2947()
{
    namespace_ed7c38f3847343dc::clear_stun();
    params = spawnstruct();
    params.attacker = undefined;
    params.var_51357609845cf128 = gettime();
    stopfxontag( getfx( "rift_marked_zombie" ), self, "j_spine4" );
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 1
// Checksum 0x0, Offset: 0x1620
// Size: 0x3c
function function_d67ffd8ae22bf637( cache )
{
    reward_instance = self;
    reward_instance function_d364b924be9b36e8( cache );
    reward_instance function_3ed651fb51ed438c( cache );
    reward_instance function_24781fccafc7f6dc( cache );
    reward_instance function_d55d0e38986d17f3( cache );
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 1
// Checksum 0x0, Offset: 0x1664
// Size: 0x2c9
function function_d364b924be9b36e8( cache )
{
    items = [];
    
    if ( getdvarint( @"ob_rift_run", 0 ) )
    {
        if ( getdvarint( @"hash_73cfb77eb49c943", 0 ) )
        {
            if ( scripts\cp_mp\utility\game_utility::getmapname() == "mp_jup_sira" )
            {
                items = function_bc2f4857c90f5344( "ob_jup_items_contracts_riftrun_hard_s2", 3 );
            }
            else if ( scripts\cp_mp\utility\game_utility::getmapname() == "mp_jup_tower" )
            {
                items = function_bc2f4857c90f5344( "ob_jup_items_contracts_riftrun_hard_s5", 4 );
            }
            else
            {
                items = function_bc2f4857c90f5344( "ob_jup_items_contracts_riftrun_hard", 3 );
            }
        }
        else if ( scripts\cp_mp\utility\game_utility::getmapname() == "mp_jup_sira" )
        {
            items = function_bc2f4857c90f5344( "ob_jup_items_contracts_riftrun_normal_s2", 3 );
        }
        else if ( scripts\cp_mp\utility\game_utility::getmapname() == "mp_jup_tower" )
        {
            items = function_bc2f4857c90f5344( "ob_jup_items_contracts_riftrun_normal_s5", 3 );
        }
        else
        {
            items = function_bc2f4857c90f5344( "ob_jup_items_contracts_riftrun_normal", 3 );
        }
    }
    else if ( getdvarint( @"ob_s3_rift_run", 0 ) )
    {
        if ( getdvarint( @"hash_bc2abb9e5752e088", 0 ) )
        {
            items = function_bc2f4857c90f5344( "ob_jup_items_contracts_riftrun_hard_s3", 4 );
        }
        else
        {
            items = function_bc2f4857c90f5344( "ob_jup_items_contracts_riftrun_normal_s3", 3 );
        }
    }
    else if ( istrue( level.ob_pvpve ) )
    {
        if ( !isdefined( self.difficulty_region ) )
        {
            self.difficulty_region = "";
        }
        
        switch ( self.difficulty_region )
        {
            case #"hash_7bb2cd766703d463":
                items = function_bc2f4857c90f5344( "ob_jup_items_contracts_green_pvpve", 3 );
                break;
            case #"hash_af83e47edfa8900a":
                items = function_bc2f4857c90f5344( "ob_jup_items_contracts_yellow_pvpve", 3 );
                break;
            case #"hash_5343b465e56ec9a4":
                items = function_bc2f4857c90f5344( "ob_jup_items_contracts_orange_pvpve", 3 );
                break;
            case #"hash_651f76c0ad6741ec":
                items = function_bc2f4857c90f5344( "ob_jup_items_contracts_red_pvpve", 3 );
                break;
            default:
                items = function_bc2f4857c90f5344( "ob_jup_items_contracts_green_pvpve", 3 );
                break;
        }
    }
    else
    {
        if ( !isdefined( self.difficulty_region ) )
        {
            self.difficulty_region = "";
        }
        
        switch ( self.difficulty_region )
        {
            case #"hash_7bb2cd766703d463":
                items = function_bc2f4857c90f5344( "ob_jup_items_contracts_green", 3 );
                break;
            case #"hash_af83e47edfa8900a":
                items = function_bc2f4857c90f5344( "ob_jup_items_contracts_yellow", 3 );
                break;
            case #"hash_5343b465e56ec9a4":
                items = function_bc2f4857c90f5344( "ob_jup_items_contracts_orange", 3 );
                break;
            case #"hash_651f76c0ad6741ec":
                items = function_bc2f4857c90f5344( "ob_jup_items_contracts_red", 3 );
                break;
            default:
                items = function_bc2f4857c90f5344( "ob_jup_items_contracts_green", 3 );
                break;
        }
    }
    
    common_cache::function_fd95ef820bb2b980( items, cache );
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 1
// Checksum 0x0, Offset: 0x1935
// Size: 0xc7
function function_24781fccafc7f6dc( cache )
{
    if ( !getdvarint( @"hash_abc1d9ea495ec189", 0 ) && !getdvarint( @"ob_rift_run", 0 ) )
    {
        return;
    }
    
    if ( !isarray( self.reward_group ) )
    {
        return;
    }
    
    player = self.reward_group[ 0 ];
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( istrue( player.var_f618a05d316a2fd6 ) || istrue( player.var_d34c91079b4d1515 ) || istrue( player.var_f277fbd58fcf41c8 ) || istrue( player.var_2123e95946a8122a ) )
    {
        items = function_297f306b101939f6( self );
        
        if ( isarray( items ) )
        {
            common_cache::function_fd95ef820bb2b980( items, cache );
        }
    }
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 1
// Checksum 0x0, Offset: 0x1a04
// Size: 0xb7
function function_297f306b101939f6( rewardinstance )
{
    if ( !isdefined( rewardinstance.difficulty_region ) )
    {
        return;
    }
    
    if ( rewardinstance.difficulty_region == "difficulty_hard" && !getdvarint( @"ob_rift_run", 0 ) )
    {
        if ( randomint( 100 ) < getdvarint( @"hash_cdde840571118831", 33 ) )
        {
            return [ "ob_jup_item_key_rift_token_low" ];
        }
        
        return;
    }
    
    if ( rewardinstance.difficulty_region == "difficulty_darkaether" || getdvarint( @"ob_rift_run", 0 ) )
    {
        if ( randomint( 100 ) < getdvarint( @"hash_ee2108899883315f", 33 ) )
        {
            return [ "ob_jup_item_key_rift_token_high" ];
        }
        
        return;
    }
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 0
// Checksum 0x0, Offset: 0x1ac3
// Size: 0x52
function function_2be245cf8652128f()
{
    var_1fdcab615049aa6f = [];
    var_1fdcab615049aa6f[ "REV_OB_ZOMBIE_CONTROL" ] = 16643;
    var_1fdcab615049aa6f[ "REV_OB_SABOTAGE" ] = 14707;
    var_1fdcab615049aa6f[ "REV_OB_ESCORT_ZOMBIES" ] = 17063;
    var_1fdcab615049aa6f[ "REV_OB_WEAPON_STASH" ] = 16644;
    var_1fdcab615049aa6f[ "REV_OB_DEFEND_MERCS" ] = 17069;
    var_1fdcab615049aa6f[ "REV_OB_OUTLAST" ] = 17089;
    return var_1fdcab615049aa6f;
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 0
// Checksum 0x0, Offset: 0x1b1e
// Size: 0x5e
function function_2723a1632cd9aed9()
{
    var_f031d67155304339 = [];
    var_f031d67155304339[ "REV_OB_ZOMBIE_CONTROL" ] = "ob_jup_items_quest_loot_zombie_control";
    var_f031d67155304339[ "REV_OB_SABOTAGE" ] = "ob_jup_items_quest_loot_sabotage";
    var_f031d67155304339[ "REV_OB_ESCORT_ZOMBIES" ] = "ob_jup_items_quest_loot_escort";
    var_f031d67155304339[ "REV_OB_WEAPON_STASH" ] = "ob_jup_items_quest_loot_weaponstash";
    var_f031d67155304339[ "REV_OB_DEFEND_MERCS" ] = "ob_jup_items_quest_loot_mercdefend";
    var_f031d67155304339[ "REV_OB_OUTLAST" ] = "ob_jup_items_quest_loot_outlast";
    return var_f031d67155304339;
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 3
// Checksum 0x0, Offset: 0x1b85
// Size: 0x167
function function_f4ca5678b389bda1( var_db1036d6c298e796, activity_instance, var_e10194ca6271ac0a )
{
    if ( !isdefined( var_e10194ca6271ac0a ) )
    {
        var_e10194ca6271ac0a = undefined;
    }
    
    if ( !isdefined( activity_instance ) )
    {
        return;
    }
    
    reward_instance = spawnstruct();
    reward_instance.var_c083bd8353c655c1 = namespace_4fda5d7358015a06::function_2dabe17056c2563f( activity_instance );
    reward_instance.var_cc4e306d6425c182 = [];
    reward_instance.var_33e96096a10a0f25 = [];
    reward_instance.var_1fdcab615049aa6f = [];
    reward_instance.var_f031d67155304339 = [];
    reward_instance.var_1fdcab615049aa6f = function_2be245cf8652128f();
    reward_instance.var_f031d67155304339 = function_2723a1632cd9aed9();
    
    foreach ( player in reward_instance.var_c083bd8353c655c1 )
    {
        if ( function_7937b1cfc8818d50( player, activity_instance, reward_instance ) )
        {
            reward_instance.var_cc4e306d6425c182[ reward_instance.var_cc4e306d6425c182.size ] = player;
        }
    }
    
    if ( reward_instance.var_cc4e306d6425c182.size == 0 )
    {
        return;
    }
    
    reward_instance.var_5da0c861642aa1e8 = spawnstruct();
    reward_instance.var_5da0c861642aa1e8.type = activity_instance.type;
    function_b3fbe14081c02a2c( var_db1036d6c298e796, reward_instance, var_e10194ca6271ac0a );
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 3
// Checksum 0x0, Offset: 0x1cf4
// Size: 0xc2
function function_b3fbe14081c02a2c( var_db1036d6c298e796, reward_instance, var_6eee8785d833d021 )
{
    var_e10194ca6271ac0a = undefined;
    
    if ( !isdefined( var_6eee8785d833d021 ) )
    {
        var_db1036d6c298e796 waittill( "reward_rift_spawn_done", var_6eee8785d833d021 );
        
        if ( !isdefined( var_6eee8785d833d021 ) )
        {
            return;
        }
    }
    
    var_e10194ca6271ac0a = var_6eee8785d833d021;
    managed_reward_cache::function_a52e804f95d8ef78( var_e10194ca6271ac0a );
    
    foreach ( player in reward_instance.var_cc4e306d6425c182 )
    {
        if ( isplayer( player ) )
        {
            reward_instance.var_33e96096a10a0f25[ player getentitynumber() ] = managed_reward_cache::function_805de4f236be02cc( var_e10194ca6271ac0a, player );
        }
    }
    
    function_dc1a9b9610b44060( var_e10194ca6271ac0a, reward_instance );
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 2
// Checksum 0x0, Offset: 0x1dbe
// Size: 0x1d4
function function_dc1a9b9610b44060( var_e10194ca6271ac0a, reward_instance )
{
    timer = 15;
    
    while ( timer > 0 )
    {
        foreach ( player in reward_instance.var_cc4e306d6425c182 )
        {
            /#
                if ( getdvarint( @"hash_9273f5c68dce75e4", 0 ) )
                {
                    continue;
                }
            #/
            
            if ( isplayer( player ) )
            {
                if ( function_9f94c5a87e6da54b( reward_instance, player ) )
                {
                    function_f006e75899cdd353( var_e10194ca6271ac0a, player, reward_instance );
                    reward_instance.var_cc4e306d6425c182 = array_remove( reward_instance.var_cc4e306d6425c182, player );
                }
            }
        }
        
        if ( reward_instance.var_cc4e306d6425c182.size == 0 )
        {
            break;
        }
        
        wait 1;
        timer -= 1;
    }
    
    activity_type = reward_instance.var_5da0c861642aa1e8.type;
    
    if ( isdefined( activity_type ) )
    {
        var_40791919d3f24302 = reward_instance.var_f031d67155304339[ activity_type ];
        
        if ( isdefined( var_40791919d3f24302 ) )
        {
            foreach ( player in reward_instance.var_cc4e306d6425c182 )
            {
                if ( isplayer( player ) )
                {
                    var_cd68c23920cc227f = { #var_40791919d3f24302:var_40791919d3f24302, #activity_type:activity_type };
                    player callback::add( "ob_exfil_success", &function_de8f5de2296c5596, var_cd68c23920cc227f );
                    player callback::add( "player_disconnect", &function_de8f5de2296c5596, var_cd68c23920cc227f );
                }
            }
        }
    }
    
    function_f1c1ef5a544c2add( var_e10194ca6271ac0a );
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 3
// Checksum 0x0, Offset: 0x1f9a
// Size: 0xa5
function function_f006e75899cdd353( var_e10194ca6271ac0a, player, reward_instance )
{
    cache = spawnstruct();
    bundle_name = function_864e6e1dfc3fa879( reward_instance, player );
    
    if ( isdefined( bundle_name ) )
    {
        items = function_bc2f4857c90f5344( bundle_name, 1 );
        common_cache::function_fd95ef820bb2b980( items, cache );
    }
    else
    {
        return;
    }
    
    var_69281e57808f26f6 = cache.contents[ 0 ];
    var_789b03a07b72284c = reward_instance.var_33e96096a10a0f25[ player getentitynumber() ];
    managed_reward_cache::function_8b4f7ed65818ac99( var_e10194ca6271ac0a, player, var_789b03a07b72284c, var_69281e57808f26f6 );
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 2
// Checksum 0x0, Offset: 0x2047
// Size: 0xe3
function function_de8f5de2296c5596( callback_params, var_cd68c23920cc227f )
{
    var_6b0364a106b77b84 = { #var_5da0c861642aa1e8:{ #type:var_cd68c23920cc227f.activity_type } };
    
    if ( function_9f94c5a87e6da54b( var_6b0364a106b77b84, self ) )
    {
        items = common_item::function_bc2f4857c90f5344( var_cd68c23920cc227f.var_40791919d3f24302, 1 );
        
        if ( isarray( items ) && isstring( items[ 0 ] ) )
        {
            itembundle = getscriptbundle( hashcat( %"itemspawnentry:", items[ 0 ] ) );
            
            if ( isdefined( itembundle ) )
            {
                callback::callback( "item_exfiled", { #lootid:common_item::function_6d15e119c2779a93( itembundle ) } );
            }
        }
    }
    
    callback::remove( "ob_exfil_success", &function_de8f5de2296c5596, 1 );
    callback::remove( "player_disconnect", &function_de8f5de2296c5596, 1 );
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 3
// Checksum 0x0, Offset: 0x2132
// Size: 0x11b, Type: bool
function function_7937b1cfc8818d50( player, activity_instance, reward_instance )
{
    activitytype = activity_instance.type;
    
    if ( !isdefined( activitytype ) )
    {
        return false;
    }
    
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( !isdefined( reward_instance ) || !isdefined( reward_instance.var_1fdcab615049aa6f ) )
    {
        return false;
    }
    
    if ( !isdefined( player.var_754fe06b68c0554b ) )
    {
        player.var_754fe06b68c0554b = [];
    }
    
    foreach ( schematic in player.var_754fe06b68c0554b )
    {
        if ( schematic == activitytype )
        {
            return false;
        }
    }
    
    quest = reward_instance.var_1fdcab615049aa6f[ activitytype ];
    
    if ( !isdefined( quest ) )
    {
        return false;
    }
    
    /#
        if ( getdvarint( @"hash_387419b90066e4b5", 0 ) )
        {
            if ( function_2ec9ca2251929c15( player, quest ) )
            {
                return true;
            }
        }
    #/
    
    if ( pmc_missions::function_c7d3c1cb4a3958cf( player, quest ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 2
// Checksum 0x0, Offset: 0x2256
// Size: 0x197, Type: bool
function function_9f94c5a87e6da54b( reward_instance, player )
{
    activitytype = reward_instance.var_5da0c861642aa1e8.type;
    var_919ba53f6defbc64 = [];
    missionid = "";
    
    if ( !isdefined( activitytype ) )
    {
        return false;
    }
    
    switch ( activitytype )
    {
        case #"hash_427820bb3395e2bf":
            var_919ba53f6defbc64[ 0 ] = 16965;
            var_919ba53f6defbc64[ 1 ] = 16970;
            missionid = 16643;
            break;
        case #"hash_5191681fd986c4eb":
            var_919ba53f6defbc64[ 0 ] = 16133;
            var_919ba53f6defbc64[ 1 ] = 16134;
            var_919ba53f6defbc64[ 2 ] = 16135;
            missionid = 14707;
            break;
        case #"hash_40d422a1ae5ecf0f":
            var_919ba53f6defbc64[ 0 ] = 17060;
            var_919ba53f6defbc64[ 1 ] = 17061;
            var_919ba53f6defbc64[ 2 ] = 17062;
            missionid = 17063;
            break;
        case #"hash_bcceffcc02978e65":
            var_919ba53f6defbc64[ 0 ] = 16636;
            var_919ba53f6defbc64[ 1 ] = 16950;
            var_919ba53f6defbc64[ 2 ] = 16951;
            missionid = 16644;
            break;
        case #"hash_b034a4d29df58c9a":
            var_919ba53f6defbc64[ 0 ] = 17066;
            var_919ba53f6defbc64[ 1 ] = 17067;
            var_919ba53f6defbc64[ 2 ] = 17068;
            missionid = 17069;
            break;
        case #"hash_17b1c4f2de901a59":
            var_919ba53f6defbc64[ 0 ] = 17087;
            var_919ba53f6defbc64[ 1 ] = 17088;
            missionid = 17089;
            break;
        default:
            return false;
    }
    
    /#
        if ( getdvarint( @"hash_387419b90066e4b5", 0 ) )
        {
            if ( function_534aa21626b78242( player, missionid, var_919ba53f6defbc64 ) )
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    #/
    
    if ( function_d97cb9fd43673c44( player, missionid, var_919ba53f6defbc64 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 2
// Checksum 0x0, Offset: 0x23f6
// Size: 0xa5
function function_864e6e1dfc3fa879( reward_instance, player )
{
    activitytype = reward_instance.var_5da0c861642aa1e8.type;
    
    if ( !isdefined( activitytype ) )
    {
        return;
    }
    
    if ( !isdefined( reward_instance ) || !isdefined( reward_instance.var_f031d67155304339 ) )
    {
        return;
    }
    
    if ( isdefined( reward_instance.var_f031d67155304339[ activitytype ] ) )
    {
        if ( !isdefined( player.var_754fe06b68c0554b ) )
        {
            player.var_754fe06b68c0554b = [];
        }
        
        player.var_754fe06b68c0554b[ player.var_754fe06b68c0554b.size ] = activitytype;
    }
    
    return reward_instance.var_f031d67155304339[ activitytype ];
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 3
// Checksum 0x0, Offset: 0x24a4
// Size: 0xbe, Type: bool
function function_d97cb9fd43673c44( player, challengeid, var_919ba53f6defbc64 )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_7c5a823345cc6183", 0 ) )
    {
        return true;
    }
    else if ( pmc_missions::function_c7d3c1cb4a3958cf( player, challengeid ) && !pmc_missions::function_62b41959b3c5a9ca( player, challengeid ) )
    {
        if ( isarray( var_919ba53f6defbc64 ) && var_919ba53f6defbc64.size > 0 )
        {
            foreach ( id in var_919ba53f6defbc64 )
            {
                if ( !pmc_missions::function_62b41959b3c5a9ca( player, id ) )
                {
                    return false;
                }
            }
            
            return true;
        }
        
        return true;
    }
    
    return false;
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 0
// Checksum 0x0, Offset: 0x256b
// Size: 0x124
function function_1b907bcbe2da5ad7()
{
    gamemodebundle = getgamemodescriptbundle();
    
    if ( isdefined( gamemodebundle ) && isdefined( self.difficulty_region ) )
    {
        if ( getdvarint( @"hash_dd47e07605565dd8", -1 ) >= 0 )
        {
            return percent_chance( getdvarint( @"hash_dd47e07605565dd8", -1 ) );
        }
        
        switch ( self.difficulty_region )
        {
            case #"hash_7bb2cd766703d463":
                if ( isdefined( gamemodebundle.var_e5501e76175e89d8 ) )
                {
                    return percent_chance( gamemodebundle.var_e5501e76175e89d8 );
                }
                
                break;
            case #"hash_af83e47edfa8900a":
                if ( isdefined( gamemodebundle.var_5aa095e9ecdb25e5 ) )
                {
                    return percent_chance( gamemodebundle.var_5aa095e9ecdb25e5 );
                }
                
                break;
            case #"hash_5343b465e56ec9a4":
                if ( isdefined( gamemodebundle.var_35605faa1dfd28f ) )
                {
                    return percent_chance( gamemodebundle.var_35605faa1dfd28f );
                }
                
                break;
            default:
                if ( isdefined( gamemodebundle.var_e5501e76175e89d8 ) )
                {
                    return percent_chance( gamemodebundle.var_e5501e76175e89d8 );
                }
                
                break;
        }
    }
    
    return 0;
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 1
// Checksum 0x0, Offset: 0x2698
// Size: 0x30e
function function_3ed651fb51ed438c( cache )
{
    if ( !isdefined( self.activity_instance ) )
    {
        return;
    }
    
    if ( !isdefined( self.difficulty_region ) )
    {
        self.difficulty_region = "";
    }
    
    activity_instance = self.activity_instance;
    
    if ( !isdefined( activity_instance.var_bfde552b90af5b08 ) )
    {
        activity_instance.var_bfde552b90af5b08 = 0;
        var_5154b3fd66de98e = 0;
        
        if ( getdvarint( @"ob_rift_run", 0 ) )
        {
            if ( getdvarint( @"hash_73cfb77eb49c943", 0 ) && isdefined( level.var_e345b15591192b73 ) )
            {
                if ( scripts\cp_mp\utility\game_utility::getmapname() == "mp_jup_sira" )
                {
                    var_5154b3fd66de98e = percent_chance( 65 );
                }
                else
                {
                    var_5154b3fd66de98e = 1;
                }
            }
        }
        
        if ( getdvarint( @"hash_1b407a4b5c4a3ec", 0 ) || getdvarint( @"hash_bc2abb9e5752e088", 0 ) || getdvarint( @"hash_1b405a4b5c49f86", 0 ) || getdvarint( @"hash_cc86ad6895d8aa2a", 0 ) )
        {
            return;
        }
        
        if ( function_1b907bcbe2da5ad7() || istrue( var_5154b3fd66de98e ) )
        {
            activity_instance.var_bfde552b90af5b08 = 1;
        }
        else
        {
            return;
        }
        
        activity_instance.schematicitems = [];
        
        if ( getdvarint( @"ob_rift_run", 0 ) )
        {
            if ( getdvarint( @"hash_73cfb77eb49c943", 0 ) && isdefined( level.var_e345b15591192b73 ) )
            {
                if ( scripts\cp_mp\utility\game_utility::getmapname() == "mp_jup_sira" )
                {
                    activity_instance.schematicitems = function_bc2f4857c90f5344( "ob_jup_items_contracts_riftrun_schematics_s2", 1 );
                }
                else
                {
                    switch ( level.var_e345b15591192b73 )
                    {
                        case 1:
                            activity_instance.schematicitems = [ "ob_jup_item_schematic_classified_dog_bone" ];
                            break;
                        case 2:
                            activity_instance.schematicitems = [ "ob_jup_item_schematic_classified_golden_armor_plate" ];
                            break;
                        case 3:
                            activity_instance.schematicitems = [ "ob_jup_item_schematic_classified_aetherblade" ];
                            break;
                        default:
                            break;
                    }
                }
            }
        }
        else
        {
            switch ( self.difficulty_region )
            {
                case #"hash_7bb2cd766703d463":
                    activity_instance.schematicitems = function_bc2f4857c90f5344( "ob_jup_items_reward_loot_schematic_green", 1 );
                    break;
                case #"hash_af83e47edfa8900a":
                    activity_instance.schematicitems = function_bc2f4857c90f5344( "ob_jup_items_reward_loot_schematic_yellow", 1 );
                    break;
                case #"hash_5343b465e56ec9a4":
                    activity_instance.schematicitems = function_bc2f4857c90f5344( "ob_jup_items_reward_loot_schematic_orange", 1 );
                    break;
                default:
                    activity_instance.schematicitems = function_bc2f4857c90f5344( "ob_jup_items_reward_loot_schematic_green", 1 );
                    break;
            }
        }
    }
    
    if ( istrue( activity_instance.var_bfde552b90af5b08 ) && isdefined( activity_instance.schematicitems ) )
    {
        common_cache::function_fd95ef820bb2b980( activity_instance.schematicitems, cache );
    }
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 1
// Checksum 0x0, Offset: 0x29ae
// Size: 0xe9
function function_d55d0e38986d17f3( cache )
{
    if ( !isdefined( self.activity_instance ) )
    {
        return;
    }
    
    activity_instance = self.activity_instance;
    var_f279996e2fdbdd12 = [];
    var_f279996e2fdbdd12 = array_add( var_f279996e2fdbdd12, "ob_jup_item_revive_self_revive" );
    var_c083bd8353c655c1 = namespace_4fda5d7358015a06::function_2dabe17056c2563f( activity_instance );
    
    if ( isdefined( var_c083bd8353c655c1 ) )
    {
        if ( is_equal( var_c083bd8353c655c1.size, 1 ) && !istrue( var_c083bd8353c655c1[ 0 ].var_3ecab5a58be77f0e ) )
        {
            var_c083bd8353c655c1[ 0 ].var_3ecab5a58be77f0e = 1;
            common_cache::function_fd95ef820bb2b980( var_f279996e2fdbdd12, cache );
            return;
        }
        
        foreach ( player in var_c083bd8353c655c1 )
        {
            player.var_3ecab5a58be77f0e = 1;
        }
    }
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 3
// Checksum 0x0, Offset: 0x2a9f
// Size: 0x17e
function function_b3c1e8c1d1b05b20( center_origin, n_radius, var_cd00b21daa6ae0b4 )
{
    var_f10d2bae0aa4fce7 = [];
    valid_points = [];
    var_5ac1024b00cecc71 = ( 0, 0, 48 );
    i = 0;
    
    while ( i < 360 )
    {
        x1 = n_radius * cos( i * 57.2958 );
        y1 = n_radius * sin( i * 57.2958 );
        check_pt = center_origin + ( x1, y1, 0 );
        pos_on_navmesh = getclosestpointonnavmesh( check_pt );
        
        if ( isdefined( pos_on_navmesh ) )
        {
            bsight = scripts\engine\trace::ray_trace_passed( center_origin + var_5ac1024b00cecc71, pos_on_navmesh + var_5ac1024b00cecc71, self.playerparticipants );
            
            if ( istrue( bsight ) )
            {
                valid_points[ valid_points.size ] = pos_on_navmesh;
            }
        }
        
        i += 20;
    }
    
    if ( is_equal( valid_points.size, 0 ) )
    {
        pos_on_navmesh = getclosestpointonnavmesh( center_origin );
        valid_points[ valid_points.size ] = pos_on_navmesh;
    }
    
    for ( i = 0; i < valid_points.size ; i++ )
    {
        s_spot = spawnstruct();
        s_spot.origin = valid_points[ i ];
        s_spot.angles = ( 0, 0, 0 );
        var_f10d2bae0aa4fce7[ var_f10d2bae0aa4fce7.size ] = s_spot;
    }
    
    if ( istrue( var_cd00b21daa6ae0b4 ) )
    {
        return var_f10d2bae0aa4fce7;
    }
    
    rand_index = randomintrange( 0, var_f10d2bae0aa4fce7.size );
    return var_f10d2bae0aa4fce7[ rand_index ];
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2c26
// Size: 0xa3
function private function_23b66008ea86e35c( var_b381b0883bcd4847 )
{
    if ( !istrue( function_bdd22095c4312f34( self ) ) || !isdefined( level.var_61a5fdd9ce50aa4a ) )
    {
        return;
    }
    
    var_571e8bd2c6ff9bf = function_c6bad126e3d76334();
    var_a8a21fdc220ea3d5 = function_7224bb7d017a588a();
    
    if ( !var_571e8bd2c6ff9bf && !var_a8a21fdc220ea3d5 && !isdefined( self.var_b90c26f642e9b96e ) )
    {
        return;
    }
    
    var_84fe3185d80d053b = function_208c5a28152e1218();
    var_b351958e76ad6ed1 = function_63be43d99c4aca4a();
    var_c083bd8353c655c1 = function_2dabe17056c2563f( self );
    [[ level.var_61a5fdd9ce50aa4a ]]( var_a8a21fdc220ea3d5, var_571e8bd2c6ff9bf, var_c083bd8353c655c1, var_84fe3185d80d053b, var_b351958e76ad6ed1 );
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2cd1
// Size: 0x35
function private function_208c5a28152e1218()
{
    var_84fe3185d80d053b = "";
    
    if ( isdefined( level.var_fac39a693f085779 ) )
    {
        var_84fe3185d80d053b = [[ level.var_fac39a693f085779 ]]( namespace_68dc261109a9503f::function_8988a4c89289d7f4( self ) );
    }
    
    return var_84fe3185d80d053b;
}

// Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2d0f
// Size: 0x1c
function private function_63be43d99c4aca4a()
{
    var_b351958e76ad6ed1 = namespace_4df2ab39b0e96ec7::get_region( namespace_68dc261109a9503f::function_8988a4c89289d7f4( self ) );
    return var_b351958e76ad6ed1;
}

/#

    // Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
    // Params 1
    // Checksum 0x0, Offset: 0x2d34
    // Size: 0x194, Type: dev
    function function_de2062aa7eaf5617( params )
    {
        wait 5;
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x356>" );
        scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:x372>", "<dev string:x39f>", &function_891f5abdda30f2cb, 1 );
        scripts\common\devgui::function_fe953f000498048f();
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x356>" );
        scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:x3b9>", "<dev string:x3e4>", &function_891f5abdda30f2cb, 1 );
        scripts\common\devgui::function_fe953f000498048f();
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x356>" );
        scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:x40f>", "<dev string:x43b>", &function_891f5abdda30f2cb, 1 );
        scripts\common\devgui::function_fe953f000498048f();
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x356>" );
        scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:x467>", "<dev string:x493>", &function_891f5abdda30f2cb, 1 );
        scripts\common\devgui::function_fe953f000498048f();
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x356>" );
        scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:x4bf>", "<dev string:x4e8>", &function_891f5abdda30f2cb, 1 );
        scripts\common\devgui::function_fe953f000498048f();
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x356>" );
        scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:x511>", "<dev string:x539>", &function_891f5abdda30f2cb, 1 );
        scripts\common\devgui::function_fe953f000498048f();
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x356>" );
        scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:x55c>", "<dev string:x576>", &function_891f5abdda30f2cb, 1 );
        scripts\common\devgui::function_fe953f000498048f();
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x356>" );
        scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:x595>", "<dev string:x5c2>", &function_891f5abdda30f2cb, 1 );
        scripts\common\devgui::function_fe953f000498048f();
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x356>" );
        scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:x5e7>", "<dev string:x61a>", &function_891f5abdda30f2cb, 1 );
        scripts\common\devgui::function_fe953f000498048f();
    }

    // Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
    // Params 1
    // Checksum 0x0, Offset: 0x2ed0
    // Size: 0x256, Type: dev
    function function_891f5abdda30f2cb( params )
    {
        var_317e5132733169cb = getclosestpointonnavmesh( ( level.players[ 0 ].origin[ 0 ], level.players[ 0 ].origin[ 1 ], level.players[ 0 ].origin[ 2 ] ) );
        use_offset = 0;
        
        if ( is_equal( params[ 0 ], "<dev string:x64c>" ) )
        {
            use_offset = 1;
        }
        else if ( is_equal( params[ 0 ], "<dev string:x65a>" ) )
        {
            use_offset = 1;
            var_11eb9d2d65d00180 = getdvarint( @"hash_eff5e2218caf8354", 0 );
            setdvar( @"hash_eff5e2218caf8354", 1 );
        }
        else
        {
            var_317e5132733169cb = getclosestpointonnavmesh( ( level.players[ 0 ].origin[ 0 ] + 64, level.players[ 0 ].origin[ 1 ] + 64, level.players[ 0 ].origin[ 2 ] ) );
        }
        
        spawn_point = level.players[ 0 ].origin;
        
        if ( isdefined( var_317e5132733169cb ) )
        {
            spawn_point = var_317e5132733169cb;
        }
        
        a_players = level.players;
        difficulty_region = "<dev string:x675>";
        
        if ( is_equal( params[ 0 ], "<dev string:x679>" ) )
        {
            spawn_point += ( 600, 0, 0 );
        }
        else if ( is_equal( params[ 0 ], "<dev string:x681>" ) )
        {
            a_players = array_remove( a_players, level.players[ 0 ] );
        }
        else if ( isdefined( params[ 0 ] ) )
        {
            difficulty_region = params[ 0 ];
        }
        
        if ( is_equal( difficulty_region, "<dev string:x675>" ) )
        {
            if ( isdefined( level.var_fac39a693f085779 ) )
            {
                difficulty_region = [[ level.var_fac39a693f085779 ]]( spawn_point );
            }
        }
        
        var_b351958e76ad6ed1 = "<dev string:x675>";
        var_b351958e76ad6ed1 = namespace_4df2ab39b0e96ec7::get_region( spawn_point );
        function_4318321c0172ec43( 0, 1, a_players, difficulty_region, var_b351958e76ad6ed1 );
        function_35a0497a05c5f84( a_players, difficulty_region, var_b351958e76ad6ed1, spawn_point, level.players[ 0 ].angles, use_offset );
        
        if ( is_equal( params[ 0 ], "<dev string:x65a>" ) )
        {
            setdvar( @"hash_eff5e2218caf8354", var_11eb9d2d65d00180 );
        }
    }

    // Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
    // Params 6
    // Checksum 0x0, Offset: 0x312e
    // Size: 0x11d, Type: dev
    function function_35a0497a05c5f84( a_players, difficulty_region, reward_region, spawn_point, spawn_angles, use_offset )
    {
        reward_groups = [];
        
        foreach ( player in a_players )
        {
            reward_groups[ reward_groups.size ] = [ player ];
        }
        
        placement_struct = namespace_71ca15b739deab72::function_3ae7f99339b96499( spawn_point, use_offset );
        lootfunc = &function_7ca191e9301a4a83;
        var_5812163a4b6704c8 = { #reward_region:reward_region, #difficulty_region:difficulty_region };
        reward_instance = spawnstruct();
        reward_instance.placement_struct = placement_struct;
        reward_instance.playerparticipants = level.players;
        reward_instance thread reward_explosion();
        function_863be9e39e19fe2f( reward_groups, placement_struct, lootfunc, var_5812163a4b6704c8 );
    }

    // Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
    // Params 1
    // Checksum 0x0, Offset: 0x3253
    // Size: 0xd9, Type: dev
    function function_7ca191e9301a4a83( var_5812163a4b6704c8 )
    {
        difficulty_region = var_5812163a4b6704c8.difficulty_region;
        reward_region = var_5812163a4b6704c8.reward_region;
        reward_group = var_5812163a4b6704c8.reward_group;
        reward_instance = spawnstruct();
        reward_instance.difficulty_region = difficulty_region;
        reward_instance.reward_region = reward_region;
        reward_instance.reward_group = reward_group;
        reward_instance.activity_instance = spawnstruct();
        reward_instance.activity_instance.playerparticipants = level.players;
        cache = spawnstruct();
        reward_instance namespace_e8853d3344e33cf6::function_d67ffd8ae22bf637( cache );
        return cache.contents;
    }

    // Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
    // Params 1
    // Checksum 0x0, Offset: 0x3334
    // Size: 0x1de, Type: dev
    function function_cdffe21a96903d57( params )
    {
        function_9a56442a0d3e18f();
        
        foreach ( player in level.players )
        {
            if ( player.name == params[ 1 ] )
            {
                if ( params[ 0 ] == "<dev string:x68d>" )
                {
                    iprintlnbold( "<dev string:x695>" + player.name + "<dev string:x6a1>" );
                    player.var_35e979f919589ba3.var_351b70af7ba3f2[ 0 ].completed = 1;
                    player.var_35e979f919589ba3.var_351b70af7ba3f2[ 1 ].completed = 1;
                    player.var_35e979f919589ba3.var_351b70af7ba3f2[ 2 ].completed = 1;
                    player.var_35e979f919589ba3.var_351b70af7ba3f2[ 3 ].completed = 0;
                    continue;
                }
                
                iprintlnbold( "<dev string:x695>" + player.name + "<dev string:x6bf>" );
                player.var_35e979f919589ba3.var_351b70af7ba3f2[ 0 ].completed = 0;
                player.var_35e979f919589ba3.var_351b70af7ba3f2[ 1 ].completed = 0;
                player.var_35e979f919589ba3.var_351b70af7ba3f2[ 2 ].completed = 0;
                player.var_35e979f919589ba3.var_351b70af7ba3f2[ 3 ].completed = 0;
            }
        }
    }

    // Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
    // Params 3
    // Checksum 0x0, Offset: 0x351a
    // Size: 0xc2, Type: dev
    function function_534aa21626b78242( player, challengeid, var_919ba53f6defbc64 )
    {
        if ( !isplayer( player ) )
        {
            return 0;
        }
        
        if ( getdvarint( @"hash_7c5a823345cc6183", 0 ) )
        {
            return 1;
        }
        else if ( function_2ec9ca2251929c15( player, challengeid ) && !function_8dbce1bc41af1b64( player, challengeid ) )
        {
            if ( isarray( var_919ba53f6defbc64 ) && var_919ba53f6defbc64.size > 0 )
            {
                foreach ( id in var_919ba53f6defbc64 )
                {
                    if ( !function_8dbce1bc41af1b64( player, id ) )
                    {
                        return 0;
                    }
                }
                
                return 1;
            }
            
            return 1;
        }
        
        return 0;
    }

    // Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
    // Params 2
    // Checksum 0x0, Offset: 0x35e4
    // Size: 0xe0, Type: dev
    function function_2ec9ca2251929c15( player, challengeid )
    {
        if ( !isdefined( challengeid ) )
        {
            return 0;
        }
        
        for ( missionindex = 0; missionindex < 3 ; missionindex++ )
        {
            challenge = player.var_35e979f919589ba3.mainmission;
            
            if ( isdefined( challenge ) && challenge > 0 && challenge == challengeid )
            {
                return 1;
            }
            
            if ( isdefined( challenge ) && challenge > 0 )
            {
                for ( childindex = 0; childindex < player.var_35e979f919589ba3.var_351b70af7ba3f2.size ; childindex++ )
                {
                    child = player.var_35e979f919589ba3.var_351b70af7ba3f2[ childindex ];
                    
                    if ( isdefined( child ) && child.mission == challengeid )
                    {
                        return 1;
                    }
                }
            }
        }
        
        return 0;
    }

    // Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
    // Params 2
    // Checksum 0x0, Offset: 0x36cc
    // Size: 0xd0, Type: dev
    function function_8dbce1bc41af1b64( player, challengeid )
    {
        for ( missionindex = 0; missionindex < 3 ; missionindex++ )
        {
            challenge = player.var_35e979f919589ba3.mainmission;
            
            if ( !isdefined( challenge ) || challenge <= 0 )
            {
                continue;
            }
            
            for ( childindex = 0; childindex < player.var_35e979f919589ba3.var_351b70af7ba3f2.size ; childindex++ )
            {
                child = player.var_35e979f919589ba3.var_351b70af7ba3f2[ childindex ];
                
                if ( isdefined( child ) && child.mission == challengeid )
                {
                    return child.completed;
                }
            }
        }
        
        return 0;
    }

    // Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
    // Params 0
    // Checksum 0x0, Offset: 0x37a4
    // Size: 0x24f, Type: dev
    function function_9a56442a0d3e18f()
    {
        foreach ( player in level.players )
        {
            iprintlnbold( "<dev string:x695>" + player.name + "<dev string:x6df>" );
            player.var_35e979f919589ba3 = spawnstruct();
            player.var_35e979f919589ba3.mainmission = 16132;
            player.var_35e979f919589ba3.var_351b70af7ba3f2 = [];
            player.var_35e979f919589ba3.var_351b70af7ba3f2[ 0 ] = spawnstruct();
            player.var_35e979f919589ba3.var_351b70af7ba3f2[ 0 ].mission = 16133;
            player.var_35e979f919589ba3.var_351b70af7ba3f2[ 0 ].completed = 1;
            player.var_35e979f919589ba3.var_351b70af7ba3f2[ 1 ] = spawnstruct();
            player.var_35e979f919589ba3.var_351b70af7ba3f2[ 1 ].mission = 16134;
            player.var_35e979f919589ba3.var_351b70af7ba3f2[ 1 ].completed = 1;
            player.var_35e979f919589ba3.var_351b70af7ba3f2[ 2 ] = spawnstruct();
            player.var_35e979f919589ba3.var_351b70af7ba3f2[ 2 ].mission = 16135;
            player.var_35e979f919589ba3.var_351b70af7ba3f2[ 2 ].completed = 1;
            player.var_35e979f919589ba3.var_351b70af7ba3f2[ 3 ] = spawnstruct();
            player.var_35e979f919589ba3.var_351b70af7ba3f2[ 3 ].mission = 14707;
            player.var_35e979f919589ba3.var_351b70af7ba3f2[ 3 ].completed = 0;
        }
    }

    // Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
    // Params 0
    // Checksum 0x0, Offset: 0x39fb
    // Size: 0x9f, Type: dev
    function function_cdd311c6e43e2ca3()
    {
        if ( getdvarint( @"hash_387419b90066e4b5", 0 ) )
        {
            wait 6;
            scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x701>" );
            scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:x724>" + self.name, "<dev string:x73b>" + self.name, &function_cdffe21a96903d57, 1 );
            scripts\common\devgui::function_fe953f000498048f();
            scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x701>" );
            scripts\common\devgui::function_b23a59dfb4ca49a1( "<dev string:x762>" + self.name, "<dev string:x77b>" + self.name, &function_cdffe21a96903d57, 1 );
            scripts\common\devgui::function_fe953f000498048f();
            function_9a56442a0d3e18f();
        }
    }

    // Namespace ob_objective_rewards / namespace_e8853d3344e33cf6
    // Params 1
    // Checksum 0x0, Offset: 0x3aa2
    // Size: 0x1d, Type: dev
    function function_ac138c84c0432491( params )
    {
        self endon( "<dev string:x7a3>" );
        thread function_cdd311c6e43e2ca3();
    }

#/
