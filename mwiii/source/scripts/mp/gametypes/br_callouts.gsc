#using scripts\engine\utility;

#namespace br_callouts;

// Namespace br_callouts / scripts\mp\gametypes\br_callouts
// Params 0
// Checksum 0x0, Offset: 0xa3
// Size: 0x4c6
function init()
{
    level.calloutglobals.namelocations = [];
    
    if ( !istrue( level.calloutglobals.var_41e0068712e63739 ) && !isdefined( level.calloutglobals.calloutlist ) && ( !isdefined( level.calloutglobals.callouttable ) || !tableexists( level.calloutglobals.callouttable ) ) )
    {
        return;
    }
    
    minx = level.mapcorners[ 0 ].origin[ 0 ];
    maxx = level.mapcorners[ 1 ].origin[ 0 ];
    sizex = maxx - minx;
    miny = level.mapcorners[ 0 ].origin[ 1 ];
    maxy = level.mapcorners[ 1 ].origin[ 1 ];
    sizey = maxy - miny;
    
    if ( istrue( level.calloutglobals.var_41e0068712e63739 ) )
    {
        level.calloutglobals.var_81bcc3f4c201eb = [];
        sitecount = compassregions_getsitecount( 1 );
        
        for ( siteidx = 0; siteidx < sitecount ; siteidx++ )
        {
            site = compassregions_getsite( 1, siteidx );
            region = compassregions_getregion( 1, site.region );
            ref = region.name + " site_" + siteidx;
            assertex( !isdefined( level.calloutglobals.namelocations[ ref ] ), "<dev string:x1c>" + ref + "<dev string:x2d>" + level.mapname );
            namedlocation = spawnstruct();
            namedlocation.origin = site.origin;
            level.calloutglobals.namelocations[ ref ] = namedlocation;
            level.calloutglobals.var_81bcc3f4c201eb[ siteidx ] = ref;
        }
        
        return;
    }
    
    if ( isdefined( level.calloutglobals.calloutlist ) )
    {
        foreach ( callout in level.calloutglobals.calloutlist )
        {
            if ( !istrue( callout.var_c13986eca25dd35e ) )
            {
                continue;
            }
            
            x = callout.xfrac;
            x = float( x );
            x = x * sizex + minx;
            y = callout.yfrac;
            y = float( y );
            y = y * sizey + miny;
            radius = callout.radius;
            radius = float( radius );
            ref = callout.calloutref;
            namedlocation = spawnstruct();
            namedlocation.origin = ( x, y, 0 );
            namedlocation.radius = radius;
            level.calloutglobals.namelocations[ ref ] = namedlocation;
        }
        
        return;
    }
    
    for ( row = 0; true ; row++ )
    {
        var_c13986eca25dd35e = tablelookupbyrow( level.calloutglobals.callouttable, row, 5 );
        
        if ( !isdefined( var_c13986eca25dd35e ) || var_c13986eca25dd35e == "" )
        {
            break;
        }
        
        if ( var_c13986eca25dd35e != "1" )
        {
            continue;
        }
        
        x = tablelookupbyrow( level.calloutglobals.callouttable, row, 6 );
        x = float( x );
        x = x * sizex + minx;
        y = tablelookupbyrow( level.calloutglobals.callouttable, row, 7 );
        y = float( y );
        y = y * sizey + miny;
        radius = tablelookupbyrow( level.calloutglobals.callouttable, row, 8 );
        radius = float( radius );
        ref = tablelookupbyrow( level.calloutglobals.callouttable, row, 1 );
        namedlocation = spawnstruct();
        namedlocation.origin = ( x, y, 0 );
        namedlocation.radius = radius;
        level.calloutglobals.namelocations[ ref ] = namedlocation;
    }
}

// Namespace br_callouts / scripts\mp\gametypes\br_callouts
// Params 1
// Checksum 0x0, Offset: 0x571
// Size: 0xeb
function getlocationnameforpoint( point )
{
    locname = "";
    
    if ( istrue( level.calloutglobals.var_41e0068712e63739 ) )
    {
        siteidx = compassregions_getsiteforworldorigin( 1, point );
        
        if ( isdefined( siteidx ) )
        {
            locname = level.calloutglobals.var_81bcc3f4c201eb[ siteidx ];
        }
    }
    else
    {
        foreach ( name, info in level.calloutglobals.namelocations )
        {
            if ( distance2dsquared( point, info.origin ) <= info.radius * info.radius )
            {
                locname = name;
                break;
            }
        }
    }
    
    return locname;
}

/#

    // Namespace br_callouts / scripts\mp\gametypes\br_callouts
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x665
    // Size: 0xd6, Type: dev
    function private function_758c08865c2c0b()
    {
        if ( istrue( level.calloutglobals.var_41e0068712e63739 ) )
        {
            compassregions_drawdiagram( 0, 1 );
            return;
        }
        
        foreach ( ref, loc in level.calloutglobals.namelocations )
        {
            scripts\engine\utility::draw_circle( loc.origin, loc.radius, ( 1, 1, 0 ), 1, 0, 1 );
            debugstar( loc.origin, ( 1, 1, 0 ), 1, ref, 1 );
        }
    }

    // Namespace br_callouts / scripts\mp\gametypes\br_callouts
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x743
    // Size: 0x17e, Type: dev
    function private function_59ff91039ae7cc92()
    {
        showtablets = isdefined( level.questinfo ) && isdefined( level.questinfo.debuginfo ) && isdefined( level.questinfo.debuginfo.locationtablets );
        
        foreach ( ref, loc in level.calloutglobals.namelocations )
        {
            if ( showtablets && isdefined( level.questinfo.debuginfo.locationtablets[ ref ] ) )
            {
                foreach ( tablet in level.questinfo.debuginfo.locationtablets[ ref ] )
                {
                    sphere( tablet.origin, 30, ( 1, 0, 0 ) );
                    line( tablet.origin, loc.origin, ( 1, 0, 0 ) );
                }
            }
        }
    }

    // Namespace br_callouts / scripts\mp\gametypes\br_callouts
    // Params 0
    // Checksum 0x0, Offset: 0x8c9
    // Size: 0x4e, Type: dev
    function function_1d1637db14bbc7d1()
    {
        if ( istrue( level.var_d55be984182fdc3 ) )
        {
            level.var_d55be984182fdc3 = 0;
            level notify( "<dev string:x48>" );
            return;
        }
        
        level endon( "<dev string:x48>" );
        level.var_d55be984182fdc3 = 1;
        
        while ( true )
        {
            function_758c08865c2c0b();
            function_59ff91039ae7cc92();
            waitframe();
        }
    }

#/
