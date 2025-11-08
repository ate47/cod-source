#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\spawner;

#namespace ai;

// Namespace ai / scripts\sp\ai
// Params 1
// Checksum 0x0, Offset: 0x37e
// Size: 0x40
function function_b1e9f30ceb841994( aigroup_name )
{
    assertex( isdefined( aigroup_name ), "get_group_touching_volume: aigroup_name is undefined to get group" );
    guys = get_ai_group_ai( aigroup_name );
    guys_touching = function_359a5497e23b8f79( guys );
    return guys_touching;
}

// Namespace ai / scripts\sp\ai
// Params 1
// Checksum 0x0, Offset: 0x3c7
// Size: 0x87
function function_359a5497e23b8f79( array )
{
    guys_touching = [];
    assertex( isarray( array ), "array_touching_volume: array is undefined or not an array" );
    
    foreach ( guy in array )
    {
        if ( isalive( guy ) && self istouching( guy ) )
        {
            guys_touching[ guys_touching.size ] = guy;
        }
    }
    
    return guys_touching;
}

// Namespace ai / scripts\sp\ai
// Params 4
// Checksum 0x0, Offset: 0x457
// Size: 0x35
function function_b602e9a854dcd12f( array, deadcount, flagname, timeout )
{
    if ( isdefined( flagname ) )
    {
        level endon( flagname );
    }
    
    waittill_dead_or_dying( array, deadcount, timeout );
}

// Namespace ai / scripts\sp\ai
// Params 1
// Checksum 0x0, Offset: 0x494
// Size: 0x69
function go_to_node_targetname( targetname )
{
    self endon( "death" );
    assertex( isdefined( targetname ), "go_to_node_targetname: targetname is undefined" );
    self cleargoalvolume();
    goals = get_target_goals( targetname );
    assertex( goals.size > 0, "go_to_node_targetname: could not find goal of any type with targetname: " + targetname );
    thread go_to_node( goals );
    waittill_either( "goal", "stop_going_to_node" );
}

// Namespace ai / scripts\sp\ai
// Params 3
// Checksum 0x0, Offset: 0x505
// Size: 0xb2
function function_70c375ef912c3fc1( array, targetname, randomdelay )
{
    assertex( isdefined( array ), "array_set_goal: array is undefined" );
    assertex( isdefined( targetname ), "array_set_goal: targetname is undefined" );
    
    foreach ( ai in array )
    {
        if ( isalive( ai ) )
        {
            if ( isdefined( randomdelay ) && randomdelay > 0 )
            {
                ai delaythread( randomfloat( randomdelay ), &go_to_node_targetname, targetname );
                continue;
            }
            
            ai thread go_to_node_targetname( targetname );
        }
    }
}

// Namespace ai / scripts\sp\ai
// Params 6
// Checksum 0x0, Offset: 0x5bf
// Size: 0x6f
function function_12c55fcbaa7c5346( array, targetname, deadcount, flagname, timeout, randomdelay )
{
    assertex( isdefined( targetname ), "array_set_goal_on_death: targetname is undefined" );
    
    if ( isdefined( deadcount ) && deadcount > 0 )
    {
        function_b602e9a854dcd12f( array, deadcount, flagname, timeout );
    }
    
    array = array_removedead_or_dying( array );
    level thread function_70c375ef912c3fc1( array, targetname, randomdelay );
}

// Namespace ai / scripts\sp\ai
// Params 7
// Checksum 0x0, Offset: 0x636
// Size: 0x91
function function_f2222194b84d7787( team, species, targetname, deadcount, flagname, timeout, randomdelay )
{
    assertex( isdefined( team ) || isdefined( species ), "team_set_goal: team and species is undefined" );
    assertex( isdefined( targetname ), "team_set_goal: targetname is undefined" );
    
    if ( !isdefined( species ) )
    {
        species = "all";
    }
    
    guys = getaispeciesarray( team, species );
    function_12c55fcbaa7c5346( guys, targetname, deadcount, flagname, timeout, randomdelay );
}

// Namespace ai / scripts\sp\ai
// Params 6
// Checksum 0x0, Offset: 0x6cf
// Size: 0x74
function function_105b3c0f7ba8cd09( aigroup_name, targetname, deadcount, flagname, timeout, randomdelay )
{
    assertex( isdefined( aigroup_name ), "group_ai_set_goal: aigroup_name for group_ai is undefined" );
    assertex( isdefined( targetname ), "group_ai_set_goal: targetname is undefined" );
    guys = get_ai_group_ai( aigroup_name );
    function_12c55fcbaa7c5346( guys, targetname, deadcount, flagname, timeout, randomdelay );
}

// Namespace ai / scripts\sp\ai
// Params 3
// Checksum 0x0, Offset: 0x74b
// Size: 0x6d
function function_807f22c65e631b07( array, deadcount, flagname )
{
    assertex( isdefined( array ) && isarray( array ), "flag_set_on_group_ai_count: array is undefined or not an array" );
    assertex( isdefined( deadcount ) && deadcount >= 0, "flag_set_on_group_ai_count: deadCount is undefined or less than 0" );
    assertex( isdefined( flagname ), "flag_set_on_group_ai_count: flagName is undefined" );
    waittill_dead_or_dying( array, deadcount );
    flag_set( flagname );
}

