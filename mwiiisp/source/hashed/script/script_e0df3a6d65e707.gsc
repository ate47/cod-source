#using scripts\cp\interaction;
#using scripts\cp\loot_system;
#using scripts\cp_mp\pickups;

#namespace namespace_caa7fcde280d1fbe;

// Namespace namespace_caa7fcde280d1fbe / namespace_cae8a9a25549b193
// Params 0
// Checksum 0x0, Offset: 0xeb
// Size: 0x1d
function main()
{
    scripts\cp\interaction::registerinteraction( "interact_armorsatchel", &function_7bf49b03aa95ddea, &function_b3c237b9f09304f6, &function_4d53102050b02de5 );
}

// Namespace namespace_caa7fcde280d1fbe / namespace_cae8a9a25549b193
// Params 2
// Checksum 0x0, Offset: 0x110
// Size: 0x2c
function function_7bf49b03aa95ddea( interaction, player )
{
    if ( player scripts\cp_mp\pickups::hasplatepouch() )
    {
        return &"COOP_GAME_PLAY/ALREADY_HAVE_ARMOR_SATCHEL";
    }
    
    return &"COOP_GAME_PLAY/ARMOR_SATCHEL";
}

// Namespace namespace_caa7fcde280d1fbe / namespace_cae8a9a25549b193
// Params 2
// Checksum 0x0, Offset: 0x144
// Size: 0x31
function function_b3c237b9f09304f6( interaction, player )
{
    scripts\cp\loot_system::function_46a2b7d2ad2bdc13( interaction, player );
    
    if ( istrue( level.var_b17f3dc7c65b1860 ) )
    {
        scripts\cp\interaction::remove_from_current_interaction_list( interaction );
    }
}

// Namespace namespace_caa7fcde280d1fbe / namespace_cae8a9a25549b193
// Params 1
// Checksum 0x0, Offset: 0x17d
// Size: 0x37
function function_4d53102050b02de5( interaction_structs )
{
    for ( i = 0; i < interaction_structs.size ; i++ )
    {
        interaction_structs[ i ].armor_satchel = "armor_satchel";
    }
}

