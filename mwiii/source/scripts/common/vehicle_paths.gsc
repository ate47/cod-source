#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_lights;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace vehicle_paths;

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 1
// Checksum 0x0, Offset: 0x453
// Size: 0x92
function gopath( vehicle )
{
    if ( !isdefined( vehicle ) )
    {
        vehicle = self;
        assertex( self.code_classname == "<dev string:x1c>", "<dev string:x2e>" );
    }
    
    vehicle endon( "death" );
    
    if ( isdefined( vehicle.hasstarted ) )
    {
        println( "<dev string:x55>" );
        return;
    }
    else
    {
        vehicle.hasstarted = 1;
    }
    
    vehicle script_delay();
    vehicle notify( "start_vehiclepath" );
    
    if ( vehicle ishelicopter() )
    {
        vehicle notify( "start_dynamicpath" );
        return;
    }
    
    vehicle startpath();
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 3
// Checksum 0x0, Offset: 0x4ed
// Size: 0x39
function _vehicle_paths( node, var_269fb0ec10b51524, var_cfa3aafb71b08d36 )
{
    if ( ishelicopter() )
    {
        vehicle_paths_helicopter( node, var_269fb0ec10b51524, var_cfa3aafb71b08d36 );
        return;
    }
    
    vehicle_paths_non_heli( node );
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 1
// Checksum 0x0, Offset: 0x52e
// Size: 0x285
function trigger_process_node( node )
{
    if ( isdefined( node.script_flag_set ) )
    {
        flag_set( node.script_flag_set );
    }
    
    if ( isdefined( node.script_flag_clear ) )
    {
        flag_clear( node.script_flag_clear );
    }
    
    if ( isdefined( node.script_prefab_exploder ) )
    {
        node.script_exploder = node.script_prefab_exploder;
        node.script_prefab_exploder = undefined;
    }
    
    if ( isdefined( node.script_exploder ) )
    {
        delay = node.script_exploder_delay;
        
        if ( isdefined( delay ) )
        {
            level delaythread( delay, &exploder, node.script_exploder );
        }
        else
        {
            level exploder( node.script_exploder );
        }
    }
    
    if ( isdefined( node.script_flag_set ) )
    {
        flag_set( node.script_flag_set );
    }
    
    if ( isdefined( node.script_ent_flag_set ) )
    {
        ent_flag_set( node.script_ent_flag_set );
    }
    
    if ( isdefined( node.script_ent_flag_clear ) )
    {
        ent_flag_clear( node.script_ent_flag_clear );
    }
    
    if ( isdefined( node.script_flag_clear ) )
    {
        flag_clear( node.script_flag_clear );
    }
    
    if ( isdefined( node.script_noteworthy ) )
    {
        if ( node.script_noteworthy == "deleteme" )
        {
            if ( isdefined( self.deathfunc ) )
            {
                delete_riders();
                level thread [[ self.deathfunc ]]( self );
                return;
            }
            else
            {
                scripts\common\vehicle_code::vehicle_deathcleanup();
                delete_riders();
                self delete();
                return;
            }
        }
        else if ( node.script_noteworthy == "engineoff" )
        {
            self vehicle_turnengineoff();
            self notify( "engineoff" );
        }
        else
        {
            self notify( node.script_noteworthy );
            self notify( "noteworthy", node.script_noteworthy );
        }
    }
    
    if ( isdefined( node.script_badplace ) )
    {
        self.script_badplace = node.script_badplace;
    }
    
    if ( isdefined( node.script_turretmg ) )
    {
        if ( node.script_turretmg )
        {
            _mgon();
        }
        else
        {
            _mgoff();
        }
    }
    
    if ( isdefined( node.script_turretmain ) )
    {
        if ( node.script_turretmain )
        {
            _mainturreton();
            return;
        }
        
        _mainturretoff();
    }
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 0
// Checksum 0x0, Offset: 0x7bb
// Size: 0x116
function delete_riders()
{
    if ( isdefined( self.riders ) )
    {
        foreach ( g in self.riders )
        {
            if ( isdefined( g ) )
            {
                if ( isdefined( g.magic_bullet_shield ) )
                {
                    g scripts\common\ai::stop_magic_bullet_shield();
                }
                
                if ( !issp() && isai( g ) )
                {
                    if ( !isalive( g ) )
                    {
                        if ( issharedfuncdefined( "ai", "getCorpseEntity" ) )
                        {
                            body = g callsharedfunc( "ai", "getCorpseEntity" );
                            
                            if ( isdefined( body ) && !isint( body ) )
                            {
                                body delete();
                            }
                        }
                    }
                    else
                    {
                        g.var_f543095c3ca1b743 = 1;
                        g.diequietly = 1;
                        g.nocorpse = 1;
                        g kill();
                    }
                    
                    continue;
                }
                
                g delete();
            }
        }
    }
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 1
// Checksum 0x0, Offset: 0x8d9
// Size: 0x51, Type: bool
function islastnode( node )
{
    if ( !isdefined( node.target ) )
    {
        return true;
    }
    
    if ( !isdefined( getvehiclenode( node.target, "targetname" ) ) && !isdefined( get_vehiclenode_any_dynamic( node.target ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 2
// Checksum 0x0, Offset: 0x933
// Size: 0x8b, Type: bool
function vehicle_should_unload( wait_func, nextpoint )
{
    if ( isdefined( nextpoint.script_unload ) )
    {
        return true;
    }
    
    if ( wait_func != &node_wait )
    {
        return false;
    }
    
    if ( !islastnode( nextpoint ) )
    {
        return false;
    }
    
    if ( istrue( self.dontunloadonend ) )
    {
        return false;
    }
    
    if ( self.vehicletype == "empty" || self.vehicletype == "empty_heli" )
    {
        return false;
    }
    
    return !( isdefined( self.script_vehicle_selfremove ) && self.script_vehicle_selfremove );
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 1
// Checksum 0x0, Offset: 0x9c7
// Size: 0x7a
function overshoot_next_node( vnode )
{
    /#
        if ( !isdefined( vnode ) )
        {
            return;
        }
        
        self endon( "<dev string:x8f>" );
        vnode waittillmatch( "<dev string:x9f>", self );
        println( "<dev string:xaa>" );
        println( "<dev string:x106>" );
        println( "<dev string:xaa>" );
        println( "<dev string:x162>" + vnode.origin + "<dev string:x192>" );
        println( "<dev string:x1b6>" );
        println( "<dev string:xaa>" );
    #/
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 0
// Checksum 0x0, Offset: 0xa49
// Size: 0x7a
function vehicle_resumepathvehicle()
{
    if ( !ishelicopter() )
    {
        self resumespeed( 35 );
        return;
    }
    
    node = undefined;
    
    if ( isdefined( self.currentnode.target ) && !isdefined( self.currentnode.exit_node ) )
    {
        node = get_vehiclenode_any_dynamic( self.currentnode.target );
    }
    
    if ( !isdefined( node ) )
    {
        return;
    }
    
    _vehicle_paths( node );
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 1
// Checksum 0x0, Offset: 0xacb
// Size: 0xd4
function get_path_getfunc( pathpoint )
{
    get_func = &get_from_vehicle_node;
    
    if ( isdefined( pathpoint.target ) && isstruct( pathpoint.target ) )
    {
        get_func = &function_98c0327a3d5ce1c;
    }
    else if ( ishelicopter() && isdefined( pathpoint.target ) )
    {
        if ( isdefined( get_from_entity( pathpoint.target ) ) )
        {
            get_func = &get_from_entity;
        }
        
        if ( isdefined( get_from_spawnstruct( pathpoint.target ) ) )
        {
            get_func = &get_from_spawnstruct;
        }
    }
    else if ( !issp() && isdefined( pathpoint.target ) )
    {
        if ( isdefined( get_from_spawnstruct( pathpoint.target ) ) )
        {
            get_func = &get_from_spawnstruct;
        }
    }
    
    return get_func;
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 3
// Checksum 0x0, Offset: 0xba8
// Size: 0xe0
function struct_wait( nextpoint, lastpoint, dist_sq )
{
    if ( !isdefined( lastpoint ) )
    {
        lastpoint = nextpoint;
    }
    
    wait 0.05;
    
    if ( isdefined( lastpoint.speed ) && lastpoint.speed >= 0 )
    {
        self vehicledriveto( nextpoint.origin, int( lastpoint.speed ) );
        
        while ( distancesquared( self.origin, nextpoint.origin ) > dist_sq )
        {
            wait 0.1;
            
            if ( utility::iscp() )
            {
                self vehicle_setspeedimmediate( lastpoint.speed, 15, 15 );
            }
        }
        
        return;
    }
    
    if ( isdefined( lastpoint.speed ) && lastpoint.speed < 0 )
    {
        self vehicle_setspeedimmediate( 0, 15, 15 );
    }
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 3
// Checksum 0x0, Offset: 0xc90
// Size: 0x8d
function node_wait( nextpoint, lastpoint, get_func )
{
    if ( isdefined( self.unique_id ) )
    {
        nodeflag = "node_flag_triggered" + self.unique_id;
    }
    else
    {
        nodeflag = "node_flag_triggered";
    }
    
    nodes_flag_triggered( nodeflag, nextpoint, get_func );
    
    if ( self.attachedpath == nextpoint )
    {
        self notify( "node_wait_terminated" );
        waittillframeend();
        return;
    }
    
    nextpoint ent_flag_wait_vehicle_node( nodeflag );
    nextpoint ent_flag_clear( nodeflag, 1 );
    nextpoint notify( "processed_node" + nodeflag );
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 3
// Checksum 0x0, Offset: 0xd25
// Size: 0x65
function nodes_flag_triggered( nodeflag, nextpoint, get_func )
{
    count = 0;
    
    while ( isdefined( nextpoint ) && count < 3 )
    {
        count++;
        thread node_flag_triggered( nodeflag, nextpoint );
        
        if ( !isdefined( nextpoint.target ) )
        {
            return;
        }
        
        nextpoint = [[ get_func ]]( nextpoint.target );
    }
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 2
// Checksum 0x0, Offset: 0xd92
// Size: 0x64
function node_flag_triggered( nodeflag, node )
{
    if ( node ent_flag_exist( nodeflag ) )
    {
        return;
    }
    
    node ent_flag_init( nodeflag );
    thread node_flag_triggered_cleanup( node, nodeflag );
    node endon( "processed_node" + nodeflag );
    self endon( "death" );
    self endon( "newpath" );
    self endon( "node_wait_terminated" );
    node waittillmatch( "trigger", self );
    node ent_flag_set( nodeflag );
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 2
// Checksum 0x0, Offset: 0xdfe
// Size: 0x3d
function node_flag_triggered_cleanup( node, nodeflag )
{
    node endon( "processed_node" + nodeflag );
    waittill_any_3( "death", "newpath", "node_wait_terminated" );
    node ent_flag_clear( nodeflag, 1 );
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 1
// Checksum 0x0, Offset: 0xe43
// Size: 0x7e3
function vehicle_paths_non_heli( node )
{
    assertex( isdefined( node ) || isdefined( self.attachedpath ), "<dev string:x211>" );
    self notify( "newpath" );
    
    if ( isdefined( node ) )
    {
        self.attachedpath = node;
    }
    
    pathstart = self.attachedpath;
    self.currentnode = self.attachedpath;
    
    if ( !isdefined( pathstart ) )
    {
        return;
    }
    
    self endon( "newpath" );
    self endon( "death" );
    pathpoint = pathstart;
    lastpoint = undefined;
    nextpoint = pathstart;
    get_func = get_path_getfunc( pathstart );
    dist_sq = 40000;
    
    while ( isdefined( nextpoint ) )
    {
        if ( !isstruct( nextpoint ) )
        {
            node_wait( nextpoint, lastpoint, get_func );
        }
        else
        {
            struct_wait( nextpoint, lastpoint, dist_sq );
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        trigger_process_node( nextpoint );
        self.currentnode = nextpoint;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( isdefined( nextpoint.script_team ) )
        {
            self.script_team = nextpoint.script_team;
        }
        
        if ( isdefined( nextpoint.script_turningdir ) )
        {
            self notify( "turning", nextpoint.script_turningdir );
        }
        
        if ( isdefined( nextpoint.script_deathroll ) )
        {
            if ( nextpoint.script_deathroll == 0 )
            {
                thread deathrolloff();
            }
            else
            {
                thread deathrollon();
            }
        }
        
        if ( isdefined( nextpoint.script_wheeldirection ) )
        {
            vehicle_setwheeldirection( nextpoint.script_wheeldirection );
        }
        
        if ( vehicle_should_unload( &node_wait, nextpoint ) )
        {
            thread unload_node( nextpoint );
        }
        
        if ( isdefined( nextpoint.script_transmission ) )
        {
            self.veh_transmission = nextpoint.script_transmission;
            
            if ( self.veh_transmission == "forward" )
            {
                vehicle_setwheeldirection( 1 );
            }
            else
            {
                vehicle_setwheeldirection( 0 );
            }
        }
        
        if ( isdefined( nextpoint.script_brake ) )
        {
            self.veh_brake = nextpoint.script_brake;
            
            if ( self vehicle_isphysveh() )
            {
                self vehphys_parkingbrake( 1 );
            }
        }
        
        if ( isdefined( nextpoint.script_pathtype ) )
        {
            self.veh_pathtype = nextpoint.script_pathtype;
        }
        
        if ( isdefined( nextpoint.script_speed ) )
        {
            accel = undefined;
            
            if ( isdefined( nextpoint.script_accel ) )
            {
                accel = nextpoint.script_accel;
            }
            
            decel = undefined;
            
            if ( isdefined( nextpoint.script_decel ) )
            {
                decel = nextpoint.script_decel;
            }
            
            self vehicle_setspeed( nextpoint.script_speed, accel, decel );
        }
        
        if ( isdefined( nextpoint.script_ent_flag_wait ) && !ent_flag( nextpoint.script_ent_flag_wait ) )
        {
            if ( isdefined( nextpoint.script_decel ) )
            {
                decel = nextpoint.script_decel;
            }
            else if ( isdefined( nextpoint.target ) )
            {
                stoppoint = [[ get_func ]]( nextpoint.target );
                distance = distance( nextpoint.origin, stoppoint.origin ) * 0.0568182;
                speed = self vehicle_getspeed();
                decel = squared( speed ) / 2 * distance;
            }
            else
            {
                decel = 20;
            }
            
            self vehicle_setspeed( 0, decel, decel );
            childthread vehicle_notifyonstop();
            ent_flag_wait( nextpoint.script_ent_flag_wait );
            
            if ( !isdefined( self ) )
            {
                return;
            }
            
            accel = 60;
            
            if ( isdefined( nextpoint.script_accel ) )
            {
                accel = nextpoint.script_accel;
            }
            
            self notify( "resumed_path" );
            self resumespeed( accel );
        }
        
        if ( isdefined( nextpoint.script_delay ) )
        {
            decel = 20;
            
            if ( isdefined( nextpoint.script_decel ) )
            {
                decel = nextpoint.script_decel;
            }
            
            self vehicle_setspeed( 0, decel );
            childthread vehicle_notifyonstop();
            
            if ( isdefined( nextpoint.target ) )
            {
                childthread overshoot_next_node( [[ get_func ]]( nextpoint.target ) );
            }
            
            nextpoint script_delay();
            self notify( "delay_passed" );
            accel = 60;
            
            if ( isdefined( nextpoint.script_accel ) )
            {
                accel = nextpoint.script_accel;
            }
            
            self notify( "resumed_path" );
            self resumespeed( accel );
        }
        
        if ( isdefined( nextpoint.script_flag_wait ) || isdefined( nextpoint.script_flag_waitopen ) )
        {
            was_stopped = 0;
            var_5b62e4fc3021a9a7 = isdefined( nextpoint.script_flag_wait ) && !flag( nextpoint.script_flag_wait );
            var_d54eec4cdd1d8fab = isdefined( nextpoint.script_flag_waitopen ) && flag( nextpoint.script_flag_waitopen );
            stopped_msg = undefined;
            
            if ( var_5b62e4fc3021a9a7 || var_d54eec4cdd1d8fab || isdefined( nextpoint.script_delay_post ) )
            {
                was_stopped = 1;
                accel = 5;
                decel = 20;
                
                if ( isdefined( nextpoint.script_accel ) )
                {
                    accel = nextpoint.script_accel;
                }
                
                if ( isdefined( nextpoint.script_decel ) )
                {
                    decel = nextpoint.script_decel;
                }
                
                if ( var_5b62e4fc3021a9a7 )
                {
                    stopped_msg = "script_flag_wait_" + nextpoint.script_flag_wait;
                }
                else if ( var_d54eec4cdd1d8fab )
                {
                    stopped_msg = "script_flag_waitopen_" + nextpoint.script_flag_waitopen;
                }
                else if ( isdefined( nextpoint.script_flag_wait ) )
                {
                    stopped_msg = "script_delay_post_" + nextpoint.script_flag_wait;
                }
                else
                {
                    stopped_msg = "script_delay_post_" + nextpoint.script_flag_waitopen;
                }
                
                _vehicle_stop_named( stopped_msg, accel, decel );
                childthread vehicle_notifyonstop();
                
                if ( isdefined( nextpoint.target ) )
                {
                    childthread overshoot_next_node( [[ get_func ]]( nextpoint.target ) );
                }
            }
            
            if ( var_5b62e4fc3021a9a7 )
            {
                flag_wait( nextpoint.script_flag_wait );
            }
            
            if ( var_d54eec4cdd1d8fab )
            {
                flag_waitopen( nextpoint.script_flag_waitopen );
            }
            
            if ( !isdefined( self ) )
            {
                return;
            }
            
            if ( isdefined( nextpoint.script_delay_post ) )
            {
                wait nextpoint.script_delay_post;
                
                if ( !isdefined( self ) )
                {
                    return;
                }
            }
            
            accel = 10;
            
            if ( isdefined( nextpoint.script_accel ) )
            {
                accel = nextpoint.script_accel;
            }
            
            if ( was_stopped )
            {
                self notify( "resumed_path" );
                _vehicle_resume_named( stopped_msg );
            }
            
            self notify( "delay_passed" );
        }
        
        if ( isdefined( self.set_lookat_point ) )
        {
            self.set_lookat_point = undefined;
            self clearlookatent();
        }
        
        if ( isdefined( nextpoint.script_vehicle_lights_off ) )
        {
            thread lights_off( nextpoint.script_vehicle_lights_off );
        }
        
        if ( isdefined( nextpoint.script_vehicle_lights_on ) )
        {
            thread lights_on( nextpoint.script_vehicle_lights_on );
        }
        
        if ( isdefined( nextpoint.script_forcecolor ) )
        {
            thread script_func( "forcecolor_riders", nextpoint.script_forcecolor );
        }
        
        lastpoint = nextpoint;
        
        if ( !isdefined( nextpoint.target ) )
        {
            break;
        }
        
        nextpoint = [[ get_func ]]( nextpoint.target );
        
        if ( !isdefined( nextpoint ) )
        {
            nextpoint = lastpoint;
            assertmsg( "<dev string:x239>" + lastpoint.origin );
            break;
        }
    }
    
    self notify( "reached_dynamic_path_end" );
    
    if ( isdefined( self.script_vehicle_selfremove ) )
    {
        if ( isdefined( self.deathfunc ) )
        {
            delete_riders();
            level thread [[ self.deathfunc ]]( self );
            return;
        }
        
        scripts\common\vehicle_code::vehicle_deathcleanup();
        delete_riders();
        self notify( "delete" );
        self delete();
    }
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 0
// Checksum 0x0, Offset: 0x162e
// Size: 0x2e
function vehicle_notifyonstop()
{
    self endon( "resumed_path" );
    
    while ( vehicle_is_stopped() )
    {
        waitframe();
    }
    
    self setwaitspeed( 0 );
    self waittill( "reached_wait_speed" );
    self notify( "stopped_path" );
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 0
// Checksum 0x0, Offset: 0x1664
// Size: 0xf
function vehicle_waittill_stopped()
{
    while ( !vehicle_is_stopped() )
    {
        waitframe();
    }
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 2
// Checksum 0x0, Offset: 0x167b
// Size: 0x21
function add_z( vec, zplus )
{
    return ( vec[ 0 ], vec[ 1 ], vec[ 2 ] + zplus );
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 3
// Checksum 0x0, Offset: 0x16a5
// Size: 0x442
function vehicle_paths_helicopter( node, var_269fb0ec10b51524, var_cfa3aafb71b08d36 )
{
    if ( self vehicle_isphysveh() )
    {
        if ( self hascomponent( "p2p" ) )
        {
            function_fabc06bb049f87ee( node );
            return;
        }
        else if ( getdvarint( @"hash_31333fbc83a5058f" ) == 0 )
        {
            println( "<dev string:x290>" );
            return;
        }
    }
    
    assertex( isdefined( node ) || isdefined( self.attachedpath ), "<dev string:x211>" );
    self notify( "newpath" );
    self endon( "newpath" );
    self endon( "death" );
    
    if ( !isdefined( var_269fb0ec10b51524 ) )
    {
        var_269fb0ec10b51524 = 0;
    }
    
    if ( isdefined( node ) )
    {
        self.attachedpath = node;
    }
    
    pathstart = self.attachedpath;
    self.currentnode = self.attachedpath;
    
    if ( !isdefined( pathstart ) )
    {
        return;
    }
    
    if ( var_269fb0ec10b51524 )
    {
        self waittill( "start_dynamicpath" );
    }
    
    if ( isdefined( var_cfa3aafb71b08d36 ) )
    {
        elevated_node = spawnstruct();
        elevated_node.origin = add_z( self.origin, var_cfa3aafb71b08d36 );
        heli_wait_node( elevated_node, undefined );
    }
    
    lastpoint = undefined;
    nextpoint = pathstart;
    get_func = get_path_getfunc( pathstart );
    
    while ( isdefined( nextpoint ) )
    {
        if ( isdefined( nextpoint.script_linkto ) )
        {
            set_lookat_from_dest( nextpoint );
        }
        
        if ( isdefined( nextpoint.script_land ) )
        {
            hasnextpoint = 0;
            
            if ( isdefined( nextpoint.target ) )
            {
                hasnextpoint = isdefined( [[ get_func ]]( nextpoint.target ) );
            }
            
            thread vehicle_landanims( nextpoint.script_unload, hasnextpoint );
        }
        
        if ( !isdefined( lastpoint ) )
        {
            if ( isdefined( self.var_918c5a31037e00ee ) )
            {
                lastpoint = self.var_918c5a31037e00ee;
            }
        }
        
        heli_wait_node( nextpoint, lastpoint, var_cfa3aafb71b08d36 );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.currentnode = nextpoint;
        nextpoint notify( "trigger", self );
        
        if ( isdefined( nextpoint.script_helimove ) )
        {
            self setyawspeedbyname( nextpoint.script_helimove );
            
            if ( nextpoint.script_helimove == "faster" )
            {
                self setmaxpitchroll( 25, 50 );
            }
        }
        
        trigger_process_node( nextpoint );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( isdefined( nextpoint.script_team ) )
        {
            self.script_team = nextpoint.script_team;
        }
        
        if ( vehicle_should_unload( &heli_wait_node, nextpoint ) )
        {
            unload_node( nextpoint );
        }
        
        if ( self vehicle_isphysveh() )
        {
            if ( isdefined( nextpoint.script_pathtype ) )
            {
                self.veh_pathtype = nextpoint.script_pathtype;
            }
        }
        
        var_3c7df338d0ac0d9e = 0;
        
        if ( isdefined( nextpoint.script_flag_wait ) )
        {
            var_3c7df338d0ac0d9e = 1;
            flag_wait( nextpoint.script_flag_wait );
        }
        
        if ( isdefined( nextpoint.script_flag_waitopen ) )
        {
            var_3c7df338d0ac0d9e = 1;
            flag_waitopen( nextpoint.script_flag_waitopen );
        }
        
        if ( var_3c7df338d0ac0d9e )
        {
            if ( isdefined( nextpoint.script_delay_post ) )
            {
                wait nextpoint.script_delay_post;
            }
            
            self notify( "delay_passed" );
        }
        
        if ( isdefined( self.set_lookat_point ) )
        {
            self.set_lookat_point = undefined;
            self clearlookatent();
        }
        
        if ( isdefined( nextpoint.script_vehicle_lights_off ) )
        {
            thread lights_off( nextpoint.script_vehicle_lights_off );
        }
        
        if ( isdefined( nextpoint.script_vehicle_lights_on ) )
        {
            thread lights_on( nextpoint.script_vehicle_lights_on );
        }
        
        if ( isdefined( nextpoint.script_forcecolor ) )
        {
            thread script_func( "forcecolor_riders", nextpoint.script_forcecolor );
        }
        
        lastpoint = nextpoint;
        
        if ( !isdefined( nextpoint.target ) )
        {
            break;
        }
        
        nextpoint = [[ get_func ]]( nextpoint.target );
        
        if ( !isdefined( nextpoint ) )
        {
            nextpoint = lastpoint;
            assertmsg( "<dev string:x239>" + lastpoint.origin );
            break;
        }
    }
    
    self notify( "reached_dynamic_path_end" );
    
    if ( isdefined( self.script_vehicle_selfremove ) )
    {
        delete_riders();
        
        if ( isdefined( self.deathfunc ) )
        {
            level thread [[ self.deathfunc ]]( self );
            return;
        }
        
        self delete();
    }
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 3
// Checksum 0x0, Offset: 0x1aef
// Size: 0x4cf
function heli_wait_node( nextpoint, lastpoint, var_cfa3aafb71b08d36 )
{
    self endon( "newpath" );
    
    if ( isdefined( nextpoint.script_unload ) || isdefined( nextpoint.script_land ) )
    {
        unloadoffset = 0;
        
        if ( isdefined( nextpoint.script_land ) )
        {
            ent_flag_set( "landed" );
            
            if ( isdefined( self.unload_land_offset ) )
            {
                unloadoffset = self.unload_land_offset;
            }
        }
        else if ( isdefined( nextpoint.script_unload ) && isdefined( self.unload_hover_offset ) )
        {
            unloadoffset = self.unload_hover_offset;
        }
        else if ( isdefined( nextpoint.script_unload ) && isdefined( self.unload_hover_offset_max ) )
        {
            groundorg = utility::groundpos( nextpoint.origin );
            unloadoffset = nextpoint.origin[ 2 ] - groundorg[ 2 ];
            
            if ( unloadoffset >= self.unload_hover_offset_max )
            {
                unloadoffset = self.unload_hover_offset_max;
            }
            else if ( isdefined( self.unload_hover_land_height ) && unloadoffset < self.unload_hover_land_height )
            {
                unloadoffset = self.unload_hover_land_height;
            }
        }
        
        nextpoint.radius = 2;
        
        if ( isdefined( nextpoint.ground_pos ) )
        {
            nextpoint.origin = nextpoint.ground_pos + ( 0, 0, unloadoffset );
        }
        else
        {
            neworg = utility::groundpos( nextpoint.origin ) + ( 0, 0, unloadoffset );
            
            if ( neworg[ 2 ] > nextpoint.origin[ 2 ] - 2000 )
            {
                nextpoint.origin = utility::groundpos( nextpoint.origin ) + ( 0, 0, unloadoffset );
            }
        }
        
        self sethoverparams( 0, 0, 0 );
    }
    
    if ( isdefined( lastpoint ) )
    {
        airresistance = lastpoint.script_airresistance;
        
        if ( isdefined( airresistance ) )
        {
            airresistance = float( airresistance );
        }
        
        speed = lastpoint.speed;
        accel = lastpoint.script_accel;
        decel = lastpoint.script_decel;
    }
    else
    {
        airresistance = undefined;
        speed = undefined;
        accel = undefined;
        decel = undefined;
    }
    
    stopnode = isdefined( nextpoint.script_stopnode ) && nextpoint.script_stopnode;
    unload = isdefined( nextpoint.script_unload );
    flag_wait = isdefined( nextpoint.script_flag_wait ) && !flag( nextpoint.script_flag_wait );
    flag_wait = flag_wait || isdefined( nextpoint.script_flag_waitopen ) && flag( nextpoint.script_flag_waitopen );
    var_ccf44cff39a902f0 = !isdefined( nextpoint.target );
    hasdelay = isdefined( nextpoint.script_delay );
    
    if ( isdefined( nextpoint.angles ) )
    {
        yaw = nextpoint.angles[ 1 ];
    }
    else
    {
        yaw = 0;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    origin = nextpoint.origin;
    
    if ( isdefined( var_cfa3aafb71b08d36 ) )
    {
        origin = add_z( origin, var_cfa3aafb71b08d36 );
    }
    
    if ( isdefined( self.heliheightoverride ) )
    {
        origin = ( origin[ 0 ], origin[ 1 ], self.heliheightoverride );
    }
    
    self vehicle_helisetai( origin, speed, accel, decel, nextpoint.script_goalyaw, nextpoint.script_anglevehicle, yaw, airresistance, hasdelay, stopnode, unload, flag_wait, var_ccf44cff39a902f0 );
    
    if ( isdefined( nextpoint.radius ) )
    {
        self setneargoalnotifydist( nextpoint.radius );
        assertex( nextpoint.radius > 0, "<dev string:x2e1>" + nextpoint.radius );
        waittill_any_2( "near_goal", "goal" );
    }
    else
    {
        self waittill( "goal" );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    trigger_process_node( nextpoint );
    
    /#
        if ( isdefined( nextpoint.script_flag_set ) )
        {
            self notify( "<dev string:x2ed>", nextpoint, nextpoint.script_flag_set );
        }
        else
        {
            self notify( "<dev string:x2ed>", nextpoint );
        }
    #/
    
    if ( isdefined( nextpoint.script_firelink ) )
    {
        if ( !isdefined( level.helicopter_firelinkfunk ) )
        {
            assertmsg( "<dev string:x305>" );
        }
        
        thread [[ level.helicopter_firelinkfunk ]]( nextpoint );
    }
    
    nextpoint script_delay();
    
    if ( isdefined( self.path_gobbler ) )
    {
        deletestruct_ref( nextpoint );
    }
    
    self notify( "continuepath" );
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 2
// Checksum 0x0, Offset: 0x1fc6
// Size: 0x323
function function_fabc06bb049f87ee( node, var_b1f8b992bf79f2d3 )
{
    assertex( isdefined( node ) || isdefined( self.attachedpath ), "<dev string:x352>" );
    self notify( "newpath" );
    self endon( "newpath" );
    self endon( "death" );
    
    if ( isdefined( node ) )
    {
        self.attachedpath = node;
    }
    
    pathstart = self.attachedpath;
    self.currentnode = self.attachedpath;
    
    if ( !isdefined( pathstart ) )
    {
        return;
    }
    
    lastpoint = undefined;
    nextpoint = pathstart;
    get_func = get_path_getfunc( pathstart );
    
    while ( isdefined( nextpoint ) )
    {
        if ( !isdefined( lastpoint ) )
        {
            if ( isdefined( self.var_918c5a31037e00ee ) )
            {
                lastpoint = self.var_918c5a31037e00ee;
            }
        }
        
        function_2936413eac5d78b1( nextpoint, lastpoint, var_b1f8b992bf79f2d3 );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.currentnode = nextpoint;
        nextpoint notify( "trigger", self );
        
        if ( isdefined( nextpoint.script_helimove ) )
        {
            self setyawspeedbyname( nextpoint.script_helimove );
            
            if ( nextpoint.script_helimove == "faster" )
            {
                self setmaxpitchroll( 25, 50 );
            }
        }
        
        trigger_process_node( nextpoint );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( isdefined( nextpoint.script_team ) )
        {
            self.script_team = nextpoint.script_team;
        }
        
        if ( self vehicle_isphysveh() )
        {
            if ( isdefined( nextpoint.script_pathtype ) )
            {
                self.veh_pathtype = nextpoint.script_pathtype;
            }
        }
        
        var_3c7df338d0ac0d9e = 0;
        
        if ( isdefined( nextpoint.script_flag_wait ) )
        {
            var_3c7df338d0ac0d9e = 1;
            flag_wait( nextpoint.script_flag_wait );
        }
        
        if ( isdefined( nextpoint.script_flag_waitopen ) )
        {
            var_3c7df338d0ac0d9e = 1;
            flag_waitopen( nextpoint.script_flag_waitopen );
        }
        
        if ( var_3c7df338d0ac0d9e )
        {
            if ( isdefined( nextpoint.script_delay_post ) )
            {
                wait nextpoint.script_delay_post;
            }
            
            self notify( "delay_passed" );
        }
        
        if ( isdefined( self.set_lookat_point ) )
        {
            self.set_lookat_point = undefined;
            self clearlookatent();
        }
        
        if ( isdefined( nextpoint.script_vehicle_lights_off ) )
        {
            thread lights_off( nextpoint.script_vehicle_lights_off );
        }
        
        if ( isdefined( nextpoint.script_vehicle_lights_on ) )
        {
            thread lights_on( nextpoint.script_vehicle_lights_on );
        }
        
        if ( isdefined( nextpoint.script_forcecolor ) )
        {
            thread script_func( "forcecolor_riders", nextpoint.script_forcecolor );
        }
        
        lastpoint = nextpoint;
        
        if ( !isdefined( nextpoint.target ) )
        {
            break;
        }
        
        nextpoint = [[ get_func ]]( nextpoint.target );
        
        if ( !isdefined( nextpoint ) )
        {
            nextpoint = lastpoint;
            assertmsg( "<dev string:x239>" + lastpoint.origin );
            break;
        }
    }
    
    self notify( "reached_dynamic_path_end" );
    
    if ( isdefined( self.script_vehicle_selfremove ) )
    {
        delete_riders();
        
        if ( isdefined( self.deathfunc ) )
        {
            level thread [[ self.deathfunc ]]( self );
            return;
        }
        
        self delete();
    }
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 3
// Checksum 0x0, Offset: 0x22f1
// Size: 0x320
function function_2936413eac5d78b1( nextpoint, lastpoint, var_b1f8b992bf79f2d3 )
{
    self endon( "newpath" );
    
    if ( isdefined( nextpoint.script_unload ) || isdefined( nextpoint.script_land ) )
    {
        assertmsg( "<dev string:x38e>" );
    }
    
    if ( isdefined( lastpoint ) )
    {
        airresistance = lastpoint.script_airresistance;
        speed = lastpoint.speed;
        accel = lastpoint.script_accel;
        decel = lastpoint.script_decel;
    }
    else
    {
        airresistance = undefined;
        speed = undefined;
        accel = undefined;
        decel = undefined;
    }
    
    stopnode = isdefined( nextpoint.script_stopnode ) && nextpoint.script_stopnode;
    unload = isdefined( nextpoint.script_unload );
    flag_wait = isdefined( nextpoint.script_flag_wait ) && !flag( nextpoint.script_flag_wait );
    flag_wait = flag_wait || isdefined( nextpoint.script_flag_waitopen ) && flag( nextpoint.script_flag_waitopen );
    var_ccf44cff39a902f0 = !isdefined( nextpoint.target );
    hasdelay = isdefined( nextpoint.script_delay );
    yaw = 0;
    
    if ( isdefined( nextpoint.angles ) )
    {
        yaw = nextpoint.angles[ 1 ];
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    origin = nextpoint.origin;
    
    if ( isdefined( nextpoint.radius ) )
    {
        assertex( nextpoint.radius > 0, "<dev string:x2e1>" + nextpoint.radius );
        self setconfigvalue( "p2p", "goalThreshold", nextpoint.radius );
    }
    
    if ( isdefined( var_b1f8b992bf79f2d3 ) )
    {
        origin = add_z( origin, var_b1f8b992bf79f2d3 );
    }
    
    if ( istrue( self.var_d9ca4757da7a9a6 ) )
    {
        yaw = flat_angle( vectortoangles( origin - self.origin ) )[ 1 ];
    }
    
    self setconfigvalue( "p2p", "goalPoint", origin );
    self setconfigvalue( "p2p", "goalAngles", ( 0, yaw, 0 ) );
    self waittill( "near_goal" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    trigger_process_node( nextpoint );
    
    /#
        if ( isdefined( nextpoint.script_flag_set ) )
        {
            self notify( "<dev string:x2ed>", nextpoint, nextpoint.script_flag_set );
        }
        else
        {
            self notify( "<dev string:x2ed>", nextpoint );
        }
    #/
    
    if ( isdefined( nextpoint.script_firelink ) )
    {
        if ( !isdefined( level.helicopter_firelinkfunk ) )
        {
            assertmsg( "<dev string:x305>" );
        }
        
        thread [[ level.helicopter_firelinkfunk ]]( nextpoint );
    }
    
    nextpoint script_delay();
    
    if ( isdefined( self.path_gobbler ) )
    {
        deletestruct_ref( nextpoint );
    }
    
    self notify( "continuepath" );
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 0
// Checksum 0x0, Offset: 0x2619
// Size: 0xd8
function get_pathstruct()
{
    structs = getstructarray( self.target, "targetname" );
    assertex( structs.size != 0, "<dev string:x3c6>" + self.origin + "<dev string:x3d5>" );
    
    if ( structs.size == 1 )
    {
        return structs[ 0 ];
    }
    
    filtered = [];
    
    foreach ( struct in structs )
    {
        if ( !isdefined( struct.script_demeanor ) )
        {
            filtered[ filtered.size ] = struct;
        }
    }
    
    assertex( filtered.size == 1, "<dev string:x3c6>" + self.origin + "<dev string:x3f3>" );
    return filtered[ 0 ];
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 1
// Checksum 0x0, Offset: 0x26fa
// Size: 0x214
function getonpath( skip_attach )
{
    path_start = undefined;
    type = self.vehicletype;
    
    if ( isdefined( self.vehicle_spawner ) )
    {
        if ( istrue( self.vehicle_spawner.dontgetonpath ) )
        {
            return;
        }
    }
    
    if ( isdefined( self.target ) )
    {
        path_start = getvehiclenode( self.target, "targetname" );
        
        /#
            if ( ishelicopter() && isdefined( path_start ) )
            {
                println( "<dev string:x42f>" + path_start.targetname );
                println( "<dev string:x44f>" + getxhashsourcename( self.vehicletype ) );
                assertmsg( "<dev string:x460>" );
            }
        #/
        
        if ( !isdefined( path_start ) )
        {
            if ( utility::iscp() )
            {
                path_start = get_pathstruct();
            }
            else
            {
                path_start = getstruct( self.target, "targetname" );
            }
        }
    }
    
    if ( !isdefined( path_start ) )
    {
        if ( ishelicopter() )
        {
            self vehicle_setspeed( 60, 20, 10 );
        }
        
        return;
    }
    
    self.attachedpath = path_start;
    
    if ( !ishelicopter() && !isstruct( path_start ) )
    {
        self.origin = path_start.origin;
        
        if ( !isdefined( skip_attach ) )
        {
            self attachpath( path_start );
        }
    }
    else if ( isdefined( self.speed ) )
    {
        self vehicle_setspeedimmediate( self.speed, 20 );
    }
    else if ( isdefined( path_start.speed ) )
    {
        accel = 20;
        decel = 10;
        
        if ( isdefined( path_start.script_accel ) )
        {
            accel = path_start.script_accel;
        }
        
        if ( isdefined( path_start.script_decel ) )
        {
            accel = path_start.script_decel;
        }
        
        speedfloat = float( path_start.speed );
        self vehicle_setspeedimmediate( speedfloat, accel, decel );
    }
    else
    {
        self vehicle_setspeed( 60, 20, 10 );
    }
    
    thread _vehicle_paths( undefined, ishelicopter() );
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 1
// Checksum 0x0, Offset: 0x2916
// Size: 0x6c
function _vehicle_resume_named( stop_name )
{
    resume_speed = self.vehicle_stop_named[ stop_name ];
    self.vehicle_stop_named[ stop_name ] = undefined;
    
    if ( self.vehicle_stop_named.size )
    {
        return;
    }
    
    if ( self hascomponent( "p2p" ) )
    {
        self setconfigvalue( "p2p", "manualSpeed", resume_speed * 17.6 );
        return;
    }
    
    self resumespeed( resume_speed );
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 3
// Checksum 0x0, Offset: 0x298a
// Size: 0x99
function _vehicle_stop_named( stop_name, acceleration, deceleration )
{
    if ( !isdefined( self.vehicle_stop_named ) )
    {
        self.vehicle_stop_named = [];
    }
    
    assertex( !isdefined( self.vehicle_stop_named[ stop_name ] ), "<dev string:x496>" );
    
    if ( self hascomponent( "p2p" ) )
    {
        self.vehicle_stop_named[ stop_name ] = self vehicle_getspeed();
        self setconfigvalue( "p2p", "manualSpeed", 0 );
        return;
    }
    
    self vehicle_setspeed( 0, acceleration, deceleration );
    self.vehicle_stop_named[ stop_name ] = acceleration;
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 1
// Checksum 0x0, Offset: 0x2a2b
// Size: 0x1ed
function unload_node( node )
{
    self endon( "death" );
    
    if ( isdefined( self.ent_flag ) && isdefined( self.ent_flag[ "prep_unload" ] ) && ent_flag( "prep_unload" ) )
    {
        return;
    }
    
    assert( isdefined( self ) );
    
    if ( isdefined( node.targetname ) )
    {
        pathnode = getnode( node.targetname, "target" );
        
        if ( isdefined( pathnode ) && self.riders.size )
        {
            foreach ( rider in self.riders )
            {
                if ( isai( rider ) )
                {
                    rider thread script_func( "go_to_node", pathnode );
                }
            }
        }
    }
    
    if ( ishelicopter() )
    {
        self sethoverparams( 0, 0, 0 );
        waittill_stable( node );
    }
    
    if ( isdefined( node.script_noteworthy ) )
    {
        if ( node.script_noteworthy == "wait_for_flag" )
        {
            flag_wait( node.script_flag );
        }
    }
    
    if ( isdefined( node.script_unload ) )
    {
        if ( node.script_unload == "1" )
        {
            node.script_unload = "default";
        }
    }
    
    var_b3941e6a151cf4d2 = _vehicle_unload( node.script_unload );
    
    if ( scripts\common\vehicle_aianim::riders_unloadable( node.script_unload ) )
    {
        self waittill( "unloaded" );
    }
    
    if ( isdefined( node.script_flag_wait ) || isdefined( node.script_flag_waitopen ) || isdefined( node.script_delay ) )
    {
        return var_b3941e6a151cf4d2;
    }
    
    if ( isdefined( self ) )
    {
        thread vehicle_resumepathvehicle();
    }
    
    return var_b3941e6a151cf4d2;
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 0
// Checksum 0x0, Offset: 0x2c21
// Size: 0x11d
function checkvehiclenavsplinestuck()
{
    self notify( "checkVehicleNavSplineStuck" );
    self endon( "checkVehicleNavSplineStuck" );
    self endon( "death" );
    laststucktime = undefined;
    laststuckposition = undefined;
    stuckdistancethreshold = 100;
    var_196855bdf0b6d359 = 5;
    
    while ( true )
    {
        self waittill( "path_blocked" );
        
        if ( !isdefined( laststucktime ) || !isdefined( laststuckposition ) )
        {
            laststucktime = gettime();
            laststuckposition = self.origin;
            continue;
        }
        
        stuckdistance = length2d( self.origin - laststuckposition );
        
        if ( stuckdistance > stuckdistancethreshold )
        {
            laststucktime = gettime();
            laststuckposition = self.origin;
            continue;
        }
        
        timeelapsed = gettime() - laststucktime;
        timeelapsedseconds = timeelapsed / 1000;
        
        if ( timeelapsedseconds > var_196855bdf0b6d359 )
        {
            /#
                duration = 400;
                print3d( self getcentroid(), "<dev string:x4b9>", ( 1, 1, 1 ), 1, 1, duration );
            #/
            
            self notify( "vehicleStuckNavSpline" );
            self stoppath();
            break;
        }
    }
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 0
// Checksum 0x0, Offset: 0x2d46
// Size: 0x6c
function checkvehiclenavsplineinterrupted()
{
    self notify( "checkVehicleNavSplineInterrupted" );
    self endon( "checkVehicleNavSplineInterrupted" );
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "navspline_interrupted" );
        
        /#
            duration = 400;
            print3d( self getcentroid(), "<dev string:x4d4>", ( 1, 1, 1 ), 1, 1, duration );
        #/
        
        self notify( "vehicleNavSplineInterrupted" );
        self stoppath();
    }
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 4
// Checksum 0x0, Offset: 0x2dba
// Size: 0xfe
function function_b5e5b1755c705053( goallocation, speedmph, var_56c51d0b8c3270ca, debugdraw )
{
    startlocation = self.origin;
    vehicleforward = anglestoforward( self.angles );
    splinepoints = self findsplinepath( startlocation, goallocation, 50, 200, 100, vehicleforward, ( 0, 0, 0 ), 300, 0.4, 0, 1, var_56c51d0b8c3270ca, 0, 1 );
    speedips = mph_to_ips( speedmph );
    self setconfigvalue( "p2p", "manualSpeed", speedips );
    
    /#
        if ( isdefined( splinepoints ) && istrue( debugdraw ) )
        {
            thread function_68d5232181fec390( splinepoints, ter_op( isdefined( var_56c51d0b8c3270ca ), ( 1, 1, 1 ), ( 1, 0, 0 ) ) );
            thread function_2a708e9755fc798b( var_56c51d0b8c3270ca, speedmph );
        }
    #/
    
    thread checkvehiclenavsplinestuck();
    thread checkvehiclenavsplineinterrupted();
}

// Namespace vehicle_paths / scripts\common\vehicle_paths
// Params 3
// Checksum 0x0, Offset: 0x2ec0
// Size: 0x2dd
function vehiclenavsplinesimplefollowbehavior( speedmph, var_56c51d0b8c3270ca, debugdraw )
{
    self notify( "vehicleNavSplineSimpleFollowBehavior" );
    self endon( "vehicleNavSplineSimpleFollowBehavior" );
    self endon( "death" );
    minradius = 500;
    maxradius = 1200;
    var_888ed72045a81b60 = 150;
    var_3a23d1f807ed0162 = 1500;
    var_c71a100d3bdf9202 = 4000;
    
    while ( true )
    {
        enemy = level.players[ 0 ];
        
        if ( !isdefined( enemy ) )
        {
            waitframe();
            continue;
        }
        
        if ( !isdefined( self.attackpoint ) )
        {
            tacpoint = getexposedtacpointwithvisinradius( enemy.origin, enemy.origin, minradius, maxradius, var_888ed72045a81b60 );
            
            if ( !isdefined( tacpoint ) )
            {
                wait 1;
                continue;
            }
            else
            {
                self.attackpoint = tacpoint.origin;
            }
        }
        
        function_b5e5b1755c705053( self.attackpoint, speedmph, var_56c51d0b8c3270ca, debugdraw );
        
        /#
            if ( istrue( debugdraw ) )
            {
                duration = 100;
                line( self.attackpoint, self.origin, ( 0, 1, 0 ), 1, 0, duration );
                sphere( self.attackpoint, 15, ( 0, 1, 0 ), 1, duration );
            }
        #/
        
        waittill_any_3( "near_goal", "vehicleNavSplineInterrupted", "vehicleStuckNavSpline" );
        self.enemyvisibletime = gettime();
        
        while ( true )
        {
            waitframe();
            attackpointdistance = distance2d( enemy.origin, self.attackpoint );
            
            if ( attackpointdistance > var_3a23d1f807ed0162 )
            {
                self.attackpoint = undefined;
                break;
            }
            
            trace = scripts\engine\trace::ray_trace( self.origin, enemy getcentroid(), self );
            
            /#
                if ( istrue( debugdraw ) )
                {
                    visible = isdefined( trace ) && trace[ "<dev string:x4f5>" ] == "<dev string:x500>" && trace[ "<dev string:x512>" ] == enemy;
                    color = ter_op( visible, ( 1, 1, 0 ), ( 1, 0, 0 ) );
                    line( enemy getcentroid(), self.origin, color, 1, 0, 1 );
                    print3d( self.origin, "<dev string:x51c>" + attackpointdistance, color, 1, 1, 1 );
                }
            #/
            
            if ( isdefined( trace ) && trace[ "hittype" ] == "hittype_entity" && trace[ "entity" ] == enemy )
            {
                self.enemyvisibletime = gettime();
                continue;
            }
            
            if ( gettime() - self.enemyvisibletime > var_c71a100d3bdf9202 )
            {
                self.attackpoint = undefined;
                break;
            }
        }
    }
}

/#

    // Namespace vehicle_paths / scripts\common\vehicle_paths
    // Params 2
    // Checksum 0x0, Offset: 0x31a5
    // Size: 0x188, Type: dev
    function function_2a708e9755fc798b( var_56c51d0b8c3270ca, speed )
    {
        duration = 400;
        textverticaloffset = 15;
        
        if ( utility::issp() )
        {
            var_1b46e8b19292a40e = getdvar( @"hash_4e06d4ff70605269", 0 );
            print3d( self.origin, "<dev string:x520>" + var_1b46e8b19292a40e, ( 1, 1, 1 ), 1, 1, duration );
        }
        
        navmeshlayer = ter_op( isdefined( var_56c51d0b8c3270ca ), var_56c51d0b8c3270ca, "<dev string:x53f>" );
        var_620e3a366fb95fcf = istrue( level.var_620e3a366fb95fcf );
        script_disconnectpaths = !isdefined( self.script_disconnectpaths ) || istrue( self.script_disconnectpaths );
        var_30c993377fdf47dd = getdvar( @"hash_b0706332ae0689bc", 1 );
        print3d( self.origin + ( 0, 0, textverticaloffset * 3 ), "<dev string:x54a>" + navmeshlayer + "<dev string:x55b>" + speed, ( 1, 1, 1 ), 1, 1, duration );
        print3d( self.origin + ( 0, 0, textverticaloffset * 2 ), "<dev string:x566>" + var_620e3a366fb95fcf + "<dev string:x584>" + script_disconnectpaths, ( 1, 1, 1 ), 1, 1, duration );
        print3d( self.origin + ( 0, 0, textverticaloffset ), "<dev string:x5a0>" + var_30c993377fdf47dd, ( 1, 1, 1 ), 1, 1, duration );
    }

    // Namespace vehicle_paths / scripts\common\vehicle_paths
    // Params 2
    // Checksum 0x0, Offset: 0x3335
    // Size: 0x8c, Type: dev
    function function_68d5232181fec390( splinepoints, pathcolor )
    {
        self notify( "<dev string:x5c6>" );
        self endon( "<dev string:x5c6>" );
        self endon( "<dev string:x5dd>" );
        
        while ( true )
        {
            waitframe();
            sphere( splinepoints[ 0 ], 5, pathcolor, 0, 1 );
            pathcolor = ter_op( isdefined( pathcolor ), pathcolor, ( 1, 1, 1 ) );
            
            for ( index = 1; index < splinepoints.size ; index++ )
            {
                line( splinepoints[ index - 1 ], splinepoints[ index ], pathcolor, 1, 0, 1 );
            }
        }
    }

#/
