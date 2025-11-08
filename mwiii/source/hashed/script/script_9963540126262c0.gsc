#using script_d74ae0b4aa21186;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;

#namespace namespace_4cfb97b54bb76867;

// Namespace namespace_4cfb97b54bb76867 / namespace_bfa2898056f8354
// Params 1
// Checksum 0x0, Offset: 0x112
// Size: 0xb4
function createevent( radius )
{
    event = function_c74368899713e7e6();
    event.radius = radius;
    event.radiussquared = radius * radius;
    event.result = [];
    eventstream = self.mind.eventstream;
    eventstream.var_c821041ce9f4100b = event;
    eventstream.events[ eventstream.events.size ] = event;
    
    if ( !isdefined( level.mind.events.buystations ) )
    {
        level thread function_f1f01b106bb7bd95();
    }
}

// Namespace namespace_4cfb97b54bb76867 / namespace_bfa2898056f8354
// Params 0
// Checksum 0x0, Offset: 0x1ce
// Size: 0xe2
function function_f1f01b106bb7bd95()
{
    level endon( "game_ended" );
    level.mind.events.buystations = [];
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() && !istrue( level.skipprematch ) )
    {
        level waittill( "prematch_cleanup" );
    }
    
    result = [];
    stations = getentitylessscriptablearray( undefined, undefined, undefined, undefined, "br_plunder_box" );
    
    foreach ( station in stations )
    {
        if ( istrue( station.visible ) )
        {
            result[ result.size ] = station;
        }
    }
    
    level.mind.events.buystations = result;
}

// Namespace namespace_4cfb97b54bb76867 / namespace_bfa2898056f8354
// Params 0
// Checksum 0x0, Offset: 0x2b8
// Size: 0x110
function getevent()
{
    event = self.mind.eventstream.var_c821041ce9f4100b;
    
    if ( !event.evaluated )
    {
        if ( event.result.size > 0 )
        {
            event.result = [];
        }
        
        foreach ( station in level.mind.events.buystations )
        {
            if ( distancesquared( station.origin, self.origin ) <= event.radiussquared )
            {
                event.result[ event.result.size ] = station;
            }
        }
        
        event.evaluated = 1;
    }
    
    return event.result;
}

