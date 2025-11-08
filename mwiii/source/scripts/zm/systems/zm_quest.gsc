#using script_292b2f4fcd5999c8;
#using script_9880b9dc28bc25e;
#using scripts\common\devgui;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\powerups\nuke;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\zm\systems\zm_cleanup_mgr;

#namespace zm_quest;

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 6
// Checksum 0x0, Offset: 0x254
// Size: 0x35c
function register_quest_step( name, step_path, setup_func, cleanup_func, var_6484f2dfb4447680, var_2157e2d0d4c8d28 )
{
    self._quest = default_to( self._quest, [] );
    
    if ( !isdefined( self._quest[ name ] ) )
    {
        self._quest[ name ] = spawnstruct();
        self._quest[ name ].name = name;
        self._quest[ name ].completed = 0;
        self._quest[ name ].steps = [];
        self._quest[ name ].current_step = 0;
        self._quest[ name ].started = 0;
        self._quest[ name ].owner = self;
        self._quest[ name ].quitted = 0;
        
        /#
            function_93119194066b1e22( name );
        #/
    }
    
    quest = self._quest[ name ];
    step_path = function_e84a5f30606d3a09( step_path, "/" );
    step_tree = strtok( step_path, "/" );
    parent_step = quest;
    var_b09501f0b31dbd97 = "";
    
    for ( tree_depth = 0; tree_depth < step_tree.size ; tree_depth++ )
    {
        child_name = step_tree[ tree_depth ];
        var_b09501f0b31dbd97 += child_name;
        parent_exists = 0;
        
        foreach ( substep in parent_step.steps )
        {
            if ( substep.name == child_name )
            {
                var_b09501f0b31dbd97 += "/";
                parent_step = substep;
                parent_exists = 1;
                break;
            }
        }
        
        if ( parent_exists )
        {
            continue;
        }
        
        var_d4efb65f7dc3c54b = parent_step.steps.size;
        parent_step.steps[ var_d4efb65f7dc3c54b ] = spawnstruct();
        child_step = parent_step.steps[ var_d4efb65f7dc3c54b ];
        child_step.name = child_name;
        child_step.path = var_b09501f0b31dbd97;
        child_step.index = var_d4efb65f7dc3c54b;
        child_step.quest = quest;
        child_step.steps = [];
        child_step.completed_steps = [];
        child_step.started = 0;
        child_step.completed = 0;
        child_step.cleaned_up = 0;
        child_step.b_skipped = 0;
        child_step.setup_completed = 0;
        
        if ( tree_depth == step_tree.size - 1 )
        {
            child_step.var_6484f2dfb4447680 = var_6484f2dfb4447680;
            child_step.var_2157e2d0d4c8d28 = var_2157e2d0d4c8d28;
            child_step.setup_func = setup_func;
            child_step.cleanup_func = cleanup_func;
        }
        
        /#
            function_6e2f110fb0d51295( name, child_step );
        #/
        
        var_b09501f0b31dbd97 += "/";
        parent_step = child_step;
    }
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 1
// Checksum 0x0, Offset: 0x5b8
// Size: 0x8f
function function_130bebe39cfc66c2( str_flag )
{
    level._quest = default_to( level._quest, [] );
    level._quest[ "busy_flags" ] = default_to( level._quest[ "busy_flags" ], [] );
    
    if ( isdefined( str_flag ) && !array_contains( level._quest[ "busy_flags" ], str_flag ) )
    {
        level._quest[ "busy_flags" ] = function_6d6af8144a5131f1( level._quest[ "busy_flags" ], str_flag );
    }
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 1
// Checksum 0x0, Offset: 0x64f
// Size: 0x76
function function_428c84c854f1154b( str_flag )
{
    level._quest[ "busy_flags" ] = default_to( level._quest[ "busy_flags" ], [] );
    
    if ( isdefined( str_flag ) && array_contains( level._quest[ "busy_flags" ], str_flag ) )
    {
        level._quest[ "busy_flags" ] = array_remove( level._quest[ "busy_flags" ], str_flag );
    }
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 1
// Checksum 0x0, Offset: 0x6cd
// Size: 0xa0, Type: bool
function function_607fa935bb0f4dab( var_ce232ccaa493471 )
{
    assertex( isarray( level._quest[ "<dev string:x1c>" ] ), "<dev string:x2a>" );
    
    foreach ( s_flag in level._quest[ "busy_flags" ] )
    {
        if ( istrue( var_ce232ccaa493471 ) && s_flag == "special_round_is_ongoing" )
        {
            continue;
        }
        
        if ( flag( s_flag ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 1
// Checksum 0x0, Offset: 0x776
// Size: 0x80
function start_quest( name )
{
    assertex( isdefined( self._quest ) && isdefined( self._quest[ name ] ), "<dev string:x5c>" + name );
    quest = self._quest[ name ];
    
    if ( quest.started )
    {
        return;
    }
    
    quest.started = 1;
    thread run_step( quest, quest.steps[ 0 ], undefined );
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 1
// Checksum 0x0, Offset: 0x7fe
// Size: 0xa6
function quit_quest( name )
{
    assertex( isdefined( self._quest ) && isdefined( self._quest[ name ] ), "<dev string:x5c>" + name );
    
    if ( !istrue( self._quest[ name ].started ) || istrue( self._quest[ name ].completed ) || istrue( self._quest[ name ].quitted ) )
    {
        return;
    }
    
    self._quest[ name ].quitted = 1;
    self notify( name + "_quitted" );
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x8ac
// Size: 0x489
function private run_step( quest, current_step, parent_step )
{
    level endon( "game_ended" );
    
    if ( isplayer( self ) )
    {
        self endon( "death" );
        self endon( "disconnect" );
    }
    
    if ( isdefined( parent_step ) && istrue( parent_step.var_2157e2d0d4c8d28 ) && current_step.index > 0 )
    {
        previous_step = parent_step.steps[ current_step.index - 1 ];
        waittill_any_3( quest.name + "_quitted", quest.name + "_completed", quest.name + "/" + previous_step.path + "_completed" );
        
        if ( quest.quitted || quest.completed )
        {
            return;
        }
    }
    
    current_step.started = 1;
    self notify( quest.name + "/" + current_step.path + "_started" );
    childthread function_525a39957e80f27( quest, current_step );
    
    if ( !quest.quitted && !current_step.completed && !current_step.setup_completed )
    {
        waittill_any_3( quest.name + "_quitted", quest.name + "/" + current_step.path + "_completed", quest.name + "/" + current_step.path + "_setup_completed" );
    }
    
    if ( current_step.steps.size > 0 )
    {
        foreach ( substep in current_step.steps )
        {
            thread run_step( quest, substep, current_step );
        }
    }
    else
    {
        current_step.completed = 1;
        self notify( quest.name + "/" + current_step.path + "_completed" );
    }
    
    if ( !quest.quitted && !current_step.completed )
    {
        waittill_any_2( quest.name + "_quitted", quest.name + "/" + current_step.path + "_completed" );
    }
    
    /#
        iprintlnbold( quest.name + "<dev string:x8c>" + current_step.path + "<dev string:x91>" );
    #/
    
    if ( isdefined( current_step.cleanup_func ) )
    {
        current_step [[ current_step.cleanup_func ]]( current_step.b_skipped );
    }
    
    current_step.cleaned_up = 1;
    self notify( quest.name + "/" + current_step.path + "_cleanup_completed" );
    
    if ( quest.quitted )
    {
        /#
            iprintlnbold( quest.name + "<dev string:x9f>" );
        #/
        
        return;
    }
    
    if ( isdefined( parent_step ) )
    {
        parent_step.completed_steps[ parent_step.completed_steps.size ] = current_step.name;
        var_6484f2dfb4447680 = ter_op( isdefined( parent_step.var_6484f2dfb4447680 ), parent_step.var_6484f2dfb4447680, parent_step.steps.size );
        
        if ( parent_step.completed_steps.size >= var_6484f2dfb4447680 )
        {
            parent_step.completed = 1;
            self notify( quest.name + "/" + parent_step.path + "_completed" );
        }
        
        return;
    }
    
    if ( quest.current_step < quest.steps.size - 1 )
    {
        quest.current_step += 1;
        thread run_step( quest, quest.steps[ quest.current_step ] );
        return;
    }
    
    quest.completed = 1;
    self notify( quest.name + "_completed" );
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0xd3d
// Size: 0xa8
function private function_525a39957e80f27( quest, step )
{
    self endon( quest.name + "_quitted" );
    self endon( quest.name + "/" + step.path + "_completed" );
    
    if ( isdefined( step.setup_func ) )
    {
        step [[ step.setup_func ]]( step.b_skipped );
    }
    
    step.setup_completed = 1;
    self notify( quest.name + "/" + step.path + "_setup_completed" );
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 11
// Checksum 0x0, Offset: 0xded
// Size: 0x116
function function_9fc5bb2a36b13c08( objective_name, priority, icon, iconsize, state, v_position, offset, str_label, str_desc, var_1d3465cc8293e5e6, var_a02f6121cced0715 )
{
    if ( !isarray( level.var_17d01e7983c2c1ce ) )
    {
        level.var_17d01e7983c2c1ce = [];
    }
    
    objectiveindex = scripts\mp\objidpoolmanager::requestobjectiveid( priority );
    level.var_17d01e7983c2c1ce[ objective_name ] = objectiveindex;
    scripts\mp\objidpoolmanager::update_objective_icon( objectiveindex, icon );
    scripts\mp\objidpoolmanager::function_c3c6bff089dfdd34( objectiveindex, iconsize );
    scripts\mp\objidpoolmanager::update_objective_state( objectiveindex, state );
    scripts\mp\objidpoolmanager::update_objective_position( objectiveindex, v_position );
    scripts\mp\objidpoolmanager::update_objective_setbackground( objectiveindex, 1 );
    
    if ( isdefined( offset ) )
    {
        scripts\mp\objidpoolmanager::update_objective_setzoffset( objectiveindex, offset );
    }
    
    if ( isistring( str_label ) )
    {
        objective_setlabel( objectiveindex, str_label );
    }
    
    if ( isistring( str_desc ) )
    {
        objective_setdescription( objectiveindex, str_desc );
    }
    
    if ( istrue( var_1d3465cc8293e5e6 ) )
    {
        objective_setshowoncompass( objectiveindex, var_1d3465cc8293e5e6 );
    }
    
    if ( istrue( var_a02f6121cced0715 ) )
    {
        scripts\mp\objidpoolmanager::objective_set_play_intro( objectiveindex, var_a02f6121cced0715 );
    }
    
    return objectiveindex;
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 11
// Checksum 0x0, Offset: 0xf0c
// Size: 0x116
function function_e61527dad992fbac( objective_name, priority, icon, iconsize, state, entity, offset, str_label, str_desc, var_1d3465cc8293e5e6, var_a02f6121cced0715 )
{
    if ( !isarray( level.var_17d01e7983c2c1ce ) )
    {
        level.var_17d01e7983c2c1ce = [];
    }
    
    objectiveindex = scripts\mp\objidpoolmanager::requestobjectiveid( priority );
    level.var_17d01e7983c2c1ce[ objective_name ] = objectiveindex;
    scripts\mp\objidpoolmanager::update_objective_icon( objectiveindex, icon );
    scripts\mp\objidpoolmanager::function_c3c6bff089dfdd34( objectiveindex, iconsize );
    scripts\mp\objidpoolmanager::update_objective_state( objectiveindex, state );
    scripts\mp\objidpoolmanager::update_objective_onentity( objectiveindex, entity );
    scripts\mp\objidpoolmanager::update_objective_setbackground( objectiveindex, 1 );
    
    if ( isdefined( offset ) )
    {
        scripts\mp\objidpoolmanager::update_objective_setzoffset( objectiveindex, offset );
    }
    
    if ( isistring( str_label ) )
    {
        objective_setlabel( objectiveindex, str_label );
    }
    
    if ( isistring( str_desc ) )
    {
        objective_setdescription( objectiveindex, str_desc );
    }
    
    if ( istrue( var_1d3465cc8293e5e6 ) )
    {
        objective_setshowoncompass( objectiveindex, var_1d3465cc8293e5e6 );
    }
    
    if ( istrue( var_a02f6121cced0715 ) )
    {
        scripts\mp\objidpoolmanager::objective_set_play_intro( objectiveindex, var_a02f6121cced0715 );
    }
    
    return objectiveindex;
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 1
// Checksum 0x0, Offset: 0x102b
// Size: 0xaf
function function_9c08bd32f79490f7( str_desc )
{
    text = newhudelem();
    text.alignx = "left";
    text.aligny = "middle";
    text.horzalign = "left";
    text.vertalign = "top";
    text.x = 15;
    text.y = 140;
    text.sort = 5;
    text.fontscale = 1;
    text.alpha = 1;
    text settext( str_desc );
    return text;
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 1
// Checksum 0x0, Offset: 0x10e3
// Size: 0x8f
function function_9659756622ccdb3d( var_2a115c3a0a3af326 )
{
    if ( isstring( var_2a115c3a0a3af326 ) )
    {
        if ( array_contains_key( level.var_17d01e7983c2c1ce, var_2a115c3a0a3af326 ) )
        {
            scripts\mp\objidpoolmanager::returnobjectiveid( level.var_17d01e7983c2c1ce[ var_2a115c3a0a3af326 ] );
            level.var_17d01e7983c2c1ce = array_remove_key( level.var_17d01e7983c2c1ce, var_2a115c3a0a3af326 );
        }
    }
    else
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( var_2a115c3a0a3af326 );
        level.var_17d01e7983c2c1ce = function_86a17f877dcf5dc2( level.var_17d01e7983c2c1ce, var_2a115c3a0a3af326 );
    }
    
    if ( level.var_17d01e7983c2c1ce.size == 0 )
    {
        level.var_17d01e7983c2c1ce = undefined;
    }
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 2
// Checksum 0x0, Offset: 0x117a
// Size: 0x71
function function_86a17f877dcf5dc2( ents, remover )
{
    newents = [];
    
    foreach ( key, item in ents )
    {
        if ( item == remover )
        {
            continue;
        }
        
        newents[ key ] = item;
    }
    
    return newents;
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 2
// Checksum 0x0, Offset: 0x11f4
// Size: 0xb1
function fake_physicslaunch( target_pos, power )
{
    start_pos = self.origin;
    gravity = getdvarint( @"bg_gravity", 0 ) * -1;
    dist = distance( start_pos, target_pos );
    time = dist / power;
    delta = target_pos - start_pos;
    drop = 0.5 * gravity * time * time;
    velocity = ( delta[ 0 ] / time, delta[ 1 ] / time, ( delta[ 2 ] - drop ) / time );
    self movegravity( velocity, time );
    return time;
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 2
// Checksum 0x0, Offset: 0x12ae
// Size: 0xa3
function force_zombie_goal( ent_or_struct, var_951cee2f1067e474 )
{
    level endon( "game_ended" );
    self endon( "death" );
    var_951cee2f1067e474 = default_to( var_951cee2f1067e474, 25 );
    namespace_5381a59d140f4df8::function_c0d3ba0eab1acba0( ent_or_struct );
    
    while ( true )
    {
        dis = distancesquared( self.origin, ent_or_struct.origin );
        
        /#
            sphere( ent_or_struct.origin, 15, ( 1, 0, 0 ), 0, 50 );
        #/
        
        if ( dis < squared( var_951cee2f1067e474 ) )
        {
            namespace_5381a59d140f4df8::function_6e660434fe00b495( ent_or_struct );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 0
// Checksum 0x0, Offset: 0x1359
// Size: 0x7ea
function function_dfbb96391a405a3e()
{
    level.var_af44283616b35663 = default_to( level.var_af44283616b35663, spawnstruct() );
    level.var_af44283616b35663.var_3af726873b4b5c1 = default_to( level.var_af44283616b35663.var_3af726873b4b5c1, spawnstruct() );
    level.var_af44283616b35663.var_fd03e124c44775e1 = default_to( level.var_af44283616b35663.var_fd03e124c44775e1, spawnstruct() );
    mapname = getdvar( @"ui_mapname" );
    var_edae6049f4f0016c = "cer_zm_inventory_" + mapname;
    
    if ( isdefined( var_edae6049f4f0016c ) )
    {
        var_eb707d7d55148f2f = getscriptbundle( "zminventory:" + var_edae6049f4f0016c );
    }
    
    if ( isdefined( var_eb707d7d55148f2f ) && isdefined( var_eb707d7d55148f2f.questitems ) )
    {
        level.var_af44283616b35663.var_3af726873b4b5c1.quests = [];
        level.var_af44283616b35663.var_3af726873b4b5c1.var_924f3a860ed29a58 = [];
        level.var_af44283616b35663.var_fd03e124c44775e1.quests = [];
        level.var_af44283616b35663.var_fd03e124c44775e1.var_924f3a860ed29a58 = [];
        
        foreach ( questindex, questitem in var_eb707d7d55148f2f.questitems )
        {
            if ( !isdefined( questitem.questitem ) )
            {
                continue;
            }
            
            quest = getscriptbundle( "zminventoryquest:" + questitem.questitem );
            
            if ( istrue( quest.var_87d9b137f0f401cc ) )
            {
                var_e016119ea3ac2220 = level.var_af44283616b35663.var_fd03e124c44775e1;
            }
            else
            {
                var_e016119ea3ac2220 = level.var_af44283616b35663.var_3af726873b4b5c1;
            }
            
            var_e016119ea3ac2220.quests[ quest.ref ] = spawnstruct();
            var_e016119ea3ac2220.quests[ quest.ref ].var_87d9b137f0f401cc = quest.var_87d9b137f0f401cc;
            var_e016119ea3ac2220.quests[ quest.ref ].var_bba2b6bd5bde4fc4 = quest.var_bba2b6bd5bde4fc4;
            var_e016119ea3ac2220.quests[ quest.ref ].index = questindex;
            var_e016119ea3ac2220.quests[ quest.ref ].ref = quest.ref;
            var_e016119ea3ac2220.quests[ quest.ref ].visible = quest.var_e4852323be50e26e;
            var_e016119ea3ac2220.quests[ quest.ref ].current_phase = 0;
            var_e016119ea3ac2220.quests[ quest.ref ].phases = [];
            var_e016119ea3ac2220.var_924f3a860ed29a58[ questindex ] = quest.ref;
            
            if ( isdefined( quest ) && isdefined( quest.phases ) )
            {
                phaseindex = 0;
                
                foreach ( phaseitem in quest.phases )
                {
                    phase = getscriptbundle( "zminventoryquestphase:" + phaseitem.phase );
                    var_e016119ea3ac2220.quests[ quest.ref ].phases[ phaseindex ] = spawnstruct();
                    var_e016119ea3ac2220.quests[ quest.ref ].phases[ phaseindex ].index = phaseindex;
                    var_e016119ea3ac2220.quests[ quest.ref ].phases[ phaseindex ].items = [];
                    
                    if ( isdefined( phase ) && isdefined( phase.items ) )
                    {
                        itemindex = 0;
                        
                        foreach ( inventoryitem in phase.items )
                        {
                            item = getscriptbundle( "zminventoryitem:" + inventoryitem.item );
                            var_e016119ea3ac2220.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ] = spawnstruct();
                            var_e016119ea3ac2220.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].index = itemindex;
                            var_e016119ea3ac2220.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].ref = item.ref;
                            var_e016119ea3ac2220.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].visible = item.var_e4852323be50e26e;
                            var_e016119ea3ac2220.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].current_stage = 0;
                            var_e016119ea3ac2220.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].stages = [];
                            
                            if ( isdefined( item ) && isdefined( item.stages ) )
                            {
                                stageindex = 0;
                                
                                foreach ( stageitem in item.stages )
                                {
                                    var_e016119ea3ac2220.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].stages[ stageindex ] = spawnstruct();
                                    var_e016119ea3ac2220.quests[ quest.ref ].phases[ phaseindex ].items[ item.ref ].stages[ stageindex ].amountneeded = stageitem.amountneeded;
                                    stageindex++;
                                }
                            }
                            
                            itemindex++;
                        }
                    }
                    
                    phaseindex++;
                }
            }
        }
    }
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 0
// Checksum 0x0, Offset: 0x1b4b
// Size: 0x72
function function_a81f0ea12cf9df1()
{
    level.var_af44283616b35663.var_87b6de1c807e9b2b = default_to( level.var_af44283616b35663.var_87b6de1c807e9b2b, [] );
    player_id = self getentitynumber();
    level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ] = level.var_af44283616b35663.var_fd03e124c44775e1;
    function_9e4a31c05a510f21();
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 0
// Checksum 0x0, Offset: 0x1bc5
// Size: 0x1cd
function function_9e4a31c05a510f21()
{
    player_id = self getentitynumber();
    
    if ( isdefined( level.var_af44283616b35663.var_3af726873b4b5c1 ) && isdefined( level.var_af44283616b35663.var_3af726873b4b5c1.quests ) )
    {
        foreach ( quest in level.var_af44283616b35663.var_3af726873b4b5c1.quests )
        {
            function_c3fbfc68d7fc5d85( quest.ref, quest.current_phase );
        }
        
        if ( isdefined( level.var_af44283616b35663.var_3af726873b4b5c1.var_924f3a860ed29a58 ) )
        {
            function_d800ca3e7ecc789e();
        }
    }
    
    if ( isdefined( level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ] ) && isdefined( level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests ) )
    {
        foreach ( quest in level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests )
        {
            function_c3fbfc68d7fc5d85( quest.ref, quest.current_phase, self );
        }
        
        if ( isdefined( level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].var_924f3a860ed29a58 ) )
        {
            function_d800ca3e7ecc789e();
        }
    }
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 3
// Checksum 0x0, Offset: 0x1d9a
// Size: 0x394
function function_c3fbfc68d7fc5d85( quest_ref, phase_index, player )
{
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    else
    {
        player_id = undefined;
    }
    
    quest_index = function_8b7626df555da362( quest_ref, player_id );
    
    if ( !isdefined( quest_ref ) || !isdefined( quest_index ) || !isdefined( phase_index ) || !isdefined( level.var_af44283616b35663 ) )
    {
        return;
    }
    
    phasedata = [];
    
    if ( isdefined( player_id ) )
    {
        foreach ( item in level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests[ quest_ref ].phases[ phase_index ].items )
        {
            phasedata[ item.index ] = spawnstruct();
            phasedata[ item.index ].visibility = item.visible;
            phasedata[ item.index ].current_stage = item.current_stage;
        }
    }
    else
    {
        foreach ( item in level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ].phases[ phase_index ].items )
        {
            phasedata[ item.index ] = spawnstruct();
            phasedata[ item.index ].visibility = item.visible;
            phasedata[ item.index ].current_stage = item.current_stage;
        }
    }
    
    var_e4724382dee6a68e = 8 - 1;
    var_47765e2a2c3adad2 = 8 - 1;
    var_b86382131c929ff4 = 2 - 1;
    packedval = int( phase_index ) & var_e4724382dee6a68e;
    totalbits = 3;
    
    for ( i = 0; i < 6 ; i++ )
    {
        phasedata[ i ] = default_to( phasedata[ i ], spawnstruct() );
        phasedata[ i ].visibility = default_to( phasedata[ i ].visibility, 0 );
        phasedata[ i ].current_stage = default_to( phasedata[ i ].current_stage, 0 );
        packedval += ( int( phasedata[ i ].visibility ) & var_b86382131c929ff4 ) << totalbits;
        totalbits += 1;
        packedval += ( int( phasedata[ i ].current_stage ) & var_47765e2a2c3adad2 ) << totalbits;
        totalbits += 3;
    }
    
    omnvarname = "ui_zm_inventory_quest_" + quest_index + 1;
    
    if ( isdefined( player_id ) )
    {
        player setclientomnvar( omnvarname, packedval );
        return;
    }
    
    foreach ( player in level.players )
    {
        player setclientomnvar( omnvarname, packedval );
    }
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 6
// Checksum 0x0, Offset: 0x2136
// Size: 0x1de, Type: bool
function function_1750f4dbf7b7b182( quest_ref, phase_index, item_ref, stage_index, amount, player )
{
    if ( !isdefined( player ) )
    {
        if ( !isdefined( quest_ref ) || !isdefined( phase_index ) || !isdefined( item_ref ) || !isdefined( stage_index ) || !isdefined( level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ].phases[ phase_index ].items[ item_ref ].stages[ stage_index ].amountneeded ) && level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ].phases[ phase_index ].items[ item_ref ].stages[ stage_index ].amountneeded > amount )
        {
            return false;
        }
    }
    else if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
        
        if ( !isdefined( quest_ref ) || !isdefined( phase_index ) || !isdefined( item_ref ) || !isdefined( stage_index ) || !isdefined( level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests[ quest_ref ].phases[ phase_index ].items[ item_ref ].stages[ stage_index ].amountneeded ) && level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests[ quest_ref ].phases[ phase_index ].items[ item_ref ].stages[ stage_index ].amountneeded > amount )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 2
// Checksum 0x0, Offset: 0x231d
// Size: 0xd3
function function_8b7626df555da362( quest_ref, player_id )
{
    if ( isdefined( level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ] ) )
    {
        return level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ].index;
    }
    
    if ( isdefined( player_id ) && isdefined( level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests[ quest_ref ] ) )
    {
        return level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests[ quest_ref ].index;
    }
    
    assertmsg( "<dev string:xa8>" + quest_ref + "<dev string:xbc>" );
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 4
// Checksum 0x0, Offset: 0x23f8
// Size: 0x109
function function_3de41abb6f8a3eca( quest_ref, phase_index, item_ref, player )
{
    if ( isdefined( level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ] ) )
    {
        return level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ].phases[ phase_index ].items[ item_ref ].index;
    }
    
    if ( isdefined( level.var_af44283616b35663.var_87b6de1c807e9b2b.quests[ quest_ref ] ) )
    {
        return level.var_af44283616b35663.var_87b6de1c807e9b2b.quests[ quest_ref ].phases[ phase_index ].items[ item_ref ].index;
    }
    
    assertmsg( "<dev string:xa8>" + quest_ref + "<dev string:xbc>" );
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 3
// Checksum 0x0, Offset: 0x2509
// Size: 0xf4
function function_d5e1ada16e44edf1( quest_ref, phase_index, player )
{
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    
    if ( isdefined( level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ] ) )
    {
        level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ].current_phase = phase_index;
        return;
    }
    
    if ( isdefined( player_id ) && isdefined( level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests[ quest_ref ] ) )
    {
        level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests[ quest_ref ].current_phase = phase_index;
        return;
    }
    
    assertmsg( "<dev string:xa8>" + quest_ref + "<dev string:xbc>" );
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 5
// Checksum 0x0, Offset: 0x2605
// Size: 0x134
function function_c7e1fddd2ee0ec13( quest_ref, phase_index, item_ref, stage_index, player )
{
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    
    if ( isdefined( level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ] ) )
    {
        level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ].phases[ phase_index ].items[ item_ref ].current_stage = stage_index;
        return;
    }
    
    if ( isdefined( player_id ) && isdefined( level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests[ quest_ref ] ) )
    {
        level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests[ quest_ref ].phases[ phase_index ].items[ item_ref ].current_stage = stage_index;
        return;
    }
    
    assertmsg( "<dev string:xa8>" + quest_ref + "<dev string:xbc>" );
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 5
// Checksum 0x0, Offset: 0x2741
// Size: 0x140
function function_c7d35ac79fe48f73( quest_ref, phase_index, item_ref, hide_item, player )
{
    if ( isdefined( player ) )
    {
        player_id = player getentitynumber();
    }
    
    hide_item = default_to( hide_item, 0 );
    
    if ( isdefined( level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ] ) )
    {
        level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ].phases[ phase_index ].items[ item_ref ].visible = !hide_item;
        return;
    }
    
    if ( isdefined( player_id ) && isdefined( level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests[ quest_ref ] ) )
    {
        level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests[ quest_ref ].phases[ phase_index ].items[ item_ref ].visible = !hide_item;
        return;
    }
    
    assertmsg( "<dev string:xa8>" + quest_ref + "<dev string:xbc>" );
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 6
// Checksum 0x0, Offset: 0x2889
// Size: 0x5f
function function_c8360ddd2f3de638( quest_ref, phase_index, item_ref, stage_index, hide_item, player )
{
    function_d5e1ada16e44edf1( quest_ref, phase_index, player );
    function_c7e1fddd2ee0ec13( quest_ref, phase_index, item_ref, stage_index, player );
    function_c7d35ac79fe48f73( quest_ref, phase_index, item_ref, hide_item, player );
    function_c3fbfc68d7fc5d85( quest_ref, phase_index, player );
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 0
// Checksum 0x0, Offset: 0x28f0
// Size: 0x1bd
function function_d800ca3e7ecc789e()
{
    foreach ( player in level.players )
    {
        var_7ae6b06a144260fd = 0;
        totalbits = 0;
        player_id = player getentitynumber();
        var_d459347b437882b2 = [];
        var_d459347b437882b2 = array_combine( level.var_af44283616b35663.var_3af726873b4b5c1.var_924f3a860ed29a58, level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].var_924f3a860ed29a58 );
        
        for ( i = 0; i < 6 ; i++ )
        {
            quest_ref = var_d459347b437882b2[ i ];
            
            if ( isdefined( quest_ref ) )
            {
                if ( isdefined( level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests[ quest_ref ] ) )
                {
                    var_7ae6b06a144260fd += ( int( level.var_af44283616b35663.var_87b6de1c807e9b2b[ player_id ].quests[ quest_ref ].visible ) & 1 ) << totalbits;
                }
                else if ( isdefined( level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ] ) )
                {
                    var_7ae6b06a144260fd += ( int( level.var_af44283616b35663.var_3af726873b4b5c1.quests[ quest_ref ].visible ) & 1 ) << totalbits;
                }
                
                totalbits += 1;
            }
        }
        
        player setclientomnvar( "ui_zm_inventory_quests_visibility", var_7ae6b06a144260fd );
    }
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 1
// Checksum 0x0, Offset: 0x2ab5
// Size: 0x31
function function_9e46c00ee4ab8e9c( var_f99283c7341869d3 )
{
    if ( isdefined( level.var_5026c70ed4889bc8 ) )
    {
        /#
            iprintln( "<dev string:xd8>" );
        #/
        
        return;
    }
    
    level.var_5026c70ed4889bc8 = var_f99283c7341869d3;
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 0
// Checksum 0x0, Offset: 0x2aee
// Size: 0x3a
function function_5d64ef7baf8eadd7()
{
    if ( isdefined( level.var_5026c70ed4889bc8 ) )
    {
        level.var_5026c70ed4889bc8 = array_remove_array( level.var_5026c70ed4889bc8, level.var_5026c70ed4889bc8 );
        level.var_5026c70ed4889bc8 = undefined;
    }
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 0
// Checksum 0x0, Offset: 0x2b30
// Size: 0x73
function function_a653d4c834e05d8b()
{
    if ( isdefined( level.var_5026c70ed4889bc8 ) && level.var_5026c70ed4889bc8.size > 0 )
    {
        foreach ( elem in level.var_5026c70ed4889bc8 )
        {
            elem scripts\mp\hud_util::hideelem();
        }
    }
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 0
// Checksum 0x0, Offset: 0x2bab
// Size: 0x73
function function_259dd78f8597c080()
{
    if ( isdefined( level.var_5026c70ed4889bc8 ) && level.var_5026c70ed4889bc8.size > 0 )
    {
        foreach ( elem in level.var_5026c70ed4889bc8 )
        {
            elem scripts\mp\hud_util::showelem();
        }
    }
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 3
// Checksum 0x0, Offset: 0x2c26
// Size: 0x75
function function_f69999652028f571( events, players, var_7b76e64b846c00d )
{
    players = default_to( players, level.players );
    assert( isarray( events ), "<dev string:x142>" );
    level.var_6f1ff165df8fdbe9 = 1;
    event = array_random( events );
    scripts\cp_mp\overlord::playevent( event, players, var_7b76e64b846c00d, 1 );
    level.var_6f1ff165df8fdbe9 = 0;
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 4
// Checksum 0x0, Offset: 0x2ca3
// Size: 0x6a
function function_453227a53255a104( conversations, players, var_7b76e64b846c00d, var_8b6798cc35c82e07 )
{
    assert( isarray( conversations ), "<dev string:x161>" );
    level.var_6f1ff165df8fdbe9 = 1;
    conversation = array_random( conversations );
    scripts\cp_mp\overlord::playconversation( conversation, players, var_7b76e64b846c00d, var_8b6798cc35c82e07 );
    level.var_6f1ff165df8fdbe9 = 0;
}

// Namespace zm_quest / scripts\zm\systems\zm_quest
// Params 1
// Checksum 0x0, Offset: 0x2d15
// Size: 0xdb
function function_d424a7b864a53e8b( var_49e0726f42025d89 )
{
    ais = getaiarray( "team_two_hundred" );
    
    foreach ( ai in ais )
    {
        if ( !istrue( ai.var_c7d2da23edd7e4cd ) )
        {
            ai scripts\zm\systems\zm_cleanup_mgr::function_fe250fd215038246();
        }
    }
    
    if ( istrue( var_49e0726f42025d89 ) )
    {
        level.players[ 0 ] thread scripts\cp_mp\powerups\nuke::grab_nuke( "nuke", level.players[ 0 ], 1, 1, 1 );
        return;
    }
    
    level.players[ 0 ] thread scripts\cp_mp\powerups\nuke::nuke_ais( level.players[ 0 ].origin, ais, "nuke", 1 );
}

/#

    // Namespace zm_quest / scripts\zm\systems\zm_quest
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x2df8
    // Size: 0x41, Type: dev
    function private function_93119194066b1e22( quest_name )
    {
        function_6e7290c8ee4f558b( "<dev string:x184>" + quest_name + "<dev string:x8c>" );
        function_b23a59dfb4ca49a1( "<dev string:x191>", "<dev string:x19f>" + quest_name, &function_f7d7be1a5c4f120f );
        function_fe953f000498048f();
    }

    // Namespace zm_quest / scripts\zm\systems\zm_quest
    // Params 2, eflags: 0x4
    // Checksum 0x0, Offset: 0x2e41
    // Size: 0x18f, Type: dev
    function private function_6e2f110fb0d51295( quest_name, step )
    {
        devgui_path = "<dev string:x184>" + quest_name + "<dev string:x8c>";
        step_tree = strtok( step.path, "<dev string:x8c>" );
        parent_step = level._quest[ quest_name ];
        
        for ( tree_depth = 0; tree_depth < step_tree.size ; tree_depth++ )
        {
            child_step = undefined;
            
            foreach ( child in parent_step.steps )
            {
                if ( child.name == step_tree[ tree_depth ] )
                {
                    child_step = child;
                    break;
                }
            }
            
            assert( isdefined( child_step ) );
            devgui_path += "<dev string:x1ae>" + child_step.index + "<dev string:x1b3>" + child_step.name + "<dev string:x8c>";
            parent_step = child_step;
        }
        
        function_6e7290c8ee4f558b( devgui_path );
        function_b23a59dfb4ca49a1( "<dev string:x1b9>", "<dev string:x1c9>" + quest_name + "<dev string:x1d5>" + step.path, &function_962580ef2ed6fd8c );
        function_b23a59dfb4ca49a1( "<dev string:x1da>", "<dev string:x1eb>" + quest_name + "<dev string:x1d5>" + step.path, &function_acdda71fab4ed5bc );
        function_fe953f000498048f();
    }

    // Namespace zm_quest / scripts\zm\systems\zm_quest
    // Params 2
    // Checksum 0x0, Offset: 0x2fd8
    // Size: 0x129, Type: dev
    function function_4d1eb7b9a161037f( quest_name, step_path )
    {
        devgui_path = "<dev string:x184>" + quest_name + "<dev string:x8c>";
        step_tree = strtok( step_path, "<dev string:x8c>" );
        parent_step = level._quest[ quest_name ];
        
        for ( tree_depth = 0; tree_depth < step_tree.size ; tree_depth++ )
        {
            child_step = undefined;
            
            foreach ( child in parent_step.steps )
            {
                if ( child.name == step_tree[ tree_depth ] )
                {
                    child_step = child;
                    break;
                }
            }
            
            assert( isdefined( child_step ) );
            devgui_path += "<dev string:x1ae>" + child_step.index + "<dev string:x1b3>" + child_step.name + "<dev string:x8c>";
            parent_step = child_step;
        }
        
        function_6e7290c8ee4f558b( devgui_path );
    }

    // Namespace zm_quest / scripts\zm\systems\zm_quest
    // Params 0
    // Checksum 0x0, Offset: 0x3109
    // Size: 0xc, Type: dev
    function function_108497a077aaee6b()
    {
        function_fe953f000498048f();
    }

    // Namespace zm_quest / scripts\zm\systems\zm_quest
    // Params 1
    // Checksum 0x0, Offset: 0x311d
    // Size: 0xb6, Type: dev
    function complete_step( step )
    {
        if ( istrue( step.completed ) )
        {
            return;
        }
        
        step.b_skipped = 1;
        step.completed = 1;
        step.quest.owner notify( step.quest.name + "<dev string:x8c>" + step.path + "<dev string:x1f8>" );
        
        for ( i = 0; i < step.steps.size ; i++ )
        {
            complete_step( step.steps[ i ] );
        }
    }

    // Namespace zm_quest / scripts\zm\systems\zm_quest
    // Params 1
    // Checksum 0x0, Offset: 0x31db
    // Size: 0x27d, Type: dev
    function function_acdda71fab4ed5bc( params )
    {
        quest_name = params[ 0 ];
        step_path = params[ 1 ];
        assertex( isdefined( level._quest ) && isdefined( level._quest[ quest_name ] ), "<dev string:x206>" + quest_name + "<dev string:x21d>" );
        quest = level._quest[ quest_name ];
        
        if ( !istrue( quest.started ) )
        {
            iprintlnbold( "<dev string:x23b>" + quest_name + "<dev string:x24a>" );
            return;
        }
        
        function_962580ef2ed6fd8c( params );
        step_tree = strtok( step_path, "<dev string:x8c>" );
        parent_step = quest;
        target_step = undefined;
        
        for ( tree_depth = 0; tree_depth < step_tree.size ; tree_depth++ )
        {
            child_step = undefined;
            
            foreach ( child in parent_step.steps )
            {
                if ( child.name == step_tree[ tree_depth ] )
                {
                    child_step = child;
                    break;
                }
            }
            
            if ( isdefined( child_step ) )
            {
                if ( tree_depth == step_tree.size - 1 )
                {
                    target_step = child_step;
                }
                else
                {
                    parent_step = child_step;
                }
                
                continue;
            }
            
            iprintlnbold( step_tree[ tree_depth ] + "<dev string:x269>" + parent_step.path + "<dev string:x289>" + quest_name + "<dev string:x29d>" );
            return;
        }
        
        assert( isdefined( target_step ) );
        
        if ( parent_step != quest )
        {
            if ( array_contains( parent_step.completed_steps, target_step.name ) )
            {
                iprintlnbold( "<dev string:x2a3>" + target_step.path + "<dev string:x2b1>" + quest_name + "<dev string:x29d>" );
            }
            else
            {
                while ( !istrue( target_step.started ) )
                {
                    wait 1;
                }
                
                complete_step( target_step );
            }
            
            return;
        }
        
        if ( target_step.index < quest.current_step )
        {
            iprintlnbold( "<dev string:x2a3>" + target_step.path + "<dev string:x2b1>" + quest_name + "<dev string:x29d>" );
            return;
        }
        
        while ( !istrue( target_step.started ) )
        {
            wait 1;
        }
        
        complete_step( target_step );
    }

    // Namespace zm_quest / scripts\zm\systems\zm_quest
    // Params 1
    // Checksum 0x0, Offset: 0x3460
    // Size: 0x12b, Type: dev
    function function_962580ef2ed6fd8c( params )
    {
        quest_name = params[ 0 ];
        step_path = params[ 1 ];
        assertex( isdefined( level._quest ) && isdefined( level._quest[ quest_name ] ), "<dev string:x206>" + quest_name + "<dev string:x21d>" );
        quest = level._quest[ quest_name ];
        
        if ( !istrue( quest.started ) )
        {
            iprintlnbold( "<dev string:x23b>" + quest_name + "<dev string:x24a>" );
            return;
        }
        
        step_tree = strtok( step_path, "<dev string:x8c>" );
        root_step = undefined;
        
        for ( step_index = 0; step_index < quest.steps.size ; step_index++ )
        {
            step = quest.steps[ step_index ];
            
            if ( step.name == step_tree[ 0 ] )
            {
                root_step = step;
                break;
            }
            
            while ( !istrue( step.started ) )
            {
                wait 1;
            }
            
            complete_step( step );
        }
    }

    // Namespace zm_quest / scripts\zm\systems\zm_quest
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x3593
    // Size: 0x18, Type: dev
    function private function_f7d7be1a5c4f120f( params )
    {
        quit_quest( params[ 0 ] );
    }

#/
