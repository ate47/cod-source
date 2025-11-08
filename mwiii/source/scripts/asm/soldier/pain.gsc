#using scripts\anim\battlechatter_events;
#using scripts\anim\face;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\script_funcs;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace pain;

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x6d2
// Size: 0x46
function isdamagelocation_rarm( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        return damagelocationisany( "right_arm_upper", "right_arm_lower", "right_hand" );
    }
    
    return 0;
}

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x721
// Size: 0x46
function isdamagelocation_rleg( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        return damagelocationisany( "right_leg_upper", "right_foot", "right_leg_lower" );
    }
    
    return 0;
}

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x770
// Size: 0x46
function isdamagelocation_lleg( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        return damagelocationisany( "left_leg_upper", "left_foot", "left_leg_lower" );
    }
    
    return 0;
}

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x7bf
// Size: 0x46
function isdamagelocation_larm( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        return damagelocationisany( "left_arm_upper", "left_arm_lower", "left_hand" );
    }
    
    return 0;
}

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x80e
// Size: 0x41
function isdamagelocation_torso( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        return damagelocationisany( "torso_upper", "torso_lower" );
    }
    
    return 0;
}

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x858
// Size: 0x46
function isdamagelocation_head( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        return damagelocationisany( "head", "neck", "helmet" );
    }
    
    return 0;
}

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x8a7
// Size: 0x4c
function isdamagelocation_larmcrouch( asmname, statename, tostatename, params )
{
    return damagelocationisany( "left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "torso_lower" );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x8fc
// Size: 0x67, Type: bool
function isdamagelocation_back( asmname, statename, tostatename, params )
{
    if ( !self.damageshield )
    {
        if ( gethumandamagedirstring() == 1 && !damagelocationisany( "left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x96c
// Size: 0x65
function isdamagelocation_torsocovercrouch( asmname, statename, tostatename, params )
{
    return damagelocationisany( "right_arm_upper", "right_arm_lower", "right_hand", "left_hand", "left_arm_upper", "left_arm_lower", "left_leg_upper", "left_leg_lower", "left_foot", "right_leg_upper", "right_leg_lower", "right_foot" );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x9da
// Size: 0x31
function choosepainanimshock( asmname, statename, params )
{
    return asm_lookupanimfromalias( statename, "shock_loop_" + self.currentpose );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 0
// Checksum 0x0, Offset: 0xa14
// Size: 0x5e
function playsonicshockfx()
{
    if ( utility::isdamageweapon( makeweapon( "iw7_sonic" ) ) && utility::isweaponepic( self.damageweapon ) )
    {
        playfxontag( level.g_effect[ "soldier_shock" ], self, "j_knee_ri" );
        playfxontag( level.g_effect[ "soldier_shock" ], self, "j_shoulder_ri" );
    }
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0xa7a
// Size: 0x111
function playshockpainloop( asmname, statename, params )
{
    self endon( "death" );
    self endon( statename + "_finished" );
    painanim = asm_getanim( asmname, statename );
    loop_time = ter_op( isdefined( self.empstuntime ), self.empstuntime, 3.5 );
    playsonicshockfx();
    self animmode( "zonly_physics", 0 );
    wait randomfloat( 0.3 );
    
    if ( self.asmname == "c6" || self.asmname == "c6_worker" )
    {
        thread shockpainloop_internal( self.asmname, statename, 1, 0, 1 );
        self playsound( "generic_flashbang_c6_1" );
    }
    else
    {
        thread shockpainloop_internal( self.asmname, statename, 1, 0 );
    }
    
    wait loop_time;
    self notify( "painloop_end" );
    asm_fireevent( asmname, "stop_loop_pain" );
    self.emplooptime = undefined;
    finishpain( asmname, statename, params );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0xb93
// Size: 0x22
function shockpainloop_c6_cleanup( asmname, statename, params )
{
    self stopsounds();
}

// Namespace pain / scripts\asm\soldier\pain
// Params 5
// Checksum 0x0, Offset: 0xbbd
// Size: 0xf0
function shockpainloop_internal( asmname, statename, playbackrate, ismovestate, allowrandom )
{
    self endon( statename + "_finished" );
    self endon( "painloop_end" );
    
    if ( isdefined( ismovestate ) && ismovestate )
    {
        moveknob = asm_lookupanimfromaliasifexists( "knobs", "move" );
        
        if ( isdefined( moveknob ) )
        {
            self setmoveanimknob( moveknob );
        }
    }
    
    prevanim = asm_getbodyknob();
    curanim = asm_getanim( asmname, statename );
    
    while ( true )
    {
        if ( isdefined( allowrandom ) )
        {
            curanim = asm_getanim( asmname, statename );
        }
        
        curxanim = asm_getxanim( statename, curanim );
        self aisetanim( statename, curanim, playbackrate );
        asm_playfacialanim( asmname, statename, curxanim );
        prevanim = curanim;
        asm_donotetrackssingleloop( asmname, statename, curxanim, asm_getnotehandler( asmname, statename ) );
    }
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0xcb5
// Size: 0x31
function chooseshockpainrecovery( asmname, statename, params )
{
    return asm_lookupanimfromalias( statename, "shock_finish_" + self.currentpose );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0xcef
// Size: 0x26
function playpainanim( asmname, statename, params )
{
    playpainaniminternal( asmname, statename, params, 0 );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0xd1d
// Size: 0x27
function playpainanimwithadditives( asmname, statename, params )
{
    playpainaniminternal( asmname, statename, params, 1 );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0xd4c
// Size: 0x3c
function playpainanimlmg( asmname, statename, params )
{
    self._blackboard.inlmgstate = 1;
    playpainaniminternal( asmname, statename, params, 0 );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 2
// Checksum 0x0, Offset: 0xd90
// Size: 0x20
function pain_can_use_handler( note, params )
{
    if ( note == "pain_can_end" )
    {
        return 1;
    }
}

// Namespace pain / scripts\asm\soldier\pain
// Params 0
// Checksum 0x0, Offset: 0xdb8
// Size: 0x13a
function getpainweaponsize()
{
    size = "_md";
    weaponsize = "rifle";
    objweapon = self.damageweapon;
    
    if ( isdefined( objweapon ) && objweapon.basename != "iw8_sn_mike14" )
    {
        weaponsize = objweapon.classname;
    }
    
    if ( weaponsize == "pistol" || weaponsize == "smg" )
    {
        size = "_md";
    }
    else if ( weaponsize == "spread" )
    {
        size = "_md";
        
        if ( isdefined( self.lastattacker ) && distancesquared( self.lastattacker.origin, self.origin ) <= 62500 )
        {
            size = "_lg";
        }
    }
    else if ( weaponsize == "sniper" || weaponsize == "mg" )
    {
        size = "_lg";
    }
    else if ( weaponsize == "grenade" && isdefined( self.damagemod ) && self.damagemod == "MOD_IMPACT" )
    {
        size = "_lg";
    }
    
    if ( isdefined( level.fnasmsoldiergetpainweaponsize ) )
    {
        size = self [[ level.fnasmsoldiergetpainweaponsize ]]( size );
    }
    
    return size;
}

// Namespace pain / scripts\asm\soldier\pain
// Params 0
// Checksum 0x0, Offset: 0xefb
// Size: 0xc0
function getpaindirectiontoactor()
{
    if ( isdefined( self.damageyaw ) && self.damageyaw >= -45 && self.damageyaw <= 45 )
    {
        dir = "_b";
        return dir;
    }
    
    if ( isdefined( self.damageyaw ) && self.damageyaw < -45 && self.damageyaw > -135 )
    {
        dir = "_l";
        return dir;
    }
    
    if ( isdefined( self.damageyaw ) && self.damageyaw > 45 && self.damageyaw < 135 )
    {
        dir = "_r";
        return dir;
    }
    
    dir = "_f";
    return dir;
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0xfc3
// Size: 0x4d
function choosedirectionalpainanim_transition( asmname, statename, params )
{
    if ( isdefined( self.var_872a8e737f3e5358 ) )
    {
        var_6ad9995dd505716a = self.var_872a8e737f3e5358;
        return asm_lookupanimfromalias( statename, var_6ad9995dd505716a );
    }
    
    return asm_getrandomanim( statename );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 8
// Checksum 0x0, Offset: 0x1019
// Size: 0x273
function playpainaniminternal( asmname, statename, params, shouldplayadditives, var_96d69c0cc6fb90c1, statenameoverride, dontsetorientmode, var_94987ccb5819c6e9 )
{
    self endon( statename + "_finished" );
    
    if ( isdefined( self.a.paintime ) )
    {
        self.a.lastpaintime = self.a.paintime;
    }
    else
    {
        self.a.lastpaintime = 0;
    }
    
    self.a.paintime = gettime();
    
    if ( self.stairsstate != "none" )
    {
        self.a.painonstairs = 1;
    }
    else
    {
        self.a.painonstairs = undefined;
    }
    
    self.a.painplaying = 1;
    
    if ( isdefined( self.painfunction ) )
    {
        shouldcontinue = [[ self.painfunction ]]();
        
        if ( !istrue( shouldcontinue ) )
        {
            self.a.painplaying = undefined;
            return;
        }
    }
    
    self animmode( "gravity" );
    
    if ( !istrue( dontsetorientmode ) )
    {
        self orientmode( "face angle", self.angles[ 1 ] );
    }
    
    if ( !isdefined( self.no_pain_sound ) )
    {
        scripts\anim\face::saygenericdialogue( "pain" );
    }
    
    if ( scripts\asm\soldier\death::shouldhelmetpoponpain( utility::wasdamagedbyexplosive() ) )
    {
        scripts\asm\soldier\death::helmetpop();
    }
    
    animstatename = statename;
    
    if ( isdefined( statenameoverride ) )
    {
        animstatename = statenameoverride;
    }
    
    painanim = asm_getanim( asmname, statename, params );
    assert( isdefined( painanim ) );
    self aisetanim( animstatename, painanim );
    painxanim = asm_getxanim( animstatename, painanim );
    asm_playfacialanim( asmname, statename, painxanim );
    
    if ( isdefined( var_94987ccb5819c6e9 ) )
    {
        self thread [[ var_94987ccb5819c6e9 ]]( asmname, statename, painanim, painxanim );
    }
    
    self.requestdifferentcover = 1;
    
    if ( animhasnotetrack( painxanim, "code_move" ) )
    {
        asm_donotetracks( asmname, statename, undefined, undefined, animstatename );
    }
    
    asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ), undefined, animstatename );
    
    if ( istrue( var_96d69c0cc6fb90c1 ) )
    {
        finishpain( asmname, statename, params );
        return;
    }
    
    finishpain( asmname, statename );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 2
// Checksum 0x0, Offset: 0x1294
// Size: 0x2b
function paincanend( statename, notename )
{
    switch ( notename )
    {
        case #"hash_b28f889d3f68dd76":
            return 1;
    }
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x12c7
// Size: 0x57
function coverexppainselectreturna( asmname, statename, params )
{
    if ( isdefined( self._blackboard.coverexposetype ) && self._blackboard.coverexposetype == "A" )
    {
        return 1;
    }
    
    return 0;
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1326
// Size: 0x6c
function finishpain( asmname, statename, params )
{
    self.a.painplaying = undefined;
    self notify( "killanimscript" );
    returnstate = undefined;
    
    if ( isdefined( params ) )
    {
        if ( isarray( params ) )
        {
            returnstate = params[ 0 ];
        }
        else
        {
            returnstate = params;
        }
    }
    
    if ( !isdefined( returnstate ) )
    {
        return;
    }
    
    thread asm_setstate( returnstate, undefined );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x139a
// Size: 0x32
function playcoverpainanimwithadditives( asmname, statename, params )
{
    self.keepclaimednodeifvalid = 1;
    playpainaniminternal( asmname, statename, params, 1 );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x13d4
// Size: 0x30
function playcoverpainanim( asmname, statename, params )
{
    self.keepclaimednodeifvalid = 1;
    playpainanim( asmname, statename, params );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x140c
// Size: 0x97
function choosepainanim_standtorsotoexposed( asmname, statename, params )
{
    assert( isdefined( self.lasttorsoanim ) );
    
    if ( self.lasttorsoanim == "torso_upper" )
    {
        transitionanim = asm_lookupanimfromalias( statename, "torso_upper" );
    }
    else if ( self.lasttorsoanim == "torso_lower" )
    {
        transitionanim = asm_lookupanimfromalias( statename, "torso_lower" );
    }
    else
    {
        transitionanim = asm_lookupanimfromalias( statename, "default" );
    }
    
    self.lasttorsoanim = undefined;
    return transitionanim;
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x14ac
// Size: 0x8e
function choosepainanim_standtorso( asmname, statename, params )
{
    if ( damagelocationisany( "torso_upper" ) )
    {
        self.lasttorsoanim = "torso_upper";
        return asm_lookupanimfromalias( statename, "torso_upper" );
    }
    
    if ( damagelocationisany( "torso_lower" ) )
    {
        self.lasttorsoanim = "torso_lower";
        return asm_lookupanimfromalias( statename, "torso_lower" );
    }
    
    self.lasttorsoanim = "default";
    return asm_lookupanimfromalias( statename, "default" );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1542
// Size: 0x17f
function choosepainanim_stand( asmname, statename, params )
{
    if ( isusingsidearm() )
    {
        return choosepainanim_pistol( asmname, statename, params );
    }
    
    painarray = [];
    
    if ( damagelocationisany( "torso_upper" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "torso_upper" );
    }
    else if ( damagelocationisany( "torso_lower" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "torso_lower" );
    }
    else if ( damagelocationisany( "head", "helmet", "neck" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "head" );
    }
    else if ( damagelocationisany( "right_arm_upper", "right_arm_lower" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "right_arm" );
    }
    else if ( damagelocationisany( "left_arm_upper", "left_arm_lower" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "left_arm" );
    }
    else if ( damagelocationisany( "left_leg_upper", "left_leg_lower", "left_foot" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "left_leg" );
    }
    else if ( damagelocationisany( "right_leg_upper", "right_leg_lower", "right_foot" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "right_leg" );
    }
    
    if ( painarray.size < 2 )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "default" );
    }
    
    assertex( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x16ca
// Size: 0x59
function choosepainanim_damageshield( asmname, statename, params )
{
    painarray = [];
    
    if ( painarray.size < 2 )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "default" );
    }
    
    assertex( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x172c
// Size: 0x51
function choosedynamicpainanim_expcrouchlegs( asmname, statename, params )
{
    painarray = [];
    painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "default" );
    assertex( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1786
// Size: 0xa3
function choosepainanim_crouch( asmname, statename, params )
{
    painarray = [];
    painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "default" );
    
    if ( damagelocationisany( "left_hand", "left_arm_lower", "left_arm_upper" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "left_arm" );
    }
    
    if ( damagelocationisany( "right_hand", "right_arm_lower", "right_arm_upper" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "right_arm" );
    }
    
    assertex( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1832
// Size: 0x18d
function choosepainanim_pistol( asmname, statename, params )
{
    painarray = [];
    
    if ( damagelocationisany( "torso_upper" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "pistol_torso_upper" );
    }
    else if ( damagelocationisany( "torso_lower" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "pistol_torso_lower" );
    }
    else if ( damagelocationisany( "neck" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "pistol_neck" );
    }
    else if ( damagelocationisany( "head" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "pistol_head" );
    }
    else if ( damagelocationisany( "left_leg_upper", "right_leg_upper" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "pistol_leg" );
    }
    else if ( damagelocationisany( "left_arm_upper" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "pistol_left_arm_upper" );
    }
    else if ( damagelocationisany( "left_arm_lower" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "pistol_left_arm_lower" );
    }
    else if ( damagelocationisany( "right_arm_upper" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "pistol_right_arm_upper" );
    }
    else if ( damagelocationisany( "right_arm_lower" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "pistol_right_arm_lower" );
    }
    
    if ( painarray.size < 2 )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "pistol_default" );
    }
    
    assertex( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x19c8
// Size: 0x6c
function choosepainanim_covercorner_helper( asmname, statename, params, angles )
{
    if ( isdefined( params ) && isdefined( params[ 1 ] ) )
    {
        return asm_lookupanimfromalias( statename, params[ 1 ] );
    }
    
    if ( self.currentpose == "crouch" )
    {
        return asm_lookupanimfromalias( statename, "crouch" );
    }
    
    return asm_lookupanimfromalias( statename, "stand" );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1a3c
// Size: 0x25
function choosepainanim_covercorner( asmname, statename, params )
{
    return choosepainanim_covercorner_helper( asmname, statename, params, undefined );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1a6a
// Size: 0x34
function choosedynamicpainanim_back( asmname, statename, params )
{
    alias = "back";
    return asm_lookupanimfromalias( statename, alias );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1aa7
// Size: 0xa9
function choosedynamicpainanim_covercrouch( asmname, statename, params )
{
    painarray = [];
    
    if ( damagelocationisany( "torso_upper", "torso_lower" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "torso" );
    }
    else if ( damagelocationisany( "head", "helmet", "neck" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "head" );
    }
    
    if ( painarray.size < 2 )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "default" );
    }
    
    assertex( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1b59
// Size: 0x16c
function choosedynamicpainanim_coverstand( asmname, statename, params )
{
    painarray = [];
    
    if ( damagelocationisany( "torso_upper" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "torso_upper" );
    }
    else if ( damagelocationisany( "torso_lower" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "torso_lower" );
    }
    else if ( damagelocationisany( "head", "helmet", "neck" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "head" );
    }
    else if ( damagelocationisany( "right_arm_upper", "right_arm_lower" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "right_arm" );
    }
    else if ( damagelocationisany( "left_arm_upper", "left_arm_lower" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "left_arm" );
    }
    else if ( damagelocationisany( "left_leg_upper", "left_leg_lower", "left_foot" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "left_leg" );
    }
    else if ( damagelocationisany( "right_leg_upper", "right_leg_lower", "right_foot" ) )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "right_leg" );
    }
    
    if ( painarray.size < 2 )
    {
        painarray[ painarray.size ] = asm_lookupanimfromalias( statename, "default" );
    }
    
    assertex( painarray.size > 0, painarray.size );
    return painarray[ randomint( painarray.size ) ];
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1cce
// Size: 0x3a
function function_9a4a7270010ada09( asmname, statename, params )
{
    self aisettargetspeed( length( self.velocity ) );
    cleanuppainanim( asmname, statename, params );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1d10
// Size: 0x175
function cleanuppainanim( asmname, statename, params )
{
    if ( isdefined( self.script ) && self.script == "pain" )
    {
        self notify( "killanimscript" );
    }
    
    self.a.painplaying = undefined;
    
    if ( isdefined( self.damageshieldpain ) )
    {
        self.damageshieldcounter = undefined;
        self.damageshieldpain = undefined;
        self.allowpain = 1;
        
        if ( !isdefined( self.predamageshieldignoreme ) )
        {
            self.ignoreme = 0;
        }
        
        self.predamageshieldignoreme = undefined;
    }
    
    if ( isdefined( self.blockingpain ) )
    {
        self.blockingpain = undefined;
        self.allowpain = 1;
    }
    
    self._blackboard.var_74f8f2b8eff7c7f = 0;
    clearpainturnrate( asmname, statename, params );
    
    if ( istrue( self.leavecasualkiller ) )
    {
        scripts\asm\soldier\script_funcs::terminate_casualkiller( asmname, statename, params );
    }
    
    if ( !istrue( self.ignoreall ) )
    {
        if ( isdefined( self.enemy ) && lengthsquared( self.velocity ) < 1 && isdefined( self.weapon ) && !istrue( self.enemy.ignoreme ) && self cansee( self.enemy ) )
        {
            self.remainexposedendtime = gettime() + 2000;
        }
    }
}

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x1e8d
// Size: 0x60, Type: bool
function transition_flashfinished( asmname, fromstate, tostate, params )
{
    if ( !isflashed() )
    {
        return true;
    }
    
    if ( gettime() > self.flashendtime )
    {
        return true;
    }
    
    return asm_eventfired( asmname, "end" ) || asm_eventfired( asmname, "finish" );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1ef6
// Size: 0x5c
function playanim_stunned( asmname, statename, params )
{
    if ( isdefined( self.stunnedcallback ) )
    {
        self [[ self.stunnedcallback ]]();
    }
    
    stunnedanim = asm_getanim( asmname, statename, params );
    self aisetanim( statename, stunnedanim );
    asm_donotetracks( asmname, statename );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1f5a
// Size: 0x42
function function_5f1b71fde3cd5900( asmname, statename, params )
{
    stunnedanim = asm_getanim( asmname, statename, params );
    self aisetanim( statename, stunnedanim );
    asm_donotetracks( asmname, statename );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1fa4
// Size: 0x32, Type: bool
function function_e00aa948164f088c( asmname, statename, params )
{
    if ( isstunned() )
    {
        return false;
    }
    
    cleanuppainanim( asmname, statename, params );
    return true;
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x1fdf
// Size: 0x40
function playanim_flashed( asmname, statename, params )
{
    self endon( statename + "_finished" );
    playanim_flashed_internal( asmname, statename );
    thread playanim_monitorflashrestart( asmname, statename );
    asm_donotetracks( asmname, statename );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 2
// Checksum 0x0, Offset: 0x2027
// Size: 0xd1
function playanim_flashed_internal( asmname, statename )
{
    flashanim = asm_getanim( asmname, statename );
    rate = 1;
    
    if ( isdefined( self.flashendtime ) )
    {
        flashlength = self.flashendtime - gettime();
        xanim = asm_getxanim( statename, flashanim );
        animlength = getanimlength( xanim ) * 1000;
        
        if ( flashlength > 0 )
        {
            rate = animlength / flashlength;
        }
        
        rate += randomfloatrange( -0.1, 0.05 );
        rate = clamp( rate, 0.65, 1.2 );
        self.flashendtime = gettime() + int( animlength / rate );
    }
    
    self aisetanim( statename, flashanim, rate );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 2
// Checksum 0x0, Offset: 0x2100
// Size: 0x64
function playanim_monitorflashrestart( asmname, statename )
{
    self endon( statename + "_finished" );
    prevflashendtime = self.flashendtime;
    
    while ( isdefined( self.flashendtime ) )
    {
        if ( prevflashendtime != self.flashendtime )
        {
            playanim_flashed_internal( asmname, statename );
            prevflashendtime = self.flashendtime;
        }
        
        waitframe();
    }
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x216c
// Size: 0x2c
function cleanupflashanim( asmname, statename, params )
{
    cleanuppainanim( asmname, statename, params );
    flashbangstop();
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x21a0
// Size: 0xae
function playanim_burning( asmname, statename, params )
{
    self endon( statename + "_finished" );
    bcs_subcategory = scripts\anim\battlechatter_events::function_c666e714b2411844( self.damageweapon );
    
    if ( isdefined( bcs_subcategory ) )
    {
        addbattlechatternotify( self, undefined, "burn", bcs_subcategory );
    }
    
    burninganim = asm_getanim( asmname, statename, params );
    playrate = randomfloatrange( 0.8, 1.2 );
    self orientmode( "face angle", self.angles[ 1 ] );
    self aisetanim( statename, burninganim, playrate );
    asm_donotetracks( asmname, statename, &burn_notetrack_handler );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 1
// Checksum 0x0, Offset: 0x2256
// Size: 0xf4
function burn_notetrack_handler( note )
{
    if ( isdefined( self.semtexstuckto ) )
    {
        return;
    }
    
    switch ( note )
    {
        case #"hash_b3c1b4729e0c6d1a":
            playfxontag( level.g_effect[ "vfx_burn_sml_head_low" ], self, "j_helmet" );
            break;
        case #"hash_91b66b1e7d9268f1":
            playfxontag( level.g_effect[ "vfx_burn_sml_low" ], self, "j_elbow_le" );
            break;
        case #"hash_91b6751e7d9278af":
            playfxontag( level.g_effect[ "vfx_burn_sml_low" ], self, "j_shoulder_ri" );
            break;
        case #"hash_72c435d66be93437":
            playfxontag( level.g_effect[ "vfx_burn_med_low" ], self, "j_knee_le" );
            break;
        case #"hash_72c43bd66be93da9":
            playfxontag( level.g_effect[ "vfx_burn_med_low" ], self, "j_knee_ri" );
            break;
    }
}

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x2352
// Size: 0x21a
function painanimfaceenemy( asmname, statename, animid, xanim )
{
    self endon( statename + "_finished" );
    enemy = self.enemy;
    animlength = getanimlength( xanim );
    endtime = animlength * 0.8;
    startaimtime = animlength;
    var_6767247f28fabd3c = getnotetracktimes( xanim, "face_enemy" )[ 0 ];
    
    if ( isdefined( var_6767247f28fabd3c ) )
    {
        endtime = var_6767247f28fabd3c * animlength;
    }
    else
    {
        if ( asm_currentstatehasflag( asmname, "notetrackAim" ) )
        {
            startaimfrac = getnotetracktimes( xanim, "start_aim" )[ 0 ];
            
            if ( isdefined( startaimfrac ) )
            {
                endtime = min( endtime, max( 0, startaimfrac - 0.3 ) * animlength );
                startaimtime = startaimfrac * animlength;
            }
        }
        
        endtime = min( endtime, max( 0, animlength - 0.5 ) );
    }
    
    wait endtime;
    
    if ( isalive( enemy ) )
    {
        var_ab47b2ec8e13ed55 = getnotetracktimes( xanim, "face_enemy_end" )[ 0 ];
        var_253b2641c5fcf77a = 1;
        
        if ( isdefined( var_ab47b2ec8e13ed55 ) )
        {
            var_253b2641c5fcf77a = var_ab47b2ec8e13ed55;
        }
        
        turnduration = getanimlength( xanim ) * var_253b2641c5fcf77a - endtime;
        var_e473d197cb34ae13 = gettime() + turnduration * 1000;
        
        while ( gettime() < var_e473d197cb34ae13 && isalive( enemy ) )
        {
            metoenemy = enemy.origin - self.origin;
            angletoenemy = vectortoyaw( metoenemy );
            anglediff = angleclamp180( angletoenemy - self.angles[ 1 ] );
            curt = self getanimtime( xanim );
            remainingrot = getangledelta( xanim, curt, var_253b2641c5fcf77a );
            delta = anglediff - remainingrot;
            self orientmode( "face angle", self.angles[ 1 ] + delta );
            waitframe();
        }
    }
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x2574
// Size: 0x7f
function playpainanim_faceplayer( asmname, statename, params )
{
    self endon( statename + "_finished" );
    fnthread = undefined;
    
    if ( isalive( self.enemy ) && isdefined( self.lastattacker ) && self.enemy == self.lastattacker )
    {
        fnthread = &painanimfaceenemy;
    }
    
    playpainaniminternal( asmname, statename, params, 0, 1, undefined, 1, fnthread );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x25fb
// Size: 0x7e
function playpainanim_exposedstand( asmname, statename, params )
{
    self endon( statename + "_finished" );
    fnthread = undefined;
    
    if ( isalive( self.enemy ) && isdefined( self.lastattacker ) && self.enemy == self.lastattacker )
    {
        fnthread = &painanimfaceenemy;
    }
    
    playpainaniminternal( asmname, statename, params, 0, 1, undefined, 0, fnthread );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x2681
// Size: 0x43
function playpainanim_exposedcrouch( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self.painattacker = self.lastattacker;
    playpainaniminternal( asmname, statename, params, 0, 1 );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x26cc
// Size: 0xb6
function playpainanim_exposedcrouchtransition( asmname, statename, params )
{
    self endon( statename + "_finished" );
    animid = asm_getanim( asmname, statename );
    self aisetanim( statename, animid );
    asm_playfacialanim( asmname, statename, asm_getxanim( statename, animid ) );
    
    if ( isalive( self.enemy ) && isdefined( self.painattacker ) && self.enemy == self.painattacker )
    {
        thread painanimfaceenemy( asmname, statename, animid, asm_getxanim( statename, animid ) );
    }
    
    self.painattacker = undefined;
    asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x278a
// Size: 0x44
function clearpainturnrate( asmname, statename, params )
{
    if ( isdefined( self.painoldturnrate ) )
    {
        self.turnrate = self.painoldturnrate;
        self.painoldturnrate = undefined;
    }
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x27d6
// Size: 0xc7
function function_111158d9cee51970( asmname, statename, params )
{
    animaliasparam = undefined;
    
    if ( isdefined( params ) && isstring( params ) )
    {
        animaliasparam = params;
    }
    
    self endon( statename + "_finished" );
    self orientmode( "face current" );
    self animmode( "live_ragdoll" );
    
    if ( isdefined( animaliasparam ) )
    {
        animid = asm_getanim( asmname, statename, animaliasparam );
    }
    else
    {
        animid = asm_getanim( asmname, statename );
    }
    
    thread function_6d4426b00706324e();
    self aisetanim( statename, animid );
    endnote = asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
    
    if ( endnote == "code_move" )
    {
        endnote = asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
    }
}

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x28a5
// Size: 0xb1
function function_56a47f26f49fc5eb( asmname, statename, blendtime, params )
{
    self endon( statename + "_finished" );
    animid = asm_getanim( asmname, statename );
    animname = asm_getxanim( statename, animid );
    thread function_b3b20911062201ad();
    self aisetanim( statename, animid );
    asm_playfacialanim( asmname, statename, animname );
    self setliveragdollrecoveryanim( animname );
    endnote = asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
    
    if ( endnote == "code_move" )
    {
        endnote = asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
    }
}

// Namespace pain / scripts\asm\soldier\pain
// Params 0
// Checksum 0x0, Offset: 0x295e
// Size: 0x3b
function function_6d4426b00706324e()
{
    if ( !isdefined( self.weapon ) )
    {
        return;
    }
    
    self endon( "death" );
    self waittillmatch( "live_ragdoll_test", "ragdoll_gun_stow" );
    scripts\anim\shared::placeweaponon( self.weapon, "chest" );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 0
// Checksum 0x0, Offset: 0x29a1
// Size: 0x3b
function function_b3b20911062201ad()
{
    if ( !isdefined( self.weapon ) )
    {
        return;
    }
    
    self endon( "death" );
    self waittillmatch( "live_ragdoll_recover", "ragdoll_gun_unstow" );
    scripts\anim\shared::placeweaponon( self.weapon, "right" );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 4
// Checksum 0x0, Offset: 0x29e4
// Size: 0x2d, Type: bool
function disablerunpain( asmname, statename, tostatename, params )
{
    return istrue( self.disablerunpain );
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x2a1a
// Size: 0x46
function function_5e9e03bdd9237c0f( asmname, statename, params )
{
    painalias = "pain_popup" + getpaindirectiontoactor();
    painanim = asm_lookupanimfromalias( statename, painalias );
    return painanim;
}

// Namespace pain / scripts\asm\soldier\pain
// Params 3
// Checksum 0x0, Offset: 0x2a69
// Size: 0x46
function function_a131b253107d514b( asmname, statename, params )
{
    painalias = "pain_popup_recover" + getpaindirectiontoactor();
    painanim = asm_lookupanimfromalias( statename, painalias );
    return painanim;
}

