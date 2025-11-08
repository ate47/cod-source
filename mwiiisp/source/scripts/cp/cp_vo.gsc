#using scripts\common\utility;
#using scripts\cp\cp_vo;
#using scripts\cp\utility;
#using scripts\engine\utility;

#namespace cp_vo;

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x207
// Size: 0x8d
function function_83b8144a47850cdd()
{
    level.vo_priority_level = [ "highest", "high", "medium", "low" ];
    level.vo_alias_data = [];
    level.vo_categories = [];
    level.vo_category_last_played_time = [];
    level.vo_dialogue_prefix = [];
    level.vo_table = "cp/" + getdvar( @"ui_mapname" ) + "_vo_table.csv";
    level thread parse_vo_table();
    level thread nag_vo_handler();
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x29c
// Size: 0x1a
function function_36bcbfd3365dc368()
{
    init_vo_system();
    thread start_vo_system();
    level thread game_ended_vo_watcher();
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x2be
// Size: 0xbf
function init_vo_system()
{
    vo_system = spawnstruct();
    vo_system.vo_currently_playing = undefined;
    vo_system.interrupt_vo = undefined;
    vo_system.is_playing = 0;
    vo_queue = [];
    
    if ( isdefined( level.vo_priority_level ) )
    {
        foreach ( priority_level in level.vo_priority_level )
        {
            vo_queue[ priority_level ] = [];
        }
    }
    
    vo_system.vo_queue = vo_queue;
    self.vo_system = vo_system;
    flag_init( "vo_system_busy" );
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x385
// Size: 0x1dd
function parse_vo_table()
{
    table = level.vo_table;
    row = 0;
    
    if ( !tableexists( table ) )
    {
        return;
    }
    
    while ( true )
    {
        id = tablelookupbyrow( table, row, 0 );
        
        if ( id == "" )
        {
            break;
        }
        
        alias_name = tablelookupbyrow( table, row, 1 );
        cooldown = int( tablelookupbyrow( table, row, 2 ) );
        chance_to_play = int( tablelookupbyrow( table, row, 3 ) );
        max_plays = int( tablelookupbyrow( table, row, 4 ) );
        category_1 = tablelookupbyrow( table, row, 5 );
        category_2 = tablelookupbyrow( table, row, 6 );
        waittillnotifyorflag = tablelookupbyrow( table, row, 7 );
        dialogueprefix = tablelookupbyrow( table, row, 8 );
        var_79ade81a56cbf98b = tablelookupbyrow( table, row, 9 );
        onlylocal = int( tablelookupbyrow( table, row, 10 ) );
        timeout = int( tablelookupbyrow( table, row, 11 ) );
        priority = tablelookupbyrow( table, row, 12 );
        var_4c576d2cfbdbe34 = int( tablelookupbyrow( table, row, 13 ) );
        missingstub = tablelookupbyrow( table, row, 15 );
        register_vo( id, alias_name, cooldown, chance_to_play, max_plays, category_1, category_2, waittillnotifyorflag, dialogueprefix, var_79ade81a56cbf98b, onlylocal, timeout, priority, var_4c576d2cfbdbe34, missingstub );
        
        if ( row % 5 == 1 )
        {
            wait 0.05;
        }
        
        row++;
    }
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 15
// Checksum 0x0, Offset: 0x56a
// Size: 0x2f2
function register_vo( id, alias_name, cooldown, chance_to_play, max_plays, category_1, category_2, waittillnotifyorflag, dialogueprefix, nextdialogue, onlylocal, timeout, priority, pause_time, missingstub )
{
    struct = spawnstruct();
    
    if ( isdefined( cooldown ) && cooldown > 0 )
    {
        struct.cooldown = cooldown;
        struct.lastplayedtime = 0;
    }
    
    if ( isdefined( missingstub ) )
    {
        struct.missingstub = missingstub;
    }
    
    if ( isdefined( pause_time ) && pause_time > 0 )
    {
        struct.pause_time = pause_time;
    }
    
    if ( istrue( onlylocal ) )
    {
        struct.onlylocal = 1;
    }
    else
    {
        struct.onlylocal = 0;
    }
    
    if ( isdefined( timeout ) && timeout > 0 )
    {
        struct.timeout = timeout;
    }
    
    if ( isdefined( priority ) )
    {
        struct.priority = priority;
    }
    
    if ( isdefined( max_plays ) && max_plays > 0 )
    {
        struct.max_plays = max_plays;
    }
    
    if ( isdefined( chance_to_play ) && chance_to_play > 0 )
    {
        struct.chance_to_play = chance_to_play;
    }
    
    if ( isdefined( waittillnotifyorflag ) && waittillnotifyorflag != "" )
    {
        struct.waittillnotifyorflag = waittillnotifyorflag;
    }
    
    if ( isdefined( category_1 ) && category_1 != "" )
    {
        if ( !isdefined( level.vo_categories[ category_1 ] ) )
        {
            level.vo_categories[ category_1 ] = [];
        }
        
        struct.category_1 = category_1;
        level.vo_categories[ category_1 ][ level.vo_categories[ category_1 ].size ] = alias_name;
        
        if ( !isdefined( level.vo_category_last_played_time[ category_1 ] ) )
        {
            level.vo_category_last_played_time[ category_1 ] = 0;
        }
    }
    
    if ( isdefined( category_2 ) && category_2 != "" )
    {
        if ( !isdefined( level.vo_categories[ category_2 ] ) )
        {
            level.vo_categories[ category_2 ] = [];
        }
        
        struct.category_2 = category_2;
        level.vo_categories[ category_2 ][ level.vo_categories[ category_2 ].size ] = alias_name;
        
        if ( !isdefined( level.vo_category_last_played_time[ category_2 ] ) )
        {
            level.vo_category_last_played_time[ category_2 ] = 0;
        }
    }
    
    if ( isdefined( dialogueprefix ) && dialogueprefix != "" )
    {
        if ( !isdefined( level.vo_dialogue_prefix[ dialogueprefix ] ) )
        {
            level.vo_dialogue_prefix[ dialogueprefix ] = [];
        }
        
        struct.dialogueprefix = dialogueprefix;
        level.vo_dialogue_prefix[ alias_name ] = dialogueprefix;
    }
    
    if ( isdefined( nextdialogue ) && nextdialogue != "" )
    {
        struct.nextdialogue = nextdialogue;
    }
    
    level.vo_alias_data[ alias_name ] = struct;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x864
// Size: 0x7d
function start_vo_system()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    while ( true )
    {
        if ( is_vo_system_busy() )
        {
            if ( flag_exist( "vo_system_busy" ) )
            {
                flag_waitopen( "vo_system_busy" );
            }
        }
        
        vo_to_play = get_vo_to_play();
        
        if ( !isdefined( vo_to_play ) )
        {
            set_vo_system_playing( 0 );
            self waittill( "play_VO_system" );
            
            if ( is_vo_system_paused() )
            {
                self waittill( "unpause_VO_system" );
            }
            
            continue;
        }
        
        play_vo_system( vo_to_play );
    }
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0x8e9
// Size: 0x3a
function play_vo_system( vo_to_play )
{
    self endon( "disconnect" );
    set_vo_system_playing( 1 );
    set_vo_currently_playing( vo_to_play );
    play_vo( vo_to_play );
    pause_between_vo( vo_to_play );
    unset_vo_currently_playing();
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x92b
// Size: 0x81
function get_vo_to_play()
{
    vo_to_play = retrieve_interrupt_vo();
    
    if ( isdefined( vo_to_play ) )
    {
        return vo_to_play;
    }
    
    if ( isdefined( level.vo_priority_level ) )
    {
        foreach ( priority_level in level.vo_priority_level )
        {
            vo_to_play = retrieve_vo_from_queue( priority_level );
            
            if ( isdefined( vo_to_play ) )
            {
                return vo_to_play;
            }
        }
    }
    
    return undefined;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x9b5
// Size: 0x28
function retrieve_interrupt_vo()
{
    interrupt_vo = self.vo_system.interrupt_vo;
    reset_interrupt_vo();
    return interrupt_vo;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x9e6
// Size: 0x15
function reset_interrupt_vo()
{
    self.vo_system.interrupt_vo = undefined;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0xa03
// Size: 0x1a
function retrieve_vo_from_queue( priority )
{
    remove_expired_vo_from_queue( priority );
    return pop_first_vo_out_of_queue( priority );
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0xa26
// Size: 0xc2
function pop_first_vo_out_of_queue( priority )
{
    first_vo = self.vo_system.vo_queue[ priority ][ 0 ];
    
    if ( !isdefined( first_vo ) )
    {
        return first_vo;
    }
    
    new_array = [];
    
    for ( array_index = 1; array_index < self.vo_system.vo_queue[ priority ].size ; array_index++ )
    {
        if ( !isdefined( self.vo_system.vo_queue[ priority ][ array_index ] ) )
        {
            break;
        }
        
        new_array[ array_index - 1 ] = self.vo_system.vo_queue[ priority ][ array_index ];
    }
    
    self.vo_system.vo_queue[ priority ] = new_array;
    return first_vo;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0xaf1
// Size: 0xdd
function remove_expired_vo_from_queue( priority )
{
    current_time = gettime();
    new_array = [];
    
    foreach ( vo_data in self.vo_system.vo_queue[ priority ] )
    {
        if ( !vo_expired( vo_data, current_time ) )
        {
            new_array[ new_array.size ] = self.vo_system.vo_queue[ priority ][ array_index ];
            continue;
        }
        
        println( "<dev string:x1c>" + vo_data.alias + "<dev string:x36>" );
    }
    
    self.vo_system.vo_queue[ priority ] = new_array;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 2
// Checksum 0x0, Offset: 0xbd6
// Size: 0x20, Type: bool
function vo_expired( vo_data, current_time )
{
    return current_time > vo_data.expire_time;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0xbff
// Size: 0x39
function set_vo_system_playing( bool )
{
    if ( !isplayer( self ) || !isdefined( self.vo_system ) )
    {
        return;
    }
    
    self.vo_system.is_playing = bool;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0xc40
// Size: 0xc, Type: bool
function is_vo_system_paused()
{
    return istrue( self.pause_vo_system );
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0xc55
// Size: 0xd
function is_vo_system_busy()
{
    return flag( "vo_system_busy" );
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0xc6b
// Size: 0x34
function set_vo_system_busy( bool )
{
    level.vo_system_busy = bool;
    
    if ( !bool )
    {
        flag_clear( "vo_system_busy" );
        return;
    }
    
    flag_set( "vo_system_busy" );
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0xca7
// Size: 0x20
function set_vo_currently_playing( vo_to_play )
{
    self.vo_system.vo_currently_playing = vo_to_play;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0xccf
// Size: 0x43d
function game_ended_vo_watcher()
{
    alias_append = "";
    level waittill( "game_ended" );
    
    foreach ( player in level.players )
    {
        foreach ( priority_level in level.vo_priority_level )
        {
            if ( isdefined( player.vo_system.vo_queue[ priority_level ] ) && player.vo_system.vo_queue[ priority_level ].size > 0 )
            {
                foreach ( vo_data in player.vo_system.vo_queue[ priority_level ] )
                {
                    if ( isdefined( vo_data ) )
                    {
                        if ( soundexists( vo_data.alias ) )
                        {
                            player stoplocalsound( vo_data.alias );
                        }
                    }
                }
                
                player.vo_system.vo_queue[ priority_level ] = [];
            }
        }
        
        if ( isdefined( level.dialogue_arr ) && level.dialogue_arr.size > 0 )
        {
            foreach ( alias in level.dialogue_arr )
            {
                if ( issubstr( alias, "pg_" ) )
                {
                    player stoplocalsound( alias );
                }
                
                if ( soundexists( player.vo_prefix + alias ) )
                {
                    player stoplocalsound( player.vo_prefix + alias );
                }
                
                if ( soundexists( player.vo_prefix + "plr_" + alias ) )
                {
                    player stoplocalsound( player.vo_prefix + "plr_" + alias );
                }
            }
        }
        
        if ( isdefined( player.current_vo_queue ) && player.current_vo_queue.size > 0 )
        {
            foreach ( element in player.current_vo_queue )
            {
                if ( isdefined( element ) )
                {
                    if ( soundexists( element ) )
                    {
                        player stoplocalsound( element );
                        continue;
                    }
                    
                    if ( soundexists( player.vo_prefix + element ) )
                    {
                        player stoplocalsound( player.vo_prefix + element );
                        continue;
                    }
                    
                    if ( soundexists( player.vo_prefix + "plr_" + element ) )
                    {
                        player stoplocalsound( player.vo_prefix + "plr_" + element );
                    }
                }
            }
        }
        
        if ( !isdefined( player.vo_prefix ) )
        {
            return;
        }
        
        switch ( player.vo_prefix )
        {
            case #"hash_8a36186c5286bc5f":
                alias_append = "_valley_girl";
                break;
            case #"hash_8a33186c52847dc8":
                alias_append = "_nerd";
                break;
            case #"hash_8a30586c5282a3f1":
                alias_append = "_rapper";
                break;
            case #"hash_8a2d586c5280655a":
                alias_append = "_jock";
                break;
            case #"hash_8a2a186c527dc203":
                alias_append = "_jock";
                break;
        }
        
        var_aca2e0282cbd3cfe = "mus_zombies" + alias_append;
        
        if ( soundexists( var_aca2e0282cbd3cfe ) )
        {
            player stoplocalsound( "mus_zombies" + alias_append );
        }
        
        var_aca2e0282cbd3cfe = "mus_zombies" + alias_append + "_lsrs";
        
        if ( soundexists( var_aca2e0282cbd3cfe ) )
        {
            player stoplocalsound( "mus_zombies" + alias_append + "_lsrs" );
        }
    }
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0x1114
// Size: 0x2d5
function play_vo( vo_to_play )
{
    self endon( "interrupt_current_VO" );
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "disconnect" );
    
    if ( self.sessionstate != "playing" )
    {
        return;
    }
    
    alias = vo_to_play.alias;
    
    if ( !soundexists( alias ) )
    {
        if ( isdefined( level.vo_alias_data[ alias ] ) && isdefined( "level.vo_alias_data[alias].missingStub" ) )
        {
            /#
                iprintln( level.vo_alias_data[ alias ].missingstub );
            #/
        }
        else
        {
            /#
                iprintln( "<dev string:x4b>" + alias );
            #/
        }
        
        wait 0.1;
        return;
    }
    
    self.vo_system_playing_vo = 1;
    
    if ( is_playing_pain_breathing_sfx( self ) )
    {
        pain_breathing_sfx_alias = get_pain_breathing_sfx_alias( self );
        
        if ( isdefined( pain_breathing_sfx_alias ) )
        {
            self stoplocalsound( pain_breathing_sfx_alias );
        }
    }
    
    println( "<dev string:x57>" + alias );
    
    if ( isdefined( vo_to_play.basealias ) )
    {
        var_e77296b7f0ba0679 = vo_to_play.basealias;
    }
    else
    {
        var_e77296b7f0ba0679 = alias;
    }
    
    foreach ( player in level.players )
    {
        if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
        {
            continue;
        }
        
        if ( isdefined( player.current_vo_queue ) )
        {
            player.current_vo_queue = array_add( player.current_vo_queue, var_e77296b7f0ba0679 );
        }
        
        if ( player == self )
        {
            if ( isdefined( level.get_alias_2d_func ) )
            {
                alias_2d = [[ level.get_alias_2d_func ]]( player, alias, var_e77296b7f0ba0679 );
            }
            else
            {
                alias_2d = get_alias_2d_version( player, alias, var_e77296b7f0ba0679 );
            }
            
            if ( isdefined( alias_2d ) )
            {
                player playlocalsound_safe( alias_2d );
            }
            else
            {
                player playlocalsound_safe( alias );
            }
            
            continue;
        }
        
        if ( !istrue( vo_to_play.only_local ) && soundexists( alias ) )
        {
            self playsoundtoplayer( alias, player );
        }
    }
    
    foreach ( category in vo_to_play.categories )
    {
        level.vo_category_last_played_time[ category ] = gettime();
    }
    
    if ( !isdefined( self.num_of_plays[ var_e77296b7f0ba0679 ] ) )
    {
        self.num_of_plays[ var_e77296b7f0ba0679 ] = 1;
    }
    else
    {
        self.num_of_plays[ var_e77296b7f0ba0679 ]++;
    }
    
    wait scripts\cp\cp_vo::get_sound_length( alias );
    self.vo_system_playing_vo = 0;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 2
// Checksum 0x0, Offset: 0x13f1
// Size: 0x2c
function alias_2d_version_exists( player, alias )
{
    alias_2d_version = get_alias_2d_version( player, alias );
    return soundexists( alias_2d_version );
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 3
// Checksum 0x0, Offset: 0x1426
// Size: 0xa2
function get_alias_2d_version( player, alias, base_alias )
{
    alias_array = strtok( alias, "_" );
    
    if ( alias_array[ 0 ] == "ww" || alias_array[ 0 ] == "dj" || alias_array[ 0 ] == "ks" )
    {
        return alias;
    }
    
    if ( isdefined( player.vo_prefix ) )
    {
        new_alias = player.vo_prefix + "plr_" + base_alias;
    }
    else
    {
        new_alias = "plr_" + base_alias;
    }
    
    if ( soundexists( new_alias ) )
    {
        return new_alias;
    }
    
    return undefined;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 2
// Checksum 0x0, Offset: 0x14d0
// Size: 0xa7
function get_alias_3d_version( player, alias )
{
    if ( issubstr( alias, "ww_" ) || issubstr( alias, "dj_" ) || issubstr( alias, "p1_" ) || issubstr( alias, "p2_" ) || issubstr( alias, "p3_" ) || issubstr( alias, "p4_" ) || issubstr( alias, "jaroslav_anc" ) )
    {
        return alias;
    }
    
    var_d76b0a8e2967c78d = getsubstr( alias, player.vo_prefix.size );
    return player.vo_prefix + var_d76b0a8e2967c78d;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0x1580
// Size: 0x7d
function get_sound_length( alias )
{
    if ( !soundexists( alias ) )
    {
        return 0;
    }
    
    var_e9adc33e7669585 = lookupsoundlength( alias ) / 1000 + 0.4;
    
    if ( getdvarint( @"loc_language" ) != 0 && getdvarint( @"loc_language" ) != 1 )
    {
        var_e9adc33e7669585 += 1.5;
    }
    
    lookup_len = get_length_from_table( alias );
    
    if ( isdefined( lookup_len ) )
    {
        var_e9adc33e7669585 = lookup_len;
    }
    
    return var_e9adc33e7669585;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0x1606
// Size: 0x38
function pause_between_vo( vo_to_play )
{
    if ( is_vo_system_paused() )
    {
        self waittill( "unpause_VO_system" );
    }
    
    if ( vo_to_play.pause_time > 0 )
    {
        wait vo_to_play.pause_time;
    }
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x1646
// Size: 0x15
function unset_vo_currently_playing()
{
    self.vo_system.vo_currently_playing = undefined;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 5
// Checksum 0x0, Offset: 0x1663
// Size: 0x181
function try_to_play_vo_on_team( alias, team, is_nag, nag_cooldown, var_e2ce4e21e9100cb9 )
{
    players = getplayersinteam( team );
    
    if ( !isdefined( alias ) )
    {
        return;
    }
    
    if ( players.size <= 0 )
    {
        return;
    }
    
    if ( !istrue( is_nag ) )
    {
        level.isteamvoplaying = 1;
        
        if ( isplayer( self ) || self == level || !isent( self ) )
        {
            foreach ( player in players )
            {
                player thread play_cp_comment_vo( alias, "cp_comment_vo", "highest", 10, 0, 0, 1 );
            }
        }
        else
        {
            thread scripts\cp\utility::playsoundatpos_safe( self.origin, alias );
        }
        
        wait scripts\cp\cp_vo::get_sound_length( alias );
        level.isteamvoplaying = 0;
        return;
    }
    
    delay_before = 45;
    
    if ( isdefined( var_e2ce4e21e9100cb9 ) )
    {
        delay_before = var_e2ce4e21e9100cb9;
    }
    
    delay_between = 60;
    
    if ( isdefined( nag_cooldown ) )
    {
        delay_between = nag_cooldown;
    }
    
    foreach ( player in players )
    {
        player thread scripts\cp\cp_vo::add_to_nag_vo( alias, "cp_comment_vo", delay_between, delay_before, 6, 1 );
    }
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 5
// Checksum 0x0, Offset: 0x17ec
// Size: 0x9d
function try_to_play_vo_for_one_player( alias, player, is_nag, nag_cooldown, var_e2ce4e21e9100cb9 )
{
    if ( !isdefined( alias ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !istrue( is_nag ) )
    {
        player thread try_to_play_vo( alias, "cp_comment_vo", "highest", 10, 0, 0, 1, 100 );
        return;
    }
    
    delay_before = 45;
    
    if ( isdefined( var_e2ce4e21e9100cb9 ) )
    {
        delay_before = var_e2ce4e21e9100cb9;
    }
    
    delay_between = 60;
    
    if ( isdefined( nag_cooldown ) )
    {
        delay_between = nag_cooldown;
    }
    
    player thread scripts\cp\cp_vo::add_to_nag_vo( alias, "cp_comment_vo", delay_between, delay_before, 6, 1 );
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 2
// Checksum 0x0, Offset: 0x1891
// Size: 0xee
function try_to_play_vo_on_all_players( alias, is_nag )
{
    if ( !isdefined( alias ) )
    {
        return;
    }
    
    if ( !isdefined( level.players ) )
    {
        return;
    }
    
    if ( !istrue( is_nag ) )
    {
        foreach ( player in level.players )
        {
            player thread try_to_play_vo( alias, "zmb_comment_vo", "highest", 10, 0, 0, 1, 100 );
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        player thread scripts\cp\cp_vo::add_to_nag_vo( alias, "zmb_comment_vo", 60, 45, 6, 1 );
    }
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 8
// Checksum 0x0, Offset: 0x1987
// Size: 0x24b
function try_to_play_vo( alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local, chance_to_play )
{
    var_c95bef4257b44781 = isdefined( level.vo_alias_data[ alias_string ] );
    aliasdata = ter_op( var_c95bef4257b44781, level.vo_alias_data[ alias_string ], undefined );
    
    if ( !isdefined( chance_to_play ) )
    {
        if ( var_c95bef4257b44781 )
        {
            if ( isdefined( aliasdata.chance_to_play ) )
            {
                chance_to_play = aliasdata.chance_to_play;
            }
        }
        else
        {
            chance_to_play = 100;
        }
    }
    
    /#
        if ( getdvarint( @"hash_2074ff36773f5d85", 0 ) != 0 )
        {
            chance_to_play = 100;
        }
    #/
    
    if ( randomint( 100 ) > chance_to_play )
    {
        return;
    }
    
    if ( should_play_vo( alias_string ) )
    {
        /#
            if ( getdvarint( @"hash_1ff01a5d033f1ce0", 0 ) != 0 && istrue( interrupt ) )
            {
                iprintln( "<dev string:x80>" + alias_string );
            }
        #/
        
        if ( !isdefined( pause_time ) && var_c95bef4257b44781 && isdefined( aliasdata.pause_time ) )
        {
            pause_time = aliasdata.pause_time;
        }
        
        if ( !isdefined( only_local ) && var_c95bef4257b44781 && isdefined( aliasdata.only_local ) )
        {
            only_local = aliasdata.onlylocal;
        }
        
        if ( !isdefined( timeout ) && var_c95bef4257b44781 && isdefined( aliasdata.timeout ) )
        {
            timeout = aliasdata.timeout;
        }
        
        if ( !isdefined( priority ) && var_c95bef4257b44781 && isdefined( aliasdata.priority ) )
        {
            priority = aliasdata.priority;
        }
        
        categories = get_categories_from_alias( alias_string );
        
        foreach ( category in categories )
        {
            level.vo_category_last_played_time[ category ] = gettime();
        }
        
        if ( var_c95bef4257b44781 && isdefined( aliasdata.lastplayedtime ) )
        {
            aliasdata.lastplayedtime = gettime();
        }
        
        thread add_to_vo_queue( alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local );
    }
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0x1bda
// Size: 0x244
function should_play_vo( alias_string )
{
    /#
        if ( getdvarint( @"hash_2074ff36773f5d85", 0 ) != 0 )
        {
            return 1;
        }
    #/
    
    if ( !isdefined( level.vo_alias_data[ alias_string ] ) )
    {
        return 1;
    }
    
    time = gettime();
    
    if ( isdefined( level.vo_alias_data[ alias_string ].cooldown ) && isdefined( level.vo_alias_data[ alias_string ].lastplayedtime ) )
    {
        if ( time < level.vo_alias_data[ alias_string ].lastplayedtime + level.vo_alias_data[ alias_string ].cooldown * 1000 )
        {
            println( "<dev string:x9a>" + alias_string + "<dev string:xaa>" );
            return 0;
        }
    }
    
    categories = get_categories_from_alias( alias_string );
    
    foreach ( category in categories )
    {
        cooldown = ter_op( isdefined( level.vo_alias_data[ alias_string ].cooldown ), level.vo_alias_data[ alias_string ].cooldown, 30 );
        
        if ( time < level.vo_category_last_played_time[ category ] + cooldown * 1000 )
        {
            println( "<dev string:xbc>" + category + "<dev string:xcf>" + alias_string + "<dev string:xe0>" );
            return 0;
        }
    }
    
    if ( isdefined( level.vo_alias_data[ alias_string ].max_plays ) )
    {
        if ( !isdefined( self.num_of_plays ) )
        {
            self.num_of_plays = [];
        }
        
        if ( !isdefined( self.num_of_plays[ alias_string ] ) )
        {
            self.num_of_plays[ alias_string ] = 0;
        }
        
        if ( self.num_of_plays[ alias_string ] < level.vo_alias_data[ alias_string ].max_plays )
        {
            return 1;
        }
        else
        {
            println( "<dev string:xf3>" + alias_string + "<dev string:xfa>" + self.num_of_plays[ alias_string ] + "<dev string:x12d>" );
            return 0;
        }
        
        return;
    }
    
    return 1;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0x1e26
// Size: 0x9c
function get_categories_from_alias( alias_string )
{
    if ( !isdefined( level.vo_categories ) )
    {
        return [];
    }
    
    keys = getarraykeys( level.vo_categories );
    temp_array = [];
    
    foreach ( key in keys )
    {
        if ( array_contains( level.vo_categories[ key ], alias_string ) )
        {
            temp_array[ temp_array.size ] = key;
        }
    }
    
    return temp_array;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 7
// Checksum 0x0, Offset: 0x1ecb
// Size: 0x183
function play_cp_comment_vo( alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local )
{
    level endon( "game_ended" );
    level.announcer_vo_playing = 1;
    player_array = level.players;
    
    if ( isplayer( self ) )
    {
        player_array = [ self ];
    }
    
    foreach ( player in player_array )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
        {
            continue;
        }
        
        /#
            println( "<dev string:x132>" + alias_string + "<dev string:x155>" );
            
            if ( getdvarint( @"hash_1ff01a5d033f1ce0" ) == 1 )
            {
                iprintlnbold( "<dev string:x159>" + alias_string );
            }
        #/
        
        vo_to_play = scripts\cp\cp_vo::create_vo_data( alias_string, timeout, pause_time, only_local );
        player thread scripts\cp\cp_vo::play_vo_system( vo_to_play );
    }
    
    wait scripts\cp\cp_vo::get_sound_length( alias_string );
    
    foreach ( player in player_array )
    {
        player set_vo_system_playing( 0 );
    }
    
    level.announcer_vo_playing = 0;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 7
// Checksum 0x0, Offset: 0x2056
// Size: 0xed
function add_to_vo_queue( alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local )
{
    if ( isdefined( vo_type ) && isdefined( level.vo_functions[ vo_type ] ) )
    {
        self thread [[ level.vo_functions[ vo_type ] ]]( alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local );
        return;
    }
    
    if ( isdefined( vo_type ) && vo_type == "cp_comment_vo" )
    {
        play_cp_comment_vo( alias_string, vo_type, priority, timeout, interrupt, pause_time, only_local );
        return;
    }
    
    if ( isplayer( self ) )
    {
        if ( isdefined( self.vo_prefix ) )
        {
            alias = self.vo_prefix + alias_string;
        }
        else
        {
            return;
        }
        
        thread play_vo_on_player( alias, priority, timeout, interrupt, pause_time, only_local, alias_string );
        return;
    }
    
    alias = alias_string;
    level thread play_vo_on_all_players( alias, priority, timeout, interrupt, pause_time, only_local, alias_string );
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 7
// Checksum 0x0, Offset: 0x214b
// Size: 0xbc
function play_vo_on_all_players( alias, priority, timeout, interrupt, pause_time, only_local, basealias )
{
    /#
        if ( getdvarint( @"hash_1ff01a5d033f1ce0" ) == 1 )
        {
            iprintlnbold( "<dev string:x159>" + alias );
        }
    #/
    
    foreach ( player in level.players )
    {
        player add_to_vo_system( alias, priority, timeout, interrupt, pause_time, only_local, basealias );
    }
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 7
// Checksum 0x0, Offset: 0x220f
// Size: 0x6f
function play_vo_on_player( alias, priority, timeout, interrupt, pause_time, only_local, basealias )
{
    /#
        if ( getdvarint( @"hash_1ff01a5d033f1ce0" ) == 1 )
        {
            iprintlnbold( "<dev string:x159>" + alias );
        }
    #/
    
    add_to_vo_system( alias, priority, timeout, interrupt, pause_time, only_local, basealias );
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 7
// Checksum 0x0, Offset: 0x2286
// Size: 0x62
function add_to_vo_system( alias, priority, timeout, interrupt, pause_time, only_local, basealias )
{
    if ( !isdefined( self.current_vo_queue ) )
    {
        self.current_vo_queue = [];
    }
    
    thread add_to_vo_system_internal( alias, priority, timeout, interrupt, pause_time, only_local, basealias );
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 7
// Checksum 0x0, Offset: 0x22f0
// Size: 0xb2
function add_to_vo_system_internal( alias, priority, timeout, interrupt, pause_time, only_local, basealias )
{
    priority = get_validated_priority( priority );
    println( "<dev string:x174>" + alias + "<dev string:x195>" );
    vo_data = create_vo_data( alias, timeout, pause_time, only_local, basealias );
    
    if ( should_interrupt_vo_system( interrupt ) )
    {
        add_to_interrupt_vo( vo_data );
        
        if ( is_vo_system_playing() )
        {
            interrupt_current_vo();
        }
    }
    else
    {
        add_to_queue_at_priority( vo_data, priority );
    }
    
    if ( !is_vo_system_playing() )
    {
        notify_system_to_grab_next_vo_from_queue();
    }
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0x23aa
// Size: 0x4f
function get_validated_priority( priority )
{
    if ( !isdefined( priority ) )
    {
        return level.vo_priority_level[ level.vo_priority_level.size - 1 ];
    }
    
    assertex( scripts\engine\utility::array_contains( level.vo_priority_level, priority ), "'" + priority + "' is not a valid priority level." );
    return priority;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 5
// Checksum 0x0, Offset: 0x2402
// Size: 0xf7
function create_vo_data( alias, timeout, pause_time, only_local, basealias )
{
    default_timeout = 999;
    var_356385d16d2bfe7a = 1.5;
    var_2909ac11ec70c778 = 3;
    vo_data = spawnstruct();
    vo_data.alias = alias;
    vo_data.categories = get_categories_from_alias( alias );
    vo_data.basealias = basealias;
    
    if ( !isdefined( timeout ) )
    {
        timeout = default_timeout;
    }
    
    vo_data.expire_time = gettime() + timeout * 1000;
    
    if ( !isdefined( pause_time ) )
    {
        pause_time = randomfloatrange( var_356385d16d2bfe7a, var_2909ac11ec70c778 );
    }
    
    vo_data.pause_time = pause_time;
    
    if ( istrue( only_local ) )
    {
        vo_data.only_local = 1;
    }
    else
    {
        vo_data.only_local = 0;
    }
    
    return vo_data;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0x2502
// Size: 0x12, Type: bool
function should_interrupt_vo_system( interrupt )
{
    return isdefined( interrupt ) && interrupt;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0x251d
// Size: 0x20
function add_to_interrupt_vo( vo_data )
{
    self.vo_system.interrupt_vo = vo_data;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x2545
// Size: 0x16, Type: bool
function is_vo_system_playing()
{
    return istrue( self.vo_system.is_playing );
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x2564
// Size: 0x28
function interrupt_current_vo()
{
    current_vo_alias = get_current_vo_alias();
    
    if ( isdefined( current_vo_alias ) )
    {
        self stoplocalsound( current_vo_alias );
    }
    
    self notify( "interrupt_current_VO" );
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x2594
// Size: 0x66
function get_current_vo_alias()
{
    if ( isdefined( self.vo_system ) )
    {
        if ( isdefined( self.vo_system.vo_currently_playing ) )
        {
            if ( isdefined( self.vo_system.vo_currently_playing.alias ) )
            {
                return self.vo_system.vo_currently_playing.alias;
            }
        }
    }
    
    return undefined;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 2
// Checksum 0x0, Offset: 0x2603
// Size: 0x41
function add_to_queue_at_priority( vo_data, priority )
{
    self.vo_system.vo_queue[ priority ][ self.vo_system.vo_queue[ priority ].size ] = vo_data;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x264c
// Size: 0xa
function notify_system_to_grab_next_vo_from_queue()
{
    self notify( "play_VO_system" );
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 2
// Checksum 0x0, Offset: 0x265e
// Size: 0xe2
function remove_vo_data( alias_substring, priority )
{
    new_array = [];
    
    foreach ( vo_data in self.vo_system.vo_queue[ priority ] )
    {
        if ( !( vo_data.alias == self.vo_prefix + alias_substring || vo_data.alias == self.vo_prefix + "plr_" + alias_substring ) )
        {
            new_array[ new_array.size ] = self.vo_system.vo_queue[ priority ][ array_index ];
        }
    }
    
    self.vo_system.vo_queue[ priority ] = new_array;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0x2748
// Size: 0x75
function pause_vo_system( player_list )
{
    if ( player_list.size == 1 )
    {
        player_list[ 0 ].pause_vo_system = 1;
        return;
    }
    
    foreach ( player in player_list )
    {
        player.pause_vo_system = 1;
    }
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0x27c5
// Size: 0x99
function unpause_vo_system( player_list )
{
    foreach ( player in player_list )
    {
        player.pause_vo_system = 0;
    }
    
    foreach ( player in player_list )
    {
        player notify( "unpause_VO_system" );
    }
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 0
// Checksum 0x0, Offset: 0x2866
// Size: 0x1a8
function nag_vo_handler()
{
    level endon( "game_ended" );
    
    if ( !isdefined( level.nag_vo ) )
    {
        level.nag_vo = [];
        level.nag_vo_never_play_again = [];
        level.pause_nag_vo = 0;
    }
    
    nag_cooldown = 60;
    
    while ( true )
    {
        while ( level.pause_nag_vo )
        {
            wait 0.1;
        }
        
        time = gettime();
        
        foreach ( alias, nag_struct in level.nag_vo )
        {
            if ( time > nag_struct.next_play_time )
            {
                if ( isdefined( nag_struct.scope ) )
                {
                    nag_struct.scope try_to_play_vo( alias, nag_struct.vo_type, "low", 3, 0, 0, nag_struct.only_local );
                }
                else
                {
                    level try_to_play_vo( alias, nag_struct.vo_type, "low", 3, 0, 0, nag_struct.only_local );
                }
                
                nag_struct.times_played++;
                
                if ( nag_struct.max_times != -1 && nag_struct.max_times <= nag_struct.times_played )
                {
                    remove_from_nag_vo( alias );
                }
                
                nag_struct.next_play_time = time + nag_struct.cooldown * min( nag_struct.times_played, 3 ) * 1000;
                wait nag_cooldown;
            }
        }
        
        wait 1;
    }
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 6
// Checksum 0x0, Offset: 0x2a16
// Size: 0x177
function add_to_nag_vo( alias, vo_type, cooldown_time, var_1e486b6da797b22, max_times, only_local )
{
    if ( !isdefined( level.nag_vo ) )
    {
        level.nag_vo = [];
        level.nag_vo_never_play_again = [];
        level.pause_nag_vo = 0;
    }
    
    if ( isdefined( level.nag_vo[ alias ] ) )
    {
        return;
    }
    
    if ( isdefined( level.nag_vo_never_play_again[ alias ] ) )
    {
        return;
    }
    
    if ( !isdefined( cooldown_time ) )
    {
        cooldown_time = 60;
    }
    
    if ( !isdefined( vo_type ) )
    {
        vo_type = "zmb_comment_vo";
    }
    
    vo_scope = undefined;
    
    if ( isplayer( self ) )
    {
        vo_scope = self;
    }
    
    var_a68342c9c3067ef7 = spawnstruct();
    var_a68342c9c3067ef7.times_played = 0;
    var_a68342c9c3067ef7.cooldown = cooldown_time;
    var_a68342c9c3067ef7.vo_type = vo_type;
    
    if ( isdefined( vo_scope ) )
    {
        var_a68342c9c3067ef7.scope = vo_scope;
    }
    
    if ( isdefined( only_local ) )
    {
        var_a68342c9c3067ef7.only_local = only_local;
    }
    else
    {
        var_a68342c9c3067ef7.only_local = 0;
    }
    
    if ( isdefined( var_1e486b6da797b22 ) )
    {
        var_a68342c9c3067ef7.next_play_time = gettime() + var_1e486b6da797b22 * 1000;
    }
    else
    {
        var_a68342c9c3067ef7.next_play_time = 0;
    }
    
    if ( isdefined( max_times ) )
    {
        var_a68342c9c3067ef7.max_times = max_times;
    }
    else
    {
        var_a68342c9c3067ef7.max_times = -1;
    }
    
    level.nag_vo[ alias ] = var_a68342c9c3067ef7;
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 2
// Checksum 0x0, Offset: 0x2b95
// Size: 0x41
function remove_from_nag_vo( alias, never_again )
{
    level.nag_vo = array_remove_index( level.nag_vo, alias, 1 );
    
    if ( istrue( never_again ) )
    {
        level.nag_vo_never_play_again[ alias ] = 1;
    }
}

// Namespace cp_vo / scripts\cp\cp_vo
// Params 1
// Checksum 0x0, Offset: 0x2bde
// Size: 0x34
function get_length_from_table( alias )
{
    len = tablelookup( "cp/cp_vo_lookup.csv", 0, alias, 1 );
    
    if ( isdefined( len ) )
    {
        len = float( len );
        return len;
    }
    
    return undefined;
}

