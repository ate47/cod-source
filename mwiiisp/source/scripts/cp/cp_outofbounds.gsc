#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_hostmigration;
#using scripts\cp\laststand;
#using scripts\cp\vehicles\vehicle_oob_cp;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace cp_outofbounds;

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x370
// Size: 0x20
function registerentforoob( ent, ref )
{
    ent.oobref = ref;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x398
// Size: 0x16
function deregisterentforoob( ent )
{
    ent.oobref = undefined;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x3b6
// Size: 0x33
function registeroobentercallback( ref, callback )
{
    struct = getoobdata();
    struct.entercallbacks[ ref ] = callback;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x3f1
// Size: 0x33
function registeroobexitcallback( ref, callback )
{
    struct = getoobdata();
    struct.exitcallbacks[ ref ] = callback;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x42c
// Size: 0x33
function registerooboutoftimecallback( ref, callback )
{
    struct = getoobdata();
    struct.outoftimecallbacks[ ref ] = callback;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x467
// Size: 0x33
function registeroobclearcallback( ref, callback )
{
    struct = getoobdata();
    struct.clearcallbacks[ ref ] = callback;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x4a2
// Size: 0x4e, Type: bool
function isoob( ent, var_3e36f415f762070e )
{
    if ( isoobimmune( ent ) )
    {
        return false;
    }
    
    if ( istrue( var_3e36f415f762070e ) && isoobimmune( ent ) )
    {
        return false;
    }
    
    return isdefined( ent.oob ) && ent.oob > 0;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x4f9
// Size: 0x6d
function enableoob( ent )
{
    if ( !isdefined( ent.oob ) )
    {
        ent.oob = 0;
    }
    
    ent.oob++;
    
    if ( ent.oob == 1 )
    {
        if ( !isdefined( ent.oobimmunity ) || ent.oobimmunity <= 0 )
        {
            onenteroob( ent );
        }
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x56e
// Size: 0x91
function disableoob( ent )
{
    assertex( isdefined( ent.oob ), "disableOOB called on an entity that was not out of bounds." );
    assertex( ent.oob > 0, "disableOOB more times than enableOOB." );
    ent.oob--;
    
    if ( ent.oob == 0 )
    {
        ent.oob = undefined;
        
        if ( !isdefined( ent.oobimmunity ) || ent.oobimmunity <= 0 )
        {
            onexitoob( ent, 0 );
        }
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x607
// Size: 0x28, Type: bool
function isoobimmune( ent )
{
    return isdefined( ent.oobimmunity ) && ent.oobimmunity > 0;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x638
// Size: 0x6d
function enableoobimmunity( ent )
{
    if ( !isdefined( ent.oobimmunity ) )
    {
        ent.oobimmunity = 0;
    }
    
    ent.oobimmunity++;
    
    if ( ent.oobimmunity == 1 )
    {
        if ( isdefined( ent.oob ) && ent.oob > 0 )
        {
            onexitoob( ent, 0 );
        }
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x6ad
// Size: 0x8f
function disableoobimmunity( ent )
{
    assertex( isdefined( ent.oobimmunity ), "disableOOBImmunity called on an entity without out of bounds immunity." );
    assertex( ent.oobimmunity > 0, "disableOOBImmunity more times than enableOOBImmunity." );
    ent.oobimmunity--;
    
    if ( ent.oobimmunity == 0 )
    {
        ent.oobimmunity = undefined;
        
        if ( isdefined( ent.oob ) && ent.oob > 0 )
        {
            onenteroob( ent );
        }
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x744
// Size: 0x1c5
function clearoob( ent, fromdeath )
{
    ent notify( "clear_oob" );
    
    if ( isoob( ent, 1 ) )
    {
        onexitoob( ent, fromdeath, 1 );
    }
    
    clearcallback = undefined;
    
    if ( isplayer( ent ) )
    {
        clearcallback = &playerclearcallback;
    }
    else if ( isdefined( ent.oobref ) )
    {
        struct = getoobdata();
        clearcallback = struct.clearcallbacks[ ent.oobref ];
    }
    
    if ( isdefined( clearcallback ) )
    {
        ent [[ clearcallback ]]();
    }
    
    ent.oobref = undefined;
    ent.oob = undefined;
    ent.oobimmunity = undefined;
    ent.oobtimeleft = undefined;
    ent.oobendtime = undefined;
    ent.oobtriggertype = undefined;
    
    if ( isdefined( ent.oobtriggers ) )
    {
        foreach ( trigger in ent.oobtriggers )
        {
            trigger.entstouching[ ent getentitynumber() ] = undefined;
        }
        
        ent.oobtriggers = undefined;
    }
    
    if ( isdefined( ent.oobsupressiontriggers ) )
    {
        foreach ( trigger in ent.oobsupressiontriggers )
        {
            trigger.entstouching[ ent getentitynumber() ] = undefined;
        }
        
        ent.oobsupressiontriggers = undefined;
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 0
// Checksum 0x0, Offset: 0x911
// Size: 0xb1
function initoob()
{
    if ( !isdefined( level.outofboundstriggers ) )
    {
        level.outofboundstriggers = [];
    }
    
    outofboundstriggers = getentarray( "OutOfBounds", "targetname" );
    
    foreach ( trigger in outofboundstriggers )
    {
        level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
    }
    
    val::group_register( "enterOOB", [ "killstreaks", "supers" ] );
    thread watchoobtriggers();
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x9ca
// Size: 0xb8
function ispointinoutofbounds( pointtocheck, teamtocheck )
{
    pointinoutofbounds = 0;
    
    if ( !isdefined( level.outofboundstriggers ) )
    {
        return pointinoutofbounds;
    }
    else
    {
        foreach ( trigger in level.outofboundstriggers )
        {
            if ( ispointinvolume( pointtocheck, trigger ) )
            {
                if ( isdefined( trigger.script_team ) && isdefined( teamtocheck ) && trigger.script_team != teamtocheck )
                {
                    continue;
                }
                
                pointinoutofbounds = 1;
                break;
            }
        }
    }
    
    return pointinoutofbounds;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0xa8b
// Size: 0x47
function add_trigger_to_oob_system( trigger )
{
    if ( isdefined( level.outofboundstriggers ) )
    {
        level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
    }
    else
    {
        level.outofboundstriggers[ 0 ] = trigger;
    }
    
    thread watchoobtrigger( trigger );
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0xada
// Size: 0x1e5
function onenteroob( ent )
{
    if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isdefined( ent.streakinfo ) )
    {
        occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( ent );
        
        foreach ( occupant in occupants )
        {
            onenteroobtrigger( self, occupant );
        }
    }
    
    entercallback = undefined;
    trigger = getlastoobtrigger( ent );
    
    if ( !isdefined( trigger ) )
    {
        trigger = self;
    }
    
    triggertype = gettriggertype( ent, trigger );
    
    if ( isplayer( ent ) )
    {
        entercallback = &playerentercallback;
    }
    else if ( isdefined( ent.oobref ) )
    {
        struct = getoobdata();
        entercallback = struct.entercallbacks[ ent.oobref ];
    }
    
    ent notify( "oob_cooldown_end" );
    
    if ( isdefined( ent.oobtimeleft ) && previouslytouchedtriggertype( ent, triggertype ) )
    {
        outofboundstime = ent.oobtimeleft / 1000;
        ent.oobendtime = int( gettime() + ent.oobtimeleft );
        ent.oobtimeleft = undefined;
        thread watchooboutoftime( ent, outofboundstime );
    }
    else
    {
        ent.oobtimeleft = undefined;
        ent.oobtriggertype = triggertype;
        outofboundstime = getoutofboundstime( triggertype );
        ent.oobendtime = int( gettime() + outofboundstime * 1000 );
        thread watchooboutoftime( ent, outofboundstime );
    }
    
    if ( isdefined( entercallback ) )
    {
        ent thread [[ entercallback ]]( "exit_oob", "clear_oob" );
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0xcc7
// Size: 0x81
function previouslytouchedtriggertype( var_7edface381884ca9, currenttriggertype )
{
    var_1b99bb6cc4aec0fe = 0;
    
    if ( isdefined( var_7edface381884ca9.oobtriggertype ) )
    {
        previoustriggertype = var_7edface381884ca9.oobtriggertype;
        
        if ( currenttriggertype == previoustriggertype )
        {
            var_1b99bb6cc4aec0fe = 1;
        }
        else if ( ( currenttriggertype == "default" || currenttriggertype == "minefield" ) && ( previoustriggertype == "default" || previoustriggertype == "minefield" ) )
        {
            var_1b99bb6cc4aec0fe = 1;
        }
    }
    
    return var_1b99bb6cc4aec0fe;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 3
// Checksum 0x0, Offset: 0xd51
// Size: 0x1a1
function onexitoob( ent, fromdeath, fromclear )
{
    if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isdefined( ent.streakinfo ) )
    {
        occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( ent );
        
        foreach ( occupant in occupants )
        {
            onexitoobtrigger( self, occupant );
        }
    }
    
    ent notify( "exit_oob" );
    exitcallback = undefined;
    
    if ( isplayer( ent ) )
    {
        exitcallback = &playerexitcallback;
    }
    else if ( isdefined( ent.oobref ) )
    {
        struct = getoobdata();
        exitcallback = struct.exitcallbacks[ ent.oobref ];
    }
    
    ent notify( "oob_timeout_end" );
    
    if ( !istrue( fromclear ) )
    {
        if ( isdefined( ent.oobendtime ) )
        {
            ent.oobtimeleft = int( max( 0, ent.oobendtime - gettime() ) );
            ent.oobendtime = undefined;
            trigger = getlastoobtrigger( ent );
            triggertype = gettriggertype( ent, trigger );
            cooldowntime = getcooldowntime( triggertype );
            thread watchoobcooldown( ent, cooldowntime );
        }
    }
    
    if ( isdefined( exitcallback ) )
    {
        ent thread [[ exitcallback ]]( fromdeath, fromclear, "clear_oob" );
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0xefa
// Size: 0xa6
function onooboutoftime( ent )
{
    outoftimecallback = undefined;
    
    if ( isdefined( ent.vehicle ) )
    {
        ent.vehicle scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_outoftimecallback( "oob_timeout_end", "clear_oob" );
    }
    else if ( isdefined( ent.oobref ) )
    {
        struct = getoobdata();
        outoftimecallback = struct.outoftimecallbacks[ ent.oobref ];
    }
    else if ( isplayer( ent ) )
    {
        outoftimecallback = &playeroutoftimecallback;
    }
    
    if ( isdefined( outoftimecallback ) )
    {
        ent thread [[ outoftimecallback ]]( "oob_timeout_end", "clear_oob" );
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0xfa8
// Size: 0x4e
function watchooboutoftime( ent, timeleft )
{
    if ( isplayer( ent ) )
    {
        ent endon( "death_or_disconnect" );
    }
    else
    {
        ent endon( "death" );
    }
    
    ent notify( "oob_timeout_end" );
    ent endon( "oob_timeout_end" );
    ent endon( "clear_oob" );
    wait timeleft;
    thread onooboutoftime( ent );
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0xffe
// Size: 0x5b
function watchoobcooldown( ent, timeleft )
{
    if ( isplayer( ent ) )
    {
        ent endon( "death_or_disconnect" );
    }
    else
    {
        ent endon( "death" );
    }
    
    ent notify( "oob_cooldown_end" );
    ent endon( "oob_cooldown_end" );
    ent endon( "clear_oob" );
    wait timeleft;
    ent.oobtimeleft = undefined;
    ent.oobtriggertype = undefined;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 0
// Checksum 0x0, Offset: 0x1061
// Size: 0x32
function function_c61001f433dfd696()
{
    self notify( "oob_last_stand" );
    self endon( "death" );
    self endon( "oob_last_stand" );
    
    while ( !scripts\cp\laststand::player_in_laststand( self ) )
    {
        wait 0.1;
    }
    
    function_ea269c0ec2ba23cd();
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 3
// Checksum 0x0, Offset: 0x109b
// Size: 0x69
function playerentercallback( exitnotify, clearnotify, triggertype )
{
    var_49e84ec5d8aa4f0a = 5;
    self.oobtype = var_49e84ec5d8aa4f0a;
    self setclientomnvar( "ui_out_of_bounds_type", var_49e84ec5d8aa4f0a );
    self setclientomnvar( "ui_out_of_bounds_countdown", self.oobendtime );
    val::group_set( "enterOOB", 0 );
    thread function_c61001f433dfd696();
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 3
// Checksum 0x0, Offset: 0x110c
// Size: 0x49
function playerexitcallback( fromdeath, fromclear, clearnotify )
{
    self setclientomnvar( "ui_out_of_bounds_type", 0 );
    self setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    val::group_reset( "enterOOB" );
    self notify( "oob_last_stand" );
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x115d
// Size: 0x56
function playeroutoftimecallback( timeoutendnotify, clearnotify )
{
    trigger = getlastoobtrigger( self );
    triggertype = gettriggertype( self, trigger );
    
    if ( triggertype == "minefield" )
    {
        thread playeroutoftimeminefield( timeoutendnotify, clearnotify );
        return;
    }
    
    function_ea269c0ec2ba23cd();
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 0
// Checksum 0x0, Offset: 0x11bb
// Size: 0x73
function function_ea269c0ec2ba23cd()
{
    self.oob = 1;
    self.shouldskiplaststand = 1;
    
    if ( scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        vehicle = scripts\cp_mp\utility\player_utility::getvehicle();
        
        if ( isdefined( vehicle ) )
        {
            vehicle scripts\cp_mp\vehicles\vehicle::vehicle_explode();
        }
    }
    
    self dodamage( self.health + 100, self.origin, undefined, undefined, "MOD_SUICIDE" );
    
    if ( scripts\cp\laststand::player_in_laststand( self ) )
    {
        self suicide();
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x1236
// Size: 0x18
function playerclearcallback( clearnotify )
{
    self setclientomnvar( "ui_out_of_bounds_countdown", 0 );
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x1256
// Size: 0xe6
function playeroutoftimeminefield( timeoutendnotify, clearnotify )
{
    minespawnpos = self.origin;
    minetrace = scripts\engine\trace::ray_trace( self.origin, self.origin - ( 0, 0, 1000 ), self );
    
    if ( isdefined( minetrace[ "hittype" ] != "hittype_none" ) && isdefined( minetrace[ "position" ] ) )
    {
        minespawnpos = minetrace[ "position" ];
    }
    
    mine = spawn( "script_model", minespawnpos );
    mine setmodel( "ks_minefield_mp" );
    mine setentityowner( self );
    mine setotherent( self );
    mine setscriptablepartstate( "warning_click", "on", 0 );
    mineexploded = playeroutoftimeminefieldinternal( mine, timeoutendnotify, clearnotify );
    
    if ( istrue( mineexploded ) )
    {
        wait 2;
    }
    
    mine delete();
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 3
// Checksum 0x0, Offset: 0x1344
// Size: 0xa3, Type: bool
function playeroutoftimeminefieldinternal( mine, timeoutendnotify, clearnotify )
{
    self endon( "death_or_disconnect" );
    
    if ( isdefined( timeoutendnotify ) )
    {
        self endon( timeoutendnotify );
    }
    
    if ( isdefined( clearnotify ) )
    {
        self endon( clearnotify );
    }
    
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause( 0.3 );
    mine setscriptablepartstate( "explosion", "on", 0 );
    self.shouldskiplaststand = 1;
    
    if ( scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        vehicle = scripts\cp_mp\utility\player_utility::getvehicle();
        
        if ( isdefined( vehicle ) )
        {
            vehicle scripts\cp_mp\vehicles\vehicle::vehicle_explode();
        }
    }
    
    self dodamage( 2000, self.origin, self, self, "MOD_EXPLOSIVE", "minefield_mp" );
    return true;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x13f0
// Size: 0x3d
function killstreakentercallback( exitnotify, clearnotify )
{
    if ( isdefined( self.owner ) )
    {
        self.owner setclientomnvar( "ui_out_of_bounds_countdown", self.oobendtime );
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 3
// Checksum 0x0, Offset: 0x1435
// Size: 0x3d
function killstreakexitcallback( fromdeath, fromclear, clearnotify )
{
    if ( isdefined( self.owner ) )
    {
        self.owner setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x147a
// Size: 0x63
function killstreakoutoftimecallback( timeoutendnotify, clearnotify )
{
    if ( issharedfuncdefined( "killstreak", "doDamageToKillstreak" ) )
    {
        self [[ getsharedfunc( "killstreak", "doDamageToKillstreak" ) ]]( 10000, self.owner, self, self.team, self.origin, "MOD_EXPLOSIVE", "nuke_mp" );
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 0
// Checksum 0x0, Offset: 0x14e5
// Size: 0x24
function killstreakclearcallback()
{
    if ( isdefined( self.owner ) )
    {
        self.owner setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 0
// Checksum 0x0, Offset: 0x1511
// Size: 0x46
function killstreakregisteroobcallbacks()
{
    registeroobentercallback( "killstreak", &killstreakentercallback );
    registeroobexitcallback( "killstreak", &killstreakexitcallback );
    registerooboutoftimecallback( "killstreak", &killstreakoutoftimecallback );
    registeroobclearcallback( "killstreak", &killstreakclearcallback );
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 0
// Checksum 0x0, Offset: 0x155f
// Size: 0xa2
function watchoobtriggers()
{
    if ( isdefined( level.outofboundstriggers ) )
    {
        for ( i = 0; i < level.outofboundstriggers.size ; i++ )
        {
            thread watchoobtrigger( level.outofboundstriggers[ i ] );
        }
        
        if ( isdefined( level.outofboundstriggerpatches ) )
        {
            foreach ( trigger in level.outofboundstriggerpatches )
            {
                thread watchoobsuppressiontrigger( trigger );
            }
        }
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x1609
// Size: 0x2a
function watchoobtrigger( trigger )
{
    trigger.entstouching = [];
    thread watchoobtriggerexit( trigger );
    thread watchoobtriggerenter( trigger );
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x163b
// Size: 0x1f3
function watchoobtriggerenter( trigger )
{
    level endon( "game_ended" );
    trigger endon( "death" );
    
    if ( isdefined( trigger.target ) )
    {
        trigger.failtrigger = getent( trigger.target, "targetname" );
        trigger.failtrigger childthread function_4ac27cf95f50d024( trigger );
    }
    
    while ( true )
    {
        trigger waittill( "trigger", ent );
        playerent = ent;
        
        /#
            if ( getdvarint( @"hash_51412b605eba83b2", 0 ) )
            {
                wait 1;
                continue;
            }
        #/
        
        if ( istrue( level.var_c3da524e90fa9fb4 ) )
        {
            wait 1;
            continue;
        }
        
        if ( isplayer( ent ) )
        {
            if ( isdefined( ent.c130 ) )
            {
                continue;
            }
        }
        
        if ( isdefined( ent.vehiclename ) && ent.vehiclename == "cruise_predator" )
        {
            if ( gettime() < ent.birthtime + 5000 )
            {
                continue;
            }
        }
        
        if ( isdefined( trigger.script_team ) )
        {
            var_5af6b346cd92a66b = 0;
            
            if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() )
            {
                var_5af6b346cd92a66b = 1;
            }
            
            if ( var_5af6b346cd92a66b && isdefined( ent.owner ) && ent.owner.team != trigger.script_team )
            {
                continue;
            }
            
            if ( !var_5af6b346cd92a66b && ent.team != trigger.script_team )
            {
                continue;
            }
        }
        
        if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() && isdefined( ent.owner ) )
        {
            playerent = ent.owner;
        }
        
        if ( ent scripts\cp_mp\killstreaks\helper_drone::ishelperdrone() && scripts\cp_mp\killstreaks\helper_drone::function_de3c015e3c7130e7( ent.helperdronetype ) )
        {
            continue;
        }
        
        if ( !interactswithoobtriggers( playerent ) )
        {
            continue;
        }
        
        onenteroobtrigger( trigger, playerent );
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x1836
// Size: 0x16d
function function_4ac27cf95f50d024( parent_trigger )
{
    self endon( "death" );
    self endon( "stop_failthread" );
    
    while ( true )
    {
        self waittill( "trigger", ent );
        playerent = ent;
        
        /#
            if ( getdvarint( @"hash_51412b605eba83b2", 0 ) )
            {
                wait 1;
                continue;
            }
        #/
        
        if ( istrue( level.var_c3da524e90fa9fb4 ) )
        {
            wait 1;
            continue;
        }
        
        if ( isplayer( ent ) )
        {
            if ( isdefined( ent.c130 ) )
            {
                continue;
            }
        }
        
        if ( isdefined( self.script_team ) )
        {
            var_5af6b346cd92a66b = 0;
            
            if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() )
            {
                var_5af6b346cd92a66b = 1;
            }
            
            if ( var_5af6b346cd92a66b && isdefined( ent.owner ) && ent.owner.team != self.script_team )
            {
                continue;
            }
            
            if ( !var_5af6b346cd92a66b && ent.team != self.script_team )
            {
                continue;
            }
        }
        
        if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() && isdefined( ent.owner ) )
        {
            playerent = ent.owner;
        }
        
        if ( !interactswithoobtriggers( playerent ) )
        {
            continue;
        }
        
        if ( isoobimmune( playerent ) )
        {
            continue;
        }
        
        playerent setclientomnvar( "ui_out_of_bounds_countdown", 0 );
        playerent notify( "oob_timeout_end" );
        thread onooboutoftime( playerent );
        break;
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x19ab
// Size: 0xa4
function watchoobtriggerexit( trigger )
{
    level endon( "game_ended" );
    trigger endon( "death" );
    
    while ( true )
    {
        temparr = trigger.entstouching;
        
        foreach ( ent in temparr )
        {
            if ( !isdefined( ent ) )
            {
                trigger.entstouching[ id ] = undefined;
            }
            
            if ( isdefined( ent ) && !trigger istouching( ent ) )
            {
                onexitoobtrigger( trigger, ent );
            }
        }
        
        waitframe();
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x1a57
// Size: 0xd9
function onenteroobtrigger( trigger, ent )
{
    entnum = ent getentitynumber();
    
    if ( isdefined( trigger.entstouching[ entnum ] ) )
    {
        return;
    }
    
    trigger.entstouching[ entnum ] = ent;
    
    if ( !isdefined( ent.oobtriggers ) )
    {
        ent.oobtriggers = [];
    }
    
    temparr = [ trigger ];
    
    foreach ( oobtrigger in ent.oobtriggers )
    {
        temparr[ temparr.size ] = oobtrigger;
    }
    
    ent.oobtriggers = temparr;
    enableoob( ent );
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x1b38
// Size: 0x73
function onexitoobtrigger( trigger, ent )
{
    entnum = ent getentitynumber();
    trigger.entstouching[ entnum ] = undefined;
    disableoob( ent );
    ent.oobtriggers = array_remove( ent.oobtriggers, trigger );
    
    if ( ent.oobtriggers.size == 0 )
    {
        ent.oobtriggers = undefined;
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x1bb3
// Size: 0x2b
function watchoobsuppressiontrigger( trigger )
{
    trigger.entstouching = [];
    wait 10;
    thread watchoobsuppressiontriggerexit();
    thread watchoobsupressiontriggerenter();
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x1be6
// Size: 0x43
function watchoobsupressiontriggerenter( trigger )
{
    level endon( "game_ended" );
    
    while ( true )
    {
        trigger waittill( "trigger", ent );
        
        if ( !interactswithoobtriggers( ent ) )
        {
            continue;
        }
        
        onenteroobsuppressiontrigger( trigger, ent );
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x1c31
// Size: 0x96
function watchoobsuppressiontriggerexit( trigger )
{
    level endon( "game_ended" );
    
    while ( true )
    {
        temparr = trigger.entstouching;
        
        foreach ( ent in temparr )
        {
            if ( !isdefined( ent ) )
            {
                trigger.entstouching[ id ] = undefined;
            }
            
            if ( !trigger istouching( ent ) )
            {
                onexitoobsupressiontrigger( trigger, ent );
            }
        }
    }
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x1ccf
// Size: 0x7d
function onenteroobsuppressiontrigger( trigger, ent )
{
    entnum = ent getentitynumber();
    
    if ( isdefined( trigger.entstouching[ entnum ] ) )
    {
        return;
    }
    
    trigger.entstouching[ entnum ] = ent;
    
    if ( !isdefined( ent.oobsupressiontriggers ) )
    {
        ent.oobsupressiontriggers = [];
    }
    
    ent.oobsupressiontriggers[ trigger getentitynumber() ] = trigger;
    enableoobimmunity( ent );
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x1d54
// Size: 0x67
function onexitoobsupressiontrigger( trigger, ent )
{
    entnum = ent getentitynumber();
    trigger.entstouching[ entnum ] = undefined;
    ent.oobsupressiontriggers[ trigger getentitynumber() ] = undefined;
    
    if ( ent.oobsupressiontriggers.size == 0 )
    {
        ent.oobsupressiontriggers = undefined;
    }
    
    disableoobimmunity( ent );
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x1dc3
// Size: 0xdb, Type: bool
function interactswithoobtriggers( ent )
{
    if ( isdefined( ent ) )
    {
        if ( isplayer( ent ) )
        {
            if ( ent scripts\cp_mp\utility\player_utility::_isalive() )
            {
                return true;
            }
        }
        
        if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() )
        {
            if ( istrue( ent.oobimmunity ) )
            {
                return false;
            }
            else if ( isdefined( ent.owner ) && isplayer( ent.owner ) )
            {
                if ( ent.owner scripts\cp_mp\utility\player_utility::_isalive() )
                {
                    return true;
                }
            }
        }
        
        if ( isdefined( ent.oobref ) )
        {
            if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() )
            {
                if ( !istrue( ent.isdestroyed ) )
                {
                    return true;
                }
            }
            
            if ( isdefined( ent.streakinfo ) && iskillstreakaffectedbyobb( ent.streakinfo.streakname ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 0
// Checksum 0x0, Offset: 0x1ea7
// Size: 0x61
function getoobdata()
{
    struct = level.oobdata;
    
    if ( !isdefined( struct ) )
    {
        struct = spawnstruct();
        struct.entercallbacks = [];
        struct.exitcallbacks = [];
        struct.outoftimecallbacks = [];
        struct.clearcallbacks = [];
        level.oobdata = struct;
    }
    
    return struct;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x1f11
// Size: 0x40
function iskillstreakaffectedbyobb( streakname )
{
    affectedbyobb = 0;
    
    switch ( streakname )
    {
        case #"hash_cf0ef5bef19a311b":
        case #"hash_e40585107590f016":
            affectedbyobb = 1;
            break;
    }
    
    return affectedbyobb;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 2
// Checksum 0x0, Offset: 0x1f5a
// Size: 0x96
function gettriggertype( ent, trigger )
{
    triggertype = "default";
    
    if ( isdefined( ent ) && ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isdefined( ent.streakinfo ) )
    {
        return "default";
    }
    
    if ( isdefined( ent ) && isdefined( ent.streakinfo ) )
    {
        return "killstreak";
    }
    
    if ( isdefined( trigger ) && isdefined( trigger.script_noteworthy ) && trigger.script_noteworthy == "MineField" )
    {
        triggertype = "minefield";
    }
    
    return triggertype;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x1ff9
// Size: 0x40
function getcooldowntime( triggertype )
{
    switch ( triggertype )
    {
        case #"hash_1cac65e1b8bf24a7":
        case #"hash_6b15362474c2e2b2":
        case #"hash_7038dec66d8275be":
            return getmaxoutofboundscooldown();
    }
    
    return undefined;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x2042
// Size: 0x4a
function getoutofboundstime( triggertype )
{
    switch ( triggertype )
    {
        case #"hash_1cac65e1b8bf24a7":
            return 10;
        case #"hash_6b15362474c2e2b2":
            return getmaxoutofboundsminefieldtime();
        case #"hash_7038dec66d8275be":
            return getmaxoutofboundstime();
    }
    
    return undefined;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x2095
// Size: 0x29
function getlastoobtrigger( ent )
{
    if ( isdefined( ent.oobtriggers ) )
    {
        return ent.oobtriggers[ 0 ];
    }
    
    return undefined;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 0
// Checksum 0x0, Offset: 0x20c7
// Size: 0x84
function getmaxoutofboundstime()
{
    if ( level.player isinvehicle() )
    {
        outofboundstime = level.var_c40a8076a9c58b32;
        
        if ( !isdefined( outofboundstime ) )
        {
            outofboundstime = max( 0, getdvarfloat( @"scr_outofboundstime", 4 ) );
            level.var_c40a8076a9c58b32 = outofboundstime;
        }
        
        return outofboundstime;
    }
    
    outofboundstime = level.outofboundstime;
    
    if ( !isdefined( outofboundstime ) )
    {
        outofboundstime = max( 0, getdvarfloat( @"scr_outofboundstime", 15 ) );
        level.outofboundstime = outofboundstime;
    }
    
    return outofboundstime;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 0
// Checksum 0x0, Offset: 0x2154
// Size: 0x58
function getmaxoutofboundscooldown()
{
    /#
        return max( 0, getdvarfloat( @"hash_1e90a42100ff3964", 3 ) );
    #/
    
    outofboundscooldown = level.outofboundscooldown;
    
    if ( !isdefined( outofboundscooldown ) )
    {
        outofboundscooldown = max( 0, getdvarfloat( @"hash_1e90a42100ff3964", 3 ) );
        level.outofboundscooldown = outofboundscooldown;
    }
    
    return outofboundscooldown;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 0
// Checksum 0x0, Offset: 0x21b5
// Size: 0x58
function getmaxoutofboundsminefieldtime()
{
    /#
        return max( 0, getdvarfloat( @"hash_e4bb2af9293410e5", 10 ) );
    #/
    
    outofboundstimeminefield = level.outofboundstimeminefield;
    
    if ( !isdefined( outofboundstimeminefield ) )
    {
        outofboundstimeminefield = max( 0, getdvarfloat( @"hash_e4bb2af9293410e5", 10 ) );
        level.outofboundstimeminefield = outofboundstimeminefield;
    }
    
    return outofboundstimeminefield;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x2216
// Size: 0x16
function function_34db328baed4337e( bool )
{
    level.var_c3da524e90fa9fb4 = !bool;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x2234
// Size: 0x15
function function_4ff3dde013cb8715( seconds )
{
    level.outofboundstime = seconds;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x2251
// Size: 0x15
function function_74fda8a1be219946( seconds )
{
    level.outofboundstimeminefield = seconds;
}

// Namespace cp_outofbounds / scripts\cp\cp_outofbounds
// Params 1
// Checksum 0x0, Offset: 0x226e
// Size: 0x15
function function_85b91de4920ec82d( seconds )
{
    level.outofboundscooldown = seconds;
}

