#using scripts\anim\animselector;
#using scripts\anim\utility;
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\arrival;
#using scripts\asm\soldier\cover;
#using scripts\asm\soldier\move;
#using scripts\asm\traverse;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace traverse;

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x424
// Size: 0x1cf
function playtraverseanim_deprecated( asmname, statename, params )
{
    self endon( "death" );
    self endon( "terminate_ai_threads" );
    checktraverse( statename );
    traverseanim = asm_getanim( asmname, statename );
    traversexanim = asm_getxanim( statename, traverseanim );
    self.desired_anim_pose = "crouch";
    scripts\anim\utility::updateanimpose();
    self endon( "killanimscript" );
    self animmode( "noclip" );
    startnode = self getnegotiationstartnode();
    assert( isdefined( startnode ) );
    self orientmode( "face angle", startnode.angles[ 1 ] );
    startnode.traverse_height = startnode.origin[ 2 ] + startnode.traverse_height_delta;
    realheight = startnode.traverse_height - startnode.origin[ 2 ];
    thread teleportthread( realheight - params );
    blendtime = 0.15;
    self aisetanim( statename, traverseanim );
    var_22943623b8e97c62 = 0.2;
    endblendtime = 0.2;
    thread traverse_donotetracks( asmname, statename );
    
    if ( !animhasnotetrack( traversexanim, "gravity on" ) )
    {
        var_cc694b7fbbf6503c = 1.23;
        wait var_cc694b7fbbf6503c - var_22943623b8e97c62;
        self animmode( "gravity" );
        wait var_22943623b8e97c62;
    }
    else
    {
        self waittillmatch( "traverse", "gravity on" );
        self animmode( "gravity" );
        
        if ( !animhasnotetrack( traversexanim, "blend" ) )
        {
            wait var_22943623b8e97c62;
        }
        else
        {
            self waittillmatch( "traverse", "blend" );
        }
    }
    
    terminatetraverse( asmname, statename );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x5fb
// Size: 0x93
function playtraverseanim( asmname, statename, params )
{
    traverseanim = asm_getanim( asmname, statename );
    checktraverse( statename );
    self animmode( "noclip" );
    startnode = self getnegotiationstartnode();
    assert( isdefined( startnode ) );
    self orientmode( "face angle", startnode.angles[ 1 ] );
    self aisetanim( statename, traverseanim );
    asm_donotetracks( asmname, statename );
    terminatetraverse( asmname, statename );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x696
// Size: 0x2f4
function playtraverseanim_doublejump( asmname, statename, params )
{
    self endon( "death" );
    self endon( "terminate_ai_threads" );
    self endon( statename + "_finished" );
    var_3016b22139446579 = getdvarint( @"hash_db3bdaface7c82ec", 0 );
    
    if ( var_3016b22139446579 != 3 && var_3016b22139446579 != 4 )
    {
        checktraverse( statename );
    }
    
    self.ragdoll_immediate = 1;
    start_node = self getnegotiationstartnode();
    var_e14ac44f6f147496 = self getnegotiationendpos();
    start_node.traverse_height = start_node.origin[ 2 ] + start_node.traverse_height_delta - 44;
    var_559df5f9875a294e = [];
    
    if ( start_node.traverse_height > var_e14ac44f6f147496[ 2 ] )
    {
        halfway_x = ( start_node.origin[ 0 ] + var_e14ac44f6f147496[ 0 ] ) * 0.5;
        halfway_y = ( start_node.origin[ 1 ] + var_e14ac44f6f147496[ 1 ] ) * 0.5;
        var_559df5f9875a294e[ var_559df5f9875a294e.size ] = ( halfway_x, halfway_y, start_node.traverse_height );
        
        /#
            if ( var_3016b22139446579 != 0 )
            {
                jump_over_position = var_559df5f9875a294e[ 0 ];
                function_52e0db833127ec95( self.origin, jump_over_position, ( 128, 0, 255 ), 100 );
                function_52e0db833127ec95( self.origin, var_e14ac44f6f147496, ( 128, 0, 255 ), 100 );
            }
        #/
    }
    
    var_559df5f9875a294e[ var_559df5f9875a294e.size ] = var_e14ac44f6f147496;
    var_4c5664c0523213f2 = spawn( "script_model", start_node.origin );
    var_4c5664c0523213f2 setmodel( "tag_origin" );
    var_4c5664c0523213f2.angles = start_node.angles;
    thread delete_on_death( var_4c5664c0523213f2 );
    self orientmode( "face angle", start_node.angles[ 1 ] );
    max_time = 1.63;
    
    /#
        if ( var_3016b22139446579 == 3 )
        {
            max_time = 0.9;
        }
    #/
    
    self linkto( var_4c5664c0523213f2 );
    jumpanim = asm_getanim( asmname, statename );
    asm_playfacialanim( asmname, statename, asm_getxanim( jumpanim ) );
    self aisetanim( statename, jumpanim );
    thread traverse_donotetracks( asmname, statename );
    
    foreach ( org in var_559df5f9875a294e )
    {
        move_time = max_time / var_559df5f9875a294e.size;
        var_4c5664c0523213f2 moveto( org, move_time );
        var_4c5664c0523213f2 waittill( "movedone" );
    }
    
    self notify( "double_jumped" );
    self unlink();
    self.ragdoll_immediate = undefined;
    var_4c5664c0523213f2 delete();
    thread terminatetraverse( asmname, statename );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x992
// Size: 0x2c
function traverse_doublejump_cleanup( asmname, statename, params )
{
    self unlink();
    self.ragdoll_immediate = undefined;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 2
// Checksum 0x0, Offset: 0x9c6
// Size: 0x3a
function traverse_donotetracks( asmname, statename )
{
    self endon( "death" );
    self endon( "terminate_ai_threads" );
    self endon( statename + "_finished" );
    self endon( "double_jumped" );
    asm_donotetracks( asmname, statename );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 1
// Checksum 0x0, Offset: 0xa08
// Size: 0x73
function getexternaltraverseinfo( traversename )
{
    assertex( isdefined( level.scr_traverse ), "<dev string:x1c>" );
    assertex( isdefined( level.scr_traverse[ traversename ] ), "<dev string:x61>" + traversename + "<dev string:x79>" );
    
    if ( isdefined( level.scr_traverse ) && isdefined( level.scr_traverse[ traversename ] ) )
    {
        return level.scr_traverse[ traversename ];
    }
    
    return undefined;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0xa83
// Size: 0x48
function playtraverseanim_external( asmname, statename, params )
{
    assertex( utility::issp(), "<dev string:x92>" + asmname + "<dev string:xb6>" + statename + "<dev string:xc4>" );
    playtraverseanim_scaled( asmname, statename );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0xad3
// Size: 0xb7
function choosetraverseanim_external( asmname, statename, params )
{
    startnode = self getnegotiationstartnode();
    assert( isdefined( startnode ) );
    traversename = startnode.animscript;
    
    if ( isdefined( level.var_2a12779877c8c257 ) && isdefined( level.var_2a12779877c8c257[ traversename ] ) )
    {
        xanim = [[ level.var_2a12779877c8c257[ traversename ] ]]( asmname, statename, params );
        assert( isanimation( xanim ) );
        return xanim;
    }
    
    animinfo = getexternaltraverseinfo( traversename );
    assert( isanimation( animinfo ) );
    return animinfo;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0xb93
// Size: 0x9f
function playdoublejumpfinishanim( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self animmode( "noclip" );
    self orientmode( "face angle", self.angles[ 1 ] );
    self.useanimgoalweight = 1;
    animid = asm_getanim( asmname, statename );
    self aisetanim( statename, animid );
    xanim = asm_getxanim( statename, animid );
    asm_playfacialanim( asmname, statename, xanim );
    asm_donotetracks( asmname, statename );
    thread terminatetraverse( asmname, statename );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 5
// Checksum 0x0, Offset: 0xc3a
// Size: 0xc3
function getdoublejumpoffsetposition( asmname, var_223efa34c2b82dc8, endpos, endangles, notetrackname )
{
    animid = asm_chooseanim( asmname, var_223efa34c2b82dc8 );
    assert( isdefined( animid ) );
    xanim = asm_getxanim( var_223efa34c2b82dc8, animid );
    aligntime = getnotetracktimes( xanim, notetrackname );
    assert( isdefined( aligntime ) && aligntime.size > 0 );
    time = aligntime[ 0 ];
    animdelta = getmovedelta( xanim, 0, time );
    animangledelta = getangledelta( xanim, 0, time );
    return scripts\asm\soldier\cover::calcanimstartpos( endpos, endangles[ 1 ], animdelta, animangledelta );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 4
// Checksum 0x0, Offset: 0xd06
// Size: 0x1a3, Type: bool
function doublejumpneedsfinishanim( asmname, nextstatename, startnode, endpos )
{
    assert( isdefined( startnode ) );
    assert( isdefined( endpos ) );
    
    /#
        if ( getdvarint( @"hash_db3bdaface7c82ec", 0 ) == 3 )
        {
            return false;
        }
    #/
    
    deltaz = endpos[ 2 ] - startnode.origin[ 2 ];
    
    if ( deltaz < 0 )
    {
        return false;
    }
    
    if ( isdefined( startnode.jump_over_offset ) && getdvarint( @"hash_db3bdaface7c82ec", 0 ) != 2 )
    {
        jump_over_offset = startnode.jump_over_offset;
        angleoffset = startnode.angles - startnode.startnodeoriginalangles;
        
        if ( angleoffset != ( 0, 0, 0 ) )
        {
            jump_over_offset = rotatevector( jump_over_offset, angleoffset );
        }
        
        jump_over_position = startnode.origin + jump_over_offset;
        var_e5e2b98a87142185 = jump_over_position[ 2 ];
        var_e5e2b98a87142185 -= 44;
        
        if ( endpos[ 2 ] < var_e5e2b98a87142185 )
        {
            return false;
        }
    }
    
    delta = endpos - startnode.origin;
    delta = ( delta[ 0 ], delta[ 1 ], 0 );
    desiredangles = vectortoangles( delta );
    offsetpos = getdoublejumpoffsetposition( asmname, nextstatename, endpos, desiredangles, "footstep_left_small" );
    newdelta = offsetpos - startnode.origin;
    
    if ( vectordot( newdelta, delta ) < 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 4
// Checksum 0x0, Offset: 0xeb2
// Size: 0x84, Type: bool
function checkdoublejumpfinish( asmname, statename, tostatename, params )
{
    startnode = gettraversalstartnode();
    
    if ( !isdefined( startnode ) )
    {
        thread terminatetraverse( asmname, "double_jump" );
        return false;
    }
    
    endpos = self getnegotiationendpos();
    assert( isdefined( endpos ) );
    
    if ( !doublejumpneedsfinishanim( asmname, tostatename, startnode, endpos ) )
    {
        thread terminatetraverse( asmname, "double_jump" );
        return false;
    }
    
    return true;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 0
// Checksum 0x0, Offset: 0xf3f
// Size: 0x1f
function gettraversalstartnode()
{
    if ( isdefined( self.traversal_start_node ) )
    {
        return self.traversal_start_node;
    }
    
    return self getnegotiationstartnode();
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0xf67
// Size: 0x111
function playdoublejumpmantleorvault( asmname, statename, zoffset )
{
    self endon( statename + "_finished" );
    startnode = gettraversalstartnode();
    assert( isdefined( startnode.doublejumpmantlepos ) );
    assert( isdefined( startnode ) );
    endpos = startnode.doublejumpmantlepos;
    
    /#
    #/
    
    delta = endpos - startnode.origin;
    delta = ( delta[ 0 ], delta[ 1 ], 0 );
    desiredangles = vectortoangles( delta );
    jumpanim = asm_getanim( asmname, statename );
    assert( isdefined( jumpanim ) );
    nextstatename = statename + "_finish";
    mantlestartpos = getdoublejumpoffsetposition( asmname, nextstatename, endpos, desiredangles, "mantle_align" );
    mantlestartpos = ( mantlestartpos[ 0 ], mantlestartpos[ 1 ], mantlestartpos[ 2 ] + zoffset );
    playscaledjump( asmname, statename, jumpanim, mantlestartpos, desiredangles, 1, 0, 1 );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x1080
// Size: 0x26
function playdoublejumpmantle( asmname, statename, params )
{
    playdoublejumpmantleorvault( asmname, statename, -8 );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x10ae
// Size: 0x26
function playdoublejumpvault( asmname, statename, params )
{
    playdoublejumpmantleorvault( asmname, statename, -42 );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x10dc
// Size: 0x39
function doublejumpterminate( asmname, statename, params )
{
    self.useanimgoalweight = 0;
    self.jump_over_position = undefined;
    self.traversal_start_node = undefined;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x111d
// Size: 0x34
function doublejumpearlyterminate( asmname, statename, params )
{
    if ( !asm_eventfired( asmname, "end" ) )
    {
        doublejumpterminate( asmname, statename, params );
    }
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 4
// Checksum 0x0, Offset: 0x1159
// Size: 0x49
function isdoublejumpanimdone( asmname, statename, tostatename, params )
{
    /#
        if ( getdvarint( @"hash_db3bdaface7c82ec", 0 ) == 3 )
        {
            return 0;
        }
    #/
    
    return asm_eventfired( asmname, "end" );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x11ab
// Size: 0x3bd
function playdoublejumptraversal( asmname, statename, params )
{
    self endon( statename + "_finished" );
    
    /#
        if ( getdvarint( @"hash_db3bdaface7c82ec", 0 ) == 4 )
        {
            playtraverseanim_doublejump( asmname, "<dev string:xf3>", params );
            return;
        }
        
        if ( getdvarint( @"hash_db3bdaface7c82ec", 0 ) == 3 )
        {
            playtraverseanim_doublejump( asmname, statename, params );
            return;
        }
    #/
    
    startnode = gettraversalstartnode();
    endpos = self getnegotiationendpos();
    assert( isdefined( startnode ) );
    assert( isdefined( endpos ) );
    
    if ( !isdefined( startnode.startnodeoriginalangles ) )
    {
        startnode.startnodeoriginalangles = startnode.angles;
    }
    
    angleoffset = startnode.angles - startnode.startnodeoriginalangles;
    
    if ( angleoffset != ( 0, 0, 0 ) )
    {
        endpos = rotatevector( endpos, angleoffset );
    }
    
    jump_over_position = undefined;
    var_3016b22139446579 = getdvarint( @"hash_db3bdaface7c82ec", 0 );
    
    if ( var_3016b22139446579 != 2 )
    {
        if ( isdefined( startnode.jump_over_offset ) )
        {
            jump_over_offset = startnode.jump_over_offset;
            
            if ( angleoffset != ( 0, 0, 0 ) )
            {
                jump_over_offset = rotatevector( jump_over_offset, angleoffset );
            }
            
            jump_over_position = startnode.origin + jump_over_offset;
            var_e5e2b98a87142185 = jump_over_position[ 2 ];
            var_e5e2b98a87142185 -= 44;
            
            if ( var_e5e2b98a87142185 > endpos[ 2 ] )
            {
                halfway_x = ( startnode.origin[ 0 ] + endpos[ 0 ] ) * 0.5;
                halfway_y = ( startnode.origin[ 1 ] + endpos[ 1 ] ) * 0.5;
                jump_over_position = ( halfway_x, halfway_y, jump_over_position[ 2 ] );
            }
            else
            {
                jump_over_position = undefined;
            }
        }
    }
    
    jumpanim = asm_getanim( asmname, statename );
    assert( isdefined( jumpanim ) );
    self.jump_over_position = jump_over_position;
    
    /#
        if ( getdvarint( @"hash_db3bdaface7c82ec", 0 ) != 0 )
        {
            if ( isdefined( jump_over_position ) )
            {
                function_52e0db833127ec95( self.origin, jump_over_position, ( 128, 0, 255 ), 100 );
                function_52e0db833127ec95( self.origin, endpos, ( 128, 0, 255 ), 100 );
            }
            else
            {
                function_52e0db833127ec95( self.origin, endpos, ( 128, 255, 0 ), 100 );
            }
        }
    #/
    
    nextstatename = statename + "_finish";
    
    if ( doublejumpneedsfinishanim( asmname, nextstatename, startnode, endpos ) )
    {
        delta = endpos - startnode.origin;
        delta = ( delta[ 0 ], delta[ 1 ], 0 );
        desiredangles = vectortoangles( delta );
        nextstatename = statename + "_finish";
        offsetpos = getdoublejumpoffsetposition( asmname, nextstatename, endpos, desiredangles, "footstep_left_small" );
        endpos = offsetpos;
    }
    
    delta = endpos - startnode.origin;
    var_4c4c6c6d3c2b086b = 0;
    animendtime = 1;
    
    if ( delta[ 2 ] < 0 )
    {
        var_4c4c6c6d3c2b086b = 1;
        touchgroundtime = getnotetracktimes( asm_getxanim( statename, jumpanim ), "gravity on" );
        
        if ( isdefined( touchgroundtime ) && touchgroundtime.size > 0 )
        {
            animendtime = touchgroundtime[ 0 ];
        }
    }
    
    delta = ( delta[ 0 ], delta[ 1 ], 0 );
    desiredangles = vectortoangles( delta );
    playscaledjump( asmname, statename, jumpanim, endpos, desiredangles, animendtime, var_4c4c6c6d3c2b086b, 1 );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x1570
// Size: 0xe5
function choosedoublejumpanim( asmname, statename, params )
{
    endpos = self getnegotiationendpos();
    assert( isdefined( endpos ) );
    alias = "double_jump_up";
    
    if ( isdefined( params ) )
    {
        assert( params == "<dev string:x107>" || params == "<dev string:x10d>" );
        alias = "double_jump_" + params;
    }
    else if ( endpos[ 2 ] < self.origin[ 2 ] )
    {
        alias = "double_jump_down";
    }
    
    if ( self.asm.footsteps.foot == "right" )
    {
        prefix = "right_";
    }
    else
    {
        prefix = "left_";
    }
    
    alias = prefix + alias;
    animname = asm_lookupanimfromalias( statename, alias );
    return animname;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 2
// Checksum 0x0, Offset: 0x165e
// Size: 0x125
function getwallnodeposition( startnode, index )
{
    assert( index >= 0 );
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    assert( isdefined( startnode.wall_info.nodeoffsets ) );
    assert( startnode.wall_info.nodeoffsets.size > index );
    angleoffset = startnode.angles - startnode.wall_info.startnodeoriginalangles;
    
    if ( angleoffset != ( 0, 0, 0 ) )
    {
        worlddelta = rotatevector( startnode.wall_info.nodeoffsets[ index ], angleoffset );
        nodeposition = startnode.origin + worlddelta;
    }
    else
    {
        nodeposition = startnode.origin + startnode.wall_info.nodeoffsets[ index ];
    }
    
    return nodeposition;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 4
// Checksum 0x0, Offset: 0x178c
// Size: 0x15a, Type: bool
function shouldwallrunshoot( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.enemy ) )
    {
        return false;
    }
    
    enemypos = self.enemy.origin;
    startnode = self.traversal_start_node;
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    assert( isdefined( self.wall_run_current_node_index ) );
    assert( startnode.wall_info.nodeoffsets.size > self.wall_run_current_node_index + 1 );
    wallstartpos = getwallnodeposition( startnode, self.wall_run_current_node_index );
    wallendpos = getwallnodeposition( startnode, self.wall_run_current_node_index + 1 );
    wallendpos = ( wallendpos[ 0 ], wallendpos[ 1 ], wallstartpos[ 2 ] );
    enemypos = ( enemypos[ 0 ], enemypos[ 1 ], wallstartpos[ 2 ] );
    walldir = vectornormalize( wallendpos - wallstartpos );
    enemydir = vectornormalize( enemypos - wallstartpos );
    dot = vectordot( walldir, enemydir );
    
    if ( dot < 0.2588 )
    {
        return false;
    }
    
    return true;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x18ef
// Size: 0x4b
function choosewallrunanim( asmname, statename, params )
{
    assert( isdefined( self.wall_run_direction ) );
    jumpanim = asm_lookupanimfromalias( statename, self.wall_run_direction );
    return jumpanim;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 1
// Checksum 0x0, Offset: 0x1943
// Size: 0x42
function getsmoothstep( delta )
{
    /#
        if ( getdvarint( @"hash_dd616d5851bec943", 1 ) == 2 )
        {
            return ( delta * delta * delta * ( delta * ( delta * 6 - 15 ) + 10 ) );
        }
    #/
    
    return delta * delta * ( 3 - 2 * delta );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 6
// Checksum 0x0, Offset: 0x198e
// Size: 0x16e
function teleportdeltaovernumframes( statename, waittime, delta, numframes, animname, playbackrate )
{
    self endon( statename + "_finished" );
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    framedelta = delta / numframes;
    startpos = self.origin[ 2 ];
    endpos = startpos + delta[ 2 ];
    lastz = self.origin[ 2 ];
    self setanimrate( animname, playbackrate );
    
    for ( i = 0; i < numframes ; i++ )
    {
        var_3897e5e4048f4e94 = 1;
        
        /#
            if ( getdvarint( @"hash_dd616d5851bec943", 1 ) == 0 )
            {
                var_3897e5e4048f4e94 = 0;
            }
        #/
        
        if ( var_3897e5e4048f4e94 )
        {
            pct = i / ( numframes - 1 );
            smoothstep = getsmoothstep( pct );
            newz = endpos * smoothstep + startpos * ( 1 - smoothstep );
            newdeltaz = newz - lastz;
            framedelta = ( framedelta[ 0 ], framedelta[ 1 ], newdeltaz );
            lastz = newz;
        }
        
        neworigin = self.origin + framedelta;
        self forceteleport( neworigin );
        
        if ( i + 1 < numframes )
        {
            waitframe();
        }
    }
    
    self setanimrate( animname, 1 );
}

/#

    // Namespace traverse / scripts\asm\soldier\traverse
    // Params 2
    // Checksum 0x0, Offset: 0x1b04
    // Size: 0x54, Type: dev
    function debugdest( dest, statename )
    {
        self notify( "<dev string:x115>" );
        self endon( "<dev string:x115>" );
        self endon( statename + "<dev string:x127>" );
        
        while ( true )
        {
            line( self.origin, dest, ( 0, 255, 0 ) );
            waitframe();
        }
    }

#/

// Namespace traverse / scripts\asm\soldier\traverse
// Params 2
// Checksum 0x0, Offset: 0x1b60
// Size: 0x3f
function wallrunnotehandler( note, params )
{
    if ( note == "start_jump" )
    {
        thread handlejumpteleports( params );
        return;
    }
    
    if ( note == "end_mantle" )
    {
        self animmode( "gravity" );
    }
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x1ba7
// Size: 0x376
function handlejumpteleports( params, animtime, playbackrate )
{
    assert( isarray( params ) );
    assert( params.size == 7 );
    statename = params[ 0 ];
    animname = params[ 1 ];
    desiredendpos = params[ 2 ];
    starttime = params[ 3 ];
    var_8c2c7ea3bd382df4 = params[ 4 ];
    var_4c4c6c6d3c2b086b = params[ 5 ];
    var_87ef9fdeb401c595 = params[ 6 ];
    self endon( statename + "_finished" );
    animlength = getanimlength( animname );
    
    if ( !isdefined( animtime ) )
    {
        animtime = ( gettime() - starttime ) * 0.001;
    }
    
    animtimepct = animtime / animlength;
    endjumptime = getnotetracktimes( animname, "end_jump" );
    var_930caef7352c0f86 = getnotetracktimes( animname, "end_double_jump" );
    
    if ( var_930caef7352c0f86.size > 0 )
    {
        self.wall_run_double_jumping = 1;
        endjumptime = var_930caef7352c0f86;
    }
    else
    {
        self.wall_run_double_jumping = 0;
    }
    
    assert( endjumptime.size > 0 );
    
    if ( isdefined( self.jump_over_position ) )
    {
        var_8c2c7ea3bd382df4 = ( endjumptime[ 0 ] - animtimepct ) / 2 + animtimepct;
        endjumptime[ 0 ] = var_8c2c7ea3bd382df4;
        desiredendpos = self.jump_over_position;
    }
    
    movedelta = getmovedelta( animname, animtimepct, var_8c2c7ea3bd382df4 );
    animendpos = self localtoworldcoords( movedelta );
    
    /#
        if ( getdvarint( @"ai_debugwallrun", 0 ) != 0 && isdefined( self.traversal_start_node ) )
        {
            disttoanimend = distance( self.origin, animendpos );
            disttodesiredpos = distance( self.origin, desiredendpos );
            var_e37286be71cbc5cd = disttodesiredpos / disttoanimend;
            
            if ( var_e37286be71cbc5cd < 0.8 || var_e37286be71cbc5cd > 1.2 )
            {
                println( "<dev string:x134>" + self.traversal_start_node.origin + "<dev string:x160>" + animname + "<dev string:x178>" + var_e37286be71cbc5cd );
                println( "<dev string:x180>" + disttoanimend + "<dev string:x191>" + disttodesiredpos );
            }
        }
    #/
    
    if ( !isdefined( playbackrate ) )
    {
        playbackrate = 1;
    }
    
    if ( var_87ef9fdeb401c595 )
    {
        disttoanimend = distance( self.origin, animendpos );
        disttodesiredpos = distance( self.origin, desiredendpos );
        playbackrate = disttoanimend / disttodesiredpos;
        
        if ( playbackrate < 0.7 )
        {
            playbackrate = 0.7;
        }
        else if ( playbackrate > 1.3 )
        {
            playbackrate = 1.3;
        }
    }
    
    scaledelta = desiredendpos - animendpos;
    var_e7f1395489e50fc7 = endjumptime[ 0 ] * animlength;
    jumpduration = var_e7f1395489e50fc7 - animtimepct * animlength;
    jumpduration *= 1 / playbackrate;
    numframes = jumpduration * 20;
    numframes = ceil( numframes );
    teleportstarttime = gettime();
    teleportdeltaovernumframes( statename, 0, scaledelta, numframes, animname, playbackrate );
    
    if ( isdefined( self.jump_over_position ) )
    {
        animtimedelta = ( gettime() - teleportstarttime ) * playbackrate;
        realanimtime = animtime + animtimedelta * 0.001;
        self.jump_over_position = undefined;
        params[ 6 ] = 0;
        handlejumpteleports( params, realanimtime, playbackrate );
    }
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 1
// Checksum 0x0, Offset: 0x1f25
// Size: 0x74
function getwallrunyawfromstartnode( startnode )
{
    assert( isdefined( startnode.wall_info ) );
    assert( startnode.wall_info.nodeoffsets.size >= 2 );
    delta = getwallnodeposition( startnode, 1 ) - getwallnodeposition( startnode, 0 );
    desiredangles = vectortoangles( delta );
    return desiredangles[ 1 ];
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 1
// Checksum 0x0, Offset: 0x1fa2
// Size: 0xf9
function getwallrundirectionfromstartnode( startnode )
{
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    assert( startnode.wall_info.nodeoffsets.size >= 2 );
    self.wall_run_current_node_index = 0;
    delta = getwallnodeposition( startnode, 1 ) - getwallnodeposition( startnode, 0 );
    desiredangles = vectortoangles( delta );
    self.wall_run_yaw = desiredangles[ 1 ];
    startposition = getwallnodeposition( startnode, self.wall_run_current_node_index );
    right = anglestoright( desiredangles );
    dir = startposition - startnode.origin;
    dot = vectordot( right, dir );
    
    if ( dot > 0 )
    {
        return "right";
    }
    
    return "left";
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 0
// Checksum 0x0, Offset: 0x20a4
// Size: 0x64
function setupwallrunifneeded()
{
    if ( isdefined( self.wall_run_direction ) )
    {
        return;
    }
    
    if ( !isdefined( self.traversal_start_node ) )
    {
        self.traversal_start_node = self getnegotiationstartnode();
    }
    
    assert( isdefined( self.traversal_start_node ) );
    startnode = self.traversal_start_node;
    self.wall_run_direction = getwallrundirectionfromstartnode( startnode );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 0
// Checksum 0x0, Offset: 0x2110
// Size: 0x12
function getwallrundirection()
{
    setupwallrunifneeded();
    return self.wall_run_direction;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x212b
// Size: 0x72
function wallrunterminate( asmname, statename, params )
{
    self.wall_run_current_node_index = undefined;
    self.wall_run_direction = undefined;
    self.wall_run_double_jumping = undefined;
    self.wall_run_yaw = undefined;
    self.wall_run_attach_anim = undefined;
    self setdefaultaimlimits();
    self.useanimgoalweight = 0;
    self.jump_over_position = undefined;
    self.traversal_start_node = undefined;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x21a5
// Size: 0x4f
function traversalorientearlyterminate( asmname, statename, params )
{
    if ( !asm_eventfired( asmname, "end" ) && !asm_eventfired( asmname, "code_move" ) )
    {
        self.traversal_start_node = undefined;
        self.wall_run_direction = undefined;
    }
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x21fc
// Size: 0x140
function playwallrunattach( asmname, statename, params )
{
    self animmode( "noclip" );
    self orientmode( "face angle", self.angles[ 1 ] );
    self.useanimgoalweight = 1;
    
    if ( isdefined( params ) && params == "shoot" )
    {
        setupwallrunaimlimits();
    }
    
    animid = asm_getanim( asmname, statename );
    xanim = asm_getxanim( statename, animid );
    var_bf02a06228e2e48e = getnotetracktimes( xanim, "wall_contact" );
    assert( isdefined( var_bf02a06228e2e48e ) && var_bf02a06228e2e48e.size > 0 );
    time = var_bf02a06228e2e48e[ 0 ];
    angledelta = getangledelta( xanim, 0, time );
    faceyaw = self.wall_run_yaw - angledelta;
    forceangles = ( 0, faceyaw, 0 );
    self forceteleport( self.origin, forceangles );
    self aisetanim( statename, animid );
    asm_playfacialanim( asmname, statename, xanim );
    endnote = asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 1
// Checksum 0x0, Offset: 0x2344
// Size: 0xa8
function getwallattachoffsetposition( asmname )
{
    animname = choosewallattachanim( asmname, "wall_run_attach" );
    assert( isdefined( animname ) );
    var_bf02a06228e2e48e = getnotetracktimes( animname, "wall_contact" );
    assert( isdefined( var_bf02a06228e2e48e ) && var_bf02a06228e2e48e.size > 0 );
    time = var_bf02a06228e2e48e[ 0 ];
    animdelta = getmovedelta( animname, 0, time );
    animangledelta = getangledelta( animname, 0, time );
    return scripts\asm\soldier\cover::calcanimstartpos( getwallnodeposition( self.traversal_start_node, 0 ), self.wall_run_yaw, animdelta, animangledelta );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x23f5
// Size: 0x1af
function playwallrunenter( asmname, statename, params )
{
    self endon( statename + "_finished" );
    animid = asm_getanim( asmname, statename );
    xanim = asm_getxanim( statename, animid );
    startnode = self.traversal_start_node;
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    assert( startnode.wall_info.nodeoffsets.size >= 2 );
    self.wall_run_current_node_index = 0;
    wallnodepos = getwallnodeposition( startnode, 0 );
    delta = wallnodepos - self.origin;
    delta = ( delta[ 0 ], delta[ 1 ], 0 );
    desiredangles = vectortoangles( delta );
    jumpdestination = getwallattachoffsetposition();
    self orientmode( "face angle", desiredangles[ 1 ] );
    assert( isdefined( self.wall_run_direction ) );
    
    /#
        if ( getdvarint( @"ai_debugwallrun", 0 ) != 0 )
        {
            function_52e0db833127ec95( self.origin, jumpdestination, ( 128, 0, 255 ), 100 );
        }
    #/
    
    animendtime = 1;
    codemovetime = getnotetracktimes( xanim, "code_move" );
    
    if ( isdefined( codemovetime ) && codemovetime.size > 0 )
    {
        animendtime = codemovetime[ 0 ];
    }
    
    playscaledjump( asmname, statename, animid, jumpdestination, desiredangles, animendtime, 0, 1 );
    self forceteleport( jumpdestination, desiredangles );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 8
// Checksum 0x0, Offset: 0x25ac
// Size: 0x110
function playscaledjump( asmname, statename, animid, desiredposition, desiredangles, var_8c2c7ea3bd382df4, var_4c4c6c6d3c2b086b, var_87ef9fdeb401c595 )
{
    self endon( statename + "_finished" );
    
    if ( !isdefined( var_8c2c7ea3bd382df4 ) )
    {
        var_8c2c7ea3bd382df4 = 1;
    }
    
    if ( !isdefined( var_4c4c6c6d3c2b086b ) )
    {
        var_4c4c6c6d3c2b086b = 0;
    }
    
    if ( !isdefined( var_87ef9fdeb401c595 ) )
    {
        var_87ef9fdeb401c595 = 0;
    }
    
    self forceteleport( self.origin, desiredangles );
    self animmode( "noclip" );
    self orientmode( "face angle", desiredangles[ 1 ] );
    xanim = asm_getxanim( statename, animid );
    self.useanimgoalweight = 1;
    self aisetanim( statename, animid );
    asm_playfacialanim( asmname, statename, xanim );
    notetrackparams = [ statename, xanim, desiredposition, gettime(), var_8c2c7ea3bd382df4, var_4c4c6c6d3c2b086b, var_87ef9fdeb401c595 ];
    asm_donotetracks( asmname, statename, &wallrunnotehandler, notetrackparams );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x26c4
// Size: 0xb7
function choosewallattachanim( asmname, statename, params )
{
    if ( isdefined( self.wall_run_attach_anim ) )
    {
        return self.wall_run_attach_anim;
    }
    
    aliasname = self.wall_run_direction;
    yawdelta = angleclamp180( self.wall_run_yaw - self.angles[ 1 ] );
    yawdelta = abs( yawdelta );
    
    if ( yawdelta >= 22.5 )
    {
        if ( yawdelta > 67.5 )
        {
            aliasname += "_90";
        }
        else
        {
            aliasname += "_45";
        }
    }
    
    self.wall_run_attach_anim = asm_lookupanimfromalias( statename, aliasname );
    return self.wall_run_attach_anim;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x2784
// Size: 0x1a2
function choosewallrunenteranim( asmname, statename, params )
{
    setupwallrunifneeded();
    assert( isdefined( self.wall_run_direction ) );
    assert( isdefined( self.traversal_start_node ) );
    alias = self.wall_run_direction;
    startnode = self.traversal_start_node;
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    assert( startnode.wall_info.nodeoffsets.size >= 2 );
    jumptopos = getwallnodeposition( startnode, 0 );
    zdelta = jumptopos[ 2 ] - self.origin[ 2 ];
    bdoublejump = 0;
    
    if ( zdelta >= 0 )
    {
        if ( zdelta > 120 )
        {
            bdoublejump = 1;
        }
    }
    else if ( 0 - zdelta > 240 )
    {
        bdoublejump = 1;
    }
    
    if ( bdoublejump == 0 )
    {
        distsq = distancesquared( self.origin, jumptopos );
        
        if ( distsq > 40000 )
        {
            bdoublejump = 1;
        }
    }
    
    prefix = "left_";
    
    if ( self.asm.footsteps.foot == "right" )
    {
        prefix = "right_";
    }
    
    if ( bdoublejump )
    {
        alias = prefix + "double_jump";
    }
    else
    {
        alias = prefix + "single_jump";
    }
    
    jumpanim = asm_lookupanimfromalias( statename, alias );
    return jumpanim;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 5
// Checksum 0x0, Offset: 0x292f
// Size: 0x47
function senddelayedevent( asmname, statename, time, event, var_775aaa9fdd143162 )
{
    self endon( statename + "_finished" );
    wait time;
    asm_fireevent( asmname, event );
    
    if ( var_775aaa9fdd143162 )
    {
        self notify( event );
    }
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 4
// Checksum 0x0, Offset: 0x297e
// Size: 0xbc, Type: bool
function hasanotherwallrun( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.wall_run_current_node_index ) )
    {
        return false;
    }
    
    startnode = self.traversal_start_node;
    
    if ( !isdefined( startnode ) )
    {
        return false;
    }
    
    assert( isdefined( startnode.wall_info ) );
    var_a3e2cf82e6f677a4 = self.wall_run_current_node_index + 2;
    
    if ( startnode.wall_info.nodeoffsets.size <= var_a3e2cf82e6f677a4 )
    {
        return false;
    }
    
    assert( startnode.wall_info.nodeoffsets.size > var_a3e2cf82e6f677a4 + 1 );
    return true;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x2a43
// Size: 0x10a
function playwallruncontinue( asmname, statename, params )
{
    self endon( statename + "_finished" );
    startnode = self.traversal_start_node;
    self function_62004d7561fd321e();
    assert( isdefined( startnode ) );
    self.wall_run_current_node_index += 2;
    assert( startnode.wall_info.nodeoffsets.size > self.wall_run_current_node_index + 1 );
    endpos = getwallnodeposition( startnode, self.wall_run_current_node_index );
    desiredangles = self.angles;
    
    if ( self.wall_run_direction == "left" )
    {
        self.wall_run_direction = "right";
    }
    else
    {
        self.wall_run_direction = "left";
    }
    
    animid = asm_getanim( asmname, statename );
    playscaledjump( asmname, statename, animid, endpos, desiredangles );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 1
// Checksum 0x0, Offset: 0x2b55
// Size: 0xdd
function getwallrunmantleposition( startnode )
{
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    assert( isdefined( startnode.wall_info.mantleoffset ) );
    angleoffset = startnode.angles - startnode.wall_info.startnodeoriginalangles;
    
    if ( angleoffset == ( 0, 0, 0 ) )
    {
        return ( startnode.origin + startnode.wall_info.mantleoffset );
    }
    
    worlddelta = rotatevector( startnode.wall_info.mantleoffset, angleoffset );
    return startnode.origin + worlddelta;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 1
// Checksum 0x0, Offset: 0x2c3b
// Size: 0xb7
function getwallrunmantleangles( startnode )
{
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    
    if ( !isdefined( startnode.wall_info.mantleangles ) )
    {
        return undefined;
    }
    
    angleoffset = startnode.angles[ 1 ] - startnode.wall_info.startnodeoriginalangles[ 1 ];
    
    if ( angleoffset == 0 )
    {
        return startnode.wall_info.mantleangles;
    }
    
    return ( 0, angleclamp180( startnode.wall_info.mantleangles[ 1 ] + angleoffset ), 0 );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 0
// Checksum 0x0, Offset: 0x2cfb
// Size: 0x71
function getwallruntomantletype()
{
    startnode = self.traversal_start_node;
    assert( isdefined( startnode ) );
    
    if ( !isdefined( startnode.wall_info.mantleoffset ) )
    {
        return "none";
    }
    
    mantlepos = getwallrunmantleposition( startnode );
    
    if ( mantlepos[ 2 ] >= self.origin[ 2 ] )
    {
        return "high";
    }
    
    return "low";
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 4
// Checksum 0x0, Offset: 0x2d75
// Size: 0x73
function shouldwallruntovault( asmname, statename, tostatename, params )
{
    startnode = self.traversal_start_node;
    assert( isdefined( startnode ) );
    
    if ( !isdefined( startnode.wall_info.bvaultover ) )
    {
        return 0;
    }
    
    return startnode.wall_info.bvaultover;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x2df1
// Size: 0x2b1
function playwallrunloop( asmname, statename, params )
{
    self endon( statename + "_finished" );
    startnode = self.traversal_start_node;
    assert( isdefined( startnode ) );
    assert( isdefined( startnode.wall_info ) );
    setupwallrunaimlimits();
    loopanim = asm_getanim( asmname, statename );
    assert( isdefined( loopanim ) );
    loopxanim = asm_getxanim( statename, loopanim );
    movedelta = getmovedelta( loopxanim );
    animmovedist = length2d( movedelta );
    assert( animmovedist > 0 );
    
    if ( !isdefined( startnode.wall_info.mantleoffset ) && self.wall_run_current_node_index == startnode.wall_info.nodeoffsets.size - 2 )
    {
        exitanim = asm_getanim( asmname, "wall_run_exit" );
        assert( isdefined( exitanim ) );
        exitxanim = asm_getxanim( "wall_run_exit", exitanim );
        var_7a01b5ed5ca503cd = getnotetracktimes( exitxanim, "start_jump" );
        assert( isdefined( var_7a01b5ed5ca503cd ) && var_7a01b5ed5ca503cd.size > 0 );
        exitanimlength = getanimlength( exitxanim );
        exitmovedelta = getmovedelta( exitxanim, 0, var_7a01b5ed5ca503cd[ 0 ] );
        exitmovedist = length2d( exitmovedelta );
    }
    else
    {
        exitmovedist = 0;
    }
    
    assert( startnode.wall_info.nodeoffsets.size > self.wall_run_current_node_index + 1 );
    delta = getwallnodeposition( startnode, self.wall_run_current_node_index + 1 ) - self.origin;
    desiredmovedist = length( delta );
    desiredmovedist -= exitmovedist;
    
    if ( desiredmovedist < 0 )
    {
        desiredmovedist = 0;
    }
    
    var_aeb58353cbdd1e6d = desiredmovedist / animmovedist;
    animlength = getanimlength( loopxanim );
    animtimeneeded = animlength * var_aeb58353cbdd1e6d;
    thread senddelayedevent( asmname, statename, animtimeneeded, "wall_run_loop_done", 1 );
    desiredmovedir = vectornormalize( delta );
    self orientmode( "face direction", desiredmovedir );
    thread playwallrunendsound( statename );
    self animmode( "noclip" );
    self aisetanim( statename, loopanim );
    asm_playfacialanim( asmname, statename, loopxanim );
    asm_donotetracks( asmname, statename );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 1
// Checksum 0x0, Offset: 0x30aa
// Size: 0x33
function playwallrunendsound( statename )
{
    self endon( "death" );
    
    if ( soundexists( "wallrun_end_npc" ) )
    {
        self waittill( "wall_run_loop_done" );
        self playsound( "wallrun_end_npc" );
    }
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x30e5
// Size: 0x1d6
function choosewallrunexitanim( asmname, statename, params )
{
    alias = self.wall_run_direction;
    endpos = self getnegotiationendpos();
    zdelta = endpos[ 2 ] - self.origin[ 2 ];
    bdoublejump = 0;
    
    if ( zdelta >= 0 )
    {
        if ( zdelta > 120 )
        {
            bdoublejump = 1;
        }
    }
    else if ( 0 - zdelta > 240 )
    {
        bdoublejump = 1;
    }
    
    if ( bdoublejump == 0 )
    {
        distsq = distancesquared( self.origin, endpos );
        
        if ( distsq > 46225 )
        {
            bdoublejump = 1;
        }
    }
    
    if ( bdoublejump )
    {
        alias += "_double";
    }
    
    endpos = self getnegotiationendpos();
    startnode = self.traversal_start_node;
    assert( isdefined( startnode.wall_info.nodeoffsets[ startnode.wall_info.nodeoffsets.size - 1 ] ) );
    dir = self getnegotiationendpos() - getwallnodeposition( startnode, startnode.wall_info.nodeoffsets.size - 1 );
    dir = ( dir[ 0 ], dir[ 1 ], 0 );
    dir = vectornormalize( dir );
    desiredangles = vectortoangles( dir );
    yawdelta = angleclamp180( desiredangles[ 1 ] - self.angles[ 1 ] );
    yawdelta = abs( yawdelta );
    
    if ( yawdelta >= 22.5 )
    {
        if ( yawdelta > 67.5 )
        {
            alias += "_90";
        }
        else
        {
            alias += "_45";
        }
    }
    
    jumpanim = asm_lookupanimfromalias( statename, alias );
    return jumpanim;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x32c4
// Size: 0x168
function playwallrunexit( asmname, statename, params )
{
    self endon( statename + "_finished" );
    startnode = self.traversal_start_node;
    endpos = self getnegotiationendpos();
    assert( isdefined( startnode ) );
    assert( isdefined( endpos ) );
    assert( isdefined( startnode.wall_info ) );
    desiredangles = self.angles;
    var_8c2c7ea3bd382df4 = 1;
    animname = asm_getanim( asmname, statename );
    groundtime = getnotetracktimes( animname, "ground" );
    self function_62004d7561fd321e();
    
    if ( isdefined( groundtime ) && groundtime.size > 0 )
    {
        var_8c2c7ea3bd382df4 = groundtime[ 0 ];
    }
    else
    {
        var_930caef7352c0f86 = getnotetracktimes( animname, "end_double_jump" );
        
        if ( isdefined( var_930caef7352c0f86 ) && var_930caef7352c0f86.size > 0 )
        {
            var_8c2c7ea3bd382df4 = var_930caef7352c0f86[ 0 ];
        }
        else
        {
            endjumptime = getnotetracktimes( animname, "end_jump" );
            
            if ( isdefined( endjumptime ) && endjumptime.size > 0 )
            {
                var_8c2c7ea3bd382df4 = endjumptime[ 0 ];
            }
        }
    }
    
    if ( soundexists( "wallrun_end_npc" ) )
    {
        self playsound( "wallrun_end_npc" );
    }
    
    playscaledjump( asmname, statename, animname, endpos, desiredangles, var_8c2c7ea3bd382df4, 1, 1 );
    thread terminatewallruntraverse( asmname, statename );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 4
// Checksum 0x0, Offset: 0x3434
// Size: 0xc1, Type: bool
function isnotdoingwallruntransition( asmname, statename, tostatename, params )
{
    if ( isdefined( self.traversal_start_node ) )
    {
        return false;
    }
    
    /#
        if ( getdvarint( @"ai_debugwallrun", 0 ) != 0 )
        {
            if ( self setuptraversaltransitioncheck( asmname, statename, tostatename, params ) )
            {
                thread draworigin();
                thread drawdebugline( self.traversal_start_node.origin, ( 0, 0, 1 ), ( 1, 0, 0 ) );
                thread debugwallrun( statename, self.traversal_start_node, self getnegotiationendpos() );
                self.traversal_start_node = undefined;
                self.wall_run_direction = undefined;
            }
        }
    #/
    
    return true;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 2
// Checksum 0x0, Offset: 0x34fe
// Size: 0x55
function terminatewallruntraverse( asmname, statename )
{
    self.wall_run_current_node_index = undefined;
    self.wall_run_direction = undefined;
    self.wall_run_double_jumping = undefined;
    self.wall_run_yaw = undefined;
    self.wall_run_attach_anim = undefined;
    self setdefaultaimlimits();
    terminatetraverse( asmname, statename );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x355b
// Size: 0x241
function playwallruntomantle( asmname, statename, params )
{
    self endon( statename + "_finished" );
    startnode = self.traversal_start_node;
    endnodepos = self getnegotiationendpos();
    assert( isdefined( startnode ) );
    assert( isdefined( endnodepos ) );
    mantleendpos = getwallrunmantleposition( startnode );
    
    if ( isdefined( startnode.wall_info.bvaultover ) || getwallruntomantletype() == "high" )
    {
        mantleangles = getwallrunmantleangles( startnode );
        
        if ( !isdefined( mantleangles ) )
        {
            delta = endnodepos - mantleendpos;
            delta = ( delta[ 0 ], delta[ 1 ], 0 );
            mantleangles = vectortoangles( delta );
        }
    }
    else
    {
        delta = mantleendpos - self.origin;
        delta = ( delta[ 0 ], delta[ 1 ], 0 );
        mantleangles = vectortoangles( delta );
    }
    
    mantleanim = asm_getanim( asmname, statename );
    assert( isdefined( mantleanim ) );
    animlength = getanimlength( mantleanim );
    var_fa917664aea6e292 = getnotetracktimes( mantleanim, "start_mantle" );
    assert( var_fa917664aea6e292.size > 0 );
    var_40d329cf034e4307 = var_fa917664aea6e292[ 0 ];
    var_4f0ca52986969139 = getnotetracktimes( mantleanim, "end_mantle" );
    assert( var_4f0ca52986969139.size > 0 );
    var_45d80567424231ae = var_4f0ca52986969139[ 0 ];
    var_99b01baf607ed310 = getmovedelta( mantleanim, var_40d329cf034e4307, var_45d80567424231ae );
    self forceteleport( self.origin, mantleangles );
    var_6f31e626554d6ab9 = self localtoworldcoords( var_99b01baf607ed310 );
    actualdelta = var_6f31e626554d6ab9 - self.origin;
    mantlestartpos = mantleendpos - actualdelta;
    
    /#
        if ( getdvarint( @"ai_debugwallrun", 0 ) != 0 )
        {
            function_52e0db833127ec95( self.origin, mantlestartpos, ( 255, 0, 0 ), 100 );
        }
    #/
    
    playscaledjump( asmname, statename, mantleanim, mantlestartpos, mantleangles, var_40d329cf034e4307, 0, 1 );
    thread terminatewallruntraverse( asmname, statename );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x37a4
// Size: 0x2f8
function playtraversaltransition( asmname, statename, params )
{
    self endon( statename + "_finished" );
    animid = asm_getanim( asmname, statename );
    
    if ( !isdefined( animid ) )
    {
        asm_fireevent( asmname, "code_move" );
        return;
    }
    
    xanim = asm_getxanim( statename, animid );
    animendtime = 1;
    notetracktimes = undefined;
    
    if ( getdvarint( @"hash_f13997d88562c7b5", 1 ) == 1 )
    {
        notetracktimes = getnotetracktimes( xanim, "align" );
    }
    
    if ( !isdefined( notetracktimes ) || notetracktimes.size == 0 )
    {
        notetracktimes = getnotetracktimes( xanim, "code_move" );
    }
    
    if ( isdefined( notetracktimes ) && notetracktimes.size > 0 )
    {
        animendtime = notetracktimes[ 0 ];
    }
    
    stopdelta = getmovedelta( xanim, 0, animendtime );
    stopangledelta = getangledelta( xanim, 0, animendtime );
    negotiationnode = self.traversal_start_node;
    assert( isdefined( negotiationnode ) );
    
    /#
        if ( getdvarint( @"ai_debugwallrun", 0 ) != 0 && self.traversal_start_node.animscript == "<dev string:x1a3>" )
        {
            thread draworigin();
            thread drawdebugline( negotiationnode.origin, ( 0, 0, 1 ), ( 1, 0, 0 ) );
            thread debugwallrun( statename, self.traversal_start_node, self getnegotiationendpos() );
        }
    #/
    
    anim_length = getanimlength( xanim ) * animendtime;
    var_64366dd6eea5221d = int( ceil( anim_length * 20 ) );
    
    if ( self.traversal_start_node.animscript == "wall_run" )
    {
        var_7fe6f6537340df66 = getwallnodeposition( self.traversal_start_node, 0 ) - self.origin;
        var_71ab5f95b941ad8d = vectortoangles( var_7fe6f6537340df66 );
        desiredyaw = var_71ab5f95b941ad8d[ 1 ];
    }
    else
    {
        desireddelta = self getnegotiationendpos() - self.traversal_start_node.origin;
        desireddelta = ( desireddelta[ 0 ], desireddelta[ 1 ], 0 );
        desiredangles = vectortoangles( desireddelta );
        desiredyaw = desiredangles[ 1 ];
    }
    
    stopstartpos = scripts\asm\soldier\cover::calcanimstartpos( negotiationnode.origin, desiredyaw, stopdelta, stopangledelta );
    arrivalyaw = desiredyaw - stopangledelta;
    self.a.arrivalasmstatename = statename;
    self.useanimgoalweight = 1;
    self startcoverarrival( stopstartpos, arrivalyaw, var_64366dd6eea5221d );
    self aisetanim( statename, animid );
    asm_playfacialanim( asmname, statename, xanim );
    asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x3aa4
// Size: 0x120
function choosetraversaltransition( asmname, statename, params )
{
    approachdir = anglestoforward( self.angles );
    approachangles = vectortoangles( approachdir );
    
    if ( self.traversal_start_node.animscript == "wall_run" )
    {
        desiredangles = vectortoangles( getwallnodeposition( self.traversal_start_node, 0 ) - self.origin );
    }
    else
    {
        desireddelta = self getnegotiationendpos() - self.traversal_start_node.origin;
        desireddelta = ( desireddelta[ 0 ], desireddelta[ 1 ], 0 );
        desiredangles = vectortoangles( desireddelta );
    }
    
    desiredyaw = desiredangles[ 1 ];
    anglediff = angleclamp180( desiredyaw - approachangles[ 1 ] );
    angleindex = getangleindex( anglediff, 22.5 );
    stopanims = getstopanims( asmname, statename, undefined, 1 );
    
    if ( !isdefined( stopanims[ angleindex ] ) )
    {
        return undefined;
    }
    
    return stopanims[ angleindex ];
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 4
// Checksum 0x0, Offset: 0x3bcd
// Size: 0x59, Type: bool
function shouldabortwallrunattach( asmname, statename, tostatename, params )
{
    distsq = distance2dsquared( self.origin, getwallnodeposition( self.traversal_start_node, 1 ) );
    
    if ( distsq < 144 )
    {
        return true;
    }
    
    return false;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 4
// Checksum 0x0, Offset: 0x3c2f
// Size: 0x3f, Type: bool
function shouldtraversetransitionto( asmname, statename, tostatename, params )
{
    if ( tostatename == self.traversal_start_node.animscript )
    {
        return true;
    }
    
    return false;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 1
// Checksum 0x0, Offset: 0x3c77
// Size: 0x54, Type: bool
function istraversaltransitionsupported( animscript )
{
    switch ( animscript )
    {
        case #"hash_3083e73248cdb399":
        case #"hash_5f054fa72e77b8dd":
        case #"hash_6fc6878fd3fd1e7a":
        case #"hash_8f681d217a32aef7":
        case #"hash_d14662a6eb371af5":
            return true;
    }
    
    return false;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 4
// Checksum 0x0, Offset: 0x3cd4
// Size: 0x301, Type: bool
function shoulddotraversaltransition( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.traversal_start_node ) )
    {
        return false;
    }
    
    if ( !istraversaltransitionsupported( self.traversal_start_node.animscript ) )
    {
        return false;
    }
    
    if ( !self.facemotion )
    {
        return false;
    }
    
    traversal_direction = undefined;
    
    if ( self.traversal_start_node.animscript == "wall_run" )
    {
        traversal_direction = getwallrundirectionfromstartnode( self.traversal_start_node );
        desireddelta = getwallnodeposition( self.traversal_start_node, 0 ) - self.origin;
        desiredangles = vectortoangles( desireddelta );
    }
    else
    {
        desireddelta = self getnegotiationendpos() - self.traversal_start_node.origin;
        desireddelta = ( desireddelta[ 0 ], desireddelta[ 1 ], 0 );
        traversal_direction = vectornormalize( desireddelta );
        desiredangles = vectortoangles( traversal_direction );
    }
    
    traversalyaw = desiredangles[ 1 ];
    approachdir = anglestoforward( self.angles );
    approachangles = vectortoangles( approachdir );
    anglediff = angleclamp180( traversalyaw - approachangles[ 1 ] );
    angleindex = getangleindex( anglediff, 22.5 );
    stopanims = getstopanims( asmname, tostatename, undefined, 1 );
    stopanim = stopanims[ angleindex ];
    
    if ( !isdefined( stopanim ) )
    {
        return false;
    }
    
    animendtime = 1;
    notetracktimes = undefined;
    
    if ( getdvarint( @"hash_f13997d88562c7b5", 1 ) == 1 )
    {
        notetracktimes = getnotetracktimes( stopanim, "align" );
    }
    
    if ( !isdefined( notetracktimes ) || notetracktimes.size == 0 )
    {
        notetracktimes = getnotetracktimes( stopanim, "code_move" );
    }
    
    if ( isdefined( notetracktimes ) && notetracktimes.size > 0 )
    {
        animendtime = notetracktimes[ 0 ];
    }
    
    stopdelta = getmovedelta( stopanim, 0, animendtime );
    stopangledelta = getangledelta( stopanim, 0, animendtime );
    disttonode = distance2d( self.origin, self.traversal_start_node.origin );
    animstopdist = length( stopdelta );
    delta = disttonode - animstopdist;
    
    if ( delta < 0 )
    {
        traversedir = anglestoforward( desiredangles );
        dot = vectordot( approachdir, traversedir );
        
        if ( dot > 0.707 )
        {
            if ( abs( delta ) > 10 )
            {
                return false;
            }
        }
        else if ( abs( delta ) > 64 )
        {
            return false;
        }
    }
    else if ( delta > 10 )
    {
        return false;
    }
    
    if ( self.traversal_start_node.animscript == "wall_run" )
    {
        self.wall_run_direction = traversal_direction;
    }
    
    return true;
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 1
// Checksum 0x0, Offset: 0x3fde
// Size: 0x2e
function handlewallrunattachnotetrack( note )
{
    if ( note == "wall_contact" )
    {
        if ( soundexists( "wallrun_start_npc" ) )
        {
            self playsound( "wallrun_start_npc" );
        }
    }
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 0
// Checksum 0x0, Offset: 0x4014
// Size: 0x2e
function setupwallrunaimlimits()
{
    self.upaimlimit = -89;
    self.downaimlimit = 45;
    self.rightaimlimit = -90;
    self.leftaimlimit = 90;
}

/#

    // Namespace traverse / scripts\asm\soldier\traverse
    // Params 3
    // Checksum 0x0, Offset: 0x404a
    // Size: 0x71, Type: dev
    function drawdebugline( pos, normal, color )
    {
        self notify( "<dev string:x1af>" );
        level endon( "<dev string:x1c5>" );
        self endon( "<dev string:x1d3>" );
        level endon( "<dev string:x1dc>" );
        self endon( "<dev string:x1af>" );
        lineend = pos + normal * 100;
        
        while ( true )
        {
            line( pos, lineend, color, 1, 1, 1 );
            wait 0.05;
        }
    }

    // Namespace traverse / scripts\asm\soldier\traverse
    // Params 4
    // Checksum 0x0, Offset: 0x40c3
    // Size: 0x3d, Type: dev
    function function_52e0db833127ec95( from, to, color, duration )
    {
        if ( !isdefined( duration ) )
        {
            duration = 5;
        }
        
        line( from, to, color, 1, 1, duration );
    }

    // Namespace traverse / scripts\asm\soldier\traverse
    // Params 0
    // Checksum 0x0, Offset: 0x4108
    // Size: 0x99, Type: dev
    function draworigin()
    {
        self notify( "<dev string:x1ec>" );
        level endon( "<dev string:x1c5>" );
        self endon( "<dev string:x1d3>" );
        level endon( "<dev string:x1dc>" );
        self endon( "<dev string:x1ec>" );
        color = ( 0, 0, 1 );
        normal = ( 0, 0, 1 );
        
        while ( true )
        {
            pos = self.origin;
            lineend = pos + normal * 100;
            line( pos, lineend, color, 1, 1, 1 );
            wait 0.05;
        }
    }

    // Namespace traverse / scripts\asm\soldier\traverse
    // Params 3
    // Checksum 0x0, Offset: 0x41a9
    // Size: 0x127, Type: dev
    function debugwallrun( statename, startnode, endpos )
    {
        color1 = ( 0, 1, 0 );
        color2 = ( 0, 0, 1 );
        color = color1;
        line( startnode.origin, getwallnodeposition( startnode, 0 ), color, 1, 1, 300 );
        currentpos = startnode.origin;
        
        for ( i = 0; i < startnode.wall_info.nodeoffsets.size - 1 ; i++ )
        {
            if ( i % 2 == 0 )
            {
                color = color2;
            }
            else
            {
                color = color1;
            }
            
            currentpos = getwallnodeposition( startnode, i );
            line( currentpos, getwallnodeposition( startnode, i + 1 ), color, 1, 1, 300 );
            currentpos = getwallnodeposition( startnode, i + 1 );
            
            if ( i % 2 == 0 )
            {
                color = color1;
                continue;
            }
            
            color = color2;
        }
        
        line( currentpos, endpos, color, 1, 1, 300 );
    }

#/

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x42d8
// Size: 0x429
function playtraverseanim_ladder( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self aisetisonladder( 1 );
    startnode = self getnegotiationstartnode();
    endpos = self getnegotiationendpos();
    assert( isdefined( startnode ) );
    self animmode( "noclip", 0 );
    self orientmode( "face angle", startnode.angles[ 1 ] );
    starttoend = endpos - startnode.origin;
    demeanor = asm_getdemeanor();
    climbanim = undefined;
    mountanim = undefined;
    dismountanim = undefined;
    dropdownanim = 0;
    
    if ( starttoend[ 2 ] > 0 )
    {
        offalias = "off_" + demeanor;
        dismountanim = asm_lookupanimfromaliasifexists( statename, offalias );
        
        if ( !isdefined( dismountanim ) )
        {
            if ( !isdefined( startnode.traverse_drop_height_delta ) || startnode.traverse_drop_height_delta < 6 )
            {
                dismountanim = asm_lookupanimfromalias( statename, "off" );
            }
            else if ( startnode.traverse_drop_height_delta < 36 )
            {
                dismountanim = asm_lookupanimfromalias( statename, "off_low" );
                dropdownanim = 1;
            }
            else if ( startnode.traverse_drop_height_delta < 60 )
            {
                dismountanim = asm_lookupanimfromalias( statename, "off_mid" );
                dropdownanim = 1;
            }
            else
            {
                dismountanim = asm_lookupanimfromalias( statename, "off_high" );
                dropdownanim = 1;
            }
        }
        
        climbanim = asm_lookupanimfromalias( statename, "up" );
    }
    else
    {
        onalias = "on_" + demeanor;
        dismountanim = asm_lookupanimfromaliasifexists( statename, onalias );
        
        if ( !isdefined( dismountanim ) )
        {
            mountanim = asm_lookupanimfromalias( statename, "on" );
        }
        
        climbanim = asm_lookupanimfromalias( statename, "down" );
    }
    
    rate = 1;
    
    if ( isdefined( self.moveplaybackrate ) )
    {
        rate = self.moveplaybackrate;
    }
    
    if ( isdefined( mountanim ) )
    {
        self aisetanim( statename, mountanim, rate );
        asm_donotetracks( asmname, statename );
    }
    
    loopendpos = endpos;
    
    if ( isdefined( dismountanim ) )
    {
        dismountxanim = asm_getxanim( statename, dismountanim );
        dismounttranslation = getmovedelta( dismountxanim );
        
        if ( dropdownanim )
        {
            loopendpos = startnode.traverse_height - ( 0, 0, 48 );
        }
        else
        {
            loopendpos = endpos - dismounttranslation + ( 0, 0, 1 );
        }
    }
    
    assert( isdefined( climbanim ) );
    var_29dc8002ce343a5d = loopendpos - self.origin;
    
    if ( var_29dc8002ce343a5d[ 2 ] * starttoend[ 2 ] > 0 )
    {
        climbxanim = asm_getxanim( statename, climbanim );
        climbanimtranslation = getmovedelta( climbxanim );
        var_2f9556e4b32808e = climbanimtranslation[ 2 ] * rate / getanimlength( climbxanim );
        climbtime = var_29dc8002ce343a5d[ 2 ] / var_2f9556e4b32808e;
        assert( climbtime > 0 );
        
        if ( !isdefined( climbxanim ) || !isdefined( climbanimtranslation ) || !isdefined( var_2f9556e4b32808e ) || !isdefined( climbtime ) )
        {
            arcname = function_2285421dfc79c4d5();
            basearcname = self.basearchetype;
            println( "<dev string:x202>" + climbanim + "<dev string:x229>" + arcname + "<dev string:x23d>" + statename + "<dev string:x24b>" + basearcname + "<dev string:x26e>" );
        }
        
        self aisetanim( statename, climbanim, rate );
        asm_donotetracksfortime( asmname, statename, climbtime );
    }
    
    if ( isdefined( dismountanim ) )
    {
        self aisetanim( statename, dismountanim, rate );
        waitframe();
        notetrackhandle = &scripts\asm\traverse::handletraversewarpnotetracks;
        self.traversestartnode = startnode;
        self.traverseendnode = self getnegotiationendnode();
        self.var_70a168924eccff58 = endpos;
        self.traversexanim = asm_getxanim( statename, dismountanim );
        asm_donotetracks( asmname, statename, notetrackhandle );
        self.var_70a168924eccff58 = undefined;
    }
    
    terminatetraverse( asmname, statename );
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x4709
// Size: 0x58
function terminate_ladder( asmname, statename, params )
{
    bisdead = !isalive( self );
    self.nogravityragdoll = bisdead;
    self aisetisonladder( 0 );
    self.var_70a168924eccff58 = undefined;
    
    if ( bisdead )
    {
        self.forceragdollimmediate = 0;
    }
}

// Namespace traverse / scripts\asm\soldier\traverse
// Params 3
// Checksum 0x0, Offset: 0x4769
// Size: 0x92
function traverse_basic( asmname, statename, params )
{
    self endon( statename + "_finished" );
    traverseanim = asm_getanim( asmname, statename );
    self animmode( "noclip", 0 );
    startnode = self getnegotiationstartnode();
    self orientmode( "face angle", startnode.angles[ 1 ] );
    self aisetanim( statename, traverseanim );
    asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
    terminatetraverse( asmname, statename );
}

