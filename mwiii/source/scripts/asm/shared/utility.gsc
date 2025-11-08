#using scripts\anim\battlechatter;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace utility;

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x6d3
// Size: 0x8c
function chooseanimshoot( asmname, statename, params )
{
    var_e592890e140b7faa = params;
    assert( isdefined( var_e592890e140b7faa ) );
    alias = self._blackboard.shootstate + "_" + var_e592890e140b7faa;
    
    if ( isdefined( self._blackboard.shootstate ) && asm_hasalias( statename, alias ) )
    {
        return asm_lookupanimfromalias( statename, alias );
    }
    
    return asm_lookupanimfromalias( statename, params );
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x768
// Size: 0x7f
function choosedemeanoranimwithoverride( asmname, statename, params )
{
    demeanor = asm_getdemeanor();
    
    if ( asm_hasdemeanoranimoverride( demeanor, params ) )
    {
        override = asm_getdemeanoranimoverride( demeanor, params );
        
        if ( isarray( override ) )
        {
            return override[ randomint( override.size ) ];
        }
        
        return override;
    }
    
    if ( !asm_hasalias( statename, demeanor ) )
    {
        return asm_lookupanimfromalias( statename, "default" );
    }
    
    return asm_lookupanimfromalias( statename, demeanor );
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x7f0
// Size: 0xc2
function choosedemeanoranimwithoverridevariants( asmname, statename, params )
{
    demeanor = asm_getdemeanor();
    
    if ( asm_hasdemeanoranimoverride( demeanor, params ) )
    {
        override = asm_getdemeanoranimoverride( demeanor, params );
        
        if ( isarray( override ) )
        {
            return override[ randomint( override.size ) ];
        }
        
        return override;
    }
    
    if ( !asm_hasalias( statename, demeanor ) )
    {
        moveanims = [];
        moveanims[ 0 ] = asm_lookupanimfromalias( statename, "trans_to_one_hand_run" );
        moveanims[ 1 ] = asm_lookupanimfromalias( statename, "one_hand_run" );
        moveanims[ 2 ] = asm_lookupanimfromalias( statename, "trans_to_two_hand_run" );
        moveanims[ 3 ] = asm_lookupanimfromalias( statename, "two_hand_run" );
        return moveanims;
    }
    
    return asm_lookupanimfromalias( statename, demeanor );
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x8bb
// Size: 0x56
function overridecovercrouchnodetype( node )
{
    if ( node.type == "Cover Crouch" && isdefined( self._blackboard.croucharrivaltype ) )
    {
        return self._blackboard.croucharrivaltype;
    }
    
    return node.type;
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x91a
// Size: 0xb6, Type: bool
function allowlmgarrival()
{
    if ( istrue( self.disablelmgmount ) )
    {
        return false;
    }
    
    ismg = weaponclass( self.weapon ) == "mg";
    
    if ( ismg )
    {
        if ( !isdefined( self.node ) || self.node isnodelmgmountable() )
        {
            return true;
        }
        
        return false;
    }
    
    if ( isdefined( self._blackboard.deployedlmgnode ) && isdefined( self.node ) && self.node == self._blackboard.deployedlmgnode && self.node isnodelmgmountable() )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x9d9
// Size: 0x68
function getnodeforwardyaw( node, poseoverride, var_83ca7917ee6a88e8 )
{
    assert( isai( self ) );
    assert( !actor_is3d() );
    
    if ( !isdefined( var_83ca7917ee6a88e8 ) )
    {
        var_83ca7917ee6a88e8 = 1;
    }
    
    offset = self getnodeyawoffset( node, poseoverride, var_83ca7917ee6a88e8 );
    return node.angles[ 1 ] + offset;
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0xa4a
// Size: 0x29, Type: bool
function nodeiscoverstand3dtype( node )
{
    if ( node.type == "Cover Stand 3D" )
    {
        return !nodeiscoverexposed3dtype( node );
    }
    
    return false;
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0xa7c
// Size: 0x47, Type: bool
function nodeiscoverexposed3dtype( node )
{
    if ( node.type == "Cover Stand 3D" )
    {
        if ( isdefined( node.script_parameters ) && node.script_parameters == "exposed" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0xacc
// Size: 0x34
function getnodetypename( node )
{
    if ( isdefined( node ) )
    {
        if ( nodeiscoverexposed3dtype( node ) )
        {
            return "Cover Exposed 3D";
        }
        else
        {
            return node.type;
        }
    }
    
    return "undefined";
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0xb09
// Size: 0xba
function choosestrongdamagedeath( asmname, statename, params )
{
    alias = undefined;
    
    if ( abs( self.damageyaw ) > 150 )
    {
        if ( damagelocationisany( "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot" ) )
        {
            alias = "legs";
        }
        else if ( self.damagelocation == "torso_lower" )
        {
            alias = "torso_lower";
        }
        else
        {
            alias = "default";
        }
    }
    else if ( self.damageyaw < 0 )
    {
        alias = "right";
    }
    else
    {
        alias = "left";
    }
    
    return asm_lookupanimfromalias( statename, alias );
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0xbcc
// Size: 0x9, Type: bool
function isatcovernode()
{
    return isdefined( scripts\asm\asm_bb::bb_getcovernode() );
}

// Namespace utility / scripts\asm\shared\utility
// Params 4
// Checksum 0x0, Offset: 0xbde
// Size: 0xaa, Type: bool
function shouldleaveanimscripted( asmname, statename, tostatename, params )
{
    if ( bb_isanimscripted() )
    {
        return false;
    }
    
    if ( isdefined( params ) )
    {
        assert( !isarray( params ) );
        var_c33b7d825b24a8bb = params;
        
        if ( var_c33b7d825b24a8bb )
        {
            if ( self.a.movement == "stop" )
            {
                return false;
            }
            
            if ( !bb_moverequested() )
            {
                return false;
            }
        }
        else if ( bb_moverequested() && self.a.movement != "stop" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0xc91
// Size: 0x7d
function animscriptedaction( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self.a.movement = "run";
    self.gunposeoverride_internal = "disable";
    animindex = asm_lookupanimfromalias( statename, "blank" );
    self aisetanim( statename, animindex );
    asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
}

// Namespace utility / scripts\asm\shared\utility
// Params 4
// Checksum 0x0, Offset: 0xd16
// Size: 0xe0, Type: bool
function randomizepassthroughchildren( asmname, statename, tostatename, params )
{
    ptostate = anim.asm[ asmname ].states[ tostatename ];
    assert( isdefined( ptostate ) );
    
    if ( isdefined( ptostate.transitions ) )
    {
        if ( ptostate.transitions.size == 2 )
        {
            if ( cointoss() )
            {
                temp = ptostate.transitions[ 0 ];
                ptostate.transitions[ 0 ] = ptostate.transitions[ 1 ];
                ptostate.transitions[ 1 ] = temp;
            }
        }
        else
        {
            ptostate.transitions = scripts\engine\utility::array_randomize( ptostate.transitions );
        }
    }
    
    return true;
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0xdff
// Size: 0x5b, Type: bool
function nodeshouldfaceangles( node )
{
    if ( !isdefined( node ) )
    {
        return false;
    }
    
    if ( isdefined( node.angles ) )
    {
        return true;
    }
    
    if ( isstruct( node ) )
    {
        return false;
    }
    
    return isdefined( node.type ) && node.type != "Path" && !isnodeexposed3d( node );
}

// Namespace utility / scripts\asm\shared\utility
// Params 2
// Checksum 0x0, Offset: 0xe63
// Size: 0x4d
function choosecrouchorstand( guy, node )
{
    return int( node.origin[ 0 ] + node.origin[ 1 ] + node.origin[ 2 ] + guy getentitynumber() ) % 2;
}

// Namespace utility / scripts\asm\shared\utility
// Params 2
// Checksum 0x0, Offset: 0xeb9
// Size: 0x34
function choosecrouchorstandtac( guy, tacorigin )
{
    return int( abs( tacorigin[ 0 ] + tacorigin[ 1 ] + tacorigin[ 2 ] + guy getentitynumber() ) ) % 2;
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0xef6
// Size: 0xd3
function getarrivalnode()
{
    if ( istrue( self.leavecasualkiller ) )
    {
        return undefined;
    }
    
    if ( isdefined( self.scriptedarrivalent ) && !self btgoalvalid() )
    {
        assert( isdefined( self.scriptedarrivalent.type ) );
        return self.scriptedarrivalent;
    }
    
    if ( isdefined( self.node ) )
    {
        return self.node;
    }
    
    if ( isdefined( self.prevnode ) && isdefined( self.pathgoalpos ) && distance2dsquared( self.prevnode.origin, self.pathgoalpos ) < 36 )
    {
        return self.prevnode;
    }
    
    if ( isdefined( self.last_set_goalnode ) )
    {
        return self.last_set_goalnode;
    }
    
    return self.last_set_goalent;
}

// Namespace utility / scripts\asm\shared\utility
// Params 2
// Checksum 0x0, Offset: 0xfd2
// Size: 0x37a
function isarrivaltypecivilian( asmname, arrivaltype )
{
    if ( isdefined( self.customarrivalstate ) )
    {
        return ( arrivaltype == "Custom" );
    }
    
    if ( bb_smartobjectrequested() )
    {
        return ( arrivaltype == "Exposed" );
    }
    
    node = getarrivalnode();
    
    if ( isdefined( node ) && isnode( node ) && node iscovermultinode() )
    {
        target_nodetype = getbestcovermultinodetype( node );
        
        if ( isdefined( target_nodetype ) )
        {
            node setcovermultinodetype( target_nodetype );
        }
    }
    
    if ( !isdefined( node ) || !isdefined( node.type ) || node.type == "struct" || !self canusecover() )
    {
        return ( arrivaltype == "Exposed" );
    }
    
    if ( isdefined( node ) && node.type == "Cover Crouch" )
    {
        covertype = getdvar( @"hash_f72dde9792b94cc9" );
        
        if ( covertype != "" )
        {
            return ( arrivaltype == covertype );
        }
        
        if ( isdefined( self._blackboard.croucharrivaltype ) )
        {
            return ( arrivaltype == self._blackboard.croucharrivaltype );
        }
        else if ( isdefined( node.covercrouchtype ) )
        {
            return ( arrivaltype == node.covercrouchtype );
        }
    }
    
    demeanor = asm_getdemeanor();
    canstand = ( !isnode( node ) || node doesnodeallowstance( "stand" ) ) && self isstanceallowed( "stand" );
    cancrouch = ( !isnode( node ) || node doesnodeallowstance( "crouch" ) ) && self isstanceallowed( "crouch" ) && demeanor != "casual" && demeanor != "casual_gun";
    
    switch ( arrivaltype )
    {
        case #"hash_cf178f370da8b13":
            if ( node.type != "Path" && node.type != "Exposed" )
            {
                return 0;
            }
            
            if ( cancrouch && choosecrouchorstand( self, node ) )
            {
                return 0;
            }
            
            return canstand;
        case #"hash_78bfa3258dd84af":
            if ( node.type != "Path" && node.type != "Exposed" )
            {
                return 0;
            }
            
            if ( canstand && !choosecrouchorstand( self, node ) )
            {
                return 0;
            }
            
            return cancrouch;
        case #"hash_c3b74422dec48736":
            return ( node.type == "Cover Crouch" || node.type == "Conceal Crouch" || node.type == "Cover Crouch Window" || node.type == "Cover Stand" || node.type == "Conceal Stand" || node.type == "Cover Prone" || node.type == "Conceal Prone" );
        case #"hash_e1d8e1adebed5a61":
            return ( node.type == "Cover Left" );
        case #"hash_cd3ffe799551db82":
            return ( node.type == "Cover Right" );
        case #"hash_a85b3cf9ab13da63":
            return ( node.type == "Exposed Moving" );
    }
    
    return arrivaltype == node.type;
}

// Namespace utility / scripts\asm\shared\utility
// Params 4
// Checksum 0x0, Offset: 0x1355
// Size: 0x735
function isarrivaltype( asmname, statename, tostatename, params )
{
    arrivaltype = params;
    
    if ( isdefined( self.customarrivalstate ) )
    {
        return ( arrivaltype == "Custom" );
    }
    
    if ( bb_smartobjectrequested() )
    {
        return ( arrivaltype == "Exposed" );
    }
    
    node = getarrivalnode();
    
    if ( isdefined( node ) && isnode( node ) && node iscovermultinode() )
    {
        target_nodetype = getbestcovermultinodetype( node );
        
        if ( isdefined( target_nodetype ) && node.type != target_nodetype && arrivaltype == target_nodetype )
        {
            node setcovermultinodetype( target_nodetype );
        }
    }
    
    if ( !isdefined( node ) || !isdefined( node.type ) || node.type == "struct" || !self canusecover() )
    {
        if ( actor_is3d() )
        {
            return ( arrivaltype == "Exposed 3D" );
        }
        else
        {
            return ( arrivaltype == "Exposed" );
        }
    }
    
    lmg = scripts\asm\shared\utility::allowlmgarrival();
    
    if ( isdefined( node ) && node.type == "Cover Crouch" && !lmg )
    {
        covertype = getdvar( @"hash_f72dde9792b94cc9" );
        
        if ( covertype != "" )
        {
            return ( arrivaltype == covertype );
        }
        
        if ( isdefined( self._blackboard.croucharrivaltype ) )
        {
            return ( arrivaltype == self._blackboard.croucharrivaltype );
        }
        else if ( isdefined( node.covercrouchtype ) )
        {
            return ( arrivaltype == node.covercrouchtype );
        }
    }
    
    demeanor = asm_getdemeanor();
    canstand = ( !isnode( node ) || node doesnodeallowstance( "stand" ) ) && self isstanceallowed( "stand" );
    cancrouch = ( !isnode( node ) || node doesnodeallowstance( "crouch" ) ) && self isstanceallowed( "crouch" ) && demeanor != "casual" && demeanor != "casual_gun";
    
    if ( asmname == "zero_gravity_space" )
    {
        switch ( arrivaltype )
        {
            case #"hash_4626de3588a73d7e":
                return ( isnodeexposed3d( node ) && canstand );
            case #"hash_b786e406d37a0dd7":
                return ( node.type == "Cover 3D" );
            case #"hash_bdacbb6eaaa538c7":
                return nodeiscoverstand3dtype( node );
            case #"hash_a8e3c2570a26f937":
                return nodeiscoverexposed3dtype( node );
            case #"hash_78bfa3258dd84af":
            case #"hash_cf178f370da8b13":
            case #"hash_55ed607005f12d49":
            case #"hash_667bc7e605903a6c":
            case #"hash_c051a32186a33cae":
            case #"hash_c3b74422dec48736":
            case #"hash_cd3ffe799551db82":
            case #"hash_e1d8e1adebed5a61":
            case #"hash_fd7cd04a31eca976":
                assertmsg( arrivaltype + "<dev string:x1c>" );
                break;
        }
    }
    else if ( asmname == "zero_gravity" )
    {
        switch ( arrivaltype )
        {
            case #"hash_cf178f370da8b13":
                return ( ( node.type == "Path" || node.type == "Exposed" ) && canstand );
            case #"hash_78bfa3258dd84af":
                return ( ( node.type == "Path" || node.type == "Exposed" ) && cancrouch );
            case #"hash_c3b74422dec48736":
                return ( node.type == "Cover Crouch" || node.type == "Conceal Crouch" );
            case #"hash_78b110033ccb68b0":
                return ( node.type == "Cover Stand" || node.type == "Conceal Stand" );
            case #"hash_55ed607005f12d49":
            case #"hash_667bc7e605903a6c":
            case #"hash_c051a32186a33cae":
            case #"hash_cd3ffe799551db82":
            case #"hash_e1d8e1adebed5a61":
                assertmsg( arrivaltype + "<dev string:x1c>" );
                break;
        }
    }
    else
    {
        switch ( arrivaltype )
        {
            case #"hash_cf178f370da8b13":
                if ( node.type != "Path" && node.type != "Exposed" )
                {
                    return 0;
                }
                
                if ( cancrouch && choosecrouchorstand( self, node ) )
                {
                    return 0;
                }
                
                return canstand;
            case #"hash_78bfa3258dd84af":
                if ( node.type != "Path" && node.type != "Exposed" )
                {
                    return 0;
                }
                
                if ( canstand && !choosecrouchorstand( self, node ) )
                {
                    return 0;
                }
                
                return cancrouch;
            case #"hash_c3b74422dec48736":
                return ( node.type == "Cover Crouch" || node.type == "Conceal Crouch" || node.type == "Cover Crouch Window" );
            case #"hash_78b110033ccb68b0":
                return ( node.type == "Cover Stand" || node.type == "Conceal Stand" );
            case #"hash_c051a32186a33cae":
                return ( node.type == "Cover Prone" || node.type == "Conceal Prone" );
            case #"hash_e1d8e1adebed5a61":
                if ( node.type != "Cover Left" )
                {
                    return 0;
                }
                
                if ( cancrouch && choosecrouchorstand( self, node ) )
                {
                    return 0;
                }
                
                return canstand;
            case #"hash_55ed607005f12d49":
                if ( node.type != "Cover Left" )
                {
                    return 0;
                }
                
                if ( canstand && !choosecrouchorstand( self, node ) )
                {
                    return 0;
                }
                
                return cancrouch;
            case #"hash_cd3ffe799551db82":
                if ( node.type != "Cover Right" )
                {
                    return 0;
                }
                
                if ( cancrouch && choosecrouchorstand( self, node ) )
                {
                    return 0;
                }
                
                return canstand;
            case #"hash_667bc7e605903a6c":
                if ( node.type != "Cover Right" )
                {
                    return 0;
                }
                
                if ( canstand && !choosecrouchorstand( self, node ) )
                {
                    return 0;
                }
                
                return cancrouch;
            case #"hash_5478c96ea12827c6":
                return ( ( node.type == "Cover Crouch" || node.type == "Cover Prone" ) && scripts\asm\shared\utility::allowlmgarrival() );
            case #"hash_bfb9a0387a2536f4":
                return ( node.type == "Cover Stand" && scripts\asm\shared\utility::allowlmgarrival() );
            case #"hash_a85b3cf9ab13da63":
                return ( node.type == "Exposed Moving" );
        }
    }
    
    return arrivaltype == node.type;
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x1a93
// Size: 0x61
function playmoveloop( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self.requestarrivalnotify = 1;
    self.var_5185accfc2476d43 = 1;
    self.var_1f91d3da0786a2 = 0;
    rate = 1;
    function_fb56c9527636713f( asmname, statename, rate, 1 );
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x1afc
// Size: 0x25
function playmoveloopcasual( asmname, statename, params )
{
    playmoveloop( asmname, statename, params );
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x1b29
// Size: 0x3b
function playanimwithdooropen( asmname, statename, params )
{
    self.var_5185accfc2476d43 = 1;
    self.var_1f91d3da0786a2 = 1;
    playanim( asmname, statename, params );
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x1b6c
// Size: 0x1b
function playmoveloopcasualcleanup( asmname, statename, params )
{
    
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x1b8f
// Size: 0x66
function calcdooropenspeed()
{
    if ( iscp() )
    {
        return 0.8;
    }
    
    t = 0.75;
    speed = length( self.velocity );
    
    if ( speed > 0 )
    {
        t = 24 / speed;
    }
    
    if ( t < 0.15 )
    {
        t = 0.15;
    }
    else if ( t > 1 )
    {
        t = 1;
    }
    
    return t;
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x1bfe
// Size: 0x156
function opendooratreasonabletime()
{
    door = self._blackboard.doortoopen;
    fndooropen = self.fndooropen;
    
    if ( !isdefined( door ) || !isdefined( fndooropen ) )
    {
        return;
    }
    
    self._blackboard.door_opened = 1;
    self endon( "death" );
    door endon( "death" );
    self endon( "path_has_door" );
    doorcenter = self [[ self.fngetdoorcenter ]]( door );
    var_f195bad2134db294 = distance2dsquared( doorcenter, self.origin );
    opendistsq = 5476;
    
    if ( !issp() )
    {
        opendist = 0.8 * length( self.velocity );
        opendist *= 0.9;
        opendistsq = max( opendist * opendist, opendistsq );
    }
    
    while ( var_f195bad2134db294 > opendistsq )
    {
        if ( isdefined( self._blackboard.doortoopen ) && door != self._blackboard.doortoopen )
        {
            return;
        }
        
        waitframe();
        var_f195bad2134db294 = distance2dsquared( doorcenter, self.origin );
    }
    
    t = calcdooropenspeed();
    self notify( "opening_door" );
    self thread [[ fndooropen ]]( door, t );
    return t;
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x1d5d
// Size: 0x4b
function opendooratreasonabletime_waitforabort( statename )
{
    self endon( "opening_door_done" );
    self waittill( statename + "_finished" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    self._blackboard.doortoopen = undefined;
    self.isopeningdoor = 0;
    self notify( "opening_door_done" );
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x1db0
// Size: 0x3c
function closedoorifnecessary( door )
{
    assert( isdefined( self.fndoorneedstoclose ) );
    
    if ( self [[ self.fndoorneedstoclose ]]( door ) )
    {
        self [[ self.fndoorclose ]]( door );
    }
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x1df4
// Size: 0x9c
function tryopendoor( asmname, statename, var_d6e02014cb6c5b06 )
{
    self endon( statename + "_finished" );
    self endon( "death" );
    
    if ( isdefined( self._blackboard.doortoopen ) )
    {
        var_eb8ea5fef7306d32 = isdoorclear();
        
        if ( var_eb8ea5fef7306d32 )
        {
            self._blackboard.doortoopen = undefined;
            return;
        }
        
        bdooropen = 0;
        
        if ( !self.facemotion )
        {
            bdooropen = function_ff35aef6aed32425( statename );
        }
        
        if ( !bdooropen )
        {
            function_4d06ccc14a583480( asmname, statename, var_d6e02014cb6c5b06 );
        }
    }
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x1e98
// Size: 0x88
function isdoorclear()
{
    var_eb8ea5fef7306d32 = 0;
    
    if ( self [[ self.fndooralreadyopen ]]( self._blackboard.doortoopen ) )
    {
        var_eb8ea5fef7306d32 = 1;
    }
    
    if ( !var_eb8ea5fef7306d32 && !( isent( self._blackboard.doortoopen ) || self._blackboard.doortoopen scriptableisdoor() ) )
    {
        if ( !isdefined( self getmodifierlocationonpath( "door", 200 ) ) )
        {
            var_eb8ea5fef7306d32 = 1;
        }
    }
    
    return var_eb8ea5fef7306d32;
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x1f29
// Size: 0xd1
function function_ff35aef6aed32425( statename )
{
    self endon( statename + "_finished" );
    self endon( "death" );
    bdooropen = 0;
    lookaheaddir = self.lookaheaddir;
    lookaheaddir = vectornormalize( ( lookaheaddir[ 0 ], lookaheaddir[ 1 ], 0 ) );
    facingdir = anglestoforward( self.angles );
    
    if ( vectordot( lookaheaddir, facingdir ) < 0.966 )
    {
        self.isopeningdoor = 1;
        thread function_4dd19bfd2ee610f1( statename );
        t = opendooratreasonabletime();
        
        if ( isdefined( t ) )
        {
            thread opendooratreasonabletime_waitforabort( statename );
            wait t;
        }
        
        self notify( "opening_door_done" );
        self._blackboard.doortoopen = undefined;
        self.isopeningdoor = 0;
        bdooropen = 1;
    }
    
    return bdooropen;
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x2003
// Size: 0x1fa
function function_4d06ccc14a583480( asmname, statename, var_d6e02014cb6c5b06 )
{
    self endon( statename + "_finished" );
    self endon( "death" );
    door = self._blackboard.doortoopen;
    self._blackboard.door_opened = undefined;
    var_36effa6a4b76959f = 1;
    cdooroffset = 160;
    cdoorpadding = 2;
    targetspeed = length2d( self.velocity );
    
    if ( !istrue( var_d6e02014cb6c5b06 ) )
    {
        var_9db8509018bbb8a = function_20962146e1a2e0dd( statename, targetspeed );
        
        if ( isdefined( var_9db8509018bbb8a[ 1 ] ) )
        {
            cdooroffset = function_e183019dcea5b774( var_9db8509018bbb8a[ 0 ], var_9db8509018bbb8a[ 1 ], targetspeed );
        }
        else
        {
            var_d6e02014cb6c5b06 = 1;
        }
    }
    
    var_76c751e661fc569f = var_36effa6a4b76959f + cdooroffset + cdoorpadding;
    doorcenter = self [[ self.fngetdoorcenter ]]( door );
    disttodoor = distance2d( doorcenter, self.origin );
    
    if ( disttodoor < var_76c751e661fc569f )
    {
        self.isopeningdoor = 1;
        thread closedoorifnecessary( door );
        var_382ab682aa991089 = 5;
        
        if ( istrue( var_d6e02014cb6c5b06 ) )
        {
            var_382ab682aa991089 = 2;
        }
        
        if ( istrue( var_d6e02014cb6c5b06 ) || disttodoor < var_76c751e661fc569f - targetspeed * var_382ab682aa991089 * level.framedurationseconds )
        {
            assert( isdefined( self.fndooropen ) );
            thread function_4dd19bfd2ee610f1( statename );
            t = opendooratreasonabletime();
            
            if ( isdefined( t ) )
            {
                thread opendooratreasonabletime_waitforabort( statename );
                wait t;
            }
            
            self notify( "opening_door_done" );
            self._blackboard.doortoopen = undefined;
            self.isopeningdoor = 0;
            return;
        }
        
        self setupdooropen( door, var_76c751e661fc569f, getdooropenspeedlookup() );
        thread handledooropennotetrack( asmname, statename );
        thread handledooropenterminate( asmname, statename );
        self waittill( "opening_door_done" );
    }
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x2205
// Size: 0xba
function function_e183019dcea5b774( doorstate, opendooranim, targetspeed )
{
    doorxanim = asm_getxanim( doorstate, opendooranim );
    assertex( animhasnotetrack( doorxanim, "<dev string:x49>" ), doorxanim + "<dev string:x57>" );
    opentimes = getnotetracktimes( doorxanim, "door_touch" );
    assert( opentimes.size > 0 );
    animdist = ( opentimes[ 0 ] * getanimlength( doorxanim ) + 3 * level.framedurationseconds ) * targetspeed;
    cdooroffset = animdist + 24;
    assertex( animhasnotetrack( doorxanim, "<dev string:x78>" ), doorxanim + "<dev string:x85>" );
    return cdooroffset;
}

// Namespace utility / scripts\asm\shared\utility
// Params 2
// Checksum 0x0, Offset: 0x22c8
// Size: 0xb8
function function_20962146e1a2e0dd( statename, targetspeed )
{
    doorstate = statename;
    dooranim = asm_lookupanimfromaliasifexists( statename, "2" );
    
    if ( !isdefined( dooranim ) )
    {
        targetspeed = self aigettargetspeed();
        speedstate = getnearestspeedthresholdname( self.basearchetype, targetspeed );
        
        if ( isdefined( speedstate ) )
        {
            dooralias = speedstate + "2";
            dooranim = asm_lookupanimfromaliasifexists( statename, dooralias );
            
            if ( !isdefined( dooranim ) )
            {
                doorstate = "door_open";
                dooranim = asm_lookupanimfromaliasifexists( "door_open", dooralias );
            }
        }
    }
    
    if ( !isdefined( dooranim ) )
    {
        dooranim = asm_lookupanimfromaliasifexists( "door_open", "2" );
    }
    
    return [ doorstate, dooranim ];
}

// Namespace utility / scripts\asm\shared\utility
// Params 2
// Checksum 0x0, Offset: 0x2389
// Size: 0x125
function handledooropennotetrack( asmname, statename )
{
    self endon( statename + "_finished" );
    self endon( "opening_door_done" );
    
    while ( true )
    {
        self waittill( "door_open", notes );
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        for ( inote = 0; inote < notes.size ; inote++ )
        {
            if ( notes[ inote ] == "door_open" )
            {
                if ( isdefined( self.fndooropen ) && isdefined( self._blackboard.doortoopen ) )
                {
                    self notify( "opening_door" );
                    t = calcdooropenspeed();
                    self thread [[ self.fndooropen ]]( self._blackboard.doortoopen, t );
                    self._blackboard.door_opened = 1;
                }
                
                continue;
            }
            
            if ( notes[ inote ] == "end" )
            {
                self._blackboard.doortoopen = undefined;
                self.isopeningdoor = 0;
                self cleardooropen();
                self notify( "opening_door_done" );
            }
        }
        
        waitframe();
    }
}

// Namespace utility / scripts\asm\shared\utility
// Params 2
// Checksum 0x0, Offset: 0x24b6
// Size: 0x78
function handledooropenterminate( asmname, statename )
{
    self endon( "opening_door_done" );
    self waittill( statename + "_finished" );
    
    if ( !isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    if ( !istrue( self._blackboard.door_opened ) )
    {
        thread opendooratreasonabletime();
    }
    
    self._blackboard.doortoopen = undefined;
    self.isopeningdoor = 0;
    self cleardooropen();
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x2536
// Size: 0x52
function function_4dd19bfd2ee610f1( statename )
{
    self endon( "opening_door_done" );
    self endon( "death" );
    statefinish = statename + "_finished";
    msg = waittill_any_return_2( statefinish, "opening_door" );
    
    if ( msg == statefinish )
    {
        self.isopeningdoor = 0;
    }
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x2590
// Size: 0x59
function getdooropenspeedlookup()
{
    if ( self.animsetname == "civilian_panic" )
    {
        return "civilian_panic";
    }
    
    if ( self.unittype == "civilian" )
    {
        return "civilian";
    }
    
    if ( self.animsetname == "juggernaut" )
    {
        return "soldier";
    }
    
    return "soldier";
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x25f1
// Size: 0x25
function playanim( asmname, statename, params )
{
    asm_playanimstate( asmname, statename, params );
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x261e
// Size: 0x2d
function playanimwithsound( asmname, statename, params )
{
    self playsound( params );
    asm_playanimstate( asmname, statename, params );
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x2653
// Size: 0x29
function loopanim( asmname, statename, params )
{
    function_fb56c9527636713f( asmname, statename, 1 );
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x2684
// Size: 0xba
function chooseanimidle( asmname, statename, params )
{
    demeanor = asm_getdemeanor();
    
    if ( asm_hasdemeanoranimoverride( demeanor, "idle" ) )
    {
        override = asm_getdemeanoranimoverride( demeanor, "idle" );
        
        if ( isarray( override ) )
        {
            return override[ randomint( override.size ) ];
        }
        
        return override;
    }
    
    if ( isdefined( self.node ) && self.node.type == "Cover Stand" )
    {
        if ( !self.node isvalidpeekoutdir( "over" ) )
        {
            params += "_high";
        }
    }
    
    return chooseanim_weaponclassprepended( asmname, statename, params );
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x2747
// Size: 0xbf
function chooseanim_weaponclassprepended( asmname, statename, params )
{
    assert( isdefined( self.weapon ) );
    weapclass = weaponclass( self.weapon );
    alias = undefined;
    
    if ( !isdefined( params ) )
    {
        return asm_getrandomanim( asmname, statename );
    }
    else
    {
        alias = params;
    }
    
    if ( !asm_hasalias( statename, weapclass + alias ) )
    {
        weapclass = "rifle";
        assertex( asm_hasalias( statename, weapclass + alias ), "<dev string:xa5>" + self.animsetname + "<dev string:xb3>" + statename + "<dev string:xbe>" + weapclass + alias + "<dev string:xd0>" );
    }
    
    return asm_lookupanimfromalias( statename, weapclass + alias );
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x280f
// Size: 0x266
function getarrivaltype()
{
    if ( isdefined( self.customarrivalstate ) )
    {
        return "Custom";
    }
    
    if ( bb_smartobjectrequested() )
    {
        return "Exposed";
    }
    
    node = getarrivalnode();
    
    if ( !isdefined( node ) || !isnode( node ) || !isdefined( node.type ) || node.type == "struct" || !self canusecover() )
    {
        tac_origin = self getcovertacpoint();
        
        if ( isdefined( tac_origin ) )
        {
            demeanor = asm_getdemeanor();
            cancrouch = self isstanceallowed( "crouch" ) && demeanor == "combat";
            
            if ( cancrouch && choosecrouchorstandtac( self, tac_origin ) )
            {
                return "Exposed Crouch";
            }
            
            return "Exposed";
        }
        
        if ( bb_getrequestedstance() == "crouch" || isfixednodeinbadplaceandshouldcrouch() && self isstanceallowed( "crouch" ) )
        {
            return "Exposed Crouch";
        }
        
        return "Exposed";
    }
    
    if ( isdefined( self.enemy ) && self iscoverinvalidagainstenemy( node ) || shouldinitiallyattackfromexposed( node ) )
    {
        if ( node doesnodeallowstance( "stand" ) && self isstanceallowed( "stand" ) )
        {
            return "Exposed";
        }
        else if ( node doesnodeallowstance( "crouch" ) && self isstanceallowed( "crouch" ) )
        {
            return "Exposed Crouch";
        }
        else
        {
            return "Cover Prone";
        }
    }
    
    if ( isnode( node ) && node iscovermultinode() )
    {
        target_nodetype = getbestcovermultinodetype( node );
        
        if ( isdefined( target_nodetype ) && target_nodetype != node.type )
        {
            node setcovermultinodetype( target_nodetype );
        }
    }
    
    nodetype = node.type;
    lmg = scripts\asm\shared\utility::allowlmgarrival();
    
    if ( lmg )
    {
        switch ( nodetype )
        {
            case #"hash_c051a32186a33cae":
            case #"hash_c3b74422dec48736":
                return "Cover Crouch LMG";
            case #"hash_78b110033ccb68b0":
                return "Cover Stand LMG";
        }
    }
    
    if ( isdefined( self._blackboard.croucharrivaltype ) && !lmg )
    {
        return self._blackboard.croucharrivaltype;
    }
    
    return self choosearrivaltype( node, nodetype );
}

// Namespace utility / scripts\asm\shared\utility
// Params 4
// Checksum 0x0, Offset: 0x2a7e
// Size: 0x43, Type: bool
function shouldstrafe( asmname, statename, tostatename, params )
{
    return bb_moverequested() && !self.facemotion && self.allowstrafe;
}

// Namespace utility / scripts\asm\shared\utility
// Params 4
// Checksum 0x0, Offset: 0x2aca
// Size: 0x51, Type: bool
function shouldabortstrafe( asmname, statename, tostatename, params )
{
    if ( !shouldstrafe( asmname, statename, tostatename, params ) )
    {
        return true;
    }
    
    if ( !bb_movetyperequested( "combat" ) )
    {
        return true;
    }
    
    if ( bb_meleechargerequested() )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x2b24
// Size: 0x4a
function chooseanimmovetype( asmname, statename, params )
{
    demeanor = asm_getdemeanor();
    
    if ( !asm_hasalias( statename, demeanor ) )
    {
        return asm_chooseanim( asmname, statename, params );
    }
    
    return asm_lookupanimfromalias( statename, demeanor );
}

// Namespace utility / scripts\asm\shared\utility
// Params 4
// Checksum 0x0, Offset: 0x2b77
// Size: 0x29
function transition_isflashed( asmname, statename, tostatename, params )
{
    return isflashed();
}

// Namespace utility / scripts\asm\shared\utility
// Params 4
// Checksum 0x0, Offset: 0x2ba9
// Size: 0x29
function transition_isstunned( asmname, statename, tostatename, params )
{
    return isstunned();
}

// Namespace utility / scripts\asm\shared\utility
// Params 4
// Checksum 0x0, Offset: 0x2bdb
// Size: 0x45, Type: bool
function transition_isburning( asmname, statename, tostatename, params )
{
    return isdefined( self._blackboard.isburning ) && !istrue( self.damageshield );
}

// Namespace utility / scripts\asm\shared\utility
// Params 4
// Checksum 0x0, Offset: 0x2c29
// Size: 0x57, Type: bool
function function_5129b58498c1a96f( asmname, statename, tostatename, params )
{
    return isdefined( self._blackboard.lastpopuptime ) && gettime() - self._blackboard.lastpopuptime < 100;
}

// Namespace utility / scripts\asm\shared\utility
// Params 4
// Checksum 0x0, Offset: 0x2c89
// Size: 0x6c, Type: bool
function shouldreacttolight( asmname, statename, tostatename, params )
{
    if ( isdefined( self.lightreaction_requesttime ) && self.lightreaction_requesttime >= gettime() - 1000 )
    {
        archetype = self getbasearchetype();
        
        if ( isspeedwithincqbrange( archetype, self aigetdesiredspeed() ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x2cfe
// Size: 0x149
function chooselightreactionanim( asmname, statename, params )
{
    direction = "center";
    
    if ( !isdefined( self.lightreaction_lightorigin ) )
    {
        return asm_lookupanimfromalias( statename, direction );
    }
    
    if ( isdefined( self.covernode ) )
    {
        myright = anglestoright( self.covernode.angles );
        myforward = anglestoforward( self.covernode.angles );
        var_4a01d3a5d7389412 = vectornormalize( self.lightreaction_lightorigin - self.origin );
    }
    else
    {
        myright = anglestoright( self.angles );
        myforward = anglestoforward( self.angles );
        var_4a01d3a5d7389412 = vectornormalize( self.lightreaction_lightorigin - self.origin );
    }
    
    var_52809b82c18e7907 = vectordot( myright, var_4a01d3a5d7389412 ) >= 0;
    var_1e3ac8ad87f9f410 = vectordot( myforward, var_4a01d3a5d7389412 );
    
    if ( var_1e3ac8ad87f9f410 >= 0.866 )
    {
        direction = "center";
    }
    else if ( var_52809b82c18e7907 )
    {
        direction = "right";
    }
    else
    {
        direction = "left";
    }
    
    return asm_lookupanimfromalias( statename, direction );
}

// Namespace utility / scripts\asm\shared\utility
// Params 4
// Checksum 0x0, Offset: 0x2e50
// Size: 0xe2, Type: bool
function isshocked( asmname, currentstate, transitiontostate, params )
{
    if ( isdefined( self.damagemod ) && self.damagemod == "MOD_IMPACT" )
    {
        return false;
    }
    
    if ( isdamageweapon( makeweapon( "emp" ) ) )
    {
        return true;
    }
    
    if ( self.unittype == "c6" || self.unittype == "c8" )
    {
        if ( isdamageweapon( makeweapon( "iw7_sonic" ) ) && isweaponepic( self.damageweapon ) )
        {
            return true;
        }
    }
    
    if ( isdamageweapon( makeweapon( "iw7_atomizer" ) ) && self.damagemod != "MOD_MELEE" && self.health <= 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x2f3b
// Size: 0x92
function getdamagedirstring()
{
    damagedir = -1 * self.damagedir;
    facingdir = anglestoforward( self.angles );
    dot = vectordot( facingdir, damagedir );
    
    if ( dot > 0.707 )
    {
        return "front";
    }
    
    if ( dot < -0.707 )
    {
        return "back";
    }
    
    cross = vectorcross( facingdir, damagedir );
    
    if ( cross[ 2 ] > 0 )
    {
        return "left";
    }
    
    return "right";
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x2fd5
// Size: 0x51, Type: bool
function gethumandamagedirstring()
{
    damagedir = -1 * self.damagedir;
    facingdir = anglestoforward( self.angles );
    dot = vectordot( facingdir, damagedir );
    
    if ( dot < -0.5 )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x302f
// Size: 0x30
function playanimandusegoalweight( asmname, statename, params )
{
    self setuseanimgoalweight( 0.2 );
    asm_playanimstate( asmname, statename );
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x3067
// Size: 0x75
function animscriptedaction_terminate( asmname, statename, params )
{
    self orientmode( "face angle 3d", self.angles );
    self.gunposeoverride_internal = undefined;
    
    if ( isdefined( self.lookatatrnode ) )
    {
        var_ae4bd9db62367d96 = asm_getheadlookknobifexists();
        
        if ( isdefined( var_ae4bd9db62367d96 ) )
        {
            self clearanim( var_ae4bd9db62367d96, 0.2 );
            self.lookatatrnode = undefined;
        }
    }
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x30e4
// Size: 0x5f
function animsriptedactioncivilian_terminate( asmname, statename, params )
{
    if ( isdefined( self.lookatatrnode ) )
    {
        var_ae4bd9db62367d96 = asm_getheadlookknobifexists();
        
        if ( isdefined( var_ae4bd9db62367d96 ) )
        {
            self clearanim( var_ae4bd9db62367d96, 0.2, self.lookatatrnode );
            self.lookatatrnode = undefined;
        }
    }
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x314b
// Size: 0x13
function cleanupanimscriptedheadlook()
{
    self.ht_on = undefined;
    lookatentity();
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x3166
// Size: 0x2c
function animscriptedstartup( asmname, statename, params )
{
    self.ht_on = undefined;
    self stoplookat();
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x319a
// Size: 0x2f
function animscriptedcleanup( asmname, statename, params )
{
    cleanupanimscriptedheadlook();
    self aisettargetspeed( self aigetdesiredspeed() );
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x31d1
// Size: 0x22
function animscriptedaction_cleanup( asmname, statename, params )
{
    cleanupanimscriptedheadlook();
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x31fb
// Size: 0x86
function disabledefaultfacialanims( bdisable )
{
    if ( !isdefined( self.headknob ) )
    {
        self.headknob = asm_getxanim( "knobs", asm_lookupanimfromalias( "knobs", "head" ) );
    }
    
    if ( !isdefined( bdisable ) || bdisable )
    {
        setfacialstate( "animscripted" );
        
        if ( isai( self ) )
        {
            self setfacialindex( "none" );
        }
        else
        {
            setfacialindexfornonai( "none" );
        }
        
        return;
    }
    
    clearfacialstate( "animscripted" );
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x3289
// Size: 0x152
function setfacialindexfornonai( state )
{
    states = [];
    states[ "none" ] = 0;
    states[ "idle" ] = 1;
    states[ "aim" ] = 2;
    states[ "run" ] = 3;
    states[ "pain" ] = 4;
    states[ "death" ] = 5;
    states[ "talk_lg" ] = 6;
    states[ "talk_md" ] = 7;
    states[ "talk_sm" ] = 8;
    states[ "happy" ] = 9;
    states[ "cheer" ] = 10;
    states[ "scared" ] = 11;
    states[ "angry" ] = 12;
    states[ "gas_death" ] = 13;
    assertex( isdefined( states[ state ] ), "<dev string:xda>" + state );
    assert( !isai( self ) );
    assert( issp() );
    self setcustomnodegameparameter( "animtime", self getentitynumber() );
    self setcustomnodegameparameterbyte( "facialindex", states[ state ] );
    facialknob = asm_lookupanimfromalias( "knobs", "head" );
    
    if ( state == "none" )
    {
        self clearanim( asm_getxanim( "knobs", facialknob ), 0.2 );
        return;
    }
    
    self setanim( asm_getxanim( "knobs", facialknob ), 1, 0.2, 1 );
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x33e3
// Size: 0xaa
function function_ee3e5d584e317d35( state )
{
    if ( state == "none" )
    {
        facialknob = asm_lookupanimfromalias( "knobs", "head_fakeactor" );
        self clearanim( asm_getxanim( "knobs", facialknob ), 0.2 );
        return;
    }
    
    facialanimid = asm_lookupanimfromalias( "facial_animation_fakeactor", state );
    
    if ( !isdefined( facialanimid ) )
    {
        iprintln( "Missing facial: " + self.animsetname + " " + state );
    }
    
    facialxanim = asm_getxanim( "facial_animation_fakeactor", facialanimid );
    self setanimknob( facialxanim, 1, 0.2 );
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x3495
// Size: 0x15
function setfacialstate( state )
{
    self.facialstate = state;
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x34b2
// Size: 0x3b
function clearfacialstate( state )
{
    self.facialstate = "asm";
    
    if ( !isdefined( self.fakeactor_face_anim ) || !self.fakeactor_face_anim )
    {
        asm_restorefacialanim();
    }
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x34f5
// Size: 0xa8, Type: bool
function isfacialstateallowed( state )
{
    if ( !isai( self ) && ( !isdefined( self.fakeactor_face_anim ) || !self.fakeactor_face_anim ) )
    {
        return false;
    }
    
    if ( !isdefined( self.facialstate ) )
    {
        self.facialstate = "asm";
    }
    
    priorities = [];
    priorities[ "asm" ] = 0;
    priorities[ "filler" ] = 1;
    priorities[ "animscripted" ] = 2;
    assertex( isdefined( priorities[ state ] ), "<dev string:xf7>" + state + "<dev string:x10d>" );
    
    if ( priorities[ state ] >= priorities[ self.facialstate ] )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x35a6
// Size: 0x18
function decrementbulletsinclip()
{
    if ( self.bulletsinclip )
    {
        self.bulletsinclip--;
    }
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x35c6
// Size: 0xb
function grenadelauncherfirerate()
{
    return randomfloatrange( 5, 8 );
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x35da
// Size: 0x2c
function shotgunfirerate()
{
    if ( weapon_pump_action_shotgun() )
    {
        return 1;
    }
    
    if ( scripts\anim\weaponlist::usingautomaticweapon() )
    {
        return ( scripts\anim\weaponlist::autoshootanimrate() * 0.7 );
    }
    
    return 0.4;
}

// Namespace utility / scripts\asm\shared\utility
// Params 2
// Checksum 0x0, Offset: 0x360f
// Size: 0xc2
function melee_checktimer( unittype, checkplayer )
{
    /#
        if ( getdvarint( @"hash_a36b45ede9e79a0a", 0 ) == 1 )
        {
            return 1;
        }
    #/
    
    if ( isdefined( self.meleeignoretimer ) && self.meleeignoretimer )
    {
        return 1;
    }
    
    if ( !isdefined( checkplayer ) )
    {
        checkplayer = 0;
    }
    
    if ( checkplayer )
    {
        if ( !isdefined( anim.meleechargeplayertimers ) )
        {
            return 1;
        }
        
        if ( !isdefined( anim.meleechargeplayertimers[ unittype ] ) )
        {
            return 1;
        }
        
        return ( gettime() > anim.meleechargeplayertimers[ unittype ] );
    }
    
    if ( !isdefined( anim.meleechargetimers ) )
    {
        return 1;
    }
    
    if ( !isdefined( anim.meleechargetimers[ unittype ] ) )
    {
        return 1;
    }
    
    return gettime() > anim.meleechargetimers[ unittype ];
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x36d9
// Size: 0x231
function setupsoldierdefaults()
{
    curtime = gettime();
    self.laserenabled = 0;
    self.primaryweapon = self.weapon;
    self.agentname = &"MP/HOSTILE_SOLDIER";
    
    if ( isdefined( level.gametype ) && level.gametype == "gwtdm" )
    {
        self.agentname = &"MP/GWTDM_SOLDIER";
    }
    
    self.currentpose = "stand";
    self.a.movement = "stop";
    self.dropweapon = 1;
    self.minexposedgrenadedist = 750;
    isally = !self isbadguy();
    self.a.lastenemytime = curtime;
    self.allowlongdeath = !isally;
    self.a.paintime = 0;
    self.reacttobulletchance = 0.8;
    self._animactive = 0;
    self._lastanimtime = 0;
    self.misstime = 0;
    self.a.nodeath = 0;
    self.misstime = 0;
    self.misstimedebounce = 0;
    self.a.disablepain = 0;
    self.battlechatter = spawnstruct();
    
    if ( !issp() )
    {
        callback::add( "on_ai_killed", &scripts\anim\battlechatter::function_d6731c6d074dc7d0 );
    }
    
    self.chatinitialized = 0;
    self.defaultturnthreshold = 55;
    scripts\asm\shared\utility::setfacialstate( "asm" );
    self.speedscalemult = 0.95 + randomfloat( 0.15 );
    self.script_forcegrenade = 0;
    self.lastenemysighttime = 0;
    self.combattime = 0;
    self.suppressed = 0;
    self.suppressedtime = 0;
    
    if ( isally )
    {
        self.suppressionthreshold = 0.5;
    }
    else
    {
        self.suppressionthreshold = 0;
    }
    
    self.ammocheatinterval = 8000;
    self.ammocheattime = 0;
    self.var_20d73f2e5569b90f = 75;
}

// Namespace utility / scripts\asm\shared\utility
// Params 3
// Checksum 0x0, Offset: 0x3912
// Size: 0x92
function getspeedmatchanimrate( xanim, samplestart, sampleend )
{
    assert( samplestart < sampleend );
    currentspeed = length( self.velocity );
    
    if ( currentspeed < 1 )
    {
        return 1;
    }
    
    animdist = length( getmovedelta( xanim, samplestart, sampleend ) );
    
    if ( animdist < 1 )
    {
        return 1;
    }
    
    animtime = getanimlength( xanim ) * ( sampleend - samplestart );
    animspeed = animdist / animtime;
    return currentspeed / animspeed;
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x39ad
// Size: 0x24, Type: bool
function isentasoldier()
{
    return self.unittype == "soldier" || self.unittype == "juggernaut";
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x39da
// Size: 0x24, Type: bool
function isentnotabomber()
{
    return self.asmname != "suicidebomber" && self.asmname != "suicidebomber_cp";
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x3a07
// Size: 0x1b, Type: bool
function demeanorhasblendspace()
{
    demeanor = asm_getdemeanor();
    return demeanor == "combat";
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x3a2b
// Size: 0x58, Type: bool
function isfixednodeinbadplaceandshouldcrouch()
{
    if ( self.fixednode && !isdefined( self.node ) && isdefined( self.color_node ) && self isnodeinbadplace( self.color_node ) && self.color_node doesnodeallowstance( "crouch" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x3a8c
// Size: 0x284
function gethighestallowedstance()
{
    nodeshighestallowedstance = undefined;
    var_58b5e042653e4c9 = 1;
    var_1462639ed10c0aa5 = 1;
    var_fbc7d1fe7086d737 = 1;
    
    if ( isdefined( self.node ) && isatcovernode() )
    {
        var_58b5e042653e4c9 = self.node doesnodeallowstance( "stand" );
        var_1462639ed10c0aa5 = self.node doesnodeallowstance( "crouch" );
        var_fbc7d1fe7086d737 = self.node doesnodeallowstance( "prone" );
    }
    else if ( !scripts\asm\asm_bb::bb_moverequested() && istrue( self._blackboard.shootparams_valid ) && isdefined( self._blackboard.shootparams_pos ) )
    {
        bcancrouch = self isstanceallowed( "crouch" );
        
        if ( bcancrouch && isfixednodeinbadplaceandshouldcrouch() )
        {
            return "crouch";
        }
        
        var_1ffc686a2062eba7 = distancesquared( self.origin, self._blackboard.shootparams_pos );
        
        if ( var_1ffc686a2062eba7 > 262144 && bcancrouch && !actor_is3d() && !isusingsidearm() )
        {
            bcancrouch = 1;
            
            if ( isdefined( self.node ) && distancesquared( self.origin, self.node.origin ) < 16 && !self.node doesnodeallowstance( "crouch" ) )
            {
                bcancrouch = abs( angleclamp180( self.node.angles[ 1 ] - self.angles[ 1 ] ) ) > 90;
            }
            
            if ( bcancrouch )
            {
                if ( sighttracepassed( self.origin + ( 0, 0, 32 ), self._blackboard.shootparams_pos, 0, undefined ) )
                {
                    return "crouch";
                }
            }
        }
    }
    
    while ( true )
    {
        if ( self isstanceallowed( "stand" ) && var_58b5e042653e4c9 )
        {
            return "stand";
        }
        
        if ( self isstanceallowed( "crouch" ) && var_1462639ed10c0aa5 )
        {
            return "crouch";
        }
        
        if ( self isstanceallowed( "prone" ) && var_fbc7d1fe7086d737 )
        {
            return "prone";
        }
        
        if ( !var_58b5e042653e4c9 || !var_1462639ed10c0aa5 || !var_fbc7d1fe7086d737 )
        {
            var_58b5e042653e4c9 = 1;
            var_1462639ed10c0aa5 = 1;
            var_fbc7d1fe7086d737 = 1;
            continue;
        }
        
        break;
    }
    
    assertmsg( "<dev string:x11c>" );
    return "crouch";
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x3d19
// Size: 0x14a
function determinerequestedstance()
{
    higheststance = gethighestallowedstance();
    requestedstance = bb_getrequestedstance();
    stances = [];
    stances[ "prone" ] = 0;
    stances[ "crouch" ] = 1;
    stances[ "stand" ] = 2;
    demeanor = self getdemeanor();
    
    if ( isdefined( self.pathgoalpos ) && distance2dsquared( self.pathgoalpos, self.origin ) > 1 )
    {
        requestedstance = "stand";
    }
    
    if ( self._blackboard.bgrenadereturnthrow )
    {
        requestedstance = "stand";
    }
    
    if ( !isdefined( higheststance ) )
    {
        higheststance = requestedstance;
    }
    
    if ( demeanor == "casual" || demeanor == "casual_gun" )
    {
        requestedstance = "stand";
    }
    else if ( higheststance == "prone" && self.unittype == "c6" )
    {
        requestedstance = "crouch";
    }
    else if ( stances[ higheststance ] < stances[ requestedstance ] )
    {
        requestedstance = higheststance;
    }
    else if ( requestedstance == "prone" && higheststance != requestedstance )
    {
        requestedstance = higheststance;
    }
    else if ( requestedstance == "crouch" && stances[ higheststance ] > stances[ "crouch" ] )
    {
        if ( bb_isinbadcrouchspot() )
        {
            requestedstance = "stand";
        }
    }
    
    return requestedstance;
}

/#

    // Namespace utility / scripts\asm\shared\utility
    // Params 1
    // Checksum 0x0, Offset: 0x3e6c
    // Size: 0x53, Type: dev
    function function_87d74491d0318ba3( archetype )
    {
        if ( isagent( self ) )
        {
            return 1;
        }
        
        if ( !isdefined( level.var_a34e5c8668851782 ) )
        {
            level.var_a34e5c8668851782 = [];
        }
        
        if ( !isdefined( level.var_a34e5c8668851782[ archetype ] ) )
        {
            level.var_a34e5c8668851782[ archetype ] = 1;
            return 0;
        }
        
        return 1;
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 4
    // Checksum 0x0, Offset: 0x3ec7
    // Size: 0x6f, Type: dev
    function function_d6919795e4b24d3a( asmname, statename, xanim, note )
    {
        if ( !animhasnotetrack( xanim, note ) )
        {
            print( "<dev string:x168>" + note + "<dev string:x1b3>" + asmname + "<dev string:x1bf>" + statename + "<dev string:x1cb>" + getxhashsourcename( getanimname( xanim ) ) + "<dev string:x1d6>" );
            level.var_e941151b3a81c996 = 0;
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 4
    // Checksum 0x0, Offset: 0x3f3e
    // Size: 0x6f, Type: dev
    function function_37064c5f2a8f68ef( asmname, statename, xanim, note )
    {
        if ( animhasnotetrack( xanim, note ) )
        {
            print( "<dev string:x1dc>" + note + "<dev string:x1b3>" + asmname + "<dev string:x1bf>" + statename + "<dev string:x1cb>" + getxhashsourcename( getanimname( xanim ) ) + "<dev string:x1d6>" );
            level.var_e941151b3a81c996 = 0;
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 5
    // Checksum 0x0, Offset: 0x3fb5
    // Size: 0xa2, Type: dev
    function function_6893c43c1838f552( asmname, statename, xanim, note1, note2 )
    {
        if ( !animhasnotetrack( xanim, note1 ) || !animhasnotetrack( xanim, note2 ) )
        {
            return;
        }
        
        if ( getnotetracktimes( xanim, note1 )[ 0 ] >= getnotetracktimes( xanim, note2 )[ 0 ] )
        {
            print( "<dev string:x227>" + note1 + "<dev string:x26a>" + note2 + "<dev string:x1b3>" + asmname + "<dev string:x1bf>" + statename + "<dev string:x1cb>" + getxhashsourcename( getanimname( xanim ) ) + "<dev string:x1d6>" );
            level.var_e941151b3a81c996 = 0;
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 4
    // Checksum 0x0, Offset: 0x405f
    // Size: 0x9a, Type: dev
    function function_3474c2003e05a5e0( asmname, statename, xanim, min_translation )
    {
        movedelta = getmovedelta( xanim );
        d = length( movedelta );
        
        if ( d < min_translation )
        {
            println( "<dev string:x285>" + min_translation + "<dev string:x2d9>" + asmname + "<dev string:x2f0>" + statename + "<dev string:x2fb>" );
            level.var_e941151b3a81c996 = 0;
            println( "<dev string:x300>" + getxhashsourcename( getanimname( xanim ) ) + "<dev string:x305>" + d );
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 4
    // Checksum 0x0, Offset: 0x4101
    // Size: 0x194, Type: dev
    function function_481385c3b908b994( asmname, statename, xanim, max_translation )
    {
        stop_time = 1;
        
        if ( animhasnotetrack( xanim, "<dev string:x314>" ) || animhasnotetrack( xanim, "<dev string:x321>" ) )
        {
            var_ad9ba4beee7c6c8e = getnotetracktimes( xanim, "<dev string:x314>" );
            
            foreach ( note in var_ad9ba4beee7c6c8e )
            {
                stop_time = min( stop_time, note );
            }
            
            finish_notes = getnotetracktimes( xanim, "<dev string:x321>" );
            
            foreach ( note in finish_notes )
            {
                stop_time = min( stop_time, note );
            }
        }
        
        movedelta = getmovedelta( xanim, 0, stop_time );
        d = length( movedelta );
        
        if ( d > max_translation )
        {
            println( "<dev string:x32b>" + max_translation + "<dev string:x2d9>" + asmname + "<dev string:x2f0>" + statename + "<dev string:x2fb>" );
            level.var_e941151b3a81c996 = 0;
            println( "<dev string:x300>" + getxhashsourcename( getanimname( xanim ) ) + "<dev string:x305>" + d );
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 5
    // Checksum 0x0, Offset: 0x429d
    // Size: 0x1f4, Type: dev
    function function_7329f095ddbdb229( asmname, statename, xanim, notetrack, max_translation )
    {
        stop_time = 1;
        
        if ( animhasnotetrack( xanim, "<dev string:x314>" ) )
        {
            var_ad9ba4beee7c6c8e = getnotetracktimes( xanim, "<dev string:x314>" );
            
            if ( var_ad9ba4beee7c6c8e.size != 1 )
            {
                println( "<dev string:x37e>" + asmname + "<dev string:x2f0>" + statename + "<dev string:x3ca>" + getxhashsourcename( getanimname( xanim ) ) );
            }
            
            stop_time = var_ad9ba4beee7c6c8e[ 0 ];
        }
        
        if ( animhasnotetrack( xanim, "<dev string:x321>" ) )
        {
            finish_notes = getnotetracktimes( xanim, "<dev string:x321>" );
            
            if ( finish_notes.size != 1 )
            {
                println( "<dev string:x3d0>" + asmname + "<dev string:x2f0>" + statename + "<dev string:x3ca>" + getxhashsourcename( getanimname( xanim ) ) );
            }
            
            stop_time = min( stop_time, finish_notes[ 0 ] );
        }
        
        start_time = 0;
        
        if ( animhasnotetrack( xanim, notetrack ) )
        {
            notes = getnotetracktimes( xanim, notetrack );
            
            if ( notes.size != 1 )
            {
                println( "<dev string:x419>" + notetrack + "<dev string:x44c>" + asmname + "<dev string:x2f0>" + statename + "<dev string:x3ca>" + getxhashsourcename( getanimname( xanim ) ) );
            }
            
            start_time = notes[ 0 ];
        }
        else
        {
            return;
        }
        
        movedelta = getmovedelta( xanim, start_time, stop_time );
        d = length( movedelta );
        
        if ( d > max_translation )
        {
            println( "<dev string:x460>" + max_translation + "<dev string:x4c3>" + notetrack + "<dev string:x4da>" + asmname + "<dev string:x2f0>" + statename + "<dev string:x2fb>" );
            level.var_e941151b3a81c996 = 0;
            println( "<dev string:x300>" + getxhashsourcename( getanimname( xanim ) ) + "<dev string:x305>" + d );
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x4499
    // Size: 0x89, Type: dev
    function validator_notetrack( asmname, statename, note )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        xanims = asm_getallanimsforstate( statename );
        
        foreach ( xanim in xanims )
        {
            function_d6919795e4b24d3a( asmname, statename, xanim, note );
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x452a
    // Size: 0x8d, Type: dev
    function function_2376c1e1ca3ac68e( asmname, statename, params )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        xanims = asm_getallanimsforstate( statename );
        
        foreach ( xanim in xanims )
        {
            function_481385c3b908b994( asmname, statename, xanim, 0.1 );
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x45bf
    // Size: 0x95, Type: dev
    function function_6421e5a82688da9d( asmname, statename, tolerance )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        if ( !isdefined( tolerance ) )
        {
            tolerance = 8;
        }
        
        xanims = asm_getallanimsforstate( statename );
        
        foreach ( xanim in xanims )
        {
            function_3474c2003e05a5e0( asmname, statename, xanim, tolerance );
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x465c
    // Size: 0x142, Type: dev
    function function_fb8af5455aa10890( asmname, statename, params )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        tolerance = 0.1;
        samplefrac = 0.1;
        xanims = asm_getallanimsforstate( statename );
        
        foreach ( xanim in xanims )
        {
            t = 0;
            
            while ( t < 1 )
            {
                t = min( t + samplefrac, 1 );
                movedelta = getmovedelta( xanim, 0, t );
                d = length( movedelta );
                
                if ( d > tolerance )
                {
                    println( "<dev string:x4ef>" + asmname + "<dev string:x2f0>" + statename + "<dev string:x536>" + tolerance + "<dev string:x2fb>" );
                    level.var_e941151b3a81c996 = 0;
                    println( "<dev string:x300>" + getxhashsourcename( getanimname( xanim ) ) + "<dev string:x305>" + d + "<dev string:x545>" + t );
                    break;
                }
            }
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x47a6
    // Size: 0x2cd, Type: dev
    function function_e291a61d131cb535( asmname, statename, params )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        assert( isdefined( self.animsetname ) );
        arc = self.animsetname;
        aliases = archetypegetaliases( arc, statename );
        
        if ( !isdefined( aliases ) )
        {
            println( "<dev string:x552>" + self.animsetname + "<dev string:x2f0>" + statename + "<dev string:x2fb>" );
            return;
        }
        
        foreach ( alias in aliases )
        {
            var_a401bfc2f3617031 = undefined;
            
            if ( issubstr( alias, "<dev string:x58d>" ) )
            {
                var_a401bfc2f3617031 = 1;
            }
            else if ( issubstr( alias, "<dev string:x592>" ) )
            {
                var_a401bfc2f3617031 = 2;
            }
            else if ( issubstr( alias, "<dev string:x597>" ) )
            {
                var_a401bfc2f3617031 = 3;
            }
            else if ( issubstr( alias, "<dev string:x59c>" ) )
            {
                var_a401bfc2f3617031 = 4;
            }
            else if ( issubstr( alias, "<dev string:x5a1>" ) )
            {
                var_a401bfc2f3617031 = 5;
            }
            else if ( issubstr( alias, "<dev string:x5a6>" ) )
            {
                var_a401bfc2f3617031 = 6;
            }
            
            if ( isdefined( var_a401bfc2f3617031 ) )
            {
                organims = archetypegetalias( arc, statename, alias, 0 );
                redanims = archetypegetalias( arc, statename, alias, 1 );
                
                if ( isarray( organims.anims ) )
                {
                    anims = organims.anims;
                }
                else
                {
                    anims = [ organims.anims ];
                }
                
                if ( isarray( redanims.anims ) )
                {
                    redanims = redanims.anims;
                }
                else
                {
                    redanims = [ redanims.anims ];
                }
                
                xanims = scripts\engine\utility::array_combine_unique( anims, redanims );
                
                foreach ( xanim in xanims )
                {
                    shoottimes = getnotetracktimes( xanim, "<dev string:x5ab>" );
                    
                    if ( shoottimes.size < var_a401bfc2f3617031 )
                    {
                        println( "<dev string:x5b3>" + asmname + "<dev string:x2f0>" + statename + "<dev string:x2fb>" );
                        level.var_e941151b3a81c996 = 0;
                        println( "<dev string:x5f9>" + alias + "<dev string:x603>" + getxhashsourcename( getanimname( xanim ) ) + "<dev string:x608>" + shoottimes.size + "<dev string:x616>" + var_a401bfc2f3617031 );
                    }
                }
            }
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x4a7b
    // Size: 0x1e, Type: dev
    function function_3668c851be298257( asmname, statename, params )
    {
        
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x4aa1
    // Size: 0x1e, Type: dev
    function function_e7680ae9c1ad905c( asmname, statename, params )
    {
        
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 4
    // Checksum 0x0, Offset: 0x4ac7
    // Size: 0xac, Type: dev
    function function_291d962b22a07e21( asmname, statename, alias, xanim )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        if ( issubstr( statename, "<dev string:x63a>" ) && ( issubstr( alias, "<dev string:x642>" ) || issubstr( alias, "<dev string:x647>" ) ) || issubstr( statename, "<dev string:x64c>" ) && ( issubstr( alias, "<dev string:x655>" ) || issubstr( alias, "<dev string:x647>" ) ) )
        {
            function_d6919795e4b24d3a( asmname, statename, xanim, "<dev string:x65a>" );
            function_6893c43c1838f552( asmname, statename, xanim, "<dev string:x65a>", "<dev string:x314>" );
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x4b7b
    // Size: 0x17d, Type: dev
    function validator_arrival( asmname, statename, params )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        assert( isdefined( self.animsetname ) );
        arc = self.animsetname;
        aliases = archetypegetaliases( arc, statename );
        
        foreach ( alias in aliases )
        {
            if ( issubstr( alias, "<dev string:x664>" ) )
            {
                continue;
            }
            
            anims = asm_getallanimsforalias( arc, statename, alias );
            
            if ( isdefined( anims ) )
            {
                foreach ( xanim in anims )
                {
                    function_291d962b22a07e21( asmname, statename, alias, xanim );
                    function_481385c3b908b994( asmname, statename, xanim, 85 );
                    function_3474c2003e05a5e0( asmname, statename, xanim, 16 );
                    function_37064c5f2a8f68ef( asmname, statename, xanim, "<dev string:x66f>" );
                    function_37064c5f2a8f68ef( asmname, statename, xanim, "<dev string:x682>" );
                    function_7329f095ddbdb229( asmname, statename, xanim, "<dev string:x693>", 1 );
                }
            }
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x4d00
    // Size: 0x19a, Type: dev
    function function_498119c92072487f( asmname, statename, params )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        assert( isdefined( self.animsetname ) );
        arc = self.animsetname;
        aliases = archetypegetaliases( arc, statename );
        
        foreach ( alias in aliases )
        {
            if ( issubstr( alias, "<dev string:x664>" ) )
            {
                continue;
            }
            
            anims = asm_getallanimsforalias( arc, statename, alias );
            
            if ( isdefined( anims ) )
            {
                foreach ( xanim in anims )
                {
                    function_291d962b22a07e21( asmname, statename, alias, xanim );
                    function_481385c3b908b994( asmname, statename, xanim, 85 );
                    function_3474c2003e05a5e0( asmname, statename, xanim, 16 );
                    function_37064c5f2a8f68ef( asmname, statename, xanim, "<dev string:x66f>" );
                    function_37064c5f2a8f68ef( asmname, statename, xanim, "<dev string:x682>" );
                    function_d6919795e4b24d3a( asmname, statename, xanim, "<dev string:x6a3>" );
                    function_d6919795e4b24d3a( asmname, statename, xanim, "<dev string:x6b0>" );
                    function_d6919795e4b24d3a( asmname, statename, xanim, "<dev string:x6c6>" );
                }
            }
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x4ea2
    // Size: 0x1f0, Type: dev
    function function_9a500dc0cc17d6da( asmname, statename, params )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        assert( isdefined( self.animsetname ) );
        arc = self.animsetname;
        aliases = archetypegetaliases( arc, statename );
        pistol_pickup = "<dev string:x6da>";
        var_9232727e455493f7 = "<dev string:x6eb>";
        
        foreach ( alias in aliases )
        {
            if ( issubstr( alias, "<dev string:x664>" ) )
            {
                continue;
            }
            
            anims = asm_getallanimsforalias( arc, statename, alias );
            
            if ( isdefined( anims ) )
            {
                foreach ( xanim in anims )
                {
                    if ( !animhasnotetrack( xanim, "<dev string:x703>" ) && !animhasnotetrack( xanim, "<dev string:x711>" ) && !animhasnotetrack( xanim, "<dev string:x720>" ) )
                    {
                        print( "<dev string:x732>" + asmname + "<dev string:x1bf>" + statename + "<dev string:x1cb>" + getxhashsourcename( getanimname( xanim ) ) + "<dev string:x1d6>" );
                        level.var_e941151b3a81c996 = 0;
                    }
                    
                    if ( !animhasnotetrack( xanim, "<dev string:x6da>" ) && !animhasnotetrack( xanim, "<dev string:x6eb>" ) )
                    {
                        print( "<dev string:x7c9>" + asmname + "<dev string:x1bf>" + statename + "<dev string:x1cb>" + getxhashsourcename( getanimname( xanim ) ) + "<dev string:x1d6>" );
                        level.var_e941151b3a81c996 = 0;
                    }
                }
            }
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x509a
    // Size: 0x19f, Type: dev
    function validator_exit( asmname, statename, params )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        assert( isdefined( self.animsetname ) );
        arc = self.animsetname;
        aliases = archetypegetaliases( arc, statename );
        
        foreach ( alias in aliases )
        {
            if ( issubstr( alias, "<dev string:x664>" ) )
            {
                continue;
            }
            
            anims = asm_getallanimsforalias( arc, statename, alias );
            
            if ( isdefined( anims ) )
            {
                foreach ( xanim in anims )
                {
                    function_291d962b22a07e21( asmname, statename, alias, xanim );
                    function_d6919795e4b24d3a( asmname, statename, xanim, "<dev string:x314>" );
                    function_d6919795e4b24d3a( asmname, statename, xanim, "<dev string:x321>" );
                    function_6893c43c1838f552( asmname, statename, xanim, "<dev string:x314>", "<dev string:x321>" );
                    function_481385c3b908b994( asmname, statename, xanim, 65 );
                    function_3474c2003e05a5e0( asmname, statename, xanim, 8 );
                    function_37064c5f2a8f68ef( asmname, statename, xanim, "<dev string:x6b0>" );
                    function_37064c5f2a8f68ef( asmname, statename, xanim, "<dev string:x6c6>" );
                }
            }
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x5241
    // Size: 0x1f1, Type: dev
    function validator_death( asmname, statename, params )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        assert( isdefined( self.animsetname ) );
        arc = self.animsetname;
        aliases = archetypegetaliases( arc, statename );
        
        foreach ( alias in aliases )
        {
            if ( issubstr( alias, "<dev string:x664>" ) )
            {
                continue;
            }
            
            anims = asm_getallanimsforalias( arc, statename, alias );
            
            if ( isdefined( anims ) )
            {
                foreach ( xanim in anims )
                {
                    function_d6919795e4b24d3a( asmname, statename, xanim, "<dev string:x85e>" );
                    
                    if ( animhasnotetrack( xanim, "<dev string:x85e>" ) )
                    {
                        var_acfa015f21c55596 = 0.05 / max( getanimlength( xanim ), 0.05 );
                        ragdoll_times = getnotetracktimes( xanim, "<dev string:x85e>" );
                        
                        foreach ( note in ragdoll_times )
                        {
                            if ( note > var_acfa015f21c55596 )
                            {
                                print( "<dev string:x86f>" + asmname + "<dev string:x1bf>" + statename + "<dev string:x1cb>" + getxhashsourcename( getanimname( xanim ) ) + "<dev string:x1d6>" );
                                level.var_e941151b3a81c996 = 0;
                            }
                        }
                    }
                }
            }
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x543a
    // Size: 0x1a2, Type: dev
    function function_a61779d8c4b66cda( asmname, statename, params )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        assert( isdefined( self.animsetname ) );
        arc = self.animsetname;
        aliases = archetypegetaliases( arc, statename );
        
        foreach ( alias in aliases )
        {
            if ( issubstr( alias, "<dev string:x664>" ) )
            {
                continue;
            }
            
            anims = asm_getallanimsforalias( arc, statename, alias );
            
            if ( isdefined( anims ) )
            {
                foreach ( xanim in anims )
                {
                    function_37064c5f2a8f68ef( asmname, statename, xanim, "<dev string:x65a>" );
                    function_d6919795e4b24d3a( asmname, statename, xanim, "<dev string:x314>" );
                    function_d6919795e4b24d3a( asmname, statename, xanim, "<dev string:x321>" );
                    function_6893c43c1838f552( asmname, statename, xanim, "<dev string:x314>", "<dev string:x321>" );
                    function_481385c3b908b994( asmname, statename, xanim, 65 );
                    function_3474c2003e05a5e0( asmname, statename, xanim, 8 );
                    function_37064c5f2a8f68ef( asmname, statename, xanim, "<dev string:x6b0>" );
                    function_37064c5f2a8f68ef( asmname, statename, xanim, "<dev string:x6c6>" );
                }
            }
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x55e4
    // Size: 0x152, Type: dev
    function validator_reload( asmname, statename, params )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        assert( isdefined( self.animsetname ) );
        arc = self.animsetname;
        aliases = archetypegetaliases( arc, statename );
        
        foreach ( alias in aliases )
        {
            if ( issubstr( alias, "<dev string:x8c7>" ) )
            {
                continue;
            }
            
            anims = asm_getallanimsforalias( arc, statename, alias );
            var_36eebb886bbddcca = !issubstr( alias, "<dev string:x8ce>" );
            
            if ( isdefined( anims ) )
            {
                foreach ( xanim in anims )
                {
                    if ( var_36eebb886bbddcca )
                    {
                        function_d6919795e4b24d3a( asmname, statename, xanim, "<dev string:x8d9>" );
                    }
                    
                    function_d6919795e4b24d3a( asmname, statename, xanim, "<dev string:x6a3>" );
                }
            }
        }
    }

    // Namespace utility / scripts\asm\shared\utility
    // Params 3
    // Checksum 0x0, Offset: 0x573e
    // Size: 0x12f, Type: dev
    function function_7f7e506dee7aa8c2( asmname, statename, params )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        assert( isdefined( self.animsetname ) );
        function_6421e5a82688da9d( asmname, statename, params );
        arc = self.animsetname;
        aliases = archetypegetaliases( arc, statename );
        
        foreach ( alias in aliases )
        {
            anims = asm_getallanimsforalias( arc, statename, alias );
            
            if ( isdefined( anims ) )
            {
                foreach ( xanim in anims )
                {
                    function_291d962b22a07e21( asmname, statename, alias, xanim );
                    function_d6919795e4b24d3a( asmname, statename, xanim, "<dev string:x314>" );
                }
            }
        }
    }

#/

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x5875
// Size: 0x51
function mapangleindextonumpad( idx )
{
    mapping = [ 2, 3, 6, 9, 8, 7, 4, 1, 2 ];
    return mapping[ idx ];
}

// Namespace utility / scripts\asm\shared\utility
// Params 5
// Checksum 0x0, Offset: 0x58cf
// Size: 0x8d
function toggle_poiauto( shouldenable, yawmin, yawmax, pitchmin, pitchmax )
{
    if ( shouldenable )
    {
        if ( !isdefined( self.poiauto ) )
        {
            poiauto_init( yawmin, yawmax, pitchmin, pitchmax );
            thread poiauto_think();
            scripts\common\ai::set_gunpose( "disable" );
        }
        
        return;
    }
    
    self notify( "poiauto_disable" );
    self.poiauto = undefined;
    self.poiauto_valid = 0;
    scripts\common\ai::set_gunpose( "automatic" );
    self stoplookat();
}

// Namespace utility / scripts\asm\shared\utility
// Params 4
// Checksum 0x0, Offset: 0x5964
// Size: 0x182
function set_poiauto_constraints( yawmax, yawmin, pitchmin, pitchmax )
{
    assert( isdefined( self.poiauto ) );
    
    if ( !isdefined( self.poiauto.og_yawmax ) )
    {
        self.poiauto.og_yawmax = self.poiauto.yawmax;
    }
    
    if ( !isdefined( self.poiauto.og_yawmin ) )
    {
        self.poiauto.og_yawmin = self.poiauto.yawmin;
    }
    
    if ( !isdefined( self.poiauto.og_pitchmin ) )
    {
        self.poiauto.og_pitchmin = self.poiauto.pitchmin;
    }
    
    if ( !isdefined( self.poiauto.og_pitchmax ) )
    {
        self.poiauto.og_pitchmax = self.poiauto.pitchmax;
    }
    
    self.poiauto.yawmax = yawmax;
    self.poiauto.yawmin = yawmin;
    self.poiauto.pitchmin = pitchmin;
    self.poiauto.pitchmax = pitchmax;
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x5aee
// Size: 0xea
function reset_poiauto_constraints()
{
    assert( isdefined( self.og_yawmax ) );
    assert( isdefined( self.og_yawmin ) );
    assert( isdefined( self.og_pitchmin ) );
    assert( isdefined( self.og_pitchmax ) );
    self.poiauto.yawmax = self.poiauto.og_yawmax;
    self.poiauto.yawmin = self.poiauto.og_yawmin;
    self.poiauto.pitchmin = self.poiauto.og_pitchmin;
    self.poiauto.pitchmax = self.poiauto.og_pitchmax;
}

// Namespace utility / scripts\asm\shared\utility
// Params 2
// Checksum 0x0, Offset: 0x5be0
// Size: 0x21a
function toggle_poi( shouldenable, firstpoint )
{
    assertex( shouldenable == 1 || shouldenable == 0, "<dev string:x8e8>" );
    self.currentpoi = undefined;
    self.nextpoi = undefined;
    self.doingpoi = shouldenable;
    self.disablelookdownpath = shouldenable;
    
    if ( isdefined( self.cqb_point_of_interest ) )
    {
        self.cqb_point_of_interest = undefined;
        self function_f7d83c92f61dcc31( 0 );
    }
    
    if ( !shouldenable )
    {
        assertex( isdefined( level.poi_activeai ), "<dev string:x919>" );
        level.poi_activeai = array_remove( level.poi_activeai, self );
        self.turnrate = ter_op( isdefined( self.poi_oldturnrate ), self.poi_oldturnrate, self.turnrate );
        self.gunadditiveoverride = undefined;
        self.disablelookdownpath = undefined;
        self._blackboard.forcestrafe = 0;
        self.gunposeoverride = undefined;
        self stoplookat();
        return;
    }
    
    currentspeed = self aigetdesiredspeed();
    archetype = self getbasearchetype();
    var_1e5343d5beae9c26 = getanimspeedthreshold( archetype, "fast" );
    self aisetdesiredspeed( min( currentspeed, var_1e5343d5beae9c26 ) );
    
    if ( !isdefined( level.poi_activeai ) )
    {
        level.poi_activeai = [];
    }
    
    level.poi_activeai[ level.poi_activeai.size ] = self;
    
    if ( isdefined( level.fnfindcqbpointsofinterest ) && !istrue( level.alreadyfindingpoi ) )
    {
        level thread [[ level.fnfindcqbpointsofinterest ]]();
        level.alreadyfindingpoi = 1;
    }
    
    assert( !isdefined( firstpoint ) || isstruct( firstpoint ) );
    self.poi_oldturnrate = self.turnrate;
    self.turnrate = 0.25;
    self.leftaimlimit = 90;
    self.rightaimlimit = -90;
    self.poi_firstpoint = firstpoint;
    self.gunposeoverride = "disable";
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x5e02
// Size: 0x1e
function shouldinitiallyattackfromexposed( node )
{
    return self._blackboard.shouldinitiallyattackfromexposed;
}

// Namespace utility / scripts\asm\shared\utility
// Params 2
// Checksum 0x0, Offset: 0x5e29
// Size: 0x1e5
function cover_canattackfromexposed( enemyorigin, node )
{
    assert( isdefined( self.enemy ) );
    
    if ( !isplayer( self.enemy ) && !isai( self.enemy ) )
    {
        return 1;
    }
    
    if ( cover_canattackfromexposedcached() )
    {
        return cover_canattackfromexposedgetcache();
    }
    
    if ( !isdefined( node ) )
    {
        node = self.covernode;
    }
    
    if ( !isdefined( node ) )
    {
        node = self.node;
    }
    
    if ( !isdefined( node ) )
    {
        return 0;
    }
    
    higheststance = gethighestallowedstance();
    zheight = 56;
    
    if ( higheststance != "stand" )
    {
        zheight = 32;
    }
    
    startorigin = node.origin + ( 0, 0, zheight );
    
    if ( !isdefined( enemyorigin ) )
    {
        if ( isai( self.enemy ) && !isbot( self.enemy ) )
        {
            enemyorigin = self.enemy getapproxeyepos();
        }
        else
        {
            enemyorigin = self.enemy geteye();
        }
    }
    
    var_d786be37f6c3bf95 = 1000;
    self._blackboard.canattackfromexposed = sighttracepassed( startorigin, enemyorigin, 0, undefined );
    self._blackboard.canattackfromexposedtime = gettime() + var_d786be37f6c3bf95;
    
    /#
        if ( getdvarint( @"hash_12099888645f099a" ) )
        {
            color = ( 1, 0, 0 );
            
            if ( self._blackboard.canattackfromexposed )
            {
                color = ( 0, 1, 0 );
            }
            
            print3d( startorigin, "<dev string:x957>", color, 1, 1, 15 );
            line( startorigin, enemyorigin, color, 1, 1, 15 );
        }
    #/
    
    return self._blackboard.canattackfromexposed;
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x6017
// Size: 0x33, Type: bool
function cover_canattackfromexposedcached()
{
    return isdefined( self._blackboard.canattackfromexposedtime ) && self._blackboard.canattackfromexposedtime > gettime();
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x6053
// Size: 0x15
function cover_canattackfromexposedgetcache()
{
    return self._blackboard.canattackfromexposed;
}

// Namespace utility / scripts\asm\shared\utility
// Params 4
// Checksum 0x0, Offset: 0x6071
// Size: 0xb3
function poiauto_init( yawmin, yawmax, pitchmin, pitchmax )
{
    if ( !isdefined( yawmin ) )
    {
        yawmin = 15;
    }
    
    if ( !isdefined( yawmax ) )
    {
        yawmax = 35;
    }
    
    if ( !isdefined( pitchmin ) )
    {
        pitchmin = -20;
    }
    
    if ( !isdefined( pitchmax ) )
    {
        pitchmax = 0;
    }
    
    self.poiauto = spawnstruct();
    self.poiauto.yawmax = yawmax;
    self.poiauto.yawmin = yawmin;
    self.poiauto.pitchmin = pitchmin;
    self.poiauto.pitchmax = pitchmax;
    self.poiauto_valid = 1;
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x612c
// Size: 0x14c
function poiauto_think()
{
    self endon( "poiauto_disable" );
    self endon( "death" );
    var_c2d5805bcd983331 = 500;
    nextaimtimer = 0;
    lastaimtimer = 0;
    var_46de370fcb18a1b0 = gettime() + 30000;
    
    if ( !isdefined( self.poiauto ) )
    {
        poiauto_init();
    }
    
    while ( true )
    {
        secondaim = 0;
        
        if ( var_46de370fcb18a1b0 <= gettime() )
        {
            self.poiauto_angles = ( 0, 0, 0 );
            
            if ( var_46de370fcb18a1b0 == nextaimtimer )
            {
                secondaim = 1;
            }
        }
        
        if ( nextaimtimer <= gettime() )
        {
            var_46de370fcb18a1b0 = gettime() + int( randomfloatrange( 0.8, 1.8 ) * 1000 );
            lastaimtimer = gettime();
            poiauto_setnewaimangle( secondaim );
            var_3080e8000aad4930 = var_c2d5805bcd983331 - gettime();
            var_37b7ec64d7b29bdb = var_46de370fcb18a1b0 - gettime();
            
            if ( abs( var_37b7ec64d7b29bdb - var_3080e8000aad4930 ) >= 550 && cointoss() )
            {
                nextaimtimer = var_46de370fcb18a1b0;
            }
            else if ( var_3080e8000aad4930 > 3000 )
            {
                nextaimtimer = gettime() + randomintrange( 2000, 3000 );
            }
            else
            {
                nextaimtimer = gettime() + var_3080e8000aad4930 + 550 + randomintrange( 1000, 2000 );
            }
        }
        
        waitframe();
    }
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x6280
// Size: 0x5a
function poiauto_relativeangletopos( angles )
{
    forward = anglestoforward( angles );
    worldforward = rotatevector( forward, self.angles );
    eye = self getapproxeyepos();
    pos = eye + worldforward * 128;
    return pos;
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x62e3
// Size: 0x59
function poiauto_glancerandom()
{
    yaw = randomfloatrange( -45, 45 );
    pitch = randomfloatrange( -20, 20 );
    pos = poiauto_relativeangletopos( ( pitch, yaw, 0 ) );
    self.poiauto_glancing = 1;
    thread poiauto_glanceend();
    self glanceatpos( pos );
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x6344
// Size: 0x21
function poiauto_glanceend()
{
    self notify( "poiauto_glanceend" );
    self endon( "poiauto_glanceend" );
    wait 0.55;
    self.poiauto_glancing = 0;
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x636d
// Size: 0xc, Type: bool
function poiauto_isglancing()
{
    return istrue( self.poiauto_glancing );
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x6382
// Size: 0xf4
function poiauto_setnewaimangle( secondaim )
{
    if ( secondaim )
    {
        yaw = randomfloatrange( self.poiauto_angles[ 1 ] + 5, self.poiauto_angles[ 1 ] + 10 );
        pitch = randomfloatrange( 5, 10 );
        
        if ( cointoss() )
        {
            pitch *= -1;
        }
        
        pitch = self.poiauto_angles[ 0 ] + pitch;
    }
    else
    {
        poiauto = self.poiauto;
        yaw = randomfloatrange( poiauto.yawmin, poiauto.yawmax );
        pitch = randomfloatrange( poiauto.pitchmin, poiauto.pitchmax );
    }
    
    if ( cointoss() )
    {
        yaw *= -1;
    }
    
    self.poiauto_nextangles = ( pitch, yaw, 0 );
    self.poiauto_nextaimtime = randomintrange( 100, 300 ) + gettime();
}

// Namespace utility / scripts\asm\shared\utility
// Params 0
// Checksum 0x0, Offset: 0x647e
// Size: 0x36
function function_2285421dfc79c4d5()
{
    arcname = undefined;
    
    if ( isdefined( self.animationarchetype ) )
    {
        arcname = self.animationarchetype;
    }
    else
    {
        arcname = self.animsetname;
    }
    
    return arcname;
}

// Namespace utility / scripts\asm\shared\utility
// Params 1
// Checksum 0x0, Offset: 0x64bd
// Size: 0xc6
function function_75996a8dac6970f2( range )
{
    if ( !isdefined( range ) )
    {
        range = 1024;
    }
    
    if ( issp() )
    {
        player = level.player;
    }
    else
    {
        [ player ] = sortbydistance( level.players, self.origin );
    }
    
    if ( self isnearanyplayer( range ) )
    {
        lookpoint = player.origin + ( 0, 0, 55 );
    }
    else
    {
        lookpoint = self.origin + ( 0, 0, 55 ) + anglestoforward( self.angles + ( 0, randomintrange( -135, 180 ), 0 ) ) * 300;
    }
    
    return lookpoint;
}

