#using script_2b85a88a1d543a;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;

#namespace namespace_b925592dfbd5676e;

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 4
// Checksum 0x0, Offset: 0x40b
// Size: 0x135
function function_15ec8dc28147b1b7( dvar, var_dc26843157970ecf, var_69a1727953025cb0, dvardefault )
{
    name = getdvar( dvar, dvardefault );
    
    if ( name == "" )
    {
        /#
            iprintln( "<dev string:x1c>" + getxhashsourcename( dvar ) + "<dev string:x41>" );
        #/
        
        return;
    }
    
    bundlename = hashcat( %"hash_62f18fdac9f4e251", name );
    bundle = getscriptbundle( bundlename );
    
    if ( !isdefined( bundle ) )
    {
        /#
            iprintln( "<dev string:x51>" + getxhashsourcename( dvar ) + "<dev string:x80>" + name + "<dev string:x87>" );
        #/
        
        return;
    }
    
    scriptid = bundle.scriptid;
    assert( !isdefined( level.secondaryvictory.missions[ scriptid ] ) );
    mission = spawnstruct();
    mission.var_dc26843157970ecf = var_dc26843157970ecf;
    mission.var_69a1727953025cb0 = var_69a1727953025cb0;
    mission.bundle = bundle;
    level.secondaryvictory.missions[ scriptid ] = mission;
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 3
// Checksum 0x0, Offset: 0x548
// Size: 0x7a
function registermission( name, init, getplayervalue )
{
    if ( !namespace_3460310ddf4d9cfa::init() )
    {
        return;
    }
    
    if ( !isdefined( level.secondaryvictory.missions[ name ] ) )
    {
        return;
    }
    
    mission = level.secondaryvictory.missions[ name ];
    mission.init = init;
    mission.getplayervalue = getplayervalue;
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 0
// Checksum 0x0, Offset: 0x5ca
// Size: 0xee
function function_6ab248769a99d7e7()
{
    foreach ( mission in level.secondaryvictory.missions )
    {
        if ( isdefined( mission.init ) )
        {
            bundle = mission.bundle;
            total = function_59a210af4334879b( bundle.total );
            xpbonus = function_59a210af4334879b( bundle.xpbonus );
            mission.total = total;
            mission.xpbonus = xpbonus;
            level [[ mission.var_69a1727953025cb0 ]]( total );
            self [[ mission.init ]]( bundle, total, xpbonus );
        }
    }
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x6c0
// Size: 0xc0
function function_59a210af4334879b( valuearray )
{
    maxteamsize = level.maxteamsize;
    value = undefined;
    teamsize = 0;
    
    foreach ( entry in valuearray )
    {
        if ( entry.teamsize <= maxteamsize && entry.teamsize > teamsize )
        {
            value = entry.value;
            teamsize = entry.teamsize;
        }
    }
    
    assert( isdefined( value ) );
    return value;
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 0
// Checksum 0x0, Offset: 0x789
// Size: 0x114
function initteamdata()
{
    foreach ( team in getarraykeys( level.teamdata ) )
    {
        if ( team == "free" || team == "spectator" || team == "civilian" )
        {
            continue;
        }
        
        if ( isdefined( level.teamdata[ team ][ "svData" ] ) )
        {
            continue;
        }
        
        level.teamdata[ team ][ "svData" ] = newteamdata();
    }
    
    function_6ab248769a99d7e7();
    
    foreach ( team in getarraykeys( level.teamdata ) )
    {
        if ( !isdefined( level.teamdata[ team ][ "svData" ] ) )
        {
            continue;
        }
        
        function_f7714705f9eb220a( team );
    }
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x8a5
// Size: 0xa0
function function_fdd037317409179e( player )
{
    var_394aebba88e4e8c2 = spawnstruct();
    var_394aebba88e4e8c2.achieved = 0;
    var_394aebba88e4e8c2.inprogress = 0;
    var_394aebba88e4e8c2.team = player.team;
    var_394aebba88e4e8c2.name = player.team;
    var_394aebba88e4e8c2.player = player;
    var_394aebba88e4e8c2.trigger = undefined;
    var_394aebba88e4e8c2.var_86909aea6009b811 = undefined;
    var_394aebba88e4e8c2.var_97b85e39841505 = undefined;
    var_394aebba88e4e8c2.var_241735be4107a4fa = 0;
    return var_394aebba88e4e8c2;
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 0
// Checksum 0x0, Offset: 0x94e
// Size: 0x39
function newteamdata()
{
    td = spawnstruct();
    td.points = [];
    td.awarded = 0;
    td.var_394aebba88e4e8c2 = undefined;
    return td;
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x990
// Size: 0x42
function getteamdata( team )
{
    assert( isdefined( team ) );
    assert( isdefined( level.teamdata[ team ][ "<dev string:x96>" ] ) );
    return level.teamdata[ team ][ "svData" ];
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x9db
// Size: 0x6f
function function_f7714705f9eb220a( team )
{
    foreach ( mission in getarraykeys( level.secondaryvictory.missions ) )
    {
        function_d19de726f751683d( mission, team );
    }
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 2
// Checksum 0x0, Offset: 0xa52
// Size: 0x61
function function_d19de726f751683d( mission, team )
{
    td = getteamdata( team );
    value = function_7dded3913cebc59e( team, mission );
    
    if ( istrue( td.awarded ) )
    {
        return;
    }
    
    td.points[ mission ] = value;
    function_c9c2b5e426ae6ad2( mission, team, value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 2
// Checksum 0x0, Offset: 0xabb
// Size: 0xa7
function function_7dded3913cebc59e( team, mission )
{
    missiondata = level.secondaryvictory.missions[ mission ];
    players = getteamplayers( team );
    value = 0;
    
    foreach ( player in players )
    {
        value += player [[ missiondata.getplayervalue ]]();
    }
    
    return value;
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 3, eflags: 0x4
// Checksum 0x0, Offset: 0xb6b
// Size: 0xa1
function private function_c9c2b5e426ae6ad2( mission, team, value )
{
    missiondata = level.secondaryvictory.missions[ mission ];
    players = getteamplayers( team );
    
    foreach ( player in players )
    {
        player [[ missiondata.var_dc26843157970ecf ]]( value );
    }
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0xc14
// Size: 0x1c
function getteamplayers( team )
{
    return level.teamdata[ team ][ "players" ];
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 0
// Checksum 0x0, Offset: 0xc39
// Size: 0xd1
function function_160e85c84dcd9d28()
{
    var_394aebba88e4e8c2 = self;
    assert( isdefined( var_394aebba88e4e8c2.team ) );
    assert( !isdefined( var_394aebba88e4e8c2.var_97b85e39841505 ) );
    assert( !isdefined( var_394aebba88e4e8c2.var_86909aea6009b811 ) );
    
    /#
        iprintln( "<dev string:xa0>" );
    #/
    
    var_394aebba88e4e8c2.var_97b85e39841505 = scripts\mp\hud_util::createservertimer( "default", 1.5, var_394aebba88e4e8c2.team );
    var_394aebba88e4e8c2.var_97b85e39841505 scripts\mp\hud_util::setpoint( "CENTER", "CENTER", 0, -162 );
    var_394aebba88e4e8c2.var_86909aea6009b811 = createhudelem( undefined, undefined, "CENTER", "CENTER", 0, -180, undefined, var_394aebba88e4e8c2.team );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 2
// Checksum 0x0, Offset: 0xd12
// Size: 0x57
function starttimer( label, time )
{
    var_394aebba88e4e8c2 = self;
    
    /#
        iprintln( "<dev string:xcc>" );
    #/
    
    var_394aebba88e4e8c2.var_97b85e39841505 settimer( time );
    var_394aebba88e4e8c2.var_86909aea6009b811.label = label;
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 0
// Checksum 0x0, Offset: 0xd71
// Size: 0x3f
function cleartimer()
{
    var_394aebba88e4e8c2 = self;
    
    /#
        iprintln( "<dev string:xf5>" );
    #/
    
    var_394aebba88e4e8c2.var_97b85e39841505 reset();
    var_394aebba88e4e8c2.var_86909aea6009b811 reset();
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 0
// Checksum 0x0, Offset: 0xdb8
// Size: 0x65
function destroyhudelements()
{
    var_394aebba88e4e8c2 = self;
    
    if ( isdefined( var_394aebba88e4e8c2.var_97b85e39841505 ) )
    {
        var_394aebba88e4e8c2.var_97b85e39841505 destroy();
        var_394aebba88e4e8c2.var_97b85e39841505 = undefined;
    }
    
    if ( isdefined( var_394aebba88e4e8c2.var_86909aea6009b811 ) )
    {
        var_394aebba88e4e8c2.var_86909aea6009b811 destroy();
        var_394aebba88e4e8c2.var_86909aea6009b811 = undefined;
    }
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 8
// Checksum 0x0, Offset: 0xe25
// Size: 0x189
function createhudelem( label, value, point, relativepoint, xoffset, yoffset, color, team )
{
    fontscale = 1.5;
    
    if ( isdefined( team ) )
    {
        fontelem = newteamhudelem( team );
    }
    else
    {
        fontelem = newhudelem();
    }
    
    fontelem.elemtype = "font";
    fontelem.font = "default";
    fontelem.fontscale = fontscale;
    fontelem.basefontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int( level.fontheight * fontscale );
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem scripts\mp\hud_util::setparent( level.uiparent );
    fontelem.hidden = 0;
    fontelem.alpha = 1;
    fontelem scripts\mp\hud_util::setpoint( point, relativepoint, xoffset, yoffset );
    
    if ( isdefined( label ) )
    {
        fontelem.label = label;
    }
    
    if ( isdefined( value ) )
    {
        fontelem setvalue( value );
    }
    
    if ( isdefined( color ) )
    {
        fontelem.color = color;
    }
    
    return fontelem;
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0xfb7
// Size: 0x61
function function_74cdb6b6565f33a3( timer )
{
    player = self;
    assert( isplayer( player ) );
    
    if ( !player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() )
    {
        var_3754da1f96fbaa7e = ter_op( timer > 0, 1, 0 );
        player setclientomnvar( "ui_is_exfil_countdown", var_3754da1f96fbaa7e );
        player setclientomnvar( "ui_match_start_countdown", timer );
    }
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x1020
// Size: 0x26
function function_f3830638ad346e8e( splashref )
{
    if ( !isdefined( splashref ) || splashref == "" )
    {
        return;
    }
    
    thread scripts\mp\hud_message::showsplash( splashref );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 2
// Checksum 0x0, Offset: 0x104e
// Size: 0x83
function function_92993664746f4afa( team, splashref )
{
    if ( !isdefined( splashref ) || splashref == "" )
    {
        return;
    }
    
    foreach ( teammember in level.teamdata[ team ][ "players" ] )
    {
        teammember thread scripts\mp\hud_message::showsplash( splashref );
    }
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x10d9
// Size: 0x19
function safewait( time )
{
    if ( isdefined( time ) && time > 0 )
    {
        wait time;
    }
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 3
// Checksum 0x0, Offset: 0x10fa
// Size: 0x2c
function function_6a694b8e45c2ca3c( dialog, team, delay )
{
    scripts\mp\gametypes\br_public::brleaderdialogteam( dialog, team, undefined, delay, undefined, "dx_br_jpbm_" );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 0
// Checksum 0x0, Offset: 0x112e
// Size: 0x43
function function_3f39c7ace07c243()
{
    kvps = [ "playlist_name", getplaylistname(), "map_name", level.mapname ];
    dlog_recordevent( "dlog_event_br_secondary_victory_init", kvps );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 2
// Checksum 0x0, Offset: 0x1179
// Size: 0xfc
function function_a10e1586d7ecf252( price, inventorycount )
{
    player = self;
    kvps = [ "playlist_name", getplaylistname(), "map_name", level.mapname, "circle_index", getcircleindex(), "price", int( price ), "inventory", inventorycount, "x", player.origin[ 0 ], "y", player.origin[ 1 ], "z", player.origin[ 2 ], "team_name", player.team ];
    self dlog_recordplayerevent( "dlog_event_br_secondary_victory_player_purchase", kvps );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 2
// Checksum 0x0, Offset: 0x127d
// Size: 0xad
function function_a9b4c3bb4abb4a01( failure_reason, position )
{
    kvps = [ "playlist_name", getplaylistname(), "map_name", level.mapname, "circle_index", getcircleindex(), "reason", int( failure_reason ), "x", position[ 0 ], "y", position[ 1 ], "z", position[ 2 ] ];
    self dlog_recordplayerevent( "dlog_event_br_secondary_victory_failure", kvps );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 5
// Checksum 0x0, Offset: 0x1332
// Size: 0xee
function function_4c04d9675ebe2f9f( team_name, team_size, position, avg_dist, chopper_time )
{
    kvps = [ "playlist_name", getplaylistname(), "map_name", level.mapname, "circle_index", getcircleindex(), "team_name", team_name, "team_size", team_size, "x", position[ 0 ], "y", position[ 1 ], "z", position[ 2 ], "avg_dist", avg_dist, "chopper_time", float( chopper_time ) ];
    dlog_recordevent( "dlog_event_br_secondary_victory_sequence_start", kvps );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x1428
// Size: 0xe1
function function_810f4a04a9253967( dist2d )
{
    player = self;
    kvps = [ "playlist_name", getplaylistname(), "map_name", level.mapname, "circle_index", getcircleindex(), "team_name", player.team, "x", player.origin[ 0 ], "y", player.origin[ 1 ], "z", player.origin[ 2 ], "distance", dist2d ];
    self dlog_recordplayerevent( "dlog_event_br_secondary_victory_player_start", kvps );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 7
// Checksum 0x0, Offset: 0x1511
// Size: 0x116
function function_b1c6ce7b2edc4ec2( position, team_name, team_count, fullyextracted, exfil_count, has_weapon_case, endingid )
{
    kvps = [ "playlist_name", getplaylistname(), "map_name", level.mapname, "circle_index", getcircleindex(), "team_name", team_name, "team_count", team_count, "fully_extracted", fullyextracted, "exfil_count", exfil_count, "has_weapon_case", has_weapon_case, "ending_id", endingid, "x", position[ 0 ], "y", position[ 1 ], "z", position[ 2 ] ];
    dlog_recordevent( "dlog_event_br_secondary_victory_sequence_end", kvps );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 4
// Checksum 0x0, Offset: 0x162f
// Size: 0xf7
function function_f35d9659b8af4887( chopper_team, has_weapon_case, endingid, position )
{
    player = self;
    kvps = [ "playlist_name", getplaylistname(), "map_name", level.mapname, "circle_index", getcircleindex(), "team_name", player.team, "chopper_team", chopper_team, "has_weapon_case", has_weapon_case, "ending_id", endingid, "x", position[ 0 ], "y", position[ 1 ], "z", position[ 2 ] ];
    self dlog_recordplayerevent( "dlog_event_br_secondary_victory_player_exfil", kvps );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x172e
// Size: 0x4b
function private getcircleindex()
{
    circleindex = -1;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    return circleindex;
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x1782
// Size: 0x8c
function function_751af1123571e361( team )
{
    fullyextracted = 1;
    players = level.teamdata[ team ][ "players" ];
    
    foreach ( player in players )
    {
        if ( !istrue( player.extracted ) )
        {
            fullyextracted = 0;
            break;
        }
    }
    
    return fullyextracted;
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 0
// Checksum 0x0, Offset: 0x1817
// Size: 0x65
function function_1324ed2d881d301f()
{
    index = level.secondaryvictory.var_ddb244800e3f1329;
    count = level.secondaryvictory.scriptbundle.var_8396ddb130a38012;
    index = ( index + 1 ) % count;
    level.secondaryvictory.var_ddb244800e3f1329 = index;
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x1884
// Size: 0x35
function function_89db4cf4358b1915( value )
{
    assert( isdefined( value ) && ( value == 0 || value == 1 ) );
    scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3( "ui_br_sv_game1", 0, 1, value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x18c1
// Size: 0x36
function function_3049b4b9d7489dca( value )
{
    assert( isdefined( value ) && ( value == 0 || value == 1 ) );
    scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3( "ui_br_sv_game1", 1, 1, value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x18ff
// Size: 0x36
function function_7d3329c47fbe47f1( value )
{
    assert( isdefined( value ) && ( value == 0 || value == 1 ) );
    scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3( "ui_br_sv_game1", 2, 1, value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x193d
// Size: 0x36
function function_906084f03cbe16da( value )
{
    assert( isdefined( value ) && ( value == 0 || value == 1 ) );
    scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3( "ui_br_sv_game1", 3, 1, value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x197b
// Size: 0x68
function function_cae7fc3d806ab9ce( value )
{
    assert( isdefined( value ) && 0 <= value && value <= 10230 );
    assert( value % 10 == 0 );
    assert( value / 10 == int( value / 10 ) );
    value = int( value / 10 );
    scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3( "ui_br_sv_game1", 4, 10, value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x19eb
// Size: 0x36
function function_358c488f5ac3aff0( value )
{
    assert( isdefined( value ) && 0 <= value && value <= 31 );
    scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3( "ui_br_sv_game1", 14, 5, value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x1a29
// Size: 0x36
function function_4e4db1d859b3ecf9( value )
{
    assert( isdefined( value ) && 0 <= value && value <= 15 );
    scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3( "ui_br_sv_game1", 19, 4, value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x1a67
// Size: 0x36
function function_ab628f99a7598153( value )
{
    assert( isdefined( value ) && 0 <= value && value <= 15 );
    scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3( "ui_br_sv_game1", 23, 4, value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x1aa5
// Size: 0x36
function function_8f67cca8eec50569( value )
{
    assert( isdefined( value ) && 0 <= value && value <= 15 );
    scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3( "ui_br_sv_game1", 27, 4, value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x1ae3
// Size: 0x22
function function_e89fc0ef7d6123d9( value )
{
    assert( isdefined( value ) );
    setomnvar( "ui_br_sv_game2", value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x1b0d
// Size: 0x22
function function_15e5e77836d740c2( value )
{
    assert( isdefined( value ) );
    setomnvar( "ui_br_sv_game3", value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x1b37
// Size: 0x43
function function_10da62a5050109ed( value )
{
    assert( isdefined( value ) && 0 <= value && value <= 31 );
    player = self;
    player scripts\cp_mp\utility\omnvar_utility::function_63437fca39c681dc( "ui_br_sv_client1", 0, 5, value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x1b82
// Size: 0x30
function function_b878acdc34c32bd( value )
{
    assert( isdefined( value ) );
    player = self;
    player setclientomnvar( "ui_br_sv_client2", value );
}

// Namespace namespace_b925592dfbd5676e / namespace_cee702b7292b0efb
// Params 1
// Checksum 0x0, Offset: 0x1bba
// Size: 0x30
function function_677a58693f27bb60( value )
{
    assert( isdefined( value ) );
    player = self;
    player setclientomnvar( "ui_br_sv_client3", value );
}

