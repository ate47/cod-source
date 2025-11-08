#using script_3a8f9ace195c9da9;
#using script_7db80de62748c769;
#using scripts\common\ai_formation;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\nvg_ai;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\engine\math;
#using scripts\engine\utility;

#namespace namespace_9871da81deb2e4b0;

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 4
// Checksum 0x0, Offset: 0x480
// Size: 0x196
function function_6afcdc96a6ce9a56( var_4ea821cbd5c93e3d, var_87f368d777c41192, override_damage_sight_range, fov )
{
    fov = default_to( fov, 60 );
    scripts\cp\coop_stealth::run_common_functions( self, 1, 1, fov );
    self.var_4ebe755e0a0a430e = 1;
    self function_8bbcaeb23a1512ef( "all", 1 );
    
    if ( isdefined( var_4ea821cbd5c93e3d ) )
    {
        self function_d493e7fe15e5eaf4( var_4ea821cbd5c93e3d );
    }
    else
    {
        assertmsg( "No valid sight_config_name provided. All AI must have a SightConfig set." );
    }
    
    if ( weaponclass( self.weapon ) == "sniper" )
    {
        self function_d493e7fe15e5eaf4( "jup_sandbox_sniper" );
    }
    
    override_damage_sight_range = default_to( override_damage_sight_range, 1600 );
    self.stealth.override_damage_sight_range = override_damage_sight_range;
    
    if ( isdefined( self.subclass ) )
    {
        switch ( self.subclass )
        {
            case #"hash_b8776a7c6d24d388":
                self.var_9aa77ab756fdca82 = 10;
                self.var_43e2ad424676b8d4 = 10;
                break;
            case #"hash_b8776d7c6d24d841":
                self.var_9aa77ab756fdca82 = 120;
                self.var_43e2ad424676b8d4 = 25;
                break;
            case #"hash_b8776c7c6d24d6ae":
                self.var_9aa77ab756fdca82 = 250;
                self.var_43e2ad424676b8d4 = 50;
                break;
            default:
                break;
        }
    }
    
    self pushplayer( 1 );
    self function_136adff8f817fad6( 1 );
    self.meleechargedistvsplayer = 120;
    function_c0256e105fcdcf61();
    thread function_85f4cc4dd2c3a1cc();
    
    if ( isdefined( var_87f368d777c41192 ) && isfunction( var_87f368d777c41192 ) )
    {
        thread ai_death_monitor( var_87f368d777c41192 );
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 0
// Checksum 0x0, Offset: 0x61e
// Size: 0x80
function function_c0256e105fcdcf61()
{
    if ( isdefined( self.spawner ) && isdefined( self.spawner.script_patrolname ) && self.spawner.script_patrolname != "" )
    {
        function_b41baf16d62d21d8( self.spawner.script_patrolname, self, 1 );
        function_e1f50b1f60aa1b25( self.spawner.script_patrolname, 0, 50, 50 );
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 0
// Checksum 0x0, Offset: 0x6a6
// Size: 0x7c
function function_85f4cc4dd2c3a1cc()
{
    self endon( "death" );
    
    if ( !isdefined( self.var_97a0ba4272149777 ) )
    {
        self.var_97a0ba4272149777 = 0;
    }
    
    while ( true )
    {
        prev_state = self.stealth_bsmstate;
        waittill_any_return_3( "stealth_investigate", "stealth_hunt", "stealth_combat" );
        
        if ( isdefined( self.stealth_bsmstate ) && self.stealth_bsmstate != prev_state )
        {
            self.var_97a0ba4272149777 = gettime();
        }
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 1
// Checksum 0x0, Offset: 0x72a
// Size: 0x1ac
function ai_death_monitor( var_87f368d777c41192 )
{
    if ( !isdefined( level.player ) )
    {
        return;
    }
    
    level.player endon( "death" );
    level.var_5ef076251e7516c7 = default_to( level.var_5ef076251e7516c7, 0 );
    level.var_f243e0956e3cf9da = default_to( level.var_f243e0956e3cf9da, 0 );
    issniper = isdefined( self.weapon ) && isdefined( self.weapon.classname ) && self.weapon.classname == "sniper";
    self waittill( "death", attacker, meansofdeath, weaponobject, damagelocation );
    wait 0.5;
    
    if ( !level.var_5ef076251e7516c7 && !flag( "vo_in_kill" ) && !istrue( level.var_f243e0956e3cf9da ) && flag( "flag_dungeon_intro_complete" ) && isplayer( attacker ) )
    {
        kill_dist = distance( level.player.origin, self.origin );
        
        if ( function_db1910344d3cdfa8( self.origin ) )
        {
            if ( istrue( level.var_4f73c33a5235d99c ) )
            {
                var_c5d7c9bae8fad8b2 = 1;
            }
            else
            {
                var_c5d7c9bae8fad8b2 = !stealthgetanyaiincombat() && percent_chance( 70 ) && getstealthdetectstate() != "spotted";
            }
            
            if ( var_c5d7c9bae8fad8b2 )
            {
                thread [[ var_87f368d777c41192 ]]( kill_dist, issniper );
            }
        }
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0x8de
// Size: 0x90, Type: bool
function function_db1910344d3cdfa8( origin, radius )
{
    radius = default_to( radius, 2000 );
    
    foreach ( ai in getaiarrayinradius( origin, radius, "axis" ) )
    {
        if ( isdefined( self.var_97a0ba4272149777 ) )
        {
            if ( !time_has_passed( self.var_97a0ba4272149777, 5 ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 0
// Checksum 0x0, Offset: 0x977
// Size: 0x2
function function_f98bf6b7b70b76aa()
{
    
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 3
// Checksum 0x0, Offset: 0x981
// Size: 0x20f
function function_96247e7595b40c0a( var_197e4e69fadbe18c, flash_volumes, end_on )
{
    level endon( "game_over" );
    level.player endon( "death" );
    level.player endon( "disconnect" );
    
    if ( isdefined( end_on ) )
    {
        level endon( end_on );
    }
    
    while ( true )
    {
        wait 1;
        all_ais = [[ var_197e4e69fadbe18c ]]();
        
        switch ( getdvar( @"hash_46e9546bc099e5fd", "default" ) )
        {
            case #"hash_c482c6c109150a4":
                array_thread( all_ais, &scripts\cp\nvg_ai::enable_flashlight, 1 );
                continue;
            case #"hash_db653a4972b3c13b":
                array_thread( all_ais, &scripts\cp\nvg_ai::enable_flashlight, 0 );
                continue;
        }
        
        var_30b0acbb5bdcf22a = all_ais;
        var_30b0acbb5bdcf22a = array_sort_with_func( var_30b0acbb5bdcf22a, &function_14f52e3e375a2355 );
        
        if ( isdefined( flash_volumes ) && isarray( flash_volumes ) && flash_volumes.size > 0 )
        {
            var_1c53b0a512652332 = [];
            
            for ( i = 0; i <= 2 * level.var_8679f91457606ad ; i++ )
            {
                nearby_ai = var_30b0acbb5bdcf22a[ i ];
                
                if ( !isdefined( nearby_ai ) )
                {
                    continue;
                }
                
                foreach ( vol in flash_volumes )
                {
                    if ( nearby_ai istouching( vol ) )
                    {
                        var_1c53b0a512652332[ var_1c53b0a512652332.size ] = nearby_ai;
                        break;
                    }
                }
                
                if ( var_1c53b0a512652332.size >= level.var_8679f91457606ad - 1 )
                {
                    break;
                }
            }
            
            var_30b0acbb5bdcf22a = var_1c53b0a512652332;
        }
        else
        {
            nearest_ais = [];
            
            for ( i = 0; i < level.var_8679f91457606ad ; i++ )
            {
                nearest_ais[ i ] = var_30b0acbb5bdcf22a[ i ];
            }
            
            var_30b0acbb5bdcf22a = nearest_ais;
        }
        
        var_cb8ec4b09b1ba636 = array_remove_array( all_ais, var_30b0acbb5bdcf22a );
        array_thread( var_cb8ec4b09b1ba636, &scripts\cp\nvg_ai::enable_flashlight, 0 );
        array_thread( var_30b0acbb5bdcf22a, &scripts\cp\nvg_ai::enable_flashlight, 1 );
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 1
// Checksum 0x0, Offset: 0xb98
// Size: 0x23
function function_76e85d0aa8db406d( var_2c6a53a7791a89e4 )
{
    self.flashlightfxoverridetag = "tag_accessory_left";
    self.flashlightfxoverride = var_2c6a53a7791a89e4;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 6
// Checksum 0x0, Offset: 0xbc3
// Size: 0x109
function function_6149b301ce19988b( spawner_targetname, think_fn, spawner_size, time_between_spawns, var_dbcd234547a892b0, var_1aca0424d68b374 )
{
    if ( !isdefined( spawner_size ) )
    {
        spawner_size = getstructarray( spawner_targetname, "targetname" ).size;
    }
    
    if ( !isdefined( time_between_spawns ) )
    {
        time_between_spawns = 0.05;
    }
    
    if ( !( isdefined( level.ambientgroups ) && isdefined( level.ambientgroups[ spawner_targetname ] ) ) )
    {
        scripts\cp\spawning::registerambientgroup( spawner_targetname, spawner_size, spawner_size, spawner_size, time_between_spawns, undefined, spawner_targetname, undefined, undefined, undefined );
    }
    
    if ( !isdefined( think_fn ) )
    {
        think_fn = &function_fac67371e80874db;
    }
    
    scripts\cp\spawning::register_module_ai_spawn_func( spawner_targetname, think_fn );
    spawn_module = scripts\cp\spawning::run_spawn_module( spawner_targetname );
    scripts\cp\cp_spawning_util::set_recent_spawn_time_threshold_override( spawn_module, time_between_spawns * 2 );
    
    if ( istrue( var_dbcd234547a892b0 ) )
    {
        var_c12844ff8174f8a0 = var_1aca0424d68b374;
        
        if ( !isdefined( var_c12844ff8174f8a0 ) )
        {
            if ( isdefined( level.var_9283d76b0bfabcca[ 0 ] ) )
            {
                var_c12844ff8174f8a0 = level.var_9283d76b0bfabcca[ 0 ];
            }
        }
        
        if ( isdefined( var_c12844ff8174f8a0 ) )
        {
            level thread function_8b740623f288f26e( spawn_module.group_name, var_c12844ff8174f8a0 );
        }
    }
    
    return spawn_module;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0xcd5
// Size: 0x8f
function function_8b740623f288f26e( spawner_targetname, var_1aca0424d68b374 )
{
    level endon( "game_ended" );
    level endon( "stop_choreographer_watcher " + spawner_targetname );
    
    while ( true )
    {
        level waittill( "ai_spawn_successful", soldier, spawnpoint, spawnpoint_origin, module_struct );
        
        if ( module_struct.group_name == spawner_targetname )
        {
            function_37605fb617b75716( var_1aca0424d68b374, soldier );
            println( "<dev string:x1c>" + spawner_targetname + "<dev string:x35>" + var_1aca0424d68b374 );
        }
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0xd6c
// Size: 0x6f
function function_efaf045c780ad9b3( var_2b3d95356f4eb366, var_1aca0424d68b374 )
{
    level endon( "game_ended" );
    level endon( "stop_choreographer_watcher " + var_2b3d95356f4eb366 );
    
    while ( true )
    {
        level waittill( "vehicle_rider_spawned", rider, veh_spawner );
        
        if ( veh_spawner == var_2b3d95356f4eb366 )
        {
            function_37605fb617b75716( var_1aca0424d68b374, rider );
            println( "<dev string:x4f>" + var_2b3d95356f4eb366 + "<dev string:x35>" + var_1aca0424d68b374 );
        }
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 1
// Checksum 0x0, Offset: 0xde3
// Size: 0x15
function function_cbddaf6c92856d2c( spawner_targetname )
{
    level notify( "stop_choreographer_watcher " + spawner_targetname );
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 4
// Checksum 0x0, Offset: 0xe00
// Size: 0xa8
function function_7af164468ae66a10( targetname, var_1aca0424d68b374, soldier_spawner, vehicle_spawner )
{
    if ( !isdefined( targetname ) )
    {
        println( "<dev string:x78>" );
        return 0;
    }
    
    if ( !isdefined( var_1aca0424d68b374 ) )
    {
        if ( isdefined( level.var_9283d76b0bfabcca[ 0 ] ) )
        {
            var_1aca0424d68b374 = level.var_9283d76b0bfabcca[ 0 ];
        }
    }
    
    if ( !isdefined( var_1aca0424d68b374 ) )
    {
        println( "<dev string:xb1>" );
        return 0;
    }
    
    if ( !isdefined( soldier_spawner ) && !isdefined( vehicle_spawner ) )
    {
        println( "<dev string:xfc>" );
        return 0;
    }
    
    if ( vehicle_spawner )
    {
        level thread function_efaf045c780ad9b3( targetname, var_1aca0424d68b374 );
    }
    
    if ( soldier_spawner )
    {
        level thread function_8b740623f288f26e( targetname, var_1aca0424d68b374 );
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0xeb0
// Size: 0x1f4
function function_fac67371e80874db( group_name, func )
{
    if ( getdvarint( @"hash_dcf5fcede3345fb8", 0 ) != 0 )
    {
        self.ignoreall = 1;
    }
    
    if ( scripts\cp\spawning::is_specified_unittype( "juggernaut" ) )
    {
        self function_b11b5190b03c861c( "" );
        self setcanusecover( 0 );
        self.var_2626d6897d71b728 = 2000;
    }
    
    if ( istrue( self.bhasriotshieldattached ) )
    {
        self.var_2626d6897d71b728 = 1400;
    }
    
    scripts\cp\coop_stealth::run_common_functions( self, 1, 1, 60, 160000 );
    self.var_d4c11c85ee9c6a42 = 1500;
    self.var_a4709d00b598b7bf = 1;
    self.var_ba67494935b9726b = 1;
    
    if ( getstealthdetectstate() == "spotted" )
    {
        if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
        {
            return;
        }
        
        player = level.player;
        
        if ( isdefined( player ) )
        {
            self setgoalpos( player.origin );
            event = spawnstruct();
            event.typeorig = "combat";
            event.type = "combat";
            event.origin = player.origin;
            event.investigate_pos = player.origin;
            self [[ self.fnsetstealthstate ]]( "combat", event );
        }
        
        self getenemyinfo( level.player );
        return;
    }
    
    if ( istrue( level.var_5f4f92a8e2b137e7 ) )
    {
        if ( self [[ self.fnisinstealthcombat ]]() || self [[ self.fnisinstealthhunt ]]() )
        {
            return;
        }
        
        self [[ self.fnsetstealthstate ]]( "hunt" );
    }
    
    if ( isdefined( self.noflashlight ) && !self.noflashlight )
    {
        delaythread( 1, &enable_flashlight, 1 );
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 1
// Checksum 0x0, Offset: 0x10ac
// Size: 0x86, Type: bool
function function_489a0835e10a9b55( ai_array )
{
    if ( !isdefined( ai_array ) || !isarray( ai_array ) )
    {
        ai_array = getaiarray( "axis" );
    }
    
    ai_array = function_fdc9d5557c53078e( ai_array );
    
    foreach ( ai in ai_array )
    {
        if ( ai [[ ai.fnisinstealthcombat ]]() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0x113b
// Size: 0xd8, Type: bool
function function_155f16ed1b7f00cd( ai_array, addtime )
{
    if ( !isdefined( ai_array ) || !isarray( ai_array ) )
    {
        ai_array = getaiarray( "axis" );
    }
    
    addtime = default_to( addtime, 3 );
    
    foreach ( ai in ai_array )
    {
        if ( !isdefined( ai ) )
        {
            continue;
        }
        
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( !isdefined( ai.lastenemysighttime ) || ai.lastenemysighttime == 0 )
        {
            continue;
        }
        
        if ( addtime > 0 && gettime() < ai.lastenemysighttime + 1000 * addtime )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0x121c
// Size: 0x52
function function_d0b6fd4fc2332c8c( ai_array, addtime )
{
    if ( !isdefined( ai_array ) || !isarray( ai_array ) )
    {
        ai_array = getaiarray( "axis" );
    }
    
    var_3b2b2934a3439464 = function_a3b5f52b9d203b7f( ai_array, addtime );
    return getclosest( self.origin, var_3b2b2934a3439464 );
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0x1277
// Size: 0xef
function function_a3b5f52b9d203b7f( ai_array, addtime )
{
    if ( !isdefined( ai_array ) || !isarray( ai_array ) )
    {
        ai_array = getaiarray( "axis" );
    }
    
    addtime = default_to( addtime, float( 0 ) );
    var_3b2b2934a3439464 = [];
    
    foreach ( ai in ai_array )
    {
        if ( !isdefined( ai ) )
        {
            continue;
        }
        
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( !isdefined( ai.lastenemysighttime ) || ai.lastenemysighttime == 0 )
        {
            continue;
        }
        
        if ( addtime > 0 && gettime() < ai.lastenemysighttime + 1000 * addtime )
        {
            var_3b2b2934a3439464 = array_add( var_3b2b2934a3439464, ai );
        }
    }
    
    return var_3b2b2934a3439464;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0x136f
// Size: 0x99
function function_1c988b6c6d6719b8( ai_array, dist )
{
    if ( !isdefined( ai_array ) || !isarray( ai_array ) )
    {
        ai_array = getaiarray( "axis" );
    }
    
    ai_array = function_fdc9d5557c53078e( ai_array );
    ai_array = function_b786b62f4d97ebf();
    var_dd93636baed7dd78 = 0;
    
    for ( i = 0; i < ai_array.size ; i++ )
    {
        if ( distance( ai_array[ i ].origin, level.player.origin ) <= dist )
        {
            var_dd93636baed7dd78++;
            continue;
        }
        
        break;
    }
    
    return var_dd93636baed7dd78;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 1
// Checksum 0x0, Offset: 0x1411
// Size: 0x4c
function function_b786b62f4d97ebf( ai_array )
{
    if ( !isdefined( ai_array ) || !isarray( ai_array ) )
    {
        ai_array = getaiarray( "axis" );
    }
    
    ai_array = function_fdc9d5557c53078e( ai_array );
    ai_array = sortbydistance( ai_array, level.player.origin );
    return ai_array;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 1
// Checksum 0x0, Offset: 0x1466
// Size: 0x40
function function_95ecff6ac09a31ed( ai_array )
{
    if ( !isdefined( ai_array ) || !isarray( ai_array ) )
    {
        ai_array = getaiarray( "axis" );
    }
    
    ai_array = function_fdc9d5557c53078e( ai_array );
    return getclosest( self.origin, ai_array );
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 3
// Checksum 0x0, Offset: 0x14af
// Size: 0xdd
function function_a5089164a46c97d( center_loc, range, steam )
{
    if ( !isdefined( center_loc ) || !isvector( center_loc ) )
    {
        return undefined;
    }
    
    if ( isdefined( range ) )
    {
        range_sq = range * range;
    }
    else
    {
        return undefined;
    }
    
    if ( !isdefined( steam ) )
    {
        steam = "axis";
    }
    
    ai_within_range = [];
    all_ais = getaiarray( steam );
    
    foreach ( ai in all_ais )
    {
        if ( distancesquared( center_loc, ai.origin ) <= range_sq )
        {
            ai_within_range[ ai_within_range.size ] = ai;
        }
    }
    
    ai_within_range = array_removedead_or_dying( ai_within_range );
    return ai_within_range;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 1
// Checksum 0x0, Offset: 0x1595
// Size: 0x9a
function function_79587a7a06a99027( steam )
{
    if ( !isdefined( steam ) )
    {
        steam = "axis";
    }
    
    ateam = getaiarray( steam );
    var_3ecbf1096d1ba823 = [];
    
    foreach ( guy in ateam )
    {
        assertex( isalive( guy ), "Got ai array yet got a dead guy!" );
        
        if ( guy istouching( self ) )
        {
            var_3ecbf1096d1ba823[ var_3ecbf1096d1ba823.size ] = guy;
        }
    }
    
    return var_3ecbf1096d1ba823;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0x1638
// Size: 0x8f
function function_6a86ad418e0171d9( ai_array, trigger_targetname )
{
    if ( !isdefined( ai_array ) || !isarray( ai_array ) )
    {
        ai_array = getaiarray( "axis" );
    }
    
    trig = function_1c4d592029f2b0d3( trigger_targetname );
    
    foreach ( ai in ai_array )
    {
        if ( ai istouching( trig ) )
        {
            return ai;
        }
    }
    
    return undefined;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 4
// Checksum 0x0, Offset: 0x16d0
// Size: 0x107
function aim_at( origin, laser_state, laser_tag, aim_time )
{
    self notify( "stop_aiming" );
    self endon( "stop_aiming" );
    self endon( "death" );
    
    if ( !isdefined( origin ) )
    {
        origin = self localtoworldcoords( ( 150, 0, 30 ) );
    }
    
    if ( !isdefined( laser_state ) )
    {
        laser_state = 0;
    }
    
    if ( !isdefined( aim_time ) )
    {
        aim_time = 1.5;
    }
    
    self.aim_target = spawn_script_origin();
    self.aim_target.origin = self gettagorigin( "tag_flash" ) + anglestoforward( self gettagangles( "tag_flash" ) ) * 50;
    childthread internal_aim_occlusion_override();
    self setentitytarget( self.aim_target );
    self.aim_target moveto( origin, aim_time, 0.01, 0.01 );
    
    /#
        thread debug_aiming();
    #/
    
    wait aim_time * 0.5;
    
    if ( laser_state > 0 )
    {
        thread aim_at_laser_on( laser_state, laser_tag );
    }
    
    wait aim_time * 0.5;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x17df
// Size: 0x48
function private internal_aim_occlusion_override()
{
    self.suppress_uselastenemysightpos = 1;
    self.dontgiveuponsuppression = 1;
    self.forcesuppressai = 1;
    
    while ( true )
    {
        self.lastenemysightpos = self.aim_target.origin;
        waitframe();
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x182f
// Size: 0x82
function private internal_aim_at_laser_tracker()
{
    while ( true )
    {
        waittillframeend();
        var_a04ea954c347f6d6 = self gettagorigin( self.aim_laser.tag );
        self.aim_laser dontinterpolate();
        self.aim_laser.origin = var_a04ea954c347f6d6;
        self.aim_laser.angles = vectortoangles( self.aim_target.origin - var_a04ea954c347f6d6 );
        waitframe();
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 4
// Checksum 0x0, Offset: 0x18b9
// Size: 0x4e
function createaiment( team, org, ang, expendable )
{
    ent = spawn_script_origin( org, ang );
    ent.health = 1;
    ent makeentitysentient( team, expendable );
    return ent;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 0
// Checksum 0x0, Offset: 0x1910
// Size: 0x23, Type: bool
function player_spotted()
{
    return isdefined( self.enemy ) && self.enemy == level.player;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 0
// Checksum 0x0, Offset: 0x193c
// Size: 0xc, Type: bool
function is_aiming()
{
    return isdefined( self.aim_target );
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0x1951
// Size: 0xea
function aim_at_laser_on( laser_state, laser_tag )
{
    self endon( "laser_off" );
    self endon( "death" );
    assertex( isdefined( self.aim_target ), "Must call entity aim_at() before using aim_at_laser_on()" );
    
    if ( laser_state != 0 )
    {
        if ( !isdefined( laser_tag ) )
        {
            laser_tag = "tag_laser";
        }
        
        self.aim_laser = spawn( "script_model", self gettagorigin( laser_tag ) );
        self.aim_laser setmodel( "tag_laser" );
        self.aim_laser setmoverlaserweapon( self.weapon );
        self.aim_laser.tag = laser_tag;
        
        if ( laser_state == 1 )
        {
            self.aim_laser laseron();
        }
        else
        {
            self.aim_laser laserforceon();
        }
        
        self.aim_laser.laser_state = laser_state;
        internal_aim_at_laser_tracker();
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 0
// Checksum 0x0, Offset: 0x1a43
// Size: 0x6a
function aim_at_laser_off()
{
    self notify( "laser_off" );
    
    if ( isdefined( self.aim_laser ) )
    {
        if ( self.aim_laser.laser_state == 1 )
        {
            self.aim_laser laseroff();
        }
        else
        {
            self.aim_laser laserforceoff();
        }
        
        self.aim_laser delete();
        self.aim_laser = undefined;
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 4
// Checksum 0x0, Offset: 0x1ab5
// Size: 0x76
function move_aim_to( origin, time, acceleration_time, deceleration_time )
{
    self endon( "death" );
    self endon( "stop_aiming" );
    
    if ( !isdefined( acceleration_time ) )
    {
        acceleration_time = 0.05;
    }
    
    if ( !isdefined( deceleration_time ) )
    {
        deceleration_time = 0.05;
    }
    
    assertex( isdefined( self.aim_target ), "Must enable aiming with aim_at() before moving aim" );
    self.aim_target moveto( origin, time, acceleration_time, deceleration_time );
    wait time;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 3
// Checksum 0x0, Offset: 0x1b33
// Size: 0x85
function link_aim_to( ent, tag, origin_offset )
{
    self endon( "stop_aiming" );
    self endon( "death" );
    assertex( isdefined( self.aim_target ), "Must enable aiming with aim_at() before linking aim" );
    
    if ( !isdefined( tag ) )
    {
        tag = "tag_origin";
    }
    
    if ( isdefined( origin_offset ) )
    {
        self.aim_target linkto( ent, tag, origin_offset, ( 0, 0, 0 ) );
        return;
    }
    
    self.aim_target linkto( ent, tag );
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 6
// Checksum 0x0, Offset: 0x1bc0
// Size: 0x301
function move_aim_to_enemy( enemy, tag, acquire_time, var_dc102d0a3fa40d6c, var_3c6327d2dc93eeb9, enable_debug )
{
    assertex( isdefined( self.aim_target ), "Must enable aiming with aim_at() before moving aim" );
    self endon( "stop_aiming" );
    self endon( "death" );
    enemy endon( "death" );
    
    if ( !isdefined( tag ) )
    {
        tag = "tag_origin";
    }
    
    if ( !isdefined( acquire_time ) )
    {
        acquire_time = 3;
    }
    
    if ( !isdefined( var_dc102d0a3fa40d6c ) )
    {
        var_dc102d0a3fa40d6c = 50;
    }
    
    if ( !isdefined( var_3c6327d2dc93eeb9 ) )
    {
        var_3c6327d2dc93eeb9 = 1;
    }
    
    /#
        if ( !isdefined( enable_debug ) )
        {
            enable_debug = 0;
        }
    #/
    
    var_12ad39f0f512b167 = enemy gettagorigin( tag );
    noise_offset = var_dc102d0a3fa40d6c;
    var_f9803f210f99196a = enemy.origin;
    var_2c0637398aff5042 = var_dc102d0a3fa40d6c / acquire_time;
    start_speed = distance( self.aim_target.origin, var_12ad39f0f512b167 ) / acquire_time;
    
    while ( distancesquared( self.aim_target.origin, enemy gettagorigin( tag ) ) > 5 )
    {
        delta_time = 0.05;
        
        if ( randomfloat( 100 ) > 50 )
        {
            noise_vec = enemy localtoworldcoords( ( 0, 0, noise_offset ) );
        }
        else
        {
            noise_vec = enemy localtoworldcoords( ( 0, 0, noise_offset * -1 ) );
        }
        
        final_destination = noise_vec - enemy.origin + enemy gettagorigin( tag );
        var_f6101d58d76925eb = self.aim_target.origin;
        enemy_speed = length( enemy.origin - var_f9803f210f99196a ) / delta_time;
        speed = enemy_speed + start_speed;
        direction = vectornormalize( final_destination - var_f6101d58d76925eb );
        velocity = direction * speed * delta_time;
        
        /#
            if ( enable_debug )
            {
                thread draw_angles( ( 0, 0, 0 ), final_destination );
                line( var_f6101d58d76925eb, var_f6101d58d76925eb + direction, ( 0, 1, 0 ) );
                line( var_f6101d58d76925eb + direction, final_destination, ( 1, 0, 0 ) );
            }
        #/
        
        noise_offset -= var_2c0637398aff5042 * delta_time;
        noise_offset = clamp( noise_offset, 0, var_dc102d0a3fa40d6c );
        var_f9803f210f99196a = enemy.origin;
        move_aim_to( var_f6101d58d76925eb + velocity, delta_time, 0.001, 0.001 );
    }
    
    if ( var_3c6327d2dc93eeb9 )
    {
        self.aim_target.origin += vectornormalize( self gettagorigin( "tag_flash" ) - self.aim_target.origin ) * 20;
        link_aim_to( enemy, tag );
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 0
// Checksum 0x0, Offset: 0x1ec9
// Size: 0x66
function stop_aiming()
{
    self notify( "stop_aiming" );
    aim_at_laser_off();
    
    if ( isdefined( self.aim_target ) )
    {
        self clearentitytarget();
        self.aim_target delete();
        self.aim_target = undefined;
    }
    
    self.suppress_uselastenemysightpos = 0;
    self.dontgiveuponsuppression = undefined;
    self.forcesuppressai = 0;
    self.lastenemysightpos = undefined;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0x1f37
// Size: 0x14b
function move_aim_along_spline( start_struct, var_fc410ce8bf19dac9 )
{
    self endon( "stop_aiming" );
    self endon( "death" );
    assertex( isdefined( self.aim_target ), "Must enable aiming with aim_at() before moving aim" );
    assertex( isdefined( start_struct ), "Must pass in starting struct in spline to move_aim_along_spline()" );
    assertex( isdefined( var_fc410ce8bf19dac9 ), "Must pass in how long to aim along spline to move_aim_along_spline()" );
    spline_dist = 0;
    
    for ( current_struct = start_struct; isdefined( current_struct.target ) ; current_struct = current_struct.next )
    {
        current_struct.next = getstruct( current_struct.target, "targetname" );
        current_struct.dist_to_next = distance( current_struct.next.origin, current_struct.origin );
        spline_dist += current_struct.dist_to_next;
    }
    
    for ( current_struct = start_struct; isdefined( current_struct.target ) ; current_struct = current_struct.next )
    {
        aim_time = current_struct.dist_to_next / spline_dist * var_fc410ce8bf19dac9;
        move_aim_to( current_struct.next.origin, aim_time );
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 4
// Checksum 0x0, Offset: 0x208a
// Size: 0x2f4
function aim_search_around( var_eb0c52046ed75b79, var_3dce490e575954cb, var_c1c6436496d9b6e8, var_4af84bd7b4e025ca )
{
    self endon( "stop_aiming" );
    self endon( "stop_searching" );
    self endon( "death" );
    
    if ( !isdefined( var_eb0c52046ed75b79 ) )
    {
        var_eb0c52046ed75b79 = -15;
    }
    else
    {
        var_eb0c52046ed75b79 *= -1;
        var_eb0c52046ed75b79 = clamp( var_eb0c52046ed75b79, -30, 30 );
    }
    
    if ( !isdefined( var_3dce490e575954cb ) )
    {
        var_3dce490e575954cb = 15;
    }
    else
    {
        var_3dce490e575954cb *= -1;
        var_3dce490e575954cb = clamp( var_3dce490e575954cb, -30, 30 );
    }
    
    if ( !isdefined( var_c1c6436496d9b6e8 ) )
    {
        var_c1c6436496d9b6e8 = 45;
    }
    else
    {
        var_c1c6436496d9b6e8 = clamp( var_c1c6436496d9b6e8, -90, 90 );
    }
    
    if ( !isdefined( var_4af84bd7b4e025ca ) )
    {
        var_4af84bd7b4e025ca = -45;
    }
    else
    {
        var_4af84bd7b4e025ca = clamp( var_4af84bd7b4e025ca, -90, 90 );
    }
    
    /#
        thread debug_aiming();
    #/
    
    while ( true )
    {
        if ( randomfloat( 100 ) > 50 )
        {
            vert_angle = var_3dce490e575954cb;
        }
        else
        {
            vert_angle = var_eb0c52046ed75b79;
        }
        
        if ( randomfloat( 100 ) > 50 )
        {
            horiz_angle = var_4af84bd7b4e025ca;
        }
        else
        {
            horiz_angle = var_c1c6436496d9b6e8;
        }
        
        deltatime = 0.05;
        time_elapsed = 0;
        search_target = self.aim_target.origin;
        
        while ( time_elapsed < 4 )
        {
            muzzle_height = self gettagorigin( "tag_flash" )[ 2 ];
            
            if ( length( self.velocity ) > 0 )
            {
                check_angles = vectortoangles( self.velocity );
            }
            else
            {
                check_angles = self.angles;
            }
            
            search_angles = check_angles + ( vert_angle, horiz_angle, 0 );
            search_vector = anglestoforward( search_angles ) * 75;
            search_start = ( self.origin[ 0 ], self.origin[ 1 ], muzzle_height );
            search_target = search_start + search_vector;
            
            /#
                if ( getdvarint( @"hash_500912e607f2c429" ) )
                {
                    thread draw_angles( search_angles, search_target, ( 0, 0, 1 ), 1, 10 );
                }
            #/
            
            var_bd6328b6f6b2add8 = search_target - self.aim_target.origin;
            var_1db13f6a6eb165a9 = length( var_bd6328b6f6b2add8 );
            var_a2b39965224cb294 = vectornormalize( var_bd6328b6f6b2add8 );
            var_f8e3f290a434df80 = var_1db13f6a6eb165a9 / ( 4 - time_elapsed );
            var_3d4f8d9283542d92 = var_a2b39965224cb294 * var_f8e3f290a434df80 + self.velocity;
            move_aim_to( self.aim_target.origin + var_3d4f8d9283542d92 * deltatime, deltatime, 1e-05, 1e-05 );
            time_elapsed += deltatime;
        }
        
        self.aim_target.origin = search_target;
    }
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 0
// Checksum 0x0, Offset: 0x2386
// Size: 0xa
function stop_aim_search_around()
{
    self notify( "stop_searching" );
}

/#

    // Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
    // Params 0
    // Checksum 0x0, Offset: 0x2398
    // Size: 0x10b, Type: dev
    function debug_aiming()
    {
        self endon( "<dev string:x154>" );
        setdvarifuninitialized( @"hash_500912e607f2c429", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_500912e607f2c429" ) )
            {
                self.aim_target childthread draw_ent_axis();
                childthread draw_line_for_time( self gettagorigin( "<dev string:x160>" ), self.aim_target.origin, 1, 0, 0, 0.05 );
                
                if ( isdefined( self.aim_laser ) )
                {
                    dist = distance( self.aim_laser.origin, self.aim_target.origin );
                    childthread draw_line_for_time( self.aim_laser.origin, self.aim_laser.origin + anglestoforward( self.aim_laser.angles ) * dist, 0, 1, 0, 0.05 );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0x24ab
// Size: 0x76
function function_64c20cb1068f5051( teleport_node, spawner_name )
{
    spawner_name = default_to( spawner_name, "gaz" );
    
    if ( isdefined( level.gaz ) )
    {
        if ( level.gaz.birthtime == gettime() )
        {
            waitframe();
        }
        
        delete_ally( level.gaz, spawner_name );
    }
    
    level.gaz = spawn_ally( teleport_node, spawner_name );
    return level.gaz;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0x252a
// Size: 0x76
function spawn_soap( teleport_node, spawner_name )
{
    spawner_name = default_to( spawner_name, "soap" );
    
    if ( isdefined( level.soap ) )
    {
        if ( level.soap.birthtime == gettime() )
        {
            waitframe();
        }
        
        delete_ally( level.soap, spawner_name );
    }
    
    level.soap = spawn_ally( teleport_node, spawner_name );
    return level.soap;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0x25a9
// Size: 0xa8
function spawn_ghost( teleport_node, spawner_name )
{
    spawner_name = default_to( spawner_name, "ghost" );
    
    if ( isdefined( level.ghost ) )
    {
        if ( level.ghost.birthtime == gettime() )
        {
            waitframe();
        }
        
        delete_ally( level.ghost, spawner_name );
    }
    
    level.ghost = spawn_ally( teleport_node, spawner_name );
    level.ghost.name = "Ghost";
    level.ghost.agentname = &"CP_JUP_CHEMICAL/GHOST";
    return level.ghost;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2
// Checksum 0x0, Offset: 0x265a
// Size: 0x76
function spawn_farah( teleport_node, spawner_name )
{
    spawner_name = default_to( spawner_name, "farah" );
    
    if ( isdefined( level.farah ) )
    {
        if ( level.farah.birthtime == gettime() )
        {
            waitframe();
        }
        
        delete_ally( level.farah, spawner_name );
    }
    
    level.farah = spawn_ally( teleport_node, spawner_name );
    return level.farah;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x26d9
// Size: 0x99
function private spawn_ally( teleport_node, spawner_name )
{
    spawner = function_7a18da6e48b71c35( spawner_name );
    ally_ai = spawner spawn_ai();
    ally_ai.goalradius = 8;
    ally_ai.animname = "guy";
    
    if ( isdefined( teleport_node ) )
    {
        ally_ai forceteleport( teleport_node.origin, teleport_node.angles );
        ally_ai setgoalpos( teleport_node.origin );
    }
    
    ally_ai.invulnerable = 1;
    return ally_ai;
}

// Namespace namespace_9871da81deb2e4b0 / namespace_a0852b262a68d01
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x277b
// Size: 0x6a
function private delete_ally( ally, spawner_name )
{
    if ( !isdefined( ally ) )
    {
        ally = self;
        assertex( isdefined( ally ) && isai( ally ), "Attempting to delete undefined or something that isn't an AI in delete_ally()" );
    }
    
    ally.invulnerable = 0;
    ally scripts\cp_mp\agents\agent_utils::despawnagent();
    ally_spawner = function_7a18da6e48b71c35( spawner_name );
    ally_spawner.count = 1;
}

