#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\flags;
#using scripts\mp\utility\perk;

#namespace namespace_707f4e559a586342;

// Namespace namespace_707f4e559a586342 / namespace_2c9cb80adc9e5a31
// Params 0
// Checksum 0x0, Offset: 0x142
// Size: 0x1e
function init()
{
    if ( !getdvarint( @"hash_e98eca6eda18788a", 1 ) )
    {
        return;
    }
    
    thread movementinit();
}

// Namespace namespace_707f4e559a586342 / namespace_2c9cb80adc9e5a31
// Params 0
// Checksum 0x0, Offset: 0x168
// Size: 0xae
function movementinit()
{
    level endon( "game_ended" );
    scripts\mp\flags::function_1240434f4201ac9d( "prematch_fade_done" );
    wait 1;
    triggers = getnoentvolumearray( "movementalarm", "script_noteworthy" );
    
    foreach ( trigger in triggers )
    {
        trigger.detectors = getentitylessscriptablearray( trigger.target, "targetname" );
        
        if ( isdefined( trigger.detectors ) )
        {
            trigger thread function_776e0185df41fb73();
        }
    }
}

// Namespace namespace_707f4e559a586342 / namespace_2c9cb80adc9e5a31
// Params 0
// Checksum 0x0, Offset: 0x21e
// Size: 0x3b
function function_776e0185df41fb73()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        
        if ( !player scripts\mp\utility\perk::_hasperk( "specialty_coldblooded" ) )
        {
            startalarm();
        }
    }
}

// Namespace namespace_707f4e559a586342 / namespace_2c9cb80adc9e5a31
// Params 0
// Checksum 0x0, Offset: 0x261
// Size: 0x102
function startalarm()
{
    level endon( "game_ended" );
    
    if ( !isdefined( self.detectors ) )
    {
        return;
    }
    
    var_d1415110270ff152 = getdvarint( @"hash_5c27f1538b104979", 20 );
    
    foreach ( element in self.detectors )
    {
        element setscriptablepartstate( "onoff", "on", 1 );
    }
    
    wait var_d1415110270ff152;
    
    while ( waittill_notify_or_timeout_return( "trigger", 1 ) == "trigger" )
    {
        wait var_d1415110270ff152;
    }
    
    foreach ( element in self.detectors )
    {
        element setscriptablepartstate( "onoff", "off", 1 );
    }
}

