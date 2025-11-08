#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\overlord;
#using scripts\engine\utility;
#using scripts\mp\flags;

#namespace overlord;

// Namespace overlord / scripts\cp_mp\overlord
// Params 0
// Checksum 0x0, Offset: 0x2bc
// Size: 0xc3
function init()
{
    if ( !function_1ad4a4e87bd92ba8() )
    {
        return;
    }
    
    level.overlord = spawnstruct();
    level.overlord.events = [];
    level.overlord.conversations = [];
    level.setoverlordlockedpriority = &setoverlordlockedpriority;
    level thread function_2b7b925f1037e020();
    level.overlord.var_f122d73bb796754c = getdvarint( @"hash_99ee36f514cfdc16", 3 );
    
    if ( getdvarint( @"hash_b1dbb741da6aa657", 0 ) == 1 )
    {
        level thread testqueue();
    }
    
    if ( getdvarint( @"hash_859fb74d1557c0b1", 1 ) && utility::ismp() )
    {
        level thread function_b0c21eabffce3fd4();
    }
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 0
// Checksum 0x0, Offset: 0x387
// Size: 0x53, Type: bool
function function_1ad4a4e87bd92ba8()
{
    if ( isdefined( level.gamemodebundle ) && istrue( level.gamemodebundle.var_21499b682c5b3a47 ) )
    {
        return true;
    }
    
    if ( utility::ismp() )
    {
        if ( getdvar( @"scr_br_gametype", "" ) != "dmz" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 0
// Checksum 0x0, Offset: 0x3e3
// Size: 0x347
function function_2b7b925f1037e020()
{
    csv = function_6c9808b9b419ed7e();
    scripts\mp\flags::levelflaginit( "overlord_csv_init", 0 );
    
    for ( row = 0; true ; row++ )
    {
        ref = tablelookupbyrow( csv, row, 0 );
        
        if ( ref == "" )
        {
            break;
        }
        
        alias = tablelookupbyrow( csv, row, 1 );
        priority = int( tablelookupbyrow( csv, row, 2 ) );
        cooldown = int( tablelookupbyrow( csv, row, 3 ) );
        timeout = lookupsoundlength( alias, 1 ) / 1000 + 2;
        registerevent( ref, alias, priority, cooldown, timeout );
    }
    
    str_bundle = function_867b48f5536f373e();
    
    if ( isdefined( str_bundle ) )
    {
        s_bundle = getscriptbundle( "dialogueoverlord:" + str_bundle );
        
        if ( isdefined( s_bundle ) )
        {
            foreach ( var_87fc95d97eb08ba9 in s_bundle.var_423f1766afe848b9 )
            {
                if ( isdefined( var_87fc95d97eb08ba9.alias ) )
                {
                    timeout = lookupsoundlength( var_87fc95d97eb08ba9.alias, 1 ) / 1000 + 2;
                    registerevent( var_87fc95d97eb08ba9.ref, var_87fc95d97eb08ba9.alias, var_87fc95d97eb08ba9.priority, var_87fc95d97eb08ba9.cooldown, timeout, var_87fc95d97eb08ba9.speakerasset, var_87fc95d97eb08ba9.delaybefore, var_87fc95d97eb08ba9.delayafter );
                }
            }
            
            foreach ( s_conversation in s_bundle.conversations )
            {
                level.overlord.conversations[ s_conversation.conversationname ] = s_conversation;
                
                foreach ( var_84e41716d3779c0e in s_conversation.soundevents )
                {
                    if ( isdefined( var_84e41716d3779c0e.alias ) )
                    {
                        eventref = default_to( var_84e41716d3779c0e.ref, var_84e41716d3779c0e.alias );
                        
                        if ( !isdefined( level.overlord.events[ eventref ] ) )
                        {
                            registerevent( eventref, var_84e41716d3779c0e.alias, var_84e41716d3779c0e.priority, var_84e41716d3779c0e.cooldown, function_c89ed1840c8d0f0f( lookupsoundlength( var_84e41716d3779c0e.alias, 1 ) ), var_84e41716d3779c0e.speakerasset, var_84e41716d3779c0e.delaybefore, var_84e41716d3779c0e.delayafter );
                        }
                    }
                }
            }
        }
    }
    
    scripts\mp\flags::levelflagset( "overlord_csv_init" );
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 0
// Checksum 0x0, Offset: 0x732
// Size: 0x92
function function_6c9808b9b419ed7e()
{
    if ( isdefined( level.gamemodebundle ) && istrue( level.gamemodebundle.var_21499b682c5b3a47 ) )
    {
        if ( isdefined( level.gamemodebundle.var_4def6c2024945408 ) )
        {
            return level.gamemodebundle.var_4def6c2024945408;
        }
        else if ( !isdefined( function_867b48f5536f373e() ) )
        {
            assertmsg( "overlord::getOverlordCSV: gameModeBundle or level.str_overlord_event_bundle override missing definition for 'Overlord Events', using '" + "mp_cp/overlord_dmz.csv" + "' as a default." );
            return "mp_cp/overlord_dmz.csv";
        }
    }
    
    return getdvar( @"hash_97efde55df4bcccd", "mp_cp/overlord_dmz.csv" );
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 0
// Checksum 0x0, Offset: 0x7cd
// Size: 0x4a
function function_867b48f5536f373e()
{
    if ( isdefined( level.gamemodebundle ) && istrue( level.gamemodebundle.var_21499b682c5b3a47 ) )
    {
        return default_to( level.var_af35f8ccfc5f7a70, level.gamemodebundle.var_74ff2a0df7caa848 );
    }
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 0
// Checksum 0x0, Offset: 0x81f
// Size: 0x7c
function testqueue()
{
    scripts\mp\flags::levelflagwait( "overlord_csv_init" );
    
    while ( true )
    {
        scripts\cp_mp\overlord::playevent( "player_civ_kill_third_warning", [ level.players[ 0 ] ] );
        wait 1;
        scripts\cp_mp\overlord::playevent( "player_civ_kill_frst_warning", [ level.players[ 0 ] ] );
        wait 1;
        scripts\cp_mp\overlord::playevent( "player_civ_kill_second_warning", [ level.players[ 0 ] ] );
        wait 5;
    }
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 8
// Checksum 0x0, Offset: 0x8a3
// Size: 0xe5
function registerevent( ref, alias, priority, cooldown, timeout, speakerasset, delaybefore, delayafter )
{
    event = spawnstruct();
    event.ref = ref;
    event.alias = alias;
    event.priority = isdefined( priority ) ? priority : 75;
    event.cooldown = cooldown * 1000;
    event.timeout = timeout;
    event.speakerasset = speakerasset;
    event.delaybefore = delaybefore;
    event.delayafter = delayafter;
    level.overlord.events[ ref ] = event;
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 4
// Checksum 0x0, Offset: 0x990
// Size: 0xc5
function function_9b411de07c46bddc( eventref, players, includedeadplayers, var_f84decb7822f8442 )
{
    if ( !isdefined( level.overlord ) )
    {
        return 0;
    }
    
    if ( !isdefined( eventref ) || !isdefined( var_f84decb7822f8442 ) )
    {
        return 0;
    }
    
    event = level.overlord.events[ eventref ];
    
    if ( !isdefined( event ) )
    {
        return 0;
    }
    
    if ( !isdefined( event.playhistory ) )
    {
        event.playhistory = [];
    }
    
    if ( istrue( event.playhistory[ var_f84decb7822f8442 ] ) )
    {
        return 0;
    }
    
    eventplayed = playevent( eventref, players, 0, includedeadplayers, 0 );
    
    if ( istrue( eventplayed ) )
    {
        event.playhistory[ var_f84decb7822f8442 ] = 1;
    }
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 5
// Checksum 0x0, Offset: 0xa5d
// Size: 0x2b5, Type: bool
function playevent( eventref, players, delay, includedeadplayers, var_fe8102d7751b9184 )
{
    if ( !isdefined( level.overlord ) )
    {
        return false;
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    event = level.overlord.events[ eventref ];
    
    if ( !isdefined( event ) )
    {
        return false;
    }
    
    if ( !soundexists( event.alias ) )
    {
        return false;
    }
    
    if ( isdefined( event.delaybefore ) && event.delaybefore > 0 )
    {
        wait event.delaybefore;
    }
    
    foreach ( player in players )
    {
        if ( !isalive( player ) && !istrue( includedeadplayers ) )
        {
            continue;
        }
        
        player function_d453707f6b8f2c6d();
        
        if ( !player function_8c3011dccace47c4( eventref ) )
        {
            continue;
        }
        
        interruptcurrent = player shouldinterrupt( event );
        var_6313cac4d3f01dab = event.timeout;
        
        if ( !interruptcurrent )
        {
            foreach ( n_start_time in player.var_5a2916f745d4389a )
            {
                var_6313cac4d3f01dab += level.overlord.events[ var_f1ded4f36c028507 ].timeout;
            }
        }
        
        player queuedialogforplayer( event.alias, event.alias, var_6313cac4d3f01dab, "overlord", interruptcurrent, undefined, event.timeout );
        player.var_5a2916f745d4389a[ eventref ] = gettime();
        
        if ( isdefined( event.speakerasset ) )
        {
            player val::set( event.alias, "overlord_speaker", event.speakerasset );
            player delaythreadendon( event.timeout, [ "disconnect" ], &val::reset, event.alias, "overlord_speaker" );
        }
    }
    
    if ( istrue( var_fe8102d7751b9184 ) && isdefined( event.timeout ) )
    {
        wait event.timeout;
    }
    
    if ( isdefined( event.delayafter ) && event.delayafter > 0 )
    {
        wait event.delayafter;
    }
    
    return true;
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 6
// Checksum 0x0, Offset: 0xd1b
// Size: 0x45e
function playconversation( conversationname, players, var_7b76e64b846c00d, var_8b6798cc35c82e07, location, group )
{
    players = default_to( players, level.players );
    var_8b6798cc35c82e07 = default_to( var_8b6798cc35c82e07, 1 );
    group = default_to( group, "overlord_conversation" );
    
    if ( isdefined( var_7b76e64b846c00d ) )
    {
        wait var_7b76e64b846c00d;
    }
    
    s_conversation = level.overlord.conversations[ conversationname ];
    
    if ( isdefined( s_conversation ) )
    {
        foreach ( var_84e41716d3779c0e in s_conversation.soundevents )
        {
            if ( isdefined( var_84e41716d3779c0e.alias ) )
            {
                eventref = default_to( var_84e41716d3779c0e.ref, var_84e41716d3779c0e.alias );
                
                if ( !isdefined( level.overlord.events[ eventref ] ) )
                {
                    registerevent( eventref, var_84e41716d3779c0e.alias, var_84e41716d3779c0e.priority, var_84e41716d3779c0e.cooldown, function_c89ed1840c8d0f0f( lookupsoundlength( var_84e41716d3779c0e.alias, 1 ) ), var_84e41716d3779c0e.speakerasset, var_84e41716d3779c0e.delaybefore, var_84e41716d3779c0e.delayafter );
                }
                
                if ( isdefined( var_84e41716d3779c0e.delaybefore ) )
                {
                    wait var_84e41716d3779c0e.delaybefore;
                }
                
                n_wait = level.overlord.events[ eventref ].timeout;
                
                if ( group != "overlord_intel" )
                {
                    foreach ( player in players )
                    {
                        if ( isalive( player ) )
                        {
                            player function_d453707f6b8f2c6d();
                            
                            if ( !player function_8c3011dccace47c4( eventref ) )
                            {
                                continue;
                            }
                            
                            if ( isdefined( var_84e41716d3779c0e.speakerasset ) )
                            {
                                player val::set( level.overlord.events[ eventref ].alias, "overlord_speaker", level.overlord.events[ eventref ].speakerasset );
                                player delaythreadendon( level.overlord.events[ eventref ].timeout, [ "disconnect" ], &val::reset, level.overlord.events[ eventref ].alias, "overlord_speaker" );
                            }
                            
                            interruptcurrent = player shouldinterrupt( level.overlord.events[ eventref ] ) || var_8b6798cc35c82e07;
                            var_6313cac4d3f01dab = level.overlord.events[ eventref ].timeout;
                            
                            if ( !interruptcurrent )
                            {
                                foreach ( n_start_time in player.var_5a2916f745d4389a )
                                {
                                    var_6313cac4d3f01dab += level.overlord.events[ var_f1ded4f36c028507 ].timeout;
                                }
                            }
                            
                            player queuedialogforplayer( var_84e41716d3779c0e.alias, var_84e41716d3779c0e.alias, var_6313cac4d3f01dab, group, var_8b6798cc35c82e07, location, level.overlord.events[ eventref ].timeout );
                            player.var_5a2916f745d4389a[ eventref ] = gettime();
                        }
                    }
                }
                else if ( isdefined( location ) )
                {
                    playsoundatpos( location, var_84e41716d3779c0e.alias );
                }
                
                wait n_wait;
                
                if ( isdefined( var_84e41716d3779c0e.delayafter ) )
                {
                    wait var_84e41716d3779c0e.delayafter;
                }
            }
        }
    }
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x1181
// Size: 0x37
function private function_b0920556607fb961( var_cf8b5ceaf91df155 )
{
    if ( isdefined( level.var_237eaf521a80c304 ) && isdefined( var_cf8b5ceaf91df155 ) && var_cf8b5ceaf91df155 != "" )
    {
        self [[ level.var_237eaf521a80c304 ]]( var_cf8b5ceaf91df155 );
    }
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 0, eflags: 0x4
// Checksum 0x0, Offset: 0x11c0
// Size: 0x1c
function private hidespeaker()
{
    if ( isdefined( level.var_673320093d434d55 ) )
    {
        self [[ level.var_673320093d434d55 ]]();
    }
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 3
// Checksum 0x0, Offset: 0x11e4
// Size: 0x71
function function_9793a81bc3bc19e9( eventref, team, delay )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    players = level.players;
    
    if ( isdefined( team ) )
    {
        if ( scripts\engine\utility::issharedfuncdefined( "game", "getTeamData" ) )
        {
            players = [[ scripts\engine\utility::getsharedfunc( "game", "getTeamData" ) ]]( team, "players" );
        }
    }
    
    playevent( eventref, players );
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 1
// Checksum 0x0, Offset: 0x125d
// Size: 0x58, Type: bool
function function_8c3011dccace47c4( eventref )
{
    if ( isdefined( self.overlordlockedpriority ) && level.overlord.events[ eventref ].priority < self.overlordlockedpriority )
    {
        return false;
    }
    
    return !scripts\engine\utility::array_contains_key( self.var_5a2916f745d4389a, eventref );
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 0
// Checksum 0x0, Offset: 0x12be
// Size: 0x133
function function_d453707f6b8f2c6d()
{
    if ( !isdefined( self.var_5a2916f745d4389a ) )
    {
        self.var_5a2916f745d4389a = [];
        return;
    }
    
    var_8685876230b8771d = [];
    currenttime = gettime();
    
    foreach ( eventref, n_start_time in self.var_5a2916f745d4389a )
    {
        if ( !isdefined( level.overlord.events[ eventref ] ) )
        {
            continue;
        }
        
        var_d2154b40b980d7d6 = n_start_time + function_a5b14435e3229bed( level.overlord.events[ eventref ].timeout ) + level.overlord.events[ eventref ].cooldown;
        
        if ( var_d2154b40b980d7d6 < currenttime )
        {
            var_8685876230b8771d[ eventref ] = n_start_time;
        }
    }
    
    foreach ( eventref, n_start_time in var_8685876230b8771d )
    {
        self.var_5a2916f745d4389a[ eventref ] = undefined;
    }
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 2
// Checksum 0x0, Offset: 0x13f9
// Size: 0xce, Type: bool
function function_50ebf0029301be3f( player, eventref )
{
    if ( !isdefined( player.var_5a2916f745d4389a ) )
    {
        return false;
    }
    
    if ( !isdefined( player.var_5a2916f745d4389a[ eventref ] ) )
    {
        return false;
    }
    
    if ( !isdefined( level.overlord.events[ eventref ] ) )
    {
        return false;
    }
    
    if ( !isdefined( level.overlord.events[ eventref ].cooldown ) )
    {
        return false;
    }
    
    lasttime = player.var_5a2916f745d4389a[ eventref ];
    cooldowntime = level.overlord.events[ eventref ].cooldown;
    currenttime = gettime();
    return lasttime + cooldowntime >= currenttime;
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 1
// Checksum 0x0, Offset: 0x14d0
// Size: 0x86, Type: bool
function shouldinterrupt( event )
{
    foreach ( n_start_time in self.var_5a2916f745d4389a )
    {
        if ( event.priority <= level.overlord.events[ eventref ].priority )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x155f
// Size: 0x25, Type: bool
function private function_4831c2aa1655ce23( player )
{
    var_d90809392748e640 = player namespace_2b1145f62aa835b8::hasperksharedfunc( "specialty_pc_stealth" );
    return !istrue( var_d90809392748e640 );
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 1, eflags: 0x4
// Checksum 0x0, Offset: 0x158d
// Size: 0x97, Type: bool
function private isvalidplayer( player )
{
    additionalchecks = 1;
    
    if ( isdefined( level.var_76eba5facacd254b ) && isfunction( level.var_76eba5facacd254b ) )
    {
        additionalchecks = [[ level.var_76eba5facacd254b ]]( player );
    }
    
    return isdefined( player ) && isdefined( player.team ) && isdefined( player.origin ) && isalive( player ) && !isdefined( player.fauxdead ) && !istrue( player.delayedspawnedplayernotify ) && istrue( additionalchecks );
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 0
// Checksum 0x0, Offset: 0x162d
// Size: 0x37b
function function_b0c21eabffce3fd4()
{
    proximitydistancesq = getdvarint( @"scr_overlord_enemy_proximity_radius", 4096 );
    proximitydistancesq *= proximitydistancesq;
    ignoretime = getdvarfloat( @"hash_32244d6acf101808", 60 );
    trackedteams = [];
    
    foreach ( team in level.teamnamelist )
    {
        trackedteams[ team ] = [];
    }
    
    while ( true )
    {
        validplayers = [];
        
        foreach ( player in level.players )
        {
            if ( isvalidplayer( player ) )
            {
                validplayers[ validplayers.size ] = player;
            }
        }
        
        partition = create_partition( validplayers, 2500 );
        
        foreach ( player in validplayers )
        {
            if ( !isvalidplayer( player ) )
            {
                continue;
            }
            
            foreach ( playerarray in partition function_df633f460888a47( player.origin ) )
            {
                foreach ( testplayer in playerarray )
                {
                    if ( !isvalidplayer( testplayer ) || !function_4831c2aa1655ce23( testplayer ) )
                    {
                        continue;
                    }
                    
                    if ( player.team == testplayer.team || distancesquared( player.origin, testplayer.origin ) > proximitydistancesq )
                    {
                        continue;
                    }
                    
                    var_ba24b605d8b9c100 = function_f240c299b9341e8f( player, testplayer, trackedteams, ignoretime );
                    
                    if ( var_ba24b605d8b9c100 )
                    {
                        testplayers = namespace_2b1145f62aa835b8::getteamdatasharedfunc( testplayer.team, "players" );
                        eventplayers = namespace_2b1145f62aa835b8::getteamdatasharedfunc( player.team, "players" );
                        var_571aeaf27dbb7e22 = [];
                        
                        foreach ( player in eventplayers )
                        {
                            if ( getdvarint( @"hash_c53afaea3f55391a", 0 ) && player namespace_2b1145f62aa835b8::hasperksharedfunc( "specialty_pc_comms" ) )
                            {
                                continue;
                            }
                            
                            var_571aeaf27dbb7e22[ var_571aeaf27dbb7e22.size ] = player;
                        }
                        
                        playevent( ter_op( testplayers.size > level.overlord.var_f122d73bb796754c, "nearby_big_team", "player_enemy_player_nearby" ), var_571aeaf27dbb7e22 );
                        trackedteams[ player.team ][ testplayer.team ] = gettime();
                    }
                }
            }
            
            waitframe();
        }
        
        wait 3;
    }
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 1
// Checksum 0x0, Offset: 0x19b0
// Size: 0x30d
function function_aea00c3815b226da( player )
{
    player notify( "monitor_enemy_prox" );
    player endon( "disconnect" );
    player endon( "death" );
    level endon( "game_ended" );
    player endon( "monitor_enemy_prox" );
    proximitydistancesq = getdvarint( @"scr_overlord_enemy_proximity_radius", 4096 );
    proximitydistancesq *= proximitydistancesq;
    ignoretime = getdvarfloat( @"hash_32244d6acf101808", 60 );
    trackedteams = [];
    
    foreach ( team in level.teamnamelist )
    {
        trackedteams[ team ] = [];
    }
    
    while ( true )
    {
        validplayers = [];
        
        foreach ( validplayer in level.players )
        {
            if ( isvalidplayer( validplayer ) )
            {
                validplayers[ validplayers.size ] = validplayer;
            }
        }
        
        partition = create_partition( validplayers, 2500 );
        
        foreach ( playerarray in partition function_df633f460888a47( player.origin ) )
        {
            foreach ( testplayer in playerarray )
            {
                if ( !isvalidplayer( testplayer ) || !function_4831c2aa1655ce23( testplayer ) )
                {
                    continue;
                }
                
                if ( player.team == testplayer.team || distancesquared( player.origin, testplayer.origin ) > proximitydistancesq )
                {
                    continue;
                }
                
                var_ba24b605d8b9c100 = !isdefined( trackedteams[ player.team ][ testplayer.team ] ) || ( gettime() - trackedteams[ player.team ][ testplayer.team ] ) / 1000 > ignoretime;
                
                if ( var_ba24b605d8b9c100 )
                {
                    testplayers = namespace_53fc9ddbb516e6e1::getteamdatasharedfunc( testplayer.team, "players" );
                    playevent( ter_op( testplayers.size > level.overlord.var_f122d73bb796754c, "nearby_big_team", "player_enemy_player_nearby" ), [ player ] );
                    trackedteams[ player.team ][ testplayer.team ] = gettime();
                }
            }
        }
        
        wait 3;
    }
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 1
// Checksum 0x0, Offset: 0x1cc5
// Size: 0x15
function setoverlordlockedpriority( val )
{
    self.overlordlockedpriority = val;
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 3
// Checksum 0x0, Offset: 0x1ce2
// Size: 0x6b
function function_2c722a2ef9574e87( players, tag, priority )
{
    foreach ( player in players )
    {
        player val::set( tag, "overlord_locked_priority", priority );
    }
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 2
// Checksum 0x0, Offset: 0x1d55
// Size: 0x62
function function_70979c1eabf04180( players, tag )
{
    foreach ( player in players )
    {
        player val::reset( tag, "overlord_locked_priority" );
    }
}

// Namespace overlord / scripts\cp_mp\overlord
// Params 4
// Checksum 0x0, Offset: 0x1dbf
// Size: 0xc2
function function_f240c299b9341e8f( player, testplayer, trackedteams, ignoretime )
{
    var_ba24b605d8b9c100 = !isdefined( trackedteams[ player.team ][ testplayer.team ] ) || ( gettime() - trackedteams[ player.team ][ testplayer.team ] ) / 1000 > ignoretime;
    
    if ( getdvarint( @"hash_c53afaea3f55391a", 0 ) )
    {
        testplayers = namespace_2b1145f62aa835b8::getteamdatasharedfunc( testplayer.team, "players" );
        return ( var_ba24b605d8b9c100 && testplayers.size > level.overlord.var_f122d73bb796754c );
    }
    
    return var_ba24b605d8b9c100;
}

