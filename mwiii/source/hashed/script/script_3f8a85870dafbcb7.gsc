#using script_41387eecc35b88bf;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\overlord;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\gamescore;

#namespace namespace_fdfa10f30c513cd7;

// Namespace namespace_fdfa10f30c513cd7 / namespace_20af609e7a544b57
// Params 0
// Checksum 0x0, Offset: 0x398
// Size: 0x94
function init()
{
    if ( !getdvarint( @"hash_464559793bf93309", 1 ) )
    {
        return;
    }
    
    level callback::add( "player_item_pickup", &on_item_pickup );
    level callback::add( "player_used_item", &function_94545a9bb0878e0e );
    level callback::add( "player_item_drop", &function_8cd3ce612122fbab );
    level callback::add( "on_ammo_pouch_drop", &on_ammo_pouch_drop );
    level callback::add( "currency_add", &function_9e622ced1b338442 );
    level callback::add( "zm_packed_weapon", &function_c5444b570959132e );
    level callback::add( "on_armor_break", &on_armor_break );
}

// Namespace namespace_fdfa10f30c513cd7 / namespace_20af609e7a544b57
// Params 1
// Checksum 0x0, Offset: 0x434
// Size: 0x21
function on_armor_break( params )
{
    if ( isplayer( self ) )
    {
        thread function_dc000c302e305ce0( "ravenov_tutorial_armor_broken" );
    }
}

// Namespace namespace_fdfa10f30c513cd7 / namespace_20af609e7a544b57
// Params 1
// Checksum 0x0, Offset: 0x45d
// Size: 0x24
function function_c5444b570959132e( params )
{
    ent_flag_set( "pap_weapon" );
    thread function_dc000c302e305ce0( "ravenov_tutorial_ready_for_higher_zone" );
}

// Namespace namespace_fdfa10f30c513cd7 / namespace_20af609e7a544b57
// Params 1
// Checksum 0x0, Offset: 0x489
// Size: 0x6d
function function_8cd3ce612122fbab( params )
{
    if ( isdefined( params.itembundle ) && isdefined( params.itembundle.subtype ) )
    {
        switch ( params.itembundle.subtype )
        {
            case #"hash_8499464a48c4e157":
                thread function_dc000c302e305ce0( "ravenov_tutorial_sell_junk" );
                break;
        }
    }
}

// Namespace namespace_fdfa10f30c513cd7 / namespace_20af609e7a544b57
// Params 1
// Checksum 0x0, Offset: 0x4fe
// Size: 0x11f
function on_item_pickup( params )
{
    if ( isdefined( params.itembundle.type ) )
    {
        switch ( params.itembundle.type )
        {
            case #"hash_c04d8180feb92b2b":
                if ( !function_74fec185b50d1b4a( "ravenov_tutorial_rucksack_upgrade_use" ) )
                {
                    thread function_dc000c302e305ce0( "ravenov_tutorial_rucksack_upgrade_collect" );
                }
                
                break;
            case #"hash_ab671284a3fc4e3d":
                if ( !function_74fec185b50d1b4a( "ravenov_tutorial_perk_can_use" ) )
                {
                    thread function_dc000c302e305ce0( "ravenov_tutorial_perk_can_collect" );
                }
                
                break;
            case #"hash_d80af4621c199350":
                if ( !function_74fec185b50d1b4a( "ravenov_tutorial_armor_upgrade_use" ) )
                {
                    thread function_dc000c302e305ce0( "ravenov_tutorial_armor_upgrade_collect" );
                }
                
                break;
        }
    }
    
    if ( isdefined( params.itembundle.subtype ) )
    {
        switch ( params.itembundle.subtype )
        {
            case #"hash_1780867e105363ce":
                if ( !function_74fec185b50d1b4a( "ravenov_tutorial_aether_tool_use" ) )
                {
                    thread function_dc000c302e305ce0( "ravenov_tutorial_aether_tool_collect" );
                }
                
                break;
        }
    }
}

// Namespace namespace_fdfa10f30c513cd7 / namespace_20af609e7a544b57
// Params 1
// Checksum 0x0, Offset: 0x625
// Size: 0xef
function function_94545a9bb0878e0e( params )
{
    if ( isdefined( params.itembundle.type ) )
    {
        switch ( params.itembundle.type )
        {
            case #"hash_c04d8180feb92b2b":
                function_dc000c302e305ce0( "ravenov_tutorial_rucksack_upgrade_use" );
                break;
            case #"hash_ab671284a3fc4e3d":
                function_dc000c302e305ce0( "ravenov_tutorial_perk_can_use" );
                break;
            case #"hash_d80af4621c199350":
                function_dc000c302e305ce0( "ravenov_tutorial_armor_upgrade_use" );
                break;
        }
    }
    
    if ( isdefined( params.itembundle.subtype ) )
    {
        switch ( params.itembundle.subtype )
        {
            case #"hash_1780867e105363ce":
                function_dc000c302e305ce0( "ravenov_tutorial_aether_tool_collect" );
                function_dc000c302e305ce0( "ravenov_tutorial_aether_tool_use" );
                break;
        }
    }
}

// Namespace namespace_fdfa10f30c513cd7 / namespace_20af609e7a544b57
// Params 1
// Checksum 0x0, Offset: 0x71c
// Size: 0x36
function on_ammo_pouch_drop( params )
{
    if ( isplayer( params.eattacker ) )
    {
        params.eattacker thread function_dc000c302e305ce0( "ravenov_tutorial_ammo_pouch" );
    }
}

// Namespace namespace_fdfa10f30c513cd7 / namespace_20af609e7a544b57
// Params 1
// Checksum 0x0, Offset: 0x75a
// Size: 0x42
function function_9e622ced1b338442( params )
{
    if ( ent_flag( "pap_weapon" ) )
    {
        return;
    }
    
    var_473e4d7cccb6d00a = scripts\mp\gamescore::_getplayerscore( self );
    
    if ( var_473e4d7cccb6d00a >= 5000 )
    {
        thread function_dc000c302e305ce0( "ravenov_tutorial_pap" );
    }
}

// Namespace namespace_fdfa10f30c513cd7 / namespace_20af609e7a544b57
// Params 1
// Checksum 0x0, Offset: 0x7a4
// Size: 0x81
function function_dc000c302e305ce0( str_conversation )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_6860664202c177f4 ) )
    {
        self.var_6860664202c177f4 = [];
    }
    
    if ( !function_74fec185b50d1b4a( str_conversation ) || getdvarint( @"hash_ac3a05ba7d5a924c", 0 ) )
    {
        self.var_6860664202c177f4[ str_conversation ] = 1;
        self setplayerdata( level.progressiongroup, "conversation_" + str_conversation, 1 );
        overlord::playconversation( str_conversation, [ self ], undefined, 0 );
    }
}

// Namespace namespace_fdfa10f30c513cd7 / namespace_20af609e7a544b57
// Params 1
// Checksum 0x0, Offset: 0x82d
// Size: 0x61
function function_74fec185b50d1b4a( str_conversation )
{
    if ( !isplayer( self ) )
    {
        return 1;
    }
    
    if ( !isdefined( self.var_6860664202c177f4 ) )
    {
        self.var_6860664202c177f4 = [];
    }
    
    b_played_vo = self getplayerdata( level.progressiongroup, "conversation_" + str_conversation ) || istrue( self.var_6860664202c177f4[ str_conversation ] );
    return b_played_vo;
}

