#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_c130airdrop;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\teams;
#using scripts\mp\weaponrank;

#namespace br_publicevent_doublexp_crate;

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0, eflags: 0x1
// Checksum 0x0, Offset: 0x55b
// Size: 0x52
function autoexec main()
{
    scripts\mp\gametypes\br_publicevents::function_dbc8f6cb3760cd82( %"doublexp_crate", &init );
    
    if ( getdvarint( @"hash_ce6e92b818a2a324", 0 ) == 0 && getdvarint( @"hash_da7fe1bcdf3005b7", 1 ) != 0 )
    {
        scripts\cp_mp\killstreaks\airdrop::function_a594839d4da1bcae( "airdrop_doublexp_crate", &function_daa510e2d1ce6f2f );
    }
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 1
// Checksum 0x0, Offset: 0x5b5
// Size: 0x67
function init( eventinfo )
{
    if ( getdvarint( @"hash_da7fe1bcdf3005b7", 1 ) == 0 )
    {
        return;
    }
    
    eventinfo.postinitfunc = &postinitfunc;
    eventinfo.var_b22310d8fb6c98fa = &function_b1e72752c0777b84;
    eventinfo.activatefunc = &function_94b6a8cecf4460f4;
    initdialog();
    
    /#
        level thread debug_init();
    #/
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0
// Checksum 0x0, Offset: 0x624
// Size: 0x3b
function initdialog()
{
    game[ "dialog" ][ "dbxp_inbound" ] = "dblx_grav_nbnd";
    game[ "dialog" ][ "dbxp_boost" ] = "dblx_grav_boos";
    game[ "dialog" ][ "dbxp_active" ] = "dblx_grav_dbxc";
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0
// Checksum 0x0, Offset: 0x667
// Size: 0x268
function postinitfunc()
{
    level.var_849fbfb162366139 = spawnstruct();
    level.var_849fbfb162366139.var_5b5b63ad1aa0c600 = getdvarint( @"hash_9d51f9c0009f08f1", 5 );
    level.var_849fbfb162366139.xpmultiplier = getdvarint( @"hash_bc16751befcea55d", 2 );
    level.var_849fbfb162366139.var_1e5a000c9dd647d9 = getdvarint( @"hash_1ba89b1c84ffbfa1", 1 );
    level.var_849fbfb162366139.var_e46c4bb389787c4b = getdvarint( @"hash_9ffcaa81d06c9318", 1 );
    level.var_849fbfb162366139.var_c7b9959dc3806b9d = getdvarint( @"hash_9a2d81522af9d92e", 1 );
    level.var_849fbfb162366139.disableparachute = getdvarint( @"hash_55f79e64c5d2a78c", 1 );
    level.var_849fbfb162366139.var_9e26db7dc8713415 = getdvarint( @"hash_220ae379b570305d", 5 );
    level.var_849fbfb162366139.var_cb99e35e55b5a678 = getdvarint( @"hash_40a3c8ac39a65a2c", 1 );
    level.var_849fbfb162366139.var_c23382998980bae9 = getdvarint( @"hash_185b9052b3deb291", 4000 );
    level.var_849fbfb162366139.var_6b4d4e4c82bcc857 = getdvarint( @"hash_1f536de4d89b0d4f", 300 );
    level.var_849fbfb162366139.var_8337fdb41fc6f888 = [];
    xprewards = strtok( getdvar( @"hash_7df719e8123c2c33", "500 750 1000 1250 1500" ), " " );
    level.var_849fbfb162366139.var_5d8c02c2769162b1 = [];
    
    foreach ( xpreward in xprewards )
    {
        level.var_849fbfb162366139.var_5d8c02c2769162b1[ level.var_849fbfb162366139.var_5d8c02c2769162b1.size ] = int( xpreward );
    }
    
    assertex( level.var_849fbfb162366139.xpmultiplier >= 1, "<dev string:x1c>" );
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0
// Checksum 0x0, Offset: 0x8d7
// Size: 0x52, Type: bool
function function_b1e72752c0777b84()
{
    if ( istrue( level.var_2df69b8e552238b6 ) && !istrue( level.var_cb9a9bfbbc8b8a0f ) && level.br_circle.circleindex > -1 && scripts\mp\gametypes\br_circle_util::function_d987886bb9de9137() > 1 && !scripts\mp\gametypes\br_circle_util::function_29e8194ff7e13e2e() )
    {
        return false;
    }
    
    return true;
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0
// Checksum 0x0, Offset: 0x932
// Size: 0xd4
function function_92d23849fac69b79()
{
    leveldata = scripts\cp_mp\killstreaks\airdrop::getleveldata( "battle_royale_doublexp_crate" );
    leveldata.capturestring = &"MP/DOUBLEXP_CRATE_CAPTURE";
    leveldata.basemodel = "military_carepackage_03_doublexp";
    leveldata.mountmantlemodel = undefined;
    leveldata.headicon = undefined;
    leveldata.timeout = undefined;
    leveldata.supportsownercapture = 0;
    leveldata.onecaptureperplayer = 1;
    leveldata.destroyoncapture = 1;
    leveldata.var_c23ca3472233553d = 1;
    leveldata.isdropcrate = 1;
    leveldata.activatecallback = &function_6a082776d19d52ba;
    leveldata.capturecallback = &function_c1c2f8b04e6586ed;
    leveldata.destroycallback = &function_8e6e4e55266fbd15;
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0
// Checksum 0x0, Offset: 0xa0e
// Size: 0x4c
function function_94b6a8cecf4460f4()
{
    function_92d23849fac69b79();
    scripts\mp\gametypes\br_publicevents::showsplashtoall( "br_pe_doublexp_crate_start", "splash_list_br_pe_doublexp_crate" );
    level thread scripts\mp\gametypes\br_public::brleaderdialog( "dbxp_inbound", 1, undefined, 0, 1, undefined );
    function_59c84ee8014ea5a8( level.var_849fbfb162366139.var_5b5b63ad1aa0c600 );
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 1
// Checksum 0x0, Offset: 0xa62
// Size: 0x37
function function_6a082776d19d52ba( isfirstactivation )
{
    if ( istrue( isfirstactivation ) )
    {
        if ( scripts\engine\utility::issharedfuncdefined( "airdrop", "registerCrateForCleanup" ) )
        {
            [[ scripts\engine\utility::getsharedfunc( "airdrop", "registerCrateForCleanup" ) ]]( self );
        }
    }
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 1
// Checksum 0x0, Offset: 0xaa1
// Size: 0x21
function function_c1c2f8b04e6586ed( player )
{
    function_fa22a58f778274e7();
    function_61b813c431fca619();
    player function_daa510e2d1ce6f2f();
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 1
// Checksum 0x0, Offset: 0xaca
// Size: 0x12
function function_8e6e4e55266fbd15( immediate )
{
    function_61b813c431fca619();
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0
// Checksum 0x0, Offset: 0xae4
// Size: 0x94
function function_61b813c431fca619()
{
    if ( isdefined( self.scriptedobjid ) )
    {
        objective_delete( self.scriptedobjid );
        scripts\mp\objidpoolmanager::returnobjectiveid( self.scriptedobjid );
        self.scriptedobjid = undefined;
    }
    
    if ( isdefined( self.smokesignal ) )
    {
        self.smokesignal setscriptablepartstate( "smoke_signal", "off", 0 );
        self.smokesignal delete();
    }
    
    if ( isdefined( level.c130successfulairdrops ) )
    {
        level.c130successfulairdrops = array_remove( level.c130successfulairdrops, self );
    }
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0
// Checksum 0x0, Offset: 0xb80
// Size: 0x26a
function function_daa510e2d1ce6f2f()
{
    player = self;
    player thread function_b7bfe6ae470e02c2();
    affectedplayers = player;
    xpmultiplier = level.var_849fbfb162366139.xpmultiplier;
    
    if ( level.var_849fbfb162366139.var_1e5a000c9dd647d9 )
    {
        teamplayers = array_removeundefined( scripts\mp\utility\teams::getteamdata( player.team, "players" ) );
        affectedplayers = teamplayers;
        
        if ( level.var_849fbfb162366139.var_e46c4bb389787c4b )
        {
            scripts\mp\rank::addteamrankxpmultiplier( xpmultiplier, player.team, "battle_royale_doublexp_crate" );
        }
        
        if ( level.var_849fbfb162366139.var_c7b9959dc3806b9d )
        {
            foreach ( teamplayer in teamplayers )
            {
                teamplayer scripts\mp\weaponrank::addweaponrankxpmultiplier( xpmultiplier, "battle_royale_doublexp_crate" );
            }
        }
    }
    else
    {
        if ( level.var_849fbfb162366139.var_e46c4bb389787c4b )
        {
            player scripts\mp\rank::addrankxpmultiplier( xpmultiplier, "battle_royale_doublexp_crate" );
        }
        
        if ( level.var_849fbfb162366139.var_c7b9959dc3806b9d )
        {
            player scripts\mp\weaponrank::addweaponrankxpmultiplier( xpmultiplier, "battle_royale_doublexp_crate" );
        }
    }
    
    player function_e9e2cf1181eb7177();
    level.var_849fbfb162366139.dlogdata[ "nbOfCratesUsed" ] = level.var_849fbfb162366139.dlogdata[ "nbOfCratesUsed" ] + 1;
    
    if ( player function_90fbfa0e04230b9() )
    {
        foreach ( affectedplayer in affectedplayers )
        {
            if ( level.var_849fbfb162366139.var_e46c4bb389787c4b )
            {
                affectedplayer scripts\mp\hud_message::showsplash( "event_double_xp", undefined, self );
            }
            
            if ( level.var_849fbfb162366139.var_c7b9959dc3806b9d )
            {
                affectedplayer scripts\mp\hud_message::showsplash( "event_double_weapon_xp", undefined, self );
            }
        }
        
        level thread scripts\mp\gametypes\br_public::brleaderdialog( "dbxp_active", undefined, affectedplayers, 1, 1, undefined );
        return;
    }
    
    setlowermessageomnvar( "doublexp_crate_already_used", undefined, 5 );
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0
// Checksum 0x0, Offset: 0xdf2
// Size: 0x8d, Type: bool
function function_90fbfa0e04230b9()
{
    player = self;
    var_dcf5297e75df8644 = ter_op( level.var_849fbfb162366139.var_1e5a000c9dd647d9, player.team, player );
    
    if ( array_contains( level.var_849fbfb162366139.var_8337fdb41fc6f888, var_dcf5297e75df8644 ) )
    {
        return false;
    }
    
    level.var_849fbfb162366139.var_8337fdb41fc6f888 = array_add( level.var_849fbfb162366139.var_8337fdb41fc6f888, var_dcf5297e75df8644 );
    return true;
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0
// Checksum 0x0, Offset: 0xe88
// Size: 0xdc
function function_b7bfe6ae470e02c2()
{
    xpreward = level.var_849fbfb162366139.var_5d8c02c2769162b1[ 0 ];
    
    if ( isdefined( level.br_circle.circleindex ) && level.br_circle.circleindex >= 0 )
    {
        index = int( min( level.br_circle.circleindex, level.var_849fbfb162366139.var_5d8c02c2769162b1.size - 1 ) );
        xpreward = level.var_849fbfb162366139.var_5d8c02c2769162b1[ index ];
    }
    
    var_b01aca3236595958 = spawnstruct();
    var_b01aca3236595958.finalxp = xpreward;
    scripts\mp\rank::giverankxp( #"hash_795ee672e1287a92", xpreward, undefined, 0, 1, 1, var_b01aca3236595958 );
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0
// Checksum 0x0, Offset: 0xf6c
// Size: 0x127
function function_fa22a58f778274e7()
{
    if ( !istrue( level.var_849fbfb162366139.var_cb99e35e55b5a678 ) )
    {
        return;
    }
    
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    droporigin = self.origin;
    dropangles = self.angles;
    itemlist = [];
    itemlist[ itemlist.size ] = [ "brloot_plunder_cash_epic_1", 500 ];
    itemlist[ itemlist.size ] = [ "brloot_super_utilitybox", 1 ];
    itemlist[ itemlist.size ] = [ "brloot_super_deployablekiosk", 1 ];
    itemlist[ itemlist.size ] = [ "brloot_super_reinforcement_flare", 1 ];
    
    foreach ( item in itemlist )
    {
        if ( scripts\mp\gametypes\br_lootcache::canspawnitemname( item[ 0 ] ) )
        {
            dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( dropstruct, droporigin, dropangles, self );
            scripts\mp\gametypes\br_pickups::spawnpickup( item[ 0 ], dropinfo, item[ 1 ], 1 );
        }
    }
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 1
// Checksum 0x0, Offset: 0x109b
// Size: 0x1cc
function function_59c84ee8014ea5a8( var_5b5b63ad1aa0c600 )
{
    level endon( "game_ended" );
    function_bdfea1628154e7e3();
    
    if ( airdrop::function_7dc6e272aac60753( "airdrop_doublexp_crate" ) )
    {
        var_2119e0b45206e4b2 = [[ scripts\engine\utility::getsharedfunc( "package_airdrop", "startPackageTypeAirdrop" ) ]]( "airdrop_doublexp_crate" );
        level.var_849fbfb162366139.dlogdata[ "nbOfCratesDropped" ] = var_2119e0b45206e4b2;
        return;
    }
    
    if ( var_5b5b63ad1aa0c600 <= 0 )
    {
        return;
    }
    
    circle = spawnstruct();
    
    if ( istrue( level.var_2df69b8e552238b6 ) )
    {
        circle.origin = level.br_level.br_circlecenters[ level.br_circle.circleindex + 1 ];
        circle.radius = level.br_level.br_circleradii[ level.br_circle.circleindex + 1 ];
    }
    else
    {
        circle.origin = scripts\mp\gametypes\br_circle::getsafecircleorigin();
        circle.radius = scripts\mp\gametypes\br_circle::getsafecircleradius();
    }
    
    pathstruct = scripts\mp\gametypes\br_c130airdrop::c130airdrop_createpath( undefined, circle.origin );
    dist = distance( pathstruct.startpt, pathstruct.endpt );
    travelspeed = scripts\mp\gametypes\br_c130::getc130speed();
    time = dist / travelspeed;
    c130airdrop = scripts\mp\gametypes\br_c130airdrop::c130airdrop_spawn( pathstruct, dist, travelspeed, time );
    c130airdrop.owner = undefined;
    c130airdrop.team = undefined;
    c130airdrop.dropfunc = &function_cc9f0006da726497;
    c130airdrop scripts\mp\gametypes\br_c130airdrop::c130airdrop_startdelivery( var_5b5b63ad1aa0c600, "battle_royale_doublexp_crate", "inactive", circle );
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 3
// Checksum 0x0, Offset: 0x126f
// Size: 0x60
function function_60e9f1bb94a9d614( point, firstsegment, secondsegment )
{
    closestpointa = pointonsegmentnearesttopoint( firstsegment[ 0 ], firstsegment[ 1 ], point );
    closestpointb = pointonsegmentnearesttopoint( secondsegment[ 0 ], secondsegment[ 1 ], point );
    
    if ( distance2dsquared( point, closestpointa ) > distance2dsquared( point, closestpointb ) )
    {
        return closestpointa;
    }
    
    return closestpointb;
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 1
// Checksum 0x0, Offset: 0x12d8
// Size: 0x138
function function_b2b7915585a31dc4( dropcircle )
{
    var_b3d62ab023b59bf6 = level.br_level.br_mapcenter + scripts\mp\gametypes\br_c130::function_1f389456d7c530a();
    var_6d7e4cc332c6d081 = scripts\mp\gametypes\br_c130::getplanepathsaferadiusfromcenter();
    var_8e0605cb0d8ae85e = function_d2c0d8330ab7ad7f( self.startpt, self.endpt, dropcircle.origin, dropcircle.radius );
    var_690b677ae1ff4e7c = function_d2c0d8330ab7ad7f( self.startpt, self.endpt, var_b3d62ab023b59bf6, var_6d7e4cc332c6d081 );
    
    if ( !isdefined( var_8e0605cb0d8ae85e ) || !isdefined( var_690b677ae1ff4e7c ) || var_690b677ae1ff4e7c.size < 2 )
    {
        return;
    }
    
    dropstart = function_60e9f1bb94a9d614( self.startpt, var_8e0605cb0d8ae85e, var_690b677ae1ff4e7c );
    dropend = function_60e9f1bb94a9d614( self.endpt, var_8e0605cb0d8ae85e, var_690b677ae1ff4e7c );
    self.centerpt = ( dropstart + dropend ) / 2;
    dropcircle.radius = distance2d( dropstart, self.centerpt ) - 50;
    
    /#
        if ( getdvarint( @"hash_5f45299d088c7963", 0 ) == 1 )
        {
            thread function_432f4f8b51643066( dropcircle );
        }
    #/
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 4
// Checksum 0x0, Offset: 0x1418
// Size: 0x2e8
function function_cc9f0006da726497( var_5b5b63ad1aa0c600, var_958bbdfed6f2e9ef, var_fe41be11a71dc1b4, dropcircle )
{
    function_b2b7915585a31dc4( dropcircle );
    var_bd34ecac3ada85b = self.startpt;
    droppoint = self.centerpt;
    planespeed = self.speed;
    dropwaittime = ( distance2d( var_bd34ecac3ada85b, droppoint ) - dropcircle.radius ) / planespeed;
    cratedroptime = dropcircle.radius * 2 / var_5b5b63ad1aa0c600 / planespeed;
    var_2119e0b45206e4b2 = 0;
    
    for ( i = 0; i < var_5b5b63ad1aa0c600 ; i++ )
    {
        wait dropwaittime;
        dropwaittime = cratedroptime;
        droplocation = scripts\mp\gametypes\br_c130airdrop::c130airdrop_findvaliddroplocation( self.origin + anglestoforward( self.angles ) * 500, 0, 1 );
        
        if ( !isdefined( droplocation ) )
        {
            continue;
        }
        
        crate = scripts\cp_mp\killstreaks\airdrop::dropbrc130airdropcrate( droplocation + ( 0, 0, level.c130airdrop_heightoverride - 100 ), droplocation, self.angles, var_958bbdfed6f2e9ef, var_fe41be11a71dc1b4, level.var_849fbfb162366139.disableparachute, undefined, "ks_airdrop_crate_br_pe_doublexp" );
        
        if ( !isdefined( crate ) )
        {
            continue;
        }
        
        crate setscriptablepartstate( "objective_map", "hidden" );
        objid = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
        
        if ( objid != -1 )
        {
            scripts\mp\objidpoolmanager::objective_add_objective( objid, "current", crate.origin, "ui_map_icon_drop_doublexp" );
            scripts\mp\objidpoolmanager::update_objective_setbackground( objid, 1 );
            scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9( objid, 1 );
            scripts\mp\objidpoolmanager::update_objective_onentity( objid, crate );
            scripts\mp\objidpoolmanager::update_objective_setzoffset( objid, 75 );
            scripts\mp\objidpoolmanager::objective_set_play_intro( objid, 0 );
            scripts\mp\objidpoolmanager::objective_set_play_outro( objid, 0 );
            scripts\mp\objidpoolmanager::function_98ba077848896a3( objid, 1 );
            scripts\mp\objidpoolmanager::function_f21e9b2e78de984b( objid, level.var_849fbfb162366139.var_c23382998980bae9 - level.var_849fbfb162366139.var_6b4d4e4c82bcc857, level.var_849fbfb162366139.var_c23382998980bae9 );
            scripts\mp\objidpoolmanager::objective_playermask_showtoall( objid );
            scripts\mp\objidpoolmanager::function_2946e9eb07acb3f1( objid, &"MP/DOUBLEXP_CRATE_NAME" );
            crate.scriptedobjid = objid;
        }
        
        triggerobject = scripts\cp_mp\killstreaks\airdrop::gettriggerobject( crate );
        triggerobject.usetimeoverride = level.var_849fbfb162366139.var_9e26db7dc8713415;
        level.c130successfulairdrops[ level.c130successfulairdrops.size ] = crate;
        var_2119e0b45206e4b2 += 1;
    }
    
    if ( getdvarint( @"hash_55f79e64c5d2a78c", 1 ) == 0 )
    {
        level waittill( "battle_royale_doublexp_crate" + "drop_anim_completed" );
        level thread scripts\mp\gametypes\br_public::brleaderdialog( "dbxp_boost", 1, undefined, 0, 1, undefined );
    }
    
    level.var_849fbfb162366139.dlogdata[ "nbOfCratesDropped" ] = var_2119e0b45206e4b2;
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0
// Checksum 0x0, Offset: 0x1708
// Size: 0x6d
function function_bdfea1628154e7e3()
{
    if ( isdefined( level.var_849fbfb162366139.dlogdata ) )
    {
        return;
    }
    
    level.var_849fbfb162366139.dlogdata = [];
    level.var_849fbfb162366139.dlogdata[ "nbOfCratesDropped" ] = 0;
    level.var_849fbfb162366139.dlogdata[ "nbOfCratesUsed" ] = 0;
    thread function_68e995abe7e84297();
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0
// Checksum 0x0, Offset: 0x177d
// Size: 0x82
function function_68e995abe7e84297()
{
    level waittill( "game_ended" );
    dlog_recordevent( "dlog_event_doublexp_crate_match_event", [ "nb_of_crates_dropped", level.var_849fbfb162366139.dlogdata[ "nbOfCratesDropped" ], "nb_of_crates_used", level.var_849fbfb162366139.dlogdata[ "nbOfCratesUsed" ], "crate_benefits_entire_team", level.var_849fbfb162366139.var_1e5a000c9dd647d9 ] );
}

// Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
// Params 0
// Checksum 0x0, Offset: 0x1807
// Size: 0xcf
function function_e9e2cf1181eb7177()
{
    circleindex = 0;
    
    if ( isdefined( level.br_circle.circleindex ) && level.br_circle.circleindex >= 0 )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    self dlog_recordplayerevent( "dlog_event_doublexp_crate_participation", [ "player_x", self.origin[ 0 ], "player_y", self.origin[ 1 ], "player_z", self.origin[ 2 ], "team", self.team, "circle_index", circleindex ] );
}

/#

    // Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
    // Params 0
    // Checksum 0x0, Offset: 0x18de
    // Size: 0x5, Type: dev
    function __debug()
    {
        
    }

    // Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
    // Params 0
    // Checksum 0x0, Offset: 0x18eb
    // Size: 0x2e, Type: dev
    function debug_init()
    {
        scripts\common\devgui::function_6e7290c8ee4f558b( "<dev string:x51>" );
        scripts\common\devgui::function_a9a864379a098ad6( "<dev string:x69>", "<dev string:x76>", &function_db70bae7732f5204 );
        scripts\common\devgui::function_fe953f000498048f();
    }

    // Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
    // Params 0
    // Checksum 0x0, Offset: 0x1921
    // Size: 0x17, Type: dev
    function function_db70bae7732f5204()
    {
        level thread scripts\mp\gametypes\br_publicevents::function_e37ee072d95a7c98( %"doublexp_crate" );
    }

    // Namespace br_publicevent_doublexp_crate / scripts\mp\gametypes\br_publicevent_doublexp_crate
    // Params 1
    // Checksum 0x0, Offset: 0x1940
    // Size: 0xdf, Type: dev
    function function_432f4f8b51643066( dropcircle )
    {
        level notify( "<dev string:x8e>" );
        level endon( "<dev string:x8e>" );
        center = ( self.centerpt[ 0 ], self.centerpt[ 1 ], 0 );
        radius = dropcircle.radius;
        start = self.startpt;
        end = self.endpt;
        
        while ( true )
        {
            waitframe();
            cylinder( center, center + ( 0, 0, 5000 ), radius, ( 1, 1, 0 ), 1, 1 );
            line( start + ( 0, 0, 5000 ), end + ( 0, 0, 5000 ), ( 1, 1, 0 ) );
        }
    }

#/
