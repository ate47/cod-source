#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\playerlogic;
#using scripts\mp\utility\disconnect_event_aggregator;
#using scripts\mp\utility\game;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\player;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;

#namespace infilexfil;

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 8
// Checksum 0x0, Offset: 0x83a
// Size: 0x268
function infil_add( type, subtype, seat_count, required_seats, fill_order, spawn_func, get_length_func, player_func )
{
    if ( !issharedfuncdefined( "infil", "get_all_infils" ) )
    {
        scripts\engine\utility::registersharedfunc( "infil", "get_all_infils", &get_all_infils );
    }
    
    while ( !isdefined( level.teamnamelist ) )
    {
        waitframe();
    }
    
    if ( !isdefined( game[ "infil" ] ) )
    {
        foreach ( team in level.teamnamelist )
        {
            game[ "infil" ][ team ] = [];
        }
        
        game[ "infil" ][ 0 ] = [];
    }
    
    if ( isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) )
    {
        infils = get_all_infils( type );
        
        foreach ( infil in infils )
        {
            if ( infil.name == subtype )
            {
                if ( isdefined( infil.script_label ) && infil.script_label == level.localeid )
                {
                    break;
                }
            }
        }
    }
    
    if ( isdefined( game[ "infil" ][ 0 ][ type ] ) && isdefined( game[ "infil" ][ 0 ][ type ][ subtype ] ) )
    {
        if ( isdefined( game[ "infil" ][ 0 ][ type ][ subtype ][ 6 ] ) )
        {
            self [[ game[ "infil" ][ 0 ][ type ][ subtype ][ 6 ] ]]( type, subtype );
        }
        
        return;
    }
    
    game[ "infil" ][ 0 ][ type ][ subtype ] = [];
    game[ "infil" ][ 0 ][ type ][ subtype ][ 0 ] = spawn_func;
    game[ "infil" ][ 0 ][ type ][ subtype ][ 1 ] = player_func;
    game[ "infil" ][ 0 ][ type ][ subtype ][ 2 ] = get_length_func;
    game[ "infil" ][ 0 ][ type ][ subtype ][ 3 ] = seat_count;
    game[ "infil" ][ 0 ][ type ][ subtype ][ 4 ] = required_seats;
    game[ "infil" ][ 0 ][ type ][ subtype ][ 5 ] = fill_order;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0xaaa
// Size: 0x33
function infil_is_interactive()
{
    if ( !isdefined( level.interactiveinfil ) )
    {
        level.interactiveinfil = getdvarint( @"hash_bafe5b24255dff94", 0 ) == 1;
    }
    
    return level.interactiveinfil;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0xae6
// Size: 0x6d6
function infil_init()
{
    /#
        level thread function_8bce6c2b9dfce133();
        level thread function_dea41b0700c91408();
        level thread function_5761b0a20863c59e();
    #/
    
    level.infilstartdelay = getdvarint( @"hash_1b3b51b6f9a78f94", 3 );
    level.infilenddelay = getdvarint( @"hash_c33a1ba677b4aee9", 3 );
    level.var_c96464f39952b78a = &function_c96464f39952b78a;
    
    if ( level.rankedmatch && !isdedicatedserver() )
    {
        game[ "infil" ] = undefined;
        gameflagset( "infil_setup_complete" );
        return;
    }
    
    if ( game[ "roundsPlayed" ] > 0 && !scripts\cp_mp\utility\game_utility::function_8b6131109e66d962() || getdvarint( @"scr_game_infilskip", 0 ) == 1 || scripts\cp_mp\utility\game_utility::isbrstylegametype() || getdvarint( @"scr_game_matchstarttime" ) < 15 || getgametype() == "war" && scripts\cp_mp\utility\game_utility::isdonetskmap() )
    {
        game[ "infil" ] = undefined;
        level.requiredplayercount[ "allies" ] = 0;
        level.requiredplayercount[ "axis" ] = 0;
        gameflagset( "infil_setup_complete" );
        return;
    }
    else if ( scripts\cp_mp\utility\game_utility::function_8b6131109e66d962() )
    {
        game[ "infil" ] = undefined;
        level.var_d0074a54d755766b = 1;
        setdvar( @"hash_c653d32c30815d2b", 5 );
    }
    
    if ( !isdefined( level.prematchperiodend ) || level.prematchperiodend == 0 )
    {
        game[ "infil" ] = undefined;
        gameflagset( "infil_setup_complete" );
        return;
    }
    
    while ( !isdefined( level.teamnamelist ) )
    {
        waitframe();
    }
    
    if ( scripts\mp\gamelogic::shouldmodelognotify() )
    {
        logstring( "IWH-315293: ALBACORE: level.teamNameList while finished" );
    }
    
    waitframe();
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    
    /#
        setdevdvarifuninitialized( @"hash_e6526b9ef05103ad", -1 );
        setdevdvarifuninitialized( @"hash_9d06e62e59d8f04a", 0 );
        setdevdvarifuninitialized( @"hash_f711f210f6ffd355", 0 );
        setdevdvarifuninitialized( @"hash_911d1dbce0b52bb1", 0 );
        setdevdvarifuninitialized( @"hash_4c2539684478a68e", "<dev string:x1c>" );
        setdevdvarifuninitialized( @"hash_1f7e93431ff79c39", "<dev string:x1c>" );
    #/
    
    level.prematchallowfunc = &infil_player_allow;
    infilduration = undefined;
    level.infilsactive = 0;
    var_8fd71ce382f455a2 = [];
    
    foreach ( infil_data in get_all_infils() )
    {
        type = infil_data.script_noteworthy;
        subtype = infil_data.name;
        
        if ( !infil_data infil_is_gamemode() )
        {
            continue;
        }
        
        if ( isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) )
        {
            if ( infil_data.name == subtype )
            {
                if ( !isdefined( infil_data.script_label ) || infil_data.script_label != level.localeid )
                {
                    continue;
                }
            }
        }
        
        if ( level.mapname == "mp_wartorn" && getgametype() == "rescue" )
        {
            infil_data.script_team = getotherteam( infil_data.script_team )[ 0 ];
        }
        
        team = infil_data.script_team;
        
        if ( !array_contains( var_8fd71ce382f455a2, team ) )
        {
            var_8fd71ce382f455a2[ var_8fd71ce382f455a2.size ] = team;
        }
    }
    
    if ( var_8fd71ce382f455a2.size == level.teamnamelist.size )
    {
        foreach ( infil_data in get_all_infils() )
        {
            type = infil_data.script_noteworthy;
            subtype = infil_data.name;
            
            if ( !infil_data infil_is_gamemode() )
            {
                continue;
            }
            
            if ( isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) )
            {
                if ( infil_data.name == subtype )
                {
                    if ( !isdefined( infil_data.script_label ) || infil_data.script_label != level.localeid )
                    {
                        continue;
                    }
                }
            }
            
            if ( infil_data infil_has_map_config() )
            {
                infil_init_spawn_selection();
            }
            
            if ( infil_data infil_is_type( type ) && infil_data infil_is_subtype( subtype ) && isgameplayteam( infil_data.script_team ) )
            {
                level.infilsactive++;
                infil_type = game[ "infil" ][ 0 ][ type ][ subtype ];
                originalsubtype = subtype;
                var_6b997733c80961c4 = subtype;
                
                if ( issubstr( var_6b997733c80961c4, "alpha" ) )
                {
                    var_6b997733c80961c4 = "alpha";
                }
                
                if ( issubstr( var_6b997733c80961c4, "bravo" ) )
                {
                    var_6b997733c80961c4 = "bravo";
                }
                
                if ( !isdefined( infil_type ) )
                {
                    infil_type = game[ "infil" ][ 0 ][ type ][ var_6b997733c80961c4 ];
                }
                
                infil_ent = infil_data [[ infil_type[ 0 ] ]]( infil_data.script_team, infil_data.target, var_6b997733c80961c4, originalsubtype );
                infil_ent.players = [];
                infil_ent.type = type;
                infil_ent.originalsubtype = originalsubtype;
                infil_ent.subtype = var_6b997733c80961c4;
                infil_ent.infillength = infil_ent [[ infil_type[ 2 ] ]]( originalsubtype );
                
                if ( !isdefined( infilduration ) || infilduration < infil_ent.infillength )
                {
                    infilduration = infil_ent.infillength;
                }
                
                team = infil_data.script_team;
                
                if ( getdvarint( @"hash_ac31997b109b6bc5", 0 ) == 1 )
                {
                    team = getenemyteams( team )[ 0 ];
                }
                
                game[ "infil" ][ team ][ 1 ][ type ][ subtype ] = infil_ent;
                register_infil_spots( team, infil_ent, infil_type[ 3 ], infil_type[ 4 ], infil_type[ 5 ], infil_type[ 1 ] );
            }
        }
    }
    
    if ( gamehasinfil() && isdefined( infilduration ) )
    {
        level thread onplayerspawned();
        level thread function_3c075bf6eade7262();
        level.prematchperiod = getdvarint( @"hash_c653d32c30815d2b", 15 );
        level.matchcountdowntime = level.prematchperiod + level.infilstartdelay + level.infilenddelay;
        level.prematchperiodend = infilduration + level.infilstartdelay + level.infilenddelay;
        level.var_2a15d29e8890b785 = 0;
        thread scripts\mp\gamelogic::matchstarttimer( "match_starting_in", level.prematchperiod + level.prematchperiodend );
        level thread infil_setup_ui();
        level thread infil_wait_for_players();
        level thread waitandunloadinfils();
        gameflagset( "infil_will_run" );
    }
    
    gameflagset( "infil_setup_complete" );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x11c4
// Size: 0x2e
function onplayerspawned()
{
    level endon( "infil_started" );
    
    while ( true )
    {
        level waittill( "player_spawned", player );
        player thread waitforstreamsynccomplete();
    }
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x11fa
// Size: 0x1cd
function waitforstreamsynccomplete()
{
    level endon( "infil_started" );
    self endon( "death_or_disconnect" );
    gameflagwait( "infil_setup_complete" );
    
    if ( istrue( level.var_2a15d29e8890b785 ) )
    {
        return;
    }
    
    if ( isdefined( self.team ) )
    {
        if ( gameflag( "infil_will_run" ) && !gameflag( "prematch_done" ) )
        {
            averageposition = ( 0, 0, 0 );
            count = 0;
            
            if ( isdefined( game[ "infil" ] ) && isdefined( game[ "infil" ][ self.team ] ) && isdefined( game[ "infil" ][ self.team ][ 1 ] ) )
            {
                foreach ( array in game[ "infil" ][ self.team ][ 1 ] )
                {
                    foreach ( ent in array )
                    {
                        averageposition += ent.origin;
                        count++;
                    }
                }
            }
            
            if ( count > 0 )
            {
                averageposition /= count;
            }
            
            self function_b88c89bb7cd1ab8e( averageposition );
        }
    }
    
    while ( !istrue( scripts\mp\utility\stats::getpersstat( "streamSyncComplete" ) ) )
    {
        waitframe();
    }
    
    var_be4fbabeafb491a7 = get_spot_from_player( self, getotherteam( self.team )[ 0 ] );
    
    if ( isdefined( var_be4fbabeafb491a7 ) )
    {
        player_free_spot( self, getotherteam( self.team )[ 0 ] );
    }
    
    player_join_infil();
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x13cf
// Size: 0x3d
function onplayerdisconnect( player )
{
    if ( !isdefined( player.infil ) )
    {
        return;
    }
    
    if ( gameflag( "prematch_done" ) )
    {
        return;
    }
    
    player_free_spot( player, player.team );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x1414
// Size: 0x3f
function onplayerchangeteams()
{
    level endon( "prematch_over" );
    self endon( "player_free_spot" );
    team = self.team;
    waittill_any_2( "joined_team", "joined_spectators" );
    player_free_spot( self, team );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x145b
// Size: 0x31
function get_all_infils( infil_type )
{
    if ( isdefined( infil_type ) )
    {
        return getstructarray( infil_type, "script_noteworthy" );
    }
    
    return getstructarray( "mp_infil", "targetname" );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x1494
// Size: 0x16, Type: bool
function infil_is_type( infil_type )
{
    return self.script_noteworthy == infil_type;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x14b3
// Size: 0x16, Type: bool
function infil_is_subtype( infil_subtype )
{
    return self.name == infil_subtype;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x14d2
// Size: 0x4da, Type: bool
function infil_is_gamemode()
{
    /#
        if ( getdvarint( @"hash_2bc5d2ec9043a3f5", 0 ) == 1 )
        {
            return true;
        }
        
        type = self.script_noteworthy;
        team = self.script_team;
        allies = getdvar( @"hash_4c2539684478a68e", "<dev string:x1c>" );
        axis = getdvar( @"hash_1f7e93431ff79c39", "<dev string:x1c>" );
        
        if ( team == "<dev string:x27>" && allies != "<dev string:x1c>" )
        {
            return ( allies == type );
        }
        
        if ( team == "<dev string:x31>" && axis != "<dev string:x1c>" )
        {
            return ( axis == type );
        }
    #/
    
    if ( !isdefined( self.spawnflags ) || self.spawnflags == 0 )
    {
        return false;
    }
    
    if ( !level.teambased )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_78fc5b05aefc64a", 1 ) == 1 && level.mapname == "mp_jup_grandprix_pm_2" )
    {
        return false;
    }
    
    if ( self.spawnflags & 1 )
    {
        switch ( level.mapname )
        {
            case #"hash_1ab428ea9c0ee9e5":
                if ( level.gametype == "sd" )
                {
                    return false;
                }
                
                break;
            case #"hash_d8bbcfc499e70e6f":
                if ( level.gametype == "sd" )
                {
                    return false;
                }
                
                break;
            case #"hash_9c2fdccb75b37f7e":
                if ( level.gametype == "dd" )
                {
                    return false;
                }
                
                break;
            case #"hash_ae56d5b65ad78351":
                if ( level.gametype == "sd" || level.gametype == "rescue" )
                {
                    return false;
                }
                
                break;
        }
        
        return true;
    }
    
    if ( self.spawnflags & 2 )
    {
        switch ( level.gametype )
        {
            case #"hash_7485fa6c474ec865":
            case #"hash_8c758b84936e8d42":
            case #"hash_c3668076a0827ce0":
            case #"hash_ea061d29bbd1f237":
            case #"hash_ec24570718a340f5":
                return true;
        }
    }
    
    if ( self.spawnflags & 4 )
    {
        switch ( level.gametype )
        {
            case #"hash_fa0ed2f6bd4f4395":
            case #"hash_fa50b0f6bd82e972":
            case #"hash_fa50baf6bd82f930":
                if ( level.mapname == "mp_petrograd" || level.mapname == "mp_piccadilly" )
                {
                    return false;
                }
                else
                {
                    return true;
                }
            case #"hash_ec086b911c1011ec":
                return true;
        }
    }
    
    if ( self.spawnflags & 8 )
    {
        switch ( level.gametype )
        {
            case #"hash_53825b446469ac4c":
            case #"hash_f4a9126c03d3385b":
                return true;
        }
    }
    
    if ( self.spawnflags & 16 )
    {
        switch ( level.gametype )
        {
            case #"hash_6efb0f59a62300fb":
            case #"hash_cf3000550ee7e8b3":
            case #"hash_dd5b900f435d3f36":
            case #"hash_ec72fd25bbbac99e":
            case #"hash_fa34c5f6bd6d4432":
                return true;
        }
    }
    
    if ( self.spawnflags & 32 )
    {
        switch ( level.gametype )
        {
            case #"hash_1a5d186c17c00d3c":
                return true;
        }
    }
    
    if ( self.spawnflags & 64 )
    {
        switch ( level.gametype )
        {
            case #"hash_eb5e5f470e0c1dc2":
                return true;
        }
    }
    
    if ( self.spawnflags & 128 )
    {
        switch ( level.gametype )
        {
            case #"hash_1e4846dca3ccf38":
            case #"hash_ca6516c10db2c95":
            case #"hash_1aac086c17fe5ccb":
            case #"hash_5e78ea9021845d4a":
            case #"hash_7f9c384a34cc392f":
            case #"hash_9a6f07d0214a87db":
            case #"hash_c065cef60f38490a":
                return true;
        }
    }
    
    if ( self.spawnflags & 256 )
    {
        switch ( level.gametype )
        {
            case #"hash_973d1db8b6644466":
                return true;
        }
    }
    
    if ( self.spawnflags & 512 )
    {
        switch ( level.gametype )
        {
            case #"hash_a1313b745c17c07e":
                return true;
        }
    }
    
    if ( self.spawnflags & 1024 )
    {
        switch ( level.gametype )
        {
            case #"hash_e6d4de8be88215fc":
                return true;
        }
    }
    
    if ( self.spawnflags & 2048 )
    {
        switch ( level.gametype )
        {
            case #"hash_4d60179017f5a28a":
                return true;
        }
    }
    
    return false;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x19b5
// Size: 0x3, Type: bool
function infil_has_map_config()
{
    return false;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x19c1
// Size: 0x2
function infil_init_spawn_selection()
{
    
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 2
// Checksum 0x0, Offset: 0x19cb
// Size: 0x190
function infil_player_allow( allow, bypass )
{
    if ( self ishost() && getdvarint( @"hash_f711f210f6ffd355" ) == 1 )
    {
        if ( !allow )
        {
            val::set( "infil_player", "weapon", 0 );
            return;
        }
        
        val::reset_all( "infil_player" );
        return;
    }
    
    if ( !teamhasinfil( self.team ) && !istrue( bypass ) )
    {
        scripts\mp\playerlogic::playerprematchallow( allow );
        return;
    }
    
    if ( !allow )
    {
        val::set( "infil_player", "allow_movement", 0 );
        val::set( "infil_player", "prone", 0 );
        val::set( "infil_player", "crouch", 0 );
        val::set( "infil_player", "allow_jump", 0 );
        val::set( "infil_player", "fire", 0 );
        val::set( "infil_player", "ads", 0 );
        val::set( "infil_player", "sprint", 0 );
        val::set( "infil_player", "melee", 0 );
        val::set( "infil_player", "lean", 0 );
        val::set( "infil_player", "slide", 0 );
        val::set( "infil_player", "offhand_weapons", 0 );
        val::set( "infil_player", "weapon_switch", 0 );
        val::set( "infil_player", "usability", 0 );
    }
    else
    {
        val::reset_all( "infil_player" );
    }
    
    println( self.name + "<dev string:x39>" + allow );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 6
// Checksum 0x0, Offset: 0x1b63
// Size: 0x20d
function register_infil_spots( team, infil, amount, required, fillorder, think_func )
{
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        game[ "infil" ][ team ][ 0 ] = [];
    }
    
    startindex = game[ "infil" ][ team ][ 0 ].size;
    
    for ( i = 0; i < amount ; i++ )
    {
        index = game[ "infil" ][ team ][ 0 ].size;
        
        if ( isdefined( fillorder ) )
        {
            seatfound = 0;
            
            foreach ( priority, seats in fillorder )
            {
                foreach ( seat in seats )
                {
                    if ( seat == index - startindex )
                    {
                        game[ "infil" ][ team ][ 0 ][ index ][ 3 ] = priority;
                        seatfound = 1;
                        break;
                    }
                }
                
                if ( seatfound )
                {
                    break;
                }
            }
        }
        else
        {
            game[ "infil" ][ team ][ 0 ][ index ][ 3 ] = -1;
        }
        
        game[ "infil" ][ team ][ 0 ][ index ][ 0 ] = i;
        game[ "infil" ][ team ][ 0 ][ index ][ 1 ] = infil;
        game[ "infil" ][ team ][ 0 ][ index ][ 2 ] = think_func;
    }
    
    if ( !istrue( level.requiredplayercountoveride ) )
    {
        level.requiredplayercount[ team ] += required;
    }
    
    /#
        if ( getdvarint( @"hash_911d1dbce0b52bb1" ) > 0 )
        {
            level.requiredplayercount[ team ] = getdvarint( @"hash_911d1dbce0b52bb1" );
        }
    #/
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 2
// Checksum 0x0, Offset: 0x1d78
// Size: 0xc2
function player_on_spot( player, spot_index )
{
    if ( !isdefined( game[ "infil" ][ player.team ][ 0 ] ) )
    {
        assertmsg( "<dev string:x6a>" );
    }
    
    if ( !isdefined( game[ "infil" ][ player.team ][ 0 ][ spot_index ] ) )
    {
        assertmsg( "<dev string:xa9>" );
    }
    
    if ( isdefined( game[ "infil" ][ player.team ][ 0 ][ spot_index ][ 4 ] ) )
    {
        assertmsg( "<dev string:xf6>" );
    }
    
    game[ "infil" ][ player.team ][ 0 ][ spot_index ][ 4 ] = player;
    return game[ "infil" ][ player.team ][ 0 ][ spot_index ];
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 2
// Checksum 0x0, Offset: 0x1e43
// Size: 0xd9
function player_free_spot( player, team )
{
    player setclientomnvar( "ui_player_in_infil", 0 );
    
    if ( !isdefined( team ) )
    {
        team = player.team;
    }
    
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        assertmsg( "<dev string:x130>" );
    }
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( is_spot_taken( team, key ) && spot[ 4 ] == player )
        {
            game[ "infil" ][ team ][ 0 ][ key ][ 4 ] = undefined;
            player notify( "player_free_spot" );
            return;
        }
    }
    
    assertmsg( "<dev string:x16f>" );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 2
// Checksum 0x0, Offset: 0x1f24
// Size: 0x23
function get_player_at_spot( team, spot_index )
{
    return game[ "infil" ][ team ][ 0 ][ spot_index ][ 4 ];
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 2
// Checksum 0x0, Offset: 0x1f50
// Size: 0x99
function get_spot_from_player( player, team )
{
    if ( !isdefined( team ) )
    {
        team = player.team;
    }
    
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        return undefined;
    }
    
    foreach ( i, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( isdefined( spot[ 4 ] ) && spot[ 4 ] == player )
        {
            return i;
        }
    }
    
    return undefined;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 2
// Checksum 0x0, Offset: 0x1ff2
// Size: 0x60, Type: bool
function is_spot_taken( team, spot_index )
{
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        assertmsg( "<dev string:x6a>" );
    }
    
    if ( !isdefined( game[ "infil" ][ team ][ 0 ][ spot_index ] ) )
    {
        assertmsg( "<dev string:xa9>" );
    }
    
    return isdefined( game[ "infil" ][ team ][ 0 ][ spot_index ][ 4 ] );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x205b
// Size: 0x90
function get_spot_taken_count( team )
{
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        assertmsg( "<dev string:x1b9>" );
    }
    
    count = 0;
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( is_spot_taken( team, key ) )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x20f4
// Size: 0x14e
function get_spot_by_priority( team )
{
    available_spots = [];
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( !is_spot_taken( team, key ) )
        {
            available_spots[ available_spots.size ] = key;
        }
    }
    
    if ( available_spots.size == 0 )
    {
        return undefined;
    }
    
    force_seat = getdvarint( @"hash_e6526b9ef05103ad", -1 );
    
    if ( array_contains( available_spots, force_seat ) )
    {
        return force_seat;
    }
    
    spots = [];
    bestpriority = -1;
    
    foreach ( spot in available_spots )
    {
        priority = game[ "infil" ][ team ][ 0 ][ spot ][ 3 ];
        
        if ( spots.size == 0 || priority < bestpriority )
        {
            spots = [];
            spots[ spots.size ] = spot;
            bestpriority = priority;
            continue;
        }
        
        if ( priority == bestpriority )
        {
            spots[ spots.size ] = spot;
        }
    }
    
    return spots[ randomint( spots.size ) ];
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x224b
// Size: 0x185
function get_spot_in_lane( team )
{
    while ( !isdefined( self.forcedavailablespawnlocation ) )
    {
        waitframe();
    }
    
    prefix = ter_op( team == "allies", "a", "b" ) + getsubstr( self.forcedavailablespawnlocation, 5, 6 );
    available_spots = [];
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( issubstr( spot[ 1 ].lane, prefix ) && !is_spot_taken( team, key ) )
        {
            available_spots[ available_spots.size ] = key;
        }
    }
    
    if ( available_spots.size == 0 )
    {
        return undefined;
    }
    
    spots = [];
    bestpriority = -1;
    
    foreach ( spot in available_spots )
    {
        priority = game[ "infil" ][ team ][ 0 ][ spot ][ 3 ];
        
        if ( spots.size == 0 || priority < bestpriority )
        {
            spots = [];
            spots[ spots.size ] = spot;
            bestpriority = priority;
            continue;
        }
        
        if ( priority == bestpriority )
        {
            spots[ spots.size ] = spot;
        }
    }
    
    return spots[ randomint( spots.size ) ];
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x23d9
// Size: 0xe1
function get_random_spot( team )
{
    available_spots = [];
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( !is_spot_taken( team, key ) )
        {
            available_spots[ available_spots.size ] = key;
        }
    }
    
    if ( available_spots.size == 0 )
    {
        return undefined;
    }
    
    spot = random( available_spots );
    
    /#
        force_seat = getdvarint( @"hash_e6526b9ef05103ad", -1 );
        
        if ( force_seat == -2 )
        {
            if ( array_contains( available_spots, 0 ) )
            {
                return 0;
            }
            else if ( array_contains( available_spots, 2 ) )
            {
                return 2;
            }
            else
            {
                return spot;
            }
        }
        else if ( array_contains( available_spots, force_seat ) )
        {
            spot = force_seat;
        }
    #/
    
    return spot;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x24c3
// Size: 0x84
function get_taken_spot_count( team )
{
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        return 0;
    }
    
    count = 0;
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( is_spot_taken( team, key ) )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x2550
// Size: 0x94
function get_taken_spot_percent( team )
{
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        return 0;
    }
    
    total = 0;
    count = 0;
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        total++;
        
        if ( is_spot_taken( team, key ) )
        {
            count++;
        }
    }
    
    return count / total;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 2
// Checksum 0x0, Offset: 0x25ed
// Size: 0x9f
function get_random_spot_in_infil( team, infil )
{
    available_spots = [];
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( key[ "infil" ] != infil )
        {
            continue;
        }
        
        if ( !is_spot_taken( team, key ) )
        {
            available_spots[ available_spots.size ] = key;
        }
    }
    
    if ( available_spots.size == 0 )
    {
        return undefined;
    }
    
    spot = random( available_spots );
    return spot;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x2695
// Size: 0x4c
function infil_player_array_handler( player )
{
    self endon( "death" );
    self.players = array_add( self.players, player );
    player waittill( "death_or_disconnect" );
    self.players = array_remove( self.players, player );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x26e9
// Size: 0x139
function player_join_infil()
{
    if ( gameflag( "infil_started" ) )
    {
        return;
    }
    
    if ( game[ "infil" ][ self.team ].size == 0 )
    {
        return;
    }
    
    if ( self ishost() && getdvarint( @"hash_f711f210f6ffd355" ) == 1 )
    {
        player_ai_fill();
        return;
    }
    
    var_ad497b2f2391dfe1 = 0;
    var_47691436552ac69 = game[ "infil" ][ self.team ][ 0 ][ 0 ][ 3 ] != -1;
    
    if ( var_ad497b2f2391dfe1 )
    {
        spot_index = get_spot_taken_count( self.team );
    }
    else if ( var_47691436552ac69 )
    {
        spot_index = get_spot_by_priority( self.team );
    }
    else
    {
        spot_index = get_random_spot( self.team );
    }
    
    if ( !isdefined( spot_index ) )
    {
        return;
    }
    
    spot = player_on_spot( self, spot_index );
    spot[ 1 ] thread infil_player_array_handler( self );
    self notify( "player_added_to_infil" );
    self.infil = spot[ 1 ];
    self thread [[ spot[ 2 ] ]]( spot[ 1 ], spot[ 0 ] );
    self setclientomnvar( "ui_player_in_infil", 1 );
    thread onplayerchangeteams();
    thread clearinfilstateatinfilend();
    player_ai_fill();
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x282a
// Size: 0x3f
function clearinfilstateatinfilend()
{
    self endon( "death_or_disconnect" );
    level waittill( "prematch_done" );
    self setcinematicmotionoverride( "iw9_playermotion" );
    result = 0;
    
    while ( !result )
    {
        result = self setdemeanorviewmodel( "normal" );
        waitframe();
    }
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x2871
// Size: 0x26
function blockswaploadouts()
{
    self endon( "disconnect" );
    self.delayswaploadout = 1;
    level waittill( "prematch_over" );
    self.delayswaploadout = 0;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x289f
// Size: 0xdd
function player_ai_fill()
{
    /#
        if ( self ishost() && getdvarint( @"hash_9d06e62e59d8f04a" ) == 1 )
        {
            var_734654199c0e8131 = level.requiredplayercount[ self.team ] - 1;
            
            if ( getdvarint( @"hash_f711f210f6ffd355" ) == 1 )
            {
                var_734654199c0e8131 = level.requiredplayercount[ self.team ];
            }
            
            if ( var_734654199c0e8131 > 0 )
            {
                level thread [[ level.bot_funcs[ "<dev string:x1f8>" ] ]]( var_734654199c0e8131, self.team );
            }
            
            other_team = getotherteam( self.team )[ 0 ];
            
            if ( level.requiredplayercount[ other_team ] > 0 )
            {
                level thread [[ level.bot_funcs[ "<dev string:x1f8>" ] ]]( level.requiredplayercount[ other_team ], other_team );
            }
        }
    #/
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x2984
// Size: 0x1f5
function infil_setup_ui()
{
    setomnvar( "ui_in_infil", 3 );
    level waittill( "infil_started" );
    ui_always_show_nameplates = getomnvar( "ui_always_show_nameplates" );
    setomnvar( "ui_always_show_nameplates", 1 );
    
    /#
        setdevdvar( @"forcearchetype", 0 );
    #/
    
    if ( !isdefined( level.bypassclasschoicefunc ) )
    {
        setomnvarforallclients( "ui_skip_loadout", 0 );
        level.bypassclasschoicefunc = undefined;
    }
    
    level thread infil_show_countdown();
    cg_drawcrosshair = getdvarint( @"cg_drawcrosshair" );
    cg_drawcrosshairnames = getdvarint( @"cg_drawcrosshairnames" );
    var_c3f949f19ad560e2 = getdvarint( @"hash_721a6fa1822b17d9" );
    setdvar( @"cg_drawcrosshair", 0 );
    setdvar( @"cg_drawcrosshairnames", 1 );
    setdvar( @"hash_721a6fa1822b17d9", 1 );
    level waittill( "prematch_done" );
    var_ae38d1b160669269 = scripts\mp\utility\player::alwaysshowminimap();
    
    foreach ( player in level.players )
    {
        if ( var_ae38d1b160669269 )
        {
            if ( issharedfuncdefined( "player", "showMiniMap" ) )
            {
                player [[ getsharedfunc( "player", "showMiniMap" ) ]]();
            }
            
            continue;
        }
        
        if ( issharedfuncdefined( "player", "hideMiniMap" ) )
        {
            player [[ getsharedfunc( "player", "hideMiniMap" ) ]]();
        }
    }
    
    setomnvar( "ui_in_infil", -1 );
    setomnvar( "ui_always_show_nameplates", ui_always_show_nameplates );
    setdvar( @"cg_drawcrosshair", cg_drawcrosshair );
    setdvar( @"cg_drawcrosshairnames", cg_drawcrosshairnames );
    setdvar( @"hash_721a6fa1822b17d9", var_c3f949f19ad560e2 );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x2b81
// Size: 0x3b
function infil_show_countdown()
{
    waittime = level.prematchperiodend - level.infilenddelay - 5;
    wait waittime;
    setomnvar( "ui_in_infil", 2 );
    level notify( "infil_countdown_show" );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x2bc4
// Size: 0xe0
function alwaysgamemodeclass()
{
    clantag = self getclantag();
    
    if ( clantag == "AR" )
    {
        class = "default1";
    }
    else if ( clantag == "SMG" )
    {
        class = "default2";
    }
    else if ( clantag == "LMG" )
    {
        class = "default3";
    }
    else
    {
        randomloadout = [];
        randomloadout[ 0 ] = "default1";
        randomloadout[ 1 ] = "default2";
        randomloadout[ 2 ] = "default3";
        class = random( randomloadout );
    }
    
    self.pers[ "class" ] = class;
    self.pers[ "lastClass" ] = "";
    self.class = self.pers[ "class" ];
    self.lastclass = self.pers[ "lastClass" ];
    return class;
}

#using_animtree( "script_model" );

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 3
// Checksum 0x0, Offset: 0x2cad
// Size: 0x1ce
function infil_player_rig( animname, rig_model, var_40a4287d8d2e7ef9 )
{
    self.animname = animname;
    player_rig = spawn( "script_model", ( 0, 0, 0 ) );
    player_rig.player = self;
    self.player_rig = player_rig;
    self.player_rig setmodel( rig_model );
    self.player_rig hide();
    self.player_rig.animname = animname;
    self.player_rig useanimtree( #animtree );
    self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
    self.player_rig.cinematic_motion_override = &handlecinematicmotionnotetrack;
    self.player_rig.dof_func = &handledofnotetrack;
    self playerlinktodelta( self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
    println( "<dev string:x206>" + self.name + "<dev string:x233>" + animname + "<dev string:x243>" + isdefined( self.player_rig ) );
    
    if ( isdefined( var_40a4287d8d2e7ef9 ) && var_40a4287d8d2e7ef9 )
    {
        self playersetgroundreferenceent( self.player_rig );
    }
    
    self notify( "rig_created" );
    waittill_any_2( "remove_rig", "player_free_spot" );
    
    if ( isdefined( self ) )
    {
        println( "<dev string:x24e>" + self.name + "<dev string:x233>" + animname + "<dev string:x243>" + isdefined( self.player_rig ) );
        
        if ( isdefined( var_40a4287d8d2e7ef9 ) && var_40a4287d8d2e7ef9 )
        {
            self playersetgroundreferenceent( undefined );
        }
        
        self unlink();
    }
    
    if ( isdefined( player_rig ) )
    {
        player_rig delete();
    }
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 3
// Checksum 0x0, Offset: 0x2e83
// Size: 0x70
function infil_play_sound_func( alias, notification, stoppable )
{
    foreach ( player in self.players )
    {
        player playsoundtoplayer( alias, player );
    }
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x2efb
// Size: 0xd0
function infil_wait_for_players()
{
    level endon( "game_ended" );
    level endon( "force_end" );
    level waittill( "match_start_real_countdown" );
    setomnvar( "ui_in_infil", 1 );
    level.var_2a15d29e8890b785 = 1;
    wait level.infilstartdelay;
    gameflagset( "infil_started" );
    
    if ( getdvarint( @"hash_837a5e61131f5464", 0 ) == 1 )
    {
        level thread manageinteractiveslowmo();
    }
    
    if ( getdvarint( @"hash_f84371d2f3a2a3ac", 0 ) == 1 )
    {
        foreach ( player in level.players )
        {
            iprintlnbold( "!-!-!-!-!-INFIL BEGIN-!-!-!-!-!" );
        }
    }
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x2fd3
// Size: 0x7e
function heli_path( vehicle )
{
    if ( !isdefined( vehicle ) )
    {
        vehicle = self;
        assertex( self.code_classname == "<dev string:x27c>", "<dev string:x28e>" );
    }
    
    vehicle endon( "death" );
    
    if ( isdefined( vehicle.hasstarted ) )
    {
        println( "<dev string:x2b5>" );
        return;
    }
    else
    {
        vehicle.hasstarted = 1;
    }
    
    vehicle script_delay();
    vehicle notify( "start_vehiclepath" );
    vehicle notify( "start_dynamicpath" );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 3
// Checksum 0x0, Offset: 0x3059
// Size: 0x30a
function vehicle_paths_helicopter( node, var_269fb0ec10b51524, var_cfa3aafb71b08d36 )
{
    assertex( isdefined( node ) || isdefined( self.attachedpath ), "<dev string:x2ef>" );
    self notify( "newpath" );
    self endon( "newpath" );
    self endon( "death" );
    
    if ( !isdefined( var_269fb0ec10b51524 ) )
    {
        var_269fb0ec10b51524 = 0;
    }
    
    if ( isdefined( node ) )
    {
        self.attachedpath = node;
    }
    
    pathstart = self.attachedpath;
    self.currentnode = self.attachedpath;
    
    if ( !isdefined( pathstart ) )
    {
        return;
    }
    
    pathpoint = pathstart;
    
    if ( var_269fb0ec10b51524 )
    {
        self waittill( "start_dynamicpath" );
    }
    
    if ( isdefined( var_cfa3aafb71b08d36 ) )
    {
        elevated_node = spawnstruct();
        elevated_node.origin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + var_cfa3aafb71b08d36 );
        heli_wait_node( elevated_node, undefined );
    }
    
    lastpoint = undefined;
    nextpoint = pathstart;
    get_func = get_path_getfunc( pathstart );
    
    while ( isdefined( nextpoint ) )
    {
        if ( isdefined( nextpoint.script_parameters ) )
        {
            readnodeevents( nextpoint );
        }
        
        if ( isdefined( nextpoint.script_linkto ) )
        {
            set_lookat_from_dest( nextpoint );
        }
        
        heli_wait_node( nextpoint, lastpoint, var_cfa3aafb71b08d36 );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.currentnode = nextpoint;
        nextpoint notify( "trigger", self );
        
        if ( isdefined( nextpoint.script_helimove ) )
        {
            self setyawspeedbyname( nextpoint.script_helimove );
            
            if ( nextpoint.script_helimove == "faster" )
            {
                self setmaxpitchroll( 25, 50 );
            }
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( isdefined( nextpoint.script_team ) )
        {
            self.script_team = nextpoint.script_team;
        }
        
        if ( isdefined( nextpoint.script_unload ) )
        {
            self notify( "unload" );
            waittill_notify_or_timeout( "unloaded", self.unload_time );
        }
        
        if ( self vehicle_isphysveh() )
        {
            if ( isdefined( nextpoint.script_pathtype ) )
            {
                self.veh_pathtype = nextpoint.script_pathtype;
            }
        }
        
        if ( isdefined( nextpoint.script_flag_wait ) )
        {
            flag_wait( nextpoint.script_flag_wait );
            
            if ( isdefined( nextpoint.script_delay_post ) )
            {
                wait nextpoint.script_delay_post;
            }
            
            self notify( "delay_passed" );
        }
        
        if ( isdefined( self.set_lookat_point ) )
        {
            self.set_lookat_point = undefined;
            self clearlookatent();
        }
        
        lastpoint = nextpoint;
        
        if ( !isdefined( nextpoint.target ) )
        {
            break;
        }
        
        nextpoint = [[ get_func ]]( nextpoint.target );
        
        if ( !isdefined( nextpoint ) )
        {
            nextpoint = lastpoint;
            assertmsg( "<dev string:x317>" + lastpoint.origin );
            break;
        }
    }
    
    self notify( "reached_dynamic_path_end" );
    
    if ( isdefined( self.script_vehicle_selfremove ) )
    {
        self delete();
    }
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 3
// Checksum 0x0, Offset: 0x336b
// Size: 0x48f
function heli_wait_node( nextpoint, lastpoint, var_cfa3aafb71b08d36 )
{
    self endon( "newpath" );
    
    if ( isdefined( nextpoint.script_unload ) || isdefined( nextpoint.script_land ) )
    {
        unloadoffset = 0;
        
        if ( isdefined( nextpoint.script_land ) )
        {
            ent_flag_set( "landed" );
            
            if ( isdefined( self.unload_land_offset ) )
            {
                unloadoffset = self.unload_land_offset;
            }
        }
        else if ( isdefined( nextpoint.script_unload ) && isdefined( self.unload_hover_offset ) )
        {
            unloadoffset = self.unload_hover_offset;
        }
        else if ( isdefined( nextpoint.script_unload ) && isdefined( self.unload_hover_offset_max ) )
        {
            groundorg = utility::groundpos( nextpoint.origin );
            unloadoffset = nextpoint.origin[ 2 ] - groundorg[ 2 ];
            
            if ( unloadoffset >= self.unload_hover_offset_max )
            {
                unloadoffset = self.unload_hover_offset_max;
            }
            else if ( isdefined( self.unload_hover_land_height ) && unloadoffset < self.unload_hover_land_height )
            {
                unloadoffset = self.unload_hover_land_height;
            }
        }
        
        nextpoint.radius = 2;
        
        if ( isdefined( nextpoint.ground_pos ) )
        {
            nextpoint.origin = nextpoint.ground_pos + ( 0, 0, unloadoffset );
        }
        else
        {
            neworg = utility::groundpos( nextpoint.origin ) + ( 0, 0, unloadoffset );
            
            if ( neworg[ 2 ] > nextpoint.origin[ 2 ] - 2000 )
            {
                nextpoint.origin = utility::groundpos( nextpoint.origin ) + ( 0, 0, unloadoffset );
            }
        }
        
        self sethoverparams( 0, 0, 0 );
    }
    
    if ( isdefined( lastpoint ) )
    {
        airresistance = lastpoint.script_airresistance;
        speed = lastpoint.speed;
        accel = lastpoint.script_accel;
        decel = lastpoint.script_decel;
    }
    else
    {
        airresistance = undefined;
        speed = undefined;
        accel = undefined;
        decel = undefined;
    }
    
    stopnode = isdefined( nextpoint.script_stopnode ) && nextpoint.script_stopnode;
    unload = isdefined( nextpoint.script_unload );
    flag_wait = isdefined( nextpoint.script_flag_wait ) && !flag( nextpoint.script_flag_wait );
    var_ccf44cff39a902f0 = !isdefined( nextpoint.target );
    hasdelay = isdefined( nextpoint.script_delay );
    
    if ( isdefined( nextpoint.angles ) )
    {
        yaw = nextpoint.angles[ 1 ];
    }
    else
    {
        yaw = 0;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    origin = nextpoint.origin;
    
    if ( isdefined( var_cfa3aafb71b08d36 ) )
    {
        origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] + var_cfa3aafb71b08d36 );
    }
    
    if ( isdefined( self.heliheightoverride ) )
    {
        origin = ( origin[ 0 ], origin[ 1 ], self.heliheightoverride );
    }
    
    self vehicle_helisetai( origin, speed, accel, decel, nextpoint.script_goalyaw, nextpoint.script_anglevehicle, yaw, airresistance, hasdelay, stopnode, unload, flag_wait, var_ccf44cff39a902f0 );
    
    if ( isdefined( nextpoint.radius ) )
    {
        self setneargoalnotifydist( nextpoint.radius );
        assertex( nextpoint.radius > 0, "<dev string:x36e>" + nextpoint.radius );
        waittill_any_2( "near_goal", "goal" );
    }
    else
    {
        self waittill( "goal" );
    }
    
    /#
        if ( isdefined( nextpoint.script_flag_set ) )
        {
            self notify( "<dev string:x37a>", nextpoint, nextpoint.script_flag_set );
        }
        else
        {
            self notify( "<dev string:x37a>", nextpoint );
        }
    #/
    
    if ( isdefined( nextpoint.script_firelink ) )
    {
        if ( !isdefined( level.helicopter_firelinkfunk ) )
        {
            assertmsg( "<dev string:x392>" );
        }
        
        thread [[ level.helicopter_firelinkfunk ]]( nextpoint );
    }
    
    nextpoint script_delay();
    
    if ( isdefined( self.path_gobbler ) )
    {
        deletestruct_ref( nextpoint );
    }
    
    self notify( "continuepath" );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x3802
// Size: 0x64
function get_path_getfunc( pathpoint )
{
    get_func = &get_from_vehicle_node;
    
    if ( isdefined( pathpoint.target ) )
    {
        if ( isdefined( get_from_entity( pathpoint.target ) ) )
        {
            get_func = &get_from_entity;
        }
        
        if ( isdefined( get_from_spawnstruct( pathpoint.target ) ) )
        {
            get_func = &get_from_spawnstruct;
        }
    }
    
    return get_func;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x386f
// Size: 0x16
function get_from_vehicle_node( target )
{
    return getvehiclenode( target, "targetname" );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x388e
// Size: 0xac
function get_from_spawnstruct( target )
{
    array = getstructarray( target, "targetname" );
    
    if ( array.size == 1 )
    {
        return array[ 0 ];
    }
    
    foreach ( element in array )
    {
        if ( isdefined( element.poi ) && isdefined( self.poi ) && element.poi == self.poi )
        {
            return element;
        }
    }
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x3942
// Size: 0x3a
function get_from_entity( target )
{
    ent = getentarray( target, "targetname" );
    
    if ( isdefined( ent ) && ent.size > 0 )
    {
        return ent[ randomint( ent.size ) ];
    }
    
    return undefined;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x3985
// Size: 0x45
function set_lookat_from_dest( dest )
{
    viewtarget = getent( dest.script_linkto, "script_linkname" );
    
    if ( !isdefined( viewtarget ) )
    {
        return;
    }
    
    self setlookatent( viewtarget );
    self.set_lookat_point = 1;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x39d2
// Size: 0x13d
function parsehelipathlength()
{
    if ( !isdefined( self.path ) )
    {
        return 0;
    }
    
    if ( isdefined( self.pathduration ) )
    {
        return self.pathduration;
    }
    
    self.pathduration = 0;
    node = self.path;
    speed = node.speed;
    
    while ( true )
    {
        if ( isdefined( node.script_unload ) )
        {
            break;
        }
        
        if ( !isdefined( node.target ) )
        {
            break;
        }
        
        next = getstruct( node.target, "targetname" );
        
        if ( !isdefined( next ) )
        {
            break;
        }
        
        var_9eb9e52b1dcd019d = distance( node.origin, next.origin );
        
        if ( isdefined( node.speed ) )
        {
            speed = node.speed;
        }
        
        conversion = 17.6;
        var_5df47f4f5b20f4ce = 1.1;
        self.pathduration += var_9eb9e52b1dcd019d * var_5df47f4f5b20f4ce / speed * conversion;
        node = next;
    }
    
    return self.pathduration;
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x3b18
// Size: 0xa6
function readnodeevents( node )
{
    events = strtok( node.script_parameters, "," );
    
    foreach ( event in events )
    {
        pair = strtok( event, ":" );
        
        if ( !isdefined( pair ) )
        {
            return;
        }
        
        if ( pair.size != 2 )
        {
            return;
        }
        
        thread processtimelineevent( pair[ 0 ], float( pair[ 1 ] ) );
    }
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 2
// Checksum 0x0, Offset: 0x3bc6
// Size: 0x193
function processtimelineevent( event, delay )
{
    if ( !isdefined( self.timelineevents ) )
    {
        self.timelineevents = [];
    }
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    switch ( event )
    {
        case #"hash_87e3c1c2828708e4":
            self.timelineevents[ "shake" ] = "low";
            
            foreach ( player in self.infil.players )
            {
                cam_shake_low( player );
            }
            
            break;
        case #"hash_807169c27e9de95b":
            self.timelineevents[ "shake" ] = "off";
            
            foreach ( player in self.infil.players )
            {
                cam_shake_off( player );
            }
            
            break;
        case #"hash_6530846d1804e962":
            self.infil notify( "event_intro" );
            break;
        case #"hash_75fef6e5f328c5ba":
            self.infil notify( "event_shootingWindow_open" );
            break;
        case #"hash_a92b19adca4b2fbe":
            self.infil notify( "event_shootingWindow_closed" );
            break;
    }
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x3d61
// Size: 0x54
function manageinteractiveslowmo()
{
    if ( !isdefined( level.interactiveinfilstart ) || !isdefined( level.interactiveinfilwindow ) )
    {
        return;
    }
    
    wait level.interactiveinfilstart;
    setslowmotion( 1, 0.5, 1 );
    wait level.interactiveinfilwindow;
    setslowmotion( 0.5, 1, 0.5 );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x3dbd
// Size: 0x2e
function waitandunloadinfils()
{
    gameflagwait( "prematch_done" );
    
    while ( level.infilsactive != 0 )
    {
        waitframe();
    }
    
    unloadallinfilintrotransients();
    level notify( "unload_audio_soundbank" );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 0
// Checksum 0x0, Offset: 0x3df3
// Size: 0xa
function function_3c075bf6eade7262()
{
    level waittill( "unload_audio_soundbank" );
}

/#

    // Namespace infilexfil / scripts\mp\infilexfil\infilexfil
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x3e05
    // Size: 0x7b, Type: dev
    function private function_8bce6c2b9dfce133()
    {
        while ( true )
        {
            if ( getdvar( @"hash_c022d48104ba5fe6", "<dev string:x3df>" ) != "<dev string:x3df>" )
            {
                setdvar( @"hash_c022d48104ba5fe6", "<dev string:x3df>" );
                infilname = getdvar( @"hash_c022d48104ba5fe6", "<dev string:x3df>" );
                setdvar( @"hash_1f7e93431ff79c39", infilname );
                function_2445244fc2466b13( "<dev string:x31>" );
            }
            
            wait 2;
        }
    }

    // Namespace infilexfil / scripts\mp\infilexfil\infilexfil
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x3e88
    // Size: 0x7b, Type: dev
    function private function_dea41b0700c91408()
    {
        while ( true )
        {
            if ( getdvar( @"hash_f6c08131f5dddab9", "<dev string:x3df>" ) != "<dev string:x3df>" )
            {
                setdvar( @"hash_f6c08131f5dddab9", "<dev string:x3df>" );
                infilname = getdvar( @"hash_f6c08131f5dddab9", "<dev string:x3df>" );
                setdvar( @"hash_4c2539684478a68e", infilname );
                function_2445244fc2466b13( "<dev string:x27>" );
            }
            
            wait 2;
        }
    }

    // Namespace infilexfil / scripts\mp\infilexfil\infilexfil
    // Params 1, eflags: 0x4
    // Checksum 0x0, Offset: 0x3f0b
    // Size: 0x6c, Type: dev
    function private function_2445244fc2466b13( team )
    {
        setdvar( @"scr_force_team", team );
        setdvar( @"scr_game_infilskip", 0 );
        setdvar( @"hash_c653d32c30815d2b", 15 );
        setdvar( @"scr_game_matchstarttime", 15 );
        setdvar( @"hash_9d06e62e59d8f04a", 1 );
        wait 1;
        map_restart( 1 );
    }

    // Namespace infilexfil / scripts\mp\infilexfil\infilexfil
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x3f7f
    // Size: 0x68, Type: dev
    function private function_5761b0a20863c59e()
    {
        level endon( "<dev string:x3e3>" );
        level endon( "<dev string:x3f9>" );
        level.var_61d21e3699d0f0bc = 0;
        
        while ( level.var_61d21e3699d0f0bc == 0 )
        {
            if ( getdvarint( @"hash_d8f31feda870cbf8", 0 ) == 1 && level.var_61d21e3699d0f0bc == 0 )
            {
                level.var_61d21e3699d0f0bc = 1;
                level thread infildebugmode();
                return;
            }
            
            waitframe();
        }
    }

    // Namespace infilexfil / scripts\mp\infilexfil\infilexfil
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x3fef
    // Size: 0x1bf, Type: dev
    function private infildebugmode()
    {
        level notify( "<dev string:x3e3>" );
        level endon( "<dev string:x407>" );
        iprintlnbold( "<dev string:x41a>" );
        level.var_e6fbdd8917189dfb = 0;
        level.var_114dd6baa6068929 = 0;
        setdvar( @"scr_game_infilskip", 0 );
        setdvar( @"hash_c653d32c30815d2b", 15 );
        setdvar( @"scr_game_matchstarttime", 15 );
        hostplayer = scripts\mp\gamelogic::gethostplayer();
        
        if ( !isdefined( hostplayer ) )
        {
            return;
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_8f57a5a96fe91b32", 1 ) == 0 )
            {
                function_dc2f945aa7bdd07a();
            }
            else if ( hostplayer buttonpressed( "<dev string:x434>" ) )
            {
                setdvar( @"scr_game_infilskip", 0 );
                setdvar( @"hash_c653d32c30815d2b", 15 );
                setdvar( @"scr_game_matchstarttime", 15 );
                iprintlnbold( "<dev string:x441>" );
                wait 1;
                map_restart();
            }
            else if ( hostplayer buttonpressed( "<dev string:x45a>" ) )
            {
                level.var_e6fbdd8917189dfb = !level.var_e6fbdd8917189dfb;
                
                if ( level.var_e6fbdd8917189dfb == 1 )
                {
                    iprintlnbold( "<dev string:x468>" );
                }
                else
                {
                    iprintlnbold( "<dev string:x482>" );
                }
                
                wait 1;
            }
            else if ( hostplayer buttonpressed( "<dev string:x49d>" ) )
            {
                level.var_114dd6baa6068929 = !level.var_114dd6baa6068929;
                
                if ( level.var_114dd6baa6068929 == 1 )
                {
                    setdvar( @"hash_f711f210f6ffd355", 1 );
                    iprintlnbold( "<dev string:x4a8>" );
                }
                else
                {
                    setdvar( @"hash_f711f210f6ffd355", 0 );
                    iprintlnbold( "<dev string:x4c4>" );
                }
                
                hostplayer noclip();
                wait 1;
            }
            
            waitframe();
        }
    }

    // Namespace infilexfil / scripts\mp\infilexfil\infilexfil
    // Params 0, eflags: 0x4
    // Checksum 0x0, Offset: 0x41b6
    // Size: 0x18, Type: dev
    function private function_dc2f945aa7bdd07a()
    {
        level notify( "<dev string:x407>" );
        iprintlnbold( "<dev string:x4e1>" );
    }

#/

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 1
// Checksum 0x0, Offset: 0x41d6
// Size: 0x1b
function function_d41cba513a03d958( waittime )
{
    self endon( "death_or_disconnect" );
    wait waittime;
    scripts\mp\class::blockclasschange();
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 5
// Checksum 0x0, Offset: 0x41f9
// Size: 0xf4
function function_4dca5340dfd36c76( scene_node, vehicle, waittime, animname, infil_type )
{
    if ( !isdefined( scene_node ) || !isdefined( scene_node.target ) )
    {
        /#
            iprintlnbold( "<dev string:x4f6>" );
        #/
        
        return;
    }
    
    destructibleversion = getentarray( scene_node.target, "targetname" );
    temporigin = scene_node.origin;
    tempangle = scene_node.angles;
    
    if ( !isdefined( destructibleversion[ 0 ] ) )
    {
        /#
            iprintlnbold( "<dev string:x509>" );
        #/
        
        return;
    }
    
    destructibleversion[ 0 ].canmove = 1;
    destructibleversion[ 0 ] setscriptablepartstate( "visibility", "hide", 1 );
    wait waittime;
    vehicle delete();
    destructibleversion[ 0 ] setscriptablepartstate( "visibility", "show" );
}

// Namespace infilexfil / scripts\mp\infilexfil\infilexfil
// Params 6
// Checksum 0x0, Offset: 0x42f5
// Size: 0xc6
function function_51293c8505f2ea4e( scene_node, vehicle_one, vehicle_two, waittime, animname, infil_type )
{
    if ( !isdefined( scene_node ) || !isdefined( scene_node.target ) )
    {
        /#
            iprintlnbold( "<dev string:x4f6>" );
        #/
        
        return;
    }
    
    staticversion = getentarray( scene_node.target, "targetname" );
    
    if ( !isdefined( staticversion[ 0 ] ) )
    {
        /#
            iprintlnbold( "<dev string:x509>" );
        #/
        
        return;
    }
    
    staticversion[ 0 ] hide();
    staticversion[ 1 ] hide();
    wait waittime;
    vehicle_one delete();
    vehicle_two delete();
    staticversion[ 0 ] show();
    staticversion[ 1 ] show();
}

