#using script_54e6d1e4fb728cb8;
#using scripts\engine\utility;

#namespace namespace_15b61b6788c29fd2;

// Namespace namespace_15b61b6788c29fd2 / namespace_6a577d053271961d
// Params 1
// Checksum 0x0, Offset: 0x14a
// Size: 0x26
function function_9e3f4898db5d314e( callback )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "enemy_on_compass" );
    self [[ callback ]]();
}

// Namespace namespace_15b61b6788c29fd2 / namespace_6a577d053271961d
// Params 3
// Checksum 0x0, Offset: 0x178
// Size: 0x95
function function_e23dcf42aae58dad( delta, callback, onlybots )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    foreach ( enemy in level.players )
    {
        if ( isdefined( onlybots ) && onlybots )
        {
            if ( !isbot( enemy ) )
            {
                continue;
            }
        }
        
        function_3482e3d6bb34c1bf( enemy, delta, callback );
    }
}

// Namespace namespace_15b61b6788c29fd2 / namespace_6a577d053271961d
// Params 3
// Checksum 0x0, Offset: 0x215
// Size: 0xb3
function function_3482e3d6bb34c1bf( enemy, delta, callback )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "ftue_enemy_loot_viewed" );
    self.var_ee280d08e9b9729d = callback;
    
    if ( !isalliedsentient( self, enemy ) )
    {
        foreach ( item in enemy.var_d2dbb2fa012e6d9c )
        {
            if ( !isdefined( item ) )
            {
                continue;
            }
            
            childthread function_683c095e6767c4c8( item.origin, delta, &function_d138a208396bb595 );
        }
    }
}

// Namespace namespace_15b61b6788c29fd2 / namespace_6a577d053271961d
// Params 2
// Checksum 0x0, Offset: 0x2d0
// Size: 0x8c
function function_ec7f69bba0f79ee7( callback, onlybots )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    foreach ( enemy in level.players )
    {
        if ( isdefined( onlybots ) && onlybots )
        {
            if ( !isbot( enemy ) )
            {
                continue;
            }
        }
        
        function_8441daa65ac853d9( enemy, callback );
    }
}

// Namespace namespace_15b61b6788c29fd2 / namespace_6a577d053271961d
// Params 2
// Checksum 0x0, Offset: 0x364
// Size: 0x8b
function function_8441daa65ac853d9( enemy, callback )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( !isalliedsentient( self, enemy ) )
    {
        foreach ( item in enemy.var_d2dbb2fa012e6d9c )
        {
            if ( !isdefined( item ) )
            {
                continue;
            }
            
            thread function_54532a3f6bfc04e8( item, callback );
        }
    }
}

// Namespace namespace_15b61b6788c29fd2 / namespace_6a577d053271961d
// Params 0
// Checksum 0x0, Offset: 0x3f7
// Size: 0x25
function function_d138a208396bb595()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self [[ self.var_ee280d08e9b9729d ]]();
    self notify( "ftue_enemy_loot_viewed" );
}

// Namespace namespace_15b61b6788c29fd2 / namespace_6a577d053271961d
// Params 2
// Checksum 0x0, Offset: 0x424
// Size: 0x57
function function_54532a3f6bfc04e8( item, callback )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "ftue_enemy_loot_picked" );
    waittill_any( "self_pickedupitem_plunder", "self_pickedupitem_weapon", "self_pickedupitem_" + item.type );
    self [[ callback ]]();
    self notify( "ftue_enemy_loot_picked" );
}

