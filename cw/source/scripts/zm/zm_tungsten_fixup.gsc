#using script_2a30ac7aa0ee8988;
#using scripts\core_common\item_world_fixup;

#namespace namespace_d5db95b4;

// Namespace namespace_d5db95b4/namespace_d5db95b4
// Params 0, eflags: 0x1
// Checksum 0x3309af91, Offset: 0x90
// Size: 0x14
function autoexec __init__()
{
    function_c70f8122();
}

// Namespace namespace_d5db95b4/namespace_d5db95b4
// Params 0
// Checksum 0xfaea6f78, Offset: 0xb0
// Size: 0x184
function function_c70f8122()
{
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    var_edfbccd0 = &item_world_fixup::function_e70fa91c;
    namespace_1c7b37c6::item_replacer( var_f8a4c541, #"zm_magicbox_weapon_named_weapons", #"zm_magicbox_tungsten_named_weapons" );
    namespace_1c7b37c6::item_replacer( var_f8a4c541, #"zm_magicbox_scorestreak_list", #"zm_magicbox_tungsten_scorestreak_list" );
    namespace_1c7b37c6::item_replacer( var_f8a4c541, #"level_6_gun_list", #"level_6_gun_list_zm_tungsten" );
    namespace_1c7b37c6::item_replacer( var_f8a4c541, #"named_gun_list", #"named_gun_list_zm_tungsten" );
    namespace_1c7b37c6::item_replacer( var_f8a4c541, #"ltm_halloween_chest_wonder_weapons", #"ltm_halloween_chest_wonder_weapons_tungsten" );
    namespace_1c7b37c6::item_replacer( var_74257310, #"ww_ray_rifle_t9_item_sr", #"ray_gun_item_sr" );
}

