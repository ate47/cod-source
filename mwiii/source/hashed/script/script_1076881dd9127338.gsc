#using script_d74ae0b4aa21186;
#using scripts\engine\utility;

#namespace namespace_3606b64785f08163;

// Namespace namespace_3606b64785f08163 / namespace_1bebff3a2e9afaca
// Params 1
// Checksum 0x0, Offset: 0xde
// Size: 0xbd
function createevent( radius )
{
    event = function_c74368899713e7e6();
    event.radiussquared = radius * radius;
    event.result = [];
    eventstream = self.mind.eventstream;
    eventstream.var_9b7e812b9d289bbf = event;
    eventstream.events[ eventstream.events.size ] = event;
    
    if ( !isdefined( level.mind.events.var_39dae4a0e7ee4d47 ) )
    {
        level.mind.events.var_39dae4a0e7ee4d47 = [];
    }
}

// Namespace namespace_3606b64785f08163 / namespace_1bebff3a2e9afaca
// Params 0
// Checksum 0x0, Offset: 0x1a3
// Size: 0x11e
function getevent()
{
    event = self.mind.eventstream.var_9b7e812b9d289bbf;
    
    if ( !event.evaluated )
    {
        if ( event.result.size > 0 )
        {
            event.result = [];
        }
        
        groups = getstructarray( "bot_camp_group", "script_noteworthy" );
        
        foreach ( group in groups )
        {
            if ( distancesquared( group.origin, self.origin ) > event.radiussquared )
            {
                continue;
            }
            
            if ( function_5a45d11a570a19c5( group ) )
            {
                continue;
            }
            
            event.result[ event.result.size ] = group;
        }
        
        event.evaluated = 1;
    }
    
    return event.result;
}

// Namespace namespace_3606b64785f08163 / namespace_1bebff3a2e9afaca
// Params 1
// Checksum 0x0, Offset: 0x2ca
// Size: 0x6e, Type: bool
function function_5a45d11a570a19c5( campgroup )
{
    ownerteams = level.mind.events.var_39dae4a0e7ee4d47[ campgroup.target ];
    
    if ( !isdefined( ownerteams ) )
    {
        return false;
    }
    
    var_4a681d08b83b6920 = ownerteams[ self.team ];
    
    if ( !isdefined( var_4a681d08b83b6920 ) )
    {
        return false;
    }
    
    return var_4a681d08b83b6920 != self.entity_number;
}

// Namespace namespace_3606b64785f08163 / namespace_1bebff3a2e9afaca
// Params 1
// Checksum 0x0, Offset: 0x341
// Size: 0xa0
function function_7dbe596500a2e27c( campgroup )
{
    if ( !isdefined( level.mind.events.var_39dae4a0e7ee4d47[ campgroup.target ] ) )
    {
        level.mind.events.var_39dae4a0e7ee4d47[ campgroup.target ] = [];
    }
    
    level.mind.events.var_39dae4a0e7ee4d47[ campgroup.target ][ self.team ] = self.entity_number;
}

// Namespace namespace_3606b64785f08163 / namespace_1bebff3a2e9afaca
// Params 1
// Checksum 0x0, Offset: 0x3e9
// Size: 0xa2
function function_5f6e68b080316fcf( campgroup )
{
    ownerteams = level.mind.events.var_39dae4a0e7ee4d47[ campgroup.target ];
    
    if ( !isdefined( ownerteams ) )
    {
        return;
    }
    
    var_4a681d08b83b6920 = ownerteams[ self.team ];
    
    if ( isdefined( var_4a681d08b83b6920 ) && var_4a681d08b83b6920 == self.entity_number )
    {
        level.mind.events.var_39dae4a0e7ee4d47[ campgroup.target ][ self.team ] = undefined;
    }
}

