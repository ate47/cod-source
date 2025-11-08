#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace cp_spawn_factor;

// Namespace cp_spawn_factor / scripts\cp\cp_spawn_factor
// Params 2
// Checksum 0x0, Offset: 0x80
// Size: 0x2f
function critical_factor( var_e2cadc5bf4175e47, spawnpoint )
{
    scorefactor = [[ var_e2cadc5bf4175e47 ]]( spawnpoint );
    scorefactor = clamp( scorefactor, 0, 1000 );
    return scorefactor;
}

// Namespace cp_spawn_factor / scripts\cp\cp_spawn_factor
// Params 1
// Checksum 0x0, Offset: 0xb8
// Size: 0x95
function avoidgrenades( spawnpoint )
{
    foreach ( grenade in level.grenades )
    {
        if ( !isdefined( grenade ) || !grenade isexplosivedangeroustoplayer( self ) )
        {
            continue;
        }
        
        if ( distancesquared( spawnpoint.origin, grenade.origin ) < 122500 )
        {
            return 0;
        }
    }
    
    return 1000;
}

// Namespace cp_spawn_factor / scripts\cp\cp_spawn_factor
// Params 1
// Checksum 0x0, Offset: 0x156
// Size: 0xc5
function avoidmines( spawnpoint )
{
    var_4e5da354865df1fd = level.mines;
    
    if ( isdefined( level.placed_crafted_traps ) )
    {
        var_4e5da354865df1fd = array_combine( level.mines, level.placed_crafted_traps );
    }
    
    foreach ( explosive in var_4e5da354865df1fd )
    {
        if ( !isdefined( explosive ) || !explosive isexplosivedangeroustoplayer( self ) )
        {
            continue;
        }
        
        if ( distancesquared( spawnpoint.origin, explosive.origin ) < 122500 )
        {
            return 0;
        }
    }
    
    return 1000;
}

// Namespace cp_spawn_factor / scripts\cp\cp_spawn_factor
// Params 1
// Checksum 0x0, Offset: 0x224
// Size: 0x93
function isexplosivedangeroustoplayer( player )
{
    if ( !level.teambased || level.friendlyfire || !isdefined( player.team ) )
    {
        return 1;
    }
    
    explosiveteam = undefined;
    
    if ( isdefined( self.owner ) )
    {
        if ( player == self.owner )
        {
            return 1;
        }
        
        explosiveteam = self.owner.team;
    }
    
    if ( isdefined( explosiveteam ) )
    {
        return ( explosiveteam != player.team );
    }
    
    return 1;
}

// Namespace cp_spawn_factor / scripts\cp\cp_spawn_factor
// Params 1
// Checksum 0x0, Offset: 0x2bf
// Size: 0x51
function avoidtelefrag( spawnpoint )
{
    if ( isdefined( self.allowtelefrag ) )
    {
        return 1000;
    }
    
    if ( isdefined( spawnpoint.allowtelefrag ) )
    {
        return 1000;
    }
    
    if ( positionwouldtelefrag( spawnpoint.origin ) )
    {
        return 0;
    }
    
    return 1000;
}

// Namespace cp_spawn_factor / scripts\cp\cp_spawn_factor
// Params 1
// Checksum 0x0, Offset: 0x318
// Size: 0x3c
function spawn_point_too_far( spawnpoint )
{
    if ( distancesquared( get_center_point_of_array( level.players ), spawnpoint.origin ) >= 16777216 )
    {
        return 0;
    }
    
    return 1000;
}

