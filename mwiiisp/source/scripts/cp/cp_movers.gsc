#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;

#namespace cp_movers;

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x400
// Size: 0x153
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
    init();
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x55b
// Size: 0x15
function script_mover_classnames()
{
    return [ "script_model_mover", "script_brushmodel_mover" ];
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x579
// Size: 0x88
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 2
// Checksum 0x0, Offset: 0x60a
// Size: 0x37
function script_mover_add_hintstring( name, hintstring )
{
    if ( !isdefined( level.script_mover_hintstrings ) )
    {
        level.script_mover_hintstrings = [];
    }
    
    level.script_mover_hintstrings[ name ] = hintstring;
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 2
// Checksum 0x0, Offset: 0x649
// Size: 0x37
function script_mover_add_parameters( name, parameters )
{
    if ( !isdefined( level.script_mover_parameters ) )
    {
        level.script_mover_parameters = [];
    }
    
    level.script_mover_parameters[ name ] = parameters;
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x688
// Size: 0x2fb
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x98b
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x9e2
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0xa2d
// Size: 0x26
function anglesclamp180( angles )
{
    return ( angleclamp180( angles[ 0 ] ), angleclamp180( angles[ 1 ] ), angleclamp180( angles[ 2 ] ) );
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0xa5c
// Size: 0x3bb
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 3
// Checksum 0x0, Offset: 0xe1f
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 3
// Checksum 0x0, Offset: 0xe61
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0xea4
// Size: 0x9
function script_mover_trigger_on()
{
    trigger_on();
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0xeb5
// Size: 0x524
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 4
// Checksum 0x0, Offset: 0x13e1
// Size: 0x88
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x1471
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x14d0
// Size: 0x222
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x16fa
// Size: 0x87
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x178a
// Size: 0x66
function script_mover_apply_move_parameters( from )
{
    foreach ( value in from.params )
    {
        script_mover_set_param( key, value );
    }
    
    script_mover_set_defaults();
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 2
// Checksum 0x0, Offset: 0x17f8
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x183f
// Size: 0x78
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 2
// Checksum 0x0, Offset: 0x18bf
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x191b
// Size: 0x62
function script_mover_save_default_move_parameters()
{
    self.params_default = [];
    
    foreach ( value in self.params )
    {
        self.params_default[ key ] = value;
    }
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x1985
// Size: 0xbf
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x1a4c
// Size: 0xb
function init()
{
    level thread script_mover_agent_spawn_watch();
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x1a5f
// Size: 0x35
function script_mover_agent_spawn_watch()
{
    level notify( "script_mover_agent_spawn_watch" );
    level endon( "script_mover_agent_spawn_watch" );
    
    while ( true )
    {
        level waittill( "spawned_agent", agent );
        agent thread player_unresolved_collision_watch();
    }
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x1a9c
// Size: 0x143
function player_unresolved_collision_watch()
{
    self endon( "disconnect" );
    
    if ( isagent( self ) )
    {
        self endon( "death" );
    }
    
    self.unresolved_collision_count = 0;
    
    while ( true )
    {
        self waittill( "unresolved_collision", mover, penetration );
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
                else if ( mover scripts\cp_mp\vehicles\vehicle::isvehicle() )
                {
                    if ( isdefined( mover.var_47a068b6e4f69d26 ) )
                    {
                        scripts\cp_mp\vehicles\vehicle::vehicle_docollisiondamagetoplayer( mover, self, 1 );
                    }
                    
                    if ( !scripts\cp_mp\vehicles\vehicle::vehicle_docollisiondamagetoplayer( mover, self ) )
                    {
                        mover unresolved_collision_nearest_node( self );
                    }
                }
                else
                {
                    mover unresolved_collision_nearest_node( self );
                }
            }
            else
            {
                unresolved_collision_nearest_node( self );
            }
            
            self.unresolved_collision_count = 0;
        }
    }
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x1be7
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x1c08
// Size: 0xfb
function unresolved_collision_owner_damage( player )
{
    inflictor = self;
    
    if ( !isdefined( inflictor.owner ) )
    {
        player mover_suicide();
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
        player mover_suicide();
        return;
    }
    
    damage_ammount = 1000;
    
    if ( isdefined( inflictor.unresolved_collision_damage ) )
    {
        damage_ammount = inflictor.unresolved_collision_damage;
    }
    
    player dodamage( damage_ammount, inflictor.origin, inflictor.owner, inflictor, "MOD_CRUSH" );
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 2
// Checksum 0x0, Offset: 0x1d0b
// Size: 0x1d8
function unresolved_collision_nearest_node( player, var_4258fb168fb20ba6 )
{
    if ( isdefined( level.override_unresolved_collision ) )
    {
        self [[ level.override_unresolved_collision ]]( player, var_4258fb168fb20ba6 );
        return;
    }
    
    if ( scripts\cp_mp\utility\game_utility::islargemap() || is_specops_gametype() )
    {
        var_4258fb168fb20ba6 = 1;
        
        if ( scripts\cp_mp\vehicles\vehicle::isvehicle() )
        {
            seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverseat( self, 1 );
            
            if ( isdefined( seatid ) )
            {
                exitpositionandangles = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getexitpositionandangles( self, player, seatid, 1 );
                
                if ( isdefined( exitpositionandangles ) )
                {
                    player setorigin( exitpositionandangles[ 0 ] );
                    return;
                }
            }
        }
    }
    else
    {
        nodes = self.unresolved_collision_nodes;
        
        if ( isdefined( nodes ) )
        {
            nodes = sortbydistance( nodes, player.origin );
        }
        else
        {
            nodes = getnodesinradius( player.origin, 300, 0, 200 );
            nodes = sortbydistance( nodes, player.origin );
        }
        
        var_cd2c014424008317 = ( 0, 0, -100 );
        player cancelmantle();
        player dontinterpolate();
        player setorigin( player.origin + var_cd2c014424008317 );
        
        for ( i = 0; i < nodes.size ; i++ )
        {
            check_node = nodes[ i ];
            org = check_node.origin;
            
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
        
        player setorigin( player.origin - var_cd2c014424008317 );
    }
    
    if ( !isdefined( var_4258fb168fb20ba6 ) )
    {
        var_4258fb168fb20ba6 = 1;
    }
    
    if ( var_4258fb168fb20ba6 )
    {
        player mover_suicide();
    }
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 2
// Checksum 0x0, Offset: 0x1eeb
// Size: 0x13
function unresolved_collision_void( player, penetration )
{
    
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x1f06
// Size: 0x21
function mover_suicide()
{
    if ( isdefined( level.ishorde ) && !isagent( self ) )
    {
        return;
    }
    
    _suicide();
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x1f2f
// Size: 0x71
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x1fa8
// Size: 0xa
function stop_player_pushed_kill()
{
    self notify( "stop_player_pushed_kill" );
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x1fba
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x1ff6
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x20a3
// Size: 0x34, Type: bool
function script_mover_has_parent_moved( parent )
{
    if ( !isdefined( parent ) )
    {
        return false;
    }
    
    return lengthsquared( parent.origin - parent.startuseorigin ) > 0.001;
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x20e0
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x216b
// Size: 0xa9
function script_mover_link_to_use_object( player )
{
    if ( isplayer( player ) )
    {
        player script_mover_start_use( self );
        playermover = player getmovingplatformparent();
        var_aaf7642ee16a1e33 = undefined;
        
        if ( isdefined( playermover ) )
        {
            var_aaf7642ee16a1e33 = playermover;
        }
        else if ( !isdefined( script_mover_get_top_parent() ) )
        {
            var_aaf7642ee16a1e33 = self;
        }
        else
        {
            var_aaf7642ee16a1e33 = spawn( "script_model", player.origin );
            var_aaf7642ee16a1e33 setmodel( "tag_origin" );
            player.scriptmoverlinkdummy = var_aaf7642ee16a1e33;
            player thread sciprt_mover_use_object_wait_for_disconnect( var_aaf7642ee16a1e33 );
        }
        
        player playerlinkto( var_aaf7642ee16a1e33 );
    }
    else
    {
        player linkto( self );
    }
    
    player playerlinkedoffsetenable();
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x221c
// Size: 0x45
function script_mover_unlink_from_use_object( player )
{
    player unlink();
    
    if ( isdefined( player.scriptmoverlinkdummy ) )
    {
        player notify( "removeMoverLinkDummy" );
        player.scriptmoverlinkdummy delete();
        player.scriptmoverlinkdummy = undefined;
    }
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x2269
// Size: 0x3c
function sciprt_mover_use_object_wait_for_disconnect( linkdummy )
{
    self endon( "removeMoverLinkDummy" );
    waittill_any_2( "death", "disconnect" );
    self.scriptmoverlinkdummy delete();
    self.scriptmoverlinkdummy = undefined;
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x22ad
// Size: 0x8c
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 2
// Checksum 0x0, Offset: 0x2341
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x23b8
// Size: 0xa4
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
                wait 0.05;
                continue;
            }
        }
        
        thread process_moving_platform_death( data, platform );
        break;
    }
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x2464
// Size: 0x8b
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

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x24f7
// Size: 0x13c
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
            self linkto( data.linkparent );
        }
    }
    
    if ( isdefined( data.linkparents ) )
    {
        if ( isarray( data.linkparents ) )
        {
            foreach ( linkedparent in data.linkparents )
            {
                parent = self getlinkedparent();
                
                if ( !isdefined( parent ) || parent != linkedparent )
                {
                    self linkto( linkedparent );
                }
            }
        }
    }
    
    thread handle_moving_platform_touch( data );
    thread handle_moving_platform_invalid( data );
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 0
// Checksum 0x0, Offset: 0x263b
// Size: 0xa
function stop_handling_moving_platforms()
{
    self notify( "stop_handling_moving_platforms" );
}

// Namespace cp_movers / scripts\cp\cp_movers
// Params 1
// Checksum 0x0, Offset: 0x264d
// Size: 0xb
function moving_platform_empty_func( data )
{
    
}

