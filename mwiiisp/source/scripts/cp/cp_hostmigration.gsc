#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;

#namespace cp_hostmigration;

// Namespace cp_hostmigration / scripts\cp\cp_hostmigration
// Params 0
// Checksum 0x0, Offset: 0x246
// Size: 0x57
function hostmigrationwait()
{
    level endon( "game_ended" );
    level.ingraceperiod = 25;
    thread matchstarttimer( "waiting_for_players", 20 );
    hostmigrationwaitforplayers();
    level.ingraceperiod = 10;
    thread matchstarttimer( "match_resuming_in", 5 );
    wait 5;
    level.ingraceperiod = 0;
}

// Namespace cp_hostmigration / scripts\cp\cp_hostmigration
// Params 0
// Checksum 0x0, Offset: 0x2a5
// Size: 0xc
function hostmigrationwaitforplayers()
{
    level endon( "hostmigration_enoughplayers" );
    wait 15;
}

// Namespace cp_hostmigration / scripts\cp\cp_hostmigration
// Params 1
// Checksum 0x0, Offset: 0x2b9
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

// Namespace cp_hostmigration / scripts\cp\cp_hostmigration
// Params 0
// Checksum 0x0, Offset: 0x394
// Size: 0x86
function hostmigrationtimerthink_internal()
{
    level endon( "host_migration_begin" );
    level endon( "host_migration_end" );
    assertex( isdefined( self.hostmigrationcontrolsfrozen ), "Not properly tracking controller frozen for " + hostmigrationname( self ) );
    
    while ( !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        self waittill( "spawned" );
    }
    
    println( "<dev string:x1c>" + hostmigrationname( self ) + "<dev string:x3d>" + self.hostmigrationcontrolsfrozen );
    self.hostmigrationcontrolsfrozen = 1;
    freezecontrolswrapper( 1 );
    level waittill( "host_migration_end" );
}

// Namespace cp_hostmigration / scripts\cp\cp_hostmigration
// Params 0
// Checksum 0x0, Offset: 0x422
// Size: 0xa2
function hostmigrationtimerthink()
{
    self endon( "disconnect" );
    assertex( isdefined( self.hostmigrationcontrolsfrozen ), "Not properly tracking controller frozen for " + hostmigrationname( self ) );
    hostmigrationtimerthink_internal();
    assertex( isdefined( self.hostmigrationcontrolsfrozen ), "Attempted to unfreeze controls for " + hostmigrationname( self ) );
    println( "<dev string:x62>" + hostmigrationname( self ) + "<dev string:x3d>" + self.hostmigrationcontrolsfrozen );
    
    if ( self.hostmigrationcontrolsfrozen )
    {
        if ( gameflag( "prematch_done" ) )
        {
            freezecontrolswrapper( 0 );
        }
        
        self.hostmigrationcontrolsfrozen = undefined;
    }
}

// Namespace cp_hostmigration / scripts\cp\cp_hostmigration
// Params 0
// Checksum 0x0, Offset: 0x4cc
// Size: 0x30
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

// Namespace cp_hostmigration / scripts\cp\cp_hostmigration
// Params 1
// Checksum 0x0, Offset: 0x505
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

// Namespace cp_hostmigration / scripts\cp\cp_hostmigration
// Params 1
// Checksum 0x0, Offset: 0x52f
// Size: 0x94
function waitlongdurationwithhostmigrationpause( duration )
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
        
        if ( isdefined( level.hostmigrationtimer ) )
        {
            timepassed = waittillhostmigrationdone();
            endtime += timepassed;
        }
    }
    
    waittillhostmigrationdone();
    return gettime() - starttime;
}

// Namespace cp_hostmigration / scripts\cp\cp_hostmigration
// Params 2
// Checksum 0x0, Offset: 0x5cc
// Size: 0x9f
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

// Namespace cp_hostmigration / scripts\cp\cp_hostmigration
// Params 1
// Checksum 0x0, Offset: 0x674
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

// Namespace cp_hostmigration / scripts\cp\cp_hostmigration
// Params 2
// Checksum 0x0, Offset: 0x733
// Size: 0x80
function matchstarttimer( type, duration )
{
    self notify( "matchStartTimer" );
    self endon( "matchStartTimer" );
    level notify( "match_start_timer_beginning" );
    counttime = int( duration );
    
    if ( counttime >= 2 )
    {
        setomnvar( "ui_match_start_text", type );
        matchstarttimer_internal( counttime );
        visionsetnaked( "", 3 );
        return;
    }
    
    introvisionset();
    visionsetnaked( "", 1 );
}

// Namespace cp_hostmigration / scripts\cp\cp_hostmigration
// Params 1
// Checksum 0x0, Offset: 0x7bb
// Size: 0x109
function matchstarttimer_internal( counttime )
{
    waittillframeend();
    introvisionset();
    level endon( "match_start_timer_beginning" );
    
    while ( counttime > 0 && !level.gameended )
    {
        foreach ( p in level.players )
        {
            p setclientomnvar( "ui_match_start_countdown", counttime );
            p setclientomnvar( "ui_match_in_progress", 0 );
        }
        
        if ( counttime == 0 )
        {
            visionsetnaked( "", 0 );
        }
        
        counttime--;
        wait 1;
    }
    
    foreach ( p in level.players )
    {
        p setclientomnvar( "ui_match_start_countdown", 0 );
        p setclientomnvar( "ui_match_in_progress", 1 );
    }
}

// Namespace cp_hostmigration / scripts\cp\cp_hostmigration
// Params 0
// Checksum 0x0, Offset: 0x8cc
// Size: 0x2d
function introvisionset()
{
    if ( !isdefined( level.introvisionset ) )
    {
        level.introvisionset = "mpIntro";
    }
    
    visionsetnaked( level.introvisionset, 0 );
}

