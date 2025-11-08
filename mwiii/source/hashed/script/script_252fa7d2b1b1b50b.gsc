#using script_640cf1641c03e2a0;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_heli_reinforce;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\poi;

#namespace namespace_f3c963e429e76c8d;

// Namespace namespace_f3c963e429e76c8d / namespace_8d9453d94dd4f401
// Params 0
// Checksum 0x0, Offset: 0x139
// Size: 0x9
function function_fa326688eafcb0e5()
{
    function_5efe196c4c230159();
}

// Namespace namespace_f3c963e429e76c8d / namespace_8d9453d94dd4f401
// Params 3
// Checksum 0x0, Offset: 0x14a
// Size: 0x22
function function_a8c998f28b4865b4( circle_origin, circle_radius, threshold_radius )
{
    function_5efe196c4c230159();
}

// Namespace namespace_f3c963e429e76c8d / namespace_8d9453d94dd4f401
// Params 0
// Checksum 0x0, Offset: 0x174
// Size: 0x157
function function_5efe196c4c230159()
{
    foreach ( category in level.var_93e65c79243ea01a )
    {
        agents = aibudgetmp_getagentsanddormantsincategory( category );
        
        foreach ( agent in agents )
        {
            if ( isint( agent ) )
            {
                infopackage = level.var_879053468f168806[ agent ];
                
                if ( !scripts\mp\gametypes\br_circle_util::ispointindangercircle( infopackage.origin ) )
                {
                    scripts\cp_mp\agents\agent_utils::function_4e065f1747aadd51( agent, category );
                }
                
                continue;
            }
            
            if ( isdefined( agent.chute ) || isdefined( agent.ridingvehicle ) )
            {
                continue;
            }
            
            if ( isdefined( agent.birthtime ) && gettime() < agent.birthtime + 10000 )
            {
                continue;
            }
            
            if ( !scripts\mp\gametypes\br_circle_util::ispointindangercircle( agent.origin ) )
            {
                scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata( agent, "killedByGas", 1 );
                agent kill();
            }
        }
    }
}

// Namespace namespace_f3c963e429e76c8d / namespace_8d9453d94dd4f401
// Params 1
// Checksum 0x0, Offset: 0x2d3
// Size: 0x4e
function function_b146e2b40516b668( category )
{
    if ( !isdefined( level.var_93e65c79243ea01a ) )
    {
        level.var_93e65c79243ea01a = [];
        scripts\mp\gametypes\br_circle::registercirclecallbacks( 11, &function_a8c998f28b4865b4, &function_fa326688eafcb0e5 );
    }
    
    level.var_93e65c79243ea01a = function_6d6af8144a5131f1( level.var_93e65c79243ea01a, category );
}

// Namespace namespace_f3c963e429e76c8d / namespace_8d9453d94dd4f401
// Params 1
// Checksum 0x0, Offset: 0x329
// Size: 0x32
function function_91eeda4f6ea1daf( category )
{
    if ( !isdefined( level.var_93e65c79243ea01a ) )
    {
        return;
    }
    
    level.var_93e65c79243ea01a = array_remove( level.var_93e65c79243ea01a, category );
}

// Namespace namespace_f3c963e429e76c8d / namespace_8d9453d94dd4f401
// Params 4
// Checksum 0x0, Offset: 0x363
// Size: 0x328
function spawn_reinforcements( location, requests, var_461b8c89eb0f0715, params )
{
    assertex( isdefined( var_461b8c89eb0f0715 ) && var_461b8c89eb0f0715.size > 0, "<dev string:x1c>" );
    assertex( isdefined( requests ) && requests.size > 0, "<dev string:x7b>" );
    ai_category = "everyone";
    ai_subcategory = undefined;
    ai_priority = "high";
    force_closest = 0;
    var_8fb0afec6ee6a75 = 10000;
    
    if ( isdefined( params ) )
    {
        if ( isdefined( params.ai_category ) )
        {
            ai_category = params.ai_category;
        }
        
        if ( isdefined( params.ai_subcategory ) )
        {
            ai_subcategory = params.ai_subcategory;
        }
        
        if ( isdefined( params.ai_priority ) )
        {
            ai_priority = params.ai_priority;
        }
        
        if ( isdefined( params.force_closest ) )
        {
            force_closest = params.force_closest;
        }
        
        if ( isdefined( params.var_8fb0afec6ee6a75 ) )
        {
            var_8fb0afec6ee6a75 = params.var_8fb0afec6ee6a75;
        }
    }
    
    agents = [];
    var_2984a3a7b3c051a7 = getclosestpointonnavmesh( location );
    group_name = scripts\mp\ai_mp_controller::function_78759441c259f58a();
    poi_name = scripts\mp\poi::poi_findPOIOriginIsIn( var_2984a3a7b3c051a7 );
    
    foreach ( type in var_461b8c89eb0f0715 )
    {
        if ( issubstr( type, "heli" ) && istrue( level.var_425df8e23aaef18c ) )
        {
            var_9a5a0701386ac693 = scripts\mp\ai_mp_controller::function_b9d78fce07834c95( requests );
            var_51900af8e34c7d04 = scripts\mp\ai_heli_reinforce::function_3779deb97b61a65( requests.size, var_2984a3a7b3c051a7, ai_priority, ai_category, ai_subcategory, group_name, "team_hundred_ninety_five", force_closest, poi_name, 256, 512, var_9a5a0701386ac693, 1, 0 );
            
            if ( isdefined( var_51900af8e34c7d04 ) )
            {
                agents = var_51900af8e34c7d04;
            }
        }
        else if ( issubstr( type, "para" ) && isdefined( level.parareinforcestruct ) )
        {
            var_9a5a0701386ac693 = scripts\mp\ai_mp_controller::function_b9d78fce07834c95( requests );
            var_63f6f0241fc2a71e = namespace_885300a47c2b51e6::function_55ab9c6da96226e7( requests.size, var_2984a3a7b3c051a7, var_8fb0afec6ee6a75, var_9a5a0701386ac693, ai_priority, ai_category, ai_subcategory, "team_hundred_ninety_five", force_closest, poi_name, undefined, undefined, 1, 1, 1, 256 );
            
            if ( isdefined( var_63f6f0241fc2a71e ) )
            {
                agents = var_63f6f0241fc2a71e;
            }
        }
        else if ( issubstr( type, "closet" ) )
        {
            var_9a5a0701386ac693 = scripts\mp\ai_mp_controller::function_b9d78fce07834c95( requests );
            var_586efc1d3caf3644 = scripts\mp\ai_mp_controller::function_9ea6eddb437eaca5( requests.size, var_2984a3a7b3c051a7, ai_priority, ai_category, ai_subcategory, group_name, "team_hundred_ninety_five", force_closest, poi_name, undefined, undefined, 256 );
            
            if ( isdefined( var_586efc1d3caf3644 ) )
            {
                agents = var_586efc1d3caf3644;
            }
        }
        else if ( issubstr( type, "safe" ) )
        {
            agents = function_3c4b94287bc8e5f9( var_2984a3a7b3c051a7, requests, poi_name, group_name, params );
        }
        else
        {
            println( "<dev string:xd6>" + type );
        }
        
        if ( agents.size > 0 )
        {
            break;
        }
    }
    
    if ( agents.size <= 0 )
    {
        println( "<dev string:x10e>" );
    }
    
    return agents;
}

// Namespace namespace_f3c963e429e76c8d / namespace_8d9453d94dd4f401
// Params 5
// Checksum 0x0, Offset: 0x694
// Size: 0x166
function function_3c4b94287bc8e5f9( location, requests, poi_name, group_name, params )
{
    safe_points = [];
    agents = [];
    safe_points = function_f94be34470ee3bad( location, requests.size, params.var_a78daf96b4bdf866, params.var_1b20f5fb6aee28f7, params.var_cf0b51ba5e529a7 );
    
    if ( safe_points.size < requests.size )
    {
        println( "<dev string:x148>" );
        return agents;
    }
    
    foreach ( index, request in requests )
    {
        ai_type = scripts\mp\ai_mp_controller::function_7f1a2e2ebe0c1693( request.type, request.tier, request.nationality );
        agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent( ai_type, safe_points[ index ], ( 0, 0, 0 ), params.ai_priority, params.ai_category, undefined, group_name, "team_hundred_ninety_five", undefined, poi_name, 1, 0, 0, undefined, 0 );
        
        if ( isdefined( agent ) )
        {
            agents[ agents.size ] = agent;
            agent thread scripts\mp\ai_behavior::function_9bbf1713a14fa580( agent, 256, 256, location );
        }
        
        waitframe();
    }
    
    return agents;
}

// Namespace namespace_f3c963e429e76c8d / namespace_8d9453d94dd4f401
// Params 5
// Checksum 0x0, Offset: 0x803
// Size: 0x149
function function_f94be34470ee3bad( location, spawn_count, spawn_distance, spawn_radius, squad_size )
{
    safe_points = [];
    var_48fcd52a851c7579 = squared( spawn_distance - spawn_radius );
    
    if ( !isdefined( spawn_distance ) )
    {
        spawn_distance = 1500;
    }
    
    if ( !isdefined( spawn_radius ) )
    {
        spawn_radius = 500;
    }
    
    for ( i = 0; i < 15 ; i++ )
    {
        searchpoint = location + vectornormalize( function_6174330574a2a273() ) * spawn_distance;
        spawnpoints = getrandomnavpoints( getclosestpointonnavmesh( searchpoint ), spawn_radius, squad_size );
        
        foreach ( point in spawnpoints )
        {
            if ( abs( point[ 2 ] - location[ 2 ] ) > 60 )
            {
                continue;
            }
            
            distsq = distance2dsquared( point, location );
            
            if ( distsq >= var_48fcd52a851c7579 && scripts\mp\ai_behavior::function_5867290fda7a1ac1( point, 64, 1000, 128 ) )
            {
                safe_points[ safe_points.size ] = point;
            }
            
            if ( safe_points.size >= spawn_count )
            {
                return safe_points;
            }
        }
        
        waitframe();
    }
    
    return safe_points;
}

