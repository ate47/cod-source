#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\movers;
#using scripts\mp\utility\damage;
#using scripts\mp\weapons;

#namespace movers;

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x59e
// Size: 0x14d
function main()
{
    if ( getdvar( @"hash_e6afce2cf5cf7515" ) == "1" )
    {
        return;
    }
    
    level.script_mover_defaults = [];
    level.script_mover_defaults[ "move_time" ] = 5;
    level.script_mover_defaults[ "accel_time" ] = 0;
    level.script_mover_defaults[ "decel_time" ] = 0;
    level.script_mover_defaults[ "wait_time" ] = 0;
    level.script_mover_defaults[ "delay_time" ] = 0;
    level.script_mover_defaults[ "usable" ] = 0;
    level.script_mover_defaults[ "hintstring" ] = "activate";
    script_mover_add_hintstring( "activate", &"MP/ACTIVATE_MOVER" );
    script_mover_add_parameters( "none", "" );
    level.script_mover_named_goals = [];
    waitframe();
    movers = [];
    classnames = script_mover_classnames();
    
    foreach ( class in classnames )
    {
        movers = array_combine( movers, getentarray( class, "classname" ) );
    }
    
    array_thread( movers, &script_mover_int );
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x6f3
// Size: 0x15
function script_mover_classnames()
{
    return [ "script_model_mover", "script_brushmodel_mover" ];
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x711
// Size: 0x8a
function script_mover_is_script_mover()
{
    if ( isdefined( self.script_mover ) )
    {
        return self.script_mover;
    }
    
    classnames = script_mover_classnames();
    
    foreach ( class in classnames )
    {
        if ( self.classname == class )
        {
            self.script_mover = 1;
            return 1;
        }
    }
    
    return 0;
}

// Namespace movers / scripts\mp\movers
// Params 2
// Checksum 0x0, Offset: 0x7a4
// Size: 0x37
function script_mover_add_hintstring( name, hintstring )
{
    if ( !isdefined( level.script_mover_hintstrings ) )
    {
        level.script_mover_hintstrings = [];
    }
    
    level.script_mover_hintstrings[ name ] = hintstring;
}

// Namespace movers / scripts\mp\movers
// Params 2
// Checksum 0x0, Offset: 0x7e3
// Size: 0x37
function script_mover_add_parameters( name, parameters )
{
    if ( !isdefined( level.script_mover_parameters ) )
    {
        level.script_mover_parameters = [];
    }
    
    level.script_mover_parameters[ name ] = parameters;
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x822
// Size: 0x2ff
function script_mover_int()
{
    if ( !isdefined( self.target ) )
    {
        return;
    }
    
    self.script_mover = 1;
    self.moving = 0;
    self.origin_ent = self;
    self.use_triggers = [];
    self.linked_ents = [];
    structs = getstructarray( self.target, "targetname" );
    
    foreach ( target in structs )
    {
        if ( !isdefined( target.script_noteworthy ) )
        {
            continue;
        }
        
        switch ( target.script_noteworthy )
        {
            case #"hash_6479a60057df5aaf":
                if ( !isdefined( target.angles ) )
                {
                    target.angles = ( 0, 0, 0 );
                }
                
                self.origin_ent = spawn( "script_model", target.origin );
                self.origin_ent.angles = target.angles;
                self.origin_ent setmodel( "tag_origin" );
                self.origin_ent linkto( self );
                break;
            default:
                break;
        }
    }
    
    ents = getentarray( self.target, "targetname" );
    
    foreach ( target in ents )
    {
        if ( !isdefined( target.script_noteworthy ) )
        {
            continue;
        }
        
        switch ( target.script_noteworthy )
        {
            case #"hash_66b78ac7e1f6f148":
                target enablelinkto();
                target linkto( self );
            case #"hash_cbaf3545ee235037":
                target script_mover_parse_targets();
                thread script_mover_use_trigger( target );
                self.use_triggers[ self.use_triggers.size ] = target;
                break;
            case #"hash_6fb23e39e833ccc9":
                target linkto( self );
                self.linked_ents[ self.linked_ents.size ] = target;
                break;
            default:
                break;
        }
    }
    
    thread script_mover_parse_targets();
    thread script_mover_init_move_parameters();
    thread script_mover_save_default_move_parameters();
    thread script_mover_apply_move_parameters( self );
    thread script_mover_move_to_target();
    
    foreach ( trigger in self.use_triggers )
    {
        script_mover_set_usable( trigger, 1 );
    }
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0xb29
// Size: 0x4f
function script_mover_use_trigger( trigger )
{
    self endon( "death" );
    
    while ( true )
    {
        trigger waittill( "trigger" );
        
        if ( trigger.goals.size > 0 )
        {
            self notify( "new_path" );
            thread script_mover_move_to_target( trigger );
            continue;
        }
        
        self notify( "trigger" );
    }
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0xb80
// Size: 0x43
function script_mover_move_to_named_goal( goal_name )
{
    if ( isdefined( level.script_mover_named_goals[ goal_name ] ) )
    {
        self notify( "new_path" );
        self.goals = [ level.script_mover_named_goals[ goal_name ] ];
        thread script_mover_move_to_target();
    }
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0xbcb
// Size: 0x26
function anglesclamp180( angles )
{
    return ( angleclamp180( angles[ 0 ] ), angleclamp180( angles[ 1 ] ), angleclamp180( angles[ 2 ] ) );
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0xbfa
// Size: 0x3b9
function script_mover_parse_targets()
{
    if ( isdefined( self.parsed ) && self.parsed )
    {
        return;
    }
    
    self.parsed = 1;
    self.goals = [];
    self.movers = [];
    self.level_notify = [];
    structs = [];
    ents = [];
    
    if ( isdefined( self.target ) )
    {
        structs = getstructarray( self.target, "targetname" );
        ents = getentarray( self.target, "targetname" );
    }
    
    for ( i = 0; i < structs.size ; i++ )
    {
        target = structs[ i ];
        
        if ( !isdefined( target.script_noteworthy ) )
        {
            target.script_noteworthy = "goal";
        }
        
        switch ( target.script_noteworthy )
        {
            case #"hash_f4a879c6a099e6a3":
                if ( isdefined( target.target ) )
                {
                    add_structs = getstructarray( target.target, "targetname" );
                    
                    foreach ( add in add_structs )
                    {
                        structs[ structs.size ] = add;
                    }
                }
                
                break;
            case #"hash_8d43150f19c69bd6":
                target script_mover_init_move_parameters();
                target script_mover_parse_targets();
                self.goals[ self.goals.size ] = target;
                
                if ( isdefined( target.params[ "name" ] ) )
                {
                    level.script_mover_named_goals[ target.params[ "name" ] ] = target;
                }
                
                break;
            case #"hash_9d36212eda6f7813":
                if ( isdefined( target.script_parameters ) )
                {
                    self.level_notify[ self.level_notify.size ] = target;
                }
                
                break;
            default:
                break;
        }
    }
    
    foreach ( ent in ents )
    {
        if ( ent script_mover_is_script_mover() )
        {
            self.movers[ self.movers.size ] = ent;
            continue;
        }
        
        if ( !isdefined( ent.script_noteworthy ) )
        {
            continue;
        }
        
        toks = strtok( ent.script_noteworthy, "_" );
        
        if ( toks.size != 3 || toks[ 1 ] != "on" )
        {
            continue;
        }
        
        switch ( toks[ 0 ] )
        {
            case #"hash_897c0184865c23aa":
                thread script_mover_call_func_on_notify( ent, &delete, toks[ 2 ] );
                break;
            case #"hash_7ebb454a971d80d":
                thread script_mover_call_func_on_notify( ent, &hide, toks[ 2 ] );
                break;
            case #"hash_ca51c18a00a0a89c":
                ent hide();
                thread script_mover_call_func_on_notify( ent, &show, toks[ 2 ] );
                break;
            case #"hash_6fc6a816bd9d0753":
            case #"hash_a604a8dc3d70bb33":
                thread script_mover_func_on_notify( ent, &trigger_off, toks[ 2 ] );
                break;
            case #"hash_59c0513670a01816":
            case #"hash_8cd851fbedf962f6":
                ent trigger_off();
                thread script_mover_func_on_notify( ent, &trigger_on, toks[ 2 ] );
                break;
            default:
                break;
        }
    }
}

// Namespace movers / scripts\mp\movers
// Params 3
// Checksum 0x0, Offset: 0xfbb
// Size: 0x3a
function script_mover_func_on_notify( ent, func, note )
{
    self endon( "death" );
    ent endon( "death" );
    
    while ( true )
    {
        self waittill( note );
        ent [[ func ]]();
    }
}

// Namespace movers / scripts\mp\movers
// Params 3
// Checksum 0x0, Offset: 0xffd
// Size: 0x3b
function script_mover_call_func_on_notify( ent, func, note )
{
    self endon( "death" );
    ent endon( "death" );
    
    while ( true )
    {
        self waittill( note );
        ent builtin [[ func ]]();
    }
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x1040
// Size: 0x9
function script_mover_trigger_on()
{
    trigger_on();
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x1051
// Size: 0x521
function script_mover_move_to_target( current )
{
    self endon( "death" );
    self endon( "new_path" );
    
    if ( !isdefined( current ) )
    {
    }
    
    for ( current = self; current.goals.size != 0 ; current = goal )
    {
        goal = random( current.goals );
        mover = self;
        mover script_mover_apply_move_parameters( goal );
        
        if ( isdefined( mover.params[ "delay_till" ] ) )
        {
            level waittill( mover.params[ "delay_till" ] );
        }
        
        if ( isdefined( mover.params[ "delay_till_trigger" ] ) && mover.params[ "delay_till_trigger" ] )
        {
            self waittill( "trigger" );
        }
        
        if ( mover.params[ "delay_time" ] > 0 )
        {
            wait mover.params[ "delay_time" ];
        }
        
        move_time = mover.params[ "move_time" ];
        accel_time = mover.params[ "accel_time" ];
        decel_time = mover.params[ "decel_time" ];
        is_moveto = 0;
        is_rotateto = 0;
        trans = transformmove( goal.origin, goal.angles, self.origin_ent.origin, self.origin_ent.angles, self.origin, self.angles );
        
        if ( mover.origin != goal.origin )
        {
            if ( isdefined( mover.params[ "move_speed" ] ) )
            {
                dist = distance( mover.origin, goal.origin );
                move_time = dist / mover.params[ "move_speed" ];
            }
            
            if ( isdefined( mover.params[ "accel_frac" ] ) )
            {
                accel_time = mover.params[ "accel_frac" ] * move_time;
            }
            
            if ( isdefined( mover.params[ "decel_frac" ] ) )
            {
                decel_time = mover.params[ "decel_frac" ] * move_time;
            }
            
            mover moveto( trans[ "origin" ], move_time, accel_time, decel_time );
            
            foreach ( note in goal.level_notify )
            {
                thread script_mover_run_notify( note.origin, note.script_parameters, self.origin, goal.origin );
            }
            
            is_moveto = 1;
        }
        
        if ( anglesclamp180( trans[ "angles" ] ) != anglesclamp180( mover.angles ) )
        {
            mover rotateto( trans[ "angles" ], move_time, accel_time, decel_time );
            is_rotateto = 1;
        }
        
        foreach ( targeted_mover in mover.movers )
        {
            targeted_mover notify( "trigger" );
        }
        
        current notify( "depart" );
        mover script_mover_allow_usable( 0 );
        self.moving = 1;
        
        if ( isdefined( mover.params[ "move_time_offset" ] ) && mover.params[ "move_time_offset" ] + move_time > 0 )
        {
            wait mover.params[ "move_time_offset" ] + move_time;
        }
        else if ( is_moveto )
        {
            self waittill( "movedone" );
        }
        else if ( is_rotateto )
        {
            self waittill( "rotatedone" );
        }
        else
        {
            wait move_time;
        }
        
        self.moving = 0;
        self notify( "move_end" );
        goal notify( "arrive" );
        
        if ( isdefined( mover.params[ "solid" ] ) )
        {
            if ( mover.params[ "solid" ] )
            {
                mover solid();
            }
            else
            {
                mover notsolid();
            }
        }
        
        foreach ( targeted_mover in goal.movers )
        {
            targeted_mover notify( "trigger" );
        }
        
        if ( isdefined( mover.params[ "wait_till" ] ) )
        {
            level waittill( mover.params[ "wait_till" ] );
        }
        
        if ( mover.params[ "wait_time" ] > 0 )
        {
            wait mover.params[ "wait_time" ];
        }
        
        mover script_mover_allow_usable( 1 );
    }
}

// Namespace movers / scripts\mp\movers
// Params 4
// Checksum 0x0, Offset: 0x157a
// Size: 0x87
function script_mover_run_notify( notify_origin, level_notify, start, end )
{
    self endon( "move_end" );
    mover = self;
    move_dir = vectornormalize( end - start );
    
    while ( true )
    {
        notify_dir = vectornormalize( notify_origin - mover.origin );
        
        if ( vectordot( move_dir, notify_dir ) <= 0 )
        {
            break;
        }
        
        wait 0.05;
    }
    
    level notify( level_notify );
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x1609
// Size: 0x57
function script_mover_init_move_parameters()
{
    self.params = [];
    
    if ( !isdefined( self.angles ) )
    {
        self.angles = ( 0, 0, 0 );
    }
    
    self.angles = anglesclamp180( self.angles );
    script_mover_parse_move_parameters( self.script_parameters );
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x1668
// Size: 0x221
function script_mover_parse_move_parameters( parameters )
{
    if ( !isdefined( parameters ) )
    {
        parameters = "";
    }
    
    params = strtok( parameters, ";" );
    
    foreach ( param in params )
    {
        toks = strtok( param, "=" );
        
        if ( toks.size != 2 )
        {
            continue;
        }
        
        if ( toks[ 1 ] == "undefined" || toks[ 1 ] == "default" )
        {
            self.params[ toks[ 0 ] ] = undefined;
            continue;
        }
        
        switch ( toks[ 0 ] )
        {
            case #"hash_2b74fd1351aa7a2c":
            case #"hash_3c39a00c7c7d0dc4":
            case #"hash_785811f02a52ccba":
            case #"hash_7b12226936aa30c5":
            case #"hash_7ce5e6f06cb19f77":
            case #"hash_85409ed1316ad84c":
            case #"hash_9a32d25bf1504c7e":
            case #"hash_cbf4d1a793ce27c8":
            case #"hash_ee220acc1acae64c":
                self.params[ toks[ 0 ] ] = script_mover_parse_range( toks[ 1 ] );
                break;
            case #"hash_3c36bb0c7c7af9ae":
            case #"hash_738c50493c45cf46":
            case #"hash_853da9d13168ab06":
            case #"hash_dde06d8e15af50a1":
                self.params[ toks[ 0 ] ] = toks[ 1 ];
                break;
            case #"hash_5277b19543577b0d":
            case #"hash_6cf0fecd49dc6429":
            case #"hash_b669df4fb84dddd4":
                self.params[ toks[ 0 ] ] = int( toks[ 1 ] );
                break;
            case #"hash_7eb55b2a3a2f02dd":
                param_name = toks[ 1 ];
                additional_params = level.script_mover_parameters[ param_name ];
                
                if ( isdefined( additional_params ) )
                {
                    script_mover_parse_move_parameters( additional_params );
                }
                
                break;
            default:
                break;
        }
    }
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x1891
// Size: 0x85
function script_mover_parse_range( str )
{
    value = 0;
    toks = strtok( str, "," );
    
    if ( toks.size == 1 )
    {
        value = float( toks[ 0 ] );
    }
    else if ( toks.size == 2 )
    {
        minvalue = float( toks[ 0 ] );
        maxvalue = float( toks[ 1 ] );
        
        if ( minvalue >= maxvalue )
        {
            value = minvalue;
        }
        else
        {
            value = randomfloatrange( minvalue, maxvalue );
        }
    }
    
    return value;
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x191f
// Size: 0x69
function script_mover_apply_move_parameters( from )
{
    foreach ( key, value in from.params )
    {
        script_mover_set_param( key, value );
    }
    
    script_mover_set_defaults();
}

// Namespace movers / scripts\mp\movers
// Params 2
// Checksum 0x0, Offset: 0x1990
// Size: 0x3f
function script_mover_set_param( param_name, value )
{
    if ( !isdefined( param_name ) )
    {
        return;
    }
    
    if ( param_name == "usable" && isdefined( value ) )
    {
        script_mover_set_usable( self, value );
    }
    
    self.params[ param_name ] = value;
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x19d7
// Size: 0x7b
function script_mover_allow_usable( usable )
{
    if ( self.params[ "usable" ] )
    {
        script_mover_set_usable( self, usable );
    }
    
    foreach ( trigger in self.use_triggers )
    {
        script_mover_set_usable( trigger, usable );
    }
}

// Namespace movers / scripts\mp\movers
// Params 2
// Checksum 0x0, Offset: 0x1a5a
// Size: 0x54
function script_mover_set_usable( use_ent, usable )
{
    if ( usable )
    {
        use_ent makeusable();
        use_ent setcursorhint( "HINT_NOICON" );
        use_ent sethintstring( level.script_mover_hintstrings[ self.params[ "hintstring" ] ] );
        return;
    }
    
    use_ent makeunusable();
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x1ab6
// Size: 0x65
function script_mover_save_default_move_parameters()
{
    self.params_default = [];
    
    foreach ( key, value in self.params )
    {
        self.params_default[ key ] = value;
    }
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x1b23
// Size: 0xc5
function script_mover_set_defaults()
{
    foreach ( key, value in level.script_mover_defaults )
    {
        if ( !isdefined( self.params[ key ] ) )
        {
            script_mover_set_param( key, value );
        }
    }
    
    if ( isdefined( self.params_default ) )
    {
        foreach ( key, value in self.params_default )
        {
            if ( !isdefined( self.params[ key ] ) )
            {
                script_mover_set_param( key, value );
            }
        }
    }
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x1bf0
// Size: 0x14
function init()
{
    level thread script_mover_connect_watch();
    level thread script_mover_agent_spawn_watch();
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x1c0c
// Size: 0x27
function script_mover_connect_watch()
{
    while ( true )
    {
        level waittill( "connected", player );
        player thread player_unresolved_collision_watch();
    }
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x1c3b
// Size: 0x27
function script_mover_agent_spawn_watch()
{
    while ( true )
    {
        level waittill( "spawned_agent", agent );
        agent thread player_unresolved_collision_watch();
    }
}

// Namespace movers / scripts\mp\movers
// Params 2
// Checksum 0x0, Offset: 0x1c6a
// Size: 0x1db
function player_update_unresolved_collision( mover, penetration )
{
    self.unresolved_collision_count++;
    thread clear_unresolved_collision_count_next_frame();
    unresolved_collision_notify_min = 3;
    
    if ( isdefined( mover ) && isdefined( mover.unresolved_collision_notify_min ) )
    {
        unresolved_collision_notify_min = mover.unresolved_collision_notify_min;
    }
    
    if ( self.unresolved_collision_count >= unresolved_collision_notify_min )
    {
        if ( isdefined( mover ) )
        {
            if ( isdefined( mover.unresolved_collision_func ) )
            {
                mover [[ mover.unresolved_collision_func ]]( self, penetration );
            }
            else if ( isdefined( mover.unresolved_collision_kill ) && mover.unresolved_collision_kill )
            {
                mover unresolved_collision_owner_damage( self );
            }
            else
            {
                var_4c9e50755168f1eb = isdefined( self.lastascenderusetime ) && gettime() - self.lastascenderusetime <= 250;
                
                if ( var_4c9e50755168f1eb || mover scripts\cp_mp\vehicles\vehicle::isvehicle() && !scripts\cp_mp\vehicles\vehicle::vehicle_docollisiondamagetoplayer( mover, self ) )
                {
                    mover unresolved_collision_nearest_node( self, 0, mover, 0 );
                }
                else
                {
                    allowsuicide = player_should_be_killed_by_mover( mover );
                    mover unresolved_collision_nearest_node( self, allowsuicide, mover, 0 );
                }
            }
        }
        else
        {
            allowsuicide = player_should_be_killed_by_mover( mover );
            unresolved_collision_nearest_node( self, allowsuicide, undefined, 0 );
        }
        
        self.unresolved_collision_count = 0;
        return;
    }
    
    if ( self.unresolved_collision_count == 1 )
    {
        if ( isplayer( self ) && isdefined( mover ) )
        {
            radius = getdvarint( @"scr_unresolved_collision_door_check_radius", 1000 );
            nearestdoor = function_65eef2622bd403cf( self.origin, radius );
            
            if ( isdefined( nearestdoor ) && nearestdoor isscriptableinstance() )
            {
                allowsuicide = player_should_be_killed_by_mover( mover );
                mover unresolved_collision_nearest_node( self, allowsuicide, mover, 1 );
                self.unresolved_collision_count = 0;
            }
        }
    }
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x1e4d
// Size: 0x24, Type: bool
function player_should_be_killed_by_mover( mover )
{
    if ( isdefined( mover ) && istrue( mover.moverdoesnotkill ) )
    {
        return false;
    }
    
    return true;
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x1e7a
// Size: 0x62
function player_unresolved_collision_watch()
{
    if ( isagent( self ) )
    {
        self endon( "death_or_disconnect" );
    }
    else
    {
        self endon( "disconnect" );
    }
    
    self.unresolved_collision_count = 0;
    
    while ( true )
    {
        self waittill( "unresolved_collision", mover, penetration );
        
        if ( player_ignore_mover( mover ) )
        {
            continue;
        }
        
        player_update_unresolved_collision( mover, penetration );
    }
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x1ee4
// Size: 0x7a
function player_ignore_mover( mover )
{
    ignoremover = 0;
    
    if ( isdefined( mover.streakinfo ) && mover.streakinfo.streakname == "cruise_predator" )
    {
        ignoremover = 1;
    }
    
    if ( isdefined( mover.carriabletype ) )
    {
        ignoremover = 1;
    }
    
    if ( isplayer( self ) && !scripts\common\values::get( "unresolved_collisions" ) )
    {
        ignoremover = 1;
    }
    
    return ignoremover;
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x1f67
// Size: 0x19
function clear_unresolved_collision_count_next_frame()
{
    self endon( "unresolved_collision" );
    waitframe();
    
    if ( isdefined( self ) )
    {
        self.unresolved_collision_count = 0;
    }
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x1f88
// Size: 0xfa
function unresolved_collision_owner_damage( player )
{
    inflictor = self;
    
    if ( !isdefined( inflictor.owner ) )
    {
        player scripts\mp\movers::mover_suicide();
        return;
    }
    
    var_136d9d8040cc1eac = 0;
    
    if ( level.teambased )
    {
        if ( isdefined( inflictor.owner.team ) && inflictor.owner.team != player.team )
        {
            var_136d9d8040cc1eac = 1;
        }
    }
    else if ( player != inflictor.owner )
    {
        var_136d9d8040cc1eac = 1;
    }
    
    if ( !var_136d9d8040cc1eac )
    {
        player scripts\mp\movers::mover_suicide();
        return;
    }
    
    damage_ammount = 1000;
    
    if ( isdefined( inflictor.unresolved_collision_damage ) )
    {
        damage_ammount = inflictor.unresolved_collision_damage;
    }
    
    player dodamage( damage_ammount, inflictor.origin, inflictor.owner, inflictor, "MOD_CRUSH" );
}

// Namespace movers / scripts\mp\movers
// Params 4
// Checksum 0x0, Offset: 0x208a
// Size: 0x45b
function unresolved_collision_nearest_node( player, var_4258fb168fb20ba6, mover, var_8f2da01924d0ae97 )
{
    if ( isdefined( level.override_unresolved_collision ) )
    {
        self [[ level.override_unresolved_collision ]]( player, istrue( var_4258fb168fb20ba6 ) );
        return;
    }
    
    if ( isdefined( mover ) && isdefined( mover.override_unresolved_collision ) )
    {
        self [[ mover.override_unresolved_collision ]]( player, istrue( var_4258fb168fb20ba6 ) );
        return;
    }
    
    if ( isdefined( mover ) )
    {
        if ( isdefined( mover.elevator ) )
        {
            if ( player scripts\common\elevators::isinsideelevator( mover ) )
            {
                return;
            }
        }
        
        if ( isdefined( mover.cover ) )
        {
            if ( player ishanging() )
            {
                player clearhanging();
            }
        }
        
        if ( scripts\cp_mp\utility\game_utility::islargemap() || istrue( var_8f2da01924d0ae97 ) )
        {
            if ( mover scripts\cp_mp\vehicles\vehicle::isvehicle() )
            {
                if ( mover scripts\cp_mp\vehicles\vehicle_occupancy::function_a24042975031e692() )
                {
                    [ exitposition, exitdirection ] = scripts\cp_mp\vehicles\vehicle_occupancy::function_9d86fd9a89cd2702( player, mover, player.origin );
                }
                else
                {
                    exitposition = scripts\cp_mp\vehicles\vehicle_occupancy::function_ca069b5427d4ff47( mover, player );
                    exitdirection = undefined;
                }
                
                if ( isdefined( exitposition ) )
                {
                    if ( isdefined( exitdirection ) && ( exitdirection == "inside" || exitdirection == "top" ) )
                    {
                        player function_a055801da45d769( exitposition, mover );
                        return;
                    }
                    
                    player setorigin( exitposition );
                    return;
                }
                else
                {
                    scripts\cp_mp\vehicles\vehicle::vehicle_docollisiondamagetoplayer( mover, player, 1 );
                    return;
                }
            }
            else if ( scripts\mp\weapons::isplantedequipment( mover ) )
            {
                mover scripts\mp\weapons::deleteexplosive();
                return;
            }
            else if ( isdefined( mover.cover ) )
            {
                mover.cover scripts\mp\equipment\tactical_cover::tac_cover_destroy( undefined, 0 );
                return;
            }
            else if ( isdefined( level.var_9e34d99a98d2ff67 ) && [[ level.var_9e34d99a98d2ff67 ]]( player, mover ) )
            {
                return;
            }
        }
        else
        {
            nodes = self.unresolved_collision_nodes;
            nearestnode = undefined;
            
            if ( isdefined( nodes ) )
            {
                nodes = sortbydistance( nodes, player.origin );
            }
            else
            {
                nodes = getnodesinradiussorted( player.origin, 500, 0, 128, "path" );
            }
            
            var_cd2c014424008317 = ( 0, 0, -100 );
            player cancelmantle();
            player dontinterpolate();
            moverents = get_mover_ents( mover );
            ignoredcharacters = level.characters;
            
            if ( isdefined( level.var_4d6759431590af80 ) )
            {
                ignoredcharacters = [[ level.var_4d6759431590af80 ]]( player );
            }
            
            ignorelist = array_combine( moverents, ignoredcharacters );
            
            /#
                if ( ignorelist.size > 128 )
                {
                    assertmsg( "<dev string:x1c>" + moverents.size + "<dev string:x65>" + ignoredcharacters.size );
                }
            #/
            
            ignorelist = get_array_of_closest( player.origin, ignorelist, undefined, 128 );
            
            for ( i = 0; i < nodes.size ; i++ )
            {
                if ( i == 3 )
                {
                    break;
                }
                
                check_node = nodes[ i ];
                org = check_node.origin + ( 0, 0, 10 );
                contents = scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 1 );
                trace = scripts\engine\trace::ray_trace( player gettagorigin( "tag_eye" ), org, ignorelist, contents );
                
                if ( isdefined( trace[ "hittype" ] ) && trace[ "hittype" ] != "hittype_none" )
                {
                    continue;
                }
                
                if ( !canspawn( org ) )
                {
                    continue;
                }
                
                if ( positionwouldtelefrag( org ) )
                {
                    continue;
                }
                
                if ( player getstance() == "prone" )
                {
                    player setstance( "crouch" );
                }
                
                player setorigin( org );
                return;
            }
        }
    }
    
    if ( istrue( mover.var_428aae905d2786a7 ) && isdefined( mover.owner ) )
    {
        player kill( mover.origin, mover.owner, mover, "MOD_CRUSH" );
        return;
    }
    
    if ( !isdefined( var_4258fb168fb20ba6 ) )
    {
        var_4258fb168fb20ba6 = 1;
    }
    
    if ( var_4258fb168fb20ba6 )
    {
        if ( !getdvarint( @"hash_60159c88e0599409", 1 ) && istrue( mover.var_2ee93f095dc416f8 ) )
        {
            return;
        }
        
        player mover_suicide();
    }
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x24ed
// Size: 0x9c
function get_mover_ents( mover )
{
    moverents = [];
    moverents[ moverents.size ] = mover;
    parent = mover getlinkedparent();
    children = mover getlinkedchildren( 1 );
    
    if ( isdefined( parent ) )
    {
        moverents[ moverents.size ] = parent;
    }
    
    if ( isdefined( children ) )
    {
        foreach ( child in children )
        {
            moverents[ moverents.size ] = child;
        }
    }
    
    return moverents;
}

// Namespace movers / scripts\mp\movers
// Params 2
// Checksum 0x0, Offset: 0x2592
// Size: 0x13
function unresolved_collision_void( player, penetration )
{
    
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x25ad
// Size: 0x9
function mover_suicide()
{
    _suicide();
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x25be
// Size: 0x70
function player_pushed_kill( min_mph )
{
    self endon( "death" );
    self endon( "stop_player_pushed_kill" );
    
    while ( true )
    {
        self waittill( "player_pushed", player, platformmph );
        
        if ( isplayer( player ) || isagent( player ) )
        {
            mph = length( platformmph );
            
            if ( mph >= min_mph )
            {
                unresolved_collision_owner_damage( player );
            }
        }
    }
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x2636
// Size: 0xa
function stop_player_pushed_kill()
{
    self notify( "stop_player_pushed_kill" );
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x2648
// Size: 0x33
function script_mover_get_top_parent()
{
    topparent = self getlinkedparent();
    
    for ( parent = topparent; isdefined( parent ) ; parent = parent getlinkedparent() )
    {
        topparent = parent;
    }
    
    return topparent;
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x2684
// Size: 0xa5
function script_mover_start_use( useent )
{
    useparent = useent script_mover_get_top_parent();
    
    if ( isdefined( useparent ) )
    {
        useparent.startuseorigin = useparent.origin;
    }
    
    self.startusemover = self getmovingplatformparent();
    
    if ( isdefined( self.startusemover ) )
    {
        topparent = self.startusemover script_mover_get_top_parent();
        
        if ( isdefined( topparent ) )
        {
            self.startusemover = topparent;
        }
        
        self.startusemover.startuseorigin = self.startusemover.origin;
    }
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x2731
// Size: 0x34, Type: bool
function script_mover_has_parent_moved( parent )
{
    if ( !isdefined( parent ) )
    {
        return false;
    }
    
    return lengthsquared( parent.origin - parent.startuseorigin ) > 0.001;
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x276e
// Size: 0x82, Type: bool
function script_mover_use_can_link( ent )
{
    if ( !isplayer( self ) )
    {
        return true;
    }
    
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    topparent = ent script_mover_get_top_parent();
    playerparent = self.startusemover;
    
    if ( !isdefined( topparent ) && !isdefined( playerparent ) )
    {
        return true;
    }
    
    if ( isdefined( topparent ) && isdefined( playerparent ) && topparent == playerparent )
    {
        return true;
    }
    
    if ( script_mover_has_parent_moved( topparent ) )
    {
        return false;
    }
    
    if ( script_mover_has_parent_moved( playerparent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x27f9
// Size: 0x2d
function script_mover_link_to_use_object( player )
{
    if ( isplayer( player ) )
    {
        player scripts\mp\movers::script_mover_start_use( self );
    }
    
    player allowmovement( 0 );
    player allowjump( 0 );
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x282e
// Size: 0x1d
function script_mover_unlink_from_use_object( player )
{
    player allowmovement( 1 );
    player allowjump( 1 );
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x2853
// Size: 0x8e
function notify_moving_platform_invalid()
{
    children = self getlinkedchildren( 0 );
    
    if ( !isdefined( children ) )
    {
        return;
    }
    
    foreach ( child in children )
    {
        if ( isdefined( child.no_moving_platfrom_unlink ) && child.no_moving_platfrom_unlink )
        {
            continue;
        }
        
        child unlink();
        child notify( "invalid_parent", self );
    }
}

// Namespace movers / scripts\mp\movers
// Params 2
// Checksum 0x0, Offset: 0x28e9
// Size: 0x6f
function process_moving_platform_death( data, platform )
{
    if ( isdefined( platform ) && isdefined( platform.no_moving_platfrom_death ) && platform.no_moving_platfrom_death )
    {
        return;
    }
    
    if ( isdefined( data.deathoverridecallback ) )
    {
        data.lasttouchedplatform = platform;
        self thread [[ data.deathoverridecallback ]]( data );
        return;
    }
    
    self delete();
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x2960
// Size: 0x13b
function handle_moving_platform_touch( data )
{
    self notify( "handle_moving_platform_touch" );
    self endon( "handle_moving_platform_touch" );
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "stop_handling_moving_platforms" );
    
    if ( isdefined( data.endonstring ) )
    {
        self endon( data.endonstring );
    }
    
    while ( true )
    {
        self waittill( "touching_platform", platform );
        
        if ( isdefined( data.validateaccuratetouching ) && data.validateaccuratetouching )
        {
            if ( !self istouching( platform ) )
            {
                waitframe();
                continue;
            }
        }
        
        if ( isdefined( data.plantedontrain ) && data.plantedontrain )
        {
            if ( scripts\cp_mp\utility\train_utility::is_train_ent( platform ) )
            {
                waitframe();
                continue;
            }
        }
        
        if ( isdefined( self.streakinfo ) && self.streakinfo.streakname == "pac_sentry" )
        {
            if ( isdefined( platform ) && isdefined( platform.crate ) )
            {
                waitframe();
                continue;
            }
        }
        
        if ( !istrue( data.skipdeath ) )
        {
            thread process_moving_platform_death( data, platform );
        }
        
        self.touchedmovingplatform = 1;
        self.lastmovingplatform = platform;
        thread platform_cleanup_on_death();
        break;
    }
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x2aa3
// Size: 0x23
function platform_cleanup_on_death()
{
    self endon( "death" );
    self.lastmovingplatform waittill( "death" );
    self.lastmovingplatform = undefined;
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x2ace
// Size: 0x8c
function handle_moving_platform_invalid( data )
{
    self notify( "handle_moving_platform_invalid" );
    self endon( "handle_moving_platform_invalid" );
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "stop_handling_moving_platforms" );
    
    if ( isdefined( data.endonstring ) )
    {
        self endon( data.endonstring );
    }
    
    self waittill( "invalid_parent", platform );
    
    if ( isdefined( data.invalidparentoverridecallback ) )
    {
        self thread [[ data.invalidparentoverridecallback ]]( data );
        return;
    }
    
    thread process_moving_platform_death( data, platform );
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x2b62
// Size: 0xf2
function handle_moving_platforms( data )
{
    self notify( "handle_moving_platforms" );
    self endon( "handle_moving_platforms" );
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "stop_handling_moving_platforms" );
    
    if ( !isdefined( data ) )
    {
        data = spawnstruct();
    }
    
    if ( isdefined( data.endonstring ) )
    {
        self endon( data.endonstring );
    }
    
    if ( isdefined( data.linkparent ) )
    {
        parent = self getlinkedparent();
        
        if ( !isdefined( parent ) || parent != data.linkparent )
        {
            if ( isdefined( data.linkoffset ) )
            {
                self linkto( data.linkparent, "", data.linkoffset, data.angleoffset );
            }
            else
            {
                self linkto( data.linkparent );
            }
        }
    }
    
    thread handle_moving_platform_touch( data );
    thread handle_moving_platform_invalid( data );
}

// Namespace movers / scripts\mp\movers
// Params 0
// Checksum 0x0, Offset: 0x2c5c
// Size: 0xa
function stop_handling_moving_platforms()
{
    self notify( "stop_handling_moving_platforms" );
}

// Namespace movers / scripts\mp\movers
// Params 1
// Checksum 0x0, Offset: 0x2c6e
// Size: 0xb
function moving_platform_empty_func( data )
{
    
}

