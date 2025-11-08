#using scripts\common\swim_common;
#using scripts\cp_mp\gasmask;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_pickups;

#namespace namespace_119c80c54f2f80e1;

// Namespace namespace_119c80c54f2f80e1 / namespace_7c996eebd51b5b1f
// Params 0
// Checksum 0x0, Offset: 0x1ae
// Size: 0x86
function init()
{
    scripts\engine\utility::registersharedfunc( "scubaGasMask", "hasScubaGasMask", &hasscubagasmask );
    scripts\engine\utility::registersharedfunc( "scubaGasMask", "isScubaGasMaskEquipped", &isscubagasmaskequipped );
    scripts\engine\utility::registersharedfunc( "scubaGasMask", "removeScubaGasMaskFromPlayer", &removescubagasmaskfromplayer );
    scripts\engine\utility::registersharedfunc( "scubaGasMask", "updateScubaGasmask", &updatescubagasmask );
    scripts\engine\utility::registersharedfunc( "scubaGasMask", "monitorScubaGasMaskDamage", &function_4e41bf5f9d46e115 );
    scripts\engine\utility::registersharedfunc( "scubaGasMask", "isUsingScubaGasMask", &isusingscubagasmask );
}

// Namespace namespace_119c80c54f2f80e1 / namespace_7c996eebd51b5b1f
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x23c
// Size: 0x15, Type: bool
function private isusingscubagasmask( player )
{
    return istrue( self.usingscubagasmask );
}

// Namespace namespace_119c80c54f2f80e1 / namespace_7c996eebd51b5b1f
// Params 1
// Checksum 0x0, Offset: 0x25a
// Size: 0x1d, Type: bool
function hasscubagasmask( player )
{
    return isusingscubagasmask( player ) && scripts\cp_mp\gasmask::hasgasmask( player );
}

// Namespace namespace_119c80c54f2f80e1 / namespace_7c996eebd51b5b1f
// Params 1
// Checksum 0x0, Offset: 0x280
// Size: 0x1d, Type: bool
function isscubagasmaskequipped( player )
{
    return hasscubagasmask( player ) && scripts\cp_mp\gasmask::isgasmaskequipped( player );
}

// Namespace namespace_119c80c54f2f80e1 / namespace_7c996eebd51b5b1f
// Params 1
// Checksum 0x0, Offset: 0x2a6
// Size: 0x20
function removescubagasmaskfromplayer( player )
{
    if ( hasscubagasmask( player ) )
    {
        player.usingscubagasmask = undefined;
    }
}

// Namespace namespace_119c80c54f2f80e1 / namespace_7c996eebd51b5b1f
// Params 2
// Checksum 0x0, Offset: 0x2ce
// Size: 0x33
function updatescubagasmask( player, isunderwater )
{
    if ( isdefined( player ) && isdefined( player.origin ) )
    {
        level thread function_9c13c9f95161d576( player, isunderwater );
    }
}

// Namespace namespace_119c80c54f2f80e1 / namespace_7c996eebd51b5b1f
// Params 2
// Checksum 0x0, Offset: 0x309
// Size: 0x6c
function function_9c13c9f95161d576( player, isunderwater )
{
    player endon( "death_or_disconnect" );
    player notify( "queue_scuba" );
    player endon( "queue_scuba" );
    level endon( "game_ended" );
    
    while ( true )
    {
        if ( !istrue( player.gasmaskswapinprogress ) )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isunderwater )
    {
        player scripts\mp\gametypes\br_pickups::function_cdf7f2f6bd3207( "underwater" );
        return;
    }
    
    player scripts\mp\gametypes\br_pickups::function_8206bc54a1ed73cb( "underwater" );
}

// Namespace namespace_119c80c54f2f80e1 / namespace_7c996eebd51b5b1f
// Params 0
// Checksum 0x0, Offset: 0x37d
// Size: 0x99
function function_4e41bf5f9d46e115()
{
    self endon( "death_or_disconnect" );
    self endon( "swim_breathing_disabled_end" );
    level endon( "game_ended" );
    var_9b7983c73df8b968 = getdvarfloat( @"hash_4a852245a5077873", 1 );
    var_76e563db5d11a0ea = getdvarfloat( @"hash_8d16d3f760df5419", 0.857 );
    
    while ( true )
    {
        if ( !scripts\common\swim_common::isplayerunderwater() )
        {
            break;
        }
        
        if ( !hasscubagasmask( self ) )
        {
            break;
        }
        
        if ( isdefined( self.origin ) && !istrue( self.plotarmor ) )
        {
            scripts\cp_mp\gasmask::processdamage( var_76e563db5d11a0ea );
        }
        
        wait var_9b7983c73df8b968;
    }
}

