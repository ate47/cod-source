#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\zombie_perks;

#namespace namespace_ab72fb42cd326323;

// Namespace namespace_ab72fb42cd326323 / namespace_abc8365716fb73a3
// Params 0
// Checksum 0x0, Offset: 0xa0
// Size: 0x3e
function function_4113bac1fcc24f04()
{
    if ( isdefined( level.var_435b6cca8be74d31 ) )
    {
        [[ level.var_435b6cca8be74d31 ]]();
        return;
    }
    
    function_900f562c61c6a5d6( "perk", &use_perk, &function_60a287a143186571, &can_use_perk, &function_aac0b757b5a813f6 );
}

// Namespace namespace_ab72fb42cd326323 / namespace_abc8365716fb73a3
// Params 2
// Checksum 0x0, Offset: 0xe6
// Size: 0x8f
function use_perk( itembundle, item )
{
    usedperk = 0;
    
    if ( !istrue( item.fromcache ) )
    {
        usedperk = grab_and_use_perk( itembundle.ref );
    }
    else if ( !has_perk( itembundle.ref ) )
    {
        give_perk( itembundle.ref, 1 );
        usedperk = 1;
    }
    
    if ( usedperk )
    {
        return ( item.count - 1 );
    }
    
    return item.count;
}

// Namespace namespace_ab72fb42cd326323 / namespace_abc8365716fb73a3
// Params 4
// Checksum 0x0, Offset: 0x17e
// Size: 0x24, Type: bool
function function_60a287a143186571( itembundle, item, autouse, allowswap )
{
    return false;
}

// Namespace namespace_ab72fb42cd326323 / namespace_abc8365716fb73a3
// Params 4
// Checksum 0x0, Offset: 0x1ab
// Size: 0x35, Type: bool
function can_use_perk( itembundle, item, autouse, allowswap )
{
    return !has_perk( itembundle.ref );
}

// Namespace namespace_ab72fb42cd326323 / namespace_abc8365716fb73a3
// Params 0
// Checksum 0x0, Offset: 0x1e9
// Size: 0x25
function function_aac0b757b5a813f6()
{
    itembundle = undefined;
    quantity = 0;
    return [ itembundle, quantity ];
}

