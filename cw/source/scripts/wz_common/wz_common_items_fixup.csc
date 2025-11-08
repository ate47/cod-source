#using script_644007a8c3885fc;
#using scripts\core_common\item_world_fixup;

#namespace wz_common_items_fixup;

// Namespace wz_common_items_fixup/wz_common_items_fixup
// Params 0, eflags: 0x1
// Checksum 0xc883ebd3, Offset: 0xe0
// Size: 0x14
function autoexec function_88ff61e0()
{
    thread function_45a212c0();
}

// Namespace wz_common_items_fixup/wz_common_items_fixup
// Params 2, eflags: 0x4
// Checksum 0x2076769d, Offset: 0x100
// Size: 0x64
function private function_9d16c83( var_705ed3b9, item_name )
{
    if ( !is_true( getgametypesetting( var_705ed3b9 ) ) )
    {
        namespace_1c7b37c6::item_remover( &item_world_fixup::remove_item, item_name );
    }
}

// Namespace wz_common_items_fixup/wz_common_items_fixup
// Params 0
// Checksum 0xd548d8ed, Offset: 0x170
// Size: 0x5b4
function function_45a212c0()
{
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    maxteamplayers = isdefined( getgametypesetting( #"maxteamplayers" ) ) ? getgametypesetting( #"maxteamplayers" ) : 1;
    var_77c6811d = 1;
    
    if ( var_77c6811d )
    {
        while ( !function_82a4c7da() && var_77c6811d )
        {
            waitframe( 1 );
            function_205a8326( "game mode is invalid." );
        }
    }
    else if ( !function_82a4c7da() )
    {
        function_205a8326( "game mode is invalid. Warning... being ignored!" );
    }
    
    function_9d16c83( #"hash_2a36e8fb9a5428", #"self_revive_item_t9" );
    function_9d16c83( #"hash_4e22aa47e19259c0", #"radiation_vest_item_t9" );
    function_9d16c83( #"hash_61b5f6d8ac7d7a19", #"armor_pouch_item_t9" );
    function_9d16c83( #"hash_30ff0bec6c65ec06", #"armor_shard_item_t9" );
    function_9d16c83( #"hash_13e19a5373c4f4e7", #"scorestreak_artillery_strike_t9_item" );
    function_9d16c83( #"hash_557259356784fdd7", #"scorestreak_chopper_gunner_t9_item" );
    function_9d16c83( #"hash_38c8b1792c0d250a", #"scorestreak_controllable_missile_t9_item" );
    function_9d16c83( #"hash_12a74d91c8b0d742", #"scorestreak_cuav_t9_item" );
    function_9d16c83( #"hash_e73a7c07468431a", #"scorestreak_death_machine_t9_item" );
    function_9d16c83( #"hash_4d0da8ca56b9422c", #"scorestreak_explosive_bow_t9_item" );
    function_9d16c83( #"hash_7d9da9c9c1f3d293", #"scorestreak_flamethrower_t9_item" );
    function_9d16c83( #"hash_421b5f8cbf87ff4d", #"scorestreak_grenade_launcher_t9_item" );
    function_9d16c83( #"hash_8da9676b8f347c3", #"scorestreak_gunship_t9_item" );
    function_9d16c83( #"hash_4801a96e69d82a91", #"scorestreak_hand_cannon_t9_item" );
    function_9d16c83( #"hash_23549b4406d700e4", #"scorestreak_harp_t9_item" );
    function_9d16c83( #"hash_680849fd1b676cfb", #"hash_52ee32e14c642494" );
    function_9d16c83( #"hash_b8c05f2c978058", #"scorestreak_hover_jet_t9_item" );
    function_9d16c83( #"hash_7b9a6ba194492507", #"scorestreak_jet_fighter_sweep_t9_item" );
    function_9d16c83( #"hash_550b9e9e19eabf76", #"scorestreak_light_attack_chopper_t9_item" );
    function_9d16c83( #"hash_78f80d4486f80e36", #"scorestreak_napalm_strike_t9_item" );
    function_9d16c83( #"hash_4a1459147fde288a", #"scorestreak_rcxd_t9_item" );
    function_9d16c83( #"hash_54cfe5e7905e4b20", #"scorestreak_sentry_turret_t9_item" );
    function_9d16c83( #"hash_4a530732c9cd1e9d", #"scorestreak_strafing_plane_t9_item" );
    function_9d16c83( #"hash_41b88c5d0b67b1cb", #"scorestreak_uav_t9_item" );
}

// Namespace wz_common_items_fixup/wz_common_items_fixup
// Params 2, eflags: 0x4
// Checksum 0x4708049a, Offset: 0x730
// Size: 0x74
function private function_205a8326( msg, var_9fb99f62 )
{
    /#
        if ( isdefined( var_9fb99f62 ) )
        {
            println( "<dev string:x38>" + msg + "<dev string:x50>" + var_9fb99f62 );
            return;
        }
        
        println( "<dev string:x38>" + msg );
    #/
}

