#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\outline;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;

#namespace outline;

// Namespace outline / scripts\mp\utility\outline
// Params 3
// Checksum 0x0, Offset: 0x171
// Size: 0x3f
function outlineenableforall( var_f20913fec7561c5f, hudoutlineassetname, prioritygroup )
{
    playersvisibleto = level.players;
    return scripts\mp\outline::outlineenableinternal( var_f20913fec7561c5f, playersvisibleto, hudoutlineassetname, prioritygroup, "ALL" );
}

// Namespace outline / scripts\mp\utility\outline
// Params 5
// Checksum 0x0, Offset: 0x1b9
// Size: 0x106
function outlineenableforteam( var_f20913fec7561c5f, var_fa3b23d51c2dc7, hudoutlineassetname, prioritygroup, var_213fdd3689d4b33e )
{
    if ( isgameplayteam( var_fa3b23d51c2dc7 ) )
    {
        playersvisibleto = getteamdata( var_fa3b23d51c2dc7, "players" );
    }
    else
    {
        playersvisibleto = [];
    }
    
    if ( isdefined( var_213fdd3689d4b33e ) )
    {
        var_404eeafd8dc3f0f0 = [];
        
        if ( isarray( var_213fdd3689d4b33e ) )
        {
            var_404eeafd8dc3f0f0 = var_213fdd3689d4b33e;
        }
        else if ( isplayer( var_213fdd3689d4b33e ) )
        {
            var_404eeafd8dc3f0f0 = [ var_213fdd3689d4b33e ];
        }
        
        foreach ( var_6b0ee97314aed333 in var_404eeafd8dc3f0f0 )
        {
            if ( isdefined( var_6b0ee97314aed333.team ) && var_6b0ee97314aed333.team == var_fa3b23d51c2dc7 )
            {
                playersvisibleto = scripts\engine\utility::array_remove( playersvisibleto, var_6b0ee97314aed333 );
            }
        }
    }
    
    return scripts\mp\outline::outlineenableinternal( var_f20913fec7561c5f, playersvisibleto, hudoutlineassetname, prioritygroup, "TEAM", var_fa3b23d51c2dc7 );
}

// Namespace outline / scripts\mp\utility\outline
// Params 5
// Checksum 0x0, Offset: 0x2c8
// Size: 0xbe
function outlineenableforsquad( var_f20913fec7561c5f, var_fa3b23d51c2dc7, squadindex, hudoutlineassetname, prioritygroup )
{
    assertex( scripts\cp_mp\utility\squad_utility::issquadmode(), "<dev string:x1c>" );
    assertex( isdefined( level.squaddata[ var_fa3b23d51c2dc7 ] ), "<dev string:x54>" + var_fa3b23d51c2dc7 );
    assertex( !isdefined( level.squaddata[ var_fa3b23d51c2dc7 ] ) || isdefined( level.squaddata[ var_fa3b23d51c2dc7 ][ squadindex ] ), "<dev string:x99>" + squadindex );
    playersvisibleto = level.squaddata[ var_fa3b23d51c2dc7 ][ squadindex ].players;
    return scripts\mp\outline::outlineenableinternal( var_f20913fec7561c5f, playersvisibleto, hudoutlineassetname, prioritygroup, "SQUAD", var_fa3b23d51c2dc7, squadindex );
}

// Namespace outline / scripts\mp\utility\outline
// Params 4
// Checksum 0x0, Offset: 0x38f
// Size: 0x47
function outlineenableforplayer( var_f20913fec7561c5f, var_18ebeb29bb7541e3, hudoutlineassetname, prioritygroup )
{
    if ( isagent( var_18ebeb29bb7541e3 ) )
    {
        return scripts\mp\outline::outlinegenerateuniqueid();
    }
    
    return scripts\mp\outline::outlineenableinternal( var_f20913fec7561c5f, [ var_18ebeb29bb7541e3 ], hudoutlineassetname, prioritygroup, "ENTITY" );
}

// Namespace outline / scripts\mp\utility\outline
// Params 2
// Checksum 0x0, Offset: 0x3df
// Size: 0x38
function outlinedisable( id, var_420a996e67989dc4 )
{
    assertex( isdefined( id ) && int( id ) == id, "<dev string:xed>" );
    scripts\mp\outline::outlinedisableinternal( id, var_420a996e67989dc4 );
}

// Namespace outline / scripts\mp\utility\outline
// Params 1
// Checksum 0x0, Offset: 0x41f
// Size: 0x23
function outlinerefresh( var_420a996e67989dc4 )
{
    assertex( isdefined( var_420a996e67989dc4 ), "<dev string:x116>" );
    scripts\mp\outline::outlinerefreshinternal( var_420a996e67989dc4 );
}

// Namespace outline / scripts\mp\utility\outline
// Params 0
// Checksum 0x0, Offset: 0x44a
// Size: 0x16
function initoutlineoccluders()
{
    level.outlineoccluders = [];
    level.outlineoccludersid = 0;
}

// Namespace outline / scripts\mp\utility\outline
// Params 2
// Checksum 0x0, Offset: 0x468
// Size: 0x69
function addoutlineoccluder( position, radius )
{
    outlineoccluder = spawnstruct();
    outlineoccluder.position = position;
    outlineoccluder.radius = radius;
    id = level.outlineoccludersid;
    level.outlineoccluders[ id ] = outlineoccluder;
    level.outlineoccludersid++;
    return id;
}

// Namespace outline / scripts\mp\utility\outline
// Params 1
// Checksum 0x0, Offset: 0x4da
// Size: 0x16
function removeoutlineoccluder( id )
{
    level.outlineoccluders[ id ] = undefined;
}

// Namespace outline / scripts\mp\utility\outline
// Params 2
// Checksum 0x0, Offset: 0x4f8
// Size: 0xad, Type: bool
function outlineoccluded( startpoint, endpoint )
{
    foreach ( occluder in level.outlineoccluders )
    {
        if ( !isdefined( occluder ) || !isdefined( occluder.position ) || !isdefined( occluder.radius ) )
        {
            continue;
        }
        
        if ( math::segmentvssphere( startpoint, endpoint, occluder.position, occluder.radius ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace outline / scripts\mp\utility\outline
// Params 6
// Checksum 0x0, Offset: 0x5ae
// Size: 0x196
function function_6b8603ff55f4ed2c( victimgroup, attacker, var_9cc7d33e2e2ebfef, duration, outlineassetname, prioritygroup )
{
    assertex( isdefined( victimgroup ), "<dev string:x14a>" );
    assertex( isdefined( attacker ), "<dev string:x1a6>" );
    
    if ( !isdefined( var_9cc7d33e2e2ebfef ) )
    {
        var_9cc7d33e2e2ebfef = [ attacker ];
    }
    
    if ( !isdefined( duration ) )
    {
        duration = 1000;
    }
    else
    {
        duration *= 1000;
    }
    
    if ( !isdefined( outlineassetname ) )
    {
        outlineassetname = "snapshotgrenade";
    }
    
    if ( !isdefined( prioritygroup ) )
    {
        prioritygroup = "equipment";
    }
    
    outlinedata = undefined;
    outlinedata = spawnstruct();
    outlinedata.owner = attacker;
    outlinedata.isalive = 1;
    outlinedata.targets = [];
    outlinedata.endtimes = [];
    outlinedata.outlineids = [];
    
    foreach ( victim in victimgroup )
    {
        if ( !isent( victim ) )
        {
            continue;
        }
        
        entnum = victim getentitynumber();
        outlinedata.targets[ entnum ] = victim;
        outlinedata.endtimes[ entnum ] = gettime() + duration;
        outlinedata.outlineids[ entnum ] = scripts\mp\outline::outlineenableinternal( victim, var_9cc7d33e2e2ebfef, outlineassetname, prioritygroup, "ENTITY" );
    }
    
    outlinedata thread function_2f7892fd0b6b8251();
}

// Namespace outline / scripts\mp\utility\outline
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x74c
// Size: 0x14f
function private function_2f7892fd0b6b8251()
{
    self endon( "death" );
    self.owner endon( "death_or_disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    level endon( "game_ended" );
    
    if ( !istrue( self.isalive ) )
    {
        return;
    }
    
    while ( self.targets.size > 0 )
    {
        foreach ( id, target in self.targets )
        {
            target = self.targets[ id ];
            endtime = self.endtimes[ id ];
            outlineid = self.outlineids[ id ];
            
            if ( !isdefined( target ) || !isreallyalive( target ) || gettime() >= endtime )
            {
                scripts\mp\utility\outline::outlinedisable( outlineid, target );
                
                if ( isdefined( target ) && ( isplayer( target ) || isbot( target ) ) )
                {
                    target scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
                }
                
                self.targets[ id ] = undefined;
                self.endtimes[ id ] = undefined;
                self.outlineids[ id ] = undefined;
            }
        }
        
        waitframe();
    }
    
    function_357b6df5a3d41e9c();
}

// Namespace outline / scripts\mp\utility\outline
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x8a3
// Size: 0xac
function private function_357b6df5a3d41e9c()
{
    self notify( "death" );
    self.isalive = 0;
    
    foreach ( id, target in self.targets )
    {
        target = self.targets[ id ];
        outlineid = self.outlineids[ id ];
        scripts\mp\utility\outline::outlinedisable( outlineid, target );
        
        if ( isdefined( target ) && ( isplayer( target ) || isbot( target ) ) )
        {
            target scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
        }
    }
}

// Namespace outline / scripts\mp\utility\outline
// Params 0
// Checksum 0x0, Offset: 0x957
// Size: 0x24
function _hudoutlineviewmodeldisable()
{
    if ( !isdefined( self ) || !isplayer( self ) )
    {
        return;
    }
    
    if ( !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return;
    }
    
    self hudoutlineviewmodeldisable();
}

// Namespace outline / scripts\mp\utility\outline
// Params 2
// Checksum 0x0, Offset: 0x983
// Size: 0x71
function _hudoutlineviewmodelenable( hudoutlineassetname, var_dafd99b070fb282a )
{
    if ( !isdefined( var_dafd99b070fb282a ) )
    {
        var_dafd99b070fb282a = 0;
    }
    
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:x20f>" );
        return;
    }
    
    if ( !var_dafd99b070fb282a && !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        assertmsg( "<dev string:x22a>" );
        return;
    }
    
    if ( var_dafd99b070fb282a && !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        thread hudoutlineviewmodelenableonnextspawn( hudoutlineassetname );
        return;
    }
    
    self hudoutlineviewmodelenable( hudoutlineassetname );
}

// Namespace outline / scripts\mp\utility\outline
// Params 1
// Checksum 0x0, Offset: 0x9fc
// Size: 0x3c
function hudoutlineviewmodelenableonnextspawn( hudoutlineassetname )
{
    level endon( "game_ended" );
    self waittill( "spawned" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self hudoutlineviewmodelenable( hudoutlineassetname );
}

