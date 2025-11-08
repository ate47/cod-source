#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace namespace_c8ac91d321f30090;

// Namespace namespace_c8ac91d321f30090 / namespace_8784b0174836bc50
// Params 1
// Checksum 0x0, Offset: 0x80
// Size: 0x87, Type: bool
function function_962089c12b654934( player )
{
    if ( !isdefined( level.soldier_allies ) )
    {
        return false;
    }
    
    foreach ( soldier in level.soldier_allies )
    {
        if ( isdefined( soldier.tracked_player ) && soldier.tracked_player == player )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_c8ac91d321f30090 / namespace_8784b0174836bc50
// Params 1
// Checksum 0x0, Offset: 0x110
// Size: 0xbd
function function_5c6c98e7d15b8d4a( player )
{
    if ( !isdefined( level.soldier_allies ) )
    {
        return undefined;
    }
    
    var_14dc09926e8e1b2f = [];
    
    foreach ( soldier in level.soldier_allies )
    {
        owner = soldier.owner;
        
        if ( isdefined( soldier.tracked_player ) )
        {
            owner = soldier.tracked_player;
        }
        
        if ( isdefined( owner ) && owner == player )
        {
            var_14dc09926e8e1b2f[ var_14dc09926e8e1b2f.size ] = soldier;
        }
    }
    
    if ( var_14dc09926e8e1b2f.size > 0 )
    {
        return var_14dc09926e8e1b2f;
    }
    
    return undefined;
}

// Namespace namespace_c8ac91d321f30090 / namespace_8784b0174836bc50
// Params 0
// Checksum 0x0, Offset: 0x1d6
// Size: 0xad
function function_5bd736549f8d4441()
{
    if ( !isdefined( level.soldier_allies ) )
    {
        return undefined;
    }
    
    var_14dc09926e8e1b2f = [];
    
    foreach ( soldier in level.soldier_allies )
    {
        owner = soldier.owner;
        
        if ( isdefined( soldier.tracked_player ) )
        {
            owner = soldier.tracked_player;
        }
        
        if ( isdefined( owner ) )
        {
            var_14dc09926e8e1b2f[ var_14dc09926e8e1b2f.size ] = soldier;
        }
    }
    
    if ( var_14dc09926e8e1b2f.size > 0 )
    {
        return var_14dc09926e8e1b2f;
    }
    
    return undefined;
}

// Namespace namespace_c8ac91d321f30090 / namespace_8784b0174836bc50
// Params 0
// Checksum 0x0, Offset: 0x28c
// Size: 0x1b
function total_allies()
{
    if ( !isdefined( level.soldier_allies ) )
    {
        return 0;
    }
    
    return level.soldier_allies.size;
}

// Namespace namespace_c8ac91d321f30090 / namespace_8784b0174836bc50
// Params 0
// Checksum 0x0, Offset: 0x2b0
// Size: 0x1b
function function_87ac668a043af5dd()
{
    if ( isdefined( level.var_506605f16efce39a ) )
    {
        return level.var_506605f16efce39a;
    }
    
    return 8;
}

