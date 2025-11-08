#using script_4948cdf739393d2d;
#using script_728ffcee8cbf30ee;
#using script_744cad313ed0a87e;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\matchdata;
#using scripts\mp\poi;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;

#namespace br_analytics;

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x2be2
// Size: 0xde
function branalytics_init()
{
    if ( isdefined( level.matchdata_br_onmatchstart ) )
    {
        return;
    }
    
    if ( false )
    {
        return;
    }
    
    if ( !branalytics_validation() )
    {
        return;
    }
    
    registersharedfunc( "analytics", "agent_alloc", &function_8e6652060309b9db );
    registersharedfunc( "analytics", "agent_spawn", &function_252e45fc60e2a731 );
    registersharedfunc( "analytics", "agent_killed", &function_e3aef4fcb303cff );
    level.var_d984da21af3906b9 = istrue( level.var_e00997af1f830a38 );
    level.matchdata_br_onmatchstart = &onmatchstartbr;
    level.delayedeventtypes = [];
    level.var_47be1d1bb3b425a6 = getdvarint( @"hash_6169803d232444ff", 0 );
    
    if ( true )
    {
        level.var_47be1d1bb3b425a6 = 1;
        analyticsreset();
    }
    
    level thread function_c523b31dd9dc82d0();
    level thread function_d5db49ed7a7d77c5();
    level thread function_a16656b5f9493d2c();
    level thread function_7635473a21a12dc3();
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x2cc8
// Size: 0x3d
function function_d54188d94e97379c( info, var_80ed4d4a2aaf5d44 )
{
    if ( isdedicatedserver() )
    {
        setdvar( @"hash_bd87b6ef2da571db", info );
    }
    
    if ( istrue( var_80ed4d4a2aaf5d44 ) )
    {
        logstring( "[KEY_MOMENT] " + info );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x2d0d
// Size: 0x1a4
function function_a16656b5f9493d2c()
{
    level endon( "game_ended" );
    function_d54188d94e97379c( "prematch_waiting" );
    level waittill( "match_start_timer_beginning" );
    wait 1;
    function_d54188d94e97379c( "prematch_countdown begin", 1 );
    
    while ( isdefined( level.matchcountdowntime ) )
    {
        function_d54188d94e97379c( "prematch_countdown " + level.matchcountdowntime );
        wait 1;
    }
    
    function_d54188d94e97379c( "prematch_cinematic begin", 1 );
    wait 2;
    
    while ( istrue( level.infilcinematicactive ) )
    {
        wait 1;
    }
    
    function_d54188d94e97379c( "prematch_cinematic end", 1 );
    wait 1;
    level notify( "prematch_cinematic_end" );
    logstring( "[KEY_MOMENT] Infil Sequence Done" );
    
    while ( true )
    {
        circleindex = 0;
        aliveplayers = 0;
        alivesquads = 0;
        
        foreach ( team in level.teamnamelist )
        {
            teamplayers = scripts\mp\utility\teams::getteamdata( team, "aliveCount" );
            
            if ( teamplayers > 0 )
            {
                aliveplayers += teamplayers;
                alivesquads += 1;
            }
        }
        
        if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
        {
            circleindex = level.br_circle.circleindex;
        }
        
        info = "circle=" + circleindex + " alive=" + aliveplayers + " squads=" + alivesquads;
        function_d54188d94e97379c( info );
        wait 10;
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x2eb9
// Size: 0x1f
function function_bd6274fad1216b30()
{
    level endon( "game_cleanup" );
    level waittill( "br_ending_start" );
    function_d54188d94e97379c( "game_ended, watching exfil", 1 );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x2ee0
// Size: 0x78
function function_7635473a21a12dc3()
{
    level thread function_bd6274fad1216b30();
    level waittill( "game_ended" );
    function_d54188d94e97379c( "game_ended, watching final kill", 1 );
    wait 1.5;
    function_d54188d94e97379c( "game_ended, watching splash", 1 );
    
    if ( isdefined( level.br_ending_delay ) )
    {
        wait level.br_ending_delay;
    }
    
    level waittill( "round_end_finished" );
    function_d54188d94e97379c( "game_ended, round_end_finished", 1 );
    level waittill( "game_cleanup" );
    function_d54188d94e97379c( "game_ended, game_cleanup", 1 );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x2f60
// Size: 0xeb
function function_d5db49ed7a7d77c5()
{
    level endon( "game_ended" );
    
    if ( !isdedicatedserver() )
    {
        return;
    }
    
    level waittill( "prematch_cinematic_end" );
    wait 30;
    runtimedprofile( "br_peak", 30 );
    wait 31;
    maxplayers = getdvarint( @"party_maxplayers", 0 );
    playercount = getintorzero( level.players.size );
    
    if ( playercount > maxplayers - 20 || getdvarint( @"hash_cd9d15d61f6e2380", 0 ) > 0 )
    {
        runjqprofile( "br_peak", 1 );
        wait 2;
    }
    
    if ( getdvarint( @"br_endmatchaftercapture", 0 ) > 0 && isdefined( level.var_b9c50a4fd9223cc7 ) )
    {
        logstring( "br_endMatchAfterCapture" );
        self thread [[ level.var_b9c50a4fd9223cc7 ]]( level.brgametype.firstteam, game[ "end_reason" ][ "objective_completed" ] );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x3053
// Size: 0x40c
function function_c523b31dd9dc82d0()
{
    level endon( "game_ended" );
    level waittill( "prematch_done" );
    level.var_d984da21af3906b9 = 1;
    humans = 0;
    bots = 0;
    headless = 0;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isbot( player ) || istestclient( player ) )
        {
            bots += 1;
            _branalytics_addevent( "player_spawned", player getorigin(), 0, "", player );
            continue;
        }
        
        if ( player isplayerheadless() )
        {
            headless += 1;
            _branalytics_addevent( "player_spawned", player getorigin(), 13, "", player );
            continue;
        }
        
        humans += 1;
        _branalytics_addevent( "player_spawned", player getorigin(), 0, "", player );
    }
    
    logstring( "[KEY_MOMENT] Prematch Done" );
    logstring( "=============================================" );
    logstring( "bots       = " + bots );
    logstring( "headless   = " + headless );
    logstring( "humans     = " + humans );
    logstring( "=============================================" );
    timenow = _branalytics_geteventtimestamp();
    function_bb96ecd805545b2e( "prematch_done", ( 0, 0, 0 ), 0, int( timenow ), "", -1 );
    var_dfee9dad130c9312 = -3;
    
    if ( isdefined( level.br_level ) && isdefined( level.br_level.br_circlecenters ) )
    {
        time = timenow;
        circlecount = level.br_level.br_circleradii.size;
        multicirclecount = scripts\mp\gametypes\br_circle_util::function_d987886bb9de9137();
        _branalytics_addevent( "multiCircleCount", ( 0, 0, 0 ), multicirclecount );
        
        for ( circleindex = 0; circleindex < circlecount - 1 ; circleindex++ )
        {
            radius = level.br_level.br_circleradii[ circleindex ];
            timedelay = level.br_level.br_circledelaytimes[ circleindex ] * 1000;
            timeclose = level.br_level.br_circleclosetimes[ circleindex ] * 1000;
            function_bb96ecd805545b2e( "circleTime", ( 0, 0, 0 ), 0, int( time ), "c" + string( circleindex ), var_dfee9dad130c9312 );
            
            if ( multicirclecount > 0 )
            {
                for ( i = 0; i < multicirclecount ; i++ )
                {
                    timemulti = time;
                    origin = level.br_multi_circle.circles[ i ].circlecenters[ circleindex ];
                    function_bb96ecd805545b2e( "circle" + string( i ), origin, int( radius ), int( timemulti ), "start", var_dfee9dad130c9312 - i );
                    timemulti += timedelay;
                    function_bb96ecd805545b2e( "circle" + string( i ), origin, int( radius ), int( timemulti ), "close", var_dfee9dad130c9312 - i );
                }
                
                time += timedelay;
                time += timeclose;
                continue;
            }
            
            origin = level.br_level.br_circlecenters[ circleindex ];
            
            if ( isdefined( timedelay ) && isdefined( timeclose ) )
            {
                function_bb96ecd805545b2e( "circle", origin, int( radius ), int( time ), "start", var_dfee9dad130c9312 );
                time += timedelay;
                function_bb96ecd805545b2e( "circle", origin, int( radius ), int( time ), "close", var_dfee9dad130c9312 );
                time += timeclose;
            }
        }
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x3467
// Size: 0x17, Type: bool
function _branalytics_addeventallowed()
{
    if ( !branalytics_validation() )
    {
        return false;
    }
    
    return istrue( level.var_d984da21af3906b9 );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x3487
// Size: 0x14
function _branalytics_geteventtimestamp()
{
    time = gettime();
    return time;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 6
// Checksum 0x0, Offset: 0x34a4
// Size: 0x3af
function function_bb96ecd805545b2e( type, origin, state, time, data, entnum )
{
    if ( !istrue( level.var_d984da21af3906b9 ) )
    {
        return;
    }
    
    if ( !isdefined( data ) || !isstring( data ) )
    {
        data = "";
    }
    
    if ( true )
    {
        if ( !isdefined( level.var_cbcec00eb49463dd ) )
        {
            level.var_cbcec00eb49463dd = [];
            level.var_303200f308c1d4cf = [];
            level.var_303200f308c1d4cf[ "breadcrumb" ] = 1;
            level.var_303200f308c1d4cf[ "playerCount" ] = 1;
            level.var_303200f308c1d4cf[ "multiCircleCount" ] = 1;
            level.var_303200f308c1d4cf[ "player_spawned" ] = 1;
            level.var_303200f308c1d4cf[ "prematch_done" ] = 1;
            level.var_303200f308c1d4cf[ "dropkit" ] = 1;
            level.var_303200f308c1d4cf[ "bonusXpDebug" ] = 1;
            level.var_303200f308c1d4cf[ "xp_event_brWeaponXp" ] = 1;
            level.var_303200f308c1d4cf[ "gulag_end" ] = 1;
            level.var_303200f308c1d4cf[ "vehicle" ] = 1;
            level.var_303200f308c1d4cf[ "kiosk" ] = 1;
            level.var_303200f308c1d4cf[ "mission" ] = 1;
            level.var_303200f308c1d4cf[ "agent_spawn" ] = 1;
            level.var_303200f308c1d4cf[ "agent_alloc" ] = 1;
            level.var_303200f308c1d4cf[ "unlock_all_blacksite_doors" ] = 1;
            level.var_303200f308c1d4cf[ "fortress_rejected" ] = 1;
            level.var_303200f308c1d4cf[ "fortress_loot_zone" ] = 1;
            level.var_303200f308c1d4cf[ "fortress_undefined_zonebounds" ] = 1;
            level.var_303200f308c1d4cf[ "circle" ] = 1;
            level.var_303200f308c1d4cf[ "circle0" ] = 1;
            level.var_303200f308c1d4cf[ "circle1" ] = 1;
            level.var_303200f308c1d4cf[ "circle2" ] = 1;
        }
        
        var_3b1fe88dbd4e0f1 = !isdefined( level.var_303200f308c1d4cf[ type ] );
        var_71ad68ab6268a451 = 0;
        var_c0548534984469b3 = 0;
        var_61bb6f79268382d9 = 0;
        var_6b037d59e086f8ab = 0;
        
        if ( var_3b1fe88dbd4e0f1 )
        {
            if ( !isdefined( level.var_cbcec00eb49463dd[ type ] ) )
            {
                var_71ad68ab6268a451 = 1;
                var_f03d96d5e0ee0a4f = spawnstruct();
                var_f03d96d5e0ee0a4f.index = level.var_cbcec00eb49463dd.size;
                var_f03d96d5e0ee0a4f.var_c51eba8dca8c32ee = [];
                var_f03d96d5e0ee0a4f.var_969b413c42a23a1f = 0;
                level.var_cbcec00eb49463dd[ type ] = var_f03d96d5e0ee0a4f;
            }
            
            var_a3c4a415cd421cc5 = level.var_cbcec00eb49463dd[ type ];
            var_6b037d59e086f8ab = var_a3c4a415cd421cc5.index;
            
            if ( data != "" )
            {
                if ( !isdefined( var_a3c4a415cd421cc5.var_c51eba8dca8c32ee[ data ] ) )
                {
                    var_61bb6f79268382d9 = 1;
                    var_a3c4a415cd421cc5.var_c51eba8dca8c32ee[ data ] = var_a3c4a415cd421cc5.var_969b413c42a23a1f;
                    var_a3c4a415cd421cc5.var_969b413c42a23a1f += 1;
                }
                
                var_c0548534984469b3 = var_a3c4a415cd421cc5.var_c51eba8dca8c32ee[ data ];
            }
        }
        
        analyticsaddevent( origin, type, state, time, data, entnum, var_3b1fe88dbd4e0f1, var_6b037d59e086f8ab, var_71ad68ab6268a451, var_c0548534984469b3, var_61bb6f79268382d9 );
    }
    
    if ( 0 && type != "breadcrumb" )
    {
        logstring( "[GAE]," + time + "," + entnum + "," + origin[ 0 ] + "," + origin[ 1 ] + "," + type + "," + state + "," + data );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 5
// Checksum 0x0, Offset: 0x385b
// Size: 0xb3
function _branalytics_addevent( type, origin, state, data, ent )
{
    allowed = _branalytics_addeventallowed();
    
    if ( allowed == 0 )
    {
        return;
    }
    
    if ( !isdefined( origin ) )
    {
        origin = ( 0, 0, 0 );
    }
    
    if ( !isdefined( state ) )
    {
        state = 0;
    }
    
    if ( !isdefined( data ) )
    {
        data = "";
    }
    
    entnum = -1;
    
    if ( isdefined( ent ) )
    {
        entnum = ent getentitynumber();
    }
    
    time = _branalytics_geteventtimestamp();
    function_bb96ecd805545b2e( type, origin, state, time, data, entnum );
    
    if ( isdefined( ent ) )
    {
        ent function_f183d915239368b7( time );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x3916
// Size: 0x33
function function_a48be354e2f41db9( type, ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    _branalytics_addevent( type, ent.origin, 0, "", ent );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0x3951
// Size: 0x3f
function function_eefaa754fc189980( type, ent, state, data )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    _branalytics_addevent( type, ent.origin, state, data, ent );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x3998
// Size: 0xbe
function _getdeathstatecode( deathtype )
{
    if ( !isdefined( deathtype ) )
    {
        return -1;
    }
    
    switch ( deathtype )
    {
        case #"hash_fea1e712b5740278":
            data = 6;
            break;
        case #"hash_1184b43822fe56f0":
            data = 3;
            break;
        case #"hash_c03eabf71149f406":
            data = 5;
            break;
        case #"hash_e97320d8279bef45":
            data = 4;
            break;
        case #"hash_ce250de499ae9603":
            data = 2;
            break;
        case #"hash_a9f265ec10b615d":
            data = 1;
            break;
        case #"hash_e11c1638da4ca83c":
            data = 0;
            break;
        default:
            data = -1;
            break;
    }
    
    return data;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0x3a5f
// Size: 0x128
function _branalytics_addeventdelayed( type, origin, ent, data )
{
    assert( isdefined( level.delayedeventtypes ) );
    assert( isdefined( type ) );
    assert( isdefined( origin ) );
    assert( isdefined( ent ) );
    
    if ( !isdefined( type ) )
    {
        type = "undefined";
    }
    
    if ( !isdefined( origin ) )
    {
        origin = ( 0, 0, 0 );
    }
    
    if ( !isdefined( data ) )
    {
        data = "";
    }
    
    if ( !isdefined( level.delayedeventtypes[ type ] ) )
    {
        level.delayedeventtypes[ type ] = [];
    }
    
    evt = spawnstruct();
    evt.type = type;
    evt.origin = origin;
    evt.ent = ent;
    evt.data = data;
    evt.state = 0;
    evt.time = _branalytics_geteventtimestamp();
    evtindex = level.delayedeventtypes[ type ].size;
    level.delayedeventtypes[ type ][ evtindex ] = evt;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x3b8f
// Size: 0xc4
function branalytics_seteventdelayedstate( type, ent, state )
{
    if ( !isdefined( type ) || !isdefined( ent ) || !isdefined( level.delayedeventtypes ) || !isdefined( level.delayedeventtypes[ type ] ) )
    {
        return;
    }
    
    foreach ( evt in level.delayedeventtypes[ type ] )
    {
        if ( evt.ent == ent )
        {
            evt.time = _branalytics_geteventtimestamp();
            evt.state = state;
            return;
        }
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x3c5b
// Size: 0xf, Type: bool
function branalytics_validation()
{
    if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        return false;
    }
    
    return true;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x3c73
// Size: 0xac
function branalytics_equipmentuse( player, objweapon, item_type )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    equipmentname = objweapon.basename;
    assert( isstring( equipmentname ) );
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "item_name";
    eventparams[ eventparams.size ] = equipmentname;
    eventparams[ eventparams.size ] = "item_type";
    eventparams[ eventparams.size ] = item_type;
    player dlog_recordplayerevent( "dlog_event_br_equipment_use", eventparams );
    
    if ( _branalytics_addeventallowed() )
    {
        _branalytics_addevent( "equipment_use", player.origin, 0, equipmentname, player );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 5
// Checksum 0x0, Offset: 0x3d27
// Size: 0x487
function branalytics_down( attacker, victim, objweapon, deathtype, meansofdeath )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    if ( isagent( attacker ) )
    {
        if ( _branalytics_addeventallowed() )
        {
            id = attacker getentitynumber();
            function_eefaa754fc189980( "down_by_agent", victim, id, deathtype );
        }
        
        return;
    }
    
    if ( !isent( attacker ) || !isplayer( attacker ) )
    {
        var_9c46fc77656f0e4b = "world";
        attacker = victim;
    }
    else if ( isdefined( objweapon ) )
    {
        var_9c46fc77656f0e4b = objweapon.basename;
    }
    else
    {
        attacker_weapon = attacker getcurrentweapon();
        var_9c46fc77656f0e4b = attacker_weapon.basename;
    }
    
    assert( isstring( var_9c46fc77656f0e4b ) );
    victim_weapon = ter_op( scripts\mp\utility\player::isinlaststand( victim ) && isdefined( victim.laststandoldweaponobj ), victim.laststandoldweaponobj, victim.lastweaponused );
    var_595b87d05e4a06c4 = "";
    
    if ( isdefined( victim_weapon ) )
    {
        var_595b87d05e4a06c4 = victim_weapon.basename;
    }
    
    assert( isstring( var_595b87d05e4a06c4 ) );
    eventparams = [];
    eventparams[ eventparams.size ] = "victim";
    eventparams[ eventparams.size ] = victim;
    attackerparams = _branalytics_header( attacker, "attacker" );
    
    foreach ( item in attackerparams )
    {
        eventparams[ eventparams.size ] = item;
    }
    
    eventparams[ eventparams.size ] = "attacker_weapon";
    eventparams[ eventparams.size ] = var_9c46fc77656f0e4b;
    var_2d618a34e27d5476 = attacker getclientomnvar( "ui_br_objective_index" );
    
    if ( !isdefined( var_2d618a34e27d5476 ) )
    {
        queststring = "none";
    }
    else
    {
        queststring = tablelookup( "mp/brmissions.csv", 0, var_2d618a34e27d5476, 1 );
    }
    
    eventparams[ eventparams.size ] = "attacker_active_mission";
    eventparams[ eventparams.size ] = queststring;
    victimparams = _branalytics_headerplayer( [], victim, "victim" );
    
    foreach ( item in victimparams )
    {
        eventparams[ eventparams.size ] = item;
    }
    
    eventparams[ eventparams.size ] = "victim_weapon";
    eventparams[ eventparams.size ] = var_595b87d05e4a06c4;
    var_2d618a34e27d5476 = victim getclientomnvar( "ui_br_objective_index" );
    
    if ( !isdefined( var_2d618a34e27d5476 ) )
    {
        queststring = "NONE";
    }
    else
    {
        queststring = tablelookup( "mp/brmissions.csv", 0, var_2d618a34e27d5476, 1 );
    }
    
    eventparams[ eventparams.size ] = "victim_active_mission";
    eventparams[ eventparams.size ] = queststring;
    eventparams[ eventparams.size ] = "death_type";
    eventparams[ eventparams.size ] = deathtype;
    eventparams[ eventparams.size ] = "means_of_death";
    eventparams[ eventparams.size ] = meansofdeath;
    teammates = scripts\mp\utility\teams::getfriendlyplayers( victim.team, 1 );
    closestdistance = 2147483647;
    
    foreach ( teammate in teammates )
    {
        if ( teammate == victim )
        {
            continue;
        }
        
        dist = distance( victim.origin, teammate.origin );
        
        if ( dist < closestdistance || closestdistance == 2147483647 )
        {
            closestdistance = dist;
        }
    }
    
    eventparams[ eventparams.size ] = "closest_victim_teammate_distance";
    eventparams[ eventparams.size ] = int( closestdistance );
    xp_earned = 0;
    
    if ( isdefined( victim.pers[ "summary" ][ "xp" ] ) )
    {
        currentxp = victim.pers[ "summary" ][ "xp" ];
        xp_earned = currentxp - victim.pers[ "telemetry" ].life.var_2148fb703835ec1f;
    }
    
    eventparams[ eventparams.size ] = "xp_earned";
    eventparams[ eventparams.size ] = xp_earned;
    attacker dlog_recordplayerevent( "dlog_event_br_down", eventparams );
    
    if ( _branalytics_addeventallowed() )
    {
        function_eefaa754fc189980( "down", victim, _getdeathstatecode( deathtype ), var_9c46fc77656f0e4b );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x41b6
// Size: 0x11d
function branalytics_revive( reviver, revivee )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "revivee";
    eventparams[ eventparams.size ] = revivee;
    reviverparams = _branalytics_header( reviver, "reviver" );
    
    foreach ( item in reviverparams )
    {
        eventparams[ eventparams.size ] = item;
    }
    
    reviveeparams = _branalytics_headerplayer( [], revivee, "revivee" );
    
    foreach ( item in reviveeparams )
    {
        eventparams[ eventparams.size ] = item;
    }
    
    reviver dlog_recordplayerevent( "dlog_event_br_revive", eventparams );
    
    if ( _branalytics_addeventallowed() )
    {
        function_a48be354e2f41db9( "revive", revivee );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x42db
// Size: 0x50
function branalytics_selfrevive( revivee )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( revivee, "revivee" );
    revivee dlog_recordplayerevent( "dlog_event_br_selfrevive", eventparams );
    
    if ( _branalytics_addeventallowed() )
    {
        function_a48be354e2f41db9( "selfRevive", revivee );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 11
// Checksum 0x0, Offset: 0x4333
// Size: 0x2a9
function branalytics_secondwind( revivee, laststandattacker, victim, meansofdeath, weaponname, laststandmeansofdeath, laststandweaponname, var_1450075a920a7dd5, var_c9d5089e35e3ff9e, bbledout, var_6b0df23a41285117 )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "lastStandAttacker";
    eventparams[ eventparams.size ] = laststandattacker;
    eventparams[ eventparams.size ] = "victim";
    eventparams[ eventparams.size ] = victim;
    reviveeparams = _branalytics_header( revivee, "revivee" );
    
    foreach ( item in reviveeparams )
    {
        eventparams[ eventparams.size ] = item;
    }
    
    var_83ebb50ff7b5cf0e = _branalytics_headerplayer( [], laststandattacker, "laststandattacker" );
    
    foreach ( item in var_83ebb50ff7b5cf0e )
    {
        eventparams[ eventparams.size ] = item;
    }
    
    victimparams = _branalytics_headerplayer( [], victim, "victim" );
    
    foreach ( item in victimparams )
    {
        eventparams[ eventparams.size ] = item;
    }
    
    eventparams[ eventparams.size ] = "only_cleanup";
    eventparams[ eventparams.size ] = var_1450075a920a7dd5;
    eventparams[ eventparams.size ] = "only_downed";
    eventparams[ eventparams.size ] = var_c9d5089e35e3ff9e;
    eventparams[ eventparams.size ] = "bled_out";
    eventparams[ eventparams.size ] = bbledout;
    eventparams[ eventparams.size ] = "downed_seconds";
    eventparams[ eventparams.size ] = var_6b0df23a41285117;
    
    if ( !isdefined( meansofdeath ) )
    {
        meansofdeath = "";
    }
    
    eventparams[ eventparams.size ] = "means_of_death";
    eventparams[ eventparams.size ] = meansofdeath;
    
    if ( !isdefined( weaponname ) )
    {
        weaponname = "";
    }
    
    eventparams[ eventparams.size ] = "weapon_name";
    eventparams[ eventparams.size ] = weaponname;
    
    if ( !isdefined( laststandmeansofdeath ) )
    {
        laststandmeansofdeath = "";
    }
    
    eventparams[ eventparams.size ] = "laststand_means_of_death";
    eventparams[ eventparams.size ] = laststandmeansofdeath;
    
    if ( !isdefined( laststandweaponname ) )
    {
        laststandweaponname = "";
    }
    
    eventparams[ eventparams.size ] = "laststand_weapon_name";
    eventparams[ eventparams.size ] = laststandweaponname;
    revivee dlog_recordplayerevent( "dlog_event_br_secondwind", eventparams );
    
    if ( _branalytics_addeventallowed() )
    {
        function_a48be354e2f41db9( "secondWind", revivee.origin );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x45e4
// Size: 0x18
function branalytics_deployallowed()
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_deploy_allowed", [] );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x4604
// Size: 0x35
function branalytics_deploytriggered( player )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( player );
    player dlog_recordplayerevent( "dlog_event_br_deploy_triggered", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x4641
// Size: 0x4b
function branalytics_landing( player )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( player );
    player dlog_recordplayerevent( "dlog_event_br_deploy_land", eventparams );
    
    if ( _branalytics_addeventallowed() )
    {
        function_a48be354e2f41db9( "land", player );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x4694
// Size: 0x39
function branalytics_playercount( playercount )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    if ( _branalytics_addeventallowed() )
    {
        _branalytics_addevent( "playerCount", ( 0, 0, 0 ), 0, playercount );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x46d5
// Size: 0x9b
function branalytics_lootpickup( player, scriptablename, amount )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    assert( isstring( scriptablename ) );
    assert( isint( amount ) );
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "item_name";
    eventparams[ eventparams.size ] = scriptablename;
    eventparams[ eventparams.size ] = "amount";
    eventparams[ eventparams.size ] = amount;
    player dlog_recordplayerevent( "dlog_event_br_loot_pickup", eventparams );
    
    if ( _branalytics_addeventallowed() )
    {
        function_eefaa754fc189980( "loot_pickup", player, amount, scriptablename );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0x4778
// Size: 0xc6
function branalytics_lootdrop( player, itemtype, var_e637ee4faed5d14d, amount )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    assert( isstring( itemtype ) );
    var_e637ee4faed5d14d = istrue( var_e637ee4faed5d14d );
    assert( isint( var_e637ee4faed5d14d ) );
    assert( isint( amount ) );
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "item_name";
    eventparams[ eventparams.size ] = itemtype;
    eventparams[ eventparams.size ] = "is_drop_from_weapon_switch";
    eventparams[ eventparams.size ] = var_e637ee4faed5d14d;
    eventparams[ eventparams.size ] = "amount";
    eventparams[ eventparams.size ] = amount;
    player dlog_recordplayerevent( "dlog_event_br_loot_drop", eventparams );
    
    if ( _branalytics_addeventallowed() )
    {
        function_eefaa754fc189980( "loot_drop", player, amount, itemtype );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x4846
// Size: 0x4d
function branalytics_gulagstart( player, type )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "type";
    eventparams[ eventparams.size ] = type;
    player dlog_recordplayerevent( "dlog_event_br_gulag_start", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x489b
// Size: 0x219
function branalytics_gulagend( player, type, arena )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventref = "none";
    var_363eb22fdb336a2a = "none";
    
    if ( isdefined( arena ) && scripts\mp\gametypes\br_gulag::function_175e22055ae274a3( "getEventSettings" ) )
    {
        event = scripts\mp\gametypes\br_gulag::function_d4b0eef0a0924094( "getEventSettings", arena );
        
        if ( isdefined( event ) )
        {
            eventref = event.ref;
        }
    }
    
    if ( isdefined( arena ) && scripts\mp\gametypes\br_gulag::function_175e22055ae274a3( "getNamedArenaSettings" ) )
    {
        namedarena = scripts\mp\gametypes\br_gulag::function_d4b0eef0a0924094( "getNamedArenaSettings", arena );
        
        if ( isdefined( namedarena ) )
        {
            var_363eb22fdb336a2a = namedarena.ref;
        }
    }
    
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "type";
    eventparams[ eventparams.size ] = type;
    eventparams[ eventparams.size ] = "event";
    eventparams[ eventparams.size ] = eventref;
    eventparams[ eventparams.size ] = "named_arena";
    eventparams[ eventparams.size ] = var_363eb22fdb336a2a;
    eventparams[ eventparams.size ] = "primary";
    eventparams[ eventparams.size ] = isdefined( player.loadoutprimary ) ? player.loadoutprimary : "";
    eventparams[ eventparams.size ] = "secondary";
    eventparams[ eventparams.size ] = isdefined( player.loadoutsecondary ) ? player.loadoutsecondary : "";
    eventparams[ eventparams.size ] = "starting_lethal";
    eventparams[ eventparams.size ] = isdefined( player.loadoutequipmentprimary ) ? player.loadoutequipmentprimary : "";
    eventparams[ eventparams.size ] = "starting_tactical";
    eventparams[ eventparams.size ] = isdefined( player.loadoutequipmentsecondary ) ? player.loadoutequipmentsecondary : "";
    eventparams[ eventparams.size ] = "pickups";
    eventparams[ eventparams.size ] = isdefined( player.var_d919d1c70719e664 ) ? player.var_d919d1c70719e664 : 0;
    player dlog_recordplayerevent( "dlog_event_br_gulag_end", eventparams );
    
    if ( _branalytics_addeventallowed() )
    {
        function_eefaa754fc189980( "gulag_end", player, 0, type );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x4abc
// Size: 0x56
function function_a951471036bd80de( total_escapee, ladder_kill )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "total_escapee";
    eventparams[ eventparams.size ] = total_escapee;
    eventparams[ eventparams.size ] = "ladder_kill";
    eventparams[ eventparams.size ] = ladder_kill;
    dlog_recordevent( "dlog_event_br_gulag_ladder_escape_result", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x4b1a
// Size: 0x3d
function branalytics_respawn( player, var_99d9696812df6304, context )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    if ( _branalytics_addeventallowed() )
    {
        function_eefaa754fc189980( "respawn", player, var_99d9696812df6304, context );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x4b5f
// Size: 0x39
function branalytics_disconnect( player, var_8d4194f42fefe406 )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    if ( _branalytics_addeventallowed() )
    {
        function_eefaa754fc189980( "disconnect", player, var_8d4194f42fefe406, "" );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0x4ba0
// Size: 0xad
function branalytics_dropbagdeployed( player, dropbagpos, dropbagspawntypeenum, crate )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "drop_x";
    eventparams[ eventparams.size ] = dropbagpos[ 0 ];
    eventparams[ eventparams.size ] = "drop_y";
    eventparams[ eventparams.size ] = dropbagpos[ 1 ];
    eventparams[ eventparams.size ] = "drop_z";
    eventparams[ eventparams.size ] = dropbagpos[ 2 ];
    eventparams[ eventparams.size ] = "spawn_type";
    eventparams[ eventparams.size ] = dropbagspawntypeenum;
    player dlog_recordplayerevent( "dlog_event_br_dropbag_deployed", eventparams );
    
    if ( _branalytics_addeventallowed() )
    {
        _branalytics_addeventdelayed( "dropkit", dropbagpos, crate, 0 );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x4c55
// Size: 0x95
function branalytics_dropbagused( player, dropbagpos, crate )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "drop_x";
    eventparams[ eventparams.size ] = dropbagpos[ 0 ];
    eventparams[ eventparams.size ] = "drop_y";
    eventparams[ eventparams.size ] = dropbagpos[ 1 ];
    eventparams[ eventparams.size ] = "drop_z";
    eventparams[ eventparams.size ] = dropbagpos[ 2 ];
    player dlog_recordplayerevent( "dlog_event_br_dropbag_used", eventparams );
    
    if ( _branalytics_addeventallowed() )
    {
        branalytics_seteventdelayedstate( "dropkit", crate, 1 );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x4cf2
// Size: 0x8a
function branalytics_dropbagdestroyed( team, dropbagpos )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    if ( !isdefined( team ) )
    {
        team = "none";
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "drop_team";
    eventparams[ eventparams.size ] = team;
    eventparams[ eventparams.size ] = "drop_x";
    eventparams[ eventparams.size ] = dropbagpos[ 0 ];
    eventparams[ eventparams.size ] = "drop_y";
    eventparams[ eventparams.size ] = dropbagpos[ 1 ];
    eventparams[ eventparams.size ] = "drop_z";
    eventparams[ eventparams.size ] = dropbagpos[ 2 ];
    dlog_recordevent( "dlog_event_br_dropbag_destroyed", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x4d84
// Size: 0x4d
function branalytics_circleenter( player, time )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "time_spent_outside";
    eventparams[ eventparams.size ] = time;
    player dlog_recordplayerevent( "dlog_event_br_circle_enter", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x4dd9
// Size: 0x4d
function branalytics_circleexit( player, time )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "time_spent_inside";
    eventparams[ eventparams.size ] = time;
    player dlog_recordplayerevent( "dlog_event_br_circle_exit", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x4e2e
// Size: 0x3e
function function_14099f0f07c09e69( time )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "time_circle_start_split";
    eventparams[ eventparams.size ] = time;
    dlog_recordevent( "dlog_event_br_multi_circle_start_split", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x4e74
// Size: 0x6e
function function_c3ca7338446f4fce( time, playercounts, teamcounts )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "time_circle_end_split";
    eventparams[ eventparams.size ] = time;
    eventparams[ eventparams.size ] = "circle_player_count";
    eventparams[ eventparams.size ] = playercounts;
    eventparams[ eventparams.size ] = "circle_team_count";
    eventparams[ eventparams.size ] = teamcounts;
    dlog_recordevent( "dlog_event_br_multi_circle_end_split", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x4eea
// Size: 0x6e
function function_77c1c837c38efa21( time, playercounts, teamcounts )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "time_circle_start_merge";
    eventparams[ eventparams.size ] = time;
    eventparams[ eventparams.size ] = "circle_player_count";
    eventparams[ eventparams.size ] = playercounts;
    eventparams[ eventparams.size ] = "circle_team_count";
    eventparams[ eventparams.size ] = teamcounts;
    dlog_recordevent( "dlog_event_br_multi_circle_start_merge", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x4f60
// Size: 0x3e
function function_4eb4428fe15d7276( time )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "time_circle_end_merge";
    eventparams[ eventparams.size ] = time;
    dlog_recordevent( "dlog_event_br_multi_circle_end_merge", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0x4fa6
// Size: 0x195
function branalytics_planepath( centerpt, yaw, startpt, endpt )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    level waittill( "prematch_done" );
    dlog_recordevent( "dlog_event_br_plane_path", [ "center_x", centerpt[ 0 ], "center_y", centerpt[ 1 ], "center_z", centerpt[ 2 ], "yaw", yaw, "start_x", startpt[ 0 ], "start_y", startpt[ 1 ], "start_z", startpt[ 2 ], "end_x", endpt[ 0 ], "end_y", endpt[ 1 ], "end_z", endpt[ 2 ] ] );
    
    if ( _branalytics_addeventallowed() )
    {
        var_de802962b74d1a6c = -2;
        timenow = _branalytics_geteventtimestamp();
        var_b1ef50b243ad7d22 = timenow + 35000;
        traveldist = distance( startpt, endpt );
        travelduration = traveldist / scripts\mp\gametypes\br_c130::getc130speed() * 1000;
        var_fc296699dfb028f8 = var_b1ef50b243ad7d22;
        var_1abcf37063053d49 = var_fc296699dfb028f8 + travelduration;
        function_bb96ecd805545b2e( "plane", startpt, 0, int( var_fc296699dfb028f8 ), "", var_de802962b74d1a6c );
        function_bb96ecd805545b2e( "plane", endpt, 0, int( var_1abcf37063053d49 ), "", var_de802962b74d1a6c );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x5143
// Size: 0x7f2
function branalytics_economy_snapshot( activeplayers )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    var_aaa3a2b391a4d25b = [];
    totalplunder = 0;
    playermax = 0;
    playermin = 5000;
    teammax = 0;
    teammin = 5000;
    
    foreach ( player in activeplayers )
    {
        if ( !isdefined( var_aaa3a2b391a4d25b[ player.team ] ) )
        {
            var_aaa3a2b391a4d25b[ player.team ] = 0;
        }
        
        if ( isdefined( player.plundercount ) )
        {
            totalplunder += player.plundercount;
            var_aaa3a2b391a4d25b[ player.team ] += player.plundercount;
            
            if ( player.plundercount > playermax )
            {
                playermax = player.plundercount;
            }
            
            if ( player.plundercount < playermin )
            {
                playermin = player.plundercount;
            }
        }
        
        if ( var_aaa3a2b391a4d25b[ player.team ] > teammax )
        {
            teammax = var_aaa3a2b391a4d25b[ player.team ];
        }
        
        if ( var_aaa3a2b391a4d25b[ player.team ] < teammin )
        {
            teammin = var_aaa3a2b391a4d25b[ player.team ];
        }
    }
    
    player_avg = int( safedivide( totalplunder, activeplayers.size ) );
    team_avg = int( safedivide( totalplunder, var_aaa3a2b391a4d25b.size ) );
    eventparams = [];
    eventparams[ eventparams.size ] = "num_players_alive";
    eventparams[ eventparams.size ] = function_3fe52b08c657d074( activeplayers.size );
    eventparams[ eventparams.size ] = "num_teams_alive";
    eventparams[ eventparams.size ] = function_3fe52b08c657d074( var_aaa3a2b391a4d25b.size );
    eventparams[ eventparams.size ] = "total_plunder_held";
    eventparams[ eventparams.size ] = function_dcb7ec4c3306db25( totalplunder );
    eventparams[ eventparams.size ] = "top_player_plunder_held";
    eventparams[ eventparams.size ] = function_dcaf784c32fdf05b( playermax );
    eventparams[ eventparams.size ] = "top_team_total_plunder_held";
    eventparams[ eventparams.size ] = function_dcaf784c32fdf05b( teammax );
    eventparams[ eventparams.size ] = "avg_player_plunder_held";
    eventparams[ eventparams.size ] = function_dcaf784c32fdf05b( player_avg );
    eventparams[ eventparams.size ] = "avg_team_total_plunder_held";
    eventparams[ eventparams.size ] = function_dcaf784c32fdf05b( team_avg );
    eventparams[ eventparams.size ] = "min_player_plunder_held";
    eventparams[ eventparams.size ] = function_f8cfd7cafbc5981e( playermin );
    eventparams[ eventparams.size ] = "min_team_total_plunder_held";
    eventparams[ eventparams.size ] = function_f8cfd7cafbc5981e( teammin );
    eventparams[ eventparams.size ] = "plunder_items_picked_up";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8cfd7cafbc5981e( level.br_plunder.plunder_items_picked_up );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "plunder_value_picked_up";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8d8c3cafbcf8ad0( level.br_plunder.plunder_value_picked_up );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "plunder_items_dropped";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8cfd7cafbc5981e( level.br_plunder.plunder_items_dropped );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "plunder_value_dropped";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8d8c3cafbcf8ad0( level.br_plunder.plunder_value_dropped );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "plunder_awarded_by_missions_total";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8d8c3cafbcf8ad0( level.br_plunder.plunder_awarded_by_missions_total );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "kiosk_spent_total";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_3fe52b08c657d074( level.br_plunder.kiosk_spent_total );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "kiosk_num_purchases";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_3fe52b08c657d074( level.br_plunder.kiosk_num_purchases );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "extraction_balloon_total_value";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8cfd7cafbc5981e( level.br_plunder.extraction_balloon_total_plunder );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "extraction_balloon_total_extractions";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_3fe52b08c657d074( level.br_plunder.extraction_balloon_num_completed );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "extraction_helicoptor_total_value";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_dcaf784c32fdf05b( level.br_plunder.extraction_helicoptor_total_plunder );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "extraction_helicoptor_total_extractions";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_3fe52b08c657d074( level.br_plunder.extraction_helicoptor_num_completed );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "ingame_count_uncommon_1";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8cfd7cafbc5981e( level.br_plunder.itemsinworld[ "brloot_plunder_cash_uncommon_1" ] );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "ingame_count_uncommon_2";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8d8c3cafbcf8ad0( level.br_plunder.itemsinworld[ "brloot_plunder_cash_uncommon_2" ] );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "ingame_count_uncommon_3";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8d8c3cafbcf8ad0( level.br_plunder.itemsinworld[ "brloot_plunder_cash_uncommon_3" ] );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "ingame_count_rare_1";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8d8c3cafbcf8ad0( level.br_plunder.itemsinworld[ "brloot_plunder_cash_rare_1" ] );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "ingame_count_rare_2";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8cfd7cafbc5981e( level.br_plunder.itemsinworld[ "brloot_plunder_cash_rare_2" ] );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "ingame_count_epic_1";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8cfd7cafbc5981e( level.br_plunder.itemsinworld[ "brloot_plunder_cash_epic_1" ] );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "ingame_count_epic_2";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8cfd7cafbc5981e( level.br_plunder.itemsinworld[ "brloot_plunder_cash_epic_2" ] );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "ingame_count_legendary_1";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8cfd7cafbc5981e( level.br_plunder.itemsinworld[ "brloot_plunder_cash_legendary_1" ] );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "count_unopened_chests";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_f8d8c3cafbcf8ad0( level.br_plunder.itemsinworld[ "br_loot_cache" ] );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    eventparams[ eventparams.size ] = "count_available_missions";
    
    if ( isdefined( level.br_plunder ) )
    {
        eventparams[ eventparams.size ] = function_783acbcf408fa927( level.br_plunder.itemsinworld[ "missionTablets" ] );
    }
    else
    {
        eventparams[ eventparams.size ] = 0;
    }
    
    dlog_recordevent( "dlog_event_br_plunder_economy_snapshot", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x593d
// Size: 0x9c
function br_getprimaryandsecondaryweapons( player )
{
    primaryweaponobj = player getcurrentweapon();
    secondaryweaponobj = undefined;
    
    if ( isdefined( player.primaryweaponobj ) && primaryweaponobj != player.primaryweaponobj )
    {
        secondaryweaponobj = player.primaryweaponobj;
    }
    else if ( isdefined( player.secondaryweaponobj ) && primaryweaponobj != player.secondaryweaponobj )
    {
        secondaryweaponobj = player.secondaryweaponobj;
    }
    
    return [ safecheckweapon( primaryweaponobj ), safecheckweapon( secondaryweaponobj ) ];
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x59e2
// Size: 0x2e8
function branalytics_inventory_snapshot( player, reason )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    playerweapons = br_getprimaryandsecondaryweapons( player );
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "reason";
    eventparams[ eventparams.size ] = reason;
    eventparams[ eventparams.size ] = "primary_weapon";
    eventparams[ eventparams.size ] = playerweapons[ 0 ];
    eventparams[ eventparams.size ] = "secondary_weapon";
    eventparams[ eventparams.size ] = playerweapons[ 1 ];
    eventparams[ eventparams.size ] = "primary_equipment";
    eventparams[ eventparams.size ] = safecheckstring( player.equipment[ "primary" ] );
    eventparams[ eventparams.size ] = "secondary_equipment";
    eventparams[ eventparams.size ] = safecheckstring( player.equipment[ "secondary" ] );
    eventparams[ eventparams.size ] = "field_equipment";
    eventparams[ eventparams.size ] = safecheckstring( player.equipment[ "super" ] );
    eventparams[ eventparams.size ] = "has_gasmask";
    eventparams[ eventparams.size ] = isdefined( player.gasmaskequipped ) && player.gasmaskequipped == 1;
    eventparams[ eventparams.size ] = "armor_plates";
    eventparams[ eventparams.size ] = function_783acbcf408fa927( player scripts\mp\equipment::getequipmentslotammo( "health" ) );
    eventparams[ eventparams.size ] = "plunder_total";
    eventparams[ eventparams.size ] = function_dcb7ec4c3306db25( player.plundercount );
    eventparams[ eventparams.size ] = "plunder_banked";
    eventparams[ eventparams.size ] = function_dcb7ec4c3306db25( player.plunderbanked );
    eventparams[ eventparams.size ] = "ammo_smg";
    eventparams[ eventparams.size ] = function_dcaf784c32fdf05b( player.br_ammo[ "brloot_ammo_919" ] );
    eventparams[ eventparams.size ] = "ammo_ar_lmg";
    eventparams[ eventparams.size ] = function_dcaf784c32fdf05b( player.br_ammo[ "brloot_ammo_762" ] );
    eventparams[ eventparams.size ] = "ammo_shotgun";
    eventparams[ eventparams.size ] = function_dcaf784c32fdf05b( player.br_ammo[ "brloot_ammo_12g" ] );
    eventparams[ eventparams.size ] = "ammo_sniper";
    eventparams[ eventparams.size ] = function_dcaf784c32fdf05b( player.br_ammo[ "brloot_ammo_50cal" ] );
    eventparams[ eventparams.size ] = "ammo_rockets";
    eventparams[ eventparams.size ] = function_3fe52b08c657d074( player.br_ammo[ "brloot_ammo_rocket" ] );
    loadoutperks = player scripts\mp\utility\stats::getpersstat( "loadoutPerks" );
    
    for ( index = 0; index < 2 ; index++ )
    {
        perkname = "specialty_null";
        perkname = loadoutperks[ index ];
        eventparams[ eventparams.size ] = "base_perk_" + index + 1;
        eventparams[ eventparams.size ] = perkname;
    }
    
    bonusperk = "specialty_null";
    bonusperk = loadoutperks[ 2 ];
    eventparams[ eventparams.size ] = "bonus_perk";
    eventparams[ eventparams.size ] = bonusperk;
    ultimateperk = "specialty_null";
    ultimateperk = loadoutperks[ 3 ];
    eventparams[ eventparams.size ] = "ultimate_perk";
    eventparams[ eventparams.size ] = ultimateperk;
    player dlog_recordplayerevent( "dlog_event_br_inventory_snapshot", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0x5cd2
// Size: 0x10b
function function_6039c3ffa983858f( player, plunderspent, weaponref, attachmentrefs )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "plunder_spent";
    eventparams[ eventparams.size ] = plunderspent;
    eventparams[ eventparams.size ] = "player_plunder_after_purchase";
    eventparams[ eventparams.size ] = player.plundercount;
    eventparams[ eventparams.size ] = "weapon";
    eventparams[ eventparams.size ] = safecheckstring( weaponref );
    assert( -1 );
    assert( -1 );
    assert( attachmentrefs.size <= 7 );
    
    for ( var_9413831c8d06464c = 0; var_9413831c8d06464c < 7 ; var_9413831c8d06464c++ )
    {
        eventparams[ eventparams.size ] = string_join( [ "weapon_attachment_", string( var_9413831c8d06464c ) ] );
        
        if ( isdefined( attachmentrefs[ var_9413831c8d06464c ] ) )
        {
            eventparams[ eventparams.size ] = safecheckstring( attachmentrefs[ var_9413831c8d06464c ] );
            continue;
        }
        
        eventparams[ eventparams.size ] = "none";
    }
    
    player dlog_recordplayerevent( "dlog_event_br_kiosk_purchase_loadout_weapon", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x5de5
// Size: 0x174
function branalytics_kiosk_purchaseloadout( player, plunderspent, loadoutdata )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "plunder_spent";
    eventparams[ eventparams.size ] = plunderspent;
    eventparams[ eventparams.size ] = "player_plunder_after_purchase";
    eventparams[ eventparams.size ] = player.plundercount;
    eventparams[ eventparams.size ] = "primary_weapon";
    eventparams[ eventparams.size ] = safecheckstring( loadoutdata.loadoutprimaryfullname );
    eventparams[ eventparams.size ] = "secondary_weapon";
    eventparams[ eventparams.size ] = safecheckstring( loadoutdata.loadoutsecondaryfullname );
    eventparams[ eventparams.size ] = "primary_equipment";
    eventparams[ eventparams.size ] = safecheckstring( loadoutdata.loadoutequipmentprimary );
    eventparams[ eventparams.size ] = "secondary_equipment";
    eventparams[ eventparams.size ] = safecheckstring( loadoutdata.loadoutequipmentsecondary );
    eventparams[ eventparams.size ] = "base_perk_1";
    eventparams[ eventparams.size ] = safecheckstring( loadoutdata.loadoutperks[ 0 ] );
    eventparams[ eventparams.size ] = "base_perk_2";
    eventparams[ eventparams.size ] = safecheckstring( loadoutdata.loadoutperks[ 1 ] );
    eventparams[ eventparams.size ] = "bonus_perk";
    eventparams[ eventparams.size ] = safecheckstring( loadoutdata.var_15f3e6df722fb1cf );
    eventparams[ eventparams.size ] = "ultimate_perk";
    eventparams[ eventparams.size ] = safecheckstring( loadoutdata.var_15f3e5df722faf9c );
    player dlog_recordplayerevent( "dlog_event_br_kiosk_purchase_loadout", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0x5f61
// Size: 0xbb
function branalytics_kiosk_purchaseitem( player, plunderspent, purchasetype, itemname )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "plunder_spent";
    eventparams[ eventparams.size ] = function_dcaf784c32fdf05b( plunderspent );
    eventparams[ eventparams.size ] = "player_plunder_after_purchase";
    eventparams[ eventparams.size ] = function_dcaf784c32fdf05b( player.plundercount );
    eventparams[ eventparams.size ] = "purchase_type";
    eventparams[ eventparams.size ] = purchasetype;
    eventparams[ eventparams.size ] = "item_name";
    eventparams[ eventparams.size ] = itemname;
    player dlog_recordplayerevent( "dlog_event_br_kiosk_purchase_item", eventparams );
    
    if ( _branalytics_addeventallowed() )
    {
        function_eefaa754fc189980( "purchase", player, plunderspent, itemname );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0x6024
// Size: 0x151
function branalytics_kiosk_menu_event( player, menuevent, menueventparam, kiosktype )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( player, "kiosk_menu_owner" );
    eventparams[ eventparams.size ] = "kiosk_menu_owner_event";
    eventparams[ eventparams.size ] = menuevent;
    eventparams[ eventparams.size ] = "kiosk_menu_owner_event_param";
    
    if ( isdefined( menueventparam ) )
    {
        eventparams[ eventparams.size ] = menueventparam;
    }
    else
    {
        eventparams[ eventparams.size ] = "none";
    }
    
    eventparams[ eventparams.size ] = "kiosk_menu_owner_event_time";
    eventparams[ eventparams.size ] = gettime() - level.starttime;
    eventparams[ eventparams.size ] = "kiosk_menu_owner_kiosk";
    
    if ( isdefined( player.br_kiosk ) )
    {
        eventparams[ eventparams.size ] = player.br_kiosk.index;
    }
    else
    {
        eventparams[ eventparams.size ] = -1;
    }
    
    eventparams[ eventparams.size ] = "kiosk_menu_owner_allowed";
    eventparams[ eventparams.size ] = istrue( player.armorykioskpurchaseallowed );
    eventparams[ eventparams.size ] = "kiosk_menu_owner_error";
    
    if ( menuevent != "menu_close" && !isdefined( player.br_kiosk ) )
    {
        eventparams[ eventparams.size ] = "unexpected_undefined_kiosk";
    }
    else
    {
        eventparams[ eventparams.size ] = "none";
    }
    
    eventparams[ eventparams.size ] = "kiosk_type";
    
    if ( !isdefined( kiosktype ) )
    {
        kiosktype = "standard_kiosk";
    }
    
    eventparams[ eventparams.size ] = kiosktype;
    player dlog_recordplayerevent( "dlog_event_br_kiosk_menu_event", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0x617d
// Size: 0x9f
function branalytics_plunder_placed_into_extraction( player, method, location, var_987ebc0a48f683a2 )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "extraction_method";
    eventparams[ eventparams.size ] = method;
    eventparams[ eventparams.size ] = "plunder_placed_into_extraction";
    eventparams[ eventparams.size ] = var_987ebc0a48f683a2;
    eventparams[ eventparams.size ] = "extraction_point_x";
    eventparams[ eventparams.size ] = location[ 0 ];
    eventparams[ eventparams.size ] = "extraction_point_y";
    eventparams[ eventparams.size ] = location[ 1 ];
    eventparams[ eventparams.size ] = "extraction_point_z";
    eventparams[ eventparams.size ] = location[ 2 ];
    player dlog_recordplayerevent( "dlog_event_br_plunder_placed_into_extraction", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 5
// Checksum 0x0, Offset: 0x6224
// Size: 0xc6
function branalytics_plunder_extraction_success( num_depositers, var_987ebc0a48f683a2, method, contains_enemy_plunder, extraction_origin )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "num_depositers";
    eventparams[ eventparams.size ] = num_depositers;
    eventparams[ eventparams.size ] = "plunder_extracted";
    eventparams[ eventparams.size ] = var_987ebc0a48f683a2;
    eventparams[ eventparams.size ] = "method";
    eventparams[ eventparams.size ] = method;
    eventparams[ eventparams.size ] = "contains_enemy_plunder";
    eventparams[ eventparams.size ] = contains_enemy_plunder;
    eventparams[ eventparams.size ] = "extraction_origin_x";
    eventparams[ eventparams.size ] = extraction_origin[ 0 ];
    eventparams[ eventparams.size ] = "extraction_origin_y";
    eventparams[ eventparams.size ] = extraction_origin[ 1 ];
    eventparams[ eventparams.size ] = "extraction_origin_z";
    eventparams[ eventparams.size ] = extraction_origin[ 2 ];
    dlog_recordevent( "dlog_event_br_plunder_extraction_success", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0x62f2
// Size: 0xd6
function branalytics_plunder_extraction_failure( plunder_dropped, method, extraction_origin, destruction_origin )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "plunder_dropped";
    eventparams[ eventparams.size ] = plunder_dropped;
    eventparams[ eventparams.size ] = "method";
    eventparams[ eventparams.size ] = method;
    eventparams[ eventparams.size ] = "extraction_origin_x";
    eventparams[ eventparams.size ] = extraction_origin[ 0 ];
    eventparams[ eventparams.size ] = "extraction_origin_y";
    eventparams[ eventparams.size ] = extraction_origin[ 1 ];
    eventparams[ eventparams.size ] = "extraction_origin_z";
    eventparams[ eventparams.size ] = extraction_origin[ 2 ];
    eventparams[ eventparams.size ] = "destruction_origin_x";
    eventparams[ eventparams.size ] = destruction_origin[ 0 ];
    eventparams[ eventparams.size ] = "destruction_origin_y";
    eventparams[ eventparams.size ] = destruction_origin[ 1 ];
    eventparams[ eventparams.size ] = "destruction_origin_z";
    eventparams[ eventparams.size ] = destruction_origin[ 2 ];
    dlog_recordevent( "dlog_event_br_plunder_extraction_failure", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x63d0
// Size: 0x74
function branalytics_bonusxp_debugdata( xp, reason )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        xuid = self getxuid() + " " + reason;
    }
    else
    {
        xuid = "none " + reason;
    }
    
    xp = int( xp );
    
    if ( _branalytics_addeventallowed() )
    {
        _branalytics_addevent( "bonusXpDebug", ( 0, 0, 0 ), xp, xuid );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x644c
// Size: 0x57
function branalytics_vehiclespawned( vehicle, refname )
{
    if ( !scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        return;
    }
    
    if ( !branalytics_validation() )
    {
        return;
    }
    
    if ( _branalytics_addeventallowed() && isdefined( level.prematchendtime ) )
    {
        _branalytics_addeventdelayed( "vehicle", vehicle.origin, vehicle, refname );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x64ab
// Size: 0x195
function function_ac421483c1da1cf7( player, var_5dc83c5ead95eaf1 )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    var_b76e41d5b60f0388 = [];
    var_1db9bd7272f6efa9 = [];
    var_2c5f7eb6cc63bbc0 = undefined;
    var_6fbbc85b08bd2762 = 0;
    var_c9af2118242f6866 = undefined;
    var_b14a4932cdb690a4 = 0;
    
    foreach ( teamdata in var_5dc83c5ead95eaf1 )
    {
        successcount = teamdata.successcount;
        var_b76e41d5b60f0388[ var_b76e41d5b60f0388.size ] = successcount;
        var_2c5f7eb6cc63bbc0 = isdefined( var_2c5f7eb6cc63bbc0 ) ? min( var_2c5f7eb6cc63bbc0, successcount ) : successcount;
        var_6fbbc85b08bd2762 = max( var_6fbbc85b08bd2762, successcount );
        failcount = teamdata.failcount;
        var_1db9bd7272f6efa9[ var_1db9bd7272f6efa9.size ] = failcount;
        var_c9af2118242f6866 = isdefined( var_c9af2118242f6866 ) ? min( var_c9af2118242f6866, failcount ) : failcount;
        var_b14a4932cdb690a4 = max( var_b14a4932cdb690a4, failcount );
    }
    
    eventparams = [ "average_bounty_succeeded", array_average( var_b76e41d5b60f0388 ), "max_bounty_succeeded", var_6fbbc85b08bd2762, "min_bounty_succeeded", var_2c5f7eb6cc63bbc0, "average_bounty_failed", array_average( var_1db9bd7272f6efa9 ), "max_bounty_failed", var_b14a4932cdb690a4, "min_bounty_failed", var_c9af2118242f6866 ];
    dlog_recordevent( "dlog_event_br_bounty_royal_completed", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x6648
// Size: 0x69
function function_e77f36370162406c( player, redeploydrone )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "deployed_from_beacon";
    var_d77822da7628823 = isdefined( redeploydrone ) && istrue( redeploydrone.var_d77822da7628823 );
    eventparams[ eventparams.size ] = var_d77822da7628823;
    player dlog_recordplayerevent( "dlog_event_br_redeploy_drone_used", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x66b9
// Size: 0xae
function function_bfc305f32a65dee5( params )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [ "pos_x", params.pos[ 0 ], "pos_y", params.pos[ 1 ], "pos_z", params.pos[ 2 ], "circle_index", params.circle_index, "was_relocating", params.was_relocating ];
    dlog_recordevent( "dlog_event_br_redeploy_drone_destroyed", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x676f
// Size: 0x5d
function function_2053c090ebbe2e31( candeploy )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [ "beacon_can_deploy", candeploy, "total_beacon_deployed", level.var_4a77e3d00962be2.var_c19b8ce5116231f.size ];
    dlog_recordevent( "dlog_event_br_beacon_used", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x67d4
// Size: 0x46
function function_e02dbe00c1c7d0d7()
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [ "total_beacon_deployed", level.var_4a77e3d00962be2.var_c19b8ce5116231f.size ];
    dlog_recordevent( "dlog_event_br_beacon_destroyed", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0x6822
// Size: 0x71
function branalytics_inittablets( num_missions, num_missions_active, num_missions_hidden, hide_percent )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_mission_init", [ "num_missions", num_missions, "num_missions_active", num_missions_active, "num_missions_hidden", num_missions_hidden, "hide_percent", hide_percent ] );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0x689b
// Size: 0x71
function branalytics_delayedshowtablets( circle_index, show_percent, num_valid, num_shown )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_mission_repopulate", [ "circle_index", circle_index, "show_percent", show_percent, "num_valid", num_valid, "num_shown", num_shown ] );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x6914
// Size: 0x10a
function branalytics_spawntablet( tablet )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_mission_spawn", [ "id", ter_op( isdefined( tablet.index ), "" + tablet.index, "invalid" ), "type", tablet.type, "origin_x", tablet.origin[ 0 ], "origin_y", tablet.origin[ 1 ], "origin_z", tablet.origin[ 2 ] ] );
    
    if ( _branalytics_addeventallowed() && isdefined( tablet.index ) )
    {
        _branalytics_addeventdelayed( "mission", tablet.origin, "" + tablet.index, tablet.tablettype );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x6a26
// Size: 0xbe
function branalytics_invalidtablet( tablet )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_mission_invalid", [ "id", ter_op( isdefined( tablet.index ), "" + tablet.index, "invalid" ), "type", tablet.type, "origin_x", tablet.origin[ 0 ], "origin_y", tablet.origin[ 1 ], "origin_z", tablet.origin[ 2 ] ] );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x6aec
// Size: 0x194
function branalytics_missionstart( missioninstance, player )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    teammates = scripts\mp\utility\teams::getfriendlyplayers( player.team, 1 );
    eventparams = _branalytics_headerplayerposrow( eventparams, teammates );
    eventparams[ eventparams.size ] = "id";
    eventparams[ eventparams.size ] = isdefined( missioninstance.tablet ) && isdefined( missioninstance.tablet.index ) ? string( missioninstance.tablet.index ) : "invalid";
    
    if ( isdefined( level.br_circle ) )
    {
        circleindex = getintorzero( level.br_circle.circleindex );
    }
    else
    {
        circleindex = -1;
    }
    
    eventparams[ eventparams.size ] = "circle_index";
    eventparams[ eventparams.size ] = circleindex;
    eventparams[ eventparams.size ] = "type";
    
    if ( getdvarint( @"hash_82bde055b11e6698", 0 ) )
    {
        eventparams[ eventparams.size ] = missioninstance.questcategory;
    }
    else
    {
        eventparams[ eventparams.size ] = missioninstance.type.ref;
    }
    
    eventparams[ eventparams.size ] = "is_legendary";
    eventparams[ eventparams.size ] = istrue( self.islegendarycontract );
    player dlog_recordplayerevent( "dlog_event_br_mission_start", eventparams );
    
    if ( _branalytics_addeventallowed() && isdefined( missioninstance.missionid ) )
    {
        branalytics_seteventdelayedstate( "mission", missioninstance.missionid, -1 );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0x6c88
// Size: 0x1f6
function branalytics_missionend( missioninstance, questtier, results, numteamplayers )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_mission_end", [ "id", ter_op( isdefined( missioninstance.missionid ), missioninstance.missionid, "invalid" ), "result", ter_op( isdefined( missioninstance.result ), missioninstance.result, "unknown" ), "reward_tier", questtier, "xp", ter_op( isdefined( results[ "xp" ] ), results[ "xp" ], 0 ), "weapon_xp", ter_op( isdefined( results[ "weapon_xp" ] ), results[ "weapon_xp" ], 0 ), "plunder", ter_op( isdefined( results[ "plunder" ] ), results[ "plunder" ], 0 ), "num_teammates_awarded", ter_op( isdefined( numteamplayers ), numteamplayers, 0 ), "type", missioninstance.questcategory, "end_state", ter_op( isdefined( missioninstance.endstate ), missioninstance.endstate, "invalid" ), "is_legendary", istrue( missioninstance.islegendarycontract ) ] );
    
    if ( _branalytics_addeventallowed() && isdefined( missioninstance.missionid ) )
    {
        if ( isdefined( missioninstance.result ) && missioninstance.result == "success" )
        {
            branalytics_seteventdelayedstate( "mission", missioninstance.missionid, questtier );
            return;
        }
        
        branalytics_seteventdelayedstate( "mission", missioninstance.missionid, -1 );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x6e86
// Size: 0x245
function function_1d6052577cd7738c( teaminfo, endreason, success )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    teammates = scripts\mp\utility\teams::getfriendlyplayers( teaminfo.targetteam, 0 );
    teammatecount = teammates.size;
    eventparams[ eventparams.size ] = "end_reason";
    eventparams[ eventparams.size ] = endreason;
    eventparams[ eventparams.size ] = "state_progress";
    eventparams[ eventparams.size ] = ter_op( istrue( success ), 5, teaminfo.state );
    eventparams[ eventparams.size ] = "collected_beryllium";
    eventparams[ eventparams.size ] = istrue( teaminfo.var_876be3bc4df3a81d & namespace_6c622b52017c6808::function_2c126de0bdb9bfd5( namespace_6c622b52017c6808::function_6844602f3120e900( "ber", 6 ) ) );
    eventparams[ eventparams.size ] = "collected_plutonium";
    eventparams[ eventparams.size ] = istrue( teaminfo.var_876be3bc4df3a81d & namespace_6c622b52017c6808::function_2c126de0bdb9bfd5( namespace_6c622b52017c6808::function_6844602f3120e900( "plu", 6 ) ) );
    eventparams[ eventparams.size ] = "collected_tritium";
    eventparams[ eventparams.size ] = istrue( teaminfo.var_876be3bc4df3a81d & namespace_6c622b52017c6808::function_2c126de0bdb9bfd5( namespace_6c622b52017c6808::function_6844602f3120e900( "tri", 6 ) ) );
    eventparams[ eventparams.size ] = "collected_gallium";
    eventparams[ eventparams.size ] = istrue( teaminfo.var_876be3bc4df3a81d & namespace_6c622b52017c6808::function_2c126de0bdb9bfd5( namespace_6c622b52017c6808::function_6844602f3120e900( "gal", 6 ) ) );
    eventparams[ eventparams.size ] = "collected_deuterium";
    eventparams[ eventparams.size ] = istrue( teaminfo.var_876be3bc4df3a81d & namespace_6c622b52017c6808::function_2c126de0bdb9bfd5( namespace_6c622b52017c6808::function_6844602f3120e900( "deu", 6 ) ) );
    eventparams[ eventparams.size ] = "collected_neptunium";
    eventparams[ eventparams.size ] = istrue( teaminfo.var_876be3bc4df3a81d & namespace_6c622b52017c6808::function_2c126de0bdb9bfd5( namespace_6c622b52017c6808::function_6844602f3120e900( "nep", 6 ) ) );
    eventparams[ eventparams.size ] = "num_teammates";
    eventparams[ eventparams.size ] = teammatecount;
    
    foreach ( player in teammates )
    {
        player dlog_recordplayerevent( "dlog_event_br_elite_broken_arrow_end", eventparams );
    }
    
    successstate = istrue( success );
    _branalytics_addevent( "elite_broken_arrow_end", ( 0, 0, 0 ), successstate, endreason );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x70d3
// Size: 0x60
function function_f3c107faa06dc299( player, timeleft )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "time_until_detonation";
    eventparams[ eventparams.size ] = timeleft;
    player dlog_recordplayerevent( "dlog_event_br_elite_broken_arrow_defuse", eventparams );
    _branalytics_addevent( "elite_broken_arrow_defuse", player getorigin(), timeleft, "time_until_detonation", player );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x713b
// Size: 0x9a
function function_f36c99358d254ea9( player, element )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "element_id";
    eventparams[ eventparams.size ] = element.elementid;
    eventparams[ eventparams.size ] = "time_from_spawn";
    eventparams[ eventparams.size ] = gettime() - element.spawntime;
    player dlog_recordplayerevent( "dlog_event_br_elite_broken_arrow_element_collect", eventparams );
    _branalytics_addevent( "elite_broken_arrow_element_collect", player getorigin(), element.spawntime, element.elementid, player );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x71dd
// Size: 0x60
function function_523b126aa6b63c7( player, var_436204fba69d256 )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "time_from_bombsite_spawn";
    eventparams[ eventparams.size ] = var_436204fba69d256;
    player dlog_recordplayerevent( "dlog_event_br_elite_broken_arrow_arm", eventparams );
    _branalytics_addevent( "elite_broken_arrow_arm", player getorigin(), var_436204fba69d256, "time_from_bombsite_spawn", player );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x7245
// Size: 0x6e
function function_77814c1b523fd8a3( playercount, cancelreason, var_91ed55cb1c27f9d5 )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "player_count";
    eventparams[ eventparams.size ] = playercount;
    eventparams[ eventparams.size ] = "cancel_reason";
    eventparams[ eventparams.size ] = cancelreason;
    eventparams[ eventparams.size ] = "player_disconnect_count";
    eventparams[ eventparams.size ] = var_91ed55cb1c27f9d5;
    dlog_recordevent( "dlog_event_br_elite_broken_arrow_match_invalid", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x72bb
// Size: 0x2b
function function_5e512f1540e0e8a3( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "initialize_fortress_kiosk", origin, state );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x72ee
// Size: 0x35
function function_a82f819fddc8e099( origin, data, player )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "kiosk_unusable_for_player", origin, 0, data, player );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x732b
// Size: 0x2b
function function_1fe361a65f4321b1( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "remove_kiosk", origin, state );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x735e
// Size: 0x2b
function function_d647f8b91ee72e68( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "fortress_rejected", origin, state );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x7391
// Size: 0x2b
function function_cdf333517613e68d( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "spawn_blacksite", origin, state );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x73c4
// Size: 0x2b
function function_a9fe2bed8ed8b965( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "spawn_fortress", origin, state );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x73f7
// Size: 0x2b
function function_ce58220fbd0824be( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "unlock_all_blacksite_doors", origin, state );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x742a
// Size: 0x2b
function function_31406a57e628c3fe( origin, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "unlock_all_fortress_interior_doors", origin, state );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x745d
// Size: 0x2c
function function_aaf1156bacf6654e( origin, data )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "spawn_boss", origin, 0, data );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x7491
// Size: 0x22
function function_5c71b11655c95436( origin )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "unlock_first_blacksite_door", origin );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x74bb
// Size: 0x22
function function_257618a8537d8d10( origin )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "stronghold_captured", origin );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x74e5
// Size: 0x2c
function function_2cc353fdc725f4b4( origin, data )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "fortress_loot_zone", origin, 0, data );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x7519
// Size: 0x2c
function function_ea157b4b9615b2df( origin, data )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "fortress_undefined_zonebounds", origin, 0, data );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x754d
// Size: 0x2c
function function_41082d2a8cf1ee28( origin, data )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "fortress_mismatched_zonebounds", origin, 0, data );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x7581
// Size: 0x3a
function function_3461c9a3dbbccecf( interrogator, state, data )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "interrogation", interrogator getorigin(), state, data, interrogator );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x75c3
// Size: 0x36
function function_82b50d847253078f( victim, state )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    _branalytics_addevent( "interrogation_victim", victim getorigin(), state, "", victim );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x7601
// Size: 0x61
function branalytics_teameliminated( team, teamplacement )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_team_eliminated", [ "team", team, "placement", teamplacement, "survival_time", gettime() - level.starttime ] );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 6
// Checksum 0x0, Offset: 0x766a
// Size: 0x71
function function_cb3b3cbf2d1ac3f3( playerxp, weaponxp, lifeindex, weaponname, player, type )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    var_b4de36cb26159194 = "xp_event";
    
    /#
        var_b4de36cb26159194 = var_b4de36cb26159194 + "<dev string:x1c>" + getxhashsourcename( type );
    #/
    
    _branalytics_addevent( var_b4de36cb26159194, ( playerxp, weaponxp, 0 ), lifeindex, weaponname, player );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x76e3
// Size: 0x2f
function branalytics_publiceventstarted( eventtype )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_public_event_start", [ "type", eventtype ] );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x771a
// Size: 0x2f
function branalytics_publiceventended( eventtype )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    dlog_recordevent( "dlog_event_br_public_event_end", [ "type", eventtype ] );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x7751
// Size: 0x99
function _branalytics_header( player, playerstr )
{
    assert( !isdefined( playerstr ) || isstring( playerstr ) );
    header = [];
    
    if ( !isstring( playerstr ) )
    {
        playerstr = "player";
    }
    
    header = _branalytics_headerplayer( header, player, playerstr );
    
    if ( isdefined( level.br_circle ) )
    {
        circleindex = getintorzero( level.br_circle.circleindex );
    }
    else
    {
        circleindex = -1;
    }
    
    header[ header.size ] = "circle_index";
    header[ header.size ] = circleindex;
    return header;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x77f3
// Size: 0x18a
function _branalytics_headerplayer( header, player, playerstr )
{
    assert( isarray( header ) );
    assert( !isdefined( playerstr ) || isstring( playerstr ) );
    
    if ( !isstring( playerstr ) )
    {
        playerstr = "player";
    }
    
    assert( isdefined( player.origin ) && isfloat( player.origin[ 0 ] ) );
    assert( isdefined( player.origin ) && isfloat( player.origin[ 1 ] ) );
    assert( isdefined( player.origin ) && isfloat( player.origin[ 2 ] ) );
    assert( isfloat( getplayerpitch( player ) ) );
    assert( isfloat( getplayeryaw( player ) ) );
    header[ header.size ] = playerstr + "_x";
    header[ header.size ] = player.origin[ 0 ];
    header[ header.size ] = playerstr + "_y";
    header[ header.size ] = player.origin[ 1 ];
    header[ header.size ] = playerstr + "_z";
    header[ header.size ] = player.origin[ 2 ];
    header[ header.size ] = playerstr + "_pitch";
    header[ header.size ] = getplayerpitch( player );
    header[ header.size ] = playerstr + "_yaw";
    header[ header.size ] = getplayeryaw( player );
    return header;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x7986
// Size: 0x1b1
function _branalytics_headerplayerposrow( params, players )
{
    assert( isarray( params ) );
    params[ params.size ] = "living_player_pos";
    rowparams = [];
    
    foreach ( player in players )
    {
        assert( isdefined( player.origin ) && isfloat( player.origin[ 0 ] ) );
        assert( isdefined( player.origin ) && isfloat( player.origin[ 1 ] ) );
        assert( isdefined( player.origin ) && isfloat( player.origin[ 2 ] ) );
        assert( isfloat( getplayerpitch( player ) ) );
        assert( isfloat( getplayeryaw( player ) ) );
        rowparams[ rowparams.size ] = "x";
        rowparams[ rowparams.size ] = player.origin[ 0 ];
        rowparams[ rowparams.size ] = "y";
        rowparams[ rowparams.size ] = player.origin[ 1 ];
        rowparams[ rowparams.size ] = "z";
        rowparams[ rowparams.size ] = player.origin[ 2 ];
        rowparams[ rowparams.size ] = "pitch";
        rowparams[ rowparams.size ] = getplayerpitch( player );
        rowparams[ rowparams.size ] = "yaw";
        rowparams[ rowparams.size ] = getplayeryaw( player );
    }
    
    params[ params.size ] = rowparams;
    return params;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x7b40
// Size: 0x1b
function safecheckstring( data )
{
    if ( isdefined( data ) )
    {
        return data;
    }
    
    return "empty";
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x7b63
// Size: 0x25
function safecheckweapon( data )
{
    if ( isdefined( data ) )
    {
        return data.basename;
    }
    
    return "empty";
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x7b90
// Size: 0x36
function function_7069250582d42c1a( data, datamin, datamax )
{
    if ( isdefined( datamin ) )
    {
        if ( data < datamin )
        {
            return datamin;
        }
    }
    
    if ( isdefined( datamax ) )
    {
        if ( data > datamax )
        {
            return datamax;
        }
    }
    
    return data;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x7bcf
// Size: 0x3f
function function_783acbcf408fa927( data )
{
    if ( isdefined( data ) && isnumber( data ) )
    {
        data_min = -128;
        data_max = 127;
        return function_7069250582d42c1a( data, data_min, data_max );
    }
    
    return 0;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x7c17
// Size: 0x41
function function_f8cfd7cafbc5981e( data )
{
    if ( isdefined( data ) && isnumber( data ) )
    {
        data_min = -32768;
        data_max = 32767;
        return function_7069250582d42c1a( data, data_min, data_max );
    }
    
    return 0;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x7c61
// Size: 0x41
function function_f8d8c3cafbcf8ad0( data )
{
    if ( isdefined( data ) && isnumber( data ) )
    {
        data_min = undefined;
        data_max = 2147483647;
        return function_7069250582d42c1a( data, data_min, data_max );
    }
    
    return 0;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x7cab
// Size: 0x1d
function function_f8cb57cafbc088c7( data )
{
    if ( isdefined( data ) && isnumber( data ) )
    {
        return data;
    }
    
    return 0;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x7cd1
// Size: 0x3e
function function_3fe52b08c657d074( data )
{
    if ( isdefined( data ) && isnumber( data ) )
    {
        data_min = 0;
        data_max = 255;
        return function_7069250582d42c1a( data, data_min, data_max );
    }
    
    return 0;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x7d18
// Size: 0x3f
function function_dcaf784c32fdf05b( data )
{
    if ( isdefined( data ) && isnumber( data ) )
    {
        data_min = 0;
        data_max = 65535;
        return function_7069250582d42c1a( data, data_min, data_max );
    }
    
    return 0;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x7d60
// Size: 0x41
function function_dcb7ec4c3306db25( data )
{
    if ( isdefined( data ) && isnumber( data ) )
    {
        data_min = 0;
        data_max = 4294967295;
        return function_7069250582d42c1a( data, data_min, data_max );
    }
    
    return 0;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x7daa
// Size: 0x1d
function function_dca1e84c32ee9f26( data )
{
    if ( isdefined( data ) && isnumber( data ) )
    {
        return data;
    }
    
    return 0;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x7dd0
// Size: 0x2c
function safedivide( data, divisor )
{
    if ( !isdefined( divisor ) || divisor <= 0 )
    {
        return ( data / 1 );
    }
    
    return data / divisor;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x7e04
// Size: 0x263
function branalytics_endgame()
{
    if ( _branalytics_addeventallowed() )
    {
        if ( isdefined( level.delayedeventtypes[ "vehicle" ] ) )
        {
            foreach ( evt in level.delayedeventtypes[ "vehicle" ] )
            {
                if ( !isdefined( evt.ent ) )
                {
                    evt.state = 1;
                    continue;
                }
                
                if ( distancesquared( evt.origin, evt.ent.origin ) > squared( 1000 ) )
                {
                    evt.state = 1;
                }
            }
        }
        
        if ( isdefined( level.br_armory_kiosk ) )
        {
            foreach ( kiosk in level.br_armory_kiosk.scriptables )
            {
                state = 0;
                
                if ( istrue( kiosk.visible ) )
                {
                    state = 1;
                }
                
                time = 0;
                entnum = -1;
                function_bb96ecd805545b2e( "kiosk", kiosk.origin, state, time, "", entnum );
            }
        }
        
        foreach ( typearray in level.delayedeventtypes )
        {
            foreach ( ev in typearray )
            {
                if ( isdefined( ev ) )
                {
                    function_bb96ecd805545b2e( ev.type, ev.origin, ev.state, ev.time, ev.data, -1 );
                }
            }
        }
    }
    
    if ( true )
    {
        analyticswritecsv();
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x806f
// Size: 0x39, Type: bool
function function_b9c4d225e9548d8b()
{
    if ( !isdefined( level.prematchendtime ) )
    {
        return false;
    }
    
    if ( !istrue( level.var_47be1d1bb3b425a6 ) )
    {
        return false;
    }
    
    if ( isplayer( self ) )
    {
        return true;
    }
    
    if ( isagent( self ) )
    {
        return true;
    }
    
    return false;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x80b1
// Size: 0x18b
function function_90d7bfd05ed0fbe9()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "brAnalytics_agent_killed" );
    entnum = self getentitynumber();
    state = 0;
    data = "";
    nextstate = 0;
    nextdata = "";
    
    while ( true )
    {
        wait 30;
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        if ( isdefined( self.gulag ) && self.gulag == 1 )
        {
            continue;
        }
        
        if ( isagent( self ) )
        {
            if ( isdefined( self.enemy ) )
            {
                nextstate = self.enemy getentitynumber();
            }
            else
            {
                nextstate = 0;
            }
            
            if ( isdefined( self.behaviorpackage ) )
            {
                nextdata = self.behaviorpackage.behavior;
            }
            else
            {
                nextdata = "";
            }
        }
        else if ( isplayer( self ) )
        {
            if ( isdefined( self.plundercount ) )
            {
                nextstate = int( self.plundercount );
            }
            
            if ( isdefined( self.team ) )
            {
                nextdata = self.team;
            }
        }
        
        time = _branalytics_geteventtimestamp();
        
        if ( self.var_d5c444a3fbb7d030 < time - 30 || state != nextstate || data != nextdata )
        {
            self.var_d5c444a3fbb7d030 = time;
            state = nextstate;
            data = nextdata;
            function_bb96ecd805545b2e( "breadcrumb", self.origin, state, time, data, entnum );
        }
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x8244
// Size: 0x41
function function_f183d915239368b7( time )
{
    if ( !function_b9c4d225e9548d8b() )
    {
        return;
    }
    
    if ( !isdefined( self.var_d5c444a3fbb7d030 ) )
    {
        self.var_d5c444a3fbb7d030 = time;
        thread function_90d7bfd05ed0fbe9();
        return;
    }
    
    self.var_d5c444a3fbb7d030 = time;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x828d
// Size: 0x2c
function function_8e6652060309b9db( origin, data )
{
    if ( !_branalytics_addeventallowed() )
    {
        return;
    }
    
    _branalytics_addevent( "agent_alloc", origin, 0, data );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x82c1
// Size: 0x75
function function_252e45fc60e2a731( ent )
{
    if ( !isdefined( ent ) || !_branalytics_addeventallowed() )
    {
        return;
    }
    
    state = 0;
    
    if ( isdefined( ent.category ) && ent.category == "gulag" )
    {
        state = 1;
    }
    
    data = ent.agent_type;
    function_eefaa754fc189980( "agent_spawn", ent, state, data );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x833e
// Size: 0x1a1
function function_e3aef4fcb303cff( ent, madedormant, attacker )
{
    if ( !isdefined( ent ) || !_branalytics_addeventallowed() )
    {
        return;
    }
    
    ent notify( "brAnalytics_agent_killed" );
    
    if ( madedormant )
    {
        var_9c46fc77656f0e4b = "dormancy";
    }
    else if ( !isdefined( attacker ) || !( isagent( attacker ) || isplayer( attacker ) ) || !isdefined( attacker.classname ) || attacker.classname == "worldspawn" || attacker.classname == "script_vehicle" || attacker.classname == "script_model" || attacker.classname == "misc_turret" || attacker.classname == "misc_samsite" || attacker.classname == "trigger_hurt" || attacker.classname == "trigger_multiple" || attacker.classname == "script_origin" )
    {
        var_9c46fc77656f0e4b = "world";
    }
    else
    {
        attacker_weapon = attacker getcurrentweapon();
        var_9c46fc77656f0e4b = attacker_weapon.basename;
    }
    
    state = 0;
    
    if ( isdefined( madedormant ) && madedormant == 1 )
    {
        state = 1;
    }
    
    if ( isdefined( level.var_91abb8090412cc15 ) && var_9c46fc77656f0e4b != "world" && var_9c46fc77656f0e4b != "dormancy" )
    {
        [[ level.var_91abb8090412cc15 ]]( ent, attacker );
    }
    
    function_eefaa754fc189980( "agent_down", ent, state, var_9c46fc77656f0e4b );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x84e7
// Size: 0x2b
function function_5bd0a2d95d2e42a5( origin, state )
{
    if ( !_branalytics_addeventallowed() )
    {
        return;
    }
    
    _branalytics_addevent( "stronghold_spawn", origin, state );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x851a
// Size: 0x22
function function_f3cff8f31f5cdbf4( origin )
{
    if ( !_branalytics_addeventallowed() )
    {
        return;
    }
    
    _branalytics_addevent( "stronghold_despawn", origin );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x8544
// Size: 0xb0
function function_97ec7995c587bf25()
{
    if ( !getdvarint( @"hash_ec7375cc2a0ca633", 1 ) )
    {
        return;
    }
    
    level.var_536cd4e9de6c69e = [];
    
    if ( !scripts\mp\gametypes\br_gametypes::isbrgametypefuncdefined( "onPickupTakenIntoBackpack" ) )
    {
        scripts\mp\gametypes\br_gametypes::registerbrgametypefunc( "onPickupTakenIntoBackpack", &function_a9c8b07af07f6f06 );
    }
    
    level.var_e17717792ade97b2 = &function_35e00e890dfee7b4;
    level.var_3afacc0c3b10b7fe = &function_cd1564ca587bcd0d;
    level.var_722da533ca224c88 = &function_2d1b322de840d5f1;
    level.var_91abb8090412cc15 = &function_179b94929cc4c682;
    level.var_d127a6a056d31d74 = &function_16a3f35cbab3325a;
    level.var_18889818bace4953 = &function_99571774beb8163b;
    
    if ( scripts\mp\team_assimilation::function_6934349b7823d888() )
    {
        scripts\mp\team_assimilation::registerteamassimilatecallback( &function_d584faafa7c6c60c );
    }
    
    thread function_c116ff94ef26d3b0();
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x85fc
// Size: 0x99
function function_c116ff94ef26d3b0()
{
    level waittill( "game_ended" );
    
    if ( isdefined( level.var_f1073fbd45b59a06.var_df987907a483df89 ) && level.var_f1073fbd45b59a06.var_df987907a483df89.size > 0 )
    {
        foreach ( fortress in level.var_f1073fbd45b59a06.var_df987907a483df89 )
        {
            fortress function_df74213f854433f9();
        }
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x869d
// Size: 0x256
function function_16a3f35cbab3325a( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isdefined( self.fortress ) )
    {
        return;
    }
    
    if ( !player function_82043961042627e2( self.fortress ) )
    {
        return;
    }
    
    if ( isdefined( player.var_2c2f43dd4153f5a ) && isdefined( player.var_2c2f43dd4153f5a.fortress ) )
    {
        if ( player.var_2c2f43dd4153f5a.fortress == self.fortress )
        {
            if ( istrue( player.var_2c2f43dd4153f5a.timeoutpending ) )
            {
                player.var_2c2f43dd4153f5a.timeoutpending = 0;
            }
            
            return;
        }
        else
        {
            proxtrigger = player.var_2c2f43dd4153f5a.fortress.proximitytrigger;
            
            if ( isdefined( proxtrigger ) )
            {
                closervolume = function_7d3c7b86d9efcddb( player, self, proxtrigger );
                
                if ( !isdefined( closervolume ) || closervolume != self )
                {
                    return;
                }
            }
        }
    }
    else
    {
        closeststronghold = undefined;
        var_eb5819f16ab7d1a6 = undefined;
        
        foreach ( sh in level.var_f1073fbd45b59a06.var_df987907a483df89 )
        {
            if ( !isdefined( sh ) || !player function_82043961042627e2( sh ) )
            {
                continue;
            }
            
            dist = undefined;
            
            if ( isdefined( sh.missiontrigger ) && isdefined( sh.missiontrigger.origin ) )
            {
                dist = function_5b8de0654b1464a5( player, sh.missiontrigger );
            }
            else if ( isdefined( sh.proximitytrigger ) && isdefined( sh.proximitytrigger.origin ) )
            {
                dist = function_5b8de0654b1464a5( player, sh.proximitytrigger );
            }
            
            if ( isdefined( dist ) && ( !isdefined( closeststronghold ) || dist < var_eb5819f16ab7d1a6 ) )
            {
                closeststronghold = sh;
                var_eb5819f16ab7d1a6 = dist;
            }
        }
        
        if ( isdefined( closeststronghold ) )
        {
            player function_3a1f84a4281d12f9( closeststronghold );
        }
        
        return;
    }
    
    player function_3a1f84a4281d12f9( self.fortress );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2, eflags: 0x4
// Checksum 0x0, Offset: 0x88fb
// Size: 0xfe
function private function_3a1f84a4281d12f9( fortress, timestamp )
{
    if ( isdefined( self.var_9fcd93eb0b17894d ) && array_contains( self.var_9fcd93eb0b17894d, fortress ) )
    {
        return;
    }
    
    if ( isdefined( self.var_2c2f43dd4153f5a ) && isdefined( self.var_2c2f43dd4153f5a.fortress ) )
    {
        if ( self.var_2c2f43dd4153f5a.fortress == fortress )
        {
            if ( istrue( self.var_2c2f43dd4153f5a.timeoutpending ) )
            {
                self.var_2c2f43dd4153f5a.timeoutpending = 0;
            }
            
            return;
        }
        else
        {
            function_708329f09283076( "entered_different_stronghold", 0 );
        }
    }
    
    self.var_2c2f43dd4153f5a = spawnstruct();
    self.var_2c2f43dd4153f5a.fortress = fortress;
    self.var_2c2f43dd4153f5a.var_ae4763248a440471 = 1;
    
    if ( !isdefined( timestamp ) )
    {
        timestamp = gettime();
    }
    
    fortress function_36fc8bc7e3143858( self, timestamp );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x8a01
// Size: 0xfe
function private function_708329f09283076( reason, success, timestamp )
{
    if ( !isdefined( self.var_2c2f43dd4153f5a ) || !isdefined( self.var_2c2f43dd4153f5a.fortress ) )
    {
        return;
    }
    
    fortress = self.var_2c2f43dd4153f5a.fortress;
    
    if ( istrue( self.var_2c2f43dd4153f5a.timeoutpending ) )
    {
        self.var_2c2f43dd4153f5a.timeoutpending = 0;
    }
    
    fortress function_17f1328aa045b61d( self, reason, success, timestamp );
    self.var_2c2f43dd4153f5a = undefined;
    
    if ( isdefined( fortress.teamattempts[ self.team ].activeplayers ) && fortress.teamattempts[ self.team ].activeplayers.size <= 0 )
    {
        fortress function_28e81a288cb740fd( self.team, success );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x8b07
// Size: 0x6e, Type: bool
function function_82043961042627e2( fortress )
{
    if ( !namespace_bd614c3c2275579a::function_397209b257df87a() )
    {
        return false;
    }
    
    if ( isdefined( fortress.capturedteam ) && fortress.capturedteam == self.team )
    {
        return false;
    }
    
    if ( istrue( fortress.isblacksite ) )
    {
        return ( istrue( fortress.unlocked ) && !istrue( fortress.captured ) );
    }
    
    return true;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0x8b7e
// Size: 0xe6
function function_7d3c7b86d9efcddb( player, volume1, volume2 )
{
    assert( isdefined( player ) );
    
    if ( !isdefined( volume1 ) )
    {
        return volume2;
    }
    else if ( !isdefined( volume2 ) )
    {
        return volume1;
    }
    
    var_585d11c8b1db05fa = ispointinvolume( player.origin, volume1 );
    var_585d10c8b1db03c7 = ispointinvolume( player.origin, volume2 );
    
    if ( !var_585d11c8b1db05fa )
    {
        if ( !var_585d10c8b1db03c7 )
        {
            return undefined;
        }
        else
        {
            return volume2;
        }
    }
    else if ( !var_585d10c8b1db03c7 )
    {
        return volume1;
    }
    
    var_75837491258e8569 = distance( player.origin, volume1.origin );
    var_4f2883195384eecc = distance( player.origin, volume2.origin );
    
    if ( var_4f2883195384eecc > var_75837491258e8569 )
    {
        return volume1;
    }
    else if ( var_75837491258e8569 > var_4f2883195384eecc )
    {
        return volume2;
    }
    
    return undefined;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x8c6d
// Size: 0x5b
function function_5b8de0654b1464a5( player, volume )
{
    if ( isdefined( player ) && isdefined( player.origin ) && isdefined( volume ) && isdefined( volume.origin ) )
    {
        return distance( player.origin, volume.origin );
    }
    
    return undefined;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x8cd1
// Size: 0x7a
function function_99571774beb8163b( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( isdefined( player.var_2c2f43dd4153f5a ) )
    {
        if ( istrue( player.var_2c2f43dd4153f5a.timeoutpending ) )
        {
            return;
        }
        
        player.var_2c2f43dd4153f5a.timeoutpending = 1;
        player.var_2c2f43dd4153f5a.timeoutstart = gettime();
        thread function_e751288a23e6e9ea( player );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x8d53
// Size: 0xab
function function_e751288a23e6e9ea( player )
{
    player endon( "stop_timeout" );
    player endon( "death_or_disconnect" );
    
    while ( isdefined( player.var_2c2f43dd4153f5a ) && istrue( player.var_2c2f43dd4153f5a.timeoutpending ) )
    {
        currenttime = gettime();
        
        if ( currenttime - player.var_2c2f43dd4153f5a.timeoutstart >= getdvarint( @"hash_f09a64ced68b366e", 5000 ) && istrue( player.var_2c2f43dd4153f5a.timeoutpending ) )
        {
            function_cf0f7529918e7772( player );
            return;
        }
        
        wait 0.2;
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x8e06
// Size: 0x9d
function function_4eb467c8f2a4c7ae( damagedata )
{
    victim = damagedata.victim;
    
    if ( isdefined( victim.modifiers ) && istrue( victim.modifiers[ "victiminstronghold" ] ) )
    {
        var_831b0df5dbb687cf = namespace_9823ee6035594d67::function_c0a211a69f5f8f2f( victim.origin );
        
        if ( isdefined( var_831b0df5dbb687cf ) )
        {
            if ( !isdefined( var_831b0df5dbb687cf.playerdeaths ) )
            {
                var_831b0df5dbb687cf.playerdeaths = 0;
            }
            
            var_831b0df5dbb687cf.playerdeaths++;
            victim function_708329f09283076( "killed", 0 );
        }
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x8eab
// Size: 0x19
function function_cf0f7529918e7772( player )
{
    player function_708329f09283076( "timeout", 0 );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x8ecc
// Size: 0x78
function function_179b94929cc4c682( ent, attacker )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    agentstruct = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata( ent, "agentStruct" );
    
    if ( isdefined( agentstruct ) )
    {
        fortress = agentstruct.fortress;
        
        if ( isdefined( fortress ) )
        {
            if ( !isdefined( fortress.agentskilled ) )
            {
                fortress.agentskilled = 0;
            }
            
            fortress.agentskilled++;
        }
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x8f4c
// Size: 0xeb
function function_a9c8b07af07f6f06( pickupent )
{
    if ( scripts\mp\gametypes\br_pickups::function_2d86ba79a58bb62( pickupent.scriptablename ) )
    {
        fortress = undefined;
        blacksite = undefined;
        
        if ( isdefined( pickupent.instance ) && isdefined( pickupent.instance.var_a88417917d64076c ) && isdefined( pickupent.instance.blacksite ) )
        {
            fortress = pickupent.instance.var_a88417917d64076c;
            blacksite = pickupent.instance.blacksite;
        }
        else
        {
            fortress = pickupent.var_a88417917d64076c;
            blacksite = pickupent.blacksite;
        }
        
        if ( isdefined( fortress ) )
        {
            fortress.keypickedup = 1;
        }
        
        if ( isdefined( blacksite ) )
        {
            blacksite.keypickedup = 1;
        }
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x903f
// Size: 0x57
function function_2d1b322de840d5f1( door, player )
{
    stronghold = door.fortress;
    
    if ( istrue( stronghold.isblacksite ) && !isdefined( stronghold.keyused ) )
    {
        stronghold.keyused = 1;
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x909e
// Size: 0x222
function function_cd1564ca587bcd0d( teamname, success )
{
    if ( !isdefined( self.missioncleared ) )
    {
        self.missioncleared = istrue( success );
    }
    
    task = self.task;
    teams = function_a86bde7020ad5a77( task );
    
    if ( !isdefined( teams ) || teams.size <= 0 )
    {
        teams = [ teamname ];
    }
    
    foreach ( team in teams )
    {
        if ( isdefined( team ) && isdefined( self.teamattempts ) && isdefined( self.teamattempts[ team ] ) && isdefined( self.teamattempts[ team ].activeplayers ) )
        {
            teammembers = level.teamdata[ team ][ "players" ];
            reason = undefined;
            
            if ( istrue( success ) && team == teamname )
            {
                reason = "mission_success";
            }
            else if ( istrue( success ) )
            {
                reason = "mission_completed_by_another_team";
            }
            else
            {
                reason = "mission_failed";
            }
            
            foreach ( player in teammembers )
            {
                if ( istrue( success ) )
                {
                    if ( team == teamname || istrue( self.isblacksite ) )
                    {
                        if ( !isdefined( player.var_9fcd93eb0b17894d ) )
                        {
                            player.var_9fcd93eb0b17894d = [];
                        }
                        
                        player.var_9fcd93eb0b17894d[ player.var_9fcd93eb0b17894d.size ] = self;
                    }
                }
                
                if ( !isdefined( self.teamattempts[ team ] ) )
                {
                    break;
                }
                
                if ( array_contains( self.teamattempts[ team ].activeplayers, player ) )
                {
                    player function_708329f09283076( reason, istrue( success ) && team == teamname );
                }
            }
        }
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x92c8
// Size: 0xfa
function function_35e00e890dfee7b4( teamname, success )
{
    teammembers = level.teamdata[ teamname ][ "players" ];
    reason = undefined;
    
    if ( istrue( success ) )
    {
        reason = "mission_success";
    }
    else
    {
        reason = "mission_failed";
    }
    
    foreach ( player in teammembers )
    {
        if ( istrue( success ) )
        {
            if ( !isdefined( player.var_9fcd93eb0b17894d ) )
            {
                player.var_9fcd93eb0b17894d = [];
            }
            
            player.var_9fcd93eb0b17894d[ player.var_9fcd93eb0b17894d.size ] = self;
        }
        
        if ( array_contains( self.teamattempts[ teamname ].activeplayers, player ) )
        {
            player function_708329f09283076( reason, istrue( success ) );
        }
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x93ca
// Size: 0x105
function private function_a86bde7020ad5a77( task )
{
    if ( isdefined( task.teams ) && task.teams.size > 0 )
    {
        return task.teams;
    }
    
    teams = [];
    
    foreach ( player in level.players )
    {
        if ( !array_contains( teams, player.team ) && isdefined( player.var_2c2f43dd4153f5a ) && isdefined( player.var_2c2f43dd4153f5a.fortress ) && player.var_2c2f43dd4153f5a.fortress.task == task )
        {
            teams[ teams.size ] = player.team;
        }
    }
    
    return teams;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x94d8
// Size: 0x175
function private function_d584faafa7c6c60c( player, oldteam, newteam )
{
    if ( isdefined( player.var_2c2f43dd4153f5a ) && isdefined( player.var_2c2f43dd4153f5a.fortress ) )
    {
        fortress = player.var_2c2f43dd4153f5a.fortress;
        
        if ( isdefined( fortress.teamattempts ) && array_contains_key( fortress.teamattempts, oldteam ) )
        {
            fortress function_17f1328aa045b61d( self, "assimilation", 0, undefined, oldteam );
            
            if ( isdefined( fortress.teamattempts[ oldteam ].activeplayers ) && fortress.teamattempts[ oldteam ].activeplayers.size <= 0 )
            {
                if ( isdefined( fortress.teamattempts[ oldteam ].var_5f8fc154303502fa ) && ( fortress.teamattempts[ oldteam ].var_5f8fc154303502fa.size > 1 || fortress.teamattempts[ oldteam ].var_5f8fc154303502fa.size == 1 && fortress.teamattempts[ oldteam ].var_5f8fc154303502fa[ 0 ] != player ) )
                {
                    fortress function_28e81a288cb740fd( oldteam, 0 );
                }
                else
                {
                    fortress.teamattempts[ oldteam ] = undefined;
                }
            }
        }
        
        fortress function_36fc8bc7e3143858( player, undefined, "assimilation" );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0x9655
// Size: 0x28d
function private function_36fc8bc7e3143858( player, timestamp, reason )
{
    fortress = self;
    
    if ( !isdefined( fortress.teamattempts ) )
    {
        fortress.teamattempts = [];
    }
    
    fortress function_3a3fa57e7d5a15bc( player.team );
    
    if ( !array_contains( fortress.teamattempts[ player.team ].var_5f8fc154303502fa, player ) )
    {
        fortress.teamattempts[ player.team ].var_5f8fc154303502fa[ fortress.teamattempts[ player.team ].var_5f8fc154303502fa.size ] = player;
    }
    
    if ( !array_contains( fortress.teamattempts[ player.team ].activeplayers, player ) )
    {
        fortress.teamattempts[ player.team ].activeplayers[ fortress.teamattempts[ player.team ].activeplayers.size ] = player;
    }
    
    if ( !isdefined( fortress.teamattempts[ player.team ].attemptevents ) )
    {
        fortress.teamattempts[ player.team ].attemptevents = [];
    }
    
    attemptevent = spawnstruct();
    attemptevent.unoid = player getplayerunoid();
    attemptevent.type = "attempt_enter";
    
    if ( isdefined( reason ) )
    {
        attemptevent.reason = reason;
    }
    else
    {
        attemptevent.reason = "enter_volume";
    }
    
    if ( isdefined( timestamp ) )
    {
        attemptevent.timestamp = timestamp;
    }
    else
    {
        attemptevent.timestamp = gettime();
    }
    
    if ( !isdefined( fortress.teamattempts[ player.team ].attemptevents ) )
    {
        fortress.teamattempts[ player.team ].attemptevents = [];
    }
    
    fortress.teamattempts[ player.team ].attemptevents[ fortress.teamattempts[ player.team ].attemptevents.size ] = attemptevent;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 5, eflags: 0x4
// Checksum 0x0, Offset: 0x98ea
// Size: 0x1cf
function private function_17f1328aa045b61d( player, reason, success, timestamp, team )
{
    fortress = self;
    
    if ( !isdefined( team ) )
    {
        team = player.team;
    }
    
    if ( !isdefined( fortress.teamattempts ) )
    {
        fortress.teamattempts = [];
    }
    
    if ( !array_contains_key( fortress.teamattempts, team ) )
    {
        fortress.teamattempts[ team ] = spawnstruct();
    }
    
    if ( isdefined( fortress.teamattempts[ team ].activeplayers ) && array_contains( fortress.teamattempts[ team ].activeplayers, player ) )
    {
        fortress.teamattempts[ team ].activeplayers = array_remove( fortress.teamattempts[ team ].activeplayers, player );
    }
    
    attemptevent = spawnstruct();
    attemptevent.unoid = player getplayerunoid();
    attemptevent.type = "attempt_exit";
    attemptevent.reason = reason;
    
    if ( isdefined( timestamp ) )
    {
        attemptevent.timestamp = timestamp;
    }
    else
    {
        attemptevent.timestamp = gettime();
    }
    
    if ( !isdefined( fortress.teamattempts[ team ].attemptevents ) )
    {
        fortress.teamattempts[ team ].attemptevents = [];
    }
    
    fortress.teamattempts[ team ].attemptevents[ fortress.teamattempts[ team ].attemptevents.size ] = attemptevent;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x9ac1
// Size: 0x109
function function_3a3fa57e7d5a15bc( team )
{
    fortress = self;
    
    if ( !isdefined( fortress.teamattempts ) )
    {
        fortress.teamattempts = [];
    }
    
    if ( array_contains_key( fortress.teamattempts, team ) )
    {
        return;
    }
    
    var_2838f16e236f9729 = spawnstruct();
    var_2838f16e236f9729.activeplayers = [];
    var_2838f16e236f9729.fortress = string( fortress.name );
    var_2838f16e236f9729.starttime = gettime();
    var_2838f16e236f9729.endtime = undefined;
    var_2838f16e236f9729.team = team;
    var_2838f16e236f9729.var_5f8fc154303502fa = [];
    var_2838f16e236f9729.mission = fortress.task.ref;
    
    if ( isdefined( fortress.missioncleared ) )
    {
        var_2838f16e236f9729.mission = "secondary_objective";
    }
    
    fortress.teamattempts[ team ] = var_2838f16e236f9729;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0x9bd2
// Size: 0xf9
function function_28e81a288cb740fd( team, success )
{
    assert( isdefined( team ) && array_contains_key( self.teamattempts, team ) );
    
    if ( !isdefined( self.attempts ) )
    {
        self.attempts = 0;
    }
    
    self.attempts++;
    
    if ( istrue( success ) )
    {
        if ( !isdefined( self.successes ) )
        {
            self.successes = 0;
        }
        
        self.successes++;
    }
    else
    {
        if ( !isdefined( self.failures ) )
        {
            self.failures = 0;
        }
        
        self.failures++;
    }
    
    attemptstruct = self.teamattempts[ team ];
    attemptstruct.endtime = gettime();
    attemptstruct.success = success;
    attemptstruct.teamsize = scripts\mp\utility\teams::getteamcount( team, 0 );
    self.teamattempts[ team ] = undefined;
    function_f36fb22c2233a40c( attemptstruct );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 1
// Checksum 0x0, Offset: 0x9cd3
// Size: 0x1d1
function function_f36fb22c2233a40c( attemptdata )
{
    playerevents = [];
    
    if ( isdefined( attemptdata.attemptevents ) && attemptdata.attemptevents.size > 0 )
    {
        foreach ( ae in attemptdata.attemptevents )
        {
            playerevents[ playerevents.size ] = [ "event_type", ae.type, "reason", ae.reason, "timestamp", ae.timestamp, "uno_id", ae.unoid ];
        }
    }
    
    var_775ff28d397a2b6 = [ "player_events", playerevents, "fortress", attemptdata.fortress, "success", attemptdata.success, "mission", attemptdata.mission, "start_time", attemptdata.starttime, "end_time", attemptdata.endtime, "team", attemptdata.team, "team_size", attemptdata.teamsize, "team_participation_count", attemptdata.var_5f8fc154303502fa.size ];
    dlog_recordevent( "dlog_event_br_stronghold_attempt", var_775ff28d397a2b6 );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0x9eac
// Size: 0x21b
function function_8ed813c1b731ca42()
{
    player = self;
    playerteam = player.sessionteam;
    
    if ( !isdefined( playerteam ) )
    {
        playerteam = player.team;
    }
    
    teamsize = scripts\mp\utility\teams::getteamcount( playerteam, 0 );
    maxteamsize = scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb();
    
    if ( teamsize > maxteamsize )
    {
        params = [ "utc_connect_time_s", player.pers[ "telemetry" ].utc_connect_time_s, "team", playerteam, "join_type", player getjointype(), "skill", player getskill(), "party_id", player getpartyid(), "is_party_host", istrue( level.onlinegame ) ? player isfireteamleader() : 0, "was_keyboardmouse", player function_989faa3e2f2d8c47() != 1, "map", level.mapname, "playlist_id", getplaylistid(), "playlist_name", getplaylistname(), "game_type", getgametype(), "sub_game_type", scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5(), "connect_index", isdefined( player.pers[ "telemetry" ].connect_index ) ? player.pers[ "telemetry" ].connect_index : 0, "lobby_id", isdefined( getlobbyid() ) ? getlobbyid() : "", "is_ranked", istrue( level.leagueplaymatch ) || istrue( level.var_77907d733abe8b63 ) ? 1 : 0 ];
        player dlog_recordplayerevent( "dlog_event_br_player_oversize_team", params );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0xa0cf
// Size: 0x2d0
function function_df74213f854433f9()
{
    poi = "unknown";
    shname = "unknown";
    shorigin = "unknown";
    shtier = namespace_bd614c3c2275579a::function_b7a9796c95aa8e8d();
    attempts = 0;
    successes = 0;
    failures = 0;
    playerdeaths = 0;
    agentdeaths = 0;
    loadoutstaken = 0;
    missioncleared = 0;
    keypickedup = istrue( self.keypickedup );
    unlocked = istrue( self.isblacksite ) && istrue( self.unlocked );
    
    if ( isdefined( self.poiname ) )
    {
        poi = self.poiname;
    }
    
    if ( isdefined( self.name ) )
    {
        shname = string( self.name );
    }
    
    if ( isdefined( self.origin ) )
    {
        shorigin = string( self.origin );
    }
    
    if ( isdefined( self.attempts ) )
    {
        attempts = self.attempts;
    }
    
    if ( isdefined( self.successes ) )
    {
        successes = self.successes;
    }
    
    if ( isdefined( self.failures ) )
    {
        failures = self.failures;
    }
    
    if ( isdefined( self.playerdeaths ) )
    {
        playerdeaths = self.playerdeaths;
    }
    
    if ( isdefined( self.agentskilled ) )
    {
        agentdeaths = self.agentskilled;
    }
    
    if ( isdefined( self.crate ) && isdefined( self.crate.var_4261eb2ab67db6f7 ) )
    {
        loadoutstaken = self.crate.var_4261eb2ab67db6f7.size;
    }
    
    if ( isdefined( self.missioncleared ) )
    {
        missioncleared = istrue( self.missioncleared );
    }
    
    args = [ "poi", poi, "name", shname, "origin", shorigin, "tier", shtier, "is_blacksite", istrue( self.isblacksite ), "attempts", attempts, "successes", successes, "failures", failures, "player_deaths", playerdeaths, "ai_deaths", agentdeaths, "loadouts_taken", loadoutstaken, "mission_cleared", missioncleared, "key_picked_up", keypickedup, "blacksite_unlocked", unlocked ];
    dlog_recordevent( "dlog_event_br_stronghold_data", args );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0xa3a7
// Size: 0x24a
function initcashtracking()
{
    level.cashtypes = [];
    level.cashtypes[ level.cashtypes.size ] = "loot";
    level.cashtypes[ level.cashtypes.size ] = "mission";
    level.cashtypes[ level.cashtypes.size ] = "combat";
    level.cashtypes[ level.cashtypes.size ] = "cache";
    level.cashtypes[ level.cashtypes.size ] = "cache_legendary";
    level.cashtypes[ level.cashtypes.size ] = "cache_scavenger";
    level.cashtypes[ level.cashtypes.size ] = "cache_secretstash";
    level.cashtypes[ level.cashtypes.size ] = "reusable_cache";
    level.cashtypes[ level.cashtypes.size ] = "cache_personal_supply";
    level.cashtypes[ level.cashtypes.size ] = "cache_personal_legacy";
    level.cashtypes[ level.cashtypes.size ] = "loot_chopper";
    level.cashtypes[ level.cashtypes.size ] = "c130_box";
    level.cashmetrics = [];
    
    foreach ( team in level.teamnamelist )
    {
        data = spawnstruct();
        data.sources = [];
        data.totaldata = [];
        
        foreach ( type in level.cashtypes )
        {
            data.sources[ type ] = 0;
            data.totaldata[ type ] = 0;
        }
        
        level.cashmetrics[ team ] = data;
    }
    
    level waittill( "prematch_done" );
    level thread recordinterval();
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0xa5f9
// Size: 0x33f
function recordinterval()
{
    for ( waittime = 60; !istrue( level.gameended ) ; waittime = max( 60 - updatetime, 0 ) )
    {
        level waittill_notify_or_timeout( "game_ended", waittime );
        starttime = gettime();
        placements = scripts\mp\gamescore::getteamscoreplacements();
        
        foreach ( team in level.teamnamelist )
        {
            if ( !isdefined( team ) )
            {
                continue;
            }
            
            time = scripts\mp\matchdata::gettimefrommatchstart( gettime() );
            eventparams = [];
            eventparams[ eventparams.size ] = "match_complete";
            eventparams[ eventparams.size ] = 0;
            eventparams[ eventparams.size ] = "time";
            eventparams[ eventparams.size ] = time;
            eventparams[ eventparams.size ] = "team";
            eventparams[ eventparams.size ] = team;
            eventparams[ eventparams.size ] = "placement";
            eventparams[ eventparams.size ] = placements[ team ];
            
            foreach ( type in level.cashtypes )
            {
                value = level.cashmetrics[ team ].sources[ type ];
                eventparams[ eventparams.size ] = "cash_source_" + type;
                eventparams[ eventparams.size ] = value;
                level.cashmetrics[ team ].totaldata[ type ] += value;
                level.cashmetrics[ team ].sources[ type ] = 0;
            }
            
            dlog_recordevent( "dlog_event_blood_money_interval", eventparams );
            waitframe();
        }
        
        updatetime = ( gettime() - starttime ) * 0.001;
    }
    
    time = scripts\mp\matchdata::gettimefrommatchstart( gettime() );
    placements = scripts\mp\gamescore::getteamscoreplacements();
    
    foreach ( team in level.teamnamelist )
    {
        eventparams = [];
        eventparams[ eventparams.size ] = "match_complete";
        eventparams[ eventparams.size ] = 1;
        eventparams[ eventparams.size ] = "time";
        eventparams[ eventparams.size ] = time;
        eventparams[ eventparams.size ] = "team";
        eventparams[ eventparams.size ] = team;
        eventparams[ eventparams.size ] = "placement";
        eventparams[ eventparams.size ] = placements[ team ];
        
        foreach ( type in level.cashtypes )
        {
            value = level.cashmetrics[ team ].totaldata[ type ];
            eventparams[ eventparams.size ] = "cash_source_" + type;
            eventparams[ eventparams.size ] = value;
        }
        
        dlog_recordevent( "dlog_event_blood_money_interval", eventparams );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0xa940
// Size: 0x88
function trackcashevent( player, type, amount )
{
    if ( !isdefined( level.cashmetrics ) || !isdefined( player ) || !isdefined( player.team ) )
    {
        return;
    }
    
    team = player.team;
    level.cashmetrics[ team ].sources[ type ] += amount;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0xa9d0
// Size: 0xa
function onmatchstartbr()
{
    thread _onmatchstartbr();
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0xa9e2
// Size: 0x3eb
function _onmatchstartbr()
{
    waittillframeend();
    assert( isstring( level.brgametype.name ) );
    assert( isarray( level.players ) );
    subgametype = level.brgametype.name;
    maxteamsize = getintorzero( level.maxteamsize );
    playercount = getintorzero( level.players.size );
    teamcount = getteamcount();
    humanplayercount = 0;
    
    foreach ( player in level.players )
    {
        if ( isbot( player ) || player isplayerheadless() )
        {
            continue;
        }
        
        humanplayercount++;
    }
    
    if ( isdefined( level.br_armory_kiosk ) )
    {
        kioskrespawncost = getintorzero( level.br_armory_kiosk.teamrevivecost );
    }
    else
    {
        kioskrespawncost = 0;
    }
    
    var_5ceaea1d11f6f7f5 = getintorzero( level.usegulag );
    
    if ( isdefined( level.gulag ) )
    {
        gulagmaxuses = getintorzero( level.gulag.maxuses );
        gulagstartingarmor = getintorzero( level.gulag.numarmorhealth );
        gulagspawnloot = getintorzero( level.gulag.spawnloot );
    }
    else
    {
        gulagmaxuses = 0;
        gulagstartingarmor = 0;
        gulagspawnloot = 0;
    }
    
    missiontypeinfo = [];
    
    if ( getdvarint( @"hash_90a3dfd557408611", 1 ) && isdefined( level.questinfo ) )
    {
        foreach ( type, info in level.questinfo.tabletinfo )
        {
            assert( isstring( type ) );
            missiontypeinfo[ missiontypeinfo.size ] = "name";
            missiontypeinfo[ missiontypeinfo.size ] = type;
            isenabled = isdefined( info ) && istrue( info.enabled );
            missiontypeinfo[ missiontypeinfo.size ] = "is_enabled";
            missiontypeinfo[ missiontypeinfo.size ] = isenabled;
        }
    }
    
    playlistid = getintorzero( getplaylistid() );
    
    if ( isdefined( level.prematchendtime ) )
    {
        prematchendtime = level.prematchendtime;
    }
    else
    {
        prematchendtime = -1;
    }
    
    frame_duration = getframeduration();
    dlog_recordevent( "dlog_event_br_server_match_start", [ "br_mission_type_info", missiontypeinfo, "map", level.script, "sub_game_type", subgametype, "max_team_size", maxteamsize, "player_count", playercount, "human_player_count", humanplayercount, "team_count", teamcount, "kiosk_respawn_cost", kioskrespawncost, "gulag_active", var_5ceaea1d11f6f7f5, "gulag_max_uses", gulagmaxuses, "gulag_starting_armor", gulagstartingarmor, "gulag_spawn_loot", gulagspawnloot, "prematch_end_time", prematchendtime, "playlist_id", playlistid, "frame_duration", frame_duration ] );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0xadd5
// Size: 0x9a
function getteamcount()
{
    teamcount = 0;
    
    foreach ( team in level.teamnamelist )
    {
        teamplayers = scripts\mp\utility\teams::getteamdata( team, "players" );
        
        if ( teamplayers.size > 0 || isdefined( level.var_7b37b2193f163b9b ) && scripts\mp\utility\teams::getteamdata( team, "UIBotCount" ) > 0 )
        {
            teamcount++;
        }
    }
    
    return teamcount;
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 0
// Checksum 0x0, Offset: 0xae78
// Size: 0x133
function function_afd45555767f3079()
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    guardsattacked = 0;
    riotstriggered = 0;
    riotscompleted = 0;
    
    if ( isdefined( level.gulag ) && isdefined( level.gulag.arenas ) )
    {
        foreach ( arena in level.gulag.arenas )
        {
            guardsattacked += default_to( arena.var_19fe32f41a41c7ff, 0 );
            riotstriggered += default_to( arena.var_60af67bcaac1aa55, 0 );
            riotscompleted += default_to( arena.riotscompleted, 0 );
        }
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "guards_attacked";
    eventparams[ eventparams.size ] = guardsattacked;
    eventparams[ eventparams.size ] = "riots_triggered";
    eventparams[ eventparams.size ] = riotstriggered;
    eventparams[ eventparams.size ] = "riots_completed";
    eventparams[ eventparams.size ] = riotscompleted;
    dlog_recordevent( "dlog_event_br_riot_totals", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 6
// Checksum 0x0, Offset: 0xafb3
// Size: 0xb7
function function_5098ee655afed5d( arenaid, circleindex, result, participants, leftovers, releasedplayers )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "arena";
    eventparams[ eventparams.size ] = arenaid;
    eventparams[ eventparams.size ] = "circle_index";
    eventparams[ eventparams.size ] = circleindex;
    eventparams[ eventparams.size ] = "result";
    eventparams[ eventparams.size ] = result;
    eventparams[ eventparams.size ] = "participants";
    eventparams[ eventparams.size ] = participants;
    eventparams[ eventparams.size ] = "leftovers";
    eventparams[ eventparams.size ] = leftovers;
    eventparams[ eventparams.size ] = "released";
    eventparams[ eventparams.size ] = releasedplayers;
    dlog_recordevent( "dlog_event_gulagbreak_result", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0xb072
// Size: 0xad
function function_885c6daf0ece2cf6( result, fail_reason )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "result";
    eventparams[ eventparams.size ] = result;
    eventparams[ eventparams.size ] = "fail_reason";
    eventparams[ eventparams.size ] = fail_reason;
    circleindex = -1;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    eventparams[ eventparams.size ] = "circle_index";
    eventparams[ eventparams.size ] = circleindex;
    self dlog_recordplayerevent( "dlog_event_reinforcement_flare_use", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 8
// Checksum 0x0, Offset: 0xb127
// Size: 0x112
function function_9d458fb3a5d1e86a( squadtotal, placement, totalcash, looted, contracts, valuables, lostondeath, var_6ed21b763a987591 )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "total_squad_cash";
    eventparams[ eventparams.size ] = int( squadtotal );
    eventparams[ eventparams.size ] = "placement";
    eventparams[ eventparams.size ] = int( placement );
    eventparams[ eventparams.size ] = "total_cash";
    eventparams[ eventparams.size ] = int( totalcash );
    eventparams[ eventparams.size ] = "looted_cash";
    eventparams[ eventparams.size ] = int( looted );
    eventparams[ eventparams.size ] = "contract_cash";
    eventparams[ eventparams.size ] = int( contracts );
    eventparams[ eventparams.size ] = "valuable_cash";
    eventparams[ eventparams.size ] = int( valuables );
    eventparams[ eventparams.size ] = "cash_lost_on_death";
    eventparams[ eventparams.size ] = int( lostondeath );
    eventparams[ eventparams.size ] = "cash_lost_on_purchase";
    eventparams[ eventparams.size ] = int( var_6ed21b763a987591 );
    self dlog_recordplayerevent( "dlog_event_br_plunder_match_totals", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0xb241
// Size: 0x6e
function function_fdd0a4efcd97f3be( axis_contracts_completed, allies_contracts_completed, location )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "axis_contracts_completed";
    eventparams[ eventparams.size ] = axis_contracts_completed;
    eventparams[ eventparams.size ] = "allies_contracts_completed";
    eventparams[ eventparams.size ] = allies_contracts_completed;
    eventparams[ eventparams.size ] = "location";
    eventparams[ eventparams.size ] = location;
    dlog_recordevent( "dlog_event_br_clash_contracts_completed", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 3
// Checksum 0x0, Offset: 0xb2b7
// Size: 0x6e
function function_2f0fb1b1516df8f8( axis_score, allies_score, location )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "axis_score";
    eventparams[ eventparams.size ] = axis_score;
    eventparams[ eventparams.size ] = "allies_score";
    eventparams[ eventparams.size ] = allies_score;
    eventparams[ eventparams.size ] = "location";
    eventparams[ eventparams.size ] = location;
    dlog_recordevent( "dlog_event_br_clash_team_scores", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 2
// Checksum 0x0, Offset: 0xb32d
// Size: 0x4d
function function_a5f798c8b2826f4c( player, treelevel )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = _branalytics_header( player );
    eventparams[ eventparams.size ] = "tree_level";
    eventparams[ eventparams.size ] = treelevel;
    player dlog_recordplayerevent( "dlog_event_br_ff_tree_level_achieved", eventparams );
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 4
// Checksum 0x0, Offset: 0xb382
// Size: 0x253
function function_eb0f4a619dd99bba( containertype, containerposition, items, index )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "container_type";
    eventparams[ eventparams.size ] = containertype;
    circleindex = -1;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    eventparams[ eventparams.size ] = "circle_index";
    eventparams[ eventparams.size ] = circleindex;
    eventparams[ eventparams.size ] = "cache_position_x";
    eventparams[ eventparams.size ] = containerposition[ 0 ];
    eventparams[ eventparams.size ] = "cache_position_y";
    eventparams[ eventparams.size ] = containerposition[ 1 ];
    eventparams[ eventparams.size ] = "cache_position_z";
    eventparams[ eventparams.size ] = containerposition[ 2 ];
    eventparams[ eventparams.size ] = "container_index";
    eventparams[ eventparams.size ] = index;
    eventparams[ eventparams.size ] = "closest_poi";
    eventparams[ eventparams.size ] = scripts\mp\poi::function_55cf921efa4cbd09( containerposition );
    self.player dlog_recordplayerevent( "dlog_event_cache_container_opened", eventparams );
    
    foreach ( item in items )
    {
        eventparams = [];
        eventparams[ eventparams.size ] = "container_type";
        eventparams[ eventparams.size ] = containertype;
        eventparams[ eventparams.size ] = "container_index";
        eventparams[ eventparams.size ] = index;
        eventparams[ eventparams.size ] = "item";
        eventparams[ eventparams.size ] = item;
        itemcount = undefined;
        
        if ( isstring( item ) )
        {
            itemcount = level.br_pickups.counts[ item ];
        }
        
        if ( !isdefined( itemcount ) )
        {
            itemcount = 1;
        }
        
        eventparams[ eventparams.size ] = "count";
        eventparams[ eventparams.size ] = itemcount;
        eventparams[ eventparams.size ] = "type";
        itemtype = undefined;
        
        if ( isstring( item ) )
        {
            itemtype = level.br_pickups.br_itemtype[ item ];
        }
        else if ( isweapon( item ) )
        {
            itemtype = #"weapon";
        }
        
        eventparams[ eventparams.size ] = itemtype;
        self.player dlog_recordplayerevent( "dlog_event_cache_container_opened_item", eventparams );
    }
}

// Namespace br_analytics / scripts\mp\gametypes\br_analytics
// Params 5
// Checksum 0x0, Offset: 0xb5dd
// Size: 0xf8
function function_7dcf65411dc17f09( valuablename, basevalue, quantity, cashtotal, player )
{
    if ( !branalytics_validation() )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "valuable_name";
    eventparams[ eventparams.size ] = valuablename;
    eventparams[ eventparams.size ] = "base_sell_value";
    eventparams[ eventparams.size ] = basevalue;
    eventparams[ eventparams.size ] = "quantity";
    eventparams[ eventparams.size ] = quantity;
    eventparams[ eventparams.size ] = "cash_total";
    eventparams[ eventparams.size ] = cashtotal;
    eventparams[ eventparams.size ] = "match_time";
    eventparams[ eventparams.size ] = scripts\cp_mp\utility\game_utility::gettimepassed();
    eventparams[ eventparams.size ] = "closest_poi";
    eventparams[ eventparams.size ] = scripts\mp\poi::function_55cf921efa4cbd09( player.origin );
    eventparams[ eventparams.size ] = "player_plunder_count";
    eventparams[ eventparams.size ] = player.plundercount;
    eventparams[ eventparams.size ] = "player_plunder_banked";
    eventparams[ eventparams.size ] = player.plunderbanked;
    player dlog_recordplayerevent( "dlog_event_valuable_sold", eventparams );
}

