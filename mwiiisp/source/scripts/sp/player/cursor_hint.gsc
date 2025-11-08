#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\utility;

#namespace cursor_hint;

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 0
// Checksum 0x0, Offset: 0x294
// Size: 0x8a
function init_cursor_hint()
{
    setdvarifuninitialized( @"hash_7925a1f90294e6e8", 0 );
    precacheshader( "cursor_hint_circle" );
    precacheshader( "cursor_hint_x" );
    precacheshader( "cursor_hint_square" );
    precacheshader( "alien_dpad_none" );
    precacheshader( "hud_arrow_up" );
    precacheshader( "hud_interaction_prompt_center_ammo" );
    precacheshader( "hud_scrap_medium_icon_test" );
    precacheshader( "hud_interaction_prompt_center_heavy" );
    precacheshader( "hud_interaction_prompt_center_steel_dragon" );
    level.cursor_hints = [];
    level.cursor_hints_max = 1;
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 4
// Checksum 0x0, Offset: 0x326
// Size: 0x44
function function_31a9edf082d398f5( bundlename, hintstring, linktag, offsetorigin )
{
    bundle = getscriptbundle( "cursorhint:" + bundlename );
    return function_5c79b14fd1f528b0( bundle, hintstring, linktag, offsetorigin );
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 4
// Checksum 0x0, Offset: 0x373
// Size: 0x14d
function function_5c79b14fd1f528b0( parms, hintstring, linktag, offsetorigin )
{
    if ( !isdefined( parms ) )
    {
        parms = spawnstruct();
        
        /#
            iprintln( "<dev string:x1c>" );
        #/
    }
    
    if ( !isdefined( hintstring ) )
    {
        hintstring = parms.hintstring;
    }
    
    if ( !isdefined( linktag ) )
    {
        linktag = parms.linktag;
    }
    
    if ( !isdefined( offsetorigin ) )
    {
        offsetorigin = parms.offsetorigin;
        
        if ( isstruct( offsetorigin ) )
        {
            offsetorigin = ( default_to( offsetorigin.x, 0 ), default_to( offsetorigin.y, 0 ), default_to( offsetorigin.z, 0 ) );
        }
    }
    
    return create_cursor_hint( linktag, offsetorigin, hintstring, parms.displayfovoverride, parms.displaydistoverride, parms.usedistoverride, parms.ignoretrace, parms.blinkhint, parms.var_9e9b6d24b7a157f0, parms.uniqueicon, parms.holdduration, parms.usecommand, parms.lockmovement, parms.usefovoverride, parms.useanglesoverride, parms.whileencumbered );
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 16
// Checksum 0x0, Offset: 0x4c9
// Size: 0x388
function create_cursor_hint( linktag, originoffset, hintstring, displayfovoverride, displaydistoverride, usedistoverride, ignoretrace, blinkhint, var_9e9b6d24b7a157f0, uniqueicon, holdduration, usecommand, lockmovement, usefovoverride, useanglesoverride, whileencumbered )
{
    hintent = self;
    
    if ( isstruct( hintent ) || is_equal( hintent.code_classname, "script_origin" ) || isdefined( originoffset ) )
    {
        hintent = spawn( "script_origin", self.origin );
        self.cursor_hint_ent = hintent;
    }
    
    hintent makeusable();
    
    if ( isdefined( originoffset ) )
    {
        tag = "tag_origin";
        
        if ( isdefined( linktag ) )
        {
            tag = linktag;
            hintent.origin = self gettagorigin( tag );
        }
        
        if ( isdefined( self.model ) && self.classname == "script_model" && self tagexists( tag ) )
        {
            hintent linkto( self, tag, originoffset, ( 0, 0, 0 ) );
        }
        else if ( isdefined( linktag ) )
        {
            hintent linkto( self, tag, originoffset, ( 0, 0, 0 ) );
        }
        else if ( isdefined( self.angles ) )
        {
            hintent.origin += rotatevector( originoffset, self.angles );
            
            if ( isent( self ) )
            {
                hintent linkto( self );
            }
        }
        else
        {
            hintent.origin += originoffset;
            
            if ( isent( self ) )
            {
                hintent linkto( self );
            }
        }
    }
    else if ( isdefined( linktag ) )
    {
        hintent sethinttag( linktag );
    }
    
    if ( isdefined( var_9e9b6d24b7a157f0 ) && var_9e9b6d24b7a157f0 )
    {
        hintent setcursorhint( "HINT_NOICON" );
    }
    else
    {
        hintent setcursorhint( "HINT_BUTTON" );
    }
    
    if ( isdefined( hintstring ) && !in_realism_mode() )
    {
        hintent sethintstring( hintstring );
    }
    
    displayfov = 360;
    
    if ( isdefined( displayfovoverride ) )
    {
        displayfov = displayfovoverride;
    }
    
    hintent sethintdisplayfov( displayfov );
    usefov = 65;
    
    if ( isdefined( usefovoverride ) )
    {
        usefov = usefovoverride;
    }
    
    hintent setusefov( usefov );
    displayrange = 500;
    
    if ( isdefined( displaydistoverride ) )
    {
        displayrange = displaydistoverride;
    }
    
    hintent sethintdisplayrange( displayrange );
    userange = 80;
    
    if ( isdefined( usedistoverride ) )
    {
        userange = usedistoverride;
    }
    
    hintent setuserange( userange );
    
    if ( isdefined( ignoretrace ) && ignoretrace )
    {
        hintent sethintonobstruction( "show" );
    }
    else
    {
        hintent sethintonobstruction( "hide" );
    }
    
    if ( isdefined( blinkhint ) && blinkhint )
    {
        hintent sethintrequiresmashing( blinkhint );
    }
    
    if ( !isdefined( holdduration ) )
    {
        holdduration = "duration_short";
    }
    
    hintent setuseholdduration( holdduration );
    
    if ( holdduration != "duration_none" && holdduration != "duration_short" )
    {
        hintent sethintrequiresholding( 1 );
    }
    
    if ( !istrue( self.var_2962af1b05702467 ) )
    {
        thread hint_delete_on_trigger();
    }
    
    if ( isdefined( uniqueicon ) )
    {
        hintent sethinticon( uniqueicon );
    }
    
    if ( isdefined( usecommand ) )
    {
        hintent setusecommand( usecommand );
    }
    
    hintent sethintlockplayermovement( istrue( lockmovement ) );
    hintent setusewhenhandsoccupied( istrue( whileencumbered ) );
    
    if ( isdefined( useanglesoverride ) )
    {
        thread internal_hint_toggle_use_by_angles( hintent, useanglesoverride, userange );
    }
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 15
// Checksum 0x0, Offset: 0x859
// Size: 0x373
function create_cursor_hint_forced( linktag, originoffset, hintstring, displayfovoverride, displaydistoverride, usedistoverride, ignoretrace, blinkhint, var_9e9b6d24b7a157f0, uniqueicon, holdduration, usecommand, lockmovement, usefovoverride, useanglesoverride )
{
    hintent = self;
    
    if ( isstruct( hintent ) || hintent.code_classname == "script_origin" || isdefined( originoffset ) )
    {
        hintent = spawn( "script_origin", self.origin );
        self.cursor_hint_ent = hintent;
    }
    
    hintent makeusable();
    
    if ( isdefined( originoffset ) )
    {
        tag = "tag_origin";
        
        if ( isdefined( linktag ) )
        {
            tag = linktag;
            hintent.origin = self gettagorigin( tag );
        }
        
        if ( isdefined( self.model ) && self.classname == "script_model" && hastag( self.model, tag ) )
        {
            hintent linkto( self, tag, originoffset, ( 0, 0, 0 ) );
        }
        else if ( isdefined( linktag ) )
        {
            hintent linkto( self, tag, originoffset, ( 0, 0, 0 ) );
        }
        else if ( isdefined( self.angles ) )
        {
            hintent.origin += rotatevector( originoffset, self.angles );
            
            if ( isent( self ) )
            {
                hintent linkto( self );
            }
        }
        else
        {
            hintent.origin += originoffset;
            
            if ( isent( self ) )
            {
                hintent linkto( self );
            }
        }
    }
    else if ( isdefined( linktag ) )
    {
        hintent sethinttag( linktag );
    }
    
    if ( isdefined( var_9e9b6d24b7a157f0 ) && var_9e9b6d24b7a157f0 )
    {
        hintent setcursorhint( "HINT_NOICON" );
    }
    else
    {
        hintent setcursorhint( "HINT_BUTTON" );
    }
    
    if ( isdefined( hintstring ) )
    {
        hintent sethintstring( hintstring );
    }
    
    displayfov = 360;
    
    if ( isdefined( displayfovoverride ) )
    {
        displayfov = displayfovoverride;
    }
    
    hintent sethintdisplayfov( displayfov );
    usefov = 65;
    
    if ( isdefined( usefovoverride ) )
    {
        usefov = usefovoverride;
    }
    
    hintent setusefov( usefov );
    displayrange = 500;
    
    if ( isdefined( displaydistoverride ) )
    {
        displayrange = displaydistoverride;
    }
    
    hintent sethintdisplayrange( displayrange );
    userange = 80;
    
    if ( isdefined( usedistoverride ) )
    {
        userange = usedistoverride;
    }
    
    hintent setuserange( userange );
    
    if ( isdefined( ignoretrace ) && ignoretrace )
    {
        hintent sethintonobstruction( "show" );
    }
    else
    {
        hintent sethintonobstruction( "hide" );
    }
    
    if ( isdefined( blinkhint ) && blinkhint )
    {
        hintent sethintrequiresmashing( blinkhint );
    }
    
    if ( !isdefined( holdduration ) )
    {
        holdduration = "duration_short";
    }
    
    hintent setuseholdduration( holdduration );
    
    if ( holdduration != "duration_none" && holdduration != "duration_short" )
    {
        hintent sethintrequiresholding( 1 );
    }
    
    thread hint_delete_on_trigger();
    
    if ( isdefined( uniqueicon ) )
    {
        hintent sethinticon( uniqueicon );
    }
    
    if ( isdefined( usecommand ) )
    {
        hintent setusecommand( usecommand );
    }
    
    if ( isdefined( lockmovement ) )
    {
        hintent sethintlockplayermovement( 1 );
    }
    else
    {
        hintent sethintlockplayermovement( 0 );
    }
    
    if ( isdefined( useanglesoverride ) )
    {
        thread internal_hint_toggle_use_by_angles( hintent, useanglesoverride, userange );
    }
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 17
// Checksum 0x0, Offset: 0xbd4
// Size: 0x382
function function_fa06de21f8aaee3b( anime, scriptednode, linktag, originoffset, hintstring, displayfovoverride, displaydistoverride, usedistadjustment, ignoretrace, blinkhint, var_9e9b6d24b7a157f0, uniqueicon, holdduration, usecommand, lockmovement, usefovoverride, useanglesadjustment )
{
    if ( !isdefined( usedistadjustment ) )
    {
        usedistadjustment = 0;
    }
    
    if ( !isdefined( useanglesadjustment ) )
    {
        useanglesadjustment = 0;
    }
    
    if ( !isdefined( usefovoverride ) )
    {
        usefovoverride = 45;
    }
    
    rig = spawn_anim_model( "player_rig", self.origin, self.angles );
    rig hide();
    startpositions = scriptednode getanim_starts( anime, rig );
    
    /#
        hintfloor = self.origin;
        
        foreach ( position in startpositions )
        {
            if ( getdvarint( @"hash_4140c00f3efa94c6", 0 ) )
            {
                if ( isdefined( linktag ) )
                {
                    hintfloor = utility::groundpos( self gettagorigin( linktag ) );
                }
                
                line( hintfloor, position, ( 1, 1, 1 ), 1, 0, 1000 );
            }
        }
    #/
    
    lastdiff = 0;
    furthestpositions = [];
    var_d85cc836998c34dd = [];
    
    foreach ( i, startposition in startpositions )
    {
        var_d85cc836998c34dd[ var_d85cc836998c34dd.size ] = distance2d( self.origin, startposition );
        
        if ( i + 1 == startpositions.size )
        {
            startdiff = distance2d( startposition, startpositions[ 0 ] );
            
            if ( startdiff > lastdiff )
            {
                lastdiff = startdiff;
                furthestpositions[ 1 ] = startpositions[ i ];
                furthestpositions[ 0 ] = startpositions[ 0 ];
            }
            
            continue;
        }
        
        startdiff = distance2d( startposition, startpositions[ i + 1 ] );
        
        if ( startdiff > lastdiff )
        {
            lastdiff = startdiff;
            furthestpositions[ 0 ] = startpositions[ i ];
            furthestpositions[ 1 ] = startpositions[ i + 1 ];
        }
    }
    
    distave = array_average( var_d85cc836998c34dd );
    newusedist = 60 + distave + usedistadjustment;
    
    if ( startpositions.size > 1 )
    {
        var_11257a1ff69c8cf6 = 30;
        sharedpoint = self.origin;
        
        if ( isdefined( linktag ) )
        {
            sharedpoint = self gettagorigin( linktag );
        }
        
        angle = math::anglebetweenvectors( sharedpoint - furthestpositions[ 0 ], sharedpoint - furthestpositions[ 1 ] );
    }
    else
    {
        var_11257a1ff69c8cf6 = 65;
        angle = 0;
    }
    
    var_b22fa04e81595347 = var_11257a1ff69c8cf6 + angle + useanglesadjustment;
    
    /#
        if ( getdvarint( @"hash_398da46238160a6", 0 ) )
        {
            iprintln( "<dev string:x53>" + distave );
            iprintln( "<dev string:x66>" + newusedist );
            iprintln( "<dev string:x73>" + angle );
            iprintln( "<dev string:x89>" + var_b22fa04e81595347 );
        }
    #/
    
    rig delete();
    create_cursor_hint( linktag, originoffset, hintstring, displayfovoverride, displaydistoverride, newusedist, ignoretrace, blinkhint, var_9e9b6d24b7a157f0, uniqueicon, holdduration, usecommand, lockmovement, usefovoverride, var_b22fa04e81595347 );
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xf5e
// Size: 0x18d
function private internal_hint_toggle_use_by_angles( hintent, useangles, userange )
{
    assert( isdefined( self.angles ), "Trying to limit use angles for cursor hint on an ent without .angles" );
    self endon( "death" );
    self endon( "hint_destroyed" );
    level.player endon( "death" );
    could_use = 1;
    desired_dot = cos( useangles );
    
    /#
        setdvarifuninitialized( @"hash_7925a1f90294e6e8", 0 );
    #/
    
    while ( true )
    {
        origin = self.origin;
        angles = self.angles;
        fwd = anglestoforward( angles );
        nml = vectornormalize( level.player geteye() - origin );
        dot = vectordot( fwd, nml );
        can_use = dot >= desired_dot;
        
        if ( can_use != could_use )
        {
            if ( can_use )
            {
                hintent setuserange( userange );
            }
            else
            {
                hintent setuserange( 1 );
            }
            
            could_use = can_use;
        }
        
        /#
            if ( getdvarint( @"hash_7925a1f90294e6e8" ) )
            {
                thread draw_line_for_time( origin, origin + fwd * 100, 1, 1, 0, 0.05 );
                thread draw_line_for_time( origin, origin + nml * 100, ter_op( can_use, 0, 1 ), ter_op( can_use, 1, 0 ), 0, 0.05 );
                print3d( origin, acos( dot ) );
            }
        #/
        
        waitframe();
    }
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 6
// Checksum 0x0, Offset: 0x10f3
// Size: 0x41
function function_29589fff42be0668( linktag, originoffset, hintstring, hintstringheld, duration, var_4a4268457b600842 )
{
    thread function_c5ecfe572bd65fd0( linktag, originoffset, hintstring, hintstringheld, duration, var_4a4268457b600842 );
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 6, eflags: 0x4
// Checksum 0x0, Offset: 0x113c
// Size: 0x61
function private function_c5ecfe572bd65fd0( linktag, originoffset, hintstring, hintstringheld, duration, var_4a4268457b600842 )
{
    thread create_cursor_hint( linktag, originoffset, hintstring );
    triggered = function_4d0a70b3e87a01cd();
    
    if ( !istrue( triggered ) )
    {
        return;
    }
    
    thread function_1202cd03e8123816( hintstringheld, duration, var_4a4268457b600842 );
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x11a5
// Size: 0x41
function private function_1202cd03e8123816( hintstringheld, duration, var_4a4268457b600842 )
{
    waittillframeend();
    
    if ( isdefined( var_4a4268457b600842 ) )
    {
        showhint = function_b8de3859f8626aaa( var_4a4268457b600842 );
        
        if ( !istrue( showhint ) )
        {
            return;
        }
    }
    
    function_cbb6e098f3e2d086( duration );
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x11ee
// Size: 0x18, Type: bool
function private function_b8de3859f8626aaa( var_4a4268457b600842 )
{
    self endon( "hint_destroyed" );
    self waittill( var_4a4268457b600842 );
    return true;
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x120f
// Size: 0x100
function private function_cbb6e098f3e2d086( duration )
{
    self endon( "hint_destroyed" );
    self.holding = undefined;
    counter = 0;
    holdcounter = 15;
    
    while ( true )
    {
        washolding = istrue( self.holding );
        
        if ( level.player usebuttonpressed() )
        {
            counter += 1;
        }
        else
        {
            counter = 0;
        }
        
        if ( isdefined( duration ) && counter >= duration * 20 + holdcounter )
        {
            break;
        }
        
        if ( counter >= holdcounter )
        {
            self.holding = 1;
            level.player playrumbleonentity( "light_1s" );
        }
        else
        {
            self.holding = undefined;
        }
        
        if ( istrue( self.holding ) && !washolding )
        {
            self notify( "hold_start" );
        }
        else if ( !istrue( self.holding ) && washolding )
        {
            self notify( "hold_stop" );
        }
        
        waitframe();
    }
    
    self notify( "hold_complete" );
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 0
// Checksum 0x0, Offset: 0x1317
// Size: 0x41
function hint_delete_on_trigger()
{
    self endon( "hint_destroyed" );
    hintent = self;
    
    if ( isdefined( self.cursor_hint_ent ) )
    {
        hintent = self.cursor_hint_ent;
    }
    
    function_7ac69d749cd3da7a( hintent );
    
    if ( isdefined( self ) )
    {
        remove_cursor_hint();
    }
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 1
// Checksum 0x0, Offset: 0x1360
// Size: 0x34
function function_7ac69d749cd3da7a( hintent )
{
    self endon( "entitydeleted" );
    hintent waittill( "trigger", other );
    
    if ( hintent != self )
    {
        self notify( "trigger", other );
    }
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 0
// Checksum 0x0, Offset: 0x139c
// Size: 0x4e
function remove_cursor_hint()
{
    hintent = self;
    
    if ( isdefined( self.cursor_hint_ent ) )
    {
        hintent = self.cursor_hint_ent;
        hintent delete();
        self notify( "hint_destroyed" );
        return;
    }
    
    if ( !isstruct( hintent ) )
    {
        hintent makeunusable();
    }
    
    self notify( "hint_destroyed" );
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 0
// Checksum 0x0, Offset: 0x13f2
// Size: 0x1a
function hint_waittill_trigger()
{
    triggerent = monitor_interact_delay( self, "stand" );
    return triggerent;
}

// Namespace cursor_hint / scripts\sp\player\cursor_hint
// Params 0
// Checksum 0x0, Offset: 0x1415
// Size: 0x33, Type: bool
function function_4d0a70b3e87a01cd()
{
    self endon( "hint_destroyed" );
    
    if ( isdefined( self.cursor_hint_ent ) )
    {
        self.cursor_hint_ent waittill( "trigger" );
    }
    else
    {
        self waittill( "trigger" );
    }
    
    return true;
}

