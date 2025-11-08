#using script_d74ae0b4aa21186;
#using scripts\engine\utility;

#namespace namespace_f0be73a95f76c7ed;

// Namespace namespace_f0be73a95f76c7ed / namespace_9d48dceb90164d92
// Params 1
// Checksum 0x0, Offset: 0xe0
// Size: 0x7d
function createevent( radius )
{
    event = function_c74368899713e7e6();
    event.result = [];
    event.radiussq = radius * radius;
    eventstream = self.mind.eventstream;
    eventstream.var_ec10c084410e83fc = event;
    eventstream.events[ eventstream.events.size ] = event;
}

// Namespace namespace_f0be73a95f76c7ed / namespace_9d48dceb90164d92
// Params 0
// Checksum 0x0, Offset: 0x165
// Size: 0x1b4
function getevent()
{
    event = self.mind.eventstream.var_ec10c084410e83fc;
    
    if ( !event.evaluated )
    {
        if ( event.result.size > 0 )
        {
            event.result = [];
        }
        
        entarray = getentarray( "script_model", "classname" );
        
        foreach ( ent in entarray )
        {
            if ( isdefined( ent.cratetype ) && ent.cratetype == "battle_royale_loadout" && ent.team == self.team && istrue( ent.isusable ) && !istrue( ent.var_2a6f82a735950253 ) && distancesquared( self.origin, ent.origin ) < event.radiussq )
            {
                entry = spawnstruct();
                entry.type = "airdrop_loadout";
                entry.entity = ent;
                entry.entity.index = ent getentitynumber();
                event.result[ event.result.size ] = entry;
            }
        }
        
        event.evaluated = 1;
    }
    
    return event.result;
}

