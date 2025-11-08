#using script_d74ae0b4aa21186;
#using scripts\engine\utility;

#namespace namespace_cd1f26d31e0fc552;

// Namespace namespace_cd1f26d31e0fc552 / namespace_e3ef90d32ac66277
// Params 2
// Checksum 0x0, Offset: 0xb7
// Size: 0x92
function createevent( radius, duration )
{
    event = function_c74368899713e7e6();
    event.radiussquared = radius * radius;
    event.duration = duration;
    event.result = [];
    eventstream = self.mind.eventstream;
    eventstream.var_b726268175e85134 = event;
    eventstream.events[ eventstream.events.size ] = event;
}

// Namespace namespace_cd1f26d31e0fc552 / namespace_e3ef90d32ac66277
// Params 0
// Checksum 0x0, Offset: 0x151
// Size: 0x29c
function getevent()
{
    event = self.mind.eventstream.var_b726268175e85134;
    
    if ( !event.evaluated )
    {
        if ( event.result.size > 0 )
        {
            foreach ( entnum, lastview in event.result )
            {
                var_23818fd0489c7005 = isexpired( lastview.time, lastview.origin );
                
                if ( var_23818fd0489c7005 )
                {
                    event.result[ entnum ] = undefined;
                }
            }
        }
        
        foreach ( player in level.players )
        {
            skip = !isdefined( player ) || self.team == player.team;
            
            if ( skip )
            {
                continue;
            }
            
            lasttime = self lastknowntime( player );
            lastpos = self lastknownpos( player );
            nolasttime = lasttime <= 0;
            var_b9f15fe7c92886c0 = !isvector( lastpos );
            entitynumber = player getentitynumber();
            shoulddelete = nolasttime || var_b9f15fe7c92886c0 || isexpired( lasttime, lastpos );
            
            if ( shoulddelete )
            {
                if ( isdefined( event.result[ entitynumber ] ) )
                {
                    event.result[ entitynumber ] = undefined;
                }
                
                continue;
            }
            
            entry = event.result[ entitynumber ];
            
            if ( !isdefined( entry ) )
            {
                entry = spawnstruct();
                entry.entnum = entitynumber;
                entry.valid = 1;
                entry.time = lasttime;
                entry.origin = lastpos;
                event.result[ entitynumber ] = entry;
                continue;
            }
            
            if ( lasttime != entry.time )
            {
                entry.valid = 1;
                entry.time = lasttime;
                entry.origin = lastpos;
            }
        }
        
        event.evaluated = 1;
    }
    
    return event.result;
}

// Namespace namespace_cd1f26d31e0fc552 / namespace_e3ef90d32ac66277
// Params 0
// Checksum 0x0, Offset: 0x3f6
// Size: 0x36
function getduration()
{
    event = self.mind.eventstream.var_b726268175e85134;
    return event.duration;
}

// Namespace namespace_cd1f26d31e0fc552 / namespace_e3ef90d32ac66277
// Params 1
// Checksum 0x0, Offset: 0x435
// Size: 0x5d
function invalidateentry( entitynumber )
{
    event = self.mind.eventstream.var_b726268175e85134;
    entry = event.result[ entitynumber ];
    
    if ( isdefined( entry ) )
    {
        entry.valid = 0;
    }
}

// Namespace namespace_cd1f26d31e0fc552 / namespace_e3ef90d32ac66277
// Params 2
// Checksum 0x0, Offset: 0x49a
// Size: 0x72, Type: bool
function isexpired( time, position )
{
    event = self.mind.eventstream.var_b726268175e85134;
    return ( gettime() - time ) / 1000 > event.duration || distancesquared( self.origin, position ) > event.radiussquared;
}

