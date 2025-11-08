#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\hud_util;

#namespace br_publicevent_firesale;

// Namespace br_publicevent_firesale / scripts\mp\gametypes\br_publicevent_firesale
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x22e
// Size: 0x17
function autoexec main()
{
    scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82( %"firesale", &init );
}

// Namespace br_publicevent_firesale / scripts\mp\gametypes\br_publicevent_firesale
// Params 1
// Checksum 0x0, Offset: 0x24d
// Size: 0x4f
function init( eventinfo )
{
    eventinfo.var_b22310d8fb6c98fa = &function_b22310d8fb6c98fa;
    eventinfo.activatefunc = &activatefunc;
    eventinfo.waitfunc = &waitfunc;
    eventinfo.postinitfunc = &postinitfunc;
}

// Namespace br_publicevent_firesale / scripts\mp\gametypes\br_publicevent_firesale
// Params 0
// Checksum 0x0, Offset: 0x2a4
// Size: 0x28
function postinitfunc()
{
    game[ "dialog" ][ "public_events_firesale_start" ] = "pblc_grav_frsc";
    game[ "dialog" ][ "public_events_firesale_end" ] = "pblc_grav_frsn";
}

// Namespace br_publicevent_firesale / scripts\mp\gametypes\br_publicevent_firesale
// Params 0
// Checksum 0x0, Offset: 0x2d4
// Size: 0x5a, Type: bool
function function_b22310d8fb6c98fa()
{
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) && level.br_circle.circleindex <= 1 )
    {
        return true;
    }
    
    var_35c1e70b1d29218 = scripts\mp\gametypes\br_armory_kiosk::function_8301ce82f0ae1be6();
    return var_35c1e70b1d29218 >= 1;
}

// Namespace br_publicevent_firesale / scripts\mp\gametypes\br_publicevent_firesale
// Params 0
// Checksum 0x0, Offset: 0x337
// Size: 0x24
function waitfunc()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    eventstarttime = calculateeventstarttime();
    wait eventstarttime;
}

// Namespace br_publicevent_firesale / scripts\mp\gametypes\br_publicevent_firesale
// Params 0
// Checksum 0x0, Offset: 0x363
// Size: 0x179
function activatefunc()
{
    level endon( "game_ended" );
    scripts\mp\gametypes\br_publicevents::showsplashtoall( "br_pe_firesale_start" );
    scripts\mp\gametypes\br_public::brleaderdialog( "public_events_firesale_start", undefined, undefined, undefined, 1.5 );
    setomnvar( "ui_minimap_pulse", 1 );
    setomnvar( "ui_publicevent_timer_type", 1 );
    eventduration = getduration();
    eventendtime = gettime() + eventduration * 1000;
    setomnvar( "ui_publicevent_timer", eventendtime );
    clockobject = spawn( "script_origin", ( 0, 0, 0 ) );
    clockobject hide();
    
    if ( isdefined( level.var_a4078546548cb0a ) )
    {
        [[ level.var_a4078546548cb0a ]]();
    }
    
    level notify( "public_event_firesale_start" );
    var_49978e5850a50d57 = 5;
    
    if ( eventduration > var_49978e5850a50d57 )
    {
        wait eventduration - var_49978e5850a50d57;
    }
    else
    {
        var_49978e5850a50d57 = int( eventduration );
    }
    
    for ( i = 0; i < var_49978e5850a50d57 ; i++ )
    {
        clockobject playsound( "ui_mp_fire_sale_timer" );
        wait 1;
    }
    
    if ( isdefined( level.var_4fecf02c9241f7f0 ) )
    {
        [[ level.var_4fecf02c9241f7f0 ]]();
    }
    
    scripts\mp\gametypes\br_publicevents::function_2907d01a7d692108( %"firesale" );
    level notify( "public_event_firesale_end" );
    showsplashtoall( "br_pe_firesale_end" );
    scripts\mp\gametypes\br_public::brleaderdialog( "public_events_firesale_end", undefined, undefined, undefined, 1.5 );
    setomnvar( "ui_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
    clockobject delete();
}

// Namespace br_publicevent_firesale / scripts\mp\gametypes\br_publicevent_firesale
// Params 0
// Checksum 0x0, Offset: 0x4e4
// Size: 0xef
function getduration()
{
    eventduration = getdvarfloat( @"hash_104f9a52db6ef74", 90 );
    var_cc5318567913f501 = isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) && level.br_circle.circleindex != -1;
    var_543c8e4d624ff7a3 = getdvarint( @"hash_cc7fed1c42605966", 1 ) == 1;
    
    if ( var_543c8e4d624ff7a3 && var_cc5318567913f501 )
    {
        eventduration = min( eventduration, scripts\mp\gametypes\br_circle::function_abbfb4d18d1a9ca7() );
    }
    
    var_8812000c33aed3c9 = getdvarint( @"hash_18c9ea0970a9d3aa", 0 ) == 1;
    
    if ( var_8812000c33aed3c9 && var_cc5318567913f501 )
    {
        eventduration = scripts\mp\gametypes\br_circle::function_abbfb4d18d1a9ca7();
    }
    
    minduration = getdvarint( @"hash_394bce38a6950030", 15 );
    eventduration = max( eventduration, minduration );
    return eventduration;
}

// Namespace br_publicevent_firesale / scripts\mp\gametypes\br_publicevent_firesale
// Params 0
// Checksum 0x0, Offset: 0x5dc
// Size: 0x51
function calculateeventstarttime()
{
    minstarttime = getdvarfloat( @"scr_br_pe_firesale_starttime_min", 795 );
    maxstarttime = getdvarfloat( @"scr_br_pe_firesale_starttime_max", 1110 );
    
    if ( maxstarttime > minstarttime )
    {
        return randomfloatrange( minstarttime, maxstarttime );
    }
    
    return minstarttime;
}

