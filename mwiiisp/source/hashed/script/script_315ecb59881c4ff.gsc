#using scripts\common\utility;
#using scripts\cp\cp_hud_message;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;

#namespace namespace_d411239fd629cf92;

// Namespace namespace_d411239fd629cf92 / namespace_4a3cae8a354ac02f
// Params 0
// Checksum 0x0, Offset: 0xf6
// Size: 0x2e
function init()
{
    scripts\engine\utility::registersharedfunc( "cluster_spike", "munitionUsed", &function_fe25039b3e24f942 );
    scripts\engine\utility::registersharedfunc( "cluster_spike", "lifetimeOverride", &function_12f3623076efb2e9 );
}

// Namespace namespace_d411239fd629cf92 / namespace_4a3cae8a354ac02f
// Params 0
// Checksum 0x0, Offset: 0x12c
// Size: 0x75
function function_fe25039b3e24f942()
{
    self notify( "munitions_used", "cluster_spike" );
    
    foreach ( player in level.players )
    {
        player thread scripts\cp\cp_hud_message::showsplash( "used_cluster_spike", undefined, self );
    }
    
    scripts\cp\utility::function_98f7ca3781dac77c( self, "cluster_spike" );
}

// Namespace namespace_d411239fd629cf92 / namespace_4a3cae8a354ac02f
// Params 0
// Checksum 0x0, Offset: 0x1a9
// Size: 0x4
function function_12f3623076efb2e9()
{
    return 180;
}

