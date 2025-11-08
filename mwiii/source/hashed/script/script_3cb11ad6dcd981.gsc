#using scripts\common\utility;
#using scripts\cp_mp\loot\common_item;
#using scripts\engine\utility;

#namespace namespace_426352158e3bb03b;

// Namespace namespace_426352158e3bb03b / namespace_c6e4bfb3d36af9bb
// Params 0
// Checksum 0x0, Offset: 0xa9
// Size: 0x1d
function function_2f94630a18a17ba2()
{
    function_900f562c61c6a5d6( "quest", &use_quest, &function_77bdd59fee5b0489, &function_77bdd59fee5b0489 );
}

// Namespace namespace_426352158e3bb03b / namespace_c6e4bfb3d36af9bb
// Params 4
// Checksum 0x0, Offset: 0xce
// Size: 0x25, Type: bool
function function_77bdd59fee5b0489( itembundle, item, auto_use, var_18fc734ec7194ede )
{
    return true;
}

// Namespace namespace_426352158e3bb03b / namespace_c6e4bfb3d36af9bb
// Params 3
// Checksum 0x0, Offset: 0xfc
// Size: 0x1c, Type: bool
function use_quest( itembundle, item, auto_use )
{
    return false;
}

