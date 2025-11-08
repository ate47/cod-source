#using scripts\anim\shared;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\mg_penetration;
#using scripts\sp\mgturret;
#using scripts\sp\spawner;
#using scripts\sp\utility;

#namespace mgturret;

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x81a
// Size: 0x212
function init_mgturretsettings()
{
    level.mgturretsettings[ "easy" ][ "convergenceTime" ] = 2.5;
    level.mgturretsettings[ "easy" ][ "suppressionTime" ] = 3;
    level.mgturretsettings[ "easy" ][ "accuracy" ] = 0.38;
    level.mgturretsettings[ "easy" ][ "aiSpread" ] = 2;
    level.mgturretsettings[ "easy" ][ "playerSpread" ] = 0.5;
    level.mgturretsettings[ "medium" ][ "convergenceTime" ] = 1.5;
    level.mgturretsettings[ "medium" ][ "suppressionTime" ] = 3;
    level.mgturretsettings[ "medium" ][ "accuracy" ] = 0.38;
    level.mgturretsettings[ "medium" ][ "aiSpread" ] = 2;
    level.mgturretsettings[ "medium" ][ "playerSpread" ] = 0.5;
    level.mgturretsettings[ "hard" ][ "convergenceTime" ] = 0.8;
    level.mgturretsettings[ "hard" ][ "suppressionTime" ] = 3;
    level.mgturretsettings[ "hard" ][ "accuracy" ] = 0.38;
    level.mgturretsettings[ "hard" ][ "aiSpread" ] = 2;
    level.mgturretsettings[ "hard" ][ "playerSpread" ] = 0.5;
    level.mgturretsettings[ "fu" ][ "convergenceTime" ] = 0.4;
    level.mgturretsettings[ "fu" ][ "suppressionTime" ] = 3;
    level.mgturretsettings[ "fu" ][ "accuracy" ] = 0.38;
    level.mgturretsettings[ "fu" ][ "aiSpread" ] = 2;
    level.mgturretsettings[ "fu" ][ "playerSpread" ] = 0.5;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0xa34
// Size: 0xc6
function main()
{
    if ( getdvar( @"mg42" ) == "" )
    {
        setdvar( @"mgturret", "off" );
    }
    
    level.magic_distance = 24;
    create_func_ref( "turret_disableLinkedTurretAngles", &mgturret_disablelinkedturretangles );
    create_func_ref( "turret_enableLinkedTurretAngles", &mgturret_enablelinkedturretangles );
    turretinfos = getentarray( "turretInfo", "targetname" );
    
    for ( index = 0; index < turretinfos.size ; index++ )
    {
        turretinfos[ index ] delete();
    }
    
    create_lock( "mg42_drones" );
    create_lock( "mg42_drones_target_trace" );
    thread auto_mgturretlink();
    thread saw_mgturretlink();
    thread turretinits();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0xb02
// Size: 0x11
function mgturret_disablelinkedturretangles()
{
    level.player playerlinkedturretanglesdisable();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0xb1b
// Size: 0x11
function mgturret_enablelinkedturretangles()
{
    level.player playerlinkedturretanglesenable();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0xb34
// Size: 0xe4
function turretinits()
{
    possible_turrets = getentarray( "misc_turret", "code_classname" );
    var_adafff1d14cac7cb = [];
    
    foreach ( possible_turret in possible_turrets )
    {
        var_adafff1d14cac7cb = array_add( var_adafff1d14cac7cb, possible_turret );
    }
    
    foreach ( turret in var_adafff1d14cac7cb )
    {
        if ( isdefined( turret.targetname ) && turret.targetname == "zulu23_turret" )
        {
            turret thread zuluinit();
        }
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0xc20
// Size: 0x1b5
function portable_mg_behavior()
{
    self detach( "weapon_mg42_carry", "tag_origin" );
    self endon( "death" );
    self.goalradius = level.default_goalradius;
    
    if ( isdefined( self.target ) )
    {
        node = getnode( self.target, "targetname" );
        
        if ( isdefined( node ) )
        {
            if ( isdefined( node.radius ) )
            {
                self.goalradius = node.radius;
            }
            
            self setgoalnode( node );
        }
    }
    
    while ( !isdefined( self.node ) )
    {
        wait 0.05;
    }
    
    turret_node = undefined;
    
    if ( isdefined( self.target ) )
    {
        node = getnode( self.target, "targetname" );
        turret_node = node;
    }
    
    if ( !isdefined( turret_node ) )
    {
        turret_node = self.node;
    }
    
    if ( !isdefined( turret_node ) )
    {
        return;
    }
    
    if ( turret_node.type != "Turret" )
    {
        return;
    }
    
    taken_nodes = gettakennodes();
    taken_nodes[ self.node.origin + "" ] = undefined;
    
    if ( isdefined( taken_nodes[ turret_node.origin + "" ] ) )
    {
        return;
    }
    
    turret = turret_node.turret;
    
    if ( isdefined( turret.reserved ) )
    {
        assert( turret.reserved != self );
        return;
    }
    
    reserve_turret( turret );
    
    if ( turret.issetup )
    {
        leave_gun_and_run_to_new_spot( turret );
    }
    else
    {
        run_to_new_spot_and_setup_gun( turret );
    }
    
    scripts\sp\mg_penetration::gunner_think( turret_node.turret );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0xddd
// Size: 0x33
function mg42_trigger()
{
    self waittill( "trigger" );
    level notify( self.targetname );
    level.mg42_trigger[ self.targetname ] = 1;
    self delete();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0xe18
// Size: 0x104
function mgturret_auto( trigger )
{
    trigger waittill( "trigger" );
    ai = getaiarray( "bad_guys" );
    
    for ( i = 0; i < ai.size ; i++ )
    {
        if ( isdefined( ai[ i ].script_mg42auto ) && trigger.script_mg42auto == ai[ i ].script_mg42auto )
        {
            ai[ i ] notify( "auto_ai" );
            println( "<dev string:x1c>" );
        }
    }
    
    spawners = getspawnerarray();
    
    for ( i = 0; i < spawners.size ; i++ )
    {
        if ( isdefined( spawners[ i ].script_mg42auto ) && trigger.script_mg42auto == spawners[ i ].script_mg42auto )
        {
            spawners[ i ].ai_mode = "auto_ai";
            println( "<dev string:x2b>", i, "<dev string:x36>" );
        }
    }
    
    scripts\sp\spawner::kill_trigger( trigger );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0xf24
// Size: 0x77
function mg42_suppressionfire( targets )
{
    self endon( "death" );
    self endon( "stop_suppressionFire" );
    
    if ( !isdefined( self.suppresionfire ) )
    {
        self.suppresionfire = 1;
    }
    
    for ( ;; )
    {
        while ( self.suppresionfire )
        {
            self settargetentity( targets[ randomint( targets.size ) ] );
            wait 2 + randomfloat( 2 );
        }
        
        self cleartargetentity();
        
        while ( !self.suppresionfire )
        {
            wait 1;
        }
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0xfa3
// Size: 0x4b
function manual_think( mg42 )
{
    org = self.origin;
    self waittill( "auto_ai" );
    mg42 notify( "stopfiring" );
    mg42 setmode( "auto_ai" );
    mg42 settargetentity( level.player );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0xff6
// Size: 0x5d
function burst_fire_settings( setting )
{
    if ( setting == "delay" )
    {
        return 0.2;
    }
    
    if ( setting == "delay_range" )
    {
        return 0.5;
    }
    
    if ( setting == "burst" )
    {
        return 0.5;
    }
    
    if ( setting == "burst_fire_rate" )
    {
        return 0.1;
    }
    
    return 1.5;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x105b
// Size: 0x1e2
function burst_fire_unmanned()
{
    self endon( "death" );
    self endon( "stop_burst_fire_unmanned" );
    
    if ( isdefined( self.script_delay_min ) )
    {
        mg42_delay = self.script_delay_min;
    }
    else
    {
        mg42_delay = burst_fire_settings( "delay" );
    }
    
    if ( isdefined( self.script_delay_max ) )
    {
        var_e7c2eca166ff3355 = self.script_delay_max - mg42_delay;
    }
    else
    {
        var_e7c2eca166ff3355 = burst_fire_settings( "delay_range" );
    }
    
    if ( isdefined( self.script_burst_min ) )
    {
        mg42_burst = self.script_burst_min;
    }
    else
    {
        mg42_burst = burst_fire_settings( "burst" );
    }
    
    if ( isdefined( self.script_burst_max ) )
    {
        var_2b8f70c634712f60 = self.script_burst_max - mg42_burst;
    }
    else
    {
        var_2b8f70c634712f60 = burst_fire_settings( "burst_range" );
    }
    
    if ( isdefined( self.script_burst_fire_rate ) )
    {
        var_8651842fb899f562 = self.script_burst_fire_rate;
    }
    else
    {
        var_8651842fb899f562 = burst_fire_settings( "burst_fire_rate" );
    }
    
    pauseuntiltime = gettime();
    turretstate = "start";
    
    if ( isdefined( self.shell_fx ) )
    {
        thread turret_shell_fx();
    }
    
    for ( ;; )
    {
        duration = ( pauseuntiltime - gettime() ) * 0.001;
        
        if ( self isfiringturret() && duration <= 0 )
        {
            if ( turretstate != "fire" )
            {
                turretstate = "fire";
                thread doshoot( var_8651842fb899f562 );
            }
            
            duration = mg42_burst + randomfloat( var_2b8f70c634712f60 );
            thread turrettimer( duration );
            self waittill( "turretstatechange" );
            duration = mg42_delay + randomfloat( var_e7c2eca166ff3355 );
            pauseuntiltime = gettime() + int( duration * 1000 );
            continue;
        }
        
        if ( turretstate != "aim" )
        {
            turretstate = "aim";
        }
        
        thread turrettimer( duration );
        self waittill( "turretstatechange" );
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x1245
// Size: 0x3d
function doshoot( var_5ba6fa0508a68649 )
{
    self endon( "death" );
    self endon( "turretstatechange" );
    fire_rate = 0.1;
    
    if ( isdefined( var_5ba6fa0508a68649 ) )
    {
        fire_rate = var_5ba6fa0508a68649;
    }
    
    for ( ;; )
    {
        self shootturret();
        wait fire_rate;
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x128a
// Size: 0x6f
function turret_shell_fx()
{
    self endon( "death" );
    self endon( "stop_burst_fire_unmanned" );
    
    if ( isdefined( self.shell_sound ) )
    {
        self.shell_sound_enabled = 1;
    }
    
    while ( true )
    {
        self waittill( "turret_fire" );
        playfxontag( self.shell_fx, self, "tag_origin" );
        
        if ( isdefined( self.shell_sound_enabled ) && self.shell_sound_enabled )
        {
            thread turret_shell_sound();
        }
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x1301
// Size: 0x81
function turret_shell_sound()
{
    self endon( "death" );
    self.shell_sound_enabled = 0;
    tag_origin = self gettagorigin( "tag_origin" );
    origin = drop_to_ground( tag_origin, -30 );
    dist = tag_origin[ 2 ] - origin[ 2 ];
    time = dist / 300;
    wait time;
    playsoundatpos( origin, self.shell_sound );
    wait 1;
    self.shell_sound_enabled = 1;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x138a
// Size: 0x28
function turrettimer( duration )
{
    if ( duration <= 0 )
    {
        return;
    }
    
    self endon( "turretstatechange" );
    wait duration;
    
    if ( isdefined( self ) )
    {
        self notify( "turretstatechange" );
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x13ba
// Size: 0xba
function random_spread( ent )
{
    self endon( "death" );
    self notify( "stop random_spread" );
    self endon( "stop random_spread" );
    self endon( "stopfiring" );
    self settargetentity( ent );
    
    while ( true )
    {
        if ( isplayer( ent ) )
        {
            ent.origin = self.manual_target getorigin();
        }
        else
        {
            ent.origin = self.manual_target.origin;
        }
        
        ent.origin += ( 20 - randomfloat( 40 ), 20 - randomfloat( 40 ), 20 - randomfloat( 60 ) );
        wait 0.2;
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x147c
// Size: 0x50
function mg42_firing( mg42 )
{
    self notify( "stop_using_built_in_burst_fire" );
    self endon( "stop_using_built_in_burst_fire" );
    mg42 stopfiring();
    
    while ( true )
    {
        mg42 waittill( "startfiring" );
        thread burst_fire( mg42 );
        mg42 startfiring();
        mg42 waittill( "stopfiring" );
        mg42 stopfiring();
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 2
// Checksum 0x0, Offset: 0x14d4
// Size: 0x137
function burst_fire( mg42, manual_target )
{
    mg42 endon( "entitydeleted" );
    mg42 endon( "stopfiring" );
    self endon( "stop_using_built_in_burst_fire" );
    
    if ( isdefined( mg42.script_delay_min ) )
    {
        mg42_delay = mg42.script_delay_min;
    }
    else
    {
        mg42_delay = scripts\sp\mgturret::burst_fire_settings( "delay" );
    }
    
    if ( isdefined( mg42.script_delay_max ) )
    {
        var_e7c2eca166ff3355 = mg42.script_delay_max - mg42_delay;
    }
    else
    {
        var_e7c2eca166ff3355 = scripts\sp\mgturret::burst_fire_settings( "delay_range" );
    }
    
    if ( isdefined( mg42.script_burst_min ) )
    {
        mg42_burst = mg42.script_burst_min;
    }
    else
    {
        mg42_burst = scripts\sp\mgturret::burst_fire_settings( "burst" );
    }
    
    if ( isdefined( mg42.script_burst_max ) )
    {
        var_2b8f70c634712f60 = mg42.script_burst_max - mg42_burst;
    }
    else
    {
        var_2b8f70c634712f60 = scripts\sp\mgturret::burst_fire_settings( "burst_range" );
    }
    
    while ( true )
    {
        mg42 startfiring();
        
        if ( isdefined( manual_target ) )
        {
            mg42 thread random_spread( manual_target );
        }
        
        wait mg42_burst + randomfloat( var_2b8f70c634712f60 );
        mg42 stopfiring();
        wait mg42_delay + randomfloat( var_e7c2eca166ff3355 );
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x1613
// Size: 0x1e0
function _spawner_mg42_think()
{
    if ( !isdefined( self.flagged_for_use ) )
    {
        self.flagged_for_use = 0;
    }
    
    if ( !isdefined( self.targetname ) )
    {
        return;
    }
    
    node = getnode( self.targetname, "target" );
    
    if ( !isdefined( node ) )
    {
        return;
    }
    
    if ( !isdefined( node.script_mg42 ) )
    {
        return;
    }
    
    if ( !isdefined( node.mg42_enabled ) )
    {
        node.mg42_enabled = 1;
    }
    
    self.script_mg42 = node.script_mg42;
    first_run = 1;
    
    while ( true )
    {
        if ( first_run )
        {
            first_run = 0;
            
            if ( isdefined( node.targetname ) || self.flagged_for_use )
            {
                self waittill( "get new user" );
            }
        }
        
        if ( !node.mg42_enabled )
        {
            node waittill( "enable mg42" );
            node.mg42_enabled = 1;
        }
        
        excluders = [];
        ai = getaiarray();
        
        for ( i = 0; i < ai.size ; i++ )
        {
            excluded = 1;
            
            if ( isdefined( ai[ i ].script_mg42 ) && ai[ i ].script_mg42 == self.script_mg42 )
            {
                excluded = 0;
            }
            
            if ( isdefined( ai[ i ].used_an_mg42 ) )
            {
                excluded = 1;
            }
            
            if ( excluded )
            {
                excluders[ excluders.size ] = ai[ i ];
            }
        }
        
        if ( excluders.size )
        {
            ai = scripts\engine\sp\utility::get_closest_ai_exclude( node.origin, undefined, excluders );
        }
        else
        {
            ai = scripts\engine\sp\utility::get_closest_ai( node.origin, undefined );
        }
        
        excluders = undefined;
        
        if ( isdefined( ai ) )
        {
            ai notify( "stop_going_to_node" );
            ai thread scripts\sp\spawner::go_to_node( node );
            ai waittill( "death" );
            continue;
        }
        
        self waittill( "get new user" );
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x17fb
// Size: 0x1cc
function mg42_think()
{
    if ( !isdefined( self.ai_mode ) )
    {
        self.ai_mode = "manual_ai";
    }
    
    node = getnode( self.target, "targetname" );
    
    if ( !isdefined( node ) )
    {
        println( "<dev string:x43>", self.origin, "<dev string:x4f>" );
        return;
    }
    
    mg42 = getent( node.target, "targetname" );
    mg42.org = node.origin;
    
    if ( isdefined( mg42.target ) )
    {
        if ( !isdefined( level.mg42_trigger ) || !isdefined( level.mg42_trigger[ mg42.target ] ) )
        {
            level.mg42_trigger[ mg42.target ] = 0;
            getent( mg42.target, "targetname" ) thread mg42_trigger();
        }
        
        trigger = 1;
    }
    else
    {
        trigger = 0;
    }
    
    while ( true )
    {
        if ( self.count == 0 )
        {
            return;
        }
        
        mg42_gunner = undefined;
        
        while ( !isdefined( mg42_gunner ) )
        {
            mg42_gunner = spawn_ai();
            wait 1;
        }
        
        mg42_gunner thread mg42_gunner_think( mg42, trigger, self.ai_mode );
        mg42_gunner thread mg42_firing( mg42 );
        mg42_gunner waittill( "death" );
        
        if ( isdefined( self.script_delay ) )
        {
            wait self.script_delay;
            continue;
        }
        
        if ( isdefined( self.script_delay_min ) && isdefined( self.script_delay_max ) )
        {
            wait self.script_delay_min + randomfloat( self.script_delay_max - self.script_delay_min );
            continue;
        }
        
        wait 1;
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 4
// Checksum 0x0, Offset: 0x19cf
// Size: 0x3f
function kill_objects( owner, msg, temp1, temp2 )
{
    owner waittill( msg );
    
    if ( isdefined( temp1 ) )
    {
        temp1 delete();
    }
    
    if ( isdefined( temp2 ) )
    {
        temp2 delete();
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 3
// Checksum 0x0, Offset: 0x1a16
// Size: 0x96
function mg42_gunner_think( mg42, trigger, ai_mode )
{
    self endon( "death" );
    
    if ( ai_mode == "manual_ai" )
    {
        while ( true )
        {
            thread mg42_gunner_manual_think( mg42, trigger );
            self waittill( "auto_ai" );
            move_use_turret( mg42, "auto_ai" );
            self waittill( "manual_ai" );
        }
        
        return;
    }
    
    while ( true )
    {
        move_use_turret( mg42, "auto_ai", level.player );
        self waittill( "manual_ai" );
        thread mg42_gunner_manual_think( mg42, trigger );
        self waittill( "auto_ai" );
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x1ab4
// Size: 0x59, Type: bool
function player_safe()
{
    if ( !isdefined( level.player_covertrigger ) )
    {
        return false;
    }
    
    if ( level.player getstance() == "prone" )
    {
        return true;
    }
    
    if ( level.player_covertype == "cow" && level.player getstance() == "crouch" )
    {
        return true;
    }
    
    return false;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x1b16
// Size: 0x5c
function stance_num()
{
    if ( level.player getstance() == "prone" )
    {
        return ( 0, 0, 5 );
    }
    else if ( level.player getstance() == "crouch" )
    {
        return ( 0, 0, 25 );
    }
    
    return ( 0, 0, 50 );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 2
// Checksum 0x0, Offset: 0x1b7b
// Size: 0x6e4
function mg42_gunner_manual_think( mg42, trigger )
{
    self endon( "death" );
    self endon( "auto_ai" );
    self.pacifist = 1;
    self setgoalpos( mg42.org );
    self.goalradius = level.magic_distance;
    self waittill( "goal" );
    
    if ( trigger )
    {
        if ( !level.mg42_trigger[ mg42.target ] )
        {
            level waittill( mg42.target );
        }
    }
    
    self.pacifist = 0;
    mg42 setmode( "auto_ai" );
    mg42 cleartargetentity();
    targ_org = spawn( "script_origin", ( 0, 0, 0 ) );
    tempmodel = spawn( "script_model", ( 0, 0, 0 ) );
    tempmodel.scale = 3;
    
    if ( getdvar( @"mg42" ) != "off" )
    {
        tempmodel setmodel( "temp" );
    }
    
    tempmodel thread temp_think( mg42, targ_org );
    level thread kill_objects( self, "death", targ_org, tempmodel );
    level thread kill_objects( self, "auto_ai", targ_org, tempmodel );
    mg42.player_target = 0;
    mg42timer = 0;
    targets = getentarray( "mg42_target", "targetname" );
    
    if ( targets.size > 0 )
    {
        script_targets = 1;
        current_org = targets[ randomint( targets.size ) ].origin;
        thread shoot_mg42_script_targets( targets );
        move_use_turret( mg42 );
        self.target_entity = targ_org;
        mg42 setmode( "manual_ai" );
        mg42 settargetentity( targ_org );
        mg42 notify( "startfiring" );
        mindist = 15;
        wait_time = 0.08;
        dif = 0.05;
        targ_org.origin = targets[ randomint( targets.size ) ].origin;
        shoot_timer = 0;
        
        while ( !isdefined( level.player_covertrigger ) )
        {
            current_org = targ_org.origin;
            
            if ( distance( current_org, targets[ self.gun_targ ].origin ) > mindist )
            {
                temp_vec = vectornormalize( targets[ self.gun_targ ].origin - current_org );
                temp_vec *= mindist;
                current_org += temp_vec;
            }
            else
            {
                self notify( "next_target" );
            }
            
            targ_org.origin = current_org;
            wait 0.1;
        }
        
        while ( true )
        {
            i = 0;
            
            while ( i < 1 )
            {
                targ_org.origin = current_org * ( 1 - i ) + ( level.player getorigin() + stance_num() ) * i;
                
                if ( player_safe() )
                {
                    i = 2;
                }
                
                wait wait_time;
                i += dif;
            }
            
            old_org = level.player getorigin();
            
            while ( !player_safe() )
            {
                targ_org.origin = level.player getorigin();
                vec_dif = targ_org.origin - old_org;
                targ_org.origin = targ_org.origin + vec_dif + stance_num();
                old_org = level.player getorigin();
                wait 0.1;
            }
            
            if ( player_safe() )
            {
                shoot_timer = gettime() + 1500 + randomfloat( 4000 );
                
                while ( player_safe() && isdefined( level.player_covertrigger.target ) && gettime() < shoot_timer )
                {
                    target = getentarray( level.player_covertrigger.target, "targetname" );
                    target = target[ randomint( target.size ) ];
                    targ_org.origin = target.origin + ( randomfloat( 30 ) - 15, randomfloat( 30 ) - 15, randomfloat( 40 ) - 60 );
                    wait 0.1;
                }
            }
            
            self notify( "next_target" );
            
            while ( player_safe() )
            {
                current_org = targ_org.origin;
                
                if ( distance( current_org, targets[ self.gun_targ ].origin ) > mindist )
                {
                    temp_vec = vectornormalize( targets[ self.gun_targ ].origin - current_org );
                    temp_vec *= mindist;
                    current_org += temp_vec;
                }
                else
                {
                    self notify( "next_target" );
                }
                
                targ_org.origin = current_org;
                wait 0.1;
            }
        }
        
        return;
    }
    
    while ( true )
    {
        move_use_turret( mg42 );
        
        while ( !isdefined( level.player_covertrigger ) )
        {
            if ( !mg42.player_target )
            {
                mg42 settargetentity( level.player );
                mg42.player_target = 1;
                tempmodel.targent = level.player;
            }
            
            wait 0.2;
        }
        
        mg42 setmode( "manual_ai" );
        move_use_turret( mg42 );
        mg42 notify( "startfiring" );
        shoot_timer = gettime() + 1500 + randomfloat( 4000 );
        
        while ( shoot_timer > gettime() )
        {
            if ( isdefined( level.player_covertrigger ) )
            {
                target = getentarray( level.player_covertrigger.target, "targetname" );
                target = target[ randomint( target.size ) ];
                targ_org.origin = target.origin + ( randomfloat( 30 ) - 15, randomfloat( 30 ) - 15, randomfloat( 40 ) - 60 );
                mg42 settargetentity( targ_org );
                tempmodel.targent = targ_org;
                wait randomfloat( 1 );
                continue;
            }
            
            break;
        }
        
        mg42 notify( "stopfiring" );
        move_use_turret( mg42 );
        
        if ( mg42.player_target )
        {
            mg42 setmode( "auto_ai" );
            mg42 cleartargetentity();
            mg42.player_target = 0;
            tempmodel.targent = tempmodel;
            tempmodel.origin = ( 0, 0, 0 );
        }
        
        while ( isdefined( level.player_covertrigger ) )
        {
            wait 0.2;
        }
        
        wait 0.75 + randomfloat( 0.2 );
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x2267
// Size: 0xae
function shoot_mg42_script_targets( targets )
{
    self endon( "death" );
    
    while ( true )
    {
        targ_filled = [];
        
        for ( i = 0; i < targets.size ; i++ )
        {
            targ_filled[ i ] = 0;
        }
        
        for ( i = 0; i < targets.size ; i++ )
        {
            self.gun_targ = randomint( targets.size );
            self waittill( "next_target" );
            
            while ( targ_filled[ self.gun_targ ] )
            {
                self.gun_targ++;
                
                if ( self.gun_targ >= targets.size )
                {
                    self.gun_targ = 0;
                }
            }
            
            targ_filled[ self.gun_targ ] = 1;
        }
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 3
// Checksum 0x0, Offset: 0x231d
// Size: 0x82
function move_use_turret( mg42, aitype, target )
{
    self setgoalpos( mg42.org );
    self.goalradius = level.magic_distance;
    self waittill( "goal" );
    
    if ( isdefined( aitype ) && aitype == "auto_ai" )
    {
        mg42 setmode( "auto_ai" );
        
        if ( isdefined( target ) )
        {
            mg42 settargetentity( target );
        }
        else
        {
            mg42 cleartargetentity();
        }
    }
    
    self useturret( mg42 );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 2
// Checksum 0x0, Offset: 0x23a7
// Size: 0x86
function temp_think( mg42, targ )
{
    if ( getdvar( @"mg42" ) == "off" )
    {
        return;
    }
    
    self.targent = self;
    
    while ( true )
    {
        self.origin = targ.origin;
        
        /#
            line( self.origin, mg42.origin, ( 0.2, 0.5, 0.8 ), 0.5 );
        #/
        
        wait 0.1;
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x2435
// Size: 0xbd
function turret_think( node )
{
    turret = getent( node.auto_mg42_target, "targetname" );
    mintime = 0.5;
    
    if ( isdefined( turret.script_turret_reuse_min ) )
    {
        mintime = turret.script_turret_reuse_min;
    }
    
    maxtime = 2;
    
    if ( isdefined( turret.script_turret_reuse_max ) )
    {
        mintime = turret.script_turret_reuse_max;
    }
    
    assert( maxtime >= mintime );
    
    for ( ;; )
    {
        turret waittill( "turret_deactivate" );
        wait mintime + randomfloat( maxtime - mintime );
        
        while ( !isturretactive( turret ) )
        {
            turret_find_user( node, turret );
            wait 1;
        }
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 2
// Checksum 0x0, Offset: 0x24fa
// Size: 0xa1
function turret_find_user( node, turret )
{
    ai = getaiarray();
    
    for ( i = 0; i < ai.size ; i++ )
    {
        if ( ai[ i ] isingoal( node.origin ) && ai[ i ] canuseturret( turret ) )
        {
            var_9a0d6e3a66997c0e = ai[ i ].keepclaimednodeifvalid;
            ai[ i ].keepclaimednodeifvalid = 0;
            
            if ( !ai[ i ] usecovernode( node ) )
            {
                ai[ i ].keepclaimednodeifvalid = var_9a0d6e3a66997c0e;
            }
        }
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x25a3
// Size: 0xe5
function setdifficulty()
{
    init_mgturretsettings();
    mg42s = getentarray( "misc_turret", "code_classname" );
    difficulty = utility::getdifficulty();
    
    for ( index = 0; index < mg42s.size ; index++ )
    {
        if ( isdefined( mg42s[ index ].script_skilloverride ) )
        {
            switch ( mg42s[ index ].script_skilloverride )
            {
                case #"hash_22ce4003c1e5227b":
                    difficulty = "easy";
                    break;
                case #"hash_c71b112fe04823d6":
                    difficulty = "medium";
                    break;
                case #"hash_cc9157548a55043c":
                    difficulty = "hard";
                    break;
                case #"hash_fa14cdf6bd53b8e4":
                    difficulty = "fu";
                    break;
                default:
                    continue;
            }
        }
        
        mg42_setdifficulty( mg42s[ index ], difficulty );
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 2
// Checksum 0x0, Offset: 0x2690
// Size: 0xa4
function mg42_setdifficulty( mg42, difficulty )
{
    mg42.convergencetime = level.mgturretsettings[ difficulty ][ "convergenceTime" ];
    mg42.suppressiontime = level.mgturretsettings[ difficulty ][ "suppressionTime" ];
    mg42.accuracy = level.mgturretsettings[ difficulty ][ "accuracy" ];
    mg42.aispread = level.mgturretsettings[ difficulty ][ "aiSpread" ];
    mg42.playerspread = level.mgturretsettings[ difficulty ][ "playerSpread" ];
}

// Namespace mgturret / scripts\sp\mgturret
// Params 3
// Checksum 0x0, Offset: 0x273c
// Size: 0x30e
function mg42_target_drones( nonai, team, dotrange )
{
    if ( !isdefined( dotrange ) )
    {
        dotrange = 0.88;
    }
    
    self endon( "death" );
    self notify( "stop_mg42_target_drones" );
    self endon( "stop_mg42_target_drones" );
    self.dronefailed = 0;
    
    if ( !isdefined( self.script_fireondrones ) )
    {
        self.script_fireondrones = 0;
    }
    
    if ( !isdefined( nonai ) )
    {
        nonai = 0;
    }
    
    self setmode( "manual_ai" );
    difficulty = utility::getdifficulty();
    
    if ( !isdefined( level.drones ) )
    {
        var_c54df9606ecbe73f = 1;
    }
    else
    {
    }
    
    for ( var_c54df9606ecbe73f = 0; true ; var_c54df9606ecbe73f = 1 )
    {
        if ( var_c54df9606ecbe73f )
        {
            if ( isdefined( self.drones_targets_sets_to_default ) )
            {
                self setmode( self.defaultonmode );
            }
            else if ( nonai )
            {
                self setmode( "auto_nonai" );
            }
            else
            {
                self setmode( "auto_ai" );
            }
            
            level waittill( "new_drone" );
        }
        
        if ( !isdefined( self.oldconvergencetime ) )
        {
            self.oldconvergencetime = self.convergencetime;
        }
        
        self.convergencetime = 2;
        
        if ( !nonai )
        {
            turretowner = self getturretowner();
            
            if ( !isalive( turretowner ) || isplayer( turretowner ) )
            {
                wait 0.05;
                continue;
            }
            else
            {
                team = turretowner.team;
            }
        }
        else
        {
            assert( isdefined( team ) );
            turretowner = undefined;
        }
        
        if ( team == "allies" )
        {
            targetteam = "axis";
        }
        else
        {
            targetteam = "allies";
        }
        
        while ( level.drones[ targetteam ].lastindex )
        {
            lock( "mg42_drones" );
            
            if ( !level.drones[ targetteam ].lastindex )
            {
                unlock( "mg42_drones" );
                break;
            }
            
            target = get_bestdrone( targetteam, dotrange );
            unlock( "mg42_drones" );
            
            if ( !isdefined( self.script_fireondrones ) || !self.script_fireondrones )
            {
                wait 0.05;
                break;
            }
            
            if ( !isdefined( target ) )
            {
                wait 0.05;
                break;
            }
            
            if ( isdefined( self.anim_wait_func ) )
            {
                [[ self.anim_wait_func ]]();
            }
            
            if ( nonai )
            {
                self setmode( "manual" );
            }
            else
            {
                self setmode( "manual_ai" );
            }
            
            self settargetentity( target, ( 0, 0, 32 ) );
            drone_target( target, 1, dotrange );
            self cleartargetentity();
            self stopfiring();
            
            if ( !nonai && !( isdefined( self getturretowner() ) && self getturretowner() == turretowner ) )
            {
                break;
            }
        }
        
        self.convergencetime = self.oldconvergencetime;
        self.oldconvergencetime = undefined;
        self cleartargetentity();
        self stopfiring();
        
        if ( level.drones[ targetteam ].lastindex )
        {
            var_c54df9606ecbe73f = 0;
            continue;
        }
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 3
// Checksum 0x0, Offset: 0x2a52
// Size: 0x148
function drone_target( drone, time, dotrange )
{
    self endon( "death" );
    drone endon( "death" );
    timer = gettime() + time * 1000;
    startedfiring = 0;
    
    while ( timer > gettime() || startedfiring )
    {
        lock( "mg42_drones_target_trace" );
        turrettarget = self getturrettarget( 1 );
        
        if ( !scripts\engine\trace::_bullet_trace_passed( self gettagorigin( "tag_flash" ), drone.origin + ( 0, 0, 40 ), 0, drone ) )
        {
            unlock( "mg42_drones_target_trace" );
            break;
        }
        else if ( isdefined( turrettarget ) && distance( turrettarget.origin, self.origin ) < distance( self.origin, drone.origin ) )
        {
            unlock( "mg42_drones_target_trace" );
            break;
        }
        
        if ( !startedfiring )
        {
            self startfiring();
            startedfiring = 1;
        }
        
        unlock_wait( "mg42_drones_target_trace" );
    }
    
    self stopfiring();
    scripts\engine\sp\utility::structarray_shuffle( level.drones[ drone.team ], 1 );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 2
// Checksum 0x0, Offset: 0x2ba2
// Size: 0x1a3
function get_bestdrone( team, dotrange )
{
    if ( level.drones[ team ].lastindex < 1 )
    {
        return;
    }
    
    ent = undefined;
    dotforward = anglestoforward( self.angles );
    
    for ( i = 0; i < level.drones[ team ].lastindex ; i++ )
    {
        if ( !isdefined( level.drones[ team ].array[ i ] ) )
        {
            continue;
        }
        
        angles = vectortoangles( level.drones[ team ].array[ i ].origin - self.origin );
        forward = anglestoforward( angles );
        
        if ( vectordot( dotforward, forward ) < dotrange )
        {
            continue;
        }
        
        ent = level.drones[ team ].array[ i ];
        
        if ( !scripts\engine\trace::_bullet_trace_passed( self gettagorigin( "tag_flash" ), ent getcentroid(), 0, ent ) )
        {
            ent = undefined;
            continue;
        }
        
        break;
    }
    
    aitarget = self getturrettarget( 1 );
    
    if ( !isdefined( self.prefers_drones ) )
    {
        if ( isdefined( ent ) && isdefined( aitarget ) && distancesquared( self.origin, aitarget.origin ) < distancesquared( self.origin, ent.origin ) )
        {
            ent = undefined;
        }
    }
    
    return ent;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x2d4e
// Size: 0x427
function saw_mgturretlink()
{
    possible_turrets = getentarray( "misc_turret", "code_classname" );
    turrets = [];
    
    foreach ( possible_turret in possible_turrets )
    {
        if ( isdefined( possible_turret.targetname ) )
        {
            continue;
        }
        
        if ( isdefined( possible_turret.script_turret_autonomous ) && possible_turret.script_turret_autonomous )
        {
            continue;
        }
        
        if ( isdefined( possible_turret.isvehicleattached ) )
        {
            assertex( possible_turret.isvehicleattached != 0, "Setting must be either true or undefined" );
            continue;
        }
        
        turrets[ turrets.size ] = possible_turret;
    }
    
    if ( !turrets.size )
    {
        return;
    }
    
    unclaimed = turrets;
    
    foreach ( turret in turrets )
    {
        foreach ( node in getnodesinradius( turret.origin, 50, 0 ) )
        {
            if ( node.type == "Path" )
            {
                continue;
            }
            
            if ( node.type == "Begin" )
            {
                continue;
            }
            
            if ( node.type == "End" )
            {
                continue;
            }
            
            nodeforward = anglestoforward( ( 0, node.angles[ 1 ], 0 ) );
            turretforward = anglestoforward( ( 0, turret.angles[ 1 ], 0 ) );
            dot = vectordot( nodeforward, turretforward );
            
            if ( dot < 0.9 )
            {
                continue;
            }
            
            unclaimed = array_remove( unclaimed, turret );
            node.turretinfo = spawn( "script_origin", turret.origin );
            node.turretinfo.angles = turret.angles;
            node.turretinfo.node = node;
            node.turretinfo.leftarc = 45;
            node.turretinfo.rightarc = 45;
            node.turretinfo.toparc = 15;
            node.turretinfo.bottomarc = 15;
            
            if ( isdefined( turret.leftarc ) )
            {
                node.turretinfo.leftarc = min( turret.leftarc, 45 );
            }
            
            if ( isdefined( turret.rightarc ) )
            {
                node.turretinfo.rightarc = min( turret.rightarc, 45 );
            }
            
            if ( isdefined( turret.toparc ) )
            {
                node.turretinfo.toparc = min( turret.toparc, 15 );
            }
            
            if ( isdefined( turret.bottomarc ) )
            {
                node.turretinfo.bottomarc = min( turret.bottomarc, 15 );
            }
            
            turret delete();
        }
    }
    
    /#
        foreach ( turret in unclaimed )
        {
            assertmsg( "<dev string:x5c>" + turret.origin + "<dev string:x6e>" );
        }
    #/
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x317d
// Size: 0x2f1
function auto_mgturretlink()
{
    possible_turrets = getentarray( "misc_turret", "code_classname" );
    turrets = [];
    
    foreach ( possible_turret in possible_turrets )
    {
        if ( !isdefined( possible_turret.targetname ) || tolower( possible_turret.targetname ) != "auto_mgturret" )
        {
            continue;
        }
        
        if ( !isdefined( possible_turret.export ) )
        {
            continue;
        }
        
        if ( !isdefined( possible_turret.script_dont_link_turret ) )
        {
            turrets[ turrets.size ] = possible_turret;
        }
    }
    
    if ( !turrets.size )
    {
        return;
    }
    
    unclaimed = turrets;
    
    foreach ( turret in turrets )
    {
        foreach ( node in getnodesinradius( turret.origin, 70 ) )
        {
            if ( node.type == "Path" )
            {
                continue;
            }
            
            if ( node.type == "Begin" )
            {
                continue;
            }
            
            if ( node.type == "End" )
            {
                continue;
            }
            
            nodeforward = anglestoforward( ( 0, node.angles[ 1 ], 0 ) );
            turretforward = anglestoforward( ( 0, turret.angles[ 1 ], 0 ) );
            dot = vectordot( nodeforward, turretforward );
            
            if ( dot < 0.9 )
            {
                continue;
            }
            
            unclaimed = array_remove( unclaimed, turret );
            node.turret = turret;
            turret.node = node;
            turret.issetup = 1;
            assertex( isdefined( turret.export ), "Turret at " + turret.origin + " does not have a .export value but is near a cover node. If you do not want them to link, use .script_dont_link_turret." );
        }
    }
    
    /#
        if ( unclaimed.size )
        {
            println( "<dev string:x8b>" );
            println( "<dev string:xd6>" );
            
            foreach ( u in unclaimed )
            {
                println( u.origin );
            }
            
            assertex( 0, "<dev string:x125>" );
        }
    #/
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x3476
// Size: 0x15c
function save_turret_sharing_info()
{
    self.shared_turrets = [];
    self.shared_turrets[ "connected" ] = [];
    self.shared_turrets[ "ambush" ] = [];
    
    if ( !isdefined( self.export ) )
    {
        assertex( !isdefined( self.script_turret_share ), "Turret at " + self.origin + " has script_turret_share but has no .export value, so script_turret_share won't have any effect." );
        assertex( !isdefined( self.script_turret_ambush ), "Turret at " + self.origin + " has script_turret_ambush but has no .export value, so script_turret_ambush won't have any effect." );
        return;
    }
    
    if ( !isdefined( level.shared_portable_turrets ) )
    {
        level.shared_portable_turrets = [];
    }
    
    level.shared_portable_turrets[ self.export ] = self;
    
    if ( isdefined( self.script_turret_share ) )
    {
        strings = strtok( self.script_turret_share, " " );
        
        for ( i = 0; i < strings.size ; i++ )
        {
            self.shared_turrets[ "connected" ][ strings[ i ] ] = 1;
        }
    }
    
    if ( isdefined( self.script_turret_ambush ) )
    {
        strings = strtok( self.script_turret_ambush, " " );
        
        for ( i = 0; i < strings.size ; i++ )
        {
            self.shared_turrets[ "ambush" ][ strings[ i ] ] = 1;
        }
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x35da
// Size: 0x23
function restoredefaultpitch()
{
    self notify( "gun_placed_again" );
    self endon( "gun_placed_again" );
    self waittill( "restore_default_drop_pitch" );
    wait 1;
    self restoredefaultdroppitch();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x3605
// Size: 0xa
function dropturret()
{
    thread dropturretproc();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x3617
// Size: 0xc6
function dropturretproc()
{
    turret = spawn( "script_model", ( 0, 0, 0 ) );
    turret.origin = self gettagorigin( level.portable_mg_gun_tag );
    turret.angles = self gettagangles( level.portable_mg_gun_tag );
    turret setmodel( self.turretmodel );
    forward = anglestoforward( self.angles );
    forward *= 100;
    turret movegravity( forward, 0.5 );
    self detach( self.turretmodel, level.portable_mg_gun_tag );
    self.turretmodel = undefined;
    wait 0.7;
    turret delete();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x36e5
// Size: 0x25
function turretdeathdetacher()
{
    self endon( "kill_turret_detach_thread" );
    self endon( "dropped_gun" );
    self waittill( "death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    dropturret();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x3712
// Size: 0x31
function turretdetacher()
{
    self endon( "death" );
    self endon( "kill_turret_detach_thread" );
    self waittill( "dropped_gun" );
    self detach( self.turretmodel, level.portable_mg_gun_tag );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x374b
// Size: 0xc
function restoredefaults()
{
    self.run_overrideanim = undefined;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x375f
// Size: 0x11
function restorepitch()
{
    self waittill( "turret_deactivate" );
    self restoredefaultdroppitch();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x3778
// Size: 0x40
function update_enemy_target_pos_while_running( ent )
{
    self endon( "death" );
    self endon( "end_mg_behavior" );
    self endon( "stop_updating_enemy_target_pos" );
    
    for ( ;; )
    {
        self waittill( "saw_enemy" );
        ent.origin = self.last_enemy_sighting_position;
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 2
// Checksum 0x0, Offset: 0x37c0
// Size: 0xe7
function move_target_pos_to_new_turrets_visibility( ent, new_spot )
{
    self endon( "death" );
    self endon( "end_mg_behavior" );
    self endon( "stop_updating_enemy_target_pos" );
    var_aac5742af70fc90 = self.turret.origin + ( 0, 0, 16 );
    dest_pos = new_spot.origin + ( 0, 0, 16 );
    
    for ( ;; )
    {
        wait 0.05;
        
        if ( sighttracepassed( ent.origin, dest_pos, 0, undefined ) )
        {
            continue;
        }
        
        angles = vectortoangles( var_aac5742af70fc90 - ent.origin );
        forward = anglestoforward( angles );
        forward *= 8;
        ent.origin += forward;
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x38af
// Size: 0x66
function record_bread_crumbs_for_ambush( ent )
{
    self endon( "death" );
    self endon( "end_mg_behavior" );
    self endon( "stop_updating_enemy_target_pos" );
    ent.bread_crumbs = [];
    
    for ( ;; )
    {
        ent.bread_crumbs[ ent.bread_crumbs.size ] = self.origin + ( 0, 0, 50 );
        wait 0.35;
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 2
// Checksum 0x0, Offset: 0x391d
// Size: 0x10c
function aim_turret_at_ambush_point_or_visible_enemy( turret, ent )
{
    if ( !isalive( self.current_enemy ) && self cansee( self.current_enemy ) )
    {
        ent.origin = self.last_enemy_sighting_position;
        return;
    }
    
    forward = anglestoforward( turret.angles );
    
    for ( i = ent.bread_crumbs.size - 3; i >= 0 ; i-- )
    {
        crumb = ent.bread_crumbs[ i ];
        normal = vectornormalize( crumb - turret.origin );
        dot = vectordot( forward, normal );
        
        if ( dot < 0.75 )
        {
            continue;
        }
        
        ent.origin = crumb;
        
        if ( sighttracepassed( turret.origin, crumb, 0, undefined ) )
        {
            continue;
        }
        
        break;
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x3a31
// Size: 0xc1
function find_a_new_turret_spot( ent )
{
    array = get_portable_mg_spot( ent );
    new_spot = array[ "spot" ];
    connection_type = array[ "type" ];
    
    if ( !isdefined( new_spot ) )
    {
        return;
    }
    
    reserve_turret( new_spot );
    thread update_enemy_target_pos_while_running( ent );
    thread move_target_pos_to_new_turrets_visibility( ent, new_spot );
    
    if ( connection_type == "ambush" )
    {
        thread record_bread_crumbs_for_ambush( ent );
    }
    
    if ( new_spot.issetup )
    {
        leave_gun_and_run_to_new_spot( new_spot );
    }
    else
    {
        pickup_gun( new_spot );
        run_to_new_spot_and_setup_gun( new_spot );
    }
    
    self notify( "stop_updating_enemy_target_pos" );
    
    if ( connection_type == "ambush" )
    {
        aim_turret_at_ambush_point_or_visible_enemy( new_spot, ent );
    }
    
    new_spot settargetentity( ent );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x3afa
// Size: 0x29
function snap_lock_turret_onto_target( turret )
{
    turret setmode( "manual" );
    wait 0.5;
    turret setmode( "manual_ai" );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x3b2b
// Size: 0xbb
function leave_gun_and_run_to_new_spot( spot )
{
    assert( spot.reserved == self );
    self stopuseturret();
    scripts\anim\shared::placeweaponon( self.primaryweapon, "none" );
    setup_anim = get_turret_setup_anim( spot );
    org = getstartorigin( spot.origin, spot.angles, setup_anim );
    assertmsg( "this turret functionality is no longer supported. query your local neighborhood ai programmer for details." );
    assertex( distance( org, self.goalpos ) < self.goalradius, "Tried to set the run pos outside the goalradius" );
    self waittill( "runto_arrived" );
    use_the_turret( spot );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x3bee
// Size: 0x22
function pickup_gun( spot )
{
    self stopuseturret();
    self.turret hide_turret();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x3c18
// Size: 0x69
function get_turret_setup_anim( turret )
{
    spot_types = [];
    spot_types[ "saw_bipod_stand" ] = level.mg_animmg[ "bipod_stand_setup" ];
    spot_types[ "saw_bipod_crouch" ] = level.mg_animmg[ "bipod_crouch_setup" ];
    spot_types[ "saw_bipod_prone" ] = level.mg_animmg[ "bipod_prone_setup" ];
    return spot_types[ turret.weaponinfo ];
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x3c8a
// Size: 0x234
function run_to_new_spot_and_setup_gun( spot )
{
    assert( spot.reserved == self );
    oldhealth = self.health;
    spot endon( "turret_deactivate" );
    self.mg42 = spot;
    self endon( "death" );
    self endon( "dropped_gun" );
    setup_anim = get_turret_setup_anim( spot );
    self.turretmodel = "weapon_mg42_carry";
    self notify( "kill_get_gun_back_on_killanimscript_thread" );
    scripts\anim\shared::placeweaponon( self.weapon, "none" );
    
    if ( self isbadguy() )
    {
        self.health = 1;
    }
    
    self attach( self.turretmodel, level.portable_mg_gun_tag );
    thread turretdeathdetacher();
    org = getstartorigin( spot.origin, spot.angles, setup_anim );
    assertmsg( "this turret functionality is no longer supported. query your local neighborhood ai programmer for details." );
    assertex( distance( org, self.goalpos ) < self.goalradius, "Tried to set the run pos outside the goalradius" );
    wait 0.05;
    clear_exception( "move" );
    set_exception( "cover_crouch", &hold_indefintely );
    assertmsg( "this turret functionality is no longer supported. query your local neighborhood ai programmer for details." );
    
    while ( distance( self.origin, org ) > 16 )
    {
        wait 0.05;
    }
    
    self notify( "kill_turret_detach_thread" );
    
    if ( self isbadguy() )
    {
        self.health = oldhealth;
    }
    
    if ( soundexists( "weapon_setup" ) )
    {
        playsoundatpos( self.origin, "weapon_setup" );
    }
    
    self animscripted( "setup_done", spot.origin, spot.angles, setup_anim );
    restoredefaults();
    self waittillmatch( "setup_done", "end" );
    spot notify( "restore_default_drop_pitch" );
    spot show_turret();
    scripts\anim\shared::placeweaponon( self.primaryweapon, "right" );
    use_the_turret( spot );
    self detach( self.turretmodel, level.portable_mg_gun_tag );
    self notify( "bcs_portable_turret_setup" );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x3ec6
// Size: 0x11
function hold_indefintely()
{
    self endon( "killanimscript" );
    self waittill( "death" );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x3edf
// Size: 0x26, Type: bool
function using_a_turret()
{
    if ( !isdefined( self.turret ) )
    {
        return false;
    }
    
    return self.turret.owner == self;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x3f0e
// Size: 0x13a
function turret_user_moves()
{
    if ( !using_a_turret() )
    {
        clear_exception( "move" );
        return;
    }
    
    array = find_connected_turrets( "connected" );
    new_spots = array[ "spots" ];
    
    if ( !new_spots.size )
    {
        clear_exception( "move" );
        return;
    }
    
    turret_node = self.node;
    
    if ( !isdefined( turret_node ) || !array_contains( new_spots, turret_node ) )
    {
        taken_nodes = gettakennodes();
        
        for ( i = 0; i < new_spots.size ; i++ )
        {
            turret_node = random( new_spots );
            
            if ( isdefined( taken_nodes[ turret_node.origin + "" ] ) )
            {
                return;
            }
        }
    }
    
    turret = turret_node.turret;
    
    if ( isdefined( turret.reserved ) )
    {
        assert( turret.reserved != self );
        return;
    }
    
    reserve_turret( turret );
    
    if ( turret.issetup )
    {
        leave_gun_and_run_to_new_spot( turret );
    }
    else
    {
        run_to_new_spot_and_setup_gun( turret );
    }
    
    scripts\sp\mg_penetration::gunner_think( turret_node.turret );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x4050
// Size: 0x80
function use_the_turret( spot )
{
    turretwasused = self useturret( spot );
    
    if ( turretwasused )
    {
        set_exception( "move", &turret_user_moves );
        self.turret = spot;
        thread mg42_firing( spot );
        spot setmode( "manual_ai" );
        spot thread restorepitch();
        self.turret = spot;
        spot.owner = self;
        return 1;
    }
    
    spot restoredefaultdroppitch();
    return 0;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x40d8
// Size: 0x83
function get_portable_mg_spot( ent )
{
    var_7e9cce41ba25c33b = [];
    var_7e9cce41ba25c33b[ var_7e9cce41ba25c33b.size ] = &find_different_way_to_attack_last_seen_position;
    var_7e9cce41ba25c33b[ var_7e9cce41ba25c33b.size ] = &find_good_ambush_spot;
    var_7e9cce41ba25c33b = array_randomize( var_7e9cce41ba25c33b );
    
    for ( i = 0; i < var_7e9cce41ba25c33b.size ; i++ )
    {
        array = [[ var_7e9cce41ba25c33b[ i ] ]]( ent );
        
        if ( !isdefined( array[ "spots" ] ) )
        {
            continue;
        }
        
        array[ "spot" ] = random( array[ "spots" ] );
        return array;
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x4163
// Size: 0x6e
function gettakennodes()
{
    array = [];
    ai = getaiarray();
    
    for ( i = 0; i < ai.size ; i++ )
    {
        if ( !isdefined( ai[ i ].node ) )
        {
            continue;
        }
        
        array[ ai[ i ].node.origin + "" ] = 1;
    }
    
    return array;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x41da
// Size: 0x190
function find_connected_turrets( connection_type )
{
    spots = level.shared_portable_turrets;
    usable_spots = [];
    spot_exports = getarraykeys( spots );
    taken_nodes = gettakennodes();
    taken_nodes[ self.node.origin + "" ] = undefined;
    
    for ( i = 0; i < spot_exports.size ; i++ )
    {
        export = spot_exports[ i ];
        
        if ( spots[ export ] == self.turret )
        {
            continue;
        }
        
        keys = getarraykeys( self.turret.shared_turrets[ connection_type ] );
        
        for ( p = 0; p < keys.size ; p++ )
        {
            if ( spots[ export ].export + "" != keys[ p ] )
            {
                continue;
            }
            
            if ( isdefined( spots[ export ].reserved ) )
            {
                continue;
            }
            
            if ( isdefined( taken_nodes[ spots[ export ].node.origin + "" ] ) )
            {
                continue;
            }
            
            if ( distance( self.goalpos, spots[ export ].origin ) > self.goalradius )
            {
                continue;
            }
            
            usable_spots[ usable_spots.size ] = spots[ export ];
        }
    }
    
    array = [];
    array[ "type" ] = connection_type;
    array[ "spots" ] = usable_spots;
    return array;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x4373
// Size: 0x16
function find_good_ambush_spot( ent )
{
    return find_connected_turrets( "ambush" );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x4392
// Size: 0xd9
function find_different_way_to_attack_last_seen_position( ent )
{
    array = find_connected_turrets( "connected" );
    usable_spots = array[ "spots" ];
    
    if ( !usable_spots.size )
    {
        return;
    }
    
    good_spot = [];
    
    for ( i = 0; i < usable_spots.size ; i++ )
    {
        if ( !within_fov( usable_spots[ i ].origin, usable_spots[ i ].angles, ent.origin, 0.75 ) )
        {
            continue;
        }
        
        if ( !sighttracepassed( ent.origin, usable_spots[ i ].origin + ( 0, 0, 16 ), 0, undefined ) )
        {
            continue;
        }
        
        good_spot[ good_spot.size ] = usable_spots[ i ];
    }
    
    array[ "spots" ] = good_spot;
    return array;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x4474
// Size: 0x63
function portable_mg_spot()
{
    save_turret_sharing_info();
    var_d43aef2c94b7d080 = 1;
    self.issetup = 1;
    assert( !isdefined( self.reserved ) );
    self.reserved = undefined;
    
    if ( isdefined( self.isvehicleattached ) )
    {
        return;
    }
    
    if ( self.spawnflags & var_d43aef2c94b7d080 )
    {
        return;
    }
    
    hide_turret();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x44df
// Size: 0x4e
function hide_turret()
{
    assert( self.issetup );
    self notify( "stop_checking_for_flanking" );
    self.issetup = 0;
    self hide();
    self.solid = 0;
    self makeunusable();
    self setdefaultdroppitch( 0 );
    thread restoredefaultpitch();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x4535
// Size: 0x41
function show_turret()
{
    self show();
    self.solid = 1;
    self makeusable();
    assert( !self.issetup );
    self.issetup = 1;
    thread stop_mg_behavior_if_flanked();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x457e
// Size: 0x32
function stop_mg_behavior_if_flanked()
{
    self endon( "stop_checking_for_flanking" );
    self waittill( "turret_deactivate" );
    
    if ( isalive( self.owner ) )
    {
        self.owner notify( "end_mg_behavior" );
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x45b8
// Size: 0x26, Type: bool
function turret_is_mine( turret )
{
    owner = turret getturretowner();
    
    if ( !isdefined( owner ) )
    {
        return false;
    }
    
    return owner == self;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x45e7
// Size: 0x1e
function end_turret_reservation( turret )
{
    waittill_turret_is_released( turret );
    turret.reserved = undefined;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x460d
// Size: 0x21
function waittill_turret_is_released( turret )
{
    turret endon( "turret_deactivate" );
    self endon( "death" );
    self waittill( "end_mg_behavior" );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x4636
// Size: 0x21
function reserve_turret( turret )
{
    turret.reserved = self;
    thread end_turret_reservation( turret );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x465f
// Size: 0x18
function zuluinit()
{
    thread turret_watchplayeruse( turret_getplayerusefuncs() );
    thread turret_impactquakes();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x467f
// Size: 0x2d
function turret_impactquakes()
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "missile_fire", missile );
        missile thread missile_explode_quakes();
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x46b4
// Size: 0x35
function missile_explode_quakes()
{
    self waittill( "explode", position );
    earthquake( 0.18, 0.75, position, 500 );
    playrumbleonposition( "artillery_rumble_light", position );
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x46f1
// Size: 0x3f
function turret_getplayerusefuncs()
{
    usefuncs = spawnstruct();
    usefuncs.startfuncs = [ &turretplayerstartfunc ];
    usefuncs.stopfuncs = [ &turretplayerstopfunc ];
    return usefuncs;
}

// Namespace mgturret / scripts\sp\mgturret
// Params 1
// Checksum 0x0, Offset: 0x4739
// Size: 0x100
function turret_watchplayeruse( usefuncs )
{
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "turretownerchange" );
        turretowner = self getturretowner();
        
        if ( isdefined( turretowner ) && isplayer( turretowner ) )
        {
            foreach ( startfunc in usefuncs.startfuncs )
            {
                self thread [[ startfunc ]]();
            }
            
            turretowner notify( "turret_mount" );
            self waittill( "turretownerchange" );
            
            foreach ( stopfunc in usefuncs.stopfuncs )
            {
                self thread [[ stopfunc ]]();
            }
            
            turretowner notify( "turret_dismount" );
        }
    }
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x4841
// Size: 0x58
function turretplayerstartfunc()
{
    self.ogplayerweapon = level.player getcurrentweapon();
    level.player giveweapon( self.weaponinfo );
    level.player switchtoweaponimmediate( self.weaponinfo );
    level.player hideviewmodel();
}

// Namespace mgturret / scripts\sp\mgturret
// Params 0
// Checksum 0x0, Offset: 0x48a1
// Size: 0x4e
function turretplayerstopfunc()
{
    level.player takeweapon( self.weaponinfo );
    
    if ( isdefined( self.ogplayerweapon ) )
    {
        level.player switchtoweaponimmediate( self.ogplayerweapon );
    }
    
    level.player showviewmodel();
}

