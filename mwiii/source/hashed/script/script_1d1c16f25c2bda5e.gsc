#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace shared;

// Namespace shared / namespace_80c14191b262bb30
// Params 1
// Checksum 0x0, Offset: 0x162
// Size: 0x6e
function teleportthread( verticaloffset )
{
    self endon( "killanimscript" );
    self notify( "endTeleportThread" );
    self endon( "endTeleportThread" );
    reps = 5;
    offset = ( 0, 0, verticaloffset / reps );
    
    for ( i = 0; i < reps ; i++ )
    {
        self forceteleport( self.origin + offset );
        wait 0.05;
    }
}

// Namespace shared / namespace_80c14191b262bb30
// Params 4
// Checksum 0x0, Offset: 0x1d8
// Size: 0x100
function teleportthreadex( verticaloffset, delay, frames, animrate )
{
    self endon( "killanimscript" );
    self notify( "endTeleportThread" );
    self endon( "endTeleportThread" );
    
    if ( verticaloffset == 0 || frames <= 0 )
    {
        return;
    }
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    offset = ( 0, 0, verticaloffset / frames );
    
    if ( isdefined( animrate ) && animrate < 1 )
    {
        self setflaggedanimknoball( "traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, animrate );
    }
    
    for ( i = 0; i < frames ; i++ )
    {
        self forceteleport( self.origin + offset );
        wait 0.05;
    }
    
    if ( isdefined( animrate ) && animrate < 1 )
    {
        self setflaggedanimknoball( "traverseAnim", self.traverseanim, self.traverseanimroot, 1, 0.2, 1 );
    }
}

/#

    // Namespace shared / namespace_80c14191b262bb30
    // Params 1
    // Checksum 0x0, Offset: 0x2e0
    // Size: 0x19, Type: dev
    function dotraverse( traversedata )
    {
        assertmsg( "<dev string:x1c>" );
    }

#/

// Namespace shared / namespace_80c14191b262bb30
// Params 1
// Checksum 0x0, Offset: 0x301
// Size: 0x44
function handletraversenotetracks( note )
{
    if ( note == "traverse_death" )
    {
        return handletraversedeathnotetrack();
    }
    
    if ( note == "traverse_align" )
    {
        return handletraversealignment();
    }
    
    if ( note == "traverse_drop" )
    {
        return handletraversedrop();
    }
}

// Namespace shared / namespace_80c14191b262bb30
// Params 0
// Checksum 0x0, Offset: 0x34d
// Size: 0x48
function handletraversedeathnotetrack()
{
    if ( isdefined( self.traversedeathanim ) )
    {
        deathanimarray = self.traversedeathanim[ self.traversedeathindex ];
        set_deathanim( deathanimarray[ randomint( deathanimarray.size ) ] );
        self.traversedeathindex++;
    }
}

// Namespace shared / namespace_80c14191b262bb30
// Params 0
// Checksum 0x0, Offset: 0x39d
// Size: 0xa8
function handletraversealignment()
{
    self animmode( "noclip" );
    targettraverseheight = undefined;
    
    if ( self.var_32a34987ee1b3095 == "nodeless" || self.var_32a34987ee1b3095 == "linkless" )
    {
        targettraverseheight = self.var_64b933af90edc53c.traverse_height;
    }
    else
    {
        targettraverseheight = self.traversestartnode.traverse_height;
    }
    
    if ( isdefined( self.traverseheight ) && isdefined( targettraverseheight ) )
    {
        currentheight = targettraverseheight - self.traversestartz;
        thread teleportthread( currentheight - self.traverseheight );
    }
}

// Namespace shared / namespace_80c14191b262bb30
// Params 0
// Checksum 0x0, Offset: 0x44d
// Size: 0x19a
function handletraversedrop()
{
    startpos = self.origin + ( 0, 0, 32 );
    endpos = physicstrace( startpos, self.origin + ( 0, 0, -512 ) );
    dist = distance( startpos, endpos );
    realdropheight = dist - 32 - 0.5;
    traverseanimpos = self getanimtime( self.traverseanim );
    traverseanimdelta = getmovedelta( self.traverseanim, traverseanimpos, 1 );
    traverseanimlength = getanimlength( self.traverseanim );
    animdropheight = 0 - traverseanimdelta[ 2 ];
    assertex( animdropheight >= 0, animdropheight );
    dropoffset = animdropheight - realdropheight;
    
    /#
        if ( getdvarint( @"hash_60bc1b675216e3d" ) )
        {
            thread scripts\anim\utility::debugline( startpos, endpos, ( 1, 1, 1 ), 40 );
            thread scripts\anim\utility::drawstringtime( "<dev string:x62>" + dropoffset, endpos, ( 1, 1, 1 ), 2 );
        }
    #/
    
    if ( animdropheight < realdropheight )
    {
        animrate = animdropheight / realdropheight;
    }
    else
    {
        animrate = 1;
    }
    
    teleportlength = ( traverseanimlength - traverseanimpos ) / 3;
    numframes = ceil( teleportlength * 20 );
    thread teleportthreadex( dropoffset, 0, numframes, animrate );
    thread finishtraversedrop( endpos[ 2 ] );
}

// Namespace shared / namespace_80c14191b262bb30
// Params 1
// Checksum 0x0, Offset: 0x5ef
// Size: 0x49
function finishtraversedrop( finalz )
{
    self endon( "killanimscript" );
    finalz += 4;
    
    while ( true )
    {
        if ( self.origin[ 2 ] < finalz )
        {
            self animmode( "gravity" );
            break;
        }
        
        wait 0.05;
    }
}

// Namespace shared / namespace_80c14191b262bb30
// Params 0
// Checksum 0x0, Offset: 0x640
// Size: 0x16
function donothingfunc()
{
    self animmode( "zonly_physics" );
    self waittill( "killanimscript" );
}

/#

    // Namespace shared / namespace_80c14191b262bb30
    // Params 4
    // Checksum 0x0, Offset: 0x65e
    // Size: 0x31, Type: dev
    function dog_jump_down( frames, rate, traversal_anim, var_5a11f5d9304a0c83 )
    {
        assertmsg( "<dev string:x73>" );
    }

#/

// Namespace shared / namespace_80c14191b262bb30
// Params 0
// Checksum 0x0, Offset: 0x697
// Size: 0xa
function seeker_traversal()
{
    self waittill( "killanimscript" );
}

