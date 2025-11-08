#using scripts\common\utility;
#using scripts\engine\utility;

#namespace sentientpoolmanager;

// Namespace sentientpoolmanager / scripts\mp\sentientpoolmanager
// Params 0
// Checksum 0x0, Offset: 0x19a
// Size: 0x1f4
function init()
{
    flag_init( "sentientpoolmanager_initialized" );
    createthreatbiasgroup( "Tactical_Static" );
    createthreatbiasgroup( "Tactical_Moving" );
    createthreatbiasgroup( "Lethal_Static" );
    createthreatbiasgroup( "Lethal_Moving" );
    createthreatbiasgroup( "Level_Vehicle" );
    createthreatbiasgroup( "Killstreak_Static" );
    createthreatbiasgroup( "Killstreak_Air" );
    createthreatbiasgroup( "Killstreak_Ground" );
    createthreatbiasgroup( "Drone" );
    setignoremegroup( "Killstreak_Ground", "Killstreak_Ground" );
    setignoremegroup( "Killstreak_Air", "Killstreak_Ground" );
    setignoremegroup( "Killstreak_Air", "Killstreak_Air" );
    setignoremegroup( "Killstreak_Ground", "Killstreak_Air" );
    level.sentientpools = [];
    level.sentientpools[ level.sentientpools.size ] = "Tactical_Static";
    level.sentientpools[ level.sentientpools.size ] = "Tactical_Moving";
    level.sentientpools[ level.sentientpools.size ] = "Lethal_Static";
    level.sentientpools[ level.sentientpools.size ] = "Lethal_Moving";
    level.sentientpools[ level.sentientpools.size ] = "Level_Vehicle";
    level.sentientpools[ level.sentientpools.size ] = "Killstreak_Static";
    level.sentientpools[ level.sentientpools.size ] = "Killstreak_Air";
    level.sentientpools[ level.sentientpools.size ] = "Killstreak_Ground";
    level.sentientpools[ level.sentientpools.size ] = "Drone";
    level.activesentients = [];
    
    for ( i = 0; i < level.sentientpools.size ; i++ )
    {
        level.activesentients[ level.sentientpools[ i ] ] = [];
    }
    
    flag_set( "sentientpoolmanager_initialized" );
}

// Namespace sentientpoolmanager / scripts\mp\sentientpoolmanager
// Params 6
// Checksum 0x0, Offset: 0x396
// Size: 0x1b2
function registersentient( threatbiasgroup, var_5c00772332ce642c, islethal, var_5f6534ad3a0a1fa2, var_719c179eabb70b31, var_8928fdf873929e88 )
{
    var_ee6f4af9861df2ab = -1;
    
    for ( i = 0; i < level.sentientpools.size ; i++ )
    {
        if ( level.sentientpools[ i ] == threatbiasgroup )
        {
            var_ee6f4af9861df2ab = i;
            break;
        }
    }
    
    if ( var_ee6f4af9861df2ab == -1 )
    {
        assertex( var_ee6f4af9861df2ab, "<dev string:x1c>" + threatbiasgroup );
        return;
    }
    
    if ( isdefined( self.sentientpool ) )
    {
        return;
    }
    
    sentientcounts = getsentientcounts();
    sentientlimits = getsentientlimits();
    
    if ( sentientcounts[ "other" ] + sentientcounts[ "expendable" ] >= sentientlimits[ "other" ] )
    {
        maderoom = level removebestsentient( var_ee6f4af9861df2ab );
        
        if ( !maderoom )
        {
            return;
        }
    }
    
    self.sentientpool = threatbiasgroup;
    self.sentientaddedtime = gettime();
    self.sentientpoolindex = self getentitynumber();
    team = undefined;
    
    if ( isstring( var_5c00772332ce642c ) )
    {
        team = var_5c00772332ce642c;
    }
    else if ( isplayer( var_5c00772332ce642c ) )
    {
        team = var_5c00772332ce642c.team;
    }
    
    succeeded = undefined;
    
    if ( isdefined( team ) && !isagent( self ) )
    {
        succeeded = self makeentitysentient( team, undefined, var_719c179eabb70b31, var_8928fdf873929e88 );
    }
    
    if ( istrue( succeeded ) )
    {
        self setthreatbiasgroup( threatbiasgroup );
        
        if ( istrue( islethal ) )
        {
            self makeentitynomeleetarget();
        }
        
        level.activesentients[ threatbiasgroup ][ self.sentientpoolindex ] = self;
        thread monitorsentient( var_5f6534ad3a0a1fa2 );
    }
}

// Namespace sentientpoolmanager / scripts\mp\sentientpoolmanager
// Params 1
// Checksum 0x0, Offset: 0x550
// Size: 0x6e
function monitorsentient( var_5f6534ad3a0a1fa2 )
{
    level endon( "game_ended" );
    poolid = self.sentientpool;
    keyid = self.sentientpoolindex;
    
    if ( isdefined( var_5f6534ad3a0a1fa2 ) )
    {
        waittill_any_3( "death", "remove_sentient", var_5f6534ad3a0a1fa2 );
    }
    else
    {
        waittill_either( "death", "remove_sentient" );
    }
    
    unregistersentient( poolid, keyid );
}

// Namespace sentientpoolmanager / scripts\mp\sentientpoolmanager
// Params 1
// Checksum 0x0, Offset: 0x5c6
// Size: 0xa2, Type: bool
function removebestsentient( var_6f03d6ebff31de00 )
{
    assert( var_6f03d6ebff31de00 >= 0 && var_6f03d6ebff31de00 < level.sentientpools.size );
    bestsentient = undefined;
    
    for ( i = 0; i <= var_6f03d6ebff31de00 ; i++ )
    {
        assert( isdefined( level.sentientpools[ i ] ) );
        bestsentient = getbestsentientfrompool( level.sentientpools[ i ] );
        
        if ( isdefined( bestsentient ) )
        {
            break;
        }
    }
    
    if ( !isdefined( bestsentient ) )
    {
        return false;
    }
    
    bestsentient unregistersentient( bestsentient.sentientpool, bestsentient.sentientpoolindex );
    return true;
}

// Namespace sentientpoolmanager / scripts\mp\sentientpoolmanager
// Params 1
// Checksum 0x0, Offset: 0x671
// Size: 0x97
function getbestsentientfrompool( pooltype )
{
    bestsentient = undefined;
    oldesttime = undefined;
    
    foreach ( sentient in level.activesentients[ pooltype ] )
    {
        if ( !isdefined( oldesttime ) || sentient.sentientaddedtime < oldesttime )
        {
            oldesttime = sentient.sentientaddedtime;
            bestsentient = sentient;
        }
    }
    
    return bestsentient;
}

// Namespace sentientpoolmanager / scripts\mp\sentientpoolmanager
// Params 2
// Checksum 0x0, Offset: 0x711
// Size: 0x56
function unregistersentient( poolid, keyid )
{
    if ( !isdefined( poolid ) || !isdefined( keyid ) )
    {
        return;
    }
    
    level.activesentients[ poolid ][ keyid ] = undefined;
    
    if ( isdefined( self ) )
    {
        self.sentientpool = undefined;
        self.sentientpoolindex = undefined;
        
        if ( !isagent( self ) )
        {
            self freeentitysentient();
        }
    }
}

