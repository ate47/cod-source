#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_deployable_kiosk;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\hud_util;

#namespace br_publicevent_flybuy;

// Namespace br_publicevent_flybuy / scripts\mp\gametypes\br_publicevent_flybuy
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x16c
// Size: 0x17
function autoexec main()
{
    scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82( %"flybuy", &init );
}

// Namespace br_publicevent_flybuy / scripts\mp\gametypes\br_publicevent_flybuy
// Params 1
// Checksum 0x0, Offset: 0x18b
// Size: 0x4f
function init( eventinfo )
{
    eventinfo.validatefunc = &validatefunc;
    eventinfo.activatefunc = &activatefunc;
    eventinfo.waitfunc = &waitfunc;
    eventinfo.postinitfunc = &postinitfunc;
}

// Namespace br_publicevent_flybuy / scripts\mp\gametypes\br_publicevent_flybuy
// Params 0
// Checksum 0x0, Offset: 0x1e2
// Size: 0x28
function postinitfunc()
{
    game[ "dialog" ][ "flybuy_intro" ] = "flyb_grav_pest";
    game[ "dialog" ][ "flybuy_desc" ] = "pblc_grav_bsnv";
}

// Namespace br_publicevent_flybuy / scripts\mp\gametypes\br_publicevent_flybuy
// Params 0
// Checksum 0x0, Offset: 0x212
// Size: 0x4, Type: bool
function validatefunc()
{
    return true;
}

// Namespace br_publicevent_flybuy / scripts\mp\gametypes\br_publicevent_flybuy
// Params 0
// Checksum 0x0, Offset: 0x21f
// Size: 0x10
function waitfunc()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
}

// Namespace br_publicevent_flybuy / scripts\mp\gametypes\br_publicevent_flybuy
// Params 0
// Checksum 0x0, Offset: 0x237
// Size: 0x48
function activatefunc()
{
    level endon( "game_ended" );
    scripts\mp\gametypes\br_publicevents::showsplashtoall( "br_pe_flybuy_start", "splash_list_br_pe_flybuy" );
    scripts\mp\gametypes\br_public::brleaderdialog( "flybuy_intro", 1, undefined, undefined, 1 );
    function_3c4cffdc51b69fa4();
    scripts\mp\gametypes\br_public::brleaderdialog( "flybuy_desc", 1, undefined, undefined, 2.5 );
}

// Namespace br_publicevent_flybuy / scripts\mp\gametypes\br_publicevent_flybuy
// Params 0
// Checksum 0x0, Offset: 0x287
// Size: 0x117
function function_3c4cffdc51b69fa4()
{
    level endon( "game_ended" );
    
    if ( istrue( level.circleclosing ) )
    {
        circleindex = level.br_circle.circleindex + 1;
    }
    else
    {
        circleindex = level.br_circle.circleindex;
    }
    
    circlecenter = level.br_level.br_circlecenters[ circleindex ];
    radius = level.br_level.br_circleradii[ circleindex ];
    count = getdvarint( @"scr_spawn_flybuy_buystations_count", 6 );
    step = 360 / count;
    yaw = 0;
    
    for ( i = 0; i < count ; i++ )
    {
        randompoint = scripts\mp\gametypes\br_circle::getrandompointinboundscircle( circlecenter, radius, 0.25, 0.75, 1, 1, 1, undefined, yaw, yaw + step );
        yaw += step;
        scripts\mp\gametypes\br_deployable_kiosk::function_590979ef771686a8( undefined, randompoint, 1 );
    }
}

