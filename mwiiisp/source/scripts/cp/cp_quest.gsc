#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace cp_quest;

// Namespace cp_quest / scripts\cp\cp_quest
// Params 0
// Checksum 0x0, Offset: 0x80
// Size: 0x2a
function init_quest_system()
{
    level.zombie_quests = [];
    level.zombie_current_quest_step_index = [];
    level.zombie_quest_complete_up_to_quest_step_index = [];
    level.num_of_quest_pieces_completed = 0;
}

// Namespace cp_quest / scripts\cp\cp_quest
// Params 0
// Checksum 0x0, Offset: 0xb2
// Size: 0x79
function start_quest_system()
{
    /#
        level thread debug_activation( @"hash_e9b5bb932cba9edc", &function_b537ff3784cebcc6 );
    #/
    
    if ( is_codxp() )
    {
        return;
    }
    
    foreach ( var_509f0abe2daf407f in level.zombie_quests )
    {
        level thread start_quest_line( quest_name );
    }
}

// Namespace cp_quest / scripts\cp\cp_quest
// Params 1
// Checksum 0x0, Offset: 0x133
// Size: 0xb2
function start_quest_line( quest_name )
{
    var_509f0abe2daf407f = level.zombie_quests[ quest_name ];
    level.zombie_quest_complete_up_to_quest_step_index[ quest_name ] = -1;
    
    foreach ( step_index, var_d785e0bc38b7afad in var_509f0abe2daf407f )
    {
        level.zombie_current_quest_step_index[ quest_name ] = step_index;
        [[ var_d785e0bc38b7afad.init_func ]]();
        
        if ( should_do_quest_step_func( quest_name, step_index ) )
        {
            [[ var_d785e0bc38b7afad.quest_step_func ]]();
        }
        
        [[ var_d785e0bc38b7afad.complete_func ]]();
    }
}

// Namespace cp_quest / scripts\cp\cp_quest
// Params 6
// Checksum 0x0, Offset: 0x1ed
// Size: 0xc4
function register_quest_step( quest_name, step_index, init_func, quest_step_func, complete_func, debug_beat_func )
{
    if ( !isdefined( level.zombie_quests[ quest_name ] ) )
    {
        level.zombie_quests[ quest_name ] = [];
    }
    
    if ( !isdefined( level.zombie_quest_complete_up_to_quest_step_index[ quest_name ] ) )
    {
        level.zombie_quest_complete_up_to_quest_step_index[ quest_name ] = -1;
    }
    
    var_d785e0bc38b7afad = spawnstruct();
    var_d785e0bc38b7afad.init_func = init_func;
    var_d785e0bc38b7afad.quest_step_func = quest_step_func;
    var_d785e0bc38b7afad.complete_func = complete_func;
    var_d785e0bc38b7afad.debug_beat_func = debug_beat_func;
    level.zombie_quests[ quest_name ][ step_index ] = var_d785e0bc38b7afad;
}

// Namespace cp_quest / scripts\cp\cp_quest
// Params 2
// Checksum 0x0, Offset: 0x2b9
// Size: 0x20, Type: bool
function should_do_quest_step_func( quest_name, step_index )
{
    return step_index > level.zombie_quest_complete_up_to_quest_step_index[ quest_name ];
}

// Namespace cp_quest / scripts\cp\cp_quest
// Params 1
// Checksum 0x0, Offset: 0x2e2
// Size: 0x17, Type: bool
function quest_line_exist( quest_name )
{
    return isdefined( level.zombie_quests[ quest_name ] );
}

/#

    // Namespace cp_quest / scripts\cp\cp_quest
    // Params 1
    // Checksum 0x0, Offset: 0x302
    // Size: 0xb0, Type: dev
    function function_b537ff3784cebcc6( var_989eaba483ac52da )
    {
        var_989eaba483ac52da = strtok( var_989eaba483ac52da, "<dev string:x1c>" );
        quest_name = var_989eaba483ac52da[ 0 ];
        complete_up_to_quest_step_index = int( var_989eaba483ac52da[ 1 ] );
        
        if ( !isdefined( level.zombie_current_quest_step_index[ quest_name ] ) )
        {
            return;
        }
        
        current_quest_step_index = level.zombie_current_quest_step_index[ quest_name ];
        
        if ( current_quest_step_index > complete_up_to_quest_step_index )
        {
            iprintlnbold( "<dev string:x1e>" + quest_name + "<dev string:x42>" );
            return;
        }
        
        level.zombie_quest_complete_up_to_quest_step_index[ quest_name ] = complete_up_to_quest_step_index;
        var_92e889285ed0b482 = level.zombie_quests[ quest_name ][ current_quest_step_index ];
        [[ var_92e889285ed0b482.debug_beat_func ]]();
    }

#/
