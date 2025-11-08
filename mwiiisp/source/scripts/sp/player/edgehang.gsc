#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;

#namespace edgehang;

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x356
// Size: 0xc9
function edgehang()
{
    wait 0.5;
    level.edgehanggroups = getentarray( "edgeHangGroup", "script_noteworthy" );
    level.player.edgehang = 0;
    
    if ( getdvarint( @"bg_enablehangpmove" ) )
    {
        return;
    }
    
    foreach ( edgehanggroup in level.edgehanggroups )
    {
        if ( !isdefined( edgehanggroup.angles ) )
        {
            edgehanggroup.angles = ( 0, 0, 0 );
        }
        
        edgehanggroup scrubangles();
        edgehanggroup thread function_a2a7ccb9802eaea6();
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x427
// Size: 0x74
function function_a2a7ccb9802eaea6()
{
    self.playerhanging = 0;
    createsplines();
    
    /#
        thread function_1a805f35243118e5();
    #/
    
    while ( true )
    {
        function_47ed763279653603();
        
        if ( true )
        {
            thread function_d915a76f0d1a7b56();
            thread function_365b82b00c240c03();
            thread function_7ac67646087b2344();
        }
        else
        {
            thread function_277cfb58f41abe();
            thread function_f74003dbdd58b159();
        }
        
        self.hanginteract waittill( "trigger" );
        function_2d4b15cc38d8bfa();
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x4a3
// Size: 0xd4
function createsplines()
{
    self.splines = [];
    
    for ( startnode = getent( self.target, "targetname" ); true ; startnode = endnode )
    {
        if ( !isdefined( startnode.target ) )
        {
            startnode delete();
            break;
        }
        
        endnode = getent( startnode.target, "targetname" );
        
        if ( !isdefined( endnode ) )
        {
            break;
        }
        
        startnode scrubangles();
        yawoffset = startnode.angles[ 1 ] - self.angles[ 1 ];
        
        if ( yawoffset < 0 )
        {
            yawoffset += 360;
        }
        else if ( yawoffset > 360 )
        {
            yawoffset -= 360;
        }
        
        function_45038569746c5388( startnode, endnode, yawoffset );
        startnode delete();
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x57f
// Size: 0x5e
function scrubangles()
{
    f = anglestoforward( self.angles );
    r = anglestoright( self.angles );
    u = anglestoup( self.angles );
    self.angles = axistoangles( f, r, u );
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x5e5
// Size: 0x222
function function_f74003dbdd58b159()
{
    jumpon = 0;
    self.hanginteract endon( "trigger" );
    
    while ( true )
    {
        if ( function_63dd525072bcee9b( self.hanginteract ) )
        {
            if ( !level.player isonground() && level.player usebuttonpressed() && !level.player ismantling() )
            {
                dir = level.player getnormalizedmovement();
                dir = ( dir[ 0 ], dir[ 1 ] * -1, 0 );
                
                if ( length( dir ) > 0.5 )
                {
                    flatf = anglestoforward( ( 0, level.player.angles[ 1 ], 0 ) );
                    dirpressed = rotatevector( vectornormalize( dir ), level.player.angles );
                    var_7bdfedb1a832a4d0 = ( self.hanginteract.origin[ 0 ], self.hanginteract.origin[ 1 ], 0 );
                    flatplayerorigin = ( level.player.origin[ 0 ], level.player.origin[ 1 ], 0 );
                    vecto = var_7bdfedb1a832a4d0 - flatplayerorigin;
                    dirto = vectornormalize( vecto );
                    distto = length( self.hanginteract.origin - level.player.origin );
                    dotto = vectordot( dirpressed, dirto );
                    dotfacing = vectordot( flatf, dirto );
                    
                    if ( distto < 100 && dotto > 0.2 && dotfacing > 0.2 )
                    {
                        self.jumpon = 1;
                        self.hanginteract notify( "trigger" );
                    }
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x80f
// Size: 0x19
function function_47ed763279653603()
{
    self.hanginteract = spawn_tag_origin();
    thread function_9bdcc8b5a0367faa();
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x830
// Size: 0xf2
function function_dd16ca35e3d5492b()
{
    jumpon = 0;
    self.hanginteract endon( "trigger" );
    
    while ( true )
    {
        if ( function_63dd525072bcee9b( self.hanginteract ) )
        {
            if ( level.player ismantling() )
            {
                distto = length( self.hanginteract.origin - level.player.origin );
                dot = vectordot( anglestoforward( self.hanginteract.angles ), anglestoforward( level.player.angles ) );
                
                if ( distto < 64 && dot > 0.4 )
                {
                    self.jumpon = 1;
                    self.hanginteract notify( "trigger" );
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x92a
// Size: 0x26e
function function_d915a76f0d1a7b56()
{
    jumpon = 0;
    self.hanginteract endon( "trigger" );
    
    while ( true )
    {
        if ( function_63dd525072bcee9b( self.hanginteract ) )
        {
            if ( !level.player.edgehang && !level.player isonground() && !level.player ismantling() && !level.player isonladder() )
            {
                dir = level.player getnormalizedmovement();
                dir = ( dir[ 0 ], dir[ 1 ] * -1, 0 );
                
                if ( length( dir ) > 0.5 )
                {
                    flatf = anglestoforward( ( 0, level.player.angles[ 1 ], 0 ) );
                    dirpressed = rotatevector( vectornormalize( dir ), level.player.angles );
                    var_7bdfedb1a832a4d0 = ( self.hanginteract.origin[ 0 ], self.hanginteract.origin[ 1 ], 0 );
                    flatplayerorigin = ( level.player.origin[ 0 ], level.player.origin[ 1 ], 0 );
                    vecto = var_7bdfedb1a832a4d0 - flatplayerorigin;
                    dirto = vectornormalize( vecto );
                    distto = length( self.hanginteract.origin - level.player.origin );
                    dotto = vectordot( dirpressed, dirto );
                    dotside = vectordot( dirto, anglestoforward( self.hanginteract.angles ) );
                    dotfacing = vectordot( flatf, dirto );
                    
                    if ( distto < 70 && dotto > 0.2 && dotfacing > 0.2 && dotside > -0.1 )
                    {
                        self.jumpon = 1;
                        self.hanginteract notify( "trigger" );
                    }
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 1
// Checksum 0x0, Offset: 0xba0
// Size: 0x4c, Type: bool
function function_63dd525072bcee9b( hanginteract )
{
    return isdefined( level.player.var_bd4c61f6575dfeb ) && hanginteract.origin == level.player.var_bd4c61f6575dfeb.origin;
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0xbf5
// Size: 0x293
function function_7ac67646087b2344()
{
    interact = 0;
    self.hanginteract endon( "trigger" );
    
    while ( true )
    {
        if ( function_63dd525072bcee9b( self.hanginteract ) )
        {
            if ( !level.player.edgehang && level.player isonladder() )
            {
                vecto = self.hanginteract.origin - level.player.origin;
                dist = length( vecto );
                
                if ( dist < 70 )
                {
                    flat_dir = ( self.hanginteract.origin[ 0 ], self.hanginteract.origin[ 1 ], 0 ) - ( level.player.origin[ 0 ], level.player.origin[ 1 ], 0 );
                    flat_dir = vectornormalize( flat_dir );
                    hangnodef = anglestoforward( self.hanginteract.angles );
                    flatdotto = vectordot( flat_dir, hangnodef );
                    
                    if ( flatdotto > 0.99 )
                    {
                        height = level.player.origin[ 2 ] - self.hanginteract.origin[ 2 ] - -70;
                        dir = level.player getnormalizedmovement();
                        dir = ( dir[ 0 ], dir[ 1 ] * -1, 0 );
                        
                        if ( abs( height ) < 15 )
                        {
                            if ( length( dir ) > 0.5 )
                            {
                                dirpressed = rotatevector( vectornormalize( dir ), level.player.angles );
                                r = anglestoright( self.hanginteract.angles );
                                dot = vectordot( r, dirpressed );
                                
                                if ( abs( dot ) > 0.7 )
                                {
                                    self.jumpon = 1;
                                    self.hanginteract notify( "trigger" );
                                }
                            }
                            
                            if ( dir[ 0 ] > 0 )
                            {
                                self.jumpon = 1;
                                self.hanginteract notify( "trigger" );
                            }
                        }
                        else if ( height > 0 )
                        {
                        }
                    }
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0xe90
// Size: 0x2b0
function function_365b82b00c240c03()
{
    interact = 0;
    self.hanginteract endon( "trigger" );
    usedist = 110;
    playercontent = physics_createcontents( [ "physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip" ] );
    
    while ( true )
    {
        shouldinteract = 0;
        
        if ( function_63dd525072bcee9b( self.hanginteract ) )
        {
            if ( !level.player.edgehang && distance( level.player.origin, self.hanginteract.origin ) < usedist )
            {
                flatf = anglestoforward( ( 0, level.player.angles[ 1 ], 0 ) );
                var_7bdfedb1a832a4d0 = ( self.hanginteract.origin[ 0 ], self.hanginteract.origin[ 1 ], 0 );
                flatplayerorigin = ( level.player.origin[ 0 ], level.player.origin[ 1 ], 0 );
                vecto = var_7bdfedb1a832a4d0 - flatplayerorigin;
                dirto = vectornormalize( vecto );
                nodef = -1 * anglestoforward( self.hanginteract.angles );
                dotto = vectordot( nodef, dirto );
                
                if ( dotto > 0.1 )
                {
                    trace_start = level.player geteye();
                    trace_end = ( self.hanginteract.origin[ 0 ], self.hanginteract.origin[ 1 ], trace_start[ 2 ] );
                    trace = scripts\engine\trace::sphere_trace( trace_start, trace_end, 4, level.player, playercontent, 0 );
                    
                    if ( trace[ "fraction" ] == 1 )
                    {
                        shouldinteract = 1;
                    }
                }
            }
        }
        
        if ( shouldinteract )
        {
            if ( !interact )
            {
                self.hanginteract scripts\sp\player\cursor_hint::create_cursor_hint( "tag_origin", ( -50, 0, 0 ), "Ledge Hang", 360, usedist, 100, 1, undefined, 1, undefined, "duration_none" );
                interact = 1;
            }
        }
        else if ( interact )
        {
            self.hanginteract scripts\sp\player\cursor_hint::remove_cursor_hint();
            interact = 0;
        }
        
        wait 0.05;
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x1148
// Size: 0x3a
function function_277cfb58f41abe()
{
    self.hanginteract scripts\sp\player\cursor_hint::create_cursor_hint( "tag_origin", ( 0, 0, 0 ), "Ledge Hang", 110, 100, 75, 1, undefined, 1, undefined, "duration_none" );
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x118a
// Size: 0x52
function function_2d4b15cc38d8bfa()
{
    function_415bec1b3c685780();
    function_762650c291d1ea28();
    thread function_fa05774957abaa95();
    function_9436102ef8c4bdf9();
    function_8b6ad68cf7c826fd();
    function_963305088b5e7892();
    
    if ( true )
    {
        wait 0.1;
        
        while ( level.player ismantling() )
        {
            wait 0.05;
        }
    }
}

/#

    // Namespace edgehang / scripts\sp\player\edgehang
    // Params 0
    // Checksum 0x0, Offset: 0x11e4
    // Size: 0x169, Type: dev
    function function_1a805f35243118e5()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_6d379c34d4da74f2", 0 ) )
            {
                splines = self.splines;
                
                foreach ( spline in splines )
                {
                    if ( !self.playerhanging )
                    {
                        color = ( 0.7, 0.7, 0.7 );
                    }
                    else if ( isdefined( self.currentspline ) && spline[ 0 ] == self.currentspline[ 0 ] && spline[ 1 ] == self.currentspline[ 1 ] )
                    {
                        color = ( 1, 0, 0 );
                    }
                    else
                    {
                        color = ( 0, 1, 0 );
                    }
                    
                    line( getworldoffset( spline[ 0 ] ), getworldoffset( spline[ 1 ] ), color, 0.75, 0, 1 );
                    angles = getsplineangles( spline );
                    centerpoint = ( getworldoffset( spline[ 0 ] ) + getworldoffset( spline[ 1 ] ) ) * 0.5;
                    line( centerpoint, centerpoint + anglestoforward( angles ) * 30, color, 1, 0, 1 );
                }
            }
            
            wait 0.05;
        }
    }

#/

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x1355
// Size: 0xf2
function function_415bec1b3c685780()
{
    self.playerhanging = 1;
    self.playerviewclamptarget = -11111;
    self.var_e8f535d69be1fc1b = 0;
    self.var_600696f7f8aae300 = spawn_tag_origin();
    self.var_a73e33c2079e9dc3 = spawn_tag_origin();
    
    if ( self islinked() )
    {
        self.var_600696f7f8aae300 linkto( self );
        self.var_a73e33c2079e9dc3 linkto( self );
    }
    
    self.var_d42c7cfda9d5b381 = 0;
    
    if ( isdefined( self.jumpon ) && self.jumpon )
    {
        var_dca9e6693cf03ea4 = level.player.origin;
    }
    else
    {
        var_dca9e6693cf03ea4 = self.hanginteract.origin;
    }
    
    function_75064dd60c073e81( var_dca9e6693cf03ea4, undefined );
    self.hanginteract delete();
    level.player.edgehang = 1;
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x144f
// Size: 0x7e
function function_963305088b5e7892()
{
    self.playerhanging = 0;
    self.var_1600b70b51c07f98 = undefined;
    self.currentspline = undefined;
    self.var_fcc975aaa6f37054 = undefined;
    self.crouchoff = undefined;
    self.jumpon = undefined;
    self.var_600696f7f8aae300 delete();
    
    if ( isdefined( self.var_ea6b9f16ae9a73a0 ) )
    {
        self.var_ea6b9f16ae9a73a0 delete();
    }
    
    level.player.edgehang = 0;
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x14d5
// Size: 0x7d2
function function_fa05774957abaa95()
{
    self endon( "playerJumpOffEdge" );
    level.player endon( "death" );
    self.weaponout = 0;
    movement_offset = ( 0, 0, 0 );
    var_82ffb19734953ccb = ( 0, 0, 0 );
    var_95f02e893ab1d0bd = 3;
    var_16609489980fd80e = 0.5;
    shimmyoffsets = spawnstruct();
    shimmyoffsets.heartbeats = [];
    shimmyoffsets.heartbeats[ "view" ] = spawnstruct();
    shimmyoffsets.heartbeats[ "view" ].beat = 0.2;
    shimmyoffsets.heartbeats[ "view" ].dir = 1;
    shimmyoffsets.heartbeats[ "gun" ] = spawnstruct();
    shimmyoffsets.heartbeats[ "gun" ].beat = 0;
    shimmyoffsets.heartbeats[ "gun" ].dir = 1;
    shimmyoffsets.var_e4d1597e80994e3f = 0;
    leanoffset = 0;
    stance = spawnstruct();
    stance.hangstance = 0;
    stance.var_b56ced6f4aa7ebc3 = 0;
    stance.var_a95ee0277142f98a = 0;
    stance thread function_b05d85944fa735c6( self );
    stance thread function_4533627768aa0f0( self );
    var_61bca333033c8393 = 0.5;
    var_e66bccd1051075e1 = 0;
    var_cdcee5ecd566bab6 = 0;
    
    while ( true )
    {
        leantype = getdvarint( @"hash_18b28a0b5e19545a", 3 );
        var_1b95f4274c016e74 = self.var_600696f7f8aae300.angles;
        input = level.player getnormalizedmovement();
        input = ( input[ 0 ], input[ 1 ] * -1, 0 );
        
        if ( length( input ) > length( var_82ffb19734953ccb ) )
        {
            lerprate = 0.1;
        }
        else
        {
            lerprate = 0.4;
        }
        
        var_82ffb19734953ccb = input;
        var_fedea97fb7062b0e = 1;
        
        if ( level.player adsbuttonpressed() )
        {
            if ( leantype == 3 )
            {
                var_7b111bc0a53378e3 = 0;
            }
            else
            {
                var_7b111bc0a53378e3 = 0.5;
            }
        }
        else
        {
            var_7b111bc0a53378e3 = 2;
        }
        
        var_9b6c25107192ea61 = rotatevector( var_82ffb19734953ccb, level.player getplayerangles() );
        var_e40259714a06517b = vectordot( vectornormalize( var_9b6c25107192ea61 ), anglestoforward( self.var_600696f7f8aae300.angles ) );
        playerf = anglestoforward( level.player getplayerangles( 1 ) );
        var_d6bfeae569af2d76 = vectordot( playerf, anglestoforward( ( 0, self.var_600696f7f8aae300.angles[ 1 ], 0 ) ) );
        var_6abb1d94c76adedc = anglestoforward( var_1b95f4274c016e74 ) * var_61bca333033c8393;
        adslean = 0;
        var_7b075d6b82932a86 = 1;
        
        if ( leantype == 0 )
        {
            adslean = math::normalize_value( 0, 0.2, var_d6bfeae569af2d76 );
            var_7b075d6b82932a86 = function_b3b143f1eab0b16c( playerf, var_1b95f4274c016e74, var_6abb1d94c76adedc );
        }
        else if ( leantype == 1 )
        {
            adslean = math::normalize_value( -0.3, 0.3, var_d6bfeae569af2d76 );
        }
        else if ( leantype == 2 )
        {
            if ( !isdefined( stance.var_48124076152106c6 ) )
            {
                stance thread function_c301a9b57c37cecf( self );
            }
            else if ( stance.var_48124076152106c6 == 1 && !level.player adsbuttonpressed() )
            {
                stance.var_48124076152106c6 = 0;
            }
            
            adslean = stance.var_48124076152106c6;
        }
        else if ( leantype == 3 )
        {
            adslean = 0;
            var_7b075d6b82932a86 = 1;
        }
        else
        {
            assertmsg( "CONST lean type " + 3 + "is not valid" );
        }
        
        stance function_e7b66cc533559d5f( self.var_d42c7cfda9d5b381, function_77ebe8aa880204ed(), adslean * var_7b075d6b82932a86 );
        
        if ( leantype == 3 )
        {
            var_b34df20a42cfcd02 = 0.2;
            maxtiltacc = 0.15;
            oldlean = self.var_d42c7cfda9d5b381;
            self.var_d42c7cfda9d5b381 = math::lerp( self.var_d42c7cfda9d5b381, input[ 0 ], 0.2 );
            leandelta = oldlean - self.var_d42c7cfda9d5b381;
            
            if ( abs( leandelta ) > var_b34df20a42cfcd02 )
            {
                if ( self.var_d42c7cfda9d5b381 > oldlean )
                {
                    self.var_d42c7cfda9d5b381 = oldlean + var_b34df20a42cfcd02;
                }
                else
                {
                    self.var_d42c7cfda9d5b381 = oldlean - var_b34df20a42cfcd02;
                }
            }
            
            oldtilt = var_cdcee5ecd566bab6;
            var_cdcee5ecd566bab6 = math::lerp( var_cdcee5ecd566bab6, -1 * input[ 1 ], 0.13 );
            tiltdelta = oldtilt - var_cdcee5ecd566bab6;
            
            if ( abs( tiltdelta ) > maxtiltacc )
            {
                if ( var_cdcee5ecd566bab6 > oldtilt )
                {
                    var_cdcee5ecd566bab6 = oldtilt + maxtiltacc;
                }
                else
                {
                    var_cdcee5ecd566bab6 = oldtilt - maxtiltacc;
                }
            }
            
            if ( level.player adsbuttonpressed() )
            {
                var_e66bccd1051075e1 = math::lerp( var_e66bccd1051075e1, 1, 0.2 );
            }
            else
            {
                var_e66bccd1051075e1 = math::lerp( var_e66bccd1051075e1, 0, 0.2 );
            }
            
            amount = var_e66bccd1051075e1;
            leanoffset = amount * self.var_d42c7cfda9d5b381;
            tiltoffset = amount * var_cdcee5ecd566bab6;
        }
        else
        {
            self.var_d42c7cfda9d5b381 = math::lerp( self.var_d42c7cfda9d5b381, stance.hangstance, 0.2 );
            leanoffset = self.var_d42c7cfda9d5b381;
            tiltoffset = 0;
        }
        
        leanoffset = clamp( leanoffset, -1, 1 );
        horleanoffset = normalize_value( -1, 1, leanoffset );
        horleanoffset = math::normalized_float_smooth_in( horleanoffset );
        horleanoffset = factor_value( -1, 1, horleanoffset );
        
        if ( leanoffset > 0 )
        {
            var_254431638edda2f1 = 4;
            
            if ( leantype == 2 )
            {
                leanvertmag = 12;
            }
            else
            {
                leanvertmag = 10;
            }
        }
        else
        {
            var_254431638edda2f1 = 3;
            leanvertmag = 8;
        }
        
        leanoffsetup = anglestoup( var_1b95f4274c016e74 ) * leanoffset * leanvertmag;
        leanoffsetf = anglestoforward( var_1b95f4274c016e74 ) * horleanoffset * var_254431638edda2f1;
        var_7fd1e7fe48ac60bb = leanoffsetup + leanoffsetf;
        tiltdot = vectordot( anglestoforward( var_1b95f4274c016e74 ), anglestoforward( level.player.angles ) );
        tiltdotfactor = math::factor_value( 0.6, 1, abs( tiltdot ) );
        tiltdotfactor = math::normalized_float_smooth_in( tiltdotfactor );
        tiltmag = 20 * tiltdotfactor;
        tiltoffsetr = anglestoright( level.player.angles ) * tiltoffset * tiltmag;
        var_bea887654e79ccb2 = tiltoffsetr;
        function_75064dd60c073e81( getworldoffset( self.var_fcc975aaa6f37054 ) + var_9b6c25107192ea61 * var_7b111bc0a53378e3 * var_fedea97fb7062b0e, var_7fd1e7fe48ac60bb + var_bea887654e79ccb2 );
        
        if ( self.playerviewclamptarget != self.currentspline[ 2 ] )
        {
            self.playerviewclamptarget = self.currentspline[ 2 ];
        }
        
        shimmyoffsets function_54538f8d17107bcc( function_77ebe8aa880204ed(), self.var_d42c7cfda9d5b381, tiltoffset );
        function_16d771b4fe408da1( input, stance );
        wait 0.05;
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 3
// Checksum 0x0, Offset: 0x1caf
// Size: 0x1b7
function function_b3b143f1eab0b16c( playerf, var_1b95f4274c016e74, var_6abb1d94c76adedc )
{
    testlength = 100;
    var_192ebe688282ab87 = 0;
    fractionincrement = 0.1;
    testheights = [];
    
    while ( var_192ebe688282ab87 < 1 )
    {
        testheights[ testheights.size ] = var_192ebe688282ab87;
        var_192ebe688282ab87 += fractionincrement;
    }
    
    i = 0;
    fracpassed = undefined;
    offsetup = anglestoup( var_1b95f4274c016e74 ) * 50;
    contents = scripts\engine\trace::create_contents( 1, 1, 1, 1, 1, 1, 1, 0, 1 );
    
    while ( true )
    {
        ang = level.player getplayerangles();
        testheight = testheights[ i ];
        testoffsetup = anglestoup( ang ) * testheights[ i ] * 10;
        playerf = anglestoforward( ang );
        start = self.var_a73e33c2079e9dc3.origin + offsetup + var_6abb1d94c76adedc + testoffsetup;
        end = self.var_a73e33c2079e9dc3.origin + playerf * testlength + offsetup + var_6abb1d94c76adedc + testoffsetup;
        trace = scripts\engine\trace::capsule_trace( start, end, 6, 12, ang, level.player, contents, 0 );
        
        if ( trace[ "fraction" ] == 1 )
        {
            fracpassed = testheights[ i ];
            break;
        }
        
        i++;
        
        if ( i > testheights.size - 1 )
        {
            break;
        }
    }
    
    if ( !isdefined( fracpassed ) )
    {
        fracpassed = 1;
    }
    
    return fracpassed;
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 2
// Checksum 0x0, Offset: 0x1e6f
// Size: 0xe3
function function_16d771b4fe408da1( input, stance )
{
    if ( self.var_e8f535d69be1fc1b > 0 && length( input ) > 0 && !level.player adsbuttonpressed() && self.weaponout )
    {
        self.weaponout = 0;
        level.player val::set( "tank_hang", "weapon", 0 );
        return;
    }
    
    if ( ( length( input ) == 0 && self.var_e8f535d69be1fc1b < 0.2 || level.player adsbuttonpressed() ) && !level.player isswitchingweapon() && !self.weaponout )
    {
        self.weaponout = 1;
        level.player val::reset_all( "tank_hang" );
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 1
// Checksum 0x0, Offset: 0x1f5a
// Size: 0x4e
function function_b05d85944fa735c6( edgestruct )
{
    edgestruct endon( "playerJumpOffEdge" );
    level.player notifyonplayercommand( "jumpButtonPressed", "+gostand" );
    
    while ( true )
    {
        level.player waittill( "jumpButtonPressed" );
        self.var_b56ced6f4aa7ebc3 = 1;
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 1
// Checksum 0x0, Offset: 0x1fb0
// Size: 0xab
function function_4533627768aa0f0( edgestruct )
{
    edgestruct endon( "playerJumpOffEdge" );
    level.player endon( "death" );
    level.player notifyonplayercommand( "crouchButtonReleased", "-stance" );
    level.player notifyonplayercommand( "crouchButtonPressed", "+stance" );
    self.crouchbuttonpressed = 0;
    
    while ( true )
    {
        msg = level.player waittill_any_return( "crouchButtonPressed", "crouchButtonReleased" );
        
        if ( msg == "crouchButtonPressed" )
        {
            self.crouchbuttonpressed = 1;
            continue;
        }
        
        self.crouchbuttonpressed = 0;
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 1
// Checksum 0x0, Offset: 0x2063
// Size: 0xa1
function function_c301a9b57c37cecf( edgestruct )
{
    edgestruct endon( "playerJumpOffEdge" );
    level.player endon( "death" );
    level.player notifyonplayercommand( "mountButtonPressed", "+melee_zoom" );
    self.var_48124076152106c6 = 0;
    
    while ( true )
    {
        level.player waittill( "mountButtonPressed" );
        
        if ( level.player adsbuttonpressed() )
        {
            if ( self.var_48124076152106c6 == 1 )
            {
                self.var_48124076152106c6 = 0;
            }
            else
            {
                self.var_48124076152106c6 = 1;
            }
            
            continue;
        }
        
        self.var_48124076152106c6 = 0;
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 3
// Checksum 0x0, Offset: 0x210c
// Size: 0x43
function function_e7b66cc533559d5f( var_d6db966f4160f816, var_7358cb8d282c1df0, adslean )
{
    if ( level.player adsbuttonpressed() )
    {
        self.hangstance = adslean;
        return;
    }
    
    self.hangstance = 0;
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x2157
// Size: 0x17
function function_77ebe8aa880204ed()
{
    return math::normalize_value( 0, 2, self.var_e8f535d69be1fc1b );
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 3
// Checksum 0x0, Offset: 0x2177
// Size: 0x48e
function function_54538f8d17107bcc( shimmymag, leanmag, tiltmag )
{
    self.var_e4d1597e80994e3f = math::lerp( self.var_e4d1597e80994e3f, shimmymag, 0.35 );
    shimmyanimrate = math::factor_value( 0.05, 0.19, self.var_e4d1597e80994e3f );
    
    foreach ( heartbeat in self.heartbeats )
    {
        heartbeat.beat += heartbeat.dir * shimmyanimrate;
        
        if ( abs( heartbeat.beat ) > 1 )
        {
            heartbeat.dir *= -1;
            frac = abs( heartbeat.beat ) - 1;
            heartbeat.beat = clamp( heartbeat.beat, -1, 1 );
            heartbeat.beat += heartbeat.dir * frac;
        }
    }
    
    camerax = 0;
    cameray = 0;
    cameraz = math::function_889bef0ad1600791( abs( self.heartbeats[ "view" ].beat ) ) * 3;
    var_25b7dd23053d5d38 = ( camerax, cameray, cameraz ) * self.var_e4d1597e80994e3f * 0.7;
    gunx = 0;
    guny = self.heartbeats[ "gun" ].beat * 0.5;
    gunz = math::function_889bef0ad1600791( abs( self.heartbeats[ "gun" ].beat ) ) * 0.8;
    var_3d2218c0e2a898f3 = ( gunx, guny, gunz ) * self.var_e4d1597e80994e3f * 0.7;
    
    if ( level.player adsbuttonpressed() )
    {
        ads = 1;
    }
    else
    {
        ads = 0;
    }
    
    var_38c1db12c398d7bc = ( -1, 1, -2 ) * self.var_e4d1597e80994e3f * ( 1 - ads );
    var_401a33448d2a9ace = ( 0, 0, 0 ) * self.var_e4d1597e80994e3f * ( 1 - ads );
    
    if ( leanmag > 0 )
    {
        var_76bb429977536df1 = ( 4, 0, 0 ) * leanmag;
        var_409f528cc0e7d98d = ( 0, 0, 6 ) * leanmag;
    }
    else
    {
        var_76bb429977536df1 = ( 2, 0, 0 ) * leanmag;
        var_409f528cc0e7d98d = ( 0, 0, 6 ) * leanmag;
    }
    
    var_d31fed92a524b6d4 = ( 0, 0, 0 ) * tiltmag;
    var_26f2c7a0b086d4c6 = ( 0, 0, 14 ) * tiltmag;
    var_14b0c9a71297fb6d = ( 0, 0, 0 ) * tiltmag;
    var_d37bc35d129ed119 = ( 0, 0, 6 ) * tiltmag;
    var_e4e41eccb74cbf30 = var_38c1db12c398d7bc + var_3d2218c0e2a898f3 + var_76bb429977536df1 + var_d31fed92a524b6d4;
    var_64e4f421798c7f02 = var_401a33448d2a9ace + var_409f528cc0e7d98d + var_26f2c7a0b086d4c6;
    var_d58398ee314e7bb1 = var_25b7dd23053d5d38 + var_14b0c9a71297fb6d;
    var_fb3d7dff6195f54d = var_d37bc35d129ed119;
    level.player.viewblender[ "weapPos" ].channels[ "edgeHangShimmy" ] = var_e4e41eccb74cbf30;
    level.player.viewblender[ "weapAng" ].channels[ "edgeHangShimmy" ] = var_64e4f421798c7f02;
    level.player.viewblender[ "viewPos" ].channels[ "edgeHangShimmy" ] = var_d58398ee314e7bb1;
    level.player.viewblender[ "viewAng" ].channels[ "edgeHangShimmy" ] = var_fb3d7dff6195f54d;
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x260d
// Size: 0x46
function function_9436102ef8c4bdf9()
{
    while ( level.player usebuttonpressed() )
    {
        wait 0.05;
    }
    
    thread function_71e68d00e8ad107b();
    
    if ( true )
    {
        thread function_541fa9f2e8715c8b();
    }
    
    if ( true )
    {
        thread function_8f05ad2e17cb3298();
    }
    
    self waittill( "playerJumpOffEdge" );
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x265b
// Size: 0x21
function function_71e68d00e8ad107b()
{
    self endon( "playerJumpOffEdge" );
    level.player waittill( "death" );
    self notify( "playerJumpOffEdge" );
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x2684
// Size: 0x29
function function_541fa9f2e8715c8b()
{
    self endon( "playerJumpOffEdge" );
    
    while ( true )
    {
        level.player waittill( "jumpButtonPressed" );
        self notify( "playerJumpOffEdge" );
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x26b5
// Size: 0x3a
function function_8f05ad2e17cb3298()
{
    self endon( "playerJumpOffEdge" );
    
    while ( true )
    {
        level.player waittill( "crouchButtonPressed" );
        self.crouchoff = 1;
        self notify( "playerJumpOffEdge" );
        wait 0.05;
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 1
// Checksum 0x0, Offset: 0x26f7
// Size: 0x30
function function_b64275b2e6f1db2b( edgestruct )
{
    edgestruct waittill( "playerJumpOffEdge" );
    
    if ( self.hint )
    {
        scripts\sp\player\cursor_hint::remove_cursor_hint();
        self.hint = 0;
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x272f
// Size: 0xa4
function function_6ac0b0bd9b464959()
{
    self endon( "jumpHintObjCleanup" );
    self.hint = 0;
    
    while ( true )
    {
        if ( level.player usebuttonpressed() && !self.hint )
        {
            scripts\sp\player\cursor_hint::create_cursor_hint( undefined, ( 0, 0, 0 ), "jump off", 90, 500, 500, 1, 0, 1 );
            self.hint = 1;
        }
        else if ( !level.player usebuttonpressed() && self.hint )
        {
            scripts\sp\player\cursor_hint::remove_cursor_hint();
            self.hint = 0;
        }
        
        wait 0.05;
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x27db
// Size: 0x234
function function_762650c291d1ea28()
{
    level.player notify( "edgeHang" );
    
    if ( isdefined( self.jumpon ) && self.jumpon )
    {
        blendtime = 0.15;
    }
    else
    {
        blendtime = 0.65;
    }
    
    earthquake( 0.2, 0.4, level.player.origin, 1000 );
    level.player.onehandpistol = function_aae1d303960f5ebe();
    level.player giveweapon( level.player.onehandpistol );
    level.player switchtoweaponimmediate( level.player.onehandpistol );
    
    if ( level.player val::get( "weapon" ) )
    {
        level.player val::set( "tank_hang", "weapon", 0 );
        level.player.ogweapon = level.player.currentweapon;
    }
    
    if ( level.player val::get( "mantle" ) )
    {
        level.player val::set( "tank_hang", "mantle", 0 );
    }
    
    if ( level.player val::get( "crouch" ) )
    {
        level.player val::set( "tank_hang", "crouch", 0 );
        level.player val::set( "tank_hang", "prone", 0 );
    }
    
    level.player val::set( "tank_hang", "weapon_switch", 0 );
    level.player val::set( "tank_hang", "allow_jump", 0 );
    level.player playerlinktoblend( self.var_600696f7f8aae300, "tag_origin", blendtime, 0.5 * blendtime, 0.5 * blendtime );
    wait blendtime;
    setviewclamps( 0 );
    earthquake( 0.18, 0.35, level.player.origin, 1000 );
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x2a17
// Size: 0xd3
function function_aae1d303960f5ebe()
{
    onehandweapon = scripts\sp\utility::make_weapon( "iw9_gunless" );
    
    foreach ( weapon in level.player.primaryweapons )
    {
        if ( function_c8e59ba9e32655e2( weapon ) )
        {
            basename = weapon.basename;
            attachments = weapon.attachments;
            onehandattachment = function_1f13244536cf5f9( basename );
            attachments = array_add( weapon.attachments, onehandattachment );
            onehandweapon = scripts\sp\utility::make_weapon( basename, attachments );
        }
    }
    
    return onehandweapon;
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 1
// Checksum 0x0, Offset: 0x2af3
// Size: 0xb6
function function_1f13244536cf5f9( weaponname )
{
    rootnames = [ "golf21", "cpapa", "decho", "mike1911", "mike9", "papa320" ];
    
    foreach ( name in rootnames )
    {
        if ( issubstr( weaponname, name ) )
        {
            return ( "onehand_" + name );
        }
    }
    
    assertmsg( "could not find a onehand attachment for <" + weaponname + ">, make an attachment and update this script" );
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 1
// Checksum 0x0, Offset: 0x2bb1
// Size: 0x2c
function function_c8e59ba9e32655e2( weapon )
{
    if ( string_starts_with( weapon.basename, "iw8_pi_" ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x2be5
// Size: 0x3b
function function_edadd79351368bc4()
{
    level.player forceplaygestureviewmodel( "ges_slide" );
    wait 0.2;
    level.player forceplaygestureviewmodel( "ges_drophand", undefined, 0.6, undefined, 1, 1 );
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x2c28
// Size: 0x40
function function_c3479355a332c0d0()
{
    level.player forceplaygestureviewmodel( "ges_window_break_far", undefined, 0.2, undefined, 1, 1 );
    wait 0.3;
    level.player stopgestureviewmodel( "ges_window_break_far", 0.5 );
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x2c70
// Size: 0x2d8
function function_8b6ad68cf7c826fd()
{
    if ( level.player val::get( "weapon" ) )
    {
        level.player val::set( "tank_hang", "weapon", 0 );
    }
    
    input = level.player getnormalizedmovement();
    input = ( input[ 0 ], input[ 1 ] * -1, 0 );
    
    if ( !isalive( level.player ) )
    {
        input = ( 0, 0, 0 );
    }
    
    if ( length( input ) > 0.3 )
    {
        input = vectornormalize( input );
        input = rotatevector( input, level.player.angles );
        towardswall = anglestoforward( self.var_600696f7f8aae300.angles );
        dot = vectordot( input, towardswall );
        
        if ( dot > 0.3 )
        {
            if ( !level.player val::get( "mantle" ) )
            {
                level.player val::set( "tank_hang", "mantle", 1 );
            }
        }
    }
    
    level.player unlink();
    level.player val::set( "tank_hang", "weapon_switch", 1 );
    level.player val::set( "tank_hang", "allow_jump", 1 );
    level.player takeweapon( level.player.onehandpistol );
    var_6b1db7392882a62 = level.player getnormalizedmovement();
    var_6b1db7392882a62 = ( var_6b1db7392882a62[ 0 ], -1 * var_6b1db7392882a62[ 1 ], 0 );
    inputmag = clamp( length( var_6b1db7392882a62 ), 0, 1 );
    var_6b1db7392882a62 = vectornormalize( var_6b1db7392882a62 );
    var_6b1db7392882a62 = rotatevector( var_6b1db7392882a62, level.player.angles );
    upmag = math::factor_value( 13, 30.5, inputmag );
    awaymag = math::factor_value( 7, 0, inputmag * inputmag );
    jumpmag = math::factor_value( 0, 13.5, inputmag );
    upvec = ( 0, 0, upmag );
    vecaway = anglestoforward( getsplineangles( self.currentspline ) ) * -1;
    awayvec = vecaway * awaymag;
    jumpvec = var_6b1db7392882a62 * jumpmag;
    jumpvec += upvec;
    jumpvec += awayvec;
    
    if ( istrue( self.crouchoff ) )
    {
        jumpvec *= 0.2;
    }
    
    thread fakejump( jumpvec );
    thread function_87e2db95531c5ce3();
    thread function_4977a9b7dd0bb47d();
    thread function_2278ec4f8588473a();
    thread function_4ee147d9ea09d508();
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 1
// Checksum 0x0, Offset: 0x2f50
// Size: 0x2ad
function fakejump( jumpvec )
{
    level.player endon( "edgeHang" );
    lerp_decay = 0.8;
    
    while ( length( jumpvec ) > 0.02 )
    {
        level.player pushplayervector( jumpvec, 1 );
        jumpvec *= lerp_decay;
        level.player.viewblender[ "weapPos" ].channels[ "edgeHangShimmy" ] = level.player.viewblender[ "weapPos" ].channels[ "edgeHangShimmy" ] * lerp_decay;
        level.player.viewblender[ "weapAng" ].channels[ "edgeHangShimmy" ] = level.player.viewblender[ "weapAng" ].channels[ "edgeHangShimmy" ] * lerp_decay;
        level.player.viewblender[ "viewPos" ].channels[ "edgeHangShimmy" ] = level.player.viewblender[ "viewPos" ].channels[ "edgeHangShimmy" ] * lerp_decay;
        level.player.viewblender[ "viewAng" ].channels[ "edgeHangShimmy" ] = level.player.viewblender[ "viewAng" ].channels[ "edgeHangShimmy" ] * lerp_decay;
        wait 0.05;
    }
    
    wait 0.3;
    level.player pushplayervector( ( 0, 0, 0 ), 1 );
    level.player.viewblender[ "weapPos" ].channels[ "edgeHangShimmy" ] = ( 0, 0, 0 );
    level.player.viewblender[ "weapAng" ].channels[ "edgeHangShimmy" ] = ( 0, 0, 0 );
    level.player.viewblender[ "viewPos" ].channels[ "edgeHangShimmy" ] = ( 0, 0, 0 );
    level.player.viewblender[ "viewAng" ].channels[ "edgeHangShimmy" ] = ( 0, 0, 0 );
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x3205
// Size: 0xd1
function function_4977a9b7dd0bb47d()
{
    level.player endon( "edgeHang" );
    
    while ( !level.player isonground() )
    {
        wait 0.05;
    }
    
    if ( !level.player val::get( "weapon" ) )
    {
        level.player val::set( "tank_hang", "weapon", 1 );
    }
    
    if ( isdefined( level.player.ogweapon ) )
    {
        level.player giveweapon( level.player.ogweapon, 0, 0, 0, 1 );
        level.player switchtoweapon( level.player.ogweapon );
        level.player.ogweapon = undefined;
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x32de
// Size: 0x80
function function_87e2db95531c5ce3()
{
    level.player endon( "edgeHang" );
    
    while ( !level.player isonground() )
    {
        wait 0.05;
    }
    
    if ( !level.player val::get( "crouch" ) )
    {
        wait 0.1;
        level.player val::set( "tank_hang", "crouch", 1 );
        level.player val::set( "tank_hang", "prone", 1 );
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x3366
// Size: 0x5e
function function_2278ec4f8588473a()
{
    level.player endon( "edgeHang" );
    
    while ( !level.player isonground() )
    {
        wait 0.05;
    }
    
    if ( !level.player val::get( "mantle" ) )
    {
        level.player val::set( "tank_hang", "mantle", 1 );
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x33cc
// Size: 0x46
function function_4ee147d9ea09d508()
{
    level.player endon( "edgeHang" );
    
    while ( !level.player isonground() )
    {
        wait 0.05;
    }
    
    wait 0.05;
    level.player val::reset_all( "tank_hang" );
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 2
// Checksum 0x0, Offset: 0x341a
// Size: 0x497
function function_75064dd60c073e81( var_82ce829d3ed2ec86, leanoffset )
{
    closestspot = undefined;
    closestdist = 999999999;
    closestspline = undefined;
    
    if ( !isdefined( self.currentspline ) || !level.player adsbuttonpressed() )
    {
        splinestocheck = self.splines;
    }
    else
    {
        splinestocheck = [ self.currentspline ];
    }
    
    foreach ( spline in splinestocheck )
    {
        spot = pointonsegmentnearesttopoint( getworldoffset( spline[ 0 ] ), getworldoffset( spline[ 1 ] ), var_82ce829d3ed2ec86 );
        dist = distance( spot, var_82ce829d3ed2ec86 );
        
        if ( dist < closestdist )
        {
            closestspot = spot;
            closestdist = dist;
            closestspline = spline;
        }
    }
    
    self.currentspline = closestspline;
    
    if ( !isdefined( self.var_1600b70b51c07f98 ) )
    {
        self.var_1600b70b51c07f98 = self.currentspline[ 2 ];
        self.var_ae22c60984b70ebc = 0;
    }
    else
    {
        yawacc = 1.8;
        splineyaw = self.currentspline[ 2 ];
        
        if ( splineyaw > self.var_1600b70b51c07f98 && abs( splineyaw - self.var_1600b70b51c07f98 ) > 180 )
        {
            splineyaw -= 360;
        }
        else if ( splineyaw < self.var_1600b70b51c07f98 && abs( splineyaw - self.var_1600b70b51c07f98 ) > 180 )
        {
            splineyaw += 360;
        }
        
        targetyaw = math::lerp( self.var_1600b70b51c07f98, splineyaw, 0.2 );
        targetyawdelta = targetyaw - self.var_1600b70b51c07f98;
        
        if ( targetyawdelta > 0 && self.var_ae22c60984b70ebc > 0 && targetyawdelta < self.var_ae22c60984b70ebc )
        {
            self.var_ae22c60984b70ebc = targetyawdelta;
        }
        else if ( targetyawdelta < 0 && self.var_ae22c60984b70ebc < 0 && targetyawdelta > self.var_ae22c60984b70ebc )
        {
            self.var_ae22c60984b70ebc = targetyawdelta;
        }
        else if ( targetyawdelta > 0 )
        {
            self.var_ae22c60984b70ebc += yawacc;
        }
        else if ( targetyawdelta < 0 )
        {
            self.var_ae22c60984b70ebc -= yawacc;
        }
        else
        {
            self.var_ae22c60984b70ebc = 0;
        }
        
        self.var_1600b70b51c07f98 += self.var_ae22c60984b70ebc;
        
        if ( self.var_1600b70b51c07f98 > 360 )
        {
            self.var_1600b70b51c07f98 -= 360;
        }
        else if ( self.var_1600b70b51c07f98 < 0 )
        {
            self.var_1600b70b51c07f98 += 360;
        }
    }
    
    if ( self islinked() )
    {
        self.var_600696f7f8aae300 unlink();
        self.var_a73e33c2079e9dc3 unlink();
    }
    
    var_211373c90db0859c = getlocaloffset( closestspot );
    
    if ( !isdefined( self.var_fcc975aaa6f37054 ) )
    {
        self.var_e8f535d69be1fc1b = 0;
    }
    else
    {
        self.var_e8f535d69be1fc1b = math::lerp( self.var_e8f535d69be1fc1b, distance( self.var_fcc975aaa6f37054, var_211373c90db0859c ), 0.5 );
    }
    
    self.var_fcc975aaa6f37054 = var_211373c90db0859c;
    self.var_600696f7f8aae300.origin = closestspot;
    self.var_a73e33c2079e9dc3.origin = closestspot;
    self.var_600696f7f8aae300.angles = function_efd8e218d6da99df( self.var_1600b70b51c07f98 );
    
    if ( !isdefined( leanoffset ) )
    {
        leanoffset = ( 0, 0, 0 );
    }
    
    globaloffset = -64 * anglestoup( self.var_600696f7f8aae300.angles ) + -14 * anglestoforward( self.var_600696f7f8aae300.angles );
    self.var_600696f7f8aae300.origin += leanoffset + globaloffset;
    
    if ( self islinked() )
    {
        self.var_600696f7f8aae300 linkto( self );
        self.var_a73e33c2079e9dc3 linkto( self );
    }
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 1
// Checksum 0x0, Offset: 0x38b9
// Size: 0x53
function setviewclamps( yawoffset )
{
    rightyaw = 170 - yawoffset;
    leftyaw = 170 + yawoffset;
    level.player playerlinktodelta( self.var_600696f7f8aae300, "tag_origin", 0.8, rightyaw, leftyaw, 65, 65, 1 );
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 1
// Checksum 0x0, Offset: 0x3914
// Size: 0x21
function getsplineangles( spline )
{
    ang = function_efd8e218d6da99df( spline[ 2 ] );
    return ang;
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 1
// Checksum 0x0, Offset: 0x393e
// Size: 0x170
function function_efd8e218d6da99df( yawoffset )
{
    og = yawoffset;
    
    if ( yawoffset > 90 && yawoffset < 270 )
    {
        flip = 1;
    }
    else
    {
        flip = 0;
    }
    
    if ( yawoffset < 90 )
    {
        yawoffset = yawoffset;
    }
    else if ( yawoffset < 180 )
    {
        yawoffset = abs( yawoffset - 180 );
    }
    else if ( yawoffset < 270 )
    {
        yawoffset = ( yawoffset - 180 ) * -1;
    }
    else
    {
        yawoffset = abs( yawoffset - 360 );
    }
    
    ang = self.angles;
    f = anglestoforward( ang );
    r = anglestoright( ang );
    u = anglestoup( ang );
    yawfactor = math::normalize_value( 0, 90, abs( yawoffset ) );
    
    if ( yawoffset < 0 )
    {
        maxr = -1 * f;
        maxf = r;
    }
    else
    {
        maxr = f;
        maxf = -1 * r;
    }
    
    if ( flip )
    {
        f *= -1;
        r *= -1;
    }
    
    newf = vectornormalize( math::factor_value( f, maxf, yawfactor ) );
    newr = vectornormalize( math::factor_value( r, maxr, yawfactor ) );
    ang = axistoangles( newf, newr, u );
    return ang;
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 3
// Checksum 0x0, Offset: 0x3ab7
// Size: 0xfc
function function_45038569746c5388( node1, node2, yawoffset )
{
    f = anglestoforward( self.angles );
    r = anglestoright( self.angles );
    u = anglestoup( self.angles );
    splines = [ node1, node2 ];
    
    if ( self islinked() )
    {
        node1 unlink();
    }
    
    node1.angles = axistoangles( f, r, u );
    
    if ( self islinked() )
    {
        node1 linkto( self );
    }
    
    self.splines = array_add( self.splines, [ getlocaloffset( node1.origin ), getlocaloffset( node2.origin ), yawoffset ] );
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 1
// Checksum 0x0, Offset: 0x3bbb
// Size: 0x42
function getlocaloffset( spot )
{
    org = self.origin;
    ang = self.angles;
    spot -= org;
    spot = rotatevectorinverted( spot, ang );
    return spot;
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 1
// Checksum 0x0, Offset: 0x3c06
// Size: 0x42
function getworldoffset( spot )
{
    org = self.origin;
    ang = self.angles;
    spot = rotatevector( spot, ang );
    spot += org;
    return spot;
}

// Namespace edgehang / scripts\sp\player\edgehang
// Params 0
// Checksum 0x0, Offset: 0x3c51
// Size: 0x22e
function function_9bdcc8b5a0367faa()
{
    self.hanginteract endon( "trigger" );
    wait 0.1;
    
    while ( true )
    {
        time = gettime();
        
        if ( isdefined( level.player.var_bd4c61f6575dfeb ) && level.player.var_bd4c61f6575dfeb.timestamp != time )
        {
            level.player.var_bd4c61f6575dfeb = undefined;
        }
        
        closestspot = undefined;
        closestdist = 999999999;
        closestspline = undefined;
        var_82ce829d3ed2ec86 = level.player.origin;
        
        foreach ( spline in self.splines )
        {
            spot = pointonsegmentnearesttopoint( getworldoffset( spline[ 0 ] ), getworldoffset( spline[ 1 ] ), var_82ce829d3ed2ec86 );
            dist = distance( spot, var_82ce829d3ed2ec86 );
            
            if ( dist < closestdist )
            {
                closestspot = spot;
                closestdist = dist;
                closestspline = spline;
            }
        }
        
        interactspot = closestspot;
        self.hanginteract.distfromplayer = closestdist;
        self.hanginteract.timestamp = time;
        
        if ( !isdefined( level.player.var_bd4c61f6575dfeb ) || self.hanginteract.distfromplayer < level.player.var_bd4c61f6575dfeb.distfromplayer )
        {
            level.player.var_bd4c61f6575dfeb = self.hanginteract;
        }
        
        self.hanginteract.origin = interactspot;
        self.hanginteract.angles = getsplineangles( closestspline );
        wait 0.05;
    }
}

