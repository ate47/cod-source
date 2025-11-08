#using script_4dac3680f88a01c3;
#using scripts\aitypes\bt_util;
#using scripts\anim\animmode;
#using scripts\anim\death;
#using scripts\anim\face;
#using scripts\anim\first_frame;
#using scripts\anim\notetracks;
#using scripts\anim\notetracks_sp;
#using scripts\anim\pain;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\asm\shared\sp\utility;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim_notetrack;
#using scripts\sp\debug;
#using scripts\sp\fakeactor;
#using scripts\sp\interaction;
#using scripts\sp\player;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#using scripts\stealth\enemy;

#namespace anim_sp;

// Namespace anim_sp / scripts\sp\anim
// Params 0
// Checksum 0x0, Offset: 0x8fe
// Size: 0x1f7
function init()
{
    setdvarifuninitialized( @"hash_359daba9e2592b36", "0" );
    initanim();
    scripts\anim\notetracks_sp::registernotetracksifnot();
    scripts\anim\pain::initpainfx();
    scripts\anim\death::init_deathfx();
    anim.callbacks[ "PlaySoundAtViewHeight" ] = &play_sound_at_viewheight;
    anim.callbacks[ "TeleportEnt" ] = &teleport_entity;
    anim.callbacks[ "ShouldDoAnim" ] = &should_do_anim;
    anim.callbacks[ "DoAnimation" ] = &do_animation;
    anim.callbacks[ "DoFacialAnim" ] = &do_facial_anim;
    anim.callbacks[ "StopAnimscripted" ] = &anim_stopanimscripted;
    anim.callbacks[ "reach_with_standard_adjustments_begin" ] = &function_8ab3eaeab1010bd4;
    anim.callbacks[ "reach_with_standard_adjustments_end" ] = &function_ac52eeb7b35a4600;
    anim.callbacks[ "AnimHandleNotetrack" ] = &sp_anim_handle_notetrack;
    anim.callbacks[ "EntityHandleNotetrack" ] = &entity_handle_notetrack;
    anim.callbacks[ "EntityHandleNotetrackAnimEnd" ] = &scripts\anim\notetracks::function_8b5c774e7238fec5;
    anim.callbacks[ "AIAnimFirstFrame" ] = &ai_anim_first_frame;
    anim.callbacks[ "CheckPlayerAnimtree" ] = &function_6b36e63fb918cd04;
    anim.callbacks[ "PrintText" ] = &dialogue_print;
    anim.callbacks[ "playXcam" ] = &play_xcam;
    registersharedfunc( "ai", "Animscripted_SharedFunc", &scripts\asm\shared\sp\utility::animscriptedactor );
    asm_globalinit();
    scripts\aitypes\bt_util::init();
    scripts\asm\asm::setup_level_ents();
    
    /#
        if ( getdvarint( @"hash_2f8a3b3aa1e31fe5", 0 ) != 0 )
        {
            thread validatetraversenodes();
        }
        
        setdvarifuninitialized( @"scr_debug_reach", 0 );
    #/
    
    if ( !isdefined( level.notetrackmissionfailedvo ) )
    {
        level.notetrackmissionfailedvo = 1;
    }
    
    if ( !isdefined( level.notetrackvo ) )
    {
        level.notetrackvo = 1;
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0xafd
// Size: 0xf8
function function_3a81a3f984fc4a09( anime )
{
    names = function_df57c8a03e293db4( anime );
    assertex( istrue( names.size ), "No animnames exist for scene " + anime );
    assertex( names.size > 1, "Only 1 animname is registered for scene " + anime );
    prevtime = undefined;
    time = undefined;
    identical = 1;
    prevtime = getanimlength( level.scr_anim[ names[ 0 ] ][ anime ] );
    
    for ( i = 1; i < names.size ; i++ )
    {
        prefix = "";
        time = getanimlength( level.scr_anim[ names[ i ] ][ anime ] );
        
        if ( prevtime != time )
        {
            identical = 0;
            prefix = "^3WARNING: ";
        }
        
        println( prefix + time + "<dev string:x1c>" + names[ i ] + "<dev string:x26>" + anime );
        prevtime = time;
    }
    
    return identical;
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0xbfe
// Size: 0x42
function function_cf49d3451c08681c( vo_alias )
{
    assert( soundexists( vo_alias ) );
    self waittillmatch( "single anim", "vo_" + vo_alias );
    ms = lookupsoundlength( vo_alias );
    wait ms / 1000;
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0xc48
// Size: 0x56
function igc_camera( bool )
{
    registered = "igc";
    
    if ( bool )
    {
        level.player scripts\sp\player::remove_damage_effects_instantly();
        level context_melee_enable( 0 );
    }
    else
    {
        level context_melee_enable( 1 );
    }
    
    level.player scripts\common\utility::igc_camera( bool );
}

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0xca6
// Size: 0x25
function letterbox_enable( bool, time )
{
    level.player scripts\common\utility::letterbox_enable( bool, time );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0xcd3
// Size: 0x4b
function play_xcam( xcamasset, origin, angles )
{
    camnum = undefined;
    camnum = default_to( camnum, 0 );
    level.player playxcam( xcamasset, camnum, origin, angles );
    wait getxcamlength( xcamasset );
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0xd26
// Size: 0xec
function die_frozen( attacker, inflictor, meansofdeath, weaponobj )
{
    assertex( isai( self ), "called die_frozen() on a non-AI!" );
    assertex( isalive( self ), "AI is already dead!" );
    self.allowdeath = 1;
    self.deathanimmode = "nophysics";
    self.disabledeathorient = 1;
    self.noragdoll = 1;
    self.skipdeathanim = 1;
    self.diequietly = 1;
    
    if ( istrue( self.magic_bullet_shield ) )
    {
        stop_magic_bullet_shield();
    }
    
    attacker = default_to( attacker, undefined );
    inflictor = default_to( inflictor, undefined );
    meansofdeath = default_to( meansofdeath, undefined );
    weaponobj = default_to( weaponobj, undefined );
    self dodamage( self.health + 1, self.origin, attacker, inflictor, meansofdeath, undefined );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0xe1a
// Size: 0x54
function anim_generic_gravity( guy, anime, tag )
{
    pain = guy.allowpain;
    guy disable_pain();
    anim_generic_custom_animmode( guy, "gravity", anime, tag );
    
    if ( pain )
    {
        guy enable_pain();
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0xe76
// Size: 0x3b
function anim_generic_reach( guy, anime, tag )
{
    guys = [];
    guys[ 0 ] = guy;
    anim_reach( guys, anime, tag, "generic" );
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0xeb9
// Size: 0x33
function anim_generic_reach_and_arrive( guy, anime, tag, arrival_type )
{
    reach_and_arrive_internal( guy, anime, tag, arrival_type, "generic" );
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0xef4
// Size: 0x39
function anim_reach_and_arrive( guy, anime, tag, arrival_type )
{
    reach_and_arrive_internal( guy, anime, tag, arrival_type, guy.animname );
}

// Namespace anim_sp / scripts\sp\anim
// Params 5
// Checksum 0x0, Offset: 0xf35
// Size: 0x1c4
function reach_and_arrive_internal( guy, anime, tag, arrival_type, anim_location )
{
    if ( is_interact_struct( self ) || is_state_interact_struct( self ) )
    {
        if ( isdefined( self.script_reaction ) )
        {
            guy.asm.customdata.interaction = self.script_reaction;
        }
        else
        {
            guy.asm.customdata.interaction = self.script_noteworthy;
        }
        
        interaction = get_interaction( guy.asm.customdata.interaction );
        
        if ( !isdefined( interaction ) )
        {
            interaction = get_state_interaction( guy.asm.customdata.interaction );
        }
        
        guy.asm.customdata.arrivalstate = undefined;
        
        if ( isdefined( interaction ) )
        {
            guy.asm.customdata.arrivalstate = guy get_arrivalstate_from_interaction( interaction );
        }
        
        if ( isdefined( guy.asm.customdata.arrivalstate ) )
        {
            anim_reach_with_funcs( [ guy ], anime, tag, anim_location, &reach_to_interact_begin, &reach_to_interact_end, arrival_type );
        }
        else
        {
            anim_reach_with_funcs( [ guy ], anime, tag, anim_location, &reach_with_arrivals_begin, &reach_with_standard_adjustments_end, arrival_type );
        }
        
        return;
    }
    
    anim_reach_with_funcs( [ guy ], anime, tag, anim_location, &reach_with_arrivals_begin, &reach_with_standard_adjustments_end, arrival_type );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x1101
// Size: 0x30
function anim_reach_and_plant( guys, anime, tag )
{
    anim_reach_with_funcs( guys, anime, tag, undefined, &reach_with_planting, &reach_with_standard_adjustments_end );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x1139
// Size: 0x30
function anim_reach_and_plant_and_arrive( guys, anime, tag )
{
    anim_reach_with_funcs( guys, anime, tag, undefined, &reach_with_planting_and_arrivals, &reach_with_standard_adjustments_end );
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0x1171
// Size: 0xff
function anim_custom_animmode( guys, custom_animmode, anime, tag )
{
    array = get_anim_position( tag );
    org = array[ "origin" ];
    angles = array[ "angles" ];
    aguy = undefined;
    
    foreach ( guy in guys )
    {
        aguy = guy;
        assertex( isdefined( guy.animname ), "Guy wants to do animmode custom but has no animname" );
        thread anim_custom_animmode_on_guy( guy, custom_animmode, anime, org, angles, guy.animname, 0 );
    }
    
    assertex( isdefined( aguy ), "anim_custom_animmode called without a guy in the array" );
    aguy wait_until_anim_finishes( anime );
    self notify( anime );
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0x1278
// Size: 0xdb
function anim_custom_animmode_loop( guys, custom_animmode, anime, tag )
{
    array = get_anim_position( tag );
    org = array[ "origin" ];
    angles = array[ "angles" ];
    
    foreach ( guy in guys )
    {
        thread anim_custom_animmode_on_guy( guy, custom_animmode, anime, org, angles, guy.animname, 1 );
    }
    
    assertex( isdefined( guys[ 0 ] ), "anim_custom_animmode called without a guy in the array" );
    guys[ 0 ] wait_until_anim_finishes( anime );
    self notify( anime );
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x135b
// Size: 0x1c
function wait_until_anim_finishes( anime )
{
    self endon( "finished_custom_animmode" + anime );
    self waittill( "death" );
}

// Namespace anim_sp / scripts\sp\anim
// Params 6
// Checksum 0x0, Offset: 0x137f
// Size: 0x91
function anim_generic_custom_animmode( guy, custom_animmode, anime, tag, thread_func, var_212b748f7df888b0 )
{
    array = get_anim_position( tag );
    org = array[ "origin" ];
    angles = array[ "angles" ];
    thread anim_custom_animmode_on_guy( guy, custom_animmode, anime, org, angles, "generic", 0, thread_func, var_212b748f7df888b0 );
    guy wait_until_anim_finishes( anime );
    self notify( anime );
}

// Namespace anim_sp / scripts\sp\anim
// Params 6
// Checksum 0x0, Offset: 0x1418
// Size: 0x92
function anim_generic_custom_animmode_loop( guy, custom_animmode, anime, tag, thread_func, var_212b748f7df888b0 )
{
    array = get_anim_position( tag );
    org = array[ "origin" ];
    angles = array[ "angles" ];
    thread anim_custom_animmode_on_guy( guy, custom_animmode, anime, org, angles, "generic", 1, thread_func, var_212b748f7df888b0 );
    guy wait_until_anim_finishes( anime );
    self notify( anime );
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0x14b2
// Size: 0x3f
function anim_custom_animmode_solo( guy, custom_animmode, anime, tag )
{
    guys = [];
    guys[ 0 ] = guy;
    anim_custom_animmode( guys, custom_animmode, anime, tag );
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0x14f9
// Size: 0x3f
function anim_custom_animmode_loop_solo( guy, custom_animmode, anime, tag )
{
    guys = [];
    guys[ 0 ] = guy;
    anim_custom_animmode_loop( guys, custom_animmode, anime, tag );
}

// Namespace anim_sp / scripts\sp\anim
// Params 9
// Checksum 0x0, Offset: 0x1540
// Size: 0x136
function anim_custom_animmode_on_guy( guy, custom_animmode, anime, org, angles, animname_override, loop, thread_func, var_212b748f7df888b0 )
{
    if ( isai( guy ) && guy doinglongdeath() )
    {
        return;
    }
    
    animname = undefined;
    
    if ( isdefined( animname_override ) )
    {
        animname = animname_override;
    }
    else
    {
        animname = guy.animname;
    }
    
    /#
        guy assert_existance_of_anim( anime, animname );
    #/
    
    assertex( isai( guy ), "Tried to do custom_animmode on a non ai" );
    
    if ( !isdefined( var_212b748f7df888b0 ) || !var_212b748f7df888b0 )
    {
        guy set_start_pos( anime, org, angles, animname_override, loop );
    }
    
    guy._animmode = custom_animmode;
    guy._custom_anim = anime;
    guy._tag_entity = self;
    guy._anime = anime;
    guy._animname = animname;
    guy._custom_anim_loop = loop;
    guy._custom_anim_thread = thread_func;
    guy asm_animcustom( &scripts\anim\animmode::main, &asm_stopanimcustom );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x167e
// Size: 0xc6
function anim_single_gravity( guys, anime, tag )
{
    foreach ( guy in guys )
    {
        guy disable_pain();
    }
    
    anim_custom_animmode( guys, "gravity", anime, tag );
    
    foreach ( guy in guys )
    {
        if ( isdefined( guy ) && isalive( guy ) )
        {
            guy enable_pain();
        }
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0x174c
// Size: 0x33
function anim_single_run( guys, anime, tag, animname_override )
{
    anim_single_internal( guys, anime, tag, 0.25, animname_override );
}

// Namespace anim_sp / scripts\sp\anim
// Params 5
// Checksum 0x0, Offset: 0x1787
// Size: 0xcd
function anim_reach_and_idle( guys, anime, anime_idle, ender, tag )
{
    thread anim_reach( guys, anime, tag );
    ent = spawnstruct();
    ent.reachers = 0;
    
    foreach ( guy in guys )
    {
        ent.reachers++;
        thread idle_on_reach( guy, anime_idle, ender, tag, ent );
    }
    
    for ( ;; )
    {
        ent waittill( "reached_position" );
        
        if ( ent.reachers <= 0 )
        {
            return;
        }
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 0
// Checksum 0x0, Offset: 0x185c
// Size: 0x11
function wait_for_guy_to_die_or_get_in_position()
{
    self endon( "death" );
    self waittill( "anim_reach_complete" );
}

// Namespace anim_sp / scripts\sp\anim
// Params 5
// Checksum 0x0, Offset: 0x1875
// Size: 0x5b
function idle_on_reach( guy, anime_idle, ender, tag, ent )
{
    guy wait_for_guy_to_die_or_get_in_position();
    ent.reachers--;
    ent notify( "reached_position" );
    
    if ( isalive( guy ) )
    {
        anim_loop_solo( guy, anime_idle, ender, tag );
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0x18d8
// Size: 0x9c
function anim_reach_together( guys, anime, tag, animname_override )
{
    guys_with_anims = [];
    
    foreach ( guy in guys )
    {
        guys_with_anims[ guys_with_anims.size ] = [ guy ];
    }
    
    thread anim_reach_speed_control( guys_with_anims );
    anim_reach_with_funcs( guys, anime, tag, animname_override, &reach_with_standard_adjustments_begin, &reach_with_standard_adjustments_end );
}

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0x197c
// Size: 0x7c
function anim_reach_failsafe( var_420777c0f0775a09, time )
{
    if ( isarray( var_420777c0f0775a09 ) )
    {
        foreach ( guy in var_420777c0f0775a09 )
        {
            thread anim_reach_failsafe( guy, time );
        }
        
        return;
    }
    
    guy = var_420777c0f0775a09;
    guy endon( "new_anim_reach" );
    wait time;
    guy notify( "goal" );
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0x1a00
// Size: 0x100
function anim_reach( guys, anime, tag, animname_override )
{
    if ( is_interact_struct( self ) )
    {
        foreach ( guy in guys )
        {
            if ( isdefined( self.script_reaction ) )
            {
                guy.asm.customdata.interaction = self.script_reaction;
                continue;
            }
            
            guy.asm.customdata.interaction = self.script_noteworthy;
        }
        
        anim_reach_with_funcs( guys, anime, tag, animname_override, &reach_to_interact_begin, &reach_to_interact_end );
        return;
    }
    
    anim_reach_with_funcs( guys, anime, tag, animname_override, &function_8ab3eaeab1010bd4, &function_ac52eeb7b35a4600 );
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x1b08
// Size: 0x75
function anim_reach_cleanup_solo( guy )
{
    if ( !isalive( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy.oldgoalradius ) )
    {
        guy.goalradius = guy.oldgoalradius;
    }
    
    if ( isdefined( guy.scriptedarrivalent ) )
    {
        guy.scriptedarrivalent delete();
    }
    
    guy.disablearrivals = 0;
    guy.stopanimdistsq = 0;
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x1b85
// Size: 0xdc
function anim_spawner_teleport( guys, anime, tag )
{
    pos = get_anim_position( tag );
    org = pos[ "origin" ];
    angles = pos[ "angles" ];
    ent = spawnstruct();
    
    foreach ( guy in guys )
    {
        startorg = getstartorigin( org, angles, level.scr_anim[ guy.animname ][ anime ] );
        guy.origin = startorg;
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0x1c69
// Size: 0x1ba
function reach_to_interact_begin( startorg, startangles )
{
    self.oldgoalradius = self.goalradius;
    self.oldpathenemyfightdist = self.pathenemyfightdist;
    self.oldpathenemylookahead = self.pathenemylookahead;
    self.pathenemyfightdist = 128;
    self.pathenemylookahead = 128;
    disable_ai_color();
    anim_changes_pushplayer( 1 );
    self.nododgemove = 1;
    self.doavoidanceblocking = 0;
    self.fixednodewason = self.fixednode;
    self.fixednode = 0;
    self.var_a4700673c6ef6c4 = self.cornercheckenabled;
    self.cornercheckenabled = 0;
    self.old_disablearrivals = self.disablearrivals;
    self.disablearrivals = 0;
    self.reach_goal_pos = undefined;
    assert( isdefined( self.asm.customdata.interaction ) );
    interaction = get_interaction( self.asm.customdata.interaction );
    
    if ( !isdefined( interaction ) )
    {
        interaction = get_state_interaction( self.asm.customdata.interaction );
    }
    
    self.customarrivalstate = get_arrivalstate_from_interaction( interaction );
    self.customarrivalangles = startangles;
    self.var_85ecbbe4fae7c0ae = get_idlestate_from_interaction( interaction );
    self.var_171120e99df3e286 = 1;
    
    if ( isdefined( interaction.arrival_animmode ) )
    {
        self.customarrivalanimmode = interaction.arrival_animmode;
    }
    
    return startorg;
}

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0x1e2c
// Size: 0x11d
function function_8ab3eaeab1010bd4( startorg, startangles )
{
    self.oldgoalradius = self.goalradius;
    self.oldpathenemyfightdist = self.pathenemyfightdist;
    self.oldpathenemylookahead = self.pathenemylookahead;
    self.pathenemyfightdist = 0;
    self.pathenemylookahead = 128;
    disable_ai_color();
    anim_changes_pushplayer( 1 );
    self.nododgemove = 1;
    self.doavoidanceblocking = 0;
    self.fixednodewason = self.fixednode;
    self.fixednode = 0;
    self.var_a4700673c6ef6c4 = self.cornercheckenabled;
    self.cornercheckenabled = 0;
    
    if ( !isdefined( self.scriptedarrivalent ) )
    {
        self.old_disablearrivals = self.disablearrivals;
        self.disablearrivals = 1;
    }
    else
    {
        self.scriptedarrivalent.angles = startangles;
        self.scriptedarrivalent.origin = startorg;
    }
    
    self.reach_goal_pos = undefined;
    return startorg;
}

// Namespace anim_sp / scripts\sp\anim
// Params 0
// Checksum 0x0, Offset: 0x1f52
// Size: 0x14d
function reach_to_interact_end()
{
    anim_changes_pushplayer( 0 );
    self.nododgemove = 0;
    self.doavoidanceblocking = 1;
    self.fixednode = self.fixednodewason;
    self.fixednodewason = undefined;
    self.cornercheckenabled = self.var_a4700673c6ef6c4;
    self.var_a4700673c6ef6c4 = undefined;
    self.pathenemyfightdist = self.oldpathenemyfightdist;
    self.pathenemylookahead = self.oldpathenemylookahead;
    self.disablearrivals = self.old_disablearrivals;
    assert( isdefined( self.asm.customdata.interaction ) );
    interaction = get_interaction( self.asm.customdata.interaction );
    
    if ( !isdefined( interaction ) )
    {
        interaction = get_state_interaction( self.asm.customdata.interaction );
    }
    
    self.var_57e1b0c4ad45db70 = get_exitstate_from_interaction( interaction );
    self.asm.customdata.interaction = undefined;
    self.customarrivalstate = undefined;
    self.customarrivalangles = undefined;
}

// Namespace anim_sp / scripts\sp\anim
// Params 0
// Checksum 0x0, Offset: 0x20a7
// Size: 0x9a
function function_ac52eeb7b35a4600()
{
    anim_changes_pushplayer( 0 );
    self.nododgemove = 0;
    self.doavoidanceblocking = 1;
    self.fixednode = self.fixednodewason;
    self.fixednodewason = undefined;
    self.cornercheckenabled = self.var_a4700673c6ef6c4;
    self.var_a4700673c6ef6c4 = undefined;
    self.pathenemyfightdist = self.oldpathenemyfightdist;
    self.pathenemylookahead = self.oldpathenemylookahead;
    
    if ( isdefined( self.old_disablearrivals ) )
    {
        self.disablearrivals = self.old_disablearrivals;
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x2149
// Size: 0x38
function anim_changes_pushplayer( value )
{
    if ( isdefined( self.dontchangepushplayer ) )
    {
        assert( self.dontchangepushplayer == 1 );
        return;
    }
    
    self pushplayer( value );
}

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0x2189
// Size: 0x28
function reach_with_arrivals_begin( startorg, startangles )
{
    startorg = reach_with_standard_adjustments_begin( startorg, startangles );
    self.disablearrivals = 0;
    return startorg;
}

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0x21ba
// Size: 0x49
function reach_with_planting( startorg, startangles )
{
    neworigin = self getdroptofloorposition( startorg );
    assert( isdefined( neworigin ) );
    startorg = neworigin;
    startorg = reach_with_standard_adjustments_begin( startorg, startangles );
    self.disablearrivals = 1;
    return startorg;
}

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0x220c
// Size: 0x48
function reach_with_planting_and_arrivals( startorg, startangles )
{
    neworigin = self getdroptofloorposition( startorg );
    assert( isdefined( neworigin ) );
    startorg = neworigin;
    startorg = reach_with_standard_adjustments_begin( startorg, startangles );
    self.disablearrivals = 0;
    return startorg;
}

// Namespace anim_sp / scripts\sp\anim
// Params 5
// Checksum 0x0, Offset: 0x225d
// Size: 0x4c
function anim_reach_and_idle_solo( guy, anime, anime_idle, ender, tag )
{
    self endon( "death" );
    newguy[ 0 ] = guy;
    anim_reach_and_idle( newguy, anime, anime_idle, ender, tag );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x22b1
// Size: 0x3a
function anim_reach_solo( guy, anime, tag )
{
    self endon( "death" );
    newguy[ 0 ] = guy;
    anim_reach( newguy, anime, tag );
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0x22f3
// Size: 0x43
function anim_reach_and_approach_solo( guy, anime, tag, arrival_type )
{
    self endon( "death" );
    newguy[ 0 ] = guy;
    anim_reach_and_approach( newguy, anime, tag, arrival_type );
}

// Namespace anim_sp / scripts\sp\anim
// Params 5
// Checksum 0x0, Offset: 0x233e
// Size: 0x1c3
function anim_reach_and_approach_node_solo( guy, anime, tag, node_type, arrival_stance )
{
    self endon( "death" );
    newguy[ 0 ] = guy;
    array = get_anim_position( tag );
    origin = array[ "origin" ];
    angles = array[ "angles" ];
    animname = guy.animname;
    
    if ( isdefined( level.scr_anim[ animname ][ anime ] ) )
    {
        if ( isarray( level.scr_anim[ animname ][ anime ] ) )
        {
            animation = level.scr_anim[ animname ][ anime ][ 0 ];
        }
        else
        {
            animation = level.scr_anim[ animname ][ anime ];
        }
        
        origin = getstartorigin( origin, angles, animation );
        angles = getstartorigin( origin, angles, animation );
    }
    
    arrivalent = spawn( "script_origin", origin );
    arrivalent.angles = angles;
    
    if ( isdefined( node_type ) )
    {
        arrivalent.type = node_type;
    }
    else
    {
        arrivalent.type = self.type;
    }
    
    if ( isdefined( arrival_stance ) )
    {
        arrivalent.arrivalstance = arrival_stance;
    }
    else
    {
        arrivalent.arrivalstance = self gethighestnodestance();
    }
    
    guy.scriptedarrivalent = arrivalent;
    anim_reach_and_approach( newguy, anime, tag );
    guy.scriptedarrivalent = undefined;
    arrivalent delete();
    
    while ( guy.a.movement != "stop" )
    {
        wait 0.05;
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0x2509
// Size: 0x115
function anim_reach_and_approach( guys, anime, tag, arrival_type )
{
    self endon( "death" );
    
    if ( is_interact_struct( self ) )
    {
        foreach ( guy in guys )
        {
            if ( isdefined( self.script_noteworthy ) )
            {
                guy.asm.customdata.interaction = self.script_noteworthy;
                continue;
            }
            
            guy.asm.customdata.interaction = self.script_reaction;
        }
        
        anim_reach_with_funcs( guys, anime, tag, undefined, &reach_to_interact_begin, &reach_to_interact_end, arrival_type );
        return;
    }
    
    if ( !isdefined( arrival_type ) )
    {
        arrival_type = "Exposed";
    }
    
    anim_reach_with_funcs( guys, anime, tag, undefined, &reach_with_arrivals_begin, &reach_with_standard_adjustments_end, arrival_type );
}

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0x2626
// Size: 0xa3
function add_animation( animname, anime )
{
    if ( !isdefined( level.completedanims ) )
    {
        level.completedanims[ animname ][ 0 ] = anime;
        return;
    }
    
    if ( !isdefined( level.completedanims[ animname ] ) )
    {
        level.completedanims[ animname ][ 0 ] = anime;
        return;
    }
    
    for ( i = 0; i < level.completedanims[ animname ].size ; i++ )
    {
        if ( level.completedanims[ animname ][ i ] == anime )
        {
            return;
        }
    }
    
    level.completedanims[ animname ][ level.completedanims[ animname ].size ] = anime;
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0x26d1
// Size: 0x8b
function anim_single_queue( guy, anime, tag, var_9e8a16d47a03007a )
{
    if ( !isdefined( var_9e8a16d47a03007a ) )
    {
        var_9e8a16d47a03007a = 0;
    }
    
    assertex( isdefined( anime ), "Tried to do anim_single_queue without passing a scene name (anime)" );
    
    if ( isdefined( guy.last_queue_time ) )
    {
        wait_for_buffer_time_to_pass( guy.last_queue_time, 0.5 );
    }
    
    function_stack( &anim_single_solo, guy, anime, tag, var_9e8a16d47a03007a );
    
    if ( isalive( guy ) )
    {
        guy.last_queue_time = gettime();
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 5
// Checksum 0x0, Offset: 0x2764
// Size: 0xbd
function anim_generic_queue( guy, anime, tag, var_9e8a16d47a03007a, timeout )
{
    guy endon( "death" );
    
    if ( !isdefined( var_9e8a16d47a03007a ) )
    {
        var_9e8a16d47a03007a = 0;
    }
    
    assertex( isdefined( anime ), "Tried to do anim_single_queue without passing a scene name (anime)" );
    
    if ( isdefined( guy.last_queue_time ) )
    {
        wait_for_buffer_time_to_pass( guy.last_queue_time, 0.5 );
    }
    
    if ( isdefined( timeout ) )
    {
        function_stack_timeout( timeout, &anim_single_solo, guy, anime, tag, var_9e8a16d47a03007a, "generic" );
    }
    else
    {
        function_stack( &anim_single_solo, guy, anime, tag, var_9e8a16d47a03007a, "generic" );
    }
    
    if ( isalive( guy ) )
    {
        guy.last_queue_time = gettime();
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x2829
// Size: 0x54
function anim_dontpushplayer( guys )
{
    foreach ( guy in guys )
    {
        guy pushplayer( 0 );
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x2885
// Size: 0x55
function anim_pushplayer( guys )
{
    foreach ( guy in guys )
    {
        guy pushplayer( 1 );
    }
}

#using_animtree( "generic_human" );

// Namespace anim_sp / scripts\sp\anim
// Params 0
// Checksum 0x0, Offset: 0x28e2
// Size: 0x58, Type: bool
function function_ce450b9957138bd5()
{
    if ( isdefined( self.weapon ) )
    {
        dropaiweapon();
    }
    
    self setflaggedanim( "blend_to_ragdoll", %animscripted_ragdoll, 1 );
    level thread start_notetrack_wait( self, "blend_to_ragdoll", undefined, undefined, %animscripted_ragdoll );
    level thread animscriptdonotetracksthread( self, "blend_to_ragdoll" );
    return true;
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x2943
// Size: 0xcb
function anim_facialanim( guy, anime, faceanim )
{
    guy endon( "death" );
    self endon( anime );
    changetime = 0.05;
    guy notify( "newLookTarget" );
    guy notify( "newFacialAnim" );
    scripts\asm\shared\utility::disabledefaultfacialanims();
    waittillframeend();
    
    if ( !isdefined( self.scriptedtalkingknob ) )
    {
        self.scriptedtalkingknob = asm_getxanim( "knobs", asm_lookupanimfromalias( "knobs", "scripted_talking" ) );
    }
    
    animflag = "scripted_face_" + anime;
    guy setanim( self.scriptedtalkingknob, 1, 0.2 );
    guy setflaggedanimknobrestart( animflag, faceanim, 1, 0, 1 );
    thread facial_notetrack_handler( guy, animflag, anime );
    thread clearfaceanimonanimdone( guy, animflag, anime );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x2a16
// Size: 0x115
function facial_notetrack_handler( guy, animflag, anime )
{
    self endon( anime );
    guy endon( "death" );
    guy endon( "stop_loop" );
    guy endon( "scripted_face_done" );
    guy endon( "newFacialAnim" );
    
    while ( true )
    {
        self waittill( animflag, notetracks );
        
        foreach ( note in notetracks )
        {
            prefix = getsubstr( note, 0, 3 );
            
            if ( prefix == "vo_" )
            {
                alias = getsubstr( note, 3 );
                
                if ( !issentient( self ) )
                {
                    thread play_sound_on_tag( alias, "j_head", 1, alias );
                }
                else
                {
                    play_sound_at_viewheight( alias, "face_sounddone", 1 );
                }
                
                continue;
            }
            
            if ( prefix == "pvo" )
            {
                alias = getsubstr( note, 4 );
                thread smart_player_dialogue( alias );
            }
        }
    }
}

/#

    // Namespace anim_sp / scripts\sp\anim
    // Params 4
    // Checksum 0x0, Offset: 0x2b33
    // Size: 0x89, Type: dev
    function function_5ce96e37e1d6418( guy, animflag, anime, faceanim )
    {
        guy endon( "<dev string:x28>" );
        guy endon( "<dev string:x2e>" );
        self endon( anime );
        wait 0.2;
        
        for ( ;; )
        {
            animweight = guy getanimweight( faceanim );
            
            if ( animweight <= 0 )
            {
                assertmsg( "<dev string:x38>" );
                return;
            }
            
            if ( self.facialstate != "<dev string:x81>" )
            {
                assertmsg( "<dev string:x8e>" );
                return;
            }
            
            waitframe();
        }
    }

#/

// Namespace anim_sp / scripts\sp\anim
// Params 5
// Checksum 0x0, Offset: 0x2bc4
// Size: 0x260
function anim_facialfiller( msg, looktarget, force, msg_ent, intensity )
{
    intensity = default_to( intensity, "sm" );
    self endon( "death" );
    self notify( "newFacialAnim" );
    
    if ( !isdefined( msg_ent ) )
    {
        msg_ent = self;
    }
    
    if ( isai( self ) && !isalive( self ) )
    {
        return;
    }
    
    if ( !isai( self ) )
    {
        if ( !isdefined( self.fakeactor_face_anim ) )
        {
            return;
        }
        else if ( !self.fakeactor_face_anim || !isalive( self ) )
        {
            return;
        }
    }
    
    if ( istrue( self.nofacialfiller ) )
    {
        return;
    }
    
    if ( !istrue( force ) && !scripts\asm\shared\utility::isfacialstateallowed( "filler" ) )
    {
        return;
    }
    
    if ( isdefined( self.unittype ) && ( self.unittype == "c6" || self.unittype == "c8" || self.unittype == "c12" ) )
    {
        return;
    }
    
    changetime = 0.05;
    self notify( "newLookTarget" );
    self endon( "newLookTarget" );
    waittillframeend();
    
    if ( !isdefined( looktarget ) && isdefined( self.bc_looktarget ) )
    {
        looktarget = self.bc_looktarget;
    }
    
    archetype = scripts\asm\shared\utility::function_2285421dfc79c4d5();
    talkanim = self.defaulttalk;
    headknob = self.scriptedtalkingknob;
    assert( isalive( self ) );
    scripts\asm\shared\utility::setfacialstate( "filler" );
    
    if ( archetype != "" )
    {
        if ( isai( self ) )
        {
            self setfacialindex( "talk_" + intensity );
        }
        else if ( istrue( self.var_5247d15da29e8539 ) )
        {
            scripts\asm\shared\utility::function_ee3e5d584e317d35( "talk_" + intensity );
        }
        else
        {
            scripts\asm\shared\utility::setfacialindexfornonai( "talk_" + intensity );
        }
    }
    else
    {
        self setanimknoblimitedrestart( talkanim, 1, 0, 1 );
        self setanim( headknob, 5, 0.267 );
    }
    
    msg_ent waittill( msg );
    
    if ( archetype != "" && isai( self ) )
    {
        self setfacialindex( "none" );
    }
    else if ( istrue( self.var_5247d15da29e8539 ) && isdefined( self.capanimset ) )
    {
        scripts\asm\shared\utility::function_ee3e5d584e317d35( "none" );
    }
    
    scripts\asm\shared\utility::clearfacialstate( "filler" );
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x2e2c
// Size: 0x80
function talk_for_time( timer )
{
    self endon( "death" );
    talkanim = self.defaulttalk;
    self setanimknoblimitedrestart( talkanim, 1, 0, 1 );
    self setanim( self.scriptedtalkingknob, 5, 0.4 );
    scripts\asm\shared\utility::disabledefaultfacialanims();
    wait timer;
    changetime = 0.3;
    self clearanim( self.scriptedtalkingknob, 0.2 );
    scripts\asm\shared\utility::disabledefaultfacialanims( 0 );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x2eb4
// Size: 0xa9
function anim_reach_idle( guys, anime, idle )
{
    ent = spawnstruct();
    ent.count = guys.size;
    
    foreach ( guy in guys )
    {
        thread reachidle( guy, anime, idle, ent );
    }
    
    while ( ent.count )
    {
        ent waittill( "reached_goal" );
    }
    
    self notify( "stopReachIdle" );
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0x2f65
// Size: 0x5e
function reachidle( guy, anime, idle, ent )
{
    anim_reach_solo( guy, anime );
    ent.count--;
    ent notify( "reached_goal" );
    
    if ( ent.count > 0 )
    {
        anim_loop_solo( guy, idle, "stopReachIdle" );
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x2fcb
// Size: 0x69
function clearfaceanimonanimdone( guy, animflag, anime )
{
    guy endon( "death" );
    guy endon( "newFacialAnim" );
    guy waittillmatch( animflag, "end" );
    guy notify( "scripted_face_done" );
    changetime = 0.3;
    guy clearanim( self.scriptedtalkingknob, 0.2 );
    scripts\asm\shared\utility::disabledefaultfacialanims( 0 );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x303c
// Size: 0x26
function anim_set_rate_single( guy, anime, rate )
{
    guy thread anim_set_rate_internal( anime, rate );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x306a
// Size: 0x2a
function anim_set_rate( guys, anime, rate )
{
    array_thread( guys, &anim_set_rate_internal, anime, rate );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x309c
// Size: 0x55
function anim_set_rate_internal( anime, rate, animname_override )
{
    animname = undefined;
    
    if ( isdefined( animname_override ) )
    {
        animname = animname_override;
    }
    else
    {
        animname = self.animname;
    }
    
    self setflaggedanim( "single anim", getanim_from_animname( anime, animname ), 1, 0, rate );
}

// Namespace anim_sp / scripts\sp\anim
// Params 5
// Checksum 0x0, Offset: 0x30f9
// Size: 0xbb
function create_anim_scene( animtree, anim_sequence, anim_asset, animname, model )
{
    if ( !isdefined( animname ) )
    {
        animname = "generic";
    }
    else
    {
        level.scr_animtree[ animname ] = animtree;
    }
    
    scene = spawnstruct();
    scene.animtree = animtree;
    scene.model = model;
    
    if ( isdefined( model ) )
    {
        level.scr_model[ animname ] = model;
    }
    
    if ( isdefined( anim_asset ) )
    {
        level.scr_anim[ animname ][ anim_sequence ] = anim_asset;
    }
    
    scene.animname = animname;
    scene.anim_sequence = anim_sequence;
    level.current_anim_data_scene = scene;
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0x31bc
// Size: 0x69
function blended_loop_solo( guy, lookat, anim_array, ender )
{
    guy.anim_array = anim_array;
    guy.ender = ender;
    guy.gesture_lookat = lookat;
    guy.animnode = self;
    guy asm_animcustom( &namespace_3123a12d1da4993::blended_loop_anim, &namespace_3123a12d1da4993::blended_loop_cleanup );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x322d
// Size: 0x67
function blended_anim_solo( guy, lookat, anim_array )
{
    while ( isdefined( guy.anim_array ) )
    {
        wait 0.05;
    }
    
    guy.anim_array = anim_array;
    guy.gesture_lookat = lookat;
    guy.animnode = self;
    guy asm_animcustom( &namespace_3123a12d1da4993::blended_anim );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x329c
// Size: 0x67
function anim_block_in_single( guys, anime, lerp_speed )
{
    foreach ( guy in guys )
    {
        thread anim_block_in_internal( guy, anime, lerp_speed );
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x330b
// Size: 0x26
function anim_block_in_solo( guy, anime, lerp_speed )
{
    thread anim_block_in_internal( guy, anime, lerp_speed );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x3339
// Size: 0x3ee
function anim_block_in_internal( newguy, anime, lerp_speed )
{
    newguy endon( "death" );
    newguy endon( "stop_blockin" );
    animname = newguy.animname;
    newguy assert_existance_of_anim( anime, animname );
    
    if ( isdefined( level.scr_blockin[ animname ] ) && isdefined( level.scr_blockin[ animname ][ anime ] ) )
    {
        start = getstruct( level.scr_blockin[ animname ][ anime ], "targetname" );
    }
    else
    {
        return;
    }
    
    if ( !isdefined( lerp_speed ) )
    {
        lerp_speed = 50;
    }
    
    mover_org = spawn( "script_model", newguy.origin );
    mover_org.angles = newguy.angles;
    mover_org setmodel( "tag_origin" );
    og_ignoreall = newguy.ignoreall;
    og_ignoreme = newguy.ignoreme;
    newguy thread anim_block_in_cleanup_internal( mover_org, og_ignoreall, og_ignoreme );
    dist = distance( newguy.origin, start.origin );
    var_d8c375423b38300c = dist / lerp_speed;
    
    if ( isplayer( newguy ) )
    {
        newguy playerlinktoabsolute( mover_org );
    }
    else if ( isai( newguy ) )
    {
        newguy animcustom( &t_poser );
        newguy linkto( mover_org, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        newguy.ignoreall = 1;
    }
    else
    {
        newguy linkto( mover_org, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        newguy.ignoreall = 1;
    }
    
    newguy.ignoreme = 1;
    var_d8c375423b38300c = ter_op( var_d8c375423b38300c == 0, 0.05, var_d8c375423b38300c );
    instant_lerp = 0.05;
    mover_org moveto( start.origin, instant_lerp );
    mover_org rotateto( start.angles, instant_lerp );
    
    if ( isai( newguy ) )
    {
        if ( !isdefined( start.angles ) )
        {
            newguy orientmode( "face point", start.origin );
        }
        else
        {
            newguy orientmode( "face angle", start.angles[ 1 ] );
        }
    }
    
    mover_org waittill( "movedone" );
    start script_wait();
    
    while ( isdefined( start.target ) )
    {
        next = getstruct( start.target, "targetname" );
        
        if ( isdefined( start.script_speed ) )
        {
            lerp_speed = start.script_speed;
        }
        
        start script_delay();
        start = next;
        dist = distance( newguy.origin, start.origin );
        var_d8c375423b38300c = dist / lerp_speed;
        mover_org moveto( start.origin, var_d8c375423b38300c );
        
        if ( isdefined( start.angles ) )
        {
            mover_org rotateto( start.angles, var_d8c375423b38300c );
            
            if ( isai( newguy ) )
            {
                newguy orientmode( "face angle", start.angles[ 1 ] );
            }
        }
        else
        {
            mover_org rotateto( vectortoangles( next.origin - mover_org.origin ), var_d8c375423b38300c );
            
            if ( isai( newguy ) )
            {
                newguy orientmode( "face point", next.origin );
            }
        }
        
        mover_org waittill( "movedone" );
        start script_wait();
    }
    
    newguy notify( "tposer done" );
}

// Namespace anim_sp / scripts\sp\anim
// Params 0
// Checksum 0x0, Offset: 0x372f
// Size: 0x1f
function t_poser()
{
    self animmode( "noclip" );
    waittill_any( "tposer done", "stop_blockin" );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x3756
// Size: 0x5c
function anim_block_in_cleanup_internal( mover_org, og_ignoreall, og_ignoreme )
{
    waittill_any( "tposer done", "stop_blockin", "death" );
    self unlink();
    
    if ( isai( self ) )
    {
        self.ignoreall = og_ignoreall;
    }
    
    self.ignoreme = og_ignoreme;
    mover_org delete();
}

// Namespace anim_sp / scripts\sp\anim
// Params 0
// Checksum 0x0, Offset: 0x37ba
// Size: 0x13, Type: bool
function should_do_anim()
{
    return !isai( self ) || !doinglongdeath();
}

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0x37d6
// Size: 0x7c
function teleport_entity( origin, angles )
{
    if ( isai( self ) )
    {
        if ( isdefined( self.anim_start_at_groundpos ) )
        {
            origin = drop_to_ground( origin );
        }
        
        self forceteleport( origin, angles, 9999 );
        return;
    }
    
    if ( isdefined( self.vehicletype ) )
    {
        self vehicle_teleport( origin, angles );
        self dontinterpolate();
        return;
    }
    
    self.origin = origin;
    self.angles = angles;
    self dontinterpolate();
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x385a
// Size: 0xaa
function play_sound_at_viewheight( aliasname, notification_string, var_a68adbd3eefe9282 )
{
    if ( !soundexists( aliasname ) )
    {
        /#
            iprintln( "<dev string:xdb>" + aliasname );
        #/
        
        if ( isstring( notification_string ) )
        {
            waitframe();
            self notify( notification_string );
            self notify( "single dialogue" );
        }
        
        return;
    }
    
    if ( isdefined( notification_string ) && isdefined( var_a68adbd3eefe9282 ) )
    {
        self playsoundatviewheight( aliasname, notification_string, var_a68adbd3eefe9282 );
    }
    else if ( isdefined( notification_string ) )
    {
        self playsoundatviewheight( aliasname, notification_string );
    }
    else
    {
        self playsoundatviewheight( aliasname );
    }
    
    if ( isdefined( notification_string ) )
    {
        self.scripteddialoguenotify = gettime();
    }
    else
    {
        self.scripteddialoguenonotify = gettime();
    }
    
    thread bcs_scripted_dialog_clear( aliasname, notification_string );
}

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0x390c
// Size: 0x53
function bcs_scripted_dialog_clear( aliasname, notification_string )
{
    self endon( "death" );
    
    if ( isdefined( notification_string ) )
    {
        self waittill( notification_string );
        self.scripteddialoguenotify = undefined;
        return;
    }
    
    length = lookupsoundlength( aliasname ) * 0.001;
    wait length;
    self.scripteddialoguenonotify = undefined;
}

// Namespace anim_sp / scripts\sp\anim
// Params 7
// Checksum 0x0, Offset: 0x3967
// Size: 0xfc, Type: bool
function do_facial_anim( dofacialanim, dodialogue, doanimation, anime, animname, dialogue, looping )
{
    /#
        if ( dofacialanim && looping )
        {
            println( "<dev string:xf8>" );
        }
    #/
    
    if ( dofacialanim && !looping )
    {
        if ( dodialogue )
        {
            thread sayspecificdialogue( dialogue );
        }
        
        assertex( !doanimation, "Can't play a facial anim and fullbody anim at the same time. The facial anim should be in the full body anim. Occurred on animation " + anime );
        thread anim_facialanim( self, anime, level.scr_face[ animname ][ anime ] );
        return true;
    }
    else if ( isai( self ) || isdefined( self.fakeactor_face_anim ) && self.fakeactor_face_anim )
    {
        if ( doanimation )
        {
            sayspecificdialogue( dialogue );
        }
        else
        {
            if ( !looping )
            {
                thread anim_facialfiller( "single dialogue" );
            }
            
            sayspecificdialogue( dialogue, "single dialogue" );
        }
    }
    else
    {
        thread play_sound_on_entity( dialogue, "single dialogue" );
    }
    
    return false;
}

#using_animtree( "animscripted_default_headlook" );

// Namespace anim_sp / scripts\sp\anim
// Params 7
// Checksum 0x0, Offset: 0x3a6c
// Size: 0x307
function do_animation( org, angles, animname, anime, anim_string, idleanim, scripted_node_ent )
{
    if ( isdefined( level.scr_xcam[ anime ] ) )
    {
        if ( isplayer( self ) )
        {
            assertmsg( "Do not include players as actors in scenes using Xcams in Single Player." );
        }
    }
    
    animation = undefined;
    
    if ( function_f1e7ee8ddeece062( anime ) )
    {
        animation = function_c099f6fd9c19f5a6( anime, org, angles, animname );
    }
    else if ( isdefined( idleanim ) )
    {
        animation = level.scr_anim[ animname ][ anime ][ idleanim ];
    }
    else
    {
        animation = level.scr_anim[ animname ][ anime ];
    }
    
    goaltime = anim_get_goal_time( animname, anime );
    last_anim_time_check();
    
    if ( !isdefined( idleanim ) )
    {
        self._lastanime = anime;
    }
    
    if ( self.code_classname == "misc_turret" && !isdefined( idleanim ) )
    {
        self setflaggedanim( anim_string, animation, 1, goaltime );
    }
    else
    {
        root = undefined;
        
        if ( isai( self ) || scripts\sp\fakeactor::is_fakeactor() )
        {
            root = asm_getbodyknob();
        }
        else if ( isdefined( self.anim_getrootfunc ) )
        {
            root = [[ self.anim_getrootfunc ]]();
        }
        
        if ( isdefined( self.asm ) && !isai( self ) )
        {
            asm_animscripted();
        }
        
        var_3ca191c06a619895 = [ -90, 90, -60, 60 ];
        var_208a5303001324ed = %lookatpos_animscripted_default;
        
        if ( isdefined( level.scr_lookat ) && isdefined( level.scr_lookat[ animname ] ) && isdefined( level.scr_lookat[ animname ][ anime ] ) )
        {
            /#
                if ( !isdefined( level.scr_lookat[ animname ][ anime ].ranges ) )
                {
                    assertmsg( "<dev string:x135>" + animname + "<dev string:x16f>" + anime );
                }
                
                if ( level.scr_lookat[ animname ][ anime ].ranges.size != 4 )
                {
                    assertmsg( "<dev string:x173>" + animname + "<dev string:x16f>" + anime );
                }
                
                if ( !isdefined( level.scr_lookat[ animname ][ anime ].atr_node ) )
                {
                    assertmsg( "<dev string:x1c6>" + animname + "<dev string:x16f>" + anime );
                }
            #/
            
            var_3ca191c06a619895 = level.scr_lookat[ animname ][ anime ].ranges;
            var_208a5303001324ed = level.scr_lookat[ animname ][ anime ].atr_node;
        }
        
        self animscripted( anim_string, org, angles, animation, undefined, root, goaltime, 1, var_3ca191c06a619895[ 0 ], var_3ca191c06a619895[ 1 ], var_3ca191c06a619895[ 2 ], var_3ca191c06a619895[ 3 ], var_208a5303001324ed, scripted_node_ent );
    }
    
    thread start_notetrack_wait( self, anim_string, anime, animname, animation );
    thread animscriptdonotetracksthread( self, anim_string, anime );
    return getanimlength( animation );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x3d7c
// Size: 0x51
function animscriptdonotetracksthread( guy, animstring, anime )
{
    if ( isdefined( guy.dontdonotetracks ) && guy.dontdonotetracks )
    {
        return;
    }
    
    guy endon( "stop_sequencing_notetracks" );
    guy endon( "death" );
    guy scripts\anim\notetracks::donotetracks( animstring );
}

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0x3dd5
// Size: 0x33
function ai_anim_first_frame( animation, animname )
{
    self._first_frame_anim = animation;
    self._animname = animname;
    asm_animcustom( &scripts\anim\first_frame::main );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x3e10
// Size: 0x64
function anim_react_new( guys, node, anime )
{
    data = spawnstruct();
    
    if ( !isarray( guys ) )
    {
        guys = [ guys ];
    }
    
    data.guys = guys;
    data.node = node;
    data.anime = anime;
    return data;
}

// Namespace anim_sp / scripts\sp\anim
// Params 4
// Checksum 0x0, Offset: 0x3e7d
// Size: 0x59
function anim_react( guys, anime, reactfunc, gotocombatonly )
{
    data = anim_react_new( guys, self, anime );
    data.fnreact = reactfunc;
    data.gotocombatonly = gotocombatonly;
    anim_react_data( data );
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x3ede
// Size: 0x309
function anim_react_data( data )
{
    array_thread( data.guys, &anim_react_thread, data );
    anime = data.anime;
    
    foreach ( guy in data.guys )
    {
        death_anime = anime + "_death";
        
        if ( isdefined( level.scr_anim[ guy.animname ][ death_anime ] ) )
        {
            guy set_deathanim( death_anime );
        }
        
        if ( isdefined( guy.animents ) )
        {
            foreach ( animent in guy.animents )
            {
                if ( isdefined( level.scr_anim[ animent.animname ][ death_anime ] ) )
                {
                    animent.deathanime = death_anime;
                }
            }
        }
        
        level thread anim_react_death( data.node, guy, data.fnreact );
    }
    
    intro_anime = anime + "_intro";
    
    if ( isdefined( level.scr_anim[ data.guys[ 0 ].animname ][ intro_anime ] ) )
    {
        data.node anim_single_with_props( data.guys, intro_anime );
    }
    
    loop_anime = anime + "_loop";
    outro_anime = anime + "_outro";
    
    foreach ( guy in data.guys )
    {
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        if ( guy ent_flag( "anim_reacted" ) )
        {
            continue;
        }
        
        if ( isdefined( level.scr_anim[ guy.animname ][ loop_anime ] ) )
        {
            data.node thread anim_loop_with_props( guy, loop_anime, "stop_anim_loop_" + guy.animname );
            continue;
        }
        
        if ( isdefined( level.scr_anim[ guy.animname ][ outro_anime ] ) )
        {
            data.node thread anim_single_with_props( guy, outro_anime );
            guy thread waittillmatch_notify( "single anim", "end", "outro_anim_end" );
            guy thread_on_notify( "outro_anim_end", &send_notify, "stop_anim_react", undefined, undefined, guy, "anim_react" );
            continue;
        }
        
        guy notify( "stop_anim_react" );
        guy notify( "stop_anim_react_death" );
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x41ef
// Size: 0x322
function anim_react_thread( data )
{
    self endon( "death" );
    self notify( "stop_anim_react" );
    self endon( "stop_anim_react" );
    type = anim_react_wait_thread();
    anim_react_alertgroup_msg( "reacted", type );
    self notify( "anim_react" );
    data.node notify( "anim_react" );
    
    if ( !istrue( self.anim_react_skip_stopanimscripted ) )
    {
        data.node notify( "stop_anim_loop_" + self.animname );
        anim_stopanimscripted();
    }
    
    skipreaction = 0;
    
    if ( isdefined( data.fnreact ) )
    {
        result = self [[ data.fnreact ]]( type );
        
        if ( isdefined( result ) )
        {
            if ( result == "skip_reaction" )
            {
                skipreaction = 1;
            }
            else
            {
                type = result;
            }
        }
    }
    
    if ( !skipreaction )
    {
        react_type = get_react_type( type );
        anime = data.anime;
        reactanime = undefined;
        
        if ( isdefined( data.fnreactanime ) )
        {
            reactanime = [[ data.fnreactanime ]]( type );
        }
        
        /#
            function_e661feea7049d008( "<dev string:x200>" + react_type );
        #/
        
        if ( type == "pain" )
        {
            reactanime = anime + "_react_pain";
            
            if ( isdefined( level.scr_anim[ self.animname ][ reactanime ] ) )
            {
                self.allowdeath = 1;
                
                if ( !isdefined( self.animreactrelative ) )
                {
                    data.node anim_single_with_props( self, reactanime );
                }
                else
                {
                    anim_single_with_props( self, reactanime );
                }
            }
            else if ( isdefined( self.script_stealthgroup ) )
            {
                scripts\stealth\enemy::bt_set_stealth_state( "combat" );
            }
        }
        else
        {
            level thread detach_linkedaniments( self );
            
            if ( !isdefined( reactanime ) )
            {
                reactanime = anime + "_react_" + react_type;
            }
            
            if ( !isdefined( level.scr_anim[ self.animname ][ reactanime ] ) )
            {
                reactanime = anime + "_react";
            }
            
            if ( isdefined( level.scr_anim[ self.animname ][ reactanime ] ) )
            {
                self.allowdeath = 1;
                
                if ( !isdefined( self.animreactrelative ) )
                {
                    data.node anim_single_with_props( self, reactanime );
                }
                else
                {
                    anim_single_with_props( self, reactanime );
                }
            }
            
            var_4ea0add0a87e4316 = reactanime + "_loop";
            
            if ( isdefined( level.scr_anim[ self.animname ][ var_4ea0add0a87e4316 ] ) )
            {
                if ( !isdefined( self.animreactrelative ) )
                {
                    data.node anim_loop_with_props( self, var_4ea0add0a87e4316 );
                }
                else
                {
                    anim_loop_with_props( self, var_4ea0add0a87e4316 );
                }
            }
            
            if ( isdefined( self.script_stealthgroup ) && istrue( data.gotocombatonly ) )
            {
                scripts\stealth\enemy::bt_set_stealth_state( "combat" );
            }
        }
    }
    else
    {
        /#
            function_e661feea7049d008( "<dev string:x21c>" );
        #/
    }
    
    self notify( "anim_react_done" );
    
    if ( isdefined( self.target ) )
    {
        scripts\sp\spawner::go_to_node();
    }
    
    if ( !isdefined( self.script_forcegoal ) )
    {
        self.goalradius = level.default_goalradius;
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x4519
// Size: 0x38
function get_react_type( type )
{
    switch ( type )
    {
        case #"hash_b330931dd2da97d1":
            return "low";
        default:
            return "high";
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 0
// Checksum 0x0, Offset: 0x4559
// Size: 0x10c
function anim_react_wait_thread()
{
    self endon( "death" );
    self endon( "stop_anim_react" );
    
    if ( !ent_flag_exist( "anim_reacted" ) )
    {
        ent_flag_init( "anim_reacted" );
    }
    
    ent_flag_clear( "anim_reacted" );
    childthread anim_react_damage();
    childthread anim_react_waittill( "react" );
    childthread anim_react_waittill( "doFlashBanged" );
    childthread anim_react_waittill( "too_close" );
    childthread anim_react_waittill( "friend_died" );
    childthread anim_react_waittill( "friend_reacted" );
    childthread anim_react_waittill( "friend_pained" );
    childthread anim_react_ai_events();
    childthread anim_react_radius();
    self waittill( "anim_react_notify", type, event );
    
    if ( isdefined( event ) )
    {
        self.anim_react_event = event;
    }
    
    ent_flag_set( "anim_reacted" );
    
    /#
        function_e661feea7049d008( "<dev string:x242>" + type );
    #/
    
    if ( type == "friend_died" || type == "friend_pained" )
    {
        wait randomfloatrange( 0.2, 0.4 );
    }
    
    return type;
}

// Namespace anim_sp / scripts\sp\anim
// Params 0
// Checksum 0x0, Offset: 0x466e
// Size: 0xaa
function anim_react_damage()
{
    self waittill( "damage", dmg, attacker, dir, point, meansofdamage, model, tag, part, idflag, objweapon );
    
    if ( meansofdamage != "MOD_GRENADE_SPLASH" && isdefined( objweapon ) && objweapon.basename != "flash" )
    {
        self notify( "anim_react_notify", "pain" );
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x4720
// Size: 0x24
function anim_react_waittill( msg )
{
    self waittill( msg, extra );
    self notify( "anim_react_notify", msg, extra );
}

// Namespace anim_sp / scripts\sp\anim
// Params 0
// Checksum 0x0, Offset: 0x474c
// Size: 0xd8
function anim_react_radius()
{
    self endon( "anim_reacted" );
    
    if ( !isdefined( self.radius ) )
    {
        self.radius = 72;
    }
    
    trigger = undefined;
    
    if ( isdefined( self.target ) )
    {
        ent = getent( self.target, "targetname" );
        
        if ( isdefined( ent ) )
        {
            if ( ent.code_classname == "trigger_multiple" )
            {
                trigger = ent;
            }
        }
    }
    
    while ( true )
    {
        waitframe();
        
        if ( distancesquared( level.player.origin, self.origin ) < squared( self.radius ) )
        {
            break;
        }
        
        if ( !isdefined( trigger ) )
        {
            continue;
        }
        
        if ( level.player istouching( trigger ) )
        {
            break;
        }
    }
    
    self notify( "too_close" );
}

// Namespace anim_sp / scripts\sp\anim
// Params 0
// Checksum 0x0, Offset: 0x482c
// Size: 0x18
function force_high_reaction()
{
    self aieventlistenerevent( "cover_blown", self, self.origin );
}

// Namespace anim_sp / scripts\sp\anim
// Params 0
// Checksum 0x0, Offset: 0x484c
// Size: 0x18
function force_low_reaction()
{
    self aieventlistenerevent( "investigate", self, self.origin );
}

// Namespace anim_sp / scripts\sp\anim
// Params 0
// Checksum 0x0, Offset: 0x486c
// Size: 0xa5
function anim_react_ai_events()
{
    self endon( "death" );
    self endon( "anim_reacted" );
    
    while ( true )
    {
        level waittill( "stealth_event", event, receiver );
        
        if ( receiver != self )
        {
            continue;
        }
        
        /#
            thread function_e573a558c94fd327( [ event ] );
        #/
        
        switch ( event.type )
        {
            case #"hash_f796130a9b9cec5":
            case #"hash_9e02cd4a0f3ca981":
                self notify( "anim_react_notify", "ai_event_high", event );
                return;
            case #"hash_e21b072df2b47f94":
                self notify( "anim_react_notify", "ai_event_low", event );
                return;
        }
    }
}

/#

    // Namespace anim_sp / scripts\sp\anim
    // Params 1
    // Checksum 0x0, Offset: 0x4919
    // Size: 0xd9, Type: dev
    function function_e573a558c94fd327( eventarray )
    {
        prefix = "<dev string:x257>";
        types = "<dev string:x262>";
        
        for ( i = 0; i < eventarray.size ; i++ )
        {
            if ( i < eventarray.size - 1 )
            {
                types += "<dev string:x26>" + eventarray[ i ].type + "<dev string:x263>";
            }
            else
            {
                types += "<dev string:x26>" + eventarray[ i ].type;
            }
            
            function_e661feea7049d008( "<dev string:x265>" + eventarray[ i ].type );
        }
        
        if ( getdvarint( @"hash_f2e0c1a7174051b7" ) > 0 )
        {
            msg = prefix + types;
            thread scripts\sp\debug::function_e31e954e5ae9ad1d( msg, ( 0, 0, 60 ) );
        }
    }

    // Namespace anim_sp / scripts\sp\anim
    // Params 1
    // Checksum 0x0, Offset: 0x49fa
    // Size: 0x35, Type: dev
    function function_e661feea7049d008( msg )
    {
        if ( getdvarint( @"hash_359daba9e2592b36" ) > 0 )
        {
            println( self getentitynumber() + "<dev string:x271>" + msg );
        }
    }

#/

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0x4a37
// Size: 0x12a
function anim_react_alertgroup_msg( suffix, type )
{
    if ( !isdefined( self.alertgroupnames ) )
    {
        return;
    }
    
    event = undefined;
    
    if ( isdefined( self.anim_react_event ) )
    {
        event = self.anim_react_event;
    }
    
    if ( type == "pain" )
    {
        suffix = "pained";
    }
    else if ( type == "death" )
    {
        suffix = "died";
    }
    
    foreach ( groupname in self.alertgroupnames )
    {
        level.alertgroup[ groupname ] = array_removeundefined( level.alertgroup[ groupname ] );
        
        foreach ( ai in level.alertgroup[ groupname ] )
        {
            ai notify( "friend_" + suffix, event );
        }
    }
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x4b69
// Size: 0x85
function anim_react_add_to_alertgroup( groupname )
{
    if ( !isdefined( level.alertgroup ) )
    {
        level.alertgroup = [];
    }
    
    if ( !isdefined( level.alertgroup[ groupname ] ) )
    {
        level.alertgroup[ groupname ] = [];
    }
    
    level.alertgroup[ groupname ][ level.alertgroup[ groupname ].size ] = self;
    
    if ( !isdefined( self.alertgroupnames ) )
    {
        self.alertgroupnames = [];
    }
    
    self.alertgroupnames[ self.alertgroupnames.size ] = groupname;
}

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0x4bf6
// Size: 0x103
function add_animents( array, anime )
{
    newarray = array;
    
    foreach ( ent in array )
    {
        if ( !isdefined( ent.animents ) )
        {
            continue;
        }
        
        foreach ( animent in ent.animents )
        {
            if ( !isdefined( level.scr_anim[ animent.animname ] ) )
            {
                continue;
            }
            
            if ( !isdefined( level.scr_anim[ animent.animname ][ anime ] ) )
            {
                continue;
            }
            
            newarray[ newarray.size ] = animent;
        }
    }
    
    return newarray;
}

// Namespace anim_sp / scripts\sp\anim
// Params 5
// Checksum 0x0, Offset: 0x4d02
// Size: 0x52
function anim_single_with_props( ents, anime, tag, var_9e8a16d47a03007a, animname_override )
{
    if ( !isarray( ents ) )
    {
        ents = [ ents ];
    }
    
    ents = add_animents( ents, anime );
    anim_single( ents, anime, tag, var_9e8a16d47a03007a, animname_override );
}

// Namespace anim_sp / scripts\sp\anim
// Params 6
// Checksum 0x0, Offset: 0x4d5c
// Size: 0x5b
function anim_loop_with_props( ents, anime, ender, tag, var_656e3d548572faf6, animname_override )
{
    if ( !isarray( ents ) )
    {
        ents = [ ents ];
    }
    
    ents = add_animents( ents, anime );
    anim_loop( ents, anime, ender, tag, var_656e3d548572faf6, animname_override );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x4dbf
// Size: 0xc6
function anim_react_death( node, guy, reactfunc )
{
    guy endon( "entitydeleted" );
    guy endon( "anim_react_done" );
    guy endon( "stop_anim_react_death" );
    guy waittill( "death" );
    
    /#
        guy function_e661feea7049d008( "<dev string:x274>" );
    #/
    
    if ( isdefined( reactfunc ) )
    {
        guy thread [[ reactfunc ]]( "death" );
    }
    
    if ( isdefined( guy.animents ) )
    {
        foreach ( ent in guy.animents )
        {
            ent thread prop_deathanim( node );
        }
    }
    
    level thread detach_linkedaniments( guy );
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x4e8d
// Size: 0x54
function prop_deathanim( node )
{
    self endon( "death" );
    
    if ( !isdefined( self.deathanime ) )
    {
        return;
    }
    
    if ( !isdefined( level.scr_anim[ self.animname ][ self.deathanime ] ) )
    {
        return;
    }
    
    node anim_single_solo( self, self.deathanime );
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x4ee9
// Size: 0x7b
function detach_linkedaniments( guy )
{
    if ( !isdefined( guy.linkedaniments ) )
    {
        return;
    }
    
    foreach ( ent in guy.linkedaniments )
    {
        ent thread detach_linkedaniment( guy );
    }
    
    guy.linkedaniments = undefined;
}

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x4f6c
// Size: 0x1ce
function detach_linkedaniment( guy )
{
    prevpos = guy gettagorigin( self.parenttag );
    waitframe();
    
    if ( !isdefined( guy ) )
    {
        newpos = prevpos + ( 0, 0, 10 );
    }
    else
    {
        newpos = guy gettagorigin( self.parenttag );
    }
    
    forward = vectornormalize( newpos - prevpos );
    velocity = forward * randomfloatrange( 1, 2 );
    self unlink();
    
    if ( isdefined( self.nophysics ) )
    {
        pos = drop_to_ground( self.origin, 16, -500 );
        dist = distance( pos, self.origin );
        time = dist / 120;
        time = max( time, 0.05 );
        self moveto( pos, time, 0, time - 0.05 );
        return;
    }
    
    if ( isdefined( self.children ) )
    {
        foreach ( child in self.children )
        {
            child unlink();
            upvelocity = ( 0, 0, 1 ) * randomfloatrange( 25, 60 ) + velocity;
            child physicslaunchclient( child.origin + ( 0, 0, 1 ), upvelocity );
        }
    }
    
    if ( isdefined( self.overridevelocity ) )
    {
        velocity = self.overridevelocity;
    }
    
    self physicslaunchclient( newpos, velocity );
}

// Namespace anim_sp / scripts\sp\anim
// Params 2
// Checksum 0x0, Offset: 0x5142
// Size: 0x41
function primaryweapon_leave_behind( tagname, suspend )
{
    origin = self gettagorigin( tagname );
    angles = self gettagangles( tagname );
    primaryweapon_leave_behind_internal( origin, angles, suspend );
}

// Namespace anim_sp / scripts\sp\anim
// Params 3
// Checksum 0x0, Offset: 0x518b
// Size: 0x8d
function primaryweapon_leave_behind_internal( origin, angles, spawnflags )
{
    if ( isdefined( self.gun_on_ground ) )
    {
        return;
    }
    
    if ( !isdefined( spawnflags ) )
    {
        spawnflags = 0;
    }
    
    gun = spawn( "weapon_" + getcompleteweaponname( self.weapon ), origin, spawnflags );
    gun.angles = angles;
    self.gun_on_ground = gun;
    scripts\anim\shared::placeweaponon( self.weapon, "none" );
    self.dropweapon = 0;
}

#using_animtree( "player" );

// Namespace anim_sp / scripts\sp\anim
// Params 1
// Checksum 0x0, Offset: 0x5220
// Size: 0x30, Type: bool
function function_6b36e63fb918cd04( animname )
{
    if ( isdefined( level.scr_animtree[ animname ] ) && level.scr_animtree[ animname ] == #animtree )
    {
        return true;
    }
    
    return false;
}

