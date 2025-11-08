#using script_3aacf02225ca0da5;
#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\uav;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_assassination_quest;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_quest_util;
#using scripts\mp\gametypes\br_utility;
#using scripts\mp\gametypes\br_vip_quest;
#using scripts\mp\playerlogic;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;

#namespace namespace_3f7548b84a92111;

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 0
// Checksum 0x0, Offset: 0xad0
// Size: 0x59
function init()
{
    level.var_21b6eafdc9b89b24 = getdvarint( @"scr_br_playtest_tool_phoenix", 0 );
    level.var_81699aa174dd5a52 = getdvarint( @"hash_10d7b61bff0b17a3", 1 );
    
    if ( !istrue( getdvarint( @"hash_2e58447fa1ca4f20", 0 ) ) )
    {
        return;
    }
    
    level thread function_21b6eafdc9b89b24();
    level thread function_81699aa174dd5a52();
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 0
// Checksum 0x0, Offset: 0xb31
// Size: 0x45e
function function_21b6eafdc9b89b24()
{
    if ( !level.var_21b6eafdc9b89b24 )
    {
        return;
    }
    
    level endon( "game_ended" );
    wait 10;
    
    while ( true )
    {
        playercommandname = "";
        var_864db7311b329a5b = 0;
        
        while ( true )
        {
            playercommandname = getdvar( @"hash_8b0a93b6b93b8800" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_8b0a93b6b93b8800", "" );
                var_864db7311b329a5b = 1;
                break;
            }
            
            playercommandname = getdvar( @"hash_dcbb0a9ee95ae26" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_dcbb0a9ee95ae26", "" );
                var_864db7311b329a5b = 2;
                break;
            }
            
            playercommandname = getdvar( @"hash_5752f63f26ab4917" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_5752f63f26ab4917", "" );
                var_864db7311b329a5b = 3;
                break;
            }
            
            playercommandname = getdvar( @"hash_a592a729d729c65a" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_a592a729d729c65a", "" );
                var_864db7311b329a5b = 4;
                break;
            }
            
            playercommandname = getdvar( @"hash_bc15d9396473711b" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_bc15d9396473711b", "" );
                var_864db7311b329a5b = 5;
                break;
            }
            
            playercommandname = getdvar( @"hash_5556ca8eeeed2341" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_5556ca8eeeed2341", "" );
                var_864db7311b329a5b = 6;
                break;
            }
            
            playercommandname = getdvar( @"hash_b18ca3f4da7b911" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_b18ca3f4da7b911", "" );
                var_864db7311b329a5b = 7;
                break;
            }
            
            playercommandname = getdvar( @"hash_668aada014b1731f" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_668aada014b1731f", "" );
                var_864db7311b329a5b = 8;
                break;
            }
            
            playercommandname = getdvar( @"hash_fe237ca99386656b" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_fe237ca99386656b", "" );
                var_864db7311b329a5b = 9;
                break;
            }
            
            playercommandname = getdvar( @"hash_9d6f9499c51c772d" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_9d6f9499c51c772d", "" );
                var_864db7311b329a5b = 10;
                break;
            }
            
            wait 0.5;
        }
        
        arguments = strtok( playercommandname, getdvar( @"hash_c72daf352ff527f5", "^P^" ) );
        whitelist = tolower( getdvar( @"scr_br_redeploy_playtester" ) );
        
        if ( function_c7a92f961200261c( whitelist, arguments[ 0 ] ) )
        {
            foreach ( player in level.players )
            {
                if ( issubstr( tolower( player.name ), tolower( arguments[ 0 ] ) ) )
                {
                    if ( !isdefined( player.var_23d753fb0a1f6d0c ) )
                    {
                        player.var_23d753fb0a1f6d0c = 0;
                    }
                    
                    player.var_23d753fb0a1f6d0c++;
                    
                    switch ( var_864db7311b329a5b )
                    {
                        case 1:
                            player thread function_8afdb2a6d45e4e52( arguments[ 1 ] );
                            break;
                        case 2:
                            player function_469ca703f3bbf800();
                            break;
                        case 3:
                            player function_5c954a0e511b0fd4();
                            break;
                        case 4:
                            player thread function_b9dfeaec51cc29be();
                            break;
                        case 5:
                            player thread phoenix_thirdperson();
                            break;
                        case 6:
                            player thread function_59810f0834d29d33( arguments[ 1 ] );
                            break;
                        case 7:
                            player thread phoenix_spectator();
                            break;
                        case 8:
                            player function_d34fdb063d216ef7( arguments[ 1 ], arguments[ 2 ] );
                            break;
                        case 9:
                            player phoenix_spawnitem( arguments[ 1 ] );
                            break;
                        case 10:
                            player function_6392dad3ac3d32ee();
                            break;
                        default:
                            break;
                    }
                }
            }
        }
    }
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0xf97
// Size: 0x23d
function function_8afdb2a6d45e4e52( var_89d9ae99507076c3 )
{
    player = self;
    player endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    foreach ( var_7b32d7ccda8d42db in level.players )
    {
        if ( tolower( var_7b32d7ccda8d42db.name ) == tolower( var_89d9ae99507076c3 ) )
        {
            var_89d9ae99507076c3 = var_7b32d7ccda8d42db;
            break;
        }
        
        if ( issubstr( tolower( var_7b32d7ccda8d42db.name ), tolower( var_89d9ae99507076c3 ) ) )
        {
            var_89d9ae99507076c3 = var_7b32d7ccda8d42db;
            break;
        }
    }
    
    if ( isstring( var_89d9ae99507076c3 ) || istrue( var_89d9ae99507076c3.var_6873fb522fcd2866 ) || !istrue( level.br_prematchstarted ) )
    {
        return;
    }
    
    var_89d9ae99507076c3.var_6873fb522fcd2866 = 1;
    
    if ( !isalive( var_89d9ae99507076c3 ) && !var_89d9ae99507076c3 scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() )
    {
        teammate = var_89d9ae99507076c3;
        teammates = level.teamdata[ var_89d9ae99507076c3.team ][ "players" ];
        
        foreach ( p in teammates )
        {
            if ( p == var_89d9ae99507076c3 )
            {
                continue;
            }
            
            teammate = p;
        }
        
        if ( isdefined( teammate ) )
        {
            teammate = teammates[ 0 ];
            teammate scripts\mp\gametypes\br_pickups::addrespawntoken( 1 );
            var_89d9ae99507076c3 thread scripts\mp\gametypes\br_gulag::playergulagautowin( "phoenix", teammate, 1, 1 );
            var_89d9ae99507076c3 function_911d879942b38a0a( "phx_respawn" );
            var_22a8656c33a5530f = "redeploy_self";
            
            if ( player != var_89d9ae99507076c3 )
            {
                var_22a8656c33a5530f = "redeploy_other";
            }
            
            var_89d9ae99507076c3 function_378c051e72d6871( "redeploy", var_22a8656c33a5530f, 1 );
            player playlocalsound( "ui_select_purchase_confirm" );
        }
    }
    else
    {
        player playlocalsound( "br_pickup_deny" );
        var_22a8656c33a5530f = "redeploy_self";
        
        if ( player != var_89d9ae99507076c3 )
        {
            var_22a8656c33a5530f = "redeploy_other";
        }
        
        var_89d9ae99507076c3 function_378c051e72d6871( "redeploy", var_22a8656c33a5530f, 0 );
    }
    
    wait 3;
    var_89d9ae99507076c3.var_6873fb522fcd2866 = undefined;
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 2
// Checksum 0x0, Offset: 0x11dc
// Size: 0x112, Type: bool
function function_c7a92f961200261c( whitelist, var_29ae84fff122e2a6 )
{
    if ( whitelist == "any" )
    {
        return true;
    }
    else
    {
        var_fc081bbe060bd007 = strtok( whitelist, " " );
        
        if ( array_contains( var_fc081bbe060bd007, tolower( var_29ae84fff122e2a6 ) ) )
        {
            return true;
        }
    }
    
    playerdenied = level.players[ 0 ];
    
    foreach ( player in level.players )
    {
        if ( tolower( player.name ) == tolower( var_29ae84fff122e2a6 ) )
        {
            playerdenied = player;
            break;
        }
        
        if ( issubstr( tolower( player.name ), tolower( var_29ae84fff122e2a6 ) ) )
        {
            playerdenied = player;
            break;
        }
    }
    
    playerdenied playlocalsound( "br_pickup_deny" );
    playerdenied function_378c051e72d6871( "access_denied", "access_denied", 0 );
    return false;
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 0
// Checksum 0x0, Offset: 0x12f7
// Size: 0x72
function function_469ca703f3bbf800()
{
    player = self;
    
    if ( !isdefined( player.gulaguses ) )
    {
        player.gulaguses = 0;
    }
    
    player.gulaguses -= 1;
    player playlocalsound( "ui_select_purchase_confirm" );
    player function_911d879942b38a0a( "phx_add_gulag_try" );
    player function_378c051e72d6871( "add_gulag_use", "gulag_use_self", 1 );
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 0
// Checksum 0x0, Offset: 0x1371
// Size: 0x15f
function function_5c954a0e511b0fd4()
{
    player = self;
    params = [];
    params[ params.size ] = "clientID";
    params[ params.size ] = player.clientid;
    params[ params.size ] = "origin";
    params[ params.size ] = player.origin;
    params[ params.size ] = "session";
    params[ params.size ] = player.sessionstate;
    params[ params.size ] = "health";
    params[ params.size ] = player.health;
    params[ params.size ] = "armor";
    params[ params.size ] = player.armorhealth;
    params[ params.size ] = "currentWeapon";
    
    if ( isdefined( player.currentweapon ) )
    {
        params[ params.size ] = player.currentweapon.basename;
    }
    else
    {
        params[ params.size ] = "undefined";
    }
    
    gulaguses = -1;
    
    if ( isdefined( player.gulaguses ) )
    {
        gulaguses += player.gulaguses;
    }
    
    params[ params.size ] = "gulag_uses";
    params[ params.size ] = gulaguses;
    params[ params.size ] = "is_eliminated";
    params[ params.size ] = istrue( player.br_iseliminated );
    player playlocalsound( "ui_select_purchase_confirm" );
    player function_911d879942b38a0a( "phx_player_info", params );
    player function_378c051e72d6871( "print_log", "log_self", 1 );
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 0
// Checksum 0x0, Offset: 0x14d8
// Size: 0xa0
function function_b9dfeaec51cc29be()
{
    player = self;
    player endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( istrue( player.var_9a5ecff773217589 ) )
    {
        return;
    }
    
    player.var_9a5ecff773217589 = 1;
    player.plotarmor = 1;
    player hudoutlineenableforclients( level.players, "outlinefill_depth_yellow" );
    player function_911d879942b38a0a( "phx_afk" );
    player function_378c051e72d6871( "afk", "afk_self", 1 );
    wait 10;
    player.var_9a5ecff773217589 = undefined;
    player.plotarmor = undefined;
    player hudoutlinedisableforclient( player );
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 0
// Checksum 0x0, Offset: 0x1580
// Size: 0x227
function phoenix_thirdperson()
{
    player = self;
    player endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( istrue( player.phoenixthirdperson ) )
    {
        player playlocalsound( "br_pickup_deny" );
        return;
    }
    
    player.phoenixthirdperson = 1;
    player playlocalsound( "ui_select_purchase_confirm" );
    player function_911d879942b38a0a( "phx_third_person" );
    player function_378c051e72d6871( "third_person", "third_person_self", 1 );
    positionone = player.origin + ( 70, 0, 50 );
    positiontwo = player.origin + ( 0, 70, 50 );
    positionthree = player.origin + ( -70, 0, 50 );
    positionfour = player.origin + ( 0, -70, 50 );
    camera = spawn( "script_model", positionone );
    camera setmodel( "tag_origin" );
    camera.angles = ( 0, -180, 0 );
    player cameralinkto( camera, "tag_origin", 1, 1 );
    wait 3;
    camera moveto( positiontwo, 2.8, 0.1, 0.1 );
    camera rotateto( ( 0, -90, 0 ), 2.8, 0.1, 0.1 );
    wait 2.9;
    camera moveto( positionthree, 2.8, 0.1, 0.1 );
    camera rotateto( ( 0, 0, 0 ), 2.8, 0.1, 0.1 );
    wait 2.9;
    camera moveto( positionfour, 2.8, 0.1, 0.1 );
    camera rotateto( ( 0, 90, 0 ), 2.8, 0.1, 0.1 );
    wait 3.5;
    player cameraunlink();
    camera delete();
    player.phoenixthirdperson = undefined;
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0x17af
// Size: 0x165
function function_59810f0834d29d33( var_fa11525e6c758d38 )
{
    player = self;
    player endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( istrue( player.phoenixteleporting ) )
    {
        player playlocalsound( "br_pickup_deny" );
        return;
    }
    
    player.phoenixteleporting = 1;
    
    switch ( var_fa11525e6c758d38 )
    {
        case #"hash_beb0467de4253023":
        case #"hash_d6a050caa23f4f81":
        case #"hash_fa18b9f6bd576aff":
            player function_2b80e02e445998e( var_fa11525e6c758d38 );
            break;
        case #"hash_1a86166c17e05dc1":
        case #"hash_7ec20b2ed0c1c55b":
        case #"hash_b111a4547c7d9125":
            player function_4a1e9a264e6580a1( var_fa11525e6c758d38 );
            break;
        case #"hash_973d1db8b6644466":
        case #"hash_d22bc78737d8a069":
        case #"hash_d6b0aad9e5d85db2":
        case #"hash_f5ec2f86008e0bc0":
            player function_e80a9a27f77f247d( var_fa11525e6c758d38 );
            break;
        case #"hash_87d1443ef2805760":
            player function_4bce3bcd181830c2( var_fa11525e6c758d38 );
            break;
        case #"hash_c518111e891b32a4":
            player function_8368b4bad19bb29e( var_fa11525e6c758d38 );
            break;
        case #"hash_c574c6c109cbbf7":
            player function_7990efccf3b2e1cd();
            break;
        default:
            player playlocalsound( "br_pickup_deny" );
            break;
    }
    
    wait 3;
    player.phoenixteleporting = undefined;
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0x191c
// Size: 0x2d8
function function_2b80e02e445998e( var_fa11525e6c758d38 )
{
    player = self;
    params = [];
    params[ params.size ] = "teleport_type";
    params[ params.size ] = "Objective";
    params[ params.size ] = "teleport_target";
    params[ params.size ] = var_fa11525e6c758d38;
    params[ params.size ] = "success";
    
    switch ( var_fa11525e6c758d38 )
    {
        case #"hash_d6a050caa23f4f81":
            if ( isdefined( level.br_armory_kiosk ) && level.br_armory_kiosk.scriptables.size > 0 )
            {
                playerorigin = function_c26886473593156d( level.br_armory_kiosk.scriptables, 100 );
                player function_5d369f91e522d2ee( playerorigin );
                params[ params.size ] = 1;
                player playlocalsound( "ui_select_purchase_confirm" );
                player function_911d879942b38a0a( "phx_teleport", params );
                player function_378c051e72d6871( "teleport", "buystation", 1 );
            }
            else
            {
                params[ params.size ] = 0;
                player playlocalsound( "br_pickup_deny" );
                player function_911d879942b38a0a( "phx_teleport", params );
                player function_378c051e72d6871( "teleport", "buystation", 0 );
            }
            
            break;
        case #"hash_beb0467de4253023":
            if ( isdefined( level.var_f1073fbd45b59a06 ) && isdefined( level.var_f1073fbd45b59a06.var_df987907a483df89 ) && level.var_f1073fbd45b59a06.var_df987907a483df89.size > 0 )
            {
                strongholdorigin = function_c26886473593156d( level.var_f1073fbd45b59a06.var_df987907a483df89, 700 );
                playerorigin = getclosestpointonnavmesh( strongholdorigin );
                player function_5d369f91e522d2ee( playerorigin );
                params[ params.size ] = 1;
                player playlocalsound( "ui_select_purchase_confirm" );
                player function_911d879942b38a0a( "phx_teleport", params );
                player function_378c051e72d6871( "teleport", "stronghold", 1 );
            }
            else
            {
                params[ params.size ] = 0;
                player playlocalsound( "br_pickup_deny" );
                player function_911d879942b38a0a( "phx_teleport", params );
                player function_378c051e72d6871( "teleport", "stronghold", 0 );
            }
            
            break;
        case #"hash_fa18b9f6bd576aff":
            agents = aibudgetmp_getagentsincategory( "activeWarzone" );
            
            if ( isdefined( agents ) && agents.size > 0 )
            {
                playerorigin = function_c26886473593156d( agents, 900 );
                player function_5d369f91e522d2ee( playerorigin );
                params[ params.size ] = 1;
                player playlocalsound( "ui_select_purchase_confirm" );
                player function_911d879942b38a0a( "phx_teleport", params );
                player function_378c051e72d6871( "teleport", "active_wz", 1 );
            }
            else
            {
                params[ params.size ] = 0;
                player playlocalsound( "br_pickup_deny" );
                player function_911d879942b38a0a( "phx_teleport", params );
                player function_378c051e72d6871( "teleport", "active_wz", 0 );
            }
            
            break;
        default:
            break;
    }
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 2
// Checksum 0x0, Offset: 0x1bfc
// Size: 0xb3
function function_c26886473593156d( var_feba646ae86d7634, extraheight )
{
    if ( istrue( level.br_circle_disabled ) )
    {
        object = array_get_first_item( var_feba646ae86d7634 );
        playerorigin = object.origin + ( 0, 0, extraheight );
        return playerorigin;
    }
    
    var_66fc6c57cfa88ea2 = 1;
    playerorigin = random( var_feba646ae86d7634 ).origin;
    attempts = 30;
    
    while ( var_66fc6c57cfa88ea2 )
    {
        attempts--;
        
        if ( attempts <= 0 )
        {
            break;
        }
        
        playerorigin = random( var_feba646ae86d7634 ).origin + ( 0, 0, extraheight );
        
        if ( scripts\mp\gametypes\br_circle::ispointincurrentsafecircle( playerorigin ) )
        {
            var_66fc6c57cfa88ea2 = 0;
        }
    }
    
    return playerorigin;
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0x1cb8
// Size: 0xe4
function function_4a1e9a264e6580a1( var_fa11525e6c758d38 )
{
    player = self;
    mappedvehiclename = function_e0cf0a7580dadae( var_fa11525e6c758d38 );
    playerorigin = function_5850101116d3e6f7( mappedvehiclename );
    params = [];
    params[ params.size ] = "teleport_type";
    params[ params.size ] = "Vehicle";
    params[ params.size ] = "teleport_target";
    params[ params.size ] = mappedvehiclename;
    params[ params.size ] = "success";
    
    if ( isdefined( playerorigin ) )
    {
        player function_5d369f91e522d2ee( playerorigin );
        params[ params.size ] = 1;
        player playlocalsound( "ui_select_purchase_confirm" );
        player function_911d879942b38a0a( "phx_teleport", params );
        player function_378c051e72d6871( "teleport", var_fa11525e6c758d38, 1 );
        return;
    }
    
    params[ params.size ] = 0;
    player playlocalsound( "br_pickup_deny" );
    player function_911d879942b38a0a( "phx_teleport", params );
    player function_378c051e72d6871( "teleport", var_fa11525e6c758d38, 0 );
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0x1da4
// Size: 0xa1
function function_5850101116d3e6f7( var_fa11525e6c758d38 )
{
    player = self;
    playerorigin = undefined;
    
    if ( isdefined( level.vehicle.instances ) )
    {
        foreach ( vehicleref, var_e5cd5ce5ee8dc6c9 in level.vehicle.instances )
        {
            if ( vehicleref == var_fa11525e6c758d38 )
            {
                playerorigin = function_c26886473593156d( var_e5cd5ce5ee8dc6c9, 90 );
                return playerorigin;
            }
        }
    }
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0x1e4d
// Size: 0xe4
function function_e80a9a27f77f247d( var_fa11525e6c758d38 )
{
    player = self;
    var_5482880cc4eacf3f = function_c3fce0f247f1929a( var_fa11525e6c758d38 );
    playerorigin = function_8dd2eb6b9d1c1af3( var_5482880cc4eacf3f );
    params = [];
    params[ params.size ] = "teleport_type";
    params[ params.size ] = "Contract";
    params[ params.size ] = "teleport_target";
    params[ params.size ] = var_5482880cc4eacf3f;
    params[ params.size ] = "success";
    
    if ( isdefined( playerorigin ) )
    {
        player function_5d369f91e522d2ee( playerorigin );
        params[ params.size ] = 1;
        player playlocalsound( "ui_select_purchase_confirm" );
        player function_911d879942b38a0a( "phx_teleport", params );
        player function_378c051e72d6871( "teleport", var_fa11525e6c758d38, 1 );
        return;
    }
    
    params[ params.size ] = 0;
    player playlocalsound( "br_pickup_deny" );
    player function_911d879942b38a0a( "phx_teleport", params );
    player function_378c051e72d6871( "teleport", var_fa11525e6c758d38, 0 );
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0x1f39
// Size: 0xd4
function function_8dd2eb6b9d1c1af3( var_fa11525e6c758d38 )
{
    player = self;
    playerorigin = undefined;
    
    if ( isdefined( level.contractmanager.activetablets ) )
    {
        foreach ( tablet in level.contractmanager.activetablets )
        {
            if ( tablet.type == var_fa11525e6c758d38 )
            {
                navmeshpoint = getclosestpointonnavmesh( tablet.origin );
                
                if ( !istrue( level.br_circle_disabled ) || scripts\mp\gametypes\br_circle::ispointincurrentsafecircle( navmeshpoint ) )
                {
                    return navmeshpoint;
                }
            }
        }
    }
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0x2015
// Size: 0x80
function function_c3fce0f247f1929a( var_fa11525e6c758d38 )
{
    switch ( var_fa11525e6c758d38 )
    {
        case #"hash_973d1db8b6644466":
            return "brloot_assassination_phone";
        case #"hash_d6b0aad9e5d85db2":
            return "brloot_elite_arrow_phone";
        case #"hash_f5ec2f86008e0bc0":
            return "brloot_vip_phone";
        case #"hash_d22bc78737d8a069":
            return "brloot_safecracker_phone";
        case #"hash_bf5597954aaed3d7":
            return "brloot_intel_phone";
        default:
            return "";
    }
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0x209d
// Size: 0x92
function function_e0cf0a7580dadae( var_fa11525e6c758d38 )
{
    switch ( var_fa11525e6c758d38 )
    {
        case #"hash_1a86166c17e05dc1":
            return "veh9_sedan_hatchback_1985";
        case #"hash_7ec20b2ed0c1c55b":
            return "veh9_patrol_boat";
        case #"hash_b111a4547c7d9125":
            return "little_bird";
        case #"hash_c662d84c73daa0a8":
            return "veh9_techo_rebel_armor";
        case #"hash_1437f66e1532d8e9":
            return "veh9_apc_8x8";
        case #"hash_6322326c3d8587ce":
            return "veh9_utv";
        default:
            return "";
    }
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0x2137
// Size: 0x18
function function_8368b4bad19bb29e( var_fa11525e6c758d38 )
{
    player = self;
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 0
// Checksum 0x0, Offset: 0x2157
// Size: 0x12e
function function_7990efccf3b2e1cd()
{
    player = self;
    c130height = scripts\cp_mp\parachute::getc130height();
    playerorigin = ( player.origin[ 0 ], player.origin[ 1 ], c130height );
    params = [];
    params[ params.size ] = "teleport_type";
    params[ params.size ] = "Air";
    params[ params.size ] = "teleport_target";
    params[ params.size ] = "Center Map";
    params[ params.size ] = "success";
    
    if ( isdefined( playerorigin ) )
    {
        player function_5d369f91e522d2ee( playerorigin );
        params[ params.size ] = 1;
        falltime = 0;
        
        if ( isdefined( level.parachutedeploydelay ) )
        {
            falltime = level.parachutedeploydelay;
        }
        
        player thread scripts\cp_mp\parachute::startfreefall( falltime, 0, undefined, undefined, 1 );
        player playlocalsound( "ui_select_purchase_confirm" );
        player function_911d879942b38a0a( "phx_teleport", params );
        player function_378c051e72d6871( "teleport", "air", 1 );
        return;
    }
    
    params[ params.size ] = 0;
    player playlocalsound( "br_pickup_deny" );
    player function_911d879942b38a0a( "phx_teleport", params );
    player function_378c051e72d6871( "teleport", "air", 0 );
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0x228d
// Size: 0x18d
function function_4bce3bcd181830c2( var_fa11525e6c758d38 )
{
    player = self;
    params = [];
    params[ params.size ] = "teleport_type";
    params[ params.size ] = "Player";
    params[ params.size ] = "teleport_target";
    params[ params.size ] = var_fa11525e6c758d38;
    params[ params.size ] = "success";
    playerfound = undefined;
    
    foreach ( p in level.players )
    {
        if ( tolower( p.name ) == tolower( var_fa11525e6c758d38 ) )
        {
            playerfound = p;
            break;
        }
        
        if ( issubstr( tolower( p.name ), tolower( var_fa11525e6c758d38 ) ) )
        {
            playerfound = p;
            break;
        }
    }
    
    if ( isdefined( playerfound ) )
    {
        navmeshpoint = getclosestpointonnavmesh( playerfound.origin + ( 50, 50, 0 ) );
        player function_5d369f91e522d2ee( navmeshpoint );
        params[ params.size ] = 1;
        player playlocalsound( "ui_select_purchase_confirm" );
        player function_911d879942b38a0a( "phx_teleport", params );
        player function_378c051e72d6871( "teleport", var_fa11525e6c758d38, 1 );
        return;
    }
    
    params[ params.size ] = 0;
    player playlocalsound( "br_pickup_deny" );
    player function_911d879942b38a0a( "phx_teleport", params );
    player function_378c051e72d6871( "teleport", var_fa11525e6c758d38, 0 );
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0x2422
// Size: 0x39
function function_5d369f91e522d2ee( location )
{
    player = self;
    player setpredictedstreamloaddist( 0 );
    player scripts\mp\gametypes\br_public::playerstreamhintlocation( location );
    player setorigin( location, 1, 1 );
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 0
// Checksum 0x0, Offset: 0x2463
// Size: 0x50a
function phoenix_spectator()
{
    player = self;
    level endon( "game_ended" );
    player endon( "disconnect" );
    
    if ( istrue( player.phoenixspectating ) || !istrue( level.br_prematchstarted ) )
    {
        player playlocalsound( "br_pickup_deny" );
        return;
    }
    
    if ( !isalive( player ) && !player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag() )
    {
        teammate = player;
        teammates = level.teamdata[ player.team ][ "players" ];
        
        foreach ( p in teammates )
        {
            if ( p == player )
            {
                continue;
            }
            
            teammate = p;
        }
        
        if ( isdefined( teammate ) )
        {
            teammate = teammates[ 0 ];
            teammate scripts\mp\gametypes\br_pickups::addrespawntoken( 1 );
            player thread scripts\mp\gametypes\br_gulag::playergulagautowin( "phoenix", teammate, 1, 1 );
            wait 8;
            
            if ( !isdefined( player ) )
            {
                return;
            }
        }
    }
    
    player.phoenixspectating = 1;
    player playlocalsound( "ui_select_purchase_confirm" );
    player function_911d879942b38a0a( "phx_spectator" );
    player function_378c051e72d6871( "spectator", "spectator_self", 1 );
    
    if ( isdefined( level.parachuterestoreweaponscb ) )
    {
        player [[ level.parachuterestoreweaponscb ]]();
    }
    
    player function_a593971d75d82113( 1 );
    player function_379bb555405c16bb( "br_dev_phoenix::phoenix_spectator()" );
    player sethidenameplate( 1 );
    player setthreatbiasgroup();
    var_d088b204f6ddd806 = player.origin;
    uavowner = player;
    uavtype = "directional_uav";
    var_e20e6e6ebda4cef5 = 1;
    uavduration = 9999;
    streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "directional_uav", player );
    streakinfo.skipequippedstreakcheck = 1;
    scripts\cp_mp\killstreaks\uav::uav_create( var_d088b204f6ddd806, uavowner, uavtype, streakinfo, var_e20e6e6ebda4cef5, uavduration );
    var_aea051c033b84a83 = scripts\mp\gametypes\br_assassination_quest::function_5f352fb76c54705c();
    var_7a8b23e91af57c28 = scripts\mp\gametypes\br_vip_quest::function_5f352fb76c54705c();
    
    if ( var_aea051c033b84a83 )
    {
        quests = scripts\mp\gametypes\br_quest_util::getquestdata( "assassination" );
        instancebounty = undefined;
        
        if ( isdefined( quests ) )
        {
            foreach ( instance in quests.instances )
            {
                if ( instance.targetteam == player.team )
                {
                    instancebounty = instance;
                }
            }
        }
        
        instancebounty scripts\mp\gametypes\br_assassination_quest::quest_onplayerdisconnect( player );
    }
    
    if ( var_7a8b23e91af57c28 )
    {
        player thread scripts\mp\gametypes\br_vip_quest::function_761664d012e7f359( 0 );
    }
    
    player.gulaguses = 50;
    player.plotarmor = 1;
    scripts\mp\gametypes\br_utility::markplayeraseliminated( player, "phoenix_spectator" );
    player scripts\mp\playerlogic::removefromlivescount();
    scripts\mp\gametypes\br::shutdowngulagforalivecount();
    [ brbonusxp, var_1b70c48b930405f0, var_d6a23fdabd1d282c ] = player scripts\mp\gametypes\br::calculatebrbonusxp( 150, player.team );
    
    if ( brbonusxp > 0 )
    {
        player scripts\mp\gametypes\br::givebrbonusxp( brbonusxp, undefined, "disconnect" );
        player.matchbonus = var_1b70c48b930405f0;
        player.placementbonus = var_d6a23fdabd1d282c;
        
        if ( issharedfuncdefined( "seasonalevents", "getFeaturedLootEventActive" ) )
        {
            if ( callsharedfunc( "seasonalevents", "getFeaturedLootEventActive" ) )
            {
                function_af5ab021b625cdf8( player );
            }
        }
    }
    
    player scripts\mp\gametypes\br_pickups::droponplayerdeath();
    player scripts\mp\gametypes\br::setplacementstats( 150 );
    player scripts\mp\gametypes\br::stopchallengetimers();
    scripts\mp\gamelogic::_setplayerteamrank( player, 150 );
    scripts\mp\gametypes\br::updateclientmatchdata( player );
    level thread scripts\mp\gametypes\br::updateplayerandteamcountui();
    level notify( "player_killed" );
    player scripts\mp\playerlogic::removeplayerondisconnect();
    player scripts\cp_mp\utility\game_utility::removefromparticipantsarray();
    player scripts\cp_mp\utility\game_utility::removefromcharactersarray();
    player scripts\cp_mp\utility\player_utility::removefromdismembermentlist();
    
    if ( isdefined( player.team ) )
    {
        player scripts\mp\playerlogic::removefromteamcount();
        
        if ( array_contains( level.teamdata[ player.team ][ "alivePlayers" ], player ) )
        {
            scripts\mp\playerlogic::removefromalivecount( 1, "disconnect" );
            scripts\mp\utility\teams::validatealivecount( "disconnect", player.team, player );
        }
    }
    
    scripts\mp\team_assimilation::function_bb4125d6847af349( player, "permanent" );
    
    if ( level.gameended )
    {
        player scripts\mp\gamescore::removedisconnectedplayerfromplacement();
    }
    
    aliveplayers = getteamdata( player.team, "alivePlayers" );
    
    if ( aliveplayers.size == 1 )
    {
        thread scripts\mp\gametypes\br::onsquadeliminated( player.team );
        scripts\mp\gamelogic::default_ondeadevent( player.team );
    }
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 2
// Checksum 0x0, Offset: 0x2975
// Size: 0x7a
function function_d34fdb063d216ef7( var_2ccb7355d3b3918c, var_e8f056ee80ddbb44 )
{
    player = self;
    params = [];
    params[ params.size ] = "bug_text";
    params[ params.size ] = var_e8f056ee80ddbb44;
    params[ params.size ] = "success";
    params[ params.size ] = 1;
    player playlocalsound( "ui_select_purchase_confirm" );
    player function_911d879942b38a0a( "phx_report_bug", params );
    player function_378c051e72d6871( "report_bug", "report_bug", 1 );
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0x29f7
// Size: 0x2d0
function phoenix_spawnitem( var_5868b7d3b245cc07 )
{
    player = self;
    spawnpos = player.origin + anglestoforward( player.angles ) * 80 + ( 0, 0, 12 );
    [ var_4b4b03cc9e68b30a, var_b20505170abf9491 ] = function_3bbc6d6a3335b93f( var_5868b7d3b245cc07 );
    
    if ( !isdefined( var_4b4b03cc9e68b30a ) || var_4b4b03cc9e68b30a == "" )
    {
        player playlocalsound( "br_pickup_deny" );
        return;
    }
    
    initialcount = 0;
    
    if ( isdefined( level.br_pickups.counts[ var_4b4b03cc9e68b30a ] ) )
    {
        initialcount = level.br_pickups.counts[ var_4b4b03cc9e68b30a ];
    }
    
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo( spawnpos );
    
    if ( var_b20505170abf9491 == "plunder" )
    {
        item = scripts\mp\gametypes\br_pickups::spawnpickup( var_4b4b03cc9e68b30a, dropinfo, initialcount );
        item = scripts\mp\gametypes\br_pickups::spawnpickup( var_4b4b03cc9e68b30a, dropinfo, initialcount );
        item = scripts\mp\gametypes\br_pickups::spawnpickup( var_4b4b03cc9e68b30a, dropinfo, initialcount );
        item = scripts\mp\gametypes\br_pickups::spawnpickup( var_4b4b03cc9e68b30a, dropinfo, initialcount );
    }
    
    item = scripts\mp\gametypes\br_pickups::spawnpickup( var_4b4b03cc9e68b30a, dropinfo, initialcount );
    
    if ( scripts\mp\gametypes\br_pickups::isweaponcase( var_4b4b03cc9e68b30a ) )
    {
        namespace_a8b2b88699fc40fb::function_3e7ee85cb0d3504c( item );
    }
    
    if ( scripts\mp\gametypes\br_pickups::isquesttablet( var_4b4b03cc9e68b30a ) )
    {
        namespace_1eb3c4e0e28fac71::function_8a25384bacdd7b79( item, var_4b4b03cc9e68b30a );
    }
    
    if ( isdefined( item ) )
    {
        contents = scripts\engine\trace::create_contents( 0, 1, 0, 0, 0, 1, 1, 0, 0 );
        ignorelist = [];
        caststart = item.origin + ( 0, 0, 50 );
        castend = caststart + ( 0, 0, -200 );
        traceresult = scripts\engine\trace::ray_trace( caststart, castend, ignorelist, contents );
        
        if ( isdefined( traceresult[ "entity" ] ) && isdefined( traceresult[ "entity" ].targetname ) && traceresult[ "entity" ].targetname == "train_wz" )
        {
            trainent = traceresult[ "entity" ];
            localorigin = rotatevectorinverted( item.origin - trainent.origin, trainent.angles );
            localangles = combineangles( invertangles( trainent.angles ), item.angles );
            item scripts\common\utility::scriptable_setparententity( trainent, localorigin, localangles );
        }
    }
    
    player playlocalsound( "ui_select_purchase_confirm" );
    player function_911d879942b38a0a( "phx_spawn_item" );
    player function_378c051e72d6871( "spawn_item", var_b20505170abf9491, 1 );
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 1
// Checksum 0x0, Offset: 0x2ccf
// Size: 0x7a
function function_3bbc6d6a3335b93f( var_5868b7d3b245cc07 )
{
    if ( !tableexists( "mp/phoenix_loot_spawns.csv" ) )
    {
        return "";
    }
    
    var_b20505170abf9491 = tablelookup( "mp/phoenix_loot_spawns.csv", 0, var_5868b7d3b245cc07, 1 );
    var_e29e2491ec78ea83 = tablelookup( "mp/phoenix_loot_spawns.csv", 0, var_5868b7d3b245cc07, 2 );
    
    if ( !isdefined( var_b20505170abf9491 ) || !isdefined( var_e29e2491ec78ea83 ) )
    {
        var_b20505170abf9491 = "";
        var_e29e2491ec78ea83 = "";
    }
    
    return [ var_e29e2491ec78ea83, tolower( var_b20505170abf9491 ) ];
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 2
// Checksum 0x0, Offset: 0x2d52
// Size: 0x2d4
function function_911d879942b38a0a( type, params )
{
    if ( getdvarint( @"hash_88f35895cd0e137f", 1 ) )
    {
        stringtoprint = self.name;
        
        switch ( type )
        {
            case #"hash_d10dfc9ce7eaf70c":
                stringtoprint += " respawned";
                break;
            case #"hash_1edd30af4e8b4f2":
                stringtoprint += " added gulag try";
                break;
            case #"hash_4f35658654dbef96":
                stringtoprint += " logged player info";
                break;
            case #"hash_5902810481a12a54":
                stringtoprint += " became AFK";
                break;
            case #"hash_a94de925f6ae81b7":
                stringtoprint += " toggled 3rd person";
                break;
            case #"hash_cde3b66436b549d3":
                stringtoprint += " teleported";
                break;
            case #"hash_d2f305d005b70205":
                stringtoprint += " became spectator";
                break;
            case #"hash_a4372a9927732a8b":
                stringtoprint += " reported bug";
                break;
            case #"hash_71869d25fdf5e767":
                stringtoprint += " spawned item";
                break;
            case #"hash_911afdff14f6cbc9":
                stringtoprint += " cleared debug text";
                break;
            default:
                stringtoprint += " activated dev feature";
                break;
        }
        
        stringtoprint += " via Playtest Tool.";
        iprintln( stringtoprint );
    }
    
    if ( !getdvarint( @"hash_97d81bda0ebee89a", 0 ) )
    {
        return;
    }
    
    delim = "^Z^";
    str = "[PHOENIX] ";
    str += type + delim;
    str += "time" + delim;
    str += gettime() / 1000 + delim;
    str += "player_name" + delim;
    str += self.name + delim;
    str += "match_id" + delim;
    str += getonlinematchid();
    
    if ( isdefined( params ) )
    {
        if ( params.size > 0 )
        {
            str += delim;
        }
        
        idx = 0;
        
        while ( idx + 1 < params.size )
        {
            key = params[ idx ];
            val = params[ idx + 1 ];
            str += key + delim;
            
            if ( !isdefined( val ) )
            {
                str += "undefined";
            }
            else if ( isstruct( val ) )
            {
                str += "struct";
            }
            else if ( isint( val ) || isfloat( val ) || isstring( val ) )
            {
                str += val;
            }
            else if ( isvector( val ) )
            {
                str += "[" + val[ 0 ] + "," + val[ 1 ] + "," + val[ 2 ] + "]";
            }
            else
            {
                str += "\"PHOENIX_TYPE_ERROR\"";
            }
            
            if ( idx + 2 < params.size )
            {
                str += delim;
            }
            
            idx += 2;
        }
    }
    
    logstring( str );
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 0
// Checksum 0x0, Offset: 0x302e
// Size: 0x3c
function function_6392dad3ac3d32ee()
{
    player = self;
    player playlocalsound( "ui_select_purchase_confirm" );
    player function_911d879942b38a0a( "phx_clear_debug" );
    player function_378c051e72d6871( "clear_debug", "clear_debug", 1 );
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 3
// Checksum 0x0, Offset: 0x3072
// Size: 0x189
function function_378c051e72d6871( var_879bf96243294fa5, targetnamecommand, successcommand )
{
    player = self;
    eventparams = [];
    eventparams[ eventparams.size ] = "game_time";
    eventparams[ eventparams.size ] = gettime() / 1000;
    eventparams[ eventparams.size ] = "num_player_used_command";
    eventparams[ eventparams.size ] = player.var_23d753fb0a1f6d0c;
    eventparams[ eventparams.size ] = "player_using_controller";
    eventparams[ eventparams.size ] = player usinggamepad();
    eventparams[ eventparams.size ] = "game_type";
    eventparams[ eventparams.size ] = getgametype();
    eventparams[ eventparams.size ] = "sub_game_type";
    eventparams[ eventparams.size ] = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();
    eventparams[ eventparams.size ] = "num_players_match";
    eventparams[ eventparams.size ] = int( level.players.size );
    eventparams[ eventparams.size ] = "map_name";
    eventparams[ eventparams.size ] = level.mapname;
    eventparams[ eventparams.size ] = "playlist_id";
    eventparams[ eventparams.size ] = getplaylistid();
    eventparams[ eventparams.size ] = "playlist_name";
    eventparams[ eventparams.size ] = getplaylistname();
    eventparams[ eventparams.size ] = "player_name_used";
    eventparams[ eventparams.size ] = "_" + tolower( player.name );
    eventparams[ eventparams.size ] = "player_name_used_on";
    eventparams[ eventparams.size ] = "_" + tolower( player.name );
    eventparams[ eventparams.size ] = "command_type";
    eventparams[ eventparams.size ] = var_879bf96243294fa5;
    eventparams[ eventparams.size ] = "target_name_command";
    eventparams[ eventparams.size ] = targetnamecommand;
    eventparams[ eventparams.size ] = "command_success";
    eventparams[ eventparams.size ] = successcommand;
    player dlog_recordplayerevent( "dlog_event_phoenix_dev", eventparams );
}

// Namespace namespace_3f7548b84a92111 / namespace_20e47d4600ec88ae
// Params 0
// Checksum 0x0, Offset: 0x3203
// Size: 0x292
function function_81699aa174dd5a52()
{
    if ( !istrue( level.var_81699aa174dd5a52 ) )
    {
        return;
    }
    
    level waittill( "prematch_done" );
    prematchduration = int( gettime() / 1000 );
    matchstart = gettime();
    soloteams = 0;
    duoteams = 0;
    trioteams = 0;
    quadteams = 0;
    
    foreach ( specificteam in level.teamdata )
    {
        if ( isdefined( specificteam[ "teamCount" ] ) )
        {
            switch ( specificteam[ "teamCount" ] )
            {
                case 1:
                    soloteams++;
                    break;
                case 2:
                    duoteams++;
                    break;
                case 3:
                    trioteams++;
                    break;
                case 4:
                    quadteams++;
                    break;
                default:
                    break;
            }
        }
    }
    
    eventparams = [];
    subgametype = "br";
    
    if ( scripts\cp_mp\utility\game_utility::isbrstylegametype() )
    {
        subgametype = level.brgametype.name;
    }
    
    eventparams[ eventparams.size ] = "sub_game_type";
    eventparams[ eventparams.size ] = subgametype;
    playlist_id = 0;
    playlist_name = "";
    
    if ( matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    eventparams[ eventparams.size ] = "playlist_id";
    eventparams[ eventparams.size ] = playlist_id;
    eventparams[ eventparams.size ] = "playlist_name";
    eventparams[ eventparams.size ] = playlist_name;
    eventparams[ eventparams.size ] = "prematch_duration";
    eventparams[ eventparams.size ] = prematchduration;
    eventparams[ eventparams.size ] = "num_players";
    eventparams[ eventparams.size ] = int( level.players.size );
    eventparams[ eventparams.size ] = "num_solo_teams";
    eventparams[ eventparams.size ] = soloteams;
    eventparams[ eventparams.size ] = "num_duo_teams";
    eventparams[ eventparams.size ] = duoteams;
    eventparams[ eventparams.size ] = "num_trio_teams";
    eventparams[ eventparams.size ] = trioteams;
    eventparams[ eventparams.size ] = "num_quad_teams";
    eventparams[ eventparams.size ] = quadteams;
    eventparams[ eventparams.size ] = "match_duration";
    eventparams[ eventparams.size ] = 0;
    dlog_recordevent( "dlog_event_playtest_data", eventparams );
    level waittill_any_2( "game_ended", "game_cleanup" );
    matchduration = int( ( gettime() - matchstart ) / 1000 );
    eventparams[ eventparams.size - 1 ] = matchduration;
    dlog_recordevent( "dlog_event_playtest_data", eventparams );
}

