#using scripts\common\vehicle;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;

#namespace battle_tracks;

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 0
// Checksum 0x0, Offset: 0x2fc
// Size: 0x1ca
function function_620aa345ac2f9963()
{
    if ( level.gametype == "dungeons" )
    {
        return;
    }
    
    projectbundle = getprojectscriptbundle();
    
    if ( isdefined( projectbundle ) )
    {
        vehicletracklistname = hashcat( %"hash_5c338ed91460dbe1", projectbundle.vehicletracklist );
    }
    else
    {
        assertmsg( "<dev string:x1c>" );
        return;
    }
    
    level.vehicletracklist = getscriptbundle( vehicletracklistname ).vehicletracklist;
    
    if ( !isdefined( level.vehicletracklist ) )
    {
        assertmsg( "<dev string:x58>" );
        return;
    }
    
    foreach ( index, trackinfo in level.vehicletracklist )
    {
        if ( index <= 1 )
        {
            continue;
        }
        
        if ( !isdefined( trackinfo.vehicletrack ) )
        {
            continue;
        }
        
        trackname = hashcat( %"hash_8f87dca26d14f0d", trackinfo.vehicletrack );
        var_2450b73ccbdae7d = getscriptbundlefieldvalues( trackname, [ #"ingamesfxalias", #"ingamemusicstate" ] );
        trackinfo.ingamesfxalias = var_2450b73ccbdae7d.ingamesfxalias;
        trackinfo.ingamemusicstate = var_2450b73ccbdae7d.ingamemusicstate;
        
        if ( !isdefined( trackinfo.ingamesfxalias ) )
        {
            assertmsg( "<dev string:x7c>" + trackinfo.vehicletrack );
        }
        
        if ( !isdefined( trackinfo.ingamemusicstate ) )
        {
            assertmsg( "<dev string:xa2>" + trackinfo.vehicletrack );
        }
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x4ce
// Size: 0x5f
function battle_tracks_onentervehicle( vehicle, player )
{
    if ( level.gametype == "dungeons" )
    {
        return;
    }
    
    if ( function_c3d244ceadc23533( player ) )
    {
        function_7718d2895fdba333( player );
        
        if ( !function_4c953e9e77258030( vehicle, player ) )
        {
            battle_tracks_stopbattletrackswhenstandingonvehicle( player );
        }
    }
    
    if ( battle_tracks_shouldstartbattletracks( vehicle ) )
    {
        battle_tracks_playbattletrackstoplayer( vehicle, player, 0 );
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 4
// Checksum 0x0, Offset: 0x535
// Size: 0xae
function battle_tracks_vehicleoccupancyenter( vehicle, player, seatid, oldseatid )
{
    if ( level.gametype == "dungeons" )
    {
        return;
    }
    
    isdriverseat = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat( vehicle, seatid );
    isbattletracksowner = battle_tracks_isbattletracksowner( vehicle, player );
    battle_tracks_trystopdrivertogglethink( vehicle, player, oldseatid );
    battle_tracks_hidetogglewidget( player );
    
    if ( isdriverseat )
    {
        if ( !isbattletracksowner )
        {
            battle_tracks_stopbattletrackstoalloccupants( vehicle );
            battle_tracks_updatebattletracks( vehicle, player );
        }
        
        if ( battle_tracks_shouldstartbattletracks( vehicle ) )
        {
            battle_tracks_playbattletrackstoalloccupants( vehicle );
        }
        
        if ( !battle_tracks_hasemptybattletracks( vehicle ) )
        {
            player thread battle_tracks_togglethink( player, vehicle );
        }
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 3
// Checksum 0x0, Offset: 0x5eb
// Size: 0x7c
function battle_tracks_onexitvehicle( vehicle, player, seatid )
{
    if ( level.gametype == "dungeons" )
    {
        return;
    }
    
    battle_tracks_stopbattletracksforplayer( vehicle.battletracksmusicstate, player, 0 );
    battle_tracks_trystopdrivertogglethink( vehicle, player, seatid );
    battle_tracks_hidetogglewidget( player );
    isbattletracksowner = battle_tracks_isbattletracksowner( vehicle, player );
    
    if ( isbattletracksowner )
    {
        battle_tracks_stopbattletrackstoalloccupants( vehicle );
        battle_tracks_clearbattletracks( vehicle );
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x66f
// Size: 0x42
function battle_tracks_monitorstandingonvehicles( player )
{
    if ( level.gametype == "dungeons" )
    {
        return;
    }
    
    level endon( "game_ended" );
    player endon( "disconnect" );
    
    while ( true )
    {
        battle_tracks_tryplayingbattletrackswhenstandingonvehicle( player );
        wait 0.5;
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x6b9
// Size: 0xa1
function battle_tracks_updatebattletracks( vehicle, player )
{
    vehicle.battletracks = [];
    vehicle.battletracksowner = player;
    vehicle.battletracksmusicstate = "";
    
    if ( battle_tracks_playerselectrandomtracks( vehicle, player ) )
    {
        battle_tracks_updatebattletracksfromplayerdata( vehicle, player, 1, 9 );
    }
    else
    {
        battle_tracks_updatebattletracksfromplayerdata( vehicle, player, 0, 9 );
    }
    
    /#
        if ( function_561f62b5ed736105() )
        {
            vehicle.battletracks = function_ea5ef1563045fe8c( vehicle );
        }
    #/
    
    vehicle.battletracks = scripts\engine\utility::array_randomize( vehicle.battletracks );
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 4
// Checksum 0x0, Offset: 0x762
// Size: 0x11c
function battle_tracks_updatebattletracksfromplayerdata( vehicle, player, startindex, endindex )
{
    data = scripts\cp_mp\vehicles\vehicle::function_86f6f784630b11fb( vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd() );
    
    for ( arrayindex = startindex; arrayindex <= endindex ; arrayindex++ )
    {
        trackindex = battle_tracks_gettrackindex( vehicle, player, arrayindex, data );
        
        /#
            if ( getdvarint( @"hash_aa9c7230c056a9f8", 0 ) > 0 )
            {
                trackindex = getdvarint( @"hash_aa9c7230c056a9f8" );
            }
        #/
        
        if ( isdefined( trackindex ) && trackindex > 1 )
        {
            if ( getdvarint( @"hash_157cdff8f5182e88", 0 ) == 0 )
            {
                sfxalias = battle_tracks_getsfxalias( trackindex );
                
                if ( isdefined( sfxalias ) && sfxalias != "" )
                {
                    vehicle.battletracks = scripts\engine\utility::array_add( vehicle.battletracks, sfxalias );
                    battle_tracks_setmusicstate( vehicle, trackindex );
                }
                
                continue;
            }
            
            vehicle.battletracks = scripts\engine\utility::array_add( vehicle.battletracks, trackindex );
        }
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x886
// Size: 0x65
function battle_tracks_setmusicstate( vehicle, trackindex )
{
    musicstate = battle_tracks_getmusicstate( trackindex );
    
    if ( vehicle.battletracksmusicstate == "" )
    {
        vehicle.battletracksmusicstate = musicstate;
        return;
    }
    
    assertex( vehicle.battletracksmusicstate == musicstate, "<dev string:xca>" );
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x8f3
// Size: 0x4a, Type: bool
function battle_tracks_playerselectrandomtracks( vehicle, player )
{
    data = scripts\cp_mp\vehicles\vehicle::function_86f6f784630b11fb( vehicle scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd() );
    firsttrackindex = battle_tracks_gettrackindex( vehicle, player, 0, data );
    return isdefined( firsttrackindex ) && firsttrackindex == 1;
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 4
// Checksum 0x0, Offset: 0x946
// Size: 0x99
function battle_tracks_gettrackindex( vehicle, player, arrayindex, data )
{
    /#
        debugindex = getdvarint( @"hash_97029a354c4876c0", 0 );
        
        if ( debugindex != 0 )
        {
            return debugindex;
        }
    #/
    
    if ( isdefined( data ) && isdefined( data.ref ) )
    {
        trackindex = player getplayerdata( level.loadoutsgroup, "customizationSetup", "vehicleCustomization", data.ref, "tracks", arrayindex );
        return trackindex;
    }
    
    return undefined;
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x9e7
// Size: 0x3e
function battle_tracks_getsfxalias( trackindex )
{
    if ( isdefined( level.vehicletracklist ) && isdefined( level.vehicletracklist[ trackindex ] ) )
    {
        return level.vehicletracklist[ trackindex ].ingamesfxalias;
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0xa2d
// Size: 0x3e
function battle_tracks_getmusicstate( trackindex )
{
    if ( isdefined( level.vehicletracklist ) && isdefined( level.vehicletracklist[ trackindex ] ) )
    {
        return level.vehicletracklist[ trackindex ].ingamemusicstate;
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0xa73
// Size: 0xb8
function battle_tracks_playbattletrackstoalloccupants( vehicle )
{
    if ( getdvarint( @"hash_157cdff8f5182e88", 0 ) == 0 )
    {
        all_occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( vehicle, 1 );
        
        if ( isdefined( vehicle.turretoccupants ) )
        {
            all_occupants = array_combine_unique( all_occupants, vehicle.turretoccupants );
        }
        
        foreach ( occupant in all_occupants )
        {
            battle_tracks_playbattletrackstoplayer( vehicle, occupant, 0 );
        }
        
        return;
    }
    
    vehicle setvehiclewartracksstate( vehicle.battletracks );
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0xb33
// Size: 0xb7
function battle_tracks_stopbattletrackstoalloccupants( vehicle )
{
    if ( getdvarint( @"hash_157cdff8f5182e88", 0 ) == 0 )
    {
        all_occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( vehicle, 1 );
        
        if ( isdefined( vehicle.turretoccupants ) )
        {
            all_occupants = array_combine_unique( all_occupants, vehicle.turretoccupants );
        }
        
        foreach ( occupant in all_occupants )
        {
            battle_tracks_stopbattletracksforplayer( vehicle.battletracksmusicstate, occupant, 0 );
        }
        
        return;
    }
    
    vehicle stopvehiclewartracks();
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 3
// Checksum 0x0, Offset: 0xbf2
// Size: 0x119
function battle_tracks_playbattletrackstoplayer( vehicle, player, var_29172b8e5d02be98 )
{
    if ( getdvarint( @"hash_157cdff8f5182e88", 0 ) != 0 )
    {
        return;
    }
    
    isbattletracksowner = battle_tracks_isbattletracksowner( vehicle, player );
    
    if ( isdefined( vehicle.battletracksmusicstate ) && isdefined( vehicle.battletracks ) && isdefined( player ) )
    {
        if ( isdefined( vehicle.battletracksowner ) && ( isbattletracksowner || var_29172b8e5d02be98 || player getwartrackpassengerenabled() ) )
        {
            vehiclebattletracksid = battle_tracks_getbattletracksid( vehicle );
            
            if ( !function_59720efc5c367af2( vehicle, player, vehiclebattletracksid ) )
            {
                /#
                    function_3971973c87f8c8d( vehicle, player );
                #/
                
                player.battletracksmusicstate = vehicle.battletracksmusicstate;
                player.battletracksid = vehiclebattletracksid;
                player setplayermusicstate( vehicle.battletracksmusicstate, vehicle.battletracks, vehicle, ( 0, 0, 0 ) );
            }
        }
        
        if ( !isbattletracksowner && !var_29172b8e5d02be98 )
        {
            player thread function_d9a28875c82616d0( player, vehicle );
        }
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 3
// Checksum 0x0, Offset: 0xd13
// Size: 0x65, Type: bool
function function_59720efc5c367af2( vehicle, player, vehiclebattletracksid )
{
    if ( !isdefined( player.battletracksmusicstate ) )
    {
        return false;
    }
    
    if ( !isdefined( player.battletracksid ) )
    {
        return false;
    }
    
    return player.battletracksmusicstate == vehicle.battletracksmusicstate && player.battletracksid == vehiclebattletracksid;
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 3
// Checksum 0x0, Offset: 0xd81
// Size: 0x7b
function battle_tracks_stopbattletracksforplayer( battletracksmusicstate, player, var_29172b8e5d02be98 )
{
    if ( getdvarint( @"hash_157cdff8f5182e88", 0 ) != 0 )
    {
        return;
    }
    
    if ( function_c3d244ceadc23533( player ) )
    {
        if ( isdefined( battletracksmusicstate ) && isdefined( player ) )
        {
            /#
                function_be79f42e9d2ddc27( battletracksmusicstate, player );
            #/
            
            player.battletracksmusicstate = undefined;
            player.battletracksid = undefined;
            player stopplayermusicstate( battletracksmusicstate );
            
            if ( !var_29172b8e5d02be98 )
            {
                player notify( "stop_battle_tracks_option_watch" );
            }
        }
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0xe04
// Size: 0x27, Type: bool
function function_c3d244ceadc23533( player )
{
    return isdefined( player.battletracksmusicstate ) && isdefined( player.battletracksid );
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0xe34
// Size: 0x30, Type: bool
function battle_tracks_isbattletracksowner( vehicle, player )
{
    return isdefined( vehicle.battletracksowner ) && vehicle.battletracksowner == player;
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0xe6d
// Size: 0x2c
function battle_tracks_clearbattletracks( vehicle )
{
    vehicle.battletracksowner = undefined;
    vehicle.battletracks = undefined;
    vehicle.battletracksmusicstate = undefined;
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0xea1
// Size: 0x32, Type: bool
function battle_tracks_hasemptybattletracks( vehicle )
{
    if ( !isdefined( vehicle.battletracks ) )
    {
        return true;
    }
    
    if ( vehicle.battletracks.size == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0xedc
// Size: 0x181
function battle_tracks_togglethink( player, vehicle )
{
    player notify( "stop_battle_tracks_toggle_think" );
    player endon( "stop_battle_tracks_toggle_think" );
    player endon( "death_or_disconnect" );
    player endon( "last_stand_start" );
    battle_tracks_tryinittogglestate( player );
    currenttogglestate = battle_tracks_gettogglestate( player );
    battle_tracks_updatetogglestate( player, vehicle, currenttogglestate );
    requirehold = player is_player_gamepad_enabled();
    
    if ( requirehold )
    {
        if ( vehicle scripts\common\vehicle::ishelicopter() )
        {
            player notifyonplayercommand( "update_battle_tracks_toggle_state", "+melee_zoom" );
            player notifyonplayercommand( "cancel_battle_tracks_toggle_state", "-melee_zoom" );
            player.battletracktogglebutton = "melee_zoom";
        }
        else
        {
            player notifyonplayercommand( "update_battle_tracks_toggle_state", "+frag" );
            player notifyonplayercommand( "cancel_battle_tracks_toggle_state", "-frag" );
            player.battletracktogglebutton = "frag";
        }
    }
    else
    {
        player notifyonplayercommand( "update_battle_tracks_toggle_state", "nightvision" );
        player.battletracktogglebutton = "nightvision";
    }
    
    while ( true )
    {
        player setclientomnvar( "ui_veh_music_toggle_button_holdtime", 0 );
        player waittill( "update_battle_tracks_toggle_state" );
        newtogglestate = battle_tracks_getnewtogglestate( player );
        
        if ( requirehold )
        {
            player childthread function_338b77c14712dbb3();
            result = player waittill_notify_or_timeout_return( "cancel_battle_tracks_toggle_state", 0.25 );
            
            if ( result == "timeout" )
            {
                player notify( "cancel_battle_tracks_toggle_state" );
                battle_tracks_updatetogglestate( player, vehicle, newtogglestate );
            }
            
            continue;
        }
        
        battle_tracks_updatetogglestate( player, vehicle, newtogglestate );
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 0
// Checksum 0x0, Offset: 0x1065
// Size: 0x49
function function_338b77c14712dbb3()
{
    self endon( "cancel_battle_tracks_toggle_state" );
    progress = 0;
    
    while ( true )
    {
        progress += level.framedurationseconds;
        self setclientomnvar( "ui_veh_music_toggle_button_holdtime", min( 1, progress / 0.25 ) );
        waitframe();
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 3
// Checksum 0x0, Offset: 0x10b6
// Size: 0x54
function battle_tracks_updatetogglestate( player, vehicle, togglestate )
{
    switch ( togglestate )
    {
        case #"hash_fa2ad6f6bd651030":
            battle_tracks_toggleonstate( player, vehicle );
            break;
        case #"hash_3699ac6c262c25ea":
            battle_tracks_toggleoffstate( player, vehicle );
            break;
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x1112
// Size: 0x28
function battle_tracks_toggleonstate( player, vehicle )
{
    battle_tracks_settogglestate( player, "on" );
    battle_tracks_playbattletrackstoalloccupants( vehicle );
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x1142
// Size: 0x28
function battle_tracks_toggleoffstate( player, vehicle )
{
    battle_tracks_settogglestate( player, "off" );
    battle_tracks_stopbattletrackstoalloccupants( vehicle );
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x1172
// Size: 0x48
function battle_tracks_getnewtogglestate( player )
{
    switch ( player.pers[ "battleTracksToggleState" ] )
    {
        case #"hash_fa2ad6f6bd651030":
            return "off";
        case #"hash_3699ac6c262c25ea":
            return "on";
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x11c2
// Size: 0x2d
function battle_tracks_tryinittogglestate( player )
{
    if ( !isdefined( player.pers[ "battleTracksToggleState" ] ) )
    {
        battle_tracks_settogglestate( player, "on" );
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x11f7
// Size: 0x98
function battle_tracks_settogglestate( player, value )
{
    player.pers[ "battleTracksToggleState" ] = value;
    var_587830fd4042be45 = player getclientomnvar( "ui_veh_battle_tracks_toggle_state" );
    
    switch ( value )
    {
        case #"hash_fa2ad6f6bd651030":
            player setclientomnvar( "ui_veh_battle_tracks_toggle_state", 1 );
            
            /#
                function_55f68a20f93c4f9a( player, var_587830fd4042be45 );
            #/
            
            break;
        case #"hash_3699ac6c262c25ea":
            player setclientomnvar( "ui_veh_battle_tracks_toggle_state", 2 );
            
            /#
                function_495e92841f7d35ec( player, var_587830fd4042be45 );
            #/
            
            break;
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x1297
// Size: 0x40
function battle_tracks_hidetogglewidget( player )
{
    if ( isdefined( player ) )
    {
        var_587830fd4042be45 = player getclientomnvar( "ui_veh_battle_tracks_toggle_state" );
        player setclientomnvar( "ui_veh_battle_tracks_toggle_state", 0 );
        
        /#
            function_d852952d0fba338f( player, var_587830fd4042be45 );
        #/
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x12df
// Size: 0x3f
function battle_tracks_gettogglestate( player )
{
    assertex( isdefined( player.pers[ "<dev string:xfe>" ] ), "<dev string:x119>" );
    return player.pers[ "battleTracksToggleState" ];
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x1327
// Size: 0x3c, Type: bool
function battle_tracks_togglestateis( player, value )
{
    return isdefined( player.pers[ "battleTracksToggleState" ] ) && player.pers[ "battleTracksToggleState" ] == value;
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 3
// Checksum 0x0, Offset: 0x136c
// Size: 0x42
function battle_tracks_trystopdrivertogglethink( vehicle, player, seatid )
{
    isdriverseat = isdefined( seatid ) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isdriverseat( vehicle, seatid );
    
    if ( isdriverseat )
    {
        player battle_tracks_stoptogglethink( player );
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x13b6
// Size: 0xc8
function battle_tracks_stoptogglethink( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player notify( "stop_battle_tracks_toggle_think" );
    
    if ( isdefined( player.battletracktogglebutton ) )
    {
        switch ( player.battletracktogglebutton )
        {
            case #"hash_10931e593d5bdf":
                player notifyonplayercommandremove( "update_battle_tracks_toggle_state", "+melee_zoom" );
                player notifyonplayercommandremove( "cancel_battle_tracks_toggle_state", "-melee_zoom" );
                break;
            case #"hash_a8e4a914fb03a4d5":
                player notifyonplayercommandremove( "update_battle_tracks_toggle_state", "+frag" );
                player notifyonplayercommandremove( "cancel_battle_tracks_toggle_state", "-frag" );
                break;
            case #"hash_b4b26057ca84210d":
                player notifyonplayercommandremove( "update_battle_tracks_toggle_state", "nightvision" );
                break;
        }
        
        player.battletracktogglebutton = undefined;
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x1486
// Size: 0x44, Type: bool
function battle_tracks_shouldstartbattletracks( vehicle )
{
    if ( battle_tracks_hasemptybattletracks( vehicle ) )
    {
        return false;
    }
    
    if ( isdefined( vehicle.battletracksowner ) && battle_tracks_togglestateis( vehicle.battletracksowner, "off" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x14d3
// Size: 0x4f
function battle_tracks_tryplayingbattletrackswhenstandingonvehicle( player )
{
    vehicle = player getmovingplatformparent();
    
    if ( battle_tracks_shouldplaybattletrackswhenstandingonvehicle( vehicle, player ) )
    {
        player thread battle_tracks_standingonvehicletimeout( vehicle, player );
        
        if ( !battle_tracks_standingonsamevehiclewithsametracksowner( vehicle, player ) )
        {
            battle_tracks_stopbattletrackswhenstandingonvehicle( player );
            battle_tracks_playbattletrackswhenstandingonvehicle( vehicle, player );
        }
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x152a
// Size: 0x1d
function battle_tracks_playbattletrackswhenstandingonvehicle( vehicle, player )
{
    battle_tracks_playbattletrackstoplayer( vehicle, player, 0 );
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x154f
// Size: 0x25
function battle_tracks_stopbattletrackswhenstandingonvehicle( player )
{
    if ( function_c3d244ceadc23533( player ) )
    {
        function_7718d2895fdba333( player );
        battle_tracks_stopbattletracksfromstandingonvehicle( player );
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x157c
// Size: 0x13
function function_7718d2895fdba333( player )
{
    player notify( "battle_tracks_standingOnVehicleTimeout" );
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x1597
// Size: 0x3b
function battle_tracks_standingonvehicletimeout( vehicle, player )
{
    level endon( "game_ended" );
    player endon( "disconnect" );
    player notify( "battle_tracks_standingOnVehicleTimeout" );
    player endon( "battle_tracks_standingOnVehicleTimeout" );
    wait 1;
    battle_tracks_stopbattletracksfromstandingonvehicle( player );
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x15da
// Size: 0x92
function function_d9a28875c82616d0( player, vehicle )
{
    level endon( "game_ended" );
    player endon( "disconnect" );
    player endon( "stop_battle_tracks_option_watch" );
    
    for ( var_5b0fc1b88f867313 = player getwartrackpassengerenabled(); true ; var_5b0fc1b88f867313 = var_4192fc05bb9a1187 )
    {
        wait 0.5;
        var_4192fc05bb9a1187 = player getwartrackpassengerenabled();
        
        if ( var_4192fc05bb9a1187 != var_5b0fc1b88f867313 )
        {
            if ( var_4192fc05bb9a1187 )
            {
                if ( battle_tracks_shouldstartbattletracks( vehicle ) )
                {
                    battle_tracks_playbattletrackstoplayer( vehicle, player, 1 );
                }
                
                continue;
            }
            
            battle_tracks_stopbattletracksforplayer( vehicle.battletracksmusicstate, player, 1 );
        }
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x1674
// Size: 0x1f
function battle_tracks_stopbattletracksfromstandingonvehicle( player )
{
    battle_tracks_stopbattletracksforplayer( player.battletracksmusicstate, player, 0 );
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x169b
// Size: 0x5a, Type: bool
function battle_tracks_shouldplaybattletrackswhenstandingonvehicle( vehicle, player )
{
    if ( !isdefined( vehicle ) )
    {
        return false;
    }
    
    if ( !vehicle scripts\cp_mp\vehicles\vehicle::isvehicle() )
    {
        return false;
    }
    
    if ( !battle_tracks_vehicleallowlisteningoutsideoccupancy( vehicle ) )
    {
        return false;
    }
    
    if ( !scripts\cp_mp\vehicles\vehicle::vehicle_isfriendlytoplayer( vehicle, player ) )
    {
        return false;
    }
    
    if ( !battle_tracks_shouldstartbattletracks( vehicle ) )
    {
        return false;
    }
    
    if ( !battle_tracks_playerinlisteningzone( vehicle, player ) )
    {
        return false;
    }
    
    return true;
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x16fe
// Size: 0x44, Type: bool
function battle_tracks_standingonsamevehiclewithsametracksowner( vehicle, player )
{
    if ( !isdefined( player.battletracksid ) )
    {
        return false;
    }
    
    battletracksid = battle_tracks_getbattletracksid( vehicle );
    return battletracksid == player.battletracksid;
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x174b
// Size: 0x27, Type: bool
function function_4c953e9e77258030( vehicle, player )
{
    if ( battle_tracks_hasemptybattletracks( vehicle ) )
    {
        return false;
    }
    
    return battle_tracks_standingonsamevehiclewithsametracksowner( vehicle, player );
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x177b
// Size: 0x46
function battle_tracks_getbattletracksid( vehicle )
{
    vehicleid = vehicle getentitynumber() + "";
    trackownerid = vehicle.battletracksowner getentitynumber() + "";
    return vehicleid + trackownerid;
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 2
// Checksum 0x0, Offset: 0x17ca
// Size: 0x65
function battle_tracks_playerinlisteningzone( vehicle, player )
{
    switch ( vehicle.targetname )
    {
        case #"hash_6e693d48c24e303b":
        case #"hash_9386dbfe3d8d881c":
            return scripts\cp_mp\utility\train_utility::isplayerinsiderectangularzonebasedonent( player, vehicle, "tag_origin", -85, 0, 77, 185, 125, 40 );
        default:
            return 0;
    }
}

// Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
// Params 1
// Checksum 0x0, Offset: 0x1837
// Size: 0x5b
function battle_tracks_vehicleallowlisteningoutsideoccupancy( vehicle )
{
    if ( isdefined( vehicle.targetname ) )
    {
        switch ( vehicle.targetname )
        {
            case #"hash_6e693d48c24e303b":
            case #"hash_9386dbfe3d8d881c":
                return 1;
            default:
                return 0;
        }
        
        return;
    }
    
    return 0;
}

/#

    // Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
    // Params 0
    // Checksum 0x0, Offset: 0x189a
    // Size: 0x1f, Type: dev
    function function_561f62b5ed736105()
    {
        return getdvar( @"hash_88960e36a4bc7a7d", "<dev string:x150>" ) != "<dev string:x150>";
    }

    // Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
    // Params 1
    // Checksum 0x0, Offset: 0x18c1
    // Size: 0xbe, Type: dev
    function function_ea5ef1563045fe8c( vehicle )
    {
        vehicle.battletracksmusicstate = "<dev string:x154>";
        result = [];
        debugwartracks = getdvar( @"hash_88960e36a4bc7a7d", "<dev string:x150>" );
        var_5587c2774459b359 = strtok( debugwartracks, "<dev string:x161>" );
        
        foreach ( var_ab66d57be4626030 in var_5587c2774459b359 )
        {
            var_d60db1b8fa4a20ce = int( var_ab66d57be4626030 );
            result = scripts\engine\utility::array_add( result, var_d60db1b8fa4a20ce );
        }
        
        return result;
    }

    // Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
    // Params 2
    // Checksum 0x0, Offset: 0x1987
    // Size: 0xcb, Type: dev
    function function_3971973c87f8c8d( vehicle, player )
    {
        if ( !function_f15328434523e979() )
        {
            return;
        }
        
        println( "<dev string:x166>" );
        println( "<dev string:x18c>" + gettime() );
        println( "<dev string:x19d>" + player getentitynumber() );
        println( "<dev string:x1b7>" + vehicle.battletracksmusicstate );
        
        foreach ( battletrack in vehicle.battletracks )
        {
            println( "<dev string:x1c8>" + battletrack );
        }
        
        println( "<dev string:x1d3>" );
    }

    // Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
    // Params 2
    // Checksum 0x0, Offset: 0x1a5a
    // Size: 0x66, Type: dev
    function function_be79f42e9d2ddc27( battletracksmusicstate, player )
    {
        if ( !function_f15328434523e979() )
        {
            return;
        }
        
        println( "<dev string:x1f9>" );
        println( "<dev string:x18c>" + gettime() );
        println( "<dev string:x19d>" + player getentitynumber() );
        println( "<dev string:x1b7>" + battletracksmusicstate );
        println( "<dev string:x1d3>" );
    }

    // Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
    // Params 2
    // Checksum 0x0, Offset: 0x1ac8
    // Size: 0x88, Type: dev
    function function_55f68a20f93c4f9a( player, var_587830fd4042be45 )
    {
        if ( !function_f15328434523e979() )
        {
            return;
        }
        
        println( "<dev string:x21f>" );
        println( "<dev string:x18c>" + gettime() );
        println( "<dev string:x19d>" + player getentitynumber() );
        println( "<dev string:x24a>" );
        println( "<dev string:x278>" + var_587830fd4042be45 );
        println( "<dev string:x28a>" + player getclientomnvar( "<dev string:x297>" ) );
        println( "<dev string:x2bc>" );
    }

    // Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
    // Params 2
    // Checksum 0x0, Offset: 0x1b58
    // Size: 0x88, Type: dev
    function function_495e92841f7d35ec( player, var_587830fd4042be45 )
    {
        if ( !function_f15328434523e979() )
        {
            return;
        }
        
        println( "<dev string:x2e7>" );
        println( "<dev string:x18c>" + gettime() );
        println( "<dev string:x19d>" + player getentitynumber() );
        println( "<dev string:x24a>" );
        println( "<dev string:x278>" + var_587830fd4042be45 );
        println( "<dev string:x28a>" + player getclientomnvar( "<dev string:x297>" ) );
        println( "<dev string:x313>" );
    }

    // Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
    // Params 2
    // Checksum 0x0, Offset: 0x1be8
    // Size: 0x88, Type: dev
    function function_d852952d0fba338f( player, var_587830fd4042be45 )
    {
        if ( !function_f15328434523e979() )
        {
            return;
        }
        
        println( "<dev string:x33f>" );
        println( "<dev string:x18c>" + gettime() );
        println( "<dev string:x19d>" + player getentitynumber() );
        println( "<dev string:x24a>" );
        println( "<dev string:x278>" + var_587830fd4042be45 );
        println( "<dev string:x28a>" + player getclientomnvar( "<dev string:x297>" ) );
        println( "<dev string:x36d>" );
    }

    // Namespace battle_tracks / scripts\cp_mp\vehicles\customization\battle_tracks
    // Params 0
    // Checksum 0x0, Offset: 0x1c78
    // Size: 0x17, Type: dev
    function function_f15328434523e979()
    {
        return getdvarint( @"hash_79d2fc5a92fbfcd1", 0 ) != 0;
    }

#/
