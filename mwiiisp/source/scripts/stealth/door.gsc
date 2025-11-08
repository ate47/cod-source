#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\door;
#using scripts\stealth\enemy;
#using scripts\stealth\event;
#using scripts\stealth\utility;

#namespace door;

// Namespace door / scripts\stealth\door
// Params 0
// Checksum 0x0, Offset: 0x109
// Size: 0x122
function stealth_suspicious_doors_init()
{
    if ( istrue( level.ship_assault ) )
    {
        return;
    }
    
    if ( isdefined( level.stealth ) )
    {
        if ( !isdefined( level.stealth.suspicious_door ) )
        {
            level.stealth.suspicious_door = spawnstruct();
            level.stealth.suspicious_door.doors = [];
            level.stealth.suspicious_door.reset_time = 30;
            level.stealth.suspicious_door.sight_distsqrd = squared( 600 );
            level.stealth.suspicious_door.detect_distsqrd = squared( 200 );
            level.stealth.suspicious_door.found_distsqrd = squared( 128 );
        }
        
        level scripts\stealth\utility::set_stealth_func( "suspicious_door", &scripts\stealth\door::suspicious_door_found );
        level scripts\stealth\event::event_severity_set( "investigate", "suspicious_door", 20 );
    }
}

// Namespace door / scripts\stealth\door
// Params 0
// Checksum 0x0, Offset: 0x233
// Size: 0x49
function suspicious_door_thread()
{
    self notify( "suspicious_door_thread" );
    self endon( "suspicious_door_thread" );
    self endon( "death" );
    self endon( "pain_death" );
    
    while ( true )
    {
        ent_flag_wait( "stealth_enabled" );
        
        if ( !scripts\stealth\utility::function_6a86dd83c01f8faa() )
        {
            suspicious_door_sighting();
        }
        
        wait 0.1;
    }
}

// Namespace door / scripts\stealth\door
// Params 0
// Checksum 0x0, Offset: 0x284
// Size: 0x473
function suspicious_door_sighting()
{
    if ( !isdefined( self.stealth.suspicious_door ) )
    {
        self.stealth.suspicious_door = spawnstruct();
    }
    
    if ( isdefined( self.stealth.suspicious_door.nexttime ) && gettime() < self.stealth.suspicious_door.nexttime )
    {
        return;
    }
    
    if ( self.ignoreall )
    {
        return;
    }
    
    if ( istrue( self.var_2d74676facf9c5a9 ) )
    {
        return;
    }
    
    if ( istrue( self.stealth.suspicious_door.investigating ) )
    {
        return;
    }
    
    if ( isdefined( self.stealth.suspicious_door.ent ) )
    {
        debounce = 100;
    }
    else
    {
        debounce = 1000;
    }
    
    self.stealth.suspicious_door.nexttime = gettime() + debounce;
    doors = level.stealth.suspicious_door.doors;
    found_door = undefined;
    saw_door = undefined;
    door = undefined;
    
    foreach ( door in doors )
    {
        doorentnum = door getentitynumber();
        
        if ( isdefined( door.found ) )
        {
            continue;
        }
        
        doororigin = door.origin;
        distsq = distancesquared( self.origin, doororigin );
        var_93d7b440350b1ced = level.stealth.suspicious_door.found_distsqrd;
        var_2a44e35fa659e850 = level.stealth.suspicious_door.sight_distsqrd;
        var_22e09cbf7a5ed764 = level.stealth.suspicious_door.detect_distsqrd;
        
        if ( doororigin[ 2 ] - self.origin[ 2 ] > 128 )
        {
            continue;
        }
        
        if ( isdefined( self.stealth.suspicious_door.ent ) )
        {
            if ( self.stealth.suspicious_door.ent == door )
            {
                continue;
            }
            
            doororiginnew = self.stealth.suspicious_door.ent.origin;
            dist2sq = distancesquared( self.origin, doororiginnew );
            
            if ( dist2sq <= distsq )
            {
                continue;
            }
        }
        
        if ( distsq < var_93d7b440350b1ced )
        {
            if ( abs( self.origin[ 2 ] - doororigin[ 2 ] ) < 60 )
            {
                /#
                    if ( getdvarint( @"hash_936a3d04dd90f9b7" ) )
                    {
                        line( doororigin, self.origin, ( 0, 1, 0 ), 1, 0, 400 );
                    }
                #/
                
                found_door = door;
                break;
            }
        }
        
        if ( distsq > var_2a44e35fa659e850 )
        {
            continue;
        }
        
        if ( distsq < var_22e09cbf7a5ed764 )
        {
            if ( canseedoor( door, debounce ) )
            {
                found_door = door;
                break;
            }
        }
        
        sight = anglestoforward( self gettagangles( "tag_eye" ) );
        var_7755d77530405278 = vectornormalize( doororigin + ( 0, 0, 30 ) - self geteye() );
        
        if ( vectordot( sight, var_7755d77530405278 ) > 0.55 )
        {
            if ( canseedoor( door, debounce ) )
            {
                found_door = door;
                break;
            }
        }
    }
    
    if ( isdefined( found_door ) )
    {
        found_door.found = 1;
        spot = undefined;
        
        if ( isdefined( door.cam_structs ) )
        {
            spot = door.cam_structs[ 0 ].origin;
        }
        else
        {
            spot = door.origin;
        }
        
        self aieventlistenerevent( "suspicious_door", found_door, spot );
    }
}

// Namespace door / scripts\stealth\door
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x6ff
// Size: 0x25b
function private canseedoor( door, debounce )
{
    result = 0;
    debugorigin = door.origin;
    
    if ( !isdefined( door.seen ) )
    {
        if ( self cansee( door, debounce ) )
        {
            result = 1;
        }
        else
        {
            handleoffset = rotatevectorinverted( door.open_struct.origin - door.origin, door.true_start_angles );
            handleorigin = door.origin + rotatevector( handleoffset, door.pivot_ent.angles );
            ignoreents = array_add( getstealthcantracetoaiignoreents(), door );
            
            if ( isdefined( door.clip ) )
            {
                ignoreents[ ignoreents.size ] = door.clip;
            }
            
            if ( isdefined( door.clip_nosight ) )
            {
                ignoreents[ ignoreents.size ] = door.clip_nosight;
            }
            
            startorigin = self geteye();
            originstocheck = [ door.origin, handleorigin ];
            
            foreach ( origin in originstocheck )
            {
                debugorigin = origin;
                trace = scripts\engine\trace::ray_trace( startorigin, origin, ignoreents );
                
                if ( is_equal( trace[ "hittype" ], "hittype_none" ) )
                {
                    result = 1;
                    break;
                }
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_936a3d04dd90f9b7" ) )
        {
            color = ter_op( result, ( 0, 1, 0 ), ( 1, 0, 0 ) );
            frames = int( debounce / 1000 * 20 );
            print3d( debugorigin, door getentitynumber(), ( 1, 1, 1 ), 1, 1, frames );
            line( debugorigin, self.origin, color, 1, 0, frames );
        }
    #/
    
    return result;
}

// Namespace door / scripts\stealth\door
// Params 1
// Checksum 0x0, Offset: 0x963
// Size: 0x1f3
function suspicious_door_found( event )
{
    door = event.entity;
    
    if ( isdefined( door.aiopener ) )
    {
        return;
    }
    
    door.aiopener = self;
    
    if ( isdefined( door.cam_structs ) && isdefined( door.cam_structs[ 0 ] ) )
    {
        spot = door.cam_structs[ 0 ].origin;
    }
    else
    {
        spot = door.origin;
    }
    
    point = getclosestpointonnavmesh( spot, self );
    distscalar = 75;
    doorright = anglestoright( door.true_start_angles );
    doornormal = vectornormalize( self.origin - door.origin );
    
    if ( vectordot( doorright, doornormal ) > 0 )
    {
        distscalar *= -1;
    }
    
    event.origin = spot + doorright * distscalar;
    event.investigate_pos = getclosestpointonnavmesh( event.origin, self );
    
    /#
        if ( getdvarint( @"hash_936a3d04dd90f9b7" ) )
        {
            line( door.origin, door.origin + doorright * 10, ( 1, 0, 0 ), 1, 0, 400 );
            line( door.origin, event.origin, ( 1, 1, 0 ), 1, 0, 400 );
            line( door.origin, event.investigate_pos, ( 0, 1, 0 ), 1, 0, 400 );
        }
    #/
    
    if ( self.stealth_bsmstate < 2 )
    {
        scripts\stealth\enemy::bt_set_stealth_state( "investigate", event );
    }
}

