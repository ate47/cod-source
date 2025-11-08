#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace asm_bb;

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x15d
// Size: 0xc
function bb_getprefixstring( category )
{
    return undefined;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x172
// Size: 0x5f
function bb_wantstostrafe()
{
    if ( isdefined( self._blackboard.meleerequested ) && self._blackboard.meleerequested )
    {
        return 1;
    }
    
    if ( isdefined( self._blackboard.bwantstostrafe ) )
    {
        return self._blackboard.bwantstostrafe;
    }
    
    return 0;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x1da
// Size: 0x20
function bb_requeststance( stance )
{
    self._blackboard.desiredstance = stance;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x202
// Size: 0x15
function bb_getrequestedstance()
{
    return self._blackboard.desiredstance;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0x220
// Size: 0x38, Type: bool
function bb_isrequestedstance_refresh( asmname, statename, tostatename, params )
{
    requestedstance = determinerequestedstance();
    return requestedstance == params;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0x261
// Size: 0x5d, Type: bool
function bb_isrequestedstanceanddemeanor( asmname, statename, tostatename, params )
{
    assert( isdefined( params ) && params.size == 2 );
    return self._blackboard.desiredstance == params[ 0 ] && scripts\asm\asm::asm_getdemeanor() == params[ 1 ];
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x2c7
// Size: 0x1c
function bb_setisincombat( bincombat )
{
    self.bisincombat = !isdefined( bincombat ) || bincombat;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x2eb
// Size: 0xb
function bb_isincombat()
{
    return self.bisincombat;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0x2ff
// Size: 0x33, Type: bool
function bb_isweaponclass( asmname, statename, tostatename, params )
{
    return weaponclass( self.weapon ) == params;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0x33b
// Size: 0x5c, Type: bool
function bb_shoulddroprocketlauncher( asmname, statename, tostatename, params )
{
    if ( weaponclass( self.weapon ) != "rocketlauncher" )
    {
        return false;
    }
    
    requestedweapon = bb_getrequestedweapon();
    
    if ( !isdefined( requestedweapon ) )
    {
        return false;
    }
    
    return requestedweapon != "rocketlauncher";
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x3a0
// Size: 0x2
function bb_requestmove()
{
    
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x3aa
// Size: 0x2
function bb_clearmoverequest()
{
    
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x3b4
// Size: 0x8
function bb_moverequested()
{
    return self codemoverequested();
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x3c5
// Size: 0x20, Type: bool
function bb_movetyperequested( movetype )
{
    return self._blackboard.movetype == movetype;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x3ee
// Size: 0x20
function bb_requestmovetype( movetype )
{
    self._blackboard.movetype = movetype;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x416
// Size: 0x20
function bb_requestweapon( weapon )
{
    self._blackboard.weaponrequest = weapon;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x43e
// Size: 0x1b
function bb_clearweaponrequest()
{
    self._blackboard.weaponrequest = "none";
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x461
// Size: 0x4b
function bb_getrequestedweapon()
{
    if ( isdefined( self._blackboard.weaponrequest ) && self._blackboard.weaponrequest == "none" )
    {
        return undefined;
    }
    
    return self._blackboard.weaponrequest;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x4b5
// Size: 0x3e
function bb_requestreload( breload )
{
    if ( !isdefined( breload ) )
    {
        self._blackboard.breload = 1;
        return;
    }
    
    self._blackboard.breload = breload;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x4fb
// Size: 0x15
function bb_reloadrequested()
{
    return self._blackboard.breload;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x519
// Size: 0x46, Type: bool
function bb_throwgrenaderequested()
{
    if ( isdefined( self._blackboard.bthrowgrenade ) )
    {
        return ( self._blackboard.bthrowgrenade && isdefined( self._blackboard.throwgrenadetarget ) );
    }
    
    return false;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x568
// Size: 0x15
function bb_getthrowgrenadetarget()
{
    return self._blackboard.throwgrenadetarget;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x586
// Size: 0x3e
function bb_requestfire( bfire )
{
    if ( !isdefined( bfire ) )
    {
        self._blackboard.bfire = 1;
        return;
    }
    
    self._blackboard.bfire = bfire;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x5cc
// Size: 0x16, Type: bool
function bb_firerequested()
{
    return istrue( self._blackboard.bfire );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x5eb
// Size: 0x20
function bb_claimshootparams( taskid )
{
    self._blackboard.shootparams_taskid = taskid;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x613
// Size: 0x5b, Type: bool
function bb_shootparams_idsmatch()
{
    if ( !istrue( self._blackboard.shootparams_valid ) )
    {
        return false;
    }
    
    if ( !isdefined( self._blackboard.shootparams_readid ) )
    {
        return false;
    }
    
    return self._blackboard.shootparams_writeid == self._blackboard.shootparams_readid;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x677
// Size: 0x3d
function bb_updateshootparams_pos( pos )
{
    assert( istrue( self._blackboard.shootparams_valid ) );
    self._blackboard.shootparams_pos = pos;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x6bc
// Size: 0x2a
function bb_clearshootparams()
{
    self._blackboard.shootparams_ent = undefined;
    self._blackboard.shootparams_valid = 0;
}

/#

    // Namespace asm_bb / scripts\asm\asm_bb
    // Params 2
    // Checksum 0x0, Offset: 0x6ee
    // Size: 0x21, Type: dev
    function bb_setshootparams( shootparams, target )
    {
        assertmsg( "<dev string:x1c>" );
    }

#/

// Namespace asm_bb / scripts\asm\asm_bb
// Params 2
// Checksum 0x0, Offset: 0x717
// Size: 0x1c
function bb_requestcoverstate( state, var_55b1b4a8c2ba7aa2 )
{
    self setcoverstate( state, var_55b1b4a8c2ba7aa2 );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x73b
// Size: 0x32
function bb_getrequestedcoverstate()
{
    if ( !isdefined( self._blackboard.coverstate ) )
    {
        return "none";
    }
    
    return self._blackboard.coverstate;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x776
// Size: 0x20
function bb_requestcoverexposetype( exposetype )
{
    self._blackboard.coverexposetype = exposetype;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x79e
// Size: 0x15
function bb_getrequestedcoverexposetype()
{
    return self._blackboard.coverexposetype;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x7bc
// Size: 0x20
function bb_requestcoverblindfire( var_690e06db214b7bec )
{
    self._blackboard.blindfire = var_690e06db214b7bec;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x7e4
// Size: 0x15
function bb_setcovernode( node )
{
    self.covernode = node;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0x801
// Size: 0x2d, Type: bool
function bb_hadcovernode( asmname, statename, tostatename, params )
{
    return isdefined( self.covernode );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x837
// Size: 0xb
function bb_getcovernode()
{
    return self.covernode;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x84b
// Size: 0x2e
function bb_getrequestedturret()
{
    if ( isdefined( self._blackboard.requestedturret ) )
    {
        return self._blackboard.requestedturret;
    }
    
    return undefined;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x882
// Size: 0x66
function bb_requestturret( turret )
{
    self._blackboard.requestedturret = turret;
    
    if ( isdefined( turret.script_delay_min ) )
    {
        self.var_29ca84991e64ec65 = turret.script_delay_min;
    }
    
    if ( isdefined( turret.script_delay_max ) )
    {
        self.var_29ee8e991e8d7d1b = turret.script_delay_max;
    }
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x8f0
// Size: 0x58
function bb_requestturretpose( pose )
{
    assert( !isdefined( pose ) || pose == "<dev string:x4b>" || pose == "<dev string:x54>" || pose == "<dev string:x5e>" || pose == "<dev string:x67>" );
    self._blackboard.requestedturretpose = pose;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0x950
// Size: 0x8e, Type: bool
function bb_hasshufflenode( asmname, statename, tostatename, params )
{
    return isdefined( self._blackboard.shufflenode ) && isdefined( self.node ) && self._blackboard.shufflenode == self.node && distancesquared( self.node.origin, self.origin ) > 16;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x9e7
// Size: 0x18
function bb_setanimscripted()
{
    self._blackboard.animscriptedactive = 1;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xa07
// Size: 0x17
function bb_clearanimscripted()
{
    self._blackboard.animscriptedactive = 0;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xa26
// Size: 0x4b, Type: bool
function bb_isanimscripted()
{
    if ( isdefined( self.script ) )
    {
        if ( self.script == "scripted" || self.script == "<custom>" )
        {
            return true;
        }
    }
    
    return istrue( self._blackboard.animscriptedactive );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0xa7a
// Size: 0x4b
function bb_requestmelee( target )
{
    self._blackboard.meleerequested = 1;
    self._blackboard.meleerequestedtarget = target;
    self._blackboard.meleerequestedcomplete = 0;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xacd
// Size: 0x2d
function bb_getmeleetarget()
{
    if ( !self._blackboard.meleerequested )
    {
        return undefined;
    }
    
    return self._blackboard.meleerequestedtarget;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xb03
// Size: 0x2a
function bb_clearmeleerequest()
{
    self._blackboard.meleerequested = 0;
    self._blackboard.meleerequestedtarget = undefined;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xb35
// Size: 0x15
function bb_clearmeleerequestcomplete()
{
    self._blackboard.meleerequestedcomplete = undefined;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0xb52
// Size: 0x37, Type: bool
function bb_meleeinprogress( asmname, statename, tostatename, params )
{
    return isdefined( self._blackboard.meleerequestedcomplete );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0xb92
// Size: 0x4e, Type: bool
function bb_meleecomplete( asmname, statename, tostatename, params )
{
    return isdefined( self._blackboard.meleerequestedcomplete ) && self._blackboard.meleerequestedcomplete;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xbe9
// Size: 0x15
function bb_meleerequested()
{
    return self._blackboard.meleerequested;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0xc07
// Size: 0x43, Type: bool
function bb_meleerequestinvalid( asmname, statename, tostatename, params )
{
    if ( !self.in_melee )
    {
        return true;
    }
    
    if ( !isdefined( self.meleetarget ) )
    {
        return true;
    }
    
    return false;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 2
// Checksum 0x0, Offset: 0xc53
// Size: 0x5e
function bb_requestmeleecharge( target, targetpos )
{
    assert( isdefined( targetpos ) );
    self._blackboard.meleerequestedcharge = 1;
    self._blackboard.meleerequestedcharge_target = target;
    self._blackboard.meleerequestedcharge_targetposition = targetpos;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xcb9
// Size: 0x3d
function bb_clearmeleechargerequest()
{
    self._blackboard.meleerequestedcharge = 0;
    self._blackboard.meleerequestedcharge_target = undefined;
    self._blackboard.meleerequestedcharge_targetposition = undefined;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xcfe
// Size: 0x3b, Type: bool
function bb_meleechargerequested()
{
    return isdefined( self._blackboard.meleerequestedcharge ) && self._blackboard.meleerequestedcharge && isdefined( self.pathgoalpos );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0xd42
// Size: 0x30, Type: bool
function bb_meleechargeaborted( asmname, statename, tostatename, params )
{
    if ( bb_meleechargerequested() )
    {
        return false;
    }
    
    return true;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xd7b
// Size: 0x46
function bb_getmeleechargetarget()
{
    if ( !isdefined( self._blackboard.meleerequestedcharge ) || !self._blackboard.meleerequestedcharge )
    {
        return undefined;
    }
    
    return self._blackboard.meleerequestedcharge_target;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xdca
// Size: 0x49
function bb_getmeleechargetargetpos()
{
    assert( isdefined( self._blackboard.meleerequestedcharge ) && self._blackboard.meleerequestedcharge );
    return self._blackboard.meleerequestedcharge_targetposition;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0xe1c
// Size: 0x20
function bb_requestgrenadereturnthrow( bthrow )
{
    self._blackboard.bgrenadereturnthrow = bthrow;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xe44
// Size: 0x16, Type: bool
function bb_iswhizbyrequested()
{
    return isdefined( self._blackboard.whizbyeventtime );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xe63
// Size: 0x78, Type: bool
function bb_isfrantic()
{
    covernode = bb_getcovernode();
    
    if ( !isdefined( covernode ) )
    {
        covernode = self.node;
    }
    
    var_a31fcf6fa75167d6 = isdefined( covernode ) && ( covernode.type == "Conceal Crouch" || covernode.type == "Conceal Stand" );
    return self._blackboard.movetype == "frantic" && !var_a31fcf6fa75167d6;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xee4
// Size: 0x1d, Type: bool
function bb_ismissingaleg()
{
    missing = bb_getmissingleg();
    
    if ( isdefined( missing ) )
    {
        return true;
    }
    
    return false;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0xf0a
// Size: 0x90
function bb_getmissingleg()
{
    count = 0;
    str = undefined;
    
    if ( !isdefined( self._blackboard.dismemberedparts ) )
    {
        return str;
    }
    
    if ( isdefined( self._blackboard.dismemberedparts[ "left_leg" ] ) )
    {
        count++;
        str = "left";
    }
    
    if ( isdefined( self._blackboard.dismemberedparts[ "right_leg" ] ) )
    {
        count++;
        str = "right";
    }
    
    if ( count == 2 )
    {
        str = "both";
    }
    
    return str;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0xfa3
// Size: 0xa1, Type: bool
function ispartdismembered( part )
{
    if ( !isdefined( self._blackboard ) )
    {
        return false;
    }
    
    if ( isdefined( self._blackboard.scriptableparts ) )
    {
        if ( !isdefined( self._blackboard.scriptableparts[ part ] ) )
        {
            return false;
        }
        
        return ( self._blackboard.scriptableparts[ part ].state == "dismember" );
    }
    
    if ( !isdefined( self._blackboard.dismemberedparts ) )
    {
        return false;
    }
    
    return isdefined( self._blackboard.dismemberedparts[ part ] );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0x104d
// Size: 0x2a, Type: bool
function bb_ispartdismembered( asmname, statename, tostatename, params )
{
    return ispartdismembered( params );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x1080
// Size: 0xdc, Type: bool
function waspartjustdismembered( part )
{
    if ( isdefined( self._blackboard.scriptableparts ) )
    {
        if ( !isdefined( self._blackboard.scriptableparts[ part ] ) )
        {
            return false;
        }
        
        if ( self._blackboard.scriptableparts[ part ].state != "dismember" )
        {
            return false;
        }
        
        return ( self._blackboard.scriptableparts[ part ].time == gettime() );
    }
    
    if ( !isdefined( self._blackboard.dismemberedparts ) )
    {
        return false;
    }
    
    if ( !isdefined( self._blackboard.dismemberedparts[ part ] ) )
    {
        return false;
    }
    
    return self._blackboard.dismemberedparts[ part ] == gettime();
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0x1165
// Size: 0x2a, Type: bool
function bb_waspartjustdismembered( asmname, statename, tostatename, params )
{
    return waspartjustdismembered( params );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0x1198
// Size: 0x3a, Type: bool
function bb_werepartsdismemberedinorder( asm, statename, tostatename, params )
{
    return ispartdismembered( params[ 0 ] ) && waspartjustdismembered( params[ 1 ] );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x11db
// Size: 0x26
function bb_dismemberedpart( part )
{
    self._blackboard.dismemberedparts[ part ] = gettime();
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x1209
// Size: 0x20
function bb_setselfdestruct( val )
{
    self._blackboard.selfdestruct = val;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x1231
// Size: 0x77, Type: bool
function bb_isselfdestruct()
{
    if ( !isdefined( self._blackboard.selfdestruct ) )
    {
        if ( isdefined( self.bt.forceselfdestructtimer ) && gettime() > self.bt.forceselfdestructtimer )
        {
            self._blackboard.selfdestruct = 1;
        }
    }
    
    return isdefined( self._blackboard.selfdestruct );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x12b1
// Size: 0x18
function bb_selfdestructnow()
{
    self._blackboard.selfdestructnow = 1;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x12d1
// Size: 0x16, Type: bool
function bb_shouldselfdestructnow()
{
    return isdefined( self._blackboard.selfdestructnow );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x12f0
// Size: 0x20
function bb_setheadless( val )
{
    self._blackboard.isheadless = val;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x1318
// Size: 0x2f, Type: bool
function bb_isheadless()
{
    if ( isdefined( self.bt.crawlmeleegrab ) )
    {
        return false;
    }
    
    return isdefined( self._blackboard.isheadless );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 2
// Checksum 0x0, Offset: 0x1350
// Size: 0xb1
function bb_setcanrodeo( side, var_e7096ce45cda4606 )
{
    if ( !isdefined( var_e7096ce45cda4606 ) )
    {
        var_e7096ce45cda4606 = 1;
    }
    
    opposite = "left";
    
    if ( side == opposite )
    {
        opposite = "right";
    }
    
    if ( isdefined( self._blackboard.rodeo ) && isdefined( self._blackboard.rodeo[ opposite ] ) )
    {
        self._blackboard.rodeo[ opposite ] = 0;
        self._blackboard.rodeo[ side ] = 0;
        return;
    }
    
    self._blackboard.rodeo[ side ] = var_e7096ce45cda4606;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x1409
// Size: 0x5b, Type: bool
function bb_canrodeo( side )
{
    if ( !isdefined( self._blackboard.rodeo ) )
    {
        return false;
    }
    
    if ( !isdefined( self._blackboard.rodeo[ side ] ) )
    {
        return false;
    }
    
    if ( !self._blackboard.rodeo[ side ] )
    {
        return false;
    }
    
    return true;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x146d
// Size: 0x20
function bb_setrodeorequest( val )
{
    self._blackboard.rodeorequest = val;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x1495
// Size: 0x1e
function bb_clearrodeorequest( val )
{
    self._blackboard.rodeorequested = undefined;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0x14bb
// Size: 0x3e, Type: bool
function bb_isrodeorequested( asmname, statename, tostatename, params )
{
    if ( !isdefined( self._blackboard.rodeorequest ) )
    {
        return false;
    }
    
    return true;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x1502
// Size: 0x9
function bb_clearmeleetarget()
{
    self function_bdcb37a9431e654();
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x1513
// Size: 0x20
function bb_setcrawlmelee( val )
{
    self._blackboard.crawlmelee = val;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x153b
// Size: 0x16, Type: bool
function bb_iscrawlmelee()
{
    return isdefined( self._blackboard.crawlmelee );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x155a
// Size: 0x20
function bb_sethaywire( val )
{
    self._blackboard.haywire = val;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x1582
// Size: 0x16, Type: bool
function bb_ishaywire()
{
    return isdefined( self._blackboard.haywire );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x15a1
// Size: 0x15
function bb_gethaywire()
{
    return self._blackboard.haywire;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x15bf
// Size: 0x20
function bb_setisinbadcrouchspot( bbadcrouchspot )
{
    self._blackboard.bbadcrouchspot = bbadcrouchspot;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x15e7
// Size: 0x16, Type: bool
function bb_isinbadcrouchspot()
{
    return istrue( self._blackboard.bbadcrouchspot );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x1606
// Size: 0xb
function bb_setcivilianstate( state )
{
    
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x1619
// Size: 0x7
function bb_getcivilianstate()
{
    return "deprecated";
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x1629
// Size: 0x15
function bb_getcivilianstatetime()
{
    return self._blackboard.civstatetime;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x1647
// Size: 0x13
function bb_civilianrequestspeed( speed )
{
    self aisetdesiredspeed( speed );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x1662
// Size: 0x16, Type: bool
function bb_isshort()
{
    return istrue( self._blackboard.bshort );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x1681
// Size: 0x20
function bb_setshort( value )
{
    self._blackboard.bshort = value;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x16a9
// Size: 0x16, Type: bool
function bb_smartobjectrequested()
{
    return isdefined( self._blackboard.smartobject );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 1
// Checksum 0x0, Offset: 0x16c8
// Size: 0xa0
function bb_requestsmartobject( value )
{
    self._blackboard.smartobject = value;
    
    if ( isdefined( self._blackboard.smartobject ) && isdefined( self._blackboard.smartobject.angles ) )
    {
        self._blackboard.smartobjectvalid = 1;
        self._blackboard.smartobjectangles = self._blackboard.smartobject.angles;
    }
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x1770
// Size: 0x15
function bb_getrequestedsmartobject()
{
    return self._blackboard.smartobject;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x178e
// Size: 0x31
function bb_clearsmartobject()
{
    self._blackboard.smartobject = undefined;
    self._blackboard.smartobjectvalid = 0;
    bb_clearplaysmartobject();
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x17c7
// Size: 0x35
function bb_requestplaysmartobject()
{
    assert( isdefined( self._blackboard.smartobject ) );
    self._blackboard.bplaysmartobject = 1;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x1804
// Size: 0x17
function bb_clearplaysmartobject()
{
    self._blackboard.bplaysmartobject = 0;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x1823
// Size: 0x16, Type: bool
function bb_playsmartobjectrequested()
{
    return istrue( self._blackboard.bplaysmartobject );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x1842
// Size: 0x32
function bb_getrequestedcovermultiswitchnodetype()
{
    assert( isdefined( self._blackboard.docovermultiswitchnodetype ) );
    return self._blackboard.docovermultiswitchnodetype;
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 0
// Checksum 0x0, Offset: 0x187d
// Size: 0x16, Type: bool
function bb_iscovermultiswitchrequested()
{
    return isdefined( self._blackboard.docovermultiswitchnodetype );
}

// Namespace asm_bb / scripts\asm\asm_bb
// Params 4
// Checksum 0x0, Offset: 0x189c
// Size: 0xe9, Type: bool
function bb_canplaygesture( asmname, statename, tostatename, gesture )
{
    if ( !isdefined( self._blackboard.gesturerequest ) )
    {
        return false;
    }
    
    if ( isdefined( gesture ) && self._blackboard.gesturerequest.gesture != gesture )
    {
        return false;
    }
    
    if ( !isdefined( self._blackboard.gesturerequest.latestalias ) )
    {
        return false;
    }
    
    if ( gettime() > self._blackboard.gesturerequest.timeoutms )
    {
        return false;
    }
    
    gesture_alias = self._blackboard.gesturerequest.latestalias;
    
    if ( !scripts\asm\asm::asm_hasalias( tostatename, gesture_alias ) )
    {
        return false;
    }
    
    return true;
}

