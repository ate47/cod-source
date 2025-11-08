#using script_6c1b22ea36b176be;
#using scripts\anim\battlechatter;
#using scripts\common\fx;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\engine\hud_management;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\art;
#using scripts\sp\audio;
#using scripts\sp\autosave;
#using scripts\sp\colors;
#using scripts\sp\compass;
#using scripts\sp\fakeactor;
#using scripts\sp\geo_mover;
#using scripts\sp\hud_util;
#using scripts\sp\lights;
#using scripts\sp\mgturret;
#using scripts\sp\player_death;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\utility;
#using scripts\stealth\player;

#namespace trigger;

// Namespace trigger / scripts\sp\trigger
// Params 0
// Checksum 0x0, Offset: 0x10b2
// Size: 0x2bf
function get_load_trigger_classes()
{
    trigger_classes = [];
    trigger_classes[ "trigger_multiple_nobloodpool" ] = &trigger_nobloodpool;
    trigger_classes[ "trigger_multiple_flag_set" ] = &trigger_flag_set;
    trigger_classes[ "trigger_radius_flag_set" ] = &trigger_flag_set;
    trigger_classes[ "trigger_multiple_flag_clear" ] = &trigger_flag_clear;
    trigger_classes[ "trigger_radius_flag_clear" ] = &trigger_flag_clear;
    trigger_classes[ "trigger_multiple_sun_off" ] = &trigger_sun_off;
    trigger_classes[ "trigger_multiple_sun_on" ] = &trigger_sun_on;
    trigger_classes[ "trigger_use_flag_set" ] = &trigger_flag_set;
    trigger_classes[ "trigger_use_flag_clear" ] = &trigger_flag_clear;
    trigger_classes[ "trigger_multiple_flag_set_touching" ] = &trigger_flag_set_touching;
    trigger_classes[ "trigger_multiple_flag_lookat" ] = &trigger_lookat;
    trigger_classes[ "trigger_multiple_flag_looking" ] = &trigger_looking;
    trigger_classes[ "trigger_multiple_no_prone" ] = &trigger_no_prone;
    trigger_classes[ "trigger_multiple_no_crouch_or_prone" ] = &trigger_no_crouch_or_prone;
    trigger_classes[ "trigger_multiple_compass" ] = &trigger_multiple_compass;
    trigger_classes[ "trigger_multiple_fx_volume" ] = &trigger_multiple_fx_volume;
    trigger_classes[ "trigger_multiple_kleenex" ] = &trigger_multiple_kleenex;
    trigger_classes[ "trigger_multiple_light_sunshadow" ] = &scripts\sp\lights::sun_shadow_trigger;
    trigger_classes[ "trigger_multiple_arbitrary_up" ] = &trigger_arbitrary_up;
    
    if ( !scripts\sp\starts::is_no_game_start() )
    {
        trigger_classes[ "trigger_multiple_autosave" ] = &scripts\sp\autosave::trigger_autosave;
        trigger_classes[ "trigger_multiple_autosave_silent" ] = &scripts\sp\autosave::function_e96f7708c1775016;
        trigger_classes[ "trigger_multiple_spawn" ] = &scripts\sp\spawner::trigger_spawner;
        trigger_classes[ "trigger_multiple_spawn_reinforcement" ] = &scripts\sp\spawner::trigger_spawner_reinforcement;
        trigger_classes[ "trigger_multiple_zone_spawn" ] = &scripts\sp\spawner::trigger_zone_spawn;
    }
    
    trigger_classes[ "trigger_multiple_stealth_shadow" ] = &trigger_stealth_shadow;
    trigger_classes[ "trigger_multiple_slide" ] = &namespace_7b69f911b6d80230::trigger_slide;
    trigger_classes[ "trigger_multiple_depthoffield" ] = &trigger_multiple_depthoffield;
    trigger_classes[ "trigger_multiple_tessellationcutoff" ] = &trigger_multiple_tessellationcutoff;
    trigger_classes[ "trigger_damage_player_flag_set" ] = &trigger_damage_player_flag_set;
    trigger_classes[ "trigger_multiple_glass_break" ] = &trigger_glass_break;
    trigger_classes[ "trigger_radius_glass_break" ] = &trigger_glass_break;
    trigger_classes[ "trigger_multiple_friendly_respawn" ] = &trigger_friendly_respawn;
    trigger_classes[ "trigger_multiple_friendly_stop_respawn" ] = &trigger_friendly_stop_respawn;
    trigger_classes[ "trigger_multiple_physics" ] = &trigger_physics;
    trigger_classes[ "trigger_multiple_fx_watersheeting" ] = &trigger_multiple_fx_watersheeting;
    trigger_classes[ "trigger_multiple_fakeactor_move" ] = &scripts\sp\fakeactor::trigger_fakeactor_move;
    trigger_classes[ "trigger_multiple_fakeactor_node_disable" ] = &scripts\sp\fakeactor::trigger_fakeactor_node_disable;
    trigger_classes[ "trigger_multiple_fakeactor_node_enable" ] = &scripts\sp\fakeactor::trigger_fakeactor_node_enable;
    trigger_classes[ "trigger_multiple_fakeactor_node_disablegroup" ] = &scripts\sp\fakeactor::trigger_fakeactor_node_disablegroup;
    trigger_classes[ "trigger_multiple_fakeactor_node_enablegroup" ] = &scripts\sp\fakeactor::trigger_fakeactor_node_enablegroup;
    trigger_classes[ "trigger_multiple_fakeactor_node_passthrough" ] = &scripts\sp\fakeactor::trigger_fakeactor_node_passthrough;
    trigger_classes[ "trigger_multiple_fakeactor_node_lock" ] = &scripts\sp\fakeactor::trigger_fakeactor_node_lock;
    trigger_classes[ "trigger_multiple_geo_mover" ] = &scripts\sp\geo_mover::trigger_moveto;
    
    /#
        trigger_classes[ "<dev string:x1c>" ] = &trigger_createart_transient;
    #/
    
    trigger_classes[ "trigger_multiple_transient" ] = &trigger_multiple_transient;
    trigger_classes[ "trigger_multiple_fire" ] = &trigger_fire;
    trigger_classes[ "trigger_radius_fire" ] = &trigger_fire;
    trigger_classes[ "trigger_multiple_fx_on" ] = &trigger_multiple_fx;
    trigger_classes[ "trigger_multiple_fx_off" ] = &trigger_multiple_fx;
    trigger_classes[ "trigger_multiple_fx_fxzone" ] = &trigger_flag_set_touching;
    trigger_classes[ "trigger_multiple_unlock" ] = &trigger_unlock;
    trigger_classes[ "trigger_multiple_light_on_touching" ] = &scripts\sp\lights::function_adb0429de1a7284;
    return trigger_classes;
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x137a
// Size: 0x6a
function trigger_multiple_fx_watersheeting( trigger )
{
    duration = 3;
    
    if ( isdefined( trigger.script_duration ) )
    {
        duration = trigger.script_duration;
    }
    
    while ( true )
    {
        trigger waittill( "trigger", other );
        
        if ( isplayer( other ) )
        {
            other setwatersheeting( 1, duration );
            wait duration * 0.2;
        }
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 0
// Checksum 0x0, Offset: 0x13ec
// Size: 0x22d
function get_load_trigger_funcs()
{
    trigger_funcs = [];
    trigger_funcs[ "friendly_mgTurret" ] = &scripts\sp\spawner::friendly_mgturret;
    
    if ( !scripts\sp\starts::is_no_game_start() )
    {
        trigger_funcs[ "camper_spawner" ] = &scripts\sp\spawner::camper_trigger_think;
        trigger_funcs[ "flood_spawner" ] = &scripts\sp\spawner::flood_trigger_think;
        trigger_funcs[ "trigger_spawner" ] = &scripts\sp\spawner::trigger_spawner;
        trigger_funcs[ "trigger_autosave" ] = &scripts\sp\autosave::trigger_autosave;
        trigger_funcs[ "trigger_spawngroup" ] = &trigger_spawngroup;
        trigger_funcs[ "trigger_vehicle_spline_spawn" ] = &trigger_vehicle_spline_spawn;
        trigger_funcs[ "trigger_vehicle_spawn" ] = &scripts\sp\spawner::trigger_spawner;
        trigger_funcs[ "random_spawn" ] = &scripts\sp\spawner::random_spawn;
        trigger_funcs[ "zone_spawn" ] = &scripts\sp\spawner::trigger_zone_spawn;
    }
    
    trigger_funcs[ "autosave_now" ] = &scripts\sp\autosave::autosave_now_trigger;
    trigger_funcs[ "trigger_autosave_tactical" ] = &scripts\sp\autosave::trigger_autosave_tactical;
    trigger_funcs[ "trigger_autosave_stealth" ] = &scripts\sp\autosave::trigger_autosave_stealth;
    trigger_funcs[ "trigger_unlock" ] = &trigger_unlock;
    trigger_funcs[ "trigger_lookat" ] = &trigger_lookat;
    trigger_funcs[ "trigger_looking" ] = &trigger_looking;
    trigger_funcs[ "trigger_cansee" ] = &trigger_cansee;
    trigger_funcs[ "flag_set" ] = &trigger_flag_set;
    trigger_funcs[ "flag_set_player" ] = &trigger_flag_set_player;
    trigger_funcs[ "flag_unset" ] = &trigger_flag_clear;
    trigger_funcs[ "flag_clear" ] = &trigger_flag_clear;
    trigger_funcs[ "friendly_respawn_trigger" ] = &trigger_friendly_respawn;
    trigger_funcs[ "radio_trigger" ] = &trigger_radio;
    trigger_funcs[ "trigger_ignore" ] = &trigger_ignore;
    trigger_funcs[ "trigger_pacifist" ] = &trigger_pacifist;
    trigger_funcs[ "trigger_delete" ] = &trigger_turns_off;
    trigger_funcs[ "trigger_delete_on_touch" ] = &trigger_delete_on_touch;
    trigger_funcs[ "trigger_off" ] = &trigger_turns_off;
    trigger_funcs[ "trigger_outdoor" ] = &scripts\sp\spawner::outdoor_think;
    trigger_funcs[ "trigger_indoor" ] = &scripts\sp\spawner::indoor_think;
    trigger_funcs[ "trigger_hint" ] = &trigger_hint;
    trigger_funcs[ "trigger_grenade_at_player" ] = &trigger_throw_grenade_at_player;
    trigger_funcs[ "flag_on_cleared" ] = &trigger_flag_on_cleared;
    trigger_funcs[ "flag_set_touching" ] = &trigger_flag_set_touching;
    trigger_funcs[ "delete_link_chain" ] = &trigger_delete_link_chain;
    trigger_funcs[ "trigger_slide" ] = &trigger_slide;
    trigger_funcs[ "trigger_dooropen" ] = &trigger_dooropen;
    trigger_funcs[ "geo_mover" ] = &scripts\sp\geo_mover::trigger_moveto;
    trigger_funcs[ "out_of_bounds" ] = &trigger_outofbounds;
    trigger_funcs[ "no_crouch_or_prone" ] = &trigger_no_crouch_or_prone;
    trigger_funcs[ "no_prone" ] = &trigger_no_prone;
    return trigger_funcs;
}

// Namespace trigger / scripts\sp\trigger
// Params 0
// Checksum 0x0, Offset: 0x1622
// Size: 0x3ef
function init_script_triggers()
{
    scripts\sp\colors::init_colors();
    scripts\sp\audio::init_audio();
    array_delete( getentarray( "trigger_multiple_softlanding", "classname" ) );
    trigger_classes = get_load_trigger_classes();
    trigger_funcs = get_load_trigger_funcs();
    
    foreach ( function in trigger_classes )
    {
        triggers = getentarray( classname, "classname" );
        array_levelthread( triggers, function );
    }
    
    trigger_multiple = getentarray( "trigger_multiple", "classname" );
    trigger_radius = getentarray( "trigger_radius", "classname" );
    triggers = array_merge( trigger_multiple, trigger_radius );
    trigger_disk = getentarray( "trigger_disk", "classname" );
    triggers = array_merge( triggers, trigger_disk );
    trigger_once = getentarray( "trigger_once", "classname" );
    triggers = array_merge( triggers, trigger_once );
    
    if ( !scripts\sp\starts::is_no_game_start() )
    {
        for ( i = 0; i < triggers.size ; i++ )
        {
            if ( triggers[ i ].spawnflags & 32 )
            {
                thread scripts\sp\spawner::trigger_spawner( triggers[ i ] );
            }
        }
    }
    
    code_classes = [ "trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_disk", "trigger_damage" ];
    
    foreach ( triggertype in code_classes )
    {
        triggers = getentarray( triggertype, "code_classname" );
        
        foreach ( trigger in triggers )
        {
            if ( isdefined( trigger.script_flag_true ) )
            {
                level thread trigger_script_flag_true( trigger );
            }
            
            if ( isdefined( trigger.script_flag_false ) )
            {
                level thread trigger_script_flag_false( trigger );
            }
            
            if ( isdefined( trigger.script_autosavename ) || isdefined( trigger.script_autosave ) )
            {
                level thread scripts\sp\autosave::function_806ee0c06769f6f( trigger );
            }
            
            if ( isdefined( trigger.script_mgturretauto ) )
            {
                level thread scripts\sp\mgturret::mgturret_auto( trigger );
            }
            
            if ( isdefined( trigger.script_killspawner ) )
            {
                level thread scripts\sp\spawner::kill_spawner( trigger );
            }
            
            if ( isdefined( trigger.script_kill_vehicle_spawner ) )
            {
                level thread scripts\common\vehicle_code::vehicle_triggerkillspawner( trigger );
            }
            
            if ( isdefined( trigger.script_emptyspawner ) )
            {
                level thread scripts\sp\spawner::empty_spawner( trigger );
            }
            
            if ( isdefined( trigger.script_prefab_exploder ) )
            {
                trigger.script_exploder = trigger.script_prefab_exploder;
            }
            
            if ( isdefined( trigger.script_exploder ) )
            {
                level thread exploder_load( trigger );
            }
            
            if ( isdefined( trigger.script_triggered_playerseek ) )
            {
                level thread trigger_playerseek( trigger );
            }
            
            if ( isdefined( trigger.script_bctrigger ) )
            {
                level thread trigger_battlechatter( trigger );
            }
            
            if ( isdefined( trigger.script_trigger_group ) )
            {
                trigger thread trigger_group();
            }
            
            if ( isdefined( trigger.script_random_killspawner ) )
            {
                level thread scripts\sp\spawner::random_killspawner( trigger );
            }
            
            if ( isdefined( trigger.targetname ) )
            {
                targetname = trigger.targetname;
                
                if ( isdefined( trigger_funcs[ targetname ] ) )
                {
                    level thread [[ trigger_funcs[ targetname ] ]]( trigger );
                }
            }
        }
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x1a19
// Size: 0x8b
function trigger_createart_transient( trigger )
{
    delete_trigger = 1;
    
    /#
        delete_trigger = 0;
        assertex( isdefined( trigger.script_transient ), "<dev string:x41>" + trigger.origin + "<dev string:x61>" );
        
        if ( !isdefined( level.var_66f10e73bb798144 ) )
        {
            level.var_66f10e73bb798144 = [];
        }
        
        level.var_66f10e73bb798144[ level.var_66f10e73bb798144.size ] = trigger;
        level thread createart_transient_thread();
    #/
    
    if ( delete_trigger )
    {
        trigger delete();
    }
}

/#

    // Namespace trigger / scripts\sp\trigger
    // Params 0
    // Checksum 0x0, Offset: 0x1aac
    // Size: 0x298, Type: dev
    function createart_transient_thread()
    {
        level notify( "<dev string:x7f>" );
        level endon( "<dev string:x7f>" );
        
        while ( !is_transient_createart_enabled() )
        {
            wait 1;
        }
        
        current_trans = "<dev string:x9a>";
        all_trans = [];
        
        foreach ( trigger in level.var_66f10e73bb798144 )
        {
            array = strtok( trigger.script_transient, "<dev string:x9b>" );
            
            foreach ( tran in array )
            {
                exists = 0;
                
                if ( !array_contains( all_trans, tran ) )
                {
                    all_trans[ all_trans.size ] = tran;
                }
            }
        }
        
        new_trans = current_trans;
        
        while ( true )
        {
            wait 1;
            
            if ( !is_transient_createart_enabled() )
            {
                continue;
            }
            
            foreach ( trigger in level.var_66f10e73bb798144 )
            {
                if ( level.player istouching( trigger ) )
                {
                    new_trans = trigger.script_transient;
                    break;
                }
            }
            
            if ( current_trans != new_trans )
            {
                load_array = [];
                unload_array = [];
                var_686fd3960ce92c66 = strtok( new_trans, "<dev string:x9b>" );
                
                foreach ( str in all_trans )
                {
                    if ( array_contains( var_686fd3960ce92c66, str ) )
                    {
                        load_array[ load_array.size ] = str;
                        continue;
                    }
                    
                    unload_array[ unload_array.size ] = str;
                }
                
                if ( current_trans == "<dev string:x9a>" )
                {
                    unloadalltransients();
                }
                
                if ( unload_array.size > 0 )
                {
                    transient_unload_array( unload_array );
                }
                
                foreach ( trans in load_array )
                {
                    transient_load( trans );
                }
                
                current_trans = new_trans;
            }
        }
    }

#/

// Namespace trigger / scripts\sp\trigger
// Params 0
// Checksum 0x0, Offset: 0x1d4c
// Size: 0x56, Type: bool
function is_transient_createart_enabled()
{
    if ( getdvar( @"createfx" ) != "" )
    {
        return true;
    }
    
    if ( getdvarint( @"scr_art_tweak" ) > 0 )
    {
        return true;
    }
    
    if ( isdefined( level.start_point ) && level.start_point == "no_game" )
    {
        return true;
    }
    
    return false;
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x1dab
// Size: 0x2be
function trigger_multiple_transient( trigger )
{
    /#
        pass = 0;
        
        if ( !isdefined( trigger.script_transient ) && !isdefined( trigger.script_transient_unload ) && !isdefined( trigger.script_transient_set ) && !isdefined( trigger.script_transient_unload_set ) && !isdefined( trigger.var_6803211c32618486 ) && !isdefined( trigger.var_e6aa8bd6620dc7cf ) )
        {
            assertmsg( "<dev string:x9d>" + trigger.origin + "<dev string:xbc>" );
        }
    #/
    
    loads = undefined;
    unloads = undefined;
    load_set = undefined;
    unload_set = 0;
    vis = undefined;
    invis = undefined;
    
    if ( isdefined( trigger.script_transient ) )
    {
        loads = strtok( trigger.script_transient, " " );
    }
    
    if ( isdefined( trigger.script_transient_unload ) )
    {
        unloads = strtok( trigger.script_transient_unload, " " );
    }
    
    if ( isdefined( trigger.script_transient_set ) )
    {
        load_set = trigger.script_transient_set;
    }
    
    if ( isdefined( trigger.script_transient_unload_set ) )
    {
        unload_set = 1;
    }
    
    if ( isdefined( trigger.var_6803211c32618486 ) )
    {
        vis = strtok( trigger.var_6803211c32618486, " " );
    }
    
    if ( isdefined( trigger.var_e6aa8bd6620dc7cf ) )
    {
        invis = strtok( trigger.var_e6aa8bd6620dc7cf, " " );
    }
    
    flag_check = [];
    flag_check = array_combine( loads, unloads );
    
    if ( isdefined( trigger.script_transient_set ) )
    {
        names = gettransientsinset( trigger.script_transient_set );
        flag_check = array_combine( flag_check, names );
    }
    
    foreach ( str in flag_check )
    {
        if ( !flag_exist( str + "_loaded" ) )
        {
            flag_init( str + "_loaded" );
        }
    }
    
    while ( true )
    {
        trigger waittill( "trigger" );
        
        if ( isdefined( vis ) )
        {
            function_17175f6af83bafea( vis );
        }
        
        if ( isdefined( unloads ) )
        {
            transient_unload_array( unloads );
        }
        
        if ( isdefined( loads ) )
        {
            transient_load_array( loads );
        }
        
        if ( isdefined( invis ) )
        {
            function_7dcc5e04ab79399b( invis );
        }
        
        if ( isdefined( load_set ) )
        {
            switchtransientset( load_set );
        }
        
        if ( istrue( unload_set ) )
        {
            switchtransientset( "none" );
        }
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x2071
// Size: 0x73
function trigger_damage_player_flag_set( trigger )
{
    flag = trigger get_trigger_flag();
    
    if ( !isdefined( level.flag[ flag ] ) )
    {
        flag_init( flag );
    }
    
    for ( ;; )
    {
        trigger waittill( "trigger", other );
        
        if ( !isalive( other ) )
        {
            continue;
        }
        
        if ( !isplayer( other ) )
        {
            continue;
        }
        
        trigger script_delay();
        flag_set( flag, other );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x20ec
// Size: 0x4f
function trigger_flag_clear( trigger )
{
    flag = trigger get_trigger_flag();
    
    if ( !isdefined( level.flag[ flag ] ) )
    {
        flag_init( flag );
    }
    
    for ( ;; )
    {
        trigger waittill( "trigger" );
        trigger script_delay();
        flag_clear( flag );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x2143
// Size: 0x5a
function trigger_flag_on_cleared( trigger )
{
    flag = trigger get_trigger_flag();
    
    if ( !isdefined( level.flag[ flag ] ) )
    {
        flag_init( flag );
    }
    
    for ( ;; )
    {
        trigger waittill( "trigger" );
        wait 1;
        
        if ( trigger found_toucher() )
        {
            continue;
        }
        
        break;
    }
    
    flag_set( flag );
}

// Namespace trigger / scripts\sp\trigger
// Params 0
// Checksum 0x0, Offset: 0x21a5
// Size: 0x8c, Type: bool
function found_toucher()
{
    ai = getaiarray( "bad_guys" );
    
    for ( i = 0; i < ai.size ; i++ )
    {
        guy = ai[ i ];
        
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        if ( guy istouching( self ) )
        {
            return true;
        }
        
        wait 0.1;
    }
    
    ai = getaiarray( "bad_guys" );
    
    for ( i = 0; i < ai.size ; i++ )
    {
        guy = ai[ i ];
        
        if ( guy istouching( self ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x223a
// Size: 0x63
function trigger_flag_set( trigger )
{
    flag = trigger get_trigger_flag();
    
    if ( !isdefined( level.flag[ flag ] ) )
    {
        flag_init( flag );
    }
    
    for ( ;; )
    {
        trigger waittill( "trigger", other );
        trigger script_delay();
        flag_set( flag, other );
        
        if ( !isdefined( trigger ) )
        {
            break;
        }
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x22a5
// Size: 0xb6
function trigger_friendly_respawn( trigger )
{
    trigger endon( "death" );
    org = getent( trigger.target, "targetname" );
    origin = undefined;
    
    if ( isdefined( org ) )
    {
        origin = org.origin;
        org delete();
    }
    else
    {
        org = getstruct( trigger.target, "targetname" );
        assertex( isdefined( org ), "trigger_multiple_friendly_respawn doesn't target an origin." );
        origin = org.origin;
    }
    
    for ( ;; )
    {
        trigger waittill( "trigger" );
        level.respawn_spawner_org = origin;
        flag_set( "respawn_friendlies" );
        wait 0.5;
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x2363
// Size: 0xe3
function trigger_landingzone( trigger )
{
    flag = trigger get_trigger_flag();
    
    if ( !isdefined( level.flag[ flag ] ) )
    {
        flag_init( flag );
    }
    
    if ( !isdefined( level.landingzones_active ) )
    {
        level.landingzones_active = [];
    }
    
    for ( ;; )
    {
        trigger waittill( "trigger", player );
        
        if ( isalive( player ) && isdefined( trigger ) && player istouching( trigger ) )
        {
            level.landingzones_active = array_add( level.landingzones_active, trigger );
        }
        
        while ( isalive( player ) && isdefined( trigger ) && player istouching( trigger ) )
        {
            if ( !flag( flag ) )
            {
                thread trigger_landingzone_active( flag );
            }
            
            wait 0.25;
        }
        
        level.landingzones_active = array_remove( level.landingzones_active, trigger );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x244e
// Size: 0x4e
function trigger_landingzone_active( flag )
{
    flag_set( flag );
    
    for ( ;; )
    {
        level.landingzones_active = array_removeundefined( level.landingzones_active );
        
        if ( level.landingzones_active.size == 0 )
        {
            break;
        }
        
        wait 0.25;
    }
    
    flag_clear( flag );
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x24a4
// Size: 0x52
function trigger_arbitrary_up( trigger )
{
    trigger setworlduptrigger( 1 );
    
    if ( isdefined( trigger.target ) )
    {
        parent = getent( trigger.target, "targetname" );
        trigger enablelinkto();
        trigger linkto( parent );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x24fe
// Size: 0x9f
function trigger_flag_set_touching( trigger )
{
    flag = trigger get_trigger_flag();
    
    if ( !isdefined( level.flag[ flag ] ) )
    {
        flag_init( flag );
    }
    
    for ( ;; )
    {
        trigger waittill( "trigger", other );
        trigger script_delay();
        
        if ( isalive( other ) && isdefined( trigger ) && other istouching( trigger ) )
        {
            flag_set( flag );
        }
        
        while ( isalive( other ) && isdefined( trigger ) && other istouching( trigger ) )
        {
            wait 0.25;
        }
        
        flag_clear( flag );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x25a5
// Size: 0x22
function trigger_friendly_stop_respawn( trigger )
{
    for ( ;; )
    {
        trigger waittill( "trigger" );
        flag_clear( "respawn_friendlies" );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 0
// Checksum 0x0, Offset: 0x25cf
// Size: 0x36
function trigger_group()
{
    thread trigger_group_remove();
    level endon( "trigger_group_" + self.script_trigger_group );
    self waittill( "trigger" );
    level notify( "trigger_group_" + self.script_trigger_group, self );
}

// Namespace trigger / scripts\sp\trigger
// Params 0
// Checksum 0x0, Offset: 0x260d
// Size: 0x2c
function trigger_group_remove()
{
    level waittill( "trigger_group_" + self.script_trigger_group, trigger );
    
    if ( self != trigger )
    {
        self delete();
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x2641
// Size: 0x44
function trigger_nobloodpool( trigger )
{
    for ( ;; )
    {
        trigger waittill( "trigger", other );
        
        if ( !isalive( other ) )
        {
            continue;
        }
        
        other.skipbloodpool = 1;
        other thread set_wait_then_clear_skipbloodpool();
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 0
// Checksum 0x0, Offset: 0x268d
// Size: 0x25
function set_wait_then_clear_skipbloodpool()
{
    self notify( "notify_wait_then_clear_skipBloodPool" );
    self endon( "notify_wait_then_clear_skipBloodPool" );
    self endon( "death" );
    wait 2;
    self.skipbloodpool = undefined;
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x26ba
// Size: 0x279
function trigger_physics( trigger )
{
    assertex( isdefined( trigger.target ), "Trigger_physics at " + trigger.origin + " has no target for physics." );
    ents = [];
    structs = getstructarray( trigger.target, "targetname" );
    orgs = getentarray( trigger.target, "targetname" );
    
    foreach ( org in orgs )
    {
        struct = spawnstruct();
        struct.origin = org.origin;
        struct.script_parameters = org.script_parameters;
        struct.script_damage = org.script_damage;
        struct.radius = org.radius;
        structs[ structs.size ] = struct;
        org delete();
    }
    
    assertex( structs.size, "Trigger_physics at " + trigger.origin + " has no target for physics." );
    trigger.org = structs[ 0 ].origin;
    trigger waittill( "trigger" );
    trigger script_delay();
    
    foreach ( struct in structs )
    {
        radius = struct.radius;
        vel = struct.script_parameters;
        damage = struct.script_damage;
        
        if ( !isdefined( radius ) )
        {
            radius = 350;
        }
        
        if ( !isdefined( vel ) )
        {
            vel = 0.25;
        }
        
        setdvar( @"tempdvar", vel );
        vel = getdvarfloat( @"tempdvar" );
        
        if ( isdefined( damage ) )
        {
            radiusdamage( struct.origin, radius, damage, damage * 0.5 );
        }
        
        physicsexplosionsphere( struct.origin, radius, radius * 0.5, vel );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x293b
// Size: 0xb3
function trigger_playerseek( trig )
{
    groupnum = trig.script_triggered_playerseek;
    trig waittill( "trigger" );
    ai = getaiarray();
    
    for ( i = 0; i < ai.size ; i++ )
    {
        if ( !isalive( ai[ i ] ) )
        {
            continue;
        }
        
        if ( isdefined( ai[ i ].script_triggered_playerseek ) && ai[ i ].script_triggered_playerseek == groupnum )
        {
            ai[ i ].goalradius = 800;
            ai[ i ] setgoalentity( level.player );
            level thread scripts\sp\spawner::delayed_player_seek_think( ai[ i ] );
        }
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x29f6
// Size: 0x38
function trigger_script_flag_false( trigger )
{
    tokens = create_flags_and_return_tokens( trigger.script_flag_false );
    trigger add_tokens_to_trigger_flags( tokens );
    trigger update_trigger_based_on_flags();
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x2a36
// Size: 0x38
function trigger_script_flag_true( trigger )
{
    tokens = create_flags_and_return_tokens( trigger.script_flag_true );
    trigger add_tokens_to_trigger_flags( tokens );
    trigger update_trigger_based_on_flags();
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x2a76
// Size: 0x68
function add_tokens_to_trigger_flags( tokens )
{
    for ( i = 0; i < tokens.size ; i++ )
    {
        flag = tokens[ i ];
        
        if ( !isdefined( level.trigger_flags[ flag ] ) )
        {
            level.trigger_flags[ flag ] = [];
        }
        
        level.trigger_flags[ flag ][ level.trigger_flags[ flag ].size ] = self;
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x2ae6
// Size: 0xda
function trigger_spawngroup( trigger )
{
    waittillframeend();
    assertex( isdefined( trigger.script_spawngroup ), "spawngroup Trigger at " + trigger.origin + " has no script_spawngroup" );
    spawngroup = trigger.script_spawngroup;
    
    if ( !isdefined( level.spawn_group ) || !isdefined( level.spawn_groups[ spawngroup ] ) )
    {
        return;
    }
    
    trigger waittill( "trigger" );
    spawners = random( level.spawn_groups[ spawngroup ] );
    
    foreach ( spawner in spawners )
    {
        spawner spawn_ai();
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x2bc8
// Size: 0x47
function trigger_sun_off( trigger )
{
    for ( ;; )
    {
        trigger waittill( "trigger", other );
        
        if ( getdvarint( @"sm_sunenable" ) == 0 )
        {
            continue;
        }
        
        setsaveddvar( @"sm_sunenable", 0 );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x2c17
// Size: 0x49
function trigger_sun_on( trigger )
{
    for ( ;; )
    {
        trigger waittill( "trigger", other );
        
        if ( getdvarint( @"sm_sunenable" ) == 1 )
        {
            continue;
        }
        
        setsaveddvar( @"sm_sunenable", 1 );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x2c68
// Size: 0x85
function trigger_vehicle_spline_spawn( trigger )
{
    trigger waittill( "trigger" );
    spawners = getentarray( trigger.target, "targetname" );
    
    foreach ( spawner in spawners )
    {
        spawner thread scripts\common\vehicle_code::spawn_vehicle_and_attach_to_spline_path( 70 );
        wait 0.05;
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 0
// Checksum 0x0, Offset: 0x2cf5
// Size: 0x223
function get_trigger_targs()
{
    triggers = [];
    target_origin = undefined;
    
    if ( isdefined( self.target ) )
    {
        targets = getentarray( self.target, "targetname" );
        orgs = [];
        
        foreach ( target in targets )
        {
            if ( target.classname == "script_origin" || target.classname == "script_origin_mini" )
            {
                orgs[ orgs.size ] = target;
            }
            
            if ( issubstr( target.classname, "trigger" ) )
            {
                triggers[ triggers.size ] = target;
            }
        }
        
        targets = getstructarray( self.target, "targetname" );
        
        foreach ( target in targets )
        {
            orgs[ orgs.size ] = target;
        }
        
        assertex( orgs.size < 2, "Trigger at " + self.origin + " targets multiple script origins" );
        
        if ( orgs.size == 1 )
        {
            org = orgs[ 0 ];
            target_origin = org.origin;
            
            if ( isdefined( org.code_classname ) )
            {
                org delete();
            }
        }
    }
    
    /#
        if ( isdefined( self.targetname ) )
        {
            assertex( isdefined( target_origin ), self.targetname + "<dev string:x165>" + self.origin + "<dev string:x16a>" );
        }
        else
        {
            assertex( isdefined( target_origin ), self.classname + "<dev string:x165>" + self.origin + "<dev string:x16a>" );
        }
    #/
    
    array = [];
    array[ "triggers" ] = triggers;
    array[ "target_origin" ] = target_origin;
    return array;
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x2f21
// Size: 0x15
function trigger_lookat( trigger )
{
    trigger_lookat_think( trigger, 1 );
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x2f3e
// Size: 0x14
function trigger_looking( trigger )
{
    trigger_lookat_think( trigger, 0 );
}

// Namespace trigger / scripts\sp\trigger
// Params 2
// Checksum 0x0, Offset: 0x2f5a
// Size: 0x327
function trigger_lookat_think( trigger, endonflag )
{
    success_dot = 0.78;
    
    if ( isdefined( trigger.script_dot ) )
    {
        success_dot = trigger.script_dot;
        assertex( success_dot <= 1, "Script_dot should be between 0 and 1" );
    }
    
    array = trigger get_trigger_targs();
    triggers = array[ "triggers" ];
    target_origin = array[ "target_origin" ];
    has_flag = isdefined( trigger.script_flag ) || isdefined( trigger.script_noteworthy );
    flagname = undefined;
    
    if ( has_flag )
    {
        flagname = trigger get_trigger_flag();
        
        if ( !isdefined( level.flag[ flagname ] ) )
        {
            flag_init( flagname );
        }
    }
    else if ( !triggers.size )
    {
        assertex( isdefined( trigger.script_flag ) || isdefined( trigger.script_noteworthy ), "Trigger_lookat at " + trigger.origin + " has no script_flag! The script_flag is used as a flag that gets set when the trigger is activated." );
    }
    
    if ( endonflag && has_flag )
    {
        level endon( flagname );
    }
    
    trigger endon( "death" );
    do_sighttrace = 1;
    
    if ( isdefined( trigger.script_nosight ) )
    {
        do_sighttrace = trigger.script_nosight;
    }
    
    duration = 0;
    
    if ( isdefined( trigger.script_duration ) )
    {
        duration = trigger.script_duration;
    }
    
    debounce = 0.05;
    
    if ( do_sighttrace )
    {
        debounce = 0.5;
    }
    
    for ( ;; )
    {
        if ( has_flag )
        {
            flag_clear( flagname );
        }
        
        trigger waittill( "trigger", other );
        assertex( isplayer( other ), "trigger_lookat currently only supports looking from the player" );
        touching_trigger = [];
        time_elapsed = 0;
        
        while ( other istouching( trigger ) )
        {
            player_eye = other geteye();
            
            if ( do_sighttrace )
            {
                sighttracesuccess = 0;
                
                if ( isdefined( level.var_76be4c1d6bd7dbd9 ) )
                {
                    sighttracesuccess = scripts\engine\trace::ray_trace_passed( player_eye, target_origin, level.player, level.var_76be4c1d6bd7dbd9 );
                }
                else
                {
                    sighttracesuccess = sighttracepassed( player_eye, target_origin, 0, undefined );
                }
                
                if ( !sighttracesuccess )
                {
                    time_elapsed = 0;
                    
                    if ( has_flag )
                    {
                        flag_clear( flagname );
                    }
                    
                    wait debounce;
                    continue;
                }
            }
            
            normal = vectornormalize( target_origin - player_eye );
            player_angles = other getplayerangles();
            player_forward = anglestoforward( player_angles );
            dot = vectordot( player_forward, normal );
            
            if ( dot >= success_dot )
            {
                time_elapsed += debounce;
                
                if ( time_elapsed >= duration )
                {
                    array_thread( triggers, &send_notify, "trigger" );
                    
                    if ( has_flag )
                    {
                        flag_set( flagname, other );
                    }
                    
                    if ( endonflag )
                    {
                        return;
                    }
                    
                    wait 2;
                }
            }
            else
            {
                time_elapsed = 0;
                
                if ( has_flag )
                {
                    flag_clear( flagname );
                }
            }
            
            wait debounce;
        }
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x3289
// Size: 0x1df
function trigger_cansee( trigger )
{
    triggers = [];
    target_origin = undefined;
    array = trigger get_trigger_targs();
    triggers = array[ "triggers" ];
    target_origin = array[ "target_origin" ];
    has_flag = isdefined( trigger.script_flag ) || isdefined( trigger.script_noteworthy );
    flagname = undefined;
    
    if ( has_flag )
    {
        flagname = trigger get_trigger_flag();
        
        if ( !isdefined( level.flag[ flagname ] ) )
        {
            flag_init( flagname );
        }
    }
    else if ( !triggers.size )
    {
        assertex( isdefined( trigger.script_flag ) || isdefined( trigger.script_noteworthy ), "Trigger_cansee at " + trigger.origin + " has no script_flag! The script_flag is used as a flag that gets set when the trigger is activated." );
    }
    
    trigger endon( "death" );
    range = 12;
    offsets = [];
    offsets[ offsets.size ] = ( 0, 0, 0 );
    offsets[ offsets.size ] = ( range, 0, 0 );
    offsets[ offsets.size ] = ( range * -1, 0, 0 );
    offsets[ offsets.size ] = ( 0, range, 0 );
    offsets[ offsets.size ] = ( 0, range * -1, 0 );
    offsets[ offsets.size ] = ( 0, 0, range );
    
    for ( ;; )
    {
        if ( has_flag )
        {
            flag_clear( flagname );
        }
        
        trigger waittill( "trigger", other );
        assertex( isplayer( other ), "trigger_cansee currently only supports looking from the player" );
        
        while ( level.player istouching( trigger ) )
        {
            if ( !other cantraceto( target_origin, offsets ) )
            {
                if ( has_flag )
                {
                    flag_clear( flagname );
                }
                
                wait 0.1;
                continue;
            }
            
            if ( has_flag )
            {
                flag_set( flagname );
            }
            
            array_thread( triggers, &send_notify, "trigger" );
            wait 0.5;
        }
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 2
// Checksum 0x0, Offset: 0x3470
// Size: 0x46, Type: bool
function cantraceto( target_origin, offsets )
{
    for ( i = 0; i < offsets.size ; i++ )
    {
        if ( sighttracepassed( self geteye(), target_origin + offsets[ i ], 1, self ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x34bf
// Size: 0xb3
function trigger_unlock( trigger )
{
    noteworthy = "ent_" + trigger getentitynumber() + "_not_set";
    
    if ( isdefined( trigger.script_noteworthy ) )
    {
        noteworthy = trigger.script_noteworthy;
    }
    
    target_triggers = getentarray( trigger.target, "targetname" );
    trigger thread trigger_unlock_death( trigger.target );
    
    for ( ;; )
    {
        array_thread( target_triggers, &trigger_off );
        trigger waittill( "trigger" );
        array_thread( target_triggers, &trigger_on );
        wait_for_an_unlocked_trigger( target_triggers, noteworthy );
        array_notify( target_triggers, "relock" );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x357a
// Size: 0x36
function trigger_unlock_death( target )
{
    self waittill( "death" );
    target_triggers = getentarray( target, "targetname" );
    array_thread( target_triggers, &trigger_off );
}

// Namespace trigger / scripts\sp\trigger
// Params 2
// Checksum 0x0, Offset: 0x35b8
// Size: 0x64
function wait_for_an_unlocked_trigger( triggers, noteworthy )
{
    level endon( "unlocked_trigger_hit" + noteworthy );
    ent = spawnstruct();
    
    for ( i = 0; i < triggers.size ; i++ )
    {
        triggers[ i ] thread report_trigger( ent, noteworthy );
    }
    
    ent waittill( "trigger" );
    level notify( "unlocked_trigger_hit" + noteworthy );
}

// Namespace trigger / scripts\sp\trigger
// Params 2
// Checksum 0x0, Offset: 0x3624
// Size: 0x33
function report_trigger( ent, noteworthy )
{
    self endon( "relock" );
    level endon( "unlocked_trigger_hit" + noteworthy );
    self waittill( "trigger" );
    ent notify( "trigger" );
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x365f
// Size: 0x24d
function trigger_battlechatter( trigger )
{
    realtrigger = undefined;
    
    if ( isdefined( trigger.target ) )
    {
        targetents = getentarray( trigger.target, "targetname" );
        
        if ( issubstr( targetents[ 0 ].classname, "trigger" ) )
        {
            realtrigger = targetents[ 0 ];
        }
    }
    
    if ( isdefined( realtrigger ) )
    {
        realtrigger waittill( "trigger", other );
    }
    else
    {
        trigger waittill( "trigger", other );
    }
    
    soldier = undefined;
    
    if ( isdefined( realtrigger ) )
    {
        if ( other.team != level.player.team && level.player istouching( trigger ) )
        {
            soldier = level.player scripts\anim\battlechatter::getclosestfriendlyspeaker( "custom" );
        }
        else if ( other.team == level.player.team )
        {
            enemyteam = "axis";
            
            if ( level.player.team == "axis" )
            {
                enemyteam = "allies";
            }
            
            soldiers = scripts\anim\battlechatter::getspeakers( enemyteam );
            soldiers = get_array_of_farthest( level.player.origin, soldiers );
            
            foreach ( guy in soldiers )
            {
                if ( guy istouching( trigger ) )
                {
                    soldier = guy;
                    
                    if ( battlechatter_dist_check( guy.origin ) )
                    {
                        break;
                    }
                }
            }
        }
    }
    else if ( isplayer( other ) )
    {
        soldier = other scripts\anim\battlechatter::getclosestfriendlyspeaker( "custom" );
    }
    else
    {
        soldier = other;
    }
    
    if ( !isdefined( soldier ) )
    {
        return;
    }
    
    if ( battlechatter_dist_check() )
    {
        return;
    }
    
    success = soldier custom_battlechatter( trigger.script_bctrigger );
    
    if ( !success )
    {
        level delaythread( 0.25, &trigger_battlechatter, trigger );
        return;
    }
    
    trigger notify( "custom_battlechatter_done" );
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x38b4
// Size: 0x25, Type: bool
function battlechatter_dist_check( origin )
{
    return distancesquared( origin, level.player getorigin() ) <= 262144;
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x38e2
// Size: 0xde
function trigger_dooropen( trigger )
{
    trigger waittill( "trigger" );
    targets = getentarray( trigger.target, "targetname" );
    rotations = [];
    rotations[ "left_door" ] = -170;
    rotations[ "right_door" ] = 170;
    
    foreach ( door in targets )
    {
        assertex( isdefined( door.script_noteworthy ), "Door had no script_noteworthy to indicate which door it is. Must be left_door or right_door." );
        rotation = rotations[ door.script_noteworthy ];
        door connectpaths();
        door rotateyaw( rotation, 1, 0, 0.5 );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x39c8
// Size: 0x1a8
function trigger_glass_break( trigger )
{
    glassid = getglassarray( trigger.target );
    type = "notetrack";
    
    if ( isdefined( trigger.script_type ) )
    {
        type = "trigger";
    }
    
    if ( !isdefined( glassid ) || glassid.size == 0 )
    {
        assertmsg( "Glass shatter trigger at origin " + trigger.origin + " needs to target a func_glass." );
        return;
    }
    
    other = undefined;
    
    while ( true )
    {
        if ( type == "notetrack" )
        {
            level waittill( "glass_break", other );
        }
        else
        {
            trigger waittill( "trigger", other );
        }
        
        if ( other istouching( trigger ) )
        {
            ref1 = other.origin;
            waitframe();
            ref2 = other.origin;
            direction = undefined;
            
            if ( ref1 != ref2 )
            {
                direction = ref2 - ref1;
            }
            
            if ( isdefined( direction ) )
            {
                foreach ( glass in glassid )
                {
                    destroyglass( glass, direction );
                }
                
                break;
            }
            
            foreach ( glass in glassid )
            {
                destroyglass( glass );
            }
            
            break;
        }
    }
    
    trigger delete();
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x3b78
// Size: 0x32
function trigger_delete_link_chain( trigger )
{
    trigger waittill( "trigger" );
    targets = trigger get_script_linkto_targets();
    array_thread( targets, &delete_links_then_self );
}

// Namespace trigger / scripts\sp\trigger
// Params 0
// Checksum 0x0, Offset: 0x3bb2
// Size: 0x84
function get_script_linkto_targets()
{
    targets = [];
    
    if ( !isdefined( self.script_linkto ) )
    {
        return targets;
    }
    
    tokens = strtok( self.script_linkto, " " );
    
    for ( i = 0; i < tokens.size ; i++ )
    {
        token = tokens[ i ];
        target = getent( token, "script_linkname" );
        
        if ( isdefined( target ) )
        {
            targets[ targets.size ] = target;
        }
    }
    
    return targets;
}

// Namespace trigger / scripts\sp\trigger
// Params 0
// Checksum 0x0, Offset: 0x3c3f
// Size: 0x27
function delete_links_then_self()
{
    targets = get_script_linkto_targets();
    array_thread( targets, &delete_links_then_self );
    self delete();
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x3c6e
// Size: 0x21
function trigger_throw_grenade_at_player( trigger )
{
    trigger endon( "death" );
    trigger waittill( "trigger" );
    throwgrenadeatplayerasap();
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x3c97
// Size: 0xed
function trigger_hint( trigger )
{
    assertex( isdefined( trigger.script_hint ), "Trigger_hint at " + trigger.origin + " has no .script_hint" );
    
    if ( !isdefined( level.displayed_hints ) )
    {
        level.displayed_hints = [];
    }
    
    waittillframeend();
    assertex( isdefined( level.trigger_hint_string ), "tried trigger hint without add_hint_string" );
    hint = trigger.script_hint;
    assertex( isdefined( level.trigger_hint_string[ hint ] ), "Trigger_hint with hint " + hint + " had no hint string assigned to it. Define hint strings with add_hint_string()" );
    trigger waittill( "trigger", other );
    assertex( isplayer( other ), "Tried to do a trigger_hint on a non player entity" );
    
    if ( isdefined( level.displayed_hints[ hint ] ) )
    {
        return;
    }
    
    level.displayed_hints[ hint ] = 1;
    other display_hint( hint );
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x3d8c
// Size: 0x2d
function trigger_delete_on_touch( trigger )
{
    for ( ;; )
    {
        trigger waittill( "trigger", other );
        
        if ( isdefined( other ) )
        {
            other delete();
        }
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x3dc1
// Size: 0x7d
function trigger_turns_off( trigger )
{
    trigger waittill( "trigger" );
    trigger trigger_off();
    
    if ( !isdefined( trigger.script_linkto ) )
    {
        return;
    }
    
    tokens = strtok( trigger.script_linkto, " " );
    
    for ( i = 0; i < tokens.size ; i++ )
    {
        array_thread( getentarray( tokens[ i ], "script_linkname" ), &trigger_off );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x3e46
// Size: 0x1e
function trigger_ignore( trigger )
{
    thread trigger_runs_function_on_touch( trigger, &set_ignoreme, &get_ignoreme );
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x3e6c
// Size: 0x1e
function trigger_pacifist( trigger )
{
    thread trigger_runs_function_on_touch( trigger, &set_pacifist, &get_pacifist );
}

// Namespace trigger / scripts\sp\trigger
// Params 3
// Checksum 0x0, Offset: 0x3e92
// Size: 0x52
function trigger_runs_function_on_touch( trigger, set_func, get_func )
{
    for ( ;; )
    {
        trigger waittill( "trigger", other );
        
        if ( !isalive( other ) )
        {
            continue;
        }
        
        if ( other [[ get_func ]]() )
        {
            continue;
        }
        
        other thread touched_trigger_runs_func( trigger, set_func );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 2
// Checksum 0x0, Offset: 0x3eec
// Size: 0x58
function touched_trigger_runs_func( trigger, set_func )
{
    self endon( "death" );
    self.ignoreme = 1;
    [[ set_func ]]( 1 );
    self.ignoretriggers = 1;
    wait 1;
    self.ignoretriggers = 0;
    
    while ( self istouching( trigger ) )
    {
        wait 1;
    }
    
    [[ set_func ]]( 0 );
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x3f4c
// Size: 0x25
function trigger_radio( trigger )
{
    trigger waittill( "trigger" );
    radio_dialogue( trigger.script_noteworthy );
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x3f79
// Size: 0x66
function trigger_flag_set_player( trigger )
{
    flag = trigger get_trigger_flag();
    
    if ( !isdefined( level.flag[ flag ] ) )
    {
        flag_init( flag );
    }
    
    for ( ;; )
    {
        trigger waittill( "trigger", other );
        
        if ( !isplayer( other ) )
        {
            continue;
        }
        
        trigger script_delay();
        flag_set( flag );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x3fe7
// Size: 0x19d
function trigger_multiple_depthoffield( trigger )
{
    waittillframeend();
    
    while ( true )
    {
        trigger waittill( "trigger", player );
        nearstart = trigger.script_dof_near_start;
        nearend = trigger.script_dof_near_end;
        nearblur = trigger.script_dof_near_blur;
        farstart = trigger.script_dof_far_start;
        farend = trigger.script_dof_far_end;
        farblur = trigger.script_dof_far_blur;
        time = trigger.script_delay;
        
        if ( nearstart != level.dof[ "base" ][ "goal" ][ "nearStart" ] || nearend != level.dof[ "base" ][ "goal" ][ "nearEnd" ] || nearblur != level.dof[ "base" ][ "goal" ][ "nearBlur" ] || farstart != level.dof[ "base" ][ "goal" ][ "farStart" ] || farend != level.dof[ "base" ][ "goal" ][ "farEnd" ] || farblur != level.dof[ "base" ][ "goal" ][ "farBlur" ] )
        {
            scripts\sp\art::dof_set_base( nearstart, nearend, nearblur, farstart, farend, farblur, time );
            wait time;
            continue;
        }
        
        waitframe();
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x418c
// Size: 0xd0
function trigger_multiple_tessellationcutoff( trigger )
{
    waittillframeend();
    
    while ( true )
    {
        trigger waittill( "trigger", player );
        cutoff_distance = trigger.script_tess_distance;
        cutoff_falloff = trigger.script_tess_falloff;
        time = trigger.script_delay;
        
        if ( cutoff_distance != level.tess.cutoff_distance_goal || cutoff_falloff != level.tess.cutoff_falloff_goal )
        {
            cutoff_distance = max( 0, cutoff_distance );
            cutoff_distance = min( 10000, cutoff_distance );
            cutoff_falloff = max( 0, cutoff_falloff );
            cutoff_falloff = min( 10000, cutoff_falloff );
            scripts\sp\art::tess_set_goal( cutoff_distance, cutoff_falloff, time );
            continue;
        }
        
        waitframe();
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x4264
// Size: 0x16d
function trigger_multiple_fx_volume( trigger )
{
    dummy = spawn( "script_origin", ( 0, 0, 0 ) );
    trigger.fx = [];
    
    foreach ( entfx in level.createfxent )
    {
        assign_fx_to_trigger( entfx, trigger, dummy );
    }
    
    dummy delete();
    
    if ( !isdefined( trigger.target ) )
    {
        return;
    }
    
    targets = getentarray( trigger.target, "targetname" );
    trigger.fx_on = 1;
    
    foreach ( target in targets )
    {
        switch ( target.classname )
        {
            case #"hash_3507493b67792336":
                target thread trigger_multiple_fx_trigger_on_think( trigger );
                break;
            case #"hash_f3b48883e3c60578":
                target thread trigger_multiple_fx_trigger_off_think( trigger );
                break;
            default:
                break;
        }
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x43d9
// Size: 0x43
function trigger_multiple_fx_trigger_on_think( volume )
{
    while ( true )
    {
        self waittill( "trigger" );
        
        if ( !volume.fx_on )
        {
            array_thread( volume.fx, &restarteffect );
        }
        
        wait 1;
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x4424
// Size: 0x43
function trigger_multiple_fx_trigger_off_think( volume )
{
    while ( true )
    {
        self waittill( "trigger" );
        
        if ( volume.fx_on )
        {
            array_thread( volume.fx, &pauseeffect );
        }
        
        wait 1;
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 3
// Checksum 0x0, Offset: 0x446f
// Size: 0xb8
function assign_fx_to_trigger( entfx, trigger, dummy )
{
    if ( isdefined( entfx.v[ "soundalias" ] ) && entfx.v[ "soundalias" ] != "nil" )
    {
        if ( !isdefined( entfx.v[ "stopable" ] ) || !entfx.v[ "stopable" ] )
        {
            return;
        }
    }
    
    dummy.origin = entfx.v[ "origin" ];
    
    if ( dummy istouching( trigger ) )
    {
        trigger.fx[ trigger.fx.size ] = entfx;
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x452f
// Size: 0x6d
function trigger_multiple_compass( trigger )
{
    minimap_image = trigger.script_parameters;
    assertex( isdefined( minimap_image ), "trigger_multiple_compass has no script_parameters for its minimap_image." );
    
    if ( !isdefined( level.minimap_image ) )
    {
        level.minimap_image = "";
    }
    
    for ( ;; )
    {
        trigger waittill( "trigger" );
        
        if ( level.minimap_image != minimap_image )
        {
            scripts\sp\compass::setupminimap( minimap_image );
        }
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x45a4
// Size: 0x21
function trigger_no_crouch_or_prone( trigger )
{
    array_thread( level.players, &no_crouch_or_prone_think_for_player, trigger );
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x45cd
// Size: 0x76
function no_crouch_or_prone_think_for_player( trigger )
{
    assert( isplayer( self ) );
    
    for ( ;; )
    {
        trigger waittill( "trigger", player );
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player != self )
        {
            continue;
        }
        
        while ( player istouching( trigger ) )
        {
            player allowprone( 0 );
            player allowcrouch( 0 );
            wait 0.05;
        }
        
        player allowprone( 1 );
        player allowcrouch( 1 );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x464b
// Size: 0x21
function trigger_no_prone( trigger )
{
    array_thread( level.players, &no_prone_for_player, trigger );
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x4674
// Size: 0x65
function no_prone_for_player( trigger )
{
    assert( isplayer( self ) );
    
    for ( ;; )
    {
        trigger waittill( "trigger", player );
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player != self )
        {
            continue;
        }
        
        while ( player istouching( trigger ) )
        {
            player allowprone( 0 );
            wait 0.05;
        }
        
        player allowprone( 1 );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x46e1
// Size: 0xb1
function exploder_load( trigger )
{
    level endon( "killexplodertridgers" + trigger.script_exploder );
    trigger waittill( "trigger" );
    
    if ( isdefined( trigger.script_chance ) && randomfloat( 1 ) > trigger.script_chance )
    {
        if ( !trigger script_delay() )
        {
            wait 4;
        }
        
        level thread exploder_load( trigger );
        return;
    }
    
    if ( !trigger script_delay() && isdefined( trigger.script_exploder_delay ) )
    {
        wait trigger.script_exploder_delay;
    }
    
    exploder( trigger.script_exploder );
    level notify( "killexplodertridgers" + trigger.script_exploder );
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x479a
// Size: 0x2f
function trigger_multiple_kleenex( trigger )
{
    if ( getdvarint( @"kleenex" ) != 1 )
    {
        return;
    }
    
    trigger waittill( "trigger" );
    kleenex_popup();
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x47d1
// Size: 0xbb
function trigger_stealth_shadow( trigger )
{
    trigger endon( "death" );
    the_flag = "stealth_in_shadow";
    
    if ( !isdefined( level.trigger_stealth_shadow ) )
    {
        level.trigger_stealth_shadow = [];
    }
    
    level.trigger_stealth_shadow[ level.trigger_stealth_shadow.size ] = trigger;
    registerstealthshadowtrigger( trigger );
    
    while ( true )
    {
        trigger waittill( "trigger", other );
        
        if ( !other ent_flag_exist( the_flag ) )
        {
            println( "<dev string:x181>" + the_flag + "<dev string:x184>" + other getentnum() + "<dev string:x1a4>" );
            continue;
        }
        
        if ( other ent_flag( the_flag ) )
        {
            continue;
        }
        
        other thread in_shadow_thread( trigger, the_flag );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 2
// Checksum 0x0, Offset: 0x4894
// Size: 0x43
function in_shadow_thread( volume, the_flag )
{
    self endon( "death" );
    scripts\stealth\player::function_e403865f115834a8( the_flag );
    
    while ( isdefined( volume ) && self istouching( volume ) )
    {
        wait 0.05;
    }
    
    scripts\stealth\player::function_3718fc282393305( the_flag );
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x48df
// Size: 0x2ab
function trigger_fire( trigger )
{
    trigger endon( "death" );
    
    if ( isdefined( trigger.trigger_fire_endon ) )
    {
        trigger endon( trigger.trigger_fire_endon );
    }
    
    default_damage = 1;
    dam_multiplier = 5;
    final_damage = 0;
    
    if ( !isdefined( trigger.script_delay_min ) && !isdefined( trigger.script_delay_max ) )
    {
        trigger.script_delay_min = 0.05;
        trigger.script_delay_max = 0.05;
    }
    
    if ( trigger.script_delay_min == trigger.script_delay_max )
    {
        trigger.script_delay = trigger.script_delay_min;
    }
    
    if ( isdefined( trigger.script_damage ) )
    {
        default_damage = trigger.script_damage;
    }
    
    while ( true )
    {
        trigger waittill( "trigger", victim );
        center_point = trigger.origin;
        
        if ( isplayer( victim ) )
        {
            final_damage = default_damage;
            
            if ( trigger.classname == "trigger_radius_fire" )
            {
                if ( isdefined( trigger.script_radius ) )
                {
                    if ( distance2dsquared( victim.origin, trigger.origin ) <= squared( trigger.script_radius ) )
                    {
                        if ( isdefined( trigger.script_multiplier ) && isnumber( trigger.script_multiplier ) )
                        {
                            dam_multiplier = trigger.script_multiplier;
                        }
                        
                        final_damage *= dam_multiplier;
                    }
                }
            }
            else if ( isdefined( trigger.target ) )
            {
                struct = getstruct( trigger.target, "targetname" );
                center_point = struct.origin;
                
                if ( isdefined( struct.script_radius ) )
                {
                    if ( distance2dsquared( victim.origin, struct.origin ) <= squared( struct.script_radius ) )
                    {
                        if ( isdefined( trigger.script_multiplier ) && isnumber( trigger.script_multiplier ) )
                        {
                            dam_multiplier = trigger.script_multiplier;
                        }
                        
                        final_damage *= dam_multiplier;
                    }
                }
            }
        }
        
        if ( istrue( victim.damageshield ) )
        {
            continue;
        }
        
        victim do_damage( final_damage, center_point, undefined, undefined, "MOD_FIRE" );
        
        if ( final_damage < 6 )
        {
            victim playrumbleonentity( "damage_light" );
        }
        else
        {
            victim playrumbleonentity( "damage_heavy" );
        }
        
        trigger script_delay();
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 1
// Checksum 0x0, Offset: 0x4b92
// Size: 0xd5
function trigger_multiple_fx( trigger )
{
    if ( trigger.classname == "trigger_multiple_fx_on" )
    {
        bool = &scripts\common\fx::struct_fx_inactive;
        func = &scripts\common\fx::play_struct_fx;
    }
    else
    {
        bool = &scripts\common\fx::struct_fx_active;
        func = &scripts\common\fx::stop_struct_fx;
    }
    
    while ( true )
    {
        trigger waittill( "trigger" );
        
        foreach ( struct in level.struct_fx )
        {
            if ( [[ bool ]]( struct ) && is_equal( struct.script_fxgroup, trigger.script_fxgroup ) )
            {
                [[ func ]]( struct );
            }
        }
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 2
// Checksum 0x0, Offset: 0x4c6f
// Size: 0x1f7
function trigger_outofbounds( trigger, var_aa6a5ebd98bc3b10 )
{
    trigger.failtrigger = getent( trigger.target, "targetname" );
    trigger endon( "death" );
    var_56c37e91e8b85f4d = trigger.spawnflags & 16;
    var_3f697146599a80c4 = function_6cd0a8e23ff14e13( "scripted_widget_out_of_bounds" );
    
    while ( true )
    {
        trigger waittill( "trigger", other );
        trigger.failtrigger childthread outofbounds_failthread();
        setomnvar( "ui_out_of_bounds_countdown", 1 );
        
        if ( isdefined( var_3f697146599a80c4 ) )
        {
            if ( !level.player function_ada0825249682644( "scripted_widget_out_of_bounds" ) )
            {
                level.player function_90de31b2cbef19f9( "scripted_widget_out_of_bounds", var_3f697146599a80c4 );
                level.player function_f4c37324750dc183( "scripted_widget_out_of_bounds", 0, -190, 1, 1 );
                level.player function_af4f62f0f944a8f1( "scripted_widget_out_of_bounds", "ReturnToMission" );
            }
            
            fields = [];
            
            if ( isdefined( var_aa6a5ebd98bc3b10 ) )
            {
                fields[ "msg_index" ] = getlocstringindex( var_aa6a5ebd98bc3b10 );
            }
            
            fields[ "countdown" ] = 1;
            level.player function_14a0ee2aaf9128c3( "scripted_widget_out_of_bounds", fields, 1 );
        }
        
        if ( var_56c37e91e8b85f4d && isdefined( other.driver ) && other.driver == level.player )
        {
            ent = other;
        }
        else
        {
            ent = level.player;
        }
        
        while ( ent istouching( trigger ) )
        {
            waitframe();
        }
        
        if ( isdefined( var_3f697146599a80c4 ) && level.player function_a0ae4b54aa48ade2( var_3f697146599a80c4 ) )
        {
            level.player function_d28fa5295a04d555( "scripted_widget_out_of_bounds", "hide" );
        }
        
        setomnvar( "ui_out_of_bounds_countdown", 0 );
        trigger.failtrigger notify( "stop_failthread" );
    }
}

// Namespace trigger / scripts\sp\trigger
// Params 0
// Checksum 0x0, Offset: 0x4e6e
// Size: 0x49
function outofbounds_failthread()
{
    self endon( "death" );
    self endon( "stop_failthread" );
    self waittill( "trigger" );
    level.player scripted_widget_destroy( "scripted_widget_out_of_bounds" );
    setomnvar( "ui_out_of_bounds_countdown", 0 );
    scripts\sp\player_death::set_custom_death_quote( 29 );
    missionfailedwrapper();
}

