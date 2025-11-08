#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;

#namespace namespace_746991ada5f529ec;

// Namespace namespace_746991ada5f529ec / namespace_ba8cfebbc70bb00b
// Params 0
// Checksum 0x0, Offset: 0x9e
// Size: 0x65
function createevent()
{
    event = function_c74368899713e7e6();
    event.result = [];
    eventstream = self.mind.eventstream;
    eventstream.var_d338b2cc0965fdb3 = event;
    eventstream.events[ eventstream.events.size ] = event;
}

// Namespace namespace_746991ada5f529ec / namespace_ba8cfebbc70bb00b
// Params 0
// Checksum 0x0, Offset: 0x10b
// Size: 0x122
function getevent()
{
    event = self.mind.eventstream.var_d338b2cc0965fdb3;
    
    if ( !event.evaluated )
    {
        if ( event.result.size > 0 )
        {
            event.result = [];
        }
        
        if ( !isdefined( level.allfobs ) )
        {
            return event.result;
        }
        
        foreach ( fob in level.allfobs )
        {
            var_b9100d06b4fcec73 = fob.trigger.gameobject;
            
            if ( !var_b9100d06b4fcec73 scripts\mp\gameobjects::caninteractwith( self.team ) )
            {
                continue;
            }
            
            event.result[ event.result.size ] = fob;
        }
        
        event.evaluated = 1;
    }
    
    return event.result;
}

