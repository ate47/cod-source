#using script_2a30ac7aa0ee8988;
#using scripts\core_common\item_world_fixup;

#namespace namespace_9be0edfa;

// Namespace namespace_9be0edfa/namespace_9be0edfa
// Params 0, eflags: 0x1
// Checksum 0x17f9e12b, Offset: 0xa0
// Size: 0x14
function autoexec __init__()
{
    function_a1302aca();
}

// Namespace namespace_9be0edfa/namespace_9be0edfa
// Params 0
// Checksum 0xd8caeee6, Offset: 0xc0
// Size: 0x1b4
function function_a1302aca()
{
    var_87d0eef8 = &item_world_fixup::remove_item;
    var_74257310 = &item_world_fixup::add_item_replacement;
    var_f8a4c541 = &item_world_fixup::function_6991057;
    var_edfbccd0 = &item_world_fixup::function_e70fa91c;
    namespace_1c7b37c6::item_replacer( var_f8a4c541, #"zm_magicbox_weapon_named_weapons", #"zm_magicbox_silver_named_weapons" );
    namespace_1c7b37c6::item_replacer( var_f8a4c541, #"level_6_gun_list", #"level_6_gun_list_zm_silver" );
    namespace_1c7b37c6::item_replacer( var_f8a4c541, #"named_gun_list", #"named_gun_list_zm_silver" );
    namespace_1c7b37c6::item_replacer( var_f8a4c541, #"ltm_halloween_chest_wonder_weapons", #"ltm_halloween_chest_wonder_weapons_silver" );
    namespace_1c7b37c6::item_replacer( var_74257310, #"ww_ray_rifle_t9_item_sr", #"ray_gun_item_sr" );
    
    if ( getdvarstring( #"g_gametype" ) === "zcranked" )
    {
        namespace_1c7b37c6::item_replacer( var_f8a4c541, #"zm_equipment_list", #"zm_equipment_list_cranked_hard" );
    }
}

