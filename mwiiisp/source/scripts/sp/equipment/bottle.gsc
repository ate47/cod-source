#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;

#namespace bottle;

// Namespace bottle / scripts\sp\equipment\bottle
// Params 1
// Checksum 0x0, Offset: 0xfe
// Size: 0x7b
function precache( offhand )
{
    level.g_effect[ "bottle_break" ] = loadfx( "vfx/iw9/core/bottle/vfx_bottle_explosion.vfx" );
    level.offhands.bottle = spawnstruct();
    level.offhands.bottle.var_9c36b02032770c02 = undefined;
    
    /#
        setdvarifuninitialized( @"debug_bottle", 0 );
    #/
    
    registeroffhandfirefunc( offhand, &function_4b06c81b27875a14 );
}

// Namespace bottle / scripts\sp\equipment\bottle
// Params 2
// Checksum 0x0, Offset: 0x181
// Size: 0x164
function function_4b06c81b27875a14( grenade, weapon )
{
    grenade waittill( "missile_stuck", stuckto, hitpart, null, hitvelocity, position, hitnormal );
    
    /#
        if ( function_402e63d965a03b3c() )
        {
            sphere( position, 5, ( 1, 0, 0 ), 0, 300 );
        }
    #/
    
    grenade delete();
    thread play_sound_in_space( "weap_bottle_explo", position );
    right = undefined;
    
    if ( is_equal( hitnormal, ( 0, 0, 1 ) ) || is_equal( hitnormal, ( 0, 0, -1 ) ) )
    {
        right = ( 1, 0, 0 );
    }
    else
    {
        right = vectorcross( hitnormal, ( 0, 0, 1 ) );
    }
    
    playfx( level.g_effect[ "bottle_break" ], position, right, hitnormal );
    playrumbleonposition( "grenade_rumble", position );
    earthquake( 0.15, 0.35, position, 300 );
    
    if ( isdefined( stuckto ) && isai( stuckto ) )
    {
        thread function_a32bb7bb61372225( stuckto, position, hitpart, hitvelocity );
    }
    
    if ( !isplayer( self ) )
    {
        level notify( "bottle_impact" );
        return;
    }
}

// Namespace bottle / scripts\sp\equipment\bottle
// Params 4
// Checksum 0x0, Offset: 0x2ed
// Size: 0x70
function function_a32bb7bb61372225( ai, position, hitpart, hitvelocity )
{
    if ( isdefined( ai.var_879faed8e3a3276f ) )
    {
        ai thread [[ ai.var_879faed8e3a3276f ]]( position, hitpart, hitvelocity );
    }
    
    waitframe();
    
    if ( !istrue( ai.disablepain ) )
    {
        ai notify( "flashbang", position, 1, 1, level.player, "axis" );
    }
}

/#

    // Namespace bottle / scripts\sp\equipment\bottle
    // Params 0
    // Checksum 0x0, Offset: 0x365
    // Size: 0x14, Type: dev
    function function_402e63d965a03b3c()
    {
        return getdvarint( @"debug_bottle" );
    }

#/
