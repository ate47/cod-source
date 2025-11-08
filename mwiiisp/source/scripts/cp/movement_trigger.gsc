#using scripts\common\utility;
#using scripts\cp\cp_debug;
#using scripts\cp\cp_hostmigration;
#using scripts\cp\movement;
#using scripts\cp\movement_trigger;
#using scripts\cp\utility\entity;
#using scripts\cp\utility\player;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;

#namespace movement_trigger;

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x555
// Size: 0x49
function function_acbd5549e257c05f( ent, ref )
{
    ent.var_c7146296a3fd5b15 = ref;
    
    /#
        var_12e944c12ab9a51e = getdvarint( @"hash_b06f1416df9785d", 0 );
        
        if ( var_12e944c12ab9a51e )
        {
            function_b3f8ecf3b39399b7( ent );
        }
    #/
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x5a6
// Size: 0x16
function function_9b5d305b348d3802( ent )
{
    ent.var_c7146296a3fd5b15 = undefined;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x5c4
// Size: 0x33
function function_3fb9b9cf10d4f89c( ref, callback )
{
    struct = function_d7c5841ba3c7f86a();
    struct.entercallbacks[ ref ] = callback;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x5ff
// Size: 0x33
function function_6cca8c5c6d8a5b90( ref, callback )
{
    struct = function_d7c5841ba3c7f86a();
    struct.exitcallbacks[ ref ] = callback;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x63a
// Size: 0x33
function function_ac7ba0e846dbd8e( ref, callback )
{
    struct = function_d7c5841ba3c7f86a();
    struct.outoftimecallbacks[ ref ] = callback;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x675
// Size: 0x33
function function_e1bec9dcc4cd3b3( ref, callback )
{
    struct = function_d7c5841ba3c7f86a();
    struct.clearcallbacks[ ref ] = callback;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x6b0
// Size: 0x4e, Type: bool
function function_70b3ca07d4c0f3f8( ent, var_3e36f415f762070e )
{
    if ( function_b819716a1d02554d( ent ) )
    {
        return false;
    }
    
    if ( istrue( var_3e36f415f762070e ) && function_b819716a1d02554d( ent ) )
    {
        return false;
    }
    
    return isdefined( ent.movementtrigger ) && ent.movementtrigger > 0;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x707
// Size: 0x6d
function function_65c16fd9e382bfa5( ent )
{
    if ( !isdefined( ent.movementtrigger ) )
    {
        ent.movementtrigger = 0;
    }
    
    ent.movementtrigger++;
    
    if ( ent.movementtrigger >= 1 )
    {
        if ( !isdefined( ent.var_b55efc7e48cdb8ea ) || ent.var_b55efc7e48cdb8ea <= 0 )
        {
            function_e7092435542d8765( ent );
        }
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x77c
// Size: 0xb2
function function_cb19ee46faa81f4e( ent, var_d5c909837fd4deb4 )
{
    assertex( isdefined( ent.movementtrigger ), "disablemovementTrigger called on an entity that was not in the Ai Region. " );
    
    if ( !isdefined( ent.movementtrigger ) )
    {
        if ( isdefined( ent ) )
        {
        }
    }
    
    if ( !istrue( var_d5c909837fd4deb4 ) )
    {
        assertex( ent.movementtrigger > 0, "disablemovementTrigger more times than enablemovementTrigger." );
    }
    
    ent.movementtrigger--;
    
    if ( ent.movementtrigger == 0 )
    {
        ent.movementtrigger = undefined;
        
        if ( !isdefined( ent.var_b55efc7e48cdb8ea ) || ent.var_b55efc7e48cdb8ea <= 0 )
        {
            function_d695c5f1c8b04647( ent, 0 );
        }
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x836
// Size: 0x28, Type: bool
function function_b819716a1d02554d( ent )
{
    return isdefined( ent.var_b55efc7e48cdb8ea ) && ent.var_b55efc7e48cdb8ea > 0;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x867
// Size: 0x6d
function function_b3f8ecf3b39399b7( ent )
{
    if ( !isdefined( ent.var_b55efc7e48cdb8ea ) )
    {
        ent.var_b55efc7e48cdb8ea = 0;
    }
    
    ent.var_b55efc7e48cdb8ea++;
    
    if ( ent.var_b55efc7e48cdb8ea == 1 )
    {
        if ( isdefined( ent.movementtrigger ) && ent.movementtrigger > 0 )
        {
            function_d695c5f1c8b04647( ent, 0 );
        }
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x8dc
// Size: 0x8f
function function_da29a8f49c0535bc( ent )
{
    assertex( isdefined( ent.var_b55efc7e48cdb8ea ), "disablemovementTriggerImmunity called on an entity without Ai Region immunity." );
    assertex( ent.var_b55efc7e48cdb8ea > 0, "disablemovementTriggerImmunity more times than enablemovementTriggerImmunity." );
    ent.var_b55efc7e48cdb8ea--;
    
    if ( ent.var_b55efc7e48cdb8ea == 0 )
    {
        ent.var_b55efc7e48cdb8ea = undefined;
        
        if ( isdefined( ent.movementtrigger ) && ent.movementtrigger > 0 )
        {
            function_e7092435542d8765( ent );
        }
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x973
// Size: 0x1d9
function function_eaf4b556bcac2919( ent, fromdeath )
{
    ent notify( "clear_movementTrigger" );
    
    if ( function_70b3ca07d4c0f3f8( ent, 1 ) )
    {
        function_d695c5f1c8b04647( ent, fromdeath, 1 );
    }
    
    clearcallback = undefined;
    
    if ( isplayer( ent ) )
    {
        clearcallback = &playerclearcallback;
    }
    else if ( isagent( ent ) )
    {
        clearcallback = &playerclearcallback;
    }
    else if ( isdefined( ent.var_c7146296a3fd5b15 ) )
    {
        struct = function_d7c5841ba3c7f86a();
        clearcallback = struct.clearcallbacks[ ent.var_c7146296a3fd5b15 ];
    }
    
    if ( isdefined( clearcallback ) )
    {
        ent [[ clearcallback ]]();
    }
    
    ent.var_c7146296a3fd5b15 = undefined;
    ent.movementtrigger = undefined;
    ent.var_b55efc7e48cdb8ea = undefined;
    ent.var_5bbd76d99b3263cc = undefined;
    ent.var_8c09ac259b9c71cc = undefined;
    ent.var_cc69dada300d6dcc = undefined;
    
    if ( isdefined( ent.var_9a1bdb96d46fbf5 ) )
    {
        foreach ( trigger in ent.var_9a1bdb96d46fbf5 )
        {
            trigger.entstouching[ ent getentitynumber() ] = undefined;
        }
        
        ent.var_9a1bdb96d46fbf5 = undefined;
    }
    
    if ( isdefined( ent.var_7ba5c84eb36c67fe ) )
    {
        foreach ( trigger in ent.var_7ba5c84eb36c67fe )
        {
            trigger.entstouching[ ent getentitynumber() ] = undefined;
        }
        
        ent.var_7ba5c84eb36c67fe = undefined;
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 0
// Checksum 0x0, Offset: 0xb54
// Size: 0x85, Type: bool
function function_3f976d2cdf3e3bd1()
{
    if ( istrue( self.allowedintrigger ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_9a1bdb96d46fbf5 ) )
    {
        return false;
    }
    
    foreach ( trigger in level.var_9a1bdb96d46fbf5 )
    {
        if ( !function_5d67f66ee32ffaf8( trigger, self ) )
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

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0xbe2
// Size: 0xb8
function function_835c95339593d1a9( pointtocheck, teamtocheck )
{
    var_4352b6bf6ea78a79 = 0;
    
    if ( !isdefined( level.var_9a1bdb96d46fbf5 ) )
    {
        return var_4352b6bf6ea78a79;
    }
    else
    {
        foreach ( trigger in level.var_9a1bdb96d46fbf5 )
        {
            if ( ispointinvolume( pointtocheck, trigger ) )
            {
                if ( isdefined( trigger.script_team ) && isdefined( teamtocheck ) && trigger.script_team != teamtocheck )
                {
                    continue;
                }
                
                var_4352b6bf6ea78a79 = 1;
                break;
            }
        }
    }
    
    return var_4352b6bf6ea78a79;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 0
// Checksum 0x0, Offset: 0xca3
// Size: 0x14, Type: bool
function function_777c44bdfc80c0bb()
{
    return getdvarint( @"hash_7ce6917a4b3920ef", 0 ) == 1;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 0
// Checksum 0x0, Offset: 0xcc0
// Size: 0xcf
function function_fbbb9e404ce48427()
{
    /#
        create_func_ref( "<dev string:x1c>", &scripts\cp\cp_debug::draw_spawner );
    #/
    
    if ( !flag_exist( "radar_scramblers_initialized" ) )
    {
        flag_init( "radar_scramblers_initialized" );
    }
    
    if ( !flag_exist( "ready_for_region_spawning" ) )
    {
        flag_init( "ready_for_region_spawning" );
    }
    
    if ( !flag_exist( "ready_for_movement_trigger" ) )
    {
        flag_init( "ready_for_movement_trigger" );
    }
    
    if ( !isdefined( level.var_9a1bdb96d46fbf5 ) )
    {
        level.var_9a1bdb96d46fbf5 = [];
    }
    
    level.var_8d330dfec4a5260f = [ "cqb", "creep", "default" ];
    level.var_9a1bdb96d46fbf5 = array_combine( level.var_9a1bdb96d46fbf5, getentarray( "movement_trigger", "targetname" ) );
    thread function_63660d5c7f87dcae();
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 0
// Checksum 0x0, Offset: 0xd97
// Size: 0xac
function function_ada79477e276d617()
{
    if ( !flag_exist( "level_ready_for_script" ) )
    {
        flag_init( "level_ready_for_script" );
    }
    
    flag_wait( "level_ready_for_script" );
    
    if ( isdefined( level.var_fc46cd90f0a40c87 ) )
    {
        [[ level.var_fc46cd90f0a40c87 ]]();
    }
    
    if ( !isdefined( level.var_9a1bdb96d46fbf5 ) )
    {
        level.var_9a1bdb96d46fbf5 = [];
    }
    
    level.var_8d330dfec4a5260f = [ "cqb", "creep", "default" ];
    level.var_9a1bdb96d46fbf5 = array_combine( level.var_9a1bdb96d46fbf5, getentarray( "movement_trigger", "targetname" ) );
    thread function_63660d5c7f87dcae();
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0xe4b
// Size: 0x170
function function_e7092435542d8765( ent )
{
    entercallback = undefined;
    trigger = function_3fc7e9cfaac73fda( ent );
    triggertype = gettriggertype( ent, trigger );
    
    if ( isplayer( ent ) )
    {
        entercallback = &playerentercallback;
    }
    else if ( isagent( ent ) )
    {
        entercallback = &function_b2a14335ecf202f8;
    }
    else if ( isdefined( ent.var_c7146296a3fd5b15 ) )
    {
        struct = function_d7c5841ba3c7f86a();
        entercallback = struct.entercallbacks[ ent.var_c7146296a3fd5b15 ];
    }
    
    ent notify( "movementTrigger_cooldown_end" );
    
    if ( isdefined( ent.var_5bbd76d99b3263cc ) && previouslytouchedtriggertype( ent, triggertype ) )
    {
        var_35c02d7c9763f4e1 = ent.var_5bbd76d99b3263cc / 1000;
        ent.var_8c09ac259b9c71cc = int( gettime() + ent.var_5bbd76d99b3263cc );
        ent.var_5bbd76d99b3263cc = undefined;
        thread function_c6cf2aa4715357ed( ent, var_35c02d7c9763f4e1 );
    }
    else
    {
        ent.var_5bbd76d99b3263cc = undefined;
        ent.var_cc69dada300d6dcc = triggertype;
        var_35c02d7c9763f4e1 = function_44d732a7afebf0db( triggertype );
        ent.var_8c09ac259b9c71cc = int( gettime() + var_35c02d7c9763f4e1 * 1000 );
        thread function_c6cf2aa4715357ed( ent, var_35c02d7c9763f4e1 );
    }
    
    if ( isdefined( entercallback ) )
    {
        ent thread [[ entercallback ]]( "exit_movementTrigger", "clear_movementTrigger", triggertype, trigger );
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 3
// Checksum 0x0, Offset: 0xfc3
// Size: 0x139
function function_d695c5f1c8b04647( ent, fromdeath, fromclear )
{
    ent notify( "exit_movementTrigger" );
    exitcallback = undefined;
    
    if ( isplayer( ent ) )
    {
        exitcallback = &playerexitcallback;
    }
    else if ( isagent( ent ) )
    {
        exitcallback = &function_d405dee230e91b4;
    }
    else if ( isdefined( ent.var_c7146296a3fd5b15 ) )
    {
        struct = function_d7c5841ba3c7f86a();
        exitcallback = struct.exitcallbacks[ ent.var_c7146296a3fd5b15 ];
    }
    
    ent notify( "movementTrigger_timeout_end" );
    
    if ( !istrue( fromclear ) )
    {
        if ( isdefined( ent.var_8c09ac259b9c71cc ) )
        {
            ent.var_5bbd76d99b3263cc = int( max( 0, ent.var_8c09ac259b9c71cc - gettime() ) );
            ent.var_8c09ac259b9c71cc = undefined;
            trigger = function_3fc7e9cfaac73fda( ent );
            triggertype = gettriggertype( ent, trigger );
            cooldowntime = getcooldowntime( triggertype );
            thread function_b73235558aaeb3a2( ent, cooldowntime );
        }
    }
    
    if ( isdefined( exitcallback ) )
    {
        ent thread [[ exitcallback ]]( fromdeath, fromclear, "clear_movementTrigger" );
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x1104
// Size: 0xa4
function function_7487311d783befd( ent )
{
    outoftimecallback = undefined;
    
    if ( isplayer( ent ) )
    {
        var_775c9a68f9c00019 = 1;
        
        if ( var_775c9a68f9c00019 )
        {
            outoftimecallback = &playeroutoftimecallback;
        }
    }
    else if ( isagent( ent ) )
    {
        var_775c9a68f9c00019 = 1;
        
        if ( var_775c9a68f9c00019 )
        {
            outoftimecallback = &playeroutoftimecallback;
        }
    }
    else if ( isdefined( ent.var_c7146296a3fd5b15 ) )
    {
        struct = function_d7c5841ba3c7f86a();
        outoftimecallback = struct.outoftimecallbacks[ ent.var_c7146296a3fd5b15 ];
    }
    
    if ( isdefined( outoftimecallback ) )
    {
        ent thread [[ outoftimecallback ]]( "movementTrigger_timeout_end", "clear_movementTrigger" );
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x11b0
// Size: 0x4e
function function_c6cf2aa4715357ed( ent, timeleft )
{
    if ( isplayer( ent ) || isagent( ent ) )
    {
        ent endon( "death" );
    }
    
    ent notify( "movementTrigger_timeout_end" );
    ent endon( "movementTrigger_timeout_end" );
    ent endon( "clear_movementTrigger" );
    wait timeleft;
    thread function_7487311d783befd( ent );
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x1206
// Size: 0x5b
function function_b73235558aaeb3a2( ent, timeleft )
{
    if ( isplayer( ent ) || isagent( ent ) )
    {
        ent endon( "death" );
    }
    
    ent notify( "movementTrigger_cooldown_end" );
    ent endon( "movementTrigger_cooldown_end" );
    ent endon( "clear_movementTrigger" );
    wait timeleft;
    ent.var_5bbd76d99b3263cc = undefined;
    ent.var_cc69dada300d6dcc = undefined;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 4
// Checksum 0x0, Offset: 0x1269
// Size: 0x6f
function playerentercallback( exitnotify, clearnotify, triggertype, trigger )
{
    var_4f78697bef4476c0 = 1;
    
    if ( isdefined( triggertype ) && triggertype == "restricted" )
    {
        var_4f78697bef4476c0 = 2;
    }
    
    self.movement_trigger = trigger;
    
    /#
        if ( scripts\cp\movement_trigger::function_4aca25cbf5674e7() )
        {
            self iprintln( "<dev string:x29>" );
        }
    #/
    
    self notify( "movement_speed_update_request", trigger );
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 4
// Checksum 0x0, Offset: 0x12e0
// Size: 0x56
function function_b2a14335ecf202f8( exitnotify, clearnotify, triggertype, trigger )
{
    var_4f78697bef4476c0 = 1;
    
    if ( isdefined( triggertype ) && triggertype == "restricted" )
    {
        var_4f78697bef4476c0 = 2;
    }
    
    function_86afcfb8eb7bf0d2( trigger );
    self.movement_trigger = trigger;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 3
// Checksum 0x0, Offset: 0x133e
// Size: 0x99
function playerexitcallback( fromdeath, fromclear, clearnotify )
{
    self notify( "movement_speed_update_request", undefined, undefined, 1 );
    
    if ( array_contains( self.var_3f62a078d28c12e3, self.movement_trigger.script_noteworthy ) )
    {
        self.var_3f62a078d28c12e3 = array_remove( self.var_3f62a078d28c12e3, self.movement_trigger.script_noteworthy );
    }
    
    self.movement_trigger = undefined;
    
    /#
        if ( scripts\cp\movement_trigger::function_4aca25cbf5674e7() )
        {
            self iprintln( "<dev string:x52>" );
        }
    #/
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 3
// Checksum 0x0, Offset: 0x13df
// Size: 0x2c
function function_d405dee230e91b4( fromdeath, fromclear, clearnotify )
{
    self.movement_trigger = undefined;
    function_d55ed59c0ce164d3();
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x1413
// Size: 0x38
function playeroutoftimecallback( timeoutendnotify, clearnotify )
{
    trigger = function_3fc7e9cfaac73fda( self );
    triggertype = gettriggertype( self, trigger );
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x1453
// Size: 0xb
function playerclearcallback( clearnotify )
{
    
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x1466
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

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 3
// Checksum 0x0, Offset: 0x1554
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
    
    scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause( 0.3 );
    mine setscriptablepartstate( "explosion", "on", 0 );
    wait 0.05;
    self dodamage( 2000, self.origin, self, mine, "MOD_EXPLOSIVE", "minefield_mp" );
    return true;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 4
// Checksum 0x0, Offset: 0x15d4
// Size: 0xbb
function killstreakentercallback( exitnotify, clearnotify, triggertype, trigger )
{
    var_4f78697bef4476c0 = 1;
    
    if ( islargemap() && level.gametype == "arm" && isdefined( triggertype ) && triggertype == "restricted" )
    {
        var_4f78697bef4476c0 = 2;
    }
    
    if ( isdefined( self.owner ) )
    {
        if ( isplayer( self.owner ) )
        {
            self.owner playerentercallback( exitnotify, clearnotify, triggertype, trigger );
            return;
        }
        
        if ( isagent( self.owner ) )
        {
            self.owner function_b2a14335ecf202f8( exitnotify, clearnotify, triggertype, trigger );
        }
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 3
// Checksum 0x0, Offset: 0x1697
// Size: 0x73
function killstreakexitcallback( fromdeath, fromclear, clearnotify )
{
    if ( isdefined( self.owner ) )
    {
        if ( isplayer( self.owner ) )
        {
            self.owner playerexitcallback( fromdeath, fromclear, clearnotify );
            return;
        }
        
        if ( isagent( self.owner ) )
        {
            self.owner function_d405dee230e91b4( fromdeath, fromclear, clearnotify );
        }
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x1712
// Size: 0x13
function killstreakoutoftimecallback( timeoutendnotify, clearnotify )
{
    
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 0
// Checksum 0x0, Offset: 0x172d
// Size: 0x54
function killstreakclearcallback()
{
    if ( isdefined( self.owner ) )
    {
        if ( isplayer( self.owner ) )
        {
            self.owner playerclearcallback();
            return;
        }
        
        if ( isagent( self.owner ) )
        {
            self.owner playerclearcallback();
        }
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 0
// Checksum 0x0, Offset: 0x1789
// Size: 0x46
function function_2d13344310ed2a7b()
{
    function_3fb9b9cf10d4f89c( "killstreak", &killstreakentercallback );
    function_6cca8c5c6d8a5b90( "killstreak", &killstreakexitcallback );
    function_ac7ba0e846dbd8e( "killstreak", &killstreakoutoftimecallback );
    function_e1bec9dcc4cd3b3( "killstreak", &killstreakclearcallback );
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 0
// Checksum 0x0, Offset: 0x17d7
// Size: 0xc3
function function_63660d5c7f87dcae()
{
    updated_array = [];
    
    if ( isdefined( level.var_9a1bdb96d46fbf5 ) )
    {
        foreach ( trigger in level.var_9a1bdb96d46fbf5 )
        {
            thread watchmovementtriggertrigger( trigger );
        }
        
        if ( isdefined( level.var_5b706f51ffbf9302 ) )
        {
            foreach ( trigger in level.var_5b706f51ffbf9302 )
            {
                thread watchmovementtriggersuppressiontrigger( trigger );
            }
        }
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x18a2
// Size: 0x8c
function watchmovementtriggertrigger( trigger )
{
    trigger notify( "watchmovementTriggerTrigger" );
    trigger endon( "watchmovementTriggerTrigger" );
    trigger.entstouching = [];
    
    if ( isdefined( trigger.target ) )
    {
        trigger.var_3efe1b3a9ef1aba0 = getent( trigger.target, "targetname" );
        trigger.var_3efe1b3a9ef1aba0.parent_trigger = trigger;
    }
    
    scripts\mp\flags::gameflagwait( "prematch_done" );
    thread watchmovementtriggertriggerexit( trigger );
    thread watchmovementtriggertriggerenter( trigger );
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x1936
// Size: 0x83
function watchmovementtriggertriggerenter( trigger )
{
    level endon( "game_ended" );
    trigger notify( "watchmovementTriggerTriggerEnter" );
    trigger endon( "watchmovementTriggerTriggerEnter" );
    trigger endon( "death" );
    
    while ( true )
    {
        trigger waittill( "trigger", ent );
        
        if ( isplayer( ent ) && isdefined( ent.c130 ) )
        {
            continue;
        }
        
        if ( !function_5d67f66ee32ffaf8( trigger, ent ) )
        {
            continue;
        }
        
        if ( !function_77dece9a1b84cd8a( ent ) )
        {
            continue;
        }
        
        function_6bf7d3e9a6d1b183( trigger, ent );
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x19c1
// Size: 0xb3
function watchmovementtriggertriggerexit( trigger )
{
    level endon( "game_ended" );
    trigger notify( "watchmovementTriggerTriggerExit" );
    trigger endon( "watchmovementTriggerTriggerExit" );
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
                function_7d18304ae5611ce9( trigger, ent );
            }
        }
        
        waitframe();
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x1a7c
// Size: 0xd9
function function_6bf7d3e9a6d1b183( trigger, ent )
{
    entnum = ent getentitynumber();
    
    if ( isdefined( trigger.entstouching[ entnum ] ) )
    {
        return;
    }
    
    trigger.entstouching[ entnum ] = ent;
    
    if ( !isdefined( ent.var_9a1bdb96d46fbf5 ) )
    {
        ent.var_9a1bdb96d46fbf5 = [];
    }
    
    temparr = [ trigger ];
    
    foreach ( movementtriggertrigger in ent.var_9a1bdb96d46fbf5 )
    {
        temparr[ temparr.size ] = movementtriggertrigger;
    }
    
    ent.var_9a1bdb96d46fbf5 = temparr;
    function_65c16fd9e382bfa5( ent );
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x1b5d
// Size: 0x99
function function_7d18304ae5611ce9( trigger, ent )
{
    entnum = ent getentitynumber();
    trigger.entstouching[ entnum ] = undefined;
    
    if ( isdefined( ent.movementtrigger ) )
    {
        function_cb19ee46faa81f4e( ent );
    }
    
    ent notify( "clean_up_exit_threads" );
    
    if ( isdefined( ent.var_9a1bdb96d46fbf5 ) )
    {
        ent.var_9a1bdb96d46fbf5 = array_remove( ent.var_9a1bdb96d46fbf5, trigger );
        
        if ( ent.var_9a1bdb96d46fbf5.size == 0 )
        {
            ent.var_9a1bdb96d46fbf5 = undefined;
        }
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x1bfe
// Size: 0x45
function watchmovementtriggersuppressiontrigger( trigger )
{
    trigger notify( "watchmovementTriggerSuppressionTrigger" );
    trigger endon( "watchmovementTriggerSuppressionTrigger" );
    trigger.entstouching = [];
    scripts\mp\flags::gameflagwait( "prematch_done" );
    thread watchmovementtriggersuppressiontriggerexit( trigger );
    thread watchmovementtriggersupressiontriggerenter( trigger );
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x1c4b
// Size: 0x59
function watchmovementtriggersupressiontriggerenter( trigger )
{
    level endon( "game_ended" );
    trigger notify( "watchmovementTriggerSupressionTriggerEnter" );
    trigger endon( "watchmovementTriggerSupressionTriggerEnter" );
    trigger endon( "death" );
    
    while ( true )
    {
        trigger waittill( "trigger", ent );
        
        if ( !function_77dece9a1b84cd8a( ent ) )
        {
            continue;
        }
        
        function_7f94d7fd3ed90c14( trigger, ent );
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x1cac
// Size: 0xb8
function watchmovementtriggersuppressiontriggerexit( trigger )
{
    level endon( "game_ended" );
    trigger notify( "watchmovementTriggerSuppressionTriggerExit" );
    trigger endon( "watchmovementTriggerSuppressionTriggerExit" );
    trigger endon( "death" );
    
    while ( true )
    {
        temparr = trigger.entstouching;
        
        if ( isdefined( temparr ) )
        {
            foreach ( ent in temparr )
            {
                if ( !isdefined( ent ) )
                {
                    trigger.entstouching[ id ] = undefined;
                }
                
                if ( isdefined( ent ) && !trigger istouching( ent ) )
                {
                    function_aaec10f2ed573950( trigger, ent );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x1d6c
// Size: 0xd9
function function_7f94d7fd3ed90c14( trigger, ent )
{
    entnum = ent getentitynumber();
    
    if ( isdefined( trigger.entstouching[ entnum ] ) )
    {
        return;
    }
    
    trigger.entstouching[ entnum ] = ent;
    
    if ( !isdefined( ent.var_7ba5c84eb36c67fe ) )
    {
        ent.var_7ba5c84eb36c67fe = [];
    }
    
    temparr = [ trigger ];
    
    foreach ( movementtriggersuppressiontrigger in ent.var_7ba5c84eb36c67fe )
    {
        temparr[ temparr.size ] = movementtriggersuppressiontrigger;
    }
    
    ent.var_7ba5c84eb36c67fe = temparr;
    function_b3f8ecf3b39399b7( ent );
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x1e4d
// Size: 0x67
function function_aaec10f2ed573950( trigger, ent )
{
    entnum = ent getentitynumber();
    trigger.entstouching[ entnum ] = undefined;
    ent.var_7ba5c84eb36c67fe[ trigger getentitynumber() ] = undefined;
    
    if ( ent.var_7ba5c84eb36c67fe.size == 0 )
    {
        ent.var_7ba5c84eb36c67fe = undefined;
    }
    
    function_da29a8f49c0535bc( ent );
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x1ebc
// Size: 0x15d, Type: bool
function function_5d67f66ee32ffaf8( trigger, ent )
{
    if ( isdefined( trigger.script_team ) )
    {
        isvehicle = 0;
        
        if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() )
        {
            isvehicle = 1;
        }
        
        if ( isvehicle )
        {
            if ( isvehicle && isdefined( ent.team ) && ent.team != "neutral" && ent.team != trigger.script_team )
            {
                return false;
            }
            
            if ( isvehicle && isdefined( ent.owner ) && ent.owner.team != trigger.script_team )
            {
                return false;
            }
            
            if ( isvehicle && isdefined( ent.occupants ) )
            {
                foreach ( occupant in ent.occupants )
                {
                    if ( occupant.team != trigger.script_team )
                    {
                        return false;
                    }
                }
            }
        }
        else if ( ent.team != trigger.script_team )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x2022
// Size: 0x8d, Type: bool
function function_77dece9a1b84cd8a( ent )
{
    if ( isdefined( ent ) )
    {
        if ( isplayer( ent ) || isagent( ent ) )
        {
            if ( ent scripts\cp_mp\utility\player_utility::_isalive() )
            {
                return true;
            }
        }
        
        if ( isdefined( ent.var_c7146296a3fd5b15 ) )
        {
            if ( ent scripts\cp_mp\vehicles\vehicle::isvehicle() )
            {
                if ( !istrue( ent.isdestroyed ) )
                {
                    return true;
                }
            }
            
            if ( isdefined( ent.streakinfo ) && function_dc7129967ca14621( ent.streakinfo.streakname ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 0
// Checksum 0x0, Offset: 0x20b8
// Size: 0x61
function function_d7c5841ba3c7f86a()
{
    struct = level.var_2060abfe0097aa70;
    
    if ( !isdefined( struct ) )
    {
        struct = spawnstruct();
        struct.entercallbacks = [];
        struct.exitcallbacks = [];
        struct.outoftimecallbacks = [];
        struct.clearcallbacks = [];
        level.var_2060abfe0097aa70 = struct;
    }
    
    return struct;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x2122
// Size: 0x40
function function_dc7129967ca14621( streakname )
{
    var_826f8e79d9fb33f = 0;
    
    switch ( streakname )
    {
        case #"hash_cf0ef5bef19a311b":
        case #"hash_e40585107590f016":
            var_826f8e79d9fb33f = 1;
            break;
    }
    
    return var_826f8e79d9fb33f;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x216b
// Size: 0xb0
function gettriggertype( ent, trigger )
{
    triggertype = "default";
    
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

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x2224
// Size: 0x4d
function getcooldowntime( triggertype )
{
    switch ( triggertype )
    {
        case #"hash_18ad1d5da2e56d4c":
        case #"hash_6b15362474c2e2b2":
        case #"hash_7038dec66d8275be":
        case #"hash_fa21c4f6bd5e3815":
            return function_44d732a7afebf0db( triggertype );
    }
    
    return undefined;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x227a
// Size: 0x4c
function function_44d732a7afebf0db( triggertype )
{
    switch ( triggertype )
    {
        case #"hash_18ad1d5da2e56d4c":
        case #"hash_6b15362474c2e2b2":
        case #"hash_7038dec66d8275be":
        case #"hash_fa21c4f6bd5e3815":
            return function_49da3b35cc6bbb23();
    }
    
    return undefined;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 0
// Checksum 0x0, Offset: 0x22cf
// Size: 0x58
function function_49da3b35cc6bbb23()
{
    /#
        return max( 0, getdvarfloat( @"hash_433957b265bb0fab", 3 ) );
    #/
    
    var_35c02d7c9763f4e1 = level.var_35c02d7c9763f4e1;
    
    if ( !isdefined( var_35c02d7c9763f4e1 ) )
    {
        var_35c02d7c9763f4e1 = max( 0, getdvarfloat( @"hash_433957b265bb0fab", 3 ) );
        level.var_35c02d7c9763f4e1 = var_35c02d7c9763f4e1;
    }
    
    return var_35c02d7c9763f4e1;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x2330
// Size: 0x29
function function_3fc7e9cfaac73fda( ent )
{
    if ( isdefined( ent.var_9a1bdb96d46fbf5 ) )
    {
        return ent.var_9a1bdb96d46fbf5[ 0 ];
    }
    
    return undefined;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 2
// Checksum 0x0, Offset: 0x2362
// Size: 0x81
function previouslytouchedtriggertype( var_7edface381884ca9, currenttriggertype )
{
    var_1b99bb6cc4aec0fe = 0;
    
    if ( isdefined( var_7edface381884ca9.var_cc69dada300d6dcc ) )
    {
        previoustriggertype = var_7edface381884ca9.var_cc69dada300d6dcc;
        
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

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x23ec
// Size: 0xb
function function_86afcfb8eb7bf0d2( trigger )
{
    
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 0
// Checksum 0x0, Offset: 0x23ff
// Size: 0x2
function function_d55ed59c0ce164d3()
{
    
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 0
// Checksum 0x0, Offset: 0x2409
// Size: 0x1a4
function movementchangerequests()
{
    level endon( "game_ended" );
    self notify( "movementChangeRequests" );
    self endon( "movementChangeRequests" );
    self endon( "disconnect" );
    self.var_3f62a078d28c12e3 = [];
    
    while ( true )
    {
        self waittill( "movement_speed_update_request", movement_trigger, var_8d04a2d6273459eb, var_bbba777adf94982f );
        
        if ( istrue( var_bbba777adf94982f ) )
        {
            /#
                if ( scripts\cp\movement_trigger::function_4aca25cbf5674e7() )
                {
                    iprintln( "<dev string:x79>" + getdvarint( @"hash_a6dc81e1fdde75ff", 0 ) );
                }
            #/
            
            scripts\cp\movement::function_36d589dc5c4191f6();
            continue;
        }
        
        if ( !isdefined( movement_trigger ) )
        {
            assertex( isdefined( movement_trigger ), "A Valid Movement Trigger Entity MUST be passed in" );
            
            if ( !isdefined( movement_trigger ) )
            {
                continue;
            }
        }
        
        var_74da84eac189e996 = movement_trigger.script_noteworthy;
        
        if ( !function_1f20f0a1bd74a167( var_74da84eac189e996 ) )
        {
            /#
                if ( scripts\cp\movement_trigger::function_4aca25cbf5674e7() )
                {
                    if ( isdefined( var_74da84eac189e996 ) )
                    {
                        iprintln( "<dev string:xc1>" + var_74da84eac189e996 );
                    }
                    
                    iprintln( "<dev string:x79>" + getdvarint( @"hash_a6dc81e1fdde75ff", 0 ) );
                }
            #/
            
            scripts\cp\movement::function_36d589dc5c4191f6();
            continue;
        }
        
        if ( array_contains( self.var_3f62a078d28c12e3, var_74da84eac189e996 ) )
        {
            /#
                if ( scripts\cp\movement_trigger::function_4aca25cbf5674e7() )
                {
                    iprintln( "<dev string:xda>" + var_74da84eac189e996 + "<dev string:xf7>" );
                }
            #/
            
            continue;
        }
        
        self.var_3f62a078d28c12e3 = array_add( self.var_3f62a078d28c12e3, var_74da84eac189e996 );
        
        /#
            if ( scripts\cp\movement_trigger::function_4aca25cbf5674e7() )
            {
                iprintln( "<dev string:x123>" + var_74da84eac189e996 );
            }
        #/
        
        if ( isdefined( movement_trigger.script_count ) )
        {
            scripts\cp\movement::function_36d589dc5c4191f6( var_74da84eac189e996, movement_trigger.script_count );
            continue;
        }
        
        scripts\cp\movement::function_36d589dc5c4191f6( var_74da84eac189e996 );
    }
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 1
// Checksum 0x0, Offset: 0x25b5
// Size: 0x29, Type: bool
function function_1f20f0a1bd74a167( var_74da84eac189e996 )
{
    if ( !isdefined( var_74da84eac189e996 ) )
    {
        return false;
    }
    
    if ( !array_contains( level.var_8d330dfec4a5260f, var_74da84eac189e996 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace movement_trigger / scripts\cp\movement_trigger
// Params 0
// Checksum 0x0, Offset: 0x25e7
// Size: 0x13, Type: bool
function function_4aca25cbf5674e7()
{
    return getdvarint( @"hash_8a5dbccaa1343d42", 0 ) != 0;
}

