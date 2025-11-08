#using scripts\anim\face;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;

#namespace notetrack;

// Namespace notetrack / scripts\common\notetrack
// Params 0
// Checksum 0x0, Offset: 0x2b0
// Size: 0xb
function function_11f8c6d6f5ba948()
{
    level thread function_9ce792d127499205();
}

// Namespace notetrack / scripts\common\notetrack
// Params 2
// Checksum 0x0, Offset: 0x2c3
// Size: 0x94
function agent_notetrack_redirect( guy, msg )
{
    guy endon( "stop_sequencing_notetracks" );
    guy endon( "death" );
    guy endon( "stop_agent_notetrack_redirect" );
    
    while ( true )
    {
        self waittill( "animscripted", notetracks );
        self notify( msg, notetracks );
        
        foreach ( note in notetracks )
        {
            if ( note == "end" )
            {
                return;
            }
        }
    }
}

// Namespace notetrack / scripts\common\notetrack
// Params 6
// Checksum 0x0, Offset: 0x35f
// Size: 0x4a
function start_notetrack_wait( guy, anim_string, anime, animname, animation, var_173bdb8ba434651d )
{
    guy notify( "stop_sequencing_notetracks" );
    thread notetrack_wait( guy, anim_string, self, anime, animname, animation, var_173bdb8ba434651d );
}

// Namespace notetrack / scripts\common\notetrack
// Params 7
// Checksum 0x0, Offset: 0x3b1
// Size: 0x39d
function notetrack_wait( guy, msg, tag_entity, anime, animname_override, animation, var_173bdb8ba434651d )
{
    guy endon( "stop_sequencing_notetracks" );
    guy endon( "death" );
    
    if ( istrue( var_173bdb8ba434651d ) )
    {
        thread agent_notetrack_redirect( guy, msg );
    }
    
    if ( isdefined( tag_entity ) )
    {
        tag_owner = tag_entity;
    }
    else
    {
        tag_owner = self;
    }
    
    animname = undefined;
    
    if ( isdefined( animname_override ) )
    {
        animname = animname_override;
    }
    else
    {
        animname = guy.animname;
    }
    
    dialogue_array = spawnstruct();
    dialogue_array.dialog = [];
    scripted_notetracks = [];
    
    if ( isdefined( animname ) && isdefined( level.scr_notetrack[ animname ] ) && isdefined( anime ) )
    {
        if ( isdefined( level.scr_notetrack[ animname ][ anime ] ) )
        {
            scripted_notetracks[ anime ] = level.scr_notetrack[ animname ][ anime ];
        }
        
        if ( isdefined( level.scr_notetrack[ animname ][ "any" ] ) )
        {
            scripted_notetracks[ "any" ] = level.scr_notetrack[ animname ][ "any" ];
        }
    }
    
    foreach ( _ in scripted_notetracks )
    {
        foreach ( notetrack_array in level.scr_notetrack[ animname ][ anime_key ] )
        {
            foreach ( scr_notetrack in notetrack_array )
            {
                if ( isdefined( scr_notetrack[ "dialog" ] ) )
                {
                    dialogue_array.dialog[ scr_notetrack[ "dialog" ] ] = 1;
                }
            }
        }
    }
    
    var_1247cd0fbe324a41 = 0;
    var_a5fb509f15a76960 = 0;
    
    while ( true )
    {
        dialogue_array.dialoguenotetrack = 0;
        notetrack = undefined;
        
        if ( !var_1247cd0fbe324a41 && isdefined( animname ) && isdefined( anime ) )
        {
            var_1247cd0fbe324a41 = 1;
            start_notetrack = undefined;
            var_a5fb509f15a76960 = isdefined( level.scr_notetrack[ animname ] ) && isdefined( level.scr_notetrack[ animname ][ anime ] ) && isdefined( level.scr_notetrack[ animname ][ anime ][ "start" ] );
            
            if ( !var_a5fb509f15a76960 )
            {
                continue;
            }
            
            notetracks = [ "start" ];
        }
        else
        {
            guy waittill( msg, notetracks );
        }
        
        if ( !isarray( notetracks ) )
        {
            notetracks = [ notetracks ];
        }
        
        guy printnotetracks( notetracks );
        validatenotetracks( msg, notetracks, animation );
        end = undefined;
        
        foreach ( note in notetracks )
        {
            notetrack_handler( guy, anime, note, animname, scripted_notetracks, tag_owner, dialogue_array );
            
            if ( note == "end" )
            {
                end = 1;
            }
        }
        
        if ( isdefined( end ) )
        {
            break;
        }
    }
    
    if ( istrue( var_173bdb8ba434651d ) )
    {
        guy notify( "stop_agent_notetrack_redirect" );
    }
}

// Namespace notetrack / scripts\common\notetrack
// Params 0
// Checksum 0x0, Offset: 0x756
// Size: 0xa
function function_e2bc0c9e826cf659()
{
    thread function_392d5e426b4896d2();
}

// Namespace notetrack / scripts\common\notetrack
// Params 0
// Checksum 0x0, Offset: 0x768
// Size: 0xae
function function_392d5e426b4896d2()
{
    self endon( "entitydeleted" );
    noteflag = "scriptable";
    
    while ( true )
    {
        self waittill( noteflag, notetracks );
        printnotetracks( notetracks );
        validatenotetracks( noteflag, notetracks );
        end = undefined;
        
        foreach ( note in notetracks )
        {
            notetrack_handler( self, undefined, note );
            
            if ( note == "end" )
            {
                end = 1;
            }
        }
        
        if ( isdefined( end ) )
        {
            break;
        }
    }
}

// Namespace notetrack / scripts\common\notetrack
// Params 7
// Checksum 0x0, Offset: 0x81e
// Size: 0x18c
function notetrack_handler( guy, anime, notetrack, animname, scripted_notetracks, tag_owner, dialogue_array )
{
    /#
        if ( getdvar( @"animsound" ) == "<dev string:x1c>" )
        {
            guy thread animsound_tracker( anime, notetrack, animname );
        }
    #/
    
    if ( notetrack == "end" )
    {
        if ( isdefined( anim.callbacks[ "EntityHandleNotetrackAnimEnd" ] ) )
        {
            [[ anim.callbacks[ "EntityHandleNotetrackAnimEnd" ] ]]( guy, notetrack );
        }
        
        return 1;
    }
    
    if ( isdefined( scripted_notetracks ) )
    {
        foreach ( anime_key, _ in scripted_notetracks )
        {
            if ( isdefined( level.scr_notetrack[ animname ][ anime_key ][ notetrack ] ) )
            {
                foreach ( scr_notetrack in level.scr_notetrack[ animname ][ anime_key ][ notetrack ] )
                {
                    [[ anim.callbacks[ "AnimHandleNotetrack" ] ]]( scr_notetrack, guy, dialogue_array, tag_owner );
                }
            }
        }
    }
    
    if ( isdefined( anim.callbacks[ "EntityHandleNotetrack" ] ) )
    {
        [[ anim.callbacks[ "EntityHandleNotetrack" ] ]]( guy, notetrack );
    }
}

// Namespace notetrack / scripts\common\notetrack
// Params 4
// Checksum 0x0, Offset: 0x9b2
// Size: 0x2ec
function anim_handle_notetrack( scr_notetrack, guy, dialogue_array, tag_owner )
{
    if ( isdefined( scr_notetrack[ "function" ] ) )
    {
        self thread [[ scr_notetrack[ "function" ] ]]( guy );
    }
    
    if ( isdefined( scr_notetrack[ "notify" ] ) )
    {
        level notify( scr_notetrack[ "notify" ] );
    }
    
    if ( isdefined( scr_notetrack[ "attach model" ] ) )
    {
        if ( isdefined( scr_notetrack[ "selftag" ] ) )
        {
            guy attach( scr_notetrack[ "attach model" ], scr_notetrack[ "selftag" ] );
            return;
        }
        
        tag_owner attach( scr_notetrack[ "attach model" ], scr_notetrack[ "tag" ] );
        return;
    }
    
    if ( isdefined( scr_notetrack[ "detach model" ] ) )
    {
        if ( isdefined( scr_notetrack[ "selftag" ] ) )
        {
            guy detach( scr_notetrack[ "detach model" ], scr_notetrack[ "selftag" ] );
        }
        else
        {
            tag_owner detach( scr_notetrack[ "detach model" ], scr_notetrack[ "tag" ] );
        }
    }
    
    if ( !dialogue_array.dialoguenotetrack )
    {
        if ( isdefined( scr_notetrack[ "dialog" ] ) && isdefined( dialogue_array.dialog[ scr_notetrack[ "dialog" ] ] ) )
        {
            guy sayspecificdialogue( scr_notetrack[ "dialog" ] );
            dialogue_array.dialog[ scr_notetrack[ "dialog" ] ] = undefined;
            dialogue_array.dialoguenotetrack = 1;
        }
    }
    
    if ( isdefined( scr_notetrack[ "create model" ] ) )
    {
        anim_addmodel( guy, scr_notetrack );
    }
    else if ( isdefined( scr_notetrack[ "delete model" ] ) )
    {
        anim_removemodel( guy, scr_notetrack );
    }
    
    if ( isdefined( scr_notetrack[ "selftag" ] ) )
    {
        if ( isdefined( scr_notetrack[ "effect" ] ) )
        {
            level thread notetrack_effect( guy, scr_notetrack );
        }
        
        if ( isdefined( scr_notetrack[ "stop_effect" ] ) )
        {
            stopfxontag( level._effect[ scr_notetrack[ "stop_effect" ] ], guy, scr_notetrack[ "selftag" ] );
        }
        
        if ( isdefined( scr_notetrack[ "swap_part_to_efx" ] ) )
        {
            playfxontag( level._effect[ scr_notetrack[ "swap_part_to_efx" ] ], guy, scr_notetrack[ "selftag" ] );
            guy hidepart( scr_notetrack[ "selftag" ] );
        }
        
        if ( isdefined( scr_notetrack[ "trace_part_for_efx" ] ) )
        {
            water_effect = undefined;
            effect = getfx( scr_notetrack[ "trace_part_for_efx" ] );
            
            if ( isdefined( scr_notetrack[ "trace_part_for_efx_water" ] ) )
            {
                water_effect = getfx( scr_notetrack[ "trace_part_for_efx_water" ] );
            }
            
            deletedepth = 0;
            
            if ( isdefined( scr_notetrack[ "trace_part_for_efx_delete_depth" ] ) )
            {
                deletedepth = scr_notetrack[ "trace_part_for_efx_delete_depth" ];
            }
            
            guy thread trace_part_for_efx( scr_notetrack[ "selftag" ], effect, water_effect, deletedepth );
        }
        
        if ( isdefined( scr_notetrack[ "trace_part_for_efx_canceling" ] ) )
        {
            guy thread trace_part_for_efx_cancel( scr_notetrack[ "selftag" ] );
        }
    }
    
    if ( isdefined( scr_notetrack[ "tag" ] ) && isdefined( scr_notetrack[ "effect" ] ) )
    {
        playfxontag( level._effect[ scr_notetrack[ "effect" ] ], tag_owner, scr_notetrack[ "tag" ] );
    }
    
    if ( isdefined( scr_notetrack[ "selftag" ] ) && isdefined( scr_notetrack[ "effect_looped" ] ) )
    {
        playfxontag( level._effect[ scr_notetrack[ "effect_looped" ] ], guy, scr_notetrack[ "selftag" ] );
    }
}

// Namespace notetrack / scripts\common\notetrack
// Params 2
// Checksum 0x0, Offset: 0xca6
// Size: 0xcf
function anim_addmodel( guy, array )
{
    if ( !isdefined( guy.scriptmodel ) )
    {
        guy.scriptmodel = [];
    }
    
    index = guy.scriptmodel.size;
    guy.scriptmodel[ index ] = spawn( "script_model", ( 0, 0, 0 ) );
    guy.scriptmodel[ index ] setmodel( array[ "create model" ] );
    guy.scriptmodel[ index ].origin = guy gettagorigin( array[ "selftag" ] );
    guy.scriptmodel[ index ].angles = guy gettagangles( array[ "selftag" ] );
}

// Namespace notetrack / scripts\common\notetrack
// Params 2
// Checksum 0x0, Offset: 0xd7d
// Size: 0x11b
function anim_removemodel( guy, array )
{
    /#
        if ( !isdefined( guy.scriptmodel ) )
        {
            assertmsg( "<dev string:x1f>" + guy.animname );
        }
    #/
    
    for ( i = 0; i < guy.scriptmodel.size ; i++ )
    {
        if ( isdefined( array[ "explosion" ] ) )
        {
            forward = anglestoforward( guy.scriptmodel[ i ].angles );
            forward *= 120;
            forward += guy.scriptmodel[ i ].origin;
            playfx( level._effect[ array[ "explosion" ] ], guy.scriptmodel[ i ].origin );
            radiusdamage( guy.scriptmodel[ i ].origin, 350, 700, 50 );
        }
        
        guy.scriptmodel[ i ] delete();
    }
}

// Namespace notetrack / scripts\common\notetrack
// Params 2
// Checksum 0x0, Offset: 0xea0
// Size: 0x65
function notetrack_effect( guy, scr_notetrack )
{
    var_863c90262c71c1b7 = isdefined( scr_notetrack[ "moreThanThreeHack" ] );
    
    if ( var_863c90262c71c1b7 )
    {
        lock( "moreThanThreeHack" );
    }
    
    playfxontag( level._effect[ scr_notetrack[ "effect" ] ], guy, scr_notetrack[ "selftag" ] );
    
    if ( var_863c90262c71c1b7 )
    {
        unlock( "moreThanThreeHack" );
    }
}

// Namespace notetrack / scripts\common\notetrack
// Params 1
// Checksum 0x0, Offset: 0xf0d
// Size: 0x15
function trace_part_for_efx_cancel( part )
{
    self notify( "cancel_trace_for_part_" + part );
}

// Namespace notetrack / scripts\common\notetrack
// Params 4
// Checksum 0x0, Offset: 0xf2a
// Size: 0x18a
function trace_part_for_efx( part, effect, water_effect, delete_depth )
{
    lock_string = "trace_part_for_efx";
    self endon( "cancel_trace_for_part_" + part );
    last_pos = self gettagorigin( part );
    hit_water = 0;
    struct = spawnstruct();
    struct.last_pos = self gettagorigin( part );
    struct.hit_surface = 0;
    struct.part = part;
    struct.hit_water = 0;
    struct.effect = effect;
    struct.stationary = 0;
    struct.last_motion_time = gettime();
    
    while ( isdefined( self ) && !struct.hit_surface )
    {
        lock( lock_string );
        test_trace_tag( struct );
        unlock_wait( lock_string );
        
        if ( struct.stationary == 1 && gettime() - struct.last_motion_time > 3000 )
        {
            return;
        }
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( water_effect ) && struct.hit_water )
    {
        effect = water_effect;
    }
    
    playfx( effect, struct.last_pos );
    
    if ( delete_depth == 0 )
    {
        self hidepart( part );
        return;
    }
    
    thread hidepartatdepth( struct.last_pos[ 2 ] - delete_depth, part );
}

// Namespace notetrack / scripts\common\notetrack
// Params 2
// Checksum 0x0, Offset: 0x10bc
// Size: 0x3a
function hidepartatdepth( depth, part )
{
    self endon( "entitydeleted" );
    
    while ( self gettagorigin( part )[ 2 ] > depth )
    {
        wait 0.05;
    }
    
    self hidepart( part );
}

// Namespace notetrack / scripts\common\notetrack
// Params 1
// Checksum 0x0, Offset: 0x10fe
// Size: 0x382
function test_trace_tag( struct )
{
    linecolor = undefined;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    struct.current_pos = self gettagorigin( struct.part );
    
    if ( struct.current_pos != struct.last_pos )
    {
        struct.last_motion_time = gettime();
        struct.stationary = 0;
        
        /#
            linecolor = ( 1, 1, 1 );
        #/
        
        if ( !scripts\engine\trace::_bullet_trace_passed( struct.last_pos, struct.current_pos, 0, self ) )
        {
            trace = scripts\engine\trace::_bullet_trace( struct.last_pos, struct.current_pos, 0, self );
            
            if ( trace[ "fraction" ] < 1 )
            {
                /#
                    linecolor = ( 1, 0, 0 );
                #/
                
                struct.last_pos = trace[ "position" ];
                struct.hit_water = trace[ "surfacetype" ] == "water";
                
                /#
                    if ( getdvarint( @"hash_b46df2b57cc019b" ) == 1 )
                    {
                        stringname = "<dev string:x6f>";
                        
                        foreach ( value in level._effect )
                        {
                            if ( struct.effect != value )
                            {
                                continue;
                            }
                            
                            stringname = key;
                            break;
                        }
                        
                        print3d( _add_z( struct.last_pos, 6 ), "<dev string:x70>" + struct.part, ( 1, 1, 1 ), 1, 1, 100 );
                        print3d( struct.last_pos, "<dev string:x76>" + stringname, ( 1, 1, 1 ), 1, 1, 100 );
                    }
                #/
                
                struct.hit_surface = 1;
                return;
            }
            else
            {
                /#
                    if ( getdvarint( @"hash_b46df2b57cc019b" ) == 1 )
                    {
                        if ( isdefined( trace[ "<dev string:x7f>" ] ) )
                        {
                            print3d( _add_z( struct.last_pos, 6 ), "<dev string:x86>" + trace[ "<dev string:x7f>" ].classname, ( 0, 0, 1 ), 1, 1, 100 );
                        }
                    }
                #/
            }
        }
        
        /#
            if ( getdvarint( @"hash_b46df2b57cc019b" ) == 1 )
            {
                line( struct.last_pos, struct.current_pos, linecolor, 1, 0, 60 );
                sphere( struct.current_pos, 8, ( 0, 1, 0 ) );
                print3d( _add_z( struct.last_pos, 6 ), struct.part, ( 0, 1, 0 ), 1, 1, 1 );
            }
        #/
    }
    else
    {
        struct.stationary = 1;
        
        /#
            if ( getdvarint( @"hash_b46df2b57cc019b" ) == 1 )
            {
                print3d( struct.current_pos, "<dev string:x8f>" + struct.part, ( 1, 0, 0 ) );
            }
        #/
    }
    
    struct.last_pos = struct.current_pos;
}

// Namespace notetrack / scripts\common\notetrack
// Params 2
// Checksum 0x0, Offset: 0x1488
// Size: 0x21
function _add_z( vec, zplus )
{
    return ( vec[ 0 ], vec[ 1 ], vec[ 2 ] + zplus );
}

// Namespace notetrack / scripts\common\notetrack
// Params 3
// Checksum 0x0, Offset: 0x14b2
// Size: 0x11f
function validatenotetracks( flagname, notes, animation )
{
    /#
        if ( isdefined( animation ) )
        {
            assertex( notes.size <= 4, "<dev string:x9e>" + notes.size + "<dev string:xb4>" + getxhashsourcename( getanimname( animation ) ) );
        }
        else
        {
            assertex( notes.size <= 4, "<dev string:x9e>" + notes.size + "<dev string:xfb>" + flagname + "<dev string:x14c>" );
        }
        
        for ( i = 0; i < notes.size ; i++ )
        {
            found = 0;
            
            for ( j = i + 1; j < notes.size ; j++ )
            {
                if ( notes[ i ] == notes[ j ] )
                {
                    found = 1;
                    
                    if ( isdefined( animation ) )
                    {
                        println( "<dev string:x14e>" + getxhashsourcename( getanimname( animation ) ) + "<dev string:x165>" + flagname + "<dev string:x177>" + notes[ i ] + "<dev string:x19a>" );
                    }
                    else
                    {
                        println( "<dev string:x19c>" + flagname + "<dev string:x177>" + notes[ i ] + "<dev string:x19a>" );
                    }
                }
                
                if ( found )
                {
                    break;
                }
            }
        }
        
        notes = undefined;
    #/
}

// Namespace notetrack / scripts\common\notetrack
// Params 1
// Checksum 0x0, Offset: 0x15d9
// Size: 0x97
function printnotetracks( notes )
{
    /#
        if ( getdvarint( @"hash_a19781010239d2e6" ) != 1 && getdvarint( @"hash_a19781010239d2e6" ) != self getentitynumber() )
        {
            return;
        }
        
        msg = notes[ 0 ];
        
        for ( i = 1; i < notes.size ; i++ )
        {
            msg += "<dev string:x1c1>" + notes[ i ];
        }
        
        println( "<dev string:x1c4>" + gettime() + "<dev string:x1c6>" + self getentitynumber() + "<dev string:x1c9>" + msg );
    #/
}

// Namespace notetrack / scripts\common\notetrack
// Params 2
// Checksum 0x0, Offset: 0x1678
// Size: 0x8a
function animsound_start_tracker( anime, animname )
{
    add_to_animsound();
    newsound = spawnstruct();
    newsound.anime = anime;
    newsound.notetrack = "#" + anime;
    newsound.animname = animname;
    newsound.end_time = gettime() + 60000;
    
    if ( animsound_exists( anime, newsound.notetrack ) )
    {
        return;
    }
    
    add_animsound( newsound );
}

// Namespace notetrack / scripts\common\notetrack
// Params 3
// Checksum 0x0, Offset: 0x170a
// Size: 0x97
function animsound_start_tracker_loop( anime, loop, animname )
{
    add_to_animsound();
    anime = loop + anime;
    newsound = spawnstruct();
    newsound.anime = anime;
    newsound.notetrack = "#" + anime;
    newsound.animname = animname;
    newsound.end_time = gettime() + 60000;
    
    if ( animsound_exists( anime, newsound.notetrack ) )
    {
        return;
    }
    
    add_animsound( newsound );
}

// Namespace notetrack / scripts\common\notetrack
// Params 3
// Checksum 0x0, Offset: 0x17a9
// Size: 0x95
function animsound_tracker( anime, notetrack, animname )
{
    notetrack = tolower( notetrack );
    add_to_animsound();
    
    if ( notetrack == "end" )
    {
        return;
    }
    
    if ( animsound_exists( anime, notetrack ) )
    {
        return;
    }
    
    newtrack = spawnstruct();
    newtrack.anime = anime;
    newtrack.notetrack = notetrack;
    newtrack.animname = animname;
    newtrack.end_time = gettime() + 60000;
    add_animsound( newtrack );
}

// Namespace notetrack / scripts\common\notetrack
// Params 2
// Checksum 0x0, Offset: 0x1846
// Size: 0xb8, Type: bool
function animsound_exists( anime, notetrack )
{
    notetrack = tolower( notetrack );
    keys = getarraykeys( self.animsounds );
    
    for ( i = 0; i < keys.size ; i++ )
    {
        key = keys[ i ];
        
        if ( self.animsounds[ key ].anime != anime )
        {
            continue;
        }
        
        if ( self.animsounds[ key ].notetrack != notetrack )
        {
            continue;
        }
        
        self.animsounds[ key ].end_time = gettime() + 60000;
        return true;
    }
    
    return false;
}

// Namespace notetrack / scripts\common\notetrack
// Params 1
// Checksum 0x0, Offset: 0x1907
// Size: 0xf2
function add_animsound( newsound )
{
    for ( i = 0; i < level.animsound_hudlimit ; i++ )
    {
        if ( isdefined( self.animsounds[ i ] ) )
        {
            continue;
        }
        
        self.animsounds[ i ] = newsound;
        return;
    }
    
    keys = getarraykeys( self.animsounds );
    index = keys[ 0 ];
    timer = self.animsounds[ index ].end_time;
    
    for ( i = 1; i < keys.size ; i++ )
    {
        key = keys[ i ];
        
        if ( self.animsounds[ key ].end_time < timer )
        {
            timer = self.animsounds[ key ].end_time;
            index = key;
        }
    }
    
    self.animsounds[ index ] = newsound;
}

// Namespace notetrack / scripts\common\notetrack
// Params 0
// Checksum 0x0, Offset: 0x1a01
// Size: 0x77
function add_to_animsound()
{
    if ( !isdefined( self.animsounds ) )
    {
        self.animsounds = [];
    }
    
    isinarray = 0;
    
    for ( i = 0; i < level.animsounds.size ; i++ )
    {
        if ( self == level.animsounds[ i ] )
        {
            isinarray = 1;
            break;
        }
    }
    
    if ( !isinarray )
    {
        level.animsounds[ level.animsounds.size ] = self;
    }
}

// Namespace notetrack / scripts\common\notetrack
// Params 0
// Checksum 0x0, Offset: 0x1a80
// Size: 0xa7
function function_9ce792d127499205()
{
    level endon( "game_ended" );
    
    while ( true )
    {
        vmnotetracks = [];
        self waittill( "vm_sv_note", vmnotetracks );
        
        if ( vmnotetracks.size > 0 )
        {
            foreach ( notetrackinfo in vmnotetracks )
            {
                if ( notetrackinfo.size > 0 )
                {
                    notetrackname = notetrackinfo[ 1 ];
                    notetrackfunc = anim.notetracks[ notetrackname ];
                    
                    if ( isdefined( notetrackfunc ) )
                    {
                        [[ notetrackfunc ]]( notetrackname, undefined, notetrackinfo );
                    }
                }
            }
        }
    }
}

