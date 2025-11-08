#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\cap;
#using scripts\engine\utility;

#namespace script_funcs;

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x37e
// Size: 0x1cc
function civilian_init( asmname, statename, params )
{
    if ( asmname == "civilian" )
    {
        msgpt1 = "Using an aitype with the old 'civilian.asm'. ";
        msgpt2 = "All civilians should be using 'civilian_react' now. ";
        msgpt3 = "AIType: '" + self.classname + "' Location: " + self.origin;
        assertmsg( msgpt1 + msgpt2 + msgpt3 );
    }
    
    if ( !isdefined( self.asm.customdata ) )
    {
        self.asm.customdata = spawnstruct();
    }
    
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.anglelerprate = 100;
    self.dontsyncmelee = 1;
    self.allowstrafe = 0;
    self.maystumble = 1;
    self.shouldstumble = 0;
    self.stumbledelay = 1000;
    self.stumblechance = 0.2;
    self.var_5dc982e3f3b58ba0 = 10000;
    self.var_8dc39eff3b814ee1 = 30000;
    thread function_f2343b622bbbac5c();
    
    if ( self.animsetname == "hadir_yth" )
    {
        self.pathsmoothmultiplier = 2;
    }
    
    initanimspeedthresholds_civilian( self.animsetname );
    initmaxspeedforpathlengthtable();
    
    if ( self isscriptable() )
    {
        thread initscriptable();
    }
    
    scripts\common\cap::init_cap();
    civilianfocusstartthread();
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x552
// Size: 0x27
function initscriptable()
{
    self endon( "death" );
    scripts\engine\utility::flag_wait( "scriptables_ready" );
    self setscriptablepartstate( "notetrack_handler", "active", 0 );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 1
// Checksum 0x0, Offset: 0x581
// Size: 0xfe
function initanimspeedthresholds_civilian( animsetname )
{
    thresholdlabel = self getbasearchetype();
    
    if ( !isdefined( thresholdlabel ) )
    {
        thresholdlabel = animsetname;
    }
    
    if ( animspeedthresholdsexist( thresholdlabel ) )
    {
        return;
    }
    
    if ( thresholdlabel == "farah_civilian" )
    {
        setspeedthreshold( thresholdlabel, "walk", 56 );
        setspeedthreshold( thresholdlabel, "fast", 105 );
        setspeedthreshold( thresholdlabel, "jog", 170 );
        setspeedthreshold( thresholdlabel, "run", 220 );
        setspeedthreshold( thresholdlabel, "sprint", 250 );
        return;
    }
    
    if ( thresholdlabel == "hadir_yth" )
    {
        setspeedthreshold( thresholdlabel, "walk", 40 );
        setspeedthreshold( thresholdlabel, "fast", 102 );
        setspeedthreshold( thresholdlabel, "jog", 103 );
        setspeedthreshold( thresholdlabel, "run", 163 );
        return;
    }
    
    setspeedthreshold( thresholdlabel, "walk", 52 );
    setspeedthreshold( thresholdlabel, "fast", 127 );
    setspeedthreshold( thresholdlabel, "jog", 153 );
    setspeedthreshold( thresholdlabel, "run", 220 );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x687
// Size: 0xa0
function chooseciviliantransitiontoidleanim( asmname, statename, params )
{
    if ( isdefined( self.asm.transtoidlealias ) )
    {
        randomalias = self.asm.transtoidlealias;
        
        if ( statename == "trans_out_stand_idle" )
        {
            self.asm.transtoidlealias = undefined;
        }
        
        return asm_lookupanimfromalias( statename, randomalias );
    }
    
    randomalias = asm_getrandomalias( statename );
    self.asm.transtoidlealias = randomalias;
    return asm_lookupanimfromalias( statename, randomalias );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x72f
// Size: 0x114
function choosecivilianreactidleanim( asmname, statename, params )
{
    if ( isdefined( self.asm.civilianreactionalias ) )
    {
        reactalias = self.asm.civilianreactionalias;
        
        if ( statename == "trans_out_combat_react" )
        {
            self.asm.civilianreactionalias = undefined;
        }
        
        return asm_lookupanimfromalias( statename, reactalias );
    }
    
    assertex( isdefined( self.asm.transtoidlealias ), "Anim alias does not exist." );
    currentalias = self.asm.transtoidlealias;
    
    if ( scripts\engine\utility::cointoss() )
    {
        alias = currentalias + "_a";
    }
    else
    {
        alias = currentalias + "_b";
    }
    
    assertex( asm_hasalias( statename, alias ), "Anim alias does not exist." );
    self.asm.civilianreactionalias = alias;
    return asm_lookupanimfromalias( statename, alias );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x84b
// Size: 0x6c
function civilian_playexposedloop( asmname, statename, params )
{
    self function_62004d7561fd321e();
    var_4fbb46e48f524506 = self asmgetstatetransitioningfrom( asmname );
    
    if ( isdefined( self.node ) )
    {
        self._blackboard.lastusednode = self.node;
    }
    
    function_fb56c9527636713f( asmname, statename, 1 );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x8bf
// Size: 0x3a
function civilian_exit_cleanup( asmname, statename, params )
{
    self._blackboard.var_9fbdce5fa10f8964 = 0;
    civilian_move_cleanup( asmname, statename, params );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x901
// Size: 0x2e
function civilian_playmoveloop( asmname, statename, params )
{
    thread civilian_watchspeed( statename );
    scripts\asm\shared\utility::playmoveloop( asmname, statename, params );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x937
// Size: 0xb4
function function_f2343b622bbbac5c()
{
    self endon( "death" );
    stumbletimer = gettime() + randomint( 1000 );
    
    while ( true )
    {
        waitframe();
        
        if ( !istrue( self.maystumble ) && !istrue( self.shouldstumble ) )
        {
            continue;
        }
        
        if ( !isdefined( self.pathgoalpos ) )
        {
            continue;
        }
        
        if ( gettime() < stumbletimer )
        {
            continue;
        }
        
        if ( randomfloat( 1 ) > self.stumblechance )
        {
            stumbletimer = gettime() + self.var_5dc982e3f3b58ba0;
            continue;
        }
        
        stumbletimer = gettime() + randomint( 1000 ) + self.var_8dc39eff3b814ee1;
        self.shouldstumble = 1;
    }
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x9f3
// Size: 0x7a
function civilian_stumblechooseanim( asmname, statename, params )
{
    archetype = self getbasearchetype();
    speed = length( self.velocity );
    alias = "stumble_jog";
    
    if ( speed > 153 )
    {
        alias = "stumble_sprint";
    }
    
    if ( speed > 220 )
    {
        alias = "stumble_run";
    }
    
    return asm_chooseanim( asmname, statename, alias );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0xa76
// Size: 0xe3
function civilian_playmoveloopblendspace( asmname, statename, param )
{
    self endon( statename + "_finished" );
    thread civilian_watchspeed( statename );
    self.requestarrivalnotify = 1;
    self.var_5185accfc2476d43 = 1;
    self.var_1f91d3da0786a2 = 0;
    blankindex = asm_lookupanimfromalias( statename, "blank" );
    self aisetanim( statename, blankindex );
    
    if ( istrue( param ) )
    {
        if ( isdefined( self._blackboard.var_610cb18ecc1af719 ) )
        {
            self._blackboard.civilianfocustargetentity = self._blackboard.var_610cb18ecc1af719;
            var_6c542b356d086308 = civilianfocuscomputeyawtotarget();
            var_6c542b356d086308 /= 180;
            civilianfocusupdateanimparameter( var_6c542b356d086308 );
        }
    }
    
    while ( true )
    {
        asm_donotetracks( asmname, statename );
    }
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 1
// Checksum 0x0, Offset: 0xb61
// Size: 0xc5
function civilian_watchspeed( statename )
{
    self endon( statename + "_finished" );
    
    if ( isdefined( self.stayahead ) && istrue( self.stayahead.active ) )
    {
        return;
    }
    
    if ( isdefined( self._blackboard.requestedspeed ) )
    {
        self aisetdesiredspeed( self._blackboard.requestedspeed );
    }
    
    while ( !isdefined( self.stayahead ) || !istrue( self.stayahead.active ) )
    {
        if ( self aigetdesiredspeed() > 153 && self pathdisttogoal() < 200 && !istrue( self.disablearrivals ) )
        {
            self aisetdesiredspeed( 153 );
        }
        
        waitframe();
    }
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0xc2e
// Size: 0x12d
function civilian_playsharpturnanim( asmname, statename, params )
{
    self endon( statename + "_finished" );
    turnanim = asm_getanim( asmname, statename );
    assert( isdefined( turnanim ) );
    turnxanim = asm_getxanim( statename, turnanim );
    self animmode( "zonly_physics", 0 );
    self orientmode( "face angle", self.angles[ 1 ] );
    turnrate = self.moveplaybackrate;
    asm_playfacialanim( asmname, statename, turnxanim );
    self aisetanim( statename, turnanim, turnrate );
    childthread function_f350cd100563acaf( turnxanim, turnrate );
    note = asm_donotetracks( asmname, statename, &function_acfe95f0c8655298, turnxanim, undefined, 0 );
    self motionwarpcancel();
    self orientmode( "face enemy or motion" );
    self animmode( "normal", 0 );
    
    if ( note == "code_move" )
    {
        self.requestarrivalnotify = 1;
        finishtimes = getnotetracktimes( turnxanim, "finish" );
        
        if ( finishtimes.size > 0 )
        {
            asm_donotetracks( asmname, statename );
        }
    }
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 2
// Checksum 0x0, Offset: 0xd63
// Size: 0xc8
function function_f350cd100563acaf( turnxanim, turnrate )
{
    waitframe();
    cornernotes = getnotetracktimes( turnxanim, "corner" );
    
    if ( cornernotes.size > 0 )
    {
        cornertime = cornernotes[ 0 ];
        animlength = getanimlength( turnxanim );
        curtime = level.frameduration / 1000 / animlength;
        animtrans = getmovedelta( turnxanim, curtime, cornertime );
        animrot = ( 0, getangledelta( turnxanim, curtime, cornertime ), 0 );
        animduration = animlength * cornertime / turnrate;
        
        if ( animduration > 0.05 )
        {
            self.useanimgoalweight = 1;
            self function_2664ab4a4ab7100c( animtrans, animrot, animduration );
        }
    }
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 2
// Checksum 0x0, Offset: 0xe33
// Size: 0x1b7
function function_acfe95f0c8655298( note, params )
{
    if ( note == "corner" )
    {
        self motionwarpcancel();
        
        if ( !isdefined( self.pathgoalpos ) )
        {
            return;
        }
        
        if ( self.lookaheaddist > 4 )
        {
            lookaheadangle = vectortoyaw( self.lookaheaddir );
        }
        else
        {
            return;
        }
        
        turnxanim = params;
        cornertimes = getnotetracktimes( turnxanim, "corner" );
        codemovetimes = getnotetracktimes( turnxanim, "code_move" );
        assert( cornertimes.size > 0 );
        endtime = 1;
        
        if ( codemovetimes.size > 0 )
        {
            endtime = codemovetimes[ 0 ];
        }
        
        duration = ( endtime - cornertimes[ 0 ] ) * getanimlength( turnxanim ) * 1000;
        
        if ( duration < level.frameduration )
        {
            return;
        }
        
        animdelta = getmovedelta( turnxanim, cornertimes[ 0 ], endtime );
        animrot = getangledelta( turnxanim, cornertimes[ 0 ], endtime );
        anglediff = angleclamp180( lookaheadangle - self.angles[ 1 ] - animrot );
        
        if ( abs( anglediff ) > 60 )
        {
            return;
        }
        
        idealstartangles = ( 0, lookaheadangle - animrot, 0 );
        targetpos = self.origin + rotatevector( animdelta, self.angles );
        targetpos = getclosestpointonnavmesh( targetpos, self, 0, 1 );
        idealstartpos = targetpos - rotatevector( animdelta, idealstartangles );
        self motionwarpwithanim( idealstartpos, idealstartangles, targetpos, ( 0, lookaheadangle, 0 ), int( duration ) );
    }
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0xff2
// Size: 0x22
function civilian_move_cleanup( asmname, statename, params )
{
    self motionwarpcancel();
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x101c
// Size: 0x29
function iswhizbydetected( asmname, statename, tostatename, params )
{
    return bb_iswhizbyrequested();
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x104e
// Size: 0x2d, Type: bool
function function_49eab317ab73356( asmname, statename, tostatename, params )
{
    return istrue( self.disableexits );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x1084
// Size: 0x89, Type: bool
function shoulddirectlytransition( asmname, statename, tostatename, params )
{
    if ( iswhizbydetected() || bb_getcivilianstate() == "combat" )
    {
        alias = self.asm.transtoidlealias;
        
        if ( alias == "civ02" || alias == "civ04" || alias == "civ06" || alias == "civ07" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x1116
// Size: 0x7f, Type: bool
function shouldcustomtransition( asmname, statename, tostatename, params )
{
    if ( bb_getcivilianstate() == "noncombat" )
    {
        alias = self.asm.transtoidlealias;
        
        if ( alias == "civ02" || alias == "civ04" || alias == "civ06" || alias == "civ07" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x119e
// Size: 0x2e
function cleanupcivilianreactionalias( asmname, statename, params )
{
    self.asm.civilianreactionalias = undefined;
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x11d4
// Size: 0x8b
function shouldsnaptocover( asmname, statename, tostatename, params )
{
    if ( bb_moverequested() )
    {
        return 0;
    }
    
    if ( !isatcovernode() )
    {
        return 0;
    }
    
    if ( !isdefined( self.node ) )
    {
        return 0;
    }
    
    if ( isdefined( self.primaryweapon ) && scripts\anim\utility_common::isusingsidearm() && weaponclass( self.primaryweapon ) != "mg" )
    {
        return 0;
    }
    
    if ( !isdefined( params ) )
    {
        return 1;
    }
    
    return isarrivaltype( asmname, statename, tostatename, params );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 2
// Checksum 0x0, Offset: 0x1268
// Size: 0x89
function enableciviliantargetfocus( ent, direction )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    self._blackboard.civilianfocustargetentity = ent;
    self._blackboard.civilianfocusstate = 1;
    
    if ( !isdefined( direction ) )
    {
        self._blackboard.civilianfocusdirection = "";
    }
    else
    {
        self._blackboard.civilianfocusdirection = direction;
    }
    
    self notify( "civilian_focus_thread_enabled" );
    civilianfocusstartthread();
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x12f9
// Size: 0x2b
function disableciviliantargetfocus()
{
    self._blackboard.civilianfocustargetentity = undefined;
    self._blackboard.civilianfocusstate = 2;
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x132c
// Size: 0x66
function civilianfocusstartthread()
{
    if ( isdefined( self._blackboard.civilianfocusthreadrunning ) )
    {
        return;
    }
    
    self._blackboard.civilianfocusthreadrunning = 1;
    self._blackboard.civilianfocusstate = 0;
    self._blackboard.civilianfocuscurvalue = 0;
    thread civilianfocusupdatethread();
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x139a
// Size: 0x6a
function civilianfocuscomputeyawtotarget()
{
    var_a5106610ad76d39b = self._blackboard.civilianfocustargetentity.origin - self.origin;
    var_a5106610ad76d39b = ( var_a5106610ad76d39b[ 0 ], var_a5106610ad76d39b[ 1 ], 0 );
    var_5290b84b388b75d7 = vectortoangles( var_a5106610ad76d39b );
    return angleclamp180( var_5290b84b388b75d7[ 1 ] - self.angles[ 1 ] );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 1
// Checksum 0x0, Offset: 0x140d
// Size: 0x130, Type: bool
function civilianfocusupdatecurrentfocus( targetvalue )
{
    var_b1dbabba77c6a3f1 = 0.5;
    var_128b23694d81a9b7 = 1 / var_b1dbabba77c6a3f1;
    curtime = gettime();
    timedelt = curtime - self._blackboard.civilianfocuslasttime;
    self._blackboard.civilianfocuslasttime = curtime;
    currentvalue = self._blackboard.civilianfocuscurvalue;
    diff = targetvalue - currentvalue;
    
    if ( abs( diff ) > 0.01 )
    {
        signtotarget = sign( targetvalue - currentvalue );
        newvalue = self._blackboard.civilianfocuscurvalue + timedelt / 1000 * var_128b23694d81a9b7 * signtotarget;
        newvalue = clamp( newvalue, -1, 1 );
        self._blackboard.civilianfocuscurvalue = newvalue;
        return false;
    }
    
    self._blackboard.civilianfocuscurvalue = targetvalue;
    return true;
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x1546
// Size: 0x50, Type: bool
function civilianfocusapproachingarrival()
{
    target_speed = self aigettargetspeed();
    
    if ( !self codemoverequested() || self pathdisttogoal() < target_speed * 1.3 )
    {
        return true;
    }
    else if ( istrue( self._blackboard.var_9fbdce5fa10f8964 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 1
// Checksum 0x0, Offset: 0x159f
// Size: 0x13
function civilianfocusupdateanimparameter( paramvalue )
{
    self setcivilianfocus( paramvalue );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x15ba
// Size: 0x4b9
function civilianfocusupdatethread()
{
    self endon( "death" );
    assert( isdefined( self._blackboard.civilianfocusstate ) );
    var_185be4b1e6feb6 = -1;
    var_9ae98138a32c9405 = 1;
    var_146b23f5a71e5333 = 170;
    var_df301aacf68898c7 = -170;
    self._blackboard.civilianfocuslasttime = 0;
    
    while ( true )
    {
        state = self._blackboard.civilianfocusstate;
        direction = self._blackboard.civilianfocusdirection;
        
        if ( state == 0 )
        {
            self waittill( "civilian_focus_thread_enabled" );
            self._blackboard.civilianfocuslasttime = gettime();
        }
        else if ( state == 1 )
        {
            var_6c542b356d086308 = civilianfocuscomputeyawtotarget();
            var_91f3f4366e4d2f1c = abs( var_6c542b356d086308 );
            
            if ( civilianfocusapproachingarrival() || var_91f3f4366e4d2f1c > 90 )
            {
                self._blackboard.civilianfocusstate = 5;
            }
            else if ( direction == "left" )
            {
                self._blackboard.civilianfocusstate = 3;
            }
            else if ( direction == "right" )
            {
                self._blackboard.civilianfocusstate = 4;
            }
            else if ( var_6c542b356d086308 != 0 )
            {
                self._blackboard.civilianfocusstate = 6;
            }
        }
        else if ( state == 2 )
        {
            self._blackboard.civilianfocusstate = 7;
        }
        else if ( state == 5 )
        {
            civilianfocusupdatecurrentfocus( 0 );
            
            if ( !civilianfocusapproachingarrival() && isalive( self._blackboard.civilianfocustargetentity ) )
            {
                var_6c542b356d086308 = civilianfocuscomputeyawtotarget();
                
                if ( abs( var_6c542b356d086308 ) < 90 )
                {
                    if ( direction == "left" )
                    {
                        self._blackboard.civilianfocusstate = 3;
                    }
                    else if ( direction == "right" )
                    {
                        self._blackboard.civilianfocusstate = 4;
                    }
                    else if ( var_6c542b356d086308 != 0 )
                    {
                        self._blackboard.civilianfocusstate = 6;
                    }
                }
            }
            
            civilianfocusupdateanimparameter( self._blackboard.civilianfocuscurvalue );
        }
        else if ( state == 6 )
        {
            var_6c542b356d086308 = civilianfocuscomputeyawtotarget();
            curtarget = clamp( var_6c542b356d086308, -45, 45 ) / 45;
            assert( curtarget >= -1 && curtarget <= 1 );
            civilianfocusupdatecurrentfocus( curtarget );
            civilianfocusupdateanimparameter( self._blackboard.civilianfocuscurvalue );
            
            if ( civilianfocusapproachingarrival() )
            {
                self._blackboard.civilianfocusstate = 5;
            }
        }
        else if ( state == 3 )
        {
            civilianfocusupdatecurrentfocus( var_185be4b1e6feb6 );
            civilianfocusupdateanimparameter( self._blackboard.civilianfocuscurvalue );
            
            if ( civilianfocusapproachingarrival() )
            {
                self._blackboard.civilianfocusstate = 5;
            }
            else
            {
                var_6c542b356d086308 = civilianfocuscomputeyawtotarget();
                
                if ( abs( var_6c542b356d086308 ) < 90 )
                {
                    self._blackboard.civilianfocusstate = 5;
                }
                else if ( direction == "right" || var_6c542b356d086308 > var_df301aacf68898c7 && var_6c542b356d086308 < -90 )
                {
                    self._blackboard.civilianfocusstate = 4;
                }
            }
        }
        else if ( state == 4 )
        {
            civilianfocusupdatecurrentfocus( var_9ae98138a32c9405 );
            civilianfocusupdateanimparameter( self._blackboard.civilianfocuscurvalue );
            
            if ( civilianfocusapproachingarrival() )
            {
                self._blackboard.civilianfocusstate = 5;
            }
            else
            {
                var_6c542b356d086308 = civilianfocuscomputeyawtotarget();
                
                if ( abs( var_6c542b356d086308 ) < 90 )
                {
                    self._blackboard.civilianfocusstate = 5;
                }
                else if ( direction == "left" || var_6c542b356d086308 > 90 && var_6c542b356d086308 < var_146b23f5a71e5333 )
                {
                    self._blackboard.civilianfocusstate = 3;
                }
            }
        }
        else if ( state == 7 )
        {
            done = civilianfocusupdatecurrentfocus( 0 );
            civilianfocusupdateanimparameter( self._blackboard.civilianfocuscurvalue );
            
            if ( done )
            {
                self._blackboard.civilianfocusstate = 0;
            }
        }
        
        waitframe();
    }
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x1a7b
// Size: 0x41, Type: bool
function civmoverequested( asmname, statename, tostatename, params )
{
    return bb_moverequested() && !istrue( self._blackboard.partialgestureplaying );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1ac5
// Size: 0x41
function civilian_chooseanim_demeanor( asmname, statename, params )
{
    if ( isdefined( params ) )
    {
        return asm_lookupanimfromalias( statename, bb_getcivilianstate() + params );
    }
    
    return asm_lookupanimfromalias( statename, bb_getcivilianstate() );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1b0e
// Size: 0xb3
function civilian_chooseanim_playerpushed( asmname, statename, params )
{
    movedir = asm_getephemeraleventdata( "player_pushed", "player_pushed" );
    movedirnormalized = vectornormalize( movedir );
    targetangles = vectortoangles( movedirnormalized );
    targetyaw = angleclamp180( targetangles[ 1 ] - self.angles[ 1 ] );
    angleindex = scripts\asm\asm::yawdiffto2468( targetyaw );
    aliasname = "pushed_" + angleindex;
    turnanim = asm_lookupanimfromalias( statename, aliasname );
    return turnanim;
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x1bca
// Size: 0x3e, Type: bool
function function_b1bbe0dc316f2efa( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.var_c4242158adaeadd2 ) )
    {
        return false;
    }
    
    return bb_getcivilianstate() == "casual";
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x1c11
// Size: 0xf1, Type: bool
function function_c41de664204e9824( asmname, statename, tostatename, params )
{
    toplayer = level.player.origin - self.origin;
    setdvarifuninitialized( @"hash_e423c827ca27e5c4", 120 );
    dist = getdvarfloat( @"hash_e423c827ca27e5c4", 120 );
    dist *= dist;
    
    if ( lengthsquared( toplayer ) > dist )
    {
        return false;
    }
    
    selfforward = anglestoforward( self.angles );
    
    if ( vectordot( toplayer, selfforward ) < 0 )
    {
        return false;
    }
    
    playerforward = anglestoforward( level.player.angles );
    
    if ( vectordot( playerforward, selfforward ) > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x1d0b
// Size: 0x191, Type: bool
function function_7bd81efb0abdbc44( asmname, statename, tostatename, params )
{
    var_db51c3e732a073b4 = 100;
    closeai = getaiarrayinradius( self.origin, var_db51c3e732a073b4 );
    
    if ( !isdefined( closeai ) )
    {
        return false;
    }
    
    topath = self getposonpath( 100 );
    selfforward = vectornormalize( topath - self.origin );
    bestai = undefined;
    distsq = var_db51c3e732a073b4 * var_db51c3e732a073b4;
    
    for ( i = 0; i < closeai.size ; i++ )
    {
        if ( self == closeai[ i ] )
        {
            continue;
        }
        
        toai = closeai[ i ].origin - self.origin;
        dot = vectordot( toai, selfforward );
        
        if ( dot < 0 )
        {
            continue;
        }
        
        aiforward = anglestoforward( closeai[ i ].angles );
        
        if ( vectordot( selfforward, aiforward ) > 0 )
        {
            continue;
        }
        
        toforward = toai - selfforward * dot;
        
        if ( length2dsquared( toforward ) > 625 )
        {
            continue;
        }
        
        var_70bbcc66e8971969 = lengthsquared( toai );
        
        if ( var_70bbcc66e8971969 < distsq )
        {
            distsq = var_70bbcc66e8971969;
            bestai = closeai[ i ];
        }
    }
    
    if ( !isdefined( bestai ) )
    {
        return false;
    }
    
    self.var_ae59f0b817468ed7 = bestai;
    return true;
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x1ea5
// Size: 0xd9
function function_e481d310d5cb87c( asmname, statename, tostatename, params )
{
    assert( isdefined( self.var_ae59f0b817468ed7 ) );
    assert( isai( self.var_ae59f0b817468ed7 ) );
    assert( isalive( self.var_ae59f0b817468ed7 ) );
    closeai = self.var_ae59f0b817468ed7;
    toai = closeai.origin - self.origin;
    forward = anglestoforward( self.angles );
    
    if ( length( toai ) > 200 )
    {
        return 1;
    }
    
    beyondthreshold = vectordot( toai, forward ) < -20;
    return beyondthreshold;
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1f87
// Size: 0x63
function function_ae83a6295a6675c8( asmname, statename, params )
{
    if ( isdefined( self.var_b5780490703ab4d1 ) )
    {
        idx = self.var_b5780490703ab4d1;
    }
    else
    {
        idx = randomint( 7 ) + 1;
    }
    
    self.var_b18d004bee7ca764 = idx;
    return asm_lookupanimfromalias( statename, "walk_" + idx );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1ff3
// Size: 0xd6
function function_d13115c5f7b949e6( asmname, statename, params )
{
    toplayer = level.player.origin - self.origin;
    forward = anglestoforward( self.angles );
    cross = vectorcross( forward, toplayer );
    idx = 1;
    
    if ( isdefined( self.var_b18d004bee7ca764 ) )
    {
        idx = self.var_b18d004bee7ca764;
    }
    
    alias = undefined;
    
    if ( cross[ 2 ] < 0 )
    {
        alias = "avoid_" + idx + "_l";
    }
    else
    {
        alias = "avoid_" + idx + "_r";
    }
    
    return asm_lookupanimfromalias( statename, alias );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x20d2
// Size: 0x123
function function_d98f49aeb63edce4( asmname, statename, params )
{
    assert( isdefined( self.var_ae59f0b817468ed7 ) );
    assert( isai( self.var_ae59f0b817468ed7 ) );
    assert( isalive( self.var_ae59f0b817468ed7 ) );
    closeai = self.var_ae59f0b817468ed7;
    toai = closeai.origin - self.origin;
    forward = anglestoforward( self.angles );
    cross = vectorcross( forward, toai );
    idx = 1;
    
    if ( isdefined( self.var_b18d004bee7ca764 ) )
    {
        idx = self.var_b18d004bee7ca764;
    }
    
    alias = undefined;
    
    if ( cross[ 2 ] < 0 )
    {
        alias = "avoid_" + idx + "_l";
    }
    else
    {
        alias = "avoid_" + idx + "_r";
    }
    
    return asm_lookupanimfromalias( statename, alias );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x21fe
// Size: 0x25
function function_c4d5a733f656507f( asmname, statename, params )
{
    self.var_ae59f0b817468ed7 = undefined;
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x222b
// Size: 0x2d, Type: bool
function function_7490810d9786cc51( asmname, statename, tostatename, params )
{
    return isdefined( self.customarrivalstate );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x2261
// Size: 0x15b
function civplayturnanim( asmname, statename, tostatename, params )
{
    self endon( statename + "_finished" );
    turnanim = asm_getanim( asmname, statename );
    turnxanim = asm_getxanim( statename, turnanim );
    self.useanimgoalweight = 1;
    assert( !isdefined( params ) || isarray( params ) && params.size == 3 );
    rate = 1;
    
    if ( !isdefined( params ) || params[ 2 ] )
    {
        rate_adjust = randomfloatrange( -0.2, 0.2 );
        rate += rate_adjust;
    }
    
    if ( isai( self ) )
    {
        self aisetanim( statename, turnanim, rate );
    }
    else
    {
        bodyanimid = asm_lookupanimfromalias( "knobs", "body" );
        bodyxanim = asm_getxanim( "knobs", bodyanimid );
        self setflaggedanimknoballrestart( statename, turnxanim, bodyxanim, 1, 0.2, 1 );
    }
    
    if ( !isdefined( params ) || params[ 1 ] )
    {
        thread function_44224a1150c6d2c9( turnxanim, statename );
    }
    
    notehandler = asm_getnotehandler( asmname, statename );
    asm_donotetracks( asmname, statename, notehandler );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 2
// Checksum 0x0, Offset: 0x23c4
// Size: 0x219
function function_44224a1150c6d2c9( turnxanim, statename )
{
    self endon( "death" );
    self endon( statename + "_finished" );
    player = undefined;
    animlength = getanimlength( turnxanim );
    
    if ( animhasnotetrack( turnxanim, "start_aim" ) )
    {
        finish_time = getnotetracktimes( turnxanim, "start_aim" );
        animlength *= finish_time[ 0 ];
    }
    else if ( animhasnotetrack( turnxanim, "finish" ) )
    {
        finish_time = getnotetracktimes( turnxanim, "finish" );
        animlength *= finish_time[ 0 ];
    }
    
    numframes = int( animlength * 20 );
    remainingframes = numframes;
    lookpoint = function_75996a8dac6970f2( 1024 );
    
    if ( isai( self ) )
    {
        while ( remainingframes > 0 )
        {
            lerpfraction = 1 / remainingframes;
            yawtoenemy = angleclamp180( vectortoyaw( lookpoint - self.origin ) - self.angles[ 1 ] );
            currentanimtime = self aigetanimtime( turnxanim );
            animyawdelta = getangledelta( turnxanim, currentanimtime, 1 );
            remainingyaw = angleclamp180( yawtoenemy - animyawdelta );
            self orientmode( "face angle", angleclamp( self.angles[ 1 ] + remainingyaw * lerpfraction ) );
            remainingframes--;
            wait 0.05;
        }
        
        return;
    }
    
    while ( remainingframes > 0 )
    {
        lerpfraction = 1 / remainingframes;
        yawtoenemy = angleclamp180( vectortoyaw( lookpoint - self.origin ) - self.angles[ 1 ] );
        currentanimtime = self getanimtime( turnxanim );
        animyawdelta = getangledelta( turnxanim, currentanimtime, 1 );
        remainingyaw = angleclamp180( yawtoenemy - animyawdelta );
        yaw = angleclamp( self.angles[ 1 ] + remainingyaw * lerpfraction );
        self.angles = ( 0, yaw, 0 );
        remainingframes--;
        wait 0.05;
    }
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x25e5
// Size: 0x207
function civchooseturnanim( asmname, statename, params )
{
    target = function_75996a8dac6970f2( 1024 );
    
    if ( isdefined( params ) & isstring( params ) && params == "return" && isdefined( self.interaction_origin ) )
    {
        target = self.interaction_origin + ( 0, 0, 55 ) + anglestoforward( self.interaction_angles ) * 10;
    }
    
    yawtotarget = vectortoyaw( target - self.origin );
    anglediff = angleclamp180( yawtotarget - self.angles[ 1 ] );
    turnanim = undefined;
    
    if ( isdefined( params ) && params == "cardinal" )
    {
        absanglediff = abs( anglediff );
        animindex = "2";
        
        if ( absanglediff > 135 )
        {
            animindex = "8";
        }
        else if ( anglediff > 45 && anglediff <= 135 )
        {
            animindex = "6";
        }
        else if ( anglediff >= -135 && anglediff < -45 )
        {
            animindex = "4";
        }
        
        turnanim = asm_lookupanimfromalias( statename, animindex );
        assertex( isdefined( turnanim ), "Cardinal turn anim index " + animindex + "is missing in animset " + self.animsetname );
    }
    else
    {
        animmap = [ "2", "3", "6", "9", "8", "7", "4", "1", "2" ];
        animindex = getangleindex( anglediff, 22.5 );
        turnanim = asm_lookupanimfromalias( statename, animmap[ animindex ] );
        assertex( isdefined( turnanim ), "Turn anim index " + animmap[ animindex ] + "is missing in animset " + self.animsetname );
    }
    
    return turnanim;
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x27f5
// Size: 0x4e, Type: bool
function function_4be295e4306dc70c( asmname, statename, tostatename, params )
{
    assertex( isdefined( params ), "CivNearGoalCheck must have a radius param" );
    return distancesquared( self.goalpos, self.origin ) < params * params;
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x284c
// Size: 0x24
function function_89007ae298fb4b15( asmname, statename, params )
{
    set_movement_speed( 52 );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x2878
// Size: 0x24
function function_e7fc2fe7dda8fc2c( asmname, statename, params )
{
    set_movement_speed( 127 );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x28a4
// Size: 0x24
function function_94ec448629b086c8( asmname, statename, params )
{
    set_movement_speed( 153 );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x28d0
// Size: 0x24
function function_d45457463f7a8eab( asmname, statename, params )
{
    set_movement_speed( 220 );
}

// Namespace script_funcs / scripts\asm\civilian\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x28fc
// Size: 0x55
function function_92c056ec351f2f6e( asmname, statename, param )
{
    if ( isdefined( self._blackboard.requestedspeed ) && self._blackboard.requestedspeed < 70 )
    {
        set_movement_speed( 70 );
    }
}

