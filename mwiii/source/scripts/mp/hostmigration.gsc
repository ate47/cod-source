#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\player;

#namespace hostmigration;

// Namespace hostmigration / scripts\mp\hostmigration
// Params 0
// Checksum 0x0, Offset: 0x273
// Size: 0x1d0
function callback_hostmigration()
{
    level.hostmigrationreturnedplayercount = 0;
    
    if ( level.gameended )
    {
        println( "<dev string:x1c>" + gettime() + "<dev string:x3b>" );
        return;
    }
    
    if ( analyticsstreamerislogfilestreamingenabled() )
    {
        analyticsstreamerlogfilestartstream();
    }
    
    println( "<dev string:x1c>" + gettime() );
    level thread hostmigrationconnectwatcher();
    
    foreach ( character in level.characters )
    {
        character.hostmigrationcontrolsfrozen = 0;
    }
    
    level.hostmigrationtimer = 1;
    setdvar( @"hash_a8ee1540ced18a88", 1 );
    level.hostmigration = 1;
    level notify( "host_migration_begin" );
    scripts\mp\gamelogic::updatetimerpausedness();
    
    foreach ( character in level.characters )
    {
        if ( !isdefined( character ) )
        {
            continue;
        }
        
        character thread hostmigrationtimerthink();
        
        if ( isplayer( character ) )
        {
            character setclientomnvar( "ui_session_state", character.sessionstate );
        }
    }
    
    level endon( "host_migration_begin" );
    hostmigrationwait();
    level.hostmigrationtimer = undefined;
    setdvar( @"hash_a8ee1540ced18a88", 0 );
    println( "<dev string:x65>" + gettime() );
    visionsetthermal( game[ "thermal_vision" ] );
    level.hostmigration = 0;
    level notify( "host_migration_end" );
    scripts\mp\gamelogic::updatetimerpausedness();
    level thread [[ level.updategameevents ]]();
}

// Namespace hostmigration / scripts\mp\hostmigration
// Params 0
// Checksum 0x0, Offset: 0x44b
// Size: 0x4d
function hostmigrationconnectwatcher()
{
    level endon( "host_migration_end" );
    level endon( "host_migration_begin" );
    level waittill( "connected", player );
    player thread hostmigrationtimerthink();
    
    if ( isplayer( player ) )
    {
        player setclientomnvar( "ui_session_state", player.sessionstate );
    }
}

// Namespace hostmigration / scripts\mp\hostmigration
// Params 0
// Checksum 0x0, Offset: 0x4a0
// Size: 0xe9
function hostmigrationwait()
{
    level endon( "game_ended" );
    level.ingraceperiod = 25;
    thread scripts\mp\gamelogic::matchstarttimer( "waiting_for_players", 20 );
    hostmigrationwaitforplayers();
    level.ingraceperiod = 10;
    thread scripts\mp\gamelogic::matchstarttimer( "match_resuming_in", 5 );
    wait 5;
    level.ingraceperiod = 0;
    
    foreach ( p in level.players )
    {
        p setclientomnvar( "ui_match_start_countdown", 0 );
        p setclientomnvar( "ui_match_in_progress", 1 );
    }
    
    if ( istrue( level.forfeitinprogress ) && !istrue( level.forfeit_aborted ) )
    {
        setomnvar( "ui_match_start_text", "opponent_forfeiting_in" );
    }
}

// Namespace hostmigration / scripts\mp\hostmigration
// Params 0
// Checksum 0x0, Offset: 0x591
// Size: 0xc
function hostmigrationwaitforplayers()
{
    level endon( "hostmigration_enoughplayers" );
    wait 15;
}

// Namespace hostmigration / scripts\mp\hostmigration
// Params 1
// Checksum 0x0, Offset: 0x5a5
// Size: 0xd2
function hostmigrationname( ent )
{
    if ( !isdefined( ent ) )
    {
        return "<removed_ent>";
    }
    
    entnum = -1;
    entname = "?";
    
    if ( isdefined( ent.entity_number ) )
    {
        entnum = ent.entity_number;
    }
    
    if ( isplayer( ent ) && isdefined( ent.name ) )
    {
        entname = ent.name;
    }
    
    if ( isplayer( ent ) )
    {
        return ( "player <" + entname + ">" );
    }
    
    if ( isagent( ent ) && scripts\cp_mp\utility\game_utility::isgameparticipant( ent ) )
    {
        return ( "participant agent <" + entnum + ">" );
    }
    
    if ( isagent( ent ) )
    {
        return ( "non-participant agent <" + entnum + ">" );
    }
    
    return "unknown entity <" + entnum + ">";
}

// Namespace hostmigration / scripts\mp\hostmigration
// Params 0
// Checksum 0x0, Offset: 0x680
// Size: 0x8d
function hostmigrationtimerthink_internal()
{
    level endon( "host_migration_begin" );
    level endon( "host_migration_end" );
    assertex( isdefined( self.hostmigrationcontrolsfrozen ), "<dev string:x84>" + hostmigrationname( self ) );
    
    while ( !isreallyalive( self ) )
    {
        self waittill( "spawned" );
    }
    
    println( "<dev string:xb4>" + hostmigrationname( self ) + "<dev string:xd8>" + self.hostmigrationcontrolsfrozen );
    self.hostmigrationcontrolsfrozen = 1;
    _freezecontrols( 1, undefined, "hostMigrationTimer" );
    level waittill( "host_migration_end" );
}

// Namespace hostmigration / scripts\mp\hostmigration
// Params 0
// Checksum 0x0, Offset: 0x715
// Size: 0x9a
function hostmigrationtimerthink()
{
    self endon( "disconnect" );
    assertex( isdefined( self.hostmigrationcontrolsfrozen ), "<dev string:x84>" + hostmigrationname( self ) );
    hostmigrationtimerthink_internal();
    assertex( isdefined( self.hostmigrationcontrolsfrozen ), "<dev string:x100>" + hostmigrationname( self ) );
    println( "<dev string:x127>" + hostmigrationname( self ) + "<dev string:xd8>" + self.hostmigrationcontrolsfrozen );
    
    if ( self.hostmigrationcontrolsfrozen )
    {
        _freezecontrols( 0, undefined, "hostMigrationTimer" );
        self.hostmigrationcontrolsfrozen = undefined;
    }
}

// Namespace hostmigration / scripts\mp\hostmigration
// Params 0
// Checksum 0x0, Offset: 0x7b7
// Size: 0x31
function waittillhostmigrationdone()
{
    if ( !isdefined( level.hostmigrationtimer ) )
    {
        return 0;
    }
    
    starttime = gettime();
    level waittill( "host_migration_end" );
    return gettime() - starttime;
}

// Namespace hostmigration / scripts\mp\hostmigration
// Params 1
// Checksum 0x0, Offset: 0x7f1
// Size: 0x22
function waittillhostmigrationstarts( duration )
{
    if ( isdefined( level.hostmigrationtimer ) )
    {
        return;
    }
    
    level endon( "host_migration_begin" );
    wait duration;
}

// Namespace hostmigration / scripts\mp\hostmigration
// Params 1
// Checksum 0x0, Offset: 0x81b
// Size: 0x9a
function waitlongdurationwithhostmigrationpause( duration )
{
    if ( !isdefined( duration ) || duration == 0 )
    {
        return;
    }
    
    assert( duration > 0 );
    starttime = gettime();
    endtime = gettime() + duration * 1000;
    
    while ( gettime() < endtime )
    {
        waittillhostmigrationstarts( ( endtime - gettime() ) / 1000 );
        
        if ( isdefined( level.hostmigrationtimer ) )
        {
            timepassed = waittillhostmigrationdone();
            endtime += timepassed;
        }
    }
    
    waittillhostmigrationdone();
    return gettime() - starttime;
}

// Namespace hostmigration / scripts\mp\hostmigration
// Params 2
// Checksum 0x0, Offset: 0x8be
// Size: 0x9e
function waittill_notify_or_timeout_hostmigration_pause( msg, duration )
{
    self endon( msg );
    
    if ( duration == 0 )
    {
        return;
    }
    
    assert( duration > 0 );
    starttime = gettime();
    endtime = gettime() + duration * 1000;
    
    while ( gettime() < endtime )
    {
        waittillhostmigrationstarts( ( endtime - gettime() ) / 1000 );
        
        if ( isdefined( level.hostmigrationtimer ) )
        {
            timepassed = waittillhostmigrationdone();
            endtime += timepassed;
        }
    }
    
    waittillhostmigrationdone();
    return gettime() - starttime;
}

// Namespace hostmigration / scripts\mp\hostmigration
// Params 1
// Checksum 0x0, Offset: 0x965
// Size: 0xb6
function waitlongdurationwithgameendtimeupdate( duration )
{
    if ( duration == 0 )
    {
        return;
    }
    
    assert( duration > 0 );
    starttime = gettime();
    endtime = gettime() + duration * 1000;
    
    while ( gettime() < endtime )
    {
        waittillhostmigrationstarts( ( endtime - gettime() ) / 1000 );
        
        while ( isdefined( level.hostmigrationtimer ) )
        {
            endtime += 1000;
            setgameendtime( int( endtime ) );
            wait 1;
        }
    }
    
    while ( isdefined( level.hostmigrationtimer ) )
    {
        endtime += 1000;
        setgameendtime( int( endtime ) );
        wait 1;
    }
    
    return gettime() - starttime;
}

