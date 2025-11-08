#using scripts\anim\notetracks_sp;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\sp\utility;
#using scripts\asm\shared\utility;
#using scripts\asm\track;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\door;
#using scripts\sp\door_internal;
#using scripts\sp\utility;

#namespace asm_sp;

// Namespace asm_sp / scripts\asm\asm_sp
// Params 2
// Checksum 0x0, Offset: 0x3f8
// Size: 0x23f
function asm_init( baseasmname, archetypename )
{
    if ( archetypename == "hero_salter" || archetypename == "farah" || archetypename == "soldier_female" )
    {
        scripts\asm\asm_bb::bb_setshort( 1 );
    }
    
    self.asmname = baseasmname;
    first_init = 0;
    
    if ( !isdefined( self.asm ) )
    {
        first_init = 1;
        self.asm = spawnstruct();
        self.asm.animoverrides = [];
        self.fnasm_init = &asm_init;
        self.fnasm_setupaim = &asm_setupaim_sp;
        self.fnasm_playfacialanim = &asm_playfacialanim_sp;
        self.fnasm_handlenotetrack = &scripts\anim\notetracks_sp::handlenotetrack;
        self.fnasm_playadditiveanimloopstate = &asm_playadditiveanimloopstate_sp;
        self.fnasm_clearfingerposes = &asm_clearfingerposes;
        self.fnplaceweaponon = &scripts\anim\shared::placeweaponon;
        self.fndooropen = &open_door;
        self.fndoorclose = &close_door;
        self.fndoorneedstoclose = &door_needs_to_close;
        self.fngetdoorcenter = &get_door_center;
        self.fndooralreadyopen = &is_door_already_open;
        self function_131f6fb305015d0( &scripts\asm\shared\utility::tryopendoor );
    }
    
    assert( isdefined( archetypename ) || isdefined( self.animsetname ) );
    
    if ( isdefined( archetypename ) )
    {
        if ( first_init )
        {
            self function_e855b69f84cb6ce3( archetypename );
        }
        else
        {
            self setanimset( archetypename );
        }
    }
    
    /#
        if ( isdefined( anim.var_cb1f5e85110fe3d ) && isdefined( anim.var_cb1f5e85110fe3d[ baseasmname ] ) )
        {
            if ( !function_87d74491d0318ba3( self.animsetname ) && archetypename != "<dev string:x1c>" )
            {
                level.var_e941151b3a81c996 = 1;
                self [[ anim.var_cb1f5e85110fe3d[ baseasmname ] ]]();
                scripts\asm\shared\sp\utility::function_ea262b8e6c281e21( baseasmname, archetypename );
                
                if ( getdvarint( @"hash_eea71d1ace9f4212", 0 ) == 1 )
                {
                    assertex( level.var_e941151b3a81c996, "<dev string:x27>" + baseasmname + "<dev string:x4f>" );
                }
                
                level.var_e941151b3a81c996 = undefined;
            }
        }
    #/
    
    /#
        if ( getdvarint( @"hash_826655be6deb410f", 0 ) == 1 )
        {
            function_211ce02c705f8c0c( baseasmname, archetypename );
        }
    #/
    
    function_c051a94f99bd65f1( self.asmname );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 0
// Checksum 0x0, Offset: 0x63f
// Size: 0x2c
function function_a2b8f8b0891ee7fe()
{
    level.fnanimatedprop_setup = &animatedprop_setup;
    level.fnanimatedprop_startanim = &animatedprop_startanim;
    level.fnanimatedprop_setanim = &animatedprop_setanim;
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0x673
// Size: 0x117
function updatepainvars( damagedsubpart )
{
    if ( self.damageshield && !isdefined( self.disabledamageshieldpain ) )
    {
        var_3bc04a1586573435 = 1500;
        
        if ( !isdefined( self.a.lastpaintime ) )
        {
            self.a.lastpaintime = 0;
        }
        
        if ( !isdefined( self.damageshieldcounter ) || gettime() - self.a.lastpaintime > var_3bc04a1586573435 )
        {
            self.damageshieldcounter = randomintrange( 2, 3 );
        }
        
        if ( isdefined( self.lastattacker ) && distancesquared( self.origin, self.lastattacker.origin ) < squared( 512 ) )
        {
            self.damageshieldcounter = 0;
        }
        
        if ( self.damageshieldcounter > 0 )
        {
            self.damageshieldcounter--;
        }
    }
    
    if ( isdefined( damagedsubpart ) )
    {
        self.damagedsubpart = damagedsubpart;
        return;
    }
    
    self.damagedsubpart = undefined;
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 0
// Checksum 0x0, Offset: 0x792
// Size: 0x22
function shouldplaypainanim()
{
    if ( isdefined( self.fnshouldplaypainanim ) )
    {
        return self [[ self.fnshouldplaypainanim ]]();
    }
    
    return shouldplaypainanimdefault();
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 0
// Checksum 0x0, Offset: 0x7bd
// Size: 0x45, Type: bool
function shouldplaypainanimdefault()
{
    var_ae76948f5ba13f88 = 4096;
    
    if ( self.a.disablepain )
    {
        return false;
    }
    
    if ( isdefined( self.pathgoalpos ) && self pathdisttogoal() < var_ae76948f5ba13f88 )
    {
        return false;
    }
    
    return true;
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 0
// Checksum 0x0, Offset: 0x80b
// Size: 0xb6
function paininternal()
{
    if ( true )
    {
        updatepainvars();
        
        if ( !shouldplaypainanim() )
        {
            if ( isdefined( self.script ) && self.script == "pain" )
            {
                self notify( "killanimscript" );
            }
            
            return;
        }
        
        bdidpain = 0;
        result = self asmevalpaintransition( self.asmname );
        
        if ( isdefined( result ) && result )
        {
            bdidpain = 1;
        }
        
        if ( self.type == "zombie" )
        {
            return;
        }
        
        if ( !bdidpain && self.script == "pain" )
        {
            self notify( "killanimscript" );
        }
    }
    
    self endon( "killanimscript" );
    self waittill( "Hellfreezesover" );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 0
// Checksum 0x0, Offset: 0x8c9
// Size: 0x1e
function subparthandler()
{
    self endon( "death" );
    self endon( "terminate_ai_threads" );
    assertmsg( "Dismemberment handlers not setup for code ASM. Bug an AI coder." );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0x8ef
// Size: 0x21
function asm_animhasfacialoverride( a_anim )
{
    if ( !animisleaf( a_anim ) )
    {
        return 0;
    }
    
    return animhasnotetrack( a_anim, "facial_override" );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 3
// Checksum 0x0, Offset: 0x919
// Size: 0x6c
function asm_playfacialanim_sp( asmname, statename, animname )
{
    if ( asmname != self.asmname )
    {
        return;
    }
    
    facialstate = self asmgetfacialstate();
    
    if ( isdefined( facialstate ) )
    {
        asm_playfacialaniminternal( animname, facialstate );
        return;
    }
    
    asm_clearfacialanim();
    self.asm.facial_state = "";
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 2
// Checksum 0x0, Offset: 0x98d
// Size: 0xeb
function asm_playfacialaniminternal( a_anim, a_state )
{
    /#
        if ( getdvar( @"hash_688ea70593f4db5e", "<dev string:x6b>" ) == "<dev string:x6d>" )
        {
            asm_clearfacialanim();
            return;
        }
    #/
    
    if ( !isfacialstateallowed( "asm" ) )
    {
        return;
    }
    
    if ( isdefined( a_anim ) && asm_animhasfacialoverride( a_anim ) )
    {
        return;
    }
    
    headknob = asm_lookupanimfromaliasifexists( "knobs", "head" );
    
    if ( !isdefined( headknob ) )
    {
        return;
    }
    
    if ( !isdefined( self.asm.facial_state ) )
    {
        self.asm.facial_state = "";
    }
    
    setfacialstate( "asm" );
    
    if ( isai( self ) )
    {
        self setfacialindex( a_state );
        return;
    }
    
    if ( istrue( self.var_5247d15da29e8539 ) )
    {
        function_ee3e5d584e317d35( a_state );
        return;
    }
    
    setfacialindexfornonai( a_state );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0xa80
// Size: 0x87
function asm_playfacialanimfromnotetrack( facial_state )
{
    archetype = function_2285421dfc79c4d5();
    
    if ( !isfacialstateallowed( "asm" ) && facial_state != "death" )
    {
        return;
    }
    
    if ( isdefined( archetype ) && archetype != "" )
    {
        setfacialstate( "asm" );
        
        if ( isai( self ) )
        {
            self setfacialindex( facial_state );
            return;
        }
        
        if ( isdefined( self.var_5247d15da29e8539 ) )
        {
            function_ee3e5d584e317d35( facial_state );
            return;
        }
        
        setfacialindexfornonai( facial_state );
    }
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0xb0f
// Size: 0x2f
function asm_playfacialanimsingleframedeath( guy )
{
    if ( isai( self ) )
    {
        self setfacialindex( "death" );
        return;
    }
    
    setfacialindexfornonai( "death" );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 0
// Checksum 0x0, Offset: 0xb46
// Size: 0x184
function asm_initfingerposes()
{
    self endon( "death" );
    var_17f47483908fd20f = 0;
    var_589c119009395654 = 0;
    animid = asm_lookupanimfromalias( "knobs", "inner_root" );
    inner_root = asm_getxanim( "knobs", animid );
    var_c163dcdce0c81c63 = 0;
    var_c163dadce0c817fd = 0;
    
    while ( true )
    {
        weights = self getanimikweights( inner_root );
        var_60f4ae371c171719 = weights[ 0 ] - var_17f47483908fd20f;
        var_73cc4a3989eefaad = ( var_60f4ae371c171719 > 0.001 ) - ( var_60f4ae371c171719 < -0.001 );
        
        if ( var_73cc4a3989eefaad != var_c163dcdce0c81c63 )
        {
            if ( var_73cc4a3989eefaad > 0 )
            {
                var_17f47483908fd20f = weights[ 0 ];
                var_c163dcdce0c81c63 = var_73cc4a3989eefaad;
                wait 0.1;
                asm_ikfingeranim( "left" );
                continue;
            }
            
            if ( var_73cc4a3989eefaad < 0 )
            {
                var_17f47483908fd20f = weights[ 0 ];
                var_c163dcdce0c81c63 = var_73cc4a3989eefaad;
                asm_clearikfingeranim( "left" );
                continue;
            }
        }
        
        var_17f47483908fd20f = weights[ 0 ];
        var_c163dcdce0c81c63 = var_73cc4a3989eefaad;
        diff_ikr = weights[ 1 ] - var_589c119009395654;
        state_ikr = ( diff_ikr > 0.001 ) - ( diff_ikr < -0.001 );
        
        if ( state_ikr != var_c163dadce0c817fd )
        {
            if ( state_ikr > 0 )
            {
                var_589c119009395654 = weights[ 1 ];
                var_c163dadce0c817fd = state_ikr;
                wait 0.1;
                asm_ikfingeranim( "right" );
                continue;
            }
            
            if ( state_ikr < 0 )
            {
                var_589c119009395654 = weights[ 1 ];
                var_c163dadce0c817fd = state_ikr;
                asm_clearikfingeranim( "right" );
                continue;
            }
        }
        
        var_589c119009395654 = weights[ 1 ];
        var_c163dadce0c817fd = state_ikr;
        wait 0.05;
    }
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 0
// Checksum 0x0, Offset: 0xcd2
// Size: 0x1a
function asm_clearfingerposes()
{
    asm_clearikfingeranim( "left" );
    asm_clearikfingeranim( "right" );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0xcf4
// Size: 0x40
function asm_ikfingeranim( side )
{
    currentweapon = scripts\anim\utility::getaicurrentweapon();
    assert( isdefined( currentweapon ) );
    
    if ( isnullweapon( currentweapon ) )
    {
        asm_clearikfingeranim( side );
    }
    
    asm_playikfingeranim( side );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0xd3c
// Size: 0x20d
function asm_playikfingeranim( side )
{
    currentweapon = scripts\anim\utility::getaicurrentweapon();
    
    if ( isnullweapon( currentweapon ) )
    {
        return;
    }
    
    fingerstate = "ik_finger_pose_r";
    var_6bae40552fced7c0 = "ik_fingers_r";
    fingeralias = getweaponbasename( currentweapon );
    
    if ( side == "left" )
    {
        fingerstate = "ik_finger_pose_l";
        var_6bae40552fced7c0 = "ik_fingers_l";
        weaponattachments = getweaponattachments( currentweapon );
        
        if ( isdefined( weaponattachments ) )
        {
            foreach ( atch in weaponattachments )
            {
                attachprefix = getsubstr( atch, 0, 7 );
                
                if ( attachprefix == "ub_mike" )
                {
                    fingeralias = "iw9_ub_mike";
                }
                
                if ( attachprefix == "ub_golf" )
                {
                    fingeralias = "iw9_ub_golf";
                }
                
                if ( attachprefix == "gripang" )
                {
                    fingeralias = "iw9_gripang";
                }
                
                if ( attachprefix == "gripver" )
                {
                    fingeralias = "iw9_gripver";
                }
            }
        }
    }
    
    if ( !asm_hasstatesp( self.animsetname, fingerstate ) )
    {
        println( "<dev string:x6f>" + self.animsetname + "<dev string:x8a>" + fingerstate );
        return;
    }
    
    if ( !isdefined( fingeralias ) || !asm_hasalias( fingerstate, fingeralias ) )
    {
        if ( !isdefined( fingeralias ) )
        {
            fingeralias = "UNDEFINED";
        }
        
        println( "<dev string:xa0>" + fingerstate + "<dev string:xd3>" + fingeralias + "<dev string:xdb>" + getcompleteweaponname( currentweapon ) );
        return;
    }
    
    fingeranim = asm_getxanim( fingerstate, asm_lookupanimfromalias( fingerstate, fingeralias ) );
    fingerknob = asm_getxanim( "knobs", asm_lookupanimfromalias( "knobs", var_6bae40552fced7c0 ) );
    self setanim( fingerknob, 1, 0.3, 1 );
    self setanim( fingeranim, 1, 0.3, 1 );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0xf51
// Size: 0x90
function asm_clearikfingeranim( side )
{
    var_6bae40552fced7c0 = "ik_fingers_l";
    
    if ( side == "right" )
    {
        var_6bae40552fced7c0 = "ik_fingers_r";
    }
    
    if ( !asm_hasalias( "knobs", var_6bae40552fced7c0 ) )
    {
        println( "<dev string:x6f>" + self.animsetname + "<dev string:xe4>" + var_6bae40552fced7c0 );
        return;
    }
    
    fingerknob = asm_getxanim( "knobs", asm_lookupanimfromalias( "knobs", var_6bae40552fced7c0 ) );
    self clearanim( fingerknob, 0.3, 1 );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0xfe9
// Size: 0xd2
function asm_playvisorraise( suffix )
{
    if ( isdefined( suffix ) )
    {
        isinstant = 1;
    }
    else
    {
        isinstant = 0;
        suffix = "";
    }
    
    asm_trynvgmodelswap();
    asm_clearvisoranim();
    var_511bb1509d434d3c = asm_getxanim( "visor", asm_lookupanimfromalias( "visor", "helmet_visor_up" + suffix ) );
    
    if ( self.visor_down == 0 )
    {
        if ( isinstant )
        {
            return;
        }
        else
        {
            self setanim( var_511bb1509d434d3c, 1, 0, 1 );
        }
        
        return;
    }
    
    var_fb5efc5c62f489 = asm_getxanim( "visor", asm_lookupanimfromalias( "visor", "helmet_visor_down" + suffix ) );
    self setanim( var_fb5efc5c62f489, 1, 0, 1 );
    
    if ( !isinstant )
    {
        wait getanimlength( var_fb5efc5c62f489 ) - 0.1;
    }
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 0
// Checksum 0x0, Offset: 0x10c3
// Size: 0x152
function asm_trynvgmodelswap()
{
    if ( !isdefined( self.nvgmodel_on ) )
    {
        return;
    }
    
    currmodel = self.headmodel;
    
    if ( isdefined( self.hatmodel ) )
    {
        currmodel = self.hatmodel;
    }
    
    if ( self.visor_down == 0 && currmodel == self.nvgmodel_on )
    {
        if ( isdefined( self.hatmodel ) )
        {
            self detach( self.hatmodel );
            self.hatmodel = self.nvgmodel_off;
            self attach( self.hatmodel );
        }
        else
        {
            self detach( self.headmodel );
            self.headmodel = self.nvgmodel_off;
            self attach( self.headmodel );
        }
        
        return;
    }
    
    if ( currmodel == self.nvgmodel_off )
    {
        if ( isdefined( self.hatmodel ) )
        {
            self detach( self.hatmodel );
            self.hatmodel = self.nvgmodel_on;
            self attach( self.hatmodel );
            return;
        }
        
        self detach( self.headmodel );
        self.headmodel = self.nvgmodel_on;
        self attach( self.headmodel );
    }
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 0
// Checksum 0x0, Offset: 0x121d
// Size: 0x79
function asm_clearvisoranim()
{
    asm_trynvgmodelswap();
    visorknob = undefined;
    visorid = asm_lookupanimfromaliasifexists( "knobs", "visor" );
    
    if ( isdefined( visorid ) )
    {
        visorknob = asm_getxanim( "knobs", visorid );
    }
    else
    {
        visorid = function_c1bf21c5e8625ea( "knobs", "visor" );
        
        if ( isdefined( visorid ) )
        {
            visorknob = function_6aa159fc2f693af7( "knobs", visorid );
        }
    }
    
    if ( isdefined( visorknob ) )
    {
        self clearanim( visorknob, 0 );
    }
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 2
// Checksum 0x0, Offset: 0x129e
// Size: 0x39
function asm_hasstatesp( archetype, statename )
{
    if ( archetypeassetloaded( archetype ) )
    {
        return archetypehasstate( archetype, statename );
    }
    
    assertmsg( "ASM_HasStateSP did not find an animarchetype asset for " + archetype );
    return 0;
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 3
// Checksum 0x0, Offset: 0x12df
// Size: 0xdf
function asm_playadditiveanimloopstate_sp( asmname, statename, params )
{
    self endon( statename + "_finished" );
    prevanim = asm_getbodyknob();
    blimited = 0;
    blendtime = 0.2;
    
    while ( true )
    {
        animname = asm_getxanim( statename, asm_getanim( asmname, statename ) );
        
        if ( prevanim != animname )
        {
            if ( blimited )
            {
                self setflaggedanimknoblimitedrestart( statename, animname, 1, blendtime, 1 );
            }
            else
            {
                self setflaggedanimknobrestart( statename, animname, 1, blendtime, 1 );
            }
            
            prevanim = animname;
        }
        
        thread asm_playadditiveanimloopstate_helper( statename, animname, blimited );
        asm_playfacialanim( asmname, statename, animname );
        asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
        self notify( statename + "additive_cancel" );
    }
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 3
// Checksum 0x0, Offset: 0x13c6
// Size: 0x6a
function asm_playadditiveanimloopstate_helper( statename, additiveanim, blimited )
{
    self endon( statename + "_finished" );
    self endon( statename + "additive_cancel" );
    
    while ( isdefined( additiveanim ) )
    {
        wait 0.2;
        
        if ( blimited )
        {
            self setflaggedanimlimited( statename, additiveanim, 1, 0, 1 );
            continue;
        }
        
        self setflaggedanim( statename, additiveanim, 1, 0, 1 );
    }
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0x1438
// Size: 0x10b
function asm_setaimlimits( limits )
{
    if ( isdefined( limits[ "left" ] ) )
    {
        self.leftaimlimit = limits[ "left" ];
    }
    else if ( actor_is3d() )
    {
        self.leftaimlimit = 56;
    }
    else
    {
        self.leftaimlimit = 45;
    }
    
    if ( isdefined( limits[ "right" ] ) )
    {
        self.rightaimlimit = limits[ "right" ];
    }
    else if ( actor_is3d() )
    {
        self.rightaimlimit = -56;
    }
    else
    {
        self.rightaimlimit = -45;
    }
    
    if ( isdefined( limits[ "up" ] ) )
    {
        self.upaimlimit = limits[ "up" ];
    }
    else if ( actor_is3d() )
    {
        self.upaimlimit = -89;
    }
    else
    {
        self.upaimlimit = -89;
    }
    
    if ( isdefined( limits[ "down" ] ) )
    {
        self.downaimlimit = limits[ "down" ];
        return;
    }
    
    if ( actor_is3d() )
    {
        self.downaimlimit = 65;
        return;
    }
    
    self.downaimlimit = 45;
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 2
// Checksum 0x0, Offset: 0x154b
// Size: 0x4c
function asm_getaimlimitset( asmname, statename )
{
    if ( !isdefined( level.aimlimitstatemappings[ asmname ] ) )
    {
        return "default";
    }
    
    if ( !isdefined( level.aimlimitstatemappings[ asmname ][ statename ] ) )
    {
        return "default";
    }
    
    return level.aimlimitstatemappings[ asmname ][ statename ];
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 2
// Checksum 0x0, Offset: 0x15a0
// Size: 0x10f
function asm_setstateaimlimits( asmname, statename )
{
    if ( isdefined( self.ignoreaimsets ) && self.ignoreaimsets )
    {
        return;
    }
    
    aimlimitset = asm_getaimlimitset( asmname, statename );
    
    /#
        if ( getdvarint( @"hash_763dbbbe8c504d96", 0 ) == 1 )
        {
            print3d( self.origin + ( -32, 0, 56 ), aimlimitset, ( 0, 1, 0 ), 1, 1, 20 );
        }
    #/
    
    if ( !isdefined( level.combataimlimits[ asmname ] ) )
    {
        asm_setaimlimits( [] );
        return;
    }
    
    isfrantic = asm_isfrantic();
    
    if ( isfrantic && isdefined( level.franticaimlimits[ asmname ][ aimlimitset ] ) )
    {
        asm_setaimlimits( level.franticaimlimits[ asmname ][ aimlimitset ] );
        return;
    }
    else if ( isdefined( level.combataimlimits[ asmname ][ aimlimitset ] ) )
    {
        asm_setaimlimits( level.combataimlimits[ asmname ][ aimlimitset ] );
        return;
    }
    
    asm_setaimlimits( [] );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 4
// Checksum 0x0, Offset: 0x16b7
// Size: 0x38f
function asm_setupaim_sp( asmname, statename, blendtime, use_5 )
{
    if ( self asmcurrentstatehasaimset( asmname ) )
    {
        return;
    }
    
    if ( istrue( self.runngun ) )
    {
        return;
    }
    
    weapclass = weaponclass( self.weapon );
    
    if ( weapclass == "none" )
    {
        return;
    }
    
    if ( asm_hasalias( statename, "aim_1" ) )
    {
        return;
    }
    
    if ( !asm_hasalias( statename, weapclass + "_aim_8" ) )
    {
        weapclass = "rifle";
        assertex( asm_hasalias( statename, weapclass + "_aim_8" ) || asm_hasalias( statename, "aim_1" ), "State " + statename + " doesn't have default (rifle) aim anims" );
    }
    
    asm_setstateaimlimits( asmname, statename );
    bfrantic = asm_isfrantic();
    arcname = self.animsetname;
    aim_5 = undefined;
    
    if ( !isdefined( use_5 ) || use_5 )
    {
        var_8bcb3d9d7aaa7510 = weapclass + "_aim_5";
        var_340d6c7e85ce51a6 = asm_lookupanimfromaliasifexists( statename, var_8bcb3d9d7aaa7510 );
        
        if ( isdefined( var_340d6c7e85ce51a6 ) )
        {
            aim_5 = asm_getxanim( statename, var_340d6c7e85ce51a6 );
        }
    }
    
    self setanimknoblimited( asm_getxanim( statename, archetypegetrandomalias( arcname, statename, weapclass + "_aim_8", bfrantic ) ), 1, blendtime );
    self setanimknoblimited( asm_getxanim( statename, archetypegetrandomalias( arcname, statename, weapclass + "_aim_2", bfrantic ) ), 1, blendtime );
    self setanimknoblimited( asm_getxanim( statename, archetypegetrandomalias( arcname, statename, weapclass + "_aim_4", bfrantic ) ), 1, blendtime );
    self setanimknoblimited( asm_getxanim( statename, archetypegetrandomalias( arcname, statename, weapclass + "_aim_6", bfrantic ) ), 1, blendtime );
    
    if ( isdefined( aim_5 ) )
    {
        self setanimlimited( aim_5, 1, blendtime );
    }
    
    aim_root = asm_lookupanimfromaliasifexists( statename, "aim_root" );
    
    if ( isdefined( aim_root ) )
    {
        self setanim( asm_getxanim( statename, aim_root ), 1, blendtime );
    }
    else
    {
        aim_root = asm_lookupanimfromaliasifexists( "knobs", "aim_root" );
        
        if ( isdefined( aim_root ) )
        {
            self setanim( asm_getxanim( "knobs", aim_root ), 1, blendtime );
        }
    }
    
    var_c09a8195928cd961 = asm_hasalias( statename, "aim_knob_2" );
    
    if ( var_c09a8195928cd961 )
    {
        self notify( "StopCleanupAimKnobs" );
        self.asm.track.aim_2 = asm_getxanim( statename, archetypegetrandomalias( arcname, statename, "aim_knob_2", bfrantic ) );
        self.asm.track.aim_4 = asm_getxanim( statename, archetypegetrandomalias( arcname, statename, "aim_knob_4", bfrantic ) );
        self.asm.track.aim_6 = asm_getxanim( statename, archetypegetrandomalias( arcname, statename, "aim_knob_6", bfrantic ) );
        self.asm.track.aim_8 = asm_getxanim( statename, archetypegetrandomalias( arcname, statename, "aim_knob_8", bfrantic ) );
        
        if ( isdefined( aim_5 ) )
        {
            self.asm.track.aim_5 = asm_getxanim( statename, archetypegetrandomalias( arcname, statename, "aim_knob_5", bfrantic ) );
        }
        
        thread asm_cleanupaimknobsonterminate( statename );
    }
    
    scripts\asm\track::trackloop_restoreaim();
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 2
// Checksum 0x0, Offset: 0x1a4e
// Size: 0x37
function asm_cleanupaimknobswithdelay( statename, delaytime )
{
    self endon( "death" );
    self endon( "StopCleanupAimKnobs" );
    waittill_any_timeout( delaytime, statename + "_finished" );
    asm_cleanupaimknobs();
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0x1a8d
// Size: 0x2a
function asm_cleanupaimknobsonterminate( statename )
{
    self endon( "death" );
    self endon( "StopCleanupAimKnobs" );
    self waittill( statename + "_finished" );
    asm_cleanupaimknobs();
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 0
// Checksum 0x0, Offset: 0x1abf
// Size: 0xab
function asm_cleanupaimknobs()
{
    if ( !isdefined( self.asm.track ) )
    {
        return;
    }
    
    self.asm.track.aim_2 = undefined;
    self.asm.track.aim_4 = undefined;
    self.asm.track.aim_6 = undefined;
    self.asm.track.aim_8 = undefined;
    self.asm.track.aim_5 = undefined;
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 7
// Checksum 0x0, Offset: 0x1b72
// Size: 0x5c
function asm_animscripted( notifyname, startpos, startangles, anime, vignettemode, rootanim, blendtime )
{
    asmname = self.asmname;
    self asmsetstate( asmname, "animscripted" );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 0
// Checksum 0x0, Offset: 0x1bd6
// Size: 0x9
function asm_stopanimscripted()
{
    self stopanimscripted();
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 2
// Checksum 0x0, Offset: 0x1be7
// Size: 0x64
function asm_animcustom( run_animscript, end_animscript )
{
    self leaveinteraction();
    scripts\asm\asm_bb::bb_setanimscripted();
    self.asm.animcustomender = end_animscript;
    self animcustom( run_animscript, &asm_animcustom_endanimscript );
    asmname = self.asmname;
    self asmsetstate( asmname, "animscripted" );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 0
// Checksum 0x0, Offset: 0x1c53
// Size: 0x4b
function asm_animcustom_endanimscript()
{
    scripts\asm\asm_bb::bb_clearanimscripted();
    
    if ( !isdefined( self.asm.animcustomender ) )
    {
        return;
    }
    
    self [[ self.asm.animcustomender ]]();
    self.asm.animcustomender = undefined;
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 0
// Checksum 0x0, Offset: 0x1ca6
// Size: 0xa
function asm_stopanimcustom()
{
    self notify( "killanimscript" );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 2
// Checksum 0x0, Offset: 0x1cb8
// Size: 0x2d
function open_door( door, t )
{
    if ( istrue( door.bashed ) )
    {
        return;
    }
    
    door scripts\sp\utility::door_force_open_fully( self, t );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0x1ced
// Size: 0xb6, Type: bool
function door_needs_to_close( door )
{
    if ( !istrue( door.ajar ) )
    {
        return false;
    }
    
    doornormal = anglestoleft( door.true_start_angles );
    doorangles = door scripts\sp\door::get_door_angles();
    
    if ( angleclamp180( doorangles[ 1 ] - door.true_start_angles[ 1 ] ) < 0 )
    {
        doornormal = -1 * doornormal;
    }
    
    doorcenter = door scripts\sp\door_internal::get_door_bottom_center();
    doortome = self.origin - doorcenter;
    doordir = anglestoforward( doorangles );
    return vectordot( doornormal, doordir ) * vectordot( doornormal, doortome ) > 0;
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0x1dac
// Size: 0x2a
function close_door( door )
{
    self endon( "opening_door" );
    door scripts\sp\door::door_close( self, 0.5, 0.1, 0.4 );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0x1dde
// Size: 0x12
function get_door_center( door )
{
    return door scripts\sp\door_internal::get_door_bottom_center();
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 1
// Checksum 0x0, Offset: 0x1df9
// Size: 0x2d, Type: bool
function is_door_already_open( door )
{
    if ( istrue( door.open_completely ) )
    {
        return true;
    }
    
    if ( door scripts\sp\door_internal::door_is_open_at_least( 60 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 4
// Checksum 0x0, Offset: 0x1e2f
// Size: 0x61
function animatedprop_setup( propname, var, origin, angles )
{
    self.animated_prop = scripts\engine\sp\utility::spawn_anim_model( propname, origin, angles );
    chairanim = level.scr_anim[ propname ][ var ];
    self.animated_prop setanimrestart( chairanim, 1, 0, 0 );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 2
// Checksum 0x0, Offset: 0x1e98
// Size: 0x7a
function animatedprop_startanim( propname, params )
{
    assert( isdefined( self.animated_prop ) );
    assert( isdefined( params ) );
    propanim = level.scr_anim[ propname ][ params ];
    assertex( self.animated_prop getanimweight( propanim ) > 0, "this should have been setup in the the guy's playanim" );
    self.animated_prop setanimrate( propanim, 1 );
}

// Namespace asm_sp / scripts\asm\asm_sp
// Params 2
// Checksum 0x0, Offset: 0x1f1a
// Size: 0x62
function animatedprop_setanim( propname, params )
{
    assert( isdefined( self.animated_prop ) );
    assert( isdefined( params ) );
    propanim = level.scr_anim[ propname ][ params ];
    self.animated_prop setanimknob( propanim, 1, 0.2, 1 );
}

/#

    // Namespace asm_sp / scripts\asm\asm_sp
    // Params 3
    // Checksum 0x0, Offset: 0x1f84
    // Size: 0x2b, Type: dev
    function function_5447ca96356f681b( asmname, statename, params )
    {
        asm_animcustom( &function_716870ebd1589f87, undefined );
    }

    // Namespace asm_sp / scripts\asm\asm_sp
    // Params 0
    // Checksum 0x0, Offset: 0x1fb7
    // Size: 0x97, Type: dev
    function function_716870ebd1589f87()
    {
        self endon( "<dev string:xfa>" );
        self endon( "<dev string:x100>" );
        shootparams = spawnstruct();
        self.shootposoverride = level.player.origin;
        self bb_newshootparams( level.player.origin, undefined, 0 );
        bb_claimshootparams( 0 );
        
        while ( true )
        {
            myshootpos = level.player.origin;
            bb_updateshootparams_pos( myshootpos );
            wait 0.05;
        }
    }

    // Namespace asm_sp / scripts\asm\asm_sp
    // Params 2
    // Checksum 0x0, Offset: 0x2056
    // Size: 0x23d, Type: dev
    function function_211ce02c705f8c0c( asmname, archetypename )
    {
        allstates = asmdevgetallstates( asmname );
        
        foreach ( statename in allstates )
        {
            var_3e95892f99a9b61c = 0;
            aliases = archetypegetaliases( archetypename, statename );
            
            if ( isdefined( aliases ) )
            {
                foreach ( alias in aliases )
                {
                    anims = animsetgetallanimindicesforalias( archetypename, statename, alias );
                    
                    foreach ( animidx in anims )
                    {
                        xanim = asm_getxanim( statename, animidx );
                        
                        if ( !animhasnotetrack( xanim, "<dev string:x115>" ) )
                        {
                            continue;
                        }
                        
                        if ( !animhasnotetrack( xanim, "<dev string:x11c>" ) )
                        {
                            errormsg = "<dev string:x122>" + archetypename + "<dev string:x152>" + statename + "<dev string:x15c>" + alias + "<dev string:x166>" + xanim + "<dev string:x16f>";
                            assertmsg( errormsg );
                            continue;
                        }
                        
                        ontimes = getnotetracktimes( xanim, "<dev string:x11c>" );
                        offtimes = getnotetracktimes( xanim, "<dev string:x115>" );
                        lastontime = 0;
                        lastofftime = -1;
                        
                        if ( ontimes.size > 0 )
                        {
                            lastontime = ontimes[ ontimes.size - 1 ];
                        }
                        
                        if ( offtimes.size > 0 )
                        {
                            lastofftime = offtimes[ offtimes.size - 1 ];
                        }
                        
                        if ( lastofftime >= lastontime )
                        {
                            errormsg = "<dev string:x171>" + archetypename + "<dev string:x152>" + statename + "<dev string:x15c>" + alias + "<dev string:x166>" + xanim + "<dev string:x16f>";
                            assertmsg( errormsg );
                        }
                    }
                }
            }
        }
    }

#/
