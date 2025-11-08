#using scripts\anim\utility_common;
#using scripts\common\gameskill;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace utility;

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x343
// Size: 0xb
function initialize( type )
{
    
}

#using_animtree( "generic_human" );

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x356
// Size: 0x140
function updateanimpose()
{
    assertex( self.a.movement == "<dev string:x1c>" || self.a.movement == "<dev string:x24>" || self.a.movement == "<dev string:x2c>", "<dev string:x33>" + self.currentpose + "<dev string:x46>" + self.a.movement );
    
    if ( isdefined( self.desired_anim_pose ) && self.desired_anim_pose != self.currentpose )
    {
        if ( self.currentpose == "prone" )
        {
            exitpronewrapper( 0.5 );
        }
        
        if ( self.desired_anim_pose == "prone" )
        {
            self setproneanimnodes( -45, 45, %prone_legs_down, %exposed_aiming, %prone_legs_up );
            enterpronewrapper( 0.5 );
            self setanimknoball( lookupanim( "default_prone", "straight_level" ), %body, 1, 0.1, 1 );
        }
    }
    
    self.desired_anim_pose = undefined;
}

/#

    // Namespace utility / scripts\anim\utility
    // Params 1
    // Checksum 0x0, Offset: 0x49e
    // Size: 0xcd, Type: dev
    function checkgrenadeinhand( animscript )
    {
        self endon( "<dev string:x4b>" );
        
        if ( animscript == "<dev string:x5d>" || animscript == "<dev string:x65>" )
        {
            wait 0.05;
            waittillframeend();
        }
        
        attachsize = self getattachsize();
        
        for ( i = 0; i < attachsize ; i++ )
        {
            model = tolower( self getattachmodelname( i ) );
            assertex( model != "<dev string:x6e>", "<dev string:x84>" + self.origin );
            assertex( model != "<dev string:xde>", "<dev string:x84>" + self.origin );
            assertex( model != "<dev string:xfe>", "<dev string:x84>" + self.origin );
        }
    }

#/

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x573
// Size: 0x5d
function printdisplaceinfo()
{
    self endon( "death" );
    self notify( "displaceprint" );
    self endon( "displaceprint" );
    
    for ( ;; )
    {
        /#
            print3d( self.origin + ( 0, 0, 60 ), "<dev string:x119>", ( 0, 0.4, 0.7 ), 0.85, 0.5 );
        #/
        
        wait 0.05;
    }
}

/#

    // Namespace utility / scripts\anim\utility
    // Params 0
    // Checksum 0x0, Offset: 0x5d8
    // Size: 0x34, Type: dev
    function isdebugon()
    {
        return getdvarint( @"animdebug" ) == 1 || isdefined( anim.debugent ) && anim.debugent == self;
    }

    // Namespace utility / scripts\anim\utility
    // Params 4
    // Checksum 0x0, Offset: 0x614
    // Size: 0x4e, Type: dev
    function drawdebuglineinternal( frompoint, topoint, color, durationframes )
    {
        for ( i = 0; i < durationframes ; i++ )
        {
            line( frompoint, topoint, color );
            wait 0.05;
        }
    }

    // Namespace utility / scripts\anim\utility
    // Params 4
    // Checksum 0x0, Offset: 0x66a
    // Size: 0x3b, Type: dev
    function drawdebugline( frompoint, topoint, color, durationframes )
    {
        if ( isdebugon() )
        {
            thread drawdebuglineinternal( frompoint, topoint, color, durationframes );
        }
    }

    // Namespace utility / scripts\anim\utility
    // Params 4
    // Checksum 0x0, Offset: 0x6ad
    // Size: 0x51, Type: dev
    function debugline( frompoint, topoint, color, durationframes )
    {
        for ( i = 0; i < durationframes * 20 ; i++ )
        {
            line( frompoint, topoint, color );
            wait 0.05;
        }
    }

#/

// Namespace utility / scripts\anim\utility
// Params 3
// Checksum 0x0, Offset: 0x706
// Size: 0x2b
function notifyaftertime( notifystring, killmestring, time )
{
    self endon( "death" );
    self endon( killmestring );
    wait time;
    self notify( notifystring );
}

// Namespace utility / scripts\anim\utility
// Params 4
// Checksum 0x0, Offset: 0x739
// Size: 0x60
function drawstringtime( msg, org, color, timer )
{
    maxtime = timer * 20;
    
    for ( i = 0; i < maxtime ; i++ )
    {
        /#
            print3d( org, msg, color, 1, 1 );
        #/
        
        wait 0.05;
    }
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x7a1
// Size: 0xaf
function showlastenemysightpos( string )
{
    self notify( "got known enemy2" );
    self endon( "got known enemy2" );
    self endon( "death" );
    
    if ( !isdefined( self.enemy ) )
    {
        return;
    }
    
    if ( self.enemy.team == "allies" )
    {
        color = ( 0.4, 0.7, 1 );
    }
    else
    {
        color = ( 1, 0.7, 0.4 );
    }
    
    while ( true )
    {
        wait 0.05;
        
        if ( !isdefined( self.lastenemysightpos ) )
        {
            continue;
        }
        
        /#
            print3d( self.lastenemysightpos, string, color, 1, 2.15 );
        #/
    }
}

/#

    // Namespace utility / scripts\anim\utility
    // Params 4
    // Checksum 0x0, Offset: 0x858
    // Size: 0x8a, Type: dev
    function function_f5e6ad17591107bc( string, org, printtime, color )
    {
        level notify( "<dev string:x126>" + org );
        level endon( "<dev string:x126>" + org );
        
        if ( !isdefined( color ) )
        {
            color = ( 0.3, 0.9, 0.6 );
        }
        
        timer = printtime * 20;
        i = 0;
        
        while ( i < timer )
        {
            wait 0.05;
            print3d( org, string, color, 1, 1 );
            i += 1;
        }
    }

    // Namespace utility / scripts\anim\utility
    // Params 4
    // Checksum 0x0, Offset: 0x8ea
    // Size: 0x4a, Type: dev
    function printdebugtext( string, org, printtime, color )
    {
        if ( getdvar( @"anim_debug" ) != "<dev string:x13b>" )
        {
            level thread function_f5e6ad17591107bc( string, org, printtime, color );
        }
    }

#/

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x93c
// Size: 0x34
function hasenemysightpos()
{
    if ( isdefined( self.node ) )
    {
        return ( canseeenemyfromexposed() || self cansuppressenemyfromexposed() );
    }
    
    return canseeenemy() || cansuppressenemy();
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x978
// Size: 0xb
function getenemysightpos()
{
    return self.goodshootpos;
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x98c
// Size: 0xd
function debugtimeout()
{
    wait 5;
    self notify( "timeout" );
}

// Namespace utility / scripts\anim\utility
// Params 3
// Checksum 0x0, Offset: 0x9a1
// Size: 0xb8
function debugposinternal( org, string, size )
{
    self endon( "death" );
    self notify( "stop debug " + org );
    self endon( "stop debug " + org );
    ent = spawnstruct();
    ent thread debugtimeout();
    ent endon( "timeout" );
    
    if ( self.enemy.team == "allies" )
    {
        color = ( 0.4, 0.7, 1 );
    }
    else
    {
        color = ( 1, 0.7, 0.4 );
    }
    
    /#
        while ( true )
        {
            wait 0.05;
            print3d( org, string, color, 1, size );
        }
    #/
}

// Namespace utility / scripts\anim\utility
// Params 2
// Checksum 0x0, Offset: 0xa61
// Size: 0x22
function debugpos( org, string )
{
    thread debugposinternal( org, string, 2.15 );
}

// Namespace utility / scripts\anim\utility
// Params 3
// Checksum 0x0, Offset: 0xa8b
// Size: 0x26
function debugpossize( org, string, size )
{
    thread debugposinternal( org, string, size );
}

// Namespace utility / scripts\anim\utility
// Params 2
// Checksum 0x0, Offset: 0xab9
// Size: 0xbd
function debugburstprint( numshots, maxshots )
{
    burstsize = numshots / maxshots;
    burstsizestr = undefined;
    
    if ( numshots == self.bulletsinclip )
    {
        burstsizestr = "all rounds";
    }
    else if ( burstsize < 0.25 )
    {
        burstsizestr = "small burst";
    }
    else if ( burstsize < 0.5 )
    {
        burstsizestr = "med burst";
    }
    else
    {
        burstsizestr = "long burst";
    }
    
    thread debugpossize( self.origin + ( 0, 0, 42 ), burstsizestr, 1.5 );
    thread debugpos( self.origin + ( 0, 0, 60 ), "Suppressing" );
}

/#

    // Namespace utility / scripts\anim\utility
    // Params 0
    // Checksum 0x0, Offset: 0xb7e
    // Size: 0xa1, Type: dev
    function printshootproc()
    {
        self endon( "<dev string:x65>" );
        self notify( "<dev string:x13f>" + self.export );
        self endon( "<dev string:x13f>" + self.export );
        printtime = 0.25;
        timer = printtime * 20;
        i = 0;
        
        while ( i < timer )
        {
            wait 0.05;
            print3d( self.origin + ( 0, 0, 70 ), "<dev string:x14e>", ( 1, 0, 0 ), 1, 1 );
            i += 1;
        }
    }

    // Namespace utility / scripts\anim\utility
    // Params 0
    // Checksum 0x0, Offset: 0xc27
    // Size: 0x24, Type: dev
    function printshoot()
    {
        if ( getdvar( @"anim_debug" ) == "<dev string:x157>" )
        {
            thread printshootproc();
        }
    }

#/

// Namespace utility / scripts\anim\utility
// Params 4
// Checksum 0x0, Offset: 0xc53
// Size: 0x66
function showdebugproc( frompoint, topoint, color, printtime )
{
    /#
        self endon( "<dev string:x65>" );
        timer = printtime * 20;
        i = 0;
        
        while ( i < timer )
        {
            wait 0.05;
            line( frompoint, topoint, color );
            i += 1;
        }
    #/
}

// Namespace utility / scripts\anim\utility
// Params 4
// Checksum 0x0, Offset: 0xcc1
// Size: 0x3d
function showdebugline( frompoint, topoint, color, printtime )
{
    thread showdebugproc( frompoint, topoint + ( 0, 0, -5 ), color, printtime );
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0xd06
// Size: 0xe5
function shootenemywrapper_normal( var_9bc9d0ee2a8a46f5 )
{
    self._blackboard.shootparams_lastshoottime = gettime();
    scripts\common\gameskill::set_accuracy_based_on_situation();
    self notify( "shooting" );
    
    if ( self aiissniper() && istrue( self._blackboard.shootparams_valid ) && isdefined( self._blackboard.shootparams_pos ) )
    {
        if ( isdefined( self.var_3568703b0bab6334 ) && self.var_145c08825430f207 > gettime() - 250 )
        {
            self shoot( 1, self.var_3568703b0bab6334, 1, 0, 1 );
        }
        else
        {
            self shoot( 1, self._blackboard.shootparams_pos, 1, 0, 1 );
        }
        
        return;
    }
    
    if ( isagent( self ) )
    {
        var_9bc9d0ee2a8a46f5 = 1;
    }
    
    self shoot( 1, undefined, var_9bc9d0ee2a8a46f5 );
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0xdf3
// Size: 0x1c
function shootenemywrapper_shootnotify( var_9bc9d0ee2a8a46f5 )
{
    level notify( "an_enemy_shot", self );
    shootenemywrapper_normal( var_9bc9d0ee2a8a46f5 );
}

// Namespace utility / scripts\anim\utility
// Params 2
// Checksum 0x0, Offset: 0xe17
// Size: 0xb3
function shootposwrapper( shootpos, var_9bc9d0ee2a8a46f5 )
{
    self._blackboard.shootparams_lastshoottime = gettime();
    
    if ( !isdefined( var_9bc9d0ee2a8a46f5 ) )
    {
        var_9bc9d0ee2a8a46f5 = 1;
    }
    
    self notify( "shooting" );
    
    if ( self aiissniper() )
    {
        self shoot( 1, shootpos, 1, 1, 1 );
        return;
    }
    
    bignoreenemy = 0;
    
    if ( isdefined( self.enemy ) && istrue( self.enemy.underlowcover ) )
    {
        bignoreenemy = 1;
    }
    
    endpos = bulletspread( self getmuzzlepos(), shootpos, 4 );
    self shoot( 1, endpos, var_9bc9d0ee2a8a46f5, bignoreenemy );
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0xed2
// Size: 0x216
function throwgun()
{
    org = spawn( "script_model", ( 0, 0, 0 ) );
    org setmodel( "temp" );
    org.origin = self gettagorigin( "tag_weapon_right" ) + ( 50, 50, 0 );
    org.angles = self gettagangles( "tag_weapon_right" );
    right = anglestoright( org.angles );
    right *= 15;
    forward = anglestoforward( org.angles );
    forward *= 15;
    org movegravity( ( 0, 50, 150 ), 100 );
    weaponclass = "weapon_" + getcompleteweaponname( self.weapon );
    weapon = spawn( weaponclass, org.origin );
    weapon.angles = self gettagangles( "tag_weapon_right" );
    weapon linkto( org );
    lastorigin = org.origin;
    
    while ( isdefined( weapon ) && isdefined( weapon.origin ) )
    {
        start = lastorigin;
        end = org.origin;
        angles = vectortoangles( end - start );
        forward = anglestoforward( angles );
        forward *= 4;
        trace = scripts\engine\trace::_bullet_trace( end, end + forward, 1, weapon );
        
        if ( isalive( trace[ "entity" ] ) && trace[ "entity" ] == self )
        {
            wait 0.05;
            continue;
        }
        
        if ( trace[ "fraction" ] < 1 )
        {
            break;
        }
        
        lastorigin = org.origin;
        wait 0.05;
    }
    
    if ( isdefined( weapon ) && isdefined( weapon.origin ) )
    {
        weapon unlink();
    }
    
    org delete();
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x10f0
// Size: 0xc1
function personalcoldbreath()
{
    tag = "TAG_EYE";
    self endon( "death" );
    self notify( "stop personal effect" );
    self endon( "stop personal effect" );
    
    while ( isdefined( self ) )
    {
        wait 0.05;
        
        if ( !isdefined( self ) )
        {
            break;
        }
        
        if ( isdefined( self.a.movement ) && self.a.movement == "stop" )
        {
            if ( isdefined( self.isindoor ) && self.isindoor == 1 )
            {
                continue;
            }
            
            playfxontag( level._effect[ "cold_breath" ], self, tag );
            wait 2.5 + randomfloat( 3 );
            continue;
        }
        
        wait 0.5;
    }
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x11b9
// Size: 0x26
function ispartiallysuppressedwrapper()
{
    if ( self.suppressionmeter <= self.suppressionthreshold * 0.25 )
    {
        return 0;
    }
    
    return self issuppressed();
}

/#

    // Namespace utility / scripts\anim\utility
    // Params 3
    // Checksum 0x0, Offset: 0x11e8
    // Size: 0x5b, Type: dev
    function showlines( start, end, end2 )
    {
        for ( ;; )
        {
            line( start, end, ( 1, 0, 0 ), 1 );
            wait 0.05;
            line( start, end2, ( 0, 0, 1 ), 1 );
            wait 0.05;
        }
    }

#/

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x124b
// Size: 0x10
function usingboltactionweapon()
{
    return weaponisboltaction( self.weapon );
}

// Namespace utility / scripts\anim\utility
// Params 3
// Checksum 0x0, Offset: 0x1264
// Size: 0x85
function setfootstepeffect( type, name, fx )
{
    assertex( isdefined( name ), "<dev string:x15c>" );
    assertex( isdefined( fx ), "<dev string:x189>" );
    assertex( isdefined( type ), "<dev string:x1b0>" );
    
    if ( !isdefined( anim.optionalstepeffects ) )
    {
        anim.optionalstepeffects = [];
    }
    
    anim.optionalstepeffects[ name ] = 1;
    level._effect[ "step_" + name ][ type ] = fx;
}

// Namespace utility / scripts\anim\utility
// Params 3
// Checksum 0x0, Offset: 0x12f1
// Size: 0x85
function setfootstepeffectsmall( type, name, fx )
{
    assertex( isdefined( name ), "<dev string:x15c>" );
    assertex( isdefined( fx ), "<dev string:x189>" );
    assertex( isdefined( type ), "<dev string:x1b0>" );
    
    if ( !isdefined( anim.optionalstepeffectssmall ) )
    {
        anim.optionalstepeffectssmall = [];
    }
    
    anim.optionalstepeffectssmall[ name ] = 1;
    level._effect[ "step_small_" + name ][ type ] = fx;
}

// Namespace utility / scripts\anim\utility
// Params 3
// Checksum 0x0, Offset: 0x137e
// Size: 0x9c
function setfootprinteffect( type, name, fx )
{
    assertex( isdefined( name ), "<dev string:x15c>" );
    assertex( isdefined( fx ), "<dev string:x189>" );
    assertex( isdefined( type ), "<dev string:x1b0>" );
    
    if ( !isdefined( anim.optionalfootprinteffects ) )
    {
        anim.optionalfootprinteffects = [];
    }
    
    if ( !isdefined( anim.flirfootprinteffects ) )
    {
        anim.flirfootprinteffects = 0;
    }
    
    anim.optionalfootprinteffects[ name ] = 1;
    level._effect[ "footprint_" + name ][ type ] = fx;
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x1422
// Size: 0x44
function unsetfootstepeffect( name )
{
    assertex( isdefined( name ), "<dev string:x1d9>" );
    
    if ( isdefined( anim.optionalstepeffects ) )
    {
        anim.optionalstepeffects[ name ] = undefined;
    }
    
    level._effect[ "step_" + name ] = undefined;
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x146e
// Size: 0x44
function unsetfootstepeffectsmall( name )
{
    assertex( isdefined( name ), "<dev string:x1d9>" );
    
    if ( isdefined( anim.optionalstepeffectssmall ) )
    {
        anim.optionalstepeffectssmall[ name ] = undefined;
    }
    
    level._effect[ "step_small_" + name ] = undefined;
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x14ba
// Size: 0x44
function unsetfootprinteffect( name )
{
    assertex( isdefined( name ), "<dev string:x1d9>" );
    
    if ( isdefined( anim.optionalfootprinteffects ) )
    {
        anim.optionalfootprinteffects[ name ] = undefined;
    }
    
    level._effect[ "footprint_" + name ] = undefined;
}

// Namespace utility / scripts\anim\utility
// Params 6
// Checksum 0x0, Offset: 0x1506
// Size: 0xdb
function setnotetrackeffect( notetrack, tag, surfacename, fx, sound_prefix, sound_suffix )
{
    assert( isdefined( notetrack ) );
    assert( isdefined( tag ) );
    assert( isdefined( fx ) );
    assertex( isstring( notetrack ), "<dev string:x20f>" );
    
    if ( !isdefined( surfacename ) )
    {
        surfacename = "all";
    }
    
    if ( !isdefined( level._notetrackfx ) )
    {
        level._notetrackfx = [];
    }
    
    level._notetrackfx[ notetrack ][ surfacename ] = spawnstruct();
    level._notetrackfx[ notetrack ][ surfacename ].tag = tag;
    level._notetrackfx[ notetrack ][ surfacename ].fx = fx;
    setnotetracksound( notetrack, surfacename, sound_prefix, sound_suffix );
}

// Namespace utility / scripts\anim\utility
// Params 4
// Checksum 0x0, Offset: 0x15e9
// Size: 0xad
function setnotetracksound( notetrack, surfacename, sound_prefix, sound_suffix )
{
    if ( !isdefined( surfacename ) )
    {
        surfacename = "all";
    }
    
    if ( !isdefined( level._notetrackfx ) )
    {
        level._notetrackfx = [];
    }
    
    if ( isdefined( level._notetrackfx[ notetrack ][ surfacename ] ) )
    {
        struct = level._notetrackfx[ notetrack ][ surfacename ];
    }
    else
    {
        struct = spawnstruct();
        level._notetrackfx[ notetrack ][ surfacename ] = struct;
    }
    
    if ( isdefined( sound_prefix ) )
    {
        struct.sound_prefix = sound_prefix;
    }
    
    if ( isdefined( sound_suffix ) )
    {
        struct.sound_suffix = sound_suffix;
    }
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x169e
// Size: 0x14
function enterpronewrapper( timer )
{
    thread enterpronewrapperproc( timer );
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x16ba
// Size: 0x7d
function enterpronewrapperproc( timer )
{
    self endon( "death" );
    self notify( "anim_prone_change" );
    self endon( "anim_prone_change" );
    self enterprone( timer, isdefined( self.a.onback ) );
    self waittill( "killanimscript" );
    
    if ( self.currentpose != "prone" && !isdefined( self.a.onback ) )
    {
        self.currentpose = "prone";
    }
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x173f
// Size: 0x21
function stoponback()
{
    exitpronewrapper( 1 );
    self.a.onback = undefined;
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x1768
// Size: 0x14
function exitpronewrapper( timer )
{
    thread exitpronewrapperproc( timer );
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x1784
// Size: 0x51
function exitpronewrapperproc( timer )
{
    self endon( "death" );
    self notify( "anim_prone_change" );
    self endon( "anim_prone_change" );
    self exitprone( timer );
    self waittill( "killanimscript" );
    
    if ( self.currentpose == "prone" )
    {
        self.currentpose = "crouch";
    }
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x17dd
// Size: 0xb
function getaiprimaryweapon()
{
    return self.primaryweapon;
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x17f1
// Size: 0xb
function getaisecondaryweapon()
{
    return self.secondaryweapon;
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x1805
// Size: 0xb
function getaisidearmweapon()
{
    return self.sidearm;
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x1819
// Size: 0xb
function getaicurrentweapon()
{
    return self.weapon;
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x182d
// Size: 0x6d
function getaicurrentweaponslot()
{
    if ( self.weapon == self.primaryweapon )
    {
        return "primary";
    }
    
    if ( self.weapon == self.secondaryweapon )
    {
        return "secondary";
    }
    
    if ( self.weapon == self.sidearm )
    {
        return "sidearm";
    }
    
    assertmsg( "<dev string:x232>" );
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x18a2
// Size: 0x3f, Type: bool
function aihasweapon( objweapon )
{
    assert( isweapon( objweapon ) );
    weaponname = getcompleteweaponname( objweapon );
    
    if ( isdefined( self.weaponinfo[ weaponname ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x18ea
// Size: 0x27
function getanimendpos( theanim )
{
    movedelta = getmovedelta( theanim, 0, 1 );
    return self localtoworldcoords( movedelta );
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x191a
// Size: 0xc5
function ragdolldeath( moveanim )
{
    self endon( "killanimscript" );
    lastorg = self.origin;
    movevec = ( 0, 0, 0 );
    
    for ( ;; )
    {
        wait 0.05;
        force = distance( self.origin, lastorg );
        lastorg = self.origin;
        
        if ( self.health == 1 )
        {
            self.a.nodeath = 1;
            self startragdoll();
            self clearanim( moveanim, 0.1 );
            wait 0.05;
            physicsexplosionsphere( lastorg, 600, 0, force * 0.1 );
            self notify( "killanimscript" );
            return;
        }
    }
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x19e7
// Size: 0xc, Type: bool
function iscqbwalkingorfacingenemy()
{
    return !self.facemotion;
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x19fc
// Size: 0x1d
function randomizeidleset()
{
    self.a.idleset = randomint( 2 );
}

// Namespace utility / scripts\anim\utility
// Params 2
// Checksum 0x0, Offset: 0x1a21
// Size: 0x43
function getrandomintfromseed( intseed, intmax )
{
    assert( intmax > 0 );
    index = intseed % anim.randominttablesize;
    return anim.randominttable[ index ] % intmax;
}

// Namespace utility / scripts\anim\utility
// Params 0
// Checksum 0x0, Offset: 0x1a6d
// Size: 0x30
function getcurrentweaponslotname()
{
    assert( isdefined( self ) );
    
    if ( isusingsecondary() )
    {
        return "secondary";
    }
    
    if ( isusingsidearm() )
    {
        return "sidearm";
    }
    
    return "primary";
}

// Namespace utility / scripts\anim\utility
// Params 2
// Checksum 0x0, Offset: 0x1aa6
// Size: 0xed
function lookupanim( animset_name, anim_index )
{
    assert( isai( self ) );
    
    if ( isdefined( self.animarchetype ) )
    {
        assertex( isdefined( anim.archetypes[ self.animarchetype ] ), "<dev string:x25f>" + self.animarchetype );
        
        if ( isdefined( anim.archetypes[ self.animarchetype ][ animset_name ] ) && isdefined( anim.archetypes[ self.animarchetype ][ animset_name ][ anim_index ] ) )
        {
            return anim.archetypes[ self.animarchetype ][ animset_name ][ anim_index ];
        }
    }
    
    assertex( isdefined( anim.archetypes[ "<dev string:x27b>" ][ animset_name ][ anim_index ] ), "<dev string:x286>" + animset_name + "<dev string:x2af>" + anim_index + "<dev string:x2b5>" );
    return anim.archetypes[ "soldier" ][ animset_name ][ anim_index ];
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x1b9c
// Size: 0x11f
function lookupanimarray( animset_name )
{
    assert( isai( self ) );
    
    if ( isdefined( self.animarchetype ) )
    {
        assertex( isdefined( anim.archetypes[ self.animarchetype ] ), "<dev string:x25f>" + self.animarchetype );
        
        if ( isdefined( anim.archetypes[ self.animarchetype ][ animset_name ] ) )
        {
            animset = anim.archetypes[ "soldier" ][ animset_name ];
            
            foreach ( key, value in anim.archetypes[ self.animarchetype ][ animset_name ] )
            {
                animset[ key ] = value;
            }
            
            return animset;
        }
    }
    
    assertex( isdefined( anim.archetypes[ "<dev string:x27b>" ][ animset_name ] ), "<dev string:x2ba>" + animset_name + "<dev string:x2b5>" );
    return anim.archetypes[ "soldier" ][ animset_name ];
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x1cc4
// Size: 0x11
function isenergyweapon( weapon )
{
    return weaponusesenergybullets( weapon );
}

// Namespace utility / scripts\anim\utility
// Params 2
// Checksum 0x0, Offset: 0x1cde
// Size: 0x8c
function function_b5216a6d7bd17210( str_gestureweapon, disallow_reload )
{
    assertex( isdefined( str_gestureweapon ), "<dev string:x2e9>" );
    disallow_reload = default_to( disallow_reload, 0 );
    
    if ( disallow_reload )
    {
        self cancelreload();
    }
    
    gestureweapon = makeweapon( str_gestureweapon );
    self giveandfireoffhand( gestureweapon );
    
    if ( !self hasweapon( gestureweapon ) )
    {
        return;
    }
    
    if ( disallow_reload )
    {
        thread function_422595121745c8a1( gestureweapon );
        self allowreload( 0 );
        waittill_any_2( "offhand_fired", "weapon_gesture_failed" );
        self allowreload( 1 );
    }
}

// Namespace utility / scripts\anim\utility
// Params 1
// Checksum 0x0, Offset: 0x1d72
// Size: 0x2f
function function_422595121745c8a1( gestureweapon )
{
    self endon( "offhand_fired" );
    self endon( "death_or_disconnect" );
    
    while ( self hasweapon( gestureweapon ) )
    {
        waitframe();
    }
    
    self notify( "weapon_gesture_failed" );
}

