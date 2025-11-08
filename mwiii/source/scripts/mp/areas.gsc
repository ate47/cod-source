#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;

#namespace areas;

// Namespace areas / scripts\mp\areas
// Params 0
// Checksum 0x0, Offset: 0x124
// Size: 0x12b
function init()
{
    level.softlandingtriggers = getentarray( "trigger_multiple_softlanding", "classname" );
    destructibles = getentarray( "destructible_vehicle", "targetname" );
    
    foreach ( trigger in level.softlandingtriggers )
    {
        if ( trigger.script_type != "car" )
        {
            continue;
        }
        
        foreach ( destructible in destructibles )
        {
            if ( distance( trigger.origin, destructible.origin ) > 64 )
            {
                continue;
            }
            
            assert( !isdefined( trigger.destructible ) );
            trigger.destructible = destructible;
        }
    }
    
    thread onplayerconnect();
}

// Namespace areas / scripts\mp\areas
// Params 0
// Checksum 0x0, Offset: 0x257
// Size: 0x37
function onplayerconnect()
{
    if ( scripts\mp\utility\game::runleanthreadmode() )
    {
        return;
    }
    
    for ( ;; )
    {
        level waittill( "connected", player );
        player.softlanding = undefined;
        player thread softlandingwaiter();
    }
}

// Namespace areas / scripts\mp\areas
// Params 1
// Checksum 0x0, Offset: 0x296
// Size: 0x15
function playerentersoftlanding( trigger )
{
    self.softlanding = trigger;
}

// Namespace areas / scripts\mp\areas
// Params 1
// Checksum 0x0, Offset: 0x2b3
// Size: 0x15
function playerleavesoftlanding( trigger )
{
    self.softlanding = undefined;
}

// Namespace areas / scripts\mp\areas
// Params 0
// Checksum 0x0, Offset: 0x2d0
// Size: 0x3c
function softlandingwaiter()
{
    self endon( "disconnect" );
    
    for ( ;; )
    {
        self waittill( "soft_landing", trigger, damage );
        
        if ( !isdefined( trigger.destructible ) )
        {
        }
    }
}

