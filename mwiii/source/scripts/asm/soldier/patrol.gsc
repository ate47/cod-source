#using scripts\aitypes\stealth;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\patrol;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace patrol;

// Namespace patrol / scripts\asm\soldier\patrol
// Params 0
// Checksum 0x0, Offset: 0x22f
// Size: 0x25
function function_3aba5f22b60d37f5()
{
    scripts\aitypes\stealth::initstealthfunctions();
    self.var_5221cb0637cd44e7 = &scripts\asm\soldier\patrol::attachflashlight;
    self.fnstealthflashlightdetach = &scripts\asm\soldier\patrol::detachflashlight;
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 3
// Checksum 0x0, Offset: 0x25c
// Size: 0x18f
function playanim_patrolreact_internal( asmname, statename, arcstatename )
{
    assert( isdefined( self.stealth ) );
    self.var_de7ab32958c52392 = self.var_fd01ad49b4e38ae8;
    
    if ( shouldpatrolreactaim() )
    {
        if ( isdefined( self.var_1c9ed4a46d13edc9 ) && distance2dsquared( self.origin, self.var_1c9ed4a46d13edc9 ) > 1024 )
        {
            self setlookat( self.var_1c9ed4a46d13edc9 );
        }
    }
    
    reactanim = self asmgetanim( asmname, statename );
    assert( isdefined( reactanim ) );
    reactxanim = asm_getxanim( arcstatename, reactanim );
    animrate = 1;
    
    if ( isdefined( self.stealthreactendtime ) )
    {
        endtime = 1;
        codemovetimes = getnotetracktimes( reactxanim, "code_move" );
        
        if ( codemovetimes.size > 0 )
        {
            endtime = codemovetimes[ 0 ];
        }
        
        animlength = getanimlength( reactxanim ) * endtime;
        desiredlength = 0.05 + ( self.stealthreactendtime - gettime() ) / 1000;
        
        if ( desiredlength < 0.2 )
        {
            desiredlength = 0.2;
        }
        
        animrate = clamp( animlength / desiredlength, 0.8, 1.3 );
        self.stealthreactendtime = undefined;
    }
    
    self aisetanim( arcstatename, reactanim, animrate );
    self function_df303d9c05757e6b( reactanim, arcstatename );
    asm_donotetrackswithinterceptor( asmname, statename, &flashlightreactionnotehandler, undefined, arcstatename );
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 4
// Checksum 0x0, Offset: 0x3f3
// Size: 0x45, Type: bool
function shouldpatrolreactaim( asmname, statename, tostatename, params )
{
    assert( isdefined( self.var_fd01ad49b4e38ae8 ) );
    return self.var_fd01ad49b4e38ae8 == "med";
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 3
// Checksum 0x0, Offset: 0x441
// Size: 0x5f
function chooseanim_patrolreactlookaround( asmname, statename, params )
{
    alias = "curious";
    
    if ( self function_129cbb4366307f50( "med" ) || self [[ self.fnisinstealthcombat ]]() )
    {
        alias = "threat";
    }
    
    return asm_lookupanimfromalias( statename, string( alias ) );
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 3
// Checksum 0x0, Offset: 0x4a9
// Size: 0x63
function chooseanim_patrolreactlookaround_checkflashlight( asmname, statename, params )
{
    alias = string( getpatrolreactdirindex() );
    
    if ( self function_129cbb4366307f50( "med" ) || self [[ self.fnisinstealthcombat ]]() )
    {
        alias = "threat_" + alias;
    }
    
    return chooseanim_patrol_checkflashlight( asmname, statename, alias );
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 0
// Checksum 0x0, Offset: 0x515
// Size: 0x72
function getpatrolreactdirindex()
{
    reactyaw = 0;
    
    if ( isdefined( self.var_1c9ed4a46d13edc9 ) )
    {
        delta = self.var_1c9ed4a46d13edc9 - self.origin;
        
        if ( length2dsquared( delta ) < 36 )
        {
            reactyaw = 0;
        }
        else
        {
            deltayaw = vectortoyaw( delta );
            reactyaw = self.angles[ 1 ] - deltayaw;
        }
    }
    
    return getreactangleindex( reactyaw );
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 0
// Checksum 0x0, Offset: 0x590
// Size: 0xb7
function function_a23a26adcf97fdd0()
{
    reactyaw = 0;
    
    if ( isdefined( self.var_1c9ed4a46d13edc9 ) )
    {
        delta = self.var_1c9ed4a46d13edc9 - self.origin;
        deltayaw = vectortoyaw( delta );
        reactyaw = self.angles[ 1 ] - deltayaw;
    }
    
    reactyaw = angleclamp180( reactyaw );
    directionindex = function_de2aa7eb339a432c( reactyaw );
    suffix = string( directionindex );
    
    if ( reactyaw < -120 && reactyaw > -180 )
    {
        suffix += "l";
    }
    else if ( reactyaw > 120 && reactyaw < 180 )
    {
        suffix += "r";
    }
    
    return suffix;
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 0
// Checksum 0x0, Offset: 0x650
// Size: 0x65
function getpatrolreactalias()
{
    assert( isdefined( self.var_fd01ad49b4e38ae8 ) );
    suffix = function_a23a26adcf97fdd0();
    
    if ( self.var_ee027a8f98390896 )
    {
        alias = self.var_fd01ad49b4e38ae8 + "_close_" + suffix;
    }
    else
    {
        alias = self.var_fd01ad49b4e38ae8 + "_" + suffix;
    }
    
    return alias;
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 3
// Checksum 0x0, Offset: 0x6be
// Size: 0x71
function chooseanim_patrolreact( asmname, statename, params )
{
    alias = getpatrolreactalias();
    animindex = asm_lookupanimfromalias( statename, alias );
    
    if ( !isdefined( animindex ) )
    {
        if ( asm_hasalias( statename, "med_8" ) )
        {
            return asm_lookupanimfromalias( statename, "med_8" );
        }
        else
        {
            return asm_lookupanimfromalias( statename, "small_8" );
        }
    }
    
    return animindex;
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 3
// Checksum 0x0, Offset: 0x738
// Size: 0x36
function chooseanim_patrolreact_checkflashlight( asmname, statename, params )
{
    alias = getpatrolreactalias();
    return chooseanim_patrol_checkflashlight( asmname, statename, alias );
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 1
// Checksum 0x0, Offset: 0x777
// Size: 0x54
function getreactangleindex( angle )
{
    angle = angleclamp180( angle );
    
    if ( angle > 135 || angle < -135 )
    {
        index = 2;
    }
    else if ( angle < -45 )
    {
        index = 4;
    }
    else if ( angle > 45 )
    {
        index = 6;
    }
    else
    {
        index = 8;
    }
    
    return index;
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 1
// Checksum 0x0, Offset: 0x7d4
// Size: 0x54
function function_de2aa7eb339a432c( angle )
{
    angle = angleclamp180( angle );
    
    if ( angle > 120 || angle < -120 )
    {
        index = 2;
    }
    else if ( angle < -30 )
    {
        index = 4;
    }
    else if ( angle > 30 )
    {
        index = 6;
    }
    else
    {
        index = 8;
    }
    
    return index;
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 4
// Checksum 0x0, Offset: 0x831
// Size: 0x89
function function_7889a8a760c6e02( turnanim, desiredyaw, beyondyaw, endtime )
{
    currentanimtime = self aigetanimtime( turnanim );
    assert( currentanimtime < endtime );
    animyaw = getangledelta( turnanim, currentanimtime, endtime ) + beyondyaw;
    totalyaw = self.angles[ 1 ] + animyaw;
    turnyaw = angleclamp180( desiredyaw - angleclamp( totalyaw ) );
    return turnyaw;
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 3
// Checksum 0x0, Offset: 0x8c3
// Size: 0x202, Type: bool
function handlefacegoalnotetrack( statename, note, params )
{
    if ( note == "face_goal" && isdefined( self.var_1c9ed4a46d13edc9 ) )
    {
        xanim = asm_getxanim( self.var_39798b565de83c7b, self.var_d1a6890d054957e7 );
        
        if ( !isdefined( xanim ) )
        {
            return false;
        }
        
        finishtime = getnotetracktimes( xanim, "finish" );
        
        if ( finishtime.size == 0 )
        {
            finishtime[ 0 ] = 1;
        }
        
        var_3611c8e9f9a8d539 = getnotetracktimes( xanim, "combat_early_out" );
        var_53c95344c2ab768f = 1;
        
        if ( var_3611c8e9f9a8d539.size == 0 || !self [[ self.fnisinstealthcombat ]]() )
        {
            var_53c95344c2ab768f = 0;
            var_3611c8e9f9a8d539[ 0 ] = 1;
        }
        
        endtime = getnotetracktimes( xanim, "face_goal_end" );
        
        if ( endtime.size == 0 )
        {
            endtime[ 0 ] = finishtime[ 0 ];
        }
        
        if ( var_3611c8e9f9a8d539[ 0 ] < endtime[ 0 ] )
        {
            endtime[ 0 ] = var_3611c8e9f9a8d539[ 0 ];
        }
        
        [ animtime ] = getnotetracktimes( xanim, "face_goal" );
        animrate = self getanimrate( xanim );
        assert( animrate != 0 );
        
        if ( animrate == 0 )
        {
            animrate = 1;
        }
        
        anim_length = getanimlength( xanim ) / animrate;
        turntime = endtime[ 0 ] - animtime;
        turntime *= anim_length;
        beyondyaw = 0;
        
        if ( !var_53c95344c2ab768f && endtime[ 0 ] < finishtime[ 0 ] )
        {
            beyondyaw = getangledelta( xanim, endtime[ 0 ], finishtime[ 0 ] );
        }
        
        metopos = self.var_1c9ed4a46d13edc9 - self.origin;
        reactworldyaw = vectortoyaw( metopos );
        turnyaw = function_7889a8a760c6e02( xanim, reactworldyaw, beyondyaw, endtime[ 0 ] );
        thread facegoalthread( statename, turnyaw, beyondyaw, self.var_1c9ed4a46d13edc9, reactworldyaw, turntime, xanim, endtime[ 0 ] );
        return true;
    }
    
    return false;
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 8
// Checksum 0x0, Offset: 0xace
// Size: 0x293
function facegoalthread( statename, turnyaw, beyondyaw, reactpos, reactworldyaw, turntime, turnanim, endtime )
{
    self notify( "FaceGoalThread" );
    self endon( "FaceGoalThread" );
    self endon( "death" );
    self endon( statename + "_finished" );
    frames = ceil( turntime * 1000 / level.frameduration );
    var_d00ab4a1a5f59a50 = turnyaw / frames;
    var_72c012a18c9e68f9 = undefined;
    stopyaw = 0;
    
    while ( frames > 0 )
    {
        overrideent = self.enemy;
        
        if ( !isdefined( overrideent ) )
        {
            if ( isdefined( self.var_33107dcb50df3cde ) && isplayer( self.var_33107dcb50df3cde ) )
            {
                overrideent = self.var_33107dcb50df3cde;
            }
        }
        
        bcansee = 0;
        
        if ( isdefined( overrideent ) && issentient( overrideent ) )
        {
            lkp = self lastknownpos( overrideent );
            lktime = self lastknowntime( overrideent );
            
            if ( !bcansee )
            {
                bcansee = self cansee( overrideent );
            }
            
            var_522f11c665d62df = 0;
            
            if ( bcansee )
            {
                if ( distancesquared( self.var_1c9ed4a46d13edc9, overrideent.origin ) >= 225 )
                {
                    self.var_1c9ed4a46d13edc9 = overrideent.origin;
                    var_522f11c665d62df = 1;
                }
            }
            else if ( !bcansee )
            {
                if ( isdefined( lkp ) && lktime > 0 )
                {
                    self.var_1c9ed4a46d13edc9 = lkp;
                    var_522f11c665d62df = 1;
                }
            }
            
            if ( var_522f11c665d62df )
            {
                metopos = self.var_1c9ed4a46d13edc9 - self.origin;
                newreactworldyaw = vectortoyaw( metopos );
                turnyaw = angleclamp180( newreactworldyaw - reactworldyaw - beyondyaw );
                reactworldyaw = newreactworldyaw;
                var_d00ab4a1a5f59a50 += turnyaw / frames;
            }
        }
        
        self orientmode( "face angle", angleclamp( self.angles[ 1 ] + var_d00ab4a1a5f59a50 ) );
        frames -= 1;
        
        if ( frames < 1 )
        {
            if ( isdefined( overrideent ) )
            {
                if ( absangleclamp180( self.angles[ 1 ] - reactworldyaw ) <= 10 )
                {
                    if ( !self [[ self.fnisinstealthcombat ]]() && isplayer( overrideent ) && bcansee )
                    {
                        self aieventlistenerevent( "sight", overrideent, overrideent.origin );
                    }
                }
                else
                {
                    self glanceatpos( self.var_1c9ed4a46d13edc9 );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 3
// Checksum 0x0, Offset: 0xd69
// Size: 0x43
function patrol_playanim_idlecurious( asmname, statename, params )
{
    thread patrol_playanim_idlecurious_facelastknownhelper( statename, self.stealthidlecurioustarget );
    addbattlechatternotify( self, undefined, "curious" );
    asm_playanimstate( asmname, statename );
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 2
// Checksum 0x0, Offset: 0xdb4
// Size: 0x69
function patrol_playanim_idlecurious_facelastknownhelper( statename, target )
{
    self endon( statename + "_finished" );
    
    while ( isdefined( target ) && isalive( target ) )
    {
        lastknown = self lastknownpos( target );
        var_b1dae7cae8885fb1 = lastknown - self.origin;
        self orientmode( "face angle", vectortoyaw( var_b1dae7cae8885fb1 ) );
        waitframe();
    }
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 3
// Checksum 0x0, Offset: 0xe25
// Size: 0x6e
function patrol_magicflashlightdetach( asmname, statename, params )
{
    if ( isdefined( self.asmflashlight ) && self.asmflashlight )
    {
        detachflashlight();
    }
    
    if ( istrue( self._blackboard.bflashlight ) && !istrue( self.asmflashlight ) )
    {
        self [[ self.fnstealthflashlighton ]]();
    }
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 3
// Checksum 0x0, Offset: 0xe9b
// Size: 0x3f
function patrol_magicflashlighton( asmname, statename, params )
{
    if ( istrue( self._blackboard.bflashlight ) )
    {
        self [[ self.fnstealthflashlighton ]]();
    }
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 3
// Checksum 0x0, Offset: 0xee2
// Size: 0x5e
function chooseanim_patrol_checkflashlight( asmname, statename, params )
{
    assert( isdefined( params ) );
    alias = params;
    
    if ( isdefined( self.asmflashlight ) && self.asmflashlight )
    {
        alias = "fl_" + alias;
    }
    
    return asm_lookupanimfromalias( statename, alias );
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 1
// Checksum 0x0, Offset: 0xf49
// Size: 0xd6
function flashlightnotehandler( note )
{
    if ( note == "attach" )
    {
        var_343b33980a5007b1 = self function_76d6356c94f30473();
        attachflashlight( var_343b33980a5007b1 );
        return;
    }
    
    if ( note == "detach" )
    {
        assert( isdefined( self.fnstealthflashlighton ) );
        detachflashlight();
        
        if ( asm_getdemeanor() != "patrol" && isdefined( self._blackboard.bflashlight ) && self._blackboard.bflashlight )
        {
            self [[ self.fnstealthflashlighton ]]();
        }
        
        return;
    }
    
    if ( note == "flashlight_on" )
    {
        self [[ self.fnstealthflashlighton ]]();
        return;
    }
    
    if ( note == "flashlight_off" )
    {
        self [[ self.fnstealthflashlightoff ]]( 0 );
    }
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 1
// Checksum 0x0, Offset: 0x1027
// Size: 0x45
function setflashlightmodel( flashlightmodel )
{
    if ( isai( self ) )
    {
        detachflashlight();
    }
    
    self.flashlightmodeloverride = flashlightmodel;
    
    if ( isai( self ) && istrue( self.asmflashlight ) )
    {
        attachflashlight( 1 );
    }
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 0
// Checksum 0x0, Offset: 0x1074
// Size: 0x47
function getflashlightmodel()
{
    modelname = "attachment_wm_tac_light_held";
    
    if ( isdefined( self.flashlightmodeloverride ) )
    {
        modelname = self.flashlightmodeloverride;
    }
    else if ( isdefined( level.flashlightmodeloverride ) )
    {
        modelname = level.flashlightmodeloverride;
    }
    
    return modelname;
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 1
// Checksum 0x0, Offset: 0x10c4
// Size: 0xb2
function attachflashlight( var_4d65db1b45602939 )
{
    assert( isdefined( self.fnstealthflashlightoff ) && isdefined( self.fnstealthflashlighton ) );
    assert( !isdefined( self.asmflashlight ) || self.asmflashlight == 0 );
    self [[ self.fnstealthflashlightoff ]]( 0 );
    modelname = getflashlightmodel();
    self attach( modelname, "tag_accessory_left", 1 );
    self.flashlightmodel = modelname;
    self.asmflashlight = 1;
    self.flashlightfxoverridetag = "tag_light";
    
    if ( var_4d65db1b45602939 )
    {
        self [[ self.fnstealthflashlighton ]]();
    }
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 0
// Checksum 0x0, Offset: 0x117e
// Size: 0x71
function detachflashlight()
{
    assert( isdefined( self.fnstealthflashlightoff ) );
    
    if ( !istrue( self.asmflashlight ) )
    {
        return;
    }
    
    self [[ self.fnstealthflashlightoff ]]( 0 );
    
    if ( isdefined( self.flashlightmodel ) )
    {
        self detach( self.flashlightmodel, "tag_accessory_left" );
        self.flashlightmodel = undefined;
    }
    
    self.asmflashlight = 0;
    self.flashlightfxoverridetag = undefined;
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 3
// Checksum 0x0, Offset: 0x11f7
// Size: 0x2c, Type: bool
function flashlightreactionnotehandler( statename, note, params )
{
    flashlightnotehandler( note );
    return handlefacegoalnotetrack( statename, note, params );
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 3
// Checksum 0x0, Offset: 0x122c
// Size: 0x25, Type: bool
function function_2be03b6fc63e8c8b( asmname, statename, params )
{
    return istrue( level.var_da217073b223521a );
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 3
// Checksum 0x0, Offset: 0x125a
// Size: 0x5f
function function_70d280c57c0cfee9( asmname, statename, params )
{
    alias = "curious";
    
    if ( self function_129cbb4366307f50( "med" ) || self [[ self.fnisinstealthcombat ]]() )
    {
        alias = "threat";
    }
    
    return asm_lookupanimfromalias( statename, string( alias ) );
}

// Namespace patrol / scripts\asm\soldier\patrol
// Params 2
// Checksum 0x0, Offset: 0x12c2
// Size: 0x41
function bc_notehandler( note, params )
{
    if ( isstartstr( note, "bc_" ) )
    {
        event = getsubstr( note, 3 );
        
        /#
        #/
        
        addbattlechatternotify( self, undefined, event );
    }
}

