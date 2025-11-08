#using scripts\anim\face;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\utility;

#namespace smoke;

// Namespace smoke / scripts\sp\equipment\smoke
// Params 1
// Checksum 0x0, Offset: 0x11c
// Size: 0x18
function precache( offhand )
{
    registeroffhandfirefunc( offhand, &smokefiremain );
}

// Namespace smoke / scripts\sp\equipment\smoke
// Params 2
// Checksum 0x0, Offset: 0x13c
// Size: 0x271
function smokefiremain( grenade, weapon )
{
    grenadeowner = self;
    addbattlechatternotify( grenadeowner, undefined, "grenade_throw", "smoke_grenade" );
    grenade waittill( "explode", grenadeorigin );
    earthquake( 0.25, 0.35, grenadeorigin, 1000 );
    playrumbleonposition( "grenade_rumble", grenadeorigin );
    playerdistancesquared = distancesquared( level.player.origin, grenadeorigin );
    
    if ( playerdistancesquared <= 22500 )
    {
        traceoffset = ( 0, 0, 18 );
        
        if ( !ray_trace_passed( level.player.origin + traceoffset, grenadeorigin + traceoffset, level.player ) )
        {
            return;
        }
        
        level.player forceplaygestureviewmodel( "iw9_ges_gas_cough_long", undefined, 0.5, 0, 1, 0 );
    }
    
    enemies = getaiarray( "axis" );
    
    foreach ( enemy in enemies )
    {
        distancesquared = distancesquared( enemy.origin, grenadeorigin );
        hasstealth = isdefined( enemy.stealth );
        incombat = isdefined( enemy.fnisinstealthcombat ) && enemy [[ enemy.fnisinstealthcombat ]]();
        
        if ( hasstealth && !incombat && distancesquared <= 1000000 )
        {
            event = spawnstruct();
            event.typeorig = "explosion";
            event.type = "cover_blown";
            event.entity = level.player;
            event.origin = grenadeorigin;
            event.investigate_pos = grenadeorigin;
            enemy [[ enemy.fnsetstealthstate ]]( "hunt", event );
        }
        
        if ( distancesquared <= 57600 )
        {
            enemy scripts\anim\face::saygenericdialogue( "cough_fit" );
            
            if ( !isdefined( enemy.stealth ) )
            {
                enemy aieventlistenerevent( "explosion", self, grenadeorigin );
            }
        }
    }
}

