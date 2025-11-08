#using script_638d701d263ee1ed;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_kiosk;
#using scripts\engine\utility;

#namespace namespace_b21ca9bc612fd35e;

// Namespace namespace_b21ca9bc612fd35e / namespace_9c3c2f13c73009de
// Params 0, eflags: 0x5
// Checksum 0x0, Offset: 0x107
// Size: 0x10
function private autoexec init()
{
    level.var_c383b967aa7e551b = &function_6872809890fda236;
}

// Namespace namespace_b21ca9bc612fd35e / namespace_9c3c2f13c73009de
// Params 0
// Checksum 0x0, Offset: 0x11f
// Size: 0x4f
function function_4b13a4ad54f972d()
{
    if ( isdefined( level.var_2a4098e63ea03444 ) )
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    level.var_2a4098e63ea03444 = spawnstruct();
    level.var_2a4098e63ea03444.disable = getdvarint( @"hash_c6ccf4097906f9e9", 0 );
}

// Namespace namespace_b21ca9bc612fd35e / namespace_9c3c2f13c73009de
// Params 0
// Checksum 0x0, Offset: 0x176
// Size: 0x2c
function function_99059a1ba0177ef5()
{
    if ( !isdefined( level.var_2a4098e63ea03444 ) )
    {
        function_4b13a4ad54f972d();
    }
    
    level.var_2a4098e63ea03444.disable = 1;
}

// Namespace namespace_b21ca9bc612fd35e / namespace_9c3c2f13c73009de
// Params 0
// Checksum 0x0, Offset: 0x1aa
// Size: 0x29
function function_11808c06b138b030()
{
    if ( !isdefined( level.var_2a4098e63ea03444 ) )
    {
        function_4b13a4ad54f972d();
    }
    
    return level.var_2a4098e63ea03444.disable;
}

// Namespace namespace_b21ca9bc612fd35e / namespace_9c3c2f13c73009de
// Params 4
// Checksum 0x0, Offset: 0x1dc
// Size: 0x5d6
function function_6872809890fda236( type, instances, spawnfunction, spawnedinstances )
{
    if ( !isstring( type ) )
    {
        assertmsg( "<dev string:x4d>" );
        return [];
    }
    
    if ( !isarray( instances ) )
    {
        assertmsg( "<dev string:x9b>" );
        return [];
    }
    
    var_cf43c0073346699e = getdvarint( @"hash_ef289541321ac02", 10 );
    
    if ( function_11808c06b138b030() )
    {
        if ( isdefined( spawnfunction ) )
        {
            for ( instanceindex = 0; instanceindex < instances.size ; instanceindex++ )
            {
                if ( instanceindex % var_cf43c0073346699e == 0 )
                {
                    waitframe();
                }
                
                [[ spawnfunction ]]( instances[ instanceindex ] );
            }
        }
        
        return instances;
    }
    
    profilebeginevent( hashcat( #"hash_e114d66bfe00abd5", type, ")" ) );
    var_9dd27621c3b3f414 = [];
    var_9dd27621c3b3f414[ "difficulty_easy" ] = function_db34ea8a158fdb1c( @"hash_dabb20898c754898", type, 1000 );
    var_9dd27621c3b3f414[ "difficulty_normal" ] = function_db34ea8a158fdb1c( @"hash_38145656dc86c56d", type, 1000 );
    var_9dd27621c3b3f414[ "difficulty_hard" ] = function_db34ea8a158fdb1c( @"hash_f9fd3aae4ac9fb7", type, 1000 );
    var_9dd27621c3b3f414[ "difficulty_darkaether" ] = function_db34ea8a158fdb1c( @"hash_f0e9cd5a5da0607c", type, 1000 );
    var_196ff61200360658 = [];
    var_196ff61200360658[ "difficulty_easy" ] = 0;
    var_196ff61200360658[ "difficulty_normal" ] = 0;
    var_196ff61200360658[ "difficulty_hard" ] = 0;
    var_196ff61200360658[ "difficulty_darkaether" ] = 0;
    regions = namespace_f721fc7d0d2d0f47::get_regions();
    regions = array_randomize( regions );
    maxregions = function_db34ea8a158fdb1c( @"hash_8d38ace4e02c6254", type, 1000 );
    newregions = [];
    
    for ( regionindex = 0; regionindex < regions.size ; regionindex++ )
    {
        regiondifficulty = namespace_f721fc7d0d2d0f47::function_cf8b9cfdad89cbec( regions[ regionindex ] );
        
        if ( isdefined( var_196ff61200360658[ regiondifficulty ] ) && var_196ff61200360658[ regiondifficulty ] >= var_9dd27621c3b3f414[ regiondifficulty ] )
        {
            continue;
        }
        
        newregions[ newregions.size ] = regions[ regionindex ];
        var_196ff61200360658[ regiondifficulty ]++;
        
        if ( newregions.size >= maxregions )
        {
            break;
        }
    }
    
    regions = newregions;
    regioncount = [];
    
    foreach ( region in regions )
    {
        regioncount[ region ] = 0;
    }
    
    instances = array_randomize( instances );
    maxtotal = function_db34ea8a158fdb1c( @"hash_74b87cb6c4318a8f", type, 1000 );
    var_e022f6549d782b98 = function_db34ea8a158fdb1c( @"hash_6032db8987c45dac", type, 1000 );
    var_f472fe97e458904c = function_db34ea8a158fdb1c( @"hash_a0a2168163c13a41", type, 1000 );
    var_cc12d997dbc0b834 = var_f472fe97e458904c * var_f472fe97e458904c;
    difficultymaxcount = [];
    difficultymaxcount[ "difficulty_easy" ] = function_db34ea8a158fdb1c( @"hash_4223258f9cd27738", type, 1000 );
    difficultymaxcount[ "difficulty_normal" ] = function_db34ea8a158fdb1c( @"hash_20d31e298a7c480d", type, 1000 );
    difficultymaxcount[ "difficulty_hard" ] = function_db34ea8a158fdb1c( @"hash_2ba1577e853f4dd7", type, 1000 );
    difficultymaxcount[ "difficulty_darkaether" ] = function_db34ea8a158fdb1c( @"hash_e6f6531887272c1c", type, 1000 );
    difficultycount = [];
    difficultycount[ "difficulty_easy" ] = 0;
    difficultycount[ "difficulty_normal" ] = 0;
    difficultycount[ "difficulty_hard" ] = 0;
    difficultycount[ "difficulty_darkaether" ] = 0;
    
    if ( !isdefined( spawnedinstances ) )
    {
        spawnedinstances = [];
    }
    else
    {
        foreach ( spawnedinstance in spawnedinstances )
        {
            region = namespace_f721fc7d0d2d0f47::get_region( spawnedinstance.origin );
            
            if ( !isdefined( region ) )
            {
                continue;
            }
            
            regioncount[ region ]++;
            regiondifficulty = namespace_f721fc7d0d2d0f47::function_cf8b9cfdad89cbec( region );
            difficultycount[ regiondifficulty ]++;
        }
    }
    
    for ( instanceindex = 0; instanceindex < instances.size ; instanceindex++ )
    {
        if ( instanceindex % var_cf43c0073346699e == 0 )
        {
            profileendevent();
            waitframe();
            profilebeginevent( hashcat( #"hash_e114d66bfe00abd5", type, ")" ) );
        }
        
        instance = instances[ instanceindex ];
        
        if ( spawnedinstances.size >= maxtotal )
        {
            break;
        }
        
        region = namespace_f721fc7d0d2d0f47::get_region( instance.origin );
        
        if ( !isdefined( region ) )
        {
            continue;
        }
        
        if ( !isdefined( regioncount[ region ] ) || regioncount[ region ] >= var_e022f6549d782b98 )
        {
            continue;
        }
        
        regiondifficulty = namespace_f721fc7d0d2d0f47::function_cf8b9cfdad89cbec( region );
        
        if ( isdefined( difficultymaxcount[ regiondifficulty ] ) && difficultycount[ regiondifficulty ] >= difficultymaxcount[ regiondifficulty ] )
        {
            continue;
        }
        
        var_ba32601f625413a7 = 0;
        
        for ( spawnedindex = 0; spawnedindex < spawnedinstances.size ; spawnedindex++ )
        {
            if ( distance2dsquared( instance.origin, spawnedinstances[ spawnedindex ].origin ) < var_cc12d997dbc0b834 )
            {
                var_ba32601f625413a7 = 1;
                break;
            }
        }
        
        if ( var_ba32601f625413a7 )
        {
            continue;
        }
        
        if ( isdefined( level.aether_storm ) && isvector( level.aether_storm.starting_origin ) && isdefined( level.aether_storm.starting_radius ) )
        {
            distancesquared = distance2dsquared( level.aether_storm.starting_origin, instance.origin );
            testdistancesquared = squared( max( level.aether_storm.starting_radius, 0 ) );
            
            if ( distancesquared <= testdistancesquared )
            {
                continue;
            }
        }
        
        regioncount[ region ]++;
        difficultycount[ regiondifficulty ]++;
        
        if ( isdefined( spawnfunction ) )
        {
            [[ spawnfunction ]]( instance );
        }
        
        spawnedinstances[ spawnedinstances.size ] = instance;
    }
    
    profileendevent();
    return spawnedinstances;
}

// Namespace namespace_b21ca9bc612fd35e / namespace_9c3c2f13c73009de
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x7bb
// Size: 0x4b
function private function_db34ea8a158fdb1c( dvar, type, defaultvalue )
{
    typedvar = hashcat( dvar, "__" + type );
    
    if ( isdvardefined( typedvar ) )
    {
        return getdvarint( typedvar );
    }
    
    return getdvarint( dvar, defaultvalue );
}

