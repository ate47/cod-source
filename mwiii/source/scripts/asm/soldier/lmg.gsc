#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace lmg;

// Namespace lmg / scripts\asm\soldier\lmg
// Params 3
// Checksum 0x0, Offset: 0x13b
// Size: 0x6f
function playcovercrouchlmg( asmname, statename, params )
{
    self._blackboard.droppedlmg = 0;
    thread asm_playanimstate( asmname, statename );
    self.asm.track.prev_time = 0;
    self.rightaimlimit = -80;
    self.leftaimlimit = 80;
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 3
// Checksum 0x0, Offset: 0x1b2
// Size: 0x124
function coverturretterminate( asmname, statename, params )
{
    self setdefaultaimlimits();
    currentturret = self getturret();
    
    if ( !isdefined( currentturret ) || isdefined( self.asm.turret ) && currentturret == self.asm.turret )
    {
        self stopuseturret();
    }
    
    if ( isdefined( self.asm.turret ) )
    {
        self.asm.turret.origin = self.asm.turretorigin;
        self.asm.turret.angles = self.asm.turretangles;
    }
    
    self.asm.turret = undefined;
    self.asm.turretorigin = undefined;
    self.asm.turretangles = undefined;
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 3
// Checksum 0x0, Offset: 0x2de
// Size: 0x22
function coverlmgterminate( asmname, statename, params )
{
    self setdefaultaimlimits();
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 3
// Checksum 0x0, Offset: 0x308
// Size: 0xb2
function playanim_droplmg( asmname, statename, params )
{
    scripts\anim\shared::dropaiweapon();
    
    if ( !isnullweapon( self.sidearm ) )
    {
        self.weapon = self.sidearm;
        self.bulletsinclip = weaponclipsize( self.weapon );
        scripts\anim\shared::updateweaponarchetype( weaponclass( self.weapon ) );
    }
    else
    {
        scripts\anim\shared::updateweaponarchetype( "null" );
    }
    
    self._blackboard.inlmgstate = 0;
    self._blackboard.deployedlmgnode = undefined;
    asm_playanimstate( asmname, statename, params );
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 4
// Checksum 0x0, Offset: 0x3c2
// Size: 0x2a, Type: bool
function turretrequested( asmname, statename, tostatename, params )
{
    return isdefined( scripts\asm\asm_bb::bb_getrequestedturret() );
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 3
// Checksum 0x0, Offset: 0x3f5
// Size: 0x71
function chooseanim_deploylmg( asmname, statename, params )
{
    if ( istrue( self._blackboard.droppedlmg ) )
    {
        assert( self.node == self._blackboard.deployedlmgnode );
        return asm_lookupanimfromalias( statename, "remount" );
    }
    
    return asm_lookupanimfromalias( statename, "default" );
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 3
// Checksum 0x0, Offset: 0x46f
// Size: 0xf7
function playanim_deployturret( asmname, statename, params )
{
    self._blackboard.usingaturret = 1;
    assert( isdefined( scripts\asm\asm_bb::bb_getrequestedturret() ) );
    turret = scripts\asm\asm_bb::bb_getrequestedturret();
    assert( distancesquared( turret.origin, self.origin ) < 4096 );
    assert( !isdefined( self.customnotetrackhandler ) );
    asm_playanimstatenotransition( asmname, statename, params );
    self.asm.turretorigin = turret.origin;
    self.asm.turretangles = turret.angles;
    self.asm.turret = turret;
    self useturret( scripts\asm\asm_bb::bb_getrequestedturret() );
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 3
// Checksum 0x0, Offset: 0x56e
// Size: 0xed
function noanim_deployturret( asmname, statename, params )
{
    self._blackboard.usingaturret = 1;
    assert( isdefined( scripts\asm\asm_bb::bb_getrequestedturret() ) );
    turret = scripts\asm\asm_bb::bb_getrequestedturret();
    assert( distancesquared( turret.origin, self.origin ) < 4096 );
    assert( !isdefined( self.customnotetrackhandler ) );
    self.asm.turretorigin = turret.origin;
    self.asm.turretangles = turret.angles;
    self.asm.turret = turret;
    self useturret( scripts\asm\asm_bb::bb_getrequestedturret() );
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 3
// Checksum 0x0, Offset: 0x663
// Size: 0x3a
function playanim_dismountturret( asmname, statename, params )
{
    self._blackboard.usingaturret = 0;
    asm_playanimstate( asmname, statename, params );
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 4
// Checksum 0x0, Offset: 0x6a5
// Size: 0xb8
function shoulddismountlmg( asmname, statename, tostatename, params )
{
    if ( self._blackboard.usingaturret )
    {
        turret = self getturret();
        requestedturret = scripts\asm\asm_bb::bb_getrequestedturret();
        usingturret = isdefined( turret ) && turret getturretowner() == self;
        usingrequestedturret = usingturret && isdefined( requestedturret ) && requestedturret == turret;
        return !usingrequestedturret;
    }
    
    moverequested = scripts\asm\asm_bb::bb_moverequested();
    atcovernode = scripts\asm\shared\utility::isatcovernode();
    return moverequested || !atcovernode;
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 3
// Checksum 0x0, Offset: 0x765
// Size: 0x1a5
function playanim_deploylmg( asmname, statename, params )
{
    if ( isdefined( self.node ) )
    {
        self._blackboard.deployedlmgnode = self.node;
        self.keepclaimednodeifvalid = 1;
    }
    
    assert( !isdefined( self.customnotetrackhandler ) );
    self.customnotetrackhandler = &notehandler_deploylmg;
    self._blackboard.inlmgstate = 1;
    animid = asm_getanim( asmname, statename );
    xanim = asm_getxanim( statename, animid );
    
    if ( isdefined( self.node ) )
    {
        if ( istrue( self._blackboard.droppedlmg ) )
        {
            self forceteleport( self.node.origin, self.angles );
            self orientmode( "face angle", self.node.angles[ 1 ] );
        }
        else
        {
            animangle = getangledelta( xanim );
            desiredyaw = self.node.angles[ 1 ] - animangle;
            self orientmode( "face angle", desiredyaw );
        }
    }
    else
    {
        self orientmode( "face angle", self.angles[ 1 ] );
    }
    
    self endon( statename + "_finished" );
    self aisetanim( statename, animid );
    asm_playfacialanim( asmname, statename, xanim );
    asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 3
// Checksum 0x0, Offset: 0x912
// Size: 0x25
function terminate_deploylmg( asmname, statename, params )
{
    self.customnotetrackhandler = undefined;
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 3
// Checksum 0x0, Offset: 0x93f
// Size: 0x4c
function playanim_dismountlmg( asmname, statename, params )
{
    self._blackboard.deployedlmgnode = undefined;
    self._blackboard.inlmgstate = 0;
    asm_playanimstate( asmname, statename );
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 4
// Checksum 0x0, Offset: 0x993
// Size: 0xda
function notehandler_deploylmg( note, flagname, customfunction, customparams )
{
    switch ( note )
    {
        case #"hash_187a1588294dd34e":
            scripts\anim\shared::placeweaponon( self.weapon, "none" );
            break;
        case #"hash_c24ff1dd3ebd3f6c":
            assert( isdefined( self._blackboard.leftweaponent ) );
            self._blackboard.leftweaponent delete();
            self._blackboard.leftweaponent = undefined;
            assert( weaponclass( self.primaryweapon ) == "<dev string:x1c>" );
            scripts\anim\shared::placeweaponon( self.primaryweapon, "right" );
            break;
    }
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 4
// Checksum 0x0, Offset: 0xa75
// Size: 0x63, Type: bool
function lowestcoverstanddeployposeis( asmname, statename, tostatename, params )
{
    assert( isdefined( params ) );
    
    if ( isdefined( self.node ) )
    {
        if ( !self.node isvalidpeekoutdir( "over" ) )
        {
            return ( params == "high" );
        }
        
        return ( params == "stand" );
    }
    
    return false;
}

// Namespace lmg / scripts\asm\soldier\lmg
// Params 4
// Checksum 0x0, Offset: 0xae1
// Size: 0x5c, Type: bool
function desiredturretposeis( asmname, statename, tostatename, params )
{
    assert( isdefined( params ) );
    
    if ( isdefined( self._blackboard.requestedturretpose ) )
    {
        return ( self._blackboard.requestedturretpose == params );
    }
    
    return false;
}

