#using script_5307834cd39b435c;
#using scripts\common\utility;
#using scripts\cp_mp\quickprompt;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\music_and_dialog;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\utility\teams;

#namespace map_to_map;

// Namespace map_to_map / scripts\mp\map_to_map
// Params 0
// Checksum 0x0, Offset: 0x30e
// Size: 0x29a
function function_b0daef016957df38()
{
    if ( getdvarint( @"hash_244dc0b0c771cd3d", 1 ) == 0 )
    {
        return;
    }
    
    wait 3;
    scripts\engine\scriptable::scriptable_addusedcallbackbypart( "map_transition_prompt", &function_7e2e0f563fa9008a );
    level.map2map = spawnstruct();
    level.map2map.warpstructs = [];
    level.map2map.warptimers = [];
    level.map2map.warpcountdown = getdvarint( @"hash_5bb49886b748ab20", 25 );
    var_ca410f77e36eb494 = getdvarint( @"hash_4499b8ecf41e59ce", 2048 );
    level.map2map.var_ca410f77e36eb494 = var_ca410f77e36eb494 * var_ca410f77e36eb494;
    var_3abe37fea6ec6fef = getdvarint( @"hash_5ea0b9183c001e76", 4096 );
    level.map2map.var_3abe37fea6ec6fef = var_3abe37fea6ec6fef * var_3abe37fea6ec6fef;
    function_80e7f41f01ef7496( "biobunker", getdvarint( @"hash_b6445fc691760f92", 136 ) );
    level.map2map.var_87e9c184bcdfd9f5 = getdvarint( @"hash_196cdab33a3f0148", 1 );
    level.map2map.var_e5ee4cca24584650 = [];
    includeme = getdvarint( @"hash_dd30517391ddf811", 1 );
    
    if ( !includeme )
    {
        level.map2map.var_e5ee4cca24584650[ level.map2map.var_e5ee4cca24584650.size ] = "oasis";
    }
    
    includeme = getdvarint( @"hash_ec51bbfc3dc4418f", 1 );
    
    if ( !includeme )
    {
        level.map2map.var_e5ee4cca24584650[ level.map2map.var_e5ee4cca24584650.size ] = "wartorn";
    }
    
    includeme = getdvarint( @"hash_e274c3aea0268188", 1 );
    
    if ( !includeme )
    {
        level.map2map.var_e5ee4cca24584650[ level.map2map.var_e5ee4cca24584650.size ] = "oilfield";
    }
    
    includeme = getdvarint( @"hash_905734eb55454584", 1 );
    
    if ( !includeme )
    {
        level.map2map.var_e5ee4cca24584650[ level.map2map.var_e5ee4cca24584650.size ] = "moderncity";
    }
    
    function_334a8a419bfc02c5( "oasis", 1 );
    function_334a8a419bfc02c5( "wartorn", 2 );
    function_334a8a419bfc02c5( "oilfield", 3 );
    function_334a8a419bfc02c5( "moderncity", 4 );
    function_954713c561c4cc55();
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 0
// Checksum 0x0, Offset: 0x5b0
// Size: 0x11c
function function_954713c561c4cc55()
{
    warpnodes = array_combine( getstructarray( "map2map_usePrompt", "script_noteworthy" ), getstructarray( "map2map_usePrompt_instant", "script_noteworthy" ) );
    
    foreach ( var_1e88d0b4c5322e0e in warpnodes )
    {
        warpstruct = function_88ca4dca7931b39b( var_1e88d0b4c5322e0e );
        
        if ( isdefined( warpstruct ) && !isdefined( level.map2map.warpstructs[ warpstruct.locname ] ) )
        {
            level.map2map.warpstructs[ warpstruct.locname ] = warpstruct;
        }
        
        if ( istrue( level.map2map.var_87e9c184bcdfd9f5 ) && var_1e88d0b4c5322e0e.targetname != "map2map_biobunker_oasis" )
        {
            var_6451879e18908224 = spawnscriptable( "map2map_tacmap_location_scriptable", var_1e88d0b4c5322e0e.origin );
        }
    }
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 1
// Checksum 0x0, Offset: 0x6d4
// Size: 0x198
function function_88ca4dca7931b39b( var_1e88d0b4c5322e0e )
{
    warpstruct = spawnstruct();
    tokens = strtok( var_1e88d0b4c5322e0e.targetname, "_" );
    mapname = tolower( tokens[ 1 ] );
    warpstruct.maptarget = mapname;
    locname = tolower( tokens[ 2 ] );
    warpstruct.locname = locname;
    
    if ( array_contains( level.map2map.var_e5ee4cca24584650, locname ) )
    {
        warpstruct = undefined;
        return;
    }
    
    warpstruct.useprompt = function_7e139d3ab9acb1a9( var_1e88d0b4c5322e0e );
    warpstruct.useprompt.maptarget = warpstruct.maptarget;
    warpstruct.useprompt.spawnlocid = function_5ee910117a53f7e0( locname );
    warpstruct.useprompt.locname = locname;
    
    if ( !istrue( warpstruct.useprompt.instantwarp ) )
    {
        triggers = getnoentvolumearray( var_1e88d0b4c5322e0e.targetname, "targetname" );
        
        if ( isdefined( triggers ) )
        {
            warpstruct.useprompt.trigger = triggers[ 0 ];
        }
        
        warpstruct.useprompt thread function_e43e0f078b1006ce( warpstruct.useprompt.trigger, warpstruct.useprompt.spawnlocid );
    }
    
    return warpstruct;
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 1
// Checksum 0x0, Offset: 0x875
// Size: 0x64
function function_7e139d3ab9acb1a9( var_1e88d0b4c5322e0e )
{
    scriptable = spawnscriptable( "map_transition_prompt", var_1e88d0b4c5322e0e.origin );
    scriptable setscriptablepartstate( "map_transition_prompt", "on" );
    
    if ( issubstr( var_1e88d0b4c5322e0e.script_noteworthy, "_instant" ) )
    {
        scriptable.instantwarp = 1;
    }
    
    return scriptable;
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 6
// Checksum 0x0, Offset: 0x8e2
// Size: 0x14a
function function_7e2e0f563fa9008a( instance, part, state, player, bautouse, usestring )
{
    if ( isdefined( instance.locname ) && instance.locname == "oasis" )
    {
        scripts\mp\pmc_missions::function_b49c89ad7edcf17b( player );
    }
    
    if ( istrue( instance.instantwarp ) )
    {
        playersonteam = scripts\mp\utility\teams::getfriendlyplayers( player.team, 1 );
        function_3209b7c7f08a12da( playersonteam, instance.maptarget, instance.spawnlocid );
        return;
    }
    
    if ( isdefined( level.map2map.warptimers[ player.team ] ) )
    {
        return;
    }
    
    function_dce86bbe8b64b892( player.team, instance );
    
    if ( getdvarint( @"hash_fdf7b751c4c1aa5c", 1 ) == 1 )
    {
        function_db49fa5c1ee8814d( player.team );
    }
    
    instance thread function_5b878641633e68b1( player.team, level.map2map.warpcountdown, instance.maptarget, instance.spawnlocid );
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 1
// Checksum 0x0, Offset: 0xa34
// Size: 0x8c
function function_db49fa5c1ee8814d( team )
{
    if ( !issharedfuncdefined( "teamAssim", "disablePlayer" ) )
    {
        return;
    }
    
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        [[ getsharedfunc( "teamAssim", "disablePlayer" ) ]]( player, "map2map_warp" );
    }
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 1
// Checksum 0x0, Offset: 0xac8
// Size: 0x8c
function function_c6b9237b5132ce26( team )
{
    if ( !issharedfuncdefined( "teamAssim", "enablePlayer" ) )
    {
        return;
    }
    
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        [[ getsharedfunc( "teamAssim", "enablePlayer" ) ]]( player, "map2map_warp" );
    }
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 4
// Checksum 0x0, Offset: 0xb5c
// Size: 0x392
function function_5b878641633e68b1( team, time, maptarget, spawnlocid )
{
    useprompt = self;
    level endon( "game_ended" );
    var_e2297e7e8e96de9f = scripts\mp\utility\teams::getfriendlyplayers( team );
    var_b440527ad8cb0b15 = [];
    
    foreach ( player in var_e2297e7e8e96de9f )
    {
        if ( isdefined( player ) && !player scripts\cp_mp\utility\player_utility::_isalive() )
        {
            var_b440527ad8cb0b15[ var_b440527ad8cb0b15.size ] = player;
        }
    }
    
    trigger = useprompt.trigger;
    
    if ( isdefined( team ) && !isdefined( level.map2map.warptimers[ team ] ) )
    {
        level endon( "map2map_warp_cancel" + team );
        level.map2map.warptimers[ team ] = time;
    }
    else
    {
        return;
    }
    
    while ( level.map2map.warptimers[ team ] >= 0 )
    {
        playersonteam = scripts\mp\utility\teams::getfriendlyplayers( team );
        playersintrigger = function_f1097a7ba31434e4( team, useprompt.trigger );
        
        if ( !isdefined( playersintrigger ) || playersintrigger.size == 0 )
        {
            map2map_cancelwarp( team, useprompt );
        }
        else if ( playersonteam.size == playersintrigger.size )
        {
            if ( level.map2map.warptimers[ team ] > 5 )
            {
                level.map2map.warptimers[ team ] = 5;
            }
        }
        
        foreach ( player in playersonteam )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            useprompt disablescriptableplayeruse( player );
            player setclientomnvar( "ui_dmz_map_to_map_prompt_visible", 0 );
            player setclientomnvar( "ui_dmz_warp_hazard", function_e0947372b9a0f240( spawnlocid ) );
            
            if ( player scripts\cp_mp\utility\player_utility::_isalive() && array_contains( var_b440527ad8cb0b15, player ) )
            {
                var_b440527ad8cb0b15 = array_remove( var_b440527ad8cb0b15, player );
            }
            else if ( !player scripts\cp_mp\utility\player_utility::_isalive() && !array_contains( var_b440527ad8cb0b15, player ) )
            {
                var_b440527ad8cb0b15[ var_b440527ad8cb0b15.size ] = player;
                
                if ( distance2dsquared( player.origin, useprompt.origin ) < level.map2map.var_ca410f77e36eb494 )
                {
                    map2map_cancelwarp( team, useprompt );
                }
            }
            
            if ( array_contains( playersintrigger, player ) )
            {
                player setclientomnvar( "ui_dmz_warp_proximity", 0 );
            }
            else if ( distance2dsquared( player.origin, useprompt.origin ) < level.map2map.var_3abe37fea6ec6fef )
            {
                player setclientomnvar( "ui_dmz_warp_proximity", 1 );
            }
            else
            {
                player setclientomnvar( "ui_dmz_warp_proximity", 2 );
            }
            
            player setclientomnvar( "ui_dmz_warp_timer", level.map2map.warptimers[ team ] );
        }
        
        wait 1;
        level.map2map.warptimers[ team ] -= 1;
    }
    
    function_c03a8f0cf1d4156f( team, useprompt );
    level.map2map.warptimers[ team ] = undefined;
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 2
// Checksum 0x0, Offset: 0xef6
// Size: 0xd0
function map2map_cancelwarp( team, useprompt )
{
    function_f7a553353c2c4f99( team, useprompt );
    playersonteam = scripts\mp\utility\teams::getfriendlyplayers( team );
    
    foreach ( player in playersonteam )
    {
        useprompt enablescriptableplayeruse( player );
        player setclientomnvar( "ui_dmz_map_to_map_prompt_visible", 1 );
        player.var_1f313499d1f87a24 = undefined;
        player scripts\cp_mp\quickprompt::function_24a08f8a03be8244();
        player setplayermusicstate( "" );
        player.warp_music = undefined;
    }
    
    level.map2map.warptimers[ team ] = undefined;
    level notify( "map2map_warp_cancel" + team );
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 1
// Checksum 0x0, Offset: 0xfce
// Size: 0x1a
function function_51aad52cc5171df3( var_f3b6838b04870fc4 )
{
    if ( var_f3b6838b04870fc4 )
    {
        self.var_1f313499d1f87a24 = 1;
    }
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 2
// Checksum 0x0, Offset: 0xff0
// Size: 0x484
function function_c03a8f0cf1d4156f( team, useprompt )
{
    level endon( "map2map_warp_cancel" + team );
    level.map2map.warptimers[ team ] = 30;
    warpconfirmed = 0;
    var_e0a412433514e56a = scripts\mp\utility\teams::getfriendlyplayers( team );
    
    while ( !warpconfirmed )
    {
        playersintrigger = function_f1097a7ba31434e4( team, useprompt.trigger );
        
        if ( playersintrigger.size == 0 || level.map2map.warptimers[ team ] == 0 )
        {
            map2map_cancelwarp( team, useprompt );
        }
        
        foreach ( player in playersintrigger )
        {
            if ( !isdefined( player.warp_music ) )
            {
                player thread scripts\mp\music_and_dialog::function_c080ebbcdcc3176f();
            }
            
            player setclientomnvar( "ui_dmz_warp_state", 3 );
            
            if ( !player scripts\cp_mp\quickprompt::function_74c8eb2aaf9f5d14( 5 ) )
            {
                player thread scripts\cp_mp\quickprompt::function_36edf91561322753( 5, level.map2map.warptimers[ team ], &function_51aad52cc5171df3 );
            }
            
            if ( isdefined( player.var_1f313499d1f87a24 ) )
            {
                warpconfirmed = 1;
            }
        }
        
        foreach ( player in var_e0a412433514e56a )
        {
            if ( array_contains( playersintrigger, player ) )
            {
                player setclientomnvar( "ui_dmz_warp_proximity", 0 );
            }
            else
            {
                if ( player scripts\cp_mp\quickprompt::function_74c8eb2aaf9f5d14( 5 ) )
                {
                    player scripts\cp_mp\quickprompt::function_24a08f8a03be8244();
                }
                
                if ( distance2dsquared( player.origin, useprompt.origin ) < level.map2map.var_3abe37fea6ec6fef )
                {
                    player setclientomnvar( "ui_dmz_warp_proximity", 1 );
                }
                else
                {
                    player setclientomnvar( "ui_dmz_warp_proximity", 2 );
                }
            }
            
            player setclientomnvar( "ui_dmz_warp_timer", level.map2map.warptimers[ team ] );
        }
        
        wait 1;
        var_e0a412433514e56a = scripts\mp\utility\teams::getfriendlyplayers( team );
        level.map2map.warptimers[ team ] -= 1;
        
        if ( level.map2map.warptimers[ team ] < 0 )
        {
            level.map2map.warptimers[ team ] = 0;
        }
    }
    
    var_e0a412433514e56a = scripts\mp\utility\teams::getfriendlyplayers( team );
    playersintrigger = function_f1097a7ba31434e4( team, useprompt.trigger );
    var_7073126d9ed50bf2 = [];
    var_797722ced855104 = [];
    
    foreach ( player in var_e0a412433514e56a )
    {
        intrigger = 0;
        
        if ( array_contains( playersintrigger, player ) )
        {
            intrigger = 1;
        }
        
        if ( player scripts\cp_mp\utility\player_utility::_isalive() && intrigger )
        {
            var_7073126d9ed50bf2[ var_7073126d9ed50bf2.size ] = player;
            continue;
        }
        
        player setplayermusicstate( "" );
        player.warp_music = undefined;
        var_797722ced855104[ var_797722ced855104.size ] = player;
    }
    
    playsoundatpos( useprompt.origin, "dmz_biobunker_radiation_vault_door_open" );
    function_3209b7c7f08a12da( var_7073126d9ed50bf2, useprompt.maptarget, useprompt.spawnlocid );
    
    foreach ( player in var_797722ced855104 )
    {
        player setclientomnvar( "ui_dmz_warp_state", 4 );
    }
    
    wait 5;
    
    if ( getdvarint( @"hash_fdf7b751c4c1aa5c", 1 ) == 1 )
    {
        function_c6b9237b5132ce26( team );
    }
    
    foreach ( player in var_797722ced855104 )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        useprompt enablescriptableplayeruse( player );
        player setclientomnvar( "ui_dmz_map_to_map_prompt_visible", 1 );
        player setclientomnvar( "ui_dmz_warp_state", 5 );
    }
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 2
// Checksum 0x0, Offset: 0x147c
// Size: 0x76
function function_dce86bbe8b64b892( team, instance )
{
    playersonteam = scripts\mp\utility\teams::getfriendlyplayers( team );
    
    foreach ( player in playersonteam )
    {
        player setclientomnvar( "ui_dmz_warp_state", 2 );
    }
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 2
// Checksum 0x0, Offset: 0x14fa
// Size: 0x93
function function_f7a553353c2c4f99( team, instance )
{
    playersonteam = scripts\mp\utility\teams::getfriendlyplayers( team );
    
    foreach ( player in playersonteam )
    {
        player setclientomnvar( "ui_dmz_warp_state", 0 );
    }
    
    if ( getdvarint( @"hash_fdf7b751c4c1aa5c", 1 ) == 1 )
    {
        function_c6b9237b5132ce26( team );
    }
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 3
// Checksum 0x0, Offset: 0x1595
// Size: 0xa5
function function_3209b7c7f08a12da( players, maptarget, spawnlocid )
{
    foreach ( player in players )
    {
        player.var_ded04cdd264a7e00 = 1;
        player.var_1f313499d1f87a24 = undefined;
        player setclientomnvar( "ui_dmz_warp_state", 5 );
        player notify( "map_to_map_warp" );
        player namespace_25b25d188ef778c4::function_df3bfe2c77975120();
    }
    
    function_d296788a307d5162( players, function_2364a3ae41c2ce7f( maptarget ), spawnlocid );
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 2
// Checksum 0x0, Offset: 0x1642
// Size: 0xdf
function function_e43e0f078b1006ce( trigger, spawnlocid )
{
    level endon( "game_ended" );
    
    if ( !scripts\mp\poi::poi_isSystemActive() )
    {
        thread function_8ad822e2a2cefa44( trigger, spawnlocid );
        return;
    }
    
    poiname = poi_findPOIOriginIsIn( trigger.origin );
    
    while ( true )
    {
        if ( isdefined( level.poi[ poiname ] ) && isdefined( level.poi[ poiname ][ "players" ] ) )
        {
            foreach ( player in level.poi[ poiname ][ "players" ] )
            {
                if ( ispointinvolume( player.origin, trigger ) )
                {
                }
            }
        }
        
        waitframe();
    }
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 2
// Checksum 0x0, Offset: 0x1729
// Size: 0x83
function function_8ad822e2a2cefa44( trigger, spawnlocid )
{
    level endon( "game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( ispointinvolume( player.origin, trigger ) )
            {
            }
        }
        
        waitframe();
    }
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 2
// Checksum 0x0, Offset: 0x17b4
// Size: 0x91
function function_f1097a7ba31434e4( team, trigger )
{
    playersonteam = scripts\mp\utility\teams::getfriendlyplayers( team, 1 );
    playersintrigger = [];
    
    foreach ( player in playersonteam )
    {
        if ( ispointinvolume( player.origin, trigger ) )
        {
            playersintrigger[ playersintrigger.size ] = player;
        }
    }
    
    return playersintrigger;
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 2
// Checksum 0x0, Offset: 0x184e
// Size: 0x56
function function_80e7f41f01ef7496( warpkey, playlistid )
{
    if ( !isdefined( level.map2map.var_b700a350075400c3 ) )
    {
        level.map2map.var_b700a350075400c3 = [];
    }
    
    level.map2map.var_b700a350075400c3[ warpkey ] = playlistid;
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 1
// Checksum 0x0, Offset: 0x18ac
// Size: 0x20
function function_2364a3ae41c2ce7f( warpkey )
{
    return level.map2map.var_b700a350075400c3[ warpkey ];
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 2
// Checksum 0x0, Offset: 0x18d5
// Size: 0x56
function function_334a8a419bfc02c5( locstring, id )
{
    if ( !isdefined( level.map2map.spawnlocid ) )
    {
        level.map2map.spawnlocid = [];
    }
    
    level.map2map.spawnlocid[ locstring ] = id;
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 1
// Checksum 0x0, Offset: 0x1933
// Size: 0x20
function function_5ee910117a53f7e0( locstring )
{
    return level.map2map.spawnlocid[ locstring ];
}

// Namespace map_to_map / scripts\mp\map_to_map
// Params 1
// Checksum 0x0, Offset: 0x195c
// Size: 0x5c
function function_e0947372b9a0f240( spawnlocid )
{
    switch ( spawnlocid )
    {
        case 1:
            return 2;
        case 2:
            return 1;
        case 3:
            return 0;
        case 4:
            return 0;
        default:
            return 0;
    }
}

