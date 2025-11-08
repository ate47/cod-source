#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\asm_mp;
#using scripts\asm\shared\mp\utility;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\engine\utility;

#namespace utility;

// Namespace utility / scripts\asm\shared\mp\utility
// Params 0
// Checksum 0x0, Offset: 0x1e9
// Size: 0x42
function dotraversal()
{
    self endon( "killanimscript" );
    startnode = self getnegotiationstartnode();
    animscript = startnode.animscript;
    self notify( "traverse_begin", animscript, startnode );
    self waittill( "traverse_end" );
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 3
// Checksum 0x0, Offset: 0x233
// Size: 0x1c, Type: bool
function chooseanimwithoverride( asmname, statename, params )
{
    return false;
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 3
// Checksum 0x0, Offset: 0x258
// Size: 0x88
function loopanimfortime( asmname, statename, params )
{
    self endon( statename + "_finished" );
    self endon( "terminate_ai_threads" );
    endevent = "loop_end";
    t = 2;
    
    if ( isarray( params ) )
    {
        if ( params.size > 0 )
        {
            t = params[ 0 ];
        }
        
        if ( params.size > 1 )
        {
            endevent = params[ 1 ];
        }
    }
    else
    {
        t = params;
    }
    
    thread function_fb56c9527636713f( asmname, statename, 1 );
    wait t;
    asm_fireevent( asmname, endevent );
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 2
// Checksum 0x0, Offset: 0x2e8
// Size: 0x8f
function waitforpathchange( asmname, statename )
{
    self endon( statename + "_finished" );
    self waittill( "path_set" );
    var_2920e731907ba823 = self.lookaheaddir * self.lookaheaddist;
    turnparams = [ 0, var_2920e731907ba823, 0, self.origin, self.lookaheaddist ];
    asm_fireevent( asmname, "sharp_turn", turnparams );
    thread waitforpathchange( asmname, statename );
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 3
// Checksum 0x0, Offset: 0x37f
// Size: 0x87
function playmoveloop_mp( asmname, statename, params )
{
    thread waitforpathchange( asmname, statename );
    rate = 1;
    
    if ( isdefined( self.asm.moveplaybackrate ) )
    {
        rate = self.asm.moveplaybackrate;
    }
    else if ( isdefined( self.moveplaybackrate ) )
    {
        rate = self.moveplaybackrate;
    }
    
    function_fb56c9527636713f( asmname, statename, rate );
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 1
// Checksum 0x0, Offset: 0x40e
// Size: 0x78, Type: bool
function isfacingenemy( mindot )
{
    if ( !isdefined( mindot ) )
    {
        mindot = 0.5;
    }
    
    forward = anglestoforward( self.angles );
    dirtoenemy = vectornormalize( self.enemy.origin - self.origin );
    dot = vectordot( forward, dirtoenemy );
    
    if ( dot < mindot )
    {
        return false;
    }
    
    return true;
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 0
// Checksum 0x0, Offset: 0x48f
// Size: 0xf, Type: bool
function isweaponfacingenemy()
{
    if ( isaimedataimtarget() )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 0
// Checksum 0x0, Offset: 0x4a7
// Size: 0x15, Type: bool
function wantstocrouch()
{
    if ( bb_getrequestedstance() == "crouch" )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 1
// Checksum 0x0, Offset: 0x4c5
// Size: 0xa5
function function_71eefa1c0da64a21( shootfrompos )
{
    if ( !istrue( self._blackboard.shootparams_valid ) )
    {
        return undefined;
    }
    else if ( isdefined( self._blackboard.shootparams_ent ) )
    {
        return self._blackboard.shootparams_ent getshootatpos();
    }
    else if ( isdefined( self._blackboard.shootparams_pos ) )
    {
        return self._blackboard.shootparams_pos;
    }
    else if ( isdefined( self.enemy ) )
    {
        return self.enemy getshootatpos();
    }
    
    return undefined;
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 0
// Checksum 0x0, Offset: 0x573
// Size: 0xed, Type: bool
function isaimedataimtarget()
{
    if ( !isdefined( self._blackboard.shootparams_pos ) && !isdefined( self._blackboard.shootparams_ent ) )
    {
        return true;
    }
    
    weaponangles = self getmuzzleangle();
    shootfrompos = self getshootfrompos();
    shootpos = function_71eefa1c0da64a21( shootfrompos );
    
    if ( !isdefined( shootpos ) )
    {
        return false;
    }
    
    var_17ffbc15989cd7cb = vectortoangles( shootpos - shootfrompos );
    absyawdiff = absangleclamp180( weaponangles[ 1 ] - var_17ffbc15989cd7cb[ 1 ] );
    
    if ( absyawdiff > anim.aimyawdifffartolerance )
    {
        if ( distancesquared( self geteye(), shootpos ) > anim.aimyawdiffclosedistsq || absyawdiff > anim.aimyawdiffclosetolerance )
        {
        }
    }
    
    aimpitchdifftolerance = getaimpitchdifftolerance();
    return absangleclamp180( weaponangles[ 0 ] - var_17ffbc15989cd7cb[ 0 ] ) <= aimpitchdifftolerance;
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 0
// Checksum 0x0, Offset: 0x669
// Size: 0x26
function getaimpitchdifftolerance()
{
    if ( isdefined( self.aimpitchdifftolerance ) )
    {
        return self.aimpitchdifftolerance;
    }
    
    return anim.aimpitchdifftolerance;
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 4
// Checksum 0x0, Offset: 0x697
// Size: 0x23
function delayslowmotion( delay, start, end, time )
{
    
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 3
// Checksum 0x0, Offset: 0x6c2
// Size: 0x1b
function delaymodifybasefov( delay, fov, time )
{
    
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 8
// Checksum 0x0, Offset: 0x6e5
// Size: 0x79
function animscriptmp( archetype, statename, aliasname, loop, playbackrate, customendon, scriptednode, tag )
{
    if ( isdefined( customendon ) )
    {
        thread animscriptmp_watchcancel( customendon );
    }
    
    if ( istrue( loop ) )
    {
        thread animscriptmp_loop_internal( archetype, statename, aliasname, playbackrate, scriptednode, tag );
        return;
    }
    
    thread animscriptmp_single_internal( archetype, statename, aliasname, playbackrate, scriptednode, tag );
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 0
// Checksum 0x0, Offset: 0x766
// Size: 0x1c
function cancelanimscriptmp()
{
    if ( !scripts\asm\asm_bb::bb_isanimscripted() )
    {
        return 0;
    }
    
    cancelanimscriptmp_internal();
    self notify( "CancelAnimscriptMP" );
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 1
// Checksum 0x0, Offset: 0x78a
// Size: 0x2b
function animscriptmp_watchcancel( customendon )
{
    self endon( "AnimscriptMP_Complete" );
    self endon( "death" );
    self endon( "CancelAnimscriptMP" );
    self waittill( customendon );
    cancelanimscriptmp();
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 6
// Checksum 0x0, Offset: 0x7bd
// Size: 0x98
function animscriptmp_single_internal( archetype, statename, aliasname, playbackrate, scriptnode, tag )
{
    animscriptmp_internal( archetype, statename, aliasname, playbackrate, scriptnode, tag );
    var_e1940c994503c932 = isdefined( playbackrate ) && playbackrate == 0;
    
    if ( !var_e1940c994503c932 && isdefined( self ) && isalive( self ) )
    {
        cancelanimscriptmp_internal();
        self notify( "AnimscriptMP_Complete" );
        self notify( "single anim", "end" );
        self notify( "looping anim", "end" );
    }
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 6
// Checksum 0x0, Offset: 0x85d
// Size: 0x56
function animscriptmp_loop_internal( archetype, statename, aliasname, playbackrate, scriptnode, tag )
{
    self endon( "CancelAnimscriptMP" );
    self endon( "death" );
    
    while ( true )
    {
        animscriptmp_internal( archetype, statename, aliasname, playbackrate, scriptnode, tag );
    }
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 4, eflags: 0x4
// Checksum 0x0, Offset: 0x8bb
// Size: 0xb7
function private function_7618d8f3ba2fbcea( xanim, scriptnode, tag, animindex )
{
    if ( isdefined( tag ) )
    {
        assert( isent( scriptnode ) );
        startpos = scriptnode gettagorigin( tag );
        startangles = scriptnode gettagangles( tag );
    }
    else
    {
        startpos = scriptnode.origin;
        startangles = scriptnode.angles;
    }
    
    animstartpos = getstartorigin( startpos, startangles, xanim );
    animstartangles = getstartangles( startpos, startangles, xanim );
    self dontinterpolate();
    self forceteleport( animstartpos, animstartangles, 9999999, 0 );
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 6
// Checksum 0x0, Offset: 0x97a
// Size: 0xec
function animscriptmp_internal( archetype, statename, aliasname, playbackrate, scriptnode, tag )
{
    self endon( "CancelAnimscriptMP" );
    self endon( "death" );
    
    if ( !isdefined( playbackrate ) )
    {
        playbackrate = 1;
    }
    
    self setoverridearchetype( "animscript", archetype, 1 );
    scripts\asm\asm_mp::asm_setanimscripted();
    animindex = archetypegetrandomalias( archetype, statename, aliasname, asm_isfrantic() );
    xanim = animsetgetanimfromindex( archetype, statename, animindex );
    
    if ( isdefined( scriptnode ) )
    {
        function_7618d8f3ba2fbcea( xanim, scriptnode, tag, animindex );
    }
    
    self aisetanim( statename, animindex, playbackrate );
    self aisetanimrate( statename, animindex, playbackrate );
    animlength = getanimlength( xanim );
    self.scripted_mode = 1;
    self.ignoreall = 1;
    
    if ( playbackrate > 0 )
    {
        wait animlength / playbackrate;
    }
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 0
// Checksum 0x0, Offset: 0xa6e
// Size: 0x32
function cancelanimscriptmp_internal()
{
    scripts\asm\asm_bb::bb_clearanimscripted();
    self scriptedanimfinished();
    self clearoverridearchetype( "animscript", 0, 0 );
    self.scripted_mode = 0;
    self.ignoreall = 0;
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 3
// Checksum 0x0, Offset: 0xaa8
// Size: 0x9e
function animscripted_single( aliasname, var_1a11aea0c900b403, statename )
{
    assertex( isalive( self ), "<dev string:x1c>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    scripts\asm\asm_mp::asm_setanimscripted();
    
    if ( !isdefined( statename ) )
    {
        statename = "animscripted";
    }
    
    animindex = asm_lookupanimfromalias( statename, aliasname );
    self aisetanim( statename, animindex );
    
    if ( !isdefined( var_1a11aea0c900b403 ) )
    {
        var_1a11aea0c900b403 = 0;
    }
    
    if ( !var_1a11aea0c900b403 )
    {
        xanim = asm_getxanim( statename, animindex );
        
        if ( isdefined( xanim ) )
        {
            animlength = getanimlength( xanim );
            wait animlength;
        }
    }
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 2
// Checksum 0x0, Offset: 0xb4e
// Size: 0x66
function function_dd94e74da0ad6ead( aliasname, statename )
{
    assertex( isalive( self ), "<dev string:x4f>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    scripts\asm\asm_mp::asm_setanimscripted();
    
    if ( !isdefined( statename ) )
    {
        statename = "animscripted";
    }
    
    animindex = asm_lookupanimfromalias( statename, aliasname );
    self aisetanim( statename, animindex, 0 );
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 2
// Checksum 0x0, Offset: 0xbbc
// Size: 0x99
function animscripted_single_earlyend( aliasname, time )
{
    assertex( isalive( self ), "<dev string:x87>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    assert( time > 0 );
    scripts\asm\asm_mp::asm_setanimscripted();
    animindex = asm_lookupanimfromalias( "animscripted", aliasname );
    self aisetanim( "animscripted", animindex );
    xanim = asm_getxanim( "animscripted", animindex );
    animlength = getanimlength( xanim );
    
    if ( time < animlength )
    {
        wait animlength - time;
    }
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 1
// Checksum 0x0, Offset: 0xc5d
// Size: 0x96
function animscripted_loop( aliasname )
{
    assertex( isalive( self ), "<dev string:xc3>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    scripts\asm\asm_mp::asm_setanimscripted();
    animindex = asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm_getxanim( "animscripted", animindex );
    animlength = getanimlength( xanim );
    
    if ( animlength < 0.05 )
    {
        animlength = 0.05;
    }
    
    while ( true )
    {
        self aisetanim( "animscripted", animindex );
        wait animlength;
    }
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 2
// Checksum 0x0, Offset: 0xcfb
// Size: 0xa9
function animscripted_loop_earlyend( aliasname, time )
{
    assertex( isalive( self ), "<dev string:xf4>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    scripts\asm\asm_mp::asm_setanimscripted();
    animindex = asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm_getxanim( "animscripted", animindex );
    animlength = getanimlength( xanim );
    
    if ( time < animlength )
    {
        animlength -= time;
    }
    
    if ( animlength < 0.05 )
    {
        animlength = 0.05;
    }
    
    while ( true )
    {
        self aisetanim( "animscripted", animindex );
        wait animlength;
    }
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 2
// Checksum 0x0, Offset: 0xdac
// Size: 0xbb
function animscripted_loop_for_time( aliasname, time )
{
    assert( time > 0 );
    assertex( isalive( self ), "<dev string:x12e>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    scripts\asm\asm_mp::asm_setanimscripted();
    animindex = asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm_getxanim( "animscripted", animindex );
    animlength = getanimlength( xanim );
    
    if ( animlength < 0.05 )
    {
        animlength = 0.05;
    }
    
    timeremaining = time;
    
    while ( timeremaining >= 0 )
    {
        self aisetanim( "animscripted", animindex );
        wait animlength;
        timeremaining -= animlength;
    }
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 2
// Checksum 0x0, Offset: 0xe6f
// Size: 0xac
function animscripted_loop_n_times( aliasname, numloops )
{
    assert( numloops );
    assertex( isalive( self ), "<dev string:x168>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    scripts\asm\asm_mp::asm_setanimscripted();
    animindex = asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm_getxanim( "animscripted", animindex );
    animlength = getanimlength( xanim );
    
    if ( animlength < 0.05 )
    {
        animlength = 0.05;
    }
    
    while ( numloops > 0 )
    {
        self aisetanim( "animscripted", animindex );
        wait animlength;
        numloops--;
    }
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 3
// Checksum 0x0, Offset: 0xf23
// Size: 0xca
function animscripted_loop_relative( aliasname, ent, tag )
{
    self endon( "death" );
    assert( isdefined( ent ) );
    assertex( isalive( self ), "<dev string:x168>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    scripts\asm\asm_mp::asm_setanimscripted();
    animindex = asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm_getxanim( "animscripted", animindex );
    function_7618d8f3ba2fbcea( xanim, ent, tag, animindex );
    
    while ( true )
    {
        if ( !istrue( self._blackboard.animscriptedactive ) )
        {
            return;
        }
        
        self aisetanim( "animscripted", animindex );
        animlength = getanimlength( xanim );
        wait animlength;
    }
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 5
// Checksum 0x0, Offset: 0xff5
// Size: 0xc2
function animscripted_single_relative( aliasname, ent, tag, var_1a11aea0c900b403, statename )
{
    assert( isdefined( ent ) );
    assertex( isalive( self ), "<dev string:x1a1>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( !isdefined( statename ) )
    {
        statename = "animscripted";
    }
    
    scripts\asm\asm_mp::asm_setanimscripted();
    animindex = asm_lookupanimfromalias( statename, aliasname );
    xanim = asm_getxanim( statename, animindex );
    function_7618d8f3ba2fbcea( xanim, ent, tag, animindex );
    self aisetanim( statename, animindex );
    
    if ( !isdefined( var_1a11aea0c900b403 ) )
    {
        var_1a11aea0c900b403 = 0;
    }
    
    if ( !var_1a11aea0c900b403 )
    {
        animlength = getanimlength( xanim );
        wait animlength;
    }
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 4
// Checksum 0x0, Offset: 0x10bf
// Size: 0x107
function animscripted_single_arrive_at( aliasname, pos, angles, var_1a11aea0c900b403 )
{
    assertex( isalive( self ), "<dev string:x1dd>" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    scripts\asm\asm_mp::asm_setanimscripted();
    animindex = asm_lookupanimfromalias( "animscripted", aliasname );
    xanim = asm_getxanim( "animscripted", animindex );
    animdelta = getmovedelta( xanim );
    animangles = getangledelta3d( xanim );
    startangles = combineangles( angles, invertangles( animangles ) );
    startpos = pos - rotatevector( animdelta, startangles );
    self dontinterpolate();
    self forceteleport( startpos, startangles, 9999999, 0 );
    self aisetanim( "animscripted", animindex );
    
    if ( !isdefined( var_1a11aea0c900b403 ) )
    {
        var_1a11aea0c900b403 = 0;
    }
    
    if ( !var_1a11aea0c900b403 )
    {
        animlength = getanimlength( xanim );
        wait animlength;
    }
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 0
// Checksum 0x0, Offset: 0x11ce
// Size: 0x10
function animscripted_clear()
{
    scripts\asm\asm_bb::bb_clearanimscripted();
    self scriptedanimfinished();
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 1
// Checksum 0x0, Offset: 0x11e6
// Size: 0x5d, Type: bool
function function_8fa69650e33c84ef( anime )
{
    if ( !isdefined( level.scr_anim ) || !isdefined( self.animname ) || !isdefined( level.scr_anim[ self.animname ] ) || !isdefined( level.scr_anim[ self.animname ][ anime ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 5
// Checksum 0x0, Offset: 0x124c
// Size: 0xee
function animscriptedagent( anime, anim_string, org, animangles, anim_flag )
{
    self endon( "death" );
    
    if ( isstring( anim_flag ) )
    {
        ent_flag_set( anim_flag );
    }
    
    aliasname = level.scr_anim[ self.animname ][ anime ];
    callback_name = anime + "_animscripted";
    callback::callback( callback_name, { #aliasname:aliasname } );
    
    if ( isdefined( org ) )
    {
        anim_node = spawnstruct();
        anim_node.origin = org;
        anim_node.angles = animangles;
        scripts\asm\shared\mp\utility::animscripted_single_relative( aliasname, anim_node );
    }
    else
    {
        scripts\asm\shared\mp\utility::animscripted_single( aliasname );
    }
    
    scripts\asm\shared\mp\utility::animscripted_clear();
    self notify( anim_string, "end" );
    
    if ( isstring( anim_flag ) )
    {
        ent_flag_clear( anim_flag );
    }
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 1
// Checksum 0x0, Offset: 0x1342
// Size: 0x66
function function_8efc1cbdaa97f95e( anime )
{
    spawn_anim = scripts\asm\asm::asm_lookupanimfromalias( "animscripted", level.scr_anim[ self.animname ][ anime ] );
    spawn_xanim = animsetgetanimfromindex( scripts\asm\shared\utility::function_2285421dfc79c4d5(), "animscripted", spawn_anim );
    var_7d881d4e81293ae5 = getmovedelta( spawn_xanim, 0, 1 );
    return var_7d881d4e81293ae5;
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 1
// Checksum 0x0, Offset: 0x13b1
// Size: 0x66
function function_5173aedda202662( anime )
{
    spawn_anim = scripts\asm\asm::asm_lookupanimfromalias( "animscripted", level.scr_anim[ self.animname ][ anime ] );
    spawn_xanim = animsetgetanimfromindex( scripts\asm\shared\utility::function_2285421dfc79c4d5(), "animscripted", spawn_anim );
    var_7d881d4e81293ae5 = getangledelta( spawn_xanim, 0, 1 );
    return var_7d881d4e81293ae5;
}

// Namespace utility / scripts\asm\shared\mp\utility
// Params 2
// Checksum 0x0, Offset: 0x1420
// Size: 0x7d
function ai_anim_first_frame( animation, animname )
{
    level_archetype = "agent_scripted_" + getdvar( @"g_mapname" );
    aliasname = getanimname( animation );
    
    if ( archetypeassetloaded( level_archetype ) )
    {
        thread scripts\asm\shared\mp\utility::animscriptmp( level_archetype, "animscripted", aliasname, undefined, 0 );
        return;
    }
    
    statename = "animscripted";
    thread scripts\asm\shared\mp\utility::function_dd94e74da0ad6ead( aliasname, statename );
}

