#using script_57bdd8aff28a4717;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_item;
#using scripts\engine\utility;
#using scripts\mp\utility\teams;

#namespace namespace_8af2bc2591598d10;

// Namespace namespace_8af2bc2591598d10 / namespace_ebe7d16f291f5dc4
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x11a
// Size: 0x4d
function private function_b1c0de32a8385673( player, var_f877158dac9d9e99, var_2536710f0f1f411a, isdebug )
{
    itembundlename = istrue( var_2536710f0f1f411a ) ? "ob_jup_item_key_rift_gate_season3_giraffe_attuned" : "ob_jup_item_key_rift_gate_season3_giraffe";
    namespace_fc89f9b99b72df11::function_9426e2a8c6789b97( player, var_f877158dac9d9e99, itembundlename, 1 );
}

