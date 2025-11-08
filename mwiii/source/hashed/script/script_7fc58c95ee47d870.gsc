#using script_d74ae0b4aa21186;
#using scripts\engine\utility;

#namespace namespace_a8c188143ce759d3;

// Namespace namespace_a8c188143ce759d3 / namespace_a88fd88e39d4308
// Params 1
// Checksum 0x0, Offset: 0xe1
// Size: 0x156
function createevent( radius )
{
    event = function_c74368899713e7e6();
    event.radius = radius;
    event.radiussquared = radius * radius;
    event.result = [];
    eventstream = self.mind.eventstream;
    eventstream.var_61c0bf2e5d0b72d1 = event;
    eventstream.events[ eventstream.events.size ] = event;
    
    if ( !isdefined( level.mind.events.var_cce0bdb14ad78af5 ) )
    {
        result = [];
        
        for ( i = 0; i < getlootspawnscriptableindexfirst() ; i++ )
        {
            scriptableinstance = getscriptableinstancefromindex( i );
            
            if ( !isdefined( scriptableinstance ) )
            {
                continue;
            }
            
            if ( scriptableinstance.type == "military_ammo_restock" )
            {
                idx = result.size;
                result[ idx ] = spawnstruct();
                result[ idx ].entity = scriptableinstance;
                result[ idx ].type = "ammo_restock";
            }
        }
        
        level.mind.events.var_cce0bdb14ad78af5 = result;
    }
}

// Namespace namespace_a8c188143ce759d3 / namespace_a88fd88e39d4308
// Params 0
// Checksum 0x0, Offset: 0x23f
// Size: 0x12c
function getevent()
{
    event = self.mind.eventstream.var_61c0bf2e5d0b72d1;
    
    if ( !event.evaluated )
    {
        if ( event.result.size > 0 )
        {
            event.result = [];
        }
        
        foreach ( ammorestock in level.mind.events.var_cce0bdb14ad78af5 )
        {
            if ( istrue( ammorestock.var_2a6f82a735950253 ) )
            {
                continue;
            }
            
            if ( distancesquared( ammorestock.entity.origin, self.origin ) < event.radiussquared )
            {
                event.result[ event.result.size ] = ammorestock;
            }
        }
        
        event.evaluated = 1;
    }
    
    return event.result;
}

