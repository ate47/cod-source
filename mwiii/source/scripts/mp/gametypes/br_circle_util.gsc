#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_multi_circle;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\game;
#using scripts\mp\utility\script;

#namespace br_circle_util;

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 5
// Checksum 0x0, Offset: 0x31a
// Size: 0x2c0
function calcsafecirclecenters( origin, circleradii, circleclosetimes, var_b7c9fe00120ea96c, var_437c3e3159a04f4e )
{
    if ( !isdefined( circleradii ) || circleradii.size < 2 || circleradii[ 0 ] <= 0 )
    {
        return undefined;
    }
    
    snaptonavmesh = getdvarint( @"hash_67a8c844bad5a45b", 0 );
    
    if ( !snaptonavmesh && scripts\mp\gametypes\br_gametypes::isfeatureenabled( "circleSnapToNavMesh" ) )
    {
        snaptonavmesh = 1;
    }
    
    circlecenters = [];
    circlecenters[ 0 ] = ( origin[ 0 ], origin[ 1 ], 0 );
    radius = circleradii[ 0 ];
    maxpct = 1 - circleradii[ 1 ] / radius;
    lastcircleindex = circleradii.size - 1;
    circlecenters[ lastcircleindex ] = getrandompointinboundscircle( origin, radius, 0, maxpct, 1, snaptonavmesh, 1 );
    
    if ( istrue( var_437c3e3159a04f4e ) )
    {
        return circlecenters;
    }
    
    playerspeed = getdvarfloat( @"hash_917b939513f89b55", 200 );
    var_11c1e6222da58849 = getdvarint( @"scr_br_circle_clamp_max_circle_speed", 0 );
    
    for ( circleindex = lastcircleindex - 1; circleindex >= 0 ; circleindex-- )
    {
        origin = circlecenters[ circleindex + 1 ];
        radius = circleradii[ circleindex ];
        minpct = 0;
        maxpct = 1 - circleradii[ circleindex + 1 ] / radius;
        pct = minpct + randomfloat( maxpct - minpct );
        closetime = circleclosetimes[ circleindex ];
        prevradius = circleradii[ circleindex + 1 ];
        deltaradius = radius - prevradius;
        radiusspeed = deltaradius / closetime;
        maxmovespeed = max( 0, playerspeed - radiusspeed );
        maxmovedist = maxmovespeed * closetime;
        var_6443d240572e7a5b = maxmovedist / radius;
        var_3f139f4756ad700e = pct > var_6443d240572e7a5b;
        
        if ( var_3f139f4756ad700e && !istrue( var_b7c9fe00120ea96c ) )
        {
            circlespeed = radiusspeed + pct * radius / closetime;
            dlog_recordevent( "dlog_event_br_circle_speed_warning", [ "player_speed", playerspeed, "circle_speed", circlespeed, "circle_close_time", float( closetime ), "circle_current_radius", float( radius ), "circle_next_radius", float( prevradius ) ] );
        }
        
        if ( circleindex )
        {
            if ( var_11c1e6222da58849 && var_3f139f4756ad700e )
            {
                pct = minpct + randomfloat( var_6443d240572e7a5b - minpct );
            }
            
            circlecenters[ circleindex ] = getrandompointinboundscircle( origin, radius, pct, pct, 1, snaptonavmesh, 1 );
        }
    }
    
    return circlecenters;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 4
// Checksum 0x0, Offset: 0x5e3
// Size: 0xd7
function function_a09532919ae80718( requestedcount, circlecenters, circleradii, snaptonavmesh )
{
    movingcircles = [];
    
    for ( circleindex = 1; circleindex <= requestedcount ; circleindex++ )
    {
        var_9d2610f6a0b725a4 = circleradii[ circleindex - 1 ];
        var_a754cfa0ff072630 = circlecenters[ circleindex - 1 ];
        current_circle_radius = circleradii[ circleindex ];
        mindist = var_9d2610f6a0b725a4 + current_circle_radius + level.br_level.br_movingcirclemovedistmin;
        maxdist = var_9d2610f6a0b725a4 + current_circle_radius + level.br_level.br_movingcirclemovedistmax;
        movingcircles[ circleindex - 1 ] = getrandompointinboundscircle( var_a754cfa0ff072630, maxdist, mindist / maxdist, 1, 1, snaptonavmesh, 1 );
    }
    
    return movingcircles;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0
// Checksum 0x0, Offset: 0x6c3
// Size: 0x24
function function_d987886bb9de9137()
{
    if ( !istrue( level.var_2df69b8e552238b6 ) )
    {
        return 0;
    }
    
    return level.br_multi_circle.circlecount;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0
// Checksum 0x0, Offset: 0x6f0
// Size: 0x39, Type: bool
function function_d8fbacc18e5d8498()
{
    return function_d987886bb9de9137() > 1 && level.br_circle.circleindex + 1 == level.br_multi_circle.mergeindex;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0
// Checksum 0x0, Offset: 0x732
// Size: 0x1e
function function_29e8194ff7e13e2e()
{
    return function_49411683f5a51daa( level.br_circle.circleindex + 1 );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0x759
// Size: 0x74
function function_49411683f5a51daa( circleindex )
{
    if ( isdefined( level.br_multi_circle.var_29e8194ff7e13e2e ) )
    {
        return [[ level.br_multi_circle.var_29e8194ff7e13e2e ]]( circleindex );
    }
    
    return function_d987886bb9de9137() > 1 && ( circleindex < level.br_multi_circle.splitindex || circleindex > level.br_multi_circle.mergeindex );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0x7d6
// Size: 0x7f
function function_57f3fd16b628c829( circleindex )
{
    var_a9ed63230d9a3c95 = level.br_level.br_circleshowdelaydanger[ circleindex ];
    
    if ( var_a9ed63230d9a3c95 > 0 )
    {
        hidedangercircle();
        delaythread( var_a9ed63230d9a3c95, &showdangercircle );
    }
    
    var_4f48a6344ec8a9c7 = level.br_level.br_circleshowdelaysafe[ circleindex ];
    
    if ( var_4f48a6344ec8a9c7 > 0 )
    {
        hidesafecircle();
        delaythread( var_4f48a6344ec8a9c7, &showsafecircle );
    }
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 2
// Checksum 0x0, Offset: 0x85d
// Size: 0x4e
function playcircleopendialog( circleindex, var_f007ce073dc3c519 )
{
    if ( canplaycircleopendialog( circleindex ) )
    {
        if ( var_f007ce073dc3c519 )
        {
            scripts\mp\gametypes\br_public::brleaderdialog( "first_circle", 1, undefined, undefined, 0.5 );
            return;
        }
        
        scripts\mp\gametypes\br_public::brleaderdialog( "new_circle", 1, undefined, undefined, 0.5 );
    }
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 2
// Checksum 0x0, Offset: 0x8b3
// Size: 0x57
function playcircleclosedialog( circleindex, var_6b890e6be7982efb )
{
    if ( canplaycircleclosedialog( circleindex ) )
    {
        if ( var_6b890e6be7982efb )
        {
            scripts\mp\gametypes\br_public::brleaderdialog( "final_circle", 1, undefined, undefined, 0.5 );
            return;
        }
        
        scripts\mp\gametypes\br_public::brleaderdialog( "circle_closing", 1, undefined, undefined, 0.5 );
        thread brcirclebattlechatter( circleindex );
    }
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0x912
// Size: 0xb
function function_6ab5543ce292e3fc( circleindex )
{
    
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0x925
// Size: 0xb
function function_d19f6d13e6cefce8( circleindex )
{
    
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0
// Checksum 0x0, Offset: 0x938
// Size: 0x11
function function_ea6cdf6492dfb4fa()
{
    return getdvarint( @"hash_afe2a26cda0aaf42", 0 );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 3
// Checksum 0x0, Offset: 0x952
// Size: 0x7b
function function_8c0f978940451524( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( isdefined( level.var_9ebef1efb6e8a3a9 ) )
    {
        foreach ( callback in level.var_9ebef1efb6e8a3a9 )
        {
            [[ callback ]]( dangercircleorigin, dangercircleradius, thresholdradius );
        }
    }
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0
// Checksum 0x0, Offset: 0x9d5
// Size: 0xac
function function_ebdd2e77a8ade959()
{
    /#
    #/
    
    if ( isdefined( level.var_c7fd2b5cf3acb3da ) )
    {
        foreach ( var_7f590f6ae7f3bc83, callback in level.var_c7fd2b5cf3acb3da )
        {
            hiddenobjects = [[ callback ]]();
            
            if ( isdefined( hiddenobjects ) && hiddenobjects.size > 0 && !function_ea6cdf6492dfb4fa() )
            {
                hiddenobjects = array_remove_duplicates( hiddenobjects );
                level.var_8a12e160a2617c92[ var_7f590f6ae7f3bc83 ] = array_combine_unique( level.var_8a12e160a2617c92[ var_7f590f6ae7f3bc83 ], hiddenobjects );
            }
        }
    }
    
    /#
    #/
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0xa89
// Size: 0x104
function function_799fe4ee850f911( circleindex )
{
    if ( !isdefined( level.br_multi_circle ) || !isdefined( level.br_multi_circle.circles ) || !isdefined( level.br_multi_circle.circles[ circleindex ] ) || !isdefined( level.br_multi_circle.circles[ circleindex ].entdata ) )
    {
        return ( 0, 0, 0 );
    }
    
    entdata = level.br_multi_circle.circles[ circleindex ].entdata;
    
    if ( !isdefined( entdata ) )
    {
        return ( 0, 0, 0 );
    }
    
    safecircle = entdata.safeent;
    
    if ( !isdefined( safecircle ) )
    {
        return ( 0, 0, 0 );
    }
    
    return ( safecircle.origin[ 0 ], safecircle.origin[ 1 ], 0 );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0xb96
// Size: 0x6f
function function_8a985543e6853bbd( circleindex )
{
    entdata = level.br_multi_circle.circles[ circleindex ].entdata;
    
    if ( !isdefined( entdata ) )
    {
        return 0;
    }
    
    safecircle = entdata.safeent;
    
    if ( !isdefined( safecircle ) )
    {
        return 0;
    }
    
    return safecircle.origin[ 2 ];
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0xc0e
// Size: 0x92
function function_755c691f70eafe3b( circleindex )
{
    entdata = level.br_multi_circle.circles[ circleindex ].entdata;
    
    if ( !isdefined( entdata ) )
    {
        return ( 0, 0, 0 );
    }
    
    dangercircle = entdata.dangerent;
    
    if ( !isdefined( dangercircle ) )
    {
        return ( 0, 0, 0 );
    }
    
    return ( dangercircle.origin[ 0 ], dangercircle.origin[ 1 ], 0 );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0xca9
// Size: 0x6f
function function_a835b5dff878f77( circleindex )
{
    entdata = level.br_multi_circle.circles[ circleindex ].entdata;
    
    if ( !isdefined( entdata ) )
    {
        return 0;
    }
    
    dangercircle = entdata.dangerent;
    
    if ( !isdefined( dangercircle ) )
    {
        return 0;
    }
    
    return dangercircle.origin[ 2 ];
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 3
// Checksum 0x0, Offset: 0xd21
// Size: 0xd1, Type: bool
function function_d277283fb9ad5d46( origin, index, bufferdist )
{
    entdata = level.br_multi_circle.circles[ index ].entdata;
    
    if ( !isdefined( entdata ) )
    {
        return false;
    }
    
    dangercircle = entdata.dangerent;
    
    if ( !isdefined( dangercircle ) )
    {
        return false;
    }
    
    if ( !isdefined( origin ) )
    {
        return false;
    }
    
    dangercircleorigin = ( dangercircle.origin[ 0 ], dangercircle.origin[ 1 ], 0 );
    dangercircleradius = dangercircle.origin[ 2 ];
    
    if ( isdefined( bufferdist ) )
    {
        dangercircleradius += bufferdist;
    }
    
    if ( distance2dsquared( dangercircleorigin, origin ) < dangercircleradius * dangercircleradius )
    {
        return true;
    }
    
    return false;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 2
// Checksum 0x0, Offset: 0xdfb
// Size: 0x7c, Type: bool
function ispointinmulticircledanger( origin, gracedistance )
{
    if ( !istrue( level.var_2df69b8e552238b6 ) )
    {
        return false;
    }
    
    if ( !isdefined( gracedistance ) )
    {
        gracedistance = 0;
    }
    
    multicirclecount = function_d987886bb9de9137();
    
    if ( function_29e8194ff7e13e2e() )
    {
        multicirclecount = 1;
    }
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        isdanger = function_d277283fb9ad5d46( origin, i, gracedistance );
        
        if ( istrue( isdanger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 3
// Checksum 0x0, Offset: 0xe80
// Size: 0xd4
function function_783961b002f33360( origin, index, bufferdist )
{
    if ( !isdefined( level.br_multi_circle.circles[ index ].entdata ) )
    {
        return undefined;
    }
    
    safecircle = level.br_multi_circle.circles[ index ].entdata.safeent;
    safecircleorigin = ( safecircle.origin[ 0 ], safecircle.origin[ 1 ], 0 );
    safecircleradius = safecircle.origin[ 2 ];
    
    if ( isdefined( bufferdist ) )
    {
        safecircleradius += bufferdist;
    }
    
    if ( distance2dsquared( safecircleorigin, origin ) < safecircleradius * safecircleradius )
    {
        return 1;
    }
    
    return 0;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0xf5d
// Size: 0x6b, Type: bool
function function_27779e30fe4c0d62( origin )
{
    if ( !istrue( level.var_2df69b8e552238b6 ) )
    {
        return false;
    }
    
    multicirclecount = function_d987886bb9de9137();
    
    if ( function_29e8194ff7e13e2e() )
    {
        multicirclecount = 1;
    }
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        issafe = function_783961b002f33360( origin, i );
        
        if ( istrue( issafe ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 3
// Checksum 0x0, Offset: 0xfd1
// Size: 0x5f, Type: bool
function function_77cec84f05ca9418( point1, point2, bufferdist )
{
    multicirclecount = function_d987886bb9de9137();
    
    for ( i = 0; i < multicirclecount ; i++ )
    {
        if ( function_d277283fb9ad5d46( point1, i ) && function_d277283fb9ad5d46( point2, i ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0
// Checksum 0x0, Offset: 0x1039
// Size: 0x68
function function_de2f1b656ee04ba9()
{
    multicirclecount = function_d987886bb9de9137();
    
    if ( multicirclecount > 1 )
    {
        var_f2c46154d60d119b = [];
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            safeorigin = function_799fe4ee850f911( i );
            var_f2c46154d60d119b[ var_f2c46154d60d119b.size ] = safeorigin;
        }
        
        return var_f2c46154d60d119b;
    }
    
    safeorigin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    return [ safeorigin ];
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0
// Checksum 0x0, Offset: 0x10a9
// Size: 0x68
function function_54798383fa7f572b()
{
    multicirclecount = function_d987886bb9de9137();
    
    if ( multicirclecount > 1 )
    {
        var_5960287de2e9eb0d = [];
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            saferadius = function_8a985543e6853bbd( i );
            var_5960287de2e9eb0d[ var_5960287de2e9eb0d.size ] = saferadius;
        }
        
        return var_5960287de2e9eb0d;
    }
    
    saferadius = scripts\mp\gametypes\br_circle::getsafecircleradius();
    return [ saferadius ];
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0
// Checksum 0x0, Offset: 0x1119
// Size: 0x68
function function_7d381171eae99b77()
{
    multicirclecount = function_d987886bb9de9137();
    
    if ( multicirclecount > 1 )
    {
        var_c86bc952d8cc7c15 = [];
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            dangerorigin = function_755c691f70eafe3b( i );
            var_c86bc952d8cc7c15[ var_c86bc952d8cc7c15.size ] = dangerorigin;
        }
        
        return var_c86bc952d8cc7c15;
    }
    
    dangerorigin = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    return [ dangerorigin ];
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0
// Checksum 0x0, Offset: 0x1189
// Size: 0x68
function function_bf15a5aa7e72aee9()
{
    multicirclecount = function_d987886bb9de9137();
    
    if ( multicirclecount > 1 )
    {
        var_18a9373b09ac2fb7 = [];
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            dangerradius = function_a835b5dff878f77( i );
            var_18a9373b09ac2fb7[ var_18a9373b09ac2fb7.size ] = dangerradius;
        }
        
        return var_18a9373b09ac2fb7;
    }
    
    dangerradius = scripts\mp\gametypes\br_circle::getdangercircleradius();
    return [ dangerradius ];
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0x11f9
// Size: 0x3d
function function_a465e3c1371d7dab( point )
{
    if ( istrue( level.br_circle_disabled ) )
    {
        return 1;
    }
    
    if ( scripts\mp\gametypes\br_circle_util::function_d987886bb9de9137() > 1 )
    {
        return function_27779e30fe4c0d62( point );
    }
    
    return scripts\mp\gametypes\br_circle::ispointincurrentsafecircle( point );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 2
// Checksum 0x0, Offset: 0x123e
// Size: 0x47
function ispointindangercircle( point, gracedistance )
{
    if ( istrue( level.br_circle_disabled ) )
    {
        return 1;
    }
    
    if ( scripts\mp\gametypes\br_circle_util::function_d987886bb9de9137() > 1 )
    {
        return ispointinmulticircledanger( point, gracedistance );
    }
    
    return scripts\mp\gametypes\br_circle::function_c11714256f856e10( point, gracedistance );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 2
// Checksum 0x0, Offset: 0x128d
// Size: 0x98, Type: bool
function function_d30c8f0e5abea93b( point, var_3643ff40cde29f03 )
{
    if ( !isdefined( var_3643ff40cde29f03 ) )
    {
        var_3643ff40cde29f03 = 0;
    }
    
    if ( isdefined( level.exclusionzones ) )
    {
        foreach ( zone in level.exclusionzones )
        {
            if ( var_3643ff40cde29f03 == function_704a7fe0058bba45( zone ) )
            {
                var_75faff8af3dda5b6 = function_92b7f40b735f689f( zone, point );
                
                if ( var_75faff8af3dda5b6 )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0x132e
// Size: 0x1e
function function_1339532e8e759d4b( time )
{
    return round( time * 1000, getframeduration() ) / 1000;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0x1355
// Size: 0x16
function function_9da6ea6196cc9cd3( time )
{
    return round( time, getframeduration() );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0
// Checksum 0x0, Offset: 0x1374
// Size: 0xa0
function function_d12a7c7251710cbf()
{
    totaltime = 0;
    
    for ( i = 0; i < level.br_level.br_circleclosetimes.size ; i++ )
    {
        totaltime += level.br_level.br_circleclosetimes[ i ];
    }
    
    for ( i = 0; i < level.br_level.br_circledelaytimes.size ; i++ )
    {
        totaltime += level.br_level.br_circledelaytimes[ i ];
    }
    
    logstring( "br_circle_util::logTotalMatchTime = " + totaltime + " seconds" );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 2
// Checksum 0x0, Offset: 0x141c
// Size: 0x552
function function_60951b84c58915ab( testpoint, var_ff696ac4914036ee )
{
    if ( scripts\mp\gametypes\br_gametypes::isfeatureenabled( "customGametypeCircles" ) )
    {
        flags::gameflagwait( "customGametypeCirclesInit" );
    }
    
    if ( !isdefined( var_ff696ac4914036ee ) )
    {
        var_ff696ac4914036ee = 0;
    }
    
    times = [];
    
    if ( istrue( level.var_2df69b8e552238b6 ) )
    {
        circleinfo = level.br_multi_circle;
    }
    else
    {
        circleinfo = spawnstruct();
        circleinfo.circles[ 0 ] = spawnstruct();
        circleinfo.circles[ 0 ].circlecenters = level.br_level.br_circlecenters;
    }
    
    if ( !isdefined( circleinfo.circles[ 0 ].circlecenters ) )
    {
        return times;
    }
    
    var_704247244350db70 = getdvarint( @"hash_a1a57a6447657ccf", 1 ) != 0;
    
    for ( multicirclecount = 0; multicirclecount < circleinfo.circles.size ; multicirclecount++ )
    {
        currenttime = 0;
        circlecenters = circleinfo.circles[ multicirclecount ].circlecenters;
        
        for ( i = 0; i < circlecenters.size - 1 ; i++ )
        {
            if ( scripts\mp\gametypes\br_circle::function_d6f728b66bd3966( i ) )
            {
                var_df03e2e71962e81b = level.br_level.var_af96b25973d3fe7e[ i ].var_c517615f66fdfc88;
                var_8bbdb8905c9834e = level.br_level.var_af96b25973d3fe7e[ i ].var_a38cece927aa04a8;
                
                for ( var_752dff205e471b6d = var_df03e2e71962e81b; var_752dff205e471b6d <= var_8bbdb8905c9834e ; var_752dff205e471b6d++ )
                {
                    segmenttime = level.br_level.var_9ca5e77c0ae08bab[ var_752dff205e471b6d ];
                    currentorigin = level.br_level.var_7c07216db79b7ecf[ var_752dff205e471b6d ];
                    nextorigin = level.br_level.var_7c07216db79b7ecf[ var_752dff205e471b6d + 1 ];
                    currentradius = level.br_level.var_c91272f3a25f1a9c[ var_752dff205e471b6d ];
                    nextradius = level.br_level.var_c91272f3a25f1a9c[ var_752dff205e471b6d + 1 ];
                    ts = findcircleintersecttimesforpoint( testpoint, currentorigin, currentradius, nextorigin, nextradius, i );
                    
                    for ( j = 0; j < ts.size ; j++ )
                    {
                        ts[ j ].time = currenttime + segmenttime * ts[ j ].time;
                        times[ times.size ] = ts[ j ];
                    }
                    
                    currenttime += segmenttime;
                }
                
                continue;
            }
            
            currentorigin = circlecenters[ i ];
            nextorigin = circlecenters[ i + 1 ];
            currentradius = level.br_level.br_circleradii[ i ];
            nextradius = level.br_level.br_circleradii[ i + 1 ];
            prewaittime = level.br_level.br_circledelaytimes[ i ];
            closetime = level.br_level.br_circleclosetimes[ i ];
            
            if ( var_704247244350db70 )
            {
                prewaittime = function_1339532e8e759d4b( prewaittime );
                closetime = function_1339532e8e759d4b( closetime );
            }
            
            currenttime += scripts\mp\gametypes\br_multi_circle::function_16f6a495317c109d();
            currenttime += prewaittime;
            ts = findcircleintersecttimesforpoint( testpoint, currentorigin, currentradius, nextorigin, nextradius, i );
            
            for ( j = 0; j < ts.size ; j++ )
            {
                ts[ j ].time = currenttime + closetime * ts[ j ].time;
                times[ times.size ] = ts[ j ];
            }
            
            currenttime += closetime;
        }
    }
    
    timessorted = scripts\mp\utility\script::quicksort( times, &function_71b56c961304206d );
    entercount = 0;
    
    for ( multicirclecount = 0; multicirclecount < circleinfo.circles.size ; multicirclecount++ )
    {
        circlecenters = circleinfo.circles[ multicirclecount ].circlecenters;
        dist = distance2d( testpoint, circlecenters[ 0 ] );
        
        if ( dist < level.br_level.br_circleradii[ 0 ] )
        {
            entercount++;
        }
    }
    
    times = [];
    times[ 0 ] = function_a0662c2865628336( 0, ter_op( entercount > 0, 0, 1 ), -1 );
    
    for ( i = 0; i < timessorted.size ; i++ )
    {
        addtime = 0;
        state = timessorted[ i ].state;
        
        if ( state == 0 )
        {
            addtime = entercount == 0;
            entercount++;
        }
        else
        {
            assert( state == 1 );
            entercount--;
            addtime = entercount == 0;
        }
        
        if ( addtime )
        {
            times[ times.size ] = timessorted[ i ];
            
            if ( var_ff696ac4914036ee > 0 && times.size > 2 )
            {
                deltatime = times[ times.size - 1 ].time - times[ times.size - 2 ].time;
                
                if ( deltatime <= var_ff696ac4914036ee )
                {
                    times[ times.size - 1 ] = undefined;
                    times[ times.size - 1 ] = undefined;
                }
            }
        }
    }
    
    return times;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0x1977
// Size: 0x25
function gettimetilldangerforpoint( testpoint )
{
    times = function_60951b84c58915ab( testpoint );
    return function_7d8550b9a2c52852( times );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0x19a5
// Size: 0x14
function function_7d8550b9a2c52852( times )
{
    return function_97dc13fd8de003a( times, 1 );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0x19c2
// Size: 0x25
function function_f487a2a306e21bdb( testpoint )
{
    times = function_60951b84c58915ab( testpoint );
    return function_169347c7de51f088( times );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0x19f0
// Size: 0x13
function function_169347c7de51f088( times )
{
    return function_97dc13fd8de003a( times, 0 );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 2
// Checksum 0x0, Offset: 0x1a0c
// Size: 0xe9
function function_97dc13fd8de003a( times, state )
{
    if ( !isdefined( times ) || times.size == 0 )
    {
        if ( state == 1 )
        {
            return 2147483647;
        }
        else
        {
            return 0;
        }
    }
    
    circlestarttime = level.br_circle.circleinittime;
    
    if ( !isdefined( circlestarttime ) )
    {
        circlestarttime = gettime();
    }
    
    var_f17b39dcb7f8fc64 = ( gettime() - circlestarttime ) / 1000;
    time_index = 0;
    
    for ( i = 1; i < times.size ; i++ )
    {
        if ( times[ i ].time <= var_f17b39dcb7f8fc64 )
        {
            time_index = i;
        }
    }
    
    if ( times[ time_index ].state == state )
    {
        return 0;
    }
    
    if ( time_index == times.size - 1 )
    {
        return 999999;
    }
    
    return times[ time_index + 1 ].time - var_f17b39dcb7f8fc64;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 2
// Checksum 0x0, Offset: 0x1afd
// Size: 0x3f
function function_d5cf183ee258befb( testpoint, offsetsec )
{
    if ( br_gametypes::isfeaturedisabled( "circle" ) )
    {
        return -1;
    }
    
    times = function_60951b84c58915ab( testpoint );
    return function_ae20efd2c4b04628( times, offsetsec );
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 2
// Checksum 0x0, Offset: 0x1b45
// Size: 0xf0
function function_ae20efd2c4b04628( times, offsetsec )
{
    if ( !isdefined( offsetsec ) )
    {
        offsetsec = 0;
    }
    
    circlestarttime = level.br_circle.circleinittime;
    
    if ( !isdefined( circlestarttime ) )
    {
        circlestarttime = gettime();
    }
    
    var_f17b39dcb7f8fc64 = ( gettime() - circlestarttime ) / 1000 + offsetsec;
    time_index = 0;
    
    for ( i = 1; i < times.size ; i++ )
    {
        if ( times[ i ].time <= var_f17b39dcb7f8fc64 )
        {
            time_index = i;
        }
    }
    
    if ( times[ time_index ].state == 1 )
    {
        return times[ time_index ].circleindex;
    }
    
    if ( time_index == times.size - 1 )
    {
        return ( level.br_level.br_circleradii.size - 1 );
    }
    
    return times[ time_index + 1 ].circleindex;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x1c3d
// Size: 0x54
function private function_a0662c2865628336( time, state, circleindex )
{
    s = spawnstruct();
    s.time = time;
    s.state = state;
    s.circleindex = circleindex;
    return s;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1c9a
// Size: 0x52, Type: bool
function private function_71b56c961304206d( left, right )
{
    if ( left.time == right.time )
    {
        return ( left.state == 0 );
    }
    
    return left.time <= right.time;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0x1cf5
// Size: 0x3e7
function function_6ec3b4c4b5a9edd( time )
{
    starttime = level.br_circle.circleinittime;
    
    if ( !isdefined( starttime ) )
    {
        return undefined;
    }
    
    if ( istrue( level.var_2df69b8e552238b6 ) )
    {
        circleinfo = level.br_multi_circle;
    }
    else
    {
        circleinfo = spawnstruct();
        circleinfo.circles[ 0 ] = spawnstruct();
        circleinfo.circles[ 0 ].circlecenters = level.br_level.br_circlecenters;
    }
    
    circlelist = [];
    
    for ( multicirclecount = 0; multicirclecount < circleinfo.circles.size ; multicirclecount++ )
    {
        deltaseconds = ( time - starttime ) / 1000;
        circledata = spawnstruct();
        circlecenters = circleinfo.circles[ multicirclecount ].circlecenters;
        
        for ( i = 0; i < circlecenters.size - 1 ; i++ )
        {
            if ( scripts\mp\gametypes\br_circle::function_d6f728b66bd3966( i ) )
            {
                var_df03e2e71962e81b = level.br_level.var_af96b25973d3fe7e[ i ].var_c517615f66fdfc88;
                var_8bbdb8905c9834e = level.br_level.var_af96b25973d3fe7e[ i ].var_a38cece927aa04a8;
                
                for ( var_752dff205e471b6d = var_df03e2e71962e81b; var_752dff205e471b6d <= var_8bbdb8905c9834e ; var_752dff205e471b6d++ )
                {
                    segmenttime = level.br_level.var_9ca5e77c0ae08bab[ var_752dff205e471b6d ];
                    currentorigin = level.br_level.var_7c07216db79b7ecf[ var_752dff205e471b6d ];
                    nextorigin = level.br_level.var_7c07216db79b7ecf[ var_752dff205e471b6d + 1 ];
                    currentradius = level.br_level.var_c91272f3a25f1a9c[ var_752dff205e471b6d ];
                    nextradius = level.br_level.var_c91272f3a25f1a9c[ var_752dff205e471b6d + 1 ];
                    deltaseconds -= segmenttime;
                    
                    if ( deltaseconds <= 0 )
                    {
                        frac = ( deltaseconds + segmenttime ) / segmenttime;
                        frac = clamp( frac, 0, 1 );
                        circledata.origin = vectorlerp( currentorigin, nextorigin, frac );
                        circledata.radius = math::lerp( currentradius, nextradius, frac );
                        break;
                    }
                }
                
                continue;
            }
            
            currentorigin = circlecenters[ i ];
            currentradius = level.br_level.br_circleradii[ i ];
            deltaseconds -= level.br_level.br_circledelaytimes[ i ];
            
            if ( deltaseconds <= 0 )
            {
                circledata.origin = currentorigin;
                circledata.radius = currentradius;
                break;
            }
            
            closetime = level.br_level.br_circleclosetimes[ i ];
            deltaseconds -= closetime;
            
            if ( deltaseconds <= 0 )
            {
                frac = ( deltaseconds + closetime ) / closetime;
                frac = clamp( frac, 0, 1 );
                nextorigin = circlecenters[ i + 1 ];
                circledata.origin = vectorlerp( currentorigin, nextorigin, frac );
                nextradius = level.br_level.br_circleradii[ i + 1 ];
                circledata.radius = math::lerp( currentradius, nextradius, frac );
                break;
            }
        }
        
        if ( deltaseconds > 0 )
        {
            circledata.origin = circlecenters[ circlecenters.size - 1 ];
            circledata.radius = level.br_level.br_circleradii[ circlecenters.size - 1 ];
        }
        
        circlelist[ multicirclecount ] = circledata;
    }
    
    return circlelist;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0
// Checksum 0x0, Offset: 0x20e5
// Size: 0x188
function function_8e779f490bbd1ae9()
{
    if ( getdvarint( @"hash_cb361ca8aa1b869f", 0 ) == 0 )
    {
        return;
    }
    
    for ( oldparams = function_a3920e4ddd93cf3(); true ; oldparams = newparams )
    {
        level waittill( "br_circle_set" );
        newparams = function_a3920e4ddd93cf3();
        
        if ( newparams.strength <= 0 )
        {
            oldparams = newparams;
            continue;
        }
        
        var_d04962fa7f3ef6a1 = gettime();
        var_a9e9a1c18405739c = var_d04962fa7f3ef6a1 + 10000;
        
        while ( gettime() < var_a9e9a1c18405739c )
        {
            progress = ( gettime() - var_d04962fa7f3ef6a1 ) / 10000;
            strength = scripts\engine\math::lerp( oldparams.strength, newparams.strength, progress );
            radius = scripts\engine\math::lerp( oldparams.radius, newparams.radius, progress );
            function_2eb76cbe682595c3( vectorlerp( oldparams.origin, newparams.origin, progress ), radius + 2000, radius + 5000, 0, 4000, strength / 2, strength, 0.35, 1 );
            wait 1;
        }
        
        function_2eb76cbe682595c3( newparams.origin, newparams.radius + 2000, newparams.radius + 5000, 0, 4000, newparams.strength / 2, newparams.strength, 0.35, 1 );
    }
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x2275
// Size: 0x10d
function private function_a3920e4ddd93cf3()
{
    struct = spawnstruct();
    struct.origin = scripts\mp\gametypes\br_public::droptogroundmultitrace( scripts\mp\gametypes\br_circle::getsafecircleorigin() );
    struct.radius = scripts\mp\gametypes\br_circle::getsafecircleradius();
    circlesleft = level.br_level.br_circleclosetimes.size - level.br_circle.circleindex - 1;
    
    switch ( circlesleft )
    {
        case 0:
            struct.strength = 300;
            break;
        case 1:
            struct.strength = 200;
            break;
        case 2:
            struct.strength = 100;
            break;
        case 3:
            struct.strength = 50;
            break;
        default:
            struct.strength = 0;
            break;
    }
    
    return struct;
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 2
// Checksum 0x0, Offset: 0x238b
// Size: 0x12a
function function_62c8ef916090a2c( var_1bfc048b9cb49482, var_4643546cfff620a5 )
{
    function_f913ed6ea80cce0d();
    
    if ( !level.var_da89dff7e3009777.size )
    {
        return;
    }
    
    var_c1427c3606becd8d = ( level.var_779cd9f4c4324154 + 1 ) % level.var_da89dff7e3009777.size;
    var_85a812a8e488e444 = level.var_da89dff7e3009777[ var_c1427c3606becd8d ].stringref;
    var_f94237d8c14e730d = scripts\mp\gametypes\br_public::droptogroundmultitrace( var_1bfc048b9cb49482, 0, -1000 );
    level.circle_reroller = spawn( "script_model", var_f94237d8c14e730d );
    
    if ( isdefined( var_4643546cfff620a5 ) )
    {
        level.circle_reroller.angles = var_4643546cfff620a5;
    }
    
    level.circle_reroller setmodel( "jup_usa_electronics_casino_slot_machine_01" );
    level.circle_reroller makeusable();
    level.circle_reroller setuseholdduration( "duration_short" );
    level.circle_reroller sethintstring( &"MP_BR_INGAME/DEV_CIRCLE_REROLLER" );
    level.circle_reroller sethintstringparams( var_85a812a8e488e444 );
    level.circle_reroller thread function_aa86aebc45c3ebca();
    level.circle_reroller thread function_9c170550c16f8876();
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0
// Checksum 0x0, Offset: 0x24bd
// Size: 0x3d
function function_f913ed6ea80cce0d()
{
    if ( !isdefined( level.var_779cd9f4c4324154 ) )
    {
        level.var_779cd9f4c4324154 = -1;
    }
    
    if ( !isdefined( level.var_da89dff7e3009777 ) || !level.var_da89dff7e3009777.size )
    {
        br_circle::function_72cbdb2550894694();
    }
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 1
// Checksum 0x0, Offset: 0x2502
// Size: 0x191
function function_aa86aebc45c3ebca( var_dfd8829dea17d4f5 )
{
    level endon( "game_ended" );
    self endon( "death" );
    
    while ( true )
    {
        self waittill( "trigger", player );
        level.var_779cd9f4c4324154 = ( level.var_779cd9f4c4324154 + 1 ) % level.var_da89dff7e3009777.size;
        level.br_circle.br_finalcircleoverride = level.var_da89dff7e3009777[ level.var_779cd9f4c4324154 ].origin;
        var_c1427c3606becd8d = ( level.var_779cd9f4c4324154 + 1 ) % level.var_da89dff7e3009777.size;
        var_85a812a8e488e444 = level.var_da89dff7e3009777[ var_c1427c3606becd8d ].stringref;
        self sethintstring( &"MP_BR_INGAME/DEV_CIRCLE_REROLLER" );
        self sethintstringparams( var_85a812a8e488e444 );
        debugplayer = player;
        
        if ( !isdefined( player ) )
        {
            debugplayer = level.player;
        }
        
        /#
            debugplayer iprintlnbold( "<dev string:x3e>" + level.var_779cd9f4c4324154 + "<dev string:x56>" + level.var_da89dff7e3009777[ level.var_779cd9f4c4324154 ].name + "<dev string:x71>" );
        #/
        
        scripts\mp\gametypes\br_circle::applycirclesettings();
        level thread scripts\mp\gametypes\br_circle::_precalcsafecirclecenters( level.br_circle.br_finalcircleoverride );
        level thread scripts\mp\gametypes\br_multi_circle::function_e71987651701448a();
        
        if ( scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined( "createC130PathStruct" ) )
        {
            level.infilstruct.c130pathstruct = scripts\mp\gametypes\br_gametypes::runbrgametypefunc( "createC130PathStruct" );
        }
    }
}

// Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
// Params 0
// Checksum 0x0, Offset: 0x269b
// Size: 0x1d
function function_9c170550c16f8876()
{
    level endon( "game_ended" );
    waitframe();
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    self delete();
}

/#

    // Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
    // Params 0
    // Checksum 0x0, Offset: 0x26c0
    // Size: 0x19b, Type: dev
    function savecircles()
    {
        println( "<dev string:x76>" );
        println( "<dev string:xc6>" );
        
        for ( i = 0; i < level.br_level.br_circlecenters.size ; i++ )
        {
            origin = level.br_level.br_circlecenters[ i ];
            println( "<dev string:xca>" + i + "<dev string:xef>" + origin + "<dev string:xf8>" );
            waitframe();
        }
        
        println( "<dev string:xc6>" );
        
        for ( i = 0; i < level.br_level.br_circleradii.size ; i++ )
        {
            radius = level.br_level.br_circleradii[ i ];
            println( "<dev string:xfd>" + i + "<dev string:xef>" + radius + "<dev string:xf8>" );
            waitframe();
        }
        
        println( "<dev string:xc6>" );
        multicirclecount = function_d987886bb9de9137();
        
        for ( i = 0; i < multicirclecount ; i++ )
        {
            for ( j = 0; j < level.br_level.br_circlecenters.size ; j++ )
            {
                origin = level.br_multi_circle.circles[ i ].circlecenters[ j ];
                println( "<dev string:x120>" + i + "<dev string:x143>" + j + "<dev string:xef>" + origin + "<dev string:xf8>" );
                waitframe();
            }
        }
        
        println( "<dev string:xc6>" );
        println( "<dev string:x159>" );
    }

    // Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x2863
    // Size: 0x1b3, Type: dev
    function private function_aedaba3e159e8c05()
    {
        hiddenobjects = [];
        
        foreach ( var_9e32462039c9c7e6 in level.var_10235f171d93edcf )
        {
            if ( var_9e32462039c9c7e6.ishidden )
            {
                continue;
            }
            
            if ( !ispointinmulticircledanger( var_9e32462039c9c7e6.origin ) )
            {
                var_203649144dd03679 = default_to( var_9e32462039c9c7e6.lastupdatetime, 0 );
                var_73c1a1ff05a9f5f1 = default_to( var_9e32462039c9c7e6.var_73c1a1ff05a9f5f1, 0 );
                currenttime = gettime();
                var_9e32462039c9c7e6.lastupdatetime = currenttime;
                var_9e32462039c9c7e6.var_73c1a1ff05a9f5f1 = level.br_circle.circleindex;
                frametime = getframeduration();
                var_9078892b0c08d622 = currenttime - var_203649144dd03679;
                
                if ( var_9078892b0c08d622 < 1000 )
                {
                    errormsg = "<dev string:x1a9>" + var_9e32462039c9c7e6.index + "<dev string:x1c1>" + var_9078892b0c08d622 + "<dev string:x1dc>" + level.br_circle.circleindex;
                    iprintln( errormsg );
                    println( errormsg );
                    objective_icon( var_9e32462039c9c7e6.markerid, level.var_e974f0c50a18d60 );
                }
                else
                {
                    objective_icon( var_9e32462039c9c7e6.markerid, level.var_ced09ab78b42cdf0 );
                }
                
                var_9e32462039c9c7e6.ishidden = 1;
                hiddenobjects[ hiddenobjects.size ] = var_9e32462039c9c7e6;
            }
        }
        
        return hiddenobjects;
    }

    // Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x2a1e
    // Size: 0x53, Type: dev
    function private function_36c47278fdf6658d( var_9e32462039c9c7e6 )
    {
        currenttime = gettime();
        var_9e32462039c9c7e6.lastupdatetime = currenttime;
        var_9e32462039c9c7e6.ishidden = 0;
        objective_icon( var_9e32462039c9c7e6.markerid, level.var_7fe7f32e28ae88f8 );
    }

    // Namespace br_circle_util / scripts\mp\gametypes\br_circle_util
    // Params 0, eflags: 0x5
    // Checksum 0x0, Offset: 0x2a79
    // Size: 0x232, Type: dev
    function private autoexec function_30e4ecc709471035()
    {
        if ( getdvarint( @"hash_63f3c60b50f9d10", 0 ) == 0 )
        {
            return;
        }
        
        level waittill( "<dev string:x1ed>" );
        scripts\mp\gametypes\br_circle::registercirclecallbacks( 99999, undefined, &function_aedaba3e159e8c05, &function_36c47278fdf6658d, undefined );
        level.var_10235f171d93edcf = [];
        level.var_7fe7f32e28ae88f8 = "<dev string:x204>";
        level.var_ced09ab78b42cdf0 = "<dev string:x225>";
        level.var_e974f0c50a18d60 = "<dev string:x248>";
        var_377db4d1a5e868d8 = [];
        
        if ( true )
        {
            var_377db4d1a5e868d8 = [];
            xbounds = [ -31000, -16000 ];
            ybounds = [ -36000, -24000 ];
            var_8076d05d44da3c09 = 3000;
            var_addad5d4f86665fa = 3000;
            xcoord = xbounds[ 0 ];
            
            while ( xcoord <= xbounds[ 1 ] )
            {
                ycoord = ybounds[ 0 ];
                
                while ( ycoord <= ybounds[ 1 ] )
                {
                    var_377db4d1a5e868d8[ var_377db4d1a5e868d8.size ] = scripts\mp\gametypes\br_public::droptogroundmultitrace( ( xcoord, ycoord, 0 ) );
                    ycoord += var_addad5d4f86665fa;
                }
                
                xcoord += var_8076d05d44da3c09;
            }
        }
        
        var_b40ab23b53022209 = getsharedfunc( "<dev string:x264>", "<dev string:x26c>" );
        objindex = 0;
        
        while ( objindex < var_377db4d1a5e868d8.size )
        {
            level.var_10235f171d93edcf[ objindex ] = spawnstruct();
            level.var_10235f171d93edcf[ objindex ].index = objindex;
            level.var_10235f171d93edcf[ objindex ].origin = var_377db4d1a5e868d8[ objindex ];
            level.var_10235f171d93edcf[ objindex ].ishidden = 0;
            sphere( level.var_10235f171d93edcf[ objindex ].origin, 10, ( 1, 0, 1 ) );
            markerid = [[ var_b40ab23b53022209 ]]( 99 );
            objective_state( markerid, "<dev string:x282>" );
            objective_icon( markerid, level.var_7fe7f32e28ae88f8 );
            objective_position( markerid, level.var_10235f171d93edcf[ objindex ].origin );
            level.var_10235f171d93edcf[ objindex ].markerid = markerid;
            objindex += 1;
        }
    }

#/
