#using scripts\anim\face;
#using scripts\common\anim;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;

#namespace anim_scene;

#using_animtree( "script_model" );

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 6
// Checksum 0x0, Offset: 0x18d
// Size: 0x157
function anim_scene_create_actor( entity, animname, is_player, player_rig_visible, disable_weapons, maintain_swimming )
{
    actor = spawnstruct();
    actor.entity = entity;
    actor.animname = animname;
    actor.interruptable = 0;
    actor.interrupted = 0;
    actor.endscene = 0;
    actor.forceendscene = 0;
    
    if ( isdefined( is_player ) && is_player )
    {
        actor.is_player = is_player;
        
        if ( isdefined( player_rig_visible ) )
        {
            actor.player_rig_visible = player_rig_visible;
        }
        else
        {
            actor.player_rig_visible = 1;
        }
        
        if ( isdefined( disable_weapons ) )
        {
            actor.disable_weapons = disable_weapons;
        }
        else
        {
            actor.disable_weapons = 1;
        }
        
        if ( isdefined( maintain_swimming ) )
        {
            actor.maintain_swimming = maintain_swimming;
        }
        else
        {
            actor.maintain_swimming = 0;
        }
    }
    else
    {
        actor.is_player = 0;
        actor.entity.animname = actor.animname;
        actor.entity useanimtree( #animtree );
    }
    
    return actor;
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 3
// Checksum 0x0, Offset: 0x2ed
// Size: 0x50
function anim_scene_set_actor_interruptable( var_9c5feb9c7ef9892d, interrupt_anime, first_frame )
{
    self.interruptable = var_9c5feb9c7ef9892d;
    
    if ( isdefined( interrupt_anime ) )
    {
        self.interrupt_anime = interrupt_anime;
        
        if ( isdefined( first_frame ) )
        {
            self.interrupt_first_frame = first_frame;
            return;
        }
        
        self.interrupt_first_frame = 0;
    }
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 8
// Checksum 0x0, Offset: 0x345
// Size: 0xd3
function anim_scene( actors, anime, start_scene, end_scene, tag, blend_in_time, var_aa3247c3c61f5e1c, var_e1c732b6f63f3e8b )
{
    foreach ( actor in actors )
    {
        actor.interrupted = 0;
        actor.endscene = 0;
    }
    
    result = _anim_scene_internal( actors, anime, 0, tag, start_scene, end_scene, blend_in_time, var_aa3247c3c61f5e1c, var_e1c732b6f63f3e8b );
    
    if ( isdefined( result ) && result )
    {
        return 1;
    }
    
    return 0;
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 8
// Checksum 0x0, Offset: 0x420
// Size: 0x117
function anim_scene_loop( actors, anime, start_scene, end_scene, tag, blend_in_time, var_aa3247c3c61f5e1c, var_e1c732b6f63f3e8b )
{
    foreach ( actor in actors )
    {
        actor.interrupted = 0;
        actor.endscene = 0;
    }
    
    _anim_scene_internal( actors, anime, 1, tag, start_scene, end_scene, blend_in_time, var_aa3247c3c61f5e1c, var_e1c732b6f63f3e8b );
    var_b51b919d4c5e5691 = 1;
    
    foreach ( actor in actors )
    {
        if ( !actor.endscene )
        {
            var_b51b919d4c5e5691 = 0;
            break;
        }
    }
    
    return var_b51b919d4c5e5691;
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 1
// Checksum 0x0, Offset: 0x540
// Size: 0x28
function anim_scene_stop( var_ec951e7a56c0f445 )
{
    if ( isdefined( var_ec951e7a56c0f445 ) && var_ec951e7a56c0f445 )
    {
        self notify( "anim_scene_force_end" );
        return;
    }
    
    self notify( "stop_scene" );
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 1
// Checksum 0x0, Offset: 0x570
// Size: 0x19
function anim_scene_stop_actor( actor )
{
    actor.endscene = 1;
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 9
// Checksum 0x0, Offset: 0x591
// Size: 0x2bc, Type: bool
function _anim_scene_internal( actors, anime, looping, tag, start_scene, end_scene, blend_in_time, var_aa3247c3c61f5e1c, var_e1c732b6f63f3e8b )
{
    self endon( "anim_scene_interrupted" );
    
    if ( !isdefined( start_scene ) )
    {
        start_scene = 1;
    }
    
    if ( !isdefined( end_scene ) )
    {
        end_scene = 1;
    }
    
    /#
        assert( isarray( actors ) );
        
        foreach ( actor in actors )
        {
            assertex( isstruct( actor ), "<dev string:x1c>" );
            assertex( isdefined( actor.entity ), "<dev string:x81>" );
            assertex( !actor.is_player || isalive( actor.entity ) && !isdefined( actor.entity.fauxdead ), "<dev string:xb3>" );
        }
        
        if ( !end_scene && !looping )
        {
            function_a3ec83bacb1ebf0f( actors, anime );
        }
    #/
    
    thread _anim_scene_ender_think( actors );
    thread _anim_scene_force_end_think( actors );
    scene_duration = 0;
    thread _anim_scene_interrupt_think( actors, tag, end_scene );
    
    if ( start_scene )
    {
        if ( !isdefined( blend_in_time ) )
        {
            blend_in_time = 0.4;
        }
        
        if ( !isdefined( var_aa3247c3c61f5e1c ) )
        {
            var_aa3247c3c61f5e1c = 0.8;
        }
        
        _anim_scene_internal_blend_in( actors, anime, tag, blend_in_time, var_e1c732b6f63f3e8b );
        _anim_scene_internal_finish_blend( actors, blend_in_time, var_aa3247c3c61f5e1c );
    }
    
    _anim_scene_internal_start_anims( actors, anime, looping, tag );
    
    if ( !looping )
    {
        foreach ( actor in actors )
        {
            actor.animduration = _anim_scene_internal_get_anim_duration( actor, anime );
            
            if ( actor.animduration > scene_duration )
            {
                scene_duration = actor.animduration;
            }
        }
        
        foreach ( actor in actors )
        {
            if ( actor.animduration < scene_duration )
            {
                thread _anim_scene_actor_end_interrupt_think( actor );
            }
        }
    }
    
    if ( looping )
    {
        self waittill( "never" );
    }
    else
    {
        wait scene_duration;
    }
    
    waittillframeend();
    self notify( "anim_scene_success" );
    
    if ( end_scene )
    {
        _anim_scene_internal_end( actors );
    }
    
    return true;
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 5
// Checksum 0x0, Offset: 0x856
// Size: 0x241
function _anim_scene_internal_blend_in( actors, anime, tag, blend_in_time, var_e1c732b6f63f3e8b )
{
    foreach ( actor in actors )
    {
        if ( actor.is_player )
        {
            if ( istrue( var_e1c732b6f63f3e8b ) )
            {
                rig_model = "viewhands_base_iw8";
                actor.player_rig = spawn( "script_model", actor.entity.origin );
                actor.player_rig setmodel( rig_model );
                actor.player_rig.animname = actor.animname;
                actor.player_rig useanimtree( #animtree );
                actor.player_rig hide();
            }
            else
            {
                actor.player_rig = spawn( "script_arms", actor.entity.origin, 0, 0, actor.entity );
                actor.player_rig.animname = actor.animname;
                actor.player_rig useanimtree( #animtree );
                actor.player_rig hide();
                actor.player_rig.entity = actor.entity;
            }
            
            anim_first_frame_solo( actor.player_rig, anime, tag );
            actor.entity setstance( get_actor_stance( actor ) );
            actor.entity playerlinktoblend( actor.player_rig, "tag_player", blend_in_time, 0, 0, 1, 1, actor.maintain_swimming );
            
            if ( actor.disable_weapons )
            {
                actor.entity val::set( "anim_scene", "weapon", 0 );
            }
        }
    }
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 1
// Checksum 0x0, Offset: 0xa9f
// Size: 0x3f
function get_actor_stance( actor )
{
    if ( isdefined( actor.entity.anim_scene_stance_override ) )
    {
        return actor.entity.anim_scene_stance_override;
    }
    
    return "stand";
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 3
// Checksum 0x0, Offset: 0xae7
// Size: 0x1cf
function _anim_scene_internal_finish_blend( actors, blend_in_time, var_aa3247c3c61f5e1c )
{
    waitdiff = var_aa3247c3c61f5e1c - blend_in_time;
    
    if ( waitdiff > 0 )
    {
        wait blend_in_time;
        
        foreach ( actor in actors )
        {
            if ( actor.interrupted )
            {
                continue;
            }
            
            if ( actor.is_player )
            {
                actor.entity playerlinktodelta( actor.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, actor.maintain_swimming );
            }
        }
        
        wait waitdiff;
        
        foreach ( actor in actors )
        {
            if ( actor.interrupted )
            {
                continue;
            }
            
            if ( actor.is_player )
            {
            }
        }
        
        return;
    }
    
    wait blend_in_time;
    
    foreach ( actor in actors )
    {
        if ( actor.interrupted )
        {
            continue;
        }
        
        if ( actor.is_player )
        {
            actor.entity playerlinktodelta( actor.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, actor.maintain_swimming );
        }
    }
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 2
// Checksum 0x0, Offset: 0xcbe
// Size: 0x96
function _anim_scene_internal_get_anim_duration( actor, anime )
{
    scene_duration = 0;
    
    if ( actor.is_player )
    {
        thisduration = getanimlength( level.scr_anim[ actor.player_rig.animname ][ anime ] );
        
        if ( thisduration > scene_duration )
        {
            scene_duration = thisduration;
        }
    }
    else
    {
        thisduration = getanimlength( level.scr_anim[ actor.animname ][ anime ] );
        
        if ( thisduration > scene_duration )
        {
            scene_duration = thisduration;
        }
    }
    
    return scene_duration;
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 4
// Checksum 0x0, Offset: 0xd5d
// Size: 0x39f
function _anim_scene_internal_start_anims( actors, anime, looping, tag )
{
    foreach ( actor in actors )
    {
        if ( actor.interrupted )
        {
            continue;
        }
        
        if ( actor.is_player )
        {
            if ( looping )
            {
                assertex( isarray( level.scr_eventanim[ actor.animname ][ anime ] ) && level.scr_eventanim[ actor.animname ][ anime ].size == 1, "<dev string:xe0>" + actor.animname + "<dev string:x11f>" + anime + "<dev string:x127>" );
                actor.entity playanimscriptsceneevent( "scripted_scene", level.scr_eventanim[ actor.animname ][ anime ][ 0 ] );
            }
            else
            {
                assertex( !isarray( level.scr_eventanim[ actor.animname ][ anime ] ), "<dev string:xe0>" + actor.animname + "<dev string:x11f>" + anime + "<dev string:x190>" );
                actor.entity playanimscriptsceneevent( "scripted_scene", level.scr_eventanim[ actor.animname ][ anime ] );
            }
            
            if ( isdefined( level.scr_viewmodelanim[ actor.animname ] ) && isdefined( level.scr_viewmodelanim[ actor.animname ][ anime ] ) && !istrue( actor.entity.blockviewmodelanim ) )
            {
                if ( looping )
                {
                    assertex( isarray( level.scr_viewmodelanim[ actor.animname ][ anime ] ) && level.scr_viewmodelanim[ actor.animname ][ anime ].size == 1, "<dev string:x1c0>" + actor.animname + "<dev string:x11f>" + anime + "<dev string:x127>" );
                    actor.entity playviewmodelanim( level.scr_viewmodelanim[ actor.animname ][ anime ][ 0 ] );
                }
                else
                {
                    assertex( !isarray( level.scr_viewmodelanim[ actor.animname ][ anime ] ), "<dev string:x1c0>" + actor.animname + "<dev string:x11f>" + anime + "<dev string:x190>" );
                    actor.entity playviewmodelanim( level.scr_viewmodelanim[ actor.animname ][ anime ] );
                }
            }
            
            if ( actor.player_rig_visible && isdefined( actor.player_rig ) && !actor.entity getcamerathirdperson() )
            {
                actor.player_rig showonlytoplayer( actor.entity );
            }
            
            if ( looping )
            {
                thread anim_loop_solo( actor.player_rig, anime, "stop_scene", tag );
            }
            else
            {
                thread anim_single_solo( actor.player_rig, anime, tag );
            }
            
            continue;
        }
        
        if ( looping )
        {
            thread anim_loop_solo( actor.entity, anime, "stop_scene", tag );
            continue;
        }
        
        thread anim_single_solo( actor.entity, anime, tag );
    }
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 1
// Checksum 0x0, Offset: 0x1104
// Size: 0xb2
function _anim_scene_internal_end( actors )
{
    foreach ( actor in actors )
    {
        if ( actor.interrupted )
        {
            continue;
        }
        
        if ( actor.is_player )
        {
            actor.entity val::reset_all( "anim_scene" );
            actor.entity unlink();
            actor.player_rig delete();
            actor.player_rig = undefined;
        }
    }
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 1
// Checksum 0x0, Offset: 0x11be
// Size: 0x73
function _anim_scene_ender_think( actors )
{
    self endon( "anim_scene_success" );
    self endon( "anim_scene_interrupted" );
    self waittill( "stop_scene" );
    
    foreach ( actor in actors )
    {
        actor.endscene = 1;
    }
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 1
// Checksum 0x0, Offset: 0x1239
// Size: 0x73
function _anim_scene_force_end_think( actors )
{
    self endon( "anim_scene_success" );
    self endon( "anim_scene_interrupted" );
    self waittill( "anim_scene_force_end" );
    
    foreach ( actor in actors )
    {
        actor.forceendscene = 1;
    }
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 1
// Checksum 0x0, Offset: 0x12b4
// Size: 0x41
function _anim_scene_actor_end_interrupt_think( actor )
{
    self endon( "anim_scene_success" );
    self endon( "anim_scene_interrupted" );
    wait actor.animduration;
    
    if ( !actor.interrupted )
    {
        actor.endscene = 1;
    }
}

// Namespace anim_scene / scripts\cp_mp\anim_scene
// Params 3
// Checksum 0x0, Offset: 0x12fd
// Size: 0x3fc
function _anim_scene_interrupt_think( actors, tag, end_scene )
{
    self endon( "anim_scene_success" );
    self endon( "anim_scene_interrupted" );
    
    while ( true )
    {
        interrupted = 0;
        
        while ( true )
        {
            wait 0.05;
            
            foreach ( actor in actors )
            {
                if ( actor.endscene || actor.forceendscene || !isdefined( actor.entity ) || actor.is_player && !isalive( actor.entity ) || actor.is_player && isdefined( actor.entity.fauxdead ) )
                {
                    if ( !actor.interrupted )
                    {
                        interrupted = 1;
                        break;
                    }
                }
            }
            
            if ( interrupted )
            {
                break;
            }
        }
        
        var_c37d8d58474be788 = 1;
        
        foreach ( actor in actors )
        {
            actordead = 0;
            
            if ( !isdefined( actor.entity ) || actor.is_player && !isalive( actor.entity ) || actor.is_player && isdefined( actor.entity.fauxdead ) )
            {
                actordead = 1;
            }
            
            if ( !actordead && !actor.endscene && !actor.forceendscene && !actor.interruptable )
            {
                var_c37d8d58474be788 = 0;
                continue;
            }
            
            actor.interrupted = 1;
            
            if ( actordead && !actor.is_player )
            {
                continue;
            }
            
            if ( actor.is_player )
            {
                if ( ( end_scene || actor.forceendscene ) && !actordead )
                {
                    actor.entity val::reset_all( "anim_scene" );
                    actor.entity stopanimscriptsceneevent();
                    actor.entity unlink();
                    actor.entity setorigin( actor.entity.origin + ( 0, 0, 1 ) );
                }
                
                if ( end_scene || actor.forceendscene || actordead )
                {
                    if ( isent( actor.player_rig ) )
                    {
                        actor.player_rig delete();
                        actor.player_rig = undefined;
                    }
                }
                
                continue;
            }
            
            if ( isdefined( actor.interrupt_anime ) )
            {
                if ( actor.interrupt_first_frame )
                {
                    thread anim_first_frame_solo( actor.entity, actor.interrupt_anime, tag );
                }
                else
                {
                    actor.entity stopanimscripted();
                    thread anim_single_solo( actor.entity, actor.interrupt_anime, tag );
                }
                
                continue;
            }
            
            actor.entity stopanimscripted();
            
            if ( is_equal( actor.entity.classname, "script_model" ) || is_equal( actor.entity.code_classname, "script_model" ) )
            {
                actor.entity scriptmodelclearanim();
            }
        }
        
        if ( var_c37d8d58474be788 )
        {
            self notify( "anim_scene_interrupted" );
            return;
        }
    }
}

/#

    // Namespace anim_scene / scripts\cp_mp\anim_scene
    // Params 2
    // Checksum 0x0, Offset: 0x1701
    // Size: 0x8b, Type: dev
    function function_a3ec83bacb1ebf0f( actors, anime )
    {
        scenelength = 0;
        
        for ( i = 0; i < actors.size ; i++ )
        {
            actor = actors[ i ];
            thisduration = getanimlength( level.scr_anim[ actor.animname ][ anime ] );
            
            if ( i == 0 )
            {
                scenelength = thisduration;
                continue;
            }
            
            if ( thisduration != scenelength )
            {
                iprintlnbold( "<dev string:x203>" );
            }
        }
    }

#/
