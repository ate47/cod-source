#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace ai_formation;

// Namespace ai_formation / scripts\common\ai_formation
// Params 0
// Checksum 0x0, Offset: 0xfa
// Size: 0x19
function init_formations()
{
    if ( !isdefined( level.formationlist ) )
    {
        level.formationlist = [];
    }
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 2
// Checksum 0x0, Offset: 0x11b
// Size: 0x7a
function function_a18d80bcfacb9e00( formationname, formationtype )
{
    if ( !isdefined( level.formationlist ) )
    {
        init_formations();
    }
    
    if ( isdefined( level.formationlist[ formationname ] ) )
    {
        return level.formationlist[ formationname ];
    }
    
    assertex( formationtype >= 0 && formationtype < 4, "<dev string:x1c>" + formationtype );
    level.formationlist[ formationname ] = newaiformation( formationtype );
    return level.formationlist[ formationname ];
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 1
// Checksum 0x0, Offset: 0x19e
// Size: 0x37
function delete_formation( formationname )
{
    if ( !isdefined( level.formationlist[ formationname ] ) )
    {
        return;
    }
    
    deleteaiformation( level.formationlist[ formationname ] );
    level.formationlist[ formationname ] = undefined;
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 3
// Checksum 0x0, Offset: 0x1dd
// Size: 0xc3
function function_73d6d4ee28a18071( formationname, aitoadd, formationtype )
{
    if ( !isdefined( formationtype ) )
    {
        formationtype = 3;
    }
    
    if ( !isdefined( level.formationlist ) )
    {
        init_formations();
    }
    
    if ( !isdefined( level.formationlist[ formationname ] ) )
    {
        function_a18d80bcfacb9e00( formationname, formationtype );
    }
    
    if ( !isarray( aitoadd ) )
    {
        aitoadd = [ aitoadd ];
    }
    
    foreach ( ai in aitoadd )
    {
        ai enter_formation( level.formationlist[ formationname ] );
        ai thread need_to_run( formationname );
    }
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 6
// Checksum 0x0, Offset: 0x2a8
// Size: 0x114
function function_98e62e94c2b167e0( formationname, horizontalcount, verticalcount, horizontalseparation, verticalseparation, leaderinfront )
{
    if ( !isdefined( leaderinfront ) )
    {
        leaderinfront = 0;
    }
    
    if ( !isdefined( level.formationlist[ formationname ] ) )
    {
        return;
    }
    
    mid = floor( horizontalcount / 2 );
    offsetcount = 1;
    
    for ( verticalindex = 0; verticalindex < verticalcount ; verticalindex++ )
    {
        for ( horizontalindex = 0; horizontalindex < horizontalcount ; horizontalindex++ )
        {
            if ( !leaderinfront && verticalindex == 0 && horizontalindex == mid )
            {
                continue;
            }
            
            yoffset = horizontalseparation * -1 * ( horizontalindex - mid );
            xoffset = verticalseparation * -1 * verticalindex;
            
            if ( leaderinfront )
            {
                yoffset -= 0.5 * ( horizontalcount - 1 ) % 2 * horizontalseparation;
                xoffset -= verticalseparation;
            }
            
            setaiformationcustomoffset( level.formationlist[ formationname ], offsetcount, ( xoffset, yoffset, 0 ) );
            offsetcount++;
        }
    }
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 6
// Checksum 0x0, Offset: 0x3c4
// Size: 0x277
function function_cf3f27c3c5266ee2( formationname, formationshape, numai, horizontalseparation, verticalseparation, leaderinfront )
{
    if ( !isdefined( leaderinfront ) )
    {
        leaderinfront = 0;
    }
    
    if ( !isdefined( level.formationlist[ formationname ] ) )
    {
        return 1;
    }
    
    if ( numai <= 1 )
    {
        return 1;
    }
    
    if ( leaderinfront && formationshape != 1 )
    {
        numai--;
    }
    
    switch ( formationshape )
    {
        case 1:
            dimension = ceil( ( sqrt( 8 * numai + 1 ) - 1 ) / 2 );
            offsetcount = 1;
            
            for ( verticalindex = 0; verticalindex < dimension ; verticalindex++ )
            {
                for ( horizontalindex = 0; horizontalindex < verticalindex + 1 ; horizontalindex++ )
                {
                    if ( verticalindex == 0 && horizontalindex == 0 )
                    {
                        continue;
                    }
                    
                    yoffset = horizontalseparation * ( horizontalindex - verticalindex / 2 );
                    xoffset = verticalseparation * -1 * verticalindex;
                    setaiformationcustomoffset( level.formationlist[ formationname ], offsetcount, ( xoffset, yoffset, 0 ) );
                    offsetcount++;
                }
            }
            
            return ( ( dimension - 1 ) * horizontalseparation );
        case 2:
            mid = 0;
            horizontalcount = 1;
            verticalcount = numai;
            break;
        case 3:
            mid = 1;
            horizontalcount = 2;
            verticalcount = ceil( numai / horizontalcount );
            break;
        case 4:
            mid = 1;
            horizontalcount = 3;
            verticalcount = ceil( numai / horizontalcount );
            break;
        default:
            horizontalcount = ceil( sqrt( numai ) );
            verticalcount = ceil( numai / horizontalcount );
            mid = floor( horizontalcount / 2 );
            break;
    }
    
    offsetcount = 1;
    
    for ( verticalindex = 0; verticalindex < verticalcount ; verticalindex++ )
    {
        for ( horizontalindex = 0; horizontalindex < horizontalcount ; horizontalindex++ )
        {
            if ( !leaderinfront && verticalindex == 0 && horizontalindex == mid )
            {
                continue;
            }
            
            yoffset = horizontalseparation * -1 * ( horizontalindex - mid );
            xoffset = verticalseparation * -1 * verticalindex;
            
            if ( leaderinfront )
            {
                yoffset -= 0.5 * ( horizontalcount - 1 ) % 2 * horizontalseparation;
                xoffset -= verticalseparation;
            }
            
            setaiformationcustomoffset( level.formationlist[ formationname ], offsetcount, ( xoffset, yoffset, 0 ) );
            offsetcount++;
        }
    }
    
    return ( horizontalcount - 1 ) * horizontalseparation;
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 2
// Checksum 0x0, Offset: 0x644
// Size: 0xb4
function function_e780688c49cc9549( formationname, customoffsetlist )
{
    if ( !isdefined( level.formationlist[ formationname ] ) )
    {
        return;
    }
    
    assertex( customoffsetlist.size < 31, "<dev string:x3a>" + 32 - 1 + "<dev string:x6b>" + level.formationlist[ formationname ] );
    count = 1;
    
    foreach ( offset in customoffsetlist )
    {
        setaiformationcustomoffset( level.formationlist[ formationname ], count, offset );
        count++;
    }
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 3
// Checksum 0x0, Offset: 0x700
// Size: 0x78
function function_bc785df299663d60( formationname, formationslot, customoffset )
{
    if ( !isdefined( level.formationlist[ formationname ] ) )
    {
        return;
    }
    
    maxcount = 31;
    assertex( formationslot < maxcount && formationslot > 0, "<dev string:x84>" + maxcount + "<dev string:xc4>" + level.formationlist[ formationname ] );
    setaiformationcustomoffset( level.formationlist[ formationname ], formationslot, customoffset );
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 2
// Checksum 0x0, Offset: 0x780
// Size: 0x35
function set_goal( formationname, goalposition )
{
    if ( !isdefined( level.formationlist[ formationname ] ) )
    {
        return;
    }
    
    aiformationmoveto( level.formationlist[ formationname ], goalposition );
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 1
// Checksum 0x0, Offset: 0x7bd
// Size: 0x68
function leave_formation( aitoremove )
{
    if ( !isarray( aitoremove ) )
    {
        aitoremove = [ aitoremove ];
    }
    
    foreach ( ai in aitoremove )
    {
        ai exit_formation();
    }
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 4
// Checksum 0x0, Offset: 0x82d
// Size: 0x7b, Type: bool
function follow_entity( formationname, ent, followdistance, timestep )
{
    if ( !isdefined( followdistance ) )
    {
        followdistance = 100;
    }
    
    if ( !isdefined( ent ) )
    {
        return false;
    }
    
    if ( !isdefined( level.formationlist[ formationname ] ) )
    {
        return false;
    }
    
    leader = get_leader( formationname );
    
    if ( isdefined( leader ) )
    {
        leader setgoalentity( ent );
        setaiformationleaderfollowdistance( level.formationlist[ formationname ], followdistance );
        return true;
    }
    
    return false;
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 1
// Checksum 0x0, Offset: 0x8b1
// Size: 0x3f, Type: bool
function function_5e8d7d93ecffa23f( formationname )
{
    if ( !isdefined( level.formationlist[ formationname ] ) )
    {
        return false;
    }
    
    leader = get_leader( formationname );
    
    if ( isdefined( leader ) )
    {
        leader cleargoalentity();
        return true;
    }
    
    return false;
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 1
// Checksum 0x0, Offset: 0x8f9
// Size: 0x2c
function get_leader( formationname )
{
    if ( !isdefined( level.formationlist[ formationname ] ) )
    {
        return undefined;
    }
    
    return getaiformationleader( level.formationlist[ formationname ] );
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 1
// Checksum 0x0, Offset: 0x92e
// Size: 0x30
function function_679b2830741a1384( formationname )
{
    formationid = level.formationlist[ formationname ];
    
    if ( !isdefined( formationid ) )
    {
        return;
    }
    
    self function_5ba70c95e357a4f9( formationid );
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x966
// Size: 0x27
function private exit_formation()
{
    if ( istrue( self.information ) )
    {
        self.information = 0;
        self function_fd663014f7eae161();
        function_699890f2ebe93aa9();
    }
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x995
// Size: 0x25
function private enter_formation( formationid )
{
    exit_formation();
    self.information = 1;
    self function_19ef30914f93393e( formationid );
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x9c2
// Size: 0x1d7
function private need_to_run( formationname )
{
    self endon( "death" );
    self endon( "enemy" );
    self endon( "following_entity" );
    level endon( "game_ended" );
    self notify( "ai_formation_run_watcher" );
    self endon( "ai_formation_run_watcher" );
    var_5ceb8e651146f51c = 1000;
    var_4a9b8203f0e14a0 = 250;
    
    while ( true )
    {
        leader = get_leader( formationname );
        
        if ( !isdefined( leader ) )
        {
            wait 1;
            continue;
        }
        
        disttogoal = self pathdisttogoal() - leader pathdisttogoal();
        
        /#
            if ( getdvarint( @"hash_96eb05fe9867a3a4", 0 ) == 1 )
            {
                print3d( self.origin, self getdemeanor(), ( 1, 0, 0 ), 1, 1, 20 );
                goal = self getgoalpos( 3 );
                draw_circle( goal, var_5ceb8e651146f51c, ( 1, 0, 0 ), 50 );
                draw_circle( goal, var_4a9b8203f0e14a0, ( 0, 1, 0 ), 50 );
            }
        #/
        
        idledemeanoroverride = "sprint";
        
        if ( self.var_7bd1c0edbaafb6e0 != idledemeanoroverride && disttogoal > var_5ceb8e651146f51c )
        {
            self enableavoidance( 1 );
            
            if ( !isdefined( self.var_3bca4b669ba7140c ) || !isdefined( self.var_d008717a85388441 ) )
            {
                self.var_3bca4b669ba7140c = self.var_7bd1c0edbaafb6e0;
                self.var_d008717a85388441 = self.var_5bdfa4fd67341cf5;
            }
            
            self.var_7bd1c0edbaafb6e0 = idledemeanoroverride;
            self.var_5bdfa4fd67341cf5 = idledemeanoroverride;
        }
        else if ( self.var_7bd1c0edbaafb6e0 == idledemeanoroverride && disttogoal < var_4a9b8203f0e14a0 )
        {
            self enableavoidance( 0 );
            self.var_7bd1c0edbaafb6e0 = self.var_3bca4b669ba7140c;
            self.var_5bdfa4fd67341cf5 = self.var_d008717a85388441;
        }
        
        wait 1;
    }
}

// Namespace ai_formation / scripts\common\ai_formation
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0xba1
// Size: 0x40
function private function_699890f2ebe93aa9()
{
    if ( isdefined( self.var_3bca4b669ba7140c ) )
    {
        self.var_7bd1c0edbaafb6e0 = self.var_3bca4b669ba7140c;
    }
    
    if ( isdefined( self.var_d008717a85388441 ) )
    {
        self.var_5bdfa4fd67341cf5 = self.var_d008717a85388441;
    }
}

