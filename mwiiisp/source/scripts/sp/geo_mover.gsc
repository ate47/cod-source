#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\utility;

#namespace geo_mover;

// Namespace geo_mover / scripts\sp\geo_mover
// Params 0
// Checksum 0x0, Offset: 0x126
// Size: 0xc
function init_mover_candidates()
{
    level.mover_candidates = undefined;
}

// Namespace geo_mover / scripts\sp\geo_mover
// Params 1
// Checksum 0x0, Offset: 0x13a
// Size: 0x85
function trigger_moveto( trigger )
{
    if ( !isdefined( level.mover_candidates ) )
    {
        level.mover_candidates = getentarray( "script_brushmodel", "classname" );
        level.mover_candidates = array_combine( level.mover_candidates, getentarray( "script_model", "classname" ) );
    }
    
    volumes = getentarray( trigger.target, "targetname" );
    array_thread( volumes, &moveto_volume_think, trigger );
}

// Namespace geo_mover / scripts\sp\geo_mover
// Params 1
// Checksum 0x0, Offset: 0x1c7
// Size: 0x641
function moveto_volume_think( trigger )
{
    movers = [];
    var_e62dc69923720fa9 = spawn_tag_origin();
    touch_test = self;
    
    foreach ( m in level.mover_candidates )
    {
        var_e62dc69923720fa9.origin = m.origin;
        
        if ( var_e62dc69923720fa9 istouching( touch_test ) )
        {
            level.mover_candidates = array_remove( level.mover_candidates, m );
            movers = array_add( movers, m );
        }
    }
    
    var_e62dc69923720fa9 delete();
    mover = undefined;
    
    /#
        var_d5d61a3d2ff3b06 = 0;
        
        foreach ( m in movers )
        {
            if ( isdefined( m.script_parameters ) && m.script_parameters == "<dev string:x1c>" )
            {
                var_d5d61a3d2ff3b06++;
            }
            
            if ( isdefined( m.script_parent ) && m.script_parent == "<dev string:x1c>" )
            {
                var_d5d61a3d2ff3b06++;
            }
        }
        
        assertex( var_d5d61a3d2ff3b06 < 2, "<dev string:x22>" + self.origin );
        assertex( var_d5d61a3d2ff3b06 > 0, "<dev string:x76>" + self.origin );
    #/
    
    foreach ( m in movers )
    {
        if ( isdefined( m.script_parameters ) && m.script_parameters == "mover" )
        {
            mover = m;
            break;
        }
        
        if ( isdefined( m.script_parent ) && m.script_parent == "mover" )
        {
            mover = m;
            break;
        }
    }
    
    foreach ( m in movers )
    {
        if ( mover != m )
        {
            m linkto( mover );
        }
    }
    
    mover_target = get_target_ent();
    
    if ( mover_target isvehicle() )
    {
        mover moveto_volume_vehiclespline( mover_target, trigger );
        self notify( "done_moving" );
        return;
    }
    
    if ( !isdefined( mover_target.angles ) )
    {
        mover_target.angles = ( 0, 0, 0 );
    }
    
    trigger.mover = mover;
    mover.origin = mover_target.origin;
    mover.angles = mover_target.angles;
    quake = undefined;
    exploder_name = undefined;
    duration = 5;
    accel = 0;
    decel = 0;
    var_69298ea86a787593 = undefined;
    var_e9aa975bb373e72f = undefined;
    
    if ( isdefined( mover_target.script_duration ) )
    {
        duration = mover_target.script_duration;
    }
    
    if ( isdefined( mover_target.script_accel ) )
    {
        accel = mover_target.script_accel;
    }
    
    if ( isdefined( mover_target.script_decel ) )
    {
        decel = mover_target.script_decel;
    }
    
    if ( isdefined( mover_target.script_earthquake ) )
    {
        quake = mover_target.script_earthquake;
    }
    
    if ( isdefined( mover_target.script_exploder ) )
    {
        exploder_name = mover_target.script_exploder;
    }
    
    if ( isdefined( mover_target.script_flag_wait ) )
    {
        var_69298ea86a787593 = mover_target.script_flag_wait;
    }
    
    if ( isdefined( mover_target.script_flag_waitopen ) )
    {
        var_e9aa975bb373e72f = mover_target.script_flag_waitopen;
    }
    
    trigger waittill( "trigger" );
    mover_target script_delay();
    
    if ( isdefined( mover_target.target ) )
    {
        mover_target = mover_target get_target_ent();
    }
    else
    {
    }
    
    for ( mover_target = undefined; isdefined( mover_target ) ; mover_target = undefined )
    {
        if ( isdefined( var_69298ea86a787593 ) )
        {
            flag_wait( var_69298ea86a787593 );
        }
        
        if ( isdefined( var_e9aa975bb373e72f ) )
        {
            flag_waitopen( var_e9aa975bb373e72f );
        }
        
        if ( isdefined( exploder_name ) )
        {
            exploder( exploder_name );
            level notify( "geo_mover_exploder", exploder_name );
        }
        else if ( isdefined( quake ) )
        {
            if ( issubstr( quake, "constant" ) )
            {
                mover thread constant_quake( quake );
            }
        }
        
        if ( !isdefined( mover_target.angles ) )
        {
            mover_target.angles = ( 0, 0, 0 );
        }
        
        mover moveto_rotateto( mover_target, duration, accel, decel );
        mover notify( "stop_constant_quake" );
        duration = 5;
        accel = 0;
        decel = 0;
        quake = undefined;
        mover_target script_delay();
        
        if ( isdefined( mover_target.script_duration ) )
        {
            duration = mover_target.script_duration;
        }
        
        if ( isdefined( mover_target.script_accel ) )
        {
            accel = mover_target.script_accel;
        }
        
        if ( isdefined( mover_target.script_decel ) )
        {
            decel = mover_target.script_decel;
        }
        
        if ( isdefined( mover_target.script_earthquake ) )
        {
            quake = mover_target.script_earthquake;
        }
        
        if ( isdefined( mover_target.script_exploder ) )
        {
            exploder_name = mover_target.script_exploder;
        }
        
        if ( isdefined( mover_target.script_flag_wait ) )
        {
            var_69298ea86a787593 = mover_target.script_flag_wait;
        }
        
        if ( isdefined( mover_target.script_flag_waitopen ) )
        {
            var_e9aa975bb373e72f = mover_target.script_flag_waitopen;
        }
        
        linked = mover_target get_linked_ents();
        
        if ( linked.size > 0 )
        {
            if ( issubstr( linked[ 0 ].classname, "trigger" ) )
            {
                linked[ 0 ] waittill( "trigger" );
            }
        }
        
        if ( isdefined( mover_target.target ) )
        {
            mover_target = mover_target get_target_ent();
            continue;
        }
    }
    
    self notify( "done_moving" );
}

// Namespace geo_mover / scripts\sp\geo_mover
// Params 2
// Checksum 0x0, Offset: 0x810
// Size: 0xef
function moveto_volume_vehiclespline( vehiclespawner, trigger )
{
    mover = self;
    mover_target = getvehiclenode( vehiclespawner.target, "targetname" );
    
    if ( !isdefined( mover_target.angles ) )
    {
        mover_target.angles = ( 0, 0, 0 );
    }
    
    trigger.mover = mover;
    mover.origin = mover_target.origin;
    mover.angles = mover_target.angles;
    trigger waittill( "trigger" );
    vehicle = vehiclespawner vehicle_dospawn();
    vehicle vehicle_turnengineoff();
    vehicle hide();
    vehicle godon();
    vehicle vehicle_turnengineoff();
    mover linkto( vehicle );
    vehicle attachpath( mover_target );
    vehicle startpath();
}

// Namespace geo_mover / scripts\sp\geo_mover
// Params 1
// Checksum 0x0, Offset: 0x907
// Size: 0x3c
function constant_quake( quake )
{
    self endon( "stop_constant_quake" );
    
    while ( true )
    {
        thread do_earthquake( quake, self.origin );
        wait randomfloatrange( 0.1, 0.2 );
    }
}

// Namespace geo_mover / scripts\sp\geo_mover
// Params 4
// Checksum 0x0, Offset: 0x94b
// Size: 0xae
function moveto_rotateto_speed( node, rate, accel, decel )
{
    point = node.origin;
    start_pos = self.origin;
    dist = distance( start_pos, point );
    time = dist / rate;
    
    if ( !isdefined( accel ) )
    {
        accel = 0;
    }
    
    if ( !isdefined( decel ) )
    {
        decel = 0;
    }
    
    self rotateto( node.angles, time, time * accel, time * decel );
    self moveto( point, time, time * accel, time * decel );
    self waittill( "movedone" );
}

// Namespace geo_mover / scripts\sp\geo_mover
// Params 4
// Checksum 0x0, Offset: 0xa01
// Size: 0x55
function moveto_rotateto( node, time, accel, decel )
{
    self moveto( node.origin, time, accel, decel );
    self rotateto( node.angles, time, accel, decel );
    self waittill( "movedone" );
}

// Namespace geo_mover / scripts\sp\geo_mover
// Params 1
// Checksum 0x0, Offset: 0xa5e
// Size: 0xb9
function set_start_positions( targetname )
{
    start_positions = getstructarray( targetname, "targetname" );
    
    foreach ( pos in start_positions )
    {
        switch ( pos.script_noteworthy )
        {
            case #"hash_87d1443ef2805760":
                level.player setorigin( pos.origin );
                level.player setplayerangles( pos.angles );
                break;
        }
    }
}

