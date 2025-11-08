#using scripts\common\utility;
#using scripts\cp\incursion_waves;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace namespace_4e51d94cfd9dde90;

// Namespace namespace_4e51d94cfd9dde90 / namespace_7adb1ffcf7f14c91
// Params 1
// Checksum 0x0, Offset: 0x10d
// Size: 0x125
function main( spawnpoints )
{
    level thread function_b44747cb0cd4eec0();
    
    if ( !isdefined( level.var_7d37a4f92843afd2 ) )
    {
        level.var_7d37a4f92843afd2 = [];
    }
    
    level.var_5a11797125800495 = [];
    spawnpoints = getstructarray( "incur_wave_spawner", "script_noteworthy" );
    
    foreach ( point in spawnpoints )
    {
        if ( isdefined( point.script_area ) )
        {
            if ( !isdefined( level.var_7d37a4f92843afd2[ point.script_area ] ) )
            {
                level.var_7d37a4f92843afd2[ point.script_area ] = [];
            }
            
            level.var_7d37a4f92843afd2[ point.script_area ][ level.var_7d37a4f92843afd2[ point.script_area ].size ] = point;
        }
        
        if ( isdefined( point.script_flag ) )
        {
            function_9cf84ec973ee6f67( point );
            continue;
        }
        
        level.var_5a11797125800495[ level.var_5a11797125800495.size ] = point;
    }
}

// Namespace namespace_4e51d94cfd9dde90 / namespace_7adb1ffcf7f14c91
// Params 1
// Checksum 0x0, Offset: 0x23a
// Size: 0x21
function function_9cf84ec973ee6f67( spawnpoint )
{
    level.queued_spawnpoints[ level.queued_spawnpoints.size ] = spawnpoint;
}

// Namespace namespace_4e51d94cfd9dde90 / namespace_7adb1ffcf7f14c91
// Params 0
// Checksum 0x0, Offset: 0x263
// Size: 0xcb
function function_b44747cb0cd4eec0()
{
    level endon( "game_ended " );
    level.queued_spawnpoints = [];
    
    while ( true )
    {
        level waittill( "spawnpoint_flag", flagname );
        var_27754596431f547a = [];
        
        foreach ( point in level.queued_spawnpoints )
        {
            if ( point.script_flag == flagname )
            {
                var_27754596431f547a[ var_27754596431f547a.size ] = point;
            }
        }
        
        level.var_5a11797125800495 = array_combine( var_27754596431f547a, level.var_5a11797125800495 );
        level.queued_spawnpoints = array_remove_array( level.queued_spawnpoints, var_27754596431f547a );
    }
}

// Namespace namespace_4e51d94cfd9dde90 / namespace_7adb1ffcf7f14c91
// Params 4
// Checksum 0x0, Offset: 0x336
// Size: 0x77
function spawnpoint_choose( struct, maxdist, mindist, var_a25052287d3b6768 )
{
    while ( true )
    {
        spawnpoint = function_3b28deadada9e76e( struct, maxdist, mindist, var_a25052287d3b6768 );
        
        if ( isdefined( spawnpoint ) )
        {
            return spawnpoint;
        }
        
        wait 0.1;
        println( "<dev string:x1c>" + struct.origin + "<dev string:x3c>" + maxdist + "<dev string:x47>" + mindist );
    }
}

// Namespace namespace_4e51d94cfd9dde90 / namespace_7adb1ffcf7f14c91
// Params 4
// Checksum 0x0, Offset: 0x3b5
// Size: 0x291
function function_3b28deadada9e76e( struct, maxdist, mindist, var_a25052287d3b6768 )
{
    if ( !isdefined( maxdist ) )
    {
        maxdist = 3000;
    }
    
    if ( !isdefined( mindist ) )
    {
        mindist = 1000;
    }
    
    hardpoint = scripts\cp\incursion_waves::function_c1dc7a1d01595216();
    
    if ( isdefined( hardpoint ) )
    {
        maxdist = 3000;
        mindist = 250;
        
        if ( isdefined( level.var_21d6479fa8291e5d ) )
        {
            maxdist = level.var_21d6479fa8291e5d;
        }
        
        if ( isdefined( level.var_2a5522483fdcba47 ) )
        {
            mindist = level.var_2a5522483fdcba47;
        }
    }
    
    all_nodes = get_array_of_closest( struct.origin, level.var_5a11797125800495, undefined, undefined, maxdist, mindist );
    
    if ( !all_nodes.size )
    {
        iprintln( "Incursion Spawning: Failed to find spawnpoint for area near: " + struct.origin );
        all_nodes = getnodesinradius( struct.origin, maxdist, mindist, 512, "cover" );
    }
    
    valid_nodes = [];
    
    foreach ( node in all_nodes )
    {
        if ( istrue( var_a25052287d3b6768 ) && isdefined( node.var_47167c56230449e1 ) )
        {
            continue;
        }
        
        valid = 1;
        
        foreach ( player in level.players )
        {
            if ( distancesquared( player.origin, node.origin ) < squared( 500 ) )
            {
                valid = 0;
                continue;
            }
            
            if ( distancesquared( player.origin, node.origin ) > squared( maxdist ) )
            {
                valid = 0;
                continue;
            }
            
            if ( sighttracepassed( player geteye(), node.origin + ( 0, 0, 40 ), 1, player, 0 ) )
            {
                valid = 0;
            }
        }
        
        if ( valid )
        {
            valid_nodes[ valid_nodes.size ] = node;
        }
    }
    
    /#
        if ( valid_nodes.size == 0 )
        {
            iprintlnbold( "<dev string:x52>" );
            
            if ( all_nodes.size > 0 )
            {
                valid_nodes[ 0 ] = all_nodes[ 0 ];
            }
        }
    #/
    
    selected_node = undefined;
    
    if ( isdefined( hardpoint ) )
    {
        selected_node = random_weight_sorted( valid_nodes );
    }
    else
    {
        selected_node = random( valid_nodes );
    }
    
    return selected_node;
}

