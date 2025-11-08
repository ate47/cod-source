#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\hostmigration;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\game_utility_mp;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;

#namespace outofbounds;

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x3f5
// Size: 0x4a
function registerentforoob( ent, ref )
{
    ent.oobref = ref;
    
    /#
        ignoreoob = getdvarint( @"hash_d197b236ea8564e", 0 );
        
        if ( ignoreoob )
        {
            scripts\mp\outofbounds::enableoobimmunity( ent );
        }
    #/
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x447
// Size: 0x16
function deregisterentforoob( ent )
{
    ent.oobref = undefined;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x465
// Size: 0x34
function registeroobentercallback( ref, callback )
{
    struct = getoobdata();
    struct.entercallbacks[ ref ] = callback;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x4a1
// Size: 0x34
function registeroobexitcallback( ref, callback )
{
    struct = getoobdata();
    struct.exitcallbacks[ ref ] = callback;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x4dd
// Size: 0x34
function registerooboutoftimecallback( ref, callback )
{
    struct = getoobdata();
    struct.outoftimecallbacks[ ref ] = callback;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x519
// Size: 0x34
function registeroobclearcallback( ref, callback )
{
    struct = getoobdata();
    struct.clearcallbacks[ ref ] = callback;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x555
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x5ac
// Size: 0x7a
function enableoob( ent )
{
    if ( !isdefined( ent.oob ) )
    {
        ent.oob = 0;
    }
    
    ent.oob++;
    
    if ( !isdefined( ent.oobimmunity ) || ent.oobimmunity <= 0 )
    {
        onenteroob( ent );
    }
    
    if ( isdefined( ent.ontouchoob ) )
    {
        [[ ent.ontouchoob ]]( ent );
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x62e
// Size: 0xa1
function disableoob( ent )
{
    if ( !isdefined( ent.oob ) )
    {
        return;
    }
    
    assertex( isdefined( ent.oob ), "<dev string:x1c>" );
    assertex( ent.oob > 0, "<dev string:x5a>" );
    ent.oob--;
    
    if ( ent.oob == 0 )
    {
        ent.oob = undefined;
    }
    
    if ( !isdefined( ent.oobimmunity ) || ent.oobimmunity <= 0 )
    {
        onexitoob( ent, 0 );
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x6d7
// Size: 0x28, Type: bool
function isoobimmune( ent )
{
    return isdefined( ent.oobimmunity ) && ent.oobimmunity > 0;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x708
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x77d
// Size: 0x8f
function disableoobimmunity( ent )
{
    assertex( isdefined( ent.oobimmunity ), "<dev string:x83>" );
    assertex( ent.oobimmunity > 0, "<dev string:xcd>" );
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x814
// Size: 0x1d3
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
    ent.oobtype = undefined;
    
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 0
// Checksum 0x0, Offset: 0x9ef
// Size: 0xa9, Type: bool
function istouchingoobtrigger()
{
    if ( isdefined( level.var_5d435d19e6cdf0b5 ) && istrue( self [[ level.var_5d435d19e6cdf0b5 ]]() ) )
    {
        return true;
    }
    
    if ( istrue( self.allowedintrigger ) )
    {
        return false;
    }
    
    if ( !isdefined( level.outofboundstriggers ) )
    {
        return false;
    }
    
    foreach ( trigger in level.outofboundstriggers )
    {
        if ( !scripts\mp\outofbounds::interactswithgivenoobtrigger( trigger, self ) )
        {
            continue;
        }
        
        if ( self istouching( trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0xaa1
// Size: 0xdc
function ispointinoutofbounds( pointtocheck, teamtocheck )
{
    if ( isdefined( level.var_29977dc303738053 ) && istrue( [[ level.var_29977dc303738053 ]]( pointtocheck, teamtocheck ) ) )
    {
        return 1;
    }
    
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 0
// Checksum 0x0, Offset: 0xb86
// Size: 0x29
function initoob()
{
    thread watchoobtriggers();
    val::group_register( "enterOOB", [ "killstreaks", "supers" ] );
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0xbb7
// Size: 0x2ec
function onenteroob( ent )
{
    var_aadbc2b08cd0c218 = [];
    trigger = self;
    
    if ( !isdefined( trigger ) )
    {
        trigger = self;
    }
    
    triggertype = gettriggertype( ent, trigger );
    
    if ( isplayer( ent ) )
    {
        var_aadbc2b08cd0c218[ var_aadbc2b08cd0c218.size ] = &playerentercallback;
    }
    
    if ( isdefined( ent.oobref ) )
    {
        struct = getoobdata();
        var_aadbc2b08cd0c218[ var_aadbc2b08cd0c218.size ] = struct.entercallbacks[ ent.oobref ];
    }
    
    ent notify( "oob_cooldown_end" );
    
    if ( isdefined( ent.oobtimeleft ) && previouslytouchedtriggertype( ent, triggertype ) && !isdefined( ent.vehicle ) )
    {
        outofboundstime = ent.oobtimeleft / 1000;
        ent.oobendtime = int( gettime() + ent.oobtimeleft );
        ent.oobtimeleft = undefined;
        thread watchooboutoftime( ent, outofboundstime );
    }
    else
    {
        outofboundstime = getoutofboundstime( triggertype );
        
        if ( isplayer( ent ) && isdefined( ent.vehicle ) && isdefined( ent.vehicle.oobendtime ) )
        {
            outofboundstime = ( ent.vehicle.oobendtime - gettime() ) / 1000;
        }
        else if ( isdefined( ent.oobtimeleft ) )
        {
            outofboundstime = min( ent.oobtimeleft / 1000, outofboundstime );
        }
        else if ( isdefined( ent.oobendtime ) )
        {
            outofboundstime = min( ( ent.oobendtime - gettime() ) / 1000, outofboundstime );
        }
        
        ent.oobtimeleft = undefined;
        ent.oobtriggertype = triggertype;
        ent.oobendtime = int( gettime() + outofboundstime * 1000 );
        thread watchooboutoftime( ent, outofboundstime );
    }
    
    foreach ( cb in var_aadbc2b08cd0c218 )
    {
        if ( isdefined( cb ) )
        {
            ent thread [[ cb ]]( "exit_oob", "clear_oob", triggertype );
        }
    }
    
    if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isdefined( ent.streakinfo ) )
    {
        occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( ent );
        
        foreach ( occupant in occupants )
        {
            onenteroobtrigger( self, occupant );
        }
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 3
// Checksum 0x0, Offset: 0xeab
// Size: 0x1eb
function onexitoob( ent, fromdeath, fromclear )
{
    trigger = self;
    ent notify( "exit_oob" );
    exitcallback = undefined;
    
    if ( !isdefined( ent.oob ) )
    {
        ent notify( "oob_timeout_end" );
        
        if ( isplayer( ent ) )
        {
            exitcallback = &playerexitcallback;
        }
        else if ( isdefined( ent.oobref ) )
        {
            struct = getoobdata();
            exitcallback = struct.exitcallbacks[ ent.oobref ];
        }
        
        if ( !istrue( fromclear ) )
        {
            if ( isdefined( ent.oobendtime ) )
            {
                ent.oobtimeleft = int( max( 0, ent.oobendtime - gettime() ) );
                ent.oobendtime = undefined;
                triggertype = gettriggertype( ent, trigger );
                cooldowntime = getcooldowntime( triggertype );
                thread watchoobcooldown( ent, cooldowntime );
            }
        }
    }
    
    if ( isdefined( exitcallback ) )
    {
        ent thread [[ exitcallback ]]( fromdeath, fromclear, "clear_oob" );
    }
    
    if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isdefined( ent.streakinfo ) )
    {
        occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( ent );
        
        foreach ( occupant in occupants )
        {
            if ( isdefined( occupant ) )
            {
                onexitoobtrigger( trigger, occupant );
            }
        }
    }
    
    level callback::callback( #"hash_51b5835095bd776a", { #fromclear:fromclear, #fromdeath:fromdeath, #trigger:trigger, #ent:ent } );
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x109e
// Size: 0xc4
function onooboutoftime( ent )
{
    outoftimecallback = undefined;
    
    if ( isplayer( ent ) )
    {
        var_775c9a68f9c00019 = 1;
        
        if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
        {
            if ( istrue( level.infilcinematicactive ) )
            {
                var_775c9a68f9c00019 = 0;
            }
            else if ( isdefined( level.matchcountdowntime ) && level.matchcountdowntime < 2 )
            {
                var_775c9a68f9c00019 = 0;
            }
        }
        
        if ( var_775c9a68f9c00019 )
        {
            outoftimecallback = &playeroutoftimecallback;
        }
    }
    else if ( isdefined( ent.oobref ) )
    {
        struct = getoobdata();
        outoftimecallback = struct.outoftimecallbacks[ ent.oobref ];
    }
    
    if ( isdefined( outoftimecallback ) )
    {
        ent thread [[ outoftimecallback ]]( "oob_timeout_end", "clear_oob" );
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x116a
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x11c0
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 3
// Checksum 0x0, Offset: 0x1223
// Size: 0xad
function playerentercallback( exitnotify, clearnotify, triggertype )
{
    var_49e84ec5d8aa4f0a = function_c6aa39a55c49dc1( triggertype );
    self.oobtype = var_49e84ec5d8aa4f0a;
    self setclientomnvar( "ui_out_of_bounds_type", var_49e84ec5d8aa4f0a );
    self setclientomnvar( "ui_out_of_bounds_countdown", self.oobendtime );
    val::group_set( "enterOOB", 0 );
    
    if ( isdefined( self.offhandweapon ) && self isthrowinggrenade() && scripts\mp\utility\weapon::issuperweapon( self.offhandweapon ) )
    {
        self canceloffhands();
    }
    
    if ( !isdefined( self.vehicle ) )
    {
        thread function_39c5bd55494a224b();
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 3
// Checksum 0x0, Offset: 0x12d8
// Size: 0x58
function playerexitcallback( fromdeath, fromclear, clearnotify )
{
    self setclientomnvar( "ui_out_of_bounds_type", 0 );
    self setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    val::group_reset( "enterOOB" );
    
    if ( istrue( self.var_f9b51be13b8defc ) )
    {
        self.var_f9b51be13b8defc = undefined;
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x1338
// Size: 0x6e
function playeroutoftimecallback( timeoutendnotify, clearnotify )
{
    trigger = getlastoobtrigger( self );
    triggertype = gettriggertype( self, trigger );
    
    if ( triggertype == "minefield" )
    {
        thread playeroutoftimeminefield( timeoutendnotify, clearnotify );
        return;
    }
    
    self.oobdeath = 1;
    _suicide( undefined, 1 );
    self.oobdeath = undefined;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x13ae
// Size: 0x25
function playerclearcallback( clearnotify )
{
    self setclientomnvar( "ui_out_of_bounds_type", 0 );
    self setclientomnvar( "ui_out_of_bounds_countdown", 0 );
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x13db
// Size: 0xe4
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 3
// Checksum 0x0, Offset: 0x14c7
// Size: 0x77, Type: bool
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
    
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( 0.3 );
    mine setscriptablepartstate( "explosion", "on", 0 );
    wait 0.05;
    self dodamage( 2000, self.origin, self, mine, "MOD_EXPLOSIVE", "minefield_mp" );
    return true;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 0
// Checksum 0x0, Offset: 0x1547
// Size: 0x45
function function_39c5bd55494a224b()
{
    self endon( "death_or_disconnect" );
    self endon( "exit_oob" );
    self waittill( "vehicle_enter" );
    
    if ( isdefined( self.vehicle ) && !scripts\common\vehicle::function_a0f7306fc3c08ecf( self.vehicle, 1 ) )
    {
        self.var_f9b51be13b8defc = 1;
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 0
// Checksum 0x0, Offset: 0x1594
// Size: 0x62
function checkinvalidoobtriggers()
{
    foreach ( trigger in self.oobtriggers )
    {
        if ( !function_4badb9b6ac027b93( self, trigger ) )
        {
            onexitoobtrigger( trigger, self );
        }
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 3
// Checksum 0x0, Offset: 0x15fe
// Size: 0x85
function killstreakentercallback( exitnotify, clearnotify, triggertype )
{
    var_49e84ec5d8aa4f0a = function_c6aa39a55c49dc1( triggertype );
    self.oobtype = var_49e84ec5d8aa4f0a;
    
    if ( isdefined( self.owner ) && istrue( self.ispiloted ) )
    {
        self.owner setclientomnvar( "ui_out_of_bounds_type", var_49e84ec5d8aa4f0a );
        self.owner setclientomnvar( "ui_out_of_bounds_countdown", self.oobendtime );
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 3
// Checksum 0x0, Offset: 0x168b
// Size: 0x60
function killstreakexitcallback( fromdeath, fromclear, clearnotify )
{
    if ( isdefined( self.owner ) && istrue( self.ispiloted ) )
    {
        self.owner setclientomnvar( "ui_out_of_bounds_type", 0 );
        self.owner setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x16f3
// Size: 0x43
function killstreakoutoftimecallback( timeoutendnotify, clearnotify )
{
    dodamagetokillstreak( 10000, self.owner, self, self.team, self.origin, "MOD_EXPLOSIVE", "nuke_multi_mp" );
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 0
// Checksum 0x0, Offset: 0x173e
// Size: 0x47
function killstreakclearcallback()
{
    if ( isdefined( self.owner ) && istrue( self.ispiloted ) )
    {
        self.owner setclientomnvar( "ui_out_of_bounds_type", 0 );
        self.owner setclientomnvar( "ui_out_of_bounds_countdown", 0 );
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 0
// Checksum 0x0, Offset: 0x178d
// Size: 0x46
function killstreakregisteroobcallbacks()
{
    registeroobentercallback( "killstreak", &killstreakentercallback );
    registeroobexitcallback( "killstreak", &killstreakexitcallback );
    registerooboutoftimecallback( "killstreak", &killstreakoutoftimecallback );
    registeroobclearcallback( "killstreak", &killstreakclearcallback );
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 0
// Checksum 0x0, Offset: 0x17db
// Size: 0xda
function watchoobtriggers()
{
    if ( scripts\mp\utility\game::lpcfeaturegated() && !scripts\mp\utility\game_utility_mp::function_9a2fd0d19774edde() && !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        return;
    }
    
    if ( isdefined( level.outofboundstriggers ) )
    {
        foreach ( trigger in level.outofboundstriggers )
        {
            thread watchoobtrigger( trigger );
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x18bd
// Size: 0x3f
function watchoobtrigger( trigger )
{
    trigger.entstouching = [];
    
    if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        scripts\mp\flags::function_1240434f4201ac9d( "prematch_done" );
    }
    
    thread watchoobtriggerexit( trigger );
    thread watchoobtriggerenter( trigger );
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x1904
// Size: 0x4c
function watchoobtriggerenter( trigger )
{
    level endon( "game_ended" );
    level endon( "switch_oob" );
    
    while ( true )
    {
        trigger waittill( "trigger", ent );
        
        if ( !function_4badb9b6ac027b93( ent, trigger ) )
        {
            continue;
        }
        
        onenteroobtrigger( trigger, ent );
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x1958
// Size: 0x79, Type: bool
function function_4badb9b6ac027b93( ent, trigger )
{
    if ( istrue( trigger.isdisabled ) )
    {
        return false;
    }
    
    if ( isdefined( level.var_54d973dccda0ef8b ) && [[ level.var_54d973dccda0ef8b ]]( ent ) )
    {
        return false;
    }
    
    if ( isplayer( ent ) && isdefined( ent.c130 ) )
    {
        return false;
    }
    
    if ( !interactswithgivenoobtrigger( trigger, ent ) )
    {
        return false;
    }
    
    if ( !interactswithoobtriggers( ent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x19da
// Size: 0xd9
function watchoobtriggerexit( trigger )
{
    level endon( "game_ended" );
    level endon( "switch_oob" );
    var_c30cd90a1a82d688 = isent( trigger );
    
    while ( true )
    {
        temparr = trigger.entstouching;
        
        foreach ( id, ent in temparr )
        {
            if ( !isdefined( ent ) )
            {
                trigger.entstouching[ id ] = undefined;
            }
            
            if ( isdefined( ent ) && ( istrue( ent.var_f9b51be13b8defc ) || !trigger istouchingtrigger( ent, var_c30cd90a1a82d688 ) && !isdefined( ent.vehicle ) ) )
            {
                onexitoobtrigger( trigger, ent );
            }
        }
        
        waitframe();
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x1abb
// Size: 0x3a, Type: bool
function private istouchingtrigger( ent, var_994e7746ed176aec )
{
    return var_994e7746ed176aec && self istouching( ent ) || !var_994e7746ed176aec && ispointinvolume( ent.origin, self );
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 3
// Checksum 0x0, Offset: 0x1afe
// Size: 0xed
function onenteroobtrigger( trigger, ent, forceentry )
{
    entnum = ent getentitynumber();
    
    if ( isdefined( trigger.entstouching[ entnum ] ) && !istrue( forceentry ) )
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
    trigger enableoob( ent );
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x1bf3
// Size: 0x8b
function onexitoobtrigger( trigger, ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    entnum = ent getentitynumber();
    trigger.entstouching[ entnum ] = undefined;
    trigger disableoob( ent );
    
    if ( !isdefined( ent.oobtriggers ) )
    {
        return;
    }
    
    ent.oobtriggers = array_remove( ent.oobtriggers, trigger );
    
    if ( ent.oobtriggers.size == 0 )
    {
        ent.oobtriggers = undefined;
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x1c86
// Size: 0x36
function watchoobsuppressiontrigger( trigger )
{
    trigger.entstouching = [];
    scripts\mp\flags::gameflagwait( "prematch_done" );
    thread watchoobsuppressiontriggerexit( trigger );
    thread watchoobsupressiontriggerenter( trigger );
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x1cc4
// Size: 0x44
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x1d10
// Size: 0xa4
function watchoobsuppressiontriggerexit( trigger )
{
    level endon( "game_ended" );
    
    while ( true )
    {
        temparr = trigger.entstouching;
        
        if ( isdefined( temparr ) )
        {
            foreach ( id, ent in temparr )
            {
                if ( !isdefined( ent ) )
                {
                    trigger.entstouching[ id ] = undefined;
                }
                
                if ( isdefined( ent ) && !trigger istouching( ent ) )
                {
                    onexitoobsupressiontrigger( trigger, ent );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x1dbc
// Size: 0xda
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
    
    temparr = [ trigger ];
    
    foreach ( oobsuppressiontrigger in ent.oobsupressiontriggers )
    {
        temparr[ temparr.size ] = oobsuppressiontrigger;
    }
    
    ent.oobsupressiontriggers = temparr;
    enableoobimmunity( ent );
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x1e9e
// Size: 0x68
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x1f0e
// Size: 0x1e5, Type: bool
function interactswithgivenoobtrigger( trigger, ent )
{
    isvehicle = ent scripts\cp_mp\vehicles\vehicle::isvehicle();
    
    if ( isdefined( trigger.script_team ) )
    {
        if ( isgroundwarcoremode() || istrue( level.ignoreteamoob ) )
        {
            return false;
        }
        
        if ( isvehicle )
        {
            if ( isdefined( ent.team ) && ent.team != "neutral" && ent.team != trigger.script_team )
            {
                return false;
            }
            
            if ( isdefined( ent.owner ) && ent.owner.team != trigger.script_team )
            {
                return false;
            }
            
            if ( isdefined( ent.occupants ) )
            {
                foreach ( occupant in ent.occupants )
                {
                    if ( isdefined( occupant.team ) && occupant.team != trigger.script_team )
                    {
                        return false;
                    }
                }
            }
        }
        else if ( !isdefined( ent.team ) || ent.team != trigger.script_team )
        {
            return false;
        }
    }
    
    if ( isvehicle )
    {
        ref = ent scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd();
        
        if ( issharedfuncdefined( ref, "interactsWithOOBTrigger" ) )
        {
            if ( !callsharedfunc( ref, "interactsWithOOBTrigger", trigger, ent ) )
            {
                return false;
            }
        }
    }
    
    if ( isdefined( trigger.script_noteworthy ) && trigger.script_noteworthy == "onlyVehOOB" )
    {
        if ( !istrue( isvehicle ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x20fc
// Size: 0x83, Type: bool
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 0
// Checksum 0x0, Offset: 0x2188
// Size: 0x62
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x21f3
// Size: 0x4d
function iskillstreakaffectedbyobb( streakname )
{
    affectedbyobb = 0;
    
    switch ( streakname )
    {
        case #"hash_9e36e3bd3a9dd00d":
        case #"hash_cf0ef5bef19a311b":
        case #"hash_e40585107590f016":
            affectedbyobb = 1;
            break;
    }
    
    return affectedbyobb;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x2249
// Size: 0xc1
function gettriggertype( ent, trigger )
{
    triggertype = "default";
    
    if ( trigger scripts\cp_mp\vehicles\vehicle::isvehicle() )
    {
        return "vehicle";
    }
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        return "br";
    }
    
    if ( isdefined( trigger ) && isdefined( trigger.script_team ) )
    {
        return "restricted";
    }
    
    if ( isdefined( ent ) && ent scripts\cp_mp\vehicles\vehicle::isvehicle() )
    {
        return "default";
    }
    
    if ( isdefined( ent ) && isdefined( ent.streakinfo ) )
    {
        return "default";
    }
    
    if ( isdefined( trigger ) && isdefined( trigger.script_noteworthy ) && trigger.script_noteworthy == "MineField" )
    {
        triggertype = "minefield";
    }
    
    return triggertype;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x2313
// Size: 0xb0
function private function_c6aa39a55c49dc1( triggertype )
{
    oobtype = 1;
    var_7c4a4f886922a011 = 0;
    
    if ( islargemap() )
    {
        gametype = getgametype();
        
        switch ( gametype )
        {
            case #"hash_ca6516c10db2c95":
            case #"hash_5e78ea9021845d4a":
            case #"hash_7f9c384a34cc392f":
            case #"hash_9a6f07d0214a87db":
            case #"hash_c065cef60f38490a":
                var_7c4a4f886922a011 = 1;
                break;
        }
        
        if ( isgroundwarcoremode() )
        {
            var_7c4a4f886922a011 = 1;
        }
    }
    
    if ( istrue( var_7c4a4f886922a011 ) )
    {
        if ( isdefined( triggertype ) && triggertype == "restricted" )
        {
            oobtype = 2;
        }
    }
    
    return oobtype;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x23cc
// Size: 0x58
function getcooldowntime( triggertype )
{
    switch ( triggertype )
    {
        case #"hash_18ad1d5da2e56d4c":
        case #"hash_6b15362474c2e2b2":
        case #"hash_7038dec66d8275be":
        case #"hash_b9c0ff6cd406fe0f":
        case #"hash_fa21c4f6bd5e3815":
            return getmaxoutofboundscooldown();
    }
    
    return undefined;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x242d
// Size: 0x74
function getoutofboundstime( triggertype )
{
    switch ( triggertype )
    {
        case #"hash_6b15362474c2e2b2":
            return getmaxoutofboundsminefieldtime();
        case #"hash_18ad1d5da2e56d4c":
            return getmaxoutofboundsrestrictedtime();
        case #"hash_fa21c4f6bd5e3815":
            return getmaxoutofboundsbrtime();
        case #"hash_7038dec66d8275be":
            return getmaxoutofboundstime();
        case #"hash_b9c0ff6cd406fe0f":
            return function_a01d18a56c6cc1aa();
    }
    
    return undefined;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x24aa
// Size: 0x29
function getlastoobtrigger( ent )
{
    if ( isdefined( ent.oobtriggers ) )
    {
        return ent.oobtriggers[ 0 ];
    }
    
    return undefined;
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 2
// Checksum 0x0, Offset: 0x24dc
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

// Namespace outofbounds / scripts\mp\outofbounds
// Params 6
// Checksum 0x0, Offset: 0x2566
// Size: 0x9b
function function_420d6eda841fd001( triggertype, origin, angles, radius, height, drawdebug )
{
    trigger = spawn( triggertype, origin, 0, radius, height );
    trigger.angles = angles;
    level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
    
    /#
        if ( drawdebug == 1 )
        {
            thread scripts\mp\utility\debug::drawsphere( trigger.origin, radius, 1000, ( 1, 1, 0 ) );
        }
    #/
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 0
// Checksum 0x0, Offset: 0x2609
// Size: 0xa9
function function_49f55ab317da5250()
{
    drawdebug = 0;
    oobspawns = getstructarray( "OutOfBounds", "targetname" );
    
    if ( isdefined( oobspawns ) )
    {
        foreach ( oobspawn in oobspawns )
        {
            function_420d6eda841fd001( "trigger_rotatable_radius", oobspawn.origin, oobspawn.angles, oobspawn.radius, oobspawn.height, drawdebug );
        }
    }
}

// Namespace outofbounds / scripts\mp\outofbounds
// Params 1
// Checksum 0x0, Offset: 0x26ba
// Size: 0x77
function function_99d6508da7894de2( triggers )
{
    foreach ( trigger in triggers )
    {
        if ( isdefined( trigger.script_team ) )
        {
            trigger.script_team = game[ trigger.script_team ];
        }
    }
}

