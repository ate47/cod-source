#using scripts\anim\combat_utility;
#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\melee;
#using scripts\common\gameskill;
#using scripts\common\utility;
#using scripts\engine\utility;

#namespace script_funcs;

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x9ee
// Size: 0x21b
function soldier_init( asmname, statename, params )
{
    assert( isdefined( self.asm ) );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    self.asm.gestures = spawnstruct();
    self.defaultturnthreshold = 59;
    self.anglelerprate = 100;
    
    if ( !isdefined( self.allowlongdeath ) )
    {
        self.allowlongdeath = 1;
    }
    
    if ( isdefined( self.fnasm_initfingerposes ) )
    {
        self thread [[ self.fnasm_initfingerposes ]]();
    }
    
    self.fnhelmetpop = &scripts\asm\soldier\death::helmetpop;
    initaimlimits( asmname );
    
    if ( self.animsetname == "ai_animation_sequencer" || self.animsetname == "ai_animation_sequencer_combat_loop" || self.animsetname == "ai_animation_sequencer_additive_poses" )
    {
    }
    else
    {
        initanimspeedthresholds_soldier( self.basearchetype );
        initanimspeedthresholds_soldier( self.animsetname );
    }
    
    if ( self findoverridearchetype( "default" ) == "rebel" )
    {
        self.maystumble = 1;
    }
    
    self.var_54b40088c45bf08d = 1;
    
    if ( self isscriptable() )
    {
        thread initscriptable();
    }
    
    self function_62004d7561fd321e();
    weapclass = weaponclass( self.weapon );
    
    if ( weapclass == "mg" )
    {
        self.combatmode = "cover_lmg";
    }
    
    if ( !isdefined( self findoverridearchetype( "weapon" ) ) )
    {
        updateweaponarchetype( weapclass );
    }
    
    if ( !isdefined( self.var_9087e842f157d27c ) )
    {
        self.var_9087e842f157d27c = &scripts\asm\soldier\melee::function_6cde2d3ae248271d;
    }
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 0
// Checksum 0x0, Offset: 0xc11
// Size: 0x27
function initscriptable()
{
    self endon( "death" );
    scripts\engine\utility::flag_wait( "scriptables_ready" );
    self setscriptablepartstate( "notetrack_handler", "active", 0 );
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 1
// Checksum 0x0, Offset: 0xc40
// Size: 0x4bc
function initaimlimits( asmname )
{
    if ( !isdefined( level.combataimlimits ) )
    {
        level.combataimlimits = [];
        level.franticaimlimits = [];
        level.aimlimitstatemappings = [];
    }
    
    if ( !isdefined( level.combataimlimits[ asmname ] ) )
    {
        combataimlimits = [];
        franticaimlimits = [];
        aimlimit = [];
        combataimlimits[ "exposed_idle" ] = aimlimit;
        aimlimit = [];
        franticaimlimits[ "exposed_idle" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "down" ] = 15;
        combataimlimits[ "cover_crouch_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "down" ] = 15;
        franticaimlimits[ "cover_crouch_lean" ] = aimlimit;
        aimlimit = [];
        franticaimlimits[ "cover_crouch_aim" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "right" ] = -15;
        combataimlimits[ "cover_left_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "right" ] = -15;
        franticaimlimits[ "cover_left_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "right" ] = -15;
        combataimlimits[ "cover_left_crouch_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "right" ] = -15;
        franticaimlimits[ "cover_left_crouch_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "left" ] = 15;
        combataimlimits[ "cover_right_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "down" ] = 37;
        aimlimit[ "left" ] = 24;
        franticaimlimits[ "cover_right_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "left" ] = 25;
        combataimlimits[ "cover_right_crouch_lean" ] = aimlimit;
        aimlimit = [];
        aimlimit[ "left" ] = 15;
        franticaimlimits[ "cover_right_crouch_lean" ] = aimlimit;
        level.combataimlimits[ asmname ] = combataimlimits;
        level.franticaimlimits[ asmname ] = franticaimlimits;
    }
    
    if ( !isdefined( level.aimlimitstatemappings[ asmname ] ) )
    {
        aimlimitmapping = [];
        aimlimitmapping[ "cover_stand_exposed" ] = "cover_stand_exposed";
        aimlimitmapping[ "cover_stand_hide_to_exposed" ] = "cover_stand_exposed";
        aimlimitmapping[ "cover_stand_full_exposed" ] = "exposed_idle";
        aimlimitmapping[ "cover_stand_hide_to_full_exposed" ] = "exposed_idle";
        aimlimitmapping[ "cover_stand_to_exposed_idle" ] = "exposed_idle";
        aimlimitmapping[ "wall_run_exit" ] = "exposed_idle";
        aimlimitmapping[ "wall_run_continue" ] = "exposed_idle";
        aimlimitmapping[ "wall_run_left_shoot" ] = "exposed_idle";
        aimlimitmapping[ "wall_run_right_shoot" ] = "exposed_idle";
        aimlimitmapping[ "wall_run_attach_left_shoot" ] = "exposed_idle";
        aimlimitmapping[ "wall_run_attach_right_shoot" ] = "exposed_idle";
        aimlimitmapping[ "cover_crouch_hide_to_stand" ] = "exposed_idle";
        aimlimitmapping[ "cover_crouch_hide_to_aim" ] = "cover_crouch_aim";
        aimlimitmapping[ "cover_crouch_hide_to_right" ] = "cover_crouch_aim";
        aimlimitmapping[ "cover_crouch_hide_to_left" ] = "cover_crouch_aim";
        aimlimitmapping[ "cover_crouch_hide_to_lean" ] = "cover_crouch_lean";
        aimlimitmapping[ "cover_crouch_aim" ] = "cover_crouch_aim";
        aimlimitmapping[ "cover_crouch_lean" ] = "cover_crouch_lean";
        aimlimitmapping[ "cover_crouch_exposed_left" ] = "cover_crouch_aim";
        aimlimitmapping[ "cover_crouch_exposed_right" ] = "cover_crouch_aim";
        aimlimitmapping[ "cover_crouch_stand" ] = "exposed_idle";
        aimlimitmapping[ "cover_crouch_to_exposed_idle" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_exposed_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_hide_to_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_exposed_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_hide_to_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_a_to_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_b_to_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_crouch_exposed_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_crouch_exposed_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_crouch_hide_to_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_crouch_hide_to_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_crouch_a_to_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_crouch_b_to_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_right_lean" ] = "cover_right_lean";
        aimlimitmapping[ "cover_right_hide_to_lean" ] = "cover_right_lean";
        aimlimitmapping[ "cover_right_crouch_hide_to_lean" ] = "cover_right_crouch_lean";
        aimlimitmapping[ "cover_right_crouch_lean" ] = "cover_right_crouch_lean";
        aimlimitmapping[ "cover_right_to_exposed_idle" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_exposed_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_exposed_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_hide_to_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_hide_to_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_a_to_b" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_b_to_a" ] = "exposed_idle";
        aimlimitmapping[ "cover_left_hide_to_lean" ] = "cover_left_lean";
        aimlimitmapping[ "cover_left_lean" ] = "cover_left_lean";
        aimlimitmapping[ "cover_left_crouch_hide_to_lean" ] = "cover_left_crouch_lean";
        aimlimitmapping[ "cover_left_crouch_lean" ] = "cover_left_crouch_lean";
        aimlimitmapping[ "cover_left_to_exposed_idle" ] = "exposed_idle";
        aimlimitmapping[ "cqb_idle" ] = "exposed_idle";
        aimlimitmapping[ "cqb_stand_loop" ] = "exposed_idle";
        aimlimitmapping[ "cqb_stand_strafe_loop" ] = "exposed_idle";
        aimlimitmapping[ "stand_run_strafe_loop" ] = "exposed_idle";
        aimlimitmapping[ "exposed_reload" ] = "exposed_idle";
        aimlimitmapping[ "exposed_weaponswitch" ] = "exposed_idle";
        aimlimitmapping[ "exposed_stand_turn" ] = "exposed_idle";
        aimlimitmapping[ "exposed_idle" ] = "exposed_idle";
        aimlimitmapping[ "exposed_prone" ] = "exposed_idle";
        aimlimitmapping[ "exposed_stand_infantry_reaction" ] = "exposed_idle";
        level.aimlimitstatemappings[ asmname ] = aimlimitmapping;
    }
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 1
// Checksum 0x0, Offset: 0x1104
// Size: 0xd3
function initanimspeedthresholds_soldier( animsetname )
{
    if ( istrue( anim.var_432836e99816347c[ animsetname ] ) )
    {
        return;
    }
    
    if ( animspeedthresholdsexist( animsetname ) )
    {
        return;
    }
    
    if ( animsetname == "boss" || animsetname == "boss2" )
    {
        setspeedthreshold( animsetname, "shuffle", 30 );
    }
    else
    {
        setspeedthreshold( animsetname, "shuffle", 23 );
    }
    
    if ( animsetname == "guard_01" || animsetname == "guard_02" )
    {
        setspeedthreshold( animsetname, "walk", 36 );
    }
    else
    {
        setspeedthreshold( animsetname, "walk", 65 );
    }
    
    setspeedthreshold( animsetname, "fast", 104 );
    setspeedthreshold( animsetname, "jog", 178 );
    setspeedthreshold( animsetname, "run", 210 );
    setspeedthreshold( animsetname, "sprint", 250 );
    anim.var_432836e99816347c[ animsetname ] = 1;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x11df
// Size: 0x8f, Type: bool
function needtoturn3d( asmname, statename, tostatename, params )
{
    if ( istrue( self.matchexposednodeorientation ) && isdefined( self.node ) )
    {
        return false;
    }
    
    yaw = getturndesiredyaw3d();
    
    if ( abs( yaw ) > self.turnthreshold )
    {
        return true;
    }
    
    pitch = getturndesiredpitch3d();
    
    if ( abs( pitch ) > self.pitchturnthreshold )
    {
        return true;
    }
    
    return false;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x1277
// Size: 0x16b
function getturndesiredyaw()
{
    if ( isdefined( self.desiredturnyaw ) )
    {
        return self.desiredturnyaw;
    }
    
    predicttime = 0.25;
    shootent = undefined;
    shootpos = undefined;
    
    if ( self bb_shootparamsvalid() )
    {
        if ( isdefined( self._blackboard.shootparams_pos ) )
        {
            shootpos = self._blackboard.shootparams_pos;
        }
        else if ( isdefined( self._blackboard.shootparams_ent ) )
        {
            shootent = self._blackboard.shootparams_ent;
        }
    }
    else if ( isdefined( self.smartfacingpos ) )
    {
        shootpos = self.smartfacingpos;
    }
    
    if ( !isdefined( shootpos ) && isdefined( self.node ) && self.node.type == "Exposed" && distancesquared( self.node.origin, self.origin ) < 36 )
    {
        return angleclamp180( self.node.angles[ 1 ] - self.angles[ 1 ] );
    }
    
    if ( isdefined( shootent ) && !issentient( shootent ) )
    {
        predicttime = 1.5;
    }
    
    desiredyaw = getpredictedaimyawtoshootentorpos( predicttime, shootent, shootpos );
    return desiredyaw;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x13eb
// Size: 0xd2
function getturndesiredyaw3d()
{
    predicttime = 0.25;
    shootent = undefined;
    shootpos = undefined;
    
    if ( self bb_shootparamsvalid() )
    {
        if ( isdefined( self._blackboard.shootparams_ent ) )
        {
            shootent = self._blackboard.shootparams_ent;
        }
        else if ( isdefined( self._blackboard.shootparams_pos ) )
        {
            shootpos = self._blackboard.shootparams_pos;
        }
    }
    else if ( isdefined( self.enemy ) )
    {
        shootent = self.enemy;
    }
    
    if ( isdefined( shootent ) && !issentient( shootent ) )
    {
        predicttime = 1.5;
    }
    
    desiredyaw = getpredictedaimyawtoshootentorpos3d( predicttime, shootent, shootpos );
    return desiredyaw;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x14c6
// Size: 0xd2
function getturndesiredpitch3d()
{
    predicttime = 0.25;
    shootent = undefined;
    shootpos = undefined;
    
    if ( self bb_shootparamsvalid() )
    {
        if ( isdefined( self._blackboard.shootparams_ent ) )
        {
            shootent = self._blackboard.shootparams_ent;
        }
        else if ( isdefined( self._blackboard.shootparams_pos ) )
        {
            shootpos = self._blackboard.shootparams_pos;
        }
    }
    else if ( isdefined( self.enemy ) )
    {
        shootent = self.enemy;
    }
    
    if ( isdefined( shootent ) && !issentient( shootent ) )
    {
        predicttime = 1.5;
    }
    
    desiredpitch = getpredictedaimpitchtoshootentorpos3d( predicttime, shootent, shootpos );
    return desiredpitch;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x15a1
// Size: 0x166
function chooseturnanim3d( asmname, statename, params )
{
    desiredyaw = getturndesiredyaw3d();
    desiredpitch = getturndesiredpitch3d();
    
    if ( abs( desiredyaw ) > self.turnthreshold && abs( desiredyaw ) > abs( desiredpitch ) )
    {
        if ( desiredyaw < 0 )
        {
            direction = "right";
        }
        else
        {
            direction = "left";
        }
        
        desiredyaw = abs( desiredyaw );
        angle = 0;
        
        if ( desiredyaw > 157.5 )
        {
            angle = 180;
        }
        else if ( desiredyaw > 112.5 )
        {
            angle = 135;
        }
        else if ( desiredyaw > 67.5 )
        {
            angle = 90;
        }
        else
        {
            angle = 45;
        }
        
        animalias = direction + "_" + angle;
        turnanim = asm_lookupanimfromalias( statename, animalias );
        return turnanim;
    }
    
    if ( desiredpitch < 0 )
    {
        direction = "up";
    }
    else
    {
        direction = "down";
    }
    
    desiredpitch = abs( desiredpitch );
    angle = 0;
    
    if ( desiredpitch > 157.5 )
    {
        angle = 180;
    }
    else if ( desiredpitch > 112.5 )
    {
        angle = 135;
    }
    else if ( desiredpitch > 67.5 )
    {
        angle = 90;
    }
    else
    {
        angle = 45;
    }
    
    animalias = direction + "_" + angle;
    turnanim = asm_lookupanimfromalias( statename, animalias );
    return turnanim;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x170f
// Size: 0x81
function choosecrouchturnanim( asmname, statename, params )
{
    desiredyaw = getturndesiredyaw();
    
    if ( desiredyaw < -135 )
    {
        alias = "2r";
    }
    else if ( desiredyaw > 135 )
    {
        alias = "2l";
    }
    else if ( desiredyaw < 0 )
    {
        alias = "6";
    }
    else
    {
        alias = "4";
    }
    
    turnanim = asm_lookupanimfromalias( statename, alias );
    return turnanim;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1799
// Size: 0x1b7
function reload_cleanup( asmname, statename, params )
{
    nullweapon = nullweapon();
    weap = self.asmreloadweapon;
    self.asmreloadweapon = nullweapon;
    
    if ( !isdefined( self.weaponinfo ) )
    {
        return;
    }
    
    var_78e527f9f68f891e = weap != nullweapon && isdefined( self.weapon ) && weap == self.weapon;
    
    if ( weap == nullweapon )
    {
        weap = self.weapon;
    }
    
    weaponname = getcompleteweaponname( weap );
    
    if ( !isdefined( self.weaponinfo[ weaponname ] ) )
    {
        return;
    }
    
    if ( !asm_eventfired( asmname, "drop clip" ) )
    {
        return;
    }
    
    if ( self.weaponinfo[ weaponname ].useclip )
    {
        clipmodel = getweaponclipmodel( weap );
        
        if ( isdefined( clipmodel ) )
        {
            battached = asm_eventfired( asmname, "attach clip left" ) || asm_eventfired( asmname, "attach clip right" );
            bdetached = asm_eventfired( asmname, "detach clip left" ) || asm_eventfired( asmname, "detach clip right" ) || asm_eventfired( asmname, "detach clip nohand" );
            
            if ( !battached )
            {
                self notify( "abort_reload" );
                return;
            }
            
            if ( battached && !bdetached )
            {
                if ( asm_eventfired( asmname, "attach clip left" ) )
                {
                    tagname = "tag_accessory_left";
                }
                else
                {
                    tagname = "tag_accessory_right";
                }
                
                self detach( clipmodel, tagname );
                self notify( "clip_detached" );
                
                if ( var_78e527f9f68f891e )
                {
                    showweaponmagattachment( weaponname );
                }
            }
        }
    }
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1958
// Size: 0x26
function terminateexposedprone( asmname, statename, params )
{
    self.pushable = 1;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1986
// Size: 0x25
function terminateexposedidleaimdown( asmname, statename, params )
{
    self.aimingdown = 0;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x19b3
// Size: 0x25
function terminateexposedcrouchaimdown( asmname, statename, params )
{
    self.aimingdown = 0;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x19e0
// Size: 0x40, Type: bool
function shouldfaceenemyinexposed()
{
    if ( isdefined( self.pathgoalpos ) )
    {
        return false;
    }
    
    return isdefined( self.enemy ) && isplayer( self.enemy ) && self cansee( self.enemy );
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1a29
// Size: 0x93
function playanim_weaponswitch( asmname, statename, params )
{
    self endon( statename + "_finished" );
    weapclass = bb_getrequestedweapon();
    animname = asm_getanim( asmname, statename );
    animrate = scripts\anim\combat_utility::fasteranimspeed();
    self aisetanim( statename, animname, animrate );
    asm_playfacialanim( asmname, statename, asm_getxanim( statename, animname ) );
    asm_donotetracks( asmname, statename, asm_getnotehandler( asmname, statename ) );
    self notify( "switched_to_sidearm" );
    scripts\common\gameskill::didsomethingotherthanshooting();
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1ac4
// Size: 0x3d
function terminate_weaponswitch( asmname, statename, params )
{
    weapclass = weaponclass( self.weapon );
    updateweaponarchetype( weapclass );
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 2
// Checksum 0x0, Offset: 0x1b09
// Size: 0x17a
function playturnanim_turnanimanglefixup( turnxanim, statename )
{
    self endon( "death" );
    self endon( statename + "_finished" );
    enemy = self.enemy;
    enemy endon( "death" );
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
    
    while ( remainingframes > 0 )
    {
        lerpfraction = 1 / remainingframes;
        yawtoenemy = getyawtospot( enemy.origin );
        self.stepoutyaw = angleclamp180( self.angles[ 1 ] + yawtoenemy );
        currentanimtime = self aigetanimtime( turnxanim );
        animyawdelta = getangledelta( turnxanim, currentanimtime, 1 );
        remainingyaw = angleclamp180( yawtoenemy - animyawdelta );
        self orientmode( "face angle", angleclamp( self.angles[ 1 ] + remainingyaw * lerpfraction ) );
        remainingframes--;
        wait 0.05;
    }
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x1c8b
// Size: 0x8e
function shouldsnaptocover_checktype( asmname, statename, tostatename, params )
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
    
    assert( isdefined( params ) );
    return isarrivaltype( asmname, statename, tostatename, params );
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 1
// Checksum 0x0, Offset: 0x1d22
// Size: 0x14
function reloadnotehandler( note )
{
    scripts\anim\notetracks::notetrack_prefix_handler( note );
    return undefined;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1d3f
// Size: 0x30
function assesscleanup( asmname, statename, params )
{
    self._blackboard.var_74f8f2b8eff7c7f = 0;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x1d77
// Size: 0x49, Type: bool
function function_9d9a4c83d3a8b338( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.assesslength ) )
    {
        return true;
    }
    
    if ( gettime() < self.assesslength )
    {
        return false;
    }
    
    return true;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 2
// Checksum 0x0, Offset: 0x1dc9
// Size: 0x85
function facegoalthread_newenemyreaction( statename, reactworldyaw )
{
    self notify( "FaceGoalThread" );
    self endon( "FaceGoalThread" );
    self endon( "death" );
    self endon( statename + "_finished" );
    
    while ( true )
    {
        multiplier = 0.25;
        reactlocalyaw = angleclamp180( reactworldyaw - self.angles[ 1 ] );
        self orientmode( "face angle", self.angles[ 1 ] + reactlocalyaw * multiplier );
        waitframe();
    }
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1e56
// Size: 0x65, Type: bool
function handlefacegoalnotetrack_newenemyreaction( statename, note, lastknown )
{
    assert( isdefined( lastknown ) );
    
    if ( note == "face_goal" )
    {
        metopos = lastknown - self.origin;
        reactworldyaw = vectortoyaw( metopos );
        thread facegoalthread_newenemyreaction( statename, reactworldyaw );
        return true;
    }
    
    return false;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1ec4
// Size: 0xc9
function playanim_newenemyreaction( asmname, statename, params )
{
    self endon( statename + "_finished" );
    pushdisabledgunpose();
    reactanim = self asmgetanim( asmname, statename );
    assert( isdefined( reactanim ) );
    reactxanim = asm_getxanim( statename, reactanim );
    self aisetanim( statename, reactanim );
    lastknown = self lastknownpos( self.enemy );
    thread playturnanim_turnanimanglefixup( reactxanim, statename );
    asm_donotetrackswithinterceptor( asmname, statename, &handlefacegoalnotetrack_newenemyreaction, lastknown );
    
    if ( isdefined( self.enemy ) && self cansee( self.enemy ) )
    {
        self.remainexposedendtime = gettime() + 2000;
    }
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x1f95
// Size: 0xae
function chooseanim_playerpushed( asmname, statename, params )
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

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x204c
// Size: 0x73
function terminate_casualkiller( asmname, statename, params )
{
    self setbasearchetype( self findoverridearchetype( "default" ) );
    self clearoverridearchetype( "demeanor", 0, 1 );
    self.newenemyreaction = 0;
    self.forcenewenemyreaction = 0;
    self notify( "leaveCasualKiller" );
    self.leavecasualkiller = 0;
    self.casualkiller = 0;
    self setdefaultaimlimits();
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x20c7
// Size: 0x2f
function pushdisabledgunpose()
{
    if ( isdefined( self.gunposeoverride ) )
    {
        self.stashedgunposeoverride = self.gunposeoverride;
    }
    
    self.gunposeoverride = "disable";
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 0
// Checksum 0x0, Offset: 0x20fe
// Size: 0x38
function popdisabledgunpose()
{
    if ( isdefined( self.stashedgunposeoverride ) )
    {
        self.gunposeoverride = self.stashedgunposeoverride;
        self.stashedgunposeoverride = undefined;
        return;
    }
    
    self.gunposeoverride = undefined;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 3
// Checksum 0x0, Offset: 0x213e
// Size: 0x3e
function function_e9cdfb92cc489acb( asmname, statename, params )
{
    self function_f662e31df8183bf8( self.origin, self.angles );
    loopanim( asmname, statename, params );
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x2184
// Size: 0x59
function function_33294352d1956570( asmname, statename, tostatename, params )
{
    if ( istrue( self.var_9dc04ef5e55f3574 ) )
    {
        self function_1c339daaba3f71db( 1 );
        utility::lookatentity( self.var_c7cd5e7e287a7df8 );
    }
    
    return asm_lookupanimfromalias( statename, self.dodgedirection );
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x21e6
// Size: 0x40
function function_78fcdbc229ec648c( asmname, statename, tostatename, params )
{
    self function_1c339daaba3f71db( 0 );
    self.var_be159be38e485344 = 0;
    self.var_1f391695bca4a279 = 1;
}

// Namespace script_funcs / scripts\asm\soldier\script_funcs
// Params 4
// Checksum 0x0, Offset: 0x222e
// Size: 0x4d
function forwardpushevent( asmname, statename, tostatename, params )
{
    movedir = asm_geteventdata( asmname, "player_pushed" );
    asm_fireephemeralevent( "player_pushed", "player_pushed", movedir );
}

