#using scripts\common\utility;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_c130;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;

#namespace br_convoy;

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0x410
// Size: 0x15
function unimogtest( c130pathstruct )
{
    level thread spawntestconvoy( c130pathstruct );
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0x42d
// Size: 0x15
function unimogsnatch( c130pathstruct )
{
    level thread spawnspreadconvoy( c130pathstruct );
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0x44a
// Size: 0x2e1
function spawntestconvoy( c130pathstruct )
{
    level.br_convoytrucks = [];
    paths = getvehiclenodearray( "br_convoy", "targetname" );
    var_4d4d20d31099d146 = [];
    
    for ( i = 0; i < paths.size ; i++ )
    {
        var_4d4d20d31099d146[ i ] = paths[ i ];
    }
    
    mapcenter = ( level.br_level.br_mapbounds[ 0 ] + level.br_level.br_mapbounds[ 1 ] ) * 0.5;
    var_252e739bc4f9bf6a = c130pathstruct.startpt - mapcenter;
    var_d2392c09df33a38f = vectortoangles( var_252e739bc4f9bf6a )[ 1 ];
    var_4a1a4bec206cbba2 = [];
    
    for ( i = 0; i < paths.size ; i++ )
    {
        tostartnode = var_4d4d20d31099d146[ i ].origin - mapcenter;
        var_4a1a4bec206cbba2[ i ] = vectortoangles( tostartnode )[ 1 ];
    }
    
    var_85ab47ef7f70892e = -1;
    var_76714bf77c396ac3 = -1;
    
    for ( i = 0; i < paths.size ; i++ )
    {
        if ( var_d2392c09df33a38f < var_4a1a4bec206cbba2[ i ] )
        {
            var_76714bf77c396ac3 = i;
            continue;
        }
        
        if ( var_76714bf77c396ac3 != -1 )
        {
            break;
        }
    }
    
    for ( i = 0; i < paths.size ; i++ )
    {
        if ( var_d2392c09df33a38f > var_4a1a4bec206cbba2[ i ] )
        {
            var_85ab47ef7f70892e = i;
            continue;
        }
        
        if ( var_85ab47ef7f70892e != -1 )
        {
            break;
        }
    }
    
    if ( var_85ab47ef7f70892e == -1 )
    {
        var_85ab47ef7f70892e = paths.size - 1;
    }
    
    if ( var_76714bf77c396ac3 == -1 )
    {
        var_76714bf77c396ac3 = 0;
    }
    
    /#
        println( "<dev string:x1c>" + var_85ab47ef7f70892e + "<dev string:x54>" + var_76714bf77c396ac3 );
        println( "<dev string:x5e>" + var_4a1a4bec206cbba2[ var_85ab47ef7f70892e ] + "<dev string:x6d>" + var_4a1a4bec206cbba2[ var_76714bf77c396ac3 ] );
        
        for ( i = 0; i < var_4a1a4bec206cbba2.size ; i++ )
        {
            println( "<dev string:x76>" + i + "<dev string:x81>" + var_4a1a4bec206cbba2[ i ] );
        }
    #/
    
    var_3dd1974e56ef9f1c = 1;
    pathindices = [ var_85ab47ef7f70892e, var_76714bf77c396ac3 ];
    
    for ( i = 0; i < var_3dd1974e56ef9f1c ; i++ )
    {
        if ( var_85ab47ef7f70892e - 1 - i <= 0 )
        {
            pathindices[ pathindices.size ] = paths.size - 1 - i;
        }
        else
        {
            pathindices[ pathindices.size ] = var_85ab47ef7f70892e - 1 - i;
        }
        
        if ( var_76714bf77c396ac3 + 1 + i >= paths.size )
        {
            pathindices[ pathindices.size ] = 0;
        }
        else
        {
            pathindices[ pathindices.size ] = var_76714bf77c396ac3 + 1 + i;
        }
        
        println( "<dev string:x86>" + pathindices[ pathindices.size - 1 ] + "<dev string:x9e>" + var_4a1a4bec206cbba2[ pathindices[ pathindices.size - 1 ] ] );
    }
    
    /#
        for ( i = 0; i < pathindices.size ; i++ )
        {
            println( "<dev string:xa9>" + i + "<dev string:x81>" + pathindices[ i ] );
        }
    #/
    
    for ( i = 0; i < pathindices.size ; i++ )
    {
        thread spawnconvoyatpath( paths[ pathindices[ i ] ] );
    }
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0x733
// Size: 0x367
function spawnspreadconvoy( c130pathstruct )
{
    level.br_convoytrucks = [];
    paths = getvehiclenodearray( "br_convoy", "targetname" );
    removelist = [];
    
    foreach ( var_36809cc9ad8ce6df in paths )
    {
        if ( distancesquared( var_36809cc9ad8ce6df.origin, ( 19328, 2944, 512 ) ) < 40000 )
        {
            removelist[ removelist.size ] = var_36809cc9ad8ce6df;
        }
    }
    
    paths = array_remove_array( paths, removelist );
    var_4d4d20d31099d146 = [];
    
    for ( i = 0; i < paths.size ; i++ )
    {
        var_4d4d20d31099d146[ i ] = paths[ i ];
    }
    
    mapcenter = ( level.br_level.br_mapbounds[ 0 ] + level.br_level.br_mapbounds[ 1 ] ) * 0.5;
    var_252e739bc4f9bf6a = c130pathstruct.startpt - mapcenter;
    var_d2392c09df33a38f = vectortoangles( var_252e739bc4f9bf6a )[ 1 ];
    var_4a1a4bec206cbba2 = [];
    
    for ( i = 0; i < paths.size ; i++ )
    {
        tostartnode = var_4d4d20d31099d146[ i ].origin - mapcenter;
        var_4a1a4bec206cbba2[ i ] = vectortoangles( tostartnode )[ 1 ];
    }
    
    var_85ab47ef7f70892e = -1;
    var_76714bf77c396ac3 = -1;
    
    for ( i = 0; i < paths.size ; i++ )
    {
        if ( var_d2392c09df33a38f < var_4a1a4bec206cbba2[ i ] )
        {
            var_76714bf77c396ac3 = i;
            continue;
        }
        
        if ( var_76714bf77c396ac3 != -1 )
        {
            break;
        }
    }
    
    for ( i = 0; i < paths.size ; i++ )
    {
        if ( var_d2392c09df33a38f > var_4a1a4bec206cbba2[ i ] )
        {
            var_85ab47ef7f70892e = i;
            continue;
        }
        
        if ( var_85ab47ef7f70892e != -1 )
        {
            break;
        }
    }
    
    if ( var_85ab47ef7f70892e == -1 )
    {
        var_85ab47ef7f70892e = paths.size - 1;
    }
    
    if ( var_76714bf77c396ac3 == -1 )
    {
        var_76714bf77c396ac3 = 0;
    }
    
    /#
        println( "<dev string:x1c>" + var_85ab47ef7f70892e + "<dev string:x54>" + var_76714bf77c396ac3 );
        println( "<dev string:x5e>" + var_4a1a4bec206cbba2[ var_85ab47ef7f70892e ] + "<dev string:x6d>" + var_4a1a4bec206cbba2[ var_76714bf77c396ac3 ] );
        
        for ( i = 0; i < var_4a1a4bec206cbba2.size ; i++ )
        {
            println( "<dev string:x76>" + i + "<dev string:x81>" + var_4a1a4bec206cbba2[ i ] );
        }
    #/
    
    var_3dd1974e56ef9f1c = 4;
    pathindices = [ var_85ab47ef7f70892e, var_76714bf77c396ac3 ];
    
    for ( i = 0; i < var_3dd1974e56ef9f1c ; i++ )
    {
        if ( var_85ab47ef7f70892e - 1 - i <= 0 )
        {
            pathindices[ pathindices.size ] = paths.size - 1 - i;
        }
        else
        {
            pathindices[ pathindices.size ] = var_85ab47ef7f70892e - 1 - i;
        }
        
        if ( var_76714bf77c396ac3 + 1 + i >= paths.size )
        {
            pathindices[ pathindices.size ] = 0;
        }
        else
        {
            pathindices[ pathindices.size ] = var_76714bf77c396ac3 + 1 + i;
        }
        
        println( "<dev string:x86>" + pathindices[ pathindices.size - 1 ] + "<dev string:x9e>" + var_4a1a4bec206cbba2[ pathindices[ pathindices.size - 1 ] ] );
    }
    
    /#
        for ( i = 0; i < pathindices.size ; i++ )
        {
            println( "<dev string:xa9>" + i + "<dev string:x81>" + pathindices[ i ] );
        }
    #/
    
    for ( i = 0; i < pathindices.size ; i++ )
    {
        thread spawnhalfconvoyatpath( paths[ pathindices[ i ] ] );
    }
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0xaa2
// Size: 0x12b
function spawnhalfconvoyatpath( path )
{
    level endon( "game_ended" );
    goleft = 0;
    
    if ( isdefined( path.script_noteworthy ) )
    {
        if ( path.script_noteworthy == "left" )
        {
            goleft = 1;
        }
    }
    
    trucks = [];
    
    for ( j = 0; j < 2 ; j++ )
    {
        truck = spawntruck( path, path.angles, goleft );
        trucks[ trucks.size ] = truck;
        wait 1.333;
    }
    
    if ( level.mapname == "mp_torez" )
    {
        var_565e98c561535a89 = 3;
        truckspeed = 17;
    }
    else
    {
        var_565e98c561535a89 = 15;
        truckspeed = 25;
    }
    
    for ( j = 0; j < trucks.size ; j++ )
    {
        trucks[ j ] vehicle_setspeedimmediate( var_565e98c561535a89, 30, 30 );
    }
    
    wait 10;
    
    for ( j = 0; j < trucks.size ; j++ )
    {
        trucks[ j ] vehicle_setspeedimmediate( var_565e98c561535a89 * 2, 30, 30 );
    }
    
    wait 4;
    
    for ( j = 0; j < trucks.size ; j++ )
    {
        trucks[ j ] vehicle_setspeedimmediate( truckspeed, 30, 30 );
    }
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0xbd5
// Size: 0xc8
function spawnconvoyatpath( path )
{
    level endon( "game_ended" );
    goleft = 0;
    
    if ( isdefined( path.script_noteworthy ) )
    {
        if ( path.script_noteworthy == "left" )
        {
            goleft = 1;
        }
    }
    
    trucks = [];
    
    for ( j = 0; j < 4 ; j++ )
    {
        trucks[ trucks.size ] = spawntruck( path, path.angles, goleft );
        wait 1.333;
    }
    
    for ( j = 0; j < trucks.size ; j++ )
    {
        trucks[ j ] vehicle_setspeedimmediate( 15, 30, 30 );
    }
    
    wait 12;
    
    for ( j = 0; j < trucks.size ; j++ )
    {
        trucks[ j ] vehicle_setspeedimmediate( 25, 30, 30 );
    }
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 3
// Checksum 0x0, Offset: 0xca5
// Size: 0xc2
function spawntruck( path, spawnori, left )
{
    vehicle = spawnvehicle( "veh8_mil_lnd_umike", "umike", "umike", path.origin, spawnori );
    vehicle.animname = "umikeVeh";
    vehicle vehicle_setspeedimmediate( 25, 30, 30 );
    vehicle thread vehiclefollowpath( path );
    vehicle setscriptablepartstate( "dustFX", "normal" );
    vehicle setscriptablepartstate( "exhaustFX", "active" );
    level.br_convoytrucks[ level.br_convoytrucks.size ] = vehicle;
    vehicle.playerslots = [];
    vehicle.br_leftspawn = left;
    return vehicle;
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0xd70
// Size: 0x13b
function vehiclefollowpath( path_node )
{
    self endon( "death" );
    self endon( "stop_follow_path" );
    self startpath( path_node );
    self playloopsound( "iw8_mp_snatch_convoy_lp" );
    
    for ( next_node = getvehiclenode( path_node.target, "targetname" ); isdefined( next_node ) ; next_node = getvehiclenode( next_node.target, "targetname" ) )
    {
        next_node waittill( "trigger" );
        
        if ( !isdefined( next_node.target ) )
        {
            break;
        }
    }
    
    self vehicle_setspeed( 0, 30, 30 );
    
    for ( vel = self vehicle_getspeed(); vel > 1 ; vel = self vehicle_getspeed() )
    {
        wait 0.1;
    }
    
    self stoploopsound( "iw8_mp_snatch_convoy_lp" );
    self stoploopsound( "veh_technical_temp_surface" );
    level notify( "infil_locked" );
    thread kickanyremainingplayers();
    wait 3;
    staticmodel = spawn( "script_model", self.origin );
    staticmodel setmodel( "veh8_mil_lnd_umike_static_allied" );
    staticmodel.angles = self.angles;
    scripts\mp\objidpoolmanager::returnobjectiveid( self.objid );
    self delete();
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 0
// Checksum 0x0, Offset: 0xeb3
// Size: 0x167
function spawnplayertoconvoy()
{
    if ( isalive( self ) )
    {
        if ( !isdefined( self.didnotselectclassintime ) )
        {
            if ( !scripts\mp\gametypes\br_public::isplayerbrsquadleader() )
            {
                return;
            }
        }
        
        if ( level.teambased )
        {
            playerteam = getteamdata( self.team, "players" );
        }
        else
        {
            playerteam = [ self ];
        }
        
        foreach ( player in playerteam )
        {
            player notify( "cancel_c130" );
            player notify( "cancel_heli" );
            player unlink();
            
            if ( !isdefined( player.br_truck ) )
            {
                player.br_truck = getnexttruckwithroom( player.team );
                player.br_truck.playerslots[ player.br_truck.playerslots.size ] = player;
            }
            
            truck = player.br_truck;
            player.angles = truck.angles;
            
            if ( !isdefined( truck.showonminimap ) )
            {
                truck showicon();
                truck.showonminimap = 1;
            }
            
            player thread jumplistener( truck );
        }
    }
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0x1022
// Size: 0x50
function jumplistener( truck )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "cancel_convoy" );
    self endon( "br_jump" );
    self.br_infil_type = "convoy";
    thread orbitcam( truck );
    thread listenjump( truck );
    thread listenkick( truck );
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 0
// Checksum 0x0, Offset: 0x107a
// Size: 0x98
function kickanyremainingplayers()
{
    foreach ( p in self.playerslots )
    {
        if ( isdefined( p ) && isdefined( p.br_infil_type ) && p.br_infil_type == "convoy" )
        {
            p cameradefault();
            p unlink();
            p thread jumpout( self );
            p notify( "br_jump" );
        }
    }
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0x111a
// Size: 0x3f
function listenkick( truck )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "cancel_c130" );
    self endon( "cancel_heli" );
    self endon( "br_jump" );
    self waittill( "halo_kick_c130" );
    truck thread kickanyremainingplayers();
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0x1161
// Size: 0xfb
function listenjump( truck )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "cancel_convoy" );
    self endon( "br_jump" );
    
    while ( true )
    {
        self waittill( "halo_jump_c130" );
        
        if ( !scripts\mp\gametypes\br_public::isplayerbrsquadleader() )
        {
            continue;
        }
        
        if ( scripts\mp\gametypes\br_c130::ispointinbounds( truck.origin ) )
        {
            if ( scripts\mp\gametypes\br_public::isplayerbrsquadleader() )
            {
                teammates = getteamdata( self.team, "players" );
                
                foreach ( p in teammates )
                {
                    if ( p != self )
                    {
                        p notify( "halo_kick_c130" );
                    }
                }
                
                break;
            }
        }
        else
        {
            self iprintlnbold( &"MP_BR_INGAME/NOT_PLAYABLE" );
        }
        
        waitframe();
    }
    
    self cameradefault();
    thread jumpout( truck );
    self notify( "br_jump" );
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0x1264
// Size: 0x272
function jumpout( truck )
{
    self setclientomnvar( "ui_br_infiled", 1 );
    println( "<dev string:xb4>" );
    self.br_infil_type = undefined;
    lookangles = self getplayerangles();
    self unlink();
    
    if ( istrue( truck.br_leftspawn ) )
    {
        offset = anglestoleft( truck.angles ) * 180;
    }
    else
    {
        offset = anglestoright( truck.angles ) * 180;
    }
    
    fwd = anglestoforward( truck.angles );
    
    if ( !isdefined( truck.offloaded ) )
    {
        truck.offloaded = 0;
    }
    else
    {
        truck.offloaded++;
    }
    
    if ( truck.offloaded == 0 )
    {
        offset += fwd * 36;
    }
    else if ( truck.offloaded == 1 )
    {
        offset -= fwd * 36;
    }
    else if ( truck.offloaded == 2 )
    {
        offset += fwd * 72;
    }
    else
    {
        offset -= fwd * 72;
    }
    
    var_f9805aad354a150e = truck.origin + offset + ( 0, 0, 18000 );
    contents = physics_createcontents( [ "physicscontents_glass", "physicscontents_water", "physicscontents_playerclip", "physicscontents_vehicleclip" ] );
    castresults = physics_raycast( var_f9805aad354a150e, var_f9805aad354a150e + ( 0, 0, -1 ) * 20000, contents, undefined, 0, "physicsquery_closest", 1 );
    
    if ( isdefined( castresults ) && castresults.size > 0 )
    {
        castend = castresults[ 0 ][ "position" ];
        self setorigin( castend, 1, 1 );
    }
    else
    {
        self setorigin( truck.origin + offset, 1, 1 );
    }
    
    waitframe();
    var_81ef0ebaf8a76116 = game[ "music" ][ "snatch_spawn" ].size;
    level.cur_infil_track = randomint( var_81ef0ebaf8a76116 );
    self setplayermusicstate( game[ "music" ][ "snatch_spawn" ][ level.cur_infil_track ] );
    function_6fb380927695ee76();
    function_985b0973f29da4f8( "br_convoy::jumpOut()" );
    self setplayerangles( lookangles );
    self notify( "fallDone" );
    scripts\cp_mp\parachute::parachutecompletedefault();
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0x14de
// Size: 0x58
function orbitcam( truck )
{
    self.angles = truck.angles;
    self playerlinkto( truck, "tag_origin" );
    function_a593971d75d82113();
    function_379bb555405c16bb( "br_convoy::orbitCam()" );
    _visionsetnaked( "", 0 );
    self cameraset( "camera_custom_orbit_1" );
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 0
// Checksum 0x0, Offset: 0x153e
// Size: 0x68, Type: bool
function aretrucksvalid()
{
    foreach ( truck in level.br_convoytrucks )
    {
        if ( !isdefined( truck ) || !isdefined( truck.playerslots ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0x15af
// Size: 0x15f
function getnexttruckwithroom( team )
{
    if ( level.teambased )
    {
        foreach ( truck in level.br_convoytrucks )
        {
            if ( isdefined( truck.spawnteam ) && truck.spawnteam == team && !istruckfull( truck ) )
            {
                return truck;
            }
        }
        
        foreach ( truck in level.br_convoytrucks )
        {
            if ( !isdefined( truck.spawnteam ) )
            {
                truck.spawnteam = team;
                return truck;
            }
        }
    }
    else
    {
        var_eb444d46acfe7514 = array_sort_with_func( level.br_convoytrucks, &sorttrucksize );
        
        foreach ( truck in var_eb444d46acfe7514 )
        {
            if ( !istruckfull( truck ) )
            {
                return truck;
            }
        }
    }
    
    return undefined;
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 1
// Checksum 0x0, Offset: 0x1717
// Size: 0x1a, Type: bool
function istruckfull( truck )
{
    return truck.playerslots.size == 8;
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 2
// Checksum 0x0, Offset: 0x173a
// Size: 0x2c, Type: bool
function sorttrucksize( a, b )
{
    return a.playerslots.size < b.playerslots.size;
}

// Namespace br_convoy / scripts\mp\gametypes\br_convoy
// Params 0
// Checksum 0x0, Offset: 0x176f
// Size: 0x84
function showicon()
{
    curobjid = scripts\mp\objidpoolmanager::requestobjectiveid( 10 );
    
    if ( curobjid == -1 )
    {
        return -1;
    }
    
    scripts\mp\objidpoolmanager::objective_add_objective( curobjid, "invisible", ( 0, 0, 0 ) );
    scripts\mp\objidpoolmanager::update_objective_onentitywithrotation( curobjid, self );
    scripts\mp\objidpoolmanager::update_objective_state( curobjid, "active" );
    iconshader = "icon_minimap_bradley";
    scripts\mp\objidpoolmanager::update_objective_icon( curobjid, iconshader );
    scripts\mp\objidpoolmanager::update_objective_setbackground( curobjid, 1 );
    scripts\mp\objidpoolmanager::objective_playermask_showtoall( curobjid );
    self.objid = curobjid;
}

